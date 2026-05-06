Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D933BCD342C
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 17:41:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7945440E0A;
	Wed,  6 May 2026 19:39:39 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id B8DB6406B4;
 Wed,  6 May 2026 19:39:22 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g9jKD3b6wzHnGgq;
 Thu,  7 May 2026 01:38:24 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 98E3A40569;
 Thu,  7 May 2026 01:39:22 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 19:39:22 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH 19/25] bpf/validate: fix BPF_LSH shift-out-of-bounds UB
Date: Wed, 6 May 2026 18:38:37 +0100
Message-ID: <20260506173846.64914-20-marat.khalili@huawei.com>
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

Function `eval_lsh` when validating left shift by 63 invoked macro
`RTE_LEN2MASK(0, int64_t)` which triggered shift-out-of-bounds undefined
behaviour.

E.g. consider the following program with the current validation code:

    Tested program:
        0:  mov r0, #0x0
        1:  ldxdw r2, [r1 + 0]
        2:  jlt r2, #0x3, L8
        3:  jgt r2, #0x5, L8
        4:  jslt r2, #0x3, L8
        5:  jsgt r2, #0x5, L8
        6:  lsh r2, #0x3f  ; tested instruction
        7:  mov r0, #0x1
        8:  exit
    Pre-state:
       r2:  3..5
    Post-state:
       r2:  0..UINT64_MAX

With sanitizer the following diagnostic is generated:

    lib/bpf/bpf_validate.c:785:4: runtime error: shift exponent 64 is
    too large for 64-bit type 'long unsigned int'
        #0 0x00000274d5e0 in eval_lsh lib/bpf/bpf_validate.c:785
        #1 0x00000275a2ea in eval_alu lib/bpf/bpf_validate.c:1310
        #2 0x00000276ce3d in evaluate lib/bpf/bpf_validate.c:3284

Add guard for this case, add test.

Fixes: 8021917293d0 ("bpf: add extra validation for input BPF program")
Cc: stable@dpdk.org

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_bpf_validate.c | 17 +++++++++++++++++
 lib/bpf/bpf_validate.c       |  3 ++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/app/test/test_bpf_validate.c b/app/test/test_bpf_validate.c
index 646313cdacf2..64047af44e4a 100644
--- a/app/test/test_bpf_validate.c
+++ b/app/test/test_bpf_validate.c
@@ -1536,6 +1536,23 @@ test_alu64_div_mod_overflow(void)
 REGISTER_FAST_TEST(bpf_validate_alu64_div_mod_overflow_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_div_mod_overflow);
 
+/* 64-bit left shift by 63. */
+static int
+test_alu64_lsh_63(void)
+{
+	return verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (EBPF_ALU64 | BPF_LSH | BPF_K),
+			.imm = 63,
+		},
+		.pre.dst = make_signed_domain(3, 5),
+		.post.dst = unknown,
+	});
+}
+
+REGISTER_FAST_TEST(bpf_validate_alu64_lsh_63_autotest, NOHUGE_OK, ASAN_OK,
+	test_alu64_lsh_63);
+
 /* 64-bit multiplication of constant and immediate with overflow. */
 static int
 test_alu64_mul_k_overflow(void)
diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index 4dbf3a3ef892..2c61e5d96a5f 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -746,7 +746,8 @@ eval_lsh(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, size_t opsz,
 
 	/* check that dreg values are and would remain always positive */
 	if ((uint64_t)rd->s.min >> (opsz - 1) != 0 || rd->s.max >=
-			RTE_LEN2MASK(opsz - rs->u.max - 1, int64_t))
+			(rs->u.max == opsz - 1 ? 0 :
+				 RTE_LEN2MASK(opsz - rs->u.max - 1, int64_t)))
 		eval_smax_bound(rd, msk);
 	else {
 		rd->s.max <<= rs->u.max;
-- 
2.43.0

