Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4B8C43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 02:28:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D52FB40291;
	Fri,  3 Jul 2026 04:28:21 +0200 (CEST)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id 842C040288
 for <dev@dpdk.org>; Fri,  3 Jul 2026 04:28:20 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 654431D000B7;
 Thu,  2 Jul 2026 22:28:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 02 Jul 2026 22:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1783045699; x=1783132099; bh=QOhT35Ni3SmWyAOTIALPY
 YUobQD9K/mc4D188Bg9+t0=; b=mRH38fELfK451paoiOBu7L2V+W7HpKGZPuGsH
 aq4Op2fc3Ngh5Xg9u97YRCaYQF9kRyvNZ8HTQs0aFodYccOkaMDeMCOPl1CVDYPg
 EGNmV5UlrFdYGeqietS8R9j405CPozY0YLT5zzLTj0Z6WEkuWddFDk/M/ZHUCikR
 B1nazf+2jIO9dHEBp1Jd1PqP4oJS1GBQZmEIUtfAs0yzVaIv187hB6zsZFmH/9C3
 oPpqXsP5hIMtstCrnwhZhXm0Shfm3llUl6KTD2KY2/4WkUDsMZTu6SUnzNDOnrS9
 +9CKsPL/YbUhyk0wgm3A2X18ILp1bw4BqaKdCYtxnVa8gOAlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1783045699; x=1783132099; bh=QOhT35Ni3SmWyAOTIALPYYUobQD9K/mc4D1
 88Bg9+t0=; b=dHLY7W2amYqKA5oxdKiL3JBGzRSaf3vx2ww4PTdZ1WPvic6LmLh
 O8wdGU6zqWe+XsiY01DtMHdD8p3PiRYsf6DaIOjOZQi1OdNMUp9DuQc7aMBn83O7
 5opO/bceUdkPx+CXC5OEVKEMPhjsrK1jKUxlllcCITtm+ZAViJE9dxY2j4RpRW4f
 NSl1YgFD1abh+zcmzZi0N0GoZcz268wa77+4dv1mxM4fb8By9u2Qk7eel6Oey7Mz
 pAG/pd8mMhFSDhwg5eqZi6WtnhYJhxSu4PzFMQYUsMedFctYZBr8ZqhI55f2P2JM
 1Vs2pwVDW4KF/61EDdTBliXY0mBgxAPkr6w==
X-ME-Sender: <xms:Qh5Haui-uzDnJwSt4g7ixXWE30vkQDIwkRs2IYBpHUlruKpFTikF8w>
 <xme:Qh5HajWk7DgcZKR7paiKgG1dlYStTnMZYQDF7LcXlHRYw3Hf_Y_7Uf_hjKpbIWHvx
 WZq1oiNZEBi7qnMnjY2X8bJHU9iYE3h1O5KMSvuWWEf-XcU954NEQ>
X-ME-Received: <xmr:Qh5HalM7ugoYOEWvxVT4xc7CddCcV1RgqIKqiqdAKyqLHYRLwlGGbDXMgTSFgHnotTphs8S1rAXfZjgmtGaZa3FqubCTcww>
X-ME-Proxy-Cause: dmFkZTFpWqLeI7EFGgGAR0vlCu5QacLfl+DLr86oWuWQgcdAOakkPHVH/rhmTTUG5uUJpR
 grrlK1zkIrAUUqxivzoYc9QYxLt3G2vxufQBCr9+q7Szfr4YjzZISp7sq7jNy5jQq28iVS
 KkYpsv5Xtb9UmVt2B9Zq6wC3+qArqHr80DSBS6BjtGLd0G9PLf72ixxE2BMQ4ZUOPDwfDi
 VD/jIdpX+RFmQwcN4WvQS7z1u2wwdviH/VNXCwxbz8FbxJvwJzK6BMq5ormOi3wUZDOh8K
 r1/XbK/Y5t3ZEcS2yVxxlnZU5cnsndw4wpjm2pse3Bb7yIFQJC+F1pwtf+rHbLYS+eE+Da
 z1UJYgll5l/6CANFiNzChjB7JMNrDUKbqClv7aVlvOJCud+We5G41aNi5ZUUi0EyNwZmZ+
 xoFJmrqbV2fZ/Meo0aBST1VX96s9WZSTza+UBV7Iy0vYfvhlEIWb5MYWZ7bXj8GYdn4ISG
 r7AUvD3xnUcNf4PHaM2O0YqfLGz8O/ysBIt8DNs7EWSa+1W+4YjpNOUVs9aQfTNmR2ur/0
 VZ63+uDyNAYD9DPeU4uFmeBwIMxxA2qElbZfAgSeoK3fvNv9+q7uUB6lADhEnuIHAnE7+d
 qSqiCI09Ti78mVFSyMIbtIfMkbRbIXQQXHMXZswffpjcPXWjinZT6x/SinyQ
