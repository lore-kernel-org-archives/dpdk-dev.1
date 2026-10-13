Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058E7CC6B08
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 09:33:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD0A740612;
	Tue, 13 Oct 2026 11:33:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 422C040609
 for <dev@dpdk.org>; Tue, 13 Oct 2026 11:33:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791884002; x=1823420002;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1w8fUCEI3Qv43CjP7oVLbuKGTSpT6htN6TYRqYUAefU=;
 b=GdBHJaPr8e46tjklGLJKrshpvodJPZzElsDJ5TgOW2jq+GrVbwh6U7iQ
 PYOWQcG4LZ7WSYsAusRBtmPOcuFvv8PxZo8Uy1wcorzcGZj9DvN2Q1L37
 WMmM/Sf4VjlnKxliNag2JUlWb88X1upQgetjsz0CcEIWozb+MBx5f0iIn
 fGkDQB+xIdQB3eXckq6UbAcrAg4mM1D5NzmqwpiUzp0yPwRJ9xf1f/DSM
 9YbFdF1lLJRvx+OP5WxOg8L0VjPOrgANiq8boc0KdJLo3Zg8dJjLj/zbb
 TkZ1QMUrP5grhSH9C7eVLUeF/Trzr5rUJoBramkOliFW00qv/rSauvnTZ g==;
X-CSE-ConnectionGUID: xqLazQlDTQaj2I/1T7PETw==
X-CSE-MsgGUID: SvqwVcA4TVaRGVBgU9yh+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="494864"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="494864"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 02:33:21 -0700
X-CSE-ConnectionGUID: 0KKIgRMtR4eBEWOSTGRTow==
X-CSE-MsgGUID: 3KZCqrefQ5CPEQTqpBOURA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1477736"
Received: from silpixa00401454.ir.intel.com ([10.20.224.230])
 by fmviesa006.fm.intel.com with ESMTP; 13 Oct 2026 02:33:21 -0700
From: Emma Finn <emma.finn@intel.com>
To: Kai Ji <kai.ji@intel.com>, Pablo de Lara <pablo.de.lara.guarch@intel.com>
Cc: dev@dpdk.org,
	Emma Finn <emma.finn@intel.com>
Subject: [PATCH v3 2/2] crypto/ipsec_mb: Add SHAKE support.
Date: Tue, 13 Oct 2026 09:33:12 +0000
Message-ID: <20261013093312.817235-3-emma.finn@intel.com>
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

Add SHAKE-128 and SHAKE-256 support to
ipsec_mb PMD.

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
 doc/guides/cryptodevs/aesni_mb.rst          |  2 +
 doc/guides/cryptodevs/features/aesni_mb.ini |  2 +
 doc/guides/rel_notes/release_26_11.rst      |  1 +
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c      |  8 +++
 drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h | 54 +++++++++++++++++++--
 5 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/doc/guides/cryptodevs/aesni_mb.rst b/doc/guides/cryptodevs/aesni_mb.rst
index 663b9f19d4b..da37d54471e 100644
--- a/doc/guides/cryptodevs/aesni_mb.rst
+++ b/doc/guides/cryptodevs/aesni_mb.rst
@@ -69,6 +69,8 @@ Hash algorithms:
 * RTE_CRYPTO_AUTH_SHA3_384 HMAC
 * RTE_CRYPTO_AUTH_SHA3_512
 * RTE_CRYPTO_AUTH_SHA3_512 HMAC
+* RTE_CRYPTO_AUTH_SHAKE_128
+* RTE_CRYPTO_AUTH_SHAKE_256
 
 AEAD algorithms:
 
diff --git a/doc/guides/cryptodevs/features/aesni_mb.ini b/doc/guides/cryptodevs/features/aesni_mb.ini
index 73bb9f42633..18109ffe05d 100644
--- a/doc/guides/cryptodevs/features/aesni_mb.ini
+++ b/doc/guides/cryptodevs/features/aesni_mb.ini
@@ -77,6 +77,8 @@ SHA3_384     = Y
 SHA3_384 HMAC = Y
 SHA3_512     = Y
 SHA3_512 HMAC = Y
