Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A589C61DB9
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 13:23:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B19940DF8;
	Tue, 25 Aug 2026 15:21:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id A071940BA3
 for <dev@dpdk.org>; Tue, 25 Aug 2026 15:21:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787664115; x=1819200115;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=fc4oEXj/Z6GNJlK43zFpibyaDpDDkNBU/TjFfn8zZE8=;
 b=H79ZDLfYADbm1GZrezKXntNwVYQu+yKPi0oDYvrceDiqoTyQKF2ZELco
 fSw9SbMx068AjwpzlaKG7zRy6uWRaF42pJnQpCcw+KKJCVDbuDBUKgUN2
 tVpR0Wyzqh0wGoYyNmmKVJQXYm1PtqLMb1iSntulqvH6EZ5Sb9plRvI1q
 ydO+gikziwOVswJrGaX0ecbMM9hZYz0525HkOWlAs/85uZ4FzfU/ixvyx
 MR6Uvh9oPBl6ScCiTQ9QrEOTFyv49olCbcOrSNKPLXK0vw2kfDc/e08Ou
 Cs5tzX0D6vR4ujaQxQ3PaqVb57n2M2rsCSg2eteF82jgRyiybXo3DM2b7 w==;
X-CSE-ConnectionGUID: PVkHGoo3Re+wBJcfgM4Kvg==
X-CSE-MsgGUID: DCoI34BkT7CkOF0ys8ZH0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88332748"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="88332748"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 06:21:54 -0700
X-CSE-ConnectionGUID: 15ZWS8uYSeCmcP1OwJC2Hw==
X-CSE-MsgGUID: JRvpBF5VSYe3Q8cr4ZHT7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="264660915"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa008.fm.intel.com with ESMTP; 25 Aug 2026 06:21:53 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v12 20/20] vfio: introduce cdev mode
Date: Tue, 25 Aug 2026 14:21:17 +0100
Message-ID: <da9b8164c3cfd2fd52ab0c29d4de9cb62bdf41c2.1787663787.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787663786.git.anatoly.burakov@intel.com>
 <cover.1787663786.git.anatoly.burakov@intel.com>
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

Add support for VFIO cdev (also known as IOMMUFD) API. The group API is now
considered legacy in the kernel, and all further development is expected to
happen in IOMMUFD infrastructure.

The implementation largely follows the kernel reference code, with most
differences from group mode concentrated in how the container and the
devices are set up. The VFIO container allocates an "IOAS" (IO address
space), maps the memory into that space, and attaches devices to IOAS -
there is no IOMMU type discovery at device attach time.

Unlike group mode, the cdev mode is device-centric, and all DMA mappings
are made for an IOAS and not into VFIO container itself. As a result, while
group mode only maps memory during first device attach, cdev mode can map
memory without having any devices attached. However, current VFIO init has
moved to before bus scan, because we need VFIO mode information for buses
to decide on IOVA mode. DMA memory mapping, however, must be performed
after the DPDK memory was already initialized, so we add another internal
API to trigger VFIO DMA maps for cdev mode right after memory init.

To assist any future use of VFIO cdev mode for custom behavior, also
introduce "get device number" API, which is kind-of-but-not-really similar
to the concept of IOMMU group.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 doc/guides/rel_notes/release_26_11.rst |   5 +
 lib/eal/freebsd/eal.c                  |  16 +
 lib/eal/include/rte_vfio.h             |  45 +++
 lib/eal/linux/eal.c                    |   7 +
 lib/eal/linux/eal_vfio.c               | 253 +++++++++++++++-
 lib/eal/linux/eal_vfio.h               |  30 +-
 lib/eal/linux/eal_vfio_cdev.c          | 396 +++++++++++++++++++++++++
 lib/eal/linux/eal_vfio_mp_sync.c       |  42 +++
 lib/eal/linux/meson.build              |   1 +
 9 files changed, 791 insertions(+), 4 deletions(-)
 create mode 100644 lib/eal/linux/eal_vfio_cdev.c

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index b5793b5c94..edee37d304 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,11 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added VFIO cdev (IOMMUFD) mode.**
+
+  Added support for the VFIO character device (cdev) API, also known as IOMMUFD.
+  DPDK now supports both the group mode and the new cdev mode.
+
 
 Removed Items
 -------------
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index bb05a969a9..39442d2bad 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -844,6 +844,12 @@ int rte_vfio_enable(__rte_unused const char *modname)
 	return -1;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_init_mem)
