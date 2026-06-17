Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7185CCD98E2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 11:00:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62BE940A84;
	Wed, 17 Jun 2026 13:00:35 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id 2C63F4064F
 for <dev@dpdk.org>; Wed, 17 Jun 2026 13:00:33 +0200 (CEST)
X-QQ-mid: esmtpsz21t1781694022tee50fe34
X-QQ-Originating-IP: WU0kdrBWgeQdQKPbTIlyloVeP6pmiplm1WXXLotQ9nY=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 19:00:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8211041266132605163
EX-QQ-RecipientCnt: 3
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 3/4] net/txgbe: add support for VF sensing PF down
Date: Wed, 17 Jun 2026 18:59:58 +0800
Message-Id: <20260617105959.10764-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617105959.10764-1-zaiyuwang@trustnetic.com>
References: <20260617105959.10764-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MUe2PhP7Eq79we87GFuaSOGjoZFXot/yGvmsStCmhas7RIr+Kfl3e2pw
 NrCaX2ryqtR3s9XR4pWTHPBgpBLfh/CKv8no3+EYVnH0vymV1E2hhIKeyZATYmhlZDeO7HY
 yPt5xRua2nuqU43D1vwChSqEFX9KOyMjYZSmTEvA8QtFnhbrD122KMveQ3P+49gDt4K0Jrc
 757X+14086Jvw5RczTO12Mtu7ZrwFtd3kT/U4igqQDO2oGe2apO1OuKJS8Qpb4lk1MsaPm7
 cYjq3+K4ABHeyqCd0v6mZSyRAgozAQ5EAKhyJpPUVXMhBr5u5dK0B39NxZHJ6muC+n3sd+v
 mXaRefBVpXzS9od/L6jZxxKkF1EKzVgz1TLGgnQrukr6y2T3FGRrmBhZHzTovk3t8g7l0T3
 yX6Gd5UElOBrCwAs+az0d3bKQ8LIQPzO1Ucqlo/FCHHkmyS+uVBQSEGw1XWPwm2/1fznQZV
 VTX9U4y3W5BOv95R2+1OlxyzI3GGggQS2MzGm6RojdcK5Q88ggjD+3v733Ssn8SkZ6PrKp7
 HuHHOKnMwN/1qbtI7DOT5nE29a/JwcfcxlZrXHIeIHCRU90KGJVpVxvZbkm6CHsbs9FDGr4
 ubSnHftewPMukOet47/yupgt2m73rCU0eIsENPHbygANNkoL97FSHn4EQNhdqKFkolznrWv
 Pj2O21VrDQIzIHlqjfqruZ0k1L4HiO7QmsZpNK5GDGXkL/1l2gRrvC7wvf0kNMrDLRSmHBS
 XFC43dirgtRUJ4e8cldycHZzSkhx39FxmTfPc3n+B0YKanYXt1wcPt2FpCm2J8RQBfAg6OR
 qwTt65zwi6SdSsdGMkXEWUDLgDdsfmpiEvSY9399/Iob9eetgBVsbVKe1/2JuGDhSPGd8ng
 +MWhopZVJEtiwgS4ix+KX3FM1P2N2wggby1NGbWNSYtIcIEamPY8/9tuBy2T49Lt5GSwJgj
 9KkT0HO5Tq8Qdd1lZNDdMZtz1Gk0VRpiL2mef/vA30RdZupxt8e6QPzV30igmP2OuEMPuzu
 vUt7JHESBpPduJLVqr7L6yshhmAbW4u0NS/He52OXBJAzkv5iCUJpNhaTOFB+6zZRsaFIF9
 2XkzhRL7A2IIxiJkO9AysuQQSofsAQ2zA==
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
index 2e2d79e0e1..d9d08b79a2 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -909,6 +909,7 @@ struct txgbe_hw {
 	bool an_done;
 	u32 fsm;
 	u64 bp_event_interval;
+	bool pf_running;
 };
 
 typedef enum {
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 2ed9a8c179..6e7ac1320f 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -3387,7 +3387,8 @@ txgbe_dev_link_update_share(struct rte_eth_dev *dev,
 
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

