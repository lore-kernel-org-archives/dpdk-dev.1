Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E88AC61DBD
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 02:01:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 971A740395;
	Wed, 26 Aug 2026 04:01:47 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id B9D18402E2
 for <dev@dpdk.org>; Wed, 26 Aug 2026 04:01:45 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-ca12086c06eso317732a12.0
 for <dev@dpdk.org>; Tue, 25 Aug 2026 19:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787709705;
 x=1788314505; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wknyt5FXKcPzLzEx3t3gjOUvxFEg8QfTs0EkW/FhOhU=;
 b=eyYr2FSCqeQ1ZbBehfSK37mm8UgutpO1fvYZXHK+EkHYKPMpTrYhyz0jb7LwslJEju
 8jygs+etT+cEDgVVSef7aRD6rcCPhU/KmhlG2uZzT5tMeVQKtdFK65DDtVUYBWAQGSl3
 rIXGLBPIfnmQOVMFmPWEg41T9WD9jNDO11MWwqIQJT0LNL2zmk7ZDRuQuKOI2eOqz77l
 90nNDphSVUpAHwn+FbsLMvrbwm2AS0czVo/QPakHOd3evywc+ZbNdVL6WWwqVCPXhIuS
 RulBICd+2NQZQwDUuLE8KcbB0G2d7yRTFMaFSUYdls6461BBEhSB92gt1JIiVM7T52SP
 DO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787709705; x=1788314505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wknyt5FXKcPzLzEx3t3gjOUvxFEg8QfTs0EkW/FhOhU=;
 b=hdKpFpSnXnZDlSLAeyC7GoJcxj5+dIwZW5gFDeN6kAGWI0utpSuEvhgjdmchna8sV+
 dDt+VjzIVZ9/LrIjvEjMLo7vCFsjo4uqaaPNBUuFE/YgPmdA03cZcLQgoFkcMKsXb80c
 Vk6JdIRCXeoi07FrvpEnuF5HtbhYgY01Mv8cYKZFJE+uUSheUd6td68IqRiSRqAKclXM
 0lh+K7rbkovMOIqxIVn3wwxhDiEccVEemth/k3pdI/AMaINoG25LmFn0pbN62to+D6DU
 qa1QJNMYM7ffTWfEaedbb/kLWA7P39KPFvUOTf3SVzTLRatvSnd6Qdgp/N7eVDTWGzFL
 RMDA==
X-Gm-Message-State: AFuF++l26raxQiYQOO6AFtpOA5xhdsc8lmINdDnmDXcTcgLhntGKzR9f
 mzrR6hDxRWnLaFqg2ncXlMjwzREqissoFoMlu+AxvmmhC7GNrP3dKiYnrgrvkUaCEOTJKOM5h6P
 usAfT6dI=
X-Gm-Gg: AR+sD100uhkftPyAtk4QesHzZoRM3cZIN2zbusgZYsasqFJ/XzzcHYIgZB6E+DQrCVd
 H+Wnj5vDtIUnCcbTe8V9OmXybumX76l2rrkbWTAL8xlbLqunBcBWpOfx7uNw6W60rLLTp4UABoa
 AEMWifnlGwdfpvUssYMFLCIMC+rd7hTuLLqg7mSLAG+UeIT4fpTlytuUbzX6zidUDsAHl05BzCf
 OaPJEJTUI9CW8xrD8qDCPG+XWWpQrrWV28yn4LXSCpuzHr35h3EUoTVZrhSEH3jTIiSvF2JDCdm
 ieDyc9dugVB83Exd324JxQF/ujfHkXLfGi1Sj63dztideYY9BUX8SnjgbExSEgJwKqz1kOZ2dHx
 ngWL2j/EXD4TmU/LbLNUPJ2rtu/4kSBIALCG5OIywWqc4+G92Aan1OKmorOeqxT3aASsL/VO67e
 eKY0Vm5HE0NM/UDNiQmBB1/60KyKBTbQdz4R5L0/Ww/9475hq3T9ArVCqKCmYroU9XrqzytrwgW
 +sLF6PA9/VGLXGetziIWJyHJCU=
X-Received: by 2002:a17:90a:fc47:b0:38e:9045:bac0 with SMTP id
 98e67ed59e1d1-3966d1b1f18mr7355964a91.5.1787709704600; 
 Tue, 25 Aug 2026 19:01:44 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396686e8aa2sm1935636a91.3.2026.08.25.19.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 19:01:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 1/5] app/test/reciprocal_division: make it a fast test
Date: Tue, 25 Aug 2026 18:56:43 -0700
Message-ID: <20260826020133.2644805-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826020133.2644805-1-stephen@networkplumber.org>
References: <20260529171417.526892-1-stephen@networkplumber.org>
 <20260826020133.2644805-1-stephen@networkplumber.org>
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

