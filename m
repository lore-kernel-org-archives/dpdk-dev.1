Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEF1D0D141
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Jan 2026 17:04:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 001C24028E;
	Wed,  7 Jan 2026 18:04:33 +0100 (CET)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50]) by mails.dpdk.org (Postfix) with ESMTP id C55934021E
 for <dev@dpdk.org>; Wed,  7 Jan 2026 18:04:32 +0100 (CET)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-88a3bba9fd4so20931296d6.2
 for <dev@dpdk.org>; Wed, 07 Jan 2026 09:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767805472; x=1768410272; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UrhTPJPDWo85DvdcV2OLaC71w8aw7CCFZHzXtWl6ikY=;
 b=edvbIl+tSYHfifrkvhaFBeOkHBnJjtpYCnBV4vRRMIHvXCrT13oFuqBLlxmMtaBdcI
 RSFlBiLTa0o0QSTCbdPdOXL2yb/b70gq3ed9uwv1TiyK2OLuQF6HxjtWH2/WDlxdseJ8
 UpIuvHxBYsxV/iFQap4s2u2Ma6JZoY44+HrsIvnIFAp+nDSJ03OLSJNc/0SYj+EW/Ck/
 BcjjjSBelkmGVGnFaPkQe55eKs90tGoXuRQL6Gh9/yW+fyG+q9zUzX+5OR6G2mNmcSaC
 UTBl/jStkC/KvvWIO7Bb3jr+FJScsh8QE1HWBIq0LbjEVHjPC7u48fNwfiv65Ol87QyF
 BOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767805472; x=1768410272;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UrhTPJPDWo85DvdcV2OLaC71w8aw7CCFZHzXtWl6ikY=;
 b=Tv5/0Qs9LEo3xdhdX+wJhOI0FlMwTRd88OwgxD7H8N/aqvt8Z6bjS4Ul0WO1gPOWEE
 zZj8ithDxY5nybH4HLvCpUxzjzlHzdzulVS15abK1eegLRuaD8DbYgWpWMBTqf1QhWm1
 1lOVdgnruMco/wBfuHQZCReVUZqBlz0RiY1/SloXzuT56VxnRHS7Niz0ky1XJ3E88ToL
 91E/RnD/Yzehh45CIHAa1IB4rX3903LjapA4YaqYUXnC1L35A0yarnK3kuf5wRxNvV8a
 WCjCkpiwKgVloOkfx8WV1BvSU0Goz0VKOisl0RCUhoQwZyBKeAf4m2+9L30LUQduLFNn
 4+nA==
X-Gm-Message-State: AOJu0YyVRpFNTgKCPiXRUrUxIkRtb3lM56OwYtLQE+3QXsU+MUtzcF0n
 C7yZJi6gSoJ5b3BSva4gn7cQA6d2B/EAicUN2itZ4AQXqu36F9Uwarq/VNjCIA==
X-Gm-Gg: AY/fxX5mar/FncwCMqo30/31ekYeZ51+6qKVzU7spMPKBsixOyH3QIMo9UtvbZ1zy50
 DgJzmhA7lxzgfWruHw9lKSoxuA0ZeJTti06HTN8Brd2cBR3Jxx9G2As/dGJBP26rHJz0iGaB+f1
 QMLJOD7ntkwBg/WSQeDY2wwnQL/tD901XRv+sO0ihcDn9OR160024/hMtaAZaYbxc1p2FHRZCNw
 vONuMS/dXsVSE61S+/WiE2oiAuXgVLrq0hccRfZOny70MZMHxXT1gG0bwTj6jpw23eFO0gKSuag
 FZ5yYVoB7X1YMdDwjyb7eRX43TPPWk209JOKde9br/SzbKTNekQLq7Y3mrnuTsrvEnj3RUWbibu
 hWeoMI/D0GprIymFjw01clWQDKFWw2W8J3GyeVGrgGOWqLI8aeJnS37BANcpI9FCALVaaMw7xs+
 9jHxA8hIf+ikPyQU3aip2R33gRPXVPs8792HsjOSIhN4iSK92Pfw5VhVBPGQ==
