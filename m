Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE85CD3439
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 17:40:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02AA440E16;
	Wed,  6 May 2026 19:39:35 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 1FCF94066F;
 Wed,  6 May 2026 19:39:21 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g9jKB6318zHnGgq;
 Thu,  7 May 2026 01:38:22 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id ECB1D40569;
 Thu,  7 May 2026 01:39:20 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 19:39:20 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH 15/25] bpf/validate: fix BPF_JGT/EBPF_JSGT no-jump max
Date: Wed, 6 May 2026 18:38:33 +0100
Message-ID: <20260506173846.64914-16-marat.khalili@huawei.com>
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

Functions `eval_jgt_jle` and `eval_jsgt_jsle` reduced range maximum for
BPF_JGT and EBPF_JSGT instructions in the no-jump case to the minimum of
src register instead of the maximum, producing more conservative
estimate that could cause false positives.

E.g. consider the following program with the current validation code:

    Tested program:
        0:  mov r0, #0x0
        1:  ldxdw r2, [r1 + 0]
        2:  jlt r2, #0x14, L15
        3:  jgt r2, #0x3c, L15
        4:  jslt r2, #0x14, L15
        5:  jsgt r2, #0x3c, L15
        6:  ldxdw r3, [r1 + 8]
        7:  jlt r3, #0x1e, L15
        8:  jgt r3, #0x32, L15
        9:  jslt r3, #0x1e, L15
       10:  jsgt r3, #0x32, L15
       11:  jgt r2, r3, L14  ; tested instruction
       12:  mov r0, #0x1
       13:  exit
       14:  mov r0, #0x2
       15:  exit
    Pre-state:
       r2:  20..60
       r3:  30..50
    Post-state:
       r2:  20..60 INTERSECT 0x14..0x1e (!)

Immediately after the tested instruction on step 12 validator expects r2
to contain values up to 60, for example 55, however for this value jump
condition r2 > r3 on step 11 would be always satisfied since r3 is known
to not exceed 50, and thus execution will always jump to step 14 instead
of continuing to step 12.

Fix range calculation, add tests for cases where range of src register
values is a strict subset of dst. Other cases will be covered in the
subsequent commits.

Fixes: 8021917293d0 ("bpf: add extra validation for input BPF program")
Cc: stable@dpdk.org

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_bpf_validate.c | 90 ++++++++++++++++++++++++++++++++++++
 lib/bpf/bpf_validate.c       |  4 +-
 2 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/app/test/test_bpf_validate.c b/app/test/test_bpf_validate.c
index b4cb5d8cdf8d..359e50aaaf8f 100644
--- a/app/test/test_bpf_validate.c
+++ b/app/test/test_bpf_validate.c
@@ -1485,6 +1485,96 @@ test_jmp64_jslt_x(void)
 REGISTER_FAST_TEST(bpf_validate_jmp64_jslt_x_autotest, NOHUGE_OK, ASAN_OK,
 	test_jmp64_jslt_x);
 
+/* Jump on ordering relationship with narrower range. */
+static int
+test_jmp64_jxx_x_ordering_narrower(void)
+{
+	TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | BPF_JGT | BPF_X),
+		},
+		.pre.dst = make_signed_domain(20, 60),
+		.pre.src = make_signed_domain(30, 50),
+		.post.dst = make_signed_domain(20, 50),
+		.jump.dst = make_signed_domain(31, 60),
+	}), "(BPF_JMP | BPF_JGT | BPF_X) check");
+
+	TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | BPF_JGE | BPF_X),
+		},
+		.pre.dst = make_signed_domain(20, 60),
+		.pre.src = make_signed_domain(30, 50),
+		.post.dst = make_signed_domain(20, 49),
+		.jump.dst = make_signed_domain(30, 60),
+	}), "(BPF_JMP | BPF_JGE | BPF_X) check");
+
+	TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | EBPF_JLT | BPF_X),
+		},
+		.pre.dst = make_signed_domain(20, 60),
+		.pre.src = make_signed_domain(30, 50),
+		.post.dst = make_signed_domain(30, 60),
+		.jump.dst = make_signed_domain(20, 49),
+	}), "(BPF_JMP | EBPF_JLT | BPF_X) check");
+
+	TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | EBPF_JLE | BPF_X),
+		},
+		.pre.dst = make_signed_domain(20, 60),
+		.pre.src = make_signed_domain(30, 50),
+		.post.dst = make_signed_domain(31, 60),
+		.jump.dst = make_signed_domain(20, 50),
+	}), "(BPF_JMP | EBPF_JLE | BPF_X) check");
+
+	TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | EBPF_JSGT | BPF_X),
+		},
+		.pre.dst = make_signed_domain(20, 60),
+		.pre.src = make_signed_domain(30, 50),
+		.post.dst = make_signed_domain(20, 50),
+		.jump.dst = make_signed_domain(31, 60),
+	}), "(BPF_JMP | EBPF_JSGT | BPF_X) check");
+
+	TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | EBPF_JSGE | BPF_X),
+		},
+		.pre.dst = make_signed_domain(20, 60),
+		.pre.src = make_signed_domain(30, 50),
+		.post.dst = make_signed_domain(20, 49),
+		.jump.dst = make_signed_domain(30, 60),
+	}), "(BPF_JMP | EBPF_JSGE | BPF_X) check");
+
+	TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | EBPF_JSLT | BPF_X),
+		},
+		.pre.dst = make_signed_domain(20, 60),
+		.pre.src = make_signed_domain(30, 50),
+		.post.dst = make_signed_domain(30, 60),
+		.jump.dst = make_signed_domain(20, 49),
+	}), "(BPF_JMP | EBPF_JSLT | BPF_X) check");
+
+	TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_JMP | EBPF_JSLE | BPF_X),
+		},
+		.pre.dst = make_signed_domain(20, 60),
+		.pre.src = make_signed_domain(30, 50),
+		.post.dst = make_signed_domain(31, 60),
+		.jump.dst = make_signed_domain(20, 50),
+	}), "(BPF_JMP | EBPF_JSLE | BPF_X) check");
+
+	return TEST_SUCCESS;
+}
+
+REGISTER_FAST_TEST(bpf_validate_jmp64_jxx_x_ordering_narrower_autotest, NOHUGE_OK, ASAN_OK,
+	test_jmp64_jxx_x_ordering_narrower);
+
 /* 64-bit load from heap (should be set to unknown). */
 static int
 test_mem_ldx_dw_heap(void)
diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index a53048801a23..ddc468fa0dce 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -1521,7 +1521,7 @@ static void
 eval_jgt_jle(struct bpf_reg_val *trd, struct bpf_reg_val *trs,
 	struct bpf_reg_val *frd, struct bpf_reg_val *frs)
 {
-	frd->u.max = RTE_MIN(frd->u.max, frs->u.min);
+	frd->u.max = RTE_MIN(frd->u.max, frs->u.max);
 	trd->u.min = RTE_MAX(trd->u.min, trs->u.min + 1);
 }
 
@@ -1537,7 +1537,7 @@ static void
 eval_jsgt_jsle(struct bpf_reg_val *trd, struct bpf_reg_val *trs,
 	struct bpf_reg_val *frd, struct bpf_reg_val *frs)
 {
-	frd->s.max = RTE_MIN(frd->s.max, frs->s.min);
+	frd->s.max = RTE_MIN(frd->s.max, frs->s.max);
 	trd->s.min = RTE_MAX(trd->s.min, trs->s.min + 1);
 }
 
-- 
2.43.0

