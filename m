Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED4DC98318
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 16:15:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B81C43287;
	Thu, 24 Sep 2026 18:14:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 1774C43262
 for <dev@dpdk.org>; Thu, 24 Sep 2026 18:13:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790266440; x=1821802440;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=IRymRcSwBner75fJcA3Nt8fvjcwf6TgKQd3EG4mipto=;
 b=bZY4sW11Ij2hQg/LU/dGyvDyJ9WQc2mG6RB4vSRHj4YxD1OWqxd2+CL0
 V39iQIeLDmGOTyk29NJL956e3laH6v3RjjlXQJ13r4bsMFoBP/KlqBb3I
 cF02FMzVEznXqwEYruJWXaVPhD1vmyDnX4Txc0KhVbseyEv8hK7CgMLwD
 Xzpzix2hHqjMlqreJ3Y2DO/fQv9KHUs1ARPI0w2GoxhCPxC0RU+MuMJ/b
 79rRkxrYwz4+zl/e7epdL+Vud5FfM5DdJaQM6nJcUOIata/NnF3MQXRqb
 Ufu3rq+IYFuIj1w3EPj5lOIUGXNUmfJBzF8tq7sMTPeiQbGy0WDfgJxAF Q==;
X-CSE-ConnectionGUID: T9K5vDxIRpGqdumBdUq2GQ==
X-CSE-MsgGUID: IAcKay4DS5eko0bkGqOP9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90000656"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90000656"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 09:13:59 -0700
X-CSE-ConnectionGUID: t0s4Efm8Qiun0Ba7FhITmg==
X-CSE-MsgGUID: jf+AoGyFQx+HG79Kc0ZFPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="277830024"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 24 Sep 2026 09:13:58 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v18 10/29] bus/pci: decouple PCI bus driver from VFIO
Date: Thu, 24 Sep 2026 17:13:17 +0100
Message-ID: <ae4246a31de53f02662fde24ff3d93dea02a6216.1790266166.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1790266165.git.anatoly.burakov@intel.com>
 <cover.1790266165.git.anatoly.burakov@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Currently, because the PCI bus driver will use VFIO API and the bus
driver definitions are shared across OS's, this results in each PCI bus
driver linking to VFIO API even though only Linux needs it.

To fix it, move OS-specific PCI bus driver definitions into their
respective source files (so that each bus still shares common driver op
implementations), and only call VFIO API on Linux with a custom DMA map op
implementation. This allows us to remove all of the VFIO stubs from
non-Linux EAL code.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/pci/bsd/pci.c     |  24 ++++++
 drivers/bus/pci/linux/pci.c   |  55 +++++++++++++
 drivers/bus/pci/pci_common.c  |  64 +++-------------
 drivers/bus/pci/private.h     | 132 ++++++++++++++++++++++++++++++++
 drivers/bus/pci/windows/pci.c |  24 ++++++
 lib/eal/freebsd/eal.c         | 140 ----------------------------------
 lib/eal/windows/eal.c         |  29 -------
 7 files changed, 247 insertions(+), 221 deletions(-)

diff --git a/drivers/bus/pci/bsd/pci.c b/drivers/bus/pci/bsd/pci.c
index c6df31d4869..22655b19f4d 100644
--- a/drivers/bus/pci/bsd/pci.c
+++ b/drivers/bus/pci/bsd/pci.c
@@ -665,3 +665,27 @@ rte_pci_ioport_unmap(struct rte_pci_ioport *p)
 
 	return ret;
 }
+
+struct rte_bus rte_pci_bus = {
+	.allow_multi_probe = true,
+	.scan = rte_pci_scan,
+	.probe = rte_bus_generic_probe,
+	.free_device = pci_free_device,
+	.cleanup = rte_bus_generic_cleanup,
+	.find_device = rte_bus_generic_find_device,
+	.match = pci_bus_match,
+	.probe_device = pci_probe_device,
+	.unplug_device = pci_unplug_device,
+	.parse = pci_parse,
+	.dev_compare = pci_dev_compare,
+	.devargs_parse = rte_pci_devargs_parse,
+	.dma_map = pci_common_dma_map,
+	.dma_unmap = pci_common_dma_unmap,
+	.get_iommu_class = rte_pci_get_iommu_class,
+	.dev_iterate = rte_pci_dev_iterate,
+	.hot_unplug_handler = pci_hot_unplug_handler,
+	.sigbus_handler = pci_sigbus_handler,
+};
+
+RTE_REGISTER_BUS(pci, rte_pci_bus);
+RTE_LOG_REGISTER_DEFAULT(pci_bus_logtype, NOTICE);
diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index 9aae0a5d14a..008e08e71fe 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -5,6 +5,7 @@
 #include <string.h>
 #include <dirent.h>
 
