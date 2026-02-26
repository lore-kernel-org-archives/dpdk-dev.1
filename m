Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F38FCE086
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:18:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B69334067E;
	Thu, 26 Feb 2026 15:18:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id C1C3840667
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:17:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772115477; x=1803651477;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=j9SgHJiGkDd2VBttVtw+GIPkAxZmalcaBq2l12Hht9k=;
 b=TxPYemjfFSLvRWqJ5ejz59LsphR7K+c0AyfUamoFCDIwB53I+sSfqNW4
 3AC0odiUnaxO1r/BF/G0+up4PIfDKaz+wqyphmOsW3ZwQyWFLPs3CWF1Z
 R9p8a0yIy94EWYDPDZz8+OAApv/8nHAX3ABv7+PaUw3ijaODzDFLsnHId
 R+zuiUb02tkPoDbWFkjB9qCfxV4wiJsQF080Jr1DN51+JzHd0TyCVC5tD
 JYEfjhJrEUq0z+W7xzMx5/FxRedT22cFWH1sZLA3DTtdWofzZqv/E5I1j
 ZSRa/n6jrNBTuRzfOQOKTyddkh8ytcaRX3Gbl/WpD8qV4OjDvRhTjTMm9 Q==;
X-CSE-ConnectionGUID: WimUwjOBQia/FM4X+kSiGQ==
X-CSE-MsgGUID: u9L34wp9SA6IDlujvk85Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="84271101"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="84271101"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 06:17:56 -0800
X-CSE-ConnectionGUID: +hWxSb+0RxC76r5y0Imy3Q==
X-CSE-MsgGUID: jPVcT/MURgefY1ruAalxKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="220719357"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 26 Feb 2026 06:17:56 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v7 07/18] vdpa/ifc: use container device assignment API
Date: Thu, 26 Feb 2026 14:17:30 +0000
Message-ID: <0c1f7a682f7aceba79379673a11f5a348cf08387.1772115411.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1772115411.git.anatoly.burakov@intel.com>
 <cover.1772115411.git.anatoly.burakov@intel.com>
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

The IFC vDPA driver uses VFIO group bind/unbind functionality for container
device assignment purposes. Use the new container device assignment API
instead to provide clearer semantics.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/vdpa/ifc/ifcvf_vdpa.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/vdpa/ifc/ifcvf_vdpa.c b/drivers/vdpa/ifc/ifcvf_vdpa.c
index f319d455ba..6f1c050787 100644
--- a/drivers/vdpa/ifc/ifcvf_vdpa.c
+++ b/drivers/vdpa/ifc/ifcvf_vdpa.c
@@ -174,28 +174,19 @@ ifcvf_vfio_setup(struct ifcvf_internal *internal)
 {
 	struct rte_pci_device *dev = internal->pdev;
 	char devname[RTE_DEV_NAME_MAX_LEN] = {0};
-	int iommu_group_num;
-	int i, ret;
+	int i;
 
 	internal->vfio_dev_fd = -1;
-	internal->vfio_group_fd = -1;
 	internal->vfio_container_fd = -1;
 
 	rte_pci_device_name(&dev->addr, devname, RTE_DEV_NAME_MAX_LEN);
-	ret = rte_vfio_get_group_num(rte_pci_get_sysfs_path(), devname,
-			&iommu_group_num);
-	if (ret <= 0) {
-		DRV_LOG(ERR, "%s failed to get IOMMU group", devname);
-		return -1;
-	}
 
 	internal->vfio_container_fd = rte_vfio_container_create();
 	if (internal->vfio_container_fd < 0)
 		return -1;
 
-	internal->vfio_group_fd = rte_vfio_container_group_bind(
-			internal->vfio_container_fd, iommu_group_num);
-	if (internal->vfio_group_fd < 0)
+	if (rte_vfio_container_assign_device(internal->vfio_container_fd,
+			rte_pci_get_sysfs_path(), devname) < 0)
 		goto err;
 
 	if (rte_pci_map_device(dev))
-- 
2.47.3

