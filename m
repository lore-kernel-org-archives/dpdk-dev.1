Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73B5C79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:52:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E24E742D99;
	Thu, 10 Sep 2026 15:52:16 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 17B7742D55;
 Thu, 10 Sep 2026 15:52:13 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EC599200408;
 Thu, 10 Sep 2026 15:52:12 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B65EB200026;
 Thu, 10 Sep 2026 15:52:12 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8766318000B1;
 Thu, 10 Sep 2026 21:52:11 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: stable@dpdk.org,
	Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v2 08/47] dma/dpaa2: fix array-bounds warning in dequeue path
Date: Thu, 10 Sep 2026 19:21:19 +0530
Message-ID: <20260910135158.2181141-9-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
 <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
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
 drivers/dma/dpaa2/dpaa2_qdma.c | 24 ++++++++----------------
 drivers/dma/dpaa2/dpaa2_qdma.h |  1 +
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/dpaa2/dpaa2_qdma.c b/drivers/dma/dpaa2/dpaa2_qdma.c
index 004dacf677..6fd3530f0d 100644
--- a/drivers/dma/dpaa2/dpaa2_qdma.c
+++ b/drivers/dma/dpaa2/dpaa2_qdma.c
@@ -943,35 +943,27 @@ dpaa2_qdma_dq_fd(const struct qbman_fd *fd,
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
+		qdma_vq->idxs[0] = idx;
 		ret = qdma_cntx_idx_ring_eq(qdma_vq->ring_cntx_idx,
-				&idx, 1, free_space);
+			qdma_vq->idxs, 1, free_space);
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
diff --git a/drivers/dma/dpaa2/dpaa2_qdma.h b/drivers/dma/dpaa2/dpaa2_qdma.h
index e2d2eb4fa8..98c64f7b45 100644
--- a/drivers/dma/dpaa2/dpaa2_qdma.h
+++ b/drivers/dma/dpaa2/dpaa2_qdma.h
@@ -290,6 +290,7 @@ struct qdma_virt_queue {
 	struct qdma_cntx_idx_ring *ring_cntx_idx;
 
 	/**Used for silent enabled*/
+	uint16_t idxs[DPAA2_QDMA_MAX_DESC];
 	struct qdma_cntx_sg *cntx_sg[DPAA2_QDMA_MAX_DESC];
 	struct qdma_cntx_fle_sdd *cntx_fle_sdd[DPAA2_QDMA_MAX_DESC];
 	uint16_t silent_idx;
-- 
2.43.0

