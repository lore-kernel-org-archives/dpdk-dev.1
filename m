Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E318CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 04:56:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0267402E7;
	Thu, 21 May 2026 06:56:38 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 45C674028D;
 Thu, 21 May 2026 06:56:37 +0200 (CEST)
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id CF0EA7AD1;
 Thu, 21 May 2026 06:56:36 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id C2A107B87; Thu, 21 May 2026 06:56:36 +0200 (CEST)
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 13E627B24;
 Thu, 21 May 2026 06:56:34 +0200 (CEST)
Message-ID: <b6348099-0eac-4944-9e8e-cbc269464188@lysator.liu.se>
Date: Thu, 21 May 2026 06:56:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Memory management BoF summary (DPDK Summit 2026)
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, dev@dpdk.org
Cc: techboard@dpdk.org, mattias.ronnblom@ericsson.com
References: <98CBD80474FA8B44BF855DF32C47DC35F6587B@smartserver.smartshare.dk>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6587B@smartserver.smartshare.dk>
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

On 5/18/26 10:35, Morten Brørup wrote:
> There are two ways of allocating/freeing memory objects in DPDK:
> 1.	From the memory heap, i.e. rte_malloc() etc.
> 2.	From a memory pool, i.e. rte_mempool_get() etc.
> 
> The current memory heap in DPDK has two issues:
> -	It is too slow to be used in the fast path.
> -	There may be contention between control threads and
> 	EAL threads for the same spinlocks in the heap.
> 
> The memory pools in the DPDK has multiple issues:
> -	It is designed for fixed size objects,
> 	so individual mempools must be allocated for each type of object.
> 	(In theory, mempools could be allocated per object size,
> 	and shared across modules.
> 	But that would require coordination across modules, including
> 	the total number of objects required by these modules,
> 	the choice of underlying mempool driver,
> 	and the optimal mempool cache size.)
> -	The number of objects in each mempool is fixed,
> 	so applications have to size their mempools to worst case usage.
> -	The memory for the objects in a mempool is pre-allocated.
> In summary, mempools consume significantly more memory than effectively
> being used.
> 
> We discussed the need for a new memory heap system,
> and converged on the following features:
> -	Providing functions to allocate and free memory objects of varying
> 	size, like the rte_malloc library, but usable in the fast path.
> -	Perhaps also a need for bulk alloc/free functions,
> 	like the rte_mempool library.
> -	Building on top of memzones.
> -	No dependency on the current DPDK heap, so it can cleanly replace it.
> 	This is a stretch requirement.
> -	NUMA aware.
> -	Using slabs for various block sizes like in the Linux Kernel,
> 	possibly with object size 2^N.
> -	Using per-lcore caches to reduce contention,
> 	resembling the mempool per-lcore caches.
> 
> Mattias Rönnblom has implemented a prototype with the above properties,
> and this was a good starting point for the discussion.
> 

I'm working to get an OK from the appropriate internal stakeholders, 
then I'll post an RFC.

Thanks a lot for the excellent summary.

> Discussion:
> -	It does not seem to be a requirement to be able to free the memory
> 	used by the heap back to the memzones.
> -	It is possible having header-less objects.
> 	However, if the headers are relatively small compared to the size of
> 	the objects themselves, having a header may offer some benefits.
> -	The mempool library has implementation details optimizing for
> 	spreading usage across memory channels, cache alignment, etc..
> 	Such performance optimization details might need consideration.
> -	There is a lower limit to how small objects will be allocated.
> 	E.g. objects smaller than the size of a pointer is unlikely.
> -	It is acceptable to return an object larger than the size requested,
> 	e.g. returning an object of 16 bytes when 12 bytes were requested.
> -	Preventing false sharing of allocated objects between CPU caches
> 	may not be necessary, but must be considered.
> -	Optimally, the new heap should replace the existing heap.
> 	As seen with the timer wheel library previously proposed, replacing
> 	core libraries in DPDK is difficult, so adding the new heap library
> 	in parallel with the existing heap, i.e. with separate APIs, might be
> 	a path of less resistance.
> 	It will then be an application choice to use this new memory heap.
> 	And long term, it can replace the existing heap, if appropriate.
> 
> Mbuf discussion:
> -	As a stretch goal, mbufs should be dynamically allocated from
> 	the new heap, instead of being pre-allocated in mempools.
> -	This might be achievable either
> 	-	by replacing the mempool library with a wrapper to the heap, or
> 	-	by providing a new mempool driver using the heap, as an
> 		alternative to the existing ring and stack mempool drivers.

Would be very interesting to see a prototype of a mempool driver for a 
new small-object allocator.

> -	In this context, it is important to note that mbuf objects have some
> 	pre-initialized fields when held in their respective mempools.
> 	If allocating an mbuf directly from the heap, these fields must
> 	somehow be initialized.
> 	We did not discuss solutions for this, but noted that using the new
> 	heap for mbufs should be considered in the design choices.
> 
> 
> Venlig hilsen / Kind regards,
> -Morten Brørup

