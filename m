Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C22606A32E
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:48:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51224410ED;
	Fri, 23 Oct 2026 15:44:44 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id D9EB940E13
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:33 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BBE191A0038;
 Fri, 23 Oct 2026 15:44:33 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5986B1A0021;
 Fri, 23 Oct 2026 15:44:33 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5486418000B6;
 Fri, 23 Oct 2026 21:44:32 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 38/65] net/dpaa2: add multi-port Tx API
Date: Fri, 23 Oct 2026 19:13:18 +0530
Message-ID: <20261023134346.37727-39-prashant.gupta_3@nxp.com>
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

Add a public API to transmit an array of packets whose destination
port and Tx queue are given per packet, and clean up the ordered Tx
helpers it builds on.

- New API rte_dpaa2_dev_tx_multi_ports():
  takes per-packet port_id[] and txq_id[] arrays (txq_id NULL means
  queue 0 of each port), resolves each dpaa2_queue, and forwards to
  dpaa2_dev_tx_multi_txq_ordered(). This allows a single burst to span
  multiple ports.

- dpaa2_dev_tx_multi_txq_ordered() takes struct dpaa2_queue ** instead
  of void ** and no longer loops with tx_again or accumulates a running
  "sent" count; it enqueues one batch and returns the number sent. Tx
  confirmation is now done after enqueue only for queues that have a
  tx_conf_queue, and the buffer-pool lookup is deferred to the slow
  path.

- The dy_conf out-parameter is dropped from the mbuf-to-fd helpers
  (dpaa2_dev_tx_mbuf_to_sg_fd, dpaa2_dev_tx_mbuf_to_simple_fd,
  dpaa2_dev_tx_fast_mbuf_to_fd); it was written but never consumed.
  dpaa2_dev_tx_fast_mbuf_to_fd() now takes the private structure
  directly and reads tx_conf_type from it.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/event/dpaa2/dpaa2_eventdev.c |   2 +-
 drivers/net/dpaa2/dpaa2_ethdev.h     |   4 +-
 drivers/net/dpaa2/dpaa2_rxtx.c       | 127 ++++++++++++---------------
 drivers/net/dpaa2/rte_pmd_dpaa2.h    |   5 ++
 4 files changed, 66 insertions(+), 72 deletions(-)

diff --git a/drivers/event/dpaa2/dpaa2_eventdev.c b/drivers/event/dpaa2/dpaa2_eventdev.c
index 476decbbdc..be6d8bc3da 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev.c
@@ -1095,7 +1095,7 @@ static uint16_t
 dpaa2_eventdev_txa_enqueue(void *port,
 	struct rte_event ev[], uint16_t nb_events)
 {
-	void *txq[MAX_TX_RING_SLOTS];
+	struct dpaa2_queue *txq[MAX_TX_RING_SLOTS];
 	struct rte_mbuf *m[MAX_TX_RING_SLOTS];
 	uint16_t sent = 0, burst, i, port_id, qid;
 
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 8c0be81c95..e4dc7b7e4f 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -975,8 +975,8 @@ uint16_t dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts);
 uint16_t dpaa2_dev_tx_ordered(void *queue, struct rte_mbuf **bufs,
 			      uint16_t nb_pkts);
 __rte_internal
