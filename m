Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B602BCCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 09:59:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8C62402AE;
	Tue, 14 Oct 2025 11:59:43 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id DBDB8402A8
 for <dev@dpdk.org>; Tue, 14 Oct 2025 11:59:42 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id A9958206E5;
 Tue, 14 Oct 2025 11:59:42 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v5 3/7] mbuf: record mbuf operations history
Date: Tue, 14 Oct 2025 11:59:40 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F654C7@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20251014070517.922137-4-thomas@monjalon.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v5 3/7] mbuf: record mbuf operations history
Thread-Index: Adw82PAswo/AbeunQsSO9EynAOGSXwAEcy3A
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251014070517.922137-1-thomas@monjalon.net>
 <20251014070517.922137-4-thomas@monjalon.net>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>,
	<dev@dpdk.org>
Cc: <shperetz@nvidia.com>, <viacheslavo@nvidia.com>,
 <bruce.richardson@intel.com>, <stephen@networkplumber.org>
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
> Sent: Tuesday, 14 October 2025 08.59
>=20
> From: Shani Peretz <shperetz@nvidia.com>
>=20
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
>  config/rte_config.h                     |   1 +
>  doc/guides/howto/debug_troubleshoot.rst |   6 +
>  doc/guides/prog_guide/mbuf_lib.rst      |   7 +
>  doc/guides/rel_notes/release_25_11.rst  |   6 +
>  lib/mbuf/mbuf_history.c                 | 227 =
++++++++++++++++++++++++
>  lib/mbuf/meson.build                    |   2 +
>  lib/mbuf/rte_mbuf.c                     |   6 +-
>  lib/mbuf/rte_mbuf.h                     |  13 +-
>  lib/mbuf/rte_mbuf_dyn.h                 |  18 ++
>  lib/mbuf/rte_mbuf_history.h             | 203 +++++++++++++++++++++
>  10 files changed, 486 insertions(+), 3 deletions(-)
>  create mode 100644 lib/mbuf/mbuf_history.c
>  create mode 100644 lib/mbuf/rte_mbuf_history.h
>=20
> diff --git a/config/rte_config.h b/config/rte_config.h
> index 05344e2619..aee137717b 100644
> --- a/config/rte_config.h
> +++ b/config/rte_config.h
> @@ -64,6 +64,7 @@
>=20
>  /* mbuf defines */
>  #define RTE_MBUF_DEFAULT_MEMPOOL_OPS "ring_mp_mc"
> +/* RTE_MBUF_HISTORY_DEBUG is not set */
>=20
>  /* ether defines */
>  #define RTE_MAX_QUEUES_PER_PORT 1024
> diff --git a/doc/guides/howto/debug_troubleshoot.rst
> b/doc/guides/howto/debug_troubleshoot.rst
> index df69fa8bcc..16feeb1e54 100644
> --- a/doc/guides/howto/debug_troubleshoot.rst
> +++ b/doc/guides/howto/debug_troubleshoot.rst
> @@ -217,6 +217,12 @@ Memory objects close to NUMA
> :numref:`dtg_mempool`.
>       desired value and frequently uses ``rte_pktmbuf_prefree_seg`` =
and
> does
>       not release MBUF back to mempool.
>=20
> +   The mbuf lifecycle can be tracked
> +   by defining the compilation flag ``RTE_MBUF_HISTORY_DEBUG``.
> +   Then the libraries will mark the mbufs,
> +   and more marks can be added in the application.
> +   Some dump functions must be used to collect the history.
> +
>  #. Lower performance between the pipeline processing stages can be
>=20
>     * The NUMA instance for packets or objects from NIC, mempool, and
> ring
> diff --git a/doc/guides/prog_guide/mbuf_lib.rst
> b/doc/guides/prog_guide/mbuf_lib.rst
> index badc0f3501..ae72eecc61 100644
> --- a/doc/guides/prog_guide/mbuf_lib.rst
> +++ b/doc/guides/prog_guide/mbuf_lib.rst
> @@ -273,6 +273,13 @@ perform sanity checks (such as buffer corruption,
> bad type, and so on).
>  When ``RTE_ENABLE_ASSERT`` is enabled,
>  more basic checks are done in many functions.
>=20
> +When ``RTE_MBUF_HISTORY_DEBUG`` is enabled,
> +the mbuf lifecycle is tracked.
> +More marks can be added by the application
> +by calling functions like ``rte_mbuf_history_mark_bulk()``.
> +Then the history can be stored in a file
> +by calling functions like ``rte_mbuf_history_dump_all()``.
> +
>=20
>  Use Cases
>  ---------
> diff --git a/doc/guides/rel_notes/release_25_11.rst
> b/doc/guides/rel_notes/release_25_11.rst
> index c3b94e1896..6854090096 100644
> --- a/doc/guides/rel_notes/release_25_11.rst
> +++ b/doc/guides/rel_notes/release_25_11.rst
> @@ -60,6 +60,12 @@ New Features
>    Added Ethernet link speed for 800 Gb/s as it is well standardized =
in
> IEEE,
>    and some devices already support this speed.
>=20
> +* **Added mbuf tracking for debug.**
> +
> +  Added history dynamic field in mbuf (disabled by default)
> +  to store successive states of the mbuf lifecycle.
> +  Some functions were added to dump statistics.
> +
>  * **Updated NXP DPAA2 ethernet driver.**
>=20
>    * Enabled software taildrop for ordered queues.
> diff --git a/lib/mbuf/mbuf_history.c b/lib/mbuf/mbuf_history.c
> new file mode 100644
> index 0000000000..e3203c0d5c
> --- /dev/null
> +++ b/lib/mbuf/mbuf_history.c
> @@ -0,0 +1,227 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2024 NVIDIA Corporation & Affiliates

