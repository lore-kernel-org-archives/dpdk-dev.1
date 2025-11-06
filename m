Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4475BCCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 18:06:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1061D40DD5;
	Wed,  5 Nov 2025 19:06:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 0592C40B98
 for <dev@dpdk.org>; Wed,  5 Nov 2025 19:06:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762365971; x=1793901971;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=txGLHk4RFHHy4xrali/u1NPKTN283d4JguvbCu7HlAU=;
 b=j/DTOZoa30OnAnGeMWjeEDy0vLrhhVbsqztcCgQVUpvGgpBDwkYfgZ8e
 zmawdwXsLXM6J9RXwmGCtA6lxiqCHpG5qXJfsAq2eyj9oYbv+TGP636WG
 PEr0X3Ig5K6A/4/ZW03fGeVDw61KTmm9osRZTVOslDBxgVFu/02RCEbQV
 I4CIlzxunxu4ZIONNgy7Sfu2zhTeyUrDnFFT6+uXcjbB/gW4YqDZi55Ql
 iHHtmZxoeg4+UubSCsZN+Q2CqZLhD7Kf3cu7VVx8NgVNKgynOOVOJbUbF
 41ePVCEUYXgyy2JccsZ0F11uVYPpUV+AT1V6psauvSxSmN7tdG88pjAGl A==;
X-CSE-ConnectionGUID: Q8+c8BYbTOihl/YoQZsXcA==
X-CSE-MsgGUID: wuhvxn5eSQa0L7IqWcPMKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="75842008"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; d="scan'208";a="75842008"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 10:06:11 -0800
X-CSE-ConnectionGUID: j128r2WLQiOvEmJz79uBIA==
X-CSE-MsgGUID: lOgnMQD4QR26Bk/sp1aNrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; d="scan'208";a="187368644"
Received: from fenlix-mobl.ccr.corp.intel.com (HELO localhost.intel.com)
 ([10.239.252.5])
 by fmviesa006.fm.intel.com with ESMTP; 05 Nov 2025 10:06:09 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: rajesh3.kumar@intel.com, aman.deep.singh@intel.com,
 manoj.kumar.subbarao@intel.com
Subject: [PATCH v3 3/4] net/ice: enable PTP packet forward with TxPP
Date: Thu,  6 Nov 2025 01:46:36 -0500
Message-ID: <20251106064638.23020-4-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251106064638.23020-1-soumyadeep.hore@intel.com>
References: <20251030173304.260209-3-soumyadeep.hore@intel.com>
 <20251106064638.23020-1-soumyadeep.hore@intel.com>
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

Previously TxPP cannot be run with ieee1588 fwd. This fwd
if enabled after TxPP enablement, causes multiple calls to
ice_timesync_enable() and ice_timesync_disable().

On introducing txpp_ena flag in adapter, the multiple calls
is handled.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 16 ++++++++++++++--
 drivers/net/intel/ice/ice_ethdev.h |  2 ++
 2 files changed, 16 insertions(+), 2 deletions(-)

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
index 6478d6dfbd..d9f857b81b 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -668,6 +668,8 @@ struct ice_adapter {
 	uint8_t ptp_tx_index;
 	bool ptp_ena;
 	uint64_t time_hw;
+	/* For TxPP */
+	bool txpp_ena;
 	struct ice_fdir_prof_info fdir_prof_info[ICE_MAX_PTGS];
 	struct ice_rss_prof_info rss_prof_info[ICE_MAX_PTGS];
 	/* True if DCF state of the associated PF is on */
-- 
2.47.1

