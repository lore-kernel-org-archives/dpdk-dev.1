Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0810CD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:22:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D557410F6;
	Tue, 16 Jun 2026 14:21:51 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id 8B16B40E7C;
 Tue, 16 Jun 2026 14:21:47 +0200 (CEST)
X-QQ-mid: esmtpsz20t1781612505t38e11a10
X-QQ-Originating-IP: BXdQVFtFGfsqyakVpQ4MqSopNeVRiCuNa4UdUMf30SI=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 16 Jun 2026 20:21:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14801801885083797876
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v6 19/21] net/txgbe: fix to reset Tx write-back pointer
Date: Tue, 16 Jun 2026 20:20:27 +0800
Message-Id: <20260616122030.9688-20-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260616122030.9688-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260616122030.9688-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NrWWU002rHaJ6Yr056JlScm3I1bwE8QYC7OlDcBiyuxJXPop6dQmS+3f
 fNxFYa6bZ4hdeMV5pLUpvwHoGKw0/+OdanT2U9TlBlBEyzuTgzAkPisL+yHQ5GtpqEJdwdr
 CuNqPO/tBmk8OmKo8IMbvgQIqxPXL5/gaF1mFY5bvUoyLn8A9LziTe0drRm/BOMvHB/dBsS
 1RY80ptrf3uwvD3XDJg3K5xjX+EyoBme9Xxn0At+3cVdZq3ayRAKj0014GCRoQ1wiS27NxV
 /pgxRjkdS7u5Fc6G96bHc1VZjuQZ1HYGiFUlbS7HpdkkpqH07fjTt3jvgdDrtbg3iqDkqYB
 nsVjrGokE0ALK5DTenjsur+1spDE5zCPT6741C/40I64iSQiVMiqW2sY5PFd45RlqFLes+M
 VQCTmZ2SDjKqT+g+mIJpl8nahjY89fVKDQ8eeUj/K4DgtdlUMKz48eMSZTupkxmWgNlGsGQ
 AfM5kZBWlv22HzcoTQ4S/wgZfUpEFngxYbfkuWjt3XK9110Nx1x6fIPwLRd5EcYyE8pFY1W
 eRtpqoKaCiTAO3E+uQGZGoLCyZA0usVME4nEIJjQASTpJhY2T39v7wQ9Vp/PuyqPYb66d4s
 i6j2oe7L7ot7llIRMHiN7Im2Z3/1mFF9egH7CWPkdu0TvHL3rX/wFXrCD6flNtIHRYhm42t
 Qx8L4G5n8/Bjhil+f7JBLFuMgHjE87Syf/Na4oLNvpaVWpB5LTUCRyNvbaFjRV/ujyh3te2
 4LQUIZHCBHFbQhKVsxsAnFVxiuSmAGfeKPDx7tXNTZsHM1OB4dSnesUqX5nPpN8y+OeL6GA
 cIbtGyvFi5m1tzVh/3eAmyt8qoNrJN1UbDuOYt6dNYguQPJxPyh1AgoNTNvGCLRlTZH/GKw
 OxNXULKSiHXkVhsY2RmxLRPi8IELZ9Y0vy9dLAMHAL+LIYNyS55ZFe5597Ie+b3l1+PNLi9
 09bioxPu8V1u6yeaTprgOurxJLy0QfzqnCuAxFznDrRajR02yZjTCVOM+mIMcSiE1kbpayE
 8zqNoB8bY9cNZ2mRWxGklFM23ksae3Ww2mp32QpZ3g+S0sMG8Krko4RMyZitRE8BtlgPZvE
 sNDxVcAMZ/XkeV1iz4jV/JjSJNBSuiskA==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

The write-back pointer was not reset when the Tx queue was reset. This
leads to the wrong Tx desc free logic. Move the resetting of pointer into
txq->ops->reset(txq).

Fixes: 8ada71d0bb7f ("net/txgbe: add Tx head write-back mode for Amber-Lite")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_rxtx.c            | 45 +++++++++++++----------
 drivers/net/txgbe/txgbe_rxtx.h            |  1 +
 drivers/net/txgbe/txgbe_rxtx_vec_common.h |  7 ++++
 3 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index 4611124b68..ed34b3a38c 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -2313,6 +2313,12 @@ txgbe_reset_tx_queue(struct txgbe_tx_queue *txq)
 	txq->tx_next_dd = (uint16_t)(txq->tx_free_thresh - 1);
 	txq->tx_tail = 0;
 
