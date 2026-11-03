Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A191606B25C
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UlJF4iIk
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B06AE42ED4;
	Tue,  3 Nov 2026 16:15:47 +0100 (CET)
Received: from mta0.migadu.com (out-108.mta0.migadu.com [91.218.175.108])
 by mails.dpdk.org (Postfix) with ESMTPS id 9E88742EC8
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:15:46 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=8qyzDHfwZVLCEQ4u46KM8sMeb8BPNkpKgO2hHrLCtc8=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718946; v=1; x=1794323746;
 b=UlJF4iIkzQmfH1L0FEI+WlCdi4RqaTaSd58FyLuoxUvEgRs9ZhO/+RUM7Fd/Br2Kva04y9aI
 5QbxbEjWIYePblW8MABQDleRP7g6bAhWMcZ0ikmrrH5WaZHB4l90c4+QT+V14esEMokpFCdUiRE
 DAnBT3sUW6BdNSEqCQvyGvoc=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 4c9f7990de327cbd;
 Tue, 03 Nov 2026 15:15:46 +0000
X-Mizu-Trace-ID: 4c9f7990de327cbd
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 143/227] net/r8169: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:41 +0800
Message-ID: <20261103145306.487255-144-chengwen.feng@linux.dev>
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
 drivers/net/r8169/r8169_ethdev.h |  4 ++--
 drivers/net/r8169/r8169_hw.c     |  2 +-
 drivers/net/r8169/r8169_rxtx.c   | 16 ++++++++--------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/r8169/r8169_ethdev.h b/drivers/net/r8169/r8169_ethdev.h
index d3676ee7d2..d73c96e5cf 100644
--- a/drivers/net/r8169/r8169_ethdev.h
+++ b/drivers/net/r8169/r8169_ethdev.h
@@ -289,11 +289,11 @@ uint64_t rtl_get_rx_port_offloads(struct rtl_hw *hw);
 uint64_t rtl_get_tx_port_offloads(void);
 
 int rtl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
-		       uint16_t nb_rx_desc, unsigned int socket_id,
+		       uint16_t nb_rx_desc, unsigned int numa_id,
 		       const struct rte_eth_rxconf *rx_conf,
 		       struct rte_mempool *mb_pool);
 int rtl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
-		       uint16_t nb_tx_desc, unsigned int socket_id,
+		       uint16_t nb_tx_desc, unsigned int numa_id,
 		       const struct rte_eth_txconf *tx_conf);
 
 int rtl_tx_done_cleanup(void *tx_queue, uint32_t free_cnt);
diff --git a/drivers/net/r8169/r8169_hw.c b/drivers/net/r8169/r8169_hw.c
index f15bd579fd..4de7aa4ac1 100644
--- a/drivers/net/r8169/r8169_hw.c
+++ b/drivers/net/r8169/r8169_hw.c
@@ -2597,7 +2597,7 @@ rtl_tally_init(struct rte_eth_dev *dev)
 	const struct rte_memzone *mz;
 
 	mz = rte_eth_dma_zone_reserve(dev, "tally_counters", 0,
-				      sizeof(struct rtl_counters), 64, rte_socket_id());
+				      sizeof(struct rtl_counters), 64, rte_numa_id());
 	if (mz == NULL)
 		return -ENOMEM;
 
diff --git a/drivers/net/r8169/r8169_rxtx.c b/drivers/net/r8169/r8169_rxtx.c
index 00de0471f4..7d39e56b8c 100644
--- a/drivers/net/r8169/r8169_rxtx.c
+++ b/drivers/net/r8169/r8169_rxtx.c
@@ -328,7 +328,7 @@ rtl_get_rx_port_offloads(struct rtl_hw *hw)
 
 int
 rtl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
-		   uint16_t nb_rx_desc, unsigned int socket_id,
+		   uint16_t nb_rx_desc, unsigned int numa_id,
 		   const struct rte_eth_rxconf *rx_conf,
 		   struct rte_mempool *mb_pool)
 {
@@ -351,8 +351,8 @@ rtl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	}
 
 	/* First allocate the rx queue data structure */
-	rxq = rte_zmalloc_socket("r8169 RX queue", sizeof(struct rtl_rx_queue),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	rxq = rte_zmalloc_numa("r8169 RX queue", sizeof(struct rtl_rx_queue),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 
 	if (rxq == NULL) {
 		PMD_INIT_LOG(ERR, "Cannot allocate Rx queue structure");
@@ -385,7 +385,7 @@ rtl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	 */
 	size = hw->RxDescLength * (nb_rx_desc + 1);
 	mz = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_idx, size,
-				      RTL_RING_ALIGN, socket_id);
+				      RTL_RING_ALIGN, numa_id);
 	if (mz == NULL) {
 		PMD_INIT_LOG(ERR,
 			     "Port %d: Cannot allocate software ring for queue %d",
@@ -1258,7 +1258,7 @@ rtl_get_tx_port_offloads(void)
 
 int
 rtl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
-		   uint16_t nb_tx_desc, unsigned int socket_id,
+		   uint16_t nb_tx_desc, unsigned int numa_id,
 		   const struct rte_eth_txconf *tx_conf)
 {
 	struct rtl_tx_queue *txq;
@@ -1279,8 +1279,8 @@ rtl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		dev->data->tx_queues[queue_idx] = NULL;
 	}
 
-	txq = rte_zmalloc_socket("r8169 TX queue", sizeof(struct rtl_tx_queue),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	txq = rte_zmalloc_numa("r8169 TX queue", sizeof(struct rtl_tx_queue),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 
 	if (!txq) {
 		PMD_INIT_LOG(ERR, "Cannot allocate Tx queue structure");
@@ -1312,7 +1312,7 @@ rtl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	 */
 	size = sizeof(struct rtl_tx_desc) * (nb_tx_desc + 1);
 	mz = rte_eth_dma_zone_reserve(dev, "tx_ring", queue_idx, size,
-				      RTL_RING_ALIGN, socket_id);
+				      RTL_RING_ALIGN, numa_id);
 	if (mz == NULL) {
 		PMD_INIT_LOG(ERR,
 			     "Port %d: Cannot allocate hardware ring for queue %d",
-- 
2.55.0

