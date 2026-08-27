Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62144C61DC4
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 15:16:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 996DC40B8D;
	Thu, 27 Aug 2026 17:15:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 82A2740A89
 for <dev@dpdk.org>; Thu, 27 Aug 2026 17:15:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787843704; x=1819379704;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=aIBP/kQ4TinRlz2+Nbx1px3/9IDnjb+bm6DJX1Q67Hk=;
 b=P7Q+aHeuMrJ4RrjQf/ZwnWSl5so8R3Ykc31SKZzkB4X+cLAwIc4jjsxs
 OmkpHsdHGJ3K+F7eJOBZA9z0druu1mMbzPgTQH2LEXuI3NctFKa80sS7O
 /b3xPPOfsgt3edcPHIpgTXfSJ8evGU2EGUjtgXJmLxnIoIfGMXXnkRjkG
 8Lr+O8vR6+iuryVHSSaElf3mgm6zV2yxqxdWEHjKOLiRjRgITCybFfyQc
 Dbq/IyNlm/vWuakHQw55S+g1mnL2h725kDRFGOBoxGHSWpsKoA/FFuKgj
 YAOHFq7haxK4gfnP/uzacxu3YMJFpnrbJA+ipR4JBc3yNXV7+p4fyE6iE g==;
X-CSE-ConnectionGUID: JYilj8UcRtK8reP1QnkGzA==
X-CSE-MsgGUID: ZcTghhaaQEyJKrrknWrjLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88371630"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="88371630"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 08:15:03 -0700
X-CSE-ConnectionGUID: YKZth6jXTiyrVOcYl+3WQw==
X-CSE-MsgGUID: YJS6nMSuQRuoWGaBItjI7w==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 27 Aug 2026 08:15:02 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v13 10/24] net/nbl: do not use VFIO group bind API
Date: Thu, 27 Aug 2026 16:14:13 +0100
Message-ID: <9f805de5aee6143e76f6ae0fc6becc45ad69fca2.1787843386.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787843385.git.anatoly.burakov@intel.com>
 <cover.1787843385.git.anatoly.burakov@intel.com>
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
 drivers/net/nbl/nbl_common/nbl_userdev.c  | 24 ++++++++++++++++-------
 drivers/net/nbl/nbl_include/nbl_include.h |  1 +
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/net/nbl/nbl_common/nbl_userdev.c b/drivers/net/nbl/nbl_common/nbl_userdev.c
index f1522772f5..b3b6548bb8 100644
--- a/drivers/net/nbl/nbl_common/nbl_userdev.c
+++ b/drivers/net/nbl/nbl_common/nbl_userdev.c
@@ -387,6 +387,15 @@ nbl_userdev_mem_event_callback(enum rte_mem_event type, const void *addr, size_t
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
 static int nbl_mdev_map_device(struct nbl_adapter *adapter)
 {
 	const struct rte_pci_device *pci_dev = adapter->pci_dev;
@@ -424,11 +433,16 @@ static int nbl_mdev_map_device(struct nbl_adapter *adapter)
 	}
 
 	NBL_LOG(DEBUG, "nbl vfio container %d", container);
-	vfio_group_fd = dev_vfio_container_group_bind(container, common->iommu_group_num);
+	/*
+	 * This assumes one device per group, as kernel will return -EBUSY on
+	 * attempting to open the same group fd for a different device.
+	 */
+	vfio_group_fd = nbl_open_group_fd(common->iommu_group_num);
 	if (vfio_group_fd < 0) {
 		NBL_LOG(ERR, "nbl vfio group bind failed, %d", vfio_group_fd);
 		goto free_container;
 	}
+	common->groupfd = vfio_group_fd;
 
 	/* check if the group is viable */
 	ret = ioctl(vfio_group_fd, VFIO_GROUP_GET_STATUS, &group_status);
@@ -535,7 +549,6 @@ static int nbl_mdev_map_device(struct nbl_adapter *adapter)
 	}
 free_group:
 	close(vfio_group_fd);
-	dev_vfio_clear_group(vfio_group_fd);
 free_container:
 	if (container_create)
 		dev_vfio_container_destroy(container);
@@ -550,17 +563,14 @@ static int nbl_mdev_unmap_device(struct nbl_adapter *adapter)
 	rte_mcfg_mem_read_lock();
 	TAILQ_REMOVE(&nbl_adapter_list, adapter, next);
 	close(common->devfd);
-	vfio_group_fd = dev_vfio_container_group_bind(nbl_default_container,
-						      common->iommu_group_num);
+	vfio_group_fd = common->groupfd;
 	NBL_LOG(DEBUG, "close vfio_group_fd %d", vfio_group_fd);
 	ret = ioctl(vfio_group_fd, VFIO_GROUP_UNSET_CONTAINER, &nbl_default_container);
 	if (ret)
 		NBL_LOG(ERR, "unset container, error %i (%s) %d",
 			errno, strerror(errno), ret);
 	nbl_group_count--;
-	ret = dev_vfio_container_group_unbind(nbl_default_container, common->iommu_group_num);
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
2.52.0

