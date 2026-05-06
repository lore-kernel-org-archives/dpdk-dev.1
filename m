Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A3CCD3439
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 17:40:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED7A240C35;
	Wed,  6 May 2026 19:39:29 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 6DBB040689;
 Wed,  6 May 2026 19:39:19 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g9jKx5TC0zJ46DS;
 Thu,  7 May 2026 01:39:01 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 3866040584;
 Thu,  7 May 2026 01:39:19 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 19:39:18 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH 11/25] bpf/validate: fix BPF_NEG of INT64_MIN and 0
Date: Wed, 6 May 2026 18:38:29 +0100
Message-ID: <20260506173846.64914-12-marat.khalili@huawei.com>
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

Function `eval_neg` did not treat values of INT64_MIN and 0 specially
when calculating negation ranges (e.g.  negated unsigned range 0..2
should turn into 0..UINT64_MAX) producing incorrect results. On top of
this negating signed INT64_MIN caused undefined behaviour.

E.g. consider the following program with the current validation code:

    Tested program:
        0:  mov r0, #0x0
        1:  ldxdw r2, [r1 + 0]
        2:  lddw r4, #0x8000000000000000
        4:  jgt r2, r4, L7
        5:  neg r2, #0x0  ; tested instruction
        6:  mov r0, #0x1
        7:  exit
    Pre-state:
       r2:  0..0x8000000000000000
    Post-state:
       r2:  INT64_MIN..INT64_MIN+1 INTERSECT 0..0x8000000000000000 (!)

After the tested instruction validator considers r2 to be within
INT64_MIN..INT64_MIN+1 if viewed as signed, or within
0..0x8000000000000000 if viewed as unsigned, however if 1 was loaded on
step 1 into r2 it is possible for it to become -1 after the tested
instruction which satisfies neither of the ranges.

With sanitizer the following diagnostic is generated:

    lib/bpf/bpf_validate.c:1120:7: runtime error: negation of
    -9223372036854775808 cannot be represented in type 'long int'; cast
    to an unsigned type to negate
        #0 0x000002747230 in eval_neg lib/bpf/bpf_validate.c:1120
        #1 0x000002748fb6 in eval_alu lib/bpf/bpf_validate.c:1251
        #2 0x000002759dd3 in evaluate lib/bpf/bpf_validate.c:3161
        ...

    SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
    lib/bpf/bpf_validate.c:1120:7

Add missing handling of special cases, add tests.

Fixes: 8021917293d0 ("bpf: add extra validation for input BPF program")
Cc: stable@dpdk.org

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_bpf_validate.c | 126 +++++++++++++++++++++++++++++++++++
 lib/bpf/bpf_validate.c       |  55 ++++++++++++---
 2 files changed, 173 insertions(+), 8 deletions(-)

diff --git a/app/test/test_bpf_validate.c b/app/test/test_bpf_validate.c
index d7396a88beb8..995f7363b80f 100644
--- a/app/test/test_bpf_validate.c
+++ b/app/test/test_bpf_validate.c
@@ -1154,6 +1154,132 @@ test_alu64_add_x_scalar_scalar(void)
 REGISTER_FAST_TEST(bpf_validate_alu64_add_x_scalar_scalar_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_add_x_scalar_scalar);
 
+/* 64-bit negation when interval first element is INT64_MIN. */
+static int
+test_alu64_neg_int64min_first(void)
+{
+	static const int64_t other_values[] = {
+		INT64_MIN,
+		INT64_MIN + 1,
+		INT64_MIN + 13,
+		-17,
+		-1,
+		0,
+		1,
+		19,
+		INT64_MAX - 23,
+		INT64_MAX - 1,
+		INT64_MAX,
+	};
+	for (int other_index = 0; other_index != RTE_DIM(other_values); ++other_index) {
+		const int64_t other_value = other_values[other_index];
+		TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+			.tested_instruction = {
+				.code = (EBPF_ALU64 | BPF_NEG),
+			},
+			.pre.dst = make_signed_domain(INT64_MIN, other_value),
+			.post.dst = other_value > 0 ? unknown :
+				make_unsigned_domain(-(uint64_t)other_value, INT64_MIN),
+		}), "other_index=%d", other_index);
+	}
+	return TEST_SUCCESS;
+}
+
+REGISTER_FAST_TEST(bpf_validate_alu64_neg_int64min_first_autotest, NOHUGE_OK, ASAN_OK,
+	test_alu64_neg_int64min_first);
+
+/* 64-bit negation when interval last element is INT64_MIN. */
+static int
+test_alu64_neg_int64min_last(void)
+{
+	static const uint64_t other_values[] = {
+		0,
+		1,
+		19,
+		INT64_MAX - 23,
+		INT64_MAX - 1,
+		INT64_MAX,
+		INT64_MIN,
+	};
+	for (int other_index = 0; other_index != RTE_DIM(other_values); ++other_index) {
+		const int64_t other_value = other_values[other_index];
+		TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+			.tested_instruction = {
+				.code = (EBPF_ALU64 | BPF_NEG),
+			},
+			.pre.dst = make_unsigned_domain(other_value, INT64_MIN),
+			.post.dst = make_signed_domain(INT64_MIN, -(uint64_t)other_value),
+		}), "other_index=%d", other_index);
+	}
+	return TEST_SUCCESS;
+}
+
+REGISTER_FAST_TEST(bpf_validate_alu64_neg_int64min_last_autotest, NOHUGE_OK, ASAN_OK,
+	test_alu64_neg_int64min_last);
+
+/* 64-bit negation when interval first element is zero. */
+static int
+test_alu64_neg_zero_first(void)
+{
+	static const uint64_t other_values[] = {
+		0,
+		1,
+		19,
+		INT64_MAX - 23,
+		INT64_MAX - 1,
+		INT64_MAX,
+		INT64_MIN,
+		INT64_MIN + 1,
+		INT64_MIN + 13,
+		-17,
+		-1,
+	};
+	for (int other_index = 0; other_index != RTE_DIM(other_values); ++other_index) {
+		const uint64_t other_value = other_values[other_index];
+		TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+			.tested_instruction = {
+				.code = (EBPF_ALU64 | BPF_NEG),
+			},
+			.pre.dst = make_unsigned_domain(0, other_value),
+			.post.dst = other_value > (uint64_t)INT64_MIN ? unknown :
+				make_signed_domain(-(uint64_t)other_value, 0),
+		}), "other_index=%d", other_index);
+	}
+	return TEST_SUCCESS;
+}
+
+REGISTER_FAST_TEST(bpf_validate_alu64_neg_zero_first_autotest, NOHUGE_OK, ASAN_OK,
+	test_alu64_neg_zero_first);
+
+/* 64-bit negation when interval last element is zero. */
+static int
+test_alu64_neg_zero_last(void)
+{
+	static const int64_t other_values[] = {
+		INT64_MIN,
+		INT64_MIN + 1,
+		INT64_MIN + 13,
+		-17,
+		-1,
+		0,
+	};
+	for (int other_index = 0; other_index != RTE_DIM(other_values); ++other_index) {
+		const int64_t other_value = other_values[other_index];
+		TEST_ASSERT_SUCCESS(verify_instruction((struct verify_instruction_param){
+			.tested_instruction = {
+				.code = (EBPF_ALU64 | BPF_NEG),
+			},
+			.pre.dst = make_signed_domain(other_value, 0),
+			.post.dst = make_unsigned_domain(0, -(uint64_t)other_value),
+		}), "other_index=%d", other_index);
+	}
+
+	return TEST_SUCCESS;
+}
+
+REGISTER_FAST_TEST(bpf_validate_alu64_neg_zero_last_autotest, NOHUGE_OK, ASAN_OK,
+	test_alu64_neg_zero_last);
+
 /* Jump if greater than immediate. */
 static int
 test_jmp64_jeq_k(void)
diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index b0d88fe7d273..79c8679ac535 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -990,6 +990,11 @@ eval_neg(struct bpf_reg_val *rd, size_t opsz, uint64_t msk)
 {
 	uint64_t ux, uy;
 	int64_t sx, sy;
+	/* additional limits imposed by signed on unsigned and back */
+	struct bpf_reg_val cross_limits = {
+		.s = { INT64_MIN, INT64_MAX },
+		.u = { 0, UINT64_MAX },
+	};
 
 	/* if we have 32-bit values - extend them to 64-bit */
 	if (opsz == sizeof(uint32_t) * CHAR_BIT) {
@@ -997,11 +1002,29 @@ eval_neg(struct bpf_reg_val *rd, size_t opsz, uint64_t msk)
 		rd->u.max = (int32_t)rd->u.max;
 	}
 
-	ux = -(int64_t)rd->u.min & msk;
-	uy = -(int64_t)rd->u.max & msk;
+	if (rd->u.min == 0) {
+		/* special case: ranges that include 0 and, possibly, 1 */
+
+		/*
+		 * Calculate requirements on the signed range of negation.
+		 * It is only possible when negated range does not cross from
+		 * INT64_MIN to INT64_MAX, which means our original range does
+		 * not reach (uint64_t)-INT64_MAX.
+		 */
+		if (rd->u.max < (uint64_t)-INT64_MAX) {
+			cross_limits.s.min = -rd->u.max;
+			cross_limits.s.max = -rd->u.min;
+		}
+
+		if (rd->u.max != 0)
+			rd->u.max = UINT64_MAX;
+	} else {
+		ux = -rd->u.min & msk;
+		uy = -rd->u.max & msk;
 
-	rd->u.max = RTE_MAX(ux, uy);
-	rd->u.min = RTE_MIN(ux, uy);
+		rd->u.max = RTE_MAX(ux, uy);
+		rd->u.min = RTE_MIN(ux, uy);
+	}
 
 	/* if we have 32-bit values - extend them to 64-bit */
 	if (opsz == sizeof(uint32_t) * CHAR_BIT) {
@@ -1009,11 +1032,27 @@ eval_neg(struct bpf_reg_val *rd, size_t opsz, uint64_t msk)
 		rd->s.max = (int32_t)rd->s.max;
 	}
 
-	sx = -rd->s.min & msk;
-	sy = -rd->s.max & msk;
+	if (rd->s.min == INT64_MIN) {
+		/* special case: negation of INT64_MIN is INT64_MIN */
+		if (rd->s.max <= 0) {
+			cross_limits.u.min = -(uint64_t)rd->s.max;
+			cross_limits.u.max = -(uint64_t)rd->s.min;
+		}
+		if (rd->s.max != INT64_MIN)
+			rd->s.max = INT64_MAX;
+	} else {
+		/* since max >= min, neither can be INT64_MIN here */
+		sx = -rd->s.min & msk;
+		sy = -rd->s.max & msk;
+
+		rd->s.max = RTE_MAX(sx, sy);
+		rd->s.min = RTE_MIN(sx, sy);
+	}
 
-	rd->s.max = RTE_MAX(sx, sy);
-	rd->s.min = RTE_MIN(sx, sy);
+	rd->s.min = RTE_MAX(rd->s.min, cross_limits.s.min) & msk;
+	rd->s.max = RTE_MIN(rd->s.max, cross_limits.s.max) & msk;
+	rd->u.min = RTE_MAX(rd->u.min, cross_limits.u.min) & msk;
+	rd->u.max = RTE_MIN(rd->u.max, cross_limits.u.max) & msk;
 }
 
 static const char *
-- 
2.43.0

