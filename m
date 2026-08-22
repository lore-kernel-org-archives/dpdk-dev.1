Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC728C5DF97
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Aug 2026 09:52:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E6FF4027B;
	Sat, 22 Aug 2026 11:52:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 217F34025F
 for <dev@dpdk.org>; Sat, 22 Aug 2026 11:52:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787392368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6WzXAz2XD2PtaxkDL/A51QlMC3cCNwAkSpavcPuYY78=;
 b=ekZr3B4UO7LqYWPwbLhjQRT/mB1OYrINB1icdfghGWvmt3dkTPTYYIxq5aoaSrmikg+oa/
 xDe80m5u0JydsTnpZLXERrfxvcwAQu8FSiac8dKEfiKsK5ctNFEzYK2XoJT/2KMKkDXa6Y
 QcOtUsxSq8jOYGhtaspQDmsJxZ1CzpI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-P8wv6HYtP7qbJE_izPSCDQ-1; Sat, 22 Aug 2026 05:52:46 -0400
X-MC-Unique: P8wv6HYtP7qbJE_izPSCDQ-1
X-Mimecast-MFC-AGG-ID: P8wv6HYtP7qbJE_izPSCDQ_1787392366
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-482bf4da3d5so1042128f8f.1
 for <dev@dpdk.org>; Sat, 22 Aug 2026 02:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787392365; x=1787997165;
 h=in-reply-to:references:user-agent:subject:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=URZqVrpHIfQcYfO+st+gUt846xJ2Al0QF+KPEF4t6yE=;
 b=G4qisFhZvCwBPERPBfMFC+i90JYwVYDbZCFiQQ27PbYIJbShIP+bt4hwqiyQd4fVUD
 0Ot/ozumwVUdr1nA6evNGujkZ8VUI4f73/LlRnqsNQRIhxL4YDxu0mi69tO1O+grXlKG
 wdjnxmNMEGBg/FbP0YdmPm1kA4igpsjvYsX0z8wJUVfD0q1qj4oHDFyiPkt+TUhVbzXy
 B+AHL5suDwHLC7OWu8kxm2Fns6iCZ0sHXh2E+yZNULFhGc+6B0GE5y4jHYC706QBZFLA
 Ds4braRs2C6GjkI0TOeoROo4lzI7nos85QSwX+KaKp0S1sUMxQXUAof+wdIaD1EQ81bL
 1X/w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpzHnQQ+ZsVHgSlMlvEGVOIpHBreBNFMecTg/bKYK8W8TZp+yOCYJfO9wjEZVILK/BXNeQ=@dpdk.org
X-Gm-Message-State: AFuF++ncOrDCDG7hu7Xe8x9HNBW+qKRFTgg9LFjlB8ohJzWQV1cAnnXn
 pTe2iUjrUNsAukxBiksLTv1qvtXXMZQ7x4PB4bTTOlvCjnQyvWDahEJ4Ctexj3JalWuLvsz/hIw
 EwL6x3AR3pCKzKSUmLVmHahMfasTmUJGIxk4ABNFdC7BU
X-Gm-Gg: AR+sD13JlIm19Gpz06Wsg7+n3iVE5+lOK3B5ddxI0TInECrPjCyB/eJl4401xyMU5GM
 q66vTD5vCOz0+Tn9qY0ijTluRqw75oLgdhSpKC8IfT0M1UU1cCOYK9FS01UO9Fz2aJojyu/NQO2
 qAIvHilrJYHD0Wt5+VpUY65p8okX1+1lX1fcMRxgebvhfxH9bnr7V5z6MNcSdosvGv4bsTv4wfQ
 g0QV7Wa8kvc4C/BHwTOqjChCThdzG0cx6jmR9JA3pUnTdAWWEWoAEPGey+W8P7MOjyrEdybjeqJ
 1iVUGZGHpQnYBJk+e34utrNuw5JdRfwgmjsq9RrQGV6EdVktg8wFRtkJJUUMnHiDdCO8m5nBjUK
 mWvzDHsYw+ZF8zJ3ulSI0MmoRYi0xqwtHgMOr62cKD00M5ALIh6deRtcUF0M=
