Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37524C636A0
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 15:31:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 752C840616;
	Sun, 22 Feb 2026 16:30:47 +0100 (CET)
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com
 [95.215.58.179]) by mails.dpdk.org (Postfix) with ESMTP id 439D1402ED
 for <dev@dpdk.org>; Sun, 22 Feb 2026 16:30:39 +0100 (CET)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danielg0.com;
 s=key1; t=1771774238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y4TwV6ZTkNN7kp34IuULHpG+jVIevsStKyIJrVhmh3M=;
 b=FA2eI33FrUm9i01mfgxa9PcRyMgtUlGTE9LHcw95O9WgtCNORNsE2JOGQs5sd2XufFy774
 YF5nuJX6Ljt2527LhSS6QzoaNMalkfVIMt9no1JN4Ac2PcCqZriIXaCTp2IBMqblMoDAgJ
 rX22MIGSaZq287jBvOMCt3Mrf7uAtR4=
From: Daniel Gregory <code@danielg0.com>
To: =?UTF-8?q?Stanis=C5=82aw=20Kardach?= <stanislaw.kardach@gmail.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Jasvinder Singh <jasvinder.singh@intel.com>,
 Sun Yuechi <sunyuechi@iscas.ac.cn>
Cc: Daniel Gregory <daniel.gregory@bytedance.com>, dev@dpdk.org,
 Punit Agrawal <punit.agrawal@bytedance.com>,
 Liang Ma <liangma@liangbit.com>,
 Pengcheng Wang <wangpengcheng.pp@bytedance.com>,
 Chunsong Feng <fengchunsong@bytedance.com>
Subject: [PATCH v4 03/10] net: implement CRC using riscv carryless multiply
Date: Sun, 22 Feb 2026 16:29:57 +0100
Message-ID: <eb0fc35415ba5f54cebc4aec93dffdb88370e41f.1771772598.git.code@danielg0.com>
In-Reply-To: <cover.1771772598.git.code@danielg0.com>
References: <20240827153230.52880-1-daniel.gregory@bytedance.com>
 <cover.1771772598.git.code@danielg0.com>
MIME-Version: 1.0
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

Using carryless multiply instructions (clmul) from RISC-V's Zbc
extension, implement CRC-32 and CRC-16 calculations on buffers.

Based on the approach described in Intel's whitepaper on "Fast CRC
Computation for Generic Polynomails Using PCLMULQDQ Instructions", we
perform repeated folds-by-1 whilst the buffer is still big enough, then
perform Barrett's reductions on the rest.

Add a case to the crc_autotest suite that tests this implementation.

Signed-off-by: Daniel Gregory <daniel.gregory@bytedance.com>
---
 MAINTAINERS           |   1 +
 app/test/test_crc.c   |  10 +++
 lib/net/meson.build   |   4 +
 lib/net/net_crc.h     |  11 +++
 lib/net/net_crc_zbc.c | 194 ++++++++++++++++++++++++++++++++++++++++++
 lib/net/rte_net_crc.c |  30 ++++++-
 lib/net/rte_net_crc.h |   3 +
 7 files changed, 252 insertions(+), 1 deletion(-)
 create mode 100644 lib/net/net_crc_zbc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index aac1c48cd3..0f2cc5d87e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -339,6 +339,7 @@ F: config/riscv/
 F: doc/guides/linux_gsg/cross_build_dpdk_for_riscv.rst
 F: lib/eal/riscv/
 F: lib/hash/rte_crc_riscv64.h
+F: lib/net/net_crc_zbc.c
 M: Sun Yuechi <sunyuechi@iscas.ac.cn>
 F: lib/**/*rvv*
 
diff --git a/app/test/test_crc.c b/app/test/test_crc.c
index 4ff03e3f64..951eaf846f 100644
--- a/app/test/test_crc.c
+++ b/app/test/test_crc.c
@@ -96,6 +96,16 @@ crc_all_algs(const char *desc, enum rte_net_crc_type type,
 	}
 	rte_net_crc_free(ctx);
 
+	ctx = rte_net_crc_set_alg(RTE_NET_CRC_ZBC, type);
+	TEST_ASSERT_NOT_NULL(ctx, "cannot allocate the CRC context");
+	crc = rte_net_crc_calc(ctx, data, data_len);
+	if (crc != res) {
+		RTE_LOG(ERR, USER1, "TEST FAILED: %s ZBC\n", desc);
+		debug_hexdump(stdout, "ZBC", &crc, 4);
+		ret = TEST_FAILED;
+	}
+	rte_net_crc_free(ctx);
+
 	return ret;
 }
 
