Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6261A606A328
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 13:54:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 957C340611;
	Tue,  3 Nov 2026 14:54:56 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTPS id 28E92402DE;
 Tue,  3 Nov 2026 14:54:55 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 9B755207E3;
 Tue,  3 Nov 2026 14:54:54 +0100 (CET)
Subject: RE: [PATCH v1 1/3] mempool: fix race between list walk and free
Date: Tue, 3 Nov 2026 14:54:52 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65AF4@smartserver.smartshare.dk>
In-Reply-To: <20261103011107.3658840-2-rsanford2@gmail.com>
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v1 1/3] mempool: fix race between list walk and free
Thread-Index: Ad1rMDnVw9aZUMMER0uH06Vk+LjygQAakqpw
References: <20261103011107.3658840-1-rsanford2@gmail.com>
 <20261103011107.3658840-2-rsanford2@gmail.com>
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

> From: Robert Sanford [mailto:rsanford2@gmail.com]
> Sent: Tuesday, 3 November 2026 02.11
> To: dev@dpdk.org
> Cc: andrew.rybchenko@oktetlabs.ru; Morten Br=F8rup;
> olivier.matz@6wind.com; Robert Sanford; stable@dpdk.org
> Subject: [PATCH v1 1/3] mempool: fix race between list walk and free
>=20
> From: Robert Sanford <rsanford@akamai.com>
>=20
> rte_mempool_walk(), rte_mempool_lookup() and rte_mempool_list_dump()
> traverse the mempool list holding only the mempool list lock.
> rte_mempool_create_empty() inserts into the list holding both the
> mempool list lock and the tailq lock, but rte_mempool_free() unlinks
> and frees the list entry holding only the tailq lock. So a mempool can
> be unlinked and freed, together with its list entry, while another
> thread is walking the list. The walker then reads freed memory. Since
> freed heap memory is zeroed, the walk callback is passed a NULL
> mempool, or rte_mempool_lookup() compares the name of one, and the
> process crashes.
>=20
> Take the mempool list lock in rte_mempool_free() as well, in the same
> order as rte_mempool_create_empty(). As a result, a rte_mempool_walk()
> callback must not free a mempool, as it already could not create one.
> Document this.
>=20
> Fixes: a3791ff0a3f8 ("mempool: introduce a function to free a pool")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Robert Sanford <rsanford@akamai.com>
> ---
>  lib/mempool/rte_mempool.c | 8 ++++++++
>  lib/mempool/rte_mempool.h | 3 +++
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
> index 069aabaa70..d9f339a3c2 100644
> --- a/lib/mempool/rte_mempool.c
> +++ b/lib/mempool/rte_mempool.c
> @@ -729,6 +729,13 @@ rte_mempool_free(struct rte_mempool *mp)
>  		return;
>=20
>  	mempool_list =3D RTE_TAILQ_CAST(rte_mempool_tailq.head,
> rte_mempool_list);
> +	/*
> +	 * Take the mempool list lock as well, like
> rte_mempool_create_empty(),
> +	 * so that the entry is not unlinked and freed while
> +	 * rte_mempool_walk(), rte_mempool_lookup() or
> rte_mempool_list_dump()
> +	 * is traversing the list.
> +	 */
> +	rte_mcfg_mempool_write_lock();
>  	rte_mcfg_tailq_write_lock();
>  	/* find out tailq entry */
>  	TAILQ_FOREACH(te, mempool_list, next) {
> @@ -741,6 +748,7 @@ rte_mempool_free(struct rte_mempool *mp)
>  		rte_free(te);
>  	}
>  	rte_mcfg_tailq_write_unlock();
> +	rte_mcfg_mempool_write_unlock();
>=20
>  	mempool_event_callback_invoke(RTE_MEMPOOL_EVENT_DESTROY, mp);
>  	rte_mempool_trace_free(mp);
> diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
> index b34cd893b1..bd58d8a9d5 100644
> --- a/lib/mempool/rte_mempool.h
> +++ b/lib/mempool/rte_mempool.h
> @@ -1947,6 +1947,9 @@ uint32_t rte_mempool_calc_obj_size(uint32_t
> elt_size, uint32_t flags,
>  /**
>   * Walk list of all memory pools
>   *
> + * The mempool list is locked while the iterator function runs, so =
the
> + * iterator function must not create or free a mempool.
> + *
>   * @param func
>   *   Iterator function
>   * @param arg
> --
> 2.34.1

Reviewed-by: Morten Br=F8rup <mb@smartsharesystems.com>

Verified that rte_mempool_create_empty() takes the mcfg_mempool and =
mcfg_tailq locks in the same order as this patch.

