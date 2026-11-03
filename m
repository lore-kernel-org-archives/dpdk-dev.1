Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C17606A32D
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=l8vRq40m
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9929642E87;
	Tue,  3 Nov 2026 16:13:04 +0100 (CET)
Received: from mta1.migadu.com (out-245.mta1.migadu.com [95.215.58.245])
 by mails.dpdk.org (Postfix) with ESMTPS id 0E0C742E7F
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:13:03 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=QdleizisZPvDCbVKfeiO7QdWlD6I3Fixw5M9mPHmYHE=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718782; v=1; x=1794323582;
 b=l8vRq40m93F5PNTZyiLfFC7rV5MVqO4+3layn5iYR4D5KDD9yLdSSujcR5cICfTB8/RaScDz
 CI+QSlj+EzJ8F32Y6x3B6DxgqCvkADIhu9sh4WzvGcKxODorlj3IeDjFShBDpLNlORMcapeScBC
 gqK3y7LkA/V1/WEruYyHjSGs=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 3290b021c2a86855;
 Tue, 03 Nov 2026 15:13:02 +0000
X-Mizu-Trace-ID: 3290b021c2a86855
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 123/227] net/hns3: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:21 +0800
Message-ID: <20261103145306.487255-124-chengwen.feng@linux.dev>
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
 drivers/net/hns3/hns3_cmd.c  |  2 +-
 drivers/net/hns3/hns3_rxtx.c | 44 ++++++++++++++++++------------------
 drivers/net/hns3/hns3_rxtx.h |  6 ++---
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/net/hns3/hns3_cmd.c b/drivers/net/hns3/hns3_cmd.c
index 34e12e7359..fdc8d827ad 100644
--- a/drivers/net/hns3/hns3_cmd.c
+++ b/drivers/net/hns3/hns3_cmd.c
@@ -50,7 +50,7 @@ hns3_allocate_dma_mem(struct hns3_hw *hw, struct hns3_cmq_ring *ring,
 
 	snprintf(z_name, sizeof(z_name), "hns3_dma_%" PRIu64,
 		rte_atomic_fetch_add_explicit(&hns3_dma_memzone_id, 1, rte_memory_order_relaxed));
-	mz = rte_memzone_reserve_bounded(z_name, size, SOCKET_ID_ANY,
+	mz = rte_memzone_reserve_bounded(z_name, size, RTE_NUMA_ID_ANY,
 					 RTE_MEMZONE_IOVA_CONTIG, alignment,
 					 RTE_PGSIZE_2M);
 	if (mz == NULL)
diff --git a/drivers/net/hns3/hns3_rxtx.c b/drivers/net/hns3/hns3_rxtx.c
index 8060c37f23..5e5e2ac5d0 100644
--- a/drivers/net/hns3/hns3_rxtx.c
+++ b/drivers/net/hns3/hns3_rxtx.c
@@ -1416,8 +1416,8 @@ hns3_alloc_rxq_and_dma_zone(struct rte_eth_dev *dev,
 	struct hns3_rx_queue *rxq;
 	unsigned int rx_desc;
 
-	rxq = rte_zmalloc_socket(q_info->type, sizeof(struct hns3_rx_queue),
-				 RTE_CACHE_LINE_SIZE, q_info->socket_id);
+	rxq = rte_zmalloc_numa(q_info->type, sizeof(struct hns3_rx_queue),
+				 RTE_CACHE_LINE_SIZE, q_info->numa_id);
 	if (rxq == NULL) {
 		hns3_err(hw, "Failed to allocate memory for No.%u rx ring!",
 			 q_info->idx);
@@ -1436,7 +1436,7 @@ hns3_alloc_rxq_and_dma_zone(struct rte_eth_dev *dev,
 			sizeof(struct hns3_desc);
 	rx_mz = rte_eth_dma_zone_reserve(dev, q_info->ring_name, q_info->idx,
 					 rx_desc, HNS3_RING_BASE_ALIGN,
-					 q_info->socket_id);
+					 q_info->numa_id);
 	if (rx_mz == NULL) {
 		hns3_err(hw, "Failed to reserve DMA memory for No.%u rx ring!",
 			 q_info->idx);
@@ -1452,7 +1452,7 @@ hns3_alloc_rxq_and_dma_zone(struct rte_eth_dev *dev,
 
 static int
 hns3_fake_rx_queue_setup(struct rte_eth_dev *dev, uint16_t idx,
-			 uint16_t nb_desc, unsigned int socket_id)
+			 uint16_t nb_desc, unsigned int numa_id)
 {
 	struct hns3_adapter *hns = dev->data->dev_private;
 	struct hns3_hw *hw = &hns->hw;
@@ -1466,7 +1466,7 @@ hns3_fake_rx_queue_setup(struct rte_eth_dev *dev, uint16_t idx,
 	}
 
 	q_info.idx = idx;
-	q_info.socket_id = socket_id;
+	q_info.numa_id = numa_id;
 	q_info.nb_desc = nb_desc;
 	q_info.type = "hns3 fake RX queue";
 	q_info.ring_name = "rx_fake_ring";
@@ -1506,8 +1506,8 @@ hns3_alloc_txq_and_dma_zone(struct rte_eth_dev *dev,
 	unsigned int tx_desc;
 	uint16_t i;
 
-	txq = rte_zmalloc_socket(q_info->type, sizeof(struct hns3_tx_queue),
-				 RTE_CACHE_LINE_SIZE, q_info->socket_id);
+	txq = rte_zmalloc_numa(q_info->type, sizeof(struct hns3_tx_queue),
+				 RTE_CACHE_LINE_SIZE, q_info->numa_id);
 	if (txq == NULL) {
 		hns3_err(hw, "Failed to allocate memory for No.%u tx ring!",
 			 q_info->idx);
@@ -1520,7 +1520,7 @@ hns3_alloc_txq_and_dma_zone(struct rte_eth_dev *dev,
 	tx_desc = txq->nb_tx_desc * sizeof(struct hns3_desc);
 	tx_mz = rte_eth_dma_zone_reserve(dev, q_info->ring_name, q_info->idx,
 					 tx_desc, HNS3_RING_BASE_ALIGN,
-					 q_info->socket_id);
+					 q_info->numa_id);
 	if (tx_mz == NULL) {
 		hns3_err(hw, "Failed to reserve DMA memory for No.%u tx ring!",
 			 q_info->idx);
@@ -1543,7 +1543,7 @@ hns3_alloc_txq_and_dma_zone(struct rte_eth_dev *dev,
 
 static int
 hns3_fake_tx_queue_setup(struct rte_eth_dev *dev, uint16_t idx,
-			 uint16_t nb_desc, unsigned int socket_id)
+			 uint16_t nb_desc, unsigned int numa_id)
 {
 	struct hns3_adapter *hns = dev->data->dev_private;
 	struct hns3_hw *hw = &hns->hw;
@@ -1557,7 +1557,7 @@ hns3_fake_tx_queue_setup(struct rte_eth_dev *dev, uint16_t idx,
 	}
 
 	q_info.idx = idx;
-	q_info.socket_id = socket_id;
+	q_info.numa_id = numa_id;
 	q_info.nb_desc = nb_desc;
 	q_info.type = "hns3 fake TX queue";
 	q_info.ring_name = "tx_fake_ring";
@@ -1711,7 +1711,7 @@ hns3_set_fake_rx_or_tx_queues(struct rte_eth_dev *dev, uint16_t nb_rx_q,
 	port_id = hw->data->port_id;
 	for (q = 0; q < rx_need_add_nb_q; q++) {
 		ret = hns3_fake_rx_queue_setup(dev, q, HNS3_MIN_RING_DESC,
-					       rte_eth_dev_socket_id(port_id));
+					       rte_eth_dev_numa_id(port_id));
 		if (ret)
 			goto setup_fake_rx_q_fail;
 	}
@@ -1719,7 +1719,7 @@ hns3_set_fake_rx_or_tx_queues(struct rte_eth_dev *dev, uint16_t nb_rx_q,
 	/* Allocate and set up fake TX queue per Ethernet port. */
 	for (q = 0; q < tx_need_add_nb_q; q++) {
 		ret = hns3_fake_tx_queue_setup(dev, q, HNS3_MIN_RING_DESC,
-					       rte_eth_dev_socket_id(port_id));
+					       rte_eth_dev_numa_id(port_id));
 		if (ret)
 			goto setup_fake_tx_q_fail;
 	}
@@ -1909,7 +1909,7 @@ hns3_get_tqp_reg_offset(uint16_t queue_id)
 
 int
 hns3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t nb_desc,
-		    unsigned int socket_id, const struct rte_eth_rxconf *conf,
+		    unsigned int numa_id, const struct rte_eth_rxconf *conf,
 		    struct rte_mempool *mp)
 {
 	struct hns3_adapter *hns = dev->data->dev_private;
@@ -1930,7 +1930,7 @@ hns3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t nb_desc,
 	}
 
 	q_info.idx = idx;
-	q_info.socket_id = socket_id;
+	q_info.numa_id = numa_id;
 	q_info.nb_desc = nb_desc;
 	q_info.type = "hns3 RX queue";
 	q_info.ring_name = "rx_ring";
@@ -1956,8 +1956,8 @@ hns3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t nb_desc,
 
 	rx_entry_len = (rxq->nb_rx_desc + HNS3_DEFAULT_RX_BURST) *
 			sizeof(struct hns3_entry);
-	rxq->sw_ring = rte_zmalloc_socket("hns3 RX sw ring", rx_entry_len,
-					  RTE_CACHE_LINE_SIZE, socket_id);
+	rxq->sw_ring = rte_zmalloc_numa("hns3 RX sw ring", rx_entry_len,
+					  RTE_CACHE_LINE_SIZE, numa_id);
 	if (rxq->sw_ring == NULL) {
 		hns3_err(hw, "Failed to allocate memory for rx sw ring!");
 		hns3_rx_queue_release(rxq);
@@ -3124,7 +3124,7 @@ hns3_tx_push_queue_init(struct rte_eth_dev *dev,
 
 int
 hns3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t nb_desc,
-		    unsigned int socket_id, const struct rte_eth_txconf *conf)
+		    unsigned int numa_id, const struct rte_eth_txconf *conf)
 {
 	struct hns3_adapter *hns = dev->data->dev_private;
 	uint16_t tx_rs_thresh, tx_free_thresh;
@@ -3145,7 +3145,7 @@ hns3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t nb_desc,
 	}
 
 	q_info.idx = idx;
-	q_info.socket_id = socket_id;
+	q_info.numa_id = numa_id;
 	q_info.nb_desc = nb_desc;
 	q_info.type = "hns3 TX queue";
 	q_info.ring_name = "tx_ring";
@@ -3163,8 +3163,8 @@ hns3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t nb_desc,
 	}
 
 	tx_entry_len = sizeof(struct hns3_entry) * txq->nb_tx_desc;
-	txq->sw_ring = rte_zmalloc_socket("hns3 TX sw ring", tx_entry_len,
-					  RTE_CACHE_LINE_SIZE, socket_id);
+	txq->sw_ring = rte_zmalloc_numa("hns3 TX sw ring", tx_entry_len,
+					  RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq->sw_ring == NULL) {
 		hns3_err(hw, "Failed to allocate memory for tx sw ring!");
 		hns3_tx_queue_release(txq);
@@ -3177,9 +3177,9 @@ hns3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t nb_desc,
 	txq->tx_bd_ready = txq->nb_tx_desc - 1;
 	txq->tx_free_thresh = tx_free_thresh;
 	txq->tx_rs_thresh = tx_rs_thresh;
-	txq->free = rte_zmalloc_socket("hns3 TX mbuf free array",
+	txq->free = rte_zmalloc_numa("hns3 TX mbuf free array",
 				sizeof(struct rte_mbuf *) * txq->tx_rs_thresh,
-				RTE_CACHE_LINE_SIZE, socket_id);
+				RTE_CACHE_LINE_SIZE, numa_id);
 	if (!txq->free) {
 		hns3_err(hw, "failed to allocate tx mbuf free array!");
 		hns3_tx_queue_release(txq);
diff --git a/drivers/net/hns3/hns3_rxtx.h b/drivers/net/hns3/hns3_rxtx.h
index c046ff21ee..2ba7ac0034 100644
--- a/drivers/net/hns3/hns3_rxtx.h
+++ b/drivers/net/hns3/hns3_rxtx.h
@@ -596,7 +596,7 @@ struct hns3_queue_info {
 	const char *ring_name;  /* point to hardware ring name */
 	uint16_t idx;
 	uint16_t nb_desc;
-	unsigned int socket_id;
+	unsigned int numa_id;
 };
 
 #define HNS3_TX_CKSUM_OFFLOAD_MASK (RTE_MBUF_F_TX_OUTER_UDP_CKSUM | \
@@ -745,11 +745,11 @@ int hns3_rxq_iterate(struct rte_eth_dev *dev,
 		 int (*callback)(struct hns3_rx_queue *, void *), void *arg);
 void hns3_dev_release_mbufs(struct hns3_adapter *hns);
 int hns3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t nb_desc,
-			unsigned int socket_id,
+			unsigned int numa_id,
 			const struct rte_eth_rxconf *conf,
 			struct rte_mempool *mp);
 int hns3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t nb_desc,
-			unsigned int socket_id,
+			unsigned int numa_id,
 			const struct rte_eth_txconf *conf);
 int hns3_rx_queue_count(void *rx_queue);
 int hns3_dev_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id);
-- 
2.55.0