+#include <rte_errno.h>
 #include <rte_log.h>
 #include <rte_pci.h>
 #include <rte_bus_pci.h>
@@ -19,6 +20,36 @@
 #include "private.h"
 #include "pci_init.h"
 
+static int
+pci_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
+{
+	struct rte_pci_device *pdev = RTE_BUS_DEVICE(dev, *pdev);
+	const struct rte_pci_driver *pdrv = RTE_BUS_DRIVER(dev->driver, *pdrv);
+
+	if (pdrv->dma_map != NULL)
+		return pci_common_dma_map(dev, addr, iova, len);
+	if (pdev->kdrv == RTE_PCI_KDRV_VFIO)
+		return rte_vfio_container_dma_map(RTE_VFIO_DEFAULT_CONTAINER_FD,
+				(uintptr_t)addr, iova, len);
+	rte_errno = ENOTSUP;
+	return -1;
+}
+
+static int
+pci_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
+{
+	struct rte_pci_device *pdev = RTE_BUS_DEVICE(dev, *pdev);
+	const struct rte_pci_driver *pdrv = RTE_BUS_DRIVER(dev->driver, *pdrv);
+
+	if (pdrv->dma_unmap != NULL)
+		return pci_common_dma_unmap(dev, addr, iova, len);
+	if (pdev->kdrv == RTE_PCI_KDRV_VFIO)
+		return rte_vfio_container_dma_unmap(RTE_VFIO_DEFAULT_CONTAINER_FD,
+				(uintptr_t)addr, iova, len);
+	rte_errno = ENOTSUP;
+	return -1;
+}
+
 /**
  * @file
  * PCI probing using Linux sysfs.
@@ -790,3 +821,27 @@ rte_pci_ioport_unmap(struct rte_pci_ioport *p)
 
 	return ret;
 }
+
+struct rte_bus rte_pci_bus = {
+	.allow_multi_probe = true,
+	.scan = rte_pci_scan,
+	.probe = rte_bus_generic_probe,
+	.free_device = pci_free_device,
+	.cleanup = rte_bus_generic_cleanup,
+	.find_device = rte_bus_generic_find_device,
+	.match = pci_bus_match,
+	.probe_device = pci_probe_device,
+	.unplug_device = pci_unplug_device,
+	.parse = pci_parse,
+	.dev_compare = pci_dev_compare,
+	.devargs_parse = rte_pci_devargs_parse,
+	.dma_map = pci_dma_map,
+	.dma_unmap = pci_dma_unmap,
+	.get_iommu_class = rte_pci_get_iommu_class,
+	.dev_iterate = rte_pci_dev_iterate,
+	.hot_unplug_handler = pci_hot_unplug_handler,
+	.sigbus_handler = pci_sigbus_handler,
+};
+
+RTE_REGISTER_BUS(pci, rte_pci_bus);
+RTE_LOG_REGISTER_DEFAULT(pci_bus_logtype, NOTICE);
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index dc8db80d3b9..097f96e030a 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -25,7 +25,6 @@
 #include <rte_string_fns.h>
 #include <rte_common.h>
 #include <rte_devargs.h>
-#include <rte_vfio.h>
 #include <rte_tailq.h>
 
 #include "private.h"
@@ -142,7 +141,7 @@ pci_unmap_resource(void *requested_addr, size_t size)
 		PCI_LOG(DEBUG, "  PCI memory unmapped at %p", requested_addr);
 }
 
-static bool
+bool
 pci_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
 {
 	const struct rte_pci_driver *pci_drv = RTE_BUS_DRIVER(drv, *pci_drv);
@@ -180,7 +179,7 @@ pci_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
  * If vendor/device ID match, call the probe() function of the
  * driver.
  */
-static int
+int
 pci_probe_device(struct rte_driver *drv, struct rte_device *dev)
 {
 	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(dev, *pci_dev);
@@ -275,7 +274,7 @@ pci_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	return ret;
 }
 
