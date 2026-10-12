Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2099CA9ED0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 09:10:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA06D40274;
	Mon, 12 Oct 2026 11:10:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id CCC5740272;
 Mon, 12 Oct 2026 11:10:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791796226; x=1823332226;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nwZ/WbdwddPs8I1C8/oT/n7I5GWXhkeSYAgASW0tOA4=;
 b=DTQZySgU/XtCjrObd2ZnyXiBZRvE2huLsHzIln92IuEk2lg3nYVNH+gr
 57WIMCuasJB14q/eQCwMkMJN+b96HACcwcAuWYLbMwt0fPFN0he21wbKv
 CMzHxSn38jY67b2QT8MbeljKbSqUpTM/5fE2cV2xRE/pqA3OA2r+CwOfl
 Rd2bWNaimvgoL1ELS3uuUAjQ83nU0+x8cv8L3sbQfboPNDEH/AE499I8c
 gkZSffjyGMHk8bv8ar0iud+vChkuPR9xmBav4/K0sG6RXansZlsYgJGOp
 OSGnw4OOYw/FzsD/QSRNC0hH9qX4J0+rKnztuu3lXxDsItEvGTbCGx/pR A==;
X-CSE-ConnectionGUID: o2kS4ydjRxKbc6BahRTTYA==
X-CSE-MsgGUID: BNHAw0hSQAybHqsvG5wD/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="386665"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="386665"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 02:10:24 -0700
X-CSE-ConnectionGUID: 6sZPSTIpQOmMdRGQzfCkBA==
X-CSE-MsgGUID: RiOQJRQYTYGXlf0p+qiYdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1149670"
Received: from pae-31.iind.intel.com ([10.49.105.72])
 by fmviesa008.fm.intel.com with ESMTP; 12 Oct 2026 02:10:21 -0700
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, bruce.richardson@intel.com,
 anatoly.burakov@intel.com, soumyadeep.hore@intel.com, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH v2] net/ice: fix max number of descriptors for E830
Date: Mon, 12 Oct 2026 16:12:26 +0000
Message-Id: <20261012161226.130164-1-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008111928.43095-1-sandeep.penigalapati@intel.com>
References: <20261008111928.43095-1-sandeep.penigalapati@intel.com>
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
v2:
  - No functional change. Added a short comment on the descriptor-limit
    defines pointing ring-facing limits at ICE_MAX_NUM_DESC_BY_MAC(),
    per review feedback.
 drivers/net/intel/ice/ice_ethdev.c | 6 +++---
 drivers/net/intel/ice/ice_rxtx.c   | 4 ++--
 drivers/net/intel/ice/ice_rxtx.h   | 4 ++++
 3 files changed, 9 insertions(+), 5 deletions(-)

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
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index cd23f7c56f..62d32185fc 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -22,6 +22,10 @@
 
 #define ICE_ALIGN_RING_DESC  32
 #define ICE_MIN_RING_DESC    64
+/*
+ * E830 needs a lower cap, so use ICE_MAX_NUM_DESC_BY_MAC() for ring
+ * limits rather than ICE_MAX_RING_DESC directly.
+ */
 #define ICE_MAX_RING_DESC    (8192 - 32)
 #define ICE_MAX_RING_DESC_E830	  8096
 #define ICE_MAX_NUM_DESC_BY_MAC(hw) ((hw)->phy_model == \
-- 
2.34.1

