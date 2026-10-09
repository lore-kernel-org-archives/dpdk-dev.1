Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9424ECA6019
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 10:50:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAD4140695;
	Fri,  9 Oct 2026 12:50:26 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 862E540608
 for <dev@dpdk.org>; Fri,  9 Oct 2026 12:50:25 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6B12F20030C;
 Fri,  9 Oct 2026 12:50:25 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 36D4620000B;
 Fri,  9 Oct 2026 12:50:25 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D82741800068;
 Fri,  9 Oct 2026 18:50:23 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v7-S1 4/6] dma/dpaa2: release SG FLE on completion ring
 overflow
Date: Fri,  9 Oct 2026 16:20:17 +0530
Message-ID: <20261009105019.1121083-5-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009105019.1121083-1-prashant.gupta_3@nxp.com>
References: <20261006150749.3591526-1-prashant.gupta_3@nxp.com>
 <20261009105019.1121083-1-prashant.gupta_3@nxp.com>
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

In the DPAA2_QDMA_FD_SG branch of dpaa2_qdma_dq_fd(), the FLE was
recorded in qdma_vq->fle_elem[] before qdma_cntx_idx_ring_eq() was
called. On overflow the function returned -ENOSPC with the entry
already accounted for, leaving the release to the bulk
rte_mempool_put_bulk() that dpaa2_qdma_dequeue() performs after the
loop.

This is not a leak and not a double put, the object is returned exactly
once either way. However the ownership is easier to follow if the error
path releases the FLE itself, so return it with rte_mempool_put() and
only record it in fle_elem[] once the indices are in the ring.

No functional change.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
---
 drivers/dma/dpaa2/dpaa2_qdma.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dpaa2/dpaa2_qdma.c b/drivers/dma/dpaa2/dpaa2_qdma.c
index 7d3f3d2003..e8ec9cddfc 100644
--- a/drivers/dma/dpaa2/dpaa2_qdma.c
+++ b/drivers/dma/dpaa2/dpaa2_qdma.c
@@ -954,26 +954,30 @@ dpaa2_qdma_dq_fd(const struct qbman_fd *fd,
 	if (type == DPAA2_QDMA_FD_LONG) {
 		idx = DPAA2_QDMA_FD_ATT_CNTX(att);
 		fle_sdd = (void *)(uintptr_t)DPAA2_GET_FD_FLC(fd);
-		qdma_vq->fle_elem[*fle_elem_nb] = fle_sdd;
-		(*fle_elem_nb)++;
 		ret = qdma_cntx_idx_ring_eq(qdma_vq->ring_cntx_idx,
 				&idx, 1, free_space);
-		if (unlikely(ret != 1))
+		if (unlikely(ret != 1)) {
+			rte_mempool_put(qdma_vq->fle_pool, fle_sdd);
 			return -ENOSPC;
+		}
+		qdma_vq->fle_elem[*fle_elem_nb] = fle_sdd;
+		(*fle_elem_nb)++;
 
 		return 0;
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
-- 
2.43.0

