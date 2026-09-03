Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66861C61DD3
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 13:55:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D99442DB0;
	Thu,  3 Sep 2026 15:54:18 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id C00C342D89
 for <dev@dpdk.org>; Thu,  3 Sep 2026 15:54:13 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A09FF1A0054;
 Thu,  3 Sep 2026 15:54:13 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 697ED1A0025;
 Thu,  3 Sep 2026 15:54:13 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E0CAD18000B7;
 Thu,  3 Sep 2026 21:54:11 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH 13/45] drivers: add dpaa2 DMA bypass memory translation option
Date: Thu,  3 Sep 2026 19:23:21 +0530
Message-ID: <20260903135353.3358303-14-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
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

Add RTE_DPAAX_QDMA_BMT_FLAG flag to allow callers to bypass
memory translation (BMT) for DMA operations. This is needed for
some PCIe scenarios where IOMMU translation should be skipped.

The flag is propagated to all SG entry and FD populate helpers
via a new 'bmt' parameter, defaulting to DISABLE when the flag
is not set.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/common/dpaax/rte_pmd_dpaax_qdma.h |  4 +-
 drivers/dma/dpaa2/dpaa2_qdma.c            | 59 ++++++++++-------------
 2 files changed, 29 insertions(+), 34 deletions(-)

diff --git a/drivers/common/dpaax/rte_pmd_dpaax_qdma.h b/drivers/common/dpaax/rte_pmd_dpaax_qdma.h
index 8f2fc83f8d..6bd72b0b0e 100644
--- a/drivers/common/dpaax/rte_pmd_dpaax_qdma.h
+++ b/drivers/common/dpaax/rte_pmd_dpaax_qdma.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2021-2024 NXP
+ * Copyright 2021-2024, 2026 NXP
  */
 
 #ifndef RTE_PMD_DPAAX_QDMA_H
@@ -7,6 +7,8 @@
 
 #include <rte_compat.h>
 
+#define RTE_DPAAX_QDMA_BMT_FLAG RTE_BIT64(7)
+
 #define RTE_DPAAX_QDMA_COPY_IDX_OFFSET 8
 #define RTE_DPAAX_QDMA_SG_IDX_ADDR_ALIGN \
 	RTE_BIT64(RTE_DPAAX_QDMA_COPY_IDX_OFFSET)
diff --git a/drivers/dma/dpaa2/dpaa2_qdma.c b/drivers/dma/dpaa2/dpaa2_qdma.c
index 1e9ec463aa..e73b7dbb1e 100644
--- a/drivers/dma/dpaa2/dpaa2_qdma.c
+++ b/drivers/dma/dpaa2/dpaa2_qdma.c
@@ -278,7 +278,7 @@ fle_sdd_pre_populate(struct qdma_cntx_fle_sdd *fle_sdd,
 }
 
 static void
