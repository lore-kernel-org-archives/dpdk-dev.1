Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E679CD98C7
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 08:52:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF45D42EE9;
	Thu, 11 Jun 2026 10:52:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 78F4E4026A
 for <dev@dpdk.org>; Thu, 11 Jun 2026 10:52:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781167963; x=1812703963;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1CaVF99ZUrihtmuJrGOz9Gl5F6CRtjYZUC1YRKO4l1M=;
 b=bhp8Ur/5e7+6l7jNgtfBzgaew6IPs9QLeYEZo+XzWxZ2SpoYncqC5r13
 Qnq5Qf/XaeC0ytitee/0NDCpU5++VVYYxiSKfmGLZg9Es9ghbY0T6rGZr
 3dX8CVHTZ1pKD194J0BQR1jA4CWFQpjcsObFYLqLx+AIbdhiM1L8Lh22N
 mvYtPHVVFOVbKp+7hMw/J6Oi97MhVO5c1JcQe0pF93tOZtyXYStwTCANB
 oVQl0gxbudIQVLLpgLlGjwQuisfoLbxeNr7HhqZsya8reaVL9NlXNdZf6
 NcKBcYFiu6VXXp1DDOJAY94u56P0LoM0WKoJMF5EZWSp4nrEKzuSVOGN9 A==;
X-CSE-ConnectionGUID: ZaStISnTSB2pALxGD/4tIQ==
X-CSE-MsgGUID: zRPuwdYpS76fe5up6oXVvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="84546601"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="84546601"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 01:52:42 -0700
X-CSE-ConnectionGUID: r4XuKqvDTEG47tYheB2T4A==
X-CSE-MsgGUID: XxARTnwgR+eb/kx2Fcdp/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="246446563"
Received: from silpixa00401454.ir.intel.com ([10.20.224.230])
 by orviesa009.jf.intel.com with ESMTP; 11 Jun 2026 01:52:41 -0700
From: Emma Finn <emma.finn@intel.com>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org,
	Emma Finn <emma.finn@intel.com>
Subject: [v1] crypto/qat: require IPsec MB for HMAC precomputes
Date: Thu, 11 Jun 2026 08:52:36 +0000
Message-ID: <20260611085237.1459286-1-emma.finn@intel.com>
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

IPsec MB library (v1.4.0+) is now required for HMAC precomputes as
OpenSSL 3.0 removed SHA*_Transform APIs. OpenSSL remains optional
for DOCSIS BPI cipher fallback via EVP API.

On x86: IPsec MB required, OpenSSL optional (DOCSIS fallback)
On ARM: IPsec MB required, OpenSSL required (DOCSIS support)

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
 doc/guides/cryptodevs/qat.rst        |  28 +-
 drivers/common/qat/meson.build       |  69 +++--
 drivers/crypto/qat/qat_sym_session.c | 412 +--------------------------
 3 files changed, 74 insertions(+), 435 deletions(-)

diff --git a/doc/guides/cryptodevs/qat.rst b/doc/guides/cryptodevs/qat.rst
index 0c2b85444e..4e60e8343c 100644
--- a/doc/guides/cryptodevs/qat.rst
+++ b/doc/guides/cryptodevs/qat.rst
@@ -352,15 +352,25 @@ To use this feature the user must set the devarg on process start as a device ad
  -a 03:01.1,qat_sym_cipher_crc_enable=1
 
 
-Running QAT PMD with Intel IPsec MB library for symmetric precomputes function
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-The QAT PMD uses Intel IPsec MB library for partial hash calculation
-in symmetric precomputes function by default,
-the minimum required version of IPsec MB library is v1.4.
-If this version of IPsec is not met, it will fallback to use OpenSSL.
-ARM will always default to using OpenSSL
-as ARM IPsec MB does not support the necessary algorithms.
+Running QAT PMD with Intel IPsec MB library
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The QAT PMD requires IPsec MB library for HMAC partial hash calculation
+in symmetric precomputes function. OpenSSL 3.0+ removed the low-level SHA*_Transform APIs
+that were previously used for HMAC precomputes.
+
+**On x86 platforms:**
+
+* Intel IPsec MB library (v1.4.0+) is required for HMAC precomputes
+* OpenSSL (3.0+) is optional for DOCSIS BPI cipher fallback
+
+**On ARM platforms:**
+
+* ARM IPsec MB library from ``gitlab.arm.com/arm-reference-solutions/ipsec-mb``
+  is required for HMAC precomputes.
+* OpenSSL (3.0+) is required for DOCSIS BPI cipher algorithms. ARM IPsec MB does not
+  implement CFB-one-byte cipher modes needed for DOCSIS. Without OpenSSL, DOCSIS
+  algorithms will not be available on ARM.
 
 
 Device and driver naming
