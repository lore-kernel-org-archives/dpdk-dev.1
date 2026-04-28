Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ABAFF886D
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Apr 2026 12:56:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FD4E40395;
	Tue, 28 Apr 2026 14:56:20 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 46601402A3
 for <dev@dpdk.org>; Tue, 28 Apr 2026 14:56:19 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 0D12320778;
 Tue, 28 Apr 2026 14:56:19 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v4 2/2] ring: introduce peek API for soring
Date: Tue, 28 Apr 2026 14:56:15 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65828@smartserver.smartshare.dk>
In-Reply-To: <20260423091625.123642-3-konstantin.ananyev@huawei.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v4 2/2] ring: introduce peek API for soring
Thread-Index: AdzTAfXv8fNKWBOORJCFs9FMAbTFewEBVqEQ
References: <20260417212358.212692-1-konstantin.ananyev@huawei.com>
 <20260423091625.123642-1-konstantin.ananyev@huawei.com>
 <20260423091625.123642-3-konstantin.ananyev@huawei.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
	<dev@dpdk.org>
Cc: <wathsala.vithanage@arm.com>
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

> From: Konstantin Ananyev [mailto:konstantin.ananyev@huawei.com]
> Sent: Thursday, 23 April 2026 11.16
>=20
> Follow the same pattern as conventional rte_ring and introduce peek =
API
> for soring too.
> Basically it provides similar functionality and similar opportunities
> for the user, while similar constraints remain - only rings with
> certain sync types are supported:
> 1) Single Producer/Single Consumer (RTE_RING_SYNC_ST)
> 2) Serialized Producer/Serialized Consumer (RTE_RING_SYNC_MT_HTS).
>=20
> Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> ---

Some comments inline below,
mainly regarding function descriptions,
and using RTE_ASSERT(0) for invalid SORING sync types.

With the function descriptions fixed,
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>


> diff --git a/doc/guides/rel_notes/release_26_07.rst
> b/doc/guides/rel_notes/release_26_07.rst
> index f012d47a4b..313f00f6df 100644
> --- a/doc/guides/rel_notes/release_26_07.rst
> +++ b/doc/guides/rel_notes/release_26_07.rst
> @@ -63,6 +63,14 @@ New Features
>      ``rte_eal_init`` and the application is responsible for probing
> each device,
>    * ``--auto-probing`` enables the initial bus probing, which is the
> current default behavior.
>=20
> +* **Added peek style API for ``rte_soring``.**
> +
> +  For sorings with producer/consumer in ``RTE_RING_SYNC_ST``,
> +  ``RTE_RING_SYNC_MT_HTS`` mode, provide the ability to split
> enqueue/dequeue
> +  operation into two phases (enqueue/dequeue start and =
enqueue/dequeue
> finish).
> +  This allows the user to inspect objects in the ring without =
removing
> them
> +  (aka MT safe peek).
> +
>=20
>  Removed Items
>  -------------
> diff --git a/lib/ring/rte_soring.h b/lib/ring/rte_soring.h
> index 95c3cc4080..5d214f85a0 100644
> --- a/lib/ring/rte_soring.h
> +++ b/lib/ring/rte_soring.h
> @@ -607,6 +607,273 @@ void
>  rte_soring_releasx(struct rte_soring *r, const void *objs,
>  	const void *meta, uint32_t stage, uint32_t n, uint32_t ftoken);
>=20
> +/**
> + * SORING Peek API
> + * Same as with rte_ring, for some sync modes it is possible to split
> + * public enqueue/dequeue API into two phases:
> + * - enqueue/dequeue start
> + * - enqueue/dequeue finish
> + * That allows user to inspect objects in the soring without removing
> them
> + * from it (aka MT safe peek).
> + * Note that right now this new API is available only for two sync
> modes:
> + * 1) Single Producer/Single Consumer (RTE_RING_SYNC_ST)
> + * 2) Serialized Producer/Serialized Consumer (RTE_RING_SYNC_MT_HTS).
> + * It is a user responsibility to create/init soring with appropriate
> sync
> + * modes selected for enqueue/dequeue.
> + * For more information, please refer to corresponding rte_ring peek
> API.
> + */
> +
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * Start to enqueue exact number of objects on the soring.
> + * Note that no actual objects are put in the queue by this function,
> + * it just reserves for user such ability.
> + * User has to call appropriate enqueue_elem_finish() to copy objects
> into the

