Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE3AD1038B
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 08:09:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD419402AF;
	Wed, 26 Nov 2025 09:09:28 +0100 (CET)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 8E0414026F
 for <dev@dpdk.org>; Wed, 26 Nov 2025 09:09:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
 s=s201512; t=1764144563;
 bh=ufgXPpkKj2eXfJTDWrM2mfblC3N+/a5Q7X+J3jdjGpM=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=FAEufl9nb9POOeoE7y/NaTQJROaH1QAT3cKDHFM7I7YOV/TO3yldbO5GpOkY1tF5I
 SXtwb4xxQNMOFmcU0LOGaFecz9NaI+S+6MxTyY9Ve3HEtNo9xwg6F4hJjYrxCDq6UV
 TeUSZ9NVbp6JxkZQvF1V1Qwe9rsg4ab78gEdupsg=
X-QQ-mid: zesmtpsz6t1764144562t4b7064cb
X-QQ-Originating-IP: o5Hj8krLNsUq2inHS7QM5Z0UqP4FjXuLIhGJ2dkWwqw=
Received: from [127.0.0.1] ( [11.176.19.22]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 26 Nov 2025 16:09:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17343232685916434492
Message-ID: <08881270F044B8AD+5e6e521c-8430-4b66-a44c-9b1b8f8f297a@tencent.com>
Date: Wed, 26 Nov 2025 16:09:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] acl: support custom memory allocator
To: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org
References: <66734dfb22e841ddad035c630bb74f1c@huawei.com>
 <16C60E2E552D75E0+20251125121446.41247-1-mannywang@tencent.com>
 <8e00f0b5-84de-40ce-bec3-673c4b9dd3f1@gmail.com>
 <7E45BE076ACCC3B2+d9eeffa0-a442-4766-b45f-406cd99700e9@tencent.com>
 <cb7c53de-bc26-42c1-8695-00a4a335ebef@gmail.com>
From: "=?gb18030?B?bWFubnl3YW5nKM3108C35Sk=?=" <mannywang@tencent.com>
In-Reply-To: <cb7c53de-bc26-42c1-8695-00a4a335ebef@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:tencent.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: ND42uzdxTIzrYDMzqiHkwPQSY+oag13tE+UFEn53U0ykci/aJ5N/DiVz
 ttMtWj/dC1JRopIQ36gayLOqZdKf0U5O7ZtnOXw5aAaUL3uWAlrGM16prdv56yBXo0aLe5j
 DYpesfPXDQIhjAKfDr4leCS0OA2W5AIamDIUPeS8hyUyLpt6eSqcTUZ8ZYJegqKNX/2xra4
 Z67algKis5routUGOD1Atq4Hc1Vza/R2vD/n7ktSZcXq2bGyLKuU/0eD9qVc6mLJI0FCVMk
 VAjgCMPsCeSUJkeAtGP5VIQwHF1HJ2CG1xbdTpSbUgP4XQoqvCvdvpmGYSoQxwum+3q5RA1
 HTEU0opsGWwdkTgat4aUWl45MM9H7ao4dK78lZQPLW40foXIljbitAE03sA5xt3BapomtsM
 lx8hPQrcM0Blr5Na0SgMtpVTo/KMFa1AGjNKbHAWykg1Qx9888HVfHFRmvbWoFjyM2s46ws
 wPsy/0kdrH4LsiTcMC/QioJIM24jE4CelskyRQ3ImnSJfXMBWyLM6in43OBljfe4YijUqlF
 SyRc95+IcOuvbd9zINkjM1q2ZdhYBCi9lMo+yNWplPK/vO8rEoNnBAVmckzwP6rdmaDHLfP
 OebKcKtMFbT/Z3hwaZIBSk02mOUZKyUO1cQqhqmYfPQ2wKtsVJRlXlRbj3Evt152AW+NqBT
 YOoFrCWjJdf31TOiZTL6Z7q+gQHs77RLhGqXXqR2TRugous7BIgddNYx4PoPueJI1G6p+Ch
 fNk4XTyHGO9/yVnDqI6B1NOAXZho40wGUFSq+TrKdyYEcti2Q2JaCb3CTSxx5leO2rXlrAN
 LGlkINcw3DKWDIeWYNHmldmOkbhItpRFTDIJDDoezB4aT34iOXxbh76fSJnMLOKBGD7CPGi
 XAM8Wb0ssYEJ/3Lzr0rVSu8vUeQZ3t4QlzXq1C9vSjB/ALT/o++nLFmHVgvcY6eEKfDcpVi
 sLd8hmVtLiY7I2IH7jfiTscqak7rRDJh/afY=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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

