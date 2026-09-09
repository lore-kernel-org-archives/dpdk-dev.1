Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3980DC79FAD
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 10:03:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3102141148;
	Wed,  9 Sep 2026 12:02:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 8657741149
 for <dev@dpdk.org>; Wed,  9 Sep 2026 12:02:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788948164; x=1820484164;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=GXJIumiS2QAzwsdV13Cat95Bk1pHMXSu4q6AiTi0u/g=;
 b=hqo/1lLUVLg93MTxRyGFjKQyiOCl3OVJqIv/Fm/vpH04Hw3MxBD0duma
 PYJCdjzyfmTTUrAdAOVXaROv9MO5nKDBAdfr/sb2mUUSskexY3OBkQ4L7
 +dBWwqw/PeUOG8QC9aJ5oH35Npwrns2s61uukFaVXfNA4xEJ6f9A9PFXN
 VoB7h+TGFGHh7UwZeblGw9Bru4dJdhwagI14orkZc1vqzPBeVOx0AE+9D
 6eA53jnelyQle1zf3SyTLbcdhU0uls8iMB39Z87TWzvTuyG+7aUgEJn4g
 4G9U4oOjMAxJvVaE63iKj//tOjmh9Iz+N+Sj4BYu+2hMc2SdPEk8Bit8E w==;
X-CSE-ConnectionGUID: t14YYogtQZ2rfm2e6Gld9g==
X-CSE-MsgGUID: tQ3YpN/gReeGycw9K/DAFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89492215"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="89492215"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 03:02:43 -0700
X-CSE-ConnectionGUID: zf78INeGRjOkQVTrc3qf6Q==
X-CSE-MsgGUID: 8Z4l9GJ6TbKAR8dJG0YY3A==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 09 Sep 2026 03:02:38 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>,
 Tomasz Duszynski <tduszynski@marvell.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>,
 Feifei Wang <wangfeifei40@huawei.com>,
 Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>,
 Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>,
 Chaoyong He <chaoyong.he@corigine.com>,
 Vijay Kumar Srivastava <vsrivast@xilinx.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v16 08/26] vfio: rename API to reflect internal status
Date: Wed,  9 Sep 2026 11:02:01 +0100
Message-ID: <739f5fadfd43f9b0fca14ae0f5e8eb201d19bb01.1788947937.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1788947937.git.anatoly.burakov@intel.com>
 <cover.1788947937.git.anatoly.burakov@intel.com>
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

Currently, even though VFIO API is internal-only, it is still named with an
`rte_` prefix, which implies public API. To reflect the fact that this API
is no longer public, rename all symbols and macros from `rte_`/`RTE_` to
`dev_`/`DEV_`, and adjust all callers.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 doc/guides/rel_notes/release_26_11.rst     |   4 +-
 drivers/bus/cdx/cdx.c                      |   6 +-
 drivers/bus/cdx/cdx_vfio.c                 |  14 +--
 drivers/bus/fslmc/fslmc_bus.c              |   4 +-
 drivers/bus/fslmc/fslmc_vfio.c             |  12 +-
 drivers/bus/pci/linux/pci.c                |   4 +-
 drivers/bus/pci/linux/pci_vfio.c           |  38 +++----
 drivers/bus/pci/pci_common.c               |  10 +-
 drivers/bus/platform/platform.c            |  10 +-
 drivers/crypto/bcmfs/bcmfs_vfio.c          |   8 +-
 drivers/net/hinic3/base/hinic3_hwdev.c     |   4 +-
 drivers/net/nbl/nbl_common/nbl_userdev.c   |  16 +--
 drivers/net/ntnic/ntnic_ethdev.c           |  10 +-
 drivers/net/ntnic/ntnic_vfio.c             |  22 ++--
 drivers/vdpa/ifc/ifcvf_vdpa.c              |  24 ++--
 drivers/vdpa/nfp/nfp_vdpa.c                |  24 ++--
 drivers/vdpa/sfc/sfc_vdpa.c                |  16 +--
 drivers/vdpa/sfc/sfc_vdpa_hw.c             |  12 +-
 lib/eal/freebsd/eal.c                      |  73 ++++++------
 lib/eal/include/{rte_vfio.h => dev_vfio.h} |  58 +++++-----
 lib/eal/include/meson.build                |   2 +-
 lib/eal/linux/eal.c                        |   6 +-
 lib/eal/linux/eal_vfio.c                   | 122 ++++++++++-----------
 lib/eal/linux/eal_vfio_mp_sync.c           |   6 +-
 lib/eal/windows/eal.c                      |  14 +--
 lib/vhost/vhost_user.c                     |  16 +--
 26 files changed, 271 insertions(+), 264 deletions(-)
 rename lib/eal/include/{rte_vfio.h => dev_vfio.h} (82%)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index b5793b5c94..71d12a4398 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -94,8 +94,8 @@ API Changes
    =======================================================
 
 * vfio: The entire VFIO API (``rte_vfio_*``) was made internal.
-  These functions are now available only to EAL and drivers,
-  and are no longer part of the public API.
+  These functions were renamed to ``dev_vfio_*``, are now available
+  only to EAL and drivers, and are no longer part of public API.
 
 
 ABI Changes
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index c0b46a41ad..ee8f24e67e 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -73,7 +73,7 @@
 #include <rte_devargs.h>
 #include <rte_kvargs.h>
 #include <rte_malloc.h>
-#include <rte_vfio.h>
+#include <dev_vfio.h>
 
 #include <eal_export.h>
 #include <eal_filesystem.h>