diff --git a/lib/net/meson.build b/lib/net/meson.build
index 3fad5edc5b..154af7d9ae 100644
--- a/lib/net/meson.build
+++ b/lib/net/meson.build
@@ -57,4 +57,8 @@ elif (dpdk_conf.has('RTE_ARCH_ARM64') and
         cc.get_define('__ARM_FEATURE_CRYPTO', args: machine_args) != '')
     sources += files('net_crc_neon.c')
     cflags += ['-DCC_ARM64_NEON_PMULL_SUPPORT']
+elif (dpdk_conf.has('RTE_ARCH_RISCV') and
+        cc.get_define('RTE_RISCV_FEATURE_ZBC', args: machine_args) != '')
+    sources += files('net_crc_zbc.c')
+    cflags += ['-DCC_RISCV64_ZBC_CLMUL_SUPPORT']
 endif
diff --git a/lib/net/net_crc.h b/lib/net/net_crc.h
index 320b0edca8..971f38afaa 100644
--- a/lib/net/net_crc.h
+++ b/lib/net/net_crc.h
@@ -44,4 +44,15 @@ rte_crc16_ccitt_neon_handler(const uint8_t *data, uint32_t data_len);
 uint32_t
 rte_crc32_eth_neon_handler(const uint8_t *data, uint32_t data_len);
 
+/* RISCV64 Zbc */
+void
+rte_net_crc_zbc_init(void);
+
+uint32_t
+rte_crc16_ccitt_zbc_handler(const uint8_t *data, uint32_t data_len);
+
+uint32_t
+rte_crc32_eth_zbc_handler(const uint8_t *data, uint32_t data_len);
+
+
 #endif /* _NET_CRC_H_ */
