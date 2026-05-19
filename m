Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D12BCD4851
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 09:34:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 458FC40E2D;
	Tue, 19 May 2026 11:32:20 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id D99864067A;
 Tue, 19 May 2026 11:32:00 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gKTvb1jZ5zHnHCZ;
 Tue, 19 May 2026 17:31:39 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id B7B1840570;
 Tue, 19 May 2026 17:32:00 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 May 2026 11:32:00 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Claudia Cauli <claudiacauli@gmail.com>
Subject: [PATCH v2 21/25] bpf/validate: fix BPF_SUB signed max zero case
Date: Tue, 19 May 2026 10:31:24 +0100
Message-ID: <20260519093131.52022-22-marat.khalili@huawei.com>
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

Function `eval_sub` used source register signed minimum to detect
overflow of the difference (operation result) signed minimum, and source
register signed maximum to detect overflow of the difference signed
maximum. However in the actual formula for difference source register
bounds are swapped (correctly, since we subtract it), so in overflow
detection we should also have swapped them. It caused false negatives in
certain cases.

E.g. consider the following program with the current validation code:

    Tested program:
        0:  mov r0, #0x0
        1:  ldxdw r2, [r1 + 0]
        2:  jsgt r2, #0x0, L7
        3:  ldxdw r3, [r1 + 8]
        4:  jsgt r3, #0x0, L7
        5:  sub r2, r3  ; tested instruction
        6:  mov r0, #0x1
        7:  exit
    Pre-state:
       r2:  INT64_MIN..0
       r3:  INT64_MIN..0
    Post-state:
       r2:  INT64_MIN

Validator ignores overflow of signed minimum and considers result to
always equal INT64_MIN. However, if -1 was loaded on step 1 and -2 was
loaded on step 3 it is possible for the difference to equal 1.

Swap source register signed minimum and maximum in the overflow
condition to match the new range formula, add test.

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
index 7cf9e404b6..205373a4f8 100644
--- a/app/test/test_bpf_validate.c
+++ b/app/test/test_bpf_validate.c
@@ -1747,6 +1747,23 @@ test_alu64_or_k_positive(void)
 REGISTER_FAST_TEST(bpf_validate_alu64_or_k_positive_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_or_k_positive);
 
+/* 64-bit difference between two negative ranges.. */
+static int
+test_alu64_sub_x_src_signed_max_zero(void)
+{
+	return verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (EBPF_ALU64 | BPF_SUB | BPF_X),
+		},
+		.pre.dst = make_signed_domain(INT64_MIN, 0),
+		.pre.src = make_signed_domain(INT64_MIN, 0),
+		.post.dst = unknown,
+	});
+}
+
+REGISTER_FAST_TEST(bpf_validate_alu64_sub_x_src_signed_max_zero_autotest, NOHUGE_OK, ASAN_OK,
+	test_alu64_sub_x_src_signed_max_zero);
+
 /* Jump if greater than immediate. */
 static int
 test_jmp64_jeq_k(void)
diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index d9ee0563c9..a500ad662c 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -716,9 +716,9 @@ eval_sub(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, uint64_t msk)
 		eval_umax_bound(&rv, msk);
 
 	if ((rd->s.min != rd->s.max || rs->s.min != rs->s.max) &&
-			(((rs->s.min < 0 && rv.s.min < rd->s.min) ||
+			(((rs->s.max < 0 && rv.s.min < rd->s.min) ||
 			rv.s.min > rd->s.min) ||
-			((rs->s.max < 0 && rv.s.max < rd->s.max) ||
+			((rs->s.min < 0 && rv.s.max < rd->s.max) ||
 			rv.s.max > rd->s.max)))
 		eval_smax_bound(&rv, msk);
 
-- 
2.43.0

