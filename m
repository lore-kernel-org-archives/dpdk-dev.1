Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0FECCFA18
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 01:21:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E19A440281;
	Wed, 12 Nov 2025 02:21:17 +0100 (CET)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id 3A8DE4026A
 for <dev@dpdk.org>; Wed, 12 Nov 2025 02:21:14 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=Wi6uBv9moabURkve2hzXgtdnanFhHrknk1blPe/21A4=;
 b=oWzNyCb8+l6QmNIoVV7f0p5mzDn8b60n+a28tTQO2YzICXrrddYAwM6oCO18z8ggVk3wl9e66
 hGRUYaa7gOI/GiiMWmNbK+OkOMRf4af5Jj4jDb6qh0XCyHcP2Hon2Zyo+Ixz9GKTUu3Wl4HS2bA
 Lqu8IMas/RbvzgyDogp6cPY=
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4d5ltj06Xcz12LDD;
 Wed, 12 Nov 2025 09:19:41 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id B4FD01400D9;
 Wed, 12 Nov 2025 09:21:12 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Nov 2025 09:21:12 +0800
Message-ID: <8837e213-bc2e-4e8f-bb12-c27819ed20ad@huawei.com>
Date: Wed, 12 Nov 2025 09:21:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] vhost_user: support function defines for back-end
To: "Bathija, Pravin" <Pravin.Bathija@dell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "pravin.m.bathija.dev@gmail.com" <pravin.m.bathija.dev@gmail.com>
References: <20251104042142.2787631-1-pravin.bathija@dell.com>
 <20251104042142.2787631-5-pravin.bathija@dell.com>
 <051163f2-7b6e-49db-83cf-7f6f366c448a@huawei.com>
 <SJ0PR19MB4606743990AD1AFE8EC06217F5CFA@SJ0PR19MB4606.namprd19.prod.outlook.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <SJ0PR19MB4606743990AD1AFE8EC06217F5CFA@SJ0PR19MB4606.namprd19.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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

