Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD88CFA76A
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 10:09:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83E0140653;
	Fri, 21 Nov 2025 11:09:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id CBDDA40430
 for <dev@dpdk.org>; Fri, 21 Nov 2025 11:09:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763719761; x=1795255761;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=a+bNdSVO/FU4TZHtnpQX3mVntkCuPVDydRGj/Dhwxn4=;
 b=JrCDdIA0BsIekEQkqQIcDmny/cA6V+gMRpAyP/A1mZUrBQdYxD5oVfUR
 QBFwd7pirEgGnQaRQV0nSE4GYY0LKuoinvECYMABuOfluK7cgdSFF47/s
 yzufVQsp2nfB50NUcz0j6cG8zElRH10EJ1vVsAokXfCNg/XxYOa5OE0nk
 Jw/uFPldm+EnKXH7eXkw7KYR1OIFvX4Y/7b6tipDoCJ4f4BNGlZjI3Bez
 MLxZQc+Z8bKvSYyrb5E75NwAf0+ZaVLlPJuc6mhVXaOsawRWt0tYrb7hj
 XrPK7ACebcKt6u9WtWwFvXo6YrGi7PHqETipP9Xdw7NV5JMrpBDcY2Kh+ A==;
X-CSE-ConnectionGUID: tC9Tjx3ZQga8OeQfkfksUA==
X-CSE-MsgGUID: rPLJnqeSQCWhWYL2WdksAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="76490990"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; d="scan'208";a="76490990"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 02:09:20 -0800
X-CSE-ConnectionGUID: FU+lCSIjSISA7t5nsQ+tDQ==
X-CSE-MsgGUID: YhMAQOcjRSivfapmalqr7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; d="scan'208";a="196121562"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 21 Nov 2025 02:09:19 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH v6 06/18] net/ntnic: use container device assignment API
Date: Fri, 21 Nov 2025 10:08:51 +0000
Message-ID: <4be4b17fcafc8a85e90c3e188f6096cd13df166d.1763719706.git.anatoly.burakov@intel.com>
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

