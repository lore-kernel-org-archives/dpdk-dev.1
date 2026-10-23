Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AAA606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:50:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC118427C4;
	Fri, 23 Oct 2026 15:45:12 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 8473F410FC
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:56 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 637791A0038;
 Fri, 23 Oct 2026 15:44:56 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 045241A0042;
 Fri, 23 Oct 2026 15:44:56 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9C564180006C;
 Fri, 23 Oct 2026 21:44:54 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 59/65] bus/fslmc: track atomic DCA context per dequeue
 dpio
Date: Fri, 23 Oct 2026 19:13:39 +0530
Message-ID: <20261023134346.37727-60-prashant.gupta_3@nxp.com>
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

For atomic scheduling the DQRR entry consumed at dequeue must be
acknowledged (DCA) from the same DPIO portal that dequeued it. The
enqueue and dequeue portals are not guaranteed to be same, so
applying the DCA index using the enqueuing's DPIO can acknowledge
the wrong portal. This corrupts the held-buffer accounting
(dqrr_size / dqrr_held) and leaks DQRR entries on the originating portal.

Record the originating dequeue DPIO alongside the sequence number when
a frame is dequeued, and only set the DCA and update the held-buffer
state when the enqueuing DPIO matches the saved one.

The atomic dequeue/enqueue logic that was open-coded in the net,
crypto and event drivers is consolidated into shared helpers in
dpaa2_hw_pvt.h:

  - dpaa2_dq_atomic_save()        save DQRR index and dequeue DPIO
  - dpaa2_eq_atomic_consume()     consume DCA only if DPIO matches
  - dpaa2_eq_atomic_dpio_update() release held DQRR after enqueue
  - dpaa2_mbuf_seq_restore()      restore seqn on enqueue failure
  - dpaa2_mbuf_seq_is_flag_set()  test seqn flags

The net, crypto and event enqueue paths are updated to use these
helpers and to restore the saved sequence number on the enqueue retry
/ failure path so the DQRR entry can be reclaimed. Ordered (ORP)
handling is left unchanged.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h     | 55 ++++++++++++++++
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c | 73 +++++++++++----------
 drivers/event/dpaa2/dpaa2_eventdev.c        | 53 ++++++++-------
 drivers/net/dpaa2/dpaa2_rxtx.c              | 44 +++++--------
 4 files changed, 141 insertions(+), 84 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index 1731999257..1ee53c53a2 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -510,6 +510,61 @@ dpaa2_mem_va_to_iova_check(void *va, uint64_t size)
 #define DPAA2_IOVA_TO_VADDR_AND_CHECK(_iova, size) \
 	rte_fslmc_cold_mem_iova_to_vaddr(_iova, size)
 
