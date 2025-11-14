Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B60CE8D67
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 17:41:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 801534278E;
	Fri, 14 Nov 2025 18:40:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id A99FF42686
 for <dev@dpdk.org>; Fri, 14 Nov 2025 18:40:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763142047; x=1794678047;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=j9SgHJiGkDd2VBttVtw+GIPkAxZmalcaBq2l12Hht9k=;
 b=PGyBOwa24kces0svToki+QMBGu21VedqUjyw0lqJ1dYMzjJzvMOHt2Vj
 Pa9pMtnYb5uwXD1gFE/fUPhQRtnB9/++OMp4hXXTqlDc8U3Gm6ICvT583
 H1rGoJQJeqHUWHEChY6tDnqiE7c7wZyqUmHN/TOijs+6wmObeCIIKMry+
 wtQEbeQ+4YN0ipKu1JIIW8KuW+D5Eo3QGxWHD6xf44s9rKvfZyItkFpyk
 zK+Ugow7+baYcyXYDqThLpiBm4mPBTmbMw6W/cqZ6g6/+Q+yLNby6s2PY
 7LZ1DZXLeyPnrbi7kelrhLVGSKdQi4v/24CGKca5sze4hV2lindSSO7h9 Q==;
X-CSE-ConnectionGUID: 60TzB50JS8ii14h5AOwW7Q==
X-CSE-MsgGUID: RMCz/d3fT1O7FcIyaATB+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="68864281"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="68864281"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2025 09:40:47 -0800
X-CSE-ConnectionGUID: CTcbPTj4REi84RYwHdKQpA==
X-CSE-MsgGUID: Jb9OHKRuRoGnRdLT0AhaSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="189650771"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 14 Nov 2025 09:40:47 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v2 09/19] vdpa/ifc: use container device assignment API
Date: Fri, 14 Nov 2025 17:40:19 +0000
Message-ID: <655e4dc4f324f392d87c9fa1607134157d626111.1763142008.git.anatoly.burakov@intel.com>
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

