Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C18C47BD0
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 09:48:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2710740430;
	Tue,  6 Jan 2026 10:48:51 +0100 (CET)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTP id B5A4C4026F
 for <dev@dpdk.org>; Tue,  6 Jan 2026 00:27:59 +0100 (CET)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-4ee1879e6d9so4210391cf.1
 for <dev@dpdk.org>; Mon, 05 Jan 2026 15:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767655679; x=1768260479; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+5eDX4nv0fRY4S86g7PnSy+dNGKq74VFJ4YQtMuh+Wc=;
 b=KaCsPnPQvomitdtSKzzEGXCmjUHrVnh+E4hAKDZtkCSW+ZZ9wAIjHtKEIuCgd8Q80P
 uKWsLECPbJUaPf9jjFuP937lnCWISD8A/wO+CnNeTT2BlyM7LNEXYR4j43F3qxVIMBrJ
 rZPt0L12dcpiSiOkxhEZOKDy93nXkXlOpfrvkcFCkoio33WCuF4vcHbEzAEWuvkA7l6X
 k3u4kD3HgGXGiW/ZXUBjj2tOmH0fJqhYNa+rpgSke8fu5CrCr+Yur69WThzw/T+ih8LN
 HzTJNAishdyOb+fVY16ZAOHmV3GcYvKwGNlcP4kWV6Qgf+W6gQDHrb1eHb0U0i1cG/3P
 417A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767655679; x=1768260479;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+5eDX4nv0fRY4S86g7PnSy+dNGKq74VFJ4YQtMuh+Wc=;
 b=IRAtKKRDsmc5BK0vbogN0chLEilEhvVP/T5cHqtiCiSB4vCWSHtU3fIlEK4K7tUfFq
 OWOG/bgY0MxiURj1IWMNmscyhIjD0mDyea4L1+O/vIFA5qFZzNoOy/DBnTAHDeDLQiX+
 NnLHlFcwesundlr1Y/523ACdniOHomm2CqMngeS1rZzPH4FhlSHy6FJKqhGQ75l/s4wq
 gVtcgPz5DwB372CWClem8AJT8GlFNjoppsLHGT4zu32ch6gxc8DPWpSxam06U6+6OGry
 VfWTktT0Hp9kxpmQe3V5GtaDdv4TFgQaEAwRAbBhh24C0ytJUjqrFm+EWWqlE7rK72ye
 EI0A==
X-Gm-Message-State: AOJu0YxU1a6hOhLHi1Y694lnYEmQA75rKFDfQzrjnxHWOlWC5d1l6BNd
 DaYogwOljjyd2wPIdWzKj27iYJR9jZdw78FCcV0yLdiRTIClfFsNus60tmDiGg==
X-Gm-Gg: AY/fxX5+Ob+0ToMzUz55yfuFni8j1huqk7JUp5uCxXSXvtJd1w/K7+YVrGheysWQjcv
 ttcFgLnGrFTW3yPCHYdvNlLn1xnKwkOiRu55VXys238uxpUSi3MxXL4A9S+0mGLkQ2MhGRMldK1
 UNAaILs6BaiudLNA87P8+eKmSLS2jz4OPdUNYFZJ705B04qknY6n+pvvEfNZ1HcFDedpWFPjBi4
 hqxN7CIeO+U0dS5OKulUKJtUhOXbB0utEdyuRBdCuGSHb3GZ6ijDx9UcXSOZxuRl/1+siV8FaO0
 lqctMjHLSGcgMTYIDASc4wmOgbz/kcChubd6dTIyS/YkRJC1IQTGwrUf7I335VD03bphczUaoTc
 bay1VONz2VScub3rugNUTSvK4xn87BLzVlfEIuDL+raPpPJxt75IdS0z7SluMtxGU3rBQkd15eB
 8bnEWfQEijRFWxlICvaOk1UX4rso1jQ2loJp53SQkpwr8gwhGC5oVedTlQfKSIlRaF+RnD
X-Google-Smtp-Source: AGHT+IFsXOW+l7bHnXM4zDIyo3HXNTlmhygs4hWz3YKWQI0fV4bNTrKrWl0lgWOfdZtXQ1j1oRudiA==
X-Received: by 2002:a05:622a:4890:b0:4f1:b956:6125 with SMTP id
 d75a77b69052e-4ffa772c576mr18928421cf.20.1767655678607; 
 Mon, 05 Jan 2026 15:27:58 -0800 (PST)
Received: from st57p01nt-relayp01.apple.com
 ([2601:182:b80:6a50:55a3:c8d2:e6eb:53e3])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ffa8e35dbfsm2571761cf.19.2026.01.05.15.27.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Jan 2026 15:27:58 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH] net: optimize raw checksum computation