diff --git a/drivers/common/qat/meson.build b/drivers/common/qat/meson.build
index 31e06f4376..4f516dea2a 100644
--- a/drivers/common/qat/meson.build
+++ b/drivers/common/qat/meson.build
@@ -27,47 +27,58 @@ if disable_drivers.contains(qat_compress_path)
             'Explicitly disabled via build config')
 endif
 
-libcrypto = dependency('libcrypto', required: false, method: 'pkg-config')
+# IPsec MB is REQUIRED for HMAC precomputes (no OpenSSL 3.0 alternative)
+# OpenSSL is OPTIONAL for DOCSIS BPI cipher fallback
+IMB_required_ver = '1.4.0'
 
 if arch_subdir == 'arm'
-    if libcrypto.found()
-        ext_deps += libcrypto
-        dpdk_conf.set('RTE_QAT_OPENSSL', true)
+    IMB_header = '#include<ipsec-mb.h>'
+else
+    IMB_header = '#include<intel-ipsec-mb.h>'
+endif
+
+# Check for IPsec MB library (required)
+libipsecmb = cc.find_library('IPSec_MB', required: false)
+if libipsecmb.found() and cc.links(
+        'int main(void) {return 0;}', dependencies: libipsecmb)
+    imb_ver = cc.get_define('IMB_VERSION_STR',
+        prefix : IMB_header).split('"')[1]
+
+    if (imb_ver.version_compare('>=' + IMB_required_ver))
+        ext_deps += libipsecmb
+        dpdk_conf.set('RTE_QAT_IPSECMB', true)
     else
         qat_crypto = false
         dpdk_drvs_disabled += qat_crypto_path
         set_variable('drv_' + qat_crypto_path.underscorify() + '_disable_reason',
-        'missing dependency for Arm, libcrypto')
+            'IPSec_MB version >= @0@ is required, found version @1@'.format(
+                IMB_required_ver, imb_ver))
     endif
 else
-    IMB_required_ver = '1.4.0'
-    IMB_header = '#include<intel-ipsec-mb.h>'
-    libipsecmb = cc.find_library('IPSec_MB', required: false)
-    if libipsecmb.found() and cc.links(
-            'int main(void) {return 0;}', dependencies: libipsecmb)
-        # version comes with quotes, so we split based on " and take the middle
-        imb_ver = cc.get_define('IMB_VERSION_STR',
-            prefix : IMB_header).split('"')[1]
+    qat_crypto = false
+    dpdk_drvs_disabled += qat_crypto_path
+    set_variable('drv_' + qat_crypto_path.underscorify() + '_disable_reason',
+        'missing required dependency, libIPSec_MB >= @0@'.format(IMB_required_ver))
+endif
 
-        if (imb_ver.version_compare('>=' + IMB_required_ver))
-            ext_deps += libipsecmb
-        elif libcrypto.found()
-            ext_deps += libcrypto
-            dpdk_conf.set('RTE_QAT_OPENSSL', true)
-        else
-            qat_crypto = false
-            dpdk_drvs_disabled += qat_crypto_path
-            set_variable('drv_' + qat_crypto_path.underscorify() + '_disable_reason',
-                'missing dependency, libipsecmb or libcrypto')
-        endif
-    elif libcrypto.found()
+# Check for OpenSSL (optional, for DOCSIS BPI cipher fallback)
+openssl_required_ver = '3.0.0'
+if qat_crypto
+    libcrypto = dependency('libcrypto', required: false, method: 'pkg-config', version: '>= ' + openssl_required_ver)
+    if libcrypto.found()
         ext_deps += libcrypto
         dpdk_conf.set('RTE_QAT_OPENSSL', true)
