Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548B3CE8D5F
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 17:42:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7B5342798;
	Fri, 14 Nov 2025 18:40:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id CA7B942709
 for <dev@dpdk.org>; Fri, 14 Nov 2025 18:40:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763142050; x=1794678050;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=pSaJUnKvo4EHm41+Ni1ZVF4d6PjaOQMemQOWvOPGga8=;
 b=E+rpXgzRBOUYZio7Xy/RIRJLaDVNMt5XRnXTvE5Q9meZEuFdzJqnHVMB
 PfDLM0VI6uFisi+VRf5RQLi59a1ldbDKE9n9GxIlQ/Dh3lT6uf9wGvUQF
 8yWgHrK3NJlnHQ51MEGwGOOoan6iQrJPDJzCmc+vvJM6g7nLIYEAc8a1Z
 JgXb/UCbcw8w8pb60MM2nrxN28ozg7y9WlDKp98UVetCqR2/ARIqSAu3a
 t9xP32K4BTW7TjtPqsrGJVXcdkrKTeVlaPJCuZ4zKmF7LXjBE0lOHCiKL
 iv9cE59AJoH130EVA1jNMRDRCNY1vvT4pPHVKaM62OTX3UecafXtmD5Tj A==;
X-CSE-ConnectionGUID: wxW+a3MSTOeUmrTNLlL53Q==
X-CSE-MsgGUID: UXAE98nmRteFpIkX7CuLkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="68864285"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="68864285"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2025 09:40:49 -0800
X-CSE-ConnectionGUID: /zD/otFHT+yTJr+//mdzBQ==
X-CSE-MsgGUID: /KPw06nnRTepbfwX8LtwfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="189650779"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 14 Nov 2025 09:40:49 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vijay Kumar Srivastava <vsrivast@xilinx.com>
Subject: [PATCH v2 11/19] vdpa/sfc: use container device assignment API
Date: Fri, 14 Nov 2025 17:40:21 +0000
Message-ID: <e0ebe444bdcb6a5b151a3a88a4a9658830cce7d9.1763142008.git.anatoly.burakov@intel.com>
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
2.47.3

