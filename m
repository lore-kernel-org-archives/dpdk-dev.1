Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B55CD4F39
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 May 2026 01:04:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9049640274;
	Fri, 15 May 2026 03:04:41 +0200 (CEST)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id 47CE540151
 for <dev@dpdk.org>; Fri, 15 May 2026 03:04:40 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=jwTm2xVUnXpSISi+h+/zmM96OlXuoi2ph4xwwyAwNtc=;
 b=dX7sj5QyDitSwVeIVUDLhqP7RVYUmhJSkPzfELgfGVwB7Z73bD0YU/HOw1V2dAXPi22YcIe89
 OUH0ZzhxuEE1mZhvyoktBOMod/OzZmmnWgWj4JTwZDSd3tPug0V08bKKo6WYxDSKmpfCatg3TGJ
 3D52q3mS5YZ0HmdD/qjMqiE=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gGphF2VXtzpTHf;
 Fri, 15 May 2026 08:57:33 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id ADEEE4048F;
 Fri, 15 May 2026 09:04:37 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 May 2026 09:04:37 +0800
Message-ID: <71c3a27c-a76f-4339-a4f5-997cd1d98286@huawei.com>
Date: Fri, 15 May 2026 09:04:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 4/5] vhost_user: Function defs for add/rem mem regions
To: <pravin.bathija@dell.com>, <dev@dpdk.org>, <stephen@networkplumber.org>,
 <maxime.coquelin@redhat.com>
CC: <thomas@monjalon.net>
References: <20260514224627.2014566-1-pravin.bathija@dell.com>
 <20260514224627.2014566-5-pravin.bathija@dell.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260514224627.2014566-5-pravin.bathija@dell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

On 5/15/2026 6:46 AM, pravin.bathija@dell.com wrote:
> From: Pravin M Bathija <pravin.bathija@dell.com>
> 
> These changes cover the function definition for add/remove memory
> region calls which are invoked on receiving vhost user message from
> vhost user front-end (e.g. Qemu). In our case, in addition to testing
> with qemu front-end, the testing has also been performed with libblkio
> front-end and spdk/dpdk back-end. We did I/O using libblkio based device
> driver, to spdk based drives.
> There are also changes for set_mem_table and new definition for get memory
> slots. Our changes optimize the set memory table call to use common support
> functions. A new vhost_user_initialize_memory() function is introduced to
> factor out the common memory initialization logic from the function
> vhost_user_set_mem_table(), which is now called from both the SET_MEM_TABLE
> message handler and the ADD_MEM_REG handler (for the first region).
> Message get memory slots is how the vhost-user front-end queries the
> vhost-user back-end about the number of memory slots available to be
> registered by the back-end. In addition support function to invalidate
> vring is also defined which is used in add/remove memory region functions.
> The helper function remove_guest_pages is also defined here which is called
> from vhost_user_add_mem_reg.

Two much detail which provide noisy infomation I think, how about:

vhost: add mem region add/remove handlers

Add support for VHOST_USER_ADD_MEM_REG, VHOST_USER_REM_MEM_REG and
VHOST_USER_GET_MAX_MEM_SLOTS. Refactor memory initialization into
common helper and add supporting functions for dynamic memory management.

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>

