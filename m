Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33DDCFA76B
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 10:10:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5E4440666;
	Fri, 21 Nov 2025 11:09:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id BBE34402F0
 for <dev@dpdk.org>; Fri, 21 Nov 2025 11:09:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763719763; x=1795255763;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=JA70EUtEjVZteFvVszbmG4OtmD4DnpHDqOjgNyJfYBY=;
 b=QYwCJHtyFZFN7baUjOsWq7nyO6TXzZTOByhTVIYNw7stuCvTcH6Sz7sL
 VbOk2PGAKPLZspF1LjCFrxTjsCz97ZCyBOFmA2mp2S/6Fjgn4F/5ptEFw
 mWksiQM6M5FX7Q3N3p17kkCfgbPfxDqRpdF13DibyQfblU3BJ0lqcsF1t
 842h068Oxtip31pSES46cfsqSsQrSLaqWG5glq/YAFF2j44z1FyhvMbbm
 c8LQF66PxpEpe1fXaAMLb9Kx+MnzhVUBH/dkvZTJnj9xH0jueD/SoNevr
 C6qv8dK6Dq7pwjKzMUZcA/YhMREgFZ+5Oft4JCjLauLI1m1Fw7IUKEeBY w==;
X-CSE-ConnectionGUID: ViBoxCTSQ7CNG3/EQ5Kn4A==
X-CSE-MsgGUID: m4PYoxEFSXqknW16PkiQKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="76490995"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; d="scan'208";a="76490995"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 02:09:22 -0800
X-CSE-ConnectionGUID: fKjDwT1tSwa8yoJkXbb3CA==
X-CSE-MsgGUID: DrksC0znQrOnL/9zVYP9dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; d="scan'208";a="196121566"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 21 Nov 2025 02:09:21 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH v6 08/18] vdpa/nfp: use container device assignment API
Date: Fri, 21 Nov 2025 10:08:53 +0000
Message-ID: <2dab318afff58efca71adf927e5fa60b682ec6c6.1763719706.git.anatoly.burakov@intel.com>
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

