Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E525C7EE30
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 12:52:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E67C40E8A;
	Wed, 25 Jun 2025 14:52:22 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id C3C6140E22
 for <dev@dpdk.org>; Wed, 25 Jun 2025 14:52:19 +0200 (CEST)
X-QQ-mid: esmtpsz21t1750855936t06bc0ea3
X-QQ-Originating-IP: t2uLS8yK27xgZKAp7akkkn1Jai1Txx6Ngbq0rW6vfV0=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.80.242])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 25 Jun 2025 20:52:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3774111095799622930
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v2 11/15] net/txgbe: add FEC support for Amber-Lite 25G NICs
Date: Wed, 25 Jun 2025 20:50:43 +0800
Message-Id: <20250625125047.18072-12-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250625125047.18072-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250625125047.18072-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: OSjQccS6YHkHT+hJEjYzLFHTMa7Zb3HDx6y/LUD+BaK6W63ai5CfvYiH
 ZXm1WY73ppLRxFhe9Xk8BTOU+D8DH9MkmnpCIQ0jeEjmqGIq2sQVqmHk5jFPXLEfwHotQ2K
 72BM934jf4VQ0IRxGADAGJfQ+ickVY9wAIv0JXjyJ/7jGSp2ra2RQUpYHwi9FYDvH9wBCE1
 hwh3BheecapKTRqFyZrnHFcPsOXfyQm8xoMPvbh8v+eztJnY2/vdExCYmAEP8wQGiMaZ4yQ
 iuOP5+9R32T95tMtRxGGxFj20AUn/THlbu/F4rXopNIuGzgD0nocqCCdx3X0zNXl/zcQT+E
 JNLmi5xAl03QBwKo2Nm1bqKO/owEdy8glfRn+1El/fxHuqPqAPfI9yHfBgU3gGh+79YqRfg
 CsJH0VgXJGfZwDDpsZnPqCewlcxKdMfQ9/2Zh3I+NdSNl/pPNLdwRmPZ87JkYb3YRo+SQqI
 DGXasoltPTfutNsg1feHn4EbKddOPd2jKU/LIIHCZF29n8nkCBO3Um2fXRobSGskDw98T2s
 IjDScWV4hmmZGTB5tlfM6eLpVbwq67HwgdqCy1/Kyeb0QMKhRVsnifJjhufp9ZbP9gBNZCf
 hGa2Npu8UH6JVDGM4uaedD23mYJrXpVVveZ5zUgBfO/TIgU8QNGu3eh0iV6UA22b2j3+Svc
 ubvJ+sGMkjJtYcZGOpvW8r+kLxssjamarFGgXGbzC2gvOYLjyEmi7V9pD/zOn03p9EqvIm8
 DuYbhZPqDYMxOmWQZRQZ/VtKWPpQKkon6GFriAMe7sC66YavWsqU0K2/umJXmCFbbKwXlGu
 ijjqC1HrvvmQsCHkcQLcNvXCaZ1VFRMrRMuu5QgPGGFuASiJh1ydaDYkZ1u76CuT+f3dl/D
 J/A9s3KkMya1v/OPKCHzIXA/SZio2p6LTQiF9nVzZZGudugKqkwSz8SFPhg0QuMb68vPyyR
 3rqAWgIms8959tjl6duwafQjVIGdeW7iW+CJqPDfmSNH3oYwbzJHDqhJZ+sjgyMV88HTx1Q
 g+xQiSnC6h/65DIbi0OmWsPskFOcGUDHZFU+E+8WHzdqGOBK29z3Gns4i5ulPlc3lUbPxdg
 Q==
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
index 368b002c88..4cafdeca5c 100644
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
index 4f93c28280..fd6594e831 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -329,6 +329,9 @@ s32 txgbe_init_hw(struct txgbe_hw *hw)
 
 	txgbe_disable_lldp(hw);
 
+	/* Init fec mode to 'AUTO' */
+	hw->fec_mode = TXGBE_PHY_FEC_AUTO;
+
 	/* Reset the hardware */
 	status = hw->mac.reset_hw(hw);
 	if (status == 0 || status == TXGBE_ERR_SFP_NOT_PRESENT) {
diff --git a/drivers/net/txgbe/base/txgbe_mng.c b/drivers/net/txgbe/base/txgbe_mng.c
index 7af43c7b44..28b5ed3542 100644
--- a/drivers/net/txgbe/base/txgbe_mng.c
+++ b/drivers/net/txgbe/base/txgbe_mng.c
@@ -601,7 +601,7 @@ s32 txgbe_hic_ephy_set_link(struct txgbe_hw *hw, u8 speed, u8 autoneg, u8 duplex
 	buffer.hdr.buf_len = sizeof(struct txgbe_hic_ephy_setlink) - sizeof(struct txgbe_hic_hdr);
 	buffer.hdr.cmd_or_resp.cmd_resv = FW_CEM_CMD_RESERVED;
 
-	buffer.fec_mode = TXGBE_PHY_FEC_AUTO;
+	buffer.fec_mode = hw->fec_mode;
 	buffer.speed = speed;
 	buffer.autoneg = autoneg;
 	buffer.duplex = duplex;
diff --git a/drivers/net/txgbe/base/txgbe_phy.h b/drivers/net/txgbe/base/txgbe_phy.h
index 79b866ea57..94788464c2 100644
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
index ba961b4b1e..3833f1420a 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -855,6 +855,8 @@ struct txgbe_hw {
 	/*amlite: new SW-FW mbox */
 	u8 swfw_index;
 	rte_atomic32_t swfw_busy;
+	u32 fec_mode;
+	u32 cur_fec_link;
 };
 
 struct txgbe_backplane_ability {
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index fffb8fb01d..374d6452f4 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -2805,9 +2805,31 @@ txgbe_dev_detect_sfp(void *param)
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
@@ -5632,6 +5654,102 @@ txgbe_clear_all_l2_tn_filter(struct rte_eth_dev *dev)
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
@@ -5708,6 +5826,9 @@ static const struct eth_dev_ops txgbe_eth_dev_ops = {
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

