Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A14CD342C
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 17:40:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F5DE40DD2;
	Wed,  6 May 2026 19:39:31 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id C6DB040676;
 Wed,  6 May 2026 19:39:19 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g9jK93pnzzHnGjS;
 Thu,  7 May 2026 01:38:21 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 9FF9C40569;
 Thu,  7 May 2026 01:39:19 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 19:39:19 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH 12/25] bpf/validate: fix BPF_DIV and BPF_MOD signed part
Date: Wed, 6 May 2026 18:38:30 +0100
Message-ID: <20260506173846.64914-13-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506173846.64914-1-marat.khalili@huawei.com>
References: <20260506173846.64914-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500008.china.huawei.com (7.182.19.65) To
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

Function `eval_divmod` for _unsigned_ division or modulo operation
calculated signed ranges using _signed_ division, which is
mathematically incorrect: unlike some other mathematical operations,
signed and unsigned divisions in the CPU register cyclic ring math are
not equivalent.

E.g. consider the following program with the current validation code:

     Tested program:
         0:  mov r0, #0x0
         1:  lddw r2, #0xaaaaaaaaaaaaaaaa
         3:  mov r3, #0x2
         4:  div r2, r3  ; tested instruction
         5:  mov r0, #0x1
         6:  exit
     Pre-state:
        r2:  -6148914691236517206
        r3:  2
     Post-state:
        r2:  -3074457345618258603 INTERSECT 0x5555555555555555 (!)

After the tested instruction validator considers r2 to equal
0x5555555555555555 if viewed as unsigned (correct, this is
0xaaaaaaaaaaaaaaaaull / 2), but equal -3074457345618258603 or
0xd555555555555555 if viewed as signed, although it cannot be both true.

Additionally, when validating division or modulo of INT64_MIN by -1
overflow happened in the validator possibly triggering an exception.

The following error is shown without sanitizer:

    1/1 DPDK:fast-tests / bpf_autotest FAIL            0.37s
    killed by signal 8 SIGFPE

With sanitizer the following diagnostic is generated:

    lib/bpf/bpf_validate.c:1086:14: runtime error: division of
    -9223372036854775808 by -1 cannot be represented in type 'long int'
        #0 0x0000027484bb in eval_divmod lib/bpf/bpf_validate.c:1086
        #1 0x00000274bcf3 in eval_alu lib/bpf/bpf_validate.c:1280
        #2 0x00000275cb3e in evaluate lib/bpf/bpf_validate.c:3192
        ...

    SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
    lib/bpf/bpf_validate.c:1086:14

Change logic to copy results from unsigned division into signed. Add
both validation and execution tests for the case that triggered an
exception. Add validation tests for non-constant division to make sure
it is still valid (ranges of the non-constant division or modulo are not
really minimal, this can be addressed in the future).

