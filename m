Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C9DCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 06:20:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 615814067C;
	Thu,  6 Nov 2025 07:20:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 8DA724013F;
 Thu,  6 Nov 2025 07:20:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762410045; x=1793946045;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NS1n75JXgEM7x0DWY6QKEmUL/TAmEle5OQ9XdQIpfM0=;
 b=Cn2WSuwihU0R+dkEUCBy/89qM3KhI9drXT2Ak02WTMmoRfwqO0YIJaIt
 0tt6y6A94hiUf0PUXEWTzFTaf/sVEyg9aJUCu3gOqBJ1X/vHtcVhCcf66
 ekPcIT1b40t8clfKEooOxC8zoQ4Seij0XvgDBzN7Xe1Et3JYFpLqSgZpt
 wfrdrJXG7FzWqjEr+9JWbPs/wBW27vwnQLJJldGNg6bhAH0gVRz2hS1eG
 jQ6rbi6sPhKXDfl+P/NgHI8X+yLENjGExkb9Jl6xCNoQGNh0f7w3eQ/xt
 IBeOfJ0kuqdvmCvRypcczuQMcYa+1/lfzSRnN1+koeDZUfDVcLURICJoH Q==;
X-CSE-ConnectionGUID: FH5mjfV6SESxTx/QID/zhQ==
X-CSE-MsgGUID: g1licr49Sr+1zzqHK+5Rtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="81940639"
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; d="scan'208";a="81940639"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 22:20:44 -0800
X-CSE-ConnectionGUID: Fp/a1JUlSJKzf61kY0WQYA==
X-CSE-MsgGUID: XiOaY8alQLC48EueCmVEMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; d="scan'208";a="192844165"
Received: from fenlix-mobl.ccr.corp.intel.com (HELO localhost.intel.com)
 ([10.239.252.5])
 by orviesa005.jf.intel.com with ESMTP; 05 Nov 2025 22:20:41 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: rajesh3.kumar@intel.com, aman.deep.singh@intel.com,
 manoj.kumar.subbarao@intel.com, stable@dpdk.org
Subject: [PATCH v4 3/4] net/ice: fix TxPP/IEEE 1588 port forwarding conflict
Date: Thu,  6 Nov 2025 14:01:25 -0500
Message-ID: <20251106190125.31630-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251106064638.23020-4-soumyadeep.hore@intel.com>
References: <20251106064638.23020-4-soumyadeep.hore@intel.com>
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

TxPP could not run alongside IEEE 1588 forwarding. When IEEE 1588
port forwarding was enabled after TxPP enablement, it caused multiple
calls to ice_timesync_enable() and ice_timesync_disable() functions.

This commit introduces a txpp_ena flag in the adapter to properly
handle these multiple function calls and resolve the compatibility issue.

Fixes: 0b6ff09a1f19 ("net/intel: support Tx packet pacing for E830")
Cc: stable@dpdk.org

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 16 ++++++++++++++--
 drivers/net/intel/ice/ice_ethdev.h |  1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 3eef4303e9..2ac63bf97f 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -2873,6 +2873,8 @@ ice_dev_stop(struct rte_eth_dev *dev)
 {
 	struct rte_eth_dev_data *data = dev->data;
 	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct ice_adapter *ad =
+			ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct ice_vsi *main_vsi = pf->main_vsi;
 	struct rte_pci_device *pci_dev = ICE_DEV_TO_PCI(dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
@@ -2893,8 +2895,10 @@ ice_dev_stop(struct rte_eth_dev *dev)
 	/* disable all queue interrupts */
 	ice_vsi_disable_queues_intr(main_vsi);
 
-	if (dev->data->dev_conf.txmode.offloads & RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP)
+	if (dev->data->dev_conf.txmode.offloads & RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP) {
+		ad->txpp_ena = 0;
 		ice_timesync_disable(dev);
+	}
 
 	if (pf->adapter->devargs.link_state_on_close == ICE_LINK_UP ||
 			(pf->adapter->devargs.link_state_on_close == ICE_LINK_INITIAL &&
@@ -4436,8 +4440,10 @@ ice_dev_start(struct rte_eth_dev *dev)
 		}
 	}
 
-	if (dev->data->dev_conf.txmode.offloads & RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP)
+	if (dev->data->dev_conf.txmode.offloads & RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP) {
 		ice_timesync_enable(dev);
+		ad->txpp_ena = 1;
+	}
 
 	return 0;
 
@@ -7029,6 +7035,9 @@ ice_timesync_enable(struct rte_eth_dev *dev)
 			ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	int ret;
 
+	if (ad->txpp_ena)
+		return 0;
+
 	if (dev->data->dev_started && !(dev->data->dev_conf.rxmode.offloads &
 	    RTE_ETH_RX_OFFLOAD_TIMESTAMP)) {
 		PMD_DRV_LOG(ERR, "Rx timestamp offload not configured");
@@ -7267,6 +7276,9 @@ ice_timesync_disable(struct rte_eth_dev *dev)
 	uint64_t val;
 	uint8_t lport;
 
+	if (ad->txpp_ena)
+		return 0;
+
 	lport = hw->port_info->lport;
 
 	ice_clear_phy_tstamp(hw, lport, 0);
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 6478d6dfbd..26c9598df1 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -667,6 +667,7 @@ struct ice_adapter {
 	uint8_t ptp_tx_block;
 	uint8_t ptp_tx_index;
 	bool ptp_ena;
+	bool txpp_ena;	/* For TxPP */
 	uint64_t time_hw;
 	struct ice_fdir_prof_info fdir_prof_info[ICE_MAX_PTGS];
 	struct ice_rss_prof_info rss_prof_info[ICE_MAX_PTGS];
-- 
2.47.1

