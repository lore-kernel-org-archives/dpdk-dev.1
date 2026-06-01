Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD23FCD5BD1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 18:18:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCCDE402F1;
	Mon,  1 Jun 2026 20:18:21 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 35134402DB
 for <dev@dpdk.org>; Mon,  1 Jun 2026 20:18:20 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gThyM1BctzHnGfj;
 Tue,  2 Jun 2026 02:17:31 +0800 (CST)
Received: from dubpeml100002.china.huawei.com (unknown [7.214.144.156])
 by mail.maildlp.com (Postfix) with ESMTPS id 2C8BE40571;
 Tue,  2 Jun 2026 02:18:19 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100002.china.huawei.com (7.214.144.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 1 Jun 2026 19:18:18 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Mon, 1 Jun 2026 19:18:18 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: RE: [PATCH v4 03/27] ring: unify memory model on C11, remove atomic32
Thread-Topic: [PATCH v4 03/27] ring: unify memory model on C11, remove atomic32
Thread-Index: AQHc7WcAzUgC9KGGd0ePrjz7hKqVP7YnzPLw
Date: Mon, 1 Jun 2026 18:18:18 +0000
Message-ID: <b8523a4e0ee34e8b9194935574e86f7c@huawei.com>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
 <20260526232542.620966-4-stephen@networkplumber.org>
In-Reply-To: <20260526232542.620966-4-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.35.234]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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


