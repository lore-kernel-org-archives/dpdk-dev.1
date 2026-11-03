Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E286A606D82C
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uXXdrQYw
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E444E42E8C;
	Tue,  3 Nov 2026 16:13:49 +0100 (CET)
Received: from mta1.migadu.com (out-50.mta1.migadu.com [95.215.58.50])
 by mails.dpdk.org (Postfix) with ESMTPS id 276FE42EB4
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:13:49 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=sS35dINJJoNsyPqs8f9N35diQrWQxIQwy1WY0NvLA/M=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718828; v=1; x=1794323628;
 b=uXXdrQYwbnTR0zRIVrqTasiF0Ynndt5bBm8hTAmMPqNTSxx/wCIWXFyzkt6vEtmFjSrbz6VH
 YzhFcXJgLjVY0MdI7LgXq+aA78teaJ0mWT7tUNu2VxsBCIfzHuybWXrpQjNGorIYpdI/tP7o2OQ
 ywRUDH67oN3FztF+JY+HZ0zU=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 9b1378192fcd093a;
 Tue, 03 Nov 2026 15:13:48 +0000
X-Mizu-Trace-ID: 9b1378192fcd093a
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 131/227] net/nbl: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:29 +0800
Message-ID: <20261103145306.487255-132-chengwen.feng@linux.dev>
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
 drivers/net/nbl/nbl_common/nbl_common.c   |  2 +-
 drivers/net/nbl/nbl_dev/nbl_dev.c         |  8 ++++----
 drivers/net/nbl/nbl_dev/nbl_dev.h         |  4 ++--
 drivers/net/nbl/nbl_hw/nbl_txrx.c         | 14 +++++++-------
 drivers/net/nbl/nbl_include/nbl_include.h |  4 ++--
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/nbl/nbl_common/nbl_common.c b/drivers/net/nbl/nbl_common/nbl_common.c
index bded42c358..0d63a04b74 100644
--- a/drivers/net/nbl/nbl_common/nbl_common.c
+++ b/drivers/net/nbl/nbl_common/nbl_common.c
@@ -21,7 +21,7 @@ void *nbl_alloc_dma_mem(struct nbl_dma_mem *mem, uint32_t size)
 		return NULL;
 
 	snprintf(z_name, sizeof(z_name), "nbl_dma_%u", nbl_dma_memzone_id++);
