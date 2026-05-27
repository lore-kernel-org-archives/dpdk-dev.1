Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3488CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 11:29:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F141940285;
	Wed, 27 May 2026 13:29:50 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 2C2A34026C
 for <dev@dpdk.org>; Wed, 27 May 2026 13:29:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779881389;
 bh=C47qO+bsrbsz29XRsXUpG4SzWqDU9R/c5XEgx+UleGg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=TwS0Rw/h5FiEUblZxEkJweTWP/d5+U6CIi5+R1/8MAg+1xgRqVk7A/FAjZzhjB+G6
 i29Rmd1jL+nNJqNXbiaaH5w45H803aIF1thCxZzrbGxwE7ZLxnCvdGMLipnOF9n3QH
 0aEZVw1kTuwoKdBTdkxAFcilJMBlhYwLpR/6TTqu61tz794PxZb9cynFvGSgjwWagK
 8HlPVeDmzfNiaRs0lCvUtgmIfm7UhWVxvZHDxf1B2mT7SMgXRHDnT4GXGswKRaD9Wh
 6Rp8uDzADnYMTmcHbI4kPg696yeMbZOE/qTZOStU7nfbb4eJG/hFpm2HMJtFSBY9pv
 VZyos+u7q7p9w==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id ADEBD1F02
 for <dev@dpdk.org>; Wed, 27 May 2026 13:29:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779881389;
 bh=C47qO+bsrbsz29XRsXUpG4SzWqDU9R/c5XEgx+UleGg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=TwS0Rw/h5FiEUblZxEkJweTWP/d5+U6CIi5+R1/8MAg+1xgRqVk7A/FAjZzhjB+G6
 i29Rmd1jL+nNJqNXbiaaH5w45H803aIF1thCxZzrbGxwE7ZLxnCvdGMLipnOF9n3QH
 0aEZVw1kTuwoKdBTdkxAFcilJMBlhYwLpR/6TTqu61tz794PxZb9cynFvGSgjwWagK
 8HlPVeDmzfNiaRs0lCvUtgmIfm7UhWVxvZHDxf1B2mT7SMgXRHDnT4GXGswKRaD9Wh
 6Rp8uDzADnYMTmcHbI4kPg696yeMbZOE/qTZOStU7nfbb4eJG/hFpm2HMJtFSBY9pv
 VZyos+u7q7p9w==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 9302B1DFA; Wed, 27 May 2026 13:29:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779881387;
 bh=C47qO+bsrbsz29XRsXUpG4SzWqDU9R/c5XEgx+UleGg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BgIkD3eNDPvwAs1QQ0x3nebO32RVLKIZ0Y5w13ppUJy6oDrwq5QIHPqvgAvyyrGGq
 1iV6YsbCKuJmy7HplIJ8hPdFOmPbwKet5G/ZDidYvc+ztvqQJ0lM03MDrXa9vgOiGE
 eEsSy99dH5wc4/oA9kOIC3APQabiUm04uOSHcMnrzLDIZZttg4IRaSwfaRCvtgfSHy
 58jwwokK6E3RopRnt6M0IZJbRQ7qFPfOkVeGB0+WHjq9H0E6i0sZAV7NBIVhcbouKm
 jNXsoNsYH11Q7kpO6FuXNBFPCYFt35d10rBEIwFmfv5ZgnZg15ss61PDCRw6IpHkVM
 ob+5gko2Fiv/g==
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 4C6C71E77;
 Wed, 27 May 2026 13:29:47 +0200 (CEST)
Message-ID: <4b9f4f80-3bbf-490d-b39e-c40930d653fd@lysator.liu.se>
Date: Wed, 27 May 2026 13:29:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 2/3] lib: add fastmem library
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Yogaraj Baskaravel <yogaraj.baskaravel@ericsson.com>
References: <20260525103642.55255-4-hofors@lysator.liu.se>
 <20260526085743.64396-1-hofors@lysator.liu.se>
 <20260526085743.64396-3-hofors@lysator.liu.se>
 <20260526062312.33f76fcc@phoenix.local>
 <b3982582-3023-4f2c-9c62-10d4af20d4e2@lysator.liu.se>
 <ahbE6KvlgzG_XkSY@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F658A1@smartserver.smartshare.dk>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F658A1@smartserver.smartshare.dk>
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