> Remove the RTE_USE_C11_MEM_MODEL build switch; C11 atomics are now
> the default for all platforms. Unifies __rte_ring_update_tail into
> the C11 form (atomic_store_release replaces the older rte_smp_wmb +
> plain store on the generic path) and renames rte_ring_generic_pvt.h
> to rte_ring_x86_pvt.h to reflect its new scope.
>=20
> Also splits the head-move helper into separate ST and MT variants,
> removing the runtime is_st branch from the MT retry loop.
> This gets small boost and scopes the following exception
> more tightly.
>=20
> Exception: on x86 with GCC, atomic_compare_exchange on the head CAS
> regresses MP/MC contended throughput by ~20% existing hand-written
> cmpxchg. As a workaround, GCC-on-x86 builds use the older
> __sync_bool_compare_and_swap builtin, which generates equivalent
> code to the original asm. Can be reverted if/when GCC gets
> fixed; similar issue was observed in Linux kernel.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/ring/meson.build                          |   2 +-
>  lib/ring/rte_ring_c11_pvt.h                   |  75 +++--------
>  lib/ring/rte_ring_elem_pvt.h                  | 125 ++++++++++++++++--
>  ..._ring_generic_pvt.h =3D> rte_ring_x86_pvt.h} |  61 ++-------
>  lib/ring/soring.c                             |  15 ++-
>  5 files changed, 158 insertions(+), 120 deletions(-)
>  rename lib/ring/{rte_ring_generic_pvt.h =3D> rte_ring_x86_pvt.h} (60%)
>=20
> diff --git a/lib/ring/meson.build b/lib/ring/meson.build
> index 21f2c12989..b178c963b8 100644
> --- a/lib/ring/meson.build
> +++ b/lib/ring/meson.build
> @@ -9,7 +9,7 @@ indirect_headers +=3D files (
>          'rte_ring_elem.h',
>          'rte_ring_elem_pvt.h',
>          'rte_ring_c11_pvt.h',
> -        'rte_ring_generic_pvt.h',
> +        'rte_ring_x86_pvt.h',
>          'rte_ring_hts.h',
>          'rte_ring_hts_elem_pvt.h',
>          'rte_ring_peek.h',
> diff --git a/lib/ring/rte_ring_c11_pvt.h b/lib/ring/rte_ring_c11_pvt.h
> index 07b6efc416..3efe011f08 100644
> --- a/lib/ring/rte_ring_c11_pvt.h
> +++ b/lib/ring/rte_ring_c11_pvt.h
> @@ -15,35 +15,10 @@
>   * @file rte_ring_c11_pvt.h
>   * It is not recommended to include this file directly,
>   * include <rte_ring.h> instead.
> - * Contains internal helper functions for MP/SP and MC/SC ring modes.
> + * Contains internal helper functions for MP and MC ring modes.
>   * For more information please refer to <rte_ring.h>.
>   */
>=20
> -/**
> - * @internal This function updates tail values.
> - */
> -static __rte_always_inline void
> -__rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
> -		uint32_t new_val, uint32_t single, uint32_t enqueue)
> -{
> -	RTE_SET_USED(enqueue);
> -
> -	/*
> -	 * If there are other enqueues/dequeues in progress that preceded us,
> -	 * we need to wait for them to complete
> -	 */
> -	if (!single)
> -		rte_wait_until_equal_32((uint32_t *)(uintptr_t)&ht->tail, old_val,
> -			rte_memory_order_relaxed);
> -
> -	/*
> -	 * R0: Establishes a synchronizing edge with load-acquire of tail at A1=
.
> -	 * Ensures that memory effects by this thread on ring elements array
> -	 * is observed by a different thread of the other type.
> -	 */
> -	rte_atomic_store_explicit(&ht->tail, new_val,
> rte_memory_order_release);
> -}
> -
>  /**
>   * @internal This is a helper function that moves the producer/consumer =
head
>   *
> @@ -72,14 +47,11 @@ __rte_ring_update_tail(struct rte_ring_headtail *ht,
> uint32_t old_val,
>   *   If behavior =3D=3D RTE_RING_QUEUE_FIXED, this will be 0 or n only
>   */
>  static __rte_always_inline unsigned int
> -__rte_ring_headtail_move_head(struct rte_ring_headtail *d,
> +__rte_ring_headtail_move_head_mt(struct rte_ring_headtail *d,
>  		const struct rte_ring_headtail *s, uint32_t capacity,
> -		unsigned int is_st, unsigned int n,
> -		enum rte_ring_queue_behavior behavior,
> +		unsigned int n,	enum rte_ring_queue_behavior behavior,
>  		uint32_t *old_head, uint32_t *new_head, uint32_t *entries)
>  {
> -	uint32_t stail;
> -	int success;
>  	unsigned int max =3D n;
>=20
>  	/*
> @@ -89,8 +61,7 @@ __rte_ring_headtail_move_head(struct rte_ring_headtail
> *d,
>  	 * d->head.
>  	 * If not, an unsafe partial order may ensue.
>  	 */
> -	*old_head =3D rte_atomic_load_explicit(&d->head,
> -			rte_memory_order_acquire);
> +	*old_head =3D rte_atomic_load_explicit(&d->head, rte_memory_order_acqui=
re);
>  	do {
>  		/* Reset n to the initial burst count */
>  		n =3D max;
> @@ -101,15 +72,14 @@ __rte_ring_headtail_move_head(struct
> rte_ring_headtail *d,
>  		 * ring elements array is observed by the time
>  		 * this thread observes its tail update.
>  		 */
> -		stail =3D rte_atomic_load_explicit(&s->tail,
> -					rte_memory_order_acquire);
> +		uint32_t stail =3D rte_atomic_load_explicit(&s->tail,
> rte_memory_order_acquire);
>=20
>  		/* The subtraction is done between two unsigned 32bits value
>  		 * (the result is always modulo 32 bits even if we have
>  		 * *old_head > s->tail). So 'entries' is always between 0
>  		 * and capacity (which is < size).
>  		 */
> -		*entries =3D (capacity + stail - *old_head);
> +		*entries =3D capacity + stail - *old_head;
>=20
>  		/* check that we have enough room in ring */
>  		if (unlikely(n > *entries))
> @@ -120,25 +90,20 @@ __rte_ring_headtail_move_head(struct
> rte_ring_headtail *d,
>  			return 0;
>=20
>  		*new_head =3D *old_head + n;
> -		if (is_st) {
> -			d->head =3D *new_head;
> -			success =3D 1;
> -		} else
> -			/* on failure, *old_head is updated */
> -			/*
> -			 * R1/A2.
> -			 * R1: Establishes a synchronizing edge with A0 of a
> -			 * different thread.
> -			 * A2: Establishes a synchronizing edge with R1 of a
> -			 * different thread to observe same value for stail
> -			 * observed by that thread on CAS failure (to retry
> -			 * with an updated *old_head).
> -			 */
> -			success =3D
> rte_atomic_compare_exchange_strong_explicit(
> -					&d->head, old_head, *new_head,
> -					rte_memory_order_release,
> -					rte_memory_order_acquire);
> -	} while (unlikely(success =3D=3D 0));
> +
> +		/* on failure, *old_head is updated */
> +		/*
> +		 * R1/A2.
> +		 * R1: Establishes a synchronizing edge with A0 of a
> +		 * different thread.
> +		 * A2: Establishes a synchronizing edge with R1 of a
> +		 * different thread to observe same value for stail
> +		 * observed by that thread on CAS failure (to retry
> +		 * with an updated *old_head).
> +		 */
> +	} while (unlikely(!rte_atomic_compare_exchange_strong_explicit(
> +				  &d->head, old_head, *new_head,
> +				  rte_memory_order_release,
> rte_memory_order_acquire)));
>  	return n;
>  }
>=20
> diff --git a/lib/ring/rte_ring_elem_pvt.h b/lib/ring/rte_ring_elem_pvt.h
> index 6eafae121f..9d1da12a92 100644
> --- a/lib/ring/rte_ring_elem_pvt.h
> +++ b/lib/ring/rte_ring_elem_pvt.h
> @@ -299,17 +299,108 @@ __rte_ring_dequeue_elems(struct rte_ring *r,
> uint32_t cons_head,
>  			cons_head & r->mask, esize, num);
>  }
>=20
> -/* Between load and load. there might be cpu reorder in weak model
> - * (powerpc/arm).
> - * There are 2 choices for the users
> - * 1.use rmb() memory barrier
> - * 2.use one-direction load_acquire/store_release barrier
> - * It depends on performance test results.
> +/**
> + * @internal This function updates tail values.
>   */
> -#ifdef RTE_USE_C11_MEM_MODEL
> -#include "rte_ring_c11_pvt.h"
> +static __rte_always_inline void
> +__rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
> +		uint32_t new_val, uint32_t single, uint32_t enqueue)
> +{
> +	RTE_SET_USED(enqueue);
> +
> +	/*
> +	 * If there are other enqueues/dequeues in progress that preceded us,
> +	 * we need to wait for them to complete
> +	 */
> +	if (!single)
> +		rte_wait_until_equal_32((uint32_t *)(uintptr_t)&ht->tail, old_val,
> +			rte_memory_order_relaxed);
> +
> +	/*
> +	 * R0: Establishes a synchronizing edge with load-acquire of tail at A1=
.
> +	 * Ensures that memory effects by this thread on ring elements array
> +	 * is observed by a different thread of the other type.
> +	 */
> +	rte_atomic_store_explicit(&ht->tail, new_val,
> rte_memory_order_release);
> +}
> +
> +/**
> + * @internal This is a helper function that moves the producer/consumer =
head
> + *
> + *
> + * This optimized version for single threaded case.
> + *
> + * @param d
> + *   A pointer to the headtail structure with head value to be moved
> + * @param s
> + *   A pointer to the counter-part headtail structure. Note that this
> + *   function only reads tail value from it
> + * @param capacity
> + *   Either ring capacity value (for producer), or zero (for consumer)
> + * @param n
> + *   The number of elements we want to move head value on
> + * @param behavior
> + *   RTE_RING_QUEUE_FIXED:    Move on a fixed number of items
> + *   RTE_RING_QUEUE_VARIABLE: Move on as many items as possible
> + * @param old_head
> + *   Returns head value as it was before the move
> + * @param new_head
> + *   Returns the new head value
> + * @param entries
> + *   Returns the number of ring entries available BEFORE head was moved
> + * @return
> + *   Actual number of objects the head was moved on
> + *   If behavior =3D=3D RTE_RING_QUEUE_FIXED, this will be 0 or n only
> + */
> +static __rte_always_inline unsigned int
> +__rte_ring_headtail_move_head_st(struct rte_ring_headtail *d,
> +		const struct rte_ring_headtail *s, uint32_t capacity,
> +		unsigned int n, enum rte_ring_queue_behavior behavior,
> +		uint32_t *old_head, uint32_t *new_head, uint32_t *entries)
> +{
> +	uint32_t stail;
> +

I really like the idea to split _st and _mt move_head into separate functio=
ns.
That makes code much cleaner an easier to understand and maintain.
Few comments on actual '_st' implementation below:=20
=20
> +	/*
> +	 * A0: Establishes a synchronizing edge with R1.
> +	 * Ensure that this thread observes same values
> +	 * to stail observed by the thread that updated
> +	 * d->head.
> +	 * If not, an unsafe partial order may ensue.
> +	 */

I believe that comment is not relevant for '_st',
there is no R1 anymore for '_st' - see below,
and no other thread except that one can move the head.
So, there is probably no point to use '_acquire' order here.
=20
> +	*old_head =3D rte_atomic_load_explicit(&d->head,
> rte_memory_order_acquire);
> +
> +	/*
> +	 * A1: Establishes a synchronizing edge with R0.
> +	 * Ensures that other thread's memory effects on
> +	 * ring elements array is observed by the time
> +	 * this thread observes its tail update.
> +	 */
> +	stail =3D rte_atomic_load_explicit(&s->tail, rte_memory_order_acquire);
> +
> +	/* The subtraction is done between two unsigned 32bits value
> +	 * (the result is always modulo 32 bits even if we have
> +	 * *old_head > s->tail). So 'entries' is always between 0
> +	 * and capacity (which is < size).
> +	 */
> +	*entries =3D capacity + stail - *old_head;
> +
> +	/* check that we have enough room in ring */
> +	if (unlikely(n > *entries))
> +		n =3D (behavior =3D=3D RTE_RING_QUEUE_FIXED) ? 0 : *entries;
> +
> +	if (n > 0) {
> +		*new_head =3D *old_head + n;
> +		d->head =3D *new_head;

There is a bit of inconsistency with the 'load' operation above:
If we use atomic_load(&d->head. ...) then it would be better to use
atomic_store(&d->head,..., order_relaxed) here.
=20
> +	}
> +
> +	return n;
> +}
> +
> +/* There are two choices because GCC optimizer does poorly on
> atomic_compare_exchange */
> +#if defined(RTE_TOOLCHAIN_GCC) && defined(RTE_ARCH_X86)

