Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A583CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 09:33:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DD8B40DCB;
	Tue, 19 May 2026 11:32:13 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 254D34066B;
 Tue, 19 May 2026 11:31:59 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gKTvY3RWvzHnHBL;
 Tue, 19 May 2026 17:31:37 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id F11E24058B;
 Tue, 19 May 2026 17:31:58 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 May 2026 11:31:58 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Claudia Cauli <claudiacauli@gmail.com>
Subject: [PATCH v2 17/25] bpf/validate: fix BPF_JMP empty range handling
Date: Tue, 19 May 2026 10:31:20 +0100
Message-ID: <20260519093131.52022-18-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519093131.52022-1-marat.khalili@huawei.com>
References: <20260506173846.64914-1-marat.khalili@huawei.com>
 <20260519093131.52022-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500002.china.huawei.com (7.182.19.148) To
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

Function `eval_jcc` did not account for 'dynamically unreachable' code
paths. Some code paths may be _dynamically_ unreachable, which measn
that according to validator calculations no valid values are left to
evaluate. This does not indicate dead code since same code might be
reachable through other code paths. Previous behaviour resulted in:
* undefined behaviour in corner cases;
* ranges breaking min <= max invariant relied upon in multiple places
  (e.g. signed overflow detection in `eval_mul` only checks `s.min` to
  make sure the range is non-negative and so on);
* unnecessary work for validator contributing to exponential code paths
  grow in some cases.

E.g. consider the following program with the current validation code:

    Tested program:
        0:  mov r0, #0x0
        1:  mov r2, #0x2a
        2:  lddw r3, #0x8000000000000000
        4:  jslt r2, r3, L7  ; tested instruction
        5:  mov r0, #0x1
        6:  exit
        7:  mov r0, #0x2
        8:  exit
    Pre-state:
       r2:  42
       r3:  INT64_MIN
    Post-state:
       r2:  42
       r3:  INT64_MIN
    Jump-state:
       r2:  42
       r3:  43..INT64_MIN INTERSECT 0x8000000000000000 (!)

At step 7 after jump from tested instruction validator considers r3 to
equal 0x8000000000000000 if viewed as unsigned, or have nonsensical
range 43..INT64_MIN if viewed as signed. In reality there is just no
valid range for this code path since it will never occur.

With sanitizer the following diagnostic is generated:

    lib/bpf/bpf_validate.c:1824:15: runtime error: signed integer
    overflow: -9223372036854775808 - 1 cannot be represented in type
    'long int'
        #0 0x000002761e41 in eval_jslt_jsge lib/bpf/bpf_validate.c:1824
        #1 0x000002762acb in eval_jcc lib/bpf/bpf_validate.c:1881
        #2 0x00000276b749 in evaluate lib/bpf/bpf_validate.c:3245
    ...

    SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
    lib/bpf/bpf_validate.c:1824:15

Add pruning of dynamically unreachable code paths that arise from
ordering comparisons. Add tests for remaining ordering jump cases.

Fixes: 8021917293d0 ("bpf: add extra validation for input BPF program")
Cc: stable@dpdk.org

Reported-by: Claudia Cauli <claudiacauli@gmail.com>
Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
Depends-on: series-38149 ("bpf: introduce extensible load API")
 app/test/test_bpf_validate.c     | 277 ++++++++++++++++++++++++++++++-
 lib/bpf/bpf_validate.c           |  96 ++++++++---
 lib/bpf/rte_bpf_validate_debug.h |   2 +
 3 files changed, 351 insertions(+), 24 deletions(-)

diff --git a/app/test/test_bpf_validate.c b/app/test/test_bpf_validate.c
index 15ccf4f6a5..f80dee24a6 100644
--- a/app/test/test_bpf_validate.c
+++ b/app/test/test_bpf_validate.c
@@ -135,6 +135,11 @@ static const struct domain unknown = {
 	.u = { .min = 0, .max = UINT64_MAX },
 };
 
+/* Unreachable state. */
+static const struct state unreachable = {
+	.is_unreachable = true,
+};
+
 
 /* BUILDING DOMAINS */
 
