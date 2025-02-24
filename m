Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72FEC021BB
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 16:59:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA34A4279D;
	Mon, 24 Feb 2025 17:59:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id EE4B641104
 for <dev@dpdk.org>; Mon, 24 Feb 2025 17:59:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740416387; x=1771952387;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=I/r3lXIglFApKip72Y0drL+zUAuc2UaJ2maJGbZWuIc=;
 b=d7sjfLebHWAwC0fCopHQ3WAHqEpmN5Ip4GUu9P1gnxbi+Hd2KR5o+60J
 vCyZ3bmFBN5dX7qu9cH+FTFKRMm2gDPnpcRLtXhPe0V/bYUSmVuc57dip
 6iWZaaiM4Fu2YF7SeoM0BXW5lOVBR1WdDyepri0FORE9bNlsXnzBAuF2m
 ukDBH1UxEQ6vyuaHbVvJBIQxVKT5uuBwCCA/9yOdR7t30J/5jFaXmJDqr
 2VCyxbbvBc4Xmcv59C4gmTkIXxm3oriMEor7RLAbApHn8AvRuPHD8HEJP
 d0zuRgaZxcViK3nS2lhXKRa7uvY1YaOMhAgPTJtQDMIHABX04ExabA/zN A==;
X-CSE-ConnectionGUID: K/fxz7ysSGa/vnbaeeCHhQ==
X-CSE-MsgGUID: UEDY1gXMRomyCYqFeXOz3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="58728730"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; d="scan'208";a="58728730"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2025 08:59:45 -0800
X-CSE-ConnectionGUID: BX6jc6MQTK2xzx3vLucCSg==
X-CSE-MsgGUID: JRJlNyI8RteKneI9h+alnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; d="scan'208";a="116618777"
Received: from unknown (HELO silpixa00400886.ger.corp.intel.com)
 ([10.237.222.180])
 by fmviesa010.fm.intel.com with ESMTP; 24 Feb 2025 08:59:43 -0800
From: Brian Dooley <brian.dooley@intel.com>
To: Akhil Goyal <gakhil@marvell.com>,
	Fan Zhang <fanzhang.oss@gmail.com>
Cc: dev@dpdk.org, kai.ji@intel.com, pablo.de.lara.guarch@intel.com,
 Brian Dooley <brian.dooley@intel.com>
Subject: [PATCH v5 1/3] cryptodev: add SM4 GCM
Date: Mon, 24 Feb 2025 16:59:37 +0000
Message-Id: <20250224165939.717714-1-brian.dooley@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241213125850.2714328-1-brian.dooley@intel.com>
References: <20241213125850.2714328-1-brian.dooley@intel.com>
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
v5:
	Change with GCM mode to in GCM mode
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
index 505356ff44..2557831fb9 100644
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
+	/**< SM4 cipher in GCM mode */
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

