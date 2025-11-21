Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE8ECFA76A
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 10:09:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4099940609;
	Fri, 21 Nov 2025 11:09:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 140A6402E5
 for <dev@dpdk.org>; Fri, 21 Nov 2025 11:09:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763719756; x=1795255756;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ILeX4tUABEIYdCyZ2zNzwCLhu4qTU91seLgX8EEd7Ek=;
 b=BSY3Fl2GtTKPVmBhfauXV5OH057n19XW40ydtUb4DhHd0x83IyhY34/h
 DZ43a+Q2axSsHI/pUxghikuR0HxeIXOeZPdoAuz29rDn5WdXlIWr3DLud
 5PUxkMXVRK4mpfIHUB7+sJfpvZXnB8Hd1LAvmI1g35aVTV4ZHJM47qTHt
 UqYL6+BPXoyeA2Wsf1S/BYyyeRmZL22G7Omve3OG1iTgR9/MtmUcNCRvE
 rbmLTLEPKWwozeOCu9d/lvIDTEbBs1vwamWOn3/AF1Q3/pQQPR0mqPVDT
 R2NVtB+e8zajQDeX5m773c2g6vK90YbTIGv514/osid/m4c+r+l8rl9YL g==;
X-CSE-ConnectionGUID: oWfIUO41Sly1s19nVEchGw==
X-CSE-MsgGUID: WKyIZRw2TxapiW3l2PnOxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="76490976"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; d="scan'208";a="76490976"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 02:09:15 -0800
X-CSE-ConnectionGUID: JSrme5SHRCCdQ3QaLaYeTg==
X-CSE-MsgGUID: k1JH4Av9QeeLEbnl3z+pTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; d="scan'208";a="196121555"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 21 Nov 2025 02:09:13 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>, Chenbo Xia <chenbox@nvidia.com>,
 Tomasz Duszynski <tduszynski@marvell.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 03/18] vfio: split get device info from setup
Date: Fri, 21 Nov 2025 10:08:48 +0000
Message-ID: <98035d5c8afa653dee9dd5881711211355eedc8f.1763719706.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763719706.git.anatoly.burakov@intel.com>
 <cover.1763719706.git.anatoly.burakov@intel.com>
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

Currently, setup gets device info as part of setup, while the separate get
device info API also calls setup if the fd is zero. Untangle these two APIs
and make each do one thing, and adjust all existing callers.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/cdx/cdx_vfio.c        | 12 ++++++++--
 drivers/bus/pci/linux/pci_vfio.c  | 18 ++++++++++----
 drivers/bus/platform/platform.c   |  9 ++++++-
 drivers/crypto/bcmfs/bcmfs_vfio.c |  8 ++++++-
 lib/eal/freebsd/eal.c             |  3 +--
 lib/eal/include/rte_vfio.h        | 23 +++++++-----------
 lib/eal/linux/eal_vfio.c          | 40 +++++++++----------------------
 7 files changed, 59 insertions(+), 54 deletions(-)

diff --git a/drivers/bus/cdx/cdx_vfio.c b/drivers/bus/cdx/cdx_vfio.c
index 11fe3265d2..9bae264409 100644
--- a/drivers/bus/cdx/cdx_vfio.c
+++ b/drivers/bus/cdx/cdx_vfio.c
@@ -401,10 +401,14 @@ cdx_vfio_map_resource_primary(struct rte_cdx_device *dev)
 		return -1;
 
 	ret = rte_vfio_setup_device(RTE_CDX_BUS_DEVICES_PATH, dev_name,
-				    &vfio_dev_fd, &device_info);
+				    &vfio_dev_fd);
 	if (ret)
 		return ret;
 
+	ret = rte_vfio_get_device_info(vfio_dev_fd, &device_info);
+	if (ret)
+		goto err_vfio_dev_fd;
+
 	/* allocate vfio_res and get region info */
 	vfio_res = rte_zmalloc("VFIO_RES", sizeof(*vfio_res), 0);
 	if (vfio_res == NULL) {
@@ -510,10 +514,14 @@ cdx_vfio_map_resource_secondary(struct rte_cdx_device *dev)
 	}
 
 	ret = rte_vfio_setup_device(RTE_CDX_BUS_DEVICES_PATH, dev_name,
-					&vfio_dev_fd, &device_info);
+					&vfio_dev_fd);
 	if (ret)
 		return ret;
 
+	ret = rte_vfio_get_device_info(vfio_dev_fd, &device_info);
+	if (ret)
+		goto err_vfio_dev_fd;
+
 	/* map MMIO regions */
 	maps = vfio_res->maps;
 
diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index 8562fdcc6b..57ec9d7066 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -753,10 +753,14 @@ pci_vfio_map_resource_primary(struct rte_pci_device *dev)
 			loc->domain, loc->bus, loc->devid, loc->function);
 
 	ret = rte_vfio_setup_device(rte_pci_get_sysfs_path(), pci_addr,
-					&vfio_dev_fd, &device_info);
+					&vfio_dev_fd);
 	if (ret)
 		return ret;
 
