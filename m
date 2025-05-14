Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6E1C3ABDA
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 08:09:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBA9B4025D;
	Wed, 14 May 2025 10:09:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 8906F40041
 for <dev@dpdk.org>; Wed, 14 May 2025 10:09:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747210191; x=1778746191;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=kWBtcaChaT53nbTgK+cHtDIHyc8tnSLIu1qx2C5RCvU=;
 b=SzTkuzRVhDBRfifk+eEEaKanCtIq68uJ9fXj2jVlThRKMB7QoHrN+Zyl
 0AXm1Hz6MJQfWjURU2Ftmu+8zWNVGFal3VvyDVwR2kVCwDXvEl7eVzlS3
 JbnXNy36Y0k7R+yKufH/xENxVcCzdmnrmkrpTUe5EZEwUapFYnIJthr2P
 WyCsCtaTG1bEn3NkicndVhb2eSwTsim6+HTII+l/dU8x4MIXbzZ/swozJ
 xhRtK6kkzzGLV96v0cbp0c7hqODdIxdYl3oMh021CLjXf9fv1h6oWGKf0
 RhQiZmki43EKSJ0AZL3KUptUczpyffDitmmM+VWj2+ArIIbEIWcn3Va0I g==;
X-CSE-ConnectionGUID: MIuZV5CMQjurUNnM7RYHIQ==
X-CSE-MsgGUID: PcMdTiCHT6m15hBNqd6ROQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="71593890"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="71593890"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 01:09:50 -0700
X-CSE-ConnectionGUID: OoTPSvK6SCCne+2fByDM8g==
X-CSE-MsgGUID: pxnBCWWHT3OMYZBn41SxoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="142908716"
Received: from silpixa00401013.ir.intel.com (HELO
 silpixa00401013.ger.corp.intel.com) ([10.237.223.185])
 by orviesa004.jf.intel.com with ESMTP; 14 May 2025 01:09:49 -0700
From: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
To: dev@dpdk.org
Cc: gakhil@marvell.com, kai.ji@intel.com,
 Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
Subject: [PATCH] crypto/qat: add caching of the asym config
Date: Wed, 14 May 2025 08:09:46 +0000
Message-Id: <20250514080946.1633268-1-arkadiuszx.kusztal@intel.com>
X-Mailer: git-send-email 2.34.1
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

Added caching option of asymmetric crypto parameters.
This helps to avoid cleaning of unused data and allows
introducing the options to reuse the previous setup.

Signed-off-by: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
---
 drivers/crypto/qat/qat_asym.c | 125 ++++++++++++++++++----------------
 drivers/crypto/qat/qat_asym.h |  13 ++++
 2 files changed, 81 insertions(+), 57 deletions(-)

diff --git a/drivers/crypto/qat/qat_asym.c b/drivers/crypto/qat/qat_asym.c
index f5b56b2f71..f91ad82fba 100644
--- a/drivers/crypto/qat/qat_asym.c
+++ b/drivers/crypto/qat/qat_asym.c
@@ -79,15 +79,23 @@ static const struct rte_driver cryptodev_qat_asym_driver = {
 	} while (0)
 
 #define SET_PKE_LN(what, how, idx) \
-	rte_memcpy(cookie->input_array[idx] + how - \
-		what.length, \
-		what.data, \
-		what.length)
+	do { \
+		rte_memcpy(cookie->input_array[idx] + how - \
+			what.length, \
+			what.data, \
+			what.length);	\
+		cookie->cache.info_in[idx].length = what.length; \
+		cookie->cache.info_in[idx].offset = how - what.length; \
+	} while (0)
 
 #define SET_PKE_LN_EC(curve, p, idx) \
