Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECCDCCFA00
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 07:48:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D7E94028C;
	Tue,  4 Nov 2025 08:48:56 +0100 (CET)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id 7915D40285
 for <dev@dpdk.org>; Tue,  4 Nov 2025 08:48:54 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=WxsbEVydRyj5Ox+oeRUioZQS6rtKunJHy+SQBJvz0ms=;
 b=y3oWAmJ5Sj0nuPpIoYfZxR6fTFWA8+yQ8RnykRzUd0zUEMrWvJcOSBhGTCAGZ+Aq2oiXweJx3
 Eg/oVuV/kjc0Sd/Z2xnoYPifL6M6Bab23cNq65Ujg7oBCc7TdghC82W3wQ+r+USQUP2cGXefUu6
 daVLHf8vP8o2pvvyjqV1CWs=
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4d10sf1jcdzRhRp;
 Tue,  4 Nov 2025 15:47:18 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 4B843140156;
 Tue,  4 Nov 2025 15:48:52 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 15:48:51 +0800
Message-ID: <3ae04cac-b80b-4cc4-900e-41e7669ada40@huawei.com>
Date: Tue, 4 Nov 2025 15:48:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] vhost_user: Function defs for add/rem mem regions
To: Pravin M Bathija <pravin.bathija@dell.com>, <dev@dpdk.org>
CC: <pravin.m.bathija.dev@gmail.com>
References: <20251104042142.2787631-1-pravin.bathija@dell.com>
 <20251104042142.2787631-4-pravin.bathija@dell.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251104042142.2787631-4-pravin.bathija@dell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

On 11/4/2025 12:21 PM, Pravin M Bathija wrote:
> These changes cover the function definition for add/remove memory
> region calls which are invoked on receiving vhost user message from
> vhost user front-end (e.g. Qemu). The vhost-user front end sw sends
> an add memory region message which includes the guest physical address
> range(GPA), memory size, front-end's virtual address and offset within
> tha file-descriptor mapping. The back-end(dpdk) uses this information
> to create a mapping within it's own address space using mmap on the
> fd + offset.  This added memory region serves as sshared memory to pass
> data back and forth between vhost-user front and back ends. Similarly in
> the case of remove memory region, the said memory region is unmapped from
> the back-end(dpdk). In our case, in addition to testing with qemu front-end,
> the testing has also been performed with libblkio front-end and spdk/dpdk
> back-end. We did I/O using libblkio based device driver, to spdk based drives.
> There are also changes for set mem table and new definition for get memory slots.
> The message vhost set memory table essentially is how the vhost-user front-end
> (qemu or libblkio) tells vhost-user back-end (dpdk) about all of it's guest
> memory regions.  This allows the back-end to translate guest physical addresses
> to back-end virtual addresses and perform direct I/O to guest memory. Our changes
> optimize the set memory table call to use common support functions. Message get
> memory slots is how the vhost-user front-end queries the vhost-user back-end about
> the number of memory slots available to be registered by the back-end.

Too much useless information in the commit log, this features is a de facto standard,
and it supported from early qemu version (6.2 as I know), so I think we could simplfy
the commit log.

