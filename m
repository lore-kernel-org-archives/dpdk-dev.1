Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF96CCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 18:06:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20A6040DC9;
	Wed,  5 Nov 2025 19:06:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 00EA540A84;
 Wed,  5 Nov 2025 19:06:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762365970; x=1793901970;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yIOx4JgD1MM7bs8p8Fvvd0zSalL20Ov4i5ftRP9mR98=;
 b=a2QjpUiKDM5Vv8CXElJ+C450A3dE+SsZbAuF6bXfd+ZKrTY1Gr+Ss2nq
 /0eN/9oa53+jsLwfQ/wbCaBch+d2tsdcBSMtS8nJFsgisH9VuL931E0ss
 MLTwbcvhiQkzpQsXwcVszViJf664VOmmJcxftNGS3XfTxBrELUwomkJD1
 Strf241ldQswNQGwwfRSrqjtECpd87r3QliQ9KgBsny4gb4R2KoM0QaWy
 WT+iDqJcHci/f+OgtwxKCKzNtgmtOaR8cXMdIzh46PzOBaA3kNFavyWUu
 wSfNtVp73d86U5BwLFlV+wS/U4wSXrL9lXVcJIfJtN41HSTKuUENTShxt A==;
X-CSE-ConnectionGUID: W+vrSmyzR86P0eu0A7crDA==
X-CSE-MsgGUID: JTVHPqjxTMy4ph/c73MY+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="75842006"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; d="scan'208";a="75842006"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 10:06:09 -0800
X-CSE-ConnectionGUID: JF7z85kDRRqZNiejAeKPuw==
X-CSE-MsgGUID: T/PwGhvBTFOJaXHRL73kww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; d="scan'208";a="187368634"
Received: from fenlix-mobl.ccr.corp.intel.com (HELO localhost.intel.com)
 ([10.239.252.5])
 by fmviesa006.fm.intel.com with ESMTP; 05 Nov 2025 10:06:06 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: rajesh3.kumar@intel.com, aman.deep.singh@intel.com,
 manoj.kumar.subbarao@intel.com, stable@dpdk.org
Subject: [PATCH v3 2/4] net/ice: fix PTP clock corruption with TxPP
Date: Thu,  6 Nov 2025 01:46:35 -0500
Message-ID: <20251106064638.23020-3-soumyadeep.hore@intel.com>
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

On enabling TxPP PTP clock was getting corrupted as timesync was enabled
on during setup. Currently timesync will be enabled during start of tx
queue, hence enabling PHC clock to get updated on starting and stopping
of ports.

Earlier when timesync was enabled in tx queue setup, on stopping ports
time will reset back to 0. Currently after every port restart PHC clock
will be set to current system CLOCK_REALTIME.

Fixes: 0b6ff09a1f19 ("net/intel: support Tx packet pacing for E830")
Cc: stable@dpdk.org

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 6 ++++++
 drivers/net/intel/ice/ice_rxtx.c   | 2 --
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 4669eba7c7..3eef4303e9 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -2893,6 +2893,9 @@ ice_dev_stop(struct rte_eth_dev *dev)
 	/* disable all queue interrupts */
 	ice_vsi_disable_queues_intr(main_vsi);
 
+	if (dev->data->dev_conf.txmode.offloads & RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP)
+		ice_timesync_disable(dev);
+
 	if (pf->adapter->devargs.link_state_on_close == ICE_LINK_UP ||
 			(pf->adapter->devargs.link_state_on_close == ICE_LINK_INITIAL &&
 				pf->init_link_up))
@@ -4433,6 +4436,9 @@ ice_dev_start(struct rte_eth_dev *dev)
 		}
 	}
 
+	if (dev->data->dev_conf.txmode.offloads & RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP)
+		ice_timesync_enable(dev);
+
 	return 0;
 
 	/* stop the started queues if failed to start all queues */
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index fd0b3a7532..2673e885c3 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -1181,7 +1181,6 @@ ice_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	if (txq->tsq != NULL && txq->tsq->ts_flag > 0) {
 		struct ice_aqc_ena_dis_txtime_qgrp txtime_pg;
 
-		dev->dev_ops->timesync_disable(dev);
 		status = ice_aq_ena_dis_txtimeq(hw, q_ids[0], 1, 0, &txtime_pg, NULL);
 		if (status != ICE_SUCCESS) {
 			PMD_DRV_LOG(DEBUG, "Failed to disable Tx time queue");
@@ -1671,7 +1670,6 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
 			PMD_INIT_LOG(ERR, "Cannot register Tx mbuf field/flag for timestamp");
 			return -EINVAL;
 		}
-		dev->dev_ops->timesync_enable(dev);
 
 		txq->tsq->nb_ts_desc = ice_calc_ts_ring_count(ICE_VSI_TO_HW(vsi), txq->nb_tx_desc);
 		ring_size = sizeof(struct ice_ts_desc) * txq->tsq->nb_ts_desc;
-- 
2.47.1

