Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD07EC44500
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 10:26:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 920D54027A;
	Thu, 22 Jan 2026 11:26:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 859A240156
 for <dev@dpdk.org>; Thu, 22 Jan 2026 11:26:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769077571; x=1800613571;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cXL/kwHuVmNODqVo6UNLbhliO0RjnlMpduj0SnRZXOY=;
 b=GBQxZEuDEX91cGuF0+tD6HH02e6qF7CqdtpqgfoH5ROFg8bQ4/DJIB93
 DiY4RlqWh0HqscLkrQe49+4bYBNqcUgVc0s+EReP0NGxFD/kY5R45Akgn
 lo3U3tgv4ZN84qzKC0xasMAG9o4DqLHA8q9MVLCy67SwO1Ghh8ZGOnf8h
 m6VJYueE7chaXGMwYvt8/O+RBD3fpFpo46fVxTdqcAoSen6iWiiOjpC/b
 uQA261GNF9CWwaDWe6mUb8anXT6jTrrGhxRZYmJdSvKwiZwd2I4v7hAoD
 N7tj8o/NJ4yQQ55lXMmxwfl0TxFmBszqyW9VoGti6vu4AjAeE5Nx52giD Q==;
X-CSE-ConnectionGUID: qV75PYUmT+m1hLIeSXHqbA==
X-CSE-MsgGUID: sei2Ur7sQZmJIj3/UB4I2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="81034763"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; d="scan'208";a="81034763"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 02:26:10 -0800
X-CSE-ConnectionGUID: MZmZTKNgQX6q5XnSqjW5NA==
X-CSE-MsgGUID: sSFjAFcTT/GbfDSI98/Kjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; d="scan'208";a="211554608"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by fmviesa004.fm.intel.com with ESMTP; 22 Jan 2026 02:26:08 -0800
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: nkaithakadan@marvell.com, kai.ji@intel.com, anoobj@marvell.com,
 stephen@networkplumber.org, Radu Nicolau <radu.nicolau@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH v5 1/2] cryptodev: add support for 256-NxA4/5/6 algorithms
Date: Thu, 22 Jan 2026 10:25:33 +0000
Message-ID: <20260122102606.2531599-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107105649.1708347-1-radu.nicolau@intel.com>
References: <20260107105649.1708347-1-radu.nicolau@intel.com>
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

Add support for

NEA4, NIA4, NCA4: Snow 5G confidentiality, integrity and AEAD modes
NEA5, NIA5, NCA5: AES 256 confidentiality, integrity and AEAD modes
NEA6, NIA6, NCA6: ZUC 256 confidentiality, integrity and AEAD modes

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 doc/guides/cryptodevs/features/default.ini |  9 ++++
 lib/cryptodev/rte_crypto_sym.h             | 52 ++++++++++++++++++----
 lib/cryptodev/rte_cryptodev.c              | 13 +++++-
 3 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/doc/guides/cryptodevs/features/default.ini b/doc/guides/cryptodevs/features/default.ini
index 64198f013a..d8026c3750 100644
--- a/doc/guides/cryptodevs/features/default.ini
+++ b/doc/guides/cryptodevs/features/default.ini
@@ -68,6 +68,9 @@ SM4 CTR        =
 SM4 CFB        =
 SM4 OFB        =
 SM4 XTS        =
+SNOW5G NEA4    =
+AES NEA5       =
+ZUC-256 NEA6   =
 
 ;
 ; Supported authentication algorithms of a default crypto driver.
@@ -106,6 +109,9 @@ SM3             =
 SM3 HMAC        =
 SHAKE_128       =
 SHAKE_256       =
+SNOW5G NIA4     =
+AES NIA5        =
+ZUC-256 NIA6    =
 
 ;
 ; Supported AEAD algorithms of a default crypto driver.
@@ -119,6 +125,9 @@ AES CCM (192)     =
 AES CCM (256)     =
 CHACHA20-POLY1305 =
 SM4 GCM           =
+SNOW5G NCA4       =
+AES NCA5          =
+ZUC-256 NCA6      =
 
 ;
 ; Supported Asymmetric algorithms of a default crypto driver.
