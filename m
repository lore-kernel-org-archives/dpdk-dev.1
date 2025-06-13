Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF81C61DB2
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 11:00:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5050742EC3;
	Fri, 13 Jun 2025 13:00:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 094B342E4E
 for <dev@dpdk.org>; Fri, 13 Jun 2025 13:00:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749812406; x=1781348406;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=TS7Obihv998Scmj2W2hWxEdeb1YVfi9HD5fGx+jshBo=;
 b=W12lfIi6I2sF1Mco+KF1GE7aCsg30Rwkl/xRrHC45qmQJYuznI5bmcIr
 JmVToM/uN1Gq0c3svKefXBbSK+wNovF5X2dJyVB2lfBAfynbIQ6uZDugQ
 O2VSkDGolM94r3TnJPnc+xKpOufGB08vQpjcicuGmxGALmrW0JsNi6y65
 kWTD9Gh+StlGF2hLmpYbca7b8tlauhMnynWrWQzq7yppoh7MVEilMTx+3
 lyx/K6ah2E+72QGfoivBo51uZi4yPjralTuUVKcny0O6MfQgPJkp0hVGA
 7JsrZVklS1pEx38e/fjNJtQYjeEk93esABmht2aimERCzdz8qukHPARQH Q==;
X-CSE-ConnectionGUID: ZSlaANyHRGm+Kek42j2rGw==
X-CSE-MsgGUID: XVnBQ/Y0S6e5R1BVDcJvBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="62675985"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; d="scan'208";a="62675985"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2025 04:00:05 -0700
X-CSE-ConnectionGUID: JDEm1ukmQGSDPrpCstB/tA==
X-CSE-MsgGUID: ChhEe0k5TgytmHlCYBT9XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; d="scan'208";a="153087327"
Received: from unknown (HELO silpixa00400465.ger.corp.intel.com)
 ([10.237.223.221])
 by orviesa005.jf.intel.com with ESMTP; 13 Jun 2025 04:00:04 -0700
From: Kai Ji <kai.ji@intel.com>
To: dev@dpdk.org
Cc: gakhil@marvell.com,
	Kai Ji <kai.ji@intel.com>
Subject: [dpdk-dev v1] app/test-crypto-perf: remove unsupported test cases
 from perf json
Date: Fri, 13 Jun 2025 11:00:01 +0000
Message-ID: <20250613110001.350767-1-kai.ji@intel.com>
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

Remove all unsupported test cases in json files

Signed-off-by: Kai Ji <kai.ji@intel.com>
---
 .../configs/crypto-perf-aesni-gcm.json        | 29 -----------
 .../configs/crypto-perf-aesni-mb.json         |  7 ---
 .../configs/crypto-perf-qat.json              | 51 ++++++-------------
 3 files changed, 16 insertions(+), 71 deletions(-)

diff --git a/app/test-crypto-perf/configs/crypto-perf-aesni-gcm.json b/app/test-crypto-perf/configs/crypto-perf-aesni-gcm.json
index 608a46e34f..e8df49337a 100644
--- a/app/test-crypto-perf/configs/crypto-perf-aesni-gcm.json
+++ b/app/test-crypto-perf/configs/crypto-perf-aesni-gcm.json
@@ -23,16 +23,6 @@
 			"optype": "aead",
 			"total-ops": "10000000"
 		},
-		"AES-GCM-128 aead-op decrypt": {
-			"aead-algo": "aes-gcm",
-			"aead-key-sz": "16",
-			"aead-op": "decrypt",
-			"aead-aad-sz": "16",
-			"aead-iv-sz": "12",
-			"digest-sz": "16",
-			"optype": "aead",
-			"total-ops": "10000000"
-		},
 		"AES-GCM-256 aead-op encrypt": {
 			"aead-algo": "aes-gcm",
 			"aead-key-sz": "32",
@@ -43,16 +33,6 @@
 			"optype": "aead",
 			"total-ops": "10000000"
 		},
-		"AES-GCM-256 aead-op decrypt": {
-			"aead-algo": "aes-gcm",
-			"aead-key-sz": "32",
-			"aead-op": "decrypt",
-			"aead-aad-sz": "32",
-			"aead-iv-sz": "12",
-			"digest-sz": "16",
-			"optype": "aead",
-			"total-ops": "10000000"
-		},
 		"AES-GMAC 128 auth-only generate": {
 			"auth-algo": "aes-gmac",
 			"auth-key-sz": "16",
@@ -77,15 +57,6 @@
 				"devtype": "crypto_aesni_gcm"
 			}
 		},
