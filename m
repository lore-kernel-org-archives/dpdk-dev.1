Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91080D65C7C
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 17:21:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D80AA40648;
	Wed, 17 Dec 2025 18:21:10 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 78337402AC
 for <dev@dpdk.org>; Wed, 17 Dec 2025 18:21:09 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dWgYQ62h8zHnGkG;
 Thu, 18 Dec 2025 01:20:42 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 6EEA140086;
 Thu, 18 Dec 2025 01:21:08 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Dec 2025 18:21:08 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: <dev@dpdk.org>, Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH 1/2] bpf: add atomic xchg support
Date: Wed, 17 Dec 2025 17:20:35 +0000
Message-ID: <20251217172037.59170-2-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217172037.59170-1-marat.khalili@huawei.com>
References: <20251217172037.59170-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100007.china.huawei.com (7.182.19.38) To
 frapema500003.china.huawei.com (7.182.19.114)
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Add support for BPF atomic xchg instruction, and tests for it. This
instruction can be produced using compiler intrinsics.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_bpf.c     | 458 ++++++++++++++++++++++++++++++++++++++++
 lib/bpf/bpf_def.h       |   5 +
 lib/bpf/bpf_exec.c      |  35 ++-
 lib/bpf/bpf_jit_arm64.c |  59 ++++--
 lib/bpf/bpf_jit_x86.c   |  37 +++-
 lib/bpf/bpf_validate.c  |  22 +-
 6 files changed, 579 insertions(+), 37 deletions(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index b7c94ba1c7..a5e104349a 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -3970,3 +3970,461 @@ test_bpf_convert(void)
 #endif /* RTE_HAS_LIBPCAP */
 
 REGISTER_FAST_TEST(bpf_convert_autotest, true, true, test_bpf_convert);
+
+/*
+ * Tests of BPF atomic instructions.
+ */
+
+/* Value that should be returned by the xchg test programs. */
+#define XCHG_RETURN_VALUE 0xdeadbeefcafebabe
+
+/* Operand of XADD, should overflow both 32-bit and 64-bit parts of initial value. */
+#define XADD_OPERAND 0xc1c3c5c7c9cbcdcf
+
+/* Argument type of the xchg test program. */
+struct xchg_arg {
+	uint64_t value0;
+	uint64_t value1;
+};
+
+/* Initial value of the data area passed to the xchg test program. */
+static const struct xchg_arg xchg_input = {
+	.value0 = 0xa0a1a2a3a4a5a6a7,
+	.value1 = 0xb0b1b2b3b4b5b6b7,
+};
+
+/* JIT function type of the xchg test program. */
+typedef uint64_t (*xchg_program)(struct xchg_arg *argument);
+
+/* Run program against xchg_input and compare output value with expected. */
+static int
+run_xchg_test(uint32_t nb_ins, const struct ebpf_insn *ins, struct xchg_arg expected)
+{
+	const struct rte_bpf_prm prm = {
+		.ins = ins,
+		.nb_ins = nb_ins,
+		.prog_arg = {
+			.type = RTE_BPF_ARG_PTR,
+			.size = sizeof(struct xchg_arg),
+		},
+	};
+
+	for (int use_jit = false; use_jit <= true; ++use_jit) {
+		struct xchg_arg argument = xchg_input;
+		uint64_t return_value;
+
+		struct rte_bpf *const bpf = rte_bpf_load(&prm);
+		RTE_TEST_ASSERT_NOT_NULL(bpf, "expect rte_bpf_load() != NULL");
+
+		if (use_jit) {
+			struct rte_bpf_jit jit;
+			RTE_TEST_ASSERT_SUCCESS(rte_bpf_get_jit(bpf, &jit),
+				"expect rte_bpf_get_jit() to succeed");
+
+			const xchg_program jit_function = (void *)jit.func;
+			return_value = jit_function(&argument);
+		} else
+			return_value = rte_bpf_exec(bpf, &argument);
+
+		rte_bpf_destroy(bpf);
+
+		RTE_TEST_ASSERT_EQUAL(return_value, XCHG_RETURN_VALUE,
+			"expect return_value == %#jx, found %#jx, use_jit=%d",
+			(uintmax_t)XCHG_RETURN_VALUE, (uintmax_t)return_value,
+			use_jit);
+
+		RTE_TEST_ASSERT_EQUAL(argument.value0, expected.value0,
+			"expect value0 == %#jx, found %#jx, use_jit=%d",
+			(uintmax_t)expected.value0, (uintmax_t)argument.value0,
+			use_jit);
+
+		RTE_TEST_ASSERT_EQUAL(argument.value1, expected.value1,
+			"expect value1 == %#jx, found %#jx, use_jit=%d",
+			(uintmax_t)expected.value1, (uintmax_t)argument.value1,
+			use_jit);
+	}
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test 32-bit XADD.
+ *
+ * - Pre-fill r0 with return value.
+ * - Fill r2 with XADD_OPERAND.
+ * - Add (uint32_t)XADD_OPERAND to *(uint32_t *)&value0.
+ * - Negate r2 and use it in the next operation to verify it was not corrupted.
+ * - Add (uint32_t)-XADD_OPERAND to *(uint32_t *)&value1.
+ * - Return r0 which should remain unchanged.
+ */
+
+static int
+test_xadd32(void)
+{
+	static const struct ebpf_insn ins[] = {
+		{
+			/* Set r0 to return value. */
+			.code = (BPF_LD | BPF_IMM | EBPF_DW),
+			.dst_reg = EBPF_REG_0,
+			.imm = (uint32_t)XCHG_RETURN_VALUE,
+		},
+		{
+			/* Second part of 128-bit instruction. */
+			.imm = XCHG_RETURN_VALUE >> 32,
+		},
+		{
+			/* Set r2 to XADD operand. */
+			.code = (BPF_LD | BPF_IMM | EBPF_DW),
+			.dst_reg = EBPF_REG_2,
+			.imm = (uint32_t)XADD_OPERAND,
+		},
+		{
+			/* Second part of 128-bit instruction. */
+			.imm = XADD_OPERAND >> 32,
+		},
+		{
+			/* Atomically add r2 to value0, 32-bit. */
+			.code = (BPF_STX | EBPF_ATOMIC | BPF_W),
+			.src_reg = EBPF_REG_2,
+			.dst_reg = EBPF_REG_1,
+			.off = offsetof(struct xchg_arg, value0),
+			.imm = BPF_ATOMIC_ADD,
+		},
+		{
+			/* Negate r2. */
+			.code = (EBPF_ALU64 | BPF_NEG | BPF_K),
+			.dst_reg = EBPF_REG_2,
+		},
+		{
+			/* Atomically add r2 to value1, 32-bit. */
+			.code = (BPF_STX | EBPF_ATOMIC | BPF_W),
+			.src_reg = EBPF_REG_2,
+			.dst_reg = EBPF_REG_1,
+			.off = offsetof(struct xchg_arg, value1),
+			.imm = BPF_ATOMIC_ADD,
+		},
+		{
+			.code = (BPF_JMP | EBPF_EXIT),
+		},
+	};
+	const struct xchg_arg expected = {
+#if RTE_BYTE_ORDER == RTE_BIG_ENDIAN
+		/* Only high 32 bits should be added. */
+		.value0 = xchg_input.value0 + (XADD_OPERAND & RTE_GENMASK64(63, 32)),
+		.value1 = xchg_input.value1 - (XADD_OPERAND & RTE_GENMASK64(63, 32)),
+#elif RTE_BYTE_ORDER == RTE_LITTLE_ENDIAN
+		/* Only low 32 bits should be added, without carry. */
+		.value0 = (xchg_input.value0 & RTE_GENMASK64(63, 32)) |
+			((xchg_input.value0 + XADD_OPERAND) & RTE_GENMASK64(31, 0)),
+		.value1 = (xchg_input.value1 & RTE_GENMASK64(63, 32)) |
+			((xchg_input.value1 - XADD_OPERAND) & RTE_GENMASK64(31, 0)),
+#else
+#error Unsupported endianness.
+#endif
+	};
+	return run_xchg_test(RTE_DIM(ins), ins, expected);
+}
+
+REGISTER_FAST_TEST(bpf_xadd32_autotest, true, true, test_xadd32);
+
+/*
+ * Test 64-bit XADD.
+ *
+ * - Pre-fill r0 with return value.
+ * - Fill r2 with XADD_OPERAND.
+ * - Add XADD_OPERAND to value0.
+ * - Negate r2 and use it in the next operation to verify it was not corrupted.
+ * - Add -XADD_OPERAND to value1.
+ * - Return r0 which should remain unchanged.
+ */
+
+static int
+test_xadd64(void)
+{
+	static const struct ebpf_insn ins[] = {
+		{
+			/* Set r0 to return value. */
+			.code = (BPF_LD | BPF_IMM | EBPF_DW),
+			.dst_reg = EBPF_REG_0,
+			.imm = (uint32_t)XCHG_RETURN_VALUE,
+		},
+		{
+			/* Second part of 128-bit instruction. */
+			.imm = XCHG_RETURN_VALUE >> 32,
+		},
+		{
+			/* Set r2 to XADD operand. */
+			.code = (BPF_LD | BPF_IMM | EBPF_DW),
+			.dst_reg = EBPF_REG_2,
+			.imm = (uint32_t)XADD_OPERAND,
+		},
+		{
+			/* Second part of 128-bit instruction. */
+			.imm = XADD_OPERAND >> 32,
+		},
+		{
+			/* Atomically add r2 to value0. */
+			.code = (BPF_STX | EBPF_ATOMIC | EBPF_DW),
+			.src_reg = EBPF_REG_2,
+			.dst_reg = EBPF_REG_1,
+			.off = offsetof(struct xchg_arg, value0),
+			.imm = BPF_ATOMIC_ADD,
+		},
+		{
+			/* Negate r2. */
+			.code = (EBPF_ALU64 | BPF_NEG | BPF_K),
+			.dst_reg = EBPF_REG_2,
+		},
+		{
+			/* Atomically add r2 to value1. */
+			.code = (BPF_STX | EBPF_ATOMIC | EBPF_DW),
+			.src_reg = EBPF_REG_2,
+			.dst_reg = EBPF_REG_1,
+			.off = offsetof(struct xchg_arg, value1),
+			.imm = BPF_ATOMIC_ADD,
+		},
+		{
+			.code = (BPF_JMP | EBPF_EXIT),
+		},
+	};
+	const struct xchg_arg expected = {
+		.value0 = xchg_input.value0 + XADD_OPERAND,
+		.value1 = xchg_input.value1 - XADD_OPERAND,
+	};
+	return run_xchg_test(RTE_DIM(ins), ins, expected);
+}
+
+REGISTER_FAST_TEST(bpf_xadd64_autotest, true, true, test_xadd64);
+
+/*
+ * Test 32-bit XCHG.
+ *
+ * - Pre-fill r2 with return value.
+ * - Exchange *(uint32_t *)&value0 and *(uint32_t *)&value1 via r2.
+ * - Upper half of r2 should get cleared, so add it back before returning.
+ */
+
+static int
+test_xchg32(void)
+{
+	static const struct ebpf_insn ins[] = {
+		{
+			/* Set r2 to return value. */
+			.code = (BPF_LD | BPF_IMM | EBPF_DW),
+			.dst_reg = EBPF_REG_2,
+			.imm = (uint32_t)XCHG_RETURN_VALUE,
+		},
+		{
+			/* Second part of 128-bit instruction. */
+			.imm = XCHG_RETURN_VALUE >> 32,
+		},
+		{
+			/* Atomically exchange r2 with value0, 32-bit. */
+			.code = (BPF_STX | EBPF_ATOMIC | BPF_W),
+			.src_reg = EBPF_REG_2,
+			.dst_reg = EBPF_REG_1,
+			.off = offsetof(struct xchg_arg, value0),
+			.imm = BPF_ATOMIC_XCHG,
+		},
+		{
+			/* Atomically exchange r2 with value1, 32-bit. */
+			.code = (BPF_STX | EBPF_ATOMIC | BPF_W),
+			.src_reg = EBPF_REG_2,
+			.dst_reg = EBPF_REG_1,
+			.off = offsetof(struct xchg_arg, value1),
+			.imm = BPF_ATOMIC_XCHG,
+		},
+		{
+			/* Atomically exchange r2 with value0, 32-bit. */
+			.code = (BPF_STX | EBPF_ATOMIC | BPF_W),
+			.src_reg = EBPF_REG_2,
+			.dst_reg = EBPF_REG_1,
+			.off = offsetof(struct xchg_arg, value0),
+			.imm = BPF_ATOMIC_XCHG,
+		},
+		{
+			/* Set upper half of r0 to return value. */
+			.code = (BPF_LD | BPF_IMM | EBPF_DW),
+			.dst_reg = EBPF_REG_0,
+			.imm = 0,
+		},
+		{
+			/* Second part of 128-bit instruction. */
+			.imm = XCHG_RETURN_VALUE >> 32,
+		},
+		{
+			/*
+			 * Add r2 (should have upper half cleared by this time)
+			 * to r0 to use as a return value.
+			 */
+			.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
+			.src_reg = EBPF_REG_2,
+			.dst_reg = EBPF_REG_0,
+		},
+		{
+			.code = (BPF_JMP | EBPF_EXIT),
+		},
+	};
+	struct xchg_arg expected = {
+#if RTE_BYTE_ORDER == RTE_BIG_ENDIAN
+	/* Only high 32 bits should be exchanged. */
+		.value0 =
+			(xchg_input.value0 & RTE_GENMASK64(31, 0)) |
+			(xchg_input.value1 & RTE_GENMASK64(63, 32)),
+		.value1 =
+			(xchg_input.value1 & RTE_GENMASK64(31, 0)) |
+			(xchg_input.value0 & RTE_GENMASK64(63, 32)),
+#elif RTE_BYTE_ORDER == RTE_LITTLE_ENDIAN
+	/* Only low 32 bits should be exchanged. */
+		.value0 =
+			(xchg_input.value1 & RTE_GENMASK64(31, 0)) |
+			(xchg_input.value0 & RTE_GENMASK64(63, 32)),
+		.value1 =
+			(xchg_input.value0 & RTE_GENMASK64(31, 0)) |
+			(xchg_input.value1 & RTE_GENMASK64(63, 32)),
+#else
+#error Unsupported endianness.
+#endif
+	};
+	return run_xchg_test(RTE_DIM(ins), ins, expected);
+}
+
+REGISTER_FAST_TEST(bpf_xchg32_autotest, true, true, test_xchg32);
+
+/*
+ * Test 64-bit XCHG.
+ *
+ * - Pre-fill r2 with return value.
+ * - Exchange value0 and value1 via r2.
+ * - Return r2, which should remain unchanged.
+ */
+
+static int
+test_xchg64(void)
+{
+	static const struct ebpf_insn ins[] = {
+		{
+			/* Set r2 to return value. */
+			.code = (BPF_LD | BPF_IMM | EBPF_DW),
+			.dst_reg = EBPF_REG_2,
+			.imm = (uint32_t)XCHG_RETURN_VALUE,
+		},
+		{
+			/* Second part of 128-bit instruction. */
+			.imm = XCHG_RETURN_VALUE >> 32,
+		},
+		{
+			/* Atomically exchange r2 with value0. */
+			.code = (BPF_STX | EBPF_ATOMIC | EBPF_DW),
+			.src_reg = EBPF_REG_2,
+			.dst_reg = EBPF_REG_1,
+			.off = offsetof(struct xchg_arg, value0),
+			.imm = BPF_ATOMIC_XCHG,
+		},
+		{
+			/* Atomically exchange r2 with value1. */
+			.code = (BPF_STX | EBPF_ATOMIC | EBPF_DW),
+			.src_reg = EBPF_REG_2,
+			.dst_reg = EBPF_REG_1,
+			.off = offsetof(struct xchg_arg, value1),
+			.imm = BPF_ATOMIC_XCHG,
+		},
+		{
+			/* Atomically exchange r2 with value0. */
+			.code = (BPF_STX | EBPF_ATOMIC | EBPF_DW),
+			.src_reg = EBPF_REG_2,
+			.dst_reg = EBPF_REG_1,
+			.off = offsetof(struct xchg_arg, value0),
+			.imm = BPF_ATOMIC_XCHG,
+		},
+		{
+			/* Copy r2 to r0 to use as a return value. */
+			.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
+			.src_reg = EBPF_REG_2,
+			.dst_reg = EBPF_REG_0,
+		},
+		{
+			.code = (BPF_JMP | EBPF_EXIT),
+		},
+	};
+	const struct xchg_arg expected = {
+		.value0 = xchg_input.value1,
+		.value1 = xchg_input.value0,
+	};
+	return run_xchg_test(RTE_DIM(ins), ins, expected);
+}
+
+REGISTER_FAST_TEST(bpf_xchg64_autotest, true, true, test_xchg64);
+
+/*
+ * Test invalid and unsupported atomic imm values (also valid ones for control).
+ *
+ * For realism use a meaningful subset of the test_xchg64 program.
+ */
+
+static int
+test_atomic_imm(int32_t imm, bool is_valid)
+{
+	const struct ebpf_insn ins[] = {
+		{
+			/* Set r2 to return value. */
+			.code = (BPF_LD | BPF_IMM | EBPF_DW),
+			.dst_reg = EBPF_REG_2,
+			.imm = (uint32_t)XCHG_RETURN_VALUE,
+		},
+		{
+			/* Second part of 128-bit instruction. */
+			.imm = XCHG_RETURN_VALUE >> 32,
+		},
+		{
+			/* Atomically exchange r2 with value0. */
+			.code = (BPF_STX | EBPF_ATOMIC | EBPF_DW),
+			.src_reg = EBPF_REG_2,
+			.dst_reg = EBPF_REG_1,
+			.off = offsetof(struct xchg_arg, value0),
+			.imm = imm,
+		},
+		{
+			/* Copy r2 to r0 to use as a return value. */
+			.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
+			.src_reg = EBPF_REG_2,
+			.dst_reg = EBPF_REG_0,
+		},
+		{
+			.code = (BPF_JMP | EBPF_EXIT),
+		},
+	};
+	const struct rte_bpf_prm prm = {
+		.ins = ins,
+		.nb_ins = RTE_DIM(ins),
+		.prog_arg = {
+			.type = RTE_BPF_ARG_PTR,
+			.size = sizeof(struct xchg_arg),
+		},
+	};
+
+	struct rte_bpf *const bpf = rte_bpf_load(&prm);
+	rte_bpf_destroy(bpf);
+
+	if (is_valid)
+		RTE_TEST_ASSERT_NOT_NULL(bpf, "expect rte_bpf_load() != NULL, imm=%#x", imm);
+	else
+		RTE_TEST_ASSERT_NULL(bpf, "expect rte_bpf_load() == NULL, imm=%#x", imm);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_atomic_imms(void)
+{
+	RTE_TEST_ASSERT_SUCCESS(test_atomic_imm(INT32_MIN, false), "expect success");
+	for (int32_t imm = BPF_ATOMIC_ADD - 1; imm <= BPF_ATOMIC_XCHG + 1; ++imm) {
+		const bool is_valid = imm == BPF_ATOMIC_ADD || imm == BPF_ATOMIC_XCHG;
+		RTE_TEST_ASSERT_SUCCESS(test_atomic_imm(imm, is_valid), "expect success");
+	}
+	RTE_TEST_ASSERT_SUCCESS(test_atomic_imm(INT32_MAX, false), "expect success");
+
+	return TEST_SUCCESS;
+}
+
+REGISTER_FAST_TEST(bpf_atomic_imms_autotest, true, true, test_atomic_imms);
diff --git a/lib/bpf/bpf_def.h b/lib/bpf/bpf_def.h
index fa9125307e..ead8d2f215 100644
--- a/lib/bpf/bpf_def.h
+++ b/lib/bpf/bpf_def.h
@@ -55,6 +55,11 @@
 #define	BPF_MSH		0xa0
 
 #define EBPF_XADD	0xc0
+/* Generalize XADD for other operations depending on imm (0 still means ADD). */
+#define EBPF_ATOMIC	0xc0
+
+#define BPF_ATOMIC_ADD	0x00
+#define BPF_ATOMIC_XCHG	0xe1
 
 /* alu/jmp fields */
 #define BPF_OP(code)    ((code) & 0xf0)
diff --git a/lib/bpf/bpf_exec.c b/lib/bpf/bpf_exec.c
index 4b5ea9f1a4..18013753b1 100644
--- a/lib/bpf/bpf_exec.c
+++ b/lib/bpf/bpf_exec.c
@@ -64,10 +64,27 @@
 	(*(type *)(uintptr_t)((reg)[(ins)->dst_reg] + (ins)->off) = \
 		(type)(reg)[(ins)->src_reg])
 
-#define BPF_ST_XADD_REG(reg, ins, tp)	\
-	(rte_atomic##tp##_add((rte_atomic##tp##_t *) \
-		(uintptr_t)((reg)[(ins)->dst_reg] + (ins)->off), \
-		reg[ins->src_reg]))
+#define BPF_ST_ATOMIC_REG(reg, ins, tp)	do { \
+	switch (ins->imm) { \
+	case BPF_ATOMIC_ADD: \
+		rte_atomic##tp##_add((rte_atomic##tp##_t *) \
+			(uintptr_t)((reg)[(ins)->dst_reg] + (ins)->off), \
+			(reg)[(ins)->src_reg]); \
+		break; \
+	case BPF_ATOMIC_XCHG: \
+		(reg)[(ins)->src_reg] = rte_atomic##tp##_exchange((uint##tp##_t *) \
+			(uintptr_t)((reg)[(ins)->dst_reg] + (ins)->off), \
+			(reg)[(ins)->src_reg]); \
+		break; \
+	default: \
+		/* this should be caught by validator and never reach here */ \
+		RTE_BPF_LOG_LINE(ERR, \
+			"%s(%p): unsupported atomic operation at pc: %#zx;", \
+			__func__, bpf, \
+			(uintptr_t)(ins) - (uintptr_t)(bpf)->prm.ins); \
+		return 0; \
+	} \
+} while (0)
 
 /* BPF_LD | BPF_ABS/BPF_IND */
 
