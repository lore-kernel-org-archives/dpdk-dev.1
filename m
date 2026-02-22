Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8370C636A0
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 15:30:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AD8640608;
	Sun, 22 Feb 2026 16:30:46 +0100 (CET)
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com
 [95.215.58.176]) by mails.dpdk.org (Postfix) with ESMTP id 97641402E6
 for <dev@dpdk.org>; Sun, 22 Feb 2026 16:30:37 +0100 (CET)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danielg0.com;
 s=key1; t=1771774237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1a//jTJe72c+XR7y38Km5rraZnf+60kM4ql9oJwiZLE=;
 b=W6w/iV65LLwVVnHSsC2St0XdGzqMRa32qS7r/bplKY1Dvx2LBjQhjercbCpMy+lWY26GuW
 I3OZIe4N3b0It3uJYc18BQeupWeRS/b6R7VriDQ4GtdzYZp9Z+AqRZHesseMvW8KAAnkpI
 tafMrZ2cy9Tws5Yq4YNwvKctmni78uo=
From: Daniel Gregory <code@danielg0.com>
To: =?UTF-8?q?Stanis=C5=82aw=20Kardach?= <stanislaw.kardach@gmail.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Sun Yuechi <sunyuechi@iscas.ac.cn>
Cc: Daniel Gregory <daniel.gregory@bytedance.com>, dev@dpdk.org,
 Punit Agrawal <punit.agrawal@bytedance.com>,
 Liang Ma <liangma@liangbit.com>,
 Pengcheng Wang <wangpengcheng.pp@bytedance.com>,
 Chunsong Feng <fengchunsong@bytedance.com>
Subject: [PATCH v4 02/10] hash: implement CRC using riscv carryless multiply
Date: Sun, 22 Feb 2026 16:29:56 +0100
Message-ID: <d71a1cdba644ace64566d62b1d5364b7cf8202d8.1771772598.git.code@danielg0.com>
In-Reply-To: <cover.1771772598.git.code@danielg0.com>
References: <20240827153230.52880-1-daniel.gregory@bytedance.com>
 <cover.1771772598.git.code@danielg0.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

From: Daniel Gregory <daniel.gregory@bytedance.com>

Using carryless multiply instructions from RISC-V's Zbc extension,
implement a Barrett reduction that calculates CRC-32C checksums.

Based on the approach described by Intel's whitepaper on "Fast CRC
Computation for Generic Polynomials Using PCLMULQDQ Instruction", which
is also described here
(https://web.archive.org/web/20240111232520/https://mary.rs/lab/crc32/)

Add a case to the autotest_hash unit test.

Signed-off-by: Daniel Gregory <daniel.gregory@bytedance.com>
---
 MAINTAINERS                |  1 +
 app/test/test_hash.c       |  7 +++
 lib/hash/meson.build       |  1 +
 lib/hash/rte_crc_riscv64.h | 90 ++++++++++++++++++++++++++++++++++++++
 lib/hash/rte_hash_crc.c    | 13 +++++-
 lib/hash/rte_hash_crc.h    |  6 ++-
 6 files changed, 116 insertions(+), 2 deletions(-)
 create mode 100644 lib/hash/rte_crc_riscv64.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b2f1ed2ba..aac1c48cd3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -338,6 +338,7 @@ M: Stanisław Kardach <stanislaw.kardach@gmail.com>
 F: config/riscv/
 F: doc/guides/linux_gsg/cross_build_dpdk_for_riscv.rst
 F: lib/eal/riscv/
+F: lib/hash/rte_crc_riscv64.h
 M: Sun Yuechi <sunyuechi@iscas.ac.cn>
 F: lib/**/*rvv*
 
diff --git a/app/test/test_hash.c b/app/test/test_hash.c
index 3fb3d96d05..74aaed440e 100644
--- a/app/test/test_hash.c
+++ b/app/test/test_hash.c
@@ -231,6 +231,13 @@ test_crc32_hash_alg_equiv(void)
 			printf("Failed checking CRC32_SW against CRC32_ARM64\n");
 			break;
 		}
+
+		/* Check against 8-byte-operand RISCV64 CRC32 if available */
+		rte_hash_crc_set_alg(CRC32_RISCV64);
+		if (hash_val != rte_hash_crc(data64, data_len, init_val)) {
+			printf("Failed checking CRC32_SW against CRC32_RISCV64\n");
+			break;
+		}
 	}
 
 	/* Resetting to best available algorithm */