-static int
+int
 pci_unplug_device(struct rte_device *rte_dev)
 {
 	struct rte_pci_device *dev = RTE_BUS_DEVICE(rte_dev, *dev);
@@ -310,7 +309,7 @@ pci_unplug_device(struct rte_device *rte_dev)
 	return 0;
 }
 
-static void
+void
 pci_free_device(struct rte_device *dev)
 {
 	struct rte_pci_device *pdev = RTE_BUS_DEVICE(dev, *pdev);
@@ -349,7 +348,7 @@ rte_pci_dump(FILE *f)
 	}
 }
 
-static int
+int
 pci_parse(const char *name, void *addr)
 {
 	struct rte_pci_addr *out = addr;
@@ -362,7 +361,7 @@ pci_parse(const char *name, void *addr)
 	return parse == false;
 }
 
-static int
+int
 pci_dev_compare(const char *name1, const char *name2)
 {
 	struct rte_pci_addr addr1, addr2;
@@ -420,7 +419,7 @@ pci_find_device_by_addr(const void *failure_addr)
 	return NULL;
 }
 
-static int
+int
 pci_hot_unplug_handler(struct rte_device *dev)
 {
 	struct rte_pci_device *pdev = RTE_BUS_DEVICE(dev, *pdev);
@@ -452,7 +451,7 @@ pci_hot_unplug_handler(struct rte_device *dev)
 	return ret;
 }
 
-static int
+int
 pci_sigbus_handler(const void *failure_addr)
 {
 	struct rte_pci_device *pdev = NULL;
@@ -474,42 +473,26 @@ pci_sigbus_handler(const void *failure_addr)
 	return ret;
 }
 
-static int
-pci_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
+int
+pci_common_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 {
 	struct rte_pci_device *pdev = RTE_BUS_DEVICE(dev, *pdev);
 	const struct rte_pci_driver *pdrv = RTE_BUS_DRIVER(dev->driver, *pdrv);
 
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
 	rte_errno = ENOTSUP;
 	return -1;
 }
 
-static int
-pci_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
+int
+pci_common_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 {
 	struct rte_pci_device *pdev = RTE_BUS_DEVICE(dev, *pdev);
 	const struct rte_pci_driver *pdrv = RTE_BUS_DRIVER(dev->driver, *pdrv);
 
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
@@ -714,26 +697,3 @@ rte_pci_pasid_set_state(const struct rte_pci_device *dev,
 			offset + RTE_PCI_PASID_CTRL) != sizeof(pasid) ? -1 : 0;
 }
 
