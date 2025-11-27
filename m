Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D887D116E4
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Nov 2025 02:05:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 453CD402C8;
	Thu, 27 Nov 2025 03:05:12 +0100 (CET)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id 2168E4013F
 for <dev@dpdk.org>; Thu, 27 Nov 2025 03:05:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
 s=s201512; t=1764209108;
 bh=13NWkPC2HuzU/LQLxTriPeST0oIn3mfwayR7MvpKtPk=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=eXCIXOpEi8jwNjk7dcfBfKxXx4b2ZY30XYB1CmJe1ZbilqxsMazRshoi90AoQqgFm
 SOt1HeLei9MmWh1zjTakQCb85WDd2FXU0X5iCBUZ5UXTGhN3JRZnoID9GGmzT6ctrr
 XSP4Ky2YgflhJYWi0gd+qQY4BvnU8r0jqCruSqwY=
X-QQ-mid: zesmtpsz9t1764209104tc7afe8c2
X-QQ-Originating-IP: Cu7zm0o0jHtDrj/D7jZ/7dIluiMbKZN/YSeAHWE9eJ0=
Received: from [127.0.0.1] ( [11.176.19.22]) by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 27 Nov 2025 10:05:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10235596288947569612
Message-ID: <2061A756224DB24D+d9f433f4-1163-44d9-81bb-ef602edf0f21@tencent.com>
Date: Thu, 27 Nov 2025 10:05:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Internet]Re: [PATCH v3] acl: support custom memory allocator
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
References: <66734dfb22e841ddad035c630bb74f1c@huawei.com>
 <16C60E2E552D75E0+20251125121446.41247-1-mannywang@tencent.com>
 <8e00f0b5-84de-40ce-bec3-673c4b9dd3f1@gmail.com>
 <7E45BE076ACCC3B2+d9eeffa0-a442-4766-b45f-406cd99700e9@tencent.com>
 <cb7c53de-bc26-42c1-8695-00a4a335ebef@gmail.com>
 <08881270F044B8AD+5e6e521c-8430-4b66-a44c-9b1b8f8f297a@tencent.com>
 <20251126132843.12340ad8@phoenix.local>
From: "=?gb18030?B?bWFubnl3YW5nKM3108C35Sk=?=" <mannywang@tencent.com>
In-Reply-To: <20251126132843.12340ad8@phoenix.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:tencent.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mdc3TkmnJyI/jB9V+GJM5XX5fsHAZgNQZCU308uWHePB0J0arPGEK0jI
 VYsTjUyDUDe7o2afyVkj3xEvm9lo/kjlDGr94+rOnHC/edzW6JHznN4QurorRc0DIsTprhA
 Nr5Y2hNjA/N/VBy4lf7kk+iRP84NtP+emlLeXQiVT6eZsMcwUCce71FSdAvRvq4G3Z1Kg5Q
 nFvvYOrdPVLWc3VY4i99Am7O7S8vhg2yPkOX4zMrBfhparNAQfjN2wZQl/wMoamjQZzWHdC
 ImC8qfj8foG2PySnkTBrQGI6ZfPpQ3FpMX45iMGjMdrWCZXCskUTsZsR22NeisCtx8ajAmO
 zi48w09YRoM3KYnLObQqTmluinIHnzicsLQsPZRzacjZQ5SvFfK/6iCB+7YoUVxM3n46UMk
 I/C3DkElTb2hsPjGMvVKdCkB41EGPsPSM+tJqB8bxdAlK29Ae/dnWWRGw//n+w7cfQI0V1E
 pZ9ITraH9Oua88+AA0bD/nhXQoYbbcRI4SUVh17UmGmrKjXjyFs8b54VC/mVlnW4L1JPORe
 imH67/DVcx76SLdV5IGSpX21ZGMoTNeCItv+pClKGcH3A9WtW6VppjFvTnQEj1hoqekdufO
 cfL1CqF064FocorgcOaol4++aRZgOXwypJdxyqV5Pe9EsaPz0En76ggwvDEsevIdNA8YFDn
 y/xgDi11/JU++rbw7xDSF9YpNU55RznSrzKGHuBJ5/847nc6aw3Etrc3V3s0bCogqr1Fz3y
 R0jr3+7hOKDVZW2kaEaq5588V/h/FZemkz2DAabrEjeS0dBeZDmAHUPLWaS9BoiBUXGKc8D
 Ceo+5ygI854TrPBdrxkQ5q9GpS1JX/vyY24+k9T46yGZyi0aFIYUfkOn5WuozwEFEolZ/bA
 eBXrR6KmMMRuwt3dMWhLJjXtGx/56kD7+G7bfhXzHdQKGP7UFt8MEzB8EmQmI69BrtTfTNV
 DBc9gyFuxU1+d8YhDAFvEKGYEHJy5UHyyNlRZ+4xokEzDdyvp9wyiHqNk32UDGGZboOg3FW
 mRfFdjV31JSPttMsbz
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

