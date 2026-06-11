Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A0ECD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 09:47:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A360B42FBB;
	Thu, 11 Jun 2026 11:47:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6DF9542FBB
 for <dev@dpdk.org>; Thu, 11 Jun 2026 11:47:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781171227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MUBusnbuGooxXckMBLvd9xdsxQkktw4GUKI78VIpfmU=;
 b=Nm3XN/cpA6vPJS6M6jdMSJhX91nz1xax2D8ywGgYk9NnUtJofXRDcW8ZKZfBtioPMZ0PwP
 euIiKaIa7KQ7++u4e5/uV7hUzn6QyXUBbDEqeRA13LN9biehwNrW7RLzYO85nKLDvzs0Hl
 jalbQ7kS/yoiIDd97n28HxnFnmX712U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-K55NmIDPOxeYjJB27qpxEA-1; Thu,
 11 Jun 2026 05:47:02 -0400
X-MC-Unique: K55NmIDPOxeYjJB27qpxEA-1
X-Mimecast-MFC-AGG-ID: K55NmIDPOxeYjJB27qpxEA_1781171220
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AC2218DB405; Thu, 11 Jun 2026 09:47:00 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.28])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7450E180058C; Thu, 11 Jun 2026 09:46:55 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com,
 Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@altera.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>,
 Kevin Laatz <kevin.laatz@intel.com>
Subject: [PATCH 10/13] bus: implement cleanup in EAL
Date: Thu, 11 Jun 2026 11:45:47 +0200
Message-ID: <20260611094551.1514962-11-david.marchand@redhat.com>
In-Reply-To: <20260611094551.1514962-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: F5k-IGX3b0hLjcUBERFxXa3dppeGgxUGksj_GotGzhA_1781171220
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

Introduce a generic cleanup helper rte_bus_generic_cleanup() that
eliminates code duplication across bus cleanup implementations:
unplug probed devices, remove devargs, remove from bus list,
and free device structures.

Add .free_device operation to struct rte_bus to allow buses to specify
how to free their device structures.
Add compile-time check in RTE_REGISTER_BUS macro to verify rte_device
is at offset 0.

Update all buses for the new .cleanup and RTE_REGISTER_BUS prototypes.

Convert to rte_bus_generic_cleanup() the buses that have both a .cleanup
and .unplug: this requires implementing .free_device for them.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/auxiliary/auxiliary_common.c | 30 ++-----------------
 drivers/bus/cdx/cdx.c                    |  2 +-
 drivers/bus/dpaa/dpaa_bus.c              |  6 ++--
 drivers/bus/fslmc/fslmc_bus.c            |  4 +--
 drivers/bus/ifpga/ifpga_bus.c            | 34 ++-------------------
 drivers/bus/pci/pci_common.c             | 30 ++++---------------
 drivers/bus/platform/platform.c          | 22 ++------------
 drivers/bus/uacce/uacce.c                | 30 ++-----------------
 drivers/bus/vdev/vdev.c                  | 22 ++++----------
 drivers/bus/vmbus/vmbus_common.c         |  8 ++---
 drivers/dma/idxd/idxd_bus.c              |  2 +-
 lib/eal/common/eal_common_bus.c          | 33 +++++++++++++++++++-
 lib/eal/include/bus_driver.h             | 38 ++++++++++++++++++++++--
 13 files changed, 102 insertions(+), 159 deletions(-)

diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index 10f466e57a..6a1fc14d59 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -179,31 +179,6 @@ rte_auxiliary_unregister(struct rte_auxiliary_driver *driver)
 	rte_bus_remove_driver(&auxiliary_bus, &driver->driver);
 }
 