+SHAKE_128    = Y
+SHAKE_256    = Y
 
 ;
 ; Supported AEAD algorithms of the 'aesni_mb' crypto driver.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 826a0cf05cf..c116f3373da 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -28,6 +28,7 @@ New Features
 
   * Added support for SHA3-224, SHA3-256, SHA3-384, and SHA3-512 hash
     algorithms and their HMAC variants.
+  * Added support for SHAKE-128 and SHAKE-256 hash algorithms.
 
 .. This section should contain new features added in this release.
    Sample format:
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
index c96d1453b8c..adfc39b9569 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -332,6 +332,14 @@ aesni_mb_set_session_auth_parameters(IMB_MGR *mb_mgr,
 	case RTE_CRYPTO_AUTH_SHA3_512_HMAC:
 		sess->template_job.hash_alg = IMB_AUTH_HMAC_SHA3_512;
 		break;
+	case RTE_CRYPTO_AUTH_SHAKE_128:
+		sess->template_job.hash_alg = IMB_AUTH_SHAKE128;
+		auth_precompute = 0;
+		break;
+	case RTE_CRYPTO_AUTH_SHAKE_256:
+		sess->template_job.hash_alg = IMB_AUTH_SHAKE256;
+		auth_precompute = 0;
+		break;
 #endif
 	default:
 		IPSEC_MB_LOG(ERR,
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
index aad31b9f909..74accab99a1 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
@@ -937,6 +937,48 @@ static const struct rte_cryptodev_capabilities aesni_mb_capabilities[] = {
 			}, }
 		}, }
 	},
+	{	/* SHAKE-128 */
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
+					.max = 64,
+					.increment = 1
+				},
+				.iv_size = { 0 }
+			}, }
+		}, }
+	},
+	{	/* SHAKE-256 */
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
+					.max = 64,
+					.increment = 1
+				},
+				.iv_size = { 0 }
+			}, }
+		}, }
+	},
 #endif
 	{	/* SM4 CBC */
 		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
@@ -1073,7 +1115,9 @@ static const unsigned int auth_blocksize[] = {
 		[IMB_AUTH_HMAC_SHA3_224]	= 144,
 		[IMB_AUTH_HMAC_SHA3_256]	= 136,
 		[IMB_AUTH_HMAC_SHA3_384]	= 104,
-		[IMB_AUTH_HMAC_SHA3_512]	= 72
+		[IMB_AUTH_HMAC_SHA3_512]	= 72,
+		[IMB_AUTH_SHAKE128]		= 168,
+		[IMB_AUTH_SHAKE256]		= 136
 #endif
 };
 
@@ -1117,7 +1161,9 @@ static const unsigned int auth_truncated_digest_byte_lengths[] = {
 		[IMB_AUTH_HMAC_SHA3_224]	= 28,
 		[IMB_AUTH_HMAC_SHA3_256]	= 32,
 		[IMB_AUTH_HMAC_SHA3_384]	= 48,
-		[IMB_AUTH_HMAC_SHA3_512]	= 64
+		[IMB_AUTH_HMAC_SHA3_512]	= 64,
+		[IMB_AUTH_SHAKE128]		= 64,
+		[IMB_AUTH_SHAKE256]		= 64
 #endif
 };
 
@@ -1166,7 +1212,9 @@ static const unsigned int auth_digest_byte_lengths[] = {
 		[IMB_AUTH_HMAC_SHA3_224]	= 28,
 		[IMB_AUTH_HMAC_SHA3_256]	= 32,
 		[IMB_AUTH_HMAC_SHA3_384]	= 48,
-		[IMB_AUTH_HMAC_SHA3_512]	= 64
+		[IMB_AUTH_HMAC_SHA3_512]	= 64,
+		[IMB_AUTH_SHAKE128]		= 64,
+		[IMB_AUTH_SHAKE256]		= 64
 #endif
 	/**< Vector mode dependent pointer table of the multi-buffer APIs */
 
-- 
2.43.0

