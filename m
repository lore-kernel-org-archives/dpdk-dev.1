Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC790606FCF4
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pudgWKIk
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81F3742E6E;
	Tue,  3 Nov 2026 16:12:43 +0100 (CET)
Received: from mta0.migadu.com (out-251.mta0.migadu.com [91.218.175.251])
 by mails.dpdk.org (Postfix) with ESMTPS id BC04442E68
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:12:42 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=lkWST5IhNRJ5Gv3IQYtFQ9m3d2b4FkakdsR1ba//xyw=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718762; v=1; x=1794323562;
 b=pudgWKIk5jgpsdL0h4RasmdJ/coT1Wo+NUOtoODEkJrOPUFeh3+mXm3od04XwHl9FRvI8SWG
 EjR2Z5uU6oh+NvaNL+uzgF10U5H6VlY6CSE62P7+2pqhG0mLYW++ZGNGgbKhb5hkld163MWSwH0
 qEtC9XrLPKfrBG6iwp1p5ox8=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 4f81d5a8e5e24b35;
 Tue, 03 Nov 2026 15:12:42 +0000
X-Mizu-Trace-ID: 4f81d5a8e5e24b35
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 120/227] net/gve: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:18 +0800
Message-ID: <20261103145306.487255-121-chengwen.feng@linux.dev>
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
 drivers/net/gve/base/gve_osdep.h |  2 +-
 drivers/net/gve/gve_ethdev.c     | 14 +++++++-------
 drivers/net/gve/gve_ethdev.h     |  8 ++++----
 drivers/net/gve/gve_rx.c         | 16 ++++++++--------
 drivers/net/gve/gve_rx_dqo.c     | 24 ++++++++++++------------
 drivers/net/gve/gve_tx.c         | 18 +++++++++---------
 drivers/net/gve/gve_tx_dqo.c     | 16 ++++++++--------
 7 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/net/gve/base/gve_osdep.h b/drivers/net/gve/base/gve_osdep.h
index 55629a0e1a..c9e3272881 100644
--- a/drivers/net/gve/base/gve_osdep.h
+++ b/drivers/net/gve/base/gve_osdep.h
@@ -184,7 +184,7 @@ gve_alloc_dma_mem(struct gve_dma_mem *mem, u64 size)
 
 	snprintf(z_name, sizeof(z_name), "gve_dma_%" PRIu64,
 		 rte_atomic_fetch_add_explicit(&gve_dma_memzone_id, 1, rte_memory_order_relaxed));
