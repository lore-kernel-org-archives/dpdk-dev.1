Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF828CE8D67
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 17:42:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF2C24279C;
	Fri, 14 Nov 2025 18:40:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 9C1C842796
 for <dev@dpdk.org>; Fri, 14 Nov 2025 18:40:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763142051; x=1794678051;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=fcLWURXChtPQcHtsiQ1uKcVEswGzl9srt/zpd/9y044=;
 b=jw+x77wx5gIQfQIZfsB5L5dNVs/YMvcUEuPr6RTf7xDhOaE103qOehXm
 rJYUU7VJcmyDsuPm0U/nSYkhY1pT/KTIsmrOYJ+3HORzpaRkAz6zguA2W
 IHwP1Dl0JHpoBfH2N6JZ4oSfqMleo9tH955/TOKmzw+dg1mS29AH8/72O
 KZdP0lVSHiIJX2fZfpik2zosnkNhYhcI0TqmculIRoMP+FWXH6hDLO9Tg
 ZNv+wgQADCRcfeHVI8Fai2rd788F/srN2bTmD26H7Fk2F+gxwsCdXbjvl
 kxtzb/Qc6f7KynJzSXqq1SSvLyZYGNPeDJj/iTE3l5VHTFYuzhWJspixR Q==;
X-CSE-ConnectionGUID: pRRsnE6DTrGTp060JuVQUg==
X-CSE-MsgGUID: ifJNapa2S1u9E2jvUtNeZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="68864287"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="68864287"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2025 09:40:51 -0800
X-CSE-ConnectionGUID: w8rqEbVMSzGaz97AC0SuRw==
X-CSE-MsgGUID: /eUEyfdKRpi8hiNRnAjrow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="189650784"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 14 Nov 2025 09:40:50 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH v2 12/19] vhost: remove group-related API from drivers
Date: Fri, 14 Nov 2025 17:40:22 +0000
Message-ID: <2997293f976bbaf0ab370331a5739baf7571ba40.1763142008.git.anatoly.burakov@intel.com>
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

Some vDPA drivers have "get_vfio_group_fd" call in their internal driver
API structure, but it is not used for anything beyond device assignment
to containers which can now be achieved via other means, so remove this
API and all its usages.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 doc/guides/prog_guide/vhost_lib.rst |  4 ----
 drivers/vdpa/ifc/ifcvf_vdpa.c       | 19 -------------------
 drivers/vdpa/mlx5/mlx5_vdpa.c       |  1 -
 drivers/vdpa/nfp/nfp_vdpa.c         | 20 --------------------
 lib/vhost/vdpa_driver.h             |  3 ---
 5 files changed, 47 deletions(-)

diff --git a/doc/guides/prog_guide/vhost_lib.rst b/doc/guides/prog_guide/vhost_lib.rst
index 0c2b4d020a..2f80cf4072 100644
--- a/doc/guides/prog_guide/vhost_lib.rst
+++ b/doc/guides/prog_guide/vhost_lib.rst
@@ -471,10 +471,6 @@ Finally, a set of device ops is defined for device specific operations:
 
   Called to allow the device to response to RARP sending.
 
-* ``get_vfio_group_fd``
-
-   Called to get the VFIO group fd of the device.
-
 * ``get_vfio_device_fd``
 
   Called to get the VFIO device fd of the device.
diff --git a/drivers/vdpa/ifc/ifcvf_vdpa.c b/drivers/vdpa/ifc/ifcvf_vdpa.c
index 6f1c050787..63f4172da5 100644
--- a/drivers/vdpa/ifc/ifcvf_vdpa.c
+++ b/drivers/vdpa/ifc/ifcvf_vdpa.c
@@ -58,7 +58,6 @@ struct ifcvf_internal {
 	struct ifcvf_hw hw;
 	int configured;
 	int vfio_container_fd;
-	int vfio_group_fd;
 	int vfio_dev_fd;
 	rte_thread_t tid; /* thread for notify relay */
 	rte_thread_t intr_tid; /* thread for config space change interrupt relay */
@@ -1204,22 +1203,6 @@ ifcvf_set_features(int vid)
 	return 0;
 }
 
