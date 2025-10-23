Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEFCCCD1BC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 12:15:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1873D4060C;
	Thu, 23 Oct 2025 14:15:09 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id 7227D40431
 for <dev@dpdk.org>; Thu, 23 Oct 2025 14:15:06 +0200 (CEST)
X-QQ-mid: esmtpgz12t1761221701tddac927c
X-QQ-Originating-IP: vWmipbhz72DfEhwbsUvHK7Nw6BNtsbWPsP3/hi8OoXY=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.187.129])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Oct 2025 20:14:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6385506867610937838
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH 6/6] net/txgbe: add PF-triggered VF link status change handling
Date: Thu, 23 Oct 2025 20:13:55 +0800
Message-Id: <20251023121356.21944-7-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251023121356.21944-1-zaiyuwang@trustnetic.com>
References: <20251023121356.21944-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MPEorwW6cFo90J31SqSA/Ug9CjCOsLav0f4Dn/L8JZyqy8wmm0XoWy3g
 +HqM6Sd5fvVJpdie2IeDsaafQW0UWXK9OgXfsbAOdvzTTj1zp1JrBqwj4pspPznhvOPWf0H
 +04HHcatzm4hrnJv5Kmf0a1QraJcZwf1CfycAg06dI2AfNH0Ate80rC3dKNElSINMKFnt1O
 KTUm7+ZHYDGdJwMTP3MJbBQNXBujzGBQeSee/R8xF1r0AYrGFsRT6IuMDWqik3+u1NNCrwW
 0iWhMqE+oV2dSB2jqVk89yAiJnVBLXIMV6XdhMsRmedR65P9Ro9g8s4Ep4d0Y6iV/CQqaIC
 IvgJYyXNo3ToVRQ/qWCb/+WFj/zzN4X2/Jdf9ea5164qxi9mYgijLZTOlwIfd/ucq4eBCWd
 Xz8fKMQRGFBj9fXgy8K50sK/mX9urX8h+E8GSKHj1Zqbn4CeYpeD+939IuVl6p+t7TNP18A
 jV/ZU1gZNy9R2c/pf4B1ouKqMhRF74folG7HVii9fo1nwfJYF3+kaEAuYm6f40BdCTWEEz6
 RGLwF29WUEpTOCiCP+PgKXRexsSEOVvt/DhIQVFD3/RLJzTeac6zXQLz+RbHX9enIyK0pa4
 aGwiJsB9wjwhqSwwXiDCOmp4ghDRM67EmW/Knu5jI7MeXADl6QWDhq0agVhM7lVthYp1zH8
 1lvO5MmNG0mwVPzYahIDrRI+xGzDDF233XkKwnsQC4BpiYQrsrYqy1K+k45e1D9OBY7jtlQ
 B6kzjM2k7EK4JI+7oDy79edU0YIWLQjQRvzJVLBTTVqYtct8M1EpNKQ8u1E4/w+TLWqvhHm
 K4bKmQ6Wa8rmNP+goUgFJvcDj/GClnF1Dow+B07CHCF2axszBVNHr1aSyF5+l6xq6248mwb
 ZtjDQOn6qRmZ1iuun15A59mdpUMvTYsTnmSWrYcbgbN0aw0wXrOLj1PSAyXsnyHPI2W2Hur
 kK66W+e1ePbWSoxjT+vjED5BkZHMXbomyheeYfaFDxROko1IiIxWBfsu34Hwn8ISql4hXum
 OoCWQmgHV8Ecg6bhZWG40NmQUwiautkcmtbOHEyUJFDPvXzq4Un9WcBkvYEPkaKzCrg4yl/
 7ipE6HwHHnDYt9sh1fBjIY=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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

Our Linux kernel driver add TXGBE_NOFITY_VF_LINK_STATUS field in
mailbox message when pf notifying vf of LSC event since txgbe-2.0.0.
So we can process VF link down/up via PF's mailbox notifications,
and directly update VF link status based on PF status

For legacy kernel driver compatibility, trigger link_update to check
vf link status changes when receive a mailbox message without
TXGBE_NOFITY_VF_LINK_STATUS filed from pf.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_mbx.h  |  2 +
 drivers/net/txgbe/txgbe_ethdev_vf.c | 84 ++++++++++++++++++++++++++---
 2 files changed, 80 insertions(+), 6 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_mbx.h b/drivers/net/txgbe/base/txgbe_mbx.h
