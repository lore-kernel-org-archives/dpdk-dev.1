Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EC3CD4851
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 09:33:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA30840A80;
	Tue, 19 May 2026 11:32:08 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 37F8D40665;
 Tue, 19 May 2026 11:31:57 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gKTvW4DcpzHnH8q;
 Tue, 19 May 2026 17:31:35 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 1A2FE40570;
 Tue, 19 May 2026 17:31:57 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 May 2026 11:31:56 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Claudia Cauli <claudiacauli@gmail.com>
Subject: [PATCH v2 13/25] bpf/validate: fix BPF_MUL ranges minimum typo
Date: Tue, 19 May 2026 10:31:16 +0100
Message-ID: <20260519093131.52022-14-marat.khalili@huawei.com>
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

Function `eval_mul` calculated minimum of the both signed and unsigned
ranges as destination square instead of product with source due to a
typo.

E.g. consider the following program with the current validation code:

     Tested program:
         0:  mov r0, #0x0
         1:  ldxdw r2, [r1 + 0]
         2:  jlt r2, #0x11, L8
         3:  jgt r2, #0x1d, L8
         4:  jslt r2, #0x11, L8
         5:  jsgt r2, #0x1d, L8
         6:  mul r2, #0xb  ; tested instruction
         7:  mov r0, #0x1
         8:  exit
     Pre-state:
        r2:  17..29
     Post-state:
        r2:  289..319

After the tested instruction validator considers r2 to be no less than
289, however if 20 was loaded on step 1 it is possible for it after
multiplying by 11 to become 220 which is less than 289.

Fix the typo, add test.

Fixes: 8021917293d0 ("bpf: add extra validation for input BPF program")
Cc: stable@dpdk.org

Reported-by: Claudia Cauli <claudiacauli@gmail.com>
Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
Depends-on: series-38149 ("bpf: introduce extensible load API")
 app/test/test_bpf_validate.c | 17 +++++++++++++++++
 lib/bpf/bpf_validate.c       |  4 ++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/app/test/test_bpf_validate.c b/app/test/test_bpf_validate.c
index 31a235a55a..ecebfd48dd 100644
--- a/app/test/test_bpf_validate.c
+++ b/app/test/test_bpf_validate.c
@@ -1289,6 +1289,23 @@ test_alu64_div_mod_overflow(void)
 REGISTER_FAST_TEST(bpf_validate_alu64_div_mod_overflow_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_div_mod_overflow);
 
+/* 64-bit mul of small scalar range and immediate. */
+static int
+test_alu64_mul_k_range_small(void)
+{
+	return verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (EBPF_ALU64 | BPF_MUL | BPF_K),
+			.imm = 11,
+		},
+		.pre.dst = make_unsigned_domain(17, 29),
+		.post.dst = make_unsigned_domain(17 * 11, 29 * 11),
+	});
+}
+
+REGISTER_FAST_TEST(bpf_validate_alu64_mul_k_range_small_autotest, NOHUGE_OK, ASAN_OK,
+	test_alu64_mul_k_range_small);
+
 /* 64-bit negation when interval first element is INT64_MIN. */
 static int
 test_alu64_neg_int64min_first(void)
diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index b784777bbb..39c75bbcd7 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -915,7 +915,7 @@ eval_mul(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, size_t opsz,
 	/* check for overflow */
 	} else if (rd->u.max <= msk >> opsz / 2 && rs->u.max <= msk >> opsz) {
 		rd->u.max *= rs->u.max;
-		rd->u.min *= rd->u.min;
+		rd->u.min *= rs->u.min;
 	} else
 		eval_umax_bound(rd, msk);
 
@@ -926,7 +926,7 @@ eval_mul(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, size_t opsz,
 	/* check that both operands are positive and no overflow */
 	} else if (rd->s.min >= 0 && rs->s.min >= 0) {
 		rd->s.max *= rs->s.max;
-		rd->s.min *= rd->s.min;
+		rd->s.min *= rs->s.min;
 	} else
 		eval_smax_bound(rd, msk);
 }
-- 
2.43.0

