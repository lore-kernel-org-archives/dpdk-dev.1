Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DF2606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:50:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2137D40B99;
	Fri, 23 Oct 2026 15:45:12 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 1E50740EDB
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:55 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F12A61A0042;
 Fri, 23 Oct 2026 15:44:54 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 932181A000A;
 Fri, 23 Oct 2026 15:44:54 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8E0FA18000B7;
 Fri, 23 Oct 2026 21:44:53 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 58/65] crypto/dpaa2_sec: unify enqueue burst path for
 ordered enqueue
Date: Fri, 23 Oct 2026 19:13:38 +0530
Message-ID: <20261023134346.37727-59-prashant.gupta_3@nxp.com>
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

The ordered enqueue path used a dedicated burst function,
dpaa2_sec_enqueue_burst_ordered(), which was installed as
dev->enqueue_burst at device start when ordered queues were enabled.
This split the crypto enqueue datapath into two separate entry points
and required swapping the burst function at start time.

Make dpaa2_sec_enqueue_burst() the single enqueue entry point. It now
inspects the mbuf seqn flags (DPAA2_ENQUEUE_FLAG_ORP /
QBMAN_ENQUEUE_FLAG_DCA) and, when an op requires ordered or atomic (DCA)
enqueue, routes the remaining burst through
dpaa2_sec_enqueue_burst_ordered(). The start-time enqueue_burst swap is
removed.

Move dpaa2_sec_set_enqueue_descriptor() and
dpaa2_sec_enqueue_burst_ordered() above the fast enqueue path so the
single entry point can call them. The normal path no longer handles DCA
flags inline and passes NULL flags to qbman_swp_enqueue_multiple(), since
DCA and ORP handling now live on the ordered path.

This mirrors the equivalent unification done for the net/dpaa2 tx burst
path.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c | 362 ++++++++++----------
 1 file changed, 175 insertions(+), 187 deletions(-)

diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index 54881bc38c..9d2fa57989 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -1502,22 +1502,174 @@ build_sec_fd(struct rte_crypto_op *op,
 	return ret;
 }
 
+static void
+dpaa2_sec_set_enqueue_descriptor(struct dpaa2_queue *dpaa2_q,
+	struct rte_mbuf *m, struct qbman_eq_desc *eqdesc)
+{
+	struct dpaa2_dpio_dev *dpio_dev = DPAA2_PER_LCORE_DPIO;
+	struct eqresp_metadata *eqresp_meta;
+	struct dpaa2_sec_dev_private *priv = dpaa2_q->crypto_data->dev_private;
+	uint16_t orpid, seqnum;
+	uint8_t dq_idx;
+
+	if (*dpaa2_seqn(m) & DPAA2_ENQUEUE_FLAG_ORP) {
+		orpid = (*dpaa2_seqn(m) & DPAA2_EQCR_OPRID_MASK) >>
+			DPAA2_EQCR_OPRID_SHIFT;
+		seqnum = (*dpaa2_seqn(m) & DPAA2_EQCR_SEQNUM_MASK) >>
+			DPAA2_EQCR_SEQNUM_SHIFT;
+
+		if (!priv->en_loose_ordered) {
+			qbman_eq_desc_set_orp(eqdesc, 1, orpid, seqnum, 0);
+			qbman_eq_desc_set_response(eqdesc, (uint64_t)
+				DPAA2_VADDR_TO_IOVA(&dpio_dev->eqresp[
+				dpio_dev->eqresp_pi]), 1);
+			qbman_eq_desc_set_token(eqdesc, 1);
+
+			eqresp_meta = &dpio_dev->eqresp_meta[dpio_dev->eqresp_pi];
+			eqresp_meta->dpaa2_q = dpaa2_q;
+			eqresp_meta->mp = m->pool;
+
+			dpio_dev->eqresp_pi + 1 < MAX_EQ_RESP_ENTRIES ?
+				dpio_dev->eqresp_pi++ : (dpio_dev->eqresp_pi = 0);
+		} else {
+			qbman_eq_desc_set_orp(eqdesc, 0, orpid, seqnum, 0);
+		}
+	} else {
+		dq_idx = *dpaa2_seqn(m) & QBMAN_EQCR_DCA_IDXMASK;
+		qbman_eq_desc_set_dca(eqdesc, 1, dq_idx, 0);
+		DPAA2_PER_LCORE_DQRR_SIZE--;
+		DPAA2_PER_LCORE_DQRR_HELD &= ~(UINT64_C(1) << dq_idx);
+	}
+	*dpaa2_seqn(m) = DPAA2_INVALID_MBUF_SEQN;
+}
+
 static uint16_t
