Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FB7606A322
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:50:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD38E40B98;
	Fri, 23 Oct 2026 15:45:13 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 7E23440B92
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:57 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5EA5E200038;
 Fri, 23 Oct 2026 15:44:57 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0BB59200020;
 Fri, 23 Oct 2026 15:44:57 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AE52D18000B7;
 Fri, 23 Oct 2026 21:44:55 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 60/65] bus/fslmc: move enqueue response descriptors to
 per-queue
Date: Fri, 23 Oct 2026 19:13:40 +0530
Message-ID: <20261023134346.37727-61-prashant.gupta_3@nxp.com>
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

Previously the enqueue (ORP) response descriptors were managed
globally per DPIO device via a shared eqresp ring (eqresp,
eqresp_meta, eqresp_pi/ci) together with the global helper
dpaa2_free_eq_descriptors(). This coupled ordered-enqueue state to
the per-core portal and required separate per-driver callbacks
(cb_eqresp_free) to free the response buffers.

Rework the ordered-enqueue response handling so that each dpaa2_queue
owns its own response pool via the new dpaa2_queue_eq_resp structure.
Introduce common helpers in dpaa2_hw_pvt.h:

  - dpaa2_queue_eqresp_create() / dpaa2_queue_eqresp_free()
  - dpaa2_enq_rsp_process()
  - dpaa2_eq_set_order_desc()
  - dpaa2_dq_order_save() / dpaa2_mbuf_seq_order_set()

and a unified dpaa2_eqresp_cb callback type. The net and sec
drivers are updated to allocate/free the per-queue pool and use the
shared order-descriptor and response-processing helpers, removing the
duplicated dpaa2_set_enqueue_descriptor() implementations and the old
free-eqresp buffer callbacks.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c    |  49 ------
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.h    |   5 -
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h     | 165 ++++++++++++++++++--
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c |  89 +++--------
 drivers/net/dpaa2/dpaa2_ethdev.c            |   5 +-
 drivers/net/dpaa2/dpaa2_ethdev.h            |   3 +-
 drivers/net/dpaa2/dpaa2_rxtx.c              |  87 ++---------
 7 files changed, 195 insertions(+), 208 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index a32406b1b3..3e18082e14 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -765,18 +765,6 @@ dpaa2_create_dpio_device(int vdev_fd,
 	io_space_count++;
 	dpio_dev->index = io_space_count;
 
-	dpio_dev->eqresp = rte_zmalloc(NULL, MAX_EQ_RESP_ENTRIES *
-				     (sizeof(struct qbman_result) +
-				     sizeof(struct eqresp_metadata)),
-				     RTE_CACHE_LINE_SIZE);
-	if (!dpio_dev->eqresp) {
-		DPAA2_BUS_ERR("Memory allocation failed for eqresp");
-		goto err;
-	}
-	dpio_dev->eqresp_meta = (struct eqresp_metadata *)(dpio_dev->eqresp +
-				MAX_EQ_RESP_ENTRIES);
-
-
 	TAILQ_INSERT_TAIL(&dpio_dev_list, dpio_dev, next);
 
 	if (!dpaa2_portal_key) {
@@ -803,7 +791,6 @@ dpaa2_create_dpio_device(int vdev_fd,
 				   dpio_dev->token);
 		}
 
-		rte_free(dpio_dev->eqresp);
 		rte_free(dpio_dev->dpio);
 	}
 
