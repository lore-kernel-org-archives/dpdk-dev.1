Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3BFC5AD49
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 08:03:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18AAC40A6B;
	Fri,  6 Jun 2025 10:02:12 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id A92EE40665;
 Fri,  6 Jun 2025 10:02:08 +0200 (CEST)
X-QQ-mid: zesmtpsz2t1749196925t70f2b7e6
X-QQ-Originating-IP: 9PRjavcIZbJRS6K/UYhHtKKTTHNJiRz3Qpm+e0xJurU=
Received: from w-MS-7E16.trustnetic.com ( [220.184.249.46])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 06 Jun 2025 16:02:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3279585422214123431
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH 10/12] net/txgbe: restrict VLAN strip configuration on VF
Date: Fri,  6 Jun 2025 16:01:15 +0800
Message-ID: <131A02DC99FEC845+20250606080117.183198-11-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606080117.183198-1-jiawenwu@trustnetic.com>
References: <20250606080117.183198-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MSZecc01IPj5TOpwuObqhmsq5ncEokTdFJCHbzSaOB8rFlA7hsc+2Dz1
 giv0Vmy2HVBJVC1i7II6tWDQLBqnmtOmsIe1NamW30tflOtTF3IkCeLnAE4+IVSaw8nyXvC
 a8wnxTI/MZZKe5OtNhNyjGhP0nOn+4Lqv8Z7D0Ddcl2Lj/ur3QWhwID3JSabo0NC/7g3t0G
 ceWeSxg6VUIEdDrmTg9ZxYkg1j1JoJf2ohjpNtx3ORtQFUqxkL0V9J9bMDKBQerq/LpvH8G
 SophhAaO+xd3UKwTwGq6ZXMEXeXU8RE6n6pXxwAOUifGHDxRnotL8aHmslSKBqEtWV0z3Ra
 V6wBoiYXH2n8HgkR/u72nkz2Rso/T0e6GgfozNhpF544oFl6lTXEVJllCCKnKxuNnuOSfD2
 9H6+xZpvg6qbMrG+hSLREkuFQAHOnoRnQWlUkzmyLDyCGABcs5iL/U8AS3v4GWxhzM+fVsW
 q9wlSyu8o5nMaKPgcAdF+40MaEQcOBhPgexPXQobO3223n9w5FtuwqvAqApAVmj76lXAJhy
 I8gN20IuGPlZD5O02Gd6P/DGAPzyEO/7Svzw/TcYiygB0+JJMdMW5ygJKWlI6nCNjqovo4D
 1zAk2QNUiNpLM4zh4NcaAeNpnxGMSu8ijOaxrgjlES6M+fGKZF2rjusY+ypxg671x48yjlm
 Pu5ZP89BSI1ktVJp0t0q0fMt7lHnlZsOcqWFa1FRkPEG0Lc1vbAP3FM9Rr0L3DMmunZbwYy
 Tw5V8QRlIJylY3tYwWUrQxQbm5aQ4N+U2juwVDASq/dFRaMI6pUGVpwriq7UKLWEP7KgMAP
 xo82cNwy5OA3TCJjcaw2deq1UAHQboXYwL0ilIFpJxFQ3qLLazF95VRqGbyt1GyeTitzpQV
 62tmHsL7do8Krkhp0V1gBskRwP1IFJHa1zb7ku14U3w0ff8pHUpOXOe71crw6v3WvI+JTEx
 22GCvtymDb6D4I7PK9rbvRYZtxKjVL2yBLxri0s2RezH0KJWjqgZ7AAwoyTiYde+XEykFUD
 HUKUICTKfIqavD8PyO7RtlT7S+SjUUoAguRqsXXg==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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

