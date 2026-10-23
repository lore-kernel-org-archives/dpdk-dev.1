Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BDD606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:50:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 681CA40DD6;
	Fri, 23 Oct 2026 15:45:11 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id DCC4440B9A
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:53 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BC5B81A0047;
 Fri, 23 Oct 2026 15:44:53 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 850311A0043;
 Fri, 23 Oct 2026 15:44:53 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7FFF218000B6;
 Fri, 23 Oct 2026 21:44:52 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 57/65] net/dpaa2: unify tx burst path for ordered and
 atomic enqueue
Date: Fri, 23 Oct 2026 19:13:37 +0530
Message-ID: <20261023134346.37727-58-prashant.gupta_3@nxp.com>
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

The ordered transmit path used a dedicated burst function,
dpaa2_dev_tx_ordered(), which was installed as dev->tx_pkt_burst at
device start when ordered queues were enabled. This split the TX datapath
into two separate entry points and required swapping the burst function
and reporting a distinct "Ordered" burst mode.

Make dpaa2_dev_tx() the single TX entry point. It now inspects the mbuf
seqn flags (DPAA2_ENQUEUE_FLAG_ORP / QBMAN_ENQUEUE_FLAG_DCA) and, when a
packet requires ordered or atomic (DCA) enqueue, routes the remaining
burst through the ordered multi-queue path. dpaa2_dev_tx_ordered() is
reduced to a static helper that wraps dpaa2_dev_tx_multi_txq_ordered(),
and the start-time tx_pkt_burst swap, the "Ordered" burst-mode string and
the exported prototype are removed.

Simplify the dpaa2_dev_tx() error handling by replacing the duplicated
send_n_return path with a single break and shared enqueue tail, passing
NULL flags since DCA is handled on the ordered path.

Rework dpaa2_dev_tx_multi_txq_ordered() to index the burst with
bufs[loop] instead of advancing the buffer pointer, handle atomic (DCA)
descriptors with per-slot dqrr_held/dqrr_size/flags, update per-queue
tx_pkts counters, and restore the mbuf seqn flags when enqueue fails so
packets can be retried.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c |   6 --
 drivers/net/dpaa2/dpaa2_ethdev.h |   3 +-
 drivers/net/dpaa2/dpaa2_rxtx.c   | 178 ++++++++++++++-----------------
 3 files changed, 84 insertions(+), 103 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index fe43779b10..85c93bf422 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1003,8 +1003,6 @@ dpaa2_dev_tx_burst_mode_get(struct rte_eth_dev *dev,
 
 	if (pkt_burst == dpaa2_dev_tx)
 		snprintf(mode->info, sizeof(mode->info), "%s", "Scalar");
-	else if (pkt_burst == dpaa2_dev_tx_ordered)
-		snprintf(mode->info, sizeof(mode->info), "%s", "Ordered");
 	else if (pkt_burst == rte_eth_pkt_burst_dummy)
 		snprintf(mode->info, sizeof(mode->info), "%s", "Dummy");
 	else
@@ -2343,10 +2341,6 @@ dpaa2_dev_start(struct rte_eth_dev *dev)
 	 */
 	dpaa2_dev_set_link_up(dev);
 
-	/* Change the tx burst function if ordered queues are used */
-	if (priv->en_ordered)
-		dev->tx_pkt_burst = dpaa2_dev_tx_ordered;
-
 	for (i = 0; i < dev->data->nb_rx_queues; i++)
 		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
 	for (i = 0; i < dev->data->nb_tx_queues; i++)
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 2f3f5bae2a..caf3fabee7 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -972,8 +972,7 @@ void dpaa2_dev_process_ordered_event(struct dpaa2_dpio_dev *dpio_dev,
 	struct dpaa2_queue *rxq, struct rte_event *ev);
 
 uint16_t dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts);
-uint16_t dpaa2_dev_tx_ordered(void *queue, struct rte_mbuf **bufs,
-			      uint16_t nb_pkts);
+
 __rte_internal
 uint16_t dpaa2_dev_tx_multi_txq_ordered(struct dpaa2_queue **dpaa2_q,
 	struct rte_mbuf **bufs, uint16_t nb_pkts);
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index dfd359d0e2..56da29a927 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -1505,6 +1505,20 @@ dpaa2_dev_tx_fast_mbuf_to_fd(struct dpaa2_dev_priv *priv,
 	return -EAGAIN;
 }
 
