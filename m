Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5017606A326
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q4FFBsQn
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00F5242EC5;
	Tue,  3 Nov 2026 16:17:02 +0100 (CET)
Received: from mta0.migadu.com (out-141.mta0.migadu.com [91.218.175.141])
 by mails.dpdk.org (Postfix) with ESMTPS id 2553F42F00
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:17:01 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=sjSVANouL8M8LwdlHtHubQujKYDTt0PBsxmQOz0q+38=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719020; v=1; x=1794323820;
 b=q4FFBsQnSGiOZf+zrqY1dMkMwOwZorMJDT7GoLGfQkWOJwX2JGYREFkzvkwf9h2EEfFFPSjS
 ADp4JgtKmCUqRIW6CWaTssM3HjM8yIb5vmfVHgqmlj7tVTRyc5UMpOCsBGZSQLZumZo+vhrKhWU
 y92DSciM8y6LLPddy4krwwlc=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id a6bdcb5ec94d730a;
 Tue, 03 Nov 2026 15:17:00 +0000
X-Mizu-Trace-ID: a6bdcb5ec94d730a
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 153/227] net/virtio: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:51 +0800
Message-ID: <20261103145306.487255-154-chengwen.feng@linux.dev>
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
 drivers/net/virtio/virtio_ethdev.c               | 4 ++--
 drivers/net/virtio/virtio_ethdev.h               | 4 ++--
 drivers/net/virtio/virtio_rxtx.c                 | 6 +++---
 drivers/net/virtio/virtio_user/virtio_user_dev.c | 2 +-
 drivers/net/virtio/virtqueue.c                   | 6 +++---
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/virtio/virtio_ethdev.c b/drivers/net/virtio/virtio_ethdev.c
index e6ad2de4ba..ad209107f8 100644
--- a/drivers/net/virtio/virtio_ethdev.c
+++ b/drivers/net/virtio/virtio_ethdev.c
@@ -1811,7 +1811,7 @@ virtio_dev_rss_init(struct rte_eth_dev *eth_dev)
 
 	if (!hw->rss_key) {
 		/* Setup default RSS key if not already setup by the user */
-		hw->rss_key = rte_malloc_socket("rss_key",
+		hw->rss_key = rte_malloc_numa("rss_key",
 				VIRTIO_NET_RSS_KEY_SIZE, 0,
 				eth_dev->device->numa_node);
 		if (!hw->rss_key) {
@@ -1833,7 +1833,7 @@ virtio_dev_rss_init(struct rte_eth_dev *eth_dev)
 
 	if (!hw->rss_reta) {
 		/* Setup default RSS reta if not already setup by the user */
-		hw->rss_reta = rte_zmalloc_socket("rss_reta",
+		hw->rss_reta = rte_zmalloc_numa("rss_reta",
 				VIRTIO_NET_RSS_RETA_SIZE * sizeof(uint16_t), 0,
 				eth_dev->device->numa_node);
 		if (!hw->rss_reta) {
diff --git a/drivers/net/virtio/virtio_ethdev.h b/drivers/net/virtio/virtio_ethdev.h
index 7aa771fd2b..765f9c8979 100644
--- a/drivers/net/virtio/virtio_ethdev.h
+++ b/drivers/net/virtio/virtio_ethdev.h
@@ -61,7 +61,7 @@ void virtio_dev_cq_start(struct rte_eth_dev *dev);
  */
 
 int  virtio_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
-		uint16_t nb_rx_desc, unsigned int socket_id,
+		uint16_t nb_rx_desc, unsigned int numa_id,
 		const struct rte_eth_rxconf *rx_conf,
 		struct rte_mempool *mb_pool);
 
@@ -69,7 +69,7 @@ int virtio_dev_rx_queue_setup_finish(struct rte_eth_dev *dev,
 				uint16_t rx_queue_id);
 
 int  virtio_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
-		uint16_t nb_tx_desc, unsigned int socket_id,
+		uint16_t nb_tx_desc, unsigned int numa_id,
 		const struct rte_eth_txconf *tx_conf);
 
 int virtio_dev_tx_queue_setup_finish(struct rte_eth_dev *dev,
diff --git a/drivers/net/virtio/virtio_rxtx.c b/drivers/net/virtio/virtio_rxtx.c
index 1afb68bc69..72116b218b 100644
--- a/drivers/net/virtio/virtio_rxtx.c
+++ b/drivers/net/virtio/virtio_rxtx.c
@@ -653,7 +653,7 @@ int
 virtio_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			uint16_t queue_idx,
 			uint16_t nb_desc,
-			unsigned int socket_id __rte_unused,
+			unsigned int numa_id __rte_unused,
 			const struct rte_eth_rxconf *rx_conf,
 			struct rte_mempool *mp)
 {
@@ -808,7 +808,7 @@ virtio_dev_rx_queue_setup_finish(struct rte_eth_dev *dev, uint16_t queue_idx)
 /*
  * struct rte_eth_dev *dev: Used to update dev
  * uint16_t nb_desc: Defaults to values read from config space
- * unsigned int socket_id: Used to allocate memzone
+ * unsigned int numa_id: Used to allocate memzone
  * const struct rte_eth_txconf *tx_conf: Used to setup tx engine
  * uint16_t queue_idx: Just used as an index in dev txq list
  */
@@ -816,7 +816,7 @@ int
 virtio_dev_tx_queue_setup(struct rte_eth_dev *dev,
 			uint16_t queue_idx,
 			uint16_t nb_desc,
-			unsigned int socket_id __rte_unused,
+			unsigned int numa_id __rte_unused,
 			const struct rte_eth_txconf *tx_conf)
 {
 	uint16_t vq_idx = 2 * queue_idx + VTNET_SQ_TQ_QUEUE_IDX;
diff --git a/drivers/net/virtio/virtio_user/virtio_user_dev.c b/drivers/net/virtio/virtio_user/virtio_user_dev.c
index c38ac059df..b7e1b617c5 100644
--- a/drivers/net/virtio/virtio_user/virtio_user_dev.c
+++ b/drivers/net/virtio/virtio_user/virtio_user_dev.c
@@ -1201,7 +1201,7 @@ virtio_user_dev_create_shadow_cvq(struct virtio_user_dev *dev, struct virtqueue
 
 	snprintf(name, sizeof(name), "port%d_shadow_cvq", vq->hw->port_id);
 	scvq = virtqueue_alloc(&dev->hw, vq->vq_queue_index, vq->vq_nentries,
-			VTNET_CQ, SOCKET_ID_ANY, name);
+			VTNET_CQ, RTE_NUMA_ID_ANY, name);
 	if (!scvq) {
 		PMD_INIT_LOG(ERR, "(%s) Failed to alloc shadow control vq", dev->path);
 		return -ENOMEM;
diff --git a/drivers/net/virtio/virtqueue.c b/drivers/net/virtio/virtqueue.c
index cf46abfd06..b4d4c49f42 100644
--- a/drivers/net/virtio/virtqueue.c
+++ b/drivers/net/virtio/virtqueue.c
@@ -390,13 +390,13 @@ virtio_rxq_sw_ring_alloc(struct virtqueue *vq, int numa_node)
 
 	size = (RTE_PMD_VIRTIO_RX_MAX_BURST + vq->vq_nentries) * sizeof(vq->rxq.sw_ring[0]);
 
-	sw_ring = rte_zmalloc_socket("sw_ring", size, RTE_CACHE_LINE_SIZE, numa_node);
+	sw_ring = rte_zmalloc_numa("sw_ring", size, RTE_CACHE_LINE_SIZE, numa_node);
 	if (!sw_ring) {
 		PMD_INIT_LOG(ERR, "can not allocate RX soft ring");
 		return -ENOMEM;
 	}
 
-	mbuf = rte_zmalloc_socket("sw_ring", sizeof(*mbuf), RTE_CACHE_LINE_SIZE, numa_node);
+	mbuf = rte_zmalloc_numa("sw_ring", sizeof(*mbuf), RTE_CACHE_LINE_SIZE, numa_node);
 	if (!mbuf) {
 		PMD_INIT_LOG(ERR, "can not allocate fake mbuf");
 		rte_free(sw_ring);
@@ -429,7 +429,7 @@ virtqueue_alloc(struct virtio_hw *hw, uint16_t index, uint16_t num, int type,
 	size = sizeof(*vq) + num * sizeof(struct vq_desc_extra);
 	size = RTE_ALIGN_CEIL(size, RTE_CACHE_LINE_SIZE);
 
-	vq = rte_zmalloc_socket(name, size, RTE_CACHE_LINE_SIZE, node);
+	vq = rte_zmalloc_numa(name, size, RTE_CACHE_LINE_SIZE, node);
 	if (vq == NULL) {
 		PMD_INIT_LOG(ERR, "can not allocate vq");
 		return NULL;
-- 
2.55.0

