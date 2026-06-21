Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0352CD98F2
	for <dpdk-dev@archiver.kernel.org>; Sun, 21 Jun 2026 17:28:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B96E940649;
	Sun, 21 Jun 2026 19:27:44 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id C9FC640150
 for <dev@dpdk.org>; Sun, 21 Jun 2026 19:27:41 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AB31520025B;
 Sun, 21 Jun 2026 19:27:41 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 738AD200249;
 Sun, 21 Jun 2026 19:27:41 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E8025180007B;
 Mon, 22 Jun 2026 01:27:39 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Cc: Prashant Gupta <prashant.gupta_3@nxp.com>
Subject: [PATCH v4 04/19] drivers: add process-type guards for secondary
 process
Date: Sun, 21 Jun 2026 22:57:16 +0530
Message-Id: <20260621172731.2916346-5-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260621172731.2916346-1-hemant.agrawal@nxp.com>
References: <20260621152228.2777171-1-hemant.agrawal@nxp.com>
 <20260621172731.2916346-1-hemant.agrawal@nxp.com>
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
 drivers/dma/dpaa/dpaa_qdma.c       | 23 +++++++++++++++++++++++
 drivers/net/dpaa/dpaa_ethdev.c     |  3 +++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/dpaa_sec/dpaa_sec.c b/drivers/crypto/dpaa_sec/dpaa_sec.c
index 65bbd38b17..36f5819b0e 100644
--- a/drivers/crypto/dpaa_sec/dpaa_sec.c
+++ b/drivers/crypto/dpaa_sec/dpaa_sec.c
@@ -3783,9 +3783,6 @@ cryptodev_dpaa_sec_probe(struct rte_dpaa_driver *dpaa_drv __rte_unused,
 			RTE_DPAA_MAX_NB_SEC_QPS,
 	};
 
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
-		return 0;
-
 	snprintf(cryptodev_name, sizeof(cryptodev_name), "%s", dpaa_dev->name);
 
 	cryptodev = rte_cryptodev_pmd_create(cryptodev_name, &dpaa_dev->device, &init_params);
diff --git a/drivers/dma/dpaa/dpaa_qdma.c b/drivers/dma/dpaa/dpaa_qdma.c
index 74e23d2ee5..af6083d2fe 100644
--- a/drivers/dma/dpaa/dpaa_qdma.c
+++ b/drivers/dma/dpaa/dpaa_qdma.c
@@ -1330,11 +1330,34 @@ dpaa_qdma_init(struct rte_dma_dev *dmadev)
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
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 8fb2e33e0a..42ab9679d1 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -2686,6 +2686,9 @@ rte_dpaa_remove(struct rte_dpaa_device *dpaa_dev)
 
 	PMD_INIT_FUNC_TRACE();
 
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return 0;
+
 	eth_dev = dpaa_dev->eth_dev;
 	dpaa_eth_dev_close(eth_dev);
 	ret = rte_eth_dev_release_port(eth_dev);
-- 
2.25.1

