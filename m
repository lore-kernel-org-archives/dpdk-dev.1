Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CADCA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 11:23:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C51AA4281D;
	Tue, 29 Sep 2026 13:22:15 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 0DACD427E9;
 Tue, 29 Sep 2026 13:22:09 +0200 (CEST)
X-QQ-mid: zesmtpgz6t1790680926tdba52daf
X-QQ-Originating-IP: LIq52qm2COkYYxLRoGcm6hgemiCwpPxoRSrUMX1y3XM=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.38])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 29 Sep 2026 19:22:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15466686366719228635
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v5 14/15] net/txgbe: fix CR/KR link training and recovery
Date: Tue, 29 Sep 2026 19:18:14 +0800
Message-ID: <15400C1BD022812E+20260929112119.4516-15-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260929112119.4516-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260929112119.4516-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NwU0tZNR0OQKLUYqHqL6pom1Gwtlu+8zO/so2qnnsZYSv+4+B0Z9eIJG
 epx2pxFk0gcc2hpdBrgX9BZvDzMFqoDDW6UPL7mvoCoG5j5TKlg8TBqvv/kRqIGICHTe0Od
 7LryGo3S/KPsQ6o2DhCLb7qRKocsnC7TjWLS2fTlnmXm7Tj2EAF/Fk5RBFiclqPEXOC7vfP
 hMjJh2qYk31vOarH1TVtAJO0H/nX/VJmVVN/zNAJ62TkHHJPiFGT5YhRFquLrUN3fMoleCk
 EPqAazSnXUSpfxIFEUmVRqOqA86DllLYNos0r2eVtsEaFFIeWBVK53MziqOI6qQ5Lke2R8w
 GI+ylFX1MJKSPSyuofDssWSLqHNFjHth4NJ4KzGhQKrF8bog+a8YExhh9J3VqewDI7MBuG3
 enKWBL3tfnv/uyB22kNeFMn51x7ElPpfBrrx3XYOJfVIPnhU4/tEZ9SFy3DzhI4Ujf0EEJT
 4CcHzKqxwSZrmoz1Pqvvn5tYtry69bpLFXUrgEpdVLmDtUWQQ2fsAcxvSJBXaPbQ0Gjfg8r
 QwUaHm9U5dJkmQOvoogj4F7eiDYjAW0m2MA9AMIs9065HzBT4RkGharH732y/JTFXIU7wOm
 8VLbcISrazov/uHgn8cHfm2SJnSePUKDjNZSt+bPsjGQQXTJ0kqBlArbIQRj6FpOPhRXHDq
 tWAydRoT5bH6XRHNlc1zvRdVhIuauuQNd8EOuKQOqkG2Iy6ag4OmKDArc/9ipuUQq6q3oeR
 FZDO4bYGWQ5JQ+0ym7rhVJoS4oAEVbFMVWbM0k0ekMbuVyzp4fY40rjsG1Ddya8H5kHDsZP
 WVYbZgUk5glfLIp5SGsewGEv9WrnHnSGZy5ain/Wfo5R/wSDVOMisWtIU4sgbRJxBq5ErBx
 3UwFqa2hDSWoLIbd6aXPPUIx21w+hdnAv5BmMYveTjylxKgr/oqkMBMCvmFdRO9zEBrQMQn
 uDd2pphMW5TQI5JLWXvS9V9KW1TL71rmjGLDYt4KTdcZ7+S26VIT9osG6rxLKG+Od85YSfg
 YNSLC0KEHNheEjGOVV81xvqroSLdnyuN/g0kL4qXKioGs0txsNY+fKXxFPdMJBPitCaUHo3
 c6/3gqJDeH8riGABoVOcdE=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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
- Re-run the page exchange on every AN next-page interrupt (1 ms
  step, 50-count round, explicit next-page handshake, -ETIMEDOUT on
  expiry) and only enter training after it succeeds; the inline
  exchange in the AN73 flow is removed and a CL72 failure no longer
  aborts the flow, so every link event re-runs the exchange instead
  of assuming the previous one is still valid.
- Initialize the FFE init mode bits in cfg_40g()/cfg_10g(), run
  txgbe_e56_set_rxs_ufine_le_max() after the RXS osc init, and write
  0x78001 = 0x7 in the AN programming sequence.
- Clear hw->bp_link_mode in txgbe_set_link_to_sfi() so a port that
  trained on the backplane does not keep a stale backplane mode after
  switching to SFI.
