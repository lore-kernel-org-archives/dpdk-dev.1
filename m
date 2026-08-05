Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8EFC55174
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Aug 2026 09:47:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EE5640A71;
	Wed,  5 Aug 2026 11:47:05 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id D7FD8406BC
 for <dev@dpdk.org>; Wed,  5 Aug 2026 11:47:03 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=wzqRmH1QSneTT6eONjaZmlgYjKddK17cuIIjqGnMp7w=;
 b=4ItOoKebUYql+xWzsgmgOne2EfTFt0OUI1vaMt6RZP4psESirNOjyVJ8Ajo4OYf6dyYWOhUoD
 geR/CIIDSjUT6gGfRuvMejN2NlbFalytjQoCfwXNUfl0UAIhNyn6qerVM7/YzAgMevUvm+zEmPY
 5aZ5UroY5SeYjsseaCZtHrk=
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hFQXV1ZmZzJ467W;
 Wed,  5 Aug 2026 17:46:18 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 08ADC4058D;
 Wed,  5 Aug 2026 17:47:03 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Aug 2026 11:47:02 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>
CC: <dev@dpdk.org>, <stephen@networkplumber.org>, <thomas@monjalon.net>
Subject: [RFC 1/2] bpf: make bpf_def.h private
Date: Wed, 5 Aug 2026 10:46:41 +0100
Message-ID: <20260805094642.52433-2-marat.khalili@huawei.com>
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

Both `bpf_def.h` header file and the symbols it defined were not
previously prefixed with `rte_`, creating an opportunity for name
conflicts. Status of the file itself (private or public) was unclear.

