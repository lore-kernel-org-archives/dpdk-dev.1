Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EA5606A32C
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=E1PkmwEf
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64C5B427BC;
	Tue,  3 Nov 2026 16:10:09 +0100 (CET)
Received: from mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
 by mails.dpdk.org (Postfix) with ESMTPS id 7821042E49
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:10:08 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=jx7DJ8tZClQhV/oe+YjFEBzTJAtEDYkzgeqNgmR/o00=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718608; v=1; x=1794323408;
 b=E1PkmwEfD0yX7zuuohI2pI5C3yZFfHf3v/WlCiPP2bBp2+5WyuSQ5xraxdhv/TxNJyFt6d0T
 UOWH/VBCimJwN8aTCKy/IW6R8jDh2ezt+XbCS9PUCG8avnsuCA+JeSa0Dx+TFhOoMhbiATL9hTQ
 Tp9eZqFexnhmw7gixT/EF/T0=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 515636b9c83e03d6;
 Tue, 03 Nov 2026 15:10:07 +0000
X-Mizu-Trace-ID: 515636b9c83e03d6
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 103/227] net/af_xdp: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:01 +0800
Message-ID: <20261103145306.487255-104-chengwen.feng@linux.dev>
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
 drivers/net/af_xdp/rte_eth_af_xdp.c | 34 ++++++++++++++---------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 9c99dcec20..02ede3f648 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -996,7 +996,7 @@ eth_dev_configure(struct rte_eth_dev *dev)
 		if (list)
 			return 0;
 
