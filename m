Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C65C7EE30
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 12:52:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1021B40E5E;
	Wed, 25 Jun 2025 14:52:18 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id 12E2340E50
 for <dev@dpdk.org>; Wed, 25 Jun 2025 14:52:15 +0200 (CEST)
X-QQ-mid: esmtpsz21t1750855930t5881a8c3
X-QQ-Originating-IP: fNThdnKyYitCVDoTaudaxv8LGMmSVsncuH1dtVPYLt0=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.80.242])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 25 Jun 2025 20:52:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8483999691281689124
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v2 09/15] net/txgbe: add TX head Write-Back mode for
 Amber-Lite NICs
Date: Wed, 25 Jun 2025 20:50:41 +0800
Message-Id: <20250625125047.18072-10-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250625125047.18072-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250625125047.18072-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MNz/6jNXRH7sUhCDYFm0ZSwaY03eoSwZMz4IduckmnzkZACp+PQYA4pa
 MreXRqeEElyPub8BKSo3Iy3jYbWROjGXRqnNw2hp8kUK4oXNY5wSPXoJ8GZBh8FuLX5LL7b
 bVu2d2U3xYSuz3hUrgtiGJDJ5vWYfugUlOadcM8NgIBnBMmOX6WK3PXoyBeuA/iM0a4FY5+
 h+2Rh0Qt+F1lxtRd5IvsnhY0bocwEtn/cpds96DCPDbYh4Hv5bF1iNL512wEw25jp9bRnIE
 KVLUZP3+L4NXIB+Cfjru4zjWcTD3+HsIYsCOvS+ERkl3GdE2TZofVCo3/NPsJBCdzzWVanb
 xMrg5kopVGeXTvOfaH9t0F8ZAqpYS88b2ccOPKwY4GIJ7iZMnWIWrm75frKW5G8aBe0lM/3
 PqIN4LYkx++THMfiix5mWwyNJbO6xeKQ2L2/t1oCvYdH78Plqjqkj1K5PuZzO24fWVXCuVI
 tr6w5loKRGg1KN4S6Vx5RJLw0meQPTfiK1eZIoKyph9TasBOSxXn/PlqmhtaJBocjPkOt+M
 c7HIc+4YLL7oMXWds+iMMiECGKBpqLRML5y3MGgW87lpHUcF1oqlnh/kTeY9l77Sq4qOmov
 tIlV71agCO/3xvKzH/TGeJhV4pBHpjW2UWhHAl8JfQBsmkcP+D0K8mofRbbNrwQ8WTAWHwD
 BrI/U6QZpLjpznqnGVZ5mZ3ANrAfBcVQBtiJAIXAtL7w5YQSKqKnqI9UAMJtS3NZ733rlne
 ccZaPq816ZxdYlvq9mO6n6Z6DSWsBQ6wO6bvat2yJOXGon0k96rkxzLle1pFew3pZO1yTSH
 V84c6aBjO7zLcNoTBYd61158DRhqI2Nr0U0BWkBtOvRwL1gygCmPJzKABktx+cU27aCgLlK
 kWgWao7YsComrcc9tqChCZmPuNG0Ykc2Zq/6xJaCuFGkrqE+Psa+FHzw0rOs4jfqEbBjthc
 v5zL1vOSuoykJnAMTwqk5Qx00IC4p1cmDl/FH4g2jnpZTPMoLH44f629UP1nQkpzXCUg7yH
 Uw5UD9Rrws+zU/FFhFR5q4gQ/+09q+fd/v2qEQrFfZjz4r8Y66Cx09N7EF104dEo6yViFR0
 A==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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

