Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBE1C79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 12:54:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3850242D83;
	Thu, 10 Sep 2026 14:53:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 71E3842D76
 for <dev@dpdk.org>; Thu, 10 Sep 2026 14:53:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789044819; x=1820580819;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=bdfIsMWbl7UhxzFEBVFtuA/VY4UXSDhxGhCQbGRtzdo=;
 b=SWHY/QXfZ4qEXBCKCnXP1YTfXSarkHbJ/AFoTN/1WGvlt7ESrdPOnGtR
 /kSTZo5Psr62QNcqmTdTytH8Qd+bRvZzsaNx4h9pxkBNr1Y7cqBSUU8Fj
 /iZG3Pnd4+9N+7c7fwqTdDRBfP/oSapJlZN8HYpC1xObKpz48Ma9jOcaR
 IsVqySEKtWd+iSxpBCAR0+VxBYx5e9+ngDVtb4M4KdSyRB3Ir7i9QZPFz
 dXxnwXGj2wxavubeRKTQPdOwk6vgDmx0Tblw010OfQLV8JKHwYzK1tHa8
 8sfCy9KuKmAvg4DJmQfoCpYO+UtT3CmoGmgzgy+MZSpt4IaYii44AMW7d g==;
X-CSE-ConnectionGUID: 4ntQDb4dSyOgpb/dcIIAKQ==
X-CSE-MsgGUID: +FFnkSumSfSq9g7Y5EMmvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89334062"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89334062"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 05:53:39 -0700
X-CSE-ConnectionGUID: gPgkSA0LSVqGH9vgDHF83g==
X-CSE-MsgGUID: HwtyNIOcTBSmK7grOZlO3Q==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 10 Sep 2026 05:53:38 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v17 12/26] net/nbl: do not use VFIO group bind API
Date: Thu, 10 Sep 2026 13:52:56 +0100
Message-ID: <81c76e8b271a9f60027f3b28b499788a3fd36eb8.1789044747.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1789044746.git.anatoly.burakov@intel.com>
 <cover.1789044746.git.anatoly.burakov@intel.com>
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
index f1522772f5..66ec8a69af 100644
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
index 2221e19c67..1ebc86baf6 100644
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
index eeae6a3301..ba99b9f8e7 100644
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

