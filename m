Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3EDC55ABA
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Aug 2026 09:47:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8C7D40A79;
	Wed,  5 Aug 2026 11:47:09 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 8491940B8C
 for <dev@dpdk.org>; Wed,  5 Aug 2026 11:47:07 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=8DxIR4ZbCCUy9ibpHxec6V9NM+5HaERruUuMNZP+tbk=;
 b=hNtRbev8xgmtaQqJ0b+kNefruRpCEs+kXfa0dKZaCTkbLS8aOhC3FDS5KSJ20IWUgWMyObeZG
 +YrdIq3mimwwzKORpWTfUZFTyDwUIiLyAO1YBq/fO7o3yhV0v/eI+kZPTqPjMlwxlhyv8/ZRSzE
 /X47BaNY5EEATvHMRTSP5Ic=
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hFQXL6XxgzHnH3M;
 Wed,  5 Aug 2026 17:46:10 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id C09A540572;
 Wed,  5 Aug 2026 17:47:04 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Aug 2026 11:47:03 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>
CC: <dev@dpdk.org>, <stephen@networkplumber.org>, <thomas@monjalon.net>
Subject: [RFC 2/2] bpf: rename macros to match Linux kernel
Date: Wed, 5 Aug 2026 10:46:42 +0100
Message-ID: <20260805094642.52433-3-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805094642.52433-1-marat.khalili@huawei.com>
References: <20260805094642.52433-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500001.china.huawei.com (7.182.19.243) To
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

BPF opcode macro names had small deviations from the ones defined in
Linux headers, confusing humans and AI tools during code generation and
analysis, since both are mostly trained on the Linux spelling.

Rename them to match Linux counterparts.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_bpf.c          | 1606 +++++++++++++++++-----------------
 app/test/test_bpf_validate.c |  198 ++---
 lib/bpf/bpf_convert.c        |   40 +-
 lib/bpf/bpf_def.h            |   76 +-
 lib/bpf/bpf_dump.c           |   32 +-
 lib/bpf/bpf_exec.c           |  152 ++--
 lib/bpf/bpf_impl.h           |    2 +-
 lib/bpf/bpf_jit_arm64.c      |  214 ++---
 lib/bpf/bpf_jit_x86.c        |  310 +++----
 lib/bpf/bpf_load_elf.c       |   14 +-
 lib/bpf/bpf_validate.c       |  266 +++---
 lib/bpf/rte_bpf.h            |    2 +-
 12 files changed, 1453 insertions(+), 1459 deletions(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index bf3e4dd0c1de..8bf12e78cf87 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -103,7 +103,7 @@ test_exit_only(void)
 {
 	static const struct rte_ebpf_insn ins[] = {
 		{
-			.code = (BPF_JMP | EBPF_EXIT),
+			.code = (BPF_JMP | BPF_EXIT),
 		},
 	};
 	return bpf_load_test(RTE_DIM(ins), ins, EINVAL);
@@ -121,9 +121,9 @@ test_no_exit(void)
 	static const struct rte_ebpf_insn ins[] = {
 		{
 			/* Set return value to the program argument. */
-			.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-			.src_reg = EBPF_REG_1,
-			.dst_reg = EBPF_REG_0,
+			.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+			.src_reg = BPF_REG_1,
+			.dst_reg = BPF_REG_0,
 		},
 	};
 	return bpf_load_test(RTE_DIM(ins), ins, EINVAL);
@@ -140,12 +140,12 @@ test_minimal_working(void)
 	static const struct rte_ebpf_insn ins[] = {
 		{
 			/* Set return value to the program argument. */
-			.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-			.src_reg = EBPF_REG_1,
-			.dst_reg = EBPF_REG_0,
+			.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+			.src_reg = BPF_REG_1,
+			.dst_reg = BPF_REG_0,
 		},
 		{
-			.code = (BPF_JMP | EBPF_EXIT),
+			.code = (BPF_JMP | BPF_EXIT),
 		},
 	};
 	return bpf_load_test(RTE_DIM(ins), ins, 0);
@@ -162,18 +162,18 @@ test_add_one(void)
 	static const struct rte_ebpf_insn ins[] = {
 		{
 			/* Set return value to one. */
-			.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
-			.dst_reg = EBPF_REG_0,
+			.code = (BPF_ALU64 | BPF_MOV | BPF_K),
+			.dst_reg = BPF_REG_0,
 			.imm = 1,
 		},
 		{
 			/* Add program argument to the return value. */
-			.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
-			.src_reg = EBPF_REG_1,
-			.dst_reg = EBPF_REG_0,
+			.code = (BPF_ALU64 | BPF_ADD | BPF_X),
+			.src_reg = BPF_REG_1,
+			.dst_reg = BPF_REG_0,
 		},
 		{
-			.code = (BPF_JMP | EBPF_EXIT),
+			.code = (BPF_JMP | BPF_EXIT),
 		},
 	};
 	return bpf_load_test(RTE_DIM(ins), ins, 0);
@@ -190,18 +190,18 @@ test_subtract_one(void)
 	static const struct rte_ebpf_insn ins[] = {
 		{
 			/* Subtract one from the program argument. */
-			.code = (EBPF_ALU64 | BPF_SUB | BPF_K),
-			.dst_reg = EBPF_REG_1,
+			.code = (BPF_ALU64 | BPF_SUB | BPF_K),
+			.dst_reg = BPF_REG_1,
 			.imm = 1,
 		},
 		{
 			/* Set return value to the result. */
-			.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-			.src_reg = EBPF_REG_1,
-			.dst_reg = EBPF_REG_0,
+			.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+			.src_reg = BPF_REG_1,
+			.dst_reg = BPF_REG_0,
 		},
 		{
-			.code = (BPF_JMP | EBPF_EXIT),
+			.code = (BPF_JMP | BPF_EXIT),
 		},
 	};
 	return bpf_load_test(RTE_DIM(ins), ins, 0);
@@ -219,25 +219,25 @@ test_jump_over_invalid_first(void)
 		{
 			/* Jump over the next instruction for some r1. */
 			.code = (BPF_JMP | BPF_JEQ | BPF_K),
-			.dst_reg = EBPF_REG_1,
+			.dst_reg = BPF_REG_1,
 			.imm = 42,
 			.off = 1,
 		},
 		{
 			/* Write 0xDEADBEEF to [r1 + INT16_MIN]. */
-			.code = (BPF_ST | BPF_MEM | EBPF_DW),
-			.dst_reg = EBPF_REG_1,
+			.code = (BPF_ST | BPF_MEM | BPF_DW),
+			.dst_reg = BPF_REG_1,
 			.off = INT16_MIN,
 			.imm = 0xDEADBEEF,
 		},
 		{
 			/* Set return value to the program argument. */
-			.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-			.src_reg = EBPF_REG_1,
-			.dst_reg = EBPF_REG_0,
+			.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+			.src_reg = BPF_REG_1,
+			.dst_reg = BPF_REG_0,
 		},
 		{
-			.code = (BPF_JMP | EBPF_EXIT),
+			.code = (BPF_JMP | BPF_EXIT),
 		},
 	};
 	return bpf_load_test(RTE_DIM(ins), ins, EINVAL);
@@ -255,32 +255,32 @@ test_jump_over_invalid_non_first(void)
 	static const struct rte_ebpf_insn ins[] = {
 		{
 			/* Set return value to the program argument. */
-			.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-			.src_reg = EBPF_REG_1,
-			.dst_reg = EBPF_REG_0,
+			.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+			.src_reg = BPF_REG_1,
+			.dst_reg = BPF_REG_0,
 		},
 		{
 			/* Jump over the next instruction for some r1. */
 			.code = (BPF_JMP | BPF_JEQ | BPF_K),
-			.dst_reg = EBPF_REG_1,
+			.dst_reg = BPF_REG_1,
 			.imm = 42,
 			.off = 1,
 		},
 		{
 			/* Write 0xDEADBEEF to [r1 + INT16_MIN]. */
-			.code = (BPF_ST | BPF_MEM | EBPF_DW),
-			.dst_reg = EBPF_REG_1,
+			.code = (BPF_ST | BPF_MEM | BPF_DW),
+			.dst_reg = BPF_REG_1,
 			.off = INT16_MIN,
 			.imm = 0xDEADBEEF,
 		},
 		{
 			/* Set return value to the program argument. */
-			.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-			.src_reg = EBPF_REG_1,
-			.dst_reg = EBPF_REG_0,
+			.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+			.src_reg = BPF_REG_1,
+			.dst_reg = BPF_REG_0,
 		},
 		{
-			.code = (BPF_JMP | EBPF_EXIT),
+			.code = (BPF_JMP | BPF_EXIT),
 		},
 	};
 	return bpf_load_test(RTE_DIM(ins), ins, EINVAL);
@@ -405,36 +405,36 @@ dummy_prepare(void *arg)
 static const struct rte_ebpf_insn test_store1_prog[] = {
 	{
 		.code = (BPF_ST | BPF_MEM | BPF_B),
-		.dst_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_offset, u8),
 		.imm = TEST_FILL_1,
 	},
 	{
 		.code = (BPF_ST | BPF_MEM | BPF_H),
-		.dst_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_offset, u16),
 		.imm = TEST_FILL_1,
 	},
 	{
 		.code = (BPF_ST | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_offset, u32),
 		.imm = TEST_FILL_1,
 	},
 	{
-		.code = (BPF_ST | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
+		.code = (BPF_ST | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_offset, u64),
 		.imm = TEST_FILL_1,
 	},
 	/* return 1 */
 	{
-		.code = (BPF_ALU | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_0,
+		.code = (BPF_ALU | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_0,
 		.imm = 1,
 	},
 	{
-		.code = (BPF_JMP | EBPF_EXIT),
+		.code = (BPF_JMP | BPF_EXIT),
 	},
 };
 
@@ -468,42 +468,42 @@ test_store1_check(uint64_t rc, const void *arg)
 static const struct rte_ebpf_insn test_store2_prog[] = {
 
 	{
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_2,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_2,
 		.imm = TEST_FILL_1,
 	},
 	{
 		.code = (BPF_STX | BPF_MEM | BPF_B),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_2,
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_2,
 		.off = offsetof(struct dummy_offset, u8),
 	},
 	{
 		.code = (BPF_STX | BPF_MEM | BPF_H),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_2,
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_2,
 		.off = offsetof(struct dummy_offset, u16),
 	},
 	{
 		.code = (BPF_STX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_2,
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_2,
 		.off = offsetof(struct dummy_offset, u32),
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_2,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_2,
 		.off = offsetof(struct dummy_offset, u64),
 	},
 	/* return 1 */
 	{
-		.code = (BPF_ALU | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_0,
+		.code = (BPF_ALU | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_0,
 		.imm = 1,
 	},
 	{
-		.code = (BPF_JMP | EBPF_EXIT),
+		.code = (BPF_JMP | BPF_EXIT),
 	},
 };
 
@@ -512,46 +512,46 @@ static const struct rte_ebpf_insn test_load1_prog[] = {
 
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_B),
-		.dst_reg = EBPF_REG_2,
-		.src_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_2,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_offset, u8),
 	},
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_H),
-		.dst_reg = EBPF_REG_3,
-		.src_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_3,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_offset, u16),
 	},
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_4,
-		.src_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_4,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_offset, u32),
 	},
 	{
-		.code = (BPF_LDX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_0,
-		.src_reg = EBPF_REG_1,
+		.code = (BPF_LDX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_0,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_offset, u64),
 	},
 	/* return sum */
 	{
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
-		.dst_reg = EBPF_REG_0,
-		.src_reg = EBPF_REG_4,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_X),
+		.dst_reg = BPF_REG_0,
+		.src_reg = BPF_REG_4,
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
-		.dst_reg = EBPF_REG_0,
-		.src_reg = EBPF_REG_3,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_X),
+		.dst_reg = BPF_REG_0,
+		.src_reg = BPF_REG_3,
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
-		.dst_reg = EBPF_REG_0,
-		.src_reg = EBPF_REG_2,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_X),
+		.dst_reg = BPF_REG_0,
+		.src_reg = BPF_REG_2,
 	},
 	{
-		.code = (BPF_JMP | EBPF_EXIT),
+		.code = (BPF_JMP | BPF_EXIT),
 	},
 };
 
@@ -588,40 +588,40 @@ test_load1_check(uint64_t rc, const void *arg)
 static const struct rte_ebpf_insn test_ldimm1_prog[] = {
 
 	{
-		.code = (BPF_LD | BPF_IMM | EBPF_DW),
-		.dst_reg = EBPF_REG_0,
+		.code = (BPF_LD | BPF_IMM | BPF_DW),
+		.dst_reg = BPF_REG_0,
 		.imm = (uint32_t)TEST_IMM_1,
 	},
 	{
 		.imm = TEST_IMM_1 >> 32,
 	},
 	{
-		.code = (BPF_LD | BPF_IMM | EBPF_DW),
-		.dst_reg = EBPF_REG_3,
+		.code = (BPF_LD | BPF_IMM | BPF_DW),
+		.dst_reg = BPF_REG_3,
 		.imm = (uint32_t)TEST_IMM_2,
 	},
 	{
 		.imm = TEST_IMM_2 >> 32,
 	},
 	{
-		.code = (BPF_LD | BPF_IMM | EBPF_DW),
-		.dst_reg = EBPF_REG_5,
+		.code = (BPF_LD | BPF_IMM | BPF_DW),
+		.dst_reg = BPF_REG_5,
 		.imm = (uint32_t)TEST_IMM_3,
 	},
 	{
 		.imm = TEST_IMM_3 >> 32,
 	},
 	{
-		.code = (BPF_LD | BPF_IMM | EBPF_DW),
-		.dst_reg = EBPF_REG_7,
+		.code = (BPF_LD | BPF_IMM | BPF_DW),
+		.dst_reg = BPF_REG_7,
 		.imm = (uint32_t)TEST_IMM_4,
 	},
 	{
 		.imm = TEST_IMM_4 >> 32,
 	},
 	{
-		.code = (BPF_LD | BPF_IMM | EBPF_DW),
-		.dst_reg = EBPF_REG_9,
+		.code = (BPF_LD | BPF_IMM | BPF_DW),
+		.dst_reg = BPF_REG_9,
 		.imm = (uint32_t)TEST_IMM_5,
 	},
 	{
@@ -629,27 +629,27 @@ static const struct rte_ebpf_insn test_ldimm1_prog[] = {
 	},
 	/* return sum */
 	{
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
-		.dst_reg = EBPF_REG_0,
-		.src_reg = EBPF_REG_3,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_X),
+		.dst_reg = BPF_REG_0,
+		.src_reg = BPF_REG_3,
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
-		.dst_reg = EBPF_REG_0,
-		.src_reg = EBPF_REG_5,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_X),
+		.dst_reg = BPF_REG_0,
+		.src_reg = BPF_REG_5,
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
-		.dst_reg = EBPF_REG_0,
-		.src_reg = EBPF_REG_7,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_X),
+		.dst_reg = BPF_REG_0,
+		.src_reg = BPF_REG_7,
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
-		.dst_reg = EBPF_REG_0,
-		.src_reg = EBPF_REG_9,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_X),
+		.dst_reg = BPF_REG_0,
+		.src_reg = BPF_REG_9,
 	},
 	{
-		.code = (BPF_JMP | EBPF_EXIT),
+		.code = (BPF_JMP | BPF_EXIT),
 	},
 };
 
