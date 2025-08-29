Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A492CA0FF0
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 11:59:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 644CB40263;
	Fri, 29 Aug 2025 13:59:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 23B914025A
 for <dev@dpdk.org>; Fri, 29 Aug 2025 13:59:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756468790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9zeSNt4shJKSwjrPrRFkEE+hPU5bsxp0jT32q3FHvNc=;
 b=ALRxzQR30l+eUPlQ5fPC/LDI5k8degCw6U76hahHgyCnolAAr+y0kTrwg7cJz2y/h3XO73
 G6wOZzrjpuKqDq9Wl27bAfeu7R5MYzhACd/ULi8OekP8UOpHqRPG+JadFPm/09y7O8A9YP
 ScTTMb5q/2wgTUByacLe9xn6KOII6jE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-B8jQZ8YTMtGel1_vFDCRUA-1; Fri,
 29 Aug 2025 07:59:47 -0400
X-MC-Unique: B8jQZ8YTMtGel1_vFDCRUA-1
X-Mimecast-MFC-AGG-ID: B8jQZ8YTMtGel1_vFDCRUA_1756468786
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E73DA1956089; Fri, 29 Aug 2025 11:59:45 +0000 (UTC)
Received: from [10.45.242.23] (unknown [10.45.242.23])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 360871800291; Fri, 29 Aug 2025 11:59:43 +0000 (UTC)
Message-ID: <e0ce893c-89a4-417f-88f5-46c60c6f9ded@redhat.com>
Date: Fri, 29 Aug 2025 13:59:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] vhost_user: support for memory regions
To: Pravin M Bathija <pravin.bathija@dell.com>, dev@dpdk.org
Cc: pravin.m.bathija.dev@gmail.com
References: <20250812023358.2400020-1-pravin.bathija@dell.com>
 <20250812023358.2400020-4-pravin.bathija@dell.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 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
 Mwqu3GQ=
In-Reply-To: <20250812023358.2400020-4-pravin.bathija@dell.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mGhFfovPoMRLMGQjBIhUwFshN6SvH_313ZgvTWDfz0o_1756468786
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

The title is not consistent with other commits in this library.

On 8/12/25 4:33 AM, Pravin M Bathija wrote:
> - modify data structures and add functions to support
>    add and remove memory regions/slots
> - define VHOST_MEMORY_MAX_NREGIONS & modify function
>    vhost_user_set_mem_table accordingly
> - dynamically add new memory slots via vhost_user_add_mem_reg
> - remove unused memory slots via vhost_user_rem_mem_reg
> - define data structure VhostUserSingleMemReg for single
>    memory region
> - modify data structures VhostUserRequest & VhostUserMsg
> 

Please write full sentences, explaining the purpose of this change and 
not just listing the changes themselves.

> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
> ---
>   lib/vhost/vhost_user.c | 325 +++++++++++++++++++++++++++++++++++------
>   lib/vhost/vhost_user.h |  10 ++
>   2 files changed, 291 insertions(+), 44 deletions(-)
> 
> diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
> index b73dec6a22..6367f54b97 100644
> --- a/lib/vhost/vhost_user.c
> +++ b/lib/vhost/vhost_user.c
> @@ -74,6 +74,9 @@ VHOST_MESSAGE_HANDLER(VHOST_USER_SET_FEATURES, vhost_user_set_features, false, t
>   VHOST_MESSAGE_HANDLER(VHOST_USER_SET_OWNER, vhost_user_set_owner, false, true) \
>   VHOST_MESSAGE_HANDLER(VHOST_USER_RESET_OWNER, vhost_user_reset_owner, false, false) \
>   VHOST_MESSAGE_HANDLER(VHOST_USER_SET_MEM_TABLE, vhost_user_set_mem_table, true, true) \
> +VHOST_MESSAGE_HANDLER(VHOST_USER_GET_MAX_MEM_SLOTS, vhost_user_get_max_mem_slots, false, false) \
> +VHOST_MESSAGE_HANDLER(VHOST_USER_ADD_MEM_REG, vhost_user_add_mem_reg, true, true) \
> +VHOST_MESSAGE_HANDLER(VHOST_USER_REM_MEM_REG, vhost_user_rem_mem_reg, true, true) \

Shouldn't it be:
VHOST_MESSAGE_HANDLER(VHOST_USER_REM_MEM_REG, vhost_user_rem_mem_reg, 
false, true)

And if not, aren't you not leaking FDs in vhost_user_rem_mem_reg?

>   VHOST_MESSAGE_HANDLER(VHOST_USER_SET_LOG_BASE, vhost_user_set_log_base, true, true) \
>   VHOST_MESSAGE_HANDLER(VHOST_USER_SET_LOG_FD, vhost_user_set_log_fd, true, true) \
>   VHOST_MESSAGE_HANDLER(VHOST_USER_SET_VRING_NUM, vhost_user_set_vring_num, false, true) \
> @@ -228,7 +231,17 @@ async_dma_map(struct virtio_net *dev, bool do_map)
>   }
>   
>   static void
> -free_mem_region(struct virtio_net *dev)
> +free_mem_region(struct rte_vhost_mem_region *reg)
> +{
> +	if (reg != NULL && reg->host_user_addr) {
> +		munmap(reg->mmap_addr, reg->mmap_size);
> +		close(reg->fd);
> +		memset(reg, 0, sizeof(struct rte_vhost_mem_region));
> +	}
> +}
> +
> +static void
> +free_all_mem_regions(struct virtio_net *dev)
>   {
>   	uint32_t i;
>   	struct rte_vhost_mem_region *reg;
> @@ -239,12 +252,10 @@ free_mem_region(struct virtio_net *dev)
>   	if (dev->async_copy && rte_vfio_is_enabled("vfio"))
>   		async_dma_map(dev, false);
>   
> -	for (i = 0; i < dev->mem->nregions; i++) {
> +	for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
>   		reg = &dev->mem->regions[i];
> -		if (reg->host_user_addr) {
> -			munmap(reg->mmap_addr, reg->mmap_size);
> -			close(reg->fd);
> -		}
> +		if (reg->mmap_addr)
> +			free_mem_region(reg);

Please split this patch in multiple ones.
Do the refactorings in dedicated patches.

>   	}
>   }
>   
> @@ -258,7 +269,7 @@ vhost_backend_cleanup(struct virtio_net *dev)
>   		vdpa_dev->ops->dev_cleanup(dev->vid);
>   
>   	if (dev->mem) {
> -		free_mem_region(dev);
> +		free_all_mem_regions(dev);
>   		rte_free(dev->mem);
>   		dev->mem = NULL;
>   	}
> @@ -707,7 +718,7 @@ numa_realloc(struct virtio_net **pdev, struct vhost_virtqueue **pvq)
>   	vhost_devices[dev->vid] = dev;
>   
>   	mem_size = sizeof(struct rte_vhost_memory) +
> -		sizeof(struct rte_vhost_mem_region) * dev->mem->nregions;
> +		sizeof(struct rte_vhost_mem_region) * VHOST_MEMORY_MAX_NREGIONS;
>   	mem = rte_realloc_socket(dev->mem, mem_size, 0, node);
>   	if (!mem) {
>   		VHOST_CONFIG_LOG(dev->ifname, ERR,
> @@ -811,8 +822,10 @@ hua_to_alignment(struct rte_vhost_memory *mem, void *ptr)
>   	uint32_t i;
>   	uintptr_t hua = (uintptr_t)ptr;
>   
> -	for (i = 0; i < mem->nregions; i++) {
> +	for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
>   		r = &mem->regions[i];
> +		if (r->host_user_addr == 0)
> +			continue;
>   		if (hua >= r->host_user_addr &&
>   			hua < r->host_user_addr + r->size) {
>   			return get_blk_size(r->fd);
> @@ -1250,9 +1263,13 @@ vhost_user_postcopy_register(struct virtio_net *dev, int main_fd,
>   	 * retrieve the region offset when handling userfaults.
>   	 */
>   	memory = &ctx->msg.payload.memory;
> -	for (i = 0; i < memory->nregions; i++) {
> +	for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
> +		int reg_msg_index = 0;
>   		reg = &dev->mem->regions[i];
> -		memory->regions[i].userspace_addr = reg->host_user_addr;
> +		if (reg->host_user_addr == 0)
> +			continue;
> +		memory->regions[reg_msg_index].userspace_addr = reg->host_user_addr;
> +		reg_msg_index++;
>   	}
>   
>   	/* Send the addresses back to qemu */
> @@ -1279,8 +1296,10 @@ vhost_user_postcopy_register(struct virtio_net *dev, int main_fd,
>   	}
>   
>   	/* Now userfault register and we can use the memory */
> -	for (i = 0; i < memory->nregions; i++) {
> +	for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
>   		reg = &dev->mem->regions[i];
> +		if (reg->host_user_addr == 0)
> +			continue;
>   		if (vhost_user_postcopy_region_register(dev, reg) < 0)
>   			return -1;
>   	}
> @@ -1385,6 +1404,46 @@ vhost_user_mmap_region(struct virtio_net *dev,
>   	return 0;
>   }
>   
> +static int
> +vhost_user_initialize_memory(struct virtio_net **pdev)
> +{
> +	struct virtio_net *dev = *pdev;
> +	int numa_node = SOCKET_ID_ANY;
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
>   static int
>   vhost_user_set_mem_table(struct virtio_net **pdev,
>   			struct vhu_msg_context *ctx,
> @@ -1393,7 +1452,6 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
>   	struct virtio_net *dev = *pdev;
>   	struct VhostUserMemory *memory = &ctx->msg.payload.memory;
>   	struct rte_vhost_mem_region *reg;
> -	int numa_node = SOCKET_ID_ANY;
>   	uint64_t mmap_offset;
>   	uint32_t i;
>   	bool async_notify = false;
> @@ -1438,39 +1496,13 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
>   		if (dev->features & (1ULL << VIRTIO_F_IOMMU_PLATFORM))
>   			vhost_user_iotlb_flush_all(dev);
>   
> -		free_mem_region(dev);
> +		free_all_mem_regions(dev);
>   		rte_free(dev->mem);
>   		dev->mem = NULL;
>   	}
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

This part should be refactored into a dedicated preliminary patch.

>   
>   	for (i = 0; i < memory->nregions; i++) {
>   		reg = &dev->mem->regions[i];
> @@ -1534,11 +1566,182 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
>   	return RTE_VHOST_MSG_RESULT_OK;
>   
>   free_mem_table:
> -	free_mem_region(dev);
> +	free_all_mem_regions(dev);
>   	rte_free(dev->mem);
>   	dev->mem = NULL;
> +	rte_free(dev->guest_pages);
> +	dev->guest_pages = NULL;
> +close_msg_fds:
> +	close_msg_fds(ctx);
> +	return RTE_VHOST_MSG_RESULT_ERR;
> +}
> +
> +
> +static int
> +vhost_user_get_max_mem_slots(struct virtio_net **pdev __rte_unused,
> +			struct vhu_msg_context *ctx,
> +			int main_fd __rte_unused)
> +{
> +	uint32_t max_mem_slots = VHOST_MEMORY_MAX_NREGIONS;

This VHOST_MEMORY_MAX_NREGIONS value was hardcoded when only
VHOST_USER_SET_MEM_TABLE was introduced.

With this new features, my understanding is that we can get rid off this
limit, right?

The good news is increasing it should not break the DPDK ABI.

Would it make sense to increase it?
> +
> +	ctx->msg.payload.u64 = (uint64_t)max_mem_slots;
> +	ctx->msg.size = sizeof(ctx->msg.payload.u64);
> +	ctx->fd_num = 0;
>   
> -free_guest_pages:
> +	return RTE_VHOST_MSG_RESULT_REPLY;
> +}
> +
> +static int
> +vhost_user_add_mem_reg(struct virtio_net **pdev,
> +			struct vhu_msg_context *ctx,
> +			int main_fd __rte_unused)
> +{
> +	struct virtio_net *dev = *pdev;
> +	struct VhostUserMemoryRegion *region = &ctx->msg.payload.memory_single.region;
> +	uint32_t i;
> +
> +	/* make sure new region will fit */
> +	if (dev->mem != NULL && dev->mem->nregions >= VHOST_MEMORY_MAX_NREGIONS) {
> +		VHOST_CONFIG_LOG(dev->ifname, ERR,
> +			"too many memory regions already (%u)",
> +			dev->mem->nregions);
> +		goto close_msg_fds;
> +	}
> +
> +	/* make sure supplied memory fd present */
> +	if (ctx->fd_num != 1) {
> +		VHOST_CONFIG_LOG(dev->ifname, ERR,
> +			"fd count makes no sense (%u)",
> +			ctx->fd_num);
> +		goto close_msg_fds;
> +	}

There is a lack of support for vDPA devices.
My understanding here is that the vDPA device does not get the new table 
entry.

In set_mem_table, we call its close callback, but that might be a bit 
too much for simple memory hotplug. we might need another mechanism.

> +
> +	/* Make sure no overlap in guest virtual address space */
> +	if (dev->mem != NULL && dev->mem->nregions > 0)	{
> +		for (uint32_t i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
> +			struct rte_vhost_mem_region *current_region = &dev->mem->regions[i];
> +
> +			if (current_region->mmap_size == 0)
> +				continue;
> +
> +			uint64_t current_region_guest_start = current_region->guest_user_addr;
> +			uint64_t current_region_guest_end = current_region_guest_start
> +								+ current_region->mmap_size - 1;

Shouldn't it use size instead of mmap_size to check for overlaps?

> +			uint64_t proposed_region_guest_start = region->userspace_addr;
> +			uint64_t proposed_region_guest_end = proposed_region_guest_start
> +								+ region->memory_size - 1;
> +			bool overlap = false;
> +
> +			bool current_region_guest_start_overlap =
> +				current_region_guest_start >= proposed_region_guest_start
> +				&& current_region_guest_start <= proposed_region_guest_end;
> +			bool current_region_guest_end_overlap =
> +				current_region_guest_end >= proposed_region_guest_start
> +				&& current_region_guest_end <= proposed_region_guest_end;
> +			bool proposed_region_guest_start_overlap =
> +				proposed_region_guest_start >= current_region_guest_start
> +				&& proposed_region_guest_start <= current_region_guest_end;
> +			bool proposed_region_guest_end_overlap =
> +				proposed_region_guest_end >= current_region_guest_start
> +				&& proposed_region_guest_end <= current_region_guest_end;
> +
> +			overlap = current_region_guest_start_overlap
> +				|| current_region_guest_end_overlap
> +				|| proposed_region_guest_start_overlap
> +				|| proposed_region_guest_end_overlap;
> +
> +			if (overlap) {
> +				VHOST_CONFIG_LOG(dev->ifname, ERR,
> +					"requested memory region overlaps with another region");
> +				VHOST_CONFIG_LOG(dev->ifname, ERR,
> +					"\tRequested region address:0x%" PRIx64,
> +					region->userspace_addr);
> +				VHOST_CONFIG_LOG(dev->ifname, ERR,
> +					"\tRequested region size:0x%" PRIx64,
> +					region->memory_size);
> +				VHOST_CONFIG_LOG(dev->ifname, ERR,
> +					"\tOverlapping region address:0x%" PRIx64,
> +					current_region->guest_user_addr);
> +				VHOST_CONFIG_LOG(dev->ifname, ERR,
> +					"\tOverlapping region size:0x%" PRIx64,
> +					current_region->mmap_size);
> +				goto close_msg_fds;
> +			}
> +
> +		}
> +	}
> +
> +	/* convert first region add to normal memory table set */
> +	if (dev->mem == NULL) {
> +		if (vhost_user_initialize_memory(pdev) < 0)
> +			goto close_msg_fds;
> +	}
> +
> +	/* find a new region and set it like memory table set does */
> +	struct rte_vhost_mem_region *reg = NULL;
> +	uint64_t mmap_offset;
> +
> +	for (uint32_t i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
> +		if (dev->mem->regions[i].guest_user_addr == 0) {
> +			reg = &dev->mem->regions[i];
> +			break;
> +		}
> +	}
> +	if (reg == NULL) {
> +		VHOST_CONFIG_LOG(dev->ifname, ERR, "no free memory region");
> +		goto close_msg_fds;
> +	}
> +
> +	reg->guest_phys_addr = region->guest_phys_addr;
> +	reg->guest_user_addr = region->userspace_addr;
> +	reg->size            = region->memory_size;
> +	reg->fd              = ctx->fds[0];
> +
> +	mmap_offset = region->mmap_offset;
> +
> +	if (vhost_user_mmap_region(dev, reg, mmap_offset) < 0) {
> +		VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to mmap region");
> +		goto close_msg_fds;
> +	}
> +
> +	dev->mem->nregions++;
> +
> +	if (dev->async_copy && rte_vfio_is_enabled("vfio"))
> +		async_dma_map(dev, true);
> +
> +	if (vhost_user_postcopy_register(dev, main_fd, ctx) < 0)
> +		goto free_mem_table;
> +
> +	for (i = 0; i < dev->nr_vring; i++) {
> +		struct vhost_virtqueue *vq = dev->virtqueue[i];
> +
> +		if (!vq)
> +			continue;
> +
> +		if (vq->desc || vq->avail || vq->used) {
> +			/* vhost_user_lock_all_queue_pairs locked all qps */
> +			VHOST_USER_ASSERT_LOCK(dev, vq, VHOST_USER_SET_MEM_TABLE);

VHOST_USER_ASSERT_LOCK(dev, vq, VHOST_USER_ADD_MEM_REG); ?

> +
> +			/*
> +			 * If the memory table got updated, the ring addresses
> +			 * need to be translated again as virtual addresses have
> +			 * changed.
> +			 */
> +			vring_invalidate(dev, vq);
> +
> +			translate_ring_addresses(&dev, &vq);
> +			*pdev = dev;
> +		}
> +	}
> +
> +	dump_guest_pages(dev);
> +
> +	return RTE_VHOST_MSG_RESULT_OK;
> +
> +free_mem_table:
> +	free_all_mem_regions(dev);
> +	rte_free(dev->mem);
> +	dev->mem = NULL;
>   	rte_free(dev->guest_pages);
>   	dev->guest_pages = NULL;
>   close_msg_fds:
> @@ -1546,6 +1749,40 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
>   	return RTE_VHOST_MSG_RESULT_ERR;
>   }
>   
> +static int
> +vhost_user_rem_mem_reg(struct virtio_net **pdev __rte_unused,
> +			struct vhu_msg_context *ctx __rte_unused,
> +			int main_fd __rte_unused)
> +{
> +	struct virtio_net *dev = *pdev;
> +	struct VhostUserMemoryRegion *region = &ctx->msg.payload.memory_single.region;
> +

It lacks support for vDPA devices.
In set_mem_table, we call the vDPA close cb to ensure it is not actively 
accessing memoring being unmapped.

We need something similar here, otherwise the vDPA device is not aware 
of the memory being unplugged.

> +	if (dev->mem != NULL && dev->mem->nregions > 0) {
> +		for (uint32_t i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
> +			struct rte_vhost_mem_region *current_region = &dev->mem->regions[i];
> +
> +			if (current_region->guest_user_addr == 0)
> +				continue;
> +
> +			/*
> +			 * According to the vhost-user specification:
> +			 * The memory region to be removed is identified by its guest address,
> +			 * user address and size. The mmap offset is ignored.
> +			 */
> +			if (region->userspace_addr == current_region->guest_user_addr
> +				&& region->guest_phys_addr == current_region->guest_phys_addr
> +				&& region->memory_size == current_region->size) {
> +				free_mem_region(current_region);
> +				dev->mem->nregions--;
> +				return RTE_VHOST_MSG_RESULT_OK;
> +			}

There is a lack of IOTLB entries invalidation here, as IOTLB entries in
the cache could point to memory being unmapped in this function.

Same comment for vring invalidation, as the vring adresses are not re-
translated at each burst.

> +		}
> +	}
> +
> +	VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to find region");
> +	return RTE_VHOST_MSG_RESULT_ERR;
> +}
> +
>   static bool
>   vq_is_ready(struct virtio_net *dev, struct vhost_virtqueue *vq)
>   {
> diff --git a/lib/vhost/vhost_user.h b/lib/vhost/vhost_user.h
> index ef486545ba..5a0e747b58 100644
> --- a/lib/vhost/vhost_user.h
> +++ b/lib/vhost/vhost_user.h
> @@ -32,6 +32,7 @@
>   					 (1ULL << VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD) | \
>   					 (1ULL << VHOST_USER_PROTOCOL_F_HOST_NOTIFIER) | \
>   					 (1ULL << VHOST_USER_PROTOCOL_F_PAGEFAULT) | \
> +					 (1ULL << VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS) | \
>   					 (1ULL << VHOST_USER_PROTOCOL_F_STATUS))
>   
>   typedef enum VhostUserRequest {
> @@ -67,6 +68,9 @@ typedef enum VhostUserRequest {
>   	VHOST_USER_POSTCOPY_END = 30,
>   	VHOST_USER_GET_INFLIGHT_FD = 31,
>   	VHOST_USER_SET_INFLIGHT_FD = 32,
> +	VHOST_USER_GET_MAX_MEM_SLOTS = 36,
> +	VHOST_USER_ADD_MEM_REG = 37,
> +	VHOST_USER_REM_MEM_REG = 38,
>   	VHOST_USER_SET_STATUS = 39,
>   	VHOST_USER_GET_STATUS = 40,
>   } VhostUserRequest;
> @@ -91,6 +95,11 @@ typedef struct VhostUserMemory {
>   	VhostUserMemoryRegion regions[VHOST_MEMORY_MAX_NREGIONS];
>   } VhostUserMemory;
>   
> +typedef struct VhostUserSingleMemReg {
> +	uint64_t padding;
> +	VhostUserMemoryRegion region;
> +} VhostUserSingleMemReg;
> +
>   typedef struct VhostUserLog {
>   	uint64_t mmap_size;
>   	uint64_t mmap_offset;
> @@ -186,6 +195,7 @@ typedef struct __rte_packed_begin VhostUserMsg {
>   		struct vhost_vring_state state;
>   		struct vhost_vring_addr addr;
>   		VhostUserMemory memory;
> +		VhostUserSingleMemReg memory_single;
>   		VhostUserLog    log;
>   		struct vhost_iotlb_msg iotlb;
>   		VhostUserCryptoSessionParam crypto_session;

