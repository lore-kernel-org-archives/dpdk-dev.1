Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64466070A86
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ByekMLsi
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 656CF427B5;
	Tue,  3 Nov 2026 15:58:54 +0100 (CET)
Received: from mta1.migadu.com (out-7.mta1.migadu.com [95.215.58.7])
 by mails.dpdk.org (Postfix) with ESMTPS id C9B97427AC
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:58:52 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=tcA8WxpnC0aNzwGBNCxBvMe+dWNP+fvsemhmZzkn4rE=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717932; v=1; x=1794322732;
 b=ByekMLsiZ+fBnYaCHIipq3p7d/58Tmoi36I8/IoT2AWrkLKepTh9JuDl64z3DxBNumNuynDB
 jWVEJ1OqYDxVoRx+DxFQzoxLLli9j5tHoMAO9TPWyT3fg46IGfpBlcl5uscKM4L/onmsRH4RPn7
 wU1Yzb22qis5VCNfKGgq7C5Y=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id c350708b3a7ad9fd;
 Tue, 03 Nov 2026 14:58:52 +0000
X-Mizu-Trace-ID: c350708b3a7ad9fd
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 038/227] vhost: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:56 +0800
Message-ID: <20261103145306.487255-39-chengwen.feng@linux.dev>
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

Rename socket_id parameters, internal variables and comments to
the NUMA node terminology, and switch internal calls to
rte_zmalloc_numa(), rte_numa_id() and RTE_NUMA_ID_ANY.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/vhost/iotlb.c            |  2 +-
 lib/vhost/rte_vhost_crypto.h |  4 ++--
 lib/vhost/vhost.c            |  4 ++--
 lib/vhost/vhost_crypto.c     | 16 ++++++++--------
 lib/vhost/vhost_user.c       | 22 +++++++++++-----------
 5 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/lib/vhost/iotlb.c b/lib/vhost/iotlb.c
