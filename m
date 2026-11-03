Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8344606F61D
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Aqr20Io7
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA3F7427D7;
	Tue,  3 Nov 2026 16:11:42 +0100 (CET)
Received: from mta0.migadu.com (out-225.mta0.migadu.com [91.218.175.225])
 by mails.dpdk.org (Postfix) with ESMTPS id 42D6342E5E
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:11:41 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=WYmkB9vJi9550mTphh+9jF02GLo4H2EijDU8rgGkbSE=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718701; v=1; x=1794323501;
 b=Aqr20Io7Z/6r6SX/gafLTTIVIw5BknbEnJPSvFLwVxU2kOqyNmAWZaTPuw/4dDBu9Bjjk8Jw
 AsZSquL9+D0Fa2xZXilEcM7VkYie6oB769vpDuZnV3hzNOMS/HqxCQU9YFskrpPx173CdFhu/vA
 eCdQ3u7KB3XeYbXb+0o94IFU=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 4649fd2d1527bad6;
 Tue, 03 Nov 2026 15:11:41 +0000
X-Mizu-Trace-ID: 4649fd2d1527bad6
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 115/227] net/ena: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:13 +0800
Message-ID: <20261103145306.487255-116-chengwen.feng@linux.dev>
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
 drivers/net/ena/base/ena_plat_dpdk.h |  6 ++--
 drivers/net/ena/ena_ethdev.c         | 42 ++++++++++++++--------------
 drivers/net/ena/ena_ethdev.h         |  2 +-
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ena/base/ena_plat_dpdk.h b/drivers/net/ena/base/ena_plat_dpdk.h
index 4a6d53d0a2..066cd11885 100644
--- a/drivers/net/ena/base/ena_plat_dpdk.h
+++ b/drivers/net/ena/base/ena_plat_dpdk.h
@@ -215,7 +215,7 @@ typedef struct {
 
 const struct rte_memzone *
 ena_mem_alloc_coherent(struct rte_eth_dev_data *data, size_t size,
-		       int socket_id, unsigned int alignment, void **virt_addr,
+		       int numa_id, unsigned int alignment, void **virt_addr,
 		       dma_addr_t *phys_addr);
 
 #define ENA_MEM_ALLOC_COHERENT_ALIGNED(					       \
@@ -224,7 +224,7 @@ ena_mem_alloc_coherent(struct rte_eth_dev_data *data, size_t size,
 		void *virt_addr;					       \
 		dma_addr_t phys_addr;					       \
 		(mem_handle) = ena_mem_alloc_coherent((dmadev), (size),	       \
-			SOCKET_ID_ANY, (alignment), &virt_addr, &phys_addr);   \
+			RTE_NUMA_ID_ANY, (alignment), &virt_addr, &phys_addr);   \
 		(virt) = virt_addr;					       \
 		(phys) = phys_addr;					       \
 	} while (0)
@@ -252,7 +252,7 @@ ena_mem_alloc_coherent(struct rte_eth_dev_data *data, size_t size,
 #define ENA_MEM_ALLOC_NODE(dmadev, size, virt, node)				\
 	do {								       \
 		ENA_TOUCH(dmadev);						\
-		virt = rte_zmalloc_socket(NULL, size, 0, node);		       \
+		virt = rte_zmalloc_numa(NULL, size, 0, node);		       \
 	} while (0)
 
 #define ENA_MEM_ALLOC(dmadev, size) rte_zmalloc(NULL, size, 1)
diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index c2d0194e51..8b65b244eb 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -245,10 +245,10 @@ static uint16_t eth_ena_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 static uint16_t eth_ena_prep_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		uint16_t nb_pkts);
 static int ena_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
-			      uint16_t nb_desc, unsigned int socket_id,
+			      uint16_t nb_desc, unsigned int numa_id,
 			      const struct rte_eth_txconf *tx_conf);
 static int ena_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
-			      uint16_t nb_desc, unsigned int socket_id,
+			      uint16_t nb_desc, unsigned int numa_id,
 			      const struct rte_eth_rxconf *rx_conf,
 			      struct rte_mempool *mp);
 static inline void ena_init_rx_mbuf(struct rte_mbuf *mbuf, uint16_t len);
@@ -1516,7 +1516,7 @@ static int ena_create_io_queue(struct rte_eth_dev *dev, struct ena_ring *ring)
 	}
 	ctx.queue_size = ring->ring_size;
 	ctx.qid = ena_qid;
