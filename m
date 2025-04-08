Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1600AC3600C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 11:08:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F176640A89;
	Tue,  8 Apr 2025 13:08:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 080D24027F
 for <dev@dpdk.org>; Tue,  8 Apr 2025 13:08:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744110537; x=1775646537;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bawYjlvIdk3jK+Q91mfb0Hr3puc0pU3t7EuaqHN6Njs=;
 b=JgClSSlXAkr2k/f9MRoaXr9OO3cnZElC85NtCZ6ei09yNtOEb2XE2I95
 BOlCtv/hOcECcW7Hojlxwpz5aRKHbtewVJQJDTiUEa/NYffC+APSNZsQM
 tfEG+RWhrkdI3u1ZRGm266yOaSONPQ5oPrZMNgBI0s85p2+74yID4MEWm
 eZfWw/k40XGHQTX3k3gu3ONpP5Kt+ClgLZCjdAjHl1hufHGQKSEuPvGbB
 Ha2GRQ7lPNgpGdpx52QmQbaN1XX5y/+XGeEM7MRVsBZjcLJTLRwM68+ZA
 68ZKa3vTOq992TKAQo9C4xrA8FX4kEIX3ASDeu4s38Nt9Y7DxVXMsTxS/ Q==;
X-CSE-ConnectionGUID: Riw+9jDgSu+0zI6GJVGpwA==
X-CSE-MsgGUID: M//phU97T6CXH1akqelp3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="68009827"
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; d="scan'208";a="68009827"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 04:08:56 -0700
X-CSE-ConnectionGUID: KpJXO/rTSdatVZ9Ek+qtXA==
X-CSE-MsgGUID: EWdGBjO3SKGfPQ/geXzMxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; d="scan'208";a="128128473"
Received: from silpixa00400884.ir.intel.com ([10.243.22.90])
 by orviesa010.jf.intel.com with ESMTP; 08 Apr 2025 04:08:55 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: Akhil Goyal <gakhil@marvell.com>,
	Fan Zhang <fanzhang.oss@gmail.com>
Cc: dev@dpdk.org,
	kai.ji@intel.com,
	Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH] cryptodev: add SNOW-V algorithms
Date: Tue,  8 Apr 2025 12:08:51 +0100
Message-ID: <20250408110851.2952910-1-radu.nicolau@intel.com>
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

Add SNOW-V and SNOW-V AEAD mode algorithms to cryptodev API.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 lib/cryptodev/rte_crypto_sym.h | 17 ++++++++++++-----
 lib/cryptodev/rte_cryptodev.c  |  4 +++-
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/lib/cryptodev/rte_crypto_sym.h b/lib/cryptodev/rte_crypto_sym.h
index 6268bab327..d6033ac4a1 100644
--- a/lib/cryptodev/rte_crypto_sym.h
+++ b/lib/cryptodev/rte_crypto_sym.h
@@ -178,8 +178,11 @@ enum rte_crypto_cipher_algorithm {
 	/**< ShangMi 4 (SM4) algorithm in OFB mode */
 	RTE_CRYPTO_CIPHER_SM4_CFB,
 	/**< ShangMi 4 (SM4) algorithm in CFB mode */
-	RTE_CRYPTO_CIPHER_SM4_XTS
+	RTE_CRYPTO_CIPHER_SM4_XTS,
 	/**< ShangMi 4 (SM4) algorithm in XTS mode */
+
+	RTE_CRYPTO_CIPHER_SNOW_V,
+	/**< SNOW V algorithm */
 };
 
 /** Symmetric Cipher Direction */
@@ -486,6 +489,8 @@ enum rte_crypto_aead_algorithm {
 	/**< Chacha20 cipher with poly1305 authenticator */
 	RTE_CRYPTO_AEAD_SM4_GCM,
 	/**< SM4 cipher in GCM mode */
+	RTE_CRYPTO_AEAD_SNOW_V,
+	/**< SNOW V algorithm in GCM mode */
 };
 
 /** Symmetric AEAD Operations */
@@ -714,8 +719,9 @@ struct rte_crypto_sym_op {
 					  *
 					  * @note
 					  * For SNOW 3G @ RTE_CRYPTO_CIPHER_SNOW3G_UEA2,
-					  * KASUMI @ RTE_CRYPTO_CIPHER_KASUMI_F8
-					  * and ZUC @ RTE_CRYPTO_CIPHER_ZUC_EEA3,
+					  * KASUMI @ RTE_CRYPTO_CIPHER_KASUMI_F8,
+					  * ZUC @ RTE_CRYPTO_CIPHER_ZUC_EEA3 and
+					  * SNOW V @ RTE_CRYPTO_CIPHER_SNOW_V
 					  * this field should be in bits. For
 					  * digest-encrypted cases this must be
 					  * an 8-bit multiple.
@@ -732,8 +738,9 @@ struct rte_crypto_sym_op {
 					  *
 					  * @note
 					  * For SNOW 3G @ RTE_CRYPTO_AUTH_SNOW3G_UEA2,
-					  * KASUMI @ RTE_CRYPTO_CIPHER_KASUMI_F8
-					  * and ZUC @ RTE_CRYPTO_CIPHER_ZUC_EEA3,
+					  * KASUMI @ RTE_CRYPTO_CIPHER_KASUMI_F8,
+					  * ZUC @ RTE_CRYPTO_CIPHER_ZUC_EEA3 and
+					  * SNOW V @ RTE_CRYPTO_CIPHER_SNOW_V
 					  * this field should be in bits. For
 					  * digest-encrypted cases this must be
 					  * an 8-bit multiple.
diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.c
index bb7bab4dd5..ae44c5f385 100644
--- a/lib/cryptodev/rte_cryptodev.c
+++ b/lib/cryptodev/rte_cryptodev.c
@@ -102,7 +102,8 @@ crypto_cipher_algorithm_strings[] = {
 	[RTE_CRYPTO_CIPHER_SM4_CTR]	= "sm4-ctr",
 	[RTE_CRYPTO_CIPHER_SM4_CFB]	= "sm4-cfb",
 	[RTE_CRYPTO_CIPHER_SM4_OFB]	= "sm4-ofb",
-	[RTE_CRYPTO_CIPHER_SM4_XTS]	= "sm4-xts"
+	[RTE_CRYPTO_CIPHER_SM4_XTS]	= "sm4-xts",
+	[RTE_CRYPTO_CIPHER_SNOW_V]	= "snow-v",
 };
 
 /**
@@ -175,6 +176,7 @@ crypto_aead_algorithm_strings[] = {
 	[RTE_CRYPTO_AEAD_AES_GCM]	= "aes-gcm",
 	[RTE_CRYPTO_AEAD_CHACHA20_POLY1305] = "chacha20-poly1305",
 	[RTE_CRYPTO_AEAD_SM4_GCM]   = "sm4-gcm",
+	[RTE_CRYPTO_AEAD_SNOW_V]   = "snow-v-aead",
 };
 
 
-- 
2.43.0