Move public symbols after adding the necessary prefix (`rte_ebpf_insn`
and `RTE_EBPF_FUNC_MAX_ARGS`) into the public header file `rte_bpf.h`,
and make the rest private.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_bpf.c              | 79 ++++++++++++++++----------------
 app/test/test_bpf_validate.c     | 74 +++++++++++++++---------------
 lib/bpf/bpf_convert.c            | 38 +++++++--------
 lib/bpf/bpf_def.h                | 15 ------
 lib/bpf/bpf_dump.c               | 13 +++---
 lib/bpf/bpf_exec.c               |  8 ++--
 lib/bpf/bpf_impl.h               |  3 +-
 lib/bpf/bpf_jit_arm64.c          |  4 +-
 lib/bpf/bpf_jit_x86.c            |  2 +-
 lib/bpf/bpf_load.c               |  2 +-
 lib/bpf/bpf_load_elf.c           | 10 ++--
 lib/bpf/bpf_validate.c           | 44 +++++++++---------
 lib/bpf/bpf_validate.h           |  4 +-
 lib/bpf/bpf_validate_debug.c     |  6 +--
 lib/bpf/meson.build              |  2 +-
 lib/bpf/rte_bpf.h                | 33 +++++++++----
 lib/bpf/rte_bpf_validate_debug.h |  8 ++--
 17 files changed, 174 insertions(+), 171 deletions(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 3205afaa63ad..bf3e4dd0c1de 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -16,6 +16,7 @@
 #include <rte_byteorder.h>
 #include <rte_errno.h>
 
+#include "bpf_def.h"
 #include "test.h"
 
 #if !defined(RTE_LIB_BPF)
@@ -52,7 +53,7 @@ test_bpf(void)
  *   TEST_SUCCESS on success, error code on failure.
  */
 static int
-bpf_load_test(uint32_t nb_ins, const struct ebpf_insn *ins, int expected_errno)
+bpf_load_test(uint32_t nb_ins, const struct rte_ebpf_insn *ins, int expected_errno)
 {
 	const struct rte_bpf_prm prm = {
 		.ins = ins,
@@ -87,7 +88,7 @@ bpf_load_test(uint32_t nb_ins, const struct ebpf_insn *ins, int expected_errno)
 static int
 test_no_instructions(void)
 {
-	static const struct ebpf_insn ins[] = {};
+	static const struct rte_ebpf_insn ins[] = {};
 	return bpf_load_test(RTE_DIM(ins), ins, EINVAL);
 }
 
@@ -100,7 +101,7 @@ REGISTER_FAST_TEST(bpf_no_instructions_autotest, NOHUGE_OK, ASAN_OK, test_no_ins
 static int
 test_exit_only(void)
 {
-	static const struct ebpf_insn ins[] = {
+	static const struct rte_ebpf_insn ins[] = {
 		{
 			.code = (BPF_JMP | EBPF_EXIT),
 		},
@@ -117,7 +118,7 @@ REGISTER_FAST_TEST(bpf_exit_only_autotest, NOHUGE_OK, ASAN_OK, test_exit_only);
 static int
 test_no_exit(void)
 {
-	static const struct ebpf_insn ins[] = {
+	static const struct rte_ebpf_insn ins[] = {
 		{
 			/* Set return value to the program argument. */
 			.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
@@ -136,7 +137,7 @@ REGISTER_FAST_TEST(bpf_no_exit_autotest, NOHUGE_OK, ASAN_OK, test_no_exit);
 static int
 test_minimal_working(void)
 {
-	static const struct ebpf_insn ins[] = {
+	static const struct rte_ebpf_insn ins[] = {
 		{
 			/* Set return value to the program argument. */
 			.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
@@ -158,7 +159,7 @@ REGISTER_FAST_TEST(bpf_minimal_working_autotest, NOHUGE_OK, ASAN_OK, test_minima
 static int
 test_add_one(void)
 {
-	static const struct ebpf_insn ins[] = {
+	static const struct rte_ebpf_insn ins[] = {
 		{
 			/* Set return value to one. */
 			.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
@@ -186,7 +187,7 @@ REGISTER_FAST_TEST(bpf_add_one_autotest, NOHUGE_OK, ASAN_OK, test_add_one);
 static int
 test_subtract_one(void)
 {
-	static const struct ebpf_insn ins[] = {
+	static const struct rte_ebpf_insn ins[] = {
 		{
 			/* Subtract one from the program argument. */
 			.code = (EBPF_ALU64 | BPF_SUB | BPF_K),
@@ -214,7 +215,7 @@ REGISTER_FAST_TEST(bpf_subtract_one_autotest, NOHUGE_OK, ASAN_OK, test_subtract_
 static int
 test_jump_over_invalid_first(void)
 {
-	static const struct ebpf_insn ins[] = {
+	static const struct rte_ebpf_insn ins[] = {
 		{
 			/* Jump over the next instruction for some r1. */
 			.code = (BPF_JMP | BPF_JEQ | BPF_K),
@@ -251,7 +252,7 @@ REGISTER_FAST_TEST(bpf_jump_over_invalid_first_autotest, NOHUGE_OK, ASAN_OK,
 static int
 test_jump_over_invalid_non_first(void)
 {
-	static const struct ebpf_insn ins[] = {
+	static const struct rte_ebpf_insn ins[] = {
 		{
 			/* Set return value to the program argument. */
 			.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
@@ -401,7 +402,7 @@ dummy_prepare(void *arg)
 }
 
 /* store immediate test-cases */
-static const struct ebpf_insn test_store1_prog[] = {
+static const struct rte_ebpf_insn test_store1_prog[] = {
 	{
 		.code = (BPF_ST | BPF_MEM | BPF_B),
 		.dst_reg = EBPF_REG_1,
@@ -464,7 +465,7 @@ test_store1_check(uint64_t rc, const void *arg)
 }
 
 /* store register test-cases */
-static const struct ebpf_insn test_store2_prog[] = {
+static const struct rte_ebpf_insn test_store2_prog[] = {
 
 	{
 		.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
@@ -507,7 +508,7 @@ static const struct ebpf_insn test_store2_prog[] = {
 };
 
 /* load test-cases */
-static const struct ebpf_insn test_load1_prog[] = {
+static const struct rte_ebpf_insn test_load1_prog[] = {
 
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_B),
@@ -584,7 +585,7 @@ test_load1_check(uint64_t rc, const void *arg)
 }
 
 /* load immediate test-cases */
-static const struct ebpf_insn test_ldimm1_prog[] = {
+static const struct rte_ebpf_insn test_ldimm1_prog[] = {
 
 	{
 		.code = (BPF_LD | BPF_IMM | EBPF_DW),
@@ -672,7 +673,7 @@ test_ldimm1_check(uint64_t rc, const void *arg)
 
 
 /* alu mul test-cases */
-static const struct ebpf_insn test_mul1_prog[] = {
+static const struct rte_ebpf_insn test_mul1_prog[] = {
 
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_W),
@@ -784,7 +785,7 @@ test_mul1_check(uint64_t rc, const void *arg)
 }
 
 /* alu shift test-cases */
-static const struct ebpf_insn test_shift1_prog[] = {
+static const struct rte_ebpf_insn test_shift1_prog[] = {
 
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_W),
@@ -979,7 +980,7 @@ test_shift1_check(uint64_t rc, const void *arg)
 }
 
 /* jmp test-cases */
-static const struct ebpf_insn test_jump1_prog[] = {
+static const struct rte_ebpf_insn test_jump1_prog[] = {
 
 	[0] = {
 		.code = (BPF_ALU | EBPF_MOV | BPF_K),
@@ -1188,7 +1189,7 @@ test_jump1_check(uint64_t rc, const void *arg)
 }
 
 /* Jump test case - check ip4_dest in particular subnet */
-static const struct ebpf_insn test_jump2_prog[] = {
+static const struct rte_ebpf_insn test_jump2_prog[] = {
 
 	[0] = {
 		.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
@@ -1353,7 +1354,7 @@ test_jump2_check(uint64_t rc, const void *arg)
 }
 
 /* alu (add, sub, and, or, xor, neg)  test-cases */
-static const struct ebpf_insn test_alu1_prog[] = {
+static const struct rte_ebpf_insn test_alu1_prog[] = {
 
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_W),
@@ -1535,7 +1536,7 @@ test_alu1_check(uint64_t rc, const void *arg)
 }
 
 /* endianness conversions (BE->LE/LE->BE)  test-cases */
-static const struct ebpf_insn test_bele1_prog[] = {
+static const struct rte_ebpf_insn test_bele1_prog[] = {
 
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_H),
@@ -1701,7 +1702,7 @@ test_bele1_check(uint64_t rc, const void *arg)
 }
 
 /* atomic add test-cases */
-static const struct ebpf_insn test_xadd1_prog[] = {
+static const struct rte_ebpf_insn test_xadd1_prog[] = {
 
 	{
 		.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
@@ -1889,7 +1890,7 @@ test_xadd1_check(uint64_t rc, const void *arg)
 }
 
 /* alu div test-cases */
-static const struct ebpf_insn test_div1_prog[] = {
+static const struct rte_ebpf_insn test_div1_prog[] = {
 
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_W),
@@ -2013,7 +2014,7 @@ test_div1_check(uint64_t rc, const void *arg)
 }
 
 /* call test-cases */
-static const struct ebpf_insn test_call1_prog[] = {
+static const struct rte_ebpf_insn test_call1_prog[] = {
 
 	{
 		.code = (BPF_LDX | BPF_MEM | BPF_W),
@@ -2138,7 +2139,7 @@ static const struct rte_bpf_xsym test_call1_xsym[] = {
 	},
 };
 
-static const struct ebpf_insn test_call2_prog[] = {
+static const struct rte_ebpf_insn test_call2_prog[] = {
 
 	{
 		.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
@@ -2264,7 +2265,7 @@ static const struct rte_bpf_xsym test_call2_xsym[] = {
 	},
 };
 
-static const struct ebpf_insn test_call3_prog[] = {
+static const struct rte_ebpf_insn test_call3_prog[] = {
 
 	{
 		.code = (BPF_JMP | EBPF_CALL),
@@ -2377,7 +2378,7 @@ static const struct rte_bpf_xsym test_call3_xsym[] = {
 };
 
 /* Test for stack corruption in multiple function calls */
-static const struct ebpf_insn test_call4_prog[] = {
+static const struct rte_ebpf_insn test_call4_prog[] = {
 	{
 		.code = (BPF_ST | BPF_MEM | BPF_B),
 		.dst_reg = EBPF_REG_10,
@@ -2550,7 +2551,7 @@ static const struct rte_bpf_xsym test_call4_xsym[] = {
 };
 
 /* string compare test case */
-static const struct ebpf_insn test_call5_prog[] = {
+static const struct rte_ebpf_insn test_call5_prog[] = {
 
 	[0] = {
 		.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
@@ -2758,7 +2759,7 @@ static const struct rte_bpf_xsym test_call5_xsym[] = {
 };
 
 /* load mbuf (BPF_ABS/BPF_IND) test-cases */
-static const struct ebpf_insn test_ld_mbuf1_prog[] = {
+static const struct rte_ebpf_insn test_ld_mbuf1_prog[] = {
 
 	/* BPF_ABS/BPF_IND implicitly expect mbuf ptr in R6 */
 	{
@@ -3016,7 +3017,7 @@ test_ld_mbuf2_check(uint64_t rc, const void *arg)
 }
 
 /* same as test_ld_mbuf1, but now store intermediate results on the stack */
-static const struct ebpf_insn test_ld_mbuf3_prog[] = {
+static const struct rte_ebpf_insn test_ld_mbuf3_prog[] = {
 
 	/* BPF_ABS/BPF_IND implicitly expect mbuf ptr in R6 */
 	{
@@ -3165,7 +3166,7 @@ static const struct ebpf_insn test_ld_mbuf3_prog[] = {
 };
 
 /* divide INT64_MIN by -1 */
-static const struct ebpf_insn test_int64min_udiv_uint64max_prog[] = {
+static const struct rte_ebpf_insn test_int64min_udiv_uint64max_prog[] = {
 	/* Load INT64_MIN into r0 */
 	{
 		.code = (BPF_LD | BPF_IMM | EBPF_DW),
@@ -3197,7 +3198,7 @@ test_int64min_udiv_uint64max_check(uint64_t rc, const void *arg)
 }
 
 /* modulo INT64_MIN by -1 */
-static const struct ebpf_insn test_int64min_umod_uint64max_prog[] = {
+static const struct rte_ebpf_insn test_int64min_umod_uint64max_prog[] = {
 	/* Load INT64_MIN into r0 */
 	{
 		.code = (BPF_LD | BPF_IMM | EBPF_DW),
@@ -3652,7 +3653,7 @@ REGISTER_FAST_TEST(bpf_load_null_autotest, NOHUGE_OK, ASAN_OK, test_bpf_load_nul
 static int
 test_bpf_exec_wrong_nb_prog_arg(void)
 {
-	static const struct ebpf_insn ins[] = {
+	static const struct rte_ebpf_insn ins[] = {
 		{ .code = (EBPF_ALU64 | EBPF_MOV | BPF_K), .dst_reg = EBPF_REG_0, .imm = 0 },
 		{ .code = (BPF_JMP | EBPF_EXIT), }
 	};
@@ -3694,7 +3695,7 @@ REGISTER_FAST_TEST(bpf_exec_wrong_nb_prog_arg_autotest, NOHUGE_OK, ASAN_OK,
 static int
 test_bpf_exec_wrong_flags(void)
 {
-	static const struct ebpf_insn ins[] = {
+	static const struct rte_ebpf_insn ins[] = {
 		{ .code = (EBPF_ALU64 | EBPF_MOV | BPF_K), .dst_reg = EBPF_REG_0, .imm = 0 },
 		{ .code = (BPF_JMP | EBPF_EXIT), }
 	};
@@ -3757,7 +3758,7 @@ typedef uint64_t (*text_xfunc_t)(uint64_t argument);
 static int
 call_from_bpf_test(text_xfunc_t xfunc)
 {
-	static const struct ebpf_insn ins[] = {
+	static const struct rte_ebpf_insn ins[] = {
 		{
 			.code = (BPF_JMP | EBPF_CALL),
 			.imm = 0,  /* xsym #0 */
@@ -4935,7 +4936,7 @@ static const struct xchg_arg xchg_input = {
 
 /* Run program against xchg_input and compare output value with expected. */
 static int
-run_xchg_test(uint32_t nb_ins, const struct ebpf_insn *ins, struct xchg_arg expected)
+run_xchg_test(uint32_t nb_ins, const struct rte_ebpf_insn *ins, struct xchg_arg expected)
 {
 	const struct rte_bpf_prm prm = {
 		.ins = ins,
@@ -5002,7 +5003,7 @@ run_xchg_test(uint32_t nb_ins, const struct ebpf_insn *ins, struct xchg_arg expe
 static int
 test_xadd32(void)
 {
-	static const struct ebpf_insn ins[] = {
+	static const struct rte_ebpf_insn ins[] = {
 		{
 			/* Set r0 to return value. */
 			.code = (BPF_LD | BPF_IMM | EBPF_DW),
@@ -5082,7 +5083,7 @@ REGISTER_FAST_TEST(bpf_xadd32_autotest, NOHUGE_OK, ASAN_OK, test_xadd32);
 static int
 test_xadd64(void)
 {
-	static const struct ebpf_insn ins[] = {
+	static const struct rte_ebpf_insn ins[] = {
 		{
 			/* Set r0 to return value. */
 			.code = (BPF_LD | BPF_IMM | EBPF_DW),
@@ -5148,7 +5149,7 @@ REGISTER_FAST_TEST(bpf_xadd64_autotest, NOHUGE_OK, ASAN_OK, test_xadd64);
 static int
 test_xchg32(void)
 {
-	static const struct ebpf_insn ins[] = {
+	static const struct rte_ebpf_insn ins[] = {
 		{
 			/* Set r2 to return value. */
 			.code = (BPF_LD | BPF_IMM | EBPF_DW),
@@ -5243,7 +5244,7 @@ REGISTER_FAST_TEST(bpf_xchg32_autotest, NOHUGE_OK, ASAN_OK, test_xchg32);
 static int
 test_xchg64(void)
 {
-	static const struct ebpf_insn ins[] = {
+	static const struct rte_ebpf_insn ins[] = {
 		{
 			/* Set r2 to return value. */
 			.code = (BPF_LD | BPF_IMM | EBPF_DW),
@@ -5306,7 +5307,7 @@ REGISTER_FAST_TEST(bpf_xchg64_autotest, NOHUGE_OK, ASAN_OK, test_xchg64);
 static int
 test_atomic_imm(int32_t imm, bool is_valid)
 {
-	const struct ebpf_insn ins[] = {
+	const struct rte_ebpf_insn ins[] = {
 		{
 			/* Set r2 to return value. */
 			.code = (BPF_LD | BPF_IMM | EBPF_DW),
diff --git a/app/test/test_bpf_validate.c b/app/test/test_bpf_validate.c
index 066f1fa156ae..110dec81b017 100644
--- a/app/test/test_bpf_validate.c
+++ b/app/test/test_bpf_validate.c
@@ -2,9 +2,9 @@
  * Copyright(c) 2025 Huawei Technologies Co., Ltd
  */
 
+#include "bpf_def.h"
 #include "test.h"
 
-#include <bpf_def.h>
 #include <rte_bpf.h>
 #include <rte_bpf_validate_debug.h>
 #include <rte_errno.h>
@@ -96,7 +96,7 @@ struct state {
 
 /* Instruction verification parameters. */
 struct verify_instruction_param {
-	struct ebpf_insn tested_instruction;
+	struct rte_ebpf_insn tested_instruction;
 	size_t area_size;
 	/* States just before the tested instruction, just after, or if jumped. */
 	struct state pre;
@@ -264,7 +264,7 @@ format_register(struct rte_bpf_validate_debug *debug, char *buffer, size_t bufsz
 /* Return true the specified conditional jump _may_ occur at current state. */
 static bool
 may_jump(const struct rte_bpf_validate_debug *debug,
-	const struct ebpf_insn *jump, uint64_t imm64)
+	const struct rte_ebpf_insn *jump, uint64_t imm64)
 {
 	const int result = rte_bpf_validate_debug_may_jump(debug, jump, imm64);
 	RTE_VERIFY(result >= 0);
@@ -279,7 +279,7 @@ check_signed_interval(struct rte_bpf_validate_debug *debug,
 	char buffer[VALUE_FORMAT_BUFFER_SIZE];
 
 	TEST_ASSERT_EQUAL(may_jump(debug,
-		&(struct ebpf_insn){
+		&(struct rte_ebpf_insn){
 			.code = (BPF_JMP | EBPF_JSLT | BPF_K),
 			.dst_reg = reg,
 		}, interval.min),
@@ -288,7 +288,7 @@ check_signed_interval(struct rte_bpf_validate_debug *debug,
 		format_value(buffer, sizeof(buffer), 'd', interval.min));
 
 	TEST_ASSERT_EQUAL(may_jump(debug,
-		&(struct ebpf_insn){
+		&(struct rte_ebpf_insn){
 			.code = (BPF_JMP | BPF_JEQ | BPF_K),
 			.dst_reg = reg,
 		}, interval.min),
@@ -297,7 +297,7 @@ check_signed_interval(struct rte_bpf_validate_debug *debug,
 		format_value(buffer, sizeof(buffer), 'd', interval.min));
 
 	TEST_ASSERT_EQUAL(may_jump(debug,
-		&(struct ebpf_insn){
+		&(struct rte_ebpf_insn){
 			.code = (BPF_JMP | BPF_JEQ | BPF_K),
 			.dst_reg = reg,
 		}, interval.max),
@@ -306,7 +306,7 @@ check_signed_interval(struct rte_bpf_validate_debug *debug,
 		format_value(buffer, sizeof(buffer), 'd', interval.max));
 
 	TEST_ASSERT_EQUAL(may_jump(debug,
-		&(struct ebpf_insn){
+		&(struct rte_ebpf_insn){
 			.code = (BPF_JMP | EBPF_JSGT | BPF_K),
 			.dst_reg = reg,
 		}, interval.max),
@@ -325,7 +325,7 @@ check_unsigned_interval(struct rte_bpf_validate_debug *debug,
 	char buffer[VALUE_FORMAT_BUFFER_SIZE];
 
 	TEST_ASSERT_EQUAL(may_jump(debug,
-		&(struct ebpf_insn){
+		&(struct rte_ebpf_insn){
 			.code = (BPF_JMP | EBPF_JLT | BPF_K),
 			.dst_reg = reg,
 		}, interval.min),
@@ -334,7 +334,7 @@ check_unsigned_interval(struct rte_bpf_validate_debug *debug,
 		format_value(buffer, sizeof(buffer), 'x', interval.min));
 
 	TEST_ASSERT_EQUAL(may_jump(debug,
-		&(struct ebpf_insn){
+		&(struct rte_ebpf_insn){
 			.code = (BPF_JMP | BPF_JEQ | BPF_K),
 			.dst_reg = reg,
 		}, interval.min),
@@ -343,7 +343,7 @@ check_unsigned_interval(struct rte_bpf_validate_debug *debug,
 		format_value(buffer, sizeof(buffer), 'x', interval.min));
 
 	TEST_ASSERT_EQUAL(may_jump(debug,
-		&(struct ebpf_insn){
+		&(struct rte_ebpf_insn){
 			.code = (BPF_JMP | BPF_JEQ | BPF_K),
 			.dst_reg = reg,
 		}, interval.max),
@@ -352,7 +352,7 @@ check_unsigned_interval(struct rte_bpf_validate_debug *debug,
 		format_value(buffer, sizeof(buffer), 'x', interval.max));
 
 	TEST_ASSERT_EQUAL(may_jump(debug,
-		&(struct ebpf_insn){
+		&(struct rte_ebpf_insn){
 			.code = (BPF_JMP | BPF_JGT | BPF_K),
 			.dst_reg = reg,
 		}, interval.max),
@@ -371,7 +371,7 @@ check_relative_interval(struct rte_bpf_validate_debug *debug,
 	char buffer[VALUE_FORMAT_BUFFER_SIZE];
 
 	TEST_ASSERT_EQUAL(may_jump(debug,
-		&(struct ebpf_insn){
+		&(struct rte_ebpf_insn){
 			.code = (BPF_JMP | EBPF_JLT | BPF_X),
 			.dst_reg = reg,
 			.src_reg = base_reg,
@@ -381,7 +381,7 @@ check_relative_interval(struct rte_bpf_validate_debug *debug,
 		format_value(buffer, sizeof(buffer), 'd', interval.min));
 
 	TEST_ASSERT_EQUAL(may_jump(debug,
-		&(struct ebpf_insn){
+		&(struct rte_ebpf_insn){
 			.code = (BPF_JMP | BPF_JEQ | BPF_X),
 			.dst_reg = reg,
 			.src_reg = base_reg,
@@ -391,7 +391,7 @@ check_relative_interval(struct rte_bpf_validate_debug *debug,
 		format_value(buffer, sizeof(buffer), 'd', interval.min));
 
 	TEST_ASSERT_EQUAL(may_jump(debug,
-		&(struct ebpf_insn){
+		&(struct rte_ebpf_insn){
 			.code = (BPF_JMP | BPF_JEQ | BPF_X),
 			.dst_reg = reg,
 			.src_reg = base_reg,
@@ -401,7 +401,7 @@ check_relative_interval(struct rte_bpf_validate_debug *debug,
 		format_value(buffer, sizeof(buffer), 'd', interval.max));
 
 	TEST_ASSERT_EQUAL(may_jump(debug,
-		&(struct ebpf_insn){
+		&(struct rte_ebpf_insn){
 			.code = (BPF_JMP | BPF_JGT | BPF_X),
 			.dst_reg = reg,
 			.src_reg = base_reg,
@@ -437,7 +437,7 @@ check_pointer_access(struct rte_bpf_validate_debug *debug, uint8_t reg,
 	const bool window_empty = (interval_size >= area_size);
 
 	TEST_ASSERT_EQUAL(rte_bpf_validate_debug_can_access(debug,
-		&(struct ebpf_insn){
+		&(struct rte_ebpf_insn){
 			.code = (BPF_LDX | BPF_B | BPF_MEM),
 			.src_reg = reg
 		}, window_begin - 1),
@@ -446,7 +446,7 @@ check_pointer_access(struct rte_bpf_validate_debug *debug, uint8_t reg,
 		format_value(buffer, sizeof(buffer), 'd', window_begin - 1));
 
 	TEST_ASSERT_EQUAL(rte_bpf_validate_debug_can_access(debug,
-		&(struct ebpf_insn){
+		&(struct rte_ebpf_insn){
 			.code = (BPF_LDX | BPF_B | BPF_MEM),
 			.src_reg = reg
 		}, window_begin),
@@ -456,7 +456,7 @@ check_pointer_access(struct rte_bpf_validate_debug *debug, uint8_t reg,
 		window_empty ? "invalid for empty window" : "valid");
 
 	TEST_ASSERT_EQUAL(rte_bpf_validate_debug_can_access(debug,
-		&(struct ebpf_insn){
+		&(struct rte_ebpf_insn){
 			.code = (BPF_LDX | BPF_B | BPF_MEM),
 			.src_reg = reg
 		}, window_end - 1),
@@ -466,7 +466,7 @@ check_pointer_access(struct rte_bpf_validate_debug *debug, uint8_t reg,
 		window_empty ? "invalid for empty window" : "valid");
 
 	TEST_ASSERT_EQUAL(rte_bpf_validate_debug_can_access(debug,
-		&(struct ebpf_insn){
+		&(struct rte_ebpf_insn){
 			.code = (BPF_LDX | BPF_B | BPF_MEM),
 			.src_reg = reg
 		}, window_end),
@@ -548,23 +548,23 @@ fits_in_imm32(int64_t value)
 
 /* Load constant into the register.  */
 static void
-load_constant(struct ebpf_insn **ins, uint8_t reg, int64_t value)
+load_constant(struct rte_ebpf_insn **ins, uint8_t reg, int64_t value)
 {
 	if (fits_in_imm32(value)) {
-		*(*ins)++ = (struct ebpf_insn){
+		*(*ins)++ = (struct rte_ebpf_insn){
 			.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
 			.dst_reg = reg,
 			.imm = (int32_t)value,
 		};
 	} else {
 		/* Load imm64 into tmp_reg using wide load, lower bits first... */
-		*(*ins)++ = (struct ebpf_insn){
+		*(*ins)++ = (struct rte_ebpf_insn){
 			.code = (BPF_LD | BPF_IMM | EBPF_DW),
 			.dst_reg = reg,
 			.imm = (uint32_t)value,
 		};
 		/* ... then higher bits. */
-		*(*ins)++ = (struct ebpf_insn){
+		*(*ins)++ = (struct rte_ebpf_insn){
 			.imm = (uint32_t)(value >> 32),
 		};
 	}
@@ -576,12 +576,12 @@ load_constant(struct ebpf_insn **ins, uint8_t reg, int64_t value)
  * Jump offset is not filled and should be patched in by the caller.
  */
 static void
-compare_and_jump(struct ebpf_insn **ins, uint8_t op, uint8_t reg,
+compare_and_jump(struct rte_ebpf_insn **ins, uint8_t op, uint8_t reg,
 	int64_t value, uint8_t tmp_reg)
 {
 	if (fits_in_imm32(value)) {
 		/* Jump on specified condition between reg and immediate. */
-		*(*ins)++ = (struct ebpf_insn){
+		*(*ins)++ = (struct rte_ebpf_insn){
 			.code = (BPF_JMP | op | BPF_K),
 			.dst_reg = reg,
 			.imm = (int32_t)value,
@@ -591,7 +591,7 @@ compare_and_jump(struct ebpf_insn **ins, uint8_t op, uint8_t reg,
 		load_constant(ins, tmp_reg, value);
 
 		/* Jump on specified condition between reg and tmp_reg. */
-		*(*ins)++ = (struct ebpf_insn){
+		*(*ins)++ = (struct rte_ebpf_insn){
 			.code = (BPF_JMP | op | BPF_X),
 			.dst_reg = reg,
 			.src_reg = tmp_reg,
@@ -606,7 +606,7 @@ compare_and_jump(struct ebpf_insn **ins, uint8_t op, uint8_t reg,
  * (Jump offsets are not filled and should be patched in by the caller.)
  */
 static void
-prepare_scalar_domain(struct ebpf_insn **ins, uint8_t reg,
+prepare_scalar_domain(struct rte_ebpf_insn **ins, uint8_t reg,
 	const struct domain *domain, uint8_t base_reg, int *service_cell_count,
 	uint8_t tmp_reg)
 {
@@ -617,7 +617,7 @@ prepare_scalar_domain(struct ebpf_insn **ins, uint8_t reg,
 	}
 
 	/* Load value from memory area into the register. */
-	*(*ins)++ = (struct ebpf_insn){
+	*(*ins)++ = (struct rte_ebpf_insn){
 		.code = (BPF_LDX | EBPF_DW | BPF_MEM),
 		.dst_reg = reg,
 		.src_reg = base_reg,
@@ -648,7 +648,7 @@ prepare_scalar_domain(struct ebpf_insn **ins, uint8_t reg,
  * and then add base register to it to convert it to a pointer, if needed.
  */
 static void
-prepare_domain(struct ebpf_insn **ins, uint8_t reg,
+prepare_domain(struct rte_ebpf_insn **ins, uint8_t reg,
 	const struct domain *domain, uint8_t base_reg, int *service_cell_count,
 	uint8_t tmp_reg)
 {
@@ -656,7 +656,7 @@ prepare_domain(struct ebpf_insn **ins, uint8_t reg,
 
 	if (domain->is_pointer)
 		/* Add base_reg to convert resulting scalar into a pointer. */
-		*(*ins)++ = (struct ebpf_insn){
+		*(*ins)++ = (struct rte_ebpf_insn){
 			.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
 			.dst_reg = reg,
 			.src_reg = base_reg,
@@ -717,9 +717,9 @@ fill_verify_instruction_defaults(struct verify_instruction_param *prm)
  * - Wide instructions are not supported yet.
  */
 static uint32_t
-generate_program(struct verify_instruction_context *ctx, struct ebpf_insn *ins)
+generate_program(struct verify_instruction_context *ctx, struct rte_ebpf_insn *ins)
 {
-	struct ebpf_insn *const ins_buf = ins;
+	struct rte_ebpf_insn *const ins_buf = ins;
 	/* Number of double words used for service purposes. */
 	int service_cell_count = 0;
 
@@ -784,7 +784,7 @@ generate_program(struct verify_instruction_context *ctx, struct ebpf_insn *ins)
 		ctx->jump.program_counter = NO_PROGRAM_COUNTER;
 	else {
 		/* Finish previous branch by issuing exit. */
-		*ins++ = (struct ebpf_insn){ .code = (BPF_JMP | EBPF_EXIT) };
+		*ins++ = (struct rte_ebpf_insn){ .code = (BPF_JMP | EBPF_EXIT) };
 
 		/* Issue jump target instruction (for setting jump breakpoint). */
 		ctx->jump.program_counter = ins - ins_buf;
@@ -798,7 +798,7 @@ generate_program(struct verify_instruction_context *ctx, struct ebpf_insn *ins)
 
 	/* Issue exit instruction. */
 	const uint32_t exit_pc = ins - ins_buf;
-	*ins++ = (struct ebpf_insn){ .code = (BPF_JMP | EBPF_EXIT) };
+	*ins++ = (struct rte_ebpf_insn){ .code = (BPF_JMP | EBPF_EXIT) };
 
 	/* Patch all jumps to point to exit. */
 	for (uint32_t pc = 0; pc != ctx->pre.program_counter; ++pc)
@@ -925,7 +925,7 @@ jump_callback(struct rte_bpf_validate_debug *debug, void *void_ctx)
 }
 
 static int
-debug_validation(struct verify_instruction_context *ctx, const struct ebpf_insn *ins,
+debug_validation(struct verify_instruction_context *ctx, const struct rte_ebpf_insn *ins,
 	uint32_t nb_ins)
 {
 	struct rte_bpf_validate_debug *const debug = rte_bpf_validate_debug_create();
@@ -994,7 +994,7 @@ debug_validation(struct verify_instruction_context *ctx, const struct ebpf_insn
 
 /* Dump whole program to log. */
 static void
-log_program_dump(const struct ebpf_insn *ins, uint32_t nb_ins, uint32_t pre_pc)
+log_program_dump(const struct rte_ebpf_insn *ins, uint32_t nb_ins, uint32_t pre_pc)
 {
 	char hexadecimal[DISASSEMBLY_FORMAT_BUFFER_SIZE];
 	char disassembly[DISASSEMBLY_FORMAT_BUFFER_SIZE];
@@ -1054,7 +1054,7 @@ verify_instruction(struct verify_instruction_param prm)
 	struct verify_instruction_context ctx = {
 		.prm = prm,
 	};
-	struct ebpf_insn ins_buf[64];
+	struct rte_ebpf_insn ins_buf[64];
 
 	const uint32_t nb_ins = generate_program(&ctx, ins_buf);
 	RTE_ASSERT(nb_ins <= RTE_DIM(ins_buf));
diff --git a/lib/bpf/bpf_convert.c b/lib/bpf/bpf_convert.c
index e8074b13d037..37095eea52ce 100644
--- a/lib/bpf/bpf_convert.c
+++ b/lib/bpf/bpf_convert.c
@@ -82,7 +82,7 @@
 /* ALU ops on registers, bpf_add|sub|...: dst_reg += src_reg */
 
 #define EBPF_ALU64_REG(OP, DST, SRC)				\
-	((struct ebpf_insn) {					\
+	((struct rte_ebpf_insn) {					\
 		.code  = EBPF_ALU64 | BPF_OP(OP) | BPF_X,	\
 		.dst_reg = DST,					\
 		.src_reg = SRC,					\
@@ -90,7 +90,7 @@
 		.imm   = 0 })
 
 #define BPF_ALU32_REG(OP, DST, SRC)				\
-	((struct ebpf_insn) {					\
+	((struct rte_ebpf_insn) {					\
 		.code  = BPF_ALU | BPF_OP(OP) | BPF_X,		\
 		.dst_reg = DST,					\
 		.src_reg = SRC,					\
@@ -100,7 +100,7 @@
 /* ALU ops on immediates, bpf_add|sub|...: dst_reg += imm32 */
 
 #define BPF_ALU32_IMM(OP, DST, IMM)				\
-	((struct ebpf_insn) {					\
+	((struct rte_ebpf_insn) {					\
 		.code  = BPF_ALU | BPF_OP(OP) | BPF_K,		\
 		.dst_reg = DST,					\
 		.src_reg = 0,					\
@@ -110,7 +110,7 @@
 /* Short form of mov, dst_reg = src_reg */
 
 #define BPF_MOV64_REG(DST, SRC)					\
-	((struct ebpf_insn) {					\
+	((struct rte_ebpf_insn) {					\
 		.code  = EBPF_ALU64 | EBPF_MOV | BPF_X,		\
 		.dst_reg = DST,					\
 		.src_reg = SRC,					\
@@ -118,7 +118,7 @@
 		.imm   = 0 })
 
 #define BPF_MOV32_REG(DST, SRC)					\
-	((struct ebpf_insn) {					\
+	((struct rte_ebpf_insn) {					\
 		.code  = BPF_ALU | EBPF_MOV | BPF_X,		\
 		.dst_reg = DST,					\
 		.src_reg = SRC,					\
@@ -128,7 +128,7 @@
 /* Short form of mov, dst_reg = imm32 */
 
 #define BPF_MOV32_IMM(DST, IMM)					\
-	((struct ebpf_insn) {					\
+	((struct rte_ebpf_insn) {					\
 		.code  = BPF_ALU | EBPF_MOV | BPF_K,		\
 		.dst_reg = DST,					\
 		.src_reg = 0,					\
@@ -138,7 +138,7 @@
 /* Short form of mov based on type, BPF_X: dst_reg = src_reg, BPF_K: dst_reg = imm32 */
 
 #define BPF_MOV32_RAW(TYPE, DST, SRC, IMM)			\
-	((struct ebpf_insn) {					\
+	((struct rte_ebpf_insn) {					\
 		.code  = BPF_ALU | EBPF_MOV | BPF_SRC(TYPE),	\
 		.dst_reg = DST,					\
 		.src_reg = SRC,					\
@@ -148,7 +148,7 @@
 /* Direct packet access, R0 = *(uint *) (skb->data + imm32) */
 
 #define BPF_LD_ABS(SIZE, IMM)					\
-	((struct ebpf_insn) {					\
+	((struct rte_ebpf_insn) {					\
 		.code  = BPF_LD | BPF_SIZE(SIZE) | BPF_ABS,	\
 		.dst_reg = 0,					\
 		.src_reg = 0,					\
@@ -158,7 +158,7 @@
 /* Memory load, dst_reg = *(uint *) (src_reg + off16) */
 
 #define BPF_LDX_MEM(SIZE, DST, SRC, OFF)			\
-	((struct ebpf_insn) {					\
+	((struct rte_ebpf_insn) {					\
 		.code  = BPF_LDX | BPF_SIZE(SIZE) | BPF_MEM,	\
 		.dst_reg = DST,					\
 		.src_reg = SRC,					\
@@ -168,7 +168,7 @@
 /* Memory store, *(uint *) (dst_reg + off16) = src_reg */
 
 #define BPF_STX_MEM(SIZE, DST, SRC, OFF)			\
-	((struct ebpf_insn) {					\
+	((struct rte_ebpf_insn) {					\
 		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_MEM,	\
 		.dst_reg = DST,					\
 		.src_reg = SRC,					\
@@ -178,7 +178,7 @@
 /* Conditional jumps against immediates, if (dst_reg 'op' imm32) goto pc + off16 */
 
 #define BPF_JMP_IMM(OP, DST, IMM, OFF)				\
-	((struct ebpf_insn) {					\
+	((struct rte_ebpf_insn) {					\
 		.code  = BPF_JMP | BPF_OP(OP) | BPF_K,		\
 		.dst_reg = DST,					\
 		.src_reg = 0,					\
@@ -188,7 +188,7 @@
 /* Raw code statement block */
 
 #define BPF_RAW_INSN(CODE, DST, SRC, OFF, IMM)			\
-	((struct ebpf_insn) {					\
+	((struct rte_ebpf_insn) {					\
 		.code  = CODE,					\
 		.dst_reg = DST,					\
 		.src_reg = SRC,					\
@@ -198,7 +198,7 @@
 /* Program exit */
 
 #define BPF_EXIT_INSN()						\
-	((struct ebpf_insn) {					\
+	((struct rte_ebpf_insn) {					\
 		.code  = BPF_JMP | EBPF_EXIT,			\
 		.dst_reg = 0,					\
 		.src_reg = 0,					\
@@ -210,7 +210,7 @@
  * If and when DPDK BPF supports them.
  */
 static bool convert_bpf_load(const struct bpf_insn *fp,
-			     struct ebpf_insn **new_insnp __rte_unused)
+			     struct rte_ebpf_insn **new_insnp __rte_unused)
 {
 	switch (fp->k) {
 	case SKF_AD_OFF + SKF_AD_PROTOCOL:
@@ -240,11 +240,11 @@ static bool convert_bpf_load(const struct bpf_insn *fp,
 }
 
 static int bpf_convert_filter(const struct bpf_insn *prog, size_t len,
-			      struct ebpf_insn *new_prog, uint32_t *new_len)
+			      struct rte_ebpf_insn *new_prog, uint32_t *new_len)
 {
 	unsigned int pass = 0;
 	size_t new_flen = 0, target, i;
-	struct ebpf_insn *new_insn;
+	struct rte_ebpf_insn *new_insn;
 	const struct bpf_insn *fp;
 	int *addrs = NULL;
 	uint8_t bpf_src;
@@ -284,8 +284,8 @@ static int bpf_convert_filter(const struct bpf_insn *prog, size_t len,
 	}
 
 	for (i = 0; i < len; fp++, i++) {
-		struct ebpf_insn tmp_insns[6] = { };
-		struct ebpf_insn *insn = tmp_insns;
+		struct rte_ebpf_insn tmp_insns[6] = { };
+		struct rte_ebpf_insn *insn = tmp_insns;
 
 		if (addrs)
 			addrs[i] = new_insn - new_prog;
@@ -526,7 +526,7 @@ struct rte_bpf_prm *
 rte_bpf_convert(const struct bpf_program *prog)
 {
 	struct rte_bpf_prm *prm = NULL;
-	struct ebpf_insn *ebpf = NULL;
+	struct rte_ebpf_insn *ebpf = NULL;
 	uint32_t ebpf_len = 0;
 	int ret;
 
diff --git a/lib/bpf/bpf_def.h b/lib/bpf/bpf_def.h
index ead8d2f215bb..ee13c8c8b758 100644
--- a/lib/bpf/bpf_def.h
+++ b/lib/bpf/bpf_def.h
@@ -129,20 +129,5 @@ enum {
  */
 #define	EBPF_PSEUDO_CALL	EBPF_REG_1
 
-/*
- * eBPF instruction format
- */
-struct ebpf_insn {
-	uint8_t code;
-	uint8_t dst_reg:4;
-	uint8_t src_reg:4;
-	int16_t off;
-	int32_t imm;
-};
-
-/*
- * eBPF allows functions with R1-R5 as arguments.
- */
-#define	EBPF_FUNC_MAX_ARGS	(EBPF_REG_6 - EBPF_REG_1)
 
 #endif /* RTE_BPF_DEF_H_ */
diff --git a/lib/bpf/bpf_dump.c b/lib/bpf/bpf_dump.c
index 4fd67ad5a1df..e2573919079e 100644
--- a/lib/bpf/bpf_dump.c
+++ b/lib/bpf/bpf_dump.c
@@ -9,6 +9,7 @@
 
 #include <eal_export.h>
 #include "rte_bpf.h"
+#include "bpf_def.h"
 
 #define BPF_OP_INDEX(x) (BPF_OP(x) >> 4)
 #define BPF_SIZE_INDEX(x) (BPF_SIZE(x) >> 3)
@@ -48,7 +49,7 @@ static const char *const jump_tbl[16] = {
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_insn_is_wide, 26.07)
 bool
-rte_bpf_insn_is_wide(const struct ebpf_insn *ins)
+rte_bpf_insn_is_wide(const struct rte_ebpf_insn *ins)
 {
 	return ins->code == (BPF_LD | BPF_IMM | EBPF_DW);
 }
@@ -56,7 +57,7 @@ rte_bpf_insn_is_wide(const struct ebpf_insn *ins)
 
 /* Format one (possibly wide) eBPF command as hexadecimal in objdump format. */
 static int
-format_hexadecimal(char *buffer, size_t bufsz, const struct ebpf_insn *ins,
+format_hexadecimal(char *buffer, size_t bufsz, const struct rte_ebpf_insn *ins,
 	uint32_t flags)
 {
 	const char *const b = (const char *)ins;
@@ -93,7 +94,7 @@ atomic_op(int32_t imm)
 
 /* Format one (possibly wide) eBPF command as assembler. */
 static int
-format_disassembly(char *buffer, size_t bufsz, const struct ebpf_insn *ins,
+format_disassembly(char *buffer, size_t bufsz, const struct rte_ebpf_insn *ins,
 	uint32_t pc, uint32_t flags)
 {
 	uint8_t cls = BPF_CLASS(ins->code);
@@ -221,7 +222,7 @@ format_disassembly(char *buffer, size_t bufsz, const struct ebpf_insn *ins,
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_format, 26.07)
 int
-rte_bpf_format(char *buffer, size_t bufsz, const struct ebpf_insn *ins,
+rte_bpf_format(char *buffer, size_t bufsz, const struct rte_ebpf_insn *ins,
 	uint32_t pc, uint32_t flags)
 {
 	if ((flags & RTE_BPF_FORMAT_FLAG_HEXADECIMAL) != 0)
@@ -231,13 +232,13 @@ rte_bpf_format(char *buffer, size_t bufsz, const struct ebpf_insn *ins,
 }
 
 RTE_EXPORT_SYMBOL(rte_bpf_dump)
-void rte_bpf_dump(FILE *f, const struct ebpf_insn *buf, uint32_t len)
+void rte_bpf_dump(FILE *f, const struct rte_ebpf_insn *buf, uint32_t len)
 {
 	uint32_t i;
 	char buffer[256];
 
 	for (i = 0; i < len; ++i) {
-		const struct ebpf_insn *ins = buf + i;
+		const struct rte_ebpf_insn *ins = buf + i;
 
 		format_disassembly(buffer, sizeof(buffer), ins, i,
 			RTE_BPF_FORMAT_FLAG_DISASSEMBLY	|
diff --git a/lib/bpf/bpf_exec.c b/lib/bpf/bpf_exec.c
index d423ef28f559..2e966aaaeadf 100644
--- a/lib/bpf/bpf_exec.c
+++ b/lib/bpf/bpf_exec.c
@@ -108,7 +108,7 @@
 
 
 static inline void
-bpf_alu_be(uint64_t reg[EBPF_REG_NUM], const struct ebpf_insn *ins)
+bpf_alu_be(uint64_t reg[EBPF_REG_NUM], const struct rte_ebpf_insn *ins)
 {
 	uint64_t *v;
 
@@ -127,7 +127,7 @@ bpf_alu_be(uint64_t reg[EBPF_REG_NUM], const struct ebpf_insn *ins)
 }
 
 static inline void
-bpf_alu_le(uint64_t reg[EBPF_REG_NUM], const struct ebpf_insn *ins)
+bpf_alu_le(uint64_t reg[EBPF_REG_NUM], const struct rte_ebpf_insn *ins)
 {
 	uint64_t *v;
 
@@ -147,7 +147,7 @@ bpf_alu_le(uint64_t reg[EBPF_REG_NUM], const struct ebpf_insn *ins)
 
 static inline const void *
 bpf_ld_mbuf(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM],
-	const struct ebpf_insn *ins, uint32_t off, uint32_t len)
+	const struct rte_ebpf_insn *ins, uint32_t off, uint32_t len)
 {
 	const struct rte_mbuf *mb;
 	const void *p;
@@ -165,7 +165,7 @@ bpf_ld_mbuf(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM],
 static inline uint64_t
 bpf_exec(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM])
 {
-	const struct ebpf_insn *ins;
+	const struct rte_ebpf_insn *ins;
 
 	for (ins = bpf->prm.raw.ins; ; ins++) {
 		switch (ins->code) {
diff --git a/lib/bpf/bpf_impl.h b/lib/bpf/bpf_impl.h
index 14ad772d4beb..76da4d59f50a 100644
--- a/lib/bpf/bpf_impl.h
+++ b/lib/bpf/bpf_impl.h
@@ -7,6 +7,7 @@
 
 #include <rte_bpf.h>
 #include <sys/mman.h>
+#include "bpf_def.h"
 
 #define MAX_BPF_STACK_SIZE	0x200
 
@@ -22,7 +23,7 @@ struct __rte_bpf_load {
 	struct rte_bpf_prm_ex prm;
 
 	/* Conversion from cBPF. */
-	struct ebpf_insn *ins;
+	struct rte_ebpf_insn *ins;
 
 	/* Loading ELF and applying relocations. */
 	int elf_fd;  /* ELF fd, must be negative (not zero) by default. */
diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
index ba7ae4d680c5..7f3ea1b75956 100644
--- a/lib/bpf/bpf_jit_arm64.c
+++ b/lib/bpf/bpf_jit_arm64.c
@@ -1126,7 +1126,7 @@ emit_branch(struct a64_jit_ctx *ctx, uint8_t op, uint32_t i, int16_t off)
 static void
 check_program_has_call(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
 {
-	const struct ebpf_insn *ins;
+	const struct rte_ebpf_insn *ins;
 	uint8_t op;
 	uint32_t i;
 
@@ -1150,7 +1150,7 @@ static int
 emit(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
 {
 	uint8_t op, dst, src, tmp1, tmp2, tmp3;
-	const struct ebpf_insn *ins;
+	const struct rte_ebpf_insn *ins;
 	uint64_t u64;
 	int16_t off;
 	int32_t imm;
diff --git a/lib/bpf/bpf_jit_x86.c b/lib/bpf/bpf_jit_x86.c
index 54eb279643b9..37da3bc6a53e 100644
--- a/lib/bpf/bpf_jit_x86.c
+++ b/lib/bpf/bpf_jit_x86.c
@@ -1315,7 +1315,7 @@ static int
 emit(struct bpf_jit_state *st, const struct rte_bpf *bpf)
 {
 	uint32_t i, dr, op, sr;
-	const struct ebpf_insn *ins;
+	const struct rte_ebpf_insn *ins;
 
 	/* reset state fields */
 	st->sz = 0;
diff --git a/lib/bpf/bpf_load.c b/lib/bpf/bpf_load.c
index 36f6556fd5fe..cb088d333ba0 100644
--- a/lib/bpf/bpf_load.c
+++ b/lib/bpf/bpf_load.c
@@ -61,7 +61,7 @@ bpf_check_xsym(const struct rte_bpf_xsym *xsym)
 			return -EINVAL;
 	} else if (xsym->type == RTE_BPF_XTYPE_FUNC) {
 
-		if (xsym->func.nb_args > EBPF_FUNC_MAX_ARGS)
+		if (xsym->func.nb_args > RTE_EBPF_FUNC_MAX_ARGS)
 			return -EINVAL;
 
 		/* check function arguments */
diff --git a/lib/bpf/bpf_load_elf.c b/lib/bpf/bpf_load_elf.c
index cb3392363108..329ae25cb173 100644
--- a/lib/bpf/bpf_load_elf.c
+++ b/lib/bpf/bpf_load_elf.c
@@ -58,7 +58,7 @@ bpf_find_xsym(const char *sn, enum rte_bpf_xtype type,
  * symbol *sn*
  */
 static int
-resolve_xsym(const char *sn, size_t ofs, struct ebpf_insn *ins, size_t ins_sz,
+resolve_xsym(const char *sn, size_t ofs, struct rte_ebpf_insn *ins, size_t ins_sz,
 	const struct rte_bpf_prm_ex *prm)
 {
 	uint32_t idx, fidx;
@@ -169,7 +169,7 @@ find_elf_code(Elf *elf, const char *section, Elf_Data **psd, size_t *pidx)
 
 	sd = elf_getdata(sc, NULL);
 	if (sd == NULL || sd->d_size == 0 ||
-			sd->d_size % sizeof(struct ebpf_insn) != 0) {
+			sd->d_size % sizeof(struct rte_ebpf_insn) != 0) {
 		rc = elf_errno();
 		RTE_BPF_LOG_LINE(ERR, "%s(%p, %s) error code: %d(%s)",
 			__func__, elf, section, rc, elf_errmsg(rc));
@@ -186,7 +186,7 @@ find_elf_code(Elf *elf, const char *section, Elf_Data **psd, size_t *pidx)
  */
 static int
 process_reloc(Elf *elf, size_t sym_idx, Elf64_Rel *re, size_t re_sz,
-	struct ebpf_insn *ins, size_t ins_sz, const struct rte_bpf_prm_ex *prm)
+	struct rte_ebpf_insn *ins, size_t ins_sz, const struct rte_bpf_prm_ex *prm)
 {
 	int32_t rc;
 	uint32_t i, n;
@@ -235,7 +235,7 @@ process_reloc(Elf *elf, size_t sym_idx, Elf64_Rel *re, size_t re_sz,
  * and update bpf code.
  */
 static int
-elf_reloc_code(Elf *elf, struct ebpf_insn *ins, size_t ins_sz, size_t sidx,
+elf_reloc_code(Elf *elf, struct rte_ebpf_insn *ins, size_t ins_sz, size_t sidx,
 	const struct rte_bpf_prm_ex *prm)
 {
 	Elf64_Rel *re;
@@ -355,7 +355,7 @@ __rte_bpf_load_elf_code(struct __rte_bpf_load *load)
 
 	prm->origin = RTE_BPF_ORIGIN_RAW;
 	prm->raw.ins = sd->d_buf;
-	prm->raw.nb_ins = sd->d_size / sizeof(struct ebpf_insn);
+	prm->raw.nb_ins = sd->d_size / sizeof(struct rte_ebpf_insn);
 
 	rc = elf_reloc_code(load->elf, sd->d_buf, sd->d_size, sidx, prm);
 	if (rc < 0)
diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index f9960088a285..31226c8f1f53 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -117,8 +117,8 @@ struct bpf_ins_check {
 		uint32_t min;
 		uint32_t max;
 	} imm;
-	const char * (*check)(const struct ebpf_insn *);
-	const char * (*eval)(struct bpf_verifier *, const struct ebpf_insn *);
+	const char * (*check)(const struct rte_ebpf_insn *ins);
+	const char * (*eval)(struct bpf_verifier *bpf, const struct rte_ebpf_insn *ins);
 };
 
 #define	ALL_REGS	RTE_LEN2MASK(EBPF_REG_NUM, uint16_t)
@@ -171,7 +171,7 @@ __rte_bpf_validate_state_is_valid(const struct bpf_verifier *verifier)
 
 int
 __rte_bpf_validate_can_access(const struct bpf_verifier *verifier,
-	const struct ebpf_insn *access, uint64_t off64)
+	const struct rte_ebpf_insn *access, uint64_t off64)
 {
 	const struct bpf_eval_state *const st = verifier->evst;
 	const struct bpf_reg_val *rv;
@@ -308,7 +308,7 @@ may_jump_code_complement(uint8_t code)
 
 int
 __rte_bpf_validate_may_jump(const struct bpf_verifier *verifier,
-	const struct ebpf_insn *jump, uint64_t imm64)
+	const struct rte_ebpf_insn *jump, uint64_t imm64)
 {
 	const struct bpf_eval_state *const st = verifier->evst;
 	const struct bpf_reg_val *rd, *rs;
@@ -543,7 +543,7 @@ __rte_bpf_validate_get_frame_size(const struct bpf_verifier *verifier)
  */
 
 static const char *
-check_alu_bele(const struct ebpf_insn *ins)
+check_alu_bele(const struct rte_ebpf_insn *ins)
 {
 	if (ins->imm != 16 && ins->imm != 32 && ins->imm != 64)
 		return "invalid imm field";
@@ -551,7 +551,7 @@ check_alu_bele(const struct ebpf_insn *ins)
 }
 
 static const char *
-eval_exit(struct bpf_verifier *bvf, const struct ebpf_insn *ins)
+eval_exit(struct bpf_verifier *bvf, const struct rte_ebpf_insn *ins)
 {
 	RTE_SET_USED(ins);
 	if (bvf->evst->rv[EBPF_REG_0].v.type == RTE_BPF_ARG_UNDEF)
@@ -611,7 +611,7 @@ eval_fill_imm(struct bpf_reg_val *rv, uint64_t mask, int32_t imm)
 }
 
 static const char *
-eval_ld_imm64(struct bpf_verifier *bvf, const struct ebpf_insn *ins)
+eval_ld_imm64(struct bpf_verifier *bvf, const struct rte_ebpf_insn *ins)
 {
 	uint32_t i;
 	uint64_t val;
@@ -1051,7 +1051,7 @@ eval_neg(struct bpf_reg_val *rd, size_t opsz, uint64_t msk)
 }
 
 static const char *
-eval_ld_mbuf(struct bpf_verifier *bvf, const struct ebpf_insn *ins)
+eval_ld_mbuf(struct bpf_verifier *bvf, const struct rte_ebpf_insn *ins)
 {
 	uint32_t i, mode;
 	struct bpf_reg_val *rv, ri, rs;
@@ -1100,7 +1100,7 @@ eval_defined(const struct bpf_reg_val *dst, const struct bpf_reg_val *src)
 }
 
 static const char *
-eval_alu(struct bpf_verifier *bvf, const struct ebpf_insn *ins)
+eval_alu(struct bpf_verifier *bvf, const struct rte_ebpf_insn *ins)
 {
 	uint64_t msk;
 	uint32_t op;
@@ -1172,7 +1172,7 @@ eval_alu(struct bpf_verifier *bvf, const struct ebpf_insn *ins)
 }
 
 static const char *
-eval_bele(struct bpf_verifier *bvf, const struct ebpf_insn *ins)
+eval_bele(struct bpf_verifier *bvf, const struct rte_ebpf_insn *ins)
 {
 	uint64_t msk;
 	struct bpf_eval_state *st;
@@ -1263,7 +1263,7 @@ eval_max_load(struct bpf_reg_val *rv, uint64_t mask)
 
 
 static const char *
-eval_load(struct bpf_verifier *bvf, const struct ebpf_insn *ins)
+eval_load(struct bpf_verifier *bvf, const struct rte_ebpf_insn *ins)
 {
 	uint32_t opsz;
 	uint64_t msk;
@@ -1349,7 +1349,7 @@ eval_mbuf_store(const struct bpf_reg_val *rv, uint32_t opsz)
 }
 
 static const char *
-eval_store(struct bpf_verifier *bvf, const struct ebpf_insn *ins)
+eval_store(struct bpf_verifier *bvf, const struct rte_ebpf_insn *ins)
 {
 	uint32_t opsz;
 	uint64_t msk;
@@ -1407,7 +1407,7 @@ eval_store(struct bpf_verifier *bvf, const struct ebpf_insn *ins)
 }
 
 static const char *
-eval_ja(struct bpf_verifier *bvf, const struct ebpf_insn *ins)
+eval_ja(struct bpf_verifier *bvf, const struct rte_ebpf_insn *ins)
 {
 	RTE_SET_USED(bvf);
 	RTE_SET_USED(ins);
@@ -1459,7 +1459,7 @@ eval_func_arg(struct bpf_verifier *bvf, const struct rte_bpf_arg *arg,
 }
 
 static const char *
-eval_call(struct bpf_verifier *bvf, const struct ebpf_insn *ins)
+eval_call(struct bpf_verifier *bvf, const struct rte_ebpf_insn *ins)
 {
 	uint32_t i, idx;
 	struct bpf_reg_val *rv;
@@ -1599,7 +1599,7 @@ eval_jslt_jsge(struct bpf_reg_val *trd, struct bpf_reg_val *trs,
 }
 
 static const char *
-eval_jcc(struct bpf_verifier *bvf, const struct ebpf_insn *ins)
+eval_jcc(struct bpf_verifier *bvf, const struct rte_ebpf_insn *ins)
 {
 	uint32_t op;
 	const char *err;
@@ -2266,7 +2266,7 @@ static const struct bpf_ins_check ins_chk[UINT8_MAX + 1] = {
  * and its fields don't violate particular instruction type restrictions.
  */
 static const char *
-check_syntax(const struct ebpf_insn *ins)
+check_syntax(const struct rte_ebpf_insn *ins)
 {
 
 	uint8_t op;
@@ -2453,7 +2453,7 @@ log_unreachable(const struct bpf_verifier *bvf)
 {
 	uint32_t i;
 	struct inst_node *node;
-	const struct ebpf_insn *ins;
+	const struct rte_ebpf_insn *ins;
 
 	for (i = 0; i != bvf->prm->raw.nb_ins; i++) {
 
@@ -2503,7 +2503,7 @@ validate(struct bpf_verifier *bvf)
 	int32_t rc;
 	uint32_t i;
 	struct inst_node *node;
-	const struct ebpf_insn *ins;
+	const struct rte_ebpf_insn *ins;
 	const char *err;
 
 	rc = 0;
@@ -2779,7 +2779,7 @@ restore_cur_eval_state(struct bpf_verifier *bvf, struct inst_node *node)
 }
 
 static void
-log_dbg_eval_state(const struct bpf_verifier *bvf, const struct ebpf_insn *ins,
+log_dbg_eval_state(const struct bpf_verifier *bvf, const struct rte_ebpf_insn *ins,
 	uint32_t pc)
 {
 	const struct bpf_eval_state *st;
@@ -2916,7 +2916,7 @@ evaluate(struct bpf_verifier *bvf)
 {
 	uint32_t idx, op;
 	const char *err;
-	const struct ebpf_insn *ins;
+	const struct rte_ebpf_insn *ins;
 	struct inst_node *next, *node;
 	int prev_nb_edge;  /* branching number of the previous instruction */
 	int rc, debug_rc;
@@ -3116,10 +3116,10 @@ __rte_bpf_validate(const struct rte_bpf_prm_ex *prm, uint32_t *stack_sz)
 	int32_t rc;
 	struct bpf_verifier bvf;
 
-	if (prm->nb_prog_arg > EBPF_FUNC_MAX_ARGS) {
+	if (prm->nb_prog_arg > RTE_EBPF_FUNC_MAX_ARGS) {
 		RTE_BPF_LOG_FUNC_LINE(ERR,
 			"support up to %u arguments, found %u",
-			EBPF_FUNC_MAX_ARGS, prm->nb_prog_arg);
+			RTE_EBPF_FUNC_MAX_ARGS, prm->nb_prog_arg);
 		return -ENOTSUP;
 	}
 
diff --git a/lib/bpf/bpf_validate.h b/lib/bpf/bpf_validate.h
index 9912f4fd5c4f..a8c3c24c1144 100644
--- a/lib/bpf/bpf_validate.h
+++ b/lib/bpf/bpf_validate.h
@@ -32,12 +32,12 @@ __rte_bpf_validate_state_is_valid(const struct bpf_verifier *verifier);
  */
 int
 __rte_bpf_validate_can_access(const struct bpf_verifier *verifier,
-	const struct ebpf_insn *access, uint64_t off64);
+	const struct rte_ebpf_insn *access, uint64_t off64);
 
 /* Get possible truth values of the specified jump condition. */
 int
 __rte_bpf_validate_may_jump(const struct bpf_verifier *verifier,
-	const struct ebpf_insn *jump, uint64_t imm64);
+	const struct rte_ebpf_insn *jump, uint64_t imm64);
 
 /* Format known information about the register for the user. */
 int
diff --git a/lib/bpf/bpf_validate_debug.c b/lib/bpf/bpf_validate_debug.c
index 5d18804a74bc..a34b2d2ec42a 100644
--- a/lib/bpf/bpf_validate_debug.c
+++ b/lib/bpf/bpf_validate_debug.c
@@ -319,7 +319,7 @@ rte_bpf_validate_debug_get_bpf_param(const struct rte_bpf_validate_debug *debug)
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_validate_debug_get_ins, 26.07)
 int
 rte_bpf_validate_debug_get_ins(const struct rte_bpf_validate_debug *debug,
-	const struct ebpf_insn **ins, uint32_t *nb_ins)
+	const struct rte_ebpf_insn **ins, uint32_t *nb_ins)
 {
 	if (debug == NULL)
 		return -EINVAL;
@@ -378,7 +378,7 @@ rte_bpf_validate_debug_get_validation_result(const struct rte_bpf_validate_debug
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_validate_debug_can_access, 26.07)
 int
 rte_bpf_validate_debug_can_access(const struct rte_bpf_validate_debug *debug,
-	const struct ebpf_insn *access, uint64_t off64)
+	const struct rte_ebpf_insn *access, uint64_t off64)
 {
 	if (debug == NULL || access == NULL)
 		return -EINVAL;
@@ -392,7 +392,7 @@ rte_bpf_validate_debug_can_access(const struct rte_bpf_validate_debug *debug,
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_validate_debug_may_jump, 26.07)
 int
 rte_bpf_validate_debug_may_jump(const struct rte_bpf_validate_debug *debug,
-	const struct ebpf_insn *jump, uint64_t imm64)
+	const struct rte_ebpf_insn *jump, uint64_t imm64)
 {
 	if (debug == NULL || jump == NULL)
 		return -EINVAL;
diff --git a/lib/bpf/meson.build b/lib/bpf/meson.build
index b74a5c232107..80a39a2c55d7 100644
--- a/lib/bpf/meson.build
+++ b/lib/bpf/meson.build
@@ -35,8 +35,8 @@ elif dpdk_conf.has('RTE_ARCH_ARM64')
 endif
 
 headers = files(
-        'bpf_def.h',
         'rte_bpf.h',
+
         'rte_bpf_ethdev.h',
         'rte_bpf_validate_debug.h',
 )
diff --git a/lib/bpf/rte_bpf.h b/lib/bpf/rte_bpf.h
index 052849945c45..2a1f52bd5c9b 100644
--- a/lib/bpf/rte_bpf.h
+++ b/lib/bpf/rte_bpf.h
@@ -19,12 +19,27 @@
 #include <rte_common.h>
 #include <rte_mbuf.h>
 #include <rte_malloc.h>
-#include <bpf_def.h>
 
 #ifdef __cplusplus
 extern "C" {
 #endif
 
+/*
+ * eBPF instruction format
+ */
+struct rte_ebpf_insn {
+	uint8_t code;
+	uint8_t dst_reg:4;
+	uint8_t src_reg:4;
+	int16_t off;
+	int32_t imm;
+};
+
+/*
+ * eBPF allows functions with up to 5 arguments.
+ */
+#define	RTE_EBPF_FUNC_MAX_ARGS	5
+
 #define RTE_BPF_EXEC_FLAG_JIT	RTE_BIT64(0)	/**< use JIT-compiled version */
 
 /** Mask with all supported `RTE_BPF_EXEC_FLAG_*` flags set. */
@@ -96,7 +111,7 @@ struct rte_bpf_xsym {
 			uint64_t (*val)(uint64_t, uint64_t, uint64_t,
 				uint64_t, uint64_t);
 			uint32_t nb_args;
-			struct rte_bpf_arg args[EBPF_FUNC_MAX_ARGS];
+			struct rte_bpf_arg args[RTE_EBPF_FUNC_MAX_ARGS];
 			/**< Function arguments descriptions. */
 			struct rte_bpf_arg ret; /**< function return value. */
 		} func;
@@ -135,7 +150,7 @@ struct rte_bpf_prm_ex {
 	/** program origin parameters, member in use depends on origin */
 	union {
 		struct {
-			const struct ebpf_insn *ins;  /**< eBPF instructions */
+			const struct rte_ebpf_insn *ins;  /**< eBPF instructions */
 			uint32_t nb_ins;  /**< number of instructions in ins */
 		} raw;
 		struct {
@@ -157,7 +172,7 @@ struct rte_bpf_prm_ex {
 	/**< array of external symbols that eBPF code is allowed to reference */
 	uint32_t nb_xsym;  /**< number of elements in xsym */
 
-	struct rte_bpf_arg prog_arg[EBPF_FUNC_MAX_ARGS];  /**< program arguments */
+	struct rte_bpf_arg prog_arg[RTE_EBPF_FUNC_MAX_ARGS];  /**< program arguments */
 	uint32_t nb_prog_arg;  /**< program argument count */
 
 	/* Validate debug instance. */
@@ -168,7 +183,7 @@ struct rte_bpf_prm_ex {
  * Input parameters for loading eBPF code, legacy version.
  */
 struct rte_bpf_prm {
-	const struct ebpf_insn *ins; /**< array of eBPF instructions */
+	const struct rte_ebpf_insn *ins; /**< array of eBPF instructions */
 	uint32_t nb_ins;            /**< number of instructions in ins */
 	const struct rte_bpf_xsym *xsym;
 	/**< array of external symbols that eBPF code is allowed to reference */
@@ -217,7 +232,7 @@ struct rte_bpf_jit_ex {
 
 /* Tuple of eBPF program arguments. */
 struct rte_bpf_prog_ctx {
-	union rte_bpf_func_arg arg[EBPF_FUNC_MAX_ARGS];
+	union rte_bpf_func_arg arg[RTE_EBPF_FUNC_MAX_ARGS];
 };
 
 struct rte_bpf;
@@ -420,7 +435,7 @@ rte_bpf_get_jit_ex(const struct rte_bpf *bpf, struct rte_bpf_jit_ex *jit);
  */
 __rte_experimental
 bool
-rte_bpf_insn_is_wide(const struct ebpf_insn *ins);
+rte_bpf_insn_is_wide(const struct rte_ebpf_insn *ins);
 
 /**
  * Print eBPF instruction into a buffer.
@@ -443,7 +458,7 @@ rte_bpf_insn_is_wide(const struct ebpf_insn *ins);
  */
 __rte_experimental
 int
-rte_bpf_format(char *buffer, size_t bufsz, const struct ebpf_insn *ins,
+rte_bpf_format(char *buffer, size_t bufsz, const struct rte_ebpf_insn *ins,
 	uint32_t pc, uint32_t flags);
 
 /**
@@ -457,7 +472,7 @@ rte_bpf_format(char *buffer, size_t bufsz, const struct ebpf_insn *ins,
  *   Number of BPF instructions to dump.
  */
 void
-rte_bpf_dump(FILE *f, const struct ebpf_insn *buf, uint32_t len);
+rte_bpf_dump(FILE *f, const struct rte_ebpf_insn *buf, uint32_t len);
 
 struct bpf_program;
 
diff --git a/lib/bpf/rte_bpf_validate_debug.h b/lib/bpf/rte_bpf_validate_debug.h
index f30fa926f10a..d91a84745f40 100644
--- a/lib/bpf/rte_bpf_validate_debug.h
+++ b/lib/bpf/rte_bpf_validate_debug.h
@@ -13,7 +13,7 @@
  * Can be used for debugging BPF validation problems as well as in tests.
  */
 
-#include <bpf_def.h>
+#include <rte_bpf.h>
 #include <rte_compat.h>
 
 #include <stdbool.h>
@@ -181,7 +181,7 @@ rte_bpf_validate_debug_get_bpf_param(const struct rte_bpf_validate_debug *debug)
 __rte_experimental
 int
 rte_bpf_validate_debug_get_ins(const struct rte_bpf_validate_debug *debug,
-	const struct ebpf_insn **ins, uint32_t *nb_ins);
+	const struct rte_ebpf_insn **ins, uint32_t *nb_ins);
 
 /**
  * Get last triggered breakpoint or catchpoint.
@@ -249,7 +249,7 @@ rte_bpf_validate_debug_get_validation_result(const struct rte_bpf_validate_debug
 __rte_experimental
 int
 rte_bpf_validate_debug_can_access(const struct rte_bpf_validate_debug *debug,
-	const struct ebpf_insn *access, uint64_t off64);
+	const struct rte_ebpf_insn *access, uint64_t off64);
 
 /**
  * Get possible truth values of the specified jump condition.
@@ -269,7 +269,7 @@ rte_bpf_validate_debug_can_access(const struct rte_bpf_validate_debug *debug,
 __rte_experimental
 int
 rte_bpf_validate_debug_may_jump(const struct rte_bpf_validate_debug *debug,
-	const struct ebpf_insn *jump, uint64_t imm64);
+	const struct rte_ebpf_insn *jump, uint64_t imm64);
 
 /**
  * Format information about specified register for the user.
-- 
2.43.0