If we still need to use legacy code for x86, I think we need an explcit mac=
ro
to enable C11 for x86 (RTE_RING_FORCE_C11 or so):
to make sure that C11 version will still get tested and measured on x86.=20

> +#include "rte_ring_x86_pvt.h"
>  #else
> -#include "rte_ring_generic_pvt.h"
> +#include "rte_ring_c11_pvt.h"
>  #endif

I tried to look at compiler output for both cases, most of the code
looks nearly identical, one thing that I noticed:=20
C11 __rte_ring_headtail_move_head_mt() uses output
parameter: 'uint32_t *old_head' directly within CAS operation.
In x86_64 that cause gcc to generate extra instructions to
store return value of CAS (eax) within 'old_head' memory location,
even when CAS was not successfull and another attempt should be
performed. In some cases, even extra branch can be observed:
https://godbolt.org/z/4dTrqMjYe
In constrast, x86 specific version that uses
__sync_bool_compare_and_swap() doesn't exibit such problem,
as __sync_bool_compare_and_swap() doesn't update the 'old_head'
with new value, and we have to re-read it explicitly on each iteration.
I tried to overcome that problem by using local variable 'head' inside the =
loop,
and updaing '*old_head' value only at exit.
With such change gcc manages to avoid extra store(/branch),
see __rte_ring_headtail_move_head_mt_c11_v2() in the link above.
Can I ask you to re-run your perf test with the patch:
https://patchwork.dpdk.org/project/dpdk/patch/20260601181509.71007-1-konsta=
ntin.ananyev@huawei.com/
applied on top of your changes and see would it help in terms of performanc=
e?
From other side - if you'll point me to the exact tests you are running,
I am happy to repeat them on my box.=20
My preference would be to avoid arch/compiler specific versions, if possibl=
e.

