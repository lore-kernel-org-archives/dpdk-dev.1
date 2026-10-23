Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8440606A321
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:50:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40D7540BA3;
	Fri, 23 Oct 2026 15:45:15 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 57A1E40E38
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:59 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 39FBD1A0041;
 Fri, 23 Oct 2026 15:44:59 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CE76A1A0043;
 Fri, 23 Oct 2026 15:44:58 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C9D4E180006C;
 Fri, 23 Oct 2026 21:44:57 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 62/65] bus/fslmc: make DPAA2 ORP/ODP ordering per-queue
 instead of per-device
Date: Fri, 23 Oct 2026 19:13:42 +0530
Message-ID: <20261023134346.37727-63-prashant.gupta_3@nxp.com>
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

The DPAA2 ORP (Order Restoration Point) / ODP ordering state used to be
tracked with device-wide flags (en_ordered / en_loose_ordered in both
dpaa2_sec_dev_private and dpaa2_dev_priv). That is fundamentally wrong:
ORP/ODP is a per-queue property on DPAA2 hardware -- different RX queues
on the same DPNI / DPSECI / DPCI can independently be configured as
unordered, atomic (hold-active), loose-ORP or strict-ORP. Collapsing it
to a single per-device flag meant the first queue's ordering mode
silently dictated the behavior of all others, and prevented mixing
ordering modes on one device.

This patch moves the ordering mode onto struct dpaa2_queue itself and
refactors all DPAA2 drivers to consult that per-queue field on both the
RX (dequeue/order-save) and TX (enqueue/order-restore) paths.

Main changes:

 - drivers/bus/fslmc (common):
   * New enum dpaa2_queue_order_type { NONE, HOLD_ACTIVE, LOOSE_ORP,
     STRICT_ORP } and a matching order_type field in struct dpaa2_queue
     -- this is now the single source of truth, per queue.
   * New dpaa2_orp_config_helper() centralizing struct opr_cfg setup
     (oprrws per SoC, oa, olws, oeane, oloe) for strict vs loose ORP,
     replacing three near-identical copies that lived in the sec/eth
     drivers.
   * Encode the strict/loose bit into the mbuf seqn (new
     DPAA2_EQCR_STRICT_SHIFT/MASK; OPRID mask narrowed to 0x1FFF to make
     room). dpaa2_mbuf_seq_order_set() and dpaa2_dq_order_save() now
     carry the per-queue ordering type end-to-end, so TX no longer has
     to look up any device-level flag.
   * dpaa2_eq_set_order_desc() derives the ORP response/strict flag
     from the mbuf seqn instead of a per-call loose_ordered argument.
   * rte_dpaa2_dpci_link_attach() gains an order_type parameter and
     programs DPCI_QUEUE_OPT_HOLD_ACTIVE / order_preservation_en /
     dpci_set_opr() per queue, recording the result on that RX queue.

- drivers/crypto/dpaa2_sec:
   * Remove device-wide en_ordered from dpaa2_sec_dev_private.
   * dpaa2_sec_eventq_attach() uses dpaa2_orp_config_helper() and
     stores the chosen order_type on the SEC qp's rx_vq.
   * Ordered enqueue and dpaa2_sec_process_ordered_event() consult the
     per-queue order_type rather than the removed device flags.

 - drivers/event/dpaa2:
   * Pass the appropriate per-queue order_type (NONE / HOLD_ACTIVE /
     LOOSE_ORP) when attaching parallel/atomic/ordered DPCI queues.
   * Enqueue and process-order paths use the new per-queue API.

 - drivers/net/dpaa2:
   * Remove en_ordered / en_loose_ordered from dpaa2_dev_priv.
   * dpaa2_eth_eventq_attach() uses dpaa2_orp_config_helper(),
     honoring DPAA2_STRICT_ORDERING_ENABLE, and records the resulting
     order_type on the specific RXQ being attached.
   * tx_multi_txq_ordered() and process_ordered_event() use the
     per-queue order_type instead of device-level flags.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 doc/guides/nics/dpaa2.rst                   |  4 +
 drivers/bus/fslmc/portal/dpaa2_hw_dpci.c    | 81 +++++++++++++++++----
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h     | 56 ++++++++++++--
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c | 41 ++++-------
 drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h   |  1 -
 drivers/event/dpaa2/dpaa2_eventdev.c        | 10 +--
 drivers/event/dpaa2/dpaa2_scheduler.c       |  2 +-
 drivers/net/dpaa2/dpaa2_ethdev.c            | 44 ++++-------
 drivers/net/dpaa2/dpaa2_ethdev.h            |  4 +-
 drivers/net/dpaa2/dpaa2_rxtx.c              |  8 +-
 10 files changed, 158 insertions(+), 93 deletions(-)

