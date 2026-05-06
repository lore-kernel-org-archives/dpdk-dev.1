Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B57FCD3439
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 17:40:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F28E340E1C;
	Wed,  6 May 2026 19:39:35 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 867DC406B8;
 Wed,  6 May 2026 19:39:21 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g9jKC1t7LzHnGgq;
 Thu,  7 May 2026 01:38:23 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 5D8B040584;
 Thu,  7 May 2026 01:39:21 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 19:39:21 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH 16/25] bpf/validate: fix BPF_JMP source range calculation
Date: Wed, 6 May 2026 18:38:34 +0100
Message-ID: <20260506173846.64914-17-marat.khalili@huawei.com>
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

All two-register ordering comparison functions (`eval_jgt_jle`,
`eval_jlt_jge`, `eval_jsgt_jsle`, `eval_jslt_jsge`) were updating only
the destination register value set but not the source register one. For
instance, instruction `jgt r2, r3` should be exactly equivalent to `jlt
r3, r2`, but previously the former only updated the possible values of
r2 while the latter only updated possible values of r3. Thus the
estimate for source register was conservative and could cause false
positives.

E.g. consider the following program with the current validation code:

    Tested program:
        0:  mov r0, #0x0
        1:  mov r2, #0x28
        2:  ldxdw r3, [r1 + 0]
        3:  jlt r3, #0x14, L11
        4:  jgt r3, #0x3c, L11
        5:  jslt r3, #0x14, L11
        6:  jsgt r3, #0x3c, L11
        7:  jgt r2, r3, L10  ; tested instruction
        8:  mov r0, #0x1
        9:  exit
       10:  mov r0, #0x2
       11:  exit
    Pre-state:
       r2:  40
       r3:  20..60
    ...
    Jump-state:
       r2:  40
       r3:  20..60

If tested instruction jumped from step 7 to step 10 validator expects r3
to contain values up to 60, for example 55, however for this value jump
condition r2 > r3 will never be satisfied since r2 is known to equal 40,
and thus execution would always continue to step 8 instead of jumping.

Add missing source register values update.

Introduce test harness for verifying all equivalent variations of a
comparison instruction. Add tests for all cases where both code branches
are reachable (unreachable branches will be covered by subsequent
commits).

Fixes: 8021917293d0 ("bpf: add extra validation for input BPF program")
Cc: stable@dpdk.org

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_bpf_validate.c | 394 +++++++++++++++++++++++++++++++----
 lib/bpf/bpf_validate.c       |   8 +
 2 files changed, 358 insertions(+), 44 deletions(-)

diff --git a/app/test/test_bpf_validate.c b/app/test/test_bpf_validate.c
index 359e50aaaf8f..1c40ebddf07a 100644
--- a/app/test/test_bpf_validate.c
+++ b/app/test/test_bpf_validate.c
@@ -32,6 +32,31 @@ RTE_LOG_REGISTER(test_bpf_validate_logtype, test.bpf_validate, NOTICE);
 #define REGISTER_FORMAT_BUFFER_SIZE 256
 #define DISASSEMBLY_FORMAT_BUFFER_SIZE 64
 
+#define COMPARISON_INDEX_IMMEDIATE RTE_BIT32(0)
+#define COMPARISON_INDEX_GREATER   RTE_BIT32(1)
+#define COMPARISON_INDEX_INCLUSIVE RTE_BIT32(2)
+#define COMPARISON_INDEX_SIGNED    RTE_BIT32(3)
+
+/* List comparison opcodes to make their index bits match constants above.  */
+static const uint8_t comparisons_opcode[] = {
+	(BPF_JMP | EBPF_JLT  | BPF_X),
+	(BPF_JMP | EBPF_JLT  | BPF_K),
+	(BPF_JMP |  BPF_JGT  | BPF_X),
+	(BPF_JMP |  BPF_JGT  | BPF_K),
+	(BPF_JMP | EBPF_JLE  | BPF_X),
+	(BPF_JMP | EBPF_JLE  | BPF_K),
+	(BPF_JMP |  BPF_JGE  | BPF_X),
+	(BPF_JMP |  BPF_JGE  | BPF_K),
+	(BPF_JMP | EBPF_JSLT | BPF_X),
+	(BPF_JMP | EBPF_JSLT | BPF_K),
+	(BPF_JMP | EBPF_JSGT | BPF_X),
+	(BPF_JMP | EBPF_JSGT | BPF_K),
+	(BPF_JMP | EBPF_JSLE | BPF_X),
+	(BPF_JMP | EBPF_JSLE | BPF_K),
+	(BPF_JMP | EBPF_JSGE | BPF_X),
+	(BPF_JMP | EBPF_JSGE | BPF_K),
+};
+
 /* Interval bounded by two signed values, inclusive; min <= max. */
 struct signed_interval {
 	int64_t min;
@@ -1044,6 +1069,206 @@ verify_instruction(struct verify_instruction_param prm)
 	return rc;
 }
 
