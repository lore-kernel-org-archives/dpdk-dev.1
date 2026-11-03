Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181D0606A326
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NSVXia8u
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5EC042DDF;
	Tue,  3 Nov 2026 16:13:16 +0100 (CET)
Received: from mta0.migadu.com (out-14.mta0.migadu.com [91.218.175.14])
 by mails.dpdk.org (Postfix) with ESMTPS id 187CE42E12
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:13:16 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=O27Kgd6prUNWri36zwyTL4pRZfCdJMl5fWWD3fd6hpQ=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718793; v=1; x=1794323593;
 b=NSVXia8uG+R97ew3ho6CLJ9GwuU+JdSA8S3IJMnFDs53Aaxq4jM1kAAa4gJprif7P1gyFkxB
 ABDCcLzuZznsCrO/DgThSE5QTUR6gPhS/GQkZVlHbuz2ZYm9VbOr+bIuPrYpaS27TzxvPfqGHlS
 dYAafd600Ku2cAPiPHRI9Cdk=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 01759796edbbbccb;
 Tue, 03 Nov 2026 15:13:13 +0000
X-Mizu-Trace-ID: 01759796edbbbccb
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 125/227] net/ionic: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:23 +0800
Message-ID: <20261103145306.487255-126-chengwen.feng@linux.dev>
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
 drivers/net/ionic/ionic_lif.c  | 38 +++++++++++++++++-----------------
 drivers/net/ionic/ionic_lif.h  |  4 ++--
 drivers/net/ionic/ionic_main.c |  6 +++---
 drivers/net/ionic/ionic_rxtx.c | 12 +++++------
 drivers/net/ionic/ionic_rxtx.h |  4 ++--
 5 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ionic/ionic_lif.c b/drivers/net/ionic/ionic_lif.c