-	ctx.numa_node = ring->numa_socket_id;
+	ctx.numa_node = ring->numa_id;
 
 	rc = ena_com_create_io_queue(ena_dev, &ctx);
 	if (rc) {
@@ -1621,7 +1621,7 @@ static int ena_queue_start(struct rte_eth_dev *dev, struct ena_ring *ring)
 static int ena_tx_queue_setup(struct rte_eth_dev *dev,
 			      uint16_t queue_idx,
 			      uint16_t nb_desc,
-			      unsigned int socket_id,
+			      unsigned int numa_id,
 			      const struct rte_eth_txconf *tx_conf)
 {
 	struct ena_ring *txq = NULL;
@@ -1657,24 +1657,24 @@ static int ena_tx_queue_setup(struct rte_eth_dev *dev,
 	txq->next_to_use = 0;
 	txq->ring_size = nb_desc;
 	txq->size_mask = nb_desc - 1;
-	txq->numa_socket_id = socket_id;
+	txq->numa_id = numa_id;
 	txq->pkts_without_db = false;
 	txq->last_cleanup_ticks = 0;
 
-	txq->tx_buffer_info = rte_zmalloc_socket("txq->tx_buffer_info",
+	txq->tx_buffer_info = rte_zmalloc_numa("txq->tx_buffer_info",
 		sizeof(struct ena_tx_buffer) * txq->ring_size,
 		RTE_CACHE_LINE_SIZE,
-		socket_id);
+		numa_id);
 	if (!txq->tx_buffer_info) {
 		PMD_DRV_LOG_LINE(ERR,
 			"Failed to allocate memory for Tx buffer info");
 		return -ENOMEM;
 	}
 
-	txq->empty_tx_reqs = rte_zmalloc_socket("txq->empty_tx_reqs",
+	txq->empty_tx_reqs = rte_zmalloc_numa("txq->empty_tx_reqs",
 		sizeof(uint16_t) * txq->ring_size,
 		RTE_CACHE_LINE_SIZE,
-		socket_id);
+		numa_id);
 	if (!txq->empty_tx_reqs) {
 		PMD_DRV_LOG_LINE(ERR,
 			"Failed to allocate memory for empty Tx requests");
@@ -1683,10 +1683,10 @@ static int ena_tx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	txq->push_buf_intermediate_buf =
-		rte_zmalloc_socket("txq->push_buf_intermediate_buf",
+		rte_zmalloc_numa("txq->push_buf_intermediate_buf",
 			txq->tx_max_header_size,
 			RTE_CACHE_LINE_SIZE,
-			socket_id);
+			numa_id);
 	if (!txq->push_buf_intermediate_buf) {
 		PMD_DRV_LOG_LINE(ERR, "Failed to alloc push buffer for LLQ");
 		rte_free(txq->tx_buffer_info);
@@ -1722,7 +1722,7 @@ static int ena_tx_queue_setup(struct rte_eth_dev *dev,
 static int ena_rx_queue_setup(struct rte_eth_dev *dev,
 			      uint16_t queue_idx,
 			      uint16_t nb_desc,
-			      unsigned int socket_id,
+			      unsigned int numa_id,
 			      const struct rte_eth_rxconf *rx_conf,
 			      struct rte_mempool *mp)
 {
@@ -1768,23 +1768,23 @@ static int ena_rx_queue_setup(struct rte_eth_dev *dev,
 	rxq->next_to_use = 0;
 	rxq->ring_size = nb_desc;
 	rxq->size_mask = nb_desc - 1;
-	rxq->numa_socket_id = socket_id;
+	rxq->numa_id = numa_id;
 	rxq->mb_pool = mp;
 
-	rxq->rx_buffer_info = rte_zmalloc_socket("rxq->buffer_info",
+	rxq->rx_buffer_info = rte_zmalloc_numa("rxq->buffer_info",
 		sizeof(struct ena_rx_buffer) * nb_desc,
 		RTE_CACHE_LINE_SIZE,
-		socket_id);
+		numa_id);
 	if (!rxq->rx_buffer_info) {
 		PMD_DRV_LOG_LINE(ERR,
 			"Failed to allocate memory for Rx buffer info");
 		return -ENOMEM;
 	}
 
-	rxq->rx_refill_buffer = rte_zmalloc_socket("rxq->rx_refill_buffer",
+	rxq->rx_refill_buffer = rte_zmalloc_numa("rxq->rx_refill_buffer",
 		sizeof(struct rte_mbuf *) * nb_desc,
 		RTE_CACHE_LINE_SIZE,
-		socket_id);
+		numa_id);
 	if (!rxq->rx_refill_buffer) {
 		PMD_DRV_LOG_LINE(ERR,
 			"Failed to allocate memory for Rx refill buffer");
@@ -1793,10 +1793,10 @@ static int ena_rx_queue_setup(struct rte_eth_dev *dev,
 		return -ENOMEM;
 	}
 
-	rxq->empty_rx_reqs = rte_zmalloc_socket("rxq->empty_rx_reqs",
+	rxq->empty_rx_reqs = rte_zmalloc_numa("rxq->empty_rx_reqs",
 		sizeof(uint16_t) * nb_desc,
 		RTE_CACHE_LINE_SIZE,
-		socket_id);
+		numa_id);
 	if (!rxq->empty_rx_reqs) {
 		PMD_DRV_LOG_LINE(ERR,
 			"Failed to allocate memory for empty Rx requests");
@@ -4111,7 +4111,7 @@ int ena_mp_indirect_table_get(struct ena_adapter *adapter,
 
 const struct rte_memzone *
 ena_mem_alloc_coherent(struct rte_eth_dev_data *data, size_t size,
-		       int socket_id, unsigned int alignment, void **virt_addr,
+		       int numa_id, unsigned int alignment, void **virt_addr,
 		       dma_addr_t *phys_addr)
 {
 	char z_name[RTE_MEMZONE_NAMESIZE];
@@ -4129,7 +4129,7 @@ ena_mem_alloc_coherent(struct rte_eth_dev_data *data, size_t size,
 	}
 	adapter->memzone_cnt++;
 
-	memzone = rte_memzone_reserve_aligned(z_name, size, socket_id,
+	memzone = rte_memzone_reserve_aligned(z_name, size, numa_id,
 		RTE_MEMZONE_IOVA_CONTIG, alignment);
 	if (memzone == NULL) {
 		PMD_DRV_LOG_LINE(ERR, "Failed to allocate ena_com memzone: %s",
diff --git a/drivers/net/ena/ena_ethdev.h b/drivers/net/ena/ena_ethdev.h
index b204b07767..fa0b147ff1 100644
--- a/drivers/net/ena/ena_ethdev.h
+++ b/drivers/net/ena/ena_ethdev.h
@@ -206,7 +206,7 @@ struct __rte_cache_aligned ena_ring {
 		struct ena_stats_tx tx_stats;
 	};
 
-	unsigned int numa_socket_id;
+	unsigned int numa_id;
 
 	uint32_t missing_tx_completion_threshold;
 
-- 
2.55.0