diff --git a/lib/net/net_crc_zbc.c b/lib/net/net_crc_zbc.c
new file mode 100644
index 0000000000..dfbdc641b5
--- /dev/null
+++ b/lib/net/net_crc_zbc.c
@@ -0,0 +1,194 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 ByteDance
+ */
+
+#include <riscv_bitmanip.h>
+#include <stdint.h>
+
+#include <rte_common.h>
+#include <rte_net_crc.h>
+
+#include "net_crc.h"
+
+/* CLMUL CRC computation context structure */
+struct crc_clmul_ctx {
+	uint64_t Pr;
+	uint64_t mu;
+	uint64_t k3;
+	uint64_t k4;
+	uint64_t k5;
+};
+
+static struct crc_clmul_ctx crc32_eth_clmul;
+static struct crc_clmul_ctx crc16_ccitt_clmul;
+
+/* Perform Barrett's reduction on 8, 16, 32 or 64-bit value */
+static inline uint32_t
+crc32_barrett_zbc(
+	const uint64_t data,
+	uint32_t crc,
+	uint32_t bits,
+	const struct crc_clmul_ctx *params)
+{
+	assert((bits == 64) || (bits == 32) || (bits == 16) || (bits == 8));
+
+	/* Combine data with the initial value */
+	uint64_t temp = (uint64_t)(data ^ crc) << (64 - bits);
+
+	/*
+	 * Multiply by mu, which is 2^96 / P. Division by 2^96 occurs by taking
+	 * the lower 64 bits of the result (remember we're inverted)
+	 */
+	temp = __riscv_clmul_64(temp, params->mu);
+	/* Multiply by P */
+	temp = __riscv_clmulh_64(temp, params->Pr);
+
+	/* Subtract from original (only needed for smaller sizes) */
+	if (bits == 16 || bits == 8)
+		temp ^= crc >> bits;
+
+	return temp;
+}
+
+/* Repeat Barrett's reduction for short buffer sizes */
+static inline uint32_t
+crc32_repeated_barrett_zbc(
+	const uint8_t *data,
+	uint32_t data_len,
+	uint32_t crc,
+	const struct crc_clmul_ctx *params)
+{
+	while (data_len >= 8) {
+		crc = crc32_barrett_zbc(*(const uint64_t *)data, crc, 64, params);
+		data += 8;
+		data_len -= 8;
+	}
+	if (data_len >= 4) {
+		crc = crc32_barrett_zbc(*(const uint32_t *)data, crc, 32, params);
+		data += 4;
+		data_len -= 4;
+	}
+	if (data_len >= 2) {
+		crc = crc32_barrett_zbc(*(const uint16_t *)data, crc, 16, params);
+		data += 2;
+		data_len -= 2;
+	}
+	if (data_len >= 1)
+		crc = crc32_barrett_zbc(*(const uint8_t *)data, crc, 8, params);
+
+	return crc;
+}
+
+/* Perform a reduction by 1 on a buffer (minimum length 2) */
+static inline void
+crc32_reduce_zbc(const uint64_t *data, uint64_t *high, uint64_t *low,
+		 const struct crc_clmul_ctx *params)
+{
+	uint64_t highh = __riscv_clmulh_64(params->k3, *high);
+	uint64_t highl = __riscv_clmul_64(params->k3, *high);
+	uint64_t lowh = __riscv_clmulh_64(params->k4, *low);
+	uint64_t lowl = __riscv_clmul_64(params->k4, *low);
+
+	*high = highl ^ lowl;
+	*low = highh ^ lowh;
+
+	*high ^= *(data++);
+	*low ^= *(data++);
+}
+
+static inline uint32_t
+crc32_eth_calc_zbc(
+	const uint8_t *data,
+	uint32_t data_len,
+	uint32_t crc,
+	const struct crc_clmul_ctx *params)
+{
+	uint64_t high, low;
+	/* Minimum length we can do reduction-by-1 over */
+	const uint32_t min_len = 16;
+	/* Barrett reduce until buffer aligned to 8-byte word */
+	uint32_t misalign = (size_t)data & 7;
+	if (misalign != 0 && misalign <= data_len) {
+		crc = crc32_repeated_barrett_zbc(data, misalign, crc, params);
+		data += misalign;
+		data_len -= misalign;
+	}
+
+	if (data_len < min_len)
+		return crc32_repeated_barrett_zbc(data, data_len, crc, params);
+
+	/* Fold buffer into two 8-byte words */
+	high = *((const uint64_t *)data) ^ crc;
+	low = *((const uint64_t *)(data + 8));
+	data += 16;
+	data_len -= 16;
+
+	for (; data_len >= 16; data_len -= 16, data += 16)
+		crc32_reduce_zbc((const uint64_t *)data, &high, &low, params);
+
+	/* Fold last 128 bits into 96 */
+	low = __riscv_clmul_64(params->k4, high) ^ low;
+	high = __riscv_clmulh_64(params->k4, high);
+	/* Upper 32 bits of high are now zero */
+	high = (low >> 32) | (high << 32);
+
+	/* Fold last 96 bits into 64 */
+	low = __riscv_clmul_64(low & 0xffffffff, params->k5);
+	low ^= high;
+
+	/*
+	 * Barrett reduction of remaining 64 bits, using high to store initial
+	 * value of low
+	 */
+	high = low;
+	low = __riscv_clmul_64(low, params->mu);
+	low &= 0xffffffff;
+	low = __riscv_clmul_64(low, params->Pr);
+	crc = (high ^ low) >> 32;
+
+	/* Combine crc with any excess */
+	crc = crc32_repeated_barrett_zbc(data, data_len, crc, params);
+
+	return crc;
+}
+
+void
+rte_net_crc_zbc_init(void)
+{
+	/*
+	 * Initialise CRC32 data - Constants derived from Intel whitepaper "Fast
+	 * CRC Computation for Generic Polynomials Using PCLMULQDQ Instrs"
+	 */
+	crc32_eth_clmul.Pr = 0x1db710641LL; /* polynomial P reversed */
+	crc32_eth_clmul.mu = 0xb4e5b025f7011641LL; /* (2 ^ 64 / P) reversed */
+	crc32_eth_clmul.k3 = 0x1751997d0LL; /* (x^(128+32) mod P << 32) reversed << 1 */
+	crc32_eth_clmul.k4 = 0x0ccaa009eLL; /* (x^(128-32) mod P << 32) reversed << 1 */
+	crc32_eth_clmul.k5 = 0x163cd6124LL; /* (x^64 mod P << 32) reversed << 1 */
+
+	/* Initialise CRC16 data */
+	/* Same calculations as above, with polynomial << 16 */
+	crc16_ccitt_clmul.Pr = 0x10811LL;
+	crc16_ccitt_clmul.mu = 0x859b040b1c581911LL;
+	crc16_ccitt_clmul.k3 = 0x8e10LL;
+	crc16_ccitt_clmul.k4 = 0x189aeLL;
+	crc16_ccitt_clmul.k5 = 0x114aaLL;
+}
+
+uint32_t
+rte_crc16_ccitt_zbc_handler(const uint8_t *data, uint32_t data_len)
+{
+	/* Negate the crc, which is present in the lower 16-bits */
+	return (uint16_t)~crc32_eth_calc_zbc(data,
+		data_len,
+		0xffff,
+		&crc16_ccitt_clmul);
+}
+
+uint32_t
+rte_crc32_eth_zbc_handler(const uint8_t *data, uint32_t data_len)
+{
+	return ~crc32_eth_calc_zbc(data,
+		data_len,
+		0xffffffffUL,
+		&crc32_eth_clmul);
+}
diff --git a/lib/net/rte_net_crc.c b/lib/net/rte_net_crc.c
index 3a589bdd6d..75668d76c4 100644
--- a/lib/net/rte_net_crc.c
+++ b/lib/net/rte_net_crc.c
@@ -40,7 +40,7 @@ struct rte_net_crc {
 
 static struct {
 	rte_net_crc_handler f[RTE_NET_CRC_REQS];
-} handlers[RTE_NET_CRC_AVX512 + 1];
+} handlers[RTE_NET_CRC_ZBC + 1];
 
 /* Scalar handling */
 