Copy-paste error:
User has to call appropriate enqueue_elem_finish() to copy objects->
User has to call appropriate rte_soring_enqueue_finish() or =
rte_soring_enqueux_finish() to copy objects

> + * queue and complete given enqueue operation.
> + *
> + * @param r
> + *   A pointer to the soring structure.
> + * @param n
> + *   The number of objects to add in the soring.
> + * @param free_space
> + *   if non-NULL, returns the amount of space in the soring after the
> + *   enqueue operation has finished.
> + * @return
> + *   - Actual number of objects enqueued, either 0 or n.

They are not yet enqueued on return, suggest (as in rte_ring_peek.h):
The number of objects that can be enqueued, either 0 or n.

Also, it's not a list of various return values, so just: "The number..." =
instead of "- The number...".

> + */
> +__rte_experimental
> +uint32_t
> +rte_soring_enqueue_bulk_start(struct rte_soring *r, uint32_t n,
> +	uint32_t *free_space);
> +
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * Start to enqueue several objects (up to 'n') on the soring.
> + * Note that no actual objects are put in the queue by this function,
> + * it just reserves for user such ability.
> + * User has to call appropriate enqueue_elem_finish() to copy objects

Copy-paste error:
User has to call appropriate enqueue_elem_finish() to copy objects->
User has to call appropriate rte_soring_enqueue_finish() or =
rte_soring_enqueux_finish() to copy objects

> into the
> + * queue and complete given enqueue operation.
> + *
> + * @param r
> + *   A pointer to the soring structure.
> + * @param n
> + *   The number of objects to add in the soring.
> + * @param free_space
> + *   if non-NULL, returns the amount of space in the soring after the
> + *   enqueue operation has finished.
> + * @return
> + *   - Actual number of objects enqueued.

They are not yet enqueued on return, suggest (as in rte_ring_peek.h):
Actual number of objects that can be enqueued.

Also, it's not a list of various return values, so just: "Actual ..." =
instead of "- Actual...".

> + */
> +__rte_experimental
> +uint32_t
> +rte_soring_enqueue_burst_start(struct rte_soring *r, uint32_t n,
> +	uint32_t *free_space);
> +
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * Complete to enqueue several objects on the soring.
> + * Note that number of objects to enqueue should not exceed previous
> + * enqueue_start return value.
> + *
> + * @param r
> + *   A pointer to the soring structure.
> + * @param objs
> + *   A pointer to an array of objects to enqueue.
> + *   Size of objects to enqueue must be the same value as 'elem_size'
> parameter
> + *   used while creating the soring. Otherwise the results are
> undefined.
> + * @param n
> + *   The number of objects to add in the soring from the 'objs'.
> + */
> +__rte_experimental
> +void
> +rte_soring_enqueue_finish(struct rte_soring *r, const void *objs,
> uint32_t n);
> +
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * Complete to enqueue several objects plus metadata on the soring.
> + * Note that number of objects to enqueue should not exceed previous
> + * enqueue_start return value.
> + *
> + * @param r
> + *   A pointer to the soring structure.
> + * @param objs
> + *   A pointer to an array of objects to enqueue.
> + *   Size of objects to enqueue must be the same value as 'elem_size'
> parameter
> + *   used while creating the soring. Otherwise the results are
> undefined.
> + * @param meta
> + *   A pointer to an array of metadata values for each object to
> enqueue.
> + *   Note that if user not using object metadata values, then this
> parameter
> + *   can be NULL.
> + *   Size of elements in this array must be the same value as
> 'meta_size'
> + *   parameter used while creating the soring. If user created the
> soring with
> + *   'meta_size' value equals zero, then 'meta' parameter should be
> NULL.
> + *   Otherwise the results are undefined.
> + * @param n
> + *   The number of objects to add in the soring from the 'objs'.
> + */
> +__rte_experimental
> +void
> +rte_soring_enqueux_finish(struct rte_soring *r, const void *objs,
> +	const void *meta, uint32_t n);
> +
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * Start to dequeue several objects from the soring.
> + * Dequeues exactly requested number of objects or none.
> + * Note that user has to call appropriate dequeue_finish()
> + * to complete given dequeue operation and actually remove objects
> from
> + * the soring.
> + *
> + * @param r
> + *   A pointer to the soring structure.
> + * @param objs
> + *   A pointer to an array of objects to dequeue.
> + *   Size of objects to dequeue must be the same value as 'elem_size'
> parameter
> + *   used while creating the soring. Otherwise the results are
> undefined.
> + * @param num
> + *   The number of objects to dequeue from the soring into the objs.
> + * @param available
> + *   If non-NULL, returns the number of remaining soring entries =
after
> the
> + *   dequeue has finished.
> + * @return
> + *   - Actual number of objects dequeued, either 0 or 'num'.

