Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21DA606D2F3
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SaXVys8i
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 384F342EDA;
	Tue,  3 Nov 2026 16:15:59 +0100 (CET)
Received: from mta1.migadu.com (out-191.mta1.migadu.com [95.215.58.191])
 by mails.dpdk.org (Postfix) with ESMTPS id 3079242EC5
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:15:58 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=TTLgEKrFmAcbv6zj9tckQkapIMIyiMFF50ksPPvei1c=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718957; v=1; x=1794323757;
 b=SaXVys8icoj/LqCukLrgjJeLXBupOYFWjOJC/SAdcwbRRvzkpgEDMjVPQfwpmR8g1u89VwmB
 es2RVANfA1CbBQ7V5Tk/0Tjg1ozn2jYalvfYdGEJQOg2/V0Kvr4wt9Ve/Z2YlUF41o0DUnROJqc
 kmL6eYFB19AuyxuhaYm8ZL48=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 5b3131967dab7483;
 Tue, 03 Nov 2026 15:15:57 +0000
X-Mizu-Trace-ID: 5b3131967dab7483
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 145/227] net/rnp: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:43 +0800
Message-ID: <20261103145306.487255-146-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename socket_id parameters, internal structure fields, variables
and comments to the NUMA node terminology, and switch calls to
the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/net/rnp/base/rnp_osdep.h |  2 +-
 drivers/net/rnp/rnp_ethdev.c     |  4 ++--
 drivers/net/rnp/rnp_rxtx.c       | 40 ++++++++++++++++----------------
 drivers/net/rnp/rnp_rxtx.h       |  4 ++--
 4 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/net/rnp/base/rnp_osdep.h b/drivers/net/rnp/base/rnp_osdep.h
index c03de79e7e..5c6952b1ef 100644
--- a/drivers/net/rnp/base/rnp_osdep.h
+++ b/drivers/net/rnp/base/rnp_osdep.h
@@ -129,7 +129,7 @@ rnp_dma_mem_alloc(__rte_unused struct rnp_hw *hw,
 				(uint64_t)rte_atomic_fetch_add_explicit(&rnp_dma_memzone_id, 1,
 				rte_memory_order_relaxed));
 	}
-	mz = rte_memzone_reserve_bounded(z_name, size, SOCKET_ID_ANY, 0,
+	mz = rte_memzone_reserve_bounded(z_name, size, RTE_NUMA_ID_ANY, 0,
 			0, RTE_PGSIZE_2M);
 	if (!mz)
 		return NULL;
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 125134f8d4..ccb92b299f 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -33,7 +33,7 @@ rnp_alloc_eth_port(struct rte_pci_device *pci, char *name)
 		RNP_PMD_ERR("Could not allocate eth_dev for %s", name);
 		return NULL;
 	}