X-ME-Proxy: <xmx:Qh5HavbL7T7JDwdnDjU_PtJOsOQlVAZHg0q6K___FxviZbO1-YjxUA>
 <xmx:Qh5HahrkxP-W-a37U7jdKRr5XwCheZR30q7NCmQDvMWFuFdMgCiCcA>
 <xmx:Qh5Harb-hogXMsoTuw1uXW2Jobmq-Vh5pLiSIvxbspetRafoMOkvLw>
 <xmx:Qh5HahRze3iHE2oS-Y84eBJ40tb2nusBK-nt2Iczrtzi5q47i93nKg>
 <xmx:Qx5HavASthIIg9dxXGuERngrHTQv3TtpxfxhuRAzZNHY3AhV12D49SCy>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 22:28:18 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH] test/bpf: remove validation tests from CI
Date: Fri,  3 Jul 2026 04:27:37 +0200
Message-ID: <20260703022738.2574548-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The new tests for BPF validation are triggering a strange issue
in GitHub Action: the last tests are killed by signal 7 SIGBUS.

The series fixing a lot of BPF issues was merged
but the related test has to be removed from the fast tests suite
which runs in some CI jobs.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 app/test/test_bpf_validate.c | 58 ++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/app/test/test_bpf_validate.c b/app/test/test_bpf_validate.c
index 3f6747eaf6..fafd5d27f5 100644
--- a/app/test/test_bpf_validate.c
+++ b/app/test/test_bpf_validate.c
@@ -1291,7 +1291,7 @@ test_alu64_add_k(void)
 	});
 }
 
-REGISTER_FAST_TEST(bpf_validate_alu64_add_k_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_alu64_add_k_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_add_k);
 
 /* 64-bit addition of immediate to a pointer range. */
@@ -1309,7 +1309,7 @@ test_alu64_add_k_pointer(void)
 	});
 }
 
-REGISTER_FAST_TEST(bpf_validate_alu64_add_k_pointer_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_alu64_add_k_pointer_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_add_k_pointer);
 
 /* 64-bit addition of pointer to a pointer. */
@@ -1327,7 +1327,7 @@ test_alu64_add_x_pointer_pointer(void)
 	});
 }
 
-REGISTER_FAST_TEST(bpf_validate_alu64_add_x_pointer_pointer_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_alu64_add_x_pointer_pointer_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_add_x_pointer_pointer);
 
 /* 64-bit addition of scalar to a pointer. */
@@ -1345,7 +1345,7 @@ test_alu64_add_x_pointer_scalar(void)
 	});
 }
 
-REGISTER_FAST_TEST(bpf_validate_alu64_add_x_pointer_scalar_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_alu64_add_x_pointer_scalar_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_add_x_pointer_scalar);
 
 /* 64-bit addition of pointer to a scalar. */
@@ -1363,7 +1363,7 @@ test_alu64_add_x_scalar_pointer(void)
 	});
 }
 
-REGISTER_FAST_TEST(bpf_validate_alu64_add_x_scalar_pointer_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_alu64_add_x_scalar_pointer_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_add_x_scalar_pointer);
 
 /* 64-bit addition of scalar to a scalar. */
@@ -1381,7 +1381,7 @@ test_alu64_add_x_scalar_scalar(void)
 	});
 }
 
