Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63681606A31E
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:50:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75B5D427CE;
	Fri, 23 Oct 2026 15:45:14 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 6AA7442788
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:58 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4D8B420002B;
 Fri, 23 Oct 2026 15:44:58 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 199F3200031;
 Fri, 23 Oct 2026 15:44:58 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BC24F18000B1;
 Fri, 23 Oct 2026 21:44:56 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 61/65] event/dpaa2: add ordered schedule type support
Date: Fri, 23 Oct 2026 19:13:41 +0530
Message-ID: <20261023134346.37727-62-prashant.gupta_3@nxp.com>
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jun Yang <jun.yang@nxp.com>

The dpaa2 eventdev supported only PARALLEL and ATOMIC schedule types.
Each schedule type uses its own DPCI Tx queue (dpci_txqs[] indexed by
event->sched_type) attached with a dedicated dequeue callback, and the
ORDERED slot was left unimplemented (marked TODO).

Add RTE_SCHED_TYPE_ORDERED support:

  - Attach the ordered DPCI queue (dpci_txqs[RTE_SCHED_TYPE_ORDERED])
    with a new dequeue callback dpaa2_eventdev_process_order() that
    saves the ORP context via dpaa2_dq_order_save().
  - Advertise RTE_EVENT_DEV_CAP_NONSEQ_MODE and accept
    RTE_SCHED_TYPE_ORDERED in queue setup.
  - Handle the ORP flag in the enqueue path via
    dpaa2_eq_set_order_desc().

Also optimize the Tx adapter enqueue path to use rte_eth_tx_burst()
directly when all packets target the same queue and no ordered/atomic
(ORP or DCA) handling is required, falling back to
dpaa2_dev_tx_multi_txq_ordered() otherwise. The DPCI attach error logs
are reworded from "RX" to "qp" for clarity.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/event/dpaa2/dpaa2_eventdev.c | 84 +++++++++++++++++++++-------
 1 file changed, 65 insertions(+), 19 deletions(-)

