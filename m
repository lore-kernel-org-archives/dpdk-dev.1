Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50166CA5FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 09:28:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 773774278C;
	Tue,  6 Oct 2026 11:27:30 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id EF326402D9
 for <dev@dpdk.org>; Tue,  6 Oct 2026 11:27:13 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D36192001AE;
 Tue,  6 Oct 2026 11:27:13 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4C1792001B9;
 Tue,  6 Oct 2026 11:27:13 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C30E118000B1;
 Tue,  6 Oct 2026 17:27:12 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v21 18/27] dma/dpaa: add devargs for SG and errata workaround
Date: Tue,  6 Oct 2026 14:56:54 +0530
Message-Id: <20261006092703.2138929-19-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261006092703.2138929-1-hemant.agrawal@nxp.com>
References: <20261005085337.1069213-1-hemant.agrawal@nxp.com>
 <20261006092703.2138929-1-hemant.agrawal@nxp.com>
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

Scatter-gather batching, the post-transfer data validation helper and the
ERR050757 read-transaction workaround already exist in the driver. This
patch does not add them; it makes them configurable at runtime and gates
the previously always-on data-validation and ERR050757 programming.

Add three new device arguments:

  dpaa_dma_sg_disable
    Submit each pending descriptor as an individual single-entry transfer
    instead of grouping them into one SG command. SG batching stays on by
    default.

  dpaa_dma_data_validation
    Enable the existing read-back-and-compare data validation helper, which
    is otherwise skipped. For debugging only; significant performance cost.

  dpaa_dma_pci_read_disable
    Skip the ERR050757 source-frame-descriptor programming (read
    transaction type and stride limiting). Only available when built with
    RTE_DMA_DPAA_ERRATA_ERR050757. May improve throughput on unaffected
    platforms.

Also update the dmadev documentation for the new arguments.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/dmadevs/dpaa.rst  |  30 +++++++++-
 drivers/dma/dpaa/dpaa_qdma.c | 106 ++++++++++++++++++++++++++---------
 2 files changed, 108 insertions(+), 28 deletions(-)

diff --git a/doc/guides/dmadevs/dpaa.rst b/doc/guides/dmadevs/dpaa.rst
index 01104d7f1e..17aac5208c 100644
--- a/doc/guides/dmadevs/dpaa.rst
+++ b/doc/guides/dmadevs/dpaa.rst
@@ -76,5 +76,31 @@ Device Arguments
 ----------------
 
 ``dpaa_dma_err_check=1``
-  Check DMA errors at driver level.
-  Usage example: ``dpaa_bus:dpaa_qdma-1,dpaa_dma_err_check=1``
+  Enable DMA error checking at driver level. When set, the driver reads
+  the hardware error detect register after each dequeue and increments
+  the error statistics counter on any reported error.
+  Usage example: ``-a dpaa_bus:dpaa_qdma-1,dpaa_dma_err_check=1``
+
+``dpaa_dma_sg_disable=1``
+  Disable scatter-gather (SG) batching. By default the driver groups
+  multiple pending descriptors into a single SG command to reduce
+  doorbell overhead. Setting this devarg forces each descriptor to be
+  submitted as an individual single-entry transfer. Useful for latency
+  benchmarking or debugging.
+  Usage example: ``-a dpaa_bus:dpaa_qdma-1,dpaa_dma_sg_disable=1``
+
+``dpaa_dma_data_validation=1``
+  Enable post-DMA data validation. After each completed transfer the
+  driver reads back source and destination buffers and compares them
+  byte by byte, logging any mismatch. This has significant performance
+  impact and is intended for debugging only.
+  Usage example: ``-a dpaa_bus:dpaa_qdma-1,dpaa_dma_data_validation=1``
+
+``dpaa_dma_pci_read_disable=1``
+  Disable the ERR050757 workaround programming. The workaround sets the
+  read transaction type on the source frame descriptor and, for transfers
+  longer than the errata safe length, programs the source stride so that
+  read transactions stay within that limit. Only available when the driver
+  is built with ``RTE_DMA_DPAA_ERRATA_ERR050757`` enabled. Disabling it may
+  improve throughput on platforms not affected by the erratum.
+  Usage example: ``-a dpaa_bus:dpaa_qdma-1,dpaa_dma_pci_read_disable=1``
diff --git a/drivers/dma/dpaa/dpaa_qdma.c b/drivers/dma/dpaa/dpaa_qdma.c
index 0234042ded..ef2d931c1c 100644
--- a/drivers/dma/dpaa/dpaa_qdma.c
+++ b/drivers/dma/dpaa/dpaa_qdma.c
@@ -11,8 +11,21 @@
 
 static uint32_t s_sg_max_entry_sz = 2000;
 static bool s_hw_err_check;