diff --git a/doc/guides/nics/dpaa2.rst b/doc/guides/nics/dpaa2.rst
index 6c67a76f12..4d927cefc2 100644
--- a/doc/guides/nics/dpaa2.rst
+++ b/doc/guides/nics/dpaa2.rst
@@ -503,6 +503,10 @@ Refer to the document :doc:`build_and_test` for details.
   create, destroy and update operations.
   e.g. ``fslmc:dpni.1,drv_flow_api_debug=1``
 
+* Use dev arg option ``drv_queue_strict_order=1`` to enable strict ordering on
+  the ordered event queue.
+  e.g. ``fslmc:dpni.1,drv_queue_strict_order=1``
+
 * Use dev arg option  ``drv_error_queue=1`` to enable Packets in Error queue.
   DPAA2 hardware drops the error packet in hardware. This option enables the
   hardware to not drop the error packet and let the driver dump the error
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c
index f796875010..680249cf95 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c
@@ -259,15 +259,50 @@ dpaa2_close_dpci_device(int object_id)
 	}
 }
 
+static int
+dpaa2_dpci_set_opr(struct dpaa2_dpci_dev *dpci_dev, uint8_t rxq_idx, int strict)
+{
+	int ret, orp_ret;
+	struct opr_cfg ocfg;
+
+	dpaa2_orp_config_helper(&ocfg, strict);
+
+	ret = dpci_disable(&dpci_dev->dpci, CMD_PRI_LOW, dpci_dev->token);
+	if (ret) {
+		DPAA2_BUS_ERR("Failed(%d) to disable DPCI.%d before setting opr",
+			ret, dpci_dev->dpci_id);
+		return ret;
+	}
+
+	orp_ret = dpci_set_opr(&dpci_dev->dpci, CMD_PRI_LOW, dpci_dev->token,
+		rxq_idx, OPR_OPT_CREATE, &ocfg);
+	if (orp_ret) {
+		DPAA2_BUS_ERR("Failed(%d) to set opr of DPCI.%d's rxq.%d",
+			orp_ret, dpci_dev->dpci_id, rxq_idx);
+		/** Enable anyway.*/
+	}
+
+	ret = dpci_enable(&dpci_dev->dpci, CMD_PRI_LOW, dpci_dev->token);
+	if (ret) {
+		DPAA2_BUS_ERR("Failed(%d) to enable DPCI.%d after setting opr",
+			ret, dpci_dev->dpci_id);
+		return ret;
+	}
+
+	return orp_ret;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_dpci_link_attach)
 int
 rte_dpaa2_dpci_link_attach(struct dpaa2_dpci_dev *dpci_dev,
 	enum dpci_dest dest_type, uint32_t dest_id, uint8_t priority,
-	dpaa2_queue_cb_dqrr_t *rx_cb, struct dpaa2_queue **txq)
+	dpaa2_queue_cb_dqrr_t *rx_cb, enum dpaa2_queue_order_type order_type,
+	struct dpaa2_queue **txq)
 {
+	struct dpaa2_queue *rx_queue = NULL;
 	struct dpci_rx_queue_cfg rx_queue_cfg;
 	uint16_t i;
-	int ret;
+	int ret, strict = false;
 	struct dpaa2_dpci_dev *peer_dpci;
 
 	memset(&rx_queue_cfg, 0, sizeof(struct dpci_rx_queue_cfg));
@@ -282,24 +317,43 @@ rte_dpaa2_dpci_link_attach(struct dpaa2_dpci_dev *dpci_dev,
 		}
 	}
 
-	/*Do settings to get the frame on a DPCON object*/
-	rx_queue_cfg.options = DPCI_QUEUE_OPT_DEST |
-		  DPCI_QUEUE_OPT_USER_CTX;
-	rx_queue_cfg.dest_cfg.dest_type = dest_type;
-	rx_queue_cfg.dest_cfg.dest_id = dest_id;
-	rx_queue_cfg.dest_cfg.priority = priority;
-	rx_queue_cfg.order_preservation_en = 0;
-
 	for (i = 0; i < dpci_dev->rx_queue_num; i++) {
-		if (!dpci_dev->rx_queue[i].cb)
+		if (!dpci_dev->rx_queue[i].event_attached)
 			break;
 	}
 	if (i >= dpci_dev->rx_queue_num || i >= dpci_dev->tx_queue_num) {
 		DPAA2_BUS_ERR("DPCI.%d No queue pair available!", dpci_dev->dpci_id);
 		return -EBUSY;
 	}
