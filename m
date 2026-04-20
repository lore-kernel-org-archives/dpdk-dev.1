Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160C2F36C2A
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Apr 2026 06:36:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4231A402E4;
	Mon, 20 Apr 2026 08:36:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 7A2834026E;
 Mon, 20 Apr 2026 08:36:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776667010; x=1808203010;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+BFTDe39JwhHwx+IzW1hfUGAu4howez5s0kd6x0nTaI=;
 b=CWavXGPwOvhZMG2kOWpXgQM9cor+lO1eUzpo34Qzujju8wobqV48F5pC
 jZwZ8rMcXJ9dEQSeUi1ErjV9J3P9cjNFC6xDIxG/oCvsDl7DNx6Ili8ng
 7Jt41Q27nAU+KnL4P/+aGBS3sZyBgFlD8y/TMpVHbr7Wr2HRPGnZUGULO
 v6C5G4NHu2cncEv9dqY+qOcTGXpj4QMhlIIsj6BOEseXtiiIXJgEpaqry
 Jbm11Rf/jgQAymZh75Ym4U3Z0OXc4xREq/MeInEdv0Ic0R/cMFSp3ifGD
 3ZrCCPdfFJKPjsCZdLEnUEr4C1ZN7vBPiJIRMlf2p2kHbhOK4TIwLK+g5 w==;
X-CSE-ConnectionGUID: ipm15S1GRFybwPS7gTJ7iw==
X-CSE-MsgGUID: XAgJDS0+TOiTyJKBQkKjFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="89042552"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; d="scan'208";a="89042552"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2026 23:36:49 -0700
X-CSE-ConnectionGUID: AqYFT6lURgeND317jILKnQ==
X-CSE-MsgGUID: FYX5FaP9RCO76v8NeFC1WA==
X-ExtLoop1: 1
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa003.fm.intel.com with ESMTP; 19 Apr 2026 23:36:47 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: stable@dpdk.org
Subject: [PATCH 1/4] net/ice: demote path selection logs from NOTICE to DEBUG
Date: Mon, 20 Apr 2026 11:57:43 +0530
Message-ID: <20260420062746.178145-2-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420062746.178145-1-shaiq.wani@intel.com>
References: <20260420062746.178145-1-shaiq.wani@intel.com>
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

Demote Rx/Tx path selection messages from NOTICE to DEBUG level
to reduce noise.

Fixes: 872b57178709 ("net/ice: use common Rx path selection infrastructure")
Fixes: cf96ec231d02 ("net/ice: use common Tx path selection infrastructure")
Cc: stable@dpdk.org
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/ice/ice_rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 31b74be9ba..5edbd705a3 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3408,7 +3408,7 @@ ice_set_rx_function(struct rte_eth_dev *dev)
 
 out:
 	dev->rx_pkt_burst = ice_rx_path_infos[ad->rx_func_type].pkt_burst;
-	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
+	PMD_DRV_LOG(DEBUG, "Using %s (port %d).",
 			ice_rx_path_infos[ad->rx_func_type].info, dev->data->port_id);
 }
 
@@ -3735,7 +3735,7 @@ ice_set_tx_function(struct rte_eth_dev *dev)
 	dev->tx_pkt_burst = mbuf_check ? ice_xmit_pkts_check :
 					 ice_tx_path_infos[ad->tx_func_type].pkt_burst;
 	dev->tx_pkt_prepare = ice_tx_path_infos[ad->tx_func_type].pkt_prep;
-	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
+	PMD_DRV_LOG(DEBUG, "Using %s (port %d).",
 		ice_tx_path_infos[ad->tx_func_type].info, dev->data->port_id);
 }
 
-- 
2.43.0

