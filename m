Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DEEC531F7
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 15:31:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D05CF40A72;
	Thu, 23 Jul 2026 17:31:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E893240A6C
 for <dev@dpdk.org>; Thu, 23 Jul 2026 17:31:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784820688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DGltkQwE9tdyYAb7gr6cY6timJ7BCIPfzqoccgK1J6Y=;
 b=JQkw7THO3gkoBRDpzPg21hEdY+qgXEIWEAIlZGLJAJ/yWP7LSnkee7eieuYOMxEa4V21le
 Tjg+PWeLZvYzcn1uRecfOw9agi0Sp2FhaqwhAWfbpzewPoxcbzTGTpm1G55o/uDB4/Ka0n
 aFjeysWPxl0lUAnLJKMaFZtDQfaqIW0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-bLN8amI9MzCdUqJUIMKlkg-1; Thu,
 23 Jul 2026 11:31:26 -0400
X-MC-Unique: bLN8amI9MzCdUqJUIMKlkg-1
X-Mimecast-MFC-AGG-ID: bLN8amI9MzCdUqJUIMKlkg_1784820686
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9429195DE47; Thu, 23 Jul 2026 15:31:25 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ACECF158B; Thu, 23 Jul 2026 15:31:24 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: maxime.coquelin@redhat.com,
	dev@dpdk.org
Cc: Chenbo Xia <chenbox@nvidia.com>
Subject: [RFC 2/3] vhost: refuse async datapath
Date: Thu, 23 Jul 2026 17:31:09 +0200
Message-ID: <20260723153111.3943368-3-david.marchand@redhat.com>
In-Reply-To: <20260723153111.3943368-1-david.marchand@redhat.com>
References: <20260723153111.3943368-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j6PudvDVJ1LIcmfh0Ns662G6TbuJk5WRO-HJJAXgRao_1784820686
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

As a first step for dropping the whole feature, refuse initialisation
when RTE_VHOST_USER_ASYNC_COPY is passed.

This is mainly make more visible those changes and isolate them from
dropping all the code in the next commit.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 doc/guides/prog_guide/vhost_lib.rst    |  15 --
 doc/guides/rel_notes/release_26_11.rst |   7 +
 lib/vhost/rte_vhost.h                  |   2 +-
 lib/vhost/socket.c                     |  27 +---
 lib/vhost/vhost_user.c                 | 210 +------------------------
 5 files changed, 17 insertions(+), 244 deletions(-)

diff --git a/doc/guides/prog_guide/vhost_lib.rst b/doc/guides/prog_guide/vhost_lib.rst
index 345a621716..25103eb49d 100644
--- a/doc/guides/prog_guide/vhost_lib.rst
+++ b/doc/guides/prog_guide/vhost_lib.rst
@@ -103,21 +103,6 @@ The following is an overview of some key Vhost API functions:
 
     It is disabled by default.
 
-  - ``RTE_VHOST_USER_ASYNC_COPY``
-
-    Asynchronous data path will be enabled when this flag is set. Async
-    data path allows applications to enable DMA acceleration for vhost
-    queues. Vhost leverages the registered DMA channels to free CPU from
-    memory copy operations in data path. A set of async data path APIs are
-    defined for DPDK applications to make use of the async capability. Only
-    packets enqueued/dequeued by async APIs are processed through the async
-    data path.
-
-    Currently this feature is only implemented on split ring enqueue data
-    path.
-
-    It is disabled by default.
-
   - ``RTE_VHOST_USER_NET_COMPLIANT_OL_FLAGS``
 
     Since v16.04, the vhost library forwards checksum and gso requests for
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 938617ca75..b44d8cc4ad 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -68,6 +68,13 @@ Removed Items
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* **Removed vhost async (DMA-accelerated) data path.**
+
+  The experimental async data path APIs have been removed from the vhost library.
+  The following functions and flag are no longer available:
+
+  - ``RTE_VHOST_USER_ASYNC_COPY``
+
 
 API Changes
 -----------
