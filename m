Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E469C3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 19:30:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFDE140654;
	Thu, 27 Mar 2025 20:30:20 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id A8575402A7
 for <dev@dpdk.org>; Thu, 27 Mar 2025 20:30:19 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 64C3B21733;
 Thu, 27 Mar 2025 20:30:19 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] mempool: micro optimizations
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 27 Mar 2025 20:30:18 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FB7D@smartserver.smartshare.dk>
In-Reply-To: <Z-WHzgriLwWC_3Mu@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mempool: micro optimizations
Thread-Index: AdufO+79NeVnobzHRtGUckI3dsV5cwAD228A
References: <20250226155923.128859-1-mb@smartsharesystems.com>
 <Z-WHzgriLwWC_3Mu@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
	<dev@dpdk.org>
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
> Sent: Thursday, 27 March 2025 18.16
>=20
> On Wed, Feb 26, 2025 at 03:59:22PM +0000, Morten Br=F8rup wrote:
> > The comparisons lcore_id < RTE_MAX_LCORE and lcore_id !=3D =
LCORE_ID_ANY
> are
> > equivalent, but the latter compiles to fewer bytes of code space.
> > Similarly for lcore_id >=3D RTE_MAX_LCORE and lcore_id =3D=3D =
LCORE_ID_ANY.
> >
> > The rte_mempool_get_ops() function is also used in the fast path, so
> > RTE_VERIFY() was replaced by RTE_ASSERT().
> >
> > Compilers implicitly consider comparisons of variable =3D=3D 0 =
likely, so
> > unlikely() was added to the check for no mempool cache (mp-
> >cache_size =3D=3D
> > 0) in the rte_mempool_default_cache() function.
> >
> > The rte_mempool_do_generic_put() function for adding objects to a
> mempool
> > was refactored as follows:
> > - The comparison for the request itself being too big, which is
> considered
> >   unlikely, was moved down and out of the code path where the cache
> has
> >   sufficient room for the added objects, which is considered the =
most
> >   likely code path.
> > - Added __rte_assume() about the cache length, size and threshold,
> for
> >   compiler optimization when "n" is compile time constant.
> > - Added __rte_assume() about "ret" being zero, so other functions
> using
> >   the value returned by this function can be potentially optimized =
by
> the
> >   compiler; especially when it merges multiple sequential code paths
> of
> >   inlined code depending on the return value being either zero or
> >   negative.
> > - The refactored source code (with comments) made the separate
> comment
> >   describing the cache flush/add algorithm superfluous, so it was
> removed.
> >
> > A few more likely()/unlikely() were added.
>=20
> In general not a big fan of using likely/unlikely, but if they give a
> perf
> benefit, we should probably take them.

They can also be a hint to the code reviewer.

The benefit varies depending on the architecture's dynamic branch =
predictor. Some architectures don't consume a branch predictor entry if =
the code follows the expected path (according to static branch =
prediction); but I don't know if this is the case for architectures =
supported by DPDK, or ancient architectures only.

I like them enough to probably some day provide an EAL patch offering =
superlikely() and superunlikely() based on =
__builtin_expect_with_probability().
I have seen compilers emit different assembly output when using =
superlikely() vs. likely().
Moving away the super-unlikely code from the cache lines holding the =
common code path reduces the L1 instruction cache pressure.

In other words: Not even a perfect dynamic branch predictor can =
substitute all the benefits from using likely()/unlikely().

