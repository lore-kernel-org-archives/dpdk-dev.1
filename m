Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B65BC5AD55
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Aug 2026 12:45:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1613140DD6;
	Mon, 10 Aug 2026 14:45:12 +0200 (CEST)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTP id 132A440144
 for <dev@dpdk.org>; Mon, 10 Aug 2026 14:45:10 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=EIMVgtaBwj9P+v9nZYGQvzbG9CvDVDKHPW+kAZwUMIg=;
 b=D0NXhcnzQMtYB4aDaYHBp+urexKcvLR/wKvw2lq9zBT4uPRqw79dbTcvWcx4dfRSarTBJEB3F
 zOG72wHHbL3IgMKhIrUQc3QKZWkZM+uT1uug8d4rQoV57WglH4OPYM2zH+bEpRldse3wc12fY4p
 1v601jadJXPr1yG0ZDpwtuU=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hJZ2V0JQrznTVd;
 Mon, 10 Aug 2026 20:34:42 +0800 (CST)
Received: from kwepemp100009.china.huawei.com (unknown [7.202.195.55])
 by mail.maildlp.com (Postfix) with ESMTPS id 906F8402AB;
 Mon, 10 Aug 2026 20:45:05 +0800 (CST)
Received: from kwepemp500015.china.huawei.com (7.202.195.9) by
 kwepemp100009.china.huawei.com (7.202.195.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 20:45:05 +0800
Received: from [10.67.120.108] (10.67.120.108) by
 kwepemp500015.china.huawei.com (7.202.195.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 20:45:04 +0800
Message-ID: <e7c3cd62-ed12-0968-9a4c-103d2184b77b@huawei.com>
Date: Mon, 10 Aug 2026 20:45:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] common/mlx5: fix high SMMU TLB miss with mempool alignment
Content-Language: en-CA
To: Slava Ovsiienko <viacheslavo@nvidia.com>, David Marchand
 <david.marchand@redhat.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, "dmitry.kozliuk@gmail.com" <dmitry.kozliuk@gmail.com>, 
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>,
 "yangshuaisong@h-partners.com" <yangshuaisong@h-partners.com>,
 "lihuisong@huawei.com" <lihuisong@huawei.com>, "liuyonglong@huawei.com"
 <liuyonglong@huawei.com>, "kangfenglong@huawei.com" <kangfenglong@huawei.com>
References: <20260612071434.2722918-1-yangxingui@huawei.com>
 <CAJFAV8xzvx8RtqpkG-KcRrbKGk+HPk0ms-=kFSLcDhO1KZkk-A@mail.gmail.com>
 <DM4PR12MB608738E64EC261C4CD6B9E19DFD22@DM4PR12MB6087.namprd12.prod.outlook.com>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <DM4PR12MB608738E64EC261C4CD6B9E19DFD22@DM4PR12MB6087.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.120.108]
X-ClientProxiedBy: kwepemh500008.china.huawei.com (7.202.181.139) To
 kwepemp500015.china.huawei.com (7.202.195.9)
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

Hi Slava,

Thanks for the review.

On 2026/8/6 15:56, Slava Ovsiienko wrote:
> Hi,
> 
> Why does cross-NUMA pinning cause the huge page size alignment?

In practice, scenarios involving intra-NUMA binding encounter issues 
with huge-page alignment.

Even with the loop bug (alignment block always entered), there is a
second issue: the if (reg_end < hugepage_end) gate uses strict <
instead of <=.
Runtime data with 1 GB hugepages on Kunpeng SoC + CX7 (NUMA1), MPRQ
enabled, 16 cores, 16 queues, queue-size 4096:
intra-NUMA (-l 40-55, all on NUMA1):
   reg_start       = 0x121b76f000
   reg_end         = 0x1240000000
   hugepage_start  = 0x1200000000
   hugepage_end    = 0x1240000000
Here reg_end == hugepage_end, so reg_end < hugepage_end is false.
Alignment is skipped, reg_start stays at 0x121b76f000 (not aligned to
the 1 GB boundary) → high TLB miss rate under SMMU.
cross-NUMA (-l 11-26, all on NUMA0, CX7 on NUMA1):
   reg_start       = 0x11d93b5000
   reg_end         = 0x11fdc46000
   hugepage_start  = 0x11c0000000
   hugepage_end    = 0x1200000000
Here reg_end (0x11fdc46000) < hugepage_end (0x1200000000) is true.
Alignment runs: reg_start → hugepage_start, reg_end → hugepage_end
→ MR is hugepage-aligned → no excessive TLB misses.
In both cases the mempool (~585 MB) fits within a single 1 GB hugepage
and reg_start is NOT aligned. The only difference is whether reg_end
happens to coincide with hugepage_end. The intra-NUMA case happens to
fill the hugepage to its exact end, which makes the < check fail.
The mempool is always allocated on NUMA1 via rte_mempool_create with
numa_node = dev->device->numa_node. We don't yet have a definitive
explanation for why the placement differs between the two pinning
configurations — it likely depends on the hugepage allocator's internal
state. But the key point is that alignment should not depend on this
coincidence; reg_start should be aligned regardless of where reg_end
falls.

> It seems we have a bug in the current code (and the patch fixes it somehow ) -
> the loop  "/* Check that all ranges are on pages of the same size. */"
> does not depend on iteration variable "I" and always runs till the end.
You are right about the loop bug — the original
loop always runs to completion because it uses msl->page_sz (fetched
once before the loop) instead of each range's own memseg list. Our
patch fixes this by calling rte_mem_virt2memseg_list() inside the loop.
> 
> The patch mostly looks good to me, there are just my 5 cents to improve:
> 
> 1.
>>    	msl = rte_mem_virt2memseg_list((void *)ranges[0].start);
> We could move this into the checking loop inside (prefertable). Or start the loop from i=1.
> Just to have rte_mem_virt2memseg_list() call in single point.
>>    	if (msl != NULL) {
>> -		uint64_t hugepage_sz = 0;
>> +		hugepage_sz = msl->page_sz;


> 2.
>> +	if (same_hugepage_sz && hugepage_sz > 0) {
>> +		unsigned int orig_ranges_n = ranges_n;
> No sense to run this code if hugepage_sz is equal to rte_mem_page_size (),
> all alignment and range merging is done by mlx5_mempool_get_chunks().
> 
> 3. Also, I would be careful about external memory. All ranges are already
> aligned to the correct page sizes, so let's add "if !is_extmem" checking.
> 

I will update the version based on your suggestions.

Thanks,
Xingui
