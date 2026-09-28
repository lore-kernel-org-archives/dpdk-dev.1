Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B11EC98328
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 05:05:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5283340B91;
	Mon, 28 Sep 2026 07:05:12 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E8186406BB
 for <dev@dpdk.org>; Mon, 28 Sep 2026 07:05:06 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68RNvpeu3846786; Sun, 27 Sep 2026 22:05:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=O
 obdSF+sFYv60G03n8aWu9r8iI9yzLWKMIraN7IvkVY=; b=j2tI6nZSO50qzOLXY
 ClNSnwxqTewLxCxb1a1Vxt4TEVJ5uGy2+VweL51W1vYsZiqN1jHh5pVJEQ14oqHf
 goGbFlsgK45poy/GwjLa/HQtP3CigU9z6yMqrfjk0ytZI2L6Q2HIl3WYtYZASWvh
 Q2dWO9jN67bqF2YLc1jEnAqCFEeBZb6/T8mrOkY/7kmJba11aUriQ+6LE5oQyvaY
 9E3uPnl8YTt1gIiGUiuY/4Nv9mB8EOxpe/HpZi76Szztzwmja8w6JvGHgZb9cf6W
 T6ygSc+Fq3E6cO07wK/oLNjknzx8I9/ceGj02xzVijVp4eihDmM8G+BC2hyQukrT
 sN1GA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gxx2cj3qk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 27 Sep 2026 22:05:06 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 27 Sep 2026 22:05:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 27 Sep 2026 22:05:05 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id D73A03F70BB;
 Sun, 27 Sep 2026 22:05:01 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <radu.nicolau@intel.com>,
 <gmuthukrishn@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH v4 7/8] crypto/openssl: support RSA-PSS
Date: Mon, 28 Sep 2026 05:04:11 +0000
Message-ID: <20260928050412.276760-8-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928050412.276760-1-ssarananaga@marvell.com>
References: <20260925081500.3848187-1-ssarananaga@marvell.com>
 <20260928050412.276760-1-ssarananaga@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAxOSBTYWx0ZWRfXxw1rc28j+qJC
 D7cjUzRQIKgAJYU3lZXpq+sorBKDs5u0w+U+yRJAE/TkJX+rc9pgAHiaqD1LwT8ajU/PPwq8i1c
 UOpBbTDaislw9EekEScwBViRY9qdQ7XRt9dO+X9fUf0tkTFCyG64KRXJLPMjSfknZkyAM/3AKGy
 wBaM/Gw2uI2L4SnS8SQ2VC2hdwU/t3/ffXY2XSRuxLjJqwefjwAvfbs+R2J45oNJB5AN2Xn+ZuW
 ScM+2Vqdwcu5BWZ8l4dbklql+LXdeYY/IppFcUHLiynHt1PPu6w0ubJXSCMWjvBC6oj+G8iBhZy
 85/gwHxobob4YeXSmmtTyw3hn2miq7VPbOrPZCh4fpf3gVz7Cvbn/v2RWxVBJuk3AhmYtSfeqiO
 DM9cLzxDjh7SkLLPhhbLASam12qLwyjX75yxg3QCAQn36ACnXqDgBCnaGEo/DivyUcppAl4Vspb
 vR4wQ6CGUraAMvVlAFQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAxOSBTYWx0ZWRfX0nvQfCJA7TID
 wLvAo+m444e7ift0ITExV9PRY4yp7WP6Sqg2CRbFZGBAiuQWHsGk0lpiJfGhPTV/PZHx6YcEM0G
 B8FvAbmuFRStenMekIYRJPOTyPIups8=
X-Proofpoint-GUID: F9YPPC3OPjHhO9O--Gv29hT2qgLLjXns
X-Authority-Analysis: v=2.4 cv=d9dgWhjE c=1 sm=1 tr=0 ts=6ab9f582 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=Qn11q3s7xTGiqqrH8nwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: F9YPPC3OPjHhO9O--Gv29hT2qgLLjXns
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
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

