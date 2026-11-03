Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97472606F614
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=r/ezG0ks
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 986E842ECA;
	Tue,  3 Nov 2026 16:14:22 +0100 (CET)
Received: from mta0.migadu.com (out-52.mta0.migadu.com [91.218.175.52])
 by mails.dpdk.org (Postfix) with ESMTPS id D790042ED2
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:14:20 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=oX4v9eH2FutWWMvqjT+cD47h71y1ZH1oipPuu9ZCfFg=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718859; v=1; x=1794323659;
 b=r/ezG0ksux6hANS6HzTaNcHGvp31YoIGxDLwYhAHdL1Brn3Zr+IS3jtB1oszGsEvjpgkph8Y
 7Xetl6L+C5Sva9LJFJ5npUx6brjQJY97wAiaM0H+XN+iRDFEm1tKmlND3Q3BVL8cqgcJlmQOqLC
 Wf8A+mT3w7bOwviqAZCjAbSw=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 692512129eb23148;
 Tue, 03 Nov 2026 15:14:19 +0000
X-Mizu-Trace-ID: 692512129eb23148
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 135/227] net/ngbe: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:33 +0800
Message-ID: <20261103145306.487255-136-chengwen.feng@linux.dev>
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
 drivers/net/ngbe/ngbe_ethdev.c |  2 +-
 drivers/net/ngbe/ngbe_ethdev.h |  4 ++--
 drivers/net/ngbe/ngbe_rxtx.c   | 28 ++++++++++++++--------------
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ngbe/ngbe_ethdev.c b/drivers/net/ngbe/ngbe_ethdev.c
index dc8e65ecc2..2ad76e7a3c 100644
--- a/drivers/net/ngbe/ngbe_ethdev.c
+++ b/drivers/net/ngbe/ngbe_ethdev.c
@@ -388,7 +388,7 @@ eth_ngbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 
 	/* Reserve memory for interrupt status block */
 	mz = rte_eth_dma_zone_reserve(eth_dev, "ngbe_driver", -1,
-		NGBE_ISB_SIZE, NGBE_ALIGN, SOCKET_ID_ANY);
+		NGBE_ISB_SIZE, NGBE_ALIGN, RTE_NUMA_ID_ANY);
 	if (mz == NULL)
 		return -ENOMEM;
 
diff --git a/drivers/net/ngbe/ngbe_ethdev.h b/drivers/net/ngbe/ngbe_ethdev.h
index 12ee884ce1..6e6bee6391 100644
--- a/drivers/net/ngbe/ngbe_ethdev.h
+++ b/drivers/net/ngbe/ngbe_ethdev.h
@@ -186,12 +186,12 @@ void ngbe_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
 void ngbe_dev_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
 
 int  ngbe_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
-		uint16_t nb_rx_desc, unsigned int socket_id,
+		uint16_t nb_rx_desc, unsigned int numa_id,
 		const struct rte_eth_rxconf *rx_conf,
 		struct rte_mempool *mb_pool);
 
 int  ngbe_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
-		uint16_t nb_tx_desc, unsigned int socket_id,
+		uint16_t nb_tx_desc, unsigned int numa_id,
 		const struct rte_eth_txconf *tx_conf);
 
 int ngbe_dev_rx_queue_count(void *rx_queue);
diff --git a/drivers/net/ngbe/ngbe_rxtx.c b/drivers/net/ngbe/ngbe_rxtx.c
index a1389de9c0..e4be3edc95 100644
--- a/drivers/net/ngbe/ngbe_rxtx.c
+++ b/drivers/net/ngbe/ngbe_rxtx.c
@@ -2007,7 +2007,7 @@ int
 ngbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 			 uint16_t queue_idx,
 			 uint16_t nb_desc,
