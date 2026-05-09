Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA4DCD37AF
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 11:30:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 452AA40A7F;
	Sat,  9 May 2026 13:29:27 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 7131B4064F;
 Sat,  9 May 2026 13:29:22 +0200 (CEST)
X-QQ-mid: zesmtpgz1t1778326153t6c7f2873
X-QQ-Originating-IP: enhZqqp/+jp4wRIv6CTvO4ooLMdJKBzHBxL8CC7C7iY=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 09 May 2026 19:29:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 312247357610027605
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v3 10/20] net/txgbe: fix a mass of unknown interrupts
Date: Sat,  9 May 2026 19:28:12 +0800
Message-Id: <20260509112823.7728-11-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260509112823.7728-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260509112823.7728-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N71rnkwxYMwyAqjs0s022Bd6I4vIw3+65Smd2xZJsIgOE0bdIjQj4oio
 xgRSYCUEMa9iutMKn1coPTxnjwmmVY9M2m7ZrXeFJxHzqhJz4MW0W37enUnj8rlEhOk6PBy
 zssPwSwAZDsiK1idBa3DEnNtlWzqqQlozF+isuemdPUOYHlfECl1LERwojJ7kq68OD4xe50
 ANymR1pd9MqPiP+0WQ9wGm7s3JmLxIlGptHydF1FL4uxWNyUKTl4D7nUf7rN8ejJ7Fc7oVI
 pgSlatR2ZSwpEYNDcf2SphZRmsL6Uvj+HZGx54UKVd+fdrjhOqHefupo9dSN6UIWi3ZMvmM
 y1kHfv3EJDXjSL5Ets+/hy3zM9OGgxlSaXZHPHchg/Gf45WuTcR/Zr6Wkop+d5dqkSmn/UG
 D5yGshAcVwk1H6d3ILF3YexN1QzNLoX84aA/qbP3NwG8+dMMLy5tpSrARteUgn6KwMcbpmB
 WDzf4yf2jQf+VS3SM2bHcePwhtGDTjPdgUBN4y01TtTsRqNOHtUupErX7EZA5SonjfONFdC
 NokkGemThSMCLMxqBp6dWDNuJuuHTquDqCGitYNHN2fSoQko+ZN6h9uigjVk2XKiiTL6BIV
 xV82IbR5zLGufD1QBRd37od+S6VQFqgIq7DT5GPl2tEiE+W6oLGNshHpQHgQwLcDY/JdXj1
 l+Yz+600vFPLZZYhetV8JSgYHDN06/On/uXTXrMrqa3GwyV95GlNFA4vlCoFd2FT5czzRSz
 fOAkMFwvj5J4Ta3IwY8At8lLy8SZu+GHikBXLqY0XlPSTs/vFNtuOZuJUVvyT2ZWheJdiAz
 aVvDcuz31vl/nkG1TMsZOlUy5rLPfoGTyJ4HUEg+itJ7zFYTl/S7nfbdU9f8BUibC7U/d+X
 dW9f0qToguH63g5WZgOb7GNmoMii32fHc105NWlLmpMpUJDuNLwAZueV7qCkAtYsrUo6rWs
 qu22mv6Xzws1SKX8TzGIE0vfAMsluZJAEZdnkNbptyOXeF9Lz0kE3CGxNlhJT7kdj1LvcpP
 pS2gsBmDvZq85MhrQgHaxxRfWykcntiQkYfdXD+dBJ16/yJTiZ5L0Ksbb0wNfA9ugYCluHy
 sfYcnkxhX0J
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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

