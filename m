Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FDDC87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 19:08:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCE3D402E1;
	Thu,  7 Aug 2025 21:08:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 4B28140150;
 Thu,  7 Aug 2025 21:08:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754593719; x=1786129719;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=L5KLfteS3RIeTMvd8x5+PNenD/HK5Lbrl11KOJty7BM=;
 b=BUvfayWpDrX5sBasrzFQi7wcHHbkbZkMrPh5nxP2JVdn++Dkaibv1Mc4
 NXprKaMqgu4qjCPJXqaEt1NGSxwC5eKoF0w+O9kSNApHQFMFC12iltwic
 /STlRKDnvVfwgyskxPPRbVHGnqqDyV2KktPqw/ByMn0klbNGv6iDT/4B4
 7Q9GcL/t6ohIN0wopSMMpyNXQXfwAEJzHX8MWNU3U2RmM7uaZl66AI8nW
 NUr+ul3utLs/v7Ug9abwc01H/ZuB7QY3lkXu+ROiKXkGznfbFa9zKBguj
 TbsqXcs+uJnqLnHeB3XIunZdC9zIDLGtAW/edK9+DXNXY7TT8rLvRfJLi w==;
X-CSE-ConnectionGUID: BYgJNENRSNyWGR/BkkambA==
X-CSE-MsgGUID: 1uT6ecrvTpGDJw5F8sm+fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="67532730"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="67532730"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 12:08:37 -0700
X-CSE-ConnectionGUID: SqdxX5o0TMu7IO+hfMmGDQ==
X-CSE-MsgGUID: g9dJ5vYDR82+DD/McR9uPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="169602124"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by orviesa004.jf.intel.com with ESMTP; 07 Aug 2025 12:08:36 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2] net/ice: fix VLAN tag reporting on Rx
Date: Thu,  7 Aug 2025 20:08:26 +0100
Message-ID: <20250807190826.327466-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714161050.289375-1-bruce.richardson@intel.com>
References: <20250714161050.289375-1-bruce.richardson@intel.com>
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
Acked-by: Ciara Loftus <ciara.loftus@intel.com>
---
V2: remove extra unnecessary defines
---
 drivers/net/intel/ice/ice_ethdev.c | 83 ++----------------------------
 1 file changed, 3 insertions(+), 80 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 513777e372..6c65a8341a 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -65,14 +65,6 @@ static const char * const ice_valid_args[] = {
 /* Maximum number of VSI */
 #define ICE_MAX_NUM_VSIS          (768UL)
 
-/* The 119 bit offset of the LAN Rx queue context is the L2TSEL control bit. */
-#define ICE_L2TSEL_QRX_CONTEXT_REG_IDX	3
-#define ICE_L2TSEL_BIT_OFFSET		   23
-enum ice_l2tsel {
-	ICE_L2TSEL_EXTRACT_FIRST_TAG_L2TAG2_2ND,
-	ICE_L2TSEL_EXTRACT_FIRST_TAG_L2TAG1,
-};
-
 struct proto_xtr_ol_flag {
 	const struct rte_mbuf_dynflag param;
 	bool required;
@@ -4965,49 +4957,12 @@ ice_vsi_config_vlan_stripping(struct ice_vsi *vsi, bool ena)
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
@@ -5019,41 +4974,9 @@ ice_vsi_config_outer_vlan_stripping(struct ice_vsi *vsi, bool on)
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

