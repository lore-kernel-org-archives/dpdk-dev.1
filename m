Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE75C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 11:16:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D775C402BE;
	Tue, 30 Jun 2026 13:16:43 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id 0243040656
 for <dev@dpdk.org>; Tue, 30 Jun 2026 13:16:41 +0200 (CEST)
X-QQ-mid: zesmtpsz7t1782818196t169ee779
X-QQ-Originating-IP: 5Rep8ML3mT4UJYyIq2DHmhUKEal7SVFHyBHy4TOwYjQ=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.190.76])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 30 Jun 2026 19:16:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 733439883965234003
EX-QQ-RecipientCnt: 3
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v4 3/4] net/txgbe: add support for VF sensing PF down
Date: Tue, 30 Jun 2026 19:16:03 +0800
Message-Id: <20260630111608.22196-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260630111608.22196-1-zaiyuwang@trustnetic.com>
References: <20260617105959.10764-1-zaiyuwang@trustnetic.om>
 <20260630111608.22196-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: ODmRr9XAsEUIAY+lmuKAMqqwKW4UjBizqb8xYg94wBqcgcfmv8ygvvwH
 fq9KzQlHmPqPxaMwX059NWhuphEVFeHwN+S768/p395P8aQSkXjxupCgA5gwgKlC05rekTd
 X9dMIHc7rsMwnGPupxicoMdjzKeFg1k6pYawo1Sc2NBanbHZnuHjMZYH7IEoFns5P1yjJlC
 MWE/gZRTTnZ7wGvB5tbhvP+HAS2oCkNr6MLbQ9uOhYMhVelqemXA8FUCXSKClsYkridaD+n
 uZNgKjja5oXSI/SiWXHh8fX1i2fIZwosbEpSVp5kNQo4v7WnQBWtVmoRq6DDmQYJNv7s50H
 3IRoRkn8pmCJ/7z2ZIetXbCK5BIKKcpvduwo32Ssl9nx+oK2gj6BgoUjz/vfzyVMsiu4LeO
 EGaU6F6WAB39ArqeqfutfDFkQrrN8OZpxC8WmOi0JNhI0Q8B2iLorCCDgoIxofJXWyG/j+X
 c0DmVH5GcFRoEenUd7PRPNr4S08VKL6ZkrgqgICFqqDobsyCpJwJugbHxPKKPGkSWOiY84p
 y565L9IrDDkICDwhg2KJV/Hgc8PHGRC3P2uJgl1nmr/JyLUukerQu1kC4S9G8r214YNPnhd
 YJcCh2BKKXc4z8rajaUZ6UNMtO41pVvbP4AS1qsKqM7S5Qs6le+3xYziHe6BYx0/iYFiVzp
 t4PebNlXbl5leeTPD7cpR+irh4TAF/mMlNS1XnntDib9AIc1oafA9Te5cV3p31ZSlOTp057
 tyhksMNOxePkx3MRZgHFJbcW1Rc350mE2Y91F0pJfL7gv/CZNhzlf2KIW8OuFiWN4E3l6u5
 P+8JwjAU3nXN8E1Fu5AKrpMnSsTVKh0NOx8LCuv47t9vbXU27y0JS8bK7/verQKlH7SIj2U
 AILtHmU5QTuXCgmhXllN899BjGwNsbGWMHmJh87JeAVWBpY3IeByGdhZeesdxVAxOh+nFvy
 aG0UDamquHu6TpMiCzUhC1ljp6cQgcvkdNZcbJY483BnYgs2bXIS/uZwZHj50mBH4uSUwIb
 qWLiwcDqnRc60nmpqVyVwZetHvRoUWwZ1ZX8g+dDc3mPATEHIahfWMyzYOV1sD/nB4zajaX
 w==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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