diff --git a/lib/hash/meson.build b/lib/hash/meson.build
index 7ce504ee8b..2e6db933a9 100644
--- a/lib/hash/meson.build
+++ b/lib/hash/meson.build
@@ -12,6 +12,7 @@ headers = files(
 indirect_headers += files(
         'rte_crc_arm64.h',
         'rte_crc_generic.h',
+        'rte_crc_riscv64.h',
         'rte_crc_sw.h',
         'rte_crc_x86.h',
         'rte_thash_x86_gfni.h',
diff --git a/lib/hash/rte_crc_riscv64.h b/lib/hash/rte_crc_riscv64.h
new file mode 100644
index 0000000000..4e0fff5098
--- /dev/null
+++ b/lib/hash/rte_crc_riscv64.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 ByteDance
+ */
+
+#ifndef _RTE_CRC_RISCV64_H_
+#define _RTE_CRC_RISCV64_H_
+
+#include <stdint.h>
+
+#include <riscv_bitmanip.h>
+
+#include <rte_debug.h>
+
+/*
+ * CRC-32C takes a reflected input (bit 7 is the lsb) and produces a reflected
+ * output. As reflecting the value we're checksumming is expensive, we instead
+ * reflect the polynomial P (0x11EDC6F41) and mu and our CRC32 algorithm.
+ *
+ * The mu constant is used for a Barrett reduction. It's 2^96 / P (0x11F91CAF6)
+ * reflected. Picking 2^96 rather than 2^64 means we can calculate a 64-bit crc
+ * using only two multiplications (https://mary.rs/lab/crc32/)
+ */
+static const uint64_t p = 0x105EC76F1;
+static const uint64_t mu = 0x4869EC38DEA713F1UL;
+
+/* Calculate the CRC32C checksum using a Barrett reduction */
+static inline uint32_t
+crc32c_riscv64(uint64_t data, uint32_t init_val, uint32_t bits)
+{
+	RTE_ASSERT((bits == 64) || (bits == 32) || (bits == 16) || (bits == 8));
+
+	/* Combine data with the initial value */
+	uint64_t crc = (uint64_t)(data ^ init_val) << (64 - bits);
+
+	/*
+	 * Multiply by mu, which is 2^96 / P. Division by 2^96 occurs by taking
+	 * the lower 64 bits of the result (remember we're inverted)
+	 */
+	crc = __riscv_clmul_64(crc, mu);
+	/* Multiply by P */
+	crc = __riscv_clmulh_64(crc, p);
+
+	/* Subtract from original (only needed for smaller sizes) */
+	if (bits == 16 || bits == 8)
+		crc ^= init_val >> bits;
+
+	return crc;
+}
+
+/*
+ * Use carryless multiply to perform hash on a value, falling back on the
+ * software in case the Zbc extension is not supported
+ */
+static inline uint32_t
+rte_hash_crc_1byte(uint8_t data, uint32_t init_val)
+{
+	if (likely((rte_hash_crc32_alg & CRC32_RISCV64) != 0))
+		return crc32c_riscv64(data, init_val, 8);
+
+	return crc32c_1byte(data, init_val);
+}
+
+static inline uint32_t
+rte_hash_crc_2byte(uint16_t data, uint32_t init_val)
+{
+	if (likely((rte_hash_crc32_alg & CRC32_RISCV64) != 0))
+		return crc32c_riscv64(data, init_val, 16);
+
+	return crc32c_2bytes(data, init_val);
+}
+
+static inline uint32_t
+rte_hash_crc_4byte(uint32_t data, uint32_t init_val)
+{
+	if (likely((rte_hash_crc32_alg & CRC32_RISCV64) != 0))
+		return crc32c_riscv64(data, init_val, 32);
+
+	return crc32c_1word(data, init_val);
+}
+
+static inline uint32_t
+rte_hash_crc_8byte(uint64_t data, uint32_t init_val)
+{
+	if (likely((rte_hash_crc32_alg & CRC32_RISCV64) != 0))
+		return crc32c_riscv64(data, init_val, 64);
+
+	return crc32c_2words(data, init_val);
+}
+
+#endif /* _RTE_CRC_RISCV64_H_ */
diff --git a/lib/hash/rte_hash_crc.c b/lib/hash/rte_hash_crc.c
index 523be0bf92..939753f436 100644
--- a/lib/hash/rte_hash_crc.c
+++ b/lib/hash/rte_hash_crc.c
@@ -17,7 +17,7 @@ RTE_EXPORT_SYMBOL(rte_hash_crc32_alg)
 uint8_t rte_hash_crc32_alg = CRC32_SW;
 
 /**
- * Allow or disallow use of SSE4.2/ARMv8 intrinsics for CRC32 hash
+ * Allow or disallow use of SSE4.2/ARMv8/RISC-V intrinsics for CRC32 hash
  * calculation.
  *
  * @param alg
@@ -26,6 +26,7 @@ uint8_t rte_hash_crc32_alg = CRC32_SW;
  *   - (CRC32_SSE42) Use SSE4.2 intrinsics if available
  *   - (CRC32_SSE42_x64) Use 64-bit SSE4.2 intrinsic if available (default x86)
  *   - (CRC32_ARM64) Use ARMv8 CRC intrinsic if available (default ARMv8)
+ *   - (CRC32_RISCV64) Use RISCV64 Zbc extension if available
  */
 RTE_EXPORT_SYMBOL(rte_hash_crc_set_alg)
 void
@@ -54,6 +55,14 @@ rte_hash_crc_set_alg(uint8_t alg)
 		rte_hash_crc32_alg = CRC32_ARM64;
 #endif
 
+#if defined(RTE_ARCH_RISCV) && defined(RTE_RISCV_FEATURE_ZBC)
+	if (!(alg & CRC32_RISCV64))
+		HASH_CRC_LOG(WARNING,
+			"Unsupported CRC32 algorithm requested using CRC32_RISCV64");
+	if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_RISCV_EXT_ZBC))
+		rte_hash_crc32_alg = CRC32_RISCV64;
+#endif
+
 	if (rte_hash_crc32_alg == CRC32_SW)
 		HASH_CRC_LOG(WARNING,
 			"Unsupported CRC32 algorithm requested using CRC32_SW");
