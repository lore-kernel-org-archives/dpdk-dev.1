Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2929D1036F
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 02:44:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF44540A6E;
	Wed, 26 Nov 2025 03:44:52 +0100 (CET)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id C53144029A
 for <dev@dpdk.org>; Wed, 26 Nov 2025 03:44:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
 s=s201512; t=1764125088;
 bh=qW/U6BOPcyRh7lKMpqhzlhSDDcho9NRWNT8T++WxYHg=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=OnCVovUE1OaaIkV1z12caJhDm+twlxMbHSLGTimW6WOzra5E27baj2ETh2XmWyYgf
 94D5WV04hAfKlDZU+g8Twy5I6k2vInh/xfQNaDemT4ELefF568DBdupAjTpBRoQAec
 JMAIrsaarbVi/MGlGRS1ibTw9uto/dWfllqfBpho=
X-QQ-mid: zesmtpsz9t1764125086tfa440bda
X-QQ-Originating-IP: HBzzkBTdK0onEPpVgu9AArM80YWgrj1DI/fiwSB6Uxg=
Received: from [127.0.0.1] ( [11.176.19.22]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 26 Nov 2025 10:44:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 972211476848402596
Message-ID: <7E45BE076ACCC3B2+d9eeffa0-a442-4766-b45f-406cd99700e9@tencent.com>
Date: Wed, 26 Nov 2025 10:44:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Internet]Re: [PATCH v3] acl: support custom memory allocator
To: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org
References: <66734dfb22e841ddad035c630bb74f1c@huawei.com>
 <16C60E2E552D75E0+20251125121446.41247-1-mannywang@tencent.com>
 <8e00f0b5-84de-40ce-bec3-673c4b9dd3f1@gmail.com>
From: "=?gb18030?B?bWFubnl3YW5nKM3108C35Sk=?=" <mannywang@tencent.com>
In-Reply-To: <8e00f0b5-84de-40ce-bec3-673c4b9dd3f1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:tencent.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MPEorwW6cFo9mL5p1gXyi82ZE9ufyWSZwRKYxi8qyvhyl0/bU5l8kNTc
 xLYDguDhEW1BW2EXpL6X2sZFYJLHS32kgCTFhfdDvJ8i7YaAEZHzbpD/xGLxpyTB1YfqXOL
 LAj+5yxtESHkbugUPwfgSqG5pWZKzNLP0dT3fq3LgmfI6aXWWEAYLTu6NWui77kdnkffvvm
 ot/TD+OlAYc9IKpti39Tz76bVUCcihSX0/tAuHFyTOy2fBP2Vi2WQC5SPbo0Eg0sOP9tkyH
 Q4Fz7bcKDSyOkR4ISkvBX43VmlVRvrucK0oAo0y8RDZpMfPdo+NkXw9q7jHNN3bWfSBEbXW
 B63hV3xakc8k+s3mnXcxvKuaQDjhInBDTCkhfv7pBVwuevKLnsWij2r19o+CW4YPkCiOYUU
 Z6a59zcGNEzAZrNZpaPElyzKD0sidICITVGHTKAyWXcY3uSW/DB5PMpHRbwTvHrrauoQsIz
 6XxFc/UBELqu6baKNS8LAxvsVqRFEbejXZyvoVM7Cm0qpp//Y+ZfDRF+ZnoScbRxBN2g0U7
 Yu/bVD3/7GXflorYA88lXJ3yegbszgOvVoQKblEEe1+DUhDlDfcThxAkjmXGe+agZyh10uw
 TlURaAZvTW6Fc+Pho5J4x3mKup+25kFRVhzazA4vBrV0n58fz/ucAh2/alBcRq/fM/XyrAz
 8v2nT4zB4t065M1xO40pIfXbgo3SqNZb8v3QmoYZCUxCpzedus4occFTJFdGXK8oMTpD8U8
 VeFj7FmhO1JH3NihDq0N5bDcn3YEo90pb8FUiZ6XTe/J7FH5sGvUFPq6dafo2V5ZhaPHapd
 iTPdeao0FWwLBX6QAVC1qSPjtNlo1Qo1zxVLkBHwNqZzUZ6zKImx4ui+/hd49p61G9vikXA
 tTrMPMew9t74gCD8baAQMXkJGCLpX3lgrgmFd9rSgGLEsuJZgxhldye1ULS0l2Rq5xDhjJ4
 3E/CcgMB2L4ZnlypB0IQmaYBlaWBSjXQh1P860i2bZj9Ly5rDqPqnrDPZyftTPOrqldJv4w
 Ux6GWQG4FuOastJD/UsxrlSgKwSHWg6m7Miuap+g==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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

Thanks for sharing this suggestion.

We actually evaluated the heap-based approach before implementing this 
patch.
It can help in some scenarios, but unfortunately it does not fully solve our
use cases. Specifically:

1. **Heap count / scalability**
    Our application maintains at least ~200 rte_acl_ctx instances (due 
to the
    total rule count and multi-tenant isolation). Allowing a dedicated 
heap per
    context would exceed the practical limits of the current rte_malloc heap
    model. The number of heaps that can be created is not unlimited, and
    maintaining hundreds of separate heaps would introduce considerable
    management overhead.

2. **Temporary allocations in build stage**
    During `rte_acl_build`, a significant portion of memory is allocated 
through
    `calloc()` for internal temporary structures. These allocations are 
freed
    right after the build completes. Even if runtime memory could come 
from a
    custom heap, these temporary allocations would still need an independent
    allocator or callback mechanism to avoid fragmentation and repeated
    malloc/free cycles.

The goal of this patch is to provide allocator callbacks so that 
applications
can apply their own memory model consistently — static region for 
runtime, and
resettable pool for build — without relying on uncontrolled internal
allocations.

On 11/26/2025 2:01 AM, Dmitry Kozlyuk wrote:
> On 11/25/25 15:14, mannywang(王永峰) wrote:
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
> 
> If a static memory region would suffice for runtime memory,
> could you have solved the issue using existing API as follows?
> 1. Allocate memory in any way, may even use `rte_malloc_*()`.
> 2. Create a new heap using `rte_malloc_heap_create()`.
> 3. Attach the memory to the heap using `rte_malloc_heap_memory_add()`.
> 4. Get the heap "socket ID" using `rte_malloc_heap_get_socket()`.
> 5. Pass the heap "socket ID" to `rte_acl_create()`.
> 
> In https://inbox.dpdk.org/dev/tencent_4125B1322F9238892BFA5F38@qq.com/
> you said that the issue is runtime memory fragmentation,
> but also did "propose extending the ACL API to support
> external memory buffers for the build process".
> What is the issue with build-time allocations?
> 
> 


