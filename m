Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB0CD148A3
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 06:14:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 782BA4028C;
	Thu,  8 Jan 2026 07:14:04 +0100 (CET)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id 51D0240261
 for <dev@dpdk.org>; Thu,  8 Jan 2026 07:14:03 +0100 (CET)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-8b2f2c5ec36so319029085a.1
 for <dev@dpdk.org>; Wed, 07 Jan 2026 22:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767852842; x=1768457642; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FDtFoTKTeGK8pcoLUrDneJhNB3vVSON077GhGMJJoLA=;
 b=IjjLsHtin6C4nSE+wAxp47opiCG998T5ExTOqYUTAA1hMsTbq/gKT5ddpys/Wc4qHK
 fd11Ws4h4hL8h8qfqhQmKJ4tNlhtVbjw7Iv2flaDH+SpWb+lYn13Oh8ctwIiUpKz6Dm+
 NEgkNHgjj7ajX/ry1s0JCh/D0uZMDlagLZ/Qs2U2oT8eh4l20tO9AGOnNIGelqOo+En6
 hXJxWv6EE4ZWMB/QRsvJE+GgDf9H9Uc+Ji9R9DtbueFWpjB/uJx2xoMzfQZllesj2FdF
 ugDTF849TYqX2bS9q+iDpEmdl1/WmxsXFNTpI47Xv1pblJ/dTOnYyF2MCJQc0dEfW6tb
 rakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767852842; x=1768457642;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FDtFoTKTeGK8pcoLUrDneJhNB3vVSON077GhGMJJoLA=;
 b=lAYPqN0EMNXpOGBQrchRKIjf5KVuHsP7MROOVj/5jiBsxWwX5J8eGFFauMCWfdb+a8
 sPbM4ig+pMy3byi43IuiNFZN7RUc0KTf7tuHuhbWR98R2kvrlnACcCJ48fDy+hKqV+RQ
 46c4lcTnXm6JrHxUPShGmWveLdXsd/kGmOtp5lVl/1qoSfpSUd4Z1LiLPRoEgKR2Bdfy
 c5NFyVoGlbQIaIacOqhKUJ+GX/wHrwv/iSiDcFNkNXoyNKtTa2CQVPL3gZbs5fEhYOHX
 Sed7CrzowyOxP1o100Fl4W4Rer5Sbgk1Cmo2H9MN4rhCoRxdDjiXdTpPvfQvz7VLH1jy
 SxPg==
X-Gm-Message-State: AOJu0Ywk4W7v1YrJUaQ929SkZdAXAX0VjZFSfWg2CCvSn8COfcDZ/lbV
 He/dVt72c6Y+7Qr0nwP6wjBa+hI6bzA8d3MXxTueIGIvp1BsdGfodO0lVXyiLg==
X-Gm-Gg: AY/fxX4bj4aTNgd1XXL/00bClmpGI9xbQQYSqYTzpJl+2om48FKyr8MwWy2EgY9mELb
 wul5syOx44ET9RtE2juI05DMNJULEpFMd/h/rDduIB5xAxLLAtvlc/l6L6gsIiJ+ht/CFAFUOHQ
 Gb9dLaFnNqSaQuwlpgFWVgi2B8i+LTppVGpvLQyjoQegvMb+dpJhJPLWnyKXyCONN53TbdThKmE
 nVtqUUbtZZY1+WtMMT7rk5vp/kO2YRx+xAptY5KK1VFeJIVjdQ0Z6z+NE3pMYAvdxMVOatlqIfN
 GKwJincfK77yWoqIRS9wj1f786ix3YiTVj8qei1btY6EKUeKDvY7a0F+mDz8kZKsWHZJIB7q/ee
 4q07D3VFQ7i1V0QcZK5HLYK8dDl8ughz2MnxPEbkBZHgM7QUyGbgp/FLmpiqPA6sIJNBGFFMcMw
 m/bzkZiMfi6ykZjjLmALf3krirk0yLxmxm6HbYvYkjhiH+GaVuD+saxDJKzQ==
X-Google-Smtp-Source: AGHT+IEkID838THhjdzUi8GVkTTSmBb7hMkaLceV24KIvmgcH2bTIJZqrQx3nKbG0NJkD6P1pV3nTg==
X-Received: by 2002:a05:620a:414a:b0:88f:c5d4:504e with SMTP id
 af79cd13be357-8c38941627emr664777885a.81.1767852842149; 
 Wed, 07 Jan 2026 22:14:02 -0800 (PST)
