Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA511FF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 10:28:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04DB540E09;
	Wed, 29 Apr 2026 12:27:08 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id A453340684;
 Wed, 29 Apr 2026 12:27:01 +0200 (CEST)
X-QQ-mid: esmtpgz10t1777458417td5f89d6a
X-QQ-Originating-IP: kW+RCO6rcss+UUHLQdk6D2UWAbOFXr/MUrITFQ9e38s=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.191.108])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 29 Apr 2026 18:26:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3220513315290221677
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 19/20] net/txgbe: fix to reset Tx write-back pointer
Date: Wed, 29 Apr 2026 18:25:13 +0800
Message-Id: <20260429102515.58880-20-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260429102515.58880-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260429102515.58880-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OKKHiI6c9SH3Qq/HthdK3j6IapieL3lHMKmilhPBggNqinHhv0x35JIL
 kn66hs3IQ8WyN26P2SkEEzngBd1zAWlMVJpxV38+KYJ7tYkb9OJeOpLUlmMJwqPePSNuBn5
 BTDiUPK6dL3HpdDwuEEGmR3MoLq4sc4SrsUeSYTrtdZTDtg9fgOTFpeWyS3UfNMGVyF3Rdt
 cxEG3HMWsEGJVNqGpsyHdYDzySdW2TbM6EsYoSNiK1JJBD7dloFohL+bTMLnqRmk7kQh/jv
 wJK8Qllnr2KFJ1BlRpUrG80tMd4qiWSFdX+YG40RLLCsy3GxDbZS/6J0nMdpETLQSh7nMw6
 Cc8/YKlG8hKXVw+oac5AewGJyAk5Beb5pBQm072dI4ZirzWosoLuTawV3PPjcnY2TuI+bKM
 eBpNFukI2d4AMfmrW/GK4RRpXdFpsOIY88CdBE2eAkOhP2gDqK2peOwO9Zy1QsbRNwIZGxH
 +TeADFy8syj1OK4VX4MskhSMImjYq5d3WdmTmMV8HWVYpnNJz3hZ7gZ+lC605+FRxpg3GU/
 3BWeiAULgCPEV2Rc+UdmB5Txe0tQ1FvWVZ2bZs1DZYW87wfRfnsyB0ymj85cYCB8129uqoq
 VPjA9wIxRWYf9EtUtzzrGwCGs0SR4u/RmyCX6190P1a9k5FQ90fIVJ+uAQrVwfC1nEl8vFk
 ZBvwWeffvlPu0B1KNllM3DnH5T8+FpYszaRc5/BOzdRCK4HPxyHwjYc4Jeo5bxJsMRgn2es
 rfWSCTylEP6v7qIHASLVzcYTd5OeDgQjd7Om8t7peMu7BvWvX+EluLG7emg6fWIlbuTklhO
 tqhE00++H4yQ39sx/pHiRaMUvnz/zP/B/igKD7AEXC6o/SMGUqdJEjIQ4VCpvOFChyNMhVG
 8q4wDkoIXHrAXnrsxtFbicHKO+/ghIWi50KkPp0sMkOVxN4KTj5CVAyKM12URjwv/cLm5Tf
 Iav5Qv7gTxBWgC2xgXZuGQ63yqPZObXdXLMDrgeRq9fgo35pPKKceUMwD3EmTS/1TVmu7Hu
 GgY7o3zncZjflrjkDbs5gSae+DnDvn+WKpUtt34i9hs4MJju2Ds8Zey25GWSPHDfD0YOnHX
 Kj5a/97DAPK
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
index be279dc4ec..956d1cbad8 100644
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
@@ -4765,15 +4771,14 @@ txgbe_dev_tx_init(struct rte_eth_dev *dev)
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

