Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45069C7EE30
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 12:52:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE10D40E41;
	Wed, 25 Jun 2025 14:52:06 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id 65F4740E1B
 for <dev@dpdk.org>; Wed, 25 Jun 2025 14:52:05 +0200 (CEST)
X-QQ-mid: esmtpsz21t1750855920t42428ebd
X-QQ-Originating-IP: wDkHSFddIURmBGS69P0KPUN79sIZU7+AVzZTHM/zUDY=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.80.242])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 25 Jun 2025 20:51:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15989412625444593448
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v2 06/15] net/txgbe: add RX&TX support for Amber-Lite NICs
Date: Wed, 25 Jun 2025 20:50:38 +0800
Message-Id: <20250625125047.18072-7-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250625125047.18072-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250625125047.18072-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: OFJyAfS/PcDYdkg6pbe3Bd3UrHk2GZpVP7d/HHk/wnoAR+vKLwiw16f/
 3SNLw0S31utShLBDMH2l63ITkoxDu8Wj9zoN/JqOnqIra2HZSvqntns32CoqReP8P7MXrto
 ab8AkLwZKN40rkK5PwRyBHHuTarQT4tydavNvE2G2K0TF3oVxlesRjQyobf2Biwf6X+u8Ai
 FcY61ImpaX+a1xU8eByNvSAbVL3pSenF/63RPRLsTJ7wuaAaJudt+9/QosTwlJr3KfP6j7g
 gXuqffF0dDb9uaSa5EhieX3di3w0CyS8YHPdwAuJujpaBj1OHTJ8eLoRD916NPCK+cra+eO
 nOcOOBjxcUrfdQhelzuUxW+YbVntxiOYTUQuadtehZ0oGVLbyAsLQC7/8fn7bQIjnaT8NPE
 v332O6n/Mv8JIuL2lYO4Zb8qZWl75PswBUofBWQQU6pmHYWi8u1CFimk4bJwTYiYpdolE94
 0/eH28YD5BxyEi7Uk35bhZSBZum7JzTCulymZrC4yXNrEQtNeTvKqVKd2XAYgVUmwaDfG/B
 HpGpWPgeFINYgMo+p1duuXxe8NVCmA8cvcgxJOjsrk3j4vzMDu+1sja1vA8tY+4MYCmpS6m
 8OPuHYCR3D7fWpN1i6jsvq7zDA6CV8RMmYZ3fKQy2vz9cE31raOz3o2GJEgBsOQI5KHcy77
 UOnjV08z3bK9inrwn46YLazd9eoGCzyY01XyEFdF98rzLElL128OLedOrrbe6RXO/cEjx1f
 qvd6o67O9l2MjyyneYf4oUVqfW3Xz7hVriK+6BTRymFnTvrJQXZR1flSxsr5koOfCz0lyZB
 wfPhe7f2D+rwzID2IMlqWxlnj9tHOBq66cEbw+Qs2JlU2OND9khIaZJQ3PFFAPMh7379hy/
 /5fyWqjzgOo1qbKIieKxueOntEutrrqcWdRmIKFqKGhzZWT2GGfeOOLmT2iiyuoBALth7dM
 nCjBIV5gWab+BFdejVx4JN1zkJrMCAA7CWGSrSQV6o9YLzq1H055AjXjQF+xOI7IKFiWRZ8
 L+tk55V04gXy0oGiuw8YGYcB0DAHUHPgCJRdm/Hg==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0
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

The packet handling workflow largely reuses the existing 10G NIC’s
process, so we adjusted driver conditional checks rather than making
major changes to the overall flow.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml.c   |  2 +-
 drivers/net/txgbe/base/txgbe_aml.h   |  1 +
 drivers/net/txgbe/base/txgbe_aml40.c |  1 -
 drivers/net/txgbe/base/txgbe_hw.c    | 27 ++++++++++++
 drivers/net/txgbe/base/txgbe_hw.h    |  2 +
 drivers/net/txgbe/base/txgbe_regs.h  | 30 +++++++++++++
 drivers/net/txgbe/txgbe_ethdev.c     | 12 ++++--
 drivers/net/txgbe/txgbe_rxtx.c       | 64 +++++++++++++++-------------
 8 files changed, 104 insertions(+), 35 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml.c b/drivers/net/txgbe/base/txgbe_aml.c