+	rx_queue = &dpci_dev->rx_queue[i];
+
+	rx_queue->order_type = DPAA2_QUEUE_NONE_ORDER;
+	/*Do settings to get the frame on a DPCON object*/
+	rx_queue_cfg.options = DPCI_QUEUE_OPT_DEST | DPCI_QUEUE_OPT_USER_CTX;
+	if (order_type == DPAA2_QUEUE_HOLD_ACTIVE_ORDER) {
+		rx_queue_cfg.options |= DPCI_QUEUE_OPT_HOLD_ACTIVE;
+		rx_queue_cfg.order_preservation_en = true;
+		rx_queue->order_type = DPAA2_QUEUE_HOLD_ACTIVE_ORDER;
+	} else {
+		rx_queue_cfg.order_preservation_en = false;
+		if (order_type == DPAA2_QUEUE_LOOSE_ORP_ORDER ||
+			order_type == DPAA2_QUEUE_STRICT_ORP_ORDER) {
+			if (order_type == DPAA2_QUEUE_STRICT_ORP_ORDER)
+				strict = true;
+			ret = dpaa2_dpci_set_opr(dpci_dev, i, strict);
+			if (ret)
+				return ret;
+			if (strict)
+				rx_queue->order_type = DPAA2_QUEUE_STRICT_ORP_ORDER;
+			else
+				rx_queue->order_type = DPAA2_QUEUE_LOOSE_ORP_ORDER;
+		}
+	}
+	rx_queue_cfg.dest_cfg.dest_type = dest_type;
+	rx_queue_cfg.dest_cfg.dest_id = dest_id;
+	rx_queue_cfg.dest_cfg.priority = priority;
 
-	rx_queue_cfg.user_ctx = (uint64_t)(&dpci_dev->rx_queue[i]);
+	rx_queue_cfg.user_ctx = (uint64_t)rx_queue;
 	ret = dpci_set_rx_queue(&dpci_dev->dpci, CMD_PRI_LOW,
 		dpci_dev->token, i, &rx_queue_cfg);
 	if (ret) {
@@ -307,8 +361,9 @@ rte_dpaa2_dpci_link_attach(struct dpaa2_dpci_dev *dpci_dev,
 			dpci_dev->dpci_id, i, ret);
 		return ret;
 	}
-	dpci_dev->rx_queue[i].cb = rx_cb;
+	rx_queue->cb = rx_cb;
 	dpci_dev->tx_queue[i].env_pool = peer_dpci->rx_queue[i].env_pool;
+	rx_queue->event_attached++;
 
 	if (txq)
 		*txq = &dpci_dev->tx_queue[i];
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index b9839eeb70..d7dc88ca35 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -53,9 +53,11 @@
 
 /* Flag to determine an ordered queue mbuf */
 #define DPAA2_ENQUEUE_FLAG_ORP		(1ULL << 30)
+#define DPAA2_EQCR_STRICT_SHIFT		29
+#define DPAA2_EQCR_STRICT_MASK		0x00000001
 /* ORP ID shift and mask */
 #define DPAA2_EQCR_OPRID_SHIFT		16
-#define DPAA2_EQCR_OPRID_MASK		0x00003FFF
+#define DPAA2_EQCR_OPRID_MASK		0x00001FFF
 /* Sequence number shift and mask */
 #define DPAA2_EQCR_SEQNUM_SHIFT		0
 #define DPAA2_EQCR_SEQNUM_MASK		0x0000FFFF
@@ -106,6 +108,35 @@ dpaa2_hw_dump(const char *fmt, ...)
 #define DPAA2_SEC_SIMPLE_FD_IB_MIN \
 	((-SEC_FLC_DHR_INBOUND) + sizeof(void *) * 2)
 