@@ -66,6 +75,8 @@ RTE_INIT(rte_hash_crc_init_alg)
 	rte_hash_crc_set_alg(CRC32_SSE42_x64);
 #elif defined(RTE_ARCH_ARM64) && defined(__ARM_FEATURE_CRC32)
 	rte_hash_crc_set_alg(CRC32_ARM64);
+#elif defined(RTE_ARCH_RISCV) && defined(RTE_RISCV_FEATURE_ZBC)
+	rte_hash_crc_set_alg(CRC32_RISCV64);
 #else
 	rte_hash_crc_set_alg(CRC32_SW);
 #endif
diff --git a/lib/hash/rte_hash_crc.h b/lib/hash/rte_hash_crc.h
index fa07c97685..3b23b98283 100644
--- a/lib/hash/rte_hash_crc.h
+++ b/lib/hash/rte_hash_crc.h
@@ -24,6 +24,7 @@
 #define CRC32_x64           (1U << 2)
 #define CRC32_SSE42_x64     (CRC32_x64|CRC32_SSE42)
 #define CRC32_ARM64         (1U << 3)
+#define CRC32_RISCV64       (1U << 4)
 
 extern uint8_t rte_hash_crc32_alg;
 
@@ -31,6 +32,8 @@ extern uint8_t rte_hash_crc32_alg;
 #include "rte_crc_arm64.h"
 #elif defined(RTE_ARCH_X86)
 #include "rte_crc_x86.h"
+#elif defined(RTE_ARCH_RISCV) && defined(RTE_RISCV_FEATURE_ZBC)
+#include "rte_crc_riscv64.h"
 #else
 #include "rte_crc_generic.h"
 #endif
@@ -40,7 +43,7 @@ extern "C" {
 #endif
 
 /**
- * Allow or disallow use of SSE4.2/ARMv8 intrinsics for CRC32 hash
+ * Allow or disallow use of SSE4.2/ARMv8/RISC-V intrinsics for CRC32 hash
  * calculation.
  *
  * @param alg
@@ -49,6 +52,7 @@ extern "C" {
  *   - (CRC32_SSE42) Use SSE4.2 intrinsics if available
  *   - (CRC32_SSE42_x64) Use 64-bit SSE4.2 intrinsic if available (default x86)
  *   - (CRC32_ARM64) Use ARMv8 CRC intrinsic if available (default ARMv8)
+ *   - (CRC32_RISCV64) Use RISC-V Carry-less multiply if available (default rv64gc_zbc)
  */
 void
 rte_hash_crc_set_alg(uint8_t alg);
-- 
2.53.0

