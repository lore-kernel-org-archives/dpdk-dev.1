Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB29CA9ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 11:05:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C79D40374;
	Mon, 12 Oct 2026 13:05:37 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id E3646402C6;
 Mon, 12 Oct 2026 13:05:33 +0200 (CEST)
X-QQ-mid: zesmtpsz4t1791803130te5500f1d
X-QQ-Originating-IP: X2DuMJQ3XSFb1oCMDM8z75SgiQ7XdLogaAUWW59aFK4=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.198.217.6])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 12 Oct 2026 19:05:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10086184058274485404
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v8 02/16] net/txgbe: use the requested speed in E56 AN setup
Date: Mon, 12 Oct 2026 18:56:19 +0800
Message-ID: <AD72BC92DDB1B64F+20261012110518.1911-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261012110518.1911-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261012110518.1911-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MPIPMtP+A9k/d4Au8NECbkA+TrgTyUBO3+NPw7PoIXxHoM3Dj4cfEY6v
 iJJpUm0U583+0SFmvONp0p8etlYo9rz0Jn/dsD2Bimy3xJdbNNz4pK9gUV4bL8wH+lkYerF
 +tpKzmVW9iXtP1M3cW1A0yAEV7DlAzqVzVRhFg0pBfeJmY/E3jVbppdtqyClQ4ISZLJkMg6
 OynX4F2rrYJExrfBsSg0pLKf/GWWdaCoho3G1g5SJ2A8Z9ZpIUCNJ1p4ItCfDwAXo3fF98f
 2EfqNP9lNGRjzIXOlq8a78lFYakyvF/25bzCYEPHqncl1DBvZPXBC1ZeaUWc0HkQE9lrvAl
 w6q9wNO6Zl09+YmzJADiQH4WWqgTGj3n/sg3w6Gc0noEERmSWicGJIw0Y29xZFTDwLvd4gp
 JL8Z40GZNHHu6H+P3sYDoR6lFd6TB6MNCqtnxGrmxrpAjcO2X/ZJo3cqABuihP3Bzzeg0Iw
 uRnGbVTGjAICTy+xWikjah321HAUvB4rL29JLBM3NBzYZCqTQt6b6epexYzR68kYxixASSo
 YX4fA/Gc0eTwWDWticSiC+GuPD6NTOb+e8PzIU2txBOUVxEF/XrvZSxQ9e4Oe6vsibceG25
 nQzeCowDEEsaq81N4hsJmW2W4FxReb21BzTNMgpT63VpuuBG96mv2LDmJdAV63bSw3jwC9K
 wWwZ5Ki6dckehrEMeImGtJOXWREEUtr+Pn7bRWjdYBK5qM8ev6wzoVHzsDa9709juhN0B4C
 bTwQBF9P8PYvfognmZ+//2DtLsrJpp8pa7pZ/2fHlpHUtQ/Lqm9gBbnoikVN1h4nshl6ptO
 6ZL9FM+cVbChUmeIzmex9W6B6cOgrUHU7WtzOkvjM6J012ZDBwc/PVhOO2HtalOrc2nbd4H
 u5QnyAw5pMeSJbUnLfajIjtnT5SUsRM21baIg1F6Nh6EiPgwEF1iR2CTiRFhTX72JZJ6/CT
 uFpX6RKplZ7VmZaJjyOOLkvNSDVbSZbXBjohQ0gwkIPT3kDelU2KCilhtJO3SMDa10BgG08
 3++u0B+P7WxZgj30wfiqFpvJhszNC/3Yxme13yW1E9fpF61BWIX80ahBp2onvXlnjhJYOQH
 ltZgjQq5iRDGFLkpEr24ag=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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

txgbe_e56_set_phy_link_mode() takes the speeds to advertise, but the
port does not use the argument: it is passed to
UNREFERENCED_PARAMETER(), and the AN base page is built from the
device id and from hw->phy.fiber_suppport_speed instead. The caller
therefore cannot narrow what is advertised, which is what kept a
10G request from reaching the base page on a 10G/40G part even
after the capability mask had been opened up.

Take the argument as a speed bitmask, as the base layer of the
out-of-tree driver does: gate the 10G, 25G, and 40G advertisement on
the requested speed and use speed rather than
hw->phy.fiber_suppport_speed on the fiber/DAC path.

Both Amber-Lite MACs support 10GBASE-KR in addition to their nominal
speed: the capability masks already report 10G|25G for the 25G MAC
and 10G|40G for the 40G MAC, while the AN base page advertised
exactly one speed picked from the device id. With automatic speed
selection asking for 10G|40G on the 40G MAC as it already did 10G|25G
on the 25G MAC, the base page advertises 10GBASE-KR together with
25GBASE-KR/CR on the 25G MAC and together with 40GBASE-KR4/CR4 on the
40G MAC. Explicit speed requests advertise only the requested modes.

