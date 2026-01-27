Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49C8D2D8E3
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 10:07:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 996BA402CE;
	Tue, 27 Jan 2026 11:07:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 0C55C406FF
 for <dev@dpdk.org>; Tue, 27 Jan 2026 11:07:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769508470; x=1801044470;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FN5DkfXH+XlxOSUwdLetU4SPclVLGCoXREHHkZ+Pmgg=;
 b=SW9wkQxLVH/hqkWJ8gHuf2xAr6CGrS/4ON9K7xY7/kZLxC49tTCjqtiN
 eYmPnqyLa/8LNusNmjsk2/KIsXqQ3VxJYWODWJWO4SPFy4oK9Zm5Eeqqo
 Ty/UCGD6HncxZltuORIK+Y44egV/ztRuU8Ykvb/Hh6A9NBpVBKssWzOL9
 p0LpN6+v10K0krz3XLjyBtYntal/zMnylzwFTjjZjOp4gDDiP7H0tWlqF
 4i3afWBT/ji+wQDN0WuP/JbLzeoMDqf5/bf7hVTsjTHmWQ4RXoymIz5XN
 iiiuvXIbopdS8AX6H4IE4iUNuw0Y3kLtb9xysm0D8gZ4oj1HakwegYN98 A==;
X-CSE-ConnectionGUID: eoXTQ7DTSMqYRRmTHGoPkA==
X-CSE-MsgGUID: TKkaAowjSbKg0okauJMrpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70602594"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; d="scan'208";a="70602594"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2026 02:07:49 -0800
X-CSE-ConnectionGUID: mCFNY4JMSKmyVFoOQ4d/ZQ==
X-CSE-MsgGUID: uSsHgOWJTcaPFrdi+B1yqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; d="scan'208";a="207993686"
Received: from silpixa00401454.ir.intel.com ([10.20.224.230])
 by orviesa007.jf.intel.com with ESMTP; 27 Jan 2026 02:07:46 -0800
From: Emma Finn <emma.finn@intel.com>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org,
	Emma Finn <emma.finn@intel.com>
Subject: [v3] crypto/openssl: Add support for SHAKE algorithms
Date: Tue, 27 Jan 2026 10:07:41 +0000
Message-ID: <20260127100741.3845554-1-emma.finn@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108153330.2441799-1-emma.finn@intel.com>
References: <20260108153330.2441799-1-emma.finn@intel.com>
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

OpenSSL 3.X has support for SHAKE, Hence adding
SHAKE-128 and SHAKE-256 support to the OpenSSL PMD.

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
v2:
* Fixed unused digest_length variable
v3:
* Updated documentation
---
 doc/guides/cryptodevs/features/openssl.ini   |  2 +
 doc/guides/cryptodevs/openssl.rst            |  2 +
 doc/guides/rel_notes/release_26_03.rst       |  4 ++
 drivers/crypto/openssl/rte_openssl_pmd.c     | 36 ++++++++++++++--
 drivers/crypto/openssl/rte_openssl_pmd_ops.c | 44 ++++++++++++++++++++
 5 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/doc/guides/cryptodevs/features/openssl.ini b/doc/guides/cryptodevs/features/openssl.ini
index df6e7de316..afe230bb9d 100644
--- a/doc/guides/cryptodevs/features/openssl.ini
+++ b/doc/guides/cryptodevs/features/openssl.ini
@@ -43,6 +43,8 @@ SHA384       = Y
 SHA384 HMAC  = Y
 SHA512       = Y
 SHA512 HMAC  = Y
+SHAKE_128    = Y
+SHAKE_256    = Y
 AES GMAC     = Y
 
 ;
diff --git a/doc/guides/cryptodevs/openssl.rst b/doc/guides/cryptodevs/openssl.rst
index d467069cac..c4eead5932 100644
--- a/doc/guides/cryptodevs/openssl.rst
+++ b/doc/guides/cryptodevs/openssl.rst
@@ -40,6 +40,8 @@ Supported authentication algorithms:
 * ``RTE_CRYPTO_AUTH_SHA256_HMAC``
 * ``RTE_CRYPTO_AUTH_SHA384_HMAC``
 * ``RTE_CRYPTO_AUTH_SHA512_HMAC``
+* ``RTE_CRYPTO_AUTH_SHAKE_128``
+* ``RTE_CRYPTO_AUTH_SHAKE_256``
 
 Supported AEAD algorithms:
 
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 15dabee7a1..6169f6b887 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -55,6 +55,10 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated openssl crypto driver.**
+
+  * Added support for SHAKE-128 and SHAKE-256 algorithms.
+
 
 Removed Items
 -------------
diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/openssl/rte_openssl_pmd.c
index 4f171f48cc..7316d7e957 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c
@@ -270,6 +270,14 @@ get_auth_algo(enum rte_crypto_auth_algorithm sessalgo,
 		case RTE_CRYPTO_AUTH_SHA512_HMAC:
 			*algo = EVP_sha512();
 			break;
+#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
+		case RTE_CRYPTO_AUTH_SHAKE_128:
+			*algo = EVP_shake128();
+			break;
+		case RTE_CRYPTO_AUTH_SHAKE_256:
+			*algo = EVP_shake256();
+			break;
+#endif
 		default:
 			res = -EINVAL;
 			break;
@@ -659,6 +667,10 @@ openssl_set_session_auth_parameters(struct openssl_session *sess,
 	case RTE_CRYPTO_AUTH_SHA256:
 	case RTE_CRYPTO_AUTH_SHA384:
 	case RTE_CRYPTO_AUTH_SHA512:
+#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
+	case RTE_CRYPTO_AUTH_SHAKE_128:
+	case RTE_CRYPTO_AUTH_SHAKE_256:
+#endif
 		sess->auth.mode = OPENSSL_AUTH_AS_AUTH;
 		if (get_auth_algo(xform->auth.algo,
 				&sess->auth.auth.evp_algo) != 0)
@@ -1397,7 +1409,7 @@ process_openssl_auth_decryption_ccm(struct rte_mbuf *mbuf_src, int offset,
 static int
 process_openssl_auth(struct rte_mbuf *mbuf_src, uint8_t *dst, int offset,
 		__rte_unused uint8_t *iv, __rte_unused EVP_PKEY * pkey,
-		int srclen, EVP_MD_CTX *ctx, const EVP_MD *algo)
+		int srclen, EVP_MD_CTX *ctx, const EVP_MD *algo, int digest_length)
 {
 	size_t dstlen;
 	struct rte_mbuf *m;
@@ -1437,8 +1449,24 @@ process_openssl_auth(struct rte_mbuf *mbuf_src, uint8_t *dst, int offset,
 	}
 
 process_auth_final:
-	if (EVP_DigestFinal_ex(ctx, dst, (unsigned int *)&dstlen) <= 0)
+	/* SHAKE algorithms are XOFs and require EVP_DigestFinalXOF */
+	if (algo == EVP_shake128() || algo == EVP_shake256()) {
+#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
+		/* Set XOF output length before calling EVP_DigestFinalXOF */
+		if (EVP_MD_CTX_ctrl(ctx, EVP_MD_CTRL_XOF_LEN, digest_length, NULL) <= 0)
+			goto process_auth_err;
+		if (EVP_DigestFinalXOF(ctx, dst, digest_length) <= 0)
+			goto process_auth_err;
+#else
+		RTE_SET_USED(digest_length);
+		OPENSSL_LOG(ERR, "SHAKE algorithms require OpenSSL 3.0+");
 		goto process_auth_err;
+#endif
+	} else {
+		if (EVP_DigestFinal_ex(ctx, dst, (unsigned int *)&dstlen) <= 0)
+			goto process_auth_err;
+	}
+
 	return 0;
 
 process_auth_err:
@@ -1995,7 +2023,7 @@ process_openssl_auth_op(struct openssl_qp *qp, struct rte_crypto_op *op,
 		ctx_a = get_local_auth_ctx(sess, qp);
 		status = process_openssl_auth(mbuf_src, dst,
 				op->sym->auth.data.offset, NULL, NULL, srclen,
-				ctx_a, sess->auth.auth.evp_algo);
+				ctx_a, sess->auth.auth.evp_algo, sess->auth.digest_length);
 		break;
 	case OPENSSL_AUTH_AS_HMAC:
 		ctx_h = get_local_hmac_ctx(sess, qp);
@@ -4008,12 +4036,14 @@ mldsa_sign_op_evp(struct rte_crypto_op *cop,
 	case RTE_CRYPTO_AUTH_SHA3_512:
 		check_md = EVP_sha3_512();
 		break;
+#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 	case RTE_CRYPTO_AUTH_SHAKE_128:
 		check_md = EVP_shake128();
 		break;
 	case RTE_CRYPTO_AUTH_SHAKE_256:
 		check_md = EVP_shake256();
 		break;
+#endif
 	default:
 		break;
 	}
diff --git a/drivers/crypto/openssl/rte_openssl_pmd_ops.c b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
index 5095e6cbea..5ad457ca53 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd_ops.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
@@ -269,6 +269,50 @@ static const struct rte_cryptodev_capabilities openssl_pmd_capabilities[] = {
 			}, }
 		}, }
 	},
+#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
+	{   /* SHAKE_128 */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_SHAKE_128,
+				.block_size = 168,
+				.key_size = {
+					.min = 0,
+					.max = 0,
+					.increment = 0
+				},
+				.digest_size = {
+					.min = 1,
+					.max = 256,
+					.increment = 1
+				},
+				.iv_size = { 0 }
+			}, }
+		}, }
+	},
+	{   /* SHAKE_256 */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_SHAKE_256,
+				.block_size = 136,
+				.key_size = {
+					.min = 0,
+					.max = 0,
+					.increment = 0
+				},
+				.digest_size = {
+					.min = 1,
+					.max = 256,
+					.increment = 1
+				},
+				.iv_size = { 0 }
+			}, }
+		}, }
+	},
+#endif
 	{	/* AES CBC */
 		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
 		{.sym = {
-- 
2.43.0