-struct rte_bus rte_pci_bus = {
-	.allow_multi_probe = true,
-	.scan = rte_pci_scan,
-	.probe = rte_bus_generic_probe,
-	.free_device = pci_free_device,
-	.cleanup = rte_bus_generic_cleanup,
-	.find_device = rte_bus_generic_find_device,
-	.match = pci_bus_match,
-	.probe_device = pci_probe_device,
-	.unplug_device = pci_unplug_device,
-	.parse = pci_parse,
-	.dev_compare = pci_dev_compare,
-	.devargs_parse = rte_pci_devargs_parse,
-	.dma_map = pci_dma_map,
-	.dma_unmap = pci_dma_unmap,
-	.get_iommu_class = rte_pci_get_iommu_class,
-	.dev_iterate = rte_pci_dev_iterate,
-	.hot_unplug_handler = pci_hot_unplug_handler,
-	.sigbus_handler = pci_sigbus_handler,
-};
-
-RTE_REGISTER_BUS(pci, rte_pci_bus);
-RTE_LOG_REGISTER_DEFAULT(pci_bus_logtype, NOTICE);
diff --git a/drivers/bus/pci/private.h b/drivers/bus/pci/private.h
index 8103c32881b..43950ff544c 100644
--- a/drivers/bus/pci/private.h
+++ b/drivers/bus/pci/private.h
@@ -272,4 +272,136 @@ rte_pci_dev_iterate(const struct rte_bus *bus,
 int
 rte_pci_devargs_parse(struct rte_devargs *da);
 
+/**
+ * Check whether a PCI driver matches a PCI device.
+ *
+ * @param drv
+ *   PCI driver to check.
+ * @param dev
+ *   PCI device to check.
+ *
+ * @return
+ *   true if the driver matches the device, false otherwise.
+ */
+bool pci_bus_match(const struct rte_driver *drv,
+		const struct rte_device *dev);
+
+/**
+ * Probe a PCI device with a matching driver.
+ *
+ * @param drv
+ *   PCI driver to use for probing.
+ * @param dev
+ *   PCI device to probe.
+ *
+ * @return
+ *   0 on success, negative value on error.
+ */
+int pci_probe_device(struct rte_driver *drv, struct rte_device *dev);
+
+/**
+ * Remove a PCI device from its driver.
+ *
+ * @param dev
+ *   PCI device to remove.
+ *
+ * @return
+ *   0 on success, negative value on error.
+ */
+int pci_unplug_device(struct rte_device *dev);
+
+/**
+ * Free a PCI device and its private data.
+ *
+ * @param dev
+ *   PCI device to free.
+ */
+void pci_free_device(struct rte_device *dev);
+
+/**
+ * Parse a PCI device name.
+ *
+ * @param name
+ *   PCI device name to parse.
+ * @param addr
+ *   Pointer to where the parsed address will be stored.
+ *
+ * @return
+ *   0 on success, negative value on error.
+ */
+int pci_parse(const char *name, void *addr);
+
+/**
+ * Compare two PCI device names.
+ *
+ * @param name1
+ *   First PCI device name.
+ * @param name2
+ *   Second PCI device name.
+ *
+ * @return
+ *   0 if the names identify the same device, non-zero otherwise.
+ */
+int pci_dev_compare(const char *name1, const char *name2);
+
+/**
+ * Handle hot-unplug events for a PCI device.
+ *
+ * @param dev
+ *   PCI device associated with the event.
+ *
+ * @return
+ *   0 on success, negative value on error.
+ */
+int pci_hot_unplug_handler(struct rte_device *dev);
+
+/**
+ * Handle a SIGBUS associated with a PCI device.
+ *
+ * @param failure_addr
+ *   Address associated with the SIGBUS.
+ *
+ * @return
+ *   0 if the event was handled, negative value on error.
+ */
+int pci_sigbus_handler(const void *failure_addr);
+
+/**
+ * Map memory for a PCI device using its driver callback.
+ *
+ * @param dev
+ *   PCI device to map memory for.
+ * @param addr
+ *   Virtual address of the memory to map.
+ * @param iova
+ *   IOVA address to map.
+ * @param len
+ *   Length of the memory segment to map.
+ *
+ * @return
+ *   0 on success, negative value on error. Returns -ENOTSUP if the driver
+ *   does not provide a DMA map callback.
+ */
+int pci_common_dma_map(struct rte_device *dev, void *addr, uint64_t iova,
+		size_t len);
+
+/**
+ * Unmap memory for a PCI device using its driver callback.
+ *
+ * @param dev
+ *   PCI device to unmap memory for.
+ * @param addr
+ *   Virtual address of the memory to unmap.
+ * @param iova
+ *   IOVA address to unmap.
+ * @param len
+ *   Length of the memory segment to unmap.
+ *
+ * @return
+ *   0 on success, negative value on error. Returns -ENOTSUP if the driver
+ *   does not provide a DMA unmap callback.
+ */
+int pci_common_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova,
+		size_t len);
+
 #endif /* _PCI_PRIVATE_H_ */
diff --git a/drivers/bus/pci/windows/pci.c b/drivers/bus/pci/windows/pci.c
index 7b51301d1e7..236336552cd 100644
--- a/drivers/bus/pci/windows/pci.c
+++ b/drivers/bus/pci/windows/pci.c
@@ -512,3 +512,27 @@ rte_pci_scan(void)
 
 	return ret;
 }
+
+struct rte_bus rte_pci_bus = {
+	.allow_multi_probe = true,
+	.scan = rte_pci_scan,
+	.probe = rte_bus_generic_probe,
+	.free_device = pci_free_device,
+	.cleanup = rte_bus_generic_cleanup,
+	.find_device = rte_bus_generic_find_device,
+	.match = pci_bus_match,
+	.probe_device = pci_probe_device,
+	.unplug_device = pci_unplug_device,
+	.parse = pci_parse,
+	.dev_compare = pci_dev_compare,
+	.devargs_parse = rte_pci_devargs_parse,
+	.dma_map = pci_common_dma_map,
+	.dma_unmap = pci_common_dma_unmap,
+	.get_iommu_class = rte_pci_get_iommu_class,
+	.dev_iterate = rte_pci_dev_iterate,
+	.hot_unplug_handler = pci_hot_unplug_handler,
+	.sigbus_handler = pci_sigbus_handler,
+};
+
+RTE_REGISTER_BUS(pci, rte_pci_bus);
+RTE_LOG_REGISTER_DEFAULT(pci_bus_logtype, NOTICE);
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index a2060978fe1..faf5f0e911c 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -41,7 +41,6 @@
 #include <rte_dev.h>
 #include <rte_devargs.h>
 #include <rte_version.h>