+int rte_vfio_init_mem(void)
+{
+	return 0;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_is_enabled)
 int rte_vfio_is_enabled(__rte_unused const char *modname)
 {
@@ -931,3 +937,13 @@ rte_vfio_get_mode(void)
 {
 	return RTE_VFIO_MODE_NONE;
 }
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_device_num)
+int
+rte_vfio_get_device_num(__rte_unused const char *sysfs_base,
+		__rte_unused const char *dev_addr,
+		__rte_unused int *vfio_device_num)
+{
+	rte_errno = ENOTSUP;
+	return -1;
+}
diff --git a/lib/eal/include/rte_vfio.h b/lib/eal/include/rte_vfio.h
index c4ba0e5cda..ba557cbfdb 100644
--- a/lib/eal/include/rte_vfio.h
+++ b/lib/eal/include/rte_vfio.h
@@ -28,6 +28,8 @@ extern "C" {
 
 #define RTE_VFIO_DIR "/dev/vfio"
 #define RTE_VFIO_CONTAINER_PATH "/dev/vfio/vfio"
+#define RTE_VFIO_IOMMUFD_PATH "/dev/iommu"
+#define RTE_VFIO_CDEV_DEVICES_PATH "/dev/vfio/devices"
 #define RTE_VFIO_GROUP_FMT "/dev/vfio/%u"
 #define RTE_VFIO_NOIOMMU_GROUP_FMT "/dev/vfio/noiommu-%u"
 #define RTE_VFIO_NOIOMMU_MODE "/sys/module/vfio/parameters/enable_unsafe_noiommu_mode"
@@ -48,11 +50,13 @@ struct vfio_device_info;
  * - RTE_VFIO_MODE_NONE: VFIO is not enabled.
  * - RTE_VFIO_MODE_GROUP: Legacy group mode.
  * - RTE_VFIO_MODE_NOIOMMU: Unsafe no-IOMMU mode.
+ * - RTE_VFIO_MODE_CDEV: Character device mode.
  */
 enum rte_vfio_mode {
 	RTE_VFIO_MODE_NONE = 0, /**< VFIO not enabled */
 	RTE_VFIO_MODE_GROUP,    /**< Group mode */
 	RTE_VFIO_MODE_NOIOMMU,  /**< Group mode with no IOMMU protection */
+	RTE_VFIO_MODE_CDEV,     /**< Device mode */
 };
 
 /**
@@ -141,6 +145,20 @@ int rte_vfio_release_device(const char *sysfs_base, const char *dev_addr, int fd
 __rte_internal
 int rte_vfio_enable(const char *modname);
 
+/**
+ * @internal
+ * Initialize VFIO memory mapping. Must be called after `rte_vfio_enable()` and
+ * after EAL memory initialization has completed.
+ *
+ * This function is only relevant on Linux.
+ *
+ * @return
+ *   0 on success.
+ *   <0 on failure.
+ */
+__rte_internal
+int rte_vfio_init_mem(void);
+
 /**
  * @internal
  * Check if VFIO subsystem is initialized and a specified kernel module is loaded.
@@ -197,6 +215,33 @@ __rte_internal
 int
 rte_vfio_get_group_num(const char *sysfs_base, const char *dev_addr, int *iommu_group_num);
 
+/**
+ * @internal
+ * Parse VFIO cdev device number for a device.
+ *
+ * This function is only relevant on Linux in cdev mode.
+ *
+ * @param sysfs_base
+ *   Sysfs path prefix.
+ * @param dev_addr
+ *   Device identifier.
+ * @param vfio_device_num
+ *   Pointer to where VFIO cdev device number will be stored.
+ *
+ * @return
+ *   0 on success.
+ *   <0 on failure, rte_errno is set.
+ *
+ * Possible rte_errno values include:
+ * - ENODEV  - Device not managed by VFIO.
+ * - EINVAL  - Invalid parameters.
+ * - ENXIO   - VFIO support not initialized.
+ * - ENOTSUP - Unsupported VFIO mode.
+ */
+__rte_internal
+int
+rte_vfio_get_device_num(const char *sysfs_base, const char *dev_addr, int *vfio_device_num);
+
 /**
  * @internal
  * Get device information.
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 5bc095bd61..97350fbb2a 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -819,6 +819,13 @@ rte_eal_init(int argc, char **argv)
 		goto err_out;
 	}
 
+	/* VFIO memory setup that requires DPDK memory to be available. */
+	if (rte_vfio_init_mem() < 0) {
+		rte_eal_init_alert("Cannot init VFIO memory");
+		rte_errno = EAGAIN;
+		goto err_out;
+	}
+
 	/* register multi-process action callbacks for hotplug after memory init */
 	if (eal_mp_dev_hotplug_init() < 0) {
 		rte_eal_init_alert("failed to register mp callback for hotplug");
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 2092ccba53..8fd32aed6c 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -347,6 +347,20 @@ vfio_container_get_by_group_num(int group_num)
 	return NULL;
 }
 
+static struct container *
+vfio_container_get_by_dev_num(int dev_num)
+{
+	struct container *cfg;
+	struct vfio_device *dev;
+
+	CONTAINER_FOREACH_ACTIVE(cfg) {
+		DEVICE_FOREACH_ACTIVE(cfg, dev)
+			if (dev->dev_num == dev_num)
+				return cfg;
+	}
+	return NULL;
+}
+
 static struct container *
 vfio_container_create(void)
 {
@@ -516,6 +530,55 @@ vfio_setup_dma_mem(struct container *cfg)
 	return 0;
 }
 
+static enum vfio_result
+vfio_cdev_assign_device(struct container *cfg, const char *sysfs_base,
+		const char *dev_addr, struct vfio_device **out_dev)
+{
+	struct vfio_device *dev, *found_dev;
+	enum vfio_result res;
+	int dev_num, ret;
+
+	/* get the cdev device number from sysfs */
+	ret = vfio_cdev_get_device_num(sysfs_base, dev_addr, &dev_num);
+	if (ret < 0) {
+		EAL_LOG(ERR, "Failed to get cdev device number for %s", dev_addr);
+		return VFIO_ERROR;
+	} else if (ret == 0) {
+		EAL_LOG(ERR, "Device %s not bound to vfio-pci cdev", dev_addr);
+		return VFIO_NOT_MANAGED;
+	}
+
+	/* do we already have this device? */
+	found_dev = vfio_cdev_get_dev_by_num(cfg, dev_num);
+	if (found_dev != NULL) {
+		EAL_LOG(ERR, "Device %s already assigned to this container", dev_addr);
+		*out_dev = found_dev;
+		return VFIO_EXISTS;
+	}
+	/* create new device structure */
+	dev = vfio_device_create(cfg);
+	if (dev == NULL) {
+		EAL_LOG(ERR, "No space to track new VFIO cdev device");
+		return VFIO_NO_SPACE;
+	}
+	/* store device number */
+	dev->dev_num = dev_num;
+
+	/* set up our device now and store it in config */
+	ret = vfio_cdev_setup_device(cfg, dev);
+	if (ret < 0) {
+		EAL_LOG(ERR, "Cannot setup cdev device %s", dev_addr);
+		res = VFIO_ERROR;
+		goto err;
+	}
+	*out_dev = dev;
+	return VFIO_SUCCESS;
+
+err:
+	vfio_device_erase(cfg, dev);
+	return res;
+}
+
 static enum vfio_result
 vfio_group_assign_device(struct container *cfg, const char *sysfs_base,
 		const char *dev_addr, struct vfio_device **out_dev)
@@ -662,6 +725,49 @@ rte_vfio_container_assign_device(int container_fd, const char *sysfs_base, const
 		return -1;
 	}
 
+	/*
+	 * The device-to-container assignment is a complex problem to solve, for the following
+	 * reasons:
+	 *
+	 * 1. PCI infrastructure is decoupled from VFIO, so PCI does not know anything about VFIO
+	 *
+	 * This means that while 99% of VFIO usage is PCI-related, we cannot communicate to PCI that
+	 * we want to map a particular device using a particular container. Previously, this was
+	 * achieved using back-channel communication via IOMMU group binding, so that whenever PCI
+	 * map actually happens, VFIO knows which container to use, so this is roughly the model we
+	 * are going with.
+	 *
+	 * 2. VFIO cannot depend on PCI because VFIO is in EAL
+	 *
+	 * We cannot "assign" a PCI device to container using rte_pci_device pointer because VFIO
+	 * cannot depend on PCI definitions, nor can't we even assume that our device is in fact a
+	 * PCI device, even though in practice this is true (at the time of this writing, FSLMC is
+	 * the only bus doing non-PCI VFIO mappings, but FSLMC manages all VFIO infrastructure by
+	 * itself, so in practice even counting FSLMC bus, we're always dealing with PCI devices).
+	 *
+	 * 3. The "assignment" means different things for group and cdev mode
+	 *
+	 * In group mode, to "bind" a device to a specific container, it is enough to bind its
+	 * IOMMU group, so that when rte_vfio_setup_device() is called, we simply retrieve already
+	 * existing group, and through that we figure out which container to use.
+	 *
+	 * For cdev mode, there are no "groups", so "assignment" either means we store some kind of
+	 * uniquely identifying token (such as device number, or an opaque pointer), or we simply
+	 * open the device straight away, and when rte_vfio_setup_device() comes we simply return
+	 * the fd that was already opened at assign.
+	 *
+	 * Doing it the latter way (opening the device at assign for both group and cdev modes)
+	 * actually solves all of these problems, so that's what we're going to do - the device
+	 * setup API call will actually just assign the device to default container, while release
+	 * will automatically cleanup and unassign anything that needs unassigned. There will be no
+	 * "unassign" call, as it is not necessary.
+	 *
+	 * There is one downside for group mode when adding duplicate devices: to get to device fd,
+	 * we need to go through the entire codepath before we arrive at fd only to realize it was
+	 * already opened earlier, but this is acceptable compromise for unifying the API around
+	 * device assignment.
+	 */
+
 	if (vfio_cfg.mode == RTE_VFIO_MODE_NONE) {
 		EAL_LOG(ERR, "VFIO support not initialized");
 		rte_errno = ENXIO;
@@ -682,6 +788,9 @@ rte_vfio_container_assign_device(int container_fd, const char *sysfs_base, const
 	case RTE_VFIO_MODE_NOIOMMU:
 		res = vfio_group_assign_device(cfg, sysfs_base, dev_addr, &dev);
 		break;
+	case RTE_VFIO_MODE_CDEV:
+		res = vfio_cdev_assign_device(cfg, sysfs_base, dev_addr, &dev);
+		break;
 	default:
 		EAL_LOG(ERR, "Unsupported VFIO mode");
 		res = VFIO_NOT_SUPPORTED;
@@ -754,6 +863,24 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		res = vfio_group_assign_device(cfg, sysfs_base, dev_addr, &dev);
 		break;
 	}
+	case RTE_VFIO_MODE_CDEV:
+	{
+		int dev_num;
+
+		/* find device number */
+		ret = vfio_cdev_get_device_num(sysfs_base, dev_addr, &dev_num);
+		if (ret < 0)
+			goto assign_fail;
+		else if (ret == 0)
+			goto not_managed;
+
+		cfg = vfio_container_get_by_dev_num(dev_num);
+		if (cfg == NULL)
+			cfg = vfio_cfg.default_cfg;
+
+		res = vfio_cdev_assign_device(cfg, sysfs_base, dev_addr, &dev);
+		break;
+	}
 	default:
 		EAL_LOG(ERR, "Unsupported VFIO mode");
 		rte_errno = ENOTSUP;
@@ -873,6 +1000,12 @@ rte_vfio_release_device(const char *sysfs_base __rte_unused,
 		}
 		break;
 	}
+	case RTE_VFIO_MODE_CDEV:
+	{
+		/* for cdev, just erase the device and we're done */
+		vfio_device_erase(cfg, dev);
+		break;
+	}
 	default:
 		EAL_LOG(ERR, "Unsupported VFIO mode");
 		rte_errno = ENOTSUP;
@@ -937,8 +1070,24 @@ vfio_select_mode(void)
 		if (vfio_sync_mode(cfg, &mode) < 0)
 			goto err;
 
-		/* primary handles DMA setup for default containers */
-		cfg->dma_setup_done = true;
+		if (mode == RTE_VFIO_MODE_CDEV) {
+			/* set up ops and sync IOAS */
+			vfio_cdev_setup_ops();
+			if (vfio_cdev_sync_ioas(cfg) < 0)
+				goto err;
+
+			/* primary handles DMA */
+			cfg->dma_setup_done = true;
+		} else if (mode == RTE_VFIO_MODE_GROUP ||
+					mode == RTE_VFIO_MODE_NOIOMMU) {
+			/* primary handles DMA */
+			cfg->dma_setup_done = true;
+		} else {
+			/* shouldn't happen */
+			EAL_LOG(ERR, "Unknown VFIO mode %d", mode);
+			goto err;
+		}
+
 		return mode;
 	}
 	/* if we failed mp sync setup, we cannot initialize VFIO */
