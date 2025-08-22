Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCB0CA0FE1
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 11:13:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DFED40A7D;
	Fri, 22 Aug 2025 13:13:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 4BDEA4028C
 for <dev@dpdk.org>; Fri, 22 Aug 2025 13:13:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755861198; x=1787397198;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=f7Ufve4TCuLUGr5kwWTkUyv1ff5oFrmbz4ncMUqp01o=;
 b=YBrv8me2YSIjZUQ+R5sByVlOndlzertj+WhmzUMjirjDnPsNPAo6ROk2
 0buAXrdSHagL6mouUyVhmN85Vj+EqgmhUkdXbxs1ohEPy3AWwS7ydaDot
 gqMNWr8T8L6cyf68KFV3HuMgbcZFEKuiNRBHIRCiFYSVtYq25I4Xl4Zky
 7wwDdsZvDAlwx8pucs4pBeCQcbqFSVgtQELfh7o9Z1K+4WrDV3PFgLvaG
 P4+RadX1o0yE3OJ/rvqyCs9N4NLQ/E9sadjqrsmg3ii5PVVoQPC5ZwhBg
 V4n0Y4Loc9XKDxiYUHvkzvpqH3Rpo6+hV+aIyWeq1lkq5LxxUXl4Mnc4F w==;
X-CSE-ConnectionGUID: E0nADYyWSyeOPini3478bQ==
X-CSE-MsgGUID: 4ZKgRYmDQH2/GWrNn6/M9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="69267769"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; d="scan'208";a="69267769"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2025 04:13:17 -0700
X-CSE-ConnectionGUID: A3nKaK2ySBq0A7LkPxG2Fw==
X-CSE-MsgGUID: tZPSZ380TsSaURfewheRUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; d="scan'208";a="168884144"
Received: from silpixa00400465.ir.intel.com (HELO
 silpixa00400465.ger.corp.intel.com) ([10.237.223.221])
 by orviesa008.jf.intel.com with ESMTP; 22 Aug 2025 04:13:16 -0700
From: Kai Ji <kai.ji@intel.com>
To: dev@dpdk.org
Cc: Kai Ji <kai.ji@intel.com>, Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
Subject: [dpdk-dev v9 2/3] crypto/qat: add sm2 encryption/decryption function
Date: Fri, 22 Aug 2025 11:13:07 +0000
Message-ID: <20250822111309.2506329-2-kai.ji@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822111309.2506329-1-kai.ji@intel.com>
References: <20241104093610.20426-2-arkadiuszx.kusztal@intel.com>
 <20250822111309.2506329-1-kai.ji@intel.com>
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

This commit adds SM2 elliptic curve based asymmetric
encryption and decryption to the Intel QuickAssist
Technology PMD.

Depends-on: patch-147900 ("[v2] crypto/qat: fix ecdsa session handling")

Signed-off-by: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
Signed-off-by: Kai Ji <kai.ji@intel.com>
---
 doc/guides/rel_notes/release_25_11.rst        |   3 +
 .../common/qat/qat_adf/icp_qat_fw_mmp_ids.h   |   3 +
 drivers/common/qat/qat_adf/qat_pke.h          |  20 +++
 drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c  |  72 ++++++++-
 drivers/crypto/qat/qat_asym.c                 | 140 +++++++++++++++++-
 5 files changed, 231 insertions(+), 7 deletions(-)

diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index b15d2e0e8f..b31d9c0fb2 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -55,6 +55,9 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated the QuickAssist Technology (QAT) Crypto PMD.**
+
+  * Added SM2 encryption and decryption algorithms.
 
 Removed Items
 -------------