+	ret = rte_vfio_get_device_info(vfio_dev_fd, &device_info);
+	if (ret)
+		goto err_vfio_dev_fd;
+
 	if (rte_intr_dev_fd_set(dev->intr_handle, vfio_dev_fd))
 		goto err_vfio_dev_fd;
 
@@ -962,10 +966,14 @@ pci_vfio_map_resource_secondary(struct rte_pci_device *dev)
 	}
 
 	ret = rte_vfio_setup_device(rte_pci_get_sysfs_path(), pci_addr,
-					&vfio_dev_fd, &device_info);
+					&vfio_dev_fd);
 	if (ret)
 		return ret;
 
+	ret = rte_vfio_get_device_info(vfio_dev_fd, &device_info);
+	if (ret)
+		goto err_vfio_dev_fd;
+
 	ret = pci_vfio_fill_regions(dev, vfio_dev_fd, &device_info);
 	if (ret)
 		goto err_vfio_dev_fd;
@@ -1194,12 +1202,14 @@ pci_vfio_ioport_map(struct rte_pci_device *dev, int bar,
 		if (vfio_dev_fd < 0) {
 			return -1;
 		} else if (vfio_dev_fd == 0) {
-			if (rte_vfio_get_device_info(rte_pci_get_sysfs_path(), pci_addr,
-				&vfio_dev_fd, &device_info) != 0)
+			if (rte_vfio_setup_device(rte_pci_get_sysfs_path(), pci_addr,
+				&vfio_dev_fd) != 0)
 				return -1;
 			/* save vfio_dev_fd so it can be used during release */
 			if (rte_intr_dev_fd_set(dev->intr_handle, vfio_dev_fd) != 0)
 				return -1;
+			if (rte_vfio_get_device_info(vfio_dev_fd, &device_info) != 0)
+				return -1;
 
 			if (pci_vfio_fill_regions(dev, vfio_dev_fd, &device_info) != 0)
 				return -1;
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index f6673cf181..9500b8aff5 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -328,12 +328,19 @@ device_setup(struct rte_platform_device *pdev)
 	const char *name = pdev->name;
 	int ret;
 
-	ret = rte_vfio_setup_device(PLATFORM_BUS_DEVICES_PATH, name, &pdev->dev_fd, &dev_info);
+	ret = rte_vfio_setup_device(PLATFORM_BUS_DEVICES_PATH, name, &pdev->dev_fd);
 	if (ret) {
 		PLATFORM_LOG_LINE(ERR, "failed to setup %s", name);
 		return -ENODEV;
 	}
 
+	ret = rte_vfio_get_device_info(pdev->dev_fd, &dev_info);
+	if (ret) {
+		PLATFORM_LOG_LINE(ERR, "failed to get device info for %s", name);
+		ret = -ENODEV;
+		goto out;
+	}
+
 	/* This is an extra check to confirm that platform device was initialized
 	 * by a kernel vfio-platform driver. On kernels that predate vfio-platform
 	 * driver this flag obviously does not exist. In such scenarios this
diff --git a/drivers/crypto/bcmfs/bcmfs_vfio.c b/drivers/crypto/bcmfs/bcmfs_vfio.c
index e7f7ed994c..d00aaf1bb7 100644
--- a/drivers/crypto/bcmfs/bcmfs_vfio.c
+++ b/drivers/crypto/bcmfs/bcmfs_vfio.c
@@ -25,12 +25,18 @@ vfio_map_dev_obj(const char *path, const char *dev_obj,
 	struct vfio_device_info d_info = { .argsz = sizeof(d_info) };
 	struct vfio_region_info reg_info = { .argsz = sizeof(reg_info) };
 
-	ret = rte_vfio_setup_device(path, dev_obj, dev_fd, &d_info);
+	ret = rte_vfio_setup_device(path, dev_obj, dev_fd);
 	if (ret) {
 		BCMFS_LOG(ERR, "VFIO Setting for device failed");
 		return ret;
 	}
 
+	ret = rte_vfio_get_device_info(*dev_fd, &d_info);
+	if (ret) {
+		BCMFS_LOG(ERR, "VFIO Getting device info failed");
+		goto map_failed;
+	}
+
 	/* getting device region info*/
 	ret = ioctl(*dev_fd, VFIO_DEVICE_GET_REGION_INFO, &reg_info);
 	if (ret < 0) {
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 3142ccd4bd..dea32ae428 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -814,8 +814,7 @@ rte_eal_vfio_get_vf_token(__rte_unused rte_uuid_t vf_token)
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_setup_device)
 int rte_vfio_setup_device(__rte_unused const char *sysfs_base,
 		      __rte_unused const char *dev_addr,
-		      __rte_unused int *vfio_dev_fd,
-		      __rte_unused struct vfio_device_info *device_info)
+		      __rte_unused int *vfio_dev_fd)
 {
 	rte_errno = ENOTSUP;
 	return -1;
diff --git a/lib/eal/include/rte_vfio.h b/lib/eal/include/rte_vfio.h
index 0ddeb08f94..fb666141f6 100644
--- a/lib/eal/include/rte_vfio.h
+++ b/lib/eal/include/rte_vfio.h
@@ -55,10 +55,7 @@ struct vfio_device_info;
  *   device location.
  *
  * @param vfio_dev_fd
- *   VFIO fd.
- *
- * @param device_info
- *   Device information.
+ *   Pointer to VFIO fd, will be set to the opened device fd on success.
  *
  * @return
  *   0 on success.
@@ -67,7 +64,7 @@ struct vfio_device_info;
  */
 __rte_internal
 int rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
-		int *vfio_dev_fd, struct vfio_device_info *device_info);
+		int *vfio_dev_fd);
 
 /**
  * @internal
@@ -187,19 +184,16 @@ rte_vfio_get_group_num(const char *sysfs_base,
  * @internal
  * Get device information.
  *
+ * This function retrieves VFIO device information from an already opened
+ * device. The device must be opened with rte_vfio_setup_device() first.
+ *
  * This function is only relevant to Linux and will return an error on BSD.
  *
- * @param sysfs_base
- *   sysfs path prefix.
- *
- * @param dev_addr
- *   device location.
- *
  * @param vfio_dev_fd
- *   VFIO fd.
+ *   VFIO device fd (must be a valid, already opened fd).
  *
  * @param device_info
- *   Device information.
+ *   Pointer to device information structure to be filled.
  *
  * @return
  *   0 on success.
@@ -207,8 +201,7 @@ rte_vfio_get_group_num(const char *sysfs_base,
  */
 __rte_internal
 int
