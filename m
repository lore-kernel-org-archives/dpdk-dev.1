Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7130BFF8875
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 10:27:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90FA040691;
	Wed, 29 Apr 2026 12:26:46 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id 63DD1402A3;
 Wed, 29 Apr 2026 12:26:38 +0200 (CEST)
X-QQ-mid: esmtpgz10t1777458391teb410e21
X-QQ-Originating-IP: PVXwEHsO2X9+KwFkxXPCfTEWPN+bOo+CNCDT8rwbcNU=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.191.108])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 29 Apr 2026 18:26:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14695345988711160646
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v2 10/20] net/txgbe: fix a mass of unknown interrupts
Date: Wed, 29 Apr 2026 18:25:04 +0800
Message-Id: <20260429102515.58880-11-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260429102515.58880-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260429102515.58880-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NY3HYYTs4gYSfSAwjAacFV7MYpR6JB1l3khY/NGFzNRoCboSYhRamoYg
 o4H74nY09E+oak8Z9eVopLGk2kNroqHO6pYGVJrLBlYr3X5TTckTyAivu9+iTQbGFrfagZK
 ps2zaxQpFUBwiCe/nzUXvmjH4Ayx5f9wmjxnoDPcKwQ7KOTXX3xLHZr4a/VaUqio44FhKfP
 LJG/e8Vz3BzzGupqJFtC7pIXkaOt/apOcrmWIZk6cuh52N0KGw6N9Zo7/ZgjBkKIhd1fMzV
 IL4KEifCciulVJQT4qU4ddRQsMj9I28YKwsmWtZ8xdDLdR1B6h9PVUgU/ugHsKCfueBM8i/
 39EJy1D8w6Z/PTkDYmf1F3xM7Pi7LU5Oca/E1jtOpRaZN4aD2S6Ch7snvqE7sU3wCa+EGFQ
 IU00ASDeZ7VfucfYS4ocPxo7h+EzId2Z6ggl8kWIE1KH3fHSxkSNwGI5HXfaD0oXtFcCwDC
 BG4ss/Q0dOAeZKdkvxCHAIQa1dZ5a3rSodUAmba23OJEjDW+TlgSXYgZqTq5So0SG7W9vm5
 5QKSNp85h0fp0aVKt+ym0nR679Vhdp2iQ31L9ZlpAYxf/olauLxGmyo9Pu8miiXf4feSqtT
 wd60tBRM3bQZzpJnLhkQdyKlgooc23cwDARCjktryZ9eNMX3+Fkl5omWireMPaR8Sjs80Hk
 GoDF+E5/w5UWXYBpPOobWPSZJpW5U73BnAIKMIOubzJp2/XtAFW4BVnLVq/1HNp2Yl5hu1o
 4V7PCVEcYMKjFoMzgwW4ZdahdqDgSzWUylkBe2Q///j/AHul9nUGTtPhVTZa/ZXrAyXvzlm
 6jzqVqB/jeabKsh8HtDbZQZfTObBp3w/+fcVyjqR/WOVcYNfy/oU/gd4FWgWS+lONvK4fEi
 Bww4Ks3YZEgg6wtc+8ajmVE+onBzVkBxaKZO3OiUN/IvPphgZLXCFAgxFfL494ujO1p3U/H
 HTPgVCHGO+JesX0DHY4GhinUvY1lODvybRL/P6szuUttPEzwTBOuabMFMpvXlzBd52lMUZJ
 b9wwsiVCSy2vOqFk4aIYsoSlImHvLXvH4rp+8rtf47bunuoqRP1DUEH07A3/IUzKGd0a8DM
 rzH2B2Kc+310W3GWctn1EM=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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
index 72a4965693..be279dc4ec 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -4354,6 +4354,8 @@ static int
 txgbe_set_rsc(struct rte_eth_dev *dev)
 {
 	struct rte_eth_rxmode *rx_conf = &dev->data->dev_conf.rxmode;
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	struct rte_eth_dev_info dev_info = { 0 };
 	bool rsc_capable = false;
@@ -4404,8 +4406,6 @@ txgbe_set_rsc(struct rte_eth_dev *dev)
 			rd32(hw, TXGBE_RXCFG(rxq->reg_idx));
 		uint32_t psrtype =
 			rd32(hw, TXGBE_POOLRSS(rxq->reg_idx));
-		uint32_t eitr =
-			rd32(hw, TXGBE_ITR(rxq->reg_idx));
 
 		/*
 		 * txgbe PMD doesn't support header-split at the moment.
@@ -4424,6 +4424,9 @@ txgbe_set_rsc(struct rte_eth_dev *dev)
 		srrctl |= txgbe_get_rscctl_maxdesc(rxq->mb_pool);
 		psrtype |= TXGBE_POOLRSS_L4HDR;
 
+		wr32(hw, TXGBE_RXCFG(rxq->reg_idx), srrctl);
+		wr32(hw, TXGBE_POOLRSS(rxq->reg_idx), psrtype);
+
 		/*
 		 * RSC: Set ITR interval corresponding to 2K ints/s.
 		 *
@@ -4437,19 +4440,20 @@ txgbe_set_rsc(struct rte_eth_dev *dev)
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

