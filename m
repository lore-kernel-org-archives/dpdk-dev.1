Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F64C3ABA3
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 May 2025 10:12:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E122402A0;
	Fri,  2 May 2025 12:12:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id C1BF44029E
 for <dev@dpdk.org>; Fri,  2 May 2025 12:12:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746180755; x=1777716755;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tODEbnoDUDXiOy+a4/sbSMLoCcrqmpMPVavzyZtiMNE=;
 b=PHajbVmV3shnuEg6ENyDwU1XhZh+rm2fRwnOEcrmSTqYyIPLmtxfniks
 o0clGumoed0HNvP89Dbth5AiC2mFmdFTCWUTgoxPxUpViCLtEETXIxAuI
 rdS0S6gA8ij+zbiBy7vAq/YmzJm99VYyLGi5StyIUrNskVeLTmUhQEKqd
 qGIPic4UH/tTE/2emBYfuxk+H7jo37sDXYdZa7Wy1sqXhoC0MZ+OrA0bs
 47sO8I4qIvSgQ+O7Z4GDRXqmADZqH2z87N5TxMTysDkf9P7L3XTXpJEZk
 9xDm9IMHu2yDqO85LYOcz9U4GtWBMu2ZLkSCQ8GtowOiIWuS9NuTIby80 Q==;
X-CSE-ConnectionGUID: qZ+2SJ7fTZGkqixfyWKGEg==
X-CSE-MsgGUID: Puu25dsxR4CmDeiU5YZRJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="59223117"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="59223117"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2025 03:12:34 -0700
X-CSE-ConnectionGUID: 4mNGg2WxT7inscMHKgRcZg==
X-CSE-MsgGUID: XiM1Q/oFQqiLqcorrTKbVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="134914561"
Received: from silpixa00401013.ir.intel.com (HELO
 silpixa00401013.ger.corp.intel.com) ([10.237.223.185])
 by fmviesa008.fm.intel.com with ESMTP; 02 May 2025 03:12:33 -0700
From: Kai Ji <kai.ji@intel.com>
To: dev@dpdk.org
Cc: gakhil@marvell.com,
	Kai Ji <kai.ji@intel.com>
Subject: [dpdk-dev v1] app/test-crypto-perf: remove decrypt test case from perf
Date: Fri,  2 May 2025 10:12:26 +0000
Message-Id: <20250502101226.1405274-1-kai.ji@intel.com>
X-Mailer: git-send-email 2.34.1
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

Remove all decrypt test cases in aesni-mb throughput perf as the
decrypt throughput testing only support OOP by dpdk-test-crypto-perf

Signed-off-by: Kai Ji <kai.ji@intel.com>
---
 .../configs/crypto-perf-aesni-mb.json         | 24 -------------------
 1 file changed, 24 deletions(-)

diff --git a/app/test-crypto-perf/configs/crypto-perf-aesni-mb.json b/app/test-crypto-perf/configs/crypto-perf-aesni-mb.json
index d50e4af36c..91fbc9cfcd 100644
--- a/app/test-crypto-perf/configs/crypto-perf-aesni-mb.json
+++ b/app/test-crypto-perf/configs/crypto-perf-aesni-mb.json
@@ -13,13 +13,6 @@
 				"devtype": "crypto_aesni_mb"
 			}
 		},
-		"AES-CBC-128 SHA1-HMAC auth-then-cipher decrypt": {
-			"cipher-algo": "aes-cbc",
-			"cipher-key-sz": "16",
-			"auth-algo": "sha1-hmac",
-			"optype": "auth-then-cipher",
-			"cipher-op": "decrypt"
-		},
 		"AES-CBC-128 SHA1-HMAC cipher-then-auth encrypt": {
 			"cipher-algo": "aes-cbc",
 			"cipher-key-sz": "16",
@@ -30,13 +23,6 @@
 			"optype": "cipher-then-auth",
 			"cipher-op": "encrypt"
 		},
-		"AES-CBC-256 SHA2-256-HMAC auth-then-cipher decrypt": {
-			"cipher-algo": "aes-cbc",
-			"cipher-key-sz": "32",
-			"auth-algo": "sha2-256-hmac",
-			"optype": "auth-then-cipher",
-			"cipher-op": "decrypt"
-		},
 		"AES-CBC-256 SHA2-256-HMAC cipher-then-auth encrypt": {
 			"cipher-algo": "aes-cbc",
 			"cipher-key-sz": "32",
@@ -53,21 +39,11 @@
 			"optype": "aead",
 			"total-ops": "10000000"
 		},
-		"AES-GCM-128 aead-op decrypt": {
-			"aead-algo": "aes-gcm",
-			"aead-key-sz": "16",
-			"aead-op": "decrypt"
-		},
 		"AES-GCM-256 aead-op encrypt": {
 			"aead-algo": "aes-gcm",
 			"aead-key-sz": "32",
 			"aead-op": "encrypt"
 		},
-		"AES-GCM-256 aead-op decrypt": {
-			"aead-algo": "aes-gcm",
-			"aead-key-sz": "32",
-			"aead-op": "decrypt"
-		},
 		"AES-GMAC 128 auth-only generate": {
 			"auth-algo": "aes-gmac",
 			"auth-key-sz": "16",
-- 
2.34.1

