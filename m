Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD13CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 10:12:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23A7040285;
	Wed, 27 May 2026 12:12:25 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 645AD4026C
 for <dev@dpdk.org>; Wed, 27 May 2026 12:12:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779876742;
 bh=vhlEZrjJn3+8oUc73vEhWAWvZ/VeupWc0shHZHMvF84=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=oMEPfdMooBgSccBge0KnjXJxSGvMb6FvccXytDpcOLsHAAlD0dOBqSXlGmEwh0LrO
 /UF9Pi5afDFsrg06GmS6fq8az5s7En85pV1gsXZ3vzj/mssGS8eyzNppfTPG/Ny8nx
 UszutoaSgk6MzIgAq2p9qbnwQ/nUCm0nFkrqUj2D7bH/BFpa5bQZS8y+2p2rzJPlYF
 XJlHSn1Jv+HOfLDEDfXm59geiqOAFY+02K4fEFv45fr4DaCoVEnGhAt6bVksOiVS9Z
 5l1nxjY+nltaEDclLg5RDp3BG1MTZSQrG3Qi3c/y5myTlSvP4GURUKH+hsfbRMYjxX
 FWjyaL8uJX5ww==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id DEA601AB4
 for <dev@dpdk.org>; Wed, 27 May 2026 12:12:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779876742;
 bh=vhlEZrjJn3+8oUc73vEhWAWvZ/VeupWc0shHZHMvF84=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=oMEPfdMooBgSccBge0KnjXJxSGvMb6FvccXytDpcOLsHAAlD0dOBqSXlGmEwh0LrO
 /UF9Pi5afDFsrg06GmS6fq8az5s7En85pV1gsXZ3vzj/mssGS8eyzNppfTPG/Ny8nx
 UszutoaSgk6MzIgAq2p9qbnwQ/nUCm0nFkrqUj2D7bH/BFpa5bQZS8y+2p2rzJPlYF
 XJlHSn1Jv+HOfLDEDfXm59geiqOAFY+02K4fEFv45fr4DaCoVEnGhAt6bVksOiVS9Z
 5l1nxjY+nltaEDclLg5RDp3BG1MTZSQrG3Qi3c/y5myTlSvP4GURUKH+hsfbRMYjxX
 FWjyaL8uJX5ww==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id C359B19F1; Wed, 27 May 2026 12:12:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779876741;
 bh=vhlEZrjJn3+8oUc73vEhWAWvZ/VeupWc0shHZHMvF84=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Xh56ZZ1yKcf3YOG0mTXItDqRgGXQWN6bHNGw6pfjD2o37rqcbU98ygukwWkiq+3QU
 3U3dTAsrvqwDBKhWQXyN4YZ21Y9PUDs54Eiz1DsBTc4asB/GYiHj5RT6WD3mPlI0y8
 YgWDKa2vFlnp4UfCyhhxt0apqkc/V+6kpBqJRF1iMkH238LbVXSF+z3mBq90rK/uGW
 QKeG0zG8so7TLTrXNSEJA0H5P0zqtl5ECAi26YnfKuWZpFavyqKn7yB7Be3huEVgop
 ciPkkh8QK9AGkFM5gpUnEgINLmnSVCUh9yVWV49rrP9DqPmHuCaIZkYrQ3DbJH1I7U
 0rcD3gmAQbdRA==
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id C508E19F0;
 Wed, 27 May 2026 12:12:19 +0200 (CEST)
Message-ID: <b3982582-3023-4f2c-9c62-10d4af20d4e2@lysator.liu.se>
Date: Wed, 27 May 2026 12:12:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 2/3] lib: add fastmem library
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Yogaraj Baskaravel <yogaraj.baskaravel@ericsson.com>
References: <20260525103642.55255-4-hofors@lysator.liu.se>
 <20260526085743.64396-1-hofors@lysator.liu.se>
 <20260526085743.64396-3-hofors@lysator.liu.se>
 <20260526062312.33f76fcc@phoenix.local>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <20260526062312.33f76fcc@phoenix.local>
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

On 5/26/26 15:23, Stephen Hemminger wrote:
> On Tue, 26 May 2026 10:57:42 +0200
> Mattias Rönnblom <hofors@lysator.liu.se> wrote:
> 
>> +__rte_experimental
>> +void *
>> +rte_fastmem_alloc(size_t size, size_t align, unsigned int flags)
>> +	__rte_alloc_size(1) __rte_alloc_align(2);
> 
> Should also add attribute __rte_malloc which tells compiler
> that pointer returned cannot alias other memory
> 
> And add __rte_dealloc(rte_fastmem_free, 1)
> which tells compiler that the returned pointer should only go
> back to fastmem (not free, rte_free, etc).

Done. Only works for the single-object ops (not bulk) though.

I've had a look at how to extend fastmem to support larger allocations 
(without suggesting this is the way to go).

Seems to me that implementation should be something like
a) slab allocator for small objects.
b) a cache-less per-socket page run allocator for mid-sized objects.
c) per-object memzones for large objects.

If one would implement that, you would essentially have a plug-in 
replacement for rte_malloc.h (maybe minus some debug and some more 
esoteric DPDK heap features).

Should fastmem be an outright replacement, or something that at least 
initially lives alongside the regular heap, maybe with a run- or 
compile-time option to make rte_malloc.h functions delegate to fastmem? 
This is unclear to me at this point. I fear the more ambitious, cleaner 
and more risky DPDK heap replacement path will go they way my attempts 
to replace rte_memcpy or rte_timer went.

I would agree with anyone saying that we should have only one heap-like 
API for memory allocations. rte_malloc.h obviously needs to stay, for 
backward compatibility reason, if nothing else. I would like to add bulk 
alloc/free, and allow for smaller alignments than 64, since slabs can do 
that efficiently (DPDK heap per-object header is 128 bytes!). One could 
either go about that by extending rte_malloc.h or deprecating that API 
and starting anew. In the latter case, one could do many more minor 
tweaks, like removing the type pointers (only a nuance), remove the 
validate function, change and extend the stats interface, etc.

