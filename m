Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22462606B257
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=riWJrAlO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7763B42EC9;
	Tue,  3 Nov 2026 16:15:40 +0100 (CET)
Received: from mta0.migadu.com (out-104.mta0.migadu.com [91.218.175.104])
 by mails.dpdk.org (Postfix) with ESMTPS id 0488642EC5
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:15:39 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=jzyXeqplhy78yKW3v4YyETK7bdRjN7L9mp1Bo354rN0=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718938; v=1; x=1794323738;
 b=riWJrAlOKyTjohVmrCNdZMX1cehZNw28YiTByrZ38hXFFQNrKS5WZAQTAK6+ElcA3JVGJG/O
 zSYAozU2Dz6EA/01A51DVx5epPwterLfPX7zW5s+ePdOnJ0ItDPytglKhTBeNWKaa/c+HZv8zjn
 OyrTuHbVt1z23to9NJQBkP3s=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 24d48d28ae13d26f;
 Tue, 03 Nov 2026 15:15:38 +0000
X-Mizu-Trace-ID: 24d48d28ae13d26f
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 142/227] net/qede: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:40 +0800
Message-ID: <20261103145306.487255-143-chengwen.feng@linux.dev>
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
 drivers/net/qede/base/bcm_osal.c | 12 +++----
 drivers/net/qede/qede_filter.c   |  2 +-
 drivers/net/qede/qede_rxtx.c     | 54 ++++++++++++++++----------------
 drivers/net/qede/qede_rxtx.h     |  4 +--
 4 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/net/qede/base/bcm_osal.c b/drivers/net/qede/base/bcm_osal.c
