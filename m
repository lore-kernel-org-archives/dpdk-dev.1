Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139C0D10373
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 02:37:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C3E44069D;
	Wed, 26 Nov 2025 03:37:59 +0100 (CET)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id 2B2824029A
 for <dev@dpdk.org>; Wed, 26 Nov 2025 03:37:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
 s=s201512; t=1764124675;
 bh=fw/jr01frsSJ8nlg9OgCRC76o1RA2r726dWJT9rbFCc=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=cUuzveI4vhh/XnVdhfCgc1CRCisQMsgZXubK7VD4h4bK5F0Y4/igb33QgmDoKQj0y
 SD1WE5ESN5l8CNFClEymcMhvkU8AOtdJ4gHPYnpLgX4hOv47cToRPZ8WV0QcNVevRQ
 FSFcdYfMO9lohHR9wGXb64PlVJbDraxwxN3T0VKA=
X-QQ-mid: esmtpgz16t1764124672t85c32e00
X-QQ-Originating-IP: CK11qgMln1aeXzvKTr/P9uFK3ypNBv8Ukt0Bu4jWVNo=
Received: from [127.0.0.1] ( [11.176.19.22]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 26 Nov 2025 10:37:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7453688635007467477
Message-ID: <920D089864A1F82E+61564d6f-ecd9-4c8c-97a7-da5a3ce226f0@tencent.com>
Date: Wed, 26 Nov 2025 10:37:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Internet]Re: [PATCH v3] acl: support custom memory allocator
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
References: <66734dfb22e841ddad035c630bb74f1c@huawei.com>
 <16C60E2E552D75E0+20251125121446.41247-1-mannywang@tencent.com>
 <20251125065922.7d12dc7d@phoenix.local>
From: "=?gb18030?B?bWFubnl3YW5nKM3108C35Sk=?=" <mannywang@tencent.com>
In-Reply-To: <20251125065922.7d12dc7d@phoenix.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:tencent.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MhFAoh6gmjppG/oK8aXN5TJ7cc3ja7S5zNhjkk+O/sRx/QF/9ftWWSr1
 kN1UAVQVO2T5Kadd1Sn9awKAd+hXZvpO3F79565srYVyfPPbgdt6nIlWKKU3vVq1o+onka5
 tHrlf9cFPcl43UWLlrivmThh9t14jvlzbRq8tSqpqDs1PPcFK/I51DsNty/U5CaIx71O3zW
 XrmHWsJbM7zNCz0CZE5rT0V2bqqW70s6BdjoHXKFeXiBkT0HZ74wyBocUmTTjKp0N3NyN5Q
 20dif1tA2OlB7XertNLXKqU2DNZvZyd1Cufq6xTTYvurtPo5DsOvjbloP1QztzO2W14Y0Pi
 kYi6W/qrVBH200vgP795hA71krUjfV7ADFoGLLyRdnVO74r26VFCyaCTqXt07FUpY0yLov3
 KwV3UrySnWsbeTRtupedDmdF+Ar+bFmAcVZuUwkAzpyiomIE6HJ+FoJfZjHDU5CvnzONfxa
 lACVll7SxEMm6M7AdNa95+lG72yULBnFcOznPleOPd/tf5483Gb7ne8Wr3i3bl7Kz/HGNpd
 AECbF+mRb7qZTUnviE6xoJotzgvjDwfftlIsGiz1+2jV0vCm4vsD4HJSpjDP8UoNqpwMbom
 NJCn5iLncQa62+C+7yGlX7QiZh8n/dkjA4w6wEM/nxPz8TVs6pvbOmultAq3kkAUWRRI5ur
 7VDILVtEKhW0MGhOLQw2Gq4rQ30Bj8K0L7LRy0AI5E6uH/VjiUguYSPdL4cNo0/maDbJzxZ
 msrUjNiDJTTwEluoxieoHgmolVZ+oHVv8P03jWF/9ZNSo+Im63IgzVLssxKj6KvBT0oXLcQ
 kIJ9o38J2+2RVC9kTsn8qgKJZQqekrJbBmVOtSIBZApPU4WReRziwjNUCyKVV4IhKyiXJiy
 74Ww/evp1gYg8vJVcanGecVVVrziY9rcY+KqKoLFuKVzV4ZqHe0rljku5GWkYvGZg0cxWTF
 PSfYe9FIhftgF1pTp6l5JSDUn
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0
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

Thanks for the review and questions.

In our deployment scenario, long-running services must avoid runtime
allocation/deallocation to ensure stability. We have observed memory
fragmentation in practice when frequent small allocations happen on the
data path. Even with optimized allocators, this behavior accumulates over
time and can lead to unexpected latency spikes.

To address this, our project adopts a pre-allocation model: each acl_ctx
is associated with a sufficiently large memory block during initialization,
and no allocations occur afterwards. This approach has been effective in
eliminating runtime uncertainty in our use case.

The proposed patch enables applications with similar requirements to plug
their memory management strategy into the ACL layer without changing the
core logic. The default behavior remains unchanged.

On 11/25/2025 10:59 PM, Stephen Hemminger wrote:
> On Tue, 25 Nov 2025 12:14:46 +0000
> "mannywang(王永峰)" <mannywang@tencent.com> wrote:
> 
>> Reduce memory fragmentation caused by dynamic memory allocations
>> by allowing users to provide custom memory allocator.
>>
>> Add new members to struct rte_acl_config to allow passing custom
>> allocator callbacks to rte_acl_build:
>>
>> - running_alloc: allocator callback for run-time internal memory
>> - running_free: free callback for run-time internal memory
>> - running_ctx: user-defined context passed to running_alloc/free
>>
>> - temp_alloc: allocator callback for temporary memory during ACL build
>> - temp_reset: reset callback for temporary allocator
>> - temp_ctx: user-defined context passed to temp_alloc/reset
>>
>> These callbacks allow users to provide their own memory pools or
>> allocators for both persistent runtime structures and temporary
>> build-time data.
>>
>> A typical approach is to pre-allocate a static memory region
>> for rte_acl_ctx, and to provide a global temporary memory manager
>> that supports multipleallocations and a single reset during ACL build.
>>
>> Since tb_mem_pool handles allocation failures using siglongjmp,
>> temp_alloc follows the same approach for failure handling.
>>
>> Signed-off-by: YongFeng Wang <mannywang@tencent.com>
> 
> Rather than introduce an API change which can have impacts in many places;
> would it be better to fix the underlying rte_malloc implementation.
> The allocator in rte_malloc() is simplistic compared to glibc and
> other malloc libraries. The other libraries provide better density,
> statistics and performance.
> 
> Improving rte_malloc() would help all use cases not just the special
> case of busy ACL usage.
> 
> The other question is does ACL library really need to be storing
> this data in huge pages at all? If all it needed was an allocator
> for single process usage, than just using regular malloc would
> avoid the whole mess.
> 


