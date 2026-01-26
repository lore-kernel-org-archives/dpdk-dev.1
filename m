Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7006C88E5C
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 07:58:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A5D8402EA;
	Mon, 26 Jan 2026 08:58:40 +0100 (CET)
Received: from out28-196.mail.aliyun.com (out28-196.mail.aliyun.com
 [115.124.28.196])
 by mails.dpdk.org (Postfix) with ESMTP id 160B9402B6;
 Mon, 26 Jan 2026 08:58:35 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.gFyU4TT_1769414313 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 26 Jan 2026 15:58:34 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>, stable@dpdk.org,
 Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v2 3/4] net/nbl: fix mbuf double-free in queue cleanup
Date: Sun, 25 Jan 2026 23:58:14 -0800
Message-Id: <20260126075815.178216-4-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126075815.178216-1-dimon.zhao@nebula-matrix.com>
References: <20260123031627.151341-1-dimon.zhao@nebula-matrix.com>
 <20260126075815.178216-1-dimon.zhao@nebula-matrix.com>
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

Only free hardware-owned mbufs to avoid double-free
corruption of application-owned buffers.

TX ring: free only transmitted mbufs (next_to_clean to next_to_use).
RX ring: free only allocated receive buffers
	 (next_to_clean to next_to_use),
	 mbufs already delivered to the application (before next_to_clean)
	 must not be touched.

Fixes: 5d910b2789da ("net/nbl: support queue setup and release")
Cc: stable@dpdk.org

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_dev/nbl_dev.c     |  2 +-
 drivers/net/nbl/nbl_hw/nbl_txrx.c     | 73 ++++++++++++++++++++++-----
 drivers/net/nbl/nbl_hw/nbl_txrx_ops.h |  2 +-
 3 files changed, 61 insertions(+), 16 deletions(-)

diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index edff61e52e..2b0413fb7c 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -328,8 +328,8 @@ int nbl_dev_port_stop(struct rte_eth_dev *eth_dev)
 	rte_delay_ms(NBL_SAFE_THREADS_WAIT_TIME);
 
 	nbl_dev_hw_stats_stop(eth_dev);
-	nbl_clear_queues(eth_dev);
 	nbl_dev_txrx_stop(eth_dev);
+	nbl_clear_queues(eth_dev);
 	nbl_userdev_port_config(adapter, NBL_KERNEL_NETWORK);
 	return 0;
 }
