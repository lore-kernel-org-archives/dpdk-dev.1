Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF29606A33C
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=J+l7/pSp
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C25CA42E7D;
	Tue,  3 Nov 2026 16:12:58 +0100 (CET)
Received: from mta0.migadu.com (out-2.mta0.migadu.com [91.218.175.2])
 by mails.dpdk.org (Postfix) with ESMTPS id D253142E7D
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:12:57 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=Ak3BRmh7Mo5zreREa1BrlhM+vLoThB2xQpyxn4odJ0Q=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718777; v=1; x=1794323577;
 b=J+l7/pSpVcMwTADynKHK13n/Mi0EiSvBOdYvnxsrQooBmpt2oZADiqwq4i9oztG++4R7vaBc
 v3Rka65H5tOjbarWMpnBNDtQPe01PRjVWPf9/mZ/ygQvYC3laxA3FXUQVucOUJt810B22yIbztA
 ZdnOcU6VsN6bcJZ5pYYHuBH8=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id adae79174b85dbc2;
 Tue, 03 Nov 2026 15:12:57 +0000
X-Mizu-Trace-ID: adae79174b85dbc2
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 122/227] net/hinic3: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:20 +0800
Message-ID: <20261103145306.487255-123-chengwen.feng@linux.dev>
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
 drivers/net/hinic3/base/hinic3_cmdq.c  |  2 +-
 drivers/net/hinic3/base/hinic3_eqs.c   |  2 +-
 drivers/net/hinic3/base/hinic3_hwdev.c |  4 +--
 drivers/net/hinic3/base/hinic3_hwdev.h |  2 +-
 drivers/net/hinic3/base/hinic3_mbox.c  |  4 +--
 drivers/net/hinic3/base/hinic3_wq.c    |  2 +-
 drivers/net/hinic3/hinic3_ethdev.c     | 38 +++++++++++++-------------
 7 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/net/hinic3/base/hinic3_cmdq.c b/drivers/net/hinic3/base/hinic3_cmdq.c
index 9c27c6f54c..42eee08570 100644
--- a/drivers/net/hinic3/base/hinic3_cmdq.c
+++ b/drivers/net/hinic3/base/hinic3_cmdq.c
@@ -743,7 +743,7 @@ hinic3_cmdq_init(struct hinic3_hwdev *hwdev)
 
 	cmdqs->cmd_buf_pool = rte_pktmbuf_pool_create(cmdq_pool_name,
 		HINIC3_CMDQ_DEPTH * HINIC3_MAX_CMDQ_TYPES, 0, 0,
-		HINIC3_CMDQ_BUF_SIZE, (int)rte_socket_id());
+		HINIC3_CMDQ_BUF_SIZE, (int)rte_numa_id());
 	if (!cmdqs->cmd_buf_pool) {
 		PMD_DRV_LOG(ERR, "Create cmdq buffer pool failed");
 		err = -ENOMEM;
diff --git a/drivers/net/hinic3/base/hinic3_eqs.c b/drivers/net/hinic3/base/hinic3_eqs.c
index 1fc78adc85..23fcf7e1cc 100644
--- a/drivers/net/hinic3/base/hinic3_eqs.c
+++ b/drivers/net/hinic3/base/hinic3_eqs.c
@@ -248,7 +248,7 @@ set_eq_pages(struct hinic3_eq *eq)
 		/* Allocate memory for each page. */
 		eq->eq_mz[pg_num] = hinic3_dma_zone_reserve(eq->hwdev->eth_dev,
 			"eq_mz", eq->q_id, eq->page_size,
-			eq->page_size, SOCKET_ID_ANY);
+			eq->page_size, RTE_NUMA_ID_ANY);
 		if (!eq->eq_mz[pg_num]) {
 			err = -ENOMEM;
 			goto dma_alloc_err;
diff --git a/drivers/net/hinic3/base/hinic3_hwdev.c b/drivers/net/hinic3/base/hinic3_hwdev.c
index 9406b6cff2..0ee1f7552b 100644
--- a/drivers/net/hinic3/base/hinic3_hwdev.c
+++ b/drivers/net/hinic3/base/hinic3_hwdev.c
@@ -546,9 +546,9 @@ hinic3_free_hwdev(struct hinic3_hwdev *hwdev)
 
 const struct rte_memzone *
 hinic3_dma_zone_reserve(const struct rte_eth_dev *dev, const char *ring_name,
-			uint16_t queue_id, size_t size, unsigned int align, int socket_id)
+			uint16_t queue_id, size_t size, unsigned int align, int numa_id)
 {
-	return rte_eth_dma_zone_reserve(dev, ring_name, queue_id, size, align, socket_id);
+	return rte_eth_dma_zone_reserve(dev, ring_name, queue_id, size, align, numa_id);
 }
 
 int
