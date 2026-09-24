Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B39C98318
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 16:15:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 770234326A;
	Thu, 24 Sep 2026 18:14:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 907E443299
 for <dev@dpdk.org>; Thu, 24 Sep 2026 18:14:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790266444; x=1821802444;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=2loGFA1sPYY/Dst7KKpDTbV8ZDNoHInBTm1C0XbfgI0=;
 b=iAt1BhxDAiGaPdK1Rp5PWXnyatMHn5lHM64y0UyE6xUFZlzM80+/NRj4
 AmN0JdTMEsalt3OKY19FE9I+wnRtfIBs1c9LRXOb8PG857M9r6vZQ6ugs
 +iJaZUzVgRApqzvjaYfy1seWQWJt+piNmNpliaBfKn6WHu0+hMSCypCtn
 s9gCniyugBU0nvBoWg22OWi0Dk3eMrSe6XnOJMoI7EipLv1xkqECNikdP
 e4R0VpzGsmUuTfsHW35aOVRFBW6f33Gp2ohNP3iteSpYn3ugYxK3bU0/w
 l9FDlqS7qdu1eNyhOPBAghrADv1Ai/JFt+jmJigxXLUkXgbNFsykmCqDG Q==;
X-CSE-ConnectionGUID: r/nuqtVaSAeiMnFk1j55Qg==
X-CSE-MsgGUID: udfPO1mkQ4CF+GWdyox1bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90000672"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90000672"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 09:14:03 -0700
X-CSE-ConnectionGUID: +3kxYPgxQze2HyPwLH9uKA==
X-CSE-MsgGUID: RO6hBNwkScePTKFyX0kAdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="277830026"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 24 Sep 2026 09:13:59 -0700
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
 Vijay Kumar Srivastava <vsrivast@xilinx.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v18 11/29] vfio: rename API to reflect internal status
Date: Thu, 24 Sep 2026 17:13:18 +0100
Message-ID: <25390a3aac750de1e966046d215f724583e18409.1790266166.git.anatoly.burakov@intel.com>
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
 drivers/bus/pci/linux/pci.c                |   8 +-
 drivers/bus/pci/linux/pci_vfio.c           |  38 +++---
 drivers/bus/platform/platform.c            |  10 +-
 drivers/crypto/bcmfs/bcmfs_vfio.c          |   8 +-
 drivers/net/hinic3/base/hinic3_hwdev.c     |   4 +-
 drivers/net/nbl/nbl_common/nbl_userdev.c   |  16 +--
 drivers/net/ntnic/ntnic_ethdev.c           |   4 +-
 drivers/net/ntnic/ntnic_vfio.c             |  22 ++--
 drivers/vdpa/ifc/ifcvf_vdpa.c              |  24 ++--
 drivers/vdpa/nfp/nfp_vdpa.c                |  24 ++--
 drivers/vdpa/sfc/sfc_vdpa.c                |  16 +--
 drivers/vdpa/sfc/sfc_vdpa_hw.c             |  12 +-
 lib/eal/include/{rte_vfio.h => dev_vfio.h} |  68 +++++------
 lib/eal/include/meson.build                |   2 +-
 lib/eal/linux/eal.c                        |   6 +-
 lib/eal/linux/eal_vfio.c                   | 134 ++++++++++-----------
 lib/eal/linux/eal_vfio_mp_sync.c           |   6 +-
 lib/vhost/socket.c                         |   6 +-
 lib/vhost/vhost_user.c                     |   6 +-
 24 files changed, 227 insertions(+), 227 deletions(-)
 rename lib/eal/include/{rte_vfio.h => dev_vfio.h} (81%)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index a308742461e..ebe7da31ceb 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -392,8 +392,8 @@ API Changes
   * all remaining ``rte_flow`` item, action and async operation structures
 
 * vfio: The entire VFIO API (``rte_vfio_*``) was made internal.
-  These functions are now available only to EAL and drivers,
-  and are no longer part of the public API.
+  These functions were renamed to ``dev_vfio_*``, are now available
+  only to EAL and drivers, and are no longer part of public API.
 
 
 ABI Changes
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index c0b46a41ade..ee8f24e67ee 100644
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
index 11fe3265d23..02a34d6f186 100644
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
index 3626b123168..d55c414eada 100644
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
index 8d39895bacf..153e6112dbf 100644
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
index 008e08e71fe..233223fbe5b 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -12,7 +12,7 @@
 #include <rte_malloc.h>
 #include <rte_devargs.h>
 #include <rte_memcpy.h>