The AN restart paths also have no record of the caller speed to
re-apply. Record it in hw->phy.autoneg_advertised before setup_link(),
as the base layer does, and pass it from the watchdog and
training-restart paths instead of the hardcoded 10. The two readers
of that field keep their existing fallback to get_link_capabilities()
when it is zero.

Fixes: 234ce0d1fa9d ("net/txgbe: fix link stability for Amber-Lite backplane mode")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml40.c  |  2 +-
 drivers/net/txgbe/base/txgbe_e56_bp.c | 23 +++++++++++------------
 drivers/net/txgbe/base/txgbe_e56_bp.h |  2 +-
 drivers/net/txgbe/txgbe_ethdev.c      | 25 +++++++++++++++++++++----
 4 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index 7c72b53f64..7476759d4d 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -172,7 +172,7 @@ s32 txgbe_setup_phy_link_aml40(struct txgbe_hw *hw,
 		if (link_up && hw->an_done && !autoneg_wait_to_complete)
 			return status;
 		rte_spinlock_lock(&hw->phy_lock);
-		txgbe_e56_set_phy_link_mode(hw, 40, autoneg_wait_to_complete);
+		txgbe_e56_set_phy_link_mode(hw, speed, autoneg_wait_to_complete);
 		rte_spinlock_unlock(&hw->phy_lock);
 		return status;
 	}