diff --git a/drivers/common/qat/qat_adf/icp_qat_fw_mmp_ids.h b/drivers/common/qat/qat_adf/icp_qat_fw_mmp_ids.h
index 630c6e1a9b..aa49612ca1 100644
--- a/drivers/common/qat/qat_adf/icp_qat_fw_mmp_ids.h
+++ b/drivers/common/qat/qat_adf/icp_qat_fw_mmp_ids.h
@@ -1542,6 +1542,9 @@ icp_qat_fw_mmp_ecdsa_verify_gfp_521_input::in in @endlink
  * @li no output parameters
  */
 
+#define PKE_ECSM2_ENCRYPTION 0x25221720
+#define PKE_ECSM2_DECRYPTION 0x201716e6
+
 #define PKE_LIVENESS 0x00000001
 /**< Functionality ID for PKE_LIVENESS
  * @li 0 input parameter(s)
diff --git a/drivers/common/qat/qat_adf/qat_pke.h b/drivers/common/qat/qat_adf/qat_pke.h
index f88932a275..ac051e965d 100644
--- a/drivers/common/qat/qat_adf/qat_pke.h
+++ b/drivers/common/qat/qat_adf/qat_pke.h
@@ -334,4 +334,24 @@ get_sm2_ecdsa_verify_function(void)
 	return qat_function;
 }
 
+static struct qat_asym_function
+get_sm2_encryption_function(void)
+{
+	struct qat_asym_function qat_function = {
+		PKE_ECSM2_ENCRYPTION, 32
+	};
+
+	return qat_function;
+}
+
+static struct qat_asym_function
+get_sm2_decryption_function(void)
+{
+	struct qat_asym_function qat_function = {
+		PKE_ECSM2_DECRYPTION, 32
+	};
+
+	return qat_function;
+}
+
 #endif
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
index 638da1a173..843580af72 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
@@ -115,6 +115,38 @@ static struct rte_cryptodev_capabilities qat_sym_crypto_caps_gen4[] = {
 	RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
 };
 
+static struct rte_cryptodev_capabilities qat_asym_crypto_caps_gen4[] = {
+	QAT_ASYM_CAP(MODEX,
+		0, 1, 512, 1),
+	QAT_ASYM_CAP(MODINV,
+		0, 1, 512, 1),
+	QAT_ASYM_CAP(RSA,
+			((1 << RTE_CRYPTO_ASYM_OP_SIGN) |
+			(1 << RTE_CRYPTO_ASYM_OP_VERIFY) |
+			(1 << RTE_CRYPTO_ASYM_OP_ENCRYPT) |
+			(1 << RTE_CRYPTO_ASYM_OP_DECRYPT)),
+			64, 512, 64),
+	{	/* SM2 */
+		.op = RTE_CRYPTO_OP_TYPE_ASYMMETRIC,
+		{.asym = {
+			.xform_capa = {
+				.xform_type = RTE_CRYPTO_ASYM_XFORM_SM2,
+				.op_types =
+				((1 << RTE_CRYPTO_ASYM_OP_SIGN) |
+				 (1 << RTE_CRYPTO_ASYM_OP_VERIFY) |
+				 (1 << RTE_CRYPTO_ASYM_OP_ENCRYPT) |
+				 (1 << RTE_CRYPTO_ASYM_OP_DECRYPT)),
+				.op_capa = {
+					[RTE_CRYPTO_ASYM_OP_ENCRYPT] = (1 << RTE_CRYPTO_SM2_PARTIAL),
+					[RTE_CRYPTO_ASYM_OP_DECRYPT] = (1 << RTE_CRYPTO_SM2_PARTIAL),
+				},
+			},
+		}
+		}
+	},
+	RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
+};
+
 static int
 qat_sym_crypto_cap_get_gen4(struct qat_cryptodev_private *internals,
 			const char *capa_memz_name,
@@ -157,6 +189,44 @@ qat_sym_crypto_cap_get_gen4(struct qat_cryptodev_private *internals,
 	return 0;
 }
 
+static int
+qat_asym_crypto_cap_get_gen4(struct qat_cryptodev_private *internals,
+			const char *capa_memz_name,
+			const uint16_t __rte_unused slice_map)
+{
+	const uint32_t size = sizeof(qat_asym_crypto_caps_gen4);
+	uint32_t i;
+
+	internals->capa_mz = rte_memzone_lookup(capa_memz_name);
+	if (internals->capa_mz == NULL) {
+		internals->capa_mz = rte_memzone_reserve(capa_memz_name,
+				size, rte_socket_id(), 0);
+		if (internals->capa_mz == NULL) {
+			QAT_LOG(DEBUG,
+				"Error allocating memzone for capabilities");
+			return -1;
+		}
+	}
+
+	struct rte_cryptodev_capabilities *addr =
+			(struct rte_cryptodev_capabilities *)
+				internals->capa_mz->addr;
+	const struct rte_cryptodev_capabilities *capabilities =
+		qat_asym_crypto_caps_gen4;
+	const uint32_t capa_num =
+		size / sizeof(struct rte_cryptodev_capabilities);
+	uint32_t curr_capa = 0;
+
+	for (i = 0; i < capa_num; i++) {
+		memcpy(addr + curr_capa, capabilities + i,
+			sizeof(struct rte_cryptodev_capabilities));
+		curr_capa++;
+	}
+	internals->qat_dev_capabilities = internals->capa_mz->addr;
+
+	return 0;
+}
+
 static __rte_always_inline void
 enqueue_one_aead_job_gen4(struct qat_sym_session *ctx,
 	struct icp_qat_fw_la_bulk_req *req,
@@ -546,7 +616,7 @@ RTE_INIT(qat_asym_crypto_gen4_init)
 			&qat_asym_crypto_ops_gen1;
 	qat_asym_gen_dev_ops[QAT_VQAT].get_capabilities =
 		qat_asym_gen_dev_ops[QAT_GEN4].get_capabilities =
-			qat_asym_crypto_cap_get_gen1;
+			qat_asym_crypto_cap_get_gen4;
 	qat_asym_gen_dev_ops[QAT_VQAT].get_feature_flags =
 		qat_asym_gen_dev_ops[QAT_GEN4].get_feature_flags =
 			qat_asym_crypto_feature_flags_get_gen1;
diff --git a/drivers/crypto/qat/qat_asym.c b/drivers/crypto/qat/qat_asym.c
index d8a1406819..51e461c12f 100644
--- a/drivers/crypto/qat/qat_asym.c
+++ b/drivers/crypto/qat/qat_asym.c
@@ -932,6 +932,15 @@ sm2_ecdsa_sign_set_input(struct icp_qat_fw_pke_request *qat_req,
 	qat_req->input_param_count = 3;
 	qat_req->output_param_count = 2;
 
+	HEXDUMP("SM2 K test", asym_op->sm2.k.data,
+		cookie->alg_bytesize);
+	HEXDUMP("SM2 K", cookie->input_array[0],
+		cookie->alg_bytesize);
+	HEXDUMP("SM2 msg", cookie->input_array[1],
+		cookie->alg_bytesize);
+	HEXDUMP("SM2 pkey", cookie->input_array[2],
+		cookie->alg_bytesize);
+
 	return RTE_CRYPTO_OP_STATUS_SUCCESS;
 }
 
@@ -982,6 +991,114 @@ sm2_ecdsa_sign_collect(struct rte_crypto_asym_op *asym_op,
 	return RTE_CRYPTO_OP_STATUS_SUCCESS;
 }
 
+static int
+sm2_encryption_set_input(struct icp_qat_fw_pke_request *qat_req,
+	struct qat_asym_op_cookie *cookie,
+	const struct rte_crypto_asym_op *asym_op,
+	const struct rte_crypto_asym_xform *xform)
+{
+	const struct qat_asym_function qat_function =
+		get_sm2_encryption_function();
+	const uint32_t qat_func_alignsize =
+		qat_function.bytesize;
+
+	SET_PKE_LN(asym_op->sm2.k, qat_func_alignsize, 0);
+	SET_PKE_LN(xform->ec.q.x, qat_func_alignsize, 1);
+	SET_PKE_LN(xform->ec.q.y, qat_func_alignsize, 2);
+
+	cookie->alg_bytesize = qat_function.bytesize;
+	cookie->qat_func_alignsize = qat_function.bytesize;
+	qat_req->pke_hdr.cd_pars.func_id = qat_function.func_id;
+	qat_req->input_param_count = 3;
+	qat_req->output_param_count = 4;
+
+	HEXDUMP("SM2 K", cookie->input_array[0],
+		qat_func_alignsize);
+	HEXDUMP("SM2 Q.x", cookie->input_array[1],
+		qat_func_alignsize);
+	HEXDUMP("SM2 Q.y", cookie->input_array[2],
+		qat_func_alignsize);
+
+	return RTE_CRYPTO_OP_STATUS_SUCCESS;
+}
+
+static uint8_t
+sm2_encryption_collect(struct rte_crypto_asym_op *asym_op,
+		const struct qat_asym_op_cookie *cookie)
+{
+	uint32_t alg_bytesize = cookie->alg_bytesize;
+
+	rte_memcpy(asym_op->sm2.c1.x.data, cookie->output_array[0], alg_bytesize);
+	rte_memcpy(asym_op->sm2.c1.y.data, cookie->output_array[1], alg_bytesize);
+	rte_memcpy(asym_op->sm2.kp.x.data, cookie->output_array[2], alg_bytesize);
+	rte_memcpy(asym_op->sm2.kp.y.data, cookie->output_array[3], alg_bytesize);
+	asym_op->sm2.c1.x.length = alg_bytesize;
+	asym_op->sm2.c1.y.length = alg_bytesize;
+	asym_op->sm2.kp.x.length = alg_bytesize;
+	asym_op->sm2.kp.y.length = alg_bytesize;
+
+	HEXDUMP("c1[x1]", cookie->output_array[0],
+		alg_bytesize);
+	HEXDUMP("c1[y]", cookie->output_array[1],
+		alg_bytesize);
+	HEXDUMP("kp[x]", cookie->output_array[2],
+		alg_bytesize);
+	HEXDUMP("kp[y]", cookie->output_array[3],
+		alg_bytesize);
+	return RTE_CRYPTO_OP_STATUS_SUCCESS;
+}
+
+
+static int
+sm2_decryption_set_input(struct icp_qat_fw_pke_request *qat_req,
+	struct qat_asym_op_cookie *cookie,
+	const struct rte_crypto_asym_op *asym_op,
+	const struct rte_crypto_asym_xform *xform)
+{
+	const struct qat_asym_function qat_function =
+		get_sm2_decryption_function();
+	const uint32_t qat_func_alignsize =
+		qat_function.bytesize;
+
+	SET_PKE_LN(xform->ec.pkey, qat_func_alignsize, 0);
+	SET_PKE_LN(asym_op->sm2.c1.x, qat_func_alignsize, 1);
+	SET_PKE_LN(asym_op->sm2.c1.y, qat_func_alignsize, 2);
+
+	cookie->alg_bytesize = qat_function.bytesize;
+	cookie->qat_func_alignsize = qat_function.bytesize;
+	qat_req->pke_hdr.cd_pars.func_id = qat_function.func_id;
+	qat_req->input_param_count = 3;
+	qat_req->output_param_count = 2;
+
+	HEXDUMP("d", cookie->input_array[0],
+		qat_func_alignsize);
+	HEXDUMP("c1[x]", cookie->input_array[1],
+		qat_func_alignsize);
+	HEXDUMP("c1[y]", cookie->input_array[2],
+		qat_func_alignsize);
+
+	return RTE_CRYPTO_OP_STATUS_SUCCESS;
+}
+
+
+static uint8_t
+sm2_decryption_collect(struct rte_crypto_asym_op *asym_op,
+		const struct qat_asym_op_cookie *cookie)
+{
+	uint32_t alg_bytesize = cookie->alg_bytesize;
+
+	rte_memcpy(asym_op->sm2.kp.x.data, cookie->output_array[0], alg_bytesize);
+	rte_memcpy(asym_op->sm2.kp.y.data, cookie->output_array[1], alg_bytesize);
+	asym_op->sm2.kp.x.length = alg_bytesize;
+	asym_op->sm2.kp.y.length = alg_bytesize;
+
+	HEXDUMP("kp[x]", cookie->output_array[0],
+		alg_bytesize);
+	HEXDUMP("kp[y]", cookie->output_array[1],
+		alg_bytesize);
+	return RTE_CRYPTO_OP_STATUS_SUCCESS;
+}
+
 static int
 asym_set_input(struct icp_qat_fw_pke_request *qat_req,
 		struct qat_asym_op_cookie *cookie,
@@ -1014,14 +1131,20 @@ asym_set_input(struct icp_qat_fw_pke_request *qat_req,
 				asym_op, xform);
 		}
 	case RTE_CRYPTO_ASYM_XFORM_SM2:
-		if (asym_op->sm2.op_type ==
-			RTE_CRYPTO_ASYM_OP_VERIFY) {
+		if (asym_op->sm2.op_type == RTE_CRYPTO_ASYM_OP_ENCRYPT) {
+			return sm2_encryption_set_input(qat_req, cookie,
+				asym_op, xform);
+		} else if (asym_op->sm2.op_type == RTE_CRYPTO_ASYM_OP_DECRYPT) {
+			return sm2_decryption_set_input(qat_req, cookie,
+				asym_op, xform);
+		} else if (asym_op->sm2.op_type == RTE_CRYPTO_ASYM_OP_VERIFY) {
 			return sm2_ecdsa_verify_set_input(qat_req, cookie,
 						asym_op, xform);
-		} else {
+		} else if (asym_op->sm2.op_type == RTE_CRYPTO_ASYM_OP_SIGN) {
 			return sm2_ecdsa_sign_set_input(qat_req, cookie,
 					asym_op, xform);
 		}
+		break;
 	default:
 		QAT_LOG(ERR, "Invalid/unsupported asymmetric crypto xform");
 		return -EINVAL;
@@ -1113,7 +1236,13 @@ qat_asym_collect_response(struct rte_crypto_op *op,
 	case RTE_CRYPTO_ASYM_XFORM_ECDH:
 		return ecdh_collect(asym_op, cookie);
 	case RTE_CRYPTO_ASYM_XFORM_SM2:
-		return sm2_ecdsa_sign_collect(asym_op, cookie);
+		if (asym_op->sm2.op_type == RTE_CRYPTO_ASYM_OP_ENCRYPT)
+			return sm2_encryption_collect(asym_op, cookie);
+		else if (asym_op->sm2.op_type == RTE_CRYPTO_ASYM_OP_DECRYPT)
+			return sm2_decryption_collect(asym_op, cookie);
+		else
+			return sm2_ecdsa_sign_collect(asym_op, cookie);
+
 	default:
 		QAT_LOG(ERR, "Not supported xform type");
 		return  RTE_CRYPTO_OP_STATUS_ERROR;
@@ -1422,9 +1551,8 @@ qat_asym_session_configure(struct rte_cryptodev *dev __rte_unused,
 	case RTE_CRYPTO_ASYM_XFORM_ECDSA:
 	case RTE_CRYPTO_ASYM_XFORM_ECPM:
 	case RTE_CRYPTO_ASYM_XFORM_ECDH:
-		ret = session_set_ec(qat_session, xform);
-		break;
 	case RTE_CRYPTO_ASYM_XFORM_SM2:
+		ret = session_set_ec(qat_session, xform);
 		break;
 	default:
 		ret = -ENOTSUP;
-- 
2.43.0