index 31e2d51658..987bbeb3c3 100644
--- a/drivers/net/txgbe/base/txgbe_mbx.h
+++ b/drivers/net/txgbe/base/txgbe_mbx.h
@@ -49,6 +49,8 @@ enum txgbe_pfvf_api_rev {
 #define TXGBE_VF_SET_MULTICAST	0x03 /* VF requests PF to set MC addr */
 #define TXGBE_VF_SET_VLAN	0x04 /* VF requests PF to set VLAN */
 
+#define TXGBE_NOFITY_VF_LINK_STATUS 0x01 /* PF notify VF link status */
+
 /* mailbox API, version 1.0 VF requests */
 #define TXGBE_VF_SET_LPE	0x05 /* VF requests PF to set VMOLR.LPE */
 #define TXGBE_VF_SET_MACVLAN	0x06 /* VF requests PF for unicast filter */
diff --git a/drivers/net/txgbe/txgbe_ethdev_vf.c b/drivers/net/txgbe/txgbe_ethdev_vf.c
index 9d0a858d4f..d181d2fe7c 100644
--- a/drivers/net/txgbe/txgbe_ethdev_vf.c
+++ b/drivers/net/txgbe/txgbe_ethdev_vf.c
@@ -1366,6 +1366,75 @@ txgbevf_dev_allmulticast_disable(struct rte_eth_dev *dev)
 	return ret;
 }
 
+/**
+ *  txgbevf_get_pf_link_status - Get pf link/speed status
+ *  @hw: pointer to hardware structure
+ *
+ *  - PF notifies status via mailbox on change
+ *  - VF sets its link state synchronously upon mailbox interrupt,
+ *    skipping hardware link detection.
+ **/
+static s32 txgbevf_get_pf_link_status(struct rte_eth_dev *dev)
+{
+	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
+	struct txgbe_mbx_info *mbx = &hw->mbx;
+	struct rte_eth_link link;
+	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
+	bool link_up = false;
+	u32 msgbuf[2];
+	s32 retval;
+
+	retval = mbx->read(hw, msgbuf, 2, 0);
+
+	/*
+	 *if the read failed it could just be a mailbox collision, best wait
+	 * until we are called again and don't report an error
+	 */
+	if (retval)
+		return 0;
+
+	rte_eth_linkstatus_get(dev, &link);
+
+	link_up = msgbuf[1] & TXGBE_VFSTATUS_UP;
+	link_speed = (msgbuf[1] & 0xFFF0) >> 1;
+
+	if (link_up == link.link_status && link_speed == link.link_speed)
+		return 0;
+
+	link.link_speed = link_speed;
+	link.link_status = link_up;
+
+	if (link_up)
+		link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+	else
+		link.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
+	/*
+	 * Invoke the LSC interrupt callback to notify the upper app of a link
+	 * status change, even though the change is detected via a mailbox interrupt
+	 * instead of an LSC interrupt. This is because VF link status changes do
+	 * not trigger LSC interrupts — they rely on PF notifications.
+	 */
+	rte_eth_dev_callback_process(dev, RTE_ETH_EVENT_INTR_LSC,
+				     NULL);
+	return rte_eth_linkstatus_set(dev, &link);
+}
+
+static void txgbevf_check_link_for_intr(struct rte_eth_dev *dev)
+{
+	struct rte_eth_link orig_link, new_link;
+
+	rte_eth_linkstatus_get(dev, &orig_link);
+	txgbevf_dev_link_update(dev, 0);
+	rte_eth_linkstatus_get(dev, &new_link);
+
+	PMD_DRV_LOG(INFO, "orig_link: %d, new_link: %d",
+		    orig_link.link_status, new_link.link_status);
+
+	if (new_link.link_status != orig_link.link_status)
+		rte_eth_dev_callback_process(dev, RTE_ETH_EVENT_INTR_LSC,
+					     NULL);
+}
+
 static void txgbevf_mbx_process(struct rte_eth_dev *dev)
 {
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
@@ -1375,12 +1444,15 @@ static void txgbevf_mbx_process(struct rte_eth_dev *dev)
 	in_msg = rd32(hw, TXGBE_VFMBX);
 
 	/* PF reset VF event */
-	if (in_msg == TXGBE_PF_CONTROL_MSG) {
-		/* dummy mbx read to ack pf */
-		if (txgbe_read_mbx(hw, &in_msg, 1, 0))
-			return;
-		rte_eth_dev_callback_process(dev, RTE_ETH_EVENT_INTR_RESET,
-					      NULL);
+	if (in_msg & TXGBE_PF_CONTROL_MSG) {
+		if (in_msg & TXGBE_NOFITY_VF_LINK_STATUS) {
+			txgbevf_get_pf_link_status(dev);
+		} else {
+			/* dummy mbx read to ack pf */
+			txgbe_read_mbx(hw, &in_msg, 1, 0);
+			/* check link status if pf ping vf */
+			txgbevf_check_link_for_intr(dev);
+		}
 	}
 }
 
-- 
2.21.0.windows.1