@@ -677,68 +677,68 @@ static const struct rte_ebpf_insn test_mul1_prog[] = {
 
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_2,
-		.src_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_2,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_vect8, in[0].u32),
 	},
 	{
-		.code = (BPF_LDX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_3,
-		.src_reg = EBPF_REG_1,
+		.code = (BPF_LDX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_3,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_vect8, in[1].u64),
 	},
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_4,
-		.src_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_4,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_vect8, in[2].u32),
 	},
 	{
 		.code = (BPF_ALU | BPF_MUL | BPF_K),
-		.dst_reg = EBPF_REG_2,
+		.dst_reg = BPF_REG_2,
 		.imm = TEST_MUL_1,
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_MUL | BPF_K),
-		.dst_reg = EBPF_REG_3,
+		.code = (BPF_ALU64 | BPF_MUL | BPF_K),
+		.dst_reg = BPF_REG_3,
 		.imm = TEST_MUL_2,
 	},
 	{
 		.code = (BPF_ALU | BPF_MUL | BPF_X),
-		.dst_reg = EBPF_REG_4,
-		.src_reg = EBPF_REG_2,
+		.dst_reg = BPF_REG_4,
+		.src_reg = BPF_REG_2,
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_MUL | BPF_X),
-		.dst_reg = EBPF_REG_4,
-		.src_reg = EBPF_REG_3,
+		.code = (BPF_ALU64 | BPF_MUL | BPF_X),
+		.dst_reg = BPF_REG_4,
+		.src_reg = BPF_REG_3,
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_2,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_2,
 		.off = offsetof(struct dummy_vect8, out[0].u64),
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_3,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_3,
 		.off = offsetof(struct dummy_vect8, out[1].u64),
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_4,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_4,
 		.off = offsetof(struct dummy_vect8, out[2].u64),
 	},
 	/* return 1 */
 	{
-		.code = (BPF_ALU | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_0,
+		.code = (BPF_ALU | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_0,
 		.imm = 1,
 	},
 	{
-		.code = (BPF_JMP | EBPF_EXIT),
+		.code = (BPF_JMP | BPF_EXIT),
 	},
 };
 
@@ -789,134 +789,134 @@ static const struct rte_ebpf_insn test_shift1_prog[] = {
 
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_2,
-		.src_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_2,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_vect8, in[0].u32),
 	},
 	{
-		.code = (BPF_LDX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_3,
-		.src_reg = EBPF_REG_1,
+		.code = (BPF_LDX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_3,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_vect8, in[1].u64),
 	},
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_4,
-		.src_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_4,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_vect8, in[2].u32),
 	},
 	{
 		.code = (BPF_ALU | BPF_LSH | BPF_K),
-		.dst_reg = EBPF_REG_2,
+		.dst_reg = BPF_REG_2,
 		.imm = TEST_SHIFT_1,
 	},
 	{
-		.code = (EBPF_ALU64 | EBPF_ARSH | BPF_K),
-		.dst_reg = EBPF_REG_3,
+		.code = (BPF_ALU64 | BPF_ARSH | BPF_K),
+		.dst_reg = BPF_REG_3,
 		.imm = TEST_SHIFT_2,
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_2,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_2,
 		.off = offsetof(struct dummy_vect8, out[0].u64),
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_3,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_3,
 		.off = offsetof(struct dummy_vect8, out[1].u64),
 	},
 	{
 		.code = (BPF_ALU | BPF_AND | BPF_K),
-		.dst_reg = EBPF_REG_4,
+		.dst_reg = BPF_REG_4,
 		.imm = TEST_SHIFT64_MASK,
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_LSH | BPF_X),
-		.dst_reg = EBPF_REG_3,
-		.src_reg = EBPF_REG_4,
+		.code = (BPF_ALU64 | BPF_LSH | BPF_X),
+		.dst_reg = BPF_REG_3,
+		.src_reg = BPF_REG_4,
 	},
 	{
 		.code = (BPF_ALU | BPF_AND | BPF_K),
-		.dst_reg = EBPF_REG_4,
+		.dst_reg = BPF_REG_4,
 		.imm = TEST_SHIFT32_MASK,
 	},
 	{
 		.code = (BPF_ALU | BPF_RSH | BPF_X),
-		.dst_reg = EBPF_REG_2,
-		.src_reg = EBPF_REG_4,
+		.dst_reg = BPF_REG_2,
+		.src_reg = BPF_REG_4,
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_2,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_2,
 		.off = offsetof(struct dummy_vect8, out[2].u64),
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_3,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_3,
 		.off = offsetof(struct dummy_vect8, out[3].u64),
 	},
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_2,
-		.src_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_2,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_vect8, in[0].u32),
 	},
 	{
-		.code = (BPF_LDX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_3,
-		.src_reg = EBPF_REG_1,
+		.code = (BPF_LDX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_3,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_vect8, in[1].u64),
 	},
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_4,
-		.src_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_4,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_vect8, in[2].u32),
 	},
 	{
 		.code = (BPF_ALU | BPF_AND | BPF_K),
-		.dst_reg = EBPF_REG_2,
+		.dst_reg = BPF_REG_2,
 		.imm = TEST_SHIFT64_MASK,
 	},
 	{
-		.code = (EBPF_ALU64 | EBPF_ARSH | BPF_X),
-		.dst_reg = EBPF_REG_3,
-		.src_reg = EBPF_REG_2,
+		.code = (BPF_ALU64 | BPF_ARSH | BPF_X),
+		.dst_reg = BPF_REG_3,
+		.src_reg = BPF_REG_2,
 	},
 	{
 		.code = (BPF_ALU | BPF_AND | BPF_K),
-		.dst_reg = EBPF_REG_2,
+		.dst_reg = BPF_REG_2,
 		.imm = TEST_SHIFT32_MASK,
 	},
 	{
 		.code = (BPF_ALU | BPF_LSH | BPF_X),
-		.dst_reg = EBPF_REG_4,
-		.src_reg = EBPF_REG_2,
+		.dst_reg = BPF_REG_4,
+		.src_reg = BPF_REG_2,
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_4,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_4,
 		.off = offsetof(struct dummy_vect8, out[4].u64),
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_3,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_3,
 		.off = offsetof(struct dummy_vect8, out[5].u64),
 	},
 	/* return 1 */
 	{
-		.code = (BPF_ALU | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_0,
+		.code = (BPF_ALU | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_0,
 		.imm = 1,
 	},
 	{
-		.code = (BPF_JMP | EBPF_EXIT),
+		.code = (BPF_JMP | BPF_EXIT),
 	},
 };
 
@@ -983,88 +983,88 @@ test_shift1_check(uint64_t rc, const void *arg)
 static const struct rte_ebpf_insn test_jump1_prog[] = {
 
 	[0] = {
-		.code = (BPF_ALU | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_0,
+		.code = (BPF_ALU | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_0,
 		.imm = 0,
 	},
 	[1] = {
 		.code = (BPF_LDX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_2,
-		.src_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_2,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_vect8, in[0].u32),
 	},
 	[2] = {
-		.code = (BPF_LDX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_3,
-		.src_reg = EBPF_REG_1,
+		.code = (BPF_LDX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_3,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_vect8, in[0].u64),
 	},
 	[3] = {
 		.code = (BPF_LDX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_4,
-		.src_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_4,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_vect8, in[1].u32),
 	},
 	[4] = {
-		.code = (BPF_LDX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_5,
-		.src_reg = EBPF_REG_1,
+		.code = (BPF_LDX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_5,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_vect8, in[1].u64),
 	},
 	[5] = {
 		.code = (BPF_JMP | BPF_JEQ | BPF_K),
-		.dst_reg = EBPF_REG_2,
+		.dst_reg = BPF_REG_2,
 		.imm = TEST_JCC_1,
 		.off = 8,
 	},
 	[6] = {
-		.code = (BPF_JMP | EBPF_JSLE | BPF_K),
-		.dst_reg = EBPF_REG_3,
+		.code = (BPF_JMP | BPF_JSLE | BPF_K),
+		.dst_reg = BPF_REG_3,
 		.imm = TEST_JCC_2,
 		.off = 9,
 	},
 	[7] = {
 		.code = (BPF_JMP | BPF_JGT | BPF_K),
-		.dst_reg = EBPF_REG_4,
+		.dst_reg = BPF_REG_4,
 		.imm = TEST_JCC_3,
 		.off = 10,
 	},
 	[8] = {
 		.code = (BPF_JMP | BPF_JSET | BPF_K),
-		.dst_reg = EBPF_REG_5,
+		.dst_reg = BPF_REG_5,
 		.imm = TEST_JCC_4,
 		.off = 11,
 	},
 	[9] = {
-		.code = (BPF_JMP | EBPF_JNE | BPF_X),
-		.dst_reg = EBPF_REG_2,
-		.src_reg = EBPF_REG_3,
+		.code = (BPF_JMP | BPF_JNE | BPF_X),
+		.dst_reg = BPF_REG_2,
+		.src_reg = BPF_REG_3,
 		.off = 12,
 	},
 	[10] = {
-		.code = (BPF_JMP | EBPF_JSGT | BPF_X),
-		.dst_reg = EBPF_REG_2,
-		.src_reg = EBPF_REG_4,
+		.code = (BPF_JMP | BPF_JSGT | BPF_X),
+		.dst_reg = BPF_REG_2,
+		.src_reg = BPF_REG_4,
 		.off = 13,
 	},
 	[11] = {
-		.code = (BPF_JMP | EBPF_JLE | BPF_X),
-		.dst_reg = EBPF_REG_2,
-		.src_reg = EBPF_REG_5,
+		.code = (BPF_JMP | BPF_JLE | BPF_X),
+		.dst_reg = BPF_REG_2,
+		.src_reg = BPF_REG_5,
 		.off = 14,
 	},
 	[12] = {
 		.code = (BPF_JMP | BPF_JSET | BPF_X),
-		.dst_reg = EBPF_REG_3,
-		.src_reg = EBPF_REG_5,
+		.dst_reg = BPF_REG_3,
+		.src_reg = BPF_REG_5,
 		.off = 15,
 	},
 	[13] = {
-		.code = (BPF_JMP | EBPF_EXIT),
+		.code = (BPF_JMP | BPF_EXIT),
 	},
 	[14] = {
-		.code = (EBPF_ALU64 | BPF_OR | BPF_K),
-		.dst_reg = EBPF_REG_0,
+		.code = (BPF_ALU64 | BPF_OR | BPF_K),
+		.dst_reg = BPF_REG_0,
 		.imm = 0x1,
 	},
 	[15] = {
@@ -1072,8 +1072,8 @@ static const struct rte_ebpf_insn test_jump1_prog[] = {
 		.off = -10,
 	},
 	[16] = {
-		.code = (EBPF_ALU64 | BPF_OR | BPF_K),
-		.dst_reg = EBPF_REG_0,
+		.code = (BPF_ALU64 | BPF_OR | BPF_K),
+		.dst_reg = BPF_REG_0,
 		.imm = 0x2,
 	},
 	[17] = {
@@ -1081,8 +1081,8 @@ static const struct rte_ebpf_insn test_jump1_prog[] = {
 		.off = -11,
 	},
 	[18] = {
-		.code = (EBPF_ALU64 | BPF_OR | BPF_K),
-		.dst_reg = EBPF_REG_0,
+		.code = (BPF_ALU64 | BPF_OR | BPF_K),
+		.dst_reg = BPF_REG_0,
 		.imm = 0x4,
 	},
 	[19] = {
@@ -1090,8 +1090,8 @@ static const struct rte_ebpf_insn test_jump1_prog[] = {
 		.off = -12,
 	},
 	[20] = {
-		.code = (EBPF_ALU64 | BPF_OR | BPF_K),
-		.dst_reg = EBPF_REG_0,
+		.code = (BPF_ALU64 | BPF_OR | BPF_K),
+		.dst_reg = BPF_REG_0,
 		.imm = 0x8,
 	},
 	[21] = {
@@ -1099,8 +1099,8 @@ static const struct rte_ebpf_insn test_jump1_prog[] = {
 		.off = -13,
 	},
 	[22] = {
-		.code = (EBPF_ALU64 | BPF_OR | BPF_K),
-		.dst_reg = EBPF_REG_0,
+		.code = (BPF_ALU64 | BPF_OR | BPF_K),
+		.dst_reg = BPF_REG_0,
 		.imm = 0x10,
 	},
 	[23] = {
@@ -1108,8 +1108,8 @@ static const struct rte_ebpf_insn test_jump1_prog[] = {
 		.off = -14,
 	},
 	[24] = {
-		.code = (EBPF_ALU64 | BPF_OR | BPF_K),
-		.dst_reg = EBPF_REG_0,
+		.code = (BPF_ALU64 | BPF_OR | BPF_K),
+		.dst_reg = BPF_REG_0,
 		.imm = 0x20,
 	},
 	[25] = {
@@ -1117,8 +1117,8 @@ static const struct rte_ebpf_insn test_jump1_prog[] = {
 		.off = -15,
 	},
 	[26] = {
-		.code = (EBPF_ALU64 | BPF_OR | BPF_K),
-		.dst_reg = EBPF_REG_0,
+		.code = (BPF_ALU64 | BPF_OR | BPF_K),
+		.dst_reg = BPF_REG_0,
 		.imm = 0x40,
 	},
 	[27] = {
@@ -1126,8 +1126,8 @@ static const struct rte_ebpf_insn test_jump1_prog[] = {
 		.off = -16,
 	},
 	[28] = {
-		.code = (EBPF_ALU64 | BPF_OR | BPF_K),
-		.dst_reg = EBPF_REG_0,
+		.code = (BPF_ALU64 | BPF_OR | BPF_K),
+		.dst_reg = BPF_REG_0,
 		.imm = 0x80,
 	},
 	[29] = {
@@ -1192,98 +1192,98 @@ test_jump1_check(uint64_t rc, const void *arg)
 static const struct rte_ebpf_insn test_jump2_prog[] = {
 
 	[0] = {
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_2,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_2,
 		.imm = 0xe,
 	},
 	[1] = {
 		.code = (BPF_LDX | BPF_MEM | BPF_H),
-		.dst_reg = EBPF_REG_3,
-		.src_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_3,
+		.src_reg = BPF_REG_1,
 		.off = 12,
 	},
 	[2] = {
-		.code = (BPF_JMP | EBPF_JNE | BPF_K),
-		.dst_reg = EBPF_REG_3,
+		.code = (BPF_JMP | BPF_JNE | BPF_K),
+		.dst_reg = BPF_REG_3,
 		.off = 2,
 		.imm = 0x81,
 	},
 	[3] = {
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_2,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_2,
 		.imm = 0x12,
 	},
 	[4] = {
 		.code = (BPF_LDX | BPF_MEM | BPF_H),
-		.dst_reg = EBPF_REG_3,
-		.src_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_3,
+		.src_reg = BPF_REG_1,
 		.off = 16,
 	},
 	[5] = {
-		.code = (EBPF_ALU64 | BPF_AND | BPF_K),
-		.dst_reg = EBPF_REG_3,
+		.code = (BPF_ALU64 | BPF_AND | BPF_K),
+		.dst_reg = BPF_REG_3,
 		.imm = 0xffff,
 	},
 	[6] = {
-		.code = (BPF_JMP | EBPF_JNE | BPF_K),
-		.dst_reg = EBPF_REG_3,
+		.code = (BPF_JMP | BPF_JNE | BPF_K),
+		.dst_reg = BPF_REG_3,
 		.off = 9,
 		.imm = 0x8,
 	},
 	[7] = {
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_2,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_X),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_2,
 	},
 	[8] = {
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_0,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_0,
 		.imm = 0,
 	},
 	[9] = {
 		.code = (BPF_LDX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_1,
 		.off = 16,
 	},
 	[10] = {
-		.code = (BPF_ALU | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_3,
+		.code = (BPF_ALU | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_3,
 		.imm = TEST_NETMASK,
 	},
 	[11] = {
-		.code = (BPF_ALU | EBPF_END | EBPF_TO_BE),
-		.dst_reg = EBPF_REG_3,
+		.code = (BPF_ALU | BPF_END | BPF_TO_BE),
+		.dst_reg = BPF_REG_3,
 		.imm = sizeof(uint32_t) * CHAR_BIT,
 	},
 	[12] = {
 		.code = (BPF_ALU | BPF_AND | BPF_X),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_3,
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_3,
 	},
 	[13] = {
-		.code = (BPF_ALU | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_3,
+		.code = (BPF_ALU | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_3,
 		.imm = TEST_SUBNET,
 	},
 	[14] = {
-		.code = (BPF_ALU | EBPF_END | EBPF_TO_BE),
-		.dst_reg = EBPF_REG_3,
+		.code = (BPF_ALU | BPF_END | BPF_TO_BE),
+		.dst_reg = BPF_REG_3,
 		.imm = sizeof(uint32_t) * CHAR_BIT,
 	},
 	[15] = {
 		.code = (BPF_JMP | BPF_JEQ | BPF_X),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_3,
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_3,
 		.off = 1,
 	},
 	[16] = {
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_0,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_0,
 		.imm = -1,
 	},
 	[17] = {
-		.code = (BPF_JMP | EBPF_EXIT),
+		.code = (BPF_JMP | BPF_EXIT),
 	},
 };
 
@@ -1358,137 +1358,137 @@ static const struct rte_ebpf_insn test_alu1_prog[] = {
 
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_2,
-		.src_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_2,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_vect8, in[0].u32),
 	},
 	{
-		.code = (BPF_LDX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_3,
-		.src_reg = EBPF_REG_1,
+		.code = (BPF_LDX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_3,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_vect8, in[0].u64),
 	},
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_4,
-		.src_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_4,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_vect8, in[1].u32),
 	},
 	{
-		.code = (BPF_LDX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_5,
-		.src_reg = EBPF_REG_1,
+		.code = (BPF_LDX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_5,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_vect8, in[1].u64),
 	},
 	{
 		.code = (BPF_ALU | BPF_AND | BPF_K),
-		.dst_reg = EBPF_REG_2,
+		.dst_reg = BPF_REG_2,
 		.imm = TEST_FILL_1,
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_OR | BPF_K),
-		.dst_reg = EBPF_REG_3,
+		.code = (BPF_ALU64 | BPF_OR | BPF_K),
+		.dst_reg = BPF_REG_3,
 		.imm = TEST_FILL_1,
 	},
 	{
 		.code = (BPF_ALU | BPF_XOR | BPF_K),
-		.dst_reg = EBPF_REG_4,
+		.dst_reg = BPF_REG_4,
 		.imm = TEST_FILL_1,
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_K),
-		.dst_reg = EBPF_REG_5,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_K),
+		.dst_reg = BPF_REG_5,
 		.imm = TEST_FILL_1,
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_2,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_2,
 		.off = offsetof(struct dummy_vect8, out[0].u64),
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_3,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_3,
 		.off = offsetof(struct dummy_vect8, out[1].u64),
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_4,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_4,
 		.off = offsetof(struct dummy_vect8, out[2].u64),
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_5,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_5,
 		.off = offsetof(struct dummy_vect8, out[3].u64),
 	},
 	{
 		.code = (BPF_ALU | BPF_OR | BPF_X),
-		.dst_reg = EBPF_REG_2,
-		.src_reg = EBPF_REG_3,
+		.dst_reg = BPF_REG_2,
+		.src_reg = BPF_REG_3,
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_XOR | BPF_X),
-		.dst_reg = EBPF_REG_3,
-		.src_reg = EBPF_REG_4,
+		.code = (BPF_ALU64 | BPF_XOR | BPF_X),
+		.dst_reg = BPF_REG_3,
+		.src_reg = BPF_REG_4,
 	},
 	{
 		.code = (BPF_ALU | BPF_SUB | BPF_X),
-		.dst_reg = EBPF_REG_4,
-		.src_reg = EBPF_REG_5,
+		.dst_reg = BPF_REG_4,
+		.src_reg = BPF_REG_5,
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_AND | BPF_X),
-		.dst_reg = EBPF_REG_5,
-		.src_reg = EBPF_REG_2,
+		.code = (BPF_ALU64 | BPF_AND | BPF_X),
+		.dst_reg = BPF_REG_5,
+		.src_reg = BPF_REG_2,
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_2,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_2,
 		.off = offsetof(struct dummy_vect8, out[4].u64),
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_3,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_3,
 		.off = offsetof(struct dummy_vect8, out[5].u64),
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_4,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_4,
 		.off = offsetof(struct dummy_vect8, out[6].u64),
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_5,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_5,
 		.off = offsetof(struct dummy_vect8, out[7].u64),
 	},
 	/* return (-r2 + (-r3)) */
 	{
 		.code = (BPF_ALU | BPF_NEG),
-		.dst_reg = EBPF_REG_2,
+		.dst_reg = BPF_REG_2,
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_NEG),
-		.dst_reg = EBPF_REG_3,
+		.code = (BPF_ALU64 | BPF_NEG),
+		.dst_reg = BPF_REG_3,
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
-		.dst_reg = EBPF_REG_2,
-		.src_reg = EBPF_REG_3,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_X),
+		.dst_reg = BPF_REG_2,
+		.src_reg = BPF_REG_3,
 	},
 	{
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-		.dst_reg = EBPF_REG_0,
-		.src_reg = EBPF_REG_2,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+		.dst_reg = BPF_REG_0,
+		.src_reg = BPF_REG_2,
 	},
 	{
-		.code = (BPF_JMP | EBPF_EXIT),
+		.code = (BPF_JMP | BPF_EXIT),
 	},
 };
 
@@ -1540,114 +1540,114 @@ static const struct rte_ebpf_insn test_bele1_prog[] = {
 
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_H),
-		.dst_reg = EBPF_REG_2,
-		.src_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_2,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_vect8, in[0].u16),
 	},
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_3,
-		.src_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_3,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_vect8, in[0].u32),
 	},
 	{
-		.code = (BPF_LDX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_4,
-		.src_reg = EBPF_REG_1,
+		.code = (BPF_LDX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_4,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_vect8, in[0].u64),
 	},
 	{
-		.code = (BPF_ALU | EBPF_END | EBPF_TO_BE),
-		.dst_reg = EBPF_REG_2,
+		.code = (BPF_ALU | BPF_END | BPF_TO_BE),
+		.dst_reg = BPF_REG_2,
 		.imm = sizeof(uint16_t) * CHAR_BIT,
 	},
 	{
-		.code = (BPF_ALU | EBPF_END | EBPF_TO_BE),
-		.dst_reg = EBPF_REG_3,
+		.code = (BPF_ALU | BPF_END | BPF_TO_BE),
+		.dst_reg = BPF_REG_3,
 		.imm = sizeof(uint32_t) * CHAR_BIT,
 	},
 	{
-		.code = (BPF_ALU | EBPF_END | EBPF_TO_BE),
-		.dst_reg = EBPF_REG_4,
+		.code = (BPF_ALU | BPF_END | BPF_TO_BE),
+		.dst_reg = BPF_REG_4,
 		.imm = sizeof(uint64_t) * CHAR_BIT,
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_2,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_2,
 		.off = offsetof(struct dummy_vect8, out[0].u64),
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_3,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_3,
 		.off = offsetof(struct dummy_vect8, out[1].u64),
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_4,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_4,
 		.off = offsetof(struct dummy_vect8, out[2].u64),
 	},
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_H),
-		.dst_reg = EBPF_REG_2,
-		.src_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_2,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_vect8, in[0].u16),
 	},
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_3,
-		.src_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_3,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_vect8, in[0].u32),
 	},
 	{
-		.code = (BPF_LDX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_4,
-		.src_reg = EBPF_REG_1,
+		.code = (BPF_LDX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_4,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_vect8, in[0].u64),
 	},
 	{
-		.code = (BPF_ALU | EBPF_END | EBPF_TO_LE),
-		.dst_reg = EBPF_REG_2,
+		.code = (BPF_ALU | BPF_END | BPF_TO_LE),
+		.dst_reg = BPF_REG_2,
 		.imm = sizeof(uint16_t) * CHAR_BIT,
 	},
 	{
-		.code = (BPF_ALU | EBPF_END | EBPF_TO_LE),
-		.dst_reg = EBPF_REG_3,
+		.code = (BPF_ALU | BPF_END | BPF_TO_LE),
+		.dst_reg = BPF_REG_3,
 		.imm = sizeof(uint32_t) * CHAR_BIT,
 	},
 	{
-		.code = (BPF_ALU | EBPF_END | EBPF_TO_LE),
-		.dst_reg = EBPF_REG_4,
+		.code = (BPF_ALU | BPF_END | BPF_TO_LE),
+		.dst_reg = BPF_REG_4,
 		.imm = sizeof(uint64_t) * CHAR_BIT,
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_2,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_2,
 		.off = offsetof(struct dummy_vect8, out[3].u64),
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_3,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_3,
 		.off = offsetof(struct dummy_vect8, out[4].u64),
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_4,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_4,
 		.off = offsetof(struct dummy_vect8, out[5].u64),
 	},
 	/* return 1 */
 	{
-		.code = (BPF_ALU | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_0,
+		.code = (BPF_ALU | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_0,
 		.imm = 1,
 	},
 	{
-		.code = (BPF_JMP | EBPF_EXIT),
+		.code = (BPF_JMP | BPF_EXIT),
 	},
 };
 
@@ -1705,132 +1705,132 @@ test_bele1_check(uint64_t rc, const void *arg)
 static const struct rte_ebpf_insn test_xadd1_prog[] = {
 
 	{
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_2,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_2,
 		.imm = 1,
 	},
 	{
-		.code = (BPF_STX | EBPF_XADD | BPF_W),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_2,
+		.code = (BPF_STX | BPF_XADD | BPF_W),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_2,
 		.off = offsetof(struct dummy_offset, u32),
 	},
 	{
-		.code = (BPF_STX | EBPF_XADD | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_2,
+		.code = (BPF_STX | BPF_XADD | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_2,
 		.off = offsetof(struct dummy_offset, u64),
 	},
 	{
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_3,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_3,
 		.imm = -1,
 	},
 	{
-		.code = (BPF_STX | EBPF_XADD | BPF_W),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_3,
+		.code = (BPF_STX | BPF_XADD | BPF_W),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_3,
 		.off = offsetof(struct dummy_offset, u32),
 	},
 	{
-		.code = (BPF_STX | EBPF_XADD | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_3,
+		.code = (BPF_STX | BPF_XADD | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_3,
 		.off = offsetof(struct dummy_offset, u64),
 	},
 	{
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_4,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_4,
 		.imm = TEST_FILL_1,
 	},
 	{
-		.code = (BPF_STX | EBPF_XADD | BPF_W),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_4,
+		.code = (BPF_STX | BPF_XADD | BPF_W),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_4,
 		.off = offsetof(struct dummy_offset, u32),
 	},
 	{
-		.code = (BPF_STX | EBPF_XADD | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_4,
+		.code = (BPF_STX | BPF_XADD | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_4,
 		.off = offsetof(struct dummy_offset, u64),
 	},
 	{
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_5,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_5,
 		.imm = TEST_MUL_1,
 	},
 	{
-		.code = (BPF_STX | EBPF_XADD | BPF_W),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_5,
+		.code = (BPF_STX | BPF_XADD | BPF_W),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_5,
 		.off = offsetof(struct dummy_offset, u32),
 	},
 	{
-		.code = (BPF_STX | EBPF_XADD | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_5,
+		.code = (BPF_STX | BPF_XADD | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_5,
 		.off = offsetof(struct dummy_offset, u64),
 	},
 	{
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_6,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_6,
 		.imm = TEST_MUL_2,
 	},
 	{
-		.code = (BPF_STX | EBPF_XADD | BPF_W),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_6,
+		.code = (BPF_STX | BPF_XADD | BPF_W),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_6,
 		.off = offsetof(struct dummy_offset, u32),
 	},
 	{
-		.code = (BPF_STX | EBPF_XADD | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_6,
+		.code = (BPF_STX | BPF_XADD | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_6,
 		.off = offsetof(struct dummy_offset, u64),
 	},
 	{
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_7,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_7,
 		.imm = TEST_JCC_2,
 	},
 	{
-		.code = (BPF_STX | EBPF_XADD | BPF_W),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_7,
+		.code = (BPF_STX | BPF_XADD | BPF_W),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_7,
 		.off = offsetof(struct dummy_offset, u32),
 	},
 	{
-		.code = (BPF_STX | EBPF_XADD | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_7,
+		.code = (BPF_STX | BPF_XADD | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_7,
 		.off = offsetof(struct dummy_offset, u64),
 	},
 	{
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_8,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_8,
 		.imm = TEST_JCC_3,
 	},
 	{
-		.code = (BPF_STX | EBPF_XADD | BPF_W),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_8,
+		.code = (BPF_STX | BPF_XADD | BPF_W),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_8,
 		.off = offsetof(struct dummy_offset, u32),
 	},
 	{
-		.code = (BPF_STX | EBPF_XADD | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_8,
+		.code = (BPF_STX | BPF_XADD | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_8,
 		.off = offsetof(struct dummy_offset, u64),
 	},
 	/* return 1 */
 	{
-		.code = (BPF_ALU | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_0,
+		.code = (BPF_ALU | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_0,
 		.imm = 1,
 	},
 	{
-		.code = (BPF_JMP | EBPF_EXIT),
+		.code = (BPF_JMP | BPF_EXIT),
 	},
 };
 
@@ -1894,90 +1894,90 @@ static const struct rte_ebpf_insn test_div1_prog[] = {
 
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_2,
-		.src_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_2,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_vect8, in[0].u32),
 	},
 	{
-		.code = (BPF_LDX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_3,
-		.src_reg = EBPF_REG_1,
+		.code = (BPF_LDX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_3,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_vect8, in[1].u64),
 	},
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_4,
-		.src_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_4,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_vect8, in[2].u32),
 	},
 	{
 		.code = (BPF_ALU | BPF_DIV | BPF_K),
-		.dst_reg = EBPF_REG_2,
+		.dst_reg = BPF_REG_2,
 		.imm = TEST_MUL_1,
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_MOD | BPF_K),
-		.dst_reg = EBPF_REG_3,
+		.code = (BPF_ALU64 | BPF_MOD | BPF_K),
+		.dst_reg = BPF_REG_3,
 		.imm = TEST_MUL_2,
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_OR | BPF_K),
-		.dst_reg = EBPF_REG_2,
+		.code = (BPF_ALU64 | BPF_OR | BPF_K),
+		.dst_reg = BPF_REG_2,
 		.imm = 1,
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_OR | BPF_K),
-		.dst_reg = EBPF_REG_3,
+		.code = (BPF_ALU64 | BPF_OR | BPF_K),
+		.dst_reg = BPF_REG_3,
 		.imm = 1,
 	},
 	{
 		.code = (BPF_ALU | BPF_MOD | BPF_X),
-		.dst_reg = EBPF_REG_4,
-		.src_reg = EBPF_REG_2,
+		.dst_reg = BPF_REG_4,
+		.src_reg = BPF_REG_2,
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_DIV | BPF_X),
-		.dst_reg = EBPF_REG_4,
-		.src_reg = EBPF_REG_3,
+		.code = (BPF_ALU64 | BPF_DIV | BPF_X),
+		.dst_reg = BPF_REG_4,
+		.src_reg = BPF_REG_3,
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_2,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_2,
 		.off = offsetof(struct dummy_vect8, out[0].u64),
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_3,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_3,
 		.off = offsetof(struct dummy_vect8, out[1].u64),
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_4,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_4,
 		.off = offsetof(struct dummy_vect8, out[2].u64),
 	},
 	/* check that we can handle division by zero gracefully. */
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_2,
-		.src_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_2,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_vect8, in[3].u32),
 	},
 	{
 		.code = (BPF_ALU | BPF_DIV | BPF_X),
-		.dst_reg = EBPF_REG_4,
-		.src_reg = EBPF_REG_2,
+		.dst_reg = BPF_REG_4,
+		.src_reg = BPF_REG_2,
 	},
 	/* return 1 */
 	{
-		.code = (BPF_ALU | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_0,
+		.code = (BPF_ALU | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_0,
 		.imm = 1,
 	},
 	{
-		.code = (BPF_JMP | EBPF_EXIT),
+		.code = (BPF_JMP | BPF_EXIT),
 	},
 };
 
@@ -2018,71 +2018,71 @@ static const struct rte_ebpf_insn test_call1_prog[] = {
 
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_2,
-		.src_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_2,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_offset, u32),
 	},
 	{
-		.code = (BPF_LDX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_3,
-		.src_reg = EBPF_REG_1,
+		.code = (BPF_LDX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_3,
+		.src_reg = BPF_REG_1,
 		.off = offsetof(struct dummy_offset, u64),
 	},
 	{
 		.code = (BPF_STX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_10,
-		.src_reg = EBPF_REG_2,
+		.dst_reg = BPF_REG_10,
+		.src_reg = BPF_REG_2,
 		.off = -4,
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_10,
-		.src_reg = EBPF_REG_3,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_10,
+		.src_reg = BPF_REG_3,
 		.off = -16,
 	},
 	{
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-		.dst_reg = EBPF_REG_2,
-		.src_reg = EBPF_REG_10,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+		.dst_reg = BPF_REG_2,
+		.src_reg = BPF_REG_10,
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_SUB | BPF_K),
-		.dst_reg = EBPF_REG_2,
+		.code = (BPF_ALU64 | BPF_SUB | BPF_K),
+		.dst_reg = BPF_REG_2,
 		.imm = 4,
 	},
 	{
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-		.dst_reg = EBPF_REG_3,
-		.src_reg = EBPF_REG_10,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+		.dst_reg = BPF_REG_3,
+		.src_reg = BPF_REG_10,
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_SUB | BPF_K),
-		.dst_reg = EBPF_REG_3,
+		.code = (BPF_ALU64 | BPF_SUB | BPF_K),
+		.dst_reg = BPF_REG_3,
 		.imm = 16,
 	},
 	{
-		.code = (BPF_JMP | EBPF_CALL),
+		.code = (BPF_JMP | BPF_CALL),
 		.imm = 0,
 	},
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_2,
-		.src_reg = EBPF_REG_10,
+		.dst_reg = BPF_REG_2,
+		.src_reg = BPF_REG_10,
 		.off = -4,
 	},
 	{
-		.code = (BPF_LDX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_0,
-		.src_reg = EBPF_REG_10,
+		.code = (BPF_LDX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_0,
+		.src_reg = BPF_REG_10,
 		.off = -16
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
-		.dst_reg = EBPF_REG_0,
-		.src_reg = EBPF_REG_2,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_X),
+		.dst_reg = BPF_REG_0,
+		.src_reg = BPF_REG_2,
 	},
 	{
-		.code = (BPF_JMP | EBPF_EXIT),
+		.code = (BPF_JMP | BPF_EXIT),
 	},
 };
 
@@ -2142,74 +2142,74 @@ static const struct rte_bpf_xsym test_call1_xsym[] = {
 static const struct rte_ebpf_insn test_call2_prog[] = {
 
 	{
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_10,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_10,
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_K),
-		.dst_reg = EBPF_REG_1,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_K),
+		.dst_reg = BPF_REG_1,
 		.imm = -(int32_t)sizeof(struct dummy_offset),
 	},
 	{
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-		.dst_reg = EBPF_REG_2,
-		.src_reg = EBPF_REG_10,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+		.dst_reg = BPF_REG_2,
+		.src_reg = BPF_REG_10,
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_K),
-		.dst_reg = EBPF_REG_2,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_K),
+		.dst_reg = BPF_REG_2,
 		.imm = -2 * (int32_t)sizeof(struct dummy_offset),
 	},
 	{
-		.code = (BPF_JMP | EBPF_CALL),
+		.code = (BPF_JMP | BPF_CALL),
 		.imm = 0,
 	},
 	{
-		.code = (BPF_LDX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_10,
+		.code = (BPF_LDX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_10,
 		.off = -(int32_t)(sizeof(struct dummy_offset) -
 			offsetof(struct dummy_offset, u64)),
 	},
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_0,
-		.src_reg = EBPF_REG_10,
+		.dst_reg = BPF_REG_0,
+		.src_reg = BPF_REG_10,
 		.off = -(int32_t)(sizeof(struct dummy_offset) -
 			offsetof(struct dummy_offset, u32)),
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
-		.dst_reg = EBPF_REG_0,
-		.src_reg = EBPF_REG_1,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_X),
+		.dst_reg = BPF_REG_0,
+		.src_reg = BPF_REG_1,
 	},
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_H),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_10,
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_10,
 		.off = -(int32_t)(2 * sizeof(struct dummy_offset) -
 			offsetof(struct dummy_offset, u16)),
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
-		.dst_reg = EBPF_REG_0,
-		.src_reg = EBPF_REG_1,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_X),
+		.dst_reg = BPF_REG_0,
+		.src_reg = BPF_REG_1,
 	},
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_B),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_10,
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_10,
 		.off = -(int32_t)(2 * sizeof(struct dummy_offset) -
 			offsetof(struct dummy_offset, u8)),
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
-		.dst_reg = EBPF_REG_0,
-		.src_reg = EBPF_REG_1,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_X),
+		.dst_reg = BPF_REG_0,
+		.src_reg = BPF_REG_1,
 	},
 	{
-		.code = (BPF_JMP | EBPF_EXIT),
+		.code = (BPF_JMP | BPF_EXIT),
 	},
 
 };
@@ -2268,51 +2268,51 @@ static const struct rte_bpf_xsym test_call2_xsym[] = {
 static const struct rte_ebpf_insn test_call3_prog[] = {
 
 	{
-		.code = (BPF_JMP | EBPF_CALL),
+		.code = (BPF_JMP | BPF_CALL),
 		.imm = 0,
 	},
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_B),
-		.dst_reg = EBPF_REG_2,
-		.src_reg = EBPF_REG_0,
+		.dst_reg = BPF_REG_2,
+		.src_reg = BPF_REG_0,
 		.off = offsetof(struct dummy_offset, u8),
 	},
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_H),
-		.dst_reg = EBPF_REG_3,
-		.src_reg = EBPF_REG_0,
+		.dst_reg = BPF_REG_3,
+		.src_reg = BPF_REG_0,
 		.off = offsetof(struct dummy_offset, u16),
 	},
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_4,
-		.src_reg = EBPF_REG_0,
+		.dst_reg = BPF_REG_4,
+		.src_reg = BPF_REG_0,
 		.off = offsetof(struct dummy_offset, u32),
 	},
 	{
-		.code = (BPF_LDX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_0,
-		.src_reg = EBPF_REG_0,
+		.code = (BPF_LDX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_0,
+		.src_reg = BPF_REG_0,
 		.off = offsetof(struct dummy_offset, u64),
 	},
 	/* return sum */
 	{
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
-		.dst_reg = EBPF_REG_0,
-		.src_reg = EBPF_REG_4,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_X),
+		.dst_reg = BPF_REG_0,
+		.src_reg = BPF_REG_4,
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
-		.dst_reg = EBPF_REG_0,
-		.src_reg = EBPF_REG_3,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_X),
+		.dst_reg = BPF_REG_0,
+		.src_reg = BPF_REG_3,
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
-		.dst_reg = EBPF_REG_0,
-		.src_reg = EBPF_REG_2,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_X),
+		.dst_reg = BPF_REG_0,
+		.src_reg = BPF_REG_2,
 	},
 	{
-		.code = (BPF_JMP | EBPF_EXIT),
+		.code = (BPF_JMP | BPF_EXIT),
 	},
 };
 
@@ -2381,82 +2381,82 @@ static const struct rte_bpf_xsym test_call3_xsym[] = {
 static const struct rte_ebpf_insn test_call4_prog[] = {
 	{
 		.code = (BPF_ST | BPF_MEM | BPF_B),
-		.dst_reg = EBPF_REG_10,
+		.dst_reg = BPF_REG_10,
 		.off = -4,
 		.imm = 1,
 	},
 	{
 		.code = (BPF_ST | BPF_MEM | BPF_B),
-		.dst_reg = EBPF_REG_10,
+		.dst_reg = BPF_REG_10,
 		.off = -3,
 		.imm = 2,
 	},
 	{
 		.code = (BPF_ST | BPF_MEM | BPF_B),
-		.dst_reg = EBPF_REG_10,
+		.dst_reg = BPF_REG_10,
 		.off = -2,
 		.imm = 3,
 	},
 	{
 		.code = (BPF_ST | BPF_MEM | BPF_B),
-		.dst_reg = EBPF_REG_10,
+		.dst_reg = BPF_REG_10,
 		.off = -1,
 		.imm = 4,
 	},
 	{
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_10,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_10,
 	},
 	{
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_2,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_2,
 		.imm = 4,
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_SUB | BPF_X),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_2,
+		.code = (BPF_ALU64 | BPF_SUB | BPF_X),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_2,
 	},
 	{
-		.code = (BPF_JMP | EBPF_CALL),
+		.code = (BPF_JMP | BPF_CALL),
 		.imm = 0,
 	},
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_B),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_10,
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_10,
 		.off = -4,
 	},
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_B),
-		.dst_reg = EBPF_REG_2,
-		.src_reg = EBPF_REG_10,
+		.dst_reg = BPF_REG_2,
+		.src_reg = BPF_REG_10,
 		.off = -3,
 	},
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_B),
-		.dst_reg = EBPF_REG_3,
-		.src_reg = EBPF_REG_10,
+		.dst_reg = BPF_REG_3,
+		.src_reg = BPF_REG_10,
 		.off = -2,
 	},
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_B),
-		.dst_reg = EBPF_REG_4,
-		.src_reg = EBPF_REG_10,
+		.dst_reg = BPF_REG_4,
+		.src_reg = BPF_REG_10,
 		.off = -1,
 	},
 	{
-		.code = (BPF_JMP | EBPF_CALL),
+		.code = (BPF_JMP | BPF_CALL),
 		.imm = 1,
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_XOR | BPF_K),
-		.dst_reg = EBPF_REG_0,
+		.code = (BPF_ALU64 | BPF_XOR | BPF_K),
+		.dst_reg = BPF_REG_0,
 		.imm = TEST_MEMFROB,
 	},
 	{
-		.code = (BPF_JMP | EBPF_EXIT),
+		.code = (BPF_JMP | BPF_EXIT),
 	},
 };
 
@@ -2554,146 +2554,146 @@ static const struct rte_bpf_xsym test_call4_xsym[] = {
 static const struct rte_ebpf_insn test_call5_prog[] = {
 
 	[0] = {
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_1,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_1,
 		.imm = STRING_GEEK,
 	},
 	[1] = {
 		.code = (BPF_STX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_10,
-		.src_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_10,
+		.src_reg = BPF_REG_1,
 		.off = -8,
 	},
 	[2] = {
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_6,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_6,
 		.imm = 0,
 	},
 	[3] = {
 		.code = (BPF_STX | BPF_MEM | BPF_B),
-		.dst_reg = EBPF_REG_10,
-		.src_reg = EBPF_REG_6,
+		.dst_reg = BPF_REG_10,
+		.src_reg = BPF_REG_6,
 		.off = -4,
 	},
 	[4] = {
 		.code = (BPF_STX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_10,
-		.src_reg = EBPF_REG_6,
+		.dst_reg = BPF_REG_10,
+		.src_reg = BPF_REG_6,
 		.off = -12,
 	},
 	[5] = {
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_1,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_1,
 		.imm = STRING_WEEK,
 	},
 	[6] = {
 		.code = (BPF_STX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_10,
-		.src_reg = EBPF_REG_1,
+		.dst_reg = BPF_REG_10,
+		.src_reg = BPF_REG_1,
 		.off = -16,
 	},
 	[7] = {
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_10,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_10,
 	},
 	[8] = {
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_K),
-		.dst_reg = EBPF_REG_1,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_K),
+		.dst_reg = BPF_REG_1,
 		.imm = -8,
 	},
 	[9] = {
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-		.dst_reg = EBPF_REG_2,
-		.src_reg = EBPF_REG_1,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+		.dst_reg = BPF_REG_2,
+		.src_reg = BPF_REG_1,
 	},
 	[10] = {
-		.code = (BPF_JMP | EBPF_CALL),
+		.code = (BPF_JMP | BPF_CALL),
 		.imm = 0,
 	},
 	[11] = {
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_0,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_0,
 	},
 	[12] = {
-		.code = (BPF_ALU | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_0,
+		.code = (BPF_ALU | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_0,
 		.imm = -1,
 	},
 	[13] = {
-		.code = (EBPF_ALU64 | BPF_LSH | BPF_K),
-		.dst_reg = EBPF_REG_1,
+		.code = (BPF_ALU64 | BPF_LSH | BPF_K),
+		.dst_reg = BPF_REG_1,
 		.imm = 0x20,
 	},
 	[14] = {
-		.code = (EBPF_ALU64 | BPF_RSH | BPF_K),
-		.dst_reg = EBPF_REG_1,
+		.code = (BPF_ALU64 | BPF_RSH | BPF_K),
+		.dst_reg = BPF_REG_1,
 		.imm = 0x20,
 	},
 	[15] = {
-		.code = (BPF_JMP | EBPF_JNE | BPF_K),
-		.dst_reg = EBPF_REG_1,
+		.code = (BPF_JMP | BPF_JNE | BPF_K),
+		.dst_reg = BPF_REG_1,
 		.off = 11,
 		.imm = 0,
 	},
 	[16] = {
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_10,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_10,
 	},
 	[17] = {
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_K),
-		.dst_reg = EBPF_REG_1,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_K),
+		.dst_reg = BPF_REG_1,
 		.imm = -8,
 	},
 	[18] = {
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-		.dst_reg = EBPF_REG_2,
-		.src_reg = EBPF_REG_10,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+		.dst_reg = BPF_REG_2,
+		.src_reg = BPF_REG_10,
 	},
 	[19] = {
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_K),
-		.dst_reg = EBPF_REG_2,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_K),
+		.dst_reg = BPF_REG_2,
 		.imm = -16,
 	},
 	[20] = {
-		.code = (BPF_JMP | EBPF_CALL),
+		.code = (BPF_JMP | BPF_CALL),
 		.imm = 0,
 	},
 	[21] = {
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_0,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_0,
 	},
 	[22] = {
-		.code = (EBPF_ALU64 | BPF_LSH | BPF_K),
-		.dst_reg = EBPF_REG_1,
+		.code = (BPF_ALU64 | BPF_LSH | BPF_K),
+		.dst_reg = BPF_REG_1,
 		.imm = 0x20,
 	},
 	[23] = {
-		.code = (EBPF_ALU64 | BPF_RSH | BPF_K),
-		.dst_reg = EBPF_REG_1,
+		.code = (BPF_ALU64 | BPF_RSH | BPF_K),
+		.dst_reg = BPF_REG_1,
 		.imm = 0x20,
 	},
 	[24] = {
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-		.dst_reg = EBPF_REG_0,
-		.src_reg = EBPF_REG_1,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+		.dst_reg = BPF_REG_0,
+		.src_reg = BPF_REG_1,
 	},
 	[25] = {
 		.code = (BPF_JMP | BPF_JEQ | BPF_X),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_6,
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_6,
 		.off = 1,
 	},
 	[26] = {
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
-		.dst_reg = EBPF_REG_0,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_K),
+		.dst_reg = BPF_REG_0,
 		.imm = 0,
 	},
 	[27] = {
-		.code = (BPF_JMP | EBPF_EXIT),
+		.code = (BPF_JMP | BPF_EXIT),
 	},
 };
 
@@ -2763,9 +2763,9 @@ static const struct rte_ebpf_insn test_ld_mbuf1_prog[] = {
 
 	/* BPF_ABS/BPF_IND implicitly expect mbuf ptr in R6 */
 	{
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-		.dst_reg = EBPF_REG_6,
-		.src_reg = EBPF_REG_1,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+		.dst_reg = BPF_REG_6,
+		.src_reg = BPF_REG_1,
 	},
 	/* load IPv4 version and IHL */
 	{
@@ -2774,50 +2774,50 @@ static const struct rte_ebpf_insn test_ld_mbuf1_prog[] = {
 	},
 	/* check IP version */
 	{
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-		.dst_reg = EBPF_REG_2,
-		.src_reg = EBPF_REG_0,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+		.dst_reg = BPF_REG_2,
+		.src_reg = BPF_REG_0,
 	},
 	{
 		.code = (BPF_ALU | BPF_AND | BPF_K),
-		.dst_reg = EBPF_REG_2,
+		.dst_reg = BPF_REG_2,
 		.imm = 0xf0,
 	},
 	{
 		.code = (BPF_JMP | BPF_JEQ | BPF_K),
-		.dst_reg = EBPF_REG_2,
+		.dst_reg = BPF_REG_2,
 		.imm = IPVERSION << 4,
 		.off = 2,
 	},
 	/* invalid IP version, return 0 */
 	{
-		.code = (EBPF_ALU64 | BPF_XOR | BPF_X),
-		.dst_reg = EBPF_REG_0,
-		.src_reg = EBPF_REG_0,
+		.code = (BPF_ALU64 | BPF_XOR | BPF_X),
+		.dst_reg = BPF_REG_0,
+		.src_reg = BPF_REG_0,
 	},
 	{
-		.code = (BPF_JMP | EBPF_EXIT),
+		.code = (BPF_JMP | BPF_EXIT),
 	},
 	/* load 3-rd byte of IP data */
 	{
 		.code = (BPF_ALU | BPF_AND | BPF_K),
-		.dst_reg = EBPF_REG_0,
+		.dst_reg = BPF_REG_0,
 		.imm = RTE_IPV4_HDR_IHL_MASK,
 	},
 	{
 		.code = (BPF_ALU | BPF_LSH | BPF_K),
-		.dst_reg = EBPF_REG_0,
+		.dst_reg = BPF_REG_0,
 		.imm = 2,
 	},
 	{
 		.code = (BPF_LD | BPF_IND | BPF_B),
-		.src_reg = EBPF_REG_0,
+		.src_reg = BPF_REG_0,
 		.imm = 3,
 	},
 	{
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-		.dst_reg = EBPF_REG_7,
-		.src_reg = EBPF_REG_0,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+		.dst_reg = BPF_REG_7,
+		.src_reg = BPF_REG_0,
 	},
 	/* load IPv4 src addr */
 	{
@@ -2825,9 +2825,9 @@ static const struct rte_ebpf_insn test_ld_mbuf1_prog[] = {
 		.imm = offsetof(struct rte_ipv4_hdr, src_addr),
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
-		.dst_reg = EBPF_REG_7,
-		.src_reg = EBPF_REG_0,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_X),
+		.dst_reg = BPF_REG_7,
+		.src_reg = BPF_REG_0,
 	},
 	/* load IPv4 total length */
 	{
@@ -2835,38 +2835,38 @@ static const struct rte_ebpf_insn test_ld_mbuf1_prog[] = {
 		.imm = offsetof(struct rte_ipv4_hdr, total_length),
 	},
 	{
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-		.dst_reg = EBPF_REG_8,
-		.src_reg = EBPF_REG_0,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+		.dst_reg = BPF_REG_8,
+		.src_reg = BPF_REG_0,
 	},
 	/* load last 4 bytes of IP data */
 	{
 		.code = (BPF_LD | BPF_IND | BPF_W),
-		.src_reg = EBPF_REG_8,
+		.src_reg = BPF_REG_8,
 		.imm = -(int32_t)sizeof(uint32_t),
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
-		.dst_reg = EBPF_REG_7,
-		.src_reg = EBPF_REG_0,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_X),
+		.dst_reg = BPF_REG_7,
+		.src_reg = BPF_REG_0,
 	},
 	/* load 2 bytes from the middle of IP data */
 	{
-		.code = (EBPF_ALU64 | BPF_RSH | BPF_K),
-		.dst_reg = EBPF_REG_8,
+		.code = (BPF_ALU64 | BPF_RSH | BPF_K),
+		.dst_reg = BPF_REG_8,
 		.imm = 1,
 	},
 	{
 		.code = (BPF_LD | BPF_IND | BPF_H),
-		.src_reg = EBPF_REG_8,
+		.src_reg = BPF_REG_8,
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
-		.dst_reg = EBPF_REG_0,
-		.src_reg = EBPF_REG_7,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_X),
+		.dst_reg = BPF_REG_0,
+		.src_reg = BPF_REG_7,
 	},
 	{
-		.code = (BPF_JMP | EBPF_EXIT),
+		.code = (BPF_JMP | BPF_EXIT),
 	},
 };
 