-REGISTER_FAST_TEST(bpf_validate_alu64_add_x_scalar_scalar_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_alu64_add_x_scalar_scalar_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_add_x_scalar_scalar);
 
 /* 64-bit bitwise AND between a scalar range and immediate. */
@@ -1398,7 +1398,7 @@ test_alu64_and_k(void)
 	});
 }
 
-REGISTER_FAST_TEST(bpf_validate_alu64_and_k_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_alu64_and_k_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_and_k);
 
 /* 64-bit division and modulo of UINT64_MAX*2/3. */
@@ -1442,7 +1442,7 @@ test_alu64_div_mod_big_constant(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_FAST_TEST(bpf_validate_alu64_div_mod_big_constant_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_alu64_div_mod_big_constant_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_div_mod_big_constant);
 
 /* 64-bit division and modulo of UINT64_MAX/3..UINT64_MAX*2/3 by a constant. */
@@ -1487,7 +1487,7 @@ test_alu64_div_mod_big_range(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_FAST_TEST(bpf_validate_alu64_div_mod_big_range_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_alu64_div_mod_big_range_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_div_mod_big_range);
 
 /* 64-bit division and modulo of INT64_MIN by -1. */
@@ -1533,7 +1533,7 @@ test_alu64_div_mod_overflow(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_FAST_TEST(bpf_validate_alu64_div_mod_overflow_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_alu64_div_mod_overflow_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_div_mod_overflow);
 
 /* 64-bit left shift by 63. */
@@ -1550,7 +1550,7 @@ test_alu64_lsh_63(void)
 	});
 }
 
-REGISTER_FAST_TEST(bpf_validate_alu64_lsh_63_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_alu64_lsh_63_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_lsh_63);
 
 /* 64-bit multiplication of constant and immediate with overflow. */
@@ -1567,7 +1567,7 @@ test_alu64_mul_k_overflow(void)
 	});
 }
 
-REGISTER_FAST_TEST(bpf_validate_alu64_mul_k_overflow_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_alu64_mul_k_overflow_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_mul_k_overflow);
 
 /* 64-bit mul of small scalar range and immediate. */
@@ -1584,7 +1584,7 @@ test_alu64_mul_k_range_small(void)
 	});
 }
 
-REGISTER_FAST_TEST(bpf_validate_alu64_mul_k_range_small_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_alu64_mul_k_range_small_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_mul_k_range_small);
 
 /* 64-bit negation when interval first element is INT64_MIN. */
@@ -1618,7 +1618,7 @@ test_alu64_neg_int64min_first(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_FAST_TEST(bpf_validate_alu64_neg_int64min_first_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_alu64_neg_int64min_first_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_neg_int64min_first);
 
 /* 64-bit negation when interval last element is INT64_MIN. */
@@ -1647,7 +1647,7 @@ test_alu64_neg_int64min_last(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_FAST_TEST(bpf_validate_alu64_neg_int64min_last_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_alu64_neg_int64min_last_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_neg_int64min_last);
 
 /* 64-bit negation when interval first element is zero. */
@@ -1681,7 +1681,7 @@ test_alu64_neg_zero_first(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_FAST_TEST(bpf_validate_alu64_neg_zero_first_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_alu64_neg_zero_first_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_neg_zero_first);
 
 /* 64-bit negation when interval last element is zero. */
@@ -1710,7 +1710,7 @@ test_alu64_neg_zero_last(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_FAST_TEST(bpf_validate_alu64_neg_zero_last_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_alu64_neg_zero_last_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_neg_zero_last);
 
 /* 64-bit bitwise OR between a positive scalar range and negative immediate. */
@@ -1727,7 +1727,7 @@ test_alu64_or_k_negative(void)
 	});
 }
 
-REGISTER_FAST_TEST(bpf_validate_alu64_or_k_negative_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_alu64_or_k_negative_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_or_k_negative);
 
 /* 64-bit bitwise OR between a positive scalar range and positive immediate. */
@@ -1744,7 +1744,7 @@ test_alu64_or_k_positive(void)
 	});
 }
 