diff --git a/drivers/event/dpaa2/dpaa2_eventdev.c b/drivers/event/dpaa2/dpaa2_eventdev.c
index 8ad9fe7d30..a03b04a057 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev.c
@@ -178,18 +178,29 @@ dpaa2_eventdev_enqueue_burst(void *port, const struct rte_event ev[],
 
 			/* Prepare enqueue descriptor */
 			qbman_eq_desc_clear(&eqdesc[loop]);
-			qbman_eq_desc_set_fq(&eqdesc[loop], dpci_txq[loop]->fqid);
-			qbman_eq_desc_set_no_orp(&eqdesc[loop], 0);
-			qbman_eq_desc_set_response(&eqdesc[loop], 0, 0);
 			flags[loop] = 0;
 			dqrr_held[loop] = 0;
 			dqrr_size[loop] = 0;
 
-			if (event->sched_type == RTE_SCHED_TYPE_ATOMIC &&
-				dpaa2_mbuf_seq_is_flag_set(event->mbuf, QBMAN_ENQUEUE_FLAG_DCA)) {
-				dpaa2_eq_atomic_consume(event->mbuf, dqrr_size[loop],
-					dqrr_held[loop], dpio_dev, &flags[loop],
-					&eqdesc[loop], atomic);
+			if (event->sched_type == RTE_SCHED_TYPE_ORDERED &&
+				dpaa2_mbuf_seq_is_flag_set(event->mbuf, DPAA2_ENQUEUE_FLAG_ORP)) {
+				ret = dpaa2_eq_set_order_desc(dpci_txq[loop], event->mbuf,
+					&eqdesc[loop], true);
+				if (ret) {
+					rte_mempool_put(dpci_txq[loop]->env_pool, ev_tx[loop]);
+					goto send_partial;
+				}
+			} else {
+				if (event->sched_type == RTE_SCHED_TYPE_ATOMIC &&
+					dpaa2_mbuf_seq_is_flag_set(event->mbuf,
+					QBMAN_ENQUEUE_FLAG_DCA)) {
+					dpaa2_eq_atomic_consume(event->mbuf, dqrr_size[loop],
+						dqrr_held[loop], dpio_dev, &flags[loop],
+						&eqdesc[loop], atomic);
+				}
+				qbman_eq_desc_set_fq(&eqdesc[loop], dpci_txq[loop]->fqid);
+				qbman_eq_desc_set_no_orp(&eqdesc[loop], 0);
+				qbman_eq_desc_set_response(&eqdesc[loop], 0, 0);
 			}
 
 			memset(&fd_arr[loop], 0, sizeof(struct qbman_fd));
@@ -258,16 +269,23 @@ static void dpaa2_eventdev_dequeue_wait(struct dpaa2_dpio_dev *dpio_dev,
 	DPAA2_PMD_DP_DEBUG("%s: poll return(%d)", __func__, ret);
 }
 
-static void dpaa2_eventdev_process_parallel(struct dpaa2_dpio_dev *dpio_dev,
-	const struct qbman_fd *fd, const struct qbman_result *dq,
+static inline void
+dpaa2_eventdev_rx_get_event(const struct qbman_fd *fd,
 	struct dpaa2_queue *rxq, struct rte_event *ev)
 {
 	struct rte_event *rx_ev = (void *)DPAA2_GET_FD_ADDR(fd);
-	struct qbman_swp *swp = dpio_dev->sw_portal;
 
 	rte_memcpy(ev, rx_ev, sizeof(struct rte_event));
 	rte_mempool_put(rxq->env_pool, rx_ev);
+}
 
+static void dpaa2_eventdev_process_parallel(struct dpaa2_dpio_dev *dpio_dev,
+	const struct qbman_fd *fd, const struct qbman_result *dq,
+	struct dpaa2_queue *rxq, struct rte_event *ev)
+{
+	struct qbman_swp *swp = dpio_dev->sw_portal;
+
+	dpaa2_eventdev_rx_get_event(fd, rxq, ev);
 	qbman_swp_dqrr_consume(swp, dq);
 }
 
@@ -275,13 +293,21 @@ static void dpaa2_eventdev_process_atomic(struct dpaa2_dpio_dev *dpio_dev,
 	const struct qbman_fd *fd, const struct qbman_result *dq,
 	struct dpaa2_queue *rxq, struct rte_event *ev)
 {
-	struct rte_event *rx_ev = (void *)DPAA2_GET_FD_ADDR(fd);
-
-	rte_memcpy(ev, rx_ev, sizeof(struct rte_event));
-	rte_mempool_put(rxq->env_pool, rx_ev);
+	dpaa2_eventdev_rx_get_event(fd, rxq, ev);
 	dpaa2_dq_atomic_save(dq, ev->mbuf, dpio_dev);
 }
 
+static void dpaa2_eventdev_process_order(struct dpaa2_dpio_dev *dpio_dev,
+	const struct qbman_fd *fd, const struct qbman_result *dq,
+	struct dpaa2_queue *rxq, struct rte_event *ev)
+{
+	struct qbman_swp *swp = dpio_dev->sw_portal;
+
+	dpaa2_eventdev_rx_get_event(fd, rxq, ev);
+	dpaa2_dq_order_save(dq, ev->mbuf);
+	qbman_swp_dqrr_consume(swp, dq);
+}
+
 static uint16_t
 dpaa2_eventdev_dequeue_burst(void *port, struct rte_event ev[],
 	uint16_t nb_events, uint64_t timeout_ticks)
@@ -439,6 +465,7 @@ dpaa2_eventdev_info_get(struct rte_eventdev *dev,
 		RTE_EVENT_DEV_CAP_RUNTIME_PORT_LINK |
 		RTE_EVENT_DEV_CAP_MULTIPLE_QUEUE_PORT |
 		RTE_EVENT_DEV_CAP_QUEUE_ALL_TYPES |
+		RTE_EVENT_DEV_CAP_NONSEQ_MODE |
 		RTE_EVENT_DEV_CAP_CARRY_FLOW_ID |
 		RTE_EVENT_DEV_CAP_MAINTENANCE_FREE;
 	dev_info->max_profiles_per_port = 1;
@@ -653,6 +680,7 @@ dpaa2_eventdev_queue_setup(struct rte_eventdev *dev, uint8_t queue_id,
 	switch (queue_conf->schedule_type) {
 	case RTE_SCHED_TYPE_PARALLEL:
 	case RTE_SCHED_TYPE_ATOMIC:
+	case RTE_SCHED_TYPE_ORDERED:
 		break;
 	default:
 		DPAA2_EVENTDEV_ERR("Schedule type(%d) is not supported.",
@@ -1169,6 +1197,7 @@ dpaa2_eventdev_txa_enqueue(void *port,
 	struct dpaa2_queue *txq[MAX_TX_RING_SLOTS];
 	struct rte_mbuf *m[MAX_TX_RING_SLOTS];
 	uint16_t sent = 0, burst, i, port_id, qid;
+	int same_q, order;
 
 	RTE_SET_USED(port);
 
@@ -1176,15 +1205,25 @@ dpaa2_eventdev_txa_enqueue(void *port,
 	 * on-stack burst array, so transmit in ring-sized chunks.
 	 */
 	while (sent < nb_events) {
+		same_q = true;
+		order = false;
 		burst = RTE_MIN(nb_events - sent, (uint16_t)RTE_DIM(m));
 		for (i = 0; i < burst; i++) {
 			m[i] = ev[sent + i].mbuf;
 			port_id = m[i]->port;
 			qid = rte_event_eth_tx_adapter_txq_get(m[i]);
 			txq[i] = rte_eth_devices[port_id].data->tx_queues[qid];
+			if (same_q && i > 0 && txq[i] != txq[i - 1])
+				same_q = false;
+			if (!order && dpaa2_mbuf_seq_is_flag_set(m[i],
+				(DPAA2_ENQUEUE_FLAG_ORP | QBMAN_ENQUEUE_FLAG_DCA)))
+				order = true;
 		}
 
-		i = dpaa2_dev_tx_multi_txq_ordered(txq, m, burst);
+		if (same_q && !order && burst > 0)
+			i = rte_eth_tx_burst(port_id, qid, m, burst);
+		else
+			i = dpaa2_dev_tx_multi_txq_ordered(txq, m, burst);
 		sent += i;
 		if (i < burst)
 			break;
@@ -1283,7 +1322,7 @@ dpaa2_eventdev_create(const char *name, struct rte_vdev_device *vdev)
 			dpaa2_eventdev_process_parallel,
 			&evq_info->dpci_txqs[RTE_SCHED_TYPE_PARALLEL]);
 		if (ret) {
-			DPAA2_EVENTDEV_ERR("DPCI attach parallel RX failed: err(%d)", ret);
+			DPAA2_EVENTDEV_ERR("DPCI attach parallel qp failed: err(%d)", ret);
 			goto err_break;
 		}
 
@@ -1292,11 +1331,18 @@ dpaa2_eventdev_create(const char *name, struct rte_vdev_device *vdev)
 			dpaa2_eventdev_process_atomic,
 			&evq_info->dpci_txqs[RTE_SCHED_TYPE_ATOMIC]);
 		if (ret) {
-			DPAA2_EVENTDEV_ERR("DPCI attach atomic RX failed: err(%d)", ret);
+			DPAA2_EVENTDEV_ERR("DPCI attach atomic qp failed: err(%d)", ret);
 			goto err_break;
 		}
 
-		/** TO DO: order schedule.*/
+		ret = rte_dpaa2_dpci_link_attach(dpci_dev, DPCI_DEST_DPCON,
+			dpcon_dev->dpcon_id, 0,
+			dpaa2_eventdev_process_order,
+			&evq_info->dpci_txqs[RTE_SCHED_TYPE_ORDERED]);
+		if (ret) {
+			DPAA2_EVENTDEV_ERR("DPCI attach order qp failed: err(%d)", ret);
+			goto err_break;
+		}
 
 		evq_info->valid = true;
 		evq_info->event_queue_id = priv->max_event_queues;
-- 
2.43.0

