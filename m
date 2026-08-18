Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6A8C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 11:19:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 565B940BA4;
	Tue, 18 Aug 2026 13:17:59 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id C94D640A76
 for <dev@dpdk.org>; Tue, 18 Aug 2026 13:17:53 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AC4ED1A0265;
 Tue, 18 Aug 2026 13:17:53 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7903A1A025B;
 Tue, 18 Aug 2026 13:17:53 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D824118000BF;
 Tue, 18 Aug 2026 19:17:51 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v12 14/26] dma/dpaa: add SG data validation and ERR050757
Date: Tue, 18 Aug 2026 16:47:18 +0530
Message-Id: <20260818111730.801760-15-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260818111730.801760-1-hemant.agrawal@nxp.com>
References: <20260813144205.2505031-1-hemant.agrawal@nxp.com>
 <20260818111730.801760-1-hemant.agrawal@nxp.com>
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

Add scatter-gather (SG) support to the QDMA driver, enabled by default
via the s_sg_enable flag. Add optional data validation mode controlled
by the s_data_validation flag for debugging transfer correctness.

Add a workaround for hardware errata ERR050757: when
RTE_DMA_DPAA_ERRATA_ERR050757 is defined, configure the source frame
descriptor with stride settings (sss/ssd = FSL_QDMA_CMD_SS_ERR050757_LEN)
to force PCI read transactions to stay within the errata-safe length
limit, preventing data corruption on affected silicon.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/dmadevs/dpaa.rst  |  30 +++++++++-
 drivers/dma/dpaa/dpaa_qdma.c | 107 +++++++++++++++++++++++++++--------
 2 files changed, 110 insertions(+), 27 deletions(-)

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
index 3981bf277e..9868cb3771 100644
--- a/drivers/dma/dpaa/dpaa_qdma.c
+++ b/drivers/dma/dpaa/dpaa_qdma.c
@@ -11,8 +11,18 @@
 
 static uint32_t s_sg_max_entry_sz = 2000;
 static bool s_hw_err_check;
+static int s_data_validation;
+static int s_sg_enable = 1;
+#ifdef RTE_DMA_DPAA_ERRATA_ERR050757
+static int s_pci_read = 1;
+#endif
 
-#define DPAA_DMA_ERROR_CHECK "dpaa_dma_err_check"
+#define DPAA_DMA_ERROR_CHECK		"dpaa_dma_err_check"
+#define DPAA_DMA_SG_DISABLE		"dpaa_dma_sg_disable"
+#define DPAA_DMA_DATA_VALID		"dpaa_dma_data_validation"
+#ifdef RTE_DMA_DPAA_ERRATA_ERR050757
+#define DPAA_DMA_PCI_READ_DISABLE	"dpaa_dma_pci_read_disable"
+#endif
 
 static inline void
 qdma_desc_addr_set64(struct fsl_qdma_comp_cmd_desc *ccdf, u64 addr)
@@ -112,7 +122,8 @@ dma_pool_alloc(char *nm, int size, int aligned, dma_addr_t *phy_addr)
 	if (!virt_addr)
 		return NULL;
 
-	*phy_addr = rte_mem_virt2iova(virt_addr);
+	if (phy_addr)
+		*phy_addr = rte_mem_virt2iova(virt_addr);
 
 	return virt_addr;
 }
@@ -392,6 +403,8 @@ fsl_qdma_data_validation(struct fsl_qdma_desc *desc[],
 	char err_msg[512];
 	int offset;
 
+	if (likely(!s_data_validation))
+		return;
 
 	offset = sprintf(err_msg, "Fatal TC%d/queue%d: ",
 		fsl_queue->block_id,
@@ -716,19 +729,21 @@ fsl_qdma_enqueue_desc_single(struct fsl_qdma_queue *fsl_queue,
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
@@ -837,19 +852,21 @@ fsl_qdma_enqueue_desc_sg(struct fsl_qdma_queue *fsl_queue)
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
@@ -888,6 +905,25 @@ fsl_qdma_enqueue_desc(struct fsl_qdma_queue *fsl_queue)
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
@@ -1358,6 +1394,20 @@ dpaa_qdma_init(struct rte_dma_dev *dmadev)
 		s_hw_err_check = true;
 		DPAA_QDMA_INFO("Enable DMA error checks");
 	}
+	if (dpaa_get_devargs(dmadev->device->devargs, DPAA_DMA_SG_DISABLE)) {
+		s_sg_enable = 0;
+		DPAA_QDMA_INFO("SG mode disabled via devarg");
+	}
+	if (dpaa_get_devargs(dmadev->device->devargs, DPAA_DMA_DATA_VALID)) {
+		s_data_validation = 1;
+		DPAA_QDMA_INFO("Data validation enabled via devarg");
+	}
+#ifdef RTE_DMA_DPAA_ERRATA_ERR050757
+	if (dpaa_get_devargs(dmadev->device->devargs, DPAA_DMA_PCI_READ_DISABLE)) {
+		s_pci_read = 0;
+		DPAA_QDMA_INFO("ERR050757 PCI read workaround disabled via devarg");
+	}
+#endif
 
 	fsl_qdma->n_queues = QDMA_QUEUES * QDMA_BLOCKS;
 	fsl_qdma->num_blocks = QDMA_BLOCKS;
@@ -1483,5 +1533,12 @@ static struct rte_dpaa_driver rte_dpaa_qdma_pmd = {
 };
 
 RTE_PMD_REGISTER_DPAA(dpaa_qdma, rte_dpaa_qdma_pmd);
-RTE_PMD_REGISTER_PARAM_STRING(dpaa_qdma, DPAA_DMA_ERROR_CHECK "=<int>");
+RTE_PMD_REGISTER_PARAM_STRING(dpaa_qdma,
+	DPAA_DMA_ERROR_CHECK "=<int> "
+	DPAA_DMA_SG_DISABLE "=<int> "
+	DPAA_DMA_DATA_VALID "=<int> "
+#ifdef RTE_DMA_DPAA_ERRATA_ERR050757
+	DPAA_DMA_PCI_READ_DISABLE "=<int>"
+#endif
+	);
 RTE_LOG_REGISTER_DEFAULT(dpaa_qdma_logtype, INFO);
-- 
2.25.1

