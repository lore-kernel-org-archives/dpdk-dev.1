Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD3FCF6C11
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Jan 2026 08:56:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B400D402E6;
	Wed,  7 Jan 2026 09:56:31 +0100 (CET)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50]) by mails.dpdk.org (Postfix) with ESMTP id 37D8F400D7
 for <dev@dpdk.org>; Tue,  6 Jan 2026 22:03:07 +0100 (CET)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-88a2ad13c24so11966886d6.1
 for <dev@dpdk.org>; Tue, 06 Jan 2026 13:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767733386; x=1768338186; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZZxOxeJWxGEmh+CsorbLM+e6qmzIkveigWg2kl2Gvqw=;
 b=eooSj20BNtlJbEnx4VSbIrVzgD9t+wOaDaJOyHcRr20oyUr46JuuafJULDUmhtQy8M
 /gRfb5dFve46ZhfOPamZDuywsG6H7Ll10G5TZ+LQI2NcfVefu0reij/5QLnuciJOuhBw
 CA0YW/63k+l6GkiTtlV4mkfGH9mW6/jcMZodtGtQSvbf6O63JaiMpMzntPQaE7HnRt4k
 baBZCIOehztS12MNX+baqn8hYOjdq2DSM2+DhpLSypoW6OSxigQapHSDZvyLUrZ6dMuO
 R1uyHc5K6yW+yNDQXZ7/EGQftdMu00WxMeJCvU8CZjGj/+npR8MfFGpyLCRNl4o3RPbg
 mjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767733386; x=1768338186;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZZxOxeJWxGEmh+CsorbLM+e6qmzIkveigWg2kl2Gvqw=;
 b=qniaFtoiPPTuXs+EK35pb0oDEKGXX8sQRJvuFEt439GRKJPRZoO8wQelWMsddxSBe1
 rHhFWIGsbQYIy2IduODoyFdQB30LytqQYSiWMU8UrwMKvbngh+2IqDOQZhm/W3kzx2GC
 dgAsA7VnLFAjJgvcG0JsbSbr9vwe22fjioW1KSpxlE9Bui3j9nAkP2ADMvTT2kW3/AIm
 eduQVc8AJGFnQzJwK05nG3urvtZh7zz+AOxJ64BdFaiUR54EZH69L560Y4kHgXXdFm0c
 vvjVvQueYix57M7RsOsDAv2SILDsZQag/e79YvTH/bSTYTnXwALlVvyZ+/KjVeiw3pGM
 wMQQ==
X-Gm-Message-State: AOJu0YyOStZbl3KUtNbIJfjrLB6XmCUk4bzIp7EWyFemqdg63gxXuVUN
 GqX4jL/IXjQQMiPRsfJa6Z68JF7ajmNjubMHtqA9qvW2qNKt9mMoDsRmbF8VKw==
X-Gm-Gg: AY/fxX57WzlkQYS/kFV87BftAhGCCuJm6ohjbd8EOTM56LT+sU3x7XNWTkA/YsOpgng
 7iiN7Cl1EuBU8O1gJJUYgZ4DIGWh3dczbXEkXv9bC8s1M0g1F53RVjgZg22TKGe0TUGVAvmLNLF
 8QcDvSZBM5Htrm1TzRsmAbN2ta+zj9RkTCI6HLBmIWF9mxSsmQ/daJRptbGn6VuUjEfUKLPObyh
 VGJyHOY9d1RoqpQUWhOWTQjmHWHQrr3bQnDZJDzVZvW3qxLnENokLPUtPhvGI2Ew/8jB6iG164a
 GzN4m5Y4aQIry/A71pN1E649qZkG4XaZjNcUMSQhb++KrmFggTspc0MX1Sf+AipY4KGhDHMorCN
 qGMb17vqERzXLRvuCVVXKplmEjS39qeDYAZXPC8rFlXzrnmfMF309lc1tgx2kIoe1UqZbcNhZR3
 +XWytCr/0AZhnitALNkqfStVg5xo5sEONfWYvk1ARXep6ZwVisdrehctrg/Q==
X-Google-Smtp-Source: AGHT+IHOgM3pm8IoVkgXunLggcR1B++vfuO2/yrEfdJM5Lcmxg0FAVoVvanocrSpBRnbPp1csixu1g==
X-Received: by 2002:a05:6214:598e:b0:888:8557:69e6 with SMTP id
 6a1803df08f44-8908427568fmr3661296d6.47.1767733386097; 
 Tue, 06 Jan 2026 13:03:06 -0800 (PST)
Received: from st57p01nt-relayp01.apple.com
 ([2601:182:b80:6a50:55a3:c8d2:e6eb:53e3])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89077253305sm21388516d6.41.2026.01.06.13.03.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Jan 2026 13:03:05 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com,
	Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v2 1/1] net: optimize raw checksum computation
