Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24590C56208
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 14:12:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CEF240697;
	Thu,  6 Aug 2026 16:11:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 9F7B740697
 for <dev@dpdk.org>; Thu,  6 Aug 2026 16:11:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786025504; x=1817561504;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Q1FT31v+HI7ts8R0GHS5oVCTi+RMdfHmTyGBRejj7aw=;
 b=e+vvTEFdkFU6j7iJ2RNBPee7OIapLHibJP4/LVUyNEbaM9fon7WZYldS
 FqwfdTVVzMAnfMiMzgTTvdi7eaXCJQmW71j28+ulbc4zefCRlCxxBZ5jL
 XsjopzvXXCQr2roiyc1Il0gL+6BCapTBqLf9WYPasyA/h0sCkNrE3x/IE
 l0cu32QY6QHCSFE78hgc2XtHB7HX7bLwGJB9a3d+6wkuHz2rlYmVLtK0N
 +tI4ChzykdwfJKDlWrBI5jYwaroFJMCPWJ48p5uIkyXMr7fgnFkrjk3MF
 dkdP0RP0tJKgYwSqpYB7ktb3rMkgc5JknkddDuG/RvEER1KHv+dLDkdXX g==;
X-CSE-ConnectionGUID: uGJEz2LHSeKwT1IMn460TQ==
X-CSE-MsgGUID: Dl0ng/AXTBqtrFcP8xdanQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="85590001"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="85590001"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 07:11:43 -0700
X-CSE-ConnectionGUID: 6ZMW7mdHSk6k/+qHep3H7A==
X-CSE-MsgGUID: UGLrjGDKQwOXWhBopZxMgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="292015177"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 06 Aug 2026 07:11:41 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vijay Kumar Srivastava <vsrivast@xilinx.com>
Subject: [PATCH v10 10/20] vdpa/sfc: use container device assignment API
Date: Thu,  6 Aug 2026 15:11:10 +0100
Message-ID: <d3ad0a2ac20a48f8448ae84746e94a13dad8133f.1786025388.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1786025387.git.anatoly.burakov@intel.com>
 <cover.1786025387.git.anatoly.burakov@intel.com>
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

