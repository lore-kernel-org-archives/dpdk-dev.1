Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE3AC2A09B
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 14:47:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8612F40DC9;
	Fri,  7 Aug 2026 16:46:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id E3C0140BA6
 for <dev@dpdk.org>; Fri,  7 Aug 2026 16:46:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786114006; x=1817650006;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=/Qcs8eqdeQmDnWmqPkEeLMMUF9OB6eBcQ2Y+ycOQ3NU=;
 b=BllSBxkBa+wjxfS3Yu2jvq63d4S6Ji/t6TX9W/eRhrEDhZZk1Te7c+4Q
 qVCid1qw3lZywmenpkcNfN0RkUm7HUAzEAS66gIDSzvc/f7h0Zkrjoo6w
 +BzQ82XtEAMhivwXkzIJGXb9/G7dl4wDrUg7wC5/IaeTsiWeo6hau6E50
 J09k8RNAZw/YgcU/dqhL8zyBmy2JSkE13mjCGNM9a+EOG/nbwcsqNz009
 EA87NCdEz+PTbIKp1dPobeeazMkmzqRVUjxhbZ45kjDMVMq6v7HmkchEf
 J1Xun9c2ioykGpV/k8y1kcbffVcLitFzkuH3p6+hXkVbg94gAOS9OYtDG Q==;
X-CSE-ConnectionGUID: oZD7KwBlStCKcf7c8ZUCdw==
X-CSE-MsgGUID: qbZ4CuC0R8OzBdCS1TIQXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="104257311"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="104257311"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 07:46:45 -0700
X-CSE-ConnectionGUID: NGMC9U+uSxm95OWs0pK6VA==
X-CSE-MsgGUID: JF+WKC3vQemL/QhVA9chJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="300623263"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 07 Aug 2026 07:46:44 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v11 06/20] net/nbl: do not use VFIO group bind API
Date: Fri,  7 Aug 2026 15:46:15 +0100
Message-ID: <f6f8f3ff576fda345300b77bfb033160e950f56d.1786113800.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1786113799.git.anatoly.burakov@intel.com>
 <cover.1786113799.git.anatoly.burakov@intel.com>
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
 drivers/net/nbl/nbl_common/nbl_userdev.c  | 20 +++++++++++++-------
 drivers/net/nbl/nbl_include/nbl_include.h |  1 +
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/nbl/nbl_common/nbl_userdev.c b/drivers/net/nbl/nbl_common/nbl_userdev.c
index 96f0d2e264..54326e44e1 100644
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
+	snprintf(path, sizeof(path), RTE_VFIO_GROUP_FMT, iommu_group_num);
+	return open(path, O_RDWR);
+}
+
 static int nbl_mdev_map_device(struct nbl_adapter *adapter)
 {
 	const struct rte_pci_device *pci_dev = adapter->pci_dev;
@@ -424,11 +433,12 @@ static int nbl_mdev_map_device(struct nbl_adapter *adapter)
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
@@ -535,7 +545,6 @@ static int nbl_mdev_map_device(struct nbl_adapter *adapter)
 	}
 free_group:
 	close(vfio_group_fd);
-	rte_vfio_clear_group(vfio_group_fd);
 free_container:
 	if (container_create)
 		rte_vfio_container_destroy(container);
@@ -549,17 +558,14 @@ static int nbl_mdev_unmap_device(struct nbl_adapter *adapter)
 
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
2.52.0

