Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8CECAC59A
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 14:46:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D316402C3;
	Wed, 17 Sep 2025 16:46:18 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 9E38240285
 for <dev@dpdk.org>; Wed, 17 Sep 2025 16:46:17 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 62306205C8;
 Wed, 17 Sep 2025 16:46:17 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v2 1/4] mbuf: record mbuf operations history
Date: Wed, 17 Sep 2025 16:46:16 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6543F@smartserver.smartshare.dk>
In-Reply-To: <20250916151207.556618-2-shperetz@nvidia.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 1/4] mbuf: record mbuf operations history
Thread-Index: AdwnHF26aaLl6163Ra2Xi8iq2Oc0QAAvHu5Q
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20250916151207.556618-1-shperetz@nvidia.com>
 <20250916151207.556618-2-shperetz@nvidia.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Shani Peretz" <shperetz@nvidia.com>,
	<dev@dpdk.org>
Cc: <stephen@networkplumber.org>, <bruce.richardson@intel.com>,
 <ajit.khaparde@broadcom.com>, <jerinj@marvell.com>,
 <konstantin.v.ananyev@yandex.ru>, <david.marchand@redhat.com>,
 <maxime.coquelin@redhat.com>, <gakhil@marvell.com>,
 <viacheslavo@nvidia.com>, <thomas@monjalon.net>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>
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

> From: Shani Peretz [mailto:shperetz@nvidia.com]
> Sent: Tuesday, 16 September 2025 17.12
>=20
> This feature is designed to monitor the lifecycle of mbufs
> as they move between the applicationand the PMD.
>=20
> It will allow us to track the operations and transitions
> of each mbuf  throughout the system, helping in debugging
> and understanding objects flow.
>=20
> The implementation uses a dynamic field to store a 64-bit
> history value in each mbuf. Each operation is represented
> by a 4-bit value, allowing up to 16 operations to be tracked
> per mbuf. The dynamic field is automatically initialized
> when the first mbuf pool is created.
>=20
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>

Looking really good.
Some comments inline below.

