Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6BCCE9D7D
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 16:36:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65F584069F;
	Tue,  6 Jan 2026 17:36:48 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E7110402DC
 for <dev@dpdk.org>; Tue,  6 Jan 2026 17:36:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767717406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fL3MAp15KVa6Xni5CmqyFS/hGIfVjkVr02Cfj40w1Ag=;
 b=Pr6d8ORdamRlQtmMHMJ7X6BuzfG1XhPk/D+rE0vKKhfEWxdAV7BtZcfvLMbJ1nqITirsrb
 o1rnOL8PdK3bqT1tbCK+FUzZV0Vyg59c8rwxt9lpl1rUKpWP0ALVeGQ8/efVs7RcANCJBa
 I/tGgk8m6fb1GdSNE1kTOs/gdpaGLys=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-sz7cdgmjMs22MmVVeSdqFw-1; Tue,
 06 Jan 2026 11:36:43 -0500
X-MC-Unique: sz7cdgmjMs22MmVVeSdqFw-1
X-Mimecast-MFC-AGG-ID: sz7cdgmjMs22MmVVeSdqFw_1767717402
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 735D9195FDC3; Tue,  6 Jan 2026 16:36:41 +0000 (UTC)
Received: from [10.45.242.22] (unknown [10.45.242.22])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF60618004D8; Tue,  6 Jan 2026 16:36:39 +0000 (UTC)
Message-ID: <0b163dd2-a981-4927-921a-fe4861c2bc13@redhat.com>
Date: Tue, 6 Jan 2026 17:36:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] vhost_user: Function defs for add/rem mem regions
To: Pravin M Bathija <pravin.bathija@dell.com>, dev@dpdk.org
Cc: pravin.m.bathija.dev@gmail.com
References: <20251113124425.2913881-1-pravin.bathija@dell.com>
 <20251113124425.2913881-5-pravin.bathija@dell.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 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
 Mwqu3GQ=
In-Reply-To: <20251113124425.2913881-5-pravin.bathija@dell.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cv6gZQAdEOCvBAv_nW9ygUhffjor-NDu7vYqwJ-Vry0_1767717402
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