It's not a list of various return values, so just: "Actual ..." instead =
of "- Actual...".

> + */
> +__rte_experimental
> +uint32_t
> +rte_soring_dequeue_bulk_start(struct rte_soring *r, void *objs,
> uint32_t num,
> +	uint32_t *available);
> +
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * Start to dequeue several objects plus metadata from the soring.
> + * Dequeues exactly requested number of objects or none.
> + * Note that user has to call appropriate dequeue_finish()
> + * to complete given dequeue operation and actually remove objects
> from
> + * the soring.
> + *
> + * @param r
> + *   A pointer to the soring structure.
> + * @param objs
> + *   A pointer to an array of objects to dequeue.
> + *   Size of objects to dequeue must be the same value as 'elem_size'
> parameter
> + *   used while creating the soring. Otherwise the results are
> undefined.
> + * @param meta
> + *   A pointer to array of metadata values for each object to =
dequeue.
> + *   Note that if user not using object metadata values, then this
> parameter
> + *   can be NULL.
> + *   Size of elements in this array must be the same value as
> 'meta_size'
> + *   parameter used while creating the soring. If user created the
> soring with
> + *   'meta_size' value equals zero, then 'meta' parameter should be
> NULL.
> + *   Otherwise the results are undefined.
> + * @param num
> + *   The number of objects to dequeue from the soring into the objs.
> + * @param available
> + *   If non-NULL, returns the number of remaining soring entries =
after
> the
> + *   dequeue has finished.
> + * @return
> + *   - Actual number of objects dequeued, either 0 or 'num'.

It's not a list of various return values, so just: "Actual ..." instead =
of "- Actual...".

> + */
> +__rte_experimental
> +uint32_t
> +rte_soring_dequeux_bulk_start(struct rte_soring *r, void *objs, void
> *meta,
> +	uint32_t num, uint32_t *available);
> +
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * Start to dequeue several objects from the soring.
> + * Dequeues up to requested number of objects.
> + * Note that user has to call appropriate dequeue_finish()
> + * to complete given dequeue operation and actually remove objects
> from
> + * the soring.
> + *
> + * @param r
> + *   A pointer to the soring structure.
> + * @param objs
> + *   A pointer to an array of objects to dequeue.
> + *   Size of objects to dequeue must be the same value as 'elem_size'
> parameter
> + *   used while creating the soring. Otherwise the results are
> undefined.
> + * @param num
> + *   The number of objects to dequeue from the soring into the objs.
> + * @param available
> + *   If non-NULL, returns the number of remaining soring entries =
after
> the
> + *   dequeue has finished.
> + * @return
> + *   - Actual number of objects dequeued.

It's not a list of various return values, so just: "Actual ..." instead =
of "- Actual...".

> + */
> +__rte_experimental
> +uint32_t
> +rte_soring_dequeue_burst_start(struct rte_soring *r, void *objs,
> uint32_t num,
> +	uint32_t *available);
> +
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * Start to dequeue several objects plus metadata from the soring.
> + * Dequeues up to requested number of objects.
> + * Note that user has to call appropriate dequeue_finish()
> + * to complete given dequeue operation and actually remove objects
> from
> + * the soring.
> + *
> + * @param r
> + *   A pointer to the soring structure.
> + * @param objs
> + *   A pointer to an array of objects to dequeue.
> + *   Size of objects to dequeue must be the same value as 'elem_size'
> parameter
> + *   used while creating the soring. Otherwise the results are
> undefined.
> + * @param meta
> + *   A pointer to array of metadata values for each object to =
dequeue.
> + *   Note that if user not using object metadata values, then this
> parameter
> + *   can be NULL.
> + *   Size of elements in this array must be the same value as
> 'meta_size'
> + *   parameter used while creating the soring. If user created the
> soring with
> + *   'meta_size' value equals zero, then 'meta' parameter should be
> NULL.
> + *   Otherwise the results are undefined.
> + * @param num
> + *   The number of objects to dequeue from the soring into the objs.
> + * @param available
> + *   If non-NULL, returns the number of remaining soring entries =
after
> the
> + *   dequeue has finished.
> + * @return
> + *   - Actual number of objects dequeued.

