Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A368CA5FF1
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 07:32:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D65674279C;
	Wed,  7 Oct 2026 09:32:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C9F51402D2
 for <dev@dpdk.org>; Wed,  7 Oct 2026 09:32:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791358336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mHELsnrg6YY2TGqow/qAuSuSzjibZzltWoX7jaPe1uU=;
 b=QQSVmslrCr5ck0hNchVz8kU7lGIRToD8rwJBoDptbYpel5R8A+YqyF2MthJZqmc/l7leeV
 G7SNARynUBH8/E+bXty3yziZpegbxkD+/mxElfsUVCEE/b0SSYVcDsnkaJL9gDRVV+FyBO
 1uAQvFDmZpJNtz9+Y4L5CEeg1ibab8g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-aD7gEKQmP92T2WTN9QCCtg-1; Wed,
 07 Oct 2026 03:32:15 -0400
X-MC-Unique: aD7gEKQmP92T2WTN9QCCtg-1
X-Mimecast-MFC-AGG-ID: aD7gEKQmP92T2WTN9QCCtg_1791358334
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38CF71954117; Wed,  7 Oct 2026 07:32:14 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CBFCE180058D; Wed,  7 Oct 2026 07:32:12 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v19 01/26] vhost: check DMA capability only once
Date: Wed,  7 Oct 2026 09:31:39 +0200
Message-ID: <20261007073206.567001-2-david.marchand@redhat.com>
In-Reply-To: <20261007073206.567001-1-david.marchand@redhat.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <20261007073206.567001-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eHvi-sK2Y_DMiE27C4_Noprb_Re7C0h3x4Nfj2aKuR0_1791358334
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

From: Anatoly Burakov <anatoly.burakov@intel.com>

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
index 0943b3e9bb..a8f58c95e8 100644
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
index bb4708aed5..75736eed3b 100644
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
index 020c993b29..2d91722fcc 100644
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
2.54.0