@@ -3021,9 +3021,9 @@ static const struct rte_ebpf_insn test_ld_mbuf3_prog[] = {
 
 	/* BPF_ABS/BPF_IND implicitly expect mbuf ptr in R6 */
 	{
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-		.dst_reg = EBPF_REG_6,
-		.src_reg = EBPF_REG_1,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+		.dst_reg = BPF_REG_6,
+		.src_reg = BPF_REG_1,
 	},
 	/* load IPv4 version and IHL */
 	{
@@ -3032,50 +3032,50 @@ static const struct rte_ebpf_insn test_ld_mbuf3_prog[] = {
 	},
 	/* check IP version */
 	{
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-		.dst_reg = EBPF_REG_2,
-		.src_reg = EBPF_REG_0,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+		.dst_reg = BPF_REG_2,
+		.src_reg = BPF_REG_0,
 	},
 	{
 		.code = (BPF_ALU | BPF_AND | BPF_K),
-		.dst_reg = EBPF_REG_2,
+		.dst_reg = BPF_REG_2,
 		.imm = 0xf0,
 	},
 	{
 		.code = (BPF_JMP | BPF_JEQ | BPF_K),
-		.dst_reg = EBPF_REG_2,
+		.dst_reg = BPF_REG_2,
 		.imm = IPVERSION << 4,
 		.off = 2,
 	},
 	/* invalid IP version, return 0 */
 	{
-		.code = (EBPF_ALU64 | BPF_XOR | BPF_X),
-		.dst_reg = EBPF_REG_0,
-		.src_reg = EBPF_REG_0,
+		.code = (BPF_ALU64 | BPF_XOR | BPF_X),
+		.dst_reg = BPF_REG_0,
+		.src_reg = BPF_REG_0,
 	},
 	{
-		.code = (BPF_JMP | EBPF_EXIT),
+		.code = (BPF_JMP | BPF_EXIT),
 	},
 	/* load 3-rd byte of IP data */
 	{
 		.code = (BPF_ALU | BPF_AND | BPF_K),
-		.dst_reg = EBPF_REG_0,
+		.dst_reg = BPF_REG_0,
 		.imm = RTE_IPV4_HDR_IHL_MASK,
 	},
 	{
 		.code = (BPF_ALU | BPF_LSH | BPF_K),
-		.dst_reg = EBPF_REG_0,
+		.dst_reg = BPF_REG_0,
 		.imm = 2,
 	},
 	{
 		.code = (BPF_LD | BPF_IND | BPF_B),
-		.src_reg = EBPF_REG_0,
+		.src_reg = BPF_REG_0,
 		.imm = 3,
 	},
 	{
 		.code = (BPF_STX | BPF_MEM | BPF_B),
-		.dst_reg = EBPF_REG_10,
-		.src_reg = EBPF_REG_0,
+		.dst_reg = BPF_REG_10,
+		.src_reg = BPF_REG_0,
 		.off = (int16_t)(offsetof(struct dummy_offset, u8) -
 			sizeof(struct dummy_offset)),
 	},
@@ -3086,8 +3086,8 @@ static const struct rte_ebpf_insn test_ld_mbuf3_prog[] = {
 	},
 	{
 		.code = (BPF_STX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_10,
-		.src_reg = EBPF_REG_0,
+		.dst_reg = BPF_REG_10,
+		.src_reg = BPF_REG_0,
 		.off = (int16_t)(offsetof(struct dummy_offset, u32) -
 			sizeof(struct dummy_offset)),
 	},
@@ -3097,71 +3097,71 @@ static const struct rte_ebpf_insn test_ld_mbuf3_prog[] = {
 		.imm = offsetof(struct rte_ipv4_hdr, total_length),
 	},
 	{
-		.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-		.dst_reg = EBPF_REG_8,
-		.src_reg = EBPF_REG_0,
+		.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+		.dst_reg = BPF_REG_8,
+		.src_reg = BPF_REG_0,
 	},
 	/* load last 4 bytes of IP data */
 	{
 		.code = (BPF_LD | BPF_IND | BPF_W),
-		.src_reg = EBPF_REG_8,
+		.src_reg = BPF_REG_8,
 		.imm = -(int32_t)sizeof(uint32_t),
 	},
 	{
-		.code = (BPF_STX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_10,
-		.src_reg = EBPF_REG_0,
+		.code = (BPF_STX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_10,
+		.src_reg = BPF_REG_0,
 		.off = (int16_t)(offsetof(struct dummy_offset, u64) -
 			sizeof(struct dummy_offset)),
 	},
 	/* load 2 bytes from the middle of IP data */
 	{
-		.code = (EBPF_ALU64 | BPF_RSH | BPF_K),
-		.dst_reg = EBPF_REG_8,
+		.code = (BPF_ALU64 | BPF_RSH | BPF_K),
+		.dst_reg = BPF_REG_8,
 		.imm = 1,
 	},
 	{
 		.code = (BPF_LD | BPF_IND | BPF_H),
-		.src_reg = EBPF_REG_8,
+		.src_reg = BPF_REG_8,
 	},
 	{
-		.code = (BPF_LDX | BPF_MEM | EBPF_DW),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_10,
+		.code = (BPF_LDX | BPF_MEM | BPF_DW),
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_10,
 		.off = (int16_t)(offsetof(struct dummy_offset, u64) -
 			sizeof(struct dummy_offset)),
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
-		.dst_reg = EBPF_REG_0,
-		.src_reg = EBPF_REG_1,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_X),
+		.dst_reg = BPF_REG_0,
+		.src_reg = BPF_REG_1,
 	},
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_W),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_10,
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_10,
 		.off = (int16_t)(offsetof(struct dummy_offset, u32) -
 			sizeof(struct dummy_offset)),
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
-		.dst_reg = EBPF_REG_0,
-		.src_reg = EBPF_REG_1,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_X),
+		.dst_reg = BPF_REG_0,
+		.src_reg = BPF_REG_1,
 	},
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_B),
-		.dst_reg = EBPF_REG_1,
-		.src_reg = EBPF_REG_10,
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_REG_10,
 		.off = (int16_t)(offsetof(struct dummy_offset, u8) -
 			sizeof(struct dummy_offset)),
 	},
 	{
-		.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
-		.dst_reg = EBPF_REG_0,
-		.src_reg = EBPF_REG_1,
+		.code = (BPF_ALU64 | BPF_ADD | BPF_X),
+		.dst_reg = BPF_REG_0,
+		.src_reg = BPF_REG_1,
 	},
 	{
-		.code = (BPF_JMP | EBPF_EXIT),
+		.code = (BPF_JMP | BPF_EXIT),
 	},
 };
 
@@ -3169,8 +3169,8 @@ static const struct rte_ebpf_insn test_ld_mbuf3_prog[] = {
 static const struct rte_ebpf_insn test_int64min_udiv_uint64max_prog[] = {
 	/* Load INT64_MIN into r0 */
 	{
-		.code = (BPF_LD | BPF_IMM | EBPF_DW),
-		.dst_reg = EBPF_REG_0,
+		.code = (BPF_LD | BPF_IMM | BPF_DW),
+		.dst_reg = BPF_REG_0,
 		.imm = (int32_t)INT64_MIN,
 	},
 	{
@@ -3178,13 +3178,13 @@ static const struct rte_ebpf_insn test_int64min_udiv_uint64max_prog[] = {
 	},
 	/* Divide r0 by immediate -1 */
 	{
-		.code = (EBPF_ALU64 | BPF_DIV | BPF_K),
-		.dst_reg = EBPF_REG_0,
+		.code = (BPF_ALU64 | BPF_DIV | BPF_K),
+		.dst_reg = BPF_REG_0,
 		.imm = -1,
 	},
 	/* Exit for correctness otherwise */
 	{
-		.code = (BPF_JMP | EBPF_EXIT),
+		.code = (BPF_JMP | BPF_EXIT),
 	},
 };
 
@@ -3201,8 +3201,8 @@ test_int64min_udiv_uint64max_check(uint64_t rc, const void *arg)
 static const struct rte_ebpf_insn test_int64min_umod_uint64max_prog[] = {
 	/* Load INT64_MIN into r0 */
 	{
-		.code = (BPF_LD | BPF_IMM | EBPF_DW),
-		.dst_reg = EBPF_REG_0,
+		.code = (BPF_LD | BPF_IMM | BPF_DW),
+		.dst_reg = BPF_REG_0,
 		.imm = (int32_t)INT64_MIN,
 	},
 	{
@@ -3210,13 +3210,13 @@ static const struct rte_ebpf_insn test_int64min_umod_uint64max_prog[] = {
 	},
 	/* Modulo r0 by immediate -1 */
 	{
-		.code = (EBPF_ALU64 | BPF_MOD | BPF_K),
-		.dst_reg = EBPF_REG_0,
+		.code = (BPF_ALU64 | BPF_MOD | BPF_K),
+		.dst_reg = BPF_REG_0,
 		.imm = -1,
 	},
 	/* Exit for correctness otherwise */
 	{
-		.code = (BPF_JMP | EBPF_EXIT),
+		.code = (BPF_JMP | BPF_EXIT),
 	},
 };
 
@@ -3654,8 +3654,8 @@ static int
 test_bpf_exec_wrong_nb_prog_arg(void)
 {
 	static const struct rte_ebpf_insn ins[] = {
-		{ .code = (EBPF_ALU64 | EBPF_MOV | BPF_K), .dst_reg = EBPF_REG_0, .imm = 0 },
-		{ .code = (BPF_JMP | EBPF_EXIT), }
+		{ .code = (BPF_ALU64 | BPF_MOV | BPF_K), .dst_reg = BPF_REG_0, .imm = 0 },
+		{ .code = (BPF_JMP | BPF_EXIT), }
 	};
 	static const struct rte_bpf_prm_ex prm = {
 		.sz = sizeof(struct rte_bpf_prm_ex),
@@ -3696,8 +3696,8 @@ static int
 test_bpf_exec_wrong_flags(void)
 {
 	static const struct rte_ebpf_insn ins[] = {
-		{ .code = (EBPF_ALU64 | EBPF_MOV | BPF_K), .dst_reg = EBPF_REG_0, .imm = 0 },
-		{ .code = (BPF_JMP | EBPF_EXIT), }
+		{ .code = (BPF_ALU64 | BPF_MOV | BPF_K), .dst_reg = BPF_REG_0, .imm = 0 },
+		{ .code = (BPF_JMP | BPF_EXIT), }
 	};
 	static const struct rte_bpf_prm_ex prm = {
 		.sz = sizeof(struct rte_bpf_prm_ex),
@@ -3760,11 +3760,11 @@ call_from_bpf_test(text_xfunc_t xfunc)
 {
 	static const struct rte_ebpf_insn ins[] = {
 		{
-			.code = (BPF_JMP | EBPF_CALL),
+			.code = (BPF_JMP | BPF_CALL),
 			.imm = 0,  /* xsym #0 */
 		},
 		{
-			.code = (BPF_JMP | EBPF_EXIT),
+			.code = (BPF_JMP | BPF_EXIT),
 		},
 	};
 	const struct rte_bpf_xsym xsym[] = {
@@ -5006,8 +5006,8 @@ test_xadd32(void)
 	static const struct rte_ebpf_insn ins[] = {
 		{
 			/* Set r0 to return value. */
-			.code = (BPF_LD | BPF_IMM | EBPF_DW),
-			.dst_reg = EBPF_REG_0,
+			.code = (BPF_LD | BPF_IMM | BPF_DW),
+			.dst_reg = BPF_REG_0,
 			.imm = (uint32_t)XCHG_RETURN_VALUE,
 		},
 		{
@@ -5016,8 +5016,8 @@ test_xadd32(void)
 		},
 		{
 			/* Set r2 to XADD operand. */
-			.code = (BPF_LD | BPF_IMM | EBPF_DW),
-			.dst_reg = EBPF_REG_2,
+			.code = (BPF_LD | BPF_IMM | BPF_DW),
+			.dst_reg = BPF_REG_2,
 			.imm = (uint32_t)XADD_OPERAND,
 		},
 		{
@@ -5026,27 +5026,27 @@ test_xadd32(void)
 		},
 		{
 			/* Atomically add r2 to value0, 32-bit. */
-			.code = (BPF_STX | EBPF_ATOMIC | BPF_W),
-			.src_reg = EBPF_REG_2,
-			.dst_reg = EBPF_REG_1,
+			.code = (BPF_STX | BPF_ATOMIC | BPF_W),
+			.src_reg = BPF_REG_2,
+			.dst_reg = BPF_REG_1,
 			.off = offsetof(struct xchg_arg, value0),
-			.imm = BPF_ATOMIC_ADD,
+			.imm = BPF_ADD,
 		},
 		{
 			/* Negate r2. */
-			.code = (EBPF_ALU64 | BPF_NEG | BPF_K),
-			.dst_reg = EBPF_REG_2,
+			.code = (BPF_ALU64 | BPF_NEG | BPF_K),
+			.dst_reg = BPF_REG_2,
 		},
 		{
 			/* Atomically add r2 to value1, 32-bit. */
-			.code = (BPF_STX | EBPF_ATOMIC | BPF_W),
-			.src_reg = EBPF_REG_2,
-			.dst_reg = EBPF_REG_1,
+			.code = (BPF_STX | BPF_ATOMIC | BPF_W),
+			.src_reg = BPF_REG_2,
+			.dst_reg = BPF_REG_1,
 			.off = offsetof(struct xchg_arg, value1),
-			.imm = BPF_ATOMIC_ADD,
+			.imm = BPF_ADD,
 		},
 		{
-			.code = (BPF_JMP | EBPF_EXIT),
+			.code = (BPF_JMP | BPF_EXIT),
 		},
 	};
 	const struct xchg_arg expected = {
@@ -5086,8 +5086,8 @@ test_xadd64(void)
 	static const struct rte_ebpf_insn ins[] = {
 		{
 			/* Set r0 to return value. */
-			.code = (BPF_LD | BPF_IMM | EBPF_DW),
-			.dst_reg = EBPF_REG_0,
+			.code = (BPF_LD | BPF_IMM | BPF_DW),
+			.dst_reg = BPF_REG_0,
 			.imm = (uint32_t)XCHG_RETURN_VALUE,
 		},
 		{
@@ -5096,8 +5096,8 @@ test_xadd64(void)
 		},
 		{
 			/* Set r2 to XADD operand. */
-			.code = (BPF_LD | BPF_IMM | EBPF_DW),
-			.dst_reg = EBPF_REG_2,
+			.code = (BPF_LD | BPF_IMM | BPF_DW),
+			.dst_reg = BPF_REG_2,
 			.imm = (uint32_t)XADD_OPERAND,
 		},
 		{
@@ -5106,27 +5106,27 @@ test_xadd64(void)
 		},
 		{
 			/* Atomically add r2 to value0. */
-			.code = (BPF_STX | EBPF_ATOMIC | EBPF_DW),
-			.src_reg = EBPF_REG_2,
-			.dst_reg = EBPF_REG_1,
+			.code = (BPF_STX | BPF_ATOMIC | BPF_DW),
+			.src_reg = BPF_REG_2,
+			.dst_reg = BPF_REG_1,
 			.off = offsetof(struct xchg_arg, value0),
-			.imm = BPF_ATOMIC_ADD,
+			.imm = BPF_ADD,
 		},
 		{
 			/* Negate r2. */
-			.code = (EBPF_ALU64 | BPF_NEG | BPF_K),
-			.dst_reg = EBPF_REG_2,
+			.code = (BPF_ALU64 | BPF_NEG | BPF_K),
+			.dst_reg = BPF_REG_2,
 		},
 		{
 			/* Atomically add r2 to value1. */
-			.code = (BPF_STX | EBPF_ATOMIC | EBPF_DW),
-			.src_reg = EBPF_REG_2,
-			.dst_reg = EBPF_REG_1,
+			.code = (BPF_STX | BPF_ATOMIC | BPF_DW),
+			.src_reg = BPF_REG_2,
+			.dst_reg = BPF_REG_1,
 			.off = offsetof(struct xchg_arg, value1),
-			.imm = BPF_ATOMIC_ADD,
+			.imm = BPF_ADD,
 		},
 		{
-			.code = (BPF_JMP | EBPF_EXIT),
+			.code = (BPF_JMP | BPF_EXIT),
 		},
 	};
 	const struct xchg_arg expected = {
@@ -5152,8 +5152,8 @@ test_xchg32(void)
 	static const struct rte_ebpf_insn ins[] = {
 		{
 			/* Set r2 to return value. */
-			.code = (BPF_LD | BPF_IMM | EBPF_DW),
-			.dst_reg = EBPF_REG_2,
+			.code = (BPF_LD | BPF_IMM | BPF_DW),
+			.dst_reg = BPF_REG_2,
 			.imm = (uint32_t)XCHG_RETURN_VALUE,
 		},
 		{
@@ -5162,32 +5162,32 @@ test_xchg32(void)
 		},
 		{
 			/* Atomically exchange r2 with value0, 32-bit. */
-			.code = (BPF_STX | EBPF_ATOMIC | BPF_W),
-			.src_reg = EBPF_REG_2,
-			.dst_reg = EBPF_REG_1,
+			.code = (BPF_STX | BPF_ATOMIC | BPF_W),
+			.src_reg = BPF_REG_2,
+			.dst_reg = BPF_REG_1,
 			.off = offsetof(struct xchg_arg, value0),
-			.imm = BPF_ATOMIC_XCHG,
+			.imm = BPF_XCHG,
 		},
 		{
 			/* Atomically exchange r2 with value1, 32-bit. */
-			.code = (BPF_STX | EBPF_ATOMIC | BPF_W),
-			.src_reg = EBPF_REG_2,
-			.dst_reg = EBPF_REG_1,
+			.code = (BPF_STX | BPF_ATOMIC | BPF_W),
+			.src_reg = BPF_REG_2,
+			.dst_reg = BPF_REG_1,
 			.off = offsetof(struct xchg_arg, value1),
-			.imm = BPF_ATOMIC_XCHG,
+			.imm = BPF_XCHG,
 		},
 		{
 			/* Atomically exchange r2 with value0, 32-bit. */
-			.code = (BPF_STX | EBPF_ATOMIC | BPF_W),
-			.src_reg = EBPF_REG_2,
-			.dst_reg = EBPF_REG_1,
+			.code = (BPF_STX | BPF_ATOMIC | BPF_W),
+			.src_reg = BPF_REG_2,
+			.dst_reg = BPF_REG_1,
 			.off = offsetof(struct xchg_arg, value0),
-			.imm = BPF_ATOMIC_XCHG,
+			.imm = BPF_XCHG,
 		},
 		{
 			/* Set upper half of r0 to return value. */
-			.code = (BPF_LD | BPF_IMM | EBPF_DW),
-			.dst_reg = EBPF_REG_0,
+			.code = (BPF_LD | BPF_IMM | BPF_DW),
+			.dst_reg = BPF_REG_0,
 			.imm = 0,
 		},
 		{
@@ -5199,12 +5199,12 @@ test_xchg32(void)
 			 * Add r2 (should have upper half cleared by this time)
 			 * to r0 to use as a return value.
 			 */
-			.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
-			.src_reg = EBPF_REG_2,
-			.dst_reg = EBPF_REG_0,
+			.code = (BPF_ALU64 | BPF_ADD | BPF_X),
+			.src_reg = BPF_REG_2,
+			.dst_reg = BPF_REG_0,
 		},
 		{
-			.code = (BPF_JMP | EBPF_EXIT),
+			.code = (BPF_JMP | BPF_EXIT),
 		},
 	};
 	struct xchg_arg expected = {
@@ -5247,8 +5247,8 @@ test_xchg64(void)
 	static const struct rte_ebpf_insn ins[] = {
 		{
 			/* Set r2 to return value. */
-			.code = (BPF_LD | BPF_IMM | EBPF_DW),
-			.dst_reg = EBPF_REG_2,
+			.code = (BPF_LD | BPF_IMM | BPF_DW),
+			.dst_reg = BPF_REG_2,
 			.imm = (uint32_t)XCHG_RETURN_VALUE,
 		},
 		{
@@ -5257,36 +5257,36 @@ test_xchg64(void)
 		},
 		{
 			/* Atomically exchange r2 with value0. */
-			.code = (BPF_STX | EBPF_ATOMIC | EBPF_DW),
-			.src_reg = EBPF_REG_2,
-			.dst_reg = EBPF_REG_1,
+			.code = (BPF_STX | BPF_ATOMIC | BPF_DW),
+			.src_reg = BPF_REG_2,
+			.dst_reg = BPF_REG_1,
 			.off = offsetof(struct xchg_arg, value0),
-			.imm = BPF_ATOMIC_XCHG,
+			.imm = BPF_XCHG,
 		},
 		{
 			/* Atomically exchange r2 with value1. */
-			.code = (BPF_STX | EBPF_ATOMIC | EBPF_DW),
-			.src_reg = EBPF_REG_2,
-			.dst_reg = EBPF_REG_1,
+			.code = (BPF_STX | BPF_ATOMIC | BPF_DW),
+			.src_reg = BPF_REG_2,
+			.dst_reg = BPF_REG_1,
 			.off = offsetof(struct xchg_arg, value1),
-			.imm = BPF_ATOMIC_XCHG,
+			.imm = BPF_XCHG,
 		},
 		{
 			/* Atomically exchange r2 with value0. */
-			.code = (BPF_STX | EBPF_ATOMIC | EBPF_DW),
-			.src_reg = EBPF_REG_2,
-			.dst_reg = EBPF_REG_1,
+			.code = (BPF_STX | BPF_ATOMIC | BPF_DW),
+			.src_reg = BPF_REG_2,
+			.dst_reg = BPF_REG_1,
 			.off = offsetof(struct xchg_arg, value0),
-			.imm = BPF_ATOMIC_XCHG,
+			.imm = BPF_XCHG,
 		},
 		{
 			/* Copy r2 to r0 to use as a return value. */
-			.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-			.src_reg = EBPF_REG_2,
-			.dst_reg = EBPF_REG_0,
+			.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+			.src_reg = BPF_REG_2,
+			.dst_reg = BPF_REG_0,
 		},
 		{
-			.code = (BPF_JMP | EBPF_EXIT),
+			.code = (BPF_JMP | BPF_EXIT),
 		},
 	};
 	const struct xchg_arg expected = {
@@ -5310,8 +5310,8 @@ test_atomic_imm(int32_t imm, bool is_valid)
 	const struct rte_ebpf_insn ins[] = {
 		{
 			/* Set r2 to return value. */
-			.code = (BPF_LD | BPF_IMM | EBPF_DW),
-			.dst_reg = EBPF_REG_2,
+			.code = (BPF_LD | BPF_IMM | BPF_DW),
+			.dst_reg = BPF_REG_2,
 			.imm = (uint32_t)XCHG_RETURN_VALUE,
 		},
 		{
@@ -5320,20 +5320,20 @@ test_atomic_imm(int32_t imm, bool is_valid)
 		},
 		{
 			/* Atomically exchange r2 with value0. */
-			.code = (BPF_STX | EBPF_ATOMIC | EBPF_DW),
-			.src_reg = EBPF_REG_2,
-			.dst_reg = EBPF_REG_1,
+			.code = (BPF_STX | BPF_ATOMIC | BPF_DW),
+			.src_reg = BPF_REG_2,
+			.dst_reg = BPF_REG_1,
 			.off = offsetof(struct xchg_arg, value0),
 			.imm = imm,
 		},
 		{
 			/* Copy r2 to r0 to use as a return value. */
-			.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
-			.src_reg = EBPF_REG_2,
-			.dst_reg = EBPF_REG_0,
+			.code = (BPF_ALU64 | BPF_MOV | BPF_X),
+			.src_reg = BPF_REG_2,
+			.dst_reg = BPF_REG_0,
 		},
 		{
-			.code = (BPF_JMP | EBPF_EXIT),
+			.code = (BPF_JMP | BPF_EXIT),
 		},
 	};
 	const struct rte_bpf_prm prm = {
@@ -5360,8 +5360,8 @@ static int
 test_atomic_imms(void)
 {
 	RTE_TEST_ASSERT_SUCCESS(test_atomic_imm(INT32_MIN, false), "expect success");
-	for (int32_t imm = BPF_ATOMIC_ADD - 1; imm <= BPF_ATOMIC_XCHG + 1; ++imm) {
-		const bool is_valid = imm == BPF_ATOMIC_ADD || imm == BPF_ATOMIC_XCHG;
+	for (int32_t imm = BPF_ADD - 1; imm <= BPF_XCHG + 1; ++imm) {
+		const bool is_valid = imm == BPF_ADD || imm == BPF_XCHG;
 		RTE_TEST_ASSERT_SUCCESS(test_atomic_imm(imm, is_valid), "expect success");
 	}
 	RTE_TEST_ASSERT_SUCCESS(test_atomic_imm(INT32_MAX, false), "expect success");
diff --git a/app/test/test_bpf_validate.c b/app/test/test_bpf_validate.c
index 110dec81b017..58ffc82d193d 100644
--- a/app/test/test_bpf_validate.c
+++ b/app/test/test_bpf_validate.c
@@ -39,22 +39,22 @@ RTE_LOG_REGISTER(test_bpf_validate_logtype, test.bpf_validate, NOTICE);
 
 /* List comparison opcodes to make their index bits match constants above.  */
 static const uint8_t comparisons_opcode[] = {
-	(BPF_JMP | EBPF_JLT  | BPF_X),
-	(BPF_JMP | EBPF_JLT  | BPF_K),
+	(BPF_JMP | BPF_JLT  | BPF_X),
+	(BPF_JMP | BPF_JLT  | BPF_K),
 	(BPF_JMP |  BPF_JGT  | BPF_X),
 	(BPF_JMP |  BPF_JGT  | BPF_K),
-	(BPF_JMP | EBPF_JLE  | BPF_X),
-	(BPF_JMP | EBPF_JLE  | BPF_K),
+	(BPF_JMP | BPF_JLE  | BPF_X),
+	(BPF_JMP | BPF_JLE  | BPF_K),
 	(BPF_JMP |  BPF_JGE  | BPF_X),
 	(BPF_JMP |  BPF_JGE  | BPF_K),
-	(BPF_JMP | EBPF_JSLT | BPF_X),
-	(BPF_JMP | EBPF_JSLT | BPF_K),
-	(BPF_JMP | EBPF_JSGT | BPF_X),
-	(BPF_JMP | EBPF_JSGT | BPF_K),
-	(BPF_JMP | EBPF_JSLE | BPF_X),
-	(BPF_JMP | EBPF_JSLE | BPF_K),
-	(BPF_JMP | EBPF_JSGE | BPF_X),
-	(BPF_JMP | EBPF_JSGE | BPF_K),
+	(BPF_JMP | BPF_JSLT | BPF_X),
+	(BPF_JMP | BPF_JSLT | BPF_K),
+	(BPF_JMP | BPF_JSGT | BPF_X),
+	(BPF_JMP | BPF_JSGT | BPF_K),
+	(BPF_JMP | BPF_JSLE | BPF_X),
+	(BPF_JMP | BPF_JSLE | BPF_K),
+	(BPF_JMP | BPF_JSGE | BPF_X),
+	(BPF_JMP | BPF_JSGE | BPF_K),
 };
 
 /* Interval bounded by two signed values, inclusive; min <= max. */
@@ -280,7 +280,7 @@ check_signed_interval(struct rte_bpf_validate_debug *debug,
 
 	TEST_ASSERT_EQUAL(may_jump(debug,
 		&(struct rte_ebpf_insn){
-			.code = (BPF_JMP | EBPF_JSLT | BPF_K),
+			.code = (BPF_JMP | BPF_JSLT | BPF_K),
 			.dst_reg = reg,
 		}, interval.min),
 		false,
@@ -307,7 +307,7 @@ check_signed_interval(struct rte_bpf_validate_debug *debug,
 
 	TEST_ASSERT_EQUAL(may_jump(debug,
 		&(struct rte_ebpf_insn){
-			.code = (BPF_JMP | EBPF_JSGT | BPF_K),
+			.code = (BPF_JMP | BPF_JSGT | BPF_K),
 			.dst_reg = reg,
 		}, interval.max),
 		false,
@@ -326,7 +326,7 @@ check_unsigned_interval(struct rte_bpf_validate_debug *debug,
 
 	TEST_ASSERT_EQUAL(may_jump(debug,
 		&(struct rte_ebpf_insn){
-			.code = (BPF_JMP | EBPF_JLT | BPF_K),
+			.code = (BPF_JMP | BPF_JLT | BPF_K),
 			.dst_reg = reg,
 		}, interval.min),
 		false,
@@ -372,7 +372,7 @@ check_relative_interval(struct rte_bpf_validate_debug *debug,
 
 	TEST_ASSERT_EQUAL(may_jump(debug,
 		&(struct rte_ebpf_insn){
-			.code = (BPF_JMP | EBPF_JLT | BPF_X),
+			.code = (BPF_JMP | BPF_JLT | BPF_X),
 			.dst_reg = reg,
 			.src_reg = base_reg,
 		}, interval.min),
@@ -552,14 +552,14 @@ load_constant(struct rte_ebpf_insn **ins, uint8_t reg, int64_t value)
 {
 	if (fits_in_imm32(value)) {
 		*(*ins)++ = (struct rte_ebpf_insn){
-			.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
+			.code = (BPF_ALU64 | BPF_MOV | BPF_K),
 			.dst_reg = reg,
 			.imm = (int32_t)value,
 		};
 	} else {
 		/* Load imm64 into tmp_reg using wide load, lower bits first... */
 		*(*ins)++ = (struct rte_ebpf_insn){
-			.code = (BPF_LD | BPF_IMM | EBPF_DW),
+			.code = (BPF_LD | BPF_IMM | BPF_DW),
 			.dst_reg = reg,
 			.imm = (uint32_t)value,
 		};
@@ -618,7 +618,7 @@ prepare_scalar_domain(struct rte_ebpf_insn **ins, uint8_t reg,
 
 	/* Load value from memory area into the register. */
 	*(*ins)++ = (struct rte_ebpf_insn){
-		.code = (BPF_LDX | EBPF_DW | BPF_MEM),
+		.code = (BPF_LDX | BPF_DW | BPF_MEM),
 		.dst_reg = reg,
 		.src_reg = base_reg,
 		.off = sizeof(uint64_t) * (*service_cell_count)++,
@@ -632,13 +632,13 @@ prepare_scalar_domain(struct rte_ebpf_insn **ins, uint8_t reg,
 	 * these bugs, this preparation phase is not a test for them.
 	 */
 	if (domain->u.min > unknown.u.min)
-		compare_and_jump(ins, EBPF_JLT, reg, domain->u.min, tmp_reg);
+		compare_and_jump(ins, BPF_JLT, reg, domain->u.min, tmp_reg);
 	if (domain->u.max < unknown.u.max)
 		compare_and_jump(ins, BPF_JGT, reg, domain->u.max, tmp_reg);
 	if (domain->s.min > unknown.s.min)
-		compare_and_jump(ins, EBPF_JSLT, reg, domain->s.min, tmp_reg);
+		compare_and_jump(ins, BPF_JSLT, reg, domain->s.min, tmp_reg);
 	if (domain->s.max < unknown.s.max)
-		compare_and_jump(ins, EBPF_JSGT, reg, domain->s.max, tmp_reg);
+		compare_and_jump(ins, BPF_JSGT, reg, domain->s.max, tmp_reg);
 }
 
 /*
@@ -657,7 +657,7 @@ prepare_domain(struct rte_ebpf_insn **ins, uint8_t reg,
 	if (domain->is_pointer)
 		/* Add base_reg to convert resulting scalar into a pointer. */
 		*(*ins)++ = (struct rte_ebpf_insn){
-			.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
+			.code = (BPF_ALU64 | BPF_ADD | BPF_X),
 			.dst_reg = reg,
 			.src_reg = base_reg,
 		};
@@ -734,15 +734,15 @@ generate_program(struct verify_instruction_context *ctx, struct rte_ebpf_insn *i
 	fill_verify_instruction_defaults(&ctx->prm);
 
 	/* Allocate registers, base_reg is received as program argument. */
-	ctx->base_reg = EBPF_REG_1;
+	ctx->base_reg = BPF_REG_1;
 	ctx->dst_reg = (ctx->prm.pre.dst.is_defined || ctx->prm.post.dst.is_defined ||
-		ctx->prm.jump.dst.is_defined) ? EBPF_REG_2 : NO_REGISTER;
+		ctx->prm.jump.dst.is_defined) ? BPF_REG_2 : NO_REGISTER;
 	ctx->src_reg = (ctx->prm.pre.src.is_defined || ctx->prm.post.src.is_defined ||
-		ctx->prm.jump.src.is_defined) ? EBPF_REG_3 : NO_REGISTER;
-	ctx->tmp_reg = EBPF_REG_4;
+		ctx->prm.jump.src.is_defined) ? BPF_REG_3 : NO_REGISTER;
+	ctx->tmp_reg = BPF_REG_4;
 
 	/* Clear r0 to make it eligible as a return value. */
-	load_constant(&ins, EBPF_REG_0, 0);
+	load_constant(&ins, BPF_REG_0, 0);
 
 	/* Fill dst register in the instruction if defined anywhere, prepare if needed. */
 	if (ctx->dst_reg != NO_REGISTER) {
@@ -777,18 +777,18 @@ generate_program(struct verify_instruction_context *ctx, struct rte_ebpf_insn *i
 
 	/* Issue post instruction (for setting post breakpoint). */
 	ctx->post.program_counter = ins - ins_buf;
-	load_constant(&ins, EBPF_REG_0, 1);
+	load_constant(&ins, BPF_REG_0, 1);
 
 	/* Issue jump branch for the jump instruction, even if dynamically unreachable. */
 	if (BPF_CLASS(ctx->prm.tested_instruction.code) != BPF_JMP)
 		ctx->jump.program_counter = NO_PROGRAM_COUNTER;
 	else {
 		/* Finish previous branch by issuing exit. */
-		*ins++ = (struct rte_ebpf_insn){ .code = (BPF_JMP | EBPF_EXIT) };
+		*ins++ = (struct rte_ebpf_insn){ .code = (BPF_JMP | BPF_EXIT) };
 
 		/* Issue jump target instruction (for setting jump breakpoint). */
 		ctx->jump.program_counter = ins - ins_buf;
-		load_constant(&ins, EBPF_REG_0, 2);
+		load_constant(&ins, BPF_REG_0, 2);
 
 		/* Patch jump in tested jump instruction. */
 		RTE_VERIFY(ins_buf[ctx->pre.program_counter].off == 0);
@@ -798,7 +798,7 @@ generate_program(struct verify_instruction_context *ctx, struct rte_ebpf_insn *i
 
 	/* Issue exit instruction. */
 	const uint32_t exit_pc = ins - ins_buf;
-	*ins++ = (struct rte_ebpf_insn){ .code = (BPF_JMP | EBPF_EXIT) };
+	*ins++ = (struct rte_ebpf_insn){ .code = (BPF_JMP | BPF_EXIT) };
 
 	/* Patch all jumps to point to exit. */
 	for (uint32_t pc = 0; pc != ctx->pre.program_counter; ++pc)
@@ -1283,7 +1283,7 @@ test_alu64_add_k(void)
 {
 	return verify_instruction((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (EBPF_ALU64 | BPF_ADD | BPF_K),
+			.code = (BPF_ALU64 | BPF_ADD | BPF_K),
 			.imm = 17,
 		},
 		.pre.dst = make_signed_domain(11, 29),
@@ -1297,7 +1297,7 @@ test_alu64_add_k_pointer(void)
 {
 	return verify_instruction((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (EBPF_ALU64 | BPF_ADD | BPF_K),
+			.code = (BPF_ALU64 | BPF_ADD | BPF_K),
 			.imm = 17,
 		},
 		.area_size = 256,
@@ -1312,7 +1312,7 @@ test_alu64_add_x_pointer_pointer(void)
 {
 	return verify_instruction((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
+			.code = (BPF_ALU64 | BPF_ADD | BPF_X),
 		},
 		.area_size = 256,
 		.pre.dst = make_pointer_domain(11, 29),
@@ -1327,7 +1327,7 @@ test_alu64_add_x_pointer_scalar(void)
 {
 	return verify_instruction((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
+			.code = (BPF_ALU64 | BPF_ADD | BPF_X),
 		},
 		.area_size = 256,
 		.pre.dst = make_pointer_domain(11, 29),
@@ -1342,7 +1342,7 @@ test_alu64_add_x_scalar_pointer(void)
 {
 	return verify_instruction((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
+			.code = (BPF_ALU64 | BPF_ADD | BPF_X),
 		},
 		.area_size = 256,
 		.pre.dst = make_signed_domain(11, 29),
@@ -1357,7 +1357,7 @@ test_alu64_add_x_scalar_scalar(void)
 {
 	return verify_instruction((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
+			.code = (BPF_ALU64 | BPF_ADD | BPF_X),
 		},
 		.area_size = 256,
 		.pre.dst = make_signed_domain(11, 29),
@@ -1372,7 +1372,7 @@ test_alu64_and_k(void)
 {
 	return verify_instruction((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (EBPF_ALU64 | BPF_AND | BPF_K),
+			.code = (BPF_ALU64 | BPF_AND | BPF_K),
 			.imm = 5,
 		},
 		.pre.dst = make_signed_domain(6, 8),
@@ -1401,21 +1401,21 @@ test_alu64_div_mod_big_constant(void)
 
 		TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
 			.tested_instruction = {
-				.code = (EBPF_ALU64 | BPF_DIV | BPF_X),
+				.code = (BPF_ALU64 | BPF_DIV | BPF_X),
 			},
 			.pre.dst = make_singleton_domain(dividend),
 			.pre.src = make_singleton_domain(divisor),
 			.post.dst = make_singleton_domain(dividend / divisor),
-		}), "(EBPF_ALU64 | BPF_DIV | BPF_X) check, index=%d", index);
+		}), "(BPF_ALU64 | BPF_DIV | BPF_X) check, index=%d", index);
 
 		TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
 			.tested_instruction = {
-				.code = (EBPF_ALU64 | BPF_MOD | BPF_X),
+				.code = (BPF_ALU64 | BPF_MOD | BPF_X),
 			},
 			.pre.dst = make_singleton_domain(dividend),
 			.pre.src = make_singleton_domain(divisor),
 			.post.dst = make_singleton_domain(dividend % divisor),
-		}), "(EBPF_ALU64 | BPF_MOD | BPF_X) check, index=%d", index);
+		}), "(BPF_ALU64 | BPF_MOD | BPF_X) check, index=%d", index);
 	}
 
 	return TEST_SUCCESS;
@@ -1443,21 +1443,21 @@ test_alu64_div_mod_big_range(void)
 
 		TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
 			.tested_instruction = {
-				.code = (EBPF_ALU64 | BPF_DIV | BPF_X),
+				.code = (BPF_ALU64 | BPF_DIV | BPF_X),
 			},
 			.pre.dst = make_unsigned_domain(dividend_first, dividend_last),
 			.pre.src = make_singleton_domain(divisor),
 			.post.dst = make_unsigned_domain(0, dividend_last),
-		}), "(EBPF_ALU64 | BPF_DIV | BPF_X) check, index=%d", index);
+		}), "(BPF_ALU64 | BPF_DIV | BPF_X) check, index=%d", index);
 
 		TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
 			.tested_instruction = {
-				.code = (EBPF_ALU64 | BPF_MOD | BPF_X),
+				.code = (BPF_ALU64 | BPF_MOD | BPF_X),
 			},
 			.pre.dst = make_unsigned_domain(dividend_first, dividend_last),
 			.pre.src = make_singleton_domain(divisor),
 			.post.dst = make_unsigned_domain(0, RTE_MIN(dividend_last, divisor - 1)),
-		}), "(EBPF_ALU64 | BPF_MOD | BPF_X) check, index=%d", index);
+		}), "(BPF_ALU64 | BPF_MOD | BPF_X) check, index=%d", index);
 	}
 
 	return TEST_SUCCESS;
@@ -1469,39 +1469,39 @@ test_alu64_div_mod_overflow(void)
 {
 	TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (EBPF_ALU64 | BPF_DIV | BPF_K),
+			.code = (BPF_ALU64 | BPF_DIV | BPF_K),
 			.imm = -1,
 		},
 		.pre.dst = make_singleton_domain(INT64_MIN),
 		.post.dst = make_singleton_domain(0),
-	}), "(EBPF_ALU64 | BPF_DIV | BPF_K) check");
+	}), "(BPF_ALU64 | BPF_DIV | BPF_K) check");
 
 	TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (EBPF_ALU64 | BPF_DIV | BPF_X),
+			.code = (BPF_ALU64 | BPF_DIV | BPF_X),
 		},
 		.pre.dst = make_singleton_domain(INT64_MIN),
 		.pre.src = make_singleton_domain(-1),
 		.post.dst = make_singleton_domain(0),
-	}), "(EBPF_ALU64 | BPF_DIV | BPF_X) check");
+	}), "(BPF_ALU64 | BPF_DIV | BPF_X) check");
 
 	TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (EBPF_ALU64 | BPF_MOD | BPF_K),
+			.code = (BPF_ALU64 | BPF_MOD | BPF_K),
 			.imm = -1,
 		},
 		.pre.dst = make_singleton_domain(INT64_MIN),
 		.post.dst = make_singleton_domain(INT64_MIN),
-	}), "(EBPF_ALU64 | BPF_MOD | BPF_K) check");
+	}), "(BPF_ALU64 | BPF_MOD | BPF_K) check");
 
 	TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (EBPF_ALU64 | BPF_MOD | BPF_X),
