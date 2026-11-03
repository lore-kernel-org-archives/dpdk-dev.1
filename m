Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3582B606B254
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CfsYEdH3
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE72E42E90;
	Tue,  3 Nov 2026 16:13:20 +0100 (CET)
Received: from mta0.migadu.com (out-16.mta0.migadu.com [91.218.175.16])
 by mails.dpdk.org (Postfix) with ESMTPS id 27C4942E93
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:13:19 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=1VBWHhRGhQQjfFrXOADUIzQbx/siR3ty2QMtQhc3AAE=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718798; v=1; x=1794323598;
 b=CfsYEdH3nbBehMVL4WhLh+H6EUCSekir1eFWfeEXsPfnZD1KwIEXdN/3ghorcVDnP/Goh4Ul
 wgogTIg18IjiCngHyJWkd8EvgTZ3Kizn7rMvC/HQQdpG1V97Us58gDdnMmi4yfMIuFSP3c9HoX0
 d99/EkHAHicX+r1AakQMacbU=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 3312d58a7cdda166;
 Tue, 03 Nov 2026 15:13:18 +0000
X-Mizu-Trace-ID: 3312d58a7cdda166
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 126/227] net/mana: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:24 +0800
Message-ID: <20261103145306.487255-127-chengwen.feng@linux.dev>
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
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename socket_id parameters, internal structure fields, variables
and comments to the NUMA node terminology, and switch calls to
the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/net/mana/mana.c | 54 ++++++++++++++++++++---------------------
 drivers/net/mana/mr.c   |  4 +--
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
index c14b522b8a..de92e377a6 100644
--- a/drivers/net/mana/mana.c
+++ b/drivers/net/mana/mana.c
@@ -68,7 +68,7 @@ mana_alloc_verbs_buf(size_t size, void *data)
 		return NULL;
 	}
 
-	ret = rte_zmalloc_socket("mana_verb_buf", size, alignment, socket);
+	ret = rte_zmalloc_numa("mana_verb_buf", size, alignment, socket);
 	if (!ret && size)
 		rte_errno = ENOMEM;
 	return ret;
@@ -565,7 +565,7 @@ mana_rss_hash_conf_get(struct rte_eth_dev *dev,
 
 static int
 mana_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
-			uint16_t nb_desc, unsigned int socket_id,
+			uint16_t nb_desc, unsigned int numa_id,
 			const struct rte_eth_txconf *tx_conf __rte_unused)
 
 {
@@ -573,27 +573,27 @@ mana_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	struct mana_txq *txq;
 	int ret;
 
-	txq = rte_zmalloc_socket("mana_txq", sizeof(*txq), 0, socket_id);
+	txq = rte_zmalloc_numa("mana_txq", sizeof(*txq), 0, numa_id);
 	if (!txq) {
 		DRV_LOG(ERR, "failed to allocate txq");
 		return -ENOMEM;
 	}
 
-	txq->socket = socket_id;
+	txq->socket = numa_id;
 
-	txq->desc_ring = rte_malloc_socket("mana_tx_desc_ring",
+	txq->desc_ring = rte_malloc_numa("mana_tx_desc_ring",
 					   sizeof(struct mana_txq_desc) *
 						nb_desc,
-					   RTE_CACHE_LINE_SIZE, socket_id);
+					   RTE_CACHE_LINE_SIZE, numa_id);
 	if (!txq->desc_ring) {
 		DRV_LOG(ERR, "failed to allocate txq desc_ring");
 		ret = -ENOMEM;
 		goto fail;
 	}
 
-	txq->gdma_comp_buf = rte_malloc_socket("mana_txq_comp",
+	txq->gdma_comp_buf = rte_malloc_numa("mana_txq_comp",
 			sizeof(*txq->gdma_comp_buf) * nb_desc,
-			RTE_CACHE_LINE_SIZE, socket_id);
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (!txq->gdma_comp_buf) {
 		DRV_LOG(ERR, "failed to allocate txq comp");
 		ret = -ENOMEM;
@@ -601,14 +601,14 @@ mana_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	}
 
 	ret = mana_mr_btree_init(&txq->mr_btree,
-				 MANA_MR_BTREE_PER_QUEUE_N, socket_id);
+				 MANA_MR_BTREE_PER_QUEUE_N, numa_id);
 	if (ret) {
 		DRV_LOG(ERR, "Failed to init TXQ MR btree");
 		goto fail;
 	}
 
 	DRV_LOG(DEBUG, "idx %u nb_desc %u socket %u txq->desc_ring %p",
-		queue_idx, nb_desc, socket_id, txq->desc_ring);
+		queue_idx, nb_desc, numa_id, txq->desc_ring);
 
 	txq->desc_ring_head = 0;
 	txq->desc_ring_tail = 0;
