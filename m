Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDAECD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:21:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFFC240E38;
	Tue, 16 Jun 2026 14:21:29 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id 54E8C4065A;
 Tue, 16 Jun 2026 14:21:28 +0200 (CEST)
X-QQ-mid: esmtpsz20t1781612479t6c51c135
X-QQ-Originating-IP: cYmrl7XadLVvdsUQj3f2k2djHk0iz6+m+5ntEeMypaI=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 16 Jun 2026 20:21:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13998590230951231799
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v6 10/21] net/txgbe: fix a mass of unknown interrupts
Date: Tue, 16 Jun 2026 20:20:18 +0800
Message-Id: <20260616122030.9688-11-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260616122030.9688-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260616122030.9688-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N+Yn5LkoQi1waR0yy43vjzwpwjfg0Vx6BhC67nsRrINSP4u1KUf/8XPL
 0aEUJbWyujVcK5pCmlGnbuZCRo6qPeD9FN2GZKbB25PsnYff660LFwKIuDBTPwCfmK1EKzL
 b71FEkEZ7ksrp3kmKVc3dHStWh3vDSXWFf/DoJ+2kt5k6jYSi8aDUw7i4NGg2rMj5PwPYeS
 6WXR6mj+bNiz/jMq0RqnmbdpTDQ+0cI6YQ0+HXz7okOYMcIoe7OIYjuQj/dbrhCMn/RzWvU
 HZsMDbDfF76IYUewUMDCOgRXuPINGY0XT92PShTjgUWYc5cI/yuJdfqWNx5PcCbROG2/zxc
 pYub4AAYb+KKgY2wWfn+6s6pXzmi10jAYYfSDaIziyiNYNIBrgYROFq38POJA++FzLMUy2P
 yazQZGSzEsIaDhKTmERoGlgl8S2zbZxhKKBqVnEhs5WDtqGH3Rddta0N/N1Nc01plaorX+X
 08uyAX8HJrdPq+NRc/K/+nYFVzUCvZqhZDv9qpZsltlFakpm2fv4AkKZx4Hfmt1m1uI864f
 GwQ+arT40DJatoRdyBuy+JjfKleSBxu0RvllDDhv7eKpUnA5ypD7RdVf/cvUGGqDGcMs6DV
 slF44TuiNd0UK1yCNC0BUkHgkSBqc0WbnafDpKfn7MHFXbi8b2+Um57jIPBw7efyeVl3a6n
 jkcR5o7blXtr3VDDzhXQVcEmfpLyD7zvtQzktTY2LB6Br+4l10Z4ytUUKFrY18cO/Y/1BZ5
 LM/qxJnA0fpV+vsUZvKH2VkSI55/e0tmWDCK6VhsM6Sk3YTrtx3QIE3nNQ8BIe7pk6F3KAK
 cUDxTBgONOzh7KHVCj6OFdnC4MQrPdYss3VQtHVstBX41CcJ0ztMoUcgsPPimeZae77Xr9N
 jMX4gHYmXiCkOnowLBGVOYW3DVpHnK7vadz1S56cnY9CV05bOi4L4Po/TUXyckkdXPz7AsL
 a2tsbuEgeQLy1qSpdniwzzpbypF4PrZ0iIA7n+k88TxUQcazSs9X0E9g4EQL7aQv9E0SxH3
 SEGeK+rwbEBQbiJH0GH2VPUQ4ONstZRwc6Z1jFrFhlg/wRbpLXyJfbJNLvg/mPDPkehe1+x
 ibvGfADtwU4
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

When RSC is enabled, Rx ring IVAR is set to configure ITR. It causes Rx
ring interrupts report on the default msix_vector. Thus a mass of unknown
interrupts occupy CPU.

Fix the issue by setting ring IVAR only when the rxq interrupt is enabled.

Fixes: be797cbf4582 ("net/txgbe: add Rx and Tx init")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_rxtx.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index d6efb3b8cc..2d0c4989d9 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -4347,6 +4347,8 @@ static int
 txgbe_set_rsc(struct rte_eth_dev *dev)
 {
 	struct rte_eth_rxmode *rx_conf = &dev->data->dev_conf.rxmode;
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	struct rte_eth_dev_info dev_info = { 0 };
 	bool rsc_capable = false;
@@ -4397,8 +4399,6 @@ txgbe_set_rsc(struct rte_eth_dev *dev)
 			rd32(hw, TXGBE_RXCFG(rxq->reg_idx));
 		uint32_t psrtype =
 			rd32(hw, TXGBE_POOLRSS(rxq->reg_idx));
-		uint32_t eitr =
-			rd32(hw, TXGBE_ITR(rxq->reg_idx));
 
 		/*
 		 * txgbe PMD doesn't support header-split at the moment.
@@ -4417,6 +4417,9 @@ txgbe_set_rsc(struct rte_eth_dev *dev)
 		srrctl |= txgbe_get_rscctl_maxdesc(rxq->mb_pool);
 		psrtype |= TXGBE_POOLRSS_L4HDR;
 
+		wr32(hw, TXGBE_RXCFG(rxq->reg_idx), srrctl);
+		wr32(hw, TXGBE_POOLRSS(rxq->reg_idx), psrtype);
+
 		/*
 		 * RSC: Set ITR interval corresponding to 2K ints/s.
 		 *
@@ -4430,19 +4433,20 @@ txgbe_set_rsc(struct rte_eth_dev *dev)
 		 * For a sparse streaming case this setting will yield
 		 * at most 500us latency for a single RSC aggregation.
 		 */
-		eitr &= ~TXGBE_ITR_IVAL_MASK;
-		eitr |= TXGBE_ITR_IVAL_10G(TXGBE_QUEUE_ITR_INTERVAL_DEFAULT);
-		eitr |= TXGBE_ITR_WRDSA;
+		if (rte_intr_dp_is_en(intr_handle)) {
+			uint32_t eitr = rd32(hw, TXGBE_ITR(rxq->reg_idx));
 
-		wr32(hw, TXGBE_RXCFG(rxq->reg_idx), srrctl);
-		wr32(hw, TXGBE_POOLRSS(rxq->reg_idx), psrtype);
-		wr32(hw, TXGBE_ITR(rxq->reg_idx), eitr);
+			eitr &= ~TXGBE_ITR_IVAL_MASK;
+			eitr |= TXGBE_ITR_IVAL_10G(TXGBE_QUEUE_ITR_INTERVAL_DEFAULT);
+			eitr |= TXGBE_ITR_WRDSA;
+			wr32(hw, TXGBE_ITR(rxq->reg_idx), eitr);
 
-		/*
-		 * RSC requires the mapping of the queue to the
-		 * interrupt vector.
-		 */
-		txgbe_set_ivar_map(hw, 0, rxq->reg_idx, i);
+			/*
+			 * RSC requires the mapping of the queue to the
+			 * interrupt vector.
+			 */
+			txgbe_set_ivar_map(hw, 0, rxq->reg_idx, i);
+		}
 	}
 
 	dev->data->lro = 1;
-- 
2.21.0.windows.1

