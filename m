Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831D8C0219B
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 18:24:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9DBB42ED5;
	Fri,  7 Feb 2025 19:24:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id CEBD542E90
 for <dev@dpdk.org>; Fri,  7 Feb 2025 19:24:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738952696; x=1770488696;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EahI4imjyFZFwhpXmQS1KqNjl0vjXFzWDPsy264DXOY=;
 b=SSaSJ5byGdG6u05xM5bf5YBGV4xNeGptwMZTOamcgheBPbivNGnJNr4O
 Yvrxy2tJmmV4CaFG2lFJHwckmEXgYUCvpdroPoC+mGeJWYjG06+FrI2Zr
 Luzmebt620L09Cv5cM3+5hDNF93dGIJjyOTbd9uSdc+uMaMr+lFXl4Elw
 Or4KeEjpyc7GC8539OzNFGoswuL/alnNdpUOS7crbSCkRCQNIkAsU17yO
 hH3zGop/IfM/gEUWN/nUzGb0/KTZAsqSPiQVV9e1iY5CNTGy/DKFkEubr
 GyBkyLMqco+cPgmKOJyYNp/VhGPffzyMZx95W9HkevDF5ieqW2kUIFTHG w==;
X-CSE-ConnectionGUID: cnb7AebgTxaz6rEEE6HR6Q==
X-CSE-MsgGUID: Kv11BivXSTaxjQT83CoKig==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="62079182"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="62079182"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 10:24:55 -0800
X-CSE-ConnectionGUID: Xk9a2FZmQgeJNf22W21nZw==
X-CSE-MsgGUID: fwbHGUS9QqKWj3vON9wc/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="142469066"
Received: from silpixa00401012.ir.intel.com ([10.243.23.14])
 by fmviesa001.fm.intel.com with ESMTP; 07 Feb 2025 10:24:52 -0800
From: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
To: dev@dpdk.org
Cc: ferruh.yigit@amd.com, kai.ji@intel.com, brian.dooley@intel.com,
 stephen@networkplumber.org,
 Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
Subject: [PATCH v5] net: add thread-safe crc api
Date: Fri,  7 Feb 2025 18:24:43 +0000
Message-Id: <20250207182443.9775-1-arkadiuszx.kusztal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250207063758.3971992-1-arkadiuszx.kusztal@intel.com>
References: <20250207063758.3971992-1-arkadiuszx.kusztal@intel.com>
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

The current net CRC API is not thread-safe, this patch
solves this by adding another, thread-safe API functions.
This API is also safe to use across multiple processes,
yet with limitations on max-simd-bitwidth, which will be checked only by
the process that created the CRC context; all other processes
(that did not create the context) will use the highest possible
SIMD extension that was built with the binary, but no higher than the one
requested by the CRC context.

Since the change of the API at this point is an ABI break,
these API symbols are versioned with the _26 suffix.

Signed-off-by: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
---
v2:
- added multi-process safety
v3:
- made the crc context opaque
- versioned old APIs
v4:
- exported rte_net_crc_free symbol
v5:
- fixed unclear comments in release notes section
- aligned `fall-through` comments

 app/test/test_crc.c                    | 169 ++++++++++---------------
 doc/guides/rel_notes/release_25_03.rst |   5 +
 drivers/crypto/qat/qat_sym.h           |   6 +-
 drivers/crypto/qat/qat_sym_session.c   |   8 ++
 drivers/crypto/qat/qat_sym_session.h   |   2 +
 lib/net/meson.build                    |   2 +
 lib/net/net_crc.h                      |  18 ++-
 lib/net/rte_net_crc.c                  | 130 ++++++++++++++++++-
 lib/net/rte_net_crc.h                  |  39 ++++--
 lib/net/version.map                    |   6 +
 10 files changed, 268 insertions(+), 117 deletions(-)

diff --git a/app/test/test_crc.c b/app/test/test_crc.c
index b85fca35fe..d7a11e8025 100644
--- a/app/test/test_crc.c
+++ b/app/test/test_crc.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2017-2020 Intel Corporation
+ * Copyright(c) 2017-2025 Intel Corporation
  */
 
 #include "test.h"