@@ -403,7 +403,7 @@ cdx_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 {
 	RTE_SET_USED(dev);
 
-	return rte_vfio_container_dma_map(RTE_VFIO_DEFAULT_CONTAINER_FD,
+	return dev_vfio_container_dma_map(DEV_VFIO_DEFAULT_CONTAINER_FD,
 					  (uintptr_t)addr, iova, len);
 }
 
@@ -412,7 +412,7 @@ cdx_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 {
 	RTE_SET_USED(dev);
 
-	return rte_vfio_container_dma_unmap(RTE_VFIO_DEFAULT_CONTAINER_FD,
+	return dev_vfio_container_dma_unmap(DEV_VFIO_DEFAULT_CONTAINER_FD,
 					    (uintptr_t)addr, iova, len);
 }
 
diff --git a/drivers/bus/cdx/cdx_vfio.c b/drivers/bus/cdx/cdx_vfio.c
index 11fe3265d2..02a34d6f18 100644
--- a/drivers/bus/cdx/cdx_vfio.c
+++ b/drivers/bus/cdx/cdx_vfio.c
@@ -23,7 +23,7 @@
 #include <eal_export.h>
 #include <rte_eal_paging.h>
 #include <rte_malloc.h>
-#include <rte_vfio.h>
+#include <dev_vfio.h>
 
 #include "bus_cdx_driver.h"
 #include "cdx_logs.h"
@@ -121,7 +121,7 @@ cdx_vfio_unmap_resource_primary(struct rte_cdx_device *dev)
 	if (vfio_dev_fd < 0)
 		return -1;
 
-	ret = rte_vfio_release_device(RTE_CDX_BUS_DEVICES_PATH, dev->device.name,
+	ret = dev_vfio_release_device(RTE_CDX_BUS_DEVICES_PATH, dev->device.name,
 				      vfio_dev_fd);
 	if (ret < 0) {
 		CDX_BUS_ERR("Cannot release VFIO device");
@@ -155,7 +155,7 @@ cdx_vfio_unmap_resource_secondary(struct rte_cdx_device *dev)
 	if (vfio_dev_fd < 0)
 		return -1;
 
-	ret = rte_vfio_release_device(RTE_CDX_BUS_DEVICES_PATH, dev->device.name,
+	ret = dev_vfio_release_device(RTE_CDX_BUS_DEVICES_PATH, dev->device.name,
 				      vfio_dev_fd);
 	if (ret < 0) {
 		CDX_BUS_ERR("Cannot release VFIO device");
@@ -400,7 +400,7 @@ cdx_vfio_map_resource_primary(struct rte_cdx_device *dev)
 	if (rte_intr_fd_set(dev->intr_handle, -1))
 		return -1;
 
-	ret = rte_vfio_setup_device(RTE_CDX_BUS_DEVICES_PATH, dev_name,
+	ret = dev_vfio_setup_device(RTE_CDX_BUS_DEVICES_PATH, dev_name,
 				    &vfio_dev_fd, &device_info);
 	if (ret)
 		return ret;
@@ -477,7 +477,7 @@ cdx_vfio_map_resource_primary(struct rte_cdx_device *dev)
 	cdx_vfio_find_and_unmap_resource(vfio_res_list, dev);
 	rte_free(vfio_res);
 err_vfio_dev_fd:
-	rte_vfio_release_device(RTE_CDX_BUS_DEVICES_PATH, dev_name, vfio_dev_fd);
+	dev_vfio_release_device(RTE_CDX_BUS_DEVICES_PATH, dev_name, vfio_dev_fd);
 	return -1;
 }
 
@@ -509,7 +509,7 @@ cdx_vfio_map_resource_secondary(struct rte_cdx_device *dev)
 		return -1;
 	}
 
-	ret = rte_vfio_setup_device(RTE_CDX_BUS_DEVICES_PATH, dev_name,
+	ret = dev_vfio_setup_device(RTE_CDX_BUS_DEVICES_PATH, dev_name,
 					&vfio_dev_fd, &device_info);
 	if (ret)
 		return ret;
@@ -535,7 +535,7 @@ cdx_vfio_map_resource_secondary(struct rte_cdx_device *dev)
 
 	return 0;
 err_vfio_dev_fd:
-	rte_vfio_release_device(RTE_CDX_BUS_DEVICES_PATH, dev_name, vfio_dev_fd);
+	dev_vfio_release_device(RTE_CDX_BUS_DEVICES_PATH, dev_name, vfio_dev_fd);
 	return -1;
 }
 
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 3626b12316..d55c414ead 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -17,7 +17,7 @@
 #include <rte_memcpy.h>
 #include <ethdev_driver.h>
 #include <rte_mbuf_dyn.h>
-#include <rte_vfio.h>
+#include <dev_vfio.h>
 
 #include "private.h"
 #include <fslmc_vfio.h>
@@ -500,7 +500,7 @@ rte_dpaa2_get_iommu_class(void)
 		return RTE_IOVA_DC;
 
 	/* check if all devices on the bus support Virtual addressing or not */
-	if (fslmc_all_device_support_iova() != 0 && rte_vfio_noiommu_is_enabled() == 0)
+	if (fslmc_all_device_support_iova() != 0 && dev_vfio_noiommu_is_enabled() == 0)
 		return RTE_IOVA_VA;
 
 	return RTE_IOVA_PA;
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 8d39895bac..153e6112db 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -34,7 +34,7 @@
 #include <rte_kvargs.h>
 #include <dev_driver.h>
 #include <rte_eal_memconfig.h>
-#include <rte_vfio.h>
+#include <dev_vfio.h>
 
 #include "private.h"
 #include "fslmc_vfio.h"
@@ -204,7 +204,7 @@ fslmc_vfio_add_group(int vfio_group_fd,
 	group->fd = vfio_group_fd;
 	group->groupid = iommu_group_num;
 	rte_strscpy(group->group_name, group_name, sizeof(group->group_name));
-	if (rte_vfio_noiommu_is_enabled() > 0)
+	if (dev_vfio_noiommu_is_enabled() > 0)
 		group->iommu_type = VFIO_NOIOMMU_IOMMU;
 	else
 		group->iommu_type = VFIO_TYPE1_IOMMU;
@@ -374,7 +374,7 @@ fslmc_get_group_id(const char *group_name,
 	int ret;
 
 	/* get group number */
-	ret = rte_vfio_get_group_num(SYSFS_FSL_MC_DEVICES,
+	ret = dev_vfio_get_group_num(SYSFS_FSL_MC_DEVICES,
 			group_name, groupid);
 	if (ret <= 0) {
 		DPAA2_BUS_ERR("Find %s IOMMU group", group_name);
@@ -411,7 +411,7 @@ fslmc_vfio_open_group_fd(const char *group_name)
 	/* if primary, try to open the group */
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		/* try regular group format */
-		snprintf(filename, sizeof(filename), RTE_VFIO_GROUP_FMT, iommu_group_num);
+		snprintf(filename, sizeof(filename), DEV_VFIO_GROUP_FMT, iommu_group_num);
 		vfio_group_fd = open(filename, O_RDWR);
 
 		goto add_vfio_group;
@@ -509,10 +509,10 @@ fslmc_vfio_open_container_fd(void)
 
 	/* if we're in a primary process, try to open the container */
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
-		vfio_container_fd = open(RTE_VFIO_CONTAINER_PATH, O_RDWR);
+		vfio_container_fd = open(DEV_VFIO_CONTAINER_PATH, O_RDWR);
 		if (vfio_container_fd < 0) {
 			DPAA2_BUS_ERR("Open VFIO container(%s), err(%d)",
-				RTE_VFIO_CONTAINER_PATH, vfio_container_fd);
+				DEV_VFIO_CONTAINER_PATH, vfio_container_fd);
 			ret = vfio_container_fd;
 			goto err_exit;
 		}
diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index 9aae0a5d14..af37a65c45 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -11,7 +11,7 @@
 #include <rte_malloc.h>
 #include <rte_devargs.h>
 #include <rte_memcpy.h>
-#include <rte_vfio.h>
+#include <dev_vfio.h>
 
 #include <eal_export.h>
 #include "eal_filesystem.h"
@@ -596,7 +596,7 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv,
 		static int is_vfio_noiommu_enabled = -1;
 
 		if (is_vfio_noiommu_enabled == -1) {
-			if (rte_vfio_noiommu_is_enabled() == 1)
+			if (dev_vfio_noiommu_is_enabled() == 1)
 				is_vfio_noiommu_enabled = 1;
 			else
 				is_vfio_noiommu_enabled = 0;
diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index f3791cce98..71afc383e6 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -18,7 +18,7 @@
 #include <rte_bus_pci.h>
 #include <rte_eal_paging.h>
 #include <rte_malloc.h>
-#include <rte_vfio.h>
+#include <dev_vfio.h>
 #include <rte_eal.h>
 #include <bus_driver.h>
 #include <rte_spinlock.h>
@@ -29,10 +29,10 @@
 #include "pci_init.h"
 #include "private.h"
 
-static struct rte_tailq_elem rte_vfio_tailq = {
+static struct rte_tailq_elem dev_vfio_tailq = {
 	.name = "VFIO_RESOURCE_LIST",
 };
-EAL_REGISTER_TAILQ(rte_vfio_tailq)
+EAL_REGISTER_TAILQ(dev_vfio_tailq)
 
 static int
 pci_vfio_get_region(const struct rte_pci_device *dev, int index,
@@ -418,7 +418,7 @@ pci_vfio_is_ioport_bar(const struct rte_pci_device *dev, int vfio_dev_fd,
 }
 
 static int
-pci_rte_vfio_setup_device(struct rte_pci_device *dev, int vfio_dev_fd)
+pci_vfio_setup_device(struct rte_pci_device *dev, int vfio_dev_fd)
 {
 	if (pci_vfio_setup_interrupts(dev, vfio_dev_fd) != 0) {
 		PCI_LOG(ERR, "Error setting up interrupts!");
@@ -738,7 +738,7 @@ pci_vfio_map_resource_primary(struct rte_pci_device *dev)
 	int i, j, ret;
 	struct mapped_pci_resource *vfio_res = NULL;
 	struct mapped_pci_res_list *vfio_res_list =
-		RTE_TAILQ_CAST(rte_vfio_tailq.head, mapped_pci_res_list);
+		RTE_TAILQ_CAST(dev_vfio_tailq.head, mapped_pci_res_list);
 
 	struct pci_map *maps;
 
@@ -752,7 +752,7 @@ pci_vfio_map_resource_primary(struct rte_pci_device *dev)
 	snprintf(pci_addr, sizeof(pci_addr), PCI_PRI_FMT,
 			loc->domain, loc->bus, loc->devid, loc->function);
 
-	ret = rte_vfio_setup_device(rte_pci_get_sysfs_path(), pci_addr,
+	ret = dev_vfio_setup_device(rte_pci_get_sysfs_path(), pci_addr,
 					&vfio_dev_fd, &device_info);
 	if (ret)
 		return ret;
@@ -897,7 +897,7 @@ pci_vfio_map_resource_primary(struct rte_pci_device *dev)
 		free(reg);
 	}
 
-	if (pci_rte_vfio_setup_device(dev, vfio_dev_fd) < 0) {
+	if (pci_vfio_setup_device(dev, vfio_dev_fd) < 0) {
 		PCI_LOG(ERR, "%s setup device failed", pci_addr);
 		goto err_map;
 	}
@@ -920,7 +920,7 @@ pci_vfio_map_resource_primary(struct rte_pci_device *dev)
 err_vfio_res:
 	rte_free(vfio_res);
 err_vfio_dev_fd:
-	rte_vfio_release_device(rte_pci_get_sysfs_path(),
+	dev_vfio_release_device(rte_pci_get_sysfs_path(),
 			pci_addr, vfio_dev_fd);
 	return -1;
 }
@@ -935,7 +935,7 @@ pci_vfio_map_resource_secondary(struct rte_pci_device *dev)
 	int j, ret, i = 0;
 	struct mapped_pci_resource *vfio_res = NULL;
 	struct mapped_pci_res_list *vfio_res_list =
-		RTE_TAILQ_CAST(rte_vfio_tailq.head, mapped_pci_res_list);
+		RTE_TAILQ_CAST(dev_vfio_tailq.head, mapped_pci_res_list);
 
 	struct pci_map *maps;
 
@@ -961,7 +961,7 @@ pci_vfio_map_resource_secondary(struct rte_pci_device *dev)
 		return -1;
 	}
 
-	ret = rte_vfio_setup_device(rte_pci_get_sysfs_path(), pci_addr,
+	ret = dev_vfio_setup_device(rte_pci_get_sysfs_path(), pci_addr,
 					&vfio_dev_fd, &device_info);
 	if (ret)
 		return ret;
@@ -1006,7 +1006,7 @@ pci_vfio_map_resource_secondary(struct rte_pci_device *dev)
 			pci_unmap_resource(maps[j].addr, maps[j].size);
 	}
 err_vfio_dev:
-	rte_vfio_release_device(rte_pci_get_sysfs_path(),
+	dev_vfio_release_device(rte_pci_get_sysfs_path(),
 			pci_addr, vfio_dev_fd);
 	return -1;
 }
@@ -1101,7 +1101,7 @@ pci_vfio_unmap_resource_primary(struct rte_pci_device *dev)
 		return -1;
 	}
 
-	ret = rte_vfio_release_device(rte_pci_get_sysfs_path(), pci_addr,
+	ret = dev_vfio_release_device(rte_pci_get_sysfs_path(), pci_addr,
 				      vfio_dev_fd);
 	if (ret < 0) {
 		PCI_LOG(ERR, "Cannot release VFIO device");
@@ -1109,7 +1109,7 @@ pci_vfio_unmap_resource_primary(struct rte_pci_device *dev)
 	}
 
 	vfio_res_list =
-		RTE_TAILQ_CAST(rte_vfio_tailq.head, mapped_pci_res_list);
+		RTE_TAILQ_CAST(dev_vfio_tailq.head, mapped_pci_res_list);
 	vfio_res = find_and_unmap_vfio_resource(vfio_res_list, dev, pci_addr);
 
 	/* if we haven't found our tailq entry, something's wrong */
@@ -1140,7 +1140,7 @@ pci_vfio_unmap_resource_secondary(struct rte_pci_device *dev)
 	if (vfio_dev_fd < 0)
 		return -1;
 
-	ret = rte_vfio_release_device(rte_pci_get_sysfs_path(), pci_addr,
+	ret = dev_vfio_release_device(rte_pci_get_sysfs_path(), pci_addr,
 				      vfio_dev_fd);
 	if (ret < 0) {
 		PCI_LOG(ERR, "Cannot release VFIO device");
@@ -1148,7 +1148,7 @@ pci_vfio_unmap_resource_secondary(struct rte_pci_device *dev)
 	}
 
 	vfio_res_list =
-		RTE_TAILQ_CAST(rte_vfio_tailq.head, mapped_pci_res_list);
+		RTE_TAILQ_CAST(dev_vfio_tailq.head, mapped_pci_res_list);
 	vfio_res = find_and_unmap_vfio_resource(vfio_res_list, dev, pci_addr);
 
 	/* if we haven't found our tailq entry, something's wrong */
@@ -1195,7 +1195,7 @@ pci_vfio_ioport_map(struct rte_pci_device *dev, int bar,
 		if (vfio_dev_fd < 0) {
 			return -1;
 		} else if (vfio_dev_fd == 0) {
-			if (rte_vfio_get_device_info(rte_pci_get_sysfs_path(), pci_addr,
+			if (dev_vfio_get_device_info(rte_pci_get_sysfs_path(), pci_addr,
 				&vfio_dev_fd, &device_info) != 0)
 				return -1;
 			/* save vfio_dev_fd so it can be used during release */
@@ -1300,11 +1300,11 @@ pci_vfio_mmio_write(const struct rte_pci_device *dev, int bar,
 int
 pci_vfio_is_enabled(void)
 {
-	int status = rte_vfio_is_enabled("vfio_pci");
+	int status = dev_vfio_is_enabled("vfio_pci");
 
 	if (!status) {
-		rte_vfio_enable();
-		status = rte_vfio_is_enabled("vfio_pci");
+		dev_vfio_enable();
+		status = dev_vfio_is_enabled("vfio_pci");
 	}
 	return status;
 }
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index dc8db80d3b..fcc4495b92 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -25,7 +25,7 @@
 #include <rte_string_fns.h>
 #include <rte_common.h>
 #include <rte_devargs.h>
-#include <rte_vfio.h>
+#include <dev_vfio.h>
 #include <rte_tailq.h>
 
 #include "private.h"
@@ -487,8 +487,8 @@ pci_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 	 *  try fallback to VFIO.
 	 */
 	if (pdev->kdrv == RTE_PCI_KDRV_VFIO)
-		return rte_vfio_container_dma_map
-				(RTE_VFIO_DEFAULT_CONTAINER_FD, (uintptr_t)addr,
+		return dev_vfio_container_dma_map
+				(DEV_VFIO_DEFAULT_CONTAINER_FD, (uintptr_t)addr,
 				 iova, len);
 	rte_errno = ENOTSUP;
 	return -1;
@@ -507,8 +507,8 @@ pci_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 	 *  try fallback to VFIO.
 	 */
 	if (pdev->kdrv == RTE_PCI_KDRV_VFIO)
-		return rte_vfio_container_dma_unmap
-				(RTE_VFIO_DEFAULT_CONTAINER_FD, (uintptr_t)addr,
+		return dev_vfio_container_dma_unmap
+				(DEV_VFIO_DEFAULT_CONTAINER_FD, (uintptr_t)addr,
 				 iova, len);
 	rte_errno = ENOTSUP;
 	return -1;
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 90d865a8df..9d7df9be80 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -23,7 +23,7 @@
 #include <rte_log.h>
 #include <rte_memory.h>
 #include <rte_string_fns.h>
-#include <rte_vfio.h>
+#include <dev_vfio.h>
 
 #include "private.h"
 
@@ -282,7 +282,7 @@ static void
 device_cleanup(struct rte_platform_device *pdev)
 {
 	device_unmap_resources(pdev);
-	rte_vfio_release_device(PLATFORM_BUS_DEVICES_PATH, pdev->name, pdev->dev_fd);
+	dev_vfio_release_device(PLATFORM_BUS_DEVICES_PATH, pdev->name, pdev->dev_fd);
 }
 
 static int
@@ -292,7 +292,7 @@ device_setup(struct rte_platform_device *pdev)
 	const char *name = pdev->name;
 	int ret;
 
-	ret = rte_vfio_setup_device(PLATFORM_BUS_DEVICES_PATH, name, &pdev->dev_fd, &dev_info);
+	ret = dev_vfio_setup_device(PLATFORM_BUS_DEVICES_PATH, name, &pdev->dev_fd, &dev_info);
 	if (ret) {
 		PLATFORM_LOG_LINE(ERR, "failed to setup %s", name);
 		return -ENODEV;
@@ -458,7 +458,7 @@ platform_bus_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t l
 	if (pdrv->dma_map != NULL)
 		return pdrv->dma_map(pdev, addr, iova, len);
 
-	return rte_vfio_container_dma_map(RTE_VFIO_DEFAULT_CONTAINER_FD, (uint64_t)addr, iova, len);
+	return dev_vfio_container_dma_map(DEV_VFIO_DEFAULT_CONTAINER_FD, (uint64_t)addr, iova, len);
 }
 
 static int
@@ -470,7 +470,7 @@ platform_bus_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t
 	if (pdrv->dma_unmap != NULL)
 		return pdrv->dma_unmap(pdev, addr, iova, len);
 
-	return rte_vfio_container_dma_unmap(RTE_VFIO_DEFAULT_CONTAINER_FD, (uint64_t)addr, iova,
+	return dev_vfio_container_dma_unmap(DEV_VFIO_DEFAULT_CONTAINER_FD, (uint64_t)addr, iova,
 					    len);
 }
 
diff --git a/drivers/crypto/bcmfs/bcmfs_vfio.c b/drivers/crypto/bcmfs/bcmfs_vfio.c
index e7f7ed994c..053af0d227 100644
--- a/drivers/crypto/bcmfs/bcmfs_vfio.c
+++ b/drivers/crypto/bcmfs/bcmfs_vfio.c
@@ -9,7 +9,7 @@
 #include <sys/mman.h>
 #include <sys/ioctl.h>
 
-#include <rte_vfio.h>
+#include <dev_vfio.h>
 
 #include "bcmfs_device.h"
 #include "bcmfs_logs.h"
@@ -25,7 +25,7 @@ vfio_map_dev_obj(const char *path, const char *dev_obj,
 	struct vfio_device_info d_info = { .argsz = sizeof(d_info) };
 	struct vfio_region_info reg_info = { .argsz = sizeof(reg_info) };
 
-	ret = rte_vfio_setup_device(path, dev_obj, dev_fd, &d_info);
+	ret = dev_vfio_setup_device(path, dev_obj, dev_fd, &d_info);
 	if (ret) {
 		BCMFS_LOG(ERR, "VFIO Setting for device failed");
 		return ret;
@@ -51,7 +51,7 @@ vfio_map_dev_obj(const char *path, const char *dev_obj,
 	return 0;
 
 map_failed:
-	rte_vfio_release_device(path, dev_obj, *dev_fd);
+	dev_vfio_release_device(path, dev_obj, *dev_fd);
 
 	return ret;
 }
@@ -87,7 +87,7 @@ bcmfs_release_vfio(struct bcmfs_device *dev)
 	/* unmap the addr */
 	munmap(dev->mmap_addr, dev->mmap_size);
 	/* release the device */
-	ret = rte_vfio_release_device(dev->dirname, dev->name,
+	ret = dev_vfio_release_device(dev->dirname, dev->name,
 				      dev->vfio_dev_fd);
 	if (ret < 0) {
 		BCMFS_LOG(ERR, "cannot release device");
diff --git a/drivers/net/hinic3/base/hinic3_hwdev.c b/drivers/net/hinic3/base/hinic3_hwdev.c
index d09a8f7e7d..6a6cf44752 100644
--- a/drivers/net/hinic3/base/hinic3_hwdev.c
+++ b/drivers/net/hinic3/base/hinic3_hwdev.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2025 Huawei Technologies Co., Ltd
  */
 
-#include <rte_vfio.h>
+#include <dev_vfio.h>
 
 #include "hinic3_compat.h"
 #include "hinic3_cmd.h"
@@ -78,7 +78,7 @@ hinic3_is_vfio_iommu_enable(const struct rte_eth_dev *eth_dev)
 {
 	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 
-	return pci_dev->kdrv == RTE_PCI_KDRV_VFIO && rte_vfio_noiommu_is_enabled() != 1;
+	return pci_dev->kdrv == RTE_PCI_KDRV_VFIO && dev_vfio_noiommu_is_enabled() != 1;
 }
 
 int
diff --git a/drivers/net/nbl/nbl_common/nbl_userdev.c b/drivers/net/nbl/nbl_common/nbl_userdev.c
index ec6840d60e..f1522772f5 100644
--- a/drivers/net/nbl/nbl_common/nbl_userdev.c
+++ b/drivers/net/nbl/nbl_common/nbl_userdev.c
@@ -4,7 +4,7 @@
 
 #include "nbl_userdev.h"
 #include <uapi/linux/vfio.h>
-#include <rte_vfio.h>
+#include <dev_vfio.h>
 
 #define NBL_USERDEV_EVENT_CLB_NAME	"nbl_userspace_mem_event_clb"
 #define NBL_USERDEV_BAR0_SIZE		65536
@@ -405,7 +405,7 @@ static int nbl_mdev_map_device(struct nbl_adapter *adapter)
 	snprintf(pathname, sizeof(pathname),
 		 "%s/%s/", rte_pci_get_sysfs_path(), dev_name);
 
-	ret = rte_vfio_get_group_num(pathname, dev_name, &common->iommu_group_num);
+	ret = dev_vfio_get_group_num(pathname, dev_name, &common->iommu_group_num);
 	if (ret <= 0) {
 		NBL_LOG(ERR, "nbl vfio group number failed");
 		return -1;
@@ -414,7 +414,7 @@ static int nbl_mdev_map_device(struct nbl_adapter *adapter)
 	NBL_LOG(DEBUG, "nbl vfio group number %d", common->iommu_group_num);
 	/* vfio_container */
 	if (nbl_default_container < 0) {
-		container = rte_vfio_container_create();
+		container = dev_vfio_container_create();
 		container_create = 1;
 
 		if (container < 0) {
@@ -424,7 +424,7 @@ static int nbl_mdev_map_device(struct nbl_adapter *adapter)
 	}
 
 	NBL_LOG(DEBUG, "nbl vfio container %d", container);
-	vfio_group_fd = rte_vfio_container_group_bind(container, common->iommu_group_num);
+	vfio_group_fd = dev_vfio_container_group_bind(container, common->iommu_group_num);
 	if (vfio_group_fd < 0) {
 		NBL_LOG(ERR, "nbl vfio group bind failed, %d", vfio_group_fd);
 		goto free_container;
@@ -535,10 +535,10 @@ static int nbl_mdev_map_device(struct nbl_adapter *adapter)
 	}
 free_group:
 	close(vfio_group_fd);
-	rte_vfio_clear_group(vfio_group_fd);
+	dev_vfio_clear_group(vfio_group_fd);
 free_container:
 	if (container_create)
-		rte_vfio_container_destroy(container);
+		dev_vfio_container_destroy(container);
 	return -1;
 }
 
@@ -550,7 +550,7 @@ static int nbl_mdev_unmap_device(struct nbl_adapter *adapter)
 	rte_mcfg_mem_read_lock();
 	TAILQ_REMOVE(&nbl_adapter_list, adapter, next);
 	close(common->devfd);
-	vfio_group_fd = rte_vfio_container_group_bind(nbl_default_container,
+	vfio_group_fd = dev_vfio_container_group_bind(nbl_default_container,
 						      common->iommu_group_num);
 	NBL_LOG(DEBUG, "close vfio_group_fd %d", vfio_group_fd);
 	ret = ioctl(vfio_group_fd, VFIO_GROUP_UNSET_CONTAINER, &nbl_default_container);
@@ -558,7 +558,7 @@ static int nbl_mdev_unmap_device(struct nbl_adapter *adapter)
 		NBL_LOG(ERR, "unset container, error %i (%s) %d",
 			errno, strerror(errno), ret);
 	nbl_group_count--;
-	ret = rte_vfio_container_group_unbind(nbl_default_container, common->iommu_group_num);
+	ret = dev_vfio_container_group_unbind(nbl_default_container, common->iommu_group_num);
 	if (ret)
 		NBL_LOG(ERR, "vfio container group unbind failed %d", ret);
 	if (!nbl_group_count) {
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 7cc90a7a5b..d9744a7d05 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -7,7 +7,7 @@
 
 #include <rte_eal.h>
 #include <rte_dev.h>
-#include <rte_vfio.h>
+#include <dev_vfio.h>
 #include <rte_ethdev.h>
 #include <rte_bus_pci.h>
 #include <ethdev_pci.h>
@@ -2690,12 +2690,12 @@ nthw_pci_probe(struct rte_pci_driver *pci_drv, struct rte_pci_device *pci_dev)
 			(pci_dev->device.devargs->data ? pci_dev->device.devargs->data : "NULL"));
 	}
 
-	const int n_rte_vfio_no_io_mmu_enabled = rte_vfio_noiommu_is_enabled();
-	NT_LOG(DBG, NTNIC, "vfio_no_iommu_enabled=%d", n_rte_vfio_no_io_mmu_enabled);
+	const int n_dev_vfio_no_io_mmu_enabled = dev_vfio_noiommu_is_enabled();
+	NT_LOG(DBG, NTNIC, "vfio_no_iommu_enabled=%d", n_dev_vfio_no_io_mmu_enabled);
 
-	if (n_rte_vfio_no_io_mmu_enabled) {
+	if (n_dev_vfio_no_io_mmu_enabled) {
 		NT_LOG(ERR, NTNIC, "vfio_no_iommu_enabled=%d: this PMD needs VFIO IOMMU",
-			n_rte_vfio_no_io_mmu_enabled);
+			n_dev_vfio_no_io_mmu_enabled);
 		return -1;
 	}
 
diff --git a/drivers/net/ntnic/ntnic_vfio.c b/drivers/net/ntnic/ntnic_vfio.c
index 439468b3a2..8489a59859 100644
--- a/drivers/net/ntnic/ntnic_vfio.c
+++ b/drivers/net/ntnic/ntnic_vfio.c
@@ -6,7 +6,7 @@
 
 #include <rte_malloc.h>
 #include <rte_memory.h>
-#include <rte_vfio.h>
+#include <dev_vfio.h>
 #include <rte_dev.h>
 #include <rte_bus_pci.h>
 #include <rte_spinlock.h>
@@ -70,16 +70,16 @@ nthw_vfio_setup(struct rte_pci_device *dev)
 	vfio->iova_addr = START_VF_IOVA;
 
 	rte_pci_device_name(&dev->addr, devname, RTE_DEV_NAME_MAX_LEN);
-	ret = rte_vfio_get_group_num(rte_pci_get_sysfs_path(), devname, &iommu_group_num);
+	ret = dev_vfio_get_group_num(rte_pci_get_sysfs_path(), devname, &iommu_group_num);
 	if (ret <= 0)
 		return -1;
 
 	if (vf_num == 0) {
 		/* use default container for pf0 */
-		vfio->container_fd = RTE_VFIO_DEFAULT_CONTAINER_FD;
+		vfio->container_fd = DEV_VFIO_DEFAULT_CONTAINER_FD;
 
 	} else {
-		vfio->container_fd = rte_vfio_container_create();
+		vfio->container_fd = dev_vfio_container_create();
 
 		if (vfio->container_fd < 0) {
 			NT_LOG(ERR, NTNIC,
@@ -88,7 +88,7 @@ nthw_vfio_setup(struct rte_pci_device *dev)
 		}
 	}
 
-	vfio->group_fd = rte_vfio_container_group_bind(vfio->container_fd, iommu_group_num);
+	vfio->group_fd = dev_vfio_container_group_bind(vfio->container_fd, iommu_group_num);
 
 	if (vfio->group_fd < 0) {
 		NT_LOG(ERR, NTNIC,
@@ -115,8 +115,8 @@ nthw_vfio_setup(struct rte_pci_device *dev)
 
 err:
 
-	if (vfio->container_fd != RTE_VFIO_DEFAULT_CONTAINER_FD)
-		rte_vfio_container_destroy(vfio->container_fd);
+	if (vfio->container_fd != DEV_VFIO_DEFAULT_CONTAINER_FD)
+		dev_vfio_container_destroy(vfio->container_fd);
 
 	return -1;
 }
@@ -135,7 +135,7 @@ nthw_vfio_remove(int vf_num)
 		return -1;
 	}
 
-	rte_vfio_container_destroy(vfio->container_fd);
+	dev_vfio_container_destroy(vfio->container_fd);
 	return 0;
 }
 
@@ -169,14 +169,14 @@ nthw_vfio_dma_map(int vf_num, void *virt_addr, uint64_t *iova_addr, uint64_t siz
 		vf_num, virt_addr, rte_malloc_virt2iova(virt_addr), gp_virt_base, vfio->iova_addr,
 		size);
 
-	int res = rte_vfio_container_dma_map(vfio->container_fd, gp_virt_base, vfio->iova_addr,
+	int res = dev_vfio_container_dma_map(vfio->container_fd, gp_virt_base, vfio->iova_addr,
 			size);
 
 	NT_LOG(DBG, NTNIC, "VFIO MMAP res %i, container_fd %i, vf_num %i", res,
 		vfio->container_fd, vf_num);
 
 	if (res) {
-		NT_LOG(ERR, NTNIC, "rte_vfio_container_dma_map failed: res %d", res);
+		NT_LOG(ERR, NTNIC, "dev_vfio_container_dma_map failed: res %d", res);
 		return -1;
 	}
 
@@ -210,7 +210,7 @@ nthw_vfio_dma_unmap(int vf_num, void *virt_addr, uint64_t iova_addr, uint64_t si
 		return -1;
 	}
 
-	int res = rte_vfio_container_dma_unmap(vfio->container_fd, gp_virt_base, iova_addr, size);
+	int res = dev_vfio_container_dma_unmap(vfio->container_fd, gp_virt_base, iova_addr, size);
 
 	if (res != 0) {
 		NT_LOG(ERR, NTNIC,
diff --git a/drivers/vdpa/ifc/ifcvf_vdpa.c b/drivers/vdpa/ifc/ifcvf_vdpa.c
index f319d455ba..36d06f1e3f 100644
--- a/drivers/vdpa/ifc/ifcvf_vdpa.c
+++ b/drivers/vdpa/ifc/ifcvf_vdpa.c
@@ -20,7 +20,7 @@
 #include <rte_vhost.h>
 #include <rte_vdpa.h>
 #include <vdpa_driver.h>
-#include <rte_vfio.h>
+#include <dev_vfio.h>
 #include <rte_spinlock.h>
 #include <rte_log.h>
 #include <rte_kvargs.h>
@@ -182,18 +182,18 @@ ifcvf_vfio_setup(struct ifcvf_internal *internal)
 	internal->vfio_container_fd = -1;
 
 	rte_pci_device_name(&dev->addr, devname, RTE_DEV_NAME_MAX_LEN);
-	ret = rte_vfio_get_group_num(rte_pci_get_sysfs_path(), devname,
+	ret = dev_vfio_get_group_num(rte_pci_get_sysfs_path(), devname,
 			&iommu_group_num);
 	if (ret <= 0) {
 		DRV_LOG(ERR, "%s failed to get IOMMU group", devname);
 		return -1;
 	}
 
-	internal->vfio_container_fd = rte_vfio_container_create();
+	internal->vfio_container_fd = dev_vfio_container_create();
 	if (internal->vfio_container_fd < 0)
 		return -1;
 
-	internal->vfio_group_fd = rte_vfio_container_group_bind(
+	internal->vfio_group_fd = dev_vfio_container_group_bind(
 			internal->vfio_container_fd, iommu_group_num);
 	if (internal->vfio_group_fd < 0)
 		goto err;
@@ -216,7 +216,7 @@ ifcvf_vfio_setup(struct ifcvf_internal *internal)
 	return 0;
 
 err:
-	rte_vfio_container_destroy(internal->vfio_container_fd);
+	dev_vfio_container_destroy(internal->vfio_container_fd);
 	return -1;
 }
 
@@ -246,7 +246,7 @@ ifcvf_dma_map(struct ifcvf_internal *internal, bool do_map)
 			reg->host_user_addr, reg->guest_phys_addr, reg->size);
 
 		if (do_map) {
-			ret = rte_vfio_container_dma_map(vfio_container_fd,
+			ret = dev_vfio_container_dma_map(vfio_container_fd,
 				reg->host_user_addr, reg->guest_phys_addr,
 				reg->size);
 			if (ret < 0) {
@@ -254,7 +254,7 @@ ifcvf_dma_map(struct ifcvf_internal *internal, bool do_map)
 				goto exit;
 			}
 		} else {
-			ret = rte_vfio_container_dma_unmap(vfio_container_fd,
+			ret = dev_vfio_container_dma_unmap(vfio_container_fd,
 				reg->host_user_addr, reg->guest_phys_addr,
 				reg->size);
 			if (ret < 0) {
@@ -388,7 +388,7 @@ vdpa_ifcvf_stop(struct ifcvf_internal *internal)
 	if (RTE_VHOST_NEED_LOG(features)) {
 		ifcvf_disable_logging(hw);
 		rte_vhost_get_log_base(internal->vid, &log_base, &log_size);
-		rte_vfio_container_dma_unmap(internal->vfio_container_fd,
+		dev_vfio_container_dma_unmap(internal->vfio_container_fd,
 				log_base, IFCVF_LOG_BASE, log_size);
 		/*
 		 * IFCVF marks dirty memory pages for only packet buffer,
@@ -791,7 +791,7 @@ m_ifcvf_start(struct ifcvf_internal *internal)
 		vring_init(&internal->m_vring[i], vq.size, vring_buf,
 				rte_mem_page_size());
 
-		ret = rte_vfio_container_dma_map(internal->vfio_container_fd,
+		ret = dev_vfio_container_dma_map(internal->vfio_container_fd,
 			(uint64_t)(uintptr_t)vring_buf, m_vring_iova, size);
 		if (ret < 0) {
 			DRV_LOG(ERR, "mediated vring DMA map failed.");
@@ -900,7 +900,7 @@ m_ifcvf_stop(struct ifcvf_internal *internal)
 
 		size = RTE_ALIGN_CEIL(vring_size(vq.size, rte_mem_page_size()),
 				rte_mem_page_size());
-		rte_vfio_container_dma_unmap(internal->vfio_container_fd,
+		dev_vfio_container_dma_unmap(internal->vfio_container_fd,
 			(uint64_t)(uintptr_t)internal->m_vring[i].desc,
 			m_vring_iova, size);
 
@@ -1205,7 +1205,7 @@ ifcvf_set_features(int vid)
 		ifcvf_sw_fallback_switchover(internal);
 	} else {
 		rte_vhost_get_log_base(vid, &log_base, &log_size);
-		rte_vfio_container_dma_map(internal->vfio_container_fd,
+		dev_vfio_container_dma_map(internal->vfio_container_fd,
 				log_base, IFCVF_LOG_BASE, log_size);
 		ifcvf_enable_logging(&internal->hw, IFCVF_LOG_BASE, log_size);
 	}
@@ -1824,7 +1824,7 @@ ifcvf_pci_remove(struct rte_pci_device *pci_dev)
 		DRV_LOG(ERR, "failed to update datapath %s", pci_dev->name);
 
 	rte_pci_unmap_device(internal->pdev);
-	rte_vfio_container_destroy(internal->vfio_container_fd);
+	dev_vfio_container_destroy(internal->vfio_container_fd);
 	rte_vdpa_unregister_device(internal->vdev);
 
 	pthread_mutex_lock(&internal_list_lock);
diff --git a/drivers/vdpa/nfp/nfp_vdpa.c b/drivers/vdpa/nfp/nfp_vdpa.c
index 4c0ab3ff30..94740e768d 100644
--- a/drivers/vdpa/nfp/nfp_vdpa.c
+++ b/drivers/vdpa/nfp/nfp_vdpa.c
@@ -12,7 +12,7 @@
 
 #include <nfp_common_pci.h>
 #include <nfp_dev.h>
-#include <rte_vfio.h>
+#include <dev_vfio.h>
 #include <rte_eal_paging.h>
 #include <rte_malloc.h>
 #include <vdpa_driver.h>
@@ -120,16 +120,16 @@ nfp_vdpa_vfio_setup(struct nfp_vdpa_dev *device)
 	struct rte_pci_device *pci_dev = device->pci_dev;
 
 	rte_pci_device_name(&pci_dev->addr, dev_name, RTE_DEV_NAME_MAX_LEN);
-	ret = rte_vfio_get_group_num(rte_pci_get_sysfs_path(), dev_name,
+	ret = dev_vfio_get_group_num(rte_pci_get_sysfs_path(), dev_name,
 			&device->iommu_group);
 	if (ret <= 0)
 		return -1;
 
-	device->vfio_container_fd = rte_vfio_container_create();
+	device->vfio_container_fd = dev_vfio_container_create();
 	if (device->vfio_container_fd < 0)
 		return -1;
 
-	device->vfio_group_fd = rte_vfio_container_group_bind(
+	device->vfio_group_fd = dev_vfio_container_group_bind(
 			device->vfio_container_fd, device->iommu_group);
 	if (device->vfio_group_fd < 0)
 		goto container_destroy;
@@ -146,9 +146,9 @@ nfp_vdpa_vfio_setup(struct nfp_vdpa_dev *device)
 	return 0;
 
 group_unbind:
-	rte_vfio_container_group_unbind(device->vfio_container_fd, device->iommu_group);
+	dev_vfio_container_group_unbind(device->vfio_container_fd, device->iommu_group);
 container_destroy:
-	rte_vfio_container_destroy(device->vfio_container_fd);
+	dev_vfio_container_destroy(device->vfio_container_fd);
 
 	return -1;
 }
@@ -157,8 +157,8 @@ static void
 nfp_vdpa_vfio_teardown(struct nfp_vdpa_dev *device)
 {
 	rte_pci_unmap_device(device->pci_dev);
-	rte_vfio_container_group_unbind(device->vfio_container_fd, device->iommu_group);
-	rte_vfio_container_destroy(device->vfio_container_fd);
+	dev_vfio_container_group_unbind(device->vfio_container_fd, device->iommu_group);
+	dev_vfio_container_destroy(device->vfio_container_fd);
 }
 
 static int
@@ -173,7 +173,7 @@ nfp_vdpa_dma_do_unmap(struct rte_vhost_memory *mem,
 	for (i = 0; i < times; i++) {
 		region = &mem->regions[i];
 
-		ret = rte_vfio_container_dma_unmap(vfio_container_fd,
+		ret = dev_vfio_container_dma_unmap(vfio_container_fd,
 				region->host_user_addr, region->guest_phys_addr,
 				region->size);
 		if (ret < 0) {
@@ -197,7 +197,7 @@ nfp_vdpa_dma_do_map(struct rte_vhost_memory *mem,
 	for (i = 0; i < times; i++) {
 		region = &mem->regions[i];
 
-		ret = rte_vfio_container_dma_map(vfio_container_fd,
+		ret = dev_vfio_container_dma_map(vfio_container_fd,
 				region->host_user_addr, region->guest_phys_addr,
 				region->size);
 		if (ret < 0) {
@@ -282,7 +282,7 @@ nfp_vdpa_relay_vring_free(struct nfp_vdpa_dev *device,
 
 		size = RTE_ALIGN_CEIL(vring_size(vring.size, rte_mem_page_size()),
 				rte_mem_page_size());
-		rte_vfio_container_dma_unmap(device->vfio_container_fd,
+		dev_vfio_container_dma_unmap(device->vfio_container_fd,
 				(uint64_t)(uintptr_t)device->hw.m_vring[i].desc,
 				m_vring_iova, size);
 
@@ -315,7 +315,7 @@ nfp_vdpa_relay_vring_alloc(struct nfp_vdpa_dev *device)
 
 		vring_init(&vdpa_hw->m_vring[i], vring.size, vring_buf, page_size);
 
-		ret = rte_vfio_container_dma_map(device->vfio_container_fd,
+		ret = dev_vfio_container_dma_map(device->vfio_container_fd,
 				(uint64_t)(uintptr_t)vring_buf, m_vring_iova, size);
 		if (ret != 0) {
 			DRV_VDPA_LOG(ERR, "vDPA vring relay dma map failed.");
diff --git a/drivers/vdpa/sfc/sfc_vdpa.c b/drivers/vdpa/sfc/sfc_vdpa.c
index eda111954f..c65f716a15 100644
--- a/drivers/vdpa/sfc/sfc_vdpa.c
+++ b/drivers/vdpa/sfc/sfc_vdpa.c
@@ -12,7 +12,7 @@
 #include <rte_errno.h>
 #include <rte_kvargs.h>
 #include <rte_string_fns.h>
-#include <rte_vfio.h>
+#include <dev_vfio.h>
 #include <rte_vhost.h>
 
 #include "efx.h"
@@ -74,13 +74,13 @@ sfc_vdpa_vfio_setup(struct sfc_vdpa_adapter *sva)
 
 	rte_pci_device_name(&dev->addr, dev_name, RTE_DEV_NAME_MAX_LEN);
 
-	sva->vfio_container_fd = rte_vfio_container_create();
+	sva->vfio_container_fd = dev_vfio_container_create();
 	if (sva->vfio_container_fd < 0)	{
 		sfc_vdpa_err(sva, "failed to create VFIO container");
 		goto fail_container_create;
 	}
 
-	rc = rte_vfio_get_group_num(rte_pci_get_sysfs_path(), dev_name,
+	rc = dev_vfio_get_group_num(rte_pci_get_sysfs_path(), dev_name,
 				    &sva->iommu_group_num);
 	if (rc <= 0) {
 		sfc_vdpa_err(sva, "failed to get IOMMU group for %s : %s",
@@ -89,7 +89,7 @@ sfc_vdpa_vfio_setup(struct sfc_vdpa_adapter *sva)
 	}
 
 	sva->vfio_group_fd =
-		rte_vfio_container_group_bind(sva->vfio_container_fd,
+		dev_vfio_container_group_bind(sva->vfio_container_fd,
 					      sva->iommu_group_num);
 	if (sva->vfio_group_fd < 0) {
 		sfc_vdpa_err(sva,
@@ -109,7 +109,7 @@ sfc_vdpa_vfio_setup(struct sfc_vdpa_adapter *sva)
 	return 0;
 
 fail_pci_map_device:
-	if (rte_vfio_container_group_unbind(sva->vfio_container_fd,
+	if (dev_vfio_container_group_unbind(sva->vfio_container_fd,
 					sva->iommu_group_num) != 0) {
 		sfc_vdpa_err(sva,
 			     "failed to unbind IOMMU group %d from container %d",
@@ -118,7 +118,7 @@ sfc_vdpa_vfio_setup(struct sfc_vdpa_adapter *sva)
 
 fail_group_bind:
 fail_get_group_num:
-	if (rte_vfio_container_destroy(sva->vfio_container_fd) != 0) {
+	if (dev_vfio_container_destroy(sva->vfio_container_fd) != 0) {
 		sfc_vdpa_err(sva, "failed to destroy container %d",
 			     sva->vfio_container_fd);
 	}
@@ -132,14 +132,14 @@ sfc_vdpa_vfio_teardown(struct sfc_vdpa_adapter *sva)
 {
 	rte_pci_unmap_device(sva->pdev);
 
-	if (rte_vfio_container_group_unbind(sva->vfio_container_fd,
+	if (dev_vfio_container_group_unbind(sva->vfio_container_fd,
 					    sva->iommu_group_num) != 0) {
 		sfc_vdpa_err(sva,
 			     "failed to unbind IOMMU group %d from container %d",
 			     sva->iommu_group_num, sva->vfio_container_fd);
 	}
 
-	if (rte_vfio_container_destroy(sva->vfio_container_fd) != 0) {
+	if (dev_vfio_container_destroy(sva->vfio_container_fd) != 0) {
 		sfc_vdpa_err(sva,
 			     "failed to destroy container %d",
 			     sva->vfio_container_fd);
diff --git a/drivers/vdpa/sfc/sfc_vdpa_hw.c b/drivers/vdpa/sfc/sfc_vdpa_hw.c
index 7e43719f53..65050b9640 100644
--- a/drivers/vdpa/sfc/sfc_vdpa_hw.c
+++ b/drivers/vdpa/sfc/sfc_vdpa_hw.c
@@ -6,7 +6,7 @@
 
 #include <rte_common.h>
 #include <rte_errno.h>
-#include <rte_vfio.h>
+#include <dev_vfio.h>
 #include <rte_vhost.h>
 
 #include "efx.h"
@@ -64,7 +64,7 @@ sfc_vdpa_dma_alloc(struct sfc_vdpa_adapter *sva, const char *name,
 	mcdi_iova = SFC_VDPA_DEFAULT_MCDI_IOVA;
 
 	for (;;) {
-		ret = rte_vfio_container_dma_map(sva->vfio_container_fd,
+		ret = dev_vfio_container_dma_map(sva->vfio_container_fd,
 						 (uint64_t)mz->addr, mcdi_iova,
 						 mcdi_buff_size);
 		if (ret == 0)
@@ -98,7 +98,7 @@ sfc_vdpa_dma_free(struct sfc_vdpa_adapter *sva, efsys_mem_t *esmp)
 
 	sfc_vdpa_log_init(sva, "name=%s", esmp->esm_mz->name);
 
-	ret = rte_vfio_container_dma_unmap(sva->vfio_container_fd,
+	ret = dev_vfio_container_dma_unmap(sva->vfio_container_fd,
 					   (uint64_t)esmp->esm_base,
 					   esmp->esm_addr, sva->mcdi_buff_size);
 	if (ret < 0)
@@ -140,7 +140,7 @@ sfc_vdpa_dma_map(struct sfc_vdpa_ops_data *ops_data, bool do_map)
 		mem_reg = &vhost_mem->regions[i];
 
 		if (do_map) {
-			rc = rte_vfio_container_dma_map(vfio_container_fd,
+			rc = dev_vfio_container_dma_map(vfio_container_fd,
 						mem_reg->host_user_addr,
 						mem_reg->guest_phys_addr,
 						mem_reg->size);
@@ -151,7 +151,7 @@ sfc_vdpa_dma_map(struct sfc_vdpa_ops_data *ops_data, bool do_map)
 				goto failed_vfio_dma_map;
 			}
 		} else {
-			rc = rte_vfio_container_dma_unmap(vfio_container_fd,
+			rc = dev_vfio_container_dma_unmap(vfio_container_fd,
 						mem_reg->host_user_addr,
 						mem_reg->guest_phys_addr,
 						mem_reg->size);
@@ -171,7 +171,7 @@ sfc_vdpa_dma_map(struct sfc_vdpa_ops_data *ops_data, bool do_map)
 failed_vfio_dma_map:
 	for (j = 0; j < i; j++) {
 		mem_reg = &vhost_mem->regions[j];
-		rte_vfio_container_dma_unmap(vfio_container_fd,
+		dev_vfio_container_dma_unmap(vfio_container_fd,
 					     mem_reg->host_user_addr,
 					     mem_reg->guest_phys_addr,
 					     mem_reg->size);
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 52d265769e..e35aae2540 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -41,7 +41,7 @@
 #include <rte_dev.h>
 #include <rte_devargs.h>
 #include <rte_version.h>
-#include <rte_vfio.h>
+#include <dev_vfio.h>
 #include <malloc_heap.h>
 #include <telemetry_internal.h>
 
@@ -819,8 +819,9 @@ rte_eal_vfio_get_vf_token(__rte_unused rte_uuid_t vf_token)
 {
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_setup_device)
-int rte_vfio_setup_device(__rte_unused const char *sysfs_base,
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_setup_device)
+int
+dev_vfio_setup_device(__rte_unused const char *sysfs_base,
 		      __rte_unused const char *dev_addr,
 		      __rte_unused int *vfio_dev_fd,
 		      __rte_unused struct vfio_device_info *device_info)
@@ -829,8 +830,9 @@ int rte_vfio_setup_device(__rte_unused const char *sysfs_base,
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_release_device)
-int rte_vfio_release_device(__rte_unused const char *sysfs_base,
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_release_device)
+int
+dev_vfio_release_device(__rte_unused const char *sysfs_base,
 			__rte_unused const char *dev_addr,
 			__rte_unused int fd)
 {
@@ -838,40 +840,45 @@ int rte_vfio_release_device(__rte_unused const char *sysfs_base,
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_enable)
-int rte_vfio_enable(void)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_enable)
+int
+dev_vfio_enable(void)
 {
 	rte_errno = ENOTSUP;
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_cleanup)
-void rte_vfio_cleanup(void)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_cleanup)
+void
+dev_vfio_cleanup(void)
 {
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_is_enabled)
-int rte_vfio_is_enabled(__rte_unused const char *modname)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_is_enabled)
+int
+dev_vfio_is_enabled(__rte_unused const char *modname)
 {
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_noiommu_is_enabled)
-int rte_vfio_noiommu_is_enabled(void)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_noiommu_is_enabled)
+int
+dev_vfio_noiommu_is_enabled(void)
 {
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_clear_group)
-int rte_vfio_clear_group(__rte_unused int vfio_group_fd)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_clear_group)
+int
+dev_vfio_clear_group(__rte_unused int vfio_group_fd)
 {
 	rte_errno = ENOTSUP;
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_group_num)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_get_group_num)
 int
-rte_vfio_get_group_num(__rte_unused const char *sysfs_base,
+dev_vfio_get_group_num(__rte_unused const char *sysfs_base,
 		       __rte_unused const char *dev_addr,
 		       __rte_unused int *iommu_group_num)
 {
@@ -879,59 +886,59 @@ rte_vfio_get_group_num(__rte_unused const char *sysfs_base,
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_container_fd)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_get_container_fd)
 int
-rte_vfio_get_container_fd(void)
+dev_vfio_get_container_fd(void)
 {
 	rte_errno = ENOTSUP;
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_group_fd)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_get_group_fd)
 int
-rte_vfio_get_group_fd(__rte_unused int iommu_group_num)
+dev_vfio_get_group_fd(__rte_unused int iommu_group_num)
 {
 	rte_errno = ENOTSUP;
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_create)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_create)
 int
-rte_vfio_container_create(void)
+dev_vfio_container_create(void)
 {
 	rte_errno = ENOTSUP;
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_destroy)
 int
-rte_vfio_container_destroy(__rte_unused int container_fd)
+dev_vfio_container_destroy(__rte_unused int container_fd)
 {
 	rte_errno = ENOTSUP;
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_group_bind)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_group_bind)
 int
-rte_vfio_container_group_bind(__rte_unused int container_fd,
+dev_vfio_container_group_bind(__rte_unused int container_fd,
 		__rte_unused int iommu_group_num)
 {
 	rte_errno = ENOTSUP;
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_group_unbind)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_group_unbind)
 int
-rte_vfio_container_group_unbind(__rte_unused int container_fd,
+dev_vfio_container_group_unbind(__rte_unused int container_fd,
 		__rte_unused int iommu_group_num)
 {
 	rte_errno = ENOTSUP;
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_dma_map)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_dma_map)
 int
-rte_vfio_container_dma_map(__rte_unused int container_fd,
+dev_vfio_container_dma_map(__rte_unused int container_fd,
 			__rte_unused uint64_t vaddr,
 			__rte_unused uint64_t iova,
 			__rte_unused uint64_t len)
@@ -940,9 +947,9 @@ rte_vfio_container_dma_map(__rte_unused int container_fd,
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_dma_unmap)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_dma_unmap)
 int
-rte_vfio_container_dma_unmap(__rte_unused int container_fd,
+dev_vfio_container_dma_unmap(__rte_unused int container_fd,
 			__rte_unused uint64_t vaddr,
 			__rte_unused uint64_t iova,
 			__rte_unused uint64_t len)
diff --git a/lib/eal/include/rte_vfio.h b/lib/eal/include/dev_vfio.h
similarity index 82%
rename from lib/eal/include/rte_vfio.h
rename to lib/eal/include/dev_vfio.h
index b53ce56a8d..d0f741061e 100644
--- a/lib/eal/include/rte_vfio.h
+++ b/lib/eal/include/dev_vfio.h
@@ -2,14 +2,14 @@
  * Copyright(c) 2017 6WIND S.A.
  */
 
-#ifndef _RTE_VFIO_H_
-#define _RTE_VFIO_H_
+#ifndef _DEV_VFIO_H_
+#define _DEV_VFIO_H_
 
 /**
  * @file
  * @internal
  *
- * RTE VFIO internal API.
+ * VFIO device API.
  *
  * This library provides VFIO related utility functions for use by drivers.
  */
@@ -25,11 +25,11 @@ extern "C" {
 
 #ifdef RTE_EXEC_ENV_LINUX
 
-#define RTE_VFIO_DIR "/dev/vfio"
-#define RTE_VFIO_CONTAINER_PATH "/dev/vfio/vfio"
-#define RTE_VFIO_GROUP_FMT "/dev/vfio/%u"
-#define RTE_VFIO_NOIOMMU_GROUP_FMT "/dev/vfio/noiommu-%u"
-#define RTE_VFIO_NOIOMMU_MODE      \
+#define DEV_VFIO_DIR "/dev/vfio"
+#define DEV_VFIO_CONTAINER_PATH "/dev/vfio/vfio"
+#define DEV_VFIO_GROUP_FMT "/dev/vfio/%u"
+#define DEV_VFIO_NOIOMMU_GROUP_FMT "/dev/vfio/noiommu-%u"
+#define DEV_VFIO_NOIOMMU_MODE      \
 	"/sys/module/vfio/parameters/enable_unsafe_noiommu_mode"
 
 #endif /* RTE_EXEC_ENV_LINUX */
@@ -37,7 +37,7 @@ extern "C" {
 /* we don't need an actual definition, only pointer is used */
 struct vfio_device_info;
 
-#define RTE_VFIO_DEFAULT_CONTAINER_FD (-1)
+#define DEV_VFIO_DEFAULT_CONTAINER_FD (-1)
 
 /**
  * @internal
@@ -66,7 +66,7 @@ struct vfio_device_info;
  *   >1 if the device cannot be managed this way.
  */
 __rte_internal
-int rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
+int dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		int *vfio_dev_fd, struct vfio_device_info *device_info);
 
 /**
@@ -90,7 +90,7 @@ int rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
  *   <0 on failure.
  */
 __rte_internal
-int rte_vfio_release_device(const char *sysfs_base, const char *dev_addr, int fd);
+int dev_vfio_release_device(const char *sysfs_base, const char *dev_addr, int fd);
 
 /**
  * @internal
@@ -104,7 +104,7 @@ int rte_vfio_release_device(const char *sysfs_base, const char *dev_addr, int fd
  *   <0 on failure.
  */
 __rte_internal
-int rte_vfio_enable(void);
+int dev_vfio_enable(void);
 
 /**
  * @internal
@@ -113,7 +113,7 @@ int rte_vfio_enable(void);
  * This function is only relevant to Linux.
  */
 __rte_internal
-void rte_vfio_cleanup(void);
+void dev_vfio_cleanup(void);
 
 /**
  * @internal
@@ -129,7 +129,7 @@ void rte_vfio_cleanup(void);
  *   0 otherwise.
  */
 __rte_internal
-int rte_vfio_is_enabled(const char *modname);
+int dev_vfio_is_enabled(const char *modname);
 
 /**
  * @internal
@@ -143,7 +143,7 @@ int rte_vfio_is_enabled(const char *modname);
  *   <0 for errors.
  */
 __rte_internal
-int rte_vfio_noiommu_is_enabled(void);
+int dev_vfio_noiommu_is_enabled(void);
 
 /**
  * @internal
@@ -161,7 +161,7 @@ int rte_vfio_noiommu_is_enabled(void);
  */
 __rte_internal
 int
-rte_vfio_clear_group(int vfio_group_fd);
+dev_vfio_clear_group(int vfio_group_fd);
 
 /**
  * @internal
@@ -186,7 +186,7 @@ rte_vfio_clear_group(int vfio_group_fd);
  */
 __rte_internal
 int
-rte_vfio_get_group_num(const char *sysfs_base,
+dev_vfio_get_group_num(const char *sysfs_base,
 		      const char *dev_addr, int *iommu_group_num);
 
 /**
@@ -213,7 +213,7 @@ rte_vfio_get_group_num(const char *sysfs_base,
  */
 __rte_internal
 int
-rte_vfio_get_device_info(const char *sysfs_base, const char *dev_addr,
+dev_vfio_get_device_info(const char *sysfs_base, const char *dev_addr,
 		int *vfio_dev_fd, struct vfio_device_info *device_info);
 
 /**
@@ -229,7 +229,7 @@ rte_vfio_get_device_info(const char *sysfs_base, const char *dev_addr,
  */
 __rte_internal
 int
-rte_vfio_get_container_fd(void);
+dev_vfio_get_container_fd(void);
 
 /**
  * @internal
@@ -247,7 +247,7 @@ rte_vfio_get_container_fd(void);
  */
 __rte_internal
 int
-rte_vfio_get_group_fd(int iommu_group_num);
+dev_vfio_get_group_fd(int iommu_group_num);
 
 /**
  * @internal
@@ -267,7 +267,7 @@ rte_vfio_get_group_fd(int iommu_group_num);
  */
 __rte_internal
 int
-rte_vfio_container_create(void);
+dev_vfio_container_create(void);
 
 /**
  * @internal
@@ -282,7 +282,7 @@ rte_vfio_container_create(void);
  */
 __rte_internal
 int
-rte_vfio_container_destroy(int container_fd);
+dev_vfio_container_destroy(int container_fd);
 
 /**
  * @internal
@@ -300,7 +300,7 @@ rte_vfio_container_destroy(int container_fd);
  */
 __rte_internal
 int
-rte_vfio_container_group_bind(int container_fd, int iommu_group_num);
+dev_vfio_container_group_bind(int container_fd, int iommu_group_num);
 
 /**
  * @internal
@@ -318,14 +318,14 @@ rte_vfio_container_group_bind(int container_fd, int iommu_group_num);
  */
 __rte_internal
 int
-rte_vfio_container_group_unbind(int container_fd, int iommu_group_num);
+dev_vfio_container_group_unbind(int container_fd, int iommu_group_num);
 
 /**
  * @internal
  * Perform DMA mapping for devices in a container.
  *
  * @param container_fd
- *   the specified container fd. Use RTE_VFIO_DEFAULT_CONTAINER_FD to
+ *   the specified container fd. Use DEV_VFIO_DEFAULT_CONTAINER_FD to
  *   use the default container.
  *
  * @param vaddr
@@ -343,7 +343,7 @@ rte_vfio_container_group_unbind(int container_fd, int iommu_group_num);
  */
 __rte_internal
 int
-rte_vfio_container_dma_map(int container_fd, uint64_t vaddr,
+dev_vfio_container_dma_map(int container_fd, uint64_t vaddr,
 		uint64_t iova, uint64_t len);
 
 /**
@@ -351,7 +351,7 @@ rte_vfio_container_dma_map(int container_fd, uint64_t vaddr,
  * Perform DMA unmapping for devices in a container.
  *
  * @param container_fd
- *   the specified container fd. Use RTE_VFIO_DEFAULT_CONTAINER_FD to
+ *   the specified container fd. Use DEV_VFIO_DEFAULT_CONTAINER_FD to
  *   use the default container.
  *
  * @param vaddr
@@ -369,11 +369,11 @@ rte_vfio_container_dma_map(int container_fd, uint64_t vaddr,
  */
 __rte_internal
 int
-rte_vfio_container_dma_unmap(int container_fd, uint64_t vaddr,
+dev_vfio_container_dma_unmap(int container_fd, uint64_t vaddr,
 		uint64_t iova, uint64_t len);
 
 #ifdef __cplusplus
 }
 #endif
 
-#endif /* _RTE_VFIO_H_ */
+#endif /* _DEV_VFIO_H_ */
diff --git a/lib/eal/include/meson.build b/lib/eal/include/meson.build
index 9282143918..8d3a6d5e00 100644
--- a/lib/eal/include/meson.build
+++ b/lib/eal/include/meson.build
@@ -60,7 +60,7 @@ headers += files(
 driver_sdk_headers = files(
         'bus_driver.h',
         'dev_driver.h',
-        'rte_vfio.h',
+        'dev_vfio.h',
 )
 
 # special case install the generic headers, since they go in a subdir
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 17977baedc..d63edb4192 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -41,7 +41,7 @@
 #include <rte_bus.h>
 #include <rte_version.h>
 #include <malloc_heap.h>
-#include <rte_vfio.h>
+#include <dev_vfio.h>
 
 #include <telemetry_internal.h>
 #include <eal_export.h>
@@ -771,7 +771,7 @@ rte_eal_init(int argc, char **argv)
 #endif
 	}
 
-	if (rte_vfio_enable()) {
+	if (dev_vfio_enable()) {
 		rte_eal_init_alert("Cannot init VFIO");
 		rte_errno = EAGAIN;
 		goto err_out;
@@ -985,7 +985,7 @@ rte_eal_cleanup(void)
 
 	rte_service_finalize();
 	eal_bus_cleanup();
-	rte_vfio_cleanup();
+	dev_vfio_cleanup();
 	rte_mp_channel_cleanup();
 	rte_eal_alarm_cleanup();
 	rte_trace_save();
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index da46ef2f17..ea7e028cfa 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -15,7 +15,7 @@
 #include <rte_log.h>
 #include <rte_memory.h>
 #include <rte_eal_memconfig.h>
-#include <rte_vfio.h>
+#include <dev_vfio.h>
 
 #include <eal_export.h>
 #include "eal_filesystem.h"
@@ -367,7 +367,7 @@ vfio_open_group_fd(int iommu_group_num, bool mp_request)
 	/* if not requesting via mp, open the group locally */
 	if (!mp_request) {
 		/* try regular group format */
-		snprintf(filename, sizeof(filename), RTE_VFIO_GROUP_FMT, iommu_group_num);
+		snprintf(filename, sizeof(filename), DEV_VFIO_GROUP_FMT, iommu_group_num);
 		vfio_group_fd = open(filename, O_RDWR);
 		if (vfio_group_fd < 0) {
 			/* if file not found, it's not an error */
@@ -378,7 +378,7 @@ vfio_open_group_fd(int iommu_group_num, bool mp_request)
 			}
 
 			/* special case: try no-IOMMU path as well */
-			snprintf(filename, sizeof(filename), RTE_VFIO_NOIOMMU_GROUP_FMT,
+			snprintf(filename, sizeof(filename), DEV_VFIO_NOIOMMU_GROUP_FMT,
 				iommu_group_num);
 			vfio_group_fd = open(filename, O_RDWR);
 			if (vfio_group_fd < 0) {
@@ -525,7 +525,7 @@ get_vfio_cfg_by_container_fd(int container_fd)
 {
 	unsigned int i;
 
-	if (container_fd == RTE_VFIO_DEFAULT_CONTAINER_FD)
+	if (container_fd == DEV_VFIO_DEFAULT_CONTAINER_FD)
 		return default_vfio_cfg;
 
 	for (i = 0; i < RTE_DIM(vfio_cfgs); i++) {
@@ -536,9 +536,9 @@ get_vfio_cfg_by_container_fd(int container_fd)
 	return NULL;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_group_fd)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_get_group_fd)
 int
-rte_vfio_get_group_fd(int iommu_group_num)
+dev_vfio_get_group_fd(int iommu_group_num)
 {
 	struct vfio_config *vfio_cfg;
 
@@ -694,7 +694,7 @@ vfio_sync_default_container(void)
 	if (rte_eal_process_type() != RTE_PROC_SECONDARY)
 		return -1;
 
-	/* default container fd should have been opened in rte_vfio_enable() */
+	/* default container fd should have been opened in dev_vfio_enable() */
 	if (!vfio_enabled ||
 			default_vfio_cfg->vfio_container_fd < 0) {
 		EAL_LOG(ERR, "VFIO support is not initialized");
@@ -740,9 +740,9 @@ vfio_sync_default_container(void)
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_clear_group)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_clear_group)
 int
-rte_vfio_clear_group(int vfio_group_fd)
+dev_vfio_clear_group(int vfio_group_fd)
 {
 	int i;
 	struct vfio_config *vfio_cfg;
@@ -769,9 +769,9 @@ rte_vfio_clear_group(int vfio_group_fd)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_setup_device)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_setup_device)
 int
-rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
+dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		int *vfio_dev_fd, struct vfio_device_info *device_info)
 {
 	struct vfio_group_status group_status = {
@@ -793,7 +793,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 	}
 
 	/* get group number */
-	ret = rte_vfio_get_group_num(sysfs_base, dev_addr, &iommu_group_num);
+	ret = dev_vfio_get_group_num(sysfs_base, dev_addr, &iommu_group_num);
 	if (ret == 0) {
 		EAL_LOG(NOTICE,
 				"%s not managed by VFIO driver, skipping",
@@ -806,7 +806,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		return -1;
 
 	/* get the actual group fd */
-	vfio_group_fd = rte_vfio_get_group_fd(iommu_group_num);
+	vfio_group_fd = dev_vfio_get_group_fd(iommu_group_num);
 	if (vfio_group_fd < 0 && vfio_group_fd != -ENOENT)
 		return -1;
 
@@ -832,14 +832,14 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		EAL_LOG(ERR, "%s cannot get VFIO group status, "
 			"error %i (%s)", dev_addr, errno, strerror(errno));
 		close(vfio_group_fd);
-		rte_vfio_clear_group(vfio_group_fd);
+		dev_vfio_clear_group(vfio_group_fd);
 		return -1;
 	} else if (!(group_status.flags & VFIO_GROUP_FLAGS_VIABLE)) {
 		EAL_LOG(ERR, "%s VFIO group is not viable! "
 			"Not all devices in IOMMU group bound to VFIO or unbound",
 			dev_addr);
 		close(vfio_group_fd);
-		rte_vfio_clear_group(vfio_group_fd);
+		dev_vfio_clear_group(vfio_group_fd);
 		return -1;
 	}
 
@@ -860,7 +860,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 				"%s cannot add VFIO group to container, error "
 				"%i (%s)", dev_addr, errno, strerror(errno));
 			close(vfio_group_fd);
-			rte_vfio_clear_group(vfio_group_fd);
+			dev_vfio_clear_group(vfio_group_fd);
 			return -1;
 		}
 
@@ -884,7 +884,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 					"%s failed to select IOMMU type",
 					dev_addr);
 				close(vfio_group_fd);
-				rte_vfio_clear_group(vfio_group_fd);
+				dev_vfio_clear_group(vfio_group_fd);
 				return -1;
 			}
 			/* lock memory hotplug before mapping and release it
@@ -901,7 +901,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 					"%i (%s)",
 					dev_addr, errno, strerror(errno));
 				close(vfio_group_fd);
-				rte_vfio_clear_group(vfio_group_fd);
+				dev_vfio_clear_group(vfio_group_fd);
 				rte_mcfg_mem_read_unlock();
 				return -1;
 			}
@@ -970,7 +970,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		if (ret < 0) {
 			EAL_LOG(ERR, "Could not sync default VFIO container");
 			close(vfio_group_fd);
-			rte_vfio_clear_group(vfio_group_fd);
+			dev_vfio_clear_group(vfio_group_fd);
 			return -1;
 		}
 		/* we have successfully initialized VFIO, notify user */
@@ -1007,7 +1007,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		EAL_LOG(WARNING, "Getting a vfio_dev_fd for %s failed",
 				dev_addr);
 		close(vfio_group_fd);
-		rte_vfio_clear_group(vfio_group_fd);
+		dev_vfio_clear_group(vfio_group_fd);
 		return -1;
 	}
 
@@ -1020,7 +1020,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 				strerror(errno));
 		close(*vfio_dev_fd);
 		close(vfio_group_fd);
-		rte_vfio_clear_group(vfio_group_fd);
+		dev_vfio_clear_group(vfio_group_fd);
 		return -1;
 	}
 	vfio_group_device_get(vfio_group_fd);
@@ -1028,9 +1028,9 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_release_device)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_release_device)
 int
-rte_vfio_release_device(const char *sysfs_base, const char *dev_addr,
+dev_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 		    int vfio_dev_fd)
 {
 	struct vfio_config *vfio_cfg;
@@ -1050,7 +1050,7 @@ rte_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 	rte_mcfg_mem_read_lock();
 
 	/* get group number */
-	ret = rte_vfio_get_group_num(sysfs_base, dev_addr, &iommu_group_num);
+	ret = dev_vfio_get_group_num(sysfs_base, dev_addr, &iommu_group_num);
 	if (ret <= 0) {
 		EAL_LOG(WARNING, "%s not managed by VFIO driver",
 			dev_addr);
@@ -1060,9 +1060,9 @@ rte_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 	}
 
 	/* get the actual group fd */
-	vfio_group_fd = rte_vfio_get_group_fd(iommu_group_num);
+	vfio_group_fd = dev_vfio_get_group_fd(iommu_group_num);
 	if (vfio_group_fd < 0) {
-		EAL_LOG(INFO, "rte_vfio_get_group_fd failed for %s",
+		EAL_LOG(INFO, "dev_vfio_get_group_fd failed for %s",
 				   dev_addr);
 		ret = vfio_group_fd;
 		goto out;
@@ -1098,7 +1098,7 @@ rte_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 			goto out;
 		}
 
-		if (rte_vfio_clear_group(vfio_group_fd) < 0) {
+		if (dev_vfio_clear_group(vfio_group_fd) < 0) {
 			EAL_LOG(INFO, "Error when clearing group for %s",
 					   dev_addr);
 			ret = -1;
@@ -1122,9 +1122,9 @@ rte_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_enable)
 int
-rte_vfio_enable(void)
+dev_vfio_enable(void)
 {
 	/* initialize group list */
 	unsigned int i, j;
@@ -1171,7 +1171,7 @@ rte_vfio_enable(void)
 	}
 
 	/* VFIO directory might not exist (e.g., unprivileged containers) */
-	dir = opendir(RTE_VFIO_DIR);
+	dir = opendir(DEV_VFIO_DIR);
 	if (dir == NULL) {
 		EAL_LOG(DEBUG,
 			"VFIO directory does not exist, skipping VFIO support...");
@@ -1204,9 +1204,9 @@ rte_vfio_enable(void)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_is_enabled)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_is_enabled)
 int
-rte_vfio_is_enabled(const char *modname)
+dev_vfio_is_enabled(const char *modname)
 {
 	const int mod_available = rte_eal_check_module(modname) > 0;
 	return vfio_enabled && mod_available;
@@ -1247,9 +1247,9 @@ vfio_set_iommu_type(int vfio_container_fd)
 	return NULL;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_device_info)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_get_device_info)
 int
-rte_vfio_get_device_info(const char *sysfs_base, const char *dev_addr,
+dev_vfio_get_device_info(const char *sysfs_base, const char *dev_addr,
 		int *vfio_dev_fd, struct vfio_device_info *device_info)
 {
 	int ret;
@@ -1263,7 +1263,7 @@ rte_vfio_get_device_info(const char *sysfs_base, const char *dev_addr,
 		return -1;
 
 	if (*vfio_dev_fd == 0) {
-		ret = rte_vfio_setup_device(sysfs_base, dev_addr,
+		ret = dev_vfio_setup_device(sysfs_base, dev_addr,
 				vfio_dev_fd, device_info);
 		if (ret)
 			return -1;
@@ -1331,10 +1331,10 @@ vfio_open_container_fd(bool mp_request)
 
 	/* if not requesting via mp, open a new container locally */
 	if (!mp_request) {
-		vfio_container_fd = open(RTE_VFIO_CONTAINER_PATH, O_RDWR);
+		vfio_container_fd = open(DEV_VFIO_CONTAINER_PATH, O_RDWR);
 		if (vfio_container_fd < 0) {
 			EAL_LOG(ERR, "Cannot open VFIO container %s, error %i (%s)",
-				RTE_VFIO_CONTAINER_PATH, errno, strerror(errno));
+				DEV_VFIO_CONTAINER_PATH, errno, strerror(errno));
 			return -1;
 		}
 
@@ -1386,12 +1386,12 @@ vfio_open_container_fd(bool mp_request)
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_container_fd)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_get_container_fd)
 int
-rte_vfio_get_container_fd(void)
+dev_vfio_get_container_fd(void)
 {
 	/* Return the default container fd if VFIO is enabled.
-	 * The default container is set up during rte_vfio_enable().
+	 * The default container is set up during dev_vfio_enable().
 	 * This function does not create a new container.
 	 */
 	if (!vfio_enabled)
@@ -1400,9 +1400,9 @@ rte_vfio_get_container_fd(void)
 	return default_vfio_cfg->vfio_container_fd;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_group_num)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_get_group_num)
 int
-rte_vfio_get_group_num(const char *sysfs_base,
+dev_vfio_get_group_num(const char *sysfs_base,
 		const char *dev_addr, int *iommu_group_num)
 {
 	char linkname[PATH_MAX];
@@ -2076,15 +2076,15 @@ container_dma_unmap(struct vfio_config *vfio_cfg, uint64_t vaddr, uint64_t iova,
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_noiommu_is_enabled)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_noiommu_is_enabled)
 int
-rte_vfio_noiommu_is_enabled(void)
+dev_vfio_noiommu_is_enabled(void)
 {
 	int fd;
 	ssize_t cnt;
 	char c;
 
-	fd = open(RTE_VFIO_NOIOMMU_MODE, O_RDONLY);
+	fd = open(DEV_VFIO_NOIOMMU_MODE, O_RDONLY);
 	if (fd < 0) {
 		if (errno != ENOENT) {
 			EAL_LOG(ERR, "Cannot open VFIO noiommu file "
@@ -2109,9 +2109,9 @@ rte_vfio_noiommu_is_enabled(void)
 	return c == 'Y';
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_create)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_create)
 int
-rte_vfio_container_create(void)
+dev_vfio_container_create(void)
 {
 	unsigned int i;
 
@@ -2142,9 +2142,9 @@ rte_vfio_container_create(void)
 	return vfio_cfgs[i].vfio_container_fd;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_destroy)
 int
-rte_vfio_container_destroy(int container_fd)
+dev_vfio_container_destroy(int container_fd)
 {
 	struct vfio_config *vfio_cfg;
 	unsigned int i;
@@ -2154,7 +2154,7 @@ rte_vfio_container_destroy(int container_fd)
 		return -1;
 	}
 
-	if (container_fd == RTE_VFIO_DEFAULT_CONTAINER_FD) {
+	if (container_fd == DEV_VFIO_DEFAULT_CONTAINER_FD) {
 		EAL_LOG(ERR, "Cannot destroy default VFIO container");
 		return -1;
 	}
@@ -2167,7 +2167,7 @@ rte_vfio_container_destroy(int container_fd)
 
 	for (i = 0; i < RTE_DIM(vfio_cfg->vfio_groups); i++)
 		if (vfio_cfg->vfio_groups[i].group_num != -1)
-			rte_vfio_container_group_unbind(container_fd,
+			dev_vfio_container_group_unbind(container_fd,
 				vfio_cfg->vfio_groups[i].group_num);
 
 	close(container_fd);
@@ -2179,9 +2179,9 @@ rte_vfio_container_destroy(int container_fd)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_group_bind)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_group_bind)
 int
-rte_vfio_container_group_bind(int container_fd, int iommu_group_num)
+dev_vfio_container_group_bind(int container_fd, int iommu_group_num)
 {
 	struct vfio_config *vfio_cfg;
 
@@ -2199,9 +2199,9 @@ rte_vfio_container_group_bind(int container_fd, int iommu_group_num)
 	return vfio_get_group_fd(vfio_cfg, iommu_group_num);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_group_unbind)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_group_unbind)
 int
-rte_vfio_container_group_unbind(int container_fd, int iommu_group_num)
+dev_vfio_container_group_unbind(int container_fd, int iommu_group_num)
 {
 	struct vfio_group *cur_grp = NULL;
 	struct vfio_config *vfio_cfg;
@@ -2245,9 +2245,9 @@ rte_vfio_container_group_unbind(int container_fd, int iommu_group_num)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_dma_map)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_dma_map)
 int
-rte_vfio_container_dma_map(int container_fd, uint64_t vaddr, uint64_t iova,
+dev_vfio_container_dma_map(int container_fd, uint64_t vaddr, uint64_t iova,
 		uint64_t len)
 {
 	struct vfio_config *vfio_cfg;
@@ -2271,9 +2271,9 @@ rte_vfio_container_dma_map(int container_fd, uint64_t vaddr, uint64_t iova,
 	return container_dma_map(vfio_cfg, vaddr, iova, len);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_dma_unmap)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_dma_unmap)
 int
-rte_vfio_container_dma_unmap(int container_fd, uint64_t vaddr, uint64_t iova,
+dev_vfio_container_dma_unmap(int container_fd, uint64_t vaddr, uint64_t iova,
 		uint64_t len)
 {
 	struct vfio_config *vfio_cfg;
@@ -2345,9 +2345,9 @@ vfio_cleanup_config(struct vfio_config *vfio_cfg)
 	memset(vfio_cfg->mem_maps.maps, 0, sizeof(vfio_cfg->mem_maps.maps));
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_cleanup)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_cleanup)
 void
-rte_vfio_cleanup(void)
+dev_vfio_cleanup(void)
 {
 	unsigned int i;
 
diff --git a/lib/eal/linux/eal_vfio_mp_sync.c b/lib/eal/linux/eal_vfio_mp_sync.c
index 22136f2e8b..ae1c8b40b9 100644
--- a/lib/eal/linux/eal_vfio_mp_sync.c
+++ b/lib/eal/linux/eal_vfio_mp_sync.c
@@ -8,7 +8,7 @@
 
 #include <rte_errno.h>
 #include <rte_log.h>
-#include <rte_vfio.h>
+#include <dev_vfio.h>
 #include <rte_eal.h>
 
 #include "eal_private.h"
@@ -34,7 +34,7 @@ vfio_mp_primary(const struct rte_mp_msg *msg, const void *peer)
 	case SOCKET_REQ_GROUP:
 		r->req = SOCKET_REQ_GROUP;
 		r->group_num = m->group_num;
-		fd = rte_vfio_get_group_fd(m->group_num);
+		fd = dev_vfio_get_group_fd(m->group_num);
 		if (fd < 0 && fd != -ENOENT)
 			r->result = SOCKET_ERR;
 		else if (fd == -ENOENT)
@@ -49,7 +49,7 @@ vfio_mp_primary(const struct rte_mp_msg *msg, const void *peer)
 		break;
 	case SOCKET_REQ_CONTAINER:
 		r->req = SOCKET_REQ_CONTAINER;
-		fd = rte_vfio_get_container_fd();
+		fd = dev_vfio_get_container_fd();
 		if (fd < 0)
 			r->result = SOCKET_ERR;
 		else {
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index b8771d4d85..d59ce9331f 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -24,7 +24,7 @@
 #include <eal_options.h>
 #include <eal_private.h>
 #include <rte_service_component.h>
-#include <rte_vfio.h>
+#include <dev_vfio.h>
 
 #include "eal_firmware.h"
 #include "eal_hugepages.h"
@@ -152,9 +152,9 @@ rte_eal_cleanup(void)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_cleanup)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_cleanup)
 void
-rte_vfio_cleanup(void)
+dev_vfio_cleanup(void)
 {
 }
 
@@ -459,9 +459,9 @@ eal_asprintf(char **buffer, const char *format, ...)
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_dma_map)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_dma_map)
 int
-rte_vfio_container_dma_map(__rte_unused int container_fd,
+dev_vfio_container_dma_map(__rte_unused int container_fd,
 			__rte_unused uint64_t vaddr,
 			__rte_unused uint64_t iova,
 			__rte_unused uint64_t len)
@@ -470,9 +470,9 @@ rte_vfio_container_dma_map(__rte_unused int container_fd,
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_dma_unmap)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_dma_unmap)
 int
-rte_vfio_container_dma_unmap(__rte_unused int container_fd,
+dev_vfio_container_dma_unmap(__rte_unused int container_fd,
 			__rte_unused uint64_t vaddr,
 			__rte_unused uint64_t iova,
 			__rte_unused uint64_t len)
diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 020c993b29..35aa70dffc 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -42,7 +42,7 @@
 #include <rte_common.h>
 #include <rte_malloc.h>
 #include <rte_log.h>
-#include <rte_vfio.h>
+#include <dev_vfio.h>
 #include <rte_errno.h>
 
 #include "iotlb.h"
@@ -191,7 +191,7 @@ async_dma_map_region(struct virtio_net *dev, struct rte_vhost_mem_region *reg, b
 			continue;
 
 		if (do_map) {
-			ret = rte_vfio_container_dma_map(RTE_VFIO_DEFAULT_CONTAINER_FD,
+			ret = dev_vfio_container_dma_map(DEV_VFIO_DEFAULT_CONTAINER_FD,
 					page->host_user_addr,
 					page->host_iova,
 					page->size);
@@ -216,7 +216,7 @@ async_dma_map_region(struct virtio_net *dev, struct rte_vhost_mem_region *reg, b
 				return -1;
 			}
 		} else {
-			ret = rte_vfio_container_dma_unmap(RTE_VFIO_DEFAULT_CONTAINER_FD,
+			ret = dev_vfio_container_dma_unmap(DEV_VFIO_DEFAULT_CONTAINER_FD,
 					page->host_user_addr,
 					page->host_iova,
 					page->size);
@@ -267,7 +267,7 @@ free_all_mem_regions(struct virtio_net *dev)
 	if (!dev || !dev->mem)
 		return;
 
-	if (dev->async_copy && rte_vfio_is_enabled("vfio"))
+	if (dev->async_copy && dev_vfio_is_enabled("vfio"))
 		async_dma_map(dev, false);
 
 	for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
@@ -1564,7 +1564,7 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
 		dev->mem->nregions++;
 	}
 
-	if (dev->async_copy && rte_vfio_is_enabled("vfio"))
+	if (dev->async_copy && dev_vfio_is_enabled("vfio"))
 		async_dma_map(dev, true);
 
 	if (vhost_user_postcopy_register(dev, main_fd, ctx) < 0)
@@ -1750,7 +1750,7 @@ vhost_user_add_mem_reg(struct virtio_net **pdev,
 
 	dev->mem->nregions++;
 
-	if (dev->async_copy && rte_vfio_is_enabled("vfio")) {
+	if (dev->async_copy && dev_vfio_is_enabled("vfio")) {
 		if (async_dma_map_region(dev, reg, true) < 0)
 			goto free_new_region_no_dma;
 	}
@@ -1791,7 +1791,7 @@ vhost_user_add_mem_reg(struct virtio_net **pdev,
 	return RTE_VHOST_MSG_RESULT_OK;
 
 free_new_region:
-	if (dev->async_copy && rte_vfio_is_enabled("vfio"))
+	if (dev->async_copy && dev_vfio_is_enabled("vfio"))
 		async_dma_map_region(dev, reg, false);
 free_new_region_no_dma:
 	remove_guest_pages(dev, reg);
@@ -1827,7 +1827,7 @@ vhost_user_rem_mem_reg(struct virtio_net **pdev,
 		if (region->userspace_addr == current_region->guest_user_addr
 			&& region->guest_phys_addr == current_region->guest_phys_addr
 			&& region->memory_size == current_region->size) {
-			if (dev->async_copy && rte_vfio_is_enabled("vfio"))
+			if (dev->async_copy && dev_vfio_is_enabled("vfio"))
 				async_dma_map_region(dev, current_region, false);
 			if (dev->features & (1ULL << VIRTIO_F_IOMMU_PLATFORM))
 				vhost_user_iotlb_cache_remove(dev,
-- 
2.52.0

