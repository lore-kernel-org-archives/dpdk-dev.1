Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA54CC61CE2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 09:55:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 618414014F;
	Tue, 25 Aug 2026 11:55:58 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 9E903400D5;
 Tue, 25 Aug 2026 11:55:56 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=1VCw9cztlp/5zCvWC8smOlbP9LObLqS0cPeui719G2s=;
 b=2VjhnEGUFzuE+dHLjwyKQZu7P7X6w7OV9tAj/LpQanp8AvO9D8PbfKDknS7oBZYHGu5UJoyTY
 DCYNw70N2xJMtUDw8DWZnqUc3GMHPcREhkpXyK9ZqfR0TeRArB6h5MGvXOUmijddK1kwkKXyPM6
 aYqO31zlG4GQzVFybkTrzPc=
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hTjp00TQdzJ467X;
 Tue, 25 Aug 2026 17:55:36 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id DE82E4058D;
 Tue, 25 Aug 2026 17:55:53 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 11:55:53 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Sebti Mouelhi <sebti.mouelhi@huawei.com>
Subject: [PATCH] bpf/validate: fix 32-bit BPF_AND/OR/XOR shift UBs
Date: Tue, 25 Aug 2026 10:55:29 +0100
Message-ID: <20260825095530.41354-1-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
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

Function `eval_umax_bits`  when calculating the mask matching the
register value counted leading zeroes in 64-bit representation but then
subtracted it from the instruction width (32 for BPF_ALU instructions)
producing zero or negative mask length, all unsupported by macro
`RTE_LEN2MASK`. This function is used by functions `eval_and`, `eval_or`
and `eval_xor` evaluating `BPF_ALU | BPF_AND`, `BPF_ALU | BPF_OR` and
`BPF_ALU | BPF_XOR` correspondingly

E.g. consider the following program with the current validation code:

    Tested program:
        0:  mov r0, #0x0
        1:  ldxdw r2, [r1 + 0]
        2:  jgt r2, #0x7fffffff, L7
        3:  jslt r2, #0x0, L7
        4:  jsgt r2, #0x7fffffff, L7
        5:  and32 r2, #0x7fffffff  ; tested instruction
        6:  mov r0, #0x1
        7:  exit
    Pre-state:
       r2:  0..INT32_MAX
    Post-state:
       r2:  0..INT64_MAX

At step 6 validator presumed that r2 may have values up to INT64_MAX,
which is impossible for the 32-bit bitwise operation on 32-bit operands
and could cause false positives.

With sanitizer the following diagnostic is generated:

    lib/bpf/bpf_validate.c:821:9: runtime error: shift exponent 65 is
    too large for 64-bit type 'long unsigned int'
        #0 0x00000837d9b5 in eval_umax_bits lib/bpf/bpf_validate.c:821
        #1 0x00000837d9f3 in eval_uand_max lib/bpf/bpf_validate.c:828
        #2 0x00000837df83 in eval_and lib/bpf/bpf_validate.c:851
        #3 0x000008384faf in eval_alu lib/bpf/bpf_validate.c:1155
        #4 0x000008396c24 in evaluate lib/bpf/bpf_validate.c:2999

Similarly for `or32 r2, #0x0`, `xor32 r2, #0x0`.

