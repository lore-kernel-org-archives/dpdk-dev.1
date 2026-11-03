Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4DF606A789
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oFyfyvw0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9378442E81;
	Tue,  3 Nov 2026 16:12:54 +0100 (CET)
Received: from mta1.migadu.com (out-235.mta1.migadu.com [95.215.58.235])
 by mails.dpdk.org (Postfix) with ESMTPS id 9BA1D42E81
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:12:52 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=qrhQqMouoj2xj/WTXJHGNxhq73TBtORg7Sk2dpHWg24=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718772; v=1; x=1794323572;
 b=oFyfyvw0Nb6a3D4Y0XP5MzodQKmPFeEp2iAMAuo7tLGPFNIuHYP7xLVis6vYOmjQzrNFjCB2
 n10V29M2LxkRKEs4Y3yWC6aoTSfluKqZyJZTKTZt2zNDu+jRy4fgCaCB2EuaFfa1b31pUwU2mwD
 1mEmvvXZ/8ZWYHwNetwk9HU4=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id f56fd3470221cdb7;
 Tue, 03 Nov 2026 15:12:52 +0000
X-Mizu-Trace-ID: f56fd3470221cdb7
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 121/227] net/hinic: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:19 +0800
Message-ID: <20261103145306.487255-122-chengwen.feng@linux.dev>
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
 drivers/net/hinic/base/hinic_compat.h      |  6 ++---
 drivers/net/hinic/base/hinic_pmd_api_cmd.c |  6 ++---
 drivers/net/hinic/base/hinic_pmd_eqs.c     |  2 +-
 drivers/net/hinic/base/hinic_pmd_hwdev.c   | 18 +++++++--------
 drivers/net/hinic/base/hinic_pmd_mbox.c    |  2 +-
 drivers/net/hinic/base/hinic_pmd_wq.c      | 10 ++++-----
 drivers/net/hinic/base/hinic_pmd_wq.h      |  2 +-
 drivers/net/hinic/hinic_pmd_ethdev.c       | 26 +++++++++++-----------
 drivers/net/hinic/hinic_pmd_rx.c           | 16 ++++++-------
 drivers/net/hinic/hinic_pmd_rx.h           |  4 ++--
 drivers/net/hinic/hinic_pmd_tx.c           |  8 +++----
 drivers/net/hinic/hinic_pmd_tx.h           |  4 ++--
 12 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/drivers/net/hinic/base/hinic_compat.h b/drivers/net/hinic/base/hinic_compat.h
index c37d970f59..a93def90a7 100644
--- a/drivers/net/hinic/base/hinic_compat.h
+++ b/drivers/net/hinic/base/hinic_compat.h
@@ -113,13 +113,13 @@ extern int hinic_logtype;
 #define HINIC_PAGE_SIZE_DPDK	6
 
 void *dma_zalloc_coherent(void *dev, size_t size, dma_addr_t *dma_handle,
-			  unsigned int socket_id);
+			  unsigned int numa_id);
 
 void *dma_zalloc_coherent_aligned(void *hwdev, size_t size,
-		dma_addr_t *dma_handle, unsigned int socket_id);
+		dma_addr_t *dma_handle, unsigned int numa_id);
 
 void *dma_zalloc_coherent_aligned256k(void *hwdev, size_t size,
-			      dma_addr_t *dma_handle, unsigned int socket_id);
+			      dma_addr_t *dma_handle, unsigned int numa_id);
 
 void dma_free_coherent(void *dev, size_t size, void *virt, dma_addr_t phys);
 
