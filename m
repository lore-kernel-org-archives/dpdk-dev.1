Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB476C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 07:06:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7675640E0C;
	Mon,  9 Jun 2025 09:05:42 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id 7246840DD2;
 Mon,  9 Jun 2025 09:05:34 +0200 (CEST)
X-QQ-mid: zesmtpsz9t1749452731t703de70d
X-QQ-Originating-IP: TErnmAm6vztble8RJnqHeATZErDxRw/qZ6iSTkGBF14=
Received: from w-MS-7E16.trustnetic.com ( [220.184.249.46])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 09 Jun 2025 15:05:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18018675828024379701
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH v2 11/12] net/ngbe: restrict VLAN strip configuration on VF
Date: Mon,  9 Jun 2025 15:04:53 +0800
Message-ID: <B1A8003ACE330051+20250609070454.223387-12-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250609070454.223387-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250609070454.223387-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N7IP8+eIyBrZ86b4G+aS9x7XqTo9wn7CAsVcTeGERHG8pnMg9QCXiDaC
 chVVQn4uQhSOKfr4lrX2L/QnDe+BchZ0MLiR2lZ12gEMlSV2vJIjbP1VrjNoJtFh5UvPnPy
 eAzi2bfbQLC0Ufd6vKHT3VYQv5gJoriMdxAyYX2tcJhj5VyCjKzDPWh5zwl0Ydq1cJdvs2t
 QgbDl9j6wjxtitlHA+AYRPNnVuobQLa0LhPFu1uTsPiuRJN54mc2aPBtqxcVRevzaIGP7PF
 jYGGp2xalLhPTyQi5eWuJTO8H6m89p3ERP7zv1oa2LApEs3v9/lRs2f0VAW+WscyzYhdwX0
 Io6HgerRKxTMC+l8pY4rJGBbd5EhwQoLEUAS4g6OMfnStE7lbnCegC3xHCgABmgFeOnKirE
 Pos28wIZmyIveHc0pT4BgcMH9CtVQNe9ZP0ceGhymJQsQbJ4KdiCuo4/4ifB7hvLYImOxNi
 JYcUNwbfzakVCiCLEknfdd7bTRMcFtKhiHZEc/VIEjaxQVh3AGQIyXoYY+3GP88A7eToFp0
 peBW9aVPQeSMjn8BSlmkEGCpeSm8tU2djrinpYWwap63kYUdiKk8X40gGrJqjDpLVVx/OUE
 9nXqsrmhcysbni53fIrX32UqhWXr4K0lVuUt/yWsqg6bWDYNZos/oEhqK4TzesZ9cJfc3Zg
 SldaPj4zZO97YZm7hQyyw1gX8rYSH3xZMPaxewriFcG0x7TehA2Xb3mE+G92NZ2on8MCfO+
 OE/ISgifJeB9Tt4LvVQ4d06pkNctDLcU6Syjd6DqtjwnXfh+XjtgX94ffHjUH+5F3EBMfsb
 hIocphpukIlzJXDfnBsTx05ZdGq9J6Xq/3X85weCjeQ2bYVgyxFHMdQroiUwjfd+vuciDVH
 k/y7Qklqp3iXPKossBWa7TX5CaaZf/OYp+Qs2am6iWpBFp53wcnv59ADWrzDq0vgSfumQSd
 jcZ+fH2CNh+0DJ92RrcL5O4hLKih219rq2n2vXTU/RSoMvpBL4hdVEJdTb+ch18vaefE72E
 BfQLvjMCvWPWV8WLgEPldmPhpWbTpoDe02B3EpRGP37r4VL/Oqwp5NS21Nnu0=
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

Fix the same issue as PF in commit baca8ec066dc ("net/ngbe: restrict
configuration of VLAN strip offload").

There is a hardware limitation that Rx ring config register is not
writable when Rx ring is enabled, i.e. the TXGBE_RXCFG_ENA bit is set.
But disabling the ring when there is traffic will cause ring get stuck.
So restrict the configuration of VLAN strip offload only if device is
started.

Fixes: f47dc03c706f ("net/ngbe: add VLAN ops for VF device")
Cc: stable@dpdk.org

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ngbe/ngbe_ethdev_vf.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ngbe/ngbe_ethdev_vf.c b/drivers/net/ngbe/ngbe_ethdev_vf.c
index 5d68f1602d..846bc981f6 100644
--- a/drivers/net/ngbe/ngbe_ethdev_vf.c
+++ b/drivers/net/ngbe/ngbe_ethdev_vf.c
@@ -828,7 +828,7 @@ ngbevf_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on)
 }
 
 static void
-ngbevf_vlan_strip_queue_set(struct rte_eth_dev *dev, uint16_t queue, int on)
+ngbevf_vlan_strip_q_set(struct rte_eth_dev *dev, uint16_t queue, int on)
 {
 	struct ngbe_hw *hw = ngbe_dev_hw(dev);
 	uint32_t ctrl;
@@ -848,6 +848,19 @@ ngbevf_vlan_strip_queue_set(struct rte_eth_dev *dev, uint16_t queue, int on)
 	ngbe_vlan_hw_strip_bitmap_set(dev, queue, on);
 }
 
+static void
+ngbevf_vlan_strip_queue_set(struct rte_eth_dev *dev, uint16_t queue, int on)
+{
+	struct ngbe_hw *hw = ngbe_dev_hw(dev);
+
+	if (!hw->adapter_stopped) {
+		PMD_DRV_LOG(ERR, "Please stop port first");
+		return;
+	}
+
+	ngbevf_vlan_strip_q_set(dev, queue, on);
+}
+
 static int
 ngbevf_vlan_offload_config(struct rte_eth_dev *dev, int mask)
 {
@@ -860,7 +873,7 @@ ngbevf_vlan_offload_config(struct rte_eth_dev *dev, int mask)
 		for (i = 0; i < dev->data->nb_rx_queues; i++) {
 			rxq = dev->data->rx_queues[i];
 			on = !!(rxq->offloads &	RTE_ETH_RX_OFFLOAD_VLAN_STRIP);
-			ngbevf_vlan_strip_queue_set(dev, i, on);
+			ngbevf_vlan_strip_q_set(dev, i, on);
 		}
 	}
 
@@ -870,6 +883,13 @@ ngbevf_vlan_offload_config(struct rte_eth_dev *dev, int mask)
 static int
 ngbevf_vlan_offload_set(struct rte_eth_dev *dev, int mask)
 {
+	struct ngbe_hw *hw = ngbe_dev_hw(dev);
+
+	if (!hw->adapter_stopped && (mask & RTE_ETH_VLAN_STRIP_MASK)) {
+		PMD_DRV_LOG(ERR, "Please stop port first");
+		return -EPERM;
+	}
+
 	ngbe_config_vlan_strip_on_all_queues(dev, mask);
 
 	ngbevf_vlan_offload_config(dev, mask);
-- 
2.48.1

