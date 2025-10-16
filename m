Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BDACCD194
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 11:20:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D9E2427CB;
	Thu, 16 Oct 2025 13:19:53 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id B7F7C41153
 for <dev@dpdk.org>; Thu, 16 Oct 2025 13:19:51 +0200 (CEST)
X-QQ-mid: esmtpsz17t1760613587taafa73a1
X-QQ-Originating-IP: w8fUznaB40GXHZK34rcayuzLhn4gRkc6bFlE28+oQiA=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.206.160.146])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 16 Oct 2025 19:19:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3112923781158726510
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v5 12/21] net/txgbe: add FEC support for Amber-Lite 25G NICs
Date: Thu, 16 Oct 2025 19:17:26 +0800
Message-Id: <20251016111736.25372-13-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251016111736.25372-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20251016111736.25372-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NvH2zBBgt3uTJNfPZVi2BGWeGuyng6UHi+RME82hd1sCeQgSu3PCfsqF
 JpZoyRzNUwNF5NuBIaVipB3+/WYZrkZ3nRlpSH9ZRJiYX+QhRdDFe95lSk+AvHg0+hUxfoV
 IxGSW0rG2ZrHLAQrUxOEJrGTowwRN7dUi47is8zrM3w9BBEfq3ZX6kbA7lX9p5TWDKRrdas
 L9VTewTXuHGE2B4jhIvei8tuXWBtRVCfzUBtFD8v4wbWL1FcFYCgNHV94Q3KqYTmEJnxmsn
 AXFVh+g2fpY2T9xGnxl6jHiFVe+Vj3iP0enxEAm3rBu4l67bimz5Ei7JpQcLoBL9cZhRHUt
 B4XlKw3tyNpwJ7JVyvrSQZ1ZDYfj/w/IC4Oyol/VrRkC9F4BGSuF4rkGBKKKBIbrHcSNB7a
 VW2lc3R3smn+ympNsqV1dgFzSwyQ65JTHA6TC/7Sm7w5n1TkyFRu/SjjVXPqPxTNXq87tKo
 LdV2nNM5lIoZXbeqHZ+34Y4DTM5vdmEsHMnU506EEGqn/Z/cjG16aZ0NoYfqXcpudX9LCak
 0vL8SVuPaQbWJPnwOgyC2t33h1X8wZNXP9YRMXH+1Ar1Y0InEd69te2BbS5oyJUyOITKdHY
 QZtxFzVglftjnLdXFvul5Qrt4lMz114lUJ2PuSLW6lp4BAZoSi2sLGUHd+Aelh/NhWDyOmx
 wCVggniv0HWK6LBvI6CO3tI/9osl/PusJBPmS9Z/huxG4cfeqg4BIEYwFv0L+TuXDtddY7d
 MLbJX0n17+yaYVD0arlw45o8Kek7keuz/PwbxtQd2OpE/gp+2NupEhng6HbKdKCHdv/B23U
 4nBqd8wCnKyKK/UrKVRzi4XKzVVy+AOtmZfGC1h3hUnlOh0+ExnpGwRvYcmM7WavwpeLFX1
 yI5aPBphMD3mfprgObx04Ol4Caz78gQMs0E1bcphP4DhoMpKqdX2VXWj+m62YqsX0ffBrfg
 TuRMWBYApztQ/VRM7vubQ+eYLV+tVY1sEfYKYYprfV7KTJqqtR9Jlq1aoliAQgF/B93w1AU
 RE8gIfwzRsq4EViOyX/HqIkTL8tAbS9o9rsbvrzE+4ZoYaj7NZN6kbN5gkxCmRh1yM42evL
 VZ6E93chVr4
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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