-			 unsigned int socket_id,
+			 unsigned int numa_id,
 			 const struct rte_eth_txconf *tx_conf)
 {
 	const struct rte_memzone *tz;
@@ -2055,16 +2055,16 @@ ngbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	/* First allocate the Tx queue data structure */
-	txq = rte_zmalloc_socket("ethdev Tx queue",
+	txq = rte_zmalloc_numa("ethdev Tx queue",
 				 sizeof(struct ngbe_tx_queue),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq == NULL)
 		return -ENOMEM;
 
 	/* Allocate Tx ring hardware descriptors. */
 	tz = rte_eth_dma_zone_reserve(dev, "tx_ring", queue_idx,
 			sizeof(struct ngbe_tx_desc) * nb_desc,
-			NGBE_ALIGN, socket_id);
+			NGBE_ALIGN, numa_id);
 	if (tz == NULL) {
 		ngbe_tx_queue_release(txq);
 		return -ENOMEM;
@@ -2091,9 +2091,9 @@ ngbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	txq->tx_ring = (struct ngbe_tx_desc *)TMZ_VADDR(tz);
 
 	/* Allocate software ring */
-	txq->sw_ring = rte_zmalloc_socket("txq->sw_ring",
+	txq->sw_ring = rte_zmalloc_numa("txq->sw_ring",
 				sizeof(struct ngbe_tx_entry) * nb_desc,
-				RTE_CACHE_LINE_SIZE, socket_id);
+				RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq->sw_ring == NULL) {
 		ngbe_tx_queue_release(txq);
 		return -ENOMEM;
@@ -2313,7 +2313,7 @@ int
 ngbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			 uint16_t queue_idx,
 			 uint16_t nb_desc,
-			 unsigned int socket_id,
+			 unsigned int numa_id,
 			 const struct rte_eth_rxconf *rx_conf,
 			 struct rte_mempool *mp)
 {
@@ -2337,9 +2337,9 @@ ngbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	/* First allocate the Rx queue data structure */
-	rxq = rte_zmalloc_socket("ethdev RX queue",
+	rxq = rte_zmalloc_numa("ethdev RX queue",
 				 sizeof(struct ngbe_rx_queue),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (rxq == NULL)
 		return -ENOMEM;
 	rxq->mb_pool = mp;
@@ -2360,7 +2360,7 @@ ngbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	/* Allocate Rx ring hardware descriptors. */
 	size = (nb_desc + RTE_PMD_NGBE_RX_MAX_BURST) * sizeof(struct ngbe_rx_desc);
 	rz = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_idx,
-				      size, NGBE_ALIGN, socket_id);
+				      size, NGBE_ALIGN, numa_id);
 	if (rz == NULL) {
 		ngbe_rx_queue_release(rxq);
 		return -ENOMEM;
@@ -2399,9 +2399,9 @@ ngbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	if (adapter->rx_bulk_alloc_allowed)
 		len += RTE_PMD_NGBE_RX_MAX_BURST;
 
-	rxq->sw_ring = rte_zmalloc_socket("rxq->sw_ring",
+	rxq->sw_ring = rte_zmalloc_numa("rxq->sw_ring",
 					  sizeof(struct ngbe_rx_entry) * len,
-					  RTE_CACHE_LINE_SIZE, socket_id);
+					  RTE_CACHE_LINE_SIZE, numa_id);
 	if (rxq->sw_ring == NULL) {
 		ngbe_rx_queue_release(rxq);
 		return -ENOMEM;
@@ -2416,9 +2416,9 @@ ngbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	 * dev_start() flow.
 	 */
 	rxq->sw_sc_ring =
-		rte_zmalloc_socket("rxq->sw_sc_ring",
+		rte_zmalloc_numa("rxq->sw_sc_ring",
 				  sizeof(struct ngbe_scattered_rx_entry) * len,
-				  RTE_CACHE_LINE_SIZE, socket_id);
+				  RTE_CACHE_LINE_SIZE, numa_id);
 	if (rxq->sw_sc_ring == NULL) {
 		ngbe_rx_queue_release(rxq);
 		return -ENOMEM;
-- 
2.55.0