-rte_vfio_get_device_info(const char *sysfs_base, const char *dev_addr,
-		int *vfio_dev_fd, struct vfio_device_info *device_info);
+rte_vfio_get_device_info(int vfio_dev_fd, struct vfio_device_info *device_info);
 
 /**
  * @internal
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 33fa04feaf..47c973e49a 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -758,7 +758,7 @@ rte_vfio_clear_group(int vfio_group_fd)
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_setup_device)
 int
 rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
-		int *vfio_dev_fd, struct vfio_device_info *device_info)
+		int *vfio_dev_fd)
 {
 	struct vfio_group_status group_status = {
 			.argsz = sizeof(group_status)
@@ -975,7 +975,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		*vfio_dev_fd = ioctl(vfio_group_fd, VFIO_GROUP_GET_DEVICE_FD,
 				     dev);
 		if (*vfio_dev_fd >= 0)
-			goto dev_get_info;
+			goto out;
 	}
 
 	/* get a file descriptor for the device */
@@ -992,18 +992,8 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		return -1;
 	}
 
-	/* test and setup the device */
-dev_get_info:
-	ret = ioctl(*vfio_dev_fd, VFIO_DEVICE_GET_INFO, device_info);
-	if (ret) {
-		EAL_LOG(ERR, "%s cannot get device info, "
-				"error %i (%s)", dev_addr, errno,
-				strerror(errno));
-		close(*vfio_dev_fd);
-		close(vfio_group_fd);
-		rte_vfio_clear_group(vfio_group_fd);
-		return -1;
-	}
+	/* device is now set up */
+out:
 	vfio_group_device_get(vfio_group_fd);
 
 	return 0;
@@ -1217,26 +1207,18 @@ vfio_set_iommu_type(int vfio_container_fd)
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_device_info)
 int
-rte_vfio_get_device_info(const char *sysfs_base, const char *dev_addr,
-		int *vfio_dev_fd, struct vfio_device_info *device_info)
+rte_vfio_get_device_info(int vfio_dev_fd, struct vfio_device_info *device_info)
 {
 	int ret;
 
-	if (device_info == NULL || *vfio_dev_fd < 0)
+	if (device_info == NULL || vfio_dev_fd < 0)
 		return -1;
 
-	if (*vfio_dev_fd == 0) {
-		ret = rte_vfio_setup_device(sysfs_base, dev_addr,
-				vfio_dev_fd, device_info);
-		if (ret)
-			return -1;
-	} else {
-		ret = ioctl(*vfio_dev_fd, VFIO_DEVICE_GET_INFO, device_info);
-		if (ret) {
-			EAL_LOG(ERR, "%s cannot get device info, error %i (%s)",
-					dev_addr, errno, strerror(errno));
-			return -1;
-		}
+	ret = ioctl(vfio_dev_fd, VFIO_DEVICE_GET_INFO, device_info);
+	if (ret) {
+		EAL_LOG(ERR, "Cannot get device info, error %i (%s)",
+				errno, strerror(errno));
+		return -1;
 	}
 
 	return 0;
-- 
2.47.3