-sg_entry_pre_populate(struct qdma_cntx_sg *sg_cntx)
+sg_entry_pre_populate(struct qdma_cntx_sg *sg_cntx, int bmt)
 {
 	uint16_t i;
 	struct qdma_sg_entry *src_sge = sg_cntx->sg_src_entry;
@@ -288,23 +288,17 @@ sg_entry_pre_populate(struct qdma_cntx_sg *sg_cntx)
 		/* source SG */
 		src_sge[i].ctrl.sl = QDMA_SG_SL_LONG;
 		src_sge[i].ctrl.fmt = QDMA_SG_FMT_SDB;
-		/** IOMMU is always on for either VA or PA mode,
-		 * so Bypass Memory Translation should be disabled.
-		 */
-		src_sge[i].ctrl.bmt = QDMA_SG_BMT_DISABLE;
+		src_sge[i].ctrl.bmt = bmt;
 		/* destination SG */
 		dst_sge[i].ctrl.sl = QDMA_SG_SL_LONG;
 		dst_sge[i].ctrl.fmt = QDMA_SG_FMT_SDB;
-		/** IOMMU is always on for either VA or PA mode,
-		 * so Bypass Memory Translation should be disabled.
-		 */
-		dst_sge[i].ctrl.bmt = QDMA_SG_BMT_DISABLE;
+		dst_sge[i].ctrl.bmt = bmt;
 	}
 }
 
 static int
 fle_sdd_sg_pre_populate(struct qdma_cntx_sg *sg_cntx,
-	struct qdma_virt_queue *qdma_vq)
+	struct qdma_virt_queue *qdma_vq, int bmt)
 {
 	struct qdma_sg_entry *src_sge = sg_cntx->sg_src_entry;
 	struct qdma_sg_entry *dst_sge = sg_cntx->sg_dst_entry;
@@ -332,7 +326,7 @@ fle_sdd_sg_pre_populate(struct qdma_cntx_sg *sg_cntx,
 		return -ENOMEM;
 	}
 
-	sg_entry_pre_populate(sg_cntx);
+	sg_entry_pre_populate(sg_cntx, bmt);
 
 	return fle_sdd_pre_populate(&sg_cntx->fle_sdd,
 		rbp, src_sge_iova, dst_sge_iova,
@@ -398,7 +392,7 @@ sg_fle_post_populate(struct qbman_fle fle[],
 static inline uint32_t
 sg_entry_populate(const struct rte_dma_sge *src,
 	const struct rte_dma_sge *dst, struct qdma_cntx_sg *sg_cntx,
-	uint16_t nb_sge)
+	uint16_t nb_sge, int bmt)
 {
 	uint16_t i;
 	uint32_t total_len = 0;
@@ -414,19 +408,13 @@ sg_entry_populate(const struct rte_dma_sge *src,
 		src_sge->data_len.data_len_sl0 = src[i].length;
 		src_sge->ctrl.sl = QDMA_SG_SL_LONG;
 		src_sge->ctrl.fmt = QDMA_SG_FMT_SDB;
-		/** IOMMU is always on for either VA or PA mode,
-		 * so Bypass Memory Translation should be disabled.
-		 */
-		src_sge->ctrl.bmt = QDMA_SG_BMT_DISABLE;
+		src_sge->ctrl.bmt = bmt;
 		dst_sge->addr_lo = (uint32_t)dst[i].addr;
 		dst_sge->addr_hi = (dst[i].addr >> 32);
 		dst_sge->data_len.data_len_sl0 = dst[i].length;
 		dst_sge->ctrl.sl = QDMA_SG_SL_LONG;
 		dst_sge->ctrl.fmt = QDMA_SG_FMT_SDB;
-		/** IOMMU is always on for either VA or PA mode,
-		 * so Bypass Memory Translation should be disabled.
-		 */
-		dst_sge->ctrl.bmt = QDMA_SG_BMT_DISABLE;
+		dst_sge->ctrl.bmt = bmt;
 		total_len += src[i].length;
 
 		if (i == (nb_sge - 1)) {
@@ -705,7 +693,9 @@ dpaa2_qdma_copy_sg(void *dev_private,
 
 	if (qdma_vq->fle_pre_populate) {
 		if (unlikely(!fle[DPAA2_QDMA_SRC_FLE].length)) {
-			ret = fle_sdd_sg_pre_populate(cntx_sg, qdma_vq);
+			ret = fle_sdd_sg_pre_populate(cntx_sg, qdma_vq,
+				(flags & RTE_DPAAX_QDMA_BMT_FLAG) ?
+				QDMA_SG_BMT_ENABLE : QDMA_SG_BMT_DISABLE);
 			if (ret)
 				return ret;
 			if (!qdma_dev->is_silent && cntx_sg && idx_addr) {
@@ -726,7 +716,9 @@ dpaa2_qdma_copy_sg(void *dev_private,
 			offsetof(struct qdma_cntx_sg, sg_src_entry);
 		dst_sge_iova = cntx_iova +
 			offsetof(struct qdma_cntx_sg, sg_dst_entry);
-		len = sg_entry_populate(src, dst, cntx_sg, nb_src);
+		len = sg_entry_populate(src, dst, cntx_sg, nb_src,
+			(flags & RTE_DPAAX_QDMA_BMT_FLAG) ?
+			QDMA_SG_BMT_ENABLE : QDMA_SG_BMT_DISABLE);
 
 		fle_populate(fle, sdd, sdd_iova,
 			&qdma_vq->rbp, src_sge_iova, dst_sge_iova, len,
@@ -759,14 +751,14 @@ dpaa2_qdma_copy_sg(void *dev_private,
 static inline void
 qdma_populate_fd_pci(uint64_t src, uint64_t dest,
 	uint32_t len, struct qbman_fd *fd,
-	struct dpaa2_qdma_rbp *rbp, int ser)
+	struct dpaa2_qdma_rbp *rbp, int ser, int bmt)
 {
 	fd->simple_pci.saddr_lo = lower_32_bits(src);
 	fd->simple_pci.saddr_hi = upper_32_bits(src);
 
 	fd->simple_pci.len_sl = len;
 
-	fd->simple_pci.bmt = DPAA2_QDMA_BMT_DISABLE;
+	fd->simple_pci.bmt = bmt;
 	fd->simple_pci.fmt = DPAA2_QDMA_FD_SHORT_FORMAT;
 	fd->simple_pci.sl = 1;
 	fd->simple_pci.ser = ser;
@@ -802,14 +794,14 @@ qdma_populate_fd_pci(uint64_t src, uint64_t dest,
 
 static inline void
 qdma_populate_fd_ddr(uint64_t src, uint64_t dest,
-	uint32_t len, struct qbman_fd *fd, int ser)
+	uint32_t len, struct qbman_fd *fd, int ser, int bmt)
 {
 	fd->simple_ddr.saddr_lo = lower_32_bits(src);
 	fd->simple_ddr.saddr_hi = upper_32_bits(src);
 
 	fd->simple_ddr.len = len;
 
-	fd->simple_ddr.bmt = DPAA2_QDMA_BMT_DISABLE;
+	fd->simple_ddr.bmt = bmt;
 	fd->simple_ddr.fmt = DPAA2_QDMA_FD_SHORT_FORMAT;
 	fd->simple_ddr.sl = 1;
 	fd->simple_ddr.ser = ser;
@@ -847,15 +839,16 @@ dpaa2_qdma_short_copy(struct qdma_virt_queue *qdma_vq,
 
 	if (qdma_vq->rbp.drbp || qdma_vq->rbp.srbp) {
 		/** PCIe EP*/
-		qdma_populate_fd_pci(src,
-			dst, length,
-			fd, &qdma_vq->rbp,
-			is_silent ? 0 : 1);
+		qdma_populate_fd_pci(src, dst, length,
+			fd, &qdma_vq->rbp, is_silent ? 0 : 1,
+			(flags & RTE_DPAAX_QDMA_BMT_FLAG) ?
+			DPAA2_QDMA_BMT_ENABLE : DPAA2_QDMA_BMT_DISABLE);
 	} else {
 		/** DDR or PCIe RC*/
-		qdma_populate_fd_ddr(src,
-			dst, length,
-			fd, is_silent ? 0 : 1);
+		qdma_populate_fd_ddr(src, dst, length,
+			fd, is_silent ? 0 : 1,
+			(flags & RTE_DPAAX_QDMA_BMT_FLAG) ?
+			DPAA2_QDMA_BMT_ENABLE : DPAA2_QDMA_BMT_DISABLE);
 	}
 	dpaa2_qdma_fd_save_att(fd, DPAA2_QDMA_IDX_FROM_FLAG(flags),
 		DPAA2_QDMA_FD_SHORT);
-- 
2.43.0