-	port = rte_zmalloc_socket(name,
+	port = rte_zmalloc_numa(name,
 			sizeof(*port),
 			RTE_CACHE_LINE_SIZE,
 			pci->device.numa_node);
@@ -1633,7 +1633,7 @@ rnp_proc_priv_init(struct rte_eth_dev *dev)
 {
 	struct rnp_proc_priv *priv;
 
-	priv = rte_zmalloc_socket("rnp_proc_priv",
+	priv = rte_zmalloc_numa("rnp_proc_priv",
 			sizeof(struct rnp_proc_priv),
 			RTE_CACHE_LINE_SIZE,
 			dev->device->numa_node);
diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index 143cd11ffe..07a810a3dd 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -156,19 +156,19 @@ rnp_rx_queue_reset(struct rnp_eth_port *port,
 static int
 rnp_alloc_rxbdr(struct rte_eth_dev *dev,
 		struct rnp_rx_queue *rxq,
-		uint16_t nb_rx_desc, int socket_id)
+		uint16_t nb_rx_desc, int numa_id)
 {
 	const struct rte_memzone *rz = NULL;
 	uint32_t size = 0;
 
 	size = (nb_rx_desc + RNP_RX_MAX_BURST_SIZE) *
 		sizeof(struct rnp_rxsw_entry);
-	rxq->sw_ring = rte_zmalloc_socket("rx_swring", size,
-			RTE_CACHE_LINE_SIZE, socket_id);
+	rxq->sw_ring = rte_zmalloc_numa("rx_swring", size,
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (rxq->sw_ring == NULL)
 		return -ENOMEM;
 	rz = rte_eth_dma_zone_reserve(dev, "rx_ring", rxq->attr.queue_id,
-			RNP_RX_MAX_RING_SZ, RNP_BD_RING_ALIGN, socket_id);
+			RNP_RX_MAX_RING_SZ, RNP_BD_RING_ALIGN, numa_id);
 	if (rz == NULL) {
 		rte_free(rxq->sw_ring);
 		rxq->sw_ring = NULL;
@@ -200,7 +200,7 @@ rnp_rx_queue_sw_reset(struct rnp_rx_queue *rxq)
 int rnp_rx_queue_setup(struct rte_eth_dev *eth_dev,
 		       uint16_t qidx,
 		       uint16_t nb_rx_desc,
-		       unsigned int socket_id,
+		       unsigned int numa_id,
 		       const struct rte_eth_rxconf *rx_conf,
 		       struct rte_mempool *mb_pool)
 {
@@ -225,8 +225,8 @@ int rnp_rx_queue_setup(struct rte_eth_dev *eth_dev,
 		rnp_rx_queue_release(data->rx_queues[qidx]);
 		data->rx_queues[qidx] = NULL;
 	}
-	rxq = rte_zmalloc_socket("rnp_rxq", sizeof(struct rnp_rx_queue),
-			RTE_CACHE_LINE_SIZE, socket_id);
+	rxq = rte_zmalloc_numa("rnp_rxq", sizeof(struct rnp_rx_queue),
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (rxq == NULL) {
 		RNP_PMD_ERR("Failed to allocate rx ring memory");
 		return -ENOMEM;
@@ -247,14 +247,14 @@ int rnp_rx_queue_setup(struct rte_eth_dev *eth_dev,
 	rxq->rx_buf_len = (uint16_t)(rte_pktmbuf_data_room_size(mb_pool) -
 			RTE_PKTMBUF_HEADROOM);
 	rxq->mb_pool = mb_pool;
-	err = rnp_alloc_rxbdr(eth_dev, rxq, nb_rx_desc, socket_id);
+	err = rnp_alloc_rxbdr(eth_dev, rxq, nb_rx_desc, numa_id);
 	if (err)
 		goto fail;
 	RNP_PMD_LOG(INFO, "PF[%u] dev:[%u] hw-lane[%u] rx_qid[%u] "
 			"hw_ridx %u socket %u",
 			hw->mbx.pf_num, rxq->attr.port_id,
 			rxq->attr.lane_id, qidx,
-			rxq->attr.index, socket_id);
+			rxq->attr.index, numa_id);
 	rxq->rx_free_thresh = (rx_conf->rx_free_thresh) ?
 		rx_conf->rx_free_thresh : RNP_DEFAULT_RX_FREE_THRESH;
 	rxq->pthresh = (rx_conf->rx_thresh.pthresh) ?
@@ -329,19 +329,19 @@ rnp_dev_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 
 static int rnp_alloc_txbdr(struct rte_eth_dev *dev,
 			   struct rnp_tx_queue *txq,
-			   uint16_t nb_desc, int socket_id)
+			   uint16_t nb_desc, int numa_id)
 {
 	const struct rte_memzone *rz = NULL;
 	int size;
 
 	size = nb_desc * sizeof(struct rnp_txsw_entry);
-	txq->sw_ring = rte_zmalloc_socket("tx_swq", size,
-			RTE_CACHE_LINE_SIZE, socket_id);
+	txq->sw_ring = rte_zmalloc_numa("tx_swq", size,
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq->sw_ring == NULL)
 		return -ENOMEM;
 
 	rz = rte_eth_dma_zone_reserve(dev, "tx_ring", txq->attr.queue_id,
-			RNP_TX_MAX_RING_SZ, RNP_BD_RING_ALIGN, socket_id);
+			RNP_TX_MAX_RING_SZ, RNP_BD_RING_ALIGN, numa_id);
 	if (rz == NULL) {
 		rte_free(txq->sw_ring);
 		txq->sw_ring = NULL;
@@ -384,7 +384,7 @@ rnp_tx_queue_sw_reset(struct rnp_tx_queue *txq)
 int
 rnp_tx_queue_setup(struct rte_eth_dev *dev,
 		   uint16_t qidx, uint16_t nb_desc,
-		   unsigned int socket_id,
+		   unsigned int numa_id,
 		   const struct rte_eth_txconf *tx_conf)
 {
 	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
@@ -408,8 +408,8 @@ rnp_tx_queue_setup(struct rte_eth_dev *dev,
 		rnp_tx_queue_release(data->tx_queues[qidx]);
 		data->tx_queues[qidx] = NULL;
 	}
-	txq = rte_zmalloc_socket("rnp_txq", sizeof(struct rnp_tx_queue),
-			RTE_CACHE_LINE_SIZE, socket_id);
+	txq = rte_zmalloc_numa("rnp_txq", sizeof(struct rnp_tx_queue),
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (!txq) {
 		RNP_PMD_ERR("Failed to allocate TX ring memory");
 		return -ENOMEM;
@@ -440,9 +440,9 @@ rnp_tx_queue_setup(struct rte_eth_dev *dev,
 		tx_conf->tx_thresh.pthresh : RNP_TX_DESC_FETCH_TH;
 	txq->pburst = (tx_conf->tx_thresh.hthresh) ?
 		tx_conf->tx_thresh.hthresh : RNP_TX_DESC_FETCH_BURST;
-	txq->free_mbufs = rte_zmalloc_socket("txq->free_mbufs",
+	txq->free_mbufs = rte_zmalloc_numa("txq->free_mbufs",
 			sizeof(struct rte_mbuf *) * txq->tx_rs_thresh,
-			RTE_CACHE_LINE_SIZE, socket_id);
+			RTE_CACHE_LINE_SIZE, numa_id);
 	txq->attr.index = rnp_get_dma_ring_index(port, qidx);
 	txq->attr.lane_id = port->attr.nr_lane;
 	txq->attr.port_id = dev->data->port_id;
@@ -451,7 +451,7 @@ rnp_tx_queue_setup(struct rte_eth_dev *dev,
 	txq->attr.nb_desc = nb_desc;
 	txq->attr.queue_id = qidx;
 
-	err = rnp_alloc_txbdr(dev, txq, nb_desc, socket_id);
+	err = rnp_alloc_txbdr(dev, txq, nb_desc, numa_id);
 	if (err)
 		goto txbd_setup_failed;
 	rnp_setup_txbdr(hw, txq);
@@ -462,7 +462,7 @@ rnp_tx_queue_setup(struct rte_eth_dev *dev,
 			"dma_idx %u socket %u",
 			hw->mbx.pf_num, txq->attr.port_id,
 			txq->attr.lane_id, qidx,
-			txq->attr.index, socket_id);
+			txq->attr.index, numa_id);
 	if (qidx < dev->data->nb_tx_queues)
 		data->tx_queues[qidx] = txq;
 	port->tx_queues[qidx] = txq;
diff --git a/drivers/net/rnp/rnp_rxtx.h b/drivers/net/rnp/rnp_rxtx.h
index 1309a49a3e..831dc48abe 100644
--- a/drivers/net/rnp/rnp_rxtx.h
+++ b/drivers/net/rnp/rnp_rxtx.h
@@ -136,14 +136,14 @@ rnp_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
 int rnp_rx_queue_setup(struct rte_eth_dev *eth_dev,
 		       uint16_t qidx,
 		       uint16_t nb_rx_desc,
-		       unsigned int socket_id,
+		       unsigned int numa_id,
 		       const struct rte_eth_rxconf *rx_conf,
 		       struct rte_mempool *mb_pool);
 int rnp_tx_queue_stop(struct rte_eth_dev *eth_dev, uint16_t qidx);
 int rnp_tx_queue_start(struct rte_eth_dev *eth_dev, uint16_t qidx);
 int rnp_tx_queue_setup(struct rte_eth_dev *dev,
 		       uint16_t qidx, uint16_t nb_desc,
-		       unsigned int socket_id,
+		       unsigned int numa_id,
 		       const struct rte_eth_txconf *tx_conf);
 int rnp_rx_queue_stop(struct rte_eth_dev *eth_dev, uint16_t qidx);
 int rnp_rx_queue_start(struct rte_eth_dev *eth_dev, uint16_t qidx);
-- 
2.55.0