+/* Callback to handle sending ordered packets through WRIOP based interface */
+static uint16_t
+dpaa2_dev_tx_ordered(void *queue, struct rte_mbuf **bufs,
+	uint16_t nb_pkts)
+{
+	uint16_t i;
+	struct dpaa2_queue *mq[nb_pkts];
+
+	for (i = 0; i < nb_pkts; i++)
+		mq[i] = queue;
+
+	return dpaa2_dev_tx_multi_txq_ordered(mq, bufs, nb_pkts);
+}
+
 /*
  * Callback to handle sending packets through WRIOP based interface
  */
@@ -1512,18 +1526,16 @@ uint16_t
 dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
 	/* Function to transmit the frames to given device and VQ*/
-	uint32_t loop, retry_count, i;
-	int32_t ret, tstamp[MAX_TX_RING_SLOTS], ptp_set_count, ptp_set;
+	uint32_t loop, retry_count, i, ptp_n, frames_to_send;
+	int32_t ret, tstamp[MAX_TX_RING_SLOTS], ptp_set, order = false, eq_ret = 0;
 	struct qbman_fd fd_arr[MAX_TX_RING_SLOTS];
-	uint32_t frames_to_send;
 	struct qbman_eq_desc eqdesc;
 	struct dpaa2_queue *dpaa2_q = queue;
 	struct qbman_swp *swp;
-	uint16_t num_tx = 0;
+	uint16_t num_tx = 0, order_tx;
 	struct rte_eth_dev_data *eth_data = dpaa2_q->eth_data;
 	struct dpaa2_dev_priv *priv = eth_data->dev_private;
 	struct rte_mempool *hw_mp;
-	uint32_t flags[MAX_TX_RING_SLOTS] = {0};
 
 	if (unlikely(!DPAA2_PER_LCORE_DPIO)) {
 		ret = dpaa2_affine_qbman_swp();
@@ -1558,7 +1570,7 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 tx_again:
 	/*Check if the queue is congested*/
 	retry_count = 0;
-	ptp_set_count = 0;
+	ptp_n = 0;
 	while (qbman_result_SCN_state(dpaa2_q->cscn)) {
 		retry_count++;
 		/* Retry for some time before giving up */
@@ -1566,24 +1578,19 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			goto skip_tx;
 	}
 
-	frames_to_send = (nb_pkts > dpaa2_eqcr_size) ?
-		dpaa2_eqcr_size : nb_pkts;
+	frames_to_send = (nb_pkts > dpaa2_eqcr_size) ? dpaa2_eqcr_size : nb_pkts;
 
 	for (loop = 0; loop < frames_to_send; loop++) {
-		if (*dpaa2_seqn(*bufs) & QBMAN_ENQUEUE_FLAG_DCA) {
-			uint8_t dqrr_index = *dpaa2_seqn(*bufs) & QBMAN_EQCR_DCA_IDXMASK;
-
-			flags[loop] = QBMAN_ENQUEUE_FLAG_DCA | dqrr_index;
-			DPAA2_PER_LCORE_DQRR_SIZE--;
-			DPAA2_PER_LCORE_DQRR_HELD &= ~(UINT64_C(1) << dqrr_index);
-			*dpaa2_seqn(*bufs) = DPAA2_INVALID_MBUF_SEQN;
+		if (unlikely(*dpaa2_seqn((*bufs)) &
+			(DPAA2_ENQUEUE_FLAG_ORP | QBMAN_ENQUEUE_FLAG_DCA))) {
+			order = true;
+			break;
 		}
 
-		if (unlikely((*bufs)->ol_flags
-		 & RTE_MBUF_F_TX_VLAN)) {
+		if (unlikely((*bufs)->ol_flags & RTE_MBUF_F_TX_VLAN)) {
 			ret = rte_vlan_insert(bufs);
 			if (ret)
-				goto send_n_return;
+				break;
 		}
 
 		tstamp[loop] = false;
@@ -1593,8 +1600,8 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			dpaa2_dev_tx_ptp_one_step_runtime(priv->eth_dev, *bufs,
 				&tstamp[loop], &ptp_set);
 			if (ptp_set)
-				ptp_set_count++;
-			if (ptp_set_count > 1)
+				ptp_n++;
+			if (ptp_n > 1)
 				DPAA2_PMD_WARN("Multiple ptp formats in burst transmission!");
 			goto skip_fast_mbuf2fd;
 		}
@@ -1614,25 +1621,22 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 				dpaa2_q, priv->tx_conf_type, tstamp[loop]);
 		}
 		if (ret)
-			goto send_n_return;
+			break;
 		bufs++;
 	}
 
