Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D22CF319D
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 11:09:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D41F840676;
	Wed, 19 Nov 2025 12:08:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 54CD340674
 for <dev@dpdk.org>; Wed, 19 Nov 2025 12:08:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763550512; x=1795086512;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=39M1/n/KN41wLZSIXRYjlxUFoqjpbUCv97/sBD+e/k8=;
 b=QTqttDEKNJYl6uhvejioe2hDK5hnGau2XB99TCHZDJlcAgtl+ViQB3gk
 xI1SzO0aAw6NKJu6xFU90UKEVxD6fD9452NP6OjU0UVg4ubGSixsA6rGE
 SRfyw9M5Fg3M38HFz5c8a9OYCdvVZ5uZrYpCzvRbwT0vIozMA2C/lQrlZ
 tgX66gRxy2ZlXCbdRc77CXJA2OwD+l6ya83BA0njGHZ3knAw4Mr7th1i+
 yHJA9PseWjkJ8EFBfzcxeTxxA8d+dl+cSqfa1cR0L0VsZfrBT78E0vOyO
 f4HVEJtUP2SM67lS26znRHlHlVqWCUWDqW2khC/dGBufdebP+i9dlWxBU A==;
X-CSE-ConnectionGUID: wtIqH0T1TyOuNmpxTQOfbQ==
X-CSE-MsgGUID: 4Z7cAc7FQqmfSo9gATKQ8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65744950"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="65744950"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 03:08:31 -0800
X-CSE-ConnectionGUID: sI+cq/4mTW2RhZ/zdHWxQw==
X-CSE-MsgGUID: eVcLBWB0Su+vf60ocJMS7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="191158186"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 19 Nov 2025 03:08:29 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v5 05/18] net/nbl: do not use VFIO group bind API
Date: Wed, 19 Nov 2025 11:08:03 +0000
Message-ID: <1358d50af918b536270b9e536e6fd7394d00d92c.1763550470.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763550469.git.anatoly.burakov@intel.com>
 <cover.1763550469.git.anatoly.burakov@intel.com>
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

Use a direct `open()` call instead, and store the group fd in common
structure.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/nbl/nbl_common/nbl_userdev.c  | 18 +++++++++++-------
 drivers/net/nbl/nbl_include/nbl_include.h |  1 +
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/nbl/nbl_common/nbl_userdev.c b/drivers/net/nbl/nbl_common/nbl_userdev.c
index 566f3a11ee..d641ecd9a8 100644
--- a/drivers/net/nbl/nbl_common/nbl_userdev.c
+++ b/drivers/net/nbl/nbl_common/nbl_userdev.c
@@ -387,6 +387,13 @@ nbl_userdev_mem_event_callback(enum rte_mem_event type, const void *addr, size_t
 	}
 }
 
+static int nbl_open_group_fd(int iommu_group_num)
+{
+	char path[PATH_MAX];
+	snprintf(path, sizeof(path), RTE_VFIO_GROUP_FMT, iommu_group_num);
+	return open(path, O_RDWR);
+}
+
 static int nbl_mdev_map_device(struct nbl_adapter *adapter)
 {
 	const struct rte_pci_device *pci_dev = adapter->pci_dev;
@@ -424,11 +431,12 @@ static int nbl_mdev_map_device(struct nbl_adapter *adapter)
 	}
 
 	NBL_LOG(DEBUG, "nbl vfio container %d", container);
-	vfio_group_fd = rte_vfio_container_group_bind(container, common->iommu_group_num);
+	vfio_group_fd = nbl_open_group_fd(common->iommu_group_num);
 	if (vfio_group_fd < 0) {
 		NBL_LOG(ERR, "nbl vfio group bind failed, %d", vfio_group_fd);
 		goto free_container;
 	}
+	common->groupfd = vfio_group_fd;
 
 	/* check if the group is viable */
 	ret = ioctl(vfio_group_fd, VFIO_GROUP_GET_STATUS, &group_status);
@@ -535,7 +543,6 @@ static int nbl_mdev_map_device(struct nbl_adapter *adapter)
 	}
 free_group:
 	close(vfio_group_fd);
-	rte_vfio_clear_group(vfio_group_fd);
 free_container:
 	if (container_create)
 		rte_vfio_container_destroy(container);
@@ -549,17 +556,14 @@ static int nbl_mdev_unmap_device(struct nbl_adapter *adapter)
 
 	close(common->devfd);
 	rte_mcfg_mem_read_lock();
-	vfio_group_fd = rte_vfio_container_group_bind(nbl_default_container,
-						      common->iommu_group_num);
+	vfio_group_fd = common->groupfd;
 	NBL_LOG(DEBUG, "close vfio_group_fd %d", vfio_group_fd);
 	ret = ioctl(vfio_group_fd, VFIO_GROUP_UNSET_CONTAINER, &nbl_default_container);
 	if (ret)
 		NBL_LOG(ERR, "unset container, error %i (%s) %d",
 			errno, strerror(errno), ret);
 	nbl_group_count--;
-	ret = rte_vfio_container_group_unbind(nbl_default_container, common->iommu_group_num);
-	if (ret)
-		NBL_LOG(ERR, "vfio container group unbind failed %d", ret);
+	close(vfio_group_fd);
 	if (!nbl_group_count) {
 		rte_mem_event_callback_unregister(NBL_USERDEV_EVENT_CLB_NAME, NULL);
 		nbl_userdev_dma_free();
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
2.47.3

