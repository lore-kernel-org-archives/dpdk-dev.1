Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A357C61DB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 05:23:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E77340151;
	Thu, 27 Aug 2026 07:23:48 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id A67194003C
 for <dev@dpdk.org>; Thu, 27 Aug 2026 07:23:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1787808225;
 bh=5w+l6AcQ8s/bXURRGQ+t8HCjGD6n6tUHcJHJgAC5PrE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MCuq6G4IOuJ3kplkiQLGNdScMJKLsqHJ98VDeX/KmQOKV+By6TVMBN6fbu7HXTn6A
 /Li48zLd1bG4g1r+jQKCYbTCE6NxJcAwgk5uTphiizZmYVbBaoXndKTRC6VYh+kBf5
 yB1PHY1jE5yI5y8v59IBukw25XepkDK+J3ZiBOhZ9ewq/ceNcqOGYYSZVd0WOKXVfn
 MUDIU1tHW+J7xRfn1o+T1eafcuL5DDeNa8QwMlWbdJY83KOoemPBLmBfLoiotZyE7Q
 4sl7tK/FZqZ2F+YXDjdzW1EBRsPbDZ+lcZ8Bq9nti+n2V8PDB1m1Zx5c8EQWfJ2949
 2ErZTga4RkiUA==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id 56BC11D925
 for <dev@dpdk.org>; Thu, 27 Aug 2026 07:23:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1787808225;
 bh=5w+l6AcQ8s/bXURRGQ+t8HCjGD6n6tUHcJHJgAC5PrE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MCuq6G4IOuJ3kplkiQLGNdScMJKLsqHJ98VDeX/KmQOKV+By6TVMBN6fbu7HXTn6A
 /Li48zLd1bG4g1r+jQKCYbTCE6NxJcAwgk5uTphiizZmYVbBaoXndKTRC6VYh+kBf5
 yB1PHY1jE5yI5y8v59IBukw25XepkDK+J3ZiBOhZ9ewq/ceNcqOGYYSZVd0WOKXVfn
 MUDIU1tHW+J7xRfn1o+T1eafcuL5DDeNa8QwMlWbdJY83KOoemPBLmBfLoiotZyE7Q
 4sl7tK/FZqZ2F+YXDjdzW1EBRsPbDZ+lcZ8Bq9nti+n2V8PDB1m1Zx5c8EQWfJ2949
 2ErZTga4RkiUA==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 3B62D1D924; Thu, 27 Aug 2026 07:23:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1787808222;
 bh=5w+l6AcQ8s/bXURRGQ+t8HCjGD6n6tUHcJHJgAC5PrE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=pWfAKQkiHdGBePPaP44qvDqM+ehJMoUiAStU60AVrl/jqCfaw1pXxStn74vW63Ay6
 Z5z/w53gRlRmJTNYRUIJdgfC1KRnA5vvlRD+TMpscGGrB8tgrTq5ITBF1tL9WM+RFe
 M3bBYL1OLqyUxOW520fWQtikrRmvK+MwES/XkrbgKNRe0gaCx0ieivc9IeZ8ychxw6
 Xd+UwDkTyltfNb1Q46b61h19ZBGZZ2sPZ6Wk33e1v2/Zmby8CWM35D9wAT4xKSikbP
 /g9HexhV/2M4mVsjCCjwObr5OAXvrCvJwVyUOuutA2Pq+yCMKuhbUQcxBCTSZsBbd5
 nttViboWyZ38w==
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id C14851D922;
 Thu, 27 Aug 2026 07:23:40 +0200 (CEST)
Message-ID: <a35a18d9-6b91-4a6f-891f-b6636f28fd91@lysator.liu.se>
Date: Thu, 27 Aug 2026 07:23:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 2/3] lib: add fastmem library
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, dev@dpdk.org
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Yogaraj Baskaravel <yogaraj.baskaravel@ericsson.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
References: <20260527173042.93867-2-hofors@lysator.liu.se>
 <20260530092634.46218-1-hofors@lysator.liu.se>
 <20260530092634.46218-3-hofors@lysator.liu.se>
 <98CBD80474FA8B44BF855DF32C47DC35F659DE@smartserver.smartshare.dk>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F659DE@smartserver.smartshare.dk>
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

