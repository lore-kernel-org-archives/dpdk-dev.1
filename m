Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBDDCCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 10:01:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14D9840DCB;
	Tue, 30 Sep 2025 12:00:42 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id 354D140695
 for <dev@dpdk.org>; Tue, 30 Sep 2025 12:00:38 +0200 (CEST)
X-QQ-mid: esmtpgz13t1759226435t7859a387
X-QQ-Originating-IP: M7jH+/cn6MapuA0BwJdqQEX2HyJhLnynA1gHGzKX3nI=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.164])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 30 Sep 2025 18:00:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3925479006266721470
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v4 07/20] net/txgbe: add RX&TX support for Amber-Lite NICs
Date: Tue, 30 Sep 2025 17:59:39 +0800
Message-Id: <20250930095953.18508-8-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250930095953.18508-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250930095953.18508-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: OKpEC/bXOl3KA+2rTGTj6zIDLCXOXdm1yIm730NfnhyTzAGdRCYl+9Dn
 38qbpey7RNCkfiSGQn+csH/F2V2RhJPl/KJhPs6tQN0aI8HwxkjIw/sB09fPi5KFJ8OL7nt
 4AHNPDkbmLbwBVzD3aLQFwyV9VuEOJ4XHYvLNqT6gy4awBlop7svRPuGZIIY50vURSCVr4P
 9qHwxDDtXA5BihOlfX2M04MsGf1Z7pnKF2gFyGP6oNfuVIGjnIH+HqIX0MIKFFmTSKTFpvJ
 QUiW1d4OgoxtxJBnNvcwV7+TI3EPoC8zWhBeMUOAytaMgWDcmDDQuHAjvaeAfhJIWlWyyJJ
 qGBJAgszQJjItdh0Y1VFD9EqBxjiwB3Fr/78q6a2WDBl04zz6trn8GNHXTOy0dbCT4CrDG6
 iptSnf5jBY855Q+fG3IPijuGFMBx69g/tyuhOFl9vtHbVEFHaA0L/OlGVSGfqkrj/IkrlIm
 kERaGFNxtkDWfAQB0zVosJUXErrufokN5LIOgEuzliysEvHzP/5a44ltmvUdfkjLKXN/bEb
 IyFUOdi6dFTWp3IrchP/ePsIaj01hnYJJtyZO1yE4sB0ZnG/eyFo9cISEDMqaTsy41Au8VH
 hrfVUFFyuzbX65XZ6vcT5VHk6sRgs0yStzq+H4LDXnsklCISQrdMWuWN22WmNkJpEvMB5/G
 L76ZMIQAkpNz7M5Gs3eOXPk+Mo6fWzw4RnG6J8ngOq+grxHRIECx3xgW2rlw19/9G9QquzW
 0rQeyYIerOXqj9rSU6/SbpRU0ZdqySYFrHSeKsnjKXYMqMhiMzy1+ulqb+e6RXFZ7ThS10G
 +Z0Typq6F1bKssTB3L2pDqafF9zSqdLV+48f7UbwU1E3MZn0K0/ZoUJsPq+wG4vS+IhX4cu
 InGCAQH95MN4x5de1TkOhW5ukAuA3GZHT8plUEzCA4eFZEk9mUYpmG9zAifoNb9mK6dyau1
 HtXfZ8n4YTJPIR+VPqxUIpiBE72x0CNAHo7Iqqdac6ORi451OPpGkeaUO+diuSzqxVcncr6
 XRG3R6BDJw4uPWtQ2lzabP/4aZ/KMKZnoVSQEUZbEjDJ2dE6y0Y3+dz+MP6UWX7yX5FBq4K
 cdUDs2LT74gsd7dfAiuB+c=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
 drivers/net/txgbe/base/txgbe_hw.c    | 17 ++++++++
 drivers/net/txgbe/base/txgbe_hw.h    |  1 +
 drivers/net/txgbe/base/txgbe_regs.h  | 31 ++++++++++++++
 drivers/net/txgbe/txgbe_ethdev.c     | 12 ++++--
 drivers/net/txgbe/txgbe_rxtx.c       | 64 +++++++++++++++-------------
 8 files changed, 94 insertions(+), 35 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml.c b/drivers/net/txgbe/base/txgbe_aml.c