+static int
+opcode_comparison_index(uint8_t opcode)
+{
+	for (int index = 0; index != RTE_DIM(comparisons_opcode); ++index)
+		if (comparisons_opcode[index] == opcode)
+			return index;
+	TEST_LOG_LINE(ERR, "Unsupported or not a comparison opcode: %hhx", opcode);
+	RTE_VERIFY(false);
+}
+
+/* Change two-register comparison verification to immediate one. */
+static bool
+make_comparison_immediate(struct verify_instruction_param *prm)
+{
+	int comparison_index = opcode_comparison_index(prm->tested_instruction.code);
+	const int64_t value = prm->pre.src.s.min;
+
+	if ((comparison_index & COMPARISON_INDEX_IMMEDIATE) != 0) {
+		TEST_LOG_LINE(ERR, "Comparison %hhx is already immediate.",
+			prm->tested_instruction.code);
+		RTE_VERIFY(false);
+	}
+
+	if (!domain_is_singleton(&prm->pre.src) || !domain_is_singleton(&prm->post.src) ||
+			!domain_is_singleton(&prm->jump.src)) {
+		TEST_LOG_LINE(DEBUG, "Cannot make immediate out of a non-singleton domain.");
+		return false;
+	}
+	if (prm->pre.src.is_pointer || prm->post.src.is_pointer || prm->jump.src.is_pointer) {
+		TEST_LOG_LINE(DEBUG, "Cannot make immediate out of a pointer.");
+		return false;
+	}
+	if (prm->post.src.s.min != value || prm->jump.src.s.min != value) {
+		TEST_LOG_LINE(DEBUG, "Cannot make immediate if the value changes.");
+		return false;
+	}
+	if (!fits_in_imm32(value)) {
+		TEST_LOG_LINE(ERR, "Cannot make immediate unless value fits in int32.");
+		return false;
+	}
+
+	comparison_index |= COMPARISON_INDEX_IMMEDIATE;
+	prm->tested_instruction.code = comparisons_opcode[comparison_index];
+	prm->tested_instruction.imm = value;
+
+	RTE_VERIFY(prm->pre.src.is_defined);
+	prm->pre.src.is_defined = false;
+
+	if (!prm->post.is_unreachable) {
+		RTE_VERIFY(prm->post.src.is_defined);
+		prm->post.src.is_defined = false;
+	}
+
+	if (!prm->jump.is_unreachable) {
+		RTE_VERIFY(prm->jump.src.is_defined);
+		prm->jump.src.is_defined = false;
+	}
+
+	return true;
+}
+
+/* Change immediate comparison verification to two-register one. */
+static void
+make_comparison_two_register(struct verify_instruction_param *prm)
+{
+	int comparison_index = opcode_comparison_index(prm->tested_instruction.code);
+	const int64_t value = prm->tested_instruction.imm;
+
+	if ((comparison_index & COMPARISON_INDEX_IMMEDIATE) == 0) {
+		TEST_LOG_LINE(ERR, "Comparison %hhx is already two-register.",
+			prm->tested_instruction.code);
+		RTE_VERIFY(false);
+	}
+
+	comparison_index &= ~COMPARISON_INDEX_IMMEDIATE;
+	prm->tested_instruction.code = comparisons_opcode[comparison_index];
+	prm->tested_instruction.imm = 0;
+
+	RTE_VERIFY(!prm->pre.src.is_defined);
+	prm->pre.src = make_singleton_domain(value);
+
+	if (!prm->post.is_unreachable) {
+		RTE_VERIFY(!prm->post.src.is_defined);
+		prm->post.src = prm->pre.src;
+	}
+
+	if (!prm->jump.is_unreachable) {
+		RTE_VERIFY(!prm->jump.src.is_defined);
+		prm->jump.src = prm->pre.src;
+	}
+}
+
+/* Change comparison verification to complement (negated result) one. */
+static void
+make_comparison_complement(struct verify_instruction_param *prm)
+{
+	int comparison_index = opcode_comparison_index(prm->tested_instruction.code);
+	comparison_index ^= COMPARISON_INDEX_GREATER | COMPARISON_INDEX_INCLUSIVE;
+	prm->tested_instruction.code = comparisons_opcode[comparison_index];
+	RTE_SWAP(prm->post, prm->jump);
+}
+
+/* Change comparison verification to converse (swapped operands) one. */
+static void
+make_comparison_converse(struct verify_instruction_param *prm)
+{
+	int comparison_index = opcode_comparison_index(prm->tested_instruction.code);
+	comparison_index ^= COMPARISON_INDEX_GREATER;
+	prm->tested_instruction.code = comparisons_opcode[comparison_index];
+	RTE_SWAP(prm->pre.dst, prm->pre.src);
+	RTE_SWAP(prm->post.dst, prm->post.src);
+	RTE_SWAP(prm->jump.dst, prm->jump.src);
+}
+
+/* Change signed comparison verification to unsigned one. */
+static void
+make_comparison_signed(struct verify_instruction_param *prm)
+{
+	int comparison_index = opcode_comparison_index(prm->tested_instruction.code);
+	if ((comparison_index & COMPARISON_INDEX_SIGNED) != 0) {
+		TEST_LOG_LINE(ERR, "Comparison %hhx is already signed.",
+			prm->tested_instruction.code);
+		RTE_VERIFY(false);
+	}
+	comparison_index |= COMPARISON_INDEX_SIGNED;
+	prm->tested_instruction.code = comparisons_opcode[comparison_index];
+}
+
+/* Verify specified two-register comparison and, if possible, immediate one. */
+static int
+verify_comparison_subcase(struct verify_instruction_param prm)
+{
+	TEST_ASSERT_SUCCESS(verify_instruction(prm), "two-register version check");
+
+	if (make_comparison_immediate(&prm))
+		TEST_ASSERT_SUCCESS(verify_instruction(prm), "immediate version check");
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Verify comparison instruction validation behaviour.
+ *
+ * Call `verify_instruction` for all valid variations of the instruction.
+ *
+ * For instance, `jgt r2, r3` verifies:
+ * * `jgt r2, r3`;
+ * * `jlt r3, r2` src and dst swapped with each other;
+ * * `jle r2, r3` with post and jump domains swapped with each other;
+ * * `jge r3, r2` with all corresponding swaps;
+ * * immediate versions of everything above where possible,
+ *   that is, register on the right is an int32 scalar singleton;
+ * * signed versions of everything above if `also_signed` is true;
+ *
+ * Regardless if passed instruction compares with immediate or singleton src
+ * both cases are generated and tested.
+ */
+static int
+verify_comparison(struct verify_instruction_param prm, bool also_signed)
+{
+	fill_verify_instruction_defaults(&prm);
+
+	if (!prm.pre.src.is_defined)
+		/* Convert from immediate form to simplify further logic. */
+		make_comparison_two_register(&prm);
+
+	/* All reachable domains must be defined by this point. */
+	RTE_VERIFY(prm.pre.dst.is_defined);
+	RTE_VERIFY(prm.pre.src.is_defined);
+	if (!prm.post.is_unreachable) {
+		RTE_VERIFY(prm.post.dst.is_defined);
+		RTE_VERIFY(prm.post.src.is_defined);
+	}
+	if (!prm.jump.is_unreachable) {
+		RTE_VERIFY(prm.jump.dst.is_defined);
+		RTE_VERIFY(prm.jump.src.is_defined);
+	}
+
+	for (int make_signed = 0; make_signed <= also_signed; ++make_signed) {
+		if (make_signed)
+			make_comparison_signed(&prm);
+
+		for (int complement = false; complement <= true; ++complement) {
+
+			for (int converse = false; converse <= true; ++converse) {
+
+				TEST_ASSERT_SUCCESS(verify_comparison_subcase(prm),
+					"make_signed=%d, complement=%d, converse=%d",
+					make_signed, complement, converse);
+
+				make_comparison_converse(&prm);
+			}
+
+			make_comparison_complement(&prm);
+		}
+	}
+
+	return TEST_SUCCESS;
+}
+
 
 /* TESTS FOR SPECIFIC INSTRUCTIONS */
 
@@ -1485,31 +1710,69 @@ test_jmp64_jslt_x(void)
 REGISTER_FAST_TEST(bpf_validate_jmp64_jslt_x_autotest, NOHUGE_OK, ASAN_OK,
 	test_jmp64_jslt_x);
 
-/* Jump on ordering relationship with narrower range. */
+/* Jump on ordering comparisons between two ranges. */
 static int
-test_jmp64_jxx_x_ordering_narrower(void)
+test_jmp64_ordering_ranges(void)
 {
-	TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+	/* All ranges used are valid for both signed and unsigned comparisons. */
+	const bool also_signed = true;
+
+	/*
+	 *     20 ---- dst ---- 60
+	 * 10 -- src -- 40
+	 */
+
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | BPF_JGT | BPF_X),
+			.code = (BPF_JMP | EBPF_JLT | BPF_X),
 		},
 		.pre.dst = make_signed_domain(20, 60),
