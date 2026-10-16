Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD93CCCA46C
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 14:03:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42122409FA;
	Fri, 16 Oct 2026 16:02:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id A06094060F
 for <dev@dpdk.org>; Fri, 16 Oct 2026 16:02:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792159349; x=1823695349;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=iVhjvCg55ay6gaQwUNmUOjtZjghbxtfVciX9n7d1mDY=;
 b=RnryzGuREp5qMhyJMfm3Iy7iYzcT93qVLu+h6GkUbG9C8Ct8cm8rPLvY
 F9+SAGLaY6apUwp6CEaQGLVmC1Hg0LBNTbn7FPZjkemntv5f7R6KhFPEH
 VR2CHGCXw15KexxSqN6UzrisKOC5LPof2igkbDTzNV+CcLUeUa5qEx2p5
 smPWDjufbQ3gqth9Y9/PIGfs38V5m+tYvTeF+GXGE09hDSILv04Qe073F
 xg3WJMXqIrNynFiS+hhxXJNfBl/wtI7tBaedWrGqJCdWekwjrkt7rvnrH
 4WeAYDulUyC5WMsCeM18OfHPbmHcNAlg/9oe3q42Vo3a5Kfe1nL084kal g==;
X-CSE-ConnectionGUID: W0vak9zxSpOrIkq4t0VuXQ==
X-CSE-MsgGUID: 5eB70vqURZ2JchtAgd9YrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="1043678"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1043678"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 07:02:29 -0700
X-CSE-ConnectionGUID: /ru5EpKyRwi5C6A7uBZm1A==
X-CSE-MsgGUID: hk/KdwkLRnmHUcKN7baWag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1951715"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 16 Oct 2026 07:02:28 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [27.03 RFC PATCH v1 8/8] net/nbl: track devices with usage counters
Date: Fri, 16 Oct 2026 15:02:15 +0100
Message-ID: <f1a2f794044755d13a3302de5b62860f0c912b3d.1792159157.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792159157.git.anatoly.burakov@intel.com>
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

Use EAL usage counters to track VFIO device references.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/nbl/nbl_common/nbl_userdev.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/nbl/nbl_common/nbl_userdev.c b/drivers/net/nbl/nbl_common/nbl_userdev.c
index 295c617d9d..426cffbc0d 100644
--- a/drivers/net/nbl/nbl_common/nbl_userdev.c
+++ b/drivers/net/nbl/nbl_common/nbl_userdev.c
@@ -4,6 +4,8 @@
 
 #include <uapi/linux/vfio.h>
 
+#include <rte_usage_count.h>
+
 #include "nbl_userdev.h"
 #include <dev_vfio.h>
 
@@ -26,7 +28,7 @@ struct nbl_userdev_map_record {
 };
 
 static int nbl_default_container = -1;
-static int nbl_group_count;
+static rte_usage_count_t nbl_group_count;
 
 TAILQ_HEAD(nbl_adapter_list_head, nbl_adapter);
 static struct nbl_adapter_list_head nbl_adapter_list =
@@ -423,7 +425,7 @@ static int nbl_mdev_map_device(struct nbl_adapter *adapter)
 	u64 dma_limit = NBL_USERDEV_DMA_LIMIT;
 	int ret, container_create = 0, container_set = 0;
 	int vfio_group_fd, container = nbl_default_container;
-	bool new_group = false;
+	bool new_group = false, first_group = false;
 
 	rte_pci_device_name(&pci_dev->addr, dev_name, RTE_DEV_NAME_MAX_LEN);
 	snprintf(pathname, sizeof(pathname),
@@ -481,11 +483,11 @@ static int nbl_mdev_map_device(struct nbl_adapter *adapter)
 			goto free_group;
 		}
 
-		nbl_group_count++;
+		first_group = rte_usage_count_claim(&nbl_group_count);
 		container_set = 1;
 		/* set an IOMMU type for container */
 
-		if (container_create || nbl_group_count == 1) {
+		if (container_create || first_group) {
 			if (ioctl(container, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU)) {
 				ret = ioctl(container, VFIO_SET_IOMMU, VFIO_TYPE1v2_IOMMU);
 				if (ret) {
@@ -548,13 +550,13 @@ static int nbl_mdev_map_device(struct nbl_adapter *adapter)
 close_fd:
 	close(common->devfd);
 unregister_mem_event:
-	if (container_set && nbl_group_count == 1) {
+	if (first_group) {
 		rte_mcfg_mem_read_lock();
 		rte_mem_event_callback_unregister(NBL_USERDEV_EVENT_CLB_NAME, NULL);
 		rte_mcfg_mem_read_unlock();
 	}
 free_dma_map:
-	if (container_set && nbl_group_count == 1) {
+	if (first_group) {
 		rte_mcfg_mem_read_lock();
 		nbl_userdev_dma_free();
 		rte_mcfg_mem_read_unlock();
@@ -562,7 +564,7 @@ static int nbl_mdev_map_device(struct nbl_adapter *adapter)
 unset_container:
 	if (container_set) {
 		ioctl(vfio_group_fd, VFIO_GROUP_UNSET_CONTAINER, &container);
-		nbl_group_count--;
+		rte_usage_count_release(&nbl_group_count);
 	}
 free_group:
 	if (new_group)
@@ -577,7 +579,7 @@ static int nbl_mdev_unmap_device(struct nbl_adapter *adapter)
 {
 	struct nbl_common_info *common = &adapter->common;
 	int vfio_group_fd, ret;
-	bool last_group_user;
+	bool last_group_user, last_group = false;
 
 	rte_mcfg_mem_read_lock();
 	TAILQ_REMOVE(&nbl_adapter_list, adapter, next);
@@ -591,11 +593,11 @@ static int nbl_mdev_unmap_device(struct nbl_adapter *adapter)
 		if (ret)
 			NBL_LOG(ERR, "unset container, error %i (%s) %d",
 				errno, strerror(errno), ret);
-		nbl_group_count--;
+		last_group = rte_usage_count_release(&nbl_group_count);
 		close(vfio_group_fd);
 		common->groupfd = -1;
 	}
-	if (!nbl_group_count) {
+	if (last_group) {
 		rte_mem_event_callback_unregister(NBL_USERDEV_EVENT_CLB_NAME, NULL);
 		nbl_userdev_dma_free();
 	}
-- 
2.52.0

