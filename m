Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E079DCD98F0
	for <dpdk-dev@archiver.kernel.org>; Sun, 21 Jun 2026 15:24:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D0734065B;
	Sun, 21 Jun 2026 17:23:00 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 0FAE040685
 for <dev@dpdk.org>; Sun, 21 Jun 2026 17:22:55 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E94EC1A01C4;
 Sun, 21 Jun 2026 17:22:54 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B215D1A000C;
 Sun, 21 Jun 2026 17:22:54 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3416B180004C;
 Sun, 21 Jun 2026 23:22:53 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v3 18/19] dma/dpaa: add SG data validation and ERR050757 fix
Date: Sun, 21 Jun 2026 20:52:27 +0530
Message-Id: <20260621152228.2777171-19-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260621152228.2777171-1-hemant.agrawal@nxp.com>
References: <20260621101651.1081425-1-hemant.agrawal@nxp.com>
 <20260621152228.2777171-1-hemant.agrawal@nxp.com>
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
 drivers/dma/dpaa/dpaa_qdma.c | 99 +++++++++++++++++++++++++++---------
 1 file changed, 75 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/dpaa/dpaa_qdma.c b/drivers/dma/dpaa/dpaa_qdma.c
index 0ede9ee8b5..acac770c88 100644
--- a/drivers/dma/dpaa/dpaa_qdma.c
+++ b/drivers/dma/dpaa/dpaa_qdma.c
@@ -9,9 +9,14 @@
 #include "dpaa_qdma.h"
 #include "dpaa_qdma_logs.h"
 
+static int s_data_validation;
+static int s_hw_err_check;
+static int s_sg_enable = 1;
 static uint32_t s_sg_max_entry_sz = 2000;
-static bool s_hw_err_check;
 
+#ifdef RTE_DMA_DPAA_ERRATA_ERR050757
+static int s_pci_read = 1;
+#endif
 #define DPAA_DMA_ERROR_CHECK "dpaa_dma_err_check"
 
 static inline void
@@ -112,7 +117,8 @@ dma_pool_alloc(char *nm, int size, int aligned, dma_addr_t *phy_addr)
 	if (!virt_addr)
 		return NULL;
 
-	*phy_addr = rte_mem_virt2iova(virt_addr);
+	if (phy_addr)
+		*phy_addr = rte_mem_virt2iova(virt_addr);
 
 	return virt_addr;
 }
@@ -392,6 +398,8 @@ fsl_qdma_data_validation(struct fsl_qdma_desc *desc[],
 	char err_msg[512];
 	int offset;
 
+	if (likely(!s_data_validation))
+		return;
 
 	offset = sprintf(err_msg, "Fatal TC%d/queue%d: ",
 		fsl_queue->block_id,
@@ -716,19 +724,21 @@ fsl_qdma_enqueue_desc_single(struct fsl_qdma_queue *fsl_queue,
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
@@ -832,19 +842,21 @@ fsl_qdma_enqueue_desc_sg(struct fsl_qdma_queue *fsl_queue)
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
@@ -883,6 +895,25 @@ fsl_qdma_enqueue_desc(struct fsl_qdma_queue *fsl_queue)
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
@@ -1339,6 +1370,26 @@ dpaa_qdma_init(struct rte_dma_dev *dmadev)
 		DPAA_QDMA_INFO("Enable DMA error checks");
 	}
 
+	if (getenv("DPAA_QDMA_DATA_VALIDATION"))
+		s_data_validation = 1;
+
+	if (getenv("DPAA_QDMA_HW_ERR_CHECK"))
+		s_hw_err_check = 1;
+
+	penv = getenv("DPAA_QDMA_SG_ENABLE");
+	if (penv)
+		s_sg_enable = atoi(penv);
+
+	penv = getenv("DPAA_QDMA_SG_MAX_ENTRY_SIZE");
+	if (penv)
+		s_sg_max_entry_sz = atoi(penv);
+
+#ifdef RTE_DMA_DPAA_ERRATA_ERR050757
+	penv = getenv("DPAA_QDMA_PCI_READ");
+	if (penv)
+		s_pci_read = atoi(penv);
+#endif
+
 	fsl_qdma->n_queues = QDMA_QUEUES * QDMA_BLOCKS;
 	fsl_qdma->num_blocks = QDMA_BLOCKS;
 	fsl_qdma->block_offset = QDMA_BLOCK_OFFSET;
-- 
2.25.1