diff --git a/lib/cryptodev/rte_crypto_sym.h b/lib/cryptodev/rte_crypto_sym.h
index 6268bab327..630fd153bd 100644
--- a/lib/cryptodev/rte_crypto_sym.h
+++ b/lib/cryptodev/rte_crypto_sym.h
@@ -178,8 +178,15 @@ enum rte_crypto_cipher_algorithm {
 	/**< ShangMi 4 (SM4) algorithm in OFB mode */
 	RTE_CRYPTO_CIPHER_SM4_CFB,
 	/**< ShangMi 4 (SM4) algorithm in CFB mode */
-	RTE_CRYPTO_CIPHER_SM4_XTS
+	RTE_CRYPTO_CIPHER_SM4_XTS,
 	/**< ShangMi 4 (SM4) algorithm in XTS mode */
+
+	RTE_CRYPTO_CIPHER_SNOW5G_NEA4,
+	/**< Snow 5G algorithm in NEA4 mode */
+	RTE_CRYPTO_CIPHER_AES_NEA5,
+	/**< AES algorithm in NEA5 mode */
+	RTE_CRYPTO_CIPHER_ZUC_NEA6,
+	/**< ZUC-256 algorithm in NEA6 mode */
 };
 
 /** Symmetric Cipher Direction */
@@ -384,6 +391,14 @@ enum rte_crypto_auth_algorithm {
 	/**< 256 bit SHAKE algorithm. */
 	RTE_CRYPTO_AUTH_SM3_HMAC,
 	/** < HMAC using ShangMi 3 (SM3) algorithm */
+
+	RTE_CRYPTO_AUTH_SNOW5G_NIA4,
+	/**< Snow 5G algorithm in NIA4 mode */
+	RTE_CRYPTO_AUTH_AES_NIA5,
+	/**< AES algorithm in NIA5 mode */
+	RTE_CRYPTO_AUTH_ZUC_NIA6,
+	/**< ZUC-256 algorithm in NIA6 mode */
+
 };
 
 /** Symmetric Authentication / Hash Operations */
@@ -486,6 +501,13 @@ enum rte_crypto_aead_algorithm {
 	/**< Chacha20 cipher with poly1305 authenticator */
 	RTE_CRYPTO_AEAD_SM4_GCM,
 	/**< SM4 cipher in GCM mode */
+
+	RTE_CRYPTO_AEAD_SNOW5G_NCA4,
+	/**< Snow 5G algorithm in NCA4 mode */
+	RTE_CRYPTO_AEAD_AES_NCA5,
+	/**< AES algorithm in NCA5 mode */
+	RTE_CRYPTO_AEAD_ZUC_NCA6,
+	/**< ZUC-256 algorithm in NCA6 mode */
 };
 
 /** Symmetric AEAD Operations */
