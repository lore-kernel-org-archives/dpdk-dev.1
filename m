Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4E8E67495
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Dec 2025 17:11:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A670840265;
	Mon, 22 Dec 2025 18:11:41 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id A879F40264;
 Mon, 22 Dec 2025 18:11:40 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id D0E6F20445;
 Mon, 22 Dec 2025 18:11:37 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: mbuf fast-free requirements analysis
Date: Mon, 22 Dec 2025 18:11:35 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65608@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <4ef23a6663774a119d3087fb21ede984@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: mbuf fast-free requirements analysis
Thread-Index: AdxtsuI54Ph/Or7ES4uJIkNuHGVH/AAHMGowAACuIkAAzd1lUAAd58awAHUVwFAAAtgfgA==
References: <98CBD80474FA8B44BF855DF32C47DC35F655E0@smartserver.smartshare.dk><0d1645e1c83f4ec4ad676095b910845c@huawei.com><98CBD80474FA8B44BF855DF32C47DC35F655E5@smartserver.smartshare.dk><d290adf103244ff7be53844ee32bb6d0@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65601@smartserver.smartshare.dk>
 <4ef23a6663774a119d3087fb21ede984@huawei.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>, <dev@dpdk.org>,
 <techboard@dpdk.org>, <bruce.richardson@intel.com>
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
> Sent: Monday, 22 December 2025 16.22
> > > > > >
> > > > > > Executive Summary:
> > > > > >
> > > > > > My analysis shows that the mbuf library is not a barrier for
> > > fast-
> > > > > freeing
> > > > > > segmented packet mbufs, and thus fast-free of jumbo frames =
is
> > > > > possible.
> > > > > >
> > > > > >
> > > > > > Detailed Analysis:
> > > > > >
> > > > > > The purpose of the mbuf fast-free Tx optimization is to
> reduce
> > > > > > rte_pktmbuf_free_seg() to something much simpler in the
> ethdev
> > > > > drivers, by
> > > > > > eliminating the code path related to indirect mbufs.
> > > > > > Optimally, we want to simplify the ethdev driver's function
> that
> > > > > frees the
> > > > > > transmitted mbufs, so it can free them directly to their
> mempool
> > > > > without
> > > > > > accessing the mbufs themselves.
> > > > > >
> > > > > > If the driver cannot access the mbuf itself, it cannot
> determine
> > > > > which
> > > > > > mempool it belongs to.
> > > > > > We don't want the driver to access every mbuf being freed;
> but if
> > > all
> > > > > > mbufs of a Tx queue belong to the same mempool, the driver
> can
> > > > > determine
> > > > > > which mempool by looking into just one of the mbufs.
> > > > > >
> > > > > > REQUIREMENT 1: The mbufs of a Tx queue must come from the
> same
> > > > > mempool.
> > > > > >
> > > > > >
> > > > > > When an mbuf is freed to its mempool, some of the fields in
> the
> > > mbuf
> > > > > must
> > > > > > be initialized.
> > > > > > So, for fast-free, this must be done by the driver's =
function
> > > that
> > > > > > prepares the Tx descriptor.
> > > > > > This is a requirement to the driver, not a requirement to =
the
> > > > > application.
> > > > > >
> > > > > > Now, let's dig into the code for freeing an mbuf.
> > > > > > Note: For readability purposes, I'll cut out some code and
> > > comments
> > > > > > unrelated to this topic.
> > > > > >
> > > > > > static __rte_always_inline void
> > > > > > rte_pktmbuf_free_seg(struct rte_mbuf *m)
> > > > > > {
> > > > > > 	m =3D rte_pktmbuf_prefree_seg(m);
> > > > > > 	if (likely(m !=3D NULL))
> > > > > > 		rte_mbuf_raw_free(m);
> > > > > > }
> > > > > >
> > > > > >
> > > > > > rte_mbuf_raw_free(m) is simple, so nothing to gain there:
> > > > > >
> > > > > > /**
> > > > > >  * Put mbuf back into its original mempool.
> > > > > >  *
> > > > > >  * The caller must ensure that the mbuf is direct and
> properly
> > > > > >  * reinitialized (refcnt=3D1, next=3DNULL, nb_segs=3D1), as =
done by
> > > > > >  * rte_pktmbuf_prefree_seg().
> > > > > >  */
> > > > > > static __rte_always_inline void
> > > > > > rte_mbuf_raw_free(struct rte_mbuf *m)
> > > > > > {
> > > > > > 	rte_mbuf_history_mark(m, RTE_MBUF_HISTORY_OP_LIB_FREE);
> > > > > > 	rte_mempool_put(m->pool, m);
> > > > > > }
> > > > > >
> > > > > > Note that the description says that the mbuf must be direct.
> > > > > > This is not entirely accurate; the mbuf is allowed to use a
> > > pinned
> > > > > > external buffer, if the mbuf holds the only reference to it.
> > > > > > (Most of the mbuf library functions have this documentation
> > > > > inaccuracy,
> > > > > > which should be fixed some day.)
> > > > > >
> > > > > > So, the fast-free optimization really comes down to
> > > > > > rte_pktmbuf_prefree_seg(m), which must not return NULL.
> > > > > >
> > > > > > Let's dig into that.
> > > > > >
> > > > > > /**
> > > > > >  * Decrease reference counter and unlink a mbuf segment
> > > > > >  *
> > > > > >  * This function does the same than a free, except that it
> does
> > > not
> > > > > >  * return the segment to its pool.
> > > > > >  * It decreases the reference counter, and if it reaches 0,
> it is
> > > > > >  * detached from its parent for an indirect mbuf.
> > > > > >  *
> > > > > >  * @return
> > > > > >  *   - (m) if it is the last reference. It can be recycled =
or
> > > freed.
> > > > > >  *   - (NULL) if the mbuf still has remaining references on
> it.
> > > > > >  */
> > > > > > static __rte_always_inline struct rte_mbuf *
> > > > > > rte_pktmbuf_prefree_seg(struct rte_mbuf *m)
> > > > > > {
> > > > > > 	bool refcnt_not_one;
> > > > > >
> > > > > > 	refcnt_not_one =3D unlikely(rte_mbuf_refcnt_read(m) !=3D =
1);
> > > > > > 	if (refcnt_not_one && __rte_mbuf_refcnt_update(m, -1) !=3D =
0)
> > > > > > 		return NULL;
> > > > > >
> > > > > > 	if (unlikely(!RTE_MBUF_DIRECT(m))) {
> > > > > > 		rte_pktmbuf_detach(m);
> > > > > > 		if (RTE_MBUF_HAS_EXTBUF(m) &&
> > > > > > 				RTE_MBUF_HAS_PINNED_EXTBUF(m) &&
> > > > > > 				__rte_pktmbuf_pinned_extbuf_decref(m))
> > > > > > 			return NULL;
> > > > > > 	}
> > > > > >
> > > > > > 	if (refcnt_not_one)
> > > > > > 		rte_mbuf_refcnt_set(m, 1);
> > > > > > 	if (m->nb_segs !=3D 1)
> > > > > > 		m->nb_segs =3D 1;
> > > > > > 	if (m->next !=3D NULL)
> > > > > > 		m->next =3D NULL;
> > > > > >
> > > > > > 	return m;
> > > > > > }
> > > > > >
> > > > > > This function can only succeed (i.e. return non-NULL) when
> > > 'refcnt'
> > > > > is 1
> > > > > > (or reaches 0).
> > > > > >
> > > > > > REQUIREMENT 2: The driver must hold the only reference to =
the
> > > mbuf,
> > > > > > i.e. 'm->refcnt' must be 1.
> > > > > >
> > > > > >
> > > > > > When the function succeeds, it initializes the mbuf fields =
as
> > > > > required by
> > > > > > rte_mbuf_raw_free() before returning.
> > > > > >
> > > > > > Now, since the driver has exclusive access to the mbuf, it =
is
> > > free to
> > > > > > initialize the 'm->next' and 'm->nb_segs' at any time.
> > > > > > It could do that when preparing the Tx descriptor.
> > > > > >
> > > > > > This is very interesting, because it means that fast-free
> does
> > > not
> > > > > > prohibit segmented packets!
> > > > > > (But the driver must have sufficient Tx descriptors for all
> > > segments
> > > > > in
> > > > > > the mbuf.)
> > > > > >
> > > > > >
> > > > > > Now, lets dig into rte_pktmbuf_prefree_seg()'s block =
handling
> > > non-
> > > > > direct
> > > > > > mbufs, i.e. cloned mbufs and mbufs with external buffer:
> > > > > >
> > > > > > 	if (unlikely(!RTE_MBUF_DIRECT(m))) {
> > > > > > 		rte_pktmbuf_detach(m);
> > > > > > 		if (RTE_MBUF_HAS_EXTBUF(m) &&
> > > > > > 				RTE_MBUF_HAS_PINNED_EXTBUF(m) &&
> > > > > > 				__rte_pktmbuf_pinned_extbuf_decref(m))
> > > > > > 			return NULL;
> > > > > > 	}
> > > > > >
> > > > > > Starting with rte_pktmbuf_detach():
> > > > > >
> > > > > > static inline void rte_pktmbuf_detach(struct rte_mbuf *m)
> > > > > > {
> > > > > > 	struct rte_mempool *mp =3D m->pool;
> > > > > > 	uint32_t mbuf_size, buf_len;
> > > > > > 	uint16_t priv_size;
> > > > > >
> > > > > > 	if (RTE_MBUF_HAS_EXTBUF(m)) {
> > > > > > 		/*
> > > > > > 		 * The mbuf has the external attached buffer,
> > > > > > 		 * we should check the type of the memory pool where
> > > > > > 		 * the mbuf was allocated from to detect the pinned
> > > > > > 		 * external buffer.
> > > > > > 		 */
> > > > > > 		uint32_t flags =3D rte_pktmbuf_priv_flags(mp);
> > > > > >
> > > > > > 		if (flags & RTE_PKTMBUF_POOL_F_PINNED_EXT_BUF) {
> > > > > > 			/*
> > > > > > 			 * The pinned external buffer should not be
> > > > > > 			 * detached from its backing mbuf, just exit.
> > > > > > 			 */
> > > > > > 			return;
> > > > > > 		}
> > > > > > 		__rte_pktmbuf_free_extbuf(m);
> > > > > > 	} else {
> > > > > > 		__rte_pktmbuf_free_direct(m);
> > > > > > 	}
> > > > > > 	priv_size =3D rte_pktmbuf_priv_size(mp);
> > > > > > 	mbuf_size =3D (uint32_t)(sizeof(struct rte_mbuf) +
> > > priv_size);
> > > > > > 	buf_len =3D rte_pktmbuf_data_room_size(mp);
> > > > > >
> > > > > > 	m->priv_size =3D priv_size;
> > > > > > 	m->buf_addr =3D (char *)m + mbuf_size;
> > > > > > 	rte_mbuf_iova_set(m, rte_mempool_virt2iova(m) + mbuf_size);
> > > > > > 	m->buf_len =3D (uint16_t)buf_len;
> > > > > > 	rte_pktmbuf_reset_headroom(m);
> > > > > > 	m->data_len =3D 0;
> > > > > > 	m->ol_flags =3D 0;
> > > > > > }
> > > > > >
> > > > > > The only quick and simple code path through this function is
> when
> > > the
> > > > > mbuf
> > > > > > uses a pinned external buffer:
> > > > > > 	if (RTE_MBUF_HAS_EXTBUF(m)) {
> > > > > > 		uint32_t flags =3D rte_pktmbuf_priv_flags(mp);
> > > > > > 		if (flags & RTE_PKTMBUF_POOL_F_PINNED_EXT_BUF)
> > > > > > 			return;
> > > > > >
> > > > > > REQUIREMENT 3: The mbuf must not be cloned or use a non-
> pinned
> > > > > external
> > > > > > buffer.
> > > > > >
> > > > > >
> > > > > > Continuing with the next part of rte_pktmbuf_prefree_seg()'s
> > > block:
> > > > > >  		if (RTE_MBUF_HAS_EXTBUF(m) &&
> > > > > > 				RTE_MBUF_HAS_PINNED_EXTBUF(m) &&
> > > > > > 				__rte_pktmbuf_pinned_extbuf_decref(m))
> > > > > > 			return NULL;
> > > > > >
> > > > > > Continuing with the next part of the block in
> > > > > rte_pktmbuf_prefree_seg():
> > > > > >
> > > > > > /**
> > > > > >  * @internal Handle the packet mbufs with attached pinned
> > > external
> > > > > buffer
> > > > > >  * on the mbuf freeing:
> > > > > >  *
> > > > > >  *  - return zero if reference counter in shinfo is one. It
> means
> > > > > there is
> > > > > >  *  no more reference to this pinned buffer and mbuf can be
> > > returned
> > > > > to
> > > > > >  *  the pool
> > > > > >  *
> > > > > >  *  - otherwise (if reference counter is not one), decrement
> > > > > reference
> > > > > >  *  counter and return non-zero value to prevent freeing the
> > > backing
> > > > > mbuf.
> > > > > >  *
> > > > > >  * Returns non zero if mbuf should not be freed.
> > > > > >  */
> > > > > > static inline int __rte_pktmbuf_pinned_extbuf_decref(struct
> > > rte_mbuf
> > > > > *m)
> > > > > > {
> > > > > > 	struct rte_mbuf_ext_shared_info *shinfo;
> > > > > >
> > > > > > 	/* Clear flags, mbuf is being freed. */
> > > > > > 	m->ol_flags =3D RTE_MBUF_F_EXTERNAL;
> > > > > > 	shinfo =3D m->shinfo;
> > > > > >
> > > > > > 	/* Optimize for performance - do not dec/reinit */
> > > > > > 	if (likely(rte_mbuf_ext_refcnt_read(shinfo) =3D=3D 1))
> > > > > > 		return 0;
> > > > > >
> > > > > > 	/*
> > > > > > 	 * Direct usage of add primitive to avoid
> > > > > > 	 * duplication of comparing with one.
> > > > > > 	 */
> > > > > > 	if (likely(rte_atomic_fetch_add_explicit(&shinfo->refcnt, -
> > > 1,
> > > > > > 				     rte_memory_order_acq_rel) - 1))
> > > > > > 		return 1;
> > > > > >
> > > > > > 	/* Reinitialize counter before mbuf freeing. */
> > > > > > 	rte_mbuf_ext_refcnt_set(shinfo, 1);
> > > > > > 	return 0;
> > > > > > }
> > > > > >
> > > > > > Essentially, if the mbuf does use a pinned external buffer,
> > > > > > rte_pktmbuf_prefree_seg() only succeeds if that pinned
> external
> > > > > buffer is
> > > > > > only referred to by the mbuf.
> > > > > >
> > > > > > REQUIREMENT 4: If the mbuf uses a pinned external buffer, =
the
> > > mbuf
> > > > > must
> > > > > > hold the only reference to that pinned external buffer, i.e.
> in
> > > that
> > > > > case,
> > > > > > 'm->shinfo->refcnt' must be 1.
> > > > > >
> > > > > >
> > > > > > Please review.
> > > > > >
> > > > > > If I'm not mistaken, the mbuf library is not a barrier for
> fast-
> > > > > freeing
> > > > > > segmented packet mbufs, and thus fast-free of jumbo frames =
is
> > > > > possible.
> > > > > >
> > > > > > We need a driver developer to confirm that my suggested
> approach
> > > -
> > > > > > resetting the mbuf fields, incl. 'm->nb_segs' and 'm->next',
> when
> > > > > > preparing the Tx descriptor - is viable.
> > > > >
> > > > > Great analysis, makes a lot of sense to me.
> > > > > Shall we add then a special API to make PMD maintainers life a
> bit
> > > > > easier:
> > > > > Something like rte_mbuf_fast_free_prep(mp, mb), that will
> > > optionally
> > > > > check
> > > > > that requirements outlined  above are satisfied for given mbuf
> and
> > > > > also reset mbuf fields to expected values?
> > > >
> > > > Good idea, Konstantin.
> > > >
> > > > Detailed suggestion below.
> > > > Note that __rte_mbuf_raw_sanity_check_mp() is used to checks the
> > > requirements
> > > > after 'nb_segs' and 'next' have been initialized.
> > > >
> > > > /**
> > > >  * Reinitialize an mbuf for freeing back into the mempool.
> > > >  *
> > > >  * The caller must ensure that the mbuf comes from the specified
> > > mempool,
> > > >  * is direct and only referred to by the caller (refcnt=3D1).
> > > >  *
> > > >  * This function is used by drivers in their transmit function
> for
> > > mbuf fast release
> > > >  * when the transmit descriptor is initialized,
> > > >  * so the driver can call rte_mbuf_raw_free()
> > > >  * when the packet segment has been transmitted.
> > > >  *
> > > >  * @see RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE
> > > >  *
> > > >  * @param mp
> > > >  *   The mempool to which the mbuf belong.
> > > >  * @param m
> > > >  *   The mbuf being reinitialized.
> > > >  */
> > > > static __rte_always_inline void
> > > > rte_mbuf_raw_prefree_seg(const struct rte_mempool *mp, struct
> > > rte_mbuf *m)
> > > > {
> > > > 	if (m->nb_segs !=3D 1)
> > > > 		m->nb_segs =3D 1;
> > > > 	if (m->next !=3D NULL)
> > > > 		m->next =3D NULL;

A comment could mention that when the driver calls this function, it has =
just loaded the mbuf to initialize the transmit descriptor, so =
m->nb_segs and m->next are already hot in the cache.
And no store operations on the mbuf itself will occur for non-segmented =
packets.

> > > >
> > > > 	__rte_mbuf_raw_sanity_check_mp(m, mp);
> > > > 	rte_mbuf_history_mark(mbuf,
> > > > RTE_MBUF_HISTORY_OP_LIB_PREFREE_RAW);
> > > > }
> > >
> > > Thanks Morten, though should we really panic if condition is not
> met?
> > > Might be just do check first and return an error.
> >
> > __rte_mbuf_raw_sanity_check_mp() is a no-op unless
> > RTE_LIBRTE_MBUF_DEBUG is enabled.
>=20
> Yep, I noticed.
>=20
> >
> > Using it everywhere in alloc/free in the mbuf library is the
> convention.
> >
> > And if we don't do it here, the __rte_mbuf_raw_sanity_check_mp() in
> > rte_mbuf_raw_free() will panic later instead.
>=20
> Why?
> This new routine (rte_mbuf_raw_prefree_seg) can check that mbuf
> satisfies fast-free criteria
> before updating it, and if conditions are not met simply return an
> error.
> Then the driver has several options:
> 1) Drop the packet silently
> 2) Refuse to send it
> 3) Switch to some slower but always working code-path (without fast-
> free)
> 4) Panic