-static int
-auxiliary_cleanup(void)
-{
-	struct rte_auxiliary_device *dev;
-	int error = 0;
-
-	RTE_BUS_FOREACH_DEV(dev, &auxiliary_bus) {
-		int ret;
-
-		if (rte_dev_is_probed(&dev->device)) {
-			ret = auxiliary_unplug_device(&dev->device);
-			if (ret < 0) {
-				rte_errno = errno;
-				error = -1;
-			}
-		}
-
-		rte_devargs_remove(dev->device.devargs);
-		rte_bus_remove_device(&auxiliary_bus, &dev->device);
-		free(dev);
-	}
-
-	return error;
-}
-
 static int
 auxiliary_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 {
@@ -247,7 +222,8 @@ auxiliary_get_iommu_class(void)
 struct rte_bus auxiliary_bus = {
 	.scan = auxiliary_scan,
 	.probe = rte_bus_generic_probe,
-	.cleanup = auxiliary_cleanup,
+	.free_device = free,
+	.cleanup = rte_bus_generic_cleanup,
 	.find_device = rte_bus_generic_find_device,
 	.match = auxiliary_bus_match,
 	.probe_device = auxiliary_probe_device,
@@ -259,5 +235,5 @@ struct rte_bus auxiliary_bus = {
 	.dev_iterate = rte_bus_generic_dev_iterate,
 };
 
-RTE_REGISTER_BUS(auxiliary, auxiliary_bus);
+RTE_REGISTER_BUS(auxiliary, auxiliary_bus, struct rte_auxiliary_device);
 RTE_LOG_REGISTER_DEFAULT(auxiliary_bus_logtype, NOTICE);
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index c0b46a41ad..d070e3b2a8 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -439,5 +439,5 @@ static struct rte_bus rte_cdx_bus = {
 	.dev_iterate = rte_bus_generic_dev_iterate,
 };
 
-RTE_REGISTER_BUS(cdx, rte_cdx_bus);
+RTE_REGISTER_BUS(cdx, rte_cdx_bus, struct rte_cdx_device);
 RTE_LOG_REGISTER_DEFAULT(cdx_logtype_bus, NOTICE);
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 3915e0a8b7..69f071d007 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -785,12 +785,12 @@ dpaa_bus_probe_device(struct rte_driver *drv, struct rte_device *dev)
 }
 
 static int
-dpaa_bus_cleanup(void)
+dpaa_bus_cleanup(struct rte_bus *bus)
 {
 	struct rte_dpaa_device *dev;
 
 	BUS_INIT_FUNC_TRACE();
-	RTE_BUS_FOREACH_DEV(dev, &rte_dpaa_bus) {
+	RTE_BUS_FOREACH_DEV(dev, bus) {
 		const struct rte_dpaa_driver *drv;
 		int ret = 0;
 
@@ -853,5 +853,5 @@ static struct rte_dpaa_bus_private dpaa_bus = {
 	.device_count = 0,
 };
 
-RTE_REGISTER_BUS(dpaa_bus, rte_dpaa_bus);
+RTE_REGISTER_BUS(dpaa_bus, rte_dpaa_bus, struct rte_dpaa_device);
 RTE_LOG_REGISTER_DEFAULT(dpaa_logtype_bus, NOTICE);
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 15164796ec..17350d69b8 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -414,7 +414,7 @@ fslmc_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
 }
 
 static int
-rte_fslmc_close(void)
+rte_fslmc_close(struct rte_bus *bus __rte_unused)
 {
 	int ret = 0;
 
@@ -549,5 +549,5 @@ struct rte_bus rte_fslmc_bus = {
 	.dev_iterate = rte_bus_generic_dev_iterate,
 };
 
-RTE_REGISTER_BUS(fslmc, rte_fslmc_bus);
+RTE_REGISTER_BUS(fslmc, rte_fslmc_bus, struct rte_dpaa2_device);
 RTE_LOG_REGISTER_DEFAULT(dpaa2_logtype_bus, NOTICE);
diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index 394b777916..e62cf371bd 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -295,35 +295,6 @@ ifpga_unplug_device(struct rte_device *dev)
 	return 0;
 }
 
-/*
- * Cleanup the content of the Intel FPGA bus, and call the remove() function
- * for all registered devices.
- */
-static int
-ifpga_cleanup(void)
-{
-	struct rte_afu_device *afu_dev;
-	int error = 0;
-
-	RTE_BUS_FOREACH_DEV(afu_dev, &rte_ifpga_bus) {
-		int ret = 0;
-
-		if (rte_dev_is_probed(&afu_dev->device)) {
-			ret = ifpga_unplug_device(&afu_dev->device);
-			if (ret < 0) {
-				rte_errno = errno;
-				error = -1;
-			}
-		}
-
-		rte_devargs_remove(afu_dev->device.devargs);
-		rte_bus_remove_device(&rte_ifpga_bus, &afu_dev->device);
-		free(afu_dev);
-	}
-
-	return error;
-}
-
 static int
 ifpga_parse(const char *name, void *addr)
 {
@@ -371,7 +342,8 @@ ifpga_parse(const char *name, void *addr)
 static struct rte_bus rte_ifpga_bus = {
 	.scan        = ifpga_scan,
 	.probe       = rte_bus_generic_probe,
-	.cleanup     = ifpga_cleanup,
+	.free_device = free,
+	.cleanup     = rte_bus_generic_cleanup,
 	.find_device = rte_bus_generic_find_device,
 	.match       = ifpga_bus_match,
 	.probe_device = ifpga_probe_device,
@@ -379,7 +351,7 @@ static struct rte_bus rte_ifpga_bus = {
 	.parse       = ifpga_parse,
 };
 
-RTE_REGISTER_BUS(ifpga, rte_ifpga_bus);
+RTE_REGISTER_BUS(ifpga, rte_ifpga_bus, struct rte_afu_device);
 RTE_INIT(ifpga_bus_init)
 {
 	RTE_VERIFY(strcmp(rte_ifpga_bus.name, RTE_STR(IFPGA_BUS_NAME)) == 0);
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index bf4822f7ec..dcc94b6bbd 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -317,29 +317,10 @@ pci_unplug_device(struct rte_device *rte_dev)
 	return 0;
 }
 
-static int
-pci_cleanup(void)
+static void
+pci_free_device(void *dev)
 {
-	struct rte_pci_device *dev;
-	int error = 0;
-
-	RTE_BUS_FOREACH_DEV(dev, &rte_pci_bus) {
-		int ret = 0;
-
-		if (rte_dev_is_probed(&dev->device)) {
-			ret = pci_unplug_device(&dev->device);
-			if (ret < 0) {
-				rte_errno = errno;
-				error = -1;
-			}
-		}
-
-		rte_devargs_remove(dev->device.devargs);
-		rte_bus_remove_device(&rte_pci_bus, &dev->device);
-		pci_free(RTE_PCI_DEVICE_INTERNAL(dev));
-	}
-
-	return error;
+	pci_free(RTE_PCI_DEVICE_INTERNAL(dev));
 }
 
 /* dump one device */
@@ -743,7 +724,8 @@ struct rte_bus rte_pci_bus = {
 	.allow_multi_probe = true,
 	.scan = rte_pci_scan,
 	.probe = rte_bus_generic_probe,
-	.cleanup = pci_cleanup,
+	.free_device = pci_free_device,
+	.cleanup = rte_bus_generic_cleanup,
 	.find_device = rte_bus_generic_find_device,
 	.match = pci_bus_match,
 	.probe_device = pci_probe_device,
@@ -759,5 +741,5 @@ struct rte_bus rte_pci_bus = {
 	.sigbus_handler = pci_sigbus_handler,
 };
 
-RTE_REGISTER_BUS(pci, rte_pci_bus);
+RTE_REGISTER_BUS(pci, rte_pci_bus, struct rte_pci_device);
 RTE_LOG_REGISTER_DEFAULT(pci_bus_logtype, NOTICE);
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 5b3c78a505..cb315144b8 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -491,26 +491,11 @@ platform_bus_get_iommu_class(void)
 	return RTE_IOVA_DC;
 }
 
-static int
-platform_bus_cleanup(void)
-{
-	struct rte_platform_device *pdev;
-
-	RTE_BUS_FOREACH_DEV(pdev, &platform_bus) {
-		if (rte_dev_is_probed(&pdev->device))
-			platform_bus_unplug_device(&pdev->device);
-
-		rte_devargs_remove(pdev->device.devargs);
-		rte_bus_remove_device(&platform_bus, &pdev->device);
-		free(pdev);
-	}
-
-	return 0;
-}
-
 static struct rte_bus platform_bus = {
 	.scan = platform_bus_scan,
 	.probe = rte_bus_generic_probe,
+	.free_device = free,
+	.cleanup = rte_bus_generic_cleanup,
 	.find_device = rte_bus_generic_find_device,
 	.match = platform_bus_match,
 	.probe_device = platform_bus_probe_device,
@@ -520,8 +505,7 @@ static struct rte_bus platform_bus = {
 	.dma_unmap = platform_bus_dma_unmap,
 	.get_iommu_class = platform_bus_get_iommu_class,
 	.dev_iterate = rte_bus_generic_dev_iterate,
-	.cleanup = platform_bus_cleanup,
 };
 
-RTE_REGISTER_BUS(platform, platform_bus);
+RTE_REGISTER_BUS(platform, platform_bus, struct rte_platform_device);
 RTE_LOG_REGISTER_DEFAULT(platform_bus_logtype, NOTICE);
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index bfe1f26557..e2763b26d5 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -402,31 +402,6 @@ uacce_unplug_device(struct rte_device *rte_dev)
 	return 0;
 }
 
-static int
-uacce_cleanup(void)
-{
-	struct rte_uacce_device *dev;
-	int error = 0;
-
-	RTE_BUS_FOREACH_DEV(dev, &uacce_bus) {
-		int ret = 0;
-
-		if (rte_dev_is_probed(&dev->device)) {
-			ret = uacce_unplug_device(&dev->device);
-			if (ret < 0) {
-				rte_errno = errno;
-				error = -1;
-			}
-		}
-
-		rte_devargs_remove(dev->device.devargs);
-		rte_bus_remove_device(&uacce_bus, &dev->device);
-		free(dev);
-	}
-
-	return error;
-}
-
 static int
 uacce_parse(const char *name, void *addr)
 {
@@ -551,7 +526,8 @@ rte_uacce_unregister(struct rte_uacce_driver *driver)
 static struct rte_bus uacce_bus = {
 	.scan = uacce_scan,
 	.probe = rte_bus_generic_probe,
-	.cleanup = uacce_cleanup,
+	.free_device = free,
+	.cleanup = rte_bus_generic_cleanup,
 	.match = uacce_bus_match,
 	.probe_device = uacce_probe_device,
 	.unplug_device = uacce_unplug_device,
@@ -560,5 +536,5 @@ static struct rte_bus uacce_bus = {
 	.dev_iterate = rte_bus_generic_dev_iterate,
 };
 
-RTE_REGISTER_BUS(uacce, uacce_bus);
+RTE_REGISTER_BUS(uacce, uacce_bus, struct rte_uacce_device);
 RTE_LOG_REGISTER_DEFAULT(uacce_bus_logtype, NOTICE);
diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index c2cd642119..bb536803e4 100644
--- a/drivers/bus/vdev/vdev.c
+++ b/drivers/bus/vdev/vdev.c
@@ -548,25 +548,12 @@ vdev_scan(void)
 }
 
 static int
-vdev_cleanup(void)
+vdev_cleanup(struct rte_bus *bus)
 {
-	struct rte_vdev_device *dev;
-	int error = 0;
+	int error;
 
 	rte_spinlock_recursive_lock(&vdev_device_list_lock);
-	RTE_BUS_FOREACH_DEV(dev, &rte_vdev_bus) {
-		int ret;
-
-		if (rte_dev_is_probed(&dev->device)) {
-			ret = vdev_unplug_device(&dev->device);
-			if (ret < 0)
-				error = -1;
-		}
-
-		rte_devargs_remove(dev->device.devargs);
-		rte_bus_remove_device(&rte_vdev_bus, &dev->device);
-		free(dev);
-	}
+	error = rte_bus_generic_cleanup(bus);
 	rte_spinlock_recursive_unlock(&vdev_device_list_lock);
 
 	return error;
@@ -607,6 +594,7 @@ vdev_get_iommu_class(void)
 static struct rte_bus rte_vdev_bus = {
 	.scan = vdev_scan,
 	.probe = rte_bus_generic_probe,
+	.free_device = free,
 	.cleanup = vdev_cleanup,
 	.find_device = vdev_find_device,
 	.match = vdev_bus_match,
@@ -619,5 +607,5 @@ static struct rte_bus rte_vdev_bus = {
 	.dev_iterate = rte_bus_generic_dev_iterate,
 };
 
-RTE_REGISTER_BUS(vdev, rte_vdev_bus);
+RTE_REGISTER_BUS(vdev, rte_vdev_bus, struct rte_vdev_device);
 RTE_LOG_REGISTER_DEFAULT(vdev_logtype_bus, NOTICE);
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index b6ae82915f..4c4170a4b5 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -146,12 +146,12 @@ rte_vmbus_probe(void)
 }
 
 static int
-rte_vmbus_cleanup(void)
+rte_vmbus_cleanup(struct rte_bus *bus)
 {
 	struct rte_vmbus_device *dev;
 	int error = 0;
 
-	RTE_BUS_FOREACH_DEV(dev, &rte_vmbus_bus) {
+	RTE_BUS_FOREACH_DEV(dev, bus) {
 		const struct rte_vmbus_driver *drv;
 		int ret;
 
@@ -169,7 +169,7 @@ rte_vmbus_cleanup(void)
 		rte_intr_instance_free(dev->intr_handle);
 
 		dev->device.driver = NULL;
-		rte_bus_remove_device(&rte_vmbus_bus, &dev->device);
+		rte_bus_remove_device(bus, &dev->device);
 		free(dev);
 	}
 
@@ -232,5 +232,5 @@ struct rte_bus rte_vmbus_bus = {
 	.dev_compare = vmbus_dev_compare,
 };
 
-RTE_REGISTER_BUS(vmbus, rte_vmbus_bus);
+RTE_REGISTER_BUS(vmbus, rte_vmbus_bus, struct rte_vmbus_device);
 RTE_LOG_REGISTER_DEFAULT(vmbus_logtype_bus, NOTICE);
diff --git a/drivers/dma/idxd/idxd_bus.c b/drivers/dma/idxd/idxd_bus.c
index 2ec526ec09..34fd9f90c9 100644
--- a/drivers/dma/idxd/idxd_bus.c
+++ b/drivers/dma/idxd/idxd_bus.c
@@ -346,7 +346,7 @@ dsa_addr_parse(const char *name, void *addr)
 	return 0;
 }
 
-RTE_REGISTER_BUS(dsa, dsa_bus);
+RTE_REGISTER_BUS(dsa, dsa_bus, struct rte_dsa_device);
 RTE_INIT(dsa_bus_init)
 {
 	rte_bus_add_driver(&dsa_bus, &dsa_driver);
diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
index ca13ccce5b..9ba23516ee 100644
--- a/lib/eal/common/eal_common_bus.c
+++ b/lib/eal/common/eal_common_bus.c
@@ -124,6 +124,37 @@ rte_bus_generic_probe(struct rte_bus *bus)
 	return (probed && probed == failed) ? -1 : 0;
 }
 
+/*
+ * Generic cleanup function for buses.
+ * Iterates through all devices on the bus, unplugs probed devices,
+ * removes devargs, removes devices from the bus list, and frees device structures.
+ */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_generic_cleanup)
+int
+rte_bus_generic_cleanup(struct rte_bus *bus)
+{
+	struct rte_device *dev;
+	int error = 0;
+
+	RTE_VERIFY(bus->free_device);
+	RTE_VERIFY(bus->unplug_device);
+
+	while ((dev = TAILQ_FIRST(&bus->device_list)) != NULL) {
+		if (rte_dev_is_probed(dev)) {
+			if (bus->unplug_device && bus->unplug_device(dev) < 0) {
+				rte_errno = errno;
+				error = -1;
+			}
+		}
+
+		rte_devargs_remove(dev->devargs);
+		rte_bus_remove_device(bus, dev);
+		bus->free_device(dev);
+	}
+
+	return error;
+}
+
 /* Probe all devices of all buses */
 RTE_EXPORT_SYMBOL(rte_bus_probe)
 int
@@ -164,7 +195,7 @@ eal_bus_cleanup(void)
 	TAILQ_FOREACH(bus, &rte_bus_list, next) {
 		if (bus->cleanup == NULL)
 			continue;
-		if (bus->cleanup() != 0)
+		if (bus->cleanup(bus) != 0)
 			ret = -1;
 	}
 
diff --git a/lib/eal/include/bus_driver.h b/lib/eal/include/bus_driver.h
index 1baf024539..c7b956833c 100644
--- a/lib/eal/include/bus_driver.h
+++ b/lib/eal/include/bus_driver.h
@@ -6,6 +6,7 @@
 #define BUS_DRIVER_H
 
 #include <rte_bus.h>
+#include <rte_common.h>
 #include <rte_compat.h>
 #include <rte_dev.h>
 #include <rte_eal.h>
@@ -239,17 +240,31 @@ typedef int (*rte_bus_hot_unplug_handler_t)(struct rte_device *dev);
  */
 typedef int (*rte_bus_sigbus_handler_t)(const void *failure_addr);
 
+/**
+ * Free a bus-specific device structure.
+ *
+ * @param device
+ *	Generic device pointer to free (will be cast to bus-specific type).
+ */
+typedef void (*rte_bus_free_device_t)(void *device);
+
 /**
  * Implementation specific cleanup function which is responsible for cleaning up
  * devices on that bus with applicable drivers.
  *
+ * The cleanup operation is the counterpart to scan, removing all devices added
+ * during scan.
+ *
  * This is called while iterating over each registered bus.
  *
+ * @param bus
+ *   Pointer to the bus to cleanup.
+ *
  * @return
  * 0 for successful cleanup
  * !0 for any error during cleanup
  */
-typedef int (*rte_bus_cleanup_t)(void);
+typedef int (*rte_bus_cleanup_t)(struct rte_bus *bus);
 
 /**
  * Check if a driver matches a device.
@@ -349,6 +364,7 @@ struct rte_bus {
 				/**< handle hot-unplug failure on the bus */
 	rte_bus_sigbus_handler_t sigbus_handler;
 					/**< handle sigbus error on the bus */
+	rte_bus_free_device_t free_device; /**< Free bus-specific device */
 	rte_bus_cleanup_t cleanup;   /**< Cleanup devices on bus */
 	RTE_TAILQ_HEAD(, rte_device) device_list; /**< List of devices on the bus */
 	RTE_TAILQ_HEAD(, rte_driver) driver_list; /**< List of drivers on the bus */
@@ -414,9 +430,10 @@ void *rte_bus_generic_dev_iterate(const struct rte_bus *bus,
  * Helper for Bus registration.
  * The constructor has higher priority than PMD constructors.
  */
-#define RTE_REGISTER_BUS(nm, bus) \
+#define RTE_REGISTER_BUS(nm, bus, bus_dev_type) \
 RTE_INIT_PRIO(businitfn_ ##nm, BUS) \
 {\
+	RTE_BUILD_BUG_ON(offsetof(typeof(bus_dev_type), device) != 0); \
 	(bus).name = RTE_STR(nm);\
 	rte_bus_register(&bus); \
 }
@@ -637,6 +654,23 @@ struct rte_driver *rte_bus_find_driver(const struct rte_bus *bus, const struct r
 __rte_internal
 int rte_bus_generic_probe(struct rte_bus *bus);
 
+/**
+ * Generic cleanup function for buses.
+ *
+ * Iterates through all devices on the bus, unplugs probed devices,
+ * removes devargs, removes devices from the bus list, and frees device structures.
+ *
+ * This function can be used by buses that don't require special cleanup
+ * logic and just need the standard device cleanup sequence.
+ *
+ * @param bus
+ *   Pointer to the bus to cleanup.
+ * @return
+ *   0 on success, -1 if any errors occurred during cleanup.
+ */
+__rte_internal
+int rte_bus_generic_cleanup(struct rte_bus *bus);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.53.0

