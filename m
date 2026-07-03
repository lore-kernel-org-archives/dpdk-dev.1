Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C9BC43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 15:29:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 839FC4026F;
	Fri,  3 Jul 2026 17:29:33 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 95A8C4003C
 for <dev@dpdk.org>; Fri,  3 Jul 2026 17:29:32 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gsHhk31GczJ467Y;
 Fri,  3 Jul 2026 23:28:38 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 23A6440584;
 Fri,  3 Jul 2026 23:29:30 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 3 Jul 2026 17:29:29 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>
Subject: [PATCH] test/bpf_validate: use unit_test_suite_runner
Date: Fri, 3 Jul 2026 16:29:09 +0100
Message-ID: <20260703152910.80285-1-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100002.china.huawei.com (7.182.19.63) To
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

Due to github CI running out of tmpfs space after adding 29 new BPF
validate tests they were temporarily disabled. Restore them as a single
test using unit_test_suite_runner.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_bpf_validate.c | 130 ++++++++++++-----------------------
 1 file changed, 44 insertions(+), 86 deletions(-)

diff --git a/app/test/test_bpf_validate.c b/app/test/test_bpf_validate.c
index 7181303f3ee4..066f1fa156ae 100644
--- a/app/test/test_bpf_validate.c
+++ b/app/test/test_bpf_validate.c
@@ -1291,9 +1291,6 @@ test_alu64_add_k(void)
 	});
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_alu64_add_k_autotest,
-	test_alu64_add_k);
-
 /* 64-bit addition of immediate to a pointer range. */
 static int
 test_alu64_add_k_pointer(void)
@@ -1309,9 +1306,6 @@ test_alu64_add_k_pointer(void)
 	});
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_alu64_add_k_pointer_autotest,
-	test_alu64_add_k_pointer);
-
 /* 64-bit addition of pointer to a pointer. */
 static int
 test_alu64_add_x_pointer_pointer(void)
@@ -1327,9 +1321,6 @@ test_alu64_add_x_pointer_pointer(void)
 	});
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_alu64_add_x_pointer_pointer_autotest,
-	test_alu64_add_x_pointer_pointer);
-
 /* 64-bit addition of scalar to a pointer. */
 static int
 test_alu64_add_x_pointer_scalar(void)
@@ -1345,9 +1336,6 @@ test_alu64_add_x_pointer_scalar(void)
 	});
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_alu64_add_x_pointer_scalar_autotest,
-	test_alu64_add_x_pointer_scalar);
-
 /* 64-bit addition of pointer to a scalar. */
 static int
 test_alu64_add_x_scalar_pointer(void)
@@ -1363,9 +1351,6 @@ test_alu64_add_x_scalar_pointer(void)
 	});
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_alu64_add_x_scalar_pointer_autotest,
-	test_alu64_add_x_scalar_pointer);
-
 /* 64-bit addition of scalar to a scalar. */
 static int
 test_alu64_add_x_scalar_scalar(void)
@@ -1381,9 +1366,6 @@ test_alu64_add_x_scalar_scalar(void)
 	});
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_alu64_add_x_scalar_scalar_autotest,
-	test_alu64_add_x_scalar_scalar);
-
 /* 64-bit bitwise AND between a scalar range and immediate. */
 static int
 test_alu64_and_k(void)
@@ -1398,9 +1380,6 @@ test_alu64_and_k(void)
 	});
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_alu64_and_k_autotest,
-	test_alu64_and_k);
-
 /* 64-bit division and modulo of UINT64_MAX*2/3. */
 static int
 test_alu64_div_mod_big_constant(void)
@@ -1442,9 +1421,6 @@ test_alu64_div_mod_big_constant(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_alu64_div_mod_big_constant_autotest,
-	test_alu64_div_mod_big_constant);
-
 /* 64-bit division and modulo of UINT64_MAX/3..UINT64_MAX*2/3 by a constant. */
 static int
 test_alu64_div_mod_big_range(void)
@@ -1487,9 +1463,6 @@ test_alu64_div_mod_big_range(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_alu64_div_mod_big_range_autotest,
-	test_alu64_div_mod_big_range);
-
 /* 64-bit division and modulo of INT64_MIN by -1. */
 static int
 test_alu64_div_mod_overflow(void)