index 4c405388f2..32334c5df2 100644
--- a/lib/vhost/iotlb.c
+++ b/lib/vhost/iotlb.c
@@ -433,7 +433,7 @@ vhost_user_iotlb_init_one(struct virtio_net *dev, int asid)
 	TAILQ_INIT(&dev->iotlb[asid]->pending_list);
 
 	if (dev->flags & VIRTIO_DEV_SUPPORT_IOMMU) {
-		dev->iotlb[asid]->pool = rte_calloc_socket("iotlb_pool", IOTLB_CACHE_SIZE,
+		dev->iotlb[asid]->pool = rte_calloc_numa("iotlb_pool", IOTLB_CACHE_SIZE,
 			sizeof(struct vhost_iotlb_entry), 0, socket);
 		if (!dev->iotlb[asid]->pool) {
 			VHOST_CONFIG_LOG(dev->ifname, ERR, "Failed to create IOTLB cache pool");
diff --git a/lib/vhost/rte_vhost_crypto.h b/lib/vhost/rte_vhost_crypto.h
index adfd5cfab0..0d96f0dae5 100644
--- a/lib/vhost/rte_vhost_crypto.h
+++ b/lib/vhost/rte_vhost_crypto.h
@@ -51,7 +51,7 @@ rte_vhost_crypto_driver_start(const char *path);
  *  multiple Vhost-crypto devices.
  * @param sess_pool
  *  The pointer to the created cryptodev session pool.
- * @param socket_id
+ * @param numa_id
  *  NUMA Socket ID to allocate resources on. *
  * @return
  *  0 if the Vhost Crypto Instance is created successfully.
@@ -60,7 +60,7 @@ rte_vhost_crypto_driver_start(const char *path);
 int
 rte_vhost_crypto_create(int vid, uint8_t cryptodev_id,
 		struct rte_mempool *sess_pool,
-		int socket_id);
+		int numa_id);
 
 /**
  *  Free the Vhost-crypto instance
diff --git a/lib/vhost/vhost.c b/lib/vhost/vhost.c
index 454fc8174c..ecd5067203 100644
--- a/lib/vhost/vhost.c
+++ b/lib/vhost/vhost.c
@@ -635,7 +635,7 @@ static void
 init_vring_queue(struct virtio_net *dev __rte_unused, struct vhost_virtqueue *vq,
 	uint32_t vring_idx)
 {
-	int numa_node = SOCKET_ID_ANY;
+	int numa_node = RTE_NUMA_ID_ANY;
 
 	memset(vq, 0, sizeof(struct vhost_virtqueue));
 
@@ -648,7 +648,7 @@ init_vring_queue(struct virtio_net *dev __rte_unused, struct vhost_virtqueue *vq
 	if (get_mempolicy(&numa_node, NULL, 0, vq, MPOL_F_NODE | MPOL_F_ADDR)) {
 		VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to query numa node: %s",
 			rte_strerror(errno));
-		numa_node = SOCKET_ID_ANY;
+		numa_node = RTE_NUMA_ID_ANY;
 	}
 #endif
 	vq->numa_node = numa_node;
diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
index 6c851c173a..69ad4e74cc 100644
--- a/lib/vhost/vhost_crypto.c
+++ b/lib/vhost/vhost_crypto.c
@@ -217,7 +217,7 @@ struct __rte_cache_aligned vhost_crypto {
 	uint64_t last_session_id;
 
 	/** socket id for the device */
-	int socket_id;
+	int numa_id;
 
 	struct virtio_net *dev;
 
@@ -1806,7 +1806,7 @@ RTE_EXPORT_SYMBOL(rte_vhost_crypto_create)
 int
 rte_vhost_crypto_create(int vid, uint8_t cryptodev_id,
 		struct rte_mempool *sess_pool,
-		int socket_id)
+		int numa_id)
 {
 	struct virtio_net *dev = get_device(vid);
 	struct rte_hash_parameters params = {0};
@@ -1819,8 +1819,8 @@ rte_vhost_crypto_create(int vid, uint8_t cryptodev_id,
 		return -EINVAL;
 	}
 
-	vcrypto = rte_zmalloc_socket(NULL, sizeof(*vcrypto),
-			RTE_CACHE_LINE_SIZE, socket_id);
+	vcrypto = rte_zmalloc_numa(NULL, sizeof(*vcrypto),
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (!vcrypto) {
 		VC_LOG_ERR("Insufficient memory");
 		return -ENOMEM;
@@ -1837,7 +1837,7 @@ rte_vhost_crypto_create(int vid, uint8_t cryptodev_id,
 	params.entries = VHOST_CRYPTO_SESSION_MAP_ENTRIES;
 	params.hash_func = rte_jhash;
 	params.key_len = sizeof(uint64_t);
-	params.numa_id = socket_id;
+	params.numa_id = numa_id;
 	vcrypto->session_map = rte_hash_create(&params);
 	if (!vcrypto->session_map) {
 		VC_LOG_ERR("Failed to creath session map");
@@ -1850,7 +1850,7 @@ rte_vhost_crypto_create(int vid, uint8_t cryptodev_id,
 			VHOST_CRYPTO_MBUF_POOL_SIZE, 512,
 			sizeof(struct vhost_crypto_data_req),
 			VHOST_CRYPTO_MAX_DATA_SIZE + RTE_PKTMBUF_HEADROOM,
-			rte_socket_id());
+			rte_numa_id());
 	if (!vcrypto->mbuf_pool) {
 		VC_LOG_ERR("Failed to creath mbuf pool");
 		ret = -ENOMEM;
@@ -1862,7 +1862,7 @@ rte_vhost_crypto_create(int vid, uint8_t cryptodev_id,
 			VHOST_CRYPTO_MBUF_POOL_SIZE,
 			sizeof(struct vhost_crypto_writeback_data),
 			128, 0, NULL, NULL, init_wb_data, NULL,
-			rte_socket_id(), 0);
+			rte_numa_id(), 0);
 	if (!vcrypto->wb_pool) {
 		VC_LOG_ERR("Failed to creath mempool");
 		ret = -ENOMEM;
@@ -1955,7 +1955,7 @@ rte_vhost_crypto_set_zero_copy(int vid, enum rte_vhost_crypto_zero_copy option)
 				VHOST_CRYPTO_MBUF_POOL_SIZE,
 				sizeof(struct vhost_crypto_writeback_data),
 				128, 0, NULL, NULL, init_wb_data, NULL,
-				rte_socket_id(), 0);
+				rte_numa_id(), 0);
 		if (!vcrypto->wb_pool) {
 			VC_LOG_ERR("Failed to creath mbuf pool");
 			return -ENOMEM;
diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index f77af4f4f7..e6ec0207d5 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -1382,7 +1382,7 @@ static int
 vhost_user_initialize_memory(struct virtio_net **pdev)
 {
 	struct virtio_net *dev = *pdev;
-	int numa_node = SOCKET_ID_ANY;
+	int numa_node = RTE_NUMA_ID_ANY;
 
 	if (dev->mem != NULL) {
 		VHOST_CONFIG_LOG(dev->ifname, ERR,
@@ -1400,7 +1400,7 @@ vhost_user_initialize_memory(struct virtio_net **pdev)
 	dev->nr_guest_pages = 0;
 	if (dev->guest_pages == NULL) {
 		dev->max_guest_pages = 8;
-		dev->guest_pages = rte_zmalloc_socket(NULL,
+		dev->guest_pages = rte_zmalloc_numa(NULL,
 					dev->max_guest_pages *
 					sizeof(struct guest_page),
 					RTE_CACHE_LINE_SIZE,
@@ -1412,7 +1412,7 @@ vhost_user_initialize_memory(struct virtio_net **pdev)
 		}
 	}
 
-	dev->mem = rte_zmalloc_socket("vhost-mem-table", sizeof(struct rte_vhost_memory) +
+	dev->mem = rte_zmalloc_numa("vhost-mem-table", sizeof(struct rte_vhost_memory) +
 		sizeof(struct rte_vhost_mem_region) * VHOST_MEMORY_MAX_NREGIONS, 0, numa_node);
 	if (dev->mem == NULL) {
 		VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to allocate memory for dev->mem");
@@ -1919,7 +1919,7 @@ vhost_user_get_inflight_fd(struct virtio_net **pdev,
 	uint16_t num_queues, queue_size;
 	struct virtio_net *dev = *pdev;
 	int fd, i, j;
-	int numa_node = SOCKET_ID_ANY;
+	int numa_node = RTE_NUMA_ID_ANY;
 	void *addr;
 
 	if (ctx->msg.size != sizeof(ctx->msg.payload.inflight)) {
@@ -1937,7 +1937,7 @@ vhost_user_get_inflight_fd(struct virtio_net **pdev,
 		numa_node = dev->virtqueue[0]->numa_node;
 
 	if (dev->inflight_info == NULL) {
-		dev->inflight_info = rte_zmalloc_socket("inflight_info",
+		dev->inflight_info = rte_zmalloc_numa("inflight_info",
 				sizeof(struct inflight_mem_info), 0, numa_node);
 		if (!dev->inflight_info) {
 			VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to alloc dev inflight area");
@@ -2022,7 +2022,7 @@ vhost_user_set_inflight_fd(struct virtio_net **pdev,
 	struct vhost_virtqueue *vq;
 	void *addr;
 	int fd, i;
-	int numa_node = SOCKET_ID_ANY;
+	int numa_node = RTE_NUMA_ID_ANY;
 
 	if (validate_msg_fds(dev, ctx, 1) != 0)
 		return RTE_VHOST_MSG_RESULT_ERR;
@@ -2070,7 +2070,7 @@ vhost_user_set_inflight_fd(struct virtio_net **pdev,
 		numa_node = dev->virtqueue[0]->numa_node;
 
 	if (!dev->inflight_info) {
-		dev->inflight_info = rte_zmalloc_socket("inflight_info",
+		dev->inflight_info = rte_zmalloc_numa("inflight_info",
 				sizeof(struct inflight_mem_info), 0, numa_node);
 		if (dev->inflight_info == NULL) {
 			VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to alloc dev inflight area");
@@ -2235,7 +2235,7 @@ vhost_check_queue_inflights_split(struct virtio_net *dev,
 	vhost_virtqueue_reconnect_log_split(vq);
 
 	if (resubmit_num) {
-		resubmit = rte_zmalloc_socket("resubmit", sizeof(struct rte_vhost_resubmit_info),
+		resubmit = rte_zmalloc_numa("resubmit", sizeof(struct rte_vhost_resubmit_info),
 				0, vq->numa_node);
 		if (!resubmit) {
 			VHOST_CONFIG_LOG(dev->ifname, ERR,
@@ -2243,7 +2243,7 @@ vhost_check_queue_inflights_split(struct virtio_net *dev,
 			return RTE_VHOST_MSG_RESULT_ERR;
 		}
 
-		resubmit->resubmit_list = rte_zmalloc_socket("resubmit_list",
+		resubmit->resubmit_list = rte_zmalloc_numa("resubmit_list",
 				resubmit_num * sizeof(struct rte_vhost_resubmit_desc),
 				0, vq->numa_node);
 		if (!resubmit->resubmit_list) {
@@ -2331,7 +2331,7 @@ vhost_check_queue_inflights_packed(struct virtio_net *dev,
 	}
 
 	if (resubmit_num) {
-		resubmit = rte_zmalloc_socket("resubmit", sizeof(struct rte_vhost_resubmit_info),
+		resubmit = rte_zmalloc_numa("resubmit", sizeof(struct rte_vhost_resubmit_info),
 				0, vq->numa_node);
 		if (resubmit == NULL) {
 			VHOST_CONFIG_LOG(dev->ifname, ERR,
@@ -2339,7 +2339,7 @@ vhost_check_queue_inflights_packed(struct virtio_net *dev,
 			return RTE_VHOST_MSG_RESULT_ERR;
 		}
 
-		resubmit->resubmit_list = rte_zmalloc_socket("resubmit_list",
+		resubmit->resubmit_list = rte_zmalloc_numa("resubmit_list",
 				resubmit_num * sizeof(struct rte_vhost_resubmit_desc),
 				0, vq->numa_node);
 		if (resubmit->resubmit_list == NULL) {
-- 
2.55.0

