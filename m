Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8C0CD5BD0
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 May 2026 16:22:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C90B4029F;
	Sat, 30 May 2026 18:22:59 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id D9D914028C
 for <dev@dpdk.org>; Sat, 30 May 2026 18:22:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1780158177;
 bh=2j2ctDZPw0+zSP/386rKOQdCO2fNeDMk9R8v/Nlof0c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=aZ+TjYhubY75nQ1XiK1EyzQff7IwVp9YKkYI2DWanm4/5HOdEBfeBECboExdZYvxM
 WDKpUZ9IqIJrd3IGbmZkJHowbg2bdB6ApZjdBZXmtFSU5sH56a7eS0vlJKOlfNSN+Q
 zq5cbm2tQa/XN6IGg6cjRiLTF6EZpPAYAHkf+XfinPh9vyxLH6sVRBXEHJGL+n+Vsx
 PIL0HX0TzJzcjsUztx+HOYR6GeCkxsKnBPCtDkOKxWsr7WlO9TZCuWB5Gq1CCV98XI
 RlxpZmb+oneqDTA9ZjjGawY37G/lt64JAlMUiS8sLSmJqV4NW5rIY0++LQxB4DZAdt
 VneCTzrMSqfeQ==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id 88B00FCE0
 for <dev@dpdk.org>; Sat, 30 May 2026 18:22:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1780158177;
 bh=2j2ctDZPw0+zSP/386rKOQdCO2fNeDMk9R8v/Nlof0c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=aZ+TjYhubY75nQ1XiK1EyzQff7IwVp9YKkYI2DWanm4/5HOdEBfeBECboExdZYvxM
 WDKpUZ9IqIJrd3IGbmZkJHowbg2bdB6ApZjdBZXmtFSU5sH56a7eS0vlJKOlfNSN+Q
 zq5cbm2tQa/XN6IGg6cjRiLTF6EZpPAYAHkf+XfinPh9vyxLH6sVRBXEHJGL+n+Vsx
 PIL0HX0TzJzcjsUztx+HOYR6GeCkxsKnBPCtDkOKxWsr7WlO9TZCuWB5Gq1CCV98XI
 RlxpZmb+oneqDTA9ZjjGawY37G/lt64JAlMUiS8sLSmJqV4NW5rIY0++LQxB4DZAdt
 VneCTzrMSqfeQ==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 6B92DFDBD; Sat, 30 May 2026 18:22:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1780158175;
 bh=2j2ctDZPw0+zSP/386rKOQdCO2fNeDMk9R8v/Nlof0c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=gU0Cw8FHCFfjXyXzVeBBdOteO6V28xGgMQXzi2CIVWzNIiOnBcbkcuVOMyrpqBxyj
 zpsjyBXMRja7BajLzL3eSMfnvknccol/Z6ErCvvfHcZbXay3+ATDNWaN4d3gkVgUG6
 Yvd87yqRdP69/NvCZt3sEV6QvXM2L1I2/OWYqccNklJ5P4DMpT3zaC03JZvRugqSJx
 jWElg3XRRqg0PnfJ4NitoSvKXqcoptFXQH9vB+1e0I9Nc3ieOrNR6pCjmKLBX+KcSb
 00JJrCn75TupFKqmz55RnLVXnG+RjhWPw0+Ji5h54n4/BtnAidfZdqtmkK7eyCIRfc
 1eTo0IOnbol3g==
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 63283FDBB;
 Sat, 30 May 2026 18:22:54 +0200 (CEST)
Message-ID: <5b5905e9-5952-49e8-80f7-7a390092e4bb@lysator.liu.se>
Date: Sat, 30 May 2026 18:22:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 2/3] lib: add fastmem library
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 "Varghese, Vipin" <Vipin.Varghese@amd.com>,
 Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Yogaraj Baskaravel <yogaraj.baskaravel@ericsson.com>,
 Stephen Hemminger <stephen@networkplumber.org>
References: <20260526085743.64396-4-hofors@lysator.liu.se>
 <20260527173042.93867-1-hofors@lysator.liu.se>
 <20260527173042.93867-3-hofors@lysator.liu.se>
 <98CBD80474FA8B44BF855DF32C47DC35F658AD@smartserver.smartshare.dk>
 <DS0PR12MB6608CB2B4897A5CB91D2D1C482092@DS0PR12MB6608.namprd12.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35F658B3@smartserver.smartshare.dk>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F658B3@smartserver.smartshare.dk>
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

