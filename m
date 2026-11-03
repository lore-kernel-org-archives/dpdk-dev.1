Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7A2606A781
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KWSSR7xZ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C2DF41104;
	Tue,  3 Nov 2026 15:54:55 +0100 (CET)
Received: from mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
 by mails.dpdk.org (Postfix) with ESMTPS id AA00B41104
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:54:53 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=TMQpo/ioppI5FLMWMQUrK07l7jwCHUeHVvJjM55o5IY=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717693; v=1; x=1794322493;
 b=KWSSR7xZrgu48l0M10U62bRpmHlNIPuMaYQRY7m1NCGwaNnrajXDNN/PYteB3IgUrwXypwlt
 tmUBY6ESaD8VxAIGH4IPiJ7dkfTZHjPVNeFKRauYLw8bZ43tQFJiu2/KSt+2BtkdqkoLKYDlYRz
 CtNNa18afo+aCiBsvlI03pGQ=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id b5130c87bc065a2c;
 Tue, 03 Nov 2026 14:54:53 +0000
X-Mizu-Trace-ID: b5130c87bc065a2c
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 012/227] eventdev: rename device socket API to NUMA node API
Date: Tue,  3 Nov 2026 22:49:30 +0800
Message-ID: <20261103145306.487255-13-chengwen.feng@linux.dev>
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

Rename the exported function rte_event_dev_socket_id() to
rte_event_dev_numa_id(), keeping the old name as a functional
alias to be deprecated once the in-tree migration completes.

Rename the numa_id fields of the timer and vector adapter
configuration structures (were socket_id), keeping socket_id as
a deprecated union alias, and the eventdev data field to
numa_id, and update in-tree users accordingly.

Also rename socket_id parameters, trace points, internal
variables, log messages and comments to the NUMA node
terminology, and switch internal calls to rte_zmalloc_numa(),
rte_numa_id() and RTE_NUMA_ID_ANY.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-eventdev/test_perf_common.c       |  4 +-
 drivers/event/dlb2/pf/dlb2_pf.c            |  2 +-
 drivers/event/dsw/dsw_evdev.c              |  4 +-
 drivers/event/octeontx/ssovf_evdev.c       |  2 +-
 drivers/event/skeleton/skeleton_eventdev.c |  4 +-
 drivers/event/sw/sw_evdev.c                |  8 +--
 drivers/event/sw/sw_evdev_xstats.c         |  2 +-
 lib/eventdev/event_timer_adapter_pmd.h     |  4 +-
 lib/eventdev/event_vector_adapter_pmd.h    |  4 +-
 lib/eventdev/eventdev_pmd.h                | 10 ++--
 lib/eventdev/eventdev_pmd_pci.h            |  4 +-
 lib/eventdev/eventdev_pmd_vdev.h           | 12 ++--
 lib/eventdev/eventdev_trace.h              | 14 ++---
 lib/eventdev/eventdev_trace_points.c       |  4 +-
 lib/eventdev/rte_event_crypto_adapter.c    | 30 +++++-----
 lib/eventdev/rte_event_dma_adapter.c       | 38 ++++++------
 lib/eventdev/rte_event_eth_rx_adapter.c    | 68 +++++++++++-----------
 lib/eventdev/rte_event_eth_tx_adapter.c    | 30 +++++-----
 lib/eventdev/rte_event_ring.c              |  6 +-
 lib/eventdev/rte_event_ring.h              |  8 +--
 lib/eventdev/rte_event_timer_adapter.c     | 16 ++---
 lib/eventdev/rte_event_timer_adapter.h     | 11 +++-
 lib/eventdev/rte_event_vector_adapter.c    | 12 ++--
 lib/eventdev/rte_event_vector_adapter.h    | 11 +++-
 lib/eventdev/rte_eventdev.c                | 31 ++++++----
 lib/eventdev/rte_eventdev.h                | 24 ++++++--
 26 files changed, 200 insertions(+), 163 deletions(-)

diff --git a/app/test-eventdev/test_perf_common.c b/app/test-eventdev/test_perf_common.c
index a7858854eb..cb69ed7f1b 100644
--- a/app/test-eventdev/test_perf_common.c
+++ b/app/test-eventdev/test_perf_common.c
@@ -1649,7 +1649,7 @@ perf_event_dev_port_setup(struct evt_test *test, struct evt_options *opt,
 		conf.event_dev_id = opt->dev_id;
 		conf.vector_sz = opt->vector_size;
 		conf.vector_timeout_ns = opt->vector_tmo_nsec;
-		conf.socket_id = opt->socket_id;
+		conf.numa_id = opt->socket_id;
 		conf.vector_mp = t->pool;
 
 		conf.ev.sched_type = opt->sched_type_list[0];
@@ -2082,7 +2082,7 @@ perf_cryptodev_setup(struct evt_test *test, struct evt_options *opt)
 		}
 
 		conf.nb_queue_pairs = nb_qps;
-		conf.socket_id = SOCKET_ID_ANY;
+		conf.numa_id = RTE_NUMA_ID_ANY;
 		conf.ff_disable = RTE_CRYPTODEV_FF_SECURITY;
 
 		ret = rte_cryptodev_configure(cdev_id, &conf);
diff --git a/drivers/event/dlb2/pf/dlb2_pf.c b/drivers/event/dlb2/pf/dlb2_pf.c
index c78783e59d..aaa55bbe00 100644
--- a/drivers/event/dlb2/pf/dlb2_pf.c
+++ b/drivers/event/dlb2/pf/dlb2_pf.c
@@ -777,7 +777,7 @@ dlb2_eventdev_pci_init(struct rte_eventdev *eventdev)
 	const void *probe_args = NULL;
 
 	DLB2_LOG_LINE_DBG("Enter with dev_id=%d socket_id=%d",
-		     eventdev->data->dev_id, eventdev->data->socket_id);
+		     eventdev->data->dev_id, eventdev->data->numa_id);
 
 	for (q = 0; q < DLB2_MAX_NUM_PORTS_ALL; q++)
 		dlb2_args.port_cos.cos_id[q] = DLB2_COS_DEFAULT;
diff --git a/drivers/event/dsw/dsw_evdev.c b/drivers/event/dsw/dsw_evdev.c
index e819412639..55e3a2045c 100644
--- a/drivers/event/dsw/dsw_evdev.c
+++ b/drivers/event/dsw/dsw_evdev.c
@@ -43,7 +43,7 @@ dsw_port_setup(struct rte_eventdev *dev, uint8_t port_id,
 		 port_id);
 
 	in_ring = rte_event_ring_create(ring_name, DSW_IN_RING_SIZE,
-					dev->data->socket_id,
+					dev->data->numa_id,
 					RING_F_SC_DEQ|RING_F_EXACT_SZ);
 
 	if (in_ring == NULL)
