Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4423AC61DD3
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 08:27:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12BA242798;
	Thu,  3 Sep 2026 10:27:30 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5A65B4028D
 for <dev@dpdk.org>; Thu,  3 Sep 2026 10:27:28 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6835lemY3630047; Thu, 3 Sep 2026 01:27:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Y
 htCvhkbVkK5K8v9fpMjz/nC9Yj9GenzQrP53NYo1ZQ=; b=KhXX/hJbI0vqWqzmD
 oNIHLj3WGXWliDZW16TNlccaX5mNozdCMg56HxnmX35Dx9oLlWPSsvS3AUb6eSvw
 lr87gRI07BqaduQcIGSDyTuUF+nHNheNFAiX6+Zb2a+HlU+d2OLjqKxmeuupgF5P
 GDTjplsuXDy7xtckN6MHkZPFoWg0EEiYwQvNmXHH2N3nlBlHPc1hkD8VRb5KQojF
 drZrupt/cvXsEbD+XbgfMNBkUiiP0Q+eZxiVTPyEbuGI/GIMaNixXkDzBTOnEpVB
 CYjGhD27ptBsPfgw3LrHJGozDpZ9LDdDvRqcCAPav9lJmyvgPE2y2aV1ViZ032Dc
 irZ+w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gef5b3y01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 01:27:27 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Sep 2026 01:27:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 3 Sep 2026 01:27:26 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id 2D9C33F7068;
 Thu,  3 Sep 2026 01:27:22 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <radu.nicolau@intel.com>,
 <gmuthukrishn@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH v2 5/8] crypto/openssl: add RSA-OAEP support for OpenSSL PMD
Date: Thu, 3 Sep 2026 08:26:45 +0000
Message-ID: <20260903082648.3610676-6-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260903082648.3610676-1-ssarananaga@marvell.com>
References: <20260831102328.2813604-1-ssarananaga@marvell.com>
 <20260903082648.3610676-1-ssarananaga@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA3MyBTYWx0ZWRfX5IG3yhMRKk0I
 EAC1SEUmd2SNPAbmmikIRu7FgpehrSiQV5cOndi4n2rBb++L7af8pYDgLS67v4TvqukLmlsmC0Q
 AAgV0SBtoqhNdtKoHbnFZVAAGLxSrTV5/IgSEUfJXCYBjlzAVO8M7e/k1joKzwQjTO6Iize9N9F
 sZ11i/i2nW+Bmpr2RMX7Ys7f3CH0HsIbV7mqxp+Io8+UNpCPX+l8WPZ+V9nREIwLwmHiTOelByk
 R565NsHfhNBp890R4ziWhW+qdE+Z+32xyJNhYUETIqmowMdbozBu+n5hjDPas+QySwagsycTOFa
 7+9QzcSFpcK0Z3wBUmwCu7xejce15NGfVRchvQvBAu0tu3YrId5U0CWqul/md3rk+a6W7ysmFJw
 zAHnCSAFwxSDbVVeu5AGuSgoIE5N2IFFcyHSzWP+mJBGAC3xCOcn4U2YQg94ltjlzux1DuUoCQ1
 ktjcsJ8qqWHIrTMgxvQ==
X-Proofpoint-GUID: qkaWvwmw1sAaqaYA0Mt_a6c0HSRY5Hl6
X-Authority-Analysis: v=2.4 cv=e6Y2j6p/ c=1 sm=1 tr=0 ts=6a992f6f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=MdwzAXbWYWzcP4Eo634A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: qkaWvwmw1sAaqaYA0Mt_a6c0HSRY5Hl6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA3MyBTYWx0ZWRfX3IA2HXAUKMaX
 +wy3sCamV4QH1H3txkmTupw90MSYz74M09lcVSz6YCM8ZZT9oczDioDhC6Gbl76ccHgdek8HVKZ
 KRtfzwhfPOSLckJMKjsD5ybs5qzZPtQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
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

Add support for RSA OAEP padding in the OpenSSL PMD OpenSSL 3.x
implementation.

Store OAEP configuration parameters in the RSA asymmetric session,
including the OAEP hash, MGF1 hash, and optional label. Configure
these parameters on the EVP_PKEY context during RSA encrypt and
decrypt operations, and default the MGF1 hash to the OAEP hash when
not specified by the application.

Validate OAEP-specific usage, restrict it to encrypt/decrypt
operations, and add proper cleanup of allocated label resources on
error and session teardown paths.

Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
---
 drivers/crypto/openssl/openssl_pmd_private.h |  5 ++
 drivers/crypto/openssl/rte_openssl_pmd.c     | 53 ++++++++++++
 drivers/crypto/openssl/rte_openssl_pmd_ops.c | 90 ++++++++++++++++++++
 3 files changed, 148 insertions(+)

