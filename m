Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E57606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:47:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6F8540EAB;
	Fri, 23 Oct 2026 15:44:38 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id CD1A140E3B
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:26 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AC0E9200034;
 Fri, 23 Oct 2026 15:44:26 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 26570200020;
 Fri, 23 Oct 2026 15:44:26 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C615E18000B1;
 Fri, 23 Oct 2026 21:44:24 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 31/65] event/dpaa2: rework event port model and DPCI
 handling
Date: Fri, 23 Oct 2026 19:13:11 +0530
Message-ID: <20261023134346.37727-32-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
References: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
 <20261023134346.37727-1-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jun Yang <jun.yang@nxp.com>

Rework the DPAA2 eventdev port model so that each event port owns a
dedicated DPIO/software portal instead of relying on the per-lcore
DPIO of whatever thread happens to call enqueue/dequeue. This removes
the lazy link-on-first-burst logic and its error-unwind paths, and
makes port behaviour independent of the calling lcore.

Main changes:

- Dedicated portal per event port:
  rte_dpaa2_alloc_dpio_device() is called at port setup and stored in
  struct dpaa2_port. enqueue/dequeue use portal->dpio_dev directly and
  reject calls on a port that was never set up or has no linked queue.
  An optional atomic port mode (RTE_DPAA2_EVENT_PORT_CFG_ATOMIC) takes
  a per-port spinlock so several lcores can share one port; otherwise
  the port records its affine lcore and warns on cross-lcore use.

- Dynamic link and unlink:
  port_link now attaches DPCON static dequeue channels at link time
  (unlinking any previous queues first), validates queue ownership,
  and unwinds cleanly on failure. port_unlink removes the channels,
  compacts the evq_info array, and is used by port_release so a port
  is properly torn down. The redundant *_queue_del_all() and per-error
  detach unwind paths are removed.

- Per-DPIO held-buffer tracking:
  The per-lcore DQRR bookkeeping globals (DPAA2_PER_LCORE_DQRR_*) are
  replaced by a dpaa2_held_bufs structure in struct dpaa2_dpio_dev, so
  atomic-queue DQRR state follows the portal that owns it. All dqrr
  callbacks now take struct dpaa2_dpio_dev * instead of struct
  qbman_swp *; the dpaa2_sec and net/dpaa2 callbacks are updated to
  match.

- Event object allocation from a mempool:
  Each DPCI Rx queue gets an env_pool mempool of rte_event objects.
  enqueue takes an event from the peer queue's pool and the process
  callbacks return it, replacing the per-event rte_malloc/rte_free on
  the hot path.

- Flush on stop:
  dpaa2_eventdev_stop() now drains each linked port and calls the
  registered dev_stop_flush callback for every leftover event.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_dpci.c    |  26 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c    |   5 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.h    |   2 +-
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h     |   4 +-
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c |  32 +-
 drivers/event/dpaa2/dpaa2_eventdev.c        | 712 ++++++++++----------
 drivers/event/dpaa2/dpaa2_eventdev.h        |  13 +-
 drivers/net/dpaa2/dpaa2_ethdev.c            |  22 +-
 drivers/net/dpaa2/dpaa2_ethdev.h            |  26 +-
 drivers/net/dpaa2/dpaa2_rxtx.c              |  69 +-
 drivers/net/dpaa2/rte_pmd_dpaa2.h           |   2 +
 11 files changed, 464 insertions(+), 449 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c
index f2bfb2a75c..f796875010 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c
@@ -56,6 +56,8 @@ dpaa2_create_dpci_device(int vdev_fd __rte_unused,
 	struct dpci_rx_queue_attr rx_attr;
 	struct dpci_tx_queue_attr tx_attr;
 	int ret, i, dpci_id = obj->object_id;
+	char pool_name[64];
+	uint64_t pool_size;
 
 	memset(&attr, 0, sizeof(struct dpci_attr));
 	memset(&peer_attr, 0, sizeof(struct dpci_peer_attr));
@@ -118,6 +120,17 @@ dpaa2_create_dpci_device(int vdev_fd __rte_unused,
 			goto queue_err;
 		}
 		dpci_node->rx_queue[i].fqid = rx_attr.fqid;
+		snprintf(pool_name, sizeof(pool_name), "dpci%d_qid%d_env", dpci_id, i);
+		pool_size = RTE_ALIGN(sizeof(struct rte_event), RTE_CACHE_LINE_SIZE);
+		dpci_node->rx_queue[i].env_pool = rte_mempool_create(pool_name,
+			1024, pool_size, 512, 0, NULL, NULL, NULL, NULL,
+			SOCKET_ID_ANY, 0);
+		if (!dpci_node->rx_queue[i].env_pool) {
+			DPAA2_BUS_ERR("Rx queue event pool create(%s) failed",
+				pool_name);
+			ret = -ENOMEM;
+			goto queue_err;
+		}
 	}
 
 	/* Enable the device */
@@ -177,8 +190,13 @@ dpaa2_create_dpci_device(int vdev_fd __rte_unused,
 		rte_free(dpci_node->tx_queue);
 	dpci_disable(&dpci_node->dpci, CMD_PRI_LOW, dpci_node->token);
 queue_err:
-	if (dpci_node->rx_queue)
+	if (dpci_node->rx_queue) {
+		for (i = 0; i < dpci_node->rx_queue_num; i++) {
+			if (dpci_node->rx_queue[i].env_pool)
+				rte_mempool_free(dpci_node->rx_queue[i].env_pool);
+		}
 		rte_free(dpci_node->rx_queue);
+	}
 open_err:
 	dpci_close(&dpci_node->dpci, CMD_PRI_LOW, dpci_node->token);
 
@@ -223,11 +241,16 @@ static void
 dpaa2_close_dpci_device(int object_id)
 {
 	struct dpaa2_dpci_dev *dpci_dev = NULL;
+	int i;
 
 	dpci_dev = get_dpci_from_id((uint32_t)object_id);
 
 	if (dpci_dev) {
 		dpci_disable(&dpci_dev->dpci, CMD_PRI_LOW, dpci_dev->token);
+		for (i = 0; i < dpci_dev->rx_queue_num; i++) {
+			if (dpci_dev->rx_queue[i].env_pool)
+				rte_mempool_free(dpci_dev->rx_queue[i].env_pool);
+		}
 		rte_free(dpci_dev->rx_queue);
 		rte_free(dpci_dev->tx_queue);
 		dpci_close(&dpci_dev->dpci, CMD_PRI_LOW, dpci_dev->token);
@@ -285,6 +308,7 @@ rte_dpaa2_dpci_link_attach(struct dpaa2_dpci_dev *dpci_dev,
 		return ret;
 	}
 	dpci_dev->rx_queue[i].cb = rx_cb;
+	dpci_dev->tx_queue[i].env_pool = peer_dpci->rx_queue[i].env_pool;
 
 	if (txq)
 		*txq = &dpci_dev->tx_queue[i];
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index 63e1660686..e88334088b 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -314,6 +314,7 @@ static void dpaa2_put_qbman_swp(struct dpaa2_dpio_dev *dpio_dev)
 		 * armed: intr_deinit returns early if intr is not enabled.
 		 */
 		dpaa2_dpio_intr_deinit(dpio_dev);
+		dpio_dev->cpu_affine = -1;
 		rte_atomic_store_explicit(&dpio_dev->ref_count, 0,
 					  rte_memory_order_release);
 	}
@@ -357,6 +358,7 @@ static struct dpaa2_dpio_dev *dpaa2_get_qbman_swp(bool ethrx)
 			return NULL;
 		}
 	}
+	dpio_dev->cpu_affine = cpu_id;
 
 	ret = pthread_setspecific(dpaa2_portal_key, (void *)dpio_dev);
 	if (ret) {
@@ -424,7 +426,7 @@ static void dpaa2_portal_finish(void *arg)
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_alloc_dpio_device)
 struct dpaa2_dpio_dev *
-rte_dpaa2_alloc_dpio_device(void)
+rte_dpaa2_alloc_dpio_device(int32_t cpu_affine)
 {
 	struct dpaa2_dpio_dev *dpio_dev = NULL;
 	uint16_t expected = 0;
@@ -452,6 +454,7 @@ rte_dpaa2_alloc_dpio_device(void)
 		return NULL;
 	}
 #endif
+	dpio_dev->cpu_affine = cpu_affine;
 
 	return dpio_dev;
 }
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
index 59a9d11955..ae0f5993d6 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
@@ -72,7 +72,7 @@ dpaa2_free_eq_descriptors(void);
 
 __rte_internal
 struct dpaa2_dpio_dev *
-rte_dpaa2_alloc_dpio_device(void);
+rte_dpaa2_alloc_dpio_device(int32_t cpu_affine);
 
 __rte_internal
 void
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index ed82eb123a..f80abffb40 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -136,6 +136,7 @@ struct dpaa2_dpio_dev {
 	int32_t	epoll_fd; /**< File descriptor created for interrupt polling */
 	int32_t hw_id; /**< An unique ID of this DPIO device instance */
 	uint8_t intr_enabled; /**< DQRI portal interrupt already set up */
+	int32_t cpu_affine;
 	uint16_t ethrx_intr_refcnt; /**< rx queues currently armed on this portal */
 	struct dpaa2_portal_dqrr dpaa2_held_bufs;
 };
