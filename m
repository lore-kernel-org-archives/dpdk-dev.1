Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BABFC61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 13:08:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E28D406BC;
	Fri, 28 Aug 2026 15:07:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id DA61340A6D
 for <dev@dpdk.org>; Fri, 28 Aug 2026 15:07:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787922444; x=1819458444;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=aIBP/kQ4TinRlz2+Nbx1px3/9IDnjb+bm6DJX1Q67Hk=;
 b=H8VRSidF9oB4AAcNOxOPCfQ5M0S3yfJZn6W7bmCaH068QTPOInjPNssY
 P8Bk9Uap75yGIgM75lUs4hX9T+X8oXSkCjY9vqRAuoyr9fy94ihNxN09I
 apYcV6HJg4VT+3IXLD/K+oJq7kXFJ7xCIp18Afol7Ql5yo0KRnlKdAG6n
 hEU68FXd/QWJmhlgxVmzwPezx9tO+KqM7RK38vP2U11he1ftTJWY03+lv
 xTnK1iAIEI75VG12cYDkCVab9N5qHhgD5oiEBJNjKIpzbJgHG2NJ6Sz3X
 p9DAfAzyfrqUOnEnhfXxjSM0Gba5BEkwt7Zx8cxu3XIHb6t/z90jsJrgl g==;
X-CSE-ConnectionGUID: qmO+f0TzTa6mvW2o9MA5Ig==
X-CSE-MsgGUID: nSARP8azTCe3k8bUVWET5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="113964589"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="113964589"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 06:07:23 -0700
X-CSE-ConnectionGUID: 8j2Yt6hzTxClkkuUE1N2+w==
X-CSE-MsgGUID: 22jGAgQ0QgasnATGSLtWVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="271959924"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 28 Aug 2026 06:07:22 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v14 11/25] net/nbl: do not use VFIO group bind API
Date: Fri, 28 Aug 2026 14:06:39 +0100
Message-ID: <4f9c9b5df6ce0b8404465c8e6ac68b2bc1f5e5c5.1787922363.git.anatoly.burakov@intel.com>
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