- Avoid register reads that are only used by disabled BP debug logs,
  and drop a leftover debug line in the watchdog.

Fixes: 234ce0d1fa9d ("net/txgbe: fix link stability for Amber-Lite backplane mode")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_e56.c    |   3 +
 drivers/net/txgbe/base/txgbe_e56.h    |   1 +
 drivers/net/txgbe/base/txgbe_e56_bp.c | 173 ++++++++++++++++----------
 drivers/net/txgbe/base/txgbe_e56_bp.h |   2 +
 drivers/net/txgbe/base/txgbe_osdep.h  |  12 +-
 drivers/net/txgbe/base/txgbe_phy.c    |   3 +
 drivers/net/txgbe/txgbe_ethdev.c      |  24 +++-
 7 files changed, 146 insertions(+), 72 deletions(-)

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
index 760101a05e..8597e42dfd 100644
--- a/drivers/net/txgbe/base/txgbe_e56_bp.c
+++ b/drivers/net/txgbe/base/txgbe_e56_bp.c
@@ -813,6 +813,7 @@ static int txgbe_e56_phy_rxs_calib_adapt_seq(struct txgbe_hw *hw,
 		status |= txgbe_e56_ctle_bypass_seq(hw, bp_link_mode);
 
 	status |= txgbe_e56_rxs_osc_init_for_temp_track_range(hw, bp_link_mode);
+	txgbe_e56_set_rxs_ufine_le_max(hw, bp_link_mode);
 
 	/* Wait an fsm_rx_sts 25G */
 	BP_LOG("Wait CTRL_FSM_RX_STAT[0]::ctrl_fsm_rx0_st to be ready ...\n");
@@ -2121,6 +2122,7 @@ int txgbe_e56_set_phy_link_mode(struct txgbe_hw *hw,
 	set_fields_e56(&rdata, 12, 12, 0x1);
 	wr32_epcs(hw, 0x070000, rdata);
 	wr32_epcs(hw, 0x078002, 0x0000);
+	wr32_epcs(hw, 0x78001, 0x7);
 	/* pcs case fec en to work around first */
 	wr32_epcs(hw, 0x100ab, 1);
 
@@ -2350,24 +2352,35 @@ static int chk_bkp_ability(struct txgbe_hw *hw,
 	return 0;
 }
 
-static int txgbe_e56_exchange_page(struct txgbe_hw *hw)
+#define AN_PAGE_EXCHANGE_TIMEOUT_MS 200
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
+		if (count2 >= AN_PAGE_EXCHANGE_TIMEOUT_MS) {
+			BP_LOG("Wait for next page timeout after %d ms\n",
+			       count2);
+			return -ETIMEDOUT;
+		}
 
 		BP_LOG("-----count----- %d - fsm: %x\n", count, fsm);
-		BP_LOG("read 78002 data %0x and clear pacv\n", rdata);
+		rdata = rd32_epcs(hw, 0x78002);
+		/* clear an pacv int */
 		an_int = rdata;
+		BP_LOG("read 78002 data %0x and clear pacv\n", rdata);
 		set_fields_e56(&rdata, 2, 2, 0x0);
 		wr32_epcs(hw, 0x78002, rdata);
 		if (an_int & VR_AN_INTR_PG_RCV) {
@@ -2382,31 +2395,87 @@ static int txgbe_e56_exchange_page(struct txgbe_hw *hw)
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
+	if (!rte_log_can_log(RTE_LOGTYPE_TXGBE_BP, RTE_LOG_DEBUG))
+		return;
+
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
 
@@ -2436,6 +2505,7 @@ static int txgbe_e56_cl72_training(struct txgbe_hw *hw)
 
 	BP_LOG("2.3 Wait %dG KR phy mode init ....\n", bylinkmode);
 	status = txgbe_set_phy_link_mode(hw, bylinkmode);
+	ret |= status;
 
 	/* 13. set phy an status to 1 - AN_CFG[0]: 4-7 lane0-lane3 */
 	rdata = rd32_ephy(hw, 0x1434);
@@ -2462,51 +2532,49 @@ static int txgbe_e56_cl72_training(struct txgbe_hw *hw)
 
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
+	ret |= status;
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
+	ret |= status;
+
+	BP_LOG("2.8 ===end ret : %d.... fsm:%x, an_int: %x\n",
+	       ret, rd32_epcs(hw, 0x78010),
+	       rd32_epcs(hw, 0x78002));
 
 	return ret;
 }
@@ -2516,27 +2584,7 @@ int txgbe_handle_e56_bkp_an73_flow(struct txgbe_hw *hw)
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
@@ -2582,11 +2630,6 @@ int txgbe_handle_e56_bkp_an73_flow(struct txgbe_hw *hw)
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
index 8089e5b971..f667a052ec 100644
--- a/drivers/net/txgbe/base/txgbe_e56_bp.h
+++ b/drivers/net/txgbe/base/txgbe_e56_bp.h
@@ -279,4 +279,6 @@ typedef union {
 int txgbe_e56_set_phy_link_mode(struct txgbe_hw *hw,
 				u32 speed, u32 need_restart);
 int txgbe_handle_e56_bkp_an73_flow(struct txgbe_hw *hw);
+int txgbe_e56_exchange_page(struct txgbe_hw *hw);
+void txgbe_e56_get_txffe(struct txgbe_hw *hw);
 #endif
diff --git a/drivers/net/txgbe/base/txgbe_osdep.h b/drivers/net/txgbe/base/txgbe_osdep.h
index da069e94f6..83fee14d12 100644
--- a/drivers/net/txgbe/base/txgbe_osdep.h
+++ b/drivers/net/txgbe/base/txgbe_osdep.h
@@ -31,10 +31,14 @@
 extern int txgbe_logtype_bp;
 #define RTE_LOGTYPE_TXGBE_BP txgbe_logtype_bp
 #define BP_LOG(fmt, ...) \
-	RTE_LOG(DEBUG, TXGBE_BP, \
-		"[%"PRIu64".%"PRIu64"]%s(%d): " fmt, \
-		usec_stamp() / 1000000, usec_stamp() % 1000000, \
-		__func__, __LINE__, ## __VA_ARGS__)
+	do { \
+		if (rte_log_can_log(RTE_LOGTYPE_TXGBE_BP, RTE_LOG_DEBUG)) \
+			RTE_LOG(DEBUG, TXGBE_BP, \
+				"[%"PRIu64".%"PRIu64"]%s(%d): " fmt, \
+				usec_stamp() / 1000000, \
+				usec_stamp() % 1000000, \
+				__func__, __LINE__, ## __VA_ARGS__); \
+	} while (0)
 
 #define ASSERT(x) do {			\
 	if (!(x))			\
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
index 7d07be93ed..dd9dc9a373 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -3050,6 +3050,7 @@ void txgbe_dev_e56_check_bp_event(void *param)
 	u32 __rte_unused an_int = 0;
 	int ret = 0;
 	bool need_link_update = false;
+	bool exchange_done = false;
 
 	if (!hw)
 		return;
@@ -3075,7 +3076,7 @@ void txgbe_dev_e56_check_bp_event(void *param)
 		}
 	}
 
-	if (!(txgbe_xpcs_an_enabled(hw)))
+	if (!txgbe_xpcs_an_enabled(hw))
 		return;
 
 	if (!hw->devarg.auto_neg)
@@ -3095,6 +3096,7 @@ void txgbe_dev_e56_check_bp_event(void *param)
 		need_link_update = true;
 		value &= ~VR_AN_INTR_CMPLT;
 		wr32_epcs(hw, VR_AN_INTR, value);
+		txgbe_e56_get_txffe(hw);
 	}
 
 	if (value & VR_AN_INTR_LINK) {
@@ -3112,7 +3114,21 @@ void txgbe_dev_e56_check_bp_event(void *param)
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
@@ -3833,8 +3849,10 @@ txgbe_dev_interrupt_get_status(struct rte_eth_dev *dev,
 	if (eicr & TXGBE_ICRMISC_LSC)
 		intr->flags |= TXGBE_FLAG_NEED_LINK_UPDATE;
 
-	if (eicr & TXGBE_ICRMISC_ANDONE)
+	if (eicr & TXGBE_ICRMISC_ANDONE) {
+		PMD_DRV_LOG(DEBUG, "an int eicr=0x%08x", eicr);
 		intr->flags |= TXGBE_FLAG_NEED_AN_CONFIG;
+	}
 
 	if (eicr & TXGBE_ICRMISC_VFMBX)
 		intr->flags |= TXGBE_FLAG_MAILBOX;
-- 
2.55.0.windows.2