Date: Mon,  5 Jan 2026 18:27:54 -0500
Message-Id: <20260105232754.34404-1-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 06 Jan 2026 10:48:49 +0100
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
 app/test/meson.build       |   1 +
 app/test/test_cksum_fuzz.c | 241 +++++++++++++++++++++++++++++++++++++
 app/test/test_cksum_perf.c |   2 +-
 lib/net/rte_cksum.h        |  63 ++++++++--
 4 files changed, 295 insertions(+), 12 deletions(-)
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
index 0b919cd59f..092332ceba 100644
--- a/app/test/test_cksum_perf.c
+++ b/app/test/test_cksum_perf.c
@@ -15,7 +15,7 @@
 #define NUM_BLOCKS 10
 #define ITERATIONS 1000000
 
-static const size_t data_sizes[] = { 20, 21, 100, 101, 1500, 1501 };
+static const size_t data_sizes[] = { 20, 21, 100, 101, 1500, 1501, 9000, 9001 };
 
 static __rte_noinline uint16_t
 do_rte_raw_cksum(const void *buf, size_t len)
diff --git a/lib/net/rte_cksum.h b/lib/net/rte_cksum.h
index a8e8927952..0322e69a74 100644
--- a/lib/net/rte_cksum.h
+++ b/lib/net/rte_cksum.h
@@ -42,25 +42,66 @@ extern "C" {
 static inline uint32_t
 __rte_raw_cksum(const void *buf, size_t len, uint32_t sum)
 {
-	const void *end;
+	const void *ptr = buf;
+	const void *end = RTE_PTR_ADD(ptr, RTE_ALIGN_FLOOR(len, 64));
+	uint64_t sum64 = sum;
+
+	/* Process in 64 byte blocks (32 x uint16_t). */
+	/* Always process as uint16_t chunks to preserve overflow/carry. */
+	while (ptr != end) {
+		const unaligned_uint16_t *p16 = (const unaligned_uint16_t *)ptr;
+		sum64 += p16[0] + p16[1] + p16[2] + p16[3] +
+			 p16[4] + p16[5] + p16[6] + p16[7] +
+			 p16[8] + p16[9] + p16[10] + p16[11] +
+			 p16[12] + p16[13] + p16[14] + p16[15] +
+			 p16[16] + p16[17] + p16[18] + p16[19] +
+			 p16[20] + p16[21] + p16[22] + p16[23] +
+			 p16[24] + p16[25] + p16[26] + p16[27] +
+			 p16[28] + p16[29] + p16[30] + p16[31];
+		ptr = RTE_PTR_ADD(ptr, 64);
+	}
 
-	for (end = RTE_PTR_ADD(buf, RTE_ALIGN_FLOOR(len, sizeof(uint16_t)));
-	     buf != end; buf = RTE_PTR_ADD(buf, sizeof(uint16_t))) {
-		uint16_t v;
+	if ((len & 32) != 0) {
+		const unaligned_uint16_t *p16 = (const unaligned_uint16_t *)ptr;
+		sum64 += p16[0] + p16[1] + p16[2] + p16[3] +
+			 p16[4] + p16[5] + p16[6] + p16[7] +
+			 p16[8] + p16[9] + p16[10] + p16[11] +
+			 p16[12] + p16[13] + p16[14] + p16[15];
+		ptr = RTE_PTR_ADD(ptr, 32);
+	}
 
-		memcpy(&v, buf, sizeof(uint16_t));
-		sum += v;
+	if ((len & 16) != 0) {
+		const unaligned_uint16_t *p16 = (const unaligned_uint16_t *)ptr;
+		sum64 += p16[0] + p16[1] + p16[2] + p16[3] + p16[4] + p16[5] + p16[6] + p16[7];
+		ptr = RTE_PTR_ADD(ptr, 16);
+	}
+
+	if ((len & 8) != 0) {
+		const unaligned_uint16_t *p16 = (const unaligned_uint16_t *)ptr;
+		sum64 += p16[0] + p16[1] + p16[2] + p16[3];
+		ptr = RTE_PTR_ADD(ptr, 8);
+	}
+
+	if ((len & 4) != 0) {
+		const unaligned_uint16_t *p16 = (const unaligned_uint16_t *)ptr;
+		sum64 += p16[0] + p16[1];
+		ptr = RTE_PTR_ADD(ptr, 4);
+	}
+
+	if ((len & 2) != 0) {
+		const unaligned_uint16_t *p16 = (const unaligned_uint16_t *)ptr;
+		sum64 += *p16;
+		ptr = RTE_PTR_ADD(ptr, 2);
 	}
 
 	/* if length is odd, keeping it byte order independent */
-	if (unlikely(len % 2)) {
+	if (unlikely(len & 1)) {
 		uint16_t left = 0;
-
-		memcpy(&left, end, 1);
-		sum += left;
+		memcpy(&left, ptr, 1);
+		sum64 += left;
 	}
 
-	return sum;
+	return (uint32_t)sum64;
 }
 
 /**
-- 
2.39.5 (Apple Git-154)

