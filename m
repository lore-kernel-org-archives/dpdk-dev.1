Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EB8CD98F2
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 11:13:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 696CB40A71;
	Mon, 22 Jun 2026 13:12:13 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id 3166140677;
 Mon, 22 Jun 2026 13:12:09 +0200 (CEST)
X-QQ-mid: esmtpsz18t1782126715t9718320c
X-QQ-Originating-IP: uZRUQDe5+ZllEJFgfYzOHVFBMJVpPrdVixnUQdMgpSQ=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 22 Jun 2026 19:11:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6030750897289131249
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v9 10/21] net/txgbe: fix a mass of unknown interrupts
Date: Mon, 22 Jun 2026 19:10:58 +0800
Message-Id: <20260622111111.21024-11-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260622111111.21024-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260622111111.21024-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N7zE+17nr98TrFNhhpOYlr1QVZFsgv/wu7Si2QajgWpzrMufKie22ufZ
 uT3BIMk7CVkeIw/tRGt9VZYDoGet/GNrq3fMxge5am0Viwde1KWPndzEvk6COQUSbHsia5L
 gjnK06CyF3x4X8gvdsZ+zBKtvH7hurepHOs+e8tRsgpLfjiE/Tadc7zPkp5Cs1e4LijLEZy
 YtTCLwrUROqwNJS+rtPoqFpdYrB10Qoz/jzRsE8Onzd+3ri550qOVxZ6p6eQL4l28nEM5I7
 CiU+VPamU2PBOVn0zZ74ErUBVsRfrSaqwWokSh8f6Q5mkt1A7Ez92FzZO1JsOyD+HF7280e
 azM4YSsH12X03zJOreztdPhKNzBmi/JbGdtS1wleYuAQCrjVPltgSdW5yGLxj2sS5zYMfUw
 OG0tkCm6vK09xDiFy1NUPKN9NokvNCQLM308tkSwe+dllCqSAkzEpMrPZ1OQQDKJY1iVRgD
 ixOuJbzTDEIP1cx3jugTl7yU1v+TBppIXy9jk0w180MM1tbFCcIUudJw+c/kAjyUz4KAEfx
 eWgoGuiHHQSnwLyadtI1IaHmRwIrakYvTZbrGs3b8Qs9t9hHCY6ge+xL0odwOHsetu0uUqM
 VtOMaT3LpJmwTooQV4Qpq5wfdQtjMormh5rtUfam6rkiZn1hgTx/DeuODSEET9ma3mq406q
 kG/IjT8EFwBYelHRvb7RPtWvKBgx23Xn6hSkHdlWPQ9ktjAQeTi3ya37MLBhcYh9OcSsAai
 TdLHLfqq7N9Q37GKIXYhI9jEPbl830RT+Oj2zxhHT+LzNLVSe3v0EruHhKHlvF/KoOefzhg
 GyInzMi9vVQNkb5RmBmAFmlgN+/IuM5/Ghwiq//0U9r3Cgb22kU1NkFtVA4U46t8U9ZPJhX
 mL8qqp6nYejL85TC1TVA31x25owq+8r6WtcRrPjxmUZYCeWTdAYMllauOVBi0BWoY84euwz
 uIwrf2+K4CXYkAFFWcEKTFQ/x/LpBbNNMYNQ/4E5DyHm/91YA8fzhBxdAFNGb/+JoFQz8an
 LetQxeoW2fFYF3dLNkEPsth56tU6gvB8P5yXkIEG/h0xMACfKpXkh0vAdJTDztQhFs7ckey
 woPe7Sko2nqKY9MLETJXTSC2m00NyNWtA==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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
index d6efb3b8cc..1c7da75c2f 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -4347,6 +4347,8 @@ static int
 txgbe_set_rsc(struct rte_eth_dev *dev)
 {
 	struct rte_eth_rxmode *rx_conf = &dev->data->dev_conf.rxmode;
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
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