-static int
-ifcvf_get_vfio_group_fd(int vid)
-{
-	struct rte_vdpa_device *vdev;
-	struct internal_list *list;
-
-	vdev = rte_vhost_get_vdpa_device(vid);
-	list = find_internal_resource_by_vdev(vdev);
-	if (list == NULL) {
-		DRV_LOG(ERR, "Invalid vDPA device: %p", vdev);
-		return -1;
-	}
-
-	return list->internal->vfio_group_fd;
-}
-
 static int
 ifcvf_get_vfio_device_fd(int vid)
 {
@@ -1465,7 +1448,6 @@ static struct rte_vdpa_dev_ops ifcvf_net_ops = {
 	.set_vring_state = ifcvf_set_vring_state,
 	.set_features = ifcvf_set_features,
 	.migration_done = NULL,
-	.get_vfio_group_fd = ifcvf_get_vfio_group_fd,
 	.get_vfio_device_fd = ifcvf_get_vfio_device_fd,
 	.get_notify_area = ifcvf_get_notify_area,
 	.get_dev_type = ifcvf_get_device_type,
@@ -1596,7 +1578,6 @@ static struct rte_vdpa_dev_ops ifcvf_blk_ops = {
 	.dev_close = ifcvf_dev_close,
 	.set_vring_state = ifcvf_set_vring_state,
 	.migration_done = NULL,
-	.get_vfio_group_fd = ifcvf_get_vfio_group_fd,
 	.get_vfio_device_fd = ifcvf_get_vfio_device_fd,
 	.get_notify_area = ifcvf_get_notify_area,
 	.get_config = ifcvf_blk_get_config,
diff --git a/drivers/vdpa/mlx5/mlx5_vdpa.c b/drivers/vdpa/mlx5/mlx5_vdpa.c
index 11708e2005..1bb5de51b6 100644
--- a/drivers/vdpa/mlx5/mlx5_vdpa.c
+++ b/drivers/vdpa/mlx5/mlx5_vdpa.c
@@ -523,7 +523,6 @@ static struct rte_vdpa_dev_ops mlx5_vdpa_ops = {
 	.set_vring_state = mlx5_vdpa_set_vring_state,
 	.set_features = mlx5_vdpa_features_set,
 	.migration_done = NULL,
-	.get_vfio_group_fd = NULL,
 	.get_vfio_device_fd = mlx5_vdpa_get_device_fd,
 	.get_notify_area = mlx5_vdpa_get_notify_area,
 	.get_stats_names = mlx5_vdpa_get_stats_names,
diff --git a/drivers/vdpa/nfp/nfp_vdpa.c b/drivers/vdpa/nfp/nfp_vdpa.c
index 4885fa5cbc..efd7ee7d95 100644
--- a/drivers/vdpa/nfp/nfp_vdpa.c
+++ b/drivers/vdpa/nfp/nfp_vdpa.c
@@ -36,9 +36,7 @@ struct nfp_vdpa_dev {
 	struct nfp_vdpa_hw hw;
 
 	int vfio_container_fd;
-	int vfio_group_fd;
 	int vfio_dev_fd;
-	int iommu_group;
 
 	rte_thread_t tid;    /**< Thread for notify relay */
 	int epoll_fd;
@@ -152,7 +150,6 @@ static void
 nfp_vdpa_vfio_teardown(struct nfp_vdpa_dev *device)
 {
 	rte_pci_unmap_device(device->pci_dev);
-	rte_vfio_container_group_unbind(device->vfio_container_fd, device->iommu_group);
 	rte_vfio_container_destroy(device->vfio_container_fd);
 }
 
@@ -1018,22 +1015,6 @@ nfp_vdpa_dev_close(int vid)
 	return 0;
 }
 
-static int
-nfp_vdpa_get_vfio_group_fd(int vid)
-{
-	struct rte_vdpa_device *vdev;
-	struct nfp_vdpa_dev_node *node;
-
-	vdev = rte_vhost_get_vdpa_device(vid);
-	node = nfp_vdpa_find_node_by_vdev(vdev);
-	if (node == NULL) {
-		DRV_VDPA_LOG(ERR, "Invalid vDPA device: %p.", vdev);
-		return -ENODEV;
-	}
-
-	return node->device->vfio_group_fd;
-}
-
 static int
 nfp_vdpa_get_vfio_device_fd(int vid)
 {
@@ -1185,7 +1166,6 @@ struct rte_vdpa_dev_ops nfp_vdpa_ops = {
 	.dev_close = nfp_vdpa_dev_close,
 	.set_vring_state = nfp_vdpa_set_vring_state,
 	.set_features = nfp_vdpa_set_features,
-	.get_vfio_group_fd = nfp_vdpa_get_vfio_group_fd,
 	.get_vfio_device_fd = nfp_vdpa_get_vfio_device_fd,
 	.get_notify_area = nfp_vdpa_get_notify_area,
 };
diff --git a/lib/vhost/vdpa_driver.h b/lib/vhost/vdpa_driver.h
index 42392a0d14..c7b9be09fb 100644
--- a/lib/vhost/vdpa_driver.h
+++ b/lib/vhost/vdpa_driver.h
@@ -50,9 +50,6 @@ struct rte_vdpa_dev_ops {
 	/** Destination operations when migration done */
 	int (*migration_done)(int vid);
 
-	/** Get the vfio group fd */
-	int (*get_vfio_group_fd)(int vid);
-
 	/** Get the vfio device fd */
 	int (*get_vfio_device_fd)(int vid);
 
-- 
2.47.3