+	frames_to_send = loop;
 	loop = 0;
 	retry_count = 0;
 	while (loop < frames_to_send) {
-		ret = qbman_swp_enqueue_multiple(swp, &eqdesc,
-				&fd_arr[loop], &flags[loop],
-				frames_to_send - loop);
-		if (unlikely(ret < 0)) {
+		eq_ret = qbman_swp_enqueue_multiple(swp, &eqdesc,
+			&fd_arr[loop], NULL, frames_to_send - loop);
+		if (unlikely(eq_ret < 0)) {
 			retry_count++;
-			if (retry_count > DPAA2_MAX_TX_RETRY_COUNT) {
-				num_tx += loop;
-				nb_pkts -= loop;
-				goto send_n_return;
-			}
+			if (retry_count > DPAA2_MAX_TX_RETRY_COUNT)
+				break;
 		} else {
-			loop += ret;
+			loop += eq_ret;
 			retry_count = 0;
 		}
 	}
@@ -1647,42 +1651,21 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			}
 		}
 	}
-	if (nb_pkts > 0)
+	if (nb_pkts > 0 && !ret && !order)
 		goto tx_again;
 
-	dpaa2_q->tx_pkts += num_tx;
-
-	return num_tx;
-
-send_n_return:
-	/* send any already prepared fd */
-	retry_count = 0;
-	i = 0;
-	while (i < loop) {
-		ret = qbman_swp_enqueue_multiple(swp, &eqdesc, &fd_arr[i],
-			&flags[i], loop - i);
-		if (unlikely(ret < 0)) {
-			retry_count++;
-			if (retry_count > DPAA2_MAX_TX_RETRY_COUNT)
-				break;
-		} else {
-			i += ret;
-			retry_count = 0;
-		}
-	}
-	num_tx += i;
-	if (priv->tx_conf_type != DPAA2_TX_NO_CONF) {
-		loop = i;
-		for (i = 0; i < loop; i++) {
-			if (tstamp[i]) {
-				rte_atomic_fetch_add_explicit(&dpaa2_q->tx_conf_queue->ts_to_cnfd,
-					1, rte_memory_order_relaxed);
-			}
-		}
-	}
-
 skip_tx:
 	dpaa2_q->tx_pkts += num_tx;
+	if (order && eq_ret >= 0) {
+order_tx_again:
+		frames_to_send = (nb_pkts > dpaa2_eqcr_size) ? dpaa2_eqcr_size : nb_pkts;
+		nb_pkts -= frames_to_send;
+		order_tx = dpaa2_dev_tx_ordered(queue, bufs, frames_to_send);
+		num_tx += order_tx;
+		bufs += frames_to_send;
+		if (nb_pkts && order_tx >= frames_to_send)
+			goto order_tx_again;
+	}
 
 	return num_tx;
 }