Suggest: 2024 -> 2025
Also in other files.

> + */
> +
> +#include <rte_errno.h>
> +#include <eal_export.h>
> +#include <rte_bitops.h>
> +#include <rte_mempool.h>
> +
> +#include "rte_mbuf_history.h"
> +#include "rte_mbuf_dyn.h"
> +#include "rte_mbuf.h"
> +#include "mbuf_log.h"
> +
> +/* Dynamic field offset */
> +RTE_EXPORT_SYMBOL(rte_mbuf_history_field_offset);
> +int rte_mbuf_history_field_offset =3D -1;
> +
> +#ifdef RTE_MBUF_HISTORY_DEBUG
> +
> +#define HISTORY_LAST_MASK (RTE_BIT64(RTE_MBUF_HISTORY_BITS) - 1)

Various places in the code has something like:
+	last_op =3D history & HISTORY_LAST_MASK;
+	RTE_ASSERT(last_op < RTE_MBUF_HISTORY_OP_MAX);

Suggest replacing those by adding a static_assert here instead:
static_assert(RTE_MBUF_HISTORY_OP_MAX =3D=3D HISTORY_LAST_MASK + 1, "Op =
size mismatch")

> +
> +/* Dynamic field definition for mbuf history */
> +static const struct rte_mbuf_dynfield mbuf_dynfield_history =3D {
> +	.name =3D RTE_MBUF_DYNFIELD_HISTORY_NAME,
> +	.size =3D sizeof(rte_mbuf_history_t),
> +	.align =3D RTE_ALIGN(sizeof(rte_mbuf_history_t), 8),
> +};
> +
> +/* Context structure for statistics counting and history printing */
> +struct count_and_print_ctx {
> +	uint64_t *stats;
> +	FILE *f;
> +};
> +
> +static uint64_t
> +mbuf_history_get(const struct rte_mbuf *m)
> +{
> +	if (rte_mbuf_history_field_offset < 0 || m =3D=3D NULL)
> +		return 0;
> +
> +	rte_mbuf_history_t *history =3D RTE_MBUF_DYNFIELD(m,
> +			rte_mbuf_history_field_offset, rte_mbuf_history_t *);
> +
> +	return rte_atomic_load_explicit(history,
> rte_memory_order_acquire);
> +}
> +
> +static int
> +mbuf_history_print(FILE *f, const struct rte_mbuf *m, uint64_t
> history)
> +{
> +	return fprintf(f, "mbuf %p: %016" PRIx64 "\n", m, history);
> +}
> +
> +static void
> +mbuf_history_count_stats_and_print(struct rte_mempool *mp
> __rte_unused,
> +		void *opaque, void *obj, unsigned obj_idx __rte_unused)

Fix:
unsigned -> unsigned int

> +{
> +	struct count_and_print_ctx *ctx =3D (struct count_and_print_ctx
> *)opaque;
> +	struct rte_mbuf *m =3D (struct rte_mbuf *)obj;
> +	uint64_t history, last_op;

Suggest using the enum type for operation variables:
uint64_t history;
enum rte_mbuf_history_op last_op;

Also elsewhere in the code.

> +
> +	if (obj =3D=3D NULL || ctx =3D=3D NULL || ctx->stats =3D=3D NULL || =
ctx->f =3D=3D
> NULL)
> +		return;
> +
> +	history =3D mbuf_history_get(m);
> +	/* Extract the most recent operation */
> +	last_op =3D history & HISTORY_LAST_MASK;
> +	RTE_ASSERT(last_op < RTE_MBUF_HISTORY_OP_MAX);
> +
> +	ctx->stats[last_op]++;
> +	ctx->stats[RTE_MBUF_HISTORY_OP_MAX]++; /* total */
> +
> +	if (history !=3D 0)
> +		mbuf_history_print(ctx->f, m, history);
> +}
> +
> +static void
> +mbuf_history_get_stats(struct rte_mempool *mp, FILE *f)
> +{
> +	uint64_t stats[RTE_MBUF_HISTORY_OP_MAX + 1] =3D {0};
> +	struct count_and_print_ctx ctx =3D {
> +		.stats =3D stats,
> +		.f =3D f
> +	};
> +
> +	if (mp->elt_size < sizeof(struct rte_mbuf)) {
> +		MBUF_LOG(ERR, "Invalid mempool element size (less than
> mbuf)");
> +		return;
> +	}
> +
> +	if (f =3D=3D NULL)
> +		return;
> +
> +	/* Output mempool header */
> +	fprintf(f, "mempool <%s>@%p\n", mp->name, mp);
> +
> +	/* Single pass: collect statistics and print mbuf history */
> +	rte_mempool_obj_iter(mp, mbuf_history_count_stats_and_print,
> &ctx);
> +
> +	/* Calculate total allocated mbufs */
> +	uint64_t total_allocated =3D
> +		stats[RTE_MBUF_HISTORY_OP_LIB_ALLOC] +
> +		stats[RTE_MBUF_HISTORY_OP_PMD_ALLOC] +
> +		stats[RTE_MBUF_HISTORY_OP_APP_ALLOC] +
> +		stats[RTE_MBUF_HISTORY_OP_RX] +
> +		stats[RTE_MBUF_HISTORY_OP_TX] +
> +		stats[RTE_MBUF_HISTORY_OP_PREP_TX] +
> +		stats[RTE_MBUF_HISTORY_OP_BUSY_TX] +
> +		stats[RTE_MBUF_HISTORY_OP_ENQUEUE] +
> +		stats[RTE_MBUF_HISTORY_OP_DEQUEUE];
> +
> +	/* Print statistics summary */
> +	fprintf(f, "  populated =3D %u\n", mp->populated_size);
> +	fprintf(f, "  never allocated =3D %" PRIu64 "\n",
> stats[RTE_MBUF_HISTORY_OP_NEVER]);
> +	fprintf(f, "  lib free =3D %" PRIu64 "\n",
> stats[RTE_MBUF_HISTORY_OP_LIB_FREE]);
> +	fprintf(f, "  PMD free =3D %" PRIu64 "\n",
> stats[RTE_MBUF_HISTORY_OP_PMD_FREE]);
> +	fprintf(f, "  app free =3D %" PRIu64 "\n",
> stats[RTE_MBUF_HISTORY_OP_APP_FREE]);
> +	fprintf(f, "  allocated =3D %" PRIu64 "\n", total_allocated);
> +	fprintf(f, "  lib alloc =3D %" PRIu64 "\n",
> stats[RTE_MBUF_HISTORY_OP_LIB_ALLOC]);
> +	fprintf(f, "  PMD alloc =3D %" PRIu64 "\n",
> stats[RTE_MBUF_HISTORY_OP_PMD_ALLOC]);
> +	fprintf(f, "  app alloc =3D %" PRIu64 "\n",
> stats[RTE_MBUF_HISTORY_OP_APP_ALLOC]);
> +	fprintf(f, "  Rx =3D %" PRIu64 "\n",
> stats[RTE_MBUF_HISTORY_OP_RX]);
> +	fprintf(f, "  Tx =3D %" PRIu64 "\n",
> stats[RTE_MBUF_HISTORY_OP_TX]);
> +	fprintf(f, "  prep Tx =3D %" PRIu64 "\n",
> stats[RTE_MBUF_HISTORY_OP_PREP_TX]);
> +	fprintf(f, "  busy Tx =3D %" PRIu64 "\n",
> stats[RTE_MBUF_HISTORY_OP_BUSY_TX]);
> +	fprintf(f, "  enqueue =3D %" PRIu64 "\n",
> stats[RTE_MBUF_HISTORY_OP_ENQUEUE]);
> +	fprintf(f, "  dequeue =3D %" PRIu64 "\n",
> stats[RTE_MBUF_HISTORY_OP_DEQUEUE]);
> +	fprintf(f, "  user defined 1 =3D %" PRIu64 "\n",
> stats[RTE_MBUF_HISTORY_OP_USR1]);
> +	fprintf(f, "  user defined 2 =3D %" PRIu64 "\n",
> stats[RTE_MBUF_HISTORY_OP_USR2]);
> +	fprintf(f, "  counted total =3D %" PRIu64 "\n",
> stats[RTE_MBUF_HISTORY_OP_MAX]);
> +}
> +
> +static void
> +mbuf_history_get_stats_walking(struct rte_mempool *mp, void *arg)
> +{
> +	if (mp->elt_size < sizeof(struct rte_mbuf))
> +		return; /* silently ignore while walking in all mempools */
> +
> +	mbuf_history_get_stats(mp, arg);
> +}
> +
> +#endif /* RTE_MBUF_HISTORY_DEBUG */
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mbuf_history_dump, 25.11)
> +void rte_mbuf_history_dump(FILE *f, const struct rte_mbuf *m)
> +{
> +#ifndef RTE_MBUF_HISTORY_DEBUG
> +	RTE_SET_USED(f);
> +	RTE_SET_USED(m);
> +	MBUF_LOG(INFO, "mbuf history recorder is not enabled");
> +#else
> +	if (f =3D=3D NULL) {
> +		MBUF_LOG(ERR, "Invalid mbuf dump file");
> +		return;
> +	}
> +	if (m =3D=3D NULL) {
> +		MBUF_LOG(ERR, "Invalid mbuf pointer");
> +		return;
> +	}
> +	if (rte_mbuf_history_field_offset < 0) {
> +		MBUF_LOG(WARNING, "mbuf history not initialized, call
> rte_mbuf_history_init()");
> +		return;
> +	}
> +	mbuf_history_print(f, m, mbuf_history_get(m));
> +#endif
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mbuf_history_dump_mempool, 25.11)
> +void rte_mbuf_history_dump_mempool(FILE *f, struct rte_mempool *mp)
> +{
> +#ifndef RTE_MBUF_HISTORY_DEBUG
> +	RTE_SET_USED(f);
> +	RTE_SET_USED(mp);
> +	MBUF_LOG(INFO, "mbuf history recorder is not enabled");
> +#else
> +	if (f =3D=3D NULL) {
> +		MBUF_LOG(ERR, "Invalid mbuf dump file");
> +		return;
> +	}
> +	if (mp =3D=3D NULL) {
> +		MBUF_LOG(ERR, "Invalid mempool pointer");
> +		return;
> +	}
> +	if (rte_mbuf_history_field_offset < 0) {
> +		MBUF_LOG(WARNING, "mbuf history not initialized, call
> rte_mbuf_history_init()");
> +		return;
> +	}
> +	mbuf_history_get_stats(mp, f);
> +#endif
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mbuf_history_dump_all, 25.11)
> +void rte_mbuf_history_dump_all(FILE *f)
> +{
> +#ifndef RTE_MBUF_HISTORY_DEBUG
> +	RTE_SET_USED(f);
> +	MBUF_LOG(INFO, "mbuf history recorder is not enabled");
> +#else
> +	if (f =3D=3D NULL) {
> +		MBUF_LOG(ERR, "Invalid mbuf dump file");
> +		return;
> +	}
> +	if (rte_mbuf_history_field_offset < 0) {
> +		MBUF_LOG(WARNING, "mbuf history not initialized, call
> rte_mbuf_history_init()");
> +		return;
> +	}
> +	fprintf(f, "mbuf history statistics:\n");
> +	rte_mempool_walk(mbuf_history_get_stats_walking, f);
> +#endif
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mbuf_history_init, 25.11)
> +void rte_mbuf_history_init(void)
> +{
> +#ifdef RTE_MBUF_HISTORY_DEBUG
> +	if (rte_mbuf_history_field_offset >=3D 0) {
> +		/* already initialized */
> +		return;
> +	}
> +
> +	rte_mbuf_history_field_offset =3D
> rte_mbuf_dynfield_register(&mbuf_dynfield_history);
> +	if (rte_mbuf_history_field_offset < 0) {
> +		MBUF_LOG(ERR, "Failed to register mbuf history dynamic
> field: %s\n",
> +			rte_strerror(rte_errno));
> +	}
> +#endif
> +}
> diff --git a/lib/mbuf/meson.build b/lib/mbuf/meson.build
> index 0435c5e628..a394db2b19 100644
> --- a/lib/mbuf/meson.build
> +++ b/lib/mbuf/meson.build
> @@ -2,6 +2,7 @@
>  # Copyright(c) 2017 Intel Corporation
>=20
>  sources =3D files(
> +        'mbuf_history.c',
>          'rte_mbuf.c',
>          'rte_mbuf_ptype.c',
>          'rte_mbuf_pool_ops.c',
> @@ -13,5 +14,6 @@ headers =3D files(
>          'rte_mbuf_ptype.h',
>          'rte_mbuf_pool_ops.h',
>          'rte_mbuf_dyn.h',
> +        'rte_mbuf_history.h',
>  )
>  deps +=3D ['mempool']
> diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
> index 22d7cfc475..d96c2196a3 100644
> --- a/lib/mbuf/rte_mbuf.c
> +++ b/lib/mbuf/rte_mbuf.c
> @@ -41,6 +41,8 @@ rte_pktmbuf_pool_init(struct rte_mempool *mp, void
> *opaque_arg)
>  		   sizeof(struct rte_pktmbuf_pool_private));
>  	RTE_ASSERT(mp->elt_size >=3D sizeof(struct rte_mbuf));
>=20
> +	rte_mbuf_history_init();
> +
>  	/* if no structure is provided, assume no mbuf private area */
>  	user_mbp_priv =3D opaque_arg;
>  	if (user_mbp_priv =3D=3D NULL) {
> @@ -515,8 +517,10 @@ void rte_pktmbuf_free_bulk(struct rte_mbuf
> **mbufs, unsigned int count)
>  		} while (m !=3D NULL);
>  	}
>=20
> -	if (nb_pending > 0)
> +	if (nb_pending > 0) {
> +		rte_mbuf_history_mark_bulk(pending, nb_pending,
> RTE_MBUF_HISTORY_OP_LIB_FREE);
>  		rte_mempool_put_bulk(pending[0]->pool, (void **)pending,
> nb_pending);
> +	}
>  }
>=20
>  /* Creates a shallow copy of mbuf */
> diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
> index 06ab7502a5..a6c6b21253 100644
> --- a/lib/mbuf/rte_mbuf.h
> +++ b/lib/mbuf/rte_mbuf.h
> @@ -40,6 +40,7 @@
>  #include <rte_branch_prediction.h>
>  #include <rte_mbuf_ptype.h>
>  #include <rte_mbuf_core.h>
> +#include <rte_mbuf_history.h>
>=20
>  #ifdef __cplusplus
>  extern "C" {
> @@ -607,6 +608,7 @@ static inline struct rte_mbuf
> *rte_mbuf_raw_alloc(struct rte_mempool *mp)
>  	if (rte_mempool_get(mp, &ret.ptr) < 0)
>  		return NULL;
>  	__rte_mbuf_raw_sanity_check(ret.m);
> +	rte_mbuf_history_mark(ret.m, RTE_MBUF_HISTORY_OP_LIB_ALLOC);
>  	return ret.m;
>  }
>=20
> @@ -642,9 +644,12 @@ static __rte_always_inline int
>  rte_mbuf_raw_alloc_bulk(struct rte_mempool *mp, struct rte_mbuf
> **mbufs, unsigned int count)
>  {
>  	int rc =3D rte_mempool_get_bulk(mp, (void **)mbufs, count);
> -	if (likely(rc =3D=3D 0))
> -		for (unsigned int idx =3D 0; idx < count; idx++)
> +	if (likely(rc =3D=3D 0)) {
> +		for (unsigned int idx =3D 0; idx < count; idx++) {
>  			__rte_mbuf_raw_sanity_check(mbufs[idx]);
> +			rte_mbuf_history_mark(mbufs[idx],
> RTE_MBUF_HISTORY_OP_LIB_ALLOC);
> +		}
> +	}
>  	return rc;
>  }
>=20
> @@ -667,6 +672,7 @@ rte_mbuf_raw_free(struct rte_mbuf *m)
>  {
>  	__rte_mbuf_raw_sanity_check(m);
>  	rte_mempool_put(m->pool, m);
> +	rte_mbuf_history_mark(m, RTE_MBUF_HISTORY_OP_LIB_FREE);

Fix: For improved race protection, mark the mbuf before actually freeing =
it, like this:
 	__rte_mbuf_raw_sanity_check(m);
+	rte_mbuf_history_mark(m, RTE_MBUF_HISTORY_OP_LIB_FREE);
 	rte_mempool_put(m->pool, m);

>  }
>=20
>  /**
> @@ -701,6 +707,7 @@ rte_mbuf_raw_free_bulk(struct rte_mempool *mp,
> struct rte_mbuf **mbufs, unsigned
>  		RTE_ASSERT(m !=3D NULL);
>  		RTE_ASSERT(m->pool =3D=3D mp);
>  		__rte_mbuf_raw_sanity_check(m);
> +		rte_mbuf_history_mark(mbufs[idx],
> RTE_MBUF_HISTORY_OP_LIB_FREE);
>  	}

Fix: The loop is normally omitted, so use rte_mbuf_history_mark_bulk() =
here instead of rte_mbuf_history_mark() inside the loop.
It also makes the code easier to read.

>=20
>  	rte_mempool_put_bulk(mp, (void **)mbufs, count);
> @@ -1013,6 +1020,8 @@ static inline int rte_pktmbuf_alloc_bulk(struct
> rte_mempool *pool,
>  	if (unlikely(rc))
>  		return rc;
>=20
> +	rte_mbuf_history_mark_bulk(mbufs, count,
> RTE_MBUF_HISTORY_OP_LIB_ALLOC);
> +
>  	/* To understand duff's device on loop unwinding optimization,
> see
>  	 * https://en.wikipedia.org/wiki/Duff's_device.
>  	 * Here while() loop is used rather than do() while{} to avoid
> extra
> diff --git a/lib/mbuf/rte_mbuf_dyn.h b/lib/mbuf/rte_mbuf_dyn.h
> index 865c90f579..dc1d4f146a 100644
> --- a/lib/mbuf/rte_mbuf_dyn.h
> +++ b/lib/mbuf/rte_mbuf_dyn.h
> @@ -69,6 +69,7 @@
>  #include <stdio.h>
>  #include <stdint.h>
>=20
> +#include <rte_stdatomic.h>
>=20
>  #ifdef __cplusplus
>  extern "C" {
> @@ -240,6 +241,23 @@ void rte_mbuf_dyn_dump(FILE *out);
>   * and parameters together.
>   */
>=20
> +/**
> + * The mbuf history dynamic field provides lifecycle tracking
> + * for mbuf objects through the system.
> + * It records a fixed set of predefined operations for debugging.
> + */
> +#define RTE_MBUF_DYNFIELD_HISTORY_NAME "rte_mbuf_dynfield_history"
> +
> +/**
> + * Type for mbuf history dynamic field.
> + *
> + * Use atomic operations to support cloned mbufs
> + * accessed simultaneously by multiple lcores.
> + *
> + * The size is 64-bit for better performance on modern systems.
> + */
> +typedef RTE_ATOMIC(uint64_t) rte_mbuf_history_t;
> +
>  /*
>   * The metadata dynamic field provides some extra packet information
>   * to interact with RTE Flow engine. The metadata in sent mbufs can =
be
> diff --git a/lib/mbuf/rte_mbuf_history.h b/lib/mbuf/rte_mbuf_history.h
> new file mode 100644
> index 0000000000..915fb13dac
> --- /dev/null
> +++ b/lib/mbuf/rte_mbuf_history.h
> @@ -0,0 +1,203 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2024 NVIDIA Corporation & Affiliates
> + */
> +
> +#ifndef _RTE_MBUF_HISTORY_H_
> +#define _RTE_MBUF_HISTORY_H_
> +
> +/**
> + * @file
> + *
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * These functions allow to track history of mbuf objects using a
> dynamic field.
> + *
> + * It tracks the lifecycle of mbuf objects through the system
> + * with a fixed set of predefined events to maintain performance.
> + *
> + * The history is stored as an atomic value (64-bit) in a dynamic
> field of the mbuf,
> + * with each event encoded in 4 bits, allowing up to 16 events to be
> tracked.
> + * Atomic operations ensure thread safety for cloned mbufs accessed =
by
> multiple lcores.
> + */
> +
> +#include <rte_common.h>
> +#include <rte_debug.h>
> +
> +#include <rte_mbuf_dyn.h>
> +
> +/* Forward declaration to avoid circular dependency. */
> +struct rte_mbuf;
> +struct rte_mempool;
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/**
> + * Number of bits for each history operation.
> + */
> +#define RTE_MBUF_HISTORY_BITS 4
> +
> +/**
> + * Maximum number of history operations that can be stored.
> + */
> +#define RTE_MBUF_HISTORY_MAX (sizeof(rte_mbuf_history_t) * 8 /
> RTE_MBUF_HISTORY_BITS)
> +
> +/**
> + * History operation types.
> + */
> +enum rte_mbuf_history_op {
> +	RTE_MBUF_HISTORY_OP_NEVER     =3D  0, /**< Initial state - never
> allocated */
> +	RTE_MBUF_HISTORY_OP_LIB_FREE  =3D  1, /**< Freed back to pool */
> +	RTE_MBUF_HISTORY_OP_PMD_FREE  =3D  2, /**< Freed by PMD */
> +	RTE_MBUF_HISTORY_OP_APP_FREE  =3D  3, /**< Freed by application */
> +	RTE_MBUF_HISTORY_OP_LIB_ALLOC =3D  4, /**< Allocation in mbuf
> library */
> +	RTE_MBUF_HISTORY_OP_PMD_ALLOC =3D  5, /**< Allocated by PMD for Rx
> */
> +	RTE_MBUF_HISTORY_OP_APP_ALLOC =3D  6, /**< Allocated by application
> */
> +	RTE_MBUF_HISTORY_OP_RX        =3D  7, /**< Received */
> +	RTE_MBUF_HISTORY_OP_TX        =3D  8, /**< Sent */
> +	RTE_MBUF_HISTORY_OP_PREP_TX   =3D  9, /**< Being prepared before Tx
> */
> +	RTE_MBUF_HISTORY_OP_BUSY_TX   =3D 10, /**< Returned due to Tx busy
> */

Suggest:
RTE_MBUF_HISTORY_OP_PREP_TX -> RTE_MBUF_HISTORY_OP_TX_PREP
RTE_MBUF_HISTORY_OP_BUSY_TX -> RTE_MBUF_HISTORY_OP_TX_BUSY

> +	RTE_MBUF_HISTORY_OP_ENQUEUE   =3D 11, /**< Enqueued for processing
> */
> +	RTE_MBUF_HISTORY_OP_DEQUEUE   =3D 12, /**< Dequeued for processing
> */
> +	/*                              13,      reserved for future */
> +	RTE_MBUF_HISTORY_OP_USR2      =3D 14, /**< Application-defined
> event 2 */
> +	RTE_MBUF_HISTORY_OP_USR1      =3D 15, /**< Application-defined
> event 1 */
> +	RTE_MBUF_HISTORY_OP_MAX       =3D 16, /**< Maximum number of
> operation types */
> +};