-	mz = rte_memzone_reserve_aligned(z_name, size, SOCKET_ID_ANY,
+	mz = rte_memzone_reserve_aligned(z_name, size, RTE_NUMA_ID_ANY,
 					 RTE_MEMZONE_IOVA_CONTIG,
 					 PAGE_SIZE);
 	if (!mz)
diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 8ee52fdd47..045692437e 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -32,7 +32,7 @@ gve_alloc_using_mz(const char *name, uint32_t num_pages)
 {
 	const struct rte_memzone *mz;
 	mz = rte_memzone_reserve_aligned(name, num_pages * PAGE_SIZE,
-					 rte_socket_id(),
+					 rte_numa_id(),
 					 RTE_MEMZONE_IOVA_CONTIG, PAGE_SIZE);
 	if (mz == NULL)
 		PMD_DRV_LOG(ERR, "Failed to alloc memzone %s.", name);
@@ -45,7 +45,7 @@ gve_alloc_using_malloc(void **bufs, uint32_t num_entries)
 	uint32_t i;
 
 	for (i = 0; i < num_entries; i++) {
-		bufs[i] = rte_malloc_socket(NULL, PAGE_SIZE, PAGE_SIZE, rte_socket_id());
+		bufs[i] = rte_malloc_numa(NULL, PAGE_SIZE, PAGE_SIZE, rte_numa_id());
 		if (bufs[i] == NULL) {
 			PMD_DRV_LOG(ERR, "Failed to malloc");
 			goto free_bufs;
@@ -339,7 +339,7 @@ gve_alloc_stats_report(struct gve_priv *priv,
 			priv->pci_dev->device.name);
 	priv->stats_report_mem = rte_memzone_reserve_aligned(z_name,
 			priv->stats_report_len,
-			rte_socket_id(),
+			rte_numa_id(),
 			RTE_MEMZONE_IOVA_CONTIG, PAGE_SIZE);
 
 	if (!priv->stats_report_mem)
@@ -629,7 +629,7 @@ gve_alloc_nic_ts_report(struct gve_priv *priv)
 	snprintf(z_name, sizeof(z_name), "gve_%s_nic_ts_report",
 		 priv->pci_dev->device.name);
 	priv->nic_ts_report_mz = rte_memzone_reserve_aligned(z_name,
-			sizeof(struct gve_nic_ts_report), rte_socket_id(),
+			sizeof(struct gve_nic_ts_report), rte_numa_id(),
 			RTE_MEMZONE_IOVA_CONTIG, PAGE_SIZE);
 
 	if (!priv->nic_ts_report_mz) {
@@ -886,7 +886,7 @@ gve_verify_driver_compatibility(struct gve_priv *priv)
 
 	driver_info_mem = rte_memzone_reserve_aligned("verify_driver_compatibility",
 			sizeof(struct gve_driver_info),
-			rte_socket_id(),
+			rte_numa_id(),
 			RTE_MEMZONE_IOVA_CONTIG, PAGE_SIZE);
 
 	if (driver_info_mem == NULL) {
@@ -1575,7 +1575,7 @@ gve_setup_device_resources(struct gve_priv *priv)
 	snprintf(z_name, sizeof(z_name), "gve_%s_cnt_arr", priv->pci_dev->device.name);
 	mz = rte_memzone_reserve_aligned(z_name,
 					 priv->num_event_counters * sizeof(*priv->cnt_array),
-					 rte_socket_id(), RTE_MEMZONE_IOVA_CONTIG,
+					 rte_numa_id(), RTE_MEMZONE_IOVA_CONTIG,
 					 PAGE_SIZE);
 	if (mz == NULL) {
 		PMD_DRV_LOG(ERR, "Could not alloc memzone for count array");
@@ -1587,7 +1587,7 @@ gve_setup_device_resources(struct gve_priv *priv)
 	snprintf(z_name, sizeof(z_name), "gve_%s_irqmz", priv->pci_dev->device.name);
 	mz = rte_memzone_reserve_aligned(z_name,
 					 sizeof(*priv->irq_dbs) * (priv->num_ntfy_blks),
-					 rte_socket_id(), RTE_MEMZONE_IOVA_CONTIG,
+					 rte_numa_id(), RTE_MEMZONE_IOVA_CONTIG,
 					 PAGE_SIZE);
 	if (mz == NULL) {
 		PMD_DRV_LOG(ERR, "Could not alloc memzone for irq_dbs");
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 3a8ddfbbb6..60375598c3 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -560,11 +560,11 @@ gve_clear_flow_subsystem_ok(struct gve_priv *priv)
 
 int
 gve_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id, uint16_t nb_desc,
-		   unsigned int socket_id, const struct rte_eth_rxconf *conf,
+		   unsigned int numa_id, const struct rte_eth_rxconf *conf,
 		   struct rte_mempool *pool);
 int
 gve_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id, uint16_t nb_desc,
-		   unsigned int socket_id, const struct rte_eth_txconf *conf);
+		   unsigned int numa_id, const struct rte_eth_txconf *conf);
 
 void
 gve_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
@@ -613,12 +613,12 @@ gve_teardown_queue_page_list(struct gve_priv *priv,
 
 int
 gve_rx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
-		       uint16_t nb_desc, unsigned int socket_id,
+		       uint16_t nb_desc, unsigned int numa_id,
 		       const struct rte_eth_rxconf *conf,
 		       struct rte_mempool *pool);
 int
 gve_tx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
-		       uint16_t nb_desc, unsigned int socket_id,
+		       uint16_t nb_desc, unsigned int numa_id,
 		       const struct rte_eth_txconf *conf);
 
 void
diff --git a/drivers/net/gve/gve_rx.c b/drivers/net/gve/gve_rx.c
index 31c187ca83..b21cd175be 100644
--- a/drivers/net/gve/gve_rx.c
+++ b/drivers/net/gve/gve_rx.c
@@ -324,7 +324,7 @@ gve_rx_buf_len_gqi(struct rte_mempool *pool)
 
 int
 gve_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
-		uint16_t nb_desc, unsigned int socket_id,
+		uint16_t nb_desc, unsigned int numa_id,
 		const struct rte_eth_rxconf *conf, struct rte_mempool *pool)
 {
 	struct gve_priv *hw = dev->data->dev_private;
@@ -361,10 +361,10 @@ gve_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
 	}
 
 	/* Allocate the RX queue data structure. */
-	rxq = rte_zmalloc_socket("gve rxq",
+	rxq = rte_zmalloc_numa("gve rxq",
 				 sizeof(struct gve_rx_queue),
 				 RTE_CACHE_LINE_SIZE,
-				 socket_id);
+				 numa_id);
 	if (!rxq) {
 		PMD_DRV_LOG(ERR, "Failed to allocate memory for rx queue structure");
 		err = -ENOMEM;
@@ -393,8 +393,8 @@ gve_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
 	rxq->scatter = !!(offloads & RTE_ETH_RX_OFFLOAD_SCATTER);
 
 	/* Allocate software ring */
-	rxq->sw_ring = rte_zmalloc_socket("gve rx sw ring", sizeof(struct rte_mbuf *) * nb_desc,
-					  RTE_CACHE_LINE_SIZE, socket_id);
+	rxq->sw_ring = rte_zmalloc_numa("gve rx sw ring", sizeof(struct rte_mbuf *) * nb_desc,
+					  RTE_CACHE_LINE_SIZE, numa_id);
 	if (!rxq->sw_ring) {
 		PMD_DRV_LOG(ERR, "Failed to allocate memory for SW RX ring");
 		err = -ENOMEM;
@@ -403,7 +403,7 @@ gve_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
 
 	mz = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_id,
 				      nb_desc * sizeof(struct gve_rx_desc),
-				      PAGE_SIZE, socket_id);
+				      PAGE_SIZE, numa_id);
 	if (mz == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to reserve DMA memory for RX");
 		err = -ENOMEM;
@@ -415,7 +415,7 @@ gve_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
 
 	mz = rte_eth_dma_zone_reserve(dev, "gve rx data ring", queue_id,
 				      sizeof(union gve_rx_data_slot) * nb_desc,
-				      PAGE_SIZE, socket_id);
+				      PAGE_SIZE, numa_id);
 	if (mz == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to allocate memory for RX data ring");
 		err = -ENOMEM;
@@ -439,7 +439,7 @@ gve_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
 
 	mz = rte_eth_dma_zone_reserve(dev, "rxq_res", queue_id,
 				      sizeof(struct gve_queue_resources),
-				      PAGE_SIZE, socket_id);
+				      PAGE_SIZE, numa_id);
 	if (mz == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to reserve DMA memory for RX resource");
 		err = -ENOMEM;
diff --git a/drivers/net/gve/gve_rx_dqo.c b/drivers/net/gve/gve_rx_dqo.c
index 03c62edee6..50e26af229 100644
--- a/drivers/net/gve/gve_rx_dqo.c
+++ b/drivers/net/gve/gve_rx_dqo.c
@@ -320,7 +320,7 @@ gve_reset_rx_ring_state_dqo(struct gve_rx_queue *rxq)
 
 int
 gve_rx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
-		       uint16_t nb_desc, unsigned int socket_id,
+		       uint16_t nb_desc, unsigned int numa_id,
 		       const struct rte_eth_rxconf *conf,
 		       struct rte_mempool *pool)
 {
@@ -338,10 +338,10 @@ gve_rx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 	}
 
 	/* Allocate the RX queue data structure. */
-	rxq = rte_zmalloc_socket("gve rxq",
+	rxq = rte_zmalloc_numa("gve rxq",
 				 sizeof(struct gve_rx_queue),
 				 RTE_CACHE_LINE_SIZE,
-				 socket_id);
+				 numa_id);
 	if (rxq == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to allocate memory for rx queue structure");
 		return -ENOMEM;
@@ -379,9 +379,9 @@ gve_rx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 			RTE_ALIGN_FLOOR(mbuf_len, GVE_RX_BUF_ALIGN_DQO));
 
 	/* Allocate software ring */
-	rxq->sw_ring = rte_zmalloc_socket("gve rx sw ring",
+	rxq->sw_ring = rte_zmalloc_numa("gve rx sw ring",
 					  nb_desc * sizeof(struct rte_mbuf *),
-					  RTE_CACHE_LINE_SIZE, socket_id);
+					  RTE_CACHE_LINE_SIZE, numa_id);
 	if (rxq->sw_ring == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to allocate memory for SW RX ring");
 		err = -ENOMEM;
@@ -389,9 +389,9 @@ gve_rx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 	}
 
 	/* Allocate completed bufs list */
-	rxq->completed_buf_list = rte_zmalloc_socket("gve completed buf list",
+	rxq->completed_buf_list = rte_zmalloc_numa("gve completed buf list",
 		nb_desc * sizeof(*rxq->completed_buf_list), RTE_CACHE_LINE_SIZE,
-		socket_id);
+		numa_id);
 	if (rxq->completed_buf_list == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to allocate completed buffer list.");
 		err = -ENOMEM;
@@ -399,9 +399,9 @@ gve_rx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 	}
 
 	/* Allocate buffer for reallocating mbufs */
-	rxq->refill_bufs = rte_zmalloc_socket("gve rx refill bufs",
+	rxq->refill_bufs = rte_zmalloc_numa("gve rx refill bufs",
 		nb_desc * sizeof(*rxq->refill_bufs), RTE_CACHE_LINE_SIZE,
-		socket_id);
+		numa_id);
 	if (rxq->refill_bufs == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to allocate rx refill bufs.");
 		err = -ENOMEM;
@@ -411,7 +411,7 @@ gve_rx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 	/* Allocate RX buffer queue */
 	mz = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_id,
 				      nb_desc * sizeof(struct gve_rx_desc_dqo),
-				      PAGE_SIZE, socket_id);
+				      PAGE_SIZE, numa_id);
 	if (mz == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to reserve DMA memory for RX buffer queue");
 		err = -ENOMEM;
@@ -424,7 +424,7 @@ gve_rx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 	/* Allocate RX completion queue */
 	mz = rte_eth_dma_zone_reserve(dev, "compl_ring", queue_id,
 				      nb_desc * sizeof(struct gve_rx_compl_desc_dqo),
-				      PAGE_SIZE, socket_id);
+				      PAGE_SIZE, numa_id);
 	if (mz == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to reserve DMA memory for RX completion queue");
 		err = -ENOMEM;
@@ -438,7 +438,7 @@ gve_rx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 
 	mz = rte_eth_dma_zone_reserve(dev, "rxq_res", queue_id,
 				      sizeof(struct gve_queue_resources),
-				      PAGE_SIZE, socket_id);
+				      PAGE_SIZE, numa_id);
 	if (mz == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to reserve DMA memory for RX resource");
 		err = -ENOMEM;
diff --git a/drivers/net/gve/gve_tx.c b/drivers/net/gve/gve_tx.c
index 279669165f..6cb31a0b80 100644
--- a/drivers/net/gve/gve_tx.c
+++ b/drivers/net/gve/gve_tx.c
@@ -561,7 +561,7 @@ gve_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 
 int
 gve_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id, uint16_t nb_desc,
-		   unsigned int socket_id, const struct rte_eth_txconf *conf)
+		   unsigned int numa_id, const struct rte_eth_txconf *conf)
 {
 	struct gve_priv *hw = dev->data->dev_private;
 	const struct rte_memzone *mz;
@@ -583,8 +583,8 @@ gve_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id, uint16_t nb_desc,
 	}
 
 	/* Allocate the TX queue data structure. */
-	txq = rte_zmalloc_socket("gve txq", sizeof(struct gve_tx_queue),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	txq = rte_zmalloc_numa("gve txq", sizeof(struct gve_tx_queue),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (!txq) {
 		PMD_DRV_LOG(ERR, "Failed to allocate memory for tx queue structure");
 		err = -ENOMEM;
@@ -609,9 +609,9 @@ gve_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id, uint16_t nb_desc,
 	txq->ntfy_addr = &hw->db_bar[rte_be_to_cpu_32(hw->irq_dbs[txq->ntfy_id].id)];
 
 	/* Allocate software ring */
-	txq->sw_ring = rte_zmalloc_socket("gve tx sw ring",
+	txq->sw_ring = rte_zmalloc_numa("gve tx sw ring",
 					  sizeof(struct rte_mbuf *) * nb_desc,
-					  RTE_CACHE_LINE_SIZE, socket_id);
+					  RTE_CACHE_LINE_SIZE, numa_id);
 	if (!txq->sw_ring) {
 		PMD_DRV_LOG(ERR, "Failed to allocate memory for SW TX ring");
 		err = -ENOMEM;
@@ -620,7 +620,7 @@ gve_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id, uint16_t nb_desc,
 
 	mz = rte_eth_dma_zone_reserve(dev, "tx_ring", queue_id,
 				      nb_desc * sizeof(union gve_tx_desc),
-				      PAGE_SIZE, socket_id);
+				      PAGE_SIZE, numa_id);
 	if (mz == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to reserve DMA memory for TX");
 		err = -ENOMEM;
@@ -632,9 +632,9 @@ gve_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id, uint16_t nb_desc,
 
 	/* QPL-specific allocations. */
 	if (txq->is_gqi_qpl) {
-		txq->iov_ring = rte_zmalloc_socket("gve tx iov ring",
+		txq->iov_ring = rte_zmalloc_numa("gve tx iov ring",
 						   sizeof(struct gve_tx_iovec) * nb_desc,
-						   RTE_CACHE_LINE_SIZE, socket_id);
+						   RTE_CACHE_LINE_SIZE, numa_id);
 		if (!txq->iov_ring) {
 			PMD_DRV_LOG(ERR, "Failed to allocate memory for SW TX ring");
 			err = -ENOMEM;
@@ -652,7 +652,7 @@ gve_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id, uint16_t nb_desc,
 	}
 
 	mz = rte_eth_dma_zone_reserve(dev, "txq_res", queue_id, sizeof(struct gve_queue_resources),
-				      PAGE_SIZE, socket_id);
+				      PAGE_SIZE, numa_id);
 	if (mz == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to reserve DMA memory for TX resource");
 		err = -ENOMEM;
diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 52fcdb285a..93a595188f 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -511,7 +511,7 @@ gve_reset_tx_ring_state_dqo(struct gve_tx_queue *txq)
 
 int
 gve_tx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
-		       uint16_t nb_desc, unsigned int socket_id,
+		       uint16_t nb_desc, unsigned int numa_id,
 		       const struct rte_eth_txconf *conf)
 {
 	struct gve_priv *hw = dev->data->dev_private;
@@ -529,9 +529,9 @@ gve_tx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 	}
 
 	/* Allocate the TX queue data structure. */
-	txq = rte_zmalloc_socket("gve txq",
+	txq = rte_zmalloc_numa("gve txq",
 				 sizeof(struct gve_tx_queue),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to allocate memory for tx queue structure");
 		return -ENOMEM;
@@ -557,9 +557,9 @@ gve_tx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 
 	/* Allocate software ring */
 	sw_size = nb_desc;
-	txq->pkt_ring_dqo = rte_zmalloc_socket("gve tx sw ring",
+	txq->pkt_ring_dqo = rte_zmalloc_numa("gve tx sw ring",
 					  sw_size * sizeof(struct gve_tx_pkt),
-					  RTE_CACHE_LINE_SIZE, socket_id);
+					  RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq->pkt_ring_dqo == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to allocate memory for SW TX ring");
 		err = -ENOMEM;
@@ -570,7 +570,7 @@ gve_tx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 	/* Allocate TX hardware ring descriptors. */
 	mz = rte_eth_dma_zone_reserve(dev, "tx_ring", queue_id,
 				      nb_desc * sizeof(union gve_tx_desc_dqo),
-				      PAGE_SIZE, socket_id);
+				      PAGE_SIZE, numa_id);
 	if (mz == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to reserve DMA memory for TX");
 		err = -ENOMEM;
@@ -583,7 +583,7 @@ gve_tx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 	/* Allocate TX completion ring descriptors. */
 	mz = rte_eth_dma_zone_reserve(dev, "tx_compl_ring", queue_id,
 				       txq->nb_complq_desc * sizeof(struct gve_tx_compl_desc),
-				      PAGE_SIZE, socket_id);
+				      PAGE_SIZE, numa_id);
 	if (mz == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to reserve DMA memory for TX completion queue");
 		err = -ENOMEM;
@@ -595,7 +595,7 @@ gve_tx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 
 	mz = rte_eth_dma_zone_reserve(dev, "txq_res", queue_id,
 				      sizeof(struct gve_queue_resources),
-				      PAGE_SIZE, socket_id);
+				      PAGE_SIZE, numa_id);
 	if (mz == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to reserve DMA memory for TX resource");
 		err = -ENOMEM;
-- 
2.55.0

