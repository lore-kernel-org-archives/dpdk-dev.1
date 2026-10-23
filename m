Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CDE606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:49:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BC4F427BA;
	Fri, 23 Oct 2026 15:45:04 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 2F1F040B91
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:53 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0BD151A0041;
 Fri, 23 Oct 2026 15:44:53 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C9FD51A0038;
 Fri, 23 Oct 2026 15:44:52 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 726D018000B5;
 Fri, 23 Oct 2026 21:44:51 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 56/65] bus/fslmc: use explicit flags for mbuf seqn
 encoding
Date: Fri, 23 Oct 2026 19:13:36 +0530
Message-ID: <20261023134346.37727-57-prashant.gupta_3@nxp.com>
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

The DPAA2 drivers stash the DQRR index in the mbuf dynamic seqn field to
support atomic (DCA) and ordered (ORP) enqueue. The index was stored as
"dqrr_index + 1" and the field was tested for a non-zero value to decide
whether it was valid, with the index recovered as "seqn - 1".

This offset-by-one scheme overloads a single field and cannot
distinguish the DCA case from the ORP case; it only works because any
valid index becomes non-zero. It is fragile and makes the DCA and ORP
paths ambiguous.

Encode the seqn using the explicit qbman flag bits instead:
  - store the index as "dqrr_index | QBMAN_ENQUEUE_FLAG_DCA"
  - recover the index with "& QBMAN_EQCR_DCA_IDXMASK"
  - gate the DCA path on "& QBMAN_ENQUEUE_FLAG_DCA"
  - gate the ORP path on "& DPAA2_ENQUEUE_FLAG_ORP"