>  /**
> @@ -341,8 +432,12 @@ __rte_ring_move_prod_head(struct rte_ring *r,
> unsigned int is_sp,
>  		uint32_t *old_head, uint32_t *new_head,
>  		uint32_t *free_entries)
>  {
> -	return __rte_ring_headtail_move_head(&r->prod, &r->cons, r->capacity,
> -			is_sp, n, behavior, old_head, new_head, free_entries);
> +	if (is_sp)
> +		return __rte_ring_headtail_move_head_st(&r->prod, &r->cons,
> r->capacity,
> +				n, behavior, old_head, new_head, free_entries);
> +	else
> +		return __rte_ring_headtail_move_head_mt(&r->prod, &r->cons,
> r->capacity,
> +				n, behavior, old_head, new_head, free_entries);
>  }
>=20
>  /**
> @@ -374,8 +469,12 @@ __rte_ring_move_cons_head(struct rte_ring *r,
> unsigned int is_sc,
>  		uint32_t *old_head, uint32_t *new_head,
>  		uint32_t *entries)
>  {
> -	return __rte_ring_headtail_move_head(&r->cons, &r->prod, 0,
> -			is_sc, n, behavior, old_head, new_head, entries);
> +	if (is_sc)
> +		return __rte_ring_headtail_move_head_st(&r->cons, &r->prod,
> 0,
> +				n, behavior, old_head, new_head, entries);
> +	else
> +		return __rte_ring_headtail_move_head_mt(&r->cons, &r->prod,
> 0,
> +				n, behavior, old_head, new_head, entries);
>  }
>=20
>  /**
> diff --git a/lib/ring/rte_ring_generic_pvt.h b/lib/ring/rte_ring_x86_pvt.=
h
> similarity index 60%
> rename from lib/ring/rte_ring_generic_pvt.h
> rename to lib/ring/rte_ring_x86_pvt.h
> index affd2d5ba7..c8de108bbd 100644
> --- a/lib/ring/rte_ring_generic_pvt.h
> +++ b/lib/ring/rte_ring_x86_pvt.h
> @@ -7,39 +7,19 @@
>   * Used as BSD-3 Licensed with permission from Kip Macy.
>   */
>=20
> -#ifndef _RTE_RING_GENERIC_PVT_H_
> -#define _RTE_RING_GENERIC_PVT_H_
> +#ifndef _RTE_RING_X86_PVT_H_
> +#define _RTE_RING_X86_PVT_H_
>=20
>  /**
> - * @file rte_ring_generic_pvt.h
> + * @file rte_ring_x86_pvt.h
>   * It is not recommended to include this file directly,
>   * include <rte_ring.h> instead.
> - * Contains internal helper functions for MP/SP and MC/SC ring modes.
> - * For more information please refer to <rte_ring.h>.
> + *
> + * Contains internal helper functions for MP and MC ring modes.
> + * It is GCC specific to workaround poor optimizer handling of C11 atomi=
c
> + * compare_exchange.
>   */
>=20
> -/**
> - * @internal This function updates tail values.
> - */
> -static __rte_always_inline void
> -__rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
> -		uint32_t new_val, uint32_t single, uint32_t enqueue)
> -{
> -	if (enqueue)
> -		rte_smp_wmb();
> -	else
> -		rte_smp_rmb();
> -	/*
> -	 * If there are other enqueues/dequeues in progress that preceded us,
> -	 * we need to wait for them to complete
> -	 */
> -	if (!single)
> -		rte_wait_until_equal_32((volatile uint32_t *)(uintptr_t)&ht->tail,
> old_val,
> -			rte_memory_order_relaxed);
> -
> -	ht->tail =3D new_val;
> -}
> -
>  /**
>   * @internal This is a helper function that moves the producer/consumer =
head
>   *
> @@ -50,8 +30,6 @@ __rte_ring_update_tail(struct rte_ring_headtail *ht,
> uint32_t old_val,
>   *   function only reads tail value from it
>   * @param capacity
>   *   Either ring capacity value (for producer), or zero (for consumer)
> - * @param is_st
> - *   Indicates whether multi-thread safe path is needed or not
>   * @param n
>   *   The number of elements we want to move head value on
>   * @param behavior
> @@ -68,14 +46,13 @@ __rte_ring_update_tail(struct rte_ring_headtail *ht,
> uint32_t old_val,
>   *   If behavior =3D=3D RTE_RING_QUEUE_FIXED, this will be 0 or n only
>   */
>  static __rte_always_inline unsigned int
> -__rte_ring_headtail_move_head(struct rte_ring_headtail *d,
> +__rte_ring_headtail_move_head_mt(struct rte_ring_headtail *d,
>  		const struct rte_ring_headtail *s, uint32_t capacity,
> -		unsigned int is_st, unsigned int n,
> +		unsigned int n,
>  		enum rte_ring_queue_behavior behavior,
>  		uint32_t *old_head, uint32_t *new_head, uint32_t *entries)
>  {
>  	unsigned int max =3D n;
> -	int success;
>=20
>  	do {
>  		/* Reset n to the initial burst count */
> @@ -83,18 +60,13 @@ __rte_ring_headtail_move_head(struct rte_ring_headtai=
l
> *d,
>=20
>  		*old_head =3D d->head;
>=20
> -		/* add rmb barrier to avoid load/load reorder in weak
> -		 * memory model. It is noop on x86
> -		 */
> -		rte_smp_rmb();
> -
>  		/*
>  		 *  The subtraction is done between two unsigned 32bits value
>  		 * (the result is always modulo 32 bits even if we have
>  		 * *old_head > s->tail). So 'entries' is always between 0
>  		 * and capacity (which is < size).
>  		 */
> -		*entries =3D (capacity + s->tail - *old_head);
> +		*entries =3D capacity + s->tail - *old_head;
>=20
>  		/* check that we have enough room in ring */
>  		if (unlikely(n > *entries))
> @@ -105,15 +77,10 @@ __rte_ring_headtail_move_head(struct
> rte_ring_headtail *d,
>  			return 0;
>=20
>  		*new_head =3D *old_head + n;
> -		if (is_st) {
> -			d->head =3D *new_head;
> -			success =3D 1;
> -		} else
> -			success =3D rte_atomic32_cmpset(
> -					(uint32_t *)(uintptr_t)&d->head,
> -					*old_head, *new_head);
> -	} while (unlikely(success =3D=3D 0));
> +	} while (unlikely(!__sync_bool_compare_and_swap(
> +				  (uint32_t *)(uintptr_t)&d->head,
> +				  *old_head, *new_head)));
>  	return n;
>  }
>=20
> -#endif /* _RTE_RING_GENERIC_PVT_H_ */
> +#endif /* _RTE_RING_X86_PVT_H_ */
> diff --git a/lib/ring/soring.c b/lib/ring/soring.c
> index 3b90521bdb..0e8bbc03c1 100644
> --- a/lib/ring/soring.c
> +++ b/lib/ring/soring.c
> @@ -135,9 +135,12 @@ __rte_soring_move_prod_head(struct rte_soring *r,
> uint32_t num,
>=20
>  	switch (st) {
>  	case RTE_RING_SYNC_ST:
> +		n =3D __rte_ring_headtail_move_head_st(&r->prod.ht, &r-
> >cons.ht,
> +				r->capacity, num, behavior, head, next, free);
> +		break;
>  	case RTE_RING_SYNC_MT:
> -		n =3D __rte_ring_headtail_move_head(&r->prod.ht, &r->cons.ht,
> -			r->capacity, st, num, behavior, head, next, free);
> +		n =3D __rte_ring_headtail_move_head_mt(&r->prod.ht, &r-
> >cons.ht,
> +				r->capacity, num, behavior, head, next, free);
>  		break;
>  	case RTE_RING_SYNC_MT_RTS:
>  		n =3D __rte_ring_rts_move_head(&r->prod.rts, &r->cons.ht,
> @@ -168,9 +171,13 @@ __rte_soring_move_cons_head(struct rte_soring *r,
> uint32_t stage, uint32_t num,
>=20
>  	switch (st) {
>  	case RTE_RING_SYNC_ST:
> +		n =3D __rte_ring_headtail_move_head_st(&r->cons.ht,
> +			&r->stage[stage].ht, 0, num, behavior,
> +			head, next, avail);
> +		break;
>  	case RTE_RING_SYNC_MT:
> -		n =3D __rte_ring_headtail_move_head(&r->cons.ht,
> -			&r->stage[stage].ht, 0, st, num, behavior,
> +		n =3D __rte_ring_headtail_move_head_mt(&r->cons.ht,
> +			&r->stage[stage].ht, 0, num, behavior,
>  			head, next, avail);
>  		break;
>  	case RTE_RING_SYNC_MT_RTS:
> --
> 2.53.0