+        if arch_subdir == 'arm'
+            message('QAT: Using OpenSSL @0@ for DOCSIS on ARM'.format(libcrypto.version()))
+        else
+            message('QAT: OpenSSL @0@ available for DOCSIS fallback'.format(libcrypto.version()))
+        endif
     else
-        qat_crypto = false
-        dpdk_drvs_disabled += qat_crypto_path
-        set_variable('drv_' + qat_crypto_path.underscorify() + '_disable_reason',
-            'missing dependency, libipsecmb or libcrypto')
+        if arch_subdir == 'arm'
+            warning('QAT: OpenSSL >= @0@ not found - DOCSIS algorithms will not be available on ARM'.format(openssl_required_ver))
+        else
+            message('QAT: OpenSSL >= @0@ not found - DOCSIS will use IPsec MB only'.format(openssl_required_ver))
+        endif
     endif
 endif
 
diff --git a/drivers/crypto/qat/qat_sym_session.c b/drivers/crypto/qat/qat_sym_session.c
index ff01db4372..8be8802e8d 100644
--- a/drivers/crypto/qat/qat_sym_session.c
+++ b/drivers/crypto/qat/qat_sym_session.c
@@ -2,19 +2,18 @@
  * Copyright(c) 2015-2022 Intel Corporation
  */
 
-#define OPENSSL_API_COMPAT 0x10100000L
-
-#ifdef RTE_QAT_OPENSSL
-#include <openssl/sha.h>	/* Needed to calculate pre-compute values */
-#include <openssl/aes.h>	/* Needed to calculate pre-compute values */
-#include <openssl/md5.h>	/* Needed to calculate pre-compute values */
-#include <openssl/evp.h>	/* Needed for bpi runt block processing */
-#endif
-
-#ifndef RTE_QAT_OPENSSL
-#ifndef RTE_ARCH_ARM
+/* IPsec MB is required for HMAC precomputes (OpenSSL 3.0 removed Transform APIs)
+ * OpenSSL is optional for DOCSIS BPI cipher fallback
+ */
+#ifdef RTE_ARCH_ARM
+#include <ipsec-mb.h>
+#else
 #include <intel-ipsec-mb.h>
 #endif
+
+#ifdef RTE_QAT_OPENSSL
+#define OPENSSL_API_COMPAT 0x30000000L
+#include <openssl/evp.h>	/* For DOCSIS BPI cipher fallback */
 #endif
 
 #include <rte_memcpy.h>
@@ -38,9 +37,8 @@
 static OSSL_PROVIDER * legacy_lib;
 static OSSL_PROVIDER *default_lib;
 
