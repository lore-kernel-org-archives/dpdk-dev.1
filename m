Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8285D2D8E4
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 10:12:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78F0A402CE;
	Tue, 27 Jan 2026 11:12:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 7C8AA400D6
 for <dev@dpdk.org>; Tue, 27 Jan 2026 11:12:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769508725; x=1801044725;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ISNvWvKQnCwCUGuS2G6rjvrUxe1gUtXS5MG6XkOLaPU=;
 b=P8AxjrxuEnGL/6eA0Rq+bLtdUxODv/GWjF67b5ewoKgSE1UbgriL62Fn
 qVY8mtKIa7imutZjcTRH8jJUF30B/GsYOvwZMUwOemYx259Cdy4l8PCGu
 Yr5j1RwzpiXEL0cc6fta9UMx5sTZSfh6CceUNbyM0wzkpsmgVoYXz6Lof
 O0Az8p4jsBjN1XJpqr786J/jLpR9DZhx4AXUyzYVjAHaSOPGaE6E24Yvv
 8w+YJlsoryKMeEhZRZY4ZSaFUdWkwVp6El+pSPJ/xO3rZrwgaIrD0Re+o
 Hls9XX8PHIwq1aACj+88sKDzB9afneMgmFkI963Kxuxmko/ZlXx6qPv5h Q==;
X-CSE-ConnectionGUID: wHktlUVuSVa4IbOAwbWzPg==
X-CSE-MsgGUID: PAc/jXU3Sme53FvK5LAryw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="73286545"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; d="scan'208";a="73286545"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2026 02:12:04 -0800
X-CSE-ConnectionGUID: oR5347ckSvmdu3z7oTWIIg==
X-CSE-MsgGUID: yWj5JL0HQ8+MtfbyvUKv9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; d="scan'208";a="212401308"
Received: from silpixa00401454.ir.intel.com ([10.20.224.230])
 by fmviesa005.fm.intel.com with ESMTP; 27 Jan 2026 02:12:03 -0800
From: Emma Finn <emma.finn@intel.com>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org,
	Emma Finn <emma.finn@intel.com>
Subject: [v2] crypto/openssl: Add support for SHA3 algorithms
Date: Tue, 27 Jan 2026 10:11:56 +0000
Message-ID: <20260127101156.3846106-1-emma.finn@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127100538.3844969-1-emma.finn@intel.com>
References: <20260127100538.3844969-1-emma.finn@intel.com>
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

Openssl has support for SHA3. Hence adding SHA3-224, SHA3-256,
SHA3-384 and SHA3-512 support to the PMD.

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
v2:
* Updated documentation
---
 doc/guides/cryptodevs/features/openssl.ini   |   8 +
 doc/guides/cryptodevs/openssl.rst            |   8 +
 doc/guides/rel_notes/release_26_03.rst       |   3 +
 drivers/crypto/openssl/rte_openssl_pmd.c     |  36 ++++
 drivers/crypto/openssl/rte_openssl_pmd_ops.c | 168 +++++++++++++++++++
 5 files changed, 223 insertions(+)

diff --git a/doc/guides/cryptodevs/features/openssl.ini b/doc/guides/cryptodevs/features/openssl.ini
index df6e7de316..08f7e0f82f 100644
--- a/doc/guides/cryptodevs/features/openssl.ini
+++ b/doc/guides/cryptodevs/features/openssl.ini
@@ -43,6 +43,14 @@ SHA384       = Y
 SHA384 HMAC  = Y
 SHA512       = Y
 SHA512 HMAC  = Y
+SHA3-224      = Y
+SHA3-224 HMAC = Y
+SHA3-256      = Y
+SHA3-256 HMAC = Y
+SHA3-384      = Y
+SHA3-384 HMAC = Y
+SHA3-512      = Y
+SHA3-512 HMAC = Y
 AES GMAC     = Y
 
 ;
diff --git a/doc/guides/cryptodevs/openssl.rst b/doc/guides/cryptodevs/openssl.rst
index d467069cac..0af609fddf 100644
--- a/doc/guides/cryptodevs/openssl.rst
+++ b/doc/guides/cryptodevs/openssl.rst
@@ -34,12 +34,20 @@ Supported authentication algorithms:
 * ``RTE_CRYPTO_AUTH_SHA256``
 * ``RTE_CRYPTO_AUTH_SHA384``
 * ``RTE_CRYPTO_AUTH_SHA512``