Thank you very much for your suggestions.Yes, we could indeed do better 
on the dynamic memory management side, and some other team members also 
share similar views.

On the other hand, this patch gives users an option: to completely avoid 
dynamic memory management, or, to put it more directly, to trade a 
sufficiently large (and possibly wasteful) amount of memory for higher 
determinism.

On 11/27/2025 5:28 AM, Stephen Hemminger wrote:
> On Wed, 26 Nov 2025 16:09:20 +0800
> "mannywang(王永峰)" <mannywang@tencent.com> wrote:
> 
>> Thanks for the follow-up question.
>>
>>   > I don't understand the build stage issue and why it needs a custom
>> allocator.
>>
>> The fragmentation concern does not come from the amount of address space,
>> but from how the underlying heap allocator manages **large / mid-sized
>> temporary buffers** that are repeatedly allocated and freed during ACL
>> build.
>>
>> ACL build allocates many temporary arrays, tables and sorted structures.
>> Some of them are several MB in size. When these allocations are done via
>> malloc/calloc, they typically end up in the general heap. Every build
>> iteration produces a different allocation pattern and size distribution.
>> Even if the allocations are freed at the end, the internal heap layout is
>> not restored to a “flat” state. Small holes remain, and future allocation of
>> large contiguous blocks may fail even if the total free memory is
>> sufficient.
>>
>> This becomes a real operational issue in long-running processes.
>>
>>   > What exactly gets fragmented? It is the entire process address space
>> which is practically unlimited?
>>
>> It is not the address space that is the limiting factor.
>> It is the **allocator's internal arena**.
>>
>> Most allocators (glibc malloc, jemalloc, tcmalloc, etc) retain internal
>> metadata, bins, and split blocks. Their fragmentation behavior accumulates
>> over time. The process may still have hundreds of MB of “free memory”, but
>> not in **contiguous regions** that satisfy the next large request.
>>
>>   > How does malloc/free overhead compare to overall ACL build time?
>>
>> The cost of malloc/free calls themselves is not the core problem.
>> The overhead is small relative to the total build time.
>>
>> The risk is that allocator fragmentation increases unpredictably over a long
>> deployment, until a large block allocation fails in the data plane.
>>
>> Our team has seen this exact behavior in production environments.
>> Because we cannot fully control the allocator state, we prefer a model
>> with zero dynamic allocation after init:
>>
>> * persistent runtime structures → pre-allocated static region
>> * temporary build data → resettable memory pool
>>
>> This avoids failure modes caused by allocator history and guarantees stable
>> latency regardless of system uptime or build frequency.
>>
>> On 11/26/2025 3:57 PM, Dmitry Kozlyuk wrote:
>>> On 11/26/25 05:44, mannywang(王永峰) wrote:
>>>> Thanks for sharing this suggestion.
>>>>
>>>> We actually evaluated the heap-based approach before implementing this
>>>> patch.
>>>> It can help in some scenarios, but unfortunately it does not fully
>>>> solve our
>>>> use cases. Specifically:
>>>>
>>>> 1. **Heap count / scalability**
>>>>     Our application maintains at least ~200 rte_acl_ctx instances (due
>>>> to the
>>>>     total rule count and multi-tenant isolation). Allowing a dedicated
>>>> heap per
>>>>     context would exceed the practical limits of the current rte_malloc
>>>> heap
>>>>     model. The number of heaps that can be created is not unlimited, and
>>>>     maintaining hundreds of separate heaps would introduce considerable
>>>>     management overhead.
>>> This is a valid point against heaps, thanks.
>>>> 2. **Temporary allocations in build stage**
>>>>     During `rte_acl_build`, a significant portion of memory is
>>>> allocated through
>>>>     `calloc()` for internal temporary structures. These allocations are
>>>> freed
>>>>     right after the build completes. Even if runtime memory could come
>>>> from a
>>>>     custom heap, these temporary allocations would still need an
>>>> independent
>>>>     allocator or callback mechanism to avoid fragmentation and repeated
>>>>     malloc/free cycles.
>>> I don't understand the build stage issue and why it needs a custom
>>> allocator.
>>> What exactly gets fragmented?
>>> It is the entire process address space which is practically unlimited?
>>> How does is malloc/free overhead compare to the overall ACL build time?
>>>    
> 
> I have seen similar issues in other networking software, mostly it is because
> glibc wants to avoid expensive compaction. See https://sourceware.org/glibc/wiki/MallocInternals
> 
> The solution was to call malloc_trim() at the end of control transaction.
> If ACL library is doing lots of small allocations, then adding it there
> would help.
> 
> The effect can also be mitigated by using mallopt to adjust MALLOC_TRIM_THRESHOLD.
> There is lots of documentation on the Internet on this.
> 
> Another option for some workloads is using an alternative library for malloc.
> There are lots of benchmarks on glibc vs tcmalloc vs jemalloc.
> 
> 
> 
> 