-REGISTER_FAST_TEST(bpf_validate_alu64_or_k_positive_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_alu64_or_k_positive_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_or_k_positive);
 
 /* 64-bit difference between two negative ranges.. */
@@ -1761,7 +1761,7 @@ test_alu64_sub_x_src_signed_max_zero(void)
 	});
 }
 
-REGISTER_FAST_TEST(bpf_validate_alu64_sub_x_src_signed_max_zero_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_alu64_sub_x_src_signed_max_zero_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_sub_x_src_signed_max_zero);
 
 /* 64-bit bitwise XOR between a negative scalar range and zero immediate. */
@@ -1778,7 +1778,7 @@ test_alu64_xor_k_negative(void)
 	});
 }
 
-REGISTER_FAST_TEST(bpf_validate_alu64_xor_k_negative_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_alu64_xor_k_negative_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_xor_k_negative);
 
 /* Jump if greater than immediate. */
@@ -1796,7 +1796,7 @@ test_jmp64_jeq_k(void)
 	});
 }
 
-REGISTER_FAST_TEST(bpf_validate_jmp64_jeq_k_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_jmp64_jeq_k_autotest, NOHUGE_OK, ASAN_OK,
 	test_jmp64_jeq_k);
 
 /* Jump if signed less than another register. */
@@ -1814,7 +1814,7 @@ test_jmp64_jslt_x(void)
 	});
 }
 
-REGISTER_FAST_TEST(bpf_validate_jmp64_jslt_x_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_jmp64_jslt_x_autotest, NOHUGE_OK, ASAN_OK,
 	test_jmp64_jslt_x);
 
 /* Jump on ordering comparisons with potential bound overflow. */
@@ -1863,7 +1863,7 @@ test_jmp64_ordering_overflow(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_FAST_TEST(bpf_validate_jmp64_ordering_overflow_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_jmp64_ordering_overflow_autotest, NOHUGE_OK, ASAN_OK,
 	test_jmp64_ordering_overflow);
 
 /* Jump on ordering comparisons between two ranges. */
@@ -2022,7 +2022,7 @@ test_jmp64_ordering_ranges(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_FAST_TEST(bpf_validate_jmp64_ordering_ranges_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_jmp64_ordering_ranges_autotest, NOHUGE_OK, ASAN_OK,
 	test_jmp64_ordering_ranges);
 
 /* Jump on ordering comparisons with singleton inside the range. */
@@ -2080,7 +2080,7 @@ test_jmp64_ordering_singleton_inside(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_FAST_TEST(bpf_validate_jmp64_ordering_singleton_inside_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_jmp64_ordering_singleton_inside_autotest, NOHUGE_OK, ASAN_OK,
 	test_jmp64_ordering_singleton_inside);
 
 /* Jump on ordering comparisons with singleton outside the range. */
@@ -2175,7 +2175,7 @@ test_jmp64_ordering_singleton_outside(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_FAST_TEST(bpf_validate_jmp64_ordering_singleton_outside_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_jmp64_ordering_singleton_outside_autotest, NOHUGE_OK, ASAN_OK,
 	test_jmp64_ordering_singleton_outside);
 
 /* Jump on ordering comparisons with ranges "touching" each other. */
@@ -2249,7 +2249,7 @@ test_jmp64_ordering_touching(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_FAST_TEST(bpf_validate_jmp64_ordering_touching_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_jmp64_ordering_touching_autotest, NOHUGE_OK, ASAN_OK,
 	test_jmp64_ordering_touching);
 
 /* 64-bit load from heap (should be set to unknown). */
@@ -2267,5 +2267,5 @@ test_mem_ldx_dw_heap(void)
 	});
 }
 
-REGISTER_FAST_TEST(bpf_validate_mem_ldx_dw_heap_autotest, NOHUGE_OK, ASAN_OK,
+REGISTER_ATTIC_TEST(bpf_validate_mem_ldx_dw_heap_autotest, NOHUGE_OK, ASAN_OK,
 	test_mem_ldx_dw_heap);
-- 
2.54.0

