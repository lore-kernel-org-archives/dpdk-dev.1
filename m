Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0227FCF319B
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 11:09:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3232640A81;
	Wed, 19 Nov 2025 12:08:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 7110440685
 for <dev@dpdk.org>; Wed, 19 Nov 2025 12:08:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763550515; x=1795086515;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=JA70EUtEjVZteFvVszbmG4OtmD4DnpHDqOjgNyJfYBY=;
 b=nee6BEPjoBxxLEPmv2+OYIlcHW6ylIdcsIqgzD3BBLWu5Kh53Qkgpu3n
 2IVFalTIPuFz5H4G8O1GPwQhQgHdnwZLfFIsUTApQQw0EA2KHSXjz47EH
 bUYwsB0V5lUO4wuxkxkTLmZdvpJpLVZ55XciJOZ1r4PtX5Q2+8Q4VbO8M
 rZahJO7L6UFoSMdWdsciCH1P4uziTS29pGZbVsZubuoTUO+Bh7f1UmmVf
 SHsszz74+7lfYdp7iYUYPtjQZOH/UDhfLMj4i8tuQnD+6Q4ONn59JwPeK
 vwr+9UQd9InBjzlenwXoVwDo4RiwYVK5oGgyNRpGrfcZGPx0cyxGepBQE A==;
X-CSE-ConnectionGUID: ISECXYV+THGUQMbTv2FIgQ==
X-CSE-MsgGUID: 8omy26M3T/+LA5vQTEHqxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65744960"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="65744960"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 03:08:34 -0800
X-CSE-ConnectionGUID: /G5pmWWvQjutfydJRKrKSw==
X-CSE-MsgGUID: CtegbAQGT8y/GcJc4RZ2Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="191158193"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 19 Nov 2025 03:08:33 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH v5 08/18] vdpa/nfp: use container device assignment API
Date: Wed, 19 Nov 2025 11:08:06 +0000
Message-ID: <3f1538b088135ca9d86788f39c6e48912d39a618.1763550470.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763550469.git.anatoly.burakov@intel.com>
 <cover.1763550469.git.anatoly.burakov@intel.com>
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