Add TX head Write-Back mode for Amber-Lite NICs. When enabled, the
hardware no longer individually rewrites descriptors but intermittently
notifies the driver of processed descriptor indices. This feature
significantly improves performance and is enabled by default in the
driver. Users can configure it via tx_headwb and tx_headwb_size in devargs.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_regs.h       |   7 ++
 drivers/net/txgbe/base/txgbe_type.h       |   6 ++
 drivers/net/txgbe/txgbe_ethdev.c          |   9 ++
 drivers/net/txgbe/txgbe_rxtx.c            | 126 ++++++++++++++++++----
 drivers/net/txgbe/txgbe_rxtx.h            |   3 +
 drivers/net/txgbe/txgbe_rxtx_vec_common.h |  27 +++--
 6 files changed, 151 insertions(+), 27 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 7ee7712e53..17257442f3 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1402,6 +1402,13 @@ enum txgbe_5tuple_protocol {
 #define   TXGBE_TXCFG_WTHRESH_MASK_AML  MS(16, 0x1FF)
 #define   TXGBE_TXCFG_WTHRESH(v)        LS(v, 16, 0x7F)
 #define   TXGBE_TXCFG_FLUSH             MS(26, 0x1)
+#define TXGBE_PX_TR_CFG_HEAD_WB         MS(27, 0x1) /* amlite head wb */
+#define TXGBE_PX_TR_CFG_HEAD_WB_64BYTE  MS(28, 0x1) /* amlite head wb 64byte */
+#define TXGBE_PX_TR_CFG_HEAD_WB_MASK    MS(27, 0x3)
+
+/* amlite: tx head wb */
+#define TXGBE_PX_TR_HEAD_ADDRL(_i)      (0x03028 + ((_i) * 0x40))
+#define TXGBE_PX_TR_HEAD_ADDRH(_i)      (0x0302C + ((_i) * 0x40))
 
 #define TXGBE_TDM_DESC_CHK(i)		(0x0180B0 + (i) * 4) /*0-3*/
 #define TXGBE_TDM_DESC_NONFATAL(i)	(0x0180C0 + (i) * 4) /*0-3*/
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index 8005283a26..5692883f60 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -723,6 +723,8 @@ struct txgbe_phy_info {
 #define TXGBE_DEVARG_FFE_MAIN		"ffe_main"
 #define TXGBE_DEVARG_FFE_PRE		"ffe_pre"
 #define TXGBE_DEVARG_FFE_POST		"ffe_post"
+#define TXGBE_DEVARG_TX_HEAD_WB		"tx_headwb"
+#define TXGBE_DEVARG_TX_HEAD_WB_SIZE	"tx_headwb_size"
 
 static const char * const txgbe_valid_arguments[] = {
 	TXGBE_DEVARG_BP_AUTO,
@@ -733,6 +735,8 @@ static const char * const txgbe_valid_arguments[] = {
 	TXGBE_DEVARG_FFE_MAIN,
 	TXGBE_DEVARG_FFE_PRE,
 	TXGBE_DEVARG_FFE_POST,
+	TXGBE_DEVARG_TX_HEAD_WB,
+	TXGBE_DEVARG_TX_HEAD_WB_SIZE,
 	NULL
 };
 
@@ -783,6 +787,8 @@ struct txgbe_devargs {
 	u16 poll;
 	u16 present;
 	u16 sgmii;
+	u16 tx_headwb;
+	u16 tx_headwb_size;
 };
 
 struct txgbe_hw {
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index a854b40b9f..ed84594105 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -513,6 +513,9 @@ txgbe_parse_devargs(struct txgbe_hw *hw, struct rte_devargs *devargs)
 	u16 ffe_main = 27;
 	u16 ffe_pre = 8;
 	u16 ffe_post = 44;
+	/* New devargs for amberlite config */
+	u16 tx_headwb = 1;
+	u16 tx_headwb_size = 16;
 
 	if (devargs == NULL)
 		goto null;
@@ -537,6 +540,10 @@ txgbe_parse_devargs(struct txgbe_hw *hw, struct rte_devargs *devargs)
 			   &txgbe_handle_devarg, &ffe_pre);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_POST,
 			   &txgbe_handle_devarg, &ffe_post);
+	rte_kvargs_process(kvlist, TXGBE_DEVARG_TX_HEAD_WB,
+			   &txgbe_handle_devarg, &tx_headwb);
+	rte_kvargs_process(kvlist, TXGBE_DEVARG_TX_HEAD_WB_SIZE,
+			   &txgbe_handle_devarg, &tx_headwb_size);
 	rte_kvargs_free(kvlist);
 
 null:
@@ -544,6 +551,8 @@ txgbe_parse_devargs(struct txgbe_hw *hw, struct rte_devargs *devargs)
 	hw->devarg.poll = poll;
 	hw->devarg.present = present;
 	hw->devarg.sgmii = sgmii;
+	hw->devarg.tx_headwb = tx_headwb;
+	hw->devarg.tx_headwb_size = tx_headwb_size;
 	hw->phy.ffe_set = ffe_set;
 	hw->phy.ffe_main = ffe_main;
 	hw->phy.ffe_pre = ffe_pre;
diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index 558ffbf73f..9846ce3c56 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -92,14 +92,29 @@ txgbe_tx_free_bufs(struct txgbe_tx_queue *txq)
 	int i, nb_free = 0;
 	struct rte_mbuf *m, *free[RTE_TXGBE_TX_MAX_FREE_BUF_SZ];
 
-	/* check DD bit on threshold descriptor */
-	status = txq->tx_ring[txq->tx_next_dd].dw3;
-	if (!(status & rte_cpu_to_le_32(TXGBE_TXD_DD))) {
-		if (txq->nb_tx_free >> 1 < txq->tx_free_thresh)
-			txgbe_set32_masked(txq->tdc_reg_addr,
-				TXGBE_TXCFG_FLUSH, TXGBE_TXCFG_FLUSH);
-		return 0;
-	}
+	if (txq->headwb_mem) {
+		uint16_t tx_last_dd = txq->nb_tx_desc +
+				      txq->tx_next_dd - txq->tx_free_thresh;
+		if (tx_last_dd >= txq->nb_tx_desc)
+			tx_last_dd -= txq->nb_tx_desc;
+
+		volatile uint16_t head = (uint16_t)*(txq->headwb_mem);
+
+		if (txq->tx_next_dd > head && head > tx_last_dd)
+			return 0;
+		else if (tx_last_dd > txq->tx_next_dd &&
+				(head > tx_last_dd || head < txq->tx_next_dd))
+			return 0;
+	} else {
+		/* check DD bit on threshold descriptor */
+		status = txq->tx_ring[txq->tx_next_dd].dw3;
+		if (!(status & rte_cpu_to_le_32(TXGBE_TXD_DD))) {
+			if (txq->nb_tx_free >> 1 < txq->tx_free_thresh)
+				txgbe_set32_masked(txq->tdc_reg_addr,
+					TXGBE_TXCFG_FLUSH, TXGBE_TXCFG_FLUSH);
+			return 0;
+		}
+}
 
 	/*
 	 * first buffer to free from S/W ring is at index
@@ -628,17 +643,28 @@ txgbe_xmit_cleanup(struct txgbe_tx_queue *txq)
 	/* Check to make sure the last descriptor to clean is done */
 	desc_to_clean_to = sw_ring[desc_to_clean_to].last_id;
 	status = txr[desc_to_clean_to].dw3;
-	if (!(status & rte_cpu_to_le_32(TXGBE_TXD_DD))) {
-		PMD_TX_FREE_LOG(DEBUG,
-				"TX descriptor %4u is not done"
-				"(port=%d queue=%d)",
-				desc_to_clean_to,
-				txq->port_id, txq->queue_id);
-		if (txq->nb_tx_free >> 1 < txq->tx_free_thresh)
-			txgbe_set32_masked(txq->tdc_reg_addr,
-				TXGBE_TXCFG_FLUSH, TXGBE_TXCFG_FLUSH);
-		/* Failed to clean any descriptors, better luck next time */
-		return -(1);
+
+	if (txq->headwb_mem) {
+		u32 head = *(txq->headwb_mem);
+
+		PMD_TX_FREE_LOG(DEBUG, "queue[%02d]: headwb_mem = %03d, desc_to_clean_to = %03d",
+				txq->reg_idx, head, desc_to_clean_to);
+		/* we have caught up to head, no work left to do */
+		if (desc_to_clean_to == head)
+			return -(1);
+	} else {
+		if (!(status & rte_cpu_to_le_32(TXGBE_TXD_DD))) {
+			PMD_TX_FREE_LOG(DEBUG,
+					"TX descriptor %4u is not done"
+					"(port=%d queue=%d)",
+					desc_to_clean_to,
+					txq->port_id, txq->queue_id);
+			if (txq->nb_tx_free >> 1 < txq->tx_free_thresh)
+				txgbe_set32_masked(txq->tdc_reg_addr,
+					TXGBE_TXCFG_FLUSH, TXGBE_TXCFG_FLUSH);
+			/* Failed to clean any descriptors, better luck next time */
+			return -(1);
+		}
 	}
 
 	/* Figure out how many descriptors will be cleaned */
@@ -2244,6 +2270,8 @@ txgbe_tx_queue_release(struct txgbe_tx_queue *txq)
 		txq->ops->release_mbufs(txq);
 		txq->ops->free_swring(txq);
 		rte_memzone_free(txq->mz);
+		if (txq->headwb_mem)
+			rte_memzone_free(txq->headwb);
 		rte_free(txq);
 	}
 }
@@ -2380,6 +2408,43 @@ txgbe_get_tx_port_offloads(struct rte_eth_dev *dev)
 	return tx_offload_capa;
 }
 