diff --git a/drivers/net/txgbe/base/txgbe_e56_bp.c b/drivers/net/txgbe/base/txgbe_e56_bp.c
index d376d918df..760101a05e 100644
--- a/drivers/net/txgbe/base/txgbe_e56_bp.c
+++ b/drivers/net/txgbe/base/txgbe_e56_bp.c
@@ -2091,13 +2091,11 @@ static int txgbe_set_phy_link_mode(struct txgbe_hw *hw,
 }
 
 int txgbe_e56_set_phy_link_mode(struct txgbe_hw *hw,
-			     u8 bp_link_mode, u32 need_restart)
+			     u32 speed, u32 need_restart)
 {
 	int status = 0;
 	u32 rdata;
 
-	UNREFERENCED_PARAMETER(bp_link_mode);
-
 	hw->an_done = false;
 	if (hw->curbp_link_mode == 10 && !need_restart)
 		return 0;
@@ -2130,14 +2128,18 @@ int txgbe_e56_set_phy_link_mode(struct txgbe_hw *hw,
 		/* backplane 10G/25G/40G */
 		/* 10GKR:7-25KR:14/15-40GKR:8-40GCR:9 */
 		/* default all speed */
-		if ((hw->device_id & 0xFF) == 0x10) {
+		if (speed & TXGBE_LINK_SPEED_10GB_FULL) {
 			backplane_mode |= BIT(7);
 			fec_advertise |= TXGBE_10G_FEC_ABL;
-		} else if ((hw->device_id & 0xFF) == 0x25) {
+		}
+
+		if (speed & TXGBE_LINK_SPEED_25GB_FULL) {
 			backplane_mode |= BIT(14) | BIT(15);
 			fec_advertise |= TXGBE_25G_RS_FEC_REQ |
 					 TXGBE_25G_BASE_FEC_REQ;
-		} else if ((hw->device_id & 0xFF) == 0x40) {
+		}
+
+		if (speed & TXGBE_LINK_SPEED_40GB_FULL) {
 			if (hw->phy.bp_capa == 0)
 				/* original configure: KR4 + CR4 */
 				backplane_mode |= BIT(9) | BIT(8);
@@ -2151,21 +2153,18 @@ int txgbe_e56_set_phy_link_mode(struct txgbe_hw *hw,
 			BP_LOG("Advertised abilities: %d\n", backplane_mode);
 		}
 	} else {
-		if ((hw->phy.fiber_suppport_speed & TXGBE_LINK_SPEED_10GB_FULL)
-		     == TXGBE_LINK_SPEED_10GB_FULL) {
+		if (speed & TXGBE_LINK_SPEED_10GB_FULL) {
 			backplane_mode |= 0x80;
 			fec_advertise |= TXGBE_10G_FEC_ABL;
 		}
 
-		if ((hw->phy.fiber_suppport_speed & TXGBE_LINK_SPEED_25GB_FULL)
-		    == TXGBE_LINK_SPEED_25GB_FULL) {
+		if (speed & TXGBE_LINK_SPEED_25GB_FULL) {
 			backplane_mode |= 0xc000;
 			fec_advertise |= TXGBE_25G_RS_FEC_REQ |
 					 TXGBE_25G_BASE_FEC_REQ;
 		}
 
-		if ((hw->phy.fiber_suppport_speed & TXGBE_LINK_SPEED_40GB_FULL)
-		    == TXGBE_LINK_SPEED_40GB_FULL) {
+		if (speed & TXGBE_LINK_SPEED_40GB_FULL) {
 			backplane_mode |= BIT(9) | BIT(8);
 			fec_advertise |= TXGBE_10G_FEC_ABL;
 		}
diff --git a/drivers/net/txgbe/base/txgbe_e56_bp.h b/drivers/net/txgbe/base/txgbe_e56_bp.h
index d2c49c2fce..8089e5b971 100644
--- a/drivers/net/txgbe/base/txgbe_e56_bp.h
+++ b/drivers/net/txgbe/base/txgbe_e56_bp.h
@@ -277,6 +277,6 @@ typedef union {
 #define E56PHY_CMS_ANA_OVRDVAL_7_ANA_LCPLL_LF_LPF_SETCODE_CALIB_I	8, 4
 
 int txgbe_e56_set_phy_link_mode(struct txgbe_hw *hw,
-				u8 bp_link_mode, u32 need_restart);
+				u32 speed, u32 need_restart);
 int txgbe_handle_e56_bkp_an73_flow(struct txgbe_hw *hw);
 #endif
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index d4c635dc2f..2f59b0794f 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -1864,7 +1864,8 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 	speed = 0x0;
 	if (*link_speeds == RTE_ETH_LINK_SPEED_AUTONEG) {
 		if (hw->mac.type == txgbe_mac_aml40) {
-			speed = TXGBE_LINK_SPEED_40GB_FULL;
+			speed = TXGBE_LINK_SPEED_10GB_FULL |
+				TXGBE_LINK_SPEED_40GB_FULL;
 		} else  if (hw->mac.type == txgbe_mac_aml) {
 			speed = (TXGBE_LINK_SPEED_10GB_FULL |
 				 TXGBE_LINK_SPEED_25GB_FULL);
@@ -1888,6 +1889,20 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 		hw->autoneg = false;
 	}
 
+	/* Record the caller speed before setup_link so that the AN
+	 * restart paths can re-apply the same configuration.
+	 */
+	hw->phy.autoneg_advertised = 0;
+
+	if (speed & TXGBE_LINK_SPEED_40GB_FULL)
+		hw->phy.autoneg_advertised |= TXGBE_LINK_SPEED_40GB_FULL;
+
+	if (speed & TXGBE_LINK_SPEED_25GB_FULL)
+		hw->phy.autoneg_advertised |= TXGBE_LINK_SPEED_25GB_FULL;
+
+	if (speed & TXGBE_LINK_SPEED_10GB_FULL)
+		hw->phy.autoneg_advertised |= TXGBE_LINK_SPEED_10GB_FULL;
+
 	err = hw->mac.setup_link(hw, speed, link_up);
 	if (err)
 		goto error;
@@ -2951,7 +2966,7 @@ void txgbe_dev_e56_check_bp_event(void *param)
 		value &= ~TXGBE_E56_AN_TXDIS;
 		wr32_epcs(hw, VR_AN_INTR, value);
 		rte_spinlock_lock(&hw->phy_lock);
-		txgbe_e56_set_phy_link_mode(hw, 10, hw->bypass_ctle);
+		txgbe_e56_set_phy_link_mode(hw, hw->phy.autoneg_advertised, hw->bypass_ctle);
 		rte_spinlock_unlock(&hw->phy_lock);
 		goto an_status;
 	}
@@ -2966,7 +2981,8 @@ void txgbe_dev_e56_check_bp_event(void *param)
 			if (ret) {
 				BP_LOG("Training FAILED, do reset\n");
 				rte_spinlock_lock(&hw->phy_lock);
-				txgbe_e56_set_phy_link_mode(hw, 10, hw->bypass_ctle);
+				txgbe_e56_set_phy_link_mode(hw, hw->phy.autoneg_advertised,
+							    hw->bypass_ctle);
 				rte_spinlock_unlock(&hw->phy_lock);
 			} else {
 				BP_LOG("ALL SUCCEEDED\n");
@@ -2975,7 +2991,8 @@ void txgbe_dev_e56_check_bp_event(void *param)
 			if (ret) {
 				BP_LOG("Training FAILED, do reset\n");
 				rte_spinlock_lock(&hw->phy_lock);
-				txgbe_e56_set_phy_link_mode(hw, 10, hw->bypass_ctle);
+				txgbe_e56_set_phy_link_mode(hw, hw->phy.autoneg_advertised,
+							    hw->bypass_ctle);
 				rte_spinlock_unlock(&hw->phy_lock);
 			} else {
 				hw->an_done = true;
-- 
2.55.0.windows.2