-		.pre.src = make_signed_domain(30, 50),
-		.post.dst = make_signed_domain(20, 50),
-		.jump.dst = make_signed_domain(31, 60),
-	}), "(BPF_JMP | BPF_JGT | BPF_X) check");
+		.pre.src = make_signed_domain(10, 40),
+		.jump.dst = make_signed_domain(20, 39),
+		.jump.src = make_signed_domain(21, 40),
+	}, also_signed), "strict, dst range weakly greater than src range");
 
-	TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | BPF_JGE | BPF_X),
+			.code = (BPF_JMP | EBPF_JLE | BPF_X),
 		},
 		.pre.dst = make_signed_domain(20, 60),
-		.pre.src = make_signed_domain(30, 50),
-		.post.dst = make_signed_domain(20, 49),
-		.jump.dst = make_signed_domain(30, 60),
-	}), "(BPF_JMP | BPF_JGE | BPF_X) check");
+		.pre.src = make_signed_domain(10, 40),
+		.jump.dst = make_signed_domain(20, 40),
+		.jump.src = make_signed_domain(20, 40),
+	}, also_signed), "non-strict, dst range weakly greater than src range");
 
-	TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+	/*
+	 *     20 ---- dst ---- 60
+	 * 10 -------- src -------- 70
+	 */
+
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | EBPF_JLT | BPF_X),
+		},
+		.pre.dst = make_signed_domain(20, 60),
+		.pre.src = make_signed_domain(10, 70),
+		.post.src = make_signed_domain(10, 60),
+		.jump.src = make_signed_domain(21, 70),
+	}, also_signed), "strict, dst range included in src range");
+
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | EBPF_JLE | BPF_X),
+		},
+		.pre.dst = make_signed_domain(20, 60),
+		.pre.src = make_signed_domain(10, 70),
+		.post.src = make_signed_domain(10, 59),
+		.jump.src = make_signed_domain(20, 70),
+	}, also_signed), "non-strict, dst range included in src range");
+
+	/*
+	 *     20 ---- dst ---- 60
+	 *        30 - src - 50
+	 */
+
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
 			.code = (BPF_JMP | EBPF_JLT | BPF_X),
 		},
