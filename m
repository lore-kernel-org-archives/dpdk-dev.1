Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7DED0D146
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Jan 2026 23:53:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F1DB4028C;
	Thu,  8 Jan 2026 00:53:10 +0100 (CET)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id 858B940261
 for <dev@dpdk.org>; Thu,  8 Jan 2026 00:53:08 +0100 (CET)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-88fe44cce7eso20888776d6.3
 for <dev@dpdk.org>; Wed, 07 Jan 2026 15:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767829988; x=1768434788; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6C6F4W8rgSNlGB1q3tZQpAVO9O208HeEcS0vn3oKlsg=;
 b=W/Jjkqypqk/jcTHNp9H59H3/y/yxc8zQ5ZtwK59N/AzwtaTeGxCXTfwxqYITaZT2/p
 Q+XComqETkGos4T+Na5tPN/2ZNLcRsdnDDzjTqMIp5Wzh8qT+gmDLgzEcm8lp8dz5//f
 nVBMUYm6l2zTd/j5oOLkQ9ZxV7n6aM6MBBZ74n/dJo14hJDr9/QZBbnWsFrRjyBK5glX
 3JXwRlNNyrkH8FNaTQUndOQiaZgViU5KmzJ0y10o9d1/appevgbpy8YS7bcC+D0+WOxZ
 5MI6KskS7BoEABcAceEnSh71OyPd1uirUzF6ZPXuIiDuNrnFF005xHZn5K4+GOKpaDN0
 UqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767829988; x=1768434788;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6C6F4W8rgSNlGB1q3tZQpAVO9O208HeEcS0vn3oKlsg=;
 b=ZJbdEFNANpPk7qxMiEA6Nta3nzqSNQupuu3OAQ9VpNp9K5Se/2RyEI7nKl8kf+Ee2M
 umdUW4HpU6YQMwhk//bTc1RyYtbvBahfQyOYK7hV/E6ONDQXapswzSrm2GAxLdckSjFQ
 MBqp4iqVsPsm/Db81Zh79ZD6kM1PXIWTnj7HegzgpNTk7D3wudKOO5OVAv3jazbPrCvF
 vsoGqXFgF5JdHPbwmBtUvWRU5Cm6wrParx4++8oKT3ALZ+I9NWuXAs/yCnZZ9DwxgQA5
 exurQSz8CTeB0AUR6yD5naTKqzeB/nSmCADM9p5YaFLleRmlYfzuUDEWxEi8FfCxt6OD
 fdMw==
X-Gm-Message-State: AOJu0YyBsj14b3DnyMzpThM36ufyWP3qFporK2yTEcgXaFodAw0tnXs0
 W+aUaFs/6j59vp59iOD+4eC+pQ1clylfec7jtXQYHOgHnnheOPUZQ7G7w0Dfsg==
X-Gm-Gg: AY/fxX4rvjBI4V8I51UbyW1r1eZMKTphL79swjKKeiVGU6AMo+3mF9cnsn1wucwi+Ya
 SwGGSsoF2WBkt70Rsmb9+eri0kSUCtvc9UQc+ns4FwMpm2vGMvmJlRLnCvaQXRkVNL1aVlFUovr
 arsSi2b6rtEb0SuNZdvWhxROPLr+YkEQJn3Z2tg0NGlyhCwCGUKVBw7kmqnYILwSzJP520s51sp
 eMbOPKJySVZEn1ed2mmvLSYF2Vsmi6+TzN5yweN0g5SFBn2nYmB0G6ZJ06bSCUNNKvvdKccyxM/
 pApgUBLvbFD+PLPC6UaS5r5S/w3IMWcefF81wZjQaQrhwWbG1GGt+AEB0tcycAUv+bp71EmyMyx
 Pw1jfeShC51hJoLyZuxFZYBp0G9J2bUdL8FfoRQp7JHHonzpuS2qWet9otQ82rHf427Um1tSSJi
 nawMjnbmdbZItxqviyVZMJoBAAtnZkoLR9QUVsIsWjTLABqyMcnM0XW/KV14rKEPgfpOvz
