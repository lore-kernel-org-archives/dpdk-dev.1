Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6143CC6B08
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 09:33:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F00840609;
	Tue, 13 Oct 2026 11:33:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 0BCD0400D6
 for <dev@dpdk.org>; Tue, 13 Oct 2026 11:33:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791884001; x=1823420001;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fDCbm2AXpdgEHiPAARmJjP+YXFZeHUxiEhjFizAZo5s=;
 b=Jnnsh2ETVwBFIOTdRt/+XaMPqJAxvm7QAaGjNBflMhnWgBCIezNFC2h9
 Bx/Yvu38re0zEK1rvfCOki/ewXJ2sVh+eCgAGPDh51g9XgayX5NKFKJIN
 AZWhIyqEV0Kfaj6cdKjDLGNM6kzPu02SdIymICgB0E2MnlcLlvbOmVLUy
 wVNWb7j5Kxal9XIJgfUlFb/2G7ooRnD5wYPQevzubo2FLwZirDcXqRcrN
 IE4t56ouVE3zub91ct0AcLbTfQqUeyIkFMGVea2nfKtkETxaoqP4W83YL
 9TCETIMAvhc8NKcW8rS3Luq91hlBXZTvv6E7R1OWCU3ei57jhxDMJp+0Q A==;
X-CSE-ConnectionGUID: DuFGBoKpT+qZ0fDvHaE6aw==
X-CSE-MsgGUID: NX3MAaKRSeK0Ojb/WJPaAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="494862"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="494862"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 02:33:20 -0700
X-CSE-ConnectionGUID: 4OgZxogMTTmHDYChd4h1WQ==
X-CSE-MsgGUID: L6nNEALwTPWGK9P4my6ayg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1477733"
Received: from silpixa00401454.ir.intel.com ([10.20.224.230])
 by fmviesa006.fm.intel.com with ESMTP; 13 Oct 2026 02:33:20 -0700
From: Emma Finn <emma.finn@intel.com>
To: Kai Ji <kai.ji@intel.com>, Pablo de Lara <pablo.de.lara.guarch@intel.com>
Cc: dev@dpdk.org,
	Emma Finn <emma.finn@intel.com>
Subject: [PATCH v3 1/2] crypto/ipsec_mb: Add SHA3 support.
Date: Tue, 13 Oct 2026 09:33:11 +0000
Message-ID: <20261013093312.817235-2-emma.finn@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013093312.817235-1-emma.finn@intel.com>
References: <20261012083506.754857-2-emma.finn@intel.com>
 <20261013093312.817235-1-emma.finn@intel.com>
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

Add SHA3-224, SHA3-256, SHA3-384, SHA3-512 and HMAC variants
to the ipsec_mb PMD.

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
 doc/guides/cryptodevs/aesni_mb.rst          |   8 +
 doc/guides/cryptodevs/features/aesni_mb.ini |   8 +
 doc/guides/rel_notes/release_26_11.rst      |   5 +
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c      |  30 +++
 drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h | 212 +++++++++++++++++++-
 5 files changed, 257 insertions(+), 6 deletions(-)

diff --git a/doc/guides/cryptodevs/aesni_mb.rst b/doc/guides/cryptodevs/aesni_mb.rst
index ab7a6138a8e..663b9f19d4b 100644
--- a/doc/guides/cryptodevs/aesni_mb.rst
+++ b/doc/guides/cryptodevs/aesni_mb.rst
@@ -61,6 +61,14 @@ Hash algorithms:
 * RTE_CRYPTO_AUTH_KASUMI_F9
 * RTE_CRYPTO_AUTH_SM3
 * RTE_CRYPTO_AUTH_SM3 HMAC
+* RTE_CRYPTO_AUTH_SHA3_224
+* RTE_CRYPTO_AUTH_SHA3_224 HMAC
+* RTE_CRYPTO_AUTH_SHA3_256
+* RTE_CRYPTO_AUTH_SHA3_256 HMAC
+* RTE_CRYPTO_AUTH_SHA3_384
+* RTE_CRYPTO_AUTH_SHA3_384 HMAC
+* RTE_CRYPTO_AUTH_SHA3_512
+* RTE_CRYPTO_AUTH_SHA3_512 HMAC
 
 AEAD algorithms:
 