-#include <rte_vfio.h>
+#include <dev_vfio.h>
 
 #include <eal_export.h>
 #include "eal_filesystem.h"
@@ -29,7 +29,7 @@ pci_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 	if (pdrv->dma_map != NULL)
 		return pci_common_dma_map(dev, addr, iova, len);
 	if (pdev->kdrv == RTE_PCI_KDRV_VFIO)
-		return rte_vfio_container_dma_map(RTE_VFIO_DEFAULT_CONTAINER_FD,
+		return dev_vfio_container_dma_map(DEV_VFIO_DEFAULT_CONTAINER_FD,
 				(uintptr_t)addr, iova, len);
 	rte_errno = ENOTSUP;
 	return -1;
@@ -44,7 +44,7 @@ pci_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 	if (pdrv->dma_unmap != NULL)
 		return pci_common_dma_unmap(dev, addr, iova, len);
 	if (pdev->kdrv == RTE_PCI_KDRV_VFIO)
-		return rte_vfio_container_dma_unmap(RTE_VFIO_DEFAULT_CONTAINER_FD,
+		return dev_vfio_container_dma_unmap(DEV_VFIO_DEFAULT_CONTAINER_FD,
 				(uintptr_t)addr, iova, len);
 	rte_errno = ENOTSUP;
 	return -1;
@@ -627,7 +627,7 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv,
 		static int is_vfio_noiommu_enabled = -1;
 
 		if (is_vfio_noiommu_enabled == -1) {
-			if (rte_vfio_noiommu_is_enabled() == 1)
+			if (dev_vfio_noiommu_is_enabled() == 1)
 				is_vfio_noiommu_enabled = 1;
 			else
 				is_vfio_noiommu_enabled = 0;
diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index ed713a005f6..e0e94e6ee2c 100644
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
@@ -1302,10 +1302,10 @@ pci_vfio_is_enabled(void)
 {
 	int status;
 
-	if (rte_vfio_enable() < 0)
+	if (dev_vfio_enable() < 0)
 		return 0;
 
-	status = rte_vfio_is_enabled() &&
-		rte_vfio_module_is_loaded(RTE_VFIO_MODULE_VFIO_PCI);
+	status = dev_vfio_is_enabled() &&
+		dev_vfio_module_is_loaded(DEV_VFIO_MODULE_VFIO_PCI);
 	return status;
 }
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 90d865a8df9..9d7df9be803 100644
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
index e7f7ed994c3..053af0d227b 100644
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
index d09a8f7e7d7..6a6cf447528 100644
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
index ec6840d60ea..f1522772f5b 100644
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
index 7634ce6f4c5..d79c4fc1d54 100644
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
@@ -2729,7 +2729,7 @@ nthw_pci_probe(struct rte_pci_driver *pci_drv, struct rte_pci_device *pci_dev)
 			(pci_dev->device.devargs->data ? pci_dev->device.devargs->data : "NULL"));
 	}
 
-	const int n_rte_vfio_no_io_mmu_enabled = rte_vfio_noiommu_is_enabled();
+	const int n_rte_vfio_no_io_mmu_enabled = dev_vfio_noiommu_is_enabled();
 	NT_LOG(DBG, NTNIC, "vfio_no_iommu_enabled=%d", n_rte_vfio_no_io_mmu_enabled);
 
 	if (n_rte_vfio_no_io_mmu_enabled) {
diff --git a/drivers/net/ntnic/ntnic_vfio.c b/drivers/net/ntnic/ntnic_vfio.c
index 439468b3a26..8489a59859f 100644
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
index f319d455ba6..36d06f1e3fb 100644
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
index 4c0ab3ff30d..94740e768d9 100644
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
index eda111954fb..c65f716a15e 100644
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
index 7e43719f53a..65050b9640e 100644
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
diff --git a/lib/eal/include/rte_vfio.h b/lib/eal/include/dev_vfio.h
similarity index 81%
rename from lib/eal/include/rte_vfio.h
rename to lib/eal/include/dev_vfio.h
index da003c33a56..871bebb43b1 100644
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
@@ -37,17 +37,17 @@ extern "C" {
 /* we don't need an actual definition, only pointer is used */
 struct vfio_device_info;
 
-#define RTE_VFIO_DEFAULT_CONTAINER_FD (-1)
+#define DEV_VFIO_DEFAULT_CONTAINER_FD (-1)
 
 /**
- * @enum rte_vfio_module
+ * @enum dev_vfio_module
  * VFIO kernel modules.
  *
  * These values identify kernel modules used by VFIO.
  */
-enum rte_vfio_module {
-	RTE_VFIO_MODULE_VFIO,     /**< Core VFIO module. */
-	RTE_VFIO_MODULE_VFIO_PCI, /**< VFIO PCI module. */
+enum dev_vfio_module {
+	DEV_VFIO_MODULE_VFIO,     /**< Core VFIO module. */
+	DEV_VFIO_MODULE_VFIO_PCI, /**< VFIO PCI module. */
 };
 
 /**
@@ -77,7 +77,7 @@ enum rte_vfio_module {
  *   >1 if the device cannot be managed this way.
  */
 __rte_internal
-int rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
+int dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		int *vfio_dev_fd, struct vfio_device_info *device_info);
 
 /**
@@ -101,7 +101,7 @@ int rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
  *   <0 on failure.
  */
 __rte_internal
-int rte_vfio_release_device(const char *sysfs_base, const char *dev_addr, int fd);
+int dev_vfio_release_device(const char *sysfs_base, const char *dev_addr, int fd);
 
 /**
  * @internal
@@ -115,7 +115,7 @@ int rte_vfio_release_device(const char *sysfs_base, const char *dev_addr, int fd
  *   <0 on failure.
  */
 __rte_internal
-int rte_vfio_enable(void);
+int dev_vfio_enable(void);
 
 /**
  * @internal
@@ -124,7 +124,7 @@ int rte_vfio_enable(void);
  * This function is only relevant to Linux.
  */
 __rte_internal
-void rte_vfio_cleanup(void);
+void dev_vfio_cleanup(void);
 
 /**
  * @internal
@@ -140,7 +140,7 @@ void rte_vfio_cleanup(void);
  *   0 otherwise.
  */
 __rte_internal
-int rte_vfio_module_is_loaded(enum rte_vfio_module module);
+int dev_vfio_module_is_loaded(enum dev_vfio_module module);
 
 /**
  * @internal
@@ -153,7 +153,7 @@ int rte_vfio_module_is_loaded(enum rte_vfio_module module);
  *   0 otherwise.
  */
 __rte_internal
-int rte_vfio_is_enabled(void);
+int dev_vfio_is_enabled(void);
 
 /**
  * @internal
@@ -167,7 +167,7 @@ int rte_vfio_is_enabled(void);
  *   <0 for errors.
  */
 __rte_internal
-int rte_vfio_noiommu_is_enabled(void);
+int dev_vfio_noiommu_is_enabled(void);
 
 /**
  * @internal
@@ -185,7 +185,7 @@ int rte_vfio_noiommu_is_enabled(void);
  */
 __rte_internal
 int
-rte_vfio_clear_group(int vfio_group_fd);
+dev_vfio_clear_group(int vfio_group_fd);
 
 /**
  * @internal
@@ -210,7 +210,7 @@ rte_vfio_clear_group(int vfio_group_fd);
  */
 __rte_internal
 int
-rte_vfio_get_group_num(const char *sysfs_base,
+dev_vfio_get_group_num(const char *sysfs_base,
 		      const char *dev_addr, int *iommu_group_num);
 
 /**
@@ -237,7 +237,7 @@ rte_vfio_get_group_num(const char *sysfs_base,
  */
 __rte_internal
 int
-rte_vfio_get_device_info(const char *sysfs_base, const char *dev_addr,
+dev_vfio_get_device_info(const char *sysfs_base, const char *dev_addr,
 		int *vfio_dev_fd, struct vfio_device_info *device_info);
 
 /**
@@ -253,7 +253,7 @@ rte_vfio_get_device_info(const char *sysfs_base, const char *dev_addr,
  */
 __rte_internal
 int
-rte_vfio_get_container_fd(void);
+dev_vfio_get_container_fd(void);
 
 /**
  * @internal
@@ -271,7 +271,7 @@ rte_vfio_get_container_fd(void);
  */
 __rte_internal
 int
-rte_vfio_get_group_fd(int iommu_group_num);
+dev_vfio_get_group_fd(int iommu_group_num);
 
 /**
  * @internal
@@ -291,7 +291,7 @@ rte_vfio_get_group_fd(int iommu_group_num);
  */
 __rte_internal
 int
-rte_vfio_container_create(void);
+dev_vfio_container_create(void);
 
 /**
  * @internal
@@ -306,7 +306,7 @@ rte_vfio_container_create(void);
  */
 __rte_internal
 int
-rte_vfio_container_destroy(int container_fd);
+dev_vfio_container_destroy(int container_fd);
 
 /**
  * @internal
@@ -324,7 +324,7 @@ rte_vfio_container_destroy(int container_fd);
  */
 __rte_internal
 int
-rte_vfio_container_group_bind(int container_fd, int iommu_group_num);
+dev_vfio_container_group_bind(int container_fd, int iommu_group_num);
 
 /**
  * @internal
@@ -342,14 +342,14 @@ rte_vfio_container_group_bind(int container_fd, int iommu_group_num);
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
@@ -367,7 +367,7 @@ rte_vfio_container_group_unbind(int container_fd, int iommu_group_num);
  */
 __rte_internal
 int
-rte_vfio_container_dma_map(int container_fd, uint64_t vaddr,
+dev_vfio_container_dma_map(int container_fd, uint64_t vaddr,
 		uint64_t iova, uint64_t len);
 
 /**
@@ -375,7 +375,7 @@ rte_vfio_container_dma_map(int container_fd, uint64_t vaddr,
  * Perform DMA unmapping for devices in a container.
  *
  * @param container_fd
- *   the specified container fd. Use RTE_VFIO_DEFAULT_CONTAINER_FD to
+ *   the specified container fd. Use DEV_VFIO_DEFAULT_CONTAINER_FD to
  *   use the default container.
  *
  * @param vaddr
@@ -393,11 +393,11 @@ rte_vfio_container_dma_map(int container_fd, uint64_t vaddr,
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
index 92821439182..8d3a6d5e000 100644
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
index 3f92cc32ebd..419cebc236b 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -39,7 +39,7 @@
 #include <rte_bus.h>
 #include <rte_version.h>
 #include <malloc_heap.h>
-#include <rte_vfio.h>
+#include <dev_vfio.h>
 
 #include <telemetry_internal.h>
 #include <eal_export.h>
@@ -769,7 +769,7 @@ rte_eal_init(int argc, char **argv)
 #endif
 	}
 
-	if (rte_vfio_enable()) {
+	if (dev_vfio_enable()) {
 		rte_eal_init_alert("Cannot init VFIO");
 		rte_errno = EAGAIN;
 		goto err_out;
@@ -983,7 +983,7 @@ rte_eal_cleanup(void)
 
 	rte_service_finalize();
 	eal_bus_cleanup();
-	rte_vfio_cleanup();
+	dev_vfio_cleanup();
 	rte_mp_channel_cleanup();
 	rte_eal_alarm_cleanup();
 	rte_trace_save();
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 780c344bf70..6ea040dd2e3 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -18,7 +18,7 @@
 #include <rte_log.h>
 #include <rte_memory.h>
 #include <rte_eal_memconfig.h>
-#include <rte_vfio.h>
+#include <dev_vfio.h>
 
 #include <eal_export.h>
 #include "eal_filesystem.h"
@@ -64,7 +64,7 @@ static struct vfio_config *default_vfio_cfg = &vfio_cfgs[0];
 static bool vfio_enabled;
 
 static int
-vfio_check_module(enum rte_vfio_module module)
+vfio_check_module(enum dev_vfio_module module)
 {
 	const char *module_name;
 	char sysfs_mod_name[PATH_MAX];
@@ -72,10 +72,10 @@ vfio_check_module(enum rte_vfio_module module)
 	int n;
 
 	switch (module) {
-	case RTE_VFIO_MODULE_VFIO:
+	case DEV_VFIO_MODULE_VFIO:
 		module_name = "vfio";
 		break;
-	case RTE_VFIO_MODULE_VFIO_PCI:
+	case DEV_VFIO_MODULE_VFIO_PCI:
 		module_name = "vfio_pci";
 		break;
 	default:
@@ -411,7 +411,7 @@ vfio_open_group_fd(int iommu_group_num, bool mp_request)
 	/* if not requesting via mp, open the group locally */
 	if (!mp_request) {
 		/* try regular group format */
-		snprintf(filename, sizeof(filename), RTE_VFIO_GROUP_FMT, iommu_group_num);
+		snprintf(filename, sizeof(filename), DEV_VFIO_GROUP_FMT, iommu_group_num);
 		vfio_group_fd = open(filename, O_RDWR);
 		if (vfio_group_fd < 0) {
 			/* if file not found, it's not an error */
@@ -422,7 +422,7 @@ vfio_open_group_fd(int iommu_group_num, bool mp_request)
 			}
 
 			/* special case: try no-IOMMU path as well */
-			snprintf(filename, sizeof(filename), RTE_VFIO_NOIOMMU_GROUP_FMT,
+			snprintf(filename, sizeof(filename), DEV_VFIO_NOIOMMU_GROUP_FMT,
 				iommu_group_num);
 			vfio_group_fd = open(filename, O_RDWR);
 			if (vfio_group_fd < 0) {
@@ -569,7 +569,7 @@ get_vfio_cfg_by_container_fd(int container_fd)
 {
 	unsigned int i;
 
-	if (container_fd == RTE_VFIO_DEFAULT_CONTAINER_FD)
+	if (container_fd == DEV_VFIO_DEFAULT_CONTAINER_FD)
 		return default_vfio_cfg;
 
 	for (i = 0; i < RTE_DIM(vfio_cfgs); i++) {
@@ -580,9 +580,9 @@ get_vfio_cfg_by_container_fd(int container_fd)
 	return NULL;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_group_fd)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_get_group_fd)
 int
-rte_vfio_get_group_fd(int iommu_group_num)
+dev_vfio_get_group_fd(int iommu_group_num)
 {
 	struct vfio_config *vfio_cfg;
 
@@ -738,7 +738,7 @@ vfio_sync_default_container(void)
 	if (rte_eal_process_type() != RTE_PROC_SECONDARY)
 		return -1;
 
-	/* default container fd should have been opened in rte_vfio_enable() */
+	/* default container fd should have been opened in dev_vfio_enable() */
 	if (!vfio_enabled ||
 			default_vfio_cfg->vfio_container_fd < 0) {
 		EAL_LOG(ERR, "VFIO support is not initialized");
@@ -784,9 +784,9 @@ vfio_sync_default_container(void)
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
@@ -813,9 +813,9 @@ rte_vfio_clear_group(int vfio_group_fd)
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
@@ -837,7 +837,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 	}
 
 	/* get group number */
-	ret = rte_vfio_get_group_num(sysfs_base, dev_addr, &iommu_group_num);
+	ret = dev_vfio_get_group_num(sysfs_base, dev_addr, &iommu_group_num);
 	if (ret == 0) {
 		EAL_LOG(NOTICE,
 				"%s not managed by VFIO driver, skipping",
@@ -850,7 +850,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		return -1;
 
 	/* get the actual group fd */
-	vfio_group_fd = rte_vfio_get_group_fd(iommu_group_num);
+	vfio_group_fd = dev_vfio_get_group_fd(iommu_group_num);
 	if (vfio_group_fd < 0 && vfio_group_fd != -ENOENT)
 		return -1;
 
@@ -876,14 +876,14 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
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
 
@@ -904,7 +904,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 				"%s cannot add VFIO group to container, error "
 				"%i (%s)", dev_addr, errno, strerror(errno));
 			close(vfio_group_fd);
-			rte_vfio_clear_group(vfio_group_fd);
+			dev_vfio_clear_group(vfio_group_fd);
 			return -1;
 		}
 
@@ -928,7 +928,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 					"%s failed to select IOMMU type",
 					dev_addr);
 				close(vfio_group_fd);
-				rte_vfio_clear_group(vfio_group_fd);
+				dev_vfio_clear_group(vfio_group_fd);
 				return -1;
 			}
 			/* lock memory hotplug before mapping and release it
@@ -945,7 +945,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 					"%i (%s)",
 					dev_addr, errno, strerror(errno));
 				close(vfio_group_fd);
-				rte_vfio_clear_group(vfio_group_fd);
+				dev_vfio_clear_group(vfio_group_fd);
 				rte_mcfg_mem_read_unlock();
 				return -1;
 			}
@@ -1014,7 +1014,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		if (ret < 0) {
 			EAL_LOG(ERR, "Could not sync default VFIO container");
 			close(vfio_group_fd);
-			rte_vfio_clear_group(vfio_group_fd);
+			dev_vfio_clear_group(vfio_group_fd);
 			return -1;
 		}
 		/* we have successfully initialized VFIO, notify user */
@@ -1051,7 +1051,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		EAL_LOG(WARNING, "Getting a vfio_dev_fd for %s failed",
 				dev_addr);
 		close(vfio_group_fd);
-		rte_vfio_clear_group(vfio_group_fd);
+		dev_vfio_clear_group(vfio_group_fd);
 		return -1;
 	}
 
@@ -1064,7 +1064,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 				strerror(errno));
 		close(*vfio_dev_fd);
 		close(vfio_group_fd);
-		rte_vfio_clear_group(vfio_group_fd);
+		dev_vfio_clear_group(vfio_group_fd);
 		return -1;
 	}
 	vfio_group_device_get(vfio_group_fd);
@@ -1072,9 +1072,9 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
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
@@ -1094,7 +1094,7 @@ rte_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 	rte_mcfg_mem_read_lock();
 
 	/* get group number */
-	ret = rte_vfio_get_group_num(sysfs_base, dev_addr, &iommu_group_num);
+	ret = dev_vfio_get_group_num(sysfs_base, dev_addr, &iommu_group_num);
 	if (ret <= 0) {
 		EAL_LOG(WARNING, "%s not managed by VFIO driver",
 			dev_addr);
@@ -1104,9 +1104,9 @@ rte_vfio_release_device(const char *sysfs_base, const char *dev_addr,
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
@@ -1142,7 +1142,7 @@ rte_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 			goto out;
 		}
 
-		if (rte_vfio_clear_group(vfio_group_fd) < 0) {
+		if (dev_vfio_clear_group(vfio_group_fd) < 0) {
 			EAL_LOG(INFO, "Error when clearing group for %s",
 					   dev_addr);
 			ret = -1;
@@ -1166,9 +1166,9 @@ rte_vfio_release_device(const char *sysfs_base, const char *dev_addr,
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
@@ -1198,7 +1198,7 @@ rte_vfio_enable(void)
 	EAL_LOG(DEBUG, "Probing VFIO support...");
 
 	/* check if vfio module is loaded */
-	vfio_available = vfio_check_module(RTE_VFIO_MODULE_VFIO);
+	vfio_available = vfio_check_module(DEV_VFIO_MODULE_VFIO);
 
 	/* return error directly */
 	if (vfio_available == -1) {
@@ -1214,7 +1214,7 @@ rte_vfio_enable(void)
 	}
 
 	/* VFIO directory might not exist (e.g., unprivileged containers) */
-	dir = opendir(RTE_VFIO_DIR);
+	dir = opendir(DEV_VFIO_DIR);
 	if (dir == NULL) {
 		EAL_LOG(DEBUG,
 			"VFIO directory does not exist, skipping VFIO support...");
@@ -1246,16 +1246,16 @@ rte_vfio_enable(void)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_module_is_loaded)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_module_is_loaded)
 int
-rte_vfio_module_is_loaded(enum rte_vfio_module module)
+dev_vfio_module_is_loaded(enum dev_vfio_module module)
 {
 	return vfio_check_module(module) > 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_is_enabled)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_is_enabled)
 int
-rte_vfio_is_enabled(void)
+dev_vfio_is_enabled(void)
 {
 	return vfio_enabled;
 }
@@ -1295,9 +1295,9 @@ vfio_set_iommu_type(int vfio_container_fd)
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
@@ -1311,7 +1311,7 @@ rte_vfio_get_device_info(const char *sysfs_base, const char *dev_addr,
 		return -1;
 
 	if (*vfio_dev_fd == 0) {
-		ret = rte_vfio_setup_device(sysfs_base, dev_addr,
+		ret = dev_vfio_setup_device(sysfs_base, dev_addr,
 				vfio_dev_fd, device_info);
 		if (ret)
 			return -1;
@@ -1379,10 +1379,10 @@ vfio_open_container_fd(bool mp_request)
 
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
 
@@ -1434,12 +1434,12 @@ vfio_open_container_fd(bool mp_request)
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
@@ -1448,9 +1448,9 @@ rte_vfio_get_container_fd(void)
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
@@ -2124,15 +2124,15 @@ container_dma_unmap(struct vfio_config *vfio_cfg, uint64_t vaddr, uint64_t iova,
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
@@ -2157,9 +2157,9 @@ rte_vfio_noiommu_is_enabled(void)
 	return c == 'Y';
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_create)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_create)
 int
-rte_vfio_container_create(void)
+dev_vfio_container_create(void)
 {
 	unsigned int i;
 
@@ -2189,9 +2189,9 @@ rte_vfio_container_create(void)
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
@@ -2201,7 +2201,7 @@ rte_vfio_container_destroy(int container_fd)
 		return -1;
 	}
 
-	if (container_fd == RTE_VFIO_DEFAULT_CONTAINER_FD) {
+	if (container_fd == DEV_VFIO_DEFAULT_CONTAINER_FD) {
 		EAL_LOG(ERR, "Cannot destroy default VFIO container");
 		return -1;
 	}
@@ -2214,7 +2214,7 @@ rte_vfio_container_destroy(int container_fd)
 
 	for (i = 0; i < RTE_DIM(vfio_cfg->vfio_groups); i++)
 		if (vfio_cfg->vfio_groups[i].group_num != -1)
-			rte_vfio_container_group_unbind(container_fd,
+			dev_vfio_container_group_unbind(container_fd,
 				vfio_cfg->vfio_groups[i].group_num);
 
 	close(container_fd);
@@ -2225,9 +2225,9 @@ rte_vfio_container_destroy(int container_fd)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_group_bind)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_group_bind)
 int
-rte_vfio_container_group_bind(int container_fd, int iommu_group_num)
+dev_vfio_container_group_bind(int container_fd, int iommu_group_num)
 {
 	struct vfio_config *vfio_cfg;
 
@@ -2245,9 +2245,9 @@ rte_vfio_container_group_bind(int container_fd, int iommu_group_num)
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
@@ -2291,9 +2291,9 @@ rte_vfio_container_group_unbind(int container_fd, int iommu_group_num)
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
@@ -2317,9 +2317,9 @@ rte_vfio_container_dma_map(int container_fd, uint64_t vaddr, uint64_t iova,
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
@@ -2392,9 +2392,9 @@ vfio_cleanup_config(struct vfio_config *vfio_cfg)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_cleanup)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_cleanup)
 void
-rte_vfio_cleanup(void)
+dev_vfio_cleanup(void)
 {
 	unsigned int i;
 	bool stuck = false;
diff --git a/lib/eal/linux/eal_vfio_mp_sync.c b/lib/eal/linux/eal_vfio_mp_sync.c
index 22136f2e8bc..ae1c8b40b99 100644
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
diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
index 1e38ea76474..9b100f669d3 100644
--- a/lib/vhost/socket.c
+++ b/lib/vhost/socket.c
@@ -17,7 +17,7 @@
 #include <eal_export.h>
 #include <rte_thread.h>
 #include <rte_log.h>
-#include <rte_vfio.h>
+#include <dev_vfio.h>
 
 #include "fd_man.h"
 #include "vduse.h"
@@ -245,8 +245,8 @@ vhost_user_add_connection(int fd, struct vhost_user_socket *vsocket)
 
 		if (dev != NULL) {
 			dev->async_copy = 1;
-			dev->dma_map_available = rte_vfio_is_enabled() &&
-					rte_vfio_module_is_loaded(RTE_VFIO_MODULE_VFIO);
+			dev->dma_map_available = dev_vfio_is_enabled() &&
+				dev_vfio_module_is_loaded(DEV_VFIO_MODULE_VFIO);
 		}
 	}
 
diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 2d91722fcc0..813efbd67f6 100644
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
-- 
2.52.0

