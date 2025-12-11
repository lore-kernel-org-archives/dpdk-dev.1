Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3BED3E77C
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 02:30:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51A4E40289;
	Thu, 11 Dec 2025 03:30:02 +0100 (CET)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id AE5CD40285
 for <dev@dpdk.org>; Thu, 11 Dec 2025 03:29:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
 s=s201512; t=1765420197;
 bh=b1WTbnp+FcGL73W0HTiTLo9hbuIxsmoqG/XYHVmLPws=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=dqvSlWKRuF3mQcHDVZviTFMjQMCBzTe9finFXbWYRt9SrtFsj3Dyvqt43qkrGcV9F
 5giTumCMWSQNJDnCfUkI0gz6em/d/+ZbIhiC1nQ7pBWXwstN/1kUJfGGbtZt6MqD0h
 MAGLHo0a7fjVgEABFFkT6Bbp1FZmBD/FUrXul264=
X-QQ-mid: zesmtpsz6t1765420193tf2588ad1
X-QQ-Originating-IP: eBaIMuJ5BZ/EE4CCsTeQCcgQgX17ETiYAs/NJBjBcqA=
Received: from [127.0.0.1] ( [11.176.19.22]) by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 11 Dec 2025 10:29:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1132841271349207504
Message-ID: <18AF3410B5B178EC+90842a44-bf75-45a9-ba78-ee052052e8d0@tencent.com>
Date: Thu, 11 Dec 2025 10:29:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Internet]Re: [PATCH v3] acl: support custom memory allocator
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
References: <66734dfb22e841ddad035c630bb74f1c@huawei.com>
 <16C60E2E552D75E0+20251125121446.41247-1-mannywang@tencent.com>
 <20251211104625.39632870@stephen-xps.local>
From: "=?gb18030?B?bWFubnl3YW5nKM3108C35Sk=?=" <mannywang@tencent.com>
In-Reply-To: <20251211104625.39632870@stephen-xps.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:tencent.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NWth7vBa++Gdb7RsX8N58ru5R+s+3bTjzSITB5zlc/ACovmTvFdKCCUu
 eJdqFiicGJ4GLy4Jd6k/QZPKliFpabuxZAxzluI6e8VPo2zXbezKHLmb9fL2NxzX6JCdBTe
 Ubz5gnHGmLhyx9U8wiYmu64kSZ6ZH6JYRODfs+nFRVzG+KUQDi57O0Yzd6wqw+AqvUQsBnp
 fcQ3J7zs0R22JL4l0BZBtr1yY97zrhHtseJgh5JpfpMLjBHjbVVyyJWD8L5COCLWh/KSzvD
 GRe9ImPqcx5F8MKqQI8xk+a8aZwEcc0uWoifmeQZNuwfDpMxaMl2HAFwHTrCWme/qoAzrMx
 tdQ5VhWmMdNPtdHueqmAVhIt3ugMpqjys8+XTsBtM7Eyjh4tD7QAKPGo1u8KjgNDefS9tBk
 4/njJ5Abvp23Ecjz+wiFkMiwRAE/RLk2hrYgZZ7IxBxr8nWjOp2UIBYmvO99u1z7N+5ZiCK
 c48GAGCGfEN0HzGFWAesC/DRwsnzBfxop+GpEsM+djbaQJlPY8e+b3q3ybYuyJsXXjDCsOk
 6X+AbE13Fj/O3vOWovrXgijeV3tFvQlEiwf5V/i1OsH0evnoxUogzPeK/tfXM8pRMw4YDj5
 rx8PND8qZM8Ls5nr1mRnYVw+X6XD3cxIFOZ2MWmRKGmRKWOwyg9T6SdVkIYQGtFbJK0hI/y
 6OlbJPaEgEZppfVEoyy0jZyCI/zD+QO8irEYFMQv0OpODm5ftd0IFm4tELWVx88sZHt5a59
 hnlkSwJWCJGItlZOYRUuM+JS/6DX9FMnPXi0i7gOnhAB54HUiI3BCrU8/3I3zNd+vqpd9Up
 D2ejAgKs7i6xDq0z08BrkVSY2zvcnOCGrgfoYN7o9vKjKJClZbEoOiLhWy4HQcoJcE4/O/+
 mcy3MxBjRFShoZEaTiogeq6FX+J+pqQFaZHmi+3pOAt8KQTV2+30z41WxFqjAuHHryAJ7Gn
 5zCS3xPh17PUbKGk0UWFGK5LUcU9jNB8c1rsVZeb1SMVb/HLZRjCJAl3wluabcLjO1G6j1T
 M0Cxi/+pgIuhhSdBn2qldBGN1/V2badACg4AiCvfRAxN6EWHsQ
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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

Supplement: The two types of memory in ACL make a management strategy 
unnecessary: (1) the run-time memory for the match tree, which is 
allocated as a single block during each build and freed when the ACL is 
reset; and (2) the temporary memory used during the build process, which 
is allocated multiple times within a single build and then released all 
at once after the build is finished.

On 12/11/2025 9:46 AM, Stephen Hemminger wrote:
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
>> ---
> 
> Rather than custom allocators, I did a couple of quick AI queries about
> alternatives. It looks like there are some big global gains possible
> here:
> 
> Summary of Recommendations
> Improvement	Benefit	Complexity	Priority
> ACL Object Pooling	Eliminates ACL-specific fragmentation	Medium	High
> Size-Class Segregation	Reduces general fragmentation	High	High
> Slab Allocator for Build	Better hugepage utilization	Medium	Medium
> Deferred Coalescing	Reduces fragmentation from churn	Medium	Medium
> Thread-Local Caching	Reduces contention, improves locality	Medium	Medium
> 
> Also adding some malloc_trim() would help.
> 
> https://claude.ai/share/75fcf73c-17e3-4f41-8590-f2ab640f9512
> 
> 


