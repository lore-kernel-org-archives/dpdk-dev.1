Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF685606A326
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lHONIdBK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F86942E96;
	Tue,  3 Nov 2026 16:13:10 +0100 (CET)
Received: from mta0.migadu.com (out-11.mta0.migadu.com [91.218.175.11])
 by mails.dpdk.org (Postfix) with ESMTPS id A783C42E7B
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:13:08 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=iN9Exy6fNPfjPyzqtG/Qr2m99IzMrHO9UBfk0xNG53Y=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718787; v=1; x=1794323587;
 b=lHONIdBK2npOPPwSwkWQjZS+Ux5u6cuFiUU5n6hWdIjqPQmsmSMHz+8DnTcAyT953AV+9wbM
 OlPAYzGPbLiO6zMtsFGSDtx8b5yL87Ab6N1uXvN1y9pLSabphudINPrCc+sw7Ef52B6goUISIAG
 f5mB9ikhWZd1lFXRtQTYGr6Y=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 2244b73600b0de13;
 Tue, 03 Nov 2026 15:13:07 +0000
X-Mizu-Trace-ID: 2244b73600b0de13
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 124/227] net/intel: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:22 +0800
Message-ID: <20261103145306.487255-125-chengwen.feng@linux.dev>
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
 drivers/net/intel/cpfl/cpfl_representor.c     |  4 +-
 drivers/net/intel/cpfl/cpfl_rxtx.c            | 74 +++++++++----------
 drivers/net/intel/cpfl/cpfl_rxtx.h            |  4 +-
 drivers/net/intel/e1000/e1000_ethdev.h        |  8 +-
 drivers/net/intel/e1000/em_rxtx.c             |  8 +-
 drivers/net/intel/e1000/igb_rxtx.c            |  8 +-
 drivers/net/intel/e1000/igc_txrx.c            |  8 +-
 drivers/net/intel/e1000/igc_txrx.h            |  4 +-
 drivers/net/intel/fm10k/fm10k_ethdev.c        | 28 +++----
 drivers/net/intel/i40e/i40e_ethdev.c          |  2 +-
 drivers/net/intel/i40e/i40e_ethdev.h          |  2 +-
 drivers/net/intel/i40e/i40e_fdir.c            |  6 +-
 drivers/net/intel/i40e/i40e_rxtx.c            | 44 +++++------
 drivers/net/intel/i40e/i40e_rxtx.h            |  4 +-
 drivers/net/intel/i40e/i40e_vf_representor.c  |  4 +-
 drivers/net/intel/iavf/iavf_osdep.c           |  2 +-
 drivers/net/intel/iavf/iavf_rxtx.c            | 32 ++++----
 drivers/net/intel/iavf/iavf_rxtx.h            |  4 +-
 .../net/intel/ice/ice_dcf_vf_representor.c    |  4 +-
 drivers/net/intel/ice/ice_fdir_filter.c       |  6 +-
 drivers/net/intel/ice/ice_osdep.h             |  2 +-
 drivers/net/intel/ice/ice_rxtx.c              | 46 ++++++------
 drivers/net/intel/ice/ice_rxtx.h              |  4 +-
 drivers/net/intel/idpf/idpf_common_rxtx.c     |  6 +-
 drivers/net/intel/idpf/idpf_common_rxtx.h     |  2 +-
 drivers/net/intel/idpf/idpf_osdep.h           |  2 +-
 drivers/net/intel/idpf/idpf_rxtx.c            | 60 +++++++--------
 drivers/net/intel/idpf/idpf_rxtx.h            |  4 +-
 drivers/net/intel/ipn3ke/ipn3ke_ethdev.c      |  2 +-
 drivers/net/intel/ipn3ke/ipn3ke_representor.c |  4 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        |  4 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c          | 32 ++++----
 .../net/intel/ixgbe/ixgbe_vf_representor.c    |  4 +-
 33 files changed, 214 insertions(+), 214 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_representor.c b/drivers/net/intel/cpfl/cpfl_representor.c