Suggest adding:
static_assert(RTE_MBUF_HISTORY_OP_MAX =3D=3D 1 << RTE_MBUF_HISTORY_BITS, =
"Enum vs bitsize mismatch");

> +
> +/**
> + * Global offset for the history dynamic field (set during
> initialization).
> + */
> +extern int rte_mbuf_history_field_offset;
> +
> +/**
> + * Initialize the mbuf history system.
> + *
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * This function registers the dynamic field for mbuf history
> tracking.
> + * It should be called once during application initialization.
> + *
> + * Note: This function is called by rte_pktmbuf_pool_create,
> + * so explicit invocation is usually not required.
> + */
> +__rte_experimental
> +void rte_mbuf_history_init(void);
> +
> +/**
> + * Mark an mbuf with a history event.
> + *
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * @param m
> + *   Pointer to the mbuf.
> + * @param op
> + *   The operation to record.
> + */
> +static inline void rte_mbuf_history_mark(struct rte_mbuf *m, uint32_t
> op)

Fix:
uint32_t op -> enum rte_mbuf_history_op op

> +{
> +#ifndef RTE_MBUF_HISTORY_DEBUG
> +	RTE_SET_USED(m);
> +	RTE_SET_USED(op);
> +#else
> +	RTE_ASSERT(rte_mbuf_history_field_offset >=3D 0);
> +	RTE_ASSERT(op < RTE_MBUF_HISTORY_OP_MAX);
> +	if (unlikely(m =3D=3D NULL))
> +		return;
> +
> +	rte_mbuf_history_t *history_field =3D RTE_MBUF_DYNFIELD(m,
> +			rte_mbuf_history_field_offset, rte_mbuf_history_t *);
> +	uint64_t old_history =3D rte_atomic_load_explicit(history_field,
> +			rte_memory_order_acquire);
> +	uint64_t new_history;
> +	do {
> +		new_history =3D (old_history << RTE_MBUF_HISTORY_BITS) | op;
> +	} while
> (unlikely(!rte_atomic_compare_exchange_weak_explicit(history_field,
> +			&old_history, new_history,
> +			rte_memory_order_release,
> rte_memory_order_acquire)));
> +#endif
> +}
> +
> +/**
> + * Mark multiple mbufs with a history event.
> + *
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * @param mbufs
> + *   Array of mbuf pointers.
> + * @param n
> + *   Number of mbufs to mark.
> + * @param op
> + *   The operation to record.
> + */
> +static inline void rte_mbuf_history_mark_bulk(struct rte_mbuf * const
> *mbufs,
> +		uint32_t n, uint32_t op)

