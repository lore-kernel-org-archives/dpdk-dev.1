Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085CCCA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 08:11:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A08F142E98;
	Wed,  7 Oct 2026 10:11:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 382C942E87
 for <dev@dpdk.org>; Wed,  7 Oct 2026 10:11:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791360673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Io8Y04jsjB0t4wZCsUPlEfZnxKwCn97b+rKmCisDyfE=;
 b=QrYd0iT5yG2BMGvHFRSusnEWXUrNY+c3dytKWcz7Vy+HwAG0/pX3AHiW4j5tu/i03k1kEc
 CltskGTQVob7CEHM+vs+oCf+Y284slHcLY2oZWohitS/4IfYk+XEBBpAJfYDv/xNo8r3s2
 iogEjLKMeO7dj731c/zsh4Vg+Xw9bR8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163--2Vn8ZxNMU-jDXrGIskDfg-1; Wed,
 7 Oct 2026 08:11:10 +0000
X-MC-Unique: -2Vn8ZxNMU-jDXrGIskDfg-1
X-Mimecast-MFC-AGG-ID: -2Vn8ZxNMU-jDXrGIskDfg_1791360668
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C38641954AE5; Wed,  7 Oct 2026 08:11:08 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE5B71956044; Wed,  7 Oct 2026 08:11:06 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [RESEND][PATCH v19 09/26] vfio: split get device info from setup
Date: Wed,  7 Oct 2026 10:10:06 +0200
Message-ID: <20261007081026.574382-10-david.marchand@redhat.com>
In-Reply-To: <20261007081026.574382-1-david.marchand@redhat.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <20261007081026.574382-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ztm8P9Hb604IFGB6RYKE8ux4ToxFt8s5V4nMqdD40F0_1791360668
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

From: Anatoly Burakov <anatoly.burakov@intel.com>

Currently, setup gets device info as part of setup, while the separate get
device info API also calls setup if the fd is zero. Untangle these two APIs
and make each do one thing, and adjust all existing callers.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/cdx/cdx_vfio.c        | 13 +++++++---
 drivers/bus/pci/linux/pci_vfio.c  | 20 +++++++++++-----
 drivers/bus/platform/platform.c   |  9 ++++++-
 drivers/crypto/bcmfs/bcmfs_vfio.c |  8 ++++++-
 lib/eal/linux/eal_vfio.c          | 40 ++++++++-----------------------
 lib/eal/linux/include/dev_vfio.h  | 24 +++++++------------
 6 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/drivers/bus/cdx/cdx_vfio.c b/drivers/bus/cdx/cdx_vfio.c
index ee47c67bf2..3a4b726a71 100644
--- a/drivers/bus/cdx/cdx_vfio.c
+++ b/drivers/bus/cdx/cdx_vfio.c
@@ -408,10 +408,14 @@ cdx_vfio_map_resource_primary(struct rte_cdx_device *dev)
 		return -1;
 
 	ret = dev_vfio_setup_device(RTE_CDX_BUS_DEVICES_PATH, dev_name,
-				    &vfio_dev_fd, &device_info);
+				    &vfio_dev_fd);
 	if (ret)
 		return ret;
 
+	ret = dev_vfio_get_device_info(vfio_dev_fd, &device_info);
+	if (ret)
+		goto err_vfio_dev_fd;
+
 	/* allocate vfio_res and get region info */
 	vfio_res = rte_zmalloc("VFIO_RES", sizeof(*vfio_res), 0);
 	if (vfio_res == NULL) {
@@ -516,11 +520,14 @@ cdx_vfio_map_resource_secondary(struct rte_cdx_device *dev)
 		return -1;
 	}
 
-	ret = dev_vfio_setup_device(RTE_CDX_BUS_DEVICES_PATH, dev_name,
-					&vfio_dev_fd, &device_info);
+	ret = dev_vfio_setup_device(RTE_CDX_BUS_DEVICES_PATH, dev_name, &vfio_dev_fd);
 	if (ret)
 		return ret;
 