@@ -1517,9 +1780,9 @@ test_jmp64_jxx_x_ordering_narrower(void)
 		.pre.src = make_signed_domain(30, 50),
 		.post.dst = make_signed_domain(30, 60),
 		.jump.dst = make_signed_domain(20, 49),
-	}), "(BPF_JMP | EBPF_JLT | BPF_X) check");
+	}, also_signed), "strict, dst range includes src range");
 
-	TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
 			.code = (BPF_JMP | EBPF_JLE | BPF_X),
 		},
@@ -1527,53 +1790,96 @@ test_jmp64_jxx_x_ordering_narrower(void)
 		.pre.src = make_signed_domain(30, 50),
 		.post.dst = make_signed_domain(31, 60),
 		.jump.dst = make_signed_domain(20, 50),
-	}), "(BPF_JMP | EBPF_JLE | BPF_X) check");
+	}, also_signed), "non-strict, dst range includes src range");
 
-	TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+	/*
+	 *     20 ---- dst ---- 60
+	 *             40 -- src -- 70
+	 */
+
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | EBPF_JSGT | BPF_X),
+			.code = (BPF_JMP | EBPF_JLT | BPF_X),
 		},
 		.pre.dst = make_signed_domain(20, 60),
-		.pre.src = make_signed_domain(30, 50),
-		.post.dst = make_signed_domain(20, 50),
-		.jump.dst = make_signed_domain(31, 60),
-	}), "(BPF_JMP | EBPF_JSGT | BPF_X) check");
+		.pre.src = make_signed_domain(40, 70),
+		.post.dst = make_signed_domain(40, 60),
+		.post.src = make_signed_domain(40, 60),
+	}, also_signed), "strict, dst range weakly less than src range");
 
