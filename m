Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBB7EB1041
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 10:20:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A8FD4067E;
	Tue, 10 Mar 2026 11:20:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id C0B02402DC
 for <dev@dpdk.org>; Tue, 10 Mar 2026 11:20:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773138015; x=1804674015;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TXMcY+RhWh3iYDE6sSEDXfrUOAS+C+80bY8qsCizi1g=;
 b=GgO+jKtXRKyBdUIEJFqfwZJ2zCaFGbDwt1aGj3kBVYLDgGDNSK7GSm03
 4gQfJ3P55MYjKVdTg0abtasW9UgcGpV211Ymdykqod66aVLlKVSij2Ms4
 0aMzYmvmMM8RQmtyzeK9VdcF/agrjSld5UO1DUtcNzPOytTWnQvBUUp2A
 ES10NgwnEUyJC4IZQC9GQyapFIxk5W7Qmbs4+GLppHrSMcp0bvoNeWulY
 HtafvuTi+Jpkd1PS6uyG0druASqXtjbC656rjP/+mwT2dhplOIy1dXiBU
 j+vGlnggNQKhl8+J9gUeO+hx+M0K/7EiFM/qYQQJ2UWc7a+xHfyzu+Ivr g==;
X-CSE-ConnectionGUID: cuneRto2QByTCNddP/hHkg==
X-CSE-MsgGUID: 3hTHjfxZTV+O/BEb/evTgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="78033173"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="78033173"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 03:20:14 -0700
X-CSE-ConnectionGUID: jlg55Y5+SDCBBBl0ihgwcQ==
X-CSE-MsgGUID: sQGMa1t0RpubR5593ynJJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="220242734"
Received: from silpixa00401454.ir.intel.com ([10.20.224.230])
 by orviesa007.jf.intel.com with ESMTP; 10 Mar 2026 03:20:13 -0700
From: Emma Finn <emma.finn@intel.com>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org,
	gakhil@marvell.com,
	Emma Finn <emma.finn@intel.com>
Subject: [v4] crypto/openssl: Add support for SHA3 algorithms
Date: Tue, 10 Mar 2026 10:20:09 +0000
Message-ID: <20260310102010.1175294-1-emma.finn@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260211114735.2594969-1-emma.finn@intel.com>
References: <20260211114735.2594969-1-emma.finn@intel.com>
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
v3:
* rebase
v4:
* rebase
---
 doc/guides/cryptodevs/features/openssl.ini   |   8 +
 doc/guides/cryptodevs/openssl.rst            |   8 +
 doc/guides/rel_notes/release_26_03.rst       |   2 +
 drivers/crypto/openssl/rte_openssl_pmd.c     |  36 ++++
 drivers/crypto/openssl/rte_openssl_pmd_ops.c | 168 +++++++++++++++++++
 5 files changed, 222 insertions(+)

diff --git a/doc/guides/cryptodevs/features/openssl.ini b/doc/guides/cryptodevs/features/openssl.ini
index 536557e9e0..bcc0c39c2f 100644
--- a/doc/guides/cryptodevs/features/openssl.ini
+++ b/doc/guides/cryptodevs/features/openssl.ini
@@ -45,6 +45,14 @@ SHA384       = Y
 SHA384 HMAC  = Y
 SHA512       = Y
 SHA512 HMAC  = Y
+SHA3_224        = Y
+SHA3_224 HMAC   = Y
+SHA3_256        = Y
+SHA3_256 HMAC   = Y
+SHA3_384        = Y
+SHA3_384 HMAC   = Y
+SHA3_512        = Y
+SHA3_512 HMAC   = Y
 SHAKE_128    = Y
 SHAKE_256    = Y
 AES GMAC     = Y
diff --git a/doc/guides/cryptodevs/openssl.rst b/doc/guides/cryptodevs/openssl.rst
index 921592ba2d..9d94668a9a 100644
--- a/doc/guides/cryptodevs/openssl.rst
+++ b/doc/guides/cryptodevs/openssl.rst
@@ -35,12 +35,20 @@ Supported authentication algorithms:
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
 * ``RTE_CRYPTO_AUTH_SHAKE_128``
 * ``RTE_CRYPTO_AUTH_SHAKE_256``
 
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index b4499ec066..2c3a318dba 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -100,6 +100,8 @@ New Features
 
   * Added support for AES-XTS cipher algorithm.
   * Added support for SHAKE-128 and SHAKE-256 authentication algorithms.
+  * Added support for SHA3-224, SHA3-256, SHA3-384, and SHA3-512 hash algorithms
+    and their HMAC variants.
 
 * **Added Ctrl+L support to cmdline library.**
 
diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/openssl/rte_openssl_pmd.c
index e5fa1a4eeb..c34efb8ad0 100644
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
@@ -282,6 +290,22 @@ get_auth_algo(enum rte_crypto_auth_algorithm sessalgo,
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
 #if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 		case RTE_CRYPTO_AUTH_SHAKE_128:
 			*algo = EVP_shake128();
@@ -680,6 +704,10 @@ openssl_set_session_auth_parameters(struct openssl_session *sess,
 	case RTE_CRYPTO_AUTH_SHA256:
 	case RTE_CRYPTO_AUTH_SHA384:
 	case RTE_CRYPTO_AUTH_SHA512:
+	case RTE_CRYPTO_AUTH_SHA3_224:
+	case RTE_CRYPTO_AUTH_SHA3_256:
+	case RTE_CRYPTO_AUTH_SHA3_384:
+	case RTE_CRYPTO_AUTH_SHA3_512:
 #if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 	case RTE_CRYPTO_AUTH_SHAKE_128:
 	case RTE_CRYPTO_AUTH_SHAKE_256:
@@ -739,6 +767,10 @@ openssl_set_session_auth_parameters(struct openssl_session *sess,
 	case RTE_CRYPTO_AUTH_SHA256_HMAC:
 	case RTE_CRYPTO_AUTH_SHA384_HMAC:
 	case RTE_CRYPTO_AUTH_SHA512_HMAC:
+	case RTE_CRYPTO_AUTH_SHA3_224_HMAC:
+	case RTE_CRYPTO_AUTH_SHA3_256_HMAC:
+	case RTE_CRYPTO_AUTH_SHA3_384_HMAC:
+	case RTE_CRYPTO_AUTH_SHA3_512_HMAC:
 		sess->auth.mode = OPENSSL_AUTH_AS_HMAC;
 
 		algo = digest_name_get(xform->auth.algo);
@@ -769,6 +801,10 @@ openssl_set_session_auth_parameters(struct openssl_session *sess,
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
index 0f2b82ec00..6133622f1b 100644
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
 	{	/* AES XTS */
 		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
 		{.sym = {
-- 
2.43.0

