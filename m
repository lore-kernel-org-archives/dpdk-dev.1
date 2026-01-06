Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169CECE9D78
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 16:29:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EBC34069F;
	Tue,  6 Jan 2026 17:29:32 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3723D402DC
 for <dev@dpdk.org>; Tue,  6 Jan 2026 17:29:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767716969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IxK1Xk0ydHqNpGuYeufLcypRDhYCqx+uVhNVkrgMlPg=;
 b=MKwXyXFlHAFGFwmZWaUGaNKxV6Elc9EyMr9Q/KSdW5mvTz/j4Xi2DfBiYuslIlwf4DX9N3
 Q+XYhbVgLWulcpADIvc8NasV3mZ76Qhs4350n61s4EmAOlCR46Jev/bs3ZrMLyl73hgh74
 MsusVxZDpcIM1pokQ46zjwHejk9L4wM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-r6qGoZxJM3WVBpZQG5LmSA-1; Tue,
 06 Jan 2026 11:29:28 -0500
X-MC-Unique: r6qGoZxJM3WVBpZQG5LmSA-1
X-Mimecast-MFC-AGG-ID: r6qGoZxJM3WVBpZQG5LmSA_1767716967
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F36391956063; Tue,  6 Jan 2026 16:29:26 +0000 (UTC)
Received: from [10.45.242.22] (unknown [10.45.242.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B82819560AB; Tue,  6 Jan 2026 16:29:25 +0000 (UTC)
Message-ID: <db79f122-fc59-4c2e-b44f-97de3131c967@redhat.com>
Date: Tue, 6 Jan 2026 17:29:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] vhost_user: support function defines for back-end
To: Pravin M Bathija <pravin.bathija@dell.com>, dev@dpdk.org
Cc: pravin.m.bathija.dev@gmail.com
References: <20251113124425.2913881-1-pravin.bathija@dell.com>
 <20251113124425.2913881-4-pravin.bathija@dell.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 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
 Mwqu3GQ=
In-Reply-To: <20251113124425.2913881-4-pravin.bathija@dell.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aat2uGES0R0S3itn0yft-Ocl0oX1xVKbovF2pl41AZw_1767716967
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
> Here we define support functions which are called from the various
> vhost-user back-end message functions like set memory table, get
> memory slots, add memory region, remove memory region.  These are
> essentially common functions to initialize memory, unmap a set of
> memory regions, perform register copy, align memory addresses and
> dma map/unmap a single memory region.
> 
> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
> ---
>   lib/vhost/vhost_user.c | 150 ++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 140 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
> index 4bfb13fb98..7dc21fe42a 100644
> --- a/lib/vhost/vhost_user.c
> +++ b/lib/vhost/vhost_user.c
> @@ -171,6 +171,80 @@ get_blk_size(int fd)
>   	return ret == -1 ? (uint64_t)-1 : (uint64_t)stat.st_blksize;
>   }
>   
> +static void
> +async_dma_map_region(struct virtio_net *dev, struct rte_vhost_mem_region *reg, bool do_map)
> +{
> +	uint32_t i;
> +	int ret = 0;
> +	int found = 0;
> +	struct guest_page *page;
> +
> +	uint64_t reg_size = reg->size;
> +	uint64_t host_user_addr  = reg->host_user_addr;
> +
> +	for (i = 0; i < dev->nr_guest_pages; i++) {
> +		page = &dev->guest_pages[i];
> +		if (host_user_addr == page->host_user_addr) {
> +			found = 1;
> +			break;
> +		}
> +	}
> +
> +	if (!found) {
> +		VHOST_CONFIG_LOG(dev->ifname, ERR, "DMA engine map: region not found");
> +		return;
> +	}
> +
> +	if (do_map) {
> +		while (reg_size) {
> +			page = &dev->guest_pages[i];
> +			ret = rte_vfio_container_dma_map(RTE_VFIO_DEFAULT_CONTAINER_FD,
> +					page->host_user_addr,
> +					page->host_iova,
> +					page->size);
> +			if (ret) {
> +				if (rte_errno == ENODEV)
> +					return;
> +
> +				/* DMA mapping errors won't stop VHOST_USER_SET_MEM_TABLE. */
> +				VHOST_CONFIG_LOG(dev->ifname, ERR, "DMA engine map failed");
> +			}
> +
> +			reg_size -= page->size;
> +			++i;
> +			if (i >= dev->nr_guest_pages) {
> +				/* shouldn't get here */
> +				VHOST_CONFIG_LOG(dev->ifname, ERR, "DMA engine map: No more pages");
> +				return;
> +			}
> +		}
> +	} else {
> +		while (reg_size) {
> +			page = &dev->guest_pages[i];
> +			ret = rte_vfio_container_dma_unmap(RTE_VFIO_DEFAULT_CONTAINER_FD,
> +					page->host_user_addr,
> +					page->host_iova,
> +					page->size);
> +			if (ret) {
> +				if (rte_errno == EINVAL)
> +					return;
> +
> +				/* DMA mapping errors won't stop VHOST_USER_SET_MEM_TABLE. */
> +				VHOST_CONFIG_LOG(dev->ifname, ERR, "DMA engine unmap failed");
> +			}
> +
> +			reg_size -= page->size;
> +			++i;
> +			if (i >= dev->nr_guest_pages) {
> +				/* shouldn't get here */
> +				VHOST_CONFIG_LOG(dev->ifname, ERR, "DMA engine unmap: No more pages");
> +				return;
> +			}
> +		}
> +	}
> +
> +}
> +
>   static void
>   async_dma_map(struct virtio_net *dev, bool do_map)
>   {
> @@ -225,7 +299,17 @@ async_dma_map(struct virtio_net *dev, bool do_map)
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
> @@ -236,12 +320,10 @@ free_mem_region(struct virtio_net *dev)
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
>   	}
>   }
>   
> @@ -255,7 +337,7 @@ vhost_backend_cleanup(struct virtio_net *dev)
>   		vdpa_dev->ops->dev_cleanup(dev->vid);
>   
>   	if (dev->mem) {
> -		free_mem_region(dev);
> +		free_all_mem_regions(dev);
>   		rte_free(dev->mem);
>   		dev->mem = NULL;
>   	}
> @@ -704,7 +786,7 @@ numa_realloc(struct virtio_net **pdev, struct vhost_virtqueue **pvq)
>   	vhost_devices[dev->vid] = dev;
>   
>   	mem_size = sizeof(struct rte_vhost_memory) +
> -		sizeof(struct rte_vhost_mem_region) * dev->mem->nregions;
> +		sizeof(struct rte_vhost_mem_region) * VHOST_MEMORY_MAX_NREGIONS;
>   	mem = rte_realloc_socket(dev->mem, mem_size, 0, node);
>   	if (!mem) {
>   		VHOST_CONFIG_LOG(dev->ifname, ERR,
> @@ -808,8 +890,10 @@ hua_to_alignment(struct rte_vhost_memory *mem, void *ptr)
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
> @@ -1248,8 +1332,12 @@ vhost_user_postcopy_register(struct virtio_net *dev, int main_fd,
>   	 */
>   	memory = &ctx->msg.payload.memory;
>   	for (i = 0; i < memory->nregions; i++) {
> +		int reg_msg_index = 0;
>   		reg = &dev->mem->regions[i];
> -		memory->regions[i].userspace_addr = reg->host_user_addr;
> +		if (reg->host_user_addr == 0)
> +			continue;
> +		memory->regions[reg_msg_index].userspace_addr = reg->host_user_addr;
> +		reg_msg_index++;

How is it supposed to work?
reg_msg_index is re-initialized to 0 at each iteration.

>   	}
>   
>   	/* Send the addresses back to qemu */
> @@ -1278,6 +1366,8 @@ vhost_user_postcopy_register(struct virtio_net *dev, int main_fd,
>   	/* Now userfault register and we can use the memory */
>   	for (i = 0; i < memory->nregions; i++) {
>   		reg = &dev->mem->regions[i];
> +		if (reg->host_user_addr == 0)
> +			continue;
>   		if (vhost_user_postcopy_region_register(dev, reg) < 0)
>   			return -1;
>   	}
> @@ -1382,6 +1472,46 @@ vhost_user_mmap_region(struct virtio_net *dev,
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
> +		dev->max_guest_pages = VHOST_MEMORY_MAX_NREGIONS;
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

