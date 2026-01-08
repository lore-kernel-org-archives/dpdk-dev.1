Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41589D1D48A
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 21:26:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90F7A402DE;
	Thu,  8 Jan 2026 22:26:55 +0100 (CET)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id 56FFD4028C
 for <dev@dpdk.org>; Thu,  8 Jan 2026 22:26:54 +0100 (CET)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-88a2d21427dso37146736d6.3
 for <dev@dpdk.org>; Thu, 08 Jan 2026 13:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767907613; x=1768512413; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XHNdiyU22irlWw4Wh5wuPsPh3VkxUxtJLGKYxUtoid0=;
 b=c1JsYTNBtaUifbQiTl6nAgU8aGbZ7uzT9zJI7/FFE9m94I1I/9wwb8keul3FFa1Pef
 ISMGd4CGtF7B4WnwdJqDvVV9uNvz8e6yv46+gAmWQrhfTZ5HcuH2peTrH9s9HuJIc4Pp
 3aE2gOIXZEs14w/EAy1hKQXuqkYG3DyxPYPYjcdfokF+KZx2sgqHdYbPTKr//+H2H7tj
 jqjZaLFsKuWUhHLTt60h7rHcrCtExkl6xFFRatuaVj2a/3M3U4DZXJs9NppyGaYjKTvO
 PoFVQ1pQCrxZF9VEx7y8B5VdhI4rZV4OtbJEl0b8iEwKWvEFwBYFQ/RFE5o/5/ZMkwmG
 OcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767907613; x=1768512413;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHNdiyU22irlWw4Wh5wuPsPh3VkxUxtJLGKYxUtoid0=;
 b=RBpDNL5WdsNF7NBg4tSKtnDzW2Orl+oZXYrkDJeYYdI59zbCJY7jMkbKNsV+pHjpwy
 wiGU5So8F8NwLy8oRgviganBwZOp+Mz294xEWVNSa9luLyDsYOxHADmDW8cu5xMDFMdk
 BHCIEN2vkspPJYJk3pAlbrDF2/fVTu+Q+eWcqH6t3qBclWtc+3Oe9tXoaqHOaYzrlpam
 qhMK9gAJYGeUxFDPJLa4FAE8C/YGBwGgw9NkrbvIEDCH67ATyKOXX5mro4re8b+/bau1
 7tPiYEUTEmkxiUMeGpxf5TRquCExqB8atnve34fAgYZ5Y2xScwYZfcAUmRGdLT+F6tDL
 yrCQ==
X-Gm-Message-State: AOJu0Ywm2+tmmMxbg6fw4GvNbJjMEt72ndJrRNtwNde0d0ElUGijNK8P
 AW4XghplzG+2EtEksLct3SItzzQ5pjlevN9+jz04COH0Ivr4/GSdOlnv/s04fA==
X-Gm-Gg: AY/fxX6c8w/acSbbqMFSixtYGImO7KxGdHRryqLK1vvqFGRIXWQdwMVgt95QiigwQaY
 VYnpvoYkNVY6h0FwlK8GxLNRp4baffbkJTFS8paHFkhyUdypCul27ViXKYc7pqoZjTS9qYIEXf8
 ZC3/vdlKsPQszCuHswHW3SVPlRIhV7TcyLrJSdYISPGC9yuRqdtylH1z5H9wC+kjFlHU8rW1pgE
 tXYpatBfdx9+EB0UBZdaTh58m2NKLJ1LvufknXdSauWgntTL4MAUfTwx/+q1sGkf5Mqt/tHCHGT
 mbT06EmbfmPCjM2HYghPrM47K8CRLUsjoY8yW4dQLXYsuCe6pCf+ccDGYS2cyWmoaAyGjMrSrjj
 8qb/csnaHtxlVX9semGep7EUQ3FU8yHvB5cMEPejQVrGyxJBEQiELE9jGauWjmMuwOZgq3g9PYF
 yPsVbGXlyze6lDk+oIDHpTegvfCndEMM2s4XcnSO1s8ln0hrNBPO+ixdMO6A==
X-Google-Smtp-Source: AGHT+IFprdsHhwylps+qOQ6GEoA/aR5HhsktLmJb8wUJnprifGx68Y1lmpLKw6TA5IT2taQRWpB4og==
X-Received: by 2002:a05:6214:2f06:b0:88a:2578:9fa9 with SMTP id
 6a1803df08f44-89084179b9bmr99488776d6.2.1767907613323; 
 Thu, 08 Jan 2026 13:26:53 -0800 (PST)
Received: from st47p01nt-relayp01.apple.com
 ([2601:182:b80:6a50:314a:3f86:1924:bd42])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8907724ef14sm61263886d6.38.2026.01.08.13.26.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Jan 2026 13:26:53 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v8] net: optimize raw checksum computation
Date: Thu,  8 Jan 2026 16:26:46 -0500
Message-Id: <20260108212646.38872-1-scott.k.mitch1@gmail.com>
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
Changes in v8:
- __rte_raw_cksum: use native pointer arithmetic instead of RTE_PTR_ADD
  to avoid incorrect results with -O3 for UDP checksums. Also improves
  performance due to less assembly generated with Clang.
