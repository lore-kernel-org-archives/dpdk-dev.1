Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0403B606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 05:20:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8A1A40B8F;
	Fri, 30 Oct 2026 06:20:28 +0100 (CET)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 7A9E340A6C
 for <dev@dpdk.org>; Fri, 30 Oct 2026 06:20:26 +0100 (CET)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 42D3C1A00C0;
 Fri, 30 Oct 2026 06:20:26 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 07FA11A00BF;
 Fri, 30 Oct 2026 06:20:26 +0100 (CET)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A3C561800224;
 Fri, 30 Oct 2026 13:20:24 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v5-S3 04/14] dma/dpaa2: use table-driven devargs parsing
Date: Fri, 30 Oct 2026 10:50:06 +0530
Message-ID: <20261030052016.3301766-5-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030052016.3301766-1-prashant.gupta_3@nxp.com>
References: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
 <20261030052016.3301766-1-prashant.gupta_3@nxp.com>
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

Convert the dpaa2 qdma devargs handling to the shared dpaax_devargs
table so each argument key is declared once and drives both the parse
table and the registered valid-args string.

Remove the custom check_devargs_handler()/dpaa2_qdma_get_devargs()
helpers and parse the arguments once at device init via
dpaax_get_devargs(), storing the results in a single dpdmai_dev->flags
bitfield (DPAA2_QDMA_FLE_PRE_POPULATE_FLAG, DPAA2_QDMA_DESC_DEBUG_FLAG,
DPAA2_QDMA_SHORT_FD_FLAG).

This drops the per-virtual-queue fle_pre_populate, using_short_fd and
flags fields, which only mirrored device-wide devargs, and makes the
copy paths read the device flags directly.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/dma/dpaa2/dpaa2_qdma.c | 94 ++++++++++------------------------
 drivers/dma/dpaa2/dpaa2_qdma.h | 15 +++---
 2 files changed, 35 insertions(+), 74 deletions(-)

diff --git a/drivers/dma/dpaa2/dpaa2_qdma.c b/drivers/dma/dpaa2/dpaa2_qdma.c
index 8d10edfd04..69cf780a1f 100644
--- a/drivers/dma/dpaa2/dpaa2_qdma.c
+++ b/drivers/dma/dpaa2/dpaa2_qdma.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018-2024 NXP
+ * Copyright 2018-2026 NXP
  */
 
 #include <rte_eal.h>
@@ -11,56 +11,25 @@
 #include <mc/fsl_dpdmai.h>
 
 #include <rte_pmd_dpaax_qdma.h>
+#include <dpaax_devarg.h>
 #include "dpaa2_hw_dpio.h"
 #include "dpaa2_qdma.h"
 #include "dpaa2_qdma_logs.h"
 
-#define DPAA2_QDMA_FLE_PRE_POPULATE "fle_pre_populate"
-#define DPAA2_QDMA_DESC_DEBUG "desc_debug"
-#define DPAA2_QDMA_USING_SHORT_FD "short_fd"
+#define DPAA2_DEVARGS(ENTRY) \
+	ENTRY("fle_pre_populate", NULL, DPAA2_QDMA_FLE_PRE_POPULATE_FLAG) \
+	ENTRY("desc_debug", NULL, DPAA2_QDMA_DESC_DEBUG_FLAG) \
+	ENTRY("short_fd", NULL, DPAA2_QDMA_SHORT_FD_FLAG)
+
+static const struct dpaax_devargs s_dpaa2_qdma_devargs[] = {
+	DPAA2_DEVARGS(DPAAX_DEVARG_TABLE_ENTRY)
+};
 
 static uint32_t dpaa2_coherent_no_alloc_cache;
 static uint32_t dpaa2_coherent_alloc_cache;
 
 static struct fsl_mc_io s_proc_mc_reg;
 
