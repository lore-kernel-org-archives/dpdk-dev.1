Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74686CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 09:33:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB7944066B;
	Tue, 19 May 2026 11:32:16 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 6EFA740672;
 Tue, 19 May 2026 11:32:00 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gKTvF6qCGzJ46gQ;
 Tue, 19 May 2026 17:31:21 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 4704440569;
 Tue, 19 May 2026 17:32:00 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 May 2026 11:31:59 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Claudia Cauli <claudiacauli@gmail.com>
Subject: [PATCH v2 20/25] bpf/validate: fix BPF_OR min calculations
Date: Tue, 19 May 2026 10:31:23 +0100
Message-ID: <20260519093131.52022-21-marat.khalili@huawei.com>
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

This commit fixes two different problems in signed and unsigned minimum
calculations within `eval_or`. Passing tests requires both problems to
be fixed which is why the changes are squashed in one commit.

1) Function `eval_or` calculated result signed minimum as bitwise OR
between corresponding minimums as long as any of them is non-negative,
which is incorrect since values within the range can have zeroes where
the minimums don't, including the sign bit.

E.g. consider the following program with the current validation code:

    Tested program:
        0:  mov r0, #0x0
        1:  ldxdw r2, [r1 + 0]
        2:  jlt r2, #0x5, L8
        3:  jgt r2, #0x6, L8
        4:  jslt r2, #0x5, L8
        5:  jsgt r2, #0x6, L8
        6:  or r2, #0xfffffffe  ; tested instruction
        7:  mov r0, #0x1
        8:  exit
    Pre-state:
       r2:  5..6
    Post-state:
       r2:  -1

After the tested instruction validator considers r2 to always equal -1,
however if 6 was loaded on step 1 it is possible for it to be -2:

     0x6 & 0xfffffffffffffffe == 0xfffffffffffffffe = -2

Set signed range to full if any of the operands can be negative,
otherwise use the maximum of both minimums as a new signed minimum
following the idea that result of bitwise OR cannot be smaller than its
operands. Add test.

2) Function `eval_or` calculated result unsigned minimum as bitwise OR
between corresponding minimums, which is incorrect since values within
the range can have zeroes the minimums don't.

E.g. consider the following program with the current validation code:

    Tested program:
        0:  mov r0, #0x0
        1:  ldxdw r2, [r1 + 0]
        2:  jlt r2, #0x5, L8
        3:  jgt r2, #0x6, L8
        4:  jslt r2, #0x5, L8
        5:  jsgt r2, #0x6, L8
        6:  or r2, #0x2  ; tested instruction
        7:  mov r0, #0x1
        8:  exit
    Pre-state:
       r2:  5..6
    Post-state:
       r2:  7

After the tested instruction validator considers r2 to always equal 7,
however if 6 was loaded on step 1 it is possible for it to be 6:

    0x6 & 0x2 == 0x6

Use the maximum of both minimums as a new unsigned minimum following the
idea that result of bitwise OR cannot be smaller than its operands. Add
test.

Fixes: 8021917293d0 ("bpf: add extra validation for input BPF program")
Cc: stable@dpdk.org

Reported-by: Claudia Cauli <claudiacauli@gmail.com>
Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
Depends-on: series-38149 ("bpf: introduce extensible load API")
 app/test/test_bpf_validate.c | 34 ++++++++++++++++++++++++++++++++++
 lib/bpf/bpf_validate.c       |  6 +++---
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/app/test/test_bpf_validate.c b/app/test/test_bpf_validate.c
index c3d1bdb78f..7cf9e404b6 100644
--- a/app/test/test_bpf_validate.c
+++ b/app/test/test_bpf_validate.c
@@ -1713,6 +1713,40 @@ test_alu64_neg_zero_last(void)
 REGISTER_FAST_TEST(bpf_validate_alu64_neg_zero_last_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_neg_zero_last);
 
+/* 64-bit bitwise OR between a positive scalar range and negative immediate. */
+static int
+test_alu64_or_k_negative(void)
+{
+	return verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (EBPF_ALU64 | BPF_OR | BPF_K),
+			.imm = -2,
+		},
+		.pre.dst = make_signed_domain(5, 6),
+		.post.dst = make_signed_domain(-2, -1),
+	});
+}
+
+REGISTER_FAST_TEST(bpf_validate_alu64_or_k_negative_autotest, NOHUGE_OK, ASAN_OK,
+	test_alu64_or_k_negative);
+
+/* 64-bit bitwise OR between a positive scalar range and positive immediate. */
+static int
+test_alu64_or_k_positive(void)
+{
+	return verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (EBPF_ALU64 | BPF_OR | BPF_K),
+			.imm = 2,
+		},
+		.pre.dst = make_signed_domain(5, 6),
+		.post.dst = make_signed_domain(5, 7),
+	});
+}
+
+REGISTER_FAST_TEST(bpf_validate_alu64_or_k_positive_autotest, NOHUGE_OK, ASAN_OK,
+	test_alu64_or_k_positive);
+
 /* Jump if greater than immediate. */
 static int
 test_jmp64_jeq_k(void)
diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index 2c61e5d96a..d9ee0563c9 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -875,7 +875,7 @@ eval_or(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, size_t opsz,
 		rd->u.max |= rs->u.max;
 	} else {
 		rd->u.max = eval_uor_max(rd->u.max, rs->u.max, opsz);
-		rd->u.min |= rs->u.min;
+		rd->u.min = RTE_MAX(rd->u.min, rs->u.min);
 	}
 
 	/* both operands are constants */
@@ -884,9 +884,9 @@ eval_or(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, size_t opsz,
 		rd->s.max |= rs->s.max;
 
 	/* both operands are non-negative */
-	} else if (rd->s.min >= 0 || rs->s.min >= 0) {
+	} else if (rd->s.min >= 0 && rs->s.min >= 0) {
 		rd->s.max = eval_uor_max(rd->s.max, rs->s.max, opsz);
-		rd->s.min |= rs->s.min;
+		rd->s.min = RTE_MAX(rd->s.min, rs->s.min);
 	} else
 		eval_smax_bound(rd, msk);
 }
-- 
2.43.0