diff --git a/lib/vhost/rte_vhost.h b/lib/vhost/rte_vhost.h
index a7f9700538..e0789807d4 100644
--- a/lib/vhost/rte_vhost.h
+++ b/lib/vhost/rte_vhost.h
@@ -38,7 +38,7 @@ extern "C" {
 #define RTE_VHOST_USER_EXTBUF_SUPPORT	(1ULL << 5)
 /* support only linear buffers (no chained mbufs) */
 #define RTE_VHOST_USER_LINEARBUF_SUPPORT	(1ULL << 6)
-#define RTE_VHOST_USER_ASYNC_COPY	(1ULL << 7)
+/* Bit 7 was RTE_VHOST_USER_ASYNC_COPY, now unsupported */
 #define RTE_VHOST_USER_NET_COMPLIANT_OL_FLAGS	(1ULL << 8)
 #define RTE_VHOST_USER_NET_STATS_ENABLE	(1ULL << 9)
 #define RTE_VHOST_USER_ASYNC_CONNECT	(1ULL << 10)
diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
index 70e582a18d..4f5f44d0a5 100644
--- a/lib/vhost/socket.c
+++ b/lib/vhost/socket.c
@@ -210,7 +210,6 @@ vhost_user_add_connection(int fd, struct vhost_user_socket *vsocket)
 	size_t size;
 	struct vhost_user_connection *conn;
 	int ret;
-	struct virtio_net *dev;
 
 	if (vsocket == NULL)
 		return;
@@ -241,13 +240,6 @@ vhost_user_add_connection(int fd, struct vhost_user_socket *vsocket)
 	if (vsocket->linearbuf)
 		vhost_enable_linearbuf(vid);
 
-	if (vsocket->async_copy) {
-		dev = get_device(vid);
-
-		if (dev)
-			dev->async_copy = 1;
-	}
-
 	VHOST_CONFIG_LOG(vsocket->path, INFO, "new device, handle is %d", vid);
 
 	if (vsocket->notify_ops->new_connection) {
@@ -911,6 +903,11 @@ rte_vhost_driver_register(const char *path, uint64_t flags)
 	if (!path)
 		return -1;
 
+	if (flags & (1ULL << 7)) {
+		VHOST_CONFIG_LOG(path, ERR, "async copy flag (bit 7) is no longer supported");
+		return -1;
+	}
+
 	pthread_mutex_lock(&vhost_user.mutex);
 
 	if (vhost_user.vsocket_cnt == MAX_VHOST_SOCKET) {
@@ -938,7 +935,7 @@ rte_vhost_driver_register(const char *path, uint64_t flags)
 	vsocket->max_queue_pairs = VHOST_MAX_QUEUE_PAIRS;
 	vsocket->extbuf = flags & RTE_VHOST_USER_EXTBUF_SUPPORT;
 	vsocket->linearbuf = flags & RTE_VHOST_USER_LINEARBUF_SUPPORT;
-	vsocket->async_copy = flags & RTE_VHOST_USER_ASYNC_COPY;
+	vsocket->async_copy = false;
 	vsocket->net_compliant_ol_flags = flags & RTE_VHOST_USER_NET_COMPLIANT_OL_FLAGS;
 	vsocket->stats_enabled = flags & RTE_VHOST_USER_NET_STATS_ENABLE;
 	vsocket->async_connect = flags & RTE_VHOST_USER_ASYNC_CONNECT;
@@ -947,12 +944,6 @@ rte_vhost_driver_register(const char *path, uint64_t flags)
 	else
 		vsocket->iommu_support = flags & RTE_VHOST_USER_IOMMU_SUPPORT;
 
-	if (vsocket->async_copy && (vsocket->iommu_support ||
-				(flags & RTE_VHOST_USER_POSTCOPY_SUPPORT))) {
-		VHOST_CONFIG_LOG(path, ERR, "async copy with IOMMU or post-copy not supported");
-		goto out_mutex;
-	}
-
 	/*
 	 * Set the supported features correctly for the builtin vhost-user
 	 * net driver.
@@ -975,12 +966,6 @@ rte_vhost_driver_register(const char *path, uint64_t flags)
 		vsocket->protocol_features  = VHOST_USER_PROTOCOL_FEATURES;
 	}
 
-	if (vsocket->async_copy) {
-		vsocket->supported_features &= ~(1ULL << VHOST_F_LOG_ALL);
-		vsocket->features &= ~(1ULL << VHOST_F_LOG_ALL);
-		VHOST_CONFIG_LOG(path, INFO, "logging feature is disabled in async copy mode");
-	}
-
 	/*
 	 * We'll not be able to receive a buffer from guest in linear mode
 	 * without external buffer if it will not fit in a single mbuf, which is
diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 020c993b29..2b35f44b70 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -42,7 +42,6 @@
 #include <rte_common.h>
 #include <rte_malloc.h>
 #include <rte_log.h>
-#include <rte_vfio.h>
 #include <rte_errno.h>
 
 #include "iotlb.h"
@@ -174,80 +173,6 @@ get_blk_size(int fd)
 	return ret == -1 ? (uint64_t)-1 : (uint64_t)stat.st_blksize;
 }
 
-static int
-async_dma_map_region(struct virtio_net *dev, struct rte_vhost_mem_region *reg, bool do_map)
-{
-	uint32_t i;
-	int ret;
-	uint64_t reg_start = reg->host_user_addr;
-	uint64_t reg_end = reg_start + reg->size;
-
-	for (i = 0; i < dev->nr_guest_pages; i++) {
-		struct guest_page *page = &dev->guest_pages[i];
-
-		/* Only process pages belonging to this region */
-		if (page->host_user_addr < reg_start ||
-		    page->host_user_addr >= reg_end)
-			continue;
-
-		if (do_map) {
-			ret = rte_vfio_container_dma_map(RTE_VFIO_DEFAULT_CONTAINER_FD,
-					page->host_user_addr,
-					page->host_iova,
-					page->size);
-			if (ret) {
-				/*
-				 * DMA device may bind with kernel driver, in this case,
-				 * we don't need to program IOMMU manually. However, if no
-				 * device is bound with vfio/uio in DPDK, and vfio kernel
-				 * module is loaded, the API will still be called and return
-				 * with ENODEV.
-				 *
-				 * DPDK vfio only returns ENODEV in very similar situations
-				 * (vfio either unsupported, or supported but no devices found).
-				 * Either way, no mappings could be performed. We treat it as
-				 * normal case in async path. This is a workaround.
-				 */
-				if (rte_errno == ENODEV)
-					return 0;
-
-				/* DMA mapping errors won't stop VHOST_USER_SET_MEM_TABLE. */
-				VHOST_CONFIG_LOG(dev->ifname, ERR, "DMA engine map failed");
-				return -1;
-			}
-		} else {
-			ret = rte_vfio_container_dma_unmap(RTE_VFIO_DEFAULT_CONTAINER_FD,
-					page->host_user_addr,
-					page->host_iova,
-					page->size);
-			if (ret) {
-				/* like DMA map, ignore the kernel driver case when unmap. */
-				if (rte_errno == EINVAL)
-					return 0;
-
-				VHOST_CONFIG_LOG(dev->ifname, ERR, "DMA engine unmap failed");
-				return -1;
-			}
-		}
-	}
-
-	return 0;
-}
-
-static void
-async_dma_map(struct virtio_net *dev, bool do_map)
-{
-	uint32_t i;
-	struct rte_vhost_mem_region *reg;
-
-	for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
-		reg = &dev->mem->regions[i];
-		if (reg->host_user_addr == 0)
-			continue;
-		async_dma_map_region(dev, reg, do_map);
-	}
-}
-
 static void
 free_mem_region(struct rte_vhost_mem_region *reg)
 {
@@ -267,9 +192,6 @@ free_all_mem_regions(struct virtio_net *dev)
 	if (!dev || !dev->mem)
 		return;
 
-	if (dev->async_copy && rte_vfio_is_enabled("vfio"))
-		async_dma_map(dev, false);
-
 	for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
 		reg = &dev->mem->regions[i];
 		if (reg->mmap_addr)
@@ -1086,90 +1008,6 @@ vhost_user_set_vring_base(struct virtio_net **pdev,
 	return RTE_VHOST_MSG_RESULT_OK;
 }
 
-static int
-add_one_guest_page(struct virtio_net *dev, uint64_t guest_phys_addr,
-		   uint64_t host_iova, uint64_t host_user_addr, uint64_t size)
-{
-	struct guest_page *page, *last_page;
-	struct guest_page *old_pages;
-
-	if (dev->nr_guest_pages == dev->max_guest_pages) {
-		dev->max_guest_pages *= 2;
-		old_pages = dev->guest_pages;
-		dev->guest_pages = rte_realloc(dev->guest_pages,
-					dev->max_guest_pages * sizeof(*page),
-					RTE_CACHE_LINE_SIZE);
-		if (dev->guest_pages == NULL) {
-			VHOST_CONFIG_LOG(dev->ifname, ERR, "cannot realloc guest_pages");
-			rte_free(old_pages);
-			return -1;
-		}
-	}
-
-	if (dev->nr_guest_pages > 0) {
-		last_page = &dev->guest_pages[dev->nr_guest_pages - 1];
-		/* merge if the two pages are continuous */
-		if (host_iova == last_page->host_iova + last_page->size &&
-		    guest_phys_addr == last_page->guest_phys_addr + last_page->size &&
-		    host_user_addr == last_page->host_user_addr + last_page->size) {
-			last_page->size += size;
-			return 0;
-		}
-	}
-
-	page = &dev->guest_pages[dev->nr_guest_pages++];
-	page->guest_phys_addr = guest_phys_addr;
-	page->host_iova  = host_iova;
-	page->host_user_addr = host_user_addr;
-	page->size = size;
-
-	return 0;
-}
-
-static int
-add_guest_pages(struct virtio_net *dev, struct rte_vhost_mem_region *reg,
-		uint64_t page_size)
-{
-	uint64_t reg_size = reg->size;
-	uint64_t host_user_addr  = reg->host_user_addr;
-	uint64_t guest_phys_addr = reg->guest_phys_addr;
-	uint64_t host_iova;
-	uint64_t size;
-
-	host_iova = rte_mem_virt2iova((void *)(uintptr_t)host_user_addr);
-	size = page_size - (guest_phys_addr & (page_size - 1));
-	size = RTE_MIN(size, reg_size);
-
-	if (add_one_guest_page(dev, guest_phys_addr, host_iova,
-			       host_user_addr, size) < 0)
-		return -1;
-
-	host_user_addr  += size;
-	guest_phys_addr += size;
-	reg_size -= size;
-
-	while (reg_size > 0) {
-		size = RTE_MIN(reg_size, page_size);
-		host_iova = rte_mem_virt2iova((void *)(uintptr_t)
-						  host_user_addr);
-		if (add_one_guest_page(dev, guest_phys_addr, host_iova,
-				       host_user_addr, size) < 0)
-			return -1;
-
-		host_user_addr  += size;
-		guest_phys_addr += size;
-		reg_size -= size;
-	}
-
-	/* sort guest page array if over binary search threshold */
-	if (dev->nr_guest_pages >= VHOST_BINARY_SEARCH_THRESH) {
-		qsort((void *)dev->guest_pages, dev->nr_guest_pages,
-			sizeof(struct guest_page), guest_page_addrcmp);
-	}
-
-	return 0;
-}
-
 static void
 remove_guest_pages(struct virtio_net *dev, struct rte_vhost_mem_region *reg)
 {
@@ -1345,7 +1183,6 @@ vhost_user_mmap_region(struct virtio_net *dev,
 	void *mmap_addr;
 	uint64_t mmap_size;
 	uint64_t alignment;
-	int populate;
 
 	/* Check for memory_size + mmap_offset overflow */
 	if (mmap_offset >= -region->size) {
@@ -1384,10 +1221,7 @@ vhost_user_mmap_region(struct virtio_net *dev,
 		return -1;
 	}
 
-	populate = dev->async_copy ? MAP_POPULATE : 0;
-	mmap_addr = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
-			MAP_SHARED | populate, region->fd, 0);
-
+	mmap_addr = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED, region->fd, 0);
 	if (mmap_addr == MAP_FAILED) {
 		VHOST_CONFIG_LOG(dev->ifname, ERR, "mmap failed (%s).", strerror(errno));
 		return -1;
@@ -1398,14 +1232,6 @@ vhost_user_mmap_region(struct virtio_net *dev,
 	region->host_user_addr = (uint64_t)(uintptr_t)mmap_addr + mmap_offset;
 	mem_set_dump(dev, mmap_addr, mmap_size, false, alignment);
 
-	if (dev->async_copy) {
-		if (add_guest_pages(dev, region, alignment) < 0) {
-			VHOST_CONFIG_LOG(dev->ifname, ERR,
-				"adding guest pages to region failed.");
-			return -1;
-		}
-	}
-
 	VHOST_CONFIG_LOG(dev->ifname, INFO,
 		"guest memory region size: 0x%" PRIx64,
 		region->size);
@@ -1519,15 +1345,6 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
 			dev->flags &= ~VIRTIO_DEV_VDPA_CONFIGURED;
 		}
 
-		/* notify the vhost application to stop DMA transfers */
-		if (dev->async_copy && dev->notify_ops->vring_state_changed) {
-			for (i = 0; i < dev->nr_vring; i++) {
-				dev->notify_ops->vring_state_changed(dev->vid,
-						i, 0);
-			}
-			async_notify = true;
-		}
-
 		/* Flush IOTLB cache as previous HVAs are now invalid */
 		if (dev->features & (1ULL << VIRTIO_F_IOMMU_PLATFORM))
 			vhost_user_iotlb_flush_all(dev);
@@ -1564,9 +1381,6 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
 		dev->mem->nregions++;
 	}
 
-	if (dev->async_copy && rte_vfio_is_enabled("vfio"))
-		async_dma_map(dev, true);
-
 	if (vhost_user_postcopy_register(dev, main_fd, ctx) < 0)
 		goto free_mem_table;
 
@@ -1735,26 +1549,13 @@ vhost_user_add_mem_reg(struct virtio_net **pdev,
 
 	if (vhost_user_mmap_region(dev, reg, region->mmap_offset) < 0) {
 		VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to mmap region");
-		if (reg->mmap_addr) {
-			/* mmap succeeded but a later step (e.g. add_guest_pages)
-			 * failed; undo the mapping and any guest-page entries.
-			 */
-			remove_guest_pages(dev, reg);
-			free_mem_region(reg);
-		} else {
-			close(reg->fd);
-			reg->fd = -1;
-		}
+		close(reg->fd);
+		reg->fd = -1;
 		goto close_msg_fds;
 	}
 
 	dev->mem->nregions++;
 
-	if (dev->async_copy && rte_vfio_is_enabled("vfio")) {
-		if (async_dma_map_region(dev, reg, true) < 0)
-			goto free_new_region_no_dma;
-	}
-
 	if (dev->postcopy_listening) {
 		/*
 		 * Cannot use vhost_user_postcopy_register() here because it
@@ -1791,9 +1592,6 @@ vhost_user_add_mem_reg(struct virtio_net **pdev,
 	return RTE_VHOST_MSG_RESULT_OK;
 
 free_new_region:
-	if (dev->async_copy && rte_vfio_is_enabled("vfio"))
-		async_dma_map_region(dev, reg, false);
-free_new_region_no_dma:
 	remove_guest_pages(dev, reg);
 	free_mem_region(reg);
 	dev->mem->nregions--;
@@ -1827,8 +1625,6 @@ vhost_user_rem_mem_reg(struct virtio_net **pdev,
 		if (region->userspace_addr == current_region->guest_user_addr
 			&& region->guest_phys_addr == current_region->guest_phys_addr
 			&& region->memory_size == current_region->size) {
-			if (dev->async_copy && rte_vfio_is_enabled("vfio"))
-				async_dma_map_region(dev, current_region, false);
 			if (dev->features & (1ULL << VIRTIO_F_IOMMU_PLATFORM))
 				vhost_user_iotlb_cache_remove(dev,
 					current_region->guest_phys_addr,
-- 
2.54.0

