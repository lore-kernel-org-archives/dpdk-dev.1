Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E475FC61DC6
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 11:44:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E533406B7;
	Thu, 27 Aug 2026 13:44:28 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 56AF7406B6;
 Thu, 27 Aug 2026 13:44:25 +0200 (CEST)
X-QQ-mid: esmtpgz13t1787831061teaf2960d
X-QQ-Originating-IP: BNNmtRjbl3OqnhJvqgP03EPucznH1v1eemzxzacESKY=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.233.170.62])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 27 Aug 2026 19:44:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9695590659235207170
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 12/13] net/txgbe: fix CR/KR link training and recovery
Date: Thu, 27 Aug 2026 19:42:04 +0800
Message-ID: <9069D5F761AECCE1+20260827114309.10530-13-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OJEI2kuYK58q4wPbnXgK2i5LIxfzl8WQGnzlzMwHnVn6dGPze5Gu+cuv
 5UTKSX/4hrnn+SD74vcSB9FxTfAz482tDr31+yOt0odbtPNXd2hjs7ALVN5AuPBeIB3AH8S
 dyDnhEhpxG8rnQL9H26fLPHadxsLmJjWMLUgg+0beauYsTjpW0xgpm7xon0uQb2OPkK/AFV
 sj1NMLIJyyvkYtR7Vajdi/rYtfSGe17mCa/N5qVov3rFvV8j5oKCBm4IkA8ekjeV3oDYNho
 OCAJ9oG0mYyeI2AUNvsguAMKsQbR/9j3SnUl1CYG+mfLnxR4khwttmH4KluLdysq2vBhdg0
 sxF+IZ1E3KWEExasCfEcVHh/ib8HEfEfYgQS9rWgQpskHJJ3oYDHu7F/K5wy9MUaNwQGLnV
 6eE0aufIQhvXdyxI6EkhjC02wAutaTl9lMnh5yRd9GEwFzuSGcVvvaVa+lWOcRcnezjEZhG
 UlMtvENAK2o8ldHYtnm9Pdh6FyCD/SH6KMBnS3G/+rEfgVicSHRzXA+sUd/mBc7iZ7boFic
 sEhiibj3+zdihXz86vqwo3dwcqlC6043iJEPPSNUVBNgPPN46W44Lc7i7VMYl3jm+GoOv8c
 8NGCeH+h9uwEdfVH549q4e/sgp2ahGM4ITfH4i9hW1nUFMQ0J5fsOWRJewZKldsujTNCqwj
 Fea+GH6RYmzyKkcy0QHGHShKDTvbR2OTJQ5bSWk561wV0ZuknJEwLe5niB27LAK9cBuEtvY
 LbPDZzcmn5dde5DeJ1SOzGm+wlVJGVlsWf1FmoUCCVbSMXCVViefe4LfwClbMBouy6jw/Hn
 wIsXuXG5wgmZb4nisDC7FHeX+4hMbX+B+v1wZMWiAWoCIcGy8swv6PZO+3hnA/y9NF4HbqA
 QpN3aPdxCRzqr4iv9qQ7ELD3KlAsZhAFRIBIn/EM4M0T0ARlGXkiKZUZrNkBM2AhiTn3PLK
 SC7fpSOkTUlbEX2zH3+tHs+/QCK1hXfUR9/4pckB4TITDR4TlS1Ca00yOfRDmt1B+OK5cXW
 CKLU2kTK6wNJ3gbuxQgpFKINKUbngdI78mOoX7tJAqfaKE1CRqdcGELIufUuBUXkVayMDN+
 uJQ2Y9O0hLpOL740GDBvQNydZGk72DvnJGY9S2pM8IzFgPHPKBBmqA=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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

Backplane CR/KR link training on the E56 PHY is unreliable and does
not recover after a link event: the completion poll can block for a
second on a condition that never triggers, the page exchange is only
run once and its result is assumed to stay valid, and the FFE init
mode and calibration ordering are also wrong.

- Poll the AN FSM (0x78010, value 0x9) for CL72 completion with a
  1 ms step and a 400 ms budget, replacing the ephy 0x163c mask-0xe
  poll that tested the wrong condition; the per-lane TX-FFE dumps
  move into txgbe_e56_get_txffe(), called once AN completes.
- Re-run the page exchange on every AN next-page interrupt from the
  event handler (50 x 1 ms poll, explicit next-page handshake,
  -ETIMEDOUT on expiry) and only enter training after it succeeds;
  the inline exchange in the AN73 flow is removed and a CL72 failure
  no longer aborts the flow, so every link event re-runs the
  exchange instead of assuming the previous one is still valid.