X-Google-Smtp-Source: AGHT+IFy+O+cuJarXauYVIZ9etEpOfvvQ1TflomuyooRU7SCvIf9NTFn1QgdUqexNXErVAcoNEXWag==
X-Received: by 2002:ad4:5968:0:b0:7e3:cc6e:3c89 with SMTP id
 6a1803df08f44-89084270b69mr46853046d6.56.1767805470107; 
 Wed, 07 Jan 2026 09:04:30 -0800 (PST)
Received: from st47p01nt-relayp02.apple.com
 ([2601:182:b80:6a50:55a3:c8d2:e6eb:53e3])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8907725ffc7sm35980536d6.44.2026.01.07.09.04.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 09:04:29 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com,
	Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v3] net: optimize raw checksum computation
Date: Wed,  7 Jan 2026 12:04:15 -0500
Message-Id: <20260107170415.80275-1-scott.k.mitch1@gmail.com>
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

Optimize __rte_raw_cksum() by processing data in larger unrolled loops
instead of iterating word-by-word. The new implementation processes
64-byte blocks (32 x uint16_t) in the hot path, followed by smaller
32/16/8/4/2-byte chunks.

Uses uint32_t accumulator with explicit casts to prevent signed integer
overflow and leverages unaligned_uint16_t for safe unaligned access on
all platforms. Adds __rte_no_ubsan_alignment attribute to suppress false
positive alignment warnings from UndefinedBehaviorSanitizer.

Performance results from cksum_perf_autotest (TSC cycles/byte):
  Block size    Before    After    Improvement
         100  0.40-0.64  0.13-0.14    ~3-4x
        1500  0.49-0.51  0.10-0.11    ~4-5x
        9000  0.48-0.51  0.11-0.12    ~4x

Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
---
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

 app/test/meson.build         |   1 +
 app/test/test_cksum_fuzz.c   | 241 +++++++++++++++++++++++++++++++++++
 app/test/test_cksum_perf.c   |   2 +-
 lib/eal/include/rte_common.h |   9 ++
 lib/net/rte_cksum.h          |  60 +++++++--
 lib/net/rte_ip6.h            |   2 +-
 6 files changed, 303 insertions(+), 12 deletions(-)
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
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 9e7d84f929..37a36a1b22 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -546,6 +546,15 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
 #define __rte_no_asan
 #endif
 
+/**
+ * Disable UndefinedBehaviorSanitizer alignment checks
+ */
+#if defined(RTE_TOOLCHAIN_GCC) || defined(RTE_TOOLCHAIN_CLANG)
+#define __rte_no_ubsan_alignment __attribute__((no_sanitize("alignment")))
+#else
+#define __rte_no_ubsan_alignment
+#endif
+
 /*********** Macros for pointer arithmetic ********/
 
 /**
diff --git a/lib/net/rte_cksum.h b/lib/net/rte_cksum.h
index a8e8927952..d6e313dea5 100644
--- a/lib/net/rte_cksum.h
+++ b/lib/net/rte_cksum.h
@@ -39,24 +39,64 @@ extern "C" {
  * @return
  *   sum += Sum of all words in the buffer.
  */
+__rte_no_ubsan_alignment
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
 
diff --git a/lib/net/rte_ip6.h b/lib/net/rte_ip6.h
index d1abf1f5d5..af65a39815 100644
--- a/lib/net/rte_ip6.h
+++ b/lib/net/rte_ip6.h
@@ -564,7 +564,7 @@ rte_ipv6_phdr_cksum(const struct rte_ipv6_hdr *ipv6_hdr, uint64_t ol_flags)
 	struct {
 		rte_be32_t len;   /* L4 length. */
 		rte_be32_t proto; /* L4 protocol - top 3 bytes must be zero */
-	} psd_hdr;
+	} psd_hdr = {0}; /* Empty initializer avoids false-positive maybe-uninitialized warning */
 
 	psd_hdr.proto = (uint32_t)(ipv6_hdr->proto << 24);
 	if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
-- 
2.39.5 (Apple Git-154)