@@ -1710,6 +1715,55 @@ test_jmp64_jslt_x(void)
 REGISTER_FAST_TEST(bpf_validate_jmp64_jslt_x_autotest, NOHUGE_OK, ASAN_OK,
 	test_jmp64_jslt_x);
 
+/* Jump on ordering comparisons with potential bound overflow. */
+static int
+test_jmp64_ordering_overflow(void)
+{
+	/* In this test signed and unsigned cases are spelled out explicitly. */
+	const bool also_signed = false;
+
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | EBPF_JSLT | BPF_X),
+		},
+		.pre.dst = make_singleton_domain(42),
+		.pre.src = make_singleton_domain(INT64_MIN),
+		.jump = unreachable,
+	}, also_signed), "signed less than INT64_MIN");
+
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | EBPF_JSGT | BPF_X),
+		},
+		.pre.dst = make_singleton_domain(42),
+		.pre.src = make_singleton_domain(INT64_MAX),
+		.jump = unreachable,
+	}, also_signed), "signed greater than INT64_MAX");
+
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | EBPF_JLT | BPF_X),
+		},
+		.pre.dst = make_singleton_domain(42),
+		.pre.src = make_singleton_domain(0),
+		.jump = unreachable,
+	}, also_signed), "unsigned less than zero");
+
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | BPF_JGT | BPF_X),
+		},
+		.pre.dst = make_singleton_domain(42),
+		.pre.src = make_singleton_domain(UINT64_MAX),
+		.jump = unreachable,
+	}, also_signed), "unsigned greater than UINT64_MAX");
+
+	return TEST_SUCCESS;
+}
+
+REGISTER_FAST_TEST(bpf_validate_jmp64_ordering_overflow_autotest, NOHUGE_OK, ASAN_OK,
+	test_jmp64_ordering_overflow);
+
 /* Jump on ordering comparisons between two ranges. */
 static int
 test_jmp64_ordering_ranges(void)
@@ -1717,6 +1771,29 @@ test_jmp64_ordering_ranges(void)
 	/* All ranges used are valid for both signed and unsigned comparisons. */
 	const bool also_signed = true;
 
+	/*
+	 *               20 ---- dst ---- 60
+	 * 0 - src - 10
+	 */
+
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | EBPF_JLT | BPF_X),
+		},
+		.pre.dst = make_signed_domain(20, 60),
+		.pre.src = make_signed_domain(0, 10),
+		.jump = unreachable,
+	}, also_signed), "strict, dst range strongly greater than src range");
+
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | EBPF_JLE | BPF_X),
+		},
+		.pre.dst = make_signed_domain(20, 60),
+		.pre.src = make_signed_domain(0, 10),
+		.jump = unreachable,
+	}, also_signed), "non-strict, dst range strongly greater than src range");
+
 	/*
 	 *     20 ---- dst ---- 60
 	 * 10 -- src -- 40
@@ -1817,15 +1894,38 @@ test_jmp64_ordering_ranges(void)
 		.post.src = make_signed_domain(40, 59),
 	}, also_signed), "non-strict, dst range weakly less than src range");
 
+	/*
+	 *     20 ---- dst ---- 60
+	 *                          70 - src - 80
+	 */
+
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | EBPF_JLT | BPF_X),
+		},
+		.pre.dst = make_signed_domain(20, 60),
+		.pre.src = make_signed_domain(70, 80),
+		.post = unreachable,
+	}, also_signed), "strict, dst range strongly less than src range");
+
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | EBPF_JLE | BPF_X),
+		},
+		.pre.dst = make_signed_domain(20, 60),
+		.pre.src = make_signed_domain(70, 80),
+		.post = unreachable,
+	}, also_signed), "non-strict, dst range strongly less than src range");
+
 	return TEST_SUCCESS;
 }
 
 REGISTER_FAST_TEST(bpf_validate_jmp64_ordering_ranges_autotest, NOHUGE_OK, ASAN_OK,
 	test_jmp64_ordering_ranges);
 
-/* Jump on ordering comparisons with singleton. */
+/* Jump on ordering comparisons with singleton inside the range. */
 static int