> ---
>  config/meson.build          |   1 +
>  lib/ethdev/rte_ethdev.h     |  15 +++
>  lib/mbuf/meson.build        |   2 +
>  lib/mbuf/rte_mbuf.c         |  10 +-
>  lib/mbuf/rte_mbuf.h         |  23 ++++-
>  lib/mbuf/rte_mbuf_dyn.h     |   7 ++
>  lib/mbuf/rte_mbuf_history.c | 181 =
++++++++++++++++++++++++++++++++++++
>  lib/mbuf/rte_mbuf_history.h | 154 ++++++++++++++++++++++++++++++
>  meson_options.txt           |   2 +
>  9 files changed, 392 insertions(+), 3 deletions(-)
>  create mode 100644 lib/mbuf/rte_mbuf_history.c
>  create mode 100644 lib/mbuf/rte_mbuf_history.h
>=20
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
>=20
>  compile_time_cpuflags =3D []
>  subdir(arch_subdir)
> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> index d23c143eed..d0f6cd2582 100644
> --- a/lib/ethdev/rte_ethdev.h
> +++ b/lib/ethdev/rte_ethdev.h
> @@ -6336,6 +6336,10 @@ rte_eth_rx_burst(uint16_t port_id, uint16_t
> queue_id,
>=20
>  	nb_rx =3D p->rx_pkt_burst(qd, rx_pkts, nb_pkts);
>=20
> +#if RTE_MBUF_HISTORY_DEBUG
> +	rte_mbuf_history_bulk(rx_pkts, nb_rx, RTE_MBUF_APP_RX);
> +#endif
> +
>  #ifdef RTE_ETHDEV_RXTX_CALLBACKS
>  	{
>  		void *cb;
> @@ -6688,8 +6692,19 @@ rte_eth_tx_burst(uint16_t port_id, uint16_t
> queue_id,
>  	}
>  #endif
>=20
> +#if RTE_MBUF_HISTORY_DEBUG
> +	uint16_t requested_pkts =3D nb_pkts;
> +	rte_mbuf_history_bulk(tx_pkts, nb_pkts, RTE_MBUF_PMD_TX);
> +#endif
> +
>  	nb_pkts =3D p->tx_pkt_burst(qd, tx_pkts, nb_pkts);
>=20
> +#if RTE_MBUF_HISTORY_DEBUG
> +	if (requested_pkts > nb_pkts)
> +		rte_mbuf_history_bulk(tx_pkts + nb_pkts,
> +				     requested_pkts - nb_pkts,
> RTE_MBUF_BUSY_TX);
> +#endif
> +
>  	rte_ethdev_trace_tx_burst(port_id, queue_id, (void **)tx_pkts,
> nb_pkts);
>  	return nb_pkts;
>  }
> diff --git a/lib/mbuf/meson.build b/lib/mbuf/meson.build
> index 0435c5e628..2c840ee2f2 100644
> --- a/lib/mbuf/meson.build
> +++ b/lib/mbuf/meson.build
> @@ -6,6 +6,7 @@ sources =3D files(
>          'rte_mbuf_ptype.c',
>          'rte_mbuf_pool_ops.c',
>          'rte_mbuf_dyn.c',
> +        'rte_mbuf_history.c',
>  )
>  headers =3D files(
>          'rte_mbuf.h',
> @@ -13,5 +14,6 @@ headers =3D files(
>          'rte_mbuf_ptype.h',
>          'rte_mbuf_pool_ops.h',
>          'rte_mbuf_dyn.h',
> +        'rte_mbuf_history.h',
>  )
>  deps +=3D ['mempool']
> diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
> index 9e7731a8a2..362dd252bc 100644
> --- a/lib/mbuf/rte_mbuf.c
> +++ b/lib/mbuf/rte_mbuf.c
> @@ -281,6 +281,10 @@ rte_pktmbuf_pool_create(const char *name, =
unsigned
> int n,
>  	unsigned int cache_size, uint16_t priv_size, uint16_t
> data_room_size,
>  	int socket_id)
>  {
> +#if RTE_MBUF_HISTORY_DEBUG
> +		if (rte_mbuf_history_init() < 0)
> +			RTE_LOG(ERR, MBUF, "Failed to enable mbuf
> history\n");
> +#endif

rte_mbuf_history_init() must be called from all mbuf library functions =
to create a pktmbuf_pool.

>  	return rte_pktmbuf_pool_create_by_ops(name, n, cache_size,
> priv_size,
>  			data_room_size, socket_id, NULL);
>  }
> @@ -516,8 +520,12 @@ void rte_pktmbuf_free_bulk(struct rte_mbuf
> **mbufs, unsigned int count)
>  		} while (m !=3D NULL);
>  	}
>=20
> -	if (nb_pending > 0)
> +	if (nb_pending > 0) {
> +#if RTE_MBUF_HISTORY_DEBUG
> +		rte_mbuf_history_bulk(pending, nb_pending, RTE_MBUF_FREE);
> +#endif
>  		rte_mempool_put_bulk(pending[0]->pool, (void **)pending,
> nb_pending);
> +	}
>  }
>=20
>  /* Creates a shallow copy of mbuf */
> diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
> index 06ab7502a5..8126f09de4 100644
> --- a/lib/mbuf/rte_mbuf.h
> +++ b/lib/mbuf/rte_mbuf.h
> @@ -40,6 +40,7 @@
>  #include <rte_branch_prediction.h>
>  #include <rte_mbuf_ptype.h>
>  #include <rte_mbuf_core.h>
> +#include "rte_mbuf_history.h"
>=20
>  #ifdef __cplusplus
>  extern "C" {
> @@ -607,6 +608,9 @@ static inline struct rte_mbuf
> *rte_mbuf_raw_alloc(struct rte_mempool *mp)
>  	if (rte_mempool_get(mp, &ret.ptr) < 0)
>  		return NULL;
>  	__rte_mbuf_raw_sanity_check(ret.m);
> +#if RTE_MBUF_HISTORY_DEBUG
> +	rte_mbuf_history_mark(ret.m, RTE_MBUF_ALLOC);
> +#endif
>  	return ret.m;
>  }
>=20
> @@ -642,9 +646,14 @@ static __rte_always_inline int
>  rte_mbuf_raw_alloc_bulk(struct rte_mempool *mp, struct rte_mbuf
> **mbufs, unsigned int count)
>  {
>  	int rc =3D rte_mempool_get_bulk(mp, (void **)mbufs, count);
> -	if (likely(rc =3D=3D 0))
> -		for (unsigned int idx =3D 0; idx < count; idx++)
> +	if (likely(rc =3D=3D 0)) {
> +		for (unsigned int idx =3D 0; idx < count; idx++) {
>  			__rte_mbuf_raw_sanity_check(mbufs[idx]);
> +#if RTE_MBUF_HISTORY_DEBUG
> +			rte_mbuf_history_mark(mbufs[idx], RTE_MBUF_ALLOC);
> +#endif
> +		}
> +	}
>  	return rc;
>  }
>=20
> @@ -667,6 +676,9 @@ rte_mbuf_raw_free(struct rte_mbuf *m)
>  {
>  	__rte_mbuf_raw_sanity_check(m);
>  	rte_mempool_put(m->pool, m);
> +#if RTE_MBUF_HISTORY_DEBUG
> +	rte_mbuf_history_mark(m, RTE_MBUF_FREE);
> +#endif
>  }
>=20
>  /**
> @@ -701,6 +713,9 @@ rte_mbuf_raw_free_bulk(struct rte_mempool *mp,
> struct rte_mbuf **mbufs, unsigned
>  		RTE_ASSERT(m !=3D NULL);
>  		RTE_ASSERT(m->pool =3D=3D mp);
>  		__rte_mbuf_raw_sanity_check(m);
> +#if RTE_MBUF_HISTORY_DEBUG
> +		rte_mbuf_history_mark(mbufs[idx], RTE_MBUF_FREE);
> +#endif
>  	}
>=20
>  	rte_mempool_put_bulk(mp, (void **)mbufs, count);
> @@ -1013,6 +1028,10 @@ static inline int rte_pktmbuf_alloc_bulk(struct
> rte_mempool *pool,
>  	if (unlikely(rc))
>  		return rc;
>=20
> +#if RTE_MBUF_HISTORY_DEBUG
> +	rte_mbuf_history_bulk(mbufs, count, RTE_MBUF_ALLOC);
> +#endif
> +
>  	/* To understand duff's device on loop unwinding optimization,
> see
>  	 * https://en.wikipedia.org/wiki/Duff's_device.
>  	 * Here while() loop is used rather than do() while{} to avoid
> extra
> diff --git a/lib/mbuf/rte_mbuf_dyn.h b/lib/mbuf/rte_mbuf_dyn.h
> index 865c90f579..8ae31b4e65 100644
> --- a/lib/mbuf/rte_mbuf_dyn.h
> +++ b/lib/mbuf/rte_mbuf_dyn.h
> @@ -240,6 +240,13 @@ void rte_mbuf_dyn_dump(FILE *out);
>   * and parameters together.
>   */
>=20
> +/**
> + * The mbuf history dynamic field provides lifecycle tracking for =
mbuf
> objects through the system.
> + * It records a fixed set of predefined operations to maintain
> performance
> + * while providing debugging capabilities.
> + */
> +#define RTE_MBUF_DYNFIELD_HISTORY_NAME "rte_mbuf_dynfield_history"