@@ -1533,9 +1506,6 @@ test_alu64_div_mod_overflow(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_alu64_div_mod_overflow_autotest,
-	test_alu64_div_mod_overflow);
-
 /* 64-bit left shift by 63. */
 static int
 test_alu64_lsh_63(void)
@@ -1550,9 +1520,6 @@ test_alu64_lsh_63(void)
 	});
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_alu64_lsh_63_autotest,
-	test_alu64_lsh_63);
-
 /* 64-bit multiplication of constant and immediate with overflow. */
 static int
 test_alu64_mul_k_overflow(void)
@@ -1567,9 +1534,6 @@ test_alu64_mul_k_overflow(void)
 	});
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_alu64_mul_k_overflow_autotest,
-	test_alu64_mul_k_overflow);
-
 /* 64-bit mul of small scalar range and immediate. */
 static int
 test_alu64_mul_k_range_small(void)
@@ -1584,9 +1548,6 @@ test_alu64_mul_k_range_small(void)
 	});
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_alu64_mul_k_range_small_autotest,
-	test_alu64_mul_k_range_small);
-
 /* 64-bit negation when interval first element is INT64_MIN. */
 static int
 test_alu64_neg_int64min_first(void)
@@ -1618,9 +1579,6 @@ test_alu64_neg_int64min_first(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_alu64_neg_int64min_first_autotest,
-	test_alu64_neg_int64min_first);
-
 /* 64-bit negation when interval last element is INT64_MIN. */
 static int
 test_alu64_neg_int64min_last(void)
@@ -1647,9 +1605,6 @@ test_alu64_neg_int64min_last(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_alu64_neg_int64min_last_autotest,
-	test_alu64_neg_int64min_last);
-
 /* 64-bit negation when interval first element is zero. */
 static int
 test_alu64_neg_zero_first(void)
@@ -1681,9 +1636,6 @@ test_alu64_neg_zero_first(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_alu64_neg_zero_first_autotest,
-	test_alu64_neg_zero_first);
-
 /* 64-bit negation when interval last element is zero. */
 static int
 test_alu64_neg_zero_last(void)
@@ -1710,9 +1662,6 @@ test_alu64_neg_zero_last(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_alu64_neg_zero_last_autotest,
-	test_alu64_neg_zero_last);
-
 /* 64-bit bitwise OR between a positive scalar range and negative immediate. */
 static int
 test_alu64_or_k_negative(void)
@@ -1727,9 +1676,6 @@ test_alu64_or_k_negative(void)
 	});
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_alu64_or_k_negative_autotest,
-	test_alu64_or_k_negative);
-
 /* 64-bit bitwise OR between a positive scalar range and positive immediate. */
 static int
 test_alu64_or_k_positive(void)
@@ -1744,9 +1690,6 @@ test_alu64_or_k_positive(void)
 	});
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_alu64_or_k_positive_autotest,
-	test_alu64_or_k_positive);
-
 /* 64-bit difference between two negative ranges.. */
 static int
 test_alu64_sub_x_src_signed_max_zero(void)
@@ -1761,9 +1704,6 @@ test_alu64_sub_x_src_signed_max_zero(void)
 	});
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_alu64_sub_x_src_signed_max_zero_autotest,
-	test_alu64_sub_x_src_signed_max_zero);
-
 /* 64-bit bitwise XOR between a negative scalar range and zero immediate. */
 static int
 test_alu64_xor_k_negative(void)
@@ -1778,9 +1718,6 @@ test_alu64_xor_k_negative(void)
 	});
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_alu64_xor_k_negative_autotest,
-	test_alu64_xor_k_negative);
-
 /* Jump if greater than immediate. */
 static int
 test_jmp64_jeq_k(void)
@@ -1796,9 +1733,6 @@ test_jmp64_jeq_k(void)
 	});
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_jmp64_jeq_k_autotest,
-	test_jmp64_jeq_k);
-
 /* Jump if signed less than another register. */
 static int
 test_jmp64_jslt_x(void)
@@ -1814,9 +1748,6 @@ test_jmp64_jslt_x(void)
 	});
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_jmp64_jslt_x_autotest,
-	test_jmp64_jslt_x);
-
 /* Jump on ordering comparisons with potential bound overflow. */
 static int
 test_jmp64_ordering_overflow(void)