-	TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | EBPF_JSGE | BPF_X),
+			.code = (BPF_JMP | EBPF_JLE | BPF_X),
 		},
 		.pre.dst = make_signed_domain(20, 60),
-		.pre.src = make_signed_domain(30, 50),
-		.post.dst = make_signed_domain(20, 49),
-		.jump.dst = make_signed_domain(30, 60),
-	}), "(BPF_JMP | EBPF_JSGE | BPF_X) check");
+		.pre.src = make_signed_domain(40, 70),
+		.post.dst = make_signed_domain(41, 60),
+		.post.src = make_signed_domain(40, 59),
+	}, also_signed), "non-strict, dst range weakly less than src range");
 
-	TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+	return TEST_SUCCESS;
+}
+
+REGISTER_FAST_TEST(bpf_validate_jmp64_ordering_ranges_autotest, NOHUGE_OK, ASAN_OK,
+	test_jmp64_ordering_ranges);
+
+/* Jump on ordering comparisons with singleton. */
+static int
+test_jmp64_ordering_singleton(void)
+{
+	/* All ranges used are valid for both signed and unsigned comparisons. */
+	const bool also_signed = true;
+
+	/*
+	 *     20 ---- dst ---- 60
+	 *             imm
+	 */
+
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | EBPF_JSLT | BPF_X),
+			.code = (BPF_JMP | EBPF_JLT | BPF_K),
+			.imm = 40,
 		},
 		.pre.dst = make_signed_domain(20, 60),
-		.pre.src = make_signed_domain(30, 50),
-		.post.dst = make_signed_domain(30, 60),
-		.jump.dst = make_signed_domain(20, 49),
-	}), "(BPF_JMP | EBPF_JSLT | BPF_X) check");
+		.post.dst = make_signed_domain(40, 60),
+		.jump.dst = make_signed_domain(20, 39),
+	}, also_signed), "(BPF_JMP | EBPF_JLT | BPF_K) check");
 
-	TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
 		.tested_instruction = {
-			.code = (BPF_JMP | EBPF_JSLE | BPF_X),
+			.code = (BPF_JMP | BPF_JGT | BPF_K),
+			.imm = 40,
 		},
 		.pre.dst = make_signed_domain(20, 60),
