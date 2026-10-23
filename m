Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D883606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:49:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A16264279B;
	Fri, 23 Oct 2026 15:44:59 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 3A5D340A84
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:48 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 169521A0038;
 Fri, 23 Oct 2026 15:44:48 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8146A1A0021;
 Fri, 23 Oct 2026 15:44:47 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2967F180006C;
 Fri, 23 Oct 2026 21:44:46 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 51/65] net/dpaa2: consolidate dequeue paths and optimize
 fast path
Date: Fri, 23 Oct 2026 19:13:31 +0530
Message-ID: <20261023134346.37727-52-prashant.gupta_3@nxp.com>
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

Unify the many duplicated QBMAN volatile-dequeue (VDQ) implementations in
the dpaa2 PMD behind shared helpers and route every Rx-side path through a
single prefetch/dequeue core, cutting duplicated code and trimming the
per-packet work on the common forwarding configuration.

Shared dequeue helpers:
- Add dpaa2_dev_qbman_pull() to build a pull descriptor (channel or FQ)
  in one place, and dpaa2_dev_rx_active_dq_storage() (exported internal)
  to prime the first in-flight VDQ. Replace the open-coded pull-descriptor
  setup in the Rx, Tx-conf, loopback and event-scheduler paths with these
  helpers, removing the duplicated dpaa2_qbman_pull_desc_channel_set() in
  dpaa2_scheduler.c.

Rx fast path:
- Drive dpaa2_dev_prefetch_rx_common() / dpaa2_dev_rx_common() with
  function pointers (dpaa2_dev_rx_cb / dpaa2_dev_dq_prefetch) resolved once
  per burst instead of re-checking the SoC family, callback and parse/
  timestamp conditions on every packet. On LX2160A the parser-result
  prefetch collapses to a no-op (dpaa2_dev_prefetch_next_psr_dummy).
- Split fd-to-mbuf so the common case uses the lightweight
  dpaa2_dev_rx_fd_to_mbuf_core(); the annotation prefetch, parse-offset,
  timestamp and parser-print steps are selected once per burst via
  dpaa2_dev_rx_fd_to_mbuf() only when actually enabled.
- Merge the channel (CDAN/interrupt) and non-channel (polling) burst
  routines; by_channel is derived from dpaa2_q->napi_dpcon.
  dpaa2_dev_rx_channel() / dpaa2_dev_prefetch_rx_channel(), their
  prototypes and the start-time rx_pkt_burst reassignment are removed.
- Rework the Rx error-dump as a callback (dpaa2_dev_err_rx_fd_to_mbuf)
  over the shared dequeue core with bulk free, replacing the standalone
  dpaa2_dev_rx_err_pkts_dump() open-coded VDQ loop.

Tx confirmation:
- Rewrite dpaa2_dev_tx_conf() on top of dpaa2_dev_prefetch_rx_common()
  with a dpaa2_dev_tx_cnf_fd_to_mbuf() callback, dropping its large
  open-coded VDQ loop. Add dpaa2_q->tx_queue back-reference so the conf
  callback can reach the originating Tx queue for 1588 timestamping.

Loopback:
- Rebuild dpaa2_dev_loopback_rx() on the shared dequeue core and
  qbman_swp_enqueue_multiple_desc(), removing another duplicated VDQ loop.

Inlining and locality:
- Force-inline the small hot helpers with __rte_always_inline and let the
  cold/slow paths (parse_slow, SG fd-to-mbuf, timestamp read, error dump)
  stay out of line to improve instruction-cache locality.
- Simplify the direct-mbuf Tx fast check and drop the redundant per-packet
  buf->next warning.

These changes remove a large amount of duplicated dequeue code and reduce
per-packet work and branches on the common forwarding path.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h |   1 +
 drivers/event/dpaa2/dpaa2_scheduler.c   |  53 +-
 drivers/net/dpaa2/dpaa2_ethdev.c        |  44 +-
 drivers/net/dpaa2/dpaa2_ethdev.h        |  24 +-
 drivers/net/dpaa2/dpaa2_rxtx.c          | 879 +++++++++---------------
 5 files changed, 357 insertions(+), 644 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index 95c7203aa2..3a92a1c0de 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -200,6 +200,7 @@ struct __rte_cache_aligned dpaa2_queue {
 	struct dpaa2_bp_info *bp_array;
 	/*to store tx_conf_queue corresponding to tx_queue*/
 	struct dpaa2_queue *tx_conf_queue;
+	struct dpaa2_queue *tx_queue;
 	int32_t eventfd;	/*!< Event Fd of this queue */
 	uint16_t nb_desc;
 	uint16_t tm_sw_td;	/*!< TM software taildrop */
diff --git a/drivers/event/dpaa2/dpaa2_scheduler.c b/drivers/event/dpaa2/dpaa2_scheduler.c
index 9e58b4253f..a80ec05add 100644
--- a/drivers/event/dpaa2/dpaa2_scheduler.c
+++ b/drivers/event/dpaa2/dpaa2_scheduler.c
@@ -74,19 +74,6 @@ dpaa2_scheduler_dq_storage_init(struct dpaa2_sch_dev *sch_dev)
 	return ret;
 }
 
