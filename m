Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D70CEE33B
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 16:31:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B65CC40A79;
	Tue, 18 Nov 2025 17:30:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 9F120409FA
 for <dev@dpdk.org>; Tue, 18 Nov 2025 17:29:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763483399; x=1795019399;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=yq6cccAZIqqjaYWKiW++tiuEosXunqfekrGgWfic2jA=;
 b=WHB3NR8Ixriw15rzFTuZ+4dGvwKwk46BoTj17vb8GMII3v3H8jqlWLyV
 RKAP3CzN4j0N0vFMBn4sikbDudvfUCeZoVefj/0uOPYl3YHMhD0z7s3WU
 F4xHedJBWAZP6A3jarfUfUmOji88asJl/rqLURoqGv0lPfGLc5gNBZScl
 OVgG+H2YNZrehryuM17iRAFewEZ3VuXGndlS1/1ndxUHk0eeBXj7zPq2u
 21E6y7nxV3wTsrn9xwJpAwMVZULhG9sD2scIw0f+AArg7rLapc5xBtuZA
 xVTbzVORRgY2r6Q4iOjDd6B3cu1vyIjWAum5Mgf4FSibnTgWOH117b3GX Q==;
X-CSE-ConnectionGUID: 9N2rZsB/TFKmaZrw/VfFIw==
X-CSE-MsgGUID: s72VA9bVTByMMNHwgbEbuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65550674"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="65550674"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2025 08:29:58 -0800
X-CSE-ConnectionGUID: uufoMRq2TD+aoxYTYDwZLw==
X-CSE-MsgGUID: QVeUTGrRRoqbX5ld6wJ2lQ==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 18 Nov 2025 08:29:57 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v3 20/20] vfio: introduce cdev mode
Date: Tue, 18 Nov 2025 16:29:21 +0000
Message-ID: <7e49d0a3938ca536b188241cf6950a6bf901f1f0.1763483254.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763483253.git.anatoly.burakov@intel.com>
 <cover.1763483253.git.anatoly.burakov@intel.com>
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

To assist any future use of VFIO cdev mode for custom behavior, also
introduce "get device number" API, which is kind-of-but-not-really similar
to the concept of IOMMU group.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/freebsd/eal.c            |  10 +
 lib/eal/include/rte_vfio.h       |  31 +++
 lib/eal/linux/eal_vfio.c         | 210 +++++++++++++++++
 lib/eal/linux/eal_vfio.h         |  29 ++-
 lib/eal/linux/eal_vfio_cdev.c    | 389 +++++++++++++++++++++++++++++++
 lib/eal/linux/eal_vfio_mp_sync.c |  42 ++++
 lib/eal/linux/meson.build        |   1 +
 7 files changed, 710 insertions(+), 2 deletions(-)
 create mode 100644 lib/eal/linux/eal_vfio_cdev.c

diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index d850ef2c4f..c993d383bf 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -923,3 +923,13 @@ rte_vfio_get_mode(void)
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
index 2730cfa67d..385e09b5ba 100644
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
@@ -197,6 +201,33 @@ __rte_internal
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
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 2e9ad7dbb4..e1d1de494b 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -369,6 +369,20 @@ vfio_container_get_by_group_num(int group_num)
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
@@ -538,6 +552,55 @@ vfio_setup_dma_mem(struct container *cfg)
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
@@ -695,6 +758,49 @@ rte_vfio_container_assign_device(int container_fd, const char *sysfs_base, const
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
@@ -715,6 +821,9 @@ rte_vfio_container_assign_device(int container_fd, const char *sysfs_base, const
 	case RTE_VFIO_MODE_NOIOMMU:
 		res = vfio_group_assign_device(cfg, sysfs_base, dev_addr, &dev);
 		break;
+	case RTE_VFIO_MODE_CDEV:
+		res = vfio_cdev_assign_device(cfg, sysfs_base, dev_addr, &dev);
+		break;
 	default:
 		EAL_LOG(ERR, "Unsupported VFIO mode");
 		res = VFIO_NOT_SUPPORTED;
@@ -787,6 +896,24 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
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
@@ -906,6 +1033,12 @@ rte_vfio_release_device(const char *sysfs_base __rte_unused,
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
@@ -971,6 +1104,9 @@ vfio_select_mode(void)
 
 		if (vfio_sync_mode(cfg, &mode) < 0)
 			goto err;
+		/* if primary is in cdev mode, we need to sync ioas as well */
+		if (mode == RTE_VFIO_MODE_CDEV && vfio_cdev_sync_ioas(cfg) < 0)
+			goto err;
 
 		/* primary handles DMA setup for default containers */
 		group_cfg->dma_setup_done = true;
@@ -990,6 +1126,19 @@ vfio_select_mode(void)
 			return RTE_VFIO_MODE_NOIOMMU;
 		return RTE_VFIO_MODE_GROUP;
 	}
+	EAL_LOG(DEBUG, "VFIO group mode not available, trying cdev mode...");
+	/* try cdev mode */
+	if (vfio_cdev_enable(cfg) == 0) {
+		if (vfio_cdev_setup_ioas(cfg) < 0)
+			goto err_mpsync;
+		if (vfio_setup_dma_mem(cfg) < 0)
+			goto err_mpsync;
+		if (vfio_register_mem_event_callback() < 0)
+			goto err_mpsync;
+
+		return RTE_VFIO_MODE_CDEV;
+	}
+	EAL_LOG(DEBUG, "VFIO cdev mode not available");
 err_mpsync:
 	vfio_mp_sync_cleanup();
 err:
@@ -1004,6 +1153,7 @@ vfio_mode_to_str(enum rte_vfio_mode mode)
 	switch (mode) {
 	case RTE_VFIO_MODE_GROUP: return "group";
 	case RTE_VFIO_MODE_NOIOMMU: return "noiommu";
+	case RTE_VFIO_MODE_CDEV: return "cdev";
 	default: return "not initialized";
 	}
 }
@@ -1143,6 +1293,40 @@ rte_vfio_get_group_num(const char *sysfs_base, const char *dev_addr, int *iommu_
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
@@ -1342,6 +1526,25 @@ rte_vfio_container_create(void)
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
+		break;
+	}
 	default:
 		EAL_LOG(NOTICE, "Unsupported VFIO mode");
 		rte_errno = ENOTSUP;
@@ -1400,6 +1603,13 @@ rte_vfio_container_destroy(int container_fd)
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
index 68d3a3ec6e..52cb3a0e08 100644
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
 
@@ -61,12 +64,20 @@ struct vfio_group_config {
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
@@ -160,12 +171,24 @@ int vfio_group_setup_iommu(struct container *cfg);
 int vfio_group_setup_device_fd(const char *dev_addr,
 		struct vfio_group *grp, struct vfio_device *dev);
 
+/* cdev mode functions */
+int vfio_cdev_enable(struct container *cfg);
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
@@ -176,6 +199,8 @@ struct vfio_mp_param {
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
index 0000000000..d2d48faa8e
--- /dev/null
+++ b/lib/eal/linux/eal_vfio_cdev.c
@@ -0,0 +1,389 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2010-2025 Intel Corporation
+ */
+
+#include <dirent.h>
+#include <fcntl.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <limits.h>
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
+	/* cdev mode does not have different IOMMU ops */
+	vfio_cfg.ops = &iommufd_ops;
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
+		if (cdev_attach_device_to_iommufd(cfg, dev) < 0)
+			return -1;
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
index 75a9afdd03..adf043d24c 100644
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
2.47.3

