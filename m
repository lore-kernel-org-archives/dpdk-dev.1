Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B309C79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:53:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94FE342D66;
	Thu, 10 Sep 2026 15:52:19 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 1763E42D80
 for <dev@dpdk.org>; Thu, 10 Sep 2026 15:52:15 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EF9251A044C;
 Thu, 10 Sep 2026 15:52:14 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B89591A0455;
 Thu, 10 Sep 2026 15:52:14 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B0E4D18000B1;
 Thu, 10 Sep 2026 21:52:13 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v2 10/47] dma/dpaa2: validate IOVA in pre-populate helpers
Date: Thu, 10 Sep 2026 19:21:21 +0530
Message-ID: <20260910135158.2181141-11-prashant.gupta_3@nxp.com>
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

From: Gagandeep Singh <g.singh@nxp.com>

fle_sdd_pre_populate() and fle_sdd_sg_pre_populate() converted the SDD
and SG entry virtual addresses to IOVA with DPAA2_VADDR_TO_IOVA(), which
does not verify that the range is actually mapped in the IOMMU/SMMU. An
unmapped buffer was silently programmed into the hardware descriptor,
leading to an SMMU translation fault at transfer time that is hard to
trace back to the missing mapping.

Use DPAA2_VADDR_TO_IOVA_AND_CHECK() for the SDD, source SG and
destination SG buffers and rte_panic() with the offending address and
size when the translation is missing, so the misconfiguration is caught
early and clearly.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/dma/dpaa2/dpaa2_qdma.c | 42 ++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/dpaa2/dpaa2_qdma.c b/drivers/dma/dpaa2/dpaa2_qdma.c
index 6fd3530f0d..8a180ab400 100644
--- a/drivers/dma/dpaa2/dpaa2_qdma.c
+++ b/drivers/dma/dpaa2/dpaa2_qdma.c
@@ -187,7 +187,15 @@ fle_sdd_pre_populate(struct qdma_cntx_fle_sdd *fle_sdd,
 {
 	struct qbman_fle *fle = fle_sdd->fle;
 	struct qdma_sdd *sdd = fle_sdd->sdd;
-	uint64_t sdd_iova = DPAA2_VADDR_TO_IOVA(sdd);
+	uint64_t sdd_iova, iova_size;
+
+	iova_size = sizeof(struct qdma_sdd) * DPAA2_QDMA_MAX_SDD;
+	sdd_iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(sdd, iova_size);
+	if (sdd_iova == RTE_BAD_IOVA) {
+		DPAA2_QDMA_ERR("No IOMMU map for sdd(%p)(size=%" PRIu64 ")",
+			sdd, iova_size);
+		return -ENOMEM;
+	}
 
 	/* first frame list to source descriptor */
 	DPAA2_SET_FLE_ADDR(&fle[DPAA2_QDMA_SDD_FLE], sdd_iova);
@@ -285,22 +293,36 @@ sg_entry_pre_populate(struct qdma_cntx_sg *sg_cntx)
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
+		DPAA2_QDMA_ERR("No IOMMU map for src_sge(%p)(size=%" PRIu64 ")",
+			src_sge, (uint64_t)iova_size);
+		return -ENOMEM;
+	}
+
+	dst_sge_iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(dst_sge, iova_size);
+	if (dst_sge_iova == RTE_BAD_IOVA) {
+		DPAA2_QDMA_ERR("No IOMMU map for dst_sge(%p)(size=%" PRIu64 ")",
+			dst_sge, (uint64_t)iova_size);
+		return -ENOMEM;
+	}
 
 	sg_entry_pre_populate(sg_cntx);
-	fle_sdd_pre_populate(&sg_cntx->fle_sdd,
+	return fle_sdd_pre_populate(&sg_cntx->fle_sdd,
 		rbp, src_sge_iova, dst_sge_iova,
 		QBMAN_FLE_WORD4_FMT_SGE);
 }
@@ -671,7 +693,13 @@ dpaa2_qdma_copy_sg(void *dev_private,
 
 	if (qdma_vq->fle_pre_populate) {
 		if (unlikely(!fle[DPAA2_QDMA_SRC_FLE].length)) {
-			fle_sdd_sg_pre_populate(cntx_sg, qdma_vq);
+			ret = fle_sdd_sg_pre_populate(cntx_sg, qdma_vq);
+			if (unlikely(ret)) {
+				if (!qdma_dev->is_silent)
+					rte_mempool_put(qdma_vq->fle_pool,
+						cntx_sg);
+				return ret;
+			}
 			if (!qdma_dev->is_silent && cntx_sg && idx_addr) {
 				for (i = 0; i < nb_src; i++)
 					cntx_sg->cntx_idx[i] = idx_addr[i];
-- 
2.43.0