X-Received: by 2002:a05:600c:468f:b0:499:7ce1:d8a2 with SMTP id
 5b1f17b1804b1-499c19d0541mr33545925e9.8.1787392365612; 
 Sat, 22 Aug 2026 02:52:45 -0700 (PDT)
X-Received: by 2002:a05:600c:468f:b0:499:7ce1:d8a2 with SMTP id
 5b1f17b1804b1-499c19d0541mr33545715e9.8.1787392365103; 
 Sat, 22 Aug 2026 02:52:45 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002fb5ec50e5a775d4.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2fb5:ec50:e5a7:75d4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499c01b90casm18374335e9.2.2026.08.22.02.52.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Aug 2026 02:52:43 -0700 (PDT)
Mime-Version: 1.0
Date: Sat, 22 Aug 2026 11:52:42 +0200
Message-Id: <DKVDPNOPM64I.DMED3KJABMT@redhat.com>
From: "Robin Jarry" <rjarry@redhat.com>
To: =?utf-8?q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 <dev@dpdk.org>, "Jerin Jacob" <jerinj@marvell.com>, "Kiran Kumar K"
 <kirankumark@marvell.com>, "Nithin Dabilpuram" <ndabilpuram@marvell.com>,
 "Zhirun Yan" <yanzhirun_163@163.com>, "Saeed Bishara"
 <saeed.bishara.os@gmail.com>
Subject: Re: [PATCH v9] graph: add optional profiling stats
User-Agent: aerc/0.22.0-10-g64898b456260-dirty
References: <20260619202047.2809165-1-mb@smartsharesystems.com>
 <20260703154357.3068739-1-mb@smartsharesystems.com>
In-Reply-To: <20260703154357.3068739-1-mb@smartsharesystems.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: A_j-MWU0drnIN7KTYQq_8IVon_cXQnFDoRMC7OJzvP8_1787392366
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

Hey Morten,

I have some concerns with the "histogram" implementation. There are
holes in the data. You will only capture specific batch sizes.

NB: did you notice we already have a burst size histogram exported in
the grout metrics:

https://github.com/DPDK/grout/blob/v0.17.1/modules/infra/api/stats.c#L313-L=
336

