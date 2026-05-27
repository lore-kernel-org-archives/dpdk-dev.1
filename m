Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BAECD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 11:17:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D380A4028A;
	Wed, 27 May 2026 13:17:36 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id A823640285
 for <dev@dpdk.org>; Wed, 27 May 2026 13:17:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779880655;
 bh=yppszZggc+xWpLlScd12rjfgKyjPOEUznQPavvTfE2s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SqCDqfoCb6ym4js+4wwPuS13wx7mKPHoowMqCEZxTxaebP+/nFOTVtBB/ygmx0zs4
 GlLQRDuQ7D8aD7+1S7Z/olKvNK0ROtiHZoU8ghGxrBY7iWfGapF9qWjgsoHSAvCYta
 5bU9GyM1/EZiNpgw/mVbWEyNHpyL1o+780AgoWigf+eLX4tTuDuXFdatHNTI64/HRV
 HlHAT6A/RJRgqPKjKndvIkpCugKYirkMsurL7UPKzh1zCa6UHD9I2RTJ2a2vWIItMb
 c3m02njgpRRFxre2j6GWUwHky3Tn+iKrVWbtTvcRaNL3YTiLzXkmUtGgAfuayW2PSr
 DEKsdQmH9d7og==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id 5919A1CF9
 for <dev@dpdk.org>; Wed, 27 May 2026 13:17:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779880655;
 bh=yppszZggc+xWpLlScd12rjfgKyjPOEUznQPavvTfE2s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SqCDqfoCb6ym4js+4wwPuS13wx7mKPHoowMqCEZxTxaebP+/nFOTVtBB/ygmx0zs4
 GlLQRDuQ7D8aD7+1S7Z/olKvNK0ROtiHZoU8ghGxrBY7iWfGapF9qWjgsoHSAvCYta
 5bU9GyM1/EZiNpgw/mVbWEyNHpyL1o+780AgoWigf+eLX4tTuDuXFdatHNTI64/HRV
 HlHAT6A/RJRgqPKjKndvIkpCugKYirkMsurL7UPKzh1zCa6UHD9I2RTJ2a2vWIItMb
 c3m02njgpRRFxre2j6GWUwHky3Tn+iKrVWbtTvcRaNL3YTiLzXkmUtGgAfuayW2PSr
 DEKsdQmH9d7og==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 3D8021CF6; Wed, 27 May 2026 13:17:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779880649;
 bh=yppszZggc+xWpLlScd12rjfgKyjPOEUznQPavvTfE2s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rKtL90xe1wuqgvjFgxJPLDFT1mpAjUKGpARln1SpVZkMetpHX7keOVCWlmnCBdMlJ
 yDM3XlVGyZaNg//ldvVX3IVfvlS1EBv7bC/DtwYixp7Id+uDsyZTJ3K3+9gdQ6lPLM
 tlFEZsg+MIA9GRuD9NzkG8l5LcUtZTWcVvm9hD9xJIOKgmSxLr7gNeEXMYdwTgQsh8
 p7rsG/w4K9wz1L2/kR2T6VzDMT0K7bJRRvhtwzxNahuB52ojyPd3x50cqVn8RRwJDC
 c3mFYe4isP9V69J84e7pJd4I7szHgNlkfm8o3dzVyWmkLSonOMgDUwxrDtYZ33UECt
 5aP9vOYfTrusg==
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 1AE3E1E4F;
 Wed, 27 May 2026 13:17:28 +0200 (CEST)
Message-ID: <7fc2a8dc-a0b8-4ea7-a612-46e0975b8840@lysator.liu.se>
Date: Wed, 27 May 2026 13:17:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 2/3] lib: add fastmem library
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Yogaraj Baskaravel <yogaraj.baskaravel@ericsson.com>
References: <20260525103642.55255-4-hofors@lysator.liu.se>
 <20260526085743.64396-1-hofors@lysator.liu.se>
 <20260526085743.64396-3-hofors@lysator.liu.se>
 <20260526062312.33f76fcc@phoenix.local>
 <b3982582-3023-4f2c-9c62-10d4af20d4e2@lysator.liu.se>
 <ahbE6KvlgzG_XkSY@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <ahbE6KvlgzG_XkSY@bricha3-mobl1.ger.corp.intel.com>
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

On 5/27/26 12:18, Bruce Richardson wrote:
> On Wed, May 27, 2026 at 12:12:19PM +0200, Mattias Rönnblom wrote:
>> On 5/26/26 15:23, Stephen Hemminger wrote:
>>> On Tue, 26 May 2026 10:57:42 +0200
>>> Mattias Rönnblom <hofors@lysator.liu.se> wrote:
>>>
>>>> +__rte_experimental
>>>> +void *
>>>> +rte_fastmem_alloc(size_t size, size_t align, unsigned int flags)
>>>> +	__rte_alloc_size(1) __rte_alloc_align(2);
>>>
>>> Should also add attribute __rte_malloc which tells compiler
>>> that pointer returned cannot alias other memory
>>>
>>> And add __rte_dealloc(rte_fastmem_free, 1)
>>> which tells compiler that the returned pointer should only go
>>> back to fastmem (not free, rte_free, etc).
>>
>> Done. Only works for the single-object ops (not bulk) though.
>>
>> I've had a look at how to extend fastmem to support larger allocations
>> (without suggesting this is the way to go).
>>
>> Seems to me that implementation should be something like
>> a) slab allocator for small objects.
>> b) a cache-less per-socket page run allocator for mid-sized objects.
>> c) per-object memzones for large objects.
>>
>> If one would implement that, you would essentially have a plug-in
>> replacement for rte_malloc.h (maybe minus some debug and some more esoteric
>> DPDK heap features).
>>
>> Should fastmem be an outright replacement, or something that at least
>> initially lives alongside the regular heap, maybe with a run- or
>> compile-time option to make rte_malloc.h functions delegate to fastmem? This
>> is unclear to me at this point. I fear the more ambitious, cleaner and more
>> risky DPDK heap replacement path will go they way my attempts to replace
>> rte_memcpy or rte_timer went.
>>
>> I would agree with anyone saying that we should have only one heap-like API
>> for memory allocations. rte_malloc.h obviously needs to stay, for backward
>> compatibility reason, if nothing else. I would like to add bulk alloc/free,
>> and allow for smaller alignments than 64, since slabs can do that
>> efficiently (DPDK heap per-object header is 128 bytes!). One could either go
>> about that by extending rte_malloc.h or deprecating that API and starting
>> anew. In the latter case, one could do many more minor tweaks, like removing
>> the type pointers (only a nuance), remove the validate function, change and
>> extend the stats interface, etc.
>>
> +1 for replacing rte_malloc. For a replacement, I'd tend towards aiming for
> compatibilty over trying to fix too many little things at once. While
> changing a couple of things is ok, I'd rather not force applications to
> make too many updates to their code when moving from one DPDK version to
> another.
> 

What one could attempt to do is to be fully backward compatible with 
rte_malloc.h (maybe minus some debug features that require per-object 
headers?) and then expose a new API which is functionally a superset of 
rte_malloc.h.

The new API would be something like a hybrid of rte_malloc.h, the 
mempool APIs, and the kind of API you find on an in-kernel memory 
manager (e.g., Solaris'), tuned for DPDK lcore use.

> /Bruce

