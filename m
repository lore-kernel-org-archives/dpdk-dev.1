Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E76C9830D
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 08:15:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D55542EF5;
	Fri, 25 Sep 2026 10:15:58 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6088540BA6
 for <dev@dpdk.org>; Fri, 25 Sep 2026 10:15:56 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P4awMA505738; Fri, 25 Sep 2026 01:15:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=i
 ihPP5M6oD6gfrkvY1lgKBF2dswBDd/8CTRNy6M6UF8=; b=eDjUlZyuhOfI9zNev
 fhnW/H1hfUgGJwpT1giTnAZAuIRuJyrqNO+1qqe3k0AADaD48/BFrDPeMMGpnjhV
 WbkPW+WBBlGE69rSwUqG2Ldv2nTg2PEcri7uWXWHh1UGQKJxeHUxZkg21Y4VUB0H
 eZ3Q/4eWbiHTQPCbnBKzPQOywaemvmy15xxoyGhf9EsfeQ0sqLz0QCj0S6nr2jV0
 DqELKKv6/U//6XW2hlo3xhi3EduaEDmPdd4mf2XRtPSijtywnPy7FNEnboyE95+N
 9ns2FQBbSmBx5mKJa8Xe9ajWDtDmuo3SWEM2/NkwDgEOg7pBGImo6j6F2iw/YzMO
 x5F+w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gwdh71raq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 01:15:55 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 25 Sep 2026 01:15:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 25 Sep 2026 01:15:55 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id B8A3B5B6954;
 Fri, 25 Sep 2026 01:15:51 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <radu.nicolau@intel.com>,
 <gmuthukrishn@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH v3 5/8] crypto/openssl: support RSA-OAEP
Date: Fri, 25 Sep 2026 08:14:57 +0000
Message-ID: <20260925081500.3848187-6-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925081500.3848187-1-ssarananaga@marvell.com>
References: <20260903082648.3610676-1-ssarananaga@marvell.com>
 <20260925081500.3848187-1-ssarananaga@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: EP_oj5Efu8kRmd085ngki_lZfktjlnN5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzMiBTYWx0ZWRfXyIT5GCrv5gYC
 +5pbUX3Btzh4TChOA+FgtniwAPbhTnZsFmKjpGSIyP04aE+IrMDTf1aCdDRH9MJ5IoseDKTq9vl
 okr3NoioLID2cLD1IQD0+mIzM8c9ioc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzMiBTYWx0ZWRfXyc1RM6E8CFp8
 caUHetfkiRURv30YGej+tarm0L69jzr5bEJUn4P/2e4Pbqnr7KhuZ+1YRnr97HVEXcQFlhLaH1y
 3ND+Rj6mJnyFv5PA7ASWVNOwH6QeXVkV2xbCxjIAGjosP2Ngc73hMH45xufIpA/jSk3HbcfpaPk
 WhtgT0/PZN1scREAg/bhPTeMhrY2ua63WwYaSoxy3AIOaXWLh0Ld+dRB/TUxoG3OiUGV2W+g6wi
 bFdTSIGbkFx61T3EXUnOTeUIKpoL2K4uNAShIC3V7iBNActcOJq6DjqRxzuHNOYZbmjaMXPzMxh
 m8BX5gbPA2MCyuuXKcwwuaespvW5qnCY55wFBGWWJAhUAs/qlGKh6Gybnll3foGbK2xwihTj00p
 D6rXppAFWQh3T9HN7jhL03l4NBr4GQu9hB5mym/XZYE70X1aAIDPiWBiC5OxSmcUIIp0UpedhUR
 aawzwjPEsHBbcn6JhfA==
X-Authority-Analysis: v=2.4 cv=OeINnRTY c=1 sm=1 tr=0 ts=6ab62dbb cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=MdwzAXbWYWzcP4Eo634A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: EP_oj5Efu8kRmd085ngki_lZfktjlnN5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
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
 drivers/crypto/openssl/openssl_pmd_private.h |  4 +
 drivers/crypto/openssl/rte_openssl_pmd.c     | 53 ++++++++++++
 drivers/crypto/openssl/rte_openssl_pmd_ops.c | 90 ++++++++++++++++++++
 3 files changed, 147 insertions(+)

diff --git a/drivers/crypto/openssl/openssl_pmd_private.h b/drivers/crypto/openssl/openssl_pmd_private.h
index ab40012d61..2807629630 100644
--- a/drivers/crypto/openssl/openssl_pmd_private.h
+++ b/drivers/crypto/openssl/openssl_pmd_private.h
@@ -181,6 +181,10 @@ struct __rte_cache_aligned openssl_asym_session {
 			RSA *rsa;
 			uint32_t pad;
 			EVP_PKEY_CTX * ctx;
+			const EVP_MD *oaep_md;
+			const EVP_MD *mgf1_md;
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
index 60d33f3474..d2f699c266 100644
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
@@ -1229,6 +1257,8 @@ static int openssl_set_asym_session_parameters(
 		BIGNUM *d = NULL;
 		BIGNUM *p = NULL, *q = NULL, *dmp1 = NULL;
 		BIGNUM *iqmp = NULL, *dmq1 = NULL;
+		uint32_t label_len = 0;
+		enum rte_crypto_auth_algorithm mgf1;
 
 		/* copy xfrm data into rsa struct */
 		n = BN_bin2bn((const unsigned char *)xform->rsa.n.data,
@@ -1240,6 +1270,56 @@ static int openssl_set_asym_session_parameters(
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
+			mgf1 = xform->rsa.padding.mgf1hash;
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
+				memcpy(asym_session->u.r.label,
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

