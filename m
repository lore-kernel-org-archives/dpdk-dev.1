Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E76CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 08:01:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AA1B4021F;
	Thu, 28 May 2026 10:01:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 9A9024014F
 for <dev@dpdk.org>; Thu, 28 May 2026 10:01:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779955262; x=1811491262;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nhSXBDHOzXmxUtR8B0EEBHd1HCo7T3cdBZyAf9An8Y8=;
 b=N3TGdn18gzJU9/Q+Rza72frKPgem1gvtV/IHn+rEWEjlehS84ytmjH1R
 e0+F+uklde33A6Dj+rp/X57QshOJvwNs6k7VhBJY5KRfzGFlLRm7x/njl
 JWT8KHSoGS9cH5Ga+tZ+/AhO215aOzfZl2QUukU+E6HX88Ms5kUXMyxSJ
 N1UhiDEesbp4rzyvcORftnC52r2M1FDW0uun64GK7Qz5MUjLsMG8Fi+2k
 ocpVnSKnITDBtWd6IVqphNBGTnxM2q2iRwwXwZW6/8W3O57HU44R91Bkp
 MGTo17s10GPY601iuyc3XGMVnGVwFOtXLPNnft6iCsW97ffcRFfxa+6R/ Q==;
X-CSE-ConnectionGUID: 4S6RXpk1QY20S5B6j8owng==
X-CSE-MsgGUID: 9BSQuvHESG+cL4GIqg6lUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80980394"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; d="scan'208";a="80980394"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 01:01:00 -0700
X-CSE-ConnectionGUID: SYLd4xiBQde4iqZpJAtuwA==
X-CSE-MsgGUID: R7YVhNg9SESAAbbzNFATmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; d="scan'208";a="246751522"
Received: from silpixa00401454.ir.intel.com ([10.20.224.230])
 by orviesa004.jf.intel.com with ESMTP; 28 May 2026 01:00:56 -0700
From: Emma Finn <emma.finn@intel.com>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org,
	Emma Finn <emma.finn@intel.com>
Subject: [v2] crypto/openssl: update to OpenSSL 3.0 minimum version
Date: Thu, 28 May 2026 08:00:52 +0000
Message-ID: <20260528080052.650061-1-emma.finn@intel.com>
X-Mailer: git-send-email 2.43.0
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

Update the OpenSSL PMD to require OpenSSL 3.0.0 as the minimum
supported version, removing all compatibility code for earlier
versions (1.0.1, 1.1.0, 1.1.1).

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
*v2: skip build if openssl v3.0 dependency is not met.
---
 doc/guides/cryptodevs/openssl.rst            |   4 +-
 doc/guides/rel_notes/release_26_07.rst       |   5 +
 drivers/crypto/openssl/compat.h              | 203 ------
 drivers/crypto/openssl/meson.build           |   4 +-
 drivers/crypto/openssl/openssl_pmd_private.h |  30 -
 drivers/crypto/openssl/rte_openssl_pmd.c     | 648 +------------------
 drivers/crypto/openssl/rte_openssl_pmd_ops.c | 206 ------
 7 files changed, 21 insertions(+), 1079 deletions(-)

diff --git a/doc/guides/cryptodevs/openssl.rst b/doc/guides/cryptodevs/openssl.rst
index 9d94668a9a..b4e2a014e2 100644
--- a/doc/guides/cryptodevs/openssl.rst
+++ b/doc/guides/cryptodevs/openssl.rst
@@ -74,9 +74,9 @@ To compile the OpenSSL PMD the openssl library must be installed. It will
 then be picked up by the Meson/Ninja build system.
 
 To ensure that you have the latest security fixes it is recommended that you
-use version 1.1.1g or newer.
+use the latest stable version of OpenSSL 3.x.
 
-* 1.1.1g, 2020-Apr-21. https://www.openssl.org/source/
+* OpenSSL 3.0.0 or newer: https://www.openssl.org/source/
 
 Initialization
 --------------
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 58d782f77e..989d54f7b7 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -90,6 +90,11 @@ Removed Items
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* crypto/openssl: Removed support for OpenSSL 1.x versions from the OpenSSL crypto PMD.
+
+  The OpenSSL crypto PMD now requires OpenSSL 3.0 as the minimum version,
+  and all compatibility code for OpenSSL 1.0.1, 1.1.0, and 1.1.1 versions has been removed.
+
 
 API Changes
 -----------
diff --git a/drivers/crypto/openssl/compat.h b/drivers/crypto/openssl/compat.h
index e1814fea8c..14104dbf2e 100644
--- a/drivers/crypto/openssl/compat.h
+++ b/drivers/crypto/openssl/compat.h
@@ -5,7 +5,6 @@
 #ifndef __RTA_COMPAT_H__
 #define __RTA_COMPAT_H__
 