Add RSA-PSS padding support to the OpenSSL crypto PMD.

Store PSS-specific parameters (hash, MGF1 hash, and salt length)
in the RSA session, advertise PSS capability, and configure the
OpenSSL EVP context accordingly for sign and verify operations.

Introduce a dedicated RSA-PSS verification path using
EVP_PKEY_verify(), while retaining verify-recover for supported
deterministic padding schemes. Reject unsupported RSA-PSS usage
for non-sign/verify operations.

Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
---
 drivers/crypto/openssl/openssl_pmd_private.h |   6 +
 drivers/crypto/openssl/rte_openssl_pmd.c     | 314 +++++++++++++++----
 drivers/crypto/openssl/rte_openssl_pmd_ops.c |  26 +-
 3 files changed, 291 insertions(+), 55 deletions(-)

diff --git a/drivers/crypto/openssl/openssl_pmd_private.h b/drivers/crypto/openssl/openssl_pmd_private.h
index 2807629630..059a14ef9f 100644
--- a/drivers/crypto/openssl/openssl_pmd_private.h
+++ b/drivers/crypto/openssl/openssl_pmd_private.h
@@ -5,6 +5,8 @@
 #ifndef _OPENSSL_PMD_PRIVATE_H_
 #define _OPENSSL_PMD_PRIVATE_H_
 
+#include <rte_common.h>
+
 #include <openssl/evp.h>
 #include <openssl/cmac.h>
 #include <openssl/hmac.h>