On 5/27/26 13:17, Morten Brørup wrote:
>> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
>> Sent: Wednesday, 27 May 2026 12.18
>>
>> On Wed, May 27, 2026 at 12:12:19PM +0200, Mattias Rönnblom wrote:
>>> On 5/26/26 15:23, Stephen Hemminger wrote:
>>>> On Tue, 26 May 2026 10:57:42 +0200
>>>> Mattias Rönnblom <hofors@lysator.liu.se> wrote:
>>>>
>>>>> +__rte_experimental
>>>>> +void *
>>>>> +rte_fastmem_alloc(size_t size, size_t align, unsigned int flags)
>>>>> +	__rte_alloc_size(1) __rte_alloc_align(2);
>>>>
>>>> Should also add attribute __rte_malloc which tells compiler
>>>> that pointer returned cannot alias other memory
>>>>
>>>> And add __rte_dealloc(rte_fastmem_free, 1)
>>>> which tells compiler that the returned pointer should only go
>>>> back to fastmem (not free, rte_free, etc).
>>>
>>> Done. Only works for the single-object ops (not bulk) though.
>>>
>>> I've had a look at how to extend fastmem to support larger
>> allocations
>>> (without suggesting this is the way to go).
>>>
>>> Seems to me that implementation should be something like
>>> a) slab allocator for small objects.
>>> b) a cache-less per-socket page run allocator for mid-sized objects.
>>> c) per-object memzones for large objects.
> 
> All allocations through the library should somehow build on memzones.
> If an application wants "normal" memory, it can use libc free()/malloc().
> 

All allocations come out of memzones. In the c) case, each object is a 
memzone. There is a very limited number of memzones, so they can't be many.

>>>
>>> If one would implement that, you would essentially have a plug-in
>>> replacement for rte_malloc.h (maybe minus some debug and some more
>> esoteric
>>> DPDK heap features).
>>>
>>> Should fastmem be an outright replacement, or something that at least
>>> initially lives alongside the regular heap, maybe with a run- or
>>> compile-time option to make rte_malloc.h functions delegate to
>> fastmem? This
>>> is unclear to me at this point. I fear the more ambitious, cleaner
>> and more
>>> risky DPDK heap replacement path will go they way my attempts to
>> replace
>>> rte_memcpy or rte_timer went.
>>>
>>> I would agree with anyone saying that we should have only one heap-
>> like API
>>> for memory allocations. rte_malloc.h obviously needs to stay, for
>> backward
>>> compatibility reason, if nothing else. I would like to add bulk
>> alloc/free,
>>> and allow for smaller alignments than 64, since slabs can do that
>>> efficiently (DPDK heap per-object header is 128 bytes!). One could
>> either go
>>> about that by extending rte_malloc.h or deprecating that API and
>> starting
>>> anew. In the latter case, one could do many more minor tweaks, like
>> removing
>>> the type pointers (only a nuance), remove the validate function,
>> change and
>>> extend the stats interface, etc.
>>>
>> +1 for replacing rte_malloc. For a replacement, I'd tend towards aiming
>> for
>> compatibilty over trying to fix too many little things at once. While
>> changing a couple of things is ok, I'd rather not force applications to
>> make too many updates to their code when moving from one DPDK version
>> to
>> another.
>>
>> /Bruce
> 
> +1 for taking the path that begins with starting anew.
> The new heap library can be designed specifically for the fast path, based on years of DPDK experience with what the fast path really needs.
> It will allow much broader experimentation along the way.
> We can easily get rid of all slow path legacy stuff in rte_malloc, like the "type" parameter.
> 
> I think we all agree that replacing rte_malloc should be the end game.
> But IMO, it very important that the properties of rte_malloc do not impose any limits on the new heap library.
> 
> Someday, when the new library has sufficiently matured, we can discuss how it can replace the rte_malloc library.
> Maybe some parts of rte_malloc are not replaceable, and need to be deprecated and removed.
> Maybe we all have switched to using the new heap, and nobody is using rte_malloc anymore, so it can simply be removed. ;-)
> 

It would be useful to have a run- or compile-time switch to use fastmem 
instead of the regular DPDK heap. In such a case, having it as an 
external library will complicate things during initialization, if you 
want all allocations to end up in fastmem.

Unfortunately, if a rte_malloc replacement, I think it belongs in the 
EAL, just like today's heap. That doesn't mean it have to start in the EAL.

> Suggestion regarding naming:
> The prefix could be "rte_mem_" instead of "rte_fastmem_" - it is shorter, and most libraries are "fast".
> And then it could live in /lib/memory instead of /lib/fastmem.
> 

mem is very generic, but point taken. Name should change, unclear to 
what. Depends on the role it will serve.
