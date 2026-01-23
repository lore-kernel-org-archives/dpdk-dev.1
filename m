Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41442D6CFBB
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 03:16:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4DA740262;
	Fri, 23 Jan 2026 04:16:50 +0100 (CET)
Received: from out28-53.mail.aliyun.com (out28-53.mail.aliyun.com
 [115.124.28.53])
 by mails.dpdk.org (Postfix) with ESMTP id E8FE1400D5;
 Fri, 23 Jan 2026 04:16:47 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.gDV2mqV_1769138204 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 23 Jan 2026 11:16:45 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>, stable@dpdk.org,
 Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 1/4] net/nbl: fix memzone leak in queue release
Date: Thu, 22 Jan 2026 19:16:24 -0800
Message-Id: <20260123031627.151341-2-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123031627.151341-1-dimon.zhao@nebula-matrix.com>
References: <20260123031627.151341-1-dimon.zhao@nebula-matrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add memzone free calls in tx_queue_release() and rx_queue_release()
to fix memory leaks. The memzones allocated in tx_queue_setup() and
rx_queue_setup() were not being freed when queues were released.

Fixes: 5d910b2789da ("net/nbl: support queue setup and release")
Cc: stable@dpdk.org

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_hw/nbl_resource.h |  2 ++
 drivers/net/nbl/nbl_hw/nbl_txrx.c     | 44 ++++++++++++++++-----------
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/net/nbl/nbl_hw/nbl_resource.h b/drivers/net/nbl/nbl_hw/nbl_resource.h
index 1f6515f64d..469c3f5827 100644
--- a/drivers/net/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/nbl/nbl_hw/nbl_resource.h
@@ -137,6 +137,7 @@ struct nbl_res_tx_ring {
 	volatile struct nbl_packed_desc *desc;
 	struct nbl_tx_entry *tx_entry;
 	const struct rte_memzone *net_hdr_mz;
+	const struct rte_memzone *desc_mz;
 	volatile uint8_t *notify;
 	const struct rte_eth_dev *eth_dev;
 	struct nbl_common_info *common;
@@ -178,6 +179,7 @@ struct nbl_res_tx_ring {
 struct nbl_res_rx_ring {
 	volatile struct nbl_packed_desc *desc;
 	struct nbl_rx_entry *rx_entry;
+	const struct rte_memzone *desc_mz;
 	struct rte_mempool *mempool;
 	volatile uint8_t *notify;
 	const struct rte_eth_dev *eth_dev;
diff --git a/drivers/net/nbl/nbl_hw/nbl_txrx.c b/drivers/net/nbl/nbl_hw/nbl_txrx.c
index 650790b4fc..103f56c3a7 100644
--- a/drivers/net/nbl/nbl_hw/nbl_txrx.c
+++ b/drivers/net/nbl/nbl_hw/nbl_txrx.c
@@ -71,7 +71,12 @@ static void nbl_res_txrx_release_tx_ring(void *priv, u16 queue_idx)
 	struct nbl_res_tx_ring *tx_ring = NBL_RES_MGT_TO_TX_RING(res_mgt, queue_idx);
 	if (!tx_ring)
 		return;
-	rte_free(tx_ring->tx_entry);
+	if (tx_ring->tx_entry)
+		rte_free(tx_ring->tx_entry);
+	if (tx_ring->net_hdr_mz)
+		rte_memzone_free(tx_ring->net_hdr_mz);
+	if (tx_ring->desc_mz)
+		rte_memzone_free(tx_ring->desc_mz);
 	rte_free(tx_ring);
 	txrx_mgt->tx_rings[queue_idx] = NULL;
 }
@@ -104,7 +109,7 @@ static int nbl_res_txrx_start_tx_ring(void *priv,
 
 	if (eth_dev->data->tx_queues[param->queue_idx] != NULL) {
 		NBL_LOG(WARNING, "re-setup an already allocated tx queue");
-		nbl_res_txrx_stop_tx_ring(priv, param->queue_idx);
+		nbl_res_txrx_release_tx_ring(priv, param->queue_idx);
 		eth_dev->data->tx_queues[param->queue_idx] = NULL;
 	}
 
@@ -173,6 +178,7 @@ static int nbl_res_txrx_start_tx_ring(void *priv,
 	tx_ring->next_to_use = 0;
 	tx_ring->desc = (struct nbl_packed_desc *)memzone->addr;
 	tx_ring->net_hdr_mz = net_hdr_mz;
+	tx_ring->desc_mz = memzone;
 	tx_ring->eth_dev = eth_dev;
 	tx_ring->dma_set_msb = common->dma_set_msb;
 	tx_ring->dma_limit_msb = common->dma_limit_msb;
@@ -226,6 +232,23 @@ static void nbl_res_txrx_stop_rx_ring(void *priv, u16 queue_idx)
 	rx_ring->next_to_use = 0;
 }
 
+static void nbl_res_txrx_release_rx_ring(void *priv, u16 queue_idx)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_txrx_mgt *txrx_mgt = NBL_RES_MGT_TO_TXRX_MGT(res_mgt);
+	struct nbl_res_rx_ring *rx_ring =
+			NBL_RES_MGT_TO_RX_RING(res_mgt, queue_idx);
+	if (!rx_ring)
+		return;
+
+	if (rx_ring->rx_entry)
+		rte_free(rx_ring->rx_entry);
+	if (rx_ring->desc_mz)
+		rte_memzone_free(rx_ring->desc_mz);
+	rte_free(rx_ring);
+	txrx_mgt->rx_rings[queue_idx] = NULL;
+}
+
 static int nbl_res_txrx_start_rx_ring(void *priv,
 				      struct nbl_start_rx_ring_param *param,
 				      u64 *dma_addr)
@@ -244,7 +267,7 @@ static int nbl_res_txrx_start_rx_ring(void *priv,
 
 	if (eth_dev->data->rx_queues[param->queue_idx] != NULL) {
 		NBL_LOG(WARNING, "re-setup an already allocated rx queue");
-		nbl_res_txrx_stop_rx_ring(priv, param->queue_idx);
+		nbl_res_txrx_release_rx_ring(priv, param->queue_idx);
 		eth_dev->data->rx_queues[param->queue_idx] = NULL;
 	}
 
@@ -275,6 +298,7 @@ static int nbl_res_txrx_start_rx_ring(void *priv,
 
 	rx_ring->product = param->product;
 	rx_ring->mempool = param->mempool;
+	rx_ring->desc_mz = memzone;
 	rx_ring->nb_desc = param->nb_desc;
 	rx_ring->queue_id = param->queue_idx;
 	rx_ring->notify_qid =
@@ -376,20 +400,6 @@ static int nbl_res_alloc_rx_bufs(void *priv, u16 queue_idx)
 	return 0;
 }
 
-static void nbl_res_txrx_release_rx_ring(void *priv, u16 queue_idx)
-{
-	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
-	struct nbl_txrx_mgt *txrx_mgt = NBL_RES_MGT_TO_TXRX_MGT(res_mgt);
-	struct nbl_res_rx_ring *rx_ring =
-			NBL_RES_MGT_TO_RX_RING(res_mgt, queue_idx);
-	if (!rx_ring)
-		return;
-
-	rte_free(rx_ring->rx_entry);
-	rte_free(rx_ring);
-	txrx_mgt->rx_rings[queue_idx] = NULL;
-}
-
 static void nbl_res_txrx_update_rx_ring(void *priv, u16 index)
 {
 	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
-- 
2.34.1