-dpaa2_sec_enqueue_burst(void *qp, struct rte_crypto_op **ops,
-			uint16_t nb_ops)
+dpaa2_sec_enqueue_burst_ordered(void *qp, struct rte_crypto_op **ops,
+	uint16_t nb_ops)
 {
 	/* Function to transmit the frames to given device and VQ*/
-	uint32_t loop;
 	int32_t ret;
 	struct qbman_fd fd_arr[MAX_TX_RING_SLOTS];
-	uint32_t frames_to_send, retry_count;
+	uint32_t frames_to_send, num_free_eq_desc, retry_count, loop;
+	struct qbman_eq_desc eqdesc[MAX_TX_RING_SLOTS];
+	struct dpaa2_sec_qp *dpaa2_qp = qp;
+	struct qbman_swp *swp;
+	uint16_t num_tx = 0, bpid;
+	uint8_t dqrr_index;
+	struct dpaa2_sec_dev_private *priv = dpaa2_qp->tx_vq.crypto_data->dev_private;
+
+	if (unlikely(!nb_ops))
+		return 0;
+
+	if (ops[0]->sess_type == RTE_CRYPTO_OP_SESSIONLESS) {
+		DPAA2_SEC_ERR("sessionless crypto op not supported");
+		return 0;
+	}
+
+	if (!DPAA2_PER_LCORE_DPIO) {
+		ret = dpaa2_affine_qbman_swp();
+		if (ret) {
+			DPAA2_SEC_ERR("Failure in affining portal");
+			return 0;
+		}
+	}
+	swp = DPAA2_PER_LCORE_PORTAL;
+
+	while (nb_ops) {
+		frames_to_send = (nb_ops > dpaa2_eqcr_size) ? dpaa2_eqcr_size : nb_ops;
+
+		if (!priv->en_loose_ordered) {
+			if (*dpaa2_seqn((*ops)->sym->m_src) & DPAA2_ENQUEUE_FLAG_ORP) {
+				num_free_eq_desc = dpaa2_free_eq_descriptors();
+				if (num_free_eq_desc < frames_to_send)
+					frames_to_send = num_free_eq_desc;
+			}
+		}
+
+		for (loop = 0; loop < frames_to_send; loop++) {
+			/*Prepare enqueue descriptor*/
+			qbman_eq_desc_clear(&eqdesc[loop]);
+			qbman_eq_desc_set_fq(&eqdesc[loop], dpaa2_qp->tx_vq.fqid);
+
+			if (*dpaa2_seqn((*ops)->sym->m_src) & DPAA2_ENQUEUE_FLAG_ORP) {
+				dpaa2_sec_set_enqueue_descriptor(&dpaa2_qp->tx_vq,
+					(*ops)->sym->m_src, &eqdesc[loop]);
+			} else {
+				if (*dpaa2_seqn((*ops)->sym->m_src) & QBMAN_ENQUEUE_FLAG_DCA) {
+					dqrr_index = *dpaa2_seqn((*ops)->sym->m_src) &
+						QBMAN_EQCR_DCA_IDXMASK;
+					DPAA2_PER_LCORE_DQRR_SIZE--;
+					DPAA2_PER_LCORE_DQRR_HELD &= ~(UINT64_C(1) << dqrr_index);
+					qbman_eq_desc_set_dca(&eqdesc[loop], 1, dqrr_index, 0);
+					*dpaa2_seqn((*ops)->sym->m_src) = DPAA2_INVALID_MBUF_SEQN;
+				}
+				qbman_eq_desc_set_no_orp(&eqdesc[loop], DPAA2_EQ_RESP_ERR_FQ);
+			}
+
+			/*Clear the unused FD fields before sending*/
+			memset(&fd_arr[loop], 0, sizeof(struct qbman_fd));
+			if ((*ops)->sym->m_src->pool->ops_index == rte_dpaa2_mpool_get_ops_idx())
+				bpid = mempool_to_bpid((*ops)->sym->m_src->pool);
+			else
+				bpid = MAX_BPID;
+			ret = build_sec_fd(*ops, &fd_arr[loop], bpid, dpaa2_qp);
+			if (ret) {
+				DPAA2_SEC_DP_DEBUG("FD build failed");
+				frames_to_send = loop + 1;
+				for (loop = 0; loop < frames_to_send; loop++)
+					free_fle(&fd_arr[loop], dpaa2_qp);
+				goto skip_tx;
+			}
+			ops++;
+		}
+
+		loop = 0;
+		retry_count = 0;
+		while (loop < frames_to_send) {
+			ret = qbman_swp_enqueue_multiple_desc(swp,
+					&eqdesc[loop], &fd_arr[loop],
+					frames_to_send - loop);
+			if (unlikely(ret < 0)) {
+				retry_count++;
+				if (retry_count > DPAA2_MAX_TX_RETRY_COUNT) {
+					num_tx += loop;
+					nb_ops -= loop;
+					DPAA2_SEC_DP_DEBUG("Enqueue fail");
+					/* freeing the fle buffers */
+					while (loop < frames_to_send) {
+						free_fle(&fd_arr[loop], dpaa2_qp);
+						loop++;
+					}
+					goto skip_tx;
+				}
+			} else {
+				loop += ret;
+				retry_count = 0;
+			}
+		}
+
+		num_tx += loop;
+		nb_ops -= loop;
+	}
+
+skip_tx:
+	dpaa2_qp->tx_vq.tx_pkts += num_tx;
+	dpaa2_qp->tx_vq.err_pkts += nb_ops;
+	return num_tx;
+}
+
+static uint16_t
+dpaa2_sec_enqueue_burst(void *qp, struct rte_crypto_op **ops,
+	uint16_t nb_ops)
+{
+	/* Function to transmit the frames to given device and VQ*/
+	int32_t ret, order = false;
+	struct qbman_fd fd_arr[MAX_TX_RING_SLOTS];
 	struct qbman_eq_desc eqdesc;
-	struct dpaa2_sec_qp *dpaa2_qp = (struct dpaa2_sec_qp *)qp;
+	struct dpaa2_sec_qp *dpaa2_qp = qp;
 	struct qbman_swp *swp;
-	uint16_t num_tx = 0;
-	uint32_t flags[MAX_TX_RING_SLOTS] = {0};
 	/*todo - need to support multiple buffer pools */
-	uint16_t bpid;
+	uint16_t num_tx = 0, bpid, loop, frames_to_send, retry_count;
 	struct rte_mempool *mb_pool;
 
 	if (unlikely(nb_ops == 0))
@@ -1536,32 +1688,26 @@ dpaa2_sec_enqueue_burst(void *qp, struct rte_crypto_op **ops,
 	if (!DPAA2_PER_LCORE_DPIO) {
 		ret = dpaa2_affine_qbman_swp();
 		if (ret) {
-			DPAA2_SEC_ERR(
-				"Failed to allocate IO portal, tid: %d",
-				rte_gettid());
+			DPAA2_SEC_ERR("Failed to allocate IO portal, tid: %d", rte_gettid());
 			return 0;
 		}
 	}
 	swp = DPAA2_PER_LCORE_PORTAL;
 
 	while (nb_ops) {
-		frames_to_send = (nb_ops > dpaa2_eqcr_size) ?
-			dpaa2_eqcr_size : nb_ops;
+		frames_to_send = (nb_ops > dpaa2_eqcr_size) ? dpaa2_eqcr_size : nb_ops;
 
 		for (loop = 0; loop < frames_to_send; loop++) {
-			if (*dpaa2_seqn((*ops)->sym->m_src) & QBMAN_ENQUEUE_FLAG_DCA) {
-				DPAA2_PER_LCORE_DQRR_SIZE--;
-				DPAA2_PER_LCORE_DQRR_HELD &= ~(UINT64_C(1) <<
-					*dpaa2_seqn((*ops)->sym->m_src) & QBMAN_EQCR_DCA_IDXMASK);
-				flags[loop] = *dpaa2_seqn((*ops)->sym->m_src);
-				*dpaa2_seqn((*ops)->sym->m_src) = DPAA2_INVALID_MBUF_SEQN;
+			if (*dpaa2_seqn((*ops)->sym->m_src) &
+				(QBMAN_ENQUEUE_FLAG_DCA | DPAA2_ENQUEUE_FLAG_ORP)) {
+				order = true;
+				break;
 			}
 
 			/*Clear the unused FD fields before sending*/
 			memset(&fd_arr[loop], 0, sizeof(struct qbman_fd));
 			mb_pool = (*ops)->sym->m_src->pool;
-			if (mb_pool->ops_index ==
-				rte_dpaa2_mpool_get_ops_idx())
+			if (mb_pool->ops_index == rte_dpaa2_mpool_get_ops_idx())
 				bpid = mempool_to_bpid(mb_pool);
 			else
 				bpid = MAX_BPID;
@@ -1573,13 +1719,12 @@ dpaa2_sec_enqueue_burst(void *qp, struct rte_crypto_op **ops,
 			ops++;
 		}
 
+		frames_to_send = loop;
 		loop = 0;
 		retry_count = 0;
 		while (loop < frames_to_send) {
 			ret = qbman_swp_enqueue_multiple(swp, &eqdesc,
-							 &fd_arr[loop],
-							 &flags[loop],
-							 frames_to_send - loop);
+				&fd_arr[loop], NULL, frames_to_send - loop);
 			if (unlikely(ret < 0)) {
 				retry_count++;
 				if (retry_count > DPAA2_MAX_TX_RETRY_COUNT) {
@@ -1588,8 +1733,7 @@ dpaa2_sec_enqueue_burst(void *qp, struct rte_crypto_op **ops,
 					DPAA2_SEC_DP_DEBUG("Enqueue fail");
 					/* freeing the fle buffers */
 					while (loop < frames_to_send) {
-						free_fle(&fd_arr[loop],
-								dpaa2_qp);
+						free_fle(&fd_arr[loop], dpaa2_qp);
 						loop++;
 					}
 					goto skip_tx;
@@ -1602,10 +1746,15 @@ dpaa2_sec_enqueue_burst(void *qp, struct rte_crypto_op **ops,
 
 		num_tx += loop;
 		nb_ops -= loop;
+		if (order)
+			break;
 	}
 skip_tx:
 	dpaa2_qp->tx_vq.tx_pkts += num_tx;
 	dpaa2_qp->tx_vq.err_pkts += nb_ops;
+	if (ret >= 0 && order)
+		num_tx += dpaa2_sec_enqueue_burst_ordered(qp, ops, nb_ops);
+
 	return num_tx;
 }
 
@@ -1810,163 +1959,6 @@ dpaa2_sec_free_eqresp_buf(uint16_t eqresp_ci,
 	rte_pktmbuf_free(op->sym->m_src);
 }
 
-static void
-dpaa2_sec_set_enqueue_descriptor(struct dpaa2_queue *dpaa2_q,
-			     struct rte_mbuf *m,
-			     struct qbman_eq_desc *eqdesc)
-{
-	struct dpaa2_dpio_dev *dpio_dev = DPAA2_PER_LCORE_DPIO;
-	struct eqresp_metadata *eqresp_meta;
-	struct dpaa2_sec_dev_private *priv = dpaa2_q->crypto_data->dev_private;
-	uint16_t orpid, seqnum;
-	uint8_t dq_idx;
-
-	if (*dpaa2_seqn(m) & DPAA2_ENQUEUE_FLAG_ORP) {
-		orpid = (*dpaa2_seqn(m) & DPAA2_EQCR_OPRID_MASK) >>
-			DPAA2_EQCR_OPRID_SHIFT;
-		seqnum = (*dpaa2_seqn(m) & DPAA2_EQCR_SEQNUM_MASK) >>
-			DPAA2_EQCR_SEQNUM_SHIFT;
-
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
-
-static uint16_t
-dpaa2_sec_enqueue_burst_ordered(void *qp, struct rte_crypto_op **ops,
-			uint16_t nb_ops)
-{
-	/* Function to transmit the frames to given device and VQ*/
-	uint32_t loop;
-	int32_t ret;
-	struct qbman_fd fd_arr[MAX_TX_RING_SLOTS];
-	uint32_t frames_to_send, num_free_eq_desc, retry_count;
-	struct qbman_eq_desc eqdesc[MAX_TX_RING_SLOTS];
-	struct dpaa2_sec_qp *dpaa2_qp = (struct dpaa2_sec_qp *)qp;
-	struct qbman_swp *swp;
-	uint16_t num_tx = 0;
-	uint16_t bpid;
-	struct rte_mempool *mb_pool;
-	struct dpaa2_sec_dev_private *priv =
-				dpaa2_qp->tx_vq.crypto_data->dev_private;
-
-	if (unlikely(nb_ops == 0))
-		return 0;
-
-	if (ops[0]->sess_type == RTE_CRYPTO_OP_SESSIONLESS) {
-		DPAA2_SEC_ERR("sessionless crypto op not supported");
-		return 0;
-	}
-
-	if (!DPAA2_PER_LCORE_DPIO) {
-		ret = dpaa2_affine_qbman_swp();
-		if (ret) {
-			DPAA2_SEC_ERR("Failure in affining portal");
-			return 0;
-		}
-	}
-	swp = DPAA2_PER_LCORE_PORTAL;
-
-	while (nb_ops) {
-		frames_to_send = (nb_ops > dpaa2_eqcr_size) ?
-			dpaa2_eqcr_size : nb_ops;
-
-		if (!priv->en_loose_ordered) {
-			if (*dpaa2_seqn((*ops)->sym->m_src) & DPAA2_ENQUEUE_FLAG_ORP) {
-				num_free_eq_desc = dpaa2_free_eq_descriptors();
-				if (num_free_eq_desc < frames_to_send)
-					frames_to_send = num_free_eq_desc;
-			}
-		}
-
-		for (loop = 0; loop < frames_to_send; loop++) {
-			/*Prepare enqueue descriptor*/
-			qbman_eq_desc_clear(&eqdesc[loop]);
-			qbman_eq_desc_set_fq(&eqdesc[loop], dpaa2_qp->tx_vq.fqid);
-
-			if (*dpaa2_seqn((*ops)->sym->m_src) & DPAA2_ENQUEUE_FLAG_ORP)
-				dpaa2_sec_set_enqueue_descriptor(
-						&dpaa2_qp->tx_vq,
-						(*ops)->sym->m_src,
-						&eqdesc[loop]);
-			else
-				qbman_eq_desc_set_no_orp(&eqdesc[loop],
-							 DPAA2_EQ_RESP_ERR_FQ);
-
-			/*Clear the unused FD fields before sending*/
-			memset(&fd_arr[loop], 0, sizeof(struct qbman_fd));
-			mb_pool = (*ops)->sym->m_src->pool;
-			if (mb_pool->ops_index ==
-				rte_dpaa2_mpool_get_ops_idx())
-				bpid = mempool_to_bpid(mb_pool);
-			else
-				bpid = MAX_BPID;
-			ret = build_sec_fd(*ops, &fd_arr[loop], bpid, dpaa2_qp);
-			if (ret) {
-				DPAA2_SEC_DP_DEBUG("FD build failed");
-				goto skip_tx;
-			}
-			ops++;
-		}
-
-		loop = 0;
-		retry_count = 0;
-		while (loop < frames_to_send) {
-			ret = qbman_swp_enqueue_multiple_desc(swp,
-					&eqdesc[loop], &fd_arr[loop],
-					frames_to_send - loop);
-			if (unlikely(ret < 0)) {
-				retry_count++;
-				if (retry_count > DPAA2_MAX_TX_RETRY_COUNT) {
-					num_tx += loop;
-					nb_ops -= loop;
-					DPAA2_SEC_DP_DEBUG("Enqueue fail");
-					/* freeing the fle buffers */
-					while (loop < frames_to_send) {
-						free_fle(&fd_arr[loop],
-								dpaa2_qp);
-						loop++;
-					}
-					goto skip_tx;
-				}
-			} else {
-				loop += ret;
-				retry_count = 0;
-			}
-		}
-
-		num_tx += loop;
-		nb_ops -= loop;
-	}
-
-skip_tx:
-	dpaa2_qp->tx_vq.tx_pkts += num_tx;
-	dpaa2_qp->tx_vq.err_pkts += nb_ops;
-	return num_tx;
-}
-
 static uint16_t
 dpaa2_sec_dequeue_burst(void *qp, struct rte_crypto_op **ops,
 	uint16_t nb_ops)
@@ -3929,10 +3921,6 @@ dpaa2_sec_dev_start(struct rte_cryptodev *dev)
 
 	PMD_INIT_FUNC_TRACE();
 
-	/* Change the tx burst function if ordered queues are used */
-	if (priv->en_ordered)
-		dev->enqueue_burst = dpaa2_sec_enqueue_burst_ordered;
-
 	memset(&attr, 0, sizeof(struct dpseci_attr));
 
 	ret = dpseci_enable(dpseci, CMD_PRI_LOW, priv->token);
-- 
2.43.0

