Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6384A6071A08
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tkDJvjh4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D613A42ECC;
	Tue,  3 Nov 2026 16:14:14 +0100 (CET)
Received: from mta1.migadu.com (out-71.mta1.migadu.com [95.215.58.71])
 by mails.dpdk.org (Postfix) with ESMTPS id 141FF42EC2
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:14:13 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=W5aL1c7ix0VyYaaAIZQfIDKkLJMeskEqgYX5E1qTT2o=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718852; v=1; x=1794323652;
 b=tkDJvjh4smXbjkHnwG3OLRbUN2GxQffbPys7CGFBdm7wtLcJdfRSPOFyiqOFfnR1n/Gi9aqv
 uong65CPTzR5ZXRoOp+K3cDvCUsZ/SNcXLaEzZM5J6JmZ6dVKZjK7AnxDga706/4mxFHjeN+FBm
 wZeBCSiISdrHLX7yyKVGYGcM=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id b926bf87ea897a0b;
 Tue, 03 Nov 2026 15:14:11 +0000
X-Mizu-Trace-ID: b926bf87ea897a0b
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 134/227] net/nfp: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:32 +0800
Message-ID: <20261103145306.487255-135-chengwen.feng@linux.dev>
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
 drivers/net/nfp/flower/nfp_flower.c           | 16 +++++++--------
 .../net/nfp/flower/nfp_flower_representor.c   | 20 +++++++++----------
 drivers/net/nfp/nfd3/nfp_nfd3.h               |  2 +-
 drivers/net/nfp/nfd3/nfp_nfd3_dp.c            | 12 +++++------
 drivers/net/nfp/nfdk/nfp_nfdk.h               |  2 +-
 drivers/net/nfp/nfdk/nfp_nfdk_dp.c            | 12 +++++------
 drivers/net/nfp/nfp_net_common.c              |  2 +-
 drivers/net/nfp/nfp_rxtx.c                    | 18 ++++++++---------
 drivers/net/nfp/nfp_rxtx.h                    |  4 ++--
 drivers/net/nfp/nfpcore/nfp_sync.c            |  2 +-
 10 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/net/nfp/flower/nfp_flower.c b/drivers/net/nfp/flower/nfp_flower.c
