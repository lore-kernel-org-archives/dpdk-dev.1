Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CE0CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 09:22:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D456840285;
	Wed, 27 May 2026 11:22:04 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id B93DC4026C
 for <dev@dpdk.org>; Wed, 27 May 2026 11:22:03 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 932EA208E7;
 Wed, 27 May 2026 11:22:03 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v5] mempool: improve cache behaviour and performance
Date: Wed, 27 May 2026 11:22:01 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F658A0@smartserver.smartshare.dk>
In-Reply-To: <ahavyHwTzyPPDkQ4@bricha3-mobl1.ger.corp.intel.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v5] mempool: improve cache behaviour and performance
Thread-Index: AdzttZUDUlh7r5ICRgm251MJ41wYYQAAxi3g
References: <20260408141315.904381-1-mb@smartsharesystems.com>
 <20260419095526.39526-1-mb@smartsharesystems.com>
 <ahCAPT1LEn_Rc7Pk@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6589A@smartserver.smartshare.dk>
 <ahVqYpVXMn59Tl2d@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6589D@smartserver.smartshare.dk>
 <98CBD80474FA8B44BF855DF32C47DC35F6589F@smartserver.smartshare.dk>
 <ahavyHwTzyPPDkQ4@bricha3-mobl1.ger.corp.intel.com>
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
> Sent: Wednesday, 27 May 2026 10.48
>=20
> On Tue, May 26, 2026 at 07:45:24PM +0200, Morten Br=F8rup wrote:
> > > From: Morten Br=F8rup [mailto:mb@smartsharesystems.com]
> > > Sent: Tuesday, 26 May 2026 12.37
> > >
> > > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > > Sent: Tuesday, 26 May 2026 11.40
> > > >
> >
> > [...]
> >
> > > > [In all this, I am making the assumption that burst size is well
> less
> > > > than
> > > > cache size. Also, similar logic would be applicable for the
> inverse
> > > > scenario, e.g. flush to empty (and fill burst) and fill to 75%]
> > >
> > > I'm not so sure about this assumption.
> > > With a cache size of 512 and a bursts of 64, the cache only holds =
8
> > > bursts.
> > > 50% is 4 bursts, and 25% is only 2 bursts.
> > >
> > > Using a replenish/drain level in the middle requires 5 bursts in
> either
> > > direction to pass the edge (and trigger replenish/flush).
> > > Using a replenish/drain level 25% from the edge requires only 3
> bursts
> > > in the wrong direction to pass the edge (and trigger
> replenish/flush).
> > > Much higher probability with random get/put.
> > >
> > > >
> > > > Now, all said, I tend to agree that we want to leave space for a
> > > decent
> > > > size burst after a fill. That is why I think that filling to 75%
> is
> > > > reasonable. After an alloc that triggers a fill, I don't want =
the
> > > cache
> > > > less than 50% full, but not completely full so there is room for
> a
> > > free
> > > > without a flush, and similarly for a free that triggers a flush,
> the
> > > > cache
> > > > should not be empty, but also should not be more than half full.
> > > >
> > > > One suggestion - we could always add a simple tunable that
> specifies
> > > > the
> > > > margin, or reserved entries for alloc and free. We can then =
guide
> in
> > > > the
> > > > docs that the value should be e.g. "zero for apps where alloc =
and
> > > free
> > > > take
> > > > place on different cores. 20%-50% of cache is recommended where
> alloc
> > > > and
> > > > free take place on the same core"
> > >
> > > Yes, a simple tunable is a really good idea.
> > >
> > > At this point, I think we should optimize for use case #1, and go
> for
> > > the 50% fill level.
> > > Then we can add a tunable to optimize for use case #2 later. I =
will
> try
> > > to come up with a draft for such a follow-up patch within the next
> few
> > > days.
> >
> > Adding a tunable is not so simple...
> > The choice of mempool cache algorithm (drain/replenish to 50% vs.
> drain/replenish completely) should be passed via the "flags" parameter
> in rte_mempool_create(), but rte_pktmbuf_pool_create() is missing the
> "flags" parameter.
> > We can add it at the next ABI breaking release.
> > WDYT?
> >
> I don't want this just a binary flag with two settings, I think it
> should be an actual numeric value.

