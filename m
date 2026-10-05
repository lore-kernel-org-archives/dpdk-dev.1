Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66651CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 12:31:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE7AB4065A;
	Mon,  5 Oct 2026 14:30:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id E65A24029D
 for <dev@dpdk.org>; Mon,  5 Oct 2026 14:30:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791203454; x=1822739454;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=t+bCD9SjS7PZywZgNX9w1X5g+t+cJ1ikpicUd7x6xl4=;
 b=aZNknsga1nVzvbv7m5dL6UVOA+4bTbyEOPAAp020ySRhJoZZTj/uEjUD
 HSmMDDFFzHuvXJwzUE6uGNMEbmgMwypDFlCCq+od3sMzB9p5g13Vacqvc
 H58tVKD5ADcdOc5IXSj2jarQIjR4TNzwVNgV1PjFj5YO1uJEpZ1WPSSsP
 xc4yfNxMJ+M1M0EnMfiSFu52u3+cn7nTAY9vjepOn8K7w9S+ZJkd2/5IF
 jjR+AKQ2F+ZMARX4nI/qKmJb4L8PB/qnVgvF96McLtQX3Ag2OwNJ8YFXV
 IhsDSBAoUmnfcg2PgqPYuqwMJPTMhUV8n+8ZCwGGh7OU3DHuSEPZlOb0Y w==;
X-CSE-ConnectionGUID: x9gdL/yaRay84I1rzAU/Yg==
X-CSE-MsgGUID: GOXD57ReRCqPTgjEp+e/wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="18878"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="18878"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 05:30:53 -0700
X-CSE-ConnectionGUID: mzZ416X7R/uvOBKhVfX9Hg==
X-CSE-MsgGUID: uiaFbMV/QtK+eRyoKOnMmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="826137"
Received: from silpixa00401454.ir.intel.com ([10.20.224.230])
 by fmviesa013.fm.intel.com with ESMTP; 05 Oct 2026 05:30:53 -0700
From: Emma Finn <emma.finn@intel.com>
To: Kai Ji <kai.ji@intel.com>, Pablo de Lara <pablo.de.lara.guarch@intel.com>
Cc: dev@dpdk.org,
	Emma Finn <emma.finn@intel.com>
Subject: [PATCH 2/2] crypto/ipsec_mb: Add SHAKE support.
Date: Mon,  5 Oct 2026 12:30:40 +0000
Message-ID: <20261005123041.429121-2-emma.finn@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005123041.429121-1-emma.finn@intel.com>
References: <20261005123041.429121-1-emma.finn@intel.com>
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
index ff7fcceb036..dca241b7f34 100644
--- a/doc/guides/cryptodevs/features/aesni_mb.ini
+++ b/doc/guides/cryptodevs/features/aesni_mb.ini
@@ -77,6 +77,8 @@ SHA3-384     = Y
 SHA3-384 HMAC = Y
 SHA3-512     = Y
 SHA3-512 HMAC = Y
+SHAKE-128    = Y
+SHAKE-256    = Y
 
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
index a63f9671528..d9d7366da39 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -331,6 +331,14 @@ aesni_mb_set_session_auth_parameters(IMB_MGR *mb_mgr,
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
index 6fdb4b8e1fb..25dc7151b09 100644
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
+					.max = 65535,
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
+					.max = 65535,
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
 
@@ -1165,7 +1211,9 @@ static const unsigned int auth_digest_byte_lengths[] = {
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