@@ -627,7 +627,7 @@ mana_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 
 static int
 mana_dev_tx_queue_setup_lock(struct rte_eth_dev *dev, uint16_t queue_idx,
-			     uint16_t nb_desc, unsigned int socket_id,
+			     uint16_t nb_desc, unsigned int numa_id,
 			     const struct rte_eth_txconf *tx_conf)
 {
 	struct mana_priv *priv = dev->data->dev_private;
@@ -636,7 +636,7 @@ mana_dev_tx_queue_setup_lock(struct rte_eth_dev *dev, uint16_t queue_idx,
 	if (mana_reset_trylock(priv))
 		return -EBUSY;
 	ret = mana_dev_tx_queue_setup(dev, queue_idx,
-				      nb_desc, socket_id, tx_conf);
+				      nb_desc, numa_id, tx_conf);
 	pthread_mutex_unlock(&priv->reset_ops_lock);
 	return ret;
 }
@@ -655,7 +655,7 @@ mana_dev_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 
 static int
 mana_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
-			uint16_t nb_desc, unsigned int socket_id,
+			uint16_t nb_desc, unsigned int numa_id,
 			const struct rte_eth_rxconf *rx_conf __rte_unused,
 			struct rte_mempool *mp)
 {
@@ -663,21 +663,21 @@ mana_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	struct mana_rxq *rxq;
 	int ret;
 
-	rxq = rte_zmalloc_socket("mana_rxq", sizeof(*rxq), 0, socket_id);
+	rxq = rte_zmalloc_numa("mana_rxq", sizeof(*rxq), 0, numa_id);
 	if (!rxq) {
 		DRV_LOG(ERR, "failed to allocate rxq");
 		return -ENOMEM;
 	}
 
 	DRV_LOG(DEBUG, "idx %u nb_desc %u socket %u",
-		queue_idx, nb_desc, socket_id);
+		queue_idx, nb_desc, numa_id);
 
-	rxq->socket = socket_id;
+	rxq->socket = numa_id;
 
