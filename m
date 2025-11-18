Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FA3CEE33B
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 16:30:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 278F840677;
	Tue, 18 Nov 2025 17:29:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id B31B14064C
 for <dev@dpdk.org>; Tue, 18 Nov 2025 17:29:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763483381; x=1795019381;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=JA70EUtEjVZteFvVszbmG4OtmD4DnpHDqOjgNyJfYBY=;
 b=UZrPZzrACG6klYb7KDPd5AKW3vomaiYDRggbP1RAE5qreowWX9wgUmO2
 ZpAfRA4g2RIEw51yBOKh3yWcNKnoyd2i0Ec0pBrMUQzje/0vLMbKI2Wx/
 dWwDxMXkWERblfIPJY6s0PQSL3HzbJLzmUGH6THBC5ADOVrkt301Hx4ME
 1OnO9MBzHiFsVKJURnD3GM3Ez7qFmS/2bSyweKk98eBGX180SOHQ+Zln2
 h6PrDHGWHMbi8z0RYY01EqfsPumEuOGDHA2KY6eZiHrJxP/lT4pM4Xto8
 jQkXsb8kt4Vk8r60P8cJOFxNiD+6UX9jRwPNdlHwVHpW1rkp7yFgBnlAq A==;
X-CSE-ConnectionGUID: 7YUV30oRTESnVHkWy3aLaA==
X-CSE-MsgGUID: jvKBiSe1T2ucUY4sojcPbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65550614"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="65550614"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2025 08:29:40 -0800
X-CSE-ConnectionGUID: wwER4DxASnKewVzV0CIAzQ==
X-CSE-MsgGUID: vVykG//OQKST7VSf31/Stg==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 18 Nov 2025 08:29:39 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH v3 10/20] vdpa/nfp: use container device assignment API
Date: Tue, 18 Nov 2025 16:29:11 +0000
Message-ID: <0724e8678743fac3d19170642b9ed7d74fbdffce.1763483254.git.anatoly.burakov@intel.com>
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

