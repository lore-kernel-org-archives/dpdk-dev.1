Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5792AC88E7B
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 11:34:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 433D642799;
	Tue, 15 Sep 2026 13:34:34 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 905884278C
 for <dev@dpdk.org>; Tue, 15 Sep 2026 13:34:31 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7450B1A0038;
 Tue, 15 Sep 2026 13:34:31 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3A7851A002A;
 Tue, 15 Sep 2026 13:34:31 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D1BA51800068;
 Tue, 15 Sep 2026 19:34:29 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v3-S1 4/5] dma/dpaa2: validate IOVA in pre-populate helpers
Date: Tue, 15 Sep 2026 17:04:21 +0530
Message-ID: <20260915113422.4166287-5-prashant.gupta_3@nxp.com>
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

From: Gagandeep Singh <g.singh@nxp.com>

fle_sdd_pre_populate() and fle_sdd_sg_pre_populate() converted the SDD
and SG entry virtual addresses to IOVA with DPAA2_VADDR_TO_IOVA(), which
does not verify that the range is actually mapped in the IOMMU/SMMU. An
unmapped buffer was silently programmed into the hardware descriptor,
leading to an SMMU translation fault at transfer time that is hard to
trace back to the missing mapping.

Use DPAA2_VADDR_TO_IOVA_AND_CHECK() for the SDD, source SG and
destination SG buffers and report the offending address and size when
the translation is missing, so the misconfiguration is caught early and
clearly. Both helpers now return an error code which is propagated to
the caller instead of continuing with an invalid descriptor.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/dma/dpaa2/dpaa2_qdma.c | 58 ++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dpaa2/dpaa2_qdma.c b/drivers/dma/dpaa2/dpaa2_qdma.c
index 6881ab1420..401ab56f39 100644
--- a/drivers/dma/dpaa2/dpaa2_qdma.c
+++ b/drivers/dma/dpaa2/dpaa2_qdma.c
@@ -183,14 +183,23 @@ dpaa2_qdma_multi_eq(struct qdma_virt_queue *qdma_vq)
 	return num_tx;
 }
 
-static void
+static int
 fle_sdd_pre_populate(struct qdma_cntx_fle_sdd *fle_sdd,
 	struct dpaa2_qdma_rbp *rbp, uint64_t src, uint64_t dest,
 	uint32_t fmt)
 {
 	struct qbman_fle *fle = fle_sdd->fle;
 	struct qdma_sdd *sdd = fle_sdd->sdd;
-	uint64_t sdd_iova = DPAA2_VADDR_TO_IOVA(sdd);
+	uint64_t sdd_iova, iova_size;
+
+	iova_size = sizeof(struct qdma_sdd) * DPAA2_QDMA_MAX_SDD;
+	sdd_iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(sdd, iova_size);
+	if (sdd_iova == RTE_BAD_IOVA) {
+		DPAA2_QDMA_ERR("No IOMMU map for sdd(%p)(size=%" PRIx64 ")",
+			sdd, iova_size);
+
+		return -ENOMEM;
+	}
 
 	/* first frame list to source descriptor */
 	DPAA2_SET_FLE_ADDR(&fle[DPAA2_QDMA_SDD_FLE], sdd_iova);
@@ -259,6 +268,8 @@ fle_sdd_pre_populate(struct qdma_cntx_fle_sdd *fle_sdd,
 
 	/* Final bit: 1, for last frame list */
 	DPAA2_SET_FLE_FIN(&fle[DPAA2_QDMA_DST_FLE]);
+
+	return 0;
 }
 
 static void
@@ -286,22 +297,39 @@ sg_entry_pre_populate(struct qdma_cntx_sg *sg_cntx)
 	}
 }
 
-static void
+static int
 fle_sdd_sg_pre_populate(struct qdma_cntx_sg *sg_cntx,
 	struct qdma_virt_queue *qdma_vq)
 {
 	struct qdma_sg_entry *src_sge = sg_cntx->sg_src_entry;
 	struct qdma_sg_entry *dst_sge = sg_cntx->sg_dst_entry;
-	rte_iova_t src_sge_iova, dst_sge_iova;
+	rte_iova_t src_sge_iova, dst_sge_iova, iova_size;
 	struct dpaa2_qdma_rbp *rbp = &qdma_vq->rbp;
 
 	memset(sg_cntx, 0, sizeof(struct qdma_cntx_sg));
 
-	src_sge_iova = DPAA2_VADDR_TO_IOVA(src_sge);
-	dst_sge_iova = DPAA2_VADDR_TO_IOVA(dst_sge);
+	iova_size = RTE_DPAAX_QDMA_JOB_SUBMIT_MAX *
+		sizeof(struct qdma_sg_entry);
+
+	src_sge_iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(src_sge, iova_size);
+	if (src_sge_iova == RTE_BAD_IOVA) {
+		DPAA2_QDMA_ERR("No IOMMU map for src_sge(%p)(size=%" PRIx64 ")",
+			src_sge, iova_size);
+
+		return -ENOMEM;
+	}
+
+	dst_sge_iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(dst_sge, iova_size);
+	if (dst_sge_iova == RTE_BAD_IOVA) {
+		DPAA2_QDMA_ERR("No IOMMU map for dst_sge(%p)(size=%" PRIx64 ")",
+			dst_sge, iova_size);
+
+		return -ENOMEM;
+	}
 
 	sg_entry_pre_populate(sg_cntx);
-	fle_sdd_pre_populate(&sg_cntx->fle_sdd,
+
+	return fle_sdd_pre_populate(&sg_cntx->fle_sdd,
 		rbp, src_sge_iova, dst_sge_iova,
 		QBMAN_FLE_WORD4_FMT_SGE);
 }
@@ -672,7 +700,13 @@ dpaa2_qdma_copy_sg(void *dev_private,
 
 	if (qdma_vq->fle_pre_populate) {
 		if (unlikely(!fle[DPAA2_QDMA_SRC_FLE].length)) {
-			fle_sdd_sg_pre_populate(cntx_sg, qdma_vq);
+			ret = fle_sdd_sg_pre_populate(cntx_sg, qdma_vq);
+			if (ret) {
+				if (!qdma_dev->is_silent)
+					rte_mempool_put(qdma_vq->fle_pool,
+						cntx_sg);
+				return ret;
+			}
 			if (!qdma_dev->is_silent && cntx_sg && idx_addr) {
 				for (i = 0; i < nb_src; i++)
 					cntx_sg->cntx_idx[i] = idx_addr[i];
@@ -874,9 +908,15 @@ dpaa2_qdma_long_copy(struct qdma_virt_queue *qdma_vq,
 
 	if (qdma_vq->fle_pre_populate) {
 		if (unlikely(!fle[DPAA2_QDMA_SRC_FLE].length)) {
-			fle_sdd_pre_populate(fle_sdd,
+			ret = fle_sdd_pre_populate(fle_sdd,
 				&qdma_vq->rbp,
 				0, 0, QBMAN_FLE_WORD4_FMT_SBF);
+			if (ret) {
+				if (!is_silent)
+					rte_mempool_put(qdma_vq->fle_pool,
+						fle_sdd);
+				return ret;
+			}
 		}
 
 		fle_post_populate(fle, src, dst, length);
-- 
2.43.0