+	ret = dev_vfio_get_device_info(vfio_dev_fd, &device_info);
+	if (ret)
+		goto err_vfio_dev_fd;
+
 	/* map MMIO regions */
 	maps = vfio_res->maps;
 
diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index 3b967d62c8..a4bb1475e8 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -752,11 +752,14 @@ pci_vfio_map_resource_primary(struct rte_pci_device *dev)
 	snprintf(pci_addr, sizeof(pci_addr), PCI_PRI_FMT,
 			loc->domain, loc->bus, loc->devid, loc->function);
 
-	ret = dev_vfio_setup_device(rte_pci_get_sysfs_path(), pci_addr,
-					&vfio_dev_fd, &device_info);
+	ret = dev_vfio_setup_device(rte_pci_get_sysfs_path(), pci_addr, &vfio_dev_fd);
 	if (ret)
 		return ret;
 
+	ret = dev_vfio_get_device_info(vfio_dev_fd, &device_info);
+	if (ret)
+		goto err_vfio_dev_fd;
+
 	if (rte_intr_dev_fd_set(dev->intr_handle, vfio_dev_fd))
 		goto err_vfio_dev_fd;
 
@@ -961,11 +964,14 @@ pci_vfio_map_resource_secondary(struct rte_pci_device *dev)
 		return -1;
 	}
 
-	ret = dev_vfio_setup_device(rte_pci_get_sysfs_path(), pci_addr,
-					&vfio_dev_fd, &device_info);
+	ret = dev_vfio_setup_device(rte_pci_get_sysfs_path(), pci_addr, &vfio_dev_fd);
 	if (ret)
 		return ret;
 
+	ret = dev_vfio_get_device_info(vfio_dev_fd, &device_info);
+	if (ret)
+		goto err_vfio_dev_fd;
+
 	ret = pci_vfio_fill_regions(dev, vfio_dev_fd, &device_info);
 	if (ret)
 		goto err_vfio_dev_fd;
@@ -1195,12 +1201,14 @@ pci_vfio_ioport_map(struct rte_pci_device *dev, int bar,
 		if (vfio_dev_fd < 0) {
 			return -1;
 		} else if (vfio_dev_fd == 0) {
-			if (dev_vfio_get_device_info(rte_pci_get_sysfs_path(), pci_addr,
-				&vfio_dev_fd, &device_info) != 0)
+			if (dev_vfio_setup_device(rte_pci_get_sysfs_path(), pci_addr,
+					&vfio_dev_fd) != 0)
 				return -1;
 			/* save vfio_dev_fd so it can be used during release */
 			if (rte_intr_dev_fd_set(dev->intr_handle, vfio_dev_fd) != 0)
 				return -1;
+			if (dev_vfio_get_device_info(vfio_dev_fd, &device_info) != 0)
+				return -1;
 
 			if (pci_vfio_fill_regions(dev, vfio_dev_fd, &device_info) != 0)
 				return -1;
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 9d7df9be80..950306e2d9 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -292,12 +292,19 @@ device_setup(struct rte_platform_device *pdev)
 	const char *name = pdev->name;
 	int ret;
 
-	ret = dev_vfio_setup_device(PLATFORM_BUS_DEVICES_PATH, name, &pdev->dev_fd, &dev_info);
+	ret = dev_vfio_setup_device(PLATFORM_BUS_DEVICES_PATH, name, &pdev->dev_fd);
 	if (ret) {
 		PLATFORM_LOG_LINE(ERR, "failed to setup %s", name);
 		return -ENODEV;
 	}
 
+	ret = dev_vfio_get_device_info(pdev->dev_fd, &dev_info);
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
index 053af0d227..ad244d9756 100644
--- a/drivers/crypto/bcmfs/bcmfs_vfio.c
+++ b/drivers/crypto/bcmfs/bcmfs_vfio.c
@@ -25,12 +25,18 @@ vfio_map_dev_obj(const char *path, const char *dev_obj,
 	struct vfio_device_info d_info = { .argsz = sizeof(d_info) };
 	struct vfio_region_info reg_info = { .argsz = sizeof(reg_info) };
 
-	ret = dev_vfio_setup_device(path, dev_obj, dev_fd, &d_info);
+	ret = dev_vfio_setup_device(path, dev_obj, dev_fd);
 	if (ret) {
 		BCMFS_LOG(ERR, "VFIO Setting for device failed");
 		return ret;
 	}
 
+	ret = dev_vfio_get_device_info(*dev_fd, &d_info);
+	if (ret) {
+		BCMFS_LOG(ERR, "VFIO Getting device info failed");
+		goto map_failed;
+	}
+
 	/* getting device region info*/
 	ret = ioctl(*dev_fd, VFIO_DEVICE_GET_REGION_INFO, &reg_info);
 	if (ret < 0) {
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 8461e47740..9148f2c156 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -810,8 +810,7 @@ dev_vfio_clear_group(int vfio_group_fd)
 
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_setup_device)
 int
-dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
-		int *vfio_dev_fd, struct vfio_device_info *device_info)
+dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_dev_fd)
 {
 	struct vfio_group_status group_status = {
 			.argsz = sizeof(group_status)
@@ -1031,7 +1030,7 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		*vfio_dev_fd = ioctl(vfio_group_fd, VFIO_GROUP_GET_DEVICE_FD,
 				     dev);
 		if (*vfio_dev_fd >= 0)
-			goto dev_get_info;
+			goto out;
 	}
 
 	/* get a file descriptor for the device */
@@ -1048,18 +1047,8 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
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
-		dev_vfio_clear_group(vfio_group_fd);
-		return -1;
-	}
+	/* device is now set up */
+out:
 	vfio_group_device_get(vfio_group_fd);
 
 	return 0;
@@ -1288,29 +1277,20 @@ vfio_set_iommu_type(int vfio_container_fd)
 
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_get_device_info)
 int
