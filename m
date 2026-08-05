Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82997C55ABA
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Aug 2026 13:47:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 223A140695;
	Wed,  5 Aug 2026 15:46:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 7020840A76
 for <dev@dpdk.org>; Wed,  5 Aug 2026 15:46:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785937568; x=1817473568;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Q1FT31v+HI7ts8R0GHS5oVCTi+RMdfHmTyGBRejj7aw=;
 b=ioncMZ9ta6+PX/g2TVZCh0/koKqgfzQrb7PYW//aMew+Kv4sDHaDc5Z9
 pP5rGPAyImUY6AYV3fjiRd8B4wX980UQfW/MvlP1SJKgWOMyQxUsGhfwV
 loaCX6OGBowXUXnq/d6iBLq1MCtkdqkor1RLH0rSMuMetCRfNvHEQFsv5
 aZaNjgl1fcTi2i2MNB3AayqzueqPmvIdfoPr452qkGoMptMBuax7wiNR9
 WFr2BIeltLiKGOMqQw22cBUCL8vNiPve41wvjBrGjPGJ1/2MOLL3vuG6G
 O2TCSK1G4GOYtuKGUgPU9xdFPc67TVnGbBrDf/5mwN5FdHrSnN7Pk0n2W A==;
X-CSE-ConnectionGUID: xSMatWmhRi+RkH6vnDp/ew==
X-CSE-MsgGUID: SgZ1RLEFQsCc2praHHkM8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86284095"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="86284095"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 06:46:08 -0700
X-CSE-ConnectionGUID: m+dtHQzeQrO5JUlrMmCZMA==
X-CSE-MsgGUID: UXCkcVuTRp2JA/6Lxt+3Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="258476639"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa007.fm.intel.com with ESMTP; 05 Aug 2026 06:46:07 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vijay Kumar Srivastava <vsrivast@xilinx.com>
Subject: [PATCH v9 09/19] vdpa/sfc: use container device assignment API
Date: Wed,  5 Aug 2026 14:45:38 +0100
Message-ID: <a8d66001d1ae6cb8ff5f7417e9bfbab13d402c96.1785937061.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1785937060.git.anatoly.burakov@intel.com>
 <cover.1785937060.git.anatoly.burakov@intel.com>
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

The SFC vDPA driver uses VFIO group bind/unbind functionality for container
device assignment purposes. Use the new container device assignment API
instead to provide clearer semantics.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/vdpa/sfc/sfc_vdpa.c | 39 +++++++------------------------------
 drivers/vdpa/sfc/sfc_vdpa.h |  2 --
 2 files changed, 7 insertions(+), 34 deletions(-)

diff --git a/drivers/vdpa/sfc/sfc_vdpa.c b/drivers/vdpa/sfc/sfc_vdpa.c
index eda111954f..99b4ced3f4 100644
--- a/drivers/vdpa/sfc/sfc_vdpa.c
+++ b/drivers/vdpa/sfc/sfc_vdpa.c
@@ -80,22 +80,12 @@ sfc_vdpa_vfio_setup(struct sfc_vdpa_adapter *sva)
 		goto fail_container_create;
 	}
 
-	rc = rte_vfio_get_group_num(rte_pci_get_sysfs_path(), dev_name,
-				    &sva->iommu_group_num);
-	if (rc <= 0) {
-		sfc_vdpa_err(sva, "failed to get IOMMU group for %s : %s",
-			     dev_name, rte_strerror(-rc));
-		goto fail_get_group_num;
-	}
-
-	sva->vfio_group_fd =
-		rte_vfio_container_group_bind(sva->vfio_container_fd,
-					      sva->iommu_group_num);
-	if (sva->vfio_group_fd < 0) {
-		sfc_vdpa_err(sva,
-			     "failed to bind IOMMU group %d to container %d",
-			     sva->iommu_group_num, sva->vfio_container_fd);
-		goto fail_group_bind;
+	rc = rte_vfio_container_assign_device(sva->vfio_container_fd,
+			rte_pci_get_sysfs_path(), dev_name);
+	if (rc < 0) {
+		sfc_vdpa_err(sva, "failed to assign device %s to container %d",
+			     dev_name, sva->vfio_container_fd);
+		goto fail_device_assign;
 	}
 
 	if (rte_pci_map_device(dev) != 0) {
@@ -109,15 +99,7 @@ sfc_vdpa_vfio_setup(struct sfc_vdpa_adapter *sva)
 	return 0;
 
 fail_pci_map_device:
-	if (rte_vfio_container_group_unbind(sva->vfio_container_fd,
-					sva->iommu_group_num) != 0) {
-		sfc_vdpa_err(sva,
-			     "failed to unbind IOMMU group %d from container %d",
-			     sva->iommu_group_num, sva->vfio_container_fd);
-	}
-
-fail_group_bind:
-fail_get_group_num:
+fail_device_assign:
 	if (rte_vfio_container_destroy(sva->vfio_container_fd) != 0) {
 		sfc_vdpa_err(sva, "failed to destroy container %d",
 			     sva->vfio_container_fd);
@@ -132,13 +114,6 @@ sfc_vdpa_vfio_teardown(struct sfc_vdpa_adapter *sva)
 {
 	rte_pci_unmap_device(sva->pdev);
 
-	if (rte_vfio_container_group_unbind(sva->vfio_container_fd,
-					    sva->iommu_group_num) != 0) {
-		sfc_vdpa_err(sva,
-			     "failed to unbind IOMMU group %d from container %d",
-			     sva->iommu_group_num, sva->vfio_container_fd);
-	}
-
 	if (rte_vfio_container_destroy(sva->vfio_container_fd) != 0) {
 		sfc_vdpa_err(sva,
 			     "failed to destroy container %d",
diff --git a/drivers/vdpa/sfc/sfc_vdpa.h b/drivers/vdpa/sfc/sfc_vdpa.h
index 2b843e563d..99a81fd1b0 100644
--- a/drivers/vdpa/sfc/sfc_vdpa.h
+++ b/drivers/vdpa/sfc/sfc_vdpa.h
@@ -70,10 +70,8 @@ struct sfc_vdpa_adapter {
 
 	sfc_vdpa_filter_t		filters;
 
-	int				vfio_group_fd;
 	int				vfio_dev_fd;
 	int				vfio_container_fd;
-	int				iommu_group_num;
 	struct sfc_vdpa_ops_data	*ops_data;
 };
 
-- 
2.52.0