It's not a list of various return values, so just: "Actual ..." instead =
of "- Actual...".

> + */
> +__rte_experimental
> +uint32_t
> +rte_soring_dequeux_burst_start(struct rte_soring *r, void *objs, void
> *meta,
> +	uint32_t num, uint32_t *available);
> +
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * Complete to dequeue several objects from the soring.
> + * Note that number of objects to dequeue should not exceed previous
> + * dequeue_start return value.
> + *
> + * @param r
> + *   A pointer to the soring structure.
> + * @param num
> + *   The number of objects to remove from the soring.
> + */
> +__rte_experimental
> +void
> +rte_soring_dequeue_finish(struct rte_soring *r, uint32_t num);
> +
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/lib/ring/soring.c b/lib/ring/soring.c
> index 4bc2321fb5..37f2db2557 100644
> --- a/lib/ring/soring.c
> +++ b/lib/ring/soring.c
> @@ -249,6 +249,28 @@ __rte_soring_stage_move_head(struct
> soring_stage_headtail *d,
>  	return n;
>  }
>=20
> +static inline void
> +__enqueue_elems(struct rte_soring *r, const void *objs, const void
> *meta,
> +	uint32_t head, uint32_t n)
> +{
> +	__rte_ring_do_enqueue_elems(&r[1], objs, r->size, head & r->mask,
> +		r->esize, n);
> +	if (meta !=3D NULL)
> +		__rte_ring_do_enqueue_elems(r->meta, meta, r->size,
> +			head & r->mask, r->msize, n);
> +}
> +
> +static inline void
> +__dequeue_elems(const struct rte_soring *r, void *objs,  void *meta,
> +	uint32_t head, uint32_t n)
> +{
> +	__rte_ring_do_dequeue_elems(objs, &r[1], r->size, head & r->mask,
> +			r->esize, n);
> +	if (meta !=3D NULL)
> +		__rte_ring_do_dequeue_elems(meta, r->meta, r->size,
> +			head & r->mask, r->msize, n);
> +}
> +

Good consolidation with the two functions above.

