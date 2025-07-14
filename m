Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAE5C83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 16:11:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 412F84026B;
	Mon, 14 Jul 2025 18:10:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 91D0E4021F;
 Mon, 14 Jul 2025 18:10:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752509458; x=1784045458;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=57d1hf1e3Umv7TixfNErrL81oIhaJwacJYES1y27osc=;
 b=FilyujMNtz1iMK05OBABPWb3Jc4HZNEWXaRmif5r6/fhUayUFhL+jbAv
 2O2JA3E30IXtbkGIlwjgkBicGz67SIzw6kkgvDfIEzrsYsWG9maCnCugs
 tf9asnJiHIi6c0TnwRG9hy0p1QHMuGMIkBfhbnAGVkECqePSv4Z0kDzmS
 n0ggElbL4NWFxYjEyuGKlpR3O6W6OSJeNtzQRCK2DYlaqL6JCJyx8PwKb
 1etn3O1nj9xa/qzbpuD5QmxaAd/T/NYAiTbd84y9oKn0y1kNEmIP5p2cb
 Hoyik00t2RLPCIQvsSVSBVSuCOHZ51sSltgnAEzNHE4ml9lX6xIZmkQJW g==;
X-CSE-ConnectionGUID: WGUP0kykSUqUa9/zFcAWjw==
X-CSE-MsgGUID: BHdwtF5CTLeoMwMQjWFFTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="80144516"
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; d="scan'208";a="80144516"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 09:10:56 -0700
X-CSE-ConnectionGUID: FaoAAmAwTm+JZwaFDVOWtg==
X-CSE-MsgGUID: VDuEODlFRCGI6wX3SRTABQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; d="scan'208";a="156607137"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa007.fm.intel.com with ESMTP; 14 Jul 2025 09:10:55 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/ice: fix VLAN tag reporting on Rx
Date: Mon, 14 Jul 2025 17:10:50 +0100
Message-ID: <20250714161050.289375-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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

The ice driver expects the first, or outer, VLAN tag in a packet to be
written to the L2TAG1 field of the descriptor, as configured by the
l2tsel field when configuring the queue context initially for the
device. However, when configuring the actual VLAN or QinQ strip
behaviour, that l2tsel field was changed, sending the single/outer vlan
tag to the L2TAG2 field in the descriptor. This meant that it was not
getting picked up correctly by the Rx paths.

This issue has been around for a long time, but was previously
partially hidden by the issue fixed in [1], since due to that bug,
the l2tsel field was not getting overridden in the single-queue case
(since the single queue was the final queue).

Fix the issue by just removing the code updating the l2tsel field, and
leave it as set by default in the initial queue configuration.

[1] https://github.com/DPDK/dpdk/commit/4cd8c72f6

Fixes: de5da9d16430 ("net/ice: support double VLAN")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 75 ++----------------------------
 1 file changed, 3 insertions(+), 72 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 513777e372..4a6e580628 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -4965,49 +4965,12 @@ ice_vsi_config_vlan_stripping(struct ice_vsi *vsi, bool ena)
 	return ret;
 }
 
-/**
- * ice_vsi_update_l2tsel - update l2tsel field for all Rx rings on this VSI
- * @vsi: VSI used to update l2tsel on
- * @l2tsel: l2tsel setting requested
- *
- * Use the l2tsel setting to update all of the Rx queue context bits for l2tsel.
- * This will modify which descriptor field the first offloaded VLAN will be
- * stripped into.
- */
-static void ice_vsi_update_l2tsel(struct ice_vsi *vsi, enum ice_l2tsel l2tsel)
-{
-	struct ice_hw *hw = ICE_VSI_TO_HW(vsi);
-	struct ice_pf *pf = ICE_VSI_TO_PF(vsi);
-	struct rte_eth_dev_data *dev_data = pf->dev_data;
-	u32 l2tsel_bit;
-	uint16_t i;
-
-	if (l2tsel == ICE_L2TSEL_EXTRACT_FIRST_TAG_L2TAG2_2ND)
-		l2tsel_bit = 0;
-	else
-		l2tsel_bit = BIT(ICE_L2TSEL_BIT_OFFSET);
-
-	for (i = 0; i < dev_data->nb_rx_queues; i++) {
-		const struct ci_rx_queue *rxq = dev_data->rx_queues[i];
-		u32 qrx_context_offset;
-		u32 regval;
-
-		qrx_context_offset = QRX_CONTEXT(ICE_L2TSEL_QRX_CONTEXT_REG_IDX, rxq->reg_idx);
-
-		regval = rd32(hw, qrx_context_offset);
-		regval &= ~BIT(ICE_L2TSEL_BIT_OFFSET);
-		regval |= l2tsel_bit;
-		wr32(hw, qrx_context_offset, regval);
-	}
-}
-
 /* Configure outer vlan stripping on or off in QinQ mode */
 static int
 ice_vsi_config_outer_vlan_stripping(struct ice_vsi *vsi, bool on)
 {
 	uint16_t outer_ethertype = vsi->adapter->pf.outer_ethertype;
 	struct ice_hw *hw = ICE_VSI_TO_HW(vsi);
-	int err = 0;
 
 	if (vsi->vsi_id >= ICE_MAX_NUM_VSIS) {
 		PMD_DRV_LOG(ERR, "VSI ID exceeds the maximum");
@@ -5019,41 +4982,9 @@ ice_vsi_config_outer_vlan_stripping(struct ice_vsi *vsi, bool on)
 		return -EOPNOTSUPP;
 	}
 
-	if (on) {
-		err = ice_vsi_ena_outer_stripping(vsi, outer_ethertype);
-		if (!err) {
-			enum ice_l2tsel l2tsel =
-				ICE_L2TSEL_EXTRACT_FIRST_TAG_L2TAG2_2ND;
-
-			/* PF tells the VF that the outer VLAN tag is always
-			 * extracted to VIRTCHNL_VLAN_TAG_LOCATION_L2TAG2_2 and
-			 * inner is always extracted to
-			 * VIRTCHNL_VLAN_TAG_LOCATION_L2TAG1. This is needed to
-			 * support outer stripping so the first tag always ends
-			 * up in L2TAG2_2ND and the second/inner tag, if
-			 * enabled, is extracted in L2TAG1.
-			 */
-			ice_vsi_update_l2tsel(vsi, l2tsel);
-		}
-	} else {
-		err = ice_vsi_dis_outer_stripping(vsi);
-		if (!err) {
-			enum ice_l2tsel l2tsel =
-				ICE_L2TSEL_EXTRACT_FIRST_TAG_L2TAG1;
-
-			/* PF tells the VF that the outer VLAN tag is always
-			 * extracted to VIRTCHNL_VLAN_TAG_LOCATION_L2TAG2_2 and
-			 * inner is always extracted to
-			 * VIRTCHNL_VLAN_TAG_LOCATION_L2TAG1. This is needed to
-			 * support inner stripping while outer stripping is
-			 * disabled so that the first and only tag is extracted
-			 * in L2TAG1.
-			 */
-			ice_vsi_update_l2tsel(vsi, l2tsel);
-		}
-	}
-
-	return err;
+	return on ?
+		ice_vsi_ena_outer_stripping(vsi, outer_ethertype) :
+		ice_vsi_dis_outer_stripping(vsi);
 }
 
 static int
-- 
2.48.1