@@ -44,131 +44,100 @@ static const uint32_t crc32_vec_res = 0xb491aab4;
 static const uint32_t crc32_vec1_res = 0xac54d294;
 static const uint32_t crc32_vec2_res = 0xefaae02f;
 static const uint32_t crc16_vec_res = 0x6bec;
-static const uint16_t crc16_vec1_res = 0x8cdd;
-static const uint16_t crc16_vec2_res = 0xec5b;
+static const uint32_t crc16_vec1_res = 0x8cdd;
+static const uint32_t crc16_vec2_res = 0xec5b;
 
 static int
-crc_calc(const uint8_t *vec,
-	uint32_t vec_len,
-	enum rte_net_crc_type type)
+crc_all_algs(const char *desc, enum rte_net_crc_type type,
+	const uint8_t *data, int data_len, uint32_t res)
 {
-	/* compute CRC */
-	uint32_t ret = rte_net_crc_calc(vec, vec_len, type);
+	struct rte_net_crc *ctx;
+	uint32_t crc;
+	int ret = TEST_SUCCESS;
+
+	ctx = rte_net_crc_set_alg(RTE_NET_CRC_SCALAR, type);
+	TEST_ASSERT_NOT_NULL(ctx, "cannot allocate the CRC context");
+	crc = rte_net_crc_calc(ctx, data, data_len);
+	if (crc != res) {
+		RTE_LOG(ERR, USER1, "TEST FAILED: %s SCALAR\n", desc);
+		debug_hexdump(stdout, "SCALAR", &crc, 4);
+		ret = TEST_FAILED;
+	}
+	rte_net_crc_free(ctx);
+
+	ctx = rte_net_crc_set_alg(RTE_NET_CRC_SSE42, type);
+	TEST_ASSERT_NOT_NULL(ctx, "cannot allocate the CRC context");
+	crc = rte_net_crc_calc(ctx, data, data_len);
+	if (crc != res) {
+		RTE_LOG(ERR, USER1, "TEST FAILED: %s SSE42\n", desc);
+		debug_hexdump(stdout, "SSE", &crc, 4);
+		ret = TEST_FAILED;
+	}
 
-	/* dump data on console */
-	debug_hexdump(stdout, NULL, vec, vec_len);
+	rte_net_crc_free(ctx);
+
+	ctx = rte_net_crc_set_alg(RTE_NET_CRC_AVX512, type);
+	TEST_ASSERT_NOT_NULL(ctx, "cannot allocate the CRC context");
+	crc = rte_net_crc_calc(ctx, data, data_len);
+	if (crc != res) {
+		RTE_LOG(ERR, USER1, "TEST FAILED: %s AVX512\n", desc);
+		debug_hexdump(stdout, "AVX512", &crc, 4);
+		ret = TEST_FAILED;
+	}
+	rte_net_crc_free(ctx);
+
+	ctx = rte_net_crc_set_alg(RTE_NET_CRC_NEON, type);
+	TEST_ASSERT_NOT_NULL(ctx, "cannot allocate the CRC context");
+	crc = rte_net_crc_calc(ctx, data, data_len);
+	if (crc != res) {
+		RTE_LOG(ERR, USER1, "TEST FAILED: %s NEON\n", desc);
+		debug_hexdump(stdout, "NEON", &crc, 4);
+		ret = TEST_FAILED;
+	}
+	rte_net_crc_free(ctx);
 
-	return  ret;
+	return ret;
 }
 
 static int