+static int
+txgbe_setup_headwb_resources(struct rte_eth_dev *dev,
+					void *tx_queue,
+					unsigned int socket_id)
+{
+	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
+	const struct rte_memzone *headwb;
+	struct txgbe_tx_queue *txq = tx_queue;
+	u8 i, headwb_size = 0;
+
+	if (hw->mac.type != txgbe_mac_aml && hw->mac.type != txgbe_mac_aml40) {
+		txq->headwb_mem = NULL;
+		return 0;
+	}
+
+	headwb_size = hw->devarg.tx_headwb_size;
+	headwb = rte_eth_dma_zone_reserve(dev, "tx_headwb_mem", txq->queue_id,
+			sizeof(u32) * headwb_size,
+			TXGBE_ALIGN, socket_id);//amlite-to-do: align?
+
+	if (headwb == NULL) {
+		DEBUGOUT("Fail to setup headwb resources: no mem");
+		txgbe_tx_queue_release(txq);
+		return -ENOMEM;
+	}
+
+	txq->headwb = headwb;
+	txq->headwb_dma = TMZ_PADDR(headwb);
+	txq->headwb_mem = (uint32_t *) TMZ_VADDR(headwb);
+
+	/* Zero out headwb_mem memory */
+	for (i = 0; i < headwb_size; i++)
+		txq->headwb_mem[i] = 0;
+
+	return 0;
+}
+
 int __rte_cold
 txgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 			 uint16_t queue_idx,
