Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B953BC88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:02:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5260442794;
	Tue, 15 Sep 2026 14:02:16 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 7C32B42789
 for <dev@dpdk.org>; Tue, 15 Sep 2026 14:02:12 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5AAB6200059;
 Tue, 15 Sep 2026 14:02:12 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 21593200053;
 Tue, 15 Sep 2026 14:02:12 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 89D01180006C;
 Tue, 15 Sep 2026 20:02:10 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v3-S3 01/10] drivers: add dpaa2 DMA bypass memory translation
 option
Date: Tue, 15 Sep 2026 17:31:59 +0530
Message-ID: <20260915120208.4185877-2-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
References: <20260915113459.4166621-1-prashant.gupta_3@nxp.com>
 <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
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
 drivers/dma/dpaa2/dpaa2_qdma.c            | 87 ++++++++++++-----------
 2 files changed, 50 insertions(+), 41 deletions(-)

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
index 401ab56f39..10fc50b8fe 100644
--- a/drivers/dma/dpaa2/dpaa2_qdma.c
+++ b/drivers/dma/dpaa2/dpaa2_qdma.c
@@ -273,7 +273,7 @@ fle_sdd_pre_populate(struct qdma_cntx_fle_sdd *fle_sdd,
 }
 
 static void
-sg_entry_pre_populate(struct qdma_cntx_sg *sg_cntx)
+sg_entry_pre_populate(struct qdma_cntx_sg *sg_cntx, int bmt)
 {
 	uint16_t i;
 	struct qdma_sg_entry *src_sge = sg_cntx->sg_src_entry;
@@ -283,23 +283,17 @@ sg_entry_pre_populate(struct qdma_cntx_sg *sg_cntx)
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
@@ -327,7 +321,7 @@ fle_sdd_sg_pre_populate(struct qdma_cntx_sg *sg_cntx,
 		return -ENOMEM;
 	}
 
-	sg_entry_pre_populate(sg_cntx);
+	sg_entry_pre_populate(sg_cntx, bmt);
 
 	return fle_sdd_pre_populate(&sg_cntx->fle_sdd,
 		rbp, src_sge_iova, dst_sge_iova,
@@ -337,7 +331,7 @@ fle_sdd_sg_pre_populate(struct qdma_cntx_sg *sg_cntx,
 static inline uint32_t
 sg_entry_post_populate(const struct rte_dma_sge *src,
 	const struct rte_dma_sge *dst, struct qdma_cntx_sg *sg_cntx,
-	uint16_t nb_sge)
+	uint16_t nb_sge, int bmt)
 {
 	uint16_t i;
 	uint32_t total_len = 0;
@@ -350,10 +344,12 @@ sg_entry_post_populate(const struct rte_dma_sge *src,
 		src_sge->addr_lo = (uint32_t)src[i].addr;
 		src_sge->addr_hi = (src[i].addr >> 32);
 		src_sge->data_len.data_len_sl0 = src[i].length;
+		src_sge->ctrl.bmt = bmt;
 
 		dst_sge->addr_lo = (uint32_t)dst[i].addr;
 		dst_sge->addr_hi = (dst[i].addr >> 32);
 		dst_sge->data_len.data_len_sl0 = dst[i].length;
+		dst_sge->ctrl.bmt = bmt;
 		total_len += dst[i].length;
 
 		src_sge->ctrl.f = 0;
@@ -368,10 +364,12 @@ sg_entry_post_populate(const struct rte_dma_sge *src,
 	src_sge->addr_lo = (uint32_t)src[i].addr;
 	src_sge->addr_hi = (src[i].addr >> 32);
 	src_sge->data_len.data_len_sl0 = src[i].length;
+	src_sge->ctrl.bmt = bmt;
 
 	dst_sge->addr_lo = (uint32_t)dst[i].addr;
 	dst_sge->addr_hi = (dst[i].addr >> 32);
 	dst_sge->data_len.data_len_sl0 = dst[i].length;
+	dst_sge->ctrl.bmt = bmt;
 
 	total_len += dst[i].length;
 	sg_cntx->job_nb = nb_sge;
@@ -393,7 +391,7 @@ sg_fle_post_populate(struct qbman_fle fle[],
 static inline uint32_t
 sg_entry_populate(const struct rte_dma_sge *src,
 	const struct rte_dma_sge *dst, struct qdma_cntx_sg *sg_cntx,
-	uint16_t nb_sge)
+	uint16_t nb_sge, int bmt)
 {
 	uint16_t i;
 	uint32_t total_len = 0;
@@ -409,19 +407,13 @@ sg_entry_populate(const struct rte_dma_sge *src,
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
@@ -445,7 +437,7 @@ fle_populate(struct qbman_fle fle[],
 	struct qdma_sdd sdd[], uint64_t sdd_iova,
 	struct dpaa2_qdma_rbp *rbp,
 	uint64_t src_iova, uint64_t dst_iova, size_t len,
-	uint32_t fmt)
+	uint32_t fmt, int bmt)
 {
 	/* first frame list to source descriptor */
 	DPAA2_SET_FLE_ADDR(&fle[DPAA2_QDMA_SDD_FLE], sdd_iova);
@@ -507,11 +499,13 @@ fle_populate(struct qbman_fle fle[],
 	 * DPAA2_SET_FLE_BMT(&fle[DPAA2_QDMA_DST_FLE]);
 	 */
 	fle[DPAA2_QDMA_SRC_FLE].word4.fmt = fmt;
+	fle[DPAA2_QDMA_SRC_FLE].word4.bmt = bmt;
 	DPAA2_SET_FLE_LEN(&fle[DPAA2_QDMA_SRC_FLE], len);
 
 	/* destination frame list to destination buffer */
 	DPAA2_SET_FLE_ADDR(&fle[DPAA2_QDMA_DST_FLE], dst_iova);
 	fle[DPAA2_QDMA_DST_FLE].word4.fmt = fmt;
+	fle[DPAA2_QDMA_DST_FLE].word4.bmt = bmt;
 	DPAA2_SET_FLE_LEN(&fle[DPAA2_QDMA_DST_FLE], len);
 
 	/* Final bit: 1, for last frame list */
@@ -520,12 +514,14 @@ fle_populate(struct qbman_fle fle[],
 
 static inline void
 fle_post_populate(struct qbman_fle fle[],
-	uint64_t src, uint64_t dest, size_t len)
+	uint64_t src, uint64_t dest, size_t len, int bmt)
 {
 	DPAA2_SET_FLE_ADDR(&fle[DPAA2_QDMA_SRC_FLE], src);
+	fle[DPAA2_QDMA_SRC_FLE].word4.bmt = bmt;
 	DPAA2_SET_FLE_LEN(&fle[DPAA2_QDMA_SRC_FLE], len);
 
 	DPAA2_SET_FLE_ADDR(&fle[DPAA2_QDMA_DST_FLE], dest);
+	fle[DPAA2_QDMA_DST_FLE].word4.bmt = bmt;
 	DPAA2_SET_FLE_LEN(&fle[DPAA2_QDMA_DST_FLE], len);
 }
 
@@ -700,7 +696,9 @@ dpaa2_qdma_copy_sg(void *dev_private,
 
 	if (qdma_vq->fle_pre_populate) {
 		if (unlikely(!fle[DPAA2_QDMA_SRC_FLE].length)) {
-			ret = fle_sdd_sg_pre_populate(cntx_sg, qdma_vq);
+			ret = fle_sdd_sg_pre_populate(cntx_sg, qdma_vq,
+				(flags & RTE_DPAAX_QDMA_BMT_FLAG) ?
+				QDMA_SG_BMT_ENABLE : QDMA_SG_BMT_DISABLE);
 			if (ret) {
 				if (!qdma_dev->is_silent)
 					rte_mempool_put(qdma_vq->fle_pool,
@@ -714,7 +712,9 @@ dpaa2_qdma_copy_sg(void *dev_private,
 		}
 
 		len = sg_entry_post_populate(src, dst,
-			cntx_sg, nb_src);
+			cntx_sg, nb_src,
+			(flags & RTE_DPAAX_QDMA_BMT_FLAG) ?
+			QDMA_SG_BMT_ENABLE : QDMA_SG_BMT_DISABLE);
 		sg_fle_post_populate(fle, len);
 	} else {
 		sdd = cntx_sg->fle_sdd.sdd;
@@ -725,11 +725,13 @@ dpaa2_qdma_copy_sg(void *dev_private,
 			offsetof(struct qdma_cntx_sg, sg_src_entry);
 		dst_sge_iova = cntx_iova +
 			offsetof(struct qdma_cntx_sg, sg_dst_entry);
-		len = sg_entry_populate(src, dst, cntx_sg, nb_src);
+		len = sg_entry_populate(src, dst, cntx_sg, nb_src,
+			(flags & RTE_DPAAX_QDMA_BMT_FLAG) ?
+			QDMA_SG_BMT_ENABLE : QDMA_SG_BMT_DISABLE);
 
 		fle_populate(fle, sdd, sdd_iova,
 			&qdma_vq->rbp, src_sge_iova, dst_sge_iova, len,
-			QBMAN_FLE_WORD4_FMT_SGE);
+			QBMAN_FLE_WORD4_FMT_SGE, DPAA2_QDMA_BMT_DISABLE);
 	}
 
 	if (unlikely(qdma_vq->flags & DPAA2_QDMA_DESC_DEBUG_FLAG))
@@ -758,14 +760,14 @@ dpaa2_qdma_copy_sg(void *dev_private,
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
@@ -801,14 +803,14 @@ qdma_populate_fd_pci(uint64_t src, uint64_t dest,
 
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
@@ -846,15 +848,16 @@ dpaa2_qdma_short_copy(struct qdma_virt_queue *qdma_vq,
 
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
@@ -919,13 +922,17 @@ dpaa2_qdma_long_copy(struct qdma_virt_queue *qdma_vq,
 			}
 		}
 
-		fle_post_populate(fle, src, dst, length);
+		fle_post_populate(fle, src, dst, length,
+			(flags & RTE_DPAAX_QDMA_BMT_FLAG) ?
+			DPAA2_QDMA_BMT_ENABLE : DPAA2_QDMA_BMT_DISABLE);
 	} else {
 		sdd = fle_sdd->sdd;
 		sdd_iova = (uint64_t)sdd - qdma_vq->fle_iova2va_offset;
 		fle_populate(fle, sdd, sdd_iova, &qdma_vq->rbp,
 			src, dst, length,
-			QBMAN_FLE_WORD4_FMT_SBF);
+			QBMAN_FLE_WORD4_FMT_SBF,
+			(flags & RTE_DPAAX_QDMA_BMT_FLAG) ?
+			DPAA2_QDMA_BMT_ENABLE : DPAA2_QDMA_BMT_DISABLE);
 	}
 
 	if (unlikely(qdma_vq->flags & DPAA2_QDMA_DESC_DEBUG_FLAG))
-- 
2.43.0

