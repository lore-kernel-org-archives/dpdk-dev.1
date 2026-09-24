Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEF5C9830E
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 16:15:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C8154326C;
	Thu, 24 Sep 2026 18:14:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 7E875432B0
 for <dev@dpdk.org>; Thu, 24 Sep 2026 18:14:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790266449; x=1821802449;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=GhdSlG3c0kRL3GQmIFzd/EktjMGZ0srms0Zglcmgwdw=;
 b=KKiLDOtK0w5Sff3nuEeQsgFK0hIIY6u5SIxDNzsdkjPTt1CfBYY/T2Ir
 zqRZchUwyENim5+D1387VMT5aGLetRcJIZEn+uOyy/WjQ+6DyZgPvOTnX
 /Lx9LS9crLB0lT+Eq90+Fa40kViCZqk98P+LZZYmqhZ92tgQbQg0BXtUk
 U0lo7XxcicApIfOKIVgDeCPCM7Fp02TiZQFgE8LdoGVxMFsrq1Hdzsjqj
 hNu96u35tSNAnnwvmd9UtcyqGuGTng+5d+c5Q5GkHYK8wWN29yySTafr6
 UlE4NTgvOciiIUYnuaiNvcctX5uNAzj5iP+7hI/hM6TqAX6m4Nvg4UoKE Q==;
X-CSE-ConnectionGUID: Mn/CeN8wSDW0b1t3qIe8GA==
X-CSE-MsgGUID: H1LnazDrTL2CUEhhJCuGZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90000702"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90000702"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 09:14:09 -0700
X-CSE-ConnectionGUID: Sinzc475QIagX8nB9S+KpA==
X-CSE-MsgGUID: BQF78OcZTe6RmzWYT0e2fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="277830059"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 24 Sep 2026 09:14:07 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v18 15/29] net/nbl: do not use VFIO group bind API
Date: Thu, 24 Sep 2026 17:13:22 +0100
Message-ID: <bd9a6fc9452a271fac30340aae48449fbeb9798c.1790266166.git.anatoly.burakov@intel.com>
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

The NBL driver currently uses group bind API, but it is using it only to
get group fd and nothing else. In context of NBL driver, this is the only
usage of VFIO API's in the driver, and it is not necessary to use it for
what NBL driver is trying to accomplish.

Use a direct `open()` call instead, store the group fd in common structure,
and find group fd's opened earlier to prevent us from opening the same
group fd twice.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/nbl/nbl_common/nbl_userdev.c  | 63 +++++++++++++++++------
 drivers/net/nbl/nbl_common/nbl_userdev.h  |  1 +
 drivers/net/nbl/nbl_include/nbl_include.h |  1 +
 3 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/drivers/net/nbl/nbl_common/nbl_userdev.c b/drivers/net/nbl/nbl_common/nbl_userdev.c
index f1522772f5b..66ec8a69afd 100644
--- a/drivers/net/nbl/nbl_common/nbl_userdev.c
+++ b/drivers/net/nbl/nbl_common/nbl_userdev.c
@@ -387,6 +387,28 @@ nbl_userdev_mem_event_callback(enum rte_mem_event type, const void *addr, size_t
 	}
 }
 
