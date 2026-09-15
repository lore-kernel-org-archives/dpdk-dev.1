Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C5FC982C4
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 11:34:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AFD24275B;
	Tue, 15 Sep 2026 13:34:33 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 8046842707;
 Tue, 15 Sep 2026 13:34:30 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6027C1A0049;
 Tue, 15 Sep 2026 13:34:30 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2997A1A0044;
 Tue, 15 Sep 2026 13:34:30 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9BE2C18000BA;
 Tue, 15 Sep 2026 19:34:28 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: stable@dpdk.org,
	Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v3-S1 3/5] dma/dpaa2: fix array-bounds warning in dequeue path
Date: Tue, 15 Sep 2026 17:04:20 +0530
Message-ID: <20260915113422.4166287-4-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915113422.4166287-1-prashant.gupta_3@nxp.com>
References: <20260915113422.4166287-1-prashant.gupta_3@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

From: Jun Yang <jun.yang@nxp.com>

In dpaa2_qdma_dq_fd, passing a local uint16_t variable directly as a
pointer to qdma_cntx_idx_ring_eq caused a compiler array-bounds warning
because the function takes a pointer to an element of the ring array.

Add a per-queue scratch buffer idxs[DPAA2_QDMA_MAX_DESC] to
struct qdma_virt_queue and use idxs[0] instead of a local variable
pointer. Also consolidate the fle_sdd pointer assignment for LONG and
SG FD types to avoid code duplication.

Fixes: 388e888dc082 ("dma/dpaa2: support short FD")
Cc: stable@dpdk.org
Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/dma/dpaa2/dpaa2_qdma.c | 38 ++++++++++++++--------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/dma/dpaa2/dpaa2_qdma.c b/drivers/dma/dpaa2/dpaa2_qdma.c
index f7d94bb799..6881ab1420 100644
--- a/drivers/dma/dpaa2/dpaa2_qdma.c
+++ b/drivers/dma/dpaa2/dpaa2_qdma.c
@@ -66,16 +66,19 @@ qdma_cntx_idx_ring_eq(struct qdma_cntx_idx_ring *ring,
 	const uint16_t *elem, uint16_t nb,
 	uint16_t *free_space)
 {
-	uint16_t i;
+	uint16_t first;
 
 	if (unlikely(nb > ring->free_space))
 		return 0;
 
-	for (i = 0; i < nb; i++) {
-		ring->cntx_idx_ring[ring->tail] = elem[i];
-		ring->tail = (ring->tail + 1) &
-			(DPAA2_QDMA_MAX_DESC - 1);
-	}
+	first = RTE_MIN(nb, (uint16_t)(DPAA2_QDMA_MAX_DESC - ring->tail));
+	rte_memcpy(&ring->cntx_idx_ring[ring->tail], elem,
+		first * sizeof(uint16_t));
+	if (nb > first)
+		rte_memcpy(&ring->cntx_idx_ring[0], &elem[first],
+			(nb - first) * sizeof(uint16_t));
+
+	ring->tail = (ring->tail + nb) & (DPAA2_QDMA_MAX_DESC - 1);
 	ring->free_space -= nb;
 	ring->nb_in_ring += nb;
 
@@ -935,35 +938,26 @@ dpaa2_qdma_dq_fd(const struct qbman_fd *fd,
 	enum dpaa2_qdma_fd_type type;
 	int ret;
 	struct qdma_cntx_sg *cntx_sg;
-	struct qdma_cntx_fle_sdd *fle_sdd;
+	struct qdma_cntx_fle_sdd *fle_sdd = NULL;
 
 	att = dpaa2_qdma_fd_get_att(fd);
 	type = DPAA2_QDMA_FD_ATT_TYPE(att);
-	if (type == DPAA2_QDMA_FD_SHORT) {
-		idx = DPAA2_QDMA_FD_ATT_CNTX(att);
-		ret = qdma_cntx_idx_ring_eq(qdma_vq->ring_cntx_idx,
-				&idx, 1, free_space);
-		if (unlikely(ret != 1))
-			return -ENOSPC;
-
-		return 0;
-	}
-	if (type == DPAA2_QDMA_FD_LONG) {
-		idx = DPAA2_QDMA_FD_ATT_CNTX(att);
+	if (type == DPAA2_QDMA_FD_LONG || type == DPAA2_QDMA_FD_SG) {
 		fle_sdd = (void *)(uintptr_t)DPAA2_GET_FD_FLC(fd);
 		qdma_vq->fle_elem[*fle_elem_nb] = fle_sdd;
 		(*fle_elem_nb)++;
+	}
+	if (type == DPAA2_QDMA_FD_SHORT ||
+		type == DPAA2_QDMA_FD_LONG) {
+		idx = DPAA2_QDMA_FD_ATT_CNTX(att);
 		ret = qdma_cntx_idx_ring_eq(qdma_vq->ring_cntx_idx,
-				&idx, 1, free_space);
+			&idx, 1, free_space);
 		if (unlikely(ret != 1))
 			return -ENOSPC;
 
 		return 0;
 	}
 	if (type == DPAA2_QDMA_FD_SG) {
-		fle_sdd = (void *)(uintptr_t)DPAA2_GET_FD_FLC(fd);
-		qdma_vq->fle_elem[*fle_elem_nb] = fle_sdd;
-		(*fle_elem_nb)++;
 		cntx_sg = container_of(fle_sdd,
 				struct qdma_cntx_sg, fle_sdd);
 		ret = qdma_cntx_idx_ring_eq(qdma_vq->ring_cntx_idx,
-- 
2.43.0

