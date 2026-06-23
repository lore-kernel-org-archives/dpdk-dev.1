Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD89CD98F2
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 11:38:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8831440650;
	Tue, 23 Jun 2026 13:38:32 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 8C1EF40650
 for <dev@dpdk.org>; Tue, 23 Jun 2026 13:38:30 +0200 (CEST)
X-QQ-mid: zesmtpsz6t1782214704tb8687372
X-QQ-Originating-IP: RWsp60S90r/cZinTpkkTylL++LljAOWBoa5hPTViKpw=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 23 Jun 2026 19:38:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15957487243669422312
EX-QQ-RecipientCnt: 3
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 3/4] net/txgbe: add support for VF sensing PF down
Date: Tue, 23 Jun 2026 19:38:03 +0800
Message-Id: <20260623113805.16464-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260623113805.16464-1-zaiyuwang@trustnetic.com>
References: <20260617105959.10764-1-zaiyuwang@trustnetic.com>
 <20260623113805.16464-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NUDSA6ly0moK1XUVApelC1neuU4SqhhR7FiAIamTrpPvvoLxFNE5DMe4
 R3Fw/KXEet+STC/ggmaBgUAKT0XTLjy7IcP882bcLm4M7Z//k5W7jATgrzJDinK/kTq8LKv
 KaglKdS9ipptckhxmRgNsZLGiS02Q+ED6aikM/tTCyRCuW13YAjKoFyfSUU7rWGllom+U9v
 pUY5qA3r5jobDTPArDVPF8aFn0xO6JZmsNVGPhx0ingFGcai0V24JtNiAU5H/eofELuXb9g
 HLG/MEHY/LEmsyRPcJFGNvvhkYmOFm6ma5Rzul+TexMPAoow53+vhtDoKalbBDasBmMF4o/
 btAAMGw5+FtbU0/QycjQYK6Gi/twenbbbzB10VEEhMwjOeowKdvwSGrJjCRRbiVQ+H4Xz4j
 FIAt13tK1E/3qXeznjNUS4DRK+P4F3oO7uGJM3uyPiYJPnOo2+0xnOQUldsCI28Db9wJ+6D
 GnmdZ4OmmtdE+P/yU/VHmq9OU/FY8mcc7e7MoVZnauvdfrWcUo6HCB2BXBlqSnZ5ExYw+Z5
 sfW4F8hlPAFcn0VuqXo7x/xVxlrKvf/jiGuEreeGXaUJ7J/DfIwIJ0nUAbwQFeOn7YU/z+e
 dhzRiHq2M9IuBBsuTduJyLNe90ZVPNRQLFsJ5Tf2p41bseh2NMDVKEtg8yC+svl8Hxci8oe
 BqRNPBvspDL5vEWpw2yWgdO7W0A8Edm0HxQiQYF/2RPpynEq98o9X0hx4aPaPx1LfYgSt4i
 zZezzWplIrQQIMvwRRAfmfJsjh1KvxF2YA6aJ7QWqt7TNU28SsGG6eMFbGTffMdxNJWT/KO
 /hLu5pWNpKuA4b0BJYSTDGOnYFX8xE993byGVJEf8t+LhjnqvCbMK6u2+SwyVD3kJhz6DUQ
 Y3wJ6QnXzSCcPZUH1qKJWvC+6x3i4lrY8ByPPqc7+hahTsJuuZIcoCmE3nMVNDAHNuQbaJP
 WgukSlV/pe0dcUrUaRZLSXT4R4HbN5bbLD6+cDNK5mtg3/cu1RB1kDIOCw7NkZn8z/OMBGe
 r/DgJ78OIMnDaxD+ZfdY5DJLnjhW2wGR38NUedx/gEtDbuiT61M0Vp+QZlILnk0L5SdKwAT
 DjYUIN34ob7JX9+ZP/CMyl5kA6UjS1j908CQnydaWzbUEpCvDh6HmY=
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

VFs should continue normal packet Rx/Tx after PF ifconfig down/up.

To achieve this, cooperate with mailbox commands added in our Linux
kernel driver txgbe-2.2.0. When mailbox messages lack the
TXGBE_VT_MSGTYPE_CTS flag, the PF is considered down. In this state,
the VF reports link down and stops transmitting. Upon detecting the
loss of CTS, the VF sends a reset request to the PF. If the request
succeeds (indicating PF recovery), the VF triggers an
RTE_ETH_EVENT_INTR_RESET event to notify the application or users to
reset the VF.