-static inline void
-dpaa2_qbman_pull_desc_channel_set(struct qbman_pull_desc *pulldesc,
-	uint32_t num, uint16_t ch_id, struct qbman_result *dq_sch_storage,
-	uint64_t iova_storage)
-{
-	qbman_pull_desc_clear(pulldesc);
-	qbman_pull_desc_set_numframes(pulldesc, num);
-	qbman_pull_desc_set_channel(pulldesc, ch_id,
-		qbman_pull_type_prio);
-	qbman_pull_desc_set_storage(pulldesc, dq_sch_storage,
-		iova_storage, 1);
-}
-
 static inline struct rte_mbuf *
 dpaa2_scheduler_swp_mbuf_dq(struct qbman_swp *swp)
 {
@@ -255,8 +242,8 @@ dpaa2_scheduler_recv(struct dpaa2_sch_dev *sch_dev,
 	do {
 		is_last = false;
 		next_pull = false;
-		dpaa2_qbman_pull_desc_channel_set(&pulldesc, nb_pkts, ch_id,
-			dq_sch_storage, iova_storage);
+		dpaa2_dev_qbman_pull(&pulldesc, ch_id, nb_pkts, dq_sch_storage,
+			iova_storage, true, qbman_pull_type_prio);
 
 		while (1) {
 			if (qbman_swp_pull(swp, &pulldesc)) {
@@ -344,36 +331,10 @@ dpaa2_scheduler_prefetch_recv(struct dpaa2_sch_dev *sch_dev,
 
 	pull_size = (nb_pkts > dpaa2_dqrr_size) ?
 		dpaa2_dqrr_size : nb_pkts;
-	if (likely(q_storage->active_dqs))
-		goto pull_active_dqs;
-
-	q_storage->toggle = 0;
-	dq_storage = q_storage->dq_storage[q_storage->toggle];
-	iova_storage = q_storage->iova_dq_storage[q_storage->toggle];
-	q_storage->last_num_pkts = pull_size;
-	dpaa2_qbman_pull_desc_channel_set(&pulldesc, nb_pkts,
-		ch_id, dq_storage, iova_storage);
-	if (check_swp_active_dqs(ethrx_dpio_dev->index)) {
-		do {
-			active = get_swp_active_dqs(ethrx_dpio_dev->index);
-			if (qbman_check_command_complete(active))
-				break;
-		} while (1);
-		clear_swp_active_dqs(ethrx_dpio_dev->index);
-	}
-	while (1) {
-		if (qbman_swp_pull(swp, &pulldesc)) {
-			DPAA2_EVENTDEV_DEBUG("Line(%d): QBMAN is busy", __LINE__);
-			/* Portal was busy, try again */
-			continue;
-		}
-		break;
+	if (likely(q_storage->active_dqs)) {
+		dpaa2_dev_rx_active_dq_storage(q_storage, ethrx_dpio_dev,
+			ch_id, pull_size, true, qbman_pull_type_prio);
 	}
-	q_storage->active_dqs = dq_storage;
-	q_storage->active_dpio_id = ethrx_dpio_dev->index;
-	set_swp_active_dqs(ethrx_dpio_dev->index, dq_storage);
-
-pull_active_dqs:
 
 	dq_storage = q_storage->active_dqs;
 	rte_prefetch0((void *)(size_t)(dq_storage));
@@ -385,8 +346,8 @@ dpaa2_scheduler_prefetch_recv(struct dpaa2_sch_dev *sch_dev,
 	q_storage->toggle ^= 1;
 	dq_storage1 = q_storage->dq_storage[q_storage->toggle];
 	iova_storage = q_storage->iova_dq_storage[q_storage->toggle];
-	dpaa2_qbman_pull_desc_channel_set(&pulldesc, nb_pkts,
-		ch_id, dq_storage1, iova_storage);
+	dpaa2_dev_qbman_pull(&pulldesc, ch_id, nb_pkts, dq_storage1,
+		iova_storage, true, qbman_pull_type_prio);
 
 	while (!qbman_check_command_complete(dq_storage))
 		;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index f00f906040..c91dfb7893 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1826,6 +1826,7 @@ dpaa2_dev_tx_queue_setup(struct rte_eth_dev *dev,
 		tc_id = dpaa2_tx_conf_q->tc_index;
 		flow_id = dpaa2_tx_conf_q->flow_id;
 		dpaa2_q->tx_conf_queue = dpaa2_tx_conf_q;
+		dpaa2_tx_conf_q->tx_queue = dpaa2_q;
 		qopt |= DPNI_QUEUE_OPT_USER_CTX;
 		tx_conf_cfg.user_context = (size_t)(dpaa2_q);
 		ret = dpni_set_queue(dpni, CMD_PRI_LOW, priv->token,
@@ -1965,9 +1966,7 @@ dpaa2_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements)
 
 	if (dev->rx_pkt_burst == dpaa2_dev_prefetch_rx ||
 		dev->rx_pkt_burst == dpaa2_dev_rx ||
-		dev->rx_pkt_burst == dpaa2_dev_loopback_rx ||
-		dev->rx_pkt_burst == dpaa2_dev_rx_channel ||
-		dev->rx_pkt_burst == dpaa2_dev_prefetch_rx_channel) {
+		dev->rx_pkt_burst == dpaa2_dev_loopback_rx) {
 		*no_of_elements = RTE_DIM(ptypes);
 		return ptypes;
 	}
@@ -2232,30 +2231,10 @@ dpaa2_dev_start(struct rte_eth_dev *dev)
 
 	PMD_INIT_FUNC_TRACE();
 
-	/* napi: FQs are scheduled to their DPCON at rx_queue_setup, not here; just
-	 * select the channel burst (the worker subscribes its portal later)
-	 */
-	if (dev->data->dev_conf.intr_conf.rxq) {
-		for (i = 0; i < data->nb_rx_queues; i++) {
-			dpaa2_q = data->rx_queues[i];
-			/* the channel burst below derefs napi_dpcon, so every
-			 * rx queue must own a channel
-			 */
-			if (!dpaa2_q->napi_dpcon) {
-				DPAA2_PMD_ERR("napi: rxq %d has no DPCON channel", i);
-				return -ENODEV;
-			}
-		}
-		if (priv->flags & DPAA2_NO_PREFETCH_RX)
-			dev->rx_pkt_burst = dpaa2_dev_rx_channel;
-		else
-			dev->rx_pkt_burst = dpaa2_dev_prefetch_rx_channel;
-	}
-
 	ret = dpni_enable(dpni, CMD_PRI_LOW, priv->token);
 	if (ret) {
 		DPAA2_PMD_ERR("Failure in enabling dpni %d device: err=%d",
-			      priv->hw_id, ret);
+			priv->hw_id, ret);
 		return ret;
 	}
 
@@ -2265,8 +2244,7 @@ dpaa2_dev_start(struct rte_eth_dev *dev)
 				DPNI_QUEUE_RX, dpaa2_q->tc_index,
 				dpaa2_q->flow_id, &cfg, &qid);
 		if (ret) {
-			DPAA2_PMD_ERR("Error in getting flow information: "
-				      "err=%d", ret);
+			DPAA2_PMD_ERR("Error in getting flow information: err=%d", ret);
 			return ret;
 		}
 		dpaa2_q->fqid = qid.fqid;
@@ -2274,10 +2252,9 @@ dpaa2_dev_start(struct rte_eth_dev *dev)
 
 	if (priv->flags & DPAA2_RX_ERROR_QUEUE_FLAG) {
 		ret = dpni_get_queue(dpni, CMD_PRI_LOW, priv->token,
-				     DPNI_QUEUE_RX_ERR, 0, 0, &cfg, &qid);
+				DPNI_QUEUE_RX_ERR, 0, 0, &cfg, &qid);
 		if (ret) {
-			DPAA2_PMD_ERR("Error getting rx err flow information: err=%d",
-						ret);
+			DPAA2_PMD_ERR("Error getting rx err flow information: err=%d", ret);
 			return ret;
 		}
 		dpaa2_q = priv->rx_err_vq;
@@ -2300,11 +2277,9 @@ dpaa2_dev_start(struct rte_eth_dev *dev)
 	}
 	err_cfg.set_frame_annotation = true;
 
-	ret = dpni_set_errors_behavior(dpni, CMD_PRI_LOW,
-				       priv->token, &err_cfg);
+	ret = dpni_set_errors_behavior(dpni, CMD_PRI_LOW, priv->token, &err_cfg);
 	if (ret) {
-		DPAA2_PMD_ERR("Error to dpni_set_errors_behavior: code = %d",
-			      ret);
+		DPAA2_PMD_ERR("Error to dpni_set_errors_behavior: code = %d", ret);
 		return ret;
 	}
 
@@ -2313,8 +2288,7 @@ dpaa2_dev_start(struct rte_eth_dev *dev)
 	    dev->data->dev_conf.intr_conf.lsc != 0) {
 		/* Registering LSC interrupt handler */
 		rte_intr_callback_register(intr_handle,
-					   dpaa2_interrupt_handler,
-					   (void *)dev);
+			dpaa2_interrupt_handler, dev);
 
 		/* enable vfio intr/eventfd mapping
 		 * Interrupt index 0 is required, so we can not use
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 91414114ac..d1ddea7c64 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -933,6 +933,26 @@ int dpaa2_eth_eventq_detach(const struct rte_eth_dev *dev,
 __rte_internal
 int dpaa2_eth_eventq_detach_by_rxq(struct dpaa2_queue *dpaa2_ethq);
 
+static __rte_always_inline void
+dpaa2_dev_qbman_pull(struct qbman_pull_desc *pulldesc, uint32_t id,
+	uint8_t numframes, struct qbman_result *v_storage, uint64_t p_storage,
+	bool by_channel, enum qbman_pull_type_e dct)
+{
+	qbman_pull_desc_clear(pulldesc);
+	qbman_pull_desc_set_numframes(pulldesc, numframes);
+	if (by_channel)
+		qbman_pull_desc_set_channel(pulldesc, id, dct);
+	else
+		qbman_pull_desc_set_fq(pulldesc, id);
+	qbman_pull_desc_set_storage(pulldesc, v_storage, p_storage, 1);
+}
+
+__rte_internal
+void
+dpaa2_dev_rx_active_dq_storage(struct queue_storage_info_t *q_storage,
+	struct dpaa2_dpio_dev *dpio, uint32_t id, uint32_t pull_size,
+	bool by_channel, enum qbman_pull_type_e dct);
+
 uint16_t dpaa2_dev_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts);
 
 uint16_t dpaa2_dev_loopback_rx(void *queue, struct rte_mbuf **bufs,
@@ -940,10 +960,6 @@ uint16_t dpaa2_dev_loopback_rx(void *queue, struct rte_mbuf **bufs,
 
 uint16_t dpaa2_dev_prefetch_rx(void *queue, struct rte_mbuf **bufs,
 			       uint16_t nb_pkts);
-uint16_t dpaa2_dev_prefetch_rx_channel(void *queue, struct rte_mbuf **bufs,
-				       uint16_t nb_pkts);
-uint16_t dpaa2_dev_rx_channel(void *queue, struct rte_mbuf **bufs,
-			      uint16_t nb_pkts);
 
 void dpaa2_dev_process_parallel_event(struct dpaa2_dpio_dev *dpio_dev,
 	const struct qbman_fd *fd, const struct qbman_result *dq,
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 6d12e6818d..0df758148c 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -40,7 +40,13 @@
 #define DPAA2_FAST_PATH_PTYPE_ETH_IPV6_TCP \
 	(DPAA2_FAST_PATH_PTYPE_ETH_IPV6 | RTE_PTYPE_L4_TCP)
 
-static inline void
+typedef void (*dpaa2_dev_rx_cb)(struct dpaa2_queue *dpaa2_q,
+	const struct qbman_fd *fd, const struct qbman_fd **fds,
+	struct rte_mbuf **mbuf);
+
+typedef void (*dpaa2_dev_dq_prefetch)(const struct qbman_result *dq);
+
+static __rte_always_inline void
 dpaa2_dev_rx_annot_prefetch(const struct qbman_fd *fd)
 {
 	size_t fd_addr;
@@ -51,7 +57,7 @@ dpaa2_dev_rx_annot_prefetch(const struct qbman_fd *fd)
 	rte_prefetch0(hw_annot_addr);
 }
 
-static inline void
+static __rte_always_inline void
 dpaa2_dev_rx_parse_offset(struct dpaa2_dev_priv *priv,
 	struct rte_mbuf *mbuf, const struct qbman_fd *fd)
 {
@@ -132,7 +138,7 @@ rte_pmd_dpaa2_rx_get_offset(uint16_t port_id, struct rte_mbuf *m,
  * ID is programmed and the mbuf is carried in the FLC to be freed once
  * the confirmation is dequeued.
  */
-static inline void
+static __rte_always_inline void
 dpaa2_mbuf_to_conf_contig_fd(struct rte_mbuf *mbuf, struct qbman_fd *fd)
 {
 	DPAA2_SET_FD_ADDR(fd, DPAA2_MBUF_VADDR_TO_IOVA(mbuf));
@@ -145,7 +151,7 @@ dpaa2_mbuf_to_conf_contig_fd(struct rte_mbuf *mbuf, struct qbman_fd *fd)
 	DPAA2_SET_FD_FLC(fd, mbuf);
 }
 
-static inline void
+static __rte_always_inline void
 dpaa2_dev_rx_mbuf_flc_offload(struct rte_mbuf *m,
 	const struct qbman_fd *fd)
 {
@@ -172,7 +178,41 @@ void dpaa2_dev_rx_mbuf_flc_offload_export(struct rte_mbuf *m,
 	dpaa2_dev_rx_mbuf_flc_offload(m, fd);
 }
 
-static inline void
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dev_rx_active_dq_storage)
+void
+dpaa2_dev_rx_active_dq_storage(struct queue_storage_info_t *q_storage,
+	struct dpaa2_dpio_dev *dpio, uint32_t id, uint32_t pull_size,
+	bool by_channel, enum qbman_pull_type_e dct)
+{
+	struct qbman_result *dq_storage;
+	struct qbman_pull_desc pulldesc;
+	struct qbman_swp *swp = dpio->sw_portal;
+	int ret;
+
+	q_storage->toggle = 0;
+	dq_storage = q_storage->dq_storage[q_storage->toggle];
+	q_storage->last_num_pkts = pull_size;
+	dpaa2_dev_qbman_pull(&pulldesc, id, pull_size, dq_storage,
+		q_storage->iova_dq_storage[q_storage->toggle],
+		by_channel, dct);
+	if (check_swp_active_dqs(dpio->index)) {
+		while (!qbman_check_command_complete(get_swp_active_dqs(dpio->index)))
+			;
+		clear_swp_active_dqs(dpio->index);
+	}
+	while (1) {
+		ret = qbman_swp_pull(swp, &pulldesc);
+		if (unlikely(ret))
+			DPAA2_PMD_DP_DEBUG("%s: Failed(%d) to pull", __func__, ret);
+		else
+			break;
+	}
+	q_storage->active_dqs = dq_storage;
+	q_storage->active_dpio_id = dpio->index;
+	set_swp_active_dqs(dpio->index, dq_storage);
+}
+
+static void
 dpaa2_dev_rx_read_timestamp(struct dpaa2_dev_priv *priv,
 	struct rte_mbuf *m)
 {
@@ -194,7 +234,7 @@ dpaa2_dev_rx_read_timestamp(struct dpaa2_dev_priv *priv,
 	dpaa2_timestamp_debug(priv, __func__, priv->rx_timestamp);
 }
 
-static inline void __rte_hot
+static __rte_always_inline void __rte_hot
 dpaa2_dev_rx_parse_new(struct dpaa2_dev_priv *priv,
 	struct rte_mbuf *m, const struct qbman_fd *fd,
 	void *hw_annot_addr, int is_vlan)
@@ -270,9 +310,9 @@ dpaa2_dev_rx_parse_new(struct dpaa2_dev_priv *priv,
 		frc_u.u16, m->packet_type, m->ol_flags);
 }
 
-static inline uint32_t __rte_hot
+static uint32_t
 dpaa2_dev_rx_parse_slow(struct rte_mbuf *mbuf,
-			struct dpaa2_annot_hdr *annotation)
+	struct dpaa2_annot_hdr *annotation)
 {
 	uint32_t pkt_type = RTE_PTYPE_UNKNOWN;
 	uint16_t *vlan_tci;
@@ -364,7 +404,7 @@ dpaa2_dev_rx_parse_slow(struct rte_mbuf *mbuf,
 	return pkt_type;
 }
 
-static inline uint32_t __rte_hot
+static uint32_t
 dpaa2_dev_rx_parse(struct dpaa2_dev_priv *priv,
 	struct rte_mbuf *mbuf, void *hw_annot_addr)
 {
@@ -410,7 +450,7 @@ dpaa2_dev_rx_parse(struct dpaa2_dev_priv *priv,
 	return dpaa2_dev_rx_parse_slow(mbuf, annotation);
 }
 
-static inline struct rte_mbuf *__rte_hot
+static struct rte_mbuf *
 dpaa2_eth_sg_fd_to_mbuf(struct dpaa2_dev_priv *priv, const struct qbman_fd *fd)
 {
 	struct qbman_sge *sgt, *sge;
@@ -493,7 +533,7 @@ dpaa2_eth_sg_fd_to_mbuf_export(struct dpaa2_dev_priv *priv, const struct qbman_f
 	return dpaa2_eth_sg_fd_to_mbuf(priv, fd);
 }
 
-static inline struct rte_mbuf *__rte_hot
+static __rte_always_inline struct rte_mbuf *__rte_hot
 dpaa2_eth_fd_to_mbuf(struct dpaa2_dev_priv *priv, const struct qbman_fd *fd)
 {
 	void *v_addr = DPAA2_IOVA_TO_VADDR(DPAA2_GET_FD_ADDR(fd));
@@ -503,11 +543,8 @@ dpaa2_eth_fd_to_mbuf(struct dpaa2_dev_priv *priv, const struct qbman_fd *fd)
 	int is_vlan = false;
 
 	if (unlikely(dpaa2_svr_family == SVR_LX2160A &&
-		(DPAA2_GET_FD_FRC_PARSE_SUM(fd) & DPAA2_PKT_TYPE_VLAN))) {
-		rte_prefetch0(rte_pktmbuf_mtod(mbuf, void *));
-		rte_prefetch0(hw_annot_addr);
+		(DPAA2_GET_FD_FRC_PARSE_SUM(fd) & DPAA2_PKT_TYPE_VLAN)))
 		is_vlan = true;
-	}
 
 	/* need to repopulated some of the fields,
 	 * as they may have changed in last transmission
@@ -576,7 +613,7 @@ static void dpaa2_dev_tx_enable_tstamp(struct qbman_fd *fd)
 		DPAA2_ANNOT_FAEAD_UPDV | DPAA2_ANNOT_FAEAD_UPD);
 }
 
-static inline struct rte_mbuf *
+static struct rte_mbuf *
 dpaa2_dev_mbuf_copy_one_seg(const struct rte_mbuf *sgm, struct rte_mempool *mp)
 {
 	struct rte_mbuf *mc = rte_pktmbuf_alloc(mp);
@@ -596,7 +633,7 @@ dpaa2_dev_mbuf_copy_one_seg(const struct rte_mbuf *sgm, struct rte_mempool *mp)
 	return mc;
 }
 
-static inline void
+static __rte_always_inline void
 dpaa2_dev_tx_config_dynamic_confirm(struct qbman_fd *fd,
 	struct dpaa2_queue *txq, int enable, int tstamp)
 {
@@ -604,24 +641,21 @@ dpaa2_dev_tx_config_dynamic_confirm(struct qbman_fd *fd,
 	void *fd_va = DPAA2_IOVA_TO_VADDR(DPAA2_GET_FD_ADDR(fd));
 
 	if (tstamp) {
-		DPAA2_SET_FD_FRC(fd,
-			DPAA2_GET_FD_FRC(fd) |
+		DPAA2_SET_FD_FRC(fd, DPAA2_GET_FD_FRC(fd) |
 			DPAA2_FD_FRC_FAEADV | DPAA2_FD_FRC_FASV);
 		fd->simple.ctrl |= DPAA2_FD_CTRL_ASAL;
 	} else {
-		DPAA2_SET_FD_FRC(fd, DPAA2_GET_FD_FRC(fd) |
-			DPAA2_FD_FRC_FAEADV);
+		DPAA2_SET_FD_FRC(fd, DPAA2_GET_FD_FRC(fd) | DPAA2_FD_FRC_FAEADV);
 	}
 	/* enable update of confirmation frame annotation */
-	fd_faead = (void *)((size_t)fd_va +
-			DPAA2_FD_PTA_SIZE + DPAA2_FD_HW_ANNOT_FAEAD_OFFSET);
+	fd_faead = (void *)((size_t)fd_va + DPAA2_FD_PTA_SIZE +
+		DPAA2_FD_HW_ANNOT_FAEAD_OFFSET);
 	if (enable) {
 		fd_faead->fqid = txq->tx_conf_queue->fqid;
 		fd_faead->ctrl = DPAA2_TX_CONFIRM_ENABLE;
 		if (tstamp) {
 			fd_faead->ctrl |= (DPAA2_ANNOT_FAEAD_A2V |
-				DPAA2_ANNOT_FAEAD_UPDV |
-				DPAA2_ANNOT_FAEAD_UPD);
+				DPAA2_ANNOT_FAEAD_UPDV | DPAA2_ANNOT_FAEAD_UPD);
 		}
 	} else {
 		fd_faead->fqid = 0;
@@ -845,7 +879,7 @@ dpaa2_dev_tx_mbuf_to_sg_fd(struct rte_mempool *hw_mp,
 	return 0;
 }
 
-static inline void
+static void
 dpaa2_dev_prefetch_next_psr(const struct qbman_result *dq)
 {
 	const struct qbman_fd *fd;
@@ -862,6 +896,12 @@ dpaa2_dev_prefetch_next_psr(const struct qbman_result *dq)
 	rte_prefetch0(&annotation->word3);
 }
 
+static __rte_always_inline void
+dpaa2_dev_prefetch_next_psr_dummy(const struct qbman_result *dq)
+{
+	RTE_SET_USED(dq);
+}
+
 static int __rte_noinline __rte_hot
 dpaa2_dev_tx_mbuf_to_simple_fd(struct rte_mempool *hw_mp,
 	struct rte_mbuf *mbuf, struct qbman_fd *fd,
@@ -910,117 +950,6 @@ dpaa2_dev_tx_mbuf_to_simple_fd(struct rte_mempool *hw_mp,
 	return ret;
 }
 
-static void
-dpaa2_dev_rx_err_pkts_dump(struct dpaa2_queue *dpaa2_q)
-{
-	/* Function receive frames for a given device and VQ */
-	struct qbman_result *dq_storage;
-	uint32_t fqid = dpaa2_q->fqid;
-	int ret, num_rx = 0, i;
-	uint8_t pending, status;
-	const uint8_t *buf;
-	struct qbman_swp *swp;
-	const struct qbman_fd *fd;
-	struct qbman_pull_desc pulldesc;
-	struct rte_eth_dev_data *eth_data = dpaa2_q->eth_data;
-	uint32_t lcore_id = rte_lcore_id();
-	void *v_addr, *hw_annot_addr;
-	struct dpaa2_fas *fas;
-	struct rte_mbuf *mbuf, *seg;
-	struct dpaa2_dev_priv *priv = eth_data->dev_private;
-
-	if (unlikely(!DPAA2_PER_LCORE_DPIO)) {
-		ret = dpaa2_affine_qbman_swp();
-		if (ret) {
-			DPAA2_PMD_ERR("Failed to allocate IO portal, tid: %d", rte_gettid());
-			return;
-		}
-	}
-	swp = DPAA2_PER_LCORE_PORTAL;
-
-	dq_storage = dpaa2_q->q_storage[lcore_id]->dq_storage[0];
-	qbman_pull_desc_clear(&pulldesc);
-	qbman_pull_desc_set_fq(&pulldesc, fqid);
-	qbman_pull_desc_set_storage(&pulldesc, dq_storage,
-			(size_t)(DPAA2_VADDR_TO_IOVA(dq_storage)), 1);
-	qbman_pull_desc_set_numframes(&pulldesc, dpaa2_dqrr_size);
-
-	while (1) {
-		if (qbman_swp_pull(swp, &pulldesc)) {
-			DPAA2_PMD_DP_DEBUG("VDQ command is not issued.QBMAN is busy");
-			/* Portal was busy, try again */
-			continue;
-		}
-		break;
-	}
-
-	/* Check if the previous issued command is completed. */
-	while (!qbman_check_command_complete(dq_storage))
-		;
-
-	pending = 1;
-	do {
-		/* Loop until the dq_storage is updated with
-		 * new token by QBMAN
-		 */
-		while (!qbman_check_new_result(dq_storage))
-			;
-
-		/* Check whether Last Pull command is Expired and
-		 * setting Condition for Loop termination
-		 */
-		if (qbman_result_DQ_is_pull_complete(dq_storage)) {
-			pending = 0;
-			/* Check for valid frame. */
-			status = qbman_result_DQ_flags(dq_storage);
-			if (unlikely(!(status & QBMAN_DQ_STAT_VALIDFRAME)))
-				continue;
-		}
-		fd = qbman_result_DQ_fd(dq_storage);
-		v_addr = DPAA2_IOVA_TO_VADDR(DPAA2_GET_FD_ADDR(fd));
-		hw_annot_addr = (void *)((size_t)v_addr + DPAA2_FD_PTA_SIZE);
-		fas = hw_annot_addr;
-
-		if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
-			dpaa2_dev_rx_annot_prefetch(fd);
-		if (DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg)
-			mbuf = dpaa2_eth_sg_fd_to_mbuf(priv, fd);
-		else
-			mbuf = dpaa2_eth_fd_to_mbuf(priv, fd);
-		if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
-			dpaa2_dev_rx_parse_offset(priv, mbuf, fd);
-
-		dpaa2_dev_rx_read_timestamp(priv, mbuf);
-
-		dpaa2_dev_rx_print_parser_result(priv, fd, mbuf);
-		DPAA2_PMD_ERR("Err pkt on port[%d]:", eth_data->port_id);
-		DPAA2_PMD_ERR("FD offset: %d, FD err: %x, FAS status: %x",
-			DPAA2_GET_FD_OFFSET(fd), DPAA2_GET_FD_ERR(fd),
-			fas->status);
-
-		__rte_mbuf_sanity_check(mbuf, 1);
-		if (mbuf->nb_segs > 1) {
-			seg = mbuf;
-			i = 0;
-			while (seg) {
-				buf = rte_pktmbuf_mtod(seg, const uint8_t *);
-				dpaa2_dump_print("Payload seg[%d]\n", i);
-				dpaa2_dump_hex_print(buf, seg->data_len);
-				seg = seg->next;
-				i++;
-			}
-		} else {
-			buf = rte_pktmbuf_mtod(mbuf, const uint8_t *);
-			dpaa2_dump_hex_print(buf, mbuf->data_len);
-		}
-		rte_pktmbuf_free(mbuf);
-		dq_storage++;
-		num_rx++;
-	} while (pending);
-
-	dpaa2_q->err_pkts += num_rx;
-}
-
 /* This function assumes that caller will be keep the same value for nb_pkts
  * across calls per queue, if that is not the case, better use non-prefetch
  * version of rx call.
@@ -1028,26 +957,23 @@ dpaa2_dev_rx_err_pkts_dump(struct dpaa2_queue *dpaa2_q)
  * the current nb_pkts or bufs space.
  */
 static __rte_always_inline uint16_t
-dpaa2_dev_prefetch_rx_common(void *queue, struct rte_mbuf **bufs,
-			     uint16_t nb_pkts, bool by_channel)
+dpaa2_dev_prefetch_rx_common(struct dpaa2_queue *dpaa2_q,
+	const struct qbman_fd *fds[], struct rte_mbuf **bufs, uint16_t nb_pkts,
+	dpaa2_dev_rx_cb rx_cb, dpaa2_dev_dq_prefetch dq_prefetch)
 {
 	/* Function receive frames for a given device and VQ*/
-	struct dpaa2_queue *dpaa2_q = queue;
 	struct qbman_result *dq_storage, *dq_storage1 = NULL;
-	int ret, num_rx = 0, pull_size;
+	int ret, num_rx = 0;
+	bool by_channel = dpaa2_q->napi_dpcon ? true : false;
+	uint32_t id, pull_size;
 	uint8_t pending, status;
 	struct qbman_swp *swp;
 	const struct qbman_fd *fd;
 	struct qbman_pull_desc pulldesc;
 	struct queue_storage_info_t *q_storage;
-	struct rte_eth_dev_data *eth_data = dpaa2_q->eth_data;
-	struct dpaa2_dev_priv *priv = eth_data->dev_private;
 
 	q_storage = dpaa2_q->q_storage[rte_lcore_id()];
 
-	if (unlikely(priv->flags & DPAA2_RX_ERROR_QUEUE_FLAG))
-		dpaa2_dev_rx_err_pkts_dump(priv->rx_err_vq);
-
 	if (unlikely(!DPAA2_PER_LCORE_ETHRX_DPIO)) {
 		ret = dpaa2_affine_qbman_ethrx_swp();
 		if (ret) {
@@ -1056,47 +982,15 @@ dpaa2_dev_prefetch_rx_common(void *queue, struct rte_mbuf **bufs,
 		}
 	}
 
-	if (!by_channel && unlikely(!rte_dpaa2_bpid_info &&
-		     rte_eal_process_type() == RTE_PROC_SECONDARY))
-		rte_dpaa2_bpid_info = dpaa2_q->bp_array;
-
 	swp = DPAA2_PER_LCORE_ETHRX_PORTAL;
+	if (dpaa2_q->napi_dpcon)
+		id = dpaa2_q->napi_dpcon->qbman_ch_id;
+	else
+		id = dpaa2_q->fqid;
 	pull_size = (nb_pkts > dpaa2_dqrr_size) ? dpaa2_dqrr_size : nb_pkts;
 	if (unlikely(!q_storage->active_dqs)) {
-		q_storage->toggle = 0;
-		dq_storage = q_storage->dq_storage[q_storage->toggle];
-		q_storage->last_num_pkts = pull_size;
-		qbman_pull_desc_clear(&pulldesc);
-		qbman_pull_desc_set_numframes(&pulldesc,
-					      q_storage->last_num_pkts);
-		if (by_channel)
-			qbman_pull_desc_set_channel(&pulldesc,
-				dpaa2_q->napi_dpcon->qbman_ch_id,
-				qbman_pull_type_active);
-		else
-			qbman_pull_desc_set_fq(&pulldesc, dpaa2_q->fqid);
-		qbman_pull_desc_set_storage(&pulldesc, dq_storage,
-			(uint64_t)(DPAA2_VADDR_TO_IOVA(dq_storage)), 1);
-		if (check_swp_active_dqs(DPAA2_PER_LCORE_ETHRX_DPIO->index)) {
-			while (!qbman_check_command_complete(
-			       get_swp_active_dqs(
-			       DPAA2_PER_LCORE_ETHRX_DPIO->index)))
-				;
-			clear_swp_active_dqs(DPAA2_PER_LCORE_ETHRX_DPIO->index);
-		}
-		while (1) {
-			if (qbman_swp_pull(swp, &pulldesc)) {
-				DPAA2_PMD_DP_DEBUG("VDQ command is not issued."
-						  " QBMAN is busy (1)");
-				/* Portal was busy, try again */
-				continue;
-			}
-			break;
-		}
-		q_storage->active_dqs = dq_storage;
-		q_storage->active_dpio_id = DPAA2_PER_LCORE_ETHRX_DPIO->index;
-		set_swp_active_dqs(DPAA2_PER_LCORE_ETHRX_DPIO->index,
-				   dq_storage);
+		dpaa2_dev_rx_active_dq_storage(q_storage, DPAA2_PER_LCORE_ETHRX_DPIO,
+			id, pull_size, by_channel, qbman_pull_type_active);
 	}
 
 	dq_storage = q_storage->active_dqs;
@@ -1108,16 +1002,9 @@ dpaa2_dev_prefetch_rx_common(void *queue, struct rte_mbuf **bufs,
 	 */
 	q_storage->toggle ^= 1;
 	dq_storage1 = q_storage->dq_storage[q_storage->toggle];
-	qbman_pull_desc_clear(&pulldesc);
-	qbman_pull_desc_set_numframes(&pulldesc, pull_size);
-	if (by_channel)
-		qbman_pull_desc_set_channel(&pulldesc,
-			dpaa2_q->napi_dpcon->qbman_ch_id,
-			qbman_pull_type_active);
-	else
-		qbman_pull_desc_set_fq(&pulldesc, dpaa2_q->fqid);
-	qbman_pull_desc_set_storage(&pulldesc, dq_storage1,
-		(uint64_t)(DPAA2_VADDR_TO_IOVA(dq_storage1)), 1);
+	dpaa2_dev_qbman_pull(&pulldesc, id, pull_size, dq_storage1,
+		q_storage->iova_dq_storage[q_storage->toggle],
+		by_channel, qbman_pull_type_active);
 
 	/* Check if the previous issued command is completed.
 	 * Also seems like the SWP is shared between the Ethernet Driver
@@ -1144,27 +1031,14 @@ dpaa2_dev_prefetch_rx_common(void *queue, struct rte_mbuf **bufs,
 			pending = 0;
 			/* Check for valid frame. */
 			status = qbman_result_DQ_flags(dq_storage);
-			if (unlikely((status & QBMAN_DQ_STAT_VALIDFRAME) == 0))
+			if (unlikely(!(status & QBMAN_DQ_STAT_VALIDFRAME)))
 				continue;
 		}
-		if (dpaa2_svr_family != SVR_LX2160A)
-			/** Packet type is parsed from FRC for LX2160A.*/
-			dpaa2_dev_prefetch_next_psr(dq_storage);
 
 		fd = qbman_result_DQ_fd(dq_storage);
 
-		if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
-			dpaa2_dev_rx_annot_prefetch(fd);
-		if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
-			bufs[num_rx] = dpaa2_eth_sg_fd_to_mbuf(priv, fd);
-		else
-			bufs[num_rx] = dpaa2_eth_fd_to_mbuf(priv, fd);
-		if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
-			dpaa2_dev_rx_parse_offset(priv, bufs[num_rx], fd);
-
-		dpaa2_dev_rx_read_timestamp(priv, bufs[num_rx]);
-
-		dpaa2_dev_rx_print_parser_result(priv, fd, bufs[num_rx]);
+		dq_prefetch(dq_storage);
+		rx_cb(dpaa2_q, fd, &fds[num_rx], &bufs[num_rx]);
 
 		dq_storage++;
 		num_rx++;
@@ -1179,8 +1053,7 @@ dpaa2_dev_prefetch_rx_common(void *queue, struct rte_mbuf **bufs,
 	/* issue a volatile dequeue command for next pull */
 	while (1) {
 		if (qbman_swp_pull(swp, &pulldesc)) {
-			DPAA2_PMD_DP_DEBUG("VDQ command is not issued."
-					  "QBMAN is busy (2)");
+			DPAA2_PMD_DP_DEBUG("QBMAN is busy (2)");
 			continue;
 		}
 		break;
@@ -1194,25 +1067,127 @@ dpaa2_dev_prefetch_rx_common(void *queue, struct rte_mbuf **bufs,
 	return num_rx;
 }
 
-uint16_t __rte_hot
-dpaa2_dev_prefetch_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
+static __rte_always_inline void __rte_hot
+dpaa2_dev_rx_fd_to_mbuf_core(struct dpaa2_queue *dpaa2_q,
+	const struct qbman_fd *fd, const struct qbman_fd **fds,
+	struct rte_mbuf **mbuf)
+{
+	struct dpaa2_dev_priv *priv = dpaa2_q->eth_data->dev_private;
+
+	RTE_SET_USED(fds);
+
+	if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
+		*mbuf = dpaa2_eth_sg_fd_to_mbuf(priv, fd);
+	else
+		*mbuf = dpaa2_eth_fd_to_mbuf(priv, fd);
+}
+
+static __rte_always_inline void
+dpaa2_dev_rx_fd_to_mbuf(struct dpaa2_queue *dpaa2_q,
+	const struct qbman_fd *fd, const struct qbman_fd **fds,
+	struct rte_mbuf **mbuf)
 {
-	return dpaa2_dev_prefetch_rx_common(queue, bufs, nb_pkts, false);
+	struct dpaa2_dev_priv *priv = dpaa2_q->eth_data->dev_private;
+
+	if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
+		dpaa2_dev_rx_annot_prefetch(fd);
+	dpaa2_dev_rx_fd_to_mbuf_core(dpaa2_q, fd, fds, mbuf);
+	if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
+		dpaa2_dev_rx_parse_offset(priv, *mbuf, fd);
+	dpaa2_dev_rx_read_timestamp(priv, *mbuf);
+	dpaa2_dev_rx_print_parser_result(priv, fd, *mbuf);
 }
 
-/* rx interrupt/CDAN path: each Rx FQ is scheduled to its own DPCON channel,
- * which a CDAN notifies on empty->non-empty. A VDQ on a scheduled FQ never
- * completes, so the channel is drained by a volatile pull on the CHANNEL (not
- * the FQID); one FQ per channel, so no demux is needed. Same prefetch pipeline
- * as dpaa2_dev_prefetch_rx (one VDQ kept in flight to mask the ~700 cycle
- * latency); the portal's single in-flight VDQ (global_active_dqs) must be
+static void
+dpaa2_dev_err_rx_fd_to_mbuf(struct dpaa2_queue *dpaa2_q,
+	const struct qbman_fd *fd, const struct qbman_fd **fds,
+	struct rte_mbuf **m)
+{
+	void *v_addr = DPAA2_IOVA_TO_VADDR(DPAA2_GET_FD_ADDR(fd));
+	void *hw_annot_addr = (void *)((size_t)v_addr + DPAA2_FD_PTA_SIZE);
+	struct dpaa2_fas *fas = hw_annot_addr;
+	struct rte_mbuf *mbuf, *seg;
+	uint32_t i;
+	const uint8_t *buf;
+
+	dpaa2_dev_rx_fd_to_mbuf(dpaa2_q, fd, fds, m);
+	DPAA2_PMD_ERR("Err pkt on port[%d]:", dpaa2_q->eth_data->port_id);
+	DPAA2_PMD_ERR("FD offset: %d, FD err: %x, FAS status: %x",
+		DPAA2_GET_FD_OFFSET(fd), DPAA2_GET_FD_ERR(fd), fas->status);
+
+	mbuf = *m;
+	__rte_mbuf_sanity_check(mbuf, 1);
+	if (mbuf->nb_segs > 1) {
+		seg = mbuf;
+		i = 0;
+		while (seg) {
+			buf = rte_pktmbuf_mtod(seg, const uint8_t *);
+			dpaa2_dump_print("Payload seg[%d]\n", i);
+			dpaa2_dump_hex_print(buf, seg->data_len);
+			seg = seg->next;
+			i++;
+		}
+	} else {
+		buf = rte_pktmbuf_mtod(mbuf, const uint8_t *);
+		dpaa2_dump_print("Payload\n");
+		dpaa2_dump_hex_print(buf, mbuf->data_len);
+	}
+}
+
+static void
+dpaa2_dev_rx_fd_cb(struct dpaa2_queue *dpaa2_q,
+	const struct qbman_fd *fd, const struct qbman_fd **fds,
+	struct rte_mbuf **mbuf)
+{
+	RTE_SET_USED(dpaa2_q);
+	RTE_SET_USED(mbuf);
+	*fds = fd;
+}
+
+static void
+dpaa2_dev_prefetch_rx_err_pkts_dump(struct dpaa2_queue *err_rxq)
+{
+	uint16_t num_rx;
+	struct rte_mbuf *mbuf[dpaa2_dqrr_size];
+
+	num_rx = dpaa2_dev_prefetch_rx_common(err_rxq, NULL, mbuf, dpaa2_dqrr_size,
+		dpaa2_dev_err_rx_fd_to_mbuf, dpaa2_dev_prefetch_next_psr_dummy);
+	err_rxq->err_pkts += num_rx;
+	rte_pktmbuf_free_bulk(mbuf, num_rx);
+}
+
+/* Support both rx interrupt path and polling path, For interrupt path, each Rx FQ
+ * is scheduled to its own DPCON channel, which a CDAN notifies on empty->non-empty.
+ * A VDQ on a scheduled FQ never completes, so the channel is drained by a volatile pull
+ * on the CHANNEL (not the FQID); one FQ per channel, so no demux is needed.
+ * Same prefetch pipeline as dpaa2_dev_prefetch_rx (one VDQ kept in flight to mask
+ * the ~700 cycle latency); the portal's single in-flight VDQ (global_active_dqs) must be
  * quiesced before an interrupt sleep.
  */
 uint16_t __rte_hot
-dpaa2_dev_prefetch_rx_channel(void *queue, struct rte_mbuf **bufs,
-			      uint16_t nb_pkts)
+dpaa2_dev_prefetch_rx(void *queue, struct rte_mbuf **bufs,
+	uint16_t nb_pkts)
 {
-	return dpaa2_dev_prefetch_rx_common(queue, bufs, nb_pkts, true);
+	struct dpaa2_queue *dpaa2_q = queue;
+	struct dpaa2_dev_priv *priv = dpaa2_q->eth_data->dev_private;
+	dpaa2_dev_dq_prefetch dq_prefetch = dpaa2_svr_family == SVR_LX2160A ?
+		dpaa2_dev_prefetch_next_psr_dummy : dpaa2_dev_prefetch_next_psr;
+
+	if (unlikely(!rte_dpaa2_bpid_info &&
+		rte_eal_process_type() == RTE_PROC_SECONDARY))
+		rte_dpaa2_bpid_info = dpaa2_q->bp_array;
+	if (unlikely((priv->flags & DPAA2_RX_ERROR_QUEUE_FLAG) &&
+		!dpaa2_q->napi_dpcon))
+		dpaa2_dev_prefetch_rx_err_pkts_dump(priv->rx_err_vq);
+
+	if (likely(!(priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN) &&
+		!(priv->flags & (DPAA2_IEEE1588_RX_TS_FLAG |
+		DPAA2_RX_PRINT_PSR_RESULT_FLAG)))) {
+		return dpaa2_dev_prefetch_rx_common(queue, NULL, bufs, nb_pkts,
+			dpaa2_dev_rx_fd_to_mbuf_core, dq_prefetch);
+	}
+	return dpaa2_dev_prefetch_rx_common(queue, NULL, bufs, nb_pkts,
+		dpaa2_dev_rx_fd_to_mbuf, dq_prefetch);
 }
 
 void __rte_hot
@@ -1281,24 +1256,20 @@ dpaa2_dev_process_ordered_event(struct dpaa2_dpio_dev *dpio_dev,
 }
 
 static __rte_always_inline uint16_t
-dpaa2_dev_rx_common(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts,
-		    bool by_channel)
+dpaa2_dev_rx_common(struct dpaa2_queue *dpaa2_q,
+	const struct qbman_fd *fds[], struct rte_mbuf **bufs, uint16_t nb_pkts,
+	dpaa2_dev_rx_cb rx_cb, dpaa2_dev_dq_prefetch dq_prefetch)
 {
 	/* Function receive frames for a given device and VQ */
-	struct dpaa2_queue *dpaa2_q = queue;
 	struct qbman_result *dq_storage;
-	uint32_t fqid = dpaa2_q->fqid;
-	uint16_t num_rx = 0, next_pull = nb_pkts, num_pulled;
+	uint32_t next_pull = nb_pkts, id, pull_size;
+	uint16_t num_rx = 0, num_pulled;
+	bool by_channel = dpaa2_q->napi_dpcon ? true : false;
 	int ret;
 	uint8_t pending, status;
 	struct qbman_swp *swp;
 	const struct qbman_fd *fd;
 	struct qbman_pull_desc pulldesc;
-	struct rte_eth_dev_data *eth_data = dpaa2_q->eth_data;
-	struct dpaa2_dev_priv *priv = eth_data->dev_private;
-
-	if (!by_channel && unlikely(priv->flags & DPAA2_RX_ERROR_QUEUE_FLAG))
-		dpaa2_dev_rx_err_pkts_dump(priv->rx_err_vq);
 
 	if (by_channel) {
 		if (unlikely(!DPAA2_PER_LCORE_ETHRX_DPIO)) {
@@ -1320,32 +1291,22 @@ dpaa2_dev_rx_common(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts,
 		}
 		swp = DPAA2_PER_LCORE_PORTAL;
 	}
+	if (dpaa2_q->napi_dpcon)
+		id = dpaa2_q->napi_dpcon->qbman_ch_id;
+	else
+		id = dpaa2_q->fqid;
 
 	do {
 		dq_storage = dpaa2_q->q_storage[0]->dq_storage[0];
-		qbman_pull_desc_clear(&pulldesc);
-		if (by_channel)
-			qbman_pull_desc_set_channel(&pulldesc,
-				dpaa2_q->napi_dpcon->qbman_ch_id,
-				qbman_pull_type_active);
-		else
-			qbman_pull_desc_set_fq(&pulldesc, fqid);
-		qbman_pull_desc_set_storage(&pulldesc, dq_storage,
-				(size_t)(DPAA2_VADDR_TO_IOVA(dq_storage)), 1);
-
-		if (next_pull > dpaa2_dqrr_size) {
-			qbman_pull_desc_set_numframes(&pulldesc,
-				dpaa2_dqrr_size);
-			next_pull -= dpaa2_dqrr_size;
-		} else {
-			qbman_pull_desc_set_numframes(&pulldesc, next_pull);
-			next_pull = 0;
-		}
+		pull_size = next_pull > dpaa2_dqrr_size ? dpaa2_dqrr_size : next_pull;
+		dpaa2_dev_qbman_pull(&pulldesc, id, pull_size, dq_storage,
+			dpaa2_q->q_storage[0]->iova_dq_storage[0],
+			by_channel, qbman_pull_type_active);
+		next_pull -= pull_size;
 
 		while (1) {
 			if (qbman_swp_pull(swp, &pulldesc)) {
-				DPAA2_PMD_DP_DEBUG(
-					"VDQ command is not issued.QBMAN is busy");
+				DPAA2_PMD_DP_DEBUG("QBMAN is busy");
 				/* Portal was busy, try again */
 				continue;
 			}
@@ -1373,27 +1334,14 @@ dpaa2_dev_rx_common(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts,
 				pending = 0;
 				/* Check for valid frame. */
 				status = qbman_result_DQ_flags(dq_storage);
-				if (unlikely((status &
-					QBMAN_DQ_STAT_VALIDFRAME) == 0))
+				if (unlikely(!(status & QBMAN_DQ_STAT_VALIDFRAME)))
 					continue;
 			}
-			if (dpaa2_svr_family != SVR_LX2160A)
-				/** Packet type is parsed from FRC for LX2160A.*/
-				dpaa2_dev_prefetch_next_psr(dq_storage);
 
 			fd = qbman_result_DQ_fd(dq_storage);
 
-			if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
-				dpaa2_dev_rx_annot_prefetch(fd);
-			if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
-				bufs[num_rx] = dpaa2_eth_sg_fd_to_mbuf(priv, fd);
-			else
-				bufs[num_rx] = dpaa2_eth_fd_to_mbuf(priv, fd);
-			if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
-				dpaa2_dev_rx_parse_offset(priv, bufs[num_rx], fd);
-
-			dpaa2_dev_rx_read_timestamp(priv, bufs[num_rx]);
-			dpaa2_dev_rx_print_parser_result(priv, fd, bufs[num_rx]);
+			dq_prefetch(dq_storage);
+			rx_cb(dpaa2_q, fd, &fds[num_rx], &bufs[num_rx]);
 
 			dq_storage++;
 			num_rx++;
@@ -1407,23 +1355,48 @@ dpaa2_dev_rx_common(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts,
 	return num_rx;
 }
 
-uint16_t
-dpaa2_dev_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
+static void
+dpaa2_dev_rx_err_pkts_dump(struct dpaa2_queue *err_rxq)
 {
-	return dpaa2_dev_rx_common(queue, bufs, nb_pkts, false);
+	uint16_t num_rx;
+	struct rte_mbuf *mbuf[dpaa2_dqrr_size];
+
+	num_rx = dpaa2_dev_rx_common(err_rxq, NULL, mbuf, dpaa2_dqrr_size,
+		dpaa2_dev_err_rx_fd_to_mbuf, dpaa2_dev_prefetch_next_psr_dummy);
+	err_rxq->err_pkts += num_rx;
+	rte_pktmbuf_free_bulk(mbuf, num_rx);
 }
 
-/* rx-interrupt path: synchronous volatile dequeue on the queue's DPCON channel
- * (no prefetch pipeline, so nothing is left in flight across an interrupt
- * sleep, and a channel VDQ -- unlike an FQ VDQ -- completes on a scheduled FQ).
+/* Support both rx-interrupt path and polling path, Fo interrupt path: synchronous
+ * volatile dequeue on the queue's DPCON channel (no prefetch pipeline, so nothing
+ * is left in flight across an interrupt sleep, and a channel VDQ -- unlike an
+ * FQ VDQ -- completes on a scheduled FQ).
  */
-uint16_t __rte_hot
-dpaa2_dev_rx_channel(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
+uint16_t
+dpaa2_dev_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
-	return dpaa2_dev_rx_common(queue, bufs, nb_pkts, true);
+	struct dpaa2_queue *dpaa2_q = queue;
+	struct dpaa2_dev_priv *priv = dpaa2_q->eth_data->dev_private;
+	dpaa2_dev_dq_prefetch dq_prefetch = dpaa2_svr_family == SVR_LX2160A ?
+		dpaa2_dev_prefetch_next_psr_dummy : dpaa2_dev_prefetch_next_psr;
+
+	if (unlikely(!rte_dpaa2_bpid_info &&
+		rte_eal_process_type() == RTE_PROC_SECONDARY))
+		rte_dpaa2_bpid_info = dpaa2_q->bp_array;
+	if (unlikely(priv->flags & DPAA2_RX_ERROR_QUEUE_FLAG))
+		dpaa2_dev_rx_err_pkts_dump(priv->rx_err_vq);
+
+	if (likely(!(priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN) &&
+		!(priv->flags & (DPAA2_IEEE1588_RX_TS_FLAG |
+		DPAA2_RX_PRINT_PSR_RESULT_FLAG)))) {
+		return dpaa2_dev_rx_common(queue, NULL, bufs, nb_pkts,
+			dpaa2_dev_rx_fd_to_mbuf_core, dq_prefetch);
+	}
+	return dpaa2_dev_rx_common(queue, NULL, bufs, nb_pkts,
+		dpaa2_dev_rx_fd_to_mbuf, dq_prefetch);
 }
 
-static inline int
+static __rte_always_inline int
 dpaa2_dev_is_mbuf_from_spec_pool(struct rte_mempool *mp,
 	struct rte_mbuf *mbuf)
 {
@@ -1436,191 +1409,83 @@ dpaa2_dev_is_mbuf_from_spec_pool(struct rte_mempool *mp,
 	return true;
 }
 
-#define swp_idx (DPAA2_PER_LCORE_ETHRX_DPIO->index)
+static __rte_always_inline void __rte_hot
+dpaa2_dev_tx_cnf_fd_to_mbuf(struct dpaa2_queue *dpaa2_q,
+	const struct qbman_fd *fd, const struct qbman_fd **fds,
+	struct rte_mbuf **mbuf)
+{
+	void *v_addr;
+	struct dpaa2_annot_hdr *annotation;
+	struct dpaa2_queue *dpaa2_txq = dpaa2_q->tx_queue;
+	struct dpaa2_dev_priv *priv = dpaa2_q->eth_data->dev_private;
+
+	RTE_SET_USED(fds);
+
+	*mbuf = (void *)DPAA2_GET_FD_FLC(fd);
+	if (unlikely((*mbuf)->ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)) {
+		v_addr = (*mbuf)->buf_addr;
+		annotation = (void *)((size_t)v_addr + DPAA2_FD_PTA_SIZE);
+		rte_atomic_store_explicit(&priv->tx_timestamp,
+			annotation->word2, rte_memory_order_relaxed);
+		rte_atomic_store_explicit(&priv->next_txq_to_cnf,
+			dpaa2_txq, rte_memory_order_relaxed);
+		rte_atomic_fetch_sub_explicit(&dpaa2_q->ts_to_cnfd, 1,
+			rte_memory_order_relaxed);
+		dpaa2_timestamp_debug(priv, __func__, priv->tx_timestamp);
+	}
+}
 
 uint16_t dpaa2_dev_tx_conf(void *txq, int drain)
 {
 	/* Function receive frames for a given device and VQ*/
 	struct dpaa2_queue *dpaa2_txq = txq;
 	struct dpaa2_queue *dpaa2_q = dpaa2_txq->tx_conf_queue;
-	struct qbman_result *dq_storage, *dq_storage1 = NULL;
-	uint32_t fqid = dpaa2_q->fqid;
-	int ret, pull_size, total = 0, bulk_free;
-	uint8_t pending, status, idx, buf_idx;
-	struct qbman_swp *swp;
-	const struct qbman_fd *fd;
-	struct qbman_pull_desc pulldesc;
-	struct queue_storage_info_t *q_storage;
-	struct qbman_result *rst;
-
+	uint16_t num_rx, total = 0, idx;
+	int bulk_free;
 	struct rte_mbuf *mbufs[dpaa2_dqrr_size];
-	struct rte_mempool *mp = NULL;
-	struct rte_eth_dev_data *eth_data = dpaa2_q->eth_data;
-	struct dpaa2_dev_priv *priv = eth_data->dev_private;
-	struct dpaa2_annot_hdr *annotation;
-	void *v_addr;
+	struct rte_mempool *mp;
+	dpaa2_dev_dq_prefetch dq_prefetch = dpaa2_svr_family == SVR_LX2160A ?
+		dpaa2_dev_prefetch_next_psr_dummy : dpaa2_dev_prefetch_next_psr;
 
-conf_again:
+dq_again:
+	num_rx = dpaa2_dev_prefetch_rx_common(dpaa2_q, NULL, mbufs, dpaa2_dqrr_size,
+		dpaa2_dev_tx_cnf_fd_to_mbuf, dq_prefetch);
 	bulk_free = true;
-	idx = 0;
-	q_storage = dpaa2_q->q_storage[rte_lcore_id()];
-	if (unlikely(!DPAA2_PER_LCORE_ETHRX_DPIO)) {
-		ret = dpaa2_affine_qbman_ethrx_swp();
-		if (ret) {
-			DPAA2_PMD_ERR("Failure in affining portal");
-			return 0;
-		}
-	}
-
-	swp = DPAA2_PER_LCORE_ETHRX_PORTAL;
-	pull_size = dpaa2_dqrr_size;
-	if (unlikely(!q_storage->active_dqs)) {
-		q_storage->toggle = 0;
-		dq_storage = q_storage->dq_storage[q_storage->toggle];
-		q_storage->last_num_pkts = pull_size;
-		qbman_pull_desc_clear(&pulldesc);
-		qbman_pull_desc_set_numframes(&pulldesc,
-			q_storage->last_num_pkts);
-		qbman_pull_desc_set_fq(&pulldesc, fqid);
-		qbman_pull_desc_set_storage(&pulldesc, dq_storage,
-			DPAA2_VADDR_TO_IOVA(dq_storage), 1);
-		if (check_swp_active_dqs(swp_idx)) {
-			rst = get_swp_active_dqs(swp_idx);
-			while (!qbman_check_command_complete(rst))
-				;
-			clear_swp_active_dqs(swp_idx);
-		}
-		while (1) {
-			if (qbman_swp_pull(swp, &pulldesc)) {
-				DPAA2_PMD_DP_DEBUG("QBMAN is busy (1)");
-				/* Portal was busy, try again */
-				continue;
-			}
-			break;
-		}
-		q_storage->active_dqs = dq_storage;
-		q_storage->active_dpio_id = swp_idx;
-		set_swp_active_dqs(swp_idx, dq_storage);
-	}
-
-	dq_storage = q_storage->active_dqs;
-	rte_prefetch0((void *)(dq_storage));
-	rte_prefetch0((void *)(dq_storage + 1));
-
-	/* Prepare next pull descriptor. This will give space for the
-	 * prefetching done on DQRR entries
-	 */
-	q_storage->toggle ^= 1;
-	dq_storage1 = q_storage->dq_storage[q_storage->toggle];
-	qbman_pull_desc_clear(&pulldesc);
-	qbman_pull_desc_set_numframes(&pulldesc, pull_size);
-	qbman_pull_desc_set_fq(&pulldesc, fqid);
-	qbman_pull_desc_set_storage(&pulldesc, dq_storage1,
-		DPAA2_VADDR_TO_IOVA(dq_storage1), 1);
-
-	/* Check if the previous issued command is completed.
-	 * Also seems like the SWP is shared between the Ethernet Driver
-	 * and the SEC driver.
-	 */
-	while (!qbman_check_command_complete(dq_storage))
-		;
-	if (dq_storage == get_swp_active_dqs(q_storage->active_dpio_id))
-		clear_swp_active_dqs(q_storage->active_dpio_id);
-
-	pending = 1;
-
-	do {
-		/* Loop until the dq_storage is updated with
-		 * new token by QBMAN
-		 */
-		while (!qbman_check_new_result(dq_storage))
-			;
-		rte_prefetch0((void *)(dq_storage + 2));
-		/* Check whether Last Pull command is Expired and
-		 * setting Condition for Loop termination
-		 */
-		if (qbman_result_DQ_is_pull_complete(dq_storage)) {
-			pending = 0;
-			/* Check for valid frame. */
-			status = qbman_result_DQ_flags(dq_storage);
-			if (unlikely((status & QBMAN_DQ_STAT_VALIDFRAME) == 0))
-				continue;
-		}
-
-		fd = qbman_result_DQ_fd(dq_storage);
-		mbufs[idx] = (void *)DPAA2_GET_FD_FLC(fd);
+	mp = NULL;
+	for (idx = 0; idx < num_rx; idx++) {
 		if (unlikely(!mp))
 			mp = mbufs[idx]->pool;
-		if (unlikely(rte_mbuf_refcnt_read(mbufs[idx]) > 1))
-			bulk_free = false;
-		if (bulk_free &&
-			!dpaa2_dev_is_mbuf_from_spec_pool(mp, mbufs[idx]))
+		if (bulk_free && unlikely(rte_mbuf_refcnt_read(mbufs[idx]) > 1 ||
+			!dpaa2_dev_is_mbuf_from_spec_pool(mp, mbufs[idx])))
 			bulk_free = false;
-		if (unlikely(mbufs[idx]->ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)) {
-			v_addr = mbufs[idx]->buf_addr;
-			annotation = (void *)((size_t)v_addr + DPAA2_FD_PTA_SIZE);
-			rte_atomic_store_explicit(&priv->tx_timestamp,
-				annotation->word2, rte_memory_order_relaxed);
-			rte_atomic_store_explicit(&priv->next_txq_to_cnf,
-				dpaa2_txq, rte_memory_order_relaxed);
-			rte_atomic_fetch_sub_explicit(&dpaa2_q->ts_to_cnfd, 1,
-				rte_memory_order_relaxed);
-			dpaa2_timestamp_debug(priv, __func__, priv->tx_timestamp);
-		}
-		idx++;
-		dq_storage++;
-		if (idx >= dpaa2_dqrr_size)
-			break;
-	} while (pending);
-
-	if (check_swp_active_dqs(swp_idx)) {
-		rst = get_swp_active_dqs(swp_idx);
-		while (!qbman_check_command_complete(rst))
-			;
-		clear_swp_active_dqs(swp_idx);
-	}
-	/* issue a volatile dequeue command for next pull */
-	while (1) {
-		if (qbman_swp_pull(swp, &pulldesc)) {
-			DPAA2_PMD_DP_DEBUG("QBMAN is busy (2)");
-			continue;
-		}
-		break;
 	}
-	q_storage->active_dqs = dq_storage1;
-	q_storage->active_dpio_id = swp_idx;
-	set_swp_active_dqs(swp_idx, dq_storage1);
 
 	if (bulk_free) {
-		rte_pktmbuf_free_bulk(mbufs, idx);
+		rte_pktmbuf_free_bulk(mbufs, num_rx);
 	} else {
-		for (buf_idx = 0; buf_idx < idx; buf_idx++)
-			rte_pktmbuf_free(mbufs[buf_idx]);
+		for (idx = 0; idx < num_rx; idx++) {
+			if (rte_mbuf_refcnt_read(mbufs[idx]) > 1)
+				rte_mbuf_refcnt_update(mbufs[idx], -1);
+			else
+				rte_pktmbuf_free(mbufs[idx]);
+		}
 	}
-
-	dpaa2_q->rx_pkts += idx;
-	total += idx;
-	if (drain && pending)
-		goto conf_again;
+	total += num_rx;
+	if (drain && num_rx)
+		goto dq_again;
 
 	return total;
 }
 
-static inline int
+static __rte_always_inline int
 dpaa2_dev_tx_fast_mbuf_to_fd(struct dpaa2_dev_priv *priv,
 	struct rte_mbuf *buf, struct qbman_fd *fd)
 {
 	struct rte_mempool *mp = buf->pool;
 
 	if (likely(RTE_MBUF_DIRECT(buf) &&
-		mp && mp->ops_index ==
-		priv->bp_list->dpaa2_ops_index &&
-		buf->nb_segs == 1 &&
-		rte_mbuf_refcnt_read(buf) == 1)) {
-		if (unlikely(buf->next)) {
-			DPAA2_PMD_WARN("Single mbuf has next segment(%p)",
-				buf->next);
-		}
+		mp->ops_index == priv->bp_list->dpaa2_ops_index &&
+		buf->nb_segs == 1 && rte_mbuf_refcnt_read(buf) == 1)) {
 		if (unlikely(priv->tx_conf_type == DPAA2_TX_ABSOLUTE_CONF))
 			dpaa2_mbuf_to_conf_contig_fd(buf, fd);
 		else
@@ -2055,26 +1920,23 @@ dpaa2_dev_tx_ordered(void *queue, struct rte_mbuf **bufs,
 /* This function loopbacks all the received packets.*/
 uint16_t
 dpaa2_dev_loopback_rx(void *queue,
-		      struct rte_mbuf **bufs __rte_unused,
-		      uint16_t nb_pkts)
+	struct rte_mbuf **bufs __rte_unused, uint16_t nb_pkts __rte_unused)
 {
 	/* Function receive frames for a given device and VQ*/
-	struct dpaa2_queue *dpaa2_q = (struct dpaa2_queue *)queue;
-	struct qbman_result *dq_storage, *dq_storage1 = NULL;
-	uint32_t fqid = dpaa2_q->fqid;
-	int ret, num_rx = 0, num_tx = 0, pull_size;
-	uint8_t pending, status;
+	struct dpaa2_queue *dpaa2_q = queue;
+	int ret, num_rx, num_tx = 0, i;
 	struct qbman_swp *swp;
-	struct qbman_fd *fd[DPAA2_LX2_DQRR_RING_SIZE];
-	struct qbman_pull_desc pulldesc;
+	const struct qbman_fd *fd[dpaa2_dqrr_size];
+	struct qbman_fd tx_fd[dpaa2_dqrr_size];
 	struct qbman_eq_desc eqdesc;
-	struct queue_storage_info_t *q_storage;
-	struct rte_eth_dev_data *eth_data = dpaa2_q->eth_data;
-	struct dpaa2_dev_priv *priv = eth_data->dev_private;
+	struct dpaa2_dev_priv *priv = dpaa2_q->eth_data->dev_private;
 	struct dpaa2_queue *tx_q = priv->tx_vq[0];
 	/* todo - currently we are using 1st TX queue only for loopback*/
 
-	q_storage = dpaa2_q->q_storage[rte_lcore_id()];
+	qbman_eq_desc_clear(&eqdesc);
+	qbman_eq_desc_set_no_orp(&eqdesc, DPAA2_EQ_RESP_ERR_FQ);
+	qbman_eq_desc_set_response(&eqdesc, 0, 0);
+	qbman_eq_desc_set_fq(&eqdesc, tx_q->fqid);
 	if (unlikely(!DPAA2_PER_LCORE_ETHRX_DPIO)) {
 		ret = dpaa2_affine_qbman_ethrx_swp();
 		if (ret) {
@@ -2083,117 +1945,16 @@ dpaa2_dev_loopback_rx(void *queue,
 		}
 	}
 	swp = DPAA2_PER_LCORE_ETHRX_PORTAL;
-	pull_size = (nb_pkts > dpaa2_dqrr_size) ? dpaa2_dqrr_size : nb_pkts;
-	if (unlikely(!q_storage->active_dqs)) {
-		q_storage->toggle = 0;
-		dq_storage = q_storage->dq_storage[q_storage->toggle];
-		q_storage->last_num_pkts = pull_size;
-		qbman_pull_desc_clear(&pulldesc);
-		qbman_pull_desc_set_numframes(&pulldesc,
-					      q_storage->last_num_pkts);
-		qbman_pull_desc_set_fq(&pulldesc, fqid);
-		qbman_pull_desc_set_storage(&pulldesc, dq_storage,
-			(size_t)(DPAA2_VADDR_TO_IOVA(dq_storage)), 1);
-		if (check_swp_active_dqs(DPAA2_PER_LCORE_ETHRX_DPIO->index)) {
-			while (!qbman_check_command_complete(
-			       get_swp_active_dqs(
-			       DPAA2_PER_LCORE_ETHRX_DPIO->index)))
-				;
-			clear_swp_active_dqs(DPAA2_PER_LCORE_ETHRX_DPIO->index);
-		}
-		while (1) {
-			if (qbman_swp_pull(swp, &pulldesc)) {
-				DPAA2_PMD_DP_DEBUG(
-					"VDQ command not issued.QBMAN busy");
-				/* Portal was busy, try again */
-				continue;
-			}
-			break;
-		}
-		q_storage->active_dqs = dq_storage;
-		q_storage->active_dpio_id = DPAA2_PER_LCORE_ETHRX_DPIO->index;
-		set_swp_active_dqs(DPAA2_PER_LCORE_ETHRX_DPIO->index,
-				   dq_storage);
-	}
-
-	dq_storage = q_storage->active_dqs;
-	rte_prefetch0((void *)(size_t)(dq_storage));
-	rte_prefetch0((void *)(size_t)(dq_storage + 1));
-
-	/* Prepare next pull descriptor. This will give space for the
-	 * prefetching done on DQRR entries
-	 */
-	q_storage->toggle ^= 1;
-	dq_storage1 = q_storage->dq_storage[q_storage->toggle];
-	qbman_pull_desc_clear(&pulldesc);
-	qbman_pull_desc_set_numframes(&pulldesc, pull_size);
-	qbman_pull_desc_set_fq(&pulldesc, fqid);
-	qbman_pull_desc_set_storage(&pulldesc, dq_storage1,
-		(size_t)(DPAA2_VADDR_TO_IOVA(dq_storage1)), 1);
-
-	/*Prepare enqueue descriptor*/
-	qbman_eq_desc_clear(&eqdesc);
-	qbman_eq_desc_set_no_orp(&eqdesc, DPAA2_EQ_RESP_ERR_FQ);
-	qbman_eq_desc_set_response(&eqdesc, 0, 0);
-	qbman_eq_desc_set_fq(&eqdesc, tx_q->fqid);
-
-	/* Check if the previous issued command is completed.
-	 * Also seems like the SWP is shared between the Ethernet Driver
-	 * and the SEC driver.
-	 */
-	while (!qbman_check_command_complete(dq_storage))
-		;
-	if (dq_storage == get_swp_active_dqs(q_storage->active_dpio_id))
-		clear_swp_active_dqs(q_storage->active_dpio_id);
-
-	pending = 1;
-
-	do {
-		/* Loop until the dq_storage is updated with
-		 * new token by QBMAN
-		 */
-		while (!qbman_check_new_result(dq_storage))
-			;
-		rte_prefetch0((void *)((size_t)(dq_storage + 2)));
-		/* Check whether Last Pull command is Expired and
-		 * setting Condition for Loop termination
-		 */
-		if (qbman_result_DQ_is_pull_complete(dq_storage)) {
-			pending = 0;
-			/* Check for valid frame. */
-			status = qbman_result_DQ_flags(dq_storage);
-			if (unlikely((status & QBMAN_DQ_STAT_VALIDFRAME) == 0))
-				continue;
-		}
-		fd[num_rx] = RTE_PTR_UNQUAL(qbman_result_DQ_fd(dq_storage));
-
-		dq_storage++;
-		num_rx++;
-	} while (pending);
 
+	num_rx = dpaa2_dev_prefetch_rx_common(dpaa2_q, fd, NULL, dpaa2_dqrr_size,
+		dpaa2_dev_rx_fd_cb, dpaa2_svr_family == SVR_LX2160A ?
+		dpaa2_dev_prefetch_next_psr_dummy : dpaa2_dev_prefetch_next_psr);
+	for (i = 0; i < num_rx; i++)
+		rte_memcpy(&tx_fd[i], fd[i], sizeof(struct qbman_fd));
 	while (num_tx < num_rx) {
-		num_tx += qbman_swp_enqueue_multiple_fd(swp, &eqdesc,
-				&fd[num_tx], 0, num_rx - num_tx);
-	}
-
-	if (check_swp_active_dqs(DPAA2_PER_LCORE_ETHRX_DPIO->index)) {
-		while (!qbman_check_command_complete(
-		       get_swp_active_dqs(DPAA2_PER_LCORE_ETHRX_DPIO->index)))
-			;
-		clear_swp_active_dqs(DPAA2_PER_LCORE_ETHRX_DPIO->index);
+		num_tx += qbman_swp_enqueue_multiple_desc(swp, &eqdesc,
+				&tx_fd[num_tx], num_rx - num_tx);
 	}
-	/* issue a volatile dequeue command for next pull */
-	while (1) {
-		if (qbman_swp_pull(swp, &pulldesc)) {
-			DPAA2_PMD_DP_DEBUG("VDQ command is not issued."
-					  "QBMAN is busy (2)");
-			continue;
-		}
-		break;
-	}
-	q_storage->active_dqs = dq_storage1;
-	q_storage->active_dpio_id = DPAA2_PER_LCORE_ETHRX_DPIO->index;
-	set_swp_active_dqs(DPAA2_PER_LCORE_ETHRX_DPIO->index, dq_storage1);
 
 	dpaa2_q->rx_pkts += num_rx;
 	dpaa2_q->tx_pkts += num_tx;
-- 
2.43.0