When mailbox messages lack the TXGBE_VT_MSGTYPE_CTS flag, the PF is
considered down. In this state, the VF reports link down and stops
transmitting. Upon detecting the loss of CTS, the VF sends a reset
request to the PF. If the request succeeds (indicating PF recovery),
the VF triggers an RTE_ETH_EVENT_INTR_RESET event to notify the
application or users to reset the VF.

The write_posted() based VF_RESET request is the only recovery path:
the PF only marks this VF as ready (and starts sending CTS) after it
processes VF_RESET, so this request is required for the VF to recover.
write_posted() may busy-wait for the ACK in the interrupt thread, but
the PF does not send further mailbox messages once it is down, so this
blocking is not continuously triggered.

Additionally, hw->rx_loaded and hw->offset_loaded must be reset when
PF ifconfig down; otherwise, because hardware counter registers are
cleared during PF reset, the VF's software counters will overflow to
0xFFFFFFFF.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 doc/guides/rel_notes/release_26_07.rst |  5 ++
 drivers/net/txgbe/base/txgbe_type.h    |  1 +
 drivers/net/txgbe/txgbe_ethdev.c       |  4 +-
 drivers/net/txgbe/txgbe_ethdev_vf.c    | 86 ++++++++++++++++++++++----
 4 files changed, 83 insertions(+), 13 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 06cd52b777..46935ba872 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -190,6 +190,11 @@ New Features
     The ``RTE_ETH_TX_OFFLOAD_UDP_TSO`` capability was advertised since the
     driver's initial integration but the data path was missing; it is now
     functional.
