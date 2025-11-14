Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA95ECE8D5F
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 17:42:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25F8A41144;
	Fri, 14 Nov 2025 18:40:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 4810F427A0
 for <dev@dpdk.org>; Fri, 14 Nov 2025 18:40:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763142055; x=1794678055;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=W7P0OjGa10bMlfp+/2LKgT7T/U4dbnnaxBCjB8gR+eQ=;
 b=ZRm6+5i9PqewRuC9HMRT07W3iiEc/F3/nSEh7VAeI45T7mDlZgJcREmN
 G4K/2sPTuQ4dLaV+7nQR+Bo3DtWl/v32lrWqf/+bFl5niJh9giFj90oJQ
 XFDJ87D9UwH4gdHpqhh4OwrnsxQ6lRi3r8BWlF8orYvvfo/3z/8PWkC3w
 fHwGrhzwWJkroyBLdWwAUo9AJRowLcqCdstK9QfPJAHP+7Ywsy4k1+oGc
 4V5eJgUBrNmdnaywBobqSYvr//cPcDcl/imqIV0Q/lO+W6XZzwULsTHIq
 l81hILsX0R/020qm9FFR2RnHfgeNSRXb254mLgIBnIXGy2qql+VfU57bR w==;
X-CSE-ConnectionGUID: PtWXhCHZRte+ipzaP1wyOQ==
X-CSE-MsgGUID: ZoS+KzB6TJS8/OARiDxmkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="68864298"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="68864298"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2025 09:40:54 -0800
X-CSE-ConnectionGUID: Rkx+z02vSG2UPA21bepYHQ==
X-CSE-MsgGUID: UZA2U/37RKKTozcakIzqHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="189650796"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 14 Nov 2025 09:40:52 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Chenbo Xia <chenbox@nvidia.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v2 13/19] vfio: cleanup and refactor
Date: Fri, 14 Nov 2025 17:40:23 +0000
Message-ID: <a53a81a2ad2ea23aabcdc274d2b5ccb6ea4a4df5.1763142008.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763142007.git.anatoly.burakov@intel.com>
 <cover.1763142007.git.anatoly.burakov@intel.com>
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

Currently, VFIO code is a bit of an incoherent mess internally, with API's
bleeding into each other, inconsistent returns, and a certain amount of
spaghetti stemming from organic growth.

Refactor VFIO code to achieve the following goals:

- Make all error handling consistent, and provide/document rte_errno values
  returned from API's to indicate various conditions.

- Introduce new "VFIO mode" concept. This new API will tell caller if
  VFIO is enabled, and whether it is using group API, and whether it is
  running in no-IOMMU mode.

- Decouple rte_vfio_setup_device semantics from PCI bus return convention.
  Currently, when device is not managed by VFIO, rte_vfio_setup_device
  will return 1, which is bus speak for "skip this device", however VFIO
  has nothing to do with PCI bus and should not follow its API conventions.

- Perform device setup in device assign, and make device setup use shared
  code path with device assign and explicitly assuming default container.
  This is technically not necessary for group mode as device set up is a
  two-step process in that mode, but coming cdev mode will have a
  single-step device setup, and it would be easier if the worked the same
  way under the hood.

- Make VFIO internals more readable. Introduce a lot of infrastructure and
  more explicit validation, rather than over-reliance on sentinel values
  and implicit assumptions. This will also make it easier to integrate cdev
  mode down the line, as it will rely on most of this infrastructure.

This will change behavior of the following functions:

- `rte_vfio_setup_device` - when the device is not managed by VFIO, the
  function will now return -1 with `rte_errno` set to ENODEV
- `rte_vfio_clear_group` - VFIO will now also close all device fd's
  associated with that group, and release all internal resources
- `rte_vfio_get_group_fd` - the function will no longer implicitly create
  a new group fd in the default container, but rather will only return one
  if there was a pre-existing group bind operation
- `rte_vfio_container_destroy` - the function will now release and close
  all group and device resources associated with the container being
  destroyed by this call
- `rte_vfio_container_group_unbind` - the function will now release and
  close all group and device resources associated with the group

All users of `rte_vfio_setup_device` have been adjusted.

The explicit group-based API will be removed in future commits, but for
now it is reimplemented using the new infrastructure.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 config/arm/meson.build            |    1 +
 config/meson.build                |    1 +
 drivers/bus/cdx/cdx_vfio.c        |   17 +-
 drivers/bus/pci/linux/pci_vfio.c  |   19 +-
 drivers/crypto/bcmfs/bcmfs_vfio.c |    6 +-
 lib/eal/freebsd/eal.c             |   16 +
 lib/eal/include/rte_vfio.h        |  320 ++--
 lib/eal/linux/eal_vfio.c          | 2448 +++++++++++------------------
 lib/eal/linux/eal_vfio.h          |  142 +-
 lib/eal/linux/eal_vfio_group.c    |  983 ++++++++++++
 lib/eal/linux/eal_vfio_mp_sync.c  |   38 +-
 lib/eal/linux/meson.build         |    1 +
 12 files changed, 2345 insertions(+), 1647 deletions(-)
 create mode 100644 lib/eal/linux/eal_vfio_group.c

diff --git a/config/arm/meson.build b/config/arm/meson.build
index c0aa21b57d..cd9ccccefd 100644
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -148,6 +148,7 @@ implementer_cavium = {
     'description': 'Cavium',
     'flags': [
         ['RTE_MAX_VFIO_GROUPS', 128],
+        ['RTE_MAX_VFIO_DEVICES', 256],
         ['RTE_MAX_LCORE', 96],
         ['RTE_MAX_NUMA_NODES', 2]
     ],
diff --git a/config/meson.build b/config/meson.build
index 0cb074ab95..6752584a7b 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -375,6 +375,7 @@ dpdk_conf.set('RTE_ENABLE_TRACE_FP', get_option('enable_trace_fp'))
 dpdk_conf.set('RTE_PKTMBUF_HEADROOM', get_option('pkt_mbuf_headroom'))
 # values which have defaults which may be overridden
 dpdk_conf.set('RTE_MAX_VFIO_GROUPS', 64)
+dpdk_conf.set('RTE_MAX_VFIO_DEVICES', 256)
 dpdk_conf.set('RTE_DRIVER_MEMPOOL_BUCKET_SIZE_KB', 64)
 dpdk_conf.set('RTE_LIBRTE_DPAA2_USE_PHYS_IOVA', true)
 if dpdk_conf.get('RTE_ARCH_64')
diff --git a/drivers/bus/cdx/cdx_vfio.c b/drivers/bus/cdx/cdx_vfio.c
index 7a44ff441a..fb64684c36 100644
--- a/drivers/bus/cdx/cdx_vfio.c
+++ b/drivers/bus/cdx/cdx_vfio.c
@@ -22,6 +22,7 @@
 
 #include <eal_export.h>
 #include <rte_eal_paging.h>
+#include <rte_errno.h>
 #include <rte_malloc.h>
 #include <rte_vfio.h>
 
@@ -402,8 +403,12 @@ cdx_vfio_map_resource_primary(struct rte_cdx_device *dev)
 
 	ret = rte_vfio_setup_device(RTE_CDX_BUS_DEVICES_PATH, dev_name,
 				    &vfio_dev_fd);
-	if (ret)
+	if (ret < 0) {
+		/* Device not managed by VFIO - skip */
+		if (rte_errno == ENODEV)
+			ret = 1;
 		return ret;
+	}
 
 	ret = rte_vfio_get_device_info(vfio_dev_fd, &device_info);
 	if (ret)
@@ -513,11 +518,13 @@ cdx_vfio_map_resource_secondary(struct rte_cdx_device *dev)
 		return -1;
 	}
 
-	ret = rte_vfio_setup_device(RTE_CDX_BUS_DEVICES_PATH, dev_name,
-					&vfio_dev_fd);
-	if (ret)
+	ret = rte_vfio_setup_device(RTE_CDX_BUS_DEVICES_PATH, dev_name, &vfio_dev_fd);
+	if (ret < 0) {
+		/* Device not managed by VFIO - skip */
+		if (rte_errno == ENODEV)
+			ret = 1;
 		return ret;
-
+	}
 	ret = rte_vfio_get_device_info(vfio_dev_fd, &device_info);
 	if (ret)
 		return ret;
diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index 47b3f1dec8..801f8fdda4 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -20,6 +20,7 @@
 #include <rte_malloc.h>
 #include <rte_vfio.h>
 #include <rte_eal.h>
+#include <rte_errno.h>
 #include <bus_driver.h>
 #include <rte_spinlock.h>
 #include <rte_tailq.h>
@@ -752,10 +753,13 @@ pci_vfio_map_resource_primary(struct rte_pci_device *dev)
 	snprintf(pci_addr, sizeof(pci_addr), PCI_PRI_FMT,
 			loc->domain, loc->bus, loc->devid, loc->function);
 
-	ret = rte_vfio_setup_device(rte_pci_get_sysfs_path(), pci_addr,
-					&vfio_dev_fd);
-	if (ret)
+	ret = rte_vfio_setup_device(rte_pci_get_sysfs_path(), pci_addr, &vfio_dev_fd);
+	if (ret < 0) {
+		/* Device not managed by VFIO - skip */
+		if (rte_errno == ENODEV)
+			ret = 1;
 		return ret;
+	}
 
 	ret = rte_vfio_get_device_info(vfio_dev_fd, &device_info);
 	if (ret)
@@ -965,10 +969,13 @@ pci_vfio_map_resource_secondary(struct rte_pci_device *dev)
 		return -1;
 	}
 
-	ret = rte_vfio_setup_device(rte_pci_get_sysfs_path(), pci_addr,
-					&vfio_dev_fd);
-	if (ret)
+	ret = rte_vfio_setup_device(rte_pci_get_sysfs_path(), pci_addr, &vfio_dev_fd);
+	if (ret < 0) {
+		/* Device not managed by VFIO - skip */
+		if (rte_errno == ENODEV)
+			ret = 1;
 		return ret;
+	}
 
 	ret = rte_vfio_get_device_info(vfio_dev_fd, &device_info);
 	if (ret)
diff --git a/drivers/crypto/bcmfs/bcmfs_vfio.c b/drivers/crypto/bcmfs/bcmfs_vfio.c
index d00aaf1bb7..92d8de4443 100644
--- a/drivers/crypto/bcmfs/bcmfs_vfio.c
+++ b/drivers/crypto/bcmfs/bcmfs_vfio.c
@@ -9,6 +9,7 @@
 #include <sys/mman.h>
 #include <sys/ioctl.h>
 
+#include <rte_errno.h>
 #include <rte_vfio.h>
 
 #include "bcmfs_device.h"