On 5/28/26 21:56, Morten Brørup wrote:
>> From: Varghese, Vipin [mailto:Vipin.Varghese@amd.com]
>> Sent: Thursday, 28 May 2026 16.45
>>
>> Public
>>
>> Hi @Morten Brørup
>>
>> <snipped>
>>
>>>
>>>> +/**
>>>> + * Pre-reserve backing memory.
>>>> + *
>>>> + * Ensures that at least @p size bytes of memzone-backed memory
>> are
>>>> + * available to the allocator on @p socket_id, reserving
>> additional
>>>> + * memzones from EAL as needed to reach that total. Subsequent
>>>> + * allocations served from the pre-reserved memory do not incur
>>>> + * memzone-reservation cost.
>>>> + *
>>>> + * The reservation is cumulative: repeated calls to
>>>> + * rte_fastmem_reserve() with the same @p socket_id grow the
>>>> + * reservation monotonically. Reserved memory is never returned to
>>>> + * the system during the allocator's lifetime.
>>>> + *
>>>> + * A typical use is to call rte_fastmem_reserve() once at
>>>> + * application startup, with a size chosen to cover the expected
>>>> + * steady-state working set. Allocations and frees during
>>>> + * steady-state operation then avoid memzone reservations
>> entirely.
>>>> + *
>>>> + * @param size
>>>> + *  The minimum amount of backing memory, in bytes, to make
>>>> + *  available on @p socket_id. The allocator may reserve more than
>>>> + *  the requested amount due to internal rounding (e.g., to
>> memzone
>>>> + *  or block granularity).
>>>> + *
>>>> + * @param socket_id
>>>> + *  The NUMA socket on which to reserve memory, or SOCKET_ID_ANY
>>>> + *  to leave the choice to the allocator. With SOCKET_ID_ANY, the
>>>> + *  allocator starts on the calling lcore's socket (or the first
>>>> + *  configured socket if the caller is not bound to one) and falls
>>>> + *  back to other sockets if the preferred socket cannot satisfy
>>>> + *  the reservation.
>>>> + *
>>>> + * @return
>>>> + *  - 0: Success.
>>>> + *  - -ENOMEM: Insufficient huge-page memory to satisfy the
>> request.
>>>> + *  - -EINVAL: Invalid @p socket_id.
>>>> + */
>>>> +__rte_experimental
>>>> +int
>>>> +rte_fastmem_reserve(size_t size, int socket_id);
>>>
>>> @Bruce,
>>> I vaguely recall that we discussed something about busses and sockets
>> a long time
>>> ago, but I cannot remember the details.
>>> Is socket_id the right type (and parameter name) to identify a memory
>> bus?
>>>
>>> @Vipin,
>>> You have been working on topology awareness. Same question to you:
>>> Is socket_id the right type (and parameter name) to identify a memory
>> bus?
>>
>> Short answer: socket_id is no longer a precise or sufficient
>> abstraction to represent a memory bus.
>> Based on the topology work with libhwloc, we’ve observed the following
>> across Ampere, Intel, and AMD platforms:
>>
>> Features like SNC (Sub-NUMA Clustering) on Intel and NPS (NUMA Per
>> Socket) on AMD change how socket_id maps to hardware.
>> In these modes:
>>
>> 1) A single physical socket can expose multiple NUMA domains.
>> 2)These NUMA domains align more closely with memory controller
>> groupings (i.e., memory buses) rather than the full socket.
>>
>>
>> Depending on the architecture:
>> a) Memory controllers may be collocated with compute cores or placed on
>> separate tiles.
>> b) As a result, socket_id can represent different scopes (full socket
>> vs. sub-socket domains), making it inconsistent.
>>
>>
>>
>> Hence practically: In some configurations, socket_id ≈ memory domain.
>> In others, it is coarser than the actual memory bus topology.
>>
>> To address this ambiguity, in the topology patches (v5/v6), we are
>> moving toward clearer separation:
>>
>> a. Cache domains (L1/L2/L3/L4) for compute locality
>> b. NUMA domains (memory + IO) as the unit for allocation locality
>>
>> This direction better reflects real hardware and avoids overloading
>> socket_id with multiple meanings.
>>
>> Happy to align this with the topology model we’re introducing so the
>> abstraction remains consistent going forward.
>> Thanks,
>> Vipin
> 
> Thank you for the quick and detailed response, Vipin!
> 
> I haven't looked deeply into the v5/v6 topology patches yet (it's on my TODO list).
> 
> The rte_fastmem library builds on top of the rte_memzone library.
> 
> So, if the rte_memzone library is updated to replace the meaning of its "socket_id" parameter with some NUMA domain identifier (we better rename the "socket_id" to a new name "numa_domain_id"), then the rte_fastmem library could remain unaffected, and its "socket_id" parameter would be passed on directly to the rte_memzone library's "numa_domain_id"?
> 

What is a "domain" here? It's the same as what is usually (in my 
experience) referred to as a NUMA node?

I would just call it "node_id".

> This is my conclusion: At this point, proper support for allocating memory in specific NUMA domains is an rte_memzone library issue, and nothing to worry about for the rte_fastmem library - it will be automatically supported in rte_fastmem when supported by rte_memzone.
> 
> 