diff --git a/drivers/net/hinic3/base/hinic3_hwdev.h b/drivers/net/hinic3/base/hinic3_hwdev.h
index c6661aa1a6..602b106ee1 100644
--- a/drivers/net/hinic3/base/hinic3_hwdev.h
+++ b/drivers/net/hinic3/base/hinic3_hwdev.h
@@ -177,7 +177,7 @@ void hinic3_free_hwdev(struct hinic3_hwdev *hwdev);
 
 const struct rte_memzone *
 hinic3_dma_zone_reserve(const struct rte_eth_dev *dev, const char *ring_name,
-			uint16_t queue_id, size_t size, unsigned int align, int socket_id);
+			uint16_t queue_id, size_t size, unsigned int align, int numa_id);
 
 int hinic3_memzone_free(const struct rte_memzone *mz);
 
diff --git a/drivers/net/hinic3/base/hinic3_mbox.c b/drivers/net/hinic3/base/hinic3_mbox.c
index c4ca2ed7ba..c166d7d7f2 100644
--- a/drivers/net/hinic3/base/hinic3_mbox.c
+++ b/drivers/net/hinic3/base/hinic3_mbox.c
@@ -1054,7 +1054,7 @@ alloc_mbox_wb_status(struct hinic3_mbox *func_to_func)
 	/* Reserved DMA area. */
 	send_mbox->wb_mz = hinic3_dma_zone_reserve(hwdev->eth_dev,
 		"wb_mz", 0, MBOX_WB_STATUS_LEN,
-		RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+		RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	if (!send_mbox->wb_mz)
 		return -ENOMEM;
 
@@ -1091,7 +1091,7 @@ alloc_mbox_tlp_buffer(struct hinic3_mbox *func_to_func)
 	struct hinic3_hwdev *hwdev = func_to_func->hwdev;
 
 	send_mbox->sbuff_mz = hinic3_dma_zone_reserve(hwdev->eth_dev, "sbuff_mz",
-			0, MBOX_MAX_BUF_SZ, MBOX_MAX_BUF_SZ, SOCKET_ID_ANY);
+			0, MBOX_MAX_BUF_SZ, MBOX_MAX_BUF_SZ, RTE_NUMA_ID_ANY);
 	if (!send_mbox->sbuff_mz)
 		return -ENOMEM;
 
