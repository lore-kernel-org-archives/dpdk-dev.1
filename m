Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66626CD98E6
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 03:35:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAACD40E2B;
	Wed, 17 Jun 2026 05:34:59 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 8D9AD40A7A;
 Wed, 17 Jun 2026 05:34:53 +0200 (CEST)
X-QQ-mid: esmtpsz11t1781667284tfcb7860d
X-QQ-Originating-IP: 3TFi8qGh0NA69DTc/JS8yXt9yr2umikGbZIQnwc+A+Q=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 11:34:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1923238947833362466
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v7 10/21] net/txgbe: fix a mass of unknown interrupts
Date: Wed, 17 Jun 2026 11:33:48 +0800
Message-Id: <20260617033400.376-11-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617033400.376-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617033400.376-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NolRe0nYnMLU7PQB1+mZIdh01rGGplmgBpSGYeklQH66tgMA2mxVkkem
 qesGt8yurxSJq0agJMaLEppMY7g/FS7ii/q6lmcftq6r3VOCJPNFsbMdv0tT2KMLYSgh9o7
 40b2eVUfjJvUc4L0ZAiQ8s9bY8PAJ2hIfRkbvWYAj6QOLyVhvu3IVBJ3ETGEVrfPzvPWqQJ
 IKTZHXRMoTradNKB6fZVHRJSoyRPafkA6cLyc3kmUYkxkYMmZBvkT9G6+cvuuUdXIGdB2oW
 up1+rnmb6IGkCv67T8hAu2d8tCvLPI6vFudpJ8JwErFFr+mm9YT1my+qlfOtvipCxIA0aO6
 TYTaehqMheCnmH3Dhy+6XDMfRRaFTYiMxCNCeajVoRznTfvX3k71uCKUbVjKSi/1s8VEaH8
 hIZMhyZ4g2YZERB1r7PDiVGGf1RgIcQKb4d2GTo8iZyziuDulvZdOj4FMERotPiuLpcEl2g
 hxIfTd9q/XkITVdtiU5B++wLOm7qHRXJVuV5PeEN3uU+M+rYUTyE58ocfF3AqreWif5VDxQ
 yHh7fc7joGP9jZmMCkfpn22sqeg1x+JkhvDmxo35QfZ/QcRnEntPGbpxQmrxAwdxaljWQPS
 90jw013tPArT2CWE7GYFrn5MSCf55x8SHwNPow1nfNvmgP9Ni8b2JSs7dliPeTK8KKg0SvC
 zok9a0ChmY5klFBbWdUFs1LrQgWrm3bCxYEI/o+F+LacGxhbd9ilfRAr4dJr0KzK7uMXlLq
 CwNoJNiJfsx+GCGxZs4F21KZMY5Nbhv+YQHy95AaGGFvUpJ+SrNUOHGDnRV37zC+Q6y+X2R
 bdgDWNShm1YKLvfLZKL4/38lmNzyQrVyMbHQKgsqEO1lL0diRrhfLRJDSoloeqakENaHG55
 7kR5xQ/E+ifEhY5NfQ+CilRgyNlLpGnyGss7wR+yKdHJVwXksla12YGEt2moNBabboBpEVN
 pndgfyhT5/pwjRpvoptmOAICpN2NgD8PnItsbvVZT1pn+yW0T//4DbIpS8S3aqz/YTTqtLY
 vpS+3+tZn9Tn3RBNZjBt4ZkmAGQQ4JucJmny8VvaXhs3I3yy9orFPTEZz3ncNhd+WAjGmBk
 9ckZ4jzaDqSN7M3p4cMDzw=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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

