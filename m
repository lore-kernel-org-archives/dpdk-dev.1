Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E899BCDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 10:44:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4428540A67;
	Wed, 24 Jun 2026 12:44:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6C1A740A79
 for <dev@dpdk.org>; Wed, 24 Jun 2026 12:44:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782297880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=11NzZCmMTIF59ToRxVgQKVauj9yDET1emDakkaDv+5A=;
 b=ClfOxn0BsTMbTMk2lq14Qr32GICJ0bLgkSNI971Qihcc2vqU3PqLXZaEYJBJvl574koEiL
 +tc5v2Ky56d8iDBe8zFoMcCZkEJrQiaSTnMhJB3kfMmpqwh0bF5Z7Cb24I5fR9z0ZbVWBm
 Mippl0F3Ds+uGqvo3FmvlgpHD9hGZDs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-kXCbQadROj-r2mlxkftBSg-1; Wed,
 24 Jun 2026 06:44:33 -0400
X-MC-Unique: kXCbQadROj-r2mlxkftBSg-1
X-Mimecast-MFC-AGG-ID: kXCbQadROj-r2mlxkftBSg_1782297871
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8978819560A7; Wed, 24 Jun 2026 10:44:31 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 47CB330001A7; Wed, 24 Jun 2026 10:44:27 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com, longli@microsoft.com,
 hemant.agrawal@nxp.com, Parav Pandit <parav@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Rosen Xu <rosen.xu@altera.com>, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>,
 Tomasz Duszynski <tduszynski@marvell.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v4 10/12] bus: implement cleanup in EAL
Date: Wed, 24 Jun 2026 12:43:21 +0200
Message-ID: <20260624104324.3576408-11-david.marchand@redhat.com>
In-Reply-To: <20260624104324.3576408-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260624104324.3576408-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FQGcniuFkBYCHAY5dciF9Tu9wNA94gAcP4krovrcqG8_1782297871
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
Update all buses for the new .cleanup and RTE_REGISTER_BUS prototypes.

Convert to rte_bus_generic_cleanup() the buses that have both a .cleanup
and .unplug_device: this requires implementing .free_device for them.

Untouched buses are:
- dma/idxd which has no unplug support,
- bus/cdx which has unplug support, but no cleanup was implemented so
  far,
- NXP buses:
  - bus/dpaa and bus/fslmc have many issues on interrupt
    allocation/setup/freeing or VFIO setup/release,
  - bus/fslmc cleanup callback is actually implemented in its internal
    VFIO layer and requires too much refactoring,

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
Changes since v1:
- dropped hack on using free() and the check in RTE_REGISTER_BUS,

---
 drivers/bus/auxiliary/auxiliary_common.c | 28 ++++---------------
 drivers/bus/dpaa/dpaa_bus.c              |  4 +--
 drivers/bus/fslmc/fslmc_bus.c            |  2 +-
 drivers/bus/ifpga/ifpga_bus.c            | 32 ++++------------------
 drivers/bus/pci/pci_common.c             | 29 +++++---------------
 drivers/bus/platform/platform.c          | 20 ++++----------
 drivers/bus/uacce/uacce.c                | 28 ++++---------------
 drivers/bus/vdev/vdev.c                  | 26 +++++++-----------
 drivers/bus/vmbus/vmbus_common.c         |  6 ++---
 lib/eal/common/eal_common_bus.c          | 33 ++++++++++++++++++++++-
 lib/eal/include/bus_driver.h             | 34 +++++++++++++++++++++++-
 11 files changed, 107 insertions(+), 135 deletions(-)

diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index 10f466e57a..80b90a4961 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -179,29 +179,10 @@ rte_auxiliary_unregister(struct rte_auxiliary_driver *driver)
 	rte_bus_remove_driver(&auxiliary_bus, &driver->driver);
 }
 
