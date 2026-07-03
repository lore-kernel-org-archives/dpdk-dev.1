Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3E0C43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 12:50:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D4F5406B8;
	Fri,  3 Jul 2026 14:50:01 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 6021A4069F
 for <dev@dpdk.org>; Fri,  3 Jul 2026 14:50:00 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 44455200046;
 Fri,  3 Jul 2026 14:50:00 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0812A200017;
 Fri,  3 Jul 2026 14:50:00 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AF93F180007B;
 Fri,  3 Jul 2026 20:49:57 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Cc: Prashant Gupta <prashant.gupta_3@nxp.com>
Subject: [PATCH v7 03/16] drivers: add process-type guards for secondary
 process
Date: Fri,  3 Jul 2026 18:19:37 +0530
Message-Id: <20260703124950.1895871-4-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260703124950.1895871-1-hemant.agrawal@nxp.com>
References: <20260702053359.3243907-1-hemant.agrawal@nxp.com>
 <20260703124950.1895871-1-hemant.agrawal@nxp.com>
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

From: Prashant Gupta <prashant.gupta_3@nxp.com>

Add RTE_PROC_PRIMARY checks in device initialization paths for
net/dpaa, crypto/dpaa_sec and dma/dpaa drivers. Secondary
processes should skip hardware initialization to prevent
segfaults when accessing hardware registers that are only
mapped in the primary process.

Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
---
 drivers/crypto/dpaa_sec/dpaa_sec.c |  3 ---
 drivers/dma/dpaa/dpaa_qdma.c       | 31 +++++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/dpaa_sec/dpaa_sec.c b/drivers/crypto/dpaa_sec/dpaa_sec.c
index c53ee70853..5caf6b18dc 100644
--- a/drivers/crypto/dpaa_sec/dpaa_sec.c
+++ b/drivers/crypto/dpaa_sec/dpaa_sec.c
@@ -3782,9 +3782,6 @@ cryptodev_dpaa_sec_probe(struct rte_dpaa_driver *dpaa_drv __rte_unused,
 			RTE_DPAA_MAX_NB_SEC_QPS,
 	};
 
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
-		return 0;
-
 	cryptodev = rte_cryptodev_pmd_create(dpaa_dev->name, &dpaa_dev->device, &init_params);
 	if (cryptodev == NULL) {
 		DPAA_SEC_ERR("failed to create cryptodev vdev");
diff --git a/drivers/dma/dpaa/dpaa_qdma.c b/drivers/dma/dpaa/dpaa_qdma.c
index a695f58bc5..6a4022c652 100644
--- a/drivers/dma/dpaa/dpaa_qdma.c
+++ b/drivers/dma/dpaa/dpaa_qdma.c
@@ -9,8 +9,14 @@
 #include "dpaa_qdma.h"
 #include "dpaa_qdma_logs.h"
 
-static uint32_t s_sg_max_entry_sz = 2000;
+static int s_data_validation;
 static bool s_hw_err_check;
+static int s_sg_enable = 1;
+static uint32_t s_sg_max_entry_sz = 2000;
+
+#ifdef RTE_DMA_DPAA_ERRATA_ERR050757
+static int s_pci_read = 1;
+#endif
 
 #define DPAA_DMA_ERROR_CHECK "dpaa_dma_err_check"
 
@@ -1346,11 +1352,34 @@ dpaa_qdma_init(struct rte_dma_dev *dmadev)
 	int ret;
 	uint32_t i, j, k;
 
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -ENOTSUP;
+
 	if (dpaa_get_devargs(dmadev->device->devargs, DPAA_DMA_ERROR_CHECK)) {
 		s_hw_err_check = true;
 		DPAA_QDMA_INFO("Enable DMA error checks");
 	}
 
+	if (getenv("DPAA_QDMA_DATA_VALIDATION"))
+		s_data_validation = 1;
+
+	if (getenv("DPAA_QDMA_HW_ERR_CHECK"))
+		s_hw_err_check = 1;
+
+	char *penv = getenv("DPAA_QDMA_SG_ENABLE");
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

