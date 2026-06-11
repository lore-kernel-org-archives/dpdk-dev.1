Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CE2CD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 15:10:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B53A432D0;
	Thu, 11 Jun 2026 17:09:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 401E442F69
 for <dev@dpdk.org>; Thu, 11 Jun 2026 17:09:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781190577; x=1812726577;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=JA70EUtEjVZteFvVszbmG4OtmD4DnpHDqOjgNyJfYBY=;
 b=LYEdT2DV41iVh09nYZEEFIf8RyFB9ZkZsXtxSqLWNs6cNMeM1IzMBwu9
 23OYzB+ke5/LgGz/Xsg3yCYIfjsKGCsSCJpt3cj3bCZP7YR8Y9dFhv+08
 TkNhcErIvQultM3a/DtP2e8MMHdtsdcQfvQ4pE3JqyoKuZno1CSontgIz
 okGCqXw7w+BN92lLSL8nCc72oH6i6xfLopjsQWqlXvWCybGJcTrJP9Gbq
 wiK1Z3RCE/JI0gAQhEEqs3mIDutGv7HcwoS5UgCG2dtKdhhfSqmZ5F/wG
 kOGvWCtmFrXBKDGHnm/WDtYsevVQHI5LeC7N2oypAssX9Qnoiy1W7S80Y A==;
X-CSE-ConnectionGUID: VcsSsf80Q9qxAe1XAHuTiQ==
X-CSE-MsgGUID: hkSTrBOIRCWLOw0tNneVkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85845380"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="85845380"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 08:09:33 -0700
X-CSE-ConnectionGUID: juLvBXMHTHu7VBRSpNs2bw==
X-CSE-MsgGUID: WOKY2GHGS3y0xxCVRl0BhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="245625259"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 11 Jun 2026 08:09:30 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH v8 08/18] vdpa/nfp: use container device assignment API
Date: Thu, 11 Jun 2026 16:09:00 +0100
Message-ID: <4a34bd11c412d160b27ea1f3640a10dee46e8698.1781190152.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781190151.git.anatoly.burakov@intel.com>
 <cover.1781190151.git.anatoly.burakov@intel.com>
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
instead to provide clearer semantics.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/vdpa/nfp/nfp_vdpa.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/vdpa/nfp/nfp_vdpa.c b/drivers/vdpa/nfp/nfp_vdpa.c
index f4fd5c92ec..4885fa5cbc 100644
--- a/drivers/vdpa/nfp/nfp_vdpa.c
+++ b/drivers/vdpa/nfp/nfp_vdpa.c
@@ -122,33 +122,26 @@ nfp_vdpa_vfio_setup(struct nfp_vdpa_dev *device)
 	rte_pci_unmap_device(pci_dev);
 
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
 
-- 
2.47.3