Additionally, hw->rx_loaded and hw->offset_loaded must be reset when
PF ifconfig down; otherwise, because hardware counter registers are
cleared during PF reset, the VF's software counters will overflow to
0xFFFFFFFF.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_type.h |  1 +
 drivers/net/txgbe/txgbe_ethdev.c    |  3 +-
 drivers/net/txgbe/txgbe_ethdev_vf.c | 60 +++++++++++++++++++++++++----
 3 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index ede780321f..956080c702 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -883,6 +883,7 @@ struct txgbe_hw {
 	rte_atomic32_t swfw_busy;
 	u32 fec_mode;
 	u32 cur_fec_link;
+	bool pf_running;
 };
 
 struct txgbe_backplane_ability {
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 0f484dfe91..003a24141c 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -3150,7 +3150,8 @@ txgbe_dev_link_update_share(struct rte_eth_dev *dev,
 
 	hw->mac.get_link_status = true;
 
-	if (intr->flags & TXGBE_FLAG_NEED_LINK_CONFIG)
+	if (intr->flags & TXGBE_FLAG_NEED_LINK_CONFIG ||
+	    (txgbe_is_vf(hw) && !hw->pf_running))
 		return rte_eth_linkstatus_set(dev, &link);
 
 	/* check if it needs to wait to complete, if lsc interrupt is enabled */
diff --git a/drivers/net/txgbe/txgbe_ethdev_vf.c b/drivers/net/txgbe/txgbe_ethdev_vf.c
index 7a50c7a855..e3832c0173 100644
--- a/drivers/net/txgbe/txgbe_ethdev_vf.c
+++ b/drivers/net/txgbe/txgbe_ethdev_vf.c
@@ -281,6 +281,7 @@ eth_txgbevf_dev_init(struct rte_eth_dev *eth_dev)
 	hw->subsystem_device_id = pci_dev->id.subsystem_device_id;
 	hw->subsystem_vendor_id = pci_dev->id.subsystem_vendor_id;
 	hw->hw_addr = (void *)pci_dev->mem_resource[0].addr;
+	hw->pf_running = true;
 
 	/* initialize the vfta */
 	memset(shadow_vfta, 0, sizeof(*shadow_vfta));
@@ -1405,10 +1406,20 @@ static s32 txgbevf_get_pf_link_status(struct rte_eth_dev *dev)
 	if (retval)
 		return 0;
 
+	if (!(msgbuf[0] & TXGBE_NOFITY_VF_LINK_STATUS))
+		return 0;
+
 	rte_eth_linkstatus_get(dev, &link);
 
+	if (!hw->pf_running) {
+		link.link_status =  RTE_ETH_LINK_DOWN;
+		link.link_speed = RTE_ETH_SPEED_NUM_NONE;
+		link.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
+		return rte_eth_linkstatus_set(dev, &link);
+	}
+
 	link_up = msgbuf[1] & TXGBE_VFSTATUS_UP;
-	link_speed = (msgbuf[1] & 0xFFF0) >> 1;
+	link_speed = (msgbuf[1] & 0x1FFFFE) >> 1;
 
 	if (link_up == link.link_status && link_speed == link.link_speed)
 		return 0;
@@ -1434,10 +1445,22 @@ static s32 txgbevf_get_pf_link_status(struct rte_eth_dev *dev)
 static void txgbevf_check_link_for_intr(struct rte_eth_dev *dev)
 {
 	struct rte_eth_link orig_link, new_link;
+	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 
 	rte_eth_linkstatus_get(dev, &orig_link);
-	txgbevf_dev_link_update(dev, 0);
-	rte_eth_linkstatus_get(dev, &new_link);
+
+	if (hw->pf_running) {
+		txgbevf_dev_link_update(dev, 0);
+		rte_eth_linkstatus_get(dev, &new_link);
+	} else {
+		DEBUGOUT("PF ifconfig down, so VF link down");
+		new_link.link_status = RTE_ETH_LINK_DOWN;
+		new_link.link_speed = RTE_ETH_SPEED_NUM_NONE;
+		new_link.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
+		new_link.link_autoneg = !(dev->data->dev_conf.link_speeds &
+					  RTE_ETH_LINK_SPEED_FIXED);
+		rte_eth_linkstatus_set(dev, &new_link);
+	}
 
 	PMD_DRV_LOG(INFO, "orig_link: %d, new_link: %d",
 		    orig_link.link_status, new_link.link_status);
@@ -1450,6 +1473,8 @@ static void txgbevf_check_link_for_intr(struct rte_eth_dev *dev)
 static void txgbevf_mbx_process(struct rte_eth_dev *dev)
 {
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
+	struct txgbe_mbx_info *mbx = &hw->mbx;
+	u32 msgbuf = 0;
 	u32 in_msg = 0;
 
 	/* peek the message first */
@@ -1457,14 +1482,33 @@ static void txgbevf_mbx_process(struct rte_eth_dev *dev)
 
 	/* PF reset VF event */
 	if (in_msg & TXGBE_PF_CONTROL_MSG) {
-		if (in_msg & TXGBE_NOFITY_VF_LINK_STATUS) {
+		/* msg is not CTS, we need to do reset */
+		if (!(in_msg & TXGBE_VT_MSGTYPE_CTS)) {
+			/* send reset to PF to reconfig CTS flag */
+			int err = 0;
+
+			msgbuf = TXGBE_VF_RESET;
+			err = mbx->write_posted(hw, &msgbuf, 1, 0);
+			if (err) {
+				hw->pf_running = false;
+				txgbevf_check_link_for_intr(dev);
+			} else {
+				hw->pf_running = true;
+				rte_eth_dev_callback_process(dev, RTE_ETH_EVENT_INTR_RESET,
+							     NULL);
+			}
+		}
+
+		if (in_msg & TXGBE_NOFITY_VF_LINK_STATUS)
 			txgbevf_get_pf_link_status(dev);
-		} else {
-			/* dummy mbx read to ack pf */
-			txgbe_read_mbx(hw, &in_msg, 1, 0);
+		else
 			/* check link status if pf ping vf */
 			txgbevf_check_link_for_intr(dev);
-		}
+	}
+
+	if (!hw->pf_running) {
+		hw->rx_loaded = true;
+		hw->offset_loaded = true;
 	}
 }
 
-- 
2.21.0.windows.1