>  static inline uint32_t
>  soring_enqueue(struct rte_soring *r, const void *objs,
>  	const void *meta, uint32_t n, enum rte_ring_queue_behavior
> behavior,
> @@ -265,11 +287,7 @@ soring_enqueue(struct rte_soring *r, const void
> *objs,
>  	n =3D __rte_soring_move_prod_head(r, n, behavior, st,
>  			&prod_head, &prod_next, &nb_free);
>  	if (n !=3D 0) {
> -		__rte_ring_do_enqueue_elems(&r[1], objs, r->size,
> -			prod_head & r->mask, r->esize, n);
> -		if (meta !=3D NULL)
> -			__rte_ring_do_enqueue_elems(r->meta, meta, r->size,
> -				prod_head & r->mask, r->msize, n);
> +		__enqueue_elems(r, objs, meta, prod_head, n);
>  		__rte_soring_update_tail(&r->prod, st, prod_head,
> prod_next, 1);
>  	}
>=20
> @@ -278,6 +296,70 @@ soring_enqueue(struct rte_soring *r, const void
> *objs,
>  	return n;
>  }
>=20
> +static inline uint32_t
> +soring_enqueue_start(struct rte_soring *r, uint32_t num,
> +	enum rte_ring_queue_behavior behavior, uint32_t *free_space)
> +{
> +	enum rte_ring_sync_type st;
> +	uint32_t free, head, n, next;
> +
> +	RTE_ASSERT(r !=3D NULL && r->nb_stage > 0);
> +
> +	st =3D r->prod.ht.sync_type;
> +
> +	switch (st) {
> +	case RTE_RING_SYNC_ST:
> +		n =3D __rte_ring_headtail_move_head(&r->prod.ht, &r->cons.ht,
> +			r->capacity, RTE_RING_SYNC_ST, num, behavior,
> +			&head, &next, &free);
> +		break;
> +	case RTE_RING_SYNC_MT_HTS:
> +		n =3D __rte_ring_hts_move_head(&r->prod.hts, &r->cons.ht,
> +			r->capacity, num, behavior, &head, &free);
> +		break;
> +	default:
> +		/* unsupported mode, shouldn't be here */
> +		RTE_ASSERT(0);

Is RTE_ASSERT(0) the right choice for failure here?
Unless built with assertions enabled, RTE_ASSERT(0) does nothing, and =
this function also does nothing but returns 0 as free_space, which may =
not be correct.

Maybe rte_panic() instead.
It's an application bug to call this with the wrong SORING sync type.
We cannot handle it gracefully, so better to fail early.
Just an idea; I have no strong preference.

> +		free =3D 0;
> +		n =3D 0;
> +	}
> +
> +	if (free_space !=3D NULL)
> +		*free_space =3D free - n;
> +	return n;
> +}
> +
> +static inline void
> +soring_enqueue_finish(struct rte_soring *r, const void *objs, const
> void *meta,
> +	uint32_t num)
> +{
> +	enum rte_ring_sync_type st;
> +	uint32_t n, tail;
> +
> +	RTE_ASSERT(r !=3D NULL && r->nb_stage > 0);
> +	RTE_ASSERT(meta =3D=3D NULL || r->meta !=3D NULL);
> +
> +	st =3D r->prod.ht.sync_type;
> +
> +	switch (st) {
> +	case RTE_RING_SYNC_ST:
> +		n =3D __rte_ring_st_get_tail(&r->prod.ht, &tail, num);
> +		if (n !=3D 0)
> +			__enqueue_elems(r, objs, meta, tail, n);
> +		__rte_ring_st_set_head_tail(&r->prod.ht, tail, n, 1);
> +		break;
> +	case RTE_RING_SYNC_MT_HTS:
> +		n =3D __rte_ring_hts_get_tail(&r->prod.hts, &tail, num);
> +		if (n !=3D 0)
> +			__enqueue_elems(r, objs, meta, tail, n);
> +		__rte_ring_hts_set_head_tail(&r->prod.hts, tail, n, 1);
> +		break;
> +	default:
> +		/* unsupported mode, shouldn't be here */
> +		RTE_ASSERT(0);

Is RTE_ASSERT(0) the right choice for failure here?

> +	}
> +}
> +
>  static inline uint32_t
>  soring_dequeue(struct rte_soring *r, void *objs, void *meta,
>  	uint32_t num, enum rte_ring_queue_behavior behavior,
> @@ -312,11 +394,7 @@ soring_dequeue(struct rte_soring *r, void *objs,
> void *meta,
>=20
>  	/* we have some elems to consume */
>  	if (n !=3D 0) {
> -		__rte_ring_do_dequeue_elems(objs, &r[1], r->size,
> -			cons_head & r->mask, r->esize, n);
> -		if (meta !=3D NULL)
> -			__rte_ring_do_dequeue_elems(meta, r->meta, r->size,
> -				cons_head & r->mask, r->msize, n);
> +		__dequeue_elems(r, objs, meta, cons_head, n);
>  		__rte_soring_update_tail(&r->cons, st, cons_head,
> cons_next, 0);
>  	}
>=20
> @@ -325,6 +403,69 @@ soring_dequeue(struct rte_soring *r, void *objs,
> void *meta,
>  	return n;
>  }
>=20
> +static inline uint32_t
> +soring_dequeue_start(struct rte_soring *r, void *objs, void *meta,
> +	uint32_t num, enum rte_ring_queue_behavior behavior,
> +	uint32_t *available)
> +{
> +	enum rte_ring_sync_type st;
> +	uint32_t avail, head, next, n, ns;
> +
> +	RTE_ASSERT(r !=3D NULL && r->nb_stage > 0);
> +	RTE_ASSERT(meta =3D=3D NULL || r->meta !=3D NULL);
> +
> +	ns =3D r->nb_stage - 1;
> +	st =3D r->cons.ht.sync_type;
> +
> +	switch (st) {
> +	case RTE_RING_SYNC_ST:
> +		n =3D __rte_ring_headtail_move_head(&r->cons.ht, &r-
> >stage[ns].ht,
> +			0, RTE_RING_SYNC_ST, num, behavior, &head, &next,
> +			&avail);
> +		break;
> +	case RTE_RING_SYNC_MT_HTS:
> +		n =3D __rte_ring_hts_move_head(&r->cons.hts, &r-
> >stage[ns].ht,
> +			0, num, behavior, &head, &avail);
> +		break;
> +	default:
> +		/* unsupported mode, shouldn't be here */
> +		RTE_ASSERT(0);

Is RTE_ASSERT(0) the right choice for failure here?

> +		avail =3D 0;
> +		n =3D 0;
> +	}
> +
> +	/* we have some elems to consume */
> +	if (n !=3D 0)
> +		__dequeue_elems(r, objs, meta, head, n);
> +
> +	if (available !=3D NULL)
> +		*available =3D avail - n;
> +	return n;
> +}
> +
> +
> +static inline void
> +soring_dequeue_finish(struct rte_soring *r, uint32_t num)
> +{
> +	uint32_t n, tail;
> +
> +	RTE_ASSERT(r !=3D NULL && r->nb_stage > 0);
> +
> +	switch (r->cons.ht.sync_type) {
> +	case RTE_RING_SYNC_ST:
> +		n =3D __rte_ring_st_get_tail(&r->cons.ht, &tail, num);
> +		__rte_ring_st_set_head_tail(&r->cons.ht, tail, n, 0);
> +		break;
> +	case RTE_RING_SYNC_MT_HTS:
> +		n =3D __rte_ring_hts_get_tail(&r->cons.hts, &tail, num);
> +		__rte_ring_hts_set_head_tail(&r->cons.hts, tail, n, 0);
> +		break;
> +	default:
> +		/* unsupported mode, shouldn't be here */
> +		RTE_ASSERT(0);

Is RTE_ASSERT(0) the right choice for failure here?

> +	}
> +}
> +
>  /*
>   * Verify internal SORING state.
>   * WARNING: if expected value is not equal to actual one, it means
> that for
> @@ -629,3 +770,81 @@ rte_soring_free_count(const struct rte_soring *r)
>  {
>  	return r->capacity - rte_soring_count(r);
>  }
> +
> +/*
> + * SORING public peek API
> + */
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_enqueue_bulk_start, 26.07)
> +uint32_t
> +rte_soring_enqueue_bulk_start(struct rte_soring *r, uint32_t n,
> +	uint32_t *free_space)
> +{
> +	return soring_enqueue_start(r, n, RTE_RING_QUEUE_FIXED,
> free_space);
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_enqueue_burst_start, 26.07)
> +uint32_t
> +rte_soring_enqueue_burst_start(struct rte_soring *r, uint32_t n,
> +	uint32_t *free_space)
> +{
> +	return soring_enqueue_start(r, n, RTE_RING_QUEUE_VARIABLE,
> free_space);
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_enqueue_finish, 26.07)
> +void
> +rte_soring_enqueue_finish(struct rte_soring *r, const void *objs,
> uint32_t n)
> +{
> +	soring_enqueue_finish(r, objs, NULL, n);
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_enqueux_finish, 26.07)
> +void
> +rte_soring_enqueux_finish(struct rte_soring *r, const void *objs,
> +	const void *meta, uint32_t n)
> +{
> +	soring_enqueue_finish(r, objs, meta, n);
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dequeue_bulk_start, 26.07)
> +uint32_t
> +rte_soring_dequeue_bulk_start(struct rte_soring *r, void *objs,
> uint32_t num,
> +	uint32_t *available)
> +{
> +	return soring_dequeue_start(r, objs, NULL, num,
> RTE_RING_QUEUE_FIXED,
> +		available);
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dequeux_bulk_start, 26.07)
> +uint32_t
> +rte_soring_dequeux_bulk_start(struct rte_soring *r, void *objs, void
> *meta,
> +	uint32_t num, uint32_t *available)
> +{
> +	return soring_dequeue_start(r, objs, meta, num,
> RTE_RING_QUEUE_FIXED,
> +		available);
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dequeue_burst_start, 26.07)
> +uint32_t
> +rte_soring_dequeue_burst_start(struct rte_soring *r, void *objs,
> uint32_t num,
> +	uint32_t *available)
> +{
> +	return soring_dequeue_start(r, objs, NULL, num,
> RTE_RING_QUEUE_VARIABLE,
> +		available);
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dequeux_burst_start, 26.07)
> +uint32_t
> +rte_soring_dequeux_burst_start(struct rte_soring *r, void *objs, void
> *meta,
> +	uint32_t num, uint32_t *available)
> +{
> +	return soring_dequeue_start(r, objs, meta, num,
> RTE_RING_QUEUE_VARIABLE,
> +		available);
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dequeue_finish, 26.07)
> +void
> +rte_soring_dequeue_finish(struct rte_soring *r, uint32_t n)
> +{
> +	soring_dequeue_finish(r, n);
> +}
> --
> 2.51.0