index 2443c98881..d41c347dd2 100644
--- a/drivers/net/ionic/ionic_lif.c
+++ b/drivers/net/ionic/ionic_lif.c
@@ -585,7 +585,7 @@ static int
 ionic_qcq_alloc(struct ionic_lif *lif,
 		uint8_t type,
 		size_t struct_size,
-		uint32_t socket_id,
+		uint32_t numa_id,
 		uint32_t index,
 		const char *type_name,
 		uint16_t flags,
@@ -626,8 +626,8 @@ ionic_qcq_alloc(struct ionic_lif *lif,
 		total_size += page_size;
 	}
 
-	new = rte_zmalloc_socket("ionic", struct_size,
-				RTE_CACHE_LINE_SIZE, socket_id);
+	new = rte_zmalloc_numa("ionic", struct_size,
+				RTE_CACHE_LINE_SIZE, numa_id);
 	if (!new) {
 		IONIC_PRINT(ERR, "Cannot allocate queue structure");
 		return -ENOMEM;
@@ -636,9 +636,9 @@ ionic_qcq_alloc(struct ionic_lif *lif,
 	new->lif = lif;
 
 	/* Most queue types will store 1 ptr per descriptor */
-	new->q.info = rte_calloc_socket("ionic",
+	new->q.info = rte_calloc_numa("ionic",
 				(uint64_t)num_descs * num_segs,
-				sizeof(void *), page_size, socket_id);
+				sizeof(void *), page_size, numa_id);
 	if (!new->q.info) {
 		IONIC_PRINT(ERR, "Cannot allocate queue info");
 		err = -ENOMEM;
@@ -662,7 +662,7 @@ ionic_qcq_alloc(struct ionic_lif *lif,
 
 	new->base_z = rte_eth_dma_zone_reserve(lif->eth_dev,
 		type_name, index /* queue_idx */,
-		total_size, IONIC_ALIGN, socket_id);
+		total_size, IONIC_ALIGN, numa_id);
 
 	if (!new->base_z) {
 		IONIC_PRINT(ERR, "Cannot reserve queue DMA memory");
@@ -778,7 +778,7 @@ ionic_rx_seg_rearm_data(struct ionic_lif *lif)
 }
 
 int
-ionic_rx_qcq_alloc(struct ionic_lif *lif, uint32_t socket_id, uint32_t index,
+ionic_rx_qcq_alloc(struct ionic_lif *lif, uint32_t numa_id, uint32_t index,
 		uint16_t nrxq_descs, struct rte_mempool *mb_pool,
 		struct ionic_rx_qcq **rxq_out)
 {
@@ -829,7 +829,7 @@ ionic_rx_qcq_alloc(struct ionic_lif *lif, uint32_t socket_id, uint32_t index,
 	err = ionic_qcq_alloc(lif,
 		IONIC_QTYPE_RXQ,
 		sizeof(struct ionic_rx_qcq),
-		socket_id,
+		numa_id,
 		index,
 		"rx",
 		flags,
@@ -855,7 +855,7 @@ ionic_rx_qcq_alloc(struct ionic_lif *lif, uint32_t socket_id, uint32_t index,
 }
 
 int
-ionic_tx_qcq_alloc(struct ionic_lif *lif, uint32_t socket_id, uint32_t index,
+ionic_tx_qcq_alloc(struct ionic_lif *lif, uint32_t numa_id, uint32_t index,
 		uint16_t ntxq_descs, struct ionic_tx_qcq **txq_out)
 {
 	struct ionic_tx_qcq *txq;
@@ -874,7 +874,7 @@ ionic_tx_qcq_alloc(struct ionic_lif *lif, uint32_t socket_id, uint32_t index,
 	err = ionic_qcq_alloc(lif,
 		IONIC_QTYPE_TXQ,
 		sizeof(struct ionic_tx_qcq),
-		socket_id,
+		numa_id,
 		index,
 		"tx",
 		flags,
@@ -905,7 +905,7 @@ ionic_admin_qcq_alloc(struct ionic_lif *lif)
 	err = ionic_qcq_alloc(lif,
 		IONIC_QTYPE_ADMINQ,
 		sizeof(struct ionic_admin_qcq),
-		rte_socket_id(),
+		rte_numa_id(),
 		0,
 		"admin",
 		flags,
@@ -932,7 +932,7 @@ ionic_notify_qcq_alloc(struct ionic_lif *lif)
 	err = ionic_qcq_alloc(lif,
 		IONIC_QTYPE_NOTIFYQ,
 		sizeof(struct ionic_notify_qcq),
-		rte_socket_id(),
+		rte_numa_id(),
 		0,
 		"notify",
 		flags,
@@ -1045,7 +1045,7 @@ int
 ionic_lif_alloc(struct ionic_lif *lif)
 {
 	struct ionic_adapter *adapter = lif->adapter;
-	uint32_t socket_id = rte_socket_id();
+	uint32_t numa_id = rte_numa_id();
 	int err;
 
 	/*
@@ -1087,19 +1087,19 @@ ionic_lif_alloc(struct ionic_lif *lif)
 		return -ENOMEM;
 	}
 
-	lif->txqcqs = rte_calloc_socket("ionic",
+	lif->txqcqs = rte_calloc_numa("ionic",
 				adapter->max_ntxqs_per_lif,
 				sizeof(*lif->txqcqs),
-				RTE_CACHE_LINE_SIZE, socket_id);
+				RTE_CACHE_LINE_SIZE, numa_id);
 	if (!lif->txqcqs) {
 		IONIC_PRINT(ERR, "Cannot allocate tx queues array");
 		return -ENOMEM;
 	}
 
-	lif->rxqcqs = rte_calloc_socket("ionic",
+	lif->rxqcqs = rte_calloc_numa("ionic",
 				adapter->max_nrxqs_per_lif,
 				sizeof(*lif->rxqcqs),
-				RTE_CACHE_LINE_SIZE, socket_id);
+				RTE_CACHE_LINE_SIZE, numa_id);
 	if (!lif->rxqcqs) {
 		IONIC_PRINT(ERR, "Cannot allocate rx queues array");
 		return -ENOMEM;
@@ -1127,7 +1127,7 @@ ionic_lif_alloc(struct ionic_lif *lif)
 
 	lif->info_z = rte_eth_dma_zone_reserve(lif->eth_dev,
 		"lif_info", 0 /* queue_idx*/,
-		lif->info_sz, IONIC_ALIGN, socket_id);
+		lif->info_sz, IONIC_ALIGN, numa_id);
 	if (!lif->info_z) {
 		IONIC_PRINT(ERR, "Cannot allocate lif info memory");
 		return -ENOMEM;
@@ -1239,7 +1239,7 @@ ionic_lif_rss_setup(struct ionic_lif *lif)
 		lif->rss_ind_tbl_z = rte_eth_dma_zone_reserve(lif->eth_dev,
 					"rss_ind_tbl", 0 /* queue_idx */,
 					sizeof(*lif->rss_ind_tbl) * tbl_sz,
-					IONIC_ALIGN, rte_socket_id());
+					IONIC_ALIGN, rte_numa_id());
 		if (!lif->rss_ind_tbl_z) {
 			IONIC_PRINT(ERR, "OOM");
 			return -ENOMEM;
diff --git a/drivers/net/ionic/ionic_lif.h b/drivers/net/ionic/ionic_lif.h
index 2d85ebbcae..38b7b12645 100644
--- a/drivers/net/ionic/ionic_lif.h
+++ b/drivers/net/ionic/ionic_lif.h
@@ -221,10 +221,10 @@ int ionic_dev_promiscuous_disable(struct rte_eth_dev *dev);
 int ionic_dev_allmulticast_enable(struct rte_eth_dev *dev);
 int ionic_dev_allmulticast_disable(struct rte_eth_dev *dev);
 
-int ionic_rx_qcq_alloc(struct ionic_lif *lif, uint32_t socket_id,
+int ionic_rx_qcq_alloc(struct ionic_lif *lif, uint32_t numa_id,
 	uint32_t index, uint16_t nrxq_descs, struct rte_mempool *mp,
 	struct ionic_rx_qcq **qcq_out);
-int ionic_tx_qcq_alloc(struct ionic_lif *lif, uint32_t socket_id,
+int ionic_tx_qcq_alloc(struct ionic_lif *lif, uint32_t numa_id,
 	uint32_t index, uint16_t ntxq_descs,
 	struct ionic_tx_qcq **qcq_out);
 void ionic_qcq_free(struct ionic_qcq *qcq);
diff --git a/drivers/net/ionic/ionic_main.c b/drivers/net/ionic/ionic_main.c
index d5545b1ecb..f11e16ac8c 100644
--- a/drivers/net/ionic/ionic_main.c
+++ b/drivers/net/ionic/ionic_main.c
@@ -463,7 +463,7 @@ ionic_port_identify(struct ionic_adapter *adapter)
 }
 
 static const struct rte_memzone *
-ionic_memzone_reserve(const char *name, uint32_t len, int socket_id)
+ionic_memzone_reserve(const char *name, uint32_t len, int numa_id)
 {
 	const struct rte_memzone *mz;
 
@@ -471,7 +471,7 @@ ionic_memzone_reserve(const char *name, uint32_t len, int socket_id)
 	if (mz)
 		return mz;
 
-	mz = rte_memzone_reserve_aligned(name, len, socket_id,
+	mz = rte_memzone_reserve_aligned(name, len, numa_id,
 		RTE_MEMZONE_IOVA_CONTIG, IONIC_ALIGN);
 	return mz;
 }
@@ -497,7 +497,7 @@ ionic_port_init(struct ionic_adapter *adapter)
 		IONIC_DRV_NAME, adapter->name);
 
 	idev->port_info_z = ionic_memzone_reserve(z_name, idev->port_info_sz,
-		SOCKET_ID_ANY);
+		RTE_NUMA_ID_ANY);
 	if (!idev->port_info_z) {
 		IONIC_PRINT(ERR, "Cannot reserve port info DMA memory");
 		return -ENOMEM;
diff --git a/drivers/net/ionic/ionic_rxtx.c b/drivers/net/ionic/ionic_rxtx.c
index 339b20f113..d028b7d066 100644
--- a/drivers/net/ionic/ionic_rxtx.c
+++ b/drivers/net/ionic/ionic_rxtx.c
@@ -132,7 +132,7 @@ ionic_dev_tx_queue_stop_secondhalf(struct rte_eth_dev *dev,
 
 int __rte_cold
 ionic_dev_tx_queue_setup(struct rte_eth_dev *eth_dev, uint16_t tx_queue_id,
-		uint16_t nb_desc, uint32_t socket_id,
+		uint16_t nb_desc, uint32_t numa_id,
 		const struct rte_eth_txconf *tx_conf)
 {
 	struct ionic_lif *lif = IONIC_ETH_DEV_TO_LIF(eth_dev);
@@ -150,7 +150,7 @@ ionic_dev_tx_queue_setup(struct rte_eth_dev *eth_dev, uint16_t tx_queue_id,
 	offloads = tx_conf->offloads | eth_dev->data->dev_conf.txmode.offloads;
 	IONIC_PRINT(DEBUG,
 		"Configuring skt %u TX queue %u with %u buffers, offloads %jx",
-		socket_id, tx_queue_id, nb_desc, offloads);
+		numa_id, tx_queue_id, nb_desc, offloads);
 
 	/* Validate number of receive descriptors */
 	if (!rte_is_power_of_2(nb_desc) || nb_desc < IONIC_MIN_RING_DESC)
@@ -172,7 +172,7 @@ ionic_dev_tx_queue_setup(struct rte_eth_dev *eth_dev, uint16_t tx_queue_id,
 	eth_dev->data->tx_queue_state[tx_queue_id] =
 		RTE_ETH_QUEUE_STATE_STOPPED;
 
-	err = ionic_tx_qcq_alloc(lif, socket_id, tx_queue_id, nb_desc, &txq);
+	err = ionic_tx_qcq_alloc(lif, numa_id, tx_queue_id, nb_desc, &txq);
 	if (err) {
 		IONIC_PRINT(DEBUG, "Queue allocation failure");
 		return -EINVAL;
@@ -536,7 +536,7 @@ int __rte_cold
 ionic_dev_rx_queue_setup(struct rte_eth_dev *eth_dev,
 		uint16_t rx_queue_id,
 		uint16_t nb_desc,
-		uint32_t socket_id,
+		uint32_t numa_id,
 		const struct rte_eth_rxconf *rx_conf,
 		struct rte_mempool *mp)
 {
@@ -555,7 +555,7 @@ ionic_dev_rx_queue_setup(struct rte_eth_dev *eth_dev,
 	offloads = rx_conf->offloads | eth_dev->data->dev_conf.rxmode.offloads;
 	IONIC_PRINT(DEBUG,
 		"Configuring skt %u RX queue %u with %u buffers, offloads %jx",
-		socket_id, rx_queue_id, nb_desc, offloads);
+		numa_id, rx_queue_id, nb_desc, offloads);
 
 	if (!rx_conf->rx_drop_en)
 		IONIC_PRINT(WARNING, "No-drop mode is not supported");
@@ -579,7 +579,7 @@ ionic_dev_rx_queue_setup(struct rte_eth_dev *eth_dev,
 	eth_dev->data->rx_queue_state[rx_queue_id] =
 		RTE_ETH_QUEUE_STATE_STOPPED;
 
-	err = ionic_rx_qcq_alloc(lif, socket_id, rx_queue_id, nb_desc, mp,
+	err = ionic_rx_qcq_alloc(lif, numa_id, rx_queue_id, nb_desc, mp,
 			&rxq);
 	if (err) {
 		IONIC_PRINT(ERR, "Queue %d allocation failure", rx_queue_id);
diff --git a/drivers/net/ionic/ionic_rxtx.h b/drivers/net/ionic/ionic_rxtx.h
index b3e4e5e5b3..d8337a247d 100644
--- a/drivers/net/ionic/ionic_rxtx.h
+++ b/drivers/net/ionic/ionic_rxtx.h
@@ -33,14 +33,14 @@ extern const uint32_t ionic_ptype_table[IONIC_RXQ_COMP_PKT_TYPE_MASK];
 
 /* ionic_rxtx.c */
 int ionic_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
-	uint16_t nb_desc, uint32_t socket_id,
+	uint16_t nb_desc, uint32_t numa_id,
 	const struct rte_eth_rxconf *rx_conf, struct rte_mempool *mp);
 void ionic_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
 int ionic_dev_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id);
 int ionic_dev_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id);
 
 int ionic_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
-	uint16_t nb_desc,  uint32_t socket_id,
+	uint16_t nb_desc,  uint32_t numa_id,
 	const struct rte_eth_txconf *tx_conf);
 void ionic_dev_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
 int ionic_dev_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id);
-- 
2.55.0

