Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638D2CA5FF1
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 08:11:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB0BA42DA3;
	Wed,  7 Oct 2026 10:10:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2B4D5427E8
 for <dev@dpdk.org>; Wed,  7 Oct 2026 10:10:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791360649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xAoX2JQx0CCKv+JhQ57sSSqUnhzINokULI1Ax7qIRX0=;
 b=Ph6Ird3P/5pGk+QJNFiHi+LdV1hz1c9u9CfBsDlRUbcSRnLCzFhj9Sozyxq7W5yXfdvuca
 qDL+cx8kfxk0aSEpxL64kjjp9slo6AJEei6h4IYLffyqx0XVtGImYarUtgt8Cs4z9jn4ZZ
 qCjd+//AGD8Gf2YAHaFTGzrR+2oriIY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-2-bVTABQMIyOfknTTMD0Jw-1; Wed,
 7 Oct 2026 08:10:46 +0000
X-MC-Unique: 2-bVTABQMIyOfknTTMD0Jw-1
X-Mimecast-MFC-AGG-ID: 2-bVTABQMIyOfknTTMD0Jw_1791360645
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67AA81802556; Wed,  7 Oct 2026 08:10:45 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6B105180057E; Wed,  7 Oct 2026 08:10:44 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Chenbo Xia <chenbox@nvidia.com>,
	Nipun Gupta <nipun.gupta@amd.com>
Subject: [RESEND][PATCH v19 04/26] bus/pci: move VFIO concerns in Linux
 implementation
Date: Wed,  7 Oct 2026 10:10:01 +0200
Message-ID: <20261007081026.574382-5-david.marchand@redhat.com>
In-Reply-To: <20261007081026.574382-1-david.marchand@redhat.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <20261007081026.574382-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l_BkHKWUEe04eTxxoTZz2RR09gAO05ZwOOVRKt4cDyU_1791360645
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Make the common PCI code independent of the VFIO API.
Move VFIO dma map/unmap operation in Linux only code: adopt the
same approach than IOMMU VA support and expose a OS specific handler
which calls a common implementation for FreeBSD and Windows.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/pci/bsd/pci.c     | 12 ++++++++++
 drivers/bus/pci/linux/pci.c   | 35 ++++++++++++++++++++++++++++++
 drivers/bus/pci/pci_common.c  | 26 +++++-----------------
 drivers/bus/pci/private.h     | 41 +++++++++++++++++++++++++++++++++++
 drivers/bus/pci/windows/pci.c | 12 ++++++++++
 5 files changed, 105 insertions(+), 21 deletions(-)

diff --git a/drivers/bus/pci/bsd/pci.c b/drivers/bus/pci/bsd/pci.c
index c6df31d486..2af99d3678 100644
--- a/drivers/bus/pci/bsd/pci.c
+++ b/drivers/bus/pci/bsd/pci.c
@@ -397,6 +397,18 @@ rte_pci_scan(void)
 	return -1;
 }
 
+int
+pci_device_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
+{
+	return pci_dma_map(dev, addr, iova, len);
+}
+
+int
+pci_device_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
+{
+	return pci_dma_unmap(dev, addr, iova, len);
+}
+
 bool
 pci_device_iommu_support_va(__rte_unused const struct rte_pci_device *dev)
 {
diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index bcf0a409da..5e4c055b07 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -5,6 +5,7 @@
 #include <string.h>
 #include <dirent.h>
 
+#include <rte_errno.h>
 #include <rte_log.h>
 #include <rte_pci.h>
 #include <rte_bus_pci.h>
@@ -478,6 +479,40 @@ rte_pci_scan(void)
 	return -1;
 }
 
+int
+pci_device_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
+{
+	int ret = pci_dma_map(dev, addr, iova, len);
+
+	if (ret == -1 && rte_errno == ENOTSUP) {
+		struct rte_pci_device *pdev = RTE_BUS_DEVICE(dev, *pdev);
+
+		/* In case driver doesn't provide any specific mapping try fallback to VFIO. */
+		if (pdev->kdrv == RTE_PCI_KDRV_VFIO)
+			ret = rte_vfio_container_dma_map(RTE_VFIO_DEFAULT_CONTAINER_FD,
+				(uintptr_t)addr, iova, len);
+	}
+
+	return ret;
+}
+
+int
+pci_device_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
+{
+	int ret = pci_dma_unmap(dev, addr, iova, len);
+
+	if (ret == -1 && rte_errno == ENOTSUP) {
+		struct rte_pci_device *pdev = RTE_BUS_DEVICE(dev, *pdev);
+
+		/* In case driver doesn't provide any specific mapping try fallback to VFIO. */
+		if (pdev->kdrv == RTE_PCI_KDRV_VFIO)
+			return rte_vfio_container_dma_unmap(RTE_VFIO_DEFAULT_CONTAINER_FD,
+				(uintptr_t)addr, iova, len);
+	}
+
+	return ret;
+}
+
 #if defined(RTE_ARCH_X86)
 bool
 pci_device_iommu_support_va(const struct rte_pci_device *dev)
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index dc8db80d3b..3770b4ad75 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -25,7 +25,6 @@
 #include <rte_string_fns.h>
 #include <rte_common.h>
 #include <rte_devargs.h>
