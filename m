Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA8DC624A4
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 13:54:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C312427E5;
	Thu,  3 Sep 2026 15:54:10 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 10B5B427D4;
 Thu,  3 Sep 2026 15:54:07 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EA181200480;
 Thu,  3 Sep 2026 15:54:06 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B39AD20004C;
 Thu,  3 Sep 2026 15:54:06 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 37A811800226;
 Thu,  3 Sep 2026 21:54:05 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: stable@dpdk.org,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH 07/45] drivers: fix double free of dpaa2 device on uninit
Date: Thu,  3 Sep 2026 19:23:15 +0530
Message-ID: <20260903135353.3358303-8-prashant.gupta_3@nxp.com>
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

dpaa2_dpdmai_dev_uninit() was called from dpaa2_qdma_close(), but
rte_dma close may run without a matching device remove, so the
uninitialization (which frees the qdma_dev allocation and the MC portal)
could run twice or leak the MC portal.

Move dpaa2_dpdmai_dev_uninit() to dpaa2_qdma_remove(), which is the
correct teardown counterpart of dpaa2_qdma_probe(). To reach the dmadev
from the remove callback, store the rte_dma_dev pointer in
struct rte_dpaa2_device at probe time and use it in remove, dropping the
now-unused forward declaration.

Fixes: 8caf8427f85a ("dma/dpaa2: introduce driver skeleton")
Cc: stable@dpdk.org

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/bus/fslmc/bus_fslmc_driver.h | 1 +
 drivers/dma/dpaa2/dpaa2_qdma.c       | 9 ++++-----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
index 44f81cf662..c64ef094d0 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -102,6 +102,7 @@ struct rte_dpaa2_device {
 	char ep_name[RTE_DEV_NAME_MAX_LEN];
 	struct rte_intr_handle *intr_handle; /**< Interrupt handle */
 	char name[FSLMC_OBJECT_MAX_LEN];    /**< DPAA2 Object name*/
+	struct rte_dma_dev *dmadev;          /**< DMA device */
 };
 
 typedef int (*rte_dpaa2_obj_create_t)(int vdev_fd,
diff --git a/drivers/dma/dpaa2/dpaa2_qdma.c b/drivers/dma/dpaa2/dpaa2_qdma.c
index f7d94bb799..4a95f2a1ab 100644
--- a/drivers/dma/dpaa2/dpaa2_qdma.c
+++ b/drivers/dma/dpaa2/dpaa2_qdma.c
@@ -1455,9 +1455,6 @@ dpaa2_qdma_stop(struct rte_dma_dev *dev)
 	return 0;
 }
 
-static int
-dpaa2_dpdmai_dev_uninit(struct rte_dma_dev *dev);
-
 static int
 dpaa2_qdma_close(struct rte_dma_dev *dev)
 {
@@ -1508,8 +1505,6 @@ dpaa2_qdma_close(struct rte_dma_dev *dev)
 	/* Reset QDMA device structure */
 	qdma_dev->num_vqs = 0;
 
-	dpaa2_dpdmai_dev_uninit(dev);
-
 	return 0;
 }
 
@@ -1708,6 +1703,7 @@ dpaa2_qdma_probe(struct rte_dpaa2_driver *dpaa2_drv,
 		return -EINVAL;
 	}
 
+	dpaa2_dev->dmadev = dmadev;
 	dmadev->dev_ops = &dpaa2_qdma_ops;
 	dmadev->device = &dpaa2_dev->device;
 	dmadev->fp_obj->dev_private = dmadev->data->dev_private;
@@ -1731,10 +1727,13 @@ dpaa2_qdma_probe(struct rte_dpaa2_driver *dpaa2_drv,
 static int
 dpaa2_qdma_remove(struct rte_dpaa2_device *dpaa2_dev)
 {
+	struct rte_dma_dev *dmadev = dpaa2_dev->dmadev;
 	int ret;
 
 	DPAA2_QDMA_FUNC_TRACE();
 
+	dpaa2_dpdmai_dev_uninit(dmadev);
+
 	ret = rte_dma_pmd_release(dpaa2_dev->device.name);
 	if (ret)
 		DPAA2_QDMA_ERR("Device cleanup failed");
-- 
2.43.0

