Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B123CD37AC
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 10:38:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25DD740DD3;
	Mon, 11 May 2026 12:37:21 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id 3A2C740652;
 Mon, 11 May 2026 12:37:18 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1778495835t5ffea5d1
X-QQ-Originating-IP: Pgt42omBJUtDhG4ZlrUDRojBm8/Bkd8KYsCfq/tjNmg=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 11 May 2026 18:37:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16648364105179027096
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v4 19/20] net/txgbe: fix to reset Tx write-back pointer
Date: Mon, 11 May 2026 18:36:01 +0800
Message-Id: <20260511103604.19724-20-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260511103604.19724-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N4KH/PyO63QvbyiqbkKgoo6FpGYzRDbEoFJ0CqKaWHH+NTIlOGLUpr0F
 aKyx/Bev/mmGV0heqvn/hZFJCPKJNDfxa46/BtO/N6LtOTirEWbbR7MzXoxBR7e+UdrBjvP
 s74F5dsg8LQCt/WIkwd6VXMK9Hx+gJEUIUHN6ZaJvt+uLQdcwWAkidoqQIgHpRlCNY9FSg4
 rY12iFERq18VWi/z8n2FMout9Kh9cinm5VM9iVA866U+B4b3qupP0fT9OVzsyI1A3d+EZw3
 WFmG/JrXVrY48wvT+4opS5Lcd2hU7bDX4eiVC/9Z72DX7T44S/8IaMkJKuWc9LWr6NXv7vk
 fVT5S8gyYW3Nw6uhCbuti3NxpKOOGCkNGPFsuXJPsAbyMRf8r1YQ0imilG0q0K/xxzoNSoc
 vfXpDBxjYh4B0QjAYhaFpzjUwv8ZHvsLrXrhAqw9HkUyFYdjAHhnClBa8nqv4mzZSAtSr3v
 t1h6uW+TI5wg55J4ZhwtFApORnsAOxFOJtloZgcBiXXs/aVe7TqCoGM8cKXIgX9myCleNS/
 An+pvryPuCpTXBl3JK86B3AeOBcdGM3C+y3XHRz6zlmk6hX9/WsmoWDEVdifW94EeD0e6Ms
 dFpCULc/cwb83C47wi5Kt9LAuAWKF38P61fd1u4IvaPbG7ThRt3jhhUwoDfFPi0i9rXrCAm
 MT0DpGQKC00mdK3mXEcIM8lDa8coqyeaJ/3nbjxH6UK76wtWa+XRkSisHJg7uKCRxP1bSDZ
 bcf6kuh+/Tn6i99yYJ1sicofgACjCdWi9hIY+RNxprz8k6Z7mqO/SIbFMZSPVYfqiCvi13Q
 qDbEp2u4FVkpcYp4zyTkryX8r0wea9NWWFuB1hUycZqXJaoIGfhjFCLsQwKWYPwD/m7U89c
 dohj6QOLmQyesBoJXoG/anG7bTVxRwY5ZbjSmKN38ovfFaMKsTmy+3WCn7vinv1y3SjV2Dn
 fLy8+IpPmwjb7WzasNNqUt2TgtLFs5x8XJwO8B3UYWR8dutOMQ/RRBxgcWnb2bts+zrwT0r
 yGgAExZeLLXW11lfOMVtjYfpSH2zKVRBHDeaQChH3dkFVHwxJeBXCZq7hXS9VUXLOmX2zQZ
 0ToFGolpBl9MVQZZML3258=
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
index 851cd122d8..ef53a868a6 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -2320,6 +2320,12 @@ txgbe_reset_tx_queue(struct txgbe_tx_queue *txq)
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
@@ -2419,7 +2425,7 @@ txgbe_get_tx_port_offloads(struct rte_eth_dev *dev)
 	return tx_offload_capa;
 }
 
-static int
+static void
 txgbe_setup_headwb_resources(struct rte_eth_dev *dev,
 					void *tx_queue,
 					unsigned int socket_id)
@@ -2427,33 +2433,33 @@ txgbe_setup_headwb_resources(struct rte_eth_dev *dev,
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
@@ -2549,6 +2555,7 @@ txgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	txq->offloads = offloads;
 	txq->ops = &def_txq_ops;
 	txq->tx_deferred_start = tx_conf->tx_deferred_start;
+	txq->headwb_size = hw->devarg.tx_headwb_size;
 #ifdef RTE_LIB_SECURITY
 	txq->using_ipsec = !!(dev->data->dev_conf.txmode.offloads &
 			RTE_ETH_TX_OFFLOAD_SECURITY);
@@ -2584,8 +2591,7 @@ txgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	/* set up scalar TX function as appropriate */
 	txgbe_set_tx_function(dev, txq);
 
-	if (hw->devarg.tx_headwb)
-		err = txgbe_setup_headwb_resources(dev, txq, socket_id);
+	txgbe_setup_headwb_resources(dev, txq, socket_id);
 
 	txq->ops->reset(txq);
 	txq->desc_error = 0;
@@ -4762,15 +4768,14 @@ txgbe_dev_tx_init(struct rte_eth_dev *dev)
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
index 02e2617cce..237bb64697 100644
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
index edf3586b77..594886c5b1 100644
--- a/drivers/net/txgbe/txgbe_rxtx_vec_common.h
+++ b/drivers/net/txgbe/txgbe_rxtx_vec_common.h
@@ -255,6 +255,13 @@ _txgbe_reset_tx_queue_vec(struct txgbe_tx_queue *txq)
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