Fix:
uint32_t n -> unsigned int count (for consistency)
uint32_t op -> enum rte_mbuf_history_op op

> +{
> +#ifndef RTE_MBUF_HISTORY_DEBUG
> +	RTE_SET_USED(mbufs);
> +	RTE_SET_USED(n);
> +	RTE_SET_USED(op);
> +#else
> +	RTE_ASSERT(rte_mbuf_history_field_offset >=3D 0);
> +	RTE_ASSERT(op < RTE_MBUF_HISTORY_OP_MAX);
> +	if (unlikely(mbufs =3D=3D NULL))
> +		return;
> +
> +	while (n--)
> +		rte_mbuf_history_mark(*mbufs++, op);
> +#endif
> +}
> +
> +/**
> + * Dump mbuf history for a single mbuf to a file.
> + *
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * @param f
> + *   File pointer to write the history to.
> + * @param m
> + *   Pointer to the mbuf to dump history for.
> + */
> +__rte_experimental
> +void rte_mbuf_history_dump(FILE *f, const struct rte_mbuf *m);
> +
> +/**
> + * Dump mbuf history statistics for a single mempool to a file.
> + *
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * @param f
> + *   File pointer to write the history statistics to.
> + * @param mp
> + *   Pointer to the mempool to dump history for.
> + */
> +__rte_experimental
> +void rte_mbuf_history_dump_mempool(FILE *f, struct rte_mempool *mp);
> +
> +/**
> + * Dump mbuf history statistics for all mempools to a file.
> + *
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * @param f
> + *   File pointer to write the history statistics to.
> + */
> +__rte_experimental
> +void rte_mbuf_history_dump_all(FILE *f);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* _RTE_MBUF_HISTORY_H_ */
> --
> 2.51.0

With fixes (suggestions optional),
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