-test_jmp64_ordering_singleton(void)
+test_jmp64_ordering_singleton_inside(void)
 {
 	/* All ranges used are valid for both signed and unsigned comparisons. */
 	const bool also_signed = true;
@@ -1878,8 +1978,177 @@ test_jmp64_ordering_singleton(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_FAST_TEST(bpf_validate_jmp64_ordering_singleton_autotest, NOHUGE_OK, ASAN_OK,
-	test_jmp64_ordering_singleton);
+REGISTER_FAST_TEST(bpf_validate_jmp64_ordering_singleton_inside_autotest, NOHUGE_OK, ASAN_OK,
+	test_jmp64_ordering_singleton_inside);
+
+/* Jump on ordering comparisons with singleton outside the range. */
+static int
+test_jmp64_ordering_singleton_outside(void)
+{
+	/* All ranges used are valid for both signed and unsigned comparisons. */
+	const bool also_signed = true;
+
+	/*
+	 *       20 ---- dst ---- 60
+	 *  imm
+	 */
+
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | EBPF_JLT | BPF_K),
+			.imm = 10,
+		},
+		.pre.dst = make_signed_domain(20, 60),
+		.jump = unreachable,
+	}, also_signed), "(BPF_JMP | EBPF_JLT | BPF_K) check, range greater than imm");
+
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | EBPF_JLE | BPF_K),
+			.imm = 10,
+		},
+		.pre.dst = make_signed_domain(20, 60),
+		.jump = unreachable,
+	}, also_signed), "(BPF_JMP | EBPF_JLE | BPF_K) check, range greater than imm");
+
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | BPF_JGT | BPF_K),
+			.imm = 10,
+		},
+		.pre.dst = make_signed_domain(20, 60),
+		.post = unreachable,
+	}, also_signed), "(BPF_JMP | EBPF_JGT | BPF_K) check, range greater than imm");
+
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | BPF_JGE | BPF_K),
+			.imm = 10,
+		},
+		.pre.dst = make_signed_domain(20, 60),
+		.post = unreachable,
+	}, also_signed), "(BPF_JMP | EBPF_JGE | BPF_K) check, range greater than imm");
+
+	/*
+	 *       20 ---- dst ---- 60
+	 *                            imm
+	 */
+
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | EBPF_JLT | BPF_K),
+			.imm = 70,
+		},
+		.pre.dst = make_signed_domain(20, 60),
+		.post = unreachable,
+	}, also_signed), "(BPF_JMP | EBPF_JLT | BPF_K) check, range less than imm");
+
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | EBPF_JLE | BPF_K),
+			.imm = 70,
+		},
+		.pre.dst = make_signed_domain(20, 60),
+		.post = unreachable,
+	}, also_signed), "(BPF_JMP | EBPF_JLE | BPF_K) check, range less than imm");
+
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | BPF_JGT | BPF_K),
+			.imm = 70,
+		},
+		.pre.dst = make_signed_domain(20, 60),
+		.jump = unreachable,
+	}, also_signed), "(BPF_JMP | EBPF_JGT | BPF_K) check, range less than imm");
+
+	TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | BPF_JGE | BPF_K),
+			.imm = 70,
+		},
+		.pre.dst = make_signed_domain(20, 60),
+		.jump = unreachable,
+	}, also_signed), "(BPF_JMP | EBPF_JGE | BPF_K) check, range less than imm");
+
+	return TEST_SUCCESS;
+}
+
+REGISTER_FAST_TEST(bpf_validate_jmp64_ordering_singleton_outside_autotest, NOHUGE_OK, ASAN_OK,
+	test_jmp64_ordering_singleton_outside);
+
+/* Jump on ordering comparisons with ranges "touching" each other. */
+static int
+test_jmp64_ordering_touching(void)
+{
+	/* All ranges used are valid for both signed and unsigned comparisons. */
+	const bool also_signed = true;
+
+	for (int overlap = 0; overlap != 3; ++overlap) {
+
+		/*
+		 *                  20 - dst - 30
+		 * 10 - src - (19 + overlap)
+		 */
+
+		TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
+			.tested_instruction = {
+				.code = (BPF_JMP | EBPF_JLT | BPF_X),
+			},
+			.pre.dst = make_signed_domain(20, 30),
+			.pre.src = make_signed_domain(10, 19 + overlap),
+			.jump = overlap <= 1 ? unreachable : (struct state){
+				.dst = make_singleton_domain(20),
+				.src = make_singleton_domain(21),
+			},
+		}, also_signed), "strict, dst left touching src right, overlap=%d", overlap);
+
+		TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
+			.tested_instruction = {
+				.code = (BPF_JMP | EBPF_JLE | BPF_X),
+			},
+			.pre.dst = make_signed_domain(20, 30),
+			.pre.src = make_signed_domain(10, 19 + overlap),
+			.jump = overlap < 1 ? unreachable : (struct state){
+				.dst = make_signed_domain(20, 19 + overlap),
+				.src = make_signed_domain(20, 19 + overlap),
+			},
+		}, also_signed), "non-strict, dst left touching src right, overlap=%d", overlap);
+
+		/*
+		 * 10 - dst - (19 + overlap)
+		 *                  20 - src - 30
+		 */
+
+		TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
+			.tested_instruction = {
+				.code = (BPF_JMP | EBPF_JLT | BPF_X),
+			},
+			.pre.dst = make_signed_domain(10, 19 + overlap),
+			.pre.src = make_signed_domain(20, 30),
+			.post = overlap < 1 ? unreachable : (struct state){
+				.dst = make_signed_domain(20, 19 + overlap),
+				.src = make_signed_domain(20, 19 + overlap),
+			},
+		}, also_signed), "strict, dst right touching src left, overlap=%d", overlap);
+
+		TEST_ASSERT_SUCCESS(verify_comparison((struct verify_instruction_param){
+			.tested_instruction = {
+				.code = (BPF_JMP | EBPF_JLE | BPF_X),
+			},
+			.pre.dst = make_signed_domain(10, 19 + overlap),
+			.pre.src = make_signed_domain(20, 30),
+			.post = overlap <= 1 ? unreachable : (struct state){
+				.dst = make_singleton_domain(21),
+				.src = make_singleton_domain(20),
+			},
+		}, also_signed), "non-strict, dst right touching src left, overlap=%d", overlap);
+	}
+
+	return TEST_SUCCESS;
+}
+
+REGISTER_FAST_TEST(bpf_validate_jmp64_ordering_touching_autotest, NOHUGE_OK, ASAN_OK,
+	test_jmp64_ordering_touching);
 
 /* 64-bit load from heap (should be set to unknown). */
 static int
diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index 8b7c27a2fa..fbae70df92 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -19,6 +19,9 @@
 
 #define BPF_ARG_PTR_STACK RTE_BPF_ARG_RESERVED
 
+/* type containing no values (AKA "bottom", "never" etc)  */
+#define BPF_ARG_UNINHABITED ((enum rte_bpf_arg_type)(RTE_BPF_ARG_UNDEF - 1))
+
 struct bpf_reg_val {
 	struct rte_bpf_arg v;
 	uint64_t mask;
@@ -36,6 +39,8 @@ struct bpf_eval_state {
 	SLIST_ENTRY(bpf_eval_state) next; /* for @safe list traversal */
 	struct bpf_reg_val rv[EBPF_REG_NUM];
 	struct bpf_reg_val sv[MAX_BPF_STACK_SIZE / sizeof(uint64_t)];
+	/* flag set for branches determined to be dynamically unreachable */
+	bool unreachable;
 };
 
 SLIST_HEAD(bpf_evst_head, bpf_eval_state);
@@ -174,6 +179,9 @@ __rte_bpf_validate_can_access(const struct bpf_verifier *verifier,
 	struct value_set access_set;
 	uint32_t opsz;
 
+	if (st->unreachable)
+		return -ENOENT;
+
 	switch (BPF_CLASS(access->code)) {
 	case BPF_LDX:
 		rv = &st->rv[access->src_reg];
@@ -310,6 +318,10 @@ __rte_bpf_validate_may_jump(const struct bpf_verifier *verifier,
 	if (!may_jump_code_is_supported(jump->code))
 		return -ENOTSUP;
 
+	if (st->unreachable)
+		/* Set no bits since neither false nor true is possible. */
+		return 0;
+
 	rd = &st->rv[jump->dst_reg];
 	dst_set = (rd->v.type == RTE_BPF_ARG_UNDEF) ? value_set_full :
 		value_set_from_pair(rd->s.min, rd->s.max, rd->u.min, rd->u.max);
@@ -1521,40 +1533,68 @@ static void
 eval_jgt_jle(struct bpf_reg_val *trd, struct bpf_reg_val *trs,
 	struct bpf_reg_val *frd, struct bpf_reg_val *frs)
 {
-	frd->u.max = RTE_MIN(frd->u.max, frs->u.max);
-	frs->u.min = RTE_MAX(frs->u.min, frd->u.min);
-	trd->u.min = RTE_MAX(trd->u.min, trs->u.min + 1);
-	trs->u.max = RTE_MIN(trs->u.max, trd->u.max - 1);
+	if (frd->u.min <= frs->u.max) {
+		frd->u.max = RTE_MIN(frd->u.max, frs->u.max);
+		frs->u.min = RTE_MAX(frs->u.min, frd->u.min);
+	} else
+		frd->v.type = frs->v.type = BPF_ARG_UNINHABITED;
+
+	if (trs->u.min < trd->u.max) {
+		trd->u.min = RTE_MAX(trd->u.min, trs->u.min + 1);
+		trs->u.max = RTE_MIN(trs->u.max, trd->u.max - 1);
+	} else
+		trd->v.type = trs->v.type = BPF_ARG_UNINHABITED;
 }
 
 static void
 eval_jlt_jge(struct bpf_reg_val *trd, struct bpf_reg_val *trs,
 	struct bpf_reg_val *frd, struct bpf_reg_val *frs)
 {
-	frd->u.min = RTE_MAX(frd->u.min, frs->u.min);
-	frs->u.max = RTE_MIN(frs->u.max, frd->u.max);
-	trd->u.max = RTE_MIN(trd->u.max, trs->u.max - 1);
-	trs->u.min = RTE_MAX(trs->u.min, trd->u.min + 1);
+	if (frs->u.min <= frd->u.max) {
+		frd->u.min = RTE_MAX(frd->u.min, frs->u.min);
+		frs->u.max = RTE_MIN(frs->u.max, frd->u.max);
+	} else
+		frd->v.type = frs->v.type = BPF_ARG_UNINHABITED;
+
+	if (trd->u.min < trs->u.max) {
+		trd->u.max = RTE_MIN(trd->u.max, trs->u.max - 1);
+		trs->u.min = RTE_MAX(trs->u.min, trd->u.min + 1);
+	} else
+		trd->v.type = trs->v.type = BPF_ARG_UNINHABITED;
 }
 
 static void
 eval_jsgt_jsle(struct bpf_reg_val *trd, struct bpf_reg_val *trs,
 	struct bpf_reg_val *frd, struct bpf_reg_val *frs)
 {
-	frd->s.max = RTE_MIN(frd->s.max, frs->s.max);
-	frs->s.min = RTE_MAX(frs->s.min, frd->s.min);
-	trd->s.min = RTE_MAX(trd->s.min, trs->s.min + 1);
-	trs->s.max = RTE_MIN(trs->s.max, trd->s.max - 1);
+	if (frd->s.min <= frs->s.max) {
+		frd->s.max = RTE_MIN(frd->s.max, frs->s.max);
+		frs->s.min = RTE_MAX(frs->s.min, frd->s.min);
+	} else
+		frd->v.type = frs->v.type = BPF_ARG_UNINHABITED;
+
+	if (trs->s.min < trd->s.max) {
+		trd->s.min = RTE_MAX(trd->s.min, trs->s.min + 1);
+		trs->s.max = RTE_MIN(trs->s.max, trd->s.max - 1);
+	} else
+		trd->v.type = trs->v.type = BPF_ARG_UNINHABITED;
 }
 
 static void
 eval_jslt_jsge(struct bpf_reg_val *trd, struct bpf_reg_val *trs,
 	struct bpf_reg_val *frd, struct bpf_reg_val *frs)
 {
-	frd->s.min = RTE_MAX(frd->s.min, frs->s.min);
-	frs->s.max = RTE_MIN(frs->s.max, frd->s.max);
-	trd->s.max = RTE_MIN(trd->s.max, trs->s.max - 1);
-	trs->s.min = RTE_MAX(trs->s.min, trd->s.min + 1);
+	if (frs->s.min <= frd->s.max) {
+		frd->s.min = RTE_MAX(frd->s.min, frs->s.min);
+		frs->s.max = RTE_MIN(frs->s.max, frd->s.max);
+	} else
+		frd->v.type = frs->v.type = BPF_ARG_UNINHABITED;
+
+	if (trd->s.min < trs->s.max) {
+		trd->s.max = RTE_MIN(trd->s.max, trs->s.max - 1);
+		trs->s.min = RTE_MAX(trs->s.min, trd->s.min + 1);
+	} else
+		trd->v.type = trs->v.type = BPF_ARG_UNINHABITED;
 }
 
 static const char *
@@ -1609,6 +1649,14 @@ eval_jcc(struct bpf_verifier *bvf, const struct ebpf_insn *ins)
 	else if (op == EBPF_JSGE)
 		eval_jslt_jsge(frd, frs, trd, trs);
 
+	if (trd->v.type == BPF_ARG_UNINHABITED ||
+			trs->v.type == BPF_ARG_UNINHABITED)
+		tst->unreachable = true;
+
+	if (frd->v.type == BPF_ARG_UNINHABITED ||
+			frs->v.type == BPF_ARG_UNINHABITED)
+		fst->unreachable = true;
+
 	return NULL;
 }
 
@@ -2349,7 +2397,7 @@ set_edge_type(struct bpf_verifier *bvf, struct inst_node *node,
  * Depth-First Search (DFS) through previously constructed
  * Control Flow Graph (CFG).
  * Information collected at this path would be used later
- * to determine is there any loops, and/or unreachable instructions.
+ * to determine is there any loops, and/or statically unreachable instructions.
  * PREREQUISITE: there is at least one node.
  */
 static void
@@ -2397,7 +2445,7 @@ dfs(struct bpf_verifier *bvf)
 }
 
 /*
- * report unreachable instructions.
+ * report statically unreachable instructions.
  */
 static void
 log_unreachable(const struct bpf_verifier *bvf)
@@ -2970,13 +3018,21 @@ evaluate(struct bpf_verifier *bvf)
 				stats.nb_restore++;
 			}
 
+			if (bvf->evst->unreachable) {
+				rc = __rte_bpf_validate_debug_evaluate_step(
+					debug, get_node_idx(bvf, next),
+					RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_UNREACHABLE);
+				if (rc < 0)
+					break;
+
+				next = NULL;
 			/*
 			 * for jcc targets: check did we already evaluated
 			 * that path and can it's evaluation be skipped that
 			 * time.
 			 */
-			if (node->nb_edge > 1 && prune_eval_state(bvf, node,
-					next) == 0) {
+			} else if (node->nb_edge > 1 &&
+					prune_eval_state(bvf, node, next) == 0) {
 				rc = __rte_bpf_validate_debug_evaluate_step(
 					debug, get_node_idx(bvf, next),
 					RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_PRUNE);
diff --git a/lib/bpf/rte_bpf_validate_debug.h b/lib/bpf/rte_bpf_validate_debug.h
index 89bf587f02..f30fa926f1 100644
--- a/lib/bpf/rte_bpf_validate_debug.h
+++ b/lib/bpf/rte_bpf_validate_debug.h
@@ -49,6 +49,8 @@ enum rte_bpf_validate_debug_event {
 	RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_PRUNE,
 	/* End of branch verification, after the last verified instruction. */
 	RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_RETURN,
+	/* Pruning branch as dynamically unreachable. */
+	RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_UNREACHABLE,
 	/* Number of valid event values. */
 	RTE_BPF_VALIDATE_DEBUG_EVENT_END,
 };
-- 
2.43.0