@@ -174,6 +174,20 @@ neon_pmull_init(void)
 #endif
 }
 
+/* ZBC/CLMUL handling */
+
+#define ZBC_CLMUL_CPU_SUPPORTED \
+	rte_cpu_get_flag_enabled(RTE_CPUFLAG_RISCV_EXT_ZBC)
+
+static void
+zbc_clmul_init(void)
+{
+#ifdef CC_RISCV64_ZBC_CLMUL_SUPPORT
+	if (ZBC_CLMUL_CPU_SUPPORTED)
+		rte_net_crc_zbc_init();
+#endif
+}
+
 static void
 handlers_init(enum rte_net_crc_alg alg)
 {
@@ -205,6 +219,15 @@ handlers_init(enum rte_net_crc_alg alg)
 			handlers[alg].f[RTE_NET_CRC32_ETH] = rte_crc32_eth_neon_handler;
 			break;
 		}
+#endif
+		break;
+	case RTE_NET_CRC_ZBC:
+#ifdef CC_RISCV64_ZBC_CLMUL_SUPPORT
+		if (ZBC_CLMUL_CPU_SUPPORTED) {
+			handlers[alg].f[RTE_NET_CRC16_CCITT] = rte_crc16_ccitt_zbc_handler;
+			handlers[alg].f[RTE_NET_CRC32_ETH] = rte_crc32_eth_zbc_handler;
+			break;
+		}
 #endif
 		/* fall-through */
 	case RTE_NET_CRC_SCALAR:
@@ -248,6 +271,9 @@ struct rte_net_crc *rte_net_crc_set_alg(enum rte_net_crc_alg alg, enum rte_net_c
 			return crc;
 		}
 		break;
+	case RTE_NET_CRC_ZBC:
+		crc->alg = RTE_NET_CRC_ZBC;
+		return crc;
 	case RTE_NET_CRC_SCALAR:
 		/* fall-through */
 	default:
@@ -275,8 +301,10 @@ RTE_INIT(rte_net_crc_init)
 	sse42_pclmulqdq_init();
 	avx512_vpclmulqdq_init();
 	neon_pmull_init();
+	zbc_clmul_init();
 	handlers_init(RTE_NET_CRC_SCALAR);
 	handlers_init(RTE_NET_CRC_NEON);
 	handlers_init(RTE_NET_CRC_SSE42);
 	handlers_init(RTE_NET_CRC_AVX512);
+	handlers_init(RTE_NET_CRC_ZBC);
 }
diff --git a/lib/net/rte_net_crc.h b/lib/net/rte_net_crc.h
index 6fb143f533..6712e5dae6 100644
--- a/lib/net/rte_net_crc.h
+++ b/lib/net/rte_net_crc.h
@@ -25,6 +25,7 @@ enum rte_net_crc_alg {
 	RTE_NET_CRC_SSE42,
 	RTE_NET_CRC_NEON,
 	RTE_NET_CRC_AVX512,
+	RTE_NET_CRC_ZBC,
 };
 
 /** CRC context (algorithm, type) */
@@ -51,6 +52,8 @@ rte_net_crc_free(struct rte_net_crc *crc);
  *   - RTE_NET_CRC_SSE42 (Use 64-bit SSE4.2 intrinsic)
  *   - RTE_NET_CRC_NEON (Use ARM Neon intrinsic)
  *   - RTE_NET_CRC_AVX512 (Use 512-bit AVX intrinsic)
+ *   - RTE_NET_CRC_ZBC (Use RISC-V Zbc extension)
+ *
  * @param type
  *   CRC type (enum rte_net_crc_type)
  *
-- 
2.53.0