+  * Added support for VF sensing PF down. VFs now detect when the PF goes
+    down (via the mailbox ``TXGBE_VT_MSGTYPE_CTS`` flag) and report link
+    down. When the PF comes back, the VF triggers an
+    ``RTE_ETH_EVENT_INTR_RESET`` event so the application can reset the VF
+    and resume normal packet Rx/Tx.
 
 
 Removed Items
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index ede780321f..c73a9ebcb4 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -883,6 +883,7 @@ struct txgbe_hw {
 	rte_atomic32_t swfw_busy;
 	u32 fec_mode;
 	u32 cur_fec_link;
+	RTE_ATOMIC(bool) pf_running;
 };
 
 struct txgbe_backplane_ability {
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 0f484dfe91..c99734cced 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -3150,7 +3150,9 @@ txgbe_dev_link_update_share(struct rte_eth_dev *dev,
 
 	hw->mac.get_link_status = true;
 
-	if (intr->flags & TXGBE_FLAG_NEED_LINK_CONFIG)
+	if (intr->flags & TXGBE_FLAG_NEED_LINK_CONFIG ||
+	    (txgbe_is_vf(hw) && !rte_atomic_load_explicit(&hw->pf_running,
+						rte_memory_order_acquire)))
 		return rte_eth_linkstatus_set(dev, &link);
 
 	/* check if it needs to wait to complete, if lsc interrupt is enabled */
diff --git a/drivers/net/txgbe/txgbe_ethdev_vf.c b/drivers/net/txgbe/txgbe_ethdev_vf.c
index 7a50c7a855..c57ac57141 100644
--- a/drivers/net/txgbe/txgbe_ethdev_vf.c
+++ b/drivers/net/txgbe/txgbe_ethdev_vf.c
@@ -281,6 +281,8 @@ eth_txgbevf_dev_init(struct rte_eth_dev *eth_dev)
 	hw->subsystem_device_id = pci_dev->id.subsystem_device_id;
 	hw->subsystem_vendor_id = pci_dev->id.subsystem_vendor_id;
 	hw->hw_addr = (void *)pci_dev->mem_resource[0].addr;
+	rte_atomic_store_explicit(&hw->pf_running, true,
+				  rte_memory_order_release);
 
 	/* initialize the vfta */
 	memset(shadow_vfta, 0, sizeof(*shadow_vfta));
@@ -1405,10 +1407,21 @@ static s32 txgbevf_get_pf_link_status(struct rte_eth_dev *dev)
 	if (retval)
 		return 0;
 
+	if (!(msgbuf[0] & TXGBE_NOFITY_VF_LINK_STATUS))
+		return 0;
+
 	rte_eth_linkstatus_get(dev, &link);
 
+	if (!rte_atomic_load_explicit(&hw->pf_running,
+				      rte_memory_order_acquire)) {
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
@@ -1434,10 +1447,23 @@ static s32 txgbevf_get_pf_link_status(struct rte_eth_dev *dev)
 static void txgbevf_check_link_for_intr(struct rte_eth_dev *dev)
 {
 	struct rte_eth_link orig_link, new_link;
+	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 
 	rte_eth_linkstatus_get(dev, &orig_link);
-	txgbevf_dev_link_update(dev, 0);
-	rte_eth_linkstatus_get(dev, &new_link);
+
+	if (rte_atomic_load_explicit(&hw->pf_running,
+				     rte_memory_order_acquire)) {
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
@@ -1450,22 +1476,58 @@ static void txgbevf_check_link_for_intr(struct rte_eth_dev *dev)
 static void txgbevf_mbx_process(struct rte_eth_dev *dev)
 {
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
+	struct txgbe_mbx_info *mbx = &hw->mbx;
+	u32 msgbuf = 0;
 	u32 in_msg = 0;
 
-	/* peek the message first */
+	/* Peek the message first */
 	in_msg = rd32(hw, TXGBE_VFMBX);
 
-	/* PF reset VF event */
-	if (in_msg & TXGBE_PF_CONTROL_MSG) {
-		if (in_msg & TXGBE_NOFITY_VF_LINK_STATUS) {
-			txgbevf_get_pf_link_status(dev);
-		} else {
-			/* dummy mbx read to ack pf */
-			txgbe_read_mbx(hw, &in_msg, 1, 0);
-			/* check link status if pf ping vf */
+	/* PF control message */
+	if (!(in_msg & TXGBE_PF_CONTROL_MSG))
+		return;
+
+	txgbevf_get_pf_link_status(dev);
+
+	if (!(in_msg & TXGBE_VT_MSGTYPE_CTS)) {
+		/*
+		 * PF is not ready for this VF (e.g. PF ifconfig down).
+		 *
+		 * Send VF_RESET to ask the PF to reconfigure us. The PF only
+		 * marks this VF as ready (and starts sending CTS) after it
+		 * processes VF_RESET, so this request is the only way to
+		 * recover. If write_posted() succeeds the PF is back up and
+		 * we notify the application to reset the VF; otherwise the PF
+		 * is still down, so we mark it down and reset the stats
+		 * baselines (hardware counters are cleared during PF reset).
+		 *
+		 * write_posted() may busy-wait for the ACK in the interrupt
+		 * thread, but the PF does not send further mailbox messages
+		 * once it is down, so this blocking is not continuously
+		 * triggered.
+		 */
+		int err;
+
+		msgbuf = TXGBE_VF_RESET;
+		err = mbx->write_posted(hw, &msgbuf, 1, 0);
+		if (err) {
+			rte_atomic_store_explicit(&hw->pf_running, false,
+						  rte_memory_order_release);
 			txgbevf_check_link_for_intr(dev);
+			hw->rx_loaded = true;
+			hw->offset_loaded = true;
+		} else {
+			rte_atomic_store_explicit(&hw->pf_running, true,
+						  rte_memory_order_release);
+			rte_eth_dev_callback_process(dev,
+					RTE_ETH_EVENT_INTR_RESET, NULL);
 		}
+		return;
 	}
+
+	/* Check link status if pf only ping vf */
+	if (!(in_msg & TXGBE_NOFITY_VF_LINK_STATUS))
+		txgbevf_check_link_for_intr(dev);
 }
 
 static int
-- 
2.21.0.windows.1