+static int
+nbl_open_group_fd(int iommu_group_num)
+{
+	char path[PATH_MAX];
+
+	snprintf(path, sizeof(path), DEV_VFIO_GROUP_FMT, iommu_group_num);
+	return open(path, O_RDWR);
+}
+
+static int
+nbl_find_group_fd(int iommu_group_num)
+{
+	struct nbl_adapter *adapter;
+
+	TAILQ_FOREACH(adapter, &nbl_adapter_list, next) {
+		if (adapter->common.iommu_group_num == iommu_group_num)
+			return adapter->common.groupfd;
+	}
+
+	return -1;
+}
+
 static int nbl_mdev_map_device(struct nbl_adapter *adapter)
 {
 	const struct rte_pci_device *pci_dev = adapter->pci_dev;
@@ -400,6 +422,7 @@ static int nbl_mdev_map_device(struct nbl_adapter *adapter)
 	u64 dma_limit = NBL_USERDEV_DMA_LIMIT;
 	int ret, container_create = 0, container_set = 0;
 	int vfio_group_fd, container = nbl_default_container;
+	bool new_group = false;
 
 	rte_pci_device_name(&pci_dev->addr, dev_name, RTE_DEV_NAME_MAX_LEN);
 	snprintf(pathname, sizeof(pathname),
@@ -424,11 +447,18 @@ static int nbl_mdev_map_device(struct nbl_adapter *adapter)
 	}
 
 	NBL_LOG(DEBUG, "nbl vfio container %d", container);
-	vfio_group_fd = dev_vfio_container_group_bind(container, common->iommu_group_num);
+	rte_mcfg_mem_read_lock();
+	vfio_group_fd = nbl_find_group_fd(common->iommu_group_num);
+	rte_mcfg_mem_read_unlock();
+	if (vfio_group_fd < 0) {
+		vfio_group_fd = nbl_open_group_fd(common->iommu_group_num);
+		new_group = true;
+	}
 	if (vfio_group_fd < 0) {
 		NBL_LOG(ERR, "nbl vfio group bind failed, %d", vfio_group_fd);
 		goto free_container;
 	}
+	common->groupfd = vfio_group_fd;
 
 	/* check if the group is viable */
 	ret = ioctl(vfio_group_fd, VFIO_GROUP_GET_STATUS, &group_status);
@@ -517,13 +547,13 @@ static int nbl_mdev_map_device(struct nbl_adapter *adapter)
 close_fd:
 	close(common->devfd);
 unregister_mem_event:
-	if (nbl_group_count == 1) {
+	if (container_set && nbl_group_count == 1) {
 		rte_mcfg_mem_read_lock();
 		rte_mem_event_callback_unregister(NBL_USERDEV_EVENT_CLB_NAME, NULL);
 		rte_mcfg_mem_read_unlock();
 	}
 free_dma_map:
-	if (nbl_group_count == 1) {
+	if (container_set && nbl_group_count == 1) {
 		rte_mcfg_mem_read_lock();
 		nbl_userdev_dma_free();
 		rte_mcfg_mem_read_unlock();
@@ -534,8 +564,8 @@ static int nbl_mdev_map_device(struct nbl_adapter *adapter)
 		nbl_group_count--;
 	}
 free_group:
-	close(vfio_group_fd);
-	dev_vfio_clear_group(vfio_group_fd);
+	if (new_group)
+		close(vfio_group_fd);
 free_container:
 	if (container_create)
 		dev_vfio_container_destroy(container);
@@ -546,21 +576,24 @@ static int nbl_mdev_unmap_device(struct nbl_adapter *adapter)
 {
 	struct nbl_common_info *common = &adapter->common;
 	int vfio_group_fd, ret;
+	bool last_group_user;
 
 	rte_mcfg_mem_read_lock();
 	TAILQ_REMOVE(&nbl_adapter_list, adapter, next);
 	close(common->devfd);
-	vfio_group_fd = dev_vfio_container_group_bind(nbl_default_container,
-						      common->iommu_group_num);
+	common->devfd = -1;
+	vfio_group_fd = common->groupfd;
+	last_group_user = nbl_find_group_fd(common->iommu_group_num) < 0;
 	NBL_LOG(DEBUG, "close vfio_group_fd %d", vfio_group_fd);
-	ret = ioctl(vfio_group_fd, VFIO_GROUP_UNSET_CONTAINER, &nbl_default_container);
-	if (ret)
-		NBL_LOG(ERR, "unset container, error %i (%s) %d",
-			errno, strerror(errno), ret);
-	nbl_group_count--;
-	ret = dev_vfio_container_group_unbind(nbl_default_container, common->iommu_group_num);
-	if (ret)
-		NBL_LOG(ERR, "vfio container group unbind failed %d", ret);
+	if (last_group_user) {
+		ret = ioctl(vfio_group_fd, VFIO_GROUP_UNSET_CONTAINER, &nbl_default_container);
+		if (ret)
+			NBL_LOG(ERR, "unset container, error %i (%s) %d",
+				errno, strerror(errno), ret);
+		nbl_group_count--;
+		close(vfio_group_fd);
+		common->groupfd = -1;
+	}
 	if (!nbl_group_count) {
 		rte_mem_event_callback_unregister(NBL_USERDEV_EVENT_CLB_NAME, NULL);
 		nbl_userdev_dma_free();
diff --git a/drivers/net/nbl/nbl_common/nbl_userdev.h b/drivers/net/nbl/nbl_common/nbl_userdev.h
index 2221e19c67c..1ebc86baf69 100644
--- a/drivers/net/nbl/nbl_common/nbl_userdev.h
+++ b/drivers/net/nbl/nbl_common/nbl_userdev.h
@@ -11,6 +11,7 @@
 #define NBL_USERDEV_INIT_COMMON(common) do {		\
 	typeof(common) _comm = (common);		\
 	_comm->devfd = -1;				\
+	_comm->groupfd = -1;				\
 	_comm->eventfd = -1;				\
 	_comm->specific_dma = false;			\
 	_comm->dma_set_msb = false;			\
diff --git a/drivers/net/nbl/nbl_include/nbl_include.h b/drivers/net/nbl/nbl_include/nbl_include.h
index eeae6a33013..ba99b9f8e7a 100644
--- a/drivers/net/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/nbl/nbl_include/nbl_include.h
@@ -132,6 +132,7 @@ struct nbl_common_info {
 	u16 vsi_id;
 	u16 instance_id;
 	int devfd;
+	int groupfd;
 	int eventfd;
 	int ifindex;
 	int iommu_group_num;
-- 
2.52.0