-test_crc_calc(void)
-{
+crc_autotest(void)
+{	uint8_t *test_data;
 	uint32_t i;
-	enum rte_net_crc_type type;
-	uint8_t *test_data;
-	uint32_t result;
-	int error;
+	int ret = TEST_SUCCESS;
 
 	/* 32-bit ethernet CRC: Test 1 */
-	type = RTE_NET_CRC32_ETH;
-
-	result = crc_calc(crc_vec, CRC_VEC_LEN, type);
-	if (result != crc32_vec_res)
-		return -1;
+	ret = crc_all_algs("32-bit ethernet CRC: Test 1", RTE_NET_CRC32_ETH, crc_vec,
+		sizeof(crc_vec), crc32_vec_res);
 
 	/* 32-bit ethernet CRC: Test 2 */
 	test_data = rte_zmalloc(NULL, CRC32_VEC_LEN1, 0);
 	if (test_data == NULL)
 		return -7;
-
 	for (i = 0; i < CRC32_VEC_LEN1; i += 12)
 		rte_memcpy(&test_data[i], crc32_vec1, 12);
-
-	result = crc_calc(test_data, CRC32_VEC_LEN1, type);
-	if (result != crc32_vec1_res) {
-		error = -2;
-		goto fail;
-	}
+	ret |= crc_all_algs("32-bit ethernet CRC: Test 2", RTE_NET_CRC32_ETH, test_data,
+		CRC32_VEC_LEN1, crc32_vec1_res);
 
 	/* 32-bit ethernet CRC: Test 3 */
+	memset(test_data, 0, CRC32_VEC_LEN1);
 	for (i = 0; i < CRC32_VEC_LEN2; i += 12)
 		rte_memcpy(&test_data[i], crc32_vec1, 12);
-
-	result = crc_calc(test_data, CRC32_VEC_LEN2, type);
-	if (result != crc32_vec2_res) {
-		error = -3;
-		goto fail;
-	}
+	ret |= crc_all_algs("32-bit ethernet CRC: Test 3", RTE_NET_CRC32_ETH, test_data,
+		CRC32_VEC_LEN2, crc32_vec2_res);
 
 	/* 16-bit CCITT CRC:  Test 4 */
-	type = RTE_NET_CRC16_CCITT;
-	result = crc_calc(crc_vec, CRC_VEC_LEN, type);
-	if (result != crc16_vec_res) {
-		error = -4;
-		goto fail;
-	}
-	/* 16-bit CCITT CRC:  Test 5 */
-	result = crc_calc(crc16_vec1, CRC16_VEC_LEN1, type);
-	if (result != crc16_vec1_res) {
-		error = -5;
-		goto fail;
-	}
-	/* 16-bit CCITT CRC:  Test 6 */
-	result = crc_calc(crc16_vec2, CRC16_VEC_LEN2, type);
-	if (result != crc16_vec2_res) {
-		error = -6;
-		goto fail;
-	}
-
-	rte_free(test_data);
-	return 0;
-
-fail:
-	rte_free(test_data);
-	return error;
-}
-
-static int
-test_crc(void)
-{
-	int ret;
-	/* set CRC scalar mode */
-	rte_net_crc_set_alg(RTE_NET_CRC_SCALAR);
-
-	ret = test_crc_calc();
-	if (ret < 0) {
-		printf("test_crc (scalar): failed (%d)\n", ret);
-		return ret;
-	}
-	/* set CRC sse4.2 mode */
-	rte_net_crc_set_alg(RTE_NET_CRC_SSE42);
+	crc_all_algs("16-bit CCITT CRC:  Test 4", RTE_NET_CRC16_CCITT, crc_vec,
+		sizeof(crc_vec), crc16_vec_res);
 
-	ret = test_crc_calc();
-	if (ret < 0) {
-		printf("test_crc (x86_64_SSE4.2): failed (%d)\n", ret);
-		return ret;
-	}
-
-	/* set CRC avx512 mode */
-	rte_net_crc_set_alg(RTE_NET_CRC_AVX512);
-
-	ret = test_crc_calc();
-	if (ret < 0) {
-		printf("test crc (x86_64 AVX512): failed (%d)\n", ret);
-		return ret;
-	}
-
-	/* set CRC neon mode */
-	rte_net_crc_set_alg(RTE_NET_CRC_NEON);
+	/* 16-bit CCITT CRC:  Test 5 */
+	ret |= crc_all_algs("16-bit CCITT CRC:  Test 5", RTE_NET_CRC16_CCITT, crc16_vec1,
+		CRC16_VEC_LEN1, crc16_vec1_res);
 
-	ret = test_crc_calc();
-	if (ret < 0) {
-		printf("test crc (arm64 neon pmull): failed (%d)\n", ret);
-		return ret;
-	}
+	/* 16-bit CCITT CRC:  Test 6 */
+	ret |= crc_all_algs("16-bit CCITT CRC:  Test 6", RTE_NET_CRC16_CCITT, crc16_vec2,
+		CRC16_VEC_LEN2, crc16_vec2_res);
 
-	return 0;
+	return ret;
 }
 
-REGISTER_FAST_TEST(crc_autotest, true, true, test_crc);
+REGISTER_FAST_TEST(crc_autotest, true, true, crc_autotest);
diff --git a/doc/guides/rel_notes/release_25_03.rst b/doc/guides/rel_notes/release_25_03.rst
index 2b139fc35b..1b79470077 100644
--- a/doc/guides/rel_notes/release_25_03.rst
+++ b/doc/guides/rel_notes/release_25_03.rst
@@ -161,6 +161,11 @@ API Changes
   but to enable/disable these drivers via Meson option requires use of the new paths.
   For example, ``-Denable_drivers=/net/i40e`` becomes ``-Denable_drivers=/net/intel/i40e``.
 
+* net: Changed the API for CRC calculation to be thread safe.
+  An opaque context argument was introduced to the net CRC API containing
+  the algorithim type and length. This argument is added to
+  to ``rte_net_crc_calc``, ``rte_net_crc_set_alg`` and freed with ``rte_net_crc_free``.
+  These functions are versioned to retain binary compatiabilty until the next LTS release.
 
 ABI Changes
 -----------
diff --git a/drivers/crypto/qat/qat_sym.h b/drivers/crypto/qat/qat_sym.h
index f42336d7ed..849e047615 100644
--- a/drivers/crypto/qat/qat_sym.h
+++ b/drivers/crypto/qat/qat_sym.h
@@ -267,8 +267,7 @@ qat_crc_verify(struct qat_sym_session *ctx, struct rte_crypto_op *op)
 		crc_data = rte_pktmbuf_mtod_offset(sym_op->m_src, uint8_t *,
 				crc_data_ofs);
 
-		crc = rte_net_crc_calc(crc_data, crc_data_len,
-				RTE_NET_CRC32_ETH);
+		crc = rte_net_crc_calc(ctx->crc, crc_data, crc_data_len);
 
 		if (crc != *(uint32_t *)(crc_data + crc_data_len))
 			op->status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
@@ -291,8 +290,7 @@ qat_crc_generate(struct qat_sym_session *ctx,
 		crc_data = rte_pktmbuf_mtod_offset(sym_op->m_src, uint8_t *,
 				sym_op->auth.data.offset);
 		crc = (uint32_t *)(crc_data + crc_data_len);
-		*crc = rte_net_crc_calc(crc_data, crc_data_len,
-				RTE_NET_CRC32_ETH);
+		*crc = rte_net_crc_calc(ctx->crc, crc_data, crc_data_len);
 	}
 }
 