+static bool s_data_validation;
+static bool s_sg_enable = true;
+#ifdef RTE_DMA_DPAA_ERRATA_ERR050757
+static bool s_pci_read = true;
+#endif
 
-#define DPAA_DMA_ERROR_CHECK "dpaa_dma_err_check"
+#define DPAA_DMA_ERROR_CHECK		"dpaa_dma_err_check"
+#define DPAA_DMA_SG_DISABLE		"dpaa_dma_sg_disable"
+#define DPAA_DMA_DATA_VALID		"dpaa_dma_data_validation"
+#ifdef RTE_DMA_DPAA_ERRATA_ERR050757
+#define DPAA_DMA_PCI_READ_DISABLE	"dpaa_dma_pci_read_disable"
+#define DPAA_DMA_ERRATA_PARAMS		DPAA_DMA_PCI_READ_DISABLE "=<int>"
+#else
+#define DPAA_DMA_ERRATA_PARAMS		""
+#endif
 
 static inline void
 qdma_desc_addr_set64(struct fsl_qdma_comp_cmd_desc *ccdf, u64 addr)
@@ -392,6 +405,8 @@ fsl_qdma_data_validation(struct fsl_qdma_desc *desc[],
 	char err_msg[512];
 	int offset;
 
+	if (likely(!s_data_validation))
+		return;
 
 	offset = sprintf(err_msg, "Fatal TC%d/queue%d: ",
 		fsl_queue->block_id,
@@ -716,19 +731,21 @@ fsl_qdma_enqueue_desc_single(struct fsl_qdma_queue *fsl_queue,
 	ft = fsl_queue->ft[fsl_queue->ci];
 
 #ifdef RTE_DMA_DPAA_ERRATA_ERR050757
-	sdf = &ft->df.sdf;
-	sdf->srttype = FSL_QDMA_CMD_RWTTYPE;
+	if (s_pci_read) {
+		sdf = &ft->df.sdf;
+		sdf->srttype = FSL_QDMA_CMD_RWTTYPE;
 #ifdef RTE_DMA_DPAA_ERRATA_ERR050265
-	sdf->prefetch = 1;
+		sdf->prefetch = 1;
 #endif
-	if (len > FSL_QDMA_CMD_SS_ERR050757_LEN) {
-		sdf->ssen = 1;
-		sdf->sss = FSL_QDMA_CMD_SS_ERR050757_LEN;
-		sdf->ssd = FSL_QDMA_CMD_SS_ERR050757_LEN;
-	} else {
-		sdf->ssen = 0;
-		sdf->sss = 0;
-		sdf->ssd = 0;
+		if (len > FSL_QDMA_CMD_SS_ERR050757_LEN) {
+			sdf->ssen = 1;
+			sdf->sss = FSL_QDMA_CMD_SS_ERR050757_LEN;
+			sdf->ssd = FSL_QDMA_CMD_SS_ERR050757_LEN;
+		} else {
+			sdf->ssen = 0;
+			sdf->sss = 0;
+			sdf->ssd = 0;
+		}
 	}
 #endif
 	csgf_src = &ft->desc_sbuf;
@@ -837,19 +854,21 @@ fsl_qdma_enqueue_desc_sg(struct fsl_qdma_queue *fsl_queue)
 	csgf_src->length = total_len;
 	csgf_dest->length = total_len;
 #ifdef RTE_DMA_DPAA_ERRATA_ERR050757
-	sdf = &ft->df.sdf;
-	sdf->srttype = FSL_QDMA_CMD_RWTTYPE;
+	if (s_pci_read) {
+		sdf = &ft->df.sdf;
+		sdf->srttype = FSL_QDMA_CMD_RWTTYPE;
 #ifdef RTE_DMA_DPAA_ERRATA_ERR050265
-	sdf->prefetch = 1;
+		sdf->prefetch = 1;
 #endif
-	if (total_len > FSL_QDMA_CMD_SS_ERR050757_LEN) {
-		sdf->ssen = 1;
-		sdf->sss = FSL_QDMA_CMD_SS_ERR050757_LEN;
-		sdf->ssd = FSL_QDMA_CMD_SS_ERR050757_LEN;
-	} else {
-		sdf->ssen = 0;
-		sdf->sss = 0;
-		sdf->ssd = 0;
+		if (total_len > FSL_QDMA_CMD_SS_ERR050757_LEN) {
+			sdf->ssen = 1;
+			sdf->sss = FSL_QDMA_CMD_SS_ERR050757_LEN;
+			sdf->ssd = FSL_QDMA_CMD_SS_ERR050757_LEN;
+		} else {
+			sdf->ssen = 0;
+			sdf->sss = 0;
+			sdf->ssd = 0;
+		}
 	}
 #endif
 	ret = fsl_qdma_enqueue_desc_to_ring(fsl_queue, num);
@@ -888,6 +907,25 @@ fsl_qdma_enqueue_desc(struct fsl_qdma_queue *fsl_queue)
 			fsl_queue->pending_num = 0;
 		}
 		return ret;
+	} else if (!s_sg_enable) {
+		while (fsl_queue->pending_num > 0) {
+			ret = fsl_qdma_enqueue_desc_single(fsl_queue,
+				fsl_queue->pending_desc[start].dst,
+				fsl_queue->pending_desc[start].src,
+				fsl_queue->pending_desc[start].len);
+			if (!ret) {
+				start = (start + 1) &
+					(fsl_queue->pending_max - 1);
+				fsl_queue->pending_start = start;
+				fsl_queue->pending_num--;
+			} else {
+				DPAA_QDMA_ERR("Eq pending desc failed(%d)",
+					ret);
+				return -EIO;
+			}
+		}
+
+		return 0;
 	}
 
 	return fsl_qdma_enqueue_desc_sg(fsl_queue);
@@ -1355,6 +1393,20 @@ dpaa_qdma_init(struct rte_dma_dev *dmadev)
 		s_hw_err_check = true;
 		DPAA_QDMA_INFO("Enable DMA error checks");
 	}
+	if (dpaa_get_devargs(dmadev->device->devargs, DPAA_DMA_SG_DISABLE)) {
+		s_sg_enable = false;
+		DPAA_QDMA_INFO("SG mode disabled via devarg");
+	}
+	if (dpaa_get_devargs(dmadev->device->devargs, DPAA_DMA_DATA_VALID)) {
+		s_data_validation = true;
+		DPAA_QDMA_INFO("Data validation enabled via devarg");
+	}
+#ifdef RTE_DMA_DPAA_ERRATA_ERR050757
+	if (dpaa_get_devargs(dmadev->device->devargs, DPAA_DMA_PCI_READ_DISABLE)) {
+		s_pci_read = false;
+		DPAA_QDMA_INFO("ERR050757 PCI read workaround disabled via devarg");
+	}
+#endif
 
 	fsl_qdma->n_queues = QDMA_QUEUES * QDMA_BLOCKS;
 	fsl_qdma->num_blocks = QDMA_BLOCKS;
@@ -1485,8 +1537,6 @@ dpaa_qdma_remove(struct rte_dpaa_device *dpaa_dev)
 	return 0;
 }
 
-static struct rte_dpaa_driver rte_dpaa_qdma_pmd;
-
 static struct rte_dpaa_driver rte_dpaa_qdma_pmd = {
 	.drv_type = FSL_DPAA_QDMA,
 	.probe = dpaa_qdma_probe,
@@ -1494,5 +1544,9 @@ static struct rte_dpaa_driver rte_dpaa_qdma_pmd = {
 };
 
 RTE_PMD_REGISTER_DPAA(dpaa_qdma, rte_dpaa_qdma_pmd);
-RTE_PMD_REGISTER_PARAM_STRING(dpaa_qdma, DPAA_DMA_ERROR_CHECK "=<int>");
+RTE_PMD_REGISTER_PARAM_STRING(dpaa_qdma,
+	DPAA_DMA_ERROR_CHECK "=<int> "
+	DPAA_DMA_SG_DISABLE "=<int> "
+	DPAA_DMA_DATA_VALID "=<int> "
+	DPAA_DMA_ERRATA_PARAMS);
 RTE_LOG_REGISTER_DEFAULT(dpaa_qdma_logtype, INFO);
-- 
2.25.1

