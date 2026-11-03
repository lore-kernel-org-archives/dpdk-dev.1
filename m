Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83619606A324
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:12:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C8E24042F;
	Tue,  3 Nov 2026 15:12:20 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTPS id 17250402DE;
 Tue,  3 Nov 2026 15:12:18 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id BB40E207E3;
 Tue,  3 Nov 2026 15:12:17 +0100 (CET)
Subject: RE: [PATCH v1 2/3] mempool: skip unpopulated pools in walk and dump
Date: Tue, 3 Nov 2026 15:12:15 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65AF5@smartserver.smartshare.dk>
In-Reply-To: <20261103011107.3658840-3-rsanford2@gmail.com>
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v1 2/3] mempool: skip unpopulated pools in walk and dump
Thread-Index: Ad1rMDroHvnIAS3cTkOQIL9Zhz9KkQAaxcxw
References: <20261103011107.3658840-1-rsanford2@gmail.com>
 <20261103011107.3658840-3-rsanford2@gmail.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Robert Sanford" <rsanford2@gmail.com>,
	<dev@dpdk.org>
Cc: <andrew.rybchenko@oktetlabs.ru>, <olivier.matz@6wind.com>,
 "Robert Sanford" <rsanford@akamai.com>, <stable@dpdk.org>
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> From: Robert Sanford <rsanford@akamai.com>
>=20
> rte_mempool_create_empty() adds a mempool to the mempool list before
> the mempool has a store. The store is allocated, and
> RTE_MEMPOOL_F_POOL_CREATED is set, by the first populate call. In
> between, rte_mempool_walk() passes the mempool to its callback, and
> rte_mempool_list_dump() calls rte_mempool_dump() on it, which reads
> the number of objects in the store. With the ring driver this
> dereferences a NULL ring, and the process crashes.
>=20
> Skip mempools that do not have RTE_MEMPOOL_F_POOL_CREATED set in
> rte_mempool_walk() and rte_mempool_list_dump(), and document it.

NAK to rte_mempool_walk() skipping unpopulated pools. The effect is too =
broad.

The correct solution is for the relevant callback functions to check =
RTE_MEMPOOL_F_POOL_CREATED, if it needs to access the mempool driver.

Instead, please fix rte_mempool_dump(FILE *f, struct rte_mempool *mp) to =
not dump the parts accessing the mempool driver when =
RTE_MEMPOOL_F_POOL_CREATED is not set. We want to know that the mempool =
exists, and partial information is much better than no information.

> The
> populating thread sets the flag without holding a lock, so add a
> release fence before setting it and an acquire fence after checking
> it. A walker that sees the flag then also sees the store.
>=20
> rte_mempool_lookup() is unchanged. It does not access the store, and
> callers may look up a mempool that is not populated yet.
>=20
> Fixes: 449c49b93a6b ("mempool: support handler operations")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Robert Sanford <rsanford@akamai.com>
> ---
>  lib/mempool/rte_mempool.c | 20 +++++++++++++++++++-
>  lib/mempool/rte_mempool.h |  3 +++
>  2 files changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
> index d9f339a3c2..7c4d4697c7 100644
> --- a/lib/mempool/rte_mempool.c
> +++ b/lib/mempool/rte_mempool.c
> @@ -304,6 +304,12 @@ mempool_ops_alloc_once(struct rte_mempool *mp)
>  		ret =3D rte_mempool_ops_alloc(mp);
>  		if (ret !=3D 0)
>  			return ret;
> +		/*
> +		 * rte_mempool_walk() and rte_mempool_list_dump() access
> the
> +		 * store of pools with this flag set. Make the store
> visible
> +		 * before the flag.
> +		 */
> +		rte_atomic_thread_fence(rte_memory_order_release);
>  		mp->flags |=3D RTE_MEMPOOL_F_POOL_CREATED;
>  	}
>  	return 0;
> @@ -1412,6 +1418,11 @@ rte_mempool_list_dump(FILE *f)
>=20
>  	TAILQ_FOREACH(te, mempool_list, next) {
>  		mp =3D (struct rte_mempool *) te->data;
> +		/* skip mempools that are not populated yet */
> +		if ((mp->flags & RTE_MEMPOOL_F_POOL_CREATED) =3D=3D 0)
> +			continue;
> +		/* pairs with the release fence in mempool_ops_alloc_once()
> */
> +		rte_atomic_thread_fence(rte_memory_order_acquire);
>  		rte_mempool_dump(f, mp);
>  	}
>=20
> @@ -1460,7 +1471,14 @@ void rte_mempool_walk(void (*func)(struct
> rte_mempool *, void *),
>  	rte_mcfg_mempool_read_lock();
>=20
>  	RTE_TAILQ_FOREACH_SAFE(te, mempool_list, next, tmp_te) {
> -		(*func)((struct rte_mempool *) te->data, arg);
> +		struct rte_mempool *mp =3D (struct rte_mempool *) te->data;
> +
> +		/* skip mempools that are not populated yet */
> +		if ((mp->flags & RTE_MEMPOOL_F_POOL_CREATED) =3D=3D 0)
> +			continue;
> +		/* pairs with the release fence in mempool_ops_alloc_once()
> */
> +		rte_atomic_thread_fence(rte_memory_order_acquire);
> +		(*func)(mp, arg);
>  	}
>=20
>  	rte_mcfg_mempool_read_unlock();
> diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
> index bd58d8a9d5..7782768a2d 100644
> --- a/lib/mempool/rte_mempool.h
> +++ b/lib/mempool/rte_mempool.h
> @@ -1907,6 +1907,8 @@ static inline void *rte_mempool_get_priv(struct
> rte_mempool *mp)
>  /**
>   * Dump the status of all mempools on the console
>   *
> + * Mempools that are not populated yet are skipped.
> + *
>   * @param f
>   *   A pointer to a file for output
>   */
> @@ -1949,6 +1951,7 @@ uint32_t rte_mempool_calc_obj_size(uint32_t
> elt_size, uint32_t flags,
>   *
>   * The mempool list is locked while the iterator function runs, so =
the
>   * iterator function must not create or free a mempool.
> + * Mempools that are not populated yet are skipped.
>   *
>   * @param func
>   *   Iterator function
> --
> 2.34.1

