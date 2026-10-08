Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7850CA6007
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 04:17:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95F1F4027B;
	Thu,  8 Oct 2026 06:17:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id B0C75400D6;
 Thu,  8 Oct 2026 06:17:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791433048; x=1822969048;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+53K3TRTuXverD95QjwtQk46xS+b7T91exOO0hpGTdg=;
 b=gr9o8JkUfV70P15CavKAQ8sEowNwAN6UWSXMoqWpnJSCY5NX0on2b1EG
 YNzaLQ/0pHPZVdSCBHAkQ1a1l3Hq/1/ZxO9ukXAQrkSa0k/DggbH1twaD
 vz3VytjIgs+2xWX4dNhWlFD1eew15ubaBW1l6IhPtBMNqc6HR0MsmIprf
 4faa7ShZLFvJ+oJN+TMhm729AVjUMZZ3SRN/fUO/4xX2QW0+hUtqF9D3X
 FjIb/U5FnOSnzbv938XFri3rztPB6/v38tt067RFdrtpmX3gZb0Jmt0Sc
 5K6nYUdO01B2Yr+Hl2psTzjOTZDyw0uSzn2A4ho6xOzigZXb59DWn5cG9 g==;
X-CSE-ConnectionGUID: SWkYLo0aR56Ph1EWb+uXfQ==
X-CSE-MsgGUID: TxIR0dDLTOSGTQzU0pwyxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="89586"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="89586"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 21:17:26 -0700
X-CSE-ConnectionGUID: byJXwfFPQmeMeh8BIc9m0w==
X-CSE-MsgGUID: F2xyLwNwQyiXJTo+gxjBcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="2415"
Received: from pae-31.iind.intel.com ([10.49.105.72])
 by fmviesa002.fm.intel.com with ESMTP; 07 Oct 2026 21:17:25 -0700
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Soumyadeep Hore <soumyadeep.hore@intel.com>, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH] net/ice: fix max number of descriptors for E830
Date: Thu,  8 Oct 2026 11:19:28 +0000
Message-Id: <20261008111928.43095-1-sandeep.penigalapati@intel.com>
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

E830 supports at most 8096 descriptors per ring, but the advertised
descriptor limits and the Rx/Tx queue setup checks used the generic
maximum of 8160. Only the ring allocation honoured the E830 limit.

An application could therefore request up to 8160 descriptors on E830.
With Tx packet pacing enabled, the Tx time queue length (Tx descriptors
plus a fetch margin) overflows the 13-bit queue length field, wraps to
zero and triggers a Malicious Driver Detection event.

Use ICE_MAX_NUM_DESC_BY_MAC() for the advertised limits and the queue
setup checks so they match the ring allocation.

Fixes: 0b6ff09a1f19 ("net/intel: support Tx packet pacing for E830")
Cc: stable@dpdk.org
Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 6 +++---
 drivers/net/intel/ice/ice_rxtx.c   | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index dfee07c457..fd239031ac 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -4802,17 +4802,17 @@ ice_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	};
 
 	dev_info->rx_desc_lim = (struct rte_eth_desc_lim) {
-		.nb_max = ICE_MAX_RING_DESC,
+		.nb_max = ICE_MAX_NUM_DESC_BY_MAC(hw),
 		.nb_min = ICE_MIN_RING_DESC,
 		.nb_align = ICE_ALIGN_RING_DESC,
 	};
 
 	dev_info->tx_desc_lim = (struct rte_eth_desc_lim) {
-		.nb_max = ICE_MAX_RING_DESC,
+		.nb_max = ICE_MAX_NUM_DESC_BY_MAC(hw),
 		.nb_min = ICE_MIN_RING_DESC,
 		.nb_align = ICE_ALIGN_RING_DESC,
 		.nb_mtu_seg_max = ICE_TX_MTU_SEG_MAX,
-		.nb_seg_max = ICE_MAX_RING_DESC,
+		.nb_seg_max = ICE_MAX_NUM_DESC_BY_MAC(hw),
 	};
 
 	dev_info->speed_capa = RTE_ETH_LINK_SPEED_10M |
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index b333444cbf..dbb32bdb87 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -1293,7 +1293,7 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
 	uint16_t i;
 
 	if (nb_desc % ICE_ALIGN_RING_DESC != 0 ||
-	    nb_desc > ICE_MAX_RING_DESC ||
+	    nb_desc > ICE_MAX_NUM_DESC_BY_MAC(hw) ||
 	    nb_desc < ICE_MIN_RING_DESC) {
 		PMD_INIT_LOG(ERR, "Number (%u) of receive descriptors is "
 			     "invalid", nb_desc);
@@ -1510,7 +1510,7 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
 	offloads = tx_conf->offloads | dev->data->dev_conf.txmode.offloads;
 
 	if (nb_desc % ICE_ALIGN_RING_DESC != 0 ||
-	    nb_desc > ICE_MAX_RING_DESC ||
+	    nb_desc > ICE_MAX_NUM_DESC_BY_MAC(hw) ||
 	    nb_desc < ICE_MIN_RING_DESC) {
 		PMD_INIT_LOG(ERR, "Number (%u) of transmit descriptors is "
 			     "invalid", nb_desc);
-- 
2.34.1

