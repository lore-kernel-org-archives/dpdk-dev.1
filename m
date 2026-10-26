Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B34606A31B
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 12:27:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10C8440678;
	Mon, 26 Oct 2026 13:26:59 +0100 (CET)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTPS id 6988B402A3;
 Mon, 26 Oct 2026 13:26:54 +0100 (CET)
X-QQ-mid: esmtpgz15t1793017609t2948af93
X-QQ-Originating-IP: LIKBtwrbChog0Y9oEH4cpoQ2XxNC1Sbz3iupqMcVDJU=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.25])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 26 Oct 2026 20:26:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6740221647251368820
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v11 02/17] net/txgbe: use the requested speed in E56 AN setup
Date: Mon, 26 Oct 2026 20:21:48 +0800
Message-ID: <616572B3B922FB61+20261026122638.9198-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261026122638.9198-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261026122638.9198-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OTgEduJtQQndZ62RdJGTird5ZgAs5RFNE4vDFFjftATjwjpnGygcG7xR
 HqKvFr8VoyMeTvWKnGSW1YEzqQqHyO7a//gc4ffYM9vT4IYXYn7y3Zjbr7zPRmeVIcUX5jn
 3WuIdyW68+JCaNoZPgQzDKm0em+T/2vJLX7YmxdFhyeBr1zxUtdGB7UBz3aPumeM90ThSUX
 zgw92oiMhSs0ts1vcFci8a31qtStN3tw+SyU0dKkGIsvsgTwNZ4/dxMYSLeVLgpFWgRohVc
 wr62SozN3Kln6FUKYEJw0EFFqPd/SPjjxpa+F7sPOzixjcXFgJDMnvkVa2/lDWsPB9fPQVm
 bgMYJVDzHy/H5PVLaT1PYG2QiC3GK+pSVRSV9cuQxzfaUOv+eP42fChG055uQsQgGKFiNNj
 yfOElON0jWxozbDTsdHo/E4FaCfpeUWHH5xBGJdfJP55ZLO22T2ecZVRy2X6Fq6GGMyUVMI
 h+MjRAf0M822xvvSfda94CyiTvuLYfyiUtN1NGfcV/di30748flH9mq7614fJ4mHZvLnP93
 5u4Pf5Ew+ZjMRWTI9JtZ2fRAUiM8pxK8kxr/MImviAyI2cCKq+duJzYOaLwL/hl3NN2WCoz
 tlA8o4ofL++15NSLB5dQwUwVVhfNI5KyZWS4XrV0AeKUlXifAVTlQ6zzYa0WI2bvuYUeugK
 diKhcfn/HvNgDkwzhGJJT89LJwIPaSHTOXHtSocK1zuzJNYDyR4tVd/eBqKzeylDjYXQ04W
 TuK9M4w4Joj+OfJRNzLOkv6onL/+wsCS+X671AOoq8PZtG9zI70UktbACAqZbDvKTLEn7pc
 Xa30Qgzhlu4ZrspYmX291i3X5Qy38YRxKazR6ouE7yC2EhPBJNK1LL3mXsvYtXlp0XP1exQ
 Z5MM/JKkY2jG867hrViMax2eX9S6SmDM1AuKTMLAiMT1HAuShI/cI1Cokoy9phrG3lzWQCE
 LgtuDMCLL/zwrQvboMAfVVsprKCB51yzIDWjGGUL23VTVyBTBkv9bWUJA5Ky5s3IzJzf61w
 wd9BnYwgXVO63ueOi+ZJLkzasxPpohyV9muemHilLu9Q6533lE/ejDWcpeGnX/gcYHfcWWd
 Q==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

txgbe_e56_set_phy_link_mode() takes the speeds to advertise, but the
port does not use the argument: it is passed to
UNREFERENCED_PARAMETER(), and the AN base page is built from the
device id and from hw->phy.fiber_suppport_speed instead. The caller
therefore cannot narrow what is advertised, which is what kept a
10G request from reaching the base page on a 10G/40G part even
after the capability mask had been opened up.

Take the argument as a speed bitmask, gate the 10G, 25G, and 40G
advertisement on the requested speed and use speed rather than
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
and pass it from the watchdog and training-restart paths instead of
the hardcoded 10. The two readers of that field keep their existing
fallback to get_link_capabilities() when it is zero.

Fixes: 234ce0d1fa9d ("net/txgbe: fix link stability for Amber-Lite backplane mode")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml40.c  |  2 +-
 drivers/net/txgbe/base/txgbe_e56_bp.c | 23 +++++++++++------------
 drivers/net/txgbe/base/txgbe_e56_bp.h |  2 +-
 drivers/net/txgbe/txgbe_ethdev.c      | 16 ++++++++++++----
 4 files changed, 25 insertions(+), 18 deletions(-)

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
index d4c635dc2f..f20e57125d 100644
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
@@ -1888,6 +1889,11 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 		hw->autoneg = false;
 	}
 
+	/* Record the caller speed first: the AN restart paths re-apply it. */
+	hw->phy.autoneg_advertised = speed & (TXGBE_LINK_SPEED_10GB_FULL |
+					      TXGBE_LINK_SPEED_25GB_FULL |
+					      TXGBE_LINK_SPEED_40GB_FULL);
+
 	err = hw->mac.setup_link(hw, speed, link_up);
 	if (err)
 		goto error;
@@ -2951,7 +2957,7 @@ void txgbe_dev_e56_check_bp_event(void *param)
 		value &= ~TXGBE_E56_AN_TXDIS;
 		wr32_epcs(hw, VR_AN_INTR, value);
 		rte_spinlock_lock(&hw->phy_lock);
-		txgbe_e56_set_phy_link_mode(hw, 10, hw->bypass_ctle);
+		txgbe_e56_set_phy_link_mode(hw, hw->phy.autoneg_advertised, hw->bypass_ctle);
 		rte_spinlock_unlock(&hw->phy_lock);
 		goto an_status;
 	}
@@ -2966,7 +2972,8 @@ void txgbe_dev_e56_check_bp_event(void *param)
 			if (ret) {
 				BP_LOG("Training FAILED, do reset\n");
 				rte_spinlock_lock(&hw->phy_lock);
-				txgbe_e56_set_phy_link_mode(hw, 10, hw->bypass_ctle);
+				txgbe_e56_set_phy_link_mode(hw, hw->phy.autoneg_advertised,
+							    hw->bypass_ctle);
 				rte_spinlock_unlock(&hw->phy_lock);
 			} else {
 				BP_LOG("ALL SUCCEEDED\n");
@@ -2975,7 +2982,8 @@ void txgbe_dev_e56_check_bp_event(void *param)
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