Apply this consistently across net/dpaa2, crypto/dpaa2_sec and
event/dpaa2 so the atomic and ordered enqueue paths are selected
unambiguously.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c | 17 +++++++----------
 drivers/event/dpaa2/dpaa2_eventdev.c        |  6 +++---
 drivers/net/dpaa2/dpaa2_rxtx.c              |  8 ++++----
 3 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index e34ca884fe..54881bc38c 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -1549,13 +1549,10 @@ dpaa2_sec_enqueue_burst(void *qp, struct rte_crypto_op **ops,
 			dpaa2_eqcr_size : nb_ops;
 
 		for (loop = 0; loop < frames_to_send; loop++) {
-			if (*dpaa2_seqn((*ops)->sym->m_src)) {
-				if (*dpaa2_seqn((*ops)->sym->m_src) & QBMAN_ENQUEUE_FLAG_DCA) {
-					DPAA2_PER_LCORE_DQRR_SIZE--;
-					DPAA2_PER_LCORE_DQRR_HELD &= ~(UINT64_C(1) <<
-						*dpaa2_seqn((*ops)->sym->m_src) &
-					QBMAN_EQCR_DCA_IDXMASK);
-				}
+			if (*dpaa2_seqn((*ops)->sym->m_src) & QBMAN_ENQUEUE_FLAG_DCA) {
+				DPAA2_PER_LCORE_DQRR_SIZE--;
+				DPAA2_PER_LCORE_DQRR_HELD &= ~(UINT64_C(1) <<
+					*dpaa2_seqn((*ops)->sym->m_src) & QBMAN_EQCR_DCA_IDXMASK);
 				flags[loop] = *dpaa2_seqn((*ops)->sym->m_src);
 				*dpaa2_seqn((*ops)->sym->m_src) = DPAA2_INVALID_MBUF_SEQN;
 			}
@@ -1848,7 +1845,7 @@ dpaa2_sec_set_enqueue_descriptor(struct dpaa2_queue *dpaa2_q,
 			qbman_eq_desc_set_orp(eqdesc, 0, orpid, seqnum, 0);
 		}
 	} else {
-		dq_idx = *dpaa2_seqn(m) - 1;
+		dq_idx = *dpaa2_seqn(m) & QBMAN_EQCR_DCA_IDXMASK;
 		qbman_eq_desc_set_dca(eqdesc, 1, dq_idx, 0);
 		DPAA2_PER_LCORE_DQRR_SIZE--;
 		DPAA2_PER_LCORE_DQRR_HELD &= ~(UINT64_C(1) << dq_idx);
@@ -1897,7 +1894,7 @@ dpaa2_sec_enqueue_burst_ordered(void *qp, struct rte_crypto_op **ops,
 			dpaa2_eqcr_size : nb_ops;
 
 		if (!priv->en_loose_ordered) {
-			if (*dpaa2_seqn((*ops)->sym->m_src)) {
+			if (*dpaa2_seqn((*ops)->sym->m_src) & DPAA2_ENQUEUE_FLAG_ORP) {
 				num_free_eq_desc = dpaa2_free_eq_descriptors();
 				if (num_free_eq_desc < frames_to_send)
 					frames_to_send = num_free_eq_desc;
@@ -1909,7 +1906,7 @@ dpaa2_sec_enqueue_burst_ordered(void *qp, struct rte_crypto_op **ops,
 			qbman_eq_desc_clear(&eqdesc[loop]);
 			qbman_eq_desc_set_fq(&eqdesc[loop], dpaa2_qp->tx_vq.fqid);
 
-			if (*dpaa2_seqn((*ops)->sym->m_src))
+			if (*dpaa2_seqn((*ops)->sym->m_src) & DPAA2_ENQUEUE_FLAG_ORP)
 				dpaa2_sec_set_enqueue_descriptor(
 						&dpaa2_qp->tx_vq,
 						(*ops)->sym->m_src,
diff --git a/drivers/event/dpaa2/dpaa2_eventdev.c b/drivers/event/dpaa2/dpaa2_eventdev.c
index 127397e681..2efdbb8b59 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev.c
@@ -185,8 +185,8 @@ dpaa2_eventdev_enqueue_burst(void *port, const struct rte_event ev[],
 			dqrr_size[loop] = 0;
 
 			if (event->sched_type == RTE_SCHED_TYPE_ATOMIC &&
-				*dpaa2_seqn(event->mbuf)) {
-				dqrr_index = *dpaa2_seqn(event->mbuf) - 1;
+				(*dpaa2_seqn(event->mbuf) & QBMAN_ENQUEUE_FLAG_DCA)) {
+				dqrr_index = *dpaa2_seqn(event->mbuf) & QBMAN_EQCR_DCA_IDXMASK;
 				qbman_eq_desc_set_dca(&eqdesc[loop], 1, dqrr_index, 0);
 				dqrr_size[loop] = 1;
 				dqrr_held[loop] = UINT64_C(1) << dqrr_index;
@@ -273,7 +273,7 @@ static void dpaa2_eventdev_process_atomic(struct dpaa2_dpio_dev *dpio_dev,
 
 	rte_memcpy(ev, rx_ev, sizeof(struct rte_event));
 	rte_mempool_put(rxq->env_pool, rx_ev);
-	*dpaa2_seqn(ev->mbuf) = dqrr_index + 1;
+	*dpaa2_seqn(ev->mbuf) = dqrr_index | QBMAN_ENQUEUE_FLAG_DCA;
 	dpio_dev->dpaa2_held_bufs.dqrr_size++;
 	dpio_dev->dpaa2_held_bufs.dqrr_held |= UINT64_C(1) << dqrr_index;
 	dpio_dev->dpaa2_held_bufs.mbuf[dqrr_index] = ev->mbuf;
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 4f712ec9f7..dfd359d0e2 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -1234,7 +1234,7 @@ dpaa2_dev_process_atomic_event(struct dpaa2_dpio_dev *dpio_dev,
 		ev->mbuf = dpaa2_eth_fd_to_mbuf(rxq->eth_data->dev_private, fd);
 
 	dqrr_index = qbman_get_dqrr_idx(dq);
-	*dpaa2_seqn(ev->mbuf) = dqrr_index + 1;
+	*dpaa2_seqn(ev->mbuf) = dqrr_index | QBMAN_ENQUEUE_FLAG_DCA;
 	dpio_dev->dpaa2_held_bufs.dqrr_size++;
 	dpio_dev->dpaa2_held_bufs.dqrr_held |= UINT64_C(1) << dqrr_index;
 	dpio_dev->dpaa2_held_bufs.mbuf[dqrr_index] = ev->mbuf;
@@ -1570,8 +1570,8 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		dpaa2_eqcr_size : nb_pkts;
 
 	for (loop = 0; loop < frames_to_send; loop++) {
-		if (*dpaa2_seqn(*bufs)) {
-			uint8_t dqrr_index = *dpaa2_seqn(*bufs) - 1;
+		if (*dpaa2_seqn(*bufs) & QBMAN_ENQUEUE_FLAG_DCA) {
+			uint8_t dqrr_index = *dpaa2_seqn(*bufs) & QBMAN_EQCR_DCA_IDXMASK;
 
 			flags[loop] = QBMAN_ENQUEUE_FLAG_DCA | dqrr_index;
 			DPAA2_PER_LCORE_DQRR_SIZE--;
@@ -1743,7 +1743,7 @@ dpaa2_set_enqueue_descriptor(struct dpaa2_queue *dpaa2_q,
 			qbman_eq_desc_set_orp(eqdesc, 0, orpid, seqnum, 0);
 		}
 	} else {
-		dq_idx = *dpaa2_seqn(m) - 1;
+		dq_idx = *dpaa2_seqn(m) & QBMAN_EQCR_DCA_IDXMASK;
 		qbman_eq_desc_set_dca(eqdesc, 1, dq_idx, 0);
 		DPAA2_PER_LCORE_DQRR_SIZE--;
 		DPAA2_PER_LCORE_DQRR_HELD &= ~(UINT64_C(1) << dq_idx);
-- 
2.43.0