-	rte_memcpy(cookie->input_array[idx] + \
-		qat_func_alignsize - curve.bytesize, \
-		curve.p.data, curve.bytesize)
+	do { \
+		rte_memcpy(cookie->input_array[idx] + \
+			qat_func_alignsize - curve.bytesize, \
+			curve.p.data, curve.bytesize); \
+		cookie->cache.info_in[idx].length = curve.bytesize; \
+		cookie->cache.info_in[idx].offset = qat_func_alignsize - curve.bytesize; \
+	} while (0)
 
 #define SET_PKE_9A_IN(what, idx) \
 	rte_memcpy(&cookie->input_buffer[idx * \
@@ -118,54 +126,35 @@ request_init(struct icp_qat_fw_pke_request *qat_req)
 }
 
 static void
-cleanup_arrays(struct qat_asym_op_cookie *cookie,
-		int in_count, int out_count, int alg_size)
+cleanup(struct qat_asym_op_cookie *cookie,
+	const struct rte_crypto_asym_xform __rte_unused *xform)
 {
 	int i;
 
-	for (i = 0; i < in_count; i++)
-		memset(cookie->input_array[i], 0x0, alg_size);
-	for (i = 0; i < out_count; i++)
-		memset(cookie->output_array[i], 0x0, alg_size);
-}
+	cookie->cache.curve_id = 0;
+	if (cookie->cache.bytes) {
+		memset(&cookie->input_buffer[0], 0, cookie->cache.bytes);
+		cookie->cache.bytes = 0;
+		return;
+	}
 
-static void
-cleanup_crt(struct qat_asym_op_cookie *cookie,
-		int alg_size)
-{
-	int i;
+	for (i = 0; i < MAX_PKE_PARAMS; i++) {
+		const uint16_t offset = cookie->cache.info_in[i].offset;
+		const uint16_t length = cookie->cache.info_in[i].length;
 
-	memset(cookie->input_array[0], 0x0, alg_size);
-	for (i = 1; i < QAT_ASYM_RSA_QT_NUM_IN_PARAMS; i++)
-		memset(cookie->input_array[i], 0x0, alg_size / 2);
-	for (i = 0; i < QAT_ASYM_RSA_NUM_OUT_PARAMS; i++)
-		memset(cookie->output_array[i], 0x0, alg_size);
-}
+		if (length == 0)
+			break;
+		memset(&cookie->input_array[i][offset], 0, length);
+		cookie->cache.info_in[i].length = 0;
+		cookie->cache.info_in[i].offset = 0;
+	}
+	for (i = 0; i < MAX_PKE_PARAMS; i++) {
+		const uint16_t length = cookie->cache.info_out[i].length;
 
-static void
-cleanup(struct qat_asym_op_cookie *cookie,
-		const struct rte_crypto_asym_xform *xform)
-{
-	if (xform->xform_type == RTE_CRYPTO_ASYM_XFORM_MODEX)
-		cleanup_arrays(cookie, QAT_ASYM_MODEXP_NUM_IN_PARAMS,
-				QAT_ASYM_MODEXP_NUM_OUT_PARAMS,
-				cookie->alg_bytesize);
-	else if (xform->xform_type == RTE_CRYPTO_ASYM_XFORM_MODINV)
-		cleanup_arrays(cookie, QAT_ASYM_MODINV_NUM_IN_PARAMS,
-				QAT_ASYM_MODINV_NUM_OUT_PARAMS,
-				cookie->alg_bytesize);
-	else if (xform->xform_type == RTE_CRYPTO_ASYM_XFORM_RSA) {
-		if (xform->rsa.key_type == RTE_RSA_KEY_TYPE_QT)
-			cleanup_crt(cookie, cookie->alg_bytesize);
-		else {
-			cleanup_arrays(cookie, QAT_ASYM_RSA_NUM_IN_PARAMS,
-				QAT_ASYM_RSA_NUM_OUT_PARAMS,
-				cookie->alg_bytesize);
-		}
-	} else {
-		cleanup_arrays(cookie, QAT_ASYM_MAX_PARAMS,
-				QAT_ASYM_MAX_PARAMS,
-				QAT_PKE_MAX_LN_SIZE);
+		if (length == 0)
+			break;
+		memset(&cookie->output_array[i], 0, length);
+		cookie->cache.info_out[i].length = 0;
 	}
 }
 
@@ -263,7 +252,7 @@ modexp_set_input(struct icp_qat_fw_pke_request *qat_req,
 
 static uint8_t
 modexp_collect(struct rte_crypto_asym_op *asym_op,
-		const struct qat_asym_op_cookie *cookie,
+		struct qat_asym_op_cookie *cookie,
 		const struct rte_crypto_asym_xform *xform)
 {
 	rte_crypto_param n = xform->modex.modulus;
@@ -277,6 +266,7 @@ modexp_collect(struct rte_crypto_asym_op *asym_op,
 	rte_memcpy(modexp_result,
 		cookie->output_array[0] + alg_bytesize
 		- n.length, n.length);
+	cookie->cache.info_out[0].length = alg_bytesize;
 	asym_op->modex.result.length = alg_bytesize;
 	HEXDUMP("ModExp result", cookie->output_array[0],
 			alg_bytesize);
@@ -324,7 +314,7 @@ modinv_set_input(struct icp_qat_fw_pke_request *qat_req,
 
 static uint8_t
 modinv_collect(struct rte_crypto_asym_op *asym_op,
-		const struct qat_asym_op_cookie *cookie,
+		struct qat_asym_op_cookie *cookie,
 		const struct rte_crypto_asym_xform *xform)
 {
 	rte_crypto_param n = xform->modinv.modulus;
@@ -340,6 +330,7 @@ modinv_collect(struct rte_crypto_asym_op *asym_op,
 		cookie->output_array[0] + alg_bytesize
 		- n.length, n.length);
 	asym_op->modinv.result.length = alg_bytesize;
+	cookie->cache.info_out[0].length = alg_bytesize;
 	HEXDUMP("ModInv result", cookie->output_array[0],
 			alg_bytesize);
 	return RTE_CRYPTO_OP_STATUS_SUCCESS;
@@ -391,6 +382,9 @@ rsa_set_pub_input(struct icp_qat_fw_pke_request *qat_req,
 
 	SET_PKE_LN(xform->rsa.e, alg_bytesize, 1);
 	SET_PKE_LN(xform->rsa.n, alg_bytesize, 2);
+	cookie->cache.info_out[0].length = alg_bytesize;
+	cookie->cache.info_out[1].length = alg_bytesize;
+	cookie->cache.info_out[2].length = alg_bytesize;
 
 	cookie->alg_bytesize = alg_bytesize;
 	qat_req->pke_hdr.cd_pars.func_id = func_id;
@@ -516,7 +510,7 @@ rsa_set_input(struct icp_qat_fw_pke_request *qat_req,
 
 static uint8_t
 rsa_collect(struct rte_crypto_asym_op *asym_op,
-		const struct qat_asym_op_cookie *cookie,
+		struct qat_asym_op_cookie *cookie,
 		const struct rte_crypto_asym_xform *xform)
 {
 	uint32_t alg_bytesize = cookie->alg_bytesize;
@@ -572,7 +566,8 @@ rsa_collect(struct rte_crypto_asym_op *asym_op,
 			HEXDUMP("RSA Signature", cookie->output_array[0],
 				alg_bytesize);
 		}
-	}
+	}	
+	cookie->cache.info_out[0].length = alg_bytesize;
 	return RTE_CRYPTO_OP_STATUS_SUCCESS;
 }
 
@@ -612,6 +607,9 @@ ecdsa_set_input(struct icp_qat_fw_pke_request *qat_req,
 		SET_PKE_9A_EC(curve[curve_id], n, 6);
 		SET_PKE_9A_EC(curve[curve_id], y, 7);
 		SET_PKE_9A_EC(curve[curve_id], x, 8);
+		cookie->cache.bytes = QAT_ASYM_ECDSA_RS_SIGN_IN_PARAMS_NO *
+			qat_func_alignsize;
+		cookie->cache.curve_id = curve_id;
 
 		cookie->alg_bytesize = curve[curve_id].bytesize;
 		cookie->qat_func_alignsize = qat_func_alignsize;
@@ -650,6 +648,9 @@ ecdsa_set_input(struct icp_qat_fw_pke_request *qat_req,
 		SET_PKE_9A_EC(curve[curve_id], a, 2);
 		SET_PKE_9A_EC(curve[curve_id], b, 1);
 		SET_PKE_9A_EC(curve[curve_id], p, 0);
+		cookie->cache.bytes = QAT_ASYM_ECDSA_RS_VERIFY_IN_PARAMS_NO *
+			qat_func_alignsize;
+		cookie->cache.curve_id = curve_id;
 
 		cookie->alg_bytesize = curve[curve_id].bytesize;
 		cookie->qat_func_alignsize = qat_func_alignsize;
@@ -680,7 +681,7 @@ ecdsa_set_input(struct icp_qat_fw_pke_request *qat_req,
 
 static uint8_t
 ecdsa_collect(struct rte_crypto_asym_op *asym_op,
-		const struct qat_asym_op_cookie *cookie)
+		struct qat_asym_op_cookie *cookie)
 {
 	uint32_t alg_bytesize = cookie->alg_bytesize;
 	uint32_t qat_func_alignsize = cookie->qat_func_alignsize;
@@ -700,6 +701,8 @@ ecdsa_collect(struct rte_crypto_asym_op *asym_op,
 		HEXDUMP("S", cookie->output_array[1],
 			qat_func_alignsize);
 	}
+	cookie->cache.info_out[0].length = alg_bytesize;
+	cookie->cache.info_out[1].length = alg_bytesize;
 	return RTE_CRYPTO_OP_STATUS_SUCCESS;
 }
 
@@ -734,6 +737,7 @@ ecpm_set_input(struct icp_qat_fw_pke_request *qat_req,
 	SET_PKE_LN_EC(curve[curve_id], b, 4);
 	SET_PKE_LN_EC(curve[curve_id], p, 5);
 	SET_PKE_LN_EC(curve[curve_id], h, 6);
+	cookie->cache.curve_id = curve_id;
 
 	cookie->alg_bytesize = curve[curve_id].bytesize;
 	cookie->qat_func_alignsize = qat_func_alignsize;
@@ -756,7 +760,7 @@ ecpm_set_input(struct icp_qat_fw_pke_request *qat_req,
 
 static uint8_t
 ecpm_collect(struct rte_crypto_asym_op *asym_op,
-		const struct qat_asym_op_cookie *cookie)
+		struct qat_asym_op_cookie *cookie)
 {
 	uint8_t *x = asym_op->ecpm.r.x.data;
 	uint8_t *y = asym_op->ecpm.r.y.data;
@@ -768,6 +772,8 @@ ecpm_collect(struct rte_crypto_asym_op *asym_op,
 	asym_op->ecpm.r.y.length = alg_bytesize;
 	rte_memcpy(x, &cookie->output_array[0][ltrim], alg_bytesize);
 	rte_memcpy(y, &cookie->output_array[1][ltrim], alg_bytesize);
+	cookie->cache.info_out[0].length = alg_bytesize;
+	cookie->cache.info_out[1].length = alg_bytesize;
 
 	HEXDUMP("rX", cookie->output_array[0],
 		qat_func_alignsize);
@@ -813,6 +819,7 @@ ecdh_set_input(struct icp_qat_fw_pke_request *qat_req,
 	SET_PKE_LN_EC(curve[curve_id], b, 4);
 	SET_PKE_LN_EC(curve[curve_id], p, 5);
 	SET_PKE_LN_EC(curve[curve_id], h, 6);
+	cookie->cache.curve_id = curve_id;
 
 	cookie->alg_bytesize = curve[curve_id].bytesize;
 	cookie->qat_func_alignsize = qat_func_alignsize;
@@ -882,7 +889,7 @@ ecdh_verify_set_input(struct icp_qat_fw_pke_request *qat_req,
 
 static uint8_t
 ecdh_collect(struct rte_crypto_asym_op *asym_op,
-		const struct qat_asym_op_cookie *cookie)
+		struct qat_asym_op_cookie *cookie)
 {
 	uint8_t *x, *y;
 	uint32_t alg_bytesize = cookie->alg_bytesize;
@@ -906,6 +913,8 @@ ecdh_collect(struct rte_crypto_asym_op *asym_op,
 
 	rte_memcpy(x, &cookie->output_array[0][ltrim], alg_bytesize);
 	rte_memcpy(y, &cookie->output_array[1][ltrim], alg_bytesize);
+	cookie->cache.info_out[0].length = alg_bytesize;
+	cookie->cache.info_out[1].length = alg_bytesize;
 
 	HEXDUMP("X", cookie->output_array[0],
 		qat_func_alignsize);
@@ -966,7 +975,7 @@ sm2_ecdsa_verify_set_input(struct icp_qat_fw_pke_request *qat_req,
 
 static uint8_t
 sm2_ecdsa_sign_collect(struct rte_crypto_asym_op *asym_op,
-		const struct qat_asym_op_cookie *cookie)
+		struct qat_asym_op_cookie *cookie)
 {
 	uint32_t alg_bytesize = cookie->alg_bytesize;
 
@@ -977,6 +986,8 @@ sm2_ecdsa_sign_collect(struct rte_crypto_asym_op *asym_op,
 	rte_memcpy(asym_op->sm2.s.data, cookie->output_array[1], alg_bytesize);
 	asym_op->sm2.r.length = alg_bytesize;
 	asym_op->sm2.s.length = alg_bytesize;
+	cookie->cache.info_out[0].length = alg_bytesize;
+	cookie->cache.info_out[1].length = alg_bytesize;
 
 	HEXDUMP("SM2 R", cookie->output_array[0],
 		alg_bytesize);
diff --git a/drivers/crypto/qat/qat_asym.h b/drivers/crypto/qat/qat_asym.h
index 00275fa3b9..ddd0035ceb 100644
--- a/drivers/crypto/qat/qat_asym.h
+++ b/drivers/crypto/qat/qat_asym.h
@@ -28,7 +28,9 @@ typedef uint64_t large_int_ptr;
 #define QAT_ASYM_RSA_NUM_OUT_PARAMS		1
 #define QAT_ASYM_RSA_QT_NUM_IN_PARAMS		6
 #define QAT_ASYM_ECDSA_RS_SIGN_IN_PARAMS	1
+#define QAT_ASYM_ECDSA_RS_SIGN_IN_PARAMS_NO	9
 #define QAT_ASYM_ECDSA_RS_SIGN_OUT_PARAMS	2
+#define QAT_ASYM_ECDSA_RS_VERIFY_IN_PARAMS_NO	10
 #define QAT_ASYM_ECDSA_RS_VERIFY_IN_PARAMS	1
 #define QAT_ASYM_ECDSA_RS_VERIFY_OUT_PARAMS	0
 #define QAT_ASYM_ECPM_IN_PARAMS			7
@@ -69,6 +71,17 @@ struct __rte_aligned(8) qat_asym_op_cookie {
 		uint8_t input_buffer[MAX_PKE_PARAMS * QAT_PKE_MAX_LN_SIZE];
 	};
 	alignas(8) uint8_t output_array[MAX_PKE_PARAMS][QAT_PKE_MAX_LN_SIZE];
+	struct {
+		uint16_t bytes;
+		struct {
+			uint16_t offset;
+			uint16_t length;
+		} info_in [MAX_PKE_PARAMS];
+		struct {
+			uint16_t length;
+		} info_out [MAX_PKE_PARAMS];
+		int curve_id;
+	} cache;
 };
 
 struct qat_asym_session {
-- 
2.34.1