-static int
-auxiliary_cleanup(void)
+static void
+auxiliary_free_device(struct rte_device *dev)
 {
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
+	free(RTE_BUS_DEVICE(dev, struct rte_auxiliary_device));
 }
 
 static int
@@ -247,7 +228,8 @@ auxiliary_get_iommu_class(void)
 struct rte_bus auxiliary_bus = {
 	.scan = auxiliary_scan,
 	.probe = rte_bus_generic_probe,
-	.cleanup = auxiliary_cleanup,
+	.free_device = auxiliary_free_device,
+	.cleanup = rte_bus_generic_cleanup,
 	.find_device = rte_bus_generic_find_device,
 	.match = auxiliary_bus_match,
 	.probe_device = auxiliary_probe_device,
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index ee467b94d5..54779f82f7 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -807,12 +807,12 @@ dpaa_bus_probe_device(struct rte_driver *drv, struct rte_device *dev)
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
 
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index dca4c5b182..1a0eca30b4 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -436,7 +436,7 @@ fslmc_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
 }
 
 static int
-rte_fslmc_close(void)
+rte_fslmc_close(struct rte_bus *bus __rte_unused)
 {
 	int ret = 0;
 
diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index 7e2e2efce0..79d1c3778f 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -298,33 +298,10 @@ ifpga_unplug_device(struct rte_device *dev)
 	return 0;
 }
 
-/*
- * Cleanup the content of the Intel FPGA bus, and call the remove() function
- * for all registered devices.
- */
-static int
-ifpga_cleanup(void)
+static void
+ifpga_free_device(struct rte_device *dev)
 {
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
+	free(RTE_BUS_DEVICE(dev, struct rte_afu_device));
 }
 
 static int
@@ -374,7 +351,8 @@ ifpga_parse(const char *name, void *addr)
 static struct rte_bus rte_ifpga_bus = {
 	.scan        = ifpga_scan,
 	.probe       = rte_bus_generic_probe,
-	.cleanup     = ifpga_cleanup,
+	.free_device = ifpga_free_device,
+	.cleanup     = rte_bus_generic_cleanup,
 	.find_device = rte_bus_generic_find_device,
 	.match       = ifpga_bus_match,
 	.probe_device = ifpga_probe_device,
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index bf4822f7ec..0f635e1537 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -317,29 +317,11 @@ pci_unplug_device(struct rte_device *rte_dev)
 	return 0;
 }
 
-static int
-pci_cleanup(void)
+static void
+pci_free_device(struct rte_device *dev)
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
+	struct rte_pci_device *pdev = RTE_BUS_DEVICE(dev, *pdev);
+	pci_free(RTE_PCI_DEVICE_INTERNAL(pdev));
 }
 
 /* dump one device */
@@ -743,7 +725,8 @@ struct rte_bus rte_pci_bus = {
 	.allow_multi_probe = true,
 	.scan = rte_pci_scan,
 	.probe = rte_bus_generic_probe,
-	.cleanup = pci_cleanup,
+	.free_device = pci_free_device,
+	.cleanup = rte_bus_generic_cleanup,
 	.find_device = rte_bus_generic_find_device,
 	.match = pci_bus_match,
 	.probe_device = pci_probe_device,
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 5b3c78a505..90d865a8df 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -491,26 +491,17 @@ platform_bus_get_iommu_class(void)
 	return RTE_IOVA_DC;
 }
 
-static int
-platform_bus_cleanup(void)
+static void
+platform_free_device(struct rte_device *dev)
 {
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
+	free(RTE_BUS_DEVICE(dev, struct rte_platform_device));
 }
 
 static struct rte_bus platform_bus = {
 	.scan = platform_bus_scan,
 	.probe = rte_bus_generic_probe,
+	.free_device = platform_free_device,
+	.cleanup = rte_bus_generic_cleanup,
 	.find_device = rte_bus_generic_find_device,
 	.match = platform_bus_match,
 	.probe_device = platform_bus_probe_device,
@@ -520,7 +511,6 @@ static struct rte_bus platform_bus = {
 	.dma_unmap = platform_bus_dma_unmap,
 	.get_iommu_class = platform_bus_get_iommu_class,
 	.dev_iterate = rte_bus_generic_dev_iterate,
-	.cleanup = platform_bus_cleanup,
 };
 
 RTE_REGISTER_BUS(platform, platform_bus);
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index bfe1f26557..99a6fb314d 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -402,29 +402,10 @@ uacce_unplug_device(struct rte_device *rte_dev)
 	return 0;
 }
 
