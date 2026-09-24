Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6892AC98318
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 16:14:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E16E43007;
	Thu, 24 Sep 2026 18:13:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 5882342FED
 for <dev@dpdk.org>; Thu, 24 Sep 2026 18:13:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790266433; x=1821802433;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=jpEoOWWe5OhIbqd2AhyUL+r1n4qUnA/lIB9EDkijTFk=;
 b=BwbUROTRXkNqJo6N+1b1c1oqlp3UgSHy0nXoeT1YbmzYtKHxSEVlisK2
 Da8qJfm0W11R8iICtUGAl+OoPg9voIggAEBqEtPVV2RF0vW7bgWIjOLZ9
 it7La3Ui54YgRpb2lFbSDPUOi+7YB0IAJM8Y2CFz7wTlXfuau2y2012dw
 o4+BK9GQDHkXbgd2JZloftTH86Vuy2o2GJ6NGYXRXjkmNGtOcAfruYT/8
 F0pteLe3xaw+rZAgr+4pb2Ky8/05vnnfLebaclNMXfa5xdvLs6loA7qFu
 FGgEt1z2uIAzB6h1ugQDi6raGV4qNWg+vQKG1K+C3ut3aSrFekCk06ddk A==;
X-CSE-ConnectionGUID: dmFRDRyBQU6/ohUH4HZ2mQ==
X-CSE-MsgGUID: mRO/KA1jRduIqRUS5NzsFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90000623"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90000623"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 09:13:52 -0700
X-CSE-ConnectionGUID: E7ev3zPARNuTmdClXoyURw==
X-CSE-MsgGUID: BKcrnVzdSDS2W7aAxKAhiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="277829976"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 24 Sep 2026 09:13:52 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v18 05/29] vhost: check DMA capability only once
Date: Thu, 24 Sep 2026 17:13:12 +0100
Message-ID: <166a75f92f9272cc97cd5cb34056c44b2f3dfcff.1790266166.git.anatoly.burakov@intel.com>
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

Currently, vhost async copy feature will check if VFIO supports DMA mapping
on every attempt to add/remove memory region or set memory table. This is
not necessary, so instead check this once at new vhost connection, and
store that value for future use.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/vhost/socket.c     |  5 ++++-
 lib/vhost/vhost.h      |  1 +
 lib/vhost/vhost_user.c | 10 +++++-----
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
index 0943b3e9bb6..a8f58c95e83 100644
--- a/lib/vhost/socket.c
+++ b/lib/vhost/socket.c
@@ -17,6 +17,7 @@
 #include <eal_export.h>
 #include <rte_thread.h>
 #include <rte_log.h>
+#include <rte_vfio.h>
 
 #include "fd_man.h"
 #include "vduse.h"
@@ -242,8 +243,10 @@ vhost_user_add_connection(int fd, struct vhost_user_socket *vsocket)
 	if (vsocket->async_copy) {
 		dev = get_device(vid);
 
-		if (dev)
+		if (dev != NULL) {
 			dev->async_copy = 1;
+			dev->dma_map_available = rte_vfio_is_enabled("vfio");
+		}
 	}
 
 	VHOST_CONFIG_LOG(vsocket->path, INFO, "new device, handle is %d", vid);
diff --git a/lib/vhost/vhost.h b/lib/vhost/vhost.h
index bb4708aed5e..75736eed3b5 100644
--- a/lib/vhost/vhost.h
+++ b/lib/vhost/vhost.h
@@ -499,6 +499,7 @@ struct __rte_cache_aligned virtio_net {
 	RTE_ATOMIC(int16_t)	broadcast_rarp;
 	uint32_t		nr_vring;
 	int			async_copy;
+	bool			dma_map_available;
 
 	int			extbuf;
 	int			linearbuf;
diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 020c993b299..2d91722fcc0 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -267,7 +267,7 @@ free_all_mem_regions(struct virtio_net *dev)
 	if (!dev || !dev->mem)
 		return;
 
-	if (dev->async_copy && rte_vfio_is_enabled("vfio"))
+	if (dev->async_copy && dev->dma_map_available)
 		async_dma_map(dev, false);
 
 	for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
@@ -1564,7 +1564,7 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
 		dev->mem->nregions++;
 	}
 
-	if (dev->async_copy && rte_vfio_is_enabled("vfio"))
+	if (dev->async_copy && dev->dma_map_available)
 		async_dma_map(dev, true);
 
 	if (vhost_user_postcopy_register(dev, main_fd, ctx) < 0)
@@ -1750,7 +1750,7 @@ vhost_user_add_mem_reg(struct virtio_net **pdev,
 
 	dev->mem->nregions++;
 
-	if (dev->async_copy && rte_vfio_is_enabled("vfio")) {
+	if (dev->async_copy && dev->dma_map_available) {
 		if (async_dma_map_region(dev, reg, true) < 0)
 			goto free_new_region_no_dma;
 	}
@@ -1791,7 +1791,7 @@ vhost_user_add_mem_reg(struct virtio_net **pdev,
 	return RTE_VHOST_MSG_RESULT_OK;
 
 free_new_region:
-	if (dev->async_copy && rte_vfio_is_enabled("vfio"))
+	if (dev->async_copy && dev->dma_map_available)
 		async_dma_map_region(dev, reg, false);
 free_new_region_no_dma:
 	remove_guest_pages(dev, reg);
@@ -1827,7 +1827,7 @@ vhost_user_rem_mem_reg(struct virtio_net **pdev,
 		if (region->userspace_addr == current_region->guest_user_addr
 			&& region->guest_phys_addr == current_region->guest_phys_addr
 			&& region->memory_size == current_region->size) {
-			if (dev->async_copy && rte_vfio_is_enabled("vfio"))
+			if (dev->async_copy && dev->dma_map_available)
 				async_dma_map_region(dev, current_region, false);
 			if (dev->features & (1ULL << VIRTIO_F_IOMMU_PLATFORM))
 				vhost_user_iotlb_cache_remove(dev,
-- 
2.52.0

