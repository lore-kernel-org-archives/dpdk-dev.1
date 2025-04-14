Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5B1C369B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Apr 2025 09:55:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CD9A402C5;
	Mon, 14 Apr 2025 11:55:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 202F6402C2;
 Mon, 14 Apr 2025 11:55:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744624545; x=1776160545;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=T2XaJ4izCYh5MZnwlOxwWAEa8AHjAJyyLlEYi05OvC8=;
 b=LuW8fRQcBpJoS84qShD6UhYpErCgvII/gJrXB6yLRdYrmgPTuBKEnzY0
 4rTVX1WqQkg1IUAUHbzB39erZD3xijfmP6W8u20bAg4sro5xSII7tUwYK
 u0czzoxfZMRMG+Te9eh9bw/oVF7R55dznPC16ZVy94FD1DDhgpuvs9WMW
 n1mos5BbYvTN5hWDGhcy91ZFdblAfAKH2JzHT/M8xR6x5FQ5CPuNQwFXE
 vLBnR0Oaj0NFMtqWfkqY1Wme2XhO1OR88KfDzxMFDWVmPXZQA5nSuhciv
 cKgwAfE/Qrz8RLQxiIu6CSuKf+K3Gg/GdEiSVmBjVX+VcJG1YHj5tMJSn A==;
X-CSE-ConnectionGUID: 4vHgIrM7RSCxgibf6NRI9A==
X-CSE-MsgGUID: LpbmNEA7Sk6O9jBuZbtcfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="45971593"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; d="scan'208";a="45971593"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2025 02:55:43 -0700
X-CSE-ConnectionGUID: ba95x4qIRSmP4ksMt3zhPQ==
X-CSE-MsgGUID: Xv8KATmOSWSRmaWVgxnqGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; d="scan'208";a="134615397"
Received: from shwdenpg561.ccr.corp.intel.com (HELO dpdk..) ([10.239.252.3])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2025 02:55:42 -0700
From: Kaiwen Deng <kaiwenx.deng@intel.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Kaiwen Deng <kaiwenx.deng@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>, Yaroslav Brustinov <ybrustin@cisco.com>
Subject: [PATCH] net/intel: fix igb tx queue offloads capability
Date: Mon, 14 Apr 2025 16:53:52 +0800
Message-Id: <20250414085353.848901-1-kaiwenx.deng@intel.com>
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

The igb driver assigns the tx port offload capability to the
tx queue offload capability.

This commit will fix this issue.

Fixes: daa3b0833f08 ("net/e1000: fix Tx offload capability typos")
Cc: stable@dpdk.org

Signed-off-by: Kaiwen Deng <kaiwenx.deng@intel.com>
---
 drivers/net/intel/e1000/igb_rxtx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/e1000/igb_rxtx.c b/drivers/net/intel/e1000/igb_rxtx.c
index 4276bb6d31..b63de2354f 100644
--- a/drivers/net/intel/e1000/igb_rxtx.c
+++ b/drivers/net/intel/e1000/igb_rxtx.c
@@ -1490,11 +1490,9 @@ igb_get_tx_port_offloads_capa(struct rte_eth_dev *dev)
 uint64_t
 igb_get_tx_queue_offloads_capa(struct rte_eth_dev *dev)
 {
-	uint64_t tx_queue_offload_capa;
-
-	tx_queue_offload_capa = igb_get_tx_port_offloads_capa(dev);
+	RTE_SET_USED(dev);
 
-	return tx_queue_offload_capa;
+	return 0;
 }
 
 int
-- 
2.34.1

