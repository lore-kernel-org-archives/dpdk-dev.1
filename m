Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F101C98318
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 16:16:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B174E432EC;
	Thu, 24 Sep 2026 18:14:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 9B7C9432C4
 for <dev@dpdk.org>; Thu, 24 Sep 2026 18:14:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790266452; x=1821802452;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=nigWFf6GwSc3mcYl0mInRe3bLlIKCfP2ARFEMV+wMOw=;
 b=N82ZPkaB8c4nBOIRABt75aNIoqiO4f+2QVSuz5dDTli0tEJR/B0k1URg
 d7c3GmEbLfqBGnPjQ1gyB05jA2xzm8j5PJusHRQYCYwgBNbTJPOdaN6Cm
 g0ikNE4oGDuVh3S5S+7Zy5vZ2Eul/wLdun7cnkK+3g8v5Soj/SkqvV2nl
 rNZJoswIczl5HiLqBMveXzAEzXaPHMBvpNyrZuoYcPGy5P8SIAIMGZ9fK
 /XW3LvWclezwBTrAUSspSq2rcYVZA0XkgzO0Ar4UTjjZw9q6oTfhnf9Yn
 MT6YGtKkw88cSDNLKduLexn6kqrcvO4pSomOahwELh4DAeTu3e51ANVaZ A==;
X-CSE-ConnectionGUID: S/Yr92abRDy7/Ho08SQX2A==
X-CSE-MsgGUID: zxqWHCGcR3qu0hdyA+/1zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90000716"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90000716"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 09:14:12 -0700
X-CSE-ConnectionGUID: iCI/hTSBTcm+6X+Wdr01PA==
X-CSE-MsgGUID: jvZYI2/sQkOoWfJHnPO2Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="277830088"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 24 Sep 2026 09:14:11 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v18 18/29] vdpa/nfp: use container device assignment API
Date: Thu, 24 Sep 2026 17:13:25 +0100
Message-ID: <f793026e71f8e240a75f292c8a22696b5e4ca0cf.1790266166.git.anatoly.burakov@intel.com>
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

The NFP vDPA driver uses VFIO group bind/unbind functionality for container
device assignment purposes. Use the new container device assignment API
instead to provide clearer semantics. Since group API is no longer used
after these changes, remove its implementation.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/vdpa/nfp/nfp_vdpa.c | 37 +++++--------------------------------
 1 file changed, 5 insertions(+), 32 deletions(-)

diff --git a/drivers/vdpa/nfp/nfp_vdpa.c b/drivers/vdpa/nfp/nfp_vdpa.c
index 94740e768d9..76d7d616a66 100644
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
-	ret = dev_vfio_get_group_num(rte_pci_get_sysfs_path(), dev_name,
-			&device->iommu_group);
-	if (ret <= 0)
-		return -1;
 
 	device->vfio_container_fd = dev_vfio_container_create();
 	if (device->vfio_container_fd < 0)
 		return -1;
 
-	device->vfio_group_fd = dev_vfio_container_group_bind(
-			device->vfio_container_fd, device->iommu_group);
-	if (device->vfio_group_fd < 0)
+	ret = dev_vfio_container_assign_device(device->vfio_container_fd,
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
-	dev_vfio_container_group_unbind(device->vfio_container_fd, device->iommu_group);
 container_destroy:
 	dev_vfio_container_destroy(device->vfio_container_fd);
 
@@ -157,7 +148,6 @@ static void
 nfp_vdpa_vfio_teardown(struct nfp_vdpa_dev *device)
 {
 	rte_pci_unmap_device(device->pci_dev);
-	dev_vfio_container_group_unbind(device->vfio_container_fd, device->iommu_group);
 	dev_vfio_container_destroy(device->vfio_container_fd);
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