Found using ESBMC (https://esbmc.github.io/docs/) through an agentic
verification workflow, with integer-overflow and undefined-shift checks
enabled.

To fix the issue change to subtracting clz64 result from 64 instead of
instruction width, add tests. Remove no-longer-used opsz argument
(truncation of inputs to 32 bits is handled by the caller `eval_alu`).

Fixes: 8021917293d0 ("bpf: add extra validation for input BPF program")
Cc: stable@dpdk.org

Reported-by: Sebti Mouelhi <sebti.mouelhi@huawei.com>
Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 app/test/test_bpf_validate.c | 45 ++++++++++++++++++++++++++++++++++++
 lib/bpf/bpf_validate.c       | 43 ++++++++++++++++------------------
 2 files changed, 65 insertions(+), 23 deletions(-)

diff --git a/app/test/test_bpf_validate.c b/app/test/test_bpf_validate.c
index 066f1fa156ae..e1c35a41a4f9 100644
--- a/app/test/test_bpf_validate.c
+++ b/app/test/test_bpf_validate.c
@@ -1277,6 +1277,48 @@ verify_comparison(struct verify_instruction_param prm, bool also_signed)
 
 /* TESTS FOR SPECIFIC INSTRUCTIONS */
 
+/* 32-bit bitwise AND between a scalar range and immediate, triggering UB. */
+static int
+test_alu32_and_k_ub(void)
+{
+	return verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_ALU | BPF_AND | BPF_K),
+			.imm = INT32_MAX,
+		},
+		.pre.dst = make_unsigned_domain(0, INT32_MAX),
+		.post.dst = make_unsigned_domain(0, INT32_MAX),
+	});
+}
+
+/* 32-bit bitwise OR between a scalar range and immediate, triggering UB. */
+static int
+test_alu32_or_k_ub(void)
+{
+	return verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_ALU | BPF_OR | BPF_K),
+			.imm = 0,
+		},
+		.pre.dst = make_unsigned_domain(0, INT32_MAX),
+		.post.dst = make_unsigned_domain(0, INT32_MAX),
+	});
+}
+
+/* 32-bit bitwise XOR between a scalar range and immediate, triggering UB. */
+static int
+test_alu32_xor_k_ub(void)
+{
+	return verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_ALU | BPF_XOR | BPF_K),
+			.imm = 0,
+		},
+		.pre.dst = make_unsigned_domain(0, INT32_MAX),
+		.post.dst = make_unsigned_domain(0, INT32_MAX),
+	});
+}
+
 /* 64-bit addition of immediate to a range. */
 static int
 test_alu64_add_k(void)