- Initialize the FFE init mode bits in cfg_40g()/cfg_10g(), run
  txgbe_e56_set_rxs_ufine_le_max() after the RXS osc init, and write
  0x78001 = 0x7 in the AN programming sequence.
- Clear hw->bp_link_mode in txgbe_set_link_to_sfi() so a port that
  trained on the backplane does not keep a stale backplane mode
  after switching to SFI.

Fixes: 234ce0d1fa9d ("net/txgbe: fix link stability for Amber-Lite backplane mode")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_e56.c    |   3 +
 drivers/net/txgbe/base/txgbe_e56.h    |   1 +
 drivers/net/txgbe/base/txgbe_e56_bp.c | 161 +++++++++++++++-----------
 drivers/net/txgbe/base/txgbe_e56_bp.h |   2 +
 drivers/net/txgbe/base/txgbe_phy.c    |   3 +
 drivers/net/txgbe/txgbe_ethdev.c      |  28 ++++-
 6 files changed, 129 insertions(+), 69 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_e56.c b/drivers/net/txgbe/base/txgbe_e56.c
index 2711863f2c..8e986daf96 100644
--- a/drivers/net/txgbe/base/txgbe_e56.c
+++ b/drivers/net/txgbe/base/txgbe_e56.c
@@ -551,6 +551,7 @@ u32 txgbe_e56_cfg_40g(struct txgbe_hw *hw)
 
 	addr  = E56PHY_FETX_FFE_TRAIN_CFG_0_ADDR;
 	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_FETX_FFE_TRAIN_CFG_0_KRT_FETX_INIT_FFE_CFG_0, 0x2);
 	set_fields_e56(&rdata, E56PHY_FETX_FFE_TRAIN_CFG_0_KRT_FETX_INIT_FFE_CFG_2, 0x2);
 	wr32_ephy(hw, addr, rdata);
 
@@ -1377,6 +1378,8 @@ txgbe_e56_cfg_10g(struct txgbe_hw *hw)
 
 	addr = E56PHY_FETX_FFE_TRAIN_CFG_0_ADDR;
 	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_FETX_FFE_TRAIN_CFG_0_KRT_FETX_INIT_FFE_CFG_0,
+		       0x2);
 	set_fields_e56(&rdata, E56PHY_FETX_FFE_TRAIN_CFG_0_KRT_FETX_INIT_FFE_CFG_2,
 		       0x2);
 	wr32_ephy(hw, addr, rdata);
