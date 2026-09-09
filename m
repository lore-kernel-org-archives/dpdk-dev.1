Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947B6C79F8C
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 10:04:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D75AA427C0;
	Wed,  9 Sep 2026 12:02:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id C09FE427A7
 for <dev@dpdk.org>; Wed,  9 Sep 2026 12:02:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788948173; x=1820484173;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=2Rs7VabA39C2dPdP4RlcGCs76TxXwZYD65RFpZQtyoA=;
 b=Iz/1yxVMsIN7+5UWXbGkkqJoL7QWu/EConl25vLgwTz/E2o9DaHDhf9D
 X09HKaB94o7bBu4za5UyxAghu5LoWiXDGeSEUvnCaf4Ibr+302KZt9N9k
 7ksGE2jpyGcecsskJFYMRvu3l2ZPmODxWUobjS5/Un9SmKUhl5bk4B9Ko
 p2CuWlKgROd2hA6FbKn5SZZWNMFZM8XgOcWpt0eiruf7fIn5qHXtjL8qt
 QJkJyQWleP2uLMGOZcb/43iFVdGk6qUj/FnXz1aNvyxZm0CnYgA+vU+0G
 DV0QuPWg2wieIHIi/0SgAtaXTjwQMqReC7vWZmLAZxap23MQSgN6MFuZ5 g==;
X-CSE-ConnectionGUID: e7xm3cGIQjWI1Epa33/giQ==
X-CSE-MsgGUID: B264mcVjQtiofwpw5Mkxvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89492252"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="89492252"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 03:02:52 -0700
X-CSE-ConnectionGUID: q/R6xpjsSlC1rlskNViglA==
X-CSE-MsgGUID: /uO0+k5YSzesAdbrDKjV5g==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 09 Sep 2026 03:02:51 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vijay Kumar Srivastava <vsrivast@xilinx.com>
Subject: [PATCH v16 16/26] vdpa/sfc: use container device assignment API
Date: Wed,  9 Sep 2026 11:02:09 +0100
Message-ID: <722e25d7d831f300a88b84ec266b5d09550c0940.1788947938.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1788947937.git.anatoly.burakov@intel.com>
 <cover.1788947937.git.anatoly.burakov@intel.com>
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

