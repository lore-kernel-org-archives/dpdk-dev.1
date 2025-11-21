Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756FACFA76A
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 10:10:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2550402F0;
	Fri, 21 Nov 2025 11:09:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id AE303402F0
 for <dev@dpdk.org>; Fri, 21 Nov 2025 11:09:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763719762; x=1795255762;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=j9SgHJiGkDd2VBttVtw+GIPkAxZmalcaBq2l12Hht9k=;
 b=JDhAJdhsWszHCUvumaT+XixVBT303nl3YY1bSkV31MdDfKnn9hAFO+oP
 aRSVcJwXTBMBXBDgTXQsFeP3yCWdvLvQcwsrTcP9bkK8atgUHpacBszOb
 YL6BT6JhWHvIvLuPLtWw/+Q0z16yxXZbhxg1qCSH9SH00hRzsdz4ZGYIJ
 NFYay8CgE2BBio/9aWY2Tl9M9xmfEupmPt8/Z/ukAfw53OiUdAfJvgFdd
 MOJ59xzmhRuNEm0KI6vO9NffTcFbK06GeCTBMN4jYD50NLL0l3wjK+swl
 7r2akv+UjqHAmRjBaBPHxOfrEZ7RJyc1Cp5GvnzN06iNRTCxKThsosaoD Q==;
X-CSE-ConnectionGUID: DDZ3R/nETIOK4nQmSI3+aQ==
X-CSE-MsgGUID: 7l/xvN/gT3CYKL/tV37QLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="76490993"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; d="scan'208";a="76490993"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 02:09:21 -0800
X-CSE-ConnectionGUID: +UrnE1lbQaaf2U8z1iPpSA==
X-CSE-MsgGUID: pymrjmVATp+NDV1XfZxmWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; d="scan'208";a="196121564"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 21 Nov 2025 02:09:21 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v6 07/18] vdpa/ifc: use container device assignment API
Date: Fri, 21 Nov 2025 10:08:52 +0000
Message-ID: <ee3d70444ee063efe4b84bfc5989646765001de0.1763719706.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763719706.git.anatoly.burakov@intel.com>
 <cover.1763719706.git.anatoly.burakov@intel.com>
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