-		"AES-GCM-128 aead-op decrypt": {
-			"aead-algo": "aes-gcm",
-			"aead-key-sz": "16",
-			"aead-op": "decrypt",
-			"aead-aad-sz": "16",
-			"aead-iv-sz": "12",
-			"digest-sz": "16",
-			"optype": "aead"
-		},
 		"AES-GCM-256 aead-op encrypt latency": {
 			"aead-algo": "aes-gcm",
 			"aead-key-sz": "32",
diff --git a/app/test-crypto-perf/configs/crypto-perf-aesni-mb.json b/app/test-crypto-perf/configs/crypto-perf-aesni-mb.json
index 91fbc9cfcd..88e2147f05 100644
--- a/app/test-crypto-perf/configs/crypto-perf-aesni-mb.json
+++ b/app/test-crypto-perf/configs/crypto-perf-aesni-mb.json
@@ -68,13 +68,6 @@
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
 		"AES-GCM-256 aead-op encrypt": {
 			"aead-algo": "aes-gcm",
 			"aead-key-sz": "32",
diff --git a/app/test-crypto-perf/configs/crypto-perf-qat.json b/app/test-crypto-perf/configs/crypto-perf-qat.json
index 0adb809e39..06ab1d7684 100644
--- a/app/test-crypto-perf/configs/crypto-perf-qat.json
+++ b/app/test-crypto-perf/configs/crypto-perf-qat.json
@@ -12,27 +12,6 @@
 				"ptest": "throughput"
 			}
 		},
-		"AES-CBC-128 SHA1-HMAC auth-then-cipher decrypt": {
-			"cipher-algo": "aes-cbc",
-			"cipher-key-sz": "16",
-			"auth-algo": "sha1-hmac",
-			"optype": "auth-then-cipher",
-			"cipher-op": "decrypt"
-		},
-		"AES-CBC-128 SHA1-HMAC cipher-then-auth encrypt": {
-			"cipher-algo": "aes-cbc",
-			"cipher-key-sz": "16",
-			"auth-algo": "sha1-hmac",
-			"optype": "cipher-then-auth",
-			"cipher-op": "encrypt"
-		},
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
@@ -47,22 +26,18 @@
 			"aead-op": "encrypt",
 			"aead-aad-sz": "16",
 			"digest-sz": "16",
-			"optype": "aead"
-		},
-		"AES-GCM-128 aead-op decrypt": {
-			"aead-algo": "aes-gcm",
-			"aead-key-sz": "16",
-			"aead-op": "decrypt"
+			"optype": "aead",
+			"total-ops": "10000000"
 		},
 		"AES-GCM-256 aead-op encrypt": {
 			"aead-algo": "aes-gcm",
 			"aead-key-sz": "32",
-			"aead-op": "encrypt"
-		},
-		"AES-GCM-256 aead-op decrypt": {
-			"aead-algo": "aes-gcm",
-			"aead-key-sz": "32",
-			"aead-op": "decrypt"
+			"aead-op": "encrypt",
+			"aead-aad-sz": "32",
+			"aead-iv-sz": "12",
+			"digest-sz": "16",
+			"optype": "aead",
+			"total-ops": "10000000"
 		}
 	},
 	"latency": {
@@ -83,12 +58,18 @@
 			"cipher-key-sz": "32",
 			"auth-algo": "sha2-256-hmac",
 			"optype": "cipher-then-auth",
-			"cipher-op": "encrypt"
+			"cipher-op": "encrypt",
+			"total-ops": "10000000"
 		},
 		"AES-GCM-128 aead-op encrypt": {
 			"aead-algo": "aes-gcm",
 			"aead-key-sz": "16",
-			"aead-op": "encrypt"
+			"aead-op": "encrypt",
+			"aead-aad-sz": "16",
+			"aead-iv-sz": "12",
+			"digest-sz": "16",
+			"optype": "aead",
+			"total-ops": "10000000"
 		}
 	}
 }
-- 
2.43.0