+#define dpaa2_eq_atomic_dpio_update(start, len, dpio, dqrr_size, dqrr_held) \
+({ \
+	uint16_t i; \
+	\
+	for (i = start; i < (uint16_t)(start + len); i++) { \
+		dpio->dpaa2_held_bufs.dqrr_size -= dqrr_size[i]; \
+		dpio->dpaa2_held_bufs.dqrr_held &= ~dqrr_held[i]; \
+	} \
+})
+
+#define dpaa2_mbuf_seq_restore(mbuf, restore) \
+({ \
+	*dpaa2_seqn(mbuf) = restore; \
+})
+
+#define dpaa2_mbuf_seq_is_flag_set(mbuf, flag) \
+({ \
+	*dpaa2_seqn(mbuf) & flag; \
+})
+
+#define dpaa2_eq_atomic_consume(mbuf, size, held, dpio_eq, flag, eqdesc, atomic) \
+({ \
+	uint32_t seqn; \
+	\
+	if (*dpaa2_seq_dpio_dq(mbuf) == dpio_eq) { \
+		seqn = *dpaa2_seqn(mbuf); \
+		if (eqdesc) { \
+			qbman_eq_desc_set_dca(eqdesc, 1, \
+				(seqn & QBMAN_EQCR_DCA_IDXMASK), 0); \
+		} \
+		if (flag) { \
+			*flag = seqn; \
+			*dpaa2_seqn(mbuf) = DPAA2_INVALID_MBUF_SEQN; \
+		} \
+		if (eqdesc || flag) { \
+			size = 1; \
+			held = UINT64_C(1) << (seqn & QBMAN_EQCR_DCA_IDXMASK); \
+		} \
+		atomic = true; \
+	} \
+})
+
+static inline void
+dpaa2_dq_atomic_save(const struct qbman_result *dq,
+	struct rte_mbuf *mbuf, struct dpaa2_dpio_dev *dpio_dev)
+{
+	uint8_t dqrr_index = qbman_get_dqrr_idx(dq);
+
+	*dpaa2_seqn(mbuf) = QBMAN_ENQUEUE_FLAG_DCA | dqrr_index;
+	*dpaa2_seq_dpio_dq(mbuf) = dpio_dev;
+	dpio_dev->dpaa2_held_bufs.dqrr_size++;
+	dpio_dev->dpaa2_held_bufs.dqrr_held |= UINT64_C(1) << dqrr_index;
+	dpio_dev->dpaa2_held_bufs.mbuf[dqrr_index] = mbuf;
+}
+
 static inline
 int check_swp_active_dqs(uint16_t dpio_index)
 {
diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index 9d2fa57989..8e0db6a385 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -1512,7 +1512,7 @@ dpaa2_sec_set_enqueue_descriptor(struct dpaa2_queue *dpaa2_q,
 	uint16_t orpid, seqnum;
 	uint8_t dq_idx;
 
-	if (*dpaa2_seqn(m) & DPAA2_ENQUEUE_FLAG_ORP) {
+	if (dpaa2_mbuf_seq_is_flag_set(m, DPAA2_ENQUEUE_FLAG_ORP)) {
 		orpid = (*dpaa2_seqn(m) & DPAA2_EQCR_OPRID_MASK) >>
 			DPAA2_EQCR_OPRID_SHIFT;
 		seqnum = (*dpaa2_seqn(m) & DPAA2_EQCR_SEQNUM_MASK) >>
@@ -1548,15 +1548,17 @@ dpaa2_sec_enqueue_burst_ordered(void *qp, struct rte_crypto_op **ops,
 	uint16_t nb_ops)
 {
 	/* Function to transmit the frames to given device and VQ*/
-	int32_t ret;
+	int32_t ret, atomic = false;
 	struct qbman_fd fd_arr[MAX_TX_RING_SLOTS];
-	uint32_t frames_to_send, num_free_eq_desc, retry_count, loop;
+	uint32_t num_free_eq_desc, retry_count, flags[MAX_TX_RING_SLOTS];
 	struct qbman_eq_desc eqdesc[MAX_TX_RING_SLOTS];
 	struct dpaa2_sec_qp *dpaa2_qp = qp;
 	struct qbman_swp *swp;
-	uint16_t num_tx = 0, bpid;
-	uint8_t dqrr_index;
+	uint16_t num_tx = 0, bpid, frames_to_send, loop;
+	uint8_t dqrr_size[MAX_TX_RING_SLOTS];
 	struct dpaa2_sec_dev_private *priv = dpaa2_qp->tx_vq.crypto_data->dev_private;
+	struct rte_mbuf *mbuf[MAX_TX_RING_SLOTS];
+	uint64_t dqrr_held[MAX_TX_RING_SLOTS];
 
 	if (unlikely(!nb_ops))
 		return 0;
@@ -1579,7 +1581,8 @@ dpaa2_sec_enqueue_burst_ordered(void *qp, struct rte_crypto_op **ops,
 		frames_to_send = (nb_ops > dpaa2_eqcr_size) ? dpaa2_eqcr_size : nb_ops;
 
 		if (!priv->en_loose_ordered) {
-			if (*dpaa2_seqn((*ops)->sym->m_src) & DPAA2_ENQUEUE_FLAG_ORP) {
+			if (dpaa2_mbuf_seq_is_flag_set((*ops)->sym->m_src,
+				DPAA2_ENQUEUE_FLAG_ORP)) {
 				num_free_eq_desc = dpaa2_free_eq_descriptors();
 				if (num_free_eq_desc < frames_to_send)
 					frames_to_send = num_free_eq_desc;
@@ -1590,18 +1593,20 @@ dpaa2_sec_enqueue_burst_ordered(void *qp, struct rte_crypto_op **ops,
 			/*Prepare enqueue descriptor*/
 			qbman_eq_desc_clear(&eqdesc[loop]);
 			qbman_eq_desc_set_fq(&eqdesc[loop], dpaa2_qp->tx_vq.fqid);
+			mbuf[loop] = (*ops)->sym->m_src;
 
-			if (*dpaa2_seqn((*ops)->sym->m_src) & DPAA2_ENQUEUE_FLAG_ORP) {
+			flags[loop] = 0;
+			dqrr_size[loop] = 0;
+			dqrr_held[loop] = 0;
+			if (dpaa2_mbuf_seq_is_flag_set(mbuf[loop], DPAA2_ENQUEUE_FLAG_ORP)) {
 				dpaa2_sec_set_enqueue_descriptor(&dpaa2_qp->tx_vq,
-					(*ops)->sym->m_src, &eqdesc[loop]);
+					mbuf[loop], &eqdesc[loop]);
 			} else {
-				if (*dpaa2_seqn((*ops)->sym->m_src) & QBMAN_ENQUEUE_FLAG_DCA) {
-					dqrr_index = *dpaa2_seqn((*ops)->sym->m_src) &
-						QBMAN_EQCR_DCA_IDXMASK;
-					DPAA2_PER_LCORE_DQRR_SIZE--;
-					DPAA2_PER_LCORE_DQRR_HELD &= ~(UINT64_C(1) << dqrr_index);
-					qbman_eq_desc_set_dca(&eqdesc[loop], 1, dqrr_index, 0);
-					*dpaa2_seqn((*ops)->sym->m_src) = DPAA2_INVALID_MBUF_SEQN;
+				if (dpaa2_mbuf_seq_is_flag_set(mbuf[loop],
+					QBMAN_ENQUEUE_FLAG_DCA)) {
+					dpaa2_eq_atomic_consume(mbuf[loop], dqrr_size[loop],
+						dqrr_held[loop], DPAA2_PER_LCORE_DPIO,
+						&flags[loop], &eqdesc[loop], atomic);
 				}
 				qbman_eq_desc_set_no_orp(&eqdesc[loop], DPAA2_EQ_RESP_ERR_FQ);
 			}
@@ -1631,18 +1636,25 @@ dpaa2_sec_enqueue_burst_ordered(void *qp, struct rte_crypto_op **ops,
 					frames_to_send - loop);
 			if (unlikely(ret < 0)) {
 				retry_count++;
-				if (retry_count > DPAA2_MAX_TX_RETRY_COUNT) {
-					num_tx += loop;
-					nb_ops -= loop;
-					DPAA2_SEC_DP_DEBUG("Enqueue fail");
-					/* freeing the fle buffers */
-					while (loop < frames_to_send) {
-						free_fle(&fd_arr[loop], dpaa2_qp);
-						loop++;
-					}
-					goto skip_tx;
+				if (retry_count <= DPAA2_MAX_TX_RETRY_COUNT)
+					continue;
+				num_tx += loop;
+				nb_ops -= loop;
+				DPAA2_SEC_DP_DEBUG("Failed(%d) to eq %d FDs",
+					ret, frames_to_send - loop);
+				/* freeing the fle buffers */
+				while (loop < frames_to_send) {
+					free_fle(&fd_arr[loop], dpaa2_qp);
+					if (flags[loop])
+						dpaa2_mbuf_seq_restore(mbuf[loop], flags[loop]);
+					loop++;
 				}
+				goto skip_tx;
 			} else {
+				if (atomic) {
+					dpaa2_eq_atomic_dpio_update(loop, ret, DPAA2_PER_LCORE_DPIO,
+						dqrr_size, dqrr_held);
+				}
 				loop += ret;
 				retry_count = 0;
 			}
@@ -1698,8 +1710,8 @@ dpaa2_sec_enqueue_burst(void *qp, struct rte_crypto_op **ops,
 		frames_to_send = (nb_ops > dpaa2_eqcr_size) ? dpaa2_eqcr_size : nb_ops;
 
 		for (loop = 0; loop < frames_to_send; loop++) {
-			if (*dpaa2_seqn((*ops)->sym->m_src) &
-				(QBMAN_ENQUEUE_FLAG_DCA | DPAA2_ENQUEUE_FLAG_ORP)) {
+			if (unlikely(dpaa2_mbuf_seq_is_flag_set((*ops)->sym->m_src,
+				(DPAA2_ENQUEUE_FLAG_ORP | QBMAN_ENQUEUE_FLAG_DCA)))) {
 				order = true;
 				break;
 			}
@@ -4108,7 +4120,6 @@ dpaa2_sec_process_atomic_event(struct dpaa2_dpio_dev *dpio_dev,
 	const struct qbman_fd *fd, const struct qbman_result *dq,
 	struct dpaa2_queue *rxq, struct rte_event *ev)
 {
-	uint8_t dqrr_index;
 	struct dpaa2_sec_qp *qp;
 	struct rte_crypto_op *crypto_op;
 
@@ -4122,11 +4133,7 @@ dpaa2_sec_process_atomic_event(struct dpaa2_dpio_dev *dpio_dev,
 	ev->priority = rxq->ev.priority;
 
 	crypto_op = dpaa2_sec_fd_to_mbuf(fd, qp);
-	dqrr_index = qbman_get_dqrr_idx(dq);
-	*dpaa2_seqn(crypto_op->sym->m_src) = QBMAN_ENQUEUE_FLAG_DCA | dqrr_index;
-	dpio_dev->dpaa2_held_bufs.dqrr_size++;
-	dpio_dev->dpaa2_held_bufs.dqrr_held |= UINT64_C(1) << dqrr_index;
-	dpio_dev->dpaa2_held_bufs.mbuf[dqrr_index] = crypto_op->sym->m_src;
+	dpaa2_dq_atomic_save(dq, crypto_op->sym->m_src, dpio_dev);
 	ev->event_ptr = crypto_op;
 }
 
diff --git a/drivers/event/dpaa2/dpaa2_eventdev.c b/drivers/event/dpaa2/dpaa2_eventdev.c
index 2efdbb8b59..8ad9fe7d30 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev.c
@@ -124,14 +124,14 @@ dpaa2_eventdev_enqueue_burst(void *port, const struct rte_event ev[],
 	struct dpaa2_port *dpaa2_portal = port;
 	struct dpaa2_dpio_dev *dpio_dev;
 	struct dpaa2_eventq *evq_info;
-	uint32_t queue_id, retry_count, loop, frames_to_send, i;
+	uint32_t queue_id, retry_count, flags[MAX_TX_RING_SLOTS];
 	struct qbman_swp *swp;
 	struct qbman_fd fd_arr[MAX_TX_RING_SLOTS];
 	struct qbman_eq_desc eqdesc[MAX_TX_RING_SLOTS];
-	uint16_t num_tx = 0;
+	uint16_t num_tx = 0, loop, _loop, frames_to_send;
 	uint64_t dqrr_held[MAX_TX_RING_SLOTS];
-	int ret;
-	uint8_t dqrr_index, dqrr_size[MAX_TX_RING_SLOTS];
+	int ret, atomic = false;
+	uint8_t dqrr_size[MAX_TX_RING_SLOTS];
 	const struct rte_event *event;
 	struct dpaa2_queue *dpci_txq[MAX_TX_RING_SLOTS];
 	struct rte_event *ev_tx[MAX_TX_RING_SLOTS];
@@ -181,15 +181,15 @@ dpaa2_eventdev_enqueue_burst(void *port, const struct rte_event ev[],
 			qbman_eq_desc_set_fq(&eqdesc[loop], dpci_txq[loop]->fqid);
 			qbman_eq_desc_set_no_orp(&eqdesc[loop], 0);
 			qbman_eq_desc_set_response(&eqdesc[loop], 0, 0);
+			flags[loop] = 0;
 			dqrr_held[loop] = 0;
 			dqrr_size[loop] = 0;
 
 			if (event->sched_type == RTE_SCHED_TYPE_ATOMIC &&
-				(*dpaa2_seqn(event->mbuf) & QBMAN_ENQUEUE_FLAG_DCA)) {
-				dqrr_index = *dpaa2_seqn(event->mbuf) & QBMAN_EQCR_DCA_IDXMASK;
-				qbman_eq_desc_set_dca(&eqdesc[loop], 1, dqrr_index, 0);
-				dqrr_size[loop] = 1;
-				dqrr_held[loop] = UINT64_C(1) << dqrr_index;
+				dpaa2_mbuf_seq_is_flag_set(event->mbuf, QBMAN_ENQUEUE_FLAG_DCA)) {
+				dpaa2_eq_atomic_consume(event->mbuf, dqrr_size[loop],
+					dqrr_held[loop], dpio_dev, &flags[loop],
+					&eqdesc[loop], atomic);
 			}
 
 			memset(&fd_arr[loop], 0, sizeof(struct qbman_fd));
@@ -213,17 +213,22 @@ dpaa2_eventdev_enqueue_burst(void *port, const struct rte_event ev[],
 					frames_to_send - loop);
 			if (unlikely(ret < 0)) {
 				retry_count++;
-				if (retry_count > DPAA2_EV_TX_RETRY_COUNT) {
-					num_tx += loop;
-					nb_events -= loop;
-					for (i = loop; i < frames_to_send; i++)
-						rte_mempool_put(dpci_txq[i]->env_pool, ev_tx[i]);
-					goto quit;
+				if (retry_count <= DPAA2_EV_TX_RETRY_COUNT)
+					continue;
+				_loop = loop;
+				while (_loop < frames_to_send) {
+					rte_mempool_put(dpci_txq[_loop]->env_pool, ev_tx[_loop]);
+					if (flags[_loop]) {
+						dpaa2_mbuf_seq_restore(ev[num_tx + _loop].mbuf,
+							flags[_loop]);
+					}
+					_loop++;
 				}
+				break;
 			} else {
-				for (i = loop; i < (loop + ret); i++) {
-					dpio_dev->dpaa2_held_bufs.dqrr_size -= dqrr_size[i];
-					dpio_dev->dpaa2_held_bufs.dqrr_held &= ~dqrr_held[i];
+				if (unlikely(atomic)) {
+					dpaa2_eq_atomic_dpio_update(loop, ret, dpio_dev,
+						dqrr_size, dqrr_held);
 				}
 				loop += ret;
 				retry_count = 0;
@@ -231,6 +236,8 @@ dpaa2_eventdev_enqueue_burst(void *port, const struct rte_event ev[],
 		}
 		num_tx += loop;
 		nb_events -= loop;
+		if (unlikely(ret < 0))
+			break;
 	}
 
 quit:
@@ -269,14 +276,10 @@ static void dpaa2_eventdev_process_atomic(struct dpaa2_dpio_dev *dpio_dev,
 	struct dpaa2_queue *rxq, struct rte_event *ev)
 {
 	struct rte_event *rx_ev = (void *)DPAA2_GET_FD_ADDR(fd);
-	uint8_t dqrr_index = qbman_get_dqrr_idx(dq);
 
 	rte_memcpy(ev, rx_ev, sizeof(struct rte_event));
 	rte_mempool_put(rxq->env_pool, rx_ev);
-	*dpaa2_seqn(ev->mbuf) = dqrr_index | QBMAN_ENQUEUE_FLAG_DCA;
-	dpio_dev->dpaa2_held_bufs.dqrr_size++;
-	dpio_dev->dpaa2_held_bufs.dqrr_held |= UINT64_C(1) << dqrr_index;
-	dpio_dev->dpaa2_held_bufs.mbuf[dqrr_index] = ev->mbuf;
+	dpaa2_dq_atomic_save(dq, ev->mbuf, dpio_dev);
 }
 
 static uint16_t
@@ -312,10 +315,10 @@ dpaa2_eventdev_dequeue_burst(void *port, struct rte_event ev[],
 			break;
 		}
 		if (dpio_dev->dpaa2_held_bufs.dqrr_held & (UINT64_C(1) << i)) {
+			dpaa2_mbuf_seq_restore(dpio_dev->dpaa2_held_bufs.mbuf[i],
+				DPAA2_INVALID_MBUF_SEQN);
 			qbman_swp_dqrr_idx_consume(swp, i);
 			dpio_dev->dpaa2_held_bufs.dqrr_size--;
-			*dpaa2_seqn(dpio_dev->dpaa2_held_bufs.mbuf[i]) =
-				DPAA2_INVALID_MBUF_SEQN;
 		}
 		i++;
 	}
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 56da29a927..149fabc0e2 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -1222,8 +1222,6 @@ dpaa2_dev_process_atomic_event(struct dpaa2_dpio_dev *dpio_dev,
 	const struct qbman_fd *fd, const struct qbman_result *dq,
 	struct dpaa2_queue *rxq, struct rte_event *ev)
 {
-	uint8_t dqrr_index;
-
 	if (dpaa2_svr_family != SVR_LX2160A)
 		dpaa2_dev_rx_annot_prefetch(fd);
 
@@ -1233,11 +1231,7 @@ dpaa2_dev_process_atomic_event(struct dpaa2_dpio_dev *dpio_dev,
 	else
 		ev->mbuf = dpaa2_eth_fd_to_mbuf(rxq->eth_data->dev_private, fd);
 
-	dqrr_index = qbman_get_dqrr_idx(dq);
-	*dpaa2_seqn(ev->mbuf) = dqrr_index | QBMAN_ENQUEUE_FLAG_DCA;
-	dpio_dev->dpaa2_held_bufs.dqrr_size++;
-	dpio_dev->dpaa2_held_bufs.dqrr_held |= UINT64_C(1) << dqrr_index;
-	dpio_dev->dpaa2_held_bufs.mbuf[dqrr_index] = ev->mbuf;
+	dpaa2_dq_atomic_save(dq, ev->mbuf, dpio_dev);
 }
 
 void __rte_hot
@@ -1581,8 +1575,8 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	frames_to_send = (nb_pkts > dpaa2_eqcr_size) ? dpaa2_eqcr_size : nb_pkts;
 
 	for (loop = 0; loop < frames_to_send; loop++) {
-		if (unlikely(*dpaa2_seqn((*bufs)) &
-			(DPAA2_ENQUEUE_FLAG_ORP | QBMAN_ENQUEUE_FLAG_DCA))) {
+		if (unlikely(dpaa2_mbuf_seq_is_flag_set((*bufs),
+			(DPAA2_ENQUEUE_FLAG_ORP | QBMAN_ENQUEUE_FLAG_DCA)))) {
 			order = true;
 			break;
 		}
@@ -1701,7 +1695,7 @@ dpaa2_set_enqueue_descriptor(struct dpaa2_queue *dpaa2_q,
 
 	qbman_eq_desc_set_fq(eqdesc, dpaa2_q->fqid);
 
-	if (*dpaa2_seqn(m) & DPAA2_ENQUEUE_FLAG_ORP) {
+	if (dpaa2_mbuf_seq_is_flag_set(m, DPAA2_ENQUEUE_FLAG_ORP)) {
 		orpid = (*dpaa2_seqn(m) & DPAA2_EQCR_OPRID_MASK) >>
 			DPAA2_EQCR_OPRID_SHIFT;
 		seqnum = (*dpaa2_seqn(m) & DPAA2_EQCR_SEQNUM_MASK) >>
@@ -1741,7 +1735,7 @@ dpaa2_dev_tx_multi_txq_ordered(struct dpaa2_queue **dpaa2_q,
 {
 	/* Function to transmit the frames to multiple queues respectively.*/
 	uint32_t loop, retry_count, i;
-	int32_t ret = 0, tstamp[MAX_TX_RING_SLOTS], ptp_n, ptp_set;
+	int32_t ret = 0, tstamp[MAX_TX_RING_SLOTS], ptp_n, ptp_set, atomic = false;
 	struct qbman_fd fd_arr[MAX_TX_RING_SLOTS];
 	uint32_t frames_to_send, num_free_eq_desc = 0;
 	struct rte_mempool *hw_mp;
@@ -1750,7 +1744,7 @@ dpaa2_dev_tx_multi_txq_ordered(struct dpaa2_queue **dpaa2_q,
 	struct dpaa2_dev_priv *priv;
 	struct dpaa2_queue *order_sendq;
 	struct dpaa2_queue *cnf_q;
-	uint8_t dqrr_size[MAX_TX_RING_SLOTS], dqrr_index;
+	uint8_t dqrr_size[MAX_TX_RING_SLOTS];
 	uint64_t dqrr_held[MAX_TX_RING_SLOTS];
 	uint32_t flags[MAX_TX_RING_SLOTS];
 
@@ -1771,7 +1765,7 @@ dpaa2_dev_tx_multi_txq_ordered(struct dpaa2_queue **dpaa2_q,
 	for (loop = 0; loop < frames_to_send; loop++) {
 		priv = dpaa2_q[loop]->eth_data->dev_private;
 		if (!priv->en_loose_ordered &&
-			(*dpaa2_seqn(bufs[loop]) & DPAA2_ENQUEUE_FLAG_ORP)) {
+			dpaa2_mbuf_seq_is_flag_set(bufs[loop], DPAA2_ENQUEUE_FLAG_ORP)) {
 			if (!num_free_eq_desc) {
 				num_free_eq_desc = dpaa2_free_eq_descriptors();
 				if (!num_free_eq_desc) {
@@ -1798,20 +1792,17 @@ dpaa2_dev_tx_multi_txq_ordered(struct dpaa2_queue **dpaa2_q,
 
 		dqrr_held[loop] = 0;
 		dqrr_size[loop] = 0;
-		if ((*dpaa2_seqn(bufs[loop]) & DPAA2_ENQUEUE_FLAG_ORP) &&
+		if (dpaa2_mbuf_seq_is_flag_set(bufs[loop], DPAA2_ENQUEUE_FLAG_ORP) &&
 			priv->en_ordered) {
 			order_sendq = priv->tx_vq[0];
 			dpaa2_set_enqueue_descriptor(order_sendq, bufs[loop], &eqdesc[loop]);
 		} else {
 			qbman_eq_desc_set_no_orp(&eqdesc[loop], DPAA2_EQ_RESP_ERR_FQ);
 			qbman_eq_desc_set_fq(&eqdesc[loop], dpaa2_q[loop]->fqid);
-			if (*dpaa2_seqn(bufs[loop]) & QBMAN_ENQUEUE_FLAG_DCA) {
-				dqrr_index = *dpaa2_seqn(bufs[loop]) & QBMAN_EQCR_DCA_IDXMASK;
-				dqrr_held[loop] = ~(UINT64_C(1) << dqrr_index);
-				dqrr_size[loop] = 1;
-				flags[loop] = *dpaa2_seqn(bufs[loop]);
-				*dpaa2_seqn(bufs[loop]) = DPAA2_INVALID_MBUF_SEQN;
-				qbman_eq_desc_set_dca(&eqdesc[loop], 1, dqrr_index, 0);
+			if (dpaa2_mbuf_seq_is_flag_set(bufs[loop], QBMAN_ENQUEUE_FLAG_DCA)) {
+				dpaa2_eq_atomic_consume(bufs[loop], dqrr_size[loop],
+					dqrr_held[loop], DPAA2_PER_LCORE_DPIO, &flags[loop],
+					&eqdesc[loop], atomic);
 			}
 		}
 
@@ -1857,18 +1848,19 @@ dpaa2_dev_tx_multi_txq_ordered(struct dpaa2_queue **dpaa2_q,
 		ret = qbman_swp_enqueue_multiple_desc(swp, &eqdesc[loop],
 				&fd_arr[loop], frames_to_send - loop);
 		if (likely(ret > 0)) {
-			for (i = loop; i < (loop + ret); i++) {
-				DPAA2_PER_LCORE_DQRR_SIZE -= dqrr_size[i];
-				DPAA2_PER_LCORE_DQRR_HELD &= ~dqrr_held[i];
-				dpaa2_q[i]->tx_pkts++;
+			if (atomic) {
+				dpaa2_eq_atomic_dpio_update(loop, ret, DPAA2_PER_LCORE_DPIO,
+					dqrr_size, dqrr_held);
 			}
+			for (i = loop; i < (loop + ret); i++)
+				dpaa2_q[i]->tx_pkts++;
 			loop += ret;
 			retry_count = 0;
 		} else {
 			retry_count++;
 			if (retry_count > DPAA2_MAX_TX_RETRY_COUNT) {
 				for (i = loop; i < frames_to_send; i++)
-					*dpaa2_seqn(bufs[i]) = flags[i];
+					dpaa2_mbuf_seq_restore(bufs[i], flags[i]);
 				break;
 			}
 		}
-- 
2.43.0

