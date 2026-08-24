Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8313C5DF81
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 11:16:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B9AA4027C;
	Mon, 24 Aug 2026 13:16:49 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C242840270
 for <dev@dpdk.org>; Mon, 24 Aug 2026 13:16:47 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O9C5tp3558954; Mon, 24 Aug 2026 04:16:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=X
 +kjK2GqXQDtLtkHTOu5K7pLyY+PKY9x25lii6oGyW8=; b=Ucfk49hwFvRnoF4ZY
 qUBrNqKmPhx9xtv/CKVqKBToks+CqKN4WO4m7MjoUxQC1KC8TqEkJ/Y3BGSlKYfg
 KDElgnTULyBepqPgd8/I+cxF+fwhxvxvaEy1kBC9NPNbL+yPJEqyKXhTEmaaYiZc
 IRsAd44QMcqm1H+/q6TvnAtuqiEzrdK6oWHAWP+Jd544BvsCtpogsJd4O7HB33ae
 uPIjT8KNbQLYZcGpBhXoCua0LQlHl+C5m+dpHXWKBmfM2LGKM4+v9kCj8YZ1mCVN
 a9PU5kOQj++TtpACWhNze/6X0WY8KTOwwSaM32EhQGlE7B1OuPbxzJV3eFHbxP+Z
 fgwZw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g7vh730mh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 04:16:41 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 24 Aug 2026 04:16:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 24 Aug 2026 04:16:40 -0700
Received: from cavium-System-Product-Name (unknown [10.28.37.22])
 by maili.marvell.com (Postfix) with ESMTP id 8AC5B3F704A;
 Mon, 24 Aug 2026 04:16:37 -0700 (PDT)
From: <kirankumark@marvell.com>
To: <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <kirankumark@marvell.com>,
 <ndabilpuram@marvell.com>, <rjarry@redhat.com>,
 <saeed.bishara.os@gmail.com>, <yanzhirun_163@163.com>
Subject: Re: [PATCH v17] graph: add optional profiling stats
Date: Mon, 24 Aug 2026 16:45:51 +0530
Message-ID: <20260824111606.779723-1-kirankumark@marvell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260823150127.490511-1-mb@smartsharesystems.com>
References: <20260823150127.490511-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfXyNXwWUqpGdrG
 mlGsgryju9loRUM78NvcgCxKBH3joVd4sXo3xHls4qh7l1Cr6HVqjFiROsqKVegtm7HysWR+vvk
 rQ+DpSe9LyVAFQQQ5vYTCtrLvc63HZI=
X-Authority-Analysis: v=2.4 cv=QJJYgALL c=1 sm=1 tr=0 ts=6a8c2819 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=n02bokGJAAAA:8
 a=M5GUcnROAAAA:8 a=qFRY1RMjrgApbiNSp8IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rszdq1ld3peujIA30KyE:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfX2kI3fLLprK3u
 n3UK7f7CudvcR38FbRIQuXWVx4JFCS6KrIfFKoTdSpXx3W/evmipFfLvas99o13HYhoRC6P/9Cg
 fWe4RO1t+bM1RU541d1HPx379NceLWtlP+OA4+B+9+2lopkeJgsIEepoAxYlT4A8TMphTuqJZ3F
 0/5UGzhYfvgUNtrLgdGdyz9dqbknOTB0LBZv+tb3nOQmhPG9RPjX4BOQNcDYjSpe00cgl5ms7qe
 Y3CBpWDIsWTHNP5DECw9FXTcXM4aW90gX4MmH34k08RM+jTyYUSc/rt8XjSItEcITbVGUfNGBjT
 4s+rcCo2O3QSk7e5EqQ3Oh14GVEw67+pShoG1FIZ7rAPxCtYT76OTNCnarKxNFUXqvVPRAYGgwp
 U9kJZ3P18ERWxFgZgrUyUPmkrM6rl0ickYSqfw1RThnrcl4NHJFahbc5KaednylWO4BmPlxOcBH
 ZMcZZNwXn0Sp9hpDSJw==
X-Proofpoint-GUID: 45Q6A-mxekLDHOuzCPoySWl3yLUyh_dj
X-Proofpoint-ORIG-GUID: 45Q6A-mxekLDHOuzCPoySWl3yLUyh_dj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
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

