Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA53FCD3439
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 17:40:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E18CC40A7F;
	Wed,  6 May 2026 19:39:28 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id F0DF840676;
 Wed,  6 May 2026 19:39:18 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g9jK84rH0zHnGjR;
 Thu,  7 May 2026 01:38:20 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id C397F40569;
 Thu,  7 May 2026 01:39:18 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 19:39:18 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Ferruh Yigit
 <ferruh.yigit@amd.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH 10/25] bpf/validate: fix EBPF_JSLT | BPF_X evaluation
Date: Wed, 6 May 2026 18:38:28 +0100
Message-ID: <20260506173846.64914-11-marat.khalili@huawei.com>
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

Function `eval_jcc` was never called for instruction `(BPF_JMP |
EBPF_JSLT | BPF_X)` due to omission from the table `ins_chk`.

E.g. consider the following program with the current validation code:

    Tested program:
        0:  mov r0, #0x0
        1:  ldxdw r2, [r1 + 0]
        2:  jslt r2, #0xfffffffd, L9
        3:  jsgt r2, #0x3, L9
        4:  mov r3, #0x0
        5:  jslt r2, r3, L8  ; tested instruction
        6:  mov r0, #0x1
        7:  exit
        8:  mov r0, #0x2
        9:  exit
    Pre-state:
       r2:
       r3:
    // skip Post-state
    Jump-state:
       r2:  -3..3

Step 8 should only be reachable (jumped to) for values of r2 less than 0
(value assigned to r3 at step 4), but validator still considers r2 to
have same range -3..3 that it had before the step 5. Moreover the
pre-state that should have been saved on step 5 is not filled in the
test DEBUG output at all, demonstrating that evaluation of this state
just did not happen.

Add missing function and change execution logic to not ignore missing
functions. Add test.

Fixes: 6e12ec4c4d6d ("bpf: add more checks")
Cc: stable@dpdk.org

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_bpf_validate.c | 18 +++++++++++++++
 lib/bpf/bpf_validate.c       | 45 ++++++++++++++++++++++++------------
 2 files changed, 48 insertions(+), 15 deletions(-)

diff --git a/app/test/test_bpf_validate.c b/app/test/test_bpf_validate.c
index cdceae3e0728..d7396a88beb8 100644
--- a/app/test/test_bpf_validate.c
+++ b/app/test/test_bpf_validate.c
@@ -1172,6 +1172,24 @@ test_jmp64_jeq_k(void)
 REGISTER_FAST_TEST(bpf_validate_jmp64_jeq_k_autotest, NOHUGE_OK, ASAN_OK,
 	test_jmp64_jeq_k);
 
+/* Jump if signed less than another register. */
+static int
+test_jmp64_jslt_x(void)
+{
+	return verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | EBPF_JSLT | BPF_X),
+		},
+		.pre.dst = make_signed_domain(-3, 3),
+		.pre.src = make_signed_domain(0, 0),
+		.post.dst = make_signed_domain(0, 3),
+		.jump.dst = make_signed_domain(-3, -1),
+	});
+}
+
+REGISTER_FAST_TEST(bpf_validate_jmp64_jslt_x_autotest, NOHUGE_OK, ASAN_OK,
+	test_jmp64_jslt_x);
+
 /* 64-bit load from heap (should be set to unknown). */
 static int
 test_mem_ldx_dw_heap(void)
diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index 391be9cbb474..b0d88fe7d273 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -1372,6 +1372,14 @@ eval_store(struct bpf_verifier *bvf, const struct ebpf_insn *ins)
 	return NULL;
 }
 
+static const char *
+eval_ja(struct bpf_verifier *bvf, const struct ebpf_insn *ins)
+{
+	RTE_SET_USED(bvf);
+	RTE_SET_USED(ins);
+	return NULL;
+}
+
 static const char *
 eval_func_arg(struct bpf_verifier *bvf, const struct rte_bpf_arg *arg,
 	struct bpf_reg_val *rv)
@@ -2023,6 +2031,7 @@ static const struct bpf_ins_check ins_chk[UINT8_MAX + 1] = {
 		.mask = { .dreg = ZERO_REG, .sreg = ZERO_REG},
 		.off = { .min = 0, .max = UINT16_MAX},
 		.imm = { .min = 0, .max = 0},
+		.eval = eval_ja,
 	},
 	/* jcc IMM instructions */
 	[(BPF_JMP | BPF_JEQ | BPF_K)] = {
@@ -2138,6 +2147,7 @@ static const struct bpf_ins_check ins_chk[UINT8_MAX + 1] = {
 		.mask = { .dreg = ALL_REGS, .sreg = ALL_REGS},
 		.off = { .min = 0, .max = UINT16_MAX},
 		.imm = { .min = 0, .max = 0},
+		.eval = eval_jcc,
 	},
 	[(BPF_JMP | EBPF_JSGE | BPF_X)] = {
 		.mask = { .dreg = ALL_REGS, .sreg = ALL_REGS},
@@ -2890,22 +2900,27 @@ evaluate(struct bpf_verifier *bvf)
 				stats.nb_save++;
 			}
 
-			if (ins_chk[op].eval != NULL) {
-				rc = __rte_bpf_validate_debug_evaluate_step(
-					debug, idx, prev_nb_edge > 1 ?
-						RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_ENTER :
-						RTE_BPF_VALIDATE_DEBUG_EVENT_STEP);
-				if (rc < 0)
-					break;
+			if (ins_chk[op].eval == NULL) {
+				RTE_BPF_LOG_FUNC_LINE(ERR,
+					"Unrecognized instruction at pc: %u", idx);
+				rc = -EINVAL;
+				break;
+			}
 
-				err = ins_chk[op].eval(bvf, ins + idx);
-				stats.nb_eval++;
-				if (err != NULL) {
-					RTE_BPF_LOG_FUNC_LINE(ERR,
-						"%s at pc: %u", err, idx);
-					rc = -EINVAL;
-					break;
-				}
+			rc = __rte_bpf_validate_debug_evaluate_step(debug, idx,
+				prev_nb_edge > 1 ?
+					RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_ENTER :
+					RTE_BPF_VALIDATE_DEBUG_EVENT_STEP);
+			if (rc < 0)
+				break;
+
+			err = ins_chk[op].eval(bvf, ins + idx);
+			stats.nb_eval++;
+			if (err != NULL) {
+				RTE_BPF_LOG_FUNC_LINE(ERR,
+					"%s at pc: %u", err, idx);
+				rc = -EINVAL;
+				break;
 			}
 
 			log_dbg_eval_state(bvf, ins + idx, idx);
-- 
2.43.0

