Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4137C5AC7A
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 14:47:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D69140E15;
	Fri,  7 Aug 2026 16:46:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 7C70740DFD
 for <dev@dpdk.org>; Fri,  7 Aug 2026 16:46:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786114009; x=1817650009;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=KIQbyDQ17D/FSA1gKye3JfRZh2hJpT+V8+LJwVDVl3w=;
 b=ZYESvEz8wnpuNASceiWyal7lteCenNU0vs29G8QjWIVu4ySpACTFtqEa
 UGoymDJfwDA9kuGUCVadSHJgdVDvql1AWuXKvO100fEuCuFSuvZliyKW3
 /e/zLqDlmZjNVPPHSP8Q14XEeGUI/naAWW1HgyLqcECDTzuKCNqELV6+B
 kB/vjjNuJx+tNbaqkwDnu8+yaykd0U3xDiV7kKZgjRqfVNopI4HM+qBe6
 lTg+S8rV7+xS2ULypAYWz3xjUDOIjds2oLt6zgLMNTyxA4JLuOg/i/X+x
 0fDXQIs5V48QJ/KxFrPN3zxn5hvTNDObG/C+50jhfTQbaOkDQxyK1haq9 A==;
X-CSE-ConnectionGUID: syRQGsw9QOWMcR+Yk6dzTg==
X-CSE-MsgGUID: 1YgRD0d9SZ+/JqB8dtrHKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="104257318"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="104257318"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 07:46:49 -0700
X-CSE-ConnectionGUID: 0j+5PLG2QgGsgeqAI7Gi9Q==
X-CSE-MsgGUID: Xk6//XbdRhenWkkwbn5Qfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="300623279"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 07 Aug 2026 07:46:48 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH v11 09/20] vdpa/nfp: use container device assignment API
Date: Fri,  7 Aug 2026 15:46:18 +0100
Message-ID: <5d74dc29f09bd560c47349b4ff0d9cf85428fa74.1786113800.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1786113799.git.anatoly.burakov@intel.com>
 <cover.1786113799.git.anatoly.burakov@intel.com>
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

The NFP vDPA driver uses VFIO group bind/unbind functionality for container
device assignment purposes. Use the new container device assignment API
instead to provide clearer semantics. Since group API is no longer used
after these changes, remove its implementation.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/vdpa/nfp/nfp_vdpa.c | 37 +++++--------------------------------
 1 file changed, 5 insertions(+), 32 deletions(-)

diff --git a/drivers/vdpa/nfp/nfp_vdpa.c b/drivers/vdpa/nfp/nfp_vdpa.c
index 4c0ab3ff30..778ab2b8e7 100644
--- a/drivers/vdpa/nfp/nfp_vdpa.c
+++ b/drivers/vdpa/nfp/nfp_vdpa.c
@@ -36,9 +36,7 @@ struct nfp_vdpa_dev {
 	struct nfp_vdpa_hw hw;
 
 	int vfio_container_fd;
-	int vfio_group_fd;
 	int vfio_dev_fd;
-	int iommu_group;
 
 	rte_thread_t tid;    /**< Thread for notify relay */
 	int epoll_fd;
@@ -120,33 +118,26 @@ nfp_vdpa_vfio_setup(struct nfp_vdpa_dev *device)
 	struct rte_pci_device *pci_dev = device->pci_dev;
 
 	rte_pci_device_name(&pci_dev->addr, dev_name, RTE_DEV_NAME_MAX_LEN);
-	ret = rte_vfio_get_group_num(rte_pci_get_sysfs_path(), dev_name,
-			&device->iommu_group);
-	if (ret <= 0)
-		return -1;
 
 	device->vfio_container_fd = rte_vfio_container_create();
 	if (device->vfio_container_fd < 0)
 		return -1;
 
-	device->vfio_group_fd = rte_vfio_container_group_bind(
-			device->vfio_container_fd, device->iommu_group);
-	if (device->vfio_group_fd < 0)
+	ret = rte_vfio_container_assign_device(device->vfio_container_fd,
+			rte_pci_get_sysfs_path(), dev_name);
+	if (ret < 0)
 		goto container_destroy;
 
-	DRV_VDPA_LOG(DEBUG, "The container_fd=%d, group_fd=%d.",
-			device->vfio_container_fd, device->vfio_group_fd);
+	DRV_VDPA_LOG(DEBUG, "container_fd=%d", device->vfio_container_fd);
 
 	ret = rte_pci_map_device(pci_dev);
 	if (ret != 0)
-		goto group_unbind;
+		goto container_destroy;
 
 	device->vfio_dev_fd = rte_intr_dev_fd_get(pci_dev->intr_handle);
 
 	return 0;
 
-group_unbind:
-	rte_vfio_container_group_unbind(device->vfio_container_fd, device->iommu_group);
 container_destroy:
 	rte_vfio_container_destroy(device->vfio_container_fd);
 
@@ -157,7 +148,6 @@ static void
 nfp_vdpa_vfio_teardown(struct nfp_vdpa_dev *device)
 {
 	rte_pci_unmap_device(device->pci_dev);
-	rte_vfio_container_group_unbind(device->vfio_container_fd, device->iommu_group);
 	rte_vfio_container_destroy(device->vfio_container_fd);
 }
 
@@ -1023,22 +1013,6 @@ nfp_vdpa_dev_close(int vid)
 	return 0;
 }
 
-static int
-nfp_vdpa_get_vfio_group_fd(int vid)
-{
-	struct rte_vdpa_device *vdev;
-	struct nfp_vdpa_dev_node *node;
-
-	vdev = rte_vhost_get_vdpa_device(vid);
-	node = nfp_vdpa_find_node_by_vdev(vdev);
-	if (node == NULL) {
-		DRV_VDPA_LOG(ERR, "Invalid vDPA device: %p.", vdev);
-		return -ENODEV;
-	}
-
-	return node->device->vfio_group_fd;
-}
-
 static int
 nfp_vdpa_get_vfio_device_fd(int vid)
 {
@@ -1190,7 +1164,6 @@ struct rte_vdpa_dev_ops nfp_vdpa_ops = {
 	.dev_close = nfp_vdpa_dev_close,
 	.set_vring_state = nfp_vdpa_set_vring_state,
 	.set_features = nfp_vdpa_set_features,
-	.get_vfio_group_fd = nfp_vdpa_get_vfio_group_fd,
 	.get_vfio_device_fd = nfp_vdpa_get_vfio_device_fd,
 	.get_notify_area = nfp_vdpa_get_notify_area,
 };
-- 
2.52.0

