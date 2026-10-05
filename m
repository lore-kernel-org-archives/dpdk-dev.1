Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93093CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 12:30:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAF454028D;
	Mon,  5 Oct 2026 14:30:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 15D0A4028C
 for <dev@dpdk.org>; Mon,  5 Oct 2026 14:30:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791203452; x=1822739452;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BCYL1Piy5AxQkEMSJLBa9nwSD1H+7ahjL27cjN7iEoY=;
 b=Q0ruxQRf/eFY4oANMk9cqk2Zx2lqyLfEhsJiZT/RoQGNv+Ib95Dcp5ZX
 YVJ34s0YguHnQxbsGmmrdsOkXdX4+3dn1xtzplvAbLp45e1aqCPwPkwc2
 BBKcCqvxpko4Imm4dY+NAjltTnraRvrtK0Y6YpHpoglji50gj9mSxK2KH
 lt4gwBPcB7nrQzBAURjVPRjPaavSBKpUP/byH9eIJL2fdCs5NJH/eXS4/
 MBdiskoxBNu9OvffJzTayAdJ3b+5EWmuKbbbyrtBLAxkKw2AMODJ3leDG
 zZJdFySFlv+foCuKBsgLVASViGaGDOs/CcJWsqJeGwduWQzaACLCKRgmc A==;
X-CSE-ConnectionGUID: fU0Po84XS72caA8xMaxHEQ==
X-CSE-MsgGUID: ZVdjFr/ITFSeBgCORIKPGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="18874"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="18874"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 05:30:51 -0700
X-CSE-ConnectionGUID: SalRCQKiTZGuIgqnz1CBqA==
X-CSE-MsgGUID: t2F7hfkLQNeMNau5vNql3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="826120"
Received: from silpixa00401454.ir.intel.com ([10.20.224.230])
 by fmviesa013.fm.intel.com with ESMTP; 05 Oct 2026 05:30:50 -0700
From: Emma Finn <emma.finn@intel.com>
To: Kai Ji <kai.ji@intel.com>, Pablo de Lara <pablo.de.lara.guarch@intel.com>
Cc: dev@dpdk.org,
	Emma Finn <emma.finn@intel.com>
Subject: [PATCH 1/2] crypto/ipsec_mb: Add SHA3 support.
Date: Mon,  5 Oct 2026 12:30:39 +0000
Message-ID: <20261005123041.429121-1-emma.finn@intel.com>
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

Add SHA3-224, SHA3-256, SHA3-384, SHA3-512 and HMAC variants
to the ipsec_mb PMD.

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
 doc/guides/cryptodevs/aesni_mb.rst          |   8 +
 doc/guides/cryptodevs/features/aesni_mb.ini |   8 +
 doc/guides/rel_notes/release_26_11.rst      |   5 +
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c      |  29 +++
 drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h | 219 +++++++++++++++++++-
 5 files changed, 259 insertions(+), 10 deletions(-)

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
index ce6b43e48bd..ff7fcceb036 100644
--- a/doc/guides/cryptodevs/features/aesni_mb.ini
+++ b/doc/guides/cryptodevs/features/aesni_mb.ini
@@ -69,6 +69,14 @@ SNOW3G UIA2  = Y
 KASUMI F9    = Y
 SM3          = Y
 SM3 HMAC     = Y
+SHA3-224     = Y
+SHA3-224 HMAC = Y
+SHA3-256     = Y
+SHA3-256 HMAC = Y
+SHA3-384     = Y
+SHA3-384 HMAC = Y
+SHA3-512     = Y
+SHA3-512 HMAC = Y
 
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
index 4c5b6e70b51..a63f9671528 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -302,6 +302,35 @@ aesni_mb_set_session_auth_parameters(IMB_MGR *mb_mgr,
 	case RTE_CRYPTO_AUTH_SM3_HMAC:
 		sess->template_job.hash_alg = IMB_AUTH_HMAC_SM3;
 		break;
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
index 6dc90a98492..6fdb4b8e1fb 100644
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
@@ -892,9 +1062,19 @@ static const unsigned int auth_blocksize[] = {
 		[IMB_AUTH_SHA_256]		= 64,
 		[IMB_AUTH_SHA_384]		= 128,
 		[IMB_AUTH_SHA_512]		= 128,
-		[IMB_AUTH_ZUC_EIA3_BITLEN]	= 16,
-		[IMB_AUTH_SNOW3G_UIA2_BITLEN]	= 16,
-		[IMB_AUTH_KASUMI_UIA1]		= 16
+		[IMB_AUTH_ZUC_EIA3]		= 16,
+		[IMB_AUTH_SNOW3G_UIA2]	= 16,
+		[IMB_AUTH_KASUMI_UIA1]	= 16,
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
@@ -926,9 +1106,19 @@ static const unsigned int auth_truncated_digest_byte_lengths[] = {
 		[IMB_AUTH_SHA_256]		= 32,
 		[IMB_AUTH_SHA_384]		= 48,
 		[IMB_AUTH_SHA_512]		= 64,
-		[IMB_AUTH_ZUC_EIA3_BITLEN]	= 4,
-		[IMB_AUTH_SNOW3G_UIA2_BITLEN]	= 4,
-		[IMB_AUTH_KASUMI_UIA1]		= 4
+		[IMB_AUTH_ZUC_EIA3]		= 4,
+		[IMB_AUTH_SNOW3G_UIA2]	= 4,
+		[IMB_AUTH_KASUMI_UIA1]	= 4,
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
@@ -967,6 +1157,15 @@ static const unsigned int auth_digest_byte_lengths[] = {
 #if IMB_VERSION(1, 5, 0) <= IMB_VERSION_NUM
 		[IMB_AUTH_SM3]			= 32,
 		[IMB_AUTH_HMAC_SM3]		= 32,
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
 
@@ -1049,15 +1248,15 @@ struct __rte_cache_aligned aesni_mb_session {
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