+* ``RTE_CRYPTO_AUTH_SHA3_224``
+* ``RTE_CRYPTO_AUTH_SHA3_256``
+* ``RTE_CRYPTO_AUTH_SHA3_384``
+* ``RTE_CRYPTO_AUTH_SHA3_512``
 * ``RTE_CRYPTO_AUTH_MD5_HMAC``
 * ``RTE_CRYPTO_AUTH_SHA1_HMAC``
 * ``RTE_CRYPTO_AUTH_SHA224_HMAC``
 * ``RTE_CRYPTO_AUTH_SHA256_HMAC``
 * ``RTE_CRYPTO_AUTH_SHA384_HMAC``
 * ``RTE_CRYPTO_AUTH_SHA512_HMAC``
+* ``RTE_CRYPTO_AUTH_SHA3_224_HMAC``
+* ``RTE_CRYPTO_AUTH_SHA3_256_HMAC``
+* ``RTE_CRYPTO_AUTH_SHA3_384_HMAC``
+* ``RTE_CRYPTO_AUTH_SHA3_512_HMAC``
 
 Supported AEAD algorithms:
 
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 15dabee7a1..e1a4e9d7a2 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -55,6 +55,9 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+   * **Updated openssl crypto driver.**
+
+     * Added support for SHA3-224/256/384/512 algorithms.
 
 Removed Items
 -------------
diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/openssl/rte_openssl_pmd.c
index 4f171f48cc..8817d7893c 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c
@@ -92,6 +92,14 @@ digest_name_get(enum rte_crypto_auth_algorithm algo)
 		return OSSL_DIGEST_NAME_SHA2_384;
 	case RTE_CRYPTO_AUTH_SHA512_HMAC:
 		return OSSL_DIGEST_NAME_SHA2_512;
+	case RTE_CRYPTO_AUTH_SHA3_224_HMAC:
+		return OSSL_DIGEST_NAME_SHA3_224;
+	case RTE_CRYPTO_AUTH_SHA3_256_HMAC:
+		return OSSL_DIGEST_NAME_SHA3_256;
+	case RTE_CRYPTO_AUTH_SHA3_384_HMAC:
+		return OSSL_DIGEST_NAME_SHA3_384;
+	case RTE_CRYPTO_AUTH_SHA3_512_HMAC:
+		return OSSL_DIGEST_NAME_SHA3_512;
 	default:
 		return NULL;
 	}