> 
> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
> ---
>  lib/vhost/vhost_user.c | 253 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 221 insertions(+), 32 deletions(-)
> 
> diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
> index 4bfb13fb98..168432e7d1 100644
> --- a/lib/vhost/vhost_user.c
> +++ b/lib/vhost/vhost_user.c
> @@ -71,6 +71,9 @@ VHOST_MESSAGE_HANDLER(VHOST_USER_SET_FEATURES, vhost_user_set_features, false, t
>  VHOST_MESSAGE_HANDLER(VHOST_USER_SET_OWNER, vhost_user_set_owner, false, true) \
>  VHOST_MESSAGE_HANDLER(VHOST_USER_RESET_OWNER, vhost_user_reset_owner, false, false) \
>  VHOST_MESSAGE_HANDLER(VHOST_USER_SET_MEM_TABLE, vhost_user_set_mem_table, true, true) \
> +VHOST_MESSAGE_HANDLER(VHOST_USER_GET_MAX_MEM_SLOTS, vhost_user_get_max_mem_slots, false, false) \
> +VHOST_MESSAGE_HANDLER(VHOST_USER_ADD_MEM_REG, vhost_user_add_mem_reg, true, true) \
> +VHOST_MESSAGE_HANDLER(VHOST_USER_REM_MEM_REG, vhost_user_rem_mem_reg, false, true) \
>  VHOST_MESSAGE_HANDLER(VHOST_USER_SET_LOG_BASE, vhost_user_set_log_base, true, true) \
>  VHOST_MESSAGE_HANDLER(VHOST_USER_SET_LOG_FD, vhost_user_set_log_fd, true, true) \
>  VHOST_MESSAGE_HANDLER(VHOST_USER_SET_VRING_NUM, vhost_user_set_vring_num, false, true) \
> @@ -1390,7 +1393,6 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
>  	struct virtio_net *dev = *pdev;
>  	struct VhostUserMemory *memory = &ctx->msg.payload.memory;
>  	struct rte_vhost_mem_region *reg;
> -	int numa_node = SOCKET_ID_ANY;
>  	uint64_t mmap_offset;
>  	uint32_t i;
>  	bool async_notify = false;
> @@ -1435,39 +1437,13 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
>  		if (dev->features & (1ULL << VIRTIO_F_IOMMU_PLATFORM))
>  			vhost_user_iotlb_flush_all(dev);
>  
> -		free_mem_region(dev);
> +		free_all_mem_regions(dev);
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
> @@ -1531,11 +1507,182 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
>  	return RTE_VHOST_MSG_RESULT_OK;
>  
>  free_mem_table:
> -	free_mem_region(dev);
> +	free_all_mem_regions(dev);
>  	rte_free(dev->mem);
>  	dev->mem = NULL;
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
> +static int
> +vhost_user_add_mem_reg(struct virtio_net **pdev,
> +			struct vhu_msg_context *ctx,
> +			int main_fd __rte_unused)
> +{
> +	struct virtio_net *dev = *pdev;
> +	struct VhostUserMemoryRegion *region = &ctx->msg.payload.memory_single.region;

Please put long line in front.

> +	uint32_t i;
> +
> +	/* make sure new region will fit */
> +	if (dev->mem != NULL && dev->mem->nregions >= VHOST_MEMORY_MAX_NREGIONS) {
> +		VHOST_CONFIG_LOG(dev->ifname, ERR,
> +			"too many memory regions already (%u)",
> +			dev->mem->nregions);

Currently support 100 char per line. So maybe we could put the log oneline. the same for below log.

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
> +			uint64_t proposed_region_guest_start = region->userspace_addr;
> +			uint64_t proposed_region_guest_end = proposed_region_guest_start
> +								+ region->memory_size - 1;
> +			bool overlap = false;
> +
> +			bool curent_region_guest_start_overlap =
> +				current_region_guest_start >= proposed_region_guest_start
> +				&& current_region_guest_start <= proposed_region_guest_end;

the && should put tail of line according DPDK coding style.

> +			bool curent_region_guest_end_overlap =
> +				current_region_guest_end >= proposed_region_guest_start
> +				&& current_region_guest_end <= proposed_region_guest_end;
> +			bool proposed_region_guest_start_overlap =
> +				proposed_region_guest_start >= current_region_guest_start
> +				&& proposed_region_guest_start <= current_region_guest_end;
> +			bool proposed_region_guest_end_overlap =
> +				proposed_region_guest_end >= current_region_guest_start
> +				&& proposed_region_guest_end <= current_region_guest_end;
> +
> +			overlap = curent_region_guest_start_overlap
> +				|| curent_region_guest_end_overlap
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

how about add sub function to wrap the check?

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

I think we could put this judgement at the beginning of function, so that we could
drop so many judgement for 'if (dev->mem == NULL)'

> +
> +	/* find a new region and set it like memory table set does */
> +	struct rte_vhost_mem_region *reg = NULL;
> +	uint64_t mmap_offset;

Suggest place them at the beginning of function.

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

no need to define mmap_offset which only used once.

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

it will map all region, we should map only this region.

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
>  	rte_free(dev->guest_pages);
>  	dev->guest_pages = NULL;
>  close_msg_fds:
> @@ -1543,6 +1690,48 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
>  	return RTE_VHOST_MSG_RESULT_ERR;
>  }
>  
> +static int
> +vhost_user_rem_mem_reg(struct virtio_net **pdev __rte_unused,
> +			struct vhu_msg_context *ctx __rte_unused,
> +			int main_fd __rte_unused)
> +{
> +	struct virtio_net *dev = *pdev;
> +	struct VhostUserMemoryRegion *region = &ctx->msg.payload.memory_single.region;
> +
> +	if ((dev->mem) && (dev->flags & VIRTIO_DEV_VDPA_CONFIGURED)) {
> +		struct rte_vdpa_device *vdpa_dev = dev->vdpa_dev;
> +
> +		if (vdpa_dev && vdpa_dev->ops->dev_close)
> +			vdpa_dev->ops->dev_close(dev->vid);
> +		dev->flags &= ~VIRTIO_DEV_VDPA_CONFIGURED;

The DPDK's vdpa devices will not report the new feature, so this will be dead code I think.

> +	}
> +
> +	if (dev->mem != NULL && dev->mem->nregions > 0) {
> +		for (uint32_t i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {

suggest i defined in beginning of func.

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

I checked the 4/5 commit, and we should do async_dma unmap this region here.

Beside, should we invalidate vring here?

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
>  static bool
>  vq_is_ready(struct virtio_net *dev, struct vhost_virtqueue *vq)
>  {

