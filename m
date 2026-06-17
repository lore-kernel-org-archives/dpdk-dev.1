Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F8ECD98E1
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 03:36:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 926AE40F35;
	Wed, 17 Jun 2026 05:35:13 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 4170B40EE3;
 Wed, 17 Jun 2026 05:35:09 +0200 (CEST)
X-QQ-mid: esmtpsz11t1781667307t53d244aa
X-QQ-Originating-IP: TMaza0MSjcmRFbSuXGJE1cTfXL+0kuedhBZlZjJXHJA=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 11:35:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16252516189947683555
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v7 19/21] net/txgbe: fix to reset Tx write-back pointer
Date: Wed, 17 Jun 2026 11:33:57 +0800
Message-Id: <20260617033400.376-20-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617033400.376-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617033400.376-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NaTe32ZPgmsAOBiOOrR98CqT7Ov4xAMtlcj3qUbD5gQNDnPdcJEnUd+E
 sTKxoE1gIBrgCzvNWbGj0ENyd6ak5g0twzptLYUjW0U0hKlsekOyi4O0Ksv7Sl+xIVY4RQ3
 Iywn4slYZfDlmO+zZfSTwmZs731P1qsukLd6oPjGAXDRvlA28WslHRh5se0L2i/cDgoUWW9
 5Ta2OacPDb89lFe4W8rxgyRW+4TiIqRAgxoaJUjlJ5/oGA8CoOLjvF3o2dWI9atfpD2mc16
 +m3zE9PWSKdM/r5zrrvDDUQ2l66JWVyihctkbcbkpsO6K2RB2nNlvpNcevCwgJ84/KbU2s8
 S3+HdyiAZ9tOjwIAgpERNY8HvC5PysHVsPTBg2e5RTw52ni3KKoh3BxYCh1YU+uHg1Ah+EU
 WcuK5lEXIljdGk16Hnie5RjXpW1UGCv6gOOhYHXIwxC55Dq4g5tU2TxW2oTpNJFVlScUC/Q
 lAwEhCr0rb8BhPwOsNDnypW54Xnlbj///ewKb4Rvllb1mbQf0rOcPXi1GHaGxwsEcSimUF4
 5Rz5rDW7texx7JaVOtKan++zqzHpFuJVZg10atsOv6kisyTOwjxJZFja/U1iOShL5SOO+T1
 ZrSBgGOE10jnX8TmUa8f9AiFTArJMAEqcO8z/dyMWz0W5gZgxCLAcuf83YLnsGt1lsh5o+E
 3OVJeMGYE7YIkLjvH515mIypQh1saqueMX9ub0c0JjIGnYIpq+fPRl93WIzzI63UJl7GoIY
 aSUshhrUB/8RTG8cGFve6hPlp1IFHyTypmVhbZMPc+A3bB+3EtJYbGpGD1Q/q8a/dHRS6w0
 5RZVF2YVsHHRc1/7xKA3trhFTo4fhJ4fs2RHfQysoBvkCFKwQzHAD1af9R32pEz1aDONcUX
 7ORG7xD9QhqX+/Ob5EdmKcg17bNZashhbgA/vfSsWYApFV0gHveyByx/RdC97ZQlWXmTiZB
 Zzbvl1UTXF1+55o5xY1jZyhkQspBj3APaBBosf09W1Z2Hc0Dw7Hmp6l1+STE5ZPHSqlfO5l
 0X/wbHKYtfEGCTf4PJgBsS7ZZ6b3cxDYSNIQGkatxeuDNWEP781jTL3AEjeCR7ZVMFJKLlp
 X3GKl1ZFG5K2eNfKWp9CJzjEGriYHtN/A==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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