-/* Some cryptographic algorithms such as MD and DES are now considered legacy
- * and not enabled by default in OpenSSL 3.0. Load up lagacy provider as MD5
- * DES are needed in QAT pre-computes and secure session creation.
+/* DES is considered legacy and not enabled by default in OpenSSL 3.0.
+ * Load legacy provider for DES-DOCSISBPI cipher fallback support.
  */
 static int ossl_legacy_provider_load(void)
 {
@@ -1412,339 +1410,9 @@ static int qat_hash_get_block_size(enum icp_qat_hw_auth_algo qat_hash_alg)
 #define HMAC_OPAD_VALUE	0x5c
 #define HASH_XCBC_PRECOMP_KEY_NUM 3
 
-#ifdef RTE_QAT_OPENSSL
-static int partial_hash_sha1(uint8_t *data_in, uint8_t *data_out)
-{
-	SHA_CTX ctx;
-
-	if (!SHA1_Init(&ctx))
-		return -EFAULT;
-	SHA1_Transform(&ctx, data_in);
-	rte_memcpy(data_out, &ctx, SHA_DIGEST_LENGTH);
-	return 0;
-}
-
-static int partial_hash_sha224(uint8_t *data_in, uint8_t *data_out)
-{
-	SHA256_CTX ctx;
-
-	if (!SHA224_Init(&ctx))
-		return -EFAULT;
-	SHA256_Transform(&ctx, data_in);
-	rte_memcpy(data_out, &ctx, SHA256_DIGEST_LENGTH);
-	return 0;
-}
-
-static int partial_hash_sha256(uint8_t *data_in, uint8_t *data_out)
-{
-	SHA256_CTX ctx;
-
-	if (!SHA256_Init(&ctx))
-		return -EFAULT;
-	SHA256_Transform(&ctx, data_in);
-	rte_memcpy(data_out, &ctx, SHA256_DIGEST_LENGTH);
-	return 0;
-}
-
-static int partial_hash_sha384(uint8_t *data_in, uint8_t *data_out)
-{
-	SHA512_CTX ctx;
-
-	if (!SHA384_Init(&ctx))
-		return -EFAULT;
-	SHA512_Transform(&ctx, data_in);
-	rte_memcpy(data_out, &ctx, SHA512_DIGEST_LENGTH);
-	return 0;
-}
-
-static int partial_hash_sha512(uint8_t *data_in, uint8_t *data_out)
-{
-	SHA512_CTX ctx;
-
-	if (!SHA512_Init(&ctx))
-		return -EFAULT;
-	SHA512_Transform(&ctx, data_in);
-	rte_memcpy(data_out, &ctx, SHA512_DIGEST_LENGTH);
-	return 0;
-}
-
-static int partial_hash_md5(uint8_t *data_in, uint8_t *data_out)
-{
-	MD5_CTX ctx;
-
-	if (!MD5_Init(&ctx))
-		return -EFAULT;
-	MD5_Transform(&ctx, data_in);
-	rte_memcpy(data_out, &ctx, MD5_DIGEST_LENGTH);
-
-	return 0;
-}
-
-static void aes_cmac_key_derive(uint8_t *base, uint8_t *derived)
-{
-	int i;
-
-	derived[0] = base[0] << 1;
-	for (i = 1; i < ICP_QAT_HW_AES_BLK_SZ ; i++) {
-		derived[i] = base[i] << 1;
-		derived[i - 1] |= base[i] >> 7;
-	}
-
-	if (base[0] & 0x80)
-		derived[ICP_QAT_HW_AES_BLK_SZ - 1] ^= QAT_AES_CMAC_CONST_RB;
-}
-
-static int
-partial_hash_compute(enum icp_qat_hw_auth_algo hash_alg,
-		uint8_t *data_in, uint8_t *data_out)
-{
-	int digest_size;
-	uint8_t digest[qat_hash_get_digest_size(
-			ICP_QAT_HW_AUTH_ALGO_DELIMITER)];
-	uint32_t *hash_state_out_be32;
-	uint64_t *hash_state_out_be64;
-	int i;
-
-	/* Initialize to avoid gcc warning */
-	memset(digest, 0, sizeof(digest));
-
-	digest_size = qat_hash_get_digest_size(hash_alg);
-	if (digest_size <= 0)
-		return -EFAULT;
-
-	hash_state_out_be32 = (uint32_t *)data_out;
-	hash_state_out_be64 = (uint64_t *)data_out;
-
-	switch (hash_alg) {
-	case ICP_QAT_HW_AUTH_ALGO_SHA1:
-		if (partial_hash_sha1(data_in, digest))
-			return -EFAULT;
-		for (i = 0; i < digest_size >> 2; i++, hash_state_out_be32++)
-			*hash_state_out_be32 =
-				rte_bswap32(*(((uint32_t *)digest)+i));
-		break;
-	case ICP_QAT_HW_AUTH_ALGO_SHA224:
-		if (partial_hash_sha224(data_in, digest))
-			return -EFAULT;
-		for (i = 0; i < digest_size >> 2; i++, hash_state_out_be32++)
-			*hash_state_out_be32 =
-				rte_bswap32(*(((uint32_t *)digest)+i));
-		break;
-	case ICP_QAT_HW_AUTH_ALGO_SHA256:
-		if (partial_hash_sha256(data_in, digest))
-			return -EFAULT;
-		for (i = 0; i < digest_size >> 2; i++, hash_state_out_be32++)
-			*hash_state_out_be32 =
-				rte_bswap32(*(((uint32_t *)digest)+i));
-		break;
-	case ICP_QAT_HW_AUTH_ALGO_SHA384:
-		if (partial_hash_sha384(data_in, digest))
-			return -EFAULT;
-		for (i = 0; i < digest_size >> 3; i++, hash_state_out_be64++)
-			*hash_state_out_be64 =
-				rte_bswap64(*(((uint64_t *)digest)+i));
-		break;
-	case ICP_QAT_HW_AUTH_ALGO_SHA512:
-		if (partial_hash_sha512(data_in, digest))
-			return -EFAULT;
-		for (i = 0; i < digest_size >> 3; i++, hash_state_out_be64++)
-			*hash_state_out_be64 =
-				rte_bswap64(*(((uint64_t *)digest)+i));
-		break;
-	case ICP_QAT_HW_AUTH_ALGO_MD5:
-		if (partial_hash_md5(data_in, data_out))
-			return -EFAULT;
-		break;
-	default:
-		QAT_LOG(ERR, "invalid hash alg %u", hash_alg);
-		return -EFAULT;
-	}
-
-	return 0;
-}
-
-static const uint8_t AES_CMAC_SEED[ICP_QAT_HW_AES_128_KEY_SZ];
-
-static int qat_sym_do_precomputes(enum icp_qat_hw_auth_algo hash_alg,
-				const uint8_t *auth_key,
-				uint16_t auth_keylen,
-				uint8_t *p_state_buf,
-				uint16_t *p_state_len,
-				uint8_t aes_cmac)
-{
-	int block_size;
-	uint8_t ipad[qat_hash_get_block_size(ICP_QAT_HW_AUTH_ALGO_DELIMITER)];
-	uint8_t opad[qat_hash_get_block_size(ICP_QAT_HW_AUTH_ALGO_DELIMITER)];
-	int i;
-
-	if (hash_alg == ICP_QAT_HW_AUTH_ALGO_AES_XCBC_MAC) {
-
-		/* CMAC */
-		if (aes_cmac) {
-			AES_KEY enc_key;
-			uint8_t *in = NULL;
-			uint8_t k0[ICP_QAT_HW_AES_128_KEY_SZ];
-			uint8_t *k1, *k2;
-
-			auth_keylen = ICP_QAT_HW_AES_128_KEY_SZ;
-
-			in = rte_zmalloc("AES CMAC K1",
-					 ICP_QAT_HW_AES_128_KEY_SZ, 16);
-
-			if (in == NULL) {
-				QAT_LOG(ERR, "Failed to alloc memory");
-				return -ENOMEM;
-			}
-
-			rte_memcpy(in, AES_CMAC_SEED,
-				   ICP_QAT_HW_AES_128_KEY_SZ);
-			rte_memcpy(p_state_buf, auth_key, auth_keylen);
-
-			if (AES_set_encrypt_key(auth_key, auth_keylen << 3,
-				&enc_key) != 0) {
-				rte_free_sensitive(in);
-				return -EFAULT;
-			}
-
-			AES_encrypt(in, k0, &enc_key);
-
-			k1 = p_state_buf + ICP_QAT_HW_AES_XCBC_MAC_STATE1_SZ;
-			k2 = k1 + ICP_QAT_HW_AES_XCBC_MAC_STATE1_SZ;
-
-			aes_cmac_key_derive(k0, k1);
-			aes_cmac_key_derive(k1, k2);
-
-			rte_memzero_explicit(k0, ICP_QAT_HW_AES_128_KEY_SZ);
-			*p_state_len = ICP_QAT_HW_AES_XCBC_MAC_STATE2_SZ;
-			rte_free_sensitive(in);
-			goto out;
-		} else {
-			static uint8_t qat_aes_xcbc_key_seed[
-					ICP_QAT_HW_AES_XCBC_MAC_STATE2_SZ] = {
-				0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
-				0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
-				0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02,
-				0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02,
-				0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03,
-				0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03,
-			};
-
-			uint8_t *in = NULL;
-			uint8_t *out = p_state_buf;
-			int x;
-			AES_KEY enc_key;
-
-			in = rte_zmalloc("working mem for key",
-					ICP_QAT_HW_AES_XCBC_MAC_STATE2_SZ, 16);
-			if (in == NULL) {
-				QAT_LOG(ERR, "Failed to alloc memory");
-				return -ENOMEM;
-			}
-
-			rte_memcpy(in, qat_aes_xcbc_key_seed,
-					ICP_QAT_HW_AES_XCBC_MAC_STATE2_SZ);
-			for (x = 0; x < HASH_XCBC_PRECOMP_KEY_NUM; x++) {
-				if (AES_set_encrypt_key(auth_key,
-							auth_keylen << 3,
-							&enc_key) != 0) {
-					rte_free_sensitive(in -
-							   (x * ICP_QAT_HW_AES_XCBC_MAC_KEY_SZ));
-					rte_memzero_explicit(out -
-							     (x * ICP_QAT_HW_AES_XCBC_MAC_KEY_SZ),
-							     ICP_QAT_HW_AES_XCBC_MAC_STATE2_SZ);
-					return -EFAULT;
-				}
-				AES_encrypt(in, out, &enc_key);
-				in += ICP_QAT_HW_AES_XCBC_MAC_KEY_SZ;
-				out += ICP_QAT_HW_AES_XCBC_MAC_KEY_SZ;
-			}
-			*p_state_len = ICP_QAT_HW_AES_XCBC_MAC_STATE2_SZ;
-			rte_free_sensitive(in - x*ICP_QAT_HW_AES_XCBC_MAC_KEY_SZ);
-			goto out;
-		}
-
-	} else if ((hash_alg == ICP_QAT_HW_AUTH_ALGO_GALOIS_128) ||
-		(hash_alg == ICP_QAT_HW_AUTH_ALGO_GALOIS_64)) {
-		uint8_t *in = NULL;
-		uint8_t *out = p_state_buf;
-		AES_KEY enc_key;
-
-		memset(p_state_buf, 0, ICP_QAT_HW_GALOIS_H_SZ +
-				ICP_QAT_HW_GALOIS_LEN_A_SZ +
-				ICP_QAT_HW_GALOIS_E_CTR0_SZ);
-		in = rte_zmalloc("working mem for key",
-				ICP_QAT_HW_GALOIS_H_SZ, 16);
-		if (in == NULL) {
-			QAT_LOG(ERR, "Failed to alloc memory");
-			return -ENOMEM;
-		}
-
-		rte_memzero_explicit(in, ICP_QAT_HW_GALOIS_H_SZ);
-		if (AES_set_encrypt_key(auth_key, auth_keylen << 3,
-			&enc_key) != 0) {
-			return -EFAULT;
-		}
-		AES_encrypt(in, out, &enc_key);
-		*p_state_len = ICP_QAT_HW_GALOIS_H_SZ +
-				ICP_QAT_HW_GALOIS_LEN_A_SZ +
-				ICP_QAT_HW_GALOIS_E_CTR0_SZ;
-		rte_free_sensitive(in);
-		return 0;
-	}
-
-	block_size = qat_hash_get_block_size(hash_alg);
-	if (block_size < 0)
-		return block_size;
-	/* init ipad and opad from key and xor with fixed values */
-	memset(ipad, 0, block_size);
-	memset(opad, 0, block_size);
-
-	if (auth_keylen > (unsigned int)block_size) {
-		QAT_LOG(ERR, "invalid keylen %u", auth_keylen);
-		return -EFAULT;
-	}
-
-	RTE_VERIFY(auth_keylen <= sizeof(ipad));
-	RTE_VERIFY(auth_keylen <= sizeof(opad));
-
-	rte_memcpy(ipad, auth_key, auth_keylen);
-	rte_memcpy(opad, auth_key, auth_keylen);
-
-	for (i = 0; i < block_size; i++) {
-		uint8_t *ipad_ptr = ipad + i;
-		uint8_t *opad_ptr = opad + i;
-		*ipad_ptr ^= HMAC_IPAD_VALUE;
-		*opad_ptr ^= HMAC_OPAD_VALUE;
-	}
-
-	/* do partial hash of ipad and copy to state1 */
-	if (partial_hash_compute(hash_alg, ipad, p_state_buf)) {
-		rte_memzero_explicit(ipad, block_size);
-		rte_memzero_explicit(opad, block_size);
-		QAT_LOG(ERR, "ipad precompute failed");
-		return -EFAULT;
-	}
-
-	/*
-	 * State len is a multiple of 8, so may be larger than the digest.
-	 * Put the partial hash of opad state_len bytes after state1
-	 */
-	*p_state_len = qat_hash_get_state1_size(hash_alg);
-	if (partial_hash_compute(hash_alg, opad, p_state_buf + *p_state_len)) {
-		rte_memzero_explicit(ipad, block_size);
-		rte_memzero_explicit(opad, block_size);
-		QAT_LOG(ERR, "opad precompute failed");
-		return -EFAULT;
-	}
-
-	/*  don't leave data lying around */
-	rte_memzero_explicit(ipad, block_size);
-	rte_memzero_explicit(opad, block_size);
-out:
-	return 0;
-}
-
-#else
+/* HMAC precomputes always use IPsec MB (OpenSSL 3.0 removed SHA*_Transform APIs)
+ * OpenSSL is only used for DOCSIS BPI cipher fallback (via EVP API)
+ */
 
 static int aes_ipsecmb_job(uint8_t *in, uint8_t *out, IMB_MGR *m,
 		const uint8_t *key, uint16_t auth_keylen)
@@ -1992,7 +1660,6 @@ static int qat_sym_do_precomputes_ipsec_mb(enum icp_qat_hw_auth_algo hash_alg,
 	free_mb_mgr(m);
 	return ret;
 }
-#endif
 
 static void
 qat_sym_session_init_common_hdr(struct qat_sym_session *session)
@@ -2482,16 +2149,9 @@ static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
 			break;
 		}
 		/* SHA-1 HMAC */
