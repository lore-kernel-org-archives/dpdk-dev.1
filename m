Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ED6606A320
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:50:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A33E4427D7;
	Fri, 23 Oct 2026 15:45:17 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 5A5CD40E37
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:45:02 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3E9AD1A0038;
 Fri, 23 Oct 2026 15:45:02 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 07EDF1A0021;
 Fri, 23 Oct 2026 15:45:02 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 03128180022D;
 Fri, 23 Oct 2026 21:45:00 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 65/65] net/dpaa2: add Tx fast path for no-confirmation
 case
Date: Fri, 23 Oct 2026 19:13:45 +0530
Message-ID: <20261023134346.37727-66-prashant.gupta_3@nxp.com>
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

Split a dedicated Tx fast path out of dpaa2_dev_tx() for the common
no-confirmation configuration, keeping the hot enqueue loop free of the
Tx-conf and timestamp bookkeeping needed only by the slow path.

- Add dpaa2_dev_tx_fast() for the DPAA2_TX_NO_CONF case. dpaa2_dev_tx()
  builds the enqueue descriptor and dispatches straight to it, so the
  common path no longer runs the per-burst Tx-conf drain or the
  per-packet timestamp accounting.
- Factor the retry enqueue loop into dpaa2_dev_tx_enqueue_multiple() and
  the ordered-queue tail into dpaa2_dev_tx_multi_ordered(), shared by
  both the fast and slow paths to remove duplicated code.
- Zero-initialise fd_arr in the slow path and mark the rarely taken
  branches (congestion retry, VLAN insert, ordered, timestamp) unlikely.

This reduces per-packet work on the common Tx path.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa2/dpaa2_rxtx.c | 158 +++++++++++++++++++++++++--------
 1 file changed, 122 insertions(+), 36 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 2af5a4745d..312c9bd7d5 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -1511,6 +1511,114 @@ dpaa2_dev_tx_ordered(void *queue, struct rte_mbuf **bufs,
 	return dpaa2_dev_tx_multi_txq_ordered(mq, bufs, nb_pkts);
 }
 
+static __rte_always_inline uint16_t __rte_hot
+dpaa2_dev_tx_enqueue_multiple(struct qbman_swp *swp,
+	const struct qbman_fd *fd, uint16_t to_send,
+	const struct qbman_eq_desc *eqdesc)
+{
+	uint16_t loop = 0, retry_count = 0;
+	int eq_ret;
+
+	while (loop < to_send) {
+		eq_ret = qbman_swp_enqueue_multiple(swp, eqdesc,
+			&fd[loop], NULL, to_send - loop);
+		if (unlikely(eq_ret < 0)) {
+			retry_count++;
+			if (retry_count > DPAA2_MAX_TX_RETRY_COUNT)
+				break;
+		} else {
+			loop += eq_ret;
+			retry_count = 0;
+		}
+	}
+
+	return loop;
+}
+
+static __rte_noinline uint16_t
+dpaa2_dev_tx_multi_ordered(struct dpaa2_queue *dpaa2_q,
+	struct rte_mbuf **bufs, uint16_t nb_pkts)
+{
+	uint16_t to_send, order_tx = 0, total = 0;
+
+order_tx_again:
+	to_send = (nb_pkts > dpaa2_eqcr_size) ? dpaa2_eqcr_size : nb_pkts;
+	order_tx = dpaa2_dev_tx_ordered(dpaa2_q, bufs, to_send);
+	bufs += order_tx;
+	nb_pkts -= order_tx;
+	total += order_tx;
+	if (nb_pkts && order_tx >= to_send)
+		goto order_tx_again;
+
+	return total;
+}
+
+static __rte_always_inline uint16_t __rte_hot
+dpaa2_dev_tx_fast(struct dpaa2_queue *dpaa2_q, struct rte_mbuf **bufs,
+	uint16_t nb_pkts, struct qbman_swp *swp, struct qbman_fd *fd_arr,
+	const struct qbman_eq_desc *eqdesc, struct rte_mempool *hw_mp)
+{
+	/* Function to transmit the frames to given device and VQ*/
+	uint32_t loop, retry_count, frames_to_send;
+	int32_t ret, order = false;
+	uint16_t num_tx = 0, eq_ret = 0;
+
+tx_again:
+	/*Check if the queue is congested*/
+	retry_count = 0;
+	while (qbman_result_SCN_state(dpaa2_q->cscn)) {
+		retry_count++;
+		/* Retry for some time before giving up */
+		if (retry_count > CONG_RETRY_COUNT)
+			goto skip_tx;
+	}
+
+	frames_to_send = (nb_pkts > dpaa2_eqcr_size) ? dpaa2_eqcr_size : nb_pkts;
+
+	for (loop = 0; loop < frames_to_send; loop++) {
+		if (unlikely(dpaa2_mbuf_seq_is_flag_set((*bufs),
+			(DPAA2_ENQUEUE_FLAG_ORP | QBMAN_ENQUEUE_FLAG_DCA)))) {
+			order = true;
+			break;
+		}
+
+		if (unlikely((*bufs)->ol_flags & RTE_MBUF_F_TX_VLAN)) {
+			ret = rte_vlan_insert(bufs);
+			if (ret)
+				break;
+		}
+		if (likely(RTE_MBUF_DIRECT(*bufs) &&
+			(*bufs)->pool->ops_index == hw_mp->ops_index &&
+			(*bufs)->nb_segs == 1 && rte_mbuf_refcnt_read(*bufs) == 1)) {
+			DPAA2_MBUF_TO_CONTIG_FD((*bufs), &fd_arr[loop],
+				mempool_to_bpid((*bufs)->pool));
+			ret = 0;
+		} else if (unlikely((*bufs)->nb_segs > 1)) {
+			ret = dpaa2_dev_tx_mbuf_to_sg_fd(hw_mp, *bufs, &fd_arr[loop],
+				dpaa2_q, DPAA2_TX_NO_CONF, false);
+		} else {
+			ret = dpaa2_dev_tx_mbuf_to_simple_fd(hw_mp, *bufs, &fd_arr[loop],
+				dpaa2_q, DPAA2_TX_NO_CONF, false);
+		}
+		if (ret)
+			break;
+		bufs++;
+	}
+
+	eq_ret = dpaa2_dev_tx_enqueue_multiple(swp, fd_arr, loop, eqdesc);
+	num_tx += eq_ret;
+	nb_pkts -= eq_ret;
+	if (unlikely(nb_pkts > 0 && !ret && !order))
+		goto tx_again;
+
+skip_tx:
+	dpaa2_q->tx_pkts += num_tx;
+	if (unlikely(order && eq_ret >= loop))
+		num_tx += dpaa2_dev_tx_multi_ordered(dpaa2_q, bufs, nb_pkts);
+
+	return num_tx;
+}
+
 /*
  * Callback to handle sending packets through WRIOP based interface
  */
