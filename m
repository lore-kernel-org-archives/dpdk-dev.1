Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C871CD5BC8
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 08:41:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 419D440280;
	Tue, 26 May 2026 10:41:47 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 0E90440279
 for <dev@dpdk.org>; Tue, 26 May 2026 10:41:46 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E497F20A2F;
 Tue, 26 May 2026 10:41:44 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v5] mempool: improve cache behaviour and performance
Date: Tue, 26 May 2026 10:41:44 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6589A@smartserver.smartshare.dk>
In-Reply-To: <ahCAPT1LEn_Rc7Pk@bricha3-mobl1.ger.corp.intel.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v5] mempool: improve cache behaviour and performance
Thread-Index: AdzqBboxmUL8wbsbQKSFYpT47OAWLAC1T1Sw
References: <20260408141315.904381-1-mb@smartsharesystems.com>
 <20260419095526.39526-1-mb@smartsharesystems.com>
 <ahCAPT1LEn_Rc7Pk@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Jingjing Wu" <jingjing.wu@intel.com>,
 "Praveen Shetty" <praveen.shetty@intel.com>,
 "Hemant Agrawal" <hemant.agrawal@nxp.com>,
 "Sachin Saxena" <sachin.saxena@oss.nxp.com>
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

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Friday, 22 May 2026 18.12
>=20
> On Sun, Apr 19, 2026 at 09:55:26AM +0000, Morten Br=F8rup wrote:
> > This patch refactors the mempool cache to eliminate some unexpected
> > behaviour and reduce the mempool cache miss rate.
> >
>=20
> Agree in principle with most of these changes. As we dicussed at the
> DPDK
> summit conference, only issue I really have is with the threshold
> limits
> here - allocating and freeing only half the cache at a time seems
> overly
> conservative. Thinking about use-cases:
>=20
> 1 for apps where alloc + free (generally Rx+Tx) is on the same =
core(s),
>   then we should run (almost) entirely out of cache.

I strongly disagree about any goal to run the cache low.
The primary goal is to minimize the cache miss (refill and replenish) =
rate.

> 2 for apps where we have alloc and free on different cores, then we
> have
>   some caches always being filled and others always being emptied

Agree.