@@ -55,7 +55,7 @@ dsw_port_setup(struct rte_eventdev *dev, uint8_t port_id,
 	ctl_in_ring = rte_ring_create_elem(ring_name,
 					   sizeof(struct dsw_ctl_msg),
 					   DSW_CTL_IN_RING_SIZE,
-					   dev->data->socket_id,
+					   dev->data->numa_id,
 					   RING_F_SC_DEQ|RING_F_EXACT_SZ);
 
 	if (ctl_in_ring == NULL) {
diff --git a/drivers/event/octeontx/ssovf_evdev.c b/drivers/event/octeontx/ssovf_evdev.c
index 957fcab04e..1e5818569b 100644
--- a/drivers/event/octeontx/ssovf_evdev.c
+++ b/drivers/event/octeontx/ssovf_evdev.c
@@ -256,7 +256,7 @@ ssovf_port_setup(struct rte_eventdev *dev, uint8_t port_id,
 	/* Allocate event port memory */
 	ws = rte_zmalloc_socket("eventdev ssows",
 			sizeof(struct ssows), RTE_CACHE_LINE_SIZE,
-			dev->data->socket_id);
+			dev->data->numa_id);
 	if (ws == NULL) {
 		ssovf_log_err("Failed to alloc memory for port=%d", port_id);
 		return -ENOMEM;
diff --git a/drivers/event/skeleton/skeleton_eventdev.c b/drivers/event/skeleton/skeleton_eventdev.c
index c0e06e4aa0..9eccf61cad 100644
--- a/drivers/event/skeleton/skeleton_eventdev.c
+++ b/drivers/event/skeleton/skeleton_eventdev.c
@@ -222,7 +222,7 @@ skeleton_eventdev_port_setup(struct rte_eventdev *dev, uint8_t port_id,
 	/* Allocate event port memory */
 	sp = rte_zmalloc_socket("eventdev port",
 			sizeof(struct skeleton_port), RTE_CACHE_LINE_SIZE,
-			dev->data->socket_id);
+			dev->data->numa_id);
 	if (sp == NULL) {
 		PMD_DRV_ERR("Failed to allocate sp port_id=%d", port_id);
 		return -ENOMEM;
@@ -352,7 +352,7 @@ skeleton_eventdev_init(struct rte_eventdev *eventdev)
 			pci_dev->addr.devid, pci_dev->addr.function);
 
 	PMD_DRV_LOG(INFO, "dev_id=%d socket_id=%d (%x:%x)",
-		eventdev->data->dev_id, eventdev->data->socket_id,
+		eventdev->data->dev_id, eventdev->data->numa_id,
 		skel->vendor_id, skel->device_id);
 
 fail:
diff --git a/drivers/event/sw/sw_evdev.c b/drivers/event/sw/sw_evdev.c
index adff02bf3e..d6bc23a220 100644
--- a/drivers/event/sw/sw_evdev.c
+++ b/drivers/event/sw/sw_evdev.c
@@ -178,7 +178,7 @@ sw_port_setup(struct rte_eventdev *dev, uint8_t port_id,
 	rte_event_ring_free(existing_ring);
 
 	p->rx_worker_ring = rte_event_ring_create(buf, MAX_SW_PROD_Q_DEPTH,
-			dev->data->socket_id,
+			dev->data->numa_id,
 			RING_F_SP_ENQ | RING_F_SC_DEQ | RING_F_EXACT_SZ);
 	if (p->rx_worker_ring == NULL) {
 		SW_LOG_ERR("Error creating RX worker ring for port %d",
@@ -197,7 +197,7 @@ sw_port_setup(struct rte_eventdev *dev, uint8_t port_id,
 	rte_event_ring_free(existing_ring);
 
 	p->cq_worker_ring = rte_event_ring_create(buf, conf->dequeue_depth,
-			dev->data->socket_id,
+			dev->data->numa_id,
 			RING_F_SP_ENQ | RING_F_SC_DEQ | RING_F_EXACT_SZ);
 	if (p->cq_worker_ring == NULL) {
 		rte_event_ring_free(p->rx_worker_ring);
@@ -237,7 +237,7 @@ qid_init(struct sw_evdev *sw, unsigned int idx, int type,
 		const struct rte_event_queue_conf *queue_conf)
 {
 	unsigned int i;
-	int socket_id = sw->data->socket_id;
+	int socket_id = sw->data->numa_id;
 	struct sw_qid *qid = &sw->qids[idx];
 
 	/* Initialize the FID structures to no pinning (-1), and zero packets */
@@ -537,7 +537,7 @@ sw_dev_configure(const struct rte_eventdev *dev)
 				       sizeof(struct sw_queue_chunk) *
 				       num_chunks,
 				       0,
-				       sw->data->socket_id);
+				       sw->data->numa_id);
 	if (!sw->chunks)
 		return -ENOMEM;
 
diff --git a/drivers/event/sw/sw_evdev_xstats.c b/drivers/event/sw/sw_evdev_xstats.c
index 076b982ab8..611a7ce94a 100644
--- a/drivers/event/sw/sw_evdev_xstats.c
+++ b/drivers/event/sw/sw_evdev_xstats.c
@@ -262,7 +262,7 @@ sw_xstats_init(struct sw_evdev *sw)
 	unsigned int i, port, qid, iq, bkt, stat = 0;
 
 	sw->xstats = rte_zmalloc_socket(NULL, sizeof(sw->xstats[0]) * count, 0,
-			sw->data->socket_id);
+			sw->data->numa_id);
 	if (sw->xstats == NULL)
 		return -ENOMEM;
 
diff --git a/lib/eventdev/event_timer_adapter_pmd.h b/lib/eventdev/event_timer_adapter_pmd.h
index f06e85dc0b..6b75ee304b 100644
--- a/lib/eventdev/event_timer_adapter_pmd.h
+++ b/lib/eventdev/event_timer_adapter_pmd.h
@@ -87,8 +87,8 @@ struct __rte_cache_aligned rte_event_timer_adapter_data {
 	/**< Event timer adapter ID */
 	uint8_t event_dev_id;
 	/**< Event device ID */
-	uint32_t socket_id;
-	/**< Socket ID where memory is allocated */
+	uint32_t numa_id;
+	/**< NUMA node ID where memory is allocated */
 	uint8_t event_port_id;
 	/**< Optional: event port ID used when the inbuilt port is absent */
 	const struct rte_memzone *mz;
diff --git a/lib/eventdev/event_vector_adapter_pmd.h b/lib/eventdev/event_vector_adapter_pmd.h
index 7fe2c53639..614833d691 100644
--- a/lib/eventdev/event_vector_adapter_pmd.h
+++ b/lib/eventdev/event_vector_adapter_pmd.h
@@ -56,8 +56,8 @@ struct __rte_cache_aligned rte_event_vector_adapter_data {
 	/**< Event vector adapter ID */
 	uint8_t event_dev_id;
 	/**< Event device ID */
-	uint32_t socket_id;
-	/**< Socket ID where memory is allocated */
+	uint32_t numa_id;
+	/**< NUMA node ID where memory is allocated */
 	uint8_t event_port_id;
 	/**< Optional: event port ID used when the inbuilt port is absent */
 	const struct rte_memzone *mz;
diff --git a/lib/eventdev/eventdev_pmd.h b/lib/eventdev/eventdev_pmd.h
index 9309dce5e1..2d40e4ff0c 100644
--- a/lib/eventdev/eventdev_pmd.h
+++ b/lib/eventdev/eventdev_pmd.h
@@ -110,8 +110,8 @@ struct rte_eventdev_global {
  * different processes in a multi-process configuration.
  */
 struct __rte_cache_aligned rte_eventdev_data {
-	int socket_id;
-	/**< Socket ID where memory is allocated */
+	int numa_id;
+	/**< NUMA node ID where memory is allocated */
 	uint8_t dev_id;
 	/**< Device ID for this instance */
 	uint8_t nb_queues;
@@ -1744,14 +1744,14 @@ struct eventdev_ops {
  *
  * @param name
  *   Unique identifier name for each device
- * @param socket_id
- *   Socket to allocate resources on.
+ * @param numa_id
+ *   NUMA node to allocate resources on.
  * @return
  *   - Slot in the rte_dev_devices array for a new device;
  */
 __rte_internal
 struct rte_eventdev *
-rte_event_pmd_allocate(const char *name, int socket_id);
+rte_event_pmd_allocate(const char *name, int numa_id);
 
 /**
  * Release the specified eventdev device.
diff --git a/lib/eventdev/eventdev_pmd_pci.h b/lib/eventdev/eventdev_pmd_pci.h
index ebc7d12b1d..3994c3b42e 100644
--- a/lib/eventdev/eventdev_pmd_pci.h
+++ b/lib/eventdev/eventdev_pmd_pci.h
@@ -57,11 +57,11 @@ rte_event_pmd_pci_probe_named(struct rte_pci_driver *pci_drv,
 
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		eventdev->data->dev_private =
-				rte_zmalloc_socket(
+				rte_zmalloc_numa(
 						"eventdev private structure",
 						private_data_size,
 						RTE_CACHE_LINE_SIZE,
-						rte_socket_id());
+						rte_numa_id());
 
 		if (eventdev->data->dev_private == NULL)
 			rte_panic("Cannot allocate memzone for private "
diff --git a/lib/eventdev/eventdev_pmd_vdev.h b/lib/eventdev/eventdev_pmd_vdev.h
index ae1c950bed..da0b3acd99 100644
--- a/lib/eventdev/eventdev_pmd_vdev.h
+++ b/lib/eventdev/eventdev_pmd_vdev.h
@@ -35,8 +35,8 @@ extern "C" {
  *   PMD type name
  * @param dev_private_size
  *   Size of event PMDs private data
- * @param socket_id
- *   Socket to allocate resources on.
+ * @param numa_id
+ *   NUMA node to allocate resources on.
  *
  * @return
  *   - Eventdev pointer if device is successfully created.
@@ -45,23 +45,23 @@ extern "C" {
 __rte_internal
 static inline struct rte_eventdev *
 rte_event_pmd_vdev_init(const char *name, size_t dev_private_size,
-		int socket_id, struct rte_vdev_device *vdev)
+		int numa_id, struct rte_vdev_device *vdev)
 {
 
 	struct rte_eventdev *eventdev;
 
 	/* Allocate device structure */
-	eventdev = rte_event_pmd_allocate(name, socket_id);
+	eventdev = rte_event_pmd_allocate(name, numa_id);
 	if (eventdev == NULL)
 		return NULL;
 
 	/* Allocate private device structure */
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		eventdev->data->dev_private =
-				rte_zmalloc_socket("eventdev device private",
+				rte_zmalloc_numa("eventdev device private",
 						dev_private_size,
 						RTE_CACHE_LINE_SIZE,
-						socket_id);
+						numa_id);
 
 		if (eventdev->data->dev_private == NULL)
 			rte_panic("Cannot allocate memzone for private device"
diff --git a/lib/eventdev/eventdev_trace.h b/lib/eventdev/eventdev_trace.h
index 6b334d8bd1..45d53bb853 100644
--- a/lib/eventdev/eventdev_trace.h
+++ b/lib/eventdev/eventdev_trace.h
@@ -388,11 +388,11 @@ RTE_TRACE_POINT(
 )
 
 RTE_TRACE_POINT(
-	rte_eventdev_trace_socket_id,
-	RTE_TRACE_POINT_ARGS(uint8_t dev_id, const void *dev, int socket_id),
+	rte_eventdev_trace_numa_id,
+	RTE_TRACE_POINT_ARGS(uint8_t dev_id, const void *dev, int numa_id),
 	rte_trace_point_emit_u8(dev_id);
 	rte_trace_point_emit_ptr(dev);
-	rte_trace_point_emit_int(socket_id);
+	rte_trace_point_emit_int(numa_id);
 )
 
 RTE_TRACE_POINT(
@@ -569,10 +569,10 @@ RTE_TRACE_POINT(
 RTE_TRACE_POINT(
 	rte_eventdev_trace_ring_create,
 	RTE_TRACE_POINT_ARGS(const char *name, unsigned int count,
-		int socket_id, unsigned int flags),
+		int numa_id, unsigned int flags),
 	rte_trace_point_emit_string(name);
 	rte_trace_point_emit_u32(count);
-	rte_trace_point_emit_int(socket_id);
+	rte_trace_point_emit_int(numa_id);
 	rte_trace_point_emit_u32(flags);
 )
 
@@ -633,11 +633,11 @@ RTE_TRACE_POINT(
 
 RTE_TRACE_POINT(
 	rte_eventdev_trace_vector_pool_create,
-	RTE_TRACE_POINT_ARGS(const void *mp, const char *name, int socket_id,
+	RTE_TRACE_POINT_ARGS(const void *mp, const char *name, int numa_id,
 		uint32_t size, uint32_t cache_size, uint32_t elt_size),
 	rte_trace_point_emit_ptr(mp);
 	rte_trace_point_emit_string(name);
-	rte_trace_point_emit_int(socket_id);
+	rte_trace_point_emit_int(numa_id);
 	rte_trace_point_emit_u32(size);
 	rte_trace_point_emit_u32(cache_size);
 	rte_trace_point_emit_u32(elt_size);
diff --git a/lib/eventdev/eventdev_trace_points.c b/lib/eventdev/eventdev_trace_points.c
index ade6723b7b..f5f6be3a7b 100644
--- a/lib/eventdev/eventdev_trace_points.c
+++ b/lib/eventdev/eventdev_trace_points.c
@@ -176,8 +176,8 @@ RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_info_get,
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_service_id_get,
 	lib.eventdev.service_id_get)
 
-RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_socket_id,
-	lib.eventdev.socket.id)
+RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_numa_id,
+	lib.eventdev.numa_id)
 
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_stop_flush_callback_register,
 	lib.eventdev.stop.flush.callback.register)
diff --git a/lib/eventdev/rte_event_crypto_adapter.c b/lib/eventdev/rte_event_crypto_adapter.c
index 6ac64cafb1..a8e29f2b32 100644
--- a/lib/eventdev/rte_event_crypto_adapter.c
+++ b/lib/eventdev/rte_event_crypto_adapter.c
@@ -91,8 +91,8 @@ struct __rte_cache_aligned event_crypto_adapter {
 	uint8_t service_inited;
 	/* Memory allocation name */
 	char mem_name[CRYPTO_ADAPTER_MEM_NAME_LEN];
-	/* Socket identifier cached from eventdev */
-	int socket_id;
+	/* NUMA node identifier cached from eventdev */
+	int numa_id;
 	/* Per adapter EAL service */
 	uint32_t service_id;
 	/* No. of queue pairs configured */
@@ -180,7 +180,7 @@ eca_init(void)
 	mz = rte_memzone_lookup(ECA_ADAPTER_ARRAY);
 	if (mz == NULL) {
 		mz = rte_memzone_reserve_aligned(ECA_ADAPTER_ARRAY, sz,
-						 rte_socket_id(), 0,
+						 rte_numa_id(), 0,
 						 RTE_CACHE_LINE_SIZE);
 		if (mz == NULL) {
 			RTE_EDEV_LOG_ERR("failed to reserve memzone err = %"
@@ -372,7 +372,7 @@ rte_event_crypto_adapter_create_ext(uint8_t id, uint8_t dev_id,
 {
 	struct event_crypto_adapter *adapter;
 	char mem_name[CRYPTO_ADAPTER_NAME_LEN];
-	int socket_id;
+	int numa_id;
 	uint8_t i;
 	int ret;
 
@@ -393,12 +393,12 @@ rte_event_crypto_adapter_create_ext(uint8_t id, uint8_t dev_id,
 		return -EEXIST;
 	}
 
-	socket_id = rte_event_dev_socket_id(dev_id);
+	numa_id = rte_event_dev_numa_id(dev_id);
 	snprintf(mem_name, CRYPTO_ADAPTER_MEM_NAME_LEN,
 		 "rte_event_crypto_adapter_%d", id);
 
-	adapter = rte_zmalloc_socket(mem_name, sizeof(*adapter),
-			RTE_CACHE_LINE_SIZE, socket_id);
+	adapter = rte_zmalloc_numa(mem_name, sizeof(*adapter),
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (adapter == NULL) {
 		RTE_EDEV_LOG_ERR("Failed to get mem for event crypto adapter!");
 		return -ENOMEM;
@@ -413,15 +413,15 @@ rte_event_crypto_adapter_create_ext(uint8_t id, uint8_t dev_id,
 	}
 
 	adapter->eventdev_id = dev_id;
-	adapter->socket_id = socket_id;
+	adapter->numa_id = numa_id;
 	adapter->conf_cb = conf_cb;
 	adapter->conf_arg = conf_arg;
 	adapter->mode = mode;
 	strcpy(adapter->mem_name, mem_name);
-	adapter->cdevs = rte_zmalloc_socket(adapter->mem_name,
+	adapter->cdevs = rte_zmalloc_numa(adapter->mem_name,
 					rte_cryptodev_count() *
 					sizeof(struct crypto_device_info), 0,
-					socket_id);
+					numa_id);
 	if (adapter->cdevs == NULL) {
 		RTE_EDEV_LOG_ERR("Failed to get mem for crypto devices");
 		eca_circular_buffer_free(&adapter->ebuf);
@@ -920,7 +920,7 @@ eca_init_service(struct event_crypto_adapter *adapter, uint8_t id)
 	memset(&service, 0, sizeof(service));
 	snprintf(service.name, CRYPTO_ADAPTER_NAME_LEN,
 		"rte_event_crypto_adapter_%d", id);
-	service.socket_id = adapter->socket_id;
+	service.socket_id = adapter->numa_id;
 	service.callback = eca_service_func;
 	service.callback_userdata = adapter;
 	/* Service function handles locking for queue add/del updates */
@@ -1011,10 +1011,10 @@ eca_add_queue_pair(struct event_crypto_adapter *adapter, uint8_t cdev_id,
 
 	if (dev_info->qpairs == NULL) {
 		dev_info->qpairs =
-		    rte_zmalloc_socket(adapter->mem_name,
+		    rte_zmalloc_numa(adapter->mem_name,
 					dev_info->dev->data->nb_queue_pairs *
 					sizeof(struct crypto_queue_pair_info),
-					0, adapter->socket_id);
+					0, adapter->numa_id);
 		if (dev_info->qpairs == NULL)
 			return -ENOMEM;
 
@@ -1141,10 +1141,10 @@ rte_event_crypto_adapter_queue_pair_add(uint8_t id,
 			return -ENOTSUP;
 		if (dev_info->qpairs == NULL) {
 			dev_info->qpairs =
-			    rte_zmalloc_socket(adapter->mem_name,
+			    rte_zmalloc_numa(adapter->mem_name,
 					dev_info->dev->data->nb_queue_pairs *
 					sizeof(struct crypto_queue_pair_info),
-					0, adapter->socket_id);
+					0, adapter->numa_id);
 			if (dev_info->qpairs == NULL)
 				return -ENOMEM;
 		}
diff --git a/lib/eventdev/rte_event_dma_adapter.c b/lib/eventdev/rte_event_dma_adapter.c
index da785483c2..1dc752141d 100644
--- a/lib/eventdev/rte_event_dma_adapter.c
+++ b/lib/eventdev/rte_event_dma_adapter.c
@@ -97,8 +97,8 @@ struct __rte_cache_aligned event_dma_adapter {
 	/* Memory allocation name */
 	char mem_name[DMA_ADAPTER_NAME_LEN];
 
-	/* Socket identifier cached from eventdev */
-	int socket_id;
+	/* NUMA node identifier cached from eventdev */
+	int numa_id;
 
 	/* Lock to serialize config updates with service function */
 	rte_spinlock_t lock;
@@ -173,7 +173,7 @@ edma_array_init(void)
 		sz = sizeof(struct event_dma_adapter *) * RTE_EVENT_DMA_ADAPTER_MAX_INSTANCE;
 		sz = RTE_ALIGN(sz, RTE_CACHE_LINE_SIZE);
 
-		mz = rte_memzone_reserve_aligned(DMA_ADAPTER_ARRAY, sz, rte_socket_id(), 0,
+		mz = rte_memzone_reserve_aligned(DMA_ADAPTER_ARRAY, sz, rte_numa_id(), 0,
 						 RTE_CACHE_LINE_SIZE);
 		if (mz == NULL) {
 			RTE_EDEV_LOG_ERR("Failed to reserve memzone : %s, err = %d",
@@ -352,7 +352,7 @@ rte_event_dma_adapter_create_ext(uint8_t id, uint8_t evdev_id,
 	char name[DMA_ADAPTER_NAME_LEN];
 	struct rte_dma_info info;
 	uint16_t num_dma_dev;
-	int socket_id;
+	int numa_id;
 	uint8_t i;
 	int ret;
 
@@ -374,10 +374,10 @@ rte_event_dma_adapter_create_ext(uint8_t id, uint8_t evdev_id,
 		return -EEXIST;
 	}
 
-	socket_id = rte_event_dev_socket_id(evdev_id);
+	numa_id = rte_event_dev_numa_id(evdev_id);
 	snprintf(name, DMA_ADAPTER_NAME_LEN, "rte_event_dma_adapter_%d", id);
-	adapter = rte_zmalloc_socket(name, sizeof(struct event_dma_adapter), RTE_CACHE_LINE_SIZE,
-				     socket_id);
+	adapter = rte_zmalloc_numa(name, sizeof(struct event_dma_adapter), RTE_CACHE_LINE_SIZE,
+				     numa_id);
 	if (adapter == NULL) {
 		RTE_EDEV_LOG_ERR("Failed to get mem for event ML adapter!");
 		return -ENOMEM;
@@ -404,12 +404,12 @@ rte_event_dma_adapter_create_ext(uint8_t id, uint8_t evdev_id,
 	adapter->eventdev_id = evdev_id;
 	adapter->mode = mode;
 	rte_strscpy(adapter->mem_name, name, DMA_ADAPTER_NAME_LEN);
-	adapter->socket_id = socket_id;
+	adapter->numa_id = numa_id;
 	adapter->conf_cb = conf_cb;
 	adapter->conf_arg = conf_arg;
-	adapter->dma_devs = rte_zmalloc_socket(adapter->mem_name,
+	adapter->dma_devs = rte_zmalloc_numa(adapter->mem_name,
 					       num_dma_dev * sizeof(struct dma_device_info), 0,
-					       socket_id);
+					       numa_id);
 	if (adapter->dma_devs == NULL) {
 		RTE_EDEV_LOG_ERR("Failed to get memory for DMA devices");
 		edma_circular_buffer_free(&adapter->ebuf);
@@ -867,7 +867,7 @@ edma_init_service(struct event_dma_adapter *adapter, uint8_t id)
 
 	memset(&service, 0, sizeof(service));
 	snprintf(service.name, DMA_ADAPTER_NAME_LEN, "rte_event_dma_adapter_%d", id);
-	service.socket_id = adapter->socket_id;
+	service.socket_id = adapter->numa_id;
 	service.callback = edma_service_func;
 	service.callback_userdata = adapter;
 
@@ -946,15 +946,15 @@ edma_add_vchan(struct event_dma_adapter *adapter, int16_t dma_dev_id, uint16_t v
 	if (dev_info->vchanq == NULL) {
 		nb_vchans = dev_info->num_dma_dev_vchan;
 
-		dev_info->vchanq = rte_zmalloc_socket(adapter->mem_name,
+		dev_info->vchanq = rte_zmalloc_numa(adapter->mem_name,
 				nb_vchans * sizeof(struct dma_vchan_info),
-				0, adapter->socket_id);
+				0, adapter->numa_id);
 		if (dev_info->vchanq == NULL)
 			return -ENOMEM;
 
-		dev_info->tqmap = rte_zmalloc_socket(adapter->mem_name,
+		dev_info->tqmap = rte_zmalloc_numa(adapter->mem_name,
 				nb_vchans * sizeof(struct dma_vchan_info),
-				0, adapter->socket_id);
+				0, adapter->numa_id);
 		if (dev_info->tqmap == NULL)
 			return -ENOMEM;
 
@@ -1039,10 +1039,10 @@ rte_event_dma_adapter_vchan_add(uint8_t id, int16_t dma_dev_id, uint16_t vchan,
 		if (dev->dev_ops->dma_adapter_vchan_add == NULL)
 			return -ENOTSUP;
 		if (dev_info->vchanq == NULL) {
-			dev_info->vchanq = rte_zmalloc_socket(adapter->mem_name,
+			dev_info->vchanq = rte_zmalloc_numa(adapter->mem_name,
 							dev_info->num_dma_dev_vchan *
 							sizeof(struct dma_vchan_info),
-							0, adapter->socket_id);
+							0, adapter->numa_id);
 			if (dev_info->vchanq == NULL) {
 				RTE_EDEV_LOG_ERR("Queue pair add not supported");
 				return -ENOMEM;
@@ -1050,10 +1050,10 @@ rte_event_dma_adapter_vchan_add(uint8_t id, int16_t dma_dev_id, uint16_t vchan,
 		}
 
 		if (dev_info->tqmap == NULL) {
-			dev_info->tqmap = rte_zmalloc_socket(adapter->mem_name,
+			dev_info->tqmap = rte_zmalloc_numa(adapter->mem_name,
 						dev_info->num_dma_dev_vchan *
 						sizeof(struct dma_vchan_info),
-						0, adapter->socket_id);
+						0, adapter->numa_id);
 			if (dev_info->tqmap == NULL) {
 				RTE_EDEV_LOG_ERR("tq pair add not supported");
 				return -ENOMEM;
diff --git a/lib/eventdev/rte_event_eth_rx_adapter.c b/lib/eventdev/rte_event_eth_rx_adapter.c
index 26c0a26db1..e87a6eca78 100644
--- a/lib/eventdev/rte_event_eth_rx_adapter.c
+++ b/lib/eventdev/rte_event_eth_rx_adapter.c
@@ -181,8 +181,8 @@ struct __rte_cache_aligned event_eth_rx_adapter {
 	uint32_t nb_queues;
 	/* Memory allocation name */
 	char mem_name[ETH_RX_ADAPTER_MEM_NAME_LEN];
-	/* Socket identifier cached from eventdev */
-	int socket_id;
+	/* NUMA node identifier cached from eventdev */
+	int numa_id;
 	/* Per adapter EAL service */
 	uint32_t service_id;
 	/* Adapter started flag */
@@ -586,10 +586,10 @@ rxa_alloc_poll(struct event_eth_rx_adapter *rx_adapter, uint32_t num_rx_polled)
 
 	len  = RTE_ALIGN(num_rx_polled * sizeof(*rx_adapter->eth_rx_poll),
 							RTE_CACHE_LINE_SIZE);
-	return  rte_zmalloc_socket(rx_adapter->mem_name,
+	return  rte_zmalloc_numa(rx_adapter->mem_name,
 				len,
 				RTE_CACHE_LINE_SIZE,
-				rx_adapter->socket_id);
+				rx_adapter->numa_id);
 }
 
 /*
@@ -602,10 +602,10 @@ rxa_alloc_wrr(struct event_eth_rx_adapter *rx_adapter, int nb_wrr)
 
 	len = RTE_ALIGN(nb_wrr * sizeof(*rx_adapter->wrr_sched),
 			RTE_CACHE_LINE_SIZE);
-	return  rte_zmalloc_socket(rx_adapter->mem_name,
+	return  rte_zmalloc_numa(rx_adapter->mem_name,
 				len,
 				RTE_CACHE_LINE_SIZE,
-				rx_adapter->socket_id);
+				rx_adapter->numa_id);
 }
 
 static int
@@ -1458,7 +1458,7 @@ rxa_memzone_array_get(const char *name, unsigned int elt_size, int nb_elems)
 
 	mz = rte_memzone_lookup(name);
 	if (mz == NULL) {
-		mz = rte_memzone_reserve_aligned(name, sz, rte_socket_id(), 0,
+		mz = rte_memzone_reserve_aligned(name, sz, rte_numa_id(), 0,
 						 RTE_CACHE_LINE_SIZE);
 		if (mz == NULL) {
 			RTE_EDEV_LOG_ERR("failed to reserve memzone"
@@ -1604,15 +1604,15 @@ rxa_create_intr_thread(struct event_eth_rx_adapter *rx_adapter)
 
 	rx_adapter->intr_ring = rte_ring_create("intr_ring",
 					RTE_EVENT_ETH_INTR_RING_SIZE,
-					rte_socket_id(), 0);
+					rte_numa_id(), 0);
 	if (!rx_adapter->intr_ring)
 		return -ENOMEM;
 
-	rx_adapter->epoll_events = rte_zmalloc_socket(rx_adapter->mem_name,
+	rx_adapter->epoll_events = rte_zmalloc_numa(rx_adapter->mem_name,
 					RTE_EVENT_ETH_INTR_RING_SIZE *
 					sizeof(struct rte_epoll_event),
 					RTE_CACHE_LINE_SIZE,
-					rx_adapter->socket_id);
+					rx_adapter->numa_id);
 	if (!rx_adapter->epoll_events) {
 		err = -ENOMEM;
 		goto error;
@@ -1782,11 +1782,11 @@ rxa_config_intr(struct event_eth_rx_adapter *rx_adapter,
 		size_t len =
 			dev_info->dev->data->nb_rx_queues * sizeof(uint16_t);
 		dev_info->intr_queue =
-			rte_zmalloc_socket(
+			rte_zmalloc_numa(
 				rx_adapter->mem_name,
 				len,
 				0,
-				rx_adapter->socket_id);
+				rx_adapter->numa_id);
 		if (dev_info->intr_queue == NULL)
 			return -ENOMEM;
 	}
@@ -1922,7 +1922,7 @@ rxa_init_service(struct event_eth_rx_adapter *rx_adapter, uint8_t id)
 	memset(&service, 0, sizeof(service));
 	snprintf(service.name, ETH_RX_ADAPTER_SERVICE_NAME_LEN,
 		"rte_event_eth_rx_adapter_%d", id);
-	service.socket_id = rx_adapter->socket_id;
+	service.socket_id = rx_adapter->numa_id;
 	service.callback = rxa_service_func;
 	service.callback_userdata = rx_adapter;
 	/* Service function handles locking for queue add/del updates */
@@ -2148,9 +2148,9 @@ rxa_add_queue(struct event_eth_rx_adapter *rx_adapter,
 	if (!rx_adapter->use_queue_event_buf)
 		return 0;
 
-	new_rx_buf = rte_zmalloc_socket("rx_buffer_meta",
+	new_rx_buf = rte_zmalloc_numa("rx_buffer_meta",
 				sizeof(*new_rx_buf), 0,
-				rte_eth_dev_socket_id(eth_dev_id));
+				rte_eth_dev_numa_id(eth_dev_id));
 	if (new_rx_buf == NULL) {
 		RTE_EDEV_LOG_ERR("Failed to allocate event buffer meta for "
 				 "dev_id: %d queue_id: %d",
@@ -2160,10 +2160,10 @@ rxa_add_queue(struct event_eth_rx_adapter *rx_adapter,
 
 	new_rx_buf->events_size = RTE_ALIGN(conf->event_buf_size, BATCH_SIZE);
 	new_rx_buf->events_size += (2 * BATCH_SIZE);
-	new_rx_buf->events = rte_zmalloc_socket("rx_buffer",
+	new_rx_buf->events = rte_zmalloc_numa("rx_buffer",
 				sizeof(struct rte_event) *
 				new_rx_buf->events_size, 0,
-				rte_eth_dev_socket_id(eth_dev_id));
+				rte_eth_dev_numa_id(eth_dev_id));
 	if (new_rx_buf->events == NULL) {
 		rte_free(new_rx_buf);
 		RTE_EDEV_LOG_ERR("Failed to allocate event buffer for "
@@ -2175,9 +2175,9 @@ rxa_add_queue(struct event_eth_rx_adapter *rx_adapter,
 	queue_info->event_buf = new_rx_buf;
 
 	/* Allocate storage for adapter queue stats */
-	stats = rte_zmalloc_socket("rx_queue_stats",
+	stats = rte_zmalloc_numa("rx_queue_stats",
 				sizeof(*stats), 0,
-				rte_eth_dev_socket_id(eth_dev_id));
+				rte_eth_dev_numa_id(eth_dev_id));
 	if (stats == NULL) {
 		rte_free(new_rx_buf->events);
 		rte_free(new_rx_buf);
@@ -2236,10 +2236,10 @@ rxa_sw_add(struct event_eth_rx_adapter *rx_adapter, uint16_t eth_dev_id,
 
 	if (dev_info->rx_queue == NULL) {
 		dev_info->rx_queue =
-		    rte_zmalloc_socket(rx_adapter->mem_name,
+		    rte_zmalloc_numa(rx_adapter->mem_name,
 				       nb_rx_queues *
 				       sizeof(struct eth_rx_queue_info), 0,
-				       rx_adapter->socket_id);
+				       rx_adapter->numa_id);
 		if (dev_info->rx_queue == NULL)
 			return -ENOMEM;
 	}
@@ -2386,7 +2386,7 @@ rxa_create(uint8_t id, uint8_t dev_id,
 	struct eth_event_enqueue_buffer *buf;
 	struct rte_event *events;
 	int ret;
-	int socket_id;
+	int numa_id;
 	uint16_t i;
 	char mem_name[ETH_RX_ADAPTER_SERVICE_NAME_LEN];
 	const uint8_t default_rss_key[] = {
@@ -2415,29 +2415,29 @@ rxa_create(uint8_t id, uint8_t dev_id,
 		return -EEXIST;
 	}
 
-	socket_id = rte_event_dev_socket_id(dev_id);
+	numa_id = rte_event_dev_numa_id(dev_id);
 	snprintf(mem_name, ETH_RX_ADAPTER_MEM_NAME_LEN,
 		"rte_event_eth_rx_adapter_%d",
 		id);
 
-	rx_adapter = rte_zmalloc_socket(mem_name, sizeof(*rx_adapter),
-			RTE_CACHE_LINE_SIZE, socket_id);
+	rx_adapter = rte_zmalloc_numa(mem_name, sizeof(*rx_adapter),
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (rx_adapter == NULL) {
 		RTE_EDEV_LOG_ERR("failed to get mem for rx adapter");
 		return -ENOMEM;
 	}
 
 	rx_adapter->eventdev_id = dev_id;
-	rx_adapter->socket_id = socket_id;
+	rx_adapter->numa_id = numa_id;
 	rx_adapter->conf_cb = conf_cb;
 	rx_adapter->conf_arg = conf_arg;
 	rx_adapter->id = id;
 	TAILQ_INIT(&rx_adapter->vector_list);
 	strcpy(rx_adapter->mem_name, mem_name);
-	rx_adapter->eth_devices = rte_zmalloc_socket(rx_adapter->mem_name,
+	rx_adapter->eth_devices = rte_zmalloc_numa(rx_adapter->mem_name,
 					RTE_MAX_ETHPORTS *
 					sizeof(struct eth_device_info), 0,
-					socket_id);
+					numa_id);
 	rte_convert_rss_key((const uint32_t *)default_rss_key,
 			(uint32_t *)rx_adapter->rss_key_be,
 			    RTE_DIM(default_rss_key));
@@ -2460,9 +2460,9 @@ rxa_create(uint8_t id, uint8_t dev_id,
 		buf = &rx_adapter->event_enqueue_buffer;
 		buf->events_size = rxa_params->event_buf_size;
 
-		events = rte_zmalloc_socket(rx_adapter->mem_name,
+		events = rte_zmalloc_numa(rx_adapter->mem_name,
 					    buf->events_size * sizeof(*events),
-					    0, socket_id);
+					    0, numa_id);
 		if (events == NULL) {
 			RTE_EDEV_LOG_ERR("Failed to allocate memory "
 					 "for adapter event buffer");
@@ -2757,10 +2757,10 @@ rte_event_eth_rx_adapter_queue_add(uint8_t id,
 			return -ENOTSUP;
 		if (dev_info->rx_queue == NULL) {
 			dev_info->rx_queue =
-			    rte_zmalloc_socket(rx_adapter->mem_name,
+			    rte_zmalloc_numa(rx_adapter->mem_name,
 					dev_info->dev->data->nb_rx_queues *
 					sizeof(struct eth_rx_queue_info), 0,
-					rx_adapter->socket_id);
+					rx_adapter->numa_id);
 			if (dev_info->rx_queue == NULL)
 				return -ENOMEM;
 		}
@@ -2913,10 +2913,10 @@ rte_event_eth_rx_adapter_queues_add(uint8_t id, uint16_t eth_dev_id, int32_t rx_
 
 		if (dev_info->rx_queue == NULL) {
 			dev_info->rx_queue =
-				rte_zmalloc_socket(rx_adapter->mem_name,
+				rte_zmalloc_numa(rx_adapter->mem_name,
 						   dev_info->dev->data->nb_rx_queues *
 							   sizeof(struct eth_rx_queue_info),
-						   0, rx_adapter->socket_id);
+						   0, rx_adapter->numa_id);
 			if (dev_info->rx_queue == NULL)
 				return -ENOMEM;
 		}
diff --git a/lib/eventdev/rte_event_eth_tx_adapter.c b/lib/eventdev/rte_event_eth_tx_adapter.c
index b3edd9f6fb..c57d6b868c 100644
--- a/lib/eventdev/rte_event_eth_tx_adapter.c
+++ b/lib/eventdev/rte_event_eth_tx_adapter.c
@@ -139,8 +139,8 @@ struct __rte_cache_aligned txa_service_data {
 	rte_event_eth_tx_adapter_conf_cb conf_cb;
 	/* Configuration callback argument */
 	void *conf_arg;
-	/* socket id */
-	int socket_id;
+	/* NUMA node id */
+	int numa_id;
 	/* Per adapter EAL service */
 	int64_t service_id;
 	/* Memory allocation name */
@@ -197,7 +197,7 @@ txa_memzone_array_get(const char *name, unsigned int elt_size, int nb_elems)
 
 	mz = rte_memzone_lookup(name);
 	if (mz == NULL) {
-		mz = rte_memzone_reserve_aligned(name, sz, rte_socket_id(), 0,
+		mz = rte_memzone_reserve_aligned(name, sz, rte_numa_id(), 0,
 						 RTE_CACHE_LINE_SIZE);
 		if (mz == NULL) {
 			RTE_EDEV_LOG_ERR("failed to reserve memzone"
@@ -361,10 +361,10 @@ txa_service_ethdev_alloc(struct txa_service_data *txa)
 	if (txa->txa_ethdev && dev_count == txa->dev_count)
 		return 0;
 
-	txa_ethdev = rte_zmalloc_socket(txa->mem_name,
+	txa_ethdev = rte_zmalloc_numa(txa->mem_name,
 					dev_count * sizeof(*txa_ethdev),
 					0,
-					txa->socket_id);
+					txa->numa_id);
 	if (txa_ethdev == NULL) {
 		RTE_EDEV_LOG_ERR("Failed to alloc txa::txa_ethdev ");
 		return -ENOMEM;
@@ -401,10 +401,10 @@ txa_service_queue_array_alloc(struct txa_service_data *txa,
 		return 0;
 
 	nb_queue = txa->txa_ethdev[port_id].dev->data->nb_tx_queues;
-	tqi = rte_zmalloc_socket(txa->mem_name,
+	tqi = rte_zmalloc_numa(txa->mem_name,
 				nb_queue *
 				sizeof(struct txa_service_queue_info), 0,
-				txa->socket_id);
+				txa->numa_id);
 	if (tqi == NULL)
 		return -ENOMEM;
 	txa->txa_ethdev[port_id].queues = tqi;
@@ -456,7 +456,7 @@ txa_service_register(struct txa_service_data *txa)
 
 	memset(&service, 0, sizeof(service));
 	snprintf(service.name, TXA_SERVICE_NAME_LEN, "txa_%d", txa->id);
-	service.socket_id = txa->socket_id;
+	service.socket_id = txa->numa_id;
 	service.callback = txa_service_func;
 	service.callback_userdata = txa;
 	service.capabilities = RTE_SERVICE_CAP_MT_SAFE;
@@ -488,10 +488,10 @@ txa_service_tx_buf_alloc(struct txa_service_data *txa,
 	uint16_t port_id;
 
 	port_id = dev->data->port_id;
-	tb = rte_zmalloc_socket(txa->mem_name,
+	tb = rte_zmalloc_numa(txa->mem_name,
 				RTE_ETH_TX_BUFFER_SIZE(TXA_BATCH_SIZE),
 				0,
-				rte_eth_dev_socket_id(port_id));
+				rte_eth_dev_numa_id(port_id));
 	if (tb == NULL)
 		RTE_EDEV_LOG_ERR("Failed to allocate memory for tx buffer");
 	return tb;
@@ -740,14 +740,14 @@ txa_service_adapter_create_ext(uint8_t id, struct rte_eventdev *dev,
 			void *conf_arg)
 {
 	struct txa_service_data *txa;
-	int socket_id;
+	int numa_id;
 	char mem_name[TXA_SERVICE_NAME_LEN];
 	int ret;
 
 	if (conf_cb == NULL)
 		return -EINVAL;
 
-	socket_id = dev->data->socket_id;
+	numa_id = dev->data->numa_id;
 	snprintf(mem_name, sizeof(mem_name),
 		"rte_event_eth_txa_%d",
 		id);
@@ -756,9 +756,9 @@ txa_service_adapter_create_ext(uint8_t id, struct rte_eventdev *dev,
 	if (ret != 0)
 		return ret;
 
-	txa = rte_zmalloc_socket(mem_name,
+	txa = rte_zmalloc_numa(mem_name,
 				sizeof(*txa),
-				RTE_CACHE_LINE_SIZE, socket_id);
+				RTE_CACHE_LINE_SIZE, numa_id);
 	if (txa == NULL) {
 		RTE_EDEV_LOG_ERR("failed to get mem for tx adapter");
 		return -ENOMEM;
@@ -766,7 +766,7 @@ txa_service_adapter_create_ext(uint8_t id, struct rte_eventdev *dev,
 
 	txa->id = id;
 	txa->eventdev_id = dev->data->dev_id;
-	txa->socket_id = socket_id;
+	txa->numa_id = numa_id;
 	strlcpy(txa->mem_name, mem_name, sizeof(txa->mem_name));
 	txa->conf_cb = conf_cb;
 	txa->conf_arg = conf_arg;
diff --git a/lib/eventdev/rte_event_ring.c b/lib/eventdev/rte_event_ring.c
index 5718985486..2fc54e4948 100644
--- a/lib/eventdev/rte_event_ring.c
+++ b/lib/eventdev/rte_event_ring.c
@@ -26,14 +26,14 @@ rte_event_ring_init(struct rte_event_ring *r, const char *name,
 /* create the ring */
 RTE_EXPORT_SYMBOL(rte_event_ring_create)
 struct rte_event_ring *
-rte_event_ring_create(const char *name, unsigned int count, int socket_id,
+rte_event_ring_create(const char *name, unsigned int count, int numa_id,
 		unsigned int flags)
 {
-	rte_eventdev_trace_ring_create(name, count, socket_id, flags);
+	rte_eventdev_trace_ring_create(name, count, numa_id, flags);
 
 	return (struct rte_event_ring *)rte_ring_create_elem(name,
 						sizeof(struct rte_event),
-						count, socket_id, flags);
+						count, numa_id, flags);
 }
 
 
diff --git a/lib/eventdev/rte_event_ring.h b/lib/eventdev/rte_event_ring.h
index 2196022798..52a7f34416 100644
--- a/lib/eventdev/rte_event_ring.h
+++ b/lib/eventdev/rte_event_ring.h
@@ -271,9 +271,9 @@ rte_event_ring_free(struct rte_event_ring *r);
  *   usable space in the ring will be ``count - 1`` entries. If the flag
  *   ``RING_F_EXACT_SZ`` is set, the this can be any value up to the ring size
  *   limit - 1, and the usable space will be exactly that requested.
- * @param socket_id
- *   The *socket_id* argument is the socket identifier in case of
- *   NUMA. The value can be *SOCKET_ID_ANY* if there is no NUMA
+ * @param numa_id
+ *   The *numa_id* argument is the NUMA node ID in case of
+ *   NUMA. The value can be *RTE_NUMA_ID_ANY* if there is no NUMA
  *   constraint for the reserved zone.
  * @param flags
  *   An OR of the following:
@@ -298,7 +298,7 @@ rte_event_ring_free(struct rte_event_ring *r);
  *    - ENOMEM - no appropriate memory area found in which to create memzone
  */
 struct rte_event_ring *
-rte_event_ring_create(const char *name, unsigned int count, int socket_id, unsigned int flags)
+rte_event_ring_create(const char *name, unsigned int count, int numa_id, unsigned int flags)
 	__rte_malloc __rte_dealloc(rte_event_ring_free, 1);
 
 /**
diff --git a/lib/eventdev/rte_event_timer_adapter.c b/lib/eventdev/rte_event_timer_adapter.c
index a76d10f505..de33fd9f95 100644
--- a/lib/eventdev/rte_event_timer_adapter.c
+++ b/lib/eventdev/rte_event_timer_adapter.c
@@ -201,7 +201,7 @@ rte_event_timer_adapter_create_ext(
 	}
 	mz = rte_memzone_reserve(mz_name,
 				 sizeof(struct rte_event_timer_adapter_data),
-				 conf->socket_id, 0);
+				 conf->numa_id, 0);
 	if (mz == NULL)
 		/* rte_errno set by rte_memzone_reserve */
 		return NULL;
@@ -212,7 +212,7 @@ rte_event_timer_adapter_create_ext(
 	adapter->data->mz = mz;
 	adapter->data->event_dev_id = conf->event_dev_id;
 	adapter->data->id = adapter_id;
-	adapter->data->socket_id = conf->socket_id;
+	adapter->data->numa_id = conf->numa_id;
 	adapter->data->conf = *conf;  /* copy conf structure */
 
 	/* Query eventdev PMD for timer adapter capabilities and ops */
@@ -931,8 +931,8 @@ swtim_init(struct rte_event_timer_adapter *adapter)
 	char swtim_name[SWTIM_NAMESIZE];
 	snprintf(swtim_name, SWTIM_NAMESIZE, "swtim_%"PRIu8,
 			adapter->data->id);
-	sw = rte_zmalloc_socket(swtim_name, sizeof(*sw), RTE_CACHE_LINE_SIZE,
-			adapter->data->socket_id);
+	sw = rte_zmalloc_numa(swtim_name, sizeof(*sw), RTE_CACHE_LINE_SIZE,
+			adapter->data->numa_id);
 	if (sw == NULL) {
 		EVTIM_LOG_ERR("failed to allocate space for private data");
 		rte_errno = ENOMEM;
@@ -958,7 +958,7 @@ swtim_init(struct rte_event_timer_adapter *adapter)
 	flags = 0; /* pool is multi-producer, multi-consumer */
 	sw->tim_pool = rte_mempool_create(pool_name, pool_size,
 			sizeof(struct rte_timer), cache_size, 0, NULL, NULL,
-			NULL, NULL, adapter->data->socket_id, flags);
+			NULL, NULL, adapter->data->numa_id, flags);
 	if (sw->tim_pool == NULL) {
 		EVTIM_LOG_ERR("failed to create timer object mempool");
 		rte_errno = ENOMEM;
@@ -995,7 +995,7 @@ swtim_init(struct rte_event_timer_adapter *adapter)
 	memset(&service, 0, sizeof(service));
 	snprintf(service.name, RTE_SERVICE_NAME_MAX,
 		 "swtim_svc_%"PRIu8, adapter->data->id);
-	service.socket_id = adapter->data->socket_id;
+	service.socket_id = adapter->data->numa_id;
 	service.callback = swtim_service_func;
 	service.callback_userdata = adapter;
 	service.capabilities &= ~(RTE_SERVICE_CAP_MT_SAFE);
@@ -1429,8 +1429,8 @@ handle_ta_info(const char *cmd __rte_unused, const char *params,
 	rte_tel_data_add_dict_uint(d, "max_tmo_ns", adapter_info.max_tmo_ns);
 	rte_tel_data_add_dict_uint(d, "event_dev_id",
 				   adapter_info.conf.event_dev_id);
-	rte_tel_data_add_dict_uint(d, "socket_id",
-				   adapter_info.conf.socket_id);
+	rte_tel_data_add_dict_uint(d, "numa_id",
+				   adapter_info.conf.numa_id);
 	rte_tel_data_add_dict_uint(d, "clk_src", adapter_info.conf.clk_src);
 	rte_tel_data_add_dict_uint(d, "timer_tick_ns",
 				   adapter_info.conf.timer_tick_ns);
diff --git a/lib/eventdev/rte_event_timer_adapter.h b/lib/eventdev/rte_event_timer_adapter.h
index 215584b10b..8f9fae5f2e 100644
--- a/lib/eventdev/rte_event_timer_adapter.h
+++ b/lib/eventdev/rte_event_timer_adapter.h
@@ -165,8 +165,15 @@ struct rte_event_timer_adapter_conf {
 	/**< Event device identifier */
 	uint16_t timer_adapter_id;
 	/**< Event timer adapter identifier */
-	uint32_t socket_id;
-	/**< Identifier of socket from which to allocate memory for adapter */
+	union {
+		/** NUMA node ID from which to allocate memory for adapter */
+		uint32_t numa_id;
+		/**
+		 * Deprecated alias of numa_id.
+		 */
+		__rte_deprecated_msg("use numa_id")
+		uint32_t socket_id;
+	};
 	enum rte_event_timer_adapter_clk_src clk_src;
 	/**< Clock source for timer adapter */
 	uint64_t timer_tick_ns;
diff --git a/lib/eventdev/rte_event_vector_adapter.c b/lib/eventdev/rte_event_vector_adapter.c
index 9a839517c8..6222f1c907 100644
--- a/lib/eventdev/rte_event_vector_adapter.c
+++ b/lib/eventdev/rte_event_vector_adapter.c
@@ -253,7 +253,7 @@ rte_event_vector_adapter_create_ext(const struct rte_event_vector_adapter_conf *
 		goto error;
 	}
 	mz = rte_memzone_reserve(mz_name, sizeof(struct rte_event_vector_adapter_data),
-				 conf->socket_id, 0);
+				 conf->numa_id, 0);
 	if (mz == NULL) {
 		adapter->ops = NULL;
 		EVVEC_LOG_DBG("failed to reserve memzone for vector adapter");
@@ -267,7 +267,7 @@ rte_event_vector_adapter_create_ext(const struct rte_event_vector_adapter_conf *
 	adapter->data->mz = mz;
 	adapter->data->event_dev_id = conf->event_dev_id;
 	adapter->data->id = adapter->adapter_id;
-	adapter->data->socket_id = conf->socket_id;
+	adapter->data->numa_id = conf->numa_id;
 	adapter->data->conf = *conf;
 
 	if (!(caps & RTE_EVENT_VECTOR_ADAPTER_CAP_INTERNAL_PORT)) {
@@ -641,7 +641,7 @@ sw_vector_adapter_service_init(struct sw_vector_adapter_data *sw)
 	if (mz == NULL) {
 		mz = rte_memzone_reserve(SW_VECTOR_ADAPTER_SERVICE_FMT,
 					 sizeof(struct sw_vector_adapter_service_data),
-					 sw->adapter->data->socket_id, 0);
+					 sw->adapter->data->numa_id, 0);
 		if (mz == NULL) {
 			EVVEC_LOG_DBG("failed to reserve memzone for service");
 			return -ENOMEM;
@@ -650,7 +650,7 @@ sw_vector_adapter_service_init(struct sw_vector_adapter_data *sw)
 		memset(service_data, 0, sizeof(*service_data));
 
 		ring = rte_ring_create(SW_VECTOR_ADAPTER_SERVICE_FMT, SERVICE_RING_SZ,
-				       sw->adapter->data->socket_id, 0);
+				       sw->adapter->data->numa_id, 0);
 		if (ring == NULL) {
 			EVVEC_LOG_ERR("failed to create ring for service");
 			rte_memzone_free(mz);
@@ -662,7 +662,7 @@ sw_vector_adapter_service_init(struct sw_vector_adapter_data *sw)
 		snprintf(service.name, RTE_SERVICE_NAME_MAX, "%s", SW_VECTOR_ADAPTER_SERVICE_FMT);
 		service.callback = sw_vector_adapter_service_func;
 		service.callback_userdata = service_data;
-		service.socket_id = sw->adapter->data->socket_id;
+		service.socket_id = sw->adapter->data->numa_id;
 
 		ret = rte_service_component_register(&service, &service_data->service_id);
 		if (ret < 0) {
@@ -696,7 +696,7 @@ sw_vector_adapter_create(struct rte_event_vector_adapter *adapter)
 	struct rte_event ev;
 
 	snprintf(name, SW_VECTOR_ADAPTER_NAME, "sw_vector_%" PRIx32, adapter->data->id);
-	sw = rte_zmalloc_socket(name, sizeof(*sw), RTE_CACHE_LINE_SIZE, adapter->data->socket_id);
+	sw = rte_zmalloc_numa(name, sizeof(*sw), RTE_CACHE_LINE_SIZE, adapter->data->numa_id);
 	if (sw == NULL) {
 		EVVEC_LOG_ERR("failed to allocate space for private data");
 		rte_errno = ENOMEM;
diff --git a/lib/eventdev/rte_event_vector_adapter.h b/lib/eventdev/rte_event_vector_adapter.h
index e85c79010e..cc29aa4baa 100644
--- a/lib/eventdev/rte_event_vector_adapter.h
+++ b/lib/eventdev/rte_event_vector_adapter.h
@@ -136,8 +136,15 @@ extern "C" {
 struct rte_event_vector_adapter_conf {
 	uint8_t event_dev_id;
 	/**< Event device identifier */
-	uint32_t socket_id;
-	/**< Identifier of socket from which to allocate memory for adapter */
+	union {
+		/** NUMA node ID from which to allocate memory for adapter */
+		uint32_t numa_id;
+		/**
+		 * Deprecated alias of numa_id.
+		 */
+		__rte_deprecated_msg("use numa_id")
+		uint32_t socket_id;
+	};
 	struct rte_event ev;
 	/**<
 	 *  The values from the following event fields will be used when
diff --git a/lib/eventdev/rte_eventdev.c b/lib/eventdev/rte_eventdev.c
index 71de25a3ab..7426fa9e7f 100644
--- a/lib/eventdev/rte_eventdev.c
+++ b/lib/eventdev/rte_eventdev.c
@@ -80,18 +80,25 @@ rte_event_dev_get_dev_id(const char *name)
 	return -ENODEV;
 }
 
-RTE_EXPORT_SYMBOL(rte_event_dev_socket_id)
+RTE_EXPORT_SYMBOL(rte_event_dev_numa_id)
 int
-rte_event_dev_socket_id(uint8_t dev_id)
+rte_event_dev_numa_id(uint8_t dev_id)
 {
 	struct rte_eventdev *dev;
 
 	RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_eventdevs[dev_id];
 
-	rte_eventdev_trace_socket_id(dev_id, dev, dev->data->socket_id);
+	rte_eventdev_trace_numa_id(dev_id, dev, dev->data->numa_id);
+
+	return dev->data->numa_id;
+}
 
-	return dev->data->socket_id;
+RTE_EXPORT_SYMBOL(rte_event_dev_socket_id)
+int
+rte_event_dev_socket_id(uint8_t dev_id)
+{
+	return rte_event_dev_numa_id(dev_id);
 }
 
 RTE_EXPORT_SYMBOL(rte_event_dev_info_get)
@@ -1481,7 +1488,7 @@ RTE_EXPORT_SYMBOL(rte_event_vector_pool_create)
 struct rte_mempool *
 rte_event_vector_pool_create(const char *name, unsigned int n,
 			     unsigned int cache_size, uint16_t nb_elem,
-			     int socket_id)
+			     int numa_id)
 {
 	const char *mp_ops_name;
 	struct rte_mempool *mp;
@@ -1497,7 +1504,7 @@ rte_event_vector_pool_create(const char *name, unsigned int n,
 
 	elt_sz =
 		sizeof(struct rte_event_vector) + (nb_elem * sizeof(uintptr_t));
-	mp = rte_mempool_create_empty(name, n, elt_sz, cache_size, 0, socket_id,
+	mp = rte_mempool_create_empty(name, n, elt_sz, cache_size, 0, numa_id,
 				      0);
 	if (mp == NULL)
 		return NULL;
@@ -1626,7 +1633,7 @@ rte_event_dev_close(uint8_t dev_id)
 
 static inline int
 eventdev_data_alloc(uint8_t dev_id, struct rte_eventdev_data **data,
-		    int socket_id)
+		    int numa_id)
 {
 	char mz_name[RTE_EVENTDEV_NAME_MAX_LEN];
 	const struct rte_memzone *mz;
@@ -1640,7 +1647,7 @@ eventdev_data_alloc(uint8_t dev_id, struct rte_eventdev_data **data,
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		mz = rte_memzone_reserve(mz_name,
 				sizeof(struct rte_eventdev_data),
-				socket_id, 0);
+				numa_id, 0);
 	} else
 		mz = rte_memzone_lookup(mz_name);
 
@@ -1674,7 +1681,7 @@ eventdev_find_free_device_index(void)
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_event_pmd_allocate)
 struct rte_eventdev *
-rte_event_pmd_allocate(const char *name, int socket_id)
+rte_event_pmd_allocate(const char *name, int numa_id)
 {
 	struct rte_eventdev *eventdev;
 	uint8_t dev_id;
@@ -1697,7 +1704,7 @@ rte_event_pmd_allocate(const char *name, int socket_id)
 		struct rte_eventdev_data *eventdev_data = NULL;
 
 		int retval =
-			eventdev_data_alloc(dev_id, &eventdev_data, socket_id);
+			eventdev_data_alloc(dev_id, &eventdev_data, numa_id);
 
 		if (retval < 0 || eventdev_data == NULL)
 			return NULL;
@@ -1710,7 +1717,7 @@ rte_event_pmd_allocate(const char *name, int socket_id)
 				RTE_EVENTDEV_NAME_MAX_LEN);
 
 			eventdev->data->dev_id = dev_id;
-			eventdev->data->socket_id = socket_id;
+			eventdev->data->numa_id = numa_id;
 			eventdev->data->dev_started = 0;
 		}
 
@@ -1838,7 +1845,7 @@ handle_dev_info(const char *cmd __rte_unused,
 	rte_tel_data_add_dict_string(d, "dev_driver", dev->device->driver->name);
 	rte_tel_data_add_dict_string(d, "state",
 		dev->data->dev_started ? "started" : "stopped");
-	rte_tel_data_add_dict_int(d, "socket_id", dev->data->socket_id);
+	rte_tel_data_add_dict_int(d, "numa_id", dev->data->numa_id);
 	rte_tel_data_add_dict_int(d, "nb_queues", dev->data->nb_queues);
 	rte_tel_data_add_dict_int(d, "nb_ports", dev->data->nb_ports);
 	rte_tel_data_add_dict_uint_hex(d, "capabilities", dev->data->event_dev_cap,
diff --git a/lib/eventdev/rte_eventdev.h b/lib/eventdev/rte_eventdev.h
index 34b1804285..1aaae6469b 100644
--- a/lib/eventdev/rte_eventdev.h
+++ b/lib/eventdev/rte_eventdev.h
@@ -580,9 +580,25 @@ rte_event_dev_count(void);
 int
 rte_event_dev_get_dev_id(const char *name);
 
+/**
+ * Return the NUMA node to which a device is connected.
+ *
+ * @param dev_id
+ *   The identifier of the device.
+ * @return
+ *   The NUMA node ID to which the device is connected or
+ *   a default of zero if the NUMA node could not be determined.
+ *   -EINVAL on error, where the given dev_id value does not
+ *   correspond to any event device.
+ */
+int
+rte_event_dev_numa_id(uint8_t dev_id);
+
 /**
  * Return the NUMA socket to which a device is connected.
  *
+ * This is a legacy alias of rte_event_dev_numa_id().
+ *
  * @param dev_id
  *   The identifier of the device.
  * @return
@@ -2554,9 +2570,9 @@ int rte_event_dev_selftest(uint8_t dev_id);
  *   details.
  * @param nb_elem
  *   The number of elements that a single event vector should be able to hold.
- * @param socket_id
- *   The socket identifier where the memory should be allocated. The
- *   value can be *SOCKET_ID_ANY* if there is no NUMA constraint for the
+ * @param numa_id
+ *   The NUMA node ID where the memory should be allocated. The
+ *   value can be *RTE_NUMA_ID_ANY* if there is no NUMA constraint for the
  *   reserved zone
  *
  * @return
@@ -2573,7 +2589,7 @@ int rte_event_dev_selftest(uint8_t dev_id);
 struct rte_mempool *
 rte_event_vector_pool_create(const char *name, unsigned int n,
 			     unsigned int cache_size, uint16_t nb_elem,
-			     int socket_id);
+			     int numa_id);
 
 #include <rte_eventdev_core.h>
 
-- 
2.55.0