-#ifdef RTE_QAT_OPENSSL
-		ret = qat_sym_do_precomputes(ICP_QAT_HW_AUTH_ALGO_SHA1, authkey,
-			authkeylen, cdesc->cd_cur_ptr, &state1_size,
-			cdesc->aes_cmac);
-
-#else
 		ret = qat_sym_do_precomputes_ipsec_mb(ICP_QAT_HW_AUTH_ALGO_SHA1,
 			authkey, authkeylen, cdesc->cd_cur_ptr, &state1_size,
 			cdesc->aes_cmac);
-#endif
 
 		if (ret) {
 			QAT_LOG(ERR, "(SHA)precompute failed");
@@ -2509,15 +2169,9 @@ static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
 			break;
 		}
 		/* SHA-224 HMAC */
-#ifdef RTE_QAT_OPENSSL
-		ret = qat_sym_do_precomputes(ICP_QAT_HW_AUTH_ALGO_SHA224, authkey,
-			authkeylen, cdesc->cd_cur_ptr, &state1_size,
-			cdesc->aes_cmac);
-#else
 		ret = qat_sym_do_precomputes_ipsec_mb(ICP_QAT_HW_AUTH_ALGO_SHA224,
 			authkey, authkeylen, cdesc->cd_cur_ptr, &state1_size,
 			cdesc->aes_cmac);
