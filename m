Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C6AFF8875
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 11:47:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E63A140A80;
	Wed, 29 Apr 2026 13:47:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 994F240A67
 for <dev@dpdk.org>; Wed, 29 Apr 2026 13:47:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777463254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UPEOGdjelrWUgDiWt8W1bYRbhbDk8JzVEyb9bxgtHbg=;
 b=SzKF4Lzcd9j9Vc0jPsHYak3YrSMoW0fEDIYWOX0ahptV1a46eJCRlUz2Ldmc0vxnriiWQ5
 py4kkMSlBFLf3hphO97LbDpIm28r7VSKgY/vh7XcpPA3/ozEICWPtvlXu9k+g/9DCEyihE
 XreLFhOleA9AaepJ8VCYU7BVbsvZSps=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-O5uxVVbPNNO-I5-KgPy9jA-1; Wed,
 29 Apr 2026 07:47:30 -0400
X-MC-Unique: O5uxVVbPNNO-I5-KgPy9jA-1
X-Mimecast-MFC-AGG-ID: O5uxVVbPNNO-I5-KgPy9jA_1777463247
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C663219560AD; Wed, 29 Apr 2026 11:47:26 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.207])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 74C181800480; Wed, 29 Apr 2026 11:47:19 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, Parav Pandit <parav@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@altera.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Kai Ji <kai.ji@intel.com>,
 Hanxiao Li <li.hanxiao@zte.com.cn>, Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>,
 Jakub Palider <jpalider@marvell.com>, Akhil Goyal <gakhil@marvell.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 17/23] drivers: rely on generic driver
Date: Wed, 29 Apr 2026 13:44:50 +0200
Message-ID: <20260429114503.932575-18-david.marchand@redhat.com>
In-Reply-To: <20260429114503.932575-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NlNhzs69e3vE9F3I8q9GDzuxGd79arATckZc3twpClw_1777463247
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

Now that the generic device object always references a generic driver, we
can rely on this reference and stop going through the bus-specific
driver reference.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/auxiliary/auxiliary_common.c | 12 +++++++-----
 drivers/bus/cdx/cdx.c                    |  2 +-
 drivers/bus/dpaa/dpaa_bus.c              |  3 ++-
 drivers/bus/fslmc/fslmc_bus.c            |  2 +-
 drivers/bus/fslmc/fslmc_vfio.c           | 10 ++++++----
 drivers/bus/ifpga/ifpga_bus.c            |  6 ++++--
 drivers/bus/pci/linux/pci_uio.c          |  6 ++++--
 drivers/bus/pci/pci_common.c             | 20 +++++++++-----------
 drivers/bus/platform/platform.c          | 20 ++++++++++++--------
 drivers/bus/uacce/uacce.c                |  5 +++--
 drivers/bus/vmbus/vmbus_common.c         |  3 ++-
 drivers/common/qat/qat_qp.c              |  4 ++--
 drivers/common/zsda/zsda_qp.c            |  4 ++--
 drivers/net/ntnic/ntnic_ethdev.c         |  8 +++-----
 drivers/raw/cnxk_bphy/cnxk_bphy.c        |  2 +-
 drivers/raw/cnxk_bphy/cnxk_bphy_cgx.c    |  2 +-
 drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c    |  2 +-
 drivers/raw/ifpga/afu_pmd_core.c         |  2 +-
 drivers/raw/ifpga/ifpga_rawdev.c         |  2 +-
 drivers/raw/ntb/ntb.c                    |  2 +-
 lib/ethdev/ethdev_pci.h                  |  7 +++++--
 21 files changed, 69 insertions(+), 55 deletions(-)

diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index ba8c35ebbe..2000ffa369 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -131,7 +131,7 @@ auxiliary_probe_device(struct rte_driver *drv, struct rte_device *dev)
 static int
 rte_auxiliary_driver_remove_dev(struct rte_auxiliary_device *dev)
 {
-	struct rte_auxiliary_driver *drv = dev->driver;
+	const struct rte_auxiliary_driver *drv = RTE_BUS_DRIVER(dev->device.driver, *drv);
 	int ret = 0;
 
 	AUXILIARY_LOG(DEBUG, "Driver %s remove auxiliary device %s on NUMA node %i",
@@ -226,12 +226,13 @@ static int
 auxiliary_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 {
 	struct rte_auxiliary_device *aux_dev = RTE_BUS_DEVICE(dev, *aux_dev);
+	const struct rte_auxiliary_driver *aux_drv = RTE_BUS_DRIVER(dev->driver, *aux_drv);
 
-	if (aux_dev->driver->dma_map == NULL) {
+	if (aux_drv->dma_map == NULL) {
 		rte_errno = ENOTSUP;
 		return -1;
 	}
-	return aux_dev->driver->dma_map(aux_dev, addr, iova, len);
+	return aux_drv->dma_map(aux_dev, addr, iova, len);
 }
 
 static int
@@ -239,12 +240,13 @@ auxiliary_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova,
 		    size_t len)
 {
 	struct rte_auxiliary_device *aux_dev = RTE_BUS_DEVICE(dev, *aux_dev);
+	const struct rte_auxiliary_driver *aux_drv = RTE_BUS_DRIVER(dev->driver, *aux_drv);
 
-	if (aux_dev->driver->dma_unmap == NULL) {
+	if (aux_drv->dma_unmap == NULL) {
 		rte_errno = ENOTSUP;
 		return -1;
 	}
-	return aux_dev->driver->dma_unmap(aux_dev, addr, iova, len);
+	return aux_drv->dma_unmap(aux_dev, addr, iova, len);
 }
 
 static enum rte_iova_mode
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index c6a4da7692..5a823a0dcd 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -382,7 +382,7 @@ rte_cdx_unregister(struct rte_cdx_driver *driver)
 static int
 cdx_detach_dev(struct rte_cdx_device *dev)
 {
-	struct rte_cdx_driver *dr = dev->driver;
+	const struct rte_cdx_driver *dr = RTE_BUS_DRIVER(dev->device.driver, *dr);
 	int ret = 0;
 
 	CDX_BUS_DEBUG("detach device %s using driver: %s",
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index b7d0caaf61..0fd6a8d7a6 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -815,11 +815,12 @@ dpaa_bus_cleanup(void)
 
 	BUS_INIT_FUNC_TRACE();
 	RTE_BUS_FOREACH_DEV(dev, &rte_dpaa_bus.bus) {
-		struct rte_dpaa_driver *drv = dev->driver;
+		const struct rte_dpaa_driver *drv;
 		int ret = 0;
 
 		if (!rte_dev_is_probed(&dev->device))
 			continue;
+		drv = RTE_BUS_DRIVER(dev->device.driver, *drv);
 		if (drv->remove == NULL)
 			continue;
 		ret = drv->remove(dev);
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index ae69bd0da2..e33b63259d 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -534,7 +534,7 @@ static int
 fslmc_bus_unplug(struct rte_device *rte_dev)
 {
 	struct rte_dpaa2_device *dev = RTE_BUS_DEVICE(rte_dev, *dev);
-	struct rte_dpaa2_driver *drv = dev->driver;
+	const struct rte_dpaa2_driver *drv = RTE_BUS_DRIVER(rte_dev->driver, *drv);
 
 	if (drv->remove != NULL) {
 		drv->remove(dev);
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index e38f3e9fe7..5784adaf90 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -1392,7 +1392,7 @@ fslmc_close_iodevices(struct rte_dpaa2_device *dev,
 	int vfio_fd)
 {
 	struct rte_dpaa2_object *object = NULL;
-	struct rte_dpaa2_driver *drv;
+	const struct rte_dpaa2_driver *drv;
 	int ret;
 
 	switch (dev->dev_type) {
@@ -1411,9 +1411,11 @@ fslmc_close_iodevices(struct rte_dpaa2_device *dev,
 	case DPAA2_ETH:
 	case DPAA2_CRYPTO:
 	case DPAA2_QDMA:
-		drv = dev->driver;
-		if (drv && drv->remove && drv->remove(dev))
-			DPAA2_BUS_ERR("Unable to remove");
+		if (dev->device.driver != NULL) {
+			drv = RTE_BUS_DRIVER(dev->device.driver, *drv);
+			if (drv->remove && drv->remove(dev))
+				DPAA2_BUS_ERR("Unable to remove");
+		}
 		break;
 	default:
 		break;
diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index a79a287fbe..b13285230b 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -296,11 +296,12 @@ ifpga_cleanup(void)
 	int error = 0;
 
 	RTE_BUS_FOREACH_DEV(afu_dev, &rte_ifpga_bus) {
-		struct rte_afu_driver *drv = afu_dev->driver;
+		const struct rte_afu_driver *drv;
 		int ret = 0;
 
 		if (!rte_dev_is_probed(&afu_dev->device))
 			goto free;
+		drv = RTE_BUS_DRIVER(afu_dev->device.driver, *drv);
 		if (drv->remove == NULL)
 			goto free;
 
@@ -326,9 +327,10 @@ static int
 ifpga_unplug(struct rte_device *dev)
 {
 	struct rte_afu_device *afu_dev = RTE_BUS_DEVICE(dev, *afu_dev);
+	const struct rte_afu_driver *afu_drv = RTE_BUS_DRIVER(dev->driver, *afu_drv);
 	int ret;
 
-	ret = afu_dev->driver->remove(afu_dev);
+	ret = afu_drv->remove(afu_dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/bus/pci/linux/pci_uio.c b/drivers/bus/pci/linux/pci_uio.c
index 4c1d3327a9..40e96b1c67 100644
--- a/drivers/bus/pci/linux/pci_uio.c
+++ b/drivers/bus/pci/linux/pci_uio.c
@@ -301,8 +301,10 @@ pci_uio_map_resource_by_index(struct rte_pci_device *dev, int res_idx,
 	struct pci_map *maps;
 	int wc_activate = 0;
 
-	if (dev->driver != NULL)
-		wc_activate = dev->driver->drv_flags & RTE_PCI_DRV_WC_ACTIVATE;
+	if (dev->device.driver != NULL) {
+		const struct rte_pci_driver *pdrv = RTE_BUS_DRIVER(dev->device.driver, *pdrv);
+		wc_activate = pdrv->drv_flags & RTE_PCI_DRV_WC_ACTIVATE;
+	}
 
 	loc = &dev->addr;
 	maps = uio_res->maps;
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index 5c37c5e543..e927f4af7b 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -245,11 +245,6 @@ pci_probe_device(struct rte_driver *drv, struct rte_device *dev)
 			return -ENOMEM;
 		}
 
-		/*
-		 * Reference driver structure.
-		 * This needs to be before rte_pci_map_device(), as it enables
-		 * to use driver flags for adjusting configuration.
-		 */
 		pci_dev->driver = pci_drv;
 		if (pci_drv->drv_flags & RTE_PCI_DRV_NEED_MAPPING) {
 			ret = rte_pci_map_device(pci_dev);
@@ -298,7 +293,7 @@ static int
 rte_pci_detach_dev(struct rte_pci_device *dev)
 {
 	struct rte_pci_addr *loc;
-	struct rte_pci_driver *dr = dev->driver;
+	const struct rte_pci_driver *dr = RTE_BUS_DRIVER(dev->device.driver, *dr);
 	int ret = 0;
 
 	loc = &dev->addr;
@@ -339,11 +334,12 @@ pci_cleanup(void)
 	int error = 0;
 
 	RTE_BUS_FOREACH_DEV(dev, &rte_pci_bus.bus) {
-		struct rte_pci_driver *drv = dev->driver;
+		const struct rte_pci_driver *drv;
 		int ret = 0;
 
 		if (!rte_dev_is_probed(&dev->device))
 			goto free;
+		drv = RTE_BUS_DRIVER(dev->device.driver, *drv);
 		if (drv->remove == NULL)
 			goto free;
 
@@ -545,9 +541,10 @@ static int
 pci_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 {
 	struct rte_pci_device *pdev = RTE_BUS_DEVICE(dev, *pdev);
+	const struct rte_pci_driver *pdrv = RTE_BUS_DRIVER(dev->driver, *pdrv);
 
-	if (pdev->driver->dma_map != NULL)
-		return pdev->driver->dma_map(pdev, addr, iova, len);
+	if (pdrv->dma_map != NULL)
+		return pdrv->dma_map(pdev, addr, iova, len);
 	/**
 	 *  In case driver don't provides any specific mapping
 	 *  try fallback to VFIO.
@@ -564,9 +561,10 @@ static int
 pci_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 {
 	struct rte_pci_device *pdev = RTE_BUS_DEVICE(dev, *pdev);
+	const struct rte_pci_driver *pdrv = RTE_BUS_DRIVER(dev->driver, *pdrv);
 
-	if (pdev->driver->dma_unmap != NULL)
-		return pdev->driver->dma_unmap(pdev, addr, iova, len);
+	if (pdrv->dma_unmap != NULL)
+		return pdrv->dma_unmap(pdev, addr, iova, len);
 	/**
 	 *  In case driver don't provides any specific mapping
 	 *  try fallback to VFIO.
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 671f36fac9..433bab9b60 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -408,7 +408,7 @@ platform_bus_probe_device(struct rte_driver *drv, struct rte_device *dev)
 static void
 device_release_driver(struct rte_platform_device *pdev)
 {
-	struct rte_platform_driver *pdrv = pdev->driver;
+	const struct rte_platform_driver *pdrv = RTE_BUS_DRIVER(pdev->device.driver, *pdrv);
 	int ret;
 
 	if (pdrv->remove != NULL) {
@@ -458,9 +458,10 @@ static int
 platform_bus_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 {
 	struct rte_platform_device *pdev = RTE_BUS_DEVICE(dev, *pdev);
+	const struct rte_platform_driver *pdrv = RTE_BUS_DRIVER(dev->driver, *pdrv);
 
-	if (pdev->driver->dma_map != NULL)
-		return pdev->driver->dma_map(pdev, addr, iova, len);
+	if (pdrv->dma_map != NULL)
+		return pdrv->dma_map(pdev, addr, iova, len);
 
 	return rte_vfio_container_dma_map(RTE_VFIO_DEFAULT_CONTAINER_FD, (uint64_t)addr, iova, len);
 }
@@ -469,9 +470,10 @@ static int
 platform_bus_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 {
 	struct rte_platform_device *pdev = RTE_BUS_DEVICE(dev, *pdev);
+	const struct rte_platform_driver *pdrv = RTE_BUS_DRIVER(dev->driver, *pdrv);
 
-	if (pdev->driver->dma_unmap != NULL)
-		return pdev->driver->dma_unmap(pdev, addr, iova, len);
+	if (pdrv->dma_unmap != NULL)
+		return pdrv->dma_unmap(pdev, addr, iova, len);
 
 	return rte_vfio_container_dma_unmap(RTE_VFIO_DEFAULT_CONTAINER_FD, (uint64_t)addr, iova,
 					    len);
@@ -480,12 +482,14 @@ platform_bus_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t
 static enum rte_iova_mode
 platform_bus_get_iommu_class(void)
 {
-	struct rte_platform_driver *pdrv;
+	const struct rte_platform_driver *pdrv;
 	struct rte_platform_device *pdev;
 
 	RTE_BUS_FOREACH_DEV(pdev, &platform_bus.bus) {
-		pdrv = pdev->driver;
-		if (pdrv != NULL && pdrv->drv_flags & RTE_PLATFORM_DRV_NEED_IOVA_AS_VA)
+		if (!rte_dev_is_probed(&pdev->device))
+			continue;
+		pdrv = RTE_BUS_DRIVER(pdev->device.driver, *pdrv);
+		if (pdrv->drv_flags & RTE_PLATFORM_DRV_NEED_IOVA_AS_VA)
 			return RTE_IOVA_VA;
 	}
 
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index d4a18b2835..efc0da606b 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -380,11 +380,12 @@ uacce_cleanup(void)
 	int error = 0;
 
 	RTE_BUS_FOREACH_DEV(dev, &uacce_bus.bus) {
-		struct rte_uacce_driver *dr = dev->driver;
+		const struct rte_uacce_driver *dr;
 		int ret = 0;
 
 		if (!rte_dev_is_probed(&dev->device))
 			goto free;
+		dr = RTE_BUS_DRIVER(dev->device.driver, *dr);
 		if (dr->remove == NULL)
 			goto free;
 
@@ -407,7 +408,7 @@ uacce_cleanup(void)
 static int
 uacce_detach_dev(struct rte_uacce_device *dev)
 {
-	struct rte_uacce_driver *dr = dev->driver;
+	const struct rte_uacce_driver *dr = RTE_BUS_DRIVER(dev->device.driver, *dr);
 	int ret = 0;
 
 	UACCE_BUS_DEBUG("detach device %s using driver: %s", dev->device.name, dr->driver.name);
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index 43652c0487..b96f4133dd 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -143,11 +143,12 @@ rte_vmbus_cleanup(void)
 	int error = 0;
 
 	RTE_BUS_FOREACH_DEV(dev, &rte_vmbus_bus.bus) {
-		const struct rte_vmbus_driver *drv = dev->driver;
+		const struct rte_vmbus_driver *drv;
 		int ret;
 
 		if (!rte_dev_is_probed(&dev->device))
 			continue;
+		drv = RTE_BUS_DRIVER(dev->device.driver, *drv);
 		if (drv->remove == NULL)
 			continue;
 
diff --git a/drivers/common/qat/qat_qp.c b/drivers/common/qat/qat_qp.c
index 0d2bbdb8a5..fe28cb160d 100644
--- a/drivers/common/qat/qat_qp.c
+++ b/drivers/common/qat/qat_qp.c
@@ -174,7 +174,7 @@ qat_qp_setup(struct qat_pci_device *qat_dev,
 
 	snprintf(op_cookie_pool_name, RTE_RING_NAMESIZE,
 					"%s%d_cookies_%s_qp%hu",
-		pci_dev->driver->driver.name, qat_dev->qat_dev_id,
+		pci_dev->device.driver->name, qat_dev->qat_dev_id,
 		qat_qp_conf->service_str, queue_pair_id);
 
 	QAT_LOG(DEBUG, "cookiepool: %s", op_cookie_pool_name);
@@ -252,7 +252,7 @@ qat_queue_create(struct qat_pci_device *qat_dev, struct qat_queue *queue,
 	 */
 	snprintf(queue->memz_name, sizeof(queue->memz_name),
 			"%s_%d_%s_%s_%d_%d",
-		pci_dev->driver->driver.name, qat_dev->qat_dev_id,
+		pci_dev->device.driver->name, qat_dev->qat_dev_id,
 		qp_conf->service_str, "qp_mem",
 		queue->hw_bundle_number, queue->hw_queue_number);
 	qp_mz = queue_dma_zone_reserve(queue->memz_name, queue_size_bytes,
diff --git a/drivers/common/zsda/zsda_qp.c b/drivers/common/zsda/zsda_qp.c
index dab524e2d3..79172234af 100644
--- a/drivers/common/zsda/zsda_qp.c
+++ b/drivers/common/zsda/zsda_qp.c
@@ -592,12 +592,12 @@ zsda_queue_create(const uint8_t dev_id, struct zsda_queue *queue,
 
 	if (dir == RING_DIR_TX)
 		snprintf(queue->memz_name, sizeof(queue->memz_name),
-			 "%s_%d_%s_%s_%d", pci_dev->driver->driver.name, dev_id,
+			 "%s_%d_%s_%s_%d", pci_dev->device.driver->name, dev_id,
 			 qp_conf->service_str, "qptxmem",
 			 queue->hw_queue_number);
 	else
 		snprintf(queue->memz_name, sizeof(queue->memz_name),
-			 "%s_%d_%s_%s_%d", pci_dev->driver->driver.name, dev_id,
+			 "%s_%d_%s_%s_%d", pci_dev->device.driver->name, dev_id,
 			 qp_conf->service_str, "qprxmem",
 			 queue->hw_queue_number);
 
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 89e751e7e0..7cc90a7a5b 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -2676,8 +2676,7 @@ nthw_pci_dev_deinit(struct rte_eth_dev *eth_dev __rte_unused)
 }
 
 static int
-nthw_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
-	struct rte_pci_device *pci_dev)
+nthw_pci_probe(struct rte_pci_driver *pci_drv, struct rte_pci_device *pci_dev)
 {
 	int ret;
 
@@ -2711,9 +2710,8 @@ nthw_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 		pci_dev->id.subsystem_vendor_id, pci_dev->id.subsystem_device_id,
 		pci_dev->name[0] ? pci_dev->name : "NA",
 		pci_dev->device.numa_node,
-		pci_dev->driver->driver.name ? pci_dev->driver->driver.name : "NA",
-		pci_dev->driver->driver.alias ? pci_dev->driver->driver.alias : "NA");
-
+		(pci_drv->driver.name != NULL) ? pci_drv->driver.name : "NA",
+		(pci_drv->driver.alias != NULL) ? pci_drv->driver.alias : "NA");
 
 	ret = nthw_pci_dev_init(pci_dev);
 
diff --git a/drivers/raw/cnxk_bphy/cnxk_bphy.c b/drivers/raw/cnxk_bphy/cnxk_bphy.c
index 0c26cfbbe6..ea30a7100c 100644
--- a/drivers/raw/cnxk_bphy/cnxk_bphy.c
+++ b/drivers/raw/cnxk_bphy/cnxk_bphy.c
@@ -351,7 +351,7 @@ bphy_rawdev_probe(struct rte_pci_driver *pci_drv,
 
 	bphy_rawdev->dev_ops = &bphy_rawdev_ops;
 	bphy_rawdev->device = &pci_dev->device;
-	bphy_rawdev->driver_name = pci_dev->driver->driver.name;
+	bphy_rawdev->driver_name = pci_dev->device.driver->name;
 
 	bphy_dev = (struct bphy_device *)bphy_rawdev->dev_private;
 	bphy_dev->mem.res0 = pci_dev->mem_resource[0];
diff --git a/drivers/raw/cnxk_bphy/cnxk_bphy_cgx.c b/drivers/raw/cnxk_bphy/cnxk_bphy_cgx.c
index c82589baa2..e0c7257027 100644
--- a/drivers/raw/cnxk_bphy/cnxk_bphy_cgx.c
+++ b/drivers/raw/cnxk_bphy/cnxk_bphy_cgx.c
@@ -319,7 +319,7 @@ cnxk_bphy_cgx_rawdev_probe(struct rte_pci_driver *pci_drv,
 
 	rawdev->dev_ops = &cnxk_bphy_cgx_rawdev_ops;
 	rawdev->device = &pci_dev->device;
-	rawdev->driver_name = pci_dev->driver->driver.name;
+	rawdev->driver_name = pci_dev->device.driver->name;
 
 	cgx = rawdev->dev_private;
 	cgx->rcgx = rte_zmalloc(NULL, sizeof(*rcgx), 0);
diff --git a/drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c b/drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c
index 60c2080740..57c7cc85f3 100644
--- a/drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c
+++ b/drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c
@@ -210,7 +210,7 @@ rvu_lf_probe(struct rte_pci_driver *pci_drv, struct rte_pci_device *pci_dev)
 
 	rvu_lf_rawdev->dev_ops = &rvu_lf_rawdev_ops;
 	rvu_lf_rawdev->device = &pci_dev->device;
-	rvu_lf_rawdev->driver_name = pci_dev->driver->driver.name;
+	rvu_lf_rawdev->driver_name = pci_dev->device.driver->name;
 
 	roc_rvu_lf = (struct roc_rvu_lf *)rvu_lf_rawdev->dev_private;
 	roc_rvu_lf->pci_dev = pci_dev;
diff --git a/drivers/raw/ifpga/afu_pmd_core.c b/drivers/raw/ifpga/afu_pmd_core.c
index f650b76cfe..ca14ebf52f 100644
--- a/drivers/raw/ifpga/afu_pmd_core.c
+++ b/drivers/raw/ifpga/afu_pmd_core.c
@@ -310,7 +310,7 @@ static int afu_rawdev_create(struct rte_afu_device *afu_dev, int socket_id)
 
 	rawdev->dev_ops = &afu_rawdev_ops;
 	rawdev->device = &afu_dev->device;
-	rawdev->driver_name = afu_dev->driver->driver.name;
+	rawdev->driver_name = afu_dev->device.driver->name;
 
 	dev = afu_rawdev_get_priv(rawdev);
 	if (!dev)
diff --git a/drivers/raw/ifpga/ifpga_rawdev.c b/drivers/raw/ifpga/ifpga_rawdev.c
index d1d54e9065..9f961c943f 100644
--- a/drivers/raw/ifpga/ifpga_rawdev.c
+++ b/drivers/raw/ifpga/ifpga_rawdev.c
@@ -1602,7 +1602,7 @@ ifpga_rawdev_create(struct rte_pci_device *pci_dev,
 
 	rawdev->dev_ops = &ifpga_rawdev_ops;
 	rawdev->device = &pci_dev->device;
-	rawdev->driver_name = pci_dev->driver->driver.name;
+	rawdev->driver_name = pci_dev->device.driver->name;
 
 	/* must enumerate the adapter before use it */
 	ret = opae_adapter_enumerate(adapter);
diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index 0ed4c14592..d54f2fb783 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -1478,7 +1478,7 @@ ntb_create(struct rte_pci_device *pci_dev, int socket_id)
 
 	rawdev->dev_ops = &ntb_ops;
 	rawdev->device = &pci_dev->device;
-	rawdev->driver_name = pci_dev->driver->driver.name;
+	rawdev->driver_name = pci_dev->device.driver->name;
 
 	ret = ntb_init_hw(rawdev, pci_dev);
 	if (ret < 0) {
diff --git a/lib/ethdev/ethdev_pci.h b/lib/ethdev/ethdev_pci.h
index 2229ffa252..ce3e293818 100644
--- a/lib/ethdev/ethdev_pci.h
+++ b/lib/ethdev/ethdev_pci.h
@@ -39,10 +39,13 @@ rte_eth_copy_pci_info(struct rte_eth_dev *eth_dev,
 	eth_dev->intr_handle = pci_dev->intr_handle;
 
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		const struct rte_pci_driver *pci_drv;
+
+		pci_drv = RTE_BUS_DRIVER(pci_dev->device.driver, *pci_drv);
 		eth_dev->data->dev_flags = 0;
-		if (pci_dev->driver->drv_flags & RTE_PCI_DRV_INTR_LSC)
+		if (pci_drv->drv_flags & RTE_PCI_DRV_INTR_LSC)
 			eth_dev->data->dev_flags |= RTE_ETH_DEV_INTR_LSC;
-		if (pci_dev->driver->drv_flags & RTE_PCI_DRV_INTR_RMV)
+		if (pci_drv->drv_flags & RTE_PCI_DRV_INTR_RMV)
 			eth_dev->data->dev_flags |= RTE_ETH_DEV_INTR_RMV;
 
 		eth_dev->data->numa_node = pci_dev->device.numa_node;
-- 
2.53.0