index 510a539d38..368b002c88 100644
--- a/drivers/net/txgbe/base/txgbe_aml.c
+++ b/drivers/net/txgbe/base/txgbe_aml.c
@@ -131,7 +131,7 @@ u32 txgbe_get_media_type_aml(struct txgbe_hw *hw)
 	return media_type;
 }
 
-static void txgbe_wait_for_link_up_aml(struct txgbe_hw *hw, u32 speed)
+void txgbe_wait_for_link_up_aml(struct txgbe_hw *hw, u32 speed)
 {
 	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
 	bool link_up = false;
diff --git a/drivers/net/txgbe/base/txgbe_aml.h b/drivers/net/txgbe/base/txgbe_aml.h
index 18f683a746..e98c952787 100644
--- a/drivers/net/txgbe/base/txgbe_aml.h
+++ b/drivers/net/txgbe/base/txgbe_aml.h
@@ -15,6 +15,7 @@ s32 txgbe_check_mac_link_aml(struct txgbe_hw *hw,
 s32 txgbe_get_link_capabilities_aml(struct txgbe_hw *hw,
 				      u32 *speed, bool *autoneg);
 u32 txgbe_get_media_type_aml(struct txgbe_hw *hw);
+void txgbe_wait_for_link_up_aml(struct txgbe_hw *hw, u32 speed);
 s32 txgbe_setup_mac_link_aml(struct txgbe_hw *hw, u32 speed,
 			       bool autoneg_wait_to_complete);
 void txgbe_init_mac_link_ops_aml(struct txgbe_hw *hw);
diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index 88408550d2..a2e034949e 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -111,7 +111,6 @@ s32 txgbe_setup_mac_link_aml40(struct txgbe_hw *hw,
 	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
 	bool link_up = false;
 	u32 link_capabilities = TXGBE_LINK_SPEED_UNKNOWN;
-	u32 value = 0;
 
 	if (hw->phy.sfp_type == txgbe_sfp_type_not_present) {
 		DEBUGOUT("SFP not detected, skip setup mac link");
diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 1e30d235fd..4fc4b4e284 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -20,6 +20,7 @@
 #define TXGBE_RAPTOR_MC_TBL_SIZE   128
 #define TXGBE_RAPTOR_VFT_TBL_SIZE  128
 #define TXGBE_RAPTOR_RX_PB_SIZE	  512 /*KB*/
+#define TXGBE_AML_RX_PB_SIZE	  768
 
 static s32 txgbe_setup_copper_link_raptor(struct txgbe_hw *hw,
 					 u32 speed,
@@ -2494,6 +2495,29 @@ s32 txgbe_init_shared_code(struct txgbe_hw *hw)
 	return status;
 }
 
+int txgbe_is_vf(struct txgbe_hw *hw)
+{
+	switch (hw->mac.type) {
+	case txgbe_mac_raptor_vf:
+	case txgbe_mac_aml_vf:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+int txgbe_is_pf(struct txgbe_hw *hw)
+{
+	switch (hw->mac.type) {
+	case txgbe_mac_raptor:
+	case txgbe_mac_aml:
+	case txgbe_mac_aml40:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
 /**
  *  txgbe_set_mac_type - Sets MAC type
  *  @hw: pointer to the HW structure
@@ -2903,6 +2927,9 @@ s32 txgbe_init_ops_generic(struct txgbe_hw *hw)
 	mac->max_rx_queues	= TXGBE_RAPTOR_MAX_RX_QUEUES;
 	mac->max_tx_queues	= TXGBE_RAPTOR_MAX_TX_QUEUES;
 
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40)
+		mac->rx_pb_size = TXGBE_AML_RX_PB_SIZE;
+
 	return 0;
 }
 
diff --git a/drivers/net/txgbe/base/txgbe_hw.h b/drivers/net/txgbe/base/txgbe_hw.h
index 476a9688bd..a7e9547430 100644
--- a/drivers/net/txgbe/base/txgbe_hw.h
+++ b/drivers/net/txgbe/base/txgbe_hw.h
@@ -85,6 +85,8 @@ void txgbe_set_mta(struct txgbe_hw *hw, u8 *mc_addr);
 s32 txgbe_negotiate_fc(struct txgbe_hw *hw, u32 adv_reg, u32 lp_reg,
 			u32 adv_sym, u32 adv_asm, u32 lp_sym, u32 lp_asm);
 s32 txgbe_init_shared_code(struct txgbe_hw *hw);
+int txgbe_is_vf(struct txgbe_hw *hw);
+int txgbe_is_pf(struct txgbe_hw *hw);
 s32 txgbe_set_mac_type(struct txgbe_hw *hw);
 s32 txgbe_init_ops_generic(struct txgbe_hw *hw);
 void txgbe_init_ops_sp(struct txgbe_hw *hw);
diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 4777b0335b..7830abac7b 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -318,12 +318,18 @@
 #define   TXGBE_LEDCTL_1G		MS(2, 0x1)
 #define   TXGBE_LEDCTL_100M		MS(3, 0x1)
 #define   TXGBE_LEDCTL_ACTIVE		MS(4, 0x1)
+#define TXGBE_LINKUP_FILTER             0x014428
 #define TXGBE_TAGTPID(i)                (0x014430 + (i) * 4) /* 0-3 */
 #define   TXGBE_TAGTPID_LSB_MASK        MS(0, 0xFFFF)
 #define   TXGBE_TAGTPID_LSB(v)          LS(v, 0, 0xFFFF)
 #define   TXGBE_TAGTPID_MSB_MASK        MS(16, 0xFFFF)
 #define   TXGBE_TAGTPID_MSB(v)          LS(v, 16, 0xFFFF)
 
+/*AML LINK STATUS OVERWRITE*/
+#define TXGBE_AML_EPCS_MISC_CTL         0x13240
+#define TXGBE_AML_LINK_STATUS_OVRD_EN   0x00000020
+#define TXGBE_AML_LINK_STATUS_OVRD_VAL  0x00000010
+
 /**
  * GPIO Control
  * P0: link speed change
@@ -1389,6 +1395,7 @@ enum txgbe_5tuple_protocol {
 #define   TXGBE_TXCFG_HTHRESH_MASK      MS(8, 0xF)
 #define   TXGBE_TXCFG_HTHRESH(v)        LS(v, 8, 0xF)
 #define   TXGBE_TXCFG_WTHRESH_MASK      MS(16, 0x7F)
+#define   TXGBE_TXCFG_WTHRESH_MASK_AML  MS(16, 0x1FF)
 #define   TXGBE_TXCFG_WTHRESH(v)        LS(v, 16, 0x7F)
 #define   TXGBE_TXCFG_FLUSH             MS(26, 0x1)
 
@@ -1634,6 +1641,16 @@ enum txgbe_5tuple_protocol {
 #define   TXGBE_ARBRXCTL_WSP            MS(2, 0x1)
 #define   TXGBE_ARBRXCTL_DIA            MS(6, 0x1)
 
+#define TXGBE_RDM_VF_RE(_i)     (0x12004 + ((_i) * 4))
+#define TXGBE_RDM_VFRE_CLR(_i)  (0x120A0 + ((_i) * 4))
+#define TXGBE_RDM_RSC_CTL       0x1200C
+/* amlite: rdm_rsc_ctl_free_ctl */
+#define TXGBE_RDM_RSC_CTL_FREE_CTL      MS(7, 0x1)
+#define TXGBE_RDM_RSC_CTL_FREE_CNT_DIS  MS(8, 0x1)
+#define TXGBE_RDM_ARB_CFG(_i)   (0x12040 + ((_i) * 4)) /* 8 of these (0-7) */
+#define TXGBE_RDM_PF_QDE(_i)    (0x12080 + ((_i) * 4))
+#define TXGBE_RDM_PF_HIDE(_i)   (0x12090 + ((_i) * 4))
+
 #define TXGBE_RPUP2TC                   0x019008
 #define   TXGBE_RPUP2TC_UP_SHIFT        3
 #define   TXGBE_RPUP2TC_UP_MASK         0x7
@@ -1708,6 +1725,19 @@ enum txgbe_5tuple_protocol {
 #define   TXGBE_MACTXCFG_SPEED_10G      LS(0, 29, 0x3)
 #define   TXGBE_MACTXCFG_SPEED_1G       LS(3, 29, 0x3)
 
+#define TXGBE_MAC_TX_CFG_AML_SPEED_MASK     0x78000000U
+#define TXGBE_MAC_TX_CFG_AML_SPEED_50G      0x20000000U
+#define TXGBE_MAC_TX_CFG_AML_SPEED_40G      0x00000000U
+#define TXGBE_MAC_TX_CFG_AML_SPEED_25G      0x10000000U
+#define TXGBE_MAC_TX_CFG_AML_SPEED_10G      0x40000000U
+#define TXGBE_MAC_TX_CFG_AML_SPEED_1G       0x70000000U
+
+#define TXGBE_MAC_MISC_CTL              0x11f00
+#define TXGBE_MAC_MISC_LINK_STS_MOD     MS(0, 0x1)
+#define TXGBE_LINK_BOTH_PCS_MAC         MS(0, 0x1)
+
+#define TXGBE_EPHY_STAT                 0x13404
+#define TXGBE_EPHY_STAT_PPL_LOCK        0x3
 #define TXGBE_ISBADDRL                  0x000160
 #define TXGBE_ISBADDRH                  0x000164
 
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index e6b7775f3a..cba1e8f2a7 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -385,7 +385,7 @@ txgbe_dev_queue_stats_mapping_set(struct rte_eth_dev *eth_dev,
 	uint32_t q_map;
 	uint8_t n, offset;
 
-	if (hw->mac.type != txgbe_mac_raptor)
+	if (!txgbe_is_pf(hw))
 		return -ENOSYS;
 
 	if (stat_idx & ~QMAP_FIELD_RESERVED_BITS_MASK)
@@ -1806,7 +1806,7 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 	}
 
 	/* Skip link setup if loopback mode is enabled. */
-	if (hw->mac.type == txgbe_mac_raptor &&
+	if (txgbe_is_pf(hw) &&
 	    dev->data->dev_conf.lpbk_mode)
 		goto skip_link_setup;
 
@@ -2816,6 +2816,7 @@ txgbe_dev_sfp_event(struct rte_eth_dev *dev)
 
 	wr32(hw, TXGBE_GPIOINTMASK, 0xFF);
 	reg = rd32(hw, TXGBE_GPIORAWINTSTAT);
+
 	if (reg & TXGBE_GPIOBIT_0)
 		wr32(hw, TXGBE_GPIOEOI, TXGBE_GPIOBIT_0);
 	if (reg & TXGBE_GPIOBIT_2) {
@@ -3078,8 +3079,13 @@ txgbe_dev_link_update_share(struct rte_eth_dev *dev,
 		break;
 	}
 
+	/* enable mac receiver */
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
+		wr32m(hw, TXGBE_MACRXCFG, TXGBE_MACRXCFG_ENA, TXGBE_MACRXCFG_ENA);
+	}
+
 	/* Re configure MAC RX */
-	if (hw->mac.type == txgbe_mac_raptor) {
+	if (txgbe_is_pf(hw)) {
 		reg = rd32(hw, TXGBE_MACRXCFG);
 		wr32(hw, TXGBE_MACRXCFG, reg);
 		wr32m(hw, TXGBE_MACRXFLT, TXGBE_MACRXFLT_PROMISC,
diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index 4e4b78fb43..558ffbf73f 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -74,19 +74,6 @@ static const u64 TXGBE_TX_OFFLOAD_MASK = (RTE_MBUF_F_TX_IP_CKSUM |
  */
 #define rte_txgbe_prefetch(p)   rte_prefetch0(p)
 
-static int
-txgbe_is_vf(struct rte_eth_dev *dev)
-{
-	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
-
-	switch (hw->mac.type) {
-	case txgbe_mac_raptor_vf:
-		return 1;
-	default:
-		return 0;
-	}
-}
-
 /*********************************************************************
  *
  *  TX functions
@@ -2110,7 +2097,7 @@ txgbe_get_rx_port_offloads(struct rte_eth_dev *dev)
 		   RTE_ETH_RX_OFFLOAD_RSS_HASH |
 		   RTE_ETH_RX_OFFLOAD_SCATTER;
 
-	if (!txgbe_is_vf(dev))
+	if (!txgbe_is_vf(hw))
 		offloads |= (RTE_ETH_RX_OFFLOAD_VLAN_FILTER |
 			     RTE_ETH_RX_OFFLOAD_QINQ_STRIP |
 			     RTE_ETH_RX_OFFLOAD_VLAN_EXTEND);
@@ -2119,10 +2106,10 @@ txgbe_get_rx_port_offloads(struct rte_eth_dev *dev)
 	 * RSC is only supported by PF devices in a non-SR-IOV
 	 * mode.
 	 */
-	if (hw->mac.type == txgbe_mac_raptor && !sriov->active)
+	if (txgbe_is_pf(hw) && !sriov->active)
 		offloads |= RTE_ETH_RX_OFFLOAD_TCP_LRO;
 
-	if (hw->mac.type == txgbe_mac_raptor)
+	if (txgbe_is_pf(hw))
 		offloads |= RTE_ETH_RX_OFFLOAD_MACSEC_STRIP;
 
 	offloads |= RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM;
@@ -2361,6 +2348,7 @@ uint64_t
 txgbe_get_tx_port_offloads(struct rte_eth_dev *dev)
 {
 	uint64_t tx_offload_capa;
+	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 
 	tx_offload_capa =
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |
@@ -2378,7 +2366,7 @@ txgbe_get_tx_port_offloads(struct rte_eth_dev *dev)
 		RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO	|
 		RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
-	if (!txgbe_is_vf(dev))
+	if (!txgbe_is_vf(hw))
 		tx_offload_capa |= RTE_ETH_TX_OFFLOAD_QINQ_INSERT;
 
 	tx_offload_capa |= RTE_ETH_TX_OFFLOAD_MACSEC_INSERT;
@@ -2496,7 +2484,7 @@ txgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	/* Modification to set tail pointer for virtual function
 	 * if vf is detected.
 	 */
-	if (hw->mac.type == txgbe_mac_raptor_vf) {
+	if (txgbe_is_vf(hw)) {
 		txq->tdt_reg_addr = TXGBE_REG_ADDR(hw, TXGBE_TXWP(queue_idx));
 		txq->tdc_reg_addr = TXGBE_REG_ADDR(hw, TXGBE_TXCFG(queue_idx));
 	} else {
@@ -2789,7 +2777,7 @@ txgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	/*
 	 * Modified to setup VFRDT for Virtual Function
 	 */
-	if (hw->mac.type == txgbe_mac_raptor_vf) {
+	if (txgbe_is_vf(hw)) {
 		rxq->rdt_reg_addr =
 			TXGBE_REG_ADDR(hw, TXGBE_RXWP(queue_idx));
 		rxq->rdh_reg_addr =
@@ -3035,7 +3023,7 @@ txgbe_rss_disable(struct rte_eth_dev *dev)
 	struct txgbe_hw *hw;
 
 	hw = TXGBE_DEV_HW(dev);
-	if (hw->mac.type == txgbe_mac_raptor_vf)
+	if (txgbe_is_vf(hw))
 		wr32m(hw, TXGBE_VFPLCFG, TXGBE_VFPLCFG_RSSENA, 0);
 	else
 		wr32m(hw, TXGBE_RACTL, TXGBE_RACTL_RSSENA, 0);
@@ -3072,7 +3060,7 @@ txgbe_dev_rss_hash_update(struct rte_eth_dev *dev,
 
 	/* Set configured hashing protocols */
 	rss_hf = rss_conf->rss_hf & TXGBE_RSS_OFFLOAD_ALL;
-	if (hw->mac.type == txgbe_mac_raptor_vf) {
+	if (txgbe_is_vf(hw)) {
 		mrqc = rd32(hw, TXGBE_VFPLCFG);
 		mrqc &= ~TXGBE_VFPLCFG_RSSMASK;
 		if (rss_hf & RTE_ETH_RSS_IPV4)
@@ -3156,7 +3144,7 @@ txgbe_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
 	}
 
 	rss_hf = 0;
-	if (hw->mac.type == txgbe_mac_raptor_vf) {
+	if (txgbe_is_vf(hw)) {
 		mrqc = rd32(hw, TXGBE_VFPLCFG);
 		if (mrqc & TXGBE_VFPLCFG_RSSIPV4)
 			rss_hf |= RTE_ETH_RSS_IPV4;
@@ -3610,6 +3598,8 @@ txgbe_dcb_hw_arbite_tx_config(struct txgbe_hw *hw, uint16_t *refill,
 {
 	switch (hw->mac.type) {
 	case txgbe_mac_raptor:
+	case txgbe_mac_aml:
+	case txgbe_mac_aml40:
 		txgbe_dcb_config_tx_desc_arbiter_raptor(hw, refill,
 							max, bwg_id, tsa);
 		txgbe_dcb_config_tx_data_arbiter_raptor(hw, refill,
@@ -4537,7 +4527,7 @@ txgbe_dev_rx_init(struct rte_eth_dev *dev)
 	 * If loopback mode is configured, set LPBK bit.
 	 */
 	hlreg0 = rd32(hw, TXGBE_PSRCTL);
-	if (hw->mac.type == txgbe_mac_raptor &&
+	if (txgbe_is_pf(hw) &&
 	    dev->data->dev_conf.lpbk_mode)
 		hlreg0 |= TXGBE_PSRCTL_LBENA;
 	else
@@ -4622,7 +4612,7 @@ txgbe_dev_rx_init(struct rte_eth_dev *dev)
 
 	wr32(hw, TXGBE_PSRCTL, rxcsum);
 
-	if (hw->mac.type == txgbe_mac_raptor) {
+	if (txgbe_is_pf(hw)) {
 		rdrxctl = rd32(hw, TXGBE_SECRXCTL);
 		if (rx_conf->offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC)
 			rdrxctl &= ~TXGBE_SECRXCTL_CRCSTRIP;
@@ -4712,11 +4702,18 @@ txgbe_dev_rxtx_start(struct rte_eth_dev *dev)
 	for (i = 0; i < dev->data->nb_tx_queues; i++) {
 		txq = dev->data->tx_queues[i];
 		/* Setup Transmit Threshold Registers */
-		wr32m(hw, TXGBE_TXCFG(txq->reg_idx),
-		      TXGBE_TXCFG_HTHRESH_MASK |
-		      TXGBE_TXCFG_WTHRESH_MASK,
-		      TXGBE_TXCFG_HTHRESH(txq->hthresh) |
-		      TXGBE_TXCFG_WTHRESH(txq->wthresh));
+		if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40)
+			wr32m(hw, TXGBE_TXCFG(txq->reg_idx),
+			      TXGBE_TXCFG_HTHRESH_MASK |
+			      TXGBE_TXCFG_WTHRESH_MASK_AML,
+			      TXGBE_TXCFG_HTHRESH(txq->hthresh) |
+			      TXGBE_TXCFG_WTHRESH(txq->wthresh));
+		else
+			wr32m(hw, TXGBE_TXCFG(txq->reg_idx),
+			      TXGBE_TXCFG_HTHRESH_MASK |
+			      TXGBE_TXCFG_WTHRESH_MASK,
+			      TXGBE_TXCFG_HTHRESH(txq->hthresh) |
+			      TXGBE_TXCFG_WTHRESH(txq->wthresh));
 	}
 
 	dmatxctl = rd32(hw, TXGBE_DMATXCTRL);
@@ -4741,13 +4738,20 @@ txgbe_dev_rxtx_start(struct rte_eth_dev *dev)
 		}
 	}
 
+	/* enable mac transmitter */
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
+		wr32(hw, TXGBE_SECTXCTL, 0);
+		wr32m(hw, TXGBE_MACTXCFG,
+			  TXGBE_MACTXCFG_TXE, TXGBE_MACTXCFG_TXE);
+	}
+
 	/* Enable Receive engine */
 	rxctrl = rd32(hw, TXGBE_PBRXCTL);
 	rxctrl |= TXGBE_PBRXCTL_ENA;
 	hw->mac.enable_rx_dma(hw, rxctrl);
 
 	/* If loopback mode is enabled, set up the link accordingly */
-	if (hw->mac.type == txgbe_mac_raptor &&
+	if (txgbe_is_pf(hw) &&
 	    dev->data->dev_conf.lpbk_mode)
 		txgbe_setup_loopback_link_raptor(hw);
 
-- 
2.21.0.windows.1

