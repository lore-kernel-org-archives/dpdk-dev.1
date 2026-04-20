Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A270F36C26
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Apr 2026 06:37:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DD4A40658;
	Mon, 20 Apr 2026 08:36:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 0FE734026E;
 Mon, 20 Apr 2026 08:36:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776667012; x=1808203012;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mbqm8YzW/N/BYXbVHqhoNAyhTmAYlR1ZpyJgipji/MA=;
 b=JetdZ+vv4NrOlcffh2MDKRgzlF5X9V5QISh+b5mdg4nbF1h4MDUgjbel
 Q/mZgGEVy1rfy1A7wYa8XFoI5e8mMsa6wPFbXDVw/MqjJUhJU0iJe4FPs
 Hej1sB7wlO3KJ2pGPTg+ziZESJsV0GZI79/fQGuKuIYC6F53mR/Z77qhL
 YouI/6/CAB/cH68Tm16jvQ/VGXHbgzdLuH9nzKHCgbAtT47pC+WnWGkx6
 R1pTylj3E16YEDCMFaAsM8Ha2fFtAy4EgEejVtaxw2vOxrf2tgv+1AkCy
 sd7L6bbA3QeS5MeG4ToTv6FjrJTPMtLqmwzDddIfnBUztQG4UWSmWtyKN w==;
X-CSE-ConnectionGUID: 4WN2MP8nRteRrfWCb8mc3A==
X-CSE-MsgGUID: eN8zAJI9T8eMfCr67BhWMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="89042553"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; d="scan'208";a="89042553"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2026 23:36:51 -0700
X-CSE-ConnectionGUID: KqIFX8jpQ62m8LHQLR3IBQ==
X-CSE-MsgGUID: c6kK+bkvSUC63xdeaoBhDw==
X-ExtLoop1: 1
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa003.fm.intel.com with ESMTP; 19 Apr 2026 23:36:49 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: stable@dpdk.org
Subject: [PATCH 2/4] net/iavf: demote path selection logs from NOTICE to DEBUG
Date: Mon, 20 Apr 2026 11:57:44 +0530
Message-ID: <20260420062746.178145-3-shaiq.wani@intel.com>
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

Fixes: 91e3205d72d8 ("net/iavf: use common Rx path selection infrastructure")
Fixes: ebcfb039afa8 ("net/iavf: use common Tx path selection infrastructure")
Cc: stable@dpdk.org
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 4ff6c18dc4..3d9b49efd0 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -3856,7 +3856,7 @@ iavf_set_rx_function(struct rte_eth_dev *dev)
 	else
 		dev->rx_pkt_burst = iavf_rx_path_infos[adapter->rx_func_type].pkt_burst;
 
-	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
+	PMD_DRV_LOG(DEBUG, "Using %s (port %d).",
 		iavf_rx_path_infos[adapter->rx_func_type].info, dev->data->port_id);
 }
 
@@ -3923,7 +3923,7 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 	else
 		dev->tx_pkt_burst = iavf_tx_path_infos[adapter->tx_func_type].pkt_burst;
 
-	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
+	PMD_DRV_LOG(DEBUG, "Using %s (port %d).",
 		 iavf_tx_path_infos[adapter->tx_func_type].info, dev->data->port_id);
 }
 
-- 
2.43.0