+enum dpaa2_queue_order_type {
+	DPAA2_QUEUE_NONE_ORDER,
+	DPAA2_QUEUE_HOLD_ACTIVE_ORDER,
+	DPAA2_QUEUE_LOOSE_ORP_ORDER,
+	DPAA2_QUEUE_STRICT_ORP_ORDER
+};
+
+static inline void
+dpaa2_orp_config_helper(struct opr_cfg *ocfg, int strict)
+{
+	memset(ocfg, 0, sizeof(struct opr_cfg));
+	/* Restoration window size = 256 frames */
+	ocfg->oprrws = 3;
+	/* Restoration window size = 512 frames for LX2 */
+	if (dpaa2_svr_family == SVR_LX2160A)
+		ocfg->oprrws = 4;
+	/* Auto advance NESN window enabled */
+	ocfg->oa = 1;
+	/* Late arrival window size disabled */
+	ocfg->olws = 0;
+	/* ORL resource exhaustion advance NESN disabled */
+	ocfg->oeane = 0;
+	/* Strict ordering enabled(loose ordering disabled) */
+	if (strict)
+		ocfg->oloe = 0;
+	else
+		ocfg->oloe = 1;
+}
+
 struct dpaa2_queue;
 
 #define DPAA2_PORTAL_DEQUEUE_DEPTH	32
@@ -191,6 +222,7 @@ struct __rte_cache_aligned dpaa2_queue {
 	uint32_t fqid;		/*!< Unique ID of this queue */
 	uint16_t flow_id;	/*!< To be used by DPAA2 framework */
 	uint8_t tc_index;	/*!< traffic class identifier */
+	enum dpaa2_queue_order_type order_type;
 	uint64_t rx_pkts;
 	uint64_t tx_pkts;
 	uint64_t err_pkts;
@@ -531,9 +563,10 @@ dpaa2_mem_va_to_iova_check(void *va, uint64_t size)
 	} \
 })
 
-#define dpaa2_mbuf_seq_order_set(mbuf, id, seqnum) \
+#define dpaa2_mbuf_seq_order_set(mbuf, id, seqnum, strict) \
 ({ \
 	*dpaa2_seqn(mbuf) = DPAA2_ENQUEUE_FLAG_ORP; \
+	*dpaa2_seqn(mbuf) |= strict << DPAA2_EQCR_STRICT_SHIFT; \
 	*dpaa2_seqn(mbuf) |= id << DPAA2_EQCR_OPRID_SHIFT; \
 	*dpaa2_seqn(mbuf) |= seqnum << DPAA2_EQCR_SEQNUM_SHIFT; \
 })