diff --git a/drivers/crypto/qat/qat_sym_session.c b/drivers/crypto/qat/qat_sym_session.c
index 50d687fd37..7200022adf 100644
--- a/drivers/crypto/qat/qat_sym_session.c
+++ b/drivers/crypto/qat/qat_sym_session.c
@@ -3174,6 +3174,14 @@ qat_sec_session_set_docsis_parameters(struct rte_cryptodev *dev,
 		ret = qat_sym_session_configure_crc(dev, xform, session);
 		if (ret < 0)
 			return ret;
+	} else {
+		/* Initialize crc algorithm */
+		session->crc = rte_net_crc_set_alg(RTE_NET_CRC_AVX512,
+			RTE_NET_CRC32_ETH);
+		if (session->crc == NULL) {
+			QAT_LOG(ERR, "Cannot initialize CRC context");
+			return -1;
+		}
 	}
 	qat_sym_session_finalize(session);
 
diff --git a/drivers/crypto/qat/qat_sym_session.h b/drivers/crypto/qat/qat_sym_session.h
index 2ca6c8ddf5..2ef2066646 100644
--- a/drivers/crypto/qat/qat_sym_session.h
+++ b/drivers/crypto/qat/qat_sym_session.h
@@ -7,6 +7,7 @@
 #include <rte_crypto.h>
 #include <cryptodev_pmd.h>
 #include <rte_security.h>
+#include <rte_net_crc.h>
 
 #include "qat_common.h"
 #include "icp_qat_hw.h"