It boils down to purpose.

The function is designed for use in the transmit code path designated =
for fast-free, where the application has promised/hinted that packets =
are fast-free compliant.
Violating preconditions in the fast path (by passing packets not =
compliant to fast-free requirements to this function) is a serious type =
of bug, for which DPDK usually doesn't provide graceful fallback.
I don't want to make an exception (and introduce graceful fallback) for =
the designated fast-free code path.

My answer would be completely different if we were designing an API for =
standard packet transmission, whereby some packets living up to certain =
criteria could take a faster code path for being freed.
If that was the case, I would agree with you about returning a value to =
indicate how to proceed, like rte_pktmbuf_prefree_seg() does.

>=20
> > Better to fail early.
> > >
> > > >
> > > > /**
> > > >  * Reinitialize a bulk of mbufs for freeing back into the
> mempool.
> > > >  *
> > > >  * The caller must ensure that the mbufs come from the specified
> > > mempool,
> > > >  * are direct and only referred to by the caller (refcnt=3D1).
> > > >  *
> > > >  * This function is used by drivers in their transmit function
> for
> > > mbuf fast release
> > > >  * when the transmit descriptors are initialized,
> > > >  * so the driver can call rte_mbuf_raw_free_bulk()
> > > >  * when the packet segments have been transmitted.
> > > >  *
> > > >  * @see RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE
> > > >  *
> > > >  * @param mp
> > > >  *   The mempool to which the mbufs belong.
> > > >  * @param mbufs
> > > >  *   Array of pointers to mbufs being reinitialized.
> > > >  *   The array must not contain NULL pointers.
> > > >  * @param count
> > > >  *   Array size.
> > > >  */
> > > > static __rte_always_inline void
> > > > rte_mbuf_raw_prefree_seg_bulk(const struct rte_mempool *mp,
> struct
> > > rte_mbuf
> > > > **mbufs, unsigned int count)
> > > > {
> > > > 	for (unsigned int idx =3D 0; idx < count; idx++) {
> > > > 		struct rte_mbuf *m =3D mbufs[idx];
> > > >
> > > > 		if (m->nb_segs !=3D 1)
> > > > 			m->nb_segs =3D 1;
> > > > 		if (m->next !=3D NULL)
> > > > 			m->next =3D NULL;
> > > >
> > > > 		__rte_mbuf_raw_sanity_check_mp(m, mp);
> > > > 	}
> > > > 	rte_mbuf_history_mark_bulk(mbufs, count,
> > > > RTE_MBUF_HISTORY_OP_LIB_PREFREE_RAW);
> > > > }
> > > >
> > > > > Konstantin
> > > > >
> > > > >
> >