-	rxq->desc_ring = rte_zmalloc_socket("mana_rx_mbuf_ring",
+	rxq->desc_ring = rte_zmalloc_numa("mana_rx_mbuf_ring",
 					    sizeof(struct mana_rxq_desc) *
 						nb_desc,
-					    RTE_CACHE_LINE_SIZE, socket_id);
+					    RTE_CACHE_LINE_SIZE, numa_id);
 
 	if (!rxq->desc_ring) {
 		DRV_LOG(ERR, "failed to allocate rxq desc_ring");
@@ -688,9 +688,9 @@ mana_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	rxq->desc_ring_head = 0;
 	rxq->desc_ring_tail = 0;
 
-	rxq->gdma_comp_buf = rte_malloc_socket("mana_rxq_comp",
+	rxq->gdma_comp_buf = rte_malloc_numa("mana_rxq_comp",
 			sizeof(*rxq->gdma_comp_buf) * nb_desc,
-			RTE_CACHE_LINE_SIZE, socket_id);
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (!rxq->gdma_comp_buf) {
 		DRV_LOG(ERR, "failed to allocate rxq comp");
 		ret = -ENOMEM;
@@ -698,7 +698,7 @@ mana_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	}
 
 	ret = mana_mr_btree_init(&rxq->mr_btree,
-				 MANA_MR_BTREE_PER_QUEUE_N, socket_id);
+				 MANA_MR_BTREE_PER_QUEUE_N, numa_id);
 	if (ret) {
 		DRV_LOG(ERR, "Failed to init RXQ MR btree");
 		goto fail;
@@ -720,7 +720,7 @@ mana_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 
 static int
 mana_dev_rx_queue_setup_lock(struct rte_eth_dev *dev, uint16_t queue_idx,
-			     uint16_t nb_desc, unsigned int socket_id,
+			     uint16_t nb_desc, unsigned int numa_id,
 			     const struct rte_eth_rxconf *rx_conf __rte_unused,
 			     struct rte_mempool *mp)
 {
@@ -730,7 +730,7 @@ mana_dev_rx_queue_setup_lock(struct rte_eth_dev *dev, uint16_t queue_idx,
 	if (mana_reset_trylock(priv))
 		return -EBUSY;
 	ret = mana_dev_rx_queue_setup(dev, queue_idx, nb_desc,
-				      socket_id, rx_conf, mp);
+				      numa_id, rx_conf, mp);
 	pthread_mutex_unlock(&priv->reset_ops_lock);
 	return ret;
 }
@@ -1999,7 +1999,7 @@ mana_proc_priv_init(struct rte_eth_dev *dev)
 {
 	struct mana_process_priv *priv;
 
-	priv = rte_zmalloc_socket("mana_proc_priv",
+	priv = rte_zmalloc_numa("mana_proc_priv",
 				  sizeof(struct mana_process_priv),
 				  RTE_CACHE_LINE_SIZE,
 				  dev->device->numa_node);
@@ -2054,7 +2054,7 @@ mana_init_shared_data(void)
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		mana_shared_mz = rte_memzone_reserve(MZ_MANA_SHARED_DATA,
 						     sizeof(*mana_shared_data),
-						     SOCKET_ID_ANY, 0);
+						     RTE_NUMA_ID_ANY, 0);
 		if (!mana_shared_mz) {
 			DRV_LOG(ERR, "Cannot allocate mana shared data");
 			ret = -rte_errno;
@@ -2168,8 +2168,8 @@ mana_probe_port(struct ibv_device *ibdev, struct ibv_device_attr_ex *dev_attr,
 		DRV_LOG(DEBUG, "Device reset for eth_dev %p priv %p",
 			eth_dev, priv);
 	} else {
-		priv = rte_zmalloc_socket(NULL, sizeof(*priv), RTE_CACHE_LINE_SIZE,
-					  SOCKET_ID_ANY);
+		priv = rte_zmalloc_numa(NULL, sizeof(*priv), RTE_CACHE_LINE_SIZE,
+					  RTE_NUMA_ID_ANY);
 		if (!priv)
 			return -ENOMEM;
 	}
diff --git a/drivers/net/mana/mr.c b/drivers/net/mana/mr.c
index 0ce1a76ed5..3de6a901dc 100644
--- a/drivers/net/mana/mr.c
+++ b/drivers/net/mana/mr.c
@@ -219,7 +219,7 @@ mana_mr_btree_expand(struct mana_mr_btree *bt, int n)
 {
 	void *mem;
 
-	mem = rte_realloc_socket(bt->table, n * sizeof(struct mana_mr_cache),
+	mem = rte_realloc_numa(bt->table, n * sizeof(struct mana_mr_cache),
 				 0, bt->socket);
 	if (!mem) {
 		DP_LOG(ERR, "Failed to expand btree size %d", n);
@@ -287,7 +287,7 @@ int
 mana_mr_btree_init(struct mana_mr_btree *bt, int n, int socket)
 {
 	memset(bt, 0, sizeof(*bt));
-	bt->table = rte_calloc_socket("MANA B-tree table",
+	bt->table = rte_calloc_numa("MANA B-tree table",
 				      n,
 				      sizeof(struct mana_mr_cache),
 				      0, socket);
-- 
2.55.0