@@ -373,12 +390,12 @@ bpf_exec(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM])
 		case (BPF_ST | BPF_MEM | EBPF_DW):
 			BPF_ST_IMM(reg, ins, uint64_t);
 			break;
-		/* atomic add instructions */
-		case (BPF_STX | EBPF_XADD | BPF_W):
-			BPF_ST_XADD_REG(reg, ins, 32);
+		/* atomic instructions */
+		case (BPF_STX | EBPF_ATOMIC | BPF_W):
+			BPF_ST_ATOMIC_REG(reg, ins, 32);
 			break;
-		case (BPF_STX | EBPF_XADD | EBPF_DW):
-			BPF_ST_XADD_REG(reg, ins, 64);
+		case (BPF_STX | EBPF_ATOMIC | EBPF_DW):
+			BPF_ST_ATOMIC_REG(reg, ins, 64);
 			break;
 		/* jump instructions */
 		case (BPF_JMP | BPF_JA):
diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
index 96b8cd2e03..13186c84c8 100644
--- a/lib/bpf/bpf_jit_arm64.c
+++ b/lib/bpf/bpf_jit_arm64.c
@@ -978,6 +978,20 @@ emit_stadd(struct a64_jit_ctx *ctx, bool is64, uint8_t rs, uint8_t rn)
 	emit_insn(ctx, insn, check_reg(rs) || check_reg(rn));
 }
 