Amber-Lite 25G NICs support four FEC modes (off, baser, rs, auto).
The driver implements standard interfaces (fec_get_capability,
fec_get, fec_set) to allow manual configuration. The default FEC
mode is set to 'auto'.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml.c  |  27 ++++++-
 drivers/net/txgbe/base/txgbe_hw.c   |   3 +
 drivers/net/txgbe/base/txgbe_mng.c  |   2 +-
 drivers/net/txgbe/base/txgbe_phy.h  |   1 +
 drivers/net/txgbe/base/txgbe_type.h |   2 +
 drivers/net/txgbe/txgbe_ethdev.c    | 121 ++++++++++++++++++++++++++++
 6 files changed, 154 insertions(+), 2 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml.c b/drivers/net/txgbe/base/txgbe_aml.c
index 3283d3f56c..867cf4c2d3 100644
--- a/drivers/net/txgbe/base/txgbe_aml.c
+++ b/drivers/net/txgbe/base/txgbe_aml.c
@@ -131,6 +131,26 @@ u32 txgbe_get_media_type_aml(struct txgbe_hw *hw)
 	return media_type;
 }
 
+static int
+txgbe_phy_fec_get(struct txgbe_hw *hw)
+{
+	int value = 0;
+
+	rte_spinlock_lock(&hw->phy_lock);
+	value = rd32_epcs(hw, SR_PMA_RS_FEC_CTRL);
+	rte_spinlock_unlock(&hw->phy_lock);
+	if (value & 0x4)
+		return TXGBE_PHY_FEC_RS;
+
+	rte_spinlock_lock(&hw->phy_lock);
+	value = rd32_epcs(hw, SR_PMA_KR_FEC_CTRL);
+	rte_spinlock_unlock(&hw->phy_lock);
+	if (value & 0x1)
+		return TXGBE_PHY_FEC_BASER;
+
+	return TXGBE_PHY_FEC_OFF;
+}
+
 void txgbe_wait_for_link_up_aml(struct txgbe_hw *hw, u32 speed)
 {
 	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
@@ -184,7 +204,12 @@ s32 txgbe_setup_mac_link_aml(struct txgbe_hw *hw,
 	status = hw->mac.check_link(hw, &link_speed, &link_up,
 				    autoneg_wait_to_complete);
 
-	if (link_speed == speed && link_up)
+	if (link_up && speed == TXGBE_LINK_SPEED_25GB_FULL)
+		hw->cur_fec_link = txgbe_phy_fec_get(hw);
+
+	if (link_speed == speed && link_up &&
+	   !(speed == TXGBE_LINK_SPEED_25GB_FULL &&
+	   !(hw->fec_mode & hw->cur_fec_link)))
 		return status;
 
 	if (speed & TXGBE_LINK_SPEED_25GB_FULL)
diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 6d3b917bbf..cbf7aafe7f 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -338,6 +338,9 @@ s32 txgbe_init_hw(struct txgbe_hw *hw)
 
 	txgbe_disable_lldp(hw);
 
+	/* Init fec mode to 'AUTO' */
+	hw->fec_mode = TXGBE_PHY_FEC_AUTO;
+
 	/* Reset the hardware */
 	status = hw->mac.reset_hw(hw);
 	if (status == 0 || status == TXGBE_ERR_SFP_NOT_PRESENT) {
diff --git a/drivers/net/txgbe/base/txgbe_mng.c b/drivers/net/txgbe/base/txgbe_mng.c
index 782e86e1fa..05eb07c0e2 100644
--- a/drivers/net/txgbe/base/txgbe_mng.c
+++ b/drivers/net/txgbe/base/txgbe_mng.c
@@ -613,7 +613,7 @@ s32 txgbe_hic_ephy_set_link(struct txgbe_hw *hw, u8 speed, u8 autoneg, u8 duplex
 	buffer.hdr.buf_len = sizeof(struct txgbe_hic_ephy_setlink) - sizeof(struct txgbe_hic_hdr);
 	buffer.hdr.cmd_or_resp.cmd_resv = FW_CEM_CMD_RESERVED;
 
-	buffer.fec_mode = TXGBE_PHY_FEC_AUTO;
+	buffer.fec_mode = hw->fec_mode;
 	buffer.speed = speed;
 	buffer.autoneg = autoneg;
 	buffer.duplex = duplex;
diff --git a/drivers/net/txgbe/base/txgbe_phy.h b/drivers/net/txgbe/base/txgbe_phy.h
index c02be3cc34..f1849c8400 100644
--- a/drivers/net/txgbe/base/txgbe_phy.h
+++ b/drivers/net/txgbe/base/txgbe_phy.h
@@ -40,6 +40,7 @@
 #define   SR_PMA_KR_LD_CESTS_RR		MS16(15, 0x1)
 #define SR_PMA_KR_FEC_CTRL              0x0100AB
 #define   SR_PMA_KR_FEC_CTRL_EN		MS16(0, 0x1)
+#define SR_PMA_RS_FEC_CTRL              0x0100C8
 #define SR_MII_MMD_CTL                  0x1F0000
 #define   SR_MII_MMD_CTL_AN_EN              0x1000
 #define   SR_MII_MMD_CTL_RESTART_AN         0x0200
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index 03e5bd489d..c5f51b3ade 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -848,6 +848,8 @@ struct txgbe_hw {
 	/*amlite: new SW-FW mbox */
 	u8 swfw_index;
 	rte_atomic32_t swfw_busy;
+	u32 fec_mode;
+	u32 cur_fec_link;
 };
 
 struct txgbe_backplane_ability {
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 13d1d6924d..dc190fbc1a 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -2806,9 +2806,31 @@ txgbe_dev_detect_sfp(void *param)
 {
 	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
+	u32 value = 0;
 	s32 err;
 
+	if (hw->mac.type == txgbe_mac_aml40) {
+		value = rd32(hw, TXGBE_GPIOEXT);
+		if (value & TXGBE_SFP1_MOD_PRST_LS) {
+			err = TXGBE_ERR_SFP_NOT_PRESENT;
+			goto out;
+		}
+	}
+
+	if (hw->mac.type == txgbe_mac_aml) {
+		value = rd32(hw, TXGBE_GPIOEXT);
+		if (value & TXGBE_SFP1_MOD_ABS_LS) {
+			err = TXGBE_ERR_SFP_NOT_PRESENT;
+			goto out;
+		}
+	}
+
+	/* wait for sfp module ready*/
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40)
+		msec_delay(200);
+
 	err = hw->phy.identify_sfp(hw);
+out:
 	if (err == TXGBE_ERR_SFP_NOT_SUPPORTED) {
 		PMD_DRV_LOG(ERR, "Unsupported SFP+ module type was detected.");
 	} else if (err == TXGBE_ERR_SFP_NOT_PRESENT) {
@@ -5642,6 +5664,102 @@ txgbe_clear_all_l2_tn_filter(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static int txgbe_fec_get_capa_speed_to_fec(struct rte_eth_fec_capa *speed_fec_capa)
+{
+	int num = 2;
+
+	if (speed_fec_capa) {
+		speed_fec_capa[0].speed = RTE_ETH_SPEED_NUM_10G;
+		speed_fec_capa[0].capa = RTE_ETH_FEC_MODE_CAPA_MASK(NOFEC);
+		speed_fec_capa[1].speed = RTE_ETH_SPEED_NUM_25G;
+		speed_fec_capa[1].capa = RTE_ETH_FEC_MODE_CAPA_MASK(NOFEC) |
+					 RTE_ETH_FEC_MODE_CAPA_MASK(AUTO) |
+					 RTE_ETH_FEC_MODE_CAPA_MASK(BASER) |
+					 RTE_ETH_FEC_MODE_CAPA_MASK(RS);
+	}
+
+	return num;
+}
+
+static int txgbe_fec_get_capability(struct rte_eth_dev *dev,
+				    struct rte_eth_fec_capa *speed_fec_capa,
+				    unsigned int num)
+{
+	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
+	u8 num_entries;
+
+	if (hw->mac.type != txgbe_mac_aml)
+		return -EOPNOTSUPP;
+
+	num_entries = txgbe_fec_get_capa_speed_to_fec(NULL);
+	if (!speed_fec_capa || num < num_entries)
+		return num_entries;
+
+	return txgbe_fec_get_capa_speed_to_fec(speed_fec_capa);
+}
+
+static int txgbe_fec_get(struct rte_eth_dev *dev, uint32_t *fec_capa)
+{
+	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
+	u32 speed = 0;
+	bool negotiate = false;
+	u32 curr_fec_mode;
+
+	hw->mac.get_link_capabilities(hw, &speed, &negotiate);
+
+	if (hw->mac.type != txgbe_mac_aml ||
+	  !(speed & TXGBE_LINK_SPEED_25GB_FULL))
+		return -EOPNOTSUPP;
+
+	if (hw->fec_mode == TXGBE_PHY_FEC_AUTO)
+		curr_fec_mode = RTE_ETH_FEC_MODE_CAPA_MASK(AUTO);
+	else if (hw->fec_mode == TXGBE_PHY_FEC_RS)
+		curr_fec_mode = RTE_ETH_FEC_MODE_CAPA_MASK(RS);
+	else if (hw->fec_mode == TXGBE_PHY_FEC_BASER)
+		curr_fec_mode = RTE_ETH_FEC_MODE_CAPA_MASK(BASER);
+	else
+		curr_fec_mode = RTE_ETH_FEC_MODE_CAPA_MASK(NOFEC);
+
+	*fec_capa = curr_fec_mode;
+	return 0;
+}
+
+static int txgbe_fec_set(struct rte_eth_dev *dev, u32 fec_capa)
+{
+	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
+	u32 orig_fec_mode = hw->fec_mode;
+	bool negotiate = false;
+	u32 speed = 0;
+
+	hw->mac.get_link_capabilities(hw, &speed, &negotiate);
+
+	if (hw->mac.type != txgbe_mac_aml ||
+	  !(speed & TXGBE_LINK_SPEED_25GB_FULL))
+		return -EOPNOTSUPP;
+
+	if (!fec_capa)
+		return -EINVAL;
+
+	if (fec_capa & RTE_ETH_FEC_MODE_CAPA_MASK(AUTO))
+		hw->fec_mode = TXGBE_PHY_FEC_AUTO;
+
+	if (fec_capa & RTE_ETH_FEC_MODE_CAPA_MASK(NOFEC))
+		hw->fec_mode = TXGBE_PHY_FEC_OFF;
+
+	if (fec_capa & RTE_ETH_FEC_MODE_CAPA_MASK(BASER))
+		hw->fec_mode = TXGBE_PHY_FEC_BASER;
+
+	if (fec_capa & RTE_ETH_FEC_MODE_CAPA_MASK(RS))
+		hw->fec_mode = TXGBE_PHY_FEC_RS;
+
+	if (hw->fec_mode != orig_fec_mode) {
+		txgbe_dev_setup_link_alarm_handler(dev);
+		txgbe_dev_link_update(dev, 0);
+	}
+
+	return 0;
+}
+
 static const struct eth_dev_ops txgbe_eth_dev_ops = {
 	.dev_configure              = txgbe_dev_configure,
 	.dev_infos_get              = txgbe_dev_info_get,
@@ -5718,6 +5836,9 @@ static const struct eth_dev_ops txgbe_eth_dev_ops = {
 	.udp_tunnel_port_del        = txgbe_dev_udp_tunnel_port_del,
 	.tm_ops_get                 = txgbe_tm_ops_get,
 	.tx_done_cleanup            = txgbe_dev_tx_done_cleanup,
+	.fec_get_capability         = txgbe_fec_get_capability,
+	.fec_get                    = txgbe_fec_get,
+	.fec_set                    = txgbe_fec_set,
 };
 
 RTE_PMD_REGISTER_PCI(net_txgbe, rte_txgbe_pmd);
-- 
2.21.0.windows.1