index abd11860b7..024c4b1f76 100644
--- a/drivers/net/qede/base/bcm_osal.c
+++ b/drivers/net/qede/base/bcm_osal.c
@@ -153,7 +153,7 @@ void *osal_dma_alloc_coherent(struct ecore_dev *p_dev,
 	const struct rte_memzone *mz;
 	char mz_name[RTE_MEMZONE_NAMESIZE];
 	uint32_t core_id = rte_lcore_id();
-	unsigned int socket_id;
+	unsigned int numa_id;
 
 	if (ecore_mz_count >= rte_memzone_max_get()) {
 		DP_ERR(p_dev, "Memzone allocation count exceeds %zu\n",
@@ -167,8 +167,8 @@ void *osal_dma_alloc_coherent(struct ecore_dev *p_dev,
 					(unsigned long)rte_get_timer_cycles());
 	if (core_id == (unsigned int)LCORE_ID_ANY)
 		core_id = rte_get_main_lcore();
-	socket_id = rte_lcore_to_socket_id(core_id);
-	mz = rte_memzone_reserve_aligned(mz_name, size, socket_id,
+	numa_id = rte_lcore_to_numa_id(core_id);
+	mz = rte_memzone_reserve_aligned(mz_name, size, numa_id,
 			RTE_MEMZONE_IOVA_CONTIG, RTE_CACHE_LINE_SIZE);
 	if (!mz) {
 		DP_ERR(p_dev, "Unable to allocate DMA memory "
@@ -192,7 +192,7 @@ void *osal_dma_alloc_coherent_aligned(struct ecore_dev *p_dev,
 	const struct rte_memzone *mz;
 	char mz_name[RTE_MEMZONE_NAMESIZE];
 	uint32_t core_id = rte_lcore_id();
-	unsigned int socket_id;
+	unsigned int numa_id;
 
 	if (ecore_mz_count >= rte_memzone_max_get()) {
 		DP_ERR(p_dev, "Memzone allocation count exceeds %zu\n",
@@ -206,8 +206,8 @@ void *osal_dma_alloc_coherent_aligned(struct ecore_dev *p_dev,
 					(unsigned long)rte_get_timer_cycles());
 	if (core_id == (unsigned int)LCORE_ID_ANY)
 		core_id = rte_get_main_lcore();
-	socket_id = rte_lcore_to_socket_id(core_id);
-	mz = rte_memzone_reserve_aligned(mz_name, size, socket_id,
+	numa_id = rte_lcore_to_numa_id(core_id);
+	mz = rte_memzone_reserve_aligned(mz_name, size, numa_id,
 			RTE_MEMZONE_IOVA_CONTIG, align);
 	if (!mz) {
 		DP_ERR(p_dev, "Unable to allocate DMA memory "
diff --git a/drivers/net/qede/qede_filter.c b/drivers/net/qede/qede_filter.c
index cecb58c997..82563085e3 100644
--- a/drivers/net/qede/qede_filter.c
+++ b/drivers/net/qede/qede_filter.c
@@ -199,7 +199,7 @@ qede_config_arfs_filter(struct rte_eth_dev *eth_dev,
 	snprintf(mz_name, sizeof(mz_name), "%lx",
 		 (unsigned long)rte_get_timer_cycles());
 	mz = rte_memzone_reserve_aligned(mz_name, QEDE_MAX_FDIR_PKT_LEN,
-					 SOCKET_ID_ANY, 0, RTE_CACHE_LINE_SIZE);
+					 RTE_NUMA_ID_ANY, 0, RTE_CACHE_LINE_SIZE);
 	if (!mz) {
 		DP_ERR(edev, "Failed to allocate memzone for fdir, err = %s\n",
 		       rte_strerror(rte_errno));
diff --git a/drivers/net/qede/qede_rxtx.c b/drivers/net/qede/qede_rxtx.c
index 25e28fd9f6..5ecca0c0b6 100644
--- a/drivers/net/qede/qede_rxtx.c
+++ b/drivers/net/qede/qede_rxtx.c
@@ -123,7 +123,7 @@ static struct qede_rx_queue *
 qede_alloc_rx_queue_mem(struct rte_eth_dev *dev,
 			uint16_t queue_idx,
 			uint16_t nb_desc,
-			unsigned int socket_id,
+			unsigned int numa_id,
 			struct rte_mempool *mp,
 			uint16_t bufsz)
 {
@@ -134,12 +134,12 @@ qede_alloc_rx_queue_mem(struct rte_eth_dev *dev,
 	int rc;
 
 	/* First allocate the rx queue data structure */
-	rxq = rte_zmalloc_socket("qede_rx_queue", sizeof(struct qede_rx_queue),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	rxq = rte_zmalloc_numa("qede_rx_queue", sizeof(struct qede_rx_queue),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 
 	if (!rxq) {
 		DP_ERR(edev, "Unable to allocate memory for rxq on socket %u",
-			  socket_id);
+			  numa_id);
 		return NULL;
 	}
 
@@ -157,11 +157,11 @@ qede_alloc_rx_queue_mem(struct rte_eth_dev *dev,
 
 	/* Allocate the parallel driver ring for Rx buffers */
 	size = sizeof(*rxq->sw_rx_ring) * rxq->nb_rx_desc;
-	rxq->sw_rx_ring = rte_zmalloc_socket("sw_rx_ring", size,
-					     RTE_CACHE_LINE_SIZE, socket_id);
+	rxq->sw_rx_ring = rte_zmalloc_numa("sw_rx_ring", size,
+					     RTE_CACHE_LINE_SIZE, numa_id);
 	if (!rxq->sw_rx_ring) {
 		DP_ERR(edev, "Memory allocation fails for sw_rx_ring on"
-		       " socket %u\n", socket_id);
+		       " socket %u\n", numa_id);
 		rte_free(rxq);
 		return NULL;
 	}
@@ -178,7 +178,7 @@ qede_alloc_rx_queue_mem(struct rte_eth_dev *dev,
 
 	if (rc != ECORE_SUCCESS) {
 		DP_ERR(edev, "Memory allocation fails for RX BD ring"
-		       " on socket %u\n", socket_id);
+		       " on socket %u\n", numa_id);
 		rte_free(rxq->sw_rx_ring);
 		rte_free(rxq);
 		return NULL;
@@ -196,7 +196,7 @@ qede_alloc_rx_queue_mem(struct rte_eth_dev *dev,
 
 	if (rc != ECORE_SUCCESS) {
 		DP_ERR(edev, "Memory allocation fails for RX CQE ring"
-		       " on socket %u\n", socket_id);
+		       " on socket %u\n", numa_id);
 		qdev->ops->common->chain_free(edev, &rxq->rx_bd_ring);
 		rte_free(rxq->sw_rx_ring);
 		rte_free(rxq);
@@ -208,7 +208,7 @@ qede_alloc_rx_queue_mem(struct rte_eth_dev *dev,
 
 int
 qede_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid,
-		    uint16_t nb_desc, unsigned int socket_id,
+		    uint16_t nb_desc, unsigned int numa_id,
 		    __rte_unused const struct rte_eth_rxconf *rx_conf,
 		    struct rte_mempool *mp)
 {
@@ -257,13 +257,13 @@ qede_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid,
 
 	if (ECORE_IS_CMT(edev)) {
 		rxq = qede_alloc_rx_queue_mem(dev, qid * 2, nb_desc,
-					      socket_id, mp, bufsz);
+					      numa_id, mp, bufsz);
 		if (!rxq)
 			return -ENOMEM;
 
 		qdev->fp_array[qid * 2].rxq = rxq;
 		rxq = qede_alloc_rx_queue_mem(dev, qid * 2 + 1, nb_desc,
-					      socket_id, mp, bufsz);
+					      numa_id, mp, bufsz);
 		if (!rxq)
 			return -ENOMEM;
 
@@ -272,7 +272,7 @@ qede_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid,
 		dev->data->rx_queues[qid] = &qdev->fp_array_cmt[qid];
 	} else {
 		rxq = qede_alloc_rx_queue_mem(dev, qid, nb_desc,
-					      socket_id, mp, bufsz);
+					      numa_id, mp, bufsz);
 		if (!rxq)
 			return -ENOMEM;
 
@@ -281,7 +281,7 @@ qede_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid,
 	}
 
 	DP_INFO(edev, "rxq %d num_desc %u rx_buf_size=%u socket %u\n",
-		  qid, nb_desc, rxq->rx_buf_size, socket_id);
+		  qid, nb_desc, rxq->rx_buf_size, numa_id);
 
 	return 0;
 }
@@ -381,7 +381,7 @@ static struct qede_tx_queue *
 qede_alloc_tx_queue_mem(struct rte_eth_dev *dev,
 			uint16_t queue_idx,
 			uint16_t nb_desc,
-			unsigned int socket_id,
+			unsigned int numa_id,
 			const struct rte_eth_txconf *tx_conf)
 {
 	struct qede_dev *qdev = dev->data->dev_private;
@@ -390,13 +390,13 @@ qede_alloc_tx_queue_mem(struct rte_eth_dev *dev,
 	int rc;
 	size_t sw_tx_ring_size;
 
-	txq = rte_zmalloc_socket("qede_tx_queue", sizeof(struct qede_tx_queue),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	txq = rte_zmalloc_numa("qede_tx_queue", sizeof(struct qede_tx_queue),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 
 	if (txq == NULL) {
 		DP_ERR(edev,
 		       "Unable to allocate memory for txq on socket %u",
-		       socket_id);
+		       numa_id);
 		return NULL;
 	}
 
@@ -415,21 +415,21 @@ qede_alloc_tx_queue_mem(struct rte_eth_dev *dev,
 	if (rc != ECORE_SUCCESS) {
 		DP_ERR(edev,
 		       "Unable to allocate memory for txbd ring on socket %u",
-		       socket_id);
+		       numa_id);
 		qede_tx_queue_release(txq);
 		return NULL;
 	}
 
 	/* Allocate software ring */
 	sw_tx_ring_size = sizeof(txq->sw_tx_ring) * txq->nb_tx_desc;
-	txq->sw_tx_ring = rte_zmalloc_socket("txq->sw_tx_ring",
+	txq->sw_tx_ring = rte_zmalloc_numa("txq->sw_tx_ring",
 					     sw_tx_ring_size,
-					     RTE_CACHE_LINE_SIZE, socket_id);
+					     RTE_CACHE_LINE_SIZE, numa_id);
 
 	if (!txq->sw_tx_ring) {
 		DP_ERR(edev,
 		       "Unable to allocate memory for txbd ring on socket %u",
-		       socket_id);
+		       numa_id);
 		qdev->ops->common->chain_free(edev, &txq->tx_pbl);
 		qede_tx_queue_release(txq);
 		return NULL;
@@ -445,7 +445,7 @@ qede_alloc_tx_queue_mem(struct rte_eth_dev *dev,
 
 	DP_INFO(edev,
 		  "txq %u num_desc %u tx_free_thresh %u socket %u\n",
-		  queue_idx, nb_desc, txq->tx_free_thresh, socket_id);
+		  queue_idx, nb_desc, txq->tx_free_thresh, numa_id);
 	return txq;
 }
 
@@ -453,7 +453,7 @@ int
 qede_tx_queue_setup(struct rte_eth_dev *dev,
 		    uint16_t queue_idx,
 		    uint16_t nb_desc,
-		    unsigned int socket_id,
+		    unsigned int numa_id,
 		    const struct rte_eth_txconf *tx_conf)
 {
 	struct qede_dev *qdev = dev->data->dev_private;
@@ -476,13 +476,13 @@ qede_tx_queue_setup(struct rte_eth_dev *dev,
 
 	if (ECORE_IS_CMT(edev)) {
 		txq = qede_alloc_tx_queue_mem(dev, queue_idx * 2, nb_desc,
-					      socket_id, tx_conf);
+					      numa_id, tx_conf);
 		if (!txq)
 			return -ENOMEM;
 
 		qdev->fp_array[queue_idx * 2].txq = txq;
 		txq = qede_alloc_tx_queue_mem(dev, (queue_idx * 2) + 1, nb_desc,
-					      socket_id, tx_conf);
+					      numa_id, tx_conf);
 		if (!txq)
 			return -ENOMEM;
 
@@ -491,7 +491,7 @@ qede_tx_queue_setup(struct rte_eth_dev *dev,
 					&qdev->fp_array_cmt[queue_idx];
 	} else {
 		txq = qede_alloc_tx_queue_mem(dev, queue_idx, nb_desc,
-					      socket_id, tx_conf);
+					      numa_id, tx_conf);
 		if (!txq)
 			return -ENOMEM;
 
diff --git a/drivers/net/qede/qede_rxtx.h b/drivers/net/qede/qede_rxtx.h
index 013a4a07c7..54b35deca4 100644
--- a/drivers/net/qede/qede_rxtx.h
+++ b/drivers/net/qede/qede_rxtx.h
@@ -241,14 +241,14 @@ struct qede_fastpath_cmt {
  * RX/TX function prototypes
  */
 int qede_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
-			uint16_t nb_desc, unsigned int socket_id,
+			uint16_t nb_desc, unsigned int numa_id,
 			const struct rte_eth_rxconf *rx_conf,
 			struct rte_mempool *mp);
 
 int qede_tx_queue_setup(struct rte_eth_dev *dev,
 			uint16_t queue_idx,
 			uint16_t nb_desc,
-			unsigned int socket_id,
+			unsigned int numa_id,
 			const struct rte_eth_txconf *tx_conf);
 
 void qede_rx_queue_release(void *rx_queue);
-- 
2.55.0