+	/* Zero out headwb_mem memory */
+	if (txq->headwb_mem) {
+		for (i = 0; i < txq->headwb_size; i++)
+			txq->headwb_mem[i] = 0;
+	}
+
 	/*
 	 * Always allow 1 descriptor to be un-allocated to avoid
 	 * a H/W race condition
@@ -2412,7 +2418,7 @@ txgbe_get_tx_port_offloads(struct rte_eth_dev *dev)
 	return tx_offload_capa;
 }
 
-static int
+static void
 txgbe_setup_headwb_resources(struct rte_eth_dev *dev,
 					void *tx_queue,
 					unsigned int socket_id)
@@ -2420,33 +2426,33 @@ txgbe_setup_headwb_resources(struct rte_eth_dev *dev,
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	const struct rte_memzone *headwb;
 	struct txgbe_tx_queue *txq = tx_queue;
-	u8 i, headwb_size = 0;
+	u8 headwb_size = 0;
 
-	if (hw->mac.type != txgbe_mac_aml && hw->mac.type != txgbe_mac_aml40) {
-		txq->headwb_mem = NULL;
-		return 0;
-	}
+	if (hw->mac.type != txgbe_mac_aml && hw->mac.type != txgbe_mac_aml40)
+		goto out;
+
+	if (!hw->devarg.tx_headwb)
+		goto out;
 
-	headwb_size = hw->devarg.tx_headwb_size;
+	headwb_size = txq->headwb_size;
 	headwb = rte_eth_dma_zone_reserve(dev, "tx_headwb_mem", txq->queue_id,
 			sizeof(u32) * headwb_size,
 			TXGBE_ALIGN, socket_id);
 
 	if (headwb == NULL) {
-		DEBUGOUT("Fail to setup headwb resources: no mem");
-		txgbe_tx_queue_release(txq);
-		return -ENOMEM;
+		PMD_DRV_LOG(INFO,
+			    "Failed to allocate headwb memory for Tx queue %u, change to SP mode",
+			    txq->queue_id);
+		goto out;
 	}
 
 	txq->headwb = headwb;
 	txq->headwb_dma = TMZ_PADDR(headwb);
 	txq->headwb_mem = (uint32_t *)TMZ_VADDR(headwb);
+	return;
 
-	/* Zero out headwb_mem memory */
-	for (i = 0; i < headwb_size; i++)
-		txq->headwb_mem[i] = 0;
-
-	return 0;
+out:
+	txq->headwb_mem = NULL;
 }
 
 int __rte_cold
@@ -2542,6 +2548,7 @@ txgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	txq->offloads = offloads;
 	txq->ops = &def_txq_ops;
 	txq->tx_deferred_start = tx_conf->tx_deferred_start;
+	txq->headwb_size = hw->devarg.tx_headwb_size;
 #ifdef RTE_LIB_SECURITY
 	txq->using_ipsec = !!(dev->data->dev_conf.txmode.offloads &
 			RTE_ETH_TX_OFFLOAD_SECURITY);
@@ -2577,8 +2584,7 @@ txgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	/* set up scalar TX function as appropriate */
 	txgbe_set_tx_function(dev, txq);
 
-	if (hw->devarg.tx_headwb)
-		err = txgbe_setup_headwb_resources(dev, txq, socket_id);
+	txgbe_setup_headwb_resources(dev, txq, socket_id);
 
 	txq->ops->reset(txq);
 	txq->desc_error = 0;
@@ -4755,15 +4761,14 @@ txgbe_dev_tx_init(struct rte_eth_dev *dev)
 		wr32(hw, TXGBE_TXRP(txq->reg_idx), 0);
 		wr32(hw, TXGBE_TXWP(txq->reg_idx), 0);
 
-		if ((hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) &&
-		     hw->devarg.tx_headwb) {
+		if (txq->headwb_mem) {
 			uint32_t txdctl;
 
 			wr32(hw, TXGBE_PX_TR_HEAD_ADDRL(txq->reg_idx),
 				(uint32_t)(txq->headwb_dma & BIT_MASK32));
 			wr32(hw, TXGBE_PX_TR_HEAD_ADDRH(txq->reg_idx),
 				(uint32_t)(txq->headwb_dma >> 32));
-			if (hw->devarg.tx_headwb_size == 16)
+			if (txq->headwb_size == 16)
 				txdctl = TXGBE_PX_TR_CFG_HEAD_WB |
 					 TXGBE_PX_TR_CFG_HEAD_WB_64BYTE;
 			else
diff --git a/drivers/net/txgbe/txgbe_rxtx.h b/drivers/net/txgbe/txgbe_rxtx.h
index 43c818cfbf..5d2e33a8d4 100644
--- a/drivers/net/txgbe/txgbe_rxtx.h
+++ b/drivers/net/txgbe/txgbe_rxtx.h
@@ -416,6 +416,7 @@ struct txgbe_tx_queue {
 	uint64_t	    desc_error;
 	bool		    resetting;
 	const struct rte_memzone *headwb;
+	uint16_t             headwb_size;
 	uint64_t             headwb_dma;
 	volatile uint32_t    *headwb_mem;
 };
diff --git a/drivers/net/txgbe/txgbe_rxtx_vec_common.h b/drivers/net/txgbe/txgbe_rxtx_vec_common.h
index 77d7ff785b..6e561aff30 100644
--- a/drivers/net/txgbe/txgbe_rxtx_vec_common.h
+++ b/drivers/net/txgbe/txgbe_rxtx_vec_common.h
@@ -252,6 +252,13 @@ _txgbe_reset_tx_queue_vec(struct txgbe_tx_queue *txq)
 	txq->tx_next_dd = (uint16_t)(txq->tx_free_thresh - 1);
 
 	txq->tx_tail = 0;
+
+	/* Zero out headwb_mem memory */
+	if (txq->headwb_mem) {
+		for (i = 0; i < txq->headwb_size; i++)
+			txq->headwb_mem[i] = 0;
+	}
+
 	/*
 	 * Always allow 1 descriptor to be un-allocated to avoid
 	 * a H/W race condition
-- 
2.21.0.windows.1