Suggest you also define the mbuf history type here:
typedef uint64_t rte_mbuf_history_t;

Or even better, to support cloned mbufs accessed simultaneously by =
multiple lcores:
typedef RTE_ATOMIC(uint64_t) rte_mbuf_history_t;

<feature creep>
It could be uint32_t on 32 bit architectures, for performance.
</feature creep>

> +
>  /*
>   * The metadata dynamic field provides some extra packet information
>   * to interact with RTE Flow engine. The metadata in sent mbufs can =
be
> diff --git a/lib/mbuf/rte_mbuf_history.c b/lib/mbuf/rte_mbuf_history.c
> new file mode 100644
> index 0000000000..5be56289ca
> --- /dev/null
> +++ b/lib/mbuf/rte_mbuf_history.c
> @@ -0,0 +1,181 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2024 NVIDIA Corporation & Affiliates
> + */
> +
> +#include <rte_mbuf_history.h>
> +#include <rte_mbuf_dyn.h>
> +#include <rte_log.h>
> +#include <rte_errno.h>
> +#include <eal_export.h>
> +#include <rte_mempool.h>
> +#include <rte_tailq.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <inttypes.h>
> +
> +/* Global offset for the history field */
> +int rte_mbuf_history_field_offset =3D -1;
> +RTE_EXPORT_SYMBOL(rte_mbuf_history_field_offset);
> +
> +#if RTE_MBUF_HISTORY_DEBUG
> +/* Dynamic field definition for mbuf history */
> +static const struct rte_mbuf_dynfield mbuf_dynfield_history =3D {
> +	.name =3D RTE_MBUF_DYNFIELD_HISTORY_NAME,
> +	.size =3D sizeof(uint64_t),
> +	.align =3D RTE_ALIGN(sizeof(uint64_t), 8),
> +};
> +
> +/* Context structure for combined statistics counting and mbuf =
history
> printing */
> +struct count_and_print_ctx {
> +	uint64_t *stats;
> +	FILE *f;
> +};
> +
> +static void
> +mbuf_history_count_stats_and_print(struct rte_mempool *mp
> __rte_unused, void *opaque,
> +					void *obj, unsigned obj_idx __rte_unused)
> +{
> +	struct count_and_print_ctx *ctx =3D (struct count_and_print_ctx
> *)opaque;
> +
> +	struct rte_mbuf *mbuf =3D (struct rte_mbuf *)obj;
> +
> +	if (obj =3D=3D NULL || ctx =3D=3D NULL || ctx->stats =3D=3D NULL || =
ctx->f =3D=3D
> NULL)
> +		return;
> +
> +	/* Get mbuf history */
> +	uint64_t history =3D rte_mbuf_history_get(mbuf);
> +
> +	ctx->stats[0]++; /* n_total */
> +
> +	if (history =3D=3D 0) {
> +		ctx->stats[1]++; /* n_never */
> +		return;
> +	}
> +
> +	/* Extract the most recent operation */
> +	uint64_t op =3D history & RTE_MBUF_HISTORY_MASK;
> +
> +	switch (op) {
> +	case RTE_MBUF_FREE:
> +		ctx->stats[2]++; /* n_free */
> +		break;
> +	case RTE_MBUF_PMD_FREE:
> +		ctx->stats[3]++; /* n_pmd_free */
> +		break;
> +	case RTE_MBUF_PMD_TX:
> +		ctx->stats[4]++; /* n_pmd_tx */
> +		break;
> +	case RTE_MBUF_APP_RX:
> +		ctx->stats[5]++; /* n_app_rx */
> +		break;
> +	case RTE_MBUF_PMD_ALLOC:
> +		ctx->stats[6]++; /* n_pmd_alloc */
> +		break;
> +	case RTE_MBUF_ALLOC:
> +		ctx->stats[7]++; /* n_alloc */
> +		break;
> +	case RTE_MBUF_BUSY_TX:
> +		ctx->stats[8]++; /* n_busy_tx */
> +		break;
> +	default:
> +		break;
> +	}

Intead of using stats[9], use stats[RTE_MBUF_HISTORY_OP_MAX].
Then your switch/case can be replaced by a simple one-liner:
ctx->stats[op]++;

This can also handle future history operation types not yet defined in =
the enumeration of operations.

> +
> +	/* Print the mbuf history value */
> +	fprintf(ctx->f, "mbuf %p: %016" PRIX64 "\n", mbuf, history);
> +
> +}
> +
> +static void
> +mbuf_history_get_stat(struct rte_mempool *mp, void *arg)
> +{
> +	FILE *f =3D (FILE *)arg;
> +	uint64_t stats[9] =3D {0};
> +
> +	if (f =3D=3D NULL)
> +		return;

It would be nice if mempools can somehow be marked with the type of =
objects they hold, or at least can be marked that they hold mbufs.
One simple way could be prefixing the mempool name with "MBUF_" when the =
mbuf library calls the mempool library to create a mempool.

Then this function can skip mempools holding other objects than mbufs.

> +
> +	/* Output mempool header */
> +	fprintf(f, "=3D=3D=3D Mempool: %s =3D=3D=3D\n", mp->name);
> +
> +	/* Create context structure for combined counting and printing */
> +	struct count_and_print_ctx ctx =3D { .stats =3D stats, .f =3D f };
> +
> +	/* Single pass: collect statistics and print mbuf history */
> +	rte_mempool_obj_iter(mp, mbuf_history_count_stats_and_print,
> &ctx);
> +
> +	/* Calculate total allocated mbufs */
> +	uint64_t total_allocated =3D stats[3] + stats[4] + stats[5] +
> +	stats[6] + stats[7] + stats[8];
> +
> +	/* Print statistics summary */
> +	fprintf(f, "\n"
> +		"Populated:       %u\n"
> +		"Never allocated: %" PRIu64 "\n"
> +		"Free:            %" PRIu64 "\n"
> +		"Allocated:       %" PRIu64 "\n"
> +		"PMD owned Tx:    %" PRIu64 "\n"
> +		"PMD owned Rx:    %" PRIu64 "\n"
> +		"App owned alloc: %" PRIu64 "\n"
> +		"App owned Rx:    %" PRIu64 "\n"
> +		"App owned busy:  %" PRIu64 "\n"
> +		"Counted total:   %" PRIu64 "\n",
> +		mp->populated_size, stats[1], stats[2], total_allocated,
> +		stats[4], stats[6], stats[7], stats[5], stats[8],
> stats[0]);
> +
> +	fprintf(f, "---\n");

Please follow the convention of other "dump" functions, e.g. like =
rte_mempool_dump():
- Use hierarchical indentation
- Use "    value=3D%" PRIu64 "\n".

> +}
> +#endif
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mbuf_history_dump, 25.11)
> +#if RTE_MBUF_HISTORY_DEBUG
> +void rte_mbuf_history_dump(FILE *f)
> +{
> +	if (f =3D=3D NULL) {
> +		RTE_LOG(ERR, MBUF, "Invalid file pointer\n");
> +		return;
> +	}
> +
> +	fprintf(f, "=3D=3D=3D MBUF History Statistics =3D=3D=3D\n");
> +	fprintf(f, "Dumping complete mbuf history for all
> mempools...\n");
> +
> +	/* Check if mbuf history is initialized */
> +	if (rte_mbuf_history_field_offset =3D=3D -1) {
> +		fprintf(f, "WARNING: MBUF history not initialized. Call
> rte_mbuf_history_init() first.\n\n");
> +		return;
> +	}
> +
> +	/* Use rte_mempool_walk to iterate over all mempools */
> +	rte_mempool_walk(mbuf_history_get_stat, f);
> +}
> +
> +int rte_mbuf_history_init(void)
> +{
> +	if (rte_mbuf_history_field_offset !=3D -1) {
> +		/* Already initialized */
> +		return 0;
> +	}
> +
> +	rte_mbuf_history_field_offset =3D
> rte_mbuf_dynfield_register(&mbuf_dynfield_history);
> +	if (rte_mbuf_history_field_offset < 0) {
> +		RTE_LOG(ERR, MBUF, "Failed to register mbuf history dynamic
> field: %s\n",
> +			rte_strerror(rte_errno));
> +		return -1;
> +	}
> +	return 0;
> +}
> +#else
> +void rte_mbuf_history_dump(FILE *f)
> +{
> +	RTE_SET_USED(f);
> +	RTE_LOG(INFO, MBUF, "Mbuf history recorder is not supported\n");
> +}
> +
> +int rte_mbuf_history_init(void)
> +{
> +	rte_errno =3D ENOTSUP;
> +	return -1;
> +}
> +#endif
> +RTE_EXPORT_SYMBOL(rte_mbuf_history_init);
> +RTE_EXPORT_SYMBOL(rte_mbuf_history_dump);
> diff --git a/lib/mbuf/rte_mbuf_history.h b/lib/mbuf/rte_mbuf_history.h
> new file mode 100644
> index 0000000000..4448ad1557
> --- /dev/null
> +++ b/lib/mbuf/rte_mbuf_history.h
> @@ -0,0 +1,154 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2024 NVIDIA Corporation & Affiliates
> + */
> +
> +#ifndef _RTE_MBUF_HISTORY_H_
> +#define _RTE_MBUF_HISTORY_H_
> +
> +/**
> + * @file
> + * MBUF History
> + *
> + * This module provides history tracking for mbuf objects using
> dynamic fields.
> + * It tracks the lifecycle of mbuf objects through the system with a
> fixed set
> + * of predefined events to maintain performance.
> + *
> + * The history is stored as a 64-bit value in the mbuf dynamic field
> area,
> + * with each event encoded in 4 bits, allowing up to 16 events to be
> tracked.
> + */
> +
> +#include <stdint.h>
> +#include <rte_mbuf_dyn.h>
> +#include <rte_common.h>
> +#include <rte_branch_prediction.h>
> +#include "mbuf_log.h"
> +
> +/* Forward declaration to avoid circular dependency */
> +struct rte_mbuf;
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/**
> + * Number of bits for each history operation
> + */
> +#define RTE_MBUF_HISTORY_BITS          4
> +
> +/**
> + * Maximum number of history operations that can be stored
> + */
> +#define RTE_MBUF_HISTORY_MAX_OPS       16

Suggest:
#define RTE_MBUF_HISTORY_MAX_OPS (sizeof(rte_mbuf_history_t) * 8 / =
RTE_MBUF_HISTORY_BITS)

> +
> +/**
> + * Mask for extracting the most recent operation from history
> + */
> +#define RTE_MBUF_HISTORY_MASK          ((1ULL <<
> RTE_MBUF_HISTORY_BITS) - 1)
> +
> +/**
> + * History operation types
> + */
> +enum rte_mbuf_history_op {

These values should be prefixed RTE_MBUF_HISTORY_OP_ or =
RTE_MBUF_HISTORY_ or something similar.
Also, naming should be hierarchical. Suggest:

> +	RTE_MBUF_NEVER =3D 0,        /* Initial state - never allocated */

RTE_MBUF_HISTORY_OP_NEVER

> +	RTE_MBUF_FREE =3D 1,         /* Freed back to pool */

RTE_MBUF_HISTORY_OP_FREE

> +	RTE_MBUF_PMD_FREE =3D 2,     /* Freed by PMD back to pool*/

RTE_MBUF_HISTORY_OP_PMD_FREE

> +	RTE_MBUF_PMD_TX =3D 3,       /* Sent to PMD for Tx */

RTE_MBUF_HISTORY_OP_PMD_TX

> +	RTE_MBUF_APP_RX =3D 4,       /* Returned to application on Rx */

RTE_MBUF_HISTORY_OP_PMD_RX

> +	RTE_MBUF_PMD_ALLOC =3D 5,    /* Allocated by PMD for Rx */

RTE_MBUF_HISTORY_OP_PMD_RX_ALLOC

> +	RTE_MBUF_ALLOC =3D 6,        /* Allocated by application */

RTE_MBUF_HISTORY_OP_ALLOC

> +	RTE_MBUF_BUSY_TX =3D 7,      /* Returned to app due to Tx busy */

RTE_MBUF_HISTORY_OP_PMD_TX_BUSY

> +	RTE_MBUF_USR3 =3D 13,        /* Application-defined event 3 */
> +	RTE_MBUF_USR2 =3D 14,        /* Application-defined event 2 */
> +	RTE_MBUF_USR1 =3D 15,        /* Application-defined event 1 */
> +	RTE_MBUF_MAX =3D 16,          /* Maximum trace operation value */
> +};
> +
> +
> +/**
> + * Global offset for the history field (set during initialization)
> + */
> +extern int rte_mbuf_history_field_offset;
> +
> +/**
> + * Initialize the mbuf history system
> + *
> + * This function registers the dynamic field for mbuf history
> tracking.
> + * It should be called once during application initialization.
> + *
> + * Note: This function is called by rte_pktmbuf_pool_create,
> + * so explicit invocation is usually not required unless initializing
> manually.
> + *
> + * @return
> + *   0 on success, -1 on failure with rte_errno set
> + */
> +int rte_mbuf_history_init(void);
> +
> +#if RTE_MBUF_HISTORY_DEBUG
> +/**
> + * Get the history value from an mbuf
> + *
> + * @param m
> + *   Pointer to the mbuf
> + * @return
> + *   The history value, or 0 if history is not available
> + */
> +static inline uint64_t rte_mbuf_history_get(const struct rte_mbuf *m)
> +{
> +	if (unlikely(m =3D=3D NULL || rte_mbuf_history_field_offset =3D=3D =
-1))
> +		return 0;

These are fast path, so don't validate params at runtime. Suggest:
    RTE_ASSERT(rte_mbuf_history_field_offset !=3D -1);
	if (unlikely(m =3D=3D NULL))
		return 0;

> +
> +	return *RTE_MBUF_DYNFIELD(m, rte_mbuf_history_field_offset,
> uint64_t *);

Mbufs may be cloned, so this should be an atomic operation.

> +}
> +
> +/**
> + * Mark an mbuf with a history event
> + *
> + * @param m
> + *   Pointer to the mbuf
> + * @param op
> + *   The operation to record
> + */
> +static inline void rte_mbuf_history_mark(struct rte_mbuf *m, uint32_t
> op)
> +{
> +	if (unlikely(m =3D=3D NULL || op >=3D RTE_MBUF_MAX ||
> rte_mbuf_history_field_offset =3D=3D -1))
> +		return;

These are fast path, so don't validate params at runtime. Suggest:
    RTE_ASSERT(rte_mbuf_history_field_offset !=3D -1);
    RTE_ASSERT(op < RTE_MBUF_HISTORY_OP_MAX);
	if (unlikely(m =3D=3D NULL))
		return 0;

> +
> +	uint64_t *history =3D RTE_MBUF_DYNFIELD(m,
> rte_mbuf_history_field_offset, uint64_t *);
> +	*history =3D (*history << RTE_MBUF_HISTORY_BITS) | op;

Mbufs may be cloned, so this should be an atomic operation.

> +}
> +
> +/**
> + * Mark multiple mbufs with a history event
> + *
> + * @param mbufs
> + *   Array of mbuf pointers
> + * @param n
> + *   Number of mbufs to mark
> + * @param op
> + *   The operation to record
> + */
> +static inline void rte_mbuf_history_bulk(struct rte_mbuf * const
> *mbufs,
> +					uint32_t n, uint32_t op)