diff --git a/drivers/net/txgbe/base/txgbe_e56.h b/drivers/net/txgbe/base/txgbe_e56.h
index fe9a83ae01..32d95b61b9 100644
--- a/drivers/net/txgbe/base/txgbe_e56.h
+++ b/drivers/net/txgbe/base/txgbe_e56.h
@@ -435,6 +435,7 @@ typedef union {
 #define E56PHY_KRT_TFSM_CFGKRT_TFSM_HOLDOFF_TIMER_X256K 23, 16
 
 #define E56PHY_FETX_FFE_TRAIN_CFG_0_ADDR   (E56PHY_PMD_BASE_ADDR + 0x2BC)
+#define E56PHY_FETX_FFE_TRAIN_CFG_0_KRT_FETX_INIT_FFE_CFG_0 1, 0
 #define E56PHY_FETX_FFE_TRAIN_CFG_0_KRT_FETX_INIT_FFE_CFG_2 9, 8
 #define E56PHY_FETX_FFE_TRAIN_CFG_0_KRT_FETX_INIT_FFE_CFG_3 13, 12
 
diff --git a/drivers/net/txgbe/base/txgbe_e56_bp.c b/drivers/net/txgbe/base/txgbe_e56_bp.c
index d376d918df..f840e6b5dd 100644
--- a/drivers/net/txgbe/base/txgbe_e56_bp.c
+++ b/drivers/net/txgbe/base/txgbe_e56_bp.c
@@ -813,6 +813,7 @@ static int txgbe_e56_phy_rxs_calib_adapt_seq(struct txgbe_hw *hw,
 		status |= txgbe_e56_ctle_bypass_seq(hw, bp_link_mode);
 
 	status |= txgbe_e56_rxs_osc_init_for_temp_track_range(hw, bp_link_mode);
+	txgbe_e56_set_rxs_ufine_le_max(hw, bp_link_mode);
 
 	/* Wait an fsm_rx_sts 25G */
 	BP_LOG("Wait CTRL_FSM_RX_STAT[0]::ctrl_fsm_rx0_st to be ready ...\n");
@@ -2123,6 +2124,7 @@ int txgbe_e56_set_phy_link_mode(struct txgbe_hw *hw,
 	set_fields_e56(&rdata, 12, 12, 0x1);
 	wr32_epcs(hw, 0x070000, rdata);
 	wr32_epcs(hw, 0x078002, 0x0000);
+	wr32_epcs(hw, 0x78001, 0x7);
 	/* pcs case fec en to work around first */
 	wr32_epcs(hw, 0x100ab, 1);
 
@@ -2351,24 +2353,29 @@ static int chk_bkp_ability(struct txgbe_hw *hw,
 	return 0;
 }
 
-static int txgbe_e56_exchange_page(struct txgbe_hw *hw)
+int txgbe_e56_exchange_page(struct txgbe_hw *hw)
 {
 	struct txgbe_backplane_ability local_ability = {0}, lp_ability = {0};
 	u32 an_int, base_page = 0;
-	int count = 0;
+	int count = 0, count2 = 0;
 
 	an_int = rd32_epcs(hw, 0x78002);
-	/* 500ms timeout */
 	if (!(an_int & VR_AN_INTR_PG_RCV))
 		return -EINVAL;
 
-	for (count = 0; count < 500; count++) {
+	/* 50ms timeout */
+	for (count = 0; count < 50; count++) {
 		u32 fsm = rd32_epcs(hw, 0x78010);
-		u32 rdata = rd32_epcs(hw, 0x78002);
+		u32 next_page = 0;
+		u32 rdata;
+
+		count2++;
 
 		BP_LOG("-----count----- %d - fsm: %x\n", count, fsm);
-		BP_LOG("read 78002 data %0x and clear pacv\n", rdata);
+		rdata = rd32_epcs(hw, 0x78002);
+		/* clear an pacv int */
 		an_int = rdata;
+		BP_LOG("read 78002 data %0x and clear pacv\n", rdata);
 		set_fields_e56(&rdata, 2, 2, 0x0);
 		wr32_epcs(hw, 0x78002, rdata);
 		if (an_int & VR_AN_INTR_PG_RCV) {
@@ -2383,31 +2390,84 @@ static int txgbe_e56_exchange_page(struct txgbe_hw *hw)
 					wr32_epcs(hw, 0x70016, 0x2001);
 					BP_LOG("write 70016 0x%0x\n",
 					       0x2001);
+					next_page = 1;
+					count = 0; /* reset count to wait next page */
+				} else {
+					next_page = 0;
 				}
 				base_page = 1;
 			}
 		}
-		if ((fsm & 0x8) == 0x8) {
-			hw->fsm = 0x8;
-			goto check_ability;
+		if (!next_page) {
+			if ((fsm & 0x8) == 0x8) {
+				hw->fsm = 0x8;
+				goto check_ability;
+			}
 		}
-		usec_delay(100);
+		usec_delay(1000);
 	}
 
 check_ability:
+	if (count == 50) {
+		BP_LOG("Wait for next page timeout\n");
+		return -ETIMEDOUT;
+	}
+	BP_LOG("AN exchange page done in %d ms\n", count2);
 	return chk_bkp_ability(hw, local_ability, lp_ability);
 }
 
+void txgbe_e56_get_txffe(struct txgbe_hw *hw)
+{
+	/* 21. read txffe to check kr training status */
+	u32 rdata = 0, pmd_ctrl = 0, lane_idx = 0, lane_num = 0, txffe = 0;
+
+	switch (hw->bp_link_mode) {
+	case 10:
+		lane_num = 1;
+		break;
+	case 40:
+		lane_num = 4;
+		break;
+	case 25:
+		lane_num = 1;
+		break;
+	default:
+		BP_LOG("%s %d :Invalid speed\n", __func__, __LINE__);
+		return;
+	}
+
+	BP_LOG("%dG phy kr training check.... fsm: %x\n",
+	       hw->bp_link_mode, rd32_epcs(hw, 0x78010));
+	rdata = rd32_ephy(hw, 0x163c) & GENMASK(lane_num, 1);
+	pmd_ctrl = rd32_ephy(hw, 0x1644);
+	BP_LOG("KR TRAINNING CHECK = %x. pmd_ctrl:%lx-%lx-%lx-%lx\n",
+	       rdata,
+	       FIELD_GET_M(GENMASK(3, 0), pmd_ctrl),
+	       FIELD_GET_M(GENMASK(7, 4), pmd_ctrl),
+	       FIELD_GET_M(GENMASK(11, 8), pmd_ctrl),
+	       FIELD_GET_M(GENMASK(15, 12), pmd_ctrl));
+	BP_LOG("before: %x-%x-%x-%x\n",
+	       rd32_ephy(hw, 0x141c), rd32_ephy(hw, 0x1420),
+	       rd32_ephy(hw, 0x1424), rd32_ephy(hw, 0x1428));
+	for (lane_idx = 0; lane_idx < lane_num; lane_idx++) {
+		txffe = rd32_ephy(hw, 0x828 + lane_idx * 0x100);
+		BP_LOG("after[%x]: %lx-%lx-%lx-%lx\n", lane_idx,
+		       FIELD_GET_M(GENMASK(6, 0), txffe),
+		       FIELD_GET_M(GENMASK(21, 16), txffe),
+		       FIELD_GET_M(GENMASK(29, 24), txffe),
+		       FIELD_GET_M(GENMASK(13, 8), txffe));
+	}
+}
+
 static int txgbe_e56_cl72_training(struct txgbe_hw *hw)
 {
 	u32 bylinkmode = hw->bp_link_mode;
 	u8 bypass_ctle = hw->bypass_ctle;
 	int status = 0, temp_data = 0;
-	u32 lane_num = 0, lane_idx = 0;
-	u32 __rte_unused pmd_ctrl = 0, txffe = 0;
+	u32 lane_num = 0;
+	u32 __rte_unused pmd_ctrl = 0;
 	int ret = 0;
 	u32 rdata;
-
 	u8 pll_en_cfg = 0;
 	u8 pmd_mode = 0;
 
@@ -2463,52 +2523,48 @@ static int txgbe_e56_cl72_training(struct txgbe_hw *hw)
 
 	/* 18 */
 	/* 19. rxs calibration and adaptation sequence */
-	BP_LOG("2.4 Wait %dG RXS.... fsm: %x\n",
-	       bylinkmode, rd32_epcs(hw, 0x78010));
+	BP_LOG("2.4 Wait %dG RXS.... fsm: %x, an_int: %x\n",
+	       bylinkmode, rd32_epcs(hw, 0x78010),
+	       rd32_epcs(hw, 0x78002));
 	status = txgbe_e56_phy_rxs_calib_adapt_seq(hw, bylinkmode, bypass_ctle);
 	ret |= status;
 	/* 20 */
-	BP_LOG("2.5 Wait %dG phy calibration.... fsm: %x\n",
-	       bylinkmode, rd32_epcs(hw, 0x78010));
-	txgbe_e56_set_rxs_ufine_le_max(hw, bylinkmode);
+	BP_LOG("2.5 Wait %dG phy calibration.... fsm: %x, an_int: %x\n",
+	       bylinkmode, rd32_epcs(hw, 0x78010),
+	       rd32_epcs(hw, 0x78002));
 	status = txgbe_e56_get_temp(hw, &temp_data);
 	if (bylinkmode == 40)
 		status = txgbe_temp_track_seq_40g(hw, TXGBE_LINK_SPEED_40GB_FULL);
 	else
 		status = txgbe_e56_rxs_post_cdr_lock_temp_track_seq(hw, bylinkmode);
+
+	ret |= status;
 	/* 21 */
-	BP_LOG("2.6 Wait %dG phy kr training check.... fsm: %x\n",
-	       bylinkmode, rd32_epcs(hw, 0x78010));
-	status = kr_read_poll(rd32_ephy, rdata,
-				  ((rdata & 0xe) & GENMASK(lane_num, 1)) ==
-				  (0xe & GENMASK(lane_num, 1)), 100,
-				   10000, hw, 0x163c);
+	BP_LOG("2.6 Wait %dG phy kr fsm check : %x, an_int: %x\n",
+	       bylinkmode, rd32_epcs(hw, 0x78010),
+	       rd32_epcs(hw, 0x78002));
+	status = kr_read_poll(rd32_epcs, rdata,
+			      (rdata & 0x9) == 0x9, 1000,
+			      400, hw, 0x78010);
 	pmd_ctrl = rd32_ephy(hw, 0x1644);
-	BP_LOG("KR TRAINING CHECK = %x, %s. pmd_ctrl:%lx-%lx-%lx-%lx\n",
+	BP_LOG("KR FSM CHECK = %x, %s. pmd_ctrl:%lx-%lx-%lx-%lx\n",
 	       rdata, status ? "FAILED" : "SUCCESS",
 	       FIELD_GET_M(GENMASK(3, 0), pmd_ctrl),
 	       FIELD_GET_M(GENMASK(7, 4), pmd_ctrl),
 	       FIELD_GET_M(GENMASK(11, 8), pmd_ctrl),
 	       FIELD_GET_M(GENMASK(15, 12), pmd_ctrl));
 	ret |= status;
-	BP_LOG("before: %x-%x-%x-%x\n",
-	       rd32_ephy(hw, 0x141c), rd32_ephy(hw, 0x1420),
-	       rd32_ephy(hw, 0x1424), rd32_ephy(hw, 0x1428));
-
-	for (lane_idx = 0; lane_idx < lane_num; lane_idx++) {
-		txffe = rd32_ephy(hw, 0x828 + lane_idx * 0x100);
-		BP_LOG("after[%x]: %lx-%lx-%lx-%lx\n", lane_idx,
-		       FIELD_GET_M(GENMASK(6, 0), txffe),
-		       FIELD_GET_M(GENMASK(21, 16), txffe),
-		       FIELD_GET_M(GENMASK(29, 24), txffe),
-		       FIELD_GET_M(GENMASK(13, 8), txffe));
-	}
 
 	/* 22 */
-	BP_LOG("2.7 Wait %dG phy Rx adc.... fsm:%x\n",
-	       bylinkmode, rd32_epcs(hw, 0x78010));
+	BP_LOG("2.7 Wait %dG phy Rx adc.... fsm:%x, an_int: %x\n",
+	       bylinkmode, rd32_epcs(hw, 0x78010),
+	       rd32_epcs(hw, 0x78002));
 	status = txgbe_e56_rxs_adc_adapt_seq(hw, bypass_ctle);
 
+	BP_LOG("2.8 ===end ret : %d.... fsm:%x, an_int: %x\n",
+	       ret, rd32_epcs(hw, 0x78010),
+	       rd32_epcs(hw, 0x78002));
+
 	return ret;
 }
 
@@ -2517,27 +2573,7 @@ int txgbe_handle_e56_bkp_an73_flow(struct txgbe_hw *hw)
 	int status = 0;
 	u32 rdata;
 
-	BP_LOG("2.1 Wait page changed ....\n");
-	status = txgbe_e56_exchange_page(hw);
-	if (status) {
-		BP_LOG("Exchange page failed\n");
-		return status;
-	}
-
-	BP_LOG("2.2 Wait page changed ..done..\n");
-	wr32_epcs(hw, 0x100ab, 0);
-	if (AN_TRAINING_MODE) {
-		rdata = rd32_epcs(hw, 0x70000);
-		BP_LOG("read 0x70000 data %0x\n", rdata);
-		wr32_epcs(hw, 0x70000, 0);
-		BP_LOG("write 0x70000 0x%0x\n", 0);
-	}
-
-	rdata = rd32_epcs(hw, 0x78002);
-	BP_LOG("read 78002 data %0x and clear page int\n", rdata);
-	set_fields_e56(&rdata, 2, 2, 0x0);
-	wr32_epcs(hw, 0x78002, rdata);
-
+	/* 10  RXS_DISABLE - TXS_DISABLE - CMS_DISABLE */
 	/* dis phy tx/rx lane */
 	rdata = rd32_ephy(hw, 0x1400);
 	set_fields_e56(&rdata, 19, 16, 0x0);
@@ -2583,11 +2619,6 @@ int txgbe_handle_e56_bkp_an73_flow(struct txgbe_hw *hw)
 	}
 
 	status = txgbe_e56_cl72_training(hw);
-	if (status) {
-		BP_LOG("CL72 training failed, status = %d\n", status);
-		return status;
-	}
-
 	rdata = rd32_ephy(hw, E56PHY_RXS_IDLE_DETECT_1_ADDR);
 	set_fields_e56(&rdata, E56PHY_RXS_IDLE_DETECT_1_IDLE_TH_ADC_PEAK_MAX, 0x28);
 	set_fields_e56(&rdata, E56PHY_RXS_IDLE_DETECT_1_IDLE_TH_ADC_PEAK_MIN, 0xa);
diff --git a/drivers/net/txgbe/base/txgbe_e56_bp.h b/drivers/net/txgbe/base/txgbe_e56_bp.h
index d2c49c2fce..da0d02b79f 100644
--- a/drivers/net/txgbe/base/txgbe_e56_bp.h
+++ b/drivers/net/txgbe/base/txgbe_e56_bp.h
@@ -279,4 +279,6 @@ typedef union {
 int txgbe_e56_set_phy_link_mode(struct txgbe_hw *hw,
 				u8 bp_link_mode, u32 need_restart);
 int txgbe_handle_e56_bkp_an73_flow(struct txgbe_hw *hw);
+int txgbe_e56_exchange_page(struct txgbe_hw *hw);
+void txgbe_e56_get_txffe(struct txgbe_hw *hw);
 #endif
diff --git a/drivers/net/txgbe/base/txgbe_phy.c b/drivers/net/txgbe/base/txgbe_phy.c
index 8b653f0aeb..10df23afae 100644
--- a/drivers/net/txgbe/base/txgbe_phy.c
+++ b/drivers/net/txgbe/base/txgbe_phy.c
@@ -1947,6 +1947,9 @@ txgbe_set_link_to_sfi(struct txgbe_hw *hw,
 	s32 err = 0;
 	u32 value = 0;
 
+	/* Switching to SFI mode clears backplane link mode. */
+	hw->bp_link_mode = 0;
+
 	/* Set the module link speed */
 	hw->mac.set_rate_select_speed(hw, speed);
 	/* 1. Wait xpcs power-up good */
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index ef30e0c40a..269e0aadd9 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -3025,6 +3025,7 @@ void txgbe_dev_e56_check_bp_event(void *param)
 	u32 __rte_unused an_int = 0;
 	int ret = 0;
 	bool need_link_update = false;
+	bool exchange_done = false;
 
 	if (!hw)
 		return;
@@ -3043,8 +3044,10 @@ void txgbe_dev_e56_check_bp_event(void *param)
 		hw->phy.sfp_type = txgbe_sfp_type_not_present;
 	}
 
-	if (!(txgbe_xpcs_an_enabled(hw)))
+	if (!(txgbe_xpcs_an_enabled(hw))) {
+		BP_LOG("%s %d\n", __func__, __LINE__);
 		return;
+	}
 
 	if (!hw->devarg.auto_neg)
 		return;
@@ -3063,6 +3066,7 @@ void txgbe_dev_e56_check_bp_event(void *param)
 		need_link_update = true;
 		value &= ~VR_AN_INTR_CMPLT;
 		wr32_epcs(hw, VR_AN_INTR, value);
+		txgbe_e56_get_txffe(hw);
 	}
 
 	if (value & VR_AN_INTR_LINK) {
@@ -3080,7 +3084,21 @@ void txgbe_dev_e56_check_bp_event(void *param)
 	}
 
 	if (value & VR_AN_INTR_PG_RCV) {
-		BP_LOG("%d Enter training\n", hw->port_id);
+		BP_LOG("%d 2.1 *** Wait page changed ....\n", hw->port_id);
+		ret = txgbe_e56_exchange_page(hw);
+		if (ret) {
+			BP_LOG("%d 2.2 *** Exchange page failed\n", hw->port_id);
+			goto an_status;
+		} else {
+			BP_LOG("%d 2.2 *** Wait page changed ..done..\n",
+			       hw->port_id);
+			wr32_epcs(hw, 0x100ab, 0);
+			exchange_done = true;
+		}
+	}
+
+	if (exchange_done) {
+		BP_LOG("%d 2.2.2 *** Enter training\n", hw->port_id);
 		ret = txgbe_handle_e56_bkp_an73_flow(hw);
 		if (!AN_TRAINING_MODE) {
 			fsm = rd32_epcs(hw, 0x78010);
@@ -3783,8 +3801,10 @@ txgbe_dev_interrupt_get_status(struct rte_eth_dev *dev,
 	if (eicr & TXGBE_ICRMISC_LSC)
 		intr->flags |= TXGBE_FLAG_NEED_LINK_UPDATE;
 
-	if (eicr & TXGBE_ICRMISC_ANDONE)
-		intr->flags |= TXGBE_FLAG_NEED_AN_CONFIG;
+	if (eicr & TXGBE_ICRMISC_ANDONE) {
+		PMD_DRV_LOG(DEBUG, "an int eicr=0x%08x", eicr);
+		intr->flags |= TXGBE_FLAG_NEED_AN_CONFIG;//aml40-to-do
+	}
 
 	if (eicr & TXGBE_ICRMISC_VFMBX)
 		intr->flags |= TXGBE_FLAG_MAILBOX;
-- 
2.55.0.windows.2

