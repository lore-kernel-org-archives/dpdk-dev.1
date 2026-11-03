Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9207C606A331
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mbtBb6I0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9F37410FC;
	Tue,  3 Nov 2026 15:54:06 +0100 (CET)
Received: from mta1.migadu.com (out-131.mta1.migadu.com [95.215.58.131])
 by mails.dpdk.org (Postfix) with ESMTPS id 62AD6410FC
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:54:05 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=y77FpYKh+1gltTylgoM1qOZrMcIx8APpYClAfQRDat8=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717645; v=1; x=1794322445;
 b=mbtBb6I0jiFwVLes4C45tHjEIr9Irl4XOc25okRxwQOqRGuksjxIvTf1UB6kKx0bmUFa5jUp
 7fnLJPNcWN2IoXIfD8k44g2vuiWhxeCMrrxAMWa3111xcrTGYa+G8BaQ4kUyNGCwM/Rp+BIAJzK
 b3f0asZk5YJz+5IHIc42vUSw=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 38305c6b1a354953;
 Tue, 03 Nov 2026 14:54:05 +0000
X-Mizu-Trace-ID: 38305c6b1a354953
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 006/227] ethdev: rename device socket API to NUMA node API
Date: Tue,  3 Nov 2026 22:49:24 +0800
Message-ID: <20261103145306.487255-7-chengwen.feng@linux.dev>
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
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename the exported function rte_eth_dev_socket_id() to
rte_eth_dev_numa_id(), keeping the old name as a functional
alias to be deprecated once the in-tree migration completes.

Rename socket_id parameters, trace point name and comments to
the NUMA node terminology, and switch internal calls to
rte_zmalloc_numa() and RTE_NUMA_ID_ANY.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/ethdev/ethdev_driver.c        | 10 ++++----
 lib/ethdev/ethdev_driver.h        | 10 ++++----
 lib/ethdev/ethdev_pci.h           |  8 +++----
 lib/ethdev/ethdev_private.c       |  2 +-
 lib/ethdev/ethdev_trace.h         |  6 ++---
 lib/ethdev/ethdev_trace_points.c  |  4 ++--
 lib/ethdev/ethdev_vdev.h          |  2 +-
 lib/ethdev/rte_ethdev.c           | 31 +++++++++++++++----------
 lib/ethdev/rte_ethdev.h           | 38 ++++++++++++++++++++++---------
 lib/ethdev/rte_ethdev_telemetry.c |  2 +-
 10 files changed, 68 insertions(+), 45 deletions(-)