-#if OPENSSL_VERSION_NUMBER >= 0x30000000L
 static __rte_always_inline void
 free_hmac_ctx(EVP_MAC_CTX *ctx)
 {
@@ -17,120 +16,7 @@ free_cmac_ctx(EVP_MAC_CTX *ctx)
 {
 	EVP_MAC_CTX_free(ctx);
 }
-#else
-static __rte_always_inline void
-free_hmac_ctx(HMAC_CTX *ctx)
-{
-	HMAC_CTX_free(ctx);
-}
-
-static __rte_always_inline void
-free_cmac_ctx(CMAC_CTX *ctx)
-{
-	CMAC_CTX_free(ctx);
-}
-#endif
-
-#if (OPENSSL_VERSION_NUMBER < 0x10100000L)
-
-static __rte_always_inline int
-set_rsa_params(RSA *rsa, BIGNUM *p, BIGNUM *q)
-{
-	rsa->p = p;
-	rsa->q = q;
-	return 0;
-}
-
-static __rte_always_inline int
-set_rsa_crt_params(RSA *rsa, BIGNUM *dmp1, BIGNUM *dmq1, BIGNUM *iqmp)
-{
-	rsa->dmp1 = dmp1;
-	rsa->dmq1 = dmq1;
-	rsa->iqmp = iqmp;
-	return 0;
-}
-
-static __rte_always_inline int
-set_rsa_keys(RSA *rsa, BIGNUM *n, BIGNUM *e, BIGNUM *d)
-{
-	rsa->n = n;
-	rsa->e = e;
-	rsa->d = d;
-	return 0;
-}
-
-static __rte_always_inline int
-set_dh_params(DH *dh, BIGNUM *p, BIGNUM *g)
-{
-	dh->p = p;
-	dh->q = NULL;
-	dh->g = g;
-	return 0;
-}
-
-static __rte_always_inline int
-set_dh_priv_key(DH *dh, BIGNUM *priv_key)
-{
-	dh->priv_key = priv_key;
-	return 0;
-}
-
-static __rte_always_inline int
-set_dsa_params(DSA *dsa, BIGNUM *p, BIGNUM *q, BIGNUM *g)
-{
-	dsa->p = p;
-	dsa->q = q;
-	dsa->g = g;
-	return 0;
-}
-
-static __rte_always_inline void
-get_dh_pub_key(DH *dh, const BIGNUM **pub_key)
-{
-	*pub_key = dh->pub_key;
-}
-
-static __rte_always_inline void
-get_dh_priv_key(DH *dh, const BIGNUM **priv_key)
-{
-	*priv_key = dh->priv_key;
-}
-
-static __rte_always_inline void
-set_dsa_sign(DSA_SIG *sign, BIGNUM *r, BIGNUM *s)
-{
-	sign->r = r;
-	sign->s = s;
-}
-
-static __rte_always_inline void
-get_dsa_sign(DSA_SIG *sign, const BIGNUM **r, const BIGNUM **s)
-{
-	*r = sign->r;
-	*s = sign->s;
-}
-
-static __rte_always_inline int
-set_dsa_keys(DSA *dsa, BIGNUM *pub, BIGNUM *priv)
-{
-	dsa->pub_key = pub;
-	dsa->priv_key = priv;
-	return 0;
-}
-
-static __rte_always_inline void
-set_dsa_pub_key(DSA *dsa, BIGNUM *pub)
-{
-	dsa->pub_key = pub;
-}
-
-static __rte_always_inline void
-get_dsa_priv_key(DSA *dsa, BIGNUM **priv_key)
-{
-	*priv_key = dsa->priv_key;
-}
 
-#elif (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 static __rte_always_inline void
 set_dsa_sign(DSA_SIG *sign, BIGNUM *r, BIGNUM *s)
 {
@@ -142,94 +28,5 @@ get_dsa_sign(DSA_SIG *sign, const BIGNUM **r, const BIGNUM **s)
 {
 	DSA_SIG_get0(sign, r, s);
 }
-#else
-
-static __rte_always_inline int
-set_rsa_params(RSA *rsa, BIGNUM *p, BIGNUM *q)
-{
-	return !(RSA_set0_factors(rsa, p, q));
-}
-
-static __rte_always_inline int
-set_rsa_crt_params(RSA *rsa, BIGNUM *dmp1, BIGNUM *dmq1, BIGNUM *iqmp)
-{
-	return !(RSA_set0_crt_params(rsa, dmp1, dmq1, iqmp));
-}
-
-/* n, e must be non-null, d can be NULL */
-
-static __rte_always_inline  int
-set_rsa_keys(RSA *rsa, BIGNUM *n, BIGNUM *e, BIGNUM *d)
-{
-	return !(RSA_set0_key(rsa, n, e, d));
-}
-
-static __rte_always_inline int
-set_dh_params(DH *dh, BIGNUM *p, BIGNUM *g)
-{
-	return !(DH_set0_pqg(dh, p, NULL, g));
-}
-
-static __rte_always_inline int
-set_dh_priv_key(DH *dh, BIGNUM *priv_key)
-{
-	return !(DH_set0_key(dh, NULL, priv_key));
-}
-
-static __rte_always_inline void
-get_dh_pub_key(DH *dh_key, const BIGNUM **pub_key)
-{
-	DH_get0_key(dh_key, pub_key, NULL);
-}
-
-static __rte_always_inline void
-get_dh_priv_key(DH *dh_key, const BIGNUM **priv_key)
-{
-	DH_get0_key(dh_key, NULL, priv_key);
-}
-
-static __rte_always_inline int
-set_dsa_params(DSA *dsa, BIGNUM *p, BIGNUM *q, BIGNUM *g)
-{
-	return !(DSA_set0_pqg(dsa, p, q, g));
-}
-
-static __rte_always_inline void
-set_dsa_priv_key(DSA *dsa, BIGNUM *priv_key)
-{
-	DSA_set0_key(dsa, NULL, priv_key);
-}
-
-static __rte_always_inline void
-set_dsa_sign(DSA_SIG *sign, BIGNUM *r, BIGNUM *s)
-{
-	DSA_SIG_set0(sign, r, s);
-}
-
-static __rte_always_inline void
-get_dsa_sign(DSA_SIG *sign, const BIGNUM **r, const BIGNUM **s)
-{
-	DSA_SIG_get0(sign, r, s);
-}
-
-static __rte_always_inline int
-set_dsa_keys(DSA *dsa, BIGNUM *pub, BIGNUM *priv)
-{
-	return !(DSA_set0_key(dsa, pub, priv));
-}
-
-static __rte_always_inline void
-set_dsa_pub_key(DSA *dsa, BIGNUM *pub_key)
-{
-	DSA_set0_key(dsa, pub_key, NULL);
-}
-
-static __rte_always_inline void
-get_dsa_priv_key(DSA *dsa, const BIGNUM **priv_key)
-{
-	DSA_get0_key(dsa, NULL, priv_key);
-}
-
-#endif /* version < 10100000 */
 
 #endif /* __RTA_COMPAT_H__ */
diff --git a/drivers/crypto/openssl/meson.build b/drivers/crypto/openssl/meson.build
index af469a9827..0d82c42764 100644
--- a/drivers/crypto/openssl/meson.build
+++ b/drivers/crypto/openssl/meson.build
@@ -7,10 +7,10 @@ if is_windows
     subdir_done()
 endif
 
-dep = dependency('libcrypto', required: false, method: 'pkg-config')
+dep = dependency('libcrypto', required: false, method: 'pkg-config', version: '>= 3.0.0')
 if not dep.found()
     build = false
-    reason = 'missing dependency, "libcrypto"'
+    reason = 'missing dependency, "libcrypto >= 3.0.0"'
 endif
 deps += 'bus_vdev'
 sources = files('rte_openssl_pmd.c', 'rte_openssl_pmd_ops.c')
diff --git a/drivers/crypto/openssl/openssl_pmd_private.h b/drivers/crypto/openssl/openssl_pmd_private.h
index d5a751600a..ab40012d61 100644
--- a/drivers/crypto/openssl/openssl_pmd_private.h
+++ b/drivers/crypto/openssl/openssl_pmd_private.h
@@ -13,10 +13,8 @@
 #include <openssl/dh.h>
 #include <openssl/dsa.h>
 #include <openssl/ec.h>
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 #include <openssl/provider.h>
 #include <openssl/core_names.h>
-#endif
 
 #define CRYPTODEV_NAME_OPENSSL_PMD	crypto_openssl
 /**< Open SSL Crypto PMD device name */
@@ -84,13 +82,8 @@ struct evp_ctx_pair {
 	EVP_CIPHER_CTX *cipher;
 	union {
 		EVP_MD_CTX *auth;
-#if OPENSSL_VERSION_NUMBER >= 0x30000000L
 		EVP_MAC_CTX *hmac;
 		EVP_MAC_CTX *cmac;
-#else
-		HMAC_CTX *hmac;
-		CMAC_CTX *cmac;
-#endif
 	};
 };
 
@@ -153,24 +146,13 @@ struct __rte_cache_aligned openssl_session {
 				/**< pointer to EVP key */
 				const EVP_MD *evp_algo;
 				/**< pointer to EVP algorithm function */
-# if OPENSSL_VERSION_NUMBER >= 0x30000000L
 				EVP_MAC_CTX * ctx;
-# else
-				HMAC_CTX *ctx;
-# endif
 				/**< pointer to EVP context structure */
 			} hmac;
 
 			struct {
-# if OPENSSL_VERSION_NUMBER >= 0x30000000L
 				EVP_MAC_CTX * ctx;
 				/**< pointer to EVP context structure */
-# else
-				const EVP_CIPHER * evp_algo;
-				/**< pointer to EVP algorithm function */
-				CMAC_CTX *ctx;
-				/**< pointer to EVP context structure */
-# endif
 			} cmac;
 		};
 
@@ -198,9 +180,7 @@ struct __rte_cache_aligned openssl_asym_session {
 		struct rsa {
 			RSA *rsa;
 			uint32_t pad;
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 			EVP_PKEY_CTX * ctx;
-#endif
 		} r;
 		struct exp {
 			BIGNUM *exp;
@@ -216,38 +196,28 @@ struct __rte_cache_aligned openssl_asym_session {
 			uint32_t key_op;
 			BIGNUM *p;
 			BIGNUM *g;
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 			OSSL_PARAM_BLD * param_bld;
 			OSSL_PARAM_BLD *param_bld_peer;
-#endif
 		} dh;
 		struct {
 			DSA *dsa;
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 			OSSL_PARAM_BLD * param_bld;
 			BIGNUM *p;
 			BIGNUM *g;
 			BIGNUM *q;
 			BIGNUM *priv_key;
-#endif
 		} s;
 		struct {
 			uint8_t curve_id;
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 			EC_GROUP * group;
 			BIGNUM *priv_key;
-#endif
 		} ec;
 		struct {
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 			OSSL_PARAM * params;
-#endif
 		} sm2;
 		struct {
 			uint8_t curve_id;
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 			OSSL_PARAM * params;
-#endif
 		} eddsa;
 		struct {
 			uint8_t type;
diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/openssl/rte_openssl_pmd.c
index c34efb8ad0..8748ef6195 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c
@@ -19,35 +19,14 @@
 #include "openssl_pmd_private.h"
 #include "compat.h"
 
-#define DES_BLOCK_SIZE 8
-
-static uint8_t cryptodev_driver_id;
-
-#if (OPENSSL_VERSION_NUMBER < 0x10100000L)
-static HMAC_CTX *HMAC_CTX_new(void)
-{
-	HMAC_CTX *ctx = OPENSSL_malloc(sizeof(*ctx));
-
-	if (ctx != NULL)
-		HMAC_CTX_init(ctx);
-	return ctx;
-}
-
-static void HMAC_CTX_free(HMAC_CTX *ctx)
-{
-	if (ctx != NULL) {
-		HMAC_CTX_cleanup(ctx);
-		OPENSSL_free(ctx);
-	}
-}
-#endif
-
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
-
 #include <openssl/provider.h>
 #include <openssl/core_names.h>
 #include <openssl/param_build.h>
 
+#define DES_BLOCK_SIZE 8
+
+static uint8_t cryptodev_driver_id;
+
 #define MAX_OSSL_ALGO_NAME_SIZE		16
 
 OSSL_PROVIDER *legacy;
@@ -104,7 +83,6 @@ digest_name_get(enum rte_crypto_auth_algorithm algo)
 		return NULL;
 	}
 }
-#endif
 
 static int cryptodev_openssl_remove(struct rte_vdev_device *vdev);
 
@@ -306,14 +284,12 @@ get_auth_algo(enum rte_crypto_auth_algorithm sessalgo,
 		case RTE_CRYPTO_AUTH_SHA3_512_HMAC:
 			*algo = EVP_sha3_512();
 			break;
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 		case RTE_CRYPTO_AUTH_SHAKE_128:
 			*algo = EVP_shake128();
 			break;
 		case RTE_CRYPTO_AUTH_SHAKE_256:
 			*algo = EVP_shake256();
 			break;
-#endif
 		default:
 			res = -EINVAL;
 			break;
@@ -659,12 +635,10 @@ static int
 openssl_set_session_auth_parameters(struct openssl_session *sess,
 		const struct rte_crypto_sym_xform *xform)
 {
-# if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 	char algo_name[MAX_OSSL_ALGO_NAME_SIZE];
 	OSSL_PARAM params[2];
 	const char *algo;
 	EVP_MAC *mac;
-# endif
 	/* Select auth generate/verify */
 	sess->auth.operation = xform->auth.op;
 	sess->auth.algo = xform->auth.algo;
@@ -708,10 +682,8 @@ openssl_set_session_auth_parameters(struct openssl_session *sess,
 	case RTE_CRYPTO_AUTH_SHA3_256:
 	case RTE_CRYPTO_AUTH_SHA3_384:
 	case RTE_CRYPTO_AUTH_SHA3_512:
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 	case RTE_CRYPTO_AUTH_SHAKE_128:
 	case RTE_CRYPTO_AUTH_SHAKE_256:
-#endif
 		sess->auth.mode = OPENSSL_AUTH_AS_AUTH;
 		if (get_auth_algo(xform->auth.algo,
 				&sess->auth.auth.evp_algo) != 0)
@@ -720,7 +692,6 @@ openssl_set_session_auth_parameters(struct openssl_session *sess,
 		break;
 
 	case RTE_CRYPTO_AUTH_AES_CMAC:
-# if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 		if (xform->auth.key.length == 16)
 			algo = SN_aes_128_cbc;
 		else if (xform->auth.key.length == 24)
@@ -745,22 +716,8 @@ openssl_set_session_auth_parameters(struct openssl_session *sess,
 				xform->auth.key.length,
 				params) != 1)
 			return -EINVAL;
-# else
-		sess->auth.mode = OPENSSL_AUTH_AS_CMAC;
-		sess->auth.cmac.ctx = CMAC_CTX_new();
-		if (get_cipher_algo(RTE_CRYPTO_CIPHER_AES_CBC,
-				    xform->auth.key.length,
-				    &sess->auth.cmac.evp_algo) != 0)
-			return -EINVAL;
-		if (CMAC_Init(sess->auth.cmac.ctx,
-			      xform->auth.key.data,
-			      xform->auth.key.length,
-			      sess->auth.cmac.evp_algo, NULL) != 1)
-			return -EINVAL;
-# endif
 		break;
 
-# if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 	case RTE_CRYPTO_AUTH_MD5_HMAC:
 	case RTE_CRYPTO_AUTH_SHA1_HMAC:
 	case RTE_CRYPTO_AUTH_SHA224_HMAC:
@@ -794,30 +751,6 @@ openssl_set_session_auth_parameters(struct openssl_session *sess,
 				params) != 1)
 			return -EINVAL;
 		break;
-# else
-	case RTE_CRYPTO_AUTH_MD5_HMAC:
-	case RTE_CRYPTO_AUTH_SHA1_HMAC:
-	case RTE_CRYPTO_AUTH_SHA224_HMAC:
-	case RTE_CRYPTO_AUTH_SHA256_HMAC:
-	case RTE_CRYPTO_AUTH_SHA384_HMAC:
-	case RTE_CRYPTO_AUTH_SHA512_HMAC:
-	case RTE_CRYPTO_AUTH_SHA3_224_HMAC:
-	case RTE_CRYPTO_AUTH_SHA3_256_HMAC:
-	case RTE_CRYPTO_AUTH_SHA3_384_HMAC:
-	case RTE_CRYPTO_AUTH_SHA3_512_HMAC:
-		sess->auth.mode = OPENSSL_AUTH_AS_HMAC;
-		sess->auth.hmac.ctx = HMAC_CTX_new();
-		if (get_auth_algo(xform->auth.algo,
-				&sess->auth.hmac.evp_algo) != 0)
-			return -EINVAL;
-
-		if (HMAC_Init_ex(sess->auth.hmac.ctx,
-				xform->auth.key.data,
-				xform->auth.key.length,
-				sess->auth.hmac.evp_algo, NULL) != 1)
-			return -EINVAL;
-		break;
-# endif
 	default:
 		return -ENOTSUP;
 	}
@@ -1295,10 +1228,6 @@ process_openssl_auth_encryption_gcm(struct rte_mbuf *mbuf_src, int offset,
 		uint8_t *dst, uint8_t *tag, EVP_CIPHER_CTX *ctx)
 {
 	int len = 0;
-#if OPENSSL_VERSION_NUMBER < 0x10100000L
-	int unused = 0;
-	uint8_t empty[] = {};
-#endif
 
 	if (EVP_EncryptInit_ex(ctx, NULL, NULL, NULL, iv) <= 0)
 		goto process_auth_encryption_gcm_err;
@@ -1312,12 +1241,6 @@ process_openssl_auth_encryption_gcm(struct rte_mbuf *mbuf_src, int offset,
 				srclen, ctx, 0))
 			goto process_auth_encryption_gcm_err;
 
-#if OPENSSL_VERSION_NUMBER < 0x10100000L
-	/* Workaround open ssl bug in version less then 1.0.1f */
-	if (EVP_EncryptUpdate(ctx, empty, &unused, empty, 0) <= 0)
-		goto process_auth_encryption_gcm_err;
-#endif
-
 	if (EVP_EncryptFinal_ex(ctx, dst, &len) <= 0)
 		goto process_auth_encryption_gcm_err;
 
@@ -1379,10 +1302,6 @@ process_openssl_auth_decryption_gcm(struct rte_mbuf *mbuf_src, int offset,
 		uint8_t *dst, uint8_t *tag, EVP_CIPHER_CTX *ctx)
 {
 	int len = 0;
-#if OPENSSL_VERSION_NUMBER < 0x10100000L
-	int unused = 0;
-	uint8_t empty[] = {};
-#endif
 
 	if (EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_GCM_SET_TAG, 16, tag) <= 0)
 		goto process_auth_decryption_gcm_err;
@@ -1399,12 +1318,6 @@ process_openssl_auth_decryption_gcm(struct rte_mbuf *mbuf_src, int offset,
 				srclen, ctx, 0))
 			goto process_auth_decryption_gcm_err;
 
-#if OPENSSL_VERSION_NUMBER < 0x10100000L
-	/* Workaround open ssl bug in version less then 1.0.1f */
-	if (EVP_DecryptUpdate(ctx, empty, &unused, empty, 0) <= 0)
-		goto process_auth_decryption_gcm_err;
-#endif
-
 	if (EVP_DecryptFinal_ex(ctx, dst, &len) <= 0)
 		return -EFAULT;
 
@@ -1500,17 +1413,11 @@ process_openssl_auth(struct rte_mbuf *mbuf_src, uint8_t *dst, int offset,
 process_auth_final:
 	/* SHAKE algorithms are XOFs and require EVP_DigestFinalXOF */
 	if (algo == EVP_shake128() || algo == EVP_shake256()) {
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 		/* Set XOF output length before calling EVP_DigestFinalXOF */
 		if (EVP_MD_CTX_ctrl(ctx, EVP_MD_CTRL_XOF_LEN, digest_length, NULL) <= 0)
 			goto process_auth_err;
 		if (EVP_DigestFinalXOF(ctx, dst, digest_length) <= 0)
 			goto process_auth_err;
-#else
-		RTE_SET_USED(digest_length);
-		OPENSSL_LOG(ERR, "SHAKE algorithms require OpenSSL 3.0+");
-		goto process_auth_err;
-#endif
 	} else {
 		if (EVP_DigestFinal_ex(ctx, dst, (unsigned int *)&dstlen) <= 0)
 			goto process_auth_err;
@@ -1523,7 +1430,6 @@ process_openssl_auth(struct rte_mbuf *mbuf_src, uint8_t *dst, int offset,
 	return -EINVAL;
 }
 
-# if OPENSSL_VERSION_NUMBER >= 0x30000000L
 /** Process standard openssl auth algorithms with hmac/cmac */
 static int
 process_openssl_auth_mac(struct rte_mbuf *mbuf_src, uint8_t *dst, int offset,
@@ -1576,109 +1482,6 @@ process_openssl_auth_mac(struct rte_mbuf *mbuf_src, uint8_t *dst, int offset,
 	OPENSSL_LOG(ERR, "Process openssl auth failed");
 	return -EINVAL;
 }
-# else
-/** Process standard openssl auth algorithms with hmac */
-static int
-process_openssl_auth_hmac(struct rte_mbuf *mbuf_src, uint8_t *dst, int offset,
-		int srclen, HMAC_CTX *ctx)
-{
-	unsigned int dstlen;
-	struct rte_mbuf *m;
-	int l, n = srclen;
-	uint8_t *src;
-
-	for (m = mbuf_src; m != NULL && offset > rte_pktmbuf_data_len(m);
-			m = m->next)
-		offset -= rte_pktmbuf_data_len(m);
-
-	if (m == 0)
-		goto process_auth_err;
-
-	src = rte_pktmbuf_mtod_offset(m, uint8_t *, offset);
-
-	l = rte_pktmbuf_data_len(m) - offset;
-	if (srclen <= l) {
-		if (HMAC_Update(ctx, (unsigned char *)src, srclen) != 1)
-			goto process_auth_err;
-		goto process_auth_final;
-	}
-
-	if (HMAC_Update(ctx, (unsigned char *)src, l) != 1)
-		goto process_auth_err;
-
-	n -= l;
-
-	for (m = m->next; (m != NULL) && (n > 0); m = m->next) {
-		src = rte_pktmbuf_mtod(m, uint8_t *);
-		l = rte_pktmbuf_data_len(m) < n ? rte_pktmbuf_data_len(m) : n;
-		if (HMAC_Update(ctx, (unsigned char *)src, l) != 1)
-			goto process_auth_err;
-		n -= l;
-	}
-
-process_auth_final:
-	if (HMAC_Final(ctx, dst, &dstlen) != 1)
-		goto process_auth_err;
-
-	if (unlikely(HMAC_Init_ex(ctx, NULL, 0, NULL, NULL) != 1))
-		goto process_auth_err;
-
-	return 0;
-
-process_auth_err:
-	OPENSSL_LOG(ERR, "Process openssl auth failed");
-	return -EINVAL;
-}
-
-/** Process standard openssl auth algorithms with cmac */
-static int
-process_openssl_auth_cmac(struct rte_mbuf *mbuf_src, uint8_t *dst, int offset,
-		int srclen, CMAC_CTX *ctx)
-{
-	unsigned int dstlen;
-	struct rte_mbuf *m;
-	int l, n = srclen;
-	uint8_t *src;
-
-	for (m = mbuf_src; m != NULL && offset > rte_pktmbuf_data_len(m);
-			m = m->next)
-		offset -= rte_pktmbuf_data_len(m);
-
-	if (m == 0)
-		goto process_auth_err;
-
-	src = rte_pktmbuf_mtod_offset(m, uint8_t *, offset);
-
-	l = rte_pktmbuf_data_len(m) - offset;
-	if (srclen <= l) {
-		if (CMAC_Update(ctx, (unsigned char *)src, srclen) != 1)
-			goto process_auth_err;
-		goto process_auth_final;
-	}
-
-	if (CMAC_Update(ctx, (unsigned char *)src, l) != 1)
-		goto process_auth_err;
-
-	n -= l;
-
-	for (m = m->next; (m != NULL) && (n > 0); m = m->next) {
-		src = rte_pktmbuf_mtod(m, uint8_t *);
-		l = rte_pktmbuf_data_len(m) < n ? rte_pktmbuf_data_len(m) : n;
-		if (CMAC_Update(ctx, (unsigned char *)src, l) != 1)
-			goto process_auth_err;
-		n -= l;
-	}
-
-process_auth_final:
-	if (CMAC_Final(ctx, dst, (size_t *)&dstlen) != 1)
-		goto process_auth_err;
-	return 0;
-
-process_auth_err:
-	OPENSSL_LOG(ERR, "Process openssl cmac auth failed");
-	return -EINVAL;
-}
-# endif
 /*----------------------------------------------------------------------------*/
 
 static inline EVP_CIPHER_CTX *
@@ -1695,7 +1498,7 @@ get_local_cipher_ctx(struct openssl_session *sess, struct openssl_qp *qp)
 		/* EVP_CIPHER_CTX_dup() added in OSSL 3.2 */
 		*lctx = EVP_CIPHER_CTX_dup(sess->cipher.ctx);
 		return *lctx;
-#elif OPENSSL_VERSION_NUMBER >= 0x30000000L
+#else
 		if (sess->chain_order == OPENSSL_CHAIN_COMBINED) {
 			/* AESNI special-cased to use openssl_aesni_ctx_clone()
 			 * to allow for working around lack of
@@ -1706,10 +1509,10 @@ get_local_cipher_ctx(struct openssl_session *sess, struct openssl_qp *qp)
 				*lctx = NULL;
 			return *lctx;
 		}
-#endif
 
 		*lctx = EVP_CIPHER_CTX_new();
 		EVP_CIPHER_CTX_copy(*lctx, sess->cipher.ctx);
+#endif
 	}
 
 	return *lctx;
@@ -1737,11 +1540,7 @@ get_local_auth_ctx(struct openssl_session *sess, struct openssl_qp *qp)
 	return *lctx;
 }
 
-#if OPENSSL_VERSION_NUMBER >= 0x30000000L
 static inline EVP_MAC_CTX *
-#else
-static inline HMAC_CTX *
-#endif
 get_local_hmac_ctx(struct openssl_session *sess, struct openssl_qp *qp)
 {
 #if (OPENSSL_VERSION_NUMBER >= 0x30000000L && OPENSSL_VERSION_NUMBER < 0x30003000L)
@@ -1759,31 +1558,16 @@ get_local_hmac_ctx(struct openssl_session *sess, struct openssl_qp *qp)
 	if (sess->ctx_copies_len == 0)
 		return sess->auth.hmac.ctx;
 
-#if OPENSSL_VERSION_NUMBER >= 0x30000000L
-	EVP_MAC_CTX **lctx =
-#else
-	HMAC_CTX **lctx =
-#endif
-		&sess->qp_ctx[qp->id].hmac;
+	EVP_MAC_CTX **lctx = &sess->qp_ctx[qp->id].hmac;
 
-	if (unlikely(*lctx == NULL)) {
-#if OPENSSL_VERSION_NUMBER >= 0x30000000L
+	if (unlikely(*lctx == NULL))
 		*lctx = EVP_MAC_CTX_dup(sess->auth.hmac.ctx);
-#else
-		*lctx = HMAC_CTX_new();
-		HMAC_CTX_copy(*lctx, sess->auth.hmac.ctx);
-#endif
-	}
 
 	return *lctx;
 #endif
 }
 
-#if OPENSSL_VERSION_NUMBER >= 0x30000000L
 static inline EVP_MAC_CTX *
-#else
-static inline CMAC_CTX *
-#endif
 get_local_cmac_ctx(struct openssl_session *sess, struct openssl_qp *qp)
 {
 #if (OPENSSL_VERSION_NUMBER >= 0x30000000L && OPENSSL_VERSION_NUMBER < 0x30003000L)
@@ -1801,21 +1585,10 @@ get_local_cmac_ctx(struct openssl_session *sess, struct openssl_qp *qp)
 	if (sess->ctx_copies_len == 0)
 		return sess->auth.cmac.ctx;
 
-#if OPENSSL_VERSION_NUMBER >= 0x30000000L
-	EVP_MAC_CTX **lctx =
-#else
-	CMAC_CTX **lctx =
-#endif
-		&sess->qp_ctx[qp->id].cmac;
+	EVP_MAC_CTX **lctx = &sess->qp_ctx[qp->id].cmac;
 
-	if (unlikely(*lctx == NULL)) {
-#if OPENSSL_VERSION_NUMBER >= 0x30000000L
+	if (unlikely(*lctx == NULL))
 		*lctx = EVP_MAC_CTX_dup(sess->auth.cmac.ctx);
-#else
-		*lctx = CMAC_CTX_new();
-		CMAC_CTX_copy(*lctx, sess->auth.cmac.ctx);
-#endif
-	}
 
 	return *lctx;
 #endif
@@ -2055,13 +1828,8 @@ process_openssl_auth_op(struct openssl_qp *qp, struct rte_crypto_op *op,
 	uint8_t *dst;
 	int srclen, status;
 	EVP_MD_CTX *ctx_a;
-# if OPENSSL_VERSION_NUMBER >= 0x30000000L
 	EVP_MAC_CTX *ctx_h;
 	EVP_MAC_CTX *ctx_c;
-# else
-	HMAC_CTX *ctx_h;
-	CMAC_CTX *ctx_c;
-# endif
 
 	srclen = op->sym->auth.data.length;
 
@@ -2076,30 +1844,18 @@ process_openssl_auth_op(struct openssl_qp *qp, struct rte_crypto_op *op,
 		break;
 	case OPENSSL_AUTH_AS_HMAC:
 		ctx_h = get_local_hmac_ctx(sess, qp);
-# if OPENSSL_VERSION_NUMBER >= 0x30000000L
 		status = process_openssl_auth_mac(mbuf_src, dst,
 				op->sym->auth.data.offset, srclen,
 				ctx_h);
-# else
-		status = process_openssl_auth_hmac(mbuf_src, dst,
-				op->sym->auth.data.offset, srclen,
-				ctx_h);
-# endif
 #if (OPENSSL_VERSION_NUMBER >= 0x30000000L && OPENSSL_VERSION_NUMBER < 0x30003000L)
 		EVP_MAC_CTX_free(ctx_h);
 #endif
 		break;
 	case OPENSSL_AUTH_AS_CMAC:
 		ctx_c = get_local_cmac_ctx(sess, qp);
-# if OPENSSL_VERSION_NUMBER >= 0x30000000L
 		status = process_openssl_auth_mac(mbuf_src, dst,
 				op->sym->auth.data.offset, srclen,
 				ctx_c);
-# else
-		status = process_openssl_auth_cmac(mbuf_src, dst,
-				op->sym->auth.data.offset, srclen,
-				ctx_c);
-# endif
 #if (OPENSSL_VERSION_NUMBER >= 0x30000000L && OPENSSL_VERSION_NUMBER < 0x30003000L)
 		EVP_MAC_CTX_free(ctx_c);
 #endif
@@ -2130,7 +1886,6 @@ process_openssl_auth_op(struct openssl_qp *qp, struct rte_crypto_op *op,
 }
 
 /* process dsa sign operation */
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 static int
 process_openssl_dsa_sign_op_evp(struct rte_crypto_op *cop,
 		struct openssl_asym_session *sess)
@@ -2296,92 +2051,8 @@ process_openssl_dsa_verify_op_evp(struct rte_crypto_op *cop,
 
 	return ret;
 }
-#else
-static int
-process_openssl_dsa_sign_op(struct rte_crypto_op *cop,
-		struct openssl_asym_session *sess)
-{
-	struct rte_crypto_dsa_op_param *op = &cop->asym->dsa;
-	DSA *dsa = sess->u.s.dsa;
-	DSA_SIG *sign = NULL;
-
-	sign = DSA_do_sign(op->message.data,
-			op->message.length,
-			dsa);
-
-	if (sign == NULL) {
-		OPENSSL_LOG(ERR, "%s:%d", __func__, __LINE__);
-		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-	} else {
-		const BIGNUM *r = NULL, *s = NULL;
-		get_dsa_sign(sign, &r, &s);
-
-		op->r.length = BN_bn2bin(r, op->r.data);
-		op->s.length = BN_bn2bin(s, op->s.data);
-		cop->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
-	}
-
-	DSA_SIG_free(sign);
-
-	return 0;
-}
-
-/* process dsa verify operation */
-static int
-process_openssl_dsa_verify_op(struct rte_crypto_op *cop,
-		struct openssl_asym_session *sess)
-{
-	struct rte_crypto_dsa_op_param *op = &cop->asym->dsa;
-	DSA *dsa = sess->u.s.dsa;
-	int ret;
-	DSA_SIG *sign = DSA_SIG_new();
-	BIGNUM *r = NULL, *s = NULL;
-	BIGNUM *pub_key = NULL;
-
-	if (sign == NULL) {
-		OPENSSL_LOG(ERR, " %s:%d", __func__, __LINE__);
-		cop->status = RTE_CRYPTO_OP_STATUS_NOT_PROCESSED;
-		return -1;
-	}
-
-	r = BN_bin2bn(op->r.data,
-			op->r.length,
-			r);
-	s = BN_bin2bn(op->s.data,
-			op->s.length,
-			s);
-	pub_key = BN_bin2bn(op->y.data,
-			op->y.length,
-			pub_key);
-	if (!r || !s || !pub_key) {
-		BN_free(r);
-		BN_free(s);
-		BN_free(pub_key);
-
-		cop->status = RTE_CRYPTO_OP_STATUS_NOT_PROCESSED;
-		return -1;
-	}
-	set_dsa_sign(sign, r, s);
-	set_dsa_pub_key(dsa, pub_key);
-
-	ret = DSA_do_verify(op->message.data,
-			op->message.length,
-			sign,
-			dsa);
-
-	if (ret != 1)
-		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-	else
-		cop->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
-
-	DSA_SIG_free(sign);
-
-	return 0;
-}
-#endif
 
 /* process dh operation */
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 static int
 process_openssl_dh_op_evp(struct rte_crypto_op *cop,
 		struct openssl_asym_session *sess)
@@ -2555,141 +2226,6 @@ process_openssl_dh_op_evp(struct rte_crypto_op *cop,
 
 	return ret;
 }
-#else
-static int
-process_openssl_dh_op(struct rte_crypto_op *cop,
-		struct openssl_asym_session *sess)
-{
-	struct rte_crypto_dh_op_param *op = &cop->asym->dh;
-	struct rte_crypto_asym_op *asym_op = cop->asym;
-	DH *dh_key = sess->u.dh.dh_key;
-	BIGNUM *priv_key = NULL;
-	int ret = 0;
-
-	if (asym_op->dh.ke_type == RTE_CRYPTO_ASYM_KE_SHARED_SECRET_COMPUTE) {
-		/* compute shared secret using peer public key
-		 * and current private key
-		 * shared secret = peer_key ^ priv_key mod p
-		 */
-		BIGNUM *peer_key = NULL;
-
-		/* copy private key and peer key and compute shared secret */
-		peer_key = BN_bin2bn(op->pub_key.data,
-				op->pub_key.length,
-				peer_key);
-		if (peer_key == NULL) {
-			cop->status = RTE_CRYPTO_OP_STATUS_NOT_PROCESSED;
-			return -1;
-		}
-		priv_key = BN_bin2bn(op->priv_key.data,
-				op->priv_key.length,
-				priv_key);
-		if (priv_key == NULL) {
-			BN_free(peer_key);
-			cop->status = RTE_CRYPTO_OP_STATUS_NOT_PROCESSED;
-			return -1;
-		}
-		ret = set_dh_priv_key(dh_key, priv_key);
-		if (ret) {
-			OPENSSL_LOG(ERR, "Failed to set private key");
-			cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-			BN_free(peer_key);
-			BN_free(priv_key);
-			return 0;
-		}
-
-		ret = DH_compute_key(
-				op->shared_secret.data,
-				peer_key, dh_key);
-		if (ret < 0) {
-			cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-			BN_free(peer_key);
-			/* priv key is already loaded into dh,
-			 * let's not free that directly here.
-			 * DH_free() will auto free it later.
-			 */
-			return 0;
-		}
-		cop->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
-		op->shared_secret.length = ret;
-		BN_free(peer_key);
-		return 0;
-	}
-
-	/*
-	 * other options are public and private key generations.
-	 *
-	 * if user provides private key,
-	 * then first set DH with user provided private key
-	 */
-	if (asym_op->dh.ke_type == RTE_CRYPTO_ASYM_KE_PUB_KEY_GENERATE &&
-			op->priv_key.length) {
-		/* generate public key using user-provided private key
-		 * pub_key = g ^ priv_key mod p
-		 */
-
-		/* load private key into DH */
-		priv_key = BN_bin2bn(op->priv_key.data,
-				op->priv_key.length,
-				priv_key);
-		if (priv_key == NULL) {
-			cop->status = RTE_CRYPTO_OP_STATUS_NOT_PROCESSED;
-			return -1;
-		}
-		ret = set_dh_priv_key(dh_key, priv_key);
-		if (ret) {
-			OPENSSL_LOG(ERR, "Failed to set private key");
-			cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-			BN_free(priv_key);
-			return 0;
-		}
-	}
-
-	/* generate public and private key pair.
-	 *
-	 * if private key already set, generates only public key.
-	 *
-	 * if private key is not already set, then set it to random value
-	 * and update internal private key.
-	 */
-	if (!DH_generate_key(dh_key)) {
-		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-		return 0;
-	}
-
-	if (asym_op->dh.ke_type == RTE_CRYPTO_ASYM_KE_PUB_KEY_GENERATE) {
-		const BIGNUM *pub_key = NULL;
-
-		OPENSSL_LOG(DEBUG, "%s:%d update public key",
-				__func__, __LINE__);
-
-		/* get the generated keys */
-		get_dh_pub_key(dh_key, &pub_key);
-
-		/* output public key */
-		op->pub_key.length = BN_bn2bin(pub_key,
-				op->pub_key.data);
-	}
-
-	if (asym_op->dh.ke_type == RTE_CRYPTO_ASYM_KE_PRIV_KEY_GENERATE) {
-		const BIGNUM *priv_key = NULL;
-
-		OPENSSL_LOG(DEBUG, "%s:%d updated priv key",
-				__func__, __LINE__);
-
-		/* get the generated keys */
-		get_dh_priv_key(dh_key, &priv_key);
-
-		/* provide generated private key back to user */
-		op->priv_key.length = BN_bn2bin(priv_key,
-				op->priv_key.data);
-	}
-
-	cop->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
-
-	return 0;
-}
-#endif
 
 /* process modinv operation */
 static int
@@ -2757,7 +2293,6 @@ process_openssl_modexp_op(struct rte_crypto_op *cop,
 }
 
 /* process rsa operations */
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 static int
 process_openssl_rsa_op_evp(struct rte_crypto_op *cop,
 		struct openssl_asym_session *sess)
@@ -3333,133 +2868,7 @@ process_openssl_eddsa_op_evp(struct rte_crypto_op *cop,
 	return ret;
 }
 
-#else
-static int
-process_openssl_rsa_op(struct rte_crypto_op *cop,
-		struct openssl_asym_session *sess)
-{
-	int ret = 0;
-	struct rte_crypto_asym_op *op = cop->asym;
-	RSA *rsa = sess->u.r.rsa;
-	uint32_t pad = sess->u.r.pad;
-	uint8_t *tmp;
 
-	cop->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
-
-	switch (pad) {
-	case RTE_CRYPTO_RSA_PADDING_PKCS1_5:
-		pad = RSA_PKCS1_PADDING;
-		break;
-	case RTE_CRYPTO_RSA_PADDING_NONE:
-		pad = RSA_NO_PADDING;
-		break;
-	default:
-		cop->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
-		OPENSSL_LOG(ERR,
-				"rsa pad type not supported %d", pad);
-		return 0;
-	}
-
-	switch (op->rsa.op_type) {
-	case RTE_CRYPTO_ASYM_OP_ENCRYPT:
-		ret = RSA_public_encrypt(op->rsa.message.length,
-				op->rsa.message.data,
-				op->rsa.cipher.data,
-				rsa,
-				pad);
-
-		if (ret > 0)
-			op->rsa.cipher.length = ret;
-		OPENSSL_LOG(DEBUG,
-				"length of encrypted text %d", ret);
-		break;
-
-	case RTE_CRYPTO_ASYM_OP_DECRYPT:
-		ret = RSA_private_decrypt(op->rsa.cipher.length,
-				op->rsa.cipher.data,
-				op->rsa.message.data,
-				rsa,
-				pad);
-		if (ret > 0)
-			op->rsa.message.length = ret;
-		break;
-
-	case RTE_CRYPTO_ASYM_OP_SIGN:
-		ret = RSA_private_encrypt(op->rsa.message.length,
-				op->rsa.message.data,
-				op->rsa.sign.data,
-				rsa,
-				pad);
-		if (ret > 0)
-			op->rsa.sign.length = ret;
-		break;
-
-	case RTE_CRYPTO_ASYM_OP_VERIFY:
-		tmp = rte_malloc(NULL, op->rsa.sign.length, 0);
-		if (tmp == NULL) {
-			OPENSSL_LOG(ERR, "Memory allocation failed");
-			cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-			break;
-		}
-		ret = RSA_public_decrypt(op->rsa.sign.length,
-				op->rsa.sign.data,
-				tmp,
-				rsa,
-				pad);
-
-		OPENSSL_LOG(DEBUG,
-				"Length of public_decrypt %d "
-				"length of message %zd",
-				ret, op->rsa.message.length);
-		if ((ret <= 0) || (CRYPTO_memcmp(tmp, op->rsa.message.data,
-				op->rsa.message.length))) {
-			OPENSSL_LOG(ERR, "RSA sign Verification failed");
-			cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-		}
-		rte_free(tmp);
-		break;
-
-	default:
-		/* allow ops with invalid args to be pushed to
-		 * completion queue
-		 */
-		cop->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
-		break;
-	}
-
-	if (ret < 0)
-		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-
-	return 0;
-}
-
-static int
-process_openssl_ecfpm_op(struct rte_crypto_op *cop,
-		struct openssl_asym_session *sess)
-{
-	RTE_SET_USED(cop);
-	RTE_SET_USED(sess);
-	return -ENOTSUP;
-}
-
-static int
-process_openssl_sm2_op(struct rte_crypto_op *cop,
-		struct openssl_asym_session *sess)
-{
-	RTE_SET_USED(cop);
-	RTE_SET_USED(sess);
-	return -ENOTSUP;
-}
-
-static int
-process_openssl_eddsa_op(struct rte_crypto_op *cop,
-		struct openssl_asym_session *sess)
-{
-	RTE_SET_USED(cop);
-	RTE_SET_USED(sess);
-	return -ENOTSUP;
-}
-#endif
 
 #if (OPENSSL_VERSION_NUMBER >= 0x30500000L)
 static int
@@ -4085,14 +3494,12 @@ mldsa_sign_op_evp(struct rte_crypto_op *cop,
 	case RTE_CRYPTO_AUTH_SHA3_512:
 		check_md = EVP_sha3_512();
 		break;
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 	case RTE_CRYPTO_AUTH_SHAKE_128:
 		check_md = EVP_shake128();
 		break;
 	case RTE_CRYPTO_AUTH_SHAKE_256:
 		check_md = EVP_shake256();
 		break;
-#endif
 	default:
 		break;
 	}
@@ -4328,11 +3735,7 @@ process_asym_op(struct openssl_qp *qp, struct rte_crypto_op *op,
 
 	switch (sess->xfrm_type) {
 	case RTE_CRYPTO_ASYM_XFORM_RSA:
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 		retval = process_openssl_rsa_op_evp(op, sess);
-# else
-		retval = process_openssl_rsa_op(op, sess);
-#endif
 		break;
 	case RTE_CRYPTO_ASYM_XFORM_MODEX:
 		retval = process_openssl_modexp_op(op, sess);
@@ -4341,51 +3744,26 @@ process_asym_op(struct openssl_qp *qp, struct rte_crypto_op *op,
 		retval = process_openssl_modinv_op(op, sess);
 		break;
 	case RTE_CRYPTO_ASYM_XFORM_DH:
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 		retval = process_openssl_dh_op_evp(op, sess);
-# else
-		retval = process_openssl_dh_op(op, sess);
-#endif
 		break;
 	case RTE_CRYPTO_ASYM_XFORM_DSA:
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 		if (op->asym->dsa.op_type == RTE_CRYPTO_ASYM_OP_SIGN)
 			retval = process_openssl_dsa_sign_op_evp(op, sess);
 		else if (op->asym->dsa.op_type ==
 				RTE_CRYPTO_ASYM_OP_VERIFY)
 			retval =
 				process_openssl_dsa_verify_op_evp(op, sess);
-#else
-		if (op->asym->dsa.op_type == RTE_CRYPTO_ASYM_OP_SIGN)
-			retval = process_openssl_dsa_sign_op(op, sess);
-		else if (op->asym->dsa.op_type ==
-				RTE_CRYPTO_ASYM_OP_VERIFY)
-			retval =
-				process_openssl_dsa_verify_op(op, sess);
 		else
 			op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
-#endif
 		break;
 	case RTE_CRYPTO_ASYM_XFORM_ECFPM:
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 		retval = process_openssl_ecfpm_op_evp(op, sess);
-#else
-		retval = process_openssl_ecfpm_op(op, sess);
-#endif
 		break;
 	case RTE_CRYPTO_ASYM_XFORM_SM2:
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 		retval = process_openssl_sm2_op_evp(op, sess);
-#else
-		retval = process_openssl_sm2_op(op, sess);
-#endif
 		break;
 	case RTE_CRYPTO_ASYM_XFORM_EDDSA:
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 		retval = process_openssl_eddsa_op_evp(op, sess);
-#else
-		retval = process_openssl_eddsa_op(op, sess);
-#endif
 		break;
 	case RTE_CRYPTO_ASYM_XFORM_ML_KEM:
 #if (OPENSSL_VERSION_NUMBER >= 0x30500000L)
@@ -4590,13 +3968,12 @@ cryptodev_openssl_create(const char *name,
 
 	rte_cryptodev_pmd_probing_finish(dev);
 
-# if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 	/* Load legacy provider
 	 * Some algorithms are no longer available in earlier version of openssl,
 	 * unless the legacy provider explicitly loaded. e.g. DES
 	 */
 	ossl_legacy_provider_load();
-# endif
+
 	return 0;
 
 init_error:
@@ -4645,9 +4022,8 @@ cryptodev_openssl_remove(struct rte_vdev_device *vdev)
 	if (cryptodev == NULL)
 		return -ENODEV;
 
-# if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 	ossl_legacy_provider_unload();
-# endif
+
 	return rte_cryptodev_pmd_destroy(cryptodev);
 }
 
diff --git a/drivers/crypto/openssl/rte_openssl_pmd_ops.c b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
index 4e5fb07bb2..d927cc5228 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd_ops.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
@@ -10,11 +10,9 @@
 
 #include "openssl_pmd_private.h"
 #include "compat.h"
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 #include <openssl/provider.h>
 #include <openssl/core_names.h>
 #include <openssl/param_build.h>
-#endif
 
 static const struct rte_cryptodev_capabilities openssl_pmd_capabilities[] = {
 	{	/* MD5 HMAC */
@@ -457,7 +455,6 @@ static const struct rte_cryptodev_capabilities openssl_pmd_capabilities[] = {
 			}, }
 		}, }
 	},
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 	{   /* SHAKE_128 */
 		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
 		{.sym = {
@@ -500,7 +497,6 @@ static const struct rte_cryptodev_capabilities openssl_pmd_capabilities[] = {
 			}, }
 		}, }
 	},
-#endif
 	{	/* AES CBC */
 		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
 		{.sym = {
@@ -1222,7 +1218,6 @@ static int openssl_set_asym_session_parameters(
 			goto err_rsa;
 
 		asym_session->u.r.pad = xform->rsa.padding.type;
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 		OSSL_PARAM_BLD * param_bld = OSSL_PARAM_BLD_new();
 		if (!param_bld) {
 			OPENSSL_LOG(ERR, "failed to allocate resources");
@@ -1323,79 +1318,7 @@ static int openssl_set_asym_session_parameters(
 		OSSL_PARAM_BLD_free(param_bld);
 		OSSL_PARAM_free(params);
 		ret = 0;
-#else
-		RSA *rsa = RSA_new();
-		if (rsa == NULL)
-			goto err_rsa;
-
-		if (xform->rsa.d.length > 0) {
-			d = BN_bin2bn(
-			(const unsigned char *)xform->rsa.d.data,
-			xform->rsa.d.length,
-			d);
-			if (!d) {
-				RSA_free(rsa);
-				goto err_rsa;
-			}
-		}
-
-		if (xform->rsa.key_type == RTE_RSA_KEY_TYPE_QT) {
-			p = BN_bin2bn((const unsigned char *)
-					xform->rsa.qt.p.data,
-					xform->rsa.qt.p.length,
-					p);
-			q = BN_bin2bn((const unsigned char *)
-					xform->rsa.qt.q.data,
-					xform->rsa.qt.q.length,
-					q);
-			dmp1 = BN_bin2bn((const unsigned char *)
-					xform->rsa.qt.dP.data,
-					xform->rsa.qt.dP.length,
-					dmp1);
-			dmq1 = BN_bin2bn((const unsigned char *)
-					xform->rsa.qt.dQ.data,
-					xform->rsa.qt.dQ.length,
-					dmq1);
-			iqmp = BN_bin2bn((const unsigned char *)
-					xform->rsa.qt.qInv.data,
-					xform->rsa.qt.qInv.length,
-					iqmp);
 
-			if (!p || !q || !dmp1 || !dmq1 || !iqmp) {
-				RSA_free(rsa);
-				goto err_rsa;
-			}
-			ret = set_rsa_params(rsa, p, q);
-			if (ret) {
-				OPENSSL_LOG(ERR,
-					"failed to set rsa params");
-				RSA_free(rsa);
-				goto err_rsa;
-			}
-			ret = set_rsa_crt_params(rsa, dmp1, dmq1, iqmp);
-			if (ret) {
-				OPENSSL_LOG(ERR,
-					"failed to set crt params");
-				RSA_free(rsa);
-				/*
-				 * set already populated params to NULL
-				 * as its freed by call to RSA_free
-				 */
-				p = q = NULL;
-				goto err_rsa;
-			}
-		}
-
-		ret = set_rsa_keys(rsa, n, e, d);
-		if (ret) {
-			OPENSSL_LOG(ERR, "Failed to load rsa keys");
-			RSA_free(rsa);
-			return ret;
-		}
-		asym_session->u.r.rsa = rsa;
-		asym_session->xfrm_type = RTE_CRYPTO_ASYM_XFORM_RSA;
-		break;
-#endif
 err_rsa:
 		BN_clear_free(n);
 		BN_clear_free(e);
@@ -1469,7 +1392,6 @@ static int openssl_set_asym_session_parameters(
 	case RTE_CRYPTO_ASYM_XFORM_DH:
 	{
 		DH *dh = NULL;
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 		BIGNUM **p = &asym_session->u.dh.p;
 		BIGNUM **g = &asym_session->u.dh.g;
 
@@ -1520,51 +1442,18 @@ static int openssl_set_asym_session_parameters(
 
 		asym_session->u.dh.param_bld = param_bld;
 		asym_session->u.dh.param_bld_peer = param_bld_peer;
-#else
-		BIGNUM *p = NULL;
-		BIGNUM *g = NULL;
-
-		p = BN_bin2bn((const unsigned char *)
-				xform->dh.p.data,
-				xform->dh.p.length,
-				p);
-		g = BN_bin2bn((const unsigned char *)
-				xform->dh.g.data,
-				xform->dh.g.length,
-				g);
-		if (!p || !g)
-			goto err_dh;
-
-		dh = DH_new();
-		if (dh == NULL) {
-			OPENSSL_LOG(ERR,
-				"failed to allocate resources");
-			goto err_dh;
-		}
-		ret = set_dh_params(dh, p, g);
-		if (ret) {
-			DH_free(dh);
-			goto err_dh;
-		}
-#endif
 		asym_session->u.dh.dh_key = dh;
 		asym_session->xfrm_type = RTE_CRYPTO_ASYM_XFORM_DH;
 		break;
 
 err_dh:
 		OPENSSL_LOG(ERR, " failed to set dh params");
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 		BN_free(*p);
 		BN_free(*g);
-#else
-		BN_free(p);
-		BN_free(g);
-#endif
 		return -1;
 	}
 	case RTE_CRYPTO_ASYM_XFORM_DSA:
 	{
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 		BIGNUM **p = &asym_session->u.s.p;
 		BIGNUM **g = &asym_session->u.s.g;
 		BIGNUM **q = &asym_session->u.s.q;
@@ -1615,85 +1504,16 @@ static int openssl_set_asym_session_parameters(
 		asym_session->u.s.param_bld = param_bld;
 
 		break;
-#else
-		BIGNUM *p = NULL, *g = NULL;
-		BIGNUM *q = NULL, *priv_key = NULL;
-		BIGNUM *pub_key = BN_new();
-		BN_zero(pub_key);
-
-		p = BN_bin2bn((const unsigned char *)
-				xform->dsa.p.data,
-				xform->dsa.p.length,
-				p);
-
-		g = BN_bin2bn((const unsigned char *)
-				xform->dsa.g.data,
-				xform->dsa.g.length,
-				g);
-
-		q = BN_bin2bn((const unsigned char *)
-				xform->dsa.q.data,
-				xform->dsa.q.length,
-				q);
-		if (!p || !q || !g)
-			goto err_dsa;
-
-		priv_key = BN_bin2bn((const unsigned char *)
-				xform->dsa.x.data,
-				xform->dsa.x.length,
-				priv_key);
-		if (priv_key == NULL)
-			goto err_dsa;
-
-		DSA *dsa = DSA_new();
-		if (dsa == NULL) {
-			OPENSSL_LOG(ERR,
-				" failed to allocate resources");
-			goto err_dsa;
-		}
-
-		ret = set_dsa_params(dsa, p, q, g);
-		if (ret) {
-			DSA_free(dsa);
-			OPENSSL_LOG(ERR, "Failed to dsa params");
-			goto err_dsa;
-		}
-
-		/*
-		 * openssl 1.1.0 mandate that public key can't be
-		 * NULL in very first call. so set a dummy pub key.
-		 * to keep consistency, lets follow same approach for
-		 * both versions
-		 */
-		/* just set dummy public for very 1st call */
-		ret = set_dsa_keys(dsa, pub_key, priv_key);
-		if (ret) {
-			DSA_free(dsa);
-			OPENSSL_LOG(ERR, "Failed to set keys");
-			goto err_dsa;
-		}
-		asym_session->u.s.dsa = dsa;
-		asym_session->xfrm_type = RTE_CRYPTO_ASYM_XFORM_DSA;
-		break;
-#endif
 err_dsa:
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 		BN_free(*p);
 		BN_free(*q);
 		BN_free(*g);
 		BN_free(*priv_key);
-#else
-		BN_free(p);
-		BN_free(q);
-		BN_free(g);
-		BN_free(priv_key);
-#endif
 		BN_free(pub_key);
 		return -1;
 	}
 	case RTE_CRYPTO_ASYM_XFORM_ECFPM:
 	{
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 		EC_GROUP *ecgrp = NULL;
 
 		asym_session->xfrm_type = xform->xform_type;
@@ -1727,14 +1547,9 @@ static int openssl_set_asym_session_parameters(
 		asym_session->u.ec.curve_id = xform->ec.curve_id;
 		asym_session->u.ec.group = ecgrp;
 		break;
-#else
-		OPENSSL_LOG(WARNING, "ECFPM unsupported for OpenSSL Version < 3.0");
-		return -ENOTSUP;
-#endif
 	}
 	case RTE_CRYPTO_ASYM_XFORM_SM2:
 	{
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 #ifndef OPENSSL_NO_SM2
 		OSSL_PARAM_BLD *param_bld = NULL;
 		OSSL_PARAM *params = NULL;
@@ -1818,10 +1633,6 @@ static int openssl_set_asym_session_parameters(
 #else
 		OPENSSL_LOG(WARNING, "SM2 unsupported in current OpenSSL Version");
 		return -ENOTSUP;
-#endif
-#else
-		OPENSSL_LOG(WARNING, "SM2 unsupported for OpenSSL Version < 3.0");
-		return -ENOTSUP;
 #endif
 	}
 	case RTE_CRYPTO_ASYM_XFORM_EDDSA:
@@ -1983,12 +1794,7 @@ static void openssl_reset_asym_session(struct openssl_asym_session *sess)
 {
 	switch (sess->xfrm_type) {
 	case RTE_CRYPTO_ASYM_XFORM_RSA:
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 		EVP_PKEY_CTX_free(sess->u.r.ctx);
-#else
-		if (sess->u.r.rsa)
-			RSA_free(sess->u.r.rsa);
-#endif
 		break;
 	case RTE_CRYPTO_ASYM_XFORM_MODEX:
 		if (sess->u.e.ctx) {
@@ -2003,35 +1809,23 @@ static void openssl_reset_asym_session(struct openssl_asym_session *sess)
 		}
 		break;
 	case RTE_CRYPTO_ASYM_XFORM_DH:
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 		OSSL_PARAM_BLD_free(sess->u.dh.param_bld);
 		OSSL_PARAM_BLD_free(sess->u.dh.param_bld_peer);
 		sess->u.dh.param_bld = NULL;
 		sess->u.dh.param_bld_peer = NULL;
-#else
-		if (sess->u.dh.dh_key)
-			DH_free(sess->u.dh.dh_key);
-#endif
 		BN_clear_free(sess->u.dh.p);
 		BN_clear_free(sess->u.dh.g);
 		break;
 	case RTE_CRYPTO_ASYM_XFORM_DSA:
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 		OSSL_PARAM_BLD_free(sess->u.s.param_bld);
 		sess->u.s.param_bld = NULL;
 		BN_clear_free(sess->u.s.p);
 		BN_clear_free(sess->u.s.q);
 		BN_clear_free(sess->u.s.g);
 		BN_clear_free(sess->u.s.priv_key);
-#else
-		if (sess->u.s.dsa)
-			DSA_free(sess->u.s.dsa);
-#endif
 		break;
 	case RTE_CRYPTO_ASYM_XFORM_SM2:
-#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
 		OSSL_PARAM_free(sess->u.sm2.params);
-#endif
 		break;
 	case RTE_CRYPTO_ASYM_XFORM_EDDSA:
 #if (OPENSSL_VERSION_NUMBER >= 0x30300000L)
-- 
2.43.0