@@ -26,7 +27,10 @@ vfio_map_dev_obj(const char *path, const char *dev_obj,
 	struct vfio_region_info reg_info = { .argsz = sizeof(reg_info) };
 
 	ret = rte_vfio_setup_device(path, dev_obj, dev_fd);
-	if (ret) {
+	if (ret < 0) {
+		/* Device not managed by VFIO - skip */
+		if (rte_errno == ENODEV)
+			ret = 1;
 		BCMFS_LOG(ERR, "VFIO Setting for device failed");
 		return ret;
 	}
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index a7360db7a7..efdb9dd369 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -946,3 +946,19 @@ rte_vfio_container_assign_device(__rte_unused int vfio_container_fd,
 	rte_errno = ENOTSUP;
 	return -1;
 }
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vfio_get_device_info, 26.03)
+int
+rte_vfio_get_device_info(__rte_unused int vfio_dev_fd,
+		__rte_unused struct vfio_device_info *device_info)
+{
+	rte_errno = ENOTSUP;
+	return -1;
+}
+
+RTE_EXPORT_SYMBOL(rte_vfio_get_mode)
+enum rte_vfio_mode
+rte_vfio_get_mode(void)
+{
+	return RTE_VFIO_MODE_NONE;
+}
diff --git a/lib/eal/include/rte_vfio.h b/lib/eal/include/rte_vfio.h
index e7e2ee950b..bfa59094fe 100644
--- a/lib/eal/include/rte_vfio.h
+++ b/lib/eal/include/rte_vfio.h
@@ -18,6 +18,7 @@
 #include <stdint.h>
 
 #include <rte_compat.h>
+#include <rte_common.h>
 
 #ifdef __cplusplus
 extern "C" {
@@ -29,8 +30,7 @@ extern "C" {
 #define RTE_VFIO_CONTAINER_PATH "/dev/vfio/vfio"
 #define RTE_VFIO_GROUP_FMT "/dev/vfio/%u"
 #define RTE_VFIO_NOIOMMU_GROUP_FMT "/dev/vfio/noiommu-%u"
-#define RTE_VFIO_NOIOMMU_MODE      \
-	"/sys/module/vfio/parameters/enable_unsafe_noiommu_mode"
+#define RTE_VFIO_NOIOMMU_MODE "/sys/module/vfio/parameters/enable_unsafe_noiommu_mode"
 
 #endif /* RTE_EXEC_ENV_LINUX */
 
@@ -41,26 +41,48 @@ struct vfio_device_info;
 
 /**
  * @internal
- * Setup vfio_cfg for the device identified by its address.
- * It discovers the configured I/O MMU groups or sets a new one for the device.
- * If a new groups is assigned, the DMA mapping is performed.
+ * Enumeration of VFIO operational modes.
  *
- * This function is only relevant to linux and will return
- * an error on BSD.
+ * These modes define how VFIO devices are accessed and managed:
+ *
+ * - RTE_VFIO_MODE_NONE: VFIO is not enabled.
+ * - RTE_VFIO_MODE_GROUP: Legacy group mode.
+ * - RTE_VFIO_MODE_NOIOMMU: Unsafe no-IOMMU mode.
+ * - RTE_VFIO_MODE_CDEV: Character device mode.
+ */
+enum rte_vfio_mode {
+	RTE_VFIO_MODE_NONE = 0, /**< VFIO not enabled */
+	RTE_VFIO_MODE_GROUP,    /**< Group mode */
+	RTE_VFIO_MODE_NOIOMMU,  /**< Group mode with no IOMMU protection */
+};
+
+/**
+ * @internal
+ * Set up a device managed by VFIO driver.
+ *
+ * If the device was not previously assigned to a container using
+ * `rte_vfio_container_assign_device()`, default container will be used.
+ *
+ * This function is only relevant on Linux.
  *
  * @param sysfs_base
- *   sysfs path prefix.
- *
+ *   Sysfs path prefix.
  * @param dev_addr
- *   device location.
- *
+ *   Device identifier.
  * @param vfio_dev_fd
- *   Pointer to VFIO fd, will be set to the opened device fd on success.
+ *   Pointer to where VFIO device file descriptor will be stored.
  *
  * @return
  *   0 on success.
- *   <0 on failure.
- *   >1 if the device cannot be managed this way.
+ *   <0 on failure, rte_errno is set.
+ *
+ * Possible rte_errno values include:
+ * - ENODEV  - Device not managed by VFIO.
+ * - ENOSPC  - No space in VFIO container to track the device.
+ * - EINVAL  - Invalid parameters.
+ * - EIO     - Error during underlying VFIO operations.
+ * - ENXIO   - VFIO support not initialized.
+ * - ENOTSUP - Unsupported VFIO mode.
  */
 __rte_internal
 int rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
@@ -68,87 +90,117 @@ int rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 
 /**
  * @internal
- * Release a device mapped to a VFIO-managed I/O MMU group.
+ * Release a device managed by VFIO driver.
  *
- * This function is only relevant to linux and will return
- * an error on BSD.
+ * This function is only relevant on Linux.
+ *
+ * @note As a result of this function, all internal resources used by the device will be released,
+ *       so if the device was using a non-default container, it will need to be reassigned.
  *
  * @param sysfs_base
- *   sysfs path prefix.
- *
+ *   Sysfs path prefix.
  * @param dev_addr
- *   device location.
- *
+ *   Device identifier.
  * @param fd
- *   VFIO fd.
+ *   A previously set up VFIO file descriptor.
  *
  * @return
  *   0 on success.
- *   <0 on failure.
+ *   <0 on failure, rte_errno is set.
+ *
+ * Possible rte_errno values include:
+ * - ENOENT  - Device not found in any container.
+ * - EINVAL  - Invalid parameters.
+ * - EIO     - Error during underlying VFIO operations.
+ * - ENXIO   - VFIO support not initialized.
+ * - ENOTSUP - Unsupported VFIO mode.
  */
 __rte_internal
 int rte_vfio_release_device(const char *sysfs_base, const char *dev_addr, int fd);
 
 /**
  * @internal
- * Enable a VFIO-related kmod.
+ * Enable VFIO subsystem and check if specified kernel module is loaded.
  *
- * This function is only relevant to linux and will return
- * an error on BSD.
+ * In case of success, `rte_vfio_get_mode()` can be used to retrieve the VFIO mode in use.
+ *
+ * This function is only relevant on Linux.
  *
  * @param modname
- *   kernel module name.
+ *   Kernel module name.
  *
  * @return
  *   0 on success.
- *   <0 on failure.
+ *   <0 on failure, rte_errno is set.
+ *
+ * Possible rte_errno values include:
+ * - EINVAL  - Invalid parameters.
+ * - ENXIO   - VFIO support not initialized.
+ * - ENOTSUP - Operation not supported.
  */
 __rte_internal
 int rte_vfio_enable(const char *modname);
 
 /**
  * @internal
- * Check whether a VFIO-related kmod is enabled.
+ * Check if VFIO subsystem is initialized and a specified kernel module is loaded.
  *
- * This function is only relevant to Linux.
+ * This function is only relevant on Linux.
  *
  * @param modname
- *   kernel module name.
+ *   Kernel module name.
  *
  * @return
- *   1 if true.
- *   0 otherwise.
+ *   1 if enabled.
+ *   0 if not enabled or not supported.
  */
 __rte_internal
 int rte_vfio_is_enabled(const char *modname);
 
 /**
  * @internal
- * Whether VFIO NOIOMMU mode is enabled.
+ * Get current VFIO mode.
  *
- * This function is only relevant to Linux.
+ * This function is only relevant on Linux.
  *
  * @return
- *   1 if true.
- *   0 if false.
- *   <0 for errors.
+ *   VFIO mode currently in use.
  */
 __rte_internal
-int rte_vfio_noiommu_is_enabled(void);
+enum rte_vfio_mode
+rte_vfio_get_mode(void);
 
 /**
  * @internal
- * Remove group fd from internal VFIO group fd array.
+ * Check if VFIO NOIOMMU mode is enabled.
  *
- * This function is only relevant to linux and will return
- * an error on BSD.
+ * This function is only relevant on Linux in group mode.
+ *
+ * @return
+ *   1 if enabled.
+ *   0 if not enabled or not supported.
+ */
+__rte_internal
+int
+rte_vfio_noiommu_is_enabled(void);
+
+/**
+ * @internal
+ * Remove group fd from internal VFIO tracking.
+ *
+ * This function is only relevant on Linux in group mode.
  *
  * @param vfio_group_fd
- *   VFIO Group FD.
+ *   VFIO group fd.
  *
  * @return
  *   0 on success.
- *   <0 on failure.
+ *   <0 on failure, rte_errno is set.
+ *
+ * Possible rte_errno values include:
+ * - ENOENT  - Group not found.
+ * - ENXIO   - VFIO support not initialized.
+ * - ENOTSUP - Unsupported VFIO mode.
  */
 __rte_internal
 int
@@ -158,27 +210,28 @@ rte_vfio_clear_group(int vfio_group_fd);
  * @internal
  * Parse IOMMU group number for a device.
  *
- * This function is only relevant to linux and will return
- * an error on BSD.
+ * This function is only relevant on Linux in group mode.
  *
  * @param sysfs_base
- *   sysfs path prefix.
- *
+ *   Sysfs path prefix.
  * @param dev_addr
- *   device location.
- *
+ *   Device identifier.
  * @param iommu_group_num
- *   iommu group number
+ *   Pointer to where IOMMU group number will be stored.
  *
  * @return
- *  >0 on success
- *   0 for non-existent group or VFIO
- *  <0 for errors
+ *   0 on success.
+ *   <0 on failure, rte_errno is set.
+ *
+ * Possible rte_errno values include:
+ * - ENODEV  - Device not managed by VFIO.
+ * - EINVAL  - Invalid parameters.
+ * - ENXIO   - VFIO support not initialized.
+ * - ENOTSUP - Unsupported VFIO mode.
  */
 __rte_internal
 int
-rte_vfio_get_group_num(const char *sysfs_base,
-		      const char *dev_addr, int *iommu_group_num);
+rte_vfio_get_group_num(const char *sysfs_base, const char *dev_addr, int *iommu_group_num);
 
 /**
  * @internal
@@ -197,7 +250,12 @@ rte_vfio_get_group_num(const char *sysfs_base,
  *
  * @return
  *   0 on success.
- *  <0 on failure.
+ *   <0 on failure, rte_errno is set.
+ *
+ * Possible rte_errno values include:
+ * - EINVAL  - Invalid parameters.
+ * - ENXIO   - VFIO support not initialized.
+ * - ENOTSUP - Unsupported VFIO mode.
  */
 __rte_internal
 int
@@ -205,14 +263,17 @@ rte_vfio_get_device_info(int vfio_dev_fd, struct vfio_device_info *device_info);
 
 /**
  * @internal
- * Get the default VFIO container fd
+ * Get the default VFIO container file descriptor.
  *
- * This function is only relevant to linux and will return
- * an error on BSD.
+ * This function is only relevant on Linux.
  *
  * @return
- *  > 0 default container fd
- *  < 0 if VFIO is not enabled or not supported
+ *   Non-negative container file descriptor on success.
+ *   <0 on failure, rte_errno is set.
+ *
+ * Possible rte_errno values include:
+ * - ENXIO   - VFIO support not initialized.
+ * - ENOTSUP - Unsupported VFIO mode.
  */
 __rte_internal
 int
@@ -220,17 +281,21 @@ rte_vfio_get_container_fd(void);
 
 /**
  * @internal
- * Open VFIO group fd or get an existing one.
+ * Return file descriptor for an open VFIO group.
  *
- * This function is only relevant to linux and will return
- * an error on BSD.
+ * This function is only relevant on Linux in group mode.
  *
  * @param iommu_group_num
- *   iommu group number
+ *   IOMMU group number.
  *
  * @return
- *  > 0 group fd
- *  < 0 for errors
+ *   Non-negative group file descriptor on success.
+ *   <0 on failure, rte_errno is set.
+ *
+ * Possible rte_errno values include:
+ * - ENOENT  - Group not found.
+ * - ENXIO   - VFIO support not initialized.
+ * - ENOTSUP - Unsupported VFIO mode.
  */
 __rte_internal
 int
@@ -238,7 +303,9 @@ rte_vfio_get_group_fd(int iommu_group_num);
 
 /**
  * @internal
- * Create a new container for device binding.
+ * Create a new VFIO container for device assignment and DMA mapping.
+ *
+ * This function is only relevant on Linux.
  *
  * @note Any newly allocated DPDK memory will not be mapped into these
  *       containers by default, user needs to manage DMA mappings for
@@ -249,8 +316,14 @@ rte_vfio_get_group_fd(int iommu_group_num);
  *       devices between multiple processes is not supported.
  *
  * @return
- *   the container fd if successful
- *   <0 if failed
+ *   Non-negative container file descriptor on success.
+ *   <0 on failure, rte_errno is set.
+ *
+ * Possible rte_errno values include:
+ * - ENOSPC  - Maximum number of containers reached.
+ * - EIO     - Underlying VFIO operation failed.
+ * - ENXIO   - VFIO support not initialized.
+ * - ENOTSUP - Unsupported VFIO mode.
  */
 __rte_internal
 int
@@ -258,14 +331,22 @@ rte_vfio_container_create(void);
 
 /**
  * @internal
- * Destroy the container, unbind all vfio groups within it.
+ * Destroy a VFIO container and unmap all devices assigned to it.
+ *
+ * This function is only relevant on Linux.
  *
  * @param container_fd
- *   the container fd to destroy
+ *   File descriptor of container to destroy.
  *
  * @return
- *    0 if successful
- *   <0 if failed
+ *   0 on success.
+ *   <0 on failure, rte_errno is set.
+ *
+ * Possible rte_errno values include:
+ * - ENODEV  - Container not managed by VFIO.
+ * - EINVAL  - Invalid container file descriptor.
+ * - ENXIO   - VFIO support not initialized.
+ * - ENOTSUP - Unsupported VFIO mode.
  */
 __rte_internal
 int
@@ -291,25 +372,42 @@ rte_vfio_container_destroy(int container_fd);
  * @return
  *   0 on success.
  *   <0 on failure, rte_errno is set.
+ *
+ * Possible rte_errno values include:
+ * - ENODEV  - Device not managed by VFIO.
+ * - EEXIST  - Device already assigned to the container.
+ * - ENOSPC  - No space in VFIO container to assign device.
+ * - EINVAL  - Invalid container file descriptor.
+ * - EIO     - Error during underlying VFIO operations.
+ * - ENXIO   - VFIO support not initialized.
+ * - ENOTSUP - Unsupported VFIO mode.
  */
 __rte_internal
 int
-rte_vfio_container_assign_device(int vfio_container_fd, const char *sysfs_base,
-		const char *dev_addr);
+rte_vfio_container_assign_device(int vfio_container_fd,
+		const char *sysfs_base, const char *dev_addr);
 
 /**
  * @internal
- * Bind a IOMMU group to a container.
+ * Bind an IOMMU group to a container.
+ *
+ * This function is only relevant on Linux in group mode.
  *
  * @param container_fd
- *   the container's fd
- *
+ *   Container file descriptor.
  * @param iommu_group_num
- *   the iommu group number to bind to container
+ *   IOMMU group number to bind to container.
  *
  * @return
- *   group fd if successful
- *   <0 if failed
+ *   0 on success.
+ *   <0 on failure, rte_errno is set.
+ *
+ * Possible rte_errno values include:
+ * - ENODEV  - IOMMU group not managed by VFIO.
+ * - ENOSPC  - No space in VFIO container to track the group.
+ * - EINVAL  - Invalid container file descriptor.
+ * - ENXIO   - VFIO support not initialized.
+ * - ENOTSUP - Unsupported VFIO mode.
  */
 __rte_internal
 int
@@ -317,17 +415,25 @@ rte_vfio_container_group_bind(int container_fd, int iommu_group_num);
 
 /**
  * @internal
- * Unbind a IOMMU group from a container.
+ * Unbind an IOMMU group from a container.
+ *
+ * This function is only relevant on Linux in group mode.
  *
  * @param container_fd
- *   the container fd of container
- *
+ *   Container file descriptor.
  * @param iommu_group_num
- *   the iommu group number to delete from container
+ *   IOMMU group number to unbind from container.
  *
  * @return
- *    0 if successful
- *   <0 if failed
+ *   0 on success.
+ *   <0 on failure, rte_errno is set.
+ *
+ * Possible rte_errno values include:
+ * - ENOENT  - VFIO group not found in container.
+ * - ENODEV  - Container not managed by VFIO.
+ * - EINVAL  - Invalid container file descriptor.
+ * - ENXIO   - VFIO support not initialized.
+ * - ENOTSUP - Unsupported VFIO mode.
  */
 __rte_internal
 int
@@ -337,22 +443,26 @@ rte_vfio_container_group_unbind(int container_fd, int iommu_group_num);
  * @internal
  * Perform DMA mapping for devices in a container.
  *
- * @param container_fd
- *   the specified container fd. Use RTE_VFIO_DEFAULT_CONTAINER_FD to
- *   use the default container.
+ * This function is only relevant on Linux.
  *
+ * @param container_fd
+ *   Container file descriptor. Use RTE_VFIO_DEFAULT_CONTAINER_FD to use the default container.
  * @param vaddr
  *   Starting virtual address of memory to be mapped.
- *
  * @param iova
  *   Starting IOVA address of memory to be mapped.
- *
  * @param len
  *   Length of memory segment being mapped.
  *
  * @return
- *    0 if successful
- *   <0 if failed
+ *   0 on success.
+ *   <0 on failure, rte_errno is set.
+ *
+ * Possible rte_errno values include:
+ * - EIO     - DMA mapping operation failed.
+ * - EINVAL  - Invalid parameters.
+ * - ENXIO   - VFIO support not initialized.
+ * - ENOTSUP - Unsupported VFIO mode.
  */
 __rte_internal
 int
@@ -363,22 +473,26 @@ rte_vfio_container_dma_map(int container_fd, uint64_t vaddr,
  * @internal
  * Perform DMA unmapping for devices in a container.
  *
- * @param container_fd
- *   the specified container fd. Use RTE_VFIO_DEFAULT_CONTAINER_FD to
- *   use the default container.
+ * This function is only relevant on Linux.
  *
+ * @param container_fd
+ *   Container file descriptor. Use RTE_VFIO_DEFAULT_CONTAINER_FD to use the default container.
  * @param vaddr
  *   Starting virtual address of memory to be unmapped.
- *
  * @param iova
  *   Starting IOVA address of memory to be unmapped.
- *
  * @param len
  *   Length of memory segment being unmapped.
  *
  * @return
- *    0 if successful
- *   <0 if failed
+ *   0 on success.
+ *   <0 on failure, rte_errno is set.
+ *
+ * Possible rte_errno values include:
+ * - EIO     - DMA unmapping operation failed.
+ * - EINVAL  - Invalid parameters.
+ * - ENXIO   - VFIO support not initialized.
+ * - ENOTSUP - Unsupported VFIO mode.
  */
 __rte_internal
 int
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 02fec64658..7d5edc7865 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -9,6 +9,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <sys/ioctl.h>
+#include <sys/stat.h>
 #include <dirent.h>
 
 #include <rte_errno.h>
@@ -24,77 +25,39 @@
 #include "eal_private.h"
 #include "eal_internal_cfg.h"
 
-#define VFIO_MEM_EVENT_CLB_NAME "vfio_mem_event_clb"
-
-/* hot plug/unplug of VFIO groups may cause all DMA maps to be dropped. we can
- * recreate the mappings for DPDK segments, but we cannot do so for memory that
- * was registered by the user themselves, so we need to store the user mappings
- * somewhere, to recreate them later.
+/*
+ * rte_errno convention:
+ *
+ * - EINVAL: invalid parameters
+ * - ENOTSUP: current mode does not support this operation
+ * - ENOXIO: VFIO not initialized
+ * - ENODEV: device not managed by VFIO
+ * - ENOSPC: no space in config
+ * - EEXIST: device already assigned
+ * - ENOENT: group or device not found
+ * - EIO: underlying VFIO operation failed
  */
-#define EAL_VFIO_MAX_USER_MEM_MAPS 256
-struct user_mem_map {
-	uint64_t addr;  /**< start VA */
-	uint64_t iova;  /**< start IOVA */
-	uint64_t len;   /**< total length of the mapping */
-	uint64_t chunk; /**< this mapping can be split in chunks of this size */
-};
 
-struct user_mem_maps {
-	rte_spinlock_recursive_t lock;
-	int n_maps;
-	struct user_mem_map maps[EAL_VFIO_MAX_USER_MEM_MAPS];
+/* functions can fail for multiple reasons, and errno is tedious */
+enum vfio_result {
+	VFIO_SUCCESS,
+	VFIO_ERROR,
+	VFIO_EXISTS,
+	VFIO_NOT_SUPPORTED,
+	VFIO_NOT_MANAGED,
+	VFIO_NOT_FOUND,
+	VFIO_NO_SPACE,
 };
 
-struct vfio_config {
-	int vfio_enabled;
-	int vfio_container_fd;
-	int vfio_active_groups;
-	const struct vfio_iommu_type *vfio_iommu_type;
-	struct vfio_group vfio_groups[RTE_MAX_VFIO_GROUPS];
-	struct user_mem_maps mem_maps;
+struct container containers[RTE_MAX_VFIO_CONTAINERS] = {0};
+struct vfio_config vfio_cfg = {
+	.mode = RTE_VFIO_MODE_NONE,
+	.default_cfg = &containers[0]
 };
 
-/* per-process VFIO config */
-static struct vfio_config vfio_cfgs[RTE_MAX_VFIO_CONTAINERS];
-static struct vfio_config *default_vfio_cfg = &vfio_cfgs[0];
-
-static int vfio_type1_dma_map(int);
-static int vfio_type1_dma_mem_map(int, uint64_t, uint64_t, uint64_t, int);
-static int vfio_spapr_dma_map(int);
-static int vfio_spapr_dma_mem_map(int, uint64_t, uint64_t, uint64_t, int);
-static int vfio_noiommu_dma_map(int);
-static int vfio_noiommu_dma_mem_map(int, uint64_t, uint64_t, uint64_t, int);
-static int vfio_dma_mem_map(struct vfio_config *vfio_cfg, uint64_t vaddr,
+static int vfio_dma_mem_map(struct container *cfg, uint64_t vaddr,
 		uint64_t iova, uint64_t len, int do_map);
 
-/* IOMMU types we support */
-static const struct vfio_iommu_type iommu_types[] = {
-	/* x86 IOMMU, otherwise known as type 1 */
-	{
-		.type_id = VFIO_TYPE1_IOMMU,
-		.name = "Type 1",
-		.partial_unmap = false,
-		.dma_map_func = &vfio_type1_dma_map,
-		.dma_user_map_func = &vfio_type1_dma_mem_map
-	},
-	/* ppc64 IOMMU, otherwise known as spapr */
-	{
-		.type_id = VFIO_SPAPR_TCE_v2_IOMMU,
-		.name = "sPAPR",
-		.partial_unmap = true,
-		.dma_map_func = &vfio_spapr_dma_map,
-		.dma_user_map_func = &vfio_spapr_dma_mem_map
-	},
-	/* IOMMU-less mode */
-	{
-		.type_id = VFIO_NOIOMMU_IOMMU,
-		.name = "No-IOMMU",
-		.partial_unmap = true,
-		.dma_map_func = &vfio_noiommu_dma_map,
-		.dma_user_map_func = &vfio_noiommu_dma_mem_map
-	},
-};
-
 static int
 is_null_map(const struct user_mem_map *map)
 {
@@ -350,280 +313,158 @@ compact_user_maps(struct user_mem_maps *user_mem_maps)
 			sizeof(user_mem_maps->maps[0]), user_mem_map_cmp);
 }
 
-static int
-vfio_open_group_fd(int iommu_group_num, bool mp_request)
+/*
+ * we will rely on kernel to not allow user to assign the same device to different containers, but
+ * kernel will not prevent mapping the same device twice using two different fd's, so we need to
+ * deduplicate our internal config to make sure we only store unique device fd's.
+ */
+static bool
+fd_is_same(int fd1, int fd2)
 {
-	int vfio_group_fd;
-	char filename[PATH_MAX];
-	struct rte_mp_msg mp_req, *mp_rep;
-	struct rte_mp_reply mp_reply = {0};
-	struct timespec ts = {.tv_sec = 5, .tv_nsec = 0};
-	struct vfio_mp_param *p = (struct vfio_mp_param *)mp_req.param;
+	struct stat st1, st2;
 
-	/* if not requesting via mp, open the group locally */
-	if (!mp_request) {
-		/* try regular group format */
-		snprintf(filename, sizeof(filename), RTE_VFIO_GROUP_FMT, iommu_group_num);
-		vfio_group_fd = open(filename, O_RDWR);
-		if (vfio_group_fd < 0) {
-			/* if file not found, it's not an error */
-			if (errno != ENOENT) {
-				EAL_LOG(ERR, "Cannot open %s: %s",
-						filename, strerror(errno));
-				return -1;
-			}
+	if (fd1 < 0 || fd2 < 0)
+		return false;
 
-			/* special case: try no-IOMMU path as well */
-			snprintf(filename, sizeof(filename), RTE_VFIO_NOIOMMU_GROUP_FMT,
-				iommu_group_num);
-			vfio_group_fd = open(filename, O_RDWR);
-			if (vfio_group_fd < 0) {
-				if (errno != ENOENT) {
-					EAL_LOG(ERR,
-						"Cannot open %s: %s",
-						filename, strerror(errno));
-					return -1;
-				}
-				return -ENOENT;
-			}
-			/* noiommu group found */
-		}
+	if (fstat(fd1, &st1) < 0)
+		return false;
+	if (fstat(fd2, &st2) < 0)
+		return false;
 
-		return vfio_group_fd;
-	}
-	/* if we're in a secondary process, request group fd from the primary
-	 * process via mp channel.
-	 */
-	p->req = SOCKET_REQ_GROUP;
-	p->group_num = iommu_group_num;
-	strcpy(mp_req.name, EAL_VFIO_MP);
-	mp_req.len_param = sizeof(*p);
-	mp_req.num_fds = 0;
-
-	vfio_group_fd = -1;
-	if (rte_mp_request_sync(&mp_req, &mp_reply, &ts) == 0 &&
-	    mp_reply.nb_received == 1) {
-		mp_rep = &mp_reply.msgs[0];
-		p = (struct vfio_mp_param *)mp_rep->param;
-		if (p->result == SOCKET_OK && mp_rep->num_fds == 1) {
-			vfio_group_fd = mp_rep->fds[0];
-		} else if (p->result == SOCKET_NO_FD) {
-			EAL_LOG(ERR, "Bad VFIO group fd");
-			vfio_group_fd = -ENOENT;
-		}
-	}
-
-	free(mp_reply.msgs);
-	if (vfio_group_fd < 0 && vfio_group_fd != -ENOENT)
-		EAL_LOG(ERR, "Cannot request VFIO group fd");
-	return vfio_group_fd;
-}
-
-static struct vfio_config *
-get_vfio_cfg_by_group_num(int iommu_group_num)
-{
-	struct vfio_config *vfio_cfg;
-	unsigned int i, j;
-
-	for (i = 0; i < RTE_DIM(vfio_cfgs); i++) {
-		vfio_cfg = &vfio_cfgs[i];
-		for (j = 0; j < RTE_DIM(vfio_cfg->vfio_groups); j++) {
-			if (vfio_cfg->vfio_groups[j].group_num ==
-					iommu_group_num)
-				return vfio_cfg;
-		}
-	}
-
-	return NULL;
-}
-
-static int
-vfio_get_group_fd(struct vfio_config *vfio_cfg,
-		int iommu_group_num)
-{
-	struct vfio_group *cur_grp = NULL;
-	int vfio_group_fd;
-	unsigned int i;
-
-	/* check if we already have the group descriptor open */
-	for (i = 0; i < RTE_DIM(vfio_cfg->vfio_groups); i++)
-		if (vfio_cfg->vfio_groups[i].group_num == iommu_group_num)
-			return vfio_cfg->vfio_groups[i].fd;
-
-	/* Lets see first if there is room for a new group */
-	if (vfio_cfg->vfio_active_groups == RTE_DIM(vfio_cfg->vfio_groups)) {
-		EAL_LOG(ERR, "Maximum number of VFIO groups reached!");
-		return -1;
-	}
-
-	/* Now lets get an index for the new group */
-	for (i = 0; i < RTE_DIM(vfio_cfg->vfio_groups); i++)
-		if (vfio_cfg->vfio_groups[i].group_num == -1) {
-			cur_grp = &vfio_cfg->vfio_groups[i];
-			break;
-		}
-
-	/* This should not happen */
-	if (cur_grp == NULL) {
-		EAL_LOG(ERR, "No VFIO group free slot found");
-		return -1;
-	}
-
-	/*
-	 * When opening a group fd, we need to decide whether to open it locally
-	 * or request it from the primary process via mp_sync.
-	 *
-	 * For the default container, secondary processes use mp_sync so that
-	 * the primary process tracks the group fd and maintains VFIO state
-	 * across all processes.
-	 *
-	 * For custom containers, we open the group fd locally in each process
-	 * since custom containers are process-local and the primary has no
-	 * knowledge of them. Requesting a group fd from the primary for a
-	 * container it doesn't know about would be incorrect.
-	 */
-	const struct internal_config *internal_conf = eal_get_internal_configuration();
-	bool mp_request = (internal_conf->process_type == RTE_PROC_SECONDARY) &&
-			(vfio_cfg == default_vfio_cfg);
-
-	vfio_group_fd = vfio_open_group_fd(iommu_group_num, mp_request);
-	if (vfio_group_fd < 0) {
-		EAL_LOG(ERR, "Failed to open VFIO group %d",
-			iommu_group_num);
-		return vfio_group_fd;
-	}
-
-	cur_grp->group_num = iommu_group_num;
-	cur_grp->fd = vfio_group_fd;
-	vfio_cfg->vfio_active_groups++;
-
-	return vfio_group_fd;
+	return st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino;
 }
 
-static struct vfio_config *
-get_vfio_cfg_by_group_fd(int vfio_group_fd)
+bool
+vfio_container_is_default(struct container *cfg)
 {
-	struct vfio_config *vfio_cfg;
-	unsigned int i, j;
-
-	for (i = 0; i < RTE_DIM(vfio_cfgs); i++) {
-		vfio_cfg = &vfio_cfgs[i];
-		for (j = 0; j < RTE_DIM(vfio_cfg->vfio_groups); j++)
-			if (vfio_cfg->vfio_groups[j].fd == vfio_group_fd)
-				return vfio_cfg;
-	}
-
-	return NULL;
+	return cfg == vfio_cfg.default_cfg;
 }
 
-static struct vfio_config *
-get_vfio_cfg_by_container_fd(int container_fd)
+static struct container *
+vfio_container_get_by_fd(int container_fd)
 {
-	unsigned int i;
+	struct container *cfg;
 
 	if (container_fd == RTE_VFIO_DEFAULT_CONTAINER_FD)
-		return default_vfio_cfg;
+		return vfio_cfg.default_cfg;
 
-	for (i = 0; i < RTE_DIM(vfio_cfgs); i++) {
-		if (vfio_cfgs[i].vfio_container_fd == container_fd)
-			return &vfio_cfgs[i];
+	CONTAINER_FOREACH_ACTIVE(cfg) {
+		if (cfg->container_fd == container_fd)
+			return cfg;
 	}
+	return NULL;
+}
+
+static struct container *
+vfio_container_get_by_group_num(int group_num)
+{
+	struct container *cfg;
+	struct vfio_group *grp;
 
+	CONTAINER_FOREACH_ACTIVE(cfg) {
+		GROUP_FOREACH_ACTIVE(cfg, grp)
+			if (grp->group_num == group_num)
+				return cfg;
+	}
 	return NULL;
 }
 
+static struct container *
+vfio_container_create(void)
+{
+	struct container *cfg;
+
+	/* find an unused container config */
+	CONTAINER_FOREACH(cfg) {
+		if (!cfg->active) {
+			*cfg = CONTAINER_INITIALIZER;
+			cfg->active = true;
+			return cfg;
+		}
+	}
+	/* no space */
+	return NULL;
+}
+
+static void
+vfio_container_erase(struct container *cfg)
+{
+	if (cfg->container_fd >= 0 && close(cfg->container_fd))
+		EAL_LOG(ERR, "Error when closing container, %d (%s)", errno, strerror(errno));
+
+	*cfg = (struct container){0};
+}
+
+static struct vfio_device *
+vfio_device_create(struct container *cfg)
+{
+	struct vfio_device *dev;
+
+	/* is there space? */
+	if (cfg->n_devices == RTE_DIM(cfg->devices))
+		return NULL;
+
+	DEVICE_FOREACH(cfg, dev) {
+		if (dev->active)
+			continue;
+		dev->active = true;
+		/* set to invalid fd */
+		dev->fd = -1;
+
+		cfg->n_devices++;
+		return dev;
+	}
+	/* should not happen */
+	EAL_LOG(WARNING, "Could not find space in device list for container");
+	return NULL;
+}
+
+static void
+vfio_device_erase(struct container *cfg, struct vfio_device *dev)
+{
+	if (dev->fd >= 0 && close(dev->fd))
+		EAL_LOG(ERR, "Error when closing device, %d (%s)", errno, strerror(errno));
+
+	*dev = (struct vfio_device){0};
+	cfg->n_devices--;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_group_fd)
 int
 rte_vfio_get_group_fd(int iommu_group_num)
 {
-	struct vfio_config *vfio_cfg;
+	struct container *cfg;
+	struct vfio_group *grp;
 
-	/* get the vfio_config it belongs to */
-	vfio_cfg = get_vfio_cfg_by_group_num(iommu_group_num);
-	vfio_cfg = vfio_cfg ? vfio_cfg : default_vfio_cfg;
-
-	return vfio_get_group_fd(vfio_cfg, iommu_group_num);
-}
-
-static int
-get_vfio_group_idx(int vfio_group_fd)
-{
-	struct vfio_config *vfio_cfg;
-	unsigned int i, j;
+	if (vfio_cfg.mode == RTE_VFIO_MODE_NONE) {
+		EAL_LOG(ERR, "VFIO support not initialized");
+		rte_errno = ENXIO;
+		return -1;
+	}
+	if (vfio_cfg.mode != RTE_VFIO_MODE_GROUP &&
+			vfio_cfg.mode != RTE_VFIO_MODE_NOIOMMU) {
+		EAL_LOG(ERR, "VFIO not initialized in group mode");
+		rte_errno = ENOTSUP;
+		return -1;
+	}
 
-	for (i = 0; i < RTE_DIM(vfio_cfgs); i++) {
-		vfio_cfg = &vfio_cfgs[i];
-		for (j = 0; j < RTE_DIM(vfio_cfg->vfio_groups); j++)
-			if (vfio_cfg->vfio_groups[j].fd == vfio_group_fd)
-				return j;
+	CONTAINER_FOREACH_ACTIVE(cfg) {
+		GROUP_FOREACH_ACTIVE(cfg, grp)
+			if (grp->group_num == iommu_group_num)
+				return grp->fd;
 	}
 
+	/* group doesn't exist */
+	EAL_LOG(ERR, "IOMMU group %d not bound to any VFIO container", iommu_group_num);
+	rte_errno = ENOENT;
 	return -1;
 }
 
-static void
-vfio_group_device_get(int vfio_group_fd)
-{
-	struct vfio_config *vfio_cfg;
-	int i;
-
-	vfio_cfg = get_vfio_cfg_by_group_fd(vfio_group_fd);
-	if (vfio_cfg == NULL) {
-		EAL_LOG(ERR, "Invalid VFIO group fd!");
-		return;
-	}
-
-	i = get_vfio_group_idx(vfio_group_fd);
-	if (i < 0)
-		EAL_LOG(ERR, "Wrong VFIO group index (%d)", i);
-	else
-		vfio_cfg->vfio_groups[i].devices++;
-}
-
-static void
-vfio_group_device_put(int vfio_group_fd)
-{
-	struct vfio_config *vfio_cfg;
-	int i;
-
-	vfio_cfg = get_vfio_cfg_by_group_fd(vfio_group_fd);
-	if (vfio_cfg == NULL) {
-		EAL_LOG(ERR, "Invalid VFIO group fd!");
-		return;
-	}
-
-	i = get_vfio_group_idx(vfio_group_fd);
-	if (i < 0)
-		EAL_LOG(ERR, "Wrong VFIO group index (%d)", i);
-	else
-		vfio_cfg->vfio_groups[i].devices--;
-}
-
-static int
-vfio_group_device_count(int vfio_group_fd)
-{
-	struct vfio_config *vfio_cfg;
-	int i;
-
-	vfio_cfg = get_vfio_cfg_by_group_fd(vfio_group_fd);
-	if (vfio_cfg == NULL) {
-		EAL_LOG(ERR, "Invalid VFIO group fd!");
-		return -1;
-	}
-
-	i = get_vfio_group_idx(vfio_group_fd);
-	if (i < 0) {
-		EAL_LOG(ERR, "Wrong VFIO group index (%d)", i);
-		return -1;
-	}
-
-	return vfio_cfg->vfio_groups[i].devices;
-}
-
 static void
 vfio_mem_event_callback(enum rte_mem_event type, const void *addr, size_t len,
 		void *arg __rte_unused)
 {
+	struct container *cfg = vfio_cfg.default_cfg;
 	struct rte_memseg_list *msl;
 	struct rte_memseg *ms;
 	size_t cur_len = 0;
@@ -638,11 +479,9 @@ vfio_mem_event_callback(enum rte_mem_event type, const void *addr, size_t len,
 		/* Maintain granularity of DMA map/unmap to memseg size */
 		for (; cur_len < len; cur_len += page_sz) {
 			if (type == RTE_MEM_EVENT_ALLOC)
-				vfio_dma_mem_map(default_vfio_cfg, vfio_va,
-						 vfio_va, page_sz, 1);
+				vfio_dma_mem_map(cfg, vfio_va, vfio_va, page_sz, 1);
 			else
-				vfio_dma_mem_map(default_vfio_cfg, vfio_va,
-						 vfio_va, page_sz, 0);
+				vfio_dma_mem_map(cfg, vfio_va, vfio_va, page_sz, 0);
 			vfio_va += page_sz;
 		}
 
@@ -660,458 +499,600 @@ vfio_mem_event_callback(enum rte_mem_event type, const void *addr, size_t len,
 			goto next;
 		}
 		if (type == RTE_MEM_EVENT_ALLOC)
-			vfio_dma_mem_map(default_vfio_cfg, ms->addr_64,
-					ms->iova, ms->len, 1);
+			vfio_dma_mem_map(cfg, ms->addr_64, ms->iova, ms->len, 1);
 		else
-			vfio_dma_mem_map(default_vfio_cfg, ms->addr_64,
-					ms->iova, ms->len, 0);
+			vfio_dma_mem_map(cfg, ms->addr_64, ms->iova, ms->len, 0);
 next:
 		cur_len += ms->len;
 		++ms;
 	}
 }
 
-static int
-vfio_sync_default_container(void)
-{
-	struct rte_mp_msg mp_req, *mp_rep;
-	struct rte_mp_reply mp_reply = {0};
-	struct timespec ts = {.tv_sec = 5, .tv_nsec = 0};
-	struct vfio_mp_param *p = (struct vfio_mp_param *)mp_req.param;
-	int iommu_type_id;
-	unsigned int i;
-
-	/* cannot be called from primary */
-	if (rte_eal_process_type() != RTE_PROC_SECONDARY)
-		return -1;
-
-	/* default container fd should have been opened in rte_vfio_enable() */
-	if (!default_vfio_cfg->vfio_enabled ||
-			default_vfio_cfg->vfio_container_fd < 0) {
-		EAL_LOG(ERR, "VFIO support is not initialized");
-		return -1;
-	}
-
-	/* find default container's IOMMU type */
-	p->req = SOCKET_REQ_IOMMU_TYPE;
-	strcpy(mp_req.name, EAL_VFIO_MP);
-	mp_req.len_param = sizeof(*p);
-	mp_req.num_fds = 0;
-
-	iommu_type_id = -1;
-	if (rte_mp_request_sync(&mp_req, &mp_reply, &ts) == 0 &&
-			mp_reply.nb_received == 1) {
-		mp_rep = &mp_reply.msgs[0];
-		p = (struct vfio_mp_param *)mp_rep->param;
-		if (p->result == SOCKET_OK)
-			iommu_type_id = p->iommu_type_id;
-	}
-	free(mp_reply.msgs);
-	if (iommu_type_id < 0) {
-		EAL_LOG(ERR,
-			"Could not get IOMMU type for default container");
-		return -1;
-	}
-
-	/* we now have an fd for default container, as well as its IOMMU type.
-	 * now, set up default VFIO container config to match.
-	 */
-	for (i = 0; i < RTE_DIM(iommu_types); i++) {
-		const struct vfio_iommu_type *t = &iommu_types[i];
-		if (t->type_id != iommu_type_id)
-			continue;
-
-		/* we found our IOMMU type */
-		default_vfio_cfg->vfio_iommu_type = t;
-
-		return 0;
-	}
-	EAL_LOG(ERR, "Could not find IOMMU type id (%i)",
-			iommu_type_id);
-	return -1;
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_clear_group)
 int
 rte_vfio_clear_group(int vfio_group_fd)
 {
-	int i;
-	struct vfio_config *vfio_cfg;
+	struct container *cfg;
+	struct vfio_group *grp;
+	struct vfio_device *dev;
 
-	vfio_cfg = get_vfio_cfg_by_group_fd(vfio_group_fd);
-	if (vfio_cfg == NULL) {
-		EAL_LOG(ERR, "Invalid VFIO group fd!");
+	if (vfio_cfg.mode == RTE_VFIO_MODE_NONE) {
+		EAL_LOG(ERR, "VFIO support not initialized");
+		rte_errno = ENXIO;
 		return -1;
 	}
 
-	i = get_vfio_group_idx(vfio_group_fd);
-	if (i < 0)
+	if (vfio_cfg.mode != RTE_VFIO_MODE_GROUP &&
+			vfio_cfg.mode != RTE_VFIO_MODE_NOIOMMU) {
+		EAL_LOG(ERR, "VFIO not initialized in group mode");
+		rte_errno = ENOTSUP;
 		return -1;
-	vfio_cfg->vfio_groups[i].group_num = -1;
-	vfio_cfg->vfio_groups[i].fd = -1;
-	vfio_cfg->vfio_groups[i].devices = 0;
-	vfio_cfg->vfio_active_groups--;
+	}
+
+	/* find our group */
+	CONTAINER_FOREACH_ACTIVE(cfg) {
+		GROUP_FOREACH_ACTIVE(cfg, grp) {
+			if (grp->fd != vfio_group_fd)
+				continue;
+			/* clear out all devices within this group */
+			DEVICE_FOREACH_ACTIVE(cfg, dev) {
+				if (dev->group != grp->group_num)
+					continue;
+				vfio_device_erase(cfg, dev);
+			}
+			/* clear out group itself */
+			vfio_group_erase(cfg, grp);
+			return 0;
+		}
+	}
+
+	rte_errno = ENOENT;
+	return -1;
+}
+
+static int
+vfio_register_mem_event_callback(void)
+{
+	int ret;
+
+	ret = rte_mem_event_callback_register(VFIO_MEM_EVENT_CLB_NAME,
+			vfio_mem_event_callback, NULL);
+
+	if (ret && rte_errno != ENOTSUP) {
+		EAL_LOG(ERR, "Could not install memory event callback for VFIO");
+		return -1;
+	}
+	if (ret)
+		EAL_LOG(DEBUG, "Memory event callbacks not supported");
+	else
+		EAL_LOG(DEBUG, "Installed memory event callback for VFIO");
 
 	return 0;
 }
 
+static int
+vfio_setup_dma_mem(struct container *cfg)
+{
+	struct user_mem_maps *user_mem_maps = &cfg->mem_maps;
+	int i, ret;
+
+	/* do we need to map DPDK-managed memory? */
+	if (vfio_container_is_default(cfg) && rte_eal_process_type() == RTE_PROC_PRIMARY)
+		ret = vfio_cfg.ops->dma_map_func(cfg);
+	else
+		ret = 0;
+	if (ret) {
+		EAL_LOG(ERR, "DMA remapping failed, error %i (%s)",
+			errno, strerror(errno));
+		return -1;
+	}
+
+	/*
+	 * not all IOMMU types support DMA mapping, but if we have mappings in the list - that
+	 * means we have previously mapped something successfully, so we can be sure that DMA
+	 * mapping is supported.
+	 */
+	for (i = 0; i < user_mem_maps->n_maps; i++) {
+		struct user_mem_map *map;
+		map = &user_mem_maps->maps[i];
+
+		ret = vfio_cfg.ops->dma_user_map_func(cfg, map->addr, map->iova, map->len, 1);
+		if (ret) {
+			EAL_LOG(ERR, "Couldn't map user memory for DMA: "
+					"va: 0x%" PRIx64 " "
+					"iova: 0x%" PRIx64 " "
+					"len: 0x%" PRIu64,
+					map->addr, map->iova,
+					map->len);
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+static enum vfio_result
+vfio_group_assign_device(struct container *cfg, const char *sysfs_base,
+		const char *dev_addr, struct vfio_device **out_dev)
+{
+	struct vfio_group_config *group_cfg = &cfg->group_cfg;
+	struct vfio_group *grp;
+	struct vfio_device *idev, *dev;
+	int iommu_group_num;
+	enum vfio_result res;
+	int ret;
+
+	/* allocate new device in config */
+	dev = vfio_device_create(cfg);
+	if (dev == NULL) {
+		EAL_LOG(ERR, "No space to track new VFIO device");
+		return VFIO_NO_SPACE;
+	}
+
+	/* remember to register mem event callback for default container in primary */
+	bool need_clb = vfio_container_is_default(cfg) &&
+			rte_eal_process_type() == RTE_PROC_PRIMARY;
+
+	/* get group number for this device */
+	ret = vfio_group_get_num(sysfs_base, dev_addr, &iommu_group_num);
+	if (ret < 0) {
+		EAL_LOG(ERR, "Cannot get IOMMU group for %s", dev_addr);
+		res = VFIO_ERROR;
+		goto device_erase;
+	} else if (ret == 0) {
+		res = VFIO_NOT_MANAGED;
+		goto device_erase;
+	}
+
+	/* group may already exist as multiple devices may share group */
+	grp = vfio_group_get_by_num(cfg, iommu_group_num);
+	if (grp == NULL) {
+		/* no device currently uses this group, create it */
+		grp = vfio_group_create(cfg, iommu_group_num);
+		if (grp == NULL) {
+			EAL_LOG(ERR, "Cannot allocate group for device %s", dev_addr);
+			res = VFIO_NO_SPACE;
+			goto device_erase;
+		}
+
+		/* open group fd */
+		ret = vfio_group_open_fd(cfg, grp);
+		if (ret == -ENOENT) {
+			EAL_LOG(DEBUG, "Device %s (IOMMU group %d) not managed by VFIO",
+					dev_addr, iommu_group_num);
+			res = VFIO_NOT_MANAGED;
+			goto group_erase;
+		} else if (ret < 0) {
+			EAL_LOG(ERR, "Cannot open VFIO group %d for device %s",
+				iommu_group_num, dev_addr);
+			res = VFIO_ERROR;
+			goto group_erase;
+		}
+
+		/* prepare group (viability + container attach) */
+		ret = vfio_group_prepare(cfg, grp);
+		if (ret < 0) {
+			res = VFIO_ERROR;
+			goto group_erase;
+		}
+
+		/* set up IOMMU type once per container */
+		if (!group_cfg->iommu_type_set) {
+			ret = vfio_group_setup_iommu(cfg);
+			if (ret < 0) {
+				res = VFIO_ERROR;
+				goto group_erase;
+			}
+			group_cfg->iommu_type_set = true;
+		}
+
+		/* set up DMA memory once per container */
+		if (!group_cfg->dma_setup_done) {
+			rte_spinlock_recursive_lock(&cfg->mem_maps.lock);
+			ret = vfio_setup_dma_mem(cfg);
+			rte_spinlock_recursive_unlock(&cfg->mem_maps.lock);
+			if (ret < 0) {
+				EAL_LOG(ERR, "DMA remapping for %s failed", dev_addr);
+				res = VFIO_ERROR;
+				goto group_erase;
+			}
+			group_cfg->dma_setup_done = true;
+		}
+
+		/* set up mem event callback if needed */
+		if (need_clb && !group_cfg->mem_event_clb_set) {
+			ret = vfio_register_mem_event_callback();
+			if (ret < 0) {
+				res = VFIO_ERROR;
+				goto group_erase;
+			}
+			group_cfg->mem_event_clb_set = true;
+		}
+	}
+
+	/* open dev fd */
+	ret = vfio_group_setup_device_fd(dev_addr, grp, dev);
+	if (ret < 0) {
+		EAL_LOG(ERR, "Cannot open VFIO device %s, error %i (%s)",
+				dev_addr, errno, strerror(errno));
+		res = VFIO_ERROR;
+		goto group_erase;
+	}
+
+	/*
+	 * we want to prevent user from assigning devices twice to prevent resource leaks, but for
+	 * group mode this is not trivial, as there is no direct way to know which fd belongs to
+	 * which group/device, except for directly comparing fd's with stat. so, that's what we're
+	 * going to do. we do not need to look in other configs as if we were to attempt to use a
+	 * different container, the kernel wouldn't have allowed us to bind the group to the
+	 * container in the first place.
+	 */
+	DEVICE_FOREACH_ACTIVE(cfg, idev) {
+		if (idev != dev && fd_is_same(idev->fd, dev->fd)) {
+			EAL_LOG(ERR, "Device %s already assigned to this container",
+					dev_addr);
+			res = VFIO_EXISTS;
+			*out_dev = idev;
+			goto dev_remove;
+		}
+	}
+	*out_dev = dev;
+	return VFIO_SUCCESS;
+dev_remove:
+	/* device will be closed, but we still need to keep the group consistent */
+	grp->n_devices--;
+group_erase:
+	/* this may be a pre-existing group so only erase it if it has no devices */
+	if (grp->n_devices == 0)
+		vfio_group_erase(cfg, grp);
+	/* if we registered callback, unregister it */
+	if (group_cfg->n_groups == 0 && group_cfg->mem_event_clb_set) {
+		rte_mem_event_callback_unregister(VFIO_MEM_EVENT_CLB_NAME, NULL);
+		group_cfg->mem_event_clb_set = false;
+	}
+device_erase:
+	vfio_device_erase(cfg, dev);
+	return res;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_assign_device)
+int
+rte_vfio_container_assign_device(int container_fd, const char *sysfs_base, const char *dev_addr)
+{
+	struct container *cfg;
+	enum vfio_result res;
+	struct vfio_device *dev;
+
+	if (sysfs_base == NULL || dev_addr == NULL) {
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	if (vfio_cfg.mode == RTE_VFIO_MODE_NONE) {
+		EAL_LOG(ERR, "VFIO support not initialized");
+		rte_errno = ENXIO;
+		return -1;
+	}
+
+	cfg = vfio_container_get_by_fd(container_fd);
+	if (cfg == NULL) {
+		EAL_LOG(ERR, "Invalid VFIO container fd");
+		rte_errno = EINVAL;
+		return -1;
+	}
+	/* protect memory configuration while setting up IOMMU/DMA */
+	rte_mcfg_mem_read_lock();
+
+	switch (vfio_cfg.mode) {
+	case RTE_VFIO_MODE_GROUP:
+	case RTE_VFIO_MODE_NOIOMMU:
+		res = vfio_group_assign_device(cfg, sysfs_base, dev_addr, &dev);
+		break;
+	default:
+		EAL_LOG(ERR, "Unsupported VFIO mode");
+		res = VFIO_NOT_SUPPORTED;
+		break;
+	}
+	rte_mcfg_mem_read_unlock();
+
+	switch (res) {
+	case VFIO_SUCCESS:
+		return 0;
+	case VFIO_EXISTS:
+		rte_errno = EEXIST;
+		return -1;
+	case VFIO_NOT_MANAGED:
+		EAL_LOG(DEBUG, "Device %s not managed by VFIO", dev_addr);
+		rte_errno = ENODEV;
+		return -1;
+	case VFIO_NO_SPACE:
+		EAL_LOG(ERR, "No space in VFIO container to assign device %s", dev_addr);
+		rte_errno = ENOSPC;
+		return -1;
+	default:
+		EAL_LOG(ERR, "Error assigning device %s to container", dev_addr);
+		rte_errno = EIO;
+		return -1;
+	}
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_setup_device)
 int
 rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		int *vfio_dev_fd)
 {
-	struct vfio_group_status group_status = {
-			.argsz = sizeof(group_status)
-	};
-	struct vfio_config *vfio_cfg;
-	struct user_mem_maps *user_mem_maps;
-	int vfio_container_fd;
-	int vfio_group_fd;
-	int iommu_group_num;
-	rte_uuid_t vf_token;
-	int i, ret;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
-
-	/* get group number */
-	ret = rte_vfio_get_group_num(sysfs_base, dev_addr, &iommu_group_num);
-	if (ret == 0) {
-		EAL_LOG(NOTICE,
-				"%s not managed by VFIO driver, skipping",
-				dev_addr);
-		return 1;
-	}
-
-	/* if negative, something failed */
-	if (ret < 0)
-		return -1;
-
-	/* get the actual group fd */
-	vfio_group_fd = rte_vfio_get_group_fd(iommu_group_num);
-	if (vfio_group_fd < 0 && vfio_group_fd != -ENOENT)
-		return -1;
-
-	/*
-	 * if vfio_group_fd == -ENOENT, that means the device
-	 * isn't managed by VFIO
-	 */
-	if (vfio_group_fd == -ENOENT) {
-		EAL_LOG(NOTICE,
-				"%s not managed by VFIO driver, skipping",
-				dev_addr);
-		return 1;
-	}
-
-	/*
-	 * at this point, we know that this group is viable (meaning, all devices
-	 * are either bound to VFIO or not bound to anything)
-	 */
-
-	/* check if the group is viable */
-	ret = ioctl(vfio_group_fd, VFIO_GROUP_GET_STATUS, &group_status);
-	if (ret) {
-		EAL_LOG(ERR, "%s cannot get VFIO group status, "
-			"error %i (%s)", dev_addr, errno, strerror(errno));
-		close(vfio_group_fd);
-		rte_vfio_clear_group(vfio_group_fd);
-		return -1;
-	} else if (!(group_status.flags & VFIO_GROUP_FLAGS_VIABLE)) {
-		EAL_LOG(ERR, "%s VFIO group is not viable! "
-			"Not all devices in IOMMU group bound to VFIO or unbound",
-			dev_addr);
-		close(vfio_group_fd);
-		rte_vfio_clear_group(vfio_group_fd);
-		return -1;
-	}
-
-	/* get the vfio_config it belongs to */
-	vfio_cfg = get_vfio_cfg_by_group_num(iommu_group_num);
-	vfio_cfg = vfio_cfg ? vfio_cfg : default_vfio_cfg;
-	vfio_container_fd = vfio_cfg->vfio_container_fd;
-	user_mem_maps = &vfio_cfg->mem_maps;
-
-	/* check if group does not have a container yet */
-	if (!(group_status.flags & VFIO_GROUP_FLAGS_CONTAINER_SET)) {
-
-		/* add group to a container */
-		ret = ioctl(vfio_group_fd, VFIO_GROUP_SET_CONTAINER,
-				&vfio_container_fd);
-		if (ret) {
-			EAL_LOG(ERR,
-				"%s cannot add VFIO group to container, error "
-				"%i (%s)", dev_addr, errno, strerror(errno));
-			close(vfio_group_fd);
-			rte_vfio_clear_group(vfio_group_fd);
-			return -1;
-		}
-
-		/*
-		 * pick an IOMMU type and set up DMA mappings for container
-		 *
-		 * needs to be done only once, only when first group is
-		 * assigned to a container and only in primary process.
-		 * Note this can happen several times with the hotplug
-		 * functionality.
-		 */
-		if (internal_conf->process_type == RTE_PROC_PRIMARY &&
-				vfio_cfg->vfio_active_groups == 1 &&
-				vfio_group_device_count(vfio_group_fd) == 0) {
-			const struct vfio_iommu_type *t;
-
-			/* select an IOMMU type which we will be using */
-			t = vfio_set_iommu_type(vfio_container_fd);
-			if (!t) {
-				EAL_LOG(ERR,
-					"%s failed to select IOMMU type",
-					dev_addr);
-				close(vfio_group_fd);
-				rte_vfio_clear_group(vfio_group_fd);
-				return -1;
-			}
-			/* lock memory hotplug before mapping and release it
-			 * after registering callback, to prevent races
-			 */
-			rte_mcfg_mem_read_lock();
-			if (vfio_cfg == default_vfio_cfg)
-				ret = t->dma_map_func(vfio_container_fd);
-			else
-				ret = 0;
-			if (ret) {
-				EAL_LOG(ERR,
-					"%s DMA remapping failed, error "
-					"%i (%s)",
-					dev_addr, errno, strerror(errno));
-				close(vfio_group_fd);
-				rte_vfio_clear_group(vfio_group_fd);
-				rte_mcfg_mem_read_unlock();
-				return -1;
-			}
-
-			vfio_cfg->vfio_iommu_type = t;
-
-			/* re-map all user-mapped segments */
-			rte_spinlock_recursive_lock(&user_mem_maps->lock);
-
-			/* this IOMMU type may not support DMA mapping, but
-			 * if we have mappings in the list - that means we have
-			 * previously mapped something successfully, so we can
-			 * be sure that DMA mapping is supported.
-			 */
-			for (i = 0; i < user_mem_maps->n_maps; i++) {
-				struct user_mem_map *map;
-				map = &user_mem_maps->maps[i];
-
-				ret = t->dma_user_map_func(
-						vfio_container_fd,
-						map->addr, map->iova, map->len,
-						1);
-				if (ret) {
-					EAL_LOG(ERR, "Couldn't map user memory for DMA: "
-							"va: 0x%" PRIx64 " "
-							"iova: 0x%" PRIx64 " "
-							"len: 0x%" PRIu64,
-							map->addr, map->iova,
-							map->len);
-					rte_spinlock_recursive_unlock(
-							&user_mem_maps->lock);
-					rte_mcfg_mem_read_unlock();
-					return -1;
-				}
-			}
-			rte_spinlock_recursive_unlock(&user_mem_maps->lock);
-
-			/* register callback for mem events */
-			if (vfio_cfg == default_vfio_cfg)
-				ret = rte_mem_event_callback_register(
-					VFIO_MEM_EVENT_CLB_NAME,
-					vfio_mem_event_callback, NULL);
-			else
-				ret = 0;
-			/* unlock memory hotplug */
-			rte_mcfg_mem_read_unlock();
-
-			if (ret && rte_errno != ENOTSUP) {
-				EAL_LOG(ERR, "Could not install memory event callback for VFIO");
-				return -1;
-			}
-			if (ret)
-				EAL_LOG(DEBUG, "Memory event callbacks not supported");
-			else
-				EAL_LOG(DEBUG, "Installed memory event callback for VFIO");
-		}
-	} else if (rte_eal_process_type() != RTE_PROC_PRIMARY &&
-			vfio_cfg == default_vfio_cfg &&
-			vfio_cfg->vfio_iommu_type == NULL) {
-		/* if we're not a primary process, we do not set up the VFIO
-		 * container because it's already been set up by the primary
-		 * process. instead, we simply ask the primary about VFIO type
-		 * we are using, and set the VFIO config up appropriately.
-		 */
-		ret = vfio_sync_default_container();
-		if (ret < 0) {
-			EAL_LOG(ERR, "Could not sync default VFIO container");
-			close(vfio_group_fd);
-			rte_vfio_clear_group(vfio_group_fd);
-			return -1;
-		}
-		/* we have successfully initialized VFIO, notify user */
-		const struct vfio_iommu_type *t =
-				default_vfio_cfg->vfio_iommu_type;
-		EAL_LOG(INFO, "Using IOMMU type %d (%s)",
-				t->type_id, t->name);
-	}
-
-	rte_eal_vfio_get_vf_token(vf_token);
-
-	/* get a file descriptor for the device with VF token firstly */
-	if (!rte_uuid_is_null(vf_token)) {
-		char vf_token_str[RTE_UUID_STRLEN];
-		char dev[PATH_MAX];
-
-		rte_uuid_unparse(vf_token, vf_token_str, sizeof(vf_token_str));
-		snprintf(dev, sizeof(dev),
-			 "%s vf_token=%s", dev_addr, vf_token_str);
-
-		*vfio_dev_fd = ioctl(vfio_group_fd, VFIO_GROUP_GET_DEVICE_FD,
-				     dev);
-		if (*vfio_dev_fd >= 0)
-			goto out;
-	}
-
-	/* get a file descriptor for the device */
-	*vfio_dev_fd = ioctl(vfio_group_fd, VFIO_GROUP_GET_DEVICE_FD, dev_addr);
-	if (*vfio_dev_fd < 0) {
-		/* if we cannot get a device fd, this implies a problem with
-		 * the VFIO group or the container not having IOMMU configured.
-		 */
-
-		EAL_LOG(WARNING, "Getting a vfio_dev_fd for %s failed",
-				dev_addr);
-		close(vfio_group_fd);
-		rte_vfio_clear_group(vfio_group_fd);
-		return -1;
-	}
-
-	/* device is now set up */
-out:
-	vfio_group_device_get(vfio_group_fd);
-
-	return 0;
-}
-
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_release_device)
-int
-rte_vfio_release_device(const char *sysfs_base, const char *dev_addr,
-		    int vfio_dev_fd)
-{
-	struct vfio_config *vfio_cfg;
-	int vfio_group_fd;
-	int iommu_group_num;
+	struct container *cfg;
+	struct vfio_device *dev;
+	enum vfio_result res;
 	int ret;
 
-	/* we don't want any DMA mapping messages to come while we're detaching
-	 * VFIO device, because this might be the last device and we might need
-	 * to unregister the callback.
-	 */
+	if (sysfs_base == NULL || dev_addr == NULL || vfio_dev_fd == NULL) {
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	if (vfio_cfg.mode == RTE_VFIO_MODE_NONE) {
+		EAL_LOG(ERR, "VFIO support not initialized");
+		rte_errno = ENXIO;
+		return -1;
+	}
+
 	rte_mcfg_mem_read_lock();
 
-	/* get group number */
-	ret = rte_vfio_get_group_num(sysfs_base, dev_addr, &iommu_group_num);
-	if (ret <= 0) {
-		EAL_LOG(WARNING, "%s not managed by VFIO driver",
-			dev_addr);
-		/* This is an error at this point. */
-		ret = -1;
-		goto out;
-	}
-
-	/* get the actual group fd */
-	vfio_group_fd = rte_vfio_get_group_fd(iommu_group_num);
-	if (vfio_group_fd < 0) {
-		EAL_LOG(INFO, "rte_vfio_get_group_fd failed for %s",
-				   dev_addr);
-		ret = vfio_group_fd;
-		goto out;
-	}
-
-	/* get the vfio_config it belongs to */
-	vfio_cfg = get_vfio_cfg_by_group_num(iommu_group_num);
-	vfio_cfg = vfio_cfg ? vfio_cfg : default_vfio_cfg;
+	switch (vfio_cfg.mode) {
+	case RTE_VFIO_MODE_GROUP:
+	case RTE_VFIO_MODE_NOIOMMU:
+	{
+		int iommu_group_num;
+
+		/* find group number */
+		ret = vfio_group_get_num(sysfs_base, dev_addr, &iommu_group_num);
+		if (ret < 0) {
+			EAL_LOG(ERR, "Cannot get IOMMU group for %s", dev_addr);
+			goto unlock;
+		} else if (ret == 0) {
+			EAL_LOG(DEBUG, "Device %s not managed by VFIO", dev_addr);
+			ret = 1;
+			goto unlock;
+		}
 
-	/* At this point we got an active group. Closing it will make the
-	 * container detachment. If this is the last active group, VFIO kernel
-	 * code will unset the container and the IOMMU mappings.
-	 */
+		/* find config by group */
+		cfg = vfio_container_get_by_group_num(iommu_group_num);
+		if (cfg == NULL)
+			cfg = vfio_cfg.default_cfg;
 
-	/* Closing a device */
-	if (close(vfio_dev_fd) < 0) {
-		EAL_LOG(INFO, "Error when closing vfio_dev_fd for %s",
-				   dev_addr);
+		res = vfio_group_assign_device(cfg, sysfs_base, dev_addr, &dev);
+		break;
+	}
+	default:
+		EAL_LOG(ERR, "Unsupported VFIO mode");
+		rte_errno = ENOTSUP;
 		ret = -1;
-		goto out;
+		goto unlock;
 	}
 
-	/* An VFIO group can have several devices attached. Just when there is
-	 * no devices remaining should the group be closed.
-	 */
-	vfio_group_device_put(vfio_group_fd);
-	if (!vfio_group_device_count(vfio_group_fd)) {
-
-		if (close(vfio_group_fd) < 0) {
-			EAL_LOG(INFO, "Error when closing vfio_group_fd for %s",
-				dev_addr);
-			ret = -1;
-			goto out;
-		}
-
-		if (rte_vfio_clear_group(vfio_group_fd) < 0) {
-			EAL_LOG(INFO, "Error when clearing group for %s",
-					   dev_addr);
-			ret = -1;
-			goto out;
-		}
+	switch (res) {
+	case VFIO_NOT_MANAGED:
+		EAL_LOG(DEBUG, "Device %s not managed by VFIO", dev_addr);
+		rte_errno = ENODEV;
+		ret = -1;
+		goto unlock;
+	case VFIO_SUCCESS:
+	case VFIO_EXISTS:
+		break;
+	case VFIO_NO_SPACE:
+		EAL_LOG(ERR, "No space in VFIO container to assign device %s", dev_addr);
+		rte_errno = ENOSPC;
+		ret = -1;
+		goto unlock;
+	default:
+		EAL_LOG(ERR, "Error assigning device %s to container", dev_addr);
+		rte_errno = EIO;
+		ret = -1;
+		goto unlock;
 	}
-
-	/* if there are no active device groups, unregister the callback to
-	 * avoid spurious attempts to map/unmap memory from VFIO.
-	 */
-	if (vfio_cfg == default_vfio_cfg && vfio_cfg->vfio_active_groups == 0 &&
-			rte_eal_process_type() != RTE_PROC_SECONDARY)
-		rte_mem_event_callback_unregister(VFIO_MEM_EVENT_CLB_NAME,
-				NULL);
+	*vfio_dev_fd = dev->fd;
 
 	/* success */
 	ret = 0;
 
-out:
+unlock:
 	rte_mcfg_mem_read_unlock();
+
 	return ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_release_device)
+int
+rte_vfio_release_device(const char *sysfs_base __rte_unused,
+		const char *dev_addr, int vfio_dev_fd)
+{
+	struct container *cfg = NULL, *icfg;
+	struct vfio_device *dev = NULL, *idev;
+	int ret;
+
+	if (sysfs_base == NULL || dev_addr == NULL) {
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	if (vfio_cfg.mode == RTE_VFIO_MODE_NONE) {
+		EAL_LOG(ERR, "VFIO support not initialized");
+		rte_errno = ENXIO;
+		return -1;
+	}
+
+	rte_mcfg_mem_read_lock();
+
+	/* we need to find both config and device */
+	CONTAINER_FOREACH_ACTIVE(icfg) {
+		DEVICE_FOREACH_ACTIVE(icfg, idev) {
+			if (idev->fd != vfio_dev_fd)
+				continue;
+			cfg = icfg;
+			dev = idev;
+			goto found;
+		}
+	}
+found:
+	if (dev == NULL) {
+		EAL_LOG(ERR, "Device %s not managed by any container", dev_addr);
+		rte_errno = ENOENT;
+		ret = -1;
+		goto unlock;
+	}
+
+	switch (vfio_cfg.mode) {
+	case RTE_VFIO_MODE_GROUP:
+	case RTE_VFIO_MODE_NOIOMMU:
+	{
+		int iommu_group_num = dev->group;
+		struct vfio_group_config *group_cfg = &cfg->group_cfg;
+		struct vfio_group *grp;
+
+		bool need_clb = vfio_container_is_default(cfg) &&
+				rte_eal_process_type() == RTE_PROC_PRIMARY;
+
+		/* find the group */
+		grp = vfio_group_get_by_num(cfg, iommu_group_num);
+		if (grp == NULL) {
+			/* shouldn't happen because we already know the device is valid */
+			EAL_LOG(ERR, "IOMMU group %d not found in container",
+					iommu_group_num);
+			rte_errno = EIO;
+			ret = -1;
+			goto unlock;
+		}
+
+		/* close device handle */
+		vfio_device_erase(cfg, dev);
+
+		/* remove device from group */
+		grp->n_devices--;
+
+		/* was this the last device? */
+		if (grp->n_devices == 0)
+			vfio_group_erase(cfg, grp);
+
+		/* if no more groups left, remove callback */
+		if (need_clb && group_cfg->n_groups == 0 && group_cfg->mem_event_clb_set) {
+			rte_mem_event_callback_unregister(VFIO_MEM_EVENT_CLB_NAME, NULL);
+			group_cfg->mem_event_clb_set = false;
+		}
+		break;
+	}
+	default:
+		EAL_LOG(ERR, "Unsupported VFIO mode");
+		rte_errno = ENOTSUP;
+		ret = -1;
+		goto unlock;
+	}
+	ret = 0;
+unlock:
+	rte_mcfg_mem_read_unlock();
+
+	return ret;
+}
+
+static int
+vfio_sync_mode(struct container *cfg, enum rte_vfio_mode *mode)
+{
+	struct vfio_mp_param *p;
+	struct rte_mp_msg mp_req = {0};
+	struct rte_mp_reply mp_reply = {0};
+	struct timespec ts = {5, 0};
+
+	/* request iommufd from primary via mp_sync */
+	rte_strscpy(mp_req.name, EAL_VFIO_MP, sizeof(mp_req.name));
+	mp_req.len_param = sizeof(*p);
+	mp_req.num_fds = 0;
+	p = (struct vfio_mp_param *)mp_req.param;
+	p->req = SOCKET_REQ_CONTAINER;
+
+	if (rte_mp_request_sync(&mp_req, &mp_reply, &ts) == 0 &&
+			mp_reply.nb_received == 1) {
+		struct rte_mp_msg *mp_rep;
+		mp_rep = &mp_reply.msgs[0];
+		p = (struct vfio_mp_param *)mp_rep->param;
+		if (p->result == SOCKET_OK && mp_rep->num_fds == 1) {
+			cfg->container_fd = mp_rep->fds[0];
+			*mode = p->mode;
+			free(mp_reply.msgs);
+			return 0;
+		}
+	}
+
+	free(mp_reply.msgs);
+	EAL_LOG(ERR, "Cannot request container_fd");
+	return -1;
+}
+
+static enum rte_vfio_mode
+vfio_select_mode(void)
+{
+	struct container *cfg;
+	enum rte_vfio_mode mode = RTE_VFIO_MODE_NONE;
+
+	cfg = vfio_container_create();
+	/* cannot happen */
+	if (cfg == NULL || cfg != vfio_cfg.default_cfg) {
+		EAL_LOG(ERR, "Unexpected VFIO config structure");
+		return RTE_VFIO_MODE_NONE;
+	}
+
+	/* for secondary, just ask the primary for the container and mode */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		struct vfio_group_config *group_cfg = &cfg->group_cfg;
+
+		if (vfio_sync_mode(cfg, &mode) < 0)
+			goto err;
+
+		/* primary handles DMA setup for default containers */
+		group_cfg->dma_setup_done = true;
+		return mode;
+	}
+	/* if we failed mp sync setup, we cannot initialize VFIO */
+	if (vfio_mp_sync_setup() < 0)
+		return RTE_VFIO_MODE_NONE;
+
+	/* try group mode first */
+	if (vfio_group_enable(cfg) == 0) {
+		/* check for noiommu */
+		int ret = vfio_group_noiommu_is_enabled();
+		if (ret < 0)
+			goto err_mpsync;
+		else if (ret == 1)
+			return RTE_VFIO_MODE_NOIOMMU;
+		return RTE_VFIO_MODE_GROUP;
+	}
+err_mpsync:
+	vfio_mp_sync_cleanup();
+err:
+	vfio_container_erase(cfg);
+
+	return RTE_VFIO_MODE_NONE;
+}
+
+static const char *
+vfio_mode_to_str(enum rte_vfio_mode mode)
+{
+	switch (mode) {
+	case RTE_VFIO_MODE_GROUP: return "group";
+	case RTE_VFIO_MODE_NOIOMMU: return "noiommu";
+	default: return "not initialized";
+	}
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_enable)
 int
 rte_vfio_enable(const char *modname)
 {
-	/* initialize group list */
-	unsigned int i, j;
 	int vfio_available;
-	DIR *dir;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	enum rte_vfio_mode mode = RTE_VFIO_MODE_NONE;
 
-	rte_spinlock_recursive_t lock = RTE_SPINLOCK_RECURSIVE_INITIALIZER;
-
-	for (i = 0; i < RTE_DIM(vfio_cfgs); i++) {
-		vfio_cfgs[i].vfio_container_fd = -1;
-		vfio_cfgs[i].vfio_active_groups = 0;
-		vfio_cfgs[i].vfio_iommu_type = NULL;
-		vfio_cfgs[i].mem_maps.lock = lock;
-
-		for (j = 0; j < RTE_DIM(vfio_cfgs[i].vfio_groups); j++) {
-			vfio_cfgs[i].vfio_groups[j].fd = -1;
-			vfio_cfgs[i].vfio_groups[j].group_num = -1;
-			vfio_cfgs[i].vfio_groups[j].devices = 0;
-		}
+	if (modname == NULL) {
+		rte_errno = EINVAL;
+		return -1;
 	}
 
 	EAL_LOG(DEBUG, "Probing VFIO support...");
@@ -1131,36 +1112,16 @@ rte_vfio_enable(const char *modname)
 			"VFIO modules not loaded, skipping VFIO support...");
 		return 0;
 	}
+	EAL_LOG(DEBUG, "VFIO module '%s' loaded, attempting to initialize VFIO...", modname);
+	mode = vfio_select_mode();
 
-	/* VFIO directory might not exist (e.g., unprivileged containers) */
-	dir = opendir(RTE_VFIO_DIR);
-	if (dir == NULL) {
-		EAL_LOG(DEBUG,
-			"VFIO directory does not exist, skipping VFIO support...");
-		return 0;
-	}
-	closedir(dir);
-
-	if (internal_conf->process_type == RTE_PROC_PRIMARY) {
-		if (vfio_mp_sync_setup() == -1) {
-			default_vfio_cfg->vfio_container_fd = -1;
-		} else {
-			/* open a default container */
-			default_vfio_cfg->vfio_container_fd = vfio_open_container_fd(false);
-		}
-	} else {
-		/* get the default container from the primary process */
-		default_vfio_cfg->vfio_container_fd =
-			vfio_open_container_fd(true);
-	}
-
-	/* check if we have VFIO driver enabled */
-	if (default_vfio_cfg->vfio_container_fd != -1) {
-		EAL_LOG(INFO, "VFIO support initialized");
-		default_vfio_cfg->vfio_enabled = 1;
-	} else {
+	/* have we initialized anything? */
+	if (mode == RTE_VFIO_MODE_NONE)
 		EAL_LOG(NOTICE, "VFIO support could not be initialized");
-	}
+	else
+		EAL_LOG(NOTICE, "VFIO support initialized: %s mode", vfio_mode_to_str(mode));
+
+	vfio_cfg.mode = mode;
 
 	return 0;
 }
@@ -1169,40 +1130,17 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_is_enabled)
 int
 rte_vfio_is_enabled(const char *modname)
 {
-	const int mod_available = rte_eal_check_module(modname) > 0;
-	return default_vfio_cfg->vfio_enabled && mod_available;
+	const int mod_available = modname ? rte_eal_check_module(modname) > 0 : 0;
+	return vfio_cfg.default_cfg->active && mod_available;
 }
 
 int
 vfio_get_iommu_type(void)
 {
-	if (default_vfio_cfg->vfio_iommu_type == NULL)
+	if (vfio_cfg.ops == NULL)
 		return -1;
 
-	return default_vfio_cfg->vfio_iommu_type->type_id;
-}
-
-const struct vfio_iommu_type *
-vfio_set_iommu_type(int vfio_container_fd)
-{
-	unsigned idx;
-	for (idx = 0; idx < RTE_DIM(iommu_types); idx++) {
-		const struct vfio_iommu_type *t = &iommu_types[idx];
-
-		int ret = ioctl(vfio_container_fd, VFIO_SET_IOMMU,
-				t->type_id);
-		if (!ret) {
-			EAL_LOG(INFO, "Using IOMMU type %d (%s)",
-					t->type_id, t->name);
-			return t;
-		}
-		/* not an error, there may be more supported IOMMU types */
-		EAL_LOG(DEBUG, "Set IOMMU type %d (%s) failed, error "
-				"%i (%s)", t->type_id, t->name, errno,
-				strerror(errno));
-	}
-	/* if we didn't find a suitable IOMMU type, fail */
-	return NULL;
+	return vfio_cfg.ops->type_id;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_device_info)
@@ -1211,126 +1149,27 @@ rte_vfio_get_device_info(int vfio_dev_fd, struct vfio_device_info *device_info)
 {
 	int ret;
 
-	if (device_info == NULL || vfio_dev_fd < 0)
+	if (device_info == NULL) {
+		rte_errno = EINVAL;
 		return -1;
+	}
+
+	if (vfio_cfg.mode == RTE_VFIO_MODE_NONE) {
+		EAL_LOG(ERR, "VFIO support not initialized");
+		rte_errno = ENXIO;
+		return -1;
+	}
 
 	ret = ioctl(vfio_dev_fd, VFIO_DEVICE_GET_INFO, device_info);
 	if (ret) {
-		EAL_LOG(ERR, "Cannot get device info, error %i (%s)",
-				errno, strerror(errno));
+		EAL_LOG(ERR, "Cannot get device info, error %d (%s)", errno, strerror(errno));
+		rte_errno = errno;
 		return -1;
 	}
 
 	return 0;
 }
 
-int
-vfio_has_supported_extensions(int vfio_container_fd)
-{
-	int ret;
-	unsigned idx, n_extensions = 0;
-	for (idx = 0; idx < RTE_DIM(iommu_types); idx++) {
-		const struct vfio_iommu_type *t = &iommu_types[idx];
-
-		ret = ioctl(vfio_container_fd, VFIO_CHECK_EXTENSION,
-				t->type_id);
-		if (ret < 0) {
-			EAL_LOG(ERR, "Could not get IOMMU type, error "
-					"%i (%s)", errno, strerror(errno));
-			close(vfio_container_fd);
-			return -1;
-		} else if (ret == 1) {
-			/* we found a supported extension */
-			n_extensions++;
-		}
-		EAL_LOG(DEBUG, "IOMMU type %d (%s) is %s",
-				t->type_id, t->name,
-				ret ? "supported" : "not supported");
-	}
-
-	/* if we didn't find any supported IOMMU types, fail */
-	if (!n_extensions) {
-		close(vfio_container_fd);
-		return -1;
-	}
-
-	return 0;
-}
-
-/*
- * Open a new VFIO container fd.
- *
- * If mp_request is true, requests a new container fd from the primary process
- * via mp channel (for secondary processes that need to open the default container).
- *
- * Otherwise, opens a new container fd locally by opening /dev/vfio/vfio.
- */
-int
-vfio_open_container_fd(bool mp_request)
-{
-	int ret, vfio_container_fd;
-	struct rte_mp_msg mp_req, *mp_rep;
-	struct rte_mp_reply mp_reply = {0};
-	struct timespec ts = {.tv_sec = 5, .tv_nsec = 0};
-	struct vfio_mp_param *p = (struct vfio_mp_param *)mp_req.param;
-
-	/* if not requesting via mp, open a new container locally */
-	if (!mp_request) {
-		vfio_container_fd = open(RTE_VFIO_CONTAINER_PATH, O_RDWR);
-		if (vfio_container_fd < 0) {
-			EAL_LOG(ERR, "Cannot open VFIO container %s, error %i (%s)",
-				RTE_VFIO_CONTAINER_PATH, errno, strerror(errno));
-			return -1;
-		}
-
-		/* check VFIO API version */
-		ret = ioctl(vfio_container_fd, VFIO_GET_API_VERSION);
-		if (ret != VFIO_API_VERSION) {
-			if (ret < 0)
-				EAL_LOG(ERR,
-					"Could not get VFIO API version, error "
-					"%i (%s)", errno, strerror(errno));
-			else
-				EAL_LOG(ERR, "Unsupported VFIO API version!");
-			close(vfio_container_fd);
-			return -1;
-		}
-
-		ret = vfio_has_supported_extensions(vfio_container_fd);
-		if (ret) {
-			EAL_LOG(ERR,
-				"No supported IOMMU extensions found!");
-			return -1;
-		}
-
-		return vfio_container_fd;
-	}
-	/*
-	 * if we're in a secondary process, request container fd from the
-	 * primary process via mp channel
-	 */
-	p->req = SOCKET_REQ_CONTAINER;
-	strcpy(mp_req.name, EAL_VFIO_MP);
-	mp_req.len_param = sizeof(*p);
-	mp_req.num_fds = 0;
-
-	vfio_container_fd = -1;
-	if (rte_mp_request_sync(&mp_req, &mp_reply, &ts) == 0 &&
-	    mp_reply.nb_received == 1) {
-		mp_rep = &mp_reply.msgs[0];
-		p = (struct vfio_mp_param *)mp_rep->param;
-		if (p->result == SOCKET_OK && mp_rep->num_fds == 1) {
-			vfio_container_fd = mp_rep->fds[0];
-			free(mp_reply.msgs);
-			return vfio_container_fd;
-		}
-	}
-
-	free(mp_reply.msgs);
-	EAL_LOG(ERR, "Cannot request VFIO container fd");
-	return -1;
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_container_fd)
 int
 rte_vfio_get_container_fd(void)
@@ -1339,511 +1178,54 @@ rte_vfio_get_container_fd(void)
 	 * The default container is set up during rte_vfio_enable().
 	 * This function does not create a new container.
 	 */
-	if (!default_vfio_cfg->vfio_enabled)
-		return -1;
+	if (vfio_cfg.mode != RTE_VFIO_MODE_NONE)
+		return vfio_cfg.default_cfg->container_fd;
 
-	return default_vfio_cfg->vfio_container_fd;
+	EAL_LOG(ERR, "VFIO support not initialized");
+	rte_errno = ENXIO;
+	return -1;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_group_num)
 int
-rte_vfio_get_group_num(const char *sysfs_base,
-		const char *dev_addr, int *iommu_group_num)
+rte_vfio_get_group_num(const char *sysfs_base, const char *dev_addr, int *iommu_group_num)
 {
-	char linkname[PATH_MAX];
-	char filename[PATH_MAX];
-	char *tok[16], *group_tok, *end;
 	int ret;
 
-	memset(linkname, 0, sizeof(linkname));
-	memset(filename, 0, sizeof(filename));
-
-	/* try to find out IOMMU group for this device */
-	snprintf(linkname, sizeof(linkname),
-			 "%s/%s/iommu_group", sysfs_base, dev_addr);
-
-	ret = readlink(linkname, filename, sizeof(filename));
-
-	/* if the link doesn't exist, no VFIO for us */
-	if (ret < 0)
-		return 0;
-
-	ret = rte_strsplit(filename, sizeof(filename),
-			tok, RTE_DIM(tok), '/');
-
-	if (ret <= 0) {
-		EAL_LOG(ERR, "%s cannot get IOMMU group", dev_addr);
-		return -1;
-	}
-
-	/* IOMMU group is always the last token */
-	errno = 0;
-	group_tok = tok[ret - 1];
-	end = group_tok;
-	*iommu_group_num = strtol(group_tok, &end, 10);
-	if ((end != group_tok && *end != '\0') || errno != 0) {
-		EAL_LOG(ERR, "%s error parsing IOMMU number!", dev_addr);
-		return -1;
-	}
-
-	return 1;
-}
-
-static int
-type1_map(const struct rte_memseg_list *msl, const struct rte_memseg *ms,
-		void *arg)
-{
-	int *vfio_container_fd = arg;
-
-	/* skip external memory that isn't a heap */
-	if (msl->external && !msl->heap)
-		return 0;
-
-	/* skip any segments with invalid IOVA addresses */
-	if (ms->iova == RTE_BAD_IOVA)
-		return 0;
-
-	return vfio_type1_dma_mem_map(*vfio_container_fd, ms->addr_64, ms->iova,
-			ms->len, 1);
-}
-
-static int
-vfio_type1_dma_mem_map(int vfio_container_fd, uint64_t vaddr, uint64_t iova,
-		uint64_t len, int do_map)
-{
-	struct vfio_iommu_type1_dma_map dma_map;
-	struct vfio_iommu_type1_dma_unmap dma_unmap;
-	int ret;
-
-	if (do_map != 0) {
-		memset(&dma_map, 0, sizeof(dma_map));
-		dma_map.argsz = sizeof(struct vfio_iommu_type1_dma_map);
-		dma_map.vaddr = vaddr;
-		dma_map.size = len;
-		dma_map.iova = iova;
-		dma_map.flags = VFIO_DMA_MAP_FLAG_READ |
-				VFIO_DMA_MAP_FLAG_WRITE;
-
-		ret = ioctl(vfio_container_fd, VFIO_IOMMU_MAP_DMA, &dma_map);
-		if (ret) {
-			/**
-			 * In case the mapping was already done EEXIST will be
-			 * returned from kernel.
-			 */
-			if (errno == EEXIST) {
-				EAL_LOG(DEBUG,
-					"Memory segment is already mapped, skipping");
-			} else {
-				EAL_LOG(ERR,
-					"Cannot set up DMA remapping, error "
-					"%i (%s)", errno, strerror(errno));
-				return -1;
-			}
-		}
-	} else {
-		memset(&dma_unmap, 0, sizeof(dma_unmap));
-		dma_unmap.argsz = sizeof(struct vfio_iommu_type1_dma_unmap);
-		dma_unmap.size = len;
-		dma_unmap.iova = iova;
-
-		ret = ioctl(vfio_container_fd, VFIO_IOMMU_UNMAP_DMA,
-				&dma_unmap);
-		if (ret) {
-			EAL_LOG(ERR, "Cannot clear DMA remapping, error "
-					"%i (%s)", errno, strerror(errno));
-			return -1;
-		} else if (dma_unmap.size != len) {
-			EAL_LOG(ERR, "Unexpected size %"PRIu64
-				" of DMA remapping cleared instead of %"PRIu64,
-				(uint64_t)dma_unmap.size, len);
-			rte_errno = EIO;
-			return -1;
-		}
-	}
-
-	return 0;
-}
-
-static int
-vfio_type1_dma_map(int vfio_container_fd)
-{
-	return rte_memseg_walk(type1_map, &vfio_container_fd);
-}
-
-/* Track the size of the statically allocated DMA window for SPAPR */
-uint64_t spapr_dma_win_len;
-uint64_t spapr_dma_win_page_sz;
-
-static int
-vfio_spapr_dma_do_map(int vfio_container_fd, uint64_t vaddr, uint64_t iova,
-		uint64_t len, int do_map)
-{
-	struct vfio_iommu_spapr_register_memory reg = {
-		.argsz = sizeof(reg),
-		.vaddr = (uintptr_t) vaddr,
-		.size = len,
-		.flags = 0
-	};
-	int ret;
-
-	if (do_map != 0) {
-		struct vfio_iommu_type1_dma_map dma_map;
-
-		if (iova + len > spapr_dma_win_len) {
-			EAL_LOG(ERR, "DMA map attempt outside DMA window");
-			return -1;
-		}
-
-		ret = ioctl(vfio_container_fd,
-				VFIO_IOMMU_SPAPR_REGISTER_MEMORY, &reg);
-		if (ret) {
-			EAL_LOG(ERR,
-				"Cannot register vaddr for IOMMU, error "
-				"%i (%s)", errno, strerror(errno));
-			return -1;
-		}
-
-		memset(&dma_map, 0, sizeof(dma_map));
-		dma_map.argsz = sizeof(struct vfio_iommu_type1_dma_map);
-		dma_map.vaddr = vaddr;
-		dma_map.size = len;
-		dma_map.iova = iova;
-		dma_map.flags = VFIO_DMA_MAP_FLAG_READ |
-				VFIO_DMA_MAP_FLAG_WRITE;
-
-		ret = ioctl(vfio_container_fd, VFIO_IOMMU_MAP_DMA, &dma_map);
-		if (ret) {
-			EAL_LOG(ERR, "Cannot map vaddr for IOMMU, error "
-					"%i (%s)", errno, strerror(errno));
-			return -1;
-		}
-
-	} else {
-		struct vfio_iommu_type1_dma_map dma_unmap;
-
-		memset(&dma_unmap, 0, sizeof(dma_unmap));
-		dma_unmap.argsz = sizeof(struct vfio_iommu_type1_dma_unmap);
-		dma_unmap.size = len;
-		dma_unmap.iova = iova;
-
-		ret = ioctl(vfio_container_fd, VFIO_IOMMU_UNMAP_DMA,
-				&dma_unmap);
-		if (ret) {
-			EAL_LOG(ERR, "Cannot unmap vaddr for IOMMU, error "
-					"%i (%s)", errno, strerror(errno));
-			return -1;
-		}
-
-		ret = ioctl(vfio_container_fd,
-				VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY, &reg);
-		if (ret) {
-			EAL_LOG(ERR,
-				"Cannot unregister vaddr for IOMMU, error "
-				"%i (%s)", errno, strerror(errno));
-			return -1;
-		}
-	}
-
-	return ret;
-}
-
-static int
-vfio_spapr_map_walk(const struct rte_memseg_list *msl,
-		const struct rte_memseg *ms, void *arg)
-{
-	int *vfio_container_fd = arg;
-
-	/* skip external memory that isn't a heap */
-	if (msl->external && !msl->heap)
-		return 0;
-
-	/* skip any segments with invalid IOVA addresses */
-	if (ms->iova == RTE_BAD_IOVA)
-		return 0;
-
-	return vfio_spapr_dma_do_map(*vfio_container_fd,
-		ms->addr_64, ms->iova, ms->len, 1);
-}
-
-struct spapr_size_walk_param {
-	uint64_t max_va;
-	uint64_t page_sz;
-	bool is_user_managed;
-};
-
-/*
- * In order to set the DMA window size required for the SPAPR IOMMU
- * we need to walk the existing virtual memory allocations as well as
- * find the hugepage size used.
- */
-static int
-vfio_spapr_size_walk(const struct rte_memseg_list *msl, void *arg)
-{
-	struct spapr_size_walk_param *param = arg;
-	uint64_t max = (uint64_t) msl->base_va + (uint64_t) msl->len;
-
-	if (msl->external && !msl->heap) {
-		/* ignore user managed external memory */
-		param->is_user_managed = true;
-		return 0;
-	}
-
-	if (max > param->max_va) {
-		param->page_sz = msl->page_sz;
-		param->max_va = max;
-	}
-
-	return 0;
-}
-
-/*
- * Find the highest memory address used in physical or virtual address
- * space and use that as the top of the DMA window.
- */
-static int
-find_highest_mem_addr(struct spapr_size_walk_param *param)
-{
-	/* find the maximum IOVA address for setting the DMA window size */
-	if (rte_eal_iova_mode() == RTE_IOVA_PA) {
-		static const char proc_iomem[] = "/proc/iomem";
-		static const char str_sysram[] = "System RAM";
-		uint64_t start, end, max = 0;
-		char *line = NULL;
-		char *dash, *space;
-		size_t line_len;
-
-		/*
-		 * Example "System RAM" in /proc/iomem:
-		 * 00000000-1fffffffff : System RAM
-		 * 200000000000-201fffffffff : System RAM
-		 */
-		FILE *fd = fopen(proc_iomem, "r");
-		if (fd == NULL) {
-			EAL_LOG(ERR, "Cannot open %s", proc_iomem);
-			return -1;
-		}
-		/* Scan /proc/iomem for the highest PA in the system */
-		while (getline(&line, &line_len, fd) != -1) {
-			if (strstr(line, str_sysram) == NULL)
-				continue;
-
-			space = strstr(line, " ");
-			dash = strstr(line, "-");
-
-			/* Validate the format of the memory string */
-			if (space == NULL || dash == NULL || space < dash) {
-				EAL_LOG(ERR, "Can't parse line \"%s\" in file %s",
-					line, proc_iomem);
-				continue;
-			}
-
-			start = strtoull(line, NULL, 16);
-			end   = strtoull(dash + 1, NULL, 16);
-			EAL_LOG(DEBUG, "Found system RAM from 0x%" PRIx64
-				" to 0x%" PRIx64, start, end);
-			if (end > max)
-				max = end;
-		}
-		free(line);
-		fclose(fd);
-
-		if (max == 0) {
-			EAL_LOG(ERR, "Failed to find valid \"System RAM\" "
-				"entry in file %s", proc_iomem);
-			return -1;
-		}
-
-		spapr_dma_win_len = rte_align64pow2(max + 1);
-		return 0;
-	} else if (rte_eal_iova_mode() == RTE_IOVA_VA) {
-		EAL_LOG(DEBUG, "Highest VA address in memseg list is 0x%"
-			PRIx64, param->max_va);
-		spapr_dma_win_len = rte_align64pow2(param->max_va);
-		return 0;
-	}
-
-	spapr_dma_win_len = 0;
-	EAL_LOG(ERR, "Unsupported IOVA mode");
-	return -1;
-}
-
-
-/*
- * The SPAPRv2 IOMMU supports 2 DMA windows with starting
- * address at 0 or 1<<59.  By default, a DMA window is set
- * at address 0, 2GB long, with a 4KB page.  For DPDK we
- * must remove the default window and setup a new DMA window
- * based on the hugepage size and memory requirements of
- * the application before we can map memory for DMA.
- */
-static int
-spapr_dma_win_size(void)
-{
-	struct spapr_size_walk_param param;
-
-	/* only create DMA window once */
-	if (spapr_dma_win_len > 0)
-		return 0;
-
-	/* walk the memseg list to find the page size/max VA address */
-	memset(&param, 0, sizeof(param));
-	if (rte_memseg_list_walk(vfio_spapr_size_walk, &param) < 0) {
-		EAL_LOG(ERR, "Failed to walk memseg list for DMA window size");
+	if (sysfs_base == NULL || dev_addr == NULL || iommu_group_num == NULL) {
+		rte_errno = EINVAL;
 		return -1;
 	}
 
-	/* we can't be sure if DMA window covers external memory */
-	if (param.is_user_managed)
-		EAL_LOG(WARNING, "Detected user managed external memory which may not be managed by the IOMMU");
-
-	/* check physical/virtual memory size */
-	if (find_highest_mem_addr(&param) < 0)
+	if (vfio_cfg.mode == RTE_VFIO_MODE_NONE) {
+		EAL_LOG(ERR, "VFIO support not initialized");
+		rte_errno = ENXIO;
 		return -1;
-	EAL_LOG(DEBUG, "Setting DMA window size to 0x%" PRIx64,
-		spapr_dma_win_len);
-	spapr_dma_win_page_sz = param.page_sz;
-	rte_mem_set_dma_mask(rte_ctz64(spapr_dma_win_len));
-	return 0;
-}
-
-static int
-vfio_spapr_create_dma_window(int vfio_container_fd)
-{
-	struct vfio_iommu_spapr_tce_create create = {
-		.argsz = sizeof(create), };
-	struct vfio_iommu_spapr_tce_remove remove = {
-		.argsz = sizeof(remove), };
-	struct vfio_iommu_spapr_tce_info info = {
-		.argsz = sizeof(info), };
-	int ret;
-
-	ret = spapr_dma_win_size();
-	if (ret < 0)
-		return ret;
-
-	ret = ioctl(vfio_container_fd, VFIO_IOMMU_SPAPR_TCE_GET_INFO, &info);
-	if (ret) {
-		EAL_LOG(ERR, "Cannot get IOMMU info, error %i (%s)",
-			errno, strerror(errno));
-		return -1;
-	}
-
-	/*
-	 * sPAPR v1/v2 IOMMU always has a default 1G DMA window set.  The window
-	 * can't be changed for v1 but it can be changed for v2. Since DPDK only
-	 * supports v2, remove the default DMA window so it can be resized.
-	 */
-	remove.start_addr = info.dma32_window_start;
-	ret = ioctl(vfio_container_fd, VFIO_IOMMU_SPAPR_TCE_REMOVE, &remove);
-	if (ret)
-		return -1;
-
-	/* create a new DMA window (start address is not selectable) */
-	create.window_size = spapr_dma_win_len;
-	create.page_shift  = rte_ctz64(spapr_dma_win_page_sz);
-	create.levels = 1;
-	ret = ioctl(vfio_container_fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
-#ifdef VFIO_IOMMU_SPAPR_INFO_DDW
-	/*
-	 * The vfio_iommu_spapr_tce_info structure was modified in
-	 * Linux kernel 4.2.0 to add support for the
-	 * vfio_iommu_spapr_tce_ddw_info structure needed to try
-	 * multiple table levels.  Skip the attempt if running with
-	 * an older kernel.
-	 */
-	if (ret) {
-		/* if at first we don't succeed, try more levels */
-		uint32_t levels;
-
-		for (levels = create.levels + 1;
-			ret && levels <= info.ddw.levels; levels++) {
-			create.levels = levels;
-			ret = ioctl(vfio_container_fd,
-				VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
-		}
 	}
-#endif /* VFIO_IOMMU_SPAPR_INFO_DDW */
-	if (ret) {
-		EAL_LOG(ERR, "Cannot create new DMA window, error "
-				"%i (%s)", errno, strerror(errno));
-		EAL_LOG(ERR,
-			"Consider using a larger hugepage size if supported by the system");
+	if (vfio_cfg.mode != RTE_VFIO_MODE_GROUP && vfio_cfg.mode != RTE_VFIO_MODE_NOIOMMU) {
+		EAL_LOG(ERR, "VFIO not initialized in group mode");
+		rte_errno = ENOTSUP;
 		return -1;
 	}
-
-	/* verify the start address  */
-	if (create.start_addr != 0) {
-		EAL_LOG(ERR, "Received unsupported start address 0x%"
-			PRIx64, (uint64_t)create.start_addr);
+	ret = vfio_group_get_num(sysfs_base, dev_addr, iommu_group_num);
+	if (ret < 0) {
+		rte_errno = EINVAL;
 		return -1;
-	}
-	return ret;
-}
-
-static int
-vfio_spapr_dma_mem_map(int vfio_container_fd, uint64_t vaddr,
-		uint64_t iova, uint64_t len, int do_map)
-{
-	int ret = 0;
-
-	if (do_map) {
-		if (vfio_spapr_dma_do_map(vfio_container_fd,
-			vaddr, iova, len, 1)) {
-			EAL_LOG(ERR, "Failed to map DMA");
-			ret = -1;
-		}
-	} else {
-		if (vfio_spapr_dma_do_map(vfio_container_fd,
-			vaddr, iova, len, 0)) {
-			EAL_LOG(ERR, "Failed to unmap DMA");
-			ret = -1;
-		}
-	}
-
-	return ret;
-}
-
-static int
-vfio_spapr_dma_map(int vfio_container_fd)
-{
-	if (vfio_spapr_create_dma_window(vfio_container_fd) < 0) {
-		EAL_LOG(ERR, "Could not create new DMA window!");
+	} else if (ret == 0) {
+		rte_errno = ENODEV;
 		return -1;
 	}
-
-	/* map all existing DPDK segments for DMA */
-	if (rte_memseg_walk(vfio_spapr_map_walk, &vfio_container_fd) < 0)
-		return -1;
-
-	return 0;
-}
-
-static int
-vfio_noiommu_dma_map(int __rte_unused vfio_container_fd)
-{
-	/* No-IOMMU mode does not need DMA mapping */
-	return 0;
-}
-
-static int
-vfio_noiommu_dma_mem_map(int __rte_unused vfio_container_fd,
-			 uint64_t __rte_unused vaddr,
-			 uint64_t __rte_unused iova, uint64_t __rte_unused len,
-			 int __rte_unused do_map)
-{
-	/* No-IOMMU mode does not need DMA mapping */
 	return 0;
 }
 
 static int
-vfio_dma_mem_map(struct vfio_config *vfio_cfg, uint64_t vaddr, uint64_t iova,
+vfio_dma_mem_map(struct container *cfg, uint64_t vaddr, uint64_t iova,
 		uint64_t len, int do_map)
 {
-	const struct vfio_iommu_type *t = vfio_cfg->vfio_iommu_type;
+	const struct vfio_iommu_ops *t = vfio_cfg.ops;
 
 	if (!t) {
 		EAL_LOG(ERR, "VFIO support not initialized");
-		rte_errno = ENODEV;
 		return -1;
 	}
 
@@ -1851,16 +1233,14 @@ vfio_dma_mem_map(struct vfio_config *vfio_cfg, uint64_t vaddr, uint64_t iova,
 		EAL_LOG(ERR,
 			"VFIO custom DMA region mapping not supported by IOMMU %s",
 			t->name);
-		rte_errno = ENOTSUP;
 		return -1;
 	}
 
-	return t->dma_user_map_func(vfio_cfg->vfio_container_fd, vaddr, iova,
-			len, do_map);
+	return t->dma_user_map_func(cfg, vaddr, iova, len, do_map);
 }
 
 static int
-container_dma_map(struct vfio_config *vfio_cfg, uint64_t vaddr, uint64_t iova,
+container_dma_map(struct container *cfg, uint64_t vaddr, uint64_t iova,
 		uint64_t len)
 {
 	struct user_mem_map *new_map;
@@ -1868,16 +1248,15 @@ container_dma_map(struct vfio_config *vfio_cfg, uint64_t vaddr, uint64_t iova,
 	bool has_partial_unmap;
 	int ret = 0;
 
-	user_mem_maps = &vfio_cfg->mem_maps;
+	user_mem_maps = &cfg->mem_maps;
 	rte_spinlock_recursive_lock(&user_mem_maps->lock);
 	if (user_mem_maps->n_maps == RTE_DIM(user_mem_maps->maps)) {
 		EAL_LOG(ERR, "No more space for user mem maps");
-		rte_errno = ENOMEM;
 		ret = -1;
 		goto out;
 	}
 	/* map the entry */
-	if (vfio_dma_mem_map(vfio_cfg, vaddr, iova, len, 1)) {
+	if (vfio_dma_mem_map(cfg, vaddr, iova, len, 1)) {
 		/* technically, this will fail if there are currently no devices
 		 * plugged in, even if a device were added later, this mapping
 		 * might have succeeded. however, since we cannot verify if this
@@ -1890,7 +1269,7 @@ container_dma_map(struct vfio_config *vfio_cfg, uint64_t vaddr, uint64_t iova,
 		goto out;
 	}
 	/* do we have partial unmap support? */
-	has_partial_unmap = vfio_cfg->vfio_iommu_type->partial_unmap;
+	has_partial_unmap = vfio_cfg.ops->partial_unmap;
 
 	/* create new user mem map entry */
 	new_map = &user_mem_maps->maps[user_mem_maps->n_maps++];
@@ -1907,17 +1286,17 @@ container_dma_map(struct vfio_config *vfio_cfg, uint64_t vaddr, uint64_t iova,
 }
 
 static int
-container_dma_unmap(struct vfio_config *vfio_cfg, uint64_t vaddr, uint64_t iova,
+container_dma_unmap(struct container *cfg, uint64_t vaddr, uint64_t iova,
 		uint64_t len)
 {
-	struct user_mem_map orig_maps[RTE_DIM(vfio_cfg->mem_maps.maps)];
+	struct user_mem_map orig_maps[RTE_DIM(cfg->mem_maps.maps)];
 	struct user_mem_map new_maps[2]; /* can be at most 2 */
 	struct user_mem_maps *user_mem_maps;
 	int n_orig, n_new, ret = 0;
 	bool has_partial_unmap;
 	unsigned int newlen;
 
-	user_mem_maps = &vfio_cfg->mem_maps;
+	user_mem_maps = &cfg->mem_maps;
 	rte_spinlock_recursive_lock(&user_mem_maps->lock);
 
 	/*
@@ -1943,13 +1322,12 @@ container_dma_unmap(struct vfio_config *vfio_cfg, uint64_t vaddr, uint64_t iova,
 	/* did we find anything? */
 	if (n_orig < 0) {
 		EAL_LOG(ERR, "Couldn't find previously mapped region");
-		rte_errno = EINVAL;
 		ret = -1;
 		goto out;
 	}
 
 	/* do we have partial unmap capability? */
-	has_partial_unmap = vfio_cfg->vfio_iommu_type->partial_unmap;
+	has_partial_unmap = vfio_cfg.ops->partial_unmap;
 
 	/*
 	 * if we don't support partial unmap, we must check if start and end of
@@ -1965,7 +1343,6 @@ container_dma_unmap(struct vfio_config *vfio_cfg, uint64_t vaddr, uint64_t iova,
 
 		if (!start_aligned || !end_aligned) {
 			EAL_LOG(DEBUG, "DMA partial unmap unsupported");
-			rte_errno = ENOTSUP;
 			ret = -1;
 			goto out;
 		}
@@ -1983,28 +1360,20 @@ container_dma_unmap(struct vfio_config *vfio_cfg, uint64_t vaddr, uint64_t iova,
 	newlen = (user_mem_maps->n_maps - n_orig) + n_new;
 	if (newlen >= RTE_DIM(user_mem_maps->maps)) {
 		EAL_LOG(ERR, "Not enough space to store partial mapping");
-		rte_errno = ENOMEM;
 		ret = -1;
 		goto out;
 	}
 
 	/* unmap the entry */
-	if (vfio_dma_mem_map(vfio_cfg, vaddr, iova, len, 0)) {
+	if (vfio_dma_mem_map(cfg, vaddr, iova, len, 0)) {
 		/* there may not be any devices plugged in, so unmapping will
-		 * fail with ENODEV/ENOTSUP rte_errno values, but that doesn't
-		 * stop us from removing the mapping, as the assumption is we
-		 * won't be needing this memory any more and thus will want to
-		 * prevent it from being remapped again on hotplug. so, only
-		 * fail if we indeed failed to unmap (e.g. if the mapping was
-		 * within our mapped range but had invalid alignment).
+		 * fail, but that doesn't stop us from removing the mapping,
+		 * as the assumption is we won't be needing this memory any
+		 * more and thus will want to prevent it from being remapped
+		 * again on hotplug. Ignore the error and proceed with
+		 * removing the mapping from our records.
 		 */
-		if (rte_errno != ENODEV && rte_errno != ENOTSUP) {
-			EAL_LOG(ERR, "Couldn't unmap region for DMA");
-			ret = -1;
-			goto out;
-		} else {
-			EAL_LOG(DEBUG, "DMA unmapping failed, but removing mappings anyway");
-		}
+		EAL_LOG(DEBUG, "DMA unmapping failed, but removing mappings anyway");
 	}
 
 	/* we have unmapped the region, so now update the maps */
@@ -2020,117 +1389,108 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_noiommu_is_enabled)
 int
 rte_vfio_noiommu_is_enabled(void)
 {
-	int fd;
-	ssize_t cnt;
-	char c;
-
-	fd = open(RTE_VFIO_NOIOMMU_MODE, O_RDONLY);
-	if (fd < 0) {
-		if (errno != ENOENT) {
-			EAL_LOG(ERR, "Cannot open VFIO noiommu file "
-					"%i (%s)", errno, strerror(errno));
-			return -1;
-		}
-		/*
-		 * else the file does not exists
-		 * i.e. noiommu is not enabled
-		 */
-		return 0;
-	}
-
-	cnt = read(fd, &c, 1);
-	close(fd);
-	if (cnt != 1) {
-		EAL_LOG(ERR, "Unable to read from VFIO noiommu file "
-				"%i (%s)", errno, strerror(errno));
-		return -1;
-	}
-
-	return c == 'Y';
+	return vfio_cfg.mode == RTE_VFIO_MODE_NOIOMMU;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_create)
 int
 rte_vfio_container_create(void)
 {
-	unsigned int i;
+	struct container *cfg;
+	int container_fd;
 
-	/* Find an empty slot to store new vfio config */
-	for (i = 1; i < RTE_DIM(vfio_cfgs); i++) {
-		if (vfio_cfgs[i].vfio_container_fd == -1)
-			break;
-	}
-
-	if (i == RTE_DIM(vfio_cfgs)) {
-		EAL_LOG(ERR, "Exceed max VFIO container limit");
+	if (vfio_cfg.mode == RTE_VFIO_MODE_NONE) {
+		EAL_LOG(ERR, "VFIO not initialized");
+		rte_errno = ENXIO;
 		return -1;
 	}
-
-	/* Create a new container fd */
-	vfio_cfgs[i].vfio_container_fd = vfio_open_container_fd(false);
-	if (vfio_cfgs[i].vfio_container_fd < 0) {
-		EAL_LOG(NOTICE, "Fail to create a new VFIO container");
+	cfg = vfio_container_create();
+	if (cfg == NULL) {
+		EAL_LOG(ERR, "Reached VFIO container limit");
+		rte_errno = ENOSPC;
 		return -1;
 	}
 
-	return vfio_cfgs[i].vfio_container_fd;
+	switch (vfio_cfg.mode) {
+	case RTE_VFIO_MODE_GROUP:
+	case RTE_VFIO_MODE_NOIOMMU:
+	{
+		container_fd = vfio_group_open_container_fd();
+		if (container_fd < 0) {
+			EAL_LOG(ERR, "Fail to create a new VFIO container");
+			rte_errno = EIO;
+			goto err;
+		}
+		cfg->container_fd = container_fd;
+		break;
+	}
+	default:
+		EAL_LOG(NOTICE, "Unsupported VFIO mode");
+		rte_errno = ENOTSUP;
+		goto err;
+	}
+	return container_fd;
+err:
+	vfio_container_erase(cfg);
+	return -1;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_destroy)
 int
 rte_vfio_container_destroy(int container_fd)
 {
-	struct vfio_config *vfio_cfg;
-	unsigned int i;
+	struct container *cfg;
+	struct vfio_device *dev;
 
-	vfio_cfg = get_vfio_cfg_by_container_fd(container_fd);
-	if (vfio_cfg == NULL) {
-		EAL_LOG(ERR, "Invalid VFIO container fd");
+	if (vfio_cfg.mode == RTE_VFIO_MODE_NONE) {
+		EAL_LOG(ERR, "VFIO not initialized");
+		rte_errno = ENXIO;
 		return -1;
 	}
 
-	for (i = 0; i < RTE_DIM(vfio_cfg->vfio_groups); i++)
-		if (vfio_cfg->vfio_groups[i].group_num != -1)
-			rte_vfio_container_group_unbind(container_fd,
-				vfio_cfg->vfio_groups[i].group_num);
-
-	close(container_fd);
-	vfio_cfg->vfio_container_fd = -1;
-	vfio_cfg->vfio_active_groups = 0;
-	vfio_cfg->vfio_iommu_type = NULL;
-
-	return 0;
-}
-
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_assign_device)
-int
-rte_vfio_container_assign_device(int vfio_container_fd, const char *sysfs_base,
-		const char *dev_addr)
-{
-	int iommu_group_num;
-	int ret;
-
-	ret = rte_vfio_get_group_num(sysfs_base, dev_addr, &iommu_group_num);
-	if (ret < 0) {
-		EAL_LOG(ERR, "Cannot get IOMMU group number for device %s",
-			dev_addr);
+	cfg = vfio_container_get_by_fd(container_fd);
+	if (cfg == NULL) {
+		EAL_LOG(ERR, "VFIO container fd not managed by VFIO");
+		rte_errno = ENODEV;
 		return -1;
-	} else if (ret == 0) {
-		EAL_LOG(ERR,
-			"Device %s is not assigned to any IOMMU group",
-			dev_addr);
+	}
+	/* forbid destroying default container */
+	if (vfio_container_is_default(cfg)) {
+		EAL_LOG(ERR, "Cannot destroy default VFIO container");
+		rte_errno = EINVAL;
 		return -1;
 	}
 
-	ret = rte_vfio_container_group_bind(vfio_container_fd,
-			iommu_group_num);
-	if (ret < 0) {
-		EAL_LOG(ERR,
-			"Cannot bind IOMMU group %d for device %s",
-			iommu_group_num, dev_addr);
+	switch (vfio_cfg.mode) {
+	case RTE_VFIO_MODE_GROUP:
+	case RTE_VFIO_MODE_NOIOMMU:
+		/* erase all devices */
+		DEVICE_FOREACH_ACTIVE(cfg, dev) {
+			EAL_LOG(DEBUG, "Device in IOMMU group %d still open, closing", dev->group);
+			/*
+			 * technically we could've done back-reference lookup and closed our groups
+			 * following a device close, but since we're closing and erasing all groups
+			 * anyway, we can afford to not bother.
+			 */
+			vfio_device_erase(cfg, dev);
+		}
+
+		/* erase all groups */
+		struct vfio_group *grp;
+		GROUP_FOREACH_ACTIVE(cfg, grp) {
+			EAL_LOG(DEBUG, "IOMMU group %d still open, closing", grp->group_num);
+			vfio_group_erase(cfg, grp);
+		}
+		break;
+	default:
+		EAL_LOG(ERR, "Unsupported VFIO mode");
+		rte_errno = ENOTSUP;
 		return -1;
 	}
 
+	/* erase entire config */
+	vfio_container_erase(cfg);
+
 	return 0;
 }
 
@@ -2138,96 +1498,174 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_group_bind)
 int
 rte_vfio_container_group_bind(int container_fd, int iommu_group_num)
 {
-	struct vfio_config *vfio_cfg;
+	struct container *cfg;
+	struct vfio_group *grp;
+	int ret;
 
-	vfio_cfg = get_vfio_cfg_by_container_fd(container_fd);
-	if (vfio_cfg == NULL) {
+	if (vfio_cfg.mode == RTE_VFIO_MODE_NONE) {
+		EAL_LOG(ERR, "VFIO support not initialized");
+		rte_errno = ENXIO;
+		return -1;
+	}
+	if (vfio_cfg.mode != RTE_VFIO_MODE_GROUP && vfio_cfg.mode != RTE_VFIO_MODE_NOIOMMU) {
+		EAL_LOG(ERR, "VFIO not initialized in group mode");
+		rte_errno = ENOTSUP;
+		return -1;
+	}
+
+	cfg = vfio_container_get_by_fd(container_fd);
+	if (cfg == NULL) {
 		EAL_LOG(ERR, "Invalid VFIO container fd");
+		rte_errno = EINVAL;
 		return -1;
 	}
 
-	return vfio_get_group_fd(vfio_cfg, iommu_group_num);
+	/* does the group already exist and already bound? */
+	grp = vfio_group_get_by_num(cfg, iommu_group_num);
+	if (grp != NULL)
+		return 0;
+
+	/* group doesn't exist, create it */
+	grp = vfio_group_create(cfg, iommu_group_num);
+	if (grp == NULL) {
+		EAL_LOG(ERR, "Failed to bind VFIO group %d", iommu_group_num);
+		rte_errno = ENOSPC;
+		return -1;
+	}
+
+	/* group created, now open fd */
+	ret = vfio_group_open_fd(cfg, grp);
+	if (ret == -ENOENT) {
+		EAL_LOG(ERR, "IOMMU group %d not managed by VFIO", iommu_group_num);
+		vfio_group_erase(cfg, grp);
+		rte_errno = ENODEV;
+		return -1;
+	} else if (ret < 0) {
+		EAL_LOG(ERR, "Cannot open VFIO group %d", iommu_group_num);
+		rte_errno = errno;
+		vfio_group_erase(cfg, grp);
+		return -1;
+	}
+
+	/* we're done */
+	return 0;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_group_unbind)
 int
 rte_vfio_container_group_unbind(int container_fd, int iommu_group_num)
 {
-	struct vfio_group *cur_grp = NULL;
-	struct vfio_config *vfio_cfg;
-	unsigned int i;
+	struct container *cfg;
+	struct vfio_group *grp;
+	struct vfio_device *dev;
 
-	vfio_cfg = get_vfio_cfg_by_container_fd(container_fd);
-	if (vfio_cfg == NULL) {
+	if (vfio_cfg.mode == RTE_VFIO_MODE_NONE) {
+		EAL_LOG(ERR, "VFIO support not initialized");
+		rte_errno = ENODEV;
+		return -1;
+	}
+
+	if (vfio_cfg.mode != RTE_VFIO_MODE_GROUP && vfio_cfg.mode != RTE_VFIO_MODE_NOIOMMU) {
+		EAL_LOG(ERR, "VFIO not initialized in group mode");
+		rte_errno = ENOTSUP;
+		return -1;
+	}
+
+	/* find container */
+	cfg = vfio_container_get_by_fd(container_fd);
+	if (cfg == NULL) {
 		EAL_LOG(ERR, "Invalid VFIO container fd");
+		rte_errno = EINVAL;
 		return -1;
 	}
 
-	for (i = 0; i < RTE_DIM(vfio_cfg->vfio_groups); i++) {
-		if (vfio_cfg->vfio_groups[i].group_num == iommu_group_num) {
-			cur_grp = &vfio_cfg->vfio_groups[i];
-			break;
-		}
-	}
-
-	/* This should not happen */
-	if (cur_grp == NULL) {
-		EAL_LOG(ERR, "Specified VFIO group number not found");
+	/* find the group */
+	grp = vfio_group_get_by_num(cfg, iommu_group_num);
+	if (grp == NULL) {
+		EAL_LOG(ERR, "VFIO group %d not found in container", iommu_group_num);
+		rte_errno = ENOENT;
 		return -1;
 	}
 
-	if (cur_grp->fd >= 0 && close(cur_grp->fd) < 0) {
-		EAL_LOG(ERR,
-			"Error when closing vfio_group_fd for iommu_group_num "
-			"%d", iommu_group_num);
-		return -1;
+	/* remove all devices from this group */
+	DEVICE_FOREACH_ACTIVE(cfg, dev) {
+		if (dev->group != grp->group_num)
+			continue;
+		vfio_device_erase(cfg, dev);
 	}
-	cur_grp->group_num = -1;
-	cur_grp->fd = -1;
-	cur_grp->devices = 0;
-	vfio_cfg->vfio_active_groups--;
+
+	vfio_group_erase(cfg, grp);
 
 	return 0;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_dma_map)
 int
-rte_vfio_container_dma_map(int container_fd, uint64_t vaddr, uint64_t iova,
-		uint64_t len)
+rte_vfio_container_dma_map(int container_fd, uint64_t vaddr, uint64_t iova, uint64_t len)
 {
-	struct vfio_config *vfio_cfg;
+	struct container *cfg;
 
 	if (len == 0) {
 		rte_errno = EINVAL;
 		return -1;
 	}
 
-	vfio_cfg = get_vfio_cfg_by_container_fd(container_fd);
-	if (vfio_cfg == NULL) {
+	if (vfio_cfg.mode == RTE_VFIO_MODE_NONE) {
+		EAL_LOG(ERR, "VFIO support not initialized");
+		rte_errno = ENXIO;
+		return -1;
+	}
+
+	cfg = vfio_container_get_by_fd(container_fd);
+	if (cfg == NULL) {
 		EAL_LOG(ERR, "Invalid VFIO container fd");
+		rte_errno = EINVAL;
 		return -1;
 	}
 
-	return container_dma_map(vfio_cfg, vaddr, iova, len);
+	if (container_dma_map(cfg, vaddr, iova, len) < 0) {
+		rte_errno = EIO;
+		return -1;
+	}
+
+	return 0;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_dma_unmap)
 int
-rte_vfio_container_dma_unmap(int container_fd, uint64_t vaddr, uint64_t iova,
-		uint64_t len)
+rte_vfio_container_dma_unmap(int container_fd, uint64_t vaddr, uint64_t iova, uint64_t len)
 {
-	struct vfio_config *vfio_cfg;
+	struct container *cfg;
 
 	if (len == 0) {
 		rte_errno = EINVAL;
 		return -1;
 	}
 
-	vfio_cfg = get_vfio_cfg_by_container_fd(container_fd);
-	if (vfio_cfg == NULL) {
+	if (vfio_cfg.mode == RTE_VFIO_MODE_NONE) {
+		EAL_LOG(ERR, "VFIO support not initialized");
+		rte_errno = ENXIO;
+		return -1;
+	}
+
+	cfg = vfio_container_get_by_fd(container_fd);
+	if (cfg == NULL) {
 		EAL_LOG(ERR, "Invalid VFIO container fd");
+		rte_errno = EINVAL;
 		return -1;
 	}
 
-	return container_dma_unmap(vfio_cfg, vaddr, iova, len);
+	if (container_dma_unmap(cfg, vaddr, iova, len) < 0) {
+		rte_errno = EIO;
+		return -1;
+	}
+
+	return 0;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_mode)
+enum rte_vfio_mode
+rte_vfio_get_mode(void)
+{
+	return vfio_cfg.mode;
 }
diff --git a/lib/eal/linux/eal_vfio.h b/lib/eal/linux/eal_vfio.h
index 89c4b5ba45..68d3a3ec6e 100644
--- a/lib/eal/linux/eal_vfio.h
+++ b/lib/eal/linux/eal_vfio.h
@@ -6,58 +6,161 @@
 #define EAL_VFIO_H_
 
 #include <rte_common.h>
+#include <rte_spinlock.h>
 
 #include <stdint.h>
 
+#include <rte_vfio.h>
+
+/* hot plug/unplug of VFIO groups may cause all DMA maps to be dropped. we can
+ * recreate the mappings for DPDK segments, but we cannot do so for memory that
+ * was registered by the user themselves, so we need to store the user mappings
+ * somewhere, to recreate them later.
+ */
+#define EAL_VFIO_MAX_USER_MEM_MAPS 256
+
+/* user memory map entry */
+struct user_mem_map {
+	uint64_t addr;  /**< start VA */
+	uint64_t iova;  /**< start IOVA */
+	uint64_t len;   /**< total length of the mapping */
+	uint64_t chunk; /**< this mapping can be split in chunks of this size */
+};
+
+/* user memory maps container (common for all API modes) */
+struct user_mem_maps {
+	rte_spinlock_recursive_t lock;
+	int n_maps;
+	struct user_mem_map maps[EAL_VFIO_MAX_USER_MEM_MAPS];
+};
+
 /*
  * we don't need to store device fd's anywhere since they can be obtained from
  * the group fd via an ioctl() call.
  */
 struct vfio_group {
+	bool active;
 	int group_num;
 	int fd;
-	int devices;
+	int n_devices;
+};
+
+/* device tracking (common for group and cdev modes) */
+struct vfio_device {
+	bool active;
+	int group; /**< back-reference to group list (group mode) */
+	int fd;
+};
+
+/* group mode specific configuration */
+struct vfio_group_config {
+	bool dma_setup_done;
+	bool iommu_type_set;
+	bool mem_event_clb_set;
+	size_t n_groups;
+	struct vfio_group groups[RTE_MAX_VFIO_GROUPS];
+};
+
+/* per-container configuration */
+struct container {
+	bool active;
+	int container_fd;
+	struct user_mem_maps mem_maps;
+	struct vfio_group_config group_cfg;
+	int n_devices;
+	struct vfio_device devices[RTE_MAX_VFIO_DEVICES];
 };
 
 /* DMA mapping function prototype.
- * Takes VFIO container fd as a parameter.
+ * Takes VFIO container config as a parameter.
  * Returns 0 on success, -1 on error.
  */
-typedef int (*vfio_dma_func_t)(int);
+typedef int (*dma_func_t)(struct container *cfg);
 
 /* Custom memory region DMA mapping function prototype.
- * Takes VFIO container fd, virtual address, physical address, length and
+ * Takes VFIO container config, virtual address, physical address, length and
  * operation type (0 to unmap 1 for map) as a parameters.
  * Returns 0 on success, -1 on error.
  */
-typedef int (*vfio_dma_user_func_t)(int fd, uint64_t vaddr, uint64_t iova,
-		uint64_t len, int do_map);
+typedef int (*dma_user_func_t)(struct container *cfg, uint64_t vaddr,
+		uint64_t iova, uint64_t len, int do_map);
 
-struct vfio_iommu_type {
+/* mode-independent ops */
+struct vfio_iommu_ops {
 	int type_id;
 	const char *name;
 	bool partial_unmap;
-	vfio_dma_user_func_t dma_user_map_func;
-	vfio_dma_func_t dma_map_func;
+	dma_user_func_t dma_user_map_func;
+	dma_func_t dma_map_func;
 };
 
-/* get the vfio container that devices are bound to by default */
-int vfio_open_container_fd(bool mp_request);
+/* global configuration */
+struct vfio_config {
+	struct container *default_cfg;
+	enum rte_vfio_mode mode;
+	const struct vfio_iommu_ops *ops;
+};
+
+/* per-process, per-container data */
+extern struct container containers[RTE_MAX_VFIO_CONTAINERS];
+
+/* current configuration */
+extern struct vfio_config vfio_cfg;
+
+#define CONTAINER_FOREACH(cfg) \
+	for ((cfg) = &containers[0]; \
+		(cfg) < &containers[RTE_DIM(containers)]; \
+		(cfg)++)
+
+#define CONTAINER_FOREACH_ACTIVE(cfg) \
+	CONTAINER_FOREACH((cfg)) \
+		if (((cfg)->active))
+
+#define GROUP_FOREACH(cfg, grp) \
+	for ((grp) = &((cfg)->group_cfg.groups[0]); \
+		(grp) < &((cfg)->group_cfg.groups[RTE_DIM((cfg)->group_cfg.groups)]); \
+		(grp)++)
+
+#define GROUP_FOREACH_ACTIVE(cfg, grp) \
+	GROUP_FOREACH((cfg), (grp)) \
+		if ((grp)->active)
 
-/* pick IOMMU type. returns a pointer to vfio_iommu_type or NULL for error */
-const struct vfio_iommu_type *
-vfio_set_iommu_type(int vfio_container_fd);
+#define DEVICE_FOREACH(cfg, dev) \
+	for ((dev) = &((cfg)->devices[0]); \
+		(dev) < &((cfg)->devices[RTE_DIM((cfg)->devices)]); \
+		(dev)++)
 
-int
-vfio_get_iommu_type(void);
+#define DEVICE_FOREACH_ACTIVE(cfg, dev) \
+	DEVICE_FOREACH((cfg), (dev)) \
+		if ((dev)->active)
 
-/* check if we have any supported extensions */
-int
-vfio_has_supported_extensions(int vfio_container_fd);
+/* for containers, we only need to initialize the lock in mem maps */
+#define CONTAINER_INITIALIZER \
+	((struct container){ \
+		.mem_maps = {.lock = RTE_SPINLOCK_RECURSIVE_INITIALIZER,}, \
+	})
 
+int vfio_get_iommu_type(void);
 int vfio_mp_sync_setup(void);
 void vfio_mp_sync_cleanup(void);
+bool vfio_container_is_default(struct container *cfg);
 
+/* group mode functions */
+int vfio_group_enable(struct container *cfg);
+int vfio_group_open_container_fd(void);
+int vfio_group_noiommu_is_enabled(void);
+int vfio_group_get_num(const char *sysfs_base, const char *dev_addr,
+		int *iommu_group_num);
+struct vfio_group *vfio_group_get_by_num(struct container *cfg, int iommu_group);
+struct vfio_group *vfio_group_create(struct container *cfg, int iommu_group);
+void vfio_group_erase(struct container *cfg, struct vfio_group *grp);
+int vfio_group_open_fd(struct container *cfg, struct vfio_group *grp);
+int vfio_group_prepare(struct container *cfg, struct vfio_group *grp);
+int vfio_group_setup_iommu(struct container *cfg);
+int vfio_group_setup_device_fd(const char *dev_addr,
+		struct vfio_group *grp, struct vfio_device *dev);
+
+#define VFIO_MEM_EVENT_CLB_NAME "vfio_mem_event_clb"
 #define EAL_VFIO_MP "eal_vfio_mp_sync"
 
 #define SOCKET_REQ_CONTAINER 0x100
@@ -73,6 +176,7 @@ struct vfio_mp_param {
 	union {
 		int group_num;
 		int iommu_type_id;
+		enum rte_vfio_mode mode;
 	};
 };
 
diff --git a/lib/eal/linux/eal_vfio_group.c b/lib/eal/linux/eal_vfio_group.c
new file mode 100644
index 0000000000..6123a83aec
--- /dev/null
+++ b/lib/eal/linux/eal_vfio_group.c
@@ -0,0 +1,983 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2010-2025 Intel Corporation
+ */
+
+#include <dirent.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+#include <uapi/linux/vfio.h>
+
+#include <rte_log.h>
+#include <rte_errno.h>
+#include <rte_eal_memconfig.h>
+#include <rte_memory.h>
+#include <rte_string_fns.h>
+#include <rte_vfio.h>
+
+#include "eal_vfio.h"
+#include "eal_private.h"
+#include "eal_internal_cfg.h"
+
+static int vfio_type1_dma_map(struct container *);
+static int vfio_type1_dma_mem_map(struct container *, uint64_t, uint64_t, uint64_t, int);
+static int vfio_spapr_dma_map(struct container *);
+static int vfio_spapr_dma_mem_map(struct container *, uint64_t, uint64_t, uint64_t, int);
+static int vfio_noiommu_dma_map(struct container *);
+static int vfio_noiommu_dma_mem_map(struct container *, uint64_t, uint64_t, uint64_t, int);
+
+/* IOMMU types we support */
+static const struct vfio_iommu_ops iommu_types[] = {
+	/* x86 IOMMU, otherwise known as type 1 */
+	{
+		.type_id = VFIO_TYPE1_IOMMU,
+		.name = "Type 1",
+		.partial_unmap = false,
+		.dma_map_func = &vfio_type1_dma_map,
+		.dma_user_map_func = &vfio_type1_dma_mem_map
+	},
+	/* ppc64 IOMMU, otherwise known as spapr */
+	{
+		.type_id = VFIO_SPAPR_TCE_v2_IOMMU,
+		.name = "sPAPR",
+		.partial_unmap = true,
+		.dma_map_func = &vfio_spapr_dma_map,
+		.dma_user_map_func = &vfio_spapr_dma_mem_map
+	},
+	/* IOMMU-less mode */
+	{
+		.type_id = VFIO_NOIOMMU_IOMMU,
+		.name = "No-IOMMU",
+		.partial_unmap = true,
+		.dma_map_func = &vfio_noiommu_dma_map,
+		.dma_user_map_func = &vfio_noiommu_dma_mem_map
+	},
+};
+
+static const struct vfio_iommu_ops *
+vfio_group_set_iommu_type(int vfio_container_fd)
+{
+	unsigned int idx;
+	for (idx = 0; idx < RTE_DIM(iommu_types); idx++) {
+		const struct vfio_iommu_ops *t = &iommu_types[idx];
+
+		int ret = ioctl(vfio_container_fd, VFIO_SET_IOMMU, t->type_id);
+		if (ret == 0)
+			return t;
+		/* not an error, there may be more supported IOMMU types */
+		EAL_LOG(DEBUG, "Set IOMMU type %d (%s) failed, error "
+				"%i (%s)", t->type_id, t->name, errno,
+				strerror(errno));
+	}
+	/* if we didn't find a suitable IOMMU type, fail */
+	return NULL;
+}
+
+static int
+type1_map(const struct rte_memseg_list *msl, const struct rte_memseg *ms,
+		void *arg)
+{
+	struct container *cfg = arg;
+
+	/* skip external memory that isn't a heap */
+	if (msl->external && !msl->heap)
+		return 0;
+
+	/* skip any segments with invalid IOVA addresses */
+	if (ms->iova == RTE_BAD_IOVA)
+		return 0;
+
+	return vfio_type1_dma_mem_map(cfg, ms->addr_64, ms->iova, ms->len, 1);
+}
+
+static int
+vfio_type1_dma_mem_map(struct container *cfg, uint64_t vaddr, uint64_t iova,
+		uint64_t len, int do_map)
+{
+	struct vfio_iommu_type1_dma_map dma_map;
+	struct vfio_iommu_type1_dma_unmap dma_unmap;
+	int ret;
+
+	if (do_map != 0) {
+		memset(&dma_map, 0, sizeof(dma_map));
+		dma_map.argsz = sizeof(struct vfio_iommu_type1_dma_map);
+		dma_map.vaddr = vaddr;
+		dma_map.size = len;
+		dma_map.iova = iova;
+		dma_map.flags = VFIO_DMA_MAP_FLAG_READ |
+				VFIO_DMA_MAP_FLAG_WRITE;
+
+		ret = ioctl(cfg->container_fd, VFIO_IOMMU_MAP_DMA, &dma_map);
+		if (ret) {
+			/**
+			 * In case the mapping was already done EEXIST will be
+			 * returned from kernel.
+			 */
+			if (errno == EEXIST) {
+				EAL_LOG(DEBUG,
+					"Memory segment is already mapped, skipping");
+			} else {
+				EAL_LOG(ERR,
+					"Cannot set up DMA remapping, error "
+					"%i (%s)", errno, strerror(errno));
+				return -1;
+			}
+		}
+	} else {
+		memset(&dma_unmap, 0, sizeof(dma_unmap));
+		dma_unmap.argsz = sizeof(struct vfio_iommu_type1_dma_unmap);
+		dma_unmap.size = len;
+		dma_unmap.iova = iova;
+
+		ret = ioctl(cfg->container_fd, VFIO_IOMMU_UNMAP_DMA,
+				&dma_unmap);
+		if (ret) {
+			EAL_LOG(ERR, "Cannot clear DMA remapping, error "
+					"%i (%s)", errno, strerror(errno));
+			return -1;
+		} else if (dma_unmap.size != len) {
+			EAL_LOG(ERR, "Unexpected size %"PRIu64
+				" of DMA remapping cleared instead of %"PRIu64,
+				(uint64_t)dma_unmap.size, len);
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+static int
+vfio_type1_dma_map(struct container *cfg)
+{
+	return rte_memseg_walk(type1_map, cfg);
+}
+
+/* Track the size of the statically allocated DMA window for SPAPR */
+uint64_t spapr_dma_win_len;
+uint64_t spapr_dma_win_page_sz;
+
+static int
+vfio_spapr_dma_do_map(struct container *cfg, uint64_t vaddr, uint64_t iova,
+		uint64_t len, int do_map)
+{
+	struct vfio_iommu_spapr_register_memory reg = {
+		.argsz = sizeof(reg),
+		.vaddr = (uintptr_t) vaddr,
+		.size = len,
+		.flags = 0
+	};
+	int ret;
+
+	if (do_map != 0) {
+		struct vfio_iommu_type1_dma_map dma_map;
+
+		if (iova + len > spapr_dma_win_len) {
+			EAL_LOG(ERR, "DMA map attempt outside DMA window");
+			return -1;
+		}
+
+		ret = ioctl(cfg->container_fd,
+				VFIO_IOMMU_SPAPR_REGISTER_MEMORY, &reg);
+		if (ret) {
+			EAL_LOG(ERR,
+				"Cannot register vaddr for IOMMU, error "
+				"%i (%s)", errno, strerror(errno));
+			return -1;
+		}
+
+		memset(&dma_map, 0, sizeof(dma_map));
+		dma_map.argsz = sizeof(struct vfio_iommu_type1_dma_map);
+		dma_map.vaddr = vaddr;
+		dma_map.size = len;
+		dma_map.iova = iova;
+		dma_map.flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE;
+
+		ret = ioctl(cfg->container_fd, VFIO_IOMMU_MAP_DMA, &dma_map);
+		if (ret) {
+			EAL_LOG(ERR, "Cannot map vaddr for IOMMU, error "
+					"%i (%s)", errno, strerror(errno));
+			return -1;
+		}
+
+	} else {
+		struct vfio_iommu_type1_dma_map dma_unmap;
+
+		memset(&dma_unmap, 0, sizeof(dma_unmap));
+		dma_unmap.argsz = sizeof(struct vfio_iommu_type1_dma_unmap);
+		dma_unmap.size = len;
+		dma_unmap.iova = iova;
+
+		ret = ioctl(cfg->container_fd, VFIO_IOMMU_UNMAP_DMA,
+				&dma_unmap);
+		if (ret) {
+			EAL_LOG(ERR, "Cannot unmap vaddr for IOMMU, error "
+					"%i (%s)", errno, strerror(errno));
+			return -1;
+		}
+
+		ret = ioctl(cfg->container_fd,
+				VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY, &reg);
+		if (ret) {
+			EAL_LOG(ERR,
+				"Cannot unregister vaddr for IOMMU, error "
+				"%i (%s)", errno, strerror(errno));
+			return -1;
+		}
+	}
+
+	return ret;
+}
+
+static int
+vfio_spapr_map_walk(const struct rte_memseg_list *msl,
+		const struct rte_memseg *ms, void *arg)
+{
+	struct container *cfg = arg;
+
+	/* skip external memory that isn't a heap */
+	if (msl->external && !msl->heap)
+		return 0;
+
+	/* skip any segments with invalid IOVA addresses */
+	if (ms->iova == RTE_BAD_IOVA)
+		return 0;
+
+	return vfio_spapr_dma_do_map(cfg, ms->addr_64, ms->iova, ms->len, 1);
+}
+
+struct spapr_size_walk_param {
+	uint64_t max_va;
+	uint64_t page_sz;
+	bool is_user_managed;
+};
+
+/*
+ * In order to set the DMA window size required for the SPAPR IOMMU
+ * we need to walk the existing virtual memory allocations as well as
+ * find the hugepage size used.
+ */
+static int
+vfio_spapr_size_walk(const struct rte_memseg_list *msl, void *arg)
+{
+	struct spapr_size_walk_param *param = arg;
+	uint64_t max = (uint64_t) msl->base_va + (uint64_t) msl->len;
+
+	if (msl->external && !msl->heap) {
+		/* ignore user managed external memory */
+		param->is_user_managed = true;
+		return 0;
+	}
+
+	if (max > param->max_va) {
+		param->page_sz = msl->page_sz;
+		param->max_va = max;
+	}
+
+	return 0;
+}
+
+/*
+ * Find the highest memory address used in physical or virtual address
+ * space and use that as the top of the DMA window.
+ */
+static int
+find_highest_mem_addr(struct spapr_size_walk_param *param)
+{
+	/* find the maximum IOVA address for setting the DMA window size */
+	if (rte_eal_iova_mode() == RTE_IOVA_PA) {
+		static const char proc_iomem[] = "/proc/iomem";
+		static const char str_sysram[] = "System RAM";
+		uint64_t start, end, max = 0;
+		char *line = NULL;
+		char *dash, *space;
+		size_t line_len;
+
+		/*
+		 * Example "System RAM" in /proc/iomem:
+		 * 00000000-1fffffffff : System RAM
+		 * 200000000000-201fffffffff : System RAM
+		 */
+		FILE *fd = fopen(proc_iomem, "r");
+		if (fd == NULL) {
+			EAL_LOG(ERR, "Cannot open %s", proc_iomem);
+			return -1;
+		}
+		/* Scan /proc/iomem for the highest PA in the system */
+		while (getline(&line, &line_len, fd) != -1) {
+			if (strstr(line, str_sysram) == NULL)
+				continue;
+
+			space = strstr(line, " ");
+			dash = strstr(line, "-");
+
+			/* Validate the format of the memory string */
+			if (space == NULL || dash == NULL || space < dash) {
+				EAL_LOG(ERR, "Can't parse line \"%s\" in file %s",
+					line, proc_iomem);
+				continue;
+			}
+
+			start = strtoull(line, NULL, 16);
+			end   = strtoull(dash + 1, NULL, 16);
+			EAL_LOG(DEBUG, "Found system RAM from 0x%" PRIx64
+				" to 0x%" PRIx64, start, end);
+			if (end > max)
+				max = end;
+		}
+		free(line);
+		fclose(fd);
+
+		if (max == 0) {
+			EAL_LOG(ERR, "Failed to find valid \"System RAM\" "
+				"entry in file %s", proc_iomem);
+			return -1;
+		}
+
+		spapr_dma_win_len = rte_align64pow2(max + 1);
+		return 0;
+	} else if (rte_eal_iova_mode() == RTE_IOVA_VA) {
+		EAL_LOG(DEBUG, "Highest VA address in memseg list is 0x%"
+			PRIx64, param->max_va);
+		spapr_dma_win_len = rte_align64pow2(param->max_va);
+		return 0;
+	}
+
+	spapr_dma_win_len = 0;
+	EAL_LOG(ERR, "Unsupported IOVA mode");
+	return -1;
+}
+
+
+/*
+ * The SPAPRv2 IOMMU supports 2 DMA windows with starting
+ * address at 0 or 1<<59.  By default, a DMA window is set
+ * at address 0, 2GB long, with a 4KB page.  For DPDK we
+ * must remove the default window and setup a new DMA window
+ * based on the hugepage size and memory requirements of
+ * the application before we can map memory for DMA.
+ */
+static int
+spapr_dma_win_size(void)
+{
+	struct spapr_size_walk_param param;
+
+	/* only create DMA window once */
+	if (spapr_dma_win_len > 0)
+		return 0;
+
+	/* walk the memseg list to find the page size/max VA address */
+	memset(&param, 0, sizeof(param));
+	if (rte_memseg_list_walk(vfio_spapr_size_walk, &param) < 0) {
+		EAL_LOG(ERR, "Failed to walk memseg list for DMA window size");
+		return -1;
+	}
+
+	/* we can't be sure if DMA window covers external memory */
+	if (param.is_user_managed)
+		EAL_LOG(WARNING, "Detected user managed external memory which may not be managed by the IOMMU");
+
+	/* check physical/virtual memory size */
+	if (find_highest_mem_addr(&param) < 0)
+		return -1;
+	EAL_LOG(DEBUG, "Setting DMA window size to 0x%" PRIx64,
+		spapr_dma_win_len);
+	spapr_dma_win_page_sz = param.page_sz;
+	rte_mem_set_dma_mask(rte_ctz64(spapr_dma_win_len));
+	return 0;
+}
+
+static int
+vfio_spapr_create_dma_window(struct container *cfg)
+{
+	struct vfio_iommu_spapr_tce_create create = {
+		.argsz = sizeof(create), };
+	struct vfio_iommu_spapr_tce_remove remove = {
+		.argsz = sizeof(remove), };
+	struct vfio_iommu_spapr_tce_info info = {
+		.argsz = sizeof(info), };
+	int ret;
+
+	ret = spapr_dma_win_size();
+	if (ret < 0)
+		return ret;
+
+	ret = ioctl(cfg->container_fd, VFIO_IOMMU_SPAPR_TCE_GET_INFO, &info);
+	if (ret) {
+		EAL_LOG(ERR, "Cannot get IOMMU info, error %i (%s)",
+			errno, strerror(errno));
+		return -1;
+	}
+
+	/*
+	 * sPAPR v1/v2 IOMMU always has a default 1G DMA window set.  The window
+	 * can't be changed for v1 but it can be changed for v2. Since DPDK only
+	 * supports v2, remove the default DMA window so it can be resized.
+	 */
+	remove.start_addr = info.dma32_window_start;
+	ret = ioctl(cfg->container_fd, VFIO_IOMMU_SPAPR_TCE_REMOVE, &remove);
+	if (ret)
+		return -1;
+
+	/* create a new DMA window (start address is not selectable) */
+	create.window_size = spapr_dma_win_len;
+	create.page_shift  = rte_ctz64(spapr_dma_win_page_sz);
+	create.levels = 1;
+	ret = ioctl(cfg->container_fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
+	/*
+	 * The vfio_iommu_spapr_tce_info structure was modified in
+	 * Linux kernel 4.2.0 to add support for the
+	 * vfio_iommu_spapr_tce_ddw_info structure needed to try
+	 * multiple table levels.  Skip the attempt if running with
+	 * an older kernel.
+	 */
+	if (ret) {
+		/* if at first we don't succeed, try more levels */
+		uint32_t levels;
+
+		for (levels = create.levels + 1;
+			ret && levels <= info.ddw.levels; levels++) {
+			create.levels = levels;
+			ret = ioctl(cfg->container_fd,
+				VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
+		}
+	}
+	if (ret) {
+		EAL_LOG(ERR, "Cannot create new DMA window, error "
+				"%i (%s)", errno, strerror(errno));
+		EAL_LOG(ERR,
+			"Consider using a larger hugepage size if supported by the system");
+		return -1;
+	}
+
+	/* verify the start address  */
+	if (create.start_addr != 0) {
+		EAL_LOG(ERR, "Received unsupported start address 0x%"
+			PRIx64, (uint64_t)create.start_addr);
+		return -1;
+	}
+	return ret;
+}
+
+static int
+vfio_spapr_dma_mem_map(struct container *cfg, uint64_t vaddr,
+		uint64_t iova, uint64_t len, int do_map)
+{
+	int ret = 0;
+
+	if (do_map) {
+		if (vfio_spapr_dma_do_map(cfg, vaddr, iova, len, 1)) {
+			EAL_LOG(ERR, "Failed to map DMA");
+			ret = -1;
+		}
+	} else {
+		if (vfio_spapr_dma_do_map(cfg, vaddr, iova, len, 0)) {
+			EAL_LOG(ERR, "Failed to unmap DMA");
+			ret = -1;
+		}
+	}
+
+	return ret;
+}
+
+static int
+vfio_spapr_dma_map(struct container *cfg)
+{
+	if (vfio_spapr_create_dma_window(cfg) < 0) {
+		EAL_LOG(ERR, "Could not create new DMA window!");
+		return -1;
+	}
+
+	/* map all existing DPDK segments for DMA */
+	if (rte_memseg_walk(vfio_spapr_map_walk, cfg) < 0)
+		return -1;
+
+	return 0;
+}
+
+static int
+vfio_noiommu_dma_map(struct container *cfg __rte_unused)
+{
+	/* No-IOMMU mode does not need DMA mapping */
+	return 0;
+}
+
+static int
+vfio_noiommu_dma_mem_map(struct container *cfg __rte_unused,
+			 uint64_t vaddr __rte_unused,
+			 uint64_t iova __rte_unused, uint64_t len __rte_unused,
+			 int do_map __rte_unused)
+{
+	/* No-IOMMU mode does not need DMA mapping */
+	return 0;
+}
+
+struct vfio_group *
+vfio_group_create(struct container *cfg, int iommu_group)
+{
+	struct vfio_group *grp;
+
+	if (cfg->group_cfg.n_groups >= RTE_DIM(cfg->group_cfg.groups)) {
+		EAL_LOG(ERR, "Cannot add more VFIO groups to container");
+		return NULL;
+	}
+	GROUP_FOREACH(cfg, grp) {
+		if (grp->active)
+			continue;
+		cfg->group_cfg.n_groups++;
+		grp->active = true;
+		grp->group_num = iommu_group;
+		grp->fd = -1;
+		return grp;
+	}
+	/* should not happen */
+	return NULL;
+}
+
+void
+vfio_group_erase(struct container *cfg, struct vfio_group *grp)
+{
+	struct vfio_group_config *group_cfg = &cfg->group_cfg;
+
+	if (grp->fd >= 0 && close(grp->fd) < 0)
+		EAL_LOG(ERR, "Error when closing group fd %d", grp->fd);
+
+	*grp = (struct vfio_group){0};
+	group_cfg->n_groups--;
+
+	/* if this was the last group in config, erase IOMMU setup and unregister callback */
+	if (group_cfg->n_groups == 0) {
+		group_cfg->dma_setup_done = false;
+		group_cfg->iommu_type_set = false;
+	}
+}
+
+struct vfio_group *
+vfio_group_get_by_num(struct container *cfg, int iommu_group)
+{
+	struct vfio_group *grp;
+
+	GROUP_FOREACH_ACTIVE(cfg, grp) {
+		if (grp->group_num == iommu_group)
+			return grp;
+	}
+	return NULL;
+}
+
+static int
+vfio_open_group_sysfs(int iommu_group_num)
+{
+	char filename[PATH_MAX];
+	int fd;
+
+	if (vfio_cfg.mode == RTE_VFIO_MODE_GROUP)
+		snprintf(filename, sizeof(filename), RTE_VFIO_GROUP_FMT, iommu_group_num);
+	else if (vfio_cfg.mode == RTE_VFIO_MODE_NOIOMMU)
+		snprintf(filename, sizeof(filename), RTE_VFIO_NOIOMMU_GROUP_FMT, iommu_group_num);
+
+	/* reset errno before open to differentiate errors */
+	errno = 0;
+	fd = open(filename, O_RDWR);
+
+	/* we have to differentiate between failed open and non-existence */
+	if (errno == ENOENT)
+		return -ENOENT;
+	return fd;
+}
+
+static int
+vfio_group_request_fd(int iommu_group_num)
+{
+	struct rte_mp_msg mp_req, *mp_rep;
+	struct rte_mp_reply mp_reply = {0};
+	struct timespec ts = {.tv_sec = 5, .tv_nsec = 0};
+	struct vfio_mp_param *p = (struct vfio_mp_param *)mp_req.param;
+	int vfio_group_fd = -1;
+
+	p->req = SOCKET_REQ_GROUP;
+	p->group_num = iommu_group_num;
+	rte_strscpy(mp_req.name, EAL_VFIO_MP, sizeof(mp_req.name));
+	mp_req.len_param = sizeof(*p);
+	mp_req.num_fds = 0;
+
+	if (rte_mp_request_sync(&mp_req, &mp_reply, &ts) == 0 && mp_reply.nb_received == 1) {
+		mp_rep = &mp_reply.msgs[0];
+		p = (struct vfio_mp_param *)mp_rep->param;
+		if (p->result == SOCKET_OK && mp_rep->num_fds == 1) {
+			vfio_group_fd = mp_rep->fds[0];
+		} else if (p->result == SOCKET_NO_FD) {
+			EAL_LOG(ERR, "Bad VFIO group fd");
+			vfio_group_fd = -ENOENT;
+		}
+	}
+
+	free(mp_reply.msgs);
+	return vfio_group_fd;
+}
+
+int
+vfio_group_open_fd(struct container *cfg, struct vfio_group *grp)
+{
+	int vfio_group_fd;
+
+	/* we make multiprocess request only in secondary processes for default config */
+	if ((rte_eal_process_type() != RTE_PROC_PRIMARY) && (vfio_container_is_default(cfg)))
+		vfio_group_fd = vfio_group_request_fd(grp->group_num);
+	else
+		vfio_group_fd = vfio_open_group_sysfs(grp->group_num);
+
+	/* pass the non-existence up the chain */
+	if (vfio_group_fd == -ENOENT)
+		return vfio_group_fd;
+	else if (vfio_group_fd < 0) {
+		EAL_LOG(ERR, "Failed to open VFIO group %d", grp->group_num);
+		return vfio_group_fd;
+	}
+	grp->fd = vfio_group_fd;
+	return 0;
+}
+
+static const struct vfio_iommu_ops *
+vfio_group_sync_iommu_ops(void)
+{
+	struct rte_mp_msg mp_req, *mp_rep;
+	struct rte_mp_reply mp_reply = {0};
+	struct timespec ts = {.tv_sec = 5, .tv_nsec = 0};
+	struct vfio_mp_param *p = (struct vfio_mp_param *)mp_req.param;
+	int iommu_type_id;
+	unsigned int i;
+
+	/* find default container's IOMMU type */
+	p->req = SOCKET_REQ_IOMMU_TYPE;
+	rte_strscpy(mp_req.name, EAL_VFIO_MP, sizeof(mp_req.name));
+	mp_req.len_param = sizeof(*p);
+	mp_req.num_fds = 0;
+
+	iommu_type_id = -1;
+	if (rte_mp_request_sync(&mp_req, &mp_reply, &ts) == 0 &&
+			mp_reply.nb_received == 1) {
+		mp_rep = &mp_reply.msgs[0];
+		p = (struct vfio_mp_param *)mp_rep->param;
+		if (p->result == SOCKET_OK)
+			iommu_type_id = p->iommu_type_id;
+	}
+	free(mp_reply.msgs);
+	if (iommu_type_id < 0) {
+		EAL_LOG(ERR, "Could not get IOMMU type from primary process");
+		return NULL;
+	}
+
+	/* we now have an fd for default container, as well as its IOMMU type.
+	 * now, set up default VFIO container config to match.
+	 */
+	for (i = 0; i < RTE_DIM(iommu_types); i++) {
+		const struct vfio_iommu_ops *t = &iommu_types[i];
+		if (t->type_id != iommu_type_id)
+			continue;
+
+		return t;
+	}
+	EAL_LOG(ERR, "Could not find IOMMU type id (%i)", iommu_type_id);
+	return NULL;
+}
+
+int
+vfio_group_noiommu_is_enabled(void)
+{
+	int fd;
+	ssize_t cnt;
+	char c;
+
+	fd = open(RTE_VFIO_NOIOMMU_MODE, O_RDONLY);
+	if (fd < 0) {
+		if (errno != ENOENT) {
+			EAL_LOG(ERR, "Cannot open VFIO noiommu file "
+					"%i (%s)", errno, strerror(errno));
+			return -1;
+		}
+		/*
+		 * else the file does not exists
+		 * i.e. noiommu is not enabled
+		 */
+		return 0;
+	}
+
+	cnt = read(fd, &c, 1);
+	close(fd);
+	if (cnt != 1) {
+		EAL_LOG(ERR, "Unable to read from VFIO noiommu file "
+				"%i (%s)", errno, strerror(errno));
+		return -1;
+	}
+
+	return c == 'Y';
+}
+
+static int
+vfio_has_supported_extensions(int vfio_container_fd)
+{
+	int ret;
+	unsigned int idx, n_extensions = 0;
+	for (idx = 0; idx < RTE_DIM(iommu_types); idx++) {
+		const struct vfio_iommu_ops *t = &iommu_types[idx];
+
+		ret = ioctl(vfio_container_fd, VFIO_CHECK_EXTENSION,
+				t->type_id);
+		if (ret < 0) {
+			EAL_LOG(ERR, "Could not get IOMMU type, error "
+					"%i (%s)", errno, strerror(errno));
+			close(vfio_container_fd);
+			return -1;
+		} else if (ret == 1) {
+			/* we found a supported extension */
+			n_extensions++;
+		}
+		EAL_LOG(DEBUG, "IOMMU type %d (%s) is %s",
+				t->type_id, t->name,
+				ret ? "supported" : "not supported");
+	}
+
+	/* if we didn't find any supported IOMMU types, fail */
+	if (!n_extensions)
+		return -1;
+
+	return 0;
+}
+
+int
+vfio_group_open_container_fd(void)
+{
+	int ret, vfio_container_fd;
+
+	vfio_container_fd = open(RTE_VFIO_CONTAINER_PATH, O_RDWR);
+	if (vfio_container_fd < 0) {
+		EAL_LOG(DEBUG, "Cannot open VFIO container %s, error %i (%s)",
+			RTE_VFIO_CONTAINER_PATH, errno, strerror(errno));
+		return -1;
+	}
+
+	/* check VFIO API version */
+	ret = ioctl(vfio_container_fd, VFIO_GET_API_VERSION);
+	if (ret != VFIO_API_VERSION) {
+		if (ret < 0)
+			EAL_LOG(DEBUG,
+				"Could not get VFIO API version, error "
+				"%i (%s)", errno, strerror(errno));
+		else
+			EAL_LOG(DEBUG, "Unsupported VFIO API version!");
+		close(vfio_container_fd);
+		return -1;
+	}
+
+	ret = vfio_has_supported_extensions(vfio_container_fd);
+	if (ret) {
+		EAL_LOG(DEBUG,
+			"No supported IOMMU extensions found!");
+		close(vfio_container_fd);
+		return -1;
+	}
+
+	return vfio_container_fd;
+}
+
+int
+vfio_group_enable(struct container *cfg)
+{
+	int container_fd;
+	DIR *dir;
+
+	/* VFIO directory might not exist (e.g., unprivileged containers) */
+	dir = opendir(RTE_VFIO_DIR);
+	if (dir == NULL) {
+		EAL_LOG(DEBUG,
+			"VFIO directory does not exist, skipping VFIO group support...");
+		return 1;
+	}
+	closedir(dir);
+
+	/* open a default container */
+	container_fd = vfio_group_open_container_fd();
+	if (container_fd < 0)
+		return -1;
+
+	cfg->container_fd = container_fd;
+	return 0;
+}
+
+int
+vfio_group_prepare(struct container *cfg, struct vfio_group *grp)
+{
+	struct vfio_group_status group_status = {
+		.argsz = sizeof(group_status)};
+	int ret;
+
+	/*
+	 * We need to assign group to a container and check if it is viable, but there are cases
+	 * where we don't need to do that.
+	 *
+	 * For default container, we need to set up the group only in primary process, as secondary
+	 * process would have requested group fd over IPC, which implies it would have already been
+	 * set up by the primary.
+	 *
+	 * For custom containers, every process sets up its own groups.
+	 */
+	if (vfio_container_is_default(cfg) && rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		EAL_LOG(DEBUG, "Skipping setup for VFIO group %d", grp->group_num);
+		return 0;
+	}
+
+	/* check if the group is viable */
+	ret = ioctl(grp->fd, VFIO_GROUP_GET_STATUS, &group_status);
+	if (ret) {
+		EAL_LOG(ERR, "Cannot get VFIO group status for group %d, error %i (%s)",
+				grp->group_num, errno, strerror(errno));
+		return -1;
+	}
+
+	if ((group_status.flags & VFIO_GROUP_FLAGS_VIABLE) == 0) {
+		EAL_LOG(ERR, "VFIO group %d is not viable! "
+			"Not all devices in IOMMU group bound to VFIO or unbound",
+			grp->group_num);
+		return -1;
+	}
+
+	/* set container for group if necessary */
+	if ((group_status.flags & VFIO_GROUP_FLAGS_CONTAINER_SET) == 0) {
+		/* add group to a container */
+		ret = ioctl(grp->fd, VFIO_GROUP_SET_CONTAINER, &cfg->container_fd);
+		if (ret) {
+			EAL_LOG(ERR, "Cannot add VFIO group %d to container, error %i (%s)",
+				grp->group_num, errno, strerror(errno));
+			return -1;
+		}
+	} else {
+		/* group is already added to a container - this should not happen */
+		EAL_LOG(ERR, "VFIO group %d is already assigned to a container", grp->group_num);
+		return -1;
+	}
+	return 0;
+}
+
+int
+vfio_group_setup_iommu(struct container *cfg)
+{
+	const struct vfio_iommu_ops *ops;
+
+	/*
+	 * Setting IOMMU type is a per-container operation (via ioctl on container fd), but the ops
+	 * structure is global and shared across all containers.
+	 *
+	 * For secondary processes with default container, we sync ops from primary. For all other
+	 * cases (primary, or secondary with custom containers), we set IOMMU type on the container
+	 * which also discovers the ops.
+	 */
+	if (vfio_container_is_default(cfg) && rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		/* Secondary process: sync ops from primary for default container */
+		ops = vfio_group_sync_iommu_ops();
+		if (ops == NULL)
+			return -1;
+	} else {
+		/* Primary process OR custom container: set IOMMU type on container */
+		ops = vfio_group_set_iommu_type(cfg->container_fd);
+		if (ops == NULL)
+			return -1;
+	}
+
+	/* Set or verify global ops */
+	if (vfio_cfg.ops == NULL) {
+		vfio_cfg.ops = ops;
+		EAL_LOG(INFO, "IOMMU type set to %d (%s)", ops->type_id, ops->name);
+	} else if (vfio_cfg.ops != ops) {
+		/* This shouldn't happen on the same machine, but log it */
+		EAL_LOG(WARNING,
+			"Container has different IOMMU type (%d - %s) than previously set (%d - %s)",
+			ops->type_id, ops->name, vfio_cfg.ops->type_id, vfio_cfg.ops->name);
+	}
+
+	return 0;
+}
+
+int
+vfio_group_setup_device_fd(const char *dev_addr, struct vfio_group *grp, struct vfio_device *dev)
+{
+	rte_uuid_t vf_token;
+	int fd;
+
+	rte_eal_vfio_get_vf_token(vf_token);
+
+	if (!rte_uuid_is_null(vf_token)) {
+		char vf_token_str[RTE_UUID_STRLEN];
+		char dev[PATH_MAX];
+
+		rte_uuid_unparse(vf_token, vf_token_str, sizeof(vf_token_str));
+		snprintf(dev, sizeof(dev),
+			 "%s vf_token=%s", dev_addr, vf_token_str);
+
+		fd = ioctl(grp->fd, VFIO_GROUP_GET_DEVICE_FD, dev);
+		if (fd >= 0)
+			goto out;
+	}
+	/* get a file descriptor for the device */
+	fd = ioctl(grp->fd, VFIO_GROUP_GET_DEVICE_FD, dev_addr);
+	if (fd < 0) {
+		/*
+		 * if we cannot get a device fd, this implies a problem with the VFIO group or the
+		 * container not having IOMMU configured.
+		 */
+		EAL_LOG(WARNING, "Getting a vfio_dev_fd for %s failed", dev_addr);
+		return -1;
+	}
+out:
+	dev->fd = fd;
+	/* store backreference to group */
+	dev->group = grp->group_num;
+	/* increment number of devices in group */
+	grp->n_devices++;
+	return 0;
+}
+
+int
+vfio_group_get_num(const char *sysfs_base, const char *dev_addr, int *iommu_group_num)
+{
+	char linkname[PATH_MAX];
+	char filename[PATH_MAX];
+	char *tok[16], *group_tok, *end;
+	int ret, group_num;
+
+	memset(linkname, 0, sizeof(linkname));
+	memset(filename, 0, sizeof(filename));
+
+	/* try to find out IOMMU group for this device */
+	snprintf(linkname, sizeof(linkname),
+			 "%s/%s/iommu_group", sysfs_base, dev_addr);
+
+	ret = readlink(linkname, filename, sizeof(filename));
+
+	/* if the link doesn't exist, no VFIO for us */
+	if (ret < 0)
+		return 0;
+
+	ret = rte_strsplit(filename, sizeof(filename),
+			tok, RTE_DIM(tok), '/');
+
+	if (ret <= 0) {
+		EAL_LOG(ERR, "%s cannot get IOMMU group", dev_addr);
+		return -1;
+	}
+
+	/* IOMMU group is always the last token */
+	errno = 0;
+	group_tok = tok[ret - 1];
+	end = group_tok;
+	group_num = strtol(group_tok, &end, 10);
+	if (end == group_tok || *end != '\0' || errno != 0) {
+		EAL_LOG(ERR, "%s error parsing IOMMU number!", dev_addr);
+		return -1;
+	}
+	*iommu_group_num = group_num;
+
+	return 1;
+}
diff --git a/lib/eal/linux/eal_vfio_mp_sync.c b/lib/eal/linux/eal_vfio_mp_sync.c
index 22136f2e8b..9a07d35023 100644
--- a/lib/eal/linux/eal_vfio_mp_sync.c
+++ b/lib/eal/linux/eal_vfio_mp_sync.c
@@ -32,21 +32,32 @@ vfio_mp_primary(const struct rte_mp_msg *msg, const void *peer)
 
 	switch (m->req) {
 	case SOCKET_REQ_GROUP:
+	{
+		struct container *cfg = vfio_cfg.default_cfg;
+		struct vfio_group *grp;
+
+		if (vfio_cfg.mode != RTE_VFIO_MODE_GROUP &&
+				vfio_cfg.mode != RTE_VFIO_MODE_NOIOMMU) {
+			EAL_LOG(ERR, "VFIO not initialized in group mode");
+			r->result = SOCKET_ERR;
+			break;
+		}
+
 		r->req = SOCKET_REQ_GROUP;
 		r->group_num = m->group_num;
-		fd = rte_vfio_get_group_fd(m->group_num);
-		if (fd < 0 && fd != -ENOENT)
-			r->result = SOCKET_ERR;
-		else if (fd == -ENOENT)
-			/* if VFIO group exists but isn't bound to VFIO driver */
+		grp = vfio_group_get_by_num(cfg, m->group_num);
+		if (grp == NULL) {
+			/* group doesn't exist in primary */
 			r->result = SOCKET_NO_FD;
-		else {
-			/* if group exists and is bound to VFIO driver */
+		} else {
+			/* group exists and is bound to VFIO driver */
+			fd = grp->fd;
 			r->result = SOCKET_OK;
 			reply.num_fds = 1;
 			reply.fds[0] = fd;
 		}
 		break;
+	}
 	case SOCKET_REQ_CONTAINER:
 		r->req = SOCKET_REQ_CONTAINER;
 		fd = rte_vfio_get_container_fd();
@@ -54,6 +65,7 @@ vfio_mp_primary(const struct rte_mp_msg *msg, const void *peer)
 			r->result = SOCKET_ERR;
 		else {
 			r->result = SOCKET_OK;
+			r->mode = vfio_cfg.mode;
 			reply.num_fds = 1;
 			reply.fds[0] = fd;
 		}
@@ -62,6 +74,13 @@ vfio_mp_primary(const struct rte_mp_msg *msg, const void *peer)
 	{
 		int iommu_type_id;
 
+		if (vfio_cfg.mode != RTE_VFIO_MODE_GROUP &&
+				vfio_cfg.mode != RTE_VFIO_MODE_NOIOMMU) {
+			EAL_LOG(ERR, "VFIO not initialized in group mode");
+			r->result = SOCKET_ERR;
+			break;
+		}
+
 		r->req = SOCKET_REQ_IOMMU_TYPE;
 
 		iommu_type_id = vfio_get_iommu_type();
@@ -90,8 +109,11 @@ vfio_mp_sync_setup(void)
 {
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		int ret = rte_mp_action_register(EAL_VFIO_MP, vfio_mp_primary);
-		if (ret && rte_errno != ENOTSUP)
+		if (ret && rte_errno != ENOTSUP) {
+			EAL_LOG(ERR, "Multiprocess sync setup failed: %d (%s)",
+					rte_errno, rte_strerror(rte_errno));
 			return -1;
+		}
 	}
 
 	return 0;
diff --git a/lib/eal/linux/meson.build b/lib/eal/linux/meson.build
index e99ebed256..75a9afdd03 100644
--- a/lib/eal/linux/meson.build
+++ b/lib/eal/linux/meson.build
@@ -16,6 +16,7 @@ sources += files(
         'eal_thread.c',
         'eal_timer.c',
         'eal_vfio.c',
+        'eal_vfio_group.c',
         'eal_vfio_mp_sync.c',
 )
 
-- 
2.47.3