diff --git a/lib/ethdev/ethdev_driver.c b/lib/ethdev/ethdev_driver.c
index e6f8d6fe85..92310c94be 100644
--- a/lib/ethdev/ethdev_driver.c
+++ b/lib/ethdev/ethdev_driver.c
@@ -327,11 +327,11 @@ rte_eth_dev_create(struct rte_device *device, const char *name,
 
 		if (priv_data_size) {
 			/* try alloc private data on device-local node. */
-			ethdev->data->dev_private = rte_zmalloc_socket(
+			ethdev->data->dev_private = rte_zmalloc_numa(
 				name, priv_data_size, RTE_CACHE_LINE_SIZE,
 				device->numa_node);
 
-			/* fall back to alloc on any socket on failure */
+			/* fall back to alloc on any NUMA node on failure */
 			if (ethdev->data->dev_private == NULL) {
 				ethdev->data->dev_private = rte_zmalloc(name,
 						priv_data_size, RTE_CACHE_LINE_SIZE);
@@ -741,7 +741,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dma_zone_reserve)
 const struct rte_memzone *
 rte_eth_dma_zone_reserve(const struct rte_eth_dev *dev, const char *ring_name,
 			 uint16_t queue_id, size_t size, unsigned int align,
-			 int socket_id)
+			 int numa_id)
 {
 	char z_name[RTE_MEMZONE_NAMESIZE];
 	const struct rte_memzone *mz;
@@ -757,7 +757,7 @@ rte_eth_dma_zone_reserve(const struct rte_eth_dev *dev, const char *ring_name,
 
 	mz = rte_memzone_lookup(z_name);
 	if (mz) {
-		if ((socket_id != SOCKET_ID_ANY && socket_id != mz->socket_id) ||
+		if ((numa_id != RTE_NUMA_ID_ANY && numa_id != mz->socket_id) ||
 				size > mz->len ||
 				((uintptr_t)mz->addr & (align - 1)) != 0) {
 			RTE_ETHDEV_LOG_LINE(ERR,
@@ -769,7 +769,7 @@ rte_eth_dma_zone_reserve(const struct rte_eth_dev *dev, const char *ring_name,
 		return mz;
 	}
 
-	return rte_memzone_reserve_aligned(z_name, size, socket_id,
+	return rte_memzone_reserve_aligned(z_name, size, numa_id,
 			RTE_MEMZONE_IOVA_CONTIG, align);
 }
 
diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index ac6f850a7e..28f0e8b2b4 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -616,7 +616,7 @@ typedef int (*eth_queue_stop_t)(struct rte_eth_dev *dev,
 typedef int (*eth_rx_queue_setup_t)(struct rte_eth_dev *dev,
 				    uint16_t rx_queue_id,
 				    uint16_t nb_rx_desc,
-				    unsigned int socket_id,
+				    unsigned int numa_id,
 				    const struct rte_eth_rxconf *rx_conf,
 				    struct rte_mempool *mb_pool);
 
@@ -624,7 +624,7 @@ typedef int (*eth_rx_queue_setup_t)(struct rte_eth_dev *dev,
 typedef int (*eth_tx_queue_setup_t)(struct rte_eth_dev *dev,
 				    uint16_t tx_queue_id,
 				    uint16_t nb_tx_desc,
-				    unsigned int socket_id,
+				    unsigned int numa_id,
 				    const struct rte_eth_txconf *tx_conf);
 
 /** @internal Enable interrupt of a receive queue of an Ethernet device. */
@@ -1813,14 +1813,14 @@ void rte_eth_dev_probing_finish(struct rte_eth_dev *dev);
  *   The sizeof of the memory area
  * @param align
  *   Alignment for resulting memzone. Must be a power of 2.
- * @param socket_id
- *   The *socket_id* argument is the socket identifier in case of NUMA.
+ * @param numa_id
+ *   The *numa_id* argument is the NUMA node ID in case of NUMA.
  */
 __rte_internal
 const struct rte_memzone *
 rte_eth_dma_zone_reserve(const struct rte_eth_dev *eth_dev, const char *name,
 			 uint16_t queue_id, size_t size,
-			 unsigned align, int socket_id);
+			 unsigned int align, int numa_id);
 
 /**
  * Free previously allocated memzone for HW rings.
diff --git a/lib/ethdev/ethdev_pci.h b/lib/ethdev/ethdev_pci.h
index ce3e293818..36482e606c 100644
--- a/lib/ethdev/ethdev_pci.h
+++ b/lib/ethdev/ethdev_pci.h
@@ -96,13 +96,13 @@ rte_eth_dev_pci_allocate(struct rte_pci_device *dev, size_t private_data_size)
 			return NULL;
 
 		if (private_data_size) {
-			/* Try and alloc the private-data structure on socket local to the device */
-			eth_dev->data->dev_private = rte_zmalloc_socket(name,
+			/* Try and alloc private-data on the device NUMA node */
+			eth_dev->data->dev_private = rte_zmalloc_numa(name,
 				private_data_size, RTE_CACHE_LINE_SIZE,
 				dev->device.numa_node);
 
-			/* if cannot allocate memory on the socket local to the device
-			 * use rte_malloc to allocate memory on some other socket, if available.
+			/* if cannot allocate memory on the NUMA node local to the device
+			 * use rte_malloc to allocate memory on some other NUMA node, if available.
 			 */
 			if (eth_dev->data->dev_private == NULL) {
 				eth_dev->data->dev_private = rte_zmalloc(name,
diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
index 70cc6ae63c..0a642bf242 100644
--- a/lib/ethdev/ethdev_private.c
+++ b/lib/ethdev/ethdev_private.c
@@ -359,7 +359,7 @@ eth_dev_shared_data_prepare(void)
 		/* Allocate port data and ownership shared memory. */
 		mz = rte_memzone_reserve(MZ_RTE_ETH_DEV_DATA,
 				sizeof(*eth_dev_shared_data),
-				SOCKET_ID_ANY, flags);
+				RTE_NUMA_ID_ANY, flags);
 		if (mz == NULL) {
 			RTE_ETHDEV_LOG_LINE(ERR, "Cannot allocate ethdev shared data");
 			goto out;
diff --git a/lib/ethdev/ethdev_trace.h b/lib/ethdev/ethdev_trace.h
index ebf5279a84..633cfb2efe 100644
--- a/lib/ethdev/ethdev_trace.h
+++ b/lib/ethdev/ethdev_trace.h
@@ -143,10 +143,10 @@ RTE_TRACE_POINT(
 )
 
 RTE_TRACE_POINT(
-	rte_ethdev_trace_socket_id,
-	RTE_TRACE_POINT_ARGS(uint16_t port_id, int socket_id),
+	rte_ethdev_trace_numa_id,
+	RTE_TRACE_POINT_ARGS(uint16_t port_id, int numa_id),
 	rte_trace_point_emit_u16(port_id);
-	rte_trace_point_emit_int(socket_id);
+	rte_trace_point_emit_int(numa_id);
 )
 
 RTE_TRACE_POINT(
diff --git a/lib/ethdev/ethdev_trace_points.c b/lib/ethdev/ethdev_trace_points.c
index b0644ea489..5cdbb1b27a 100644
--- a/lib/ethdev/ethdev_trace_points.c
+++ b/lib/ethdev/ethdev_trace_points.c
@@ -92,8 +92,8 @@ RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_owner_delete,
 RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_owner_get,
 	lib.ethdev.owner_get)
 
-RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_socket_id,
-	lib.ethdev.socket_id)
+RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_numa_id,
+	lib.ethdev.numa_id)
 
 RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_get_sec_ctx,
 	lib.ethdev.get_sec_ctx)
diff --git a/lib/ethdev/ethdev_vdev.h b/lib/ethdev/ethdev_vdev.h
index 010ec75a00..9c039778d4 100644
--- a/lib/ethdev/ethdev_vdev.h
+++ b/lib/ethdev/ethdev_vdev.h
@@ -40,7 +40,7 @@ rte_eth_vdev_allocate(struct rte_vdev_device *dev, size_t private_data_size)
 		return NULL;
 
 	if (private_data_size) {
-		eth_dev->data->dev_private = rte_zmalloc_socket(name,
+		eth_dev->data->dev_private = rte_zmalloc_numa(name,
 			private_data_size, RTE_CACHE_LINE_SIZE,
 			dev->device.numa_node);
 		if (!eth_dev->data->dev_private) {
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 8f91a353d9..23fcf2d2e8 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -642,30 +642,37 @@ rte_eth_dev_owner_get(const uint16_t port_id, struct rte_eth_dev_owner *owner)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_socket_id)
+RTE_EXPORT_SYMBOL(rte_eth_dev_numa_id)
 int
-rte_eth_dev_socket_id(uint16_t port_id)
+rte_eth_dev_numa_id(uint16_t port_id)
 {
-	int socket_id = SOCKET_ID_ANY;
+	int numa_id = RTE_NUMA_ID_ANY;
 	struct rte_eth_dev *ethdev;
 
 	if (port_id >= RTE_MAX_ETHPORTS) {
 		rte_errno = EINVAL;
-		return socket_id;
+		return numa_id;
 	}
 
 	ethdev = &rte_eth_devices[port_id];
 	if (!eth_dev_is_allocated(ethdev)) {
 		rte_errno = EINVAL;
 	} else {
-		socket_id = rte_eth_devices[port_id].data->numa_node;
-		if (socket_id == SOCKET_ID_ANY)
+		numa_id = rte_eth_devices[port_id].data->numa_node;
+		if (numa_id == RTE_NUMA_ID_ANY)
 			rte_errno = 0;
 	}
 
-	rte_ethdev_trace_socket_id(port_id, socket_id);
+	rte_ethdev_trace_numa_id(port_id, numa_id);
+
+	return numa_id;
+}
 
-	return socket_id;
+RTE_EXPORT_SYMBOL(rte_eth_dev_socket_id)
+int
+rte_eth_dev_socket_id(uint16_t port_id)
+{
+	return rte_eth_dev_numa_id(port_id);
 }
 
 RTE_EXPORT_SYMBOL(rte_eth_dev_get_sec_ctx)
@@ -2344,7 +2351,7 @@ rte_eth_rx_queue_check_mempools(struct rte_mempool **rx_mempools,
 RTE_EXPORT_SYMBOL(rte_eth_rx_queue_setup)
 int
 rte_eth_rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
-		       uint16_t nb_rx_desc, unsigned int socket_id,
+		       uint16_t nb_rx_desc, unsigned int numa_id,
 		       const struct rte_eth_rxconf *rx_conf,
 		       struct rte_mempool *mp)
 {
@@ -2554,7 +2561,7 @@ rte_eth_rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 	}
 
 	ret = dev->dev_ops->rx_queue_setup(dev, rx_queue_id, nb_rx_desc,
-					   socket_id, &local_conf, mp);
+					   numa_id, &local_conf, mp);
 	if (!ret) {
 		if (!dev->data->min_rx_buf_size ||
 		    dev->data->min_rx_buf_size > mbp_buf_size)
@@ -2675,7 +2682,7 @@ rte_eth_rx_hairpin_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 RTE_EXPORT_SYMBOL(rte_eth_tx_queue_setup)
 int
 rte_eth_tx_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
-		       uint16_t nb_tx_desc, unsigned int socket_id,
+		       uint16_t nb_tx_desc, unsigned int numa_id,
 		       const struct rte_eth_txconf *tx_conf)
 {
 	struct rte_eth_dev *dev;
@@ -2781,7 +2788,7 @@ rte_eth_tx_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
 
 	rte_ethdev_trace_txq_setup(port_id, tx_queue_id, nb_tx_desc, tx_conf);
 	return eth_err(port_id, dev->dev_ops->tx_queue_setup(dev,
-		       tx_queue_id, nb_tx_desc, socket_id, &local_conf));
+		       tx_queue_id, nb_tx_desc, numa_id, &local_conf));
 }
 
 RTE_EXPORT_SYMBOL(rte_eth_tx_hairpin_queue_setup)
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 1924483689..83a4dfb337 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -2424,7 +2424,7 @@ rte_eth_dev_is_removed(uint16_t port_id);
  * Allocate and set up a receive queue for an Ethernet device.
  *
  * The function allocates a contiguous block of memory for *nb_rx_desc*
- * receive descriptors from a memory zone associated with *socket_id*
+ * receive descriptors from a memory zone associated with *numa_id*
  * and initializes each receive descriptor with a network buffer allocated
  * from the memory pool *mb_pool*.
  *
@@ -2436,9 +2436,9 @@ rte_eth_dev_is_removed(uint16_t port_id);
  *   to rte_eth_dev_configure().
  * @param nb_rx_desc
  *   The number of receive descriptors to allocate for the receive ring.
- * @param socket_id
- *   The *socket_id* argument is the socket identifier in case of NUMA.
- *   The value can be *SOCKET_ID_ANY* if there is no NUMA constraint for
+ * @param numa_id
+ *   The *numa_id* argument is the NUMA node ID in case of NUMA.
+ *   The value can be *RTE_NUMA_ID_ANY* if there is no NUMA constraint for
  *   the DMA memory allocated for the receive descriptors of the ring.
  * @param rx_conf
  *   The pointer to the configuration data to be used for the receive queue.
@@ -2483,7 +2483,7 @@ rte_eth_dev_is_removed(uint16_t port_id);
  *      initializing receive descriptors.
  */
 int rte_eth_rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
-		uint16_t nb_rx_desc, unsigned int socket_id,
+		uint16_t nb_rx_desc, unsigned int numa_id,
 		const struct rte_eth_rxconf *rx_conf,
 		struct rte_mempool *mb_pool);
 
@@ -2526,9 +2526,9 @@ int rte_eth_rx_hairpin_queue_setup
  *   to rte_eth_dev_configure().
  * @param nb_tx_desc
  *   The number of transmit descriptors to allocate for the transmit ring.
- * @param socket_id
- *   The *socket_id* argument is the socket identifier in case of NUMA.
- *   Its value can be *SOCKET_ID_ANY* if there is no NUMA constraint for
+ * @param numa_id
+ *   The *numa_id* argument is the NUMA node ID in case of NUMA.
+ *   Its value can be *RTE_NUMA_ID_ANY* if there is no NUMA constraint for
  *   the DMA memory allocated for the transmit descriptors of the ring.
  * @param tx_conf
  *   The pointer to the configuration data to be used for the transmit queue.
@@ -2564,7 +2564,7 @@ int rte_eth_rx_hairpin_queue_setup
  *   - -ENOMEM: Unable to allocate the transmit ring descriptors.
  */
 int rte_eth_tx_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
-		uint16_t nb_tx_desc, unsigned int socket_id,
+		uint16_t nb_tx_desc, unsigned int numa_id,
 		const struct rte_eth_txconf *tx_conf);
 
 /**
@@ -2704,14 +2704,30 @@ int rte_eth_dev_count_aggr_ports(uint16_t port_id);
 int rte_eth_dev_map_aggr_tx_affinity(uint16_t port_id, uint16_t tx_queue_id,
 				     uint8_t affinity);
 
+/**
+ * Return the NUMA node to which an Ethernet device is connected
+ *
+ * @param port_id
+ *   The port identifier of the Ethernet device
+ * @return
+ *   - The NUMA node ID which the Ethernet device is connected to.
+ *   - RTE_NUMA_ID_ANY if the NUMA node could not be
+ *     determined. rte_errno is then set to:
+ *     - EINVAL is the port_id is invalid,
+ *     - 0 is the NUMA node could not be determined,
+ */
+int rte_eth_dev_numa_id(uint16_t port_id);
+
 /**
  * Return the NUMA socket to which an Ethernet device is connected
  *
+ * This is a legacy alias of rte_eth_dev_numa_id().
+ *
  * @param port_id
  *   The port identifier of the Ethernet device
  * @return
  *   - The NUMA socket ID which the Ethernet device is connected to.
- *   - -1 (which translates to SOCKET_ID_ANY) if the socket could not be
+ *   - -1 (which translates to RTE_NUMA_ID_ANY) if the socket could not be
  *     determined. rte_errno is then set to:
  *     - EINVAL is the port_id is invalid,
  *     - 0 is the socket could not be determined,
@@ -4064,7 +4080,7 @@ enum rte_eth_event_type {
 	/**
 	 * The port is being probed, i.e. allocated and not yet available.
 	 * It is too early to check validity, query infos, and configure
-	 * the port. But some functions, like rte_eth_dev_socket_id() and
+	 * the port. But some functions, like rte_eth_dev_numa_id() and
 	 * rte_eth_dev_owner_*() are available to the application.
 	 */
 	RTE_ETH_EVENT_NEW,
diff --git a/lib/ethdev/rte_ethdev_telemetry.c b/lib/ethdev/rte_ethdev_telemetry.c
index 146acec174..1749e86421 100644
--- a/lib/ethdev/rte_ethdev_telemetry.c
+++ b/lib/ethdev/rte_ethdev_telemetry.c
@@ -537,7 +537,7 @@ eth_dev_handle_port_rxq(const char *cmd __rte_unused,
 
 	rte_tel_data_start_dict(d);
 	rte_tel_data_add_dict_string(d, "mempool_name", qinfo.mp->name);
-	rte_tel_data_add_dict_uint(d, "socket_id", qinfo.mp->numa_id);
+	rte_tel_data_add_dict_uint(d, "numa_id", qinfo.mp->numa_id);
 
 	rx_thresh = &qinfo.conf.rx_thresh;
 	rte_tel_data_add_dict_uint(d, "host_threshold", rx_thresh->hthresh);
-- 
2.55.0