-static int
-uacce_cleanup(void)
+static void
+uacce_free_device(struct rte_device *dev)
 {
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
+	free(RTE_BUS_DEVICE(dev, struct rte_uacce_device));
 }
 
 static int
@@ -551,7 +532,8 @@ rte_uacce_unregister(struct rte_uacce_driver *driver)
 static struct rte_bus uacce_bus = {
 	.scan = uacce_scan,
 	.probe = rte_bus_generic_probe,
-	.cleanup = uacce_cleanup,
+	.free_device = uacce_free_device,
+	.cleanup = rte_bus_generic_cleanup,
 	.match = uacce_bus_match,
 	.probe_device = uacce_probe_device,
 	.unplug_device = uacce_unplug_device,
diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index 7e94f86e28..02d719a44d 100644
--- a/drivers/bus/vdev/vdev.c
+++ b/drivers/bus/vdev/vdev.c
@@ -548,26 +548,19 @@ vdev_scan(void)
 	return 0;
 }
 
+static void
+vdev_free_device(struct rte_device *dev)
+{
+	free(RTE_BUS_DEVICE(dev, struct rte_vdev_device));
+}
+
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
@@ -608,6 +601,7 @@ vdev_get_iommu_class(void)
 static struct rte_bus rte_vdev_bus = {
 	.scan = vdev_scan,
 	.probe = rte_bus_generic_probe,
+	.free_device = vdev_free_device,
 	.cleanup = vdev_cleanup,
 	.find_device = vdev_find_device,
 	.match = vdev_bus_match,
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index bfb45e963c..a6e3a24a7c 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -144,12 +144,12 @@ rte_vmbus_probe(void)
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
 
@@ -167,7 +167,7 @@ rte_vmbus_cleanup(void)
 		rte_intr_instance_free(dev->intr_handle);
 
 		dev->device.driver = NULL;
-		rte_bus_remove_device(&rte_vmbus_bus, &dev->device);
+		rte_bus_remove_device(bus, &dev->device);
 		free(dev);
 	}
 
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
index fde55ff06d..4f6521c87f 100644
--- a/lib/eal/include/bus_driver.h
+++ b/lib/eal/include/bus_driver.h
@@ -226,17 +226,31 @@ typedef int (*rte_bus_hot_unplug_handler_t)(struct rte_device *dev);
  */
 typedef int (*rte_bus_sigbus_handler_t)(const void *failure_addr);
 
+/**
+ * Free a bus-specific device structure.
+ *
+ * @param dev
+ *	Device pointer.
+ */
+typedef void (*rte_bus_free_device_t)(struct rte_device *dev);
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
@@ -336,6 +350,7 @@ struct rte_bus {
 				/**< handle hot-unplug failure on the bus */
 	rte_bus_sigbus_handler_t sigbus_handler;
 					/**< handle sigbus error on the bus */
+	rte_bus_free_device_t free_device; /**< Free bus-specific device */
 	rte_bus_cleanup_t cleanup;   /**< Cleanup devices on bus */
 	RTE_TAILQ_HEAD(, rte_device) device_list; /**< List of devices on the bus */
 	RTE_TAILQ_HEAD(, rte_driver) driver_list; /**< List of drivers on the bus */
@@ -624,6 +639,23 @@ struct rte_driver *rte_bus_find_driver(const struct rte_bus *bus, const struct r
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
2.54.0

