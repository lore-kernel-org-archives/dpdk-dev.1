Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42BDCD98EE
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 08:15:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE31840E19;
	Wed, 17 Jun 2026 10:15:12 +0200 (CEST)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id 2C5504027A;
 Wed, 17 Jun 2026 10:15:09 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1781684102t66ce7226
X-QQ-Originating-IP: 4rbgJo9gE+gJVinxSqT6ei8aRrlaMArN1RHMMG3yYYc=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 16:15:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12812420107103707023
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v8 10/21] net/txgbe: fix a mass of unknown interrupts
Date: Wed, 17 Jun 2026 16:12:57 +0800
Message-Id: <20260617081309.19124-11-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617081309.19124-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617081309.19124-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M6Ay7JEfLhYiPOOXRUDh9iQu53Nn9C/L+WBKB4maAUHf7puLpC0BoFMF
 NT7MY54y4uvPtFLRteXbF9zkj2etS8q/Cvz1ws1KiKs3wjzg5hESQeolUcooVJu76zls5uj
 qtQpFsGm4lhoC54335DWZBsSWBXW0Dg+0mn51Bri0Bj1MVPTPLttIZIJu7B8B0df865pqI4
 BHYj02bO7DFXlK3cBxxX0C6sd1AS7VTXE7xtK+nNQLY4mUuxSfCt0z2uP7p0L/xvD03Jh9j
 TgshXo2CVmLVs+48RwgJmreCaYrRAZotIbDmDJqHvlycgwfmwbo0lmp8dsXPExmK2aJHl6J
 PaGxSJu+egZlUbZ4ix0/7GfebJCCnG042SQS/m+z5uYCGVzhbfIngd3JC5vLS1k06Rr12Zs
 VjWk6OtrlfFE5zVdGK5QYnA1bKFXlS0nVAi7VMRIuCyxyGcGaF8GT6O0t3EdBzbQEp8om9x
 0l7BfWy5Nd+6OCyjEm/B7q+0kVIWKmL5MZKaVJuHHosonBG4PrLHXaM+Ulla4KEvzhczOqC
 s5Jy2Dign1R1O3t0peledCdQdWihv5oi9apAc2lAUhpSW1lbu/cz8eEhjyr3+l8+sS+Y7iy
 nzYpCI7qwbS4eP9OBXrtv5k+rscF+v7tQrGNEyfgYdT4RYMGUHtYt8i17lbu2AzQZ5D74M8
 jDiBXSASAZorHTnMrU1d1elQEshF+60CpXQ+f5KFp46KKv15eZRtfSotdQ9wVBuldLft7aq
 shJXSaCV3j2joHxIYHfMA8rMcDjN4INt1mCHvASUnTthfLbDD2FZ6lLiMf9jn+4mUi3rR4o
 p2lMxGPnkqlI0bAZKxJfaXTyIxW3d+cgdJGC4ln80zIhcbMeSywQC5dBDpKv6/mdoy+32Zo
 PliY2NfWHM35gJ+w00g85HPsgGQn1wlKL8/1wKVSgaDGQnP6kQrcrXfmb/DyxV5MoCSrKp8
 Ndkfevz6rlUKEdR7si/RmjXcBAtBYy4zpp8NTNr8K9wWoE/Cd37235eWGZrEd8Ht1oCMHHf
 aPeDB/TUuE6wMgkW8zodmOJph6OYWmpDlPZBHWMYGhL/LZAYXlfwwLLhAe/hgaDvCJf+vAM
 Ou2ajgVVAh11g4l1oVDOzw=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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

