Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9C6C44532
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 15:13:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B86AB4068A;
	Tue, 21 Jul 2026 17:13:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 7BF9E40294
 for <dev@dpdk.org>; Tue, 21 Jul 2026 17:13:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784646810; x=1816182810;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ieJsWLlH4OVEXMNBOVSgjl7eesDCrbrb1WSVV810CGU=;
 b=R/zrfvutpMa+jvrKM7pu5Lgb7D9AAMaqQ1gEWd5sGwrgmpBm5GeRhGca
 uvKyYdzUoVUT+StFpymV80rHyHIwjepqgYmjeFsDKj02QbB8Ku3AmPhpr
 NtR+ZF12rFvb10cIWzbniF+5ahmkrXOY1J81eXOZdsuVtWCim5+43V6hf
 U/4PSZ1hQaoNH9NfW6pyuANLz0mQV3TNXlegOdbry3EtIKKFStDY07T0Q
 jR2kmr1sDReLRDC6yLPLB5MRWdolomFzTu6QN2l9ZIKhGZsxAsqy7l1mU
 PUGKfInoMge41zPWes885+UTa44x1kMgQU9xTzqNqIyWZb6jS/JsRWti9 g==;
X-CSE-ConnectionGUID: AS4UAy28QwypFOCuYmw2yA==
X-CSE-MsgGUID: ehrL4viSSLeRQd2GQ4U3uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85107709"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="85107709"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 08:13:29 -0700
X-CSE-ConnectionGUID: j2Siu7YxTf+tWGLKNFxo8A==
X-CSE-MsgGUID: alysz72RQomlB6ctLsKtRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="281070928"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 21 Jul 2026 08:13:29 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 1/6] doc/rel_notes: remove bullets for single items
Date: Tue, 21 Jul 2026 16:13:20 +0100
Message-ID: <20260721151325.2698283-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721151325.2698283-1-bruce.richardson@intel.com>
References: <20260721151325.2698283-1-bruce.richardson@intel.com>
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

For release note component updates where only a single item is called
out, remove the bullet point character.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/rel_notes/release_26_07.rst | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 6badd6d91b..83610938bd 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -137,7 +137,7 @@ New Features
 
 * **Updated Google gve driver.**
 
-  * Added hardware timestamping support on DQO queues.
+  Added hardware timestamping support on DQO queues.
 
 * **Updated Intel iavf driver.**
 
@@ -147,18 +147,18 @@ New Features
 
 * **Updated Intel ice driver.**
 
-  * Added ``rl_burst_size`` devarg to configure the scheduler rate-limiter
-    burst size, reducing Tx latency jitter for time-sensitive traffic.
+  Added ``rl_burst_size`` devarg to configure the scheduler rate-limiter
+  burst size, reducing Tx latency jitter for time-sensitive traffic.
 
 * **Updated Microsoft mana driver.**
 
-  * Added device reset support to the MANA PMD,
-    doing automatic recovery from hardware service reset events,
-    and notification to upper layers of the reset lifecycle.
+  Added device reset support to the MANA PMD,
+  doing automatic recovery from hardware service reset events,
+  and notification to upper layers of the reset lifecycle.
 
 * **Updated NVIDIA mlx5 ethernet driver.**
 
-  * Added support for selective Rx in scalar SPRQ Rx path.
+  Added support for selective Rx in scalar SPRQ Rx path.
 
 * **Updated NXP dpaa2 driver.**
 
@@ -192,14 +192,14 @@ New Features
 
 * **Updated Marvell cnxk crypto driver.**
 
-  * Added support for ML-KEM and ML-DSA on CN20K platform.
+  Added support for ML-KEM and ML-DSA on CN20K platform.
 
 * **Updated Wangxun ngbe driver.**
 
-  * Implemented UDP Segmentation Offload (USO) in the transmit path.
-    The ``RTE_ETH_TX_OFFLOAD_UDP_TSO`` capability was advertised
-    since the driver's initial integration but the data path was missing;
-    it is now functional.
+  Implemented UDP Segmentation Offload (USO) in the transmit path.
+  The ``RTE_ETH_TX_OFFLOAD_UDP_TSO`` capability was advertised
+  since the driver's initial integration but the data path was missing;
+  it is now functional.
 
 * **Updated Wangxun txgbe driver.**
 
-- 
2.53.0

