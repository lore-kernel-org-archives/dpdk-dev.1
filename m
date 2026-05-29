Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF20CD6E49
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 17:14:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EED040654;
	Fri, 29 May 2026 19:14:24 +0200 (CEST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id 031B1400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 19:14:23 +0200 (CEST)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-137335bc3caso5681348c88.0
 for <dev@dpdk.org>; Fri, 29 May 2026 10:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780074862;
 x=1780679662; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wknyt5FXKcPzLzEx3t3gjOUvxFEg8QfTs0EkW/FhOhU=;
 b=kY95cbopAjXr/5pJvZFoN8qeaRRMNRoQRFEbe3GOiDRn7Ql3xij4BiJ8EwivsBpJdW
 5D7+N3XMDG3KpFn5VHjDwEA/1bowQe8Fx82PaQIB0/vC3CZbo9a77CaZZoGU4yLyYT51
 rEDzGCgRPkXUMSNgDZ7j46VFupF5xJa25iS/t/76iP37DexiEZ8dd7kYCYDoAPNemoz/
 8OqcdYIaEbGW3pQcl32JCNkcZI1mv5VmtBhZJJj1qOE3ij0i7pS9oQsF0qB560C7m4qn
 HOepPwOTuQF+QMi2V4bNCMrMH/suRBQHSdkUyQolPGxxQpj9DiW0WcVjWGTCCGYx3nS8
 oIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780074862; x=1780679662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wknyt5FXKcPzLzEx3t3gjOUvxFEg8QfTs0EkW/FhOhU=;
 b=DcoxUQCY9jO3J9luRWM2rg3HnfSv9PIaeZr2N893J+eRQxW9cGUQcBF8c5HxO+YOYc
 YraKx0a7aJQHOdkHuhIYxdY3ofR0Mdlqi1QDF8vcf6I1RR7IRXaXyisdkdNDo6Y+LaIV
 BY55fggkPnuow46O80lQqldMWQ15RatpNXvpad5KWkAdH3qPiH9jCh9mRrBg8FUjbkah
 a9gjpawVPThoIEaUCjzRAcq0ryLnVnO6Thl3cPuqT9WW3C6FIBfAN/gncBy5Zyq3ikjY
 ox1vV1tF8ZskuFI+73sS7jiGjj+OugkVVaYaz4BEJZnPjVkdVOj3gIg6R34UoKehpgxN
 X+Eg==
X-Gm-Message-State: AOJu0Yzp+d9bgD/bajapzNu5v5A6tmRc38hfXDdMxLs1QMdQRzqBWLfH
 bUm5h0MwUHdZ2LSzbj5VerhhzpKUwVSo4dPFLBpucIAQkIUw1xptxa+piQdD/WCeXS67a+4fkio
 o9PM4
X-Gm-Gg: Acq92OFtDrXjECiApvlzEUeJaHT6ev0savDQEfIJceD4qsJRxa3hc1iax3wl0zI39Qu
 Q1sONKYhr52Ur0TpelxqC6Rb6RoCX0TmGgeaKIJmbfHw1ZPcRfPEvFXns3qkQOcA2Cvg/SxVB9Z
 MN4UyKWZh+5/7d6iTvjzDj32TeKy8CNc2GowPLHqfm/lTAudlQat0rQDeHV6N0SruHA6QxBLdkS
 0F3EvPZPRDuTZGlsbo2uYnegbb9HBWj30Bc3AYg9gdaRdc+zCMI6euiaEjoXXhD1gPcAADkKs17
 8HobWh6iCllQQwU8z7/G4vsKtkItTnHSZnAivWutgWi+EpEjRRLNI7/ReGCBLCf1SaEalnLe8Bc
 wsObLZEuzmjWyuIY4HnP6Y4lKNhopy5VexT1jRsL9GzccVmI7XeC4M0+JHLJMnhk9Rlqjd4Ap6b
 mQ2auU4oMTprohFrtQ8/7WETto/vBiXHwPVumlvjmh8rZEA5AP3qoPMdPx6IhNQNqZ4jMXsiu/
X-Received: by 2002:a05:693c:2c86:b0:2f3:3daf:3496 with SMTP id
 5a478bee46e88-304fa6714b6mr299091eec.26.1780074861794; 
 Fri, 29 May 2026 10:14:21 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c120csm1880350eec.4.2026.05.29.10.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 10:14:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 1/7] app/test/reciprocal_division: make it a fast test
Date: Fri, 29 May 2026 10:10:54 -0700
Message-ID: <20260529171417.526892-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529171417.526892-1-stephen@networkplumber.org>
References: <20260529171417.526892-1-stephen@networkplumber.org>
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

This test is useful to have in CI, but the iteration values
were too large to make it usable as a fast test.