Date: Tue,  6 Jan 2026 16:03:03 -0500
Message-Id: <20260106210303.16008-1-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 07 Jan 2026 09:56:29 +0100
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

From: Scott Mitchell <scott.k.mitch1@gmail.com>

Optimize __rte_raw_cksum() by processing data in larger unrolled loops
instead of iterating word-by-word. The new implementation processes
64-byte blocks (32 x uint16_t) in the hot path, followed by smaller
32/16/8/4/2-byte chunks.

Uses uint64_t accumulator to reduce carry propagation overhead and
leverages unaligned_uint16_t for safe unaligned access on all platforms.

Performance results from cksum_perf_autotest (TSC cycles/byte):
  Block size    Before    After    Improvement
         100  0.40-0.64  0.13-0.14    ~3-4x
        1500  0.49-0.51  0.10-0.11    ~4-5x
        9000  0.48-0.51  0.11-0.12    ~4x

Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
---
Changes in v2:
- Fixed UndefinedBehaviorSanitizer errors by adding uint32_t casts to prevent
  signed integer overflow in addition chains
- Restored uint32_t sum accumulator instead of uint64_t
- Added 64k length to test_cksum_perf.c

 app/test/meson.build       |   1 +
 app/test/test_cksum_fuzz.c | 241 +++++++++++++++++++++++++++++++++++++
 app/test/test_cksum_perf.c |   2 +-
 lib/net/rte_cksum.h        |  59 +++++++--
 4 files changed, 292 insertions(+), 11 deletions(-)
 create mode 100644 app/test/test_cksum_fuzz.c