@@ -2187,6 +2229,9 @@ static struct
 unit_test_suite test_bpf_validate_suite  = {
 	.suite_name = "Test BPF Validate Unit Test Suite",
 	.unit_test_cases = {
+		TEST_CASE(test_alu32_and_k_ub),
+		TEST_CASE(test_alu32_or_k_ub),
+		TEST_CASE(test_alu32_xor_k_ub),
 		TEST_CASE(test_alu64_add_k),
 		TEST_CASE(test_alu64_add_k_pointer),
 		TEST_CASE(test_alu64_add_x_pointer_pointer),
diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index f9960088a285..d3cd14f24683 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -812,43 +812,42 @@ eval_arsh(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, size_t opsz,
 }
 
 static uint64_t
-eval_umax_bits(uint64_t v, size_t opsz)
+eval_umax_bits(uint64_t v)
 {
 	if (v == 0)
 		return 0;
 
 	v = rte_clz64(v);
-	return RTE_LEN2MASK(opsz - v, uint64_t);
+	return RTE_LEN2MASK(64 - v, uint64_t);
 }
 
 /* estimate max possible value for (v1 & v2) */
 static uint64_t
-eval_uand_max(uint64_t v1, uint64_t v2, size_t opsz)
+eval_uand_max(uint64_t v1, uint64_t v2)
 {
-	v1 = eval_umax_bits(v1, opsz);
-	v2 = eval_umax_bits(v2, opsz);
+	v1 = eval_umax_bits(v1);
+	v2 = eval_umax_bits(v2);
 	return (v1 & v2);
 }
 
 /* estimate max possible value for (v1 | v2) */
 static uint64_t
-eval_uor_max(uint64_t v1, uint64_t v2, size_t opsz)
+eval_uor_max(uint64_t v1, uint64_t v2)
 {
-	v1 = eval_umax_bits(v1, opsz);
-	v2 = eval_umax_bits(v2, opsz);
+	v1 = eval_umax_bits(v1);
+	v2 = eval_umax_bits(v2);
 	return (v1 | v2);
 }
 
 static void
-eval_and(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, size_t opsz,
-	uint64_t msk)
+eval_and(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, uint64_t msk)
 {
 	/* both operands are constants */
 	if (rd->u.min == rd->u.max && rs->u.min == rs->u.max) {
 		rd->u.min &= rs->u.min;
 		rd->u.max &= rs->u.max;
 	} else {
-		rd->u.max = eval_uand_max(rd->u.max, rs->u.max, opsz);
+		rd->u.max = eval_uand_max(rd->u.max, rs->u.max);
 		rd->u.min = 0;
 	}
 
@@ -859,22 +858,21 @@ eval_and(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, size_t opsz,
 	/* at least one of operand is non-negative */
 	} else if (rd->s.min >= 0 || rs->s.min >= 0) {
 		rd->s.max = eval_uand_max(rd->s.max & (msk >> 1),
-			rs->s.max & (msk >> 1), opsz);
+			rs->s.max & (msk >> 1));
 		rd->s.min = 0;
 	} else
 		eval_smax_bound(rd, msk);
 }
 
 static void
-eval_or(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, size_t opsz,
-	uint64_t msk)
+eval_or(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, uint64_t msk)
 {
 	/* both operands are constants */
 	if (rd->u.min == rd->u.max && rs->u.min == rs->u.max) {
 		rd->u.min |= rs->u.min;
 		rd->u.max |= rs->u.max;
 	} else {
-		rd->u.max = eval_uor_max(rd->u.max, rs->u.max, opsz);
+		rd->u.max = eval_uor_max(rd->u.max, rs->u.max);
 		rd->u.min = RTE_MAX(rd->u.min, rs->u.min);
 	}
 
@@ -885,22 +883,21 @@ eval_or(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, size_t opsz,
 
 	/* both operands are non-negative */
 	} else if (rd->s.min >= 0 && rs->s.min >= 0) {
-		rd->s.max = eval_uor_max(rd->s.max, rs->s.max, opsz);
+		rd->s.max = eval_uor_max(rd->s.max, rs->s.max);
 		rd->s.min = RTE_MAX(rd->s.min, rs->s.min);
 	} else
 		eval_smax_bound(rd, msk);
 }
 
 static void
-eval_xor(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, size_t opsz,
-	uint64_t msk)
+eval_xor(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, uint64_t msk)
 {
 	/* both operands are constants */
 	if (rd->u.min == rd->u.max && rs->u.min == rs->u.max) {
 		rd->u.min ^= rs->u.min;
 		rd->u.max ^= rs->u.max;
 	} else {
-		rd->u.max = eval_uor_max(rd->u.max, rs->u.max, opsz);
+		rd->u.max = eval_uor_max(rd->u.max, rs->u.max);
 		rd->u.min = 0;
 	}
 
@@ -911,7 +908,7 @@ eval_xor(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, size_t opsz,
 
 	/* both operands are non-negative */
 	} else if (rd->s.min >= 0 && rs->s.min >= 0) {
-		rd->s.max = eval_uor_max(rd->s.max, rs->s.max, opsz);
+		rd->s.max = eval_uor_max(rd->s.max, rs->s.max);
 		rd->s.min = 0;
 	} else
 		eval_smax_bound(rd, msk);
@@ -1152,11 +1149,11 @@ eval_alu(struct bpf_verifier *bvf, const struct ebpf_insn *ins)
 	else if (op == EBPF_ARSH)
 		eval_arsh(rd, &rs, opsz, msk);
 	else if (op == BPF_AND)
-		eval_and(rd, &rs, opsz, msk);
+		eval_and(rd, &rs, msk);
 	else if (op == BPF_OR)
-		eval_or(rd, &rs, opsz, msk);
+		eval_or(rd, &rs, msk);
 	else if (op == BPF_XOR)
-		eval_xor(rd, &rs, opsz, msk);
+		eval_xor(rd, &rs, msk);
 	else if (op == BPF_MUL)
 		eval_mul(rd, &rs, opsz, msk);
 	else if (op == BPF_DIV || op == BPF_MOD)
-- 
2.43.0