On 11/13/25 1:44 PM, Pravin M Bathija wrote:
> These changes cover the function definition for add/remove memory
> region calls which are invoked on receiving vhost user message from
> vhost user front-end (e.g. Qemu). In our case, in addition to testing
> with qemu front-end, the testing has also been performed with libblkio
> front-end and spdk/dpdk back-end. We did I/O using libblkio based device
> driver, to spdk based drives. There are also changes for set_mem_table
> and new definition for get memory slots. Our changes optimize the set
> memory table call to use common support functions. Message get memory
> slots is how the vhost-user front-end queries the vhost-user back-end
> about the number of memory slots available to be registered by the
> back-end. In addition support function to invalidate vring is also
> defined which is used in add/remove memory region functions.
> 
> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
> ---
>   lib/vhost/vhost_user.c | 249 +++++++++++++++++++++++++++++++++++------
>   1 file changed, 217 insertions(+), 32 deletions(-)
> 
> diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
> index 7dc21fe42a..d9cf967ba2 100644
> --- a/lib/vhost/vhost_user.c
> +++ b/lib/vhost/vhost_user.c
> @@ -71,6 +71,9 @@ VHOST_MESSAGE_HANDLER(VHOST_USER_SET_FEATURES, vhost_user_set_features, false, t
>   VHOST_MESSAGE_HANDLER(VHOST_USER_SET_OWNER, vhost_user_set_owner, false, true) \
>   VHOST_MESSAGE_HANDLER(VHOST_USER_RESET_OWNER, vhost_user_reset_owner, false, false) \
>   VHOST_MESSAGE_HANDLER(VHOST_USER_SET_MEM_TABLE, vhost_user_set_mem_table, true, true) \
> +VHOST_MESSAGE_HANDLER(VHOST_USER_GET_MAX_MEM_SLOTS, vhost_user_get_max_mem_slots, false, false) \
> +VHOST_MESSAGE_HANDLER(VHOST_USER_ADD_MEM_REG, vhost_user_add_mem_reg, true, true) \
> +VHOST_MESSAGE_HANDLER(VHOST_USER_REM_MEM_REG, vhost_user_rem_mem_reg, false, true) \
>   VHOST_MESSAGE_HANDLER(VHOST_USER_SET_LOG_BASE, vhost_user_set_log_base, true, true) \
>   VHOST_MESSAGE_HANDLER(VHOST_USER_SET_LOG_FD, vhost_user_set_log_fd, true, true) \
>   VHOST_MESSAGE_HANDLER(VHOST_USER_SET_VRING_NUM, vhost_user_set_vring_num, false, true) \
> @@ -1520,7 +1523,6 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
>   	struct virtio_net *dev = *pdev;
>   	struct VhostUserMemory *memory = &ctx->msg.payload.memory;
>   	struct rte_vhost_mem_region *reg;
> -	int numa_node = SOCKET_ID_ANY;
>   	uint64_t mmap_offset;
>   	uint32_t i;
>   	bool async_notify = false;
> @@ -1565,39 +1567,13 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
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
>   
>   	for (i = 0; i < memory->nregions; i++) {
>   		reg = &dev->mem->regions[i];
> @@ -1661,11 +1637,182 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
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
>   
> -free_guest_pages:
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
> +dev_invalidate_vrings(struct virtio_net *dev)
> +{
> +	uint32_t i;
> +
> +	for (i = 0; i < dev->nr_vring; i++) {
> +		struct vhost_virtqueue *vq = dev->virtqueue[i];
> +
> +		if (!vq)
> +			continue;
> +
> +		if (vq->desc || vq->avail || vq->used) {
> +			/* vhost_user_lock_all_queue_pairs locked all qps */
> +			VHOST_USER_ASSERT_LOCK(dev, vq, VHOST_USER_ADD_MEM_REG);
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
> +}
> +
> +static int
> +vhost_user_add_mem_reg(struct virtio_net **pdev,
> +			struct vhu_msg_context *ctx,
> +			int main_fd __rte_unused)
> +{
> +	uint32_t i;
> +	struct virtio_net *dev = *pdev;
> +	struct VhostUserMemoryRegion *region = &ctx->msg.payload.memory_single.region;
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
> +	if (dev->mem != NULL && dev->mem->nregions > 0)	{
> +		for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
> +			struct rte_vhost_mem_region *current_region = &dev->mem->regions[i];
> +
> +			if (current_region->mmap_size == 0)
> +				continue;
> +
> +			uint64_t current_region_guest_start = current_region->guest_user_addr;
> +			uint64_t current_region_guest_end = current_region_guest_start
> +								+ current_region->mmap_size - 1;
> +			uint64_t proposed_region_guest_start = region->userspace_addr;
> +			uint64_t proposed_region_guest_end = proposed_region_guest_start
> +								+ region->memory_size - 1;
> +			bool overlap = false;
> +
> +			bool curent_region_guest_start_overlap =

s/curent/current/

> +				current_region_guest_start >= proposed_region_guest_start &&
> +				current_region_guest_start <= proposed_region_guest_end;
> +			bool curent_region_guest_end_overlap =
> +				current_region_guest_end >= proposed_region_guest_start &&
> +				current_region_guest_end <= proposed_region_guest_end;

Ditto

> +			bool proposed_region_guest_start_overlap =
> +				proposed_region_guest_start >= current_region_guest_start &&
> +				proposed_region_guest_start <= current_region_guest_end;
> +			bool proposed_region_guest_end_overlap =
> +				proposed_region_guest_end >= current_region_guest_start &&
> +				proposed_region_guest_end <= current_region_guest_end;
> +
> +			overlap = curent_region_guest_start_overlap
> +				|| curent_region_guest_end_overlap
> +				|| proposed_region_guest_start_overlap
> +				|| proposed_region_guest_end_overlap;

Couldn't all the above be simplified with something like below?

overlap = !(proposed_region_guest_end < current_region_guest_start ||
                proposed_region_guest_start > current_region_guest_end);

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
> +	/* find a new region and set it like memory table set does */
> +	struct rte_vhost_mem_region *reg = NULL;
> +
> +	for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
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
> +	if (vhost_user_mmap_region(dev, reg, region->mmap_offset) < 0) {
> +		VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to mmap region");
> +		goto close_msg_fds;
> +	}
> +
> +	dev->mem->nregions++;
> +
> +	if (dev->async_copy && rte_vfio_is_enabled("vfio"))
> +		async_dma_map_region(dev, reg, true);
> +
> +	if (vhost_user_postcopy_register(dev, main_fd, ctx) < 0)
> +		goto free_mem_table;
> +
> +	dev_invalidate_vrings(dev);
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
> @@ -1673,6 +1820,44 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
>   	return RTE_VHOST_MSG_RESULT_ERR;
>   }
>   
> +static int
> +vhost_user_rem_mem_reg(struct virtio_net **pdev __rte_unused,
> +			struct vhu_msg_context *ctx __rte_unused,
> +			int main_fd __rte_unused)
> +{
> +	uint32_t i;
> +	struct virtio_net *dev = *pdev;

pdev is marked 'unused', it needs to be fixed.

> +	struct VhostUserMemoryRegion *region = &ctx->msg.payload.memory_single.region;

Same for ctx.

> +
> +	if (dev->mem != NULL && dev->mem->nregions > 0) {
> +		for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
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
> +				if (dev->async_copy && rte_vfio_is_enabled("vfio"))
> +					async_dma_map_region(dev, current_region, false);
> +				dev_invalidate_vrings(dev);
> +				free_mem_region(current_region);
> +				dev->mem->nregions--;
> +				return RTE_VHOST_MSG_RESULT_OK;
> +			}
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