diff --git a/drivers/net/hinic3/base/hinic3_wq.c b/drivers/net/hinic3/base/hinic3_wq.c
index cce22e672f..d76668678d 100644
--- a/drivers/net/hinic3/base/hinic3_wq.c
+++ b/drivers/net/hinic3/base/hinic3_wq.c
@@ -21,7 +21,7 @@ alloc_wq_pages(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq, int qid)
 	const struct rte_memzone *wq_mz;
 
 	wq_mz = hinic3_dma_zone_reserve(hwdev->eth_dev, "hinic3_wq_mz",
-					qid, wq->wq_buf_size, RTE_PGSIZE_256K, SOCKET_ID_ANY);
+					qid, wq->wq_buf_size, RTE_PGSIZE_256K, RTE_NUMA_ID_ANY);
 	if (!wq_mz) {
 		PMD_DRV_LOG(ERR, "Allocate wq[%d] rq_mz failed", qid);
 		return -ENOMEM;
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index eb5ddd9de6..cf28bb7292 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -573,7 +573,7 @@ hinic3_copy_mempool_init(struct hinic3_nic_dev *nic_dev)
 	if (nic_dev->cpy_mpool == NULL) {
 		nic_dev->cpy_mpool = rte_pktmbuf_pool_create(HINCI3_CPY_MEMPOOL_NAME,
 			HINIC3_COPY_MEMPOOL_DEPTH, HINIC3_COPY_MEMPOOL_CACHE,
-			0, HINIC3_COPY_MBUF_SIZE, rte_socket_id());
+			0, HINIC3_COPY_MBUF_SIZE, rte_numa_id());
 		if (nic_dev->cpy_mpool == NULL) {
 			PMD_DRV_LOG(ERR,
 				    "Create copy mempool failed, errno: %d, dev_name: %s",
@@ -923,7 +923,7 @@ hinic3_reset_tx_queue(struct rte_eth_dev *dev)
  * Receive queue index.
  * @param[in] nb_desc
  * Number of descriptors for receive queue.
- * @param[in] socket_id
+ * @param[in] numa_id
  * Socket index on which memory must be allocated.
  * @param[in] rx_conf
  * Thresholds parameters (unused_).
@@ -935,7 +935,7 @@ hinic3_reset_tx_queue(struct rte_eth_dev *dev)
  */
 static int
 hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
-		      unsigned int socket_id, const struct rte_eth_rxconf *rx_conf,
+		      unsigned int numa_id, const struct rte_eth_rxconf *rx_conf,
 		      struct rte_mempool *mp)
 {
 	struct hinic3_nic_dev *nic_dev;
@@ -999,8 +999,8 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 		return -EINVAL;
 	}
 
-	rxq = rte_zmalloc_socket("hinic3_rq", sizeof(struct hinic3_rxq),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	rxq = rte_zmalloc_numa("hinic3_rq", sizeof(struct hinic3_rxq),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (!rxq) {
 		PMD_DRV_LOG(ERR, "Allocate rxq[%d] failed, dev_name: %s", qid,
 			    dev->data->name);
@@ -1048,7 +1048,7 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 	rxq->rx_buff_shift = rte_log2_u32(rxq->buf_len);
 
 	pi_mz = hinic3_dma_zone_reserve(dev, "hinic3_rq_pi", qid, RTE_PGSIZE_4K,
-					RTE_CACHE_LINE_SIZE, socket_id);
+					RTE_CACHE_LINE_SIZE, numa_id);
 	if (!pi_mz) {
 		PMD_DRV_LOG(ERR, "Allocate rxq[%d] pi_mz failed, dev_name: %s",
 			    qid, dev->data->name);
@@ -1068,7 +1068,7 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 
 	queue_buf_size = RTE_BIT32(rxq->wqebb_shift) * rq_depth;
 	rq_mz = hinic3_dma_zone_reserve(dev, "hinic3_rq_mz", qid,
-					queue_buf_size, RTE_PGSIZE_256K, socket_id);
+					queue_buf_size, RTE_PGSIZE_256K, numa_id);
 	if (!rq_mz) {
 		PMD_DRV_LOG(ERR, "Allocate rxq[%d] rq_mz failed, dev_name: %s",
 			    qid, dev->data->name);
@@ -1081,9 +1081,9 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 	rxq->queue_buf_paddr = rq_mz->iova;
 	rxq->queue_buf_vaddr = rq_mz->addr;
 
-	rxq->rx_info = rte_zmalloc_socket("rx_info",
+	rxq->rx_info = rte_zmalloc_numa("rx_info",
 					  rq_depth * sizeof(*rxq->rx_info),
-					  RTE_CACHE_LINE_SIZE, socket_id);
+					  RTE_CACHE_LINE_SIZE, numa_id);
 	if (!rxq->rx_info) {
 		PMD_DRV_LOG(ERR, "Allocate rx_info failed, dev_name: %s",
 			    dev->data->name);
@@ -1094,7 +1094,7 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev)) {
 		ci_mz = hinic3_dma_zone_reserve(dev, "hinic3_ci_mz", qid,
 						sizeof(*rxq->rq_ci),
-						RTE_CACHE_LINE_SIZE, (int)socket_id);
+						RTE_CACHE_LINE_SIZE, (int)numa_id);
 
 		if (!ci_mz) {
 			PMD_DRV_LOG(ERR, "Allocate ci mem zone failed, dev_name: %s",
@@ -1110,7 +1110,7 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 	} else {
 		cqe_mz = hinic3_dma_zone_reserve(dev, "hinic3_cqe_mz", qid,
 						 rq_depth * sizeof(*rxq->rx_cqe),
-						 RTE_CACHE_LINE_SIZE, socket_id);
+						 RTE_CACHE_LINE_SIZE, numa_id);
 		if (!cqe_mz) {
 			PMD_DRV_LOG(ERR, "Allocate cqe mem zone failed, dev_name: %s",
 			dev->data->name);
@@ -1163,7 +1163,7 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
  * Transmit queue index.
  * @param[in] nb_desc
  * Number of descriptors for transmit queue.
- * @param[in] socket_id
+ * @param[in] numa_id
  * Socket index on which memory must be allocated.
  * @param[in] tx_conf
  * Tx queue configuration parameters (unused_).
@@ -1173,7 +1173,7 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
  */
 static int
 hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
-		      unsigned int socket_id, const struct rte_eth_txconf *tx_conf)
+		      unsigned int numa_id, const struct rte_eth_txconf *tx_conf)
 {
 	struct hinic3_nic_dev *nic_dev;
 	struct hinic3_hwdev *hwdev;
@@ -1226,8 +1226,8 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 		return -EINVAL;
 	}
 
-	txq = rte_zmalloc_socket("hinic3_tx_queue", sizeof(struct hinic3_txq),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	txq = rte_zmalloc_numa("hinic3_tx_queue", sizeof(struct hinic3_txq),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (!txq) {
 		PMD_DRV_LOG(ERR, "Allocate txq[%d] failed, dev_name: %s", qid,
 			    dev->data->name);
@@ -1248,7 +1248,7 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 
 	ci_mz = hinic3_dma_zone_reserve(dev, "hinic3_sq_ci", qid,
 					HINIC3_CI_Q_ADDR_SIZE,
-					HINIC3_CI_Q_ADDR_SIZE, socket_id);
+					HINIC3_CI_Q_ADDR_SIZE, numa_id);
 	if (!ci_mz) {
 		PMD_DRV_LOG(ERR, "Allocate txq[%d] ci_mz failed, dev_name: %s",
 			    qid, dev->data->name);
@@ -1261,7 +1261,7 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 
 	queue_buf_size = RTE_BIT32(txq->wqebb_shift) * sq_depth;
 	sq_mz = hinic3_dma_zone_reserve(dev, "hinic3_sq_mz", qid,
-					queue_buf_size, RTE_PGSIZE_256K, socket_id);
+					queue_buf_size, RTE_PGSIZE_256K, numa_id);
 	if (!sq_mz) {
 		PMD_DRV_LOG(ERR, "Allocate txq[%d] sq_mz failed, dev_name: %s",
 			    qid, dev->data->name);
@@ -1282,9 +1282,9 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 	}
 	txq->db_addr = db_addr;
 
-	txq->tx_info = rte_zmalloc_socket("tx_info",
+	txq->tx_info = rte_zmalloc_numa("tx_info",
 					  sq_depth * sizeof(*txq->tx_info),
-					  RTE_CACHE_LINE_SIZE, socket_id);
+					  RTE_CACHE_LINE_SIZE, numa_id);
 	if (!txq->tx_info) {
 		PMD_DRV_LOG(ERR, "Allocate tx_info failed, dev_name: %s",
 			    dev->data->name);
-- 
2.55.0

