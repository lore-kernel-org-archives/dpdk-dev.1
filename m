Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059B9CD98CE
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 15:10:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BBE2432B2;
	Thu, 11 Jun 2026 17:09:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id EB87D40684
 for <dev@dpdk.org>; Thu, 11 Jun 2026 17:09:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781190577; x=1812726577;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=j9SgHJiGkDd2VBttVtw+GIPkAxZmalcaBq2l12Hht9k=;
 b=oJjiIRegsFpIm6ja9NN8m3pJ8zPGAwrPoq5mkgfaIliHOU5gBMczJjIs
 Jf7+eR5IiP7VHqQX8NHC7aYZ021JeLf3ZuOIX4bpkmjzcYfFpKZuhVs6j
 83Q4J424NpZxNpaWfTAsB54BMyrbRmPdNd+4a2iAbm2Pu+Lr/i49QYhC1
 QX2nysMumocfrz7uwsra8xvCaL3WJg5PI82MJFcNCclWP7q63/kKOoQkY
 2URIWeCvD//ucX1cJWc5bweIIZDeiR80212+Y1rEjLgioe4+bJTBf31xX
 Pvnk9wUJN77MyxYfjG7ND5KXp42nj4QFUmY6EseBoF1AJKuS2bEP7ePIm A==;
X-CSE-ConnectionGUID: rTiv3crgTsuYMTq5sR4nSw==
X-CSE-MsgGUID: SDnTMJqgQJCnHBRmoa3OLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85845379"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="85845379"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 08:09:30 -0700
X-CSE-ConnectionGUID: yTm0nfbQTJyXqZPfUOxmoA==
X-CSE-MsgGUID: WuCHxUL4Q5iNgufVpFs7RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="245625251"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 11 Jun 2026 08:09:30 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v8 07/18] vdpa/ifc: use container device assignment API
Date: Thu, 11 Jun 2026 16:08:59 +0100
Message-ID: <71eef25efefc74dfef52eaa0bffef6ade14181aa.1781190152.git.anatoly.burakov@intel.com>
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