On 11/11/2025 7:31 PM, Bathija, Pravin wrote:
> Responses inline.
> 
> 
> Internal Use - Confidential
>> -----Original Message-----
>> From: fengchengwen <fengchengwen@huawei.com>
>> Sent: Tuesday, November 4, 2025 12:06 AM
>> To: Bathija, Pravin <Pravin.Bathija@dell.com>; dev@dpdk.org
>> Cc: pravin.m.bathija.dev@gmail.com
>> Subject: Re: [PATCH v3 4/5] vhost_user: support function defines for back-end
>>
>>
>> [EXTERNAL EMAIL]
>>
>> On 11/4/2025 12:21 PM, Pravin M Bathija wrote:
>>> Here we define support functions which are called from the various
>>> vhost-user back-end message functions like set memory table, get
>>> memory slots, add memory region, remove memory region.  These are
>>> essetially common functions to initialize memory, unmap a set of
>>> memory regions, perform register copy and align memory addresses.
>>>
>>> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
>>> ---
>>>  lib/vhost/vhost_user.c | 80
>>> +++++++++++++++++++++++++++++++++++-------
>>>  1 file changed, 68 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c index
>>> 168432e7d1..9a85f2fc92 100644
>>> --- a/lib/vhost/vhost_user.c
>>> +++ b/lib/vhost/vhost_user.c
>>> @@ -228,7 +228,17 @@ async_dma_map(struct virtio_net *dev, bool
>>> do_map)  }
>>>
>>>  static void
>>> -free_mem_region(struct virtio_net *dev)
>>> +free_mem_region(struct rte_vhost_mem_region *reg) {
>>> +   if (reg != NULL && reg->host_user_addr) {
>>> +           munmap(reg->mmap_addr, reg->mmap_size);
>>> +           close(reg->fd);
>>> +           memset(reg, 0, sizeof(struct rte_vhost_mem_region));
>>> +   }
>>> +}
>>> +
>>> +static void
>>> +free_all_mem_regions(struct virtio_net *dev)
>>>  {
>>>     uint32_t i;
>>>     struct rte_vhost_mem_region *reg;
>>> @@ -239,12 +249,10 @@ free_mem_region(struct virtio_net *dev)
>>>     if (dev->async_copy && rte_vfio_is_enabled("vfio"))
>>>             async_dma_map(dev, false);
>>>
>>> -   for (i = 0; i < dev->mem->nregions; i++) {
>>> +   for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
>>>             reg = &dev->mem->regions[i];
>>> -           if (reg->host_user_addr) {
>>> -                   munmap(reg->mmap_addr, reg->mmap_size);
>>> -                   close(reg->fd);
>>> -           }
>>> +           if (reg->mmap_addr)
>>> +                   free_mem_region(reg);
>>>     }
>>>  }
>>>
>>> @@ -258,7 +266,7 @@ vhost_backend_cleanup(struct virtio_net *dev)
>>>             vdpa_dev->ops->dev_cleanup(dev->vid);
>>>
>>>     if (dev->mem) {
>>> -           free_mem_region(dev);
>>> +           free_all_mem_regions(dev);
>>>             rte_free(dev->mem);
>>>             dev->mem = NULL;
>>>     }
>>> @@ -707,7 +715,7 @@ numa_realloc(struct virtio_net **pdev, struct
>> vhost_virtqueue **pvq)
>>>     vhost_devices[dev->vid] = dev;
>>>
>>>     mem_size = sizeof(struct rte_vhost_memory) +
>>> -           sizeof(struct rte_vhost_mem_region) * dev->mem->nregions;
>>> +           sizeof(struct rte_vhost_mem_region) *
>> VHOST_MEMORY_MAX_NREGIONS;
>>>     mem = rte_realloc_socket(dev->mem, mem_size, 0, node);
>>>     if (!mem) {
>>>             VHOST_CONFIG_LOG(dev->ifname, ERR,
>>> @@ -811,8 +819,10 @@ hua_to_alignment(struct rte_vhost_memory
>> *mem, void *ptr)
>>>     uint32_t i;
>>>     uintptr_t hua = (uintptr_t)ptr;
>>>
>>> -   for (i = 0; i < mem->nregions; i++) {
>>> +   for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
>>>             r = &mem->regions[i];
>>> +           if (r->host_user_addr == 0)
>>> +                   continue;
>>>             if (hua >= r->host_user_addr &&
>>>                     hua < r->host_user_addr + r->size) {
>>>                     return get_blk_size(r->fd);
>>> @@ -1250,9 +1260,13 @@ vhost_user_postcopy_register(struct virtio_net
>> *dev, int main_fd,
>>>      * retrieve the region offset when handling userfaults.
>>>      */
>>>     memory = &ctx->msg.payload.memory;
>>> -   for (i = 0; i < memory->nregions; i++) {
>>> +   for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
>>
>> I think the using MAX_NREGIONS are most for convienent, but it will impact
>> the performance, because the rte_vhost_va_from_guest_pa() should iter the
>> entire array.
>>
> 
> Replaced VHOST_MEMORY_MAX_NREGIONS with memory->nregions. Please review v4.
> 
>> I think we should keep the original impl: make sure the nregions entry of
>> memory-region is always valid.
>>
>> Beside, where is the modification for rte_vhost_va_from_guest_pa()???
> 
> Could you please provide more detail ? rte_vhost_va_from_guest_pa() was never called from here before.

Because rte_vhost_va_from_guest_pa() use mem-nregions as for uplimit:
	for (i = 0; i < mem->nregions; i++) {

this function was never called, but I think we need to make each commit complete.

> 
>>
>>> +           int reg_msg_index = 0;
>>>             reg = &dev->mem->regions[i];
>>> -           memory->regions[i].userspace_addr = reg->host_user_addr;
>>> +           if (reg->host_user_addr == 0)
>>> +                   continue;
>>> +           memory->regions[reg_msg_index].userspace_addr = reg-
>>> host_user_addr;
>>> +           reg_msg_index++;
>>>     }
>>>
>>>     /* Send the addresses back to qemu */ @@ -1279,8 +1293,10 @@
>>> vhost_user_postcopy_register(struct virtio_net *dev, int main_fd,
>>>     }
>>>
>>>     /* Now userfault register and we can use the memory */
>>> -   for (i = 0; i < memory->nregions; i++) {
>>> +   for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
>>>             reg = &dev->mem->regions[i];
>>> +           if (reg->host_user_addr == 0)
>>> +                   continue;
>>>             if (vhost_user_postcopy_region_register(dev, reg) < 0)
>>>                     return -1;
>>>     }
>>> @@ -1385,6 +1401,46 @@ vhost_user_mmap_region(struct virtio_net *dev,
>>>     return 0;
>>>  }
>>>
>>> +static int
>>> +vhost_user_initialize_memory(struct virtio_net **pdev)
>>
>> This function should be part of 3/5, else the 3/5 will compile fail
> 
> I have moved support functions to patch-3. Please review v4.
> 
>>
>>> +{
>>> +   struct virtio_net *dev = *pdev;
>>> +   int numa_node = SOCKET_ID_ANY;
>>> +
>>> +   /*
>>> +    * If VQ 0 has already been allocated, try to allocate on the same
>>> +    * NUMA node. It can be reallocated later in numa_realloc().
>>> +    */
>>> +   if (dev->nr_vring > 0)
>>> +           numa_node = dev->virtqueue[0]->numa_node;
>>> +
>>> +   dev->nr_guest_pages = 0;
>>> +   if (dev->guest_pages == NULL) {
>>> +           dev->max_guest_pages = 8;
>>
>> It should be VHOST_MEMORY_MAX_NREGIONS
> 
> Done. Please review v4.
> 
>>
>>> +           dev->guest_pages = rte_zmalloc_socket(NULL,
>>> +                                   dev->max_guest_pages *
>>> +                                   sizeof(struct guest_page),
>>> +                                   RTE_CACHE_LINE_SIZE,
>>> +                                   numa_node);
>>> +           if (dev->guest_pages == NULL) {
>>> +                   VHOST_CONFIG_LOG(dev->ifname, ERR,
>>> +                           "failed to allocate memory for dev-
>>> guest_pages");
>>> +                   return -1;
>>> +           }
>>> +   }
>>> +
>>> +   dev->mem = rte_zmalloc_socket("vhost-mem-table", sizeof(struct
>> rte_vhost_memory) +
>>> +           sizeof(struct rte_vhost_mem_region) *
>> VHOST_MEMORY_MAX_NREGIONS, 0, numa_node);
>>> +   if (dev->mem == NULL) {
>>> +           VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to allocate
>> memory for dev->mem");
>>> +           rte_free(dev->guest_pages);
>>> +           dev->guest_pages = NULL;
>>> +           return -1;
>>> +   }
>>> +
>>> +   return 0;
>>> +}
>>> +
>>>  static int
>>>  vhost_user_set_mem_table(struct virtio_net **pdev,
>>>                     struct vhu_msg_context *ctx,
> 
> 