-static int
-check_devargs_handler(__rte_unused const char *key, const char *value,
-		      __rte_unused void *opaque)
-{
-	if (strcmp(value, "1"))
-		return -1;
-
-	return 0;
-}
-
-static int
-dpaa2_qdma_get_devargs(struct rte_devargs *devargs, const char *key)
-{
-	struct rte_kvargs *kvlist;
-
-	if (!devargs)
-		return 0;
-
-	kvlist = rte_kvargs_parse(devargs->args, NULL);
-	if (!kvlist)
-		return 0;
-
-	if (!rte_kvargs_count(kvlist, key)) {
-		rte_kvargs_free(kvlist);
-		return 0;
-	}
-
-	if (rte_kvargs_process(kvlist, key,
-			       check_devargs_handler, NULL) < 0) {
-		rte_kvargs_free(kvlist);
-		return 0;
-	}
-	rte_kvargs_free(kvlist);
-
-	return 1;
-}
-
 static inline int
 qdma_cntx_idx_ring_eq(struct qdma_cntx_idx_ring *ring,
 	const uint16_t *elem, uint16_t nb,
@@ -670,7 +639,7 @@ dpaa2_qdma_copy_sg(void *dev_private,
 	DPAA2_SET_FD_COMPOUND_FMT(fd);
 	DPAA2_SET_FD_FLC(fd, (uint64_t)cntx_sg);
 
-	if (qdma_vq->fle_pre_populate) {
+	if (dpdmai_dev->flags & DPAA2_QDMA_FLE_PRE_POPULATE_FLAG) {
 		if (unlikely(!fle[DPAA2_QDMA_SRC_FLE].length)) {
 			fle_sdd_sg_pre_populate(cntx_sg, qdma_vq);
 			if (!qdma_dev->is_silent && cntx_sg && idx_addr) {
@@ -698,7 +667,7 @@ dpaa2_qdma_copy_sg(void *dev_private,
 			QBMAN_FLE_WORD4_FMT_SGE);
 	}
 
-	if (unlikely(qdma_vq->flags & DPAA2_QDMA_DESC_DEBUG_FLAG))
+	if (unlikely(dpdmai_dev->flags & DPAA2_QDMA_DESC_DEBUG_FLAG))
 		dpaa2_qdma_long_fmt_dump(cntx_sg->fle_sdd.fle);
 
 	dpaa2_qdma_fd_save_att(fd, 0, DPAA2_QDMA_FD_SG);
@@ -844,7 +813,7 @@ dpaa2_qdma_short_copy(struct qdma_virt_queue *qdma_vq,
 static int
 dpaa2_qdma_long_copy(struct qdma_virt_queue *qdma_vq,
 	rte_iova_t src, rte_iova_t dst, uint32_t length,
-	int is_silent, uint64_t flags)
+	int is_silent, uint64_t flags, uint32_t dev_flags)
 {
 	int ret = 0, expected;
 	struct qbman_fd *fd = &qdma_vq->fd[qdma_vq->fd_idx];
@@ -872,7 +841,7 @@ dpaa2_qdma_long_copy(struct qdma_virt_queue *qdma_vq,
 	DPAA2_SET_FD_COMPOUND_FMT(fd);
 	DPAA2_SET_FD_FLC(fd, (uint64_t)fle);
 
-	if (qdma_vq->fle_pre_populate) {
+	if (dev_flags & DPAA2_QDMA_FLE_PRE_POPULATE_FLAG) {
 		if (unlikely(!fle[DPAA2_QDMA_SRC_FLE].length)) {
 			fle_sdd_pre_populate(fle_sdd,
 				&qdma_vq->rbp,
@@ -888,7 +857,7 @@ dpaa2_qdma_long_copy(struct qdma_virt_queue *qdma_vq,
 			QBMAN_FLE_WORD4_FMT_SBF);
 	}
 
-	if (unlikely(qdma_vq->flags & DPAA2_QDMA_DESC_DEBUG_FLAG))
+	if (unlikely(dev_flags & DPAA2_QDMA_DESC_DEBUG_FLAG))
 		dpaa2_qdma_long_fmt_dump(fle);
 
 	dpaa2_qdma_fd_save_att(fd, DPAA2_QDMA_IDX_FROM_FLAG(flags),
@@ -921,12 +890,14 @@ dpaa2_qdma_copy(void *dev_private, uint16_t vchan,
 	struct qdma_device *qdma_dev = dpdmai_dev->qdma_dev;
 	struct qdma_virt_queue *qdma_vq = &qdma_dev->vqs[vchan];
 
-	if (qdma_vq->using_short_fd)
+	if (dpdmai_dev->flags & DPAA2_QDMA_SHORT_FD_FLAG) {
 		return dpaa2_qdma_short_copy(qdma_vq, src, dst,
 				length, qdma_dev->is_silent, flags);
-	else
+	} else {
 		return dpaa2_qdma_long_copy(qdma_vq, src, dst,
-				length, qdma_dev->is_silent, flags);
+				length, qdma_dev->is_silent, flags,
+				dpdmai_dev->flags);
+	}
 }
 
 static inline int
@@ -1379,21 +1350,6 @@ dpaa2_qdma_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
 	if (ret)
 		return ret;
 
-	if (dpaa2_qdma_get_devargs(dev->device->devargs, DPAA2_QDMA_FLE_PRE_POPULATE))
-		qdma_dev->vqs[vchan].fle_pre_populate = 1;
-	else
-		qdma_dev->vqs[vchan].fle_pre_populate = 0;
-
-	if (dpaa2_qdma_get_devargs(dev->device->devargs, DPAA2_QDMA_DESC_DEBUG))
-		qdma_dev->vqs[vchan].flags |= DPAA2_QDMA_DESC_DEBUG_FLAG;
-	else
-		qdma_dev->vqs[vchan].flags &= (~DPAA2_QDMA_DESC_DEBUG_FLAG);
-
-	if (dpaa2_qdma_get_devargs(dev->device->devargs, DPAA2_QDMA_USING_SHORT_FD))
-		qdma_dev->vqs[vchan].using_short_fd = 1;
-	else
-		qdma_dev->vqs[vchan].using_short_fd = 0;
-
 	snprintf(pool_name, sizeof(pool_name),
 		"qdma_fle_pool_dev%d_qid%d", dpdmai_dev->dpdmai_id, vchan);
 	pool_size = sizeof(struct qdma_cntx_sg);
@@ -1656,6 +1612,11 @@ dpaa2_dpdmai_dev_init(struct rte_dma_dev *dev, uint32_t dpdmai_id)
 
 	DPAA2_QDMA_FUNC_TRACE();
 
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		dpdmai_dev->flags = 0;
+		dpaax_get_devargs(s_dpaa2_qdma_devargs, dev, &dpdmai_dev->flags);
+	}
+
 	if (!dpaa2_coherent_no_alloc_cache) {
 		if (dpaa2_svr_family == SVR_LX2160A) {
 			dpaa2_coherent_no_alloc_cache =
@@ -1801,7 +1762,6 @@ static struct rte_dpaa2_driver rte_dpaa2_qdma_pmd = {
 
 RTE_PMD_REGISTER_DPAA2(dpaa2_qdma, rte_dpaa2_qdma_pmd);
 RTE_PMD_REGISTER_PARAM_STRING(dpaa2_qdma,
-	DPAA2_QDMA_FLE_PRE_POPULATE "=<int>"
-	DPAA2_QDMA_DESC_DEBUG"=<int>"
-	DPAA2_QDMA_USING_SHORT_FD"=<int>");
+	DPAA2_DEVARGS(DPAAX_DEVARG_STRING_ENTRY)
+);
 RTE_LOG_REGISTER_DEFAULT(dpaa2_qdma_logtype, INFO);
diff --git a/drivers/dma/dpaa2/dpaa2_qdma.h b/drivers/dma/dpaa2/dpaa2_qdma.h
index e2d2eb4fa8..4a5d1056f0 100644
--- a/drivers/dma/dpaa2/dpaa2_qdma.h
+++ b/drivers/dma/dpaa2/dpaa2_qdma.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018-2024 NXP
+ * Copyright 2018-2026 NXP
  */
 
 #ifndef _DPAA2_QDMA_H_
@@ -233,6 +233,12 @@ struct __rte_packed_begin qdma_cntx_sg {
 #define DPAA2_QDMA_IDX_FROM_FLAG(flag) \
 	((flag) >> RTE_DPAAX_QDMA_COPY_IDX_OFFSET)
 
+enum dpaa2_dpdmai_dev_flags {
+	DPAA2_QDMA_FLE_PRE_POPULATE_FLAG = RTE_BIT32(0),
+	DPAA2_QDMA_DESC_DEBUG_FLAG = RTE_BIT32(1),
+	DPAA2_QDMA_SHORT_FD_FLAG = RTE_BIT32(2)
+};
+
 /** Represents a DPDMAI device */
 struct dpaa2_dpdmai_dev {
 	/** Pointer to Next device instance */
@@ -247,6 +253,7 @@ struct dpaa2_dpdmai_dev {
 	struct dpaa2_queue rx_queue[DPAA2_DPDMAI_MAX_QUEUES];
 	/** TX queues */
 	struct dpaa2_queue tx_queue[DPAA2_DPDMAI_MAX_QUEUES];
+	uint32_t flags;
 	struct qdma_device *qdma_dev;
 };
 
@@ -261,8 +268,6 @@ struct qdma_cntx_idx_ring {
 	uint16_t nb_in_ring;
 };
 
-#define DPAA2_QDMA_DESC_DEBUG_FLAG (1 << 0)
-
 /** Represents a QDMA virtual queue */
 struct qdma_virt_queue {
 	/** Associated hw queue */
@@ -273,8 +278,6 @@ struct qdma_virt_queue {
 	void **fle_elem;
 	/** Route by port */
 	struct dpaa2_qdma_rbp rbp;
-	/** States if this vq is in use or not */
-	uint8_t fle_pre_populate;
 	/** Number of descriptor for the virtual DMA channel */
 	uint16_t nb_desc;
 	/* Total number of enqueues on this VQ */
@@ -284,7 +287,6 @@ struct qdma_virt_queue {
 	uint64_t copy_num;
 
 	uint16_t vq_id;
-	uint32_t flags;
 	struct qbman_fd fd[DPAA2_QDMA_MAX_DESC];
 	uint16_t fd_idx;
 	struct qdma_cntx_idx_ring *ring_cntx_idx;
@@ -295,7 +297,6 @@ struct qdma_virt_queue {
 	uint16_t silent_idx;
 
 	int num_valid_jobs;
-	int using_short_fd;
 
 	struct rte_dma_stats stats;
 };
-- 
2.43.0