Redo the test with checks around boundary values and
use unit test framework for sub tests.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_reciprocal_division.c | 279 ++++++++++++++++------------
 1 file changed, 157 insertions(+), 122 deletions(-)

diff --git a/app/test/test_reciprocal_division.c b/app/test/test_reciprocal_division.c
index 3d0736d8dd..80f8561523 100644
--- a/app/test/test_reciprocal_division.c
+++ b/app/test/test_reciprocal_division.c
@@ -5,162 +5,197 @@
 #include "test.h"
 
 #include <stdio.h>
-#include <unistd.h>
 #include <inttypes.h>
 
 #include <rte_common.h>
-#include <rte_cycles.h>
 #include <rte_random.h>
 #include <rte_reciprocal.h>
 
-#define MAX_ITERATIONS	(1ULL << 32)
-#define DIVIDE_ITER	(100)
+#define MAX_ITERATIONS	(1ULL << 20)
+#define DIVISORS_RANDOM 64
 
 static int
-test_reciprocal(void)
+test_u32_divide(uint32_t a, uint32_t d, struct rte_reciprocal r)
 {
-	int result = 0;
-	uint32_t divisor_u32 = 0;
-	uint32_t dividend_u32;
-	uint32_t nresult_u32;
-	uint32_t rresult_u32;
-	uint64_t i, j;
-	uint64_t divisor_u64 = 0;
-	uint64_t dividend_u64;
-	uint64_t nresult_u64;
-	uint64_t rresult_u64;
-	struct rte_reciprocal reci_u32 = {0};
-	struct rte_reciprocal_u64 reci_u64 = {0};
-
-	printf("Validating unsigned 32bit division.\n");
-	for (i = 0; i < MAX_ITERATIONS; i++) {
-		/* Change divisor every DIVIDE_ITER iterations. */
-		if (i % DIVIDE_ITER == 0) {
-			divisor_u32 = rte_rand();
-			reci_u32 = rte_reciprocal_value(divisor_u32);
-		}
-
-		dividend_u32 = rte_rand();
-		nresult_u32 = dividend_u32 / divisor_u32;
-		rresult_u32 = rte_reciprocal_divide(dividend_u32,
-				reci_u32);
-		if (nresult_u32 != rresult_u32) {
-			printf("Division failed, %"PRIu32"/%"PRIu32" = "
-					"expected %"PRIu32" result %"PRIu32"\n",
-					dividend_u32, divisor_u32,
-					nresult_u32, rresult_u32);
-			result = 1;
-			break;
-		}
-	}
+	uint32_t expected = a / d;
+	uint32_t result = rte_reciprocal_divide(a, r);
 
-	printf("Validating unsigned 64bit division.\n");
-	for (i = 0; i < MAX_ITERATIONS; i++) {
-		/* Change divisor every DIVIDE_ITER iterations. */
-		if (i % DIVIDE_ITER == 0) {
-			divisor_u64 = rte_rand();
-			reci_u64 = rte_reciprocal_value_u64(divisor_u64);
-		}
+	TEST_ASSERT_EQUAL(expected, result,
+			  "%"PRIu32"/%"PRIu32" expected %"PRIu32" got %"PRIu32,
+			  a, d, expected, result);
+	return 0;
+}
 
-		dividend_u64 = rte_rand();
-		nresult_u64 = dividend_u64 / divisor_u64;
-		rresult_u64 = rte_reciprocal_divide_u64(dividend_u64,
-				&reci_u64);
-		if (nresult_u64 != rresult_u64) {
-			printf("Division failed,  %"PRIu64"/%"PRIu64" = "
-					"expected %"PRIu64" result %"PRIu64"\n",
-					dividend_u64, divisor_u64,
-					nresult_u64, rresult_u64);
-			result = 1;
-			break;
+static int
+test_reciprocal_u32(void)
+{
+	const uint32_t edge_div_u32[] = {
+		1, 2, 3, 7, 0x7fffffff, 0x80000000, 0xfffffffe, UINT32_MAX,
+	};
+	unsigned int n_div = RTE_DIM(edge_div_u32) + DIVISORS_RANDOM;
+
+	for (unsigned int di = 0; di < n_div; di++) {
+		uint32_t d;
+		if (di < RTE_DIM(edge_div_u32))
+			d = edge_div_u32[di]; /* Make sure and test the edge cases */
+		else
+			d = rte_rand_max(UINT32_MAX - 1) + 1;
+
+		struct rte_reciprocal r = rte_reciprocal_value(d);
+		uint32_t qmax = UINT32_MAX / d;   /* largest q with q*d <= UINT32_MAX */
+		if (d != 1)
+			qmax++;
+
+		for (unsigned int k = 0; k < MAX_ITERATIONS; k++) {
+			uint32_t q = rte_rand_max(qmax);
+			uint32_t val = q * d;           /* fits in u32 */
+
+			/* Check around the value.
+			 * Under and overflow of 32 bit value are fine here.
+			 */
+			if (test_u32_divide(val - 1, d, r) < 0 ||
+			    test_u32_divide(val, d, r) < 0 ||
+			    test_u32_divide(val + 1, d, r) < 0)
+				return -1;
 		}
 	}
+	return TEST_SUCCESS;
+}
 
-	printf("Validating unsigned 64bit division with 32bit divisor.\n");
-	for (i = 0; i < MAX_ITERATIONS; i++) {
-		/* Change divisor every DIVIDE_ITER iterations. */
-		if (i % DIVIDE_ITER == 0) {
-			divisor_u64 = rte_rand() >> 32;
-			reci_u64 = rte_reciprocal_value_u64(divisor_u64);
-		}
+static int
+test_u64_divide(uint64_t a, uint64_t d, const struct rte_reciprocal_u64 *r)
+{
+	uint64_t expected = a / d;
+	uint64_t result = rte_reciprocal_divide_u64(a, r);
+
+	TEST_ASSERT_EQUAL(expected, result,
+			  "%"PRIu64"/%"PRIu64" expected %"PRIu64" got %"PRIu64,
+			  a, d, expected, result);
+	return 0;
+}
 
-		dividend_u64 = rte_rand();
 
-		nresult_u64 = dividend_u64 / divisor_u64;
-		rresult_u64 = rte_reciprocal_divide_u64(dividend_u64,
-				&reci_u64);
+static int
+test_reciprocal_u64(void)
+{
+	const uint64_t edge_div_u64[] = {
+		1, 2, 3, 7, 0x7fffffff, 0x80000000, 0xfffffffe, UINT64_MAX,
+	};
+	unsigned int n_div = RTE_DIM(edge_div_u64) + DIVISORS_RANDOM;
+
+	for (unsigned int di = 0; di < n_div; di++) {
+		uint64_t d;
+		if (di < RTE_DIM(edge_div_u64))
+			d = edge_div_u64[di];
+		else
+			d = rte_rand_max(UINT64_MAX - 1) + 1;
+
+		struct rte_reciprocal_u64 r = rte_reciprocal_value_u64(d);
+		uint64_t qmax = UINT64_MAX / d;   /* largest q with q*d <= UINT64_MAX */
+		if (d != 1)
+			++qmax;
+
+		for (unsigned int k = 0; k < MAX_ITERATIONS; k++) {
+			uint64_t q = rte_rand_max(qmax);
+			uint64_t val = q * d;
+
+			if (test_u64_divide(val - 1, d, &r) < 0 ||
+			    test_u64_divide(val, d, &r) < 0 ||
+			    test_u64_divide(val + 1, d, &r) < 0)
+				return -1;
 
-		if (nresult_u64 != rresult_u64) {
-			printf("Division failed, %"PRIu64"/%"PRIu64" = "
-					"expected %"PRIu64" result %"PRIu64"\n",
-					dividend_u64, divisor_u64,
-					nresult_u64, rresult_u64);
-			result = 1;
-			break;
 		}
 	}
+	return TEST_SUCCESS;
+}
 
-	printf("Validating division by power of 2.\n");
-	for (i = 0; i < 32; i++) {
-		divisor_u64 = 1ull << i;
-		reci_u64 = rte_reciprocal_value_u64(divisor_u64);
-		reci_u32 = rte_reciprocal_value((uint32_t)divisor_u64);
+static int
+test_reciprocal_u64_small(void)
+{
+	/* 64-bit division with a 32-bit-range divisor */
+	uint64_t divisor_u64 = (rte_rand() >> 32) | 1;
+	struct rte_reciprocal_u64 reci_u64 = rte_reciprocal_value_u64(divisor_u64);
+
+	for (unsigned int i = 0; i < MAX_ITERATIONS; i++) {
+		uint64_t dividend_u64 = rte_rand();
+		uint64_t nresult_u64 = dividend_u64 / divisor_u64;
+		uint64_t rresult_u64 = rte_reciprocal_divide_u64(dividend_u64, &reci_u64);
+
+		TEST_ASSERT_EQUAL(nresult_u64, rresult_u64,
+			"%"PRIu64"/%"PRIu64" = expected %"PRIu64" got %"PRIu64,
+			dividend_u64, divisor_u64, nresult_u64, rresult_u64);
+	}
 
-		for (j = 0; j < MAX_ITERATIONS >> 4; j++) {
-			dividend_u64 = rte_rand();
+	return TEST_SUCCESS;
+}
 
-			nresult_u64 = dividend_u64 / divisor_u64;
-			rresult_u64 = rte_reciprocal_divide_u64(dividend_u64,
+static int
+test_reciprocal_pow2(void)
+{
+	for (unsigned int i = 0; i < 32; i++) {
+		uint64_t divisor_u64 = 1ULL << i;
+		struct rte_reciprocal_u64 reci_u64 = rte_reciprocal_value_u64(divisor_u64);
+		struct rte_reciprocal reci_u32 = rte_reciprocal_value((uint32_t)divisor_u64);
+
+		for (unsigned int j = 0; j < MAX_ITERATIONS >> 4; j++) {
+			uint64_t dividend_u64 = rte_rand();
+			uint64_t nresult_u64 = dividend_u64 / divisor_u64;
+			uint64_t rresult_u64 = rte_reciprocal_divide_u64(dividend_u64,
 					&reci_u64);
 
-			if (nresult_u64 != rresult_u64) {
-				printf(
-				"Division 64 failed, %"PRIu64"/%"PRIu64" = "
-					"expected %"PRIu64" result %"PRIu64"\n",
-						dividend_u64, divisor_u64,
-						nresult_u64, rresult_u64);
-				result = 1;
-			}
-
-			nresult_u32 = (dividend_u64 >> 32) / divisor_u64;
-			rresult_u32 = rte_reciprocal_divide(
+			TEST_ASSERT_EQUAL(nresult_u64, rresult_u64,
+				"u64 %"PRIu64"/%"PRIu64" = expected %"PRIu64" got %"PRIu64,
+				dividend_u64, divisor_u64,
+				nresult_u64, rresult_u64);
+
+			uint32_t nresult_u32 = (dividend_u64 >> 32) / divisor_u64;
+			uint32_t rresult_u32 = rte_reciprocal_divide(
 					(dividend_u64 >> 32), reci_u32);
 
-			if (nresult_u32 != rresult_u32) {
-				printf(
-				"Division 32 failed, %"PRIu64"/%"PRIu64" = "
-					"expected %"PRIu64" result %"PRIu64"\n",
-						dividend_u64 >> 32, divisor_u64,
-						nresult_u64, rresult_u64);
-				result = 1;
-				break;
-			}
+			TEST_ASSERT_EQUAL(nresult_u32, rresult_u32,
+				"u32 %"PRIu64"/%"PRIu64" = expected %"PRIu32" got %"PRIu32,
+				dividend_u64 >> 32, divisor_u64,
+				nresult_u32, rresult_u32);
 		}
 	}
 
-	for (; i < 64; i++) {
-		divisor_u64 = 1ull << i;
-		reci_u64 = rte_reciprocal_value_u64(divisor_u64);
+	for (unsigned int i = 32; i < 64; i++) {
+		uint64_t divisor_u64 = 1ULL << i;
+		struct rte_reciprocal_u64 reci_u64 = rte_reciprocal_value_u64(divisor_u64);
 
-		for (j = 0; j < MAX_ITERATIONS >> 4; j++) {
-			dividend_u64 = rte_rand();
-
-			nresult_u64 = dividend_u64 / divisor_u64;
-			rresult_u64 = rte_reciprocal_divide_u64(dividend_u64,
+		for (unsigned int j = 0; j < MAX_ITERATIONS >> 4; j++) {
+			uint64_t dividend_u64 = rte_rand();
+			uint64_t nresult_u64 = dividend_u64 / divisor_u64;
+			uint64_t rresult_u64 = rte_reciprocal_divide_u64(dividend_u64,
 					&reci_u64);
 
-			if (nresult_u64 != rresult_u64) {
-				printf("Division failed, %"PRIu64"/%"PRIu64" = "
-					"expected %"PRIu64" result %"PRIu64"\n",
-						dividend_u64, divisor_u64,
-						nresult_u64, rresult_u64);
-				result = 1;
-				break;
-			}
+			TEST_ASSERT_EQUAL(nresult_u64, rresult_u64,
+				"u64 %"PRIu64"/%"PRIu64" = expected %"PRIu64" got %"PRIu64,
+				dividend_u64, divisor_u64,
+				nresult_u64, rresult_u64);
 		}
 	}
 
-	return result;
+	return TEST_SUCCESS;
+}
+
+static struct unit_test_suite reciprocal_tests = {
+	.suite_name = "reciprocal division autotest",
+	.setup = NULL,
+	.teardown = NULL,
+	.unit_test_cases = {
+		TEST_CASE(test_reciprocal_u32),
+		TEST_CASE(test_reciprocal_u64),
+		TEST_CASE(test_reciprocal_u64_small),
+		TEST_CASE(test_reciprocal_pow2),
+		TEST_CASES_END()
+	}
+};
+
+static int
+test_reciprocal(void)
+{
+	return unit_test_suite_runner(&reciprocal_tests);
 }
 
-REGISTER_PERF_TEST(reciprocal_division, test_reciprocal);
+REGISTER_FAST_TEST(reciprocal_division_autotest, NOHUGE_OK, ASAN_OK, test_reciprocal);
-- 
2.53.0