> 
> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
> ---
>  lib/vhost/vhost_user.c | 329 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 296 insertions(+), 33 deletions(-)
> 
> diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
> index 0ee3fe7a5e..fdcb7e0158 100644
> --- a/lib/vhost/vhost_user.c
> +++ b/lib/vhost/vhost_user.c
> @@ -71,6 +71,9 @@ VHOST_MESSAGE_HANDLER(VHOST_USER_SET_FEATURES, vhost_user_set_features, false, t
>  VHOST_MESSAGE_HANDLER(VHOST_USER_SET_OWNER, vhost_user_set_owner, false, true) \
>  VHOST_MESSAGE_HANDLER(VHOST_USER_RESET_OWNER, vhost_user_reset_owner, false, false) \
>  VHOST_MESSAGE_HANDLER(VHOST_USER_SET_MEM_TABLE, vhost_user_set_mem_table, true, true) \
> +VHOST_MESSAGE_HANDLER(VHOST_USER_GET_MAX_MEM_SLOTS, vhost_user_get_max_mem_slots, false, false) \
> +VHOST_MESSAGE_HANDLER(VHOST_USER_ADD_MEM_REG, vhost_user_add_mem_reg, true, true) \
> +VHOST_MESSAGE_HANDLER(VHOST_USER_REM_MEM_REG, vhost_user_rem_mem_reg, true, true) \
>  VHOST_MESSAGE_HANDLER(VHOST_USER_SET_LOG_BASE, vhost_user_set_log_base, true, true) \
>  VHOST_MESSAGE_HANDLER(VHOST_USER_SET_LOG_FD, vhost_user_set_log_fd, true, true) \
>  VHOST_MESSAGE_HANDLER(VHOST_USER_SET_VRING_NUM, vhost_user_set_vring_num, false, true) \
> @@ -1167,6 +1170,24 @@ add_guest_pages(struct virtio_net *dev, struct rte_vhost_mem_region *reg,
>  	return 0;
>  }
>  
> +static void
> +remove_guest_pages(struct virtio_net *dev, struct rte_vhost_mem_region *reg)
> +{
> +	uint64_t reg_start = reg->host_user_addr;
> +	uint64_t reg_end = reg_start + reg->size;
> +	uint32_t i, j = 0;
> +
> +	for (i = 0; i < dev->nr_guest_pages; i++) {
> +		if (dev->guest_pages[i].host_user_addr >= reg_start &&
> +		    dev->guest_pages[i].host_user_addr < reg_end)
> +			continue;
> +		if (j != i)
> +			dev->guest_pages[j] = dev->guest_pages[i];
> +		j++;
> +	}
> +	dev->nr_guest_pages = j;
> +}
> +
>  #ifdef RTE_LIBRTE_VHOST_DEBUG
>  /* TODO: enable it only in debug mode? */
>  static void
> @@ -1413,6 +1434,52 @@ vhost_user_mmap_region(struct virtio_net *dev,
>  	return 0;
>  }
>  
> +static int
> +vhost_user_initialize_memory(struct virtio_net **pdev)
> +{
> +	struct virtio_net *dev = *pdev;
> +	int numa_node = SOCKET_ID_ANY;
> +
> +	if (dev->mem != NULL) {
> +		VHOST_CONFIG_LOG(dev->ifname, ERR,
> +			"memory already initialized, free it first");
> +		return -1;
> +	}
> +
> +	/*
> +	 * If VQ 0 has already been allocated, try to allocate on the same
> +	 * NUMA node. It can be reallocated later in numa_realloc().
> +	 */
> +	if (dev->nr_vring > 0)
> +		numa_node = dev->virtqueue[0]->numa_node;
> +
> +	dev->nr_guest_pages = 0;
> +	if (dev->guest_pages == NULL) {
> +		dev->max_guest_pages = 8;
> +		dev->guest_pages = rte_zmalloc_socket(NULL,
> +					dev->max_guest_pages *
> +					sizeof(struct guest_page),
> +					RTE_CACHE_LINE_SIZE,
> +					numa_node);
> +		if (dev->guest_pages == NULL) {
> +			VHOST_CONFIG_LOG(dev->ifname, ERR,
> +				"failed to allocate memory for dev->guest_pages");
> +			return -1;
> +		}
> +	}
> +
> +	dev->mem = rte_zmalloc_socket("vhost-mem-table", sizeof(struct rte_vhost_memory) +
> +		sizeof(struct rte_vhost_mem_region) * VHOST_MEMORY_MAX_NREGIONS, 0, numa_node);
> +	if (dev->mem == NULL) {
> +		VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to allocate memory for dev->mem");
> +		rte_free(dev->guest_pages);
> +		dev->guest_pages = NULL;
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
>  static int
>  vhost_user_set_mem_table(struct virtio_net **pdev,
>  			struct vhu_msg_context *ctx,
> @@ -1421,7 +1488,6 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
>  	struct virtio_net *dev = *pdev;
>  	struct VhostUserMemory *memory = &ctx->msg.payload.memory;
>  	struct rte_vhost_mem_region *reg;
> -	int numa_node = SOCKET_ID_ANY;
>  	uint64_t mmap_offset;
>  	uint32_t i;
>  	bool async_notify = false;
> @@ -1466,39 +1532,13 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
>  		if (dev->features & (1ULL << VIRTIO_F_IOMMU_PLATFORM))
>  			vhost_user_iotlb_flush_all(dev);
>  
> -		free_mem_region(dev);
> +		free_all_mem_regions(dev);

This should be done in commit 3/5, I suspect that 3/5 of the code may fail to be compiled.

Please make sure each commit should compile OK, so that git commit binary search and
troubleshooting could work.

>  		rte_free(dev->mem);
>  		dev->mem = NULL;
>  	}
>  
> -	/*
> -	 * If VQ 0 has already been allocated, try to allocate on the same
> -	 * NUMA node. It can be reallocated later in numa_realloc().
> -	 */
> -	if (dev->nr_vring > 0)
> -		numa_node = dev->virtqueue[0]->numa_node;
> -
> -	dev->nr_guest_pages = 0;
> -	if (dev->guest_pages == NULL) {
> -		dev->max_guest_pages = 8;
> -		dev->guest_pages = rte_zmalloc_socket(NULL,
> -					dev->max_guest_pages *
> -					sizeof(struct guest_page),
> -					RTE_CACHE_LINE_SIZE,
> -					numa_node);
> -		if (dev->guest_pages == NULL) {
> -			VHOST_CONFIG_LOG(dev->ifname, ERR,
> -				"failed to allocate memory for dev->guest_pages");
> -			goto close_msg_fds;
> -		}
> -	}
> -
> -	dev->mem = rte_zmalloc_socket("vhost-mem-table", sizeof(struct rte_vhost_memory) +
> -		sizeof(struct rte_vhost_mem_region) * memory->nregions, 0, numa_node);
> -	if (dev->mem == NULL) {
> -		VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to allocate memory for dev->mem");
> -		goto free_guest_pages;
> -	}
> +	if (vhost_user_initialize_memory(pdev) < 0)
> +		goto close_msg_fds;
>  
>  	for (i = 0; i < memory->nregions; i++) {
>  		reg = &dev->mem->regions[i];
> @@ -1562,11 +1602,9 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
>  	return RTE_VHOST_MSG_RESULT_OK;
>  
>  free_mem_table:
> -	free_mem_region(dev);
> +	free_all_mem_regions(dev);

Same, it should be done in commit 3/5

>  	rte_free(dev->mem);
>  	dev->mem = NULL;
> -
> -free_guest_pages:
>  	rte_free(dev->guest_pages);
>  	dev->guest_pages = NULL;
>  close_msg_fds:
> @@ -1574,6 +1612,231 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
>  	return RTE_VHOST_MSG_RESULT_ERR;
>  }
>  
> +
> +static int
> +vhost_user_get_max_mem_slots(struct virtio_net **pdev __rte_unused,
> +			struct vhu_msg_context *ctx,
> +			int main_fd __rte_unused)
> +{
> +	uint32_t max_mem_slots = VHOST_MEMORY_MAX_NREGIONS;
> +
> +	ctx->msg.payload.u64 = (uint64_t)max_mem_slots;
> +	ctx->msg.size = sizeof(ctx->msg.payload.u64);
> +	ctx->fd_num = 0;
> +
> +	return RTE_VHOST_MSG_RESULT_REPLY;
> +}
> +
> +static void
> +_dev_invalidate_vrings(struct virtio_net **pdev)

It seems that there is no such naming convention in vhost.

> +{
> +	struct virtio_net *dev = *pdev;
> +	uint32_t i;
> +
> +	for (i = 0; i < dev->nr_vring; i++) {
> +		struct vhost_virtqueue *vq = dev->virtqueue[i];
> +
> +		if (!vq)
> +			continue;
> +
> +		if (vq->desc || vq->avail || vq->used) {
> +			vq_assert_lock(dev, vq);
> +
> +			/*
> +			 * If the memory table got updated, the ring addresses
> +			 * need to be translated again as virtual addresses have
> +			 * changed.
> +			 */
> +			vring_invalidate(dev, vq);
> +
> +			translate_ring_addresses(&dev, &vq);
> +		}
> +	}
> +
> +	*pdev = dev;

why do this?

> +}
> +
> +/*
> + * Macro wrapper that performs the compile-time lock assertion with the
> + * correct message ID at the call site, then calls the implementation.
> + */
> +#define dev_invalidate_vrings(pdev, id) do { \
> +	static_assert(id ## _LOCK_ALL_QPS, \
> +		#id " handler is not declared as locking all queue pairs"); \
> +	_dev_invalidate_vrings(pdev); \
> +} while (0)
> +
> +static int
> +vhost_user_add_mem_reg(struct virtio_net **pdev,
> +			struct vhu_msg_context *ctx,
> +			int main_fd __rte_unused)
> +{
> +	uint32_t i;
> +	struct virtio_net *dev = *pdev;
> +	struct VhostUserMemoryRegion *region = &ctx->msg.payload.memreg.region;

Local variables should be arranged in descending order of length.

struct VhostUserMemoryRegion *region = &ctx->msg.payload.memreg.region;
struct virtio_net *dev = *pdev;
uint32_t i;

> +
> +	/* convert first region add to normal memory table set */
> +	if (dev->mem == NULL) {
> +		if (vhost_user_initialize_memory(pdev) < 0)
> +			goto close_msg_fds;
> +	}
> +
> +	/* make sure new region will fit */
> +	if (dev->mem->nregions >= VHOST_MEMORY_MAX_NREGIONS) {
> +		VHOST_CONFIG_LOG(dev->ifname, ERR, "too many memory regions already (%u)",
> +									dev->mem->nregions);
> +		goto close_msg_fds;
> +	}
> +
> +	/* make sure supplied memory fd present */
> +	if (ctx->fd_num != 1) {
> +		VHOST_CONFIG_LOG(dev->ifname, ERR, "fd count makes no sense (%u)", ctx->fd_num);
> +		goto close_msg_fds;
> +	}
> +
> +	/* Make sure no overlap in guest virtual address space */
> +	for (i = 0; i < dev->mem->nregions; i++) {
> +		struct rte_vhost_mem_region *current_region = &dev->mem->regions[i];
> +		uint64_t current_region_guest_start = current_region->guest_user_addr;
> +		uint64_t current_region_guest_end = current_region_guest_start
> +							+ current_region->size - 1;
> +		uint64_t proposed_region_guest_start = region->userspace_addr;
> +		uint64_t proposed_region_guest_end = proposed_region_guest_start
> +							+ region->memory_size - 1;

why not use short name?

> +
> +		if (!((proposed_region_guest_end < current_region_guest_start) ||
> +			(proposed_region_guest_start > current_region_guest_end))) {
> +			VHOST_CONFIG_LOG(dev->ifname, ERR,
> +				"requested memory region overlaps with another region");
> +			VHOST_CONFIG_LOG(dev->ifname, ERR,
> +				"\tRequested region address:0x%" PRIx64,
> +				region->userspace_addr);
> +			VHOST_CONFIG_LOG(dev->ifname, ERR,
> +				"\tRequested region size:0x%" PRIx64,
> +				region->memory_size);
> +			VHOST_CONFIG_LOG(dev->ifname, ERR,
> +				"\tOverlapping region address:0x%" PRIx64,
> +				current_region->guest_user_addr);
> +			VHOST_CONFIG_LOG(dev->ifname, ERR,
> +				"\tOverlapping region size:0x%" PRIx64,
> +				current_region->size);
> +			goto close_msg_fds;
> +		}
> +	}
> +
> +	/* New region goes at the end of the contiguous array */
> +	struct rte_vhost_mem_region *reg = &dev->mem->regions[dev->mem->nregions];
> +
> +	reg->guest_phys_addr = region->guest_phys_addr;
> +	reg->guest_user_addr = region->userspace_addr;
> +	reg->size            = region->memory_size;
> +	reg->fd              = ctx->fds[0];
> +	ctx->fds[0]          = -1;
> +
> +	if (vhost_user_mmap_region(dev, reg, region->mmap_offset) < 0) {
> +		VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to mmap region");
> +		if (reg->mmap_addr) {
> +			/* mmap succeeded but a later step (e.g. add_guest_pages)
> +			 * failed; undo the mapping and any guest-page entries.
> +			 */
> +			remove_guest_pages(dev, reg);
> +			free_mem_region(reg);
> +		} else {
> +			close(reg->fd);
> +			reg->fd = -1;
> +		}
> +		goto close_msg_fds;
> +	}
> +
> +	dev->mem->nregions++;
> +
> +	if (dev->async_copy && rte_vfio_is_enabled("vfio")) {
> +		if (async_dma_map_region(dev, reg, true) < 0)
> +			goto free_new_region;

I point it out in v12, maybe not so clear, so again:
the goto will invoke async_dma_map_region(dev, reg, false), it should not invoke in
this branch.

> +	}
> +
> +	if (dev->postcopy_listening) {
> +		/*
> +		 * Cannot use vhost_user_postcopy_register() here because it
> +		 * reads ctx->msg.payload.memory (SET_MEM_TABLE layout), but
> +		 * ADD_MEM_REG uses the memreg payload.  Register the
> +		 * single new region directly instead.
> +		 */
> +		if (vhost_user_postcopy_region_register(dev, reg) < 0)
> +			goto free_new_region;
> +	}
> +
> +	dev_invalidate_vrings(pdev, VHOST_USER_ADD_MEM_REG);
> +	dev = *pdev;

What the meaning? the dev already set *pdev in the beginning.
I also point it out in v12, I don't know what happening.

> +	dump_guest_pages(dev);
> +
> +	return RTE_VHOST_MSG_RESULT_OK;
> +
> +free_new_region:
> +	if (dev->async_copy && rte_vfio_is_enabled("vfio"))
> +		async_dma_map_region(dev, reg, false);
> +	remove_guest_pages(dev, reg);
> +	free_mem_region(reg);
> +	dev->mem->nregions--;
> +close_msg_fds:
> +	close_msg_fds(ctx);
> +	return RTE_VHOST_MSG_RESULT_ERR;
> +}
> +
> +static int
> +vhost_user_rem_mem_reg(struct virtio_net **pdev,
> +			struct vhu_msg_context *ctx,
> +			int main_fd __rte_unused)
> +{
> +	uint32_t i;
> +	struct virtio_net *dev = *pdev;
> +	struct VhostUserMemoryRegion *region = &ctx->msg.payload.memreg.region;
> +
> +	if (dev->mem == NULL || dev->mem->nregions == 0) {
> +		VHOST_CONFIG_LOG(dev->ifname, ERR, "no memory regions to remove");
> +		close_msg_fds(ctx);
> +		return RTE_VHOST_MSG_RESULT_ERR;
> +	}
> +
> +	for (i = 0; i < dev->mem->nregions; i++) {
> +		struct rte_vhost_mem_region *current_region = &dev->mem->regions[i];
> +
> +		/*
> +		 * According to the vhost-user specification:
> +		 * The memory region to be removed is identified by its GPA,
> +		 * user address and size. The mmap offset is ignored.
> +		 */
> +		if (region->userspace_addr == current_region->guest_user_addr
> +			&& region->guest_phys_addr == current_region->guest_phys_addr
> +			&& region->memory_size == current_region->size) {
> +			if (dev->async_copy && rte_vfio_is_enabled("vfio"))
> +				async_dma_map_region(dev, current_region, false);
> +			remove_guest_pages(dev, current_region);
> +			free_mem_region(current_region);
> +
> +			/* Compact the regions array to keep it contiguous */
> +			if (i < dev->mem->nregions - 1) {
> +				memmove(&dev->mem->regions[i],
> +					&dev->mem->regions[i + 1],
> +					(dev->mem->nregions - 1 - i) *
> +					sizeof(struct rte_vhost_mem_region));
> +				memset(&dev->mem->regions[dev->mem->nregions - 1],
> +					0, sizeof(struct rte_vhost_mem_region));
> +			}
> +
> +			dev->mem->nregions--;
> +			dev_invalidate_vrings(pdev, VHOST_USER_REM_MEM_REG);
> +			dev = *pdev;

I still don't know what the assignment meaning/function?

> +			close_msg_fds(ctx);
> +			return RTE_VHOST_MSG_RESULT_OK;
> +		}
> +	}
> +
> +	VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to find region");
> +	close_msg_fds(ctx);
> +	return RTE_VHOST_MSG_RESULT_ERR;
> +}
> +
>  static bool
>  vq_is_ready(struct virtio_net *dev, struct vhost_virtqueue *vq)
>  {