+			.code = (BPF_ALU64 | BPF_MOD | BPF_X),
 		},
 		.pre.dst = make_singleton_domain(INT64_MIN),
 		.pre.src = make_singleton_domain(-1),
 		.post.dst = make_singleton_domain(INT64_MIN),
-	}), "(EBPF_ALU64 | BPF_MOD | BPF_X) check");
+	}), "(BPF_ALU64 | BPF_MOD | BPF_X) check");
 
 	return TEST_SUCCESS;
 }
@@ -1512,7 +1512,7 @@ test_alu64_lsh_63(void)
 {
 	return verify_instruction((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (EBPF_ALU64 | BPF_LSH | BPF_K),
+			.code = (BPF_ALU64 | BPF_LSH | BPF_K),
 			.imm = 63,
 		},
 		.pre.dst = make_signed_domain(3, 5),
@@ -1526,7 +1526,7 @@ test_alu64_mul_k_overflow(void)
 {
 	return verify_instruction((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (EBPF_ALU64 | BPF_MUL | BPF_K),
+			.code = (BPF_ALU64 | BPF_MUL | BPF_K),
 			.imm = 0x12345678,
 		},
 		.pre.dst = make_singleton_domain(0x9876543210),
@@ -1540,7 +1540,7 @@ test_alu64_mul_k_range_small(void)
 {
 	return verify_instruction((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (EBPF_ALU64 | BPF_MUL | BPF_K),
+			.code = (BPF_ALU64 | BPF_MUL | BPF_K),
 			.imm = 11,
 		},
 		.pre.dst = make_unsigned_domain(17, 29),
@@ -1569,7 +1569,7 @@ test_alu64_neg_int64min_first(void)
 		const int64_t other_value = other_values[other_index];
 		TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
 			.tested_instruction = {
-				.code = (EBPF_ALU64 | BPF_NEG),
+				.code = (BPF_ALU64 | BPF_NEG),
 			},
 			.pre.dst = make_signed_domain(INT64_MIN, other_value),
 			.post.dst = other_value > 0 ? unknown :
@@ -1596,7 +1596,7 @@ test_alu64_neg_int64min_last(void)
 		const int64_t other_value = other_values[other_index];
 		TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
 			.tested_instruction = {
-				.code = (EBPF_ALU64 | BPF_NEG),
+				.code = (BPF_ALU64 | BPF_NEG),
 			},
 			.pre.dst = make_unsigned_domain(other_value, INT64_MIN),
 			.post.dst = make_signed_domain(INT64_MIN, -(uint64_t)other_value),
@@ -1626,7 +1626,7 @@ test_alu64_neg_zero_first(void)
 		const uint64_t other_value = other_values[other_index];
 		TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
 			.tested_instruction = {
-				.code = (EBPF_ALU64 | BPF_NEG),
+				.code = (BPF_ALU64 | BPF_NEG),
 			},
 			.pre.dst = make_unsigned_domain(0, other_value),
 			.post.dst = other_value > (uint64_t)INT64_MIN ? unknown :
@@ -1652,7 +1652,7 @@ test_alu64_neg_zero_last(void)
 		const int64_t other_value = other_values[other_index];
 		TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
 			.tested_instruction = {
-				.code = (EBPF_ALU64 | BPF_NEG),
+				.code = (BPF_ALU64 | BPF_NEG),
 			},
 			.pre.dst = make_signed_domain(other_value, 0),
 			.post.dst = make_unsigned_domain(0, -(uint64_t)other_value),
@@ -1668,7 +1668,7 @@ test_alu64_or_k_negative(void)
 {
 	return verify_instruction((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (EBPF_ALU64 | BPF_OR | BPF_K),
+			.code = (BPF_ALU64 | BPF_OR | BPF_K),
 			.imm = -2,
 		},
 		.pre.dst = make_signed_domain(5, 6),
@@ -1682,7 +1682,7 @@ test_alu64_or_k_positive(void)
 {
 	return verify_instruction((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (EBPF_ALU64 | BPF_OR | BPF_K),
+			.code = (BPF_ALU64 | BPF_OR | BPF_K),
 			.imm = 2,
 		},
 		.pre.dst = make_signed_domain(5, 6),
@@ -1696,7 +1696,7 @@ test_alu64_sub_x_src_signed_max_zero(void)
 {
 	return verify_instruction((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (EBPF_ALU64 | BPF_SUB | BPF_X),
+			.code = (BPF_ALU64 | BPF_SUB | BPF_X),
 		},
 		.pre.dst = make_signed_domain(INT64_MIN, 0),
 		.pre.src = make_signed_domain(INT64_MIN, 0),
@@ -1710,7 +1710,7 @@ test_alu64_xor_k_negative(void)
 {
 	return verify_instruction((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (EBPF_ALU64 | BPF_XOR | BPF_K),
+			.code = (BPF_ALU64 | BPF_XOR | BPF_K),
 			.imm = 0,
 		},
 		.pre.dst = make_signed_domain(INT64_MIN, 0),
@@ -1739,7 +1739,7 @@ test_jmp64_jslt_x(void)
 {
 	return verify_instruction((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | EBPF_JSLT | BPF_X),
+			.code = (BPF_JMP | BPF_JSLT | BPF_X),
 		},
 		.pre.dst = make_signed_domain(-3, 3),
 		.pre.src = make_signed_domain(0, 0),
@@ -1757,7 +1757,7 @@ test_jmp64_ordering_overflow(void)
 
 	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | EBPF_JSLT | BPF_X),
+			.code = (BPF_JMP | BPF_JSLT | BPF_X),
 		},
 		.pre.dst = make_singleton_domain(42),
 		.pre.src = make_singleton_domain(INT64_MIN),
@@ -1766,7 +1766,7 @@ test_jmp64_ordering_overflow(void)
 
 	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | EBPF_JSGT | BPF_X),
+			.code = (BPF_JMP | BPF_JSGT | BPF_X),
 		},
 		.pre.dst = make_singleton_domain(42),
 		.pre.src = make_singleton_domain(INT64_MAX),
@@ -1775,7 +1775,7 @@ test_jmp64_ordering_overflow(void)
 
 	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | EBPF_JLT | BPF_X),
+			.code = (BPF_JMP | BPF_JLT | BPF_X),
 		},
 		.pre.dst = make_singleton_domain(42),
 		.pre.src = make_singleton_domain(0),
@@ -1808,7 +1808,7 @@ test_jmp64_ordering_ranges(void)
 
 	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | EBPF_JLT | BPF_X),
+			.code = (BPF_JMP | BPF_JLT | BPF_X),
 		},
 		.pre.dst = make_signed_domain(20, 60),
 		.pre.src = make_signed_domain(0, 10),
@@ -1817,7 +1817,7 @@ test_jmp64_ordering_ranges(void)
 
 	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | EBPF_JLE | BPF_X),
+			.code = (BPF_JMP | BPF_JLE | BPF_X),
 		},
 		.pre.dst = make_signed_domain(20, 60),
 		.pre.src = make_signed_domain(0, 10),
@@ -1831,7 +1831,7 @@ test_jmp64_ordering_ranges(void)
 
 	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | EBPF_JLT | BPF_X),
+			.code = (BPF_JMP | BPF_JLT | BPF_X),
 		},
 		.pre.dst = make_signed_domain(20, 60),
 		.pre.src = make_signed_domain(10, 40),
@@ -1841,7 +1841,7 @@ test_jmp64_ordering_ranges(void)
 
 	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | EBPF_JLE | BPF_X),
+			.code = (BPF_JMP | BPF_JLE | BPF_X),
 		},
 		.pre.dst = make_signed_domain(20, 60),
 		.pre.src = make_signed_domain(10, 40),
@@ -1856,7 +1856,7 @@ test_jmp64_ordering_ranges(void)
 
 	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | EBPF_JLT | BPF_X),
+			.code = (BPF_JMP | BPF_JLT | BPF_X),
 		},
 		.pre.dst = make_signed_domain(20, 60),
 		.pre.src = make_signed_domain(10, 70),
@@ -1866,7 +1866,7 @@ test_jmp64_ordering_ranges(void)
 
 	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | EBPF_JLE | BPF_X),
+			.code = (BPF_JMP | BPF_JLE | BPF_X),
 		},
 		.pre.dst = make_signed_domain(20, 60),
 		.pre.src = make_signed_domain(10, 70),
@@ -1881,7 +1881,7 @@ test_jmp64_ordering_ranges(void)
 
 	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | EBPF_JLT | BPF_X),
+			.code = (BPF_JMP | BPF_JLT | BPF_X),
 		},
 		.pre.dst = make_signed_domain(20, 60),
 		.pre.src = make_signed_domain(30, 50),
@@ -1891,7 +1891,7 @@ test_jmp64_ordering_ranges(void)
 
 	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | EBPF_JLE | BPF_X),
+			.code = (BPF_JMP | BPF_JLE | BPF_X),
 		},
 		.pre.dst = make_signed_domain(20, 60),
 		.pre.src = make_signed_domain(30, 50),
@@ -1906,7 +1906,7 @@ test_jmp64_ordering_ranges(void)
 
 	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | EBPF_JLT | BPF_X),
+			.code = (BPF_JMP | BPF_JLT | BPF_X),
 		},
 		.pre.dst = make_signed_domain(20, 60),
 		.pre.src = make_signed_domain(40, 70),
@@ -1916,7 +1916,7 @@ test_jmp64_ordering_ranges(void)
 
 	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | EBPF_JLE | BPF_X),
+			.code = (BPF_JMP | BPF_JLE | BPF_X),
 		},
 		.pre.dst = make_signed_domain(20, 60),
 		.pre.src = make_signed_domain(40, 70),
@@ -1931,7 +1931,7 @@ test_jmp64_ordering_ranges(void)
 
 	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | EBPF_JLT | BPF_X),
+			.code = (BPF_JMP | BPF_JLT | BPF_X),
 		},
 		.pre.dst = make_signed_domain(20, 60),
 		.pre.src = make_signed_domain(70, 80),
@@ -1940,7 +1940,7 @@ test_jmp64_ordering_ranges(void)
 
 	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | EBPF_JLE | BPF_X),
+			.code = (BPF_JMP | BPF_JLE | BPF_X),
 		},
 		.pre.dst = make_signed_domain(20, 60),
 		.pre.src = make_signed_domain(70, 80),
@@ -1964,13 +1964,13 @@ test_jmp64_ordering_singleton_inside(void)
 
 	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | EBPF_JLT | BPF_K),
+			.code = (BPF_JMP | BPF_JLT | BPF_K),
 			.imm = 40,
 		},
 		.pre.dst = make_signed_domain(20, 60),
 		.post.dst = make_signed_domain(40, 60),
 		.jump.dst = make_signed_domain(20, 39),
-	}, also_signed), "(BPF_JMP | EBPF_JLT | BPF_K) check");
+	}, also_signed), "(BPF_JMP | BPF_JLT | BPF_K) check");
 
 	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
@@ -1984,13 +1984,13 @@ test_jmp64_ordering_singleton_inside(void)
 
 	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | EBPF_JLE | BPF_K),
+			.code = (BPF_JMP | BPF_JLE | BPF_K),
 			.imm = 40,
 		},
 		.pre.dst = make_signed_domain(20, 60),
 		.post.dst = make_signed_domain(41, 60),
 		.jump.dst = make_signed_domain(20, 40),
-	}, also_signed), "(BPF_JMP | EBPF_JLE | BPF_K) check");
+	}, also_signed), "(BPF_JMP | BPF_JLE | BPF_K) check");
 
 	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
@@ -2019,21 +2019,21 @@ test_jmp64_ordering_singleton_outside(void)
 
 	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | EBPF_JLT | BPF_K),
+			.code = (BPF_JMP | BPF_JLT | BPF_K),
 			.imm = 10,
 		},
 		.pre.dst = make_signed_domain(20, 60),
 		.jump = unreachable,
-	}, also_signed), "(BPF_JMP | EBPF_JLT | BPF_K) check, range greater than imm");
+	}, also_signed), "(BPF_JMP | BPF_JLT | BPF_K) check, range greater than imm");
 
 	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | EBPF_JLE | BPF_K),
+			.code = (BPF_JMP | BPF_JLE | BPF_K),
 			.imm = 10,
 		},
 		.pre.dst = make_signed_domain(20, 60),
 		.jump = unreachable,
-	}, also_signed), "(BPF_JMP | EBPF_JLE | BPF_K) check, range greater than imm");
+	}, also_signed), "(BPF_JMP | BPF_JLE | BPF_K) check, range greater than imm");
 
 	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
@@ -2060,21 +2060,21 @@ test_jmp64_ordering_singleton_outside(void)
 
 	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | EBPF_JLT | BPF_K),
+			.code = (BPF_JMP | BPF_JLT | BPF_K),
 			.imm = 70,
 		},
 		.pre.dst = make_signed_domain(20, 60),
 		.post = unreachable,
-	}, also_signed), "(BPF_JMP | EBPF_JLT | BPF_K) check, range less than imm");
+	}, also_signed), "(BPF_JMP | BPF_JLT | BPF_K) check, range less than imm");
 
 	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | EBPF_JLE | BPF_K),
+			.code = (BPF_JMP | BPF_JLE | BPF_K),
 			.imm = 70,
 		},
 		.pre.dst = make_signed_domain(20, 60),
 		.post = unreachable,
-	}, also_signed), "(BPF_JMP | EBPF_JLE | BPF_K) check, range less than imm");
+	}, also_signed), "(BPF_JMP | BPF_JLE | BPF_K) check, range less than imm");
 
 	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
@@ -2113,7 +2113,7 @@ test_jmp64_ordering_touching(void)
 
 		TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 			.tested_instruction = {
-				.code = (BPF_JMP | EBPF_JLT | BPF_X),
+				.code = (BPF_JMP | BPF_JLT | BPF_X),
 			},
 			.pre.dst = make_signed_domain(20, 30),
 			.pre.src = make_signed_domain(10, 19 + overlap),
@@ -2125,7 +2125,7 @@ test_jmp64_ordering_touching(void)
 
 		TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 			.tested_instruction = {
-				.code = (BPF_JMP | EBPF_JLE | BPF_X),
+				.code = (BPF_JMP | BPF_JLE | BPF_X),
 			},
 			.pre.dst = make_signed_domain(20, 30),
 			.pre.src = make_signed_domain(10, 19 + overlap),
@@ -2142,7 +2142,7 @@ test_jmp64_ordering_touching(void)
 
 		TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 			.tested_instruction = {
-				.code = (BPF_JMP | EBPF_JLT | BPF_X),
+				.code = (BPF_JMP | BPF_JLT | BPF_X),
 			},
 			.pre.dst = make_signed_domain(10, 19 + overlap),
 			.pre.src = make_signed_domain(20, 30),
@@ -2154,7 +2154,7 @@ test_jmp64_ordering_touching(void)
 
 		TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 			.tested_instruction = {
-				.code = (BPF_JMP | EBPF_JLE | BPF_X),
+				.code = (BPF_JMP | BPF_JLE | BPF_X),
 			},
 			.pre.dst = make_signed_domain(10, 19 + overlap),
 			.pre.src = make_signed_domain(20, 30),
