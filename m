Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA12606A33B
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=I6JAWvuT
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EADD942EEB;
	Tue,  3 Nov 2026 16:16:46 +0100 (CET)
Received: from mta0.migadu.com (out-132.mta0.migadu.com [91.218.175.132])
 by mails.dpdk.org (Postfix) with ESMTPS id 03CC242EEC
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:16:45 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=OxP6x1P5m698RhN33i4npwKXYNkM4pJuL9xgPG1Ly10=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719004; v=1; x=1794323804;
 b=I6JAWvuTpgYigULBdnnxSgYte9iIfI7n7X9E5MYFe0tVkuO/VjCU5lQ/xTVgF5LiGRWV0O0M
 UV+O84ANWPezUa+CKl7RvyvZJJUd19+IVRtErS1fP6rRC9y1pnPzxrbo5mSJ7TnTC5nr19+oTw1
 leud1HzMjUmbjqNBzyhLwm00=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 10930c78c828a9c2;
 Tue, 03 Nov 2026 15:16:44 +0000
X-Mizu-Trace-ID: 10930c78c828a9c2
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 151/227] net/txgbe: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:49 +0800
Message-ID: <20261103145306.487255-152-chengwen.feng@linux.dev>
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
 drivers/net/txgbe/txgbe_ethdev.c |  2 +-
 drivers/net/txgbe/txgbe_ethdev.h |  4 ++--
 drivers/net/txgbe/txgbe_rxtx.c   | 34 ++++++++++++++++----------------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index fe7fed704f..da562bda15 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -719,7 +719,7 @@ eth_txgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 
 	/* Reserve memory for interrupt status block */
 	mz = rte_eth_dma_zone_reserve(eth_dev, "txgbe_driver", -1,
-		16, TXGBE_ALIGN, SOCKET_ID_ANY);
+		16, TXGBE_ALIGN, RTE_NUMA_ID_ANY);
 	if (mz == NULL)
 		return -ENOMEM;
 
diff --git a/drivers/net/txgbe/txgbe_ethdev.h b/drivers/net/txgbe/txgbe_ethdev.h
index 28dfa1bc5e..3dfc751572 100644
--- a/drivers/net/txgbe/txgbe_ethdev.h
+++ b/drivers/net/txgbe/txgbe_ethdev.h
@@ -435,12 +435,12 @@ void txgbe_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
 void txgbe_dev_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
 
 int  txgbe_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
-		uint16_t nb_rx_desc, unsigned int socket_id,
+		uint16_t nb_rx_desc, unsigned int numa_id,
 		const struct rte_eth_rxconf *rx_conf,
 		struct rte_mempool *mb_pool);
 
 int  txgbe_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
-		uint16_t nb_tx_desc, unsigned int socket_id,
+		uint16_t nb_tx_desc, unsigned int numa_id,
 		const struct rte_eth_txconf *tx_conf);
 
 int txgbe_dev_rx_queue_count(void *rx_queue);
diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index a295666f9d..e2e8a02df4 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -2423,7 +2423,7 @@ txgbe_get_tx_port_offloads(struct rte_eth_dev *dev)
 static void
 txgbe_setup_headwb_resources(struct rte_eth_dev *dev,
 					void *tx_queue,
-					unsigned int socket_id)
+					unsigned int numa_id)
 {
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	const struct rte_memzone *headwb;
@@ -2439,7 +2439,7 @@ txgbe_setup_headwb_resources(struct rte_eth_dev *dev,
 	headwb_size = txq->headwb_size;
 	headwb = rte_eth_dma_zone_reserve(dev, "tx_headwb_mem", txq->queue_id,
 			sizeof(u32) * headwb_size,
-			TXGBE_ALIGN, socket_id);
+			TXGBE_ALIGN, numa_id);
 
 	if (headwb == NULL) {
 		PMD_DRV_LOG(INFO,
@@ -2461,7 +2461,7 @@ int __rte_cold
 txgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 			 uint16_t queue_idx,
 			 uint16_t nb_desc,
-			 unsigned int socket_id,
+			 unsigned int numa_id,
 			 const struct rte_eth_txconf *tx_conf)
 {
 	const struct rte_memzone *tz;
@@ -2522,16 +2522,16 @@ txgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	/* First allocate the tx queue data structure */
-	txq = rte_zmalloc_socket("ethdev TX queue",
+	txq = rte_zmalloc_numa("ethdev TX queue",
 				 sizeof(struct txgbe_tx_queue),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq == NULL)
 		return -ENOMEM;
 
 	/* Allocate TX ring hardware descriptors. */
 	tz = rte_eth_dma_zone_reserve(dev, "tx_ring", queue_idx,
 			sizeof(struct txgbe_tx_desc) * nb_desc,
-			TXGBE_ALIGN, socket_id);
+			TXGBE_ALIGN, numa_id);
 	if (tz == NULL) {
 		txgbe_tx_queue_release(txq);
 		return -ENOMEM;
@@ -2573,9 +2573,9 @@ txgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	txq->tx_ring = (struct txgbe_tx_desc *)TMZ_VADDR(tz);
 
 	/* Allocate software ring */
-	txq->sw_ring = rte_zmalloc_socket("txq->sw_ring",
+	txq->sw_ring = rte_zmalloc_numa("txq->sw_ring",
 				sizeof(struct txgbe_tx_entry) * nb_desc,
-				RTE_CACHE_LINE_SIZE, socket_id);
+				RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq->sw_ring == NULL) {
 		txgbe_tx_queue_release(txq);
 		return -ENOMEM;
@@ -2586,7 +2586,7 @@ txgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	/* set up scalar TX function as appropriate */
 	txgbe_set_tx_function(dev, txq);
 
-	txgbe_setup_headwb_resources(dev, txq, socket_id);
+	txgbe_setup_headwb_resources(dev, txq, numa_id);
 
 	txq->ops->reset(txq);
 	txq->desc_error = 0;
@@ -2774,7 +2774,7 @@ int __rte_cold
 txgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			 uint16_t queue_idx,
 			 uint16_t nb_desc,
-			 unsigned int socket_id,
+			 unsigned int numa_id,
 			 const struct rte_eth_rxconf *rx_conf,
 			 struct rte_mempool *mp)
 {
@@ -2809,9 +2809,9 @@ txgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	/* First allocate the rx queue data structure */
-	rxq = rte_zmalloc_socket("ethdev RX queue",
+	rxq = rte_zmalloc_numa("ethdev RX queue",
 				 sizeof(struct txgbe_rx_queue),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (rxq == NULL)
 		return -ENOMEM;
 	rxq->mb_pool = mp;
@@ -2838,7 +2838,7 @@ txgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	/* Allocate RX ring hardware descriptors. */
 	size = (nb_desc + RTE_PMD_TXGBE_RX_MAX_BURST) * sizeof(struct txgbe_rx_desc);
 	rz = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_idx,
-				      size, TXGBE_ALIGN, socket_id);
+				      size, TXGBE_ALIGN, numa_id);
 	if (rz == NULL) {
 		txgbe_rx_queue_release(rxq);
 		return -ENOMEM;
@@ -2890,9 +2890,9 @@ txgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	if (adapter->rx_bulk_alloc_allowed)
 		len += RTE_PMD_TXGBE_RX_MAX_BURST;
 
-	rxq->sw_ring = rte_zmalloc_socket("rxq->sw_ring",
+	rxq->sw_ring = rte_zmalloc_numa("rxq->sw_ring",
 					  sizeof(struct txgbe_rx_entry) * len,
-					  RTE_CACHE_LINE_SIZE, socket_id);
+					  RTE_CACHE_LINE_SIZE, numa_id);
 	if (!rxq->sw_ring) {
 		txgbe_rx_queue_release(rxq);
 		return -ENOMEM;
@@ -2907,9 +2907,9 @@ txgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	 * dev_start() flow.
 	 */
 	rxq->sw_sc_ring =
-		rte_zmalloc_socket("rxq->sw_sc_ring",
+		rte_zmalloc_numa("rxq->sw_sc_ring",
 				  sizeof(struct txgbe_scattered_rx_entry) * len,
-				  RTE_CACHE_LINE_SIZE, socket_id);
+				  RTE_CACHE_LINE_SIZE, numa_id);
 	if (!rxq->sw_sc_ring) {
 		txgbe_rx_queue_release(rxq);
 		return -ENOMEM;
-- 
2.55.0

