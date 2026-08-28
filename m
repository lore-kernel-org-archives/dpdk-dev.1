Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CED0C61DBD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 13:08:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B7E540BA2;
	Fri, 28 Aug 2026 15:07:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 1275E40B90
 for <dev@dpdk.org>; Fri, 28 Aug 2026 15:07:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787922448; x=1819458448;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=2Rs7VabA39C2dPdP4RlcGCs76TxXwZYD65RFpZQtyoA=;
 b=LO0UQLISKId5vOwR2uZoivXO9FPWG8VQM3hOXOZgrkohg1WeH4Zf0U4K
 B278ImIzs1YOIxevgHepT9Tsvi2D9kc/FDB5qmaquoLWJCoq3kXo4dgnE
 GhofkyL2SA8XFD045B6JUmE7xf3B1QrhhyyyMGv6aPfcLQduyBiHosGFl
 K3bpslsrBOXf+geZ8wPAhRvobGgcJNDiqIiM+dYSsiiz8faWJYmf9ZwyX
 qs84E4C+VIxQj4jK1vu0DhV9DuPSZ3WCnpYoNGvZaPxPSTAikfoMCYT8/
 p2o9Ti60QAeF2Mxaa8emscBUz8riRZiOGNRja8/DN2f8lujcOfsoUWz/r Q==;
X-CSE-ConnectionGUID: IDCm7zgmRL6Y65C4KJ3RaA==
X-CSE-MsgGUID: fltoLythRQCKFGjR9J6hQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="113964601"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="113964601"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 06:07:28 -0700
X-CSE-ConnectionGUID: eY8P2kdwSDmwg4DwJ4ECyw==
X-CSE-MsgGUID: Qcy4+mitQzqllWCbvv6FNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="271959964"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 28 Aug 2026 06:07:27 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vijay Kumar Srivastava <vsrivast@xilinx.com>
Subject: [PATCH v14 15/25] vdpa/sfc: use container device assignment API
Date: Fri, 28 Aug 2026 14:06:43 +0100
Message-ID: <722e25d7d831f300a88b84ec266b5d09550c0940.1787922363.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787922362.git.anatoly.burakov@intel.com>
 <cover.1787922362.git.anatoly.burakov@intel.com>
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
index c65f716a15..bd5420cfa5 100644
--- a/drivers/vdpa/sfc/sfc_vdpa.c
+++ b/drivers/vdpa/sfc/sfc_vdpa.c
@@ -80,22 +80,12 @@ sfc_vdpa_vfio_setup(struct sfc_vdpa_adapter *sva)
 		goto fail_container_create;
 	}
 
-	rc = dev_vfio_get_group_num(rte_pci_get_sysfs_path(), dev_name,
-				    &sva->iommu_group_num);
-	if (rc <= 0) {
-		sfc_vdpa_err(sva, "failed to get IOMMU group for %s : %s",
-			     dev_name, rte_strerror(-rc));
-		goto fail_get_group_num;
-	}
-
-	sva->vfio_group_fd =
-		dev_vfio_container_group_bind(sva->vfio_container_fd,
-					      sva->iommu_group_num);
-	if (sva->vfio_group_fd < 0) {
-		sfc_vdpa_err(sva,
-			     "failed to bind IOMMU group %d to container %d",
-			     sva->iommu_group_num, sva->vfio_container_fd);
-		goto fail_group_bind;
+	rc = dev_vfio_container_assign_device(sva->vfio_container_fd,
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
-	if (dev_vfio_container_group_unbind(sva->vfio_container_fd,
-					sva->iommu_group_num) != 0) {
-		sfc_vdpa_err(sva,
-			     "failed to unbind IOMMU group %d from container %d",
-			     sva->iommu_group_num, sva->vfio_container_fd);
-	}
-
-fail_group_bind:
-fail_get_group_num:
+fail_device_assign:
 	if (dev_vfio_container_destroy(sva->vfio_container_fd) != 0) {
 		sfc_vdpa_err(sva, "failed to destroy container %d",
 			     sva->vfio_container_fd);
@@ -132,13 +114,6 @@ sfc_vdpa_vfio_teardown(struct sfc_vdpa_adapter *sva)
 {
 	rte_pci_unmap_device(sva->pdev);
 
-	if (dev_vfio_container_group_unbind(sva->vfio_container_fd,
-					    sva->iommu_group_num) != 0) {
-		sfc_vdpa_err(sva,
-			     "failed to unbind IOMMU group %d from container %d",
-			     sva->iommu_group_num, sva->vfio_container_fd);
-	}
-
 	if (dev_vfio_container_destroy(sva->vfio_container_fd) != 0) {
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

