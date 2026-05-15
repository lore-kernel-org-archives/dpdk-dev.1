Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A047CD4F25
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 May 2026 00:33:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C17940274;
	Fri, 15 May 2026 02:33:09 +0200 (CEST)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id 8836540151
 for <dev@dpdk.org>; Fri, 15 May 2026 02:33:07 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=kd9nJ5nojLqeX0zkuF36erxgbqVN9CK+6cQDhjwZRRE=;
 b=KM9jNdMO5P6bGRmHY0T7hF96ynr4h/PukeXCPMSuW163ZvJQxhOl3d/JaL0XNHzdlWwb0fnqZ
 RkUf73NL1CU7vxlWady4KiDlI57OOIQb0fXIKRBwbmQihEQB1hkLzZmCk9ZHgJmsRknuQ8aCP4E
 WxF5sIJD72rxHk0Pt+6Zcmk=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gGnz55MNgz1T4G6;
 Fri, 15 May 2026 08:25:21 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 678C72025F;
 Fri, 15 May 2026 08:33:05 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 May 2026 08:33:04 +0800
Message-ID: <4663f567-0167-415d-ba5a-c1133ae0f7f5@huawei.com>
Date: Fri, 15 May 2026 08:33:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 3/5] vhost_user: support function defines for back-end
To: <pravin.bathija@dell.com>, <dev@dpdk.org>, <stephen@networkplumber.org>,
 <maxime.coquelin@redhat.com>
CC: <thomas@monjalon.net>
References: <20260514224627.2014566-1-pravin.bathija@dell.com>
 <20260514224627.2014566-4-pravin.bathija@dell.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260514224627.2014566-4-pravin.bathija@dell.com>
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

please use vhost as the commit title prefix (please use git blame to refer),
the same as other commit in this patchset.

How about: vhost: refactor memory helper functions

On 5/15/2026 6:46 AM, pravin.bathija@dell.com wrote:
> From: Pravin M Bathija <pravin.bathija@dell.com>
> 
> Here we define support functions which are called from the various
> vhost-user back-end message functions like set memory table, get
> memory slots, add memory region, remove memory region.  These are
> essentially common functions to unmap a set of memory regions,
> perform register copy, align memory addresses and dma map/unmap a
> single memory region.

Two much detail, how about:

Extract reusable helper routines for vhost-user backend memory operations:
split DMA map/unmap into per-region logic, decouple and rework memory
region free routines, and iterate over VHOST_MEMORY_MAX_NREGIONS
uniformly across related functions to simplify code reuse.

As above fixed:
Acked-by: Chengwen Feng <fengchengwen@huawei.com>