>=20
> Few more comments inline below.
>=20
> > A few comments were improved for readability.
> >
> > Some assertions, RTE_ASSERT(), were added. Most importantly to =
assert
> that
> > the return values of the mempool drivers' enqueue and dequeue
> operations
> > are API compliant, i.e. 0 (for success) or negative (for failure),
> and
> > never positive.
> >
> > Signed-off-by: Morten Br=F8rup <mb@smartsharesystems.com>
>=20
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>=20
> > ---
> >  lib/mempool/rte_mempool.h | 67 =
++++++++++++++++++++++---------------
> --
> >  1 file changed, 38 insertions(+), 29 deletions(-)
> >
> > diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
> > index c495cc012f..aedc100964 100644
> > --- a/lib/mempool/rte_mempool.h
> > +++ b/lib/mempool/rte_mempool.h
> > @@ -334,7 +334,7 @@ struct __rte_cache_aligned rte_mempool {
> >  #ifdef RTE_LIBRTE_MEMPOOL_STATS
> >  #define RTE_MEMPOOL_STAT_ADD(mp, name, n) do {
> \
> >  		unsigned int __lcore_id =3D rte_lcore_id();
> \
> > -		if (likely(__lcore_id < RTE_MAX_LCORE))
> \
> > +		if (likely(__lcore_id !=3D LCORE_ID_ANY))
> \
>=20
> Is this not opening up the possibility of runtime crashes, if
> __lcore_id is
> invalid? I see from the commit log, you say the change in comparison
> results in smaller code gen, but it does leave undefined behaviour =
when
> __lcore_id =3D=3D 500, for example.

In this case, __lcore_id comes from rte_lcore_id(), and if that is =
invalid, everything breaks everywhere.

>=20
> >  			(mp)->stats[__lcore_id].name +=3D (n);
> \
> >  		else
> \
> >  			rte_atomic_fetch_add_explicit(&((mp)-
> >stats[RTE_MAX_LCORE].name),  \
> > @@ -751,7 +751,7 @@ extern struct rte_mempool_ops_table
> rte_mempool_ops_table;
> >  static inline struct rte_mempool_ops *
> >  rte_mempool_get_ops(int ops_index)
> >  {
> > -	RTE_VERIFY((ops_index >=3D 0) && (ops_index <
> RTE_MEMPOOL_MAX_OPS_IDX));
> > +	RTE_ASSERT((ops_index >=3D 0) && (ops_index <
> RTE_MEMPOOL_MAX_OPS_IDX));
> >
> >  	return &rte_mempool_ops_table.ops[ops_index];
> >  }
> > @@ -791,7 +791,8 @@ rte_mempool_ops_dequeue_bulk(struct rte_mempool
> *mp,
> >  	rte_mempool_trace_ops_dequeue_bulk(mp, obj_table, n);
> >  	ops =3D rte_mempool_get_ops(mp->ops_index);
> >  	ret =3D ops->dequeue(mp, obj_table, n);
> > -	if (ret =3D=3D 0) {
> > +	RTE_ASSERT(ret <=3D 0);
> > +	if (likely(ret =3D=3D 0)) {
> >  		RTE_MEMPOOL_STAT_ADD(mp, get_common_pool_bulk, 1);
> >  		RTE_MEMPOOL_STAT_ADD(mp, get_common_pool_objs, n);
> >  	}
> > @@ -816,11 +817,14 @@ rte_mempool_ops_dequeue_contig_blocks(struct
> rte_mempool *mp,
> >  		void **first_obj_table, unsigned int n)
> >  {
> >  	struct rte_mempool_ops *ops;
> > +	int ret;
> >
> >  	ops =3D rte_mempool_get_ops(mp->ops_index);
> >  	RTE_ASSERT(ops->dequeue_contig_blocks !=3D NULL);
> >  	rte_mempool_trace_ops_dequeue_contig_blocks(mp, first_obj_table,
> n);
> > -	return ops->dequeue_contig_blocks(mp, first_obj_table, n);
> > +	ret =3D ops->dequeue_contig_blocks(mp, first_obj_table, n);
> > +	RTE_ASSERT(ret <=3D 0);
> > +	return ret;
> >  }
> >
> >  /**
> > @@ -848,6 +852,7 @@ rte_mempool_ops_enqueue_bulk(struct rte_mempool
> *mp, void * const *obj_table,
> >  	rte_mempool_trace_ops_enqueue_bulk(mp, obj_table, n);
> >  	ops =3D rte_mempool_get_ops(mp->ops_index);
> >  	ret =3D ops->enqueue(mp, obj_table, n);
> > +	RTE_ASSERT(ret <=3D 0);
> >  #ifdef RTE_LIBRTE_MEMPOOL_DEBUG
> >  	if (unlikely(ret < 0))
> >  		RTE_MEMPOOL_LOG(CRIT, "cannot enqueue %u objects to mempool
> %s",
> > @@ -1333,10 +1338,10 @@ rte_mempool_cache_free(struct
> rte_mempool_cache *cache);
> >  static __rte_always_inline struct rte_mempool_cache *
> >  rte_mempool_default_cache(struct rte_mempool *mp, unsigned =
lcore_id)
> >  {
> > -	if (mp->cache_size =3D=3D 0)
> > +	if (unlikely(mp->cache_size =3D=3D 0))
> >  		return NULL;
> >
> > -	if (lcore_id >=3D RTE_MAX_LCORE)
> > +	if (unlikely(lcore_id =3D=3D LCORE_ID_ANY))
> >  		return NULL;
> >
>=20
> Again, I'd be concerned about the resiliency of this. But I suppose
> having
> an invalid lcore id is just asking for problems and crashes later.

I was through the same line of thinking...
This introduces a risk.
However, DPDK is built on a design requirement that parameters passed to =
fast path APIs must be valid.
So I trust the API contract here.

And, as you say, if someone starts passing an invalid lcore_id around, =
lots of stuff will break anyway.

>=20
> >  	rte_mempool_trace_default_cache(mp, lcore_id,
> > @@ -1383,32 +1388,33 @@ rte_mempool_do_generic_put(struct =
rte_mempool
> *mp, void * const *obj_table,
> >  {

Thank you for the feedback and ack, Bruce.

