Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61856CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 07:37:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 284DE4068A;
	Thu,  2 Oct 2025 09:37:41 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 3211840262
 for <dev@dpdk.org>; Thu,  2 Oct 2025 09:37:39 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id DF7A2206E5;
 Thu,  2 Oct 2025 09:37:38 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v3 2/5] mbuf: record mbuf operations history
Date: Thu, 2 Oct 2025 09:37:38 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6548D@smartserver.smartshare.dk>
In-Reply-To: <20250930233828.3999565-3-thomas@monjalon.net>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 2/5] mbuf: record mbuf operations history
Thread-Index: AdwyY2NCaH0RReqjRWCOdbcTvD/ZYABBNilQ
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20250930233828.3999565-1-thomas@monjalon.net>
 <20250930233828.3999565-3-thomas@monjalon.net>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>, <dev@dpdk.org>,
 "Shani Peretz" <shperetz@nvidia.com>
Cc: <viacheslavo@nvidia.com>, <bruce.richardson@intel.com>,
 <stephen@networkplumber.org>
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

> From: Thomas Monjalon [mailto:thomas@monjalon.net]
> Sent: Wednesday, 1 October 2025 01.25
>=20
> From: Shani Peretz <shperetz@nvidia.com>
> =09
> This feature is designed to monitor the lifecycle of mbufs
> as they move between the application and the PMD.
> It will allow to track the operations and transitions
> of each mbuf throughout the system, helping in debugging
> and understanding objects flow.
>=20
> As a debug feature impacting the data path, it is disabled by default.
>=20
> The implementation uses a dynamic field to store a 64-bit
> atomic history value in each mbuf. Each operation is represented
> by a 4-bit value, allowing up to 16 operations to be tracked.
> Atomic operations ensure thread safety for cloned mbufs accessed
> by multiple lcores. The dynamic field is automatically initialized
> when the first mbuf pool is created.
>=20
> Some operations done in the mbuf library are marked.
> More operations from other libraries or the application can be marked.
>=20
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---

[...]

> diff --git a/config/meson.build b/config/meson.build
> index 55497f0bf5..d1f21f3115 100644
> --- a/config/meson.build
> +++ b/config/meson.build
> @@ -379,6 +379,7 @@ if get_option('mbuf_refcnt_atomic')
>      dpdk_conf.set('RTE_MBUF_REFCNT_ATOMIC', true)
>  endif
>  dpdk_conf.set10('RTE_IOVA_IN_MBUF', get_option('enable_iova_as_pa'))
> +dpdk_conf.set10('RTE_MBUF_HISTORY_DEBUG',
> get_option('enable_mbuf_history'))

Not really important, just a suggestion:
The mempool library has its debug options defined in =
/config/rte_config.h.
For consistency, the mbuf history debug option also belongs in =
/config/rte_config.h, instead of being a meson option.
It also means using "#ifdef RTE_MBUF_HISTORY_DEBUG" instead of "#if =
RTE_MBUF_HISTORY_DEBUG".

[...]

> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mbuf_history_dump_mempool, 25.11)
> +void rte_mbuf_history_dump_mempool(FILE *f, struct rte_mempool *mp)
> +{
> +#if !RTE_MBUF_HISTORY_DEBUG
> +	RTE_SET_USED(f);
> +	RTE_SET_USED(mp);
> +	MBUF_LOG(INFO, "mbuf history recorder is not enabled");
> +#else
> +	if (f =3D=3D NULL) {
> +		MBUF_LOG(ERR, "Invalid mbuf dump file.");
> +		return;
> +	}
> +	if (mp =3D=3D NULL) {
> +		fprintf(f, "ERROR: Invalid mempool pointer\n");

Should be MBUF_LOG(ERR, ...), not fprintf().

> +		return;
> +	}
> +	if (rte_mbuf_history_field_offset < 0) {
> +		fprintf(f, "WARNING: mbuf history not initialized. Call
> rte_mbuf_history_init() first.\n");

Should be MBUF_LOG(ERR, ...), not fprintf().

> +		return;
> +	}

Since the type of objects held in a mempool is not identifiable as =
mbufs, you should check that (mp->elt_size >=3D sizeof(struct =
rte_mbuf)). Imagine some non-mbuf mempool holding 64 byte sized objects, =
and rte_mbuf_history_field_offset being in the second cache line.

You might want to log an error if called directly, and silently skip of =
called from rte_mbuf_history_dump_all(), so suggest adding a wrapper =
when calling this function through rte_mempool_walk().

> +	mbuf_history_get_stats(mp, f);
> +#endif
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mbuf_history_dump_all, 25.11)
> +void rte_mbuf_history_dump_all(FILE *f)
> +{
> +#if !RTE_MBUF_HISTORY_DEBUG
> +	RTE_SET_USED(f);
> +	MBUF_LOG(INFO, "mbuf history recorder is not enabled");
> +#else
> +	if (f =3D=3D NULL) {
> +		MBUF_LOG(ERR, "Invalid mbuf dump file.");
> +		return;
> +	}
> +	fprintf(f, "mbuf history statistics:\n");
> +	if (rte_mbuf_history_field_offset < 0) {
> +		fprintf(f, "WARNING: mbuf history not initialized. Call
> rte_mbuf_history_init() first.\n\n");
> +		return;
> +	}
> +	rte_mempool_walk(mbuf_history_get_stats, f);
> +#endif
> +}
> +

[...]

> +/**
> + * Mark an mbuf with a history event.
> + *
> + * @param m
> + *   Pointer to the mbuf.
> + * @param op
> + *   The operation to record.
> + */
> +static inline void rte_mbuf_history_mark(struct rte_mbuf *m, uint32_t
> op)
> +{
> +#if !RTE_MBUF_HISTORY_DEBUG
> +	RTE_SET_USED(m);
> +	RTE_SET_USED(op);
> +#else
> +	RTE_ASSERT(rte_mbuf_history_field_offset >=3D 0);
> +	RTE_ASSERT(op < RTE_MBUF_HISTORY_OP_MAX);
> +	if (unlikely (m =3D=3D NULL))
> +		return;
> +
> +	rte_mbuf_history_t *history_field =3D RTE_MBUF_DYNFIELD(m,
> +			rte_mbuf_history_field_offset, rte_mbuf_history_t *);
> +	uint64_t history =3D rte_atomic_load_explicit(history_field,
> rte_memory_order_acquire);
> +	history =3D (history << RTE_MBUF_HISTORY_BITS) | op;
> +	rte_atomic_store_explicit(history_field, history,
> rte_memory_order_release);

This is not thread safe.
Some other thread can race to update history_field after this thread =
loads it, so when this tread stores the updated history, the other =
thread's history update is overwritten and lost.
To make it thread safe, you must use a CAS operation and start over if =
it failed.

> +#endif
> +}