diff --git a/app/test/meson.build b/app/test/meson.build
index efec42a6bf..c92325ad58 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -38,6 +38,7 @@ source_file_deps = {
     'test_byteorder.c': [],
     'test_cfgfile.c': ['cfgfile'],
     'test_cksum.c': ['net'],
+    'test_cksum_fuzz.c': ['net'],
     'test_cksum_perf.c': ['net'],
     'test_cmdline.c': [],
     'test_cmdline_cirbuf.c': [],
diff --git a/app/test/test_cksum_fuzz.c b/app/test/test_cksum_fuzz.c
new file mode 100644
index 0000000000..cc3c3e71e1
--- /dev/null
+++ b/app/test/test_cksum_fuzz.c
@@ -0,0 +1,241 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Apple Inc.
+ */
+
+#include <stdio.h>
+#include <string.h>
+
+#include <rte_common.h>
+#include <rte_cycles.h>
+#include <rte_hexdump.h>
+#include <rte_cksum.h>
+#include <rte_malloc.h>
+#include <rte_random.h>
+
+#include "test.h"
+
+/*
+ * Fuzz test for __rte_raw_cksum optimization.
+ * Compares the optimized implementation against the original reference
+ * implementation across random data of various lengths.
+ */
+
+#define DEFAULT_ITERATIONS 1000
+#define MAX_TEST_LEN 65536  /* 64K to match GRO frame sizes */
+
+/*
+ * Original (reference) implementation of __rte_raw_cksum from DPDK v23.11.
+ * This is retained here for comparison testing against the optimized version.
+ */
+static inline uint32_t
+__rte_raw_cksum_reference(const void *buf, size_t len, uint32_t sum)
+{
+	const void *end;
+
+	for (end = RTE_PTR_ADD(buf, RTE_ALIGN_FLOOR(len, sizeof(uint16_t)));
+	     buf != end; buf = RTE_PTR_ADD(buf, sizeof(uint16_t))) {
+		uint16_t v;
+
+		memcpy(&v, buf, sizeof(uint16_t));
+		sum += v;
+	}
+
+	/* if length is odd, keeping it byte order independent */
+	if (unlikely(len % 2)) {
+		uint16_t left = 0;
+
+		memcpy(&left, end, 1);
+		sum += left;
+	}
+
+	return sum;
+}
+
+static void
+init_random_buffer(uint8_t *buf, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		buf[i] = (uint8_t)rte_rand();
+}
+
+static inline uint32_t
+get_initial_sum(bool random_initial_sum)
+{
+	return random_initial_sum ? (rte_rand() & 0xFFFFFFFF) : 0;
+}
+
+/*
+ * Test a single buffer length with specific alignment and initial sum
+ */
+static int
+test_cksum_fuzz_length_aligned(size_t len, bool aligned, uint32_t initial_sum)
+{
+	uint8_t *data;
+	uint8_t *buf;
+	size_t alloc_size;
+	uint32_t sum_ref, sum_opt;
+
+	if (len == 0 && !aligned) {
+		/* Skip unaligned test for zero length - nothing to test */
+		return TEST_SUCCESS;
+	}
+
+	/* Allocate exact size for aligned, +1 for unaligned offset */
+	alloc_size = aligned ? len : len + 1;
+	if (alloc_size == 0)
+		alloc_size = 1;  /* rte_malloc doesn't like 0 */
+
+	data = rte_malloc(NULL, alloc_size, 64);
+	if (data == NULL) {
+		printf("Failed to allocate %zu bytes\n", alloc_size);
+		return TEST_FAILED;
+	}
+
+	buf = aligned ? data : (data + 1);
+
+	init_random_buffer(buf, len);
+
+	sum_ref = __rte_raw_cksum_reference(buf, len, initial_sum);
+	sum_opt = __rte_raw_cksum(buf, len, initial_sum);
+
+	if (sum_ref != sum_opt) {
+		printf("MISMATCH at len=%zu aligned='%s' initial_sum=0x%08x ref=0x%08x opt=0x%08x\n",
+		       len, aligned ? "aligned" : "unaligned",
+		       initial_sum, sum_ref, sum_opt);
+		rte_hexdump(stdout, "failing buffer", buf, len);
+		rte_free(data);
+		return TEST_FAILED;
+	}
+
+	rte_free(data);
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test a length with both alignments
+ */
+static int
+test_cksum_fuzz_length(size_t len, uint32_t initial_sum)
+{
+	int rc;
+
+	/* Test aligned */
+	rc = test_cksum_fuzz_length_aligned(len, true, initial_sum);
+	if (rc != TEST_SUCCESS)
+		return rc;
+
+	/* Test unaligned */
+	rc = test_cksum_fuzz_length_aligned(len, false, initial_sum);
+
+	return rc;
+}
+
+/*
+ * Test specific edge case lengths
+ */
+static int
+test_cksum_fuzz_edge_cases(void)
+{
+	/* Edge case lengths that might trigger bugs */
+	static const size_t edge_lengths[] = {
+		0, 1, 2, 3, 4, 5, 6, 7, 8,
+		15, 16, 17,
+		31, 32, 33,
+		63, 64, 65,
+		127, 128, 129,
+		255, 256, 257,
+		511, 512, 513,
+		1023, 1024, 1025,
+		1500, 1501,  /* MTU boundaries */
+		2047, 2048, 2049,
+		4095, 4096, 4097,
+		8191, 8192, 8193,
+		16383, 16384, 16385,
+		32767, 32768, 32769,
+		65534, 65535, 65536  /* 64K GRO boundaries */
+	};
+	unsigned int i;
+	int rc;
+
+	printf("Testing edge case lengths...\n");
+
+	for (i = 0; i < RTE_DIM(edge_lengths); i++) {
+		/* Test with zero initial sum */
+		rc = test_cksum_fuzz_length(edge_lengths[i], 0);
+		if (rc != TEST_SUCCESS)
+			return rc;
+
+		/* Test with random initial sum */
+		rc = test_cksum_fuzz_length(edge_lengths[i], get_initial_sum(true));
+		if (rc != TEST_SUCCESS)
+			return rc;
+	}
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test random lengths with optional random initial sums
+ */
+static int
+test_cksum_fuzz_random(unsigned int iterations, bool random_initial_sum)
+{
+	unsigned int i;
+	int rc;
+
+	printf("Testing random lengths (0-%d)%s...\n", MAX_TEST_LEN,
+	       random_initial_sum ? " with random initial sums" : "");
+
+	for (i = 0; i < iterations; i++) {
+		size_t len = rte_rand() % (MAX_TEST_LEN + 1);
+
+		rc = test_cksum_fuzz_length(len, get_initial_sum(random_initial_sum));
+		if (rc != TEST_SUCCESS) {
+			printf("Failed at len=%zu\n", len);
+			return rc;
+		}
+	}
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_cksum_fuzz(void)
+{
+	int rc;
+	unsigned int iterations = DEFAULT_ITERATIONS;
+
+	printf("### __rte_raw_cksum optimization fuzz test ###\n");
+	printf("Iterations per test: %u\n\n", iterations);
+
+	/* Test edge cases */
+	rc = test_cksum_fuzz_edge_cases();
+	if (rc != TEST_SUCCESS) {
+		printf("Edge case test FAILED\n");
+		return rc;
+	}
+	printf("Edge case test PASSED\n\n");
+
+	/* Test random lengths with zero initial sum */
+	rc = test_cksum_fuzz_random(iterations, false);
+	if (rc != TEST_SUCCESS) {
+		printf("Random length test FAILED\n");
+		return rc;
+	}
+	printf("Random length test PASSED\n\n");
+
+	/* Test random lengths with random initial sums */
+	rc = test_cksum_fuzz_random(iterations, true);
+	if (rc != TEST_SUCCESS) {
+		printf("Random initial sum test FAILED\n");
+		return rc;
+	}
+	printf("Random initial sum test PASSED\n\n");
+
+	printf("All fuzz tests PASSED!\n");
+	return TEST_SUCCESS;
+}
+
+REGISTER_FAST_TEST(cksum_fuzz_autotest, true, true, test_cksum_fuzz);
diff --git a/app/test/test_cksum_perf.c b/app/test/test_cksum_perf.c
index 0b919cd59f..6b1d4589e0 100644
--- a/app/test/test_cksum_perf.c
+++ b/app/test/test_cksum_perf.c
@@ -15,7 +15,7 @@
 #define NUM_BLOCKS 10
 #define ITERATIONS 1000000
 
-static const size_t data_sizes[] = { 20, 21, 100, 101, 1500, 1501 };
+static const size_t data_sizes[] = { 20, 21, 100, 101, 1500, 1501, 9000, 9001, 65536, 65537 };
 
 static __rte_noinline uint16_t
 do_rte_raw_cksum(const void *buf, size_t len)
diff --git a/lib/net/rte_cksum.h b/lib/net/rte_cksum.h
index a8e8927952..67807a92ef 100644
--- a/lib/net/rte_cksum.h
+++ b/lib/net/rte_cksum.h
@@ -42,21 +42,60 @@ extern "C" {
 static inline uint32_t
 __rte_raw_cksum(const void *buf, size_t len, uint32_t sum)
 {
-	const void *end;
+	/* Process in 64 byte blocks (32 x uint16_t). */
+	/* Always process as uint16_t chunks to preserve overflow/carry. */
+	const void *end = RTE_PTR_ADD(buf, RTE_ALIGN_FLOOR(len, 64));
+	while (buf != end) {
+		const unaligned_uint16_t *p16 = (const unaligned_uint16_t *)buf;
+		sum += (uint32_t)p16[0] + p16[1] + p16[2] + p16[3] +
+			 p16[4] + p16[5] + p16[6] + p16[7] +
+			 p16[8] + p16[9] + p16[10] + p16[11] +
+			 p16[12] + p16[13] + p16[14] + p16[15] +
+			 p16[16] + p16[17] + p16[18] + p16[19] +
+			 p16[20] + p16[21] + p16[22] + p16[23] +
+			 p16[24] + p16[25] + p16[26] + p16[27] +
+			 p16[28] + p16[29] + p16[30] + p16[31];
+		buf = RTE_PTR_ADD(buf, 64);
+	}
 
-	for (end = RTE_PTR_ADD(buf, RTE_ALIGN_FLOOR(len, sizeof(uint16_t)));
-	     buf != end; buf = RTE_PTR_ADD(buf, sizeof(uint16_t))) {
-		uint16_t v;
+	if (len & 32) {
+		const unaligned_uint16_t *p16 = (const unaligned_uint16_t *)buf;
+		sum += (uint32_t)p16[0] + p16[1] + p16[2] + p16[3] +
+			 p16[4] + p16[5] + p16[6] + p16[7] +
+			 p16[8] + p16[9] + p16[10] + p16[11] +
+			 p16[12] + p16[13] + p16[14] + p16[15];
+		buf = RTE_PTR_ADD(buf, 32);
+	}
 
-		memcpy(&v, buf, sizeof(uint16_t));
-		sum += v;
+	if (len & 16) {
+		const unaligned_uint16_t *p16 = (const unaligned_uint16_t *)buf;
+		sum += (uint32_t)p16[0] + p16[1] + p16[2] + p16[3] +
+			 p16[4] + p16[5] + p16[6] + p16[7];
+		buf = RTE_PTR_ADD(buf, 16);
 	}
 
-	/* if length is odd, keeping it byte order independent */
-	if (unlikely(len % 2)) {
-		uint16_t left = 0;
+	if (len & 8) {
+		const unaligned_uint16_t *p16 = (const unaligned_uint16_t *)buf;
+		sum += (uint32_t)p16[0] + p16[1] + p16[2] + p16[3];
+		buf = RTE_PTR_ADD(buf, 8);
+	}
 
-		memcpy(&left, end, 1);
+	if (len & 4) {
+		const unaligned_uint16_t *p16 = (const unaligned_uint16_t *)buf;
+		sum += (uint32_t)p16[0] + p16[1];
+		buf = RTE_PTR_ADD(buf, 4);
+	}
+
+	if (len & 2) {
+		const unaligned_uint16_t *p16 = (const unaligned_uint16_t *)buf;
+		sum += *p16;
+		buf = RTE_PTR_ADD(buf, 2);
+	}
+
+	/* If length is odd use memcpy for byte order independence */
+	if (len & 1) {
+		uint16_t left = 0;
+		memcpy(&left, buf, 1);
 		sum += left;
 	}
 
-- 
2.39.5 (Apple Git-154)

