Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2244FCD5BD5
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 13:05:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6899340E13;
	Wed, 27 May 2026 15:04:13 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id 90D2740E18;
 Wed, 27 May 2026 15:04:09 +0200 (CEST)
X-QQ-mid: esmtpsz19t1779887045t762f98f4
X-QQ-Originating-IP: kgvANDHTyMwMljf14ImDLMpbdufzCzGOiXR31K8Ix8k=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.231.28.113])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 27 May 2026 21:04:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8926948673650342609
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v5 19/21] net/txgbe: fix to reset Tx write-back pointer
Date: Wed, 27 May 2026 21:02:19 +0800
Message-Id: <20260527130222.24348-20-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260527130222.24348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260527130222.24348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OZN1JCoYTp5PxSlx+4CukIz7Wqvt0YIsrcbWwiHZBqY5oYeYWAISlQKY
 LHrJB9GeJJrbTmXZn+pwktXK622VHswZIIBhT73qHFx/Y9+8laPbhCsj+rSfZespZJJjz1I
 c0tbR3XZDg71nwgY8nsBknAX7LdziVIoLJ/49e57rnnDorbXQMKzPDlQKkDcx1BMoP0Vqji
 wCspDUuMVPfoddMhBydmuirMYE5ZEX+P8LaG1yO9OAqBOa6xC64sPurRvQTZEs+VUI2lp6N
 YudSHAKg7WlO54RLmSeX4nDvUxryUZJG9qGfBtLgNnerkld7qG3G+nPCIMomVyUoFlcVi5u
 NexRA1cUfbY5CcgWmXXVQDAOzXhsP3S2nMnV5Y1OSgDUKAF8x3BbV6eLNcWejviGd13e/OX
 O8Hql3ICX+oofH6ZMraIDXRsZmNi+NT7qiU53cLZhdsk0/9vtCY3C0y+eJiuGftRfnPkfzZ
 1EEsb6mu+fWr5C9Q7sZlmVnK/rEZFnnjb+mM5kH40MSoSvi1B7FumVO8KoaNhaqSt25AZsx
 31oFf6Z7QWG0Gu3BY6ki0b5kv/1KMe4WciFxlr2HDXZNOLhufn8PAnuA8Q9TLmzVl7K2BAH
 81OBVP1LXva4wqbjC5qAGYyeUMB30OrHuYi1vgIGaG/HzaqjajLLhvrRpX6/ftVV1DK3plY
 Hsx3jhlJE3cjRyilUgmOIWBCUUIuSUZ835bPKR6FSxii84NNDY5FcqTjmZ8nBELJJdCC98Y
 FgNSrhUyw49BSA5cAgwVtHjC9cw9qxlrttQ5gg5wkgeKiplmjwuurbTf8Tz3y4mZ5fOeCoM
 TiBHgFUCitw7NzQYSfp3wHXsL5b343fd5FqN3NYC+fopbIMxFp8vFmwklDXQ7uHmdvZM/x1
 RS+psMwAOFwAwMDvDjGU6wjP/81n2Dy2Vxb9n6OAeOSAj/g018I5+Msd5e0RxiLGEtW6g6K
 8+CiA4cw8fxhKd4SGxdZK081bHKzZLLyLM5k9Z83131rSzVyuKUMFQa0jKXLStt2v/NzzAT
 uy9ID1U4Zk4qxIt2CtTagkvctccYyt+mAo4hTYW+eaFAOsKUpKKtzduE/TWKicbY0yl1dMX
 rFeYET55jIlQixzamEJQD4=
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
index ea4947201e..d27f2915f8 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -2311,6 +2311,12 @@ txgbe_reset_tx_queue(struct txgbe_tx_queue *txq)
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
@@ -2410,7 +2416,7 @@ txgbe_get_tx_port_offloads(struct rte_eth_dev *dev)
 	return tx_offload_capa;
 }
 
-static int
+static void
 txgbe_setup_headwb_resources(struct rte_eth_dev *dev,
 					void *tx_queue,
 					unsigned int socket_id)
@@ -2418,33 +2424,33 @@ txgbe_setup_headwb_resources(struct rte_eth_dev *dev,
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
@@ -2540,6 +2546,7 @@ txgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	txq->offloads = offloads;
 	txq->ops = &def_txq_ops;
 	txq->tx_deferred_start = tx_conf->tx_deferred_start;
+	txq->headwb_size = hw->devarg.tx_headwb_size;
 #ifdef RTE_LIB_SECURITY
 	txq->using_ipsec = !!(dev->data->dev_conf.txmode.offloads &
 			RTE_ETH_TX_OFFLOAD_SECURITY);
@@ -2575,8 +2582,7 @@ txgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	/* set up scalar TX function as appropriate */
 	txgbe_set_tx_function(dev, txq);
 
-	if (hw->devarg.tx_headwb)
-		err = txgbe_setup_headwb_resources(dev, txq, socket_id);
+	txgbe_setup_headwb_resources(dev, txq, socket_id);
 
 	txq->ops->reset(txq);
 	txq->desc_error = 0;
@@ -4753,15 +4759,14 @@ txgbe_dev_tx_init(struct rte_eth_dev *dev)
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
index 3671326084..3696c3557b 100644
--- a/drivers/net/txgbe/txgbe_rxtx_vec_common.h
+++ b/drivers/net/txgbe/txgbe_rxtx_vec_common.h
@@ -251,6 +251,13 @@ _txgbe_reset_tx_queue_vec(struct txgbe_tx_queue *txq)
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

