Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9740ACA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 08:12:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E067E42EC8;
	Wed,  7 Oct 2026 10:12:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 35BE742EB4
 for <dev@dpdk.org>; Wed,  7 Oct 2026 10:12:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791360723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mEQ3jxnWA++3A1CYyq9y/IIEbxqC+ctWx3F4SUDYOXc=;
 b=guMBJRJd6d5d/xRmQ68bZJTLIedBYd1RUEjA8D/WF1pZ0a8rJESVRhbXB7Pwv433Np2mZ9
 HWwyI1/G7HfF33VcXQGsz2J1whTWc4xZlL33657pikvMU24JWk2Rf2+Xgrp0Y6Pm75HXyl
 ox67x66jGqfLhq63aFcpWAMIK6RKtiI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-zYjYtv0qMwW8m-ExSPFb9w-1; Wed,
 7 Oct 2026 08:11:58 +0000
X-MC-Unique: zYjYtv0qMwW8m-ExSPFb9w-1
X-Mimecast-MFC-AGG-ID: zYjYtv0qMwW8m-ExSPFb9w_1791360716
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DB271800767; Wed,  7 Oct 2026 08:11:56 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C49DF1956044; Wed,  7 Oct 2026 08:11:52 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>,
 Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [RESEND][PATCH v19 22/26] vfio: decouple device setup from bus
 concerns
Date: Wed,  7 Oct 2026 10:10:19 +0200
Message-ID: <20261007081026.574382-23-david.marchand@redhat.com>
In-Reply-To: <20261007081026.574382-1-david.marchand@redhat.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <20261007081026.574382-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OJTddH_FTuC7s1WxUaBoXmSGpYe5IAp-jIRn1stT86k_1791360716
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

Change the return semantics of dev_vfio_setup_device and
dev_vfio_get_group_num to be more consistent with standard error
handling conventions.

Previously, these functions returned positive values (1 or >0) to
indicate that a device is not managed by VFIO. This convention was
inherited from PCI bus semantics where positive return means "skip
this device", but VFIO should not follow bus-specific conventions.

Now both functions return -1 with rte_errno set to ENODEV when the
device is not managed by VFIO. This makes error handling more
consistent and allows callers to distinguish between "not a VFIO
device" (ENODEV) and actual errors.

All driver call sites have been updated to check for rte_errno ==
ENODEV and convert it to the bus-specific "skip" return value (1)
where appropriate.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/cdx/cdx_vfio.c               | 13 ++++++++--
 drivers/bus/fslmc/fslmc_vfio.c           |  4 +--
 drivers/bus/pci/linux/pci_vfio.c         | 13 ++++++++--
 drivers/crypto/bcmfs/bcmfs_vfio.c        |  9 +++++--
 drivers/net/nbl/nbl_common/nbl_userdev.c |  2 +-
 lib/eal/linux/eal_vfio.c                 | 33 +++++++-----------------
 lib/eal/linux/include/dev_vfio.h         |  4 +--
 7 files changed, 43 insertions(+), 35 deletions(-)

diff --git a/drivers/bus/cdx/cdx_vfio.c b/drivers/bus/cdx/cdx_vfio.c
index 3a4b726a71..3c9f658ba7 100644
--- a/drivers/bus/cdx/cdx_vfio.c
+++ b/drivers/bus/cdx/cdx_vfio.c
@@ -22,6 +22,7 @@
 
 #include <eal_export.h>
 #include <rte_eal_paging.h>
+#include <rte_errno.h>
 #include <rte_malloc.h>
 #include <dev_vfio.h>
 
@@ -409,8 +410,12 @@ cdx_vfio_map_resource_primary(struct rte_cdx_device *dev)
 
 	ret = dev_vfio_setup_device(RTE_CDX_BUS_DEVICES_PATH, dev_name,
 				    &vfio_dev_fd);
-	if (ret)
+	if (ret < 0) {
+		/* Device not managed by VFIO - skip */
+		if (rte_errno == ENODEV)
+			ret = 1;
 		return ret;
+	}
 
 	ret = dev_vfio_get_device_info(vfio_dev_fd, &device_info);
 	if (ret)
@@ -521,8 +526,12 @@ cdx_vfio_map_resource_secondary(struct rte_cdx_device *dev)
 	}
 
 	ret = dev_vfio_setup_device(RTE_CDX_BUS_DEVICES_PATH, dev_name, &vfio_dev_fd);