@@ -159,7 +160,7 @@ struct queue_storage_info_t {
 
 struct dpaa2_queue;
 
-typedef void (dpaa2_queue_cb_dqrr_t)(struct qbman_swp *swp,
+typedef void (dpaa2_queue_cb_dqrr_t)(struct dpaa2_dpio_dev *dpio_dev,
 		const struct qbman_fd *fd,
 		const struct qbman_result *dq,
 		struct dpaa2_queue *rxq,
@@ -189,6 +190,7 @@ struct __rte_cache_aligned dpaa2_queue {
 	void *cfg;
 	uint8_t options;
 	struct rte_event ev;
+	struct rte_mempool *env_pool;
 	dpaa2_queue_cb_dqrr_t *cb;
 	dpaa2_queue_cb_eqresp_free_t *cb_eqresp_free;
 	struct dpaa2_bp_info *bp_array;
diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index 6e759dd821..e34ca884fe 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -4098,13 +4098,12 @@ void dpaa2_sec_stats_reset(struct rte_cryptodev *dev)
 }
 
 static void __rte_hot
-dpaa2_sec_process_parallel_event(struct qbman_swp *swp,
-				 const struct qbman_fd *fd,
-				 const struct qbman_result *dq,
-				 struct dpaa2_queue *rxq,
-				 struct rte_event *ev)
+dpaa2_sec_process_parallel_event(struct dpaa2_dpio_dev *dpio_dev,
+	const struct qbman_fd *fd, const struct qbman_result *dq,
+	struct dpaa2_queue *rxq, struct rte_event *ev)
 {
 	struct dpaa2_sec_qp *qp;
+	struct qbman_swp *swp = dpio_dev->sw_portal;
 
 	qp = container_of(rxq, struct dpaa2_sec_qp, rx_vq);
 	ev->flow_id = rxq->ev.flow_id;
@@ -4120,11 +4119,9 @@ dpaa2_sec_process_parallel_event(struct qbman_swp *swp,
 }
 
 static void
-dpaa2_sec_process_atomic_event(struct qbman_swp *swp __rte_unused,
-				 const struct qbman_fd *fd,
-				 const struct qbman_result *dq,
-				 struct dpaa2_queue *rxq,
-				 struct rte_event *ev)
+dpaa2_sec_process_atomic_event(struct dpaa2_dpio_dev *dpio_dev,
+	const struct qbman_fd *fd, const struct qbman_result *dq,
+	struct dpaa2_queue *rxq, struct rte_event *ev)
 {
 	uint8_t dqrr_index;
 	struct dpaa2_sec_qp *qp;
@@ -4142,21 +4139,20 @@ dpaa2_sec_process_atomic_event(struct qbman_swp *swp __rte_unused,
 	crypto_op = dpaa2_sec_fd_to_mbuf(fd, qp);
 	dqrr_index = qbman_get_dqrr_idx(dq);
 	*dpaa2_seqn(crypto_op->sym->m_src) = QBMAN_ENQUEUE_FLAG_DCA | dqrr_index;
-	DPAA2_PER_LCORE_DQRR_SIZE++;
-	DPAA2_PER_LCORE_DQRR_HELD |= UINT64_C(1) << dqrr_index;
-	DPAA2_PER_LCORE_DQRR_MBUF(dqrr_index) = crypto_op->sym->m_src;
+	dpio_dev->dpaa2_held_bufs.dqrr_size++;
+	dpio_dev->dpaa2_held_bufs.dqrr_held |= UINT64_C(1) << dqrr_index;
+	dpio_dev->dpaa2_held_bufs.mbuf[dqrr_index] = crypto_op->sym->m_src;
 	ev->event_ptr = crypto_op;
 }
 
 static void __rte_hot
-dpaa2_sec_process_ordered_event(struct qbman_swp *swp,
-				const struct qbman_fd *fd,
-				const struct qbman_result *dq,
-				struct dpaa2_queue *rxq,
-				struct rte_event *ev)
+dpaa2_sec_process_ordered_event(struct dpaa2_dpio_dev *dpio_dev,
+	const struct qbman_fd *fd, const struct qbman_result *dq,
+	struct dpaa2_queue *rxq, struct rte_event *ev)
 {
 	struct rte_crypto_op *crypto_op;
 	struct dpaa2_sec_qp *qp;
+	struct qbman_swp *swp = dpio_dev->sw_portal;
 
 	qp = container_of(rxq, struct dpaa2_sec_qp, rx_vq);
 	ev->flow_id = rxq->ev.flow_id;
diff --git a/drivers/event/dpaa2/dpaa2_eventdev.c b/drivers/event/dpaa2/dpaa2_eventdev.c
index 28ed07bd97..03016d2a12 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev.c
@@ -51,66 +51,66 @@
 
 #define DPAA2_EV_TX_RETRY_COUNT 10000
 
+static __rte_always_inline struct dpaa2_dpio_dev *
+dpaa2_event_portal_io_prepare(struct dpaa2_port *dpaa2_portal)
+{
+	struct dpaa2_dpio_dev *dpio_dev;
+
+	if (unlikely(!dpaa2_portal->dpio_dev)) {
+		DPAA2_EVENTDEV_ERR("Event port%d not setup", dpaa2_portal->port_id);
+		return NULL;
+	}
+
+	if (unlikely(!dpaa2_portal->num_linked_evq)) {
+		DPAA2_EVENTDEV_WARN("Event port%d no queue linked",
+			dpaa2_portal->port_id);
+		rte_delay_us(10000);
+		return NULL;
+	}
+
+	dpio_dev = dpaa2_portal->dpio_dev;
+
+	if (unlikely(!dpaa2_portal->port_atomic &&
+		!rte_atomic_load_explicit(&dpaa2_portal->flushing,
+		rte_memory_order_relaxed)) &&
+		dpio_dev->cpu_affine != (int32_t)rte_lcore_id()) {
+		DPAA2_EVENTDEV_DEBUG("Event port%d affine CPU from %d->%d",
+			dpaa2_portal->port_id, dpio_dev->cpu_affine, rte_lcore_id());
+		dpio_dev->cpu_affine = rte_lcore_id();
+	}
+
+	return dpio_dev;
+}
+
 static uint16_t
 dpaa2_eventdev_enqueue_burst(void *port, const struct rte_event ev[],
-			     uint16_t nb_events)
+	uint16_t nb_events)
 {
 	struct dpaa2_port *dpaa2_portal = port;
 	struct dpaa2_dpio_dev *dpio_dev;
 	struct rte_eventdev *eventdev = dpaa2_portal->eventdev;
 	struct dpaa2_eventdev *priv = eventdev->data->dev_private;
 	struct dpaa2_eventq *evq_info;
-	uint32_t queue_id, retry_count;
+	uint32_t queue_id, retry_count, loop, frames_to_send, i;
 	struct qbman_swp *swp;
 	struct qbman_fd fd_arr[MAX_TX_RING_SLOTS];
-	uint32_t loop, frames_to_send;
 	struct qbman_eq_desc eqdesc[MAX_TX_RING_SLOTS];
 	uint16_t num_tx = 0;
-	int i, n, ret;
-	uint8_t channel_index;
+	int ret;
+	uint8_t dqrr_index;
 	const struct rte_event *event;
-	struct dpaa2_queue *dpci_txq;
-
-	if (unlikely(!DPAA2_PER_LCORE_DPIO)) {
-		/* Affine current thread context to a qman portal */
-		ret = dpaa2_affine_qbman_swp();
-		if (ret < 0) {
-			DPAA2_EVENTDEV_ERR(
-				"Failed to allocate IO portal, tid: %d",
-				rte_gettid());
-			return 0;
-		}
-	}
-	/* todo - dpaa2_portal shall have dpio_dev - no per thread variable */
-	dpio_dev = DPAA2_PER_LCORE_DPIO;
-	swp = DPAA2_PER_LCORE_PORTAL;
+	struct dpaa2_queue *dpci_txq[MAX_TX_RING_SLOTS];
+	struct rte_event *ev_tx[MAX_TX_RING_SLOTS];
 
-	if (likely(dpaa2_portal->is_port_linked))
-		goto skip_linking;
+	if (unlikely(dpaa2_portal->port_atomic))
+		rte_spinlock_lock(&dpaa2_portal->port_lock);
 
-	/* Create mapping between portal and channel to receive packets */
-	for (i = 0; i < DPAA2_EVENT_MAX_QUEUES; i++) {
-		evq_info = &dpaa2_portal->evq_info[i];
-		if (!evq_info->event_port)
-			continue;
+	dpio_dev = dpaa2_event_portal_io_prepare(dpaa2_portal);
+	if (!dpio_dev)
+		goto quit;
 
-		ret = dpio_add_static_dequeue_channel(dpio_dev->dpio,
-						      CMD_PRI_LOW,
-						      dpio_dev->token,
-						      evq_info->dpcon->dpcon_id,
-						      &channel_index);
-		if (ret < 0) {
-			DPAA2_EVENTDEV_ERR(
-				"Static dequeue config failed: err(%d)", ret);
-			goto err;
-		}
+	swp = dpio_dev->sw_portal;
 
-		qbman_swp_push_set(swp, channel_index, 1);
-		evq_info->dpcon->channel_index = channel_index;
-	}
-	dpaa2_portal->is_port_linked = true;
-
-skip_linking:
 	while (nb_events) {
 		frames_to_send = (nb_events > dpaa2_eqcr_size) ?
 			dpaa2_eqcr_size : nb_events;
@@ -133,23 +133,27 @@ dpaa2_eventdev_enqueue_burst(void *port, const struct rte_event ev[],
 				ret = -ENOTSUP;
 				goto send_partial;
 			}
-			dpci_txq = evq_info->dpci_txqs[event->sched_type];
+			dpci_txq[loop] = evq_info->dpci_txqs[event->sched_type];
+
+			ret = rte_mempool_get(dpci_txq[loop]->env_pool, (void **)&ev_tx[loop]);
+			if (ret) {
+				DPAA2_EVENTDEV_ERR("Allocate event object failed from %s",
+					dpci_txq[loop]->env_pool->name);
+				goto send_partial;
+			}
 
 			/* Prepare enqueue descriptor */
 			qbman_eq_desc_clear(&eqdesc[loop]);
-			qbman_eq_desc_set_fq(&eqdesc[loop], dpci_txq->fqid);
+			qbman_eq_desc_set_fq(&eqdesc[loop], dpci_txq[loop]->fqid);
 			qbman_eq_desc_set_no_orp(&eqdesc[loop], 0);
 			qbman_eq_desc_set_response(&eqdesc[loop], 0, 0);
 
-			if (event->sched_type == RTE_SCHED_TYPE_ATOMIC
-				&& *dpaa2_seqn(event->mbuf)) {
-				uint8_t dqrr_index =
-					*dpaa2_seqn(event->mbuf) - 1;
-
-				qbman_eq_desc_set_dca(&eqdesc[loop], 1,
-						      dqrr_index, 0);
-				DPAA2_PER_LCORE_DQRR_SIZE--;
-				DPAA2_PER_LCORE_DQRR_HELD &= ~(1 << dqrr_index);
+			if (event->sched_type == RTE_SCHED_TYPE_ATOMIC &&
+				*dpaa2_seqn(event->mbuf)) {
+				dqrr_index = *dpaa2_seqn(event->mbuf) - 1;
+				qbman_eq_desc_set_dca(&eqdesc[loop], 1, dqrr_index, 0);
+				dpio_dev->dpaa2_held_bufs.dqrr_size--;
+				dpio_dev->dpaa2_held_bufs.dqrr_held &= ~(1 << dqrr_index);
 			}
 
 			memset(&fd_arr[loop], 0, sizeof(struct qbman_fd));
@@ -158,23 +162,13 @@ dpaa2_eventdev_enqueue_burst(void *port, const struct rte_event ev[],
 			 * todo - need to align with hw context data
 			 * to avoid copy
 			 */
-			struct rte_event *ev_temp = rte_malloc(NULL,
-						sizeof(struct rte_event), 0);
-
-			if (!ev_temp) {
-				if (!loop)
-					return num_tx;
-				frames_to_send = loop;
-				DPAA2_EVENTDEV_ERR(
-					"Unable to allocate event object");
-				goto send_partial;
-			}
-			rte_memcpy(ev_temp, event, sizeof(struct rte_event));
-			DPAA2_SET_FD_ADDR((&fd_arr[loop]), (size_t)ev_temp);
-			DPAA2_SET_FD_LEN((&fd_arr[loop]),
-					 sizeof(struct rte_event));
+
+			rte_memcpy(ev_tx[loop], event, sizeof(struct rte_event));
+			DPAA2_SET_FD_ADDR((&fd_arr[loop]), (size_t)ev_tx[loop]);
+			DPAA2_SET_FD_LEN((&fd_arr[loop]), sizeof(struct rte_event));
 		}
 send_partial:
+		frames_to_send = loop;
 		loop = 0;
 		retry_count = 0;
 		while (loop < frames_to_send) {
@@ -186,7 +180,9 @@ dpaa2_eventdev_enqueue_burst(void *port, const struct rte_event ev[],
 				if (retry_count > DPAA2_EV_TX_RETRY_COUNT) {
 					num_tx += loop;
 					nb_events -= loop;
-					return num_tx;
+					for (i = loop; i < frames_to_send; i++)
+						rte_mempool_put(dpci_txq[i]->env_pool, ev_tx[i]);
+					goto quit;
 				}
 			} else {
 				loop += ret;
@@ -197,19 +193,10 @@ dpaa2_eventdev_enqueue_burst(void *port, const struct rte_event ev[],
 		nb_events -= loop;
 	}
 
+quit:
+	if (dpaa2_portal->port_atomic)
+		rte_spinlock_unlock(&dpaa2_portal->port_lock);
 	return num_tx;
-err:
-	for (n = 0; n < i; n++) {
-		evq_info = &dpaa2_portal->evq_info[n];
-		if (!evq_info->event_port)
-			continue;
-		qbman_swp_push_set(swp, evq_info->dpcon->channel_index, 0);
-		dpio_remove_static_dequeue_channel(dpio_dev->dpio, 0,
-						dpio_dev->token,
-						evq_info->dpcon->dpcon_id);
-	}
-	return 0;
-
 }
 
 static void dpaa2_eventdev_dequeue_wait(uint64_t timeout_ticks)
@@ -223,109 +210,72 @@ static void dpaa2_eventdev_dequeue_wait(uint64_t timeout_ticks)
 			 &epoll_ev, 1, timeout_ticks);
 }
 
-static void dpaa2_eventdev_process_parallel(struct qbman_swp *swp,
-					    const struct qbman_fd *fd,
-					    const struct qbman_result *dq,
-					    struct dpaa2_queue *rxq,
-					    struct rte_event *ev)
+static void dpaa2_eventdev_process_parallel(struct dpaa2_dpio_dev *dpio_dev,
+	const struct qbman_fd *fd, const struct qbman_result *dq,
+	struct dpaa2_queue *rxq, struct rte_event *ev)
 {
-	struct rte_event *ev_temp =
-		(struct rte_event *)(size_t)DPAA2_GET_FD_ADDR(fd);
+	struct rte_event *rx_ev = (void *)DPAA2_GET_FD_ADDR(fd);
+	struct qbman_swp *swp = dpio_dev->sw_portal;
 
-	RTE_SET_USED(rxq);
-
-	*ev = *ev_temp;
-	rte_free(ev_temp);
+	rte_memcpy(ev, rx_ev, sizeof(struct rte_event));
+	rte_mempool_put(rxq->env_pool, rx_ev);
 
 	qbman_swp_dqrr_consume(swp, dq);
 }
 
-static void dpaa2_eventdev_process_atomic(struct qbman_swp *swp,
-					  const struct qbman_fd *fd,
-					  const struct qbman_result *dq,
-					  struct dpaa2_queue *rxq,
-					  struct rte_event *ev)
+static void dpaa2_eventdev_process_atomic(struct dpaa2_dpio_dev *dpio_dev,
+	const struct qbman_fd *fd, const struct qbman_result *dq,
+	struct dpaa2_queue *rxq, struct rte_event *ev)
 {
-	struct rte_event *ev_temp =
-		(struct rte_event *)(size_t)DPAA2_GET_FD_ADDR(fd);
+	struct rte_event *rx_ev = (void *)DPAA2_GET_FD_ADDR(fd);
 	uint8_t dqrr_index = qbman_get_dqrr_idx(dq);
 
-	RTE_SET_USED(swp);
-	RTE_SET_USED(rxq);
-
-	*ev = *ev_temp;
-	rte_free(ev_temp);
+	rte_memcpy(ev, rx_ev, sizeof(struct rte_event));
+	rte_mempool_put(rxq->env_pool, rx_ev);
 	*dpaa2_seqn(ev->mbuf) = dqrr_index + 1;
-	DPAA2_PER_LCORE_DQRR_SIZE++;
-	DPAA2_PER_LCORE_DQRR_HELD |= 1 << dqrr_index;
-	DPAA2_PER_LCORE_DQRR_MBUF(dqrr_index) = ev->mbuf;
+	dpio_dev->dpaa2_held_bufs.dqrr_size++;
+	dpio_dev->dpaa2_held_bufs.dqrr_held |= UINT64_C(1) << dqrr_index;
+	dpio_dev->dpaa2_held_bufs.mbuf[dqrr_index] = ev->mbuf;
 }
 
 static uint16_t
 dpaa2_eventdev_dequeue_burst(void *port, struct rte_event ev[],
-			     uint16_t nb_events, uint64_t timeout_ticks)
+	uint16_t nb_events, uint64_t timeout_ticks)
 {
 	const struct qbman_result *dq;
-	struct dpaa2_dpio_dev *dpio_dev = NULL;
+	struct dpaa2_dpio_dev *dpio_dev;
 	struct dpaa2_port *dpaa2_portal = port;
-	struct dpaa2_eventq *evq_info;
 	struct qbman_swp *swp;
 	const struct qbman_fd *fd;
 	struct dpaa2_queue *rxq;
-	int num_pkts = 0, ret, i = 0, n;
-	uint8_t channel_index;
+	uint16_t num_pkts = 0, i = 0;
 
-	if (unlikely(!DPAA2_PER_LCORE_DPIO)) {
-		/* Affine current thread context to a qman portal */
-		ret = dpaa2_affine_qbman_swp();
-		if (ret < 0) {
-			DPAA2_EVENTDEV_ERR(
-				"Failed to allocate IO portal, tid: %d",
-				rte_gettid());
-			return 0;
-		}
-	}
+	if (unlikely(dpaa2_portal->port_atomic))
+		rte_spinlock_lock(&dpaa2_portal->port_lock);
 
-	dpio_dev = DPAA2_PER_LCORE_DPIO;
-	swp = DPAA2_PER_LCORE_PORTAL;
+	dpio_dev = dpaa2_event_portal_io_prepare(dpaa2_portal);
+	if (!dpio_dev)
+		goto quit;
 
-	if (likely(dpaa2_portal->is_port_linked))
-		goto skip_linking;
+	swp = dpio_dev->sw_portal;
 
-	/* Create mapping between portal and channel to receive packets */
-	for (i = 0; i < DPAA2_EVENT_MAX_QUEUES; i++) {
-		evq_info = &dpaa2_portal->evq_info[i];
-		if (!evq_info->event_port)
-			continue;
+	/* Check if there are atomic contexts to be released */
 
-		ret = dpio_add_static_dequeue_channel(dpio_dev->dpio,
-						      CMD_PRI_LOW,
-						      dpio_dev->token,
-						      evq_info->dpcon->dpcon_id,
-						      &channel_index);
-		if (ret < 0) {
-			DPAA2_EVENTDEV_ERR(
-				"Static dequeue config failed: err(%d)", ret);
-			goto err;
+	while (dpio_dev->dpaa2_held_bufs.dqrr_size) {
+		if (i >= DPAA2_PORTAL_DEQUEUE_DEPTH) {
+			DPAA2_EVENTDEV_WARN("Too many hold dqrrs(%d)",
+				dpio_dev->dpaa2_held_bufs.dqrr_size);
+			break;
 		}
-
-		qbman_swp_push_set(swp, channel_index, 1);
-		evq_info->dpcon->channel_index = channel_index;
-	}
-	dpaa2_portal->is_port_linked = true;
-
-skip_linking:
-	/* Check if there are atomic contexts to be released */
-	while (DPAA2_PER_LCORE_DQRR_SIZE) {
-		if (DPAA2_PER_LCORE_DQRR_HELD & (1 << i)) {
+		if (dpio_dev->dpaa2_held_bufs.dqrr_held & (UINT64_C(1) << i)) {
 			qbman_swp_dqrr_idx_consume(swp, i);
-			DPAA2_PER_LCORE_DQRR_SIZE--;
-			*dpaa2_seqn(DPAA2_PER_LCORE_DQRR_MBUF(i)) =
+			dpio_dev->dpaa2_held_bufs.dqrr_size--;
+			*dpaa2_seqn(dpio_dev->dpaa2_held_bufs.mbuf[i]) =
 				DPAA2_INVALID_MBUF_SEQN;
 		}
 		i++;
 	}
-	DPAA2_PER_LCORE_DQRR_HELD = 0;
+	dpio_dev->dpaa2_held_bufs.dqrr_held = 0;
 
 	do {
 		dq = qbman_swp_dqrr_next(swp);
@@ -339,48 +289,34 @@ dpaa2_eventdev_dequeue_burst(void *port, struct rte_event ev[],
 				timeout_ticks = 0;
 				continue;
 			}
-			return num_pkts;
+			goto quit;
 		}
 		qbman_swp_prefetch_dqrr_next(swp);
 
 		fd = qbman_result_DQ_fd(dq);
-		rxq = (struct dpaa2_queue *)(size_t)qbman_result_DQ_fqd_ctx(dq);
-		if (rxq) {
-			rxq->cb(swp, fd, dq, rxq, &ev[num_pkts]);
-		} else {
+		rxq = (void *)qbman_result_DQ_fqd_ctx(dq);
+		if (rxq && rxq->cb)
+			rxq->cb(dpio_dev, fd, dq, rxq, &ev[num_pkts]);
+		else
 			qbman_swp_dqrr_consume(swp, dq);
-			DPAA2_EVENTDEV_ERR("Null Return VQ received");
-			return 0;
-		}
 
 		num_pkts++;
 	} while (num_pkts < nb_events);
 
+quit:
+	if (dpaa2_portal->port_atomic)
+		rte_spinlock_unlock(&dpaa2_portal->port_lock);
 	return num_pkts;
-err:
-	for (n = 0; n < i; n++) {
-		evq_info = &dpaa2_portal->evq_info[n];
-		if (!evq_info->event_port)
-			continue;
-
-		qbman_swp_push_set(swp, evq_info->dpcon->channel_index, 0);
-		dpio_remove_static_dequeue_channel(dpio_dev->dpio, 0,
-							dpio_dev->token,
-						evq_info->dpcon->dpcon_id);
-	}
-	return 0;
 }
 
 static void
 dpaa2_eventdev_info_get(struct rte_eventdev *dev,
-			struct rte_event_dev_info *dev_info)
+	struct rte_event_dev_info *dev_info)
 {
 	struct dpaa2_eventdev *priv = dev->data->dev_private;
 
 	EVENTDEV_INIT_FUNC_TRACE();
 
-	RTE_SET_USED(dev);
-
 	memset(dev_info, 0, sizeof(struct rte_event_dev_info));
 	dev_info->min_dequeue_timeout_ns =
 		DPAA2_EVENT_MIN_DEQUEUE_TIMEOUT;
@@ -396,6 +332,8 @@ dpaa2_eventdev_info_get(struct rte_eventdev *dev,
 	dev_info->max_event_priority_levels =
 		DPAA2_EVENT_MAX_EVENT_PRIORITY_LEVELS;
 	dev_info->max_event_ports = rte_fslmc_get_device_count(DPAA2_IO);
+	if (dev_info->max_event_ports > dev_info->max_event_queues)
+		dev_info->max_event_ports = dev_info->max_event_queues;
 	/* we only support dpio up to number of cores */
 	if (dev_info->max_event_ports > rte_lcore_count())
 		dev_info->max_event_ports = rte_lcore_count();
@@ -464,9 +402,42 @@ dpaa2_eventdev_start(struct rte_eventdev *dev)
 static void
 dpaa2_eventdev_stop(struct rte_eventdev *dev)
 {
+	uint16_t num, i, max;
+	struct rte_event ev;
+	struct dpaa2_port *dpaa2_portal;
+
 	EVENTDEV_INIT_FUNC_TRACE();
 
-	RTE_SET_USED(dev);
+	for (i = 0; i < dev->data->nb_ports; i++) {
+		dpaa2_portal = dev->data->ports[i];
+		if (!dpaa2_portal || !dpaa2_portal->num_linked_evq)
+			continue;
+		/* Workers must be quiesced before rte_event_dev_stop() is called.
+		 * Concurrent portal access from a worker lcore during drain is undefined.
+		 * Mark the port as draining so the dequeue path skips the
+		 * cross-lcore warning. Do not touch cpu_affine here: it is
+		 * read on the data path and mutating it would be a data race.
+		 */
+		rte_atomic_store_explicit(&dpaa2_portal->flushing, 1,
+			rte_memory_order_relaxed);
+		max = 0;
+dq_again:
+		rte_delay_us(100);
+		num = dpaa2_eventdev_dequeue_burst(dpaa2_portal, &ev, 1, 1);
+		max++;
+		if (num && dev->dev_ops->dev_stop_flush) {
+			dev->dev_ops->dev_stop_flush(dev->data->dev_id,
+				ev, dev->data->dev_stop_flush_arg);
+		}
+		if (!num || max > 10000) {
+			rte_atomic_store_explicit(&dpaa2_portal->flushing, 0,
+				rte_memory_order_relaxed);
+			if (max > 10000 && num)
+				DPAA2_EVENTDEV_WARN("Quit with pending buffers");
+			continue;
+		}
+		goto dq_again;
+	}
 }
 
 static int
@@ -543,116 +514,218 @@ dpaa2_eventdev_port_def_conf(struct rte_eventdev *dev, uint8_t port_id,
 }
 
 static int
-dpaa2_eventdev_port_setup(struct rte_eventdev *dev, uint8_t port_id,
-			  const struct rte_event_port_conf *port_conf)
+dpaa2_eventdev_port_unlink(struct rte_eventdev *dev, void *port,
+	uint8_t queues[], uint16_t nb_unlinks)
 {
-	char event_port_name[32];
-	struct dpaa2_port *portal;
+	struct dpaa2_port *dpaa2_portal = port;
+	int i, j, ret, num = 0, idx = 0;
+	struct dpaa2_dpio_dev *dpio_dev = NULL;
+	struct dpaa2_eventq *evq_info;
+	struct qbman_swp *swp;
+	uint8_t total_queues[DPAA2_EVENT_MAX_QUEUES];
+	struct dpaa2_eventq *evq_infos[DPAA2_EVENT_MAX_QUEUES];
 
 	EVENTDEV_INIT_FUNC_TRACE();
 
-	RTE_SET_USED(port_conf);
-
-	sprintf(event_port_name, "event-port-%d", port_id);
-	portal = rte_zmalloc(event_port_name, sizeof(struct dpaa2_port), 0);
-	if (!portal) {
-		DPAA2_EVENTDEV_ERR("Memory allocation failure");
-		return -ENOMEM;
+	RTE_SET_USED(dev);
+	if (!queues) {
+		queues = total_queues;
+		nb_unlinks = dpaa2_portal->num_linked_evq;
+		for (i = 0; i < nb_unlinks; i++)
+			queues[i] = dpaa2_portal->evq_info[i]->event_queue_id;
 	}
-	portal->eventdev = dev;
 
-	portal->port_id = port_id;
-	dev->data->ports[port_id] = portal;
-	return 0;
-}
-
-static void
-dpaa2_eventdev_port_release(void *port)
-{
-	struct dpaa2_port *portal = port;
-
-	EVENTDEV_INIT_FUNC_TRACE();
+	for (i = 0; i < nb_unlinks; i++) {
+		for (j = 0; j < dpaa2_portal->num_linked_evq; j++) {
+			evq_info = dpaa2_portal->evq_info[j];
+			if (evq_info && evq_info->event_queue_id == queues[i]) {
+				dpio_dev = dpaa2_portal->dpio_dev;
+				swp = dpio_dev->sw_portal;
+				qbman_swp_push_set(swp, evq_info->dpcon->channel_index, 0);
+				ret = dpio_remove_static_dequeue_channel(dpio_dev->dpio,
+					0, dpio_dev->token, evq_info->dpcon->dpcon_id);
+				if (ret)
+					DPAA2_EVENTDEV_WARN("Failed(%d) to remove channel", ret);
+				evq_info->event_port = NULL;
+				dpaa2_portal->evq_info[j] = NULL;
+				num++;
+				break;
+			}
+		}
+		if (j == dpaa2_portal->num_linked_evq) {
+			DPAA2_EVENTDEV_WARN("%s: Event port%d doesn't handle queue[%d]:%d",
+				__func__, dpaa2_portal->port_id, i, queues[i]);
+		}
+	}
 
-	if (portal == NULL)
-		return;
+	for (i = 0; i < dpaa2_portal->num_linked_evq; i++) {
+		if (dpaa2_portal->evq_info[i]) {
+			evq_infos[idx] = dpaa2_portal->evq_info[i];
+			idx++;
+			dpaa2_portal->evq_info[i] = NULL;
+		}
+	}
+	for (i = 0; i < idx; i++)
+		dpaa2_portal->evq_info[i] = evq_infos[i];
 
-	/* TODO: Cleanup is required when ports are in linked state. */
-	if (portal->is_port_linked)
-		DPAA2_EVENTDEV_WARN("Event port must be unlinked before release");
+	dpaa2_portal->num_linked_evq -= num;
 
-	rte_free(portal);
+	return num;
 }
 
 static int
 dpaa2_eventdev_port_link(struct rte_eventdev *dev, void *port,
-			 const uint8_t queues[], const uint8_t priorities[],
-			uint16_t nb_links)
+	const uint8_t queues[], const uint8_t priorities[],
+	uint16_t nb_links)
 {
 	struct dpaa2_eventdev *priv = dev->data->dev_private;
-	struct dpaa2_port *dpaa2_portal = port;
+	struct dpaa2_port *dpaa2_portal = port, *ev_port;
+	struct dpaa2_dpio_dev *dpio_dev = dpaa2_portal->dpio_dev;
 	struct dpaa2_eventq *evq_info;
+	int ret = 0;
 	uint16_t i;
+	uint8_t channel_index;
 
 	EVENTDEV_INIT_FUNC_TRACE();
 
 	RTE_SET_USED(priorities);
 
+	if (dpaa2_portal->num_linked_evq > 0) {
+		ret = rte_event_port_unlink(dev->data->dev_id,
+			dpaa2_portal->port_id, NULL, 0);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < nb_links; i++) {
+		evq_info = &priv->evq_info[queues[i]];
+		if (!evq_info->valid) {
+			DPAA2_EVENTDEV_WARN("%s: Event port%d.queue%d is not valid!",
+				__func__, dpaa2_portal->port_id, queues[i]);
+			return -EINVAL;
+		}
+		if (evq_info->event_port) {
+			ev_port = evq_info->event_port;
+			DPAA2_EVENTDEV_WARN("%s: queue%d is occupied by event port%d",
+				__func__, queues[i], ev_port->port_id);
+			return -ENODEV;
+		}
+	}
+
 	for (i = 0; i < nb_links; i++) {
 		evq_info = &priv->evq_info[queues[i]];
-		dpaa2_portal->evq_info[queues[i]] = *evq_info;
-		dpaa2_portal->evq_info[queues[i]].event_port = port;
+		ret = dpio_add_static_dequeue_channel(dpio_dev->dpio,
+			CMD_PRI_LOW, dpio_dev->token,
+			evq_info->dpcon->dpcon_id, &channel_index);
+		if (ret) {
+			DPAA2_EVENTDEV_ERR("Event port%d.queue%d static dequeue config failed(%d)",
+				dpaa2_portal->port_id, queues[i], ret);
+			goto err;
+		}
+
+		qbman_swp_push_set(dpio_dev->sw_portal, channel_index, 1);
+		evq_info->dpcon->channel_index = channel_index;
+
+		dpaa2_portal->evq_info[dpaa2_portal->num_linked_evq] = evq_info;
+		evq_info->event_port = dpaa2_portal;
 		dpaa2_portal->num_linked_evq++;
 	}
 
-	return (int)nb_links;
+err:
+	if (!ret)
+		return nb_links;
+
+	nb_links = i;
+	for (i = 0; i < nb_links; i++) {
+		evq_info = &priv->evq_info[queues[i]];
+		evq_info->event_port = NULL;
+		qbman_swp_push_set(dpio_dev->sw_portal, evq_info->dpcon->channel_index, 0);
+		if (dpio_remove_static_dequeue_channel(dpio_dev->dpio,
+			0, dpio_dev->token, evq_info->dpcon->dpcon_id)) {
+			DPAA2_EVENTDEV_ERR("Event port%d.queue%d remove failed!",
+				dpaa2_portal->port_id, queues[i]);
+		}
+		dpaa2_portal->num_linked_evq--;
+	}
+	return ret;
 }
 
-static int
-dpaa2_eventdev_port_unlink(struct rte_eventdev *dev, void *port,
-			   uint8_t queues[], uint16_t nb_unlinks)
+static void
+dpaa2_eventdev_port_release(void *port)
 {
-	struct dpaa2_port *dpaa2_portal = port;
-	int i;
-	struct dpaa2_dpio_dev *dpio_dev = NULL;
-	struct dpaa2_eventq *evq_info;
-	struct qbman_swp *swp;
+	struct dpaa2_port *portal = port;
+	uint8_t port_id;
+	struct rte_eventdev *eventdev;
+	int ret;
 
 	EVENTDEV_INIT_FUNC_TRACE();
 
-	RTE_SET_USED(dev);
-	RTE_SET_USED(queues);
+	if (!portal)
+		return;
 
-	for (i = 0; i < nb_unlinks; i++) {
-		evq_info = &dpaa2_portal->evq_info[queues[i]];
-
-		if (DPAA2_PER_LCORE_DPIO && evq_info->dpcon) {
-			/* todo dpaa2_portal shall have dpio_dev-no per lcore*/
-			dpio_dev = DPAA2_PER_LCORE_DPIO;
-			swp = DPAA2_PER_LCORE_PORTAL;
-
-			qbman_swp_push_set(swp,
-					evq_info->dpcon->channel_index, 0);
-			dpio_remove_static_dequeue_channel(dpio_dev->dpio, 0,
-						dpio_dev->token,
-						evq_info->dpcon->dpcon_id);
+	port_id = portal->port_id;
+	eventdev = portal->eventdev;
+
+	/* TODO: Cleanup is required when ports are in linked state. */
+	if (portal->num_linked_evq && eventdev) {
+		ret = rte_event_port_unlink(eventdev->data->dev_id, port_id, NULL, 0);
+		if (ret < 0) {
+			DPAA2_EVENTDEV_ERR("Event port.%d unlink all failed(%d)",
+				portal->port_id, ret);
 		}
-		memset(evq_info, 0, sizeof(struct dpaa2_eventq));
-		if (dpaa2_portal->num_linked_evq)
-			dpaa2_portal->num_linked_evq--;
 	}
 
-	if (!dpaa2_portal->num_linked_evq)
-		dpaa2_portal->is_port_linked = false;
+	if (portal->dpio_dev)
+		rte_dpaa2_free_dpio_device(portal->dpio_dev);
 
-	return (int)nb_unlinks;
+	rte_free(portal);
+	if (eventdev)
+		eventdev->data->ports[port_id] = NULL;
 }
 
+static int
+dpaa2_eventdev_port_setup(struct rte_eventdev *dev, uint8_t port_id,
+	const struct rte_event_port_conf *port_conf)
+{
+	char event_port_name[32];
+	struct dpaa2_port *portal;
+
+	EVENTDEV_INIT_FUNC_TRACE();
+
+	if (dev->data->ports[port_id]) {
+		DPAA2_EVENTDEV_WARN("Event port%d exists!", port_id);
+		dpaa2_eventdev_port_release(dev->data->ports[port_id]);
+	}
+
+	sprintf(event_port_name, "event-port-%d", port_id);
+	portal = rte_zmalloc(event_port_name, sizeof(struct dpaa2_port), 0);
+	if (!portal) {
+		DPAA2_EVENTDEV_ERR("Memory allocation failure");
+		return -ENOMEM;
+	}
+
+	portal->dpio_dev = rte_dpaa2_alloc_dpio_device(-1);
+	if (!portal->dpio_dev) {
+		rte_free(portal);
+		return -ENODEV;
+	}
+	if (port_conf &&
+		(port_conf->event_port_cfg & RTE_DPAA2_EVENT_PORT_CFG_ATOMIC)) {
+		portal->port_atomic = true;
+		rte_spinlock_init(&portal->port_lock);
+	}
+	portal->eventdev = dev;
+
+	portal->port_id = port_id;
+	dev->data->ports[port_id] = portal;
+	return 0;
+}
 
 static int
 dpaa2_eventdev_timeout_ticks(struct rte_eventdev *dev, uint64_t ns,
 			     uint64_t *timeout_ticks)
 {
-	uint32_t scale = 1000*1000;
+	uint32_t scale = 1000 * 1000;
 
 	EVENTDEV_INIT_FUNC_TRACE();
 
@@ -673,16 +746,13 @@ dpaa2_eventdev_dump(struct rte_eventdev *dev, FILE *f)
 
 static int
 dpaa2_eventdev_eth_caps_get(const struct rte_eventdev *dev,
-			    const struct rte_eth_dev *eth_dev,
-			    uint32_t *caps)
+	const struct rte_eth_dev *eth_dev, uint32_t *caps)
 {
-	const char *ethdev_driver = eth_dev->device->driver->name;
-
 	EVENTDEV_INIT_FUNC_TRACE();
 
 	RTE_SET_USED(dev);
 
-	if (!strcmp(ethdev_driver, "net_dpaa2"))
+	if (rte_pmd_dpaa2_dev_is_dpaa2(eth_dev->data->port_id))
 		*caps = RTE_EVENT_ETH_RX_ADAPTER_DPAA2_CAP;
 	else
 		*caps = RTE_EVENT_ETH_RX_ADAPTER_SW_CAP;
@@ -703,11 +773,9 @@ dpaa2_eventdev_eth_queue_add_all(const struct rte_eventdev *dev,
 	EVENTDEV_INIT_FUNC_TRACE();
 
 	for (i = 0; i < eth_dev->data->nb_rx_queues; i++) {
-		ret = dpaa2_eth_eventq_attach(eth_dev, i,
-					      dpcon, queue_conf);
+		ret = dpaa2_eth_eventq_attach(eth_dev, i, dpcon, queue_conf);
 		if (ret) {
-			DPAA2_EVENTDEV_ERR(
-				"Event queue attach failed: err(%d)", ret);
+			DPAA2_EVENTDEV_ERR("Event queue attach failed: err(%d)", ret);
 			goto fail;
 		}
 	}
@@ -732,40 +800,14 @@ dpaa2_eventdev_eth_queue_add(const struct rte_eventdev *dev,
 
 	EVENTDEV_INIT_FUNC_TRACE();
 
-	if (rx_queue_id == -1)
-		return dpaa2_eventdev_eth_queue_add_all(dev,
-				eth_dev, queue_conf);
-
-	ret = dpaa2_eth_eventq_attach(eth_dev, rx_queue_id,
-				      dpcon, queue_conf);
-	if (ret) {
-		DPAA2_EVENTDEV_ERR(
-			"Event queue attach failed: err(%d)", ret);
-		return ret;
-	}
-	return 0;
-}
-
-static int
-dpaa2_eventdev_eth_queue_del_all(const struct rte_eventdev *dev,
-			     const struct rte_eth_dev *eth_dev)
-{
-	int i, ret;
-
-	EVENTDEV_INIT_FUNC_TRACE();
-
-	RTE_SET_USED(dev);
+	if (rx_queue_id < 0)
+		return dpaa2_eventdev_eth_queue_add_all(dev, eth_dev, queue_conf);
 
-	for (i = 0; i < eth_dev->data->nb_rx_queues; i++) {
-		ret = dpaa2_eth_eventq_detach(eth_dev, i);
-		if (ret) {
-			DPAA2_EVENTDEV_ERR(
-				"Event queue detach failed: err(%d)", ret);
-			return ret;
-		}
-	}
+	ret = dpaa2_eth_eventq_attach(eth_dev, rx_queue_id, dpcon, queue_conf);
+	if (ret)
+		DPAA2_EVENTDEV_ERR("Event queue attach failed: err(%d)", ret);
 
-	return 0;
+	return ret;
 }
 
 static int
@@ -773,19 +815,11 @@ dpaa2_eventdev_eth_queue_del(const struct rte_eventdev *dev,
 			     const struct rte_eth_dev *eth_dev,
 			     int32_t rx_queue_id)
 {
-	int ret;
-
 	EVENTDEV_INIT_FUNC_TRACE();
 
-	if (rx_queue_id == -1)
-		return dpaa2_eventdev_eth_queue_del_all(dev, eth_dev);
-
-	ret = dpaa2_eth_eventq_detach(eth_dev, rx_queue_id);
-	if (ret) {
-		DPAA2_EVENTDEV_ERR(
-			"Event queue detach failed: err(%d)", ret);
-		return ret;
-	}
+	RTE_SET_USED(dev);
+	RTE_SET_USED(eth_dev);
+	RTE_SET_USED(rx_queue_id);
 
 	return 0;
 }
@@ -848,8 +882,7 @@ dpaa2_eventdev_crypto_queue_add_all(const struct rte_eventdev *dev,
 	for (i = 0; i < cryptodev->data->nb_queue_pairs; i++) {
 		ret = dpaa2_sec_eventq_attach(cryptodev, i, dpcon, ev);
 		if (ret) {
-			DPAA2_EVENTDEV_ERR("dpaa2_sec_eventq_attach failed: ret %d",
-				    ret);
+			DPAA2_EVENTDEV_ERR("Event queue attach failed: err(%d)", ret);
 			goto fail;
 		}
 	}
@@ -863,9 +896,8 @@ dpaa2_eventdev_crypto_queue_add_all(const struct rte_eventdev *dev,
 
 static int
 dpaa2_eventdev_crypto_queue_add(const struct rte_eventdev *dev,
-		const struct rte_cryptodev *cryptodev,
-		int32_t rx_queue_id,
-		const struct rte_event_crypto_adapter_queue_conf *conf)
+	const struct rte_cryptodev *cryptodev, int32_t qp,
+	const struct rte_event_crypto_adapter_queue_conf *conf)
 {
 	struct dpaa2_eventdev *priv = dev->data->dev_private;
 	uint8_t ev_qid = conf->ev.queue_id;
@@ -874,63 +906,34 @@ dpaa2_eventdev_crypto_queue_add(const struct rte_eventdev *dev,
 
 	EVENTDEV_INIT_FUNC_TRACE();
 
-	if (rx_queue_id == -1)
-		return dpaa2_eventdev_crypto_queue_add_all(dev,
-				cryptodev, &conf->ev);
+	if (qp < 0)
+		return dpaa2_eventdev_crypto_queue_add_all(dev, cryptodev, &conf->ev);
 
-	ret = dpaa2_sec_eventq_attach(cryptodev, rx_queue_id,
-				      dpcon, &conf->ev);
-	if (ret) {
-		DPAA2_EVENTDEV_ERR(
-			"dpaa2_sec_eventq_attach failed: ret: %d", ret);
-		return ret;
-	}
-	return 0;
+	ret = dpaa2_sec_eventq_attach(cryptodev, qp, dpcon, &conf->ev);
+	if (ret)
+		DPAA2_EVENTDEV_ERR("Failed(%d) to attach SEC qp.%d", ret, qp);
+
+	return ret;
 }
 
 static int
-dpaa2_eventdev_crypto_queue_del_all(const struct rte_eventdev *dev,
-			     const struct rte_cryptodev *cdev)
+dpaa2_eventdev_crypto_queue_del(const struct rte_eventdev *dev,
+	const struct rte_cryptodev *cryptodev, int32_t qp)
 {
 	int i, ret;
-
 	EVENTDEV_INIT_FUNC_TRACE();
-
 	RTE_SET_USED(dev);
-
-	for (i = 0; i < cdev->data->nb_queue_pairs; i++) {
-		ret = dpaa2_sec_eventq_detach(cdev, i);
-		if (ret) {
-			DPAA2_EVENTDEV_ERR(
-				"dpaa2_sec_eventq_detach failed:ret %d", ret);
-			return ret;
+	if (qp < 0) {
+		for (i = 0; i < cryptodev->data->nb_queue_pairs; i++) {
+			ret = dpaa2_sec_eventq_detach(cryptodev, i);
+			if (ret)
+				DPAA2_EVENTDEV_ERR("Failed(%d) to detach qp.%d", ret, i);
 		}
+		return 0;
 	}
-
-	return 0;
+	return dpaa2_sec_eventq_detach(cryptodev, qp);
 }
 
-static int
-dpaa2_eventdev_crypto_queue_del(const struct rte_eventdev *dev,
-			     const struct rte_cryptodev *cryptodev,
-			     int32_t rx_queue_id)
-{
-	int ret;
-
-	EVENTDEV_INIT_FUNC_TRACE();
-
-	if (rx_queue_id == -1)
-		return dpaa2_eventdev_crypto_queue_del_all(dev, cryptodev);
-
-	ret = dpaa2_sec_eventq_detach(cryptodev, rx_queue_id);
-	if (ret) {
-		DPAA2_EVENTDEV_ERR(
-			"dpaa2_sec_eventq_detach failed: ret: %d", ret);
-		return ret;
-	}
-
-	return 0;
-}
 
 static int
 dpaa2_eventdev_crypto_start(const struct rte_eventdev *dev,
@@ -981,8 +984,7 @@ dpaa2_eventdev_tx_adapter_caps(const struct rte_eventdev *dev,
 
 static uint16_t
 dpaa2_eventdev_txa_enqueue_same_dest(void *port,
-				     struct rte_event ev[],
-				     uint16_t nb_events)
+	struct rte_event ev[], uint16_t nb_events)
 {
 	struct rte_mbuf *m[MAX_TX_RING_SLOTS], *m0;
 	uint16_t sent = 0, burst, i, port_id;
@@ -1013,8 +1015,7 @@ dpaa2_eventdev_txa_enqueue_same_dest(void *port,
 
 static uint16_t
 dpaa2_eventdev_txa_enqueue(void *port,
-			   struct rte_event ev[],
-			   uint16_t nb_events)
+	struct rte_event ev[], uint16_t nb_events)
 {
 	void *txq[MAX_TX_RING_SLOTS];
 	struct rte_mbuf *m[MAX_TX_RING_SLOTS];
@@ -1088,13 +1089,13 @@ dpaa2_eventdev_create(const char *name, struct rte_vdev_device *vdev)
 		goto fail;
 	}
 
-	eventdev->dev_ops       = &dpaa2_eventdev_ops;
+	eventdev->dev_ops = &dpaa2_eventdev_ops;
 	eventdev->enqueue_burst = dpaa2_eventdev_enqueue_burst;
 	eventdev->enqueue_new_burst = dpaa2_eventdev_enqueue_burst;
 	eventdev->enqueue_forward_burst = dpaa2_eventdev_enqueue_burst;
 	eventdev->dequeue_burst = dpaa2_eventdev_dequeue_burst;
-	eventdev->txa_enqueue	= dpaa2_eventdev_txa_enqueue;
-	eventdev->txa_enqueue_same_dest	= dpaa2_eventdev_txa_enqueue_same_dest;
+	eventdev->txa_enqueue = dpaa2_eventdev_txa_enqueue;
+	eventdev->txa_enqueue_same_dest = dpaa2_eventdev_txa_enqueue_same_dest;
 
 	/* For secondary processes, the primary has done all the work */
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
@@ -1145,6 +1146,8 @@ dpaa2_eventdev_create(const char *name, struct rte_vdev_device *vdev)
 		evq_info->event_port = NULL;
 
 		priv->max_event_queues++;
+		if (priv->max_event_queues >= DPAA2_EVENT_MAX_QUEUES)
+			break;
 	} while (dpcon_dev && dpci_dev);
 
 	DPAA2_EVENTDEV_INFO("%s eventdev created", name);
@@ -1164,9 +1167,9 @@ dpaa2_eventdev_destroy(const char *name)
 	int i;
 
 	eventdev = rte_event_pmd_get_named_dev(name);
-	if (eventdev == NULL) {
+	if (!eventdev) {
 		DPAA2_EVENTDEV_ERR("eventdev with name %s not allocated", name);
-		return -1;
+		return -ENODEV;
 	}
 
 	/* For secondary processes, the primary has done all the work */
@@ -1188,7 +1191,6 @@ dpaa2_eventdev_destroy(const char *name)
 	return 0;
 }
 
-
 static int
 dpaa2_eventdev_probe(struct rte_vdev_device *vdev)
 {
diff --git a/drivers/event/dpaa2/dpaa2_eventdev.h b/drivers/event/dpaa2/dpaa2_eventdev.h
index 9f0abae9d4..b6f23ec2e2 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.h
+++ b/drivers/event/dpaa2/dpaa2_eventdev.h
@@ -67,10 +67,19 @@ struct dpaa2_eventq {
 
 struct dpaa2_port {
 	struct rte_eventdev *eventdev;
-	struct dpaa2_eventq evq_info[DPAA2_EVENT_MAX_QUEUES];
+	struct dpaa2_dpio_dev *dpio_dev;
+	int port_atomic;
+	rte_spinlock_t port_lock;
+	/*
+	 * Set by the control thread while draining this port in the stop
+	 * path. Read on the data path to suppress the cross-lcore warning
+	 * without mutating cpu_affine (which would race with the data path).
+	 */
+	RTE_ATOMIC(uint32_t) flushing;
+
+	struct dpaa2_eventq *evq_info[DPAA2_EVENT_MAX_QUEUES];
 	uint8_t port_id;
 	uint8_t num_linked_evq;
-	uint8_t is_port_linked;
 	uint64_t timeout_us;
 };
 
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 9002556b91..552ac4c94d 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3315,11 +3315,10 @@ int dpaa2_eth_eventq_attach(const struct rte_eth_dev *dev,
 		const struct rte_event_eth_rx_adapter_queue_conf *queue_conf)
 {
 	struct dpaa2_dev_priv *eth_priv = dev->data->dev_private;
-	struct fsl_mc_io *dpni = (struct fsl_mc_io *)dev->process_private;
+	struct fsl_mc_io *dpni = dev->process_private;
 	struct dpaa2_queue *dpaa2_ethq = eth_priv->rx_vq[eth_rx_queue_id];
-	uint8_t flow_id = dpaa2_ethq->flow_id;
+	uint8_t flow_id = dpaa2_ethq->flow_id, options, priority;
 	struct dpni_queue *cfg;
-	uint8_t options, priority;
 	int ret;
 
 	cfg = dpaa2_ethq->cfg;
@@ -3352,7 +3351,7 @@ int dpaa2_eth_eventq_attach(const struct rte_eth_dev *dev,
 	}
 
 	if (queue_conf->ev.sched_type == RTE_SCHED_TYPE_ORDERED &&
-			!eth_priv->en_ordered) {
+		!eth_priv->en_ordered) {
 		struct opr_cfg ocfg;
 
 		/* Restoration window size = 256 frames */
@@ -3376,10 +3375,10 @@ int dpaa2_eth_eventq_attach(const struct rte_eth_dev *dev,
 		}
 
 		ret = dpni_set_opr(dpni, CMD_PRI_LOW, eth_priv->token,
-				   dpaa2_ethq->tc_index, flow_id,
-				   OPR_OPT_CREATE, &ocfg, 0);
+			dpaa2_ethq->tc_index, flow_id, OPR_OPT_CREATE, &ocfg, 0);
 		if (ret) {
-			DPAA2_PMD_ERR("Error setting opr: ret: %d", ret);
+			DPAA2_PMD_ERR("Failed(%d) to set opr of TC%d.flow.%d",
+				ret, dpaa2_ethq->tc_index, flow_id);
 			return ret;
 		}
 
@@ -3390,13 +3389,18 @@ int dpaa2_eth_eventq_attach(const struct rte_eth_dev *dev,
 	cfg->user_context = (size_t)(dpaa2_ethq);
 
 	ret = dpni_set_queue(dpni, CMD_PRI_LOW, eth_priv->token, DPNI_QUEUE_RX,
-			     dpaa2_ethq->tc_index, flow_id, options, cfg);
+		dpaa2_ethq->tc_index, flow_id, options, cfg);
 	if (ret) {
-		DPAA2_PMD_ERR("Error in dpni_set_queue: ret: %d", ret);
+		DPAA2_PMD_ERR("Failed(%d) to set queue of TC%d.flow.%d",
+			ret, dpaa2_ethq->tc_index, flow_id);
 		return ret;
 	}
 
 	rte_memcpy(&dpaa2_ethq->ev, &queue_conf->ev, sizeof(struct rte_event));
+	dpaa2_ethq->ev.flow_id = flow_id;
+	dpaa2_ethq->ev.event_type = RTE_EVENT_TYPE_ETHDEV;
+	dpaa2_ethq->ev.op = RTE_EVENT_OP_NEW;
+	dpaa2_ethq->ev.queue_id = eth_rx_queue_id;
 
 	return 0;
 }
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 9ef6ee0e8c..d46fbd6d7d 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -929,21 +929,17 @@ uint16_t dpaa2_dev_prefetch_rx_channel(void *queue, struct rte_mbuf **bufs,
 				       uint16_t nb_pkts);
 uint16_t dpaa2_dev_rx_channel(void *queue, struct rte_mbuf **bufs,
 			      uint16_t nb_pkts);
-void dpaa2_dev_process_parallel_event(struct qbman_swp *swp,
-				      const struct qbman_fd *fd,
-				      const struct qbman_result *dq,
-				      struct dpaa2_queue *rxq,
-				      struct rte_event *ev);
-void dpaa2_dev_process_atomic_event(struct qbman_swp *swp,
-				    const struct qbman_fd *fd,
-				    const struct qbman_result *dq,
-				    struct dpaa2_queue *rxq,
-				    struct rte_event *ev);
-void dpaa2_dev_process_ordered_event(struct qbman_swp *swp,
-				     const struct qbman_fd *fd,
-				     const struct qbman_result *dq,
-				     struct dpaa2_queue *rxq,
-				     struct rte_event *ev);
+
+void dpaa2_dev_process_parallel_event(struct dpaa2_dpio_dev *dpio_dev,
+	const struct qbman_fd *fd, const struct qbman_result *dq,
+	struct dpaa2_queue *rxq, struct rte_event *ev);
+void dpaa2_dev_process_atomic_event(struct dpaa2_dpio_dev *dpio_dev,
+	const struct qbman_fd *fd, const struct qbman_result *dq,
+	struct dpaa2_queue *rxq, struct rte_event *ev);
+void dpaa2_dev_process_ordered_event(struct dpaa2_dpio_dev *dpio_dev,
+	const struct qbman_fd *fd, const struct qbman_result *dq,
+	struct dpaa2_queue *rxq, struct rte_event *ev);
+
 uint16_t dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts);
 uint16_t dpaa2_dev_tx_ordered(void *queue, struct rte_mbuf **bufs,
 			      uint16_t nb_pkts);
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 3e8fc29baa..d0d4536ab4 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -1201,23 +1201,16 @@ dpaa2_dev_prefetch_rx_channel(void *queue, struct rte_mbuf **bufs,
 }
 
 void __rte_hot
-dpaa2_dev_process_parallel_event(struct qbman_swp *swp,
-				 const struct qbman_fd *fd,
-				 const struct qbman_result *dq,
-				 struct dpaa2_queue *rxq,
-				 struct rte_event *ev)
+dpaa2_dev_process_parallel_event(struct dpaa2_dpio_dev *dpio_dev,
+	const struct qbman_fd *fd, const struct qbman_result *dq,
+	struct dpaa2_queue *rxq, struct rte_event *ev)
 {
-	rte_prefetch0((void *)(size_t)(DPAA2_GET_FD_ADDR(fd) +
-		DPAA2_FD_PTA_SIZE + 16));
+	struct qbman_swp *swp = dpio_dev->sw_portal;
 
-	ev->flow_id = rxq->ev.flow_id;
-	ev->sub_event_type = rxq->ev.sub_event_type;
-	ev->event_type = RTE_EVENT_TYPE_ETHDEV;
-	ev->op = RTE_EVENT_OP_NEW;
-	ev->sched_type = rxq->ev.sched_type;
-	ev->queue_id = rxq->ev.queue_id;
-	ev->priority = rxq->ev.priority;
+	if (dpaa2_svr_family != SVR_LX2160A)
+		dpaa2_dev_rx_annot_prefetch(fd);
 
+	ev->event = rxq->ev.event;
 	if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
 		ev->mbuf = dpaa2_eth_sg_fd_to_mbuf(rxq->eth_data->dev_private, fd);
 	else
@@ -1227,25 +1220,16 @@ dpaa2_dev_process_parallel_event(struct qbman_swp *swp,
 }
 
 void __rte_hot
-dpaa2_dev_process_atomic_event(struct qbman_swp *swp __rte_unused,
-			       const struct qbman_fd *fd,
-			       const struct qbman_result *dq,
-			       struct dpaa2_queue *rxq,
-			       struct rte_event *ev)
+dpaa2_dev_process_atomic_event(struct dpaa2_dpio_dev *dpio_dev,
+	const struct qbman_fd *fd, const struct qbman_result *dq,
+	struct dpaa2_queue *rxq, struct rte_event *ev)
 {
 	uint8_t dqrr_index;
 
-	rte_prefetch0((void *)(size_t)(DPAA2_GET_FD_ADDR(fd) +
-		DPAA2_FD_PTA_SIZE + 16));
-
-	ev->flow_id = rxq->ev.flow_id;
-	ev->sub_event_type = rxq->ev.sub_event_type;
-	ev->event_type = RTE_EVENT_TYPE_ETHDEV;
-	ev->op = RTE_EVENT_OP_NEW;
-	ev->sched_type = rxq->ev.sched_type;
-	ev->queue_id = rxq->ev.queue_id;
-	ev->priority = rxq->ev.priority;
+	if (dpaa2_svr_family != SVR_LX2160A)
+		dpaa2_dev_rx_annot_prefetch(fd);
 
+	ev->event = rxq->ev.event;
 	if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
 		ev->mbuf = dpaa2_eth_sg_fd_to_mbuf(rxq->eth_data->dev_private, fd);
 	else
@@ -1253,29 +1237,22 @@ dpaa2_dev_process_atomic_event(struct qbman_swp *swp __rte_unused,
 
 	dqrr_index = qbman_get_dqrr_idx(dq);
 	*dpaa2_seqn(ev->mbuf) = dqrr_index + 1;
-	DPAA2_PER_LCORE_DQRR_SIZE++;
-	DPAA2_PER_LCORE_DQRR_HELD |= UINT64_C(1) << dqrr_index;
-	DPAA2_PER_LCORE_DQRR_MBUF(dqrr_index) = ev->mbuf;
+	dpio_dev->dpaa2_held_bufs.dqrr_size++;
+	dpio_dev->dpaa2_held_bufs.dqrr_held |= UINT64_C(1) << dqrr_index;
+	dpio_dev->dpaa2_held_bufs.mbuf[dqrr_index] = ev->mbuf;
 }
 
 void __rte_hot
-dpaa2_dev_process_ordered_event(struct qbman_swp *swp,
-				const struct qbman_fd *fd,
-				const struct qbman_result *dq,
-				struct dpaa2_queue *rxq,
-				struct rte_event *ev)
+dpaa2_dev_process_ordered_event(struct dpaa2_dpio_dev *dpio_dev,
+	const struct qbman_fd *fd, const struct qbman_result *dq,
+	struct dpaa2_queue *rxq, struct rte_event *ev)
 {
-	rte_prefetch0((void *)(size_t)(DPAA2_GET_FD_ADDR(fd) +
-		DPAA2_FD_PTA_SIZE + 16));
+	struct qbman_swp *swp = dpio_dev->sw_portal;
 
-	ev->flow_id = rxq->ev.flow_id;
-	ev->sub_event_type = rxq->ev.sub_event_type;
-	ev->event_type = RTE_EVENT_TYPE_ETHDEV;
-	ev->op = RTE_EVENT_OP_NEW;
-	ev->sched_type = rxq->ev.sched_type;
-	ev->queue_id = rxq->ev.queue_id;
-	ev->priority = rxq->ev.priority;
+	if (dpaa2_svr_family != SVR_LX2160A)
+		dpaa2_dev_rx_annot_prefetch(fd);
 
+	ev->event = rxq->ev.event;
 	if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
 		ev->mbuf = dpaa2_eth_sg_fd_to_mbuf(rxq->eth_data->dev_private, fd);
 	else
diff --git a/drivers/net/dpaa2/rte_pmd_dpaa2.h b/drivers/net/dpaa2/rte_pmd_dpaa2.h
index e8e21e28cc..b28962c5f8 100644
--- a/drivers/net/dpaa2/rte_pmd_dpaa2.h
+++ b/drivers/net/dpaa2/rte_pmd_dpaa2.h
@@ -129,6 +129,8 @@ int
 rte_pmd_dpaa2_rx_get_offset(uint16_t port_id, struct rte_mbuf *m,
 	uint8_t *l3_off, uint8_t *l4_off, uint8_t *l5_off);
 
+#define RTE_DPAA2_EVENT_PORT_CFG_ATOMIC RTE_BIT32(31)
+
 /** RTE_DPAA2_MIX_GROUP_FLOW has same behavio as RTE_DPAA2_FLAT_GROUP_FLOW*/
 enum rte_dpaa2_flow_type {
 	RTE_DPAA2_FLAT_GROUP_FLOW,
-- 
2.43.0