@@ -1863,9 +1794,6 @@ test_jmp64_ordering_overflow(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_jmp64_ordering_overflow_autotest,
-	test_jmp64_ordering_overflow);
-
 /* Jump on ordering comparisons between two ranges. */
 static int
 test_jmp64_ordering_ranges(void)
@@ -2022,9 +1950,6 @@ test_jmp64_ordering_ranges(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_jmp64_ordering_ranges_autotest,
-	test_jmp64_ordering_ranges);
-
 /* Jump on ordering comparisons with singleton inside the range. */
 static int
 test_jmp64_ordering_singleton_inside(void)
@@ -2080,9 +2005,6 @@ test_jmp64_ordering_singleton_inside(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_jmp64_ordering_singleton_inside_autotest,
-	test_jmp64_ordering_singleton_inside);
-
 /* Jump on ordering comparisons with singleton outside the range. */
 static int
 test_jmp64_ordering_singleton_outside(void)
@@ -2175,9 +2097,6 @@ test_jmp64_ordering_singleton_outside(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_jmp64_ordering_singleton_outside_autotest,
-	test_jmp64_ordering_singleton_outside);
-
 /* Jump on ordering comparisons with ranges "touching" each other. */
 static int
 test_jmp64_ordering_touching(void)
@@ -2249,9 +2168,6 @@ test_jmp64_ordering_touching(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_jmp64_ordering_touching_autotest,
-	test_jmp64_ordering_touching);
-
 /* 64-bit load from heap (should be set to unknown). */
 static int
 test_mem_ldx_dw_heap(void)
@@ -2267,5 +2183,47 @@ test_mem_ldx_dw_heap(void)
 	});
 }
 
-REGISTER_ATTIC_TEST(bpf_validate_mem_ldx_dw_heap_autotest,
-	test_mem_ldx_dw_heap);
+static struct
+unit_test_suite test_bpf_validate_suite  = {
+	.suite_name = "Test BPF Validate Unit Test Suite",
+	.unit_test_cases = {
+		TEST_CASE(test_alu64_add_k),
+		TEST_CASE(test_alu64_add_k_pointer),
+		TEST_CASE(test_alu64_add_x_pointer_pointer),
+		TEST_CASE(test_alu64_add_x_pointer_scalar),
+		TEST_CASE(test_alu64_add_x_scalar_pointer),
+		TEST_CASE(test_alu64_add_x_scalar_scalar),
+		TEST_CASE(test_alu64_and_k),
+		TEST_CASE(test_alu64_div_mod_big_constant),
+		TEST_CASE(test_alu64_div_mod_big_range),
+		TEST_CASE(test_alu64_div_mod_overflow),
+		TEST_CASE(test_alu64_lsh_63),
+		TEST_CASE(test_alu64_mul_k_overflow),
+		TEST_CASE(test_alu64_mul_k_range_small),
+		TEST_CASE(test_alu64_neg_int64min_first),
+		TEST_CASE(test_alu64_neg_int64min_last),
+		TEST_CASE(test_alu64_neg_zero_first),
+		TEST_CASE(test_alu64_neg_zero_last),
+		TEST_CASE(test_alu64_or_k_negative),
+		TEST_CASE(test_alu64_or_k_positive),
+		TEST_CASE(test_alu64_sub_x_src_signed_max_zero),
+		TEST_CASE(test_alu64_xor_k_negative),
+		TEST_CASE(test_jmp64_jeq_k),
+		TEST_CASE(test_jmp64_jslt_x),
+		TEST_CASE(test_jmp64_ordering_overflow),
+		TEST_CASE(test_jmp64_ordering_ranges),
+		TEST_CASE(test_jmp64_ordering_singleton_inside),
+		TEST_CASE(test_jmp64_ordering_singleton_outside),
+		TEST_CASE(test_jmp64_ordering_touching),
+		TEST_CASE(test_mem_ldx_dw_heap),
+		TEST_CASES_END()
+	}
+};
+
+static int
+test_bpf_validate(void)
+{
+	return unit_test_suite_runner(&test_bpf_validate_suite);
+}
+
+REGISTER_FAST_TEST(bpf_validate_autotest, NOHUGE_OK, ASAN_OK, test_bpf_validate);
-- 
2.43.0