On 8/13/26 13:32, Morten Brørup wrote:
> Hi Mattias,
> 
> It would be great to get fastmem into DPDK 26.11.
> 

At this point, it doesn't look like I have any time to spend on this 
contribution in the near future.

Also, I would like to get more actual application use of this library 
before its inclusion.

I started to investigate if you can fit a slab allocator as one of the 
allocation paths in rte_malloc.h, and I think that might be doable as 
well. There's a fair bit of subtle issues there to solve first though, 
and that's a more ambitious project. My next RFC would probably have 
been an attempt at this.

In case fastmem is accepted as a separate, standalone library it doesn't 
need to be shipped in one of the ABI-breaking releases. So 27.03 should 
be fine.

Something that would help is a tech board or mem subsystem maintainer 
indication of if a separate API/library is the way to go as a first 
step, or if we should do what Stephen Hemminger has argued for and not 
introduce a new memory allocator API but rather just fix the heap right 
away.

The latter is higher effort, higher risk, but also higher reward.

> I have reviewed the patch for features and usage. Not for correctness.
> 

Thanks. I will review this later, when I pick up fastmem work again.

Sorry for the late reply.

> Here are my comments, in somewhat random order.
> 
> -
> 
> Export symbols for 26.11, not 24.11.
> 
> -
> 
> Generally, consider setting rte_errno and returning -1, instead of returning -ESOMETHING.
> Then, e.g. in bin_alloc_one(), if slab_acquire() returns NULL, grow_socket() (called by slab_acquire()) has already set rte_errno.
> 
> -
> 
> +/*
> + * Slab header at offset 0 of each 2 MiB slab. Either free (linked
> + * via next_free) or assigned to a bin (linked via list).
> + */
> +struct fastmem_slab {
> +	struct fastmem_bin *bin;
> +	void *free_head;
> +	uint32_t free_count;
> +	uint32_t n_slots;
> +	struct fastmem_slab *next_free;
> +	TAILQ_ENTRY(fastmem_slab) list;
> +	rte_iova_t iova_base;
> +} __rte_aligned(FASTMEM_SLAB_HEADER_SIZE);
> 
> I wonder if rte_fastmem_virt2iova() is going to be a hot function?
> Then it should be inline, and the iova_base field should be first in the fastmem_slab for easier access (and possibly faster on architectures without "load with offset" instructions).
> 
> The rte_fastmem_virt2iova() function can be inline without exposing fastmem internals by using opaque pointer magic.
> The opaque pointer magic should be protected by a bunch of static_assert()'s in rte_fastmem.c, mentioning that rte_fastmem_virt2iova() depends on these.
> Something like:
> 
> static inline rte_iova_t
> rte_fastmem_virt2iova(const void *ptr)
> {
> //	struct fastmem_slab *slab;
> 	void *slab;
> 
> //	slab = slab_of((void *)(uintptr_t)ptr);
> //	slab = (uintptr_t)ptr & ~(uintptr_t)FASTMEM_SLAB_MASK;
> 	slab = ((uintptr_t)ptr & ~(uintptr_t)((1 << 21) - 1));
> 	// rte_fastmem.c: static_assert(FASTMEM_SLAB_MASK == (1 << 21) - 1),
> 		"Mismatch in rte_fastmem_virt2iova()");
> 
> //	return slab->iova_base + ((uintptr_t)ptr - (uintptr_t)slab);
> 	return *(rte_iova_t *)slab + ((uintptr_t)ptr - (uintptr_t)slab);
> 	// rte_fastmem.c: static_assert(offsetof(struct fastmem_slab, iova_base) == 0,
> 		"Mismatch in rte_fastmem_virt2iova()");
> }
> 
> -
> 
> Generally, statistics counting should be build-time configurable enable/disable for performance.
> It's acceptable to keep the variables in the structs, and just not update them.
> Consider (with statistics disabled) removing the statistics variables from the fastmem_cache structure, so the objects at the bottom of the stack are in the same cache line as the count/capacity fields. (If it makes any practical difference.)
> 
> -
> 
> +struct fastmem_cache {
> +	uint32_t count;
> +	uint32_t capacity;
> +	uint32_t target;
> +	uint64_t alloc_cache_hits;
> +	uint64_t alloc_cache_misses;
> +	uint64_t alloc_nomem;
> +	uint64_t free_cache_hits;
> +	uint64_t free_cache_misses;
> +	void *objs[];
> +} __rte_cache_aligned;
> 
> "target" is a shadow of "capacity / 2".
> It is rarely used without also accessing "capacity".
> Consider dropping it, and just using capacity / 2.
> It might even improve performance in some locations, where "capacity" is already loaded into a CPU register or will be used shortly thereafter. (My performance comment is pure speculation, not measured.) (For reference, the mempool lib uses cache->size / 2.)
> 
> -
> 
> Initialization should be done at the proper DPDK startup stage, not lazily at all fastmem functions.
> In the fastmem functions, calling fastmem_assure() should be replaced by a simple RTE_ASSERT(fastmem != NULL).
> 
> I was wondering how do other libs handle the situation where a secondary process depends on init performed by the primary function?
> It looks like they do something similiar to fastmem_assure(). This sucks!
> That's an important feature gap in DPDK, which I already registered as a bug on the wishlist: https://bugs.dpdk.org/show_bug.cgi?id=1913
> 
> Until we get that wish fixed, we should make eal depend on fastmem, and call the fastmem init function from inside rte_eal_init().
> 
> -
> 
> Do you foresee any other flags than RTE_FASTMEM_F_ZERO?
> I'd prefer not passing a flags parameter to the fastmem public alloc APIs, and instead expose two variants of the alloc APIs.
> It's OK to pass around the zero flag (or a boolean) internally; it will be optimized away because it is known at build time from the two alloc API variants.
> 
> -
> 
> A fastmem handle "rte_fastmem_handle_t" is not an object handle, so the name could be misleading.
> It's rather a sort of accelerator or helper for faster alloc/free.
> 
> Also, it doesn't support SOCKET_ID_ANY (-1).
> Would it be beneficial to support SOCKET_ID_ANY, so the socket_id part gets resolved when using the fastmem handle?
> Or would that defeat the performance gain of fastmem handles?
> And are there relevant use cases for fastmem handle supporting SOCKET_ID_ANY, or am I pointlessly feature creeping?
> 
> -
> 
> +#define FASTMEM_MIN_SIZE ((size_t)1 << FASTMEM_MIN_CLASS_LOG2)
> +#define FASTMEM_MAX_ALLOC_SIZE ((size_t)1 << FASTMEM_MAX_CLASS_LOG2)
> 
> Min and Max names should be similar.
> 
> -
> 
> rte_fastmem_cache_flush():
> The function name could indicate that it operates on the current lcore only.
> Makes code using the function easier to read, for reviewers unfamiliar with the fastmem lib.
> 
> -
> 
> In grow_socket():
> +	if (socket->n_memzones == FASTMEM_MAX_MEMZONES_PER_SOCKET) {
> +		FASTMEM_LOG(ERR,
> +			"reached per-socket memzone cap (%u) on socket %d",
> 
> cap -> limit
> 
> -
> 
> In bin_push_locked():
> 
> +		struct fastmem_slab *slab = (struct fastmem_slab *)
> +			((uintptr_t)obj & ~(uintptr_t)FASTMEM_SLAB_MASK);
> 
> -> slab_of()
> 
> -Morten