@@ -955,10 +1104,17 @@ vfio_select_mode(void)
 			return RTE_VFIO_MODE_NOIOMMU;
 		return RTE_VFIO_MODE_GROUP;
 	}
+	EAL_LOG(DEBUG, "VFIO group mode not available, trying cdev mode...");
+	/* cdev ops, IOAS and DMA setup are deferred to rte_vfio_init_mem() */
+	if (vfio_cdev_enable(cfg) == 0)
+		return RTE_VFIO_MODE_CDEV;
+	EAL_LOG(DEBUG, "VFIO cdev mode not available");
 err_mpsync:
 	vfio_mp_sync_cleanup();
 err:
 	vfio_container_erase(cfg);
+	/* reset ops as well */
+	vfio_cfg.ops = NULL;
 
 	return RTE_VFIO_MODE_NONE;
 }
@@ -969,6 +1125,7 @@ vfio_mode_to_str(enum rte_vfio_mode mode)
 	switch (mode) {
 	case RTE_VFIO_MODE_GROUP: return "group";
 	case RTE_VFIO_MODE_NOIOMMU: return "noiommu";
+	case RTE_VFIO_MODE_CDEV: return "cdev";
 	default: return "not initialized";
 	}
 }
@@ -1016,6 +1173,36 @@ rte_vfio_enable(const char *modname)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_init_mem)
+int
+rte_vfio_init_mem(void)
+{
+	struct container *cfg = vfio_cfg.default_cfg;
+
+	/* secondary already synced everything during rte_vfio_enable() */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return 0;
+
+	switch (vfio_cfg.mode) {
+	case RTE_VFIO_MODE_CDEV:
+		/* iommufd IOAS is populated once DPDK memory is available */
+		vfio_cdev_setup_ops();
+		if (vfio_cdev_setup_ioas(cfg) < 0)
+			return -1;
+		if (vfio_setup_dma_mem(cfg) < 0)
+			return -1;
+		if (vfio_register_mem_event_callback() < 0)
+			return -1;
+		cfg->dma_setup_done = true;
+		break;
+	default:
+		/* group/noiommu map memory at device attach, or no VFIO */
+		break;
+	}
+
+	return 0;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_is_enabled)
 int
 rte_vfio_is_enabled(const char *modname)
