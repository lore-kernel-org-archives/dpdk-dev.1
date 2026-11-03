Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62785606A326
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jPDCWRVy
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A17842E49;
	Tue,  3 Nov 2026 16:10:31 +0100 (CET)
Received: from mta1.migadu.com (out-83.mta1.migadu.com [95.215.58.83])
 by mails.dpdk.org (Postfix) with ESMTPS id 8699542E49
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:10:30 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=NG2aAS68o6zg5BhqBqiPvxM7vlTQ4hc7MhjyClUzGC4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718630; v=1; x=1794323430;
 b=jPDCWRVyjZdHdW6hzPdEoQDF0IwYkrJSXgFvMnPZ7pW59HKb+vQmVWaVrFyYGDBZKfNhK8NA
 gNPEnOH1iZerlPYVF43nDH6bFB1dmLxrwP87fGkZXqvMpGNYd2B0qxZX4PnbG+NkXBq/kSKKBIh
 OvqJhw/92TPy9Aktl0T1N4sI=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id b7ed6e86fd6c27fd;
 Tue, 03 Nov 2026 15:10:30 +0000
X-Mizu-Trace-ID: b7ed6e86fd6c27fd
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 105/227] net/atlantic: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:03 +0800
Message-ID: <20261103145306.487255-106-chengwen.feng@linux.dev>
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
 drivers/net/atlantic/atl_ethdev.h |  4 ++--
 drivers/net/atlantic/atl_rxtx.c   | 24 ++++++++++++------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/atlantic/atl_ethdev.h b/drivers/net/atlantic/atl_ethdev.h
index d2f951c146..41bd29652f 100644
--- a/drivers/net/atlantic/atl_ethdev.h
+++ b/drivers/net/atlantic/atl_ethdev.h
@@ -58,12 +58,12 @@ void atl_rx_queue_release(struct rte_eth_dev *dev, uint16_t rx_queue_id);
 void atl_tx_queue_release(struct rte_eth_dev *dev, uint16_t tx_queue_id);
 
 int atl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
-		uint16_t nb_rx_desc, unsigned int socket_id,
+		uint16_t nb_rx_desc, unsigned int numa_id,
 		const struct rte_eth_rxconf *rx_conf,
 		struct rte_mempool *mb_pool);
 
 int atl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
-		uint16_t nb_tx_desc, unsigned int socket_id,
+		uint16_t nb_tx_desc, unsigned int numa_id,
 		const struct rte_eth_txconf *tx_conf);
 
 int atl_rx_queue_count(void *rx_queue);
diff --git a/drivers/net/atlantic/atl_rxtx.c b/drivers/net/atlantic/atl_rxtx.c
index 8d02b92304..016351e69d 100644
--- a/drivers/net/atlantic/atl_rxtx.c
+++ b/drivers/net/atlantic/atl_rxtx.c
@@ -100,7 +100,7 @@ atl_reset_rx_queue(struct atl_rx_queue *rxq)
 
 int
 atl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
-		   uint16_t nb_rx_desc, unsigned int socket_id,
+		   uint16_t nb_rx_desc, unsigned int numa_id,
 		   const struct rte_eth_rxconf *rx_conf,
 		   struct rte_mempool *mb_pool)
 {
@@ -130,8 +130,8 @@ atl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
 	}
 
 	/* allocate memory for the queue structure */
-	rxq = rte_zmalloc_socket("atlantic Rx queue", sizeof(*rxq),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	rxq = rte_zmalloc_numa("atlantic Rx queue", sizeof(*rxq),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (rxq == NULL) {
 		PMD_INIT_LOG(ERR, "Cannot allocate queue structure");
 		return -ENOMEM;
@@ -152,9 +152,9 @@ atl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
 		PMD_DRV_LOG(ERR, "PMD does not support KEEP_CRC offload");
 
 	/* allocate memory for the software ring */
-	rxq->sw_ring = rte_zmalloc_socket("atlantic sw rx ring",
+	rxq->sw_ring = rte_zmalloc_numa("atlantic sw rx ring",
 				nb_rx_desc * sizeof(struct atl_rx_entry),
-				RTE_CACHE_LINE_SIZE, socket_id);
+				RTE_CACHE_LINE_SIZE, numa_id);
 	if (rxq->sw_ring == NULL) {
 		PMD_INIT_LOG(ERR,
 			"Port %d: Cannot allocate software ring for queue %d",
@@ -171,7 +171,7 @@ atl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
 	mz = rte_eth_dma_zone_reserve(dev, "rx hw_ring", rx_queue_id,
 				      HW_ATL_B0_MAX_RXD *
 					sizeof(struct hw_atl_rxd_s),
-				      128, socket_id);
+				      128, numa_id);
 	if (mz == NULL) {
 		PMD_INIT_LOG(ERR,
 			"Port %d: Cannot allocate hardware ring for queue %d",
@@ -223,7 +223,7 @@ atl_reset_tx_queue(struct atl_tx_queue *txq)
 
 int
 atl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
-		   uint16_t nb_tx_desc, unsigned int socket_id,
+		   uint16_t nb_tx_desc, unsigned int numa_id,
 		   const struct rte_eth_txconf *tx_conf)
 {
 	struct atl_tx_queue *txq;
@@ -252,8 +252,8 @@ atl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 	}
 
 	/* allocate memory for the queue structure */
-	txq = rte_zmalloc_socket("atlantic Tx queue", sizeof(*txq),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	txq = rte_zmalloc_numa("atlantic Tx queue", sizeof(*txq),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq == NULL) {
 		PMD_INIT_LOG(ERR, "Cannot allocate queue structure");
 		return -ENOMEM;
@@ -267,9 +267,9 @@ atl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 
 
 	/* allocate memory for the software ring */
-	txq->sw_ring = rte_zmalloc_socket("atlantic sw tx ring",
+	txq->sw_ring = rte_zmalloc_numa("atlantic sw tx ring",
 				nb_tx_desc * sizeof(struct atl_tx_entry),
-				RTE_CACHE_LINE_SIZE, socket_id);
+				RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq->sw_ring == NULL) {
 		PMD_INIT_LOG(ERR,
 			"Port %d: Cannot allocate software ring for queue %d",
@@ -285,7 +285,7 @@ atl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 	 */
 	mz = rte_eth_dma_zone_reserve(dev, "tx hw_ring", tx_queue_id,
 				HW_ATL_B0_MAX_TXD * sizeof(struct hw_atl_txd_s),
-				128, socket_id);
+				128, numa_id);
 	if (mz == NULL) {
 		PMD_INIT_LOG(ERR,
 			"Port %d: Cannot allocate hardware ring for queue %d",
-- 
2.55.0