@@ -2392,6 +2457,7 @@ txgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	struct txgbe_hw     *hw;
 	uint16_t tx_free_thresh;
 	uint64_t offloads;
+	s32 err = 0;
 
 	PMD_INIT_FUNC_TRACE();
 	hw = TXGBE_DEV_HW(dev);
@@ -2511,12 +2577,15 @@ txgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	/* set up scalar TX function as appropriate */
 	txgbe_set_tx_function(dev, txq);
 
+	if (hw->devarg.tx_headwb)
+		err = txgbe_setup_headwb_resources(dev, txq, socket_id);
+
 	txq->ops->reset(txq);
 	txq->desc_error = 0;
 
 	dev->data->tx_queues[queue_idx] = txq;
 
-	return 0;
+	return err;
 }
 
 /**
@@ -4658,6 +4727,23 @@ txgbe_dev_tx_init(struct rte_eth_dev *dev)
 		/* Setup the HW Tx Head and TX Tail descriptor pointers */
 		wr32(hw, TXGBE_TXRP(txq->reg_idx), 0);
 		wr32(hw, TXGBE_TXWP(txq->reg_idx), 0);
+
+		if ((hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) &&
+		     hw->devarg.tx_headwb) {
+			uint32_t txdctl;
+
+			wr32(hw, TXGBE_PX_TR_HEAD_ADDRL(txq->reg_idx),
+				(uint32_t)(txq->headwb_dma & BIT_MASK32));
+			wr32(hw, TXGBE_PX_TR_HEAD_ADDRH(txq->reg_idx),
+				(uint32_t)(txq->headwb_dma >> 32));
+			if (hw->devarg.tx_headwb_size == 16)
+				txdctl = TXGBE_PX_TR_CFG_HEAD_WB |
+					 TXGBE_PX_TR_CFG_HEAD_WB_64BYTE;
+			else
+				txdctl = TXGBE_PX_TR_CFG_HEAD_WB;
+			wr32m(hw, TXGBE_TXCFG(txq->reg_idx),
+				TXGBE_PX_TR_CFG_HEAD_WB_MASK, txdctl);
+		}
 	}
 
 #ifndef RTE_LIB_SECURITY