@@ -864,42 +851,6 @@ dpaa2_alloc_dq_storage(struct queue_storage_info_t *q_storage)
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_free_eq_descriptors)
-uint32_t
-dpaa2_free_eq_descriptors(void)
-{
-	struct dpaa2_dpio_dev *dpio_dev = DPAA2_PER_LCORE_DPIO;
-	struct qbman_result *eqresp;
-	struct eqresp_metadata *eqresp_meta;
-	struct dpaa2_queue *txq;
-
-	while (dpio_dev->eqresp_ci != dpio_dev->eqresp_pi) {
-		eqresp = &dpio_dev->eqresp[dpio_dev->eqresp_ci];
-		eqresp_meta = &dpio_dev->eqresp_meta[dpio_dev->eqresp_ci];
-
-		if (!qbman_result_eqresp_rspid(eqresp))
-			break;
-
-		if (qbman_result_eqresp_rc(eqresp)) {
-			txq = eqresp_meta->dpaa2_q;
-			txq->cb_eqresp_free(dpio_dev->eqresp_ci, txq);
-		}
-		qbman_result_eqresp_set_rspid(eqresp, 0);
-
-		dpio_dev->eqresp_ci + 1 < MAX_EQ_RESP_ENTRIES ?
-			dpio_dev->eqresp_ci++ : (dpio_dev->eqresp_ci = 0);
-	}
-
-	/* Return 1 less entry so that PI and CI are never same in a
-	 * case there all the EQ responses are in use.
-	 */
-	if (dpio_dev->eqresp_ci > dpio_dev->eqresp_pi)
-		return dpio_dev->eqresp_ci - dpio_dev->eqresp_pi - 1;
-	else
-		return dpio_dev->eqresp_ci - dpio_dev->eqresp_pi +
-			MAX_EQ_RESP_ENTRIES - 1;
-}
-
 static struct rte_dpaa2_object rte_dpaa2_dpio_obj = {
 	.dev_type = DPAA2_IO,
 	.create = dpaa2_create_dpio_device,
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
index c61f8ee0a2..61ed9e0421 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
@@ -65,11 +65,6 @@ __rte_internal
 void
 dpaa2_free_dq_storage(struct queue_storage_info_t *q_storage);
 
-/* free the enqueue response descriptors */
-__rte_internal
-uint32_t
-dpaa2_free_eq_descriptors(void);
-
 __rte_internal
 struct dpaa2_dpio_dev *
 rte_dpaa2_alloc_dpio_device(int isr, uint32_t threshold,
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index 1ee53c53a2..b9839eeb70 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -24,6 +24,7 @@
 #ifndef true
 #define true       1
 #endif
+#undef DPAA2_ORDER_DEBUG
 #define lower_32_bits(x) ((uint32_t)(x))
 #define upper_32_bits(x) ((uint32_t)(((x) >> 16) >> 16))
 
@@ -54,7 +55,7 @@
 #define DPAA2_ENQUEUE_FLAG_ORP		(1ULL << 30)
 /* ORP ID shift and mask */
 #define DPAA2_EQCR_OPRID_SHIFT		16
-#define DPAA2_EQCR_OPRID_MASK		0x3FFF0000
+#define DPAA2_EQCR_OPRID_MASK		0x00003FFF
 /* Sequence number shift and mask */
 #define DPAA2_EQCR_SEQNUM_SHIFT		0
 #define DPAA2_EQCR_SEQNUM_MASK		0x0000FFFF
@@ -89,6 +90,15 @@
 #define SEC_FLC_DHR_OUTBOUND	(-114)
 #define SEC_FLC_DHR_INBOUND	0
 
+static inline __rte_format_printf(1, 2) void
+dpaa2_hw_dump(const char *fmt, ...)
+{
+	va_list ap;
+	va_start(ap, fmt);
+	rte_vlog(RTE_LOG_NOTICE, RTE_LOGTYPE_USER1, fmt, ap);
+	va_end(ap);
+}
+
 /** Consider aligning with 8 bytes to multiply point size with 2.*/
 #define DPAA2_SEC_SIMPLE_FD_OB_MIN \
 	((-SEC_FLC_DHR_OUTBOUND) + sizeof(void *) * 2)
@@ -98,11 +108,6 @@
 
 struct dpaa2_queue;
 
-struct eqresp_metadata {
-	struct dpaa2_queue *dpaa2_q;
-	struct rte_mempool *mp;
-};
-
 #define DPAA2_PORTAL_DEQUEUE_DEPTH	32
 struct dpaa2_portal_dqrr {
 	struct rte_mbuf *mbuf[DPAA2_PORTAL_DEQUEUE_DEPTH];
@@ -116,10 +121,6 @@ struct dpaa2_dpio_dev {
 	uint16_t index; /**< Index of a instance in the list */
 	RTE_ATOMIC(uint16_t) ref_count;
 		/**< How many thread contexts are sharing this.*/
-	uint16_t eqresp_ci;
-	uint16_t eqresp_pi;
-	struct qbman_result *eqresp;
-	struct eqresp_metadata *eqresp_meta;
 	struct fsl_mc_io *dpio; /** handle to DPIO portal object */
 	uint16_t token;
 	struct qbman_swp *sw_portal; /** SW portal object */
@@ -168,8 +169,18 @@ typedef void (dpaa2_queue_cb_dqrr_t)(struct dpaa2_dpio_dev *dpio_dev,
 		struct dpaa2_queue *rxq,
 		struct rte_event *ev);
 
-typedef void (dpaa2_queue_cb_eqresp_free_t)(uint16_t eqresp_ci,
-					struct dpaa2_queue *dpaa2_q);
+typedef void (dpaa2_eqresp_cb)(const struct qbman_fd *fd,
+	struct dpaa2_queue *dpaa2_q, struct rte_mbuf **pm);
+
+#define DPAA2_EQRESP_MAX_NUM (MAX_TX_RING_SLOTS * 4)
+
+struct dpaa2_queue_eq_resp {
+	struct qbman_result *eqresp_pool;
+	uint32_t pool_len;
+	uint16_t active_h;
+	uint16_t active_t;
+	dpaa2_eqresp_cb *cb;
+};
 
 struct __rte_cache_aligned dpaa2_queue {
 	struct rte_mempool *mb_pool; /**< mbuf pool to populate RX ring. */
@@ -191,11 +202,11 @@ struct __rte_cache_aligned dpaa2_queue {
 	};
 	void *cfg;
 	uint8_t options;
+	struct dpaa2_queue_eq_resp eq_resp;
 	struct rte_event ev;
 	struct rte_mempool *env_pool;
 	uint8_t event_attached;
 	dpaa2_queue_cb_dqrr_t *cb;
-	dpaa2_queue_cb_eqresp_free_t *cb_eqresp_free;
 	struct dpaa2_bp_info *bp_array;
 	/*to store tx_conf_queue corresponding to tx_queue*/
 	struct dpaa2_queue *tx_conf_queue;
@@ -520,6 +531,13 @@ dpaa2_mem_va_to_iova_check(void *va, uint64_t size)
 	} \
 })
 
+#define dpaa2_mbuf_seq_order_set(mbuf, id, seqnum) \
+({ \
+	*dpaa2_seqn(mbuf) = DPAA2_ENQUEUE_FLAG_ORP; \
+	*dpaa2_seqn(mbuf) |= id << DPAA2_EQCR_OPRID_SHIFT; \
+	*dpaa2_seqn(mbuf) |= seqnum << DPAA2_EQCR_SEQNUM_SHIFT; \
+})
+
 #define dpaa2_mbuf_seq_restore(mbuf, restore) \
 ({ \
 	*dpaa2_seqn(mbuf) = restore; \
@@ -565,6 +583,127 @@ dpaa2_dq_atomic_save(const struct qbman_result *dq,
 	dpio_dev->dpaa2_held_bufs.mbuf[dqrr_index] = mbuf;
 }
 
+static inline void
+dpaa2_dq_order_save(const struct qbman_result *dq,
+	struct rte_mbuf *mbuf)
+{
+	uint32_t odpid = qbman_result_DQ_odpid(dq);
+	uint32_t seqnum = qbman_result_DQ_seqnum(dq);
+
+#ifdef DPAA2_ORDER_DEBUG
+	if (odpid > DPAA2_EQCR_OPRID_MASK) {
+		dpaa2_hw_dump("Critical! too large odp ID(%d)\n", odpid);
+		return;
+	}
+	if (seqnum > DPAA2_EQCR_SEQNUM_MASK) {
+		dpaa2_hw_dump("Critical! Order seq number(%d) overflows\n", seqnum);
+		return;
+	}
+#endif
+	dpaa2_mbuf_seq_order_set(mbuf, odpid, seqnum);
+}
+
+static inline int
+dpaa2_queue_eqresp_create(struct dpaa2_queue *queue,
+	dpaa2_eqresp_cb *cb)
+{
+	struct dpaa2_queue_eq_resp *eq_resp = &queue->eq_resp;
+
+	eq_resp->eqresp_pool = rte_zmalloc(NULL,
+		sizeof(struct qbman_result) * DPAA2_EQRESP_MAX_NUM,
+		RTE_CACHE_LINE_SIZE);
+	if (!eq_resp->eqresp_pool)
+		return -ENOBUFS;
+	eq_resp->pool_len = DPAA2_EQRESP_MAX_NUM;
+	eq_resp->active_h = 0;
+	eq_resp->active_t = 0;
+	eq_resp->cb = cb;
+
+	return 0;
+}
+
+static inline void
+dpaa2_enq_rsp_process(struct dpaa2_queue *txq, uint16_t num)
+{
+	uint16_t i, idx = 0;
+	struct dpaa2_queue_eq_resp *eq_resp = &txq->eq_resp;
+	struct qbman_result *eqresp;
+	struct rte_mbuf *m, *mbufs[MAX_TX_RING_SLOTS];
+
+	if (likely(eq_resp->active_h == eq_resp->active_t))
+		return;
+
+	num = num > MAX_TX_RING_SLOTS ? MAX_TX_RING_SLOTS : num;
+
+	for (i = 0; i < num; i++) {
+		eqresp = &eq_resp->eqresp_pool[eq_resp->active_h];
+		if (!qbman_result_eqresp_rspid(eqresp))
+			break;
+		if (!qbman_result_eqresp_rc(eqresp))
+			goto hw_rsp;
+
+		m = NULL;
+		eq_resp->cb(qbman_result_eqresp_fd(eqresp), txq, &m);
+		if (m && (!idx || mbufs[0]->pool == m->pool)) {
+			mbufs[idx] = m;
+			idx++;
+		} else if (m) {
+			rte_pktmbuf_free(m);
+		}
+hw_rsp:
+		qbman_result_eqresp_set_rspid(eqresp, 0);
+		eq_resp->active_h = (eq_resp->active_h + 1) & (eq_resp->pool_len - 1);
+		if (eq_resp->active_h == eq_resp->active_t)
+			break;
+	}
+	if (idx)
+		rte_pktmbuf_free_bulk(mbufs, idx);
+}
+
+static inline int
+dpaa2_eq_set_order_desc(struct dpaa2_queue *dpaa2_q, struct rte_mbuf *m,
+	struct qbman_eq_desc *eqdesc, int loose_ordered)
+{
+	uint16_t orpid, seqnum, next;
+	int rsp;
+	struct qbman_result *eqresp;
+	struct dpaa2_queue_eq_resp *eq_resp = &dpaa2_q->eq_resp;
+
+	qbman_eq_desc_set_fq(eqdesc, dpaa2_q->fqid);
+	orpid = (*dpaa2_seqn(m) >> DPAA2_EQCR_OPRID_SHIFT) & DPAA2_EQCR_OPRID_MASK;
+	seqnum = (*dpaa2_seqn(m) >> DPAA2_EQCR_SEQNUM_SHIFT) & DPAA2_EQCR_SEQNUM_MASK;
+	rsp = loose_ordered ? 0 : 1;
+	qbman_eq_desc_set_orp(eqdesc, rsp, orpid, seqnum, 0);
+	if (loose_ordered) {
+		qbman_eq_desc_set_response(eqdesc, 0, 0);
+		goto orp_quit;
+	}
+
+	next = (eq_resp->active_t + 1) & (eq_resp->pool_len - 1);
+	if (next == eq_resp->active_h)
+		return -EAGAIN;
+	eqresp = &eq_resp->eqresp_pool[eq_resp->active_t];
+	qbman_eq_desc_set_response(eqdesc, DPAA2_VADDR_TO_IOVA(eqresp), 1);
+	qbman_eq_desc_set_token(eqdesc, 1);
+	eq_resp->active_t = next;
+orp_quit:
+	*dpaa2_seqn(m) = DPAA2_INVALID_MBUF_SEQN;
+
+	return 0;
+}
+
+static inline void
+dpaa2_queue_eqresp_free(struct dpaa2_queue *queue)
+{
+	while (queue->eq_resp.active_h != queue->eq_resp.active_t)
+		dpaa2_enq_rsp_process(queue, 1);
+	if (queue->eq_resp.eqresp_pool)
+		rte_free(queue->eq_resp.eqresp_pool);
+	queue->eq_resp.active_h = 0;
+	queue->eq_resp.active_t = 0;
+	queue->eq_resp.pool_len = 0;
+}
+
 static inline
 int check_swp_active_dqs(uint16_t dpio_index)
 {
diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index 8e0db6a385..f51c231b99 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -1502,47 +1502,6 @@ build_sec_fd(struct rte_crypto_op *op,
 	return ret;
 }
 
-static void
-dpaa2_sec_set_enqueue_descriptor(struct dpaa2_queue *dpaa2_q,
-	struct rte_mbuf *m, struct qbman_eq_desc *eqdesc)
-{
-	struct dpaa2_dpio_dev *dpio_dev = DPAA2_PER_LCORE_DPIO;
-	struct eqresp_metadata *eqresp_meta;
-	struct dpaa2_sec_dev_private *priv = dpaa2_q->crypto_data->dev_private;
-	uint16_t orpid, seqnum;
-	uint8_t dq_idx;
-
-	if (dpaa2_mbuf_seq_is_flag_set(m, DPAA2_ENQUEUE_FLAG_ORP)) {
-		orpid = (*dpaa2_seqn(m) & DPAA2_EQCR_OPRID_MASK) >>
-			DPAA2_EQCR_OPRID_SHIFT;
-		seqnum = (*dpaa2_seqn(m) & DPAA2_EQCR_SEQNUM_MASK) >>
-			DPAA2_EQCR_SEQNUM_SHIFT;
-
-		if (!priv->en_loose_ordered) {
-			qbman_eq_desc_set_orp(eqdesc, 1, orpid, seqnum, 0);
-			qbman_eq_desc_set_response(eqdesc, (uint64_t)
-				DPAA2_VADDR_TO_IOVA(&dpio_dev->eqresp[
-				dpio_dev->eqresp_pi]), 1);
-			qbman_eq_desc_set_token(eqdesc, 1);
-
-			eqresp_meta = &dpio_dev->eqresp_meta[dpio_dev->eqresp_pi];
-			eqresp_meta->dpaa2_q = dpaa2_q;
-			eqresp_meta->mp = m->pool;
-
-			dpio_dev->eqresp_pi + 1 < MAX_EQ_RESP_ENTRIES ?
-				dpio_dev->eqresp_pi++ : (dpio_dev->eqresp_pi = 0);
-		} else {
-			qbman_eq_desc_set_orp(eqdesc, 0, orpid, seqnum, 0);
-		}
-	} else {
-		dq_idx = *dpaa2_seqn(m) & QBMAN_EQCR_DCA_IDXMASK;
-		qbman_eq_desc_set_dca(eqdesc, 1, dq_idx, 0);
-		DPAA2_PER_LCORE_DQRR_SIZE--;
-		DPAA2_PER_LCORE_DQRR_HELD &= ~(UINT64_C(1) << dq_idx);
-	}
-	*dpaa2_seqn(m) = DPAA2_INVALID_MBUF_SEQN;
-}
-
 static uint16_t
 dpaa2_sec_enqueue_burst_ordered(void *qp, struct rte_crypto_op **ops,
 	uint16_t nb_ops)
@@ -1550,7 +1509,7 @@ dpaa2_sec_enqueue_burst_ordered(void *qp, struct rte_crypto_op **ops,
 	/* Function to transmit the frames to given device and VQ*/
 	int32_t ret, atomic = false;
 	struct qbman_fd fd_arr[MAX_TX_RING_SLOTS];
-	uint32_t num_free_eq_desc, retry_count, flags[MAX_TX_RING_SLOTS];
+	uint32_t retry_count, flags[MAX_TX_RING_SLOTS];
 	struct qbman_eq_desc eqdesc[MAX_TX_RING_SLOTS];
 	struct dpaa2_sec_qp *dpaa2_qp = qp;
 	struct qbman_swp *swp;
@@ -1576,31 +1535,24 @@ dpaa2_sec_enqueue_burst_ordered(void *qp, struct rte_crypto_op **ops,
 		}
 	}
 	swp = DPAA2_PER_LCORE_PORTAL;
+	dpaa2_enq_rsp_process(&dpaa2_qp->tx_vq, nb_ops);
 
 	while (nb_ops) {
 		frames_to_send = (nb_ops > dpaa2_eqcr_size) ? dpaa2_eqcr_size : nb_ops;
 
-		if (!priv->en_loose_ordered) {
-			if (dpaa2_mbuf_seq_is_flag_set((*ops)->sym->m_src,
-				DPAA2_ENQUEUE_FLAG_ORP)) {
-				num_free_eq_desc = dpaa2_free_eq_descriptors();
-				if (num_free_eq_desc < frames_to_send)
-					frames_to_send = num_free_eq_desc;
-			}
-		}
-
 		for (loop = 0; loop < frames_to_send; loop++) {
 			/*Prepare enqueue descriptor*/
 			qbman_eq_desc_clear(&eqdesc[loop]);
-			qbman_eq_desc_set_fq(&eqdesc[loop], dpaa2_qp->tx_vq.fqid);
 			mbuf[loop] = (*ops)->sym->m_src;
 
 			flags[loop] = 0;
 			dqrr_size[loop] = 0;
 			dqrr_held[loop] = 0;
 			if (dpaa2_mbuf_seq_is_flag_set(mbuf[loop], DPAA2_ENQUEUE_FLAG_ORP)) {
-				dpaa2_sec_set_enqueue_descriptor(&dpaa2_qp->tx_vq,
-					mbuf[loop], &eqdesc[loop]);
+				ret = dpaa2_eq_set_order_desc(&dpaa2_qp->tx_vq, mbuf[loop],
+					&eqdesc[loop], priv->en_loose_ordered);
+				if (ret)
+					goto skip_tx;
 			} else {
 				if (dpaa2_mbuf_seq_is_flag_set(mbuf[loop],
 					QBMAN_ENQUEUE_FLAG_DCA)) {
@@ -1608,6 +1560,7 @@ dpaa2_sec_enqueue_burst_ordered(void *qp, struct rte_crypto_op **ops,
 						dqrr_held[loop], DPAA2_PER_LCORE_DPIO,
 						&flags[loop], &eqdesc[loop], atomic);
 				}
+				qbman_eq_desc_set_fq(&eqdesc[loop], dpaa2_qp->tx_vq.fqid);
 				qbman_eq_desc_set_no_orp(&eqdesc[loop], DPAA2_EQ_RESP_ERR_FQ);
 			}
 
@@ -1954,21 +1907,21 @@ dpaa2_sec_dump(struct rte_crypto_op *op, FILE *f)
 }
 
 static void
-dpaa2_sec_free_eqresp_buf(uint16_t eqresp_ci,
-			  struct dpaa2_queue *dpaa2_q)
+dpaa2_sec_eqresp_cb(const struct qbman_fd *fd, struct dpaa2_queue *dpaa2_q,
+	struct rte_mbuf **pm)
 {
-	struct dpaa2_dpio_dev *dpio_dev = DPAA2_PER_LCORE_DPIO;
 	struct rte_crypto_op *op;
-	struct qbman_fd *fd;
 	struct dpaa2_sec_qp *dpaa2_qp;
 
 	dpaa2_qp = container_of(dpaa2_q, struct dpaa2_sec_qp, tx_vq);
-	fd = qbman_result_eqresp_fd(&dpio_dev->eqresp[eqresp_ci]);
 	op = dpaa2_sec_fd_to_mbuf(fd, dpaa2_qp);
 	/* Instead of freeing, enqueue it to the sec tx queue (sec->core)
 	 * after setting an error in FD. But this will have performance impact.
 	 */
-	rte_pktmbuf_free(op->sym->m_src);
+	if (pm)
+		*pm = op->sym->m_src;
+	else
+		rte_pktmbuf_free(op->sym->m_src);
 }
 
 static uint16_t
@@ -2083,6 +2036,7 @@ dpaa2_sec_queue_pair_release(struct rte_cryptodev *dev, uint16_t queue_pair_id)
 
 	dpaa2_queue_storage_free(&qp->rx_vq, 1);
 	rte_mempool_free(qp->fle_pool);
+	dpaa2_queue_eqresp_free(&qp->tx_vq);
 	rte_free(qp);
 
 	dev->data->queue_pairs[queue_pair_id] = NULL;
@@ -2153,6 +2107,14 @@ dpaa2_sec_queue_pair_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 		return -ENOMEM;
 	}
 
+	retcode = dpaa2_queue_eqresp_create(&qp->tx_vq, dpaa2_sec_eqresp_cb);
+	if (retcode) {
+		rte_mempool_free(qp->fle_pool);
+		qp->fle_pool = NULL;
+		dpaa2_queue_storage_free((&qp->rx_vq), 1);
+		return retcode;
+	}
+
 	cfg.dest_cfg.dest_type = DPSECI_DEST_NONE;
 	retcode = dpseci_set_rx_queue(dpseci, CMD_PRI_LOW, priv->token,
 				      qp_id, &cfg);
@@ -4156,11 +4118,7 @@ dpaa2_sec_process_ordered_event(struct dpaa2_dpio_dev *dpio_dev,
 	ev->priority = rxq->ev.priority;
 	crypto_op = dpaa2_sec_fd_to_mbuf(fd, qp);
 
-	*dpaa2_seqn(crypto_op->sym->m_src) = DPAA2_ENQUEUE_FLAG_ORP;
-	*dpaa2_seqn(crypto_op->sym->m_src) |= qbman_result_DQ_odpid(dq) <<
-		DPAA2_EQCR_OPRID_SHIFT;
-	*dpaa2_seqn(crypto_op->sym->m_src) |= qbman_result_DQ_seqnum(dq) <<
-		DPAA2_EQCR_SEQNUM_SHIFT;
+	dpaa2_dq_order_save(dq, crypto_op->sym->m_src);
 
 	qbman_swp_dqrr_consume(swp, dq);
 	ev->event_ptr = crypto_op;
@@ -4231,7 +4189,6 @@ dpaa2_sec_eventq_attach(const struct rte_cryptodev *dev,
 			DPAA2_SEC_ERR("Error setting opr: ret: %d", ret);
 			return ret;
 		}
-		qp->tx_vq.cb_eqresp_free = dpaa2_sec_free_eqresp_buf;
 		priv->en_ordered = 1;
 	}
 
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 85c93bf422..b75625dc01 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1192,6 +1192,7 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 		/* cleanup tx queue cscn */
 		for (i = 0; i < priv->nb_tx_queues; i++) {
 			dpaa2_q = priv->tx_vq[i];
+			dpaa2_queue_eqresp_free(dpaa2_q);
 			rte_free(dpaa2_q->cscn);
 			priv->tx_vq[i] = NULL;
 		}
@@ -1858,7 +1859,9 @@ dpaa2_dev_tx_queue_setup(struct rte_eth_dev *dev,
 			return ret;
 		}
 	}
-	dpaa2_q->cb_eqresp_free = dpaa2_dev_free_eqresp_buf;
+	ret = dpaa2_queue_eqresp_create(dpaa2_q, dpaa2_dev_eqresp_cb);
+	if (ret)
+		return ret;
 	dev->data->tx_queues[tx_queue_id] = dpaa2_q;
 
 	if (priv->tx_conf_type != DPAA2_TX_NO_CONF) {
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index caf3fabee7..491ad78d85 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -977,7 +977,8 @@ __rte_internal
 uint16_t dpaa2_dev_tx_multi_txq_ordered(struct dpaa2_queue **dpaa2_q,
 	struct rte_mbuf **bufs, uint16_t nb_pkts);
 
-void dpaa2_dev_free_eqresp_buf(uint16_t eqresp_ci, struct dpaa2_queue *dpaa2_q);
+void dpaa2_dev_eqresp_cb(const struct qbman_fd *fd,
+	struct dpaa2_queue *dpaa2_q, struct rte_mbuf **pm);
 void dpaa2_flow_clean(struct rte_eth_dev *dev, uint8_t tc_id,
 	enum dpaa2_flow_dist_type type);
 uint16_t dpaa2_dev_tx_conf(struct dpaa2_queue *tx_conf_q, int drain);
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 149fabc0e2..fec046deaf 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -1250,9 +1250,7 @@ dpaa2_dev_process_ordered_event(struct dpaa2_dpio_dev *dpio_dev,
 	else
 		ev->mbuf = dpaa2_eth_fd_to_mbuf(rxq->eth_data->dev_private, fd);
 
-	*dpaa2_seqn(ev->mbuf) = DPAA2_ENQUEUE_FLAG_ORP;
-	*dpaa2_seqn(ev->mbuf) |= qbman_result_DQ_odpid(dq) << DPAA2_EQCR_OPRID_SHIFT;
-	*dpaa2_seqn(ev->mbuf) |= qbman_result_DQ_seqnum(dq) << DPAA2_EQCR_SEQNUM_SHIFT;
+	dpaa2_dq_order_save(dq, ev->mbuf);
 
 	qbman_swp_dqrr_consume(swp, dq);
 }
@@ -1665,84 +1663,35 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 }
 
 void
-dpaa2_dev_free_eqresp_buf(uint16_t eqresp_ci,
-			  __rte_unused struct dpaa2_queue *dpaa2_q)
+dpaa2_dev_eqresp_cb(const struct qbman_fd *fd,
+	struct dpaa2_queue *dpaa2_q, struct rte_mbuf **pm)
 {
-	struct dpaa2_dpio_dev *dpio_dev = DPAA2_PER_LCORE_DPIO;
-	struct qbman_fd *fd;
 	struct rte_mbuf *m;
 
-	fd = qbman_result_eqresp_fd(&dpio_dev->eqresp[eqresp_ci]);
-
 	/* Setting port id does not matter as we are to free the mbuf */
 	if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
 		m = dpaa2_eth_sg_fd_to_mbuf(dpaa2_q->eth_data->dev_private, fd);
 	else
 		m = dpaa2_eth_fd_to_mbuf(dpaa2_q->eth_data->dev_private, fd);
-	if (m)
+	if (pm)
+		*pm = m;
+	else if (m)
 		rte_pktmbuf_free(m);
 }
 
-static void
-dpaa2_set_enqueue_descriptor(struct dpaa2_queue *dpaa2_q,
-	struct rte_mbuf *m, struct qbman_eq_desc *eqdesc)
-{
-	struct dpaa2_dev_priv *priv = dpaa2_q->eth_data->dev_private;
-	struct dpaa2_dpio_dev *dpio_dev = DPAA2_PER_LCORE_DPIO;
-	struct eqresp_metadata *eqresp_meta;
-	uint16_t orpid, seqnum;
-	uint8_t dq_idx;
-
-	qbman_eq_desc_set_fq(eqdesc, dpaa2_q->fqid);
-
-	if (dpaa2_mbuf_seq_is_flag_set(m, DPAA2_ENQUEUE_FLAG_ORP)) {
-		orpid = (*dpaa2_seqn(m) & DPAA2_EQCR_OPRID_MASK) >>
-			DPAA2_EQCR_OPRID_SHIFT;
-		seqnum = (*dpaa2_seqn(m) & DPAA2_EQCR_SEQNUM_MASK) >>
-			DPAA2_EQCR_SEQNUM_SHIFT;
-
-		if (!priv->en_loose_ordered) {
-			qbman_eq_desc_set_orp(eqdesc, 1, orpid, seqnum, 0);
-			qbman_eq_desc_set_response(eqdesc, (uint64_t)
-				DPAA2_VADDR_TO_IOVA(&dpio_dev->eqresp[
-				dpio_dev->eqresp_pi]), 1);
-			qbman_eq_desc_set_token(eqdesc, 1);
-
-			eqresp_meta = &dpio_dev->eqresp_meta[
-				dpio_dev->eqresp_pi];
-			eqresp_meta->dpaa2_q = dpaa2_q;
-			eqresp_meta->mp = m->pool;
-
-			dpio_dev->eqresp_pi + 1 < MAX_EQ_RESP_ENTRIES ?
-				dpio_dev->eqresp_pi++ :
-				(dpio_dev->eqresp_pi = 0);
-		} else {
-			qbman_eq_desc_set_orp(eqdesc, 0, orpid, seqnum, 0);
-		}
-	} else {
-		dq_idx = *dpaa2_seqn(m) & QBMAN_EQCR_DCA_IDXMASK;
-		qbman_eq_desc_set_dca(eqdesc, 1, dq_idx, 0);
-		DPAA2_PER_LCORE_DQRR_SIZE--;
-		DPAA2_PER_LCORE_DQRR_HELD &= ~(UINT64_C(1) << dq_idx);
-	}
-	*dpaa2_seqn(m) = DPAA2_INVALID_MBUF_SEQN;
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dev_tx_multi_txq_ordered)
 uint16_t
 dpaa2_dev_tx_multi_txq_ordered(struct dpaa2_queue **dpaa2_q,
 	struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
 	/* Function to transmit the frames to multiple queues respectively.*/
-	uint32_t loop, retry_count, i;
+	uint32_t loop, retry_count, i, frames_to_send;
 	int32_t ret = 0, tstamp[MAX_TX_RING_SLOTS], ptp_n, ptp_set, atomic = false;
 	struct qbman_fd fd_arr[MAX_TX_RING_SLOTS];
-	uint32_t frames_to_send, num_free_eq_desc = 0;
 	struct rte_mempool *hw_mp;
 	struct qbman_eq_desc eqdesc[MAX_TX_RING_SLOTS];
 	struct qbman_swp *swp;
 	struct dpaa2_dev_priv *priv;
-	struct dpaa2_queue *order_sendq;
 	struct dpaa2_queue *cnf_q;
 	uint8_t dqrr_size[MAX_TX_RING_SLOTS];
 	uint64_t dqrr_held[MAX_TX_RING_SLOTS];
@@ -1757,24 +1706,14 @@ dpaa2_dev_tx_multi_txq_ordered(struct dpaa2_queue **dpaa2_q,
 		}
 	}
 	swp = DPAA2_PER_LCORE_PORTAL;
+	for (loop = 0; loop < nb_pkts; loop++)
+		dpaa2_enq_rsp_process(dpaa2_q[loop], 1);
 
 	ptp_n = 0;
-	frames_to_send = (nb_pkts > dpaa2_eqcr_size) ?
-		dpaa2_eqcr_size : nb_pkts;
+	frames_to_send = (nb_pkts > dpaa2_eqcr_size) ? dpaa2_eqcr_size : nb_pkts;
 
 	for (loop = 0; loop < frames_to_send; loop++) {
 		priv = dpaa2_q[loop]->eth_data->dev_private;
-		if (!priv->en_loose_ordered &&
-			dpaa2_mbuf_seq_is_flag_set(bufs[loop], DPAA2_ENQUEUE_FLAG_ORP)) {
-			if (!num_free_eq_desc) {
-				num_free_eq_desc = dpaa2_free_eq_descriptors();
-				if (!num_free_eq_desc) {
-					ret = -EIO;
-					goto send_frames;
-				}
-			}
-			num_free_eq_desc--;
-		}
 
 		/* Check if the queue is congested */
 		retry_count = 0;
@@ -1794,8 +1733,10 @@ dpaa2_dev_tx_multi_txq_ordered(struct dpaa2_queue **dpaa2_q,
 		dqrr_size[loop] = 0;
 		if (dpaa2_mbuf_seq_is_flag_set(bufs[loop], DPAA2_ENQUEUE_FLAG_ORP) &&
 			priv->en_ordered) {
-			order_sendq = priv->tx_vq[0];
-			dpaa2_set_enqueue_descriptor(order_sendq, bufs[loop], &eqdesc[loop]);
+			ret = dpaa2_eq_set_order_desc(priv->tx_vq[0], bufs[loop], &eqdesc[loop],
+				priv->en_loose_ordered);
+			if (ret)
+				goto send_frames;
 		} else {
 			qbman_eq_desc_set_no_orp(&eqdesc[loop], DPAA2_EQ_RESP_ERR_FQ);
 			qbman_eq_desc_set_fq(&eqdesc[loop], dpaa2_q[loop]->fqid);
-- 
2.43.0