+static void
+emit_swpal(struct a64_jit_ctx *ctx, bool is64, uint8_t rs, uint8_t rt, uint8_t rn)
+{
+	uint32_t insn;
+
+	insn = 0xb8e08000;
+	insn |= (!!is64) << 30;
+	insn |= rs << 16;
+	insn |= rn << 5;
+	insn |= rt;
+
+	emit_insn(ctx, insn, check_reg(rs) || check_reg(rt) || check_reg(rn));
+}
+
 static void
 emit_ldxr(struct a64_jit_ctx *ctx, bool is64, uint8_t rt, uint8_t rn)
 {
@@ -1018,8 +1032,8 @@ has_atomics(void)
 }
 
 static void
-emit_xadd(struct a64_jit_ctx *ctx, uint8_t op, uint8_t tmp1, uint8_t tmp2,
-	  uint8_t tmp3, uint8_t dst, int16_t off, uint8_t src)
+emit_atomic(struct a64_jit_ctx *ctx, uint8_t op, uint8_t tmp1, uint8_t tmp2,
+	  uint8_t tmp3, uint8_t dst, int16_t off, uint8_t src, int32_t atomic_op)
 {
 	bool is64 = (BPF_SIZE(op) == EBPF_DW);
 	uint8_t rn;
@@ -1032,13 +1046,32 @@ emit_xadd(struct a64_jit_ctx *ctx, uint8_t op, uint8_t tmp1, uint8_t tmp2,
 		rn = dst;
 	}
 
-	if (has_atomics()) {
-		emit_stadd(ctx, is64, src, rn);
-	} else {
-		emit_ldxr(ctx, is64, tmp2, rn);
-		emit_add(ctx, is64, tmp2, src);
-		emit_stxr(ctx, is64, tmp3, tmp2, rn);
-		emit_cbnz(ctx, is64, tmp3, -3);
+	switch (atomic_op) {
+	case BPF_ATOMIC_ADD:
+		if (has_atomics()) {
+			emit_stadd(ctx, is64, src, rn);
+		} else {
+			emit_ldxr(ctx, is64, tmp2, rn);
+			emit_add(ctx, is64, tmp2, src);
+			emit_stxr(ctx, is64, tmp3, tmp2, rn);
+			emit_cbnz(ctx, is64, tmp3, -3);
+		}
+		break;
+	case BPF_ATOMIC_XCHG:
+		if (has_atomics()) {
+			emit_swpal(ctx, is64, src, src, rn);
+		} else {
+			emit_ldxr(ctx, is64, tmp2, rn);
+			emit_stxr(ctx, is64, tmp3, src, rn);
+			emit_cbnz(ctx, is64, tmp3, -2);
+			emit_mov(ctx, is64, src, tmp2);
+		}
+		break;
+	default:
+		/* this should be caught by validator and never reach here */
+		emit_mov_imm(ctx, 1, ebpf_to_a64_reg(ctx, EBPF_REG_0), 0);
+		emit_epilogue(ctx);
+		return;
 	}
 }
 
@@ -1322,10 +1355,10 @@ emit(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
 			emit_mov_imm(ctx, 1, tmp2, off);
 			emit_str(ctx, BPF_SIZE(op), tmp1, dst, tmp2);
 			break;
-		/* STX XADD: lock *(size *)(dst + off) += src */
-		case (BPF_STX | EBPF_XADD | BPF_W):
-		case (BPF_STX | EBPF_XADD | EBPF_DW):
-			emit_xadd(ctx, op, tmp1, tmp2, tmp3, dst, off, src);
+		/* lock *(size *)(dst + off) += src or xchg(dst + off, &src) */
+		case (BPF_STX | EBPF_ATOMIC | BPF_W):
+		case (BPF_STX | EBPF_ATOMIC | EBPF_DW):
+			emit_atomic(ctx, op, tmp1, tmp2, tmp3, dst, off, src, imm);
 			break;
 		/* PC += off */
 		case (BPF_JMP | BPF_JA):
diff --git a/lib/bpf/bpf_jit_x86.c b/lib/bpf/bpf_jit_x86.c
index 4d74e418f8..7329668d55 100644
--- a/lib/bpf/bpf_jit_x86.c
+++ b/lib/bpf/bpf_jit_x86.c
@@ -167,7 +167,7 @@ emit_rex(struct bpf_jit_state *st, uint32_t op, uint32_t reg, uint32_t rm)
 	if (BPF_CLASS(op) == EBPF_ALU64 ||
 			op == (BPF_ST | BPF_MEM | EBPF_DW) ||
 			op == (BPF_STX | BPF_MEM | EBPF_DW) ||
-			op == (BPF_STX | EBPF_XADD | EBPF_DW) ||
+			op == (BPF_STX | EBPF_ATOMIC | EBPF_DW) ||
 			op == (BPF_LD | BPF_IMM | EBPF_DW) ||
 			(BPF_CLASS(op) == BPF_LDX &&
 			BPF_MODE(op) == BPF_MEM &&
@@ -652,22 +652,41 @@ emit_st_reg(struct bpf_jit_state *st, uint32_t op, uint32_t sreg, uint32_t dreg,
 	emit_st_common(st, op, sreg, dreg, 0, ofs);
 }
 
+static void
+emit_abs_jmp(struct bpf_jit_state *st, int32_t ofs);
+
 /*
  * emit lock add %<sreg>, <ofs>(%<dreg>)
  */
 static void
-emit_st_xadd(struct bpf_jit_state *st, uint32_t op, uint32_t sreg,
-	uint32_t dreg, int32_t ofs)
+emit_st_atomic(struct bpf_jit_state *st, uint32_t op, uint32_t sreg,
+	uint32_t dreg, int32_t ofs, int32_t atomic_op)
 {
 	uint32_t imsz, mods;
+	uint8_t ops;
 
 	const uint8_t lck = 0xF0; /* lock prefix */
-	const uint8_t ops = 0x01; /* add opcode */
+
+	switch (atomic_op) {
+	case BPF_ATOMIC_ADD:
+		ops = 0x01; /* add opcode */
+		break;
+	case BPF_ATOMIC_XCHG:
+		ops = 0x87; /* xchg opcode */
+		break;
+	default:
+		/* this should be caught by validator and never reach here */
+		emit_ld_imm64(st, RAX, 0, 0);
+		emit_abs_jmp(st, st->exit.off);
+		return;
+	}
 
 	imsz = imm_size(ofs);
 	mods = (imsz == 1) ? MOD_IDISP8 : MOD_IDISP32;
 
-	emit_bytes(st, &lck, sizeof(lck));
+	/* xchg already implies lock */
+	if (atomic_op != BPF_ATOMIC_XCHG)
+		emit_bytes(st, &lck, sizeof(lck));
 	emit_rex(st, op, sreg, dreg);
 	emit_bytes(st, &ops, sizeof(ops));
 	emit_modregrm(st, mods, sreg, dreg);
@@ -1429,10 +1448,10 @@ emit(struct bpf_jit_state *st, const struct rte_bpf *bpf)
 		case (BPF_ST | BPF_MEM | EBPF_DW):
 			emit_st_imm(st, op, dr, ins->imm, ins->off);
 			break;
-		/* atomic add instructions */
-		case (BPF_STX | EBPF_XADD | BPF_W):
-		case (BPF_STX | EBPF_XADD | EBPF_DW):
-			emit_st_xadd(st, op, sr, dr, ins->off);
+		/* atomic instructions */
+		case (BPF_STX | EBPF_ATOMIC | BPF_W):
+		case (BPF_STX | EBPF_ATOMIC | EBPF_DW):
+			emit_st_atomic(st, op, sr, dr, ins->off, ins->imm);
 			break;
 		/* jump instructions */
 		case (BPF_JMP | BPF_JA):
diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index 4f47d6dc7b..c6f6bfab23 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -910,6 +910,16 @@ eval_store(struct bpf_verifier *bvf, const struct ebpf_insn *ins)
 
 	if (BPF_CLASS(ins->code) == BPF_STX) {
 		rs = st->rv[ins->src_reg];
+		if (BPF_MODE(ins->code) == EBPF_ATOMIC)
+			switch (ins->imm) {
+			case BPF_ATOMIC_ADD:
+				break;
+			case BPF_ATOMIC_XCHG:
+				eval_max_bound(&st->rv[ins->src_reg], msk);
+				break;
+			default:
+				return "unsupported atomic operation";
+			}
 		eval_apply_mask(&rs, msk);
 	} else
 		eval_fill_imm(&rs, msk, ins->imm);
@@ -926,7 +936,7 @@ eval_store(struct bpf_verifier *bvf, const struct ebpf_insn *ins)
 
 		sv = st->sv + rd.u.max / sizeof(uint64_t);
 		if (BPF_CLASS(ins->code) == BPF_STX &&
-				BPF_MODE(ins->code) == EBPF_XADD)
+				BPF_MODE(ins->code) == EBPF_ATOMIC)
 			eval_max_bound(sv, msk);
 		else
 			*sv = rs;
@@ -1549,17 +1559,17 @@ static const struct bpf_ins_check ins_chk[UINT8_MAX + 1] = {
 		.imm = { .min = 0, .max = 0},
 		.eval = eval_store,
 	},
-	/* atomic add instructions */
-	[(BPF_STX | EBPF_XADD | BPF_W)] = {
+	/* atomic instructions */
+	[(BPF_STX | EBPF_ATOMIC | BPF_W)] = {
 		.mask = { .dreg = ALL_REGS, .sreg = ALL_REGS},
 		.off = { .min = 0, .max = UINT16_MAX},
-		.imm = { .min = 0, .max = 0},
+		.imm = { .min = BPF_ATOMIC_ADD, .max = BPF_ATOMIC_XCHG},
 		.eval = eval_store,
 	},
-	[(BPF_STX | EBPF_XADD | EBPF_DW)] = {
+	[(BPF_STX | EBPF_ATOMIC | EBPF_DW)] = {
 		.mask = { .dreg = ALL_REGS, .sreg = ALL_REGS},
 		.off = { .min = 0, .max = UINT16_MAX},
-		.imm = { .min = 0, .max = 0},
+		.imm = { .min = BPF_ATOMIC_ADD, .max = BPF_ATOMIC_XCHG},
 		.eval = eval_store,
 	},
 	/* store IMM instructions */
-- 
2.43.0