@@ -714,8 +736,11 @@ struct rte_crypto_sym_op {
 					  *
 					  * @note
 					  * For SNOW 3G @ RTE_CRYPTO_CIPHER_SNOW3G_UEA2,
-					  * KASUMI @ RTE_CRYPTO_CIPHER_KASUMI_F8
-					  * and ZUC @ RTE_CRYPTO_CIPHER_ZUC_EEA3,
+					  * KASUMI @ RTE_CRYPTO_CIPHER_KASUMI_F8,
+					  * ZUC @ RTE_CRYPTO_CIPHER_ZUC_EEA3,
+					  * SNOW 5G @ RTE_CRYPTO_CIPHER_SNOW5G_NEA4,
+					  * AES @ RTE_CRYPTO_CIPHER_AES_NEA5
+					  * and ZUC @ RTE_CRYPTO_CIPHER_ZUC_NEA6
 					  * this field should be in bits. For
 					  * digest-encrypted cases this must be
 					  * an 8-bit multiple.
@@ -732,8 +757,11 @@ struct rte_crypto_sym_op {
 					  *
 					  * @note
 					  * For SNOW 3G @ RTE_CRYPTO_AUTH_SNOW3G_UEA2,
-					  * KASUMI @ RTE_CRYPTO_CIPHER_KASUMI_F8
-					  * and ZUC @ RTE_CRYPTO_CIPHER_ZUC_EEA3,
+					  * KASUMI @ RTE_CRYPTO_CIPHER_KASUMI_F8,
+					  * ZUC @ RTE_CRYPTO_CIPHER_ZUC_EEA3,
+					  * SNOW 5G @ RTE_CRYPTO_CIPHER_SNOW5G_NEA4,
+					  * AES @ RTE_CRYPTO_CIPHER_AES_NEA5
+					  * and ZUC @ RTE_CRYPTO_CIPHER_ZUC_NEA6
 					  * this field should be in bits. For
 					  * digest-encrypted cases this must be
 					  * an 8-bit multiple.
@@ -750,8 +778,11 @@ struct rte_crypto_sym_op {
 					  *
 					  * @note
 					  * For SNOW 3G @ RTE_CRYPTO_AUTH_SNOW3G_UIA2,
-					  * KASUMI @ RTE_CRYPTO_AUTH_KASUMI_F9
-					  * and ZUC @ RTE_CRYPTO_AUTH_ZUC_EIA3,
+					  * KASUMI @ RTE_CRYPTO_AUTH_KASUMI_F9,
+					  * ZUC @ RTE_CRYPTO_AUTH_ZUC_EIA3,
+					  * SNOW 5G @ RTE_CRYPTO_AUTH_SNOW5G_NIA4,
+					  * AES @ RTE_CRYPTO_AUTH_AES_NIA5
+					  * and ZUC @ RTE_CRYPTO_AUTH_ZUC_NIA6
 					  * this field should be in bits. For
 					  * digest-encrypted cases this must be
 					  * an 8-bit multiple.
@@ -775,8 +806,11 @@ struct rte_crypto_sym_op {
 					  *
 					  * @note
 					  * For SNOW 3G @ RTE_CRYPTO_AUTH_SNOW3G_UIA2,
-					  * KASUMI @ RTE_CRYPTO_AUTH_KASUMI_F9
-					  * and ZUC @ RTE_CRYPTO_AUTH_ZUC_EIA3,
+					  * KASUMI @ RTE_CRYPTO_AUTH_KASUMI_F9,
+					  * ZUC @ RTE_CRYPTO_AUTH_ZUC_EIA3,
+					  * SNOW 5G @ RTE_CRYPTO_AUTH_SNOW5G_NIA4,
+					  * AES @ RTE_CRYPTO_AUTH_AES_NIA5
+					  * and ZUC @ RTE_CRYPTO_AUTH_ZUC_NIA6
 					  * this field should be in bits. For
 					  * digest-encrypted cases this must be
 					  * an 8-bit multiple.
diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.c
index f4c6f692f0..7bddb154c2 100644
--- a/lib/cryptodev/rte_cryptodev.c
+++ b/lib/cryptodev/rte_cryptodev.c
@@ -102,7 +102,10 @@ crypto_cipher_algorithm_strings[] = {
 	[RTE_CRYPTO_CIPHER_SM4_CTR]	= "sm4-ctr",
 	[RTE_CRYPTO_CIPHER_SM4_CFB]	= "sm4-cfb",
 	[RTE_CRYPTO_CIPHER_SM4_OFB]	= "sm4-ofb",
-	[RTE_CRYPTO_CIPHER_SM4_XTS]	= "sm4-xts"
+	[RTE_CRYPTO_CIPHER_SM4_XTS]	= "sm4-xts",
+	[RTE_CRYPTO_CIPHER_SNOW5G_NEA4]	= "snow5g-nea4",
+	[RTE_CRYPTO_CIPHER_AES_NEA5]	= "aes-nea5",
+	[RTE_CRYPTO_CIPHER_ZUC_NEA6]	= "zuc-nea6",
 };
 
 /**
@@ -162,6 +165,10 @@ crypto_auth_algorithm_strings[] = {
 
 	[RTE_CRYPTO_AUTH_SHAKE_128]	 = "shake-128",
 	[RTE_CRYPTO_AUTH_SHAKE_256]	 = "shake-256",
+
+	[RTE_CRYPTO_AUTH_SNOW5G_NIA4] = "snow5g-nia4",
+	[RTE_CRYPTO_AUTH_AES_NIA5]	 = "aes-nia5",
+	[RTE_CRYPTO_AUTH_ZUC_NIA6]	 = "zuc-nia6",
 };
 
 /**
@@ -175,6 +182,10 @@ crypto_aead_algorithm_strings[] = {
 	[RTE_CRYPTO_AEAD_AES_GCM]	= "aes-gcm",
 	[RTE_CRYPTO_AEAD_CHACHA20_POLY1305] = "chacha20-poly1305",
 	[RTE_CRYPTO_AEAD_SM4_GCM]   = "sm4-gcm",
+
+	[RTE_CRYPTO_AEAD_SNOW5G_NCA4] = "snow5g-nca4",
+	[RTE_CRYPTO_AEAD_AES_NCA5]    = "aes-nca5",
+	[RTE_CRYPTO_AEAD_ZUC_NCA6]    = "zuc-nca6",
 };
 
 
-- 
2.50.1