-	mz = rte_memzone_reserve_bounded(z_name, size, SOCKET_ID_ANY, 0,
+	mz = rte_memzone_reserve_bounded(z_name, size, RTE_NUMA_ID_ANY, 0,
 					 0, RTE_PGSIZE_2M);
 	if (!mz)
 		return NULL;
diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index d28eea082f..81d90a14e7 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -355,7 +355,7 @@ int nbl_dev_port_close(struct rte_eth_dev *eth_dev)
 }
 
 int nbl_tx_queue_setup(struct rte_eth_dev *eth_dev, u16 queue_idx,
-		       u16 nb_desc, unsigned int socket_id, const struct rte_eth_txconf *conf)
+		       u16 nb_desc, unsigned int numa_id, const struct rte_eth_txconf *conf)
 {
 	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
 	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
@@ -367,7 +367,7 @@ int nbl_tx_queue_setup(struct rte_eth_dev *eth_dev, u16 queue_idx,
 
 	param.queue_idx = queue_idx;
 	param.nb_desc = nb_desc;
-	param.socket_id = socket_id;
+	param.numa_id = numa_id;
 	param.conf = conf;
 	param.product = adapter->caps.product_type;
 	param.bond_broadcast_check = NULL;
@@ -383,7 +383,7 @@ int nbl_tx_queue_setup(struct rte_eth_dev *eth_dev, u16 queue_idx,
 }
 
 int nbl_rx_queue_setup(struct rte_eth_dev *eth_dev, u16 queue_idx,
-		       u16 nb_desc, unsigned int socket_id,
+		       u16 nb_desc, unsigned int numa_id,
 		       const struct rte_eth_rxconf *conf, struct rte_mempool *mempool)
 {
 	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
@@ -396,7 +396,7 @@ int nbl_rx_queue_setup(struct rte_eth_dev *eth_dev, u16 queue_idx,
 
 	param.queue_idx = queue_idx;
 	param.nb_desc = nb_desc;
-	param.socket_id = socket_id;
+	param.numa_id = numa_id;
 	param.conf = conf;
 	param.mempool = mempool;
 	param.product = adapter->caps.product_type;
diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.h b/drivers/net/nbl/nbl_dev/nbl_dev.h
index bfe2b06deb..bdf2129b04 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.h
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.h
@@ -78,9 +78,9 @@ int nbl_dev_port_start(struct rte_eth_dev *eth_dev);
 int nbl_dev_port_stop(struct rte_eth_dev *eth_dev);
 int nbl_dev_port_close(struct rte_eth_dev *eth_dev);
 int nbl_tx_queue_setup(struct rte_eth_dev *eth_dev, u16 queue_idx,
-		       u16 nb_desc, unsigned int socket_id, const struct rte_eth_txconf *conf);
+		       u16 nb_desc, unsigned int numa_id, const struct rte_eth_txconf *conf);
 int nbl_rx_queue_setup(struct rte_eth_dev *eth_dev, u16 queue_idx,
-		       u16 nb_desc, unsigned int socket_id,
+		       u16 nb_desc, unsigned int numa_id,
 		       const struct rte_eth_rxconf *conf, struct rte_mempool *mempool);
 void nbl_tx_queues_release(struct rte_eth_dev *eth_dev, uint16_t queue_id);
 void nbl_rx_queues_release(struct rte_eth_dev *eth_dev, uint16_t queue_id);
diff --git a/drivers/net/nbl/nbl_hw/nbl_txrx.c b/drivers/net/nbl/nbl_hw/nbl_txrx.c
index 7beae85177..9587045832 100644
--- a/drivers/net/nbl/nbl_hw/nbl_txrx.c
+++ b/drivers/net/nbl/nbl_hw/nbl_txrx.c
@@ -165,7 +165,7 @@ static int nbl_res_txrx_start_tx_ring(void *priv,
 	size = RTE_ALIGN_CEIL(sizeof(tx_ring->desc[0]) * param->nb_desc, 4096);
 	memzone = rte_eth_dma_zone_reserve(eth_dev, "tx_ring", param->queue_idx,
 					   size, RTE_CACHE_LINE_SIZE,
-					   param->socket_id);
+					   param->numa_id);
 	if (memzone == NULL) {
 		NBL_LOG(ERR, "reserve dma zone for tx ring failed");
 		goto alloc_dma_zone_failed;
@@ -176,7 +176,7 @@ static int nbl_res_txrx_start_tx_ring(void *priv,
 	snprintf(vq_hdr_name, sizeof(vq_hdr_name), "port%d_vq%d_hdr",
 			eth_dev->data->port_id, param->queue_idx);
 	net_hdr_mz = rte_memzone_reserve_aligned(vq_hdr_name, size,
-						 param->socket_id,
+						 param->numa_id,
 						 RTE_MEMZONE_IOVA_CONTIG,
 						 RTE_CACHE_LINE_SIZE);
 	if (net_hdr_mz == NULL) {
@@ -312,17 +312,17 @@ static int nbl_res_txrx_start_rx_ring(void *priv,
 		eth_dev->data->rx_queues[param->queue_idx] = NULL;
 	}
 
-	rx_ring = rte_zmalloc_socket("nbl_rxring", sizeof(*rx_ring),
-				 RTE_CACHE_LINE_SIZE, param->socket_id);
+	rx_ring = rte_zmalloc_numa("nbl_rxring", sizeof(*rx_ring),
+				 RTE_CACHE_LINE_SIZE, param->numa_id);
 	if (rx_ring == NULL) {
 		NBL_LOG(ERR, "allocate rx queue data structure failed");
 		return -ENOMEM;
 	}
 
 	size = sizeof(rx_ring->rx_entry[0]) * (param->nb_desc + NBL_DESC_PER_LOOP_VEC_MAX);
-	rx_ring->rx_entry = rte_zmalloc_socket("rxq rx_entry", size,
+	rx_ring->rx_entry = rte_zmalloc_numa("rxq rx_entry", size,
 					       RTE_CACHE_LINE_SIZE,
-					       param->socket_id);
+					       param->numa_id);
 	if (rx_ring->rx_entry == NULL) {
 		NBL_LOG(ERR, "allocate rx queue %d software ring failed", param->queue_idx);
 		goto alloc_rx_entry_failed;
@@ -331,7 +331,7 @@ static int nbl_res_txrx_start_rx_ring(void *priv,
 	size = sizeof(rx_ring->desc[0]) * (param->nb_desc + NBL_DESC_PER_LOOP_VEC_MAX);
 	memzone = rte_eth_dma_zone_reserve(eth_dev, "rx_ring", param->queue_idx,
 					   size, RTE_CACHE_LINE_SIZE,
-					   param->socket_id);
+					   param->numa_id);
 	if (memzone == NULL) {
 		NBL_LOG(ERR, "reserve dma zone for rx ring failed");
 		goto alloc_dma_zone_failed;
diff --git a/drivers/net/nbl/nbl_include/nbl_include.h b/drivers/net/nbl/nbl_include/nbl_include.h
index ba99b9f8e7..07549cf2f9 100644
--- a/drivers/net/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/nbl/nbl_include/nbl_include.h
@@ -82,7 +82,7 @@ struct nbl_func_caps {
 struct nbl_start_rx_ring_param {
 	u16 queue_idx;
 	u16 nb_desc;
-	u32 socket_id;
+	u32 numa_id;
 	enum nbl_product_type product;
 	const struct rte_eth_rxconf *conf;
 	struct rte_mempool *mempool;
@@ -91,7 +91,7 @@ struct nbl_start_rx_ring_param {
 struct nbl_start_tx_ring_param {
 	u16 queue_idx;
 	u16 nb_desc;
-	u32 socket_id;
+	u32 numa_id;
 	enum nbl_product_type product;
 	const struct rte_eth_txconf *conf;
 	bool (*bond_broadcast_check)(struct rte_mbuf *mbuf);
-- 
2.55.0