diff --git a/doc/guides/cryptodevs/features/aesni_mb.ini b/doc/guides/cryptodevs/features/aesni_mb.ini
index ce6b43e48bd..73bb9f42633 100644
--- a/doc/guides/cryptodevs/features/aesni_mb.ini
+++ b/doc/guides/cryptodevs/features/aesni_mb.ini
@@ -69,6 +69,14 @@ SNOW3G UIA2  = Y
 KASUMI F9    = Y
 SM3          = Y
 SM3 HMAC     = Y
+SHA3_224     = Y
+SHA3_224 HMAC = Y
+SHA3_256     = Y
+SHA3_256 HMAC = Y
+SHA3_384     = Y
+SHA3_384 HMAC = Y
+SHA3_512     = Y
+SHA3_512 HMAC = Y
 
 ;
 ; Supported AEAD algorithms of the 'aesni_mb' crypto driver.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295da..826a0cf05cf 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -24,6 +24,11 @@ DPDK Release 26.11
 New Features
 ------------
 
+* **Updated AESNI_MB crypto driver.**
+
+  * Added support for SHA3-224, SHA3-256, SHA3-384, and SHA3-512 hash
+    algorithms and their HMAC variants.
+
 .. This section should contain new features added in this release.
    Sample format:
 
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
index 4c5b6e70b51..c96d1453b8c 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -302,6 +302,36 @@ aesni_mb_set_session_auth_parameters(IMB_MGR *mb_mgr,
 	case RTE_CRYPTO_AUTH_SM3_HMAC:
 		sess->template_job.hash_alg = IMB_AUTH_HMAC_SM3;
 		break;
+#endif
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+	case RTE_CRYPTO_AUTH_SHA3_224:
+		sess->template_job.hash_alg = IMB_AUTH_SHA3_224;
+		auth_precompute = 0;
+		break;
+	case RTE_CRYPTO_AUTH_SHA3_224_HMAC:
+		sess->template_job.hash_alg = IMB_AUTH_HMAC_SHA3_224;
+		break;
+	case RTE_CRYPTO_AUTH_SHA3_256:
+		sess->template_job.hash_alg = IMB_AUTH_SHA3_256;
+		auth_precompute = 0;
+		break;
+	case RTE_CRYPTO_AUTH_SHA3_256_HMAC:
+		sess->template_job.hash_alg = IMB_AUTH_HMAC_SHA3_256;
+		break;
+	case RTE_CRYPTO_AUTH_SHA3_384:
+		sess->template_job.hash_alg = IMB_AUTH_SHA3_384;
+		auth_precompute = 0;
+		break;
+	case RTE_CRYPTO_AUTH_SHA3_384_HMAC:
+		sess->template_job.hash_alg = IMB_AUTH_HMAC_SHA3_384;
+		break;
+	case RTE_CRYPTO_AUTH_SHA3_512:
+		sess->template_job.hash_alg = IMB_AUTH_SHA3_512;
+		auth_precompute = 0;
+		break;
+	case RTE_CRYPTO_AUTH_SHA3_512_HMAC:
+		sess->template_job.hash_alg = IMB_AUTH_HMAC_SHA3_512;
+		break;
 #endif
 	default:
 		IPSEC_MB_LOG(ERR,
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
index 6dc90a98492..aad31b9f909 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
@@ -768,6 +768,176 @@ static const struct rte_cryptodev_capabilities aesni_mb_capabilities[] = {
 			}, }
 		}, }
 	},
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+	{	/* SHA3-224 */
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
+					.min = 1,
+					.max = 28,
+					.increment = 1
+				},
+				.iv_size = { 0 }
+			}, }
+		}, }
+	},
+	{	/* HMAC SHA3-224 */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_SHA3_224_HMAC,
+				.block_size = 144,
+				.key_size = {
+					.min = 1,
+					.max = 65535,
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
+	{	/* SHA3-256 */
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
+					.min = 1,
+					.max = 32,
+					.increment = 1
+				},
+				.iv_size = { 0 }
+			}, }
+		}, }
+	},
+	{	/* HMAC SHA3-256 */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_SHA3_256_HMAC,
+				.block_size = 136,
+				.key_size = {
+					.min = 1,
+					.max = 65535,
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
+	{	/* SHA3-384 */
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
+					.min = 1,
+					.max = 48,
+					.increment = 1
+				},
+				.iv_size = { 0 }
+			}, }
+		}, }
+	},
+	{	/* HMAC SHA3-384 */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_SHA3_384_HMAC,
+				.block_size = 104,
+				.key_size = {
+					.min = 1,
+					.max = 65535,
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
+	{	/* SHA3-512 */
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
+					.min = 1,
+					.max = 64,
+					.increment = 1
+				},
+				.iv_size = { 0 }
+			}, }
+		}, }
+	},
+	{	/* HMAC SHA3-512 */
+		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+		{.sym = {
+			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			{.auth = {
+				.algo = RTE_CRYPTO_AUTH_SHA3_512_HMAC,
+				.block_size = 72,
+				.key_size = {
+					.min = 1,
+					.max = 65535,
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
+#endif
 	{	/* SM4 CBC */
 		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
 		{.sym = {
@@ -894,7 +1064,17 @@ static const unsigned int auth_blocksize[] = {
 		[IMB_AUTH_SHA_512]		= 128,
 		[IMB_AUTH_ZUC_EIA3_BITLEN]	= 16,
 		[IMB_AUTH_SNOW3G_UIA2_BITLEN]	= 16,
-		[IMB_AUTH_KASUMI_UIA1]		= 16
+		[IMB_AUTH_KASUMI_UIA1]		= 16,
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+		[IMB_AUTH_SHA3_224]		= 144,
+		[IMB_AUTH_SHA3_256]		= 136,
+		[IMB_AUTH_SHA3_384]		= 104,
+		[IMB_AUTH_SHA3_512]		= 72,
+		[IMB_AUTH_HMAC_SHA3_224]	= 144,
+		[IMB_AUTH_HMAC_SHA3_256]	= 136,
+		[IMB_AUTH_HMAC_SHA3_384]	= 104,
+		[IMB_AUTH_HMAC_SHA3_512]	= 72
+#endif
 };
 
 /**
@@ -928,7 +1108,17 @@ static const unsigned int auth_truncated_digest_byte_lengths[] = {
 		[IMB_AUTH_SHA_512]		= 64,
 		[IMB_AUTH_ZUC_EIA3_BITLEN]	= 4,
 		[IMB_AUTH_SNOW3G_UIA2_BITLEN]	= 4,
-		[IMB_AUTH_KASUMI_UIA1]		= 4
+		[IMB_AUTH_KASUMI_UIA1]		= 4,
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+		[IMB_AUTH_SHA3_224]		= 28,
+		[IMB_AUTH_SHA3_256]		= 32,
+		[IMB_AUTH_SHA3_384]		= 48,
+		[IMB_AUTH_SHA3_512]		= 64,
+		[IMB_AUTH_HMAC_SHA3_224]	= 28,
+		[IMB_AUTH_HMAC_SHA3_256]	= 32,
+		[IMB_AUTH_HMAC_SHA3_384]	= 48,
+		[IMB_AUTH_HMAC_SHA3_512]	= 64
+#endif
 };
 
 /**
@@ -967,6 +1157,16 @@ static const unsigned int auth_digest_byte_lengths[] = {
 #if IMB_VERSION(1, 5, 0) <= IMB_VERSION_NUM
 		[IMB_AUTH_SM3]			= 32,
 		[IMB_AUTH_HMAC_SM3]		= 32,
+#endif
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+		[IMB_AUTH_SHA3_224]		= 28,
+		[IMB_AUTH_SHA3_256]		= 32,
+		[IMB_AUTH_SHA3_384]		= 48,
+		[IMB_AUTH_SHA3_512]		= 64,
+		[IMB_AUTH_HMAC_SHA3_224]	= 28,
+		[IMB_AUTH_HMAC_SHA3_256]	= 32,
+		[IMB_AUTH_HMAC_SHA3_384]	= 48,
+		[IMB_AUTH_HMAC_SHA3_512]	= 64
 #endif
 	/**< Vector mode dependent pointer table of the multi-buffer APIs */
 
@@ -1049,15 +1249,15 @@ struct __rte_cache_aligned aesni_mb_session {
 		/* *< auth operation generate or verify */
 		union {
 			struct {
-				alignas(16) uint8_t inner[128];
+				alignas(16) uint8_t inner[144];
 				/* *< inner pad */
-				alignas(16) uint8_t outer[128];
+				alignas(16) uint8_t outer[144];
 				/* *< outer pad */
 			} pads;
 			/* *< HMAC Authentication pads -
 			 * allocating space for the maximum pad
-			 * size supported which is 128 bytes for
-			 * SHA512
+			 * size supported which is 144 bytes for
+			 * SHA3-224
 			 */
 
 			struct {
-- 
2.43.0

