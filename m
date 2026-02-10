Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7014FEA8131
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 15:52:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3342B400D7;
	Tue, 10 Feb 2026 16:52:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id DBA98400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 16:52:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770738735; x=1802274735;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=B7YH2FBdReGv+TAcFRpsbEVVUyPkmaiKY+8nHAF6TOM=;
 b=RC5yPLUv+c8am9sBwweI9/ACBmmtemgXmBTeJBpvW2da0/Ao4BePYaho
 KCKxI/aQElTAyX5NG1F4Wfl4JwGelswbimeiC7wcVRPa9eiUWsKhdc4eL
 7Cu2dgC8pqk0YTaV8HRIXESwKUD9gdNTw1m1ZMBFu01f668RDz0zGzdCT
 a6r1zuYRj2ffVrL0L3v1SV6s5dhIjfn0XL8ZKk0f704s8QZnBYGg5WvLV
 S0W2vJDN0BcftQzToiWD0VDOrjd2gXZC8HGR9/FIUdMRWnHa9KD76oTyE
 S9ZUgDppN5N/ADZ8N0nffgiEF9aT4e2Hcz8Ja79B6xJsZ2Pea/oDuTxv8 Q==;
X-CSE-ConnectionGUID: N8Aj+2yvQomgQQ68dvLAYg==
X-CSE-MsgGUID: fZs3nlXdRwSiXM4A0XZArQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71080887"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71080887"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 07:52:14 -0800
X-CSE-ConnectionGUID: H1bKaTvTR0iEv/w36UKGbA==
X-CSE-MsgGUID: OZTlrPuZSrulO8U5kcVntg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211285370"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 10 Feb 2026 07:52:12 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
 Carolyn Wyborny <carolyn.wyborny@intel.com>
Subject: [PATCH v2 1/7] net/ixgbe: add missing E610 MAC type checks
Date: Tue, 10 Feb 2026 15:52:03 +0000
Message-ID: <23738c8f043b1f65742744caa9b725d5474cb059.1770738711.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <4084ed8c4f7c01852ca22c7975d0639fc4c8a066.1770641909.git.anatoly.burakov@intel.com>
References: <4084ed8c4f7c01852ca22c7975d0639fc4c8a066.1770641909.git.anatoly.burakov@intel.com>
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

A few E610 MAC type checks were missing (verified using E610 datasheet).

Fixes: 316637762a5f ("net/ixgbe/base: enable E610 device")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_bypass_api.h |  8 +-----
 drivers/net/intel/ixgbe/ixgbe_ethdev.c     | 29 ++++++++++++++--------
 drivers/net/intel/ixgbe/ixgbe_fdir.c       |  8 +++---
 drivers/net/intel/ixgbe/ixgbe_flow.c       |  3 ++-
 drivers/net/intel/ixgbe/ixgbe_pf.c         |  5 ++--
 drivers/net/intel/ixgbe/ixgbe_rxtx.c       | 14 +++++++----
 6 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_bypass_api.h b/drivers/net/intel/ixgbe/ixgbe_bypass_api.h
index 6ef965dbb6..eb73bc8b17 100644
--- a/drivers/net/intel/ixgbe/ixgbe_bypass_api.h
+++ b/drivers/net/intel/ixgbe/ixgbe_bypass_api.h
@@ -40,16 +40,10 @@ static s32 ixgbe_bypass_rw_generic(struct ixgbe_hw *hw, u32 cmd, u32 *status)
 		dir_sdo = IXGBE_ESDP_SDP6_DIR;
 		break;
 	case ixgbe_mac_X540:
-		sck = IXGBE_ESDP_SDP2;
-		sdi = IXGBE_ESDP_SDP0;
-		sdo = IXGBE_ESDP_SDP1;
-		dir_sck = IXGBE_ESDP_SDP2_DIR;
-		dir_sdi = IXGBE_ESDP_SDP0_DIR;
-		dir_sdo = IXGBE_ESDP_SDP1_DIR;
-		break;
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
 	case ixgbe_mac_X550EM_a:
+	case ixgbe_mac_E610:
 		sck = IXGBE_ESDP_SDP2;
 		sdi = IXGBE_ESDP_SDP0;
 		sdo = IXGBE_ESDP_SDP1;
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 89a799762f..11500a923c 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -911,7 +911,8 @@ ixgbe_dev_queue_stats_mapping_set(struct rte_eth_dev *eth_dev,
 		(hw->mac.type != ixgbe_mac_X540) &&
 		(hw->mac.type != ixgbe_mac_X550) &&
 		(hw->mac.type != ixgbe_mac_X550EM_x) &&
-		(hw->mac.type != ixgbe_mac_X550EM_a))
+		(hw->mac.type != ixgbe_mac_X550EM_a) &&
+		(hw->mac.type != ixgbe_mac_E610))
 		return -ENOSYS;
 
 	PMD_INIT_LOG(DEBUG, "Setting port %d, %s queue_id %d to stat index %d",
@@ -2134,10 +2135,11 @@ ixgbe_vlan_hw_extend_enable(struct rte_eth_dev *dev)
 	ctrl |= IXGBE_EXTENDED_VLAN;
 	IXGBE_WRITE_REG(hw, IXGBE_CTRL_EXT, ctrl);
 
-	/* Clear pooling mode of PFVTCTL. It's required by X550. */
+	/* Clear pooling mode of PFVTCTL. It's required by X550 and E610. */
 	if (hw->mac.type == ixgbe_mac_X550 ||
 	    hw->mac.type == ixgbe_mac_X550EM_x ||
-	    hw->mac.type == ixgbe_mac_X550EM_a) {
+	    hw->mac.type == ixgbe_mac_X550EM_a ||
+	    hw->mac.type == ixgbe_mac_E610) {
 		ctrl = IXGBE_READ_REG(hw, IXGBE_VT_CTL);
 		ctrl &= ~IXGBE_VT_CTL_POOLING_MODE_MASK;
 		IXGBE_WRITE_REG(hw, IXGBE_VT_CTL, ctrl);
@@ -2830,6 +2832,7 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
 		case ixgbe_mac_X550:
 		case ixgbe_mac_X550EM_x:
 		case ixgbe_mac_X550EM_a:
+		case ixgbe_mac_E610:
 			speed = IXGBE_LINK_SPEED_X550_AUTONEG;
 			break;
 		default:
@@ -4046,10 +4049,11 @@ ixgbe_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	if (hw->mac.type == ixgbe_mac_X540 ||
 	    hw->mac.type == ixgbe_mac_X540_vf ||
 	    hw->mac.type == ixgbe_mac_X550 ||
-	    hw->mac.type == ixgbe_mac_X550_vf) {
+	    hw->mac.type == ixgbe_mac_X550_vf ||
+	    hw->mac.type == ixgbe_mac_E610) {
 		dev_info->speed_capa |= RTE_ETH_LINK_SPEED_100M;
 	}
-	if (hw->mac.type == ixgbe_mac_X550) {
+	if (hw->mac.type == ixgbe_mac_X550 || hw->mac.type == ixgbe_mac_E610) {
 		dev_info->speed_capa |= RTE_ETH_LINK_SPEED_2_5G;
 		dev_info->speed_capa |= RTE_ETH_LINK_SPEED_5G;
 	}
@@ -7665,7 +7669,8 @@ ixgbe_update_e_tag_eth_type(struct ixgbe_hw *hw,
 
 	if (hw->mac.type != ixgbe_mac_X550 &&
 	    hw->mac.type != ixgbe_mac_X550EM_x &&
-	    hw->mac.type != ixgbe_mac_X550EM_a) {
+	    hw->mac.type != ixgbe_mac_X550EM_a &&
+	    hw->mac.type != ixgbe_mac_E610) {
 		return -ENOTSUP;
 	}
 
@@ -7686,7 +7691,8 @@ ixgbe_e_tag_enable(struct ixgbe_hw *hw)
 
 	if (hw->mac.type != ixgbe_mac_X550 &&
 	    hw->mac.type != ixgbe_mac_X550EM_x &&
-	    hw->mac.type != ixgbe_mac_X550EM_a) {
+	    hw->mac.type != ixgbe_mac_X550EM_a &&
+	    hw->mac.type != ixgbe_mac_E610) {
 		return -ENOTSUP;
 	}
 
@@ -7709,7 +7715,8 @@ ixgbe_e_tag_filter_del(struct rte_eth_dev *dev,
 
 	if (hw->mac.type != ixgbe_mac_X550 &&
 	    hw->mac.type != ixgbe_mac_X550EM_x &&
-	    hw->mac.type != ixgbe_mac_X550EM_a) {
+	    hw->mac.type != ixgbe_mac_X550EM_a &&
+	    hw->mac.type != ixgbe_mac_E610) {
 		return -ENOTSUP;
 	}
 
@@ -7745,7 +7752,8 @@ ixgbe_e_tag_filter_add(struct rte_eth_dev *dev,
 
 	if (hw->mac.type != ixgbe_mac_X550 &&
 	    hw->mac.type != ixgbe_mac_X550EM_x &&
-	    hw->mac.type != ixgbe_mac_X550EM_a) {
+	    hw->mac.type != ixgbe_mac_X550EM_a &&
+	    hw->mac.type != ixgbe_mac_E610) {
 		return -ENOTSUP;
 	}
 
@@ -7932,7 +7940,8 @@ ixgbe_e_tag_forwarding_en_dis(struct rte_eth_dev *dev, bool en)
 
 	if (hw->mac.type != ixgbe_mac_X550 &&
 	    hw->mac.type != ixgbe_mac_X550EM_x &&
-	    hw->mac.type != ixgbe_mac_X550EM_a) {
+	    hw->mac.type != ixgbe_mac_X550EM_a &&
+	    hw->mac.type != ixgbe_mac_E610) {
 		return -ENOTSUP;
 	}
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_fdir.c b/drivers/net/intel/ixgbe/ixgbe_fdir.c
index 97ef185583..0bdfbd411a 100644
--- a/drivers/net/intel/ixgbe/ixgbe_fdir.c
+++ b/drivers/net/intel/ixgbe/ixgbe_fdir.c
@@ -650,10 +650,11 @@ ixgbe_fdir_configure(struct rte_eth_dev *dev)
 		hw->mac.type != ixgbe_mac_E610)
 		return -ENOSYS;
 
-	/* x550 supports mac-vlan and tunnel mode but other NICs not */
+	/* x550 and E610 supports mac-vlan and tunnel mode but other NICs not */
 	if (hw->mac.type != ixgbe_mac_X550 &&
 	    hw->mac.type != ixgbe_mac_X550EM_x &&
 	    hw->mac.type != ixgbe_mac_X550EM_a &&
+	    hw->mac.type != ixgbe_mac_E610 &&
 	    mode != RTE_FDIR_MODE_SIGNATURE &&
 	    mode != RTE_FDIR_MODE_PERFECT)
 		return -ENOSYS;
@@ -1130,7 +1131,7 @@ ixgbe_fdir_filter_program(struct rte_eth_dev *dev,
 		return -ENOTSUP;
 
 	/*
-	 * Sanity check for x550.
+	 * Sanity check for x550 and E610.
 	 * When adding a new filter with flow type set to IPv4,
 	 * the flow director mask should be configed before,
 	 * and the L4 protocol and ports are masked.
@@ -1138,7 +1139,8 @@ ixgbe_fdir_filter_program(struct rte_eth_dev *dev,
 	if ((!del) &&
 	    (hw->mac.type == ixgbe_mac_X550 ||
 	     hw->mac.type == ixgbe_mac_X550EM_x ||
-	     hw->mac.type == ixgbe_mac_X550EM_a) &&
+	     hw->mac.type == ixgbe_mac_X550EM_a ||
+	     hw->mac.type == ixgbe_mac_E610) &&
 	    (rule->ixgbe_fdir.formatted.flow_type ==
 	     IXGBE_ATR_FLOW_TYPE_IPV4 ||
 	     rule->ixgbe_fdir.formatted.flow_type ==
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 3b68d820ca..27d2ba1132 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -1361,7 +1361,8 @@ ixgbe_parse_l2_tn_filter(struct rte_eth_dev *dev,
 
 	if (hw->mac.type != ixgbe_mac_X550 &&
 		hw->mac.type != ixgbe_mac_X550EM_x &&
-		hw->mac.type != ixgbe_mac_X550EM_a) {
+		hw->mac.type != ixgbe_mac_X550EM_a &&
+		hw->mac.type != ixgbe_mac_E610) {
 		memset(l2_tn_filter, 0, sizeof(struct ixgbe_l2_tunnel_conf));
 		rte_flow_error_set(error, EINVAL,
 			RTE_FLOW_ERROR_TYPE_ITEM,
diff --git a/drivers/net/intel/ixgbe/ixgbe_pf.c b/drivers/net/intel/ixgbe/ixgbe_pf.c
index e967fe5e48..d9a775f99a 100644
--- a/drivers/net/intel/ixgbe/ixgbe_pf.c
+++ b/drivers/net/intel/ixgbe/ixgbe_pf.c
@@ -558,11 +558,12 @@ ixgbe_set_vf_lpe(struct rte_eth_dev *dev, uint32_t vf, uint32_t *msgbuf)
 	uint32_t max_frs;
 	uint32_t hlreg0;
 
-	/* X540 and X550 support jumbo frames in IOV mode */
+	/* X540, X550, and E610 support jumbo frames in IOV mode */
 	if (hw->mac.type != ixgbe_mac_X540 &&
 		hw->mac.type != ixgbe_mac_X550 &&
 		hw->mac.type != ixgbe_mac_X550EM_x &&
-		hw->mac.type != ixgbe_mac_X550EM_a) {
+		hw->mac.type != ixgbe_mac_X550EM_a &&
+		hw->mac.type != ixgbe_mac_E610) {
 		struct ixgbe_vf_info *vfinfo =
 			*IXGBE_DEV_PRIVATE_TO_P_VFDATA(dev->data->dev_private);
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 0af04c9b0d..2857c19355 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -2707,7 +2707,8 @@ ixgbe_get_tx_port_offloads(struct rte_eth_dev *dev)
 
 	if (hw->mac.type == ixgbe_mac_X550 ||
 	    hw->mac.type == ixgbe_mac_X550EM_x ||
-	    hw->mac.type == ixgbe_mac_X550EM_a)
+	    hw->mac.type == ixgbe_mac_X550EM_a ||
+	    hw->mac.type == ixgbe_mac_E610)
 		tx_offload_capa |= RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM;
 
 #ifdef RTE_LIB_SECURITY
@@ -3166,7 +3167,8 @@ ixgbe_get_rx_port_offloads(struct rte_eth_dev *dev)
 
 	if (hw->mac.type == ixgbe_mac_X550 ||
 	    hw->mac.type == ixgbe_mac_X550EM_x ||
-	    hw->mac.type == ixgbe_mac_X550EM_a)
+	    hw->mac.type == ixgbe_mac_X550EM_a ||
+	    hw->mac.type == ixgbe_mac_E610)
 		offloads |= RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM;
 
 #ifdef RTE_LIB_SECURITY
@@ -3246,7 +3248,7 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 
 	/*
 	 * The packet type in RX descriptor is different for different NICs.
-	 * Some bits are used for x550 but reserved for other NICS.
+	 * Some bits are used for x550 and E610 but reserved for other NICS.
 	 * So set different masks for different NICs.
 	 */
 	if (hw->mac.type == ixgbe_mac_X550 ||
@@ -3254,7 +3256,8 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	    hw->mac.type == ixgbe_mac_X550EM_a ||
 	    hw->mac.type == ixgbe_mac_X550_vf ||
 	    hw->mac.type == ixgbe_mac_X550EM_x_vf ||
-	    hw->mac.type == ixgbe_mac_X550EM_a_vf)
+	    hw->mac.type == ixgbe_mac_X550EM_a_vf ||
+	    hw->mac.type == ixgbe_mac_E610)
 		rxq->pkt_type_mask = IXGBE_PACKET_TYPE_MASK_X550;
 	else
 		rxq->pkt_type_mask = IXGBE_PACKET_TYPE_MASK_82599;
@@ -3506,7 +3509,8 @@ ixgbe_dev_clear_queues(struct rte_eth_dev *dev)
 		if (hw->mac.type == ixgbe_mac_X540 ||
 		     hw->mac.type == ixgbe_mac_X550 ||
 		     hw->mac.type == ixgbe_mac_X550EM_x ||
-		     hw->mac.type == ixgbe_mac_X550EM_a)
+		     hw->mac.type == ixgbe_mac_X550EM_a ||
+		     hw->mac.type == ixgbe_mac_E610)
 			ixgbe_setup_loopback_link_x540_x550(hw, false);
 	}
 }
-- 
2.47.3