@@ -185,6 +187,10 @@ struct __rte_cache_aligned openssl_asym_session {
 			const EVP_MD *mgf1_md;
 			uint8_t *label;
 			uint32_t label_len;
+
+			const EVP_MD *pss_md;
+			const EVP_MD *pss_mgf1_md;
+			int pss_saltlen;
 		} r;
 		struct exp {
 			BIGNUM *exp;
diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/openssl/rte_openssl_pmd.c
index 4fbbb73bfa..1b33470c8f 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c
@@ -2327,6 +2327,216 @@ openssl_rsa_set_oaep_params(EVP_PKEY_CTX *ctx,
 	return 0;
 }
 
+/**
+ * Configure RSA-PSS padding parameters, including the signature digest,
+ * on an initialized EVP_PKEY_CTX. Must be called after
+ * EVP_PKEY_CTX_set_rsa_padding().
+ *
+ * @return 0 on success, -1 on failure.
+ */
+static int
+openssl_rsa_set_pss_params(EVP_PKEY_CTX *ctx,
+		const struct openssl_asym_session *sess)
+{
+	/*
+	 * Tells OpenSSL which hash algorithm was used to create the
+	 * input message digest (rte_crypto_rsa_padding::hash), so it
+	 * knows the expected digest length and can embed the correct
+	 * algorithm identifier while PSS-encoding it. This does not
+	 * cause the digest to be (re-)computed here: EVP_PKEY_sign()/
+	 * EVP_PKEY_verify() operate on the digest bytes as-is.
+	 */
+	if (EVP_PKEY_CTX_set_signature_md(ctx, sess->u.r.pss_md) <= 0)
+		return -1;
+
+	if (EVP_PKEY_CTX_set_rsa_mgf1_md(ctx, sess->u.r.pss_mgf1_md) <= 0)
+		return -1;
+
+	/* pss_saltlen is a literal byte count (0 is valid: no salt) */
+	if (EVP_PKEY_CTX_set_rsa_pss_saltlen(ctx, sess->u.r.pss_saltlen) <= 0)
+		return -1;
+
+	return 0;
+}
+
+/**
+ * Sign a message using RSA-PSS. Per rte_crypto_rsa_op_param::message and
+ * rte_crypto_rsa_padding::hash, the input is a digest already hashed by
+ * the caller with the configured algorithm, not the raw message, so
+ * EVP_PKEY_sign() is used directly on it (no internal re-hashing). This
+ * matches the pattern used for PKCS#1 v1.5/unpadded RSA signing in
+ * process_openssl_rsa_op_evp().
+ *
+ * The OpenSSL PMD does not advertise rte_crypto_rsa_capa::pss_explicit_salt,
+ * so an application-supplied rte_crypto_rsa_op_param::pss_salt is rejected
+ * by the caller before this function is invoked; the salt is always
+ * generated internally by OpenSSL's RNG via EVP_PKEY_sign().
+ *
+ * @return 0 on success, -1 on failure.
+ */
+static int
+openssl_rsa_pss_sign(uint32_t pad, const struct openssl_asym_session *sess,
+		struct rte_crypto_asym_op *op)
+{
+	EVP_PKEY_CTX *ctx = sess->u.r.ctx;
+	size_t outlen = 0;
+
+	if (EVP_PKEY_sign_init(ctx) <= 0)
+		return -1;
+
+	if (EVP_PKEY_CTX_set_rsa_padding(ctx, pad) <= 0)
+		return -1;
+
+	if (openssl_rsa_set_pss_params(ctx, sess) < 0)
+		return -1;
+
+	if (EVP_PKEY_sign(ctx, NULL, &outlen,
+			op->rsa.message.data, op->rsa.message.length) <= 0)
+		return -1;
+
+	if (outlen == 0 || outlen > op->rsa.sign.length)
+		return -1;
+
+	outlen = op->rsa.sign.length;
+	if (EVP_PKEY_sign(ctx, op->rsa.sign.data, &outlen,
+			op->rsa.message.data, op->rsa.message.length) <= 0)
+		return -1;
+
+	op->rsa.sign.length = outlen;
+	return 0;
+}
+
+/**
+ * Verify an RSA-PSS signature against a pre-computed message digest.
+ * Per rte_crypto_rsa_op_param::message and rte_crypto_rsa_padding::hash,
+ * the input is already a digest, so EVP_PKEY_verify() is used directly
+ * on it (no internal re-hashing). PSS does not support verify-recover,
+ * so this also gives a direct pass/fail result.
+ *
+ * A signature mismatch (including one caused by OpenSSL rejecting a
+ * malformed signature outright, e.g. wrong size) is a normal outcome,
+ * not a processing error, so it must not fail the enqueue operation.
+ *
+ * @return 0 if the signature is valid, 1 if invalid/mismatched,
+ *         -1 on a setup/processing failure unrelated to the signature.
+ */
+static int
+openssl_rsa_pss_verify(uint32_t pad, const struct openssl_asym_session *sess,
+		struct rte_crypto_asym_op *op)
+{
+	EVP_PKEY_CTX *ctx = sess->u.r.ctx;
+	int ret;
+
+	if (EVP_PKEY_verify_init(ctx) <= 0)
+		return -1;
+
+	if (EVP_PKEY_CTX_set_rsa_padding(ctx, pad) <= 0)
+		return -1;
+
+	if (openssl_rsa_set_pss_params(ctx, sess) < 0)
+		return -1;
+
+	/*
+	 * EVP_PKEY_verify() returns 1 for a valid signature, 0 for an
+	 * invalid one, and a negative value only for setup/library errors
+	 * (see EVP_PKEY_verify(3)); a malformed signature is reported via
+	 * a 0 return here too, not a negative one.
+	 */
+	ret = EVP_PKEY_verify(ctx,
+			op->rsa.sign.data, op->rsa.sign.length,
+			op->rsa.message.data, op->rsa.message.length);
+	if (ret < 0)
+		return -1;
+
+	if (ret == 0) {
+		OPENSSL_LOG(DEBUG, "RSA-PSS signature verification failed");
+		return 1;
+	}
+
+	return 0;
+}
+
+/**
+ * Verify an RSA signature using verify-recover, for deterministic
+ * padding schemes (PKCS#1 v1.5, no padding). Not applicable to PSS,
+ * since OpenSSL does not support recover-mode verification for PSS
+ * (RSA-PSS is a probabilistic scheme and cannot be undone to recover
+ * the original digest).
+ *
+ * A signature mismatch is a normal outcome, not a processing error, so
+ * it must not fail the enqueue operation. Note that EVP_PKEY_verify_recover()
+ * itself can return <= 0 for a mismatch too, e.g. when the signature does not
+ * decode to a validly padded value (OpenSSL then reports it as a hard
+ * "data too large for modulus"/padding error rather than a soft 0 return),
+ * so that case is treated the same as a successful-but-mismatching recover.
+ *
+ * @return 0 if the signature is valid, 1 if invalid/mismatched,
+ *         -1 on a setup/processing failure unrelated to the signature.
+ */
+static int
+openssl_rsa_verify_recover(EVP_PKEY_CTX *ctx, uint32_t pad,
+		struct rte_crypto_asym_op *op)
+{
+	uint8_t *tmp;
+	size_t outlen = 0;
+	int ret;
+
+	if (EVP_PKEY_verify_recover_init(ctx) <= 0)
+		return -1;
+
+	if (EVP_PKEY_CTX_set_rsa_padding(ctx, pad) <= 0)
+		return -1;
+
+	if (EVP_PKEY_verify_recover(ctx, NULL, &outlen,
+			op->rsa.sign.data,
+			op->rsa.sign.length) <= 0) {
+		OPENSSL_LOG(ERR, "RSA sign Verification failed");
+		return 1;
+	}
+
+	if ((outlen <= 0) || (outlen != op->rsa.sign.length)) {
+		OPENSSL_LOG(ERR, "RSA sign Verification failed");
+		return 1;
+	}
+
+	tmp = OPENSSL_malloc(outlen);
+	if (tmp == NULL) {
+		OPENSSL_LOG(ERR, "Memory allocation failed");
+		return -1;
+	}
+
+	ret = EVP_PKEY_verify_recover(ctx, tmp, &outlen,
+			op->rsa.sign.data,
+			op->rsa.sign.length);
+	if (ret <= 0) {
+		/*
+		 * A malformed/corrupted signature can make the underlying
+		 * RSA op itself fail (e.g. invalid padding), rather than
+		 * just returning a recovered value that fails to compare.
+		 * Both cases mean verification failed, not that processing
+		 * broke, so still let the op complete successfully.
+		 */
+		OPENSSL_free(tmp);
+		OPENSSL_LOG(ERR, "RSA sign Verification failed");
+		return 1;
+	}
+
+	OPENSSL_LOG(DEBUG,
+			"Length of public_decrypt %zu "
+			"length of message %zd",
+			outlen, op->rsa.message.length);
+	if (outlen != op->rsa.message.length ||
+			CRYPTO_memcmp(tmp, op->rsa.message.data,
+				op->rsa.message.length) != 0) {
+		OPENSSL_free(tmp);
+		OPENSSL_LOG(ERR, "RSA sign Verification failed");
+		return 1;
+	}
+	OPENSSL_free(tmp);
+
+	return 0;
+}
+
 /* process rsa operations */
 static int
 process_openssl_rsa_op_evp(struct rte_crypto_op *cop,
@@ -2334,7 +2544,6 @@ process_openssl_rsa_op_evp(struct rte_crypto_op *cop,
 {
 	struct rte_crypto_asym_op *op = cop->asym;
 	uint32_t pad = sess->u.r.pad;
-	uint8_t *tmp;
 	size_t outlen = 0;
 	int ret = -1;
 
@@ -2352,6 +2561,15 @@ process_openssl_rsa_op_evp(struct rte_crypto_op *cop,
 		return ret;
 	}
 
+	/* PSS is only valid for sign/verify */
+	if (sess->u.r.pad == RTE_CRYPTO_RSA_PADDING_PSS &&
+		op->rsa.op_type != RTE_CRYPTO_ASYM_OP_SIGN &&
+		op->rsa.op_type != RTE_CRYPTO_ASYM_OP_VERIFY) {
+		OPENSSL_LOG(ERR, "PSS supports sign/verify only");
+		cop->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
+		return ret;
+	}
+
 	switch (pad) {
 	case RTE_CRYPTO_RSA_PADDING_PKCS1_5:
 		pad = RSA_PKCS1_PADDING;
@@ -2362,6 +2580,9 @@ process_openssl_rsa_op_evp(struct rte_crypto_op *cop,
 	case RTE_CRYPTO_RSA_PADDING_OAEP:
 		pad = RSA_PKCS1_OAEP_PADDING;
 		break;
+	case RTE_CRYPTO_RSA_PADDING_PSS:
+		pad = RSA_PKCS1_PSS_PADDING;
+		break;
 	default:
 		cop->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
 		OPENSSL_LOG(ERR,
@@ -2426,70 +2647,55 @@ process_openssl_rsa_op_evp(struct rte_crypto_op *cop,
 		break;
 
 	case RTE_CRYPTO_ASYM_OP_SIGN:
-		if (EVP_PKEY_sign_init(rsa_ctx) <= 0)
-			goto err_rsa;
+		if (sess->u.r.pad == RTE_CRYPTO_RSA_PADDING_PSS) {
+			if (op->rsa.pss_salt.data != NULL) {
+				OPENSSL_LOG(ERR, "Explicit RSA-PSS salt is not supported");
+				cop->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
+				return ret;
+			}
+			if (openssl_rsa_pss_sign(pad, sess, op) < 0)
+				goto err_rsa;
+		} else {
+			if (EVP_PKEY_sign_init(rsa_ctx) <= 0)
+				goto err_rsa;
 
-		if (EVP_PKEY_CTX_set_rsa_padding(rsa_ctx, pad) <= 0)
-			goto err_rsa;
+			if (EVP_PKEY_CTX_set_rsa_padding(rsa_ctx, pad) <= 0)
+				goto err_rsa;
 
-		if (EVP_PKEY_sign(rsa_ctx, NULL, &outlen,
-				op->rsa.message.data,
-				op->rsa.message.length) <= 0)
-			goto err_rsa;
+			if (EVP_PKEY_sign(rsa_ctx, NULL, &outlen,
+					op->rsa.message.data,
+					op->rsa.message.length) <= 0)
+				goto err_rsa;
 
-		if (outlen <= 0)
-			goto err_rsa;
+			if (outlen <= 0)
+				goto err_rsa;
 
-		if (EVP_PKEY_sign(rsa_ctx, op->rsa.sign.data, &outlen,
-				op->rsa.message.data,
-				op->rsa.message.length) <= 0)
-			goto err_rsa;
-		op->rsa.sign.length = outlen;
+			if (EVP_PKEY_sign(rsa_ctx, op->rsa.sign.data, &outlen,
+					op->rsa.message.data,
+					op->rsa.message.length) <= 0)
+				goto err_rsa;
+			op->rsa.sign.length = outlen;
+		}
 		break;
 
 	case RTE_CRYPTO_ASYM_OP_VERIFY:
-		if (EVP_PKEY_verify_recover_init(rsa_ctx) <= 0)
-			goto err_rsa;
-
-		if (EVP_PKEY_CTX_set_rsa_padding(rsa_ctx, pad) <= 0)
-			goto err_rsa;
+		if (sess->u.r.pad == RTE_CRYPTO_RSA_PADDING_PSS)
+			ret = openssl_rsa_pss_verify(pad, sess, op);
+		else
+			ret = openssl_rsa_verify_recover(rsa_ctx, pad, op);
 
-		if (EVP_PKEY_verify_recover(rsa_ctx, NULL, &outlen,
-				op->rsa.sign.data,
-				op->rsa.sign.length) <= 0)
+		if (ret < 0)
 			goto err_rsa;
 
-		if ((outlen <= 0) || (outlen != op->rsa.sign.length))
-			goto err_rsa;
-
-		tmp = OPENSSL_malloc(outlen);
-		if (tmp == NULL) {
-			OPENSSL_LOG(ERR, "Memory allocation failed");
-			goto err_rsa;
-		}
-
-		ret = EVP_PKEY_verify_recover(rsa_ctx, tmp, &outlen,
-				op->rsa.sign.data,
-				op->rsa.sign.length);
-		if (ret <= 0) {
-			/* OpenSSL RSA verification returns one on
-			 * successful verification, otherwise 0. Hence,
-			 * this enqueue operation should succeed even if
-			 * invalid signature has been requested in verify.
-			 */
-			OPENSSL_free(tmp);
-			goto err_rsa;
-		}
-
-		OPENSSL_LOG(DEBUG,
-				"Length of public_decrypt %zu "
-				"length of message %zd",
-				outlen, op->rsa.message.length);
-		if (CRYPTO_memcmp(tmp, op->rsa.message.data,
-				op->rsa.message.length)) {
-			OPENSSL_LOG(ERR, "RSA sign Verification failed");
+		/*
+		 * ret == 1 means the signature did not verify; that is a
+		 * normal outcome, so the op still completes (with an error
+		 * status) instead of failing the enqueue itself.
+		 */
+		if (ret > 0) {
+			cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+			return 0;
 		}
-		OPENSSL_free(tmp);
 		break;
 
 	default:
diff --git a/drivers/crypto/openssl/rte_openssl_pmd_ops.c b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
index d2f699c266..d3718c28e4 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd_ops.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
@@ -740,9 +740,11 @@ static const struct rte_cryptodev_capabilities openssl_pmd_capabilities[] = {
 				.max = 0,
 				.increment = 1
 				},
+				/* pss_explicit_salt not supported, defaults to false */
 				.pad_types = ((1 << RTE_CRYPTO_RSA_PADDING_NONE) |
 					(1 << RTE_CRYPTO_RSA_PADDING_PKCS1_5) |
-					(1 << RTE_CRYPTO_RSA_PADDING_OAEP)),
+					(1 << RTE_CRYPTO_RSA_PADDING_OAEP) |
+					(1 << RTE_CRYPTO_RSA_PADDING_PSS)),
 				.mgf1_hash_algos = (RTE_BIT64(RTE_CRYPTO_AUTH_SHA1) |
 					RTE_BIT64(RTE_CRYPTO_AUTH_SHA224) |
 					RTE_BIT64(RTE_CRYPTO_AUTH_SHA256) |
@@ -1318,6 +1320,28 @@ static int openssl_set_asym_session_parameters(
 				asym_session->u.r.label_len = 0;
 				asym_session->u.r.label = NULL;
 			}
+		} else if (xform->rsa.padding.type == RTE_CRYPTO_RSA_PADDING_PSS) {
+			asym_session->u.r.pss_md = openssl_get_md(xform->rsa.padding.hash);
+
+			if (asym_session->u.r.pss_md == NULL) {
+				OPENSSL_LOG(ERR,
+					"Unsupported PSS hash algorithm %u",
+					xform->rsa.padding.hash);
+				goto err_rsa;
+			}
+
+			mgf1 = xform->rsa.padding.mgf1hash;
+			if (mgf1 == 0)
+				mgf1 = xform->rsa.padding.hash;
+
+			asym_session->u.r.pss_mgf1_md = openssl_get_md(mgf1);
+			if (asym_session->u.r.pss_mgf1_md == NULL) {
+				OPENSSL_LOG(ERR,
+					"Unsupported PSS MGF1 hash algorithm %u", mgf1);
+				goto err_rsa;
+			}
+
+			asym_session->u.r.pss_saltlen = xform->rsa.padding.pss_saltlen;
 		}
 
 		OSSL_PARAM_BLD * param_bld = OSSL_PARAM_BLD_new();
-- 
2.54.0