-#include <rte_vfio.h>
 #include <rte_tailq.h>
 
 #include "private.h"
@@ -474,7 +473,7 @@ pci_sigbus_handler(const void *failure_addr)
 	return ret;
 }
 
-static int
+int
 pci_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 {
 	struct rte_pci_device *pdev = RTE_BUS_DEVICE(dev, *pdev);
@@ -482,19 +481,12 @@ pci_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 
 	if (pdrv->dma_map != NULL)
 		return pdrv->dma_map(pdev, addr, iova, len);
-	/**
-	 *  In case driver don't provides any specific mapping
-	 *  try fallback to VFIO.
-	 */
-	if (pdev->kdrv == RTE_PCI_KDRV_VFIO)
-		return rte_vfio_container_dma_map
-				(RTE_VFIO_DEFAULT_CONTAINER_FD, (uintptr_t)addr,
-				 iova, len);
+
 	rte_errno = ENOTSUP;
 	return -1;
 }
 
-static int
+int
 pci_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 {
 	struct rte_pci_device *pdev = RTE_BUS_DEVICE(dev, *pdev);
@@ -502,14 +494,6 @@ pci_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 
 	if (pdrv->dma_unmap != NULL)
 		return pdrv->dma_unmap(pdev, addr, iova, len);
-	/**
-	 *  In case driver don't provides any specific mapping
-	 *  try fallback to VFIO.
-	 */
-	if (pdev->kdrv == RTE_PCI_KDRV_VFIO)
-		return rte_vfio_container_dma_unmap
-				(RTE_VFIO_DEFAULT_CONTAINER_FD, (uintptr_t)addr,
-				 iova, len);
 	rte_errno = ENOTSUP;
 	return -1;
 }
@@ -727,8 +711,8 @@ struct rte_bus rte_pci_bus = {
 	.parse = pci_parse,
 	.dev_compare = pci_dev_compare,
 	.devargs_parse = rte_pci_devargs_parse,
-	.dma_map = pci_dma_map,
-	.dma_unmap = pci_dma_unmap,
+	.dma_map = pci_device_dma_map,
+	.dma_unmap = pci_device_dma_unmap,
 	.get_iommu_class = rte_pci_get_iommu_class,
 	.dev_iterate = rte_pci_dev_iterate,
 	.hot_unplug_handler = pci_hot_unplug_handler,
diff --git a/drivers/bus/pci/private.h b/drivers/bus/pci/private.h
index 8103c32881..f266a1b04d 100644
--- a/drivers/bus/pci/private.h
+++ b/drivers/bus/pci/private.h
@@ -210,6 +210,47 @@ pci_uio_remap_resource(struct rte_pci_device *dev);
 int pci_uio_map_resource_by_index(struct rte_pci_device *dev, int res_idx,
 		struct mapped_pci_resource *uio_res, int map_idx);
 
+/**
+ * Call driver DMA map callback if any.
+ *
+ * @param dev
+ *   Device pointer.
+ * @param addr
+ *   Virtual address to map.
+ * @param iova
+ *   IOVA address to map.
+ * @param len
+ *   Length of the memory segment being mapped.
+ * @return
+ *   0 on success, -1 on error
+ */
+int pci_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len);
+
+/**
+ * Call driver DMA unmap callback if any.
+ *
+ * @param dev
+ *   Device pointer.
+ * @param addr
+ *   Virtual address to unmap.
+ * @param iova
+ *   IOVA address to unmap.
+ * @param len
+ *   Length of the memory segment being unmapped.
+ * @return
+ *   0 on success, -1 on error
+ */
+int pci_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t len);
+
+/**
+ * OS specific callbacks for dma_map/dma_unmap
+ */
+int
+pci_device_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len);
+
+int
+pci_device_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t len);
+
 /**
  * OS specific callbacks for rte_pci_get_iommu_class
  *
diff --git a/drivers/bus/pci/windows/pci.c b/drivers/bus/pci/windows/pci.c
index 7b51301d1e..383c6bdc2f 100644
--- a/drivers/bus/pci/windows/pci.c
+++ b/drivers/bus/pci/windows/pci.c
@@ -120,6 +120,18 @@ rte_pci_mmio_write(const struct rte_pci_device *dev, int bar,
 	return len;
 }
 
+int
+pci_device_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
+{
+	return pci_dma_map(dev, addr, iova, len);
+}
+
+int
+pci_device_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
+{
+	return pci_dma_unmap(dev, addr, iova, len);
+}
+
 enum rte_iova_mode
 pci_device_iova_mode(const struct rte_pci_driver *pdrv __rte_unused,
 		const struct rte_pci_device *pdev __rte_unused)
-- 
2.54.0