-#include <rte_vfio.h>
 #include <malloc_heap.h>
 #include <telemetry_internal.h>
 
@@ -818,142 +817,3 @@ void
 rte_eal_vfio_get_vf_token(__rte_unused rte_uuid_t vf_token)
 {
 }
-
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_setup_device)
-int rte_vfio_setup_device(__rte_unused const char *sysfs_base,
-		      __rte_unused const char *dev_addr,
-		      __rte_unused int *vfio_dev_fd,
-		      __rte_unused struct vfio_device_info *device_info)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_release_device)
-int rte_vfio_release_device(__rte_unused const char *sysfs_base,
-			__rte_unused const char *dev_addr,
-			__rte_unused int fd)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_enable)
-int rte_vfio_enable(void)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_cleanup)
-void
-rte_vfio_cleanup(void)
-{
-}
-
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_module_is_loaded)
-int rte_vfio_module_is_loaded(__rte_unused enum rte_vfio_module module)
-{
-	return 0;
-}
-
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_is_enabled)
-int rte_vfio_is_enabled(void)
-{
-	return 0;
-}
-
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_noiommu_is_enabled)
-int rte_vfio_noiommu_is_enabled(void)
-{
-	return 0;
-}
-
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_clear_group)
-int rte_vfio_clear_group(__rte_unused int vfio_group_fd)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_group_num)
-int
-rte_vfio_get_group_num(__rte_unused const char *sysfs_base,
-		       __rte_unused const char *dev_addr,
-		       __rte_unused int *iommu_group_num)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_container_fd)
-int
-rte_vfio_get_container_fd(void)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_group_fd)
-int
-rte_vfio_get_group_fd(__rte_unused int iommu_group_num)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_create)
-int
-rte_vfio_container_create(void)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_destroy)
-int
-rte_vfio_container_destroy(__rte_unused int container_fd)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_group_bind)
-int
-rte_vfio_container_group_bind(__rte_unused int container_fd,
-		__rte_unused int iommu_group_num)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_group_unbind)
-int
-rte_vfio_container_group_unbind(__rte_unused int container_fd,
-		__rte_unused int iommu_group_num)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_dma_map)
-int
-rte_vfio_container_dma_map(__rte_unused int container_fd,
-			__rte_unused uint64_t vaddr,
-			__rte_unused uint64_t iova,
-			__rte_unused uint64_t len)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_dma_unmap)
-int
-rte_vfio_container_dma_unmap(__rte_unused int container_fd,
-			__rte_unused uint64_t vaddr,
-			__rte_unused uint64_t iova,
-			__rte_unused uint64_t len)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index b8771d4d858..cac8faa53db 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -24,7 +24,6 @@
 #include <eal_options.h>
 #include <eal_private.h>
 #include <rte_service_component.h>
-#include <rte_vfio.h>
 
 #include "eal_firmware.h"
 #include "eal_hugepages.h"
@@ -152,12 +151,6 @@ rte_eal_cleanup(void)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_cleanup)
-void
-rte_vfio_cleanup(void)
-{
-}
-
 /* Launch threads, called at application init(). */
 RTE_EXPORT_SYMBOL(rte_eal_init)
 int
@@ -459,28 +452,6 @@ eal_asprintf(char **buffer, const char *format, ...)
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_dma_map)
-int
-rte_vfio_container_dma_map(__rte_unused int container_fd,
-			__rte_unused uint64_t vaddr,
-			__rte_unused uint64_t iova,
-			__rte_unused uint64_t len)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_dma_unmap)
-int
-rte_vfio_container_dma_unmap(__rte_unused int container_fd,
-			__rte_unused uint64_t vaddr,
-			__rte_unused uint64_t iova,
-			__rte_unused uint64_t len)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(rte_firmware_read)
 int
 rte_firmware_read(__rte_unused const char *name,
-- 
2.52.0