diff --git a/drivers/crypto/openssl/openssl_pmd_private.h b/drivers/crypto/openssl/openssl_pmd_private.h
index ab40012d61..8704e1915a 100644
--- a/drivers/crypto/openssl/openssl_pmd_private.h
+++ b/drivers/crypto/openssl/openssl_pmd_private.h
@@ -181,6 +181,11 @@ struct __rte_cache_aligned openssl_asym_session {
 			RSA *rsa;
 			uint32_t pad;
 			EVP_PKEY_CTX * ctx;
+			const EVP_MD *oaep_md;
+			const EVP_MD *mgf1_md;
+
+			uint8_t *label;
+			uint32_t label_len;
 		} r;
 		struct exp {
 			BIGNUM *exp;
diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/openssl/rte_openssl_pmd.c
index 2319c7cfa9..4fbbb73bfa 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c
@@ -2292,6 +2292,41 @@ process_openssl_modexp_op(struct rte_crypto_op *cop,
 	return 0;
 }
 
+/**
+ * Configure RSA-OAEP parameters on an initialized EVP_PKEY_CTX.
+ * Must be called after EVP_PKEY_encrypt_init() or EVP_PKEY_decrypt_init().
+ *
+ * @return 0 on success, -1 on failure.
+ */
+static int
+openssl_rsa_set_oaep_params(EVP_PKEY_CTX *ctx,
+		const struct openssl_asym_session *sess)
+{
+	if (sess->u.r.pad != RTE_CRYPTO_RSA_PADDING_OAEP)
+		return 0;
+
+	if (EVP_PKEY_CTX_set_rsa_oaep_md(ctx, sess->u.r.oaep_md) <= 0)
+		return -1;
+
+	if (EVP_PKEY_CTX_set_rsa_mgf1_md(ctx, sess->u.r.mgf1_md) <= 0)
+		return -1;
+
+	if (sess->u.r.label_len > 0) {
+		void *label = OPENSSL_memdup(sess->u.r.label, sess->u.r.label_len);
+
+		if (label == NULL)
+			return -1;
+
+		if (EVP_PKEY_CTX_set0_rsa_oaep_label(ctx, label, sess->u.r.label_len) <= 0) {
+			OPENSSL_free(label);
+			return -1;
+		}
+	}
+	/* Empty label is default; set0_rsa_oaep_label(NULL,0) fails on OpenSSL 3. */
+
+	return 0;
+}
+
 /* process rsa operations */
 static int
 process_openssl_rsa_op_evp(struct rte_crypto_op *cop,
@@ -2308,6 +2343,15 @@ process_openssl_rsa_op_evp(struct rte_crypto_op *cop,
 	if (!rsa_ctx)
 		return ret;
 
+	/* OAEP is only valid for encrypt/decrypt */
+	if (sess->u.r.pad == RTE_CRYPTO_RSA_PADDING_OAEP &&
+			op->rsa.op_type != RTE_CRYPTO_ASYM_OP_ENCRYPT &&
+			op->rsa.op_type != RTE_CRYPTO_ASYM_OP_DECRYPT) {
+		OPENSSL_LOG(ERR, "OAEP supports encrypt/decrypt only");
+		cop->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
+		return ret;
+	}
+
 	switch (pad) {
 	case RTE_CRYPTO_RSA_PADDING_PKCS1_5:
 		pad = RSA_PKCS1_PADDING;
@@ -2315,6 +2359,9 @@ process_openssl_rsa_op_evp(struct rte_crypto_op *cop,
 	case RTE_CRYPTO_RSA_PADDING_NONE:
 		pad = RSA_NO_PADDING;
 		break;
+	case RTE_CRYPTO_RSA_PADDING_OAEP:
+		pad = RSA_PKCS1_OAEP_PADDING;
+		break;
 	default:
 		cop->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
 		OPENSSL_LOG(ERR,
@@ -2330,6 +2377,9 @@ process_openssl_rsa_op_evp(struct rte_crypto_op *cop,
 		if (EVP_PKEY_CTX_set_rsa_padding(rsa_ctx, pad) <= 0)
 			goto err_rsa;
 
+		if (openssl_rsa_set_oaep_params(rsa_ctx, sess) < 0)
+			goto err_rsa;
+
 		if (EVP_PKEY_encrypt(rsa_ctx, NULL, &outlen,
 				op->rsa.message.data,
 				op->rsa.message.length) <= 0)
@@ -2355,6 +2405,9 @@ process_openssl_rsa_op_evp(struct rte_crypto_op *cop,
 		if (EVP_PKEY_CTX_set_rsa_padding(rsa_ctx, pad) <= 0)
 			goto err_rsa;
 
+		if (openssl_rsa_set_oaep_params(rsa_ctx, sess) < 0)
+			goto err_rsa;
+
 		if (EVP_PKEY_decrypt(rsa_ctx, NULL, &outlen,
 				op->rsa.cipher.data,
 				op->rsa.cipher.length) <= 0)
diff --git a/drivers/crypto/openssl/rte_openssl_pmd_ops.c b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
index 60d33f3474..902b46918d 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd_ops.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2016-2017 Intel Corporation
  */
 
+#include <limits.h>
 #include <string.h>
 
 #include <rte_common.h>
@@ -1208,6 +1209,33 @@ openssl_pmd_sym_session_configure(struct rte_cryptodev *dev,
 	return 0;
 }
 
+static const EVP_MD *
+openssl_get_md(enum rte_crypto_auth_algorithm alg)
+{
+	switch (alg) {
+	case RTE_CRYPTO_AUTH_SHA1:
+		return EVP_sha1();
+	case RTE_CRYPTO_AUTH_SHA224:
+		return EVP_sha224();
+	case RTE_CRYPTO_AUTH_SHA256:
+		return EVP_sha256();
+	case RTE_CRYPTO_AUTH_SHA384:
+		return EVP_sha384();
+	case RTE_CRYPTO_AUTH_SHA512:
+		return EVP_sha512();
+	case RTE_CRYPTO_AUTH_SHA3_224:
+		return EVP_sha3_224();
+	case RTE_CRYPTO_AUTH_SHA3_256:
+		return EVP_sha3_256();
+	case RTE_CRYPTO_AUTH_SHA3_384:
+		return EVP_sha3_384();
+	case RTE_CRYPTO_AUTH_SHA3_512:
+		return EVP_sha3_512();
+	default:
+		return NULL;
+	}
+}
+
 static int openssl_set_asym_session_parameters(
 		struct openssl_asym_session *asym_session,
 		struct rte_crypto_asym_xform *xform)
@@ -1229,6 +1257,7 @@ static int openssl_set_asym_session_parameters(
 		BIGNUM *d = NULL;
 		BIGNUM *p = NULL, *q = NULL, *dmp1 = NULL;
 		BIGNUM *iqmp = NULL, *dmq1 = NULL;
+		uint32_t label_len = 0;
 
 		/* copy xfrm data into rsa struct */
 		n = BN_bin2bn((const unsigned char *)xform->rsa.n.data,
@@ -1240,6 +1269,57 @@ static int openssl_set_asym_session_parameters(
 			goto err_rsa;
 
 		asym_session->u.r.pad = xform->rsa.padding.type;
+		if (xform->rsa.padding.type == RTE_CRYPTO_RSA_PADDING_OAEP) {
+			asym_session->u.r.oaep_md = openssl_get_md(xform->rsa.padding.hash);
+
+			if (asym_session->u.r.oaep_md == NULL) {
+				OPENSSL_LOG(ERR,
+					"Unsupported OAEP hash algorithm %u",
+					xform->rsa.padding.hash);
+				goto err_rsa;
+			}
+
+			enum rte_crypto_auth_algorithm mgf1 = xform->rsa.padding.mgf1hash;
+
+			if (mgf1 == 0)
+				mgf1 = xform->rsa.padding.hash;
+
+			asym_session->u.r.mgf1_md = openssl_get_md(mgf1);
+			if (asym_session->u.r.mgf1_md == NULL) {
+				OPENSSL_LOG(ERR,
+					"Unsupported OAEP MGF1 hash algorithm %u", mgf1);
+				goto err_rsa;
+			}
+
+			if (xform->rsa.padding.oaep_label.length > (size_t)INT_MAX) {
+				OPENSSL_LOG(ERR,
+					"OAEP label length %zu is too large",
+					xform->rsa.padding.oaep_label.length);
+				goto err_rsa;
+			}
+
+			label_len = (uint32_t)xform->rsa.padding.oaep_label.length;
+			if (label_len > 0) {
+				if (xform->rsa.padding.oaep_label.data == NULL) {
+					OPENSSL_LOG(ERR,
+						"OAEP label length is non-zero but data is NULL");
+					goto err_rsa;
+				}
+
+				asym_session->u.r.label = OPENSSL_zalloc(label_len);
+				if (asym_session->u.r.label == NULL)
+					goto err_rsa;
+
+				rte_memcpy(asym_session->u.r.label,
+					xform->rsa.padding.oaep_label.data,
+					label_len);
+				asym_session->u.r.label_len = label_len;
+			} else {
+				asym_session->u.r.label_len = 0;
+				asym_session->u.r.label = NULL;
+			}
+		}
+
 		OSSL_PARAM_BLD * param_bld = OSSL_PARAM_BLD_new();
 		if (!param_bld) {
 			OPENSSL_LOG(ERR, "failed to allocate resources");
@@ -1342,6 +1422,11 @@ static int openssl_set_asym_session_parameters(
 		ret = 0;
 
 err_rsa:
+		if (ret != 0 && asym_session->u.r.label) {
+			OPENSSL_free(asym_session->u.r.label);
+			asym_session->u.r.label = NULL;
+			asym_session->u.r.label_len = 0;
+		}
 		BN_clear_free(n);
 		BN_clear_free(e);
 		BN_clear_free(d);
@@ -1817,6 +1902,11 @@ static void openssl_reset_asym_session(struct openssl_asym_session *sess)
 	switch (sess->xfrm_type) {
 	case RTE_CRYPTO_ASYM_XFORM_RSA:
 		EVP_PKEY_CTX_free(sess->u.r.ctx);
+		if (sess->u.r.label_len > 0) {
+			OPENSSL_free(sess->u.r.label);
+			sess->u.r.label = NULL;
+			sess->u.r.label_len = 0;
+		}
 		break;
 	case RTE_CRYPTO_ASYM_XFORM_MODEX:
 		if (sess->u.e.ctx) {
-- 
2.54.0