If it was plain and simple to support a numeric value, I'd do it.
But the two algorithms differ too much.
If needed, the flag can be used as an enum to support more algorithms in =
the future.

My WIP (not even build tested), where you can see the different =
algorithms steered by the cache->flags field, looks like this:

static __rte_always_inline void
rte_mempool_do_generic_put(struct rte_mempool *mp, void * const =
*obj_table,
			   unsigned int n, struct rte_mempool_cache *cache)
{
	void **cache_objs;

	/* No cache provided? */
	if (unlikely(cache =3D=3D NULL))
		goto driver_enqueue;

	/* Increment stats now, adding in mempool always succeeds. */
	RTE_MEMPOOL_CACHE_STAT_ADD(cache, put_bulk, 1);
	RTE_MEMPOOL_CACHE_STAT_ADD(cache, put_objs, n);

	__rte_assume(cache->size <=3D RTE_MEMPOOL_CACHE_MAX_SIZE);
	__rte_assume(cache->len <=3D RTE_MEMPOOL_CACHE_MAX_SIZE);
	__rte_assume(cache->len <=3D cache->size);
	if (likely(cache->len + n <=3D cache->size)) {
		/* Sufficient room in the cache for the objects. */
		cache_objs =3D &cache->objs[cache->len];
		cache->len +=3D n;

        /* Add the objects to the cache. */
        rte_memcpy(cache_objs, obj_table, sizeof(void *) * n);

        return;
	}

    /* Insufficient room in the cache for the objects. */

    if (cache->flags & RTE_MEMPOOL_F_CACHE_ACCESS_ONE_WAY) {
        /* The algorithm is optimized for put or get operations only. */
        /* The request itself exceeds the cache bounce buffer limit? */
        __rte_assume(cache->size <=3D RTE_MEMPOOL_CACHE_MAX_SIZE);
        if (n > cache->size)
            goto driver_enqueue_stats_incremented;

        /* Fill the cache completely by adding the first part of the =
objects. */
        cache_objs =3D &cache->objs[cache->len];
        rte_memcpy(cache_objs, obj_table, sizeof(void *) * (cache->size =
- cache->len));
        obj_table +=3D cache->size - cache->len;

        /* Flush the entire cache to the backend. */
        rte_mempool_ops_enqueue_bulk(mp, &cache->objs[0], cache->size);

        /* Add the remaining objects to the cache. */
        cache->len =3D n - (cache->size - cache->len);
        rte_memcpy(&cache->objs[0], obj_table, sizeof(void *) * =
cache->len);
    } else {
        /* The algorithm is optimized for a balanced mix of put and get =
operations. */
        /* The request itself exceeds the cache bounce buffer limit? */
        __rte_assume(cache->size / 2 <=3D RTE_MEMPOOL_CACHE_MAX_SIZE / =
2);
        if (n > cache->size / 2)
            goto driver_enqueue_stats_incremented;

        /*
         * Flush part of the cache to the backend to make room for the =
objects;
         * flush (size / 2) objects from the bottom of the cache, where
         * objects are less hot, and move down the remaining objects, =
which
         * are more hot, from the upper half of the cache.
         */
        __rte_assume(cache->len > cache->size / 2);
        rte_mempool_ops_enqueue_bulk(mp, &cache->objs[0], cache->size / =
2);
        rte_memcpy(&cache->objs[0], &cache->objs[cache->size / 2],
                sizeof(void *) * (cache->len - cache->size / 2));
        cache_objs =3D &cache->objs[cache->len - cache->size / 2];
        cache->len =3D cache->len - cache->size / 2 + n;

        /* Add the objects to the cache. */
        rte_memcpy(cache_objs, obj_table, sizeof(void *) * n);
    }

    return;

driver_enqueue:

	/* increment stat now, adding in mempool always success */
	RTE_MEMPOOL_STAT_ADD(mp, put_bulk, 1);
	RTE_MEMPOOL_STAT_ADD(mp, put_objs, n);

driver_enqueue_stats_incremented:

	/* push objects to the backend */
	rte_mempool_ops_enqueue_bulk(mp, obj_table, n);
}



> Can we not use function versioning to add the
> new parameter to all functions needing it, without worrying about ABI
> breakage.

The public structures will also change, so I don't think so.

>=20
> /Bruce
