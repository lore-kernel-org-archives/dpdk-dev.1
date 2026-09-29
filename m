Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ACEC9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:21:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 919CE42E52;
	Tue, 29 Sep 2026 16:21:28 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 84A83411F3;
 Tue, 29 Sep 2026 16:21:25 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 641792000F9;
 Tue, 29 Sep 2026 16:21:25 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2E6102000F5;
 Tue, 29 Sep 2026 16:21:25 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 976A6180006C;
 Tue, 29 Sep 2026 22:21:23 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: stable@dpdk.org,
	Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v5-S1 3/5] dma/dpaa2: fix array-bounds warning and SG FD
 double-put
Date: Tue, 29 Sep 2026 19:51:15 +0530
Message-ID: <20260929142117.3109066-4-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929142117.3109066-1-prashant.gupta_3@nxp.com>
References: <20260922092158.2340839-1-prashant.gupta_3@nxp.com>
 <20260929142117.3109066-1-prashant.gupta_3@nxp.com>
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

Two bugs fixed in the QDMA dequeue path:

1. Array-bounds warning: qdma_cntx_idx_ring_eq advanced the ring tail
   one element at a time in a loop, which triggered a GCC -Warray-bounds
   diagnostic because the compiler could not prove the tail stayed in
   bounds. Replace the loop with a two-part memcpy (head region plus
   wrap-around region when needed) and advance ring->tail by the full
   count in one step, eliminating the warning.

2. SG FD double-put: in dpaa2_qdma_dq_fd() the fle_sdd pointer was
   stored into fle_elem[] and the counter incremented before checking
   the qdma_cntx_idx_ring_eq return value. On -ENOSPC the function
   returned without putting fle_sdd back to fle_pool, causing a double-
   free when the pool was later destroyed. Fix by calling
   rte_mempool_put() before returning -ENOSPC, and moving the
   fle_elem[]/counter update to after ring_eq succeeds.
Fixes: 388e888dc082 ("dma/dpaa2: support short FD")
Cc: stable@dpdk.org
Cc: stable@dpdk.org
Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/dma/dpaa2/dpaa2_qdma.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dpaa2/dpaa2_qdma.c b/drivers/dma/dpaa2/dpaa2_qdma.c
index f7d94bb799..3b272f6593 100644
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
+	memcpy(&ring->cntx_idx_ring[ring->tail], elem,
+		first * sizeof(uint16_t));
+	if (nb > first)
+		memcpy(&ring->cntx_idx_ring[0], &elem[first],
+			(nb - first) * sizeof(uint16_t));
+
+	ring->tail = (ring->tail + nb) & (DPAA2_QDMA_MAX_DESC - 1);
 	ring->free_space -= nb;
 	ring->nb_in_ring += nb;
 
@@ -962,15 +965,17 @@ dpaa2_qdma_dq_fd(const struct qbman_fd *fd,
 	}
 	if (type == DPAA2_QDMA_FD_SG) {
 		fle_sdd = (void *)(uintptr_t)DPAA2_GET_FD_FLC(fd);
-		qdma_vq->fle_elem[*fle_elem_nb] = fle_sdd;
-		(*fle_elem_nb)++;
 		cntx_sg = container_of(fle_sdd,
 				struct qdma_cntx_sg, fle_sdd);
 		ret = qdma_cntx_idx_ring_eq(qdma_vq->ring_cntx_idx,
 				cntx_sg->cntx_idx,
 				cntx_sg->job_nb, free_space);
-		if (unlikely(ret < cntx_sg->job_nb))
+		if (unlikely(ret < cntx_sg->job_nb)) {
+			rte_mempool_put(qdma_vq->fle_pool, fle_sdd);
 			return -ENOSPC;
+		}
+		qdma_vq->fle_elem[*fle_elem_nb] = fle_sdd;
+		(*fle_elem_nb)++;
 
 		return 0;
 	}