-		list = rte_zmalloc_socket(name, sizeof(*list), 0,
+		list = rte_zmalloc_numa(name, sizeof(*list), 0,
 					dev->device->numa_node);
 		if (list == NULL)
 			return -1;
@@ -1246,7 +1246,7 @@ eth_dev_close(struct rte_eth_dev *dev)
 		goto out;
 
 	AF_XDP_LOG_LINE(INFO, "Closing AF_XDP ethdev on numa socket %u",
-		rte_socket_id());
+		rte_numa_id());
 
 	for (i = 0; i < internals->queue_cnt; i++) {
 		rxq = &internals->rx_queues[i];
@@ -1423,8 +1423,8 @@ xsk_umem_info *xdp_umem_configure(struct pmd_internals *internals,
 						rte_pktmbuf_priv_size(mb_pool) +
 						RTE_PKTMBUF_HEADROOM;
 
-		umem = rte_zmalloc_socket("umem", sizeof(*umem), 0,
-					  rte_socket_id());
+		umem = rte_zmalloc_numa("umem", sizeof(*umem), 0,
+					  rte_numa_id());
 		if (umem == NULL) {
 			AF_XDP_LOG_LINE(ERR, "Failed to allocate umem info");
 			return NULL;
@@ -1490,7 +1490,7 @@ xsk_umem_info *xdp_umem_configure(struct pmd_internals *internals,
 	int ret;
 	uint64_t i;
 
-	umem = rte_zmalloc_socket("umem", sizeof(*umem), 0, rte_socket_id());
+	umem = rte_zmalloc_numa("umem", sizeof(*umem), 0, rte_numa_id());
 	if (umem == NULL) {
 		AF_XDP_LOG_LINE(ERR, "Failed to allocate umem info");
 		return NULL;
@@ -1500,7 +1500,7 @@ xsk_umem_info *xdp_umem_configure(struct pmd_internals *internals,
 		       internals->if_name, rxq->xsk_queue_idx);
 	umem->buf_ring = rte_ring_create(ring_name,
 					 ETH_AF_XDP_NUM_BUFFERS,
-					 rte_socket_id(),
+					 rte_numa_id(),
 					 0x0);
 	if (umem->buf_ring == NULL) {
 		AF_XDP_LOG_LINE(ERR, "Failed to create rte_ring");
@@ -1515,7 +1515,7 @@ xsk_umem_info *xdp_umem_configure(struct pmd_internals *internals,
 		       internals->if_name, rxq->xsk_queue_idx);
 	mz = rte_memzone_reserve_aligned(mz_name,
 			ETH_AF_XDP_NUM_BUFFERS * ETH_AF_XDP_FRAME_SIZE,
-			rte_socket_id(), RTE_MEMZONE_IOVA_CONTIG,
+			rte_numa_id(), RTE_MEMZONE_IOVA_CONTIG,
 			getpagesize());
 	if (mz == NULL) {
 		AF_XDP_LOG_LINE(ERR, "Failed to reserve memzone for af_xdp umem.");
@@ -2062,7 +2062,7 @@ static int
 eth_rx_queue_setup(struct rte_eth_dev *dev,
 		   uint16_t rx_queue_id,
 		   uint16_t nb_rx_desc,
-		   unsigned int socket_id __rte_unused,
+		   unsigned int numa_id __rte_unused,
 		   const struct rte_eth_rxconf *rx_conf,
 		   struct rte_mempool *mb_pool)
 {
@@ -2127,7 +2127,7 @@ static int
 eth_tx_queue_setup(struct rte_eth_dev *dev,
 		   uint16_t tx_queue_id,
 		   uint16_t nb_tx_desc __rte_unused,
-		   unsigned int socket_id __rte_unused,
+		   unsigned int numa_id __rte_unused,
 		   const struct rte_eth_txconf *tx_conf __rte_unused)
 {
 	struct pmd_internals *internals = dev->data->dev_private;
@@ -2579,7 +2579,7 @@ init_internals(struct rte_vdev_device *dev, const char *if_name,
 	int ret;
 	int i;
 
-	internals = rte_zmalloc_socket(name, sizeof(*internals), 0, numa_node);
+	internals = rte_zmalloc_numa(name, sizeof(*internals), 0, numa_node);
 	if (internals == NULL)
 		return NULL;
 
@@ -2619,7 +2619,7 @@ init_internals(struct rte_vdev_device *dev, const char *if_name,
 		goto err_free_internals;
 	}
 
-	internals->rx_queues = rte_zmalloc_socket(NULL,
+	internals->rx_queues = rte_zmalloc_numa(NULL,
 					sizeof(struct pkt_rx_queue) * queue_cnt,
 					0, numa_node);
 	if (internals->rx_queues == NULL) {
@@ -2627,7 +2627,7 @@ init_internals(struct rte_vdev_device *dev, const char *if_name,
 		goto err_free_internals;
 	}
 
-	internals->tx_queues = rte_zmalloc_socket(NULL,
+	internals->tx_queues = rte_zmalloc_numa(NULL,
 					sizeof(struct pkt_tx_queue) * queue_cnt,
 					0, numa_node);
 	if (internals->tx_queues == NULL) {
@@ -2648,7 +2648,7 @@ init_internals(struct rte_vdev_device *dev, const char *if_name,
 		goto err_free_tx;
 
 	process_private = (struct pmd_process_private *)
-		rte_zmalloc_socket(name, sizeof(struct pmd_process_private),
+		rte_zmalloc_numa(name, sizeof(struct pmd_process_private),
 				   RTE_CACHE_LINE_SIZE, numa_node);
 	if (process_private == NULL) {
 		AF_XDP_LOG_LINE(ERR, "Failed to alloc memory for process private");
@@ -2859,7 +2859,7 @@ rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
 		eth_dev->rx_pkt_burst = rte_eth_pkt_burst_dummy;
 		eth_dev->tx_pkt_burst = rte_eth_pkt_burst_dummy;
 		eth_dev->process_private = (struct pmd_process_private *)
-			rte_zmalloc_socket(name,
+			rte_zmalloc_numa(name,
 					   sizeof(struct pmd_process_private),
 					   RTE_CACHE_LINE_SIZE,
 					   eth_dev->device->numa_node);
@@ -2994,14 +2994,14 @@ rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
 	}
 
 	/* get numa node id from net sysfs */
-	if (dev->device.numa_node == SOCKET_ID_ANY) {
+	if (dev->device.numa_node == RTE_NUMA_ID_ANY) {
 		unsigned long numa = 0;
 		char numa_path[PATH_MAX];
 
 		snprintf(numa_path, sizeof(numa_path), "/sys/class/net/%s/device/numa_node",
 			 if_name);
 		if (access(numa_path, R_OK) != 0 || eal_parse_sysfs_value(numa_path, &numa) != 0)
-			dev->device.numa_node = rte_socket_id();
+			dev->device.numa_node = rte_numa_id();
 		else
 			dev->device.numa_node = numa;
 	}
@@ -3041,7 +3041,7 @@ rte_pmd_af_xdp_remove(struct rte_vdev_device *dev)
 	struct rte_eth_dev *eth_dev = NULL;
 
 	AF_XDP_LOG_LINE(INFO, "Removing AF_XDP ethdev on numa socket %u",
-		rte_socket_id());
+		rte_numa_id());
 
 	if (dev == NULL)
 		return -1;
-- 
2.55.0

