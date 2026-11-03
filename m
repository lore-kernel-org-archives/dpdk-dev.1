Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228AB606D818
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RWN5hX05
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFB5942DCE;
	Tue,  3 Nov 2026 16:10:54 +0100 (CET)
Received: from mta1.migadu.com (out-119.mta1.migadu.com [95.215.58.119])
 by mails.dpdk.org (Postfix) with ESMTPS id 3C4D0427D7
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:10:53 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=W3E0Uc75k55WziYBbP4ez5QBBumrhxeIo8PM6SmpOU0=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718653; v=1; x=1794323453;
 b=RWN5hX05YkHpF4jNgI3ilcMTt/Cba+GRiV3PyUbgPJ1lqvAjSrmiv094PIBufIp4rgqdR+Qw
 B81D25md6rWB82b80pOdBY1gSH7lhFlipC4nNDhbKBXsIDX8rqxhs6UURS0IcCzsWsgDzBvzaYN
 /VXX2sgX8xlDlLUcsC2lGCNQ=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 052af9551a215585;
 Tue, 03 Nov 2026 15:10:52 +0000
X-Mizu-Trace-ID: 052af9551a215585
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 108/227] net/bnx2x: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:06 +0800
Message-ID: <20261103145306.487255-109-chengwen.feng@linux.dev>
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
 drivers/net/bnx2x/bnx2x.c      |  2 +-
 drivers/net/bnx2x/bnx2x_rxtx.c | 22 +++++++++++-----------
 drivers/net/bnx2x/bnx2x_rxtx.h |  4 ++--
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/bnx2x/bnx2x.c b/drivers/net/bnx2x/bnx2x.c
index 2924fed66b..fdb3290413 100644
--- a/drivers/net/bnx2x/bnx2x.c
+++ b/drivers/net/bnx2x/bnx2x.c
@@ -156,7 +156,7 @@ bnx2x_dma_alloc(struct bnx2x_softc *sc, size_t size, struct bnx2x_dma *dma,
 
 	/* Caller must take care that strlen(mz_name) < RTE_MEMZONE_NAMESIZE */
 	z = rte_memzone_reserve_aligned(mz_name, (uint64_t)size,
-					SOCKET_ID_ANY,
+					RTE_NUMA_ID_ANY,
 					RTE_MEMZONE_IOVA_CONTIG, align);
 	if (z == NULL) {
 		PMD_DRV_LOG(ERR, sc, "DMA alloc failed for %s", msg);
diff --git a/drivers/net/bnx2x/bnx2x_rxtx.c b/drivers/net/bnx2x/bnx2x_rxtx.c
index fbc0bb7698..0b8451d4ab 100644
--- a/drivers/net/bnx2x/bnx2x_rxtx.c
+++ b/drivers/net/bnx2x/bnx2x_rxtx.c
@@ -10,10 +10,10 @@
 
 static const struct rte_memzone *
 ring_dma_zone_reserve(struct rte_eth_dev *dev, const char *ring_name,
-		      uint16_t queue_id, uint32_t ring_size, int socket_id)
+		      uint16_t queue_id, uint32_t ring_size, int numa_id)
 {
 	return rte_eth_dma_zone_reserve(dev, ring_name, queue_id,
-			ring_size, BNX2X_PAGE_SIZE, socket_id);
+			ring_size, BNX2X_PAGE_SIZE, numa_id);
 }
 
 static void
@@ -45,7 +45,7 @@ int
 bnx2x_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		       uint16_t queue_idx,
 		       uint16_t nb_desc,