-		.pre.src = make_signed_domain(30, 50),
-		.post.dst = make_signed_domain(31, 60),
-		.jump.dst = make_signed_domain(20, 50),
-	}), "(BPF_JMP | EBPF_JSLE | BPF_X) check");
+		.post.dst = make_signed_domain(20, 40),
+		.jump.dst = make_signed_domain(41, 60),
+	}, also_signed), "(BPF_JMP | EBPF_JGT | BPF_K) check");
+
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | EBPF_JLE | BPF_K),
+			.imm = 40,
+		},
+		.pre.dst = make_signed_domain(20, 60),
+		.post.dst = make_signed_domain(41, 60),
+		.jump.dst = make_signed_domain(20, 40),
+	}, also_signed), "(BPF_JMP | EBPF_JLE | BPF_K) check");
+
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | BPF_JGE | BPF_K),
+			.imm = 40,
+		},
+		.pre.dst = make_signed_domain(20, 60),
+		.post.dst = make_signed_domain(20, 39),
+		.jump.dst = make_signed_domain(40, 60),
+	}, also_signed), "(BPF_JMP | EBPF_JGE | BPF_K) check");
 
 	return TEST_SUCCESS;
 }
 
-REGISTER_FAST_TEST(bpf_validate_jmp64_jxx_x_ordering_narrower_autotest, NOHUGE_OK, ASAN_OK,
-	test_jmp64_jxx_x_ordering_narrower);
+REGISTER_FAST_TEST(bpf_validate_jmp64_ordering_singleton_autotest, NOHUGE_OK, ASAN_OK,
+	test_jmp64_ordering_singleton);
 
 /* 64-bit load from heap (should be set to unknown). */
 static int
diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index ddc468fa0dce..8b7c27a2fa3a 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -1522,7 +1522,9 @@ eval_jgt_jle(struct bpf_reg_val *trd, struct bpf_reg_val *trs,
 	struct bpf_reg_val *frd, struct bpf_reg_val *frs)
 {
 	frd->u.max = RTE_MIN(frd->u.max, frs->u.max);
+	frs->u.min = RTE_MAX(frs->u.min, frd->u.min);
 	trd->u.min = RTE_MAX(trd->u.min, trs->u.min + 1);
+	trs->u.max = RTE_MIN(trs->u.max, trd->u.max - 1);
 }
 
 static void
@@ -1530,7 +1532,9 @@ eval_jlt_jge(struct bpf_reg_val *trd, struct bpf_reg_val *trs,
 	struct bpf_reg_val *frd, struct bpf_reg_val *frs)
 {
 	frd->u.min = RTE_MAX(frd->u.min, frs->u.min);
+	frs->u.max = RTE_MIN(frs->u.max, frd->u.max);
 	trd->u.max = RTE_MIN(trd->u.max, trs->u.max - 1);
+	trs->u.min = RTE_MAX(trs->u.min, trd->u.min + 1);
 }
 
 static void
@@ -1538,7 +1542,9 @@ eval_jsgt_jsle(struct bpf_reg_val *trd, struct bpf_reg_val *trs,
 	struct bpf_reg_val *frd, struct bpf_reg_val *frs)
 {
 	frd->s.max = RTE_MIN(frd->s.max, frs->s.max);
+	frs->s.min = RTE_MAX(frs->s.min, frd->s.min);
 	trd->s.min = RTE_MAX(trd->s.min, trs->s.min + 1);
+	trs->s.max = RTE_MIN(trs->s.max, trd->s.max - 1);
 }
 
 static void
@@ -1546,7 +1552,9 @@ eval_jslt_jsge(struct bpf_reg_val *trd, struct bpf_reg_val *trs,
 	struct bpf_reg_val *frd, struct bpf_reg_val *frs)
 {
 	frd->s.min = RTE_MAX(frd->s.min, frs->s.min);
+	frs->s.max = RTE_MIN(frs->s.max, frd->s.max);
 	trd->s.max = RTE_MIN(trd->s.max, trs->s.max - 1);
+	trs->s.min = RTE_MAX(trs->s.min, trd->s.min + 1);
 }
 
 static const char *
-- 
2.43.0