Received: from st57p01nt-relayp04.apple.com
 ([2601:182:b80:6a50:75d8:5eda:abb3:12c5])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f51ceb5sm565690685a.35.2026.01.07.22.14.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 22:14:01 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v5] net: optimize raw checksum computation
Date: Thu,  8 Jan 2026 01:13:38 -0500
Message-Id: <20260108061338.27217-1-scott.k.mitch1@gmail.com>
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
Changes in v5:
- Simplified __rte_raw_cksum pointer arithmetic using type-safe uint16_t*
  instead of RTE_PTR_ADD byte arithmetic
- Fixed GCC -Wmaybe-uninitialized false-positive warnings in rte_ipv4_phdr_cksum
  and rte_ipv6_phdr_cksum using compiler barriers (no assembly impact)
- Refactored hinic driver's local phdr_cksum implementations to call common
  functions, eliminating duplication
- Simplified phdr_cksum struct initialization with designated initializers

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

 app/test/meson.build             |   1 +
 app/test/test_cksum_fuzz.c       | 241 +++++++++++++++++++++++++++++++
 app/test/test_cksum_perf.c       |   2 +-
 drivers/net/hinic/hinic_pmd_tx.c |  38 +----
 lib/net/rte_cksum.h              |  19 +--
 lib/net/rte_ip4.h                |  28 ++--
 lib/net/rte_ip6.h                |  19 +--
 7 files changed, 276 insertions(+), 72 deletions(-)
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
diff --git a/drivers/net/hinic/hinic_pmd_tx.c b/drivers/net/hinic/hinic_pmd_tx.c
index 22fb0bffaf..6b36ad84fd 100644
--- a/drivers/net/hinic/hinic_pmd_tx.c
+++ b/drivers/net/hinic/hinic_pmd_tx.c
@@ -706,47 +706,13 @@ hinic_get_sq_wqe(struct hinic_txq *txq, int wqebb_cnt,
 static inline uint16_t
 hinic_ipv4_phdr_cksum(const struct rte_ipv4_hdr *ipv4_hdr, uint64_t ol_flags)
 {
-	struct ipv4_psd_header {
-		uint32_t src_addr; /* IP address of source host. */
-		uint32_t dst_addr; /* IP address of destination host. */
-		uint8_t  zero;     /* zero. */
-		uint8_t  proto;    /* L4 protocol type. */
-		uint16_t len;      /* L4 length. */
-	} psd_hdr;
-
-	psd_hdr.src_addr = ipv4_hdr->src_addr;
-	psd_hdr.dst_addr = ipv4_hdr->dst_addr;
-	psd_hdr.zero = 0;
-	psd_hdr.proto = ipv4_hdr->next_proto_id;
-	if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
-		psd_hdr.len = 0;
-	} else {
-		psd_hdr.len =
-		rte_cpu_to_be_16(rte_be_to_cpu_16(ipv4_hdr->total_length) -
-				 rte_ipv4_hdr_len(ipv4_hdr));
-	}
-	return rte_raw_cksum(&psd_hdr, sizeof(psd_hdr));
+	return rte_ipv4_phdr_cksum(ipv4_hdr, ol_flags & RTE_MBUF_F_TX_TCP_SEG);
 }
 
 static inline uint16_t
 hinic_ipv6_phdr_cksum(const struct rte_ipv6_hdr *ipv6_hdr, uint64_t ol_flags)
 {
-	uint32_t sum;
-	struct {
-		uint32_t len;   /* L4 length. */
-		uint32_t proto; /* L4 protocol - top 3 bytes must be zero */
-	} psd_hdr;
-
-	psd_hdr.proto = (ipv6_hdr->proto << 24);
-	if (ol_flags & RTE_MBUF_F_TX_TCP_SEG)
-		psd_hdr.len = 0;
-	else
-		psd_hdr.len = ipv6_hdr->payload_len;
-
-	sum = __rte_raw_cksum(&ipv6_hdr->src_addr,
-		sizeof(ipv6_hdr->src_addr) + sizeof(ipv6_hdr->dst_addr), 0);
-	sum = __rte_raw_cksum(&psd_hdr, sizeof(psd_hdr), sum);
-	return __rte_raw_cksum_reduce(sum);
+	return rte_ipv6_phdr_cksum(ipv6_hdr, ol_flags & RTE_MBUF_F_TX_TCP_SEG);
 }
 
 static inline void hinic_get_outer_cs_pld_offset(struct rte_mbuf *m,
diff --git a/lib/net/rte_cksum.h b/lib/net/rte_cksum.h
index a8e8927952..2e8b1384aa 100644
--- a/lib/net/rte_cksum.h
+++ b/lib/net/rte_cksum.h
@@ -42,20 +42,17 @@ extern "C" {
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
+	/* Process as uint16 chunks to preserve overflow/carry math. */
+	const unaligned_uint16_t *buf16 = (const unaligned_uint16_t *)buf;
+	/* Divide byte length by 2 to get number of uint16_t elements. */
+	const unaligned_uint16_t *end = buf16 + (len >> 1);
+	/* GCC and Clang vectorize the loop. */
+	for (; buf16 != end; buf16++)
+		sum += *buf16;
 
 	/* if length is odd, keeping it byte order independent */
-	if (unlikely(len % 2)) {
+	if (len & 1) {
 		uint16_t left = 0;
-
 		memcpy(&left, end, 1);
 		sum += left;
 	}
diff --git a/lib/net/rte_ip4.h b/lib/net/rte_ip4.h
index 822a660cfb..67033875cc 100644
--- a/lib/net/rte_ip4.h
+++ b/lib/net/rte_ip4.h
@@ -223,21 +223,19 @@ rte_ipv4_phdr_cksum(const struct rte_ipv4_hdr *ipv4_hdr, uint64_t ol_flags)
 		uint8_t  zero;     /* zero. */
 		uint8_t  proto;    /* L4 protocol type. */
 		uint16_t len;      /* L4 length. */
-	} psd_hdr;
-
-	uint32_t l3_len;
-
-	psd_hdr.src_addr = ipv4_hdr->src_addr;
-	psd_hdr.dst_addr = ipv4_hdr->dst_addr;
-	psd_hdr.zero = 0;
-	psd_hdr.proto = ipv4_hdr->next_proto_id;
-	if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) {
-		psd_hdr.len = 0;
-	} else {
-		l3_len = rte_be_to_cpu_16(ipv4_hdr->total_length);
-		psd_hdr.len = rte_cpu_to_be_16((uint16_t)(l3_len -
-			rte_ipv4_hdr_len(ipv4_hdr)));
-	}
+	} psd_hdr = {
+		.src_addr = ipv4_hdr->src_addr,
+		.dst_addr = ipv4_hdr->dst_addr,
+		.proto = ipv4_hdr->next_proto_id,
+		.len = (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) ? 0 :
+			rte_cpu_to_be_16((uint16_t)(rte_be_to_cpu_16(ipv4_hdr->total_length) -
+				rte_ipv4_hdr_len(ipv4_hdr)))
+	};
+#ifdef RTE_CC_GCC
+	/* Suppress GCC -Wmaybe-uninitialized false positive. No assembly/runtime impacts. */
+	asm volatile("" : "+m" (psd_hdr));
+#endif
+
 	return rte_raw_cksum(&psd_hdr, sizeof(psd_hdr));
 }
 
