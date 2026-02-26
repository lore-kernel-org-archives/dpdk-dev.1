Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD1BFCE087
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:18:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C61CC40679;
	Thu, 26 Feb 2026 15:18:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id E449640651
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:17:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772115476; x=1803651476;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=a+bNdSVO/FU4TZHtnpQX3mVntkCuPVDydRGj/Dhwxn4=;
 b=Pkk739PJI/EhCLMrQaYvexvBUjKR6AMbvftGnfz1DlMvyyZEGimzz8+y
 4LhPK1sDdJiCLguVwkQMzD4PIAD52rciB7tfsisbVWYb7nc6SZKckiIew
 hp63g4WbHpzoSRXRfmgtWNIMMhkn3xNlxMorvrhpliQ7RFVcxoeSPaCJD
 W4D4dOGR5K6Ps+K2FhmuY/9qmCuxD5cNpjvUPtotctCQOPHMJ9qnPB+0n
 z6jR4kHb1ckvTO8cyVnkQczN0x1p+P7dgEs+bQTNEyMzJDKSWNuS98WlC
 3CknuT1cgzHIr3h846U3NgJjtGTk2Jdwq2DmE/5d86pclEH670bymlaJJ A==;
X-CSE-ConnectionGUID: ktyd5j02QD69Od/+MEaZbg==
X-CSE-MsgGUID: wAEPVe+OQpeV4yBBdAmajw==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="84271097"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="84271097"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 06:17:55 -0800
X-CSE-ConnectionGUID: VGBixNSTQfGo8incncY60A==
X-CSE-MsgGUID: uz39pUgpQ4++8D8ZQyq1Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="220719353"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 26 Feb 2026 06:17:55 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH v7 06/18] net/ntnic: use container device assignment API
Date: Thu, 26 Feb 2026 14:17:29 +0000
Message-ID: <1f915254ba01dfd7da0a07d0b024ecbf6cb8aa19.1772115411.git.anatoly.burakov@intel.com>
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

The NTNIC driver uses VFIO group bind/unbind functionality for container
device assignment purposes. Use the new container device assignment API
instead to provide clearer semantics.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/ntnic/ntnic_vfio.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ntnic/ntnic_vfio.c b/drivers/net/ntnic/ntnic_vfio.c
index 439468b3a2..c746b300b2 100644
--- a/drivers/net/ntnic/ntnic_vfio.c
+++ b/drivers/net/ntnic/ntnic_vfio.c
@@ -28,7 +28,6 @@ nt_vfio_vf_num(const struct rte_pci_device *pdev)
 /* Internal API */
 struct vfio_dev {
 	int container_fd;
-	int group_fd;
 	int dev_fd;
 	uint64_t iova_addr;
 };
@@ -50,7 +49,6 @@ nthw_vfio_setup(struct rte_pci_device *dev)
 {
 	int ret;
 	char devname[RTE_DEV_NAME_MAX_LEN] = { 0 };
-	int iommu_group_num;
 	int vf_num;
 	struct vfio_dev *vfio;
 
@@ -66,14 +64,9 @@ nthw_vfio_setup(struct rte_pci_device *dev)
 	}
 
 	vfio->dev_fd = -1;
-	vfio->group_fd = -1;
 	vfio->iova_addr = START_VF_IOVA;
 
 	rte_pci_device_name(&dev->addr, devname, RTE_DEV_NAME_MAX_LEN);
-	ret = rte_vfio_get_group_num(rte_pci_get_sysfs_path(), devname, &iommu_group_num);
-	if (ret <= 0)
-		return -1;
-
 	if (vf_num == 0) {
 		/* use default container for pf0 */
 		vfio->container_fd = RTE_VFIO_DEFAULT_CONTAINER_FD;
@@ -86,17 +79,14 @@ nthw_vfio_setup(struct rte_pci_device *dev)
 				"VFIO device setup failed. VFIO container creation failed.");
 			return -1;
 		}
-	}
+		ret = rte_vfio_container_assign_device(vfio->container_fd,
+				rte_pci_get_sysfs_path(), devname);
+		if (ret < 0) {
+			NT_LOG(ERR, NTNIC,
+				"VFIO device setup failed. Assign device to container failed.");
+			goto err;
+		}
 
-	vfio->group_fd = rte_vfio_container_group_bind(vfio->container_fd, iommu_group_num);
-
-	if (vfio->group_fd < 0) {
-		NT_LOG(ERR, NTNIC,
-			"VFIO device setup failed. VFIO container group bind failed.");
-		goto err;
-	}
-
-	if (vf_num > 0) {
 		if (rte_pci_map_device(dev)) {
 			NT_LOG(ERR, NTNIC,
 				"Map VFIO device failed. is the vfio-pci driver loaded?");
@@ -106,10 +96,8 @@ nthw_vfio_setup(struct rte_pci_device *dev)
 
 	vfio->dev_fd = rte_intr_dev_fd_get(dev->intr_handle);
 
-	NT_LOG(DBG, NTNIC,
-		"%s: VFIO id=%d, dev_fd=%d, container_fd=%d, group_fd=%d, iommu_group_num=%d",
-		dev->name, vf_num, vfio->dev_fd, vfio->container_fd, vfio->group_fd,
-		iommu_group_num);
+	NT_LOG(DBG, NTNIC, "%s: VFIO id=%d, dev_fd=%d, container_fd=%d",
+		dev->name, vf_num, vfio->dev_fd, vfio->container_fd);
 
 	return vf_num;
 
-- 
2.47.3