-uint16_t dpaa2_dev_tx_multi_txq_ordered(void **queue,
-		struct rte_mbuf **bufs, uint16_t nb_pkts);
+uint16_t dpaa2_dev_tx_multi_txq_ordered(struct dpaa2_queue **dpaa2_q,
+	struct rte_mbuf **bufs, uint16_t nb_pkts);
 
 void dpaa2_dev_free_eqresp_buf(uint16_t eqresp_ci, struct dpaa2_queue *dpaa2_q);
 void dpaa2_flow_clean(struct rte_eth_dev *dev, uint8_t tc_id,
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 0d4fc18455..a44b991d1b 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -738,8 +738,7 @@ dpaa2_dev_tx_conf_mbuf_to_sge(struct qbman_sge *sgt,
 static int __rte_noinline __rte_hot
 dpaa2_dev_tx_mbuf_to_sg_fd(struct rte_mempool *hw_mp,
 	struct rte_mbuf *mbuf, struct qbman_fd *fd,
-	struct dpaa2_queue *txq, enum dpaa2_tx_conf_type conf,
-	uint8_t *dy_conf, int tstamp)
+	struct dpaa2_queue *txq, enum dpaa2_tx_conf_type conf, int tstamp)
 {
 	struct rte_mbuf *cur_seg = mbuf, *sg_mbuf;
 	struct qbman_sge *sgt;
@@ -841,8 +840,6 @@ dpaa2_dev_tx_mbuf_to_sg_fd(struct rte_mempool *hw_mp,
 		if (ret)
 			return ret;
 	}
-	if (dy_conf && need_dyconf)
-		*dy_conf = true;
 
 	return 0;
 }
@@ -867,8 +864,7 @@ dpaa2_dev_prefetch_next_psr(const struct qbman_result *dq)
 static int __rte_noinline __rte_hot
 dpaa2_dev_tx_mbuf_to_simple_fd(struct rte_mempool *hw_mp,
 	struct rte_mbuf *mbuf, struct qbman_fd *fd,
-	struct dpaa2_queue *txq, enum dpaa2_tx_conf_type conf,
-	uint8_t *dy_conf, int tstamp)
+	struct dpaa2_queue *txq, enum dpaa2_tx_conf_type conf, int tstamp)
 {
 	int need_dyconf = false, need_conf = false;
 	struct rte_mbuf *mi;
@@ -905,13 +901,10 @@ dpaa2_dev_tx_mbuf_to_simple_fd(struct rte_mempool *hw_mp,
 		rte_pktmbuf_free(mbuf);
 	}
 
-	if (need_dyconf) {
+	if (need_dyconf)
 		dpaa2_dev_tx_config_dynamic_confirm(fd, txq, true, tstamp);
-		if (dy_conf)
-			*dy_conf = true;
-	} else if (tstamp) {
+	else if (tstamp)
 		dpaa2_dev_tx_enable_tstamp(fd);
-	}
 
 	return ret;
 }
@@ -1613,12 +1606,10 @@ uint16_t dpaa2_dev_tx_conf(void *txq, int drain)
 }
 
 static inline int
