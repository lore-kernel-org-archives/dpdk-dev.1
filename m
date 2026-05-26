Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1247ACD5BB4
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 07:01:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0913E40280;
	Tue, 26 May 2026 09:01:10 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 3F88C40279
 for <dev@dpdk.org>; Tue, 26 May 2026 09:01:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779778867;
 bh=2/vQjmvIGvvIxf67SQSTQ3M/QmisuY22sHv/0UI3Tvs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KbRy6E9y/gO+3inIkUlkHGGCbKeQUufGltH2kg7DhsP+aVMnlLiRK0pIb8psZLknx
 l2TRtPoLMhUhHCbvAItz1JfQssjpqwU8NB4QnB0Wuvfne4zEIyqSZJkUGYKw7HBLwP
 l0NEMoc6kpf4mRdQT2uuELBOg/NVMfJ8TMPkPX0E62cP7/2T6VwSOQvWdmwkZL1nLs
 qx7cfr1czc4V4Lu+5YpqS3nboAZRdY7zGFRTlVmIuS9H7G/LWGhkvIFLz3MCMv6I5I
 2sYiXqeQqrpydsFCXN26r9k7PlUbgVyKW/OsF08xiqaLrV7DIgRBATa8Ky/iuyMC1o
 2hM36npc1LiFQ==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id B876E1C8CE
 for <dev@dpdk.org>; Tue, 26 May 2026 09:01:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779778867;
 bh=2/vQjmvIGvvIxf67SQSTQ3M/QmisuY22sHv/0UI3Tvs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KbRy6E9y/gO+3inIkUlkHGGCbKeQUufGltH2kg7DhsP+aVMnlLiRK0pIb8psZLknx
 l2TRtPoLMhUhHCbvAItz1JfQssjpqwU8NB4QnB0Wuvfne4zEIyqSZJkUGYKw7HBLwP
 l0NEMoc6kpf4mRdQT2uuELBOg/NVMfJ8TMPkPX0E62cP7/2T6VwSOQvWdmwkZL1nLs
 qx7cfr1czc4V4Lu+5YpqS3nboAZRdY7zGFRTlVmIuS9H7G/LWGhkvIFLz3MCMv6I5I
 2sYiXqeQqrpydsFCXN26r9k7PlUbgVyKW/OsF08xiqaLrV7DIgRBATa8Ky/iuyMC1o
 2hM36npc1LiFQ==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 9BA911C93D; Tue, 26 May 2026 09:01:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779778866;
 bh=2/vQjmvIGvvIxf67SQSTQ3M/QmisuY22sHv/0UI3Tvs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fLMC+Xb8bQCnJhFH1LCpR3W1luWBLtcou9j1qJ/hjQJyC/E1n7ne5KhLkVf/dCHnh
 PMybCATmOCSv4KDDGBy1x9iJ9agiAyx9SKzXPapffixi+PNIlBlwWpCgYbhZTgWOPN
 //oxTdchnnbM53oqwpcf8saWclUH0ykjFkic+rhjEc/Q2pe+cSyFrXEoZ5E2zPCzq6
 xVOJOPU2krFZLvrMbE0QQcTw9eO/exNCimnm73NkuwaFvY+tijMaYBIrhMTVwSBTIO
 YHVctpuS5sJw7AIx5LHvxAu9M07/jDDA+ZqIaTd7FWJSM3nFwOudgJ8uNZPi+1bzul
 IKZcP7x/lwXVw==
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id E78411C8CB;
 Tue, 26 May 2026 09:01:04 +0200 (CEST)
Message-ID: <118452aa-63f7-4072-b06b-9a5b94829348@lysator.liu.se>
Date: Tue, 26 May 2026 09:01:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] lib/fastmem: fast small-object allocator
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Yogaraj Baskaravel <yogaraj.baskaravel@ericsson.com>
References: <20260525103642.55255-1-hofors@lysator.liu.se>
 <20260525073029.235b4d40@phoenix.local>
 <af3a4738-df30-43c4-b3d9-5ec1912a307a@lysator.liu.se>
 <20260525151824.6a32e829@phoenix.local>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <20260525151824.6a32e829@phoenix.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

On 5/26/26 00:18, Stephen Hemminger wrote:
> On Mon, 25 May 2026 21:39:20 +0200
> Mattias Rönnblom <hofors@lysator.liu.se> wrote:
> 
>> On 5/25/26 16:30, Stephen Hemminger wrote:
>>> On Mon, 25 May 2026 12:36:39 +0200
>>> Mattias Rönnblom <hofors@lysator.liu.se> wrote:
>>>    
>>>> This RFC introduces fastmem, a general-purpose small-object allocator
>>>> for DPDK. It is intended to replace per-type mempools with a single
>>>> allocator that handles arbitrary sizes, grows on demand, and matches
>>>> mempool-level performance on the hot path.
>>>
>>> Makes sense, what a simple wrapper inline to allow full replacement
>>> testing/performance A/B comparison?
>>
>> Do you mean a mempool or a heap wrapper? Or both?
>>
>> I haven't looked into what options there are with mempools. A mempool
>> driver should be possible, but then I guess one might attempt a
>> whole-sale mempool-compatible API as well.
> 
> My thinking is a yet another allocator in DPDK is just another source
> of confusion and bugs. BUT if it can consolidate and fully replace
> one or more existing allocators then it would be great improvement.
> 
> Mempools are fast, but fixed and space inefficient.
> Rte_malloc is slow, but flexible.
> 
> Also, need to make whatever is added play well with static
> and dynamic checkers.

I'm not sure it's possible to replace mempools with a slab allocator 
like fastmem. They have different semantics, and I suspect that there 
are times when you prefer a mempool.

# Object Identity & Content Preservation

A mempool always returns one of the same pre-populated objects, with its 
contents untouched since last use. This enables pre-initialized fields, 
hardware-registered buffers, and constructors that run only once.

# Safe Use-After-Free

Returned objects remain valid, typed memory even after release. Stale 
references do not segfault or observe unrelated data, enabling RCU-style 
deferred reclamation.

# Bounded, Failure-Free Operation

A mempool operates with a fixed number of objects and performs no 
runtime memory allocation. This guarantees deterministic latency, 
natural backpressure, and eliminates `ENOMEM` failures after initialization.

# Known IOVA at Initialization Time

All object addresses, both virtual and physical, are fixed and 
enumerable from creation time. This enables pre-programming DMA 
descriptors and IOMMU registration.

# Memory Accounting

A mempool provides an exact, attributable memory footprint per pool, 
without sharing backing memory across unrelated users.

# Dense, Enumerable Object Set

Objects share a common base address and fixed stride, enabling efficient 
iteration and pointer compression.

Considering many apps use DPDK for I/O and other hardware abstraction 
only, and carry all other OS/kernel/platform type infrastructure 
themselves, replacing the mempools with something else will likely cause 
a lot of friction.

A fastmem-backed mempool backend (with limitations)? Sure.

Replacing rte_malloc seems easier, but I haven't looked into that in 
detail yet.