-#endif
 		if (ret) {
 			QAT_LOG(ERR, "(SHA)precompute failed");
 			return -EFAULT;
@@ -2534,15 +2188,9 @@ static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
 			break;
 		}
 		/* SHA-256 HMAC */
-#ifdef RTE_QAT_OPENSSL
-		ret = qat_sym_do_precomputes(ICP_QAT_HW_AUTH_ALGO_SHA256, authkey,
-			authkeylen, cdesc->cd_cur_ptr, &state1_size,
-			cdesc->aes_cmac);
-#else
 		ret = qat_sym_do_precomputes_ipsec_mb(ICP_QAT_HW_AUTH_ALGO_SHA256,
 			authkey, authkeylen, cdesc->cd_cur_ptr, &state1_size,
 			cdesc->aes_cmac);
-#endif
 		if (ret) {
 			QAT_LOG(ERR, "(SHA)precompute failed");
 			return -EFAULT;
@@ -2559,15 +2207,9 @@ static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
 			break;
 		}
 		/* SHA-384 HMAC */
-#ifdef RTE_QAT_OPENSSL
-		ret = qat_sym_do_precomputes(ICP_QAT_HW_AUTH_ALGO_SHA384, authkey,
-			authkeylen, cdesc->cd_cur_ptr, &state1_size,
-			cdesc->aes_cmac);
-#else
 		ret = qat_sym_do_precomputes_ipsec_mb(ICP_QAT_HW_AUTH_ALGO_SHA384,
 			authkey, authkeylen, cdesc->cd_cur_ptr, &state1_size,
 			cdesc->aes_cmac);
