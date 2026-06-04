Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD22CD6E77
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 15:09:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 135AF402CC;
	Thu,  4 Jun 2026 17:09:46 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 35E54402B6
 for <dev@dpdk.org>; Thu,  4 Jun 2026 17:09:44 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gWSdF4d6szHnGgC;
 Thu,  4 Jun 2026 23:08:49 +0800 (CST)
Received: from dubpeml100002.china.huawei.com (unknown [7.214.144.156])
 by mail.maildlp.com (Postfix) with ESMTPS id 59CE840584;
 Thu,  4 Jun 2026 23:09:43 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100002.china.huawei.com (7.214.144.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 4 Jun 2026 16:09:42 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Thu, 4 Jun 2026 16:09:42 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: RE: [PATCH 1/5] ring: split single thread vs multi-thread cases
Thread-Topic: [PATCH 1/5] ring: split single thread vs multi-thread cases
Thread-Index: AQHc8rN9YW8goiGZLUeKOZUTkni+ArYuetRA
Date: Thu, 4 Jun 2026 15:09:42 +0000
Message-ID: <4d00e4b985034da1ac4724c5420ea117@huawei.com>
References: <20260602171552.686349-1-stephen@networkplumber.org>
 <20260602171552.686349-2-stephen@networkplumber.org>
In-Reply-To: <20260602171552.686349-2-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.220]
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