-dev_vfio_get_device_info(const char *sysfs_base, const char *dev_addr,
-		int *vfio_dev_fd, struct vfio_device_info *device_info)
+dev_vfio_get_device_info(int vfio_dev_fd, struct vfio_device_info *device_info)
 {
 	int ret;
 
 	if (!vfio_enabled)
 		return -1;
 
-	if (device_info == NULL || *vfio_dev_fd < 0)
+	if (device_info == NULL || vfio_dev_fd < 0)
 		return -1;
 
-	if (*vfio_dev_fd == 0) {
-		ret = dev_vfio_setup_device(sysfs_base, dev_addr,
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
+		EAL_LOG(ERR, "Cannot get device info, error %i (%s)", errno, strerror(errno));
+		return -1;
 	}
 
 	return 0;
diff --git a/lib/eal/linux/include/dev_vfio.h b/lib/eal/linux/include/dev_vfio.h
index 46ec508083..a0ca51f34c 100644
--- a/lib/eal/linux/include/dev_vfio.h
+++ b/lib/eal/linux/include/dev_vfio.h
@@ -59,10 +59,7 @@ enum dev_vfio_module {
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
@@ -70,8 +67,7 @@ enum dev_vfio_module {
  *   >1 if the device cannot be managed this way.
  */
 __rte_internal
-int dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
-		int *vfio_dev_fd, struct vfio_device_info *device_info);
+int dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_dev_fd);
 
 /**
  * @internal
@@ -189,26 +185,22 @@ dev_vfio_get_group_num(const char *sysfs_base, const char *dev_addr, int *iommu_
  * @internal
  * Get device information.
  *
- * @param sysfs_base
- *   sysfs path prefix.
- *
- * @param dev_addr
- *   device location.
+ * This function retrieves VFIO device information from an already opened
+ * device. The device must be opened with `dev_vfio_setup_device()` first.
  *
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
- *  <0 on failure.
+ *   <0 on failure.
  */
 __rte_internal
 int
-dev_vfio_get_device_info(const char *sysfs_base, const char *dev_addr,
-		int *vfio_dev_fd, struct vfio_device_info *device_info);
+dev_vfio_get_device_info(int vfio_dev_fd, struct vfio_device_info *device_info);
 
 /**
  * @internal
-- 
2.54.0

