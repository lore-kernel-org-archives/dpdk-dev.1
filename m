Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389B6C9EC7A
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 12:04:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F4B040DD3;
	Mon, 12 Jan 2026 13:04:21 +0100 (CET)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id BEA8440DD3
 for <dev@dpdk.org>; Mon, 12 Jan 2026 13:04:19 +0100 (CET)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-8b25ed53fcbso102545885a.0
 for <dev@dpdk.org>; Mon, 12 Jan 2026 04:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768219459; x=1768824259; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xzJBN5ubd1//yiKLvr+Td8jWEt/hzERNstiIxicGjmA=;
 b=T6LuVRd36qQ1+RLAADMztMG+cUQcpdzQqpdVLFiFYPdhtbzDLyooIaMpMZH1KI38WF
 P9Po2wC9epYS3Vx9C7K+zy5Iz5UXqiDB+eWujBRbQ7cFwP1fj1W3mK/Z5bPp/g+CAaaA
 7CYnOFzkaRrw2sUlowgdBEDadYEZJxJEGlFxjtKM5D7Hnq2A3n7pi38ezO+QhXdty5XO
 Zr92wgXp6DVStfIS6yTrHwI5vGLuk1rc8LW0HL6yryziveAgdfYjexFHz6q6+5hW4uZe
 J8v+R5A9FnRCJydNvgg0pNPwjFuc1+tbtJ1BXcfb9oK+ZvGLJE0nRZ00z4vsG8kxpDbB
 yYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768219459; x=1768824259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xzJBN5ubd1//yiKLvr+Td8jWEt/hzERNstiIxicGjmA=;
 b=lxUjp+Ukkc8mJlL7k6HAuG+tppDK+8jGpjdR4cEiCq11cdj0+jBqRvTdwcdzCAebua
 7MQVpYpNoEoVVvwKQ4wCDHF8y2vfnZ5/ptlMe4GS6SDAbM6wIMRzbjklrzLEyKX/vX1w
 kbd/m0rjQanZew27ObKBLPNyvhv1btmk/eM7037nSzU+lHAJ0JcHMJPAsat6H7tQ3ooY
 FRX8mtfYGuFnHyCA83z8je7EbCXxs4on2uV5jRzCNpBX/87AfzJcqzQJxr0OWN88Snmw
 Vg+ZJ3mtIBRhNb+W6H7jXKs5FF9PLfn7c/i+mcAHagy2JWX9CkFsuPQ8fQxCPQ7WdcJe
 aa7w==
X-Gm-Message-State: AOJu0YxeQ7pZLZQf7G+cf7E68kBeiauASpf1UpYod4KNK7qbB0/C5X4F
 MgkYTwWwqLLED2CQpe5X2PvmpVTIqVzT4WsQoPzPc/xcyj9tbe/TvOkzLMz4lg==
X-Gm-Gg: AY/fxX6htPxi4P+HACXzJvNDkMO6sRYXkB9rRLGEHPUr2BFkdcbnx/6CqDSp/7m41KS
 tJuOXO6HtFvq2pKCakOX5PWNyCyYcMLJ8K5BT7VxKqGXWBLekp4Mz4EnTIzd1ReFQfGZpkBTL+q
 kfZIdmcyYz6YcpNqEyBFaHVe/YvaxqXksGn8gK3DlszGuaMfrebrbH0dgJcyG/DyWft/2t3aVH4
 74/B5aqLtsxlQu1nmyiFogrxl7Lbcq4i3knmMYtXDLQSPDcIfyj7qhpdDJJ1oUGstKZ1ESjdRpC
 GSwmNWuyOaSWtT1GTsHgZaDIRZ4ThjJf5XHdFMM4UdR54gjOpPIT4LskkXFtmo5BQuhV7y60k5p
 iav6FuhZBoD94+lQrURZpPlTuVCk3r/iJmgX5680qorF6bScm2NgP7hCBHuB6gWmRVRD3dwEFQp
 01dbGqpQpFgaiYfXB7lpnvVOXqAYEQTQ17GyYjNVVrzA==
X-Google-Smtp-Source: AGHT+IEvC/JiPFbvw1p8EReGfYUuCXJnRvYE5d+c4WDGFNraCrk44Ao2qm3HJJ3rulL/H+MzOSP5jw==
X-Received: by 2002:a05:620a:4620:b0:8b2:7679:4d12 with SMTP id
 af79cd13be357-8c389397ca1mr2379143485a.26.1768219457389; 
 Mon, 12 Jan 2026 04:04:17 -0800 (PST)
Received: from st47p01nt-relayp04.apple.com ([2620:149:13c1:500::12])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f5433c6sm1547713885a.52.2026.01.12.04.04.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 04:04:17 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v14 2/2] net: __rte_raw_cksum pointers enable compiler
 optimizations
Date: Mon, 12 Jan 2026 07:04:11 -0500
Message-Id: <20260112120411.27314-3-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260112120411.27314-1-scott.k.mitch1@gmail.com>
References: <20260112120411.27314-1-scott.k.mitch1@gmail.com>
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
index 0000000000..839861f57d
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