@@ -2174,7 +2174,7 @@ test_mem_ldx_dw_heap(void)
 {
 	return verify_instruction((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_MEM | BPF_LDX | EBPF_DW),
+			.code = (BPF_MEM | BPF_LDX | BPF_DW),
 			.off = 16,
 		},
 		.area_size = 24,
diff --git a/lib/bpf/bpf_convert.c b/lib/bpf/bpf_convert.c
index 37095eea52ce..4cb40b90dfbe 100644
--- a/lib/bpf/bpf_convert.c
+++ b/lib/bpf/bpf_convert.c
@@ -64,18 +64,18 @@
  * Arg1, Arg2, Arg3, etc are used as argument mappings of function
  * calls in BPF_CALL instruction.
  */
-#define BPF_REG_ARG1	EBPF_REG_1
-#define BPF_REG_ARG2	EBPF_REG_2
-#define BPF_REG_ARG3	EBPF_REG_3
-#define BPF_REG_ARG4	EBPF_REG_4
-#define BPF_REG_ARG5	EBPF_REG_5
-#define BPF_REG_CTX	EBPF_REG_6
-#define BPF_REG_FP	EBPF_REG_10
+#define BPF_REG_ARG1	BPF_REG_1
+#define BPF_REG_ARG2	BPF_REG_2
+#define BPF_REG_ARG3	BPF_REG_3
+#define BPF_REG_ARG4	BPF_REG_4
+#define BPF_REG_ARG5	BPF_REG_5
+#define BPF_REG_CTX	BPF_REG_6
+#define BPF_REG_FP	BPF_REG_10
 
 /* Additional register mappings for converted user programs. */
-#define BPF_REG_A	EBPF_REG_0
-#define BPF_REG_X	EBPF_REG_7
-#define BPF_REG_TMP	EBPF_REG_8
+#define BPF_REG_A	BPF_REG_0
+#define BPF_REG_X	BPF_REG_7
+#define BPF_REG_TMP	BPF_REG_8
 
 /* Helper macros for filter block array initializers. */
 
@@ -83,7 +83,7 @@
 
 #define EBPF_ALU64_REG(OP, DST, SRC)				\
 	((struct rte_ebpf_insn) {					\
-		.code  = EBPF_ALU64 | BPF_OP(OP) | BPF_X,	\
+		.code  = BPF_ALU64 | BPF_OP(OP) | BPF_X,	\
 		.dst_reg = DST,					\
 		.src_reg = SRC,					\
 		.off   = 0,					\
@@ -111,7 +111,7 @@
 
 #define BPF_MOV64_REG(DST, SRC)					\
 	((struct rte_ebpf_insn) {					\
-		.code  = EBPF_ALU64 | EBPF_MOV | BPF_X,		\
+		.code  = BPF_ALU64 | BPF_MOV | BPF_X,		\
 		.dst_reg = DST,					\
 		.src_reg = SRC,					\
 		.off   = 0,					\
@@ -119,7 +119,7 @@
 
 #define BPF_MOV32_REG(DST, SRC)					\
 	((struct rte_ebpf_insn) {					\
-		.code  = BPF_ALU | EBPF_MOV | BPF_X,		\
+		.code  = BPF_ALU | BPF_MOV | BPF_X,		\
 		.dst_reg = DST,					\
 		.src_reg = SRC,					\
 		.off   = 0,					\
@@ -129,7 +129,7 @@
 
 #define BPF_MOV32_IMM(DST, IMM)					\
 	((struct rte_ebpf_insn) {					\
-		.code  = BPF_ALU | EBPF_MOV | BPF_K,		\
+		.code  = BPF_ALU | BPF_MOV | BPF_K,		\
 		.dst_reg = DST,					\
 		.src_reg = 0,					\
 		.off   = 0,					\
@@ -139,7 +139,7 @@
 
 #define BPF_MOV32_RAW(TYPE, DST, SRC, IMM)			\
 	((struct rte_ebpf_insn) {					\
-		.code  = BPF_ALU | EBPF_MOV | BPF_SRC(TYPE),	\
+		.code  = BPF_ALU | BPF_MOV | BPF_SRC(TYPE),	\
 		.dst_reg = DST,					\
 		.src_reg = SRC,					\
 		.off   = 0,					\
@@ -199,7 +199,7 @@
 
 #define BPF_EXIT_INSN()						\
 	((struct rte_ebpf_insn) {					\
-		.code  = BPF_JMP | EBPF_EXIT,			\
+		.code  = BPF_JMP | BPF_EXIT,			\
 		.dst_reg = 0,					\
 		.src_reg = 0,					\
 		.off   = 0,					\
@@ -305,7 +305,7 @@ static int bpf_convert_filter(const struct bpf_insn *prog, size_t len,
 		case BPF_ALU | BPF_MOD | BPF_X:
 			/* For cBPF, don't cause floating point exception */
 			*insn++ = BPF_MOV32_REG(BPF_REG_X, BPF_REG_X);
-			*insn++ = BPF_JMP_IMM(EBPF_JNE, BPF_REG_X, 0, 2);
+			*insn++ = BPF_JMP_IMM(BPF_JNE, BPF_REG_X, 0, 2);
 			*insn++ = BPF_ALU32_REG(BPF_XOR, BPF_REG_A, BPF_REG_A);
 			*insn++ = BPF_EXIT_INSN();
 			/* fallthrough */
@@ -396,7 +396,7 @@ static int bpf_convert_filter(const struct bpf_insn *prog, size_t len,
 
 			/* Convert JEQ into JNE when 'jump_true' is next insn. */
 			if (fp->jt == 0 && BPF_OP(fp->code) == BPF_JEQ) {
-				insn->code = BPF_JMP | EBPF_JNE | bpf_src;
+				insn->code = BPF_JMP | BPF_JNE | bpf_src;
 				target = i + fp->jf + 1;
 				BPF_EMIT_JMP;
 				break;
@@ -430,12 +430,12 @@ static int bpf_convert_filter(const struct bpf_insn *prog, size_t len,
 			break;
 
 			/* RET_K is remapped into 2 insns. RET_A case doesn't need an
-			 * extra mov as EBPF_REG_0 is already mapped into BPF_REG_A.
+			 * extra mov as BPF_REG_0 is already mapped into BPF_REG_A.
 			 */
 		case BPF_RET | BPF_A:
 		case BPF_RET | BPF_K:
 			if (BPF_RVAL(fp->code) == BPF_K) {
-				*insn++ = BPF_MOV32_RAW(BPF_K, EBPF_REG_0,
+				*insn++ = BPF_MOV32_RAW(BPF_K, BPF_REG_0,
 							0, fp->k);
 			}
 			*insn = BPF_EXIT_INSN();
diff --git a/lib/bpf/bpf_def.h b/lib/bpf/bpf_def.h
index ee13c8c8b758..a854729ab6a6 100644
--- a/lib/bpf/bpf_def.h
+++ b/lib/bpf/bpf_def.h
@@ -7,16 +7,11 @@
 #ifndef _RTE_BPF_DEF_H_
 #define _RTE_BPF_DEF_H_
 
-/**
- * @file
- *
+/*
  * classic BPF (cBPF) and extended BPF (eBPF) related defines.
  * For more information regarding cBPF and eBPF ISA and their differences,
  * please refer to:
  * https://www.kernel.org/doc/Documentation/networking/filter.txt.
- * As a rule of thumb for that file:
- * all definitions used by both cBPF and eBPF start with bpf(BPF)_ prefix,
- * while eBPF only ones start with ebpf(EBPF)) prefix.
  */
 
 #include <stdint.h>
@@ -37,14 +32,14 @@
 #define	BPF_RET		0x06
 #define	BPF_MISC        0x07
 
-#define EBPF_ALU64	0x07
+#define BPF_ALU64	0x07
 
 /* ld/ldx fields */
 #define BPF_SIZE(code)  ((code) & 0x18)
 #define	BPF_W		0x00
 #define	BPF_H		0x08
 #define	BPF_B		0x10
-#define	EBPF_DW		0x18
+#define	BPF_DW		0x18
 
 #define BPF_MODE(code)  ((code) & 0xe0)
 #define	BPF_IMM		0x00
@@ -54,12 +49,11 @@
 #define	BPF_LEN		0x80
 #define	BPF_MSH		0xa0
 
-#define EBPF_XADD	0xc0
+#define BPF_XADD	0xc0
 /* Generalize XADD for other operations depending on imm (0 still means ADD). */
-#define EBPF_ATOMIC	0xc0
+#define BPF_ATOMIC	0xc0
 
-#define BPF_ATOMIC_ADD	0x00
-#define BPF_ATOMIC_XCHG	0xe1
+#define BPF_XCHG	0xe1
 
 /* alu/jmp fields */
 #define BPF_OP(code)    ((code) & 0xf0)
@@ -75,9 +69,9 @@
 #define	BPF_MOD		0x90
 #define	BPF_XOR		0xa0
 
-#define EBPF_MOV	0xb0
-#define EBPF_ARSH	0xc0
-#define EBPF_END	0xd0
+#define BPF_MOV	0xb0
+#define BPF_ARSH	0xc0
+#define BPF_END	0xd0
 
 #define	BPF_JA		0x00
 #define	BPF_JEQ		0x10
@@ -85,49 +79,49 @@
 #define	BPF_JGE		0x30
 #define	BPF_JSET        0x40
 
-#define EBPF_JNE	0x50
-#define EBPF_JSGT	0x60
-#define EBPF_JSGE	0x70
-#define EBPF_CALL	0x80
-#define EBPF_EXIT	0x90
-#define EBPF_JLT	0xa0
-#define EBPF_JLE	0xb0
-#define EBPF_JSLT	0xc0
-#define EBPF_JSLE	0xd0
+#define BPF_JNE	0x50
+#define BPF_JSGT	0x60
+#define BPF_JSGE	0x70
+#define BPF_CALL	0x80
+#define BPF_EXIT	0x90
+#define BPF_JLT	0xa0
+#define BPF_JLE	0xb0
+#define BPF_JSLT	0xc0
+#define BPF_JSLE	0xd0
 
 #define BPF_SRC(code)   ((code) & 0x08)
 #define	BPF_K		0x00
 #define	BPF_X		0x08
 
-/* if BPF_OP(code) == EBPF_END */
-#define EBPF_TO_LE	0x00  /* convert to little-endian */
-#define EBPF_TO_BE	0x08  /* convert to big-endian */
+/* if BPF_OP(code) == BPF_END */
+#define BPF_TO_LE	0x00  /* convert to little-endian */
+#define BPF_TO_BE	0x08  /* convert to big-endian */
 
 /*
  * eBPF registers
  */
 enum {
-	EBPF_REG_0,  /* return value from internal function/for eBPF program */
-	EBPF_REG_1,  /* 0-th argument to internal function */
-	EBPF_REG_2,  /* 1-th argument to internal function */
-	EBPF_REG_3,  /* 2-th argument to internal function */
-	EBPF_REG_4,  /* 3-th argument to internal function */
-	EBPF_REG_5,  /* 4-th argument to internal function */
-	EBPF_REG_6,  /* callee saved register */
-	EBPF_REG_7,  /* callee saved register */
-	EBPF_REG_8,  /* callee saved register */
-	EBPF_REG_9,  /* callee saved register */
-	EBPF_REG_10, /* stack pointer (read-only) */
-	EBPF_REG_NUM,
+	BPF_REG_0,  /* return value from internal function/for eBPF program */
+	BPF_REG_1,  /* 0-th argument to internal function */
+	BPF_REG_2,  /* 1-th argument to internal function */
+	BPF_REG_3,  /* 2-th argument to internal function */
+	BPF_REG_4,  /* 3-th argument to internal function */
+	BPF_REG_5,  /* 4-th argument to internal function */
+	BPF_REG_6,  /* callee saved register */
+	BPF_REG_7,  /* callee saved register */
+	BPF_REG_8,  /* callee saved register */
+	BPF_REG_9,  /* callee saved register */
+	BPF_REG_10, /* stack pointer (read-only) */
+	MAX_BPF_REG,
 };
 
 /*
- * When EBPF_CALL instruction has src_reg == EBPF_PSEUDO_CALL,
+ * When BPF_CALL instruction has src_reg == BPF_PSEUDO_CALL,
  * it should be treated as pseudo-call instruction, where
  * imm value contains pc-relative offset to another EBPF function.
  * Right now DPDK EBPF library doesn't support it.
  */
-#define	EBPF_PSEUDO_CALL	EBPF_REG_1
+#define	BPF_PSEUDO_CALL	BPF_REG_1
 
 
 #endif /* RTE_BPF_DEF_H_ */
diff --git a/lib/bpf/bpf_dump.c b/lib/bpf/bpf_dump.c
index e2573919079e..78f5b8bc473b 100644
--- a/lib/bpf/bpf_dump.c
+++ b/lib/bpf/bpf_dump.c
@@ -26,32 +26,32 @@ static const char *const alu_op_tbl[16] = {
 	[BPF_OR >> 4] = "or",	   [BPF_AND >> 4] = "and",
 	[BPF_LSH >> 4] = "lsh",	   [BPF_RSH >> 4] = "rsh",
 	[BPF_NEG >> 4] = "neg",	   [BPF_MOD >> 4] = "mod",
-	[BPF_XOR >> 4] = "xor",	   [EBPF_MOV >> 4] = "mov",
-	[EBPF_ARSH >> 4] = "arsh", [EBPF_END >> 4] = "endian",
+	[BPF_XOR >> 4] = "xor",	   [BPF_MOV >> 4] = "mov",
+	[BPF_ARSH >> 4] = "arsh", [BPF_END >> 4] = "endian",
 };
 
 static const char *const size_tbl[] = {
 	[BPF_W >> 3] = "w",
 	[BPF_H >> 3] = "h",
 	[BPF_B >> 3] = "b",
-	[EBPF_DW >> 3] = "dw",
+	[BPF_DW >> 3] = "dw",
 };
 
 static const char *const jump_tbl[16] = {
 	[BPF_JA >> 4] = "ja",	   [BPF_JEQ >> 4] = "jeq",
 	[BPF_JGT >> 4] = "jgt",	   [BPF_JGE >> 4] = "jge",
-	[BPF_JSET >> 4] = "jset",  [EBPF_JNE >> 4] = "jne",
-	[EBPF_JSGT >> 4] = "jsgt", [EBPF_JSGE >> 4] = "jsge",
-	[EBPF_CALL >> 4] = "call", [EBPF_EXIT >> 4] = "exit",
-	[EBPF_JLT >> 4] = "jlt",   [EBPF_JLE >> 4] = "jle",
-	[EBPF_JSLT >> 4] = "jslt", [EBPF_JSLE >> 4] = "jsle",
+	[BPF_JSET >> 4] = "jset",  [BPF_JNE >> 4] = "jne",
+	[BPF_JSGT >> 4] = "jsgt", [BPF_JSGE >> 4] = "jsge",
+	[BPF_CALL >> 4] = "call", [BPF_EXIT >> 4] = "exit",
+	[BPF_JLT >> 4] = "jlt",   [BPF_JLE >> 4] = "jle",
+	[BPF_JSLT >> 4] = "jslt", [BPF_JSLE >> 4] = "jsle",
 };
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_insn_is_wide, 26.07)
 bool
 rte_bpf_insn_is_wide(const struct rte_ebpf_insn *ins)
 {
-	return ins->code == (BPF_LD | BPF_IMM | EBPF_DW);
+	return ins->code == (BPF_LD | BPF_IMM | BPF_DW);
 }
 
 
@@ -83,9 +83,9 @@ static inline const char *
 atomic_op(int32_t imm)
 {
 	switch (imm) {
-	case BPF_ATOMIC_ADD:
+	case BPF_ADD:
 		return "xadd";
-	case BPF_ATOMIC_XCHG:
+	case BPF_XCHG:
 		return "xchg";
 	default:
 		return NULL;
@@ -110,7 +110,7 @@ format_disassembly(char *buffer, size_t bufsz, const struct rte_ebpf_insn *ins,
 	case BPF_ALU:
 		postfix = "32";
 		/* fall through */
-	case EBPF_ALU64:
+	case BPF_ALU64:
 		op = alu_op_tbl[BPF_OP_INDEX(ins->code)];
 		if (ins->off != 0)
 			/* Not yet supported variation with non-zero offset. */
@@ -124,7 +124,7 @@ format_disassembly(char *buffer, size_t bufsz, const struct rte_ebpf_insn *ins,
 	case BPF_LD:
 		op = "ld";
 		postfix = size_tbl[BPF_SIZE_INDEX(ins->code)];
-		if (ins->code == (BPF_LD | BPF_IMM | EBPF_DW)) {
+		if (ins->code == (BPF_LD | BPF_IMM | BPF_DW)) {
 			uint64_t val;
 
 			if (ins->src_reg != 0)
@@ -172,7 +172,7 @@ format_disassembly(char *buffer, size_t bufsz, const struct rte_ebpf_insn *ins,
 		case BPF_MEM:
 			op = "stx";
 			break;
-		case EBPF_ATOMIC:
+		case BPF_ATOMIC:
 			op = atomic_op(ins->imm);
 			if (op == NULL)
 				return snprintf(buffer, bufsz,
@@ -201,10 +201,10 @@ format_disassembly(char *buffer, size_t bufsz, const struct rte_ebpf_insn *ins,
 		switch (BPF_OP(ins->code)) {
 		case BPF_JA:
 			return snprintf(buffer, bufsz, "%s %s%s", op, jump, warning);
-		case EBPF_CALL:
+		case BPF_CALL:
 			/* Call of helper function with index in immediate. */
 			return snprintf(buffer, bufsz, "%s #%u%s", op, ins->imm, warning);
-		case EBPF_EXIT:
+		case BPF_EXIT:
 			return snprintf(buffer, bufsz, "%s%s", op, warning);
 		}
 
diff --git a/lib/bpf/bpf_exec.c b/lib/bpf/bpf_exec.c
index 2e966aaaeadf..b52f6888b1ed 100644
--- a/lib/bpf/bpf_exec.c
+++ b/lib/bpf/bpf_exec.c
@@ -67,12 +67,12 @@
 
 #define BPF_ST_ATOMIC_REG(reg, ins, tp)	do { \
 	switch (ins->imm) { \
-	case BPF_ATOMIC_ADD: \
+	case BPF_ADD: \
 		rte_atomic##tp##_add((rte_atomic##tp##_t *) \
 			(uintptr_t)((reg)[(ins)->dst_reg] + (ins)->off), \
 			(reg)[(ins)->src_reg]); \
 		break; \
-	case BPF_ATOMIC_XCHG: \
+	case BPF_XCHG: \
 		(reg)[(ins)->src_reg] = rte_atomic##tp##_exchange((uint##tp##_t *) \
 			(uintptr_t)((reg)[(ins)->dst_reg] + (ins)->off), \
 			(reg)[(ins)->src_reg]); \
@@ -95,7 +95,7 @@
 	const type *p = bpf_ld_mbuf(bpf, reg, ins, (ins)->imm, sizeof(type)); \
 	if (p == NULL)  \
 		return 0; \
-	reg[EBPF_REG_0] = op(p[0]); \
+	reg[BPF_REG_0] = op(p[0]); \
 } while (0)
 
 #define BPF_LD_IND(bpf, reg, ins, type, op) do { \
@@ -103,12 +103,12 @@
 	const type *p = bpf_ld_mbuf(bpf, reg, ins, ofs, sizeof(type)); \
 	if (p == NULL)  \
 		return 0; \
-	reg[EBPF_REG_0] = op(p[0]); \
+	reg[BPF_REG_0] = op(p[0]); \
 } while (0)
 
 
 static inline void
-bpf_alu_be(uint64_t reg[EBPF_REG_NUM], const struct rte_ebpf_insn *ins)
+bpf_alu_be(uint64_t reg[MAX_BPF_REG], const struct rte_ebpf_insn *ins)
 {
 	uint64_t *v;
 
@@ -127,7 +127,7 @@ bpf_alu_be(uint64_t reg[EBPF_REG_NUM], const struct rte_ebpf_insn *ins)
 }
 
 static inline void
-bpf_alu_le(uint64_t reg[EBPF_REG_NUM], const struct rte_ebpf_insn *ins)
+bpf_alu_le(uint64_t reg[MAX_BPF_REG], const struct rte_ebpf_insn *ins)
 {
 	uint64_t *v;
 
@@ -146,14 +146,14 @@ bpf_alu_le(uint64_t reg[EBPF_REG_NUM], const struct rte_ebpf_insn *ins)
 }
 
 static inline const void *
-bpf_ld_mbuf(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM],
+bpf_ld_mbuf(const struct rte_bpf *bpf, uint64_t reg[MAX_BPF_REG],
 	const struct rte_ebpf_insn *ins, uint32_t off, uint32_t len)
 {
 	const struct rte_mbuf *mb;
 	const void *p;
 
-	mb = (const struct rte_mbuf *)(uintptr_t)reg[EBPF_REG_6];
-	p = rte_pktmbuf_read(mb, off, len, reg + EBPF_REG_0);
+	mb = (const struct rte_mbuf *)(uintptr_t)reg[BPF_REG_6];
+	p = rte_pktmbuf_read(mb, off, len, reg + BPF_REG_0);
 	if (p == NULL)
 		RTE_BPF_LOG_LINE(DEBUG, "%s(bpf=%p, mbuf=%p, ofs=%u, len=%u): "
 			"load beyond packet boundary at pc: %#zx;",
@@ -163,7 +163,7 @@ bpf_ld_mbuf(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM],
 }
 
 static inline uint64_t
-bpf_exec(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM])
+bpf_exec(const struct rte_bpf *bpf, uint64_t reg[MAX_BPF_REG])
 {
 	const struct rte_ebpf_insn *ins;
 
@@ -200,7 +200,7 @@ bpf_exec(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM])
 		case (BPF_ALU | BPF_MOD | BPF_K):
 			BPF_OP_ALU_IMM(reg, ins, %, uint32_t);
 			break;
-		case (BPF_ALU | EBPF_MOV | BPF_K):
+		case (BPF_ALU | BPF_MOV | BPF_K):
 			EBPF_MOV_ALU_IMM(reg, ins, uint32_t);
 			break;
 		/* 32 bit ALU REG operations */
@@ -236,95 +236,95 @@ bpf_exec(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM])
 			BPF_DIV_ZERO_CHECK(bpf, reg, ins, uint32_t);
 			BPF_OP_ALU_REG(reg, ins, %, uint32_t);
 			break;
-		case (BPF_ALU | EBPF_MOV | BPF_X):
+		case (BPF_ALU | BPF_MOV | BPF_X):
 			EBPF_MOV_ALU_REG(reg, ins, uint32_t);
 			break;
 		case (BPF_ALU | BPF_NEG):
 			BPF_NEG_ALU(reg, ins, uint32_t);
 			break;
-		case (BPF_ALU | EBPF_END | EBPF_TO_BE):
+		case (BPF_ALU | BPF_END | BPF_TO_BE):
 			bpf_alu_be(reg, ins);
 			break;
-		case (BPF_ALU | EBPF_END | EBPF_TO_LE):
+		case (BPF_ALU | BPF_END | BPF_TO_LE):
 			bpf_alu_le(reg, ins);
 			break;
 		/* 64 bit ALU IMM operations */
-		case (EBPF_ALU64 | BPF_ADD | BPF_K):
+		case (BPF_ALU64 | BPF_ADD | BPF_K):
 			BPF_OP_ALU_IMM(reg, ins, +, uint64_t);
 			break;
-		case (EBPF_ALU64 | BPF_SUB | BPF_K):
+		case (BPF_ALU64 | BPF_SUB | BPF_K):
 			BPF_OP_ALU_IMM(reg, ins, -, uint64_t);
 			break;
-		case (EBPF_ALU64 | BPF_AND | BPF_K):
+		case (BPF_ALU64 | BPF_AND | BPF_K):
 			BPF_OP_ALU_IMM(reg, ins, &, uint64_t);
 			break;
-		case (EBPF_ALU64 | BPF_OR | BPF_K):
+		case (BPF_ALU64 | BPF_OR | BPF_K):
 			BPF_OP_ALU_IMM(reg, ins, |, uint64_t);
 			break;
-		case (EBPF_ALU64 | BPF_LSH | BPF_K):
+		case (BPF_ALU64 | BPF_LSH | BPF_K):
 			BPF_OP_ALU_IMM(reg, ins, <<, uint64_t);
 			break;
-		case (EBPF_ALU64 | BPF_RSH | BPF_K):
+		case (BPF_ALU64 | BPF_RSH | BPF_K):
 			BPF_OP_ALU_IMM(reg, ins, >>, uint64_t);
 			break;
-		case (EBPF_ALU64 | EBPF_ARSH | BPF_K):
+		case (BPF_ALU64 | BPF_ARSH | BPF_K):
 			BPF_OP_ALU_IMM(reg, ins, >>, int64_t);
 			break;
-		case (EBPF_ALU64 | BPF_XOR | BPF_K):
+		case (BPF_ALU64 | BPF_XOR | BPF_K):
 			BPF_OP_ALU_IMM(reg, ins, ^, uint64_t);
 			break;
-		case (EBPF_ALU64 | BPF_MUL | BPF_K):
+		case (BPF_ALU64 | BPF_MUL | BPF_K):
 			BPF_OP_ALU_IMM(reg, ins, *, uint64_t);
 			break;
-		case (EBPF_ALU64 | BPF_DIV | BPF_K):
+		case (BPF_ALU64 | BPF_DIV | BPF_K):
 			BPF_OP_ALU_IMM(reg, ins, /, uint64_t);
 			break;
-		case (EBPF_ALU64 | BPF_MOD | BPF_K):
+		case (BPF_ALU64 | BPF_MOD | BPF_K):
 			BPF_OP_ALU_IMM(reg, ins, %, uint64_t);
 			break;
-		case (EBPF_ALU64 | EBPF_MOV | BPF_K):
+		case (BPF_ALU64 | BPF_MOV | BPF_K):
 			EBPF_MOV_ALU_IMM(reg, ins, uint64_t);
 			break;
 		/* 64 bit ALU REG operations */
-		case (EBPF_ALU64 | BPF_ADD | BPF_X):
+		case (BPF_ALU64 | BPF_ADD | BPF_X):
 			BPF_OP_ALU_REG(reg, ins, +, uint64_t);
 			break;
-		case (EBPF_ALU64 | BPF_SUB | BPF_X):
+		case (BPF_ALU64 | BPF_SUB | BPF_X):
 			BPF_OP_ALU_REG(reg, ins, -, uint64_t);
 			break;
-		case (EBPF_ALU64 | BPF_AND | BPF_X):
+		case (BPF_ALU64 | BPF_AND | BPF_X):
 			BPF_OP_ALU_REG(reg, ins, &, uint64_t);
 			break;
-		case (EBPF_ALU64 | BPF_OR | BPF_X):
+		case (BPF_ALU64 | BPF_OR | BPF_X):
 			BPF_OP_ALU_REG(reg, ins, |, uint64_t);
 			break;
-		case (EBPF_ALU64 | BPF_LSH | BPF_X):
+		case (BPF_ALU64 | BPF_LSH | BPF_X):
 			BPF_OP_ALU_REG(reg, ins, <<, uint64_t);
 			break;
-		case (EBPF_ALU64 | BPF_RSH | BPF_X):
+		case (BPF_ALU64 | BPF_RSH | BPF_X):
 			BPF_OP_ALU_REG(reg, ins, >>, uint64_t);
 			break;
-		case (EBPF_ALU64 | EBPF_ARSH | BPF_X):
+		case (BPF_ALU64 | BPF_ARSH | BPF_X):
 			BPF_OP_ALU_REG(reg, ins, >>, int64_t);
 			break;
-		case (EBPF_ALU64 | BPF_XOR | BPF_X):
+		case (BPF_ALU64 | BPF_XOR | BPF_X):
 			BPF_OP_ALU_REG(reg, ins, ^, uint64_t);
 			break;
-		case (EBPF_ALU64 | BPF_MUL | BPF_X):
+		case (BPF_ALU64 | BPF_MUL | BPF_X):
 			BPF_OP_ALU_REG(reg, ins, *, uint64_t);
 			break;
-		case (EBPF_ALU64 | BPF_DIV | BPF_X):
+		case (BPF_ALU64 | BPF_DIV | BPF_X):
 			BPF_DIV_ZERO_CHECK(bpf, reg, ins, uint64_t);
 			BPF_OP_ALU_REG(reg, ins, /, uint64_t);
 			break;
-		case (EBPF_ALU64 | BPF_MOD | BPF_X):
+		case (BPF_ALU64 | BPF_MOD | BPF_X):
 			BPF_DIV_ZERO_CHECK(bpf, reg, ins, uint64_t);
 			BPF_OP_ALU_REG(reg, ins, %, uint64_t);
 			break;
-		case (EBPF_ALU64 | EBPF_MOV | BPF_X):
+		case (BPF_ALU64 | BPF_MOV | BPF_X):
 			EBPF_MOV_ALU_REG(reg, ins, uint64_t);
 			break;
-		case (EBPF_ALU64 | BPF_NEG):
+		case (BPF_ALU64 | BPF_NEG):
 			BPF_NEG_ALU(reg, ins, uint64_t);
 			break;
 		/* load instructions */
@@ -337,11 +337,11 @@ bpf_exec(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM])
 		case (BPF_LDX | BPF_MEM | BPF_W):
 			BPF_LD_REG(reg, ins, uint32_t);
 			break;
-		case (BPF_LDX | BPF_MEM | EBPF_DW):
+		case (BPF_LDX | BPF_MEM | BPF_DW):
 			BPF_LD_REG(reg, ins, uint64_t);
 			break;
 		/* load 64 bit immediate value */
-		case (BPF_LD | BPF_IMM | EBPF_DW):
+		case (BPF_LD | BPF_IMM | BPF_DW):
 			reg[ins->dst_reg] = (uint32_t)ins[0].imm |
 				(uint64_t)(uint32_t)ins[1].imm << 32;
 			ins++;
@@ -376,7 +376,7 @@ bpf_exec(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM])
 		case (BPF_STX | BPF_MEM | BPF_W):
 			BPF_ST_REG(reg, ins, uint32_t);
 			break;
-		case (BPF_STX | BPF_MEM | EBPF_DW):
+		case (BPF_STX | BPF_MEM | BPF_DW):
 			BPF_ST_REG(reg, ins, uint64_t);
 			break;
 		case (BPF_ST | BPF_MEM | BPF_B):
@@ -388,14 +388,14 @@ bpf_exec(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM])
 		case (BPF_ST | BPF_MEM | BPF_W):
 			BPF_ST_IMM(reg, ins, uint32_t);
 			break;
-		case (BPF_ST | BPF_MEM | EBPF_DW):
+		case (BPF_ST | BPF_MEM | BPF_DW):
 			BPF_ST_IMM(reg, ins, uint64_t);
 			break;
 		/* atomic instructions */
-		case (BPF_STX | EBPF_ATOMIC | BPF_W):
+		case (BPF_STX | BPF_ATOMIC | BPF_W):
 			BPF_ST_ATOMIC_REG(reg, ins, 32);
 			break;
-		case (BPF_STX | EBPF_ATOMIC | EBPF_DW):
+		case (BPF_STX | BPF_ATOMIC | BPF_DW):
 			BPF_ST_ATOMIC_REG(reg, ins, 64);
 			break;
 		/* jump instructions */
@@ -406,31 +406,31 @@ bpf_exec(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM])
 		case (BPF_JMP | BPF_JEQ | BPF_K):
 			BPF_JMP_CND_IMM(reg, ins, ==, uint64_t);
 			break;
-		case (BPF_JMP | EBPF_JNE | BPF_K):
+		case (BPF_JMP | BPF_JNE | BPF_K):
 			BPF_JMP_CND_IMM(reg, ins, !=, uint64_t);
 			break;
 		case (BPF_JMP | BPF_JGT | BPF_K):
 			BPF_JMP_CND_IMM(reg, ins, >, uint64_t);
 			break;
-		case (BPF_JMP | EBPF_JLT | BPF_K):
+		case (BPF_JMP | BPF_JLT | BPF_K):
 			BPF_JMP_CND_IMM(reg, ins, <, uint64_t);
 			break;
 		case (BPF_JMP | BPF_JGE | BPF_K):
 			BPF_JMP_CND_IMM(reg, ins, >=, uint64_t);
 			break;
-		case (BPF_JMP | EBPF_JLE | BPF_K):
+		case (BPF_JMP | BPF_JLE | BPF_K):
 			BPF_JMP_CND_IMM(reg, ins, <=, uint64_t);
 			break;
-		case (BPF_JMP | EBPF_JSGT | BPF_K):
+		case (BPF_JMP | BPF_JSGT | BPF_K):
 			BPF_JMP_CND_IMM(reg, ins, >, int64_t);
 			break;
-		case (BPF_JMP | EBPF_JSLT | BPF_K):
+		case (BPF_JMP | BPF_JSLT | BPF_K):
 			BPF_JMP_CND_IMM(reg, ins, <, int64_t);
 			break;
-		case (BPF_JMP | EBPF_JSGE | BPF_K):
+		case (BPF_JMP | BPF_JSGE | BPF_K):
 			BPF_JMP_CND_IMM(reg, ins, >=, int64_t);
 			break;
-		case (BPF_JMP | EBPF_JSLE | BPF_K):
+		case (BPF_JMP | BPF_JSLE | BPF_K):
 			BPF_JMP_CND_IMM(reg, ins, <=, int64_t);
 			break;
 		case (BPF_JMP | BPF_JSET | BPF_K):
@@ -440,46 +440,46 @@ bpf_exec(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM])
 		case (BPF_JMP | BPF_JEQ | BPF_X):
 			BPF_JMP_CND_REG(reg, ins, ==, uint64_t);
 			break;
-		case (BPF_JMP | EBPF_JNE | BPF_X):
+		case (BPF_JMP | BPF_JNE | BPF_X):
 			BPF_JMP_CND_REG(reg, ins, !=, uint64_t);
 			break;
 		case (BPF_JMP | BPF_JGT | BPF_X):
 			BPF_JMP_CND_REG(reg, ins, >, uint64_t);
 			break;
-		case (BPF_JMP | EBPF_JLT | BPF_X):
+		case (BPF_JMP | BPF_JLT | BPF_X):
 			BPF_JMP_CND_REG(reg, ins, <, uint64_t);
 			break;
 		case (BPF_JMP | BPF_JGE | BPF_X):
 			BPF_JMP_CND_REG(reg, ins, >=, uint64_t);
 			break;
-		case (BPF_JMP | EBPF_JLE | BPF_X):
+		case (BPF_JMP | BPF_JLE | BPF_X):
 			BPF_JMP_CND_REG(reg, ins, <=, uint64_t);
 			break;
-		case (BPF_JMP | EBPF_JSGT | BPF_X):
+		case (BPF_JMP | BPF_JSGT | BPF_X):
 			BPF_JMP_CND_REG(reg, ins, >, int64_t);
 			break;
-		case (BPF_JMP | EBPF_JSLT | BPF_X):
+		case (BPF_JMP | BPF_JSLT | BPF_X):
 			BPF_JMP_CND_REG(reg, ins, <, int64_t);
 			break;
-		case (BPF_JMP | EBPF_JSGE | BPF_X):
+		case (BPF_JMP | BPF_JSGE | BPF_X):
 			BPF_JMP_CND_REG(reg, ins, >=, int64_t);
 			break;
-		case (BPF_JMP | EBPF_JSLE | BPF_X):
+		case (BPF_JMP | BPF_JSLE | BPF_X):
 			BPF_JMP_CND_REG(reg, ins, <=, int64_t);
 			break;
 		case (BPF_JMP | BPF_JSET | BPF_X):
 			BPF_JMP_CND_REG(reg, ins, &, uint64_t);
 			break;
 		/* call instructions */
-		case (BPF_JMP | EBPF_CALL):
-			reg[EBPF_REG_0] = bpf->prm.xsym[ins->imm].func.val(
-				reg[EBPF_REG_1], reg[EBPF_REG_2],
-				reg[EBPF_REG_3], reg[EBPF_REG_4],
-				reg[EBPF_REG_5]);
+		case (BPF_JMP | BPF_CALL):
+			reg[BPF_REG_0] = bpf->prm.xsym[ins->imm].func.val(
+				reg[BPF_REG_1], reg[BPF_REG_2],
+				reg[BPF_REG_3], reg[BPF_REG_4],
+				reg[BPF_REG_5]);
 			break;
 		/* return instruction */
-		case (BPF_JMP | EBPF_EXIT):
-			return reg[EBPF_REG_0];
+		case (BPF_JMP | BPF_EXIT):
+			return reg[BPF_REG_0];
 		default:
 			RTE_BPF_LOG_LINE(ERR,
 				"%s(%p): invalid opcode %#x at pc: %#zx;",
@@ -500,7 +500,7 @@ rte_bpf_exec_burst(const struct rte_bpf *bpf, void *ctx[], uint64_t rc[],
 	uint32_t num)
 {
 	uint32_t i;
-	uint64_t reg[EBPF_REG_NUM];
+	uint64_t reg[MAX_BPF_REG];
 	uint64_t stack[MAX_BPF_STACK_SIZE / sizeof(uint64_t)];
 
 	if (bpf->prm.nb_prog_arg != 1) {
@@ -511,8 +511,8 @@ rte_bpf_exec_burst(const struct rte_bpf *bpf, void *ctx[], uint64_t rc[],
 
 	for (i = 0; i != num; i++) {
 
-		reg[EBPF_REG_1] = (uintptr_t)ctx[i];
-		reg[EBPF_REG_10] = (uintptr_t)(stack + RTE_DIM(stack));
+		reg[BPF_REG_1] = (uintptr_t)ctx[i];
+		reg[BPF_REG_10] = (uintptr_t)(stack + RTE_DIM(stack));
 
 		rc[i] = bpf_exec(bpf, reg);
 	}
@@ -525,32 +525,32 @@ exec_vm_burst_ex(const struct rte_bpf *bpf, const struct rte_bpf_prog_ctx *ctx,
 	uint64_t rc[], uint32_t num)
 {
 	uint32_t i;
-	uint64_t reg[EBPF_REG_NUM];
+	uint64_t reg[MAX_BPF_REG];
 	uint64_t stack[MAX_BPF_STACK_SIZE / sizeof(uint64_t)];
 
 	for (i = 0; i != num; i++) {
 
 		switch (bpf->prm.nb_prog_arg) {
 		case 5:
-			reg[EBPF_REG_5] = ctx[i].arg[4].u64;
+			reg[BPF_REG_5] = ctx[i].arg[4].u64;
 			/* FALLTHROUGH */
 		case 4:
-			reg[EBPF_REG_4] = ctx[i].arg[3].u64;
+			reg[BPF_REG_4] = ctx[i].arg[3].u64;
 			/* FALLTHROUGH */
 		case 3:
-			reg[EBPF_REG_3] = ctx[i].arg[2].u64;
+			reg[BPF_REG_3] = ctx[i].arg[2].u64;
 			/* FALLTHROUGH */
 		case 2:
-			reg[EBPF_REG_2] = ctx[i].arg[1].u64;
+			reg[BPF_REG_2] = ctx[i].arg[1].u64;
 			/* FALLTHROUGH */
 		case 1:
-			reg[EBPF_REG_1] = ctx[i].arg[0].u64;
+			reg[BPF_REG_1] = ctx[i].arg[0].u64;
 			/* FALLTHROUGH */
 		case 0:
 			break;
 		}
 
-		reg[EBPF_REG_10] = (uintptr_t)(stack + RTE_DIM(stack));
+		reg[BPF_REG_10] = (uintptr_t)(stack + RTE_DIM(stack));
 
 		rc[i] = bpf_exec(bpf, reg);
 	}
diff --git a/lib/bpf/bpf_impl.h b/lib/bpf/bpf_impl.h
index 76da4d59f50a..d72485871884 100644
--- a/lib/bpf/bpf_impl.h
+++ b/lib/bpf/bpf_impl.h
@@ -89,7 +89,7 @@ bpf_size(uint32_t bpf_op_sz)
 		return sizeof(uint16_t);
 	else if (bpf_op_sz == BPF_W)
 		return sizeof(uint32_t);
-	else if (bpf_op_sz == EBPF_DW)
+	else if (bpf_op_sz == BPF_DW)
 		return sizeof(uint64_t);
 	return 0;
 }
diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
index 7f3ea1b75956..86d114f691e4 100644
--- a/lib/bpf/bpf_jit_arm64.c
+++ b/lib/bpf/bpf_jit_arm64.c
@@ -14,11 +14,11 @@
 #define A64_REG_MASK(r)		((r) & 0x1f)
 #define A64_INVALID_OP_CODE	(UINT32_C(0xffffffff))
 
-#define TMP_REG_1		(EBPF_REG_10 + 1)
-#define TMP_REG_2		(EBPF_REG_10 + 2)
-#define TMP_REG_3		(EBPF_REG_10 + 3)
+#define TMP_REG_1		(BPF_REG_10 + 1)
+#define TMP_REG_2		(BPF_REG_10 + 2)
+#define TMP_REG_3		(BPF_REG_10 + 3)
 
-#define EBPF_FP			(EBPF_REG_10)
+#define EBPF_FP			(BPF_REG_10)
 #define EBPF_OP_GET(op)		(BPF_OP(op) >> 4)
 
 #define A64_R(x)		x
@@ -42,7 +42,7 @@ struct a64_jit_ctx {
 	uint32_t idx;             /* Current instruction index */
 	uint32_t program_start;   /* Program index, Just after prologue */
 	uint32_t program_sz;      /* Program size. Found in first pass */
-	uint8_t foundcall;        /* Found EBPF_CALL class code in eBPF pgm */
+	uint8_t foundcall;        /* Found BPF_CALL class code in eBPF pgm */
 };
 
 static int
@@ -70,7 +70,7 @@ check_mov_hw(bool is64, const uint8_t val)
 static int
 check_ls_sz(uint8_t sz)
 {
-	if (sz == BPF_B || sz == BPF_H || sz == BPF_W || sz == EBPF_DW)
+	if (sz == BPF_B || sz == BPF_H || sz == BPF_W || sz == BPF_DW)
 		return 0;
 
 	return 1;
@@ -190,22 +190,22 @@ ebpf_to_a64_cond(uint8_t op)
 		return A64_EQ;
 	case BPF_JGT:
 		return A64_HI;
-	case EBPF_JLT:
+	case BPF_JLT:
 		return A64_CC;
 	case BPF_JGE:
 		return A64_CS;
-	case EBPF_JLE:
+	case BPF_JLE:
 		return A64_LS;
 	case BPF_JSET:
-	case EBPF_JNE:
+	case BPF_JNE:
 		return A64_NE;
-	case EBPF_JSGT:
+	case BPF_JSGT:
 		return A64_GT;
-	case EBPF_JSLT:
+	case BPF_JSLT:
 		return A64_LT;
-	case EBPF_JSGE:
+	case BPF_JSGE:
 		return A64_GE;
-	case EBPF_JSLE:
+	case BPF_JSLE:
 		return A64_LE;
 	default:
 		return UINT8_MAX;
@@ -402,7 +402,7 @@ emit_ls(struct a64_jit_ctx *ctx, uint8_t sz, uint8_t rt, uint8_t rn, uint8_t rm,
 		insn |= RTE_SHIFT_VAL32(1, 30);
 	else if (sz == BPF_W)
 		insn |= RTE_SHIFT_VAL32(2, 30);
-	else if (sz == EBPF_DW)
+	else if (sz == BPF_DW)
 		insn |= RTE_SHIFT_VAL32(3, 30);
 
 	insn |= RTE_SHIFT_VAL32(rm, 16);
@@ -726,18 +726,18 @@ ebpf_to_a64_reg(struct a64_jit_ctx *ctx, uint8_t reg)
 {
 	const uint32_t ebpf2a64_has_call[] = {
 		/* Map A64 R7 register as EBPF return register */
-		[EBPF_REG_0] = A64_R(7),
+		[BPF_REG_0] = A64_R(7),
 		/* Map A64 arguments register as EBPF arguments register */
-		[EBPF_REG_1] = A64_R(0),
-		[EBPF_REG_2] = A64_R(1),
-		[EBPF_REG_3] = A64_R(2),
-		[EBPF_REG_4] = A64_R(3),
-		[EBPF_REG_5] = A64_R(4),
+		[BPF_REG_1] = A64_R(0),
+		[BPF_REG_2] = A64_R(1),
+		[BPF_REG_3] = A64_R(2),
+		[BPF_REG_4] = A64_R(3),
+		[BPF_REG_5] = A64_R(4),
 		/* Map A64 callee save register as EBPF callee save register */
-		[EBPF_REG_6] = A64_R(19),
-		[EBPF_REG_7] = A64_R(20),
-		[EBPF_REG_8] = A64_R(21),
-		[EBPF_REG_9] = A64_R(22),
+		[BPF_REG_6] = A64_R(19),
+		[BPF_REG_7] = A64_R(20),
+		[BPF_REG_8] = A64_R(21),
+		[BPF_REG_9] = A64_R(22),
 		[EBPF_FP]    = A64_R(25),
 		/* Map A64 scratch registers as temporary storage */
 		[TMP_REG_1] = A64_R(9),
@@ -747,21 +747,21 @@ ebpf_to_a64_reg(struct a64_jit_ctx *ctx, uint8_t reg)
 
 	const uint32_t ebpf2a64_no_call[] = {
 		/* Map A64 R7 register as EBPF return register */
-		[EBPF_REG_0] = A64_R(7),
+		[BPF_REG_0] = A64_R(7),
 		/* Map A64 arguments register as EBPF arguments register */
-		[EBPF_REG_1] = A64_R(0),
-		[EBPF_REG_2] = A64_R(1),
-		[EBPF_REG_3] = A64_R(2),
-		[EBPF_REG_4] = A64_R(3),
-		[EBPF_REG_5] = A64_R(4),
+		[BPF_REG_1] = A64_R(0),
+		[BPF_REG_2] = A64_R(1),
+		[BPF_REG_3] = A64_R(2),
+		[BPF_REG_4] = A64_R(3),
+		[BPF_REG_5] = A64_R(4),
 		/*
-		 * EBPF program does not have EBPF_CALL op code,
+		 * EBPF program does not have BPF_CALL op code,
 		 * Map A64 scratch registers as EBPF callee save registers.
 		 */
-		[EBPF_REG_6] = A64_R(9),
-		[EBPF_REG_7] = A64_R(10),
-		[EBPF_REG_8] = A64_R(11),
-		[EBPF_REG_9] = A64_R(12),
+		[BPF_REG_6] = A64_R(9),
+		[BPF_REG_7] = A64_R(10),
+		[BPF_REG_8] = A64_R(11),
+		[BPF_REG_9] = A64_R(12),
 		/* Map A64 FP register as EBPF FP register */
 		[EBPF_FP]    = A64_FP,
 		/* Map remaining A64 scratch registers as temporary storage */
@@ -795,10 +795,10 @@ emit_prologue_has_call(struct a64_jit_ctx *ctx)
 {
 	uint8_t r6, r7, r8, r9, fp;
 
-	r6 = ebpf_to_a64_reg(ctx, EBPF_REG_6);
-	r7 = ebpf_to_a64_reg(ctx, EBPF_REG_7);
-	r8 = ebpf_to_a64_reg(ctx, EBPF_REG_8);
-	r9 = ebpf_to_a64_reg(ctx, EBPF_REG_9);
+	r6 = ebpf_to_a64_reg(ctx, BPF_REG_6);
+	r7 = ebpf_to_a64_reg(ctx, BPF_REG_7);
+	r8 = ebpf_to_a64_reg(ctx, BPF_REG_8);
+	r9 = ebpf_to_a64_reg(ctx, BPF_REG_9);
 	fp = ebpf_to_a64_reg(ctx, EBPF_FP);
 
 	/*
@@ -842,12 +842,12 @@ emit_epilogue_has_call(struct a64_jit_ctx *ctx)
 {
 	uint8_t r6, r7, r8, r9, fp, r0;
 
-	r6 = ebpf_to_a64_reg(ctx, EBPF_REG_6);
-	r7 = ebpf_to_a64_reg(ctx, EBPF_REG_7);
-	r8 = ebpf_to_a64_reg(ctx, EBPF_REG_8);
-	r9 = ebpf_to_a64_reg(ctx, EBPF_REG_9);
+	r6 = ebpf_to_a64_reg(ctx, BPF_REG_6);
+	r7 = ebpf_to_a64_reg(ctx, BPF_REG_7);
+	r8 = ebpf_to_a64_reg(ctx, BPF_REG_8);
+	r9 = ebpf_to_a64_reg(ctx, BPF_REG_9);
 	fp = ebpf_to_a64_reg(ctx, EBPF_FP);
-	r0 = ebpf_to_a64_reg(ctx, EBPF_REG_0);
+	r0 = ebpf_to_a64_reg(ctx, BPF_REG_0);
 
 	if (ctx->stack_sz)
 		emit_add_imm_64(ctx, A64_SP, A64_SP, ctx->stack_sz);
@@ -863,7 +863,7 @@ static void
 emit_prologue_no_call(struct a64_jit_ctx *ctx)
 {
 	/*
-	 * eBPF prog stack layout without EBPF_CALL opcode
+	 * eBPF prog stack layout without BPF_CALL opcode
 	 *
 	 *                               high
 	 *    eBPF prologue(EBPF_FP) 0:+-----+ <= original A64_SP/current A64_FP
@@ -891,7 +891,7 @@ emit_epilogue_no_call(struct a64_jit_ctx *ctx)
 {
 	if (ctx->stack_sz)
 		emit_add_imm_64(ctx, A64_SP, A64_SP, ctx->stack_sz);
-	emit_mov_64(ctx, A64_R(0), ebpf_to_a64_reg(ctx, EBPF_REG_0));
+	emit_mov_64(ctx, A64_R(0), ebpf_to_a64_reg(ctx, BPF_REG_0));
 	emit_ret(ctx);
 }
 
@@ -920,7 +920,7 @@ emit_epilogue(struct a64_jit_ctx *ctx)
 static void
 emit_call(struct a64_jit_ctx *ctx, uint8_t tmp, void *func)
 {
-	uint8_t r0 = ebpf_to_a64_reg(ctx, EBPF_REG_0);
+	uint8_t r0 = ebpf_to_a64_reg(ctx, BPF_REG_0);
 
 	emit_mov_imm(ctx, 1, tmp, (uint64_t)func);
 	emit_blr(ctx, tmp);
@@ -956,7 +956,7 @@ emit_b(struct a64_jit_ctx *ctx, int32_t imm26)
 static void
 emit_return_zero_if_src_zero(struct a64_jit_ctx *ctx, bool is64, uint8_t src)
 {
-	uint8_t r0 = ebpf_to_a64_reg(ctx, EBPF_REG_0);
+	uint8_t r0 = ebpf_to_a64_reg(ctx, BPF_REG_0);
 	uint16_t jump_to_epilogue;
 
 	emit_cbnz(ctx, is64, src, 3);
@@ -1035,7 +1035,7 @@ static void
 emit_atomic(struct a64_jit_ctx *ctx, uint8_t op, uint8_t tmp1, uint8_t tmp2,
 	  uint8_t tmp3, uint8_t dst, int16_t off, uint8_t src, int32_t atomic_op)
 {
-	bool is64 = (BPF_SIZE(op) == EBPF_DW);
+	bool is64 = (BPF_SIZE(op) == BPF_DW);
 	uint8_t rn;
 
 	if (off) {
@@ -1047,7 +1047,7 @@ emit_atomic(struct a64_jit_ctx *ctx, uint8_t op, uint8_t tmp1, uint8_t tmp2,
 	}
 
 	switch (atomic_op) {
-	case BPF_ATOMIC_ADD:
+	case BPF_ADD:
 		if (has_atomics()) {
 			emit_stadd(ctx, is64, src, rn);
 		} else {
@@ -1057,7 +1057,7 @@ emit_atomic(struct a64_jit_ctx *ctx, uint8_t op, uint8_t tmp1, uint8_t tmp2,
 			emit_cbnz(ctx, is64, tmp3, -3);
 		}
 		break;
-	case BPF_ATOMIC_XCHG:
+	case BPF_XCHG:
 		if (has_atomics()) {
 			emit_swpal(ctx, is64, src, src, rn);
 		} else {
@@ -1069,7 +1069,7 @@ emit_atomic(struct a64_jit_ctx *ctx, uint8_t op, uint8_t tmp1, uint8_t tmp2,
 		break;
 	default:
 		/* this should be caught by validator and never reach here */
-		emit_mov_imm(ctx, 1, ebpf_to_a64_reg(ctx, EBPF_REG_0), 0);
+		emit_mov_imm(ctx, 1, ebpf_to_a64_reg(ctx, BPF_REG_0), 0);
 		emit_epilogue(ctx);
 		return;
 	}
@@ -1136,7 +1136,7 @@ check_program_has_call(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
 
 		switch (op) {
 		/* Call imm */
-		case (BPF_JMP | EBPF_CALL):
+		case (BPF_JMP | BPF_CALL):
 			ctx->foundcall = 1;
 			return;
 		}
@@ -1178,162 +1178,162 @@ emit(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
 
 		dst = ebpf_to_a64_reg(ctx, ins->dst_reg);
 		src = ebpf_to_a64_reg(ctx, ins->src_reg);
-		is64 = (BPF_CLASS(op) == EBPF_ALU64);
+		is64 = (BPF_CLASS(op) == BPF_ALU64);
 
 		switch (op) {
 		/* dst = src */
-		case (BPF_ALU | EBPF_MOV | BPF_X):
-		case (EBPF_ALU64 | EBPF_MOV | BPF_X):
+		case (BPF_ALU | BPF_MOV | BPF_X):
+		case (BPF_ALU64 | BPF_MOV | BPF_X):
 			emit_mov(ctx, is64, dst, src);
 			break;
 		/* dst = imm */
-		case (BPF_ALU | EBPF_MOV | BPF_K):
-		case (EBPF_ALU64 | EBPF_MOV | BPF_K):
+		case (BPF_ALU | BPF_MOV | BPF_K):
+		case (BPF_ALU64 | BPF_MOV | BPF_K):
 			emit_mov_imm(ctx, is64, dst, imm);
 			break;
 		/* dst += src */
 		case (BPF_ALU | BPF_ADD | BPF_X):
-		case (EBPF_ALU64 | BPF_ADD | BPF_X):
+		case (BPF_ALU64 | BPF_ADD | BPF_X):
 			emit_add(ctx, is64, dst, src);
 			break;
 		/* dst += imm */
 		case (BPF_ALU | BPF_ADD | BPF_K):
-		case (EBPF_ALU64 | BPF_ADD | BPF_K):
+		case (BPF_ALU64 | BPF_ADD | BPF_K):
 			emit_mov_imm(ctx, is64, tmp1, imm);
 			emit_add(ctx, is64, dst, tmp1);
 			break;
 		/* dst -= src */
 		case (BPF_ALU | BPF_SUB | BPF_X):
-		case (EBPF_ALU64 | BPF_SUB | BPF_X):
+		case (BPF_ALU64 | BPF_SUB | BPF_X):
 			emit_sub(ctx, is64, dst, src);
 			break;
 		/* dst -= imm */
 		case (BPF_ALU | BPF_SUB | BPF_K):
-		case (EBPF_ALU64 | BPF_SUB | BPF_K):
+		case (BPF_ALU64 | BPF_SUB | BPF_K):
 			emit_mov_imm(ctx, is64, tmp1, imm);
 			emit_sub(ctx, is64, dst, tmp1);
 			break;
 		/* dst *= src */
 		case (BPF_ALU | BPF_MUL | BPF_X):
-		case (EBPF_ALU64 | BPF_MUL | BPF_X):
+		case (BPF_ALU64 | BPF_MUL | BPF_X):
 			emit_mul(ctx, is64, dst, src);
 			break;
 		/* dst *= imm */
 		case (BPF_ALU | BPF_MUL | BPF_K):
-		case (EBPF_ALU64 | BPF_MUL | BPF_K):
+		case (BPF_ALU64 | BPF_MUL | BPF_K):
 			emit_mov_imm(ctx, is64, tmp1, imm);
 			emit_mul(ctx, is64, dst, tmp1);
 			break;
 		/* dst /= src */
 		case (BPF_ALU | BPF_DIV | BPF_X):
-		case (EBPF_ALU64 | BPF_DIV | BPF_X):
+		case (BPF_ALU64 | BPF_DIV | BPF_X):
 			emit_return_zero_if_src_zero(ctx, is64, src);
 			emit_div(ctx, is64, dst, src);
 			break;
 		/* dst /= imm */
 		case (BPF_ALU | BPF_DIV | BPF_K):
-		case (EBPF_ALU64 | BPF_DIV | BPF_K):
+		case (BPF_ALU64 | BPF_DIV | BPF_K):
 			emit_mov_imm(ctx, is64, tmp1, imm);
 			emit_div(ctx, is64, dst, tmp1);
 			break;
 		/* dst %= src */
 		case (BPF_ALU | BPF_MOD | BPF_X):
-		case (EBPF_ALU64 | BPF_MOD | BPF_X):
+		case (BPF_ALU64 | BPF_MOD | BPF_X):
 			emit_return_zero_if_src_zero(ctx, is64, src);
 			emit_mod(ctx, is64, tmp1, dst, src);
 			break;
 		/* dst %= imm */
 		case (BPF_ALU | BPF_MOD | BPF_K):
-		case (EBPF_ALU64 | BPF_MOD | BPF_K):
+		case (BPF_ALU64 | BPF_MOD | BPF_K):
 			emit_mov_imm(ctx, is64, tmp1, imm);
 			emit_mod(ctx, is64, tmp2, dst, tmp1);
 			break;
 		/* dst |= src */
 		case (BPF_ALU | BPF_OR | BPF_X):
-		case (EBPF_ALU64 | BPF_OR | BPF_X):
+		case (BPF_ALU64 | BPF_OR | BPF_X):
 			emit_or(ctx, is64, dst, src);
 			break;
 		/* dst |= imm */
 		case (BPF_ALU | BPF_OR | BPF_K):
-		case (EBPF_ALU64 | BPF_OR | BPF_K):
+		case (BPF_ALU64 | BPF_OR | BPF_K):
 			emit_mov_imm(ctx, is64, tmp1, imm);
 			emit_or(ctx, is64, dst, tmp1);
 			break;
 		/* dst &= src */
 		case (BPF_ALU | BPF_AND | BPF_X):
-		case (EBPF_ALU64 | BPF_AND | BPF_X):
+		case (BPF_ALU64 | BPF_AND | BPF_X):
 			emit_and(ctx, is64, dst, src);
 			break;
 		/* dst &= imm */
 		case (BPF_ALU | BPF_AND | BPF_K):
-		case (EBPF_ALU64 | BPF_AND | BPF_K):
+		case (BPF_ALU64 | BPF_AND | BPF_K):
 			emit_mov_imm(ctx, is64, tmp1, imm);
 			emit_and(ctx, is64, dst, tmp1);
 			break;
 		/* dst ^= src */
 		case (BPF_ALU | BPF_XOR | BPF_X):
-		case (EBPF_ALU64 | BPF_XOR | BPF_X):
+		case (BPF_ALU64 | BPF_XOR | BPF_X):
 			emit_xor(ctx, is64, dst, src);
 			break;
 		/* dst ^= imm */
 		case (BPF_ALU | BPF_XOR | BPF_K):
-		case (EBPF_ALU64 | BPF_XOR | BPF_K):
+		case (BPF_ALU64 | BPF_XOR | BPF_K):
 			emit_mov_imm(ctx, is64, tmp1, imm);
 			emit_xor(ctx, is64, dst, tmp1);
 			break;
 		/* dst = -dst */
 		case (BPF_ALU | BPF_NEG):
-		case (EBPF_ALU64 | BPF_NEG):
+		case (BPF_ALU64 | BPF_NEG):
 			emit_neg(ctx, is64, dst);
 			break;
 		/* dst <<= src */
 		case BPF_ALU | BPF_LSH | BPF_X:
-		case EBPF_ALU64 | BPF_LSH | BPF_X:
+		case BPF_ALU64 | BPF_LSH | BPF_X:
 			emit_lslv(ctx, is64, dst, src);
 			break;
 		/* dst <<= imm */
 		case BPF_ALU | BPF_LSH | BPF_K:
-		case EBPF_ALU64 | BPF_LSH | BPF_K:
+		case BPF_ALU64 | BPF_LSH | BPF_K:
 			emit_lsl(ctx, is64, dst, imm);
 			break;
 		/* dst >>= src */
 		case BPF_ALU | BPF_RSH | BPF_X:
-		case EBPF_ALU64 | BPF_RSH | BPF_X:
+		case BPF_ALU64 | BPF_RSH | BPF_X:
 			emit_lsrv(ctx, is64, dst, src);
 			break;
 		/* dst >>= imm */
 		case BPF_ALU | BPF_RSH | BPF_K:
-		case EBPF_ALU64 | BPF_RSH | BPF_K:
+		case BPF_ALU64 | BPF_RSH | BPF_K:
 			emit_lsr(ctx, is64, dst, imm);
 			break;
 		/* dst >>= src (arithmetic) */
-		case BPF_ALU | EBPF_ARSH | BPF_X:
-		case EBPF_ALU64 | EBPF_ARSH | BPF_X:
+		case BPF_ALU | BPF_ARSH | BPF_X:
+		case BPF_ALU64 | BPF_ARSH | BPF_X:
 			emit_asrv(ctx, is64, dst, src);
 			break;
 		/* dst >>= imm (arithmetic) */
-		case BPF_ALU | EBPF_ARSH | BPF_K:
-		case EBPF_ALU64 | EBPF_ARSH | BPF_K:
+		case BPF_ALU | BPF_ARSH | BPF_K:
+		case BPF_ALU64 | BPF_ARSH | BPF_K:
 			emit_asr(ctx, is64, dst, imm);
 			break;
 		/* dst = be##imm(dst) */
-		case (BPF_ALU | EBPF_END | EBPF_TO_BE):
+		case (BPF_ALU | BPF_END | BPF_TO_BE):
 			emit_be(ctx, dst, imm);
 			break;
 		/* dst = le##imm(dst) */
-		case (BPF_ALU | EBPF_END | EBPF_TO_LE):
+		case (BPF_ALU | BPF_END | BPF_TO_LE):
 			emit_le(ctx, dst, imm);
 			break;
 		/* dst = *(size *) (src + off) */
 		case (BPF_LDX | BPF_MEM | BPF_B):
 		case (BPF_LDX | BPF_MEM | BPF_H):
 		case (BPF_LDX | BPF_MEM | BPF_W):
-		case (BPF_LDX | BPF_MEM | EBPF_DW):
+		case (BPF_LDX | BPF_MEM | BPF_DW):
 			emit_mov_imm(ctx, 1, tmp1, off);
 			emit_ldr(ctx, BPF_SIZE(op), dst, src, tmp1);
 			break;
 		/* dst = imm64 */
-		case (BPF_LD | BPF_IMM | EBPF_DW):
+		case (BPF_LD | BPF_IMM | BPF_DW):
 			u64 = RTE_SHIFT_VAL64(ins[1].imm, 32) | (uint32_t)imm;
 			emit_mov_imm(ctx, 1, dst, u64);
 			i++;
@@ -1342,7 +1342,7 @@ emit(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
 		case (BPF_STX | BPF_MEM | BPF_B):
 		case (BPF_STX | BPF_MEM | BPF_H):
 		case (BPF_STX | BPF_MEM | BPF_W):
-		case (BPF_STX | BPF_MEM | EBPF_DW):
+		case (BPF_STX | BPF_MEM | BPF_DW):
 			emit_mov_imm(ctx, 1, tmp1, off);
 			emit_str(ctx, BPF_SIZE(op), src, dst, tmp1);
 			break;
@@ -1350,14 +1350,14 @@ emit(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
 		case (BPF_ST | BPF_MEM | BPF_B):
 		case (BPF_ST | BPF_MEM | BPF_H):
 		case (BPF_ST | BPF_MEM | BPF_W):
-		case (BPF_ST | BPF_MEM | EBPF_DW):
+		case (BPF_ST | BPF_MEM | BPF_DW):
 			emit_mov_imm(ctx, 1, tmp1, imm);
 			emit_mov_imm(ctx, 1, tmp2, off);
 			emit_str(ctx, BPF_SIZE(op), tmp1, dst, tmp2);
 			break;
 		/* lock *(size *)(dst + off) += src or xchg(dst + off, &src) */
-		case (BPF_STX | EBPF_ATOMIC | BPF_W):
-		case (BPF_STX | EBPF_ATOMIC | EBPF_DW):
+		case (BPF_STX | BPF_ATOMIC | BPF_W):
+		case (BPF_STX | BPF_ATOMIC | BPF_DW):
 			emit_atomic(ctx, op, tmp1, tmp2, tmp3, dst, off, src, imm);
 			break;
 		/* PC += off */
@@ -1366,15 +1366,15 @@ emit(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
 			break;
 		/* PC += off if dst COND imm */
 		case (BPF_JMP | BPF_JEQ | BPF_K):
-		case (BPF_JMP | EBPF_JNE | BPF_K):
+		case (BPF_JMP | BPF_JNE | BPF_K):
 		case (BPF_JMP | BPF_JGT | BPF_K):
-		case (BPF_JMP | EBPF_JLT | BPF_K):
+		case (BPF_JMP | BPF_JLT | BPF_K):
 		case (BPF_JMP | BPF_JGE | BPF_K):
-		case (BPF_JMP | EBPF_JLE | BPF_K):
-		case (BPF_JMP | EBPF_JSGT | BPF_K):
-		case (BPF_JMP | EBPF_JSLT | BPF_K):
-		case (BPF_JMP | EBPF_JSGE | BPF_K):
-		case (BPF_JMP | EBPF_JSLE | BPF_K):
+		case (BPF_JMP | BPF_JLE | BPF_K):
+		case (BPF_JMP | BPF_JSGT | BPF_K):
+		case (BPF_JMP | BPF_JSLT | BPF_K):
+		case (BPF_JMP | BPF_JSGE | BPF_K):
+		case (BPF_JMP | BPF_JSLE | BPF_K):
 			emit_mov_imm(ctx, 1, tmp1, imm);
 			emit_cmp(ctx, 1, dst, tmp1);
 			emit_branch(ctx, op, i, off);
@@ -1386,15 +1386,15 @@ emit(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
 			break;
 		/* PC += off if dst COND src */
 		case (BPF_JMP | BPF_JEQ | BPF_X):
-		case (BPF_JMP | EBPF_JNE | BPF_X):
+		case (BPF_JMP | BPF_JNE | BPF_X):
 		case (BPF_JMP | BPF_JGT | BPF_X):
-		case (BPF_JMP | EBPF_JLT | BPF_X):
+		case (BPF_JMP | BPF_JLT | BPF_X):
 		case (BPF_JMP | BPF_JGE | BPF_X):
-		case (BPF_JMP | EBPF_JLE | BPF_X):
-		case (BPF_JMP | EBPF_JSGT | BPF_X):
-		case (BPF_JMP | EBPF_JSLT | BPF_X):
-		case (BPF_JMP | EBPF_JSGE | BPF_X):
-		case (BPF_JMP | EBPF_JSLE | BPF_X):
+		case (BPF_JMP | BPF_JLE | BPF_X):
+		case (BPF_JMP | BPF_JSGT | BPF_X):
+		case (BPF_JMP | BPF_JSLT | BPF_X):
+		case (BPF_JMP | BPF_JSGE | BPF_X):
+		case (BPF_JMP | BPF_JSLE | BPF_X):
 			emit_cmp(ctx, 1, dst, src);
 			emit_branch(ctx, op, i, off);
 			break;
@@ -1403,11 +1403,11 @@ emit(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
 			emit_branch(ctx, op, i, off);
 			break;
 		/* Call imm */
-		case (BPF_JMP | EBPF_CALL):
+		case (BPF_JMP | BPF_CALL):
 			emit_call(ctx, tmp1, bpf->prm.xsym[ins->imm].func.val);
 			break;
 		/* Return r0 */
-		case (BPF_JMP | EBPF_EXIT):
+		case (BPF_JMP | BPF_EXIT):
 			emit_epilogue(ctx);
 			break;
 		default:
diff --git a/lib/bpf/bpf_jit_x86.c b/lib/bpf/bpf_jit_x86.c
index 37da3bc6a53e..a56ed10efe23 100644
--- a/lib/bpf/bpf_jit_x86.c
+++ b/lib/bpf/bpf_jit_x86.c
@@ -60,17 +60,17 @@ enum {
  * eBPF to x86_64 register mappings.
  */
 static const uint32_t ebpf2x86[] = {
-	[EBPF_REG_0] = RAX,
-	[EBPF_REG_1] = RDI,
-	[EBPF_REG_2] = RSI,
-	[EBPF_REG_3] = RDX,
-	[EBPF_REG_4] = RCX,
-	[EBPF_REG_5] = R8,
-	[EBPF_REG_6] = RBX,
-	[EBPF_REG_7] = R13,
-	[EBPF_REG_8] = R14,
-	[EBPF_REG_9] = R15,
-	[EBPF_REG_10] = RBP,
+	[BPF_REG_0] = RAX,
+	[BPF_REG_1] = RDI,
+	[BPF_REG_2] = RSI,
+	[BPF_REG_3] = RDX,
+	[BPF_REG_4] = RCX,
+	[BPF_REG_5] = R8,
+	[BPF_REG_6] = RBX,
+	[BPF_REG_7] = R13,
+	[BPF_REG_8] = R14,
+	[BPF_REG_9] = R15,
+	[BPF_REG_10] = RBP,
 };
 
 /*
@@ -166,11 +166,11 @@ emit_rex(struct bpf_jit_state *st, uint32_t op, uint32_t reg, uint32_t rm)
 	USED(st->reguse, rm);
 
 	rex = 0;
-	if (BPF_CLASS(op) == EBPF_ALU64 ||
-			op == (BPF_ST | BPF_MEM | EBPF_DW) ||
-			op == (BPF_STX | BPF_MEM | EBPF_DW) ||
-			op == (BPF_STX | EBPF_ATOMIC | EBPF_DW) ||
-			op == (BPF_LD | BPF_IMM | EBPF_DW) ||
+	if (BPF_CLASS(op) == BPF_ALU64 ||
+			op == (BPF_ST | BPF_MEM | BPF_DW) ||
+			op == (BPF_STX | BPF_MEM | BPF_DW) ||
+			op == (BPF_STX | BPF_ATOMIC | BPF_DW) ||
+			op == (BPF_LD | BPF_IMM | BPF_DW) ||
 			(BPF_CLASS(op) == BPF_LDX &&
 			BPF_MODE(op) == BPF_MEM &&
 			BPF_SIZE(op) != BPF_W))
@@ -237,7 +237,7 @@ emit_xchg_reg(struct bpf_jit_state *st, uint32_t sreg, uint32_t dreg)
 {
 	const uint8_t ops = 0x87;
 
-	emit_rex(st, EBPF_ALU64, sreg, dreg);
+	emit_rex(st, BPF_ALU64, sreg, dreg);
 	emit_bytes(st, &ops, sizeof(ops));
 	emit_modregrm(st, MOD_DIRECT, sreg, dreg);
 }
@@ -314,7 +314,7 @@ emit_be2le_48(struct bpf_jit_state *st, uint32_t dreg, uint32_t imm)
 	const uint8_t ops = 0x0F;
 	const uint8_t mods = 1;
 
-	rop = (imm == 64) ? EBPF_ALU64 : BPF_ALU;
+	rop = (imm == 64) ? BPF_ALU64 : BPF_ALU;
 	emit_rex(st, rop, 0, dreg);
 	emit_bytes(st, &ops, sizeof(ops));
 	emit_modregrm(st, MOD_DIRECT, mods, dreg);
@@ -340,7 +340,7 @@ emit_le2be(struct bpf_jit_state *st, uint32_t dreg, uint32_t imm)
 	if (imm == 16)
 		emit_movzwl(st, dreg, dreg);
 	else if (imm == 32)
-		emit_mov_reg(st, BPF_ALU | EBPF_MOV | BPF_X, dreg, dreg);
+		emit_mov_reg(st, BPF_ALU | BPF_MOV | BPF_X, dreg, dreg);
 }
 
 /*
@@ -418,7 +418,7 @@ emit_shift(struct bpf_jit_state *st, uint32_t op, uint32_t dreg)
 	static const uint8_t mods[] = {
 		[GET_BPF_OP(BPF_LSH)] = 4,
 		[GET_BPF_OP(BPF_RSH)] = 5,
-		[GET_BPF_OP(EBPF_ARSH)] = 7,
+		[GET_BPF_OP(BPF_ARSH)] = 7,
 	};
 
 	bop = GET_BPF_OP(op);
@@ -497,7 +497,7 @@ emit_ld_imm64(struct bpf_jit_state *st, uint32_t dreg, uint32_t imm0,
 
 	const uint8_t ops = 0xB8;
 
-	op = (imm1 == 0) ? BPF_ALU : EBPF_ALU64;
+	op = (imm1 == 0) ? BPF_ALU : BPF_ALU64;
 
 	emit_rex(st, op, 0, dreg);
 	emit_opcode(st, ops, dreg);
@@ -531,19 +531,19 @@ emit_mul(struct bpf_jit_state *st, uint32_t op, uint32_t sreg, uint32_t dreg,
 	const uint8_t mods = 4;
 
 	/* save rax & rdx */
-	emit_mov_reg(st, EBPF_ALU64 | EBPF_MOV | BPF_X, RAX, REG_TMP0);
-	emit_mov_reg(st, EBPF_ALU64 | EBPF_MOV | BPF_X, RDX, REG_TMP1);
+	emit_mov_reg(st, BPF_ALU64 | BPF_MOV | BPF_X, RAX, REG_TMP0);
+	emit_mov_reg(st, BPF_ALU64 | BPF_MOV | BPF_X, RDX, REG_TMP1);
 
 	/* rax = dreg */
-	emit_mov_reg(st, EBPF_ALU64 | EBPF_MOV | BPF_X, dreg, RAX);
+	emit_mov_reg(st, BPF_ALU64 | BPF_MOV | BPF_X, dreg, RAX);
 
 	if (BPF_SRC(op) == BPF_X)
 		/* rdx = sreg */
-		emit_mov_reg(st, EBPF_ALU64 | EBPF_MOV | BPF_X,
+		emit_mov_reg(st, BPF_ALU64 | BPF_MOV | BPF_X,
 			sreg == RAX ? REG_TMP0 : sreg, RDX);
 	else
 		/* rdx = imm */
-		emit_mov_imm(st, EBPF_ALU64 | EBPF_MOV | BPF_K, RDX, imm);
+		emit_mov_imm(st, BPF_ALU64 | BPF_MOV | BPF_K, RDX, imm);
 
 	emit_rex(st, op, RAX, RDX);
 	emit_bytes(st, &ops, sizeof(ops));
@@ -551,13 +551,13 @@ emit_mul(struct bpf_jit_state *st, uint32_t op, uint32_t sreg, uint32_t dreg,
 
 	if (dreg != RDX)
 		/* restore rdx */
-		emit_mov_reg(st, EBPF_ALU64 | EBPF_MOV | BPF_X, REG_TMP1, RDX);
+		emit_mov_reg(st, BPF_ALU64 | BPF_MOV | BPF_X, REG_TMP1, RDX);
 
 	if (dreg != RAX) {
 		/* dreg = rax */
-		emit_mov_reg(st, EBPF_ALU64 | EBPF_MOV | BPF_X, RAX, dreg);
+		emit_mov_reg(st, BPF_ALU64 | BPF_MOV | BPF_X, RAX, dreg);
 		/* restore rax */
-		emit_mov_reg(st, EBPF_ALU64 | EBPF_MOV | BPF_X, REG_TMP0, RAX);
+		emit_mov_reg(st, BPF_ALU64 | BPF_MOV | BPF_X, REG_TMP0, RAX);
 	}
 }
 
@@ -670,10 +670,10 @@ emit_st_atomic(struct bpf_jit_state *st, uint32_t op, uint32_t sreg,
 	const uint8_t lck = 0xF0; /* lock prefix */
 
 	switch (atomic_op) {
-	case BPF_ATOMIC_ADD:
+	case BPF_ADD:
 		ops = 0x01; /* add opcode */
 		break;
-	case BPF_ATOMIC_XCHG:
+	case BPF_XCHG:
 		ops = 0x87; /* xchg opcode */
 		break;
 	default:
@@ -687,7 +687,7 @@ emit_st_atomic(struct bpf_jit_state *st, uint32_t op, uint32_t sreg,
 	mods = (imsz == 1) ? MOD_IDISP8 : MOD_IDISP32;
 
 	/* xchg already implies lock */
-	if (atomic_op != BPF_ATOMIC_XCHG)
+	if (atomic_op != BPF_XCHG)
 		emit_bytes(st, &lck, sizeof(lck));
 	emit_rex(st, op, sreg, dreg);
 	emit_bytes(st, &ops, sizeof(ops));
@@ -777,15 +777,15 @@ emit_movcc_reg(struct bpf_jit_state *st, uint32_t op, uint32_t sreg,
 
 	static const uint8_t ops[][2] = {
 		[GET_BPF_OP(BPF_JEQ)] = {0x0F, 0x44},  /* CMOVZ */
-		[GET_BPF_OP(EBPF_JNE)] = {0x0F, 0x45},  /* CMOVNE */
+		[GET_BPF_OP(BPF_JNE)] = {0x0F, 0x45},  /* CMOVNE */
 		[GET_BPF_OP(BPF_JGT)] = {0x0F, 0x47},  /* CMOVA */
-		[GET_BPF_OP(EBPF_JLT)] = {0x0F, 0x42},  /* CMOVB */
+		[GET_BPF_OP(BPF_JLT)] = {0x0F, 0x42},  /* CMOVB */
 		[GET_BPF_OP(BPF_JGE)] = {0x0F, 0x43},  /* CMOVAE */
-		[GET_BPF_OP(EBPF_JLE)] = {0x0F, 0x46},  /* CMOVBE */
-		[GET_BPF_OP(EBPF_JSGT)] = {0x0F, 0x4F}, /* CMOVG */
-		[GET_BPF_OP(EBPF_JSLT)] = {0x0F, 0x4C}, /* CMOVL */
-		[GET_BPF_OP(EBPF_JSGE)] = {0x0F, 0x4D}, /* CMOVGE */
-		[GET_BPF_OP(EBPF_JSLE)] = {0x0F, 0x4E}, /* CMOVLE */
+		[GET_BPF_OP(BPF_JLE)] = {0x0F, 0x46},  /* CMOVBE */
+		[GET_BPF_OP(BPF_JSGT)] = {0x0F, 0x4F}, /* CMOVG */
+		[GET_BPF_OP(BPF_JSLT)] = {0x0F, 0x4C}, /* CMOVL */
+		[GET_BPF_OP(BPF_JSGE)] = {0x0F, 0x4D}, /* CMOVGE */
+		[GET_BPF_OP(BPF_JSLE)] = {0x0F, 0x4E}, /* CMOVLE */
 		[GET_BPF_OP(BPF_JSET)] = {0x0F, 0x45}, /* CMOVNE */
 	};
 
@@ -818,29 +818,29 @@ emit_abs_jcc(struct bpf_jit_state *st, uint32_t op, int32_t ofs)
 
 	static const uint8_t op8[] = {
 		[GET_BPF_OP(BPF_JEQ)] = 0x74,  /* JE */
-		[GET_BPF_OP(EBPF_JNE)] = 0x75,  /* JNE */
+		[GET_BPF_OP(BPF_JNE)] = 0x75,  /* JNE */
 		[GET_BPF_OP(BPF_JGT)] = 0x77,  /* JA */
-		[GET_BPF_OP(EBPF_JLT)] = 0x72,  /* JB */
+		[GET_BPF_OP(BPF_JLT)] = 0x72,  /* JB */
 		[GET_BPF_OP(BPF_JGE)] = 0x73,  /* JAE */
-		[GET_BPF_OP(EBPF_JLE)] = 0x76,  /* JBE */
-		[GET_BPF_OP(EBPF_JSGT)] = 0x7F, /* JG */
-		[GET_BPF_OP(EBPF_JSLT)] = 0x7C, /* JL */
-		[GET_BPF_OP(EBPF_JSGE)] = 0x7D, /*JGE */
-		[GET_BPF_OP(EBPF_JSLE)] = 0x7E, /* JLE */
+		[GET_BPF_OP(BPF_JLE)] = 0x76,  /* JBE */
+		[GET_BPF_OP(BPF_JSGT)] = 0x7F, /* JG */
+		[GET_BPF_OP(BPF_JSLT)] = 0x7C, /* JL */
+		[GET_BPF_OP(BPF_JSGE)] = 0x7D, /*JGE */
+		[GET_BPF_OP(BPF_JSLE)] = 0x7E, /* JLE */
 		[GET_BPF_OP(BPF_JSET)] = 0x75, /*JNE */
 	};
 
 	static const uint8_t op32[][2] = {
 		[GET_BPF_OP(BPF_JEQ)] = {0x0F, 0x84},  /* JE */
-		[GET_BPF_OP(EBPF_JNE)] = {0x0F, 0x85},  /* JNE */
+		[GET_BPF_OP(BPF_JNE)] = {0x0F, 0x85},  /* JNE */
 		[GET_BPF_OP(BPF_JGT)] = {0x0F, 0x87},  /* JA */
-		[GET_BPF_OP(EBPF_JLT)] = {0x0F, 0x82},  /* JB */
+		[GET_BPF_OP(BPF_JLT)] = {0x0F, 0x82},  /* JB */
 		[GET_BPF_OP(BPF_JGE)] = {0x0F, 0x83},  /* JAE */
-		[GET_BPF_OP(EBPF_JLE)] = {0x0F, 0x86},  /* JBE */
-		[GET_BPF_OP(EBPF_JSGT)] = {0x0F, 0x8F}, /* JG */
-		[GET_BPF_OP(EBPF_JSLT)] = {0x0F, 0x8C}, /* JL */
-		[GET_BPF_OP(EBPF_JSGE)] = {0x0F, 0x8D}, /*JGE */
-		[GET_BPF_OP(EBPF_JSLE)] = {0x0F, 0x8E}, /* JLE */
+		[GET_BPF_OP(BPF_JLE)] = {0x0F, 0x86},  /* JBE */
+		[GET_BPF_OP(BPF_JSGT)] = {0x0F, 0x8F}, /* JG */
+		[GET_BPF_OP(BPF_JSLT)] = {0x0F, 0x8C}, /* JL */
+		[GET_BPF_OP(BPF_JSGE)] = {0x0F, 0x8D}, /*JGE */
+		[GET_BPF_OP(BPF_JSLE)] = {0x0F, 0x8E}, /* JLE */
 		[GET_BPF_OP(BPF_JSET)] = {0x0F, 0x85}, /*JNE */
 	};
 
@@ -929,9 +929,9 @@ emit_jcc_imm(struct bpf_jit_state *st, uint32_t op, uint32_t dreg,
 	uint32_t imm, int32_t ofs)
 {
 	if (BPF_OP(op) == BPF_JSET)
-		emit_tst_imm(st, EBPF_ALU64, dreg, imm);
+		emit_tst_imm(st, BPF_ALU64, dreg, imm);
 	else
-		emit_cmp_imm(st, EBPF_ALU64, dreg, imm);
+		emit_cmp_imm(st, BPF_ALU64, dreg, imm);
 
 	emit_jcc(st, op, ofs);
 }
@@ -970,9 +970,9 @@ emit_jcc_reg(struct bpf_jit_state *st, uint32_t op, uint32_t sreg,
 	uint32_t dreg, int32_t ofs)
 {
 	if (BPF_OP(op) == BPF_JSET)
-		emit_tst_reg(st, EBPF_ALU64, sreg, dreg);
+		emit_tst_reg(st, BPF_ALU64, sreg, dreg);
 	else
-		emit_cmp_reg(st, EBPF_ALU64, sreg, dreg);
+		emit_cmp_reg(st, BPF_ALU64, sreg, dreg);
 
 	emit_jcc(st, op, ofs);
 }
@@ -1019,13 +1019,13 @@ emit_div(struct bpf_jit_state *st, uint32_t op, uint32_t sreg, uint32_t dreg,
 
 	/* save rax & rdx */
 	if (dreg != RAX)
-		emit_mov_reg(st, EBPF_ALU64 | EBPF_MOV | BPF_X, RAX, REG_TMP0);
+		emit_mov_reg(st, BPF_ALU64 | BPF_MOV | BPF_X, RAX, REG_TMP0);
 	if (dreg != RDX)
-		emit_mov_reg(st, EBPF_ALU64 | EBPF_MOV | BPF_X, RDX, REG_TMP1);
+		emit_mov_reg(st, BPF_ALU64 | BPF_MOV | BPF_X, RDX, REG_TMP1);
 
 	/* fill rax & rdx */
-	emit_mov_reg(st, EBPF_ALU64 | EBPF_MOV | BPF_X, dreg, RAX);
-	emit_mov_imm(st, EBPF_ALU64 | EBPF_MOV | BPF_K, RDX, 0);
+	emit_mov_reg(st, BPF_ALU64 | BPF_MOV | BPF_X, dreg, RAX);
+	emit_mov_imm(st, BPF_ALU64 | BPF_MOV | BPF_K, RDX, 0);
 
 	if (BPF_SRC(op) == BPF_X) {
 		sr = sreg;
@@ -1035,7 +1035,7 @@ emit_div(struct bpf_jit_state *st, uint32_t op, uint32_t sreg, uint32_t dreg,
 			sr = REG_TMP1;
 	} else {
 		sr = REG_DIV_IMM;
-		emit_mov_imm(st, EBPF_ALU64 | EBPF_MOV | BPF_K, sr, imm);
+		emit_mov_imm(st, BPF_ALU64 | BPF_MOV | BPF_K, sr, imm);
 	}
 
 	emit_rex(st, op, 0, sr);
@@ -1043,14 +1043,14 @@ emit_div(struct bpf_jit_state *st, uint32_t op, uint32_t sreg, uint32_t dreg,
 	emit_modregrm(st, MOD_DIRECT, mods, sr);
 
 	if (BPF_OP(op) == BPF_DIV)
-		emit_mov_reg(st, EBPF_ALU64 | EBPF_MOV | BPF_X, RAX, dreg);
+		emit_mov_reg(st, BPF_ALU64 | BPF_MOV | BPF_X, RAX, dreg);
 	else
-		emit_mov_reg(st, EBPF_ALU64 | EBPF_MOV | BPF_X, RDX, dreg);
+		emit_mov_reg(st, BPF_ALU64 | BPF_MOV | BPF_X, RDX, dreg);
 
 	if (dreg != RAX)
-		emit_mov_reg(st, EBPF_ALU64 | EBPF_MOV | BPF_X, REG_TMP0, RAX);
+		emit_mov_reg(st, BPF_ALU64 | BPF_MOV | BPF_X, REG_TMP0, RAX);
 	if (dreg != RDX)
-		emit_mov_reg(st, EBPF_ALU64 | EBPF_MOV | BPF_X, REG_TMP1, RDX);
+		emit_mov_reg(st, BPF_ALU64 | BPF_MOV | BPF_X, REG_TMP1, RDX);
 }
 
 /*
@@ -1059,53 +1059,53 @@ emit_div(struct bpf_jit_state *st, uint32_t op, uint32_t sreg, uint32_t dreg,
  * calculate load offset and check is it inside first packet segment.
  */
 static void
-emit_ldmb_fast_path(struct bpf_jit_state *st, const uint32_t rg[EBPF_REG_7],
+emit_ldmb_fast_path(struct bpf_jit_state *st, const uint32_t rg[BPF_REG_7],
 	uint32_t sreg, uint32_t mode, uint32_t sz, uint32_t imm,
 	const int32_t ofs[LDMB_OFS_NUM])
 {
 	/* make R2 contain *off* value */
 
-	if (sreg != rg[EBPF_REG_2]) {
-		emit_mov_imm(st, EBPF_ALU64 | EBPF_MOV | BPF_K,
-			rg[EBPF_REG_2], imm);
+	if (sreg != rg[BPF_REG_2]) {
+		emit_mov_imm(st, BPF_ALU64 | BPF_MOV | BPF_K,
+			rg[BPF_REG_2], imm);
 		if (mode == BPF_IND)
-			emit_alu_reg(st, EBPF_ALU64 | BPF_ADD | BPF_X,
-				sreg, rg[EBPF_REG_2]);
+			emit_alu_reg(st, BPF_ALU64 | BPF_ADD | BPF_X,
+				sreg, rg[BPF_REG_2]);
 	} else
 		/* BPF_IND with sreg == R2 */
-		emit_alu_imm(st, EBPF_ALU64 | BPF_ADD | BPF_K,
-			rg[EBPF_REG_2], imm);
+		emit_alu_imm(st, BPF_ALU64 | BPF_ADD | BPF_K,
+			rg[BPF_REG_2], imm);
 
 	/* R3 = mbuf->data_len */
 	emit_ld_reg(st, BPF_LDX | BPF_MEM | BPF_H,
-		rg[EBPF_REG_6], rg[EBPF_REG_3],
+		rg[BPF_REG_6], rg[BPF_REG_3],
 		offsetof(struct rte_mbuf, data_len));
 
 	/* R3 = R3 - R2 */
-	emit_alu_reg(st, EBPF_ALU64 | BPF_SUB | BPF_X,
-		rg[EBPF_REG_2], rg[EBPF_REG_3]);
+	emit_alu_reg(st, BPF_ALU64 | BPF_SUB | BPF_X,
+		rg[BPF_REG_2], rg[BPF_REG_3]);
 
 	/* JSLT R3, <sz> <slow_path> */
-	emit_cmp_imm(st, EBPF_ALU64, rg[EBPF_REG_3], sz);
-	emit_abs_jcc(st, BPF_JMP | EBPF_JSLT | BPF_K, ofs[LDMB_SLP_OFS]);
+	emit_cmp_imm(st, BPF_ALU64, rg[BPF_REG_3], sz);
+	emit_abs_jcc(st, BPF_JMP | BPF_JSLT | BPF_K, ofs[LDMB_SLP_OFS]);
 
 	/* R3 = mbuf->data_off */
 	emit_ld_reg(st, BPF_LDX | BPF_MEM | BPF_H,
-		rg[EBPF_REG_6], rg[EBPF_REG_3],
+		rg[BPF_REG_6], rg[BPF_REG_3],
 		offsetof(struct rte_mbuf, data_off));
 
 	/* R0 = mbuf->buf_addr */
-	emit_ld_reg(st, BPF_LDX | BPF_MEM | EBPF_DW,
-		rg[EBPF_REG_6], rg[EBPF_REG_0],
+	emit_ld_reg(st, BPF_LDX | BPF_MEM | BPF_DW,
+		rg[BPF_REG_6], rg[BPF_REG_0],
 		offsetof(struct rte_mbuf, buf_addr));
 
 	/* R0 = R0 + R3 */
-	emit_alu_reg(st, EBPF_ALU64 | BPF_ADD | BPF_X,
-		rg[EBPF_REG_3], rg[EBPF_REG_0]);
+	emit_alu_reg(st, BPF_ALU64 | BPF_ADD | BPF_X,
+		rg[BPF_REG_3], rg[BPF_REG_0]);
 
 	/* R0 = R0 + R2 */
-	emit_alu_reg(st, EBPF_ALU64 | BPF_ADD | BPF_X,
-		rg[EBPF_REG_2], rg[EBPF_REG_0]);
+	emit_alu_reg(st, BPF_ALU64 | BPF_ADD | BPF_X,
+		rg[BPF_REG_2], rg[BPF_REG_0]);
 
 	/* JMP <fin_part> */
 	emit_abs_jmp(st, ofs[LDMB_FIN_OFS]);
@@ -1117,29 +1117,29 @@ emit_ldmb_fast_path(struct bpf_jit_state *st, const uint32_t rg[EBPF_REG_7],
  * call __rte_pktmbuf_read() and check return value.
  */
 static void
-emit_ldmb_slow_path(struct bpf_jit_state *st, const uint32_t rg[EBPF_REG_7],
+emit_ldmb_slow_path(struct bpf_jit_state *st, const uint32_t rg[BPF_REG_7],
 	uint32_t sz)
 {
 	/* make R3 contain *len* value (1/2/4) */
 
-	emit_mov_imm(st, EBPF_ALU64 | EBPF_MOV | BPF_K, rg[EBPF_REG_3], sz);
+	emit_mov_imm(st, BPF_ALU64 | BPF_MOV | BPF_K, rg[BPF_REG_3], sz);
 
 	/* make R4 contain (RBP - ldmb.stack_ofs) */
 
-	emit_mov_reg(st, EBPF_ALU64 | EBPF_MOV | BPF_X, RBP, rg[EBPF_REG_4]);
-	emit_alu_imm(st, EBPF_ALU64 | BPF_SUB | BPF_K, rg[EBPF_REG_4],
+	emit_mov_reg(st, BPF_ALU64 | BPF_MOV | BPF_X, RBP, rg[BPF_REG_4]);
+	emit_alu_imm(st, BPF_ALU64 | BPF_SUB | BPF_K, rg[BPF_REG_4],
 		st->ldmb.stack_ofs);
 
 	/* make R1 contain mbuf ptr */
 
-	emit_mov_reg(st, EBPF_ALU64 | EBPF_MOV | BPF_X,
-		rg[EBPF_REG_6], rg[EBPF_REG_1]);
+	emit_mov_reg(st, BPF_ALU64 | BPF_MOV | BPF_X,
+		rg[BPF_REG_6], rg[BPF_REG_1]);
 
 	/* call rte_pktmbuf_read */
 	emit_call(st, (uintptr_t)__rte_pktmbuf_read);
 
 	/* check that return value (R0) is not zero */
-	emit_tst_reg(st, EBPF_ALU64, rg[EBPF_REG_0], rg[EBPF_REG_0]);
+	emit_tst_reg(st, BPF_ALU64, rg[BPF_REG_0], rg[BPF_REG_0]);
 	emit_abs_jcc(st, BPF_JMP | BPF_JEQ | BPF_K, st->exit.off);
 }
 
@@ -1180,7 +1180,7 @@ static void
 emit_ld_mbuf(struct bpf_jit_state *st, uint32_t op, uint32_t sreg, uint32_t imm)
 {
 	uint32_t i, mode, opsz, sz;
-	uint32_t rg[EBPF_REG_7];
+	uint32_t rg[BPF_REG_7];
 	int32_t ofs[LDMB_OFS_NUM];
 
 	mode = BPF_MODE(op);
@@ -1201,7 +1201,7 @@ emit_ld_mbuf(struct bpf_jit_state *st, uint32_t op, uint32_t sreg, uint32_t imm)
 	ofs[LDMB_SLP_OFS] = st->sz;
 	emit_ldmb_slow_path(st, rg, sz);
 	ofs[LDMB_FIN_OFS] = st->sz;
-	emit_ldmb_fin(st, rg[EBPF_REG_0], opsz, sz);
+	emit_ldmb_fin(st, rg[BPF_REG_0], opsz, sz);
 
 	RTE_VERIFY(ofs[LDMB_FIN_OFS] - ofs[LDMB_FSP_OFS] <= INT8_MAX);
 
@@ -1210,7 +1210,7 @@ emit_ld_mbuf(struct bpf_jit_state *st, uint32_t op, uint32_t sreg, uint32_t imm)
 	st->sz = ofs[LDMB_FSP_OFS];
 	emit_ldmb_fast_path(st, rg, sreg, mode, sz, imm, ofs);
 	emit_ldmb_slow_path(st, rg, sz);
-	emit_ldmb_fin(st, rg[EBPF_REG_0], opsz, sz);
+	emit_ldmb_fin(st, rg[BPF_REG_0], opsz, sz);
 }
 
 static void
@@ -1228,21 +1228,21 @@ emit_prolog(struct bpf_jit_state *st, int32_t stack_size)
 		return;
 
 
-	emit_alu_imm(st, EBPF_ALU64 | BPF_SUB | BPF_K, RSP,
+	emit_alu_imm(st, BPF_ALU64 | BPF_SUB | BPF_K, RSP,
 		spil * sizeof(uint64_t));
 
 	ofs = 0;
 	for (i = 0; i != RTE_DIM(save_regs); i++) {
 		if (INUSE(st->reguse, save_regs[i]) != 0) {
-			emit_st_reg(st, BPF_STX | BPF_MEM | EBPF_DW,
+			emit_st_reg(st, BPF_STX | BPF_MEM | BPF_DW,
 				save_regs[i], RSP, ofs);
 			ofs += sizeof(uint64_t);
 		}
 	}
 
 	if (INUSE(st->reguse, RBP) != 0) {
-		emit_mov_reg(st, EBPF_ALU64 | EBPF_MOV | BPF_X, RSP, RBP);
-		emit_alu_imm(st, EBPF_ALU64 | BPF_SUB | BPF_K, RSP, stack_size);
+		emit_mov_reg(st, BPF_ALU64 | BPF_MOV | BPF_X, RSP, RBP);
+		emit_alu_imm(st, BPF_ALU64 | BPF_SUB | BPF_K, RSP, stack_size);
 
 		/*
 		 * Align stack pointer appropriately for function calls.
@@ -1251,7 +1251,7 @@ emit_prolog(struct bpf_jit_state *st, int32_t stack_size)
 		 * but hopefully `alignof(max_align_t)` will always be greater.
 		 * Original stack pointer will be restored from rbp.
 		 */
-		emit_alu_imm(st, EBPF_ALU64 | BPF_AND | BPF_K, RSP,
+		emit_alu_imm(st, BPF_ALU64 | BPF_AND | BPF_K, RSP,
 			-(uint32_t)alignof(max_align_t));
 	}
 }
@@ -1289,19 +1289,19 @@ emit_epilog(struct bpf_jit_state *st)
 	if (spil != 0) {
 
 		if (INUSE(st->reguse, RBP) != 0)
-			emit_mov_reg(st, EBPF_ALU64 | EBPF_MOV | BPF_X,
+			emit_mov_reg(st, BPF_ALU64 | BPF_MOV | BPF_X,
 				RBP, RSP);
 
 		ofs = 0;
 		for (i = 0; i != RTE_DIM(save_regs); i++) {
 			if (INUSE(st->reguse, save_regs[i]) != 0) {
-				emit_ld_reg(st, BPF_LDX | BPF_MEM | EBPF_DW,
+				emit_ld_reg(st, BPF_LDX | BPF_MEM | BPF_DW,
 					RSP, save_regs[i], ofs);
 				ofs += sizeof(uint64_t);
 			}
 		}
 
-		emit_alu_imm(st, EBPF_ALU64 | BPF_ADD | BPF_K, RSP,
+		emit_alu_imm(st, BPF_ALU64 | BPF_ADD | BPF_K, RSP,
 			spil * sizeof(uint64_t));
 	}
 
@@ -1348,7 +1348,7 @@ emit(struct bpf_jit_state *st, const struct rte_bpf *bpf)
 		case (BPF_ALU | BPF_RSH | BPF_K):
 			emit_shift_imm(st, op, dr, ins->imm);
 			break;
-		case (BPF_ALU | EBPF_MOV | BPF_K):
+		case (BPF_ALU | BPF_MOV | BPF_K):
 			emit_mov_imm(st, op, dr, ins->imm);
 			break;
 		/* 32 bit ALU REG operations */
@@ -1363,58 +1363,58 @@ emit(struct bpf_jit_state *st, const struct rte_bpf *bpf)
 		case (BPF_ALU | BPF_RSH | BPF_X):
 			emit_shift_reg(st, op, sr, dr);
 			break;
-		case (BPF_ALU | EBPF_MOV | BPF_X):
+		case (BPF_ALU | BPF_MOV | BPF_X):
 			emit_mov_reg(st, op, sr, dr);
 			break;
 		case (BPF_ALU | BPF_NEG):
 			emit_neg(st, op, dr);
 			break;
-		case (BPF_ALU | EBPF_END | EBPF_TO_BE):
+		case (BPF_ALU | BPF_END | BPF_TO_BE):
 			emit_be2le(st, dr, ins->imm);
 			break;
-		case (BPF_ALU | EBPF_END | EBPF_TO_LE):
+		case (BPF_ALU | BPF_END | BPF_TO_LE):
 			emit_le2be(st, dr, ins->imm);
 			break;
 		/* 64 bit ALU IMM operations */
-		case (EBPF_ALU64 | BPF_ADD | BPF_K):
-		case (EBPF_ALU64 | BPF_SUB | BPF_K):
-		case (EBPF_ALU64 | BPF_AND | BPF_K):
-		case (EBPF_ALU64 | BPF_OR | BPF_K):
-		case (EBPF_ALU64 | BPF_XOR | BPF_K):
+		case (BPF_ALU64 | BPF_ADD | BPF_K):
+		case (BPF_ALU64 | BPF_SUB | BPF_K):
+		case (BPF_ALU64 | BPF_AND | BPF_K):
+		case (BPF_ALU64 | BPF_OR | BPF_K):
+		case (BPF_ALU64 | BPF_XOR | BPF_K):
 			emit_alu_imm(st, op, dr, ins->imm);
 			break;
-		case (EBPF_ALU64 | BPF_LSH | BPF_K):
-		case (EBPF_ALU64 | BPF_RSH | BPF_K):
-		case (EBPF_ALU64 | EBPF_ARSH | BPF_K):
+		case (BPF_ALU64 | BPF_LSH | BPF_K):
+		case (BPF_ALU64 | BPF_RSH | BPF_K):
+		case (BPF_ALU64 | BPF_ARSH | BPF_K):
 			emit_shift_imm(st, op, dr, ins->imm);
 			break;
-		case (EBPF_ALU64 | EBPF_MOV | BPF_K):
+		case (BPF_ALU64 | BPF_MOV | BPF_K):
 			emit_mov_imm(st, op, dr, ins->imm);
 			break;
 		/* 64 bit ALU REG operations */
-		case (EBPF_ALU64 | BPF_ADD | BPF_X):
-		case (EBPF_ALU64 | BPF_SUB | BPF_X):
-		case (EBPF_ALU64 | BPF_AND | BPF_X):
-		case (EBPF_ALU64 | BPF_OR | BPF_X):
-		case (EBPF_ALU64 | BPF_XOR | BPF_X):
+		case (BPF_ALU64 | BPF_ADD | BPF_X):
+		case (BPF_ALU64 | BPF_SUB | BPF_X):
+		case (BPF_ALU64 | BPF_AND | BPF_X):
+		case (BPF_ALU64 | BPF_OR | BPF_X):
+		case (BPF_ALU64 | BPF_XOR | BPF_X):
 			emit_alu_reg(st, op, sr, dr);
 			break;
-		case (EBPF_ALU64 | BPF_LSH | BPF_X):
-		case (EBPF_ALU64 | BPF_RSH | BPF_X):
-		case (EBPF_ALU64 | EBPF_ARSH | BPF_X):
+		case (BPF_ALU64 | BPF_LSH | BPF_X):
+		case (BPF_ALU64 | BPF_RSH | BPF_X):
+		case (BPF_ALU64 | BPF_ARSH | BPF_X):
 			emit_shift_reg(st, op, sr, dr);
 			break;
-		case (EBPF_ALU64 | EBPF_MOV | BPF_X):
+		case (BPF_ALU64 | BPF_MOV | BPF_X):
 			emit_mov_reg(st, op, sr, dr);
 			break;
-		case (EBPF_ALU64 | BPF_NEG):
+		case (BPF_ALU64 | BPF_NEG):
 			emit_neg(st, op, dr);
 			break;
 		/* multiply instructions */
 		case (BPF_ALU | BPF_MUL | BPF_K):
 		case (BPF_ALU | BPF_MUL | BPF_X):
-		case (EBPF_ALU64 | BPF_MUL | BPF_K):
-		case (EBPF_ALU64 | BPF_MUL | BPF_X):
+		case (BPF_ALU64 | BPF_MUL | BPF_K):
+		case (BPF_ALU64 | BPF_MUL | BPF_X):
 			emit_mul(st, op, sr, dr, ins->imm);
 			break;
 		/* divide instructions */
@@ -1422,21 +1422,21 @@ emit(struct bpf_jit_state *st, const struct rte_bpf *bpf)
 		case (BPF_ALU | BPF_MOD | BPF_K):
 		case (BPF_ALU | BPF_DIV | BPF_X):
 		case (BPF_ALU | BPF_MOD | BPF_X):
-		case (EBPF_ALU64 | BPF_DIV | BPF_K):
-		case (EBPF_ALU64 | BPF_MOD | BPF_K):
-		case (EBPF_ALU64 | BPF_DIV | BPF_X):
-		case (EBPF_ALU64 | BPF_MOD | BPF_X):
+		case (BPF_ALU64 | BPF_DIV | BPF_K):
+		case (BPF_ALU64 | BPF_MOD | BPF_K):
+		case (BPF_ALU64 | BPF_DIV | BPF_X):
+		case (BPF_ALU64 | BPF_MOD | BPF_X):
 			emit_div(st, op, sr, dr, ins->imm);
 			break;
 		/* load instructions */
 		case (BPF_LDX | BPF_MEM | BPF_B):
 		case (BPF_LDX | BPF_MEM | BPF_H):
 		case (BPF_LDX | BPF_MEM | BPF_W):
-		case (BPF_LDX | BPF_MEM | EBPF_DW):
+		case (BPF_LDX | BPF_MEM | BPF_DW):
 			emit_ld_reg(st, op, sr, dr, ins->off);
 			break;
 		/* load 64 bit immediate value */
-		case (BPF_LD | BPF_IMM | EBPF_DW):
+		case (BPF_LD | BPF_IMM | BPF_DW):
 			emit_ld_imm64(st, dr, ins[0].imm, ins[1].imm);
 			i++;
 			break;
@@ -1453,18 +1453,18 @@ emit(struct bpf_jit_state *st, const struct rte_bpf *bpf)
 		case (BPF_STX | BPF_MEM | BPF_B):
 		case (BPF_STX | BPF_MEM | BPF_H):
 		case (BPF_STX | BPF_MEM | BPF_W):
-		case (BPF_STX | BPF_MEM | EBPF_DW):
+		case (BPF_STX | BPF_MEM | BPF_DW):
 			emit_st_reg(st, op, sr, dr, ins->off);
 			break;
 		case (BPF_ST | BPF_MEM | BPF_B):
 		case (BPF_ST | BPF_MEM | BPF_H):
 		case (BPF_ST | BPF_MEM | BPF_W):
-		case (BPF_ST | BPF_MEM | EBPF_DW):
+		case (BPF_ST | BPF_MEM | BPF_DW):
 			emit_st_imm(st, op, dr, ins->imm, ins->off);
 			break;
 		/* atomic instructions */
-		case (BPF_STX | EBPF_ATOMIC | BPF_W):
-		case (BPF_STX | EBPF_ATOMIC | EBPF_DW):
+		case (BPF_STX | BPF_ATOMIC | BPF_W):
+		case (BPF_STX | BPF_ATOMIC | BPF_DW):
 			emit_st_atomic(st, op, sr, dr, ins->off, ins->imm);
 			break;
 		/* jump instructions */
@@ -1473,39 +1473,39 @@ emit(struct bpf_jit_state *st, const struct rte_bpf *bpf)
 			break;
 		/* jump IMM instructions */
 		case (BPF_JMP | BPF_JEQ | BPF_K):
-		case (BPF_JMP | EBPF_JNE | BPF_K):
+		case (BPF_JMP | BPF_JNE | BPF_K):
 		case (BPF_JMP | BPF_JGT | BPF_K):
-		case (BPF_JMP | EBPF_JLT | BPF_K):
+		case (BPF_JMP | BPF_JLT | BPF_K):
 		case (BPF_JMP | BPF_JGE | BPF_K):
-		case (BPF_JMP | EBPF_JLE | BPF_K):
-		case (BPF_JMP | EBPF_JSGT | BPF_K):
-		case (BPF_JMP | EBPF_JSLT | BPF_K):
-		case (BPF_JMP | EBPF_JSGE | BPF_K):
-		case (BPF_JMP | EBPF_JSLE | BPF_K):
+		case (BPF_JMP | BPF_JLE | BPF_K):
+		case (BPF_JMP | BPF_JSGT | BPF_K):
+		case (BPF_JMP | BPF_JSLT | BPF_K):
+		case (BPF_JMP | BPF_JSGE | BPF_K):
+		case (BPF_JMP | BPF_JSLE | BPF_K):
 		case (BPF_JMP | BPF_JSET | BPF_K):
 			emit_jcc_imm(st, op, dr, ins->imm, ins->off + 1);
 			break;
 		/* jump REG instructions */
 		case (BPF_JMP | BPF_JEQ | BPF_X):
-		case (BPF_JMP | EBPF_JNE | BPF_X):
+		case (BPF_JMP | BPF_JNE | BPF_X):
 		case (BPF_JMP | BPF_JGT | BPF_X):
-		case (BPF_JMP | EBPF_JLT | BPF_X):
+		case (BPF_JMP | BPF_JLT | BPF_X):
 		case (BPF_JMP | BPF_JGE | BPF_X):
-		case (BPF_JMP | EBPF_JLE | BPF_X):
-		case (BPF_JMP | EBPF_JSGT | BPF_X):
-		case (BPF_JMP | EBPF_JSLT | BPF_X):
-		case (BPF_JMP | EBPF_JSGE | BPF_X):
-		case (BPF_JMP | EBPF_JSLE | BPF_X):
+		case (BPF_JMP | BPF_JLE | BPF_X):
+		case (BPF_JMP | BPF_JSGT | BPF_X):
+		case (BPF_JMP | BPF_JSLT | BPF_X):
+		case (BPF_JMP | BPF_JSGE | BPF_X):
+		case (BPF_JMP | BPF_JSLE | BPF_X):
 		case (BPF_JMP | BPF_JSET | BPF_X):
 			emit_jcc_reg(st, op, sr, dr, ins->off + 1);
 			break;
 		/* call instructions */
-		case (BPF_JMP | EBPF_CALL):
+		case (BPF_JMP | BPF_CALL):
 			emit_call(st,
 				(uintptr_t)bpf->prm.xsym[ins->imm].func.val);
 			break;
 		/* return instruction */
-		case (BPF_JMP | EBPF_EXIT):
+		case (BPF_JMP | BPF_EXIT):
 			emit_epilog(st);
 			break;
 		default:
diff --git a/lib/bpf/bpf_load_elf.c b/lib/bpf/bpf_load_elf.c
index 329ae25cb173..e0671783df4f 100644
--- a/lib/bpf/bpf_load_elf.c
+++ b/lib/bpf/bpf_load_elf.c
@@ -68,9 +68,9 @@ resolve_xsym(const char *sn, size_t ofs, struct rte_ebpf_insn *ins, size_t ins_s
 		return -EINVAL;
 
 	idx = ofs / sizeof(ins[0]);
-	if (ins[idx].code == (BPF_JMP | EBPF_CALL))
+	if (ins[idx].code == (BPF_JMP | BPF_CALL))
 		type = RTE_BPF_XTYPE_FUNC;
-	else if (ins[idx].code == (BPF_LD | BPF_IMM | EBPF_DW) &&
+	else if (ins[idx].code == (BPF_LD | BPF_IMM | BPF_DW) &&
 			ofs < ins_sz - sizeof(ins[idx]))
 		type = RTE_BPF_XTYPE_VAR;
 	else
@@ -84,14 +84,14 @@ resolve_xsym(const char *sn, size_t ofs, struct rte_ebpf_insn *ins, size_t ins_s
 	if (type == RTE_BPF_XTYPE_FUNC) {
 
 		/* we don't support multiple functions per BPF module,
-		 * so treat EBPF_PSEUDO_CALL to external function
-		 * as an ordinary EBPF_CALL.
+		 * so treat BPF_PSEUDO_CALL to external function
+		 * as an ordinary BPF_CALL.
 		 */
-		if (ins[idx].src_reg == EBPF_PSEUDO_CALL) {
+		if (ins[idx].src_reg == BPF_PSEUDO_CALL) {
 			RTE_BPF_LOG_LINE(INFO, "%s(%u): "
-				"EBPF_PSEUDO_CALL to external function: %s",
+				"BPF_PSEUDO_CALL to external function: %s",
 				__func__, idx, sn);
-			ins[idx].src_reg = EBPF_REG_0;
+			ins[idx].src_reg = BPF_REG_0;
 		}
 		ins[idx].imm = fidx;
 	/* for variable we need to store its absolute address */
diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index 31226c8f1f53..0487a6f7d163 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -37,7 +37,7 @@ struct bpf_reg_val {
 
 struct bpf_eval_state {
 	SLIST_ENTRY(bpf_eval_state) next; /* for @safe list traversal */
-	struct bpf_reg_val rv[EBPF_REG_NUM];
+	struct bpf_reg_val rv[MAX_BPF_REG];
 	struct bpf_reg_val sv[MAX_BPF_STACK_SIZE / sizeof(uint64_t)];
 	/* flag set for branches determined to be dynamically unreachable */
 	bool unreachable;
@@ -121,12 +121,12 @@ struct bpf_ins_check {
 	const char * (*eval)(struct bpf_verifier *bpf, const struct rte_ebpf_insn *ins);
 };
 
-#define	ALL_REGS	RTE_LEN2MASK(EBPF_REG_NUM, uint16_t)
-#define	WRT_REGS	RTE_LEN2MASK(EBPF_REG_10, uint16_t)
-#define	ZERO_REG	RTE_LEN2MASK(EBPF_REG_1, uint16_t)
+#define	ALL_REGS	RTE_LEN2MASK(MAX_BPF_REG, uint16_t)
+#define	WRT_REGS	RTE_LEN2MASK(BPF_REG_10, uint16_t)
+#define	ZERO_REG	RTE_LEN2MASK(BPF_REG_1, uint16_t)
 
 /* For LD_IND R6 is an implicit CTX register. */
-#define	IND_SRC_REGS	(WRT_REGS ^ 1 << EBPF_REG_6)
+#define	IND_SRC_REGS	(WRT_REGS ^ 1 << BPF_REG_6)
 
 /*
  * Debugging internal interface and helpers.
@@ -223,13 +223,13 @@ may_jump_code_is_supported(uint8_t code)
 	case BPF_JEQ:
 	case BPF_JGT:
 	case BPF_JGE:
-	case EBPF_JNE:
-	case EBPF_JSGT:
-	case EBPF_JSGE:
-	case EBPF_JLT:
-	case EBPF_JLE:
-	case EBPF_JSLT:
-	case EBPF_JSLE:
+	case BPF_JNE:
+	case BPF_JSGT:
+	case BPF_JSGE:
+	case BPF_JLT:
+	case BPF_JLE:
+	case BPF_JSLT:
+	case BPF_JSLE:
 		return true;
 	default:
 		return false;
@@ -241,10 +241,10 @@ static bool
 may_jump_code_is_signed(uint8_t code)
 {
 	switch (BPF_OP(code)) {
-	case EBPF_JSGT:
-	case EBPF_JSGE:
-	case EBPF_JSLT:
-	case EBPF_JSLE:
+	case BPF_JSGT:
+	case BPF_JSGE:
+	case BPF_JSLT:
+	case BPF_JSLE:
 		return true;
 	default:
 		return false;
@@ -259,20 +259,20 @@ may_jump(uint8_t code, const struct value_set *origin,
 	switch (BPF_OP(code)) {
 	case BPF_JEQ:
 		return value_sets_intersect(dst_set, src_set);
-	case EBPF_JNE:
+	case BPF_JNE:
 		return !(value_set_is_singleton(dst_set) &&
 			value_sets_equal(dst_set, src_set));
 	case BPF_JGT:
-	case EBPF_JSGT:
+	case BPF_JSGT:
 		return !value_sets_based_less_or_equal(origin, dst_set, src_set);
 	case BPF_JGE:
-	case EBPF_JSGE:
+	case BPF_JSGE:
 		return !value_sets_based_less(origin, dst_set, src_set);
-	case EBPF_JLT:
-	case EBPF_JSLT:
+	case BPF_JLT:
+	case BPF_JSLT:
 		return !value_sets_based_less_or_equal(origin, src_set, dst_set);
-	case EBPF_JSLE:
-	case EBPF_JLE:
+	case BPF_JSLE:
+	case BPF_JLE:
 		return !value_sets_based_less(origin, src_set, dst_set);
 	}
 	/* may_jump_code_is_supported should have caught this */
@@ -286,20 +286,20 @@ may_jump_code_complement(uint8_t code)
 {
 	switch (BPF_OP(code)) {
 	case BPF_JEQ:
-	case EBPF_JNE:
-		return code ^ BPF_JEQ ^ EBPF_JNE;
+	case BPF_JNE:
+		return code ^ BPF_JEQ ^ BPF_JNE;
 	case BPF_JGT:
-	case EBPF_JLE:
-		return code ^ BPF_JGT ^ EBPF_JLE;
+	case BPF_JLE:
+		return code ^ BPF_JGT ^ BPF_JLE;
 	case BPF_JGE:
-	case EBPF_JLT:
-		return code ^ BPF_JGE ^ EBPF_JLT;
-	case EBPF_JSGT:
-	case EBPF_JSLE:
-		return code ^ EBPF_JSGT ^ EBPF_JSLE;
-	case EBPF_JSGE:
-	case EBPF_JSLT:
-		return code ^ EBPF_JSGE ^ EBPF_JSLT;
+	case BPF_JLT:
+		return code ^ BPF_JGE ^ BPF_JLT;
+	case BPF_JSGT:
+	case BPF_JSLE:
+		return code ^ BPF_JSGT ^ BPF_JSLE;
+	case BPF_JSGE:
+	case BPF_JSLT:
+		return code ^ BPF_JSGE ^ BPF_JSLT;
 	}
 	/* may_jump_code_is_supported should have caught this */
 	RTE_ASSERT(false);
@@ -507,7 +507,7 @@ int
 __rte_bpf_validate_format_register_info(const struct bpf_verifier *verifier,
 	char *buffer, size_t bufsz, uint8_t reg)
 {
-	if (reg >= EBPF_REG_NUM)
+	if (reg >= MAX_BPF_REG)
 		return -EINVAL;
 
 	return format_reg_val(buffer, bufsz, &verifier->evst->rv[reg]);
@@ -554,7 +554,7 @@ static const char *
 eval_exit(struct bpf_verifier *bvf, const struct rte_ebpf_insn *ins)
 {
 	RTE_SET_USED(ins);
-	if (bvf->evst->rv[EBPF_REG_0].v.type == RTE_BPF_ARG_UNDEF)
+	if (bvf->evst->rv[BPF_REG_0].v.type == RTE_BPF_ARG_UNDEF)
 		return "undefined return value";
 	return NULL;
 }
@@ -1059,7 +1059,7 @@ eval_ld_mbuf(struct bpf_verifier *bvf, const struct rte_ebpf_insn *ins)
 	mode = BPF_MODE(ins->code);
 
 	/* R6 is an implicit input that must contain pointer to mbuf */
-	if (bvf->evst->rv[EBPF_REG_6].v.type != RTE_BPF_ARG_PTR_MBUF)
+	if (bvf->evst->rv[BPF_REG_6].v.type != RTE_BPF_ARG_PTR_MBUF)
 		return "invalid type for implicit ctx register";
 
 	if (mode == BPF_IND) {
@@ -1075,11 +1075,11 @@ eval_ld_mbuf(struct bpf_verifier *bvf, const struct rte_ebpf_insn *ins)
 	}
 
 	/* R1-R5 scratch registers */
-	for (i = EBPF_REG_1; i != EBPF_REG_6; i++)
+	for (i = BPF_REG_1; i != BPF_REG_6; i++)
 		bvf->evst->rv[i].v.type = RTE_BPF_ARG_UNDEF;
 
 	/* R0 is an implicit output, contains data fetched from the packet */
-	rv = bvf->evst->rv + EBPF_REG_0;
+	rv = bvf->evst->rv + BPF_REG_0;
 	rv->v.size = bpf_size(BPF_SIZE(ins->code));
 	eval_fill_max_bound(rv, RTE_LEN2MASK(rv->v.size * CHAR_BIT, uint64_t));
 
@@ -1136,7 +1136,7 @@ eval_alu(struct bpf_verifier *bvf, const struct rte_ebpf_insn *ins)
 		eval_fill_imm(rd, UINT64_MAX, 0);
 	}
 
-	err = eval_defined((op != EBPF_MOV) ? rd : NULL,
+	err = eval_defined((op != BPF_MOV) ? rd : NULL,
 			   (op != BPF_NEG) ? &rs : NULL);
 	if (err != NULL)
 		return err;
@@ -1149,7 +1149,7 @@ eval_alu(struct bpf_verifier *bvf, const struct rte_ebpf_insn *ins)
 		eval_lsh(rd, &rs, opsz, msk);
 	else if (op == BPF_RSH)
 		eval_rsh(rd, &rs, opsz, msk);
-	else if (op == EBPF_ARSH)
+	else if (op == BPF_ARSH)
 		eval_arsh(rd, &rs, opsz, msk);
 	else if (op == BPF_AND)
 		eval_and(rd, &rs, opsz, msk);
@@ -1163,7 +1163,7 @@ eval_alu(struct bpf_verifier *bvf, const struct rte_ebpf_insn *ins)
 		err = eval_divmod(op, rd, &rs, msk);
 	else if (op == BPF_NEG)
 		eval_neg(rd, opsz, msk);
-	else if (op == EBPF_MOV)
+	else if (op == BPF_MOV)
 		*rd = rs;
 	else
 		eval_max_bound(rd, msk);
@@ -1189,12 +1189,12 @@ eval_bele(struct bpf_verifier *bvf, const struct rte_ebpf_insn *ins)
 		return err;
 
 #if RTE_BYTE_ORDER == RTE_LITTLE_ENDIAN
-	if (ins->code == (BPF_ALU | EBPF_END | EBPF_TO_BE))
+	if (ins->code == (BPF_ALU | BPF_END | BPF_TO_BE))
 		eval_max_bound(rd, msk);
 	else
 		eval_apply_mask(rd, msk);
 #else
-	if (ins->code == (BPF_ALU | EBPF_END | EBPF_TO_LE))
+	if (ins->code == (BPF_ALU | BPF_END | BPF_TO_LE))
 		eval_max_bound(rd, msk);
 	else
 		eval_apply_mask(rd, msk);
@@ -1365,11 +1365,11 @@ eval_store(struct bpf_verifier *bvf, const struct rte_ebpf_insn *ins)
 
 	if (BPF_CLASS(ins->code) == BPF_STX) {
 		rs = st->rv[ins->src_reg];
-		if (BPF_MODE(ins->code) == EBPF_ATOMIC)
+		if (BPF_MODE(ins->code) == BPF_ATOMIC)
 			switch (ins->imm) {
-			case BPF_ATOMIC_ADD:
+			case BPF_ADD:
 				break;
-			case BPF_ATOMIC_XCHG:
+			case BPF_XCHG:
 				eval_max_bound(&st->rv[ins->src_reg], msk);
 				break;
 			default:
@@ -1391,7 +1391,7 @@ eval_store(struct bpf_verifier *bvf, const struct rte_ebpf_insn *ins)
 
 		sv = st->sv + rd.u.max / sizeof(uint64_t);
 		if (BPF_CLASS(ins->code) == BPF_STX &&
-				BPF_MODE(ins->code) == EBPF_ATOMIC)
+				BPF_MODE(ins->code) == BPF_ATOMIC)
 			eval_max_bound(sv, msk);
 		else
 			*sv = rs;
@@ -1482,16 +1482,16 @@ eval_call(struct bpf_verifier *bvf, const struct rte_ebpf_insn *ins)
 	err = NULL;
 	for (i = 0; i != xsym->func.nb_args && err == NULL; i++) {
 		err = eval_func_arg(bvf, xsym->func.args + i,
-			bvf->evst->rv + EBPF_REG_1 + i);
+			bvf->evst->rv + BPF_REG_1 + i);
 	}
 
 	/* R1-R5 argument/scratch registers */
-	for (i = EBPF_REG_1; i != EBPF_REG_6; i++)
+	for (i = BPF_REG_1; i != BPF_REG_6; i++)
 		bvf->evst->rv[i].v.type = RTE_BPF_ARG_UNDEF;
 
 	/* update return value */
 
-	rv = bvf->evst->rv + EBPF_REG_0;
+	rv = bvf->evst->rv + BPF_REG_0;
 	rv->v = xsym->func.ret;
 	if (rv->v.type == RTE_BPF_ARG_RAW)
 		eval_fill_max_bound(rv,
@@ -1631,23 +1631,23 @@ eval_jcc(struct bpf_verifier *bvf, const struct rte_ebpf_insn *ins)
 
 	if (op == BPF_JEQ)
 		eval_jeq_jne(trd, trs);
-	else if (op == EBPF_JNE)
+	else if (op == BPF_JNE)
 		eval_jeq_jne(frd, frs);
 	else if (op == BPF_JGT)
 		eval_jgt_jle(trd, trs, frd, frs);
-	else if (op == EBPF_JLE)
+	else if (op == BPF_JLE)
 		eval_jgt_jle(frd, frs, trd, trs);
-	else if (op == EBPF_JLT)
+	else if (op == BPF_JLT)
 		eval_jlt_jge(trd, trs, frd, frs);
 	else if (op == BPF_JGE)
 		eval_jlt_jge(frd, frs, trd, trs);
-	else if (op == EBPF_JSGT)
+	else if (op == BPF_JSGT)
 		eval_jsgt_jsle(trd, trs, frd, frs);
-	else if (op == EBPF_JSLE)
+	else if (op == BPF_JSLE)
 		eval_jsgt_jsle(frd, frs, trd, trs);
-	else if (op == EBPF_JSLT)
+	else if (op == BPF_JSLT)
 		eval_jslt_jsge(trd, trs, frd, frs);
-	else if (op == EBPF_JSGE)
+	else if (op == BPF_JSGE)
 		eval_jslt_jsge(frd, frs, trd, trs);
 
 	if (trd->v.type == BPF_ARG_UNINHABITED ||
@@ -1714,7 +1714,7 @@ static const struct bpf_ins_check ins_chk[UINT8_MAX + 1] = {
 		.imm = { .min = 0, .max = UINT32_MAX,},
 		.eval = eval_alu,
 	},
-	[(BPF_ALU | EBPF_MOV | BPF_K)] = {
+	[(BPF_ALU | BPF_MOV | BPF_K)] = {
 		.mask = {.dreg = WRT_REGS, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = UINT32_MAX,},
@@ -1733,73 +1733,73 @@ static const struct bpf_ins_check ins_chk[UINT8_MAX + 1] = {
 		.eval = eval_alu,
 	},
 	/* ALU IMM 64-bit instructions */
-	[(EBPF_ALU64 | BPF_ADD | BPF_K)] = {
+	[(BPF_ALU64 | BPF_ADD | BPF_K)] = {
 		.mask = {.dreg = WRT_REGS, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = UINT32_MAX,},
 		.eval = eval_alu,
 	},
-	[(EBPF_ALU64 | BPF_SUB | BPF_K)] = {
+	[(BPF_ALU64 | BPF_SUB | BPF_K)] = {
 		.mask = {.dreg = WRT_REGS, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = UINT32_MAX,},
 		.eval = eval_alu,
 	},
-	[(EBPF_ALU64 | BPF_AND | BPF_K)] = {
+	[(BPF_ALU64 | BPF_AND | BPF_K)] = {
 		.mask = {.dreg = WRT_REGS, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = UINT32_MAX,},
 		.eval = eval_alu,
 	},
-	[(EBPF_ALU64 | BPF_OR | BPF_K)] = {
+	[(BPF_ALU64 | BPF_OR | BPF_K)] = {
 		.mask = {.dreg = WRT_REGS, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = UINT32_MAX,},
 		.eval = eval_alu,
 	},
-	[(EBPF_ALU64 | BPF_LSH | BPF_K)] = {
+	[(BPF_ALU64 | BPF_LSH | BPF_K)] = {
 		.mask = {.dreg = WRT_REGS, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = UINT32_MAX,},
 		.eval = eval_alu,
 	},
-	[(EBPF_ALU64 | BPF_RSH | BPF_K)] = {
+	[(BPF_ALU64 | BPF_RSH | BPF_K)] = {
 		.mask = {.dreg = WRT_REGS, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = UINT32_MAX,},
 		.eval = eval_alu,
 	},
-	[(EBPF_ALU64 | EBPF_ARSH | BPF_K)] = {
+	[(BPF_ALU64 | BPF_ARSH | BPF_K)] = {
 		.mask = {.dreg = WRT_REGS, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = UINT32_MAX,},
 		.eval = eval_alu,
 	},
-	[(EBPF_ALU64 | BPF_XOR | BPF_K)] = {
+	[(BPF_ALU64 | BPF_XOR | BPF_K)] = {
 		.mask = {.dreg = WRT_REGS, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = UINT32_MAX,},
 		.eval = eval_alu,
 	},
-	[(EBPF_ALU64 | BPF_MUL | BPF_K)] = {
+	[(BPF_ALU64 | BPF_MUL | BPF_K)] = {
 		.mask = {.dreg = WRT_REGS, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = UINT32_MAX,},
 		.eval = eval_alu,
 	},
-	[(EBPF_ALU64 | EBPF_MOV | BPF_K)] = {
+	[(BPF_ALU64 | BPF_MOV | BPF_K)] = {
 		.mask = {.dreg = WRT_REGS, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = UINT32_MAX,},
 		.eval = eval_alu,
 	},
-	[(EBPF_ALU64 | BPF_DIV | BPF_K)] = {
+	[(BPF_ALU64 | BPF_DIV | BPF_K)] = {
 		.mask = { .dreg = WRT_REGS, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 1, .max = UINT32_MAX},
 		.eval = eval_alu,
 	},
-	[(EBPF_ALU64 | BPF_MOD | BPF_K)] = {
+	[(BPF_ALU64 | BPF_MOD | BPF_K)] = {
 		.mask = { .dreg = WRT_REGS, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 1, .max = UINT32_MAX},
@@ -1866,7 +1866,7 @@ static const struct bpf_ins_check ins_chk[UINT8_MAX + 1] = {
 		.imm = { .min = 0, .max = 0},
 		.eval = eval_alu,
 	},
-	[(BPF_ALU | EBPF_MOV | BPF_X)] = {
+	[(BPF_ALU | BPF_MOV | BPF_X)] = {
 		.mask = { .dreg = WRT_REGS, .sreg = ALL_REGS},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = 0},
@@ -1878,14 +1878,14 @@ static const struct bpf_ins_check ins_chk[UINT8_MAX + 1] = {
 		.imm = { .min = 0, .max = 0},
 		.eval = eval_alu,
 	},
-	[(BPF_ALU | EBPF_END | EBPF_TO_BE)] = {
+	[(BPF_ALU | BPF_END | BPF_TO_BE)] = {
 		.mask = { .dreg = WRT_REGS, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 16, .max = 64},
 		.check = check_alu_bele,
 		.eval = eval_bele,
 	},
-	[(BPF_ALU | EBPF_END | EBPF_TO_LE)] = {
+	[(BPF_ALU | BPF_END | BPF_TO_LE)] = {
 		.mask = { .dreg = WRT_REGS, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 16, .max = 64},
@@ -1893,79 +1893,79 @@ static const struct bpf_ins_check ins_chk[UINT8_MAX + 1] = {
 		.eval = eval_bele,
 	},
 	/* ALU REG 64-bit instructions */
-	[(EBPF_ALU64 | BPF_ADD | BPF_X)] = {
+	[(BPF_ALU64 | BPF_ADD | BPF_X)] = {
 		.mask = { .dreg = WRT_REGS, .sreg = ALL_REGS},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = 0},
 		.eval = eval_alu,
 	},
-	[(EBPF_ALU64 | BPF_SUB | BPF_X)] = {
+	[(BPF_ALU64 | BPF_SUB | BPF_X)] = {
 		.mask = { .dreg = WRT_REGS, .sreg = ALL_REGS},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = 0},
 		.eval = eval_alu,
 	},
-	[(EBPF_ALU64 | BPF_AND | BPF_X)] = {
+	[(BPF_ALU64 | BPF_AND | BPF_X)] = {
 		.mask = { .dreg = WRT_REGS, .sreg = ALL_REGS},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = 0},
 		.eval = eval_alu,
 	},
-	[(EBPF_ALU64 | BPF_OR | BPF_X)] = {
+	[(BPF_ALU64 | BPF_OR | BPF_X)] = {
 		.mask = { .dreg = WRT_REGS, .sreg = ALL_REGS},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = 0},
 		.eval = eval_alu,
 	},
-	[(EBPF_ALU64 | BPF_LSH | BPF_X)] = {
+	[(BPF_ALU64 | BPF_LSH | BPF_X)] = {
 		.mask = { .dreg = WRT_REGS, .sreg = ALL_REGS},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = 0},
 		.eval = eval_alu,
 	},
-	[(EBPF_ALU64 | BPF_RSH | BPF_X)] = {
+	[(BPF_ALU64 | BPF_RSH | BPF_X)] = {
 		.mask = { .dreg = WRT_REGS, .sreg = ALL_REGS},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = 0},
 		.eval = eval_alu,
 	},
-	[(EBPF_ALU64 | EBPF_ARSH | BPF_X)] = {
+	[(BPF_ALU64 | BPF_ARSH | BPF_X)] = {
 		.mask = { .dreg = WRT_REGS, .sreg = ALL_REGS},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = 0},
 		.eval = eval_alu,
 	},
-	[(EBPF_ALU64 | BPF_XOR | BPF_X)] = {
+	[(BPF_ALU64 | BPF_XOR | BPF_X)] = {
 		.mask = { .dreg = WRT_REGS, .sreg = ALL_REGS},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = 0},
 		.eval = eval_alu,
 	},
-	[(EBPF_ALU64 | BPF_MUL | BPF_X)] = {
+	[(BPF_ALU64 | BPF_MUL | BPF_X)] = {
 		.mask = { .dreg = WRT_REGS, .sreg = ALL_REGS},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = 0},
 		.eval = eval_alu,
 	},
-	[(EBPF_ALU64 | BPF_DIV | BPF_X)] = {
+	[(BPF_ALU64 | BPF_DIV | BPF_X)] = {
 		.mask = { .dreg = WRT_REGS, .sreg = ALL_REGS},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = 0},
 		.eval = eval_alu,
 	},
-	[(EBPF_ALU64 | BPF_MOD | BPF_X)] = {
+	[(BPF_ALU64 | BPF_MOD | BPF_X)] = {
 		.mask = { .dreg = WRT_REGS, .sreg = ALL_REGS},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = 0},
 		.eval = eval_alu,
 	},
-	[(EBPF_ALU64 | EBPF_MOV | BPF_X)] = {
+	[(BPF_ALU64 | BPF_MOV | BPF_X)] = {
 		.mask = { .dreg = WRT_REGS, .sreg = ALL_REGS},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = 0},
 		.eval = eval_alu,
 	},
-	[(EBPF_ALU64 | BPF_NEG)] = {
+	[(BPF_ALU64 | BPF_NEG)] = {
 		.mask = { .dreg = WRT_REGS, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = 0},
@@ -1990,14 +1990,14 @@ static const struct bpf_ins_check ins_chk[UINT8_MAX + 1] = {
 		.imm = { .min = 0, .max = 0},
 		.eval = eval_load,
 	},
-	[(BPF_LDX | BPF_MEM | EBPF_DW)] = {
+	[(BPF_LDX | BPF_MEM | BPF_DW)] = {
 		.mask = {. dreg = WRT_REGS, .sreg = ALL_REGS},
 		.off = { .min = 0, .max = UINT16_MAX},
 		.imm = { .min = 0, .max = 0},
 		.eval = eval_load,
 	},
 	/* load 64 bit immediate value */
-	[(BPF_LD | BPF_IMM | EBPF_DW)] = {
+	[(BPF_LD | BPF_IMM | BPF_DW)] = {
 		.mask = { .dreg = WRT_REGS, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = UINT32_MAX},
@@ -2060,23 +2060,23 @@ static const struct bpf_ins_check ins_chk[UINT8_MAX + 1] = {
 		.imm = { .min = 0, .max = 0},
 		.eval = eval_store,
 	},
-	[(BPF_STX | BPF_MEM | EBPF_DW)] = {
+	[(BPF_STX | BPF_MEM | BPF_DW)] = {
 		.mask = { .dreg = ALL_REGS, .sreg = ALL_REGS},
 		.off = { .min = 0, .max = UINT16_MAX},
 		.imm = { .min = 0, .max = 0},
 		.eval = eval_store,
 	},
 	/* atomic instructions */
-	[(BPF_STX | EBPF_ATOMIC | BPF_W)] = {
+	[(BPF_STX | BPF_ATOMIC | BPF_W)] = {
 		.mask = { .dreg = ALL_REGS, .sreg = ALL_REGS},
 		.off = { .min = 0, .max = UINT16_MAX},
-		.imm = { .min = BPF_ATOMIC_ADD, .max = BPF_ATOMIC_XCHG},
+		.imm = { .min = BPF_ADD, .max = BPF_XCHG},
 		.eval = eval_store,
 	},
-	[(BPF_STX | EBPF_ATOMIC | EBPF_DW)] = {
+	[(BPF_STX | BPF_ATOMIC | BPF_DW)] = {
 		.mask = { .dreg = ALL_REGS, .sreg = ALL_REGS},
 		.off = { .min = 0, .max = UINT16_MAX},
-		.imm = { .min = BPF_ATOMIC_ADD, .max = BPF_ATOMIC_XCHG},
+		.imm = { .min = BPF_ADD, .max = BPF_XCHG},
 		.eval = eval_store,
 	},
 	/* store IMM instructions */
@@ -2098,7 +2098,7 @@ static const struct bpf_ins_check ins_chk[UINT8_MAX + 1] = {
 		.imm = { .min = 0, .max = UINT32_MAX},
 		.eval = eval_store,
 	},
-	[(BPF_ST | BPF_MEM | EBPF_DW)] = {
+	[(BPF_ST | BPF_MEM | BPF_DW)] = {
 		.mask = { .dreg = ALL_REGS, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = UINT16_MAX},
 		.imm = { .min = 0, .max = UINT32_MAX},
@@ -2118,7 +2118,7 @@ static const struct bpf_ins_check ins_chk[UINT8_MAX + 1] = {
 		.imm = { .min = 0, .max = UINT32_MAX},
 		.eval = eval_jcc,
 	},
-	[(BPF_JMP | EBPF_JNE | BPF_K)] = {
+	[(BPF_JMP | BPF_JNE | BPF_K)] = {
 		.mask = { .dreg = ALL_REGS, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = UINT16_MAX},
 		.imm = { .min = 0, .max = UINT32_MAX},
@@ -2130,7 +2130,7 @@ static const struct bpf_ins_check ins_chk[UINT8_MAX + 1] = {
 		.imm = { .min = 0, .max = UINT32_MAX},
 		.eval = eval_jcc,
 	},
-	[(BPF_JMP | EBPF_JLT | BPF_K)] = {
+	[(BPF_JMP | BPF_JLT | BPF_K)] = {
 		.mask = { .dreg = ALL_REGS, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = UINT16_MAX},
 		.imm = { .min = 0, .max = UINT32_MAX},
@@ -2142,31 +2142,31 @@ static const struct bpf_ins_check ins_chk[UINT8_MAX + 1] = {
 		.imm = { .min = 0, .max = UINT32_MAX},
 		.eval = eval_jcc,
 	},
-	[(BPF_JMP | EBPF_JLE | BPF_K)] = {
+	[(BPF_JMP | BPF_JLE | BPF_K)] = {
 		.mask = { .dreg = ALL_REGS, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = UINT16_MAX},
 		.imm = { .min = 0, .max = UINT32_MAX},
 		.eval = eval_jcc,
 	},
-	[(BPF_JMP | EBPF_JSGT | BPF_K)] = {
+	[(BPF_JMP | BPF_JSGT | BPF_K)] = {
 		.mask = { .dreg = ALL_REGS, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = UINT16_MAX},
 		.imm = { .min = 0, .max = UINT32_MAX},
 		.eval = eval_jcc,
 	},
-	[(BPF_JMP | EBPF_JSLT | BPF_K)] = {
+	[(BPF_JMP | BPF_JSLT | BPF_K)] = {
 		.mask = { .dreg = ALL_REGS, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = UINT16_MAX},
 		.imm = { .min = 0, .max = UINT32_MAX},
 		.eval = eval_jcc,
 	},
-	[(BPF_JMP | EBPF_JSGE | BPF_K)] = {
+	[(BPF_JMP | BPF_JSGE | BPF_K)] = {
 		.mask = { .dreg = ALL_REGS, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = UINT16_MAX},
 		.imm = { .min = 0, .max = UINT32_MAX},
 		.eval = eval_jcc,
 	},
-	[(BPF_JMP | EBPF_JSLE | BPF_K)] = {
+	[(BPF_JMP | BPF_JSLE | BPF_K)] = {
 		.mask = { .dreg = ALL_REGS, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = UINT16_MAX},
 		.imm = { .min = 0, .max = UINT32_MAX},
@@ -2185,7 +2185,7 @@ static const struct bpf_ins_check ins_chk[UINT8_MAX + 1] = {
 		.imm = { .min = 0, .max = 0},
 		.eval = eval_jcc,
 	},
-	[(BPF_JMP | EBPF_JNE | BPF_X)] = {
+	[(BPF_JMP | BPF_JNE | BPF_X)] = {
 		.mask = { .dreg = ALL_REGS, .sreg = ALL_REGS},
 		.off = { .min = 0, .max = UINT16_MAX},
 		.imm = { .min = 0, .max = 0},
@@ -2197,7 +2197,7 @@ static const struct bpf_ins_check ins_chk[UINT8_MAX + 1] = {
 		.imm = { .min = 0, .max = 0},
 		.eval = eval_jcc,
 	},
-	[(BPF_JMP | EBPF_JLT | BPF_X)] = {
+	[(BPF_JMP | BPF_JLT | BPF_X)] = {
 		.mask = { .dreg = ALL_REGS, .sreg = ALL_REGS},
 		.off = { .min = 0, .max = UINT16_MAX},
 		.imm = { .min = 0, .max = 0},
@@ -2209,31 +2209,31 @@ static const struct bpf_ins_check ins_chk[UINT8_MAX + 1] = {
 		.imm = { .min = 0, .max = 0},
 		.eval = eval_jcc,
 	},
-	[(BPF_JMP | EBPF_JLE | BPF_X)] = {
+	[(BPF_JMP | BPF_JLE | BPF_X)] = {
 		.mask = { .dreg = ALL_REGS, .sreg = ALL_REGS},
 		.off = { .min = 0, .max = UINT16_MAX},
 		.imm = { .min = 0, .max = 0},
 		.eval = eval_jcc,
 	},
-	[(BPF_JMP | EBPF_JSGT | BPF_X)] = {
+	[(BPF_JMP | BPF_JSGT | BPF_X)] = {
 		.mask = { .dreg = ALL_REGS, .sreg = ALL_REGS},
 		.off = { .min = 0, .max = UINT16_MAX},
 		.imm = { .min = 0, .max = 0},
 		.eval = eval_jcc,
 	},
-	[(BPF_JMP | EBPF_JSLT | BPF_X)] = {
+	[(BPF_JMP | BPF_JSLT | BPF_X)] = {
 		.mask = { .dreg = ALL_REGS, .sreg = ALL_REGS},
 		.off = { .min = 0, .max = UINT16_MAX},
 		.imm = { .min = 0, .max = 0},
 		.eval = eval_jcc,
 	},
-	[(BPF_JMP | EBPF_JSGE | BPF_X)] = {
+	[(BPF_JMP | BPF_JSGE | BPF_X)] = {
 		.mask = { .dreg = ALL_REGS, .sreg = ALL_REGS},
 		.off = { .min = 0, .max = UINT16_MAX},
 		.imm = { .min = 0, .max = 0},
 		.eval = eval_jcc,
 	},
-	[(BPF_JMP | EBPF_JSLE | BPF_X)] = {
+	[(BPF_JMP | BPF_JSLE | BPF_X)] = {
 		.mask = { .dreg = ALL_REGS, .sreg = ALL_REGS},
 		.off = { .min = 0, .max = UINT16_MAX},
 		.imm = { .min = 0, .max = 0},
@@ -2246,14 +2246,14 @@ static const struct bpf_ins_check ins_chk[UINT8_MAX + 1] = {
 		.eval = eval_jcc,
 	},
 	/* call instruction */
-	[(BPF_JMP | EBPF_CALL)] = {
+	[(BPF_JMP | BPF_CALL)] = {
 		.mask = { .dreg = ZERO_REG, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = UINT32_MAX},
 		.eval = eval_call,
 	},
 	/* ret instruction */
-	[(BPF_JMP | EBPF_EXIT)] = {
+	[(BPF_JMP | BPF_EXIT)] = {
 		.mask = { .dreg = ZERO_REG, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = 0},
 		.imm = { .min = 0, .max = 0},
@@ -2461,7 +2461,7 @@ log_unreachable(const struct bpf_verifier *bvf)
 		ins = bvf->prm->raw.ins + i;
 
 		if (node->colour == WHITE &&
-				ins->code != (BPF_LD | BPF_IMM | EBPF_DW))
+				ins->code != (BPF_LD | BPF_IMM | BPF_DW))
 			RTE_BPF_LOG_LINE(ERR, "unreachable code at pc: %u;", i);
 	}
 }
@@ -2524,29 +2524,29 @@ validate(struct bpf_verifier *bvf)
 		 * outgoing edge.
 		 */
 		switch (ins->code) {
-		case (BPF_JMP | EBPF_EXIT):
+		case (BPF_JMP | BPF_EXIT):
 			break;
 		case (BPF_JMP | BPF_JEQ | BPF_K):
-		case (BPF_JMP | EBPF_JNE | BPF_K):
+		case (BPF_JMP | BPF_JNE | BPF_K):
 		case (BPF_JMP | BPF_JGT | BPF_K):
-		case (BPF_JMP | EBPF_JLT | BPF_K):
+		case (BPF_JMP | BPF_JLT | BPF_K):
 		case (BPF_JMP | BPF_JGE | BPF_K):
-		case (BPF_JMP | EBPF_JLE | BPF_K):
-		case (BPF_JMP | EBPF_JSGT | BPF_K):
-		case (BPF_JMP | EBPF_JSLT | BPF_K):
-		case (BPF_JMP | EBPF_JSGE | BPF_K):
-		case (BPF_JMP | EBPF_JSLE | BPF_K):
+		case (BPF_JMP | BPF_JLE | BPF_K):
+		case (BPF_JMP | BPF_JSGT | BPF_K):
+		case (BPF_JMP | BPF_JSLT | BPF_K):
+		case (BPF_JMP | BPF_JSGE | BPF_K):
+		case (BPF_JMP | BPF_JSLE | BPF_K):
 		case (BPF_JMP | BPF_JSET | BPF_K):
 		case (BPF_JMP | BPF_JEQ | BPF_X):
-		case (BPF_JMP | EBPF_JNE | BPF_X):
+		case (BPF_JMP | BPF_JNE | BPF_X):
 		case (BPF_JMP | BPF_JGT | BPF_X):
-		case (BPF_JMP | EBPF_JLT | BPF_X):
+		case (BPF_JMP | BPF_JLT | BPF_X):
 		case (BPF_JMP | BPF_JGE | BPF_X):
-		case (BPF_JMP | EBPF_JLE | BPF_X):
-		case (BPF_JMP | EBPF_JSGT | BPF_X):
-		case (BPF_JMP | EBPF_JSLT | BPF_X):
-		case (BPF_JMP | EBPF_JSGE | BPF_X):
-		case (BPF_JMP | EBPF_JSLE | BPF_X):
+		case (BPF_JMP | BPF_JLE | BPF_X):
+		case (BPF_JMP | BPF_JSGT | BPF_X):
+		case (BPF_JMP | BPF_JSLT | BPF_X):
+		case (BPF_JMP | BPF_JSGE | BPF_X):
+		case (BPF_JMP | BPF_JSLE | BPF_X):
 		case (BPF_JMP | BPF_JSET | BPF_X):
 			rc |= add_edge(bvf, node, i + ins->off + 1);
 			rc |= add_edge(bvf, node, i + 1);
@@ -2556,7 +2556,7 @@ validate(struct bpf_verifier *bvf)
 			rc |= add_edge(bvf, node, i + ins->off + 1);
 			break;
 		/* load 64 bit immediate value */
-		case (BPF_LD | BPF_IMM | EBPF_DW):
+		case (BPF_LD | BPF_IMM | BPF_DW):
 			rc |= add_edge(bvf, node, i + 2);
 			i++;
 			break;
@@ -2843,7 +2843,7 @@ cmp_eval_state(const struct bpf_eval_state *lv, const struct bpf_eval_state *rv)
 	/* for stack expect identical values */
 	rc = memcmp(lv->sv, rv->sv, sizeof(lv->sv));
 	if (rc != 0)
-		return -(2 * EBPF_REG_NUM);
+		return -(2 * MAX_BPF_REG);
 
 	k = 0;
 	/* check register values */
@@ -2941,7 +2941,7 @@ evaluate(struct bpf_verifier *bvf)
 	};
 
 	for (uint32_t pai = 0; pai != bvf->prm->nb_prog_arg; ++pai) {
-		struct bpf_reg_val *reg = &bvf->evst->rv[EBPF_REG_1 + pai];
+		struct bpf_reg_val *reg = &bvf->evst->rv[BPF_REG_1 + pai];
 
 		reg->v = bvf->prm->prog_arg[pai];
 		reg->mask = UINT64_MAX;
@@ -2949,7 +2949,7 @@ evaluate(struct bpf_verifier *bvf)
 			eval_max_bound(reg, UINT64_MAX);
 	}
 
-	bvf->evst->rv[EBPF_REG_10] = rvfp;
+	bvf->evst->rv[BPF_REG_10] = rvfp;
 
 	ins = bvf->prm->raw.ins;
 	node = bvf->in;
@@ -3127,7 +3127,7 @@ __rte_bpf_validate(const struct rte_bpf_prm_ex *prm, uint32_t *stack_sz)
 		if (!prog_arg_is_valid(&prm->prog_arg[pai])) {
 			RTE_BPF_LOG_FUNC_LINE(ERR,
 				"unsupported argument %d (r%d) type",
-				pai, EBPF_REG_1 + pai);
+				pai, BPF_REG_1 + pai);
 			return -ENOTSUP;
 		}
 
diff --git a/lib/bpf/rte_bpf.h b/lib/bpf/rte_bpf.h
index 2a1f52bd5c9b..9fafdf6f2729 100644
--- a/lib/bpf/rte_bpf.h
+++ b/lib/bpf/rte_bpf.h
@@ -291,7 +291,7 @@ rte_bpf_load(const struct rte_bpf_prm *prm)
 /**
  * Create a new eBPF execution context and load BPF code from given ELF
  * file into it.
- * Note that if the function will encounter EBPF_PSEUDO_CALL instruction
+ * Note that if the function will encounter BPF_PSEUDO_CALL instruction
  * that references external symbol, it will treat is as standard BPF_CALL
  * to the external helper function.
  *
-- 
2.43.0

