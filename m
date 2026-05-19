Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6987DCD4851
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 09:33:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54C0940DCF;
	Tue, 19 May 2026 11:32:14 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 7A4004066B;
 Tue, 19 May 2026 11:31:59 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gKTvY67BPzHnH5N;
 Tue, 19 May 2026 17:31:37 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 5B1C540570;
 Tue, 19 May 2026 17:31:59 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 May 2026 11:31:59 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Claudia Cauli <claudiacauli@gmail.com>
Subject: [PATCH v2 18/25] bpf/validate: fix BPF_AND min calculations
Date: Tue, 19 May 2026 10:31:21 +0100
Message-ID: <20260519093131.52022-19-marat.khalili@huawei.com>
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

Function `eval_and` calculated both signed (if positive) and unsigned
minimum values as bitwise AND between corresponding minimums, which is
incorrect since intermediate values can have zeroes in bits where
minimum values don't.

E.g. consider the following program with the current validation code:

    Tested program:
        0:  mov r0, #0x0
        1:  ldxdw r2, [r1 + 0]
        2:  jlt r2, #0x6, L8
        3:  jgt r2, #0x8, L8
        4:  jslt r2, #0x6, L8
        5:  jsgt r2, #0x8, L8
        6:  and r2, #0x5  ; tested instruction
        7:  mov r0, #0x1
        8:  exit
    Pre-state:
       r2:  6..8
    Post-state:
       r2:  4..7

After the tested instruction validator considers r2 to be equal or
greater than 4, however if 8 was loaded on step 1 it is possible for it
to be zero (0x8 & 0x5 == 0).

Use zero as a new safe lower bound for both signed (if positive) and
unsigned minimum. Add test.

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
index f80dee24a6..5d26299ba6 100644
--- a/app/test/test_bpf_validate.c
+++ b/app/test/test_bpf_validate.c
@@ -1384,6 +1384,23 @@ test_alu64_add_x_scalar_scalar(void)
 REGISTER_FAST_TEST(bpf_validate_alu64_add_x_scalar_scalar_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_add_x_scalar_scalar);
 
+/* 64-bit bitwise AND between a scalar range and immediate. */
+static int
+test_alu64_and_k(void)
+{
+	return verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (EBPF_ALU64 | BPF_AND | BPF_K),
+			.imm = 5,
+		},
+		.pre.dst = make_signed_domain(6, 8),
+		.post.dst = make_signed_domain(0, 7),
+	});
+}
+
+REGISTER_FAST_TEST(bpf_validate_alu64_and_k_autotest, NOHUGE_OK, ASAN_OK,
+	test_alu64_and_k);
+
 /* 64-bit division and modulo of UINT64_MAX*2/3. */
 static int
 test_alu64_div_mod_big_constant(void)
diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index fbae70df92..4dbf3a3ef8 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -848,7 +848,7 @@ eval_and(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, size_t opsz,
 		rd->u.max &= rs->u.max;
 	} else {
 		rd->u.max = eval_uand_max(rd->u.max, rs->u.max, opsz);
-		rd->u.min &= rs->u.min;
+		rd->u.min = 0;
 	}
 
 	/* both operands are constants */
@@ -859,7 +859,7 @@ eval_and(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, size_t opsz,
 	} else if (rd->s.min >= 0 || rs->s.min >= 0) {
 		rd->s.max = eval_uand_max(rd->s.max & (msk >> 1),
 			rs->s.max & (msk >> 1), opsz);
-		rd->s.min &= rs->s.min;
+		rd->s.min = 0;
 	} else
 		eval_smax_bound(rd, msk);
 }
-- 
2.43.0