-dpaa2_dev_tx_fast_mbuf_to_fd(struct rte_eth_dev_data *dev,
-	struct rte_mbuf *buf, struct qbman_fd *fd,
-	enum dpaa2_tx_conf_type conf)
+dpaa2_dev_tx_fast_mbuf_to_fd(struct dpaa2_dev_priv *priv,
+	struct rte_mbuf *buf, struct qbman_fd *fd)
 {
 	struct rte_mempool *mp = buf->pool;
-	struct dpaa2_dev_priv *priv = dev->dev_private;
 
 	if (likely(RTE_MBUF_DIRECT(buf) &&
 		mp && mp->ops_index ==
@@ -1629,7 +1620,7 @@ dpaa2_dev_tx_fast_mbuf_to_fd(struct rte_eth_dev_data *dev,
 			DPAA2_PMD_WARN("Single mbuf has next segment(%p)",
 				buf->next);
 		}
-		if (unlikely(conf == DPAA2_TX_ABSOLUTE_CONF))
+		if (unlikely(priv->tx_conf_type == DPAA2_TX_ABSOLUTE_CONF))
 			dpaa2_mbuf_to_conf_contig_fd(buf, fd);
 		else
 			DPAA2_MBUF_TO_CONTIG_FD(buf, fd, mempool_to_bpid(mp));
@@ -1662,7 +1653,6 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	struct dpaa2_dev_priv *priv = eth_data->dev_private;
 	struct rte_mempool *hw_mp;
 	uint32_t flags[MAX_TX_RING_SLOTS] = {0};
-	uint8_t dy_conf[MAX_TX_RING_SLOTS];
 
 	if (unlikely(!DPAA2_PER_LCORE_DPIO)) {
 		ret = dpaa2_affine_qbman_swp();
@@ -1709,7 +1699,6 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		dpaa2_eqcr_size : nb_pkts;
 
 	for (loop = 0; loop < frames_to_send; loop++) {
-		dy_conf[loop] = false;
 		if (*dpaa2_seqn(*bufs)) {
 			uint8_t dqrr_index = *dpaa2_seqn(*bufs) - 1;
 
@@ -1739,8 +1728,7 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			goto skip_fast_mbuf2fd;
 		}
 
-		ret = dpaa2_dev_tx_fast_mbuf_to_fd(eth_data,
-			*bufs, &fd_arr[loop], priv->tx_conf_type);
+		ret = dpaa2_dev_tx_fast_mbuf_to_fd(priv, *bufs, &fd_arr[loop]);
 		if (likely(!ret)) {
 			bufs++;
 			continue;
@@ -1749,10 +1737,10 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 skip_fast_mbuf2fd:
 		if (unlikely((*bufs)->nb_segs > 1)) {
 			ret = dpaa2_dev_tx_mbuf_to_sg_fd(hw_mp, *bufs, &fd_arr[loop],
-				dpaa2_q, priv->tx_conf_type, &dy_conf[loop], tstamp[loop]);
+				dpaa2_q, priv->tx_conf_type, tstamp[loop]);
 		} else {
 			ret = dpaa2_dev_tx_mbuf_to_simple_fd(hw_mp, *bufs, &fd_arr[loop],
-				dpaa2_q, priv->tx_conf_type, &dy_conf[loop], tstamp[loop]);
+				dpaa2_q, priv->tx_conf_type, tstamp[loop]);
 		}
 		if (ret)
 			goto send_n_return;
@@ -1849,11 +1837,9 @@ dpaa2_dev_free_eqresp_buf(uint16_t eqresp_ci,
 
 static void
 dpaa2_set_enqueue_descriptor(struct dpaa2_queue *dpaa2_q,
-			     struct rte_mbuf *m,
-			     struct qbman_eq_desc *eqdesc)
+	struct rte_mbuf *m, struct qbman_eq_desc *eqdesc)
 {
-	struct rte_eth_dev_data *eth_data = dpaa2_q->eth_data;
-	struct dpaa2_dev_priv *priv = eth_data->dev_private;
+	struct dpaa2_dev_priv *priv = dpaa2_q->eth_data->dev_private;
 	struct dpaa2_dpio_dev *dpio_dev = DPAA2_PER_LCORE_DPIO;
 	struct eqresp_metadata *eqresp_meta;
 	uint16_t orpid, seqnum;
@@ -1896,22 +1882,20 @@ dpaa2_set_enqueue_descriptor(struct dpaa2_queue *dpaa2_q,
 
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dev_tx_multi_txq_ordered)
 uint16_t
-dpaa2_dev_tx_multi_txq_ordered(void **queue,
+dpaa2_dev_tx_multi_txq_ordered(struct dpaa2_queue **dpaa2_q,
 	struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
 	/* Function to transmit the frames to multiple queues respectively.*/
-	uint32_t loop, retry_count, sent = 0, i;
+	uint32_t loop, retry_count, i;
 	int32_t ret = 0, tstamp[MAX_TX_RING_SLOTS], ptp_set_count, ptp_set;
 	struct qbman_fd fd_arr[MAX_TX_RING_SLOTS];
 	uint32_t frames_to_send, num_free_eq_desc = 0;
 	struct rte_mempool *hw_mp;
 	struct qbman_eq_desc eqdesc[MAX_TX_RING_SLOTS];
-	struct dpaa2_queue *dpaa2_q[MAX_TX_RING_SLOTS];
 	struct qbman_swp *swp;
-	struct rte_eth_dev_data *eth_data;
 	struct dpaa2_dev_priv *priv;
 	struct dpaa2_queue *order_sendq;
-	uint8_t dy_conf[MAX_TX_RING_SLOTS];
+	struct dpaa2_queue *cnf_q;
 
 	if (unlikely(!DPAA2_PER_LCORE_DPIO)) {
 		ret = dpaa2_affine_qbman_swp();
@@ -1923,25 +1907,12 @@ dpaa2_dev_tx_multi_txq_ordered(void **queue,
 	}
 	swp = DPAA2_PER_LCORE_PORTAL;
 
-tx_again:
 	ptp_set_count = 0;
 	frames_to_send = (nb_pkts > dpaa2_eqcr_size) ?
 		dpaa2_eqcr_size : nb_pkts;
 
 	for (loop = 0; loop < frames_to_send; loop++) {
-		dpaa2_q[loop] = queue[loop];
-		if (dpaa2_q[loop]->tx_conf_queue)
-			dpaa2_dev_tx_conf(dpaa2_q[loop], false);
-		eth_data = dpaa2_q[loop]->eth_data;
-		priv = eth_data->dev_private;
-		dy_conf[loop] = false;
-		if (unlikely(!priv->bp_list)) {
-			DPAA2_PMD_ERR("%s's buffer pool not initialized!",
-				eth_data->name);
-			ret = -ENOMEM;
-			goto send_frames;
-		}
-		hw_mp = priv->bp_list->mp;
+		priv = dpaa2_q[loop]->eth_data->dev_private;
 		if (!priv->en_loose_ordered &&
 			(*dpaa2_seqn(*bufs) & DPAA2_ENQUEUE_FLAG_ORP)) {
 			if (!num_free_eq_desc) {
@@ -1954,9 +1925,6 @@ dpaa2_dev_tx_multi_txq_ordered(void **queue,
 			num_free_eq_desc--;
 		}
 
-		DPAA2_PMD_DP_DEBUG("===> eth_data =%p, fqid =%d",
-			eth_data, dpaa2_q[loop]->fqid);
-
 		/* Check if the queue is congested */
 		retry_count = 0;
 		while (qbman_result_SCN_state(dpaa2_q[loop]->cscn)) {
@@ -1973,8 +1941,7 @@ dpaa2_dev_tx_multi_txq_ordered(void **queue,
 
 		if (*dpaa2_seqn(*bufs) && priv->en_ordered) {
 			order_sendq = priv->tx_vq[0];
-			dpaa2_set_enqueue_descriptor(order_sendq, *bufs,
-				&eqdesc[loop]);
+			dpaa2_set_enqueue_descriptor(order_sendq, *bufs, &eqdesc[loop]);
 		} else {
 			qbman_eq_desc_set_no_orp(&eqdesc[loop], DPAA2_EQ_RESP_ERR_FQ);
 			qbman_eq_desc_set_fq(&eqdesc[loop], dpaa2_q[loop]->fqid);
@@ -1993,27 +1960,27 @@ dpaa2_dev_tx_multi_txq_ordered(void **queue,
 			goto skip_fast_mbuf2fd;
 		}
 
-		ret = dpaa2_dev_tx_fast_mbuf_to_fd(eth_data,
-				*bufs, &fd_arr[loop], priv->tx_conf_type);
+		ret = dpaa2_dev_tx_fast_mbuf_to_fd(priv, *bufs, &fd_arr[loop]);
 		if (likely(!ret)) {
-			if (priv->tx_conf_type == DPAA2_TX_ABSOLUTE_CONF)
-				dy_conf[loop] = true;
 			bufs++;
 			continue;
 		}
 
 skip_fast_mbuf2fd:
+		if (unlikely(!priv->bp_list)) {
+			ret = -ENOMEM;
+			goto send_frames;
+		}
+		hw_mp = priv->bp_list->mp;
 		if (unlikely((*bufs)->nb_segs > 1)) {
 			ret = dpaa2_dev_tx_mbuf_to_sg_fd(hw_mp, *bufs, &fd_arr[loop],
-				dpaa2_q[loop], priv->tx_conf_type, &dy_conf[loop], tstamp[loop]);
+				dpaa2_q[loop], priv->tx_conf_type, tstamp[loop]);
 		} else {
 			ret = dpaa2_dev_tx_mbuf_to_simple_fd(hw_mp, *bufs, &fd_arr[loop],
-				dpaa2_q[loop], priv->tx_conf_type, &dy_conf[loop], tstamp[loop]);
+				dpaa2_q[loop], priv->tx_conf_type, tstamp[loop]);
 		}
 		if (ret)
 			goto send_frames;
-		if (priv->tx_conf_type == DPAA2_TX_ABSOLUTE_CONF)
-			dy_conf[loop] = true;
 		bufs++;
 	}
 
@@ -2023,8 +1990,7 @@ dpaa2_dev_tx_multi_txq_ordered(void **queue,
 	retry_count = 0;
 	while (loop < frames_to_send) {
 		ret = qbman_swp_enqueue_multiple_desc(swp, &eqdesc[loop],
-				&fd_arr[loop],
-				frames_to_send - loop);
+				&fd_arr[loop], frames_to_send - loop);
 		if (likely(ret > 0)) {
 			loop += ret;
 			retry_count = 0;
@@ -2034,18 +2000,41 @@ dpaa2_dev_tx_multi_txq_ordered(void **queue,
 				break;
 		}
 	}
-	nb_pkts -= loop;
-	sent += loop;
 	for (i = 0; i < loop; i++) {
-		if (tstamp[i] && dpaa2_q[i]->tx_conf_queue) {
-			rte_atomic_fetch_add_explicit(&dpaa2_q[i]->tx_conf_queue->ts_to_cnfd,
-				1, rte_memory_order_relaxed);
+		if (unlikely(dpaa2_q[i]->tx_conf_queue)) {
+			dpaa2_dev_tx_conf(dpaa2_q[i], false);
+			if (tstamp[i]) {
+				cnf_q = dpaa2_q[i]->tx_conf_queue;
+				rte_atomic_fetch_add_explicit(&cnf_q->ts_to_cnfd,
+					1, rte_memory_order_relaxed);
+			}
 		}
 	}
-	if (nb_pkts > 0 && !ret)
-		goto tx_again;
 
-	return sent;
+	return loop;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dpaa2_dev_tx_multi_ports, 26.11)
+uint16_t
+rte_dpaa2_dev_tx_multi_ports(uint16_t port_id[],
+	uint16_t txq_id[], struct rte_mbuf **bufs, uint16_t nb_pkts)
+{
+	uint16_t i;
+	struct dpaa2_queue *txq[nb_pkts];
+	struct rte_eth_dev_data *data;
+
+	if (txq_id) {
+		for (i = 0; i < nb_pkts; i++) {
+			data = rte_eth_devices[port_id[i]].data;
+			txq[i] = data->tx_queues[txq_id[i]];
+		}
+	} else {
+		for (i = 0; i < nb_pkts; i++) {
+			data = rte_eth_devices[port_id[i]].data;
+			txq[i] = data->tx_queues[0];
+		}
+	}
+	return dpaa2_dev_tx_multi_txq_ordered(txq, bufs, nb_pkts);
 }
 
 /* Callback to handle sending ordered packets through WRIOP based interface */
@@ -2054,7 +2043,7 @@ dpaa2_dev_tx_ordered(void *queue, struct rte_mbuf **bufs,
 	uint16_t nb_pkts)
 {
 	uint16_t i;
-	void *mq[nb_pkts];
+	struct dpaa2_queue *mq[nb_pkts];
 
 	for (i = 0; i < nb_pkts; i++)
 		mq[i] = queue;
diff --git a/drivers/net/dpaa2/rte_pmd_dpaa2.h b/drivers/net/dpaa2/rte_pmd_dpaa2.h
index 5125ec5bf7..74b7e63c54 100644
--- a/drivers/net/dpaa2/rte_pmd_dpaa2.h
+++ b/drivers/net/dpaa2/rte_pmd_dpaa2.h
@@ -162,6 +162,11 @@ uint16_t
 rte_dpaa2_scheduler_rx(void *scheduler_handle, struct rte_mbuf **mbuf,
 	uint16_t nb_pkts);
 
+__rte_experimental
+uint16_t
+rte_dpaa2_dev_tx_multi_ports(uint16_t port_id[],
+	uint16_t txq_id[], struct rte_mbuf **bufs, uint16_t nb_pkts);
+
 #define RTE_DPAA2_EVENT_PORT_CFG_ATOMIC RTE_BIT32(31)
 
 /** RTE_DPAA2_MIX_GROUP_FLOW has same behavio as RTE_DPAA2_FLAT_GROUP_FLOW*/
-- 
2.43.0

