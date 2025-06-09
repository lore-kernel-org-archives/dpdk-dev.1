Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F08C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 07:06:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FBD240DF6;
	Mon,  9 Jun 2025 09:05:41 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id 17EDF40A6D;
 Mon,  9 Jun 2025 09:05:32 +0200 (CEST)
X-QQ-mid: zesmtpsz9t1749452729t8f54a02c
X-QQ-Originating-IP: 3gs9EfS03Ts83jchLQfqszejdx6dVvRbr81ZaJefRfg=
Received: from w-MS-7E16.trustnetic.com ( [220.184.249.46])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 09 Jun 2025 15:05:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16601405074837256311
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH v2 10/12] net/txgbe: restrict VLAN strip configuration on VF
Date: Mon,  9 Jun 2025 15:04:52 +0800
Message-ID: <55D50257D52812D2+20250609070454.223387-11-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250609070454.223387-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250609070454.223387-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N+v2p8NjVRtQmUjRkNMTO7QWWdbqWqAotv+2OrGQQLY9pUkQDM8TqIAZ
 3OXd18drQgiCMhbvrGJG94UBbeSD8UhZvY78hCOOXBNjK+OleLsmG7NXioJQ9XB/spaT0n1
 7UyDo0gBtwpZlo4jtmBW4KFjiB0Kjh7oWZ8vbPOSTlBxdF3zmqQ70KcFgisbyrwfg9wgnAd
 gVLXKW6qTX3iY6D8Bj3rq06Eq80YMGc1wJ80X6Ww0u7HAFntIMcpauVXknqTHS+MaN9wQh/
 NWancB0rSBMeBNBG7Abn3mYuFEmz3cqCkNK/ImiOqpJDuerR7f9Ct139zuzLH63WukGG0ZQ
 SlgyHG1EuVksIhecfemWU3jaIY5yL7NvstgFB8ulTifmd6FAAL3CTX9uLJkPzLtmO0iUmdt
 tDDb10psxdNpDkceWaON3I/y7dpbafPpmvquK3gRSHl2fqQRsC8y3RdWqno5rYOyVQL77Es
 Yf7D/TieLLFbMqaIL+f1X4KKyHuwhmx/kS6VT7Sas9Ld2Cw8an+cYbYWD8kw5cE/cjCxV0h
 Zi4SItW8groGJCRAQBdOUJ6jbAl1ieABVZMzpmJ5SmHTiZN3qyIjA69vkg952oiJRufeE8x
 6EP0Pnu7d0+vpjgPQPn1fM5LZQSHErhZ9J+TXAt7CQ30d4iZWC2EH3NAbQX3eDXdFUHfcWm
 +CE13q/g2jY1gXFWoyxSpXOa4aB7un12Gxf3HNxem4dhDxhrxYDRE1oP+2M23jXgBnRWdu/
 CYdWsQIrB68ufCh+sOwQs+89F3MX081nXNP01bokcZNqqe4utkq/Fx0TMrM7LY8ZDAFz5e0
 /Z0/Ogek1T2ylVqNm5M1MidkJ1azLcnQ7Inp+al0pMgIJwsLewZjfnBO9SKR6TvJph5g8+b
 OBWAHFTGIJrhUtNQwMg3KjMyuRZcLHXfx+KF83hR8q3Lh5YRn8RQeacEsZG/4VIOkTfp44U
 aEBfmSt+Wtz2NJTZ9H9JctGtbPKH7VR1dXZP5yJN/ewIgTkJ6TgWUfsqDJdsTHtdce3A/fU
 qMGx084w7+r2Xx6FM6EZ/hNO5GLZFcPJ6SFpViOXUy7fFhKbw29lE8sgl9HAk=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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

Fix the same issue as PF in commit 66364efcf958 ("net/txgbe: restrict
configuration of VLAN strip offload").

There is a hardware limitation that Rx ring config register is not
writable when Rx ring is enabled, i.e. the TXGBE_RXCFG_ENA bit is set.
But disabling the ring when there is traffic will cause ring get stuck.
So restrict the configuration of VLAN strip offload only if device is
started.

Fixes: aa1ae7941e71 ("net/txgbe: support VF VLAN")
Cc: stable@dpdk.org

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/txgbe_ethdev_vf.c | 31 +++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev_vf.c b/drivers/net/txgbe/txgbe_ethdev_vf.c
index c0d8aa15b2..847febf8c3 100644
--- a/drivers/net/txgbe/txgbe_ethdev_vf.c
+++ b/drivers/net/txgbe/txgbe_ethdev_vf.c
@@ -935,7 +935,7 @@ txgbevf_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on)
 }
 
 static void
-txgbevf_vlan_strip_queue_set(struct rte_eth_dev *dev, uint16_t queue, int on)
+txgbevf_vlan_strip_q_set(struct rte_eth_dev *dev, uint16_t queue, int on)
 {
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	uint32_t ctrl;
@@ -946,20 +946,28 @@ txgbevf_vlan_strip_queue_set(struct rte_eth_dev *dev, uint16_t queue, int on)
 		return;
 
 	ctrl = rd32(hw, TXGBE_RXCFG(queue));
-	txgbe_dev_save_rx_queue(hw, queue);
 	if (on)
 		ctrl |= TXGBE_RXCFG_VLAN;
 	else
 		ctrl &= ~TXGBE_RXCFG_VLAN;
-	wr32(hw, TXGBE_RXCFG(queue), 0);
-	msec_delay(100);
-	txgbe_dev_store_rx_queue(hw, queue);
-	wr32m(hw, TXGBE_RXCFG(queue),
-		TXGBE_RXCFG_VLAN | TXGBE_RXCFG_ENA, ctrl);
+	wr32(hw, TXGBE_RXCFG(queue), ctrl);
 
 	txgbe_vlan_hw_strip_bitmap_set(dev, queue, on);
 }
 
+static void
+txgbevf_vlan_strip_queue_set(struct rte_eth_dev *dev, uint16_t queue, int on)
+{
+	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
+
+	if (!hw->adapter_stopped) {
+		PMD_DRV_LOG(ERR, "Please stop port first");
+		return;
+	}
+
+	txgbevf_vlan_strip_q_set(dev, queue, on);
+}
+
 static int
 txgbevf_vlan_offload_config(struct rte_eth_dev *dev, int mask)
 {
@@ -972,7 +980,7 @@ txgbevf_vlan_offload_config(struct rte_eth_dev *dev, int mask)
 		for (i = 0; i < dev->data->nb_rx_queues; i++) {
 			rxq = dev->data->rx_queues[i];
 			on = !!(rxq->offloads &	RTE_ETH_RX_OFFLOAD_VLAN_STRIP);
-			txgbevf_vlan_strip_queue_set(dev, i, on);
+			txgbevf_vlan_strip_q_set(dev, i, on);
 		}
 	}
 
@@ -982,6 +990,13 @@ txgbevf_vlan_offload_config(struct rte_eth_dev *dev, int mask)
 static int
 txgbevf_vlan_offload_set(struct rte_eth_dev *dev, int mask)
 {
+	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
+
+	if (!hw->adapter_stopped && (mask & RTE_ETH_VLAN_STRIP_MASK)) {
+		PMD_DRV_LOG(ERR, "Please stop port first");
+		return -EPERM;
+	}
+
 	txgbe_config_vlan_strip_on_all_queues(dev, mask);
 
 	txgbevf_vlan_offload_config(dev, mask);
-- 
2.48.1