X-Google-Smtp-Source: AGHT+IFXtspv/4g+zQVnAADbQdL6h2aqYza8gZpwAtKgr8S+dSqSSDvhwIvpmgD3Hp5+7uer4wngYw==
X-Received: by 2002:a05:6214:248a:b0:88a:52a1:257b with SMTP id
 6a1803df08f44-890842cbc82mr65836446d6.59.1767829987563; 
 Wed, 07 Jan 2026 15:53:07 -0800 (PST)
Received: from st47p01nt-relayp03.apple.com
 ([2601:182:b80:6a50:75d8:5eda:abb3:12c5])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8907723436fsm47806646d6.34.2026.01.07.15.53.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 15:53:07 -0800 (PST)
From: Scott <scott.k.mitch1@gmail.com>
X-Google-Original-From: Scott <scott_mitchell@apple.com>
To: dev@dpdk.org
Cc: mb@smartsharesystems.com,
	Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v4] net: optimize raw checksum computation
Date: Wed,  7 Jan 2026 18:53:04 -0500
Message-Id: <20260107235304.30028-1-scott_mitchell@apple.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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
Replacing the memcpy with unaligned_uint16_t pointer access enables
both GCC and Clang to vectorize with SSE/AVX/AVX-512.

Performance results from cksum_perf_autotest on Intel Xeon
(Cascade Lake, AVX-512) built with Clang 18.1 (TSC cycles/byte):

  Block size    Before    After    Improvement
         100      0.40     0.24        ~40%
        1500      0.50     0.06        ~8x
        9000      0.49     0.06        ~8x

Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
---
Changes in v4:
- Replaced manual 64-byte loop unrolling with simple pointer iteration
- Removed __rte_no_ubsan_alignment macro (no longer needed)
- Removed rte_ip6.h false-positive warning fix (unable to repro locally)
- Updated performance numbers: AVX-512 vectorization on Clang achieves ~8x
  improvement for large packets vs scalar implementation

Changes in v3:
- Added __rte_no_ubsan_alignment macro to suppress false-positive UBSAN
  alignment warnings when using unaligned_uint16_t
- Fixed false-positive GCC maybe-uninitialized warning in rte_ip6.h exposed
  by optimization (can be split to separate patch once verified on CI)

Changes in v2:
- Fixed UndefinedBehaviorSanitizer errors by adding uint32_t casts to prevent
  signed integer overflow in addition chains
- Restored uint32_t sum accumulator instead of uint64_t
- Added 64k length to test_cksum_perf.c

 app/test/meson.build       |   1 +
 app/test/test_cksum_fuzz.c | 241 +++++++++++++++++++++++++++++++++++++
 app/test/test_cksum_perf.c |   2 +-
 lib/net/rte_cksum.h        |  19 ++-
 4 files changed, 252 insertions(+), 11 deletions(-)
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
index a8e8927952..a582e3a158 100644
--- a/lib/net/rte_cksum.h
+++ b/lib/net/rte_cksum.h
@@ -42,20 +42,19 @@ extern "C" {
 static inline uint32_t
 __rte_raw_cksum(const void *buf, size_t len, uint32_t sum)
 {
-	const void *end;
+	/*
+	 * Process as uint16 chunks to preserve overflow/carry math.
+	 * GCC and Clang vectorize the loop (if SSE available).
+	 */
+	const void *end = RTE_PTR_ADD(buf, RTE_ALIGN_FLOOR(len, sizeof(uint16_t)));
 
-	for (end = RTE_PTR_ADD(buf, RTE_ALIGN_FLOOR(len, sizeof(uint16_t)));
-	     buf != end; buf = RTE_PTR_ADD(buf, sizeof(uint16_t))) {
-		uint16_t v;
-
-		memcpy(&v, buf, sizeof(uint16_t));
-		sum += v;
-	}
+	for (const unaligned_uint16_t *buf16 = (const unaligned_uint16_t *)buf;
+			buf16 != end; buf16++)
+		sum += *buf16;
 
 	/* if length is odd, keeping it byte order independent */
-	if (unlikely(len % 2)) {
+	if (len & 1) {
 		uint16_t left = 0;
-
 		memcpy(&left, end, 1);
 		sum += left;
 	}
-- 
2.39.5 (Apple Git-154)