@@ -1108,6 +1295,40 @@ rte_vfio_get_group_num(const char *sysfs_base, const char *dev_addr, int *iommu_
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_device_num)
+int
+rte_vfio_get_device_num(const char *sysfs_base, const char *dev_addr, int *device_num)
+{
+	int ret;
+
+	if (sysfs_base == NULL || dev_addr == NULL || device_num == NULL) {
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
+	if (vfio_cfg.mode != RTE_VFIO_MODE_CDEV) {
+		EAL_LOG(ERR, "VFIO not initialized in cdev mode");
+		rte_errno = ENOTSUP;
+		return -1;
+	}
+
+	ret = vfio_cdev_get_device_num(sysfs_base, dev_addr, device_num);
+	if (ret < 0) {
+		rte_errno = EINVAL;
+		return -1;
+	} else if (ret == 0) {
+		rte_errno = ENODEV;
+		return -1;
+	}
+	return 0;
+}
+
 static int
 vfio_dma_mem_map(struct container *cfg, uint64_t vaddr, uint64_t iova,
 		uint64_t len, int do_map)
@@ -1307,6 +1528,27 @@ rte_vfio_container_create(void)
 		cfg->container_fd = container_fd;
 		break;
 	}
+	case RTE_VFIO_MODE_CDEV:
+	{
+		/* Open new iommufd for custom container */
+		container_fd = vfio_cdev_get_iommufd();
+		if (container_fd < 0) {
+			EAL_LOG(ERR, "Cannot open iommufd for cdev container");
+			rte_errno = EIO;
+			goto err;
+		}
+		cfg->container_fd = container_fd;
+
+		/* Set up IOAS for this container */
+		if (vfio_cdev_setup_ioas(cfg) < 0) {
+			EAL_LOG(ERR, "Cannot setup IOAS for cdev container");
+			rte_errno = EIO;
+			goto err;
+		}
+		/* we only need to set up IOAS for DMA to work */
+		cfg->dma_setup_done = true;
+		break;
+	}
 	default:
 		EAL_LOG(NOTICE, "Unsupported VFIO mode");
 		rte_errno = ENOTSUP;
