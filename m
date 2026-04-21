Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A032DF89256
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Apr 2026 10:45:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D911D4029D;
	Tue, 21 Apr 2026 12:45:00 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id B89EA4027C
 for <dev@dpdk.org>; Tue, 21 Apr 2026 12:44:59 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 77BF523C33;
 Tue, 21 Apr 2026 12:44:59 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] net/intel: do not bypass mbuf lib for mbuf fast-free
Date: Tue, 21 Apr 2026 12:44:56 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65803@smartserver.smartshare.dk>
In-Reply-To: <aedSxmC4gskM6mHM@bricha3-mobl1.ger.corp.intel.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] net/intel: do not bypass mbuf lib for mbuf fast-free
Thread-Index: AdzReoG8bYEQEQofSBed4I7EPUo3oAAAPfHg
References: <20260418095639.10003-1-mb@smartsharesystems.com>
 <aedSxmC4gskM6mHM@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>
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
> Sent: Tuesday, 21 April 2026 12.35
>=20
> On Sat, Apr 18, 2026 at 09:56:38AM +0000, Morten Br=F8rup wrote:
> > Freeing mbufs directly into the mempool meant that mbuf
> instrumentation,
> > including mbuf history marking, was omitted.
> > The mbufs are now freed via the rte_mbuf_raw_free_bulk() function
> instead.
> >
> > Added a static_assert to ensure that type casting the array of =
struct
> > ci_tx_entry_vec to an array of rte_mbuf pointers remains sound.
> >
> > Performance note:
> > The (n & 31) condition was not removed.
> > For the default tx_rs_thresh value (32), the condition will be true.
> > And due to inlining, the rte_mbuf_raw_free_bulk() ends up in an
> > rte_memcpy(), where the optimizer takes advantage of knowing that =
the
> > lower bits are not set.
> > This should compensate somewhat for removing the handcoded
> optimization of
> > copying in chunks of 32 mbufs.
> >
> > Signed-off-by: Morten Br=F8rup <mb@smartsharesystems.com>
> > ---
>=20
> Ran a very quick perf test using a couple of 100G ports, no regression
> seen with this patch, maybe even a slight perf bump. Therefore:
>=20
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> Tested-by: Bruce Richardson <bruce.richardson@intel.com>
>=20
> One comment inline below:
>=20
> >  doc/guides/rel_notes/release_26_07.rst |  4 +++
> >  drivers/net/intel/common/tx.h          | 36 =
+++---------------------
> --
> >  2 files changed, 7 insertions(+), 33 deletions(-)
> >
> > diff --git a/doc/guides/rel_notes/release_26_07.rst
> b/doc/guides/rel_notes/release_26_07.rst
> > index 060b26ff61..9367d38b13 100644
> > --- a/doc/guides/rel_notes/release_26_07.rst
> > +++ b/doc/guides/rel_notes/release_26_07.rst
> > @@ -24,6 +24,10 @@ DPDK Release 26.07
> >  New Features
> >  ------------
> >
> > +* **Updated Intel common driver.**
> > +
> > +  * Added missing mbuf history marking to vectorized Tx path for
> MBUF_FAST_FREE.
> > +
>=20
> I don't think this is a big enough change to require a release note
> update.
> It's really more of a bug fix. If you are ok with it, I'd like to drop
> this
> RN entry on apply of the patch?

OK with me.

>=20
> >  .. This section should contain new features added in this release.
> >     Sample format:
> >
> > diff --git a/drivers/net/intel/common/tx.h
> b/drivers/net/intel/common/tx.h
> > index 283bd58d5d..4a201da83c 100644
> > --- a/drivers/net/intel/common/tx.h
> > +++ b/drivers/net/intel/common/tx.h
> > @@ -285,42 +285,12 @@ ci_tx_free_bufs_vec(struct ci_tx_queue *txq,
> ci_desc_done_fn desc_done, bool ctx
> >  			(txq->fast_free_mp =3D txep[0].mbuf->pool);
> >
> >  	if (mp !=3D NULL && (n & 31) =3D=3D 0) {
> > -		void **cache_objs;
> > -		struct rte_mempool_cache *cache =3D
> rte_mempool_default_cache(mp, rte_lcore_id());
> > -
> > -		if (cache =3D=3D NULL)
> > -			goto normal;
> > -
> > -		cache_objs =3D &cache->objs[cache->len];
> > -
> > -		if (n > RTE_MEMPOOL_CACHE_MAX_SIZE) {
> > -			rte_mempool_ops_enqueue_bulk(mp, (void *)txep, n);
> > -			goto done;
> > -		}
> > -
> > -		/* The cache follows the following algorithm
> > -		 *   1. Add the objects to the cache
> > -		 *   2. Anything greater than the cache min value (if it
> > -		 *   crosses the cache flush threshold) is flushed to the
> ring.
> > -		 */
> > -		/* Add elements back into the cache */
> > -		uint32_t copied =3D 0;
> > -		/* n is multiple of 32 */
> > -		while (copied < n) {
> > -			memcpy(&cache_objs[copied], &txep[copied], 32 *
> sizeof(void *));
> > -			copied +=3D 32;
> > -		}
> > -		cache->len +=3D n;
> > -
> > -		if (cache->len >=3D cache->flushthresh) {
> > -			rte_mempool_ops_enqueue_bulk(mp, &cache->objs[cache-
> >size],
> > -					cache->len - cache->size);
> > -			cache->len =3D cache->size;
> > -		}
> > +		static_assert(sizeof(*txep) =3D=3D sizeof(struct rte_mbuf *),
> > +				"txep array is not similar to an array of
> rte_mbuf pointers");
> > +		rte_mbuf_raw_free_bulk(mp, (void *)txep, n);
> >  		goto done;
> >  	}
> >
> > -normal:
> >  	m =3D rte_pktmbuf_prefree_seg(txep[0].mbuf);
> >  	if (likely(m)) {
> >  		free[0] =3D m;
> > --
> > 2.43.0
> >
