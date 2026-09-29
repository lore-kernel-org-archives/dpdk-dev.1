Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD6FCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 11:22:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C3D942793;
	Tue, 29 Sep 2026 13:21:57 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 547E542798;
 Tue, 29 Sep 2026 13:21:50 +0200 (CEST)
X-QQ-mid: zesmtpgz6t1790680895te25b4b1e
X-QQ-Originating-IP: hfKJMa4zFwe/0l4mMMkaYbkYnreGW9NmImsovPiiYPM=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.38])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 29 Sep 2026 19:21:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14913709281852411342
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v5 02/15] net/txgbe: use the requested speed in E56 AN setup
Date: Tue, 29 Sep 2026 19:18:02 +0800
Message-ID: <CB1B9B43243183C9+20260929112119.4516-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260929112119.4516-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260929112119.4516-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NHGFjaVOIMm2Z+0bTwahR5HA6HRTfoI5ULCZ1zNua/OPUW7tfyfCbKK8
 F+4RdOPe75aRQAtVj7v2DIGPeGhLsNymRs1//qOWYYwdv0p98AIXqd6zO3M+8w/YVJ0ZSyf
 2Jj3wk/+5UoC35n2wbUNhliRrDI+aihvoYqPxD8TpoQhjbI2o92CS6R8P1JeZwgXFhGpXoy
 olv79fJ1SvU5WiKjUMfPjS9ZIPTDLz2BOLXRvcekJ7EtkepLzv9DGWCoxesUDL2VFuQHbEb
 i1VQIcSRPpDqDUYZFJXwyZR11Apb4UFexjdSudyrN4kjWBtAEcDqxG4TXqT3HWdKQqa5PzC
 K19ngGrDcNWmhPJI3/cP2TsOo6//xye973vVy+LFggeK+4D6Rnc4V8oJwtQAOyXiMcBYBba
 m3nSZDfSYsj9M3fSOGDzG3l2Mpl6cFfSvR9MwAlkoIrLQVYo1Yx53xeRdtVLbPq3ct3MHYE
 wVi1k0x37cGNxPEsh5akaSfjoys79bq5QWLbhvqjelnAASFaoX4TGCFQXe70njD/rbELVIi
 PpjmuI87+NIbf8sogl+OwjJhyH28xoN+6eLDkKoRivyN23MGyLc6OVJN4w2ASqjlweSSCmg
 9USmZc1epprYMpi3jfmrqktcK2tqf3ZfkFXFmQxkpI+rGOsbuoivF/JtM4Csb9bR3W2VpfK
 MR8z+++daQbwBG8UHEZzkDwqCcqCbWRf/e1BG+oGlyUALecWYb4XUUKeb7Em61XBwopoUXN
 uV5la2/pbSeWS8+O19Ib0vkZPz9vYA11JR+H6K43j3bv04b8iJ5seTVr82kyMEhtwdfK1ti
 e9FWdazQzI+Pf+IBuOzIQVyXbZfYNBi5dmFvglSPYEXUWQwgV4g3I4kvm7fmwpNQPUdTF6V
 0RmzC06sknIT5fq/I1p9oRKbRKwi+xFT27dNaUf2YAvfQzIaN+oFHRvoP+ODiiylNp/pJYX
 MjdD5xlMjKCQjX8kvn0krhVbUMQayJ7Mb3Oow0ghoG6TgjkFuz+94a3Mef2tfN8lPkSX8NC
 AlEacqJh1M5Zbh9z0YcJ2WwV73Tu9x0DedKp2k8mhHzNSqul2pTJ2V6uJry2ObwyCpL1U59
 g==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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
index bc2e11e801..ae15c0f440 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -1912,7 +1912,8 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 	speed = 0x0;
 	if (*link_speeds == RTE_ETH_LINK_SPEED_AUTONEG) {
 		if (hw->mac.type == txgbe_mac_aml40) {
-			speed = TXGBE_LINK_SPEED_40GB_FULL;
+			speed = TXGBE_LINK_SPEED_10GB_FULL |
+				TXGBE_LINK_SPEED_40GB_FULL;
 		} else  if (hw->mac.type == txgbe_mac_aml) {
 			speed = (TXGBE_LINK_SPEED_10GB_FULL |
 				 TXGBE_LINK_SPEED_25GB_FULL);
@@ -1936,6 +1937,20 @@ txgbe_dev_start(struct rte_eth_dev *dev)
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
@@ -3017,7 +3032,7 @@ void txgbe_dev_e56_check_bp_event(void *param)
 		value &= ~TXGBE_E56_AN_TXDIS;
 		wr32_epcs(hw, VR_AN_INTR, value);
 		rte_spinlock_lock(&hw->phy_lock);
-		txgbe_e56_set_phy_link_mode(hw, 10, hw->bypass_ctle);
+		txgbe_e56_set_phy_link_mode(hw, hw->phy.autoneg_advertised, hw->bypass_ctle);
 		rte_spinlock_unlock(&hw->phy_lock);
 		goto an_status;
 	}
@@ -3032,7 +3047,8 @@ void txgbe_dev_e56_check_bp_event(void *param)
 			if (ret) {
 				BP_LOG("Training FAILED, do reset\n");
 				rte_spinlock_lock(&hw->phy_lock);
-				txgbe_e56_set_phy_link_mode(hw, 10, hw->bypass_ctle);
+				txgbe_e56_set_phy_link_mode(hw, hw->phy.autoneg_advertised,
+							    hw->bypass_ctle);
 				rte_spinlock_unlock(&hw->phy_lock);
 			} else {
 				BP_LOG("ALL SUCCEEDED\n");
@@ -3041,7 +3057,8 @@ void txgbe_dev_e56_check_bp_event(void *param)
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