@@ -1365,6 +1607,13 @@ rte_vfio_container_destroy(int container_fd)
 			vfio_group_erase(cfg, grp);
 		}
 		break;
+	case RTE_VFIO_MODE_CDEV:
+		/* erase all devices */
+		DEVICE_FOREACH_ACTIVE(cfg, dev) {
+			EAL_LOG(DEBUG, "Device vfio%d still open, closing", dev->dev_num);
+			vfio_device_erase(cfg, dev);
+		}
+		break;
 	default:
 		EAL_LOG(ERR, "Unsupported VFIO mode");
 		rte_errno = ENOTSUP;
diff --git a/lib/eal/linux/eal_vfio.h b/lib/eal/linux/eal_vfio.h
index c49f55bb8f..5fda472e29 100644
--- a/lib/eal/linux/eal_vfio.h
+++ b/lib/eal/linux/eal_vfio.h
@@ -48,7 +48,10 @@ struct vfio_group {
 /* device tracking (common for group and cdev modes) */
 struct vfio_device {
 	bool active;
-	int group; /**< back-reference to group list (group mode) */
+	union {
+		int group; /**< back-reference to group list (group mode) */
+		int dev_num;   /**< device number, e.g., X in /dev/vfio/devices/vfioX (cdev mode) */
+	};
 	int fd;
 };
 
@@ -60,13 +63,21 @@ struct vfio_group_config {
 	struct vfio_group groups[RTE_MAX_VFIO_GROUPS];
 };
 
+/* cdev mode specific configuration */
+struct vfio_cdev_config {
+	uint32_t ioas_id;
+};
+
 /* per-container configuration */
 struct container {
 	bool active;
 	bool dma_setup_done;
 	int container_fd;
 	struct user_mem_maps mem_maps;
-	struct vfio_group_config group_cfg;
+	union {
+		struct vfio_group_config group_cfg;
+		struct vfio_cdev_config cdev_cfg;
+	};
 	int n_devices;
 	struct vfio_device devices[RTE_MAX_VFIO_DEVICES];
 };
@@ -161,12 +172,25 @@ int vfio_group_setup_iommu(struct container *cfg);
 int vfio_group_setup_device_fd(const char *dev_addr,
 		struct vfio_group *grp, struct vfio_device *dev);
 
+/* cdev mode functions */
+int vfio_cdev_enable(struct container *cfg);
+void vfio_cdev_setup_ops(void);
+int vfio_cdev_setup_ioas(struct container *cfg);
+int vfio_cdev_sync_ioas(struct container *cfg);
+int vfio_cdev_get_iommufd(void);
+int vfio_cdev_get_device_num(const char *sysfs_base, const char *dev_addr,
+		int *cdev_dev_num);
+struct vfio_device *vfio_cdev_get_dev_by_num(struct container *cfg, int cdev_dev_num);
+int vfio_cdev_setup_device(struct container *cfg, struct vfio_device *dev);
+
 #define VFIO_MEM_EVENT_CLB_NAME "vfio_mem_event_clb"
 #define EAL_VFIO_MP "eal_vfio_mp_sync"
 
 #define SOCKET_REQ_CONTAINER 0x100
 #define SOCKET_REQ_GROUP 0x200
 #define SOCKET_REQ_IOMMU_TYPE 0x400
+#define SOCKET_REQ_CDEV 0x800
+#define SOCKET_REQ_IOAS_ID 0x1000
 #define SOCKET_OK 0x0
 #define SOCKET_NO_FD 0x1
 #define SOCKET_ERR 0xFF
@@ -177,6 +201,8 @@ struct vfio_mp_param {
 	union {
 		int group_num;
 		int iommu_type_id;
+		int cdev_dev_num;
+		int ioas_id;
 		enum rte_vfio_mode mode;
 	};
 };
diff --git a/lib/eal/linux/eal_vfio_cdev.c b/lib/eal/linux/eal_vfio_cdev.c
new file mode 100644
index 0000000000..a659891b60
--- /dev/null
+++ b/lib/eal/linux/eal_vfio_cdev.c
@@ -0,0 +1,396 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2010-2025 Intel Corporation
+ */
+
+#include <dirent.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+#include <uapi/linux/iommufd.h>
+#include <uapi/linux/vfio.h>
+
+#include <rte_log.h>
+#include <rte_errno.h>
+#include <rte_memory.h>
+#include <rte_string_fns.h>
+
+#include "eal_vfio.h"
+#include "eal_private.h"
+#include "eal_internal_cfg.h"
+
+static int vfio_cdev_dma_map(struct container *cfg);
+static int vfio_cdev_dma_mem_map(struct container *cfg, uint64_t vaddr,
+		uint64_t iova, uint64_t len, int do_map);
+
+/* IOMMUFD cdev mode IOMMU operations */
+static const struct vfio_iommu_ops iommufd_ops = {
+	.type_id = 0, /* cdev mode doesn't use type_id */
+	.name = "IOMMUFD",
+	.partial_unmap = false,
+	.dma_map_func = &vfio_cdev_dma_map,
+	.dma_user_map_func = &vfio_cdev_dma_mem_map
+};
+
+void
+vfio_cdev_setup_ops(void)
+{
+	vfio_cfg.ops = &iommufd_ops;
+}
+
+static int
+vfio_cdev_dma_mem_map(struct container *cfg, uint64_t vaddr, uint64_t iova,
+		uint64_t len, int do_map)
+{
+	struct iommu_ioas_map ioas_map;
+	struct iommu_ioas_unmap ioas_unmap;
+	int ret;
+
+	if (do_map != 0) {
+		memset(&ioas_map, 0, sizeof(ioas_map));
+		ioas_map.size = sizeof(struct iommu_ioas_map);
+		ioas_map.flags = IOMMU_IOAS_MAP_FIXED_IOVA |
+				IOMMU_IOAS_MAP_READABLE |
+				IOMMU_IOAS_MAP_WRITEABLE;
+		ioas_map.ioas_id = cfg->cdev_cfg.ioas_id;
+		ioas_map.user_va = vaddr;
+		ioas_map.length = len;
+		ioas_map.iova = iova;
+
+		ret = ioctl(cfg->container_fd, IOMMU_IOAS_MAP, &ioas_map);
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
+		memset(&ioas_unmap, 0, sizeof(ioas_unmap));
+		ioas_unmap.size = sizeof(struct iommu_ioas_unmap);
+		ioas_unmap.ioas_id = cfg->cdev_cfg.ioas_id;
+		ioas_unmap.length = len;
+		ioas_unmap.iova = iova;
+
+		ret = ioctl(cfg->container_fd, IOMMU_IOAS_UNMAP, &ioas_unmap);
+		if (ret) {
+			EAL_LOG(ERR, "Cannot clear DMA remapping, error "
+					"%i (%s)", errno, strerror(errno));
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+static int
+cdev_map(const struct rte_memseg_list *msl, const struct rte_memseg *ms,
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
+	return vfio_cdev_dma_mem_map(cfg, ms->addr_64, ms->iova, ms->len, 1);
+}
+
+static int
+vfio_cdev_dma_map(struct container *cfg)
+{
+	return rte_memseg_walk(cdev_map, cfg);
+}
+
+int
+vfio_cdev_sync_ioas(struct container *cfg)
+{
+	struct rte_mp_msg mp_req, *mp_rep;
+	struct rte_mp_reply mp_reply = {0};
+	struct timespec ts = {.tv_sec = 5, .tv_nsec = 0};
+	struct vfio_mp_param *p = (struct vfio_mp_param *)mp_req.param;
+
+	p->req = SOCKET_REQ_IOAS_ID;
+	rte_strscpy(mp_req.name, EAL_VFIO_MP, sizeof(mp_req.name));
+	mp_req.len_param = sizeof(*p);
+	mp_req.num_fds = 0;
+
+	if (rte_mp_request_sync(&mp_req, &mp_reply, &ts) == 0 && mp_reply.nb_received == 1) {
+		mp_rep = &mp_reply.msgs[0];
+		p = (struct vfio_mp_param *)mp_rep->param;
+		if (p->result == SOCKET_OK && mp_rep->num_fds == 0) {
+			cfg->cdev_cfg.ioas_id = p->ioas_id;
+			free(mp_reply.msgs);
+			return 0;
+		}
+	}
+
+	free(mp_reply.msgs);
+	EAL_LOG(ERR, "Cannot request ioas_id");
+	return -1;
+}
+
+int
+vfio_cdev_setup_ioas(struct container *cfg)
+{
+	struct iommu_ioas_alloc ioas_alloc;
+	int ret;
+
+	/* Allocate an IOAS */
+	memset(&ioas_alloc, 0, sizeof(ioas_alloc));
+	ioas_alloc.size = sizeof(struct iommu_ioas_alloc);
+	ioas_alloc.flags = 0;
+
+	ret = ioctl(cfg->container_fd, IOMMU_IOAS_ALLOC, &ioas_alloc);
+	if (ret) {
+		EAL_LOG(ERR, "Cannot allocate IOAS, error %i (%s)",
+				errno, strerror(errno));
+		return -1;
+	}
+	cfg->cdev_cfg.ioas_id = ioas_alloc.out_ioas_id;
+
+	EAL_LOG(DEBUG, "Allocated IOAS with ID %u", cfg->cdev_cfg.ioas_id);
+	return 0;
+}
+
+int
+vfio_cdev_get_iommufd(void)
+{
+	int iommufd;
+
+	/* if not requesting via mp, open iommufd locally */
+	iommufd = open(RTE_VFIO_IOMMUFD_PATH, O_RDWR);
+	if (iommufd < 0) {
+		EAL_LOG(ERR, "Cannot open %s: %s",
+				RTE_VFIO_IOMMUFD_PATH, strerror(errno));
+		return -1;
+	}
+
+	return iommufd;
+}
+
+int
+vfio_cdev_enable(struct container *cfg)
+{
+	int iommufd;
+
+	/* Check if iommufd device exists */
+	if (access(RTE_VFIO_IOMMUFD_PATH, F_OK) != 0) {
+		EAL_LOG(DEBUG,
+			"IOMMUFD device does not exist, skipping VFIO cdev support...");
+		return 1;
+	}
+
+	/* open iommufd */
+	iommufd = vfio_cdev_get_iommufd();
+	if (iommufd < 0)
+		return -1;
+
+	cfg->container_fd = iommufd;
+	return 0;
+}
+
+int
+vfio_cdev_get_device_num(const char *sysfs_base, const char *dev_addr, int *cdev_dev_num)
+{
+	char linkname[PATH_MAX];
+	char filename[PATH_MAX];
+	char *dev_tok, *end;
+	int dev_num;
+	DIR *dir;
+	struct dirent *entry;
+
+	memset(linkname, 0, sizeof(linkname));
+	memset(filename, 0, sizeof(filename));
+
+	/* check if vfio-dev directory exists for this device */
+	snprintf(linkname, sizeof(linkname),
+			 "%s/%s/vfio-dev", sysfs_base, dev_addr);
+
+	dir = opendir(linkname);
+	if (dir == NULL) {
+		/* device doesn't have vfio-dev, not bound to vfio-pci cdev */
+		return 0;
+	}
+
+	/* find vfioX entry in vfio-dev directory */
+	while ((entry = readdir(dir)) != NULL) {
+		if (strncmp(entry->d_name, "vfio", 4) == 0) {
+			/* parse device number from vfioX */
+			errno = 0;
+			dev_tok = entry->d_name + 4; /* skip "vfio" prefix */
+			end = dev_tok;
+			dev_num = strtol(dev_tok, &end, 10);
+			if (end == dev_tok || *end != '\0' || errno != 0) {
+				EAL_LOG(ERR, "%s error parsing VFIO cdev device number!",
+						dev_addr);
+				closedir(dir);
+				return -1;
+			}
+			*cdev_dev_num = dev_num;
+			closedir(dir);
+			return 1;
+		}
+	}
+
+	closedir(dir);
+	/* no vfio device found */
+	return 0;
+}
+
+struct vfio_device *
+vfio_cdev_get_dev_by_num(struct container *cfg, int cdev_dev_num)
+{
+	struct vfio_device *dev;
+	/* find device handle */
+	DEVICE_FOREACH_ACTIVE(cfg, dev) {
+		if (dev->dev_num != cdev_dev_num)
+			continue;
+		return dev;
+	}
+	return NULL;
+}
+
+static int
+cdev_open_device_fd(int cdev_dev_num)
+{
+	char devname[PATH_MAX] = {0};
+	int dev_fd;
+
+	snprintf(devname, sizeof(devname), "%s/vfio%d",
+			RTE_VFIO_CDEV_DEVICES_PATH, cdev_dev_num);
+
+	dev_fd = open(devname, O_RDWR);
+	if (dev_fd < 0) {
+		EAL_LOG(ERR, "Cannot open %s: %s", devname, strerror(errno));
+		return -1;
+	}
+
+	return dev_fd;
+}
+
+static int
+cdev_attach_device_to_iommufd(struct container *cfg, struct vfio_device *dev)
+{
+	struct vfio_device_bind_iommufd bind = {0};
+	struct vfio_device_attach_iommufd_pt attach = {0};
+	rte_uuid_t vf_token;
+
+	rte_eal_vfio_get_vf_token(vf_token);
+
+	/* try with token first */
+	if (!rte_uuid_is_null(vf_token)) {
+		bind.flags = VFIO_DEVICE_BIND_FLAG_TOKEN;
+		bind.token_uuid_ptr = (uintptr_t)&vf_token;
+		bind.argsz = sizeof(bind);
+		bind.iommufd = cfg->container_fd;
+
+		/* this may fail because the kernel is too old */
+		if (ioctl(dev->fd, VFIO_DEVICE_BIND_IOMMUFD, &bind) < 0) {
+			EAL_LOG(DEBUG, "Failed to bind device %d with VF token", dev->dev_num);
+			EAL_LOG(NOTICE, "Unable to use VF tokens with current kernel version.");
+			EAL_LOG(NOTICE, "Please use kernel >=6.17 or use group mode.");
+			/* erase the bind structure */
+			bind = (struct vfio_device_bind_iommufd){0};
+		} else {
+			goto attach;
+		}
+	}
+	bind.flags = 0;
+	bind.argsz = sizeof(bind);
+	bind.iommufd = cfg->container_fd;
+
+	if (ioctl(dev->fd, VFIO_DEVICE_BIND_IOMMUFD, &bind) < 0) {
+		EAL_LOG(ERR, "Cannot bind device to IOMMUFD, error %i (%s)",
+				errno, strerror(errno));
+		return -1;
+	}
+
+attach:
+	/* attach device to IOAS */
+	attach.argsz = sizeof(attach);
+	attach.flags = 0;
+	attach.pt_id = cfg->cdev_cfg.ioas_id;
+
+	if (ioctl(dev->fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach) < 0) {
+		EAL_LOG(ERR, "Cannot attach device to IOAS, error %i (%s)",
+				errno, strerror(errno));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int
+vfio_cdev_request_dev_fd(struct vfio_device *dev)
+{
+	struct rte_mp_msg mp_req, *mp_rep;
+	struct rte_mp_reply mp_reply = {0};
+	struct timespec ts = {.tv_sec = 5, .tv_nsec = 0};
+	struct vfio_mp_param *p = (struct vfio_mp_param *)mp_req.param;
+	int device_fd = -1;
+
+	/* secondary process requests device fd from primary */
+	p->req = SOCKET_REQ_CDEV;
+	p->cdev_dev_num = dev->dev_num;
+	rte_strscpy(mp_req.name, EAL_VFIO_MP, sizeof(mp_req.name));
+	mp_req.len_param = sizeof(*p);
+	mp_req.num_fds = 0;
+
+	if (rte_mp_request_sync(&mp_req, &mp_reply, &ts) == 0 &&
+			mp_reply.nb_received == 1) {
+		mp_rep = &mp_reply.msgs[0];
+		p = (struct vfio_mp_param *)mp_rep->param;
+		if (p->result == SOCKET_OK && mp_rep->num_fds == 1)
+			device_fd = mp_rep->fds[0];
+	}
+
+	free(mp_reply.msgs);
+
+	if (device_fd < 0) {
+		EAL_LOG(ERR, "Cannot request device fd for vfio%d", dev->dev_num);
+		return -1;
+	}
+	dev->fd = device_fd;
+
+	return 0;
+}
+
+int
+vfio_cdev_setup_device(struct container *cfg, struct vfio_device *dev)
+{
+	int device_fd;
+
+	/* get device fd - primary or custom container opens it, secondary requests from primary */
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY || !vfio_container_is_default(cfg)) {
+		device_fd = cdev_open_device_fd(dev->dev_num);
+		if (device_fd < 0)
+			return -1;
+		dev->fd = device_fd;
+
+		/* attach device to iommufd - only in primary */
+		if (cdev_attach_device_to_iommufd(cfg, dev) < 0) {
+			close(device_fd);
+			dev->fd = -1;
+			return -1;
+		}
+	} else if (vfio_cdev_request_dev_fd(dev) < 0) {
+		return -1;
+	}
+	return 0;
+}
diff --git a/lib/eal/linux/eal_vfio_mp_sync.c b/lib/eal/linux/eal_vfio_mp_sync.c
index 9a07d35023..6d94f44af8 100644
--- a/lib/eal/linux/eal_vfio_mp_sync.c
+++ b/lib/eal/linux/eal_vfio_mp_sync.c
@@ -93,6 +93,48 @@ vfio_mp_primary(const struct rte_mp_msg *msg, const void *peer)
 		}
 		break;
 	}
+	case SOCKET_REQ_CDEV:
+	{
+		struct container *cfg;
+		struct vfio_device *dev;
+
+		if (vfio_cfg.mode != RTE_VFIO_MODE_CDEV) {
+			EAL_LOG(ERR, "VFIO not initialized in cdev mode");
+			r->result = SOCKET_ERR;
+			break;
+		}
+
+		r->req = SOCKET_REQ_CDEV;
+		r->cdev_dev_num = m->cdev_dev_num;
+
+		cfg = vfio_cfg.default_cfg;
+		dev = vfio_cdev_get_dev_by_num(cfg, m->cdev_dev_num);
+		if (dev == NULL) {
+			r->result = SOCKET_NO_FD;
+		} else {
+			r->result = SOCKET_OK;
+			reply.num_fds = 1;
+			reply.fds[0] = dev->fd;
+		}
+		break;
+	}
+	case SOCKET_REQ_IOAS_ID:
+	{
+		struct container *cfg;
+
+		if (vfio_cfg.mode != RTE_VFIO_MODE_CDEV) {
+			EAL_LOG(ERR, "VFIO not initialized in cdev mode");
+			r->result = SOCKET_ERR;
+			break;
+		}
+
+		r->req = SOCKET_REQ_IOAS_ID;
+		cfg = vfio_cfg.default_cfg;
+		r->ioas_id = cfg->cdev_cfg.ioas_id;
+
+		r->result = SOCKET_OK;
+		break;
+	}
 	default:
 		EAL_LOG(ERR, "vfio received invalid message!");
 		return -1;
diff --git a/lib/eal/linux/meson.build b/lib/eal/linux/meson.build
index 5ec8eddaa2..c164a30b49 100644
--- a/lib/eal/linux/meson.build
+++ b/lib/eal/linux/meson.build
@@ -16,6 +16,7 @@ sources += files(
         'eal_thread.c',
         'eal_timer.c',
         'eal_vfio.c',
+        'eal_vfio_cdev.c',
         'eal_vfio_group.c',
         'eal_vfio_mp_sync.c',
 )
-- 
2.52.0