@@ -1758,7 +1741,7 @@ dpaa2_dev_tx_multi_txq_ordered(struct dpaa2_queue **dpaa2_q,
 {
 	/* Function to transmit the frames to multiple queues respectively.*/
 	uint32_t loop, retry_count, i;
-	int32_t ret = 0, tstamp[MAX_TX_RING_SLOTS], ptp_set_count, ptp_set;
+	int32_t ret = 0, tstamp[MAX_TX_RING_SLOTS], ptp_n, ptp_set;
 	struct qbman_fd fd_arr[MAX_TX_RING_SLOTS];
 	uint32_t frames_to_send, num_free_eq_desc = 0;
 	struct rte_mempool *hw_mp;
@@ -1767,6 +1750,9 @@ dpaa2_dev_tx_multi_txq_ordered(struct dpaa2_queue **dpaa2_q,
 	struct dpaa2_dev_priv *priv;
 	struct dpaa2_queue *order_sendq;
 	struct dpaa2_queue *cnf_q;
+	uint8_t dqrr_size[MAX_TX_RING_SLOTS], dqrr_index;
+	uint64_t dqrr_held[MAX_TX_RING_SLOTS];
+	uint32_t flags[MAX_TX_RING_SLOTS];
 
 	if (unlikely(!DPAA2_PER_LCORE_DPIO)) {
 		ret = dpaa2_affine_qbman_swp();
@@ -1778,14 +1764,14 @@ dpaa2_dev_tx_multi_txq_ordered(struct dpaa2_queue **dpaa2_q,
 	}
 	swp = DPAA2_PER_LCORE_PORTAL;
 
-	ptp_set_count = 0;
+	ptp_n = 0;
 	frames_to_send = (nb_pkts > dpaa2_eqcr_size) ?
 		dpaa2_eqcr_size : nb_pkts;
 
 	for (loop = 0; loop < frames_to_send; loop++) {
 		priv = dpaa2_q[loop]->eth_data->dev_private;
 		if (!priv->en_loose_ordered &&
-			(*dpaa2_seqn(*bufs) & DPAA2_ENQUEUE_FLAG_ORP)) {
+			(*dpaa2_seqn(bufs[loop]) & DPAA2_ENQUEUE_FLAG_ORP)) {
 			if (!num_free_eq_desc) {
 				num_free_eq_desc = dpaa2_free_eq_descriptors();
 				if (!num_free_eq_desc) {
@@ -1810,32 +1796,41 @@ dpaa2_dev_tx_multi_txq_ordered(struct dpaa2_queue **dpaa2_q,
 		/* Prepare enqueue descriptor */
 		qbman_eq_desc_clear(&eqdesc[loop]);
 
-		if (*dpaa2_seqn(*bufs) && priv->en_ordered) {
+		dqrr_held[loop] = 0;
+		dqrr_size[loop] = 0;
+		if ((*dpaa2_seqn(bufs[loop]) & DPAA2_ENQUEUE_FLAG_ORP) &&
+			priv->en_ordered) {
 			order_sendq = priv->tx_vq[0];
-			dpaa2_set_enqueue_descriptor(order_sendq, *bufs, &eqdesc[loop]);
+			dpaa2_set_enqueue_descriptor(order_sendq, bufs[loop], &eqdesc[loop]);
 		} else {
 			qbman_eq_desc_set_no_orp(&eqdesc[loop], DPAA2_EQ_RESP_ERR_FQ);
 			qbman_eq_desc_set_fq(&eqdesc[loop], dpaa2_q[loop]->fqid);
+			if (*dpaa2_seqn(bufs[loop]) & QBMAN_ENQUEUE_FLAG_DCA) {
+				dqrr_index = *dpaa2_seqn(bufs[loop]) & QBMAN_EQCR_DCA_IDXMASK;
+				dqrr_held[loop] = ~(UINT64_C(1) << dqrr_index);
+				dqrr_size[loop] = 1;
+				flags[loop] = *dpaa2_seqn(bufs[loop]);
+				*dpaa2_seqn(bufs[loop]) = DPAA2_INVALID_MBUF_SEQN;
+				qbman_eq_desc_set_dca(&eqdesc[loop], 1, dqrr_index, 0);
+			}
 		}
 
 		tstamp[loop] = false;
-		if (unlikely(((*bufs)->ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST) &&
+		if (unlikely((bufs[loop]->ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST) &&
 			(priv->flags & DPAA2_IEEE1588_TX_TS_FLAG))) {
 			ptp_set = false;
-			dpaa2_dev_tx_ptp_one_step_runtime(priv->eth_dev, *bufs,
+			dpaa2_dev_tx_ptp_one_step_runtime(priv->eth_dev, bufs[loop],
 				&tstamp[loop], &ptp_set);
 			if (ptp_set)
-				ptp_set_count++;
-			if (ptp_set_count > 1)
+				ptp_n++;
+			if (ptp_n > 1)
 				DPAA2_PMD_WARN("Multiple ptp formats in burst transmission!");
 			goto skip_fast_mbuf2fd;
 		}
 
-		ret = dpaa2_dev_tx_fast_mbuf_to_fd(priv, *bufs, &fd_arr[loop]);
-		if (likely(!ret)) {
-			bufs++;
+		ret = dpaa2_dev_tx_fast_mbuf_to_fd(priv, bufs[loop], &fd_arr[loop]);
+		if (likely(!ret))
 			continue;
-		}
 
 skip_fast_mbuf2fd:
 		if (unlikely(!priv->bp_list)) {
@@ -1843,16 +1838,15 @@ dpaa2_dev_tx_multi_txq_ordered(struct dpaa2_queue **dpaa2_q,
 			goto send_frames;
 		}
 		hw_mp = priv->bp_list->mp;
-		if (unlikely((*bufs)->nb_segs > 1)) {
-			ret = dpaa2_dev_tx_mbuf_to_sg_fd(hw_mp, *bufs, &fd_arr[loop],
+		if (unlikely(bufs[loop]->nb_segs > 1)) {
+			ret = dpaa2_dev_tx_mbuf_to_sg_fd(hw_mp, bufs[loop], &fd_arr[loop],
 				dpaa2_q[loop], priv->tx_conf_type, tstamp[loop]);
 		} else {
-			ret = dpaa2_dev_tx_mbuf_to_simple_fd(hw_mp, *bufs, &fd_arr[loop],
+			ret = dpaa2_dev_tx_mbuf_to_simple_fd(hw_mp, bufs[loop], &fd_arr[loop],
 				dpaa2_q[loop], priv->tx_conf_type, tstamp[loop]);
 		}
 		if (ret)
 			goto send_frames;
-		bufs++;
 	}
 
 send_frames:
@@ -1863,12 +1857,20 @@ dpaa2_dev_tx_multi_txq_ordered(struct dpaa2_queue **dpaa2_q,
 		ret = qbman_swp_enqueue_multiple_desc(swp, &eqdesc[loop],
 				&fd_arr[loop], frames_to_send - loop);
 		if (likely(ret > 0)) {
+			for (i = loop; i < (loop + ret); i++) {
+				DPAA2_PER_LCORE_DQRR_SIZE -= dqrr_size[i];
+				DPAA2_PER_LCORE_DQRR_HELD &= ~dqrr_held[i];
+				dpaa2_q[i]->tx_pkts++;
+			}
 			loop += ret;
 			retry_count = 0;
 		} else {
 			retry_count++;
-			if (retry_count > DPAA2_MAX_TX_RETRY_COUNT)
+			if (retry_count > DPAA2_MAX_TX_RETRY_COUNT) {
+				for (i = loop; i < frames_to_send; i++)
+					*dpaa2_seqn(bufs[i]) = flags[i];
 				break;
+			}
 		}
 	}
 	for (i = 0; i < loop; i++) {
@@ -1908,20 +1910,6 @@ rte_dpaa2_dev_tx_multi_ports(uint16_t port_id[],
 	return dpaa2_dev_tx_multi_txq_ordered(txq, bufs, nb_pkts);
 }
 
-/* Callback to handle sending ordered packets through WRIOP based interface */
-uint16_t
-dpaa2_dev_tx_ordered(void *queue, struct rte_mbuf **bufs,
-	uint16_t nb_pkts)
-{
-	uint16_t i;
-	struct dpaa2_queue *mq[nb_pkts];
-
-	for (i = 0; i < nb_pkts; i++)
-		mq[i] = queue;
-
-	return dpaa2_dev_tx_multi_txq_ordered(mq, bufs, nb_pkts);
-}
-
 /* This function loopbacks all the received packets.*/
 uint16_t
 dpaa2_dev_loopback_rx(void *queue,
-- 
2.43.0