Thanks for the follow-up question.

 > I don't understand the build stage issue and why it needs a custom 
allocator.

The fragmentation concern does not come from the amount of address space,
but from how the underlying heap allocator manages **large / mid-sized
temporary buffers** that are repeatedly allocated and freed during ACL 
build.

ACL build allocates many temporary arrays, tables and sorted structures.
Some of them are several MB in size. When these allocations are done via
malloc/calloc, they typically end up in the general heap. Every build
iteration produces a different allocation pattern and size distribution.
Even if the allocations are freed at the end, the internal heap layout is
not restored to a “flat” state. Small holes remain, and future allocation of
large contiguous blocks may fail even if the total free memory is 
sufficient.

This becomes a real operational issue in long-running processes.

 > What exactly gets fragmented? It is the entire process address space 
which is practically unlimited?

It is not the address space that is the limiting factor.
It is the **allocator's internal arena**.

Most allocators (glibc malloc, jemalloc, tcmalloc, etc) retain internal
metadata, bins, and split blocks. Their fragmentation behavior accumulates
over time. The process may still have hundreds of MB of “free memory”, but
not in **contiguous regions** that satisfy the next large request.

 > How does malloc/free overhead compare to overall ACL build time?

The cost of malloc/free calls themselves is not the core problem.
The overhead is small relative to the total build time.

The risk is that allocator fragmentation increases unpredictably over a long
deployment, until a large block allocation fails in the data plane.

Our team has seen this exact behavior in production environments.
Because we cannot fully control the allocator state, we prefer a model
with zero dynamic allocation after init:

* persistent runtime structures → pre-allocated static region
* temporary build data → resettable memory pool

This avoids failure modes caused by allocator history and guarantees stable
latency regardless of system uptime or build frequency.

On 11/26/2025 3:57 PM, Dmitry Kozlyuk wrote:
> On 11/26/25 05:44, mannywang(王永峰) wrote:
>> Thanks for sharing this suggestion.
>>
>> We actually evaluated the heap-based approach before implementing this 
>> patch.
>> It can help in some scenarios, but unfortunately it does not fully 
>> solve our
>> use cases. Specifically:
>>
>> 1. **Heap count / scalability**
>>    Our application maintains at least ~200 rte_acl_ctx instances (due 
>> to the
>>    total rule count and multi-tenant isolation). Allowing a dedicated 
>> heap per
>>    context would exceed the practical limits of the current rte_malloc 
>> heap
>>    model. The number of heaps that can be created is not unlimited, and
>>    maintaining hundreds of separate heaps would introduce considerable
>>    management overhead.
> This is a valid point against heaps, thanks.
>> 2. **Temporary allocations in build stage**
>>    During `rte_acl_build`, a significant portion of memory is 
>> allocated through
>>    `calloc()` for internal temporary structures. These allocations are 
>> freed
>>    right after the build completes. Even if runtime memory could come 
>> from a
>>    custom heap, these temporary allocations would still need an 
>> independent
>>    allocator or callback mechanism to avoid fragmentation and repeated
>>    malloc/free cycles.
> I don't understand the build stage issue and why it needs a custom 
> allocator.
> What exactly gets fragmented?
> It is the entire process address space which is practically unlimited?
> How does is malloc/free overhead compare to the overall ACL build time?
> 

