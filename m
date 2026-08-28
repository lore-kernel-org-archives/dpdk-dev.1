Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F58AC61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 13:08:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC0AA40B8C;
	Fri, 28 Aug 2026 15:07:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id BE68D40A82
 for <dev@dpdk.org>; Fri, 28 Aug 2026 15:07:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787922446; x=1819458446;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=zXDjrUKkKuMUNdxBv/pQ/lnkrYufAu91WzhxK4ifr9I=;
 b=e8ZK5LB/DELQ/HYK5rARaMSEA0hUXAQfVhqVY/Ck3bOGQKryxs6RMomr
 Qee79HY9tXXvajo1YRAsUfGQpDQbdMMOGXjtgGkpZUVRCUOHR9WaTV2II
 wgmnQzZiCSFNWXyJYWL7S3LN1PL4D2wM0GDjxz0RHVeuT21dYieVXnJRo
 7+C1+phJn9WCCOXc1IeX2pGIVW1NKy5K7cTqeawRpnZbl/HuDSKsSM1uf
 hEPiAuuxPClzBNUVVFza93dOO3CiOmgYqfPTfmJgqWrb97kJGIImvJMck
 FLOsYs0rxB1eFw7hEXJ2Mltlzok+kKqCiQqHxQuQ8vwp4VqVkh9s1gjlg w==;
X-CSE-ConnectionGUID: RML5BNz3SomUnBXK9xTfDA==
X-CSE-MsgGUID: 4jbDPgVxS1uNIL9erfRmvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="113964596"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="113964596"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 06:07:25 -0700
X-CSE-ConnectionGUID: sd4mNd/WTWCGpvvOmvw+tg==
X-CSE-MsgGUID: DQD+VtICTSG81UGVqX1oDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="271959938"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 28 Aug 2026 06:07:25 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v14 13/25] vdpa/ifc: use container device assignment API
Date: Fri, 28 Aug 2026 14:06:41 +0100
Message-ID: <d0892f481255687d141f427313cee4c30cff88ae.1787922363.git.anatoly.burakov@intel.com>
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

The IFC vDPA driver uses VFIO group bind/unbind functionality for container
device assignment purposes. Use the new container device assignment API
instead to provide clearer semantics. Since group API is no longer used
after these changes, remove its implementation.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/vdpa/ifc/ifcvf_vdpa.c | 34 +++-------------------------------
 1 file changed, 3 insertions(+), 31 deletions(-)

diff --git a/drivers/vdpa/ifc/ifcvf_vdpa.c b/drivers/vdpa/ifc/ifcvf_vdpa.c
index 36d06f1e3f..04ed2052d3 100644
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
@@ -174,28 +173,19 @@ ifcvf_vfio_setup(struct ifcvf_internal *internal)
 {
 	struct rte_pci_device *dev = internal->pdev;
 	char devname[RTE_DEV_NAME_MAX_LEN] = {0};
-	int iommu_group_num;
-	int i, ret;
+	int i;
 
 	internal->vfio_dev_fd = -1;
-	internal->vfio_group_fd = -1;
 	internal->vfio_container_fd = -1;
 
 	rte_pci_device_name(&dev->addr, devname, RTE_DEV_NAME_MAX_LEN);
-	ret = dev_vfio_get_group_num(rte_pci_get_sysfs_path(), devname,
-			&iommu_group_num);
-	if (ret <= 0) {
-		DRV_LOG(ERR, "%s failed to get IOMMU group", devname);
-		return -1;
-	}
 
 	internal->vfio_container_fd = dev_vfio_container_create();
 	if (internal->vfio_container_fd < 0)
 		return -1;
 
-	internal->vfio_group_fd = dev_vfio_container_group_bind(
-			internal->vfio_container_fd, iommu_group_num);
-	if (internal->vfio_group_fd < 0)
+	if (dev_vfio_container_assign_device(internal->vfio_container_fd,
+			rte_pci_get_sysfs_path(), devname) < 0)
 		goto err;
 
 	if (rte_pci_map_device(dev))
@@ -1213,22 +1203,6 @@ ifcvf_set_features(int vid)
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
@@ -1474,7 +1448,6 @@ static struct rte_vdpa_dev_ops ifcvf_net_ops = {
 	.set_vring_state = ifcvf_set_vring_state,
 	.set_features = ifcvf_set_features,
 	.migration_done = NULL,
-	.get_vfio_group_fd = ifcvf_get_vfio_group_fd,
 	.get_vfio_device_fd = ifcvf_get_vfio_device_fd,
 	.get_notify_area = ifcvf_get_notify_area,
 	.get_dev_type = ifcvf_get_device_type,
@@ -1605,7 +1578,6 @@ static struct rte_vdpa_dev_ops ifcvf_blk_ops = {
 	.dev_close = ifcvf_dev_close,
 	.set_vring_state = ifcvf_set_vring_state,
 	.migration_done = NULL,
-	.get_vfio_group_fd = ifcvf_get_vfio_group_fd,
 	.get_vfio_device_fd = ifcvf_get_vfio_device_fd,
 	.get_notify_area = ifcvf_get_notify_area,
 	.get_config = ifcvf_blk_get_config,
-- 
2.52.0