index bf63975a15..3283d3f56c 100644
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
index 597b42951e..c7d64cade6 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -112,7 +112,6 @@ s32 txgbe_setup_mac_link_aml40(struct txgbe_hw *hw,
 	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
 	bool link_up = false;
 	u32 link_capabilities = TXGBE_LINK_SPEED_UNKNOWN;
-	u32 value = 0;
 
 	if (hw->phy.sfp_type == txgbe_sfp_type_not_present) {
 		DEBUGOUT("SFP not detected, skip setup mac link");
diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index ef1c3c06ea..be8409c28e 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -20,6 +20,7 @@
 #define TXGBE_RAPTOR_MC_TBL_SIZE   128
 #define TXGBE_RAPTOR_VFT_TBL_SIZE  128
 #define TXGBE_RAPTOR_RX_PB_SIZE	  512 /*KB*/
+#define TXGBE_AML_RX_PB_SIZE	  768
 
 static s32 txgbe_setup_copper_link_raptor(struct txgbe_hw *hw,
 					 u32 speed,
@@ -2505,6 +2506,19 @@ bool txgbe_is_pf(struct txgbe_hw *hw)
 {
 	switch (hw->mac.type) {
 	case txgbe_mac_sp:
+	case txgbe_mac_aml:
+	case txgbe_mac_aml40:
+		return true;
+	default:
+		return false;
+	}
+}
+
+bool txgbe_is_vf(struct txgbe_hw *hw)
+{
+	switch (hw->mac.type) {
+	case txgbe_mac_sp_vf:
+	case txgbe_mac_aml_vf:
 		return true;
 	default:
 		return false;
@@ -2920,6 +2934,9 @@ s32 txgbe_init_ops_generic(struct txgbe_hw *hw)
 	mac->max_rx_queues	= TXGBE_RAPTOR_MAX_RX_QUEUES;
 	mac->max_tx_queues	= TXGBE_RAPTOR_MAX_TX_QUEUES;
 
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40)
+		mac->rx_pb_size = TXGBE_AML_RX_PB_SIZE;
+
 	return 0;
 }
 
diff --git a/drivers/net/txgbe/base/txgbe_hw.h b/drivers/net/txgbe/base/txgbe_hw.h
index 7afc800f8d..ab33d01966 100644
--- a/drivers/net/txgbe/base/txgbe_hw.h
+++ b/drivers/net/txgbe/base/txgbe_hw.h
@@ -86,6 +86,7 @@ s32 txgbe_negotiate_fc(struct txgbe_hw *hw, u32 adv_reg, u32 lp_reg,
 			u32 adv_sym, u32 adv_asm, u32 lp_sym, u32 lp_asm);
 s32 txgbe_init_shared_code(struct txgbe_hw *hw);
 bool txgbe_is_pf(struct txgbe_hw *hw);
+bool txgbe_is_vf(struct txgbe_hw *hw);
 s32 txgbe_set_mac_type(struct txgbe_hw *hw);
 s32 txgbe_init_ops_generic(struct txgbe_hw *hw);
 void txgbe_init_ops_sp(struct txgbe_hw *hw);
diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 5709245068..93cc222339 100644
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
+#define TXGBE_AML_LINK_STATUS_OVRD_EN   MS(5, 0x1)
+#define TXGBE_AML_LINK_STATUS_OVRD_VAL  MS(4, 0x1)
+
 /**
  * GPIO Control
  * P0: link speed change
@@ -1393,7 +1399,9 @@ enum txgbe_5tuple_protocol {
 #define   TXGBE_TXCFG_HTHRESH_MASK      MS(8, 0xF)
 #define   TXGBE_TXCFG_HTHRESH(v)        LS(v, 8, 0xF)
 #define   TXGBE_TXCFG_WTHRESH_MASK      MS(16, 0x7F)
+#define   TXGBE_TXCFG_WTHRESH_MASK_AML  MS(16, 0x1FF)
 #define   TXGBE_TXCFG_WTHRESH(v)        LS(v, 16, 0x7F)
+#define   TXGBE_TXCFG_WTHRESH_AML(v)    LS(v, 16, 0x1FF)
 #define   TXGBE_TXCFG_FLUSH             MS(26, 0x1)
 
 #define TXGBE_TDM_DESC_CHK(i)		(0x0180B0 + (i) * 4) /*0-3*/
@@ -1638,6 +1646,16 @@ enum txgbe_5tuple_protocol {
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
@@ -1712,6 +1730,19 @@ enum txgbe_5tuple_protocol {
 #define   TXGBE_MACTXCFG_SPEED_10G      LS(0, 29, 0x3)
 #define   TXGBE_MACTXCFG_SPEED_1G       LS(3, 29, 0x3)
 
+#define TXGBE_MAC_TX_CFG_AML_SPEED_MASK     MS(28, 0x7)
+#define TXGBE_MAC_TX_CFG_AML_SPEED_50G      LS(2, 28, 0x7)
+#define TXGBE_MAC_TX_CFG_AML_SPEED_40G      LS(0, 28, 0x7)
+#define TXGBE_MAC_TX_CFG_AML_SPEED_25G      LS(1, 28, 0x7)
+#define TXGBE_MAC_TX_CFG_AML_SPEED_10G      LS(4, 28, 0x7)
+#define TXGBE_MAC_TX_CFG_AML_SPEED_1G       LS(7, 28, 0x7)
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
index 0e2f25ad76..30c11b8743 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -385,7 +385,7 @@ txgbe_dev_queue_stats_mapping_set(struct rte_eth_dev *eth_dev,
 	uint32_t q_map;
 	uint8_t n, offset;
 
-	if (hw->mac.type != txgbe_mac_sp)
+	if (!txgbe_is_pf(hw))
 		return -ENOSYS;
 
 	if (stat_idx & ~QMAP_FIELD_RESERVED_BITS_MASK)
@@ -1806,7 +1806,7 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 	}
 
 	/* Skip link setup if loopback mode is enabled. */
-	if (hw->mac.type == txgbe_mac_sp &&
+	if (txgbe_is_pf(hw) &&
 	    dev->data->dev_conf.lpbk_mode)
 		goto skip_link_setup;
 
@@ -2817,6 +2817,7 @@ txgbe_dev_sfp_event(struct rte_eth_dev *dev)
 
 	wr32(hw, TXGBE_GPIOINTMASK, 0xFF);
 	reg = rd32(hw, TXGBE_GPIORAWINTSTAT);
+
 	if (reg & TXGBE_GPIOBIT_0)
 		wr32(hw, TXGBE_GPIOEOI, TXGBE_GPIOBIT_0);
 	if (reg & TXGBE_GPIOBIT_2) {
@@ -3079,8 +3080,13 @@ txgbe_dev_link_update_share(struct rte_eth_dev *dev,
 		break;
 	}
 
+	/* enable mac receiver */
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
+		wr32m(hw, TXGBE_MACRXCFG, TXGBE_MACRXCFG_ENA, TXGBE_MACRXCFG_ENA);
+	}
+
 	/* Re configure MAC RX */
-	if (hw->mac.type == txgbe_mac_sp) {
+	if (txgbe_is_pf(hw)) {
 		reg = rd32(hw, TXGBE_MACRXCFG);
 		wr32(hw, TXGBE_MACRXCFG, reg);
 		wr32m(hw, TXGBE_MACRXFLT, TXGBE_MACRXFLT_PROMISC,
diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index 5c05dfd90a..3f157527c6 100644
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
-	case txgbe_mac_sp_vf:
-		return 1;
-	default:
-		return 0;
-	}
-}
-
 /*********************************************************************
  *
  *  TX functions
@@ -2112,7 +2099,7 @@ txgbe_get_rx_port_offloads(struct rte_eth_dev *dev)
 		   RTE_ETH_RX_OFFLOAD_RSS_HASH |
 		   RTE_ETH_RX_OFFLOAD_SCATTER;
 
-	if (!txgbe_is_vf(dev))
+	if (!txgbe_is_vf(hw))
 		offloads |= (RTE_ETH_RX_OFFLOAD_VLAN_FILTER |
 			     RTE_ETH_RX_OFFLOAD_QINQ_STRIP |
 			     RTE_ETH_RX_OFFLOAD_VLAN_EXTEND);
@@ -2121,10 +2108,10 @@ txgbe_get_rx_port_offloads(struct rte_eth_dev *dev)
 	 * RSC is only supported by PF devices in a non-SR-IOV
 	 * mode.
 	 */
-	if (hw->mac.type == txgbe_mac_sp && !sriov->active)
+	if (txgbe_is_pf(hw) && !sriov->active)
 		offloads |= RTE_ETH_RX_OFFLOAD_TCP_LRO;
 
-	if (hw->mac.type == txgbe_mac_sp)
+	if (txgbe_is_pf(hw))
 		offloads |= RTE_ETH_RX_OFFLOAD_MACSEC_STRIP;
 
 	offloads |= RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM;
@@ -2363,6 +2350,7 @@ uint64_t
 txgbe_get_tx_port_offloads(struct rte_eth_dev *dev)
 {
 	uint64_t tx_offload_capa;
+	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 
 	tx_offload_capa =
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |
@@ -2380,7 +2368,7 @@ txgbe_get_tx_port_offloads(struct rte_eth_dev *dev)
 		RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO	|
 		RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
-	if (!txgbe_is_vf(dev))
+	if (!txgbe_is_vf(hw))
 		tx_offload_capa |= RTE_ETH_TX_OFFLOAD_QINQ_INSERT;
 
 	tx_offload_capa |= RTE_ETH_TX_OFFLOAD_MACSEC_INSERT;
@@ -2498,7 +2486,7 @@ txgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	/* Modification to set tail pointer for virtual function
 	 * if vf is detected.
 	 */
-	if (hw->mac.type == txgbe_mac_sp_vf) {
+	if (txgbe_is_vf(hw)) {
 		txq->tdt_reg_addr = TXGBE_REG_ADDR(hw, TXGBE_TXWP(queue_idx));
 		txq->tdc_reg_addr = TXGBE_REG_ADDR(hw, TXGBE_TXCFG(queue_idx));
 	} else {
@@ -2791,7 +2779,7 @@ txgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	/*
 	 * Modified to setup VFRDT for Virtual Function
 	 */
-	if (hw->mac.type == txgbe_mac_sp_vf) {
+	if (txgbe_is_vf(hw)) {
 		rxq->rdt_reg_addr =
 			TXGBE_REG_ADDR(hw, TXGBE_RXWP(queue_idx));
 		rxq->rdh_reg_addr =
@@ -3037,7 +3025,7 @@ txgbe_rss_disable(struct rte_eth_dev *dev)
 	struct txgbe_hw *hw;
 
 	hw = TXGBE_DEV_HW(dev);
-	if (hw->mac.type == txgbe_mac_sp_vf)
+	if (txgbe_is_vf(hw))
 		wr32m(hw, TXGBE_VFPLCFG, TXGBE_VFPLCFG_RSSENA, 0);
 	else
 		wr32m(hw, TXGBE_RACTL, TXGBE_RACTL_RSSENA, 0);
@@ -3074,7 +3062,7 @@ txgbe_dev_rss_hash_update(struct rte_eth_dev *dev,
 
 	/* Set configured hashing protocols */
 	rss_hf = rss_conf->rss_hf & TXGBE_RSS_OFFLOAD_ALL;
-	if (hw->mac.type == txgbe_mac_sp_vf) {
+	if (txgbe_is_vf(hw)) {
 		mrqc = rd32(hw, TXGBE_VFPLCFG);
 		mrqc &= ~TXGBE_VFPLCFG_RSSMASK;
 		if (rss_hf & RTE_ETH_RSS_IPV4)
@@ -3166,7 +3154,7 @@ txgbe_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
 	}
 
 	rss_hf = 0;
-	if (hw->mac.type == txgbe_mac_sp_vf) {
+	if (txgbe_is_vf(hw)) {
 		mrqc = rd32(hw, TXGBE_VFPLCFG);
 		if (mrqc & TXGBE_VFPLCFG_RSSIPV4)
 			rss_hf |= RTE_ETH_RSS_IPV4;
@@ -3628,6 +3616,8 @@ txgbe_dcb_hw_arbite_tx_config(struct txgbe_hw *hw, uint16_t *refill,
 {
 	switch (hw->mac.type) {
 	case txgbe_mac_sp:
+	case txgbe_mac_aml:
+	case txgbe_mac_aml40:
 		txgbe_dcb_config_tx_desc_arbiter_raptor(hw, refill,
 							max, bwg_id, tsa);
 		txgbe_dcb_config_tx_data_arbiter_raptor(hw, refill,
@@ -4555,7 +4545,7 @@ txgbe_dev_rx_init(struct rte_eth_dev *dev)
 	 * If loopback mode is configured, set LPBK bit.
 	 */
 	hlreg0 = rd32(hw, TXGBE_PSRCTL);
-	if (hw->mac.type == txgbe_mac_sp &&
+	if (txgbe_is_pf(hw) &&
 	    dev->data->dev_conf.lpbk_mode)
 		hlreg0 |= TXGBE_PSRCTL_LBENA;
 	else
@@ -4640,7 +4630,7 @@ txgbe_dev_rx_init(struct rte_eth_dev *dev)
 
 	wr32(hw, TXGBE_PSRCTL, rxcsum);
 
-	if (hw->mac.type == txgbe_mac_sp) {
+	if (txgbe_is_pf(hw)) {
 		rdrxctl = rd32(hw, TXGBE_SECRXCTL);
 		if (rx_conf->offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC)
 			rdrxctl &= ~TXGBE_SECRXCTL_CRCSTRIP;
@@ -4730,11 +4720,18 @@ txgbe_dev_rxtx_start(struct rte_eth_dev *dev)
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
+			      TXGBE_TXCFG_WTHRESH_AML(txq->wthresh));
+		else
+			wr32m(hw, TXGBE_TXCFG(txq->reg_idx),
+			      TXGBE_TXCFG_HTHRESH_MASK |
+			      TXGBE_TXCFG_WTHRESH_MASK,
+			      TXGBE_TXCFG_HTHRESH(txq->hthresh) |
+			      TXGBE_TXCFG_WTHRESH(txq->wthresh));
 	}
 
 	dmatxctl = rd32(hw, TXGBE_DMATXCTRL);
@@ -4759,13 +4756,20 @@ txgbe_dev_rxtx_start(struct rte_eth_dev *dev)
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
-	if (hw->mac.type == txgbe_mac_sp &&
+	if (txgbe_is_pf(hw) &&
 	    dev->data->dev_conf.lpbk_mode)
 		txgbe_setup_loopback_link_raptor(hw);
 
-- 
2.21.0.windows.1