-#endif
 		if (ret) {
 			QAT_LOG(ERR, "(SHA)precompute failed");
 			return -EFAULT;
@@ -2584,15 +2226,9 @@ static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
 			break;
 		}
 		/* SHA-512 HMAC */
-#ifdef RTE_QAT_OPENSSL
-		ret = qat_sym_do_precomputes(ICP_QAT_HW_AUTH_ALGO_SHA512, authkey,
-			authkeylen, cdesc->cd_cur_ptr, &state1_size,
-			cdesc->aes_cmac);
-#else
 		ret = qat_sym_do_precomputes_ipsec_mb(ICP_QAT_HW_AUTH_ALGO_SHA512,
 			authkey, authkeylen, cdesc->cd_cur_ptr, &state1_size,
 			cdesc->aes_cmac);
-#endif
 		if (ret) {
 			QAT_LOG(ERR, "(SHA)precompute failed");
 			return -EFAULT;
@@ -2628,16 +2264,10 @@ static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
 
 		if (cdesc->aes_cmac)
 			memset(cdesc->cd_cur_ptr, 0, state1_size);
-#ifdef RTE_QAT_OPENSSL
-		ret = qat_sym_do_precomputes(ICP_QAT_HW_AUTH_ALGO_AES_XCBC_MAC,
-			authkey, authkeylen, cdesc->cd_cur_ptr + state1_size,
-			&state2_size, cdesc->aes_cmac);
-#else
 		ret = qat_sym_do_precomputes_ipsec_mb(
 			ICP_QAT_HW_AUTH_ALGO_AES_XCBC_MAC,
 			authkey, authkeylen, cdesc->cd_cur_ptr + state1_size,
 			&state2_size, cdesc->aes_cmac);
-#endif
 		if (ret) {
 			QAT_LOG(ERR, "(%s)precompute failed",
 				cdesc->aes_cmac ? "CMAC" : "XCBC");
@@ -2654,15 +2284,9 @@ static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
 	case ICP_QAT_HW_AUTH_ALGO_GALOIS_64:
 		cdesc->qat_proto_flag = QAT_CRYPTO_PROTO_FLAG_GCM;
 		state1_size = ICP_QAT_HW_GALOIS_128_STATE1_SZ;
-#ifdef RTE_QAT_OPENSSL
-		ret = qat_sym_do_precomputes(cdesc->qat_hash_alg, authkey,
-			authkeylen, cdesc->cd_cur_ptr + state1_size,
-			&state2_size, cdesc->aes_cmac);
-#else
 		ret = qat_sym_do_precomputes_ipsec_mb(cdesc->qat_hash_alg, authkey,
 			authkeylen, cdesc->cd_cur_ptr + state1_size,
 			&state2_size, cdesc->aes_cmac);
-#endif
 		if (ret) {
 			QAT_LOG(ERR, "(GCM)precompute failed");
 			return -EFAULT;
@@ -2734,15 +2358,9 @@ static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
 		auth_param->hash_state_sz = ICP_QAT_HW_ZUC_256_IV_SZ >> 3;
 		break;
 	case ICP_QAT_HW_AUTH_ALGO_MD5:
-#ifdef RTE_QAT_OPENSSL
-		ret = qat_sym_do_precomputes(ICP_QAT_HW_AUTH_ALGO_MD5, authkey,
-			authkeylen, cdesc->cd_cur_ptr, &state1_size,
-			cdesc->aes_cmac);
-#else
 		ret = qat_sym_do_precomputes_ipsec_mb(ICP_QAT_HW_AUTH_ALGO_MD5,
 			authkey, authkeylen, cdesc->cd_cur_ptr, &state1_size,
 			cdesc->aes_cmac);
-#endif
 		if (ret) {
 			QAT_LOG(ERR, "(MD5)precompute failed");
 			return -EFAULT;
-- 
2.43.0

