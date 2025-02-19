Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67485C021B0
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 11:50:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5AC340E39;
	Wed, 19 Feb 2025 12:50:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id E04FA40DDC
 for <dev@dpdk.org>; Wed, 19 Feb 2025 12:50:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739965819; x=1771501819;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ewpp8Z7YR80VxxEmtiWCnD9o146BQMAyjvyVlUyMd7U=;
 b=iuVXL1khux5nIXT7IJHtpPsdU+Dd+dCICPJJb+XNOhtocvaeOnkJ0NXs
 mpvBTJ+Iw3b8p68d/0kQxLDg8gHOijIDEhuHQ7RVux8Fb3t3OjrkDZPjs
 EOJhfjgcm3VkFXd4NfG/YGOmVOY8y2lKuMMbH5t2od7MzrCSNQ/BpTVdi
 libPWfovFAb6AZOPFDB8KwQtC7MI5YeJ8Xml0LsqGvBUlV4FHljcP/Bny
 roiJ8P0d81ioS6EeA2J22WGrrVkgbBYchA5xHiLRf5TXJa2nYbsw0F/8X
 5SjpYyuHru6dXzgwP7mQZDRSLS4PEIT8SOqdFgW/7YzmyBXyj5Z6Fuzzp w==;
X-CSE-ConnectionGUID: 3+ktxme4TnCch8CNSVMkRA==
X-CSE-MsgGUID: coWIrzMJTXKzY3/xIVil/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40412096"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="40412096"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 03:50:19 -0800
X-CSE-ConnectionGUID: c4BQamDrSHSCNsImv+We2A==
X-CSE-MsgGUID: aGGFvz/OQvSF7C36PbSedw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="114556912"
Received: from unknown (HELO silpixa00400886.ir.intel.com) ([10.243.22.139])
 by orviesa010.jf.intel.com with ESMTP; 19 Feb 2025 03:50:17 -0800
From: Brian Dooley <brian.dooley@intel.com>
To: Akhil Goyal <gakhil@marvell.com>,
	Fan Zhang <fanzhang.oss@gmail.com>
Cc: dev@dpdk.org, kai.ji@intel.com, pablo.de.lara.guarch@intel.com,
 Brian Dooley <brian.dooley@intel.com>
Subject: [PATCH v4 2/3] cryptodev: add SM4 GCM
Date: Wed, 19 Feb 2025 11:50:00 +0000
Message-Id: <20250219115001.1047145-2-brian.dooley@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250219115001.1047145-1-brian.dooley@intel.com>
References: <20241213125850.2714328-1-brian.dooley@intel.com>
 <20250219115001.1047145-1-brian.dooley@intel.com>
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

Added support for symmetric algorithm SM4 GCM in cryptodev.

Signed-off-by: Brian Dooley <brian.dooley@intel.com>
---
 doc/guides/cryptodevs/features/default.ini | 2 ++
 lib/cryptodev/rte_crypto_sym.h             | 4 +++-
 lib/cryptodev/rte_cryptodev.c              | 3 ++-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/doc/guides/cryptodevs/features/default.ini b/doc/guides/cryptodevs/features/default.ini
index 592af48026..116ffce249 100644
--- a/doc/guides/cryptodevs/features/default.ini
+++ b/doc/guides/cryptodevs/features/default.ini
@@ -118,6 +118,8 @@ AES CCM (128)     =
 AES CCM (192)     =
 AES CCM (256)     =
 CHACHA20-POLY1305 =
+SM4 GCM           =
+
 ;
 ; Supported Asymmetric algorithms of a default crypto driver.
 ;
diff --git a/lib/cryptodev/rte_crypto_sym.h b/lib/cryptodev/rte_crypto_sym.h
index 505356ff44..b47e52f63b 100644
--- a/lib/cryptodev/rte_crypto_sym.h
+++ b/lib/cryptodev/rte_crypto_sym.h
@@ -482,8 +482,10 @@ enum rte_crypto_aead_algorithm {
 	/**< AES algorithm in CCM mode. */
 	RTE_CRYPTO_AEAD_AES_GCM,
 	/**< AES algorithm in GCM mode. */
-	RTE_CRYPTO_AEAD_CHACHA20_POLY1305
+	RTE_CRYPTO_AEAD_CHACHA20_POLY1305,
 	/**< Chacha20 cipher with poly1305 authenticator */
+	RTE_CRYPTO_AEAD_SM4_GCM
+	/**< SM4 cipher with GCM mode */
 };
 
 /** Symmetric AEAD Operations */
diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.c
index a49b0662f3..7b5236ad41 100644
--- a/lib/cryptodev/rte_cryptodev.c
+++ b/lib/cryptodev/rte_cryptodev.c
@@ -168,7 +168,8 @@ static const char *
 crypto_aead_algorithm_strings[] = {
 	[RTE_CRYPTO_AEAD_AES_CCM]	= "aes-ccm",
 	[RTE_CRYPTO_AEAD_AES_GCM]	= "aes-gcm",
-	[RTE_CRYPTO_AEAD_CHACHA20_POLY1305] = "chacha20-poly1305"
+	[RTE_CRYPTO_AEAD_CHACHA20_POLY1305] = "chacha20-poly1305",
+	[RTE_CRYPTO_AEAD_SM4_GCM]   = "sm4-gcm"
 };
 
 
-- 
2.25.1