@@ -149,6 +150,7 @@ struct qat_sym_session {
 	uint8_t is_zuc256;
 	uint8_t is_wireless;
 	uint32_t slice_types;
+	struct rte_net_crc *crc;
 	enum qat_sym_proto_flag qat_proto_flag;
 	qat_sym_build_request_t build_request[2];
 #ifndef RTE_QAT_OPENSSL
diff --git a/lib/net/meson.build b/lib/net/meson.build
index 8afcc4ed37..b26b377e8e 100644
--- a/lib/net/meson.build
+++ b/lib/net/meson.build
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017-2020 Intel Corporation
 
+use_function_versioning=true
+
 headers = files(
         'rte_cksum.h',
         'rte_ip.h',
diff --git a/lib/net/net_crc.h b/lib/net/net_crc.h
index 7a74d5406c..563ea809a9 100644
--- a/lib/net/net_crc.h
+++ b/lib/net/net_crc.h
@@ -1,10 +1,26 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2020 Intel Corporation
+ * Copyright(c) 2020-2025 Intel Corporation
  */
 
 #ifndef _NET_CRC_H_
 #define _NET_CRC_H_
 
+#include "rte_net_crc.h"
+
+void
+rte_net_crc_set_alg_v25(enum rte_net_crc_alg alg);
+
+struct rte_net_crc *
+rte_net_crc_set_alg_v26(enum rte_net_crc_alg alg,
+	enum rte_net_crc_type type);
+
+uint32_t
+rte_net_crc_calc_v25(const void *data,
+	uint32_t data_len, enum rte_net_crc_type type);
+
+uint32_t
+rte_net_crc_calc_v26(const struct rte_net_crc *ctx,
+	const void *data, const uint32_t data_len);
 /*
  * Different implementations of CRC
  */
diff --git a/lib/net/rte_net_crc.c b/lib/net/rte_net_crc.c
index 346c285c15..3a41df6eb9 100644
--- a/lib/net/rte_net_crc.c
+++ b/lib/net/rte_net_crc.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2017-2020 Intel Corporation
+ * Copyright(c) 2017-2025 Intel Corporation
  */
 
 #include <stddef.h>
@@ -10,6 +10,8 @@
 #include <rte_net_crc.h>
 #include <rte_log.h>
 #include <rte_vect.h>
+#include <rte_function_versioning.h>
+#include <rte_malloc.h>
 
 #include "net_crc.h"
 
@@ -38,11 +40,21 @@ rte_crc32_eth_handler(const uint8_t *data, uint32_t data_len);
 typedef uint32_t
 (*rte_net_crc_handler)(const uint8_t *data, uint32_t data_len);
 
+struct rte_net_crc {
+	enum rte_net_crc_alg alg;
+	enum rte_net_crc_type type;
+};
+
 static rte_net_crc_handler handlers_default[] = {
 	[RTE_NET_CRC16_CCITT] = rte_crc16_ccitt_default_handler,
 	[RTE_NET_CRC32_ETH] = rte_crc32_eth_default_handler,
 };
 
+static struct
+{
+	rte_net_crc_handler f[RTE_NET_CRC_REQS];
+} handlers_dpdk26[RTE_NET_CRC_AVX512 + 1];
+
 static const rte_net_crc_handler *handlers = handlers_default;
 
 static const rte_net_crc_handler handlers_scalar[] = {
@@ -286,10 +298,56 @@ rte_crc32_eth_default_handler(const uint8_t *data, uint32_t data_len)
 	return handlers[RTE_NET_CRC32_ETH](data, data_len);
 }
 
+static void
+handlers_init(enum rte_net_crc_alg alg)
+{
+	handlers_dpdk26[alg].f[RTE_NET_CRC16_CCITT] = rte_crc16_ccitt_handler;
+	handlers_dpdk26[alg].f[RTE_NET_CRC32_ETH] = rte_crc32_eth_handler;
+
+	switch (alg) {
+	case RTE_NET_CRC_AVX512:
+#ifdef CC_X86_64_AVX512_VPCLMULQDQ_SUPPORT
+		if (AVX512_VPCLMULQDQ_CPU_SUPPORTED) {
+			handlers_dpdk26[alg].f[RTE_NET_CRC16_CCITT] =
+				rte_crc16_ccitt_avx512_handler;
+			handlers_dpdk26[alg].f[RTE_NET_CRC32_ETH] =
+				rte_crc32_eth_avx512_handler;
+			break;
+		}
+#endif
+		/* fall-through */
+	case RTE_NET_CRC_SSE42:
+#ifdef CC_X86_64_SSE42_PCLMULQDQ_SUPPORT
+		if (SSE42_PCLMULQDQ_CPU_SUPPORTED) {
+			handlers_dpdk26[alg].f[RTE_NET_CRC16_CCITT] =
+				rte_crc16_ccitt_sse42_handler;
+			handlers_dpdk26[alg].f[RTE_NET_CRC32_ETH] =
+				rte_crc32_eth_sse42_handler;
+		}
+#endif
+		break;
+	case RTE_NET_CRC_NEON:
+#ifdef CC_ARM64_NEON_PMULL_SUPPORT
+		if (NEON_PMULL_CPU_SUPPORTED) {
+			handlers_dpdk26[alg].f[RTE_NET_CRC16_CCITT] =
+				rte_crc16_ccitt_neon_handler;
+			handlers_dpdk26[alg].f[RTE_NET_CRC32_ETH] =
+				rte_crc32_eth_neon_handler;
+			break;
+		}
+#endif
+		/* fall-through */
+	case RTE_NET_CRC_SCALAR:
+		/* fall-through */
+	default:
+		break;
+	}
+}
+
 /* Public API */
 
 void
-rte_net_crc_set_alg(enum rte_net_crc_alg alg)
+rte_net_crc_set_alg_v25(enum rte_net_crc_alg alg)
 {
 	handlers = NULL;
 	if (max_simd_bitwidth == 0)
@@ -316,9 +374,59 @@ rte_net_crc_set_alg(enum rte_net_crc_alg alg)
 	if (handlers == NULL)
 		handlers = handlers_scalar;
 }
+VERSION_SYMBOL(rte_net_crc_set_alg, _v25, 25);
+
+struct rte_net_crc *rte_net_crc_set_alg_v26(enum rte_net_crc_alg alg,
+	enum rte_net_crc_type type)
+{
+	uint16_t max_simd_bitwidth;
+	struct rte_net_crc *crc;
+
+	crc = rte_zmalloc(NULL, sizeof(struct rte_net_crc), 0);
+	if (crc == NULL)
+		return NULL;
+	max_simd_bitwidth = rte_vect_get_max_simd_bitwidth();
+	crc->type = type;
+	crc->alg = RTE_NET_CRC_SCALAR;
+
+	switch (alg) {
+	case RTE_NET_CRC_AVX512:
+		if (max_simd_bitwidth >= RTE_VECT_SIMD_512) {
+			crc->alg = RTE_NET_CRC_AVX512;
+			return crc;
+		}
+		/* fall-through */
+	case RTE_NET_CRC_SSE42:
+		if (max_simd_bitwidth >= RTE_VECT_SIMD_128) {
+			crc->alg = RTE_NET_CRC_SSE42;
+			return crc;
+		}
+		break;
+	case RTE_NET_CRC_NEON:
+		if (max_simd_bitwidth >= RTE_VECT_SIMD_128) {
+			crc->alg = RTE_NET_CRC_NEON;
+			return crc;
+		}
+		break;
+	case RTE_NET_CRC_SCALAR:
+		/* fall-through */
+	default:
+		break;
+	}
+	return crc;
+}
+BIND_DEFAULT_SYMBOL(rte_net_crc_set_alg, _v26, 26);
+MAP_STATIC_SYMBOL(struct rte_net_crc *rte_net_crc_set_alg(
+	enum rte_net_crc_alg alg, enum rte_net_crc_type type),
+	rte_net_crc_set_alg_v26);
+
+void rte_net_crc_free(struct rte_net_crc *crc)
+{
+	rte_free(crc);
+}
 
 uint32_t
-rte_net_crc_calc(const void *data,
+rte_net_crc_calc_v25(const void *data,
 	uint32_t data_len,
 	enum rte_net_crc_type type)
 {
@@ -330,6 +438,18 @@ rte_net_crc_calc(const void *data,
 
 	return ret;
 }
+VERSION_SYMBOL(rte_net_crc_calc, _v25, 25);
+
+uint32_t
+rte_net_crc_calc_v26(const struct rte_net_crc *ctx,
+	const void *data, const uint32_t data_len)
+{
+	return handlers_dpdk26[ctx->alg].f[ctx->type](data, data_len);
+}
+BIND_DEFAULT_SYMBOL(rte_net_crc_calc, _v26, 26);
+MAP_STATIC_SYMBOL(uint32_t rte_net_crc_calc(const struct rte_net_crc *ctx,
+	const void *data, const uint32_t data_len),
+	rte_net_crc_calc_v26);
 
 /* Call initialisation helpers for all crc algorithm handlers */
 RTE_INIT(rte_net_crc_init)
@@ -338,4 +458,8 @@ RTE_INIT(rte_net_crc_init)
 	sse42_pclmulqdq_init();
 	avx512_vpclmulqdq_init();
 	neon_pmull_init();
+	handlers_init(RTE_NET_CRC_SCALAR);
+	handlers_init(RTE_NET_CRC_NEON);
+	handlers_init(RTE_NET_CRC_SSE42);
+	handlers_init(RTE_NET_CRC_AVX512);
 }
diff --git a/lib/net/rte_net_crc.h b/lib/net/rte_net_crc.h
index 72d3e10ff6..ffac8c2f1f 100644
--- a/lib/net/rte_net_crc.h
+++ b/lib/net/rte_net_crc.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2017-2020 Intel Corporation
+ * Copyright(c) 2017-2025 Intel Corporation
  */
 
 #ifndef _RTE_NET_CRC_H_
@@ -26,8 +26,11 @@ enum rte_net_crc_alg {
 	RTE_NET_CRC_AVX512,
 };
 
+/** CRC context (algorithm, type) */
+struct rte_net_crc;
+
 /**
- * This API set the CRC computation algorithm (i.e. scalar version,
+ * This API set the CRC context (i.e. scalar version,
  * x86 64-bit sse4.2 intrinsic version, etc.) and internal data
  * structure.
  *
@@ -37,27 +40,45 @@ enum rte_net_crc_alg {
  *   - RTE_NET_CRC_SSE42 (Use 64-bit SSE4.2 intrinsic)
  *   - RTE_NET_CRC_NEON (Use ARM Neon intrinsic)
  *   - RTE_NET_CRC_AVX512 (Use 512-bit AVX intrinsic)
+ * @param type
+ *   CRC type (enum rte_net_crc_type)
+ *
+ * @return
+ *   Pointer to the CRC context
  */
-void
-rte_net_crc_set_alg(enum rte_net_crc_alg alg);
+struct rte_net_crc *
+rte_net_crc_set_alg(enum rte_net_crc_alg alg,
+	enum rte_net_crc_type type);
 
 /**
  * CRC compute API
  *
+ * Note:
+ * The command line argument --force-max-simd-bitwidth will be ignored
+ * by processes that have not created this CRC context.
+ *
+ * @param ctx
+ *   Pointer to the CRC context
  * @param data
  *   Pointer to the packet data for CRC computation
  * @param data_len
  *   Data length for CRC computation
- * @param type
- *   CRC type (enum rte_net_crc_type)
  *
  * @return
  *   CRC value
  */
 uint32_t
-rte_net_crc_calc(const void *data,
-	uint32_t data_len,
-	enum rte_net_crc_type type);
+rte_net_crc_calc(const struct rte_net_crc *ctx,
+	const void *data, const uint32_t data_len);
+/**
+ * Frees the memory space pointed to by the CRC context pointer.
+ * If the pointer is NULL, the function does nothing.
+ *
+ * @param ctx
+ *   Pointer to the CRC context
+ */
+void
+rte_net_crc_free(struct rte_net_crc *crc);
 
 #ifdef __cplusplus
 }
diff --git a/lib/net/version.map b/lib/net/version.map
index bec4ce23ea..d03f3f6ad0 100644
--- a/lib/net/version.map
+++ b/lib/net/version.map
@@ -5,6 +5,7 @@ DPDK_25 {
 	rte_ether_format_addr;
 	rte_ether_unformat_addr;
 	rte_net_crc_calc;
+	rte_net_crc_free;
 	rte_net_crc_set_alg;
 	rte_net_get_ptype;
 	rte_net_make_rarp_packet;
@@ -12,3 +13,8 @@ DPDK_25 {
 
 	local: *;
 };
+
+DPDK_26 {
+	rte_net_crc_calc;
+	rte_net_crc_set_alg;
+} DPDK_25;
-- 
2.34.1

