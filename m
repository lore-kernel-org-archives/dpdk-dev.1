Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA34C606A795
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=L6imGFgl
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AE0C42EC8;
	Tue,  3 Nov 2026 16:16:26 +0100 (CET)
Received: from mta1.migadu.com (out-217.mta1.migadu.com [95.215.58.217])
 by mails.dpdk.org (Postfix) with ESMTPS id 078E5427C7
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:16:25 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=IBos/QmBwem3rOOc4HkKsiVJ7QrvJq1mmWtZkpzINzQ=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718984; v=1; x=1794323784;
 b=L6imGFgl4eNdRaQlMlRd0GvrzMowsPFzKjGUGIjbep2cOkNc40shmdsN4kDvMwNBWGqO1KKl
 CzSCGyxFPIdNIJbpCJw9eY2uJGwGPX01b36tMGDgyJBsKQ2Ck1KR4G6Tv6yPraZ0S3ia9rCE6uP
 0Fb3axeMWdfppRaMlTG/S5dk=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 57a44f8f36aafd23;
 Tue, 03 Nov 2026 15:16:24 +0000
X-Mizu-Trace-ID: 57a44f8f36aafd23
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 148/227] net/sxe2: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:46 +0800
Message-ID: <20261103145306.487255-149-chengwen.feng@linux.dev>
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
 drivers/net/sxe2/sxe2_ethdev_repr.c |  2 +-
 drivers/net/sxe2/sxe2_mp.c          |  2 +-
 drivers/net/sxe2/sxe2_rx.c          | 16 ++++++++--------
 drivers/net/sxe2/sxe2_rx.h          |  2 +-
 drivers/net/sxe2/sxe2_tx.c          | 16 ++++++++--------
 drivers/net/sxe2/sxe2_tx.h          |  2 +-
 6 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_ethdev_repr.c b/drivers/net/sxe2/sxe2_ethdev_repr.c
index cee37d5d8e..5be8d45301 100644
--- a/drivers/net/sxe2/sxe2_ethdev_repr.c
+++ b/drivers/net/sxe2/sxe2_ethdev_repr.c
@@ -560,7 +560,7 @@ int32_t sxe2_switchdev_repr_devs_init(struct sxe2_adapter *adapter,
 			goto l_release_port;
 		}
 		eth_dev->data->numa_node = adapter->dev_info.dev_data->numa_node;