On Sun, Aug 23, 2026 at 03:01:27PM +0000, Morten Brørup wrote:
> Added graph node profiling stats, build time configurable by enabling
> RTE_GRAPH_PROFILE in rte_config.h.
>
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> ---

Acked-by: Kiran Kumar Kokkilagadda <kirankumark@marvell.com>

> v17:
> * Snapshot cycles as positive number, and subtract after processing.
>   (Robin Jarry)
> v16:
> * Refactored range bucketing for clarity and performance. (AI)
> v15:
> * Used the term "ranges" instead of "intervals". (AI)
> * Described the last range as "%u+" instead of "[%u;[".
>   Correct would be "[%u;+∞[", but prefer ASCII here.
> v14:
> * Changed some minor details suggested by AI.
> v13:
> * Fixed cache alignment; array should be aligned, not struct.
> * Changed some minor details suggested by AI.
> v12:
> * Multiply printed percent values by 100.0. (AI)
> * Added to release note that this feature is disabled by default. (AI)
> v11:
> * Fixed signedness comparison and copy-paste bug.
> v10:
> * Use intervals instead of point samples. (Robin Jarry)
> * Do not double-indent printf continuations.
>   Follows existing coding style in the file, and
>   avoids a long line warning from checkpatch.
> * Rebased.
>   Moved release note to 26.11 file.
> v9:
> * Fixed comment still mentioning 32 objects.
> * Moved sample size array outside loop. (AI)
> * Added release note. (AI)
> v8:
> * Added static const array as local variable, instead of indexing directly
>   into const array. (AI)
>   This also eliminates the space required between "} [idx];" weirdness.
> * Added build time configurable RTE_GRAPH_PROFILE_BURST_SIZE to replace
>   the hardcoded burst size of 32. (AI)
> v7:
> * Use RTE_DIM() in histogram for loop.
> * Added static_assert for histogram index values.
> * Minor details to please checkpatch.
>   Although I disagree with requiring a space when indexing into
>   a constant array "(const type []){values} [idx];",
>   I have changed the code to comply.
> v6:
> * Consolidate the four histogram entries into one array. (Saeed Bishara)
> * Sample at 32 objs instead of a half burst. (Saeed Bishara)
> * Moved stats to different location in rte_node structure. (Jerin)
> * Minor details to please checkpatch.
> v5:
> * Added stats for a half burst and a full burst.
> v4:
> * Added documentation. (AI)
> * Added more comments. (AI)
> * Improved dump. (AI)
> * Debug shows both cycles/call and cycles/obj.
> v3:
> * Debug shows cycles/obj instead of cycles/call.
> * Fixed missing --in-reply-to.
> v2:
> * Fixed indentation.
> ---
>  config/rte_config.h                    |  4 ++
>  doc/guides/prog_guide/graph_lib.rst    |  5 ++
>  doc/guides/rel_notes/release_26_11.rst |  9 ++++
>  lib/graph/graph_debug.c                | 67 ++++++++++++++++++++++++++
>  lib/graph/node.c                       |  2 +
>  lib/graph/rte_graph_worker_common.h    | 57 ++++++++++++++++++++--
>  6 files changed, 141 insertions(+), 3 deletions(-)
>
> diff --git a/config/rte_config.h b/config/rte_config.h
> index 0447cdf2ad..6beee01b09 100644
> --- a/config/rte_config.h
> +++ b/config/rte_config.h
> @@ -106,6 +106,10 @@
>  /* rte_graph defines */
>  #define RTE_GRAPH_BURST_SIZE 256
>  #define RTE_LIBRTE_GRAPH_STATS 1
> +/* RTE_GRAPH_PROFILE is not set */
> +#define RTE_GRAPH_PROFILE_BURST_SMALL 8
> +#define RTE_GRAPH_PROFILE_BURST_MEDIUM 32
> +#define RTE_GRAPH_PROFILE_BURST_LARGE RTE_GRAPH_BURST_SIZE
>
>  /****** driver defines ********/
>
> diff --git a/doc/guides/prog_guide/graph_lib.rst b/doc/guides/prog_guide/graph_lib.rst
> index 1c2cd1ef31..aa5faf4e82 100644
> --- a/doc/guides/prog_guide/graph_lib.rst
> +++ b/doc/guides/prog_guide/graph_lib.rst
> @@ -49,6 +49,11 @@ Performance tuning parameters
>    RTE_GRAPH_BURST_SIZE config option.
>    The testing shows, on x86 and arm64 servers, The sweet spot is 256 burst
>    size. While on arm64 embedded SoCs, it is either 64 or 128.
> +- Enable the ``RTE_GRAPH_PROFILE`` config option for more profiling details
> +  (disabled by default).
> +  Set the ``RTE_GRAPH_PROFILE_BURST_SMALL``, ``RTE_GRAPH_PROFILE_BURST_MEDIUM``,
> +  and ``RTE_GRAPH_PROFILE_BURST_LARGE`` config options to sample specific
> +  burst size ranges.
>  - Disable node statistics (using ``RTE_LIBRTE_GRAPH_STATS`` config option)
>    if not needed.
>
> diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
> index c8cc86295d..2c822b6eee 100644
> --- a/doc/guides/rel_notes/release_26_11.rst
> +++ b/doc/guides/rel_notes/release_26_11.rst
> @@ -55,6 +55,15 @@ New Features
>       Also, make sure to start the actual text at the margin.
>       =======================================================
>
> +* **Added optional graph profiling statistics.**
> +
> +  Added build time configurable graph node profiling statistics via
> +  ``RTE_GRAPH_PROFILE`` in ``rte_config.h`` (disabled by default). When enabled,
> +  tracks cycles spent processing various burst size ranges per node.
> +  The edges of the ranges are build time configurable via
> +  ``RTE_GRAPH_PROFILE_BURST_SMALL``, ``RTE_GRAPH_PROFILE_BURST_MEDIUM``, and
> +  ``RTE_GRAPH_PROFILE_BURST_LARGE`` in ``rte_config.h``.
> +
>
>  Removed Items
>  -------------
> diff --git a/lib/graph/graph_debug.c b/lib/graph/graph_debug.c
> index e3b8cccdc1..a2aef9918f 100644
> --- a/lib/graph/graph_debug.c
> +++ b/lib/graph/graph_debug.c
> @@ -60,6 +60,7 @@ rte_graph_obj_dump(FILE *f, struct rte_graph *g, bool all)
>  	rte_graph_off_t off;
>  	struct rte_node *n;
>  	rte_edge_t i;
> +	uint64_t all_total_cycles = 0;
>
>  	fprintf(f, "graph <%s> @ %p\n", g->name, g);
>  	fprintf(f, "  id=%" PRIu32 "\n", g->id);
> @@ -72,6 +73,12 @@ rte_graph_obj_dump(FILE *f, struct rte_graph *g, bool all)
>  	fprintf(f, "  nodes_start=0x%" PRIx32 "\n", g->nodes_start);
>  	fprintf(f, "  cir_start=%p\n", g->cir_start);
>
> +	rte_graph_foreach_node(count, off, g, n) {
> +		if (!all && n->idx == 0)
> +			continue;
> +		all_total_cycles += n->total_cycles;
> +	}
> +
>  	rte_graph_foreach_node(count, off, g, n) {
>  		if (!all && n->idx == 0)
>  			continue;
> @@ -93,6 +100,66 @@ rte_graph_obj_dump(FILE *f, struct rte_graph *g, bool all)
>  				n->dispatch.total_sched_fail);
>  		}
>  		fprintf(f, "       total_calls=%" PRId64 "\n", n->total_calls);
> +		if (rte_graph_has_stats_feature())
> +			fprintf(f, "       total_cycles=%" PRIu64 " (%.1f%% of all nodes), avg cycles/call=%.1f\n",
> +				n->total_cycles,
> +				all_total_cycles == 0 ? 0.0 :
> +				(double)n->total_cycles / (double)all_total_cycles * 100.0,
> +				n->total_calls == 0 ? 0.0 :
> +				(double)n->total_cycles / (double)n->total_calls);
> +
> +#ifdef RTE_GRAPH_PROFILE
> +		static const uint16_t sample_sizes[] = {
> +				0, 1, 2, RTE_GRAPH_PROFILE_BURST_SMALL,
> +				RTE_GRAPH_PROFILE_BURST_MEDIUM, RTE_GRAPH_PROFILE_BURST_LARGE};
> +		static_assert(RTE_DIM(sample_sizes) == 2U + RTE_DIM(n->usage_stats),
> +				"usage_stats array size mismatch");
> +		for (unsigned int idx = 0; idx < RTE_DIM(sample_sizes); idx++) {
> +			uint64_t calls;
> +			uint64_t cycles;
> +			double objs_per_call;
> +			if (idx < 2) {
> +				calls = n->usage_stats_01[idx].calls;
> +				cycles = n->usage_stats_01[idx].cycles;
> +				objs_per_call = (double)idx;
> +				fprintf(f, "       for %u objs/call\n",
> +					idx);
> +			} else {
> +				calls = n->usage_stats[idx - 2].calls;
> +				cycles = n->usage_stats[idx - 2].cycles;
> +				objs_per_call = calls == 0 ? 0.0 :
> +						(double)n->usage_stats[idx - 2].objs /
> +						(double)calls;
> +				if (idx < RTE_DIM(sample_sizes) - 1)
> +					fprintf(f, "       for [%u;%u[ objs/call",
> +						sample_sizes[idx], sample_sizes[idx + 1]);
> +				else
> +					fprintf(f, "       for %u+ objs/call",
> +						sample_sizes[idx]);
> +				if (calls != 0)
> +					fprintf(f, ", avg %.1f objs/call\n",
> +						objs_per_call);
> +				fprintf(f, "\n");
> +			}
> +			fprintf(f, "         calls=%" PRIu64,
> +				calls);
> +			if (calls != 0) {
> +				fprintf(f, " (%.1f%% of this node)\n",
> +					n->total_calls == 0 ? 0.0 :
> +					(double)calls / (double)n->total_calls * 100.0);
> +				fprintf(f, "         cycles=%" PRIu64 " (%.1f%% of this node), avg cycles/call=%.1f",
> +					cycles,
> +					n->total_cycles == 0 ? 0.0 :
> +					(double)cycles / (double)n->total_cycles * 100.0,
> +					(double)cycles / (double)calls);
> +				if (objs_per_call != 0.0)
> +					fprintf(f, ", avg cycles/obj=%.1f",
> +						(double)cycles / (double)calls / objs_per_call);
> +			}
> +			fprintf(f, "\n");
> +		}
> +#endif /* RTE_GRAPH_PROFILE */
> +
>  		for (i = 0; i < n->nb_edges; i++)
>  			fprintf(f, "          edge[%d] <%s>\n", i,
>  				n->nodes[i]->name);
> diff --git a/lib/graph/node.c b/lib/graph/node.c
> index 1fce3e6632..19b38881ae 100644
> --- a/lib/graph/node.c
> +++ b/lib/graph/node.c
> @@ -110,10 +110,12 @@ __rte_node_register(const struct rte_node_register *reg)
>  	rte_edge_t i;
>  	size_t sz;
>
> +#ifndef RTE_GRAPH_PROFILE
>  	/* Limit Node specific metadata to one cacheline on 64B CL machine */
>  	RTE_BUILD_BUG_ON((offsetof(struct rte_node, nodes) -
>  			  offsetof(struct rte_node, ctx)) !=
>  			 RTE_CACHE_LINE_MIN_SIZE);
> +#endif
>
>  	graph_spinlock_lock();
>
> diff --git a/lib/graph/rte_graph_worker_common.h b/lib/graph/rte_graph_worker_common.h
> index 4ab53a533e..89c1f3dbf9 100644
> --- a/lib/graph/rte_graph_worker_common.h
> +++ b/lib/graph/rte_graph_worker_common.h
> @@ -121,6 +121,27 @@ struct __rte_cache_aligned rte_node {
>  	rte_graph_off_t xstat_off; /**< Offset to xstat counters. */
>
>  	/** Fast path area cache line 2. */
> +#ifdef RTE_GRAPH_PROFILE
> +	/** Usage when this node processed 0 or 1 objects. */
> +	alignas(RTE_CACHE_LINE_MIN_SIZE)
> +	struct {
> +		uint64_t calls;     /**< Calls done. */
> +		uint64_t cycles;    /**< Cycles spent. */
> +	} usage_stats_01[2];
> +	/**
> +	 * Usage when this node processed N objects:
> +	 * - index 0 (micro): 2 <= N < RTE_GRAPH_PROFILE_BURST_SMALL
> +	 * - index 1 (small): RTE_GRAPH_PROFILE_BURST_SMALL <= N < RTE_GRAPH_PROFILE_BURST_MEDIUM
> +	 * - index 2 (medium): RTE_GRAPH_PROFILE_BURST_MEDIUM <= N < RTE_GRAPH_PROFILE_BURST_LARGE
> +	 * - index 3 (large): RTE_GRAPH_PROFILE_BURST_LARGE <= N
> +	 */
> +	struct {
> +		uint64_t calls;     /**< Calls done. */
> +		uint64_t cycles;    /**< Cycles spent. */
> +		uint64_t objs;      /**< Objects processed. */
> +	} usage_stats[4];
> +	/** Fast path area cache line 4. */
> +#endif
>  	__extension__ struct __rte_cache_aligned {
>  #define RTE_NODE_CTX_SZ 16
>  		union {
> @@ -148,8 +169,10 @@ struct __rte_cache_aligned rte_node {
>  	};
>  };
>
> +#ifndef RTE_GRAPH_PROFILE
>  static_assert(offsetof(struct rte_node, nodes) - offsetof(struct rte_node, ctx)
>  	== RTE_CACHE_LINE_MIN_SIZE, "rte_node fast path area must fit in 64 bytes");
> +#endif
>
>  /**
>   * @internal
> @@ -197,7 +220,7 @@ void __rte_node_stream_alloc_size(struct rte_graph *graph,
>  static __rte_always_inline void
>  __rte_node_process(struct rte_graph *graph, struct rte_node *node)
>  {
> -	uint64_t start;
> +	uint64_t cycles;
>  	uint16_t rc;
>  	void **objs;
>
> @@ -206,11 +229,39 @@ __rte_node_process(struct rte_graph *graph, struct rte_node *node)
>  	rte_prefetch0(objs);
>
>  	if (rte_graph_has_stats_feature()) {
> -		start = rte_rdtsc();
> +		cycles = rte_rdtsc();
>  		rc = node->process(graph, node, objs, node->idx);
> -		node->total_cycles += rte_rdtsc() - start;
> +		cycles = rte_rdtsc() - cycles;
> +		node->total_cycles += cycles;
>  		node->total_calls++;
>  		node->total_objs += rc;
> +#ifdef RTE_GRAPH_PROFILE
> +		static_assert(RTE_GRAPH_PROFILE_BURST_SMALL >= 2,
> +			"BURST_SMALL must be >= 2");
> +		static_assert(RTE_GRAPH_PROFILE_BURST_SMALL < RTE_GRAPH_PROFILE_BURST_MEDIUM,
> +			"BURST_SMALL must be < BURST_MEDIUM");
> +		static_assert(RTE_GRAPH_PROFILE_BURST_MEDIUM < RTE_GRAPH_PROFILE_BURST_LARGE,
> +			"BURST_MEDIUM must be < BURST_LARGE");
> +		if (rc < 2) {
> +			node->usage_stats_01[rc].calls++;
> +			node->usage_stats_01[rc].cycles += cycles;
> +		} else {
> +			unsigned int index;
> +
> +			if (rc >= RTE_GRAPH_PROFILE_BURST_LARGE)
> +				index = 3;
> +			else if (rc >= RTE_GRAPH_PROFILE_BURST_MEDIUM)
> +				index = 2;
> +			else if (rc >= RTE_GRAPH_PROFILE_BURST_SMALL)
> +				index = 1;
> +			else
> +				index = 0;
> +
> +			node->usage_stats[index].calls++;
> +			node->usage_stats[index].cycles += cycles;
> +			node->usage_stats[index].objs += rc;
> +		}
> +#endif
>  	} else {
>  		node->process(graph, node, objs, node->idx);
>  	}
> --
> 2.43.0
