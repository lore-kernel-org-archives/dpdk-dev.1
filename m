Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FDDC98318
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 16:16:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82465432A6;
	Thu, 24 Sep 2026 18:14:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id A795B43249
 for <dev@dpdk.org>; Thu, 24 Sep 2026 18:14:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790266451; x=1821802451;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Y1ayIOaaBM1Ptgk6d4MRMxA8FD5jS6CdI5njUxTEo+o=;
 b=F2Bh7Jx7aGtiJx4KsCrvW6J41StCeSOMG3XzAtwpTypGwx9Gq7TC0Ti9
 nrpVLX6jd6QOE3cc4933fPAQRtf/Z2X7GcciMMWwBWlcYa79hGE0J9jci
 fLMbnUY3ummqjesjZmI71S9P3C5U7KnCwKbl8j34bpe6agIO631fgUINX
 HZRv0HjxcoLRgXeBeQd71NGjP03jbeBcdxUYxGbJerEuYRxleQHAeOHN/
 1ipyW2DjDtROXLedJ/9mg2nXo0w/5o/xoFiFS8Cr7QEQIzesBvCj1RKqY
 RtuNjyosj/t7n5y9e6+zkjYGJma9FkdtqdqkDsWKcoK/xTsevj3/K04Ni Q==;
X-CSE-ConnectionGUID: wK/PDwyLQo2JOIK9qn2TEg==
X-CSE-MsgGUID: yfFaMSxkT2+EYM89zSfL+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90000713"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90000713"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 09:14:11 -0700
X-CSE-ConnectionGUID: vBI9P4Z9RHOfOBG6Sh99Zg==
X-CSE-MsgGUID: +66OlUs2QqSb2F0TtkpuIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="277830079"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 24 Sep 2026 09:14:10 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v18 17/29] vdpa/ifc: use container device assignment API
Date: Thu, 24 Sep 2026 17:13:24 +0100
Message-ID: <67c3473a5bbaf6407b1c2b9195361d9dbbc7de5e.1790266166.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1790266165.git.anatoly.burakov@intel.com>
 <cover.1790266165.git.anatoly.burakov@intel.com>
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
index 36d06f1e3fb..04ed2052d34 100644
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