diff --git a/drivers/net/nbl/nbl_hw/nbl_txrx.c b/drivers/net/nbl/nbl_hw/nbl_txrx.c
index 2a6acdcac1..3fa0b22e42 100644
--- a/drivers/net/nbl/nbl_hw/nbl_txrx.c
+++ b/drivers/net/nbl/nbl_hw/nbl_txrx.c
@@ -44,19 +44,43 @@ static void nbl_res_txrx_stop_tx_ring(void *priv, u16 queue_idx)
 {
 	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
 	struct nbl_res_tx_ring *tx_ring = NBL_RES_MGT_TO_TX_RING(res_mgt, queue_idx);
-	int i;
+	struct nbl_tx_entry *tx_entry;
+	u16 i, free_cnt, free_mbuf_cnt;
 
 	if (!tx_ring)
 		return;
 
-	for (i = 0; i < tx_ring->nb_desc; i++) {
-		if (tx_ring->tx_entry[i].mbuf != NULL) {
-			rte_pktmbuf_free_seg(tx_ring->tx_entry[i].mbuf);
-			memset(&tx_ring->tx_entry[i], 0, sizeof(*tx_ring->tx_entry));
+	i = tx_ring->next_to_clean + 1 - NBL_TX_RS_THRESH;
+	free_cnt = tx_ring->vq_free_cnt;
+	tx_entry = &tx_ring->tx_entry[i];
+	free_mbuf_cnt = 0;
+
+	while (free_cnt < tx_ring->nb_desc) {
+		if (tx_entry->mbuf) {
+			free_mbuf_cnt++;
+			rte_pktmbuf_free_seg(tx_entry->mbuf);
+		}
+
+		i++;
+		tx_entry++;
+		free_cnt++;
+		if (i == tx_ring->nb_desc) {
+			i = 0;
+			tx_entry = &tx_ring->tx_entry[i];
 		}
+	}
+
+	NBL_LOG(DEBUG, "stop tx ring ntc %u, ntu %u, vq_free_cnt %u, mbuf free_cnt %u",
+		tx_ring->next_to_clean, tx_ring->next_to_use, tx_ring->vq_free_cnt, free_mbuf_cnt);
+
+	for (i = 0; i < tx_ring->nb_desc; i++) {
+		tx_ring->desc[i].addr = 0;
+		tx_ring->desc[i].len = 0;
+		tx_ring->desc[i].id = 0;
 		tx_ring->desc[i].flags = 0;
 	}
 
+	memset(tx_ring->tx_entry, 0, sizeof(*tx_entry) * tx_ring->nb_desc);
 	tx_ring->avail_used_flags = NBL_PACKED_DESC_F_AVAIL_BIT;
 	tx_ring->used_wrap_counter = 1;
 	tx_ring->next_to_clean = NBL_TX_RS_THRESH - 1;
@@ -205,25 +229,46 @@ static int nbl_res_txrx_start_tx_ring(void *priv,
 static void nbl_res_txrx_stop_rx_ring(void *priv, u16 queue_idx)
 {
 	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
-	struct nbl_res_rx_ring *rx_ring =
-			NBL_RES_MGT_TO_RX_RING(res_mgt, queue_idx);
-	u16 i;
+	struct nbl_res_rx_ring *rx_ring = NBL_RES_MGT_TO_RX_RING(res_mgt, queue_idx);
+	struct nbl_rx_entry *rx_buf;
+	u16 i, free_cnt, free_mbuf_cnt;
 
 	if (!rx_ring)
 		return;
+
+	i = rx_ring->next_to_clean;
+	free_cnt = rx_ring->vq_free_cnt;
+	free_mbuf_cnt = 0;
+
 	if (rx_ring->rx_entry != NULL) {
-		for (i = 0; i < rx_ring->nb_desc; i++) {
-			if (rx_ring->rx_entry[i].mbuf != NULL) {
-				rte_pktmbuf_free_seg(rx_ring->rx_entry[i].mbuf);
-				rx_ring->rx_entry[i].mbuf = NULL;
+		rx_buf = &rx_ring->rx_entry[i];
+		while (free_cnt < rx_ring->nb_desc) {
+			if (rx_buf->mbuf) {
+				free_mbuf_cnt++;
+				rte_pktmbuf_free_seg(rx_buf->mbuf);
+			}
+
+			i++;
+			rx_buf++;
+			free_cnt++;
+			if (i == rx_ring->nb_desc) {
+				i = 0;
+				rx_buf = &rx_ring->rx_entry[i];
 			}
-			rx_ring->desc[i].flags = 0;
 		}
 
-		for (i = rx_ring->nb_desc; i < rx_ring->nb_desc + NBL_DESC_PER_LOOP_VEC_MAX; i++)
+		memset(rx_ring->rx_entry, 0, sizeof(struct nbl_rx_entry) * rx_ring->nb_desc);
+
+		for (i = 0; i < rx_ring->nb_desc + NBL_DESC_PER_LOOP_VEC_MAX; i++) {
+			rx_ring->desc[i].addr = 0;
+			rx_ring->desc[i].len = 0;
+			rx_ring->desc[i].id = 0;
 			rx_ring->desc[i].flags = 0;
+		}
 	}
 
+	NBL_LOG(DEBUG, "stop rx ring ntc %u, ntu %u, vq_free_cnt %u, free_mbuf_cnt %u",
+		rx_ring->next_to_clean, rx_ring->next_to_use, rx_ring->vq_free_cnt, free_mbuf_cnt);
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
 }
diff --git a/drivers/net/nbl/nbl_hw/nbl_txrx_ops.h b/drivers/net/nbl/nbl_hw/nbl_txrx_ops.h
index 2ab4b09683..dc0bab2b7b 100644
--- a/drivers/net/nbl/nbl_hw/nbl_txrx_ops.h
+++ b/drivers/net/nbl/nbl_hw/nbl_txrx_ops.h
@@ -43,7 +43,7 @@ nbl_tx_free_bufs(struct nbl_res_tx_ring *txq)
 	if (!desc_is_used(&txq->desc[next_to_clean], txq->used_wrap_counter))
 		return 0;
 
-	n = 32;
+	n = NBL_TX_RS_THRESH;
 
 	 /* first buffer to free from S/W ring is at index
 	  * tx_next_dd - (tx_rs_thresh-1)
-- 
2.34.1

