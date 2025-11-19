Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ACDCF319B
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 11:09:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C12D40A6F;
	Wed, 19 Nov 2025 12:08:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 6D0C340685
 for <dev@dpdk.org>; Wed, 19 Nov 2025 12:08:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763550514; x=1795086514;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=j9SgHJiGkDd2VBttVtw+GIPkAxZmalcaBq2l12Hht9k=;
 b=PpD5z8zjc1jdxyVISQpeNb+S1mF2FQwgeUQ9HT4MT4v7r/0Eo3ByPe74
 3iY2lQlXfAFGehugmet6E55JhJzwOcK0N9tDWiPDMkV/LrAxy8UID8mn6
 OnSFXEakyfW0YAX0gy3Q2nZ5kmv83kvgHOskWGkBMKk1da68JNxsGDG8L
 sxDsAL0RhJh82PU4fsiBaJINpxvDXJw1PVL1pzKppsMmz4xkx7MOOXYJl
 JhE5L7tOU2i1k34bX4Vh+XxgbcJZlmNjG0b7ukaJ2hWzaYub3g1Xstu5O
 MUaBmBMdDf3xRvMEBkLK2+SmjiYYgp30h1VWnjzhsbQBEN4VbXgucHoCZ g==;
X-CSE-ConnectionGUID: Gme0UyxeRIOttiCOZdv9/g==
X-CSE-MsgGUID: UZWl23lbSji2OUwdy9eYLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65744958"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="65744958"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 03:08:33 -0800
X-CSE-ConnectionGUID: ybb9H3UGQrqk1+4SKFfQ9A==
X-CSE-MsgGUID: cAhXxkazQFWowXpbomuHTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="191158191"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 19 Nov 2025 03:08:32 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v5 07/18] vdpa/ifc: use container device assignment API
Date: Wed, 19 Nov 2025 11:08:05 +0000
Message-ID: <37e03bf1ba5f2ec184cc395cb011feab799fbf8d.1763550470.git.anatoly.burakov@intel.com>
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