index bb28c0b989..e7c631dbd6 100644
--- a/drivers/net/intel/cpfl/cpfl_representor.c
+++ b/drivers/net/intel/cpfl/cpfl_representor.c
@@ -292,7 +292,7 @@ static int
 cpfl_repr_rx_queue_setup(__rte_unused struct rte_eth_dev *dev,
 			 __rte_unused uint16_t queue_id,
 			 __rte_unused uint16_t nb_desc,
-			 __rte_unused unsigned int socket_id,
+			 __rte_unused unsigned int numa_id,
 			 __rte_unused const struct rte_eth_rxconf *conf,
 			 __rte_unused struct rte_mempool *pool)
 {
@@ -304,7 +304,7 @@ static int
 cpfl_repr_tx_queue_setup(__rte_unused struct rte_eth_dev *dev,
 			 __rte_unused uint16_t queue_id,
 			 __rte_unused uint16_t nb_desc,
-			 __rte_unused unsigned int socket_id,
+			 __rte_unused unsigned int numa_id,
 			 __rte_unused const struct rte_eth_txconf *conf)
 {
 	/* Dummy */
diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index a358beca23..5082a5d6b7 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -119,7 +119,7 @@ static const struct idpf_rxq_ops def_rxq_ops = {
 static const struct rte_memzone *
 cpfl_dma_zone_reserve(struct rte_eth_dev *dev, uint16_t queue_idx,
 		      uint16_t len, uint16_t queue_type,
-		      unsigned int socket_id, bool splitq)
+		      unsigned int numa_id, bool splitq)
 {
 	char ring_name[RTE_MEMZONE_NAMESIZE];
 	const struct rte_memzone *mz;
@@ -162,7 +162,7 @@ cpfl_dma_zone_reserve(struct rte_eth_dev *dev, uint16_t queue_idx,
 
 	mz = rte_eth_dma_zone_reserve(dev, ring_name, queue_idx,
 				      ring_size, CPFL_RING_BASE_ALIGN,
-				      socket_id);
+				      numa_id);
 	if (mz == NULL) {
 		PMD_INIT_LOG(ERR, "Failed to reserve DMA memory for ring");
 		return NULL;
@@ -183,7 +183,7 @@ cpfl_dma_zone_release(const struct rte_memzone *mz)
 static int
 cpfl_rx_split_bufq_setup(struct rte_eth_dev *dev, struct idpf_rx_queue *rxq,
 			 uint16_t queue_idx, uint16_t rx_free_thresh,
-			 uint16_t nb_desc, unsigned int socket_id,
+			 uint16_t nb_desc, unsigned int numa_id,
 			 struct rte_mempool *mp, uint8_t bufq_id)
 {
 	struct cpfl_vport *cpfl_vport = dev->data->dev_private;
@@ -195,10 +195,10 @@ cpfl_rx_split_bufq_setup(struct rte_eth_dev *dev, struct idpf_rx_queue *rxq,
 	uint16_t len;
 	int ret;
 
-	bufq = rte_zmalloc_socket("cpfl bufq",
+	bufq = rte_zmalloc_numa("cpfl bufq",
 				   sizeof(struct idpf_rx_queue),
 				   RTE_CACHE_LINE_SIZE,
-				   socket_id);
+				   numa_id);
 	if (bufq == NULL) {
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for rx buffer queue.");
 		ret = -ENOMEM;
@@ -222,7 +222,7 @@ cpfl_rx_split_bufq_setup(struct rte_eth_dev *dev, struct idpf_rx_queue *rxq,
 
 	mz = cpfl_dma_zone_reserve(dev, queue_idx, len,
 				   VIRTCHNL2_QUEUE_TYPE_RX_BUFFER,
-				   socket_id, true);
+				   numa_id, true);
 	if (mz == NULL) {
 		ret = -ENOMEM;
 		goto err_mz_reserve;
@@ -233,10 +233,10 @@ cpfl_rx_split_bufq_setup(struct rte_eth_dev *dev, struct idpf_rx_queue *rxq,
 	bufq->mz = mz;
 
 	bufq->sw_ring =
-		rte_zmalloc_socket("cpfl rx bufq sw ring",
+		rte_zmalloc_numa("cpfl rx bufq sw ring",
 				   sizeof(struct rte_mbuf *) * len,
 				   RTE_CACHE_LINE_SIZE,
-				   socket_id);
+				   numa_id);
 	if (bufq->sw_ring == NULL) {
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for SW ring");
 		ret = -ENOMEM;
@@ -339,7 +339,7 @@ cpfl_tx_queue_release(void *txq)
 
 int
 cpfl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
-		    uint16_t nb_desc, unsigned int socket_id,
+		    uint16_t nb_desc, unsigned int numa_id,
 		    const struct rte_eth_rxconf *rx_conf,
 		    struct rte_mempool *mp)
 {
@@ -382,10 +382,10 @@ cpfl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	}
 
 	/* Setup Rx queue */
-	cpfl_rxq = rte_zmalloc_socket("cpfl rxq",
+	cpfl_rxq = rte_zmalloc_numa("cpfl rxq",
 				 sizeof(struct cpfl_rx_queue),
 				 RTE_CACHE_LINE_SIZE,
-				 socket_id);
+				 numa_id);
 	if (cpfl_rxq == NULL) {
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for rx queue data structure");
 		ret = -ENOMEM;
@@ -412,7 +412,7 @@ cpfl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	/* Allocate a little more to support bulk allocate. */
 	len = nb_desc + IDPF_RX_MAX_BURST;
 	mz = cpfl_dma_zone_reserve(dev, queue_idx, len, VIRTCHNL2_QUEUE_TYPE_RX,
-				   socket_id, is_splitq);
+				   numa_id, is_splitq);
 	if (mz == NULL) {
 		ret = -ENOMEM;
 		goto err_mz_reserve;
@@ -422,10 +422,10 @@ cpfl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	rxq->mz = mz;
 
 	if (!is_splitq) {
-		rxq->sw_ring = rte_zmalloc_socket("cpfl rxq sw ring",
+		rxq->sw_ring = rte_zmalloc_numa("cpfl rxq sw ring",
 						  sizeof(struct rte_mbuf *) * len,
 						  RTE_CACHE_LINE_SIZE,
-						  socket_id);
+						  numa_id);
 		if (rxq->sw_ring == NULL) {
 			PMD_INIT_LOG(ERR, "Failed to allocate memory for SW ring");
 			ret = -ENOMEM;
@@ -442,7 +442,7 @@ cpfl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		/* Setup Rx buffer queues */
 		ret = cpfl_rx_split_bufq_setup(dev, rxq, 2 * queue_idx,
 					       rx_free_thresh, nb_desc,
-					       socket_id, mp, 1);
+					       numa_id, mp, 1);
 		if (ret != 0) {
 			PMD_INIT_LOG(ERR, "Failed to setup buffer queue 1");
 			ret = -EINVAL;
@@ -451,7 +451,7 @@ cpfl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 
 		ret = cpfl_rx_split_bufq_setup(dev, rxq, 2 * queue_idx + 1,
 					       rx_free_thresh, nb_desc,
-					       socket_id, mp, 2);
+					       numa_id, mp, 2);
 		if (ret != 0) {
 			PMD_INIT_LOG(ERR, "Failed to setup buffer queue 2");
 			ret = -EINVAL;
@@ -479,7 +479,7 @@ cpfl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 static int
 cpfl_tx_complq_setup(struct rte_eth_dev *dev, struct ci_tx_queue *txq,
 		     uint16_t queue_idx, uint16_t nb_desc,
-		     unsigned int socket_id)
+		     unsigned int numa_id)
 {
 	struct cpfl_vport *cpfl_vport = dev->data->dev_private;
 	struct idpf_vport *vport = &cpfl_vport->base;
@@ -487,10 +487,10 @@ cpfl_tx_complq_setup(struct rte_eth_dev *dev, struct ci_tx_queue *txq,
 	struct idpf_complq *cq;
 	int ret;
 
-	cq = rte_zmalloc_socket("cpfl splitq cq",
+	cq = rte_zmalloc_numa("cpfl splitq cq",
 				sizeof(*cq),
 				RTE_CACHE_LINE_SIZE,
-				socket_id);
+				numa_id);
 	if (cq == NULL) {
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for Tx compl queue");
 		ret = -ENOMEM;
@@ -505,7 +505,7 @@ cpfl_tx_complq_setup(struct rte_eth_dev *dev, struct ci_tx_queue *txq,
 
 	mz = cpfl_dma_zone_reserve(dev, queue_idx, nb_desc,
 				   VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION,
-				   socket_id, true);
+				   numa_id, true);
 	if (mz == NULL) {
 		ret = -ENOMEM;
 		goto err_mz_reserve;
@@ -527,7 +527,7 @@ cpfl_tx_complq_setup(struct rte_eth_dev *dev, struct ci_tx_queue *txq,
 
 int
 cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
-		    uint16_t nb_desc, unsigned int socket_id,
+		    uint16_t nb_desc, unsigned int numa_id,
 		    const struct rte_eth_txconf *tx_conf)
 {
 	struct cpfl_vport *cpfl_vport = dev->data->dev_private;
@@ -558,10 +558,10 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	}
 
 	/* Allocate the TX queue data structure. */
-	cpfl_txq = rte_zmalloc_socket("cpfl txq",
+	cpfl_txq = rte_zmalloc_numa("cpfl txq",
 				 sizeof(struct cpfl_tx_queue),
 				 RTE_CACHE_LINE_SIZE,
-				 socket_id);
+				 numa_id);
 	if (cpfl_txq == NULL) {
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for tx queue structure");
 		ret = -ENOMEM;
@@ -587,7 +587,7 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 
 	/* Allocate TX hardware ring descriptors. */
 	mz = cpfl_dma_zone_reserve(dev, queue_idx, nb_desc, VIRTCHNL2_QUEUE_TYPE_TX,
-				   socket_id, is_splitq);
+				   numa_id, is_splitq);
 	if (mz == NULL) {
 		ret = -ENOMEM;
 		goto err_mz_reserve;
@@ -596,9 +596,9 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	txq->mz = mz;
 
 	if (!is_splitq) {
-		txq->sw_ring = rte_zmalloc_socket("cpfl tx sw ring",
+		txq->sw_ring = rte_zmalloc_numa("cpfl tx sw ring",
 				sizeof(struct ci_tx_entry) * nb_desc,
-				RTE_CACHE_LINE_SIZE, socket_id);
+				RTE_CACHE_LINE_SIZE, numa_id);
 		if (txq->sw_ring == NULL) {
 			PMD_INIT_LOG(ERR, "Failed to allocate memory for SW TX ring");
 			ret = -ENOMEM;
@@ -607,9 +607,9 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 
 		/* Allocate RS last_id tracking array */
 		const uint16_t num_rs_buckets = nb_desc / tx_rs_thresh;
-		txq->rs_last_id = rte_zmalloc_socket("cpfl tx rs_last_id",
+		txq->rs_last_id = rte_zmalloc_numa("cpfl tx rs_last_id",
 				sizeof(txq->rs_last_id[0]) * num_rs_buckets,
-				RTE_CACHE_LINE_SIZE, socket_id);
+				RTE_CACHE_LINE_SIZE, numa_id);
 		if (txq->rs_last_id == NULL) {
 			PMD_INIT_LOG(ERR, "Failed to allocate memory for RS last_id array");
 			ret = -ENOMEM;
@@ -620,14 +620,14 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		idpf_qc_single_tx_queue_reset(txq);
 	} else {
 		txq->desc_ring = mz->addr;
-		ret = idpf_qc_split_tx_pending_alloc(txq, socket_id);
+		ret = idpf_qc_split_tx_pending_alloc(txq, numa_id);
 		if (ret != 0)
 			goto err_sw_ring_alloc;
 		idpf_qc_split_tx_descq_reset(txq);
 
 		/* Setup tx completion queue if split model */
 		ret = cpfl_tx_complq_setup(dev, txq, queue_idx,
-					   2 * nb_desc, socket_id);
+					   2 * nb_desc, numa_id);
 		if (ret != 0)
 			goto err_complq_setup;
 	}
@@ -735,10 +735,10 @@ cpfl_rx_hairpin_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	}
 
 	/* Setup Rx description queue */
-	cpfl_rxq = rte_zmalloc_socket("cpfl hairpin rxq",
+	cpfl_rxq = rte_zmalloc_numa("cpfl hairpin rxq",
 				 sizeof(struct cpfl_rx_queue),
 				 RTE_CACHE_LINE_SIZE,
-				 SOCKET_ID_ANY);
+				 RTE_NUMA_ID_ANY);
 	if (!cpfl_rxq) {
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for rx queue data structure");
 		return -ENOMEM;
@@ -761,10 +761,10 @@ cpfl_rx_hairpin_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		cpfl_vport->p2p_manual_bind = false;
 
 	if (cpfl_vport->p2p_rx_bufq == NULL) {
-		bufq1 = rte_zmalloc_socket("hairpin rx bufq1",
+		bufq1 = rte_zmalloc_numa("hairpin rx bufq1",
 					   sizeof(struct idpf_rx_queue),
 					   RTE_CACHE_LINE_SIZE,
-					   SOCKET_ID_ANY);
+					   RTE_NUMA_ID_ANY);
 		if (!bufq1) {
 			PMD_INIT_LOG(ERR, "Failed to allocate memory for hairpin Rx buffer queue 1.");
 			ret = -ENOMEM;
@@ -847,10 +847,10 @@ cpfl_tx_hairpin_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	}
 
 	/* Allocate the TX queue data structure. */
-	cpfl_txq = rte_zmalloc_socket("cpfl hairpin txq",
+	cpfl_txq = rte_zmalloc_numa("cpfl hairpin txq",
 				 sizeof(struct cpfl_tx_queue),
 				 RTE_CACHE_LINE_SIZE,
-				 SOCKET_ID_ANY);
+				 RTE_NUMA_ID_ANY);
 	if (!cpfl_txq) {
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for tx queue structure");
 		return -ENOMEM;
@@ -893,7 +893,7 @@ cpfl_tx_hairpin_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		cpfl_hw_qtail_get(cpfl_vport->p2p_q_chunks_info->tx_qtail_start,
 				  logic_qid, cpfl_vport->p2p_q_chunks_info->tx_qtail_spacing);
 	if (cpfl_vport->p2p_tx_complq == NULL) {
-		cq = rte_zmalloc_socket("cpfl hairpin cq",
+		cq = rte_zmalloc_numa("cpfl hairpin cq",
 					sizeof(struct idpf_complq),
 					RTE_CACHE_LINE_SIZE,
 					dev->device->numa_node);
diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.h b/drivers/net/intel/cpfl/cpfl_rxtx.h
index 52cdecac88..6ae03b1a75 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.h
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.h
@@ -88,10 +88,10 @@ cpfl_hw_qtail_get(uint64_t tail_start, uint16_t offset, uint64_t tail_spacing)
 }
 
 int cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
-			uint16_t nb_desc, unsigned int socket_id,
+			uint16_t nb_desc, unsigned int numa_id,
 			const struct rte_eth_txconf *tx_conf);
 int cpfl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
-			uint16_t nb_desc, unsigned int socket_id,
+			uint16_t nb_desc, unsigned int numa_id,
 			const struct rte_eth_rxconf *rx_conf,
 			struct rte_mempool *mp);
 int cpfl_rx_queue_init(struct rte_eth_dev *dev, uint16_t rx_queue_id);
diff --git a/drivers/net/intel/e1000/e1000_ethdev.h b/drivers/net/intel/e1000/e1000_ethdev.h
index 0907c7c259..539fe1e028 100644
--- a/drivers/net/intel/e1000/e1000_ethdev.h
+++ b/drivers/net/intel/e1000/e1000_ethdev.h
@@ -410,7 +410,7 @@ uint64_t igb_get_rx_port_offloads_capa(struct rte_eth_dev *dev);
 uint64_t igb_get_rx_queue_offloads_capa(struct rte_eth_dev *dev);
 
 int eth_igb_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
-		uint16_t nb_rx_desc, unsigned int socket_id,
+		uint16_t nb_rx_desc, unsigned int numa_id,
 		const struct rte_eth_rxconf *rx_conf,
 		struct rte_mempool *mb_pool);
 
@@ -423,7 +423,7 @@ uint64_t igb_get_tx_port_offloads_capa(struct rte_eth_dev *dev);
 uint64_t igb_get_tx_queue_offloads_capa(struct rte_eth_dev *dev);
 
 int eth_igb_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
-		uint16_t nb_tx_desc, unsigned int socket_id,
+		uint16_t nb_tx_desc, unsigned int numa_id,
 		const struct rte_eth_txconf *tx_conf);
 
 int eth_igb_tx_done_cleanup(void *txq, uint32_t free_cnt);
@@ -484,7 +484,7 @@ uint64_t em_get_rx_port_offloads_capa(void);
 uint64_t em_get_rx_queue_offloads_capa(void);
 
 int eth_em_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
-		uint16_t nb_rx_desc, unsigned int socket_id,
+		uint16_t nb_rx_desc, unsigned int numa_id,
 		const struct rte_eth_rxconf *rx_conf,
 		struct rte_mempool *mb_pool);
 
@@ -497,7 +497,7 @@ uint64_t em_get_tx_port_offloads_capa(struct rte_eth_dev *dev);
 uint64_t em_get_tx_queue_offloads_capa(struct rte_eth_dev *dev);
 
 int eth_em_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
-		uint16_t nb_tx_desc, unsigned int socket_id,
+		uint16_t nb_tx_desc, unsigned int numa_id,
 		const struct rte_eth_txconf *tx_conf);
 
 int eth_em_rx_init(struct rte_eth_dev *dev);
diff --git a/drivers/net/intel/e1000/em_rxtx.c b/drivers/net/intel/e1000/em_rxtx.c
index 3e18ac994a..47891e96a8 100644
--- a/drivers/net/intel/e1000/em_rxtx.c
+++ b/drivers/net/intel/e1000/em_rxtx.c
@@ -1193,7 +1193,7 @@ int
 eth_em_tx_queue_setup(struct rte_eth_dev *dev,
 			 uint16_t queue_idx,
 			 uint16_t nb_desc,
-			 unsigned int socket_id,
+			 unsigned int numa_id,
 			 const struct rte_eth_txconf *tx_conf)
 {
 	const struct rte_memzone *tz;
@@ -1274,7 +1274,7 @@ eth_em_tx_queue_setup(struct rte_eth_dev *dev,
 	 */
 	tsize = sizeof(txq->tx_ring[0]) * E1000_MAX_RING_DESC;
 	tz = rte_eth_dma_zone_reserve(dev, "tx_ring", queue_idx, tsize,
-				      RTE_CACHE_LINE_SIZE, socket_id);
+				      RTE_CACHE_LINE_SIZE, numa_id);
 	if (tz == NULL)
 		return -ENOMEM;
 
@@ -1393,7 +1393,7 @@ int
 eth_em_rx_queue_setup(struct rte_eth_dev *dev,
 		uint16_t queue_idx,
 		uint16_t nb_desc,
-		unsigned int socket_id,
+		unsigned int numa_id,
 		const struct rte_eth_rxconf *rx_conf,
 		struct rte_mempool *mp)
 {
@@ -1437,7 +1437,7 @@ eth_em_rx_queue_setup(struct rte_eth_dev *dev,
 	/* Allocate RX ring for max possible mumber of hardware descriptors. */
 	rsize = sizeof(rxq->rx_ring[0]) * E1000_MAX_RING_DESC;
 	rz = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_idx, rsize,
-				      RTE_CACHE_LINE_SIZE, socket_id);
+				      RTE_CACHE_LINE_SIZE, numa_id);
 	if (rz == NULL)
 		return -ENOMEM;
 
diff --git a/drivers/net/intel/e1000/igb_rxtx.c b/drivers/net/intel/e1000/igb_rxtx.c
index ef531f1cd4..c91c7fc6fd 100644
--- a/drivers/net/intel/e1000/igb_rxtx.c
+++ b/drivers/net/intel/e1000/igb_rxtx.c
@@ -1498,7 +1498,7 @@ int
 eth_igb_tx_queue_setup(struct rte_eth_dev *dev,
 			 uint16_t queue_idx,
 			 uint16_t nb_desc,
-			 unsigned int socket_id,
+			 unsigned int numa_id,
 			 const struct rte_eth_txconf *tx_conf)
 {
 	const struct rte_memzone *tz;
@@ -1556,7 +1556,7 @@ eth_igb_tx_queue_setup(struct rte_eth_dev *dev,
 	 */
 	size = sizeof(union e1000_adv_tx_desc) * E1000_MAX_RING_DESC;
 	tz = rte_eth_dma_zone_reserve(dev, "tx_ring", queue_idx, size,
-				      E1000_ALIGN, socket_id);
+				      E1000_ALIGN, numa_id);
 	if (tz == NULL) {
 		igb_tx_queue_release(txq);
 		return -ENOMEM;
@@ -1697,7 +1697,7 @@ int
 eth_igb_rx_queue_setup(struct rte_eth_dev *dev,
 			 uint16_t queue_idx,
 			 uint16_t nb_desc,
-			 unsigned int socket_id,
+			 unsigned int numa_id,
 			 const struct rte_eth_rxconf *rx_conf,
 			 struct rte_mempool *mp)
 {
@@ -1760,7 +1760,7 @@ eth_igb_rx_queue_setup(struct rte_eth_dev *dev,
 	 */
 	size = sizeof(union e1000_adv_rx_desc) * E1000_MAX_RING_DESC;
 	rz = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_idx, size,
-				      E1000_ALIGN, socket_id);
+				      E1000_ALIGN, numa_id);
 	if (rz == NULL) {
 		igb_rx_queue_release(rxq);
 		return -ENOMEM;
diff --git a/drivers/net/intel/e1000/igc_txrx.c b/drivers/net/intel/e1000/igc_txrx.c
index dca66c3c2c..468327287f 100644
--- a/drivers/net/intel/e1000/igc_txrx.c
+++ b/drivers/net/intel/e1000/igc_txrx.c
@@ -1260,7 +1260,7 @@ int
 eth_igc_rx_queue_setup(struct rte_eth_dev *dev,
 			 uint16_t queue_idx,
 			 uint16_t nb_desc,
-			 unsigned int socket_id,
+			 unsigned int numa_id,
 			 const struct rte_eth_rxconf *rx_conf,
 			 struct rte_mempool *mp)
 {
@@ -1313,7 +1313,7 @@ eth_igc_rx_queue_setup(struct rte_eth_dev *dev,
 	 */
 	size = sizeof(union e1000_adv_rx_desc) * IGC_MAX_RXD;
 	rz = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_idx, size,
-				      IGC_ALIGN, socket_id);
+				      IGC_ALIGN, numa_id);
 	if (rz == NULL) {
 		igc_rx_queue_release(rxq);
 		return -ENOMEM;
@@ -2072,7 +2072,7 @@ igc_dev_clear_queues(struct rte_eth_dev *dev)
 }
 
 int eth_igc_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
-		uint16_t nb_desc, unsigned int socket_id,
+		uint16_t nb_desc, unsigned int numa_id,
 		const struct rte_eth_txconf *tx_conf)
 {
 	const struct rte_memzone *tz;
@@ -2124,7 +2124,7 @@ int eth_igc_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	 */
 	size = sizeof(union e1000_adv_tx_desc) * IGC_MAX_TXD;
 	tz = rte_eth_dma_zone_reserve(dev, "tx_ring", queue_idx, size,
-				      IGC_ALIGN, socket_id);
+				      IGC_ALIGN, numa_id);
 	if (tz == NULL) {
 		igc_tx_queue_release(txq);
 		return -ENOMEM;
diff --git a/drivers/net/intel/e1000/igc_txrx.h b/drivers/net/intel/e1000/igc_txrx.h
index 29cb138312..5d0ddca3e6 100644
--- a/drivers/net/intel/e1000/igc_txrx.h
+++ b/drivers/net/intel/e1000/igc_txrx.h
@@ -146,7 +146,7 @@ void eth_igc_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
 void eth_igc_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
 void igc_dev_clear_queues(struct rte_eth_dev *dev);
 int eth_igc_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
-		uint16_t nb_rx_desc, unsigned int socket_id,
+		uint16_t nb_rx_desc, unsigned int numa_id,
 		const struct rte_eth_rxconf *rx_conf,
 		struct rte_mempool *mb_pool);
 
@@ -157,7 +157,7 @@ int eth_igc_rx_descriptor_status(void *rx_queue, uint16_t offset);
 int eth_igc_tx_descriptor_status(void *tx_queue, uint16_t offset);
 
 int eth_igc_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
-		uint16_t nb_desc, unsigned int socket_id,
+		uint16_t nb_desc, unsigned int numa_id,
 		const struct rte_eth_txconf *tx_conf);
 int eth_igc_tx_done_cleanup(void *txqueue, uint32_t free_cnt);
 
diff --git a/drivers/net/intel/fm10k/fm10k_ethdev.c b/drivers/net/intel/fm10k/fm10k_ethdev.c
index 5aa15a8dba..ce6fb14d91 100644
--- a/drivers/net/intel/fm10k/fm10k_ethdev.c
+++ b/drivers/net/intel/fm10k/fm10k_ethdev.c
@@ -1783,7 +1783,7 @@ static uint64_t fm10k_get_rx_port_offloads_capa(struct rte_eth_dev *dev)
 
 static int
 fm10k_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
-	uint16_t nb_desc, unsigned int socket_id,
+	uint16_t nb_desc, unsigned int numa_id,
 	const struct rte_eth_rxconf *conf, struct rte_mempool *mp)
 {
 	struct fm10k_hw *hw = FM10K_DEV_PRIVATE_TO_HW(dev->data->dev_private);
@@ -1826,8 +1826,8 @@ fm10k_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
 	}
 
 	/* allocate memory for the queue structure */
-	q = rte_zmalloc_socket("fm10k", sizeof(*q), RTE_CACHE_LINE_SIZE,
-				socket_id);
+	q = rte_zmalloc_numa("fm10k", sizeof(*q), RTE_CACHE_LINE_SIZE,
+				numa_id);
 	if (q == NULL) {
 		PMD_INIT_LOG(ERR, "Cannot allocate queue structure");
 		return -ENOMEM;
@@ -1847,9 +1847,9 @@ fm10k_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
 		return -EINVAL;
 	}
 	/* allocate memory for the software ring */
-	q->sw_ring = rte_zmalloc_socket("fm10k sw ring",
+	q->sw_ring = rte_zmalloc_numa("fm10k sw ring",
 			(nb_desc + q->nb_fake_desc) * sizeof(struct rte_mbuf *),
-			RTE_CACHE_LINE_SIZE, socket_id);
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (q->sw_ring == NULL) {
 		PMD_INIT_LOG(ERR, "Cannot allocate software ring");
 		rte_free(q);
@@ -1863,7 +1863,7 @@ fm10k_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
 	 */
 	mz = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_id,
 				      FM10K_MAX_RX_RING_SZ, FM10K_ALIGN_RX_DESC,
-				      socket_id);
+				      numa_id);
 	if (mz == NULL) {
 		PMD_INIT_LOG(ERR, "Cannot allocate hardware ring");
 		rte_free(q->sw_ring);
@@ -1973,7 +1973,7 @@ static uint64_t fm10k_get_tx_port_offloads_capa(struct rte_eth_dev *dev)
 
 static int
 fm10k_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
-	uint16_t nb_desc, unsigned int socket_id,
+	uint16_t nb_desc, unsigned int numa_id,
 	const struct rte_eth_txconf *conf)
 {
 	struct fm10k_hw *hw = FM10K_DEV_PRIVATE_TO_HW(dev->data->dev_private);
@@ -2010,8 +2010,8 @@ fm10k_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
 	}
 
 	/* allocate memory for the queue structure */
-	q = rte_zmalloc_socket("fm10k", sizeof(*q), RTE_CACHE_LINE_SIZE,
-				socket_id);
+	q = rte_zmalloc_numa("fm10k", sizeof(*q), RTE_CACHE_LINE_SIZE,
+				numa_id);
 	if (q == NULL) {
 		PMD_INIT_LOG(ERR, "Cannot allocate queue structure");
 		return -ENOMEM;
@@ -2031,9 +2031,9 @@ fm10k_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
 	}
 
 	/* allocate memory for the software ring */
-	q->sw_ring = rte_zmalloc_socket("fm10k sw ring",
+	q->sw_ring = rte_zmalloc_numa("fm10k sw ring",
 					nb_desc * sizeof(struct rte_mbuf *),
-					RTE_CACHE_LINE_SIZE, socket_id);
+					RTE_CACHE_LINE_SIZE, numa_id);
 	if (q->sw_ring == NULL) {
 		PMD_INIT_LOG(ERR, "Cannot allocate software ring");
 		rte_free(q);
@@ -2047,7 +2047,7 @@ fm10k_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
 	 */
 	mz = rte_eth_dma_zone_reserve(dev, "tx_ring", queue_id,
 				      FM10K_MAX_TX_RING_SZ, FM10K_ALIGN_TX_DESC,
-				      socket_id);
+				      numa_id);
 	if (mz == NULL) {
 		PMD_INIT_LOG(ERR, "Cannot allocate hardware ring");
 		rte_free(q->sw_ring);
@@ -2061,10 +2061,10 @@ fm10k_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
 	 * allocate memory for the RS bit tracker. Enough slots to hold the
 	 * descriptor index for each RS bit needing to be set are required.
 	 */
-	q->rs_tracker.list = rte_zmalloc_socket("fm10k rs tracker",
+	q->rs_tracker.list = rte_zmalloc_numa("fm10k rs tracker",
 				((nb_desc + 1) / q->rs_thresh) *
 				sizeof(uint16_t),
-				RTE_CACHE_LINE_SIZE, socket_id);
+				RTE_CACHE_LINE_SIZE, numa_id);
 	if (q->rs_tracker.list == NULL) {
 		PMD_INIT_LOG(ERR, "Cannot allocate RS bit tracker");
 		rte_free(q->sw_ring);
diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 66db44aaa1..a1eeccad23 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -4462,7 +4462,7 @@ i40e_allocate_dma_mem_d(__rte_unused struct i40e_hw *hw,
 
 	snprintf(z_name, sizeof(z_name), "i40e_dma_%" PRIu64,
 		rte_atomic_fetch_add_explicit(&i40e_dma_memzone_id, 1, rte_memory_order_relaxed));
-	mz = rte_memzone_reserve_bounded(z_name, size, SOCKET_ID_ANY,
+	mz = rte_memzone_reserve_bounded(z_name, size, RTE_NUMA_ID_ANY,
 			RTE_MEMZONE_IOVA_CONTIG, alignment, RTE_PGSIZE_2M);
 	if (!mz)
 		return I40E_ERR_NO_MEMORY;
diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index e5e136f554..8ba51c923e 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -1383,7 +1383,7 @@ int i40e_fdir_setup(struct i40e_pf *pf);
 void i40e_vsi_enable_queues_intr(struct i40e_vsi *vsi);
 const struct rte_memzone *i40e_memzone_reserve(const char *name,
 					uint32_t len,
-					int socket_id);
+					int numa_id);
 void i40e_fdir_rx_proc_sync(struct rte_eth_dev_data *dev_data);
 void i40e_fdir_teardown(struct i40e_pf *pf);
 int i40e_fdir_engine_init(struct i40e_pf *pf);
diff --git a/drivers/net/intel/i40e/i40e_fdir.c b/drivers/net/intel/i40e/i40e_fdir.c
index 11e11b6713..f3323d194b 100644
--- a/drivers/net/intel/i40e/i40e_fdir.c
+++ b/drivers/net/intel/i40e/i40e_fdir.c
@@ -228,7 +228,7 @@ i40e_fdir_setup(struct i40e_pf *pf)
 			I40E_FDIR_MZ_NAME,
 			eth_dev->data->port_id);
 	mz = i40e_memzone_reserve(z_name, I40E_FDIR_PKT_LEN *
-			I40E_FDIR_PRG_PKT_CNT, SOCKET_ID_ANY);
+			I40E_FDIR_PRG_PKT_CNT, RTE_NUMA_ID_ANY);
 	if (!mz) {
 		PMD_DRV_LOG(ERR, "Cannot init memzone for "
 				 "flow director program packet.");
@@ -978,7 +978,7 @@ i40e_fdir_flow_store_init(struct rte_eth_dev *dev)
 		.key_len = sizeof(struct i40e_fdir_input),
 		.hash_func = rte_hash_crc,
 		.hash_func_init_val = 0,
-		.socket_id = rte_socket_id(),
+		.numa_id = rte_numa_id(),
 	};
 	char fdir_pool_name[RTE_MEMPOOL_NAMESIZE];
 	int ret;
@@ -1006,7 +1006,7 @@ i40e_fdir_flow_store_init(struct rte_eth_dev *dev)
 			RTE_MAX(i40e_flow_engine_fdir.flow_size,
 				i40e_flow_engine_fdir_ethertype.flow_size),
 			0, 0, NULL, NULL, NULL, NULL,
-			rte_socket_id(),
+			rte_numa_id(),
 			/* pack flows tightly */
 			RTE_MEMPOOL_F_NO_SPREAD | RTE_MEMPOOL_F_NO_CACHE_ALIGN |
 			RTE_MEMPOOL_F_NO_IOVA_CONTIG |
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 8bfd1e07d2..389f1448c9 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -1637,7 +1637,7 @@ int
 i40e_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			uint16_t queue_idx,
 			uint16_t nb_desc,
-			unsigned int socket_id,
+			unsigned int numa_id,
 			const struct rte_eth_rxconf *rx_conf,
 			struct rte_mempool *mp)
 {
@@ -1689,10 +1689,10 @@ i40e_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	/* Allocate the rx queue data structure */
-	rxq = rte_zmalloc_socket("i40e rx queue",
+	rxq = rte_zmalloc_numa("i40e rx queue",
 				 sizeof(struct ci_rx_queue),
 				 RTE_CACHE_LINE_SIZE,
-				 socket_id);
+				 numa_id);
 	if (!rxq) {
 		PMD_DRV_LOG(ERR, "Failed to allocate memory for "
 			    "rx queue data structure");
@@ -1726,7 +1726,7 @@ i40e_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			      I40E_DMA_MEM_ALIGN);
 
 	rz = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_idx,
-			      ring_size, I40E_RING_BASE_ALIGN, socket_id);
+			      ring_size, I40E_RING_BASE_ALIGN, numa_id);
 	if (!rz) {
 		i40e_rx_queue_release(rxq);
 		PMD_DRV_LOG(ERR, "Failed to reserve DMA memory for RX");
@@ -1744,10 +1744,10 @@ i40e_dev_rx_queue_setup(struct rte_eth_dev *dev,
 
 	/* Allocate the software ring. */
 	rxq->sw_ring =
-		rte_zmalloc_socket("i40e rx sw ring",
+		rte_zmalloc_numa("i40e rx sw ring",
 				   sizeof(struct ci_rx_entry) * len,
 				   RTE_CACHE_LINE_SIZE,
-				   socket_id);
+				   numa_id);
 	if (!rxq->sw_ring) {
 		i40e_rx_queue_release(rxq);
 		PMD_DRV_LOG(ERR, "Failed to allocate memory for SW ring");
@@ -1965,7 +1965,7 @@ int
 i40e_dev_tx_queue_setup(struct rte_eth_dev *dev,
 			uint16_t queue_idx,
 			uint16_t nb_desc,
-			unsigned int socket_id,
+			unsigned int numa_id,
 			const struct rte_eth_txconf *tx_conf)
 {
 	struct i40e_vsi *vsi;
@@ -2106,10 +2106,10 @@ i40e_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	/* Allocate the TX queue data structure. */
-	txq = rte_zmalloc_socket("i40e tx queue",
+	txq = rte_zmalloc_numa("i40e tx queue",
 				  sizeof(struct ci_tx_queue),
 				  RTE_CACHE_LINE_SIZE,
-				  socket_id);
+				  numa_id);
 	if (!txq) {
 		PMD_DRV_LOG(ERR, "Failed to allocate memory for "
 			    "tx queue structure");
@@ -2120,7 +2120,7 @@ i40e_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	ring_size = sizeof(struct ci_tx_desc) * I40E_MAX_RING_DESC;
 	ring_size = RTE_ALIGN(ring_size, I40E_DMA_MEM_ALIGN);
 	tz = rte_eth_dma_zone_reserve(dev, "ci_tx_ring", queue_idx,
-			      ring_size, I40E_RING_BASE_ALIGN, socket_id);
+			      ring_size, I40E_RING_BASE_ALIGN, numa_id);
 	if (!tz) {
 		i40e_tx_queue_release(txq);
 		PMD_DRV_LOG(ERR, "Failed to reserve DMA memory for TX");
@@ -2146,10 +2146,10 @@ i40e_dev_tx_queue_setup(struct rte_eth_dev *dev,
 
 	/* Allocate software ring */
 	txq->sw_ring =
-		rte_zmalloc_socket("i40e tx sw ring",
+		rte_zmalloc_numa("i40e tx sw ring",
 				   sizeof(struct ci_tx_entry) * nb_desc,
 				   RTE_CACHE_LINE_SIZE,
-				   socket_id);
+				   numa_id);
 	if (!txq->sw_ring) {
 		i40e_tx_queue_release(txq);
 		PMD_DRV_LOG(ERR, "Failed to allocate memory for SW TX ring");
@@ -2158,8 +2158,8 @@ i40e_dev_tx_queue_setup(struct rte_eth_dev *dev,
 
 	/* Allocate RS last_id tracking array */
 	uint16_t num_rs_buckets = nb_desc / tx_rs_thresh;
-	txq->rs_last_id = rte_zmalloc_socket(NULL, sizeof(txq->rs_last_id[0]) * num_rs_buckets,
-			RTE_CACHE_LINE_SIZE, socket_id);
+	txq->rs_last_id = rte_zmalloc_numa(NULL, sizeof(txq->rs_last_id[0]) * num_rs_buckets,
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq->rs_last_id == NULL) {
 		i40e_tx_queue_release(txq);
 		PMD_DRV_LOG(ERR, "Failed to allocate memory for RS last_id array");
@@ -2217,7 +2217,7 @@ i40e_tx_queue_release(void *txq)
 }
 
 const struct rte_memzone *
-i40e_memzone_reserve(const char *name, uint32_t len, int socket_id)
+i40e_memzone_reserve(const char *name, uint32_t len, int numa_id)
 {
 	const struct rte_memzone *mz;
 
@@ -2225,7 +2225,7 @@ i40e_memzone_reserve(const char *name, uint32_t len, int socket_id)
 	if (mz)
 		return mz;
 
-	mz = rte_memzone_reserve_aligned(name, len, socket_id,
+	mz = rte_memzone_reserve_aligned(name, len, numa_id,
 			RTE_MEMZONE_IOVA_CONTIG, I40E_RING_BASE_ALIGN);
 	return mz;
 }
@@ -2720,10 +2720,10 @@ i40e_fdir_setup_tx_resources(struct i40e_pf *pf)
 	dev = &rte_eth_devices[pf->dev_data->port_id];
 
 	/* Allocate the TX queue data structure. */
-	txq = rte_zmalloc_socket("i40e fdir tx queue",
+	txq = rte_zmalloc_numa("i40e fdir tx queue",
 				  sizeof(struct ci_tx_queue),
 				  RTE_CACHE_LINE_SIZE,
-				  SOCKET_ID_ANY);
+				  RTE_NUMA_ID_ANY);
 	if (!txq) {
 		PMD_DRV_LOG(ERR, "Failed to allocate memory for "
 					"tx queue structure.");
@@ -2736,7 +2736,7 @@ i40e_fdir_setup_tx_resources(struct i40e_pf *pf)
 
 	tz = rte_eth_dma_zone_reserve(dev, "fdir_tx_ring",
 				      I40E_FDIR_QUEUE_ID, ring_size,
-				      I40E_RING_BASE_ALIGN, SOCKET_ID_ANY);
+				      I40E_RING_BASE_ALIGN, RTE_NUMA_ID_ANY);
 	if (!tz) {
 		i40e_tx_queue_release(txq);
 		PMD_DRV_LOG(ERR, "Failed to reserve DMA memory for TX.");
@@ -2779,10 +2779,10 @@ i40e_fdir_setup_rx_resources(struct i40e_pf *pf)
 	dev = &rte_eth_devices[pf->dev_data->port_id];
 
 	/* Allocate the RX queue data structure. */
-	rxq = rte_zmalloc_socket("i40e fdir rx queue",
+	rxq = rte_zmalloc_numa("i40e fdir rx queue",
 				  sizeof(struct ci_rx_queue),
 				  RTE_CACHE_LINE_SIZE,
-				  SOCKET_ID_ANY);
+				  RTE_NUMA_ID_ANY);
 	if (!rxq) {
 		PMD_DRV_LOG(ERR, "Failed to allocate memory for "
 					"rx queue structure.");
@@ -2795,7 +2795,7 @@ i40e_fdir_setup_rx_resources(struct i40e_pf *pf)
 
 	rz = rte_eth_dma_zone_reserve(dev, "fdir_rx_ring",
 				      I40E_FDIR_QUEUE_ID, ring_size,
-				      I40E_RING_BASE_ALIGN, SOCKET_ID_ANY);
+				      I40E_RING_BASE_ALIGN, RTE_NUMA_ID_ANY);
 	if (!rz) {
 		i40e_rx_queue_release(rxq);
 		PMD_DRV_LOG(ERR, "Failed to reserve DMA memory for RX.");
diff --git a/drivers/net/intel/i40e/i40e_rxtx.h b/drivers/net/intel/i40e/i40e_rxtx.h
index 0977342064..c4eb1b43de 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.h
+++ b/drivers/net/intel/i40e/i40e_rxtx.h
@@ -116,13 +116,13 @@ const uint32_t *i40e_dev_supported_ptypes_get(struct rte_eth_dev *dev,
 int i40e_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			    uint16_t queue_idx,
 			    uint16_t nb_desc,
-			    unsigned int socket_id,
+			    unsigned int numa_id,
 			    const struct rte_eth_rxconf *rx_conf,
 			    struct rte_mempool *mp);
 int i40e_dev_tx_queue_setup(struct rte_eth_dev *dev,
 			    uint16_t queue_idx,
 			    uint16_t nb_desc,
-			    unsigned int socket_id,
+			    unsigned int numa_id,
 			    const struct rte_eth_txconf *tx_conf);
 void i40e_rx_queue_release(void *rxq);
 void i40e_tx_queue_release(void *txq);
diff --git a/drivers/net/intel/i40e/i40e_vf_representor.c b/drivers/net/intel/i40e/i40e_vf_representor.c
index e8f0bb62a0..35f2d2abf3 100644
--- a/drivers/net/intel/i40e/i40e_vf_representor.c
+++ b/drivers/net/intel/i40e/i40e_vf_representor.c
@@ -131,7 +131,7 @@ static int
 i40e_vf_representor_rx_queue_setup(__rte_unused struct rte_eth_dev *dev,
 	__rte_unused uint16_t rx_queue_id,
 	__rte_unused uint16_t nb_rx_desc,
-	__rte_unused unsigned int socket_id,
+	__rte_unused unsigned int numa_id,
 	__rte_unused const struct rte_eth_rxconf *rx_conf,
 	__rte_unused struct rte_mempool *mb_pool)
 {
@@ -142,7 +142,7 @@ static int
 i40e_vf_representor_tx_queue_setup(__rte_unused struct rte_eth_dev *dev,
 	__rte_unused uint16_t rx_queue_id,
 	__rte_unused uint16_t nb_rx_desc,
-	__rte_unused unsigned int socket_id,
+	__rte_unused unsigned int numa_id,
 	__rte_unused const struct rte_eth_txconf *tx_conf)
 {
 	return 0;
diff --git a/drivers/net/intel/iavf/iavf_osdep.c b/drivers/net/intel/iavf/iavf_osdep.c
index c0ff301be5..732118dadb 100644
--- a/drivers/net/intel/iavf/iavf_osdep.c
+++ b/drivers/net/intel/iavf/iavf_osdep.c
@@ -27,7 +27,7 @@ iavf_allocate_dma_mem_d(__rte_unused struct iavf_hw *hw,
 
 	snprintf(z_name, sizeof(z_name), "iavf_dma_%" PRIu64,
 		rte_atomic_fetch_add_explicit(&iavf_dma_memzone_id, 1, rte_memory_order_relaxed));
-	mz = rte_memzone_reserve_bounded(z_name, size, SOCKET_ID_ANY,
+	mz = rte_memzone_reserve_bounded(z_name, size, RTE_NUMA_ID_ANY,
 					 RTE_MEMZONE_IOVA_CONTIG, alignment,
 					 RTE_PGSIZE_2M);
 	if (!mz)
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 84b931e78a..6be1870099 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -534,7 +534,7 @@ iavf_select_rxd_to_pkt_fields_handler(struct ci_rx_queue *rxq, uint32_t rxdid)
 
 int
 iavf_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
-		       uint16_t nb_desc, unsigned int socket_id,
+		       uint16_t nb_desc, unsigned int numa_id,
 		       const struct rte_eth_rxconf *rx_conf,
 		       struct rte_mempool *mp)
 {
@@ -588,10 +588,10 @@ iavf_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	}
 
 	/* Allocate the rx queue data structure */
-	rxq = rte_zmalloc_socket("iavf rxq",
+	rxq = rte_zmalloc_numa("iavf rxq",
 				 sizeof(struct ci_rx_queue),
 				 RTE_CACHE_LINE_SIZE,
-				 socket_id);
+				 numa_id);
 	if (!rxq) {
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for "
 			     "rx queue data structure");
@@ -599,10 +599,10 @@ iavf_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	}
 
 	/* Allocate stats */
-	rxq->stats = rte_zmalloc_socket("iavf rxq stats",
+	rxq->stats = rte_zmalloc_numa("iavf rxq stats",
 				 sizeof(struct iavf_rx_queue_stats),
 				 RTE_CACHE_LINE_SIZE,
-				 socket_id);
+				 numa_id);
 	if (!rxq->stats) {
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for "
 			     "rx queue stats");
@@ -662,10 +662,10 @@ iavf_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	/* Allocate the software ring. */
 	len = nb_desc + IAVF_RX_MAX_BURST;
 	rxq->sw_ring =
-		rte_zmalloc_socket("iavf rx sw ring",
+		rte_zmalloc_numa("iavf rx sw ring",
 				   sizeof(struct rte_mbuf *) * len,
 				   RTE_CACHE_LINE_SIZE,
-				   socket_id);
+				   numa_id);
 	if (!rxq->sw_ring) {
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for SW ring");
 		rte_free(rxq->stats);
@@ -681,7 +681,7 @@ iavf_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 			      IAVF_DMA_MEM_ALIGN);
 	mz = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_idx,
 				      ring_size, IAVF_RING_BASE_ALIGN,
-				      socket_id);
+				      numa_id);
 	if (!mz) {
 		PMD_INIT_LOG(ERR, "Failed to reserve DMA memory for RX");
 		rte_free(rxq->sw_ring);
@@ -729,7 +729,7 @@ int
 iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
 		       uint16_t queue_idx,
 		       uint16_t nb_desc,
-		       unsigned int socket_id,
+		       unsigned int numa_id,
 		       const struct rte_eth_txconf *tx_conf)
 {
 	struct iavf_hw *hw = IAVF_DEV_PRIVATE_TO_HW(dev->data->dev_private);
@@ -773,10 +773,10 @@ iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	/* Allocate the TX queue data structure. */
-	txq = rte_zmalloc_socket("iavf txq",
+	txq = rte_zmalloc_numa("iavf txq",
 				 sizeof(struct ci_tx_queue),
 				 RTE_CACHE_LINE_SIZE,
-				 socket_id);
+				 numa_id);
 	if (!txq) {
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for "
 			     "tx queue structure");
@@ -822,10 +822,10 @@ iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
 
 	/* Allocate software ring */
 	txq->sw_ring =
-		rte_zmalloc_socket("iavf tx sw ring",
+		rte_zmalloc_numa("iavf tx sw ring",
 				   sizeof(struct ci_tx_entry) * nb_desc,
 				   RTE_CACHE_LINE_SIZE,
-				   socket_id);
+				   numa_id);
 	if (!txq->sw_ring) {
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for SW TX ring");
 		rte_free(txq);
@@ -834,8 +834,8 @@ iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
 
 	/* Allocate RS last_id tracking array */
 	uint16_t num_rs_buckets = nb_desc / tx_rs_thresh;
-	txq->rs_last_id = rte_zmalloc_socket(NULL, sizeof(txq->rs_last_id[0]) * num_rs_buckets,
-			RTE_CACHE_LINE_SIZE, socket_id);
+	txq->rs_last_id = rte_zmalloc_numa(NULL, sizeof(txq->rs_last_id[0]) * num_rs_buckets,
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq->rs_last_id == NULL) {
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for RS last_id array");
 		rte_free(txq->sw_ring);
@@ -848,7 +848,7 @@ iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	ring_size = RTE_ALIGN(ring_size, IAVF_DMA_MEM_ALIGN);
 	mz = rte_eth_dma_zone_reserve(dev, "ci_tx_ring", queue_idx,
 				      ring_size, IAVF_RING_BASE_ALIGN,
-				      socket_id);
+				      numa_id);
 	if (!mz) {
 		PMD_INIT_LOG(ERR, "Failed to reserve DMA memory for TX");
 		rte_free(txq->sw_ring);
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 812d7e23ee..2ebad546ae 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -452,7 +452,7 @@ enum iavf_rx_flex_desc_ipsec_crypto_status {
 int iavf_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			   uint16_t queue_idx,
 			   uint16_t nb_desc,
-			   unsigned int socket_id,
+			   unsigned int numa_id,
 			   const struct rte_eth_rxconf *rx_conf,
 			   struct rte_mempool *mp);
 
@@ -466,7 +466,7 @@ int iavf_tx_burst_mode_get(struct rte_eth_dev *dev, uint16_t queue_id,
 int iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
 			   uint16_t queue_idx,
 			   uint16_t nb_desc,
-			   unsigned int socket_id,
+			   unsigned int numa_id,
 			   const struct rte_eth_txconf *tx_conf);
 int iavf_dev_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id);
 int iavf_dev_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id);
diff --git a/drivers/net/intel/ice/ice_dcf_vf_representor.c b/drivers/net/intel/ice/ice_dcf_vf_representor.c
index 564ff02fd8..d7dcac9f6b 100644
--- a/drivers/net/intel/ice/ice_dcf_vf_representor.c
+++ b/drivers/net/intel/ice/ice_dcf_vf_representor.c
@@ -79,7 +79,7 @@ static int
 ice_dcf_vf_repr_rx_queue_setup(__rte_unused struct rte_eth_dev *dev,
 			       __rte_unused uint16_t queue_id,
 			       __rte_unused uint16_t nb_desc,
-			       __rte_unused unsigned int socket_id,
+			       __rte_unused unsigned int numa_id,
 			       __rte_unused const struct rte_eth_rxconf *conf,
 			       __rte_unused struct rte_mempool *pool)
 {
@@ -90,7 +90,7 @@ static int
 ice_dcf_vf_repr_tx_queue_setup(__rte_unused struct rte_eth_dev *dev,
 			       __rte_unused uint16_t queue_id,
 			       __rte_unused uint16_t nb_desc,
-			       __rte_unused unsigned int socket_id,
+			       __rte_unused unsigned int numa_id,
 			       __rte_unused const struct rte_eth_txconf *conf)
 {
 	return 0;
diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index 3a15abe422..34ab9fe68f 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -188,7 +188,7 @@ static int
 ice_fdir_is_tunnel_profile(enum ice_fdir_tunnel_type tunnel_type);
 
 static const struct rte_memzone *
-ice_memzone_reserve(const char *name, uint32_t len, int socket_id)
+ice_memzone_reserve(const char *name, uint32_t len, int numa_id)
 {
 	const struct rte_memzone *mz;
 
@@ -196,7 +196,7 @@ ice_memzone_reserve(const char *name, uint32_t len, int socket_id)
 	if (mz)
 		return mz;
 
-	return rte_memzone_reserve_aligned(name, len, socket_id,
+	return rte_memzone_reserve_aligned(name, len, numa_id,
 					   RTE_MEMZONE_IOVA_CONTIG,
 					   ICE_RING_BASE_ALIGN);
 }
@@ -521,7 +521,7 @@ ice_fdir_setup(struct ice_pf *pf)
 	snprintf(z_name, sizeof(z_name), "ICE_%s_%d",
 		 ICE_FDIR_MZ_NAME,
 		 eth_dev->data->port_id);
-	mz = ice_memzone_reserve(z_name, ICE_FDIR_PKT_LEN, SOCKET_ID_ANY);
+	mz = ice_memzone_reserve(z_name, ICE_FDIR_PKT_LEN, RTE_NUMA_ID_ANY);
 	if (!mz) {
 		PMD_DRV_LOG(ERR, "Cannot init memzone for "
 			    "flow director program packet.");
diff --git a/drivers/net/intel/ice/ice_osdep.h b/drivers/net/intel/ice/ice_osdep.h
index f4ec8b8994..b07834e03b 100644
--- a/drivers/net/intel/ice/ice_osdep.h
+++ b/drivers/net/intel/ice/ice_osdep.h
@@ -257,7 +257,7 @@ ice_alloc_dma_mem(__rte_unused struct ice_hw *hw,
 
 	snprintf(z_name, sizeof(z_name), "ice_dma_%" PRIu64,
 		rte_atomic_fetch_add_explicit(&ice_dma_memzone_id, 1, rte_memory_order_relaxed));
-	mz = rte_memzone_reserve_bounded(z_name, size, SOCKET_ID_ANY, 0,
+	mz = rte_memzone_reserve_bounded(z_name, size, RTE_NUMA_ID_ANY, 0,
 					 0, RTE_PGSIZE_2M);
 	if (!mz)
 		return NULL;
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 6f19e070ee..5b3dc6fe44 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -1278,7 +1278,7 @@ int
 ice_rx_queue_setup(struct rte_eth_dev *dev,
 		   uint16_t queue_idx,
 		   uint16_t nb_desc,
-		   unsigned int socket_id,
+		   unsigned int numa_id,
 		   const struct rte_eth_rxconf *rx_conf,
 		   struct rte_mempool *mp)
 {
@@ -1332,10 +1332,10 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	/* Allocate the rx queue data structure */
-	rxq = rte_zmalloc_socket(NULL,
+	rxq = rte_zmalloc_numa(NULL,
 				 sizeof(struct ci_rx_queue),
 				 RTE_CACHE_LINE_SIZE,
-				 socket_id);
+				 numa_id);
 
 	if (!rxq) {
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for "
@@ -1390,7 +1390,7 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
 	ring_size = RTE_ALIGN(ring_size, ICE_DMA_MEM_ALIGN);
 	rz = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_idx,
 				      ring_size, ICE_RING_BASE_ALIGN,
-				      socket_id);
+				      numa_id);
 	if (!rz) {
 		ice_rx_queue_release(rxq);
 		PMD_INIT_LOG(ERR, "Failed to reserve DMA memory for RX");
@@ -1413,10 +1413,10 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
 	tlen += len;
 
 	/* Allocate the software ring. */
-	rxq->sw_ring = rte_zmalloc_socket(NULL,
+	rxq->sw_ring = rte_zmalloc_numa(NULL,
 					  sizeof(struct ci_rx_entry) * tlen,
 					  RTE_CACHE_LINE_SIZE,
-					  socket_id);
+					  numa_id);
 	if (!rxq->sw_ring) {
 		ice_rx_queue_release(rxq);
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for SW ring");
@@ -1499,7 +1499,7 @@ int
 ice_tx_queue_setup(struct rte_eth_dev *dev,
 		   uint16_t queue_idx,
 		   uint16_t nb_desc,
-		   unsigned int socket_id,
+		   unsigned int numa_id,
 		   const struct rte_eth_txconf *tx_conf)
 {
 	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
@@ -1624,10 +1624,10 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	/* Allocate the TX queue data structure. */
-	txq = rte_zmalloc_socket(NULL,
+	txq = rte_zmalloc_numa(NULL,
 				 sizeof(struct ci_tx_queue),
 				 RTE_CACHE_LINE_SIZE,
-				 socket_id);
+				 numa_id);
 	if (!txq) {
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for "
 			     "tx queue structure");
@@ -1639,7 +1639,7 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
 	ring_size = RTE_ALIGN(ring_size, ICE_DMA_MEM_ALIGN);
 	tz = rte_eth_dma_zone_reserve(dev, "ci_tx_ring", queue_idx,
 				      ring_size, ICE_RING_BASE_ALIGN,
-				      socket_id);
+				      numa_id);
 	if (!tz) {
 		ice_tx_queue_release(txq);
 		PMD_INIT_LOG(ERR, "Failed to reserve DMA memory for TX");
@@ -1666,10 +1666,10 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
 
 	/* Allocate software ring */
 	txq->sw_ring =
-		rte_zmalloc_socket(NULL,
+		rte_zmalloc_numa(NULL,
 				   sizeof(struct ci_tx_entry) * nb_desc,
 				   RTE_CACHE_LINE_SIZE,
-				   socket_id);
+				   numa_id);
 	if (!txq->sw_ring) {
 		ice_tx_queue_release(txq);
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for SW TX ring");
@@ -1678,8 +1678,8 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
 
 	/* Allocate RS last_id tracking array */
 	uint16_t num_rs_buckets = nb_desc / tx_rs_thresh;
-	txq->rs_last_id = rte_zmalloc_socket(NULL, sizeof(txq->rs_last_id[0]) * num_rs_buckets,
-			RTE_CACHE_LINE_SIZE, socket_id);
+	txq->rs_last_id = rte_zmalloc_numa(NULL, sizeof(txq->rs_last_id[0]) * num_rs_buckets,
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq->rs_last_id == NULL) {
 		ice_tx_queue_release(txq);
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for RS last_id array");
@@ -1693,8 +1693,8 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
 			return -EINVAL;
 		}
 
-		txq->tsq = rte_zmalloc_socket(NULL, sizeof(struct ice_txtime),
-				RTE_CACHE_LINE_SIZE, socket_id);
+		txq->tsq = rte_zmalloc_numa(NULL, sizeof(struct ice_txtime),
+				RTE_CACHE_LINE_SIZE, numa_id);
 		if (!txq->tsq) {
 			ice_tx_queue_release(txq);
 			PMD_INIT_LOG(ERR, "Failed to allocate memory for tx time queue structure");
@@ -1714,7 +1714,7 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
 		ring_size = sizeof(struct ice_ts_desc) * txq->tsq->nb_ts_desc;
 		ring_size = RTE_ALIGN(ring_size, ICE_DMA_MEM_ALIGN);
 		const struct rte_memzone *ts_z = rte_eth_dma_zone_reserve(dev, "ice_tstamp_ring",
-				queue_idx, ring_size, ICE_RING_BASE_ALIGN, socket_id);
+				queue_idx, ring_size, ICE_RING_BASE_ALIGN, numa_id);
 		if (!ts_z) {
 			ice_tx_queue_release(txq);
 			PMD_INIT_LOG(ERR, "Failed to reserve DMA memory for TX timestamp");
@@ -2633,10 +2633,10 @@ ice_fdir_setup_tx_resources(struct ice_pf *pf)
 	dev = &rte_eth_devices[pf->adapter->pf.dev_data->port_id];
 
 	/* Allocate the TX queue data structure. */
-	txq = rte_zmalloc_socket("ice fdir tx queue",
+	txq = rte_zmalloc_numa("ice fdir tx queue",
 				 sizeof(struct ci_tx_queue),
 				 RTE_CACHE_LINE_SIZE,
-				 SOCKET_ID_ANY);
+				 RTE_NUMA_ID_ANY);
 	if (!txq) {
 		PMD_DRV_LOG(ERR, "Failed to allocate memory for "
 			    "tx queue structure.");
@@ -2649,7 +2649,7 @@ ice_fdir_setup_tx_resources(struct ice_pf *pf)
 
 	tz = rte_eth_dma_zone_reserve(dev, "fdir_tx_ring",
 				      ICE_FDIR_QUEUE_ID, ring_size,
-				      ICE_RING_BASE_ALIGN, SOCKET_ID_ANY);
+				      ICE_RING_BASE_ALIGN, RTE_NUMA_ID_ANY);
 	if (!tz) {
 		ice_tx_queue_release(txq);
 		PMD_DRV_LOG(ERR, "Failed to reserve DMA memory for TX.");
@@ -2691,10 +2691,10 @@ ice_fdir_setup_rx_resources(struct ice_pf *pf)
 	dev = &rte_eth_devices[pf->adapter->pf.dev_data->port_id];
 
 	/* Allocate the RX queue data structure. */
-	rxq = rte_zmalloc_socket("ice fdir rx queue",
+	rxq = rte_zmalloc_numa("ice fdir rx queue",
 				 sizeof(struct ci_rx_queue),
 				 RTE_CACHE_LINE_SIZE,
-				 SOCKET_ID_ANY);
+				 RTE_NUMA_ID_ANY);
 	if (!rxq) {
 		PMD_DRV_LOG(ERR, "Failed to allocate memory for "
 			    "rx queue structure.");
@@ -2707,7 +2707,7 @@ ice_fdir_setup_rx_resources(struct ice_pf *pf)
 
 	rz = rte_eth_dma_zone_reserve(dev, "fdir_rx_ring",
 				      ICE_FDIR_QUEUE_ID, ring_size,
-				      ICE_RING_BASE_ALIGN, SOCKET_ID_ANY);
+				      ICE_RING_BASE_ALIGN, RTE_NUMA_ID_ANY);
 	if (!rz) {
 		ice_rx_queue_release(rxq);
 		PMD_DRV_LOG(ERR, "Failed to reserve DMA memory for RX.");
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index 3332053d3d..15ebe0b7ad 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -209,13 +209,13 @@ struct ice_32b_rx_flex_desc_comms_ovs {
 int ice_rx_queue_setup(struct rte_eth_dev *dev,
 		       uint16_t queue_idx,
 		       uint16_t nb_desc,
-		       unsigned int socket_id,
+		       unsigned int numa_id,
 		       const struct rte_eth_rxconf *rx_conf,
 		       struct rte_mempool *mp);
 int ice_tx_queue_setup(struct rte_eth_dev *dev,
 		       uint16_t queue_idx,
 		       uint16_t nb_desc,
-		       unsigned int socket_id,
+		       unsigned int numa_id,
 		       const struct rte_eth_txconf *tx_conf);
 int ice_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id);
 int ice_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id);
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index eb29024547..2cf7be6060 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -230,12 +230,12 @@ idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq)
 
 RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_tx_pending_alloc)
 int
-idpf_qc_split_tx_pending_alloc(struct ci_tx_queue *txq, unsigned int socket_id)
+idpf_qc_split_tx_pending_alloc(struct ci_tx_queue *txq, unsigned int numa_id)
 {
 	/* Scalar completion tags and vector descriptor indices both use nb_tx_desc pointers. */
-	txq->tx_pending_pkts = rte_zmalloc_socket("idpf_tx_pending",
+	txq->tx_pending_pkts = rte_zmalloc_numa("idpf_tx_pending",
 			sizeof(struct rte_mbuf *) * txq->nb_tx_desc,
-			RTE_CACHE_LINE_SIZE, socket_id);
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq->tx_pending_pkts == NULL) {
 		DRV_LOG(ERR, "Failed to alloc idpf tx_pending shadow ring");
 		return -ENOMEM;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index a4843c9f69..a74179d233 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -216,7 +216,7 @@ void idpf_qc_single_rx_queue_reset(struct idpf_rx_queue *rxq);
 __rte_internal
 void idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq);
 __rte_internal
-int idpf_qc_split_tx_pending_alloc(struct ci_tx_queue *txq, unsigned int socket_id);
+int idpf_qc_split_tx_pending_alloc(struct ci_tx_queue *txq, unsigned int numa_id);
 __rte_internal
 void idpf_qc_split_tx_release_mbufs(struct ci_tx_queue *txq);
 __rte_internal
diff --git a/drivers/net/intel/idpf/idpf_osdep.h b/drivers/net/intel/idpf/idpf_osdep.h
index 7d99a23cf8..68b8b7bc53 100644
--- a/drivers/net/intel/idpf/idpf_osdep.h
+++ b/drivers/net/intel/idpf/idpf_osdep.h
@@ -241,7 +241,7 @@ idpf_alloc_dma_mem(__rte_unused struct idpf_hw *hw,
 		return NULL;
 
 	snprintf(z_name, sizeof(z_name), "idpf_dma_%"PRIu64, rte_rand());
-	mz = rte_memzone_reserve_aligned(z_name, size, SOCKET_ID_ANY,
+	mz = rte_memzone_reserve_aligned(z_name, size, RTE_NUMA_ID_ANY,
 					 RTE_MEMZONE_IOVA_CONTIG, RTE_PGSIZE_4K);
 	if (!mz)
 		return NULL;
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 3bee388c17..124826dc85 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -59,7 +59,7 @@ static const struct idpf_rxq_ops def_rxq_ops = {
 static const struct rte_memzone *
 idpf_dma_zone_reserve(struct rte_eth_dev *dev, uint16_t queue_idx,
 		      uint16_t len, uint16_t queue_type,
-		      unsigned int socket_id, bool splitq)
+		      unsigned int numa_id, bool splitq)
 {
 	char ring_name[RTE_MEMZONE_NAMESIZE];
 	const struct rte_memzone *mz;
@@ -102,7 +102,7 @@ idpf_dma_zone_reserve(struct rte_eth_dev *dev, uint16_t queue_idx,
 
 	mz = rte_eth_dma_zone_reserve(dev, ring_name, queue_idx,
 				      ring_size, IDPF_RING_BASE_ALIGN,
-				      socket_id);
+				      numa_id);
 	if (mz == NULL) {
 		PMD_INIT_LOG(ERR, "Failed to reserve DMA memory for ring");
 		return NULL;
@@ -123,7 +123,7 @@ idpf_dma_zone_release(const struct rte_memzone *mz)
 static int
 idpf_rx_split_bufq_setup(struct rte_eth_dev *dev, struct idpf_rx_queue *rxq,
 			 uint16_t queue_idx, uint16_t rx_free_thresh,
-			 uint16_t nb_desc, unsigned int socket_id,
+			 uint16_t nb_desc, unsigned int numa_id,
 			 struct rte_mempool *mp, uint8_t bufq_id)
 {
 	struct idpf_vport *vport = dev->data->dev_private;
@@ -134,10 +134,10 @@ idpf_rx_split_bufq_setup(struct rte_eth_dev *dev, struct idpf_rx_queue *rxq,
 	uint16_t len;
 	int ret;
 
-	bufq = rte_zmalloc_socket("idpf bufq",
+	bufq = rte_zmalloc_numa("idpf bufq",
 				   sizeof(struct idpf_rx_queue),
 				   RTE_CACHE_LINE_SIZE,
-				   socket_id);
+				   numa_id);
 	if (bufq == NULL) {
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for rx buffer queue.");
 		ret = -ENOMEM;
@@ -161,7 +161,7 @@ idpf_rx_split_bufq_setup(struct rte_eth_dev *dev, struct idpf_rx_queue *rxq,
 
 	mz = idpf_dma_zone_reserve(dev, queue_idx, len,
 				   VIRTCHNL2_QUEUE_TYPE_RX_BUFFER,
-				   socket_id, true);
+				   numa_id, true);
 	if (mz == NULL) {
 		ret = -ENOMEM;
 		goto err_mz_reserve;
@@ -172,10 +172,10 @@ idpf_rx_split_bufq_setup(struct rte_eth_dev *dev, struct idpf_rx_queue *rxq,
 	bufq->mz = mz;
 
 	bufq->sw_ring =
-		rte_zmalloc_socket("idpf rx bufq sw ring",
+		rte_zmalloc_numa("idpf rx bufq sw ring",
 				   sizeof(struct rte_mbuf *) * len,
 				   RTE_CACHE_LINE_SIZE,
-				   socket_id);
+				   numa_id);
 	if (bufq->sw_ring == NULL) {
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for SW ring");
 		ret = -ENOMEM;
@@ -220,7 +220,7 @@ idpf_rx_split_bufq_release(struct idpf_rx_queue *bufq)
 
 int
 idpf_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
-		    uint16_t nb_desc, unsigned int socket_id,
+		    uint16_t nb_desc, unsigned int numa_id,
 		    const struct rte_eth_rxconf *rx_conf,
 		    struct rte_mempool *mp)
 {
@@ -261,10 +261,10 @@ idpf_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	}
 
 	/* Setup Rx queue */
-	rxq = rte_zmalloc_socket("idpf rxq",
+	rxq = rte_zmalloc_numa("idpf rxq",
 				 sizeof(struct idpf_rx_queue),
 				 RTE_CACHE_LINE_SIZE,
-				 socket_id);
+				 numa_id);
 	if (rxq == NULL) {
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for rx queue data structure");
 		ret = -ENOMEM;
@@ -290,7 +290,7 @@ idpf_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	/* Allocate a little more to support bulk allocate. */
 	len = nb_desc + IDPF_RX_MAX_BURST;
 	mz = idpf_dma_zone_reserve(dev, queue_idx, len, VIRTCHNL2_QUEUE_TYPE_RX,
-				   socket_id, is_splitq);
+				   numa_id, is_splitq);
 	if (mz == NULL) {
 		ret = -ENOMEM;
 		goto err_mz_reserve;
@@ -300,10 +300,10 @@ idpf_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	rxq->mz = mz;
 
 	if (!is_splitq) {
-		rxq->sw_ring = rte_zmalloc_socket("idpf rxq sw ring",
+		rxq->sw_ring = rte_zmalloc_numa("idpf rxq sw ring",
 						  sizeof(struct rte_mbuf *) * len,
 						  RTE_CACHE_LINE_SIZE,
-						  socket_id);
+						  numa_id);
 		if (rxq->sw_ring == NULL) {
 			PMD_INIT_LOG(ERR, "Failed to allocate memory for SW ring");
 			ret = -ENOMEM;
@@ -320,7 +320,7 @@ idpf_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		/* Setup Rx buffer queues */
 		ret = idpf_rx_split_bufq_setup(dev, rxq, 2 * queue_idx,
 					       rx_free_thresh, nb_desc,
-					       socket_id, mp, 1);
+					       numa_id, mp, 1);
 		if (ret != 0) {
 			PMD_INIT_LOG(ERR, "Failed to setup buffer queue 1");
 			ret = -EINVAL;
@@ -329,7 +329,7 @@ idpf_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 
 		ret = idpf_rx_split_bufq_setup(dev, rxq, 2 * queue_idx + 1,
 					       rx_free_thresh, nb_desc,
-					       socket_id, mp, 2);
+					       numa_id, mp, 2);
 		if (ret != 0) {
 			PMD_INIT_LOG(ERR, "Failed to setup buffer queue 2");
 			ret = -EINVAL;
@@ -356,17 +356,17 @@ idpf_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 static int
 idpf_tx_complq_setup(struct rte_eth_dev *dev, struct ci_tx_queue *txq,
 		     uint16_t queue_idx, uint16_t nb_desc,
-		     unsigned int socket_id)
+		     unsigned int numa_id)
 {
 	struct idpf_vport *vport = dev->data->dev_private;
 	const struct rte_memzone *mz;
 	struct idpf_complq *cq;
 	int ret;
 
-	cq = rte_zmalloc_socket("idpf splitq cq",
+	cq = rte_zmalloc_numa("idpf splitq cq",
 				sizeof(*cq),
 				RTE_CACHE_LINE_SIZE,
-				socket_id);
+				numa_id);
 	if (cq == NULL) {
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for Tx compl queue");
 		ret = -ENOMEM;
@@ -381,7 +381,7 @@ idpf_tx_complq_setup(struct rte_eth_dev *dev, struct ci_tx_queue *txq,
 
 	mz = idpf_dma_zone_reserve(dev, queue_idx, nb_desc,
 				   VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION,
-				   socket_id, true);
+				   numa_id, true);
 	if (mz == NULL) {
 		ret = -ENOMEM;
 		goto err_mz_reserve;
@@ -403,7 +403,7 @@ idpf_tx_complq_setup(struct rte_eth_dev *dev, struct ci_tx_queue *txq,
 
 int
 idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
-		    uint16_t nb_desc, unsigned int socket_id,
+		    uint16_t nb_desc, unsigned int numa_id,
 		    const struct rte_eth_txconf *tx_conf)
 {
 	struct idpf_vport *vport = dev->data->dev_private;
@@ -432,10 +432,10 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	}
 
 	/* Allocate the TX queue data structure. */
-	txq = rte_zmalloc_socket("idpf txq",
+	txq = rte_zmalloc_numa("idpf txq",
 				 sizeof(struct ci_tx_queue),
 				 RTE_CACHE_LINE_SIZE,
-				 socket_id);
+				 numa_id);
 	if (txq == NULL) {
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for tx queue structure");
 		ret = -ENOMEM;
@@ -459,7 +459,7 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 
 	/* Allocate TX hardware ring descriptors. */
 	mz = idpf_dma_zone_reserve(dev, queue_idx, nb_desc, VIRTCHNL2_QUEUE_TYPE_TX,
-				   socket_id, is_splitq);
+				   numa_id, is_splitq);
 	if (mz == NULL) {
 		ret = -ENOMEM;
 		goto err_mz_reserve;
@@ -468,18 +468,18 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	txq->mz = mz;
 
 	if (!is_splitq) {
-		txq->sw_ring = rte_zmalloc_socket("idpf tx sw ring",
+		txq->sw_ring = rte_zmalloc_numa("idpf tx sw ring",
 				sizeof(struct ci_tx_entry) * nb_desc,
-				RTE_CACHE_LINE_SIZE, socket_id);
+				RTE_CACHE_LINE_SIZE, numa_id);
 		if (txq->sw_ring == NULL) {
 			PMD_INIT_LOG(ERR, "Failed to allocate memory for SW TX ring");
 			ret = -ENOMEM;
 			goto err_sw_ring_alloc;
 		}
 
-		txq->rs_last_id = rte_zmalloc_socket("idpf tx rs_last_id",
+		txq->rs_last_id = rte_zmalloc_numa("idpf tx rs_last_id",
 				sizeof(txq->rs_last_id[0]) * (nb_desc >> txq->log2_rs_thresh),
-				RTE_CACHE_LINE_SIZE, socket_id);
+				RTE_CACHE_LINE_SIZE, numa_id);
 		if (txq->rs_last_id == NULL) {
 			PMD_INIT_LOG(ERR, "Failed to allocate memory for TX RS tracking");
 			ret = -ENOMEM;
@@ -490,14 +490,14 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		idpf_qc_single_tx_queue_reset(txq);
 	} else {
 		txq->desc_ring = mz->addr;
-		ret = idpf_qc_split_tx_pending_alloc(txq, socket_id);
+		ret = idpf_qc_split_tx_pending_alloc(txq, numa_id);
 		if (ret != 0)
 			goto err_sw_ring_alloc;
 		idpf_qc_split_tx_descq_reset(txq);
 
 		/* Setup tx completion queue if split model */
 		ret = idpf_tx_complq_setup(dev, txq, queue_idx,
-					   2 * nb_desc, socket_id);
+					   2 * nb_desc, numa_id);
 		if (ret != 0)
 			goto err_complq_setup;
 	}
diff --git a/drivers/net/intel/idpf/idpf_rxtx.h b/drivers/net/intel/idpf/idpf_rxtx.h
index b456b8705d..0a5f0dd490 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_rxtx.h
@@ -27,7 +27,7 @@
 #define IDPF_SUPPORT_CHAIN_NUM 5
 
 int idpf_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
-			uint16_t nb_desc, unsigned int socket_id,
+			uint16_t nb_desc, unsigned int numa_id,
 			const struct rte_eth_rxconf *rx_conf,
 			struct rte_mempool *mp);
 int idpf_rx_queue_init(struct rte_eth_dev *dev, uint16_t rx_queue_id);
@@ -36,7 +36,7 @@ int idpf_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id);
 void idpf_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
 
 int idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
-			uint16_t nb_desc, unsigned int socket_id,
+			uint16_t nb_desc, unsigned int numa_id,
 			const struct rte_eth_txconf *tx_conf);
 int idpf_tx_queue_init(struct rte_eth_dev *dev, uint16_t tx_queue_id);
 int idpf_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id);
diff --git a/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c b/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c
index 2ee87c94c2..d6cc367dce 100644
--- a/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c
+++ b/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c
@@ -462,7 +462,7 @@ static int ipn3ke_vswitch_probe(struct rte_afu_device *afu_dev)
 	if (!afu_dev->shared.data) {
 		snprintf(name, sizeof(name), "net_%s_hw",
 			afu_dev->device.name);
-		hw = rte_zmalloc_socket(name,
+		hw = rte_zmalloc_numa(name,
 					sizeof(struct ipn3ke_hw),
 					RTE_CACHE_LINE_SIZE,
 					afu_dev->device.numa_node);
diff --git a/drivers/net/intel/ipn3ke/ipn3ke_representor.c b/drivers/net/intel/ipn3ke/ipn3ke_representor.c
index 05aad6cd15..50ab7df99d 100644
--- a/drivers/net/intel/ipn3ke/ipn3ke_representor.c
+++ b/drivers/net/intel/ipn3ke/ipn3ke_representor.c
@@ -293,7 +293,7 @@ ipn3ke_rpst_tx_queue_stop(__rte_unused struct rte_eth_dev *dev,
 static int
 ipn3ke_rpst_rx_queue_setup(__rte_unused struct rte_eth_dev *dev,
 	__rte_unused uint16_t queue_idx, __rte_unused uint16_t nb_desc,
-	__rte_unused unsigned int socket_id,
+	__rte_unused unsigned int numa_id,
 	__rte_unused const struct rte_eth_rxconf *rx_conf,
 	__rte_unused struct rte_mempool *mp)
 {
@@ -303,7 +303,7 @@ ipn3ke_rpst_rx_queue_setup(__rte_unused struct rte_eth_dev *dev,
 static int
 ipn3ke_rpst_tx_queue_setup(__rte_unused struct rte_eth_dev *dev,
 	__rte_unused uint16_t queue_idx, __rte_unused uint16_t nb_desc,
-	__rte_unused unsigned int socket_id,
+	__rte_unused unsigned int numa_id,
 	__rte_unused const struct rte_eth_txconf *tx_conf)
 {
 	return 0;
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index a646909b4e..2758f9338d 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -552,12 +552,12 @@ void ixgbe_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
 void ixgbe_dev_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
 
 int  ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
-		uint16_t nb_rx_desc, unsigned int socket_id,
+		uint16_t nb_rx_desc, unsigned int numa_id,
 		const struct rte_eth_rxconf *rx_conf,
 		struct rte_mempool *mb_pool);
 
 int  ixgbe_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
-		uint16_t nb_tx_desc, unsigned int socket_id,
+		uint16_t nb_tx_desc, unsigned int numa_id,
 		const struct rte_eth_txconf *tx_conf);
 
 int ixgbe_dev_rx_queue_count(void *rx_queue);
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 4cf43fae16..440c9cee96 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -2685,7 +2685,7 @@ int __rte_cold
 ixgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 			 uint16_t queue_idx,
 			 uint16_t nb_desc,
-			 unsigned int socket_id,
+			 unsigned int numa_id,
 			 const struct rte_eth_txconf *tx_conf)
 {
 	const struct rte_memzone *tz;
@@ -2818,9 +2818,9 @@ ixgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	/* First allocate the tx queue data structure */
-	txq = rte_zmalloc_socket("ethdev TX queue", sizeof(struct ci_tx_queue) +
+	txq = rte_zmalloc_numa("ethdev TX queue", sizeof(struct ci_tx_queue) +
 					sizeof(struct ixgbe_advctx_info) * IXGBE_CTX_NUM,
-				 RTE_CACHE_LINE_SIZE, socket_id);
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq == NULL)
 		return -ENOMEM;
 	txq->ctx_cache = RTE_PTR_ADD(txq, sizeof(struct ci_tx_queue));
@@ -2832,7 +2832,7 @@ ixgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	 */
 	tz = rte_eth_dma_zone_reserve(dev, "ixgbe_tx_ring", queue_idx,
 			sizeof(union ixgbe_adv_tx_desc) * IXGBE_MAX_RING_DESC,
-			IXGBE_ALIGN, socket_id);
+			IXGBE_ALIGN, numa_id);
 	if (tz == NULL) {
 		ixgbe_tx_queue_release(txq);
 		return -ENOMEM;
@@ -2873,9 +2873,9 @@ ixgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	txq->ixgbe_tx_ring = (union ixgbe_adv_tx_desc *)tz->addr;
 
 	/* Allocate software ring */
-	txq->sw_ring = rte_zmalloc_socket("txq->sw_ring",
+	txq->sw_ring = rte_zmalloc_numa("txq->sw_ring",
 				sizeof(struct ci_tx_entry) * nb_desc,
-				RTE_CACHE_LINE_SIZE, socket_id);
+				RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq->sw_ring == NULL) {
 		ixgbe_tx_queue_release(txq);
 		return -ENOMEM;
@@ -2885,8 +2885,8 @@ ixgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 
 	/* Allocate RS last_id tracking array */
 	uint16_t num_rs_buckets = nb_desc / tx_rs_thresh;
-	txq->rs_last_id = rte_zmalloc_socket(NULL, sizeof(txq->rs_last_id[0]) * num_rs_buckets,
-			RTE_CACHE_LINE_SIZE, socket_id);
+	txq->rs_last_id = rte_zmalloc_numa(NULL, sizeof(txq->rs_last_id[0]) * num_rs_buckets,
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq->rs_last_id == NULL) {
 		ixgbe_tx_queue_release(txq);
 		PMD_DRV_LOG(ERR, "Failed to allocate memory for RS last_id array");
@@ -3160,7 +3160,7 @@ int __rte_cold
 ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			 uint16_t queue_idx,
 			 uint16_t nb_desc,
-			 unsigned int socket_id,
+			 unsigned int numa_id,
 			 const struct rte_eth_rxconf *rx_conf,
 			 struct rte_mempool *mp)
 {
@@ -3204,8 +3204,8 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	/* First allocate the rx queue data structure */
-	rxq = rte_zmalloc_socket("ethdev RX queue", sizeof(struct ci_rx_queue),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	rxq = rte_zmalloc_numa("ethdev RX queue", sizeof(struct ci_rx_queue),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (rxq == NULL)
 		return -ENOMEM;
 	rxq->mp = mp;
@@ -3252,7 +3252,7 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	 * resizing in later calls to the queue setup function.
 	 */
 	rz = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_idx,
-				      RX_RING_SZ, IXGBE_ALIGN, socket_id);
+				      RX_RING_SZ, IXGBE_ALIGN, numa_id);
 	if (rz == NULL) {
 		ixgbe_rx_queue_release(rxq);
 		return -ENOMEM;
@@ -3299,9 +3299,9 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	if (adapter->rx_bulk_alloc_allowed)
 		len += IXGBE_RX_MAX_BURST;
 
-	rxq->sw_ring = rte_zmalloc_socket("rxq->sw_ring",
+	rxq->sw_ring = rte_zmalloc_numa("rxq->sw_ring",
 					  sizeof(struct ci_rx_entry) * len,
-					  RTE_CACHE_LINE_SIZE, socket_id);
+					  RTE_CACHE_LINE_SIZE, numa_id);
 	if (!rxq->sw_ring) {
 		ixgbe_rx_queue_release(rxq);
 		return -ENOMEM;
@@ -3316,9 +3316,9 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	 * dev_start() flow.
 	 */
 	rxq->sw_sc_ring =
-		rte_zmalloc_socket("rxq->sw_sc_ring",
+		rte_zmalloc_numa("rxq->sw_sc_ring",
 				   sizeof(struct ci_rx_entry_sc) * len,
-				   RTE_CACHE_LINE_SIZE, socket_id);
+				   RTE_CACHE_LINE_SIZE, numa_id);
 	if (!rxq->sw_sc_ring) {
 		ixgbe_rx_queue_release(rxq);
 		return -ENOMEM;
diff --git a/drivers/net/intel/ixgbe/ixgbe_vf_representor.c b/drivers/net/intel/ixgbe/ixgbe_vf_representor.c
index c11983e307..d9032c0f3d 100644
--- a/drivers/net/intel/ixgbe/ixgbe_vf_representor.c
+++ b/drivers/net/intel/ixgbe/ixgbe_vf_representor.c
@@ -111,7 +111,7 @@ static int ixgbe_vf_representor_rx_queue_setup(
 	__rte_unused struct rte_eth_dev *dev,
 	__rte_unused uint16_t rx_queue_id,
 	__rte_unused uint16_t nb_rx_desc,
-	__rte_unused unsigned int socket_id,
+	__rte_unused unsigned int numa_id,
 	__rte_unused const struct rte_eth_rxconf *rx_conf,
 	__rte_unused struct rte_mempool *mb_pool)
 {
@@ -122,7 +122,7 @@ static int ixgbe_vf_representor_tx_queue_setup(
 	__rte_unused struct rte_eth_dev *dev,
 	__rte_unused uint16_t rx_queue_id,
 	__rte_unused uint16_t nb_rx_desc,
-	__rte_unused unsigned int socket_id,
+	__rte_unused unsigned int numa_id,
 	__rte_unused const struct rte_eth_txconf *tx_conf)
 {
 	return 0;
-- 
2.55.0

