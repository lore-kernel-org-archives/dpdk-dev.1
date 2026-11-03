Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89F7606A328
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BrtNAN6R
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3048442E53;
	Tue,  3 Nov 2026 16:11:00 +0100 (CET)
Received: from mta1.migadu.com (out-123.mta1.migadu.com [95.215.58.123])
 by mails.dpdk.org (Postfix) with ESMTPS id C215A42E53
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:10:58 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=GBXeJjDu64Lkj8gsC8Fd8Gld0XlagUtRdzphaFJbsck=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718658; v=1; x=1794323458;
 b=BrtNAN6R3I3UxlG82Btk9UM+mNu752x1jm2ILlXBYz+WZXVtiu6zuovRUloSVVUeOc7VP91w
 btk4/d0LPGPSUwS1lCFj/bjJbZ3fijOX9kKFz+ZAd66RjwCWLbLxaQqtKHLbsVS7IZgJmeH3XiP
 YnUFVVKiw3SxoHGbOLJDvOIM=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 62c83b4e7260fe77;
 Tue, 03 Nov 2026 15:10:58 +0000
X-Mizu-Trace-ID: 62c83b4e7260fe77
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 109/227] net/bnxt: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:07 +0800
Message-ID: <20261103145306.487255-110-chengwen.feng@linux.dev>
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
 drivers/net/bnxt/bnxt_ethdev.c              |  6 ++--
 drivers/net/bnxt/bnxt_mpc.c                 | 38 ++++++++++-----------
 drivers/net/bnxt/bnxt_reps.c                | 32 ++++++++---------
 drivers/net/bnxt/bnxt_reps.h                |  4 +--
 drivers/net/bnxt/bnxt_ring.c                | 12 +++----
 drivers/net/bnxt/bnxt_ring.h                |  2 +-
 drivers/net/bnxt/bnxt_rxq.c                 | 10 +++---
 drivers/net/bnxt/bnxt_rxq.h                 |  2 +-
 drivers/net/bnxt/bnxt_rxr.c                 | 22 ++++++------
 drivers/net/bnxt/bnxt_rxr.h                 |  2 +-
 drivers/net/bnxt/bnxt_txq.c                 | 14 ++++----
 drivers/net/bnxt/bnxt_txq.h                 |  2 +-
 drivers/net/bnxt/bnxt_txr.c                 | 18 +++++-----
 drivers/net/bnxt/bnxt_txr.h                 |  2 +-
 drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c |  2 +-
 15 files changed, 84 insertions(+), 84 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 4ecd2effdf..2bb5cad1d9 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -632,7 +632,7 @@ static int bnxt_alloc_ctx_mem_buf(struct bnxt *bp, char *type, size_t size,
 	if (!ctx)
 		return -EINVAL;
 
-	ctx->va = rte_zmalloc_socket(type, size, 0,
+	ctx->va = rte_zmalloc_numa(type, size, 0,
 				     bp->eth_dev->device->numa_node);
 	if (ctx->va == NULL)
 		return -ENOMEM;
@@ -5418,7 +5418,7 @@ static int bnxt_alloc_stats_mem(struct bnxt *bp)
 				       sizeof(struct rx_port_stats_ext) + 512);
 	if (!mz) {
 		mz = rte_memzone_reserve(mz_name, total_alloc_len,
-					 SOCKET_ID_ANY,
+					 RTE_NUMA_ID_ANY,
 					 RTE_MEMZONE_2MB |
 					 RTE_MEMZONE_SIZE_HINT_ONLY |
 					 RTE_MEMZONE_IOVA_CONTIG);
@@ -5444,7 +5444,7 @@ static int bnxt_alloc_stats_mem(struct bnxt *bp)
 	if (!mz) {
 		mz = rte_memzone_reserve(mz_name,
 					 total_alloc_len,
-					 SOCKET_ID_ANY,
+					 RTE_NUMA_ID_ANY,
 					 RTE_MEMZONE_2MB |
 					 RTE_MEMZONE_SIZE_HINT_ONLY |
 					 RTE_MEMZONE_IOVA_CONTIG);
diff --git a/drivers/net/bnxt/bnxt_mpc.c b/drivers/net/bnxt/bnxt_mpc.c
index 5560d3da00..1644e2c96e 100644
--- a/drivers/net/bnxt/bnxt_mpc.c
+++ b/drivers/net/bnxt/bnxt_mpc.c
@@ -179,23 +179,23 @@ int bnxt_mpc_close(struct bnxt *bp)
 }
 
 static int bnxt_init_mpc_ring_struct(struct bnxt_mpc_txq *mpc_queue,
-				     unsigned int socket_id)
+				     unsigned int numa_id)
 {
 	struct bnxt_cp_ring_info *cpr;
 	struct bnxt_mpc_ring_info *mpr;
 	struct bnxt_ring *ring;
 	int rc = 0;
 
-	mpr = rte_zmalloc_socket("bnxt_mpc_ring",
+	mpr = rte_zmalloc_numa("bnxt_mpc_ring",
 				 sizeof(struct bnxt_mpc_ring_info),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (mpr == NULL)
 		return -ENOMEM;
 	mpc_queue->mpc_ring = mpr;
 
-	ring = rte_zmalloc_socket("bnxt_mpc_ring_struct",
+	ring = rte_zmalloc_numa("bnxt_mpc_ring_struct",
 				  sizeof(struct bnxt_ring),
-				  RTE_CACHE_LINE_SIZE, socket_id);
+				  RTE_CACHE_LINE_SIZE, numa_id);
 	if (ring == NULL) {
 		PMD_DRV_LOG_LINE(ERR, "MPC ring struct alloc failed rc:%d", rc);
 		rc = -ENOMEM;
@@ -211,9 +211,9 @@ static int bnxt_init_mpc_ring_struct(struct bnxt_mpc_txq *mpc_queue,
 	ring->vmem = (void **)&mpr->mpc_buf_ring;
 	ring->fw_ring_id = INVALID_HW_RING_ID;
 
-	cpr = rte_zmalloc_socket("bnxt_mpc_ring",
+	cpr = rte_zmalloc_numa("bnxt_mpc_ring",
 				 sizeof(struct bnxt_cp_ring_info),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (cpr == NULL) {
 		PMD_DRV_LOG_LINE(ERR, "MPC cp ring alloc failed rc:%d", rc);
 		rc = -ENOMEM;
@@ -221,9 +221,9 @@ static int bnxt_init_mpc_ring_struct(struct bnxt_mpc_txq *mpc_queue,
 	}
 	mpc_queue->cp_ring = cpr;
 
-	ring = rte_zmalloc_socket("bnxt_mpc_ring_struct",
+	ring = rte_zmalloc_numa("bnxt_mpc_ring_struct",
 				  sizeof(struct bnxt_ring),
-				  RTE_CACHE_LINE_SIZE, socket_id);
+				  RTE_CACHE_LINE_SIZE, numa_id);
 	if (ring == NULL) {
 		PMD_DRV_LOG_LINE(ERR, "MPC cp ring struct alloc failed rc:%d", rc);
 		rc = -ENOMEM;
@@ -323,7 +323,7 @@ static int bnxt_alloc_mpc_rings(struct bnxt_mpc_txq *mpc_queue,
 	mz = rte_memzone_lookup(mz_name);
 	if (!mz) {
 		mz = rte_memzone_reserve_aligned(mz_name, total_alloc_len,
-				SOCKET_ID_ANY,
+				RTE_NUMA_ID_ANY,
 				RTE_MEMZONE_2MB |
 				RTE_MEMZONE_SIZE_HINT_ONLY |
 				RTE_MEMZONE_IOVA_CONTIG,
@@ -398,7 +398,7 @@ static uint16_t get_mpc_ring_logical_id(uint8_t mpc_cap,
 }
 
 static int bnxt_mpc_queue_setup_one(struct bnxt *bp, enum bnxt_mpc_chnl chnl_id,
-				    uint16_t nb_desc, unsigned int socket_id)
+				    uint16_t nb_desc, unsigned int numa_id)
 {
 	int rc = 0;
 	struct bnxt_mpc *mpc;
@@ -408,18 +408,18 @@ static int bnxt_mpc_queue_setup_one(struct bnxt *bp, enum bnxt_mpc_chnl chnl_id,
 		return 0;
 
 	mpc = bp->mpc;
-	mpc_queue = rte_zmalloc_socket("bnxt_mpc_queue",
+	mpc_queue = rte_zmalloc_numa("bnxt_mpc_queue",
 				       sizeof(struct bnxt_mpc_txq),
-				       RTE_CACHE_LINE_SIZE, socket_id);
+				       RTE_CACHE_LINE_SIZE, numa_id);
 	if (!mpc_queue) {
 		PMD_DRV_LOG_LINE(ERR, "bnxt_mpc_queue allocation failed!");
 		return -ENOMEM;
 	}
 
 	mpc_queue->free =
-		rte_zmalloc_socket(NULL,
+		rte_zmalloc_numa(NULL,
 				   sizeof(struct bnxt_mpc_mbuf *) * nb_desc,
-				   RTE_CACHE_LINE_SIZE, socket_id);
+				   RTE_CACHE_LINE_SIZE, numa_id);
 	if (!mpc_queue->free) {
 		PMD_DRV_LOG_LINE(ERR, "allocation of mpc mbuf free array failed!");
 		rc = -ENOMEM;
@@ -430,7 +430,7 @@ static int bnxt_mpc_queue_setup_one(struct bnxt *bp, enum bnxt_mpc_chnl chnl_id,
 	/* TBD: hardcoded to 1 for now and should be tuned later for perf */
 	mpc_queue->free_thresh = BNXT_MPC_DESC_THRESH;
 
-	rc = bnxt_init_mpc_ring_struct(mpc_queue, socket_id);
+	rc = bnxt_init_mpc_ring_struct(mpc_queue, numa_id);
 	if (rc)
 		goto bnxt_mpc_queue_setup_one_err1;
 
@@ -530,7 +530,7 @@ int bnxt_mpc_open(struct bnxt *bp)
 	int rc = 0;
 	enum bnxt_mpc_chnl i;
 	struct bnxt_mpc *mpc;
-	unsigned int socket_id;
+	unsigned int numa_id;
 
 	rc = is_bnxt_in_error(bp);
 	if (rc)
@@ -545,7 +545,7 @@ int bnxt_mpc_open(struct bnxt *bp)
 		PMD_DRV_LOG_LINE(ERR, "MPC channels enable failed rc:%d", rc);
 		return rc;
 	}
-	socket_id = rte_lcore_to_socket_id(rte_get_main_lcore());
+	numa_id = rte_lcore_to_numa_id(rte_get_main_lcore());
 	mpc = bp->mpc;
 
 	/* Limit to MPC TE_CFA and RE_CFA */
@@ -556,7 +556,7 @@ int bnxt_mpc_open(struct bnxt *bp)
 	for (i = 0; i < BNXT_MPC_CHNL_MAX; i++) {
 		if (!(mpc->mpc_chnls_cap & (1 << i)))
 			continue;
-		rc = bnxt_mpc_queue_setup_one(bp, i, BNXT_MPC_NB_DESC, socket_id);
+		rc = bnxt_mpc_queue_setup_one(bp, i, BNXT_MPC_NB_DESC, numa_id);
 		if (rc) {
 			PMD_DRV_LOG_LINE(ERR, "MPC queue %d setup failed rc:%d",
 				    i, rc);
diff --git a/drivers/net/bnxt/bnxt_reps.c b/drivers/net/bnxt/bnxt_reps.c
index dd0f14d5c6..d3d1afd7d8 100644
--- a/drivers/net/bnxt/bnxt_reps.c
+++ b/drivers/net/bnxt/bnxt_reps.c
@@ -684,21 +684,21 @@ int bnxt_rep_dev_configure_op(struct rte_eth_dev *eth_dev)
 }
 
 static int bnxt_init_rep_rx_ring(struct bnxt_rx_queue *rxq,
-				 unsigned int socket_id)
+				 unsigned int numa_id)
 {
 	struct bnxt_rx_ring_info *rxr;
 	struct bnxt_ring *ring;
 
-	rxr = rte_zmalloc_socket("bnxt_rep_rx_ring",
+	rxr = rte_zmalloc_numa("bnxt_rep_rx_ring",
 				 sizeof(struct bnxt_rx_ring_info),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (rxr == NULL)
 		return -ENOMEM;
 	rxq->rx_ring = rxr;
 
-	ring = rte_zmalloc_socket("bnxt_rep_rx_ring_struct",
+	ring = rte_zmalloc_numa("bnxt_rep_rx_ring_struct",
 				  sizeof(struct bnxt_ring),
-				  RTE_CACHE_LINE_SIZE, socket_id);
+				  RTE_CACHE_LINE_SIZE, numa_id);
 	if (ring == NULL)
 		return -ENOMEM;
 	rxr->rx_ring_struct = ring;
@@ -711,7 +711,7 @@ static int bnxt_init_rep_rx_ring(struct bnxt_rx_queue *rxq,
 int bnxt_rep_rx_queue_setup_op(struct rte_eth_dev *eth_dev,
 			       uint16_t queue_idx,
 			       uint16_t nb_desc,
-			       unsigned int socket_id,
+			       unsigned int numa_id,
 			       __rte_unused const struct rte_eth_rxconf *rx_conf,
 			       __rte_unused struct rte_mempool *mp)
 {
@@ -756,9 +756,9 @@ int bnxt_rep_rx_queue_setup_op(struct rte_eth_dev *eth_dev,
 			bnxt_rx_queue_release_op(eth_dev, queue_idx);
 	}
 
-	rxq = rte_zmalloc_socket("bnxt_vfr_rx_queue",
+	rxq = rte_zmalloc_numa("bnxt_vfr_rx_queue",
 				 sizeof(struct bnxt_rx_queue),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (!rxq) {
 		PMD_DRV_LOG_LINE(ERR, "bnxt_vfr_rx_queue allocation failed!");
 		return -ENOMEM;
@@ -768,14 +768,14 @@ int bnxt_rep_rx_queue_setup_op(struct rte_eth_dev *eth_dev,
 
 	rxq->nb_rx_desc = nb_desc;
 
-	rc = bnxt_init_rep_rx_ring(rxq, socket_id);
+	rc = bnxt_init_rep_rx_ring(rxq, numa_id);
 	if (rc)
 		goto out;
 
-	buf_ring = rte_zmalloc_socket("bnxt_rx_vfr_buf_ring",
+	buf_ring = rte_zmalloc_numa("bnxt_rx_vfr_buf_ring",
 				      sizeof(struct rte_mbuf *) *
 				      rxq->rx_ring->rx_ring_struct->ring_size,
-				      RTE_CACHE_LINE_SIZE, socket_id);
+				      RTE_CACHE_LINE_SIZE, numa_id);
 	if (!buf_ring) {
 		PMD_DRV_LOG_LINE(ERR, "bnxt_rx_vfr_buf_ring allocation failed!");
 		rc = -ENOMEM;
@@ -814,7 +814,7 @@ void bnxt_rep_rx_queue_release_op(struct rte_eth_dev *dev, uint16_t queue_idx)
 int bnxt_rep_tx_queue_setup_op(struct rte_eth_dev *eth_dev,
 			       uint16_t queue_idx,
 			       uint16_t nb_desc,
-			       unsigned int socket_id,
+			       unsigned int numa_id,
 			       __rte_unused const struct rte_eth_txconf *tx_conf)
 {
 	struct bnxt_representor *rep_bp = eth_dev->data->dev_private;
@@ -856,16 +856,16 @@ int bnxt_rep_tx_queue_setup_op(struct rte_eth_dev *eth_dev,
 			bnxt_rep_tx_queue_release_op(eth_dev, queue_idx);
 	}
 
-	vfr_txq = rte_zmalloc_socket("bnxt_vfr_tx_queue",
+	vfr_txq = rte_zmalloc_numa("bnxt_vfr_tx_queue",
 				     sizeof(struct bnxt_vf_rep_tx_queue),
-				     RTE_CACHE_LINE_SIZE, socket_id);
+				     RTE_CACHE_LINE_SIZE, numa_id);
 	if (!vfr_txq) {
 		PMD_DRV_LOG_LINE(ERR, "bnxt_vfr_tx_queue allocation failed!");
 		return -ENOMEM;
 	}
-	txq = rte_zmalloc_socket("bnxt_tx_queue",
+	txq = rte_zmalloc_numa("bnxt_tx_queue",
 				 sizeof(struct bnxt_tx_queue),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (!txq) {
 		PMD_DRV_LOG_LINE(ERR, "bnxt_tx_queue allocation failed!");
 		rte_free(vfr_txq);
diff --git a/drivers/net/bnxt/bnxt_reps.h b/drivers/net/bnxt/bnxt_reps.h
index 1615ecf11c..0f02770ae6 100644
--- a/drivers/net/bnxt/bnxt_reps.h
+++ b/drivers/net/bnxt/bnxt_reps.h
@@ -32,14 +32,14 @@ int bnxt_rep_dev_start_op(struct rte_eth_dev *eth_dev);
 int bnxt_rep_rx_queue_setup_op(struct rte_eth_dev *eth_dev,
 				  __rte_unused uint16_t queue_idx,
 				  __rte_unused uint16_t nb_desc,
-				  __rte_unused unsigned int socket_id,
+				  __rte_unused unsigned int numa_id,
 				  __rte_unused const struct rte_eth_rxconf *
 				  rx_conf,
 				  __rte_unused struct rte_mempool *mp);
 int bnxt_rep_tx_queue_setup_op(struct rte_eth_dev *eth_dev,
 				  __rte_unused uint16_t queue_idx,
 				  __rte_unused uint16_t nb_desc,
-				  __rte_unused unsigned int socket_id,
+				  __rte_unused unsigned int numa_id,
 				  __rte_unused const struct rte_eth_txconf *
 				  tx_conf);
 void bnxt_rep_rx_queue_release_op(struct rte_eth_dev *dev, uint16_t queue_idx);
diff --git a/drivers/net/bnxt/bnxt_ring.c b/drivers/net/bnxt/bnxt_ring.c
index d478c60a1e..a01a8462fc 100644
--- a/drivers/net/bnxt/bnxt_ring.c
+++ b/drivers/net/bnxt/bnxt_ring.c
@@ -95,7 +95,7 @@ int bnxt_alloc_ring_grps(struct bnxt *bp)
  * tx bd ring - Only non-zero length if tx_ring_info is not NULL
  * rx bd ring - Only non-zero length if rx_ring_info is not NULL
  */
-int bnxt_alloc_rings(struct bnxt *bp, unsigned int socket_id, uint16_t qidx,
+int bnxt_alloc_rings(struct bnxt *bp, unsigned int numa_id, uint16_t qidx,
 			    struct bnxt_tx_queue *txq,
 			    struct bnxt_rx_queue *rxq,
 			    struct bnxt_cp_ring_info *cp_ring_info,
@@ -207,7 +207,7 @@ int bnxt_alloc_rings(struct bnxt *bp, unsigned int socket_id, uint16_t qidx,
 	mz = rte_memzone_lookup(mz_name);
 	if (!mz) {
 		mz = rte_memzone_reserve_aligned(mz_name, total_alloc_len,
-				socket_id,
+				numa_id,
 				RTE_MEMZONE_2MB |
 				RTE_MEMZONE_SIZE_HINT_ONLY |
 				RTE_MEMZONE_IOVA_CONTIG,
@@ -459,14 +459,14 @@ int bnxt_alloc_rxtx_nq_ring(struct bnxt *bp)
 	if (!BNXT_HAS_NQ(bp) || bp->rxtx_nq_ring)
 		return 0;
 
-	nqr = rte_zmalloc_socket("nqr",
+	nqr = rte_zmalloc_numa("nqr",
 				 sizeof(struct bnxt_cp_ring_info),
 				 RTE_CACHE_LINE_SIZE,
 				 bp->eth_dev->device->numa_node);
 	if (nqr == NULL)
 		return -ENOMEM;
 
-	ring = rte_zmalloc_socket("bnxt_cp_ring_struct",
+	ring = rte_zmalloc_numa("bnxt_cp_ring_struct",
 				  sizeof(struct bnxt_ring),
 				  RTE_CACHE_LINE_SIZE,
 				  bp->eth_dev->device->numa_node);
@@ -879,14 +879,14 @@ int bnxt_alloc_async_ring_struct(struct bnxt *bp)
 	if (BNXT_NUM_ASYNC_CPR(bp) == 0)
 		return 0;
 
-	cpr = rte_zmalloc_socket("cpr",
+	cpr = rte_zmalloc_numa("cpr",
 				 sizeof(struct bnxt_cp_ring_info),
 				 RTE_CACHE_LINE_SIZE,
 				 bp->eth_dev->device->numa_node);
 	if (cpr == NULL)
 		return -ENOMEM;
 
-	ring = rte_zmalloc_socket("bnxt_cp_ring_struct",
+	ring = rte_zmalloc_numa("bnxt_cp_ring_struct",
 				  sizeof(struct bnxt_ring),
 				  RTE_CACHE_LINE_SIZE,
 				  bp->eth_dev->device->numa_node);
diff --git a/drivers/net/bnxt/bnxt_ring.h b/drivers/net/bnxt/bnxt_ring.h
index d63ae8d8f8..7e339a270d 100644
--- a/drivers/net/bnxt/bnxt_ring.h
+++ b/drivers/net/bnxt/bnxt_ring.h
@@ -67,7 +67,7 @@ struct bnxt_rx_ring_info;
 struct bnxt_cp_ring_info;
 void bnxt_free_ring(struct bnxt_ring *ring);
 int bnxt_alloc_ring_grps(struct bnxt *bp);
-int bnxt_alloc_rings(struct bnxt *bp, unsigned int socket_id, uint16_t qidx,
+int bnxt_alloc_rings(struct bnxt *bp, unsigned int numa_id, uint16_t qidx,
 			    struct bnxt_tx_queue *txq,
 			    struct bnxt_rx_queue *rxq,
 			    struct bnxt_cp_ring_info *cp_ring_info,
diff --git a/drivers/net/bnxt/bnxt_rxq.c b/drivers/net/bnxt/bnxt_rxq.c
index 11115db1fd..09033309b2 100644
--- a/drivers/net/bnxt/bnxt_rxq.c
+++ b/drivers/net/bnxt/bnxt_rxq.c
@@ -281,7 +281,7 @@ void bnxt_rx_queue_release_op(struct rte_eth_dev *dev, uint16_t queue_idx)
 int bnxt_rx_queue_setup_op(struct rte_eth_dev *eth_dev,
 			       uint16_t queue_idx,
 			       uint16_t nb_desc,
-			       unsigned int socket_id,
+			       unsigned int numa_id,
 			       const struct rte_eth_rxconf *rx_conf,
 			       struct rte_mempool *mp)
 {
@@ -324,8 +324,8 @@ int bnxt_rx_queue_setup_op(struct rte_eth_dev *eth_dev,
 	rxq = eth_dev->data->rx_queues[queue_idx];
 	if (rxq)
 		bnxt_rx_queue_release_op(eth_dev, queue_idx);
-	rxq = rte_zmalloc_socket("bnxt_rx_queue", sizeof(struct bnxt_rx_queue),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	rxq = rte_zmalloc_numa("bnxt_rx_queue", sizeof(struct bnxt_rx_queue),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (!rxq) {
 		PMD_DRV_LOG_LINE(ERR, "bnxt_rx_queue allocation failed!");
 		return -ENOMEM;
@@ -351,7 +351,7 @@ int bnxt_rx_queue_setup_op(struct rte_eth_dev *eth_dev,
 
 	eth_dev->data->rx_queues[queue_idx] = rxq;
 
-	rc = bnxt_init_rx_ring_struct(rxq, socket_id);
+	rc = bnxt_init_rx_ring_struct(rxq, numa_id);
 	if (rc) {
 		PMD_DRV_LOG_LINE(ERR,
 			    "init_rx_ring_struct failed!");
@@ -367,7 +367,7 @@ int bnxt_rx_queue_setup_op(struct rte_eth_dev *eth_dev,
 		rxq->crc_len = 0;
 
 	/* Allocate RX ring hardware descriptors */
-	rc = bnxt_alloc_rings(bp, socket_id, queue_idx, NULL, rxq, rxq->cp_ring,
+	rc = bnxt_alloc_rings(bp, numa_id, queue_idx, NULL, rxq, rxq->cp_ring,
 			      NULL, "rxr");
 	if (rc) {
 		PMD_DRV_LOG_LINE(ERR,
diff --git a/drivers/net/bnxt/bnxt_rxq.h b/drivers/net/bnxt/bnxt_rxq.h
index 3385496e70..4ef5c4b4d0 100644
--- a/drivers/net/bnxt/bnxt_rxq.h
+++ b/drivers/net/bnxt/bnxt_rxq.h
@@ -57,7 +57,7 @@ void bnxt_rx_queue_release_op(struct rte_eth_dev *dev, uint16_t queue_idx);
 int bnxt_rx_queue_setup_op(struct rte_eth_dev *eth_dev,
 			       uint16_t queue_idx,
 			       uint16_t nb_desc,
-			       unsigned int socket_id,
+			       unsigned int numa_id,
 			       const struct rte_eth_rxconf *rx_conf,
 			       struct rte_mempool *mp);
 void bnxt_free_rx_mbufs(struct bnxt *bp);
diff --git a/drivers/net/bnxt/bnxt_rxr.c b/drivers/net/bnxt/bnxt_rxr.c
index 43b13790f8..2f0c619c67 100644
--- a/drivers/net/bnxt/bnxt_rxr.c
+++ b/drivers/net/bnxt/bnxt_rxr.c
@@ -1528,7 +1528,7 @@ void bnxt_free_rx_rings(struct bnxt *bp)
 	}
 }
 
-int bnxt_init_rx_ring_struct(struct bnxt_rx_queue *rxq, unsigned int socket_id)
+int bnxt_init_rx_ring_struct(struct bnxt_rx_queue *rxq, unsigned int numa_id)
 {
 	struct bnxt_cp_ring_info *cpr;
 	struct bnxt_rx_ring_info *rxr;
@@ -1540,18 +1540,18 @@ int bnxt_init_rx_ring_struct(struct bnxt_rx_queue *rxq, unsigned int socket_id)
 		rxr = rxq->rx_ring;
 	} else {
 
-		rxr = rte_zmalloc_socket("bnxt_rx_ring",
+		rxr = rte_zmalloc_numa("bnxt_rx_ring",
 					 sizeof(struct bnxt_rx_ring_info),
-					 RTE_CACHE_LINE_SIZE, socket_id);
+					 RTE_CACHE_LINE_SIZE, numa_id);
 		if (rxr == NULL)
 			return -ENOMEM;
 		rxq->rx_ring = rxr;
 	}
 
 	if (rxr->rx_ring_struct == NULL) {
-		ring = rte_zmalloc_socket("bnxt_rx_ring_struct",
+		ring = rte_zmalloc_numa("bnxt_rx_ring_struct",
 					   sizeof(struct bnxt_ring),
-					   RTE_CACHE_LINE_SIZE, socket_id);
+					   RTE_CACHE_LINE_SIZE, numa_id);
 		if (ring == NULL)
 			return -ENOMEM;
 		rxr->rx_ring_struct = ring;
@@ -1571,18 +1571,18 @@ int bnxt_init_rx_ring_struct(struct bnxt_rx_queue *rxq, unsigned int socket_id)
 	if (rxq->cp_ring != NULL) {
 		cpr = rxq->cp_ring;
 	} else {
-		cpr = rte_zmalloc_socket("bnxt_rx_ring",
+		cpr = rte_zmalloc_numa("bnxt_rx_ring",
 					 sizeof(struct bnxt_cp_ring_info),
-					 RTE_CACHE_LINE_SIZE, socket_id);
+					 RTE_CACHE_LINE_SIZE, numa_id);
 		if (cpr == NULL)
 			return -ENOMEM;
 		rxq->cp_ring = cpr;
 	}
 
 	if (cpr->cp_ring_struct == NULL) {
-		ring = rte_zmalloc_socket("bnxt_rx_ring_struct",
+		ring = rte_zmalloc_numa("bnxt_rx_ring_struct",
 					   sizeof(struct bnxt_ring),
-					   RTE_CACHE_LINE_SIZE, socket_id);
+					   RTE_CACHE_LINE_SIZE, numa_id);
 		if (ring == NULL)
 			return -ENOMEM;
 		cpr->cp_ring_struct = ring;
@@ -1606,9 +1606,9 @@ int bnxt_init_rx_ring_struct(struct bnxt_rx_queue *rxq, unsigned int socket_id)
 
 	rxr = rxq->rx_ring;
 	/* Allocate Aggregator rings */
-	ring = rte_zmalloc_socket("bnxt_rx_ring_struct",
+	ring = rte_zmalloc_numa("bnxt_rx_ring_struct",
 				   sizeof(struct bnxt_ring),
-				   RTE_CACHE_LINE_SIZE, socket_id);
+				   RTE_CACHE_LINE_SIZE, numa_id);
 	if (ring == NULL)
 		return -ENOMEM;
 	rxr->ag_ring_struct = ring;
diff --git a/drivers/net/bnxt/bnxt_rxr.h b/drivers/net/bnxt/bnxt_rxr.h
index 4e745bd7b7..a42564c165 100644
--- a/drivers/net/bnxt/bnxt_rxr.h
+++ b/drivers/net/bnxt/bnxt_rxr.h
@@ -148,7 +148,7 @@ struct bnxt_rx_ring_info {
 uint16_t bnxt_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			       uint16_t nb_pkts);
 void bnxt_free_rx_rings(struct bnxt *bp);
-int bnxt_init_rx_ring_struct(struct bnxt_rx_queue *rxq, unsigned int socket_id);
+int bnxt_init_rx_ring_struct(struct bnxt_rx_queue *rxq, unsigned int numa_id);
 int bnxt_init_one_rx_ring(struct bnxt_rx_queue *rxq);
 int bnxt_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id);
 int bnxt_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id);
diff --git a/drivers/net/bnxt/bnxt_txq.c b/drivers/net/bnxt/bnxt_txq.c
index 983be5130b..cbd9223e8e 100644
--- a/drivers/net/bnxt/bnxt_txq.c
+++ b/drivers/net/bnxt/bnxt_txq.c
@@ -123,7 +123,7 @@ void bnxt_tx_queue_release_op(struct rte_eth_dev *dev, uint16_t queue_idx)
 int bnxt_tx_queue_setup_op(struct rte_eth_dev *eth_dev,
 			       uint16_t queue_idx,
 			       uint16_t nb_desc,
-			       unsigned int socket_id,
+			       unsigned int numa_id,
 			       const struct rte_eth_txconf *tx_conf)
 {
 	struct bnxt *bp = eth_dev->data->dev_private;
@@ -151,8 +151,8 @@ int bnxt_tx_queue_setup_op(struct rte_eth_dev *eth_dev,
 		if (txq)
 			bnxt_tx_queue_release_op(eth_dev, queue_idx);
 	}
-	txq = rte_zmalloc_socket("bnxt_tx_queue", sizeof(struct bnxt_tx_queue),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	txq = rte_zmalloc_numa("bnxt_tx_queue", sizeof(struct bnxt_tx_queue),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (!txq) {
 		PMD_DRV_LOG_LINE(ERR, "bnxt_tx_queue allocation failed!");
 		return -ENOMEM;
@@ -161,9 +161,9 @@ int bnxt_tx_queue_setup_op(struct rte_eth_dev *eth_dev,
 	txq->bp = bp;
 	eth_dev->data->tx_queues[queue_idx] = txq;
 
-	txq->free = rte_zmalloc_socket(NULL,
+	txq->free = rte_zmalloc_numa(NULL,
 				       sizeof(struct rte_mbuf *) * nb_desc,
-				       RTE_CACHE_LINE_SIZE, socket_id);
+				       RTE_CACHE_LINE_SIZE, numa_id);
 	if (!txq->free) {
 		PMD_DRV_LOG_LINE(ERR, "allocation of tx mbuf free array failed!");
 		rc = -ENOMEM;
@@ -187,7 +187,7 @@ int bnxt_tx_queue_setup_op(struct rte_eth_dev *eth_dev,
 
 	txq->tx_deferred_start = tx_conf->tx_deferred_start;
 
-	rc = bnxt_init_tx_ring_struct(txq, socket_id);
+	rc = bnxt_init_tx_ring_struct(txq, numa_id);
 	if (rc)
 		goto err;
 
@@ -195,7 +195,7 @@ int bnxt_tx_queue_setup_op(struct rte_eth_dev *eth_dev,
 	txq->port_id = eth_dev->data->port_id;
 
 	/* Allocate TX ring hardware descriptors */
-	if (bnxt_alloc_rings(bp, socket_id, queue_idx, txq, NULL, txq->cp_ring,
+	if (bnxt_alloc_rings(bp, numa_id, queue_idx, txq, NULL, txq->cp_ring,
 			     NULL, "txr")) {
 		PMD_DRV_LOG_LINE(ERR, "ring_dma_zone_reserve for tx_ring failed!");
 		rc = -ENOMEM;
diff --git a/drivers/net/bnxt/bnxt_txq.h b/drivers/net/bnxt/bnxt_txq.h
index 01f5cf817a..52fe889c8c 100644
--- a/drivers/net/bnxt/bnxt_txq.h
+++ b/drivers/net/bnxt/bnxt_txq.h
@@ -46,7 +46,7 @@ void bnxt_tx_queue_release_op(struct rte_eth_dev *dev, uint16_t queue_idx);
 int bnxt_tx_queue_setup_op(struct rte_eth_dev *eth_dev,
 			       uint16_t queue_idx,
 			       uint16_t nb_desc,
-			       unsigned int socket_id,
+			       unsigned int numa_id,
 			       const struct rte_eth_txconf *tx_conf);
 uint64_t bnxt_get_tx_port_offloads(struct bnxt *bp);
 #endif
diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c
index 4c01e8a275..700b2ca43f 100644
--- a/drivers/net/bnxt/bnxt_txr.c
+++ b/drivers/net/bnxt/bnxt_txr.c
@@ -60,22 +60,22 @@ int bnxt_init_one_tx_ring(struct bnxt_tx_queue *txq)
 	return 0;
 }
 
-int bnxt_init_tx_ring_struct(struct bnxt_tx_queue *txq, unsigned int socket_id)
+int bnxt_init_tx_ring_struct(struct bnxt_tx_queue *txq, unsigned int numa_id)
 {
 	struct bnxt_cp_ring_info *cpr;
 	struct bnxt_tx_ring_info *txr;
 	struct bnxt_ring *ring;
 
-	txr = rte_zmalloc_socket("bnxt_tx_ring",
+	txr = rte_zmalloc_numa("bnxt_tx_ring",
 				 sizeof(struct bnxt_tx_ring_info),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (txr == NULL)
 		return -ENOMEM;
 	txq->tx_ring = txr;
 
-	ring = rte_zmalloc_socket("bnxt_tx_ring_struct",
+	ring = rte_zmalloc_numa("bnxt_tx_ring_struct",
 				  sizeof(struct bnxt_ring),
-				  RTE_CACHE_LINE_SIZE, socket_id);
+				  RTE_CACHE_LINE_SIZE, numa_id);
 	if (ring == NULL)
 		return -ENOMEM;
 	txr->tx_ring_struct = ring;
@@ -87,16 +87,16 @@ int bnxt_init_tx_ring_struct(struct bnxt_tx_queue *txq, unsigned int socket_id)
 	ring->vmem = (void **)&txr->tx_buf_ring;
 	ring->fw_ring_id = INVALID_HW_RING_ID;
 
-	cpr = rte_zmalloc_socket("bnxt_tx_ring",
+	cpr = rte_zmalloc_numa("bnxt_tx_ring",
 				 sizeof(struct bnxt_cp_ring_info),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (cpr == NULL)
 		return -ENOMEM;
 	txq->cp_ring = cpr;
 
-	ring = rte_zmalloc_socket("bnxt_tx_ring_struct",
+	ring = rte_zmalloc_numa("bnxt_tx_ring_struct",
 				  sizeof(struct bnxt_ring),
-				  RTE_CACHE_LINE_SIZE, socket_id);
+				  RTE_CACHE_LINE_SIZE, numa_id);
 	if (ring == NULL)
 		return -ENOMEM;
 	cpr->cp_ring_struct = ring;
diff --git a/drivers/net/bnxt/bnxt_txr.h b/drivers/net/bnxt/bnxt_txr.h
index fd92a242c3..a68d9f3822 100644
--- a/drivers/net/bnxt/bnxt_txr.h
+++ b/drivers/net/bnxt/bnxt_txr.h
@@ -46,7 +46,7 @@ static inline uint32_t bnxt_tx_avail(struct bnxt_tx_queue *txq)
 
 void bnxt_free_tx_rings(struct bnxt *bp);
 int bnxt_init_one_tx_ring(struct bnxt_tx_queue *txq);
-int bnxt_init_tx_ring_struct(struct bnxt_tx_queue *txq, unsigned int socket_id);
+int bnxt_init_tx_ring_struct(struct bnxt_tx_queue *txq, unsigned int numa_id);
 uint16_t bnxt_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			uint16_t nb_pkts);
 uint16_t _bnxt_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
index a761d9bdeb..22bdc25906 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
@@ -500,7 +500,7 @@ static int alloc_link_pbl(struct tfc_ts_mem_cfg *mem_cfg, uint32_t page_size,
 		/* Backing store does not already exist so allocate */
 		mem_cfg->ts_mz.mz = rte_memzone_reserve_aligned(mz_name,
 								total_size,
-								SOCKET_ID_ANY,
+								RTE_NUMA_ID_ANY,
 								mz_size |
 								RTE_MEMZONE_SIZE_HINT_ONLY |
 								RTE_MEMZONE_IOVA_CONTIG,
-- 
2.55.0