@@ -1519,12 +1627,12 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
 	/* Function to transmit the frames to given device and VQ*/
 	uint32_t loop, retry_count, i, ptp_n, frames_to_send;
-	int32_t ret, tstamp[MAX_TX_RING_SLOTS], ptp_set, order = false, eq_ret = 0;
-	struct qbman_fd fd_arr[MAX_TX_RING_SLOTS];
+	int32_t ret, tstamp[MAX_TX_RING_SLOTS], ptp_set, order = false;
+	struct qbman_fd fd_arr[MAX_TX_RING_SLOTS] = {0};
 	struct qbman_eq_desc eqdesc;
 	struct dpaa2_queue *dpaa2_q = queue;
 	struct qbman_swp *swp;
-	uint16_t num_tx = 0, order_tx;
+	uint16_t num_tx = 0, eq_ret = 0;
 	struct rte_eth_dev_data *eth_data = dpaa2_q->eth_data;
 	struct dpaa2_dev_priv *priv = eth_data->dev_private;
 	struct rte_mempool *hw_mp;
@@ -1549,15 +1657,15 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	}
 	hw_mp = priv->bp_list->mp;
 
-	if (dpaa2_q->tx_conf_queue)
-		dpaa2_dev_tx_conf(dpaa2_q->tx_conf_queue, false);
-
 	/*Prepare enqueue descriptor*/
 	qbman_eq_desc_clear(&eqdesc);
 	qbman_eq_desc_set_no_orp(&eqdesc, DPAA2_EQ_RESP_ERR_FQ);
 	qbman_eq_desc_set_fq(&eqdesc, dpaa2_q->fqid);
+	if (likely(priv->tx_conf_type == DPAA2_TX_NO_CONF))
+		return dpaa2_dev_tx_fast(dpaa2_q, bufs, nb_pkts, swp, fd_arr, &eqdesc, hw_mp);
 
-	/*Clear the unused FD fields before sending*/
+	if (dpaa2_q->tx_conf_queue)
+		dpaa2_dev_tx_conf(dpaa2_q->tx_conf_queue, false);
 
 tx_again:
 	/*Check if the queue is congested*/
@@ -1617,27 +1725,13 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		bufs++;
 	}
 
-	frames_to_send = loop;
-	loop = 0;
-	retry_count = 0;
-	while (loop < frames_to_send) {
-		eq_ret = qbman_swp_enqueue_multiple(swp, &eqdesc,
-			&fd_arr[loop], NULL, frames_to_send - loop);
-		if (unlikely(eq_ret < 0)) {
-			retry_count++;
-			if (retry_count > DPAA2_MAX_TX_RETRY_COUNT)
-				break;
-		} else {
-			loop += eq_ret;
-			retry_count = 0;
-		}
-	}
+	eq_ret = dpaa2_dev_tx_enqueue_multiple(swp, fd_arr, loop, &eqdesc);
+	num_tx += eq_ret;
+	nb_pkts -= eq_ret;
 
-	num_tx += loop;
-	nb_pkts -= loop;
 	if (priv->tx_conf_type != DPAA2_TX_NO_CONF) {
-		for (i = 0; i < loop; i++) {
-			if (tstamp[i]) {
+		for (i = 0; i < eq_ret; i++) {
+			if (unlikely(tstamp[i])) {
 				rte_atomic_fetch_add_explicit(&dpaa2_q->tx_conf_queue->ts_to_cnfd,
 					1, rte_memory_order_relaxed);
 			}
@@ -1648,16 +1742,8 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 skip_tx:
 	dpaa2_q->tx_pkts += num_tx;
-	if (order && eq_ret >= 0) {
-order_tx_again:
-		frames_to_send = (nb_pkts > dpaa2_eqcr_size) ? dpaa2_eqcr_size : nb_pkts;
-		nb_pkts -= frames_to_send;
-		order_tx = dpaa2_dev_tx_ordered(queue, bufs, frames_to_send);
-		num_tx += order_tx;
-		bufs += frames_to_send;
-		if (nb_pkts && order_tx >= frames_to_send)
-			goto order_tx_again;
-	}
+	if (unlikely(order && eq_ret >= loop))
+		num_tx += dpaa2_dev_tx_multi_ordered(dpaa2_q, bufs, nb_pkts);
 
 	return num_tx;
 }
-- 
2.43.0