Fixes: 8021917293d0 ("bpf: add extra validation for input BPF program")
Cc: stable@dpdk.org

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_bpf.c          |  99 +++++++++++++++++++++++++
 app/test/test_bpf_validate.c | 135 +++++++++++++++++++++++++++++++++++
 lib/bpf/bpf_validate.c       |  38 +++-------
 3 files changed, 244 insertions(+), 28 deletions(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 69e84f0cab56..744bf02f7356 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -393,6 +393,13 @@ cmp_res(const char *func, uint64_t exp_rc, uint64_t ret_rc,
 	return ret;
 }
 
+/* Empty prepare function */
+static void
+dummy_prepare(void *arg)
+{
+	RTE_SET_USED(arg);
+}
+
 /* store immediate test-cases */
 static const struct ebpf_insn test_store1_prog[] = {
 	{
@@ -3157,6 +3164,70 @@ static const struct ebpf_insn test_ld_mbuf3_prog[] = {
 	},
 };
 
+/* divide INT64_MIN by -1 */
+static const struct ebpf_insn test_int64min_udiv_uint64max_prog[] = {
+	/* Load INT64_MIN into r0 */
+	{
+		.code = (BPF_LD | BPF_IMM | EBPF_DW),
+		.dst_reg = EBPF_REG_0,
+		.imm = (int32_t)INT64_MIN,
+	},
+	{
+		.imm = (int32_t)(INT64_MIN >> 32),
+	},
+	/* Divide r0 by immediate -1 */
+	{
+		.code = (EBPF_ALU64 | BPF_DIV | BPF_K),
+		.dst_reg = EBPF_REG_0,
+		.imm = -1,
+	},
+	/* Exit for correctness otherwise */
+	{
+		.code = (BPF_JMP | EBPF_EXIT),
+	},
+};
+
+static int
+test_int64min_udiv_uint64max_check(uint64_t rc, const void *arg)
+{
+	RTE_SET_USED(arg);
+	/* 0x8000000000000000ull / 0xFFFFFFFFFFFFFFFFull == 0 */
+	TEST_ASSERT_EQUAL(rc, 0, "expected 0, found %#" PRIx64, rc);
+	return TEST_SUCCESS;
+}
+
+/* modulo INT64_MIN by -1 */
+static const struct ebpf_insn test_int64min_umod_uint64max_prog[] = {
+	/* Load INT64_MIN into r0 */
+	{
+		.code = (BPF_LD | BPF_IMM | EBPF_DW),
+		.dst_reg = EBPF_REG_0,
+		.imm = (int32_t)INT64_MIN,
+	},
+	{
+		.imm = (int32_t)(INT64_MIN >> 32),
+	},
+	/* Modulo r0 by immediate -1 */
+	{
+		.code = (EBPF_ALU64 | BPF_MOD | BPF_K),
+		.dst_reg = EBPF_REG_0,
+		.imm = -1,
+	},
+	/* Exit for correctness otherwise */
+	{
+		.code = (BPF_JMP | EBPF_EXIT),
+	},
+};
+
+static int
+test_int64min_umod_uint64max_check(uint64_t rc, const void *arg)
+{
+	RTE_SET_USED(arg);
+	/* 0x8000000000000000ull % 0xFFFFFFFFFFFFFFFFull == 0x8000000000000000ull  */
+	TEST_ASSERT_EQUAL(rc, (uint64_t)INT64_MIN, "expected INT64_MIN, found %#" PRIx64, rc);
+	return TEST_SUCCESS;
+}
+
 /* all bpf test cases */
 static const struct bpf_test tests[] = {
 	{
@@ -3465,6 +3536,34 @@ static const struct bpf_test tests[] = {
 		/* mbuf as input argument is not supported on 32 bit platform */
 		.allow_fail = (sizeof(uint64_t) != sizeof(uintptr_t)),
 	},
+	{
+		.name = "test_int64min_udiv_uint64max",
+		.arg_sz = sizeof(struct dummy_vect8),
+		.prm = {
+			.ins = test_int64min_udiv_uint64max_prog,
+			.nb_ins = RTE_DIM(test_int64min_udiv_uint64max_prog),
+			.prog_arg = {
+				.type = RTE_BPF_ARG_PTR,
+				.size = sizeof(struct dummy_vect8),
+			},
+		},
+		.prepare = dummy_prepare,
+		.check_result = test_int64min_udiv_uint64max_check,
+	},
+	{
+		.name = "test_int64min_umod_uint64max",
+		.arg_sz = 1,
+		.prm = {
+			.ins = test_int64min_umod_uint64max_prog,
+			.nb_ins = RTE_DIM(test_int64min_umod_uint64max_prog),
+			.prog_arg = {
+				.type = RTE_BPF_ARG_PTR,
+				.size = 1,
+			},
+		},
+		.prepare = dummy_prepare,
+		.check_result = test_int64min_umod_uint64max_check,
+	},
 };
 
 static int
diff --git a/app/test/test_bpf_validate.c b/app/test/test_bpf_validate.c
index 995f7363b80f..aada6e110337 100644
--- a/app/test/test_bpf_validate.c
+++ b/app/test/test_bpf_validate.c
@@ -1154,6 +1154,141 @@ test_alu64_add_x_scalar_scalar(void)
 REGISTER_FAST_TEST(bpf_validate_alu64_add_x_scalar_scalar_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_add_x_scalar_scalar);
 
+/* 64-bit division and modulo of UINT64_MAX*2/3. */
+static int
+test_alu64_div_mod_big_constant(void)
+{
+	const uint64_t dividend = UINT64_MAX / 3 * 2;
+	static const uint64_t divisors[] = {
+		1,
+		2,
+		3,
+		UINT64_MAX / 3,
+		INT64_MAX,
+		INT64_MIN,
+		UINT64_MAX / 3 * 2,
+		UINT64_MAX / 4 * 3,
+		UINT64_MAX,
+	};
+	for (int index = 0; index != RTE_DIM(divisors); ++index) {
+		const uint64_t divisor = divisors[index];
+
+		TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+			.tested_instruction = {
+				.code = (EBPF_ALU64 | BPF_DIV | BPF_X),
+			},
+			.pre.dst = make_singleton_domain(dividend),
+			.pre.src = make_singleton_domain(divisor),
+			.post.dst = make_singleton_domain(dividend / divisor),
+		}), "(EBPF_ALU64 | BPF_DIV | BPF_X) check, index=%d", index);
+
+		TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+			.tested_instruction = {
+				.code = (EBPF_ALU64 | BPF_MOD | BPF_X),
+			},
+			.pre.dst = make_singleton_domain(dividend),
+			.pre.src = make_singleton_domain(divisor),
+			.post.dst = make_singleton_domain(dividend % divisor),
+		}), "(EBPF_ALU64 | BPF_MOD | BPF_X) check, index=%d", index);
+	}
+
+	return TEST_SUCCESS;
+}
+
+REGISTER_FAST_TEST(bpf_validate_alu64_div_mod_big_constant_autotest, NOHUGE_OK, ASAN_OK,
+	test_alu64_div_mod_big_constant);
+
+/* 64-bit division and modulo of UINT64_MAX/3..UINT64_MAX*2/3 by a constant. */
+static int
+test_alu64_div_mod_big_range(void)
+{
+	const uint64_t dividend_first = UINT64_MAX / 3;
+	const uint64_t dividend_last = UINT64_MAX / 3 * 2;
+	static const uint64_t divisors[] = {
+		1,
+		2,
+		3,
+		UINT64_MAX / 3,
+		INT64_MAX,
+		INT64_MIN,
+		UINT64_MAX / 3 * 2,
+		UINT64_MAX / 4 * 3,
+		UINT64_MAX,
+	};
+	for (int index = 0; index != RTE_DIM(divisors); ++index) {
+		const uint64_t divisor = divisors[index];
+
+		TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+			.tested_instruction = {
+				.code = (EBPF_ALU64 | BPF_DIV | BPF_X),
+			},
+			.pre.dst = make_unsigned_domain(dividend_first, dividend_last),
+			.pre.src = make_singleton_domain(divisor),
+			.post.dst = make_unsigned_domain(0, dividend_last),
+		}), "(EBPF_ALU64 | BPF_DIV | BPF_X) check, index=%d", index);
+
+		TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+			.tested_instruction = {
+				.code = (EBPF_ALU64 | BPF_MOD | BPF_X),
+			},
+			.pre.dst = make_unsigned_domain(dividend_first, dividend_last),
+			.pre.src = make_singleton_domain(divisor),
+			.post.dst = make_unsigned_domain(0, RTE_MIN(dividend_last, divisor - 1)),
+		}), "(EBPF_ALU64 | BPF_MOD | BPF_X) check, index=%d", index);
+	}
+
+	return TEST_SUCCESS;
+}
+
+REGISTER_FAST_TEST(bpf_validate_alu64_div_mod_big_range_autotest, NOHUGE_OK, ASAN_OK,
+	test_alu64_div_mod_big_range);
+
+/* 64-bit division and modulo of INT64_MIN by -1. */
+static int
+test_alu64_div_mod_overflow(void)
+{
+	TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (EBPF_ALU64 | BPF_DIV | BPF_K),
+			.imm = -1,
+		},
+		.pre.dst = make_singleton_domain(INT64_MIN),
+		.post.dst = make_singleton_domain(0),
+	}), "(EBPF_ALU64 | BPF_DIV | BPF_K) check");
+
+	TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (EBPF_ALU64 | BPF_DIV | BPF_X),
+		},
+		.pre.dst = make_singleton_domain(INT64_MIN),
+		.pre.src = make_singleton_domain(-1),
+		.post.dst = make_singleton_domain(0),
+	}), "(EBPF_ALU64 | BPF_DIV | BPF_X) check");
+
+	TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (EBPF_ALU64 | BPF_MOD | BPF_K),
+			.imm = -1,
+		},
+		.pre.dst = make_singleton_domain(INT64_MIN),
+		.post.dst = make_singleton_domain(INT64_MIN),
+	}), "(EBPF_ALU64 | BPF_MOD | BPF_K) check");
+
+	TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (EBPF_ALU64 | BPF_MOD | BPF_X),
+		},
+		.pre.dst = make_singleton_domain(INT64_MIN),
+		.pre.src = make_singleton_domain(-1),
+		.post.dst = make_singleton_domain(INT64_MIN),
+	}), "(EBPF_ALU64 | BPF_MOD | BPF_X) check");
+
+	return TEST_SUCCESS;
+}
+
+REGISTER_FAST_TEST(bpf_validate_alu64_div_mod_overflow_autotest, NOHUGE_OK, ASAN_OK,
+	test_alu64_div_mod_overflow);
+
 /* 64-bit negation when interval first element is INT64_MIN. */
 static int
 test_alu64_neg_int64min_first(void)
diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index 79c8679ac535..b784777bbb6b 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -932,8 +932,7 @@ eval_mul(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, size_t opsz,
 }
 
 static const char *
-eval_divmod(uint32_t op, struct bpf_reg_val *rd, struct bpf_reg_val *rs,
-	size_t opsz, uint64_t msk)
+eval_divmod(uint32_t op, struct bpf_reg_val *rd, struct bpf_reg_val *rs, uint64_t msk)
 {
 	/* both operands are constants */
 	if (rd->u.min == rd->u.max && rs->u.min == rs->u.max) {
@@ -954,34 +953,17 @@ eval_divmod(uint32_t op, struct bpf_reg_val *rd, struct bpf_reg_val *rs,
 		rd->u.min = 0;
 	}
 
-	/* if we have 32-bit values - extend them to 64-bit */
-	if (opsz == sizeof(uint32_t) * CHAR_BIT) {
-		rd->s.min = (int32_t)rd->s.min;
-		rd->s.max = (int32_t)rd->s.max;
-		rs->s.min = (int32_t)rs->s.min;
-		rs->s.max = (int32_t)rs->s.max;
-	}
-
-	/* both operands are constants */
-	if (rd->s.min == rd->s.max && rs->s.min == rs->s.max) {
-		if (rs->s.max == 0)
-			return "division by 0";
-		if (op == BPF_DIV) {
-			rd->s.min /= rs->s.min;
-			rd->s.max /= rs->s.max;
-		} else {
-			rd->s.min %= rs->s.min;
-			rd->s.max %= rs->s.max;
-		}
-	} else if (op == BPF_MOD) {
-		rd->s.min = RTE_MAX(rd->s.max, 0);
-		rd->s.min = RTE_MIN(rd->s.min, 0);
+	if (rd->u.min >= (uint64_t)INT64_MIN || rd->u.max <= (uint64_t)INT64_MAX) {
+		/*
+		 * All values have the same sign bit, which means range
+		 * contiguous as unsigned is also contiguous as signed,
+		 * so we can just reuse it without any changes.
+		 */
+		rd->s.min = rd->u.min;
+		rd->s.max = rd->u.max;
 	} else
 		eval_smax_bound(rd, msk);
 
-	rd->s.max &= msk;
-	rd->s.min &= msk;
-
 	return NULL;
 }
 
@@ -1165,7 +1147,7 @@ eval_alu(struct bpf_verifier *bvf, const struct ebpf_insn *ins)
 	else if (op == BPF_MUL)
 		eval_mul(rd, &rs, opsz, msk);
 	else if (op == BPF_DIV || op == BPF_MOD)
-		err = eval_divmod(op, rd, &rs, opsz, msk);
+		err = eval_divmod(op, rd, &rs, msk);
 	else if (op == BPF_NEG)
 		eval_neg(rd, opsz, msk);
 	else if (op == EBPF_MOV)
-- 
2.43.0