diff --git a/drivers/net/txgbe/txgbe_rxtx.h b/drivers/net/txgbe/txgbe_rxtx.h
index 622a0d3981..b1ac03576f 100644
--- a/drivers/net/txgbe/txgbe_rxtx.h
+++ b/drivers/net/txgbe/txgbe_rxtx.h
@@ -414,6 +414,9 @@ struct txgbe_tx_queue {
 	const struct rte_memzone *mz;
 	uint64_t	    desc_error;
 	bool		    resetting;
+	const struct rte_memzone *headwb;
+	uint64_t             headwb_dma;
+	volatile uint32_t    *headwb_mem;
 };
 
 struct txgbe_txq_ops {
diff --git a/drivers/net/txgbe/txgbe_rxtx_vec_common.h b/drivers/net/txgbe/txgbe_rxtx_vec_common.h
index cf67df66d8..5d75951115 100644
--- a/drivers/net/txgbe/txgbe_rxtx_vec_common.h
+++ b/drivers/net/txgbe/txgbe_rxtx_vec_common.h
@@ -89,13 +89,26 @@ txgbe_tx_free_bufs(struct txgbe_tx_queue *txq)
 	int nb_free = 0;
 	struct rte_mbuf *m, *free[RTE_TXGBE_TX_MAX_FREE_BUF_SZ];
 
-	/* check DD bit on threshold descriptor */
-	status = txq->tx_ring[txq->tx_next_dd].dw3;
-	if (!(status & TXGBE_TXD_DD)) {
-		if (txq->nb_tx_free >> 1 < txq->tx_free_thresh)
-			txgbe_set32_masked(txq->tdc_reg_addr,
-				TXGBE_TXCFG_FLUSH, TXGBE_TXCFG_FLUSH);
-		return 0;
+	if (txq->headwb_mem) {
+		uint16_t tx_last_dd = txq->nb_tx_desc +
+				      txq->tx_next_dd - txq->tx_free_thresh;
+		if (tx_last_dd >= txq->nb_tx_desc)
+			tx_last_dd -= txq->nb_tx_desc;
+				volatile uint16_t head = (uint16_t)*(txq->headwb_mem);
+		if (txq->tx_next_dd > head && head > tx_last_dd)
+			return 0;
+		else if (tx_last_dd > txq->tx_next_dd &&
+				(head > tx_last_dd || head < txq->tx_next_dd))
+			return 0;
+	} else {
+		/* check DD bit on threshold descriptor */
+		status = txq->tx_ring[txq->tx_next_dd].dw3;
+		if (!(status & TXGBE_TXD_DD)) {
+			if (txq->nb_tx_free >> 1 < txq->tx_free_thresh)
+				txgbe_set32_masked(txq->tdc_reg_addr,
+					TXGBE_TXCFG_FLUSH, TXGBE_TXCFG_FLUSH);
+			return 0;
+		}
 	}
 
 	n = txq->tx_free_thresh;
-- 
2.21.0.windows.1