diff --git a/lib/net/rte_ip6.h b/lib/net/rte_ip6.h
index d1abf1f5d5..e2896ac8bd 100644
--- a/lib/net/rte_ip6.h
+++ b/lib/net/rte_ip6.h
@@ -560,19 +560,20 @@ rte_ipv6_phdr_cksum(const struct rte_ipv6_hdr *ipv6_hdr, uint64_t ol_flags)
 static inline uint16_t
 rte_ipv6_phdr_cksum(const struct rte_ipv6_hdr *ipv6_hdr, uint64_t ol_flags)
 {
-	uint32_t sum;
 	struct {
 		rte_be32_t len;   /* L4 length. */
 		rte_be32_t proto; /* L4 protocol - top 3 bytes must be zero */
-	} psd_hdr;
-
-	psd_hdr.proto = (uint32_t)(ipv6_hdr->proto << 24);
-	if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
-		psd_hdr.len = 0;
-	else
-		psd_hdr.len = ipv6_hdr->payload_len;
+	} psd_hdr = {
+		.proto = (uint32_t)(ipv6_hdr->proto << 24),
+		.len = (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) ? 0 :
+			ipv6_hdr->payload_len
+	};
+#ifdef RTE_CC_GCC
+	/* Suppress GCC -Wmaybe-uninitialized false positive. No assembly/runtime impacts. */
+	asm volatile("" : "+m" (psd_hdr));
+#endif
 
-	sum = __rte_raw_cksum(&ipv6_hdr->src_addr,
+	uint32_t sum = __rte_raw_cksum(&ipv6_hdr->src_addr,
 		sizeof(ipv6_hdr->src_addr) + sizeof(ipv6_hdr->dst_addr),
 		0);
 	sum = __rte_raw_cksum(&psd_hdr, sizeof(psd_hdr), sum);
-- 
2.39.5 (Apple Git-154)