-	if (ret)
+	if (ret < 0) {
+		/* Device not managed by VFIO - skip */
+		if (rte_errno == ENODEV)
+			ret = 1;
 		return ret;
+	}
 
 	ret = dev_vfio_get_device_info(vfio_dev_fd, &device_info);
 	if (ret)
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 153e6112db..c2b6ac1f3f 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -376,9 +376,9 @@ fslmc_get_group_id(const char *group_name,
 	/* get group number */
 	ret = dev_vfio_get_group_num(SYSFS_FSL_MC_DEVICES,
 			group_name, groupid);
-	if (ret <= 0) {
+	if (ret < 0) {
 		DPAA2_BUS_ERR("Find %s IOMMU group", group_name);
-		if (ret < 0)
+		if (rte_errno != ENODEV)
 			return ret;
 
 		return -EIO;
diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index a4bb1475e8..5af4302d62 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -20,6 +20,7 @@
 #include <rte_malloc.h>
 #include <dev_vfio.h>
 #include <rte_eal.h>
+#include <rte_errno.h>
 #include <bus_driver.h>
 #include <rte_spinlock.h>
 #include <rte_tailq.h>
@@ -753,8 +754,12 @@ pci_vfio_map_resource_primary(struct rte_pci_device *dev)
 			loc->domain, loc->bus, loc->devid, loc->function);
 
 	ret = dev_vfio_setup_device(rte_pci_get_sysfs_path(), pci_addr, &vfio_dev_fd);
-	if (ret)
+	if (ret < 0) {
+		/* Device not managed by VFIO - skip */
+		if (rte_errno == ENODEV)
+			ret = 1;
 		return ret;
+	}
 
 	ret = dev_vfio_get_device_info(vfio_dev_fd, &device_info);
 	if (ret)
@@ -965,8 +970,12 @@ pci_vfio_map_resource_secondary(struct rte_pci_device *dev)
 	}
 
 	ret = dev_vfio_setup_device(rte_pci_get_sysfs_path(), pci_addr, &vfio_dev_fd);
-	if (ret)
+	if (ret < 0) {
+		/* Device not managed by VFIO - skip */
+		if (rte_errno == ENODEV)
+			ret = 1;
 		return ret;
+	}
 
 	ret = dev_vfio_get_device_info(vfio_dev_fd, &device_info);
 	if (ret)
diff --git a/drivers/crypto/bcmfs/bcmfs_vfio.c b/drivers/crypto/bcmfs/bcmfs_vfio.c
index ad244d9756..92c8472953 100644
--- a/drivers/crypto/bcmfs/bcmfs_vfio.c
+++ b/drivers/crypto/bcmfs/bcmfs_vfio.c
@@ -9,6 +9,7 @@
 #include <sys/mman.h>
 #include <sys/ioctl.h>
 
+#include <rte_errno.h>
 #include <dev_vfio.h>
 
 #include "bcmfs_device.h"
@@ -26,8 +27,12 @@ vfio_map_dev_obj(const char *path, const char *dev_obj,
 	struct vfio_region_info reg_info = { .argsz = sizeof(reg_info) };
 
 	ret = dev_vfio_setup_device(path, dev_obj, dev_fd);
-	if (ret) {
-		BCMFS_LOG(ERR, "VFIO Setting for device failed");
+	if (ret < 0) {
+		/* Device not managed by VFIO - skip */
+		if (rte_errno == ENODEV)
+			ret = 1;
+		else
+			BCMFS_LOG(ERR, "VFIO Setting for device failed");
 		return ret;
 	}
 
diff --git a/drivers/net/nbl/nbl_common/nbl_userdev.c b/drivers/net/nbl/nbl_common/nbl_userdev.c
index 91b7c8006f..295c617d9d 100644
--- a/drivers/net/nbl/nbl_common/nbl_userdev.c
+++ b/drivers/net/nbl/nbl_common/nbl_userdev.c
@@ -430,7 +430,7 @@ static int nbl_mdev_map_device(struct nbl_adapter *adapter)
 		 "%s/%s/", rte_pci_get_sysfs_path(), dev_name);
 
 	ret = dev_vfio_get_group_num(pathname, dev_name, &common->iommu_group_num);
-	if (ret <= 0) {
+	if (ret < 0) {
 		NBL_LOG(ERR, "nbl vfio group number failed");
 		return -1;
 	}
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index d4a165464f..fe60c57fc5 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -33,6 +33,7 @@
  * rte_errno convention:
  *
  * - EINVAL: invalid parameters
+ * - ENODEV: device not managed by VFIO
  */
 
 /* per-process VFIO config */
@@ -771,14 +772,6 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_de
 
 	/* get group number */
 	ret = dev_vfio_get_group_num(sysfs_base, dev_addr, &iommu_group_num);
-	if (ret == 0) {
-		EAL_LOG(NOTICE,
-				"%s not managed by VFIO driver, skipping",
-				dev_addr);
-		return 1;
-	}
-
-	/* if negative, something failed */
 	if (ret < 0)
 		return -1;
 
@@ -792,10 +785,8 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_de
 	 * isn't managed by VFIO
 	 */
 	if (vfio_group_fd == -ENOENT) {
-		EAL_LOG(NOTICE,
-				"%s not managed by VFIO driver, skipping",
-				dev_addr);
-		return 1;
+		rte_errno = ENODEV;
+		return -1;
 	}
 
 	/*
@@ -1013,11 +1004,9 @@ dev_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 
 	/* get group number */
 	ret = dev_vfio_get_group_num(sysfs_base, dev_addr, &iommu_group_num);
-	if (ret <= 0) {
+	if (ret < 0) {
 		EAL_LOG(WARNING, "%s not managed by VFIO driver",
 			dev_addr);
-		/* This is an error at this point. */
-		ret = -1;
 		goto out;
 	}
 
@@ -1304,8 +1293,7 @@ dev_vfio_get_container_fd(void)
 
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_get_group_num)
 int
-dev_vfio_get_group_num(const char *sysfs_base,
-		const char *dev_addr, int *iommu_group_num)
+dev_vfio_get_group_num(const char *sysfs_base, const char *dev_addr, int *iommu_group_num)
 {
 	char linkname[PATH_MAX];
 	char filename[PATH_MAX];
@@ -1330,8 +1318,10 @@ dev_vfio_get_group_num(const char *sysfs_base,
 	ret = readlink(linkname, filename, sizeof(filename));
 
 	/* if the link doesn't exist, no VFIO for us */
-	if (ret < 0)
-		return 0;
+	if (ret < 0) {
+		rte_errno = ENODEV;
+		return -1;
+	}
 
 	ret = rte_strsplit(filename, sizeof(filename),
 			tok, RTE_DIM(tok), '/');
@@ -1351,7 +1341,7 @@ dev_vfio_get_group_num(const char *sysfs_base,
 		return -1;
 	}
 
-	return 1;
+	return 0;
 }
 
 static int
@@ -1645,9 +1635,6 @@ dev_vfio_container_assign_device(int vfio_container_fd, const char *sysfs_base,
 	if (ret < 0) {
 		EAL_LOG(ERR, "Cannot get IOMMU group number for device %s", dev_addr);
 		return -1;
-	} else if (ret == 0) {
-		EAL_LOG(ERR, "Device %s is not assigned to any IOMMU group", dev_addr);
-		return -1;
 	}
 
 	ret = vfio_container_group_bind(vfio_container_fd, iommu_group_num);
diff --git a/lib/eal/linux/include/dev_vfio.h b/lib/eal/linux/include/dev_vfio.h
index b3bf1ed7eb..4e2c21ae89 100644
--- a/lib/eal/linux/include/dev_vfio.h
+++ b/lib/eal/linux/include/dev_vfio.h
@@ -62,7 +62,6 @@ enum dev_vfio_module {
  *
  * @return
  *   0 on success.
- *   >1 if the device cannot be managed this way.
  *   <0 on failure, rte_errno is set.
  *
  * Possible rte_errno values include:
@@ -159,8 +158,7 @@ int dev_vfio_noiommu_is_enabled(void);
  *   Pointer to where IOMMU group number will be stored.
  *
  * @return
- *  >0 on success
- *   0 for non-existent group or VFIO
+ *   0 on success.
  *   <0 on failure, rte_errno is set.
  *
  * Possible rte_errno values include:
-- 
2.54.0

