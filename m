Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E014EC98306
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 12:54:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F02B42D0B;
	Tue, 22 Sep 2026 14:54:35 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id 59E8242D6A;
 Tue, 22 Sep 2026 14:54:30 +0200 (CEST)
X-QQ-mid: esmtpsz17t1790081666tdd7293a8
X-QQ-Originating-IP: wAZRmJL4Gn8to4Z+FCdUxuE6fEj0I2Q4RYHnSx/TkMk=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.132])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 22 Sep 2026 20:54:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17371979151336315613
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v4 02/16] net/txgbe: use the requested speed in E56 AN setup
Date: Tue, 22 Sep 2026 20:37:35 +0800
Message-ID: <92EED0631176B41C+20260922125414.3638-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260922125414.3638-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260922125414.3638-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N8qSFIyXZu+y62NtLDl1FNlUkNwdAkQlbyjkczJzmittkVxjoNTyAPTf
 AKmEJ9GsRLeilZguq3DjSry7P4Ra94GVvlsZbnXixG7V8SUb5L4Ukf1TAU7jx2REXy2iD0k
 jS9/FOeBv/as1lxPcEWeDSqR4UsNPrCkl3p8WBdLUgFOt0AANzjyaqkbW5PVV25MTi9o2e0
 GX4+sdzefrb9SPDXesBMEH9P5megW3Q+d26pBEFNPou7e8cgqrkI44tKJ4t7k7BXzvBQMWv
 k4yDUxM9PTw2z2/O7qIZUgTtR6W3fQgHD4i5t4V+FhuILyK9QM7hpkv6d9N9JZMRHDvtyov
 30ok4qr8qBKVKd/rZlyFUY7J+0hafzjLxqAmg7ShPVmwwD/fouEdfqbaeIRifDd3W8JHm6e
 720IsU5p3TjksYRn03dHM61lUcavHCUGnKQ5qILDGNuOCCTA3rSKF737bQibzA+Uh0E4vhQ
 +IVcznbvQxr6zS7NXqpt97XTrgFC9bwgxwP+WDnhCTcenf7HRqSnPe3eMqDErs/r8ZhbW4v
 wfobyUd7XfC38kQNGHD/9yEiILfn0dPz26zsC2JRiOf5OFswNIPQlSz58DG+3X4G0CH3uAQ
 DRIR7gNGi1eyk5RY8zMOzWiD2QQ4KoYpH7wnjAXqXqB6zRLIEO6zy3i+wUEaLGdnHPs/+bj
 v3HrYHnSX0UnX29t4icTH9BsCEqrJ9gcSBFJaQku55EuQNaAf71270dmyxlVymtP7JAVUzh
 w2FfJ5E0zC/mmf0uzccbbY2dyK3faTdP+8QVGu5jxnmkYxYkDV3mqU8kUzBUtv7AlVJocOI
 1Z+AlmJApOxXf6hNHTD3AXs+9K1PA/WtKI7tZI0KZs0TqHXL6i/llnOI4/hpYCM1N2nz+vc
 pz1PZHU/XnvXu1NHRH/mrgKyRXbEd2/4WsQyBWpi5Xm6ipao/EHl1Atkusq65JVUMHOe8D/
 PYE0H3QAyGIO/inWSO19Q1sgyQbCNPvFDNOY3FLiwFpOdH2yl+HBSpNARcDUwvxMMC3wfhh
 HGUTpH1+cTPlauTZ10oYF/1rlc3LWI2HidSu4rvs0rJUdWGZaFNYZDTUYn50jKGPSV1YtAG
 Q==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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
out-of-tree driver does: gate the 10G and 25G advertisement on
speed, keep the 40G case on the device id, and use speed rather than
hw->phy.fiber_suppport_speed on the fiber/DAC path.

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
 drivers/net/txgbe/txgbe_ethdev.c      | 22 +++++++++++++++++++---
 4 files changed, 32 insertions(+), 17 deletions(-)

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
index d376d918df..7b8af0638d 100644
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
+		if ((hw->device_id & 0xFF) == 0x40) {
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
index bc2e11e801..69c94992ae 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -1936,6 +1936,20 @@ txgbe_dev_start(struct rte_eth_dev *dev)
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
@@ -3017,7 +3031,7 @@ void txgbe_dev_e56_check_bp_event(void *param)
 		value &= ~TXGBE_E56_AN_TXDIS;
 		wr32_epcs(hw, VR_AN_INTR, value);
 		rte_spinlock_lock(&hw->phy_lock);
-		txgbe_e56_set_phy_link_mode(hw, 10, hw->bypass_ctle);
+		txgbe_e56_set_phy_link_mode(hw, hw->phy.autoneg_advertised, hw->bypass_ctle);
 		rte_spinlock_unlock(&hw->phy_lock);
 		goto an_status;
 	}
@@ -3032,7 +3046,8 @@ void txgbe_dev_e56_check_bp_event(void *param)
 			if (ret) {
 				BP_LOG("Training FAILED, do reset\n");
 				rte_spinlock_lock(&hw->phy_lock);
-				txgbe_e56_set_phy_link_mode(hw, 10, hw->bypass_ctle);
+				txgbe_e56_set_phy_link_mode(hw, hw->phy.autoneg_advertised,
+							    hw->bypass_ctle);
 				rte_spinlock_unlock(&hw->phy_lock);
 			} else {
 				BP_LOG("ALL SUCCEEDED\n");
@@ -3041,7 +3056,8 @@ void txgbe_dev_e56_check_bp_event(void *param)
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