> The move head function has optimization for updating when
> being used on single threaded ring. Code is cleaner if the two
> cases are split into separate functions.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/ring/rte_ring_c11_pvt.h     | 100 +++++++++++++++++++++++++-------
>  lib/ring/rte_ring_elem_pvt.h    |  16 +++--
>  lib/ring/rte_ring_generic_pvt.h |  77 ++++++++++++++++++++----
>  lib/ring/soring.c               |  24 +++++---
>  4 files changed, 171 insertions(+), 46 deletions(-)
>=20
> diff --git a/lib/ring/rte_ring_c11_pvt.h b/lib/ring/rte_ring_c11_pvt.h
> index 07b6efc416..5afc14dec9 100644
> --- a/lib/ring/rte_ring_c11_pvt.h
> +++ b/lib/ring/rte_ring_c11_pvt.h
> @@ -46,6 +46,7 @@ __rte_ring_update_tail(struct rte_ring_headtail *ht,
> uint32_t old_val,
>=20
>  /**
>   * @internal This is a helper function that moves the producer/consumer =
head
> + *    optimized for single threaded case
>   *
>   * @param d
>   *   A pointer to the headtail structure with head value to be moved
> @@ -54,8 +55,6 @@ __rte_ring_update_tail(struct rte_ring_headtail *ht,
> uint32_t old_val,
>   *   function only reads tail value from it
>   * @param capacity
>   *   Either ring capacity value (for producer), or zero (for consumer)
> - * @param is_st
> - *   Indicates whether multi-thread safe path is needed or not
>   * @param n
>   *   The number of elements we want to move head value on
>   * @param behavior
> @@ -72,14 +71,77 @@ __rte_ring_update_tail(struct rte_ring_headtail *ht,
> uint32_t old_val,
>   *   If behavior =3D=3D RTE_RING_QUEUE_FIXED, this will be 0 or n only
>   */
>  static __rte_always_inline unsigned int
> -__rte_ring_headtail_move_head(struct rte_ring_headtail *d,
> +__rte_ring_headtail_move_head_st(struct rte_ring_headtail *d,
>  		const struct rte_ring_headtail *s, uint32_t capacity,
> -		unsigned int is_st, unsigned int n,
> +		unsigned int n,
>  		enum rte_ring_queue_behavior behavior,
>  		uint32_t *old_head, uint32_t *new_head, uint32_t *entries)
>  {
>  	uint32_t stail;
> -	int success;
> +
> +	/* Single producer: only this thread writes d->head,
> +	 * so a relaxed load is sufficient.
> +	 */
> +	*old_head =3D rte_atomic_load_explicit(&d->head,
> rte_memory_order_relaxed);
> +
> +	/* Acquire pairs with the consumer's release-store of tail in
> __rte_ring_update_tail,
> +	 * ensuring the consumer's ring-element reads are complete before
> +	 * we observe the updated tail.
> +	 */
> +	stail =3D rte_atomic_load_explicit(&s->tail, rte_memory_order_acquire);
> +
> +	/* Unsigned subtraction is modulo 2^32, so entries is always in
> +	 * [0, capacity) even if old_head > stail.
> +	 */
> +	*entries =3D capacity + stail - *old_head;
> +
> +	/* check that we have enough room in ring */
> +	if (unlikely(n > *entries))
> +		n =3D (behavior =3D=3D RTE_RING_QUEUE_FIXED) ? 0 : *entries;
> +
> +	if (n > 0) {
> +		*new_head =3D *old_head + n;
> +		rte_atomic_store_explicit(&d->head, *new_head,
> rte_memory_order_relaxed);
> +	}
> +
> +	return n;
> +}
> +
> +/**
> + * @internal This is a helper function that moves the producer/consumer =
head
> + *    for use in multi-thread safe path
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
> +__rte_ring_headtail_move_head_mt(struct rte_ring_headtail *d,
> +		const struct rte_ring_headtail *s, uint32_t capacity,
> +		unsigned int n,
> +		enum rte_ring_queue_behavior behavior,
> +		uint32_t *old_head, uint32_t *new_head, uint32_t *entries)
> +{
> +	uint32_t stail;
> +	bool success;
>  	unsigned int max =3D n;
>=20
>  	/*
> @@ -120,25 +182,21 @@ __rte_ring_headtail_move_head(struct
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
> +		success =3D rte_atomic_compare_exchange_strong_explicit(
>  					&d->head, old_head, *new_head,
>  					rte_memory_order_release,
>  					rte_memory_order_acquire);
> -	} while (unlikely(success =3D=3D 0));
> +	} while (unlikely(!success));
>  	return n;
>  }
>=20
> diff --git a/lib/ring/rte_ring_elem_pvt.h b/lib/ring/rte_ring_elem_pvt.h
> index 6eafae121f..a0fdec9812 100644
> --- a/lib/ring/rte_ring_elem_pvt.h
> +++ b/lib/ring/rte_ring_elem_pvt.h
> @@ -341,8 +341,12 @@ __rte_ring_move_prod_head(struct rte_ring *r,
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
> @@ -374,8 +378,12 @@ __rte_ring_move_cons_head(struct rte_ring *r,
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
> diff --git a/lib/ring/rte_ring_generic_pvt.h b/lib/ring/rte_ring_generic_=
pvt.h
> index affd2d5ba7..c044b0824f 100644
> --- a/lib/ring/rte_ring_generic_pvt.h
> +++ b/lib/ring/rte_ring_generic_pvt.h
> @@ -42,6 +42,7 @@ __rte_ring_update_tail(struct rte_ring_headtail *ht,
> uint32_t old_val,
>=20
>  /**
>   * @internal This is a helper function that moves the producer/consumer =
head
> + *    for use in multi-thread safe path
>   *
>   * @param d
>   *   A pointer to the headtail structure with head value to be moved
> @@ -50,8 +51,6 @@ __rte_ring_update_tail(struct rte_ring_headtail *ht,
> uint32_t old_val,
>   *   function only reads tail value from it
>   * @param capacity
>   *   Either ring capacity value (for producer), or zero (for consumer)
> - * @param is_st
> - *   Indicates whether multi-thread safe path is needed or not
>   * @param n
>   *   The number of elements we want to move head value on
>   * @param behavior
> @@ -68,10 +67,9 @@ __rte_ring_update_tail(struct rte_ring_headtail *ht,
> uint32_t old_val,
>   *   If behavior =3D=3D RTE_RING_QUEUE_FIXED, this will be 0 or n only
>   */
>  static __rte_always_inline unsigned int
> -__rte_ring_headtail_move_head(struct rte_ring_headtail *d,
> +__rte_ring_headtail_move_head_mt(struct rte_ring_headtail *d,
>  		const struct rte_ring_headtail *s, uint32_t capacity,
> -		unsigned int is_st, unsigned int n,
> -		enum rte_ring_queue_behavior behavior,
> +		unsigned int n, enum rte_ring_queue_behavior behavior,
>  		uint32_t *old_head, uint32_t *new_head, uint32_t *entries)
>  {
>  	unsigned int max =3D n;
> @@ -105,15 +103,70 @@ __rte_ring_headtail_move_head(struct
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
> +		success =3D rte_atomic32_cmpset(
> +				(uint32_t *)(uintptr_t)&d->head,
> +				*old_head, *new_head);
>  	} while (unlikely(success =3D=3D 0));
>  	return n;
>  }
>=20
> +/**
> + * @internal This is a helper function that moves the producer/consumer =
head
> + *    optimized for single threaded case
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
> +		unsigned int n,
> +		enum rte_ring_queue_behavior behavior,
> +		uint32_t *old_head, uint32_t *new_head, uint32_t *entries)
> +{
> +	*old_head =3D d->head;
> +
> +	/* add rmb barrier to avoid load/load reorder in weak
> +	 * memory model. It is noop on x86
> +	 */
> +	rte_smp_rmb();
> +
> +	/*
> +	 *  The subtraction is done between two unsigned 32bits value
> +	 * (the result is always modulo 32 bits even if we have
> +	 * *old_head > s->tail). So 'entries' is always between 0
> +	 * and capacity (which is < size).
> +	 */
> +	*entries =3D (capacity + s->tail - *old_head);
> +
> +	/* check that we have enough room in ring */
> +	if (unlikely(n > *entries))
> +		n =3D (behavior =3D=3D RTE_RING_QUEUE_FIXED) ? 0 : *entries;
> +
> +	if (likely(n > 0)) {
> +		*new_head =3D *old_head + n;
> +		d->head =3D *new_head;
> +	}
> +	return n;
> +}
> +
>  #endif /* _RTE_RING_GENERIC_PVT_H_ */
> diff --git a/lib/ring/soring.c b/lib/ring/soring.c
> index e9c75619fe..22f9c60e9c 100644
> --- a/lib/ring/soring.c
> +++ b/lib/ring/soring.c
> @@ -135,9 +135,12 @@ __rte_soring_move_prod_head(struct rte_soring *r,
> uint32_t num,
>=20
>  	switch (st) {
>  	case RTE_RING_SYNC_ST:
> +		n =3D __rte_ring_headtail_move_head_st(&r->prod.ht, &r-
> >cons.ht,
> +			r->capacity, num, behavior, head, next, free);
> +		break;
>  	case RTE_RING_SYNC_MT:
> -		n =3D __rte_ring_headtail_move_head(&r->prod.ht, &r->cons.ht,
> -			r->capacity, st, num, behavior, head, next, free);
> +		n =3D __rte_ring_headtail_move_head_mt(&r->prod.ht, &r-
> >cons.ht,
> +			r->capacity, num, behavior, head, next, free);
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
> @@ -309,9 +316,8 @@ soring_enqueue_start(struct rte_soring *r, uint32_t n=
um,
>=20
>  	switch (st) {
>  	case RTE_RING_SYNC_ST:
> -		n =3D __rte_ring_headtail_move_head(&r->prod.ht, &r->cons.ht,
> -			r->capacity, RTE_RING_SYNC_ST, num, behavior,
> -			&head, &next, &free);
> +		n =3D __rte_ring_headtail_move_head_st(&r->prod.ht, &r-
> >cons.ht,
> +			r->capacity, num, behavior, &head, &next, &free);
>  		break;
>  	case RTE_RING_SYNC_MT_HTS:
>  		n =3D __rte_ring_hts_move_head(&r->prod.hts, &r->cons.ht,
> @@ -419,8 +425,8 @@ soring_dequeue_start(struct rte_soring *r, void *objs=
,
> void *meta,
>=20
>  	switch (st) {
>  	case RTE_RING_SYNC_ST:
> -		n =3D __rte_ring_headtail_move_head(&r->cons.ht, &r-
> >stage[ns].ht,
> -			0, RTE_RING_SYNC_ST, num, behavior, &head, &next,
> +		n =3D __rte_ring_headtail_move_head_st(&r->cons.ht, &r-
> >stage[ns].ht,
> +			0, num, behavior, &head, &next,
>  			&avail);
>  		break;
>  	case RTE_RING_SYNC_MT_HTS:
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Tested-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.53.0