rte_mbuf_history_bulk() -> rte_mbuf_history_mark_bulk()

> +{
> +	if (unlikely(mbufs =3D=3D NULL || op >=3D RTE_MBUF_MAX ||
> rte_mbuf_history_field_offset =3D=3D -1))
> +		return;

These are fast path, so don't validate params at runtime. Suggest:
    RTE_ASSERT(rte_mbuf_history_field_offset !=3D -1);
    RTE_ASSERT(mbufs !=3D NULL);
    RTE_ASSERT(op < RTE_MBUF_HISTORY_OP_MAX);

> +
> +	while (n--)
> +		rte_mbuf_history_mark(*mbufs++, op);
> +}
> +#endif
> +
> +/**
> + * Dump mbuf history statistics for all mempools to a file
> + *
> + * @param f
> + *   File pointer to write the history statistics to
> + */
> +__rte_experimental
> +void rte_mbuf_history_dump(FILE *f);

<feature creep>
It would be nice to expose three dump functions:
1) dump the history of one mbuf:
void rte_mbuf_history_dump(FILE *f, const struct rte_mbuf * mbuf);
2) dump the history of one mbuf pool, and
void rte_mbuf_history_dump_mempool(FILE *f, const struct rte_mempool * =
mp);
3) dump the history of all mbuf pools.
void rte_mbuf_history_dump_all(FILE *f);
<feature creep>

> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* _RTE_MBUF_HISTORY_H_ */
> diff --git a/meson_options.txt b/meson_options.txt
> index e49b2fc089..48f6d4a9a5 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -16,6 +16,8 @@ option('drivers_install_subdir', type: 'string',
> value: 'dpdk/pmds-<VERSION>', d
>         'Subdirectory of libdir where to install PMDs. Defaults to
> using a versioned subdirectory.')
>  option('enable_docs', type: 'boolean', value: false, description:
>         'build documentation')
> +option('enable_mbuf_history', type: 'boolean', value: false,
> description:
> +       'Enable mbuf history tracking for debugging purposes. This =
will
> track mbufs allocation and free operations. Default is false.')
>  option('enable_apps', type: 'string', value: '', description:
>         'Comma-separated list of apps to build. If unspecified, build
> all apps.')
>  option('enable_deprecated_libs', type: 'string', value: '',
> description:
> --
> 2.34.1

