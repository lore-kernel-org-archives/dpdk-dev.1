Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40205CD98F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 11:34:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48CC340289;
	Wed, 17 Jun 2026 13:33:51 +0200 (CEST)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id 7EE6C40696
 for <dev@dpdk.org>; Wed, 17 Jun 2026 13:33:49 +0200 (CEST)
X-QQ-mid: esmtpsz20t1781696025t360a80fb
X-QQ-Originating-IP: X/MBvC9cK3n398c6fmLDy7/+FP0rvZVeTrtmvhO9aRM=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 19:33:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7499956721412781341
EX-QQ-RecipientCnt: 3
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 3/4] net/txgbe: add support for VF sensing PF down
Date: Wed, 17 Jun 2026 19:33:33 +0800
Message-Id: <20260617113335.15648-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617113335.15648-1-zaiyuwang@trustnetic.com>
References: <20260617105959.10764-1-zaiyuwang@trustnetic.com>
 <20260617113335.15648-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MiGG3bUCB3cLY/AygFUCeIEfYJ22p4oGNXBUELls33A+gJfRxY3yyqqw
 OiwMbaZqdCdxbRT4hEKXx3BMzjguv9525ANWB78xJJyMxzbwGgU2QHq3dSHOZaaA96afudM
 sCXEIGLh0JiWgPx4gXYM1Zr39KMBf96bJangOX8oG630fkf4F2mwssFmsIJz7/yAFi36l2k
 7AtiDXVlCDc08E7NoTPyBjvB4iBPsR8q1pJSn/bDYdVo8hYWHYnOwB9DBJ44ugs62IPSDVM
 1mwgRWEALaIOHvvWMw4vHOdIwF73pv5XQPrR56QC2WCAKz1kYdXeOAARicrKkhTN/5goPMB
 Tr+YsC011F/Gly+3XsHPCu6mG8ui3kfNUJ66J8W/xsbn/vk9fmpvZ8zbV17dzsLa/bzuygx
 poYfCxQWvRWYitFM7MmhNzz85cV3NN/yMKvC0jEggmA7GFc+dxI0zu7lJ8gvn13zWOEV96F
 1iJ73tovcEMdH5UU/FRctgrNz4A7C5Xac67HOksraJw2w9VGVeaG6BXac4UgEk8oJzObQfL
 yyuW4iDKskezDP+a6EB+zEOQEV2+R44l3y8MMDO1WpzCW7xESsW8rgClcrvDyKzCSoY8DDM
 tLSPkH8P1esT3vUGQztAA9xwQTYAKMjYAF3J1AMS3OWhHcCBA2RwWYsy+EEZw56Nd6vhuXB
 NcsP2QGL8RMs1U35b9PdwujWGLc/9KBz3TZdoF9b0KJeE2nCZ/Lc2HaYWy8A9CSI3yScgCz
 7EwHmNJBVljfsSM6G+20wFMr6sKQF/EHvOBSbiEKQWwEE8Vuc8MlJrnpwMnak5fnRKtJRV5
 yl39y3ul1tXMNDGit6Y0bzbNp3MbTmf1rnVoyDVa48/3IveQo9x0RT2P69H6uiI7rGq88Rn
 Mo+tQ84IL4mK1F6RT5aWWVZfhClmBPy8hNrsReZqMv9siypBw9fUYB0O9u3k20IQa141tt5
 40BQgh8o5Pe5P47iqeobsK9J3uflBu8NgxUuEvCCZFRW4fwjEm3VLlA8MysnQ5PlR8+AboQ
 oCAaxidesMaG9axA7kLz0yzSlRE3P0inbgrfk9scYKLtXwFKr2RouABg/9X6HLGjvjWNhc1
 5yBpt1e28OE6P+xx/d8HlC5ZaSNkdd9fE3oP+vzUrT58hkpmypRupvwxxQeSkrS3Q==
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

VFs should continue normal packet Rx/Tx after PF ifconfig down/up.

To achieve this, cooperate with mailbox commands added in our Linux
kernel driver txgbe-2.2.0. Detect PF ifconfig down when
TXGBE_VT_MSGTYPE_SPEC is present in mailbox commands. Detect PF ifconfig
up when mailbox commands lack TXGBE_VT_MSGTYPE_CTS. Upon detection PF
up, the VF needs to reset; the driver sets a reset callback to prompt
users to reset the VF.

Additionally, hw->rx_loaded and hw->offset_loaded must be reset after
PF ifconfig up; otherwise, because hardware counter registers are cleared
during PF reset, the VF's software counters will overflow to 0xFFFFFFFF.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_type.h |  1 +
 drivers/net/txgbe/txgbe_ethdev.c    |  3 +-
 drivers/net/txgbe/txgbe_ethdev_vf.c | 58 +++++++++++++++++++++++++----
 3 files changed, 54 insertions(+), 8 deletions(-)

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
index 7a50c7a855..7ec1e009ed 100644
--- a/drivers/net/txgbe/txgbe_ethdev_vf.c
+++ b/drivers/net/txgbe/txgbe_ethdev_vf.c
@@ -281,6 +281,7 @@ eth_txgbevf_dev_init(struct rte_eth_dev *eth_dev)
 	hw->subsystem_device_id = pci_dev->id.subsystem_device_id;
 	hw->subsystem_vendor_id = pci_dev->id.subsystem_vendor_id;
 	hw->hw_addr = (void *)pci_dev->mem_resource[0].addr;
+	hw->pf_running = true;
 
 	/* initialize the vfta */
 	memset(shadow_vfta, 0, sizeof(*shadow_vfta));
@@ -1405,8 +1406,18 @@ static s32 txgbevf_get_pf_link_status(struct rte_eth_dev *dev)
 	if (retval)
 		return 0;
 
+	if (!(msgbuf[0] & TXGBE_NOFITY_VF_LINK_STATUS))
+		return 0;
+
 	rte_eth_linkstatus_get(dev, &link);
 
+	if (!hw->pf_running) {
+		link_up = false;
+		link_speed = TXGBE_LINK_SPEED_UNKNOWN;
+		link.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
+		return rte_eth_linkstatus_set(dev, &link);
+	}
+
 	link_up = msgbuf[1] & TXGBE_VFSTATUS_UP;
 	link_speed = (msgbuf[1] & 0xFFF0) >> 1;
 
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
+	u32 msgbuf[TXGBE_VF_PERMADDR_MSG_LEN] = {0};
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
+			msgbuf[0] = TXGBE_VF_RESET;
+			err = mbx->write_posted(hw, msgbuf, 1, 0);
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