Morten Br=C3=B8rup, Jul 03, 2026 at 17:43:
> graph: add optional profiling stats
>
> Added graph node profiling stats, build time configurable by enabling
> RTE_GRAPH_PROFILE in rte_config.h.
>
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> ---
> v9:
> * Fixed comment still mentioning 32 objects.
> * Moved sample size array outside loop. (AI)
> * Added release note. (AI)
> v8:
> * Added static const array as local variable, instead of indexing directl=
y
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
>  config/rte_config.h                    |  2 ++
>  doc/guides/prog_guide/graph_lib.rst    |  3 ++
>  doc/guides/rel_notes/release_26_07.rst |  7 ++++
>  lib/graph/graph_debug.c                | 50 ++++++++++++++++++++++++++
>  lib/graph/node.c                       |  2 ++
>  lib/graph/rte_graph_worker_common.h    | 32 +++++++++++++++--
>  6 files changed, 93 insertions(+), 3 deletions(-)
>
> diff --git a/config/rte_config.h b/config/rte_config.h
> index 0447cdf2ad..7703a6325b 100644
> --- a/config/rte_config.h
> +++ b/config/rte_config.h
> @@ -106,6 +106,8 @@
>  /* rte_graph defines */
>  #define RTE_GRAPH_BURST_SIZE 256
>  #define RTE_LIBRTE_GRAPH_STATS 1
> +/* RTE_GRAPH_PROFILE is not set */
> +#define RTE_GRAPH_PROFILE_BURST_SIZE 32
> =20
>  /****** driver defines ********/
> =20
> diff --git a/doc/guides/prog_guide/graph_lib.rst b/doc/guides/prog_guide/=
graph_lib.rst
> index 8dd49c19d2..4311c37cc2 100644
> --- a/doc/guides/prog_guide/graph_lib.rst
> +++ b/doc/guides/prog_guide/graph_lib.rst
> @@ -49,6 +49,9 @@ Performance tuning parameters
>    RTE_GRAPH_BURST_SIZE config option.
>    The testing shows, on x86 and arm64 servers, The sweet spot is 256 bur=
st
>    size. While on arm64 embedded SoCs, it is either 64 or 128.
> +- Enable the ``RTE_GRAPH_PROFILE`` config option for more profiling deta=
ils.
> +  Set the ``RTE_GRAPH_PROFILE_BURST_SIZE`` config option to sample a spe=
cific
> +  burst size.
>  - Disable node statistics (using ``RTE_LIBRTE_GRAPH_STATS`` config optio=
n)
>    if not needed.
> =20
> diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_note=
s/release_26_07.rst
> index 8b1bdada1a..cb7d48eeac 100644
> --- a/doc/guides/rel_notes/release_26_07.rst
> +++ b/doc/guides/rel_notes/release_26_07.rst
> @@ -83,6 +83,13 @@ New Features
>    * The size of the ``struct rte_mempool_cache`` was kept
>      for API/ABI compatibility purposes.
> =20
> +* **Added optional graph profiling statistics.**
> +
> +  Added build-time configurable graph node profiling statistics via
> +  ``RTE_GRAPH_PROFILE`` in ``rte_config.h``. When enabled, tracks cycles
> +  spent processing bursts of 0, 1, ``RTE_GRAPH_PROFILE_BURST_SIZE``,
> +  and ``RTE_GRAPH_BURST_SIZE`` objects per node.
> +
>  * **Added RISC-V vector paths.**
> =20
>    * Increased the default SIMD bitwidth to allow using the vector extens=
ion.
> diff --git a/lib/graph/graph_debug.c b/lib/graph/graph_debug.c
> index e3b8cccdc1..b999fa4140 100644
> --- a/lib/graph/graph_debug.c
> +++ b/lib/graph/graph_debug.c
> @@ -93,6 +93,56 @@ rte_graph_obj_dump(FILE *f, struct rte_graph *g, bool =
all)
>  =09=09=09=09n->dispatch.total_sched_fail);
>  =09=09}
>  =09=09fprintf(f, "       total_calls=3D%" PRId64 "\n", n->total_calls);
> +=09=09if (rte_graph_has_stats_feature())
> +=09=09=09fprintf(f, "       total_cycles=3D%" PRIu64 ", avg cycles/call=
=3D%.1f\n",
> +=09=09=09=09=09n->total_cycles,
> +=09=09=09=09=09n->total_calls =3D=3D 0 ? 0.0 :
> +=09=09=09=09=09(double)n->total_cycles / (double)n->total_calls);
> +#ifdef RTE_GRAPH_PROFILE
> +=09=09static const uint16_t profile_sample_sizes[] =3D {
> +=09=09=09=090, 1, RTE_GRAPH_PROFILE_BURST_SIZE, RTE_GRAPH_BURST_SIZE};
> +=09=09static_assert(RTE_DIM(profile_sample_sizes) =3D=3D RTE_DIM(n->usag=
e_stats),
> +=09=09=09=09"usage_stats array size mismatch");
> +=09=09int64_t calls_other =3D n->total_calls;
> +=09=09int64_t cycles_other =3D n->total_cycles;
> +=09=09int64_t objs_other =3D n->total_objs;
> +=09=09for (int idx =3D 0; idx < RTE_DIM(n->usage_stats) + 1; idx++) {
> +=09=09=09uint64_t calls;
> +=09=09=09uint64_t cycles;
> +=09=09=09double objs_per_call;
> +=09=09=09if (idx < RTE_DIM(n->usage_stats)) {
> +=09=09=09=09uint16_t idx_objs =3D profile_sample_sizes[idx];
> +=09=09=09=09fprintf(f, "       objs[%u]\n", idx_objs);
> +=09=09=09=09calls =3D n->usage_stats[idx].calls;
> +=09=09=09=09cycles =3D n->usage_stats[idx].cycles;
> +=09=09=09=09objs_per_call =3D (double)idx_objs;
> +=09=09=09=09calls_other -=3D calls;
> +=09=09=09=09cycles_other -=3D cycles;
> +=09=09=09=09objs_other -=3D idx_objs * calls;
> +=09=09=09} else {
> +=09=09=09=09fprintf(f, "       objs[other]\n");
> +=09=09=09=09if (calls_other > 0 && cycles_other > 0 && objs_other > 0) {
> +=09=09=09=09=09calls =3D calls_other;
> +=09=09=09=09=09cycles =3D cycles_other;
> +=09=09=09=09=09objs_per_call =3D (double)objs_other / (double)calls_othe=
r;
> +=09=09=09=09=09fprintf(f, "         avg objs/call=3D%.1f\n", objs_per_ca=
ll);
> +=09=09=09=09} else {
> +=09=09=09=09=09calls =3D 0;
> +=09=09=09=09=09cycles =3D 0;
> +=09=09=09=09=09objs_per_call =3D 0.0;
> +=09=09=09=09}
> +=09=09=09}
> +=09=09=09fprintf(f, "         calls=3D%" PRIu64, calls);
> +=09=09=09if (calls !=3D 0)
> +=09=09=09=09fprintf(f, ", cycles=3D%" PRIu64 ", avg cycles/call=3D%.1f",
> +=09=09=09=09=09=09cycles,
> +=09=09=09=09=09=09(double)cycles / (double)calls);
> +=09=09=09if (calls !=3D 0 && objs_per_call !=3D 0.0)
> +=09=09=09=09fprintf(f, ", avg cycles/obj=3D%.1f",
> +=09=09=09=09=09=09(double)cycles / (double)calls / objs_per_call);
> +=09=09=09fprintf(f, "\n");
> +=09=09}
> +#endif
>  =09=09for (i =3D 0; i < n->nb_edges; i++)
>  =09=09=09fprintf(f, "          edge[%d] <%s>\n", i,
>  =09=09=09=09n->nodes[i]->name);
> diff --git a/lib/graph/node.c b/lib/graph/node.c
> index 1fce3e6632..19b38881ae 100644
> --- a/lib/graph/node.c
> +++ b/lib/graph/node.c
> @@ -110,10 +110,12 @@ __rte_node_register(const struct rte_node_register =
*reg)
>  =09rte_edge_t i;
>  =09size_t sz;
> =20
> +#ifndef RTE_GRAPH_PROFILE
>  =09/* Limit Node specific metadata to one cacheline on 64B CL machine */
>  =09RTE_BUILD_BUG_ON((offsetof(struct rte_node, nodes) -
>  =09=09=09  offsetof(struct rte_node, ctx)) !=3D
>  =09=09=09 RTE_CACHE_LINE_MIN_SIZE);
> +#endif
> =20
>  =09graph_spinlock_lock();
> =20
> diff --git a/lib/graph/rte_graph_worker_common.h b/lib/graph/rte_graph_wo=
rker_common.h
> index 4ab53a533e..00e8f5859d 100644
> --- a/lib/graph/rte_graph_worker_common.h
> +++ b/lib/graph/rte_graph_worker_common.h
> @@ -121,6 +121,17 @@ struct __rte_cache_aligned rte_node {
>  =09rte_graph_off_t xstat_off; /**< Offset to xstat counters. */
> =20
>  =09/** Fast path area cache line 2. */
> +#ifdef RTE_GRAPH_PROFILE
> +=09/**
> +=09 * Usage when this node processed 0, 1, RTE_GRAPH_PROFILE_BURST_SIZE,
> +=09 * or RTE_GRAPH_BURST_SIZE objects.
> +=09 */
> +=09struct __rte_cache_aligned {
> +=09=09uint64_t calls;     /**< Calls done. */
> +=09=09uint64_t cycles;    /**< Cycles spent. */
> +=09} usage_stats[4];
> +=09/** Fast path area cache line 3. */
> +#endif
>  =09__extension__ struct __rte_cache_aligned {
>  #define RTE_NODE_CTX_SZ 16
>  =09=09union {
> @@ -148,8 +159,10 @@ struct __rte_cache_aligned rte_node {
>  =09};
>  };
> =20
> +#ifndef RTE_GRAPH_PROFILE
>  static_assert(offsetof(struct rte_node, nodes) - offsetof(struct rte_nod=
e, ctx)
>  =09=3D=3D RTE_CACHE_LINE_MIN_SIZE, "rte_node fast path area must fit in =
64 bytes");
> +#endif
> =20
>  /**
>   * @internal
> @@ -197,7 +210,7 @@ void __rte_node_stream_alloc_size(struct rte_graph *g=
raph,
>  static __rte_always_inline void
>  __rte_node_process(struct rte_graph *graph, struct rte_node *node)
>  {
> -=09uint64_t start;
> +=09uint64_t cycles;
>  =09uint16_t rc;
>  =09void **objs;
> =20
> @@ -206,11 +219,24 @@ __rte_node_process(struct rte_graph *graph, struct =
rte_node *node)
>  =09rte_prefetch0(objs);
> =20
>  =09if (rte_graph_has_stats_feature()) {
> -=09=09start =3D rte_rdtsc();
> +=09=09cycles =3D -rte_rdtsc();

I presume this works but it feels confusing taking a "negative" value of
an unsigned integer.

>  =09=09rc =3D node->process(graph, node, objs, node->idx);
> -=09=09node->total_cycles +=3D rte_rdtsc() - start;
> +=09=09cycles +=3D rte_rdtsc();
> +=09=09node->total_cycles +=3D cycles;
>  =09=09node->total_calls++;
>  =09=09node->total_objs +=3D rc;
> +#ifdef RTE_GRAPH_PROFILE
> +=09=09if (rc <=3D 1) {
> +=09=09=09node->usage_stats[rc].calls++;
> +=09=09=09node->usage_stats[rc].cycles +=3D cycles;
> +=09=09} else if (rc =3D=3D RTE_GRAPH_PROFILE_BURST_SIZE) {
> +=09=09=09node->usage_stats[2].calls++;
> +=09=09=09node->usage_stats[2].cycles +=3D cycles;
> +=09=09} else if (rc =3D=3D RTE_GRAPH_BURST_SIZE) {
> +=09=09=09node->usage_stats[3].calls++;
> +=09=09=09node->usage_stats[3].cycles +=3D cycles;

If you want a reliable histogram, you would need to change these tests
to the following:

=09=09id (rc >=3D RTE_GRAPH_BURST_SIZE) {
=09=09=09node->usage_stats[3].calls++;
=09=09=09node->usage_stats[3].cycles +=3D cycles;
=09=09} else if (rc >=3D RTE_GRAPH_PROFILE_BURST_SIZE) {
=09=09=09node->usage_stats[2].calls++;
=09=09=09node->usage_stats[2].cycles +=3D cycles;
=09=09} else if (rc !=3D 0) {
=09=09=09node->usage_stats[1].calls++;
=09=09=09node->usage_stats[1].cycles +=3D cycles;
=09=09} else {
=09=09=09node->usage_stats[0].calls++;
=09=09=09node->usage_stats[0].cycles +=3D cycles;
=09=09}

Otherwise, you will miss lots of odd-sized batches in your histogram
data.


> +=09=09}
> +#endif
>  =09} else {
>  =09=09node->process(graph, node, objs, node->idx);
>  =09}


--=20
Robin

# Not a flying toy.

