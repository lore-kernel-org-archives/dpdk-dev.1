Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F21BD5B175
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Dec 2025 14:41:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56B854026F;
	Mon, 15 Dec 2025 15:41:13 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id C10C940151;
 Mon, 15 Dec 2025 15:41:12 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dVN5n0dCmzJ46c7;
 Mon, 15 Dec 2025 22:40:45 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id 508A740571;
 Mon, 15 Dec 2025 22:41:11 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500001.china.huawei.com (7.214.147.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Dec 2025 14:41:10 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Mon, 15 Dec 2025 14:41:10 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>, "techboard@dpdk.org" <techboard@dpdk.org>
Subject: RE: mbuf fast-free requirements analysis
Thread-Topic: mbuf fast-free requirements analysis
Thread-Index: AdxtsuI54Ph/Or7ES4uJIkNuHGVH/AAHMGow
Date: Mon, 15 Dec 2025 14:41:10 +0000
Message-ID: <0d1645e1c83f4ec4ad676095b910845c@huawei.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F655E0@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F655E0@smartserver.smartshare.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.220]
Content-Type: text/plain; charset="iso-8859-1"
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



>=20
> Executive Summary:
>=20
> My analysis shows that the mbuf library is not a barrier for fast-freeing
> segmented packet mbufs, and thus fast-free of jumbo frames is possible.
>=20
>=20
> Detailed Analysis:
>=20
> The purpose of the mbuf fast-free Tx optimization is to reduce
> rte_pktmbuf_free_seg() to something much simpler in the ethdev drivers, b=
y
> eliminating the code path related to indirect mbufs.
> Optimally, we want to simplify the ethdev driver's function that frees th=
e
> transmitted mbufs, so it can free them directly to their mempool without
> accessing the mbufs themselves.
>=20
> If the driver cannot access the mbuf itself, it cannot determine which
> mempool it belongs to.
> We don't want the driver to access every mbuf being freed; but if all
> mbufs of a Tx queue belong to the same mempool, the driver can determine
> which mempool by looking into just one of the mbufs.
>=20
> REQUIREMENT 1: The mbufs of a Tx queue must come from the same mempool.
>=20
>=20
> When an mbuf is freed to its mempool, some of the fields in the mbuf must
> be initialized.
> So, for fast-free, this must be done by the driver's function that
> prepares the Tx descriptor.
> This is a requirement to the driver, not a requirement to the application=
.
>=20
> Now, let's dig into the code for freeing an mbuf.
> Note: For readability purposes, I'll cut out some code and comments
> unrelated to this topic.
>=20
> static __rte_always_inline void
> rte_pktmbuf_free_seg(struct rte_mbuf *m)
> {
> 	m =3D rte_pktmbuf_prefree_seg(m);
> 	if (likely(m !=3D NULL))
> 		rte_mbuf_raw_free(m);
> }
>=20
>=20
> rte_mbuf_raw_free(m) is simple, so nothing to gain there:
>=20
> /**
>  * Put mbuf back into its original mempool.
>  *
>  * The caller must ensure that the mbuf is direct and properly
>  * reinitialized (refcnt=3D1, next=3DNULL, nb_segs=3D1), as done by
>  * rte_pktmbuf_prefree_seg().
>  */
> static __rte_always_inline void
> rte_mbuf_raw_free(struct rte_mbuf *m)
> {
> 	rte_mbuf_history_mark(m, RTE_MBUF_HISTORY_OP_LIB_FREE);
> 	rte_mempool_put(m->pool, m);
> }
>=20
> Note that the description says that the mbuf must be direct.
> This is not entirely accurate; the mbuf is allowed to use a pinned
> external buffer, if the mbuf holds the only reference to it.
> (Most of the mbuf library functions have this documentation inaccuracy,
> which should be fixed some day.)
>=20
> So, the fast-free optimization really comes down to
> rte_pktmbuf_prefree_seg(m), which must not return NULL.
>=20
> Let's dig into that.
>=20
> /**
>  * Decrease reference counter and unlink a mbuf segment
>  *
>  * This function does the same than a free, except that it does not
>  * return the segment to its pool.
>  * It decreases the reference counter, and if it reaches 0, it is
>  * detached from its parent for an indirect mbuf.
>  *
>  * @return
>  *   - (m) if it is the last reference. It can be recycled or freed.
>  *   - (NULL) if the mbuf still has remaining references on it.
>  */
> static __rte_always_inline struct rte_mbuf *
> rte_pktmbuf_prefree_seg(struct rte_mbuf *m)
> {
> 	bool refcnt_not_one;
>=20
> 	refcnt_not_one =3D unlikely(rte_mbuf_refcnt_read(m) !=3D 1);
> 	if (refcnt_not_one && __rte_mbuf_refcnt_update(m, -1) !=3D 0)
> 		return NULL;
>=20
> 	if (unlikely(!RTE_MBUF_DIRECT(m))) {
> 		rte_pktmbuf_detach(m);
> 		if (RTE_MBUF_HAS_EXTBUF(m) &&
> 				RTE_MBUF_HAS_PINNED_EXTBUF(m) &&
> 				__rte_pktmbuf_pinned_extbuf_decref(m))
> 			return NULL;
> 	}
>=20
> 	if (refcnt_not_one)
> 		rte_mbuf_refcnt_set(m, 1);
> 	if (m->nb_segs !=3D 1)
> 		m->nb_segs =3D 1;
> 	if (m->next !=3D NULL)
> 		m->next =3D NULL;
>=20
> 	return m;
> }
>=20
> This function can only succeed (i.e. return non-NULL) when 'refcnt' is 1
> (or reaches 0).
>=20
> REQUIREMENT 2: The driver must hold the only reference to the mbuf,
> i.e. 'm->refcnt' must be 1.
>=20
>=20
> When the function succeeds, it initializes the mbuf fields as required by
> rte_mbuf_raw_free() before returning.
>=20
> Now, since the driver has exclusive access to the mbuf, it is free to
> initialize the 'm->next' and 'm->nb_segs' at any time.
> It could do that when preparing the Tx descriptor.
>=20
> This is very interesting, because it means that fast-free does not
> prohibit segmented packets!
> (But the driver must have sufficient Tx descriptors for all segments in
> the mbuf.)
>=20
>=20
> Now, lets dig into rte_pktmbuf_prefree_seg()'s block handling non-direct
> mbufs, i.e. cloned mbufs and mbufs with external buffer:
>=20
> 	if (unlikely(!RTE_MBUF_DIRECT(m))) {
> 		rte_pktmbuf_detach(m);
> 		if (RTE_MBUF_HAS_EXTBUF(m) &&
> 				RTE_MBUF_HAS_PINNED_EXTBUF(m) &&
> 				__rte_pktmbuf_pinned_extbuf_decref(m))
> 			return NULL;
> 	}
>=20
> Starting with rte_pktmbuf_detach():
>=20
> static inline void rte_pktmbuf_detach(struct rte_mbuf *m)
> {
> 	struct rte_mempool *mp =3D m->pool;
> 	uint32_t mbuf_size, buf_len;
> 	uint16_t priv_size;
>=20
> 	if (RTE_MBUF_HAS_EXTBUF(m)) {
> 		/*
> 		 * The mbuf has the external attached buffer,
> 		 * we should check the type of the memory pool where
> 		 * the mbuf was allocated from to detect the pinned
> 		 * external buffer.
> 		 */
> 		uint32_t flags =3D rte_pktmbuf_priv_flags(mp);
>=20
> 		if (flags & RTE_PKTMBUF_POOL_F_PINNED_EXT_BUF) {
> 			/*
> 			 * The pinned external buffer should not be
> 			 * detached from its backing mbuf, just exit.
> 			 */
> 			return;
> 		}
> 		__rte_pktmbuf_free_extbuf(m);
> 	} else {
> 		__rte_pktmbuf_free_direct(m);
> 	}
> 	priv_size =3D rte_pktmbuf_priv_size(mp);
> 	mbuf_size =3D (uint32_t)(sizeof(struct rte_mbuf) + priv_size);
> 	buf_len =3D rte_pktmbuf_data_room_size(mp);
>=20
> 	m->priv_size =3D priv_size;
> 	m->buf_addr =3D (char *)m + mbuf_size;
> 	rte_mbuf_iova_set(m, rte_mempool_virt2iova(m) + mbuf_size);
> 	m->buf_len =3D (uint16_t)buf_len;
> 	rte_pktmbuf_reset_headroom(m);
> 	m->data_len =3D 0;
> 	m->ol_flags =3D 0;
> }
>=20
> The only quick and simple code path through this function is when the mbu=
f
> uses a pinned external buffer:
> 	if (RTE_MBUF_HAS_EXTBUF(m)) {
> 		uint32_t flags =3D rte_pktmbuf_priv_flags(mp);
> 		if (flags & RTE_PKTMBUF_POOL_F_PINNED_EXT_BUF)
> 			return;
>=20
> REQUIREMENT 3: The mbuf must not be cloned or use a non-pinned external
> buffer.
>=20
>=20
> Continuing with the next part of rte_pktmbuf_prefree_seg()'s block:
>  		if (RTE_MBUF_HAS_EXTBUF(m) &&
> 				RTE_MBUF_HAS_PINNED_EXTBUF(m) &&
> 				__rte_pktmbuf_pinned_extbuf_decref(m))
> 			return NULL;
>=20
> Continuing with the next part of the block in rte_pktmbuf_prefree_seg():
>=20
> /**
>  * @internal Handle the packet mbufs with attached pinned external buffer
>  * on the mbuf freeing:
>  *
>  *  - return zero if reference counter in shinfo is one. It means there i=
s
>  *  no more reference to this pinned buffer and mbuf can be returned to
>  *  the pool
>  *
>  *  - otherwise (if reference counter is not one), decrement reference
>  *  counter and return non-zero value to prevent freeing the backing mbuf=
.
>  *
>  * Returns non zero if mbuf should not be freed.
>  */
> static inline int __rte_pktmbuf_pinned_extbuf_decref(struct rte_mbuf *m)
> {
> 	struct rte_mbuf_ext_shared_info *shinfo;
>=20
> 	/* Clear flags, mbuf is being freed. */
> 	m->ol_flags =3D RTE_MBUF_F_EXTERNAL;
> 	shinfo =3D m->shinfo;
>=20
> 	/* Optimize for performance - do not dec/reinit */
> 	if (likely(rte_mbuf_ext_refcnt_read(shinfo) =3D=3D 1))
> 		return 0;
>=20
> 	/*
> 	 * Direct usage of add primitive to avoid
> 	 * duplication of comparing with one.
> 	 */
> 	if (likely(rte_atomic_fetch_add_explicit(&shinfo->refcnt, -1,
> 				     rte_memory_order_acq_rel) - 1))
> 		return 1;
>=20
> 	/* Reinitialize counter before mbuf freeing. */
> 	rte_mbuf_ext_refcnt_set(shinfo, 1);
> 	return 0;
> }
>=20
> Essentially, if the mbuf does use a pinned external buffer,
> rte_pktmbuf_prefree_seg() only succeeds if that pinned external buffer is
> only referred to by the mbuf.
>=20
> REQUIREMENT 4: If the mbuf uses a pinned external buffer, the mbuf must
> hold the only reference to that pinned external buffer, i.e. in that case=
,
> 'm->shinfo->refcnt' must be 1.
>=20
>=20
> Please review.
>=20
> If I'm not mistaken, the mbuf library is not a barrier for fast-freeing
> segmented packet mbufs, and thus fast-free of jumbo frames is possible.
>=20
> We need a driver developer to confirm that my suggested approach -
> resetting the mbuf fields, incl. 'm->nb_segs' and 'm->next', when
> preparing the Tx descriptor - is viable.

Great analysis, makes a lot of sense to me.
Shall we add then a special API to make PMD maintainers life a bit easier:
Something like rte_mbuf_fast_free_prep(mp, mb), that will optionally check
that requirements outlined  above are satisfied for given mbuf and
also reset mbuf fields to expected values?
Konstantin