- Added __rte_no_ubsan_alignment attribute to suppress false UBSAN warnings
- Added RTE_SUPPRESS_UNINITIALIZED_WARNING macro for GCC workaround
- Fixed C++ compilation errors in rte_ip4.h and rte_ip6.h
- Formatted complex ternary expressions for readability

Changes in v7:
- Replaced pointer arithmetic with RTE_PTR_ADD/RTE_ALIGN_FLOOR for DPDK consistency
  (BROKEN - Clang alias analysis bug causes incorrect UDP checksums)

Changes in v6:
- Fixed GCC -Wmaybe-uninitialized false positive in mlx5 driver

Changes in v5:
- Replaced memcpy loop with direct pointer access to enable vectorization
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

---
 app/test/meson.build             |   1 +
 app/test/test_cksum_fuzz.c       | 240 +++++++++++++++++++++++++++++++
 app/test/test_cksum_perf.c       |   2 +-
 drivers/net/hinic/hinic_pmd_tx.c |  38 +----
 drivers/net/mlx5/mlx5_flow_dv.c  |   2 +
 lib/eal/include/rte_common.h     |  22 +++
 lib/net/rte_cksum.h              |  18 +--
 lib/net/rte_ip4.h                |  26 ++--
 lib/net/rte_ip6.h                |  17 ++-
 9 files changed, 294 insertions(+), 72 deletions(-)
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
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 47f6d28410..4f77a1e4f1 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -4445,6 +4445,8 @@ __flow_encap_decap_resource_register(struct rte_eth_dev *dev,
 			.reserve = 0,
 		}
 	};
+	RTE_SUPPRESS_UNINITIALIZED_WARNING(encap_decap_key);
+
 	struct mlx5_flow_cb_ctx ctx = {
 		.error = error,
 		.data = resource,
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 9e7d84f929..044275c2bd 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -546,6 +546,28 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
 #define __rte_no_asan
 #endif
 
+/**
+ * Disable UndefinedBehaviorSanitizer alignment check on some code
+ */
+#if defined(RTE_CC_CLANG) || defined(RTE_CC_GCC)
+#define __rte_no_ubsan_alignment __attribute__((no_sanitize("alignment")))
+#else
+#define __rte_no_ubsan_alignment
+#endif
+
+/**
+ * Suppress GCC -Wmaybe-uninitialized false positive on struct initialization.
+ * This tells the compiler that the variable's memory has been touched,
+ * preventing the false positive without affecting other optimizations.
+ */
+#ifdef RTE_CC_GCC
+#define RTE_SUPPRESS_UNINITIALIZED_WARNING(var) do {	\
+	asm volatile("" : "+m" (var));			\
+} while (0)
+#else
+#define RTE_SUPPRESS_UNINITIALIZED_WARNING(var)
+#endif
+
 /*********** Macros for pointer arithmetic ********/
 
 /**
diff --git a/lib/net/rte_cksum.h b/lib/net/rte_cksum.h
index a8e8927952..364f519455 100644
--- a/lib/net/rte_cksum.h
+++ b/lib/net/rte_cksum.h
@@ -39,23 +39,19 @@ extern "C" {
  * @return
  *   sum += Sum of all words in the buffer.
  */
+__rte_no_ubsan_alignment
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
+	const unaligned_uint16_t *end = buf16 + (len / sizeof(uint16_t));
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
index 822a660cfb..63852717c9 100644
--- a/lib/net/rte_ip4.h
+++ b/lib/net/rte_ip4.h
@@ -223,21 +223,17 @@ rte_ipv4_phdr_cksum(const struct rte_ipv4_hdr *ipv4_hdr, uint64_t ol_flags)
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
+		.len = (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
+			? (uint16_t)0
+			: rte_cpu_to_be_16((uint16_t)(rte_be_to_cpu_16(ipv4_hdr->total_length) -
+					rte_ipv4_hdr_len(ipv4_hdr)))
+	};
+	RTE_SUPPRESS_UNINITIALIZED_WARNING(psd_hdr);
+
 	return rte_raw_cksum(&psd_hdr, sizeof(psd_hdr));
 }
 
diff --git a/lib/net/rte_ip6.h b/lib/net/rte_ip6.h
index d1abf1f5d5..8a7e5e4b8a 100644
--- a/lib/net/rte_ip6.h
+++ b/lib/net/rte_ip6.h
@@  -560,19 +560,18 @@ rte_ipv6_phdr_cksum(const struct rte_ipv6_hdr *ipv6_hdr, uint64_t ol_flags)
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
+		.len = (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
+			? (rte_be32_t)0
+			: ipv6_hdr->payload_len,
+		.proto = (uint32_t)(ipv6_hdr->proto << 24)
+	};
+	RTE_SUPPRESS_UNINITIALIZED_WARNING(psd_hdr);
 
-	sum = __rte_raw_cksum(&ipv6_hdr->src_addr,
+	uint32_t sum = __rte_raw_cksum(&ipv6_hdr->src_addr,
 		sizeof(ipv6_hdr->src_addr) + sizeof(ipv6_hdr->dst_addr),
 		0);
 	sum = __rte_raw_cksum(&psd_hdr, sizeof(psd_hdr), sum);
-- 
2.39.5 (Apple Git-154)