diff --git a/drivers/net/hinic/base/hinic_pmd_api_cmd.c b/drivers/net/hinic/base/hinic_pmd_api_cmd.c
index b72edc0652..ef1798485f 100644
--- a/drivers/net/hinic/base/hinic_pmd_api_cmd.c
+++ b/drivers/net/hinic/base/hinic_pmd_api_cmd.c
@@ -658,7 +658,7 @@ static int alloc_cmd_buf(struct hinic_api_cmd_chain *chain,
 
 	cmd_vaddr_alloc = dma_zalloc_coherent(dev, (API_CMD_BUF_SIZE +
 					      API_PAYLOAD_ALIGN_SIZE),
-					      &cmd_paddr, SOCKET_ID_ANY);
+					      &cmd_paddr, RTE_NUMA_ID_ANY);
 	if (!cmd_vaddr_alloc) {
 		PMD_DRV_LOG(ERR, "Allocate API CMD dma memory failed");
 		return -ENOMEM;
@@ -712,7 +712,7 @@ static int api_cmd_create_cell(struct hinic_api_cmd_chain *chain,
 
 	node_vaddr_alloc = dma_zalloc_coherent(dev, (chain->cell_size +
 					       API_CMD_NODE_ALIGN_SIZE),
-					       &node_paddr, SOCKET_ID_ANY);
+					       &node_paddr, RTE_NUMA_ID_ANY);
 	if (!node_vaddr_alloc) {
 		PMD_DRV_LOG(ERR, "Allocate dma API CMD cell failed");
 		return -ENOMEM;
@@ -889,7 +889,7 @@ static int api_chain_init(struct hinic_api_cmd_chain *chain,
 
 	chain->wb_status = (struct hinic_api_cmd_status *)
 			   dma_zalloc_coherent(dev, sizeof(*chain->wb_status),
-				&chain->wb_status_paddr, SOCKET_ID_ANY);
+				&chain->wb_status_paddr, RTE_NUMA_ID_ANY);
 	if (!chain->wb_status) {
 		PMD_DRV_LOG(ERR, "Allocate DMA wb status failed");
 		err = -ENOMEM;
diff --git a/drivers/net/hinic/base/hinic_pmd_eqs.c b/drivers/net/hinic/base/hinic_pmd_eqs.c
index f0e1139a98..ebd05c7585 100644
--- a/drivers/net/hinic/base/hinic_pmd_eqs.c
+++ b/drivers/net/hinic/base/hinic_pmd_eqs.c
@@ -240,7 +240,7 @@ static int alloc_eq_pages(struct hinic_eq *eq)
 		eq->virt_addr[pg_num] =
 			(u8 *)dma_zalloc_coherent_aligned(eq->hwdev,
 					eq->page_size, &eq->dma_addr[pg_num],
-					SOCKET_ID_ANY);
+					RTE_NUMA_ID_ANY);
 		if (!eq->virt_addr[pg_num]) {
 			err = -ENOMEM;
 			goto dma_alloc_err;
diff --git a/drivers/net/hinic/base/hinic_pmd_hwdev.c b/drivers/net/hinic/base/hinic_pmd_hwdev.c
index 3aca40d17d..ac65b8ce29 100644
--- a/drivers/net/hinic/base/hinic_pmd_hwdev.c
+++ b/drivers/net/hinic/base/hinic_pmd_hwdev.c
@@ -114,7 +114,7 @@ void hinic_be32_to_cpu(void *data, u32 len)
 
 static void *hinic_dma_mem_zalloc(struct hinic_hwdev *hwdev, size_t size,
 			   dma_addr_t *dma_handle, unsigned int align,
-			   unsigned int socket_id)
+			   unsigned int numa_id)
 {
 	int rc;
 	uint32_t alloc_cnt;
@@ -131,7 +131,7 @@ static void *hinic_dma_mem_zalloc(struct hinic_hwdev *hwdev, size_t size,
 	snprintf(z_name, sizeof(z_name), "%s_%u",
 		 hwdev->pcidev_hdl->name, alloc_cnt);
 
-	mz = rte_memzone_reserve_aligned(z_name, size, socket_id,
+	mz = rte_memzone_reserve_aligned(z_name, size, numa_id,
 					 RTE_MEMZONE_IOVA_CONTIG, align);
 	if (!mz) {
 		PMD_DRV_LOG(ERR, "Alloc dma able memory failed, errno: %d, ma_name: %s, size: 0x%zx",
@@ -212,25 +212,25 @@ hinic_dma_mem_free(struct hinic_hwdev *hwdev, size_t size,
 }
 
 void *dma_zalloc_coherent(void *hwdev, size_t size, dma_addr_t *dma_handle,
-			  unsigned int socket_id)
+			  unsigned int numa_id)
 {
 	return hinic_dma_mem_zalloc(hwdev, size, dma_handle,
-				    RTE_CACHE_LINE_SIZE, socket_id);
+				    RTE_CACHE_LINE_SIZE, numa_id);
 }
 
 void *dma_zalloc_coherent_aligned(void *hwdev, size_t size,
-				dma_addr_t *dma_handle, unsigned int socket_id)
+				dma_addr_t *dma_handle, unsigned int numa_id)
 {
 	return hinic_dma_mem_zalloc(hwdev, size, dma_handle, HINIC_PAGE_SIZE,
-				    socket_id);
+				    numa_id);
 }
 
 void *dma_zalloc_coherent_aligned256k(void *hwdev, size_t size,
 				      dma_addr_t *dma_handle,
-				      unsigned int socket_id)
+				      unsigned int numa_id)
 {
 	return hinic_dma_mem_zalloc(hwdev, size, dma_handle,
-				    HINIC_PAGE_SIZE * 64, socket_id);
+				    HINIC_PAGE_SIZE * 64, numa_id);
 }
 
 void dma_free_coherent(void *hwdev, size_t size, void *virt, dma_addr_t phys)
@@ -314,7 +314,7 @@ void *dma_pool_alloc(struct pci_pool *pool, dma_addr_t *dma_addr)
 	void *buf;
 
 	buf = hinic_dma_mem_zalloc(pool->hwdev, pool->elem_size, dma_addr,
-				(u32)pool->align, SOCKET_ID_ANY);
+				(u32)pool->align, RTE_NUMA_ID_ANY);
 	if (buf)
 		rte_atomic_fetch_add_explicit(&pool->inuse, 1, rte_memory_order_relaxed);
 