@@ -585,12 +618,18 @@ dpaa2_dq_atomic_save(const struct qbman_result *dq,
 
 static inline void
 dpaa2_dq_order_save(const struct qbman_result *dq,
-	struct rte_mbuf *mbuf)
+	struct rte_mbuf *mbuf, enum dpaa2_queue_order_type order_type)
 {
+	uint32_t strict = order_type == DPAA2_QUEUE_STRICT_ORP_ORDER ? 1 : 0;
 	uint32_t odpid = qbman_result_DQ_odpid(dq);
 	uint32_t seqnum = qbman_result_DQ_seqnum(dq);
 
 #ifdef DPAA2_ORDER_DEBUG
+	if (order_type != DPAA2_QUEUE_LOOSE_ORP_ORDER &&
+		order_type != DPAA2_QUEUE_STRICT_ORP_ORDER) {
+		dpaa2_hw_dump("Critical! Invalid order type(%d)\n", order_type);
+		return;
+	}
 	if (odpid > DPAA2_EQCR_OPRID_MASK) {
 		dpaa2_hw_dump("Critical! too large odp ID(%d)\n", odpid);
 		return;
@@ -600,7 +639,7 @@ dpaa2_dq_order_save(const struct qbman_result *dq,
 		return;
 	}
 #endif
-	dpaa2_mbuf_seq_order_set(mbuf, odpid, seqnum);
+	dpaa2_mbuf_seq_order_set(mbuf, odpid, seqnum, strict);
 }
 
 static inline int
@@ -662,7 +701,7 @@ dpaa2_enq_rsp_process(struct dpaa2_queue *txq, uint16_t num)
 
 static inline int
 dpaa2_eq_set_order_desc(struct dpaa2_queue *dpaa2_q, struct rte_mbuf *m,
-	struct qbman_eq_desc *eqdesc, int loose_ordered)
+	struct qbman_eq_desc *eqdesc)
 {
 	uint16_t orpid, seqnum, next;
 	int rsp;
@@ -672,9 +711,9 @@ dpaa2_eq_set_order_desc(struct dpaa2_queue *dpaa2_q, struct rte_mbuf *m,
 	qbman_eq_desc_set_fq(eqdesc, dpaa2_q->fqid);
 	orpid = (*dpaa2_seqn(m) >> DPAA2_EQCR_OPRID_SHIFT) & DPAA2_EQCR_OPRID_MASK;
 	seqnum = (*dpaa2_seqn(m) >> DPAA2_EQCR_SEQNUM_SHIFT) & DPAA2_EQCR_SEQNUM_MASK;
-	rsp = loose_ordered ? 0 : 1;
+	rsp = (*dpaa2_seqn(m) >> DPAA2_EQCR_STRICT_SHIFT) & DPAA2_EQCR_STRICT_MASK;
 	qbman_eq_desc_set_orp(eqdesc, rsp, orpid, seqnum, 0);
-	if (loose_ordered) {
+	if (!rsp) {
 		qbman_eq_desc_set_response(eqdesc, 0, 0);
 		goto orp_quit;
 	}
@@ -791,7 +830,8 @@ void rte_dpaa2_free_dpci_dev(struct dpaa2_dpci_dev *dpci);
 __rte_internal
 int rte_dpaa2_dpci_link_attach(struct dpaa2_dpci_dev *dpci_dev,
 	enum dpci_dest dest_type, uint32_t dest_id, uint8_t priority,
-	dpaa2_queue_cb_dqrr_t *rx_cb, struct dpaa2_queue **txq);
+	dpaa2_queue_cb_dqrr_t *rx_cb, enum dpaa2_queue_order_type order_type,
+	struct dpaa2_queue **txq);
 
 /* Global MCP pointer */
 __rte_internal
diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index f51c231b99..a88bf0fe8f 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -1515,7 +1515,6 @@ dpaa2_sec_enqueue_burst_ordered(void *qp, struct rte_crypto_op **ops,
 	struct qbman_swp *swp;
 	uint16_t num_tx = 0, bpid, frames_to_send, loop;
 	uint8_t dqrr_size[MAX_TX_RING_SLOTS];
-	struct dpaa2_sec_dev_private *priv = dpaa2_qp->tx_vq.crypto_data->dev_private;
 	struct rte_mbuf *mbuf[MAX_TX_RING_SLOTS];
 	uint64_t dqrr_held[MAX_TX_RING_SLOTS];
 
@@ -1550,7 +1549,7 @@ dpaa2_sec_enqueue_burst_ordered(void *qp, struct rte_crypto_op **ops,
 			dqrr_held[loop] = 0;
 			if (dpaa2_mbuf_seq_is_flag_set(mbuf[loop], DPAA2_ENQUEUE_FLAG_ORP)) {
 				ret = dpaa2_eq_set_order_desc(&dpaa2_qp->tx_vq, mbuf[loop],
-					&eqdesc[loop], priv->en_loose_ordered);
+					&eqdesc[loop]);
 				if (ret)
 					goto skip_tx;
 			} else {
@@ -4118,7 +4117,7 @@ dpaa2_sec_process_ordered_event(struct dpaa2_dpio_dev *dpio_dev,
 	ev->priority = rxq->ev.priority;
 	crypto_op = dpaa2_sec_fd_to_mbuf(fd, qp);
 
-	dpaa2_dq_order_save(dq, crypto_op->sym->m_src);
+	dpaa2_dq_order_save(dq, crypto_op->sym->m_src, qp->rx_vq.order_type);
 
 	qbman_swp_dqrr_consume(swp, dq);
 	ev->event_ptr = crypto_op;
@@ -4135,6 +4134,7 @@ dpaa2_sec_eventq_attach(const struct rte_cryptodev *dev,
 	struct fsl_mc_io *dpseci = (struct fsl_mc_io *)priv->hw;
 	struct dpaa2_sec_qp *qp = dev->data->queue_pairs[qp_id];
 	struct dpseci_rx_queue_cfg cfg;
+	struct opr_cfg ocfg;
 	uint8_t priority;
 	int ret;
 
@@ -4158,42 +4158,27 @@ dpaa2_sec_eventq_attach(const struct rte_cryptodev *dev,
 
 	cfg.options |= DPSECI_QUEUE_OPT_USER_CTX;
 	cfg.user_ctx = (size_t)(&qp->rx_vq);
+	qp->rx_vq.order_type = DPAA2_QUEUE_NONE_ORDER;
 	if (event->sched_type == RTE_SCHED_TYPE_ATOMIC) {
 		cfg.options |= DPSECI_QUEUE_OPT_ORDER_PRESERVATION;
 		cfg.order_preservation_en = 1;
-	}
-
-	if (event->sched_type == RTE_SCHED_TYPE_ORDERED) {
-		struct opr_cfg ocfg;
-
-		/* Restoration window size = 256 frames */
-		ocfg.oprrws = 3;
-		/* Restoration window size = 512 frames for LX2 */
-		if (dpaa2_svr_family == SVR_LX2160A)
-			ocfg.oprrws = 4;
-		/* Auto advance NESN window enabled */
-		ocfg.oa = 1;
-		/* Late arrival window size disabled */
-		ocfg.olws = 0;
-		/* ORL resource exhaustaion advance NESN disabled */
-		ocfg.oeane = 0;
-
-		if (priv->en_loose_ordered)
-			ocfg.oloe = 1;
-		else
-			ocfg.oloe = 0;
-
+		qp->rx_vq.order_type = DPAA2_QUEUE_HOLD_ACTIVE_ORDER;
+	} else if (event->sched_type == RTE_SCHED_TYPE_ORDERED) {
+		dpaa2_orp_config_helper(&ocfg, !priv->en_loose_ordered);
 		ret = dpseci_set_opr(dpseci, CMD_PRI_LOW, priv->token,
-				   qp_id, OPR_OPT_CREATE, &ocfg);
+				qp_id, OPR_OPT_CREATE, &ocfg);
 		if (ret) {
 			DPAA2_SEC_ERR("Error setting opr: ret: %d", ret);
 			return ret;
 		}
-		priv->en_ordered = 1;
+		if (priv->en_loose_ordered)
+			qp->rx_vq.order_type = DPAA2_QUEUE_LOOSE_ORP_ORDER;
+		else
+			qp->rx_vq.order_type = DPAA2_QUEUE_STRICT_ORP_ORDER;
 	}
 
 	ret = dpseci_set_rx_queue(dpseci, CMD_PRI_LOW, priv->token,
-				  qp_id, &cfg);
+			qp_id, &cfg);
 	if (ret) {
 		DPAA2_SEC_ERR("Error in dpseci_set_queue: ret: %d", ret);
 		return ret;
diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h b/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
index f29817f456..2995aec943 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
@@ -39,7 +39,6 @@ struct dpaa2_sec_dev_private {
 	uint16_t token; /**< Token required by DPxxx objects */
 	unsigned int max_nb_queue_pairs;
 	/**< Max number of queue pairs supported by device */
-	uint8_t en_ordered;
 	uint8_t en_loose_ordered;
 	enum dpaa2_sec_dump_levels dump_level;
 };
diff --git a/drivers/event/dpaa2/dpaa2_eventdev.c b/drivers/event/dpaa2/dpaa2_eventdev.c
index a03b04a057..011883bba8 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev.c
@@ -185,7 +185,7 @@ dpaa2_eventdev_enqueue_burst(void *port, const struct rte_event ev[],
 			if (event->sched_type == RTE_SCHED_TYPE_ORDERED &&
 				dpaa2_mbuf_seq_is_flag_set(event->mbuf, DPAA2_ENQUEUE_FLAG_ORP)) {
 				ret = dpaa2_eq_set_order_desc(dpci_txq[loop], event->mbuf,
-					&eqdesc[loop], true);
+					&eqdesc[loop]);
 				if (ret) {
 					rte_mempool_put(dpci_txq[loop]->env_pool, ev_tx[loop]);
 					goto send_partial;
@@ -304,7 +304,7 @@ static void dpaa2_eventdev_process_order(struct dpaa2_dpio_dev *dpio_dev,
 	struct qbman_swp *swp = dpio_dev->sw_portal;
 
 	dpaa2_eventdev_rx_get_event(fd, rxq, ev);
-	dpaa2_dq_order_save(dq, ev->mbuf);
+	dpaa2_dq_order_save(dq, ev->mbuf, rxq->order_type);
 	qbman_swp_dqrr_consume(swp, dq);
 }
 
@@ -1319,7 +1319,7 @@ dpaa2_eventdev_create(const char *name, struct rte_vdev_device *vdev)
 
 		ret = rte_dpaa2_dpci_link_attach(dpci_dev, DPCI_DEST_DPCON,
 			dpcon_dev->dpcon_id, 0,
-			dpaa2_eventdev_process_parallel,
+			dpaa2_eventdev_process_parallel, DPAA2_QUEUE_NONE_ORDER,
 			&evq_info->dpci_txqs[RTE_SCHED_TYPE_PARALLEL]);
 		if (ret) {
 			DPAA2_EVENTDEV_ERR("DPCI attach parallel qp failed: err(%d)", ret);
@@ -1328,7 +1328,7 @@ dpaa2_eventdev_create(const char *name, struct rte_vdev_device *vdev)
 
 		ret = rte_dpaa2_dpci_link_attach(dpci_dev, DPCI_DEST_DPCON,
 			dpcon_dev->dpcon_id, 0,
-			dpaa2_eventdev_process_atomic,
+			dpaa2_eventdev_process_atomic, DPAA2_QUEUE_HOLD_ACTIVE_ORDER,
 			&evq_info->dpci_txqs[RTE_SCHED_TYPE_ATOMIC]);
 		if (ret) {
 			DPAA2_EVENTDEV_ERR("DPCI attach atomic qp failed: err(%d)", ret);
@@ -1337,7 +1337,7 @@ dpaa2_eventdev_create(const char *name, struct rte_vdev_device *vdev)
 
 		ret = rte_dpaa2_dpci_link_attach(dpci_dev, DPCI_DEST_DPCON,
 			dpcon_dev->dpcon_id, 0,
-			dpaa2_eventdev_process_order,
+			dpaa2_eventdev_process_order, DPAA2_QUEUE_LOOSE_ORP_ORDER,
 			&evq_info->dpci_txqs[RTE_SCHED_TYPE_ORDERED]);
 		if (ret) {
 			DPAA2_EVENTDEV_ERR("DPCI attach order qp failed: err(%d)", ret);
diff --git a/drivers/event/dpaa2/dpaa2_scheduler.c b/drivers/event/dpaa2/dpaa2_scheduler.c
index a80ec05add..325c23e1dc 100644
--- a/drivers/event/dpaa2/dpaa2_scheduler.c
+++ b/drivers/event/dpaa2/dpaa2_scheduler.c
@@ -158,7 +158,7 @@ dpaa2_scheduler_dpci_recv(struct dpaa2_sch_dev *sch_dev,
 	dpcon_dev = sch_dev->dpcon_dev[cpu];
 	dpci_dev = sch_dev->dpci_dev[cpu];
 	ret = rte_dpaa2_dpci_link_attach(dpci_dev, DPCI_DEST_DPCON,
-		dpcon_dev->dpcon_id, 0, NULL, NULL);
+		dpcon_dev->dpcon_id, 0, NULL, DPAA2_QUEUE_NONE_ORDER, NULL);
 	if (ret) {
 		DPAA2_EVENTDEV_ERR("DPCI link attaches dpcon failed: err(%d)", ret);
 		return 0;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index b75625dc01..b6e911266f 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -113,7 +113,8 @@ dpaa2_dev_args_qos_entries_per_tc(void *vdev,
 	ENTRY("drv_qos_entries_per_tc", dpaa2_dev_args_qos_entries_per_tc, \
 		DPAA2_QOS_ENTRIES_PER_TC_FLAG) \
 	ENTRY("drv_qos_flow_only_steer", NULL, DPAA2_QOS_FLOW_ONLY_STEER_FLAG) \
-	ENTRY("drv_flow_api_debug", NULL, DPAA2_FLOW_API_DEBUG_FLAG)
+	ENTRY("drv_flow_api_debug", NULL, DPAA2_FLOW_API_DEBUG_FLAG) \
+	ENTRY("drv_queue_strict_order", NULL, DPAA2_QUEUE_STRICT_ORDER_FLAG)
 
 #define CHECK_INTERVAL         100  /* 100ms */
 #define MAX_REPEAT_TIME        90   /* 9s (90 * 100ms) in total */
@@ -3388,7 +3389,8 @@ int dpaa2_eth_eventq_attach(const struct rte_eth_dev *dev,
 	struct dpaa2_queue *dpaa2_ethq = eth_priv->rx_vq[eth_rx_queue_id];
 	uint8_t flow_id = dpaa2_ethq->flow_id, options, priority;
 	struct dpni_queue *cfg;
-	int ret;
+	struct opr_cfg ocfg;
+	int ret, strict = false;
 
 	cfg = dpaa2_ethq->cfg;
 
@@ -3412,35 +3414,15 @@ int dpaa2_eth_eventq_attach(const struct rte_eth_dev *dev,
 	cfg->destination.id = dpcon->dpcon_id;
 	cfg->destination.priority = priority;
 
+	dpaa2_ethq->order_type = DPAA2_QUEUE_NONE_ORDER;
 	if (queue_conf->ev.sched_type == RTE_SCHED_TYPE_ATOMIC) {
 		options |= DPNI_QUEUE_OPT_HOLD_ACTIVE;
 		cfg->destination.hold_active = 1;
-	}
-
-	if (queue_conf->ev.sched_type == RTE_SCHED_TYPE_ORDERED &&
-		!eth_priv->en_ordered) {
-		struct opr_cfg ocfg;
-
-		/* Restoration window size = 256 frames */
-		ocfg.oprrws = 3;
-		/* Restoration window size = 512 frames for LX2 */
-		if (dpaa2_svr_family == SVR_LX2160A)
-			ocfg.oprrws = 4;
-		/* Auto advance NESN window enabled */
-		ocfg.oa = 1;
-		/* Late arrival window size disabled */
-		ocfg.olws = 0;
-		/* ORL resource exhaustion advance NESN disabled */
-		ocfg.oeane = 0;
-		/* Loose ordering enabled */
-		ocfg.oloe = 1;
-		eth_priv->en_loose_ordered = 1;
-		/* Strict ordering enabled if explicitly set */
-		if (getenv("DPAA2_STRICT_ORDERING_ENABLE")) {
-			ocfg.oloe = 0;
-			eth_priv->en_loose_ordered = 0;
-		}
-
+		dpaa2_ethq->order_type = DPAA2_QUEUE_HOLD_ACTIVE_ORDER;
+	} else if (queue_conf->ev.sched_type == RTE_SCHED_TYPE_ORDERED) {
+		if (eth_priv->flags & DPAA2_QUEUE_STRICT_ORDER_FLAG)
+			strict = true;
+		dpaa2_orp_config_helper(&ocfg, strict);
 		ret = dpni_set_opr(dpni, CMD_PRI_LOW, eth_priv->token,
 			dpaa2_ethq->tc_index, flow_id, OPR_OPT_CREATE, &ocfg, 0);
 		if (ret) {
@@ -3448,8 +3430,10 @@ int dpaa2_eth_eventq_attach(const struct rte_eth_dev *dev,
 				ret, dpaa2_ethq->tc_index, flow_id);
 			return ret;
 		}
-
-		eth_priv->en_ordered = 1;
+		if (strict)
+			dpaa2_ethq->order_type = DPAA2_QUEUE_STRICT_ORP_ORDER;
+		else
+			dpaa2_ethq->order_type = DPAA2_QUEUE_LOOSE_ORP_ORDER;
 	}
 
 	options |= DPNI_QUEUE_OPT_USER_CTX;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 491ad78d85..33f78d310a 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -115,6 +115,8 @@
 
 #define DPAA2_FLOW_API_DEBUG_FLAG RTE_BIT32(16)
 
+#define DPAA2_QUEUE_STRICT_ORDER_FLAG RTE_BIT32(17)
+
 /* DPDMUX index for DPMAC */
 #define DPAA2_DPDMUX_DPMAC_IDX 0
 
@@ -401,8 +403,6 @@ struct dpaa2_dev_priv {
 	uint16_t fs_entries;
 	uint8_t dist_queues;
 	uint8_t num_channels;
-	uint8_t en_ordered;
-	uint8_t en_loose_ordered;
 	uint8_t max_cgs;
 	/** RXQs in same TC share same cgid.*/
 	uint8_t cgid_in_use[MAX_TCS];
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index fec046deaf..2af5a4745d 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -1250,7 +1250,7 @@ dpaa2_dev_process_ordered_event(struct dpaa2_dpio_dev *dpio_dev,
 	else
 		ev->mbuf = dpaa2_eth_fd_to_mbuf(rxq->eth_data->dev_private, fd);
 
-	dpaa2_dq_order_save(dq, ev->mbuf);
+	dpaa2_dq_order_save(dq, ev->mbuf, rxq->order_type);
 
 	qbman_swp_dqrr_consume(swp, dq);
 }
@@ -1731,10 +1731,8 @@ dpaa2_dev_tx_multi_txq_ordered(struct dpaa2_queue **dpaa2_q,
 
 		dqrr_held[loop] = 0;
 		dqrr_size[loop] = 0;
-		if (dpaa2_mbuf_seq_is_flag_set(bufs[loop], DPAA2_ENQUEUE_FLAG_ORP) &&
-			priv->en_ordered) {
-			ret = dpaa2_eq_set_order_desc(priv->tx_vq[0], bufs[loop], &eqdesc[loop],
-				priv->en_loose_ordered);
+		if (dpaa2_mbuf_seq_is_flag_set(bufs[loop], DPAA2_ENQUEUE_FLAG_ORP)) {
+			ret = dpaa2_eq_set_order_desc(priv->tx_vq[0], bufs[loop], &eqdesc[loop]);
 			if (ret)
 				goto send_frames;
 		} else {
-- 
2.43.0

