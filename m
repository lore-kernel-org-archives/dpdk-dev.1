Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA707D1D47C
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 15:33:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC38B4066B;
	Thu,  8 Jan 2026 16:33:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 66B964027A
 for <dev@dpdk.org>; Thu,  8 Jan 2026 16:33:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767886417; x=1799422417;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2Yn4ZT3//qQ+7wD1wu3uO8q0UuV6Sl6ZJv9rV2RKhl8=;
 b=Mgip/ilFE0SVCo5lb/vK8edSXbGXMGuEdU7gIbzQ0WRKXP1oes45kJ1L
 ggROOmwDz/bWSMd0LCam3iVjmlvVutXFQ9PjwHTkw4Stsoknt4cKbpRwy
 0P4TDEfbeOjtC3cZxENjFPfU6gxLbWlLZgj3UvtVjO9TOhZVt0XsNdUeO
 RbG5WKZ00KerOC3IdOIAH0CBLRDHYYAFjIqqion+X8y7f0CjxCYzXd4zg
 0NK/Y6/w5zfmI96oL+mbiwoQobsKVNCtlUmnR6tFZzG3MOg1tm08U1zxL
 THYr6wLWy34SyxCH/yf/zK3qLgOvXrtMqIqJcJCTYI1BryFfCmgtHKpho A==;
X-CSE-ConnectionGUID: 1QEierSfQryuN2GyShs9sw==
X-CSE-MsgGUID: pyWbq4cjQ9CWTXLtBuKzxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="79906794"
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; d="scan'208";a="79906794"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2026 07:33:36 -0800
X-CSE-ConnectionGUID: hLefqifYSpurDj0Y8skhtQ==
X-CSE-MsgGUID: DL7+C1CwQB2QUMDhGi2Vgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; d="scan'208";a="203247019"
Received: from silpixa00401454.ir.intel.com ([10.20.224.230])
 by orviesa007.jf.intel.com with ESMTP; 08 Jan 2026 07:33:35 -0800
From: Emma Finn <emma.finn@intel.com>
To: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org,
	Emma Finn <emma.finn@intel.com>
Subject: [v2] crypto/openssl: Add support for SHAKE algorithms
Date: Thu,  8 Jan 2026 15:33:30 +0000
Message-ID: <20260108153330.2441799-1-emma.finn@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108143837.2412053-1-emma.finn@intel.com>
References: <20260108143837.2412053-1-emma.finn@intel.com>
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
---
 app/test/test_cryptodev_blockcipher.c        |  4 +-
 drivers/crypto/openssl/rte_openssl_pmd.c     | 30 ++++++++++++--
 drivers/crypto/openssl/rte_openssl_pmd_ops.c | 42 ++++++++++++++++++++
 3 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/app/test/test_cryptodev_blockcipher.c b/app/test/test_cryptodev_blockcipher.c
index 6b37347789..1438f24993 100644
--- a/app/test/test_cryptodev_blockcipher.c
+++ b/app/test/test_cryptodev_blockcipher.c
@@ -1174,7 +1174,9 @@ authonly_setup(void)
 		RTE_CRYPTO_AUTH_SHA512_HMAC,
 		RTE_CRYPTO_AUTH_AES_CMAC,
 		RTE_CRYPTO_AUTH_NULL,
-		RTE_CRYPTO_AUTH_AES_XCBC_MAC
+		RTE_CRYPTO_AUTH_AES_XCBC_MAC,
+		RTE_CRYPTO_AUTH_SHAKE_128,
+		RTE_CRYPTO_AUTH_SHAKE_256
 	};
 
 	rte_cryptodev_info_get(dev_id, &dev_info);
diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/openssl/rte_openssl_pmd.c
index 4f171f48cc..755674f71a 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c
@@ -270,6 +270,12 @@ get_auth_algo(enum rte_crypto_auth_algorithm sessalgo,
 		case RTE_CRYPTO_AUTH_SHA512_HMAC:
 			*algo = EVP_sha512();
 			break;
+		case RTE_CRYPTO_AUTH_SHAKE_128:
+			*algo = EVP_shake128();
+			break;
+		case RTE_CRYPTO_AUTH_SHAKE_256:
+			*algo = EVP_shake256();
+			break;
 		default:
 			res = -EINVAL;
 			break;
@@ -659,6 +665,8 @@ openssl_set_session_auth_parameters(struct openssl_session *sess,
 	case RTE_CRYPTO_AUTH_SHA256:
 	case RTE_CRYPTO_AUTH_SHA384:
 	case RTE_CRYPTO_AUTH_SHA512:
+	case RTE_CRYPTO_AUTH_SHAKE_128:
+	case RTE_CRYPTO_AUTH_SHAKE_256:
 		sess->auth.mode = OPENSSL_AUTH_AS_AUTH;
 		if (get_auth_algo(xform->auth.algo,
 				&sess->auth.auth.evp_algo) != 0)
@@ -1397,7 +1405,7 @@ process_openssl_auth_decryption_ccm(struct rte_mbuf *mbuf_src, int offset,
 static int
 process_openssl_auth(struct rte_mbuf *mbuf_src, uint8_t *dst, int offset,
 		__rte_unused uint8_t *iv, __rte_unused EVP_PKEY * pkey,
-		int srclen, EVP_MD_CTX *ctx, const EVP_MD *algo)
+		int srclen, EVP_MD_CTX *ctx, const EVP_MD *algo, int digest_length)
 {
 	size_t dstlen;
 	struct rte_mbuf *m;
@@ -1437,8 +1445,24 @@ process_openssl_auth(struct rte_mbuf *mbuf_src, uint8_t *dst, int offset,
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
@@ -1995,7 +2019,7 @@ process_openssl_auth_op(struct openssl_qp *qp, struct rte_crypto_op *op,
 		ctx_a = get_local_auth_ctx(sess, qp);
 		status = process_openssl_auth(mbuf_src, dst,
 				op->sym->auth.data.offset, NULL, NULL, srclen,
-				ctx_a, sess->auth.auth.evp_algo);
+				ctx_a, sess->auth.auth.evp_algo, sess->auth.digest_length);
 		break;
 	case OPENSSL_AUTH_AS_HMAC:
 		ctx_h = get_local_hmac_ctx(sess, qp);
diff --git a/drivers/crypto/openssl/rte_openssl_pmd_ops.c b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
index 5095e6cbea..f6c32fdcb6 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd_ops.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
@@ -269,6 +269,48 @@ static const struct rte_cryptodev_capabilities openssl_pmd_capabilities[] = {
 			}, }
 		}, }
 	},
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
 	{	/* AES CBC */
 		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
 		{.sym = {
-- 
2.43.0

