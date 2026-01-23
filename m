Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AF5D74EF3
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 16:03:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCED04060C;
	Fri, 23 Jan 2026 17:03:20 +0100 (CET)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id BF3BC402E9
 for <dev@dpdk.org>; Fri, 23 Jan 2026 17:03:18 +0100 (CET)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2b714f30461so2195451eec.0
 for <dev@dpdk.org>; Fri, 23 Jan 2026 08:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769184198; x=1769788998; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QTM59IGJsqJUlb24DH6dC7HEXPaCnDre/44ew72i6MI=;
 b=RFZ9vP6WIzJVsSJrk0FBQQXiXuq0tVmbsrK1O5H6QoDLPm713DL66YpJKL5Lj6nVY1
 X5UBIKpAHvqfFjV6tLfYKu4w2ixSyYz04QunC/E3KPiBlSRhQoNSFeE3OlxEPvz6tIbY
 pHeQz0NZmsWd0Eq3QFTz1tG0z5ylVyFeKwZw6kn4X4tKstx+jAi97CMdwQkWxKZ/+EuK
 qQhgYB+srZWFhF0OPGvYpcU2ititrv6lvTJWrpByDU22wSdwWDu15Zr8XBaaBdPnuH80
 +IUnK8qRJOeFcTv+eW5JcPWd2aGwX/BBjmj1EZHuVBRzqSXMt0Rv9xK2R/0boP9cGqOY
 tWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769184198; x=1769788998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QTM59IGJsqJUlb24DH6dC7HEXPaCnDre/44ew72i6MI=;
 b=L1lsA7aKhTffe9rv4K4V5epdIAOrE9QxHzFb0w7YX/gaRtXxjzpyicb4TJ/dRuJyFZ
 lyHGJCx2CmeHcU9blUZdwp8KgiFjT2IAbY34pEhdQnIKTTfnnoFeolgSYZKu6QSQgxVu
 +b60MMASYWrbOvlDe0O42nlWgJiG510JWIbaGztbtNhJVh0jCiP9X5UWFYEUNd+aP6Ok
 JvDDj8JjoJIVa3TeUASmRLc7wPVnp0CKy/9CxeC64PIY/QhYur3iE+P8A5tjvis4HyhJ
 Hx1TyVnx5exdv83PCZBjEfD6FcZmYxfCWrcLg/DHwaNMqzv+QaFMnpUDY2IwnbMg4V+Z
 IDmA==
X-Gm-Message-State: AOJu0YwXKgLbM21bQTtZ79WSdns7/6rwzJm++/FJfRpYePkwslD5ftV6
 gAFEb1PYUP/1OU6BaVPhi8ke9AaBUeXi06rSVDtiioh0ZCdZoD7ekefjN1K9Fw==
X-Gm-Gg: AZuq6aKK1Y4CoFIDKAx/zbZL476AP0mhDk5tje87YoEBu4jBZSPoCuhEa/lte/Ontye
 dsp6SN2UIFvozTyc3hnwwE+QUM2rufFPQ6ruAaYZ9wWBDS+wibaIJ8JBBcR7ZTtgSo7b/0EeweH
 glg0GwnG5lPmoulMreDbJ42uIXXITCDJZuWZtMoB/vjGchKycbHNhLPIzq8ACre08i2L+WyiR4K
 FZzbQHD+Ul1oRvFiCNxMkapt+JNhoKyZ4gJWZVHwHvyW2k6cuI9KnrMxnDUK2fE+z51/a/nXKIg
 HA/eyR8+EM4l/COFmYt85sHTCUQKa9e10F76/8+k06QN+JZW3EzrsyCNobEJk6h0hOU+kfYXCik
 BMpZ2ufvyOPnQnbeOPZIPFQqatRlqfrGQOP+PExdF8l478nkh2foHMKZGhRNeXs7C2U+t0xYmD1
 VOc9vMIhDaLh6HLXvrOy3nLhYuDWZEitNY
X-Received: by 2002:a05:7300:dc95:b0:2b6:fe9b:49fa with SMTP id
 5a478bee46e88-2b7399946ecmr1950922eec.18.1769184197340; 
 Fri, 23 Jan 2026 08:03:17 -0800 (PST)
Received: from mac.com ([136.24.82.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b73a6f5d2asm3514158eec.14.2026.01.23.08.03.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Jan 2026 08:03:16 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v16 2/2] net: __rte_raw_cksum pointers enable compiler
 optimizations
Date: Fri, 23 Jan 2026 08:02:44 -0800
Message-Id: <20260123160244.57335-3-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260123160244.57335-1-scott.k.mitch1@gmail.com>
References: <20260117212114.10466-1-scott.k.mitch1@gmail.com>
 <20260123160244.57335-1-scott.k.mitch1@gmail.com>
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

From: Scott Mitchell <scott.k.mitch1@gmail.com>

__rte_raw_cksum uses a loop with memcpy on each iteration.
GCC 15+ is able to vectorize the loop but Clang 18.1 is not.

Replace memcpy with direct pointer access using unaligned_uint16_t.
This enables both GCC and Clang to vectorize the loop while handling
unaligned access safely on all architectures.

Performance results from cksum_perf_autotest on Intel Xeon
(Cascade Lake, AVX-512) built with Clang 18.1 (TSC cycles/byte):

  Block size    Before    After    Improvement
         100      0.40     0.24        ~40%
        1500      0.50     0.06        ~8x
        9000      0.49     0.06        ~8x

Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
---
 app/test/meson.build       |   1 +
 app/test/test_cksum_fuzz.c | 240 +++++++++++++++++++++++++++++++++++++
 app/test/test_cksum_perf.c |   2 +-
 lib/net/rte_cksum.h        |  14 +--
 4 files changed, 247 insertions(+), 10 deletions(-)
 create mode 100644 app/test/test_cksum_fuzz.c

diff --git a/app/test/meson.build b/app/test/meson.build
index f4d04a6e42..2ca17716b9 100644
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
index 0000000000..3df11e3dc2
--- /dev/null
+++ b/app/test/test_cksum_fuzz.c
@@ -0,0 +1,240 @@
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
+REGISTER_FAST_TEST(cksum_fuzz_autotest, NOHUGE_OK, ASAN_OK, test_cksum_fuzz);
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
index a8e8927952..f04b46a6c3 100644
--- a/lib/net/rte_cksum.h
+++ b/lib/net/rte_cksum.h
@@ -42,15 +42,11 @@ extern "C" {
 static inline uint32_t
 __rte_raw_cksum(const void *buf, size_t len, uint32_t sum)
 {
-	const void *end;
-
-	for (end = RTE_PTR_ADD(buf, RTE_ALIGN_FLOOR(len, sizeof(uint16_t)));
-	     buf != end; buf = RTE_PTR_ADD(buf, sizeof(uint16_t))) {
-		uint16_t v;
-
-		memcpy(&v, buf, sizeof(uint16_t));
-		sum += v;
-	}
+	/* Process uint16 chunks to preserve overflow/carry math. GCC/Clang vectorize the loop. */
+	const unaligned_uint16_t *buf16 = (const unaligned_uint16_t *)buf;
+	const unaligned_uint16_t *end = buf16 + (len / sizeof(*buf16));
+	for (; buf16 != end; buf16++)
+		sum += *buf16;
 
 	/* if length is odd, keeping it byte order independent */
 	if (unlikely(len % 2)) {
-- 
2.39.5 (Apple Git-154)