>=20
> For case #1, we only need worry about the thresholds for the odd case
> where we have a burst that causes us to overflow our cache (and we
> can't increase our cache size to cope and avoid that).=20
> Otherwise the thresholds don't matter.

It seems like you assume the application only does something like this:
Rx -> Rewrite -> Tx

In that case, the per-lcore cache only needs capacity for one burst, =
yes.
With my patch, the cache can be rightsized by requesting a cache size of =
2 * burst size.
(Then the fill level will be either size/2 or empty, i.e. one burst or =
zero.
This also happens to meet your suggested goal about low fill level, =
which I disagree with.)

However, I don't think that is a realistic use case.
Many apps do something like this:

     |-> Rewrite ->|
Rx ->|             |-> Tx
     |-> Hold      |
         Release ->|

They often hold back packets before they are transmitted.
For a simple router, when the destination IP address is not in the =
neighbor table, packets to that IP address are queued until ARP/ND has =
been resolved, and then they are dequeued and transmitted.
Or apps performing shaping or pacing, where packets are held back in =
queues, and dequeued at the appropriate time.
For such apps, the waves are much bigger (than the simple =
Rx->Rewrite->Tx use case).

With a random enqueue/dequeue pattern, replenishing/draining the cache =
to size/2 minimizes the probability of reaching one of its edges (empty =
or full), triggering a "cache miss" (refill/replenish).

> However, for case #2, the thresholds are constantly involved as
> we
> always are going to backing store. In this case, we really want to =
have
> the
> allocs *always* fill the cache completely, and the frees completely
> empty
> the cache.

Agree.

>=20
> Because of this, while we want to avoid cases where we fill the cache
> completely only to have a further free causing it to be flushed,
> because of
> case #2 we cannot be overly conservative in how much we free/empty.
> Ideally, we want to fill to full less a single burst, and empty =
leaving
> only a single burst in the cache. Unfortunately, we don't know what
> those
> burst limits are, so we have to try and guess the best behaviour from
> everything else.

I agree about not wanting to be overly conservative.
But in the use cases I have described for #1, I don't think a target =
fill level of size/2 is overly conservative.

I also acknowledge that this patch doubles the mempool cache miss rate =
for #2.
E.g. with a cache size of 512 and burst size of 64, the per-burst miss =
rate will be 64 / (1/2 * 512) =3D 1/4, compared to 64 / 512 =3D 1/8 with =
a full replenish/drain algorithm.

In theory, we could make it build time configurable to optimize mempools =
for #2.
But mempools are also used for other objects than mbufs, so that would =
have unwanted side effects for non-mbuf mempools.

If we went for an algorithm targeting replenish/drain at 25 % from the =
edges, the per-burst miss rate for #2 would be: 64 / (3/4 * 512) =3D =
1/6.

How about addressing #2 in the release notes:
We describe that the cache refill/drain algorithm has been changed to =
only refill/drain to 50 % of the cache size, so pipelined applications =
performing Rx (mempool get) and Tx (mempool put) on separate cores =
should configure their mbuf pools with double the cache size of what =
they previously were to achieve similar performance.

>=20
> All that said, commits with specific suggestions inline.
>=20
> /Bruce
>=20
> <snip>
>=20
> > diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
> > index 2e54fc4466..432c43ab15 100644
> > --- a/lib/mempool/rte_mempool.h
> > +++ b/lib/mempool/rte_mempool.h
> > @@ -89,7 +89,7 @@ struct __rte_cache_aligned rte_mempool_debug_stats
> {
> >   */
> >  struct __rte_cache_aligned rte_mempool_cache {
> >  	uint32_t size;	      /**< Size of the cache */
> > -	uint32_t flushthresh; /**< Threshold before we flush excess
> elements */
> > +	uint32_t flushthresh; /**< Obsolete; for API/ABI compatibility
> purposes only */
> >  	uint32_t len;	      /**< Current cache count */
> >  #ifdef RTE_LIBRTE_MEMPOOL_STATS
> >  	uint32_t unused;
> > @@ -107,8 +107,10 @@ struct __rte_cache_aligned rte_mempool_cache {
> >  	/**
> >  	 * Cache objects
> >  	 *
> > -	 * Cache is allocated to this size to allow it to overflow in
> certain
> > -	 * cases to avoid needless emptying of cache.
> > +	 * Note:
> > +	 * Cache is allocated at double size for API/ABI compatibility
> purposes only.
> > +	 * When reducing its size at an API/ABI breaking release,
> > +	 * remember to add a cache guard after it.
> >  	 */
> >  	alignas(RTE_CACHE_LINE_SIZE) void
> *objs[RTE_MEMPOOL_CACHE_MAX_SIZE * 2];
> >  };
> > @@ -1046,12 +1048,17 @@ rte_mempool_free(struct rte_mempool *mp);
> >   * @param cache_size
> >   *   If cache_size is non-zero, the rte_mempool library will try to
> >   *   limit the accesses to the common lockless pool, by maintaining
> a
> > - *   per-lcore object cache. This argument must be lower or equal =
to
> > - *   RTE_MEMPOOL_CACHE_MAX_SIZE and n / 1.5.
> > + *   per-lcore object cache. This argument must be an even number,
> > + *   lower or equal to RTE_MEMPOOL_CACHE_MAX_SIZE and n.
> >   *   The access to the per-lcore table is of course
> >   *   faster than the multi-producer/consumer pool. The cache can be
> >   *   disabled if the cache_size argument is set to 0; it can be
> useful to
> >   *   avoid losing objects in cache.
> > + *   Note:
> > + *   Mempool put/get requests of more than cache_size / 2 objects
> may be
> > + *   partially or fully served directly by the multi-
> producer/consumer
> > + *   pool, to avoid the overhead of copying the objects twice
> (instead of
> > + *   once) when using the cache as a bounce buffer.
> >   * @param private_data_size
> >   *   The size of the private data appended after the mempool
> >   *   structure. This is useful for storing some private data after
> the
> > @@ -1390,24 +1397,32 @@ rte_mempool_do_generic_put(struct =
rte_mempool
> *mp, void * const *obj_table,
> >  	RTE_MEMPOOL_CACHE_STAT_ADD(cache, put_bulk, 1);
> >  	RTE_MEMPOOL_CACHE_STAT_ADD(cache, put_objs, n);
> >
> > -	__rte_assume(cache->flushthresh <=3D RTE_MEMPOOL_CACHE_MAX_SIZE *
> 2);
> > -	__rte_assume(cache->len <=3D RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
> > -	__rte_assume(cache->len <=3D cache->flushthresh);
> > -	if (likely(cache->len + n <=3D cache->flushthresh)) {
> > +	__rte_assume(cache->size <=3D RTE_MEMPOOL_CACHE_MAX_SIZE);
> > +	__rte_assume(cache->size / 2 <=3D RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
> > +	__rte_assume(cache->len <=3D RTE_MEMPOOL_CACHE_MAX_SIZE);
> > +	__rte_assume(cache->len <=3D cache->size);
> > +	if (likely(cache->len + n <=3D cache->size)) {
> >  		/* Sufficient room in the cache for the objects. */
> >  		cache_objs =3D &cache->objs[cache->len];
> >  		cache->len +=3D n;
> > -	} else if (n <=3D cache->flushthresh) {
> > +	} else if (n <=3D cache->size / 2) {
> >  		/*
> > -		 * The cache is big enough for the objects, but - as
> detected by
> > -		 * the comparison above - has insufficient room for them.
> > -		 * Flush the cache to make room for the objects.
> > +		 * The number of objects is within the cache bounce buffer
> limit,
> > +		 * but - as detected by the comparison above - the cache
> has
> > +		 * insufficient room for them.
> > +		 * Flush the cache to the backend to make room for the
> objects;
> > +		 * flush (size / 2) objects from the bottom of the cache,
> where
> > +		 * objects are less hot, and move down the remaining
> objects, which
> > +		 * are more hot, from the upper half of the cache.
> >  		 */
> > -		cache_objs =3D &cache->objs[0];
> > -		rte_mempool_ops_enqueue_bulk(mp, cache_objs, cache->len);
> > -		cache->len =3D n;
> > +		__rte_assume(cache->len > cache->size / 2);
> > +		rte_mempool_ops_enqueue_bulk(mp, &cache->objs[0], cache-
> >size / 2);
> > +		rte_memcpy(&cache->objs[0], &cache->objs[cache->size / 2],
> > +				sizeof(void *) * (cache->len - cache->size /
> 2));
> > +		cache_objs =3D &cache->objs[cache->len - cache->size / 2];
> > +		cache->len =3D cache->len - cache->size / 2 + n;
>=20
> The flushing of only half the cache I'm not so certain about. I agree
> that
> we want to not flush to empty, but I also think that we want to do =
more
> than a half-flush, especially since we do an enqueue to the cache
> immediately afterwards. Consider the case where we have a cache size =
of
> 128, and we do an enqueue of 32, with the cache currently full. In =
that
> case we only flush 64, reducing the cache to 64, but then immediately
> bringing it back up to 96.

I thought in depth about whether the flush/replenish sizes should =
consider the request size or not. (E.g. if I should replenish size/2 or =
size/2+request.)
I decided for not considering the request size, for two reasons:
a) It roughly doesn't matter, especially when considering a sequence of =
random get/put requests.
b) The size of the backend transactions become fixed, which has =
performance benefits: With my patch, they are always size/2, so if the =
cache size is 2^N, the backend transactions are 2^N and CPU cache =
aligned.

> For cases where we have pipelines with all
> alloc
> on one core and all free on another, this half-flush would be
> inefficient.
>=20
> Instead, I would look to have a lower target threshold post-flush, and
> I
> would suggest 25% - taking into account the newly freed buffers.

It's not good for #1.
I agree that it is better for #2. But I don't think #2 is the likely use =
case.

After our discussion at the summit, I did start working a patch =
targeting fill levels at 25% from the cache edges, but I don't think =
it's better; so I'd rather stick with a target fill level of 50%.

> For example:
>=20
> 	/* if n > our target of 1/4 full, flush everything,
> 	 * else flush so that we end up with 1/4 full after n added.
> 	 */
> 	flush_count =3D n > cache->size/4 ? cache->len :
> 			(cache->len + n) - cache->size/4;
>=20
>=20
> >  	} else {
> > -		/* The request itself is too big for the cache. */
> > +		/* The request itself is too big. */
> >  		goto driver_enqueue_stats_incremented;
>=20
> I think original comment is better. The request itself is not too big
> for
> the whole mempool, just for the cache.

Ack.

>=20
> >  	}
> >
> > @@ -1524,7 +1539,7 @@ rte_mempool_do_generic_get(struct rte_mempool
> *mp, void **obj_table,
> >  	/* The cache is a stack, so copy will be in reverse order. */
> >  	cache_objs =3D &cache->objs[cache->len];
> >
> > -	__rte_assume(cache->len <=3D RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
> > +	__rte_assume(cache->len <=3D RTE_MEMPOOL_CACHE_MAX_SIZE);
> >  	if (likely(n <=3D cache->len)) {
> >  		/* The entire request can be satisfied from the cache. */
> >  		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
> > @@ -1548,13 +1563,13 @@ rte_mempool_do_generic_get(struct =
rte_mempool
> *mp, void **obj_table,
> >  	for (index =3D 0; index < len; index++)
> >  		*obj_table++ =3D *--cache_objs;
> >
> > -	/* Dequeue below would overflow mem allocated for cache? */
> > -	if (unlikely(remaining > RTE_MEMPOOL_CACHE_MAX_SIZE))
> > +	/* Dequeue below would exceed the cache bounce buffer limit? */
> > +	__rte_assume(cache->size / 2 <=3D RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
> > +	if (unlikely(remaining > cache->size / 2))
> >  		goto driver_dequeue;
> >
> > -	/* Fill the cache from the backend; fetch size + remaining
> objects. */
> > -	ret =3D rte_mempool_ops_dequeue_bulk(mp, cache->objs,
> > -			cache->size + remaining);
> > +	/* Fill the cache from the backend; fetch (size / 2) objects. */
> > +	ret =3D rte_mempool_ops_dequeue_bulk(mp, cache->objs, cache->size =
/
> 2);
>=20
> Again, the cache->size / 2 doesn't seem right here. We at most half-
> fill
> the cache and then take some objects from that, meaning that have just
> done
> a re-fill of cache but end the function with it less than half full.
> Since
> we take from this value, I'd suggest just filling the cache =
completely.

The issues at the edges of the cache are symmetrical.
If we replenish the cache to full, and the next transaction is a put, =
the cache needs to be drained.
That's why I replenish to size/2.

>=20
> >  	if (unlikely(ret < 0)) {
> >  		/*
> >  		 * We are buffer constrained, and not able to fetch all
> that.
> > @@ -1568,10 +1583,11 @@ rte_mempool_do_generic_get(struct =
rte_mempool
> *mp, void **obj_table,
> >  	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
> >  	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
> >
> > -	__rte_assume(cache->size <=3D RTE_MEMPOOL_CACHE_MAX_SIZE);
> > -	__rte_assume(remaining <=3D RTE_MEMPOOL_CACHE_MAX_SIZE);
> > -	cache_objs =3D &cache->objs[cache->size + remaining];
> > -	cache->len =3D cache->size;
> > +	__rte_assume(cache->size / 2 <=3D RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
> > +	__rte_assume(remaining <=3D RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
> > +	__rte_assume(remaining <=3D cache->size / 2);
> > +	cache_objs =3D &cache->objs[cache->size / 2];
> > +	cache->len =3D cache->size / 2 - remaining;
> >  	for (index =3D 0; index < remaining; index++)
> >  		*obj_table++ =3D *--cache_objs;
> >
> > --
> > 2.43.0
> >