index 14a8992376..b8c061c657 100644
--- a/drivers/net/nfp/flower/nfp_flower.c
+++ b/drivers/net/nfp/flower/nfp_flower.c
@@ -380,7 +380,7 @@ nfp_flower_init_ctrl_vnic(struct nfp_app_fw_flower *app_fw_flower,
 	pci_name = strchr(pf_dev->pci_dev->name, ':') + 1;
 
 	/* Create a mbuf pool for the ctrl vNIC */
-	numa_node = rte_socket_id();
+	numa_node = rte_numa_id();
 	snprintf(ctrl_pktmbuf_pool_name, sizeof(ctrl_pktmbuf_pool_name),
 			"%s_ctrlmp", pci_name);
 	app_fw_flower->ctrl_pktmbuf_pool =
@@ -424,7 +424,7 @@ nfp_flower_init_ctrl_vnic(struct nfp_app_fw_flower *app_fw_flower,
 	snprintf(ctrl_rxring_name, sizeof(ctrl_rxring_name), "%s_ctrx_ring", pci_name);
 	/* Set up the Rx queues */
 	for (i = 0; i < n_rxq; i++) {
-		rxq = rte_zmalloc_socket("ethdev RX queue",
+		rxq = rte_zmalloc_numa("ethdev RX queue",
 				sizeof(struct nfp_net_rxq), RTE_CACHE_LINE_SIZE,
 				numa_node);
 		if (rxq == NULL) {
@@ -473,7 +473,7 @@ nfp_flower_init_ctrl_vnic(struct nfp_app_fw_flower *app_fw_flower,
 		rxq->rxds = tz->addr;
 
 		/* Mbuf pointers array for referencing mbufs linked to RX descriptors */
-		rxq->rxbufs = rte_zmalloc_socket("rxq->rxbufs",
+		rxq->rxbufs = rte_zmalloc_numa("rxq->rxbufs",
 				sizeof(*rxq->rxbufs) * CTRL_VNIC_NB_DESC,
 				RTE_CACHE_LINE_SIZE, numa_node);
 		if (rxq->rxbufs == NULL) {
@@ -499,7 +499,7 @@ nfp_flower_init_ctrl_vnic(struct nfp_app_fw_flower *app_fw_flower,
 	snprintf(ctrl_txring_name, sizeof(ctrl_txring_name), "%s_cttx_ring", pci_name);
 	/* Set up the Tx queues */
 	for (i = 0; i < n_txq; i++) {
-		txq = rte_zmalloc_socket("ethdev TX queue",
+		txq = rte_zmalloc_numa("ethdev TX queue",
 				sizeof(struct nfp_net_txq), RTE_CACHE_LINE_SIZE,
 				numa_node);
 		if (txq == NULL) {
@@ -539,7 +539,7 @@ nfp_flower_init_ctrl_vnic(struct nfp_app_fw_flower *app_fw_flower,
 		txq->txds = tz->addr;
 
 		/* Mbuf pointers array for referencing mbufs linked to TX descriptors */
-		txq->txbufs = rte_zmalloc_socket("txq->txbufs",
+		txq->txbufs = rte_zmalloc_numa("txq->txbufs",
 				sizeof(*txq->txbufs) * CTRL_VNIC_NB_DESC,
 				RTE_CACHE_LINE_SIZE, numa_node);
 		if (txq->txbufs == NULL) {
@@ -744,11 +744,11 @@ nfp_init_app_fw_flower(struct nfp_net_hw_priv *hw_priv)
 	struct nfp_app_fw_flower *app_fw_flower;
 	struct nfp_pf_dev *pf_dev = hw_priv->pf_dev;
 
-	numa_node = rte_socket_id();
+	numa_node = rte_numa_id();
 	id = nfp_function_id_get(pf_dev, 0);
 
 	/* Allocate memory for the Flower app */
-	app_fw_flower = rte_zmalloc_socket("nfp_app_fw_flower", sizeof(*app_fw_flower),
+	app_fw_flower = rte_zmalloc_numa("nfp_app_fw_flower", sizeof(*app_fw_flower),
 			RTE_CACHE_LINE_SIZE, numa_node);
 	if (app_fw_flower == NULL) {
 		PMD_INIT_LOG(ERR, "Could not malloc app fw flower.");
@@ -770,7 +770,7 @@ nfp_init_app_fw_flower(struct nfp_net_hw_priv *hw_priv)
 	}
 
 	/* Allocate memory for the PF AND ctrl vNIC here (hence the * 2) */
-	pf_hw = rte_zmalloc_socket("nfp_pf_vnic", 2 * sizeof(struct nfp_net_hw),
+	pf_hw = rte_zmalloc_numa("nfp_pf_vnic", 2 * sizeof(struct nfp_net_hw),
 			RTE_CACHE_LINE_SIZE, numa_node);
 	if (pf_hw == NULL) {
 		PMD_INIT_LOG(ERR, "Could not malloc nfp pf vnic.");
diff --git a/drivers/net/nfp/flower/nfp_flower_representor.c b/drivers/net/nfp/flower/nfp_flower_representor.c
index 231a76980d..d75dbcbd4b 100644
--- a/drivers/net/nfp/flower/nfp_flower_representor.c
+++ b/drivers/net/nfp/flower/nfp_flower_representor.c
@@ -249,7 +249,7 @@ static int
 nfp_flower_repr_rx_queue_setup(struct rte_eth_dev *dev,
 		uint16_t rx_queue_id,
 		uint16_t nb_rx_desc,
-		unsigned int socket_id,
+		unsigned int numa_id,
 		__rte_unused const struct rte_eth_rxconf *rx_conf,
 		__rte_unused struct rte_mempool *mb_pool)
 {
@@ -262,14 +262,14 @@ nfp_flower_repr_rx_queue_setup(struct rte_eth_dev *dev,
 	pf_hw = repr->app_fw_flower->pf_hw;
 
 	/* Allocating rx queue data structure */
-	rxq = rte_zmalloc_socket("ethdev RX queue", sizeof(struct nfp_net_rxq),
-			RTE_CACHE_LINE_SIZE, socket_id);
+	rxq = rte_zmalloc_numa("ethdev RX queue", sizeof(struct nfp_net_rxq),
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (rxq == NULL)
 		return -ENOMEM;
 
 	snprintf(ring_name, sizeof(ring_name), "%s-%s-%u", repr->name, "Rx", rx_queue_id);
 	repr->ring[rx_queue_id] = rte_ring_create(ring_name, nb_rx_desc,
-			rte_socket_id(), 0);
+			rte_numa_id(), 0);
 	if (repr->ring[rx_queue_id] == NULL) {
 		PMD_DRV_LOG(ERR, "The rte_ring_create failed for rx queue %u.", rx_queue_id);
 		rte_free(rxq);
@@ -288,7 +288,7 @@ static int
 nfp_flower_repr_tx_queue_setup(struct rte_eth_dev *dev,
 		uint16_t tx_queue_id,
 		__rte_unused uint16_t nb_tx_desc,
-		unsigned int socket_id,
+		unsigned int numa_id,
 		__rte_unused const struct rte_eth_txconf *tx_conf)
 {
 	struct nfp_net_txq *txq;
@@ -299,8 +299,8 @@ nfp_flower_repr_tx_queue_setup(struct rte_eth_dev *dev,
 	pf_hw = repr->app_fw_flower->pf_hw;
 
 	/* Allocating tx queue data structure */
-	txq = rte_zmalloc_socket("ethdev TX queue", sizeof(struct nfp_net_txq),
-			RTE_CACHE_LINE_SIZE, socket_id);
+	txq = rte_zmalloc_numa("ethdev TX queue", sizeof(struct nfp_net_txq),
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq == NULL)
 		return -ENOMEM;
 
@@ -886,8 +886,8 @@ nfp_flower_repr_init(struct rte_eth_dev *eth_dev,
 	 * representor PMD will try to read from the ring.
 	 */
 	snprintf(ring_name, sizeof(ring_name), "%s_%s", init_repr_data->name, "ring");
-	numa_node = rte_socket_id();
-	repr->ring = rte_zmalloc_socket(ring_name,
+	numa_node = rte_numa_id();
+	repr->ring = rte_zmalloc_numa(ring_name,
 			sizeof(struct rte_ring *) * app_fw_flower->pf_hw->max_rx_queues,
 			RTE_CACHE_LINE_SIZE, numa_node);
 	if (repr->ring == NULL) {
@@ -897,7 +897,7 @@ nfp_flower_repr_init(struct rte_eth_dev *eth_dev,
 
 	repr->repr_nb_qstats = RTE_MAX(app_fw_flower->pf_hw->max_rx_queues,
 			app_fw_flower->pf_hw->max_tx_queues);
-	repr->repr_qstats = rte_zmalloc_socket("nfp_repr_qstats",
+	repr->repr_qstats = rte_zmalloc_numa("nfp_repr_qstats",
 			sizeof(struct eth_queue_stats) * repr->repr_nb_qstats,
 			RTE_CACHE_LINE_SIZE, numa_node);
 	if (repr->repr_qstats == NULL) {
diff --git a/drivers/net/nfp/nfd3/nfp_nfd3.h b/drivers/net/nfp/nfd3/nfp_nfd3.h
index dc24f4fa1d..b8a42dcf15 100644
--- a/drivers/net/nfp/nfd3/nfp_nfd3.h
+++ b/drivers/net/nfp/nfd3/nfp_nfd3.h
@@ -81,7 +81,7 @@ uint16_t nfp_net_nfd3_xmit_pkts(void *tx_queue,
 int nfp_net_nfd3_tx_queue_setup(struct rte_eth_dev *dev,
 		uint16_t queue_idx,
 		uint16_t nb_desc,
-		unsigned int socket_id,
+		unsigned int numa_id,
 		const struct rte_eth_txconf *tx_conf);
 
 #endif /* __NFP_NFD3_H__ */
diff --git a/drivers/net/nfp/nfd3/nfp_nfd3_dp.c b/drivers/net/nfp/nfd3/nfp_nfd3_dp.c
index 6466a5a4fb..1503934667 100644
--- a/drivers/net/nfp/nfd3/nfp_nfd3_dp.c
+++ b/drivers/net/nfp/nfd3/nfp_nfd3_dp.c
@@ -374,7 +374,7 @@ int
 nfp_net_nfd3_tx_queue_setup(struct rte_eth_dev *dev,
 		uint16_t queue_idx,
 		uint16_t nb_desc,
-		unsigned int socket_id,
+		unsigned int numa_id,
 		const struct rte_eth_txconf *tx_conf)
 {
 	size_t size;
@@ -421,8 +421,8 @@ nfp_net_nfd3_tx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	/* Allocating tx queue data structure */
-	txq = rte_zmalloc_socket("ethdev TX queue", sizeof(struct nfp_net_txq),
-			RTE_CACHE_LINE_SIZE, socket_id);
+	txq = rte_zmalloc_numa("ethdev TX queue", sizeof(struct nfp_net_txq),
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq == NULL) {
 		PMD_DRV_LOG(ERR, "Error allocating tx dma.");
 		return -ENOMEM;
@@ -437,7 +437,7 @@ nfp_net_nfd3_tx_queue_setup(struct rte_eth_dev *dev,
 	 */
 	size = sizeof(struct nfp_net_nfd3_tx_desc) * NFD3_TX_DESC_PER_PKT * max_tx_desc;
 	tz = rte_eth_dma_zone_reserve(dev, "tx_ring", queue_idx, size,
-			NFP_MEMZONE_ALIGN, socket_id);
+			NFP_MEMZONE_ALIGN, numa_id);
 	if (tz == NULL) {
 		PMD_DRV_LOG(ERR, "Error allocating tx dma.");
 		nfp_net_tx_queue_release(dev, queue_idx);
@@ -459,9 +459,9 @@ nfp_net_nfd3_tx_queue_setup(struct rte_eth_dev *dev,
 	txq->txds = tz->addr;
 
 	/* Mbuf pointers array for referencing mbufs linked to TX descriptors */
-	txq->txbufs = rte_zmalloc_socket("txq->txbufs",
+	txq->txbufs = rte_zmalloc_numa("txq->txbufs",
 			sizeof(*txq->txbufs) * txq->tx_count,
-			RTE_CACHE_LINE_SIZE, socket_id);
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq->txbufs == NULL) {
 		nfp_net_tx_queue_release(dev, queue_idx);
 		dev->data->tx_queues[queue_idx] = NULL;
diff --git a/drivers/net/nfp/nfdk/nfp_nfdk.h b/drivers/net/nfp/nfdk/nfp_nfdk.h
index d843162be0..b0f5224acf 100644
--- a/drivers/net/nfp/nfdk/nfp_nfdk.h
+++ b/drivers/net/nfp/nfdk/nfp_nfdk.h
@@ -216,7 +216,7 @@ uint16_t nfp_net_nfdk_xmit_pkts(void *tx_queue,
 int nfp_net_nfdk_tx_queue_setup(struct rte_eth_dev *dev,
 		uint16_t queue_idx,
 		uint16_t nb_desc,
-		unsigned int socket_id,
+		unsigned int numa_id,
 		const struct rte_eth_txconf *tx_conf);
 int nfp_net_nfdk_tx_maybe_close_block(struct nfp_net_txq *txq,
 		struct rte_mbuf *pkt);
diff --git a/drivers/net/nfp/nfdk/nfp_nfdk_dp.c b/drivers/net/nfp/nfdk/nfp_nfdk_dp.c
index 777550b6df..a039de9135 100644
--- a/drivers/net/nfp/nfdk/nfp_nfdk_dp.c
+++ b/drivers/net/nfp/nfdk/nfp_nfdk_dp.c
@@ -408,7 +408,7 @@ int
 nfp_net_nfdk_tx_queue_setup(struct rte_eth_dev *dev,
 		uint16_t queue_idx,
 		uint16_t nb_desc,
-		unsigned int socket_id,
+		unsigned int numa_id,
 		const struct rte_eth_txconf *tx_conf)
 {
 	size_t size;
@@ -457,8 +457,8 @@ nfp_net_nfdk_tx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	/* Allocating tx queue data structure */
-	txq = rte_zmalloc_socket("ethdev TX queue", sizeof(struct nfp_net_txq),
-			RTE_CACHE_LINE_SIZE, socket_id);
+	txq = rte_zmalloc_numa("ethdev TX queue", sizeof(struct nfp_net_txq),
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq == NULL) {
 		PMD_DRV_LOG(ERR, "Error allocating tx dma.");
 		return -ENOMEM;
@@ -472,7 +472,7 @@ nfp_net_nfdk_tx_queue_setup(struct rte_eth_dev *dev,
 	size = sizeof(struct nfp_net_nfdk_tx_desc) * max_tx_desc *
 			NFDK_TX_DESC_PER_SIMPLE_PKT;
 	tz = rte_eth_dma_zone_reserve(dev, "tx_ring", queue_idx, size,
-			NFP_MEMZONE_ALIGN, socket_id);
+			NFP_MEMZONE_ALIGN, numa_id);
 	if (tz == NULL) {
 		PMD_DRV_LOG(ERR, "Error allocating tx dma.");
 		nfp_net_tx_queue_release(dev, queue_idx);
@@ -493,9 +493,9 @@ nfp_net_nfdk_tx_queue_setup(struct rte_eth_dev *dev,
 	txq->ktxds = tz->addr;
 
 	/* Mbuf pointers array for referencing mbufs linked to TX descriptors */
-	txq->txbufs = rte_zmalloc_socket("txq->txbufs",
+	txq->txbufs = rte_zmalloc_numa("txq->txbufs",
 			sizeof(*txq->txbufs) * txq->tx_count,
-			RTE_CACHE_LINE_SIZE, socket_id);
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq->txbufs == NULL) {
 		nfp_net_tx_queue_release(dev, queue_idx);
 		return -ENOMEM;
diff --git a/drivers/net/nfp/nfp_net_common.c b/drivers/net/nfp/nfp_net_common.c
index 97841c00b5..ab0aa14ff4 100644
--- a/drivers/net/nfp/nfp_net_common.c
+++ b/drivers/net/nfp/nfp_net_common.c
@@ -2269,7 +2269,7 @@ nfp_net_txrwb_alloc(struct rte_eth_dev *eth_dev)
 	snprintf(mz_name, sizeof(mz_name), "%s_TXRWB", eth_dev->data->name);
 	net_hw->txrwb_mz = rte_memzone_reserve_aligned(mz_name,
 			net_hw->max_tx_queues * sizeof(uint64_t),
-			rte_socket_id(),
+			rte_numa_id(),
 			RTE_MEMZONE_IOVA_CONTIG, RTE_CACHE_LINE_SIZE);
 	if (net_hw->txrwb_mz == NULL) {
 		PMD_INIT_LOG(ERR, "Failed to alloc %s for TX ring write back.",
diff --git a/drivers/net/nfp/nfp_rxtx.c b/drivers/net/nfp/nfp_rxtx.c
index 19c8324549..b76c6ea7ed 100644
--- a/drivers/net/nfp/nfp_rxtx.c
+++ b/drivers/net/nfp/nfp_rxtx.c
@@ -620,7 +620,7 @@ int
 nfp_net_rx_queue_setup(struct rte_eth_dev *dev,
 		uint16_t queue_idx,
 		uint16_t nb_desc,
-		unsigned int socket_id,
+		unsigned int numa_id,
 		const struct rte_eth_rxconf *rx_conf,
 		struct rte_mempool *mp)
 {
@@ -655,8 +655,8 @@ nfp_net_rx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	/* Allocating rx queue data structure */
-	rxq = rte_zmalloc_socket("ethdev RX queue", sizeof(struct nfp_net_rxq),
-			RTE_CACHE_LINE_SIZE, socket_id);
+	rxq = rte_zmalloc_numa("ethdev RX queue", sizeof(struct nfp_net_rxq),
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (rxq == NULL)
 		return -ENOMEM;
 
@@ -687,7 +687,7 @@ nfp_net_rx_queue_setup(struct rte_eth_dev *dev,
 	 */
 	tz = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_idx,
 			sizeof(struct nfp_net_rx_desc) * max_rx_desc,
-			NFP_MEMZONE_ALIGN, socket_id);
+			NFP_MEMZONE_ALIGN, numa_id);
 	if (tz == NULL) {
 		PMD_DRV_LOG(ERR, "Error allocating rx dma.");
 		nfp_net_rx_queue_release(dev, queue_idx);
@@ -700,9 +700,9 @@ nfp_net_rx_queue_setup(struct rte_eth_dev *dev,
 	rxq->rxds = tz->addr;
 
 	/* Mbuf pointers array for referencing mbufs linked to RX descriptors */
-	rxq->rxbufs = rte_zmalloc_socket("rxq->rxbufs",
+	rxq->rxbufs = rte_zmalloc_numa("rxq->rxbufs",
 			sizeof(*rxq->rxbufs) * nb_desc, RTE_CACHE_LINE_SIZE,
-			socket_id);
+			numa_id);
 	if (rxq->rxbufs == NULL) {
 		nfp_net_rx_queue_release(dev, queue_idx);
 		dev->data->rx_queues[queue_idx] = NULL;
@@ -838,7 +838,7 @@ int
 nfp_net_tx_queue_setup(struct rte_eth_dev *dev,
 		uint16_t queue_idx,
 		uint16_t nb_desc,
-		unsigned int socket_id,
+		unsigned int numa_id,
 		const struct rte_eth_txconf *tx_conf)
 {
 	struct nfp_net_hw_priv *hw_priv;
@@ -847,10 +847,10 @@ nfp_net_tx_queue_setup(struct rte_eth_dev *dev,
 
 	if (hw_priv->pf_dev->ver.extend == NFP_NET_CFG_VERSION_DP_NFD3)
 		return nfp_net_nfd3_tx_queue_setup(dev, queue_idx,
-				nb_desc, socket_id, tx_conf);
+				nb_desc, numa_id, tx_conf);
 	else
 		return nfp_net_nfdk_tx_queue_setup(dev, queue_idx,
-				nb_desc, socket_id, tx_conf);
+				nb_desc, numa_id, tx_conf);
 }
 
 void
diff --git a/drivers/net/nfp/nfp_rxtx.h b/drivers/net/nfp/nfp_rxtx.h
index 95c7a85053..a4cde4d4dd 100644
--- a/drivers/net/nfp/nfp_rxtx.h
+++ b/drivers/net/nfp/nfp_rxtx.h
@@ -226,7 +226,7 @@ uint16_t nfp_net_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 void nfp_net_rx_queue_release(struct rte_eth_dev *dev, uint16_t queue_idx);
 void nfp_net_reset_rx_queue(struct nfp_net_rxq *rxq);
 int nfp_net_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
-		uint16_t nb_desc, unsigned int socket_id,
+		uint16_t nb_desc, unsigned int numa_id,
 		const struct rte_eth_rxconf *rx_conf,
 		struct rte_mempool *mp);
 void nfp_net_tx_queue_release(struct rte_eth_dev *dev, uint16_t queue_idx);
@@ -235,7 +235,7 @@ void nfp_net_reset_tx_queue(struct nfp_net_txq *txq);
 int nfp_net_tx_queue_setup(struct rte_eth_dev *dev,
 		uint16_t queue_idx,
 		uint16_t nb_desc,
-		unsigned int socket_id,
+		unsigned int numa_id,
 		const struct rte_eth_txconf *tx_conf);
 uint32_t nfp_net_tx_free_bufs(struct nfp_net_txq *txq);
 void nfp_net_rx_queue_info_get(struct rte_eth_dev *dev,
diff --git a/drivers/net/nfp/nfpcore/nfp_sync.c b/drivers/net/nfp/nfpcore/nfp_sync.c
index 1b594257c6..a7a9465f65 100644
--- a/drivers/net/nfp/nfpcore/nfp_sync.c
+++ b/drivers/net/nfp/nfpcore/nfp_sync.c
@@ -56,7 +56,7 @@ nfp_sync_alloc(void)
 		return sync;
 	}
 
-	mz = rte_memzone_reserve("nfp_sync",  sizeof(*sync), SOCKET_ID_ANY,
+	mz = rte_memzone_reserve("nfp_sync",  sizeof(*sync), RTE_NUMA_ID_ANY,
 			RTE_MEMZONE_SIZE_HINT_ONLY);
 	if (mz == NULL)
 		return NULL;
-- 
2.55.0

