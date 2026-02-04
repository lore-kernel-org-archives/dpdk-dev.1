Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E7CE95372
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 10:05:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE7AC402EE;
	Wed,  4 Feb 2026 11:05:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id A5FF7402DE
 for <dev@dpdk.org>; Wed,  4 Feb 2026 11:05:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770199554; x=1801735554;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5w4MnG0fZX4y3EU7Fj1UoQEDDtjj0GxQJPAnKcvNpP8=;
 b=Dz3FHk+AOk8vVeGV89mVPFeQQaX+vWItH7A1ap8KSKhUV0fAWkoLt3Ii
 fT2FrMpEnAd7BQH/ya3L3x6c9XmJXKLYQ7XR8cE9qqfi5vXeP4okWL+80
 UyTPWLP9im77uUn47WxuaeW+hXY0/+MGjYeorIK/YLVJyQnJpEZ+buC0x
 Uxprqyr5CAg/RYHpYduWB95ZBNumQKtWk0RO6skDEK44K5onjuKDbM1xF
 Mt8F0MRW5HYnK5uX2XHPw7+uSkSTITZHa06SqL8+cQ6ig4wCFOPFSb8mj
 +tlLcu6r7zqGMrfI91Te93BQbIZVtVwOr120CFBMAWHC/cllcH1qd8Lqu Q==;
X-CSE-ConnectionGUID: kT+OYPYhRBaW3aAVsvgMdA==
X-CSE-MsgGUID: P4sNiXvFSJ+/xDU076aW3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71280926"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; d="scan'208";a="71280926"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2026 02:05:46 -0800
X-CSE-ConnectionGUID: AUl0gH1/SVWIw+jNwKI4kw==
X-CSE-MsgGUID: II9EgRXYTr+1AK+H/lGY/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; d="scan'208";a="214601380"
Received: from silpixa00401454.ir.intel.com ([10.20.224.230])
 by fmviesa005.fm.intel.com with ESMTP; 04 Feb 2026 02:05:44 -0800
From: Emma Finn <emma.finn@intel.com>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org,
	Emma Finn <emma.finn@intel.com>
Subject: [v2] crypto/openssl: Add support for SHA3 algorithms
Date: Wed,  4 Feb 2026 10:05:37 +0000
Message-ID: <20260204100538.346006-1-emma.finn@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129144242.4161225-1-emma.finn@intel.com>
References: <20260129144242.4161225-1-emma.finn@intel.com>
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

Add SHA3-224, SHA3-256, SHA3-384, and SHA3-512
support to the OpenSSL PMD, including both hash
and HMAC variants.

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
v2:
* Updated documentation
---
 doc/guides/cryptodevs/features/openssl.ini   |  10 +-
 doc/guides/cryptodevs/openssl.rst            |   8 +
 doc/guides/rel_notes/release_26_03.rst       |   4 +
 drivers/crypto/openssl/rte_openssl_pmd.c     |  36 ++++
 drivers/crypto/openssl/rte_openssl_pmd_ops.c | 168 +++++++++++++++++++
 5 files changed, 225 insertions(+), 1 deletion(-)

diff --git a/doc/guides/cryptodevs/features/openssl.ini b/doc/guides/cryptodevs/features/openssl.ini
index df6e7de316..82da0df22f 100644
--- a/doc/guides/cryptodevs/features/openssl.ini
+++ b/doc/guides/cryptodevs/features/openssl.ini
@@ -43,7 +43,15 @@ SHA384       = Y
 SHA384 HMAC  = Y
 SHA512       = Y
 SHA512 HMAC  = Y
-AES GMAC     = Y
+SHA3_224        = Y
+SHA3_224 HMAC   = Y
+SHA3_256        = Y
+SHA3_256 HMAC   = Y
+SHA3_384        = Y
+SHA3_384 HMAC   = Y
+SHA3_512        = Y
+SHA3_512 HMAC   = Y
+AES GMAC      = Y
 
 ;
 ; Supported AEAD algorithms of the 'openssl' crypto driver.
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
index a0f89b5ea2..d7c9352649 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -63,6 +63,10 @@ New Features
 
   * Added support for pre and post VF reset callbacks.
 
+* **Updated openssl crypto driver.**
+
+  * Added support for SHA3-224, SHA3-256, SHA3-384, and SHA3-512 hash algorithms
+    and their HMAC variants.
 
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

