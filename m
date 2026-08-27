Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185B3C61DB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 15:16:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88EA640B91;
	Thu, 27 Aug 2026 17:15:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 4E90740A75
 for <dev@dpdk.org>; Thu, 27 Aug 2026 17:15:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787843705; x=1819379705;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Ij0X93tRI2faz1kWoy2HO2S/9xdUvU+oUAt5M9zR2G0=;
 b=ONlxiYnM1fhFexCV3tSIdxwFH08HQiQ+uU91dvqY3ciYmitvQ2TlsfRY
 lWj/MW5EPFD8ScdZYBCAlL6OvFGia7B527gG3znGu2JxU6TnVPb+C6EHt
 4R3sZwiY8aNc9UUSrM4Af7Az1fAmsxk9wkFc6KxTt3KWbuN84w+YTGPDO
 /uzFU7qn8RUFl1xymaLhin3Q5ZueWkBPshcgm/Jw2uiWPn4m9tvqoiKot
 wvcBJjuLrzLjh7u1Z8MDy8IA7rp55EXdsfI8VXrdjRext7j0oJTM96rKs
 QrKs8xLcHFt+OUQ6B38u84SxkHt+QcRDHOHWaoO25zR2MnTktGeFfWEoB g==;
X-CSE-ConnectionGUID: /KEvcNFgQraoNjDb/0Gzvw==
X-CSE-MsgGUID: vlR4a0nJRkWoaM0jroSE/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88371632"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="88371632"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 08:15:05 -0700
X-CSE-ConnectionGUID: h2RbzdKaTLOil6ficpKw1A==
X-CSE-MsgGUID: ZxQKBZkZSFOnUV0cM6GQ+w==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 27 Aug 2026 08:15:04 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH v13 11/24] net/ntnic: use container device assignment API
Date: Thu, 27 Aug 2026 16:14:14 +0100
Message-ID: <cb83de02bd7bffc22e28af8e423db7d7036718ba.1787843386.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787843385.git.anatoly.burakov@intel.com>
 <cover.1787843385.git.anatoly.burakov@intel.com>
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
index 8489a59859..cacd81643f 100644
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
-	ret = dev_vfio_get_group_num(rte_pci_get_sysfs_path(), devname, &iommu_group_num);
-	if (ret <= 0)
-		return -1;
-
 	if (vf_num == 0) {
 		/* use default container for pf0 */
 		vfio->container_fd = DEV_VFIO_DEFAULT_CONTAINER_FD;
@@ -86,17 +79,14 @@ nthw_vfio_setup(struct rte_pci_device *dev)
 				"VFIO device setup failed. VFIO container creation failed.");
 			return -1;
 		}
-	}
+		ret = dev_vfio_container_assign_device(vfio->container_fd,
+				rte_pci_get_sysfs_path(), devname);
+		if (ret < 0) {
+			NT_LOG(ERR, NTNIC,
+				"VFIO device setup failed. Assign device to container failed.");
+			goto err;
+		}
 
-	vfio->group_fd = dev_vfio_container_group_bind(vfio->container_fd, iommu_group_num);
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
2.52.0