diff --git a/drivers/net/hinic/base/hinic_pmd_mbox.c b/drivers/net/hinic/base/hinic_pmd_mbox.c
index 7418c9b602..270bed05c3 100644
--- a/drivers/net/hinic/base/hinic_pmd_mbox.c
+++ b/drivers/net/hinic/base/hinic_pmd_mbox.c
@@ -443,7 +443,7 @@ static int alloc_mbox_wb_status(struct hinic_mbox_func_to_func *func_to_func)
 	u32 addr_h, addr_l;
 
 	send_mbox->wb_vaddr = dma_zalloc_coherent(hwdev, MBOX_WB_STATUS_LEN,
-					&send_mbox->wb_paddr, SOCKET_ID_ANY);
+					&send_mbox->wb_paddr, RTE_NUMA_ID_ANY);
 	if (!send_mbox->wb_vaddr) {
 		PMD_DRV_LOG(ERR, "Allocating memory for mailbox wb status failed");
 		return -ENOMEM;
diff --git a/drivers/net/hinic/base/hinic_pmd_wq.c b/drivers/net/hinic/base/hinic_pmd_wq.c
index 345248c3ea..1197ec0082 100644
--- a/drivers/net/hinic/base/hinic_pmd_wq.c
+++ b/drivers/net/hinic/base/hinic_pmd_wq.c
@@ -16,13 +16,13 @@ static void free_wq_pages(struct hinic_hwdev *hwdev, struct hinic_wq *wq)
 }
 
 static int alloc_wq_pages(struct hinic_hwdev *hwdev, struct hinic_wq *wq,
-			unsigned int socket_id)
+			unsigned int numa_id)
 {
 	dma_addr_t dma_addr = 0;
 
 	wq->queue_buf_vaddr = (u64)(u64 *)
 		dma_zalloc_coherent_aligned256k(hwdev, wq->wq_buf_size,
-						&dma_addr, socket_id);
+						&dma_addr, numa_id);
 	if (!wq->queue_buf_vaddr) {
 		PMD_DRV_LOG(ERR, "Failed to allocate wq page");
 		return -ENOMEM;
@@ -41,7 +41,7 @@ static int alloc_wq_pages(struct hinic_hwdev *hwdev, struct hinic_wq *wq,
 }
 
 int hinic_wq_allocate(struct hinic_hwdev *hwdev, struct hinic_wq *wq,
-		      u32 wqebb_shift, u16 q_depth, unsigned int socket_id)
+		      u32 wqebb_shift, u16 q_depth, unsigned int numa_id)
 {
 	int err;
 
@@ -61,7 +61,7 @@ int hinic_wq_allocate(struct hinic_hwdev *hwdev, struct hinic_wq *wq,
 		return -EINVAL;
 	}
 
-	err = alloc_wq_pages(hwdev, wq, socket_id);
+	err = alloc_wq_pages(hwdev, wq, numa_id);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Failed to allocate wq pages");
 		return err;
@@ -115,7 +115,7 @@ int hinic_cmdq_alloc(struct hinic_wq *wq, struct hinic_hwdev *hwdev,
 		wq[i].wq_buf_size = wq_buf_size;
 		wq[i].q_depth = q_depth;
 
-		err = alloc_wq_pages(hwdev, &wq[i], SOCKET_ID_ANY);
+		err = alloc_wq_pages(hwdev, &wq[i], RTE_NUMA_ID_ANY);
 		if (err) {
 			PMD_DRV_LOG(ERR, "Failed to alloc CMDQ blocks");
 			goto cmdq_block_err;
diff --git a/drivers/net/hinic/base/hinic_pmd_wq.h b/drivers/net/hinic/base/hinic_pmd_wq.h
index 354d0338de..80bcfc43ec 100644
--- a/drivers/net/hinic/base/hinic_pmd_wq.h
+++ b/drivers/net/hinic/base/hinic_pmd_wq.h
@@ -122,7 +122,7 @@ void hinic_cmdq_free(struct hinic_hwdev *hwdev, struct hinic_wq *wq,
 		     int cmdq_blocks);
 
 int hinic_wq_allocate(struct hinic_hwdev *hwdev, struct hinic_wq *wq,
-		      u32 wqebb_shift, u16 q_depth, unsigned int socket_id);
+		      u32 wqebb_shift, u16 q_depth, unsigned int numa_id);
 
 void hinic_wq_free(struct hinic_hwdev *hwdev, struct hinic_wq *wq);
 
diff --git a/drivers/net/hinic/hinic_pmd_ethdev.c b/drivers/net/hinic/hinic_pmd_ethdev.c
index 016d632e64..e552c471d0 100644
--- a/drivers/net/hinic/hinic_pmd_ethdev.c
+++ b/drivers/net/hinic/hinic_pmd_ethdev.c
@@ -361,7 +361,7 @@ static int hinic_dev_configure(struct rte_eth_dev *dev)
  *   RX queue index.
  * @param nb_desc
  *   Number of descriptors for receive queue.
- * @param socket_id
+ * @param numa_id
  *   NUMA socket on which memory must be allocated.
  * @param rx_conf
  *   Thresholds parameters (unused_).
@@ -372,7 +372,7 @@ static int hinic_dev_configure(struct rte_eth_dev *dev)
  *   0 on success, negative error value otherwise.
  */
 static int hinic_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
-			 uint16_t nb_desc, unsigned int socket_id,
+			 uint16_t nb_desc, unsigned int numa_id,
 			 __rte_unused const struct rte_eth_rxconf *rx_conf,
 			 struct rte_mempool *mp)
 {
@@ -423,8 +423,8 @@ static int hinic_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		return -EINVAL;
 	}
 
-	rxq = rte_zmalloc_socket("hinic_rx_queue", sizeof(struct hinic_rxq),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	rxq = rte_zmalloc_numa("hinic_rx_queue", sizeof(struct hinic_rxq),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (!rxq) {
 		PMD_DRV_LOG(ERR, "Allocate rxq[%d] failed, dev_name: %s",
 			    queue_idx, dev->data->name);
@@ -433,7 +433,7 @@ static int hinic_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	nic_dev->rxqs[queue_idx] = rxq;
 
 	/* alloc rx sq hw wqe page */
-	rc = hinic_create_rq(hwdev, queue_idx, rq_depth, socket_id);
+	rc = hinic_create_rq(hwdev, queue_idx, rq_depth, numa_id);
 	if (rc) {
 		PMD_DRV_LOG(ERR, "Create rxq[%d] failed, dev_name: %s, rq_depth: %d",
 			    queue_idx, dev->data->name, rq_depth);
@@ -460,7 +460,7 @@ static int hinic_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	rxq->q_depth = rq_depth;
 	rxq->buf_len = (u16)buf_size;
 	rxq->rx_free_thresh = rx_free_thresh;
-	rxq->socket_id = socket_id;
+	rxq->numa_id = numa_id;
 
 	/* the last point cant do mbuf rearm in bulk */
 	rxq->rxinfo_align_end = rxq->q_depth - rxq->rx_free_thresh;
@@ -521,7 +521,7 @@ static void hinic_reset_rx_queue(struct rte_eth_dev *dev)
  *   Transmit queue index.
  * @param nb_desc
  *   Number of descriptors for transmit queue.
- * @param socket_id
+ * @param numa_id
  *   NUMA socket on which memory must be allocated.
  * @param tx_conf
  *   Tx queue configuration parameters.
@@ -530,7 +530,7 @@ static void hinic_reset_rx_queue(struct rte_eth_dev *dev)
  *   0 on success, negative error value otherwise.
  */
 static int hinic_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
-			 uint16_t nb_desc, unsigned int socket_id,
+			 uint16_t nb_desc, unsigned int numa_id,
 			 __rte_unused const struct rte_eth_txconf *tx_conf)
 {
 	int rc;
@@ -578,8 +578,8 @@ static int hinic_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		return -EINVAL;
 	}
 
-	txq = rte_zmalloc_socket("hinic_tx_queue", sizeof(struct hinic_txq),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	txq = rte_zmalloc_numa("hinic_tx_queue", sizeof(struct hinic_txq),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (!txq) {
 		PMD_DRV_LOG(ERR, "Allocate txq[%d] failed, dev_name: %s",
 			    queue_idx, dev->data->name);
@@ -588,7 +588,7 @@ static int hinic_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	nic_dev->txqs[queue_idx] = txq;
 
 	/* alloc tx sq hw wqepage */
-	rc = hinic_create_sq(hwdev, queue_idx, sq_depth, socket_id);
+	rc = hinic_create_sq(hwdev, queue_idx, sq_depth, numa_id);
 	if (rc) {
 		PMD_DRV_LOG(ERR, "Create txq[%d] failed, dev_name: %s, sq_depth: %d",
 			    queue_idx, dev->data->name, sq_depth);
@@ -607,7 +607,7 @@ static int hinic_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	txq->sq_bot_sge_addr = HINIC_GET_WQ_TAIL(txq) -
 					sizeof(struct hinic_sq_bufdesc);
 	txq->cos = nic_dev->default_cos;
-	txq->socket_id = socket_id;
+	txq->numa_id = numa_id;
 
 	/* alloc software txinfo */
 	rc = hinic_setup_tx_resources(txq);
@@ -2678,7 +2678,7 @@ static int hinic_copy_mempool_init(struct hinic_nic_dev *nic_dev)
 					HINIC_COPY_MEMPOOL_DEPTH,
 					0, 0,
 					HINIC_COPY_MBUF_SIZE,
-					rte_socket_id());
+					rte_numa_id());
 		if (!nic_dev->cpy_mpool) {
 			PMD_DRV_LOG(ERR, "Create copy mempool failed, errno: %d, dev_name: %s",
 				    rte_errno, nic_dev->proc_dev_name);
diff --git a/drivers/net/hinic/hinic_pmd_rx.c b/drivers/net/hinic/hinic_pmd_rx.c
index c2cd295033..5df252e789 100644
--- a/drivers/net/hinic/hinic_pmd_rx.c
+++ b/drivers/net/hinic/hinic_pmd_rx.c
@@ -210,7 +210,7 @@ void hinic_get_func_rx_buf_size(struct hinic_nic_dev *nic_dev)
 }
 
 int hinic_create_rq(struct hinic_hwdev *hwdev, u16 q_id,
-			u16 rq_depth, unsigned int socket_id)
+			u16 rq_depth, unsigned int numa_id)
 {
 	int err;
 	struct hinic_nic_io *nic_io = hwdev->nic_io;
@@ -224,7 +224,7 @@ int hinic_create_rq(struct hinic_hwdev *hwdev, u16 q_id,
 	nic_io->rq_depth = rq_depth;
 
 	err = hinic_wq_allocate(hwdev, &nic_io->rq_wq[q_id],
-			HINIC_RQ_WQEBB_SHIFT, nic_io->rq_depth, socket_id);
+			HINIC_RQ_WQEBB_SHIFT, nic_io->rq_depth, numa_id);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Failed to allocate WQ for RQ");
 		return err;
@@ -232,7 +232,7 @@ int hinic_create_rq(struct hinic_hwdev *hwdev, u16 q_id,
 	rq->wq = &nic_io->rq_wq[q_id];
 
 	rq->pi_virt_addr = (volatile u16 *)dma_zalloc_coherent(hwdev,
-			HINIC_PAGE_SIZE, &rq->pi_dma_addr, socket_id);
+			HINIC_PAGE_SIZE, &rq->pi_dma_addr, numa_id);
 	if (!rq->pi_virt_addr) {
 		PMD_DRV_LOG(ERR, "Failed to allocate rq pi virt addr");
 		err = -ENOMEM;
@@ -304,13 +304,13 @@ void hinic_rxq_stats_reset(struct hinic_rxq *rxq)
 	memset(rxq_stats, 0, sizeof(*rxq_stats));
 }
 
-static int hinic_rx_alloc_cqe(struct hinic_rxq *rxq, unsigned int socket_id)
+static int hinic_rx_alloc_cqe(struct hinic_rxq *rxq, unsigned int numa_id)
 {
 	size_t cqe_mem_size;
 
 	cqe_mem_size = sizeof(struct hinic_rq_cqe) * rxq->q_depth;
 	rxq->cqe_start_vaddr = dma_zalloc_coherent(rxq->nic_dev->hwdev,
-				cqe_mem_size, &rxq->cqe_start_paddr, socket_id);
+				cqe_mem_size, &rxq->cqe_start_paddr, numa_id);
 	if (!rxq->cqe_start_vaddr) {
 		PMD_DRV_LOG(ERR, "Allocate cqe dma memory failed");
 		return -ENOMEM;
@@ -366,12 +366,12 @@ int hinic_setup_rx_resources(struct hinic_rxq *rxq)
 	int err, pkts;
 
 	rx_info_sz = rxq->q_depth * sizeof(*rxq->rx_info);
-	rxq->rx_info = rte_zmalloc_socket("rx_info", rx_info_sz,
-				RTE_CACHE_LINE_SIZE, rxq->socket_id);
+	rxq->rx_info = rte_zmalloc_numa("rx_info", rx_info_sz,
+				RTE_CACHE_LINE_SIZE, rxq->numa_id);
 	if (!rxq->rx_info)
 		return -ENOMEM;
 
-	err = hinic_rx_alloc_cqe(rxq, rxq->socket_id);
+	err = hinic_rx_alloc_cqe(rxq, rxq->numa_id);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Allocate rx cqe failed");
 		goto rx_cqe_err;
diff --git a/drivers/net/hinic/hinic_pmd_rx.h b/drivers/net/hinic/hinic_pmd_rx.h
index 43c236b46c..88a0c09950 100644
--- a/drivers/net/hinic/hinic_pmd_rx.h
+++ b/drivers/net/hinic/hinic_pmd_rx.h
@@ -86,7 +86,7 @@ struct hinic_rxq {
 	u16 rx_free_thresh;
 	u16 rxinfo_align_end;
 
-	u32 socket_id;
+	u32 numa_id;
 
 	unsigned long status;
 	struct hinic_rxq_stats rxq_stats;
@@ -128,7 +128,7 @@ void hinic_rx_remove_configure(struct rte_eth_dev *dev);
 void hinic_get_func_rx_buf_size(struct hinic_nic_dev *nic_dev);
 
 int hinic_create_rq(struct hinic_hwdev *hwdev, u16 q_id,
-			u16 rq_depth, unsigned int socket_id);
+			u16 rq_depth, unsigned int numa_id);
 
 void hinic_destroy_rq(struct hinic_hwdev *hwdev, u16 q_id);
 
diff --git a/drivers/net/hinic/hinic_pmd_tx.c b/drivers/net/hinic/hinic_pmd_tx.c
index 22fb0bffaf..e4987c2e14 100644
--- a/drivers/net/hinic/hinic_pmd_tx.c
+++ b/drivers/net/hinic/hinic_pmd_tx.c
@@ -1279,8 +1279,8 @@ int hinic_setup_tx_resources(struct hinic_txq *txq)
 	u64 tx_info_sz;
 
 	tx_info_sz = txq->q_depth * sizeof(*txq->tx_info);
-	txq->tx_info = rte_zmalloc_socket("tx_info", tx_info_sz,
-			RTE_CACHE_LINE_SIZE, txq->socket_id);
+	txq->tx_info = rte_zmalloc_numa("tx_info", tx_info_sz,
+			RTE_CACHE_LINE_SIZE, txq->numa_id);
 	if (!txq->tx_info)
 		return -ENOMEM;
 
@@ -1297,7 +1297,7 @@ void hinic_free_tx_resources(struct hinic_txq *txq)
 }
 
 int hinic_create_sq(struct hinic_hwdev *hwdev, u16 q_id,
-			u16 sq_depth, unsigned int socket_id)
+			u16 sq_depth, unsigned int numa_id)
 {
 	int err;
 	struct hinic_nic_io *nic_io = hwdev->nic_io;
@@ -1312,7 +1312,7 @@ int hinic_create_sq(struct hinic_hwdev *hwdev, u16 q_id,
 	/* alloc wq */
 	err = hinic_wq_allocate(nic_io->hwdev, &nic_io->sq_wq[q_id],
 				HINIC_SQ_WQEBB_SHIFT, nic_io->sq_depth,
-				socket_id);
+				numa_id);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Failed to allocate WQ for SQ");
 		return err;
diff --git a/drivers/net/hinic/hinic_pmd_tx.h b/drivers/net/hinic/hinic_pmd_tx.h
index 152f7abc53..939c82730a 100644
--- a/drivers/net/hinic/hinic_pmd_tx.h
+++ b/drivers/net/hinic/hinic_pmd_tx.h
@@ -115,7 +115,7 @@ struct hinic_txq {
 	u16 q_id;
 	u16 q_depth;
 	u32 cos;
-	u32 socket_id;
+	u32 numa_id;
 
 	/* cacheline1 */
 	struct hinic_txq_stats txq_stats;
@@ -140,7 +140,7 @@ void hinic_txq_get_stats(struct hinic_txq *txq, struct hinic_txq_stats *stats);
 void hinic_txq_stats_reset(struct hinic_txq *txq);
 
 int hinic_create_sq(struct hinic_hwdev *hwdev, u16 q_id,
-			u16 sq_depth, unsigned int socket_id);
+			u16 sq_depth, unsigned int numa_id);
 
 void hinic_destroy_sq(struct hinic_hwdev *hwdev, u16 q_id);
 
-- 
2.55.0