-		       unsigned int socket_id,
+		       unsigned int numa_id,
 		       __rte_unused const struct rte_eth_rxconf *rx_conf,
 		       struct rte_mempool *mp)
 {
@@ -61,8 +61,8 @@ bnx2x_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	rte_iova_t busaddr;
 
 	/* First allocate the rx queue data structure */
-	rxq = rte_zmalloc_socket("ethdev RX queue", sizeof(struct bnx2x_rx_queue),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	rxq = rte_zmalloc_numa("ethdev RX queue", sizeof(struct bnx2x_rx_queue),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (NULL == rxq) {
 		PMD_DRV_LOG(ERR, sc, "rte_zmalloc for rxq failed!");
 		return -ENOMEM;
@@ -88,7 +88,7 @@ bnx2x_dev_rx_queue_setup(struct rte_eth_dev *dev,
 
 	/* Allocate RX ring hardware descriptors */
 	dma_size = rxq->nb_rx_desc * sizeof(struct eth_rx_bd);
-	dma = ring_dma_zone_reserve(dev, "hw_ring", queue_idx, dma_size, socket_id);
+	dma = ring_dma_zone_reserve(dev, "hw_ring", queue_idx, dma_size, numa_id);
 	if (NULL == dma) {
 		PMD_RX_LOG(ERR, "ring_dma_zone_reserve for rx_ring failed!");
 		bnx2x_rx_queue_release(rxq);
@@ -107,9 +107,9 @@ bnx2x_dev_rx_queue_setup(struct rte_eth_dev *dev,
 
 	/* Allocate software ring */
 	dma_size = rxq->nb_rx_desc * sizeof(struct bnx2x_rx_entry);
-	rxq->sw_ring = rte_zmalloc_socket("sw_ring", dma_size,
+	rxq->sw_ring = rte_zmalloc_numa("sw_ring", dma_size,
 					  RTE_CACHE_LINE_SIZE,
-					  socket_id);
+					  numa_id);
 	if (NULL == rxq->sw_ring) {
 		PMD_RX_LOG(ERR, "rte_zmalloc for sw_ring failed!");
 		bnx2x_rx_queue_release(rxq);
@@ -136,7 +136,7 @@ bnx2x_dev_rx_queue_setup(struct rte_eth_dev *dev,
 
 	/* Allocate CQ chain. */
 	dma_size = BNX2X_RX_CHAIN_PAGE_SZ * rxq->nb_cq_pages;
-	dma = ring_dma_zone_reserve(dev, "bnx2x_rcq", queue_idx, dma_size, socket_id);
+	dma = ring_dma_zone_reserve(dev, "bnx2x_rcq", queue_idx, dma_size, numa_id);
 	if (NULL == dma) {
 		PMD_RX_LOG(ERR, "RCQ  alloc failed");
 		return -ENOMEM;
@@ -231,7 +231,7 @@ int
 bnx2x_dev_tx_queue_setup(struct rte_eth_dev *dev,
 		       uint16_t queue_idx,
 		       uint16_t nb_desc,
-		       unsigned int socket_id,
+		       unsigned int numa_id,
 		       const struct rte_eth_txconf *tx_conf)
 {
 	uint16_t i;
@@ -270,7 +270,7 @@ bnx2x_dev_tx_queue_setup(struct rte_eth_dev *dev,
 
 	/* Allocate TX ring hardware descriptors */
 	tsize = txq->nb_tx_desc * sizeof(union eth_tx_bd_types);
-	tz = ring_dma_zone_reserve(dev, "tx_hw_ring", queue_idx, tsize, socket_id);
+	tz = ring_dma_zone_reserve(dev, "tx_hw_ring", queue_idx, tsize, numa_id);
 	if (tz == NULL) {
 		bnx2x_tx_queue_release(txq);
 		return -ENOMEM;
diff --git a/drivers/net/bnx2x/bnx2x_rxtx.h b/drivers/net/bnx2x/bnx2x_rxtx.h
index 247a72230b..c8dc12156d 100644
--- a/drivers/net/bnx2x/bnx2x_rxtx.h
+++ b/drivers/net/bnx2x/bnx2x_rxtx.h
@@ -64,12 +64,12 @@ struct bnx2x_tx_queue {
 };
 
 int bnx2x_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
-			      uint16_t nb_rx_desc, unsigned int socket_id,
+			      uint16_t nb_rx_desc, unsigned int numa_id,
 			      const struct rte_eth_rxconf *rx_conf,
 			      struct rte_mempool *mb_pool);
 
 int bnx2x_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
-			      uint16_t nb_tx_desc, unsigned int socket_id,
+			      uint16_t nb_tx_desc, unsigned int numa_id,
 			      const struct rte_eth_txconf *tx_conf);
 
 void bnx2x_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t queue_idx);
-- 
2.55.0

