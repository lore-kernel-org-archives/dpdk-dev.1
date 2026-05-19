Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836CFCD4851
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 09:34:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5844640E31;
	Tue, 19 May 2026 11:32:21 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 529DD4067E;
 Tue, 19 May 2026 11:32:01 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gKTvb4tk2zHnHCh;
 Tue, 19 May 2026 17:31:39 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 2F97B40569;
 Tue, 19 May 2026 17:32:01 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 May 2026 11:32:00 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Claudia Cauli <claudiacauli@gmail.com>
Subject: [PATCH v2 22/25] bpf/validate: fix BPF_XOR signed min calculation
Date: Tue, 19 May 2026 10:31:25 +0100
Message-ID: <20260519093131.52022-23-marat.khalili@huawei.com>
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

Function `eval_xor` calculated signed minimum using essentially unsigned
algorithm as long as any of the operands have non-negative range, which
is incorrect since it ignores any negative numbers that may have the
sign or any other bits set.

E.g. consider the following program with the current validation code:

    Tested program:
        0:  mov r0, #0x0
        1:  ldxdw r2, [r1 + 0]
        2:  jsgt r2, #0x0, L5
        3:  xor r2, #0x0  ; tested instruction
        4:  mov r0, #0x1
        5:  exit
    Pre-state:
       r2:  INT64_MIN..0
    Post-state:
       r2:  0

After the tested instruction validator considers r2 to equal 0, however
if -1 was loaded on step 1 it is possible for it to be -1.

Set signed range to full if any of the operands can be negative,
otherwise (if both operands are non-negative) use same algorithm as for
unsigned numbers. Add test.

Fixes: 8021917293d0 ("bpf: add extra validation for input BPF program")
Cc: stable@dpdk.org

Reported-by: Claudia Cauli <claudiacauli@gmail.com>
Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
Depends-on: series-38149 ("bpf: introduce extensible load API")
 app/test/test_bpf_validate.c | 17 +++++++++++++++++
 lib/bpf/bpf_validate.c       |  2 +-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/app/test/test_bpf_validate.c b/app/test/test_bpf_validate.c
index 205373a4f8..a06d3254d6 100644
--- a/app/test/test_bpf_validate.c
+++ b/app/test/test_bpf_validate.c
@@ -1764,6 +1764,23 @@ test_alu64_sub_x_src_signed_max_zero(void)
 REGISTER_FAST_TEST(bpf_validate_alu64_sub_x_src_signed_max_zero_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_sub_x_src_signed_max_zero);
 
+/* 64-bit bitwise XOR between a negative scalar range and zero immediate. */
+static int
+test_alu64_xor_k_negative(void)
+{
+	return verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (EBPF_ALU64 | BPF_XOR | BPF_K),
+			.imm = 0,
+		},
+		.pre.dst = make_signed_domain(INT64_MIN, 0),
+		.post.dst = unknown,
+	});
+}
+
+REGISTER_FAST_TEST(bpf_validate_alu64_xor_k_negative_autotest, NOHUGE_OK, ASAN_OK,
+	test_alu64_xor_k_negative);
+
 /* Jump if greater than immediate. */
 static int
 test_jmp64_jeq_k(void)
diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index a500ad662c..35b7d4ad83 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -910,7 +910,7 @@ eval_xor(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, size_t opsz,
 		rd->s.max ^= rs->s.max;
 
 	/* both operands are non-negative */
-	} else if (rd->s.min >= 0 || rs->s.min >= 0) {
+	} else if (rd->s.min >= 0 && rs->s.min >= 0) {
 		rd->s.max = eval_uor_max(rd->s.max, rs->s.max, opsz);
 		rd->s.min = 0;
 	} else
-- 
2.43.0