@@ -270,6 +278,22 @@ get_auth_algo(enum rte_crypto_auth_algorithm sessalgo,
 		case RTE_CRYPTO_AUTH_SHA512_HMAC:
 			*algo = EVP_sha512();
 			break;
+		case RTE_CRYPTO_AUTH_SHA3_224:
+		case RTE_CRYPTO_AUTH_SHA3_224_HMAC:
+			*algo = EVP_sha3_224();
+			break;
+		case RTE_CRYPTO_AUTH_SHA3_256:
+		case RTE_CRYPTO_AUTH_SHA3_256_HMAC:
+			*algo = EVP_sha3_256();
+			break;
+		case RTE_CRYPTO_AUTH_SHA3_384:
+		case RTE_CRYPTO_AUTH_SHA3_384_HMAC:
+			*algo = EVP_sha3_384();
+			break;
+		case RTE_CRYPTO_AUTH_SHA3_512:
+		case RTE_CRYPTO_AUTH_SHA3_512_HMAC:
+			*algo = EVP_sha3_512();
+			break;
 		default:
 			res = -EINVAL;
 			break;
@@ -659,6 +683,10 @@ openssl_set_session_auth_parameters(struct openssl_session *sess,
 	case RTE_CRYPTO_AUTH_SHA256:
 	case RTE_CRYPTO_AUTH_SHA384:
 	case RTE_CRYPTO_AUTH_SHA512:
+	case RTE_CRYPTO_AUTH_SHA3_224:
+	case RTE_CRYPTO_AUTH_SHA3_256:
+	case RTE_CRYPTO_AUTH_SHA3_384:
+	case RTE_CRYPTO_AUTH_SHA3_512:
 		sess->auth.mode = OPENSSL_AUTH_AS_AUTH;
 		if (get_auth_algo(xform->auth.algo,
 				&sess->auth.auth.evp_algo) != 0)
@@ -714,6 +742,10 @@ openssl_set_session_auth_parameters(struct openssl_session *sess,
 	case RTE_CRYPTO_AUTH_SHA256_HMAC:
 	case RTE_CRYPTO_AUTH_SHA384_HMAC:
 	case RTE_CRYPTO_AUTH_SHA512_HMAC:
+	case RTE_CRYPTO_AUTH_SHA3_224_HMAC:
+	case RTE_CRYPTO_AUTH_SHA3_256_HMAC:
+	case RTE_CRYPTO_AUTH_SHA3_384_HMAC:
+	case RTE_CRYPTO_AUTH_SHA3_512_HMAC:
 		sess->auth.mode = OPENSSL_AUTH_AS_HMAC;
 
 		algo = digest_name_get(xform->auth.algo);
@@ -744,6 +776,10 @@ openssl_set_session_auth_parameters(struct openssl_session *sess,
 	case RTE_CRYPTO_AUTH_SHA256_HMAC:
 	case RTE_CRYPTO_AUTH_SHA384_HMAC:
 	case RTE_CRYPTO_AUTH_SHA512_HMAC:
+	case RTE_CRYPTO_AUTH_SHA3_224_HMAC:
+	case RTE_CRYPTO_AUTH_SHA3_256_HMAC:
+	case RTE_CRYPTO_AUTH_SHA3_384_HMAC:
+	case RTE_CRYPTO_AUTH_SHA3_512_HMAC:
 		sess->auth.mode = OPENSSL_AUTH_AS_HMAC;
 		sess->auth.hmac.ctx = HMAC_CTX_new();
 		if (get_auth_algo(xform->auth.algo,
diff --git a/drivers/crypto/openssl/rte_openssl_pmd_ops.c b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
index 5095e6cbea..8d6ae346a8 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd_ops.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
@@ -269,6 +269,174 @@ static const struct rte_cryptodev_capabilities openssl_pmd_capabilities[] = {
 			}, }
 		}, }
 	},
+	{	/* SHA3_224 HMAC */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_SHA3_224_HMAC,
+				.block_size = 144,
+				.key_size = {
+					.min = 1,
+					.max = 144,
+					.increment = 1
+				},
+				.digest_size = {
+					.min = 1,
+					.max = 28,
+					.increment = 1
+				},
+				.iv_size = { 0 }
+			}, }
+		}, }
+	},
+	{	/* SHA3_224 */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_SHA3_224,
+				.block_size = 144,
+				.key_size = {
+					.min = 0,
+					.max = 0,
+					.increment = 0
+				},
+				.digest_size = {
+					.min = 28,
+					.max = 28,
+					.increment = 0
+				},
+				.iv_size = { 0 }
+			}, }
+		}, }
+	},
+	{	/* SHA3_256 HMAC */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_SHA3_256_HMAC,
+				.block_size = 136,
+				.key_size = {
+					.min = 1,
+					.max = 136,
+					.increment = 1
+				},
+				.digest_size = {
+					.min = 1,
+					.max = 32,
+					.increment = 1
+				},
+				.iv_size = { 0 }
+			}, }
+		}, }
+	},
+	{	/* SHA3_256 */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_SHA3_256,
+				.block_size = 136,
+				.key_size = {
+					.min = 0,
+					.max = 0,
+					.increment = 0
+				},
+				.digest_size = {
+					.min = 32,
+					.max = 32,
+					.increment = 0
+				},
+				.iv_size = { 0 }
+			}, }
+		}, }
+	},
+	{	/* SHA3_384 HMAC */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_SHA3_384_HMAC,
+				.block_size = 104,
+				.key_size = {
+					.min = 1,
+					.max = 104,
+					.increment = 1
+				},
+				.digest_size = {
+					.min = 1,
+					.max = 48,
+					.increment = 1
+				},
+				.iv_size = { 0 }
+			}, }
+		}, }
+	},
+	{	/* SHA3_384 */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_SHA3_384,
+				.block_size = 104,
+				.key_size = {
+					.min = 0,
+					.max = 0,
+					.increment = 0
+				},
+				.digest_size = {
+					.min = 48,
+					.max = 48,
+					.increment = 0
+				},
+				.iv_size = { 0 }
+			}, }
+		}, }
+	},
+	{	/* SHA3_512 HMAC */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_SHA3_512_HMAC,
+				.block_size = 72,
+				.key_size = {
+					.min = 1,
+					.max = 72,
+					.increment = 1
+				},
+				.digest_size = {
+					.min = 1,
+					.max = 64,
+					.increment = 1
+				},
+				.iv_size = { 0 }
+			}, }
+		}, }
+	},
+	{	/* SHA3_512 */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_SHA3_512,
+				.block_size = 72,
+				.key_size = {
+					.min = 0,
+					.max = 0,
+					.increment = 0
+				},
+				.digest_size = {
+					.min = 64,
+					.max = 64,
+					.increment = 0
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