-		eth_dev->data->dev_private = rte_zmalloc_socket(name,
+		eth_dev->data->dev_private = rte_zmalloc_numa(name,
 			sizeof(struct sxe2_adapter),
 			RTE_CACHE_LINE_SIZE,
 			eth_dev->data->numa_node);
diff --git a/drivers/net/sxe2/sxe2_mp.c b/drivers/net/sxe2/sxe2_mp.c
index be103322ad..715c86d8db 100644
--- a/drivers/net/sxe2/sxe2_mp.c
+++ b/drivers/net/sxe2/sxe2_mp.c
@@ -135,7 +135,7 @@ sxe2_mp_init_primary(__rte_unused struct rte_eth_dev *dev)
 	if (sxe2_mp_mz == NULL) {
 		sxe2_mp_mz = rte_memzone_reserve(SXE2_MP_MZ_NAME,
 				sizeof(struct sxe2_mp_shared_data),
-				rte_socket_id(), 0);
+				rte_numa_id(), 0);
 		if (sxe2_mp_mz == NULL && rte_errno != EEXIST) {
 			PMD_LOG_ERR(DRV, "Failed to reserve memzone %s, error: %d",
 					SXE2_MP_MZ_NAME, -rte_errno);
diff --git a/drivers/net/sxe2/sxe2_rx.c b/drivers/net/sxe2/sxe2_rx.c
index 3830c676d7..f17e446c23 100644
--- a/drivers/net/sxe2/sxe2_rx.c
+++ b/drivers/net/sxe2/sxe2_rx.c
@@ -189,7 +189,7 @@ void __rte_cold sxe2_all_rxqs_release(struct rte_eth_dev *dev)
 }
 
 static struct sxe2_rx_queue *sxe2_rx_queue_alloc(struct rte_eth_dev *dev, uint16_t queue_idx,
-		uint16_t ring_depth, uint32_t socket_id)
+		uint16_t ring_depth, uint32_t numa_id)
 {
 	struct sxe2_rx_queue *rxq;
 	const struct rte_memzone *tz;
@@ -200,8 +200,8 @@ static struct sxe2_rx_queue *sxe2_rx_queue_alloc(struct rte_eth_dev *dev, uint16
 		dev->data->rx_queues[queue_idx] = NULL;
 	}
 
-	rxq = rte_zmalloc_socket("rx_queue", sizeof(*rxq),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	rxq = rte_zmalloc_numa("rx_queue", sizeof(*rxq),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 
 	if (rxq == NULL) {
 		PMD_LOG_ERR(RX, "rx queue[%d] alloc failed", queue_idx);
@@ -211,9 +211,9 @@ static struct sxe2_rx_queue *sxe2_rx_queue_alloc(struct rte_eth_dev *dev, uint16
 	rxq->ring_depth = ring_depth;
 	len = rxq->ring_depth + SXE2_RX_PKTS_BURST_BATCH_NUM;
 
-	rxq->buffer_ring = rte_zmalloc_socket("rx_buffer_ring",
+	rxq->buffer_ring = rte_zmalloc_numa("rx_buffer_ring",
 					  sizeof(struct rte_mbuf *) * len,
-					  RTE_CACHE_LINE_SIZE, socket_id);
+					  RTE_CACHE_LINE_SIZE, numa_id);
 
 	if (!rxq->buffer_ring) {
 		PMD_LOG_ERR(RX, "Rxq malloc mbuf mem failed");
@@ -223,7 +223,7 @@ static struct sxe2_rx_queue *sxe2_rx_queue_alloc(struct rte_eth_dev *dev, uint16
 	}
 
 	tz = rte_eth_dma_zone_reserve(dev, "rx_dma", queue_idx,
-					SXE2_RX_RING_SIZE, SXE2_DESC_ADDR_ALIGN, socket_id);
+					SXE2_RX_RING_SIZE, SXE2_DESC_ADDR_ALIGN, numa_id);
 	if (tz == NULL) {
 		PMD_LOG_ERR(RX, "Rxq malloc desc mem failed");
 		rte_free(rxq->buffer_ring);
@@ -243,7 +243,7 @@ static struct sxe2_rx_queue *sxe2_rx_queue_alloc(struct rte_eth_dev *dev, uint16
 }
 
 int32_t __rte_cold sxe2_rx_queue_setup(struct rte_eth_dev *dev,
-			uint16_t queue_idx, uint16_t nb_desc, uint32_t socket_id,
+			uint16_t queue_idx, uint16_t nb_desc, uint32_t numa_id,
 			const struct rte_eth_rxconf *rx_conf,
 			struct rte_mempool *mp)
 {
@@ -299,7 +299,7 @@ int32_t __rte_cold sxe2_rx_queue_setup(struct rte_eth_dev *dev,
 		goto l_end;
 	}
 
-	rxq = sxe2_rx_queue_alloc(dev, queue_idx, nb_desc, socket_id);
+	rxq = sxe2_rx_queue_alloc(dev, queue_idx, nb_desc, numa_id);
 	if (rxq == NULL) {
 		PMD_LOG_ERR(RX, "rx queue[%d] resource alloc failed", queue_idx);
 		ret = -ENOMEM;
diff --git a/drivers/net/sxe2/sxe2_rx.h b/drivers/net/sxe2/sxe2_rx.h
index c2582bc571..2fa7d189a1 100644
--- a/drivers/net/sxe2/sxe2_rx.h
+++ b/drivers/net/sxe2/sxe2_rx.h
@@ -8,7 +8,7 @@
 #include "sxe2_queue.h"
 
 int32_t __rte_cold sxe2_rx_queue_setup(struct rte_eth_dev *dev,
-				uint16_t queue_idx, uint16_t nb_desc, uint32_t socket_id,
+				uint16_t queue_idx, uint16_t nb_desc, uint32_t numa_id,
 				const struct rte_eth_rxconf *rx_conf,
 				struct rte_mempool *mp);
 
diff --git a/drivers/net/sxe2/sxe2_tx.c b/drivers/net/sxe2/sxe2_tx.c
index 94a6e9afc7..a05e94effe 100644
--- a/drivers/net/sxe2/sxe2_tx.c
+++ b/drivers/net/sxe2/sxe2_tx.c
@@ -258,7 +258,7 @@ void __rte_cold sxe2_all_txqs_release(struct rte_eth_dev *dev)
 
 static struct sxe2_tx_queue
 *sxe2_tx_queue_alloc(struct rte_eth_dev *dev, uint16_t queue_idx,
-		uint16_t ring_depth, uint32_t socket_id)
+		uint16_t ring_depth, uint32_t numa_id)
 {
 	struct sxe2_tx_queue *txq;
 	const struct rte_memzone *tz;
@@ -268,8 +268,8 @@ static struct sxe2_tx_queue
 		dev->data->tx_queues[queue_idx] = NULL;
 	}
 
-	txq = rte_zmalloc_socket("tx_queue", sizeof(struct sxe2_tx_queue),
-			RTE_CACHE_LINE_SIZE, socket_id);
+	txq = rte_zmalloc_numa("tx_queue", sizeof(struct sxe2_tx_queue),
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq == NULL) {
 		PMD_LOG_ERR(TX, "tx queue:%d alloc failed", queue_idx);
 		goto l_end;
@@ -277,7 +277,7 @@ static struct sxe2_tx_queue
 
 	tz = rte_eth_dma_zone_reserve(dev, "tx_dma", queue_idx,
 			sizeof(union sxe2_tx_data_desc) * SXE2_MAX_RING_DESC,
-			SXE2_DESC_ADDR_ALIGN, socket_id);
+			SXE2_DESC_ADDR_ALIGN, numa_id);
 	if (tz == NULL) {
 		PMD_LOG_ERR(TX, "tx desc ring alloc failed, queue_id:%d", queue_idx);
 		rte_free(txq);
@@ -285,9 +285,9 @@ static struct sxe2_tx_queue
 		goto l_end;
 	}
 
-	txq->buffer_ring = rte_zmalloc_socket("tx_buffer_ring",
+	txq->buffer_ring = rte_zmalloc_numa("tx_buffer_ring",
 		sizeof(struct sxe2_tx_buffer) * ring_depth,
-		RTE_CACHE_LINE_SIZE, socket_id);
+		RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq->buffer_ring == NULL) {
 		PMD_LOG_ERR(TX, "tx buffer alloc failed, queue_id:%d", queue_idx);
 		rte_memzone_free(tz);
@@ -305,7 +305,7 @@ static struct sxe2_tx_queue
 }
 
 int32_t __rte_cold sxe2_tx_queue_setup(struct rte_eth_dev *dev,
-		uint16_t queue_idx, uint16_t nb_desc, uint32_t socket_id,
+		uint16_t queue_idx, uint16_t nb_desc, uint32_t numa_id,
 		const struct rte_eth_txconf *tx_conf)
 {
 	int32_t ret = 0;
@@ -329,7 +329,7 @@ int32_t __rte_cold sxe2_tx_queue_setup(struct rte_eth_dev *dev,
 		goto end;
 	}
 
-	txq = sxe2_tx_queue_alloc(dev, queue_idx, nb_desc, socket_id);
+	txq = sxe2_tx_queue_alloc(dev, queue_idx, nb_desc, numa_id);
 	if (txq == NULL) {
 		PMD_LOG_ERR(TX, "failed to alloc sxe2vf tx queue:%u resource", queue_idx);
 		ret = -ENOMEM;
diff --git a/drivers/net/sxe2/sxe2_tx.h b/drivers/net/sxe2/sxe2_tx.h
index bc5ff1c2bc..37e3a00d6f 100644
--- a/drivers/net/sxe2/sxe2_tx.h
+++ b/drivers/net/sxe2/sxe2_tx.h
@@ -20,7 +20,7 @@ void sxe2_tx_queue_mbufs_release(struct sxe2_tx_queue *txq);
 int32_t __rte_cold sxe2_tx_queue_stop(struct rte_eth_dev *dev, uint16_t queue_id);
 
 int32_t __rte_cold sxe2_tx_queue_setup(struct rte_eth_dev *dev,
-		uint16_t queue_idx, uint16_t nb_desc, uint32_t socket_id,
+		uint16_t queue_idx, uint16_t nb_desc, uint32_t numa_id,
 		const struct rte_eth_txconf *tx_conf);
 
 void __rte_cold sxe2_tx_queue_release(struct rte_eth_dev *dev, uint16_t queue_idx);
-- 
2.55.0

