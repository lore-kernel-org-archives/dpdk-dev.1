Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B2DCD342C
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 17:40:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D11F40E03;
	Wed,  6 May 2026 19:39:33 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 52CEA406B4;
 Wed,  6 May 2026 19:39:21 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g9jKz0MDYzJ46Q7;
 Thu,  7 May 2026 01:39:03 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 7D82D40569;
 Thu,  7 May 2026 01:39:20 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 19:39:20 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH 14/25] bpf/validate: fix BPF_MUL signed overflow UB
Date: Wed, 6 May 2026 18:38:32 +0100
Message-ID: <20260506173846.64914-15-marat.khalili@huawei.com>
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

Function `eval_mul` triggered signed overflow for large constants.

E.g. consider the following program with the current validation code:

    Tested program:
        0:  mov r0, #0x0
        1:  lddw r2, #0x9876543210
        3:  mul r2, #0x12345678  ; tested instruction
        4:  mov r0, #0x1
        5:  exit

With sanitizer the following diagnostic is generated:

    lib/bpf/bpf_validate.c:1032:26: runtime error: signed integer
    overflow: 654820258320 * 305419896 cannot be represented in type
    'long int'
        #0 0x000002746bfd in eval_mul lib/bpf/bpf_validate.c:1032
        #1 0x00000274b6ac in eval_alu lib/bpf/bpf_validate.c:1260
        #2 0x00000275c526 in evaluate lib/bpf/bpf_validate.c:3174
        ...

    SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
    lib/bpf/bpf_validate.c:1032:26

Multiply constants as unsigned which will produce mathematically correct
result in two's complement representation, add test.

Fixes: 8021917293d0 ("bpf: add extra validation for input BPF program")
Cc: stable@dpdk.org

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_bpf_validate.c | 17 +++++++++++++++++
 lib/bpf/bpf_validate.c       |  4 ++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/app/test/test_bpf_validate.c b/app/test/test_bpf_validate.c
index 3e0493f831ae..b4cb5d8cdf8d 100644
--- a/app/test/test_bpf_validate.c
+++ b/app/test/test_bpf_validate.c
@@ -1289,6 +1289,23 @@ test_alu64_div_mod_overflow(void)
 REGISTER_FAST_TEST(bpf_validate_alu64_div_mod_overflow_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_div_mod_overflow);
 
+/* 64-bit multiplication of constant and immediate with overflow. */
+static int
+test_alu64_mul_k_overflow(void)
+{
+	return verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (EBPF_ALU64 | BPF_MUL | BPF_K),
+			.imm = 0x12345678,
+		},
+		.pre.dst = make_singleton_domain(0x9876543210),
+		.post.dst = make_singleton_domain(0x9876543210u * 0x12345678),
+	});
+}
+
+REGISTER_FAST_TEST(bpf_validate_alu64_mul_k_overflow_autotest, NOHUGE_OK, ASAN_OK,
+	test_alu64_mul_k_overflow);
+
 /* 64-bit mul of small scalar range and immediate. */
 static int
 test_alu64_mul_k_range_small(void)
diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index 39c75bbcd76f..a53048801a23 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -921,8 +921,8 @@ eval_mul(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, size_t opsz,
 
 	/* both operands are constants */
 	if (rd->s.min == rd->s.max && rs->s.min == rs->s.max) {
-		rd->s.min = (rd->s.min * rs->s.min) & msk;
-		rd->s.max = (rd->s.max * rs->s.max) & msk;
+		rd->s.min = ((uint64_t)rd->s.min * (uint64_t)rs->s.min) & msk;
+		rd->s.max = ((uint64_t)rd->s.max * (uint64_t)rs->s.max) & msk;
 	/* check that both operands are positive and no overflow */
 	} else if (rd->s.min >= 0 && rs->s.min >= 0) {
 		rd->s.max *= rs->s.max;
-- 
2.43.0

