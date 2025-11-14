Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30388CE8D5F
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 17:41:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93CA442792;
	Fri, 14 Nov 2025 18:40:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id A093B4275B
 for <dev@dpdk.org>; Fri, 14 Nov 2025 18:40:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763142048; x=1794678048;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=JA70EUtEjVZteFvVszbmG4OtmD4DnpHDqOjgNyJfYBY=;
 b=i6O6Uo0imyztgAIXRB2yD9Yhqc+Z6ieIMqkO1DHh8LAjJoEPL+UaaJ8j
 LwxrsuPRTK0c1drK/Fz8LfHPPLbD9/m1PazlT3yZjz77X6KxMZZMvGB9L
 c4bD7k4Qg02ccXUXO3HiIo0/WLocIaGCn/K/nGHp+By+CPDU6SKaSAcYD
 Otd1/Ij9EooYImZuCC9IuGYuAVaHMSry3lcDeaVzIpOtvKVhUp55K08M0
 tSrcynLFt0kQRGmLck++GprLfIASJ5KV5LgTc7KFCt4/MBBlSgJssdKKe
 r4Wcfot4rFogRAmxEU1j9UKhVbjq3uXpm8hyHsOv4lhCHO0H8/cqO/IP9 w==;
X-CSE-ConnectionGUID: r96NdUrPSqGZZcXCDlYClw==
X-CSE-MsgGUID: jQp5UZyiSg+ppvo2LdbiWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="68864282"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="68864282"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2025 09:40:48 -0800
X-CSE-ConnectionGUID: 4tUNjhkPScOnUU01pr/NiA==
X-CSE-MsgGUID: jCru01icQSumk5E9ICkfCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="189650773"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 14 Nov 2025 09:40:48 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH v2 10/19] vdpa/nfp: use container device assignment API
Date: Fri, 14 Nov 2025 17:40:20 +0000
Message-ID: <0e08123464917167b9f9c7b3fde63d035c6d277b.1763142008.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763142007.git.anatoly.burakov@intel.com>
 <cover.1763142007.git.anatoly.burakov@intel.com>
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

