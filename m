Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08DFC71135
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 08:43:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63A4F42F3D;
	Fri, 13 Jun 2025 10:42:50 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id 46E9C42EC3;
 Fri, 13 Jun 2025 10:42:46 +0200 (CEST)
X-QQ-mid: esmtpsz18t1749804164t5a7ea037
X-QQ-Originating-IP: UsPFgDszv4DCpZpYHN4VVJvitrvum+po/5gD2g2389A=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.60.58])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 13 Jun 2025 16:42:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15921256510754367061
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH v3 15/17] net/txgbe: restrict VLAN strip configuration on VF
Date: Fri, 13 Jun 2025 16:41:57 +0800
Message-Id: <20250613084159.22184-16-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250613084159.22184-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250613084159.22184-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Mdc3TkmnJyI/BTW8XV8C9sOV4QqlzLO5RwZIENJn9tcmntBIUYxyb6BG
 iv0w6r9Re1i2cUXgdCcgovxcNXRa2bU0kSHnSvjUkONFrjOpE0+kbSpCZma3SkUYNuNLvvo
 vM7qmMSc1SinuKSSlyHKe2ZVQxJ0DZQVpoPEhYOpJz3JoM8Yl6KkYOdrR6Eqf31CvVCM7/f
 T9+j49tJ1bu3gydj7rCSgmgocQ94vhQbzjK+l3X7RuMl9qe5gAOffyjcpuLgGQXGqshJqLQ
 Oj9ce/MWxwCXPCHEymFsTmGaZIlZzYboGBxIJgX3AL8MZCtzJaIOWgMWb5YUwgGUVLeN/oa
 tzj/VfIVO/wxBDnZ6lcJGVh0nRjtvGFwBuYTBzFpQQFdOtSgiYeJN7ikoq9ZlkXg+0mMCp/
 DZzP+J3qgdg1S+WAbG0831KdlWIciDvQvulEknRQ08RHUiFmb4kgsQNYwh69OIdE0/KW1AU
 PspbvyYW9lSHLn4ZvLy2ZjSKn9K2UtfmuZCWvCFWXq0nOyjn4FMVwRUQOZAQgrjd2GkQgYm
 Lcse1H+CZs4zjmDSXXZxtpqu1yDfnZTgxeNrPrJ/kxFAvApcb0UJGX/+HSSCC7Cq1yzXyrR
 92KhUYahM8eI9fEf7ZbfISLIWSefrCcmC/RCp5Muu/eLc6wLkxs7OsalMXjuQRAS20oWKQd
 Wkcjn/fTJPDylY6RM2P4AITjZqGhq2SJtIn1qMN3UgjJyy6HsJqkCsagassWxS8mUKP3ff2
 ax7IllsKDSEEeV/VlZ3NzrljJFPB/eKJWLyzbA0IwABt1xDXFNLuiS8kicDGrpl0Hp4Cp2v
 VPdiZJJoPpgQ2kaKGS08kArJT9BmAX3LzmuOwHDRqcGhaeWixV4RcDoQ5jU0IrVXrI1NQ6i
 KbtaexFS83dr2xMfJfLAz1+kPXhDQXJ+tDGI460QC+Ry6G+VdEvwzHiL+s0onlzuh9S8oTm
 1eo5sEUtgR+oaeKVqJvQalSRwOjqXJHI0vqOzQlPRfmDKdEa9CH8uZMOJjmR0SNx+UA45Am
 QUrI8RAnRzXAGVKfqGHYLBdWeSIhpWZqEFS3+fZxV97IzEKKWY
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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