> 
> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
> ---
>  lib/vhost/vhost_user.c | 89 ++++++++++++++++++++++++++++--------------
>  1 file changed, 60 insertions(+), 29 deletions(-)
> 
> diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
> index 4bfb13fb98..0ee3fe7a5e 100644
> --- a/lib/vhost/vhost_user.c
> +++ b/lib/vhost/vhost_user.c
> @@ -171,20 +171,27 @@ get_blk_size(int fd)
>  	return ret == -1 ? (uint64_t)-1 : (uint64_t)stat.st_blksize;
>  }
>  
> -static void
> -async_dma_map(struct virtio_net *dev, bool do_map)
> +static int
> +async_dma_map_region(struct virtio_net *dev, struct rte_vhost_mem_region *reg, bool do_map)
>  {
> -	int ret = 0;
>  	uint32_t i;
> -	struct guest_page *page;
> +	int ret;
> +	uint64_t reg_start = reg->host_user_addr;
> +	uint64_t reg_end = reg_start + reg->size;
> +
> +	for (i = 0; i < dev->nr_guest_pages; i++) {
> +		struct guest_page *page = &dev->guest_pages[i];
> +
> +		/* Only process pages belonging to this region */
> +		if (page->host_user_addr < reg_start ||
> +		    page->host_user_addr >= reg_end)
> +			continue;
>  
> -	if (do_map) {
> -		for (i = 0; i < dev->nr_guest_pages; i++) {
> -			page = &dev->guest_pages[i];
> +		if (do_map) {
>  			ret = rte_vfio_container_dma_map(RTE_VFIO_DEFAULT_CONTAINER_FD,
> -							 page->host_user_addr,
> -							 page->host_iova,
> -							 page->size);
> +					page->host_user_addr,
> +					page->host_iova,
> +					page->size);
>  			if (ret) {
>  				/*
>  				 * DMA device may bind with kernel driver, in this case,
> @@ -199,33 +206,57 @@ async_dma_map(struct virtio_net *dev, bool do_map)
>  				 * normal case in async path. This is a workaround.
>  				 */
>  				if (rte_errno == ENODEV)
> -					return;
> +					return 0;
>  
>  				/* DMA mapping errors won't stop VHOST_USER_SET_MEM_TABLE. */
>  				VHOST_CONFIG_LOG(dev->ifname, ERR, "DMA engine map failed");
> +				return -1;
>  			}
> -		}
> -
> -	} else {
> -		for (i = 0; i < dev->nr_guest_pages; i++) {
> -			page = &dev->guest_pages[i];
> +		} else {
>  			ret = rte_vfio_container_dma_unmap(RTE_VFIO_DEFAULT_CONTAINER_FD,
> -							   page->host_user_addr,
> -							   page->host_iova,
> -							   page->size);
> +					page->host_user_addr,
> +					page->host_iova,
> +					page->size);
>  			if (ret) {
>  				/* like DMA map, ignore the kernel driver case when unmap. */
>  				if (rte_errno == EINVAL)
> -					return;
> +					return 0;
>  
>  				VHOST_CONFIG_LOG(dev->ifname, ERR, "DMA engine unmap failed");
> +				return -1;
>  			}
>  		}
>  	}
> +
> +	return 0;
> +}
> +
> +static void
> +async_dma_map(struct virtio_net *dev, bool do_map)
> +{
> +	uint32_t i;
> +	struct rte_vhost_mem_region *reg;
> +
> +	for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
> +		reg = &dev->mem->regions[i];
> +		if (reg->host_user_addr == 0)
> +			continue;
> +		async_dma_map_region(dev, reg, do_map);
> +	}
>  }
>  
>  static void
> -free_mem_region(struct virtio_net *dev)
> +free_mem_region(struct rte_vhost_mem_region *reg)
> +{
> +	if (reg != NULL && reg->mmap_addr) {
> +		munmap(reg->mmap_addr, reg->mmap_size);
> +		close(reg->fd);
> +		memset(reg, 0, sizeof(struct rte_vhost_mem_region));
> +	}
> +}
> +
> +static void
> +free_all_mem_regions(struct virtio_net *dev)
>  {
>  	uint32_t i;
>  	struct rte_vhost_mem_region *reg;
> @@ -236,12 +267,10 @@ free_mem_region(struct virtio_net *dev)
>  	if (dev->async_copy && rte_vfio_is_enabled("vfio"))
>  		async_dma_map(dev, false);
>  
> -	for (i = 0; i < dev->mem->nregions; i++) {
> +	for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
>  		reg = &dev->mem->regions[i];
> -		if (reg->host_user_addr) {
> -			munmap(reg->mmap_addr, reg->mmap_size);
> -			close(reg->fd);
> -		}
> +		if (reg->mmap_addr)
> +			free_mem_region(reg);
>  	}
>  }
>  
> @@ -255,7 +284,7 @@ vhost_backend_cleanup(struct virtio_net *dev)
>  		vdpa_dev->ops->dev_cleanup(dev->vid);
>  
>  	if (dev->mem) {
> -		free_mem_region(dev);
> +		free_all_mem_regions(dev);
>  		rte_free(dev->mem);
>  		dev->mem = NULL;
>  	}
> @@ -704,7 +733,7 @@ numa_realloc(struct virtio_net **pdev, struct vhost_virtqueue **pvq)
>  	vhost_devices[dev->vid] = dev;
>  
>  	mem_size = sizeof(struct rte_vhost_memory) +
> -		sizeof(struct rte_vhost_mem_region) * dev->mem->nregions;
> +		sizeof(struct rte_vhost_mem_region) * VHOST_MEMORY_MAX_NREGIONS;
>  	mem = rte_realloc_socket(dev->mem, mem_size, 0, node);
>  	if (!mem) {
>  		VHOST_CONFIG_LOG(dev->ifname, ERR,
> @@ -808,8 +837,10 @@ hua_to_alignment(struct rte_vhost_memory *mem, void *ptr)
>  	uint32_t i;
>  	uintptr_t hua = (uintptr_t)ptr;
>  
> -	for (i = 0; i < mem->nregions; i++) {
> +	for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
>  		r = &mem->regions[i];
> +		if (r->host_user_addr == 0)
> +			continue;
>  		if (hua >= r->host_user_addr &&
>  			hua < r->host_user_addr + r->size) {
>  			return get_blk_size(r->fd);

