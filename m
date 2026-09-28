Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A886C9832F
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 06:52:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 350C0402A4;
	Mon, 28 Sep 2026 08:52:08 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D4B8C40269
 for <dev@dpdk.org>; Mon, 28 Sep 2026 08:52:05 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68RJsmjM3399714; Sun, 27 Sep 2026 23:51:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=F
 ixh6snWX3N7cSWLr2naCJGM9Lbn9pHYSDGrX5Dn7BI=; b=BZPW0E3qD8tn/8Kcm
 M8RdhTkqK861XCb9oENs7idCbKK2ERPMFFSjE/JlL35H7GZh9/vVfP5Z5B34Rdd/
 qMY7UuzWBXA7d8W7LR/FSKEI+wRy9xtY12Vk56RVRkefQcW4iN96Bv/HJKfZSs8e
 +THSbLw8dic82Fn6x+pCdBalVlTMaRzI72wku9OwIFDdndLmTutuftuLeD0TgwpQ
 miARfgtA1zdOJwwsNRf8l1fK+hi8VMvq0leYHGAIbjbF5gNSvREP/dwTPTurCy6N
 SGzIscSp5haPNKYPXyo1M2ytWNhhRjs1EXQUyUuK8K7asgqzHluTCyXMi4BtYdow
 lZ50g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gxx2cjcj5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 27 Sep 2026 23:51:56 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 27 Sep 2026 23:51:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 27 Sep 2026 23:51:54 -0700
Received: from cavium-System-Product-Name (unknown [10.28.37.22])
 by maili.marvell.com (Postfix) with ESMTP id 09AC63F706C;
 Sun, 27 Sep 2026 23:51:48 -0700 (PDT)
From: <kirankumark@marvell.com>
To: <kirankumark@marvell.com>, Robin Jarry <rjarry@redhat.com>
CC: <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>, Zhirun Yan <yanzhirun_163@163.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, Christophe Fontaine
 <cfontain@redhat.com>, David Marchand <david.marchand@redhat.com>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>, Maxime Leroy
 <maxime@leroys.fr>
Subject: Re: [PATCH dpdk/26.11 v3 2/2] graph: replace circular buffer with
 topological bitmap
Date: Mon, 28 Sep 2026 12:21:28 +0530
Message-ID: <20260928065128.1936818-1-kirankumark@marvell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260717090326.1860634-3-rjarry@redhat.com> (raw)
References: <20260717090326.1860634-3-rjarry@redhat.com> (raw)
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyNiBTYWx0ZWRfX1EZox5WqAQRs
 f9G4qRQCZ8UXo+kBH8GM/iGUQTfqIQtmbxwbVtaIA2umLf27GVUwCU3wF2+ZO+mEfL5vQMluO3y
 WU6kGrIxh49dcZk04zSo+FJNlRijWs/zMnDqfbpeTSwXUHFMEIGz2fbFn407c3MplgGU3oumrRW
 bCg7RIJ8ZSz0yVN5LKx+CArJKcYgCbwWq3WX36HJ/cDs+ep5nMqnSdxzXcyS+jg59SoNwFj8cvW
 a8/0ZvPLfGhlpny+zKmqoZKXbm4TzPGq3o+DWXJZbPRcIGzn6ibhiSVR2iECXyHRUlfO4aKTgQU
 RH4fUvb3MCT1Fd7oTnxJKrvfFzlxSwFwfM6jbEjyZV7IDkCD2KRpRx0HezlnG6yZRCcSl4AYkK0
 tcDIPpmMXyIyVVcWpsxVTIxIl8bw41WXY69SxO9ZVW5nJdMktE6sRPcfti9N/3u+WvP0fm8j1iQ
 ERCDR58AdQAXtG+DBZg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyNiBTYWx0ZWRfX7imhsdgAglDU
 3IsmEIzRjR/BCW3XGB5jm8wyIgMucnuBDTOcfpYMkjtmjGLQqFyrUm6jwiE537G6mZuV2r6rw+s
 iT4B4i1LSW+0notoJOGfLAu2KN17KUQ=
X-Proofpoint-GUID: ivRjCFsgEa33aIuUMmC4Edo57YxMsmHm
X-Authority-Analysis: v=2.4 cv=d9dgWhjE c=1 sm=1 tr=0 ts=6aba0e8c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=VQ9ene8lAAAA:8 a=FP58Ms26AAAA:8 a=SSmOFEACAAAA:8
 a=M5GUcnROAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=i0EeH86SAAAA:8
 a=fd3STBmZuBJBIcJBFskA:9 a=0Al5eFyeYPmzp1dq:21 a=5kMfGx23w8a0v5ansn-_:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: ivRjCFsgEa33aIuUMmC4Edo57YxMsmHm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
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

From: Kiran Kumar K <kirankumark@marvell.com>=0D

On Fri, 17 Jul 2026 11:03:26 +0200 [thread overview], Robin Jarry <rjarry@r=
edhat.com> wrote:=0D
> Replace the FIFO circular buffer used to track pending nodes with=0D
> a bitmap and a topologically-sorted schedule table.=0D
>=0D
> The old circular buffer appended nodes in enqueue order, which is=0D
> effectively a partial DFS driven by per-node process functions: the=0D
> first downstream node enqueued by a process function is visited=0D
> next, regardless of its position in the overall graph. This means=0D
> convergence nodes can be visited before all their upstream branches=0D
> have run, causing redundant visits with smaller batches.=0D
>=0D
> At graph creation time, nodes are now sorted by (topo_order,=0D
> node_id) and assigned a bit position (sched_idx). The topological=0D
> depth is computed via BFS from source nodes so that upstream nodes=0D
> are always visited before downstream ones. During the walk, a=0D
> bitmap tracks which nodes have pending objects. Scanning from the=0D
> lowest bit naturally follows topological order.=0D
>=0D
> This ensures that in fan-out-then-converge topologies, all branches=0D
> feeding a converge node complete before that node is visited. In=0D
> the diamond perf test, the converge node is visited once at 256=0D
> objs/call (~1064M objs/sec) instead of twice at 128 objs/call=0D
> (~970M objs/sec), a ~10% throughput improvement.=0D
>=0D
> perf stat on a server CPU shows ~7% more instructions executed but=0D
> ~7% higher IPC (1.32 vs 1.23), 16% fewer L1 cache misses, and 8%=0D
> fewer branch mispredictions. The bitmap (16 bytes for <64 nodes) is=0D
> more cache-friendly than the circular buffer (256+ bytes). Net=0D
> cycle count and elapsed time are neutral.=0D
>=0D
> Existing linear and tree topologies show no measurable regression.=0D
>=0D
> Suggested-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>=0D
> Signed-off-by: Robin Jarry <rjarry@redhat.com>=0D
> Cc: Christophe Fontaine <cfontain@redhat.com>=0D
> Cc: David Marchand <david.marchand@redhat.com>=0D
> Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>=0D
> Cc: Maxime Leroy <maxime@leroys.fr>=0D
> ---=0D
=0D
Acked-by: Kiran Kumar Kokkilagadda <kirankumark@marvell.com>=0D
=0D
>  app/test/test_graph_perf.c                    |    6 +-=0D
>  doc/guides/prog_guide/graph_lib.rst           |   29 +-=0D
>  .../prog_guide/img/graph_mem_layout.svg       | 1823 +++++++----------=0D
>  lib/graph/graph.c                             |   27 +-=0D
>  lib/graph/graph_debug.c                       |   12 +-=0D
>  lib/graph/graph_ops.c                         |   46 +=0D
>  lib/graph/graph_populate.c                    |  107 +-=0D
>  lib/graph/graph_private.h                     |   41 +-=0D
>  lib/graph/rte_graph_model_mcore_dispatch.h    |   34 +-=0D
>  lib/graph/rte_graph_model_rtc.h               |   63 +-=0D
>  lib/graph/rte_graph_worker.h                  |    2 +-=0D
>  lib/graph/rte_graph_worker_common.h           |   78 +-=0D
>  12 files changed, 1032 insertions(+), 1236 deletions(-)=0D
>=0D
> diff --git a/app/test/test_graph_perf.c b/app/test/test_graph_perf.c=0D
> index c509d364b826..8801714453db 100644=0D
> --- a/app/test/test_graph_perf.c=0D
> +++ b/app/test/test_graph_perf.c=0D
> @@ -1050,9 +1050,9 @@ graph_init_parallel_tree(void)=0D
>   * The fan_out node enqueues to converge (edge 0) before branch (edge 1)=
.=0D
>   * With a FIFO scheduler, converge is visited first with only 50% of the=
=0D
>   * objects, then branch runs and re-enqueues to converge for a second vi=
sit.=0D
> - * With priority-based bitmap scheduling, branch (priority -1) runs befo=
re=0D
> - * converge (priority 0), so converge accumulates all objects and is vis=
ited=0D
> - * only once.=0D
> + * With bitmap scheduling sorted by topological order, branch runs befor=
e=0D
> + * converge (lower topo_order), so converge accumulates all objects and =
is=0D
> + * visited only once.=0D
>   */=0D
>  static inline int=0D
>  graph_init_diamond(void)=0D
> diff --git a/doc/guides/prog_guide/graph_lib.rst b/doc/guides/prog_guide/=
graph_lib.rst=0D
> index 8dd49c19d262..9ee868680248 100644=0D
> --- a/doc/guides/prog_guide/graph_lib.rst=0D
> +++ b/doc/guides/prog_guide/graph_lib.rst=0D
> @@ -122,8 +122,9 @@ Source node:=0D
>=0D
>  Source nodes are static nodes created using ``RTE_NODE_REGISTER`` by pas=
sing=0D
>  ``flags`` as ``RTE_NODE_SOURCE_F``.=0D
> -While performing the graph walk, the ``process()`` function of all the s=
ource=0D
> -nodes will be called first. So that these nodes can be used as input nod=
es for a graph.=0D
> +Source nodes are always visited first during the graph walk since they h=
ave=0D
> +the lowest topological depth (0). This ensures they act as input nodes f=
or=0D
> +a graph.=0D
>=0D
>  nb_xstats:=0D
>  ^^^^^^^^^^=0D
> @@ -396,12 +397,26 @@ Graph object memory layout=0D
>  Understanding the memory layout helps to debug the graph library and=0D
>  improve the performance if needed.=0D
>=0D
> -Graph object consists of a header, circular buffer to store the pending =
stream=0D
> -when walking over the graph, variable-length memory to store the ``rte_n=
ode`` objects,=0D
> -and variable-length memory to store the xstat reported by each ``rte_nod=
e``.=0D
> +A graph object consists of a header, a scheduling table mapping bit posi=
tions to=0D
> +node offsets, pending and source bitmaps for tracking which nodes need=0D
> +processing, variable-length memory to store the ``rte_node`` objects, an=
d=0D
> +variable-length memory to store the xstat reported by each ``rte_node``.=
=0D
>=0D
> -The graph_nodes_mem_create() creates and populate this memory. The funct=
ions=0D
> -such as ``rte_graph_walk()`` and ``rte_node_enqueue_*`` use this memory=
=0D
> +Nodes are sorted by ``(topo_order, node_id)`` at graph creation time and=
 each=0D
> +node is assigned a bit position in the pending bitmap. The topological d=
epth=0D
> +is computed via BFS from source nodes so that upstream nodes are always =
visited=0D
> +before downstream ones. During the graph walk, the bitmap is scanned fro=
m the=0D
> +lowest bit, naturally following topological order.=0D
> +=0D
> +This ordering improves batching in fan-out-then-converge topologies. For=
=0D
> +example, if ``eth_input`` classifies packets to both ``mpls_input`` and=
=0D
> +``ipv4_input``, and ``mpls_input`` also feeds into ``ipv4_input``, the=0D
> +topological ordering ensures ``mpls_input`` runs first. Its output accum=
ulates=0D
> +in ``ipv4_input`` which is then visited only once with all packets, inst=
ead of=0D
> +being visited twice (before and after MPLS label popping).=0D
> +=0D
> +The ``graph_fp_mem_create()`` function creates and populates this memory=
. The=0D
> +functions such as ``rte_graph_walk()`` and ``rte_node_enqueue_*`` use th=
is memory=0D
>  to enable fastpath services.=0D
>=0D
>  Graph feature arc=0D
> diff --git a/doc/guides/prog_guide/img/graph_mem_layout.svg b/doc/guides/=
prog_guide/img/graph_mem_layout.svg=0D
> index 3f3a4f3a808e..6c8879b17f4b 100644=0D
> --- a/doc/guides/prog_guide/img/graph_mem_layout.svg=0D
> +++ b/doc/guides/prog_guide/img/graph_mem_layout.svg=0D
> @@ -1,65 +1,22 @@=0D
>  <?xml version=3D"1.0" encoding=3D"UTF-8" standalone=3D"no"?>=0D
> -<!-- Created with Inkscape (http://www.inkscape.org/) -->=0D
>  <!-- SPDX-License-Identifier: BSD-3-Clause -->=0D
> +=0D
>  <!-- Copyright(C) 2020 Marvell International Ltd. -->=0D
> +=0D
>  <svg=0D
> -   width=3D"960"=0D
> -   height=3D"600"=0D
> -   viewBox=3D"0 0 960 600"=0D
> +   width=3D"820"=0D
> +   height=3D"540"=0D
> +   viewBox=3D"0 0 819.99998 540"=0D
>     version=3D"1.1"=0D
> -   id=3D"svg1"=0D
> -   inkscape:version=3D"1.3.2 (091e20e, 2023-11-25, custom)"=0D
> +   id=3D"svg56"=0D
>     sodipodi:docname=3D"graph_mem_layout.svg"=0D
> +   inkscape:version=3D"1.4.4 (dcaf3e7d9e, 2026-05-05)"=0D
>     xmlns:inkscape=3D"http://www.inkscape.org/namespaces/inkscape"=0D
>     xmlns:sodipodi=3D"http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"=
=0D
> -   xmlns:xlink=3D"http://www.w3.org/1999/xlink"=0D
>     xmlns=3D"http://www.w3.org/2000/svg"=0D
>     xmlns:svg=3D"http://www.w3.org/2000/svg">=0D
> -  <sodipodi:namedview=0D
> -     id=3D"namedview1"=0D
> -     pagecolor=3D"#ffffff"=0D
> -     bordercolor=3D"#000000"=0D
> -     borderopacity=3D"0.25"=0D
> -     inkscape:showpageshadow=3D"2"=0D
> -     inkscape:pageopacity=3D"0.0"=0D
> -     inkscape:pagecheckerboard=3D"0"=0D
> -     inkscape:deskcolor=3D"#d1d1d1"=0D
> -     inkscape:document-units=3D"px"=0D
> -     showgrid=3D"true"=0D
> -     inkscape:zoom=3D"6.1531386"=0D
> -     inkscape:cx=3D"753.51789"=0D
> -     inkscape:cy=3D"469.11019"=0D
> -     inkscape:window-width=3D"1920"=0D
> -     inkscape:window-height=3D"1057"=0D
> -     inkscape:window-x=3D"-8"=0D
> -     inkscape:window-y=3D"-8"=0D
> -     inkscape:window-maximized=3D"1"=0D
> -     inkscape:current-layer=3D"layer1">=0D
> -    <inkscape:grid=0D
> -       id=3D"grid18"=0D
> -       units=3D"px"=0D
> -       originx=3D"0"=0D
> -       originy=3D"0"=0D
> -       spacingx=3D"1"=0D
> -       spacingy=3D"1"=0D
> -       empcolor=3D"#0099e5"=0D
> -       empopacity=3D"0.30196078"=0D
> -       color=3D"#0099e5"=0D
> -       opacity=3D"0.14901961"=0D
> -       empspacing=3D"5"=0D
> -       dotted=3D"false"=0D
> -       gridanglex=3D"30"=0D
> -       gridanglez=3D"30"=0D
> -       visible=3D"true" />=0D
> -  </sodipodi:namedview>=0D
>    <defs=0D
> -     id=3D"defs1">=0D
> -    <rect=0D
> -       x=3D"569.30411"=0D
> -       y=3D"433.24112"=0D
> -       width=3D"99.519047"=0D
> -       height=3D"22.294105"=0D
> -       id=3D"rect22" />=0D
> +     id=3D"defs56">=0D
>      <marker=0D
>         style=3D"overflow:visible"=0D
>         id=3D"Triangle"=0D
> @@ -67,8 +24,8 @@=0D
>         refY=3D"0"=0D
>         orient=3D"auto-start-reverse"=0D
>         inkscape:stockid=3D"Triangle arrow"=0D
> -       markerWidth=3D"1"=0D
> -       markerHeight=3D"1"=0D
> +       markerWidth=3D"2"=0D
> +       markerHeight=3D"2"=0D
>         viewBox=3D"0 0 1 1"=0D
>         inkscape:isstock=3D"true"=0D
>         inkscape:collect=3D"always"=0D
> @@ -79,1065 +36,705 @@=0D
>           d=3D"M 5.77,0 -2.88,5 V -5 Z"=0D
>           id=3D"path135" />=0D
>      </marker>=0D
> -    <rect=0D
> -       x=3D"656.57551"=0D
> -       y=3D"399.79598"=0D
> -       width=3D"185.92138"=0D
> -       height=3D"16.251869"=0D
> -       id=3D"rect19" />=0D
> -    <rect=0D
> -       x=3D"765.814"=0D
> -       y=3D"425.65652"=0D
> -       width=3D"104.80528"=0D
> -       height=3D"23.902958"=0D
> -       id=3D"rect18" />=0D
> -    <rect=0D
> -       x=3D"650.43626"=0D
> -       y=3D"461.97063"=0D
> -       width=3D"56.999362"=0D
> -       height=3D"17.927219"=0D
> -       id=3D"rect16" />=0D
> -    <linearGradient=0D
> -       id=3D"swatch10"=0D
> -       inkscape:swatch=3D"solid">=0D
> -      <stop=0D
> -         style=3D"stop-color:#090608;stop-opacity:1;"=0D
> -         offset=3D"0"=0D
> -         id=3D"stop10" />=0D
> -    </linearGradient>=0D
> -    <rect=0D
> -       x=3D"451.39817"=0D
> -       y=3D"509.77655"=0D
> -       width=3D"136.52266"=0D
> -       height=3D"74.007236"=0D
> -       id=3D"rect7" />=0D
> -    <rect=0D
> -       x=3D"334.18174"=0D
> -       y=3D"450.01915"=0D
> -       width=3D"51.483294"=0D
> -       height=3D"22.064269"=0D
> -       id=3D"rect6" />=0D
> -    <rect=0D
> -       x=3D"332.80272"=0D
> -       y=3D"483.11556"=0D
> -       width=3D"57.918706"=0D
> -       height=3D"32.177059"=0D
> -       id=3D"rect5" />=0D
> -    <rect=0D
> -       x=3D"361.3024"=0D
> -       y=3D"464.26899"=0D
> -       width=3D"133.30496"=0D
> -       height=3D"49.644605"=0D
> -       id=3D"rect4" />=0D
> -    <rect=0D
> -       x=3D"155.8289"=0D
> -       y=3D"426.57587"=0D
> -       width=3D"103.88593"=0D
> -       height=3D"13.330496"=0D
> -       id=3D"rect2" />=0D
> -    <marker=0D
> -       style=3D"overflow:visible"=0D
> -       id=3D"Triangle-0"=0D
> -       refX=3D"0"=0D
> -       refY=3D"0"=0D
> -       orient=3D"auto-start-reverse"=0D
> -       inkscape:stockid=3D"Triangle arrow"=0D
> -       markerWidth=3D"1"=0D
> -       markerHeight=3D"1"=0D
> -       viewBox=3D"0 0 1 1"=0D
> -       inkscape:isstock=3D"true"=0D
> -       inkscape:collect=3D"always"=0D
> -       preserveAspectRatio=3D"xMidYMid">=0D
> -      <path=0D
> -         transform=3D"scale(0.5)"=0D
> -         style=3D"fill:context-stroke;fill-rule:evenodd;stroke:context-s=
troke;stroke-width:1pt"=0D
> -         d=3D"M 5.77,0 -2.88,5 V -5 Z"=0D
> -         id=3D"path135-2" />=0D
> -    </marker>=0D
> -    <rect=0D
> -       x=3D"656.5755"=0D
> -       y=3D"399.79599"=0D
> -       width=3D"186.38106"=0D
> -       height=3D"37.396793"=0D
> -       id=3D"rect19-5" />=0D
>    </defs>=0D
> -  <g=0D
> -     inkscape:label=3D"Layer 1"=0D
> -     inkscape:groupmode=3D"layer"=0D
> -     id=3D"layer1">=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1.13576"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 144.20018,75.514867 V 521.03057"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path232" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1.13545"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 272.64375,75.629785 V 520.91592"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path234" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 143.70149,76.013557 H 273.14244"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path236" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 143.70149,127.21041 H 273.14244"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path238" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 143.70149,180.40726 H 273.14244"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path240" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 143.70149,215.60412 H 273.14244"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path242" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 143.70149,266.80095 H 273.14244"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path244" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 143.70149,317.99782 H 273.14244"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path246" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 143.70149,369.19466 H 273.14244"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path248" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 143.70149,420.3915 H 273.14244"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path250" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 143.59745,445.61126 H 273.0384"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path250-4" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"0.998115"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 143.86386,470.4766 H 272.81725"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path250-4-4" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"0.998115"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 144.33823,495.4898 H 273.29162"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path250-4-4-6" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"0.999778"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 143.81154,520.51707 H 273.19503"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path250-7" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 173.54384,94.079177 v -1.125 l 4.03125,-0.0156 v 3.54688 q=
 -0.92188,0.75 -1.92188,1.125 -0.98437,0.35937 -2.03125,0.35937 -1.40625,0 =
-2.5625,-0.59375 -1.14062,-0.60937 -1.73437,-1.73437 -0.57813,-1.14063 -0.5=
7813,-2.54688 0,-1.40625 0.57813,-2.60937 0.59375,-1.20313 1.6875,-1.78125 =
1.09375,-0.59375 2.51562,-0.59375 1.03125,0 1.85938,0.34375 0.84375,0.32812=
 1.3125,0.9375 0.48437,0.59375 0.73437,1.54687 l -1.14062,0.3125 q -0.21875=
,-0.71875 -0.53125,-1.14062 -0.3125,-0.42188 -0.90625,-0.67188 -0.59375,-0.=
25 -1.3125,-0.25 -0.875,0 -1.51563,0.26563 -0.625,0.26562 -1.01562,0.70312 =
-0.375,0.42188 -0.59375,0.9375 -0.35938,0.875 -0.35938,1.92188 0,1.26562 0.=
4375,2.125 0.4375,0.85937 1.26563,1.28125 0.84375,0.42187 1.79687,0.42187 0=
.8125,0 1.59375,-0.3125 0.78125,-0.32812 1.1875,-0.6875 v -1.76562 z m 5.72=
643,3.73437 v -6.90625 h 1.0625 v 1.04688 q 0.40625,-0.73438 0.73437,-0.968=
75 0.34375,-0.23438 0.76563,-0.23438 0.59375,0 1.20312,0.375 l -0.40625,1.0=
7813 q -0.4375,-0.25 -0.85937,-0.25 -0.39063,0 -0.70313,0.23437 -0.29687,0.=
23438 -0.42187,0.64063 -0.20313,0.625 -0.20313,1.35937 v 3.625 z m 8.96961,=
-0.85937 q -0.65625,0.5625 -1.26562,0.79687 -0.59375,0.21875 -1.28125,0.218=
75 -1.14063,0 -1.75,-0.54687 -0.60938,-0.5625 -0.60938,-1.4375 0,-0.5 0.218=
75,-0.92188 0.23438,-0.42187 0.60938,-0.67187 0.375,-0.25 0.84375,-0.39063 =
0.34375,-0.0781 1.04687,-0.17187 1.42188,-0.17188 2.09375,-0.40625 0,-0.234=
38 0,-0.29688 0,-0.71875 -0.32812,-1.01562 -0.45313,-0.39063 -1.34375,-0.39=
063 -0.8125,0 -1.21875,0.29688 -0.39063,0.28125 -0.57813,1.01562 l -1.14062=
,-0.15625 q 0.15625,-0.73437 0.51562,-1.1875 0.35938,-0.45312 1.03125,-0.68=
75 0.67188,-0.25 1.5625,-0.25 0.89063,0 1.4375,0.20313 0.5625,0.20312 0.812=
5,0.53125 0.26563,0.3125 0.375,0.79687 0.0469,0.29688 0.0469,1.07813 v 1.56=
25 q 0,1.625 0.0781,2.0625 0.0781,0.4375 0.29688,0.82812 h -1.21875 q -0.18=
75,-0.35937 -0.23438,-0.85937 z m -0.0937,-2.60938 q -0.64062,0.26563 -1.92=
187,0.4375 -0.71875,0.10938 -1.01563,0.25 -0.29687,0.125 -0.46875,0.375 -0.=
15625,0.25 -0.15625,0.54688 0,0.46875 0.34375,0.78125 0.35938,0.3125 1.0468=
8,0.3125 0.67187,0 1.20312,-0.29688 0.53125,-0.29687 0.78125,-0.8125 0.1875=
,-0.39062 0.1875,-1.17187 z m 2.99061,6.125003 v -9.562503 h 1.07812 v 0.89=
063 q 0.375,-0.53125 0.84375,-0.78125 0.48438,-0.26563 1.15625,-0.26563 0.8=
75,0 1.54688,0.45313 0.6875,0.45312 1.03125,1.28125 0.34375,0.82812 0.34375=
,1.82812 0,1.04688 -0.375,1.90625 -0.375,0.84375 -1.10938,1.29688 -0.71875,=
0.45312 -1.53125,0.45312 -0.57812,0 -1.04687,-0.25 -0.46875,-0.25 -0.76563,=
-0.625 v 3.375003 z m 1.0625,-6.078123 q 0,1.34375 0.53125,1.98437 0.54687,=
0.625 1.3125,0.625 0.78125,0 1.34375,-0.65625 0.5625,-0.65625 0.5625,-2.046=
87 0,-1.3125 -0.54688,-1.96875 -0.54687,-0.67188 -1.29687,-0.67188 -0.75,0 =
-1.32813,0.70313 -0.57812,0.70312 -0.57812,2.03125 z m 6.34997,3.42187 v -9=
.54687 h 1.17188 v 3.42187 q 0.82812,-0.9375 2.07812,-0.9375 0.76563,0 1.32=
813,0.29688 0.5625,0.29687 0.8125,0.84375 0.25,0.53125 0.25,1.54687 v 4.375=
 h -1.17188 v -4.375 q 0,-0.89062 -0.39062,-1.28125 -0.375,-0.40625 -1.0781=
3,-0.40625 -0.51562,0 -0.98437,0.28125 -0.45313,0.26563 -0.65625,0.73438 -0=
.1875,0.45312 -0.1875,1.26562 v 3.78125 z m 11.30296,0 v -9.54687 h 1.26563=
 v 3.92187 h 4.95312 v -3.92187 h 1.26563 v 9.54687 h -1.26563 v -4.5 h -4.=
95312 v 4.5 z m 14.17203,-2.21875 1.20313,0.14063 q -0.28125,1.0625 -1.0625=
,1.65625 -0.76563,0.57812 -1.96875,0.57812 -1.51563,0 -2.40625,-0.9375 -0.8=
9063,-0.9375 -0.89063,-2.60937 0,-1.75 0.89063,-2.70313 0.90625,-0.96875 2.=
34375,-0.96875 1.39062,0 2.26562,0.9375 0.875,0.9375 0.875,2.65625 0,0.1093=
8 0,0.3125 H 220.118 q 0.0625,1.14063 0.64063,1.75 0.57812,0.59375 1.4375,0=
.59375 0.65625,0 1.10937,-0.32812 0.45313,-0.34375 0.71875,-1.07813 z m -3.=
84375,-1.90625 h 3.85938 q -0.0781,-0.85937 -0.4375,-1.29687 -0.5625,-0.687=
5 -1.45313,-0.6875 -0.8125,0 -1.35937,0.54687 -0.54688,0.53125 -0.60938,1.4=
375 z m 11.03748,3.26563 q -0.65625,0.5625 -1.26563,0.79687 -0.59375,0.2187=
5 -1.28125,0.21875 -1.14062,0 -1.75,-0.54687 -0.60937,-0.5625 -0.60937,-1.4=
375 0,-0.5 0.21875,-0.92188 0.23437,-0.42187 0.60937,-0.67187 0.375,-0.25 0=
.84375,-0.39063 0.34375,-0.0781 1.04688,-0.17187 1.42187,-0.17188 2.09375,-=
0.40625 0,-0.23438 0,-0.29688 0,-0.71875 -0.32813,-1.01562 -0.45312,-0.3906=
3 -1.34375,-0.39063 -0.8125,0 -1.21875,0.29688 -0.39062,0.28125 -0.57812,1.=
01562 l -1.14063,-0.15625 q 0.15625,-0.73437 0.51563,-1.1875 0.35937,-0.453=
12 1.03125,-0.6875 0.67187,-0.25 1.5625,-0.25 0.89062,0 1.4375,0.20313 0.56=
25,0.20312 0.8125,0.53125 0.26562,0.3125 0.375,0.79687 0.0469,0.29688 0.046=
9,1.07813 v 1.5625 q 0,1.625 0.0781,2.0625 0.0781,0.4375 0.29687,0.82812 h =
-1.21875 q -0.1875,-0.35937 -0.23437,-0.85937 z m -0.0937,-2.60938 q -0.640=
63,0.26563 -1.92188,0.4375 -0.71875,0.10938 -1.01562,0.25 -0.29688,0.125 -0=
.46875,0.375 -0.15625,0.25 -0.15625,0.54688 0,0.46875 0.34375,0.78125 0.359=
37,0.3125 1.04687,0.3125 0.67188,0 1.20313,-0.29688 0.53125,-0.29687 0.7812=
5,-0.8125 0.1875,-0.39062 0.1875,-1.17187 z m 7.47497,3.46875 v -0.875 q -0=
.65625,1.03125 -1.9375,1.03125 -0.8125,0 -1.51562,-0.45312 -0.6875,-0.45313=
 -1.07813,-1.26563 -0.375,-0.82812 -0.375,-1.89062 0,-1.03125 0.34375,-1.87=
5 0.34375,-0.84375 1.03125,-1.28125 0.70313,-0.45313 1.54688,-0.45313 0.625=
,0 1.10937,0.26563 0.5,0.25 0.79688,0.67187 v -3.42187 h 1.17187 v 9.54687 =
z m -3.70312,-3.45312 q 0,1.32812 0.5625,1.98437 0.5625,0.65625 1.32812,0.6=
5625 0.76563,0 1.29688,-0.625 0.53125,-0.625 0.53125,-1.90625 0,-1.42187 -0=
.54688,-2.07812 -0.54687,-0.67188 -1.34375,-0.67188 -0.78125,0 -1.3125,0.64=
063 -0.51562,0.625 -0.51562,2 z m 11.3656,1.23437 1.20312,0.14063 q -0.2812=
5,1.0625 -1.0625,1.65625 -0.76562,0.57812 -1.96875,0.57812 -1.51562,0 -2.40=
625,-0.9375 -0.89062,-0.9375 -0.89062,-2.60937 0,-1.75 0.89062,-2.70313 0.9=
0625,-0.96875 2.34375,-0.96875 1.39063,0 2.26563,0.9375 0.875,0.9375 0.875,=
2.65625 0,0.10938 0,0.3125 h -5.15625 q 0.0625,1.14063 0.64062,1.75 0.57813=
,0.59375 1.4375,0.59375 0.65625,0 1.10938,-0.32812 0.45312,-0.34375 0.71875=
,-1.07813 z m -3.84375,-1.90625 h 3.85937 q -0.0781,-0.85937 -0.4375,-1.296=
87 -0.5625,-0.6875 -1.45312,-0.6875 -0.8125,0 -1.35938,0.54687 -0.54687,0.5=
3125 -0.60937,1.4375 z m 6.50623,4.125 v -6.90625 h 1.0625 v 1.04688 q 0.40=
625,-0.73438 0.73437,-0.96875 0.34375,-0.23438 0.76563,-0.23438 0.59375,0 1=
.20312,0.375 l -0.40625,1.07813 q -0.4375,-0.25 -0.85937,-0.25 -0.39063,0 -=
0.70313,0.23437 -0.29687,0.23438 -0.42187,0.64063 -0.20313,0.625 -0.20313,1=
.35937 v 3.625 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path252" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 162.29759,111.45418 1.1875,-0.0781 q 0,0.51563 0.15625,0.8=
75 0.15625,0.35938 0.57812,0.59375 0.42188,0.21875 0.96875,0.21875 0.78125,=
0 1.17188,-0.3125 0.39062,-0.3125 0.39062,-0.73437 0,-0.3125 -0.23437,-0.57=
813 -0.23438,-0.28125 -1.17188,-0.67187 -0.9375,-0.40625 -1.1875,-0.57813 -=
0.4375,-0.26562 -0.67187,-0.625 -0.21875,-0.35937 -0.21875,-0.82812 0,-0.81=
25 0.65625,-1.39063 0.65625,-0.59375 1.82812,-0.59375 1.29688,0 1.96875,0.6=
0938 0.6875,0.59375 0.71875,1.57812 l -1.15625,0.0781 q -0.0312,-0.625 -0.4=
5312,-0.98438 -0.40625,-0.375 -1.17188,-0.375 -0.60937,0 -0.95312,0.28125 -=
0.32813,0.28125 -0.32813,0.60938 0,0.3125 0.29688,0.5625 0.1875,0.17187 1,0=
.53125 1.35937,0.57812 1.70312,0.92187 0.5625,0.53125 0.5625,1.3125 0,0.515=
63 -0.3125,1.01563 -0.3125,0.48437 -0.96875,0.78125 -0.64062,0.29687 -1.515=
62,0.29687 -1.20313,0 -2.04688,-0.59375 -0.84375,-0.59375 -0.79687,-1.92187=
 z m 9.32031,1.40625 -0.20312,0.95312 q -0.42188,0.10938 -0.8125,0.10938 -0=
.70313,0 -1.125,-0.34375 -0.3125,-0.25 -0.3125,-0.70313 0,-0.23437 0.17187,=
-1.04687 l 0.82813,-4.01563 h -0.92188 l 0.1875,-0.90625 h 0.9375 l 0.34375=
,-1.70312 1.35938,-0.8125 -0.53125,2.51562 h 1.15625 l -0.1875,0.90625 h -1=
.15625 l -0.79688,3.8125 q -0.15625,0.73438 -0.15625,0.875 0,0.21875 0.1093=
8,0.32813 0.125,0.10937 0.40625,0.10937 0.39062,0 0.70312,-0.0781 z m 0.937=
37,0.95312 1.45312,-6.90625 h 1.03125 l -0.28125,1.40625 q 0.53125,-0.79687=
 1.03125,-1.17187 0.51563,-0.39063 1.04688,-0.39063 0.35937,0 0.875,0.25 l =
-0.48438,1.09375 q -0.3125,-0.21875 -0.67187,-0.21875 -0.625,0 -1.28125,0.6=
875 -0.64063,0.6875 -1.01563,2.48438 l -0.57812,2.76562 z m 9.15712,-1.25 q=
 -1.23438,1.40625 -2.54688,1.40625 -0.79687,0 -1.29687,-0.45312 -0.48438,-0=
.46875 -0.48438,-1.125 0,-0.4375 0.21875,-1.5 l 0.84375,-3.98438 h 1.17188 =
l -0.92188,4.40625 q -0.10937,0.5625 -0.10937,0.85938 0,0.39062 0.23437,0.6=
0937 0.23438,0.21875 0.70313,0.21875 0.48437,0 0.95312,-0.23437 0.48438,-0.=
23438 0.8125,-0.64063 0.34375,-0.42187 0.5625,-0.98437 0.14063,-0.35938 0.3=
2813,-1.25 l 0.625,-2.98438 h 1.1875 l -1.45313,6.90625 h -1.07812 z m 7.47=
497,-1.26562 1.17188,0.125 q -0.4375,1.29687 -1.26563,1.92187 -0.8125,0.625=
 -1.84375,0.625 -1.14062,0 -1.84375,-0.71875 -0.6875,-0.73437 -0.6875,-2.04=
687 0,-1.125 0.4375,-2.21875 0.45313,-1.09375 1.28125,-1.65625 0.84375,-0.5=
7813 1.92188,-0.57813 1.10937,0 1.76562,0.625 0.65625,0.625 0.65625,1.65625=
 l -1.15625,0.0781 q -0.0156,-0.65625 -0.39062,-1.01563 -0.375,-0.375 -0.98=
438,-0.375 -0.70312,0 -1.23437,0.45313 -0.51563,0.4375 -0.8125,1.35937 -0.2=
9688,0.90625 -0.29688,1.75 0,0.89063 0.39063,1.34375 0.39062,0.4375 0.96875=
,0.4375 0.5625,0 1.07812,-0.4375 0.53125,-0.4375 0.84375,-1.32812 z m 4.648=
44,1.5625 -0.20313,0.95312 q -0.42187,0.10938 -0.8125,0.10938 -0.70312,0 -1=
.125,-0.34375 -0.3125,-0.25 -0.3125,-0.70313 0,-0.23437 0.17188,-1.04687 l =
0.82812,-4.01563 h -0.92187 l 0.1875,-0.90625 h 0.9375 l 0.34375,-1.70312 1=
.35937,-0.8125 -0.53125,2.51562 h 1.15625 l -0.1875,0.90625 h -1.15625 l -0=
.79687,3.8125 q -0.15625,0.73438 -0.15625,0.875 0,0.21875 0.10937,0.32813 0=
.125,0.10937 0.40625,0.10937 0.39063,0 0.70313,-0.0781 z m 4.64035,0.95312 =
1.45312,-6.90625 h 1.03125 l -0.28125,1.40625 q 0.53125,-0.79687 1.03125,-1=
.17187 0.51563,-0.39063 1.04688,-0.39063 0.35937,0 0.875,0.25 l -0.48438,1.=
09375 q -0.3125,-0.21875 -0.67187,-0.21875 -0.625,0 -1.28125,0.6875 -0.6406=
3,0.6875 -1.01563,2.48438 l -0.57812,2.76562 z m 7.20399,-0.95312 -0.20312,=
0.95312 q -0.42188,0.10938 -0.8125,0.10938 -0.70313,0 -1.125,-0.34375 -0.31=
25,-0.25 -0.3125,-0.70313 0,-0.23437 0.17187,-1.04687 l 0.82813,-4.01563 h =
-0.92188 l 0.1875,-0.90625 h 0.9375 l 0.34375,-1.70312 1.35938,-0.8125 -0.5=
3125,2.51562 h 1.15625 l -0.1875,0.90625 h -1.15625 l -0.79688,3.8125 q -0.=
15625,0.73438 -0.15625,0.875 0,0.21875 0.10938,0.32813 0.125,0.10937 0.4062=
5,0.10937 0.39062,0 0.70312,-0.0781 z m 6.01549,-1.39063 1.15625,0.10938 q =
-0.25,0.85937 -1.14062,1.625 -0.89063,0.76562 -2.125,0.76562 -0.76563,0 -1.=
40625,-0.34375 -0.64063,-0.35937 -0.98438,-1.03125 -0.32812,-0.6875 -0.3281=
2,-1.54687 0,-1.14063 0.51562,-2.20313 0.53125,-1.0625 1.35938,-1.57812 0.8=
4375,-0.51563 1.8125,-0.51563 1.23437,0 1.96875,0.76563 0.75,0.76562 0.75,2=
.09375 0,0.5 -0.0937,1.04687 h -5.09375 q -0.0312,0.1875 -0.0312,0.35938 0,=
0.96875 0.4375,1.48437 0.45312,0.5 1.10937,0.5 0.59375,0 1.17188,-0.39062 0=
.59375,-0.39063 0.92187,-1.14063 z m -3.42187,-1.71875 h 3.875 q 0.0156,-0.=
1875 0.0156,-0.26562 0,-0.875 -0.45312,-1.34375 -0.4375,-0.48438 -1.125,-0.=
48438 -0.76563,0 -1.39063,0.53125 -0.60937,0.51563 -0.92187,1.5625 z m 4.47=
497,6.71875 v -0.85937 h 7.76563 v 0.85937 z m 8.63123,-2.03125 1.1875,0.10=
938 q 0,0.40625 0.10937,0.60937 0.10938,0.20313 0.34375,0.3125 0.32813,0.14=
063 0.82813,0.14063 1.0625,0 1.53125,-0.54688 0.3125,-0.375 0.57812,-1.625 =
l 0.10938,-0.5625 q -0.92188,0.9375 -1.95313,0.9375 -1.04687,0 -1.75,-0.765=
62 -0.70312,-0.78125 -0.70312,-2.1875 0,-1.17188 0.54687,-2.14063 0.5625,-0=
.98437 1.32813,-1.46875 0.76562,-0.5 1.57812,-0.5 1.35938,0 2.09375,1.28125=
 l 0.23438,-1.125 h 1.07812 l -1.39062,6.67188 q -0.21875,1.09375 -0.59375,=
1.70312 -0.375,0.625 -1.03125,0.95313 -0.65625,0.34375 -1.53125,0.34375 -0.=
82813,0 -1.4375,-0.21875 -0.59375,-0.20313 -0.89063,-0.625 -0.29687,-0.4062=
5 -0.29687,-0.95313 0,-0.15625 0.0312,-0.34375 z m 1.46875,-3.6875 q 0,0.71=
875 0.14062,1.07813 0.20313,0.5 0.5625,0.76562 0.35938,0.25 0.79688,0.25 0.=
57812,0 1.14062,-0.40625 0.57813,-0.40625 0.9375,-1.25 0.35938,-0.85937 0.3=
5938,-1.625 0,-0.85937 -0.48438,-1.35937 -0.46875,-0.51563 -1.15625,-0.5156=
3 -0.4375,0 -0.84375,0.23438 -0.39062,0.23437 -0.75,0.70312 -0.34375,0.4687=
5 -0.53125,1.14063 -0.17187,0.65625 -0.17187,0.98437 z m 6.00622,3.0625 1.4=
5313,-6.90625 h 1.03125 l -0.28125,1.40625 q 0.53125,-0.79687 1.03125,-1.17=
187 0.51562,-0.39063 1.04687,-0.39063 0.35938,0 0.875,0.25 l -0.48437,1.093=
75 q -0.3125,-0.21875 -0.67188,-0.21875 -0.625,0 -1.28125,0.6875 -0.64062,0=
.6875 -1.01562,2.48438 l -0.57813,2.76562 z m 9.11025,-0.85937 q -0.625,0.5=
3125 -1.1875,0.78125 -0.5625,0.23437 -1.20313,0.23437 -0.96875,0 -1.5625,-0=
.5625 -0.57812,-0.5625 -0.57812,-1.4375 0,-0.57812 0.26562,-1.01562 0.26563=
,-0.45313 0.70313,-0.71875 0.4375,-0.28125 1.0625,-0.39063 0.40625,-0.0781 =
1.51562,-0.125 1.10938,-0.0469 1.59375,-0.23437 0.125,-0.48438 0.125,-0.812=
5 0,-0.40625 -0.29687,-0.64063 -0.40625,-0.32812 -1.1875,-0.32812 -0.75,0 -=
1.21875,0.32812 -0.46875,0.32813 -0.6875,0.9375 l -1.1875,-0.10937 q 0.3593=
7,-1.01563 1.14062,-1.5625 0.79688,-0.54688 2,-0.54688 1.28125,0 2.03125,0.=
60938 0.57813,0.45312 0.57813,1.1875 0,0.54687 -0.15625,1.28125 l -0.39063,=
1.71875 q -0.1875,0.8125 -0.1875,1.32812 0,0.32813 0.15625,0.9375 h -1.2031=
2 q -0.0937,-0.34375 -0.125,-0.85937 z m 0.42187,-2.64063 q -0.23437,0.0937=
 -0.53125,0.15625 -0.28125,0.0469 -0.9375,0.10938 -1.03125,0.0781 -1.45312,=
0.21875 -0.42188,0.14062 -0.64063,0.45312 -0.21875,0.29688 -0.21875,0.67188=
 0,0.5 0.34375,0.82812 0.34375,0.3125 0.98438,0.3125 0.57812,0 1.10937,-0.3=
125 0.54688,-0.3125 0.85938,-0.85937 0.3125,-0.5625 0.48437,-1.57813 z m 1.=
7406,6.15625 2,-9.5625 h 1.09375 l -0.20312,0.95313 q 0.59375,-0.625 1.0781=
2,-0.85938 0.48438,-0.25 1.01563,-0.25 0.98437,0 1.625,0.71875 0.65625,0.71=
875 0.65625,2.0625 0,1.07813 -0.35938,1.96875 -0.34375,0.875 -0.875,1.42188=
 -0.51562,0.54687 -1.04687,0.79687 -0.53125,0.25 -1.09375,0.25 -1.25,0 -1.9=
2188,-1.26562 l -0.78125,3.76562 z m 2.32813,-5.48437 q 0,0.78125 0.10937,1=
.07812 0.17188,0.42188 0.53125,0.6875 0.375,0.25 0.875,0.25 1.01563,0 1.640=
63,-1.14062 0.625,-1.14063 0.625,-2.32813 0,-0.875 -0.42188,-1.35937 -0.421=
87,-0.48438 -1.04687,-0.48438 -0.45313,0 -0.84375,0.25 -0.375,0.23438 -0.70=
313,0.70313 -0.32812,0.46875 -0.54687,1.15625 -0.21875,0.6875 -0.21875,1.18=
75 z m 5.66247,2.82812 2,-9.54687 h 1.17188 l -0.76563,3.67187 q 0.65625,-0=
.64062 1.21875,-0.90625 0.57813,-0.28125 1.17188,-0.28125 0.85937,0 1.32812=
,0.45313 0.48438,0.45312 0.48438,1.1875 0,0.35937 -0.20313,1.34375 l -0.859=
37,4.07812 h -1.17188 l 0.875,-4.1875 q 0.1875,-0.90625 0.1875,-1.14062 0,-=
0.34375 -0.23437,-0.54688 -0.23438,-0.21875 -0.67188,-0.21875 -0.64062,0 -1=
.21875,0.34375 -0.57812,0.32813 -0.90625,0.90625 -0.32812,0.57813 -0.60937,=
1.875 l -0.60938,2.96875 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path254" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 190.99429,149.01041 v -9.54688 h 6.4375 v 1.125 h -5.17188=
 v 2.96875 h 4.46875 v 1.125 h -4.46875 v 4.32813 z m 12.65698,-2.21875 1.2=
0313,0.14062 q -0.28125,1.0625 -1.0625,1.65625 -0.76563,0.57813 -1.96875,0.=
57813 -1.51563,0 -2.40625,-0.9375 -0.89063,-0.9375 -0.89063,-2.60938 0,-1.7=
5 0.89063,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.39062,0 2.26562,0.93=
75 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.15625 q 0.0625,1.1406=
2 0.64063,1.75 0.57812,0.59375 1.4375,0.59375 0.65625,0 1.10937,-0.32813 0.=
45313,-0.34375 0.71875,-1.07812 z m -3.84375,-1.90625 h 3.85938 q -0.0781,-=
0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.45313,-0.6875 -0.8125,0 -1.3593=
7,0.54688 -0.54688,0.53125 -0.60938,1.4375 z m 6.52185,4.125 v -6.90625 h 1=
.0625 v 0.98437 q 0.75,-1.14062 2.1875,-1.14062 0.625,0 1.15625,0.21875 0.5=
3125,0.21875 0.78125,0.59375 0.26563,0.35937 0.375,0.85937 0.0625,0.32813 0=
.0625,1.14063 v 4.25 h -1.17187 v -4.20313 q 0,-0.71875 -0.14063,-1.0625 -0=
.14062,-0.35937 -0.48437,-0.5625 -0.34375,-0.21875 -0.8125,-0.21875 -0.75,0=
 -1.29688,0.46875 -0.54687,0.46875 -0.54687,1.79688 v 3.78125 z m 11.9281,-=
2.53125 1.15625,0.15625 q -0.1875,1.1875 -0.96875,1.85937 -0.78125,0.67188 =
-1.92187,0.67188 -1.40625,0 -2.28125,-0.92188 -0.85938,-0.9375 -0.85938,-2.=
65625 0,-1.125 0.375,-1.96875 0.375,-0.84375 1.125,-1.25 0.76563,-0.42187 1=
.65625,-0.42187 1.125,0 1.84375,0.57812 0.71875,0.5625 0.92188,1.60938 l -1=
.14063,0.17187 q -0.17187,-0.70312 -0.59375,-1.04687 -0.40625,-0.35938 -0.9=
8437,-0.35938 -0.89063,0 -1.45313,0.64063 -0.54687,0.64062 -0.54687,2 0,1.4=
0625 0.53125,2.03125 0.54687,0.625 1.40625,0.625 0.6875,0 1.14062,-0.42188 =
0.46875,-0.42187 0.59375,-1.29687 z m 6.88282,0.3125 1.20312,0.14062 q -0.2=
8125,1.0625 -1.0625,1.65625 -0.76562,0.57813 -1.96875,0.57813 -1.51562,0 -2=
.40625,-0.9375 -0.89062,-0.9375 -0.89062,-2.60938 0,-1.75 0.89062,-2.70312 =
0.90625,-0.96875 2.34375,-0.96875 1.39063,0 2.26563,0.9375 0.875,0.9375 0.8=
75,2.65625 0,0.10937 0,0.3125 h -5.15625 q 0.0625,1.14062 0.64062,1.75 0.57=
813,0.59375 1.4375,0.59375 0.65625,0 1.10938,-0.32813 0.45312,-0.34375 0.71=
875,-1.07812 z m -3.84375,-1.90625 h 3.85937 q -0.0781,-0.85938 -0.4375,-1.=
29688 -0.5625,-0.6875 -1.45312,-0.6875 -0.8125,0 -1.35938,0.54688 -0.54687,=
0.53125 -0.60937,1.4375 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path256" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 161.95064,158.35416 q 0,0.45312 -0.125,0.85937 -0.125,0.39=
063 -0.39063,0.73438 -0.25,0.34375 -0.64062,0.60937 -0.375,0.25 -0.89063,0.=
42188 0.34375,0.125 0.54688,0.51562 0.21875,0.39063 0.34375,1.04688 l 0.343=
75,1.85937 q 0.0156,0.125 0.0312,0.23438 0.0156,0.10937 0.0156,0.1875 0,0.0=
625 -0.0312,0.10937 -0.0312,0.0469 -0.10937,0.0781 -0.0625,0.0156 -0.1875,0=
.0156 -0.125,0.0156 -0.3125,0.0156 -0.17188,0 -0.28125,-0.0156 -0.0937,0 -0=
.15625,-0.0312 -0.0469,-0.0312 -0.0781,-0.0781 -0.0156,-0.0625 -0.0312,-0.1=
4063 l -0.32812,-1.98437 q -0.0625,-0.34375 -0.15625,-0.625 -0.0937,-0.2812=
5 -0.26563,-0.48438 -0.15625,-0.20312 -0.42187,-0.3125 -0.26563,-0.10937 -0=
.64063,-0.10937 h -0.75 l -0.71875,3.59375 q -0.0156,0.0469 -0.0469,0.0937 =
-0.0312,0.0312 -0.10938,0.0469 -0.0781,0.0156 -0.1875,0.0312 -0.10937,0.015=
6 -0.26562,0.0156 -0.15625,0 -0.26563,-0.0156 -0.0937,0 -0.15625,-0.0156 -0=
.0625,-0.0312 -0.0937,-0.0625 -0.0156,-0.0469 0,-0.0937 l 1.5625,-7.8125 q =
0.0469,-0.25 0.20313,-0.34375 0.15625,-0.10938 0.34375,-0.10938 h 1.82812 q=
 0.60938,0 1.0625,0.125 0.45313,0.10938 0.75,0.34375 0.3125,0.21875 0.45313=
,0.54688 0.15625,0.32812 0.15625,0.75 z m -1.20313,0.17187 q 0,-0.21875 -0.=
0781,-0.40625 -0.0781,-0.1875 -0.25,-0.32812 -0.15625,-0.14063 -0.4375,-0.2=
0313 -0.26563,-0.0781 -0.64063,-0.0781 h -1.15625 l -0.57812,2.84375 h 0.98=
437 q 0.57813,0 0.98438,-0.15625 0.42187,-0.15625 0.67187,-0.40625 0.25,-0.=
26563 0.375,-0.59375 0.125,-0.32813 0.125,-0.67188 z m 8.93988,-1.70312 q 0=
,0.0312 0,0.10937 0,0.0625 -0.0156,0.14063 -0.0156,0.0781 -0.0469,0.17187 -=
0.0156,0.0781 -0.0625,0.14063 -0.0312,0.0625 -0.0937,0.10937 -0.0625,0.0469=
 -0.125,0.0469 h -2.35937 l -1.46875,7.29687 q -0.0156,0.0625 -0.0469,0.109=
38 -0.0312,0.0312 -0.10937,0.0469 -0.0625,0.0156 -0.17188,0.0312 -0.10937,0=
.0156 -0.28125,0.0156 -0.15625,0 -0.26562,-0.0156 -0.0937,-0.0156 -0.15625,=
-0.0312 -0.0625,-0.0156 -0.0781,-0.0469 -0.0156,-0.0469 -0.0156,-0.10938 l =
1.46875,-7.29687 h -2.35938 q -0.0937,0 -0.125,-0.0625 -0.0312,-0.0625 -0.0=
312,-0.15625 0,-0.0469 0,-0.10938 0.0156,-0.0781 0.0312,-0.15625 0.0156,-0.=
0937 0.0469,-0.17187 0.0312,-0.0781 0.0625,-0.14063 0.0469,-0.0781 0.0937,-=
0.10937 0.0469,-0.0469 0.10937,-0.0469 h 5.85938 q 0.0781,0 0.10937,0.0625 =
0.0312,0.0625 0.0312,0.17188 z m 5.83861,-0.0156 q 0,0.0312 0,0.10938 0,0.0=
625 -0.0156,0.14062 -0.0156,0.0781 -0.0469,0.15625 -0.0156,0.0781 -0.0625,0=
.15625 -0.0312,0.0625 -0.0937,0.10938 -0.0469,0.0469 -0.10937,0.0469 h -3.2=
9688 l -0.53125,2.64063 h 2.82813 q 0.0781,0 0.10937,0.0469 0.0469,0.0469 0=
.0469,0.15625 0,0.0312 -0.0156,0.10938 0,0.0625 -0.0156,0.14062 -0.0156,0.0=
781 -0.0469,0.15625 -0.0156,0.0781 -0.0469,0.14063 -0.0312,0.0625 -0.0937,0=
.10937 -0.0469,0.0469 -0.10938,0.0469 H 171.198 l -0.60938,3 h 3.34375 q 0.=
0625,0 0.10938,0.0625 0.0469,0.0469 0.0469,0.15625 0,0.0469 -0.0156,0.125 0=
,0.0625 -0.0156,0.14062 -0.0156,0.0781 -0.0469,0.15625 -0.0156,0.0781 -0.06=
25,0.15625 -0.0312,0.0625 -0.0937,0.10938 -0.0469,0.0312 -0.10938,0.0312 h =
-4.04687 q -0.0781,0 -0.15625,-0.0156 -0.0625,-0.0312 -0.10938,-0.0781 -0.0=
469,-0.0625 -0.0625,-0.14063 -0.0156,-0.0937 0.0156,-0.21875 l 1.5,-7.51562=
 q 0.0469,-0.25 0.20312,-0.34375 0.15625,-0.10938 0.29688,-0.10938 h 4 q 0.=
14062,0 0.14062,0.21875 z m 5.44538,9.9375 q 0,0.0469 0,0.10938 0,0.0625 -0=
.0156,0.125 -0.0156,0.0625 -0.0469,0.14062 -0.0312,0.0781 -0.0781,0.125 -0.=
0312,0.0625 -0.0781,0.0937 -0.0469,0.0469 -0.10938,0.0469 h -6.26562 q -0.0=
781,0 -0.10938,-0.0625 -0.0312,-0.0625 -0.0312,-0.15625 0,-0.0312 0,-0.0937=
 0,-0.0625 0.0156,-0.14063 0.0156,-0.0625 0.0469,-0.14062 0.0156,-0.0625 0.=
0625,-0.14063 0.0312,-0.0625 0.0781,-0.0937 0.0469,-0.0312 0.10937,-0.0312 =
h 6.26563 q 0.0781,0 0.10937,0.0625 0.0469,0.0625 0.0469,0.15625 z m 9.2786=
5,-9.23437 q 0,0.0469 -0.0156,0.10937 -0.0156,0.0625 -0.0312,0.14063 -0.015=
6,0.0781 -0.0469,0.15625 -0.0156,0.0781 -0.0469,0.14062 -0.0312,0.0625 -0.0=
781,0.10938 -0.0312,0.0312 -0.0781,0.0312 -0.0937,0 -0.26563,-0.10938 -0.17=
187,-0.125 -0.45312,-0.26562 -0.26563,-0.15625 -0.67188,-0.26563 -0.39062,-=
0.125 -0.9375,-0.125 -0.57812,0 -1.09375,0.17188 -0.5,0.17187 -0.92187,0.48=
437 -0.42188,0.29688 -0.75,0.70313 -0.32813,0.40625 -0.5625,0.90625 -0.2343=
8,0.48437 -0.35938,1.01562 -0.10937,0.53125 -0.10937,1.07813 0,0.5625 0.156=
25,1.01562 0.17187,0.4375 0.48437,0.73438 0.3125,0.29687 0.75,0.45312 0.437=
5,0.15625 0.98438,0.15625 0.40625,0 0.84375,-0.0937 0.45312,-0.0937 0.82812=
,-0.29687 l 0.48438,-2.4375 h -1.95313 q -0.0781,0 -0.125,-0.0469 -0.0312,-=
0.0625 -0.0312,-0.17187 0,-0.0469 0,-0.10938 0.0156,-0.0781 0.0312,-0.15625=
 0.0156,-0.0781 0.0469,-0.15625 0.0312,-0.0781 0.0625,-0.14062 0.0469,-0.06=
25 0.0937,-0.0937 0.0469,-0.0469 0.10937,-0.0469 h 2.67188 q 0.1875,0 0.265=
62,0.125 0.0781,0.125 0.0312,0.32813 l -0.64062,3.25 q -0.0312,0.125 -0.078=
1,0.20312 -0.0312,0.0625 -0.0937,0.125 -0.0469,0.0625 -0.29687,0.17188 -0.2=
3438,0.10937 -0.59375,0.23437 -0.35938,0.10938 -0.8125,0.1875 -0.45313,0.09=
37 -0.95313,0.0937 -0.84375,0 -1.48437,-0.20312 -0.64063,-0.21875 -1.07813,=
-0.64063 -0.4375,-0.42187 -0.67187,-1.01562 -0.21875,-0.59375 -0.21875,-1.3=
2813 0,-0.70312 0.15625,-1.375 0.15625,-0.67187 0.45312,-1.28125 0.3125,-0.=
60937 0.75,-1.10937 0.4375,-0.51563 1,-0.89063 0.57813,-0.375 1.25,-0.57812=
 0.6875,-0.21875 1.48438,-0.21875 0.45312,0 0.84375,0.0781 0.40625,0.0781 0=
.71875,0.20313 0.3125,0.10937 0.51562,0.25 0.21875,0.125 0.29688,0.20312 0.=
0781,0.0625 0.10937,0.14063 0.0312,0.0625 0.0312,0.15625 z m 6.9863,0.84375=
 q 0,0.45312 -0.125,0.85937 -0.125,0.39063 -0.39062,0.73438 -0.25,0.34375 -=
0.64063,0.60937 -0.375,0.25 -0.89062,0.42188 0.34375,0.125 0.54687,0.51562 =
0.21875,0.39063 0.34375,1.04688 l 0.34375,1.85937 q 0.0156,0.125 0.0312,0.2=
3438 0.0156,0.10937 0.0156,0.1875 0,0.0625 -0.0312,0.10937 -0.0312,0.0469 -=
0.10938,0.0781 -0.0625,0.0156 -0.1875,0.0156 -0.125,0.0156 -0.3125,0.0156 -=
0.17187,0 -0.28125,-0.0156 -0.0937,0 -0.15625,-0.0312 -0.0469,-0.0312 -0.07=
81,-0.0781 -0.0156,-0.0625 -0.0312,-0.14063 l -0.32813,-1.98437 q -0.0625,-=
0.34375 -0.15625,-0.625 -0.0937,-0.28125 -0.26562,-0.48438 -0.15625,-0.2031=
2 -0.42188,-0.3125 -0.26562,-0.10937 -0.64062,-0.10937 h -0.75 l -0.71875,3=
.59375 q -0.0156,0.0469 -0.0469,0.0937 -0.0312,0.0312 -0.10937,0.0469 -0.07=
81,0.0156 -0.1875,0.0312 -0.10938,0.0156 -0.26563,0.0156 -0.15625,0 -0.2656=
2,-0.0156 -0.0937,0 -0.15625,-0.0156 -0.0625,-0.0312 -0.0937,-0.0625 -0.015=
6,-0.0469 0,-0.0937 l 1.5625,-7.8125 q 0.0469,-0.25 0.20312,-0.34375 0.1562=
5,-0.10938 0.34375,-0.10938 h 1.82813 q 0.60937,0 1.0625,0.125 0.45312,0.10=
938 0.75,0.34375 0.3125,0.21875 0.45312,0.54688 0.15625,0.32812 0.15625,0.7=
5 z m -1.20312,0.17187 q 0,-0.21875 -0.0781,-0.40625 -0.0781,-0.1875 -0.25,=
-0.32812 -0.15625,-0.14063 -0.4375,-0.20313 -0.26562,-0.0781 -0.64062,-0.07=
81 h -1.15625 l -0.57813,2.84375 h 0.98438 q 0.57812,0 0.98437,-0.15625 0.4=
2188,-0.15625 0.67188,-0.40625 0.25,-0.26563 0.375,-0.59375 0.125,-0.32813 =
0.125,-0.67188 z m 8.42425,6.09375 q 0.0312,0.14063 0.0156,0.23438 -0.0156,=
0.0781 -0.0781,0.125 -0.0469,0.0469 -0.1875,0.0469 -0.125,0.0156 -0.34375,0=
.0156 -0.14062,0 -0.25,-0.0156 -0.10937,0 -0.17187,-0.0156 -0.0469,-0.0312 =
-0.0781,-0.0625 -0.0156,-0.0469 -0.0312,-0.0937 l -0.3125,-2.0625 h -3.5 l =
-1.09375,2.03125 q -0.0469,0.0781 -0.0937,0.125 -0.0312,0.0312 -0.10937,0.0=
625 -0.0781,0.0156 -0.20313,0.0156 -0.10937,0.0156 -0.28125,0.0156 -0.20312=
,0 -0.3125,-0.0156 -0.125,-0.0156 -0.15625,-0.0469 -0.0469,-0.0469 -0.0312,=
-0.14063 0.0156,-0.0937 0.0937,-0.23437 l 4.375,-7.8125 q 0.0469,-0.0781 0.=
0937,-0.125 0.0625,-0.0469 0.14063,-0.0625 0.0937,-0.0312 0.21875,-0.0312 0=
.125,-0.0156 0.3125,-0.0156 0.21875,0 0.34375,0.0156 0.14062,0 0.21875,0.03=
12 0.0937,0.0156 0.125,0.0625 0.0312,0.0469 0.0469,0.125 z m -2.1875,-6.906=
25 v 0 l -2.28125,4.1875 h 2.92188 z m 9.93059,0.85938 q 0,0.34375 -0.0781,=
0.71875 -0.0781,0.375 -0.26562,0.73437 -0.17188,0.35938 -0.4375,0.6875 -0.2=
6563,0.32813 -0.65625,0.57813 -0.375,0.23437 -0.875,0.375 -0.5,0.14062 -1.1=
875,0.14062 h -1.15625 l -0.59375,3.04688 q -0.0156,0.0469 -0.0469,0.0937 -=
0.0312,0.0312 -0.10937,0.0469 -0.0781,0.0156 -0.1875,0.0312 -0.10938,0.0156=
 -0.26563,0.0156 -0.15625,0 -0.26562,-0.0156 -0.0937,0 -0.15625,-0.0156 -0.=
0625,-0.0312 -0.0937,-0.0625 -0.0156,-0.0469 0,-0.0937 l 1.54687,-7.78125 q=
 0.0469,-0.26563 0.20313,-0.375 0.17187,-0.10938 0.39062,-0.10938 h 1.65625=
 q 0.32813,0 0.57813,0.0312 0.25,0.0156 0.48437,0.0625 0.35938,0.0781 0.640=
63,0.25 0.28125,0.15625 0.46875,0.40625 0.20312,0.23438 0.29687,0.54688 0.1=
0938,0.3125 0.10938,0.6875 z m -1.1875,0.10937 q 0,-0.40625 -0.20313,-0.687=
5 -0.1875,-0.29687 -0.60937,-0.40625 -0.15625,-0.0469 -0.34375,-0.0625 -0.1=
875,-0.0156 -0.40625,-0.0156 h -1.04688 l -0.67187,3.375 h 1.0625 q 0.46875=
,0 0.78125,-0.0937 0.32812,-0.10938 0.5625,-0.28125 0.25,-0.17188 0.40625,-=
0.39063 0.17187,-0.23437 0.26562,-0.46875 0.10938,-0.25 0.15625,-0.5 0.0469=
,-0.25 0.0469,-0.46875 z m 7.76033,6.17188 q -0.0156,0.0469 -0.0469,0.0937 =
-0.0312,0.0312 -0.10937,0.0469 -0.0625,0.0156 -0.17188,0.0312 -0.10937,0.01=
56 -0.28125,0.0156 -0.15625,0 -0.26562,-0.0156 -0.0937,-0.0156 -0.15625,-0.=
0312 -0.0625,-0.0156 -0.0781,-0.0469 -0.0156,-0.0469 0,-0.0937 l 0.73438,-3=
.75 h -3.82813 l -0.73437,3.75 q -0.0156,0.0469 -0.0469,0.0937 -0.0312,0.03=
12 -0.10937,0.0469 -0.0781,0.0156 -0.1875,0.0312 -0.10938,0.0156 -0.26563,0=
.0156 -0.17187,0 -0.28125,-0.0156 -0.0937,-0.0156 -0.15625,-0.0312 -0.0469,=
-0.0156 -0.0781,-0.0469 -0.0156,-0.0469 0,-0.0937 l 1.60937,-8.10938 q 0.01=
56,-0.0312 0.0469,-0.0625 0.0469,-0.0469 0.10937,-0.0625 0.0781,-0.0312 0.1=
875,-0.0469 0.10938,-0.0156 0.26563,-0.0156 0.15625,0 0.26562,0.0156 0.1093=
8,0.0156 0.15625,0.0469 0.0625,0.0156 0.0781,0.0625 0.0156,0.0312 0.0156,0.=
0625 l -0.67187,3.39063 h 3.82812 l 0.67188,-3.39063 q 0.0156,-0.0312 0.046=
9,-0.0625 0.0312,-0.0469 0.0937,-0.0625 0.0781,-0.0312 0.1875,-0.0469 0.109=
38,-0.0156 0.28125,-0.0156 0.15625,0 0.25,0.0156 0.10938,0.0156 0.17188,0.0=
469 0.0625,0.0156 0.0781,0.0625 0.0156,0.0312 0,0.0625 z m 7.38217,1.89062 =
q 0,0.0469 0,0.10938 0,0.0625 -0.0156,0.125 -0.0156,0.0625 -0.0469,0.14062 =
-0.0312,0.0781 -0.0781,0.125 -0.0312,0.0625 -0.0781,0.0937 -0.0469,0.0469 -=
0.10938,0.0469 h -6.26562 q -0.0781,0 -0.10938,-0.0625 -0.0312,-0.0625 -0.0=
312,-0.15625 0,-0.0312 0,-0.0937 0,-0.0625 0.0156,-0.14063 0.0156,-0.0625 0=
.0469,-0.14062 0.0156,-0.0625 0.0625,-0.14063 0.0312,-0.0625 0.0781,-0.0937=
 0.0469,-0.0312 0.10937,-0.0312 h 6.26563 q 0.0781,0 0.10937,0.0625 0.0469,=
0.0625 0.0469,0.15625 z m 7.49741,-9.9375 q 0,0.0469 0,0.10938 0,0.0625 -0.=
0156,0.14062 -0.0156,0.0781 -0.0469,0.17188 -0.0312,0.0781 -0.0781,0.15625 =
-0.0312,0.0625 -0.0781,0.10937 -0.0469,0.0469 -0.125,0.0469 h -3.07813 l -0=
.5625,2.85937 h 2.90625 q 0.0781,0 0.10938,0.0625 0.0469,0.0469 0.0469,0.14=
063 0,0.0625 -0.0156,0.14062 0,0.0625 -0.0156,0.14063 -0.0156,0.0625 -0.046=
9,0.15625 -0.0156,0.0781 -0.0625,0.14062 -0.0312,0.0625 -0.0937,0.10938 -0.=
0469,0.0469 -0.10938,0.0469 h -2.90625 l -0.70312,3.5 q -0.0156,0.0625 -0.0=
469,0.10938 -0.0312,0.0312 -0.10937,0.0469 -0.0625,0.0156 -0.17188,0.0312 -=
0.10937,0.0156 -0.28125,0.0156 -0.15625,0 -0.26562,-0.0156 -0.10938,-0.0156=
 -0.17188,-0.0312 -0.0469,-0.0156 -0.0781,-0.0469 -0.0156,-0.0469 0,-0.1093=
8 l 1.5625,-7.79687 q 0.0469,-0.25 0.20312,-0.34375 0.15625,-0.10938 0.2968=
8,-0.10938 h 3.78125 q 0.0937,0 0.125,0.0625 0.0312,0.0625 0.0312,0.15625 z=
 m 6.32704,0 q 0,0.0312 0,0.10938 0,0.0625 -0.0156,0.14062 -0.0156,0.0781 -=
0.0469,0.15625 -0.0156,0.0781 -0.0625,0.15625 -0.0312,0.0625 -0.0937,0.1093=
8 -0.0469,0.0469 -0.10938,0.0469 h -3.29687 l -0.53125,2.64063 h 2.82812 q =
0.0781,0 0.10938,0.0469 0.0469,0.0469 0.0469,0.15625 0,0.0312 -0.0156,0.109=
38 0,0.0625 -0.0156,0.14062 -0.0156,0.0781 -0.0469,0.15625 -0.0156,0.0781 -=
0.0469,0.14063 -0.0312,0.0625 -0.0937,0.10937 -0.0469,0.0469 -0.10937,0.046=
9 H 235.652 l -0.60937,3 h 3.34375 q 0.0625,0 0.10937,0.0625 0.0469,0.0469 =
0.0469,0.15625 0,0.0469 -0.0156,0.125 0,0.0625 -0.0156,0.14062 -0.0156,0.07=
81 -0.0469,0.15625 -0.0156,0.0781 -0.0625,0.15625 -0.0312,0.0625 -0.0937,0.=
10938 -0.0469,0.0312 -0.10937,0.0312 h -4.04688 q -0.0781,0 -0.15625,-0.015=
6 -0.0625,-0.0312 -0.10937,-0.0781 -0.0469,-0.0625 -0.0625,-0.14063 -0.0156=
,-0.0937 0.0156,-0.21875 l 1.5,-7.51562 q 0.0469,-0.25 0.20313,-0.34375 0.1=
5625,-0.10938 0.29687,-0.10938 h 4 q 0.14063,0 0.14063,0.21875 z m 6.711,7.=
73438 q -0.0156,0.14062 -0.0781,0.23437 -0.0625,0.0781 -0.14062,0.14063 -0.=
0625,0.0625 -0.15625,0.0937 -0.0781,0.0156 -0.17188,0.0156 h -0.42187 q -0.=
17188,0 -0.29688,-0.0312 -0.10937,-0.0469 -0.20312,-0.14062 -0.0781,-0.0937=
 -0.15625,-0.23438 -0.0625,-0.15625 -0.14063,-0.39062 l -1.57812,-4.48438 q=
 -0.15625,-0.48437 -0.32813,-0.95312 -0.15625,-0.48438 -0.29687,-0.96875 h =
-0.0156 q -0.0781,0.53125 -0.1875,1.0625 -0.0937,0.51562 -0.20312,1.04687 l=
 -0.96875,4.90625 q -0.0156,0.0625 -0.0625,0.10938 -0.0312,0.0312 -0.0937,0=
.0469 -0.0625,0.0156 -0.17188,0.0312 -0.10937,0.0156 -0.26562,0.0156 -0.140=
63,0 -0.25,-0.0156 -0.0937,-0.0156 -0.15625,-0.0312 -0.0469,-0.0156 -0.0625=
,-0.0469 -0.0156,-0.0469 0,-0.10938 l 1.54687,-7.76562 q 0.0469,-0.26563 0.=
21875,-0.375 0.17188,-0.10938 0.34375,-0.10938 h 0.5 q 0.15625,0 0.26563,0.=
0312 0.125,0.0312 0.20312,0.125 0.0937,0.0781 0.15625,0.21875 0.0781,0.125 =
0.15625,0.32813 l 1.59375,4.5625 q 0.14063,0.42187 0.28125,0.84375 0.15625,=
0.42187 0.29688,0.84375 h 0.0156 q 0.0937,-0.53125 0.20313,-1.09375 0.10937=
,-0.57813 0.20312,-1.10938 l 0.92188,-4.5625 q 0.0156,-0.0625 0.0469,-0.093=
7 0.0312,-0.0312 0.0937,-0.0625 0.0625,-0.0312 0.15625,-0.0312 0.10938,-0.0=
156 0.26563,-0.0156 0.15625,0 0.25,0.0156 0.10937,0 0.15625,0.0312 0.0625,0=
.0312 0.0781,0.0625 0.0156,0.0312 0.0156,0.0937 z m 9.09039,-7.09375 q 0,0.=
14062 -0.0469,0.34375 -0.0469,0.20312 -0.125,0.32812 -0.0781,0.10938 -0.156=
25,0.10938 -0.0937,0 -0.21875,-0.125 -0.125,-0.125 -0.32812,-0.26563 -0.203=
13,-0.14062 -0.53125,-0.25 -0.32813,-0.125 -0.82813,-0.125 -0.54687,0 -1,0.=
20313 -0.4375,0.20312 -0.8125,0.5625 -0.35937,0.34375 -0.64062,0.79687 -0.2=
6563,0.45313 -0.45313,0.95313 -0.17187,0.5 -0.26562,1.01562 -0.0781,0.5 -0.=
0781,0.95313 0,0.51562 0.125,0.92187 0.125,0.40625 0.375,0.6875 0.25,0.2812=
5 0.60938,0.42188 0.35937,0.14062 0.8125,0.14062 0.51562,0 0.875,-0.10937 0=
.375,-0.10938 0.625,-0.25 0.26562,-0.14063 0.4375,-0.25 0.1875,-0.125 0.296=
87,-0.125 0.0781,0 0.10938,0.0625 0.0312,0.0469 0.0312,0.15625 0,0.0312 -0.=
0156,0.0937 -0.0156,0.0625 -0.0312,0.14062 0,0.0625 -0.0156,0.15625 -0.0156=
,0.0781 -0.0469,0.15625 -0.0312,0.0625 -0.0625,0.125 -0.0156,0.0625 -0.0937=
,0.125 -0.0625,0.0625 -0.28125,0.20313 -0.21875,0.125 -0.53125,0.23437 -0.3=
125,0.10938 -0.71875,0.1875 -0.39062,0.0937 -0.82812,0.0937 -0.67188,0 -1.2=
0313,-0.20312 -0.53125,-0.20313 -0.90625,-0.57813 -0.375,-0.39062 -0.57812,=
-0.96875 -0.20313,-0.57812 -0.20313,-1.32812 0,-0.60938 0.125,-1.26563 0.14=
063,-0.65625 0.39063,-1.26562 0.25,-0.625 0.625,-1.17188 0.39062,-0.54687 0=
.89062,-0.95312 0.5,-0.42188 1.125,-0.65625 0.64063,-0.25 1.39063,-0.25 0.4=
8437,0 0.89062,0.10937 0.42188,0.10938 0.70313,0.28125 0.29687,0.15625 0.42=
187,0.28125 0.14063,0.125 0.14063,0.29688 z m 6.26028,-0.64063 q 0,0.0312 0=
,0.10938 0,0.0625 -0.0156,0.14062 -0.0156,0.0781 -0.0469,0.15625 -0.0156,0.=
0781 -0.0625,0.15625 -0.0312,0.0625 -0.0937,0.10938 -0.0469,0.0469 -0.10937=
,0.0469 h -3.29688 l -0.53125,2.64063 h 2.82813 q 0.0781,0 0.10937,0.0469 0=
.0469,0.0469 0.0469,0.15625 0,0.0312 -0.0156,0.10938 0,0.0625 -0.0156,0.140=
62 -0.0156,0.0781 -0.0469,0.15625 -0.0156,0.0781 -0.0469,0.14063 -0.0312,0.=
0625 -0.0937,0.10937 -0.0469,0.0469 -0.10938,0.0469 h -2.82812 l -0.60936,3=
 h 3.34373 q 0.0625,0 0.10938,0.0625 0.0469,0.0469 0.0469,0.15625 0,0.0469 =
-0.0156,0.125 0,0.0625 -0.0156,0.14062 -0.0156,0.0781 -0.0469,0.15625 -0.01=
56,0.0781 -0.0625,0.15625 -0.0312,0.0625 -0.0937,0.10938 -0.0469,0.0312 -0.=
10938,0.0312 h -4.04686 q -0.0781,0 -0.15625,-0.0156 -0.0625,-0.0312 -0.109=
37,-0.0781 -0.0469,-0.0625 -0.0625,-0.14063 -0.0156,-0.0937 0.0156,-0.21875=
 l 1.49999,-7.51562 q 0.0469,-0.25 0.20312,-0.34375 0.15625,-0.10938 0.2968=
8,-0.10938 h 4 q 0.14062,0 0.14062,0.21875 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path258" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 173.78297,198.86352 1.26562,0.3125 q -0.39062,1.5625 -1.42=
187,2.375 -1.03125,0.8125 -2.53125,0.8125 -1.53125,0 -2.5,-0.625 -0.96875,-=
0.625 -1.48438,-1.8125 -0.5,-1.1875 -0.5,-2.5625 0,-1.48438 0.5625,-2.59375=
 0.57813,-1.10938 1.625,-1.6875 1.0625,-0.57813 2.32813,-0.57813 1.42187,0 =
2.39062,0.73438 0.98438,0.71875 1.375,2.04687 l -1.25,0.29688 q -0.32812,-1=
.04688 -0.96875,-1.51563 -0.625,-0.48437 -1.57812,-0.48437 -1.09375,0 -1.84=
375,0.53125 -0.73438,0.53125 -1.03125,1.42187 -0.29688,0.875 -0.29688,1.828=
13 0,1.21875 0.34375,2.125 0.35938,0.90625 1.10938,1.35937 0.75,0.4375 1.62=
5,0.4375 1.0625,0 1.79687,-0.60937 0.73438,-0.60938 0.98438,-1.8125 z m 2.6=
8765,-4.84375 v -1.35938 h 1.17188 v 1.35938 z m 0,8.1875 v -6.90625 h 1.17=
188 v 6.90625 z m 2.92984,0 v -6.90625 h 1.0625 v 1.04687 q 0.40625,-0.7343=
7 0.73438,-0.96875 0.34375,-0.23437 0.76562,-0.23437 0.59375,0 1.20313,0.37=
5 l -0.40625,1.07812 q -0.4375,-0.25 -0.85938,-0.25 -0.39062,0 -0.70312,0.2=
3438 -0.29688,0.23437 -0.42188,0.64062 -0.20312,0.625 -0.20312,1.35938 v 3.=
625 z m 8.96962,-2.53125 1.15625,0.15625 q -0.1875,1.1875 -0.96875,1.85937 =
-0.78125,0.67188 -1.92187,0.67188 -1.40625,0 -2.28125,-0.92188 -0.85938,-0.=
9375 -0.85938,-2.65625 0,-1.125 0.375,-1.96875 0.375,-0.84375 1.125,-1.25 0=
.76563,-0.42187 1.65625,-0.42187 1.125,0 1.84375,0.57812 0.71875,0.5625 0.9=
2188,1.60938 l -1.14063,0.17187 q -0.17187,-0.70312 -0.59375,-1.04687 -0.40=
625,-0.35938 -0.98437,-0.35938 -0.89063,0 -1.45313,0.64063 -0.54687,0.64062=
 -0.54687,2 0,1.40625 0.53125,2.03125 0.54687,0.625 1.40625,0.625 0.6875,0 =
1.14062,-0.42188 0.46875,-0.42187 0.59375,-1.29687 z m 6.67969,2.53125 v -1=
.01563 q -0.8125,1.17188 -2.1875,1.17188 -0.60937,0 -1.14062,-0.23438 -0.53=
125,-0.23437 -0.79688,-0.57812 -0.25,-0.35938 -0.35937,-0.875 -0.0625,-0.34=
375 -0.0625,-1.09375 v -4.28125 h 1.17187 v 3.82812 q 0,0.92188 0.0625,1.23=
438 0.10938,0.46875 0.46875,0.73437 0.35938,0.25 0.89063,0.25 0.51562,0 0.9=
8437,-0.26562 0.46875,-0.26563 0.65625,-0.73438 0.1875,-0.46875 0.1875,-1.3=
4375 v -3.70312 h 1.17188 v 6.90625 z m 2.8656,0 v -9.54688 h 1.17188 v 9.5=
4688 z m 7.49234,-0.85938 q -0.65625,0.5625 -1.26562,0.79688 -0.59375,0.218=
75 -1.28125,0.21875 -1.14063,0 -1.75,-0.54688 -0.60938,-0.5625 -0.60938,-1.=
4375 0,-0.5 0.21875,-0.92187 0.23438,-0.42188 0.60938,-0.67188 0.375,-0.25 =
0.84375,-0.39062 0.34375,-0.0781 1.04687,-0.17188 1.42188,-0.17187 2.09375,=
-0.40625 0,-0.23437 0,-0.29687 0,-0.71875 -0.32812,-1.01563 -0.45313,-0.390=
62 -1.34375,-0.39062 -0.8125,0 -1.21875,0.29687 -0.39063,0.28125 -0.57813,1=
.01563 l -1.14062,-0.15625 q 0.15625,-0.73438 0.51562,-1.1875 0.35938,-0.45=
313 1.03125,-0.6875 0.67188,-0.25 1.5625,-0.25 0.89063,0 1.4375,0.20312 0.5=
625,0.20313 0.8125,0.53125 0.26563,0.3125 0.375,0.79688 0.0469,0.29687 0.04=
69,1.07812 v 1.5625 q 0,1.625 0.0781,2.0625 0.0781,0.4375 0.29688,0.82813 h=
 -1.21875 q -0.1875,-0.35938 -0.23438,-0.85938 z m -0.0937,-2.60937 q -0.64=
062,0.26562 -1.92187,0.4375 -0.71875,0.10937 -1.01563,0.25 -0.29687,0.125 -=
0.46875,0.375 -0.15625,0.25 -0.15625,0.54687 0,0.46875 0.34375,0.78125 0.35=
938,0.3125 1.04688,0.3125 0.67187,0 1.20312,-0.29687 0.53125,-0.29688 0.781=
25,-0.8125 0.1875,-0.39063 0.1875,-1.17188 z m 2.97498,3.46875 v -6.90625 h=
 1.0625 v 1.04687 q 0.40625,-0.73437 0.73437,-0.96875 0.34375,-0.23437 0.76=
563,-0.23437 0.59375,0 1.20312,0.375 l -0.40625,1.07812 q -0.4375,-0.25 -0.=
85937,-0.25 -0.39063,0 -0.70313,0.23438 -0.29687,0.23437 -0.42187,0.64062 -=
0.20313,0.625 -0.20313,1.35938 v 3.625 z m 8.25073,0 v -9.54688 h 3.59375 q=
 1.09375,0 1.75,0.29688 0.65625,0.28125 1.03125,0.89062 0.375,0.60938 0.375=
,1.26563 0,0.60937 -0.34375,1.15625 -0.32813,0.53125 -0.98438,0.85937 0.859=
38,0.25 1.32813,0.875 0.46875,0.60938 0.46875,1.4375 0,0.67188 -0.29688,1.2=
5 -0.28125,0.57813 -0.70312,0.89063 -0.40625,0.3125 -1.03125,0.46875 -0.625=
,0.15625 -1.54688,0.15625 z m 1.26562,-5.53125 h 2.0625 q 0.84375,0 1.20313=
,-0.10938 0.48437,-0.14062 0.71875,-0.46875 0.25,-0.34375 0.25,-0.84375 0,-=
0.46875 -0.23438,-0.82812 -0.21875,-0.35938 -0.64062,-0.5 -0.42188,-0.14063=
 -1.45313,-0.14063 h -1.90625 z m 0,4.40625 h 2.375 q 0.60938,0 0.85938,-0.=
0469 0.4375,-0.0781 0.73437,-0.25 0.29688,-0.1875 0.48438,-0.53125 0.1875,-=
0.35937 0.1875,-0.8125 0,-0.53125 -0.28125,-0.92187 -0.26563,-0.40625 -0.75=
,-0.5625 -0.48438,-0.15625 -1.40625,-0.15625 h -2.20313 z m 12.06163,1.125 =
v -1.01563 q -0.8125,1.17188 -2.1875,1.17188 -0.60937,0 -1.14062,-0.23438 -=
0.53125,-0.23437 -0.79688,-0.57812 -0.25,-0.35938 -0.35937,-0.875 -0.0625,-=
0.34375 -0.0625,-1.09375 v -4.28125 h 1.17187 v 3.82812 q 0,0.92188 0.0625,=
1.23438 0.10938,0.46875 0.46875,0.73437 0.35938,0.25 0.89063,0.25 0.51562,0=
 0.98437,-0.26562 0.46875,-0.26563 0.65625,-0.73438 0.1875,-0.46875 0.1875,=
-1.34375 v -3.70312 h 1.17188 v 6.90625 z m 3.16248,0 v -6 h -1.03125 v -0.=
90625 h 1.03125 v -0.73438 q 0,-0.70312 0.125,-1.04687 0.17187,-0.45313 0.5=
9375,-0.73438 0.42187,-0.28125 1.20312,-0.28125 0.48438,0 1.09375,0.10938 l=
 -0.1875,1.03125 q -0.35937,-0.0625 -0.6875,-0.0625 -0.53125,0 -0.75,0.2343=
7 -0.21875,0.21875 -0.21875,0.84375 v 0.64063 h 1.34375 v 0.90625 h -1.3437=
5 v 6 z m 3.4621,0 v -6 h -1.03125 v -0.90625 h 1.03125 v -0.73438 q 0,-0.7=
0312 0.125,-1.04687 0.17187,-0.45313 0.59375,-0.73438 0.42187,-0.28125 1.20=
312,-0.28125 0.48438,0 1.09375,0.10938 l -0.1875,1.03125 q -0.35937,-0.0625=
 -0.6875,-0.0625 -0.53125,0 -0.75,0.23437 -0.21875,0.21875 -0.21875,0.84375=
 v 0.64063 h 1.34375 v 0.90625 h -1.34375 v 6 z m 8.15611,-2.21875 1.20312,=
0.14062 q -0.28125,1.0625 -1.0625,1.65625 -0.76562,0.57813 -1.96875,0.57813=
 -1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375 -0.89062,-2.60938 0,-1.75 0.8=
9062,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.39063,0 2.26563,0.9375 0.=
875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.15625 q 0.0625,1.14062 0.6=
4062,1.75 0.57813,0.59375 1.4375,0.59375 0.65625,0 1.10938,-0.32813 0.45312=
,-0.34375 0.71875,-1.07812 z m -3.84375,-1.90625 h 3.85937 q -0.0781,-0.859=
38 -0.4375,-1.29688 -0.5625,-0.6875 -1.45312,-0.6875 -0.8125,0 -1.35938,0.5=
4688 -0.54687,0.53125 -0.60937,1.4375 z m 6.50622,4.125 v -6.90625 h 1.0625=
 v 1.04687 q 0.40625,-0.73437 0.73438,-0.96875 0.34375,-0.23437 0.76562,-0.=
23437 0.59375,0 1.20313,0.375 l -0.40625,1.07812 q -0.4375,-0.25 -0.85938,-=
0.25 -0.39062,0 -0.70312,0.23438 -0.29688,0.23437 -0.42188,0.64062 -0.20312=
,0.625 -0.20312,1.35938 v 3.625 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path260" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 187.94858,237.4041 v -9.54687 h 1.29687 l 5.01563,7.5 v -7=
.5 h 1.20312 v 9.54687 h -1.29687 l -5.01563,-7.5 v 7.5 z m 9.04703,-3.4531=
2 q 0,-1.92188 1.07812,-2.84375 0.89063,-0.76563 2.17188,-0.76563 1.42187,0=
 2.32812,0.9375 0.90625,0.92188 0.90625,2.57813 0,1.32812 -0.40625,2.09375 =
-0.39062,0.76562 -1.15625,1.1875 -0.76562,0.42187 -1.67187,0.42187 -1.45313=
,0 -2.35938,-0.92187 -0.89062,-0.9375 -0.89062,-2.6875 z m 1.20312,0 q 0,1.=
32812 0.57813,1.98437 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45312,-0.65=
625 0.57813,-0.67187 0.57813,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57813,=
-0.65625 -1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57813,0.65625 -0.578=
13,1.98438 z m 11.13123,3.45312 v -0.875 q -0.65625,1.03125 -1.9375,1.03125=
 -0.8125,0 -1.51563,-0.45312 -0.6875,-0.45313 -1.07812,-1.26563 -0.375,-0.8=
2812 -0.375,-1.89062 0,-1.03125 0.34375,-1.875 0.34375,-0.84375 1.03125,-1.=
28125 0.70312,-0.45313 1.54687,-0.45313 0.625,0 1.10938,0.26563 0.5,0.25 0.=
79687,0.67187 v -3.42187 h 1.17188 v 9.54687 z m -3.70313,-3.45312 q 0,1.32=
812 0.5625,1.98437 0.5625,0.65625 1.32813,0.65625 0.76562,0 1.29687,-0.625 =
0.53125,-0.625 0.53125,-1.90625 0,-1.42187 -0.54687,-2.07812 -0.54688,-0.67=
188 -1.34375,-0.67188 -0.78125,0 -1.3125,0.64063 -0.51563,0.625 -0.51563,2 =
z m 11.36561,1.23437 1.20312,0.14063 q -0.28125,1.0625 -1.0625,1.65625 -0.7=
6562,0.57812 -1.96875,0.57812 -1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375 =
-0.89062,-2.60937 0,-1.75 0.89062,-2.70313 0.90625,-0.96875 2.34375,-0.9687=
5 1.39063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,0.10938 0,0.3125 h =
-5.15625 q 0.0625,1.14063 0.64062,1.75 0.57813,0.59375 1.4375,0.59375 0.656=
25,0 1.10938,-0.32812 0.45312,-0.34375 0.71875,-1.07813 z m -3.84375,-1.906=
25 h 3.85937 q -0.0781,-0.85937 -0.4375,-1.29687 -0.5625,-0.6875 -1.45312,-=
0.6875 -0.8125,0 -1.35938,0.54687 -0.54687,0.53125 -0.60937,1.4375 z m 9.89=
671,-0.57812 q 0,-1.6875 0.34375,-2.71875 0.35937,-1.03125 1.04687,-1.59375=
 0.6875,-0.5625 1.71875,-0.5625 0.78125,0 1.35938,0.3125 0.57812,0.29687 0.=
95312,0.89062 0.375,0.57813 0.59375,1.42188 0.21875,0.82812 0.21875,2.25 0,=
1.67187 -0.35937,2.70312 -0.34375,1.03125 -1.03125,1.59375 -0.67188,0.5625 =
-1.73438,0.5625 -1.375,0 -2.15625,-0.98437 -0.95312,-1.1875 -0.95312,-3.875=
 z m 1.20312,0 q 0,2.34375 0.54688,3.125 0.5625,0.78125 1.35937,0.78125 0.8=
125,0 1.35938,-0.78125 0.5625,-0.78125 0.5625,-3.125 0,-2.35938 -0.5625,-3.=
125 -0.54688,-0.78125 -1.35938,-0.78125 -0.8125,0 -1.29687,0.6875 -0.60938,=
0.875 -0.60938,3.21875 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path262" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 164.51677,251.04473 1.1875,-0.0781 q 0,0.51562 0.15625,0.8=
75 0.15625,0.35937 0.57812,0.59375 0.42188,0.21875 0.96875,0.21875 0.78125,=
0 1.17188,-0.3125 0.39062,-0.3125 0.39062,-0.73438 0,-0.3125 -0.23437,-0.57=
812 -0.23438,-0.28125 -1.17188,-0.67188 -0.9375,-0.40625 -1.1875,-0.57812 -=
0.4375,-0.26563 -0.67187,-0.625 -0.21875,-0.35938 -0.21875,-0.82813 0,-0.81=
25 0.65625,-1.39062 0.65625,-0.59375 1.82812,-0.59375 1.29688,0 1.96875,0.6=
0937 0.6875,0.59375 0.71875,1.57813 l -1.15625,0.0781 q -0.0312,-0.625 -0.4=
5312,-0.98437 -0.40625,-0.375 -1.17188,-0.375 -0.60937,0 -0.95312,0.28125 -=
0.32813,0.28125 -0.32813,0.60937 0,0.3125 0.29688,0.5625 0.1875,0.17188 1,0=
.53125 1.35937,0.57813 1.70312,0.92188 0.5625,0.53125 0.5625,1.3125 0,0.515=
62 -0.3125,1.01562 -0.3125,0.48438 -0.96875,0.78125 -0.64062,0.29688 -1.515=
62,0.29688 -1.20313,0 -2.04688,-0.59375 -0.84375,-0.59375 -0.79687,-1.92188=
 z m 9.32031,1.40625 -0.20312,0.95313 q -0.42188,0.10937 -0.8125,0.10937 -0=
.70313,0 -1.125,-0.34375 -0.3125,-0.25 -0.3125,-0.70312 0,-0.23438 0.17187,=
-1.04688 l 0.82813,-4.01562 h -0.92188 l 0.1875,-0.90625 h 0.9375 l 0.34375=
,-1.70313 1.35938,-0.8125 -0.53125,2.51563 h 1.15625 l -0.1875,0.90625 h -1=
.15625 l -0.79688,3.8125 q -0.15625,0.73437 -0.15625,0.875 0,0.21875 0.1093=
8,0.32812 0.125,0.10938 0.40625,0.10938 0.39062,0 0.70312,-0.0781 z m 0.937=
37,0.95313 1.45312,-6.90625 h 1.03125 l -0.28125,1.40625 q 0.53125,-0.79688=
 1.03125,-1.17188 0.51563,-0.39062 1.04688,-0.39062 0.35937,0 0.875,0.25 l =
-0.48438,1.09375 q -0.3125,-0.21875 -0.67187,-0.21875 -0.625,0 -1.28125,0.6=
875 -0.64063,0.6875 -1.01563,2.48437 l -0.57812,2.76563 z m 9.15712,-1.25 q=
 -1.23438,1.40625 -2.54688,1.40625 -0.79687,0 -1.29687,-0.45313 -0.48438,-0=
.46875 -0.48438,-1.125 0,-0.4375 0.21875,-1.5 l 0.84375,-3.98437 h 1.17188 =
l -0.92188,4.40625 q -0.10937,0.5625 -0.10937,0.85937 0,0.39063 0.23437,0.6=
0938 0.23438,0.21875 0.70313,0.21875 0.48437,0 0.95312,-0.23438 0.48438,-0.=
23437 0.8125,-0.64062 0.34375,-0.42188 0.5625,-0.98438 0.14063,-0.35937 0.3=
2813,-1.25 l 0.625,-2.98437 h 1.1875 l -1.45313,6.90625 h -1.07812 z m 7.47=
497,-1.26563 1.17188,0.125 q -0.4375,1.29688 -1.26563,1.92188 -0.8125,0.625=
 -1.84375,0.625 -1.14062,0 -1.84375,-0.71875 -0.6875,-0.73438 -0.6875,-2.04=
688 0,-1.125 0.4375,-2.21875 0.45313,-1.09375 1.28125,-1.65625 0.84375,-0.5=
7812 1.92188,-0.57812 1.10937,0 1.76562,0.625 0.65625,0.625 0.65625,1.65625=
 l -1.15625,0.0781 q -0.0156,-0.65625 -0.39062,-1.01562 -0.375,-0.375 -0.98=
438,-0.375 -0.70312,0 -1.23437,0.45312 -0.51563,0.4375 -0.8125,1.35938 -0.2=
9688,0.90625 -0.29688,1.75 0,0.89062 0.39063,1.34375 0.39062,0.4375 0.96875=
,0.4375 0.5625,0 1.07812,-0.4375 0.53125,-0.4375 0.84375,-1.32813 z m 4.648=
44,1.5625 -0.20313,0.95313 q -0.42187,0.10937 -0.8125,0.10937 -0.70312,0 -1=
.125,-0.34375 -0.3125,-0.25 -0.3125,-0.70312 0,-0.23438 0.17188,-1.04688 l =
0.82812,-4.01562 h -0.92187 l 0.1875,-0.90625 h 0.9375 l 0.34375,-1.70313 1=
.35937,-0.8125 -0.53125,2.51563 h 1.15625 l -0.1875,0.90625 h -1.15625 l -0=
.79687,3.8125 q -0.15625,0.73437 -0.15625,0.875 0,0.21875 0.10937,0.32812 0=
.125,0.10938 0.40625,0.10938 0.39063,0 0.70313,-0.0781 z m 4.64035,0.95313 =
1.45312,-6.90625 h 1.03125 l -0.28125,1.40625 q 0.53125,-0.79688 1.03125,-1=
.17188 0.51563,-0.39062 1.04688,-0.39062 0.35937,0 0.875,0.25 l -0.48438,1.=
09375 q -0.3125,-0.21875 -0.67187,-0.21875 -0.625,0 -1.28125,0.6875 -0.6406=
3,0.6875 -1.01563,2.48437 l -0.57812,2.76563 z m 7.20399,-0.95313 -0.20312,=
0.95313 q -0.42188,0.10937 -0.8125,0.10937 -0.70313,0 -1.125,-0.34375 -0.31=
25,-0.25 -0.3125,-0.70312 0,-0.23438 0.17187,-1.04688 l 0.82813,-4.01562 h =
-0.92188 l 0.1875,-0.90625 h 0.9375 l 0.34375,-1.70313 1.35938,-0.8125 -0.5=
3125,2.51563 h 1.15625 l -0.1875,0.90625 h -1.15625 l -0.79688,3.8125 q -0.=
15625,0.73437 -0.15625,0.875 0,0.21875 0.10938,0.32812 0.125,0.10938 0.4062=
5,0.10938 0.39062,0 0.70312,-0.0781 z m 6.01549,-1.39062 1.15625,0.10937 q =
-0.25,0.85938 -1.14062,1.625 -0.89063,0.76563 -2.125,0.76563 -0.76563,0 -1.=
40625,-0.34375 -0.64063,-0.35938 -0.98438,-1.03125 -0.32812,-0.6875 -0.3281=
2,-1.54688 0,-1.14062 0.51562,-2.20312 0.53125,-1.0625 1.35938,-1.57813 0.8=
4375,-0.51562 1.8125,-0.51562 1.23437,0 1.96875,0.76562 0.75,0.76563 0.75,2=
.09375 0,0.5 -0.0937,1.04688 h -5.09375 q -0.0312,0.1875 -0.0312,0.35937 0,=
0.96875 0.4375,1.48438 0.45312,0.5 1.10937,0.5 0.59375,0 1.17188,-0.39063 0=
.59375,-0.39062 0.92187,-1.14062 z m -3.42187,-1.71875 h 3.875 q 0.0156,-0.=
1875 0.0156,-0.26563 0,-0.875 -0.45312,-1.34375 -0.4375,-0.48437 -1.125,-0.=
48437 -0.76563,0 -1.39063,0.53125 -0.60937,0.51562 -0.92187,1.5625 z m 4.47=
497,6.71875 v -0.85938 h 7.76563 v 0.85938 z m 8.69373,-2.65625 1.45312,-6.=
90625 h 1.0625 l -0.25,1.20312 q 0.6875,-0.71875 1.29688,-1.03125 0.60937,-=
0.32812 1.23437,-0.32812 0.84375,0 1.3125,0.45312 0.48438,0.45313 0.48438,1=
.21875 0,0.375 -0.17188,1.20313 l -0.875,4.1875 h -1.17187 l 0.92187,-4.375=
 q 0.125,-0.64063 0.125,-0.95313 0,-0.34375 -0.23437,-0.54687 -0.23438,-0.2=
1875 -0.6875,-0.21875 -0.90625,0 -1.60938,0.65625 -0.70312,0.64062 -1.03125=
,2.21875 l -0.67187,3.21875 z m 7.63122,-2.625 q 0,-2.01563 1.1875,-3.34375=
 0.98438,-1.09375 2.57813,-1.09375 1.25,0 2.01562,0.78125 0.76563,0.78125 0=
.76563,2.10937 0,1.1875 -0.48438,2.21875 -0.48437,1.01563 -1.375,1.5625 -0.=
89062,0.54688 -1.875,0.54688 -0.79687,0 -1.46875,-0.34375 -0.65625,-0.34375=
 -1,-0.96875 -0.34375,-0.64063 -0.34375,-1.46875 z m 1.17188,-0.10938 q 0,0=
.96875 0.46875,1.48438 0.46875,0.5 1.1875,0.5 0.375,0 0.75,-0.15625 0.375,-=
0.15625 0.6875,-0.46875 0.32812,-0.3125 0.54687,-0.70313 0.21875,-0.40625 0=
.35938,-0.875 0.20312,-0.64062 0.20312,-1.23437 0,-0.9375 -0.46875,-1.45313=
 -0.46875,-0.51562 -1.1875,-0.51562 -0.5625,0 -1.01562,0.26562 -0.45313,0.2=
6563 -0.82813,0.78125 -0.35937,0.5 -0.53125,1.17188 -0.17187,0.67187 -0.171=
87,1.20312 z m 10.69372,1.73438 q -1.01562,1.15625 -2.10937,1.15625 -0.9843=
8,0 -1.64063,-0.71875 -0.65625,-0.73438 -0.65625,-2.10938 0,-1.26562 0.5156=
3,-2.3125 0.51562,-1.04687 1.29687,-1.5625 0.78125,-0.51562 1.5625,-0.51562=
 1.28125,0 1.9375,1.23437 l 0.78125,-3.71875 h 1.17188 l -1.98438,9.54688 h=
 -1.09375 z m -3.23437,-1.89063 q 0,0.71875 0.14062,1.14063 0.14063,0.40625=
 0.48438,0.6875 0.34375,0.28125 0.82812,0.28125 0.79688,0 1.45313,-0.84375 =
0.875,-1.10938 0.875,-2.73438 0,-0.8125 -0.4375,-1.26562 -0.42188,-0.46875 =
-1.07813,-0.46875 -0.42187,0 -0.76562,0.1875 -0.34375,0.1875 -0.6875,0.6406=
2 -0.34375,0.45313 -0.57813,1.15625 -0.23437,0.6875 -0.23437,1.21875 z m 11=
.0531,0.54688 1.15625,0.10937 q -0.25,0.85938 -1.14062,1.625 -0.89063,0.765=
63 -2.125,0.76563 -0.76563,0 -1.40625,-0.34375 -0.64063,-0.35938 -0.98438,-=
1.03125 -0.32812,-0.6875 -0.32812,-1.54688 0,-1.14062 0.51562,-2.20312 0.53=
125,-1.0625 1.35938,-1.57813 0.84375,-0.51562 1.8125,-0.51562 1.23437,0 1.9=
6875,0.76562 0.75,0.76563 0.75,2.09375 0,0.5 -0.0937,1.04688 h -5.09375 q -=
0.0312,0.1875 -0.0312,0.35937 0,0.96875 0.4375,1.48438 0.45312,0.5 1.10937,=
0.5 0.59375,0 1.17188,-0.39063 0.59375,-0.39062 0.92187,-1.14062 z m -3.421=
87,-1.71875 h 3.875 q 0.0156,-0.1875 0.0156,-0.26563 0,-0.875 -0.45312,-1.3=
4375 -0.4375,-0.48437 -1.125,-0.48437 -0.76563,0 -1.39063,0.53125 -0.60937,=
0.51562 -0.92187,1.5625 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path264" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 187.94858,288.60097 v -9.54687 h 1.29687 l 5.01563,7.5 v -=
7.5 h 1.20312 v 9.54687 h -1.29687 l -5.01563,-7.5 v 7.5 z m 9.04703,-3.453=
12 q 0,-1.92188 1.07812,-2.84375 0.89063,-0.76563 2.17188,-0.76563 1.42187,=
0 2.32812,0.9375 0.90625,0.92188 0.90625,2.57813 0,1.32812 -0.40625,2.09375=
 -0.39062,0.76562 -1.15625,1.1875 -0.76562,0.42187 -1.67187,0.42187 -1.4531=
3,0 -2.35938,-0.92187 -0.89062,-0.9375 -0.89062,-2.6875 z m 1.20312,0 q 0,1=
.32812 0.57813,1.98437 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45312,-0.6=
5625 0.57813,-0.67187 0.57813,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57813=
,-0.65625 -1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57813,0.65625 -0.57=
813,1.98438 z m 11.13123,3.45312 v -0.875 q -0.65625,1.03125 -1.9375,1.0312=
5 -0.8125,0 -1.51563,-0.45312 -0.6875,-0.45313 -1.07812,-1.26563 -0.375,-0.=
82812 -0.375,-1.89062 0,-1.03125 0.34375,-1.875 0.34375,-0.84375 1.03125,-1=
.28125 0.70312,-0.45313 1.54687,-0.45313 0.625,0 1.10938,0.26563 0.5,0.25 0=
.79687,0.67187 v -3.42187 h 1.17188 v 9.54687 z m -3.70313,-3.45312 q 0,1.3=
2812 0.5625,1.98437 0.5625,0.65625 1.32813,0.65625 0.76562,0 1.29687,-0.625=
 0.53125,-0.625 0.53125,-1.90625 0,-1.42187 -0.54687,-2.07812 -0.54688,-0.6=
7188 -1.34375,-0.67188 -0.78125,0 -1.3125,0.64063 -0.51563,0.625 -0.51563,2=
 z m 11.36561,1.23437 1.20312,0.14063 q -0.28125,1.0625 -1.0625,1.65625 -0.=
76562,0.57812 -1.96875,0.57812 -1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375=
 -0.89062,-2.60937 0,-1.75 0.89062,-2.70313 0.90625,-0.96875 2.34375,-0.968=
75 1.39063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,0.10938 0,0.3125 h=
 -5.15625 q 0.0625,1.14063 0.64062,1.75 0.57813,0.59375 1.4375,0.59375 0.65=
625,0 1.10938,-0.32812 0.45312,-0.34375 0.71875,-1.07813 z m -3.84375,-1.90=
625 h 3.85937 q -0.0781,-0.85937 -0.4375,-1.29687 -0.5625,-0.6875 -1.45312,=
-0.6875 -0.8125,0 -1.35938,0.54687 -0.54687,0.53125 -0.60937,1.4375 z m 14.=
31858,4.125 h -1.17187 v -7.46875 q -0.42188,0.40625 -1.10938,0.8125 -0.687=
5,0.40625 -1.23437,0.60938 v -1.14063 q 0.98437,-0.45312 1.71875,-1.10937 0=
.73437,-0.67188 1.03125,-1.28125 h 0.76562 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path266" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 164.51677,302.2416 1.1875,-0.0781 q 0,0.51563 0.15625,0.87=
5 0.15625,0.35938 0.57812,0.59375 0.42188,0.21875 0.96875,0.21875 0.78125,0=
 1.17188,-0.3125 0.39062,-0.3125 0.39062,-0.73437 0,-0.3125 -0.23437,-0.578=
13 -0.23438,-0.28125 -1.17188,-0.67187 -0.9375,-0.40625 -1.1875,-0.57813 -0=
.4375,-0.26562 -0.67187,-0.625 -0.21875,-0.35937 -0.21875,-0.82812 0,-0.812=
5 0.65625,-1.39063 0.65625,-0.59375 1.82812,-0.59375 1.29688,0 1.96875,0.60=
938 0.6875,0.59375 0.71875,1.57812 l -1.15625,0.0781 q -0.0312,-0.625 -0.45=
312,-0.98438 -0.40625,-0.375 -1.17188,-0.375 -0.60937,0 -0.95312,0.28125 -0=
.32813,0.28125 -0.32813,0.60938 0,0.3125 0.29688,0.5625 0.1875,0.17187 1,0.=
53125 1.35937,0.57812 1.70312,0.92187 0.5625,0.53125 0.5625,1.3125 0,0.5156=
3 -0.3125,1.01563 -0.3125,0.48437 -0.96875,0.78125 -0.64062,0.29687 -1.5156=
2,0.29687 -1.20313,0 -2.04688,-0.59375 -0.84375,-0.59375 -0.79687,-1.92187 =
z m 9.32031,1.40625 -0.20312,0.95312 q -0.42188,0.10938 -0.8125,0.10938 -0.=
70313,0 -1.125,-0.34375 -0.3125,-0.25 -0.3125,-0.70313 0,-0.23437 0.17187,-=
1.04687 l 0.82813,-4.01563 h -0.92188 l 0.1875,-0.90625 h 0.9375 l 0.34375,=
-1.70312 1.35938,-0.8125 -0.53125,2.51562 h 1.15625 l -0.1875,0.90625 h -1.=
15625 l -0.79688,3.8125 q -0.15625,0.73438 -0.15625,0.875 0,0.21875 0.10938=
,0.32813 0.125,0.10937 0.40625,0.10937 0.39062,0 0.70312,-0.0781 z m 0.9373=
7,0.95312 1.45312,-6.90625 h 1.03125 l -0.28125,1.40625 q 0.53125,-0.79687 =
1.03125,-1.17187 0.51563,-0.39063 1.04688,-0.39063 0.35937,0 0.875,0.25 l -=
0.48438,1.09375 q -0.3125,-0.21875 -0.67187,-0.21875 -0.625,0 -1.28125,0.68=
75 -0.64063,0.6875 -1.01563,2.48438 l -0.57812,2.76562 z m 9.15712,-1.25 q =
-1.23438,1.40625 -2.54688,1.40625 -0.79687,0 -1.29687,-0.45312 -0.48438,-0.=
46875 -0.48438,-1.125 0,-0.4375 0.21875,-1.5 l 0.84375,-3.98438 h 1.17188 l=
 -0.92188,4.40625 q -0.10937,0.5625 -0.10937,0.85938 0,0.39062 0.23437,0.60=
937 0.23438,0.21875 0.70313,0.21875 0.48437,0 0.95312,-0.23437 0.48438,-0.2=
3438 0.8125,-0.64063 0.34375,-0.42187 0.5625,-0.98437 0.14063,-0.35938 0.32=
813,-1.25 l 0.625,-2.98438 h 1.1875 l -1.45313,6.90625 h -1.07812 z m 7.474=
97,-1.26562 1.17188,0.125 q -0.4375,1.29687 -1.26563,1.92187 -0.8125,0.625 =
-1.84375,0.625 -1.14062,0 -1.84375,-0.71875 -0.6875,-0.73437 -0.6875,-2.046=
87 0,-1.125 0.4375,-2.21875 0.45313,-1.09375 1.28125,-1.65625 0.84375,-0.57=
813 1.92188,-0.57813 1.10937,0 1.76562,0.625 0.65625,0.625 0.65625,1.65625 =
l -1.15625,0.0781 q -0.0156,-0.65625 -0.39062,-1.01563 -0.375,-0.375 -0.984=
38,-0.375 -0.70312,0 -1.23437,0.45313 -0.51563,0.4375 -0.8125,1.35937 -0.29=
688,0.90625 -0.29688,1.75 0,0.89063 0.39063,1.34375 0.39062,0.4375 0.96875,=
0.4375 0.5625,0 1.07812,-0.4375 0.53125,-0.4375 0.84375,-1.32812 z m 4.6484=
4,1.5625 -0.20313,0.95312 q -0.42187,0.10938 -0.8125,0.10938 -0.70312,0 -1.=
125,-0.34375 -0.3125,-0.25 -0.3125,-0.70313 0,-0.23437 0.17188,-1.04687 l 0=
.82812,-4.01563 h -0.92187 l 0.1875,-0.90625 h 0.9375 l 0.34375,-1.70312 1.=
35937,-0.8125 -0.53125,2.51562 h 1.15625 l -0.1875,0.90625 h -1.15625 l -0.=
79687,3.8125 q -0.15625,0.73438 -0.15625,0.875 0,0.21875 0.10937,0.32813 0.=
125,0.10937 0.40625,0.10937 0.39063,0 0.70313,-0.0781 z m 4.64035,0.95312 1=
.45312,-6.90625 h 1.03125 l -0.28125,1.40625 q 0.53125,-0.79687 1.03125,-1.=
17187 0.51563,-0.39063 1.04688,-0.39063 0.35937,0 0.875,0.25 l -0.48438,1.0=
9375 q -0.3125,-0.21875 -0.67187,-0.21875 -0.625,0 -1.28125,0.6875 -0.64063=
,0.6875 -1.01563,2.48438 l -0.57812,2.76562 z m 7.20399,-0.95312 -0.20312,0=
.95312 q -0.42188,0.10938 -0.8125,0.10938 -0.70313,0 -1.125,-0.34375 -0.312=
5,-0.25 -0.3125,-0.70313 0,-0.23437 0.17187,-1.04687 l 0.82813,-4.01563 h -=
0.92188 l 0.1875,-0.90625 h 0.9375 l 0.34375,-1.70312 1.35938,-0.8125 -0.53=
125,2.51562 h 1.15625 l -0.1875,0.90625 h -1.15625 l -0.79688,3.8125 q -0.1=
5625,0.73438 -0.15625,0.875 0,0.21875 0.10938,0.32813 0.125,0.10937 0.40625=
,0.10937 0.39062,0 0.70312,-0.0781 z m 6.01549,-1.39063 1.15625,0.10938 q -=
0.25,0.85937 -1.14062,1.625 -0.89063,0.76562 -2.125,0.76562 -0.76563,0 -1.4=
0625,-0.34375 -0.64063,-0.35937 -0.98438,-1.03125 -0.32812,-0.6875 -0.32812=
,-1.54687 0,-1.14063 0.51562,-2.20313 0.53125,-1.0625 1.35938,-1.57812 0.84=
375,-0.51563 1.8125,-0.51563 1.23437,0 1.96875,0.76563 0.75,0.76562 0.75,2.=
09375 0,0.5 -0.0937,1.04687 h -5.09375 q -0.0312,0.1875 -0.0312,0.35938 0,0=
.96875 0.4375,1.48437 0.45312,0.5 1.10937,0.5 0.59375,0 1.17188,-0.39062 0.=
59375,-0.39063 0.92187,-1.14063 z m -3.42187,-1.71875 h 3.875 q 0.0156,-0.1=
875 0.0156,-0.26562 0,-0.875 -0.45312,-1.34375 -0.4375,-0.48438 -1.125,-0.4=
8438 -0.76563,0 -1.39063,0.53125 -0.60937,0.51563 -0.92187,1.5625 z m 4.474=
97,6.71875 v -0.85937 h 7.76563 v 0.85937 z m 8.69373,-2.65625 1.45312,-6.9=
0625 h 1.0625 l -0.25,1.20313 q 0.6875,-0.71875 1.29688,-1.03125 0.60937,-0=
.32813 1.23437,-0.32813 0.84375,0 1.3125,0.45313 0.48438,0.45312 0.48438,1.=
21875 0,0.375 -0.17188,1.20312 l -0.875,4.1875 h -1.17187 l 0.92187,-4.375 =
q 0.125,-0.64062 0.125,-0.95312 0,-0.34375 -0.23437,-0.54688 -0.23438,-0.21=
875 -0.6875,-0.21875 -0.90625,0 -1.60938,0.65625 -0.70312,0.64063 -1.03125,=
2.21875 l -0.67187,3.21875 z m 7.63122,-2.625 q 0,-2.01562 1.1875,-3.34375 =
0.98438,-1.09375 2.57813,-1.09375 1.25,0 2.01562,0.78125 0.76563,0.78125 0.=
76563,2.10938 0,1.1875 -0.48438,2.21875 -0.48437,1.01562 -1.375,1.5625 -0.8=
9062,0.54687 -1.875,0.54687 -0.79687,0 -1.46875,-0.34375 -0.65625,-0.34375 =
-1,-0.96875 -0.34375,-0.64062 -0.34375,-1.46875 z m 1.17188,-0.10937 q 0,0.=
96875 0.46875,1.48437 0.46875,0.5 1.1875,0.5 0.375,0 0.75,-0.15625 0.375,-0=
.15625 0.6875,-0.46875 0.32812,-0.3125 0.54687,-0.70312 0.21875,-0.40625 0.=
35938,-0.875 0.20312,-0.64063 0.20312,-1.23438 0,-0.9375 -0.46875,-1.45312 =
-0.46875,-0.51563 -1.1875,-0.51563 -0.5625,0 -1.01562,0.26563 -0.45313,0.26=
562 -0.82813,0.78125 -0.35937,0.5 -0.53125,1.17187 -0.17187,0.67188 -0.1718=
7,1.20313 z m 10.69372,1.73437 q -1.01562,1.15625 -2.10937,1.15625 -0.98438=
,0 -1.64063,-0.71875 -0.65625,-0.73437 -0.65625,-2.10937 0,-1.26563 0.51563=
,-2.3125 0.51562,-1.04688 1.29687,-1.5625 0.78125,-0.51563 1.5625,-0.51563 =
1.28125,0 1.9375,1.23438 l 0.78125,-3.71875 h 1.17188 l -1.98438,9.54687 h =
-1.09375 z m -3.23437,-1.89062 q 0,0.71875 0.14062,1.14062 0.14063,0.40625 =
0.48438,0.6875 0.34375,0.28125 0.82812,0.28125 0.79688,0 1.45313,-0.84375 0=
.875,-1.10937 0.875,-2.73437 0,-0.8125 -0.4375,-1.26563 -0.42188,-0.46875 -=
1.07813,-0.46875 -0.42187,0 -0.76562,0.1875 -0.34375,0.1875 -0.6875,0.64063=
 -0.34375,0.45312 -0.57813,1.15625 -0.23437,0.6875 -0.23437,1.21875 z m 11.=
0531,0.54687 1.15625,0.10938 q -0.25,0.85937 -1.14062,1.625 -0.89063,0.7656=
2 -2.125,0.76562 -0.76563,0 -1.40625,-0.34375 -0.64063,-0.35937 -0.98438,-1=
.03125 -0.32812,-0.6875 -0.32812,-1.54687 0,-1.14063 0.51562,-2.20313 0.531=
25,-1.0625 1.35938,-1.57812 0.84375,-0.51563 1.8125,-0.51563 1.23437,0 1.96=
875,0.76563 0.75,0.76562 0.75,2.09375 0,0.5 -0.0937,1.04687 h -5.09375 q -0=
.0312,0.1875 -0.0312,0.35938 0,0.96875 0.4375,1.48437 0.45312,0.5 1.10937,0=
.5 0.59375,0 1.17188,-0.39062 0.59375,-0.39063 0.92187,-1.14063 z m -3.4218=
7,-1.71875 h 3.875 q 0.0156,-0.1875 0.0156,-0.26562 0,-0.875 -0.45312,-1.34=
375 -0.4375,-0.48438 -1.125,-0.48438 -0.76563,0 -1.39063,0.53125 -0.60937,0=
.51563 -0.92187,1.5625 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path268" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 187.94858,339.7978 v -9.54688 h 1.29687 l 5.01563,7.5 v -7=
.5 h 1.20312 v 9.54688 h -1.29687 l -5.01563,-7.5 v 7.5 z m 9.04703,-3.4531=
3 q 0,-1.92187 1.07812,-2.84375 0.89063,-0.76562 2.17188,-0.76562 1.42187,0=
 2.32812,0.9375 0.90625,0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.09375 =
-0.39062,0.76563 -1.15625,1.1875 -0.76562,0.42188 -1.67187,0.42188 -1.45313=
,0 -2.35938,-0.92188 -0.89062,-0.9375 -0.89062,-2.6875 z m 1.20312,0 q 0,1.=
32813 0.57813,1.98438 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45312,-0.65=
625 0.57813,-0.67188 0.57813,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57813,=
-0.65625 -1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57813,0.65625 -0.578=
13,1.98437 z m 11.13123,3.45313 v -0.875 q -0.65625,1.03125 -1.9375,1.03125=
 -0.8125,0 -1.51563,-0.45313 -0.6875,-0.45312 -1.07812,-1.26562 -0.375,-0.8=
2813 -0.375,-1.89063 0,-1.03125 0.34375,-1.875 0.34375,-0.84375 1.03125,-1.=
28125 0.70312,-0.45312 1.54687,-0.45312 0.625,0 1.10938,0.26562 0.5,0.25 0.=
79687,0.67188 v -3.42188 h 1.17188 v 9.54688 z m -3.70313,-3.45313 q 0,1.32=
813 0.5625,1.98438 0.5625,0.65625 1.32813,0.65625 0.76562,0 1.29687,-0.625 =
0.53125,-0.625 0.53125,-1.90625 0,-1.42188 -0.54687,-2.07813 -0.54688,-0.67=
187 -1.34375,-0.67187 -0.78125,0 -1.3125,0.64062 -0.51563,0.625 -0.51563,2 =
z m 11.36561,1.23438 1.20312,0.14062 q -0.28125,1.0625 -1.0625,1.65625 -0.7=
6562,0.57813 -1.96875,0.57813 -1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375 =
-0.89062,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-0.96875 2.34375,-0.9687=
5 1.39063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h =
-5.15625 q 0.0625,1.14062 0.64062,1.75 0.57813,0.59375 1.4375,0.59375 0.656=
25,0 1.10938,-0.32813 0.45312,-0.34375 0.71875,-1.07812 z m -3.84375,-1.906=
25 h 3.85937 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.45312,-=
0.6875 -0.8125,0 -1.35938,0.54688 -0.54687,0.53125 -0.60937,1.4375 z m 16.0=
5296,3 v 1.125 h -6.29688 q -0.0156,-0.42188 0.14063,-0.8125 0.23437,-0.640=
63 0.76562,-1.26563 0.53125,-0.625 1.53125,-1.45312 1.5625,-1.26563 2.10938=
,-2.01563 0.54687,-0.75 0.54687,-1.40625 0,-0.70312 -0.5,-1.17187 -0.5,-0.4=
8438 -1.29687,-0.48438 -0.85938,0 -1.375,0.51563 -0.5,0.5 -0.5,1.39062 l -1=
.20313,-0.10937 q 0.125,-1.35938 0.92188,-2.0625 0.8125,-0.70313 2.17187,-0=
.70313 1.375,0 2.17188,0.76563 0.8125,0.75 0.8125,1.875 0,0.57812 -0.23438,=
1.14062 -0.23437,0.54688 -0.78125,1.15625 -0.54687,0.60938 -1.8125,1.67188 =
-1.04687,0.89062 -1.35937,1.21875 -0.29688,0.3125 -0.48438,0.625 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path270" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 164.51677,353.43844 1.1875,-0.0781 q 0,0.51562 0.15625,0.8=
75 0.15625,0.35937 0.57812,0.59375 0.42188,0.21875 0.96875,0.21875 0.78125,=
0 1.17188,-0.3125 0.39062,-0.3125 0.39062,-0.73438 0,-0.3125 -0.23437,-0.57=
812 -0.23438,-0.28125 -1.17188,-0.67188 -0.9375,-0.40625 -1.1875,-0.57812 -=
0.4375,-0.26563 -0.67187,-0.625 -0.21875,-0.35938 -0.21875,-0.82813 0,-0.81=
25 0.65625,-1.39062 0.65625,-0.59375 1.82812,-0.59375 1.29688,0 1.96875,0.6=
0937 0.6875,0.59375 0.71875,1.57813 l -1.15625,0.0781 q -0.0312,-0.625 -0.4=
5312,-0.98437 -0.40625,-0.375 -1.17188,-0.375 -0.60937,0 -0.95312,0.28125 -=
0.32813,0.28125 -0.32813,0.60937 0,0.3125 0.29688,0.5625 0.1875,0.17188 1,0=
.53125 1.35937,0.57813 1.70312,0.92188 0.5625,0.53125 0.5625,1.3125 0,0.515=
62 -0.3125,1.01562 -0.3125,0.48438 -0.96875,0.78125 -0.64062,0.29688 -1.515=
62,0.29688 -1.20313,0 -2.04688,-0.59375 -0.84375,-0.59375 -0.79687,-1.92188=
 z m 9.32031,1.40625 -0.20312,0.95313 q -0.42188,0.10937 -0.8125,0.10937 -0=
.70313,0 -1.125,-0.34375 -0.3125,-0.25 -0.3125,-0.70312 0,-0.23438 0.17187,=
-1.04688 l 0.82813,-4.01562 h -0.92188 l 0.1875,-0.90625 h 0.9375 l 0.34375=
,-1.70313 1.35938,-0.8125 -0.53125,2.51563 h 1.15625 l -0.1875,0.90625 h -1=
.15625 l -0.79688,3.8125 q -0.15625,0.73437 -0.15625,0.875 0,0.21875 0.1093=
8,0.32812 0.125,0.10938 0.40625,0.10938 0.39062,0 0.70312,-0.0781 z m 0.937=
37,0.95313 1.45312,-6.90625 h 1.03125 l -0.28125,1.40625 q 0.53125,-0.79688=
 1.03125,-1.17188 0.51563,-0.39062 1.04688,-0.39062 0.35937,0 0.875,0.25 l =
-0.48438,1.09375 q -0.3125,-0.21875 -0.67187,-0.21875 -0.625,0 -1.28125,0.6=
875 -0.64063,0.6875 -1.01563,2.48437 l -0.57812,2.76563 z m 9.15712,-1.25 q=
 -1.23438,1.40625 -2.54688,1.40625 -0.79687,0 -1.29687,-0.45313 -0.48438,-0=
.46875 -0.48438,-1.125 0,-0.4375 0.21875,-1.5 l 0.84375,-3.98437 h 1.17188 =
l -0.92188,4.40625 q -0.10937,0.5625 -0.10937,0.85937 0,0.39063 0.23437,0.6=
0938 0.23438,0.21875 0.70313,0.21875 0.48437,0 0.95312,-0.23438 0.48438,-0.=
23437 0.8125,-0.64062 0.34375,-0.42188 0.5625,-0.98438 0.14063,-0.35937 0.3=
2813,-1.25 l 0.625,-2.98437 h 1.1875 l -1.45313,6.90625 h -1.07812 z m 7.47=
497,-1.26563 1.17188,0.125 q -0.4375,1.29688 -1.26563,1.92188 -0.8125,0.625=
 -1.84375,0.625 -1.14062,0 -1.84375,-0.71875 -0.6875,-0.73438 -0.6875,-2.04=
688 0,-1.125 0.4375,-2.21875 0.45313,-1.09375 1.28125,-1.65625 0.84375,-0.5=
7812 1.92188,-0.57812 1.10937,0 1.76562,0.625 0.65625,0.625 0.65625,1.65625=
 l -1.15625,0.0781 q -0.0156,-0.65625 -0.39062,-1.01562 -0.375,-0.375 -0.98=
438,-0.375 -0.70312,0 -1.23437,0.45312 -0.51563,0.4375 -0.8125,1.35938 -0.2=
9688,0.90625 -0.29688,1.75 0,0.89062 0.39063,1.34375 0.39062,0.4375 0.96875=
,0.4375 0.5625,0 1.07812,-0.4375 0.53125,-0.4375 0.84375,-1.32813 z m 4.648=
44,1.5625 -0.20313,0.95313 q -0.42187,0.10937 -0.8125,0.10937 -0.70312,0 -1=
.125,-0.34375 -0.3125,-0.25 -0.3125,-0.70312 0,-0.23438 0.17188,-1.04688 l =
0.82812,-4.01562 h -0.92187 l 0.1875,-0.90625 h 0.9375 l 0.34375,-1.70313 1=
.35937,-0.8125 -0.53125,2.51563 h 1.15625 l -0.1875,0.90625 h -1.15625 l -0=
.79687,3.8125 q -0.15625,0.73437 -0.15625,0.875 0,0.21875 0.10937,0.32812 0=
.125,0.10938 0.40625,0.10938 0.39063,0 0.70313,-0.0781 z m 4.64035,0.95313 =
1.45312,-6.90625 h 1.03125 l -0.28125,1.40625 q 0.53125,-0.79688 1.03125,-1=
.17188 0.51563,-0.39062 1.04688,-0.39062 0.35937,0 0.875,0.25 l -0.48438,1.=
09375 q -0.3125,-0.21875 -0.67187,-0.21875 -0.625,0 -1.28125,0.6875 -0.6406=
3,0.6875 -1.01563,2.48437 l -0.57812,2.76563 z m 7.20399,-0.95313 -0.20312,=
0.95313 q -0.42188,0.10937 -0.8125,0.10937 -0.70313,0 -1.125,-0.34375 -0.31=
25,-0.25 -0.3125,-0.70312 0,-0.23438 0.17187,-1.04688 l 0.82813,-4.01562 h =
-0.92188 l 0.1875,-0.90625 h 0.9375 l 0.34375,-1.70313 1.35938,-0.8125 -0.5=
3125,2.51563 h 1.15625 l -0.1875,0.90625 h -1.15625 l -0.79688,3.8125 q -0.=
15625,0.73437 -0.15625,0.875 0,0.21875 0.10938,0.32812 0.125,0.10938 0.4062=
5,0.10938 0.39062,0 0.70312,-0.0781 z m 6.01549,-1.39062 1.15625,0.10937 q =
-0.25,0.85938 -1.14062,1.625 -0.89063,0.76563 -2.125,0.76563 -0.76563,0 -1.=
40625,-0.34375 -0.64063,-0.35938 -0.98438,-1.03125 -0.32812,-0.6875 -0.3281=
2,-1.54688 0,-1.14062 0.51562,-2.20312 0.53125,-1.0625 1.35938,-1.57813 0.8=
4375,-0.51562 1.8125,-0.51562 1.23437,0 1.96875,0.76562 0.75,0.76563 0.75,2=
.09375 0,0.5 -0.0937,1.04688 h -5.09375 q -0.0312,0.1875 -0.0312,0.35937 0,=
0.96875 0.4375,1.48438 0.45312,0.5 1.10937,0.5 0.59375,0 1.17188,-0.39063 0=
.59375,-0.39062 0.92187,-1.14062 z m -3.42187,-1.71875 h 3.875 q 0.0156,-0.=
1875 0.0156,-0.26563 0,-0.875 -0.45312,-1.34375 -0.4375,-0.48437 -1.125,-0.=
48437 -0.76563,0 -1.39063,0.53125 -0.60937,0.51562 -0.92187,1.5625 z m 4.47=
497,6.71875 v -0.85938 h 7.76563 v 0.85938 z m 8.69373,-2.65625 1.45312,-6.=
90625 h 1.0625 l -0.25,1.20312 q 0.6875,-0.71875 1.29688,-1.03125 0.60937,-=
0.32812 1.23437,-0.32812 0.84375,0 1.3125,0.45312 0.48438,0.45313 0.48438,1=
.21875 0,0.375 -0.17188,1.20313 l -0.875,4.1875 h -1.17187 l 0.92187,-4.375=
 q 0.125,-0.64063 0.125,-0.95313 0,-0.34375 -0.23437,-0.54687 -0.23438,-0.2=
1875 -0.6875,-0.21875 -0.90625,0 -1.60938,0.65625 -0.70312,0.64062 -1.03125=
,2.21875 l -0.67187,3.21875 z m 7.63122,-2.625 q 0,-2.01563 1.1875,-3.34375=
 0.98438,-1.09375 2.57813,-1.09375 1.25,0 2.01562,0.78125 0.76563,0.78125 0=
.76563,2.10937 0,1.1875 -0.48438,2.21875 -0.48437,1.01563 -1.375,1.5625 -0.=
89062,0.54688 -1.875,0.54688 -0.79687,0 -1.46875,-0.34375 -0.65625,-0.34375=
 -1,-0.96875 -0.34375,-0.64063 -0.34375,-1.46875 z m 1.17188,-0.10938 q 0,0=
.96875 0.46875,1.48438 0.46875,0.5 1.1875,0.5 0.375,0 0.75,-0.15625 0.375,-=
0.15625 0.6875,-0.46875 0.32812,-0.3125 0.54687,-0.70313 0.21875,-0.40625 0=
.35938,-0.875 0.20312,-0.64062 0.20312,-1.23437 0,-0.9375 -0.46875,-1.45313=
 -0.46875,-0.51562 -1.1875,-0.51562 -0.5625,0 -1.01562,0.26562 -0.45313,0.2=
6563 -0.82813,0.78125 -0.35937,0.5 -0.53125,1.17188 -0.17187,0.67187 -0.171=
87,1.20312 z m 10.69372,1.73438 q -1.01562,1.15625 -2.10937,1.15625 -0.9843=
8,0 -1.64063,-0.71875 -0.65625,-0.73438 -0.65625,-2.10938 0,-1.26562 0.5156=
3,-2.3125 0.51562,-1.04687 1.29687,-1.5625 0.78125,-0.51562 1.5625,-0.51562=
 1.28125,0 1.9375,1.23437 l 0.78125,-3.71875 h 1.17188 l -1.98438,9.54688 h=
 -1.09375 z m -3.23437,-1.89063 q 0,0.71875 0.14062,1.14063 0.14063,0.40625=
 0.48438,0.6875 0.34375,0.28125 0.82812,0.28125 0.79688,0 1.45313,-0.84375 =
0.875,-1.10938 0.875,-2.73438 0,-0.8125 -0.4375,-1.26562 -0.42188,-0.46875 =
-1.07813,-0.46875 -0.42187,0 -0.76562,0.1875 -0.34375,0.1875 -0.6875,0.6406=
2 -0.34375,0.45313 -0.57813,1.15625 -0.23437,0.6875 -0.23437,1.21875 z m 11=
.0531,0.54688 1.15625,0.10937 q -0.25,0.85938 -1.14062,1.625 -0.89063,0.765=
63 -2.125,0.76563 -0.76563,0 -1.40625,-0.34375 -0.64063,-0.35938 -0.98438,-=
1.03125 -0.32812,-0.6875 -0.32812,-1.54688 0,-1.14062 0.51562,-2.20312 0.53=
125,-1.0625 1.35938,-1.57813 0.84375,-0.51562 1.8125,-0.51562 1.23437,0 1.9=
6875,0.76562 0.75,0.76563 0.75,2.09375 0,0.5 -0.0937,1.04688 h -5.09375 q -=
0.0312,0.1875 -0.0312,0.35937 0,0.96875 0.4375,1.48438 0.45312,0.5 1.10937,=
0.5 0.59375,0 1.17188,-0.39063 0.59375,-0.39062 0.92187,-1.14062 z m -3.421=
87,-1.71875 h 3.875 q 0.0156,-0.1875 0.0156,-0.26563 0,-0.875 -0.45312,-1.3=
4375 -0.4375,-0.48437 -1.125,-0.48437 -0.76563,0 -1.39063,0.53125 -0.60937,=
0.51562 -0.92187,1.5625 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path272" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 186.84224,390.99465 v -9.54688 h 1.29687 l 5.01563,7.5 v -=
7.5 h 1.20312 v 9.54688 h -1.29687 l -5.01563,-7.5 v 7.5 z m 9.04703,-3.453=
13 q 0,-1.92187 1.07812,-2.84375 0.89063,-0.76562 2.17188,-0.76562 1.42187,=
0 2.32812,0.9375 0.90625,0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.09375=
 -0.39062,0.76563 -1.15625,1.1875 -0.76562,0.42188 -1.67187,0.42188 -1.4531=
3,0 -2.35938,-0.92188 -0.89062,-0.9375 -0.89062,-2.6875 z m 1.20312,0 q 0,1=
.32813 0.57813,1.98438 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45312,-0.6=
5625 0.57813,-0.67188 0.57813,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57813=
,-0.65625 -1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57813,0.65625 -0.57=
813,1.98437 z m 11.13123,3.45313 v -0.875 q -0.65625,1.03125 -1.9375,1.0312=
5 -0.8125,0 -1.51563,-0.45313 -0.6875,-0.45312 -1.07812,-1.26562 -0.375,-0.=
82813 -0.375,-1.89063 0,-1.03125 0.34375,-1.875 0.34375,-0.84375 1.03125,-1=
.28125 0.70312,-0.45312 1.54687,-0.45312 0.625,0 1.10938,0.26562 0.5,0.25 0=
.79687,0.67188 v -3.42188 h 1.17188 v 9.54688 z m -3.70313,-3.45313 q 0,1.3=
2813 0.5625,1.98438 0.5625,0.65625 1.32813,0.65625 0.76562,0 1.29687,-0.625=
 0.53125,-0.625 0.53125,-1.90625 0,-1.42188 -0.54687,-2.07813 -0.54688,-0.6=
7187 -1.34375,-0.67187 -0.78125,0 -1.3125,0.64062 -0.51563,0.625 -0.51563,2=
 z m 11.3656,1.23438 1.20313,0.14062 q -0.28125,1.0625 -1.0625,1.65625 -0.7=
6563,0.57813 -1.96875,0.57813 -1.51563,0 -2.40625,-0.9375 -0.89063,-0.9375 =
-0.89063,-2.60938 0,-1.75 0.89063,-2.70312 0.90625,-0.96875 2.34375,-0.9687=
5 1.39062,0 2.26562,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h =
-5.15625 q 0.0625,1.14062 0.64063,1.75 0.57812,0.59375 1.4375,0.59375 0.656=
25,0 1.10937,-0.32813 0.45313,-0.34375 0.71875,-1.07812 z m -3.84375,-1.906=
25 h 3.85938 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.45313,-=
0.6875 -0.8125,0 -1.35937,0.54688 -0.54688,0.53125 -0.60938,1.4375 z m 10.3=
6547,4.125 v -9.54688 h 1.29687 l 5.01563,7.5 v -7.5 h 1.20312 v 9.54688 h =
-1.29687 l -5.01563,-7.5 v 7.5 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path274" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 164.51677,404.63527 1.1875,-0.0781 q 0,0.51563 0.15625,0.8=
75 0.15625,0.35938 0.57812,0.59375 0.42188,0.21875 0.96875,0.21875 0.78125,=
0 1.17188,-0.3125 0.39062,-0.3125 0.39062,-0.73437 0,-0.3125 -0.23437,-0.57=
813 -0.23438,-0.28125 -1.17188,-0.67187 -0.9375,-0.40625 -1.1875,-0.57813 -=
0.4375,-0.26562 -0.67187,-0.625 -0.21875,-0.35937 -0.21875,-0.82812 0,-0.81=
25 0.65625,-1.39063 0.65625,-0.59375 1.82812,-0.59375 1.29688,0 1.96875,0.6=
0938 0.6875,0.59375 0.71875,1.57812 l -1.15625,0.0781 q -0.0312,-0.625 -0.4=
5312,-0.98438 -0.40625,-0.375 -1.17188,-0.375 -0.60937,0 -0.95312,0.28125 -=
0.32813,0.28125 -0.32813,0.60938 0,0.3125 0.29688,0.5625 0.1875,0.17187 1,0=
.53125 1.35937,0.57812 1.70312,0.92187 0.5625,0.53125 0.5625,1.3125 0,0.515=
63 -0.3125,1.01563 -0.3125,0.48437 -0.96875,0.78125 -0.64062,0.29687 -1.515=
62,0.29687 -1.20313,0 -2.04688,-0.59375 -0.84375,-0.59375 -0.79687,-1.92187=
 z m 9.32031,1.40625 -0.20312,0.95312 q -0.42188,0.10938 -0.8125,0.10938 -0=
.70313,0 -1.125,-0.34375 -0.3125,-0.25 -0.3125,-0.70313 0,-0.23437 0.17187,=
-1.04687 l 0.82813,-4.01563 h -0.92188 l 0.1875,-0.90625 h 0.9375 l 0.34375=
,-1.70312 1.35938,-0.8125 -0.53125,2.51562 h 1.15625 l -0.1875,0.90625 h -1=
.15625 l -0.79688,3.8125 q -0.15625,0.73438 -0.15625,0.875 0,0.21875 0.1093=
8,0.32813 0.125,0.10937 0.40625,0.10937 0.39062,0 0.70312,-0.0781 z m 0.937=
37,0.95312 1.45312,-6.90625 h 1.03125 l -0.28125,1.40625 q 0.53125,-0.79687=
 1.03125,-1.17187 0.51563,-0.39063 1.04688,-0.39063 0.35937,0 0.875,0.25 l =
-0.48438,1.09375 q -0.3125,-0.21875 -0.67187,-0.21875 -0.625,0 -1.28125,0.6=
875 -0.64063,0.6875 -1.01563,2.48438 l -0.57812,2.76562 z m 9.15712,-1.25 q=
 -1.23438,1.40625 -2.54688,1.40625 -0.79687,0 -1.29687,-0.45312 -0.48438,-0=
.46875 -0.48438,-1.125 0,-0.4375 0.21875,-1.5 l 0.84375,-3.98438 h 1.17188 =
l -0.92188,4.40625 q -0.10937,0.5625 -0.10937,0.85938 0,0.39062 0.23437,0.6=
0937 0.23438,0.21875 0.70313,0.21875 0.48437,0 0.95312,-0.23437 0.48438,-0.=
23438 0.8125,-0.64063 0.34375,-0.42187 0.5625,-0.98437 0.14063,-0.35938 0.3=
2813,-1.25 l 0.625,-2.98438 h 1.1875 l -1.45313,6.90625 h -1.07812 z m 7.47=
497,-1.26562 1.17188,0.125 q -0.4375,1.29687 -1.26563,1.92187 -0.8125,0.625=
 -1.84375,0.625 -1.14062,0 -1.84375,-0.71875 -0.6875,-0.73437 -0.6875,-2.04=
687 0,-1.125 0.4375,-2.21875 0.45313,-1.09375 1.28125,-1.65625 0.84375,-0.5=
7813 1.92188,-0.57813 1.10937,0 1.76562,0.625 0.65625,0.625 0.65625,1.65625=
 l -1.15625,0.0781 q -0.0156,-0.65625 -0.39062,-1.01563 -0.375,-0.375 -0.98=
438,-0.375 -0.70312,0 -1.23437,0.45313 -0.51563,0.4375 -0.8125,1.35937 -0.2=
9688,0.90625 -0.29688,1.75 0,0.89063 0.39063,1.34375 0.39062,0.4375 0.96875=
,0.4375 0.5625,0 1.07812,-0.4375 0.53125,-0.4375 0.84375,-1.32812 z m 4.648=
44,1.5625 -0.20313,0.95312 q -0.42187,0.10938 -0.8125,0.10938 -0.70312,0 -1=
.125,-0.34375 -0.3125,-0.25 -0.3125,-0.70313 0,-0.23437 0.17188,-1.04687 l =
0.82812,-4.01563 h -0.92187 l 0.1875,-0.90625 h 0.9375 l 0.34375,-1.70312 1=
.35937,-0.8125 -0.53125,2.51562 h 1.15625 l -0.1875,0.90625 h -1.15625 l -0=
.79687,3.8125 q -0.15625,0.73438 -0.15625,0.875 0,0.21875 0.10937,0.32813 0=
.125,0.10937 0.40625,0.10937 0.39063,0 0.70313,-0.0781 z m 4.64035,0.95312 =
1.45312,-6.90625 h 1.03125 l -0.28125,1.40625 q 0.53125,-0.79687 1.03125,-1=
.17187 0.51563,-0.39063 1.04688,-0.39063 0.35937,0 0.875,0.25 l -0.48438,1.=
09375 q -0.3125,-0.21875 -0.67187,-0.21875 -0.625,0 -1.28125,0.6875 -0.6406=
3,0.6875 -1.01563,2.48438 l -0.57812,2.76562 z m 7.20399,-0.95312 -0.20312,=
0.95312 q -0.42188,0.10938 -0.8125,0.10938 -0.70313,0 -1.125,-0.34375 -0.31=
25,-0.25 -0.3125,-0.70313 0,-0.23437 0.17187,-1.04687 l 0.82813,-4.01563 h =
-0.92188 l 0.1875,-0.90625 h 0.9375 l 0.34375,-1.70312 1.35938,-0.8125 -0.5=
3125,2.51562 h 1.15625 l -0.1875,0.90625 h -1.15625 l -0.79688,3.8125 q -0.=
15625,0.73438 -0.15625,0.875 0,0.21875 0.10938,0.32813 0.125,0.10937 0.4062=
5,0.10937 0.39062,0 0.70312,-0.0781 z m 6.01549,-1.39063 1.15625,0.10938 q =
-0.25,0.85937 -1.14062,1.625 -0.89063,0.76562 -2.125,0.76562 -0.76563,0 -1.=
40625,-0.34375 -0.64063,-0.35937 -0.98438,-1.03125 -0.32812,-0.6875 -0.3281=
2,-1.54687 0,-1.14063 0.51562,-2.20313 0.53125,-1.0625 1.35938,-1.57812 0.8=
4375,-0.51563 1.8125,-0.51563 1.23437,0 1.96875,0.76563 0.75,0.76562 0.75,2=
.09375 0,0.5 -0.0937,1.04687 h -5.09375 q -0.0312,0.1875 -0.0312,0.35938 0,=
0.96875 0.4375,1.48437 0.45312,0.5 1.10937,0.5 0.59375,0 1.17188,-0.39062 0=
.59375,-0.39063 0.92187,-1.14063 z m -3.42187,-1.71875 h 3.875 q 0.0156,-0.=
1875 0.0156,-0.26562 0,-0.875 -0.45312,-1.34375 -0.4375,-0.48438 -1.125,-0.=
48438 -0.76563,0 -1.39063,0.53125 -0.60937,0.51563 -0.92187,1.5625 z m 4.47=
497,6.71875 v -0.85937 h 7.76563 v 0.85937 z m 8.69373,-2.65625 1.45312,-6.=
90625 h 1.0625 l -0.25,1.20313 q 0.6875,-0.71875 1.29688,-1.03125 0.60937,-=
0.32813 1.23437,-0.32813 0.84375,0 1.3125,0.45313 0.48438,0.45312 0.48438,1=
.21875 0,0.375 -0.17188,1.20312 l -0.875,4.1875 h -1.17187 l 0.92187,-4.375=
 q 0.125,-0.64062 0.125,-0.95312 0,-0.34375 -0.23437,-0.54688 -0.23438,-0.2=
1875 -0.6875,-0.21875 -0.90625,0 -1.60938,0.65625 -0.70312,0.64063 -1.03125=
,2.21875 l -0.67187,3.21875 z m 7.63122,-2.625 q 0,-2.01562 1.1875,-3.34375=
 0.98438,-1.09375 2.57813,-1.09375 1.25,0 2.01562,0.78125 0.76563,0.78125 0=
.76563,2.10938 0,1.1875 -0.48438,2.21875 -0.48437,1.01562 -1.375,1.5625 -0.=
89062,0.54687 -1.875,0.54687 -0.79687,0 -1.46875,-0.34375 -0.65625,-0.34375=
 -1,-0.96875 -0.34375,-0.64062 -0.34375,-1.46875 z m 1.17188,-0.10937 q 0,0=
.96875 0.46875,1.48437 0.46875,0.5 1.1875,0.5 0.375,0 0.75,-0.15625 0.375,-=
0.15625 0.6875,-0.46875 0.32812,-0.3125 0.54687,-0.70312 0.21875,-0.40625 0=
.35938,-0.875 0.20312,-0.64063 0.20312,-1.23438 0,-0.9375 -0.46875,-1.45312=
 -0.46875,-0.51563 -1.1875,-0.51563 -0.5625,0 -1.01562,0.26563 -0.45313,0.2=
6562 -0.82813,0.78125 -0.35937,0.5 -0.53125,1.17187 -0.17187,0.67188 -0.171=
87,1.20313 z m 10.69372,1.73437 q -1.01562,1.15625 -2.10937,1.15625 -0.9843=
8,0 -1.64063,-0.71875 -0.65625,-0.73437 -0.65625,-2.10937 0,-1.26563 0.5156=
3,-2.3125 0.51562,-1.04688 1.29687,-1.5625 0.78125,-0.51563 1.5625,-0.51563=
 1.28125,0 1.9375,1.23438 l 0.78125,-3.71875 h 1.17188 l -1.98438,9.54687 h=
 -1.09375 z m -3.23437,-1.89062 q 0,0.71875 0.14062,1.14062 0.14063,0.40625=
 0.48438,0.6875 0.34375,0.28125 0.82812,0.28125 0.79688,0 1.45313,-0.84375 =
0.875,-1.10937 0.875,-2.73437 0,-0.8125 -0.4375,-1.26563 -0.42188,-0.46875 =
-1.07813,-0.46875 -0.42187,0 -0.76562,0.1875 -0.34375,0.1875 -0.6875,0.6406=
3 -0.34375,0.45312 -0.57813,1.15625 -0.23437,0.6875 -0.23437,1.21875 z m 11=
.0531,0.54687 1.15625,0.10938 q -0.25,0.85937 -1.14062,1.625 -0.89063,0.765=
62 -2.125,0.76562 -0.76563,0 -1.40625,-0.34375 -0.64063,-0.35937 -0.98438,-=
1.03125 -0.32812,-0.6875 -0.32812,-1.54687 0,-1.14063 0.51562,-2.20313 0.53=
125,-1.0625 1.35938,-1.57812 0.84375,-0.51563 1.8125,-0.51563 1.23437,0 1.9=
6875,0.76563 0.75,0.76562 0.75,2.09375 0,0.5 -0.0937,1.04687 h -5.09375 q -=
0.0312,0.1875 -0.0312,0.35938 0,0.96875 0.4375,1.48437 0.45312,0.5 1.10937,=
0.5 0.59375,0 1.17188,-0.39062 0.59375,-0.39063 0.92187,-1.14063 z m -3.421=
87,-1.71875 h 3.875 q 0.0156,-0.1875 0.0156,-0.26562 0,-0.875 -0.45312,-1.3=
4375 -0.4375,-0.48438 -1.125,-0.48438 -0.76563,0 -1.39063,0.53125 -0.60937,=
0.51563 -0.92187,1.5625 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path276" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       fill-opacity=3D"0"=0D
> -       d=3D"M 93.256612,37.783637 H 323.58733 v 27.46456 H 93.256612 Z"=
=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path278" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 115.56788,59.583637 v -6.90625 h 1.0625 v 1.04687 q 0.4062=
5,-0.73437 0.73438,-0.96875 0.34375,-0.23437 0.76562,-0.23437 0.59375,0 1.2=
0313,0.375 l -0.40625,1.07812 q -0.4375,-0.25 -0.85938,-0.25 -0.39062,0 -0.=
70312,0.23438 -0.29688,0.23437 -0.42188,0.64062 -0.20312,0.625 -0.20312,1.3=
5938 v 3.625 z m 7.01649,-1.04688 0.17188,1.03125 q -0.5,0.10938 -0.89063,0=
.10938 -0.64062,0 -1,-0.20313 -0.34375,-0.20312 -0.48437,-0.53125 -0.14063,=
-0.32812 -0.14063,-1.39062 v -3.96875 h -0.85937 v -0.90625 h 0.85937 v -1.=
71875 l 1.17188,-0.70313 v 2.42188 h 1.17187 v 0.90625 h -1.17187 v 4.04687=
 q 0,0.5 0.0469,0.64063 0.0625,0.14062 0.20313,0.23437 0.14062,0.0781 0.406=
25,0.0781 0.20312,0 0.51562,-0.0469 z m 5.87487,-1.17187 1.20311,0.14062 q =
-0.28125,1.0625 -1.06249,1.65625 -0.76562,0.57813 -1.96875,0.57813 -1.51562=
,0 -2.40625,-0.9375 -0.89062,-0.9375 -0.89062,-2.60938 0,-1.75 0.89062,-2.7=
0312 0.90625,-0.96875 2.34375,-0.96875 1.39063,0 2.26563,0.9375 0.87499,0.9=
375 0.87499,2.65625 0,0.10937 0,0.3125 h -5.15624 q 0.0625,1.14062 0.64062,=
1.75 0.57813,0.59375 1.4375,0.59375 0.65625,0 1.10938,-0.32813 0.45312,-0.3=
4375 0.71875,-1.07812 z m -3.84375,-1.90625 h 3.85937 q -0.0781,-0.85938 -0=
.4375,-1.29688 -0.5625,-0.6875 -1.45312,-0.6875 -0.8125,0 -1.35938,0.54688 =
-0.54687,0.53125 -0.60937,1.4375 z m 5.44372,6.78125 v -0.85938 h 7.76562 v=
 0.85938 z m 8.27185,-2.07813 1.14062,0.15625 q 0.0781,0.53125 0.40625,0.78=
125 0.4375,0.3125 1.1875,0.3125 0.8125,0 1.25,-0.32812 0.45313,-0.3125 0.60=
938,-0.90625 0.0937,-0.35938 0.0781,-1.5 -0.76562,0.90625 -1.90625,0.90625 =
-1.4375,0 -2.21875,-1.03125 -0.78125,-1.03125 -0.78125,-2.46875 0,-0.98438 =
0.35938,-1.8125 0.35937,-0.84375 1.03125,-1.29688 0.6875,-0.45312 1.60937,-=
0.45312 1.21875,0 2.01563,0.98437 v -0.82812 h 1.07812 v 5.96875 q 0,1.6093=
7 -0.32812,2.28125 -0.32813,0.6875 -1.04688,1.07812 -0.70312,0.39063 -1.75,=
0.39063 -1.23437,0 -2,-0.5625 -0.75,-0.5625 -0.73437,-1.67188 z m 0.98437,-=
4.15625 q 0,1.35938 0.53125,1.98438 0.54688,0.625 1.35938,0.625 0.79687,0 1=
.34375,-0.625 0.54687,-0.625 0.54687,-1.95313 0,-1.26562 -0.5625,-1.90625 -=
0.5625,-0.64062 -1.35937,-0.64062 -0.76563,0 -1.3125,0.64062 -0.54688,0.625=
 -0.54688,1.875 z m 6.63123,3.57813 v -6.90625 h 1.0625 v 1.04687 q 0.40625=
,-0.73437 0.73437,-0.96875 0.34375,-0.23437 0.76563,-0.23437 0.59375,0 1.20=
312,0.375 l -0.40625,1.07812 q -0.4375,-0.25 -0.85937,-0.25 -0.39063,0 -0.7=
0313,0.23438 -0.29687,0.23437 -0.42187,0.64062 -0.20313,0.625 -0.20313,1.35=
938 v 3.625 z m 8.96962,-0.85938 q -0.65625,0.5625 -1.26563,0.79688 -0.5937=
5,0.21875 -1.28125,0.21875 -1.14062,0 -1.75,-0.54688 -0.60937,-0.5625 -0.60=
937,-1.4375 0,-0.5 0.21875,-0.92187 0.23437,-0.42188 0.60937,-0.67188 0.375=
,-0.25 0.84375,-0.39062 0.34375,-0.0781 1.04688,-0.17188 1.42187,-0.17187 2=
.09375,-0.40625 0,-0.23437 0,-0.29687 0,-0.71875 -0.32813,-1.01563 -0.45312=
,-0.39062 -1.34375,-0.39062 -0.8125,0 -1.21875,0.29687 -0.39062,0.28125 -0.=
57812,1.01563 l -1.14063,-0.15625 q 0.15625,-0.73438 0.51563,-1.1875 0.3593=
7,-0.45313 1.03125,-0.6875 0.67187,-0.25 1.5625,-0.25 0.89062,0 1.4375,0.20=
312 0.5625,0.20313 0.8125,0.53125 0.26562,0.3125 0.375,0.79688 0.0469,0.296=
87 0.0469,1.07812 v 1.5625 q 0,1.625 0.0781,2.0625 0.0781,0.4375 0.29687,0.=
82813 h -1.21875 q -0.1875,-0.35938 -0.23437,-0.85938 z m -0.0937,-2.60937 =
q -0.64063,0.26562 -1.92188,0.4375 -0.71875,0.10937 -1.01562,0.25 -0.29688,=
0.125 -0.46875,0.375 -0.15625,0.25 -0.15625,0.54687 0,0.46875 0.34375,0.781=
25 0.35937,0.3125 1.04687,0.3125 0.67188,0 1.20313,-0.29687 0.53125,-0.2968=
8 0.78125,-0.8125 0.1875,-0.39063 0.1875,-1.17188 z m 2.9906,6.125 v -9.562=
5 h 1.07812 v 0.89062 q 0.375,-0.53125 0.84375,-0.78125 0.48438,-0.26562 1.=
15625,-0.26562 0.875,0 1.54688,0.45312 0.6875,0.45313 1.03125,1.28125 0.343=
75,0.82813 0.34375,1.82813 0,1.04687 -0.375,1.90625 -0.375,0.84375 -1.10938=
,1.29687 -0.71875,0.45313 -1.53125,0.45313 -0.57812,0 -1.04687,-0.25 -0.468=
75,-0.25 -0.76563,-0.625 v 3.375 z m 1.0625,-6.07813 q 0,1.34375 0.53125,1.=
98438 0.54687,0.625 1.3125,0.625 0.78125,0 1.34375,-0.65625 0.5625,-0.65625=
 0.5625,-2.04688 0,-1.3125 -0.54688,-1.96875 -0.54687,-0.67187 -1.29687,-0.=
67187 -0.75,0 -1.32813,0.70312 -0.57812,0.70313 -0.57812,2.03125 z m 6.3499=
7,3.42188 v -9.54688 h 1.17188 v 3.42188 q 0.82812,-0.9375 2.07812,-0.9375 =
0.76563,0 1.32813,0.29687 0.5625,0.29688 0.8125,0.84375 0.25,0.53125 0.25,1=
.54688 v 4.375 h -1.17188 v -4.375 q 0,-0.89063 -0.39062,-1.28125 -0.375,-0=
.40625 -1.07813,-0.40625 -0.51562,0 -0.98437,0.28125 -0.45313,0.26562 -0.65=
625,0.73437 -0.1875,0.45313 -0.1875,1.26563 v 3.78125 z m 10.67797,-3.45313=
 q 0,-1.92187 1.07812,-2.84375 0.89063,-0.76562 2.17188,-0.76562 1.42187,0 =
2.32812,0.9375 0.90625,0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -=
0.39062,0.76563 -1.15625,1.1875 -0.76562,0.42188 -1.67187,0.42188 -1.45313,=
0 -2.35938,-0.92188 -0.89062,-0.9375 -0.89062,-2.6875 z m 1.20312,0 q 0,1.3=
2813 0.57813,1.98438 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45312,-0.656=
25 0.57813,-0.67188 0.57813,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57813,-=
0.65625 -1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57813,0.65625 -0.5781=
3,1.98437 z m 7.72498,3.45313 h -1.07813 v -9.54688 h 1.17188 v 3.40625 q 0=
.73437,-0.92187 1.89062,-0.92187 0.64063,0 1.20313,0.26562 0.57812,0.25 0.9=
375,0.71875 0.375,0.45313 0.57812,1.10938 0.20313,0.65625 0.20313,1.40625 0=
,1.78125 -0.875,2.75 -0.875,0.96875 -2.10938,0.96875 -1.21875,0 -1.92187,-1=
.01563 z m 0,-3.5 q 0,1.23437 0.32812,1.78125 0.5625,0.90625 1.5,0.90625 0.=
76563,0 1.32813,-0.65625 0.5625,-0.67188 0.5625,-2 0,-1.34375 -0.54688,-1.9=
8438 -0.53125,-0.65625 -1.29687,-0.65625 -0.76563,0 -1.32813,0.67188 -0.546=
87,0.67187 -0.54687,1.9375 z m 6.33435,-4.6875 v -1.35938 h 1.17187 v 1.359=
38 z m -1.48438,10.875 0.21875,-1 q 0.35938,0.0937 0.54688,0.0937 0.35937,0=
 0.53125,-0.25 0.1875,-0.23438 0.1875,-1.1875 v -7.25 h 1.17187 v 7.28125 q=
 0,1.28125 -0.32812,1.78125 -0.4375,0.65625 -1.40625,0.65625 -0.48438,0 -0.=
92188,-0.125 z m 9.17984,-4.90625 1.20313,0.14062 q -0.28125,1.0625 -1.0625=
,1.65625 -0.76563,0.57813 -1.96875,0.57813 -1.51563,0 -2.40625,-0.9375 -0.8=
9063,-0.9375 -0.89063,-2.60938 0,-1.75 0.89063,-2.70312 0.90625,-0.96875 2.=
34375,-0.96875 1.39062,0 2.26562,0.9375 0.875,0.9375 0.875,2.65625 0,0.1093=
7 0,0.3125 h -5.15625 q 0.0625,1.14062 0.64063,1.75 0.57812,0.59375 1.4375,=
0.59375 0.65625,0 1.10937,-0.32813 0.45313,-0.34375 0.71875,-1.07812 z m -3=
.84375,-1.90625 h 3.85938 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625,-0.68=
75 -1.45313,-0.6875 -0.8125,0 -1.35937,0.54688 -0.54688,0.53125 -0.60938,1.=
4375 z m 11.03748,1.59375 1.15625,0.15625 q -0.1875,1.1875 -0.96875,1.85937=
 -0.78125,0.67188 -1.92188,0.67188 -1.40625,0 -2.28125,-0.92188 -0.85937,-0=
.9375 -0.85937,-2.65625 0,-1.125 0.375,-1.96875 0.375,-0.84375 1.125,-1.25 =
0.76562,-0.42187 1.65625,-0.42187 1.125,0 1.84375,0.57812 0.71875,0.5625 0.=
92187,1.60938 l -1.14062,0.17187 q -0.17188,-0.70312 -0.59375,-1.04687 -0.4=
0625,-0.35938 -0.98438,-0.35938 -0.89062,0 -1.45312,0.64063 -0.54688,0.6406=
2 -0.54688,2 0,1.40625 0.53125,2.03125 0.54688,0.625 1.40625,0.625 0.6875,0=
 1.14063,-0.42188 0.46875,-0.42187 0.59375,-1.29687 z m 4.71094,1.48437 0.1=
7187,1.03125 q -0.5,0.10938 -0.89062,0.10938 -0.64063,0 -1,-0.20313 -0.3437=
5,-0.20312 -0.48438,-0.53125 -0.14062,-0.32812 -0.14062,-1.39062 v -3.96875=
 h -0.85938 v -0.90625 h 0.85938 v -1.71875 l 1.17187,-0.70313 v 2.42188 h =
1.17188 v 0.90625 h -1.17188 v 4.04687 q 0,0.5 0.0469,0.64063 0.0625,0.1406=
2 0.20312,0.23437 0.14063,0.0781 0.40625,0.0781 0.20313,0 0.51563,-0.0469 z=
 m 4.84347,1.04688 v -6.90625 h 1.04688 v 0.96875 q 0.32812,-0.51563 0.8593=
7,-0.8125 0.54688,-0.3125 1.23438,-0.3125 0.78125,0 1.26562,0.3125 0.48438,=
0.3125 0.6875,0.89062 0.82813,-1.20312 2.14063,-1.20312 1.03125,0 1.57812,0=
.57812 0.5625,0.5625 0.5625,1.73438 v 4.75 h -1.17187 v -4.35938 q 0,-0.703=
12 -0.125,-1 -0.10938,-0.3125 -0.40625,-0.5 -0.29688,-0.1875 -0.70313,-0.18=
75 -0.71875,0 -1.20312,0.48438 -0.48438,0.48437 -0.48438,1.54687 v 4.01563 =
h -1.17187 v -4.48438 q 0,-0.78125 -0.29688,-1.17187 -0.28125,-0.39063 -0.9=
2187,-0.39063 -0.5,0 -0.92188,0.26563 -0.42187,0.25 -0.60937,0.75 -0.1875,0=
.5 -0.1875,1.45312 v 3.57813 z m 15.83681,-2.21875 1.20312,0.14062 q -0.281=
25,1.0625 -1.0625,1.65625 -0.76562,0.57813 -1.96875,0.57813 -1.51562,0 -2.4=
0625,-0.9375 -0.89062,-0.9375 -0.89062,-2.60938 0,-1.75 0.89062,-2.70312 0.=
90625,-0.96875 2.34375,-0.96875 1.39063,0 2.26563,0.9375 0.875,0.9375 0.875=
,2.65625 0,0.10937 0,0.3125 h -5.15625 q 0.0625,1.14062 0.64062,1.75 0.5781=
3,0.59375 1.4375,0.59375 0.65625,0 1.10938,-0.32813 0.45312,-0.34375 0.7187=
5,-1.07812 z m -3.8438,-1.90625 h 3.85937 q -0.0781,-0.85938 -0.4375,-1.296=
88 -0.5625,-0.6875 -1.45312,-0.6875 -0.8125,0 -1.35938,0.54688 -0.54687,0.5=
3125 -0.60937,1.4375 z m 6.52185,4.125 v -6.90625 h 1.04687 v 0.96875 q 0.3=
2813,-0.51563 0.85938,-0.8125 0.54687,-0.3125 1.23437,-0.3125 0.78125,0 1.2=
6563,0.3125 0.48437,0.3125 0.6875,0.89062 0.82812,-1.20312 2.14062,-1.20312=
 1.03125,0 1.57813,0.57812 0.5625,0.5625 0.5625,1.73438 v 4.75 h -1.17188 v=
 -4.35938 q 0,-0.70312 -0.125,-1 -0.10937,-0.3125 -0.40625,-0.5 -0.29687,-0=
.1875 -0.70312,-0.1875 -0.71875,0 -1.20313,0.48438 -0.48437,0.48437 -0.4843=
7,1.54687 v 4.01563 h -1.17188 v -4.48438 q 0,-0.78125 -0.29687,-1.17187 -0=
.28125,-0.39063 -0.92188,-0.39063 -0.5,0 -0.92187,0.26563 -0.42188,0.25 -0.=
60938,0.75 -0.1875,0.5 -0.1875,1.45312 v 3.57813 z m 10.66493,-3.45313 q 0,=
-1.92187 1.07813,-2.84375 0.89062,-0.76562 2.17187,-0.76562 1.42188,0 2.328=
13,0.9375 0.90625,0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.390=
63,0.76563 -1.15625,1.1875 -0.76563,0.42188 -1.67188,0.42188 -1.45312,0 -2.=
35937,-0.92188 -0.89063,-0.9375 -0.89063,-2.6875 z m 1.20313,0 q 0,1.32813 =
0.57812,1.98438 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45313,-0.65625 0.=
57812,-0.67188 0.57812,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57812,-0.656=
25 -1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57812,0.65625 -0.57812,1.9=
8437 z m 6.63122,3.45313 v -6.90625 h 1.0625 v 1.04687 q 0.40625,-0.73437 0=
.73438,-0.96875 0.34375,-0.23437 0.76562,-0.23437 0.59375,0 1.20313,0.375 l=
 -0.40625,1.07812 q -0.4375,-0.25 -0.85938,-0.25 -0.39062,0 -0.70312,0.2343=
8 -0.29688,0.23437 -0.42188,0.64062 -0.20312,0.625 -0.20312,1.35938 v 3.625=
 z m 4.40712,2.65625 -0.125,-1.09375 q 0.375,0.10937 0.65625,0.10937 0.3906=
3,0 0.625,-0.14062 0.23438,-0.125 0.39063,-0.35938 0.10937,-0.17187 0.35937=
,-0.875 0.0312,-0.0937 0.10938,-0.28125 l -2.625,-6.92187 h 1.26562 l 1.437=
5,4 q 0.28125,0.76562 0.5,1.59375 0.20313,-0.79688 0.46875,-1.57813 l 1.484=
38,-4.01562 h 1.17187 l -2.625,7.01562 q -0.42187,1.14063 -0.65625,1.57813 =
-0.3125,0.57812 -0.71875,0.84375 -0.40625,0.28125 -0.96875,0.28125 -0.32812=
,0 -0.75,-0.15625 z m 10.39832,-2.65625 v -9.54688 h 1.17187 v 9.54688 z m =
7.49234,-0.85938 q -0.65625,0.5625 -1.26563,0.79688 -0.59375,0.21875 -1.281=
25,0.21875 -1.14062,0 -1.75,-0.54688 -0.60937,-0.5625 -0.60937,-1.4375 0,-0=
.5 0.21875,-0.92187 0.23437,-0.42188 0.60937,-0.67188 0.375,-0.25 0.84375,-=
0.39062 0.34375,-0.0781 1.04688,-0.17188 1.42187,-0.17187 2.09375,-0.40625 =
0,-0.23437 0,-0.29687 0,-0.71875 -0.32813,-1.01563 -0.45312,-0.39062 -1.343=
75,-0.39062 -0.8125,0 -1.21875,0.29687 -0.39062,0.28125 -0.57812,1.01563 l =
-1.14063,-0.15625 q 0.15625,-0.73438 0.51563,-1.1875 0.35937,-0.45313 1.031=
25,-0.6875 0.67187,-0.25 1.5625,-0.25 0.89062,0 1.4375,0.20312 0.5625,0.203=
13 0.8125,0.53125 0.26562,0.3125 0.375,0.79688 0.0469,0.29687 0.0469,1.0781=
2 v 1.5625 q 0,1.625 0.0781,2.0625 0.0781,0.4375 0.29687,0.82813 h -1.21875=
 q -0.1875,-0.35938 -0.23437,-0.85938 z m -0.0937,-2.60937 q -0.64063,0.265=
62 -1.92188,0.4375 -0.71875,0.10937 -1.01562,0.25 -0.29688,0.125 -0.46875,0=
.375 -0.15625,0.25 -0.15625,0.54687 0,0.46875 0.34375,0.78125 0.35937,0.312=
5 1.04687,0.3125 0.67188,0 1.20313,-0.29687 0.53125,-0.29688 0.78125,-0.812=
5 0.1875,-0.39063 0.1875,-1.17188 z m 2.94372,6.125 -0.125,-1.09375 q 0.375=
,0.10937 0.65625,0.10937 0.39063,0 0.625,-0.14062 0.23438,-0.125 0.39063,-0=
.35938 0.10937,-0.17187 0.35937,-0.875 0.0312,-0.0937 0.10938,-0.28125 l -2=
.625,-6.92187 h 1.26562 l 1.4375,4 q 0.28125,0.76562 0.5,1.59375 0.20313,-0=
.79688 0.46875,-1.57813 l 1.48438,-4.01562 h 1.17187 l -2.625,7.01562 q -0.=
42187,1.14063 -0.65625,1.57813 -0.3125,0.57812 -0.71875,0.84375 -0.40625,0.=
28125 -0.96875,0.28125 -0.32812,0 -0.75,-0.15625 z m 6.27344,-6.10938 q 0,-=
1.92187 1.07812,-2.84375 0.89063,-0.76562 2.17188,-0.76562 1.42187,0 2.3281=
2,0.9375 0.90625,0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.3906=
2,0.76563 -1.15625,1.1875 -0.76562,0.42188 -1.67187,0.42188 -1.45313,0 -2.3=
5938,-0.92188 -0.89062,-0.9375 -0.89062,-2.6875 z m 1.20312,0 q 0,1.32813 0=
.57813,1.98438 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45312,-0.65625 0.5=
7813,-0.67188 0.57813,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57813,-0.6562=
5 -1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57813,0.65625 -0.57813,1.98=
437 z m 11.17811,3.45313 v -1.01563 q -0.8125,1.17188 -2.1875,1.17188 -0.60=
938,0 -1.14063,-0.23438 -0.53125,-0.23437 -0.79687,-0.57812 -0.25,-0.35938 =
-0.35938,-0.875 -0.0625,-0.34375 -0.0625,-1.09375 v -4.28125 h 1.17188 v 3.=
82812 q 0,0.92188 0.0625,1.23438 0.10937,0.46875 0.46875,0.73437 0.35937,0.=
25 0.89062,0.25 0.51563,0 0.98438,-0.26562 0.46875,-0.26563 0.65625,-0.7343=
8 0.1875,-0.46875 0.1875,-1.34375 v -3.70312 h 1.17187 v 6.90625 z m 5.4437=
2,-1.04688 0.17188,1.03125 q -0.5,0.10938 -0.89063,0.10938 -0.64062,0 -1,-0=
.20313 -0.34375,-0.20312 -0.48437,-0.53125 -0.14063,-0.32812 -0.14063,-1.39=
062 v -3.96875 h -0.85937 v -0.90625 h 0.85937 v -1.71875 l 1.17188,-0.7031=
3 v 2.42188 H 301.87 v 0.90625 h -1.17187 v 4.04687 q 0,0.5 0.0469,0.64063 =
0.0625,0.14062 0.20313,0.23437 0.14062,0.0781 0.40625,0.0781 0.20312,0 0.51=
562,-0.0469 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path280"=0D
> -       style=3D"fill:#c8ab37" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       fill-opacity=3D"0"=0D
> -       d=3D"m 141.69362,420.4057 c -7.18405,0 -13.00787,-0.97061 -13.007=
87,-2.16791 v -97.61697 c 0,-1.1973 -5.82383,-2.16788 -13.00788,-2.16788 v =
0 c 7.18405,0 13.00788,-0.97061 13.00788,-2.16791 v -97.61696 0 c 0,-1.1972=
9 5.82382,-2.16789 13.00787,-2.16789 z"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path282" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       fill-opacity=3D"0"=0D
> -       d=3D"m 141.69362,420.4057 c -7.18405,0 -13.00787,-0.97061 -13.007=
87,-2.16791 v -97.61697 c 0,-1.1973 -5.82383,-2.16788 -13.00788,-2.16788 v =
0 c 7.18405,0 13.00788,-0.97061 13.00788,-2.16791 v -97.61696 0 c 0,-1.1972=
9 5.82382,-2.16789 13.00787,-2.16789"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path284" />=0D
> -    <path=0D
> -       stroke=3D"#595959"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linejoin=3D"round"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"m 141.69362,420.4057 c -7.18405,0 -13.00787,-0.97061 -13.007=
87,-2.16791 v -97.61697 c 0,-1.1973 -5.82383,-2.16788 -13.00788,-2.16788 v =
0 c 7.18405,0 13.00788,-0.97061 13.00788,-2.16791 v -97.61696 0 c 0,-1.1972=
9 5.82382,-2.16789 13.00787,-2.16789"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path286"=0D
> -       style=3D"fill:none" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       fill-opacity=3D"0"=0D
> -       d=3D"m 66.103062,278.3112 h 99.401568 v 27.46457 H 66.103062 Z"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path288" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 75.899942,298.8312 v -6.21875 h 0.9375 v 0.875 q 0.6875,-1=
.01562 1.98437,-1.01562 0.5625,0 1.03125,0.20312 0.48438,0.20313 0.71875,0.=
53125 0.23438,0.32813 0.32813,0.76563 0.0469,0.29687 0.0469,1.03125 v 3.828=
12 h -1.04687 v -3.78125 q 0,-0.65625 -0.125,-0.96875 -0.125,-0.3125 -0.437=
5,-0.5 -0.3125,-0.20312 -0.73438,-0.20312 -0.67187,0 -1.17187,0.4375 -0.484=
38,0.42187 -0.48438,1.60937 v 3.40625 z m 7.64258,0 h -0.98438 v -8.59375 h=
 1.0625 v 3.0625 q 0.67188,-0.82812 1.70313,-0.82812 0.57812,0 1.07812,0.23=
437 0.51563,0.21875 0.84375,0.64063 0.34375,0.42187 0.53125,1.01562 0.1875,=
0.59375 0.1875,1.26563 0,1.59375 -0.79687,2.46875 -0.79688,0.875 -1.89063,0=
.875 -1.10937,0 -1.73437,-0.92188 z m -0.0156,-3.15625 q 0,1.10938 0.3125,1=
.60938 0.5,0.8125 1.34375,0.8125 0.6875,0 1.1875,-0.59375 0.51562,-0.59375 =
0.51562,-1.79688 0,-1.21875 -0.48437,-1.79687 -0.48438,-0.57813 -1.17188,-0=
.57813 -0.6875,0 -1.20312,0.60938 -0.5,0.59375 -0.5,1.73437 z m 4.73633,5.5=
4688 v -0.76563 h 7 v 0.76563 z m 7.6582,-2.39063 v -6.21875 h 0.9375 v 0.8=
75 q 0.6875,-1.01562 1.98437,-1.01562 0.5625,0 1.03125,0.20312 0.484378,0.2=
0313 0.718748,0.53125 0.23438,0.32813 0.32813,0.76563 0.0469,0.29687 0.0469=
,1.03125 v 3.82812 h -1.046878 v -3.78125 q 0,-0.65625 -0.125,-0.96875 -0.1=
25,-0.3125 -0.4375,-0.5 -0.3125,-0.20312 -0.73437,-0.20312 -0.67188,0 -1.17=
188,0.4375 -0.48437,0.42187 -0.48437,1.60937 v 3.40625 z m 6.283208,-3.1093=
7 q 0,-1.73438 0.95312,-2.5625 0.79688,-0.6875 1.95313,-0.6875 1.28125,0 2.=
09375,0.84375 0.82812,0.82812 0.82812,2.3125 0,1.20312 -0.35937,1.89062 -0.=
35938,0.6875 -1.0625,1.07813 -0.6875,0.375 -1.5,0.375 -1.29688,0 -2.10938,-=
0.82813 -0.79687,-0.84375 -0.79687,-2.42187 z m 1.07812,0 q 0,1.1875 0.5156=
3,1.78125 0.53125,0.59375 1.3125,0.59375 0.79687,0 1.3125,-0.59375 0.51562,=
-0.59375 0.51562,-1.8125 0,-1.15625 -0.53125,-1.75 -0.51562,-0.59375 -1.296=
87,-0.59375 -0.78125,0 -1.3125,0.59375 -0.51563,0.57812 -0.51563,1.78125 z =
m 10.01758,3.10937 v -0.78125 q -0.59375,0.92188 -1.73437,0.92188 -0.75,0 -=
1.375,-0.40625 -0.625,-0.42188 -0.96875,-1.15625 -0.34375,-0.73438 -0.34375=
,-1.6875 0,-0.92188 0.3125,-1.6875 0.3125,-0.76563 0.9375,-1.15625 0.625,-0=
.40625 1.39062,-0.40625 0.5625,0 1,0.23437 0.4375,0.23438 0.71875,0.60938 v=
 -3.07813 h 1.04688 v 8.59375 z m -3.32812,-3.10937 q 0,1.20312 0.5,1.79687=
 0.5,0.57813 1.1875,0.57813 0.6875,0 1.17187,-0.5625 0.48438,-0.5625 0.4843=
8,-1.71875 0,-1.28125 -0.5,-1.875 -0.48438,-0.59375 -1.20313,-0.59375 -0.70=
312,0 -1.17187,0.57812 -0.46875,0.5625 -0.46875,1.79688 z m 10.2207,1.10937=
 1.09375,0.125 q -0.25,0.95313 -0.95313,1.48438 -0.70312,0.53125 -1.78125,0=
.53125 -1.35937,0 -2.17187,-0.84375 -0.79688,-0.84375 -0.79688,-2.35938 0,-=
1.5625 0.8125,-2.42187 0.8125,-0.875 2.09375,-0.875 1.25,0 2.03125,0.84375 =
0.79688,0.84375 0.79688,2.39062 0,0.0937 0,0.28125 h -4.64063 q 0.0625,1.03=
125 0.57813,1.57813 0.51562,0.53125 1.29687,0.53125 0.57813,0 0.98438,-0.29=
688 0.42187,-0.3125 0.65625,-0.96875 z m -3.45313,-1.70312 h 3.46875 q -0.0=
625,-0.79688 -0.39062,-1.1875 -0.51563,-0.60938 -1.3125,-0.60938 -0.73438,0=
 -1.23438,0.48438 -0.48437,0.48437 -0.53125,1.3125 z m 5.45508,1.84375 1.03=
125,-0.15625 q 0.0937,0.625 0.48438,0.95312 0.40625,0.32813 1.14062,0.32813=
 0.71875,0 1.0625,-0.28125 0.35938,-0.29688 0.35938,-0.70313 0,-0.35937 -0.=
3125,-0.5625 -0.21875,-0.14062 -1.07813,-0.35937 -1.15625,-0.29688 -1.60937=
,-0.5 -0.4375,-0.21875 -0.67188,-0.59375 -0.23437,-0.375 -0.23437,-0.84375 =
0,-0.40625 0.1875,-0.76563 0.1875,-0.35937 0.51562,-0.59375 0.25,-0.17187 0=
.67188,-0.29687 0.42187,-0.125 0.92187,-0.125 0.71875,0 1.26563,0.21875 0.5=
625,0.20312 0.82812,0.5625 0.26563,0.35937 0.35938,0.95312 l -1.03125,0.140=
63 q -0.0625,-0.46875 -0.40625,-0.73438 -0.32813,-0.28125 -0.95313,-0.28125=
 -0.71875,0 -1.03125,0.25 -0.3125,0.23438 -0.3125,0.5625 0,0.20313 0.125,0.=
35938 0.14063,0.17187 0.40625,0.28125 0.15625,0.0625 0.9375,0.26562 1.125,0=
.3125 1.5625,0.5 0.4375,0.1875 0.6875,0.54688 0.25,0.35937 0.25,0.90625 0,0=
.53125 -0.3125,1 -0.29687,0.45312 -0.875,0.71875 -0.57812,0.25 -1.3125,0.25=
 -1.21875,0 -1.85937,-0.5 -0.625,-0.51563 -0.79688,-1.5 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path290" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 688.20019,75.514867 V 360.08705"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path292" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 816.64369,75.514867 V 360.08705"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path294" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"m 687.70149,76.013557 h 129.441"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path296" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"m 687.70149,111.21041 h 129.441"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path298" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"m 687.70149,148.40726 h 129.441"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path300" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"m 687.70149,183.60412 h 129.441"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path302" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"m 687.70149,218.80095 h 129.441"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path304" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"m 687.70149,253.99782 h 129.441"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path306" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"m 687.70149,289.19466 h 129.441"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path308" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"m 687.70149,324.3915 h 129.441"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path310" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"0.969816"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 688.95796,420.60254 H 810.70284"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path310-0" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"0.9689"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 689.29865,450.44943 H 810.81369"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path310-0-7" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"m 687.70149,359.58837 h 129.441"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path312" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 734.99429,97.813557 v -9.54688 h 6.4375 v 1.125 h -5.1719 =
v 2.96875 h 4.4688 v 1.125 h -4.4688 v 4.32813 z m 12.657,-2.21875 1.2031,0=
.14062 q -0.2812,1.0625 -1.0625,1.65625 -0.7656,0.57813 -1.9687,0.57813 -1.=
5157,0 -2.4063,-0.9375 -0.8906,-0.9375 -0.8906,-2.60938 0,-1.75 0.8906,-2.7=
0312 0.9063,-0.96875 2.3438,-0.96875 1.3906,0 2.2656,0.9375 0.875,0.9375 0.=
875,2.65625 0,0.10937 0,0.3125 h -5.1563 q 0.062,1.14062 0.6407,1.75 0.5781=
,0.59375 1.4375,0.59375 0.6562,0 1.1093,-0.32813 0.4532,-0.34375 0.7188,-1.=
07812 z m -3.8438,-1.90625 h 3.8594 q -0.078,-0.85938 -0.4375,-1.29688 -0.5=
625,-0.6875 -1.4531,-0.6875 -0.8125,0 -1.3594,0.54688 -0.5469,0.53125 -0.60=
94,1.4375 z m 6.5219,4.125 v -6.90625 h 1.0625 v 0.98437 q 0.75,-1.14062 2.=
1875,-1.14062 0.625,0 1.1562,0.21875 0.5313,0.21875 0.7813,0.59375 0.2656,0=
.35937 0.375,0.85937 0.062,0.32813 0.062,1.14063 v 4.25 h -1.1719 v -4.2031=
3 q 0,-0.71875 -0.1406,-1.0625 -0.1406,-0.35937 -0.4844,-0.5625 -0.3437,-0.=
21875 -0.8125,-0.21875 -0.75,0 -1.2969,0.46875 -0.5468,0.46875 -0.5468,1.79=
688 v 3.78125 z m 11.9281,-2.53125 1.1562,0.15625 q -0.1875,1.1875 -0.9687,=
1.85937 -0.7813,0.67188 -1.9219,0.67188 -1.4062,0 -2.2812,-0.92188 -0.8594,=
-0.9375 -0.8594,-2.65625 0,-1.125 0.375,-1.96875 0.375,-0.84375 1.125,-1.25=
 0.7656,-0.42187 1.6562,-0.42187 1.125,0 1.8438,0.57812 0.7187,0.5625 0.921=
9,1.60938 l -1.1407,0.17187 q -0.1718,-0.70312 -0.5937,-1.04687 -0.4063,-0.=
35938 -0.9844,-0.35938 -0.8906,0 -1.4531,0.64063 -0.5469,0.64062 -0.5469,2 =
0,1.40625 0.5313,2.03125 0.5468,0.625 1.4062,0.625 0.6875,0 1.1406,-0.42188=
 0.4688,-0.42187 0.5938,-1.29687 z m 6.8828,0.3125 1.2031,0.14062 q -0.2812=
,1.0625 -1.0625,1.65625 -0.7656,0.57813 -1.9687,0.57813 -1.5157,0 -2.4063,-=
0.9375 -0.8906,-0.9375 -0.8906,-2.60938 0,-1.75 0.8906,-2.70312 0.9063,-0.9=
6875 2.3438,-0.96875 1.3906,0 2.2656,0.9375 0.875,0.9375 0.875,2.65625 0,0.=
10937 0,0.3125 h -5.1563 q 0.062,1.14062 0.6407,1.75 0.5781,0.59375 1.4375,=
0.59375 0.6562,0 1.1093,-0.32813 0.4532,-0.34375 0.7188,-1.07812 z m -3.843=
8,-1.90625 h 3.8594 q -0.078,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.4=
531,-0.6875 -0.8125,0 -1.3594,0.54688 -0.5469,0.53125 -0.6094,1.4375 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path314" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 710.41189,129.94791 1.2031,-0.10938 q 0.078,0.71875 0.3906=
,1.1875 0.3125,0.45313 0.9532,0.73438 0.6562,0.28125 1.4687,0.28125 0.7188,=
0 1.2656,-0.21875 0.5625,-0.21875 0.8282,-0.57813 0.2656,-0.375 0.2656,-0.8=
2812 0,-0.45313 -0.2656,-0.78125 -0.25,-0.32813 -0.8438,-0.5625 -0.3906,-0.=
15625 -1.7031,-0.46875 -1.3125,-0.3125 -1.8438,-0.59375 -0.6718,-0.35938 -1=
.0156,-0.89063 -0.3281,-0.53125 -0.3281,-1.1875 0,-0.71875 0.4062,-1.34375 =
0.4063,-0.625 1.1875,-0.95312 0.7969,-0.32813 1.7657,-0.32813 1.0468,0 1.85=
93,0.34375 0.8125,0.34375 1.25,1.01563 0.4375,0.65625 0.4688,1.48437 l -1.2=
031,0.0937 q -0.1094,-0.90625 -0.6719,-1.35937 -0.5625,-0.46875 -1.6563,-0.=
46875 -1.1406,0 -1.6718,0.42187 -0.5157,0.42188 -0.5157,1.01563 0,0.51562 0=
.3594,0.84375 0.375,0.32812 1.9063,0.6875 1.5468,0.34375 2.1093,0.59375 0.8=
438,0.39062 1.2344,0.98437 0.3906,0.57813 0.3906,1.35938 0,0.75 -0.4375,1.4=
375 -0.4218,0.67187 -1.25,1.04687 -0.8125,0.35938 -1.8281,0.35938 -1.2969,0=
 -2.1719,-0.375 -0.875,-0.375 -1.375,-1.125 -0.5,-0.76563 -0.5312,-1.71875 =
z m 9.1553,3.0625 v -9.54688 h 1.1719 v 9.54688 z m 2.5393,-3.45313 q 0,-1.=
92187 1.0781,-2.84375 0.8906,-0.76562 2.1719,-0.76562 1.4218,0 2.3281,0.937=
5 0.9062,0.92187 0.9062,2.57812 0,1.32813 -0.4062,2.09375 -0.3906,0.76563 -=
1.1563,1.1875 -0.7656,0.42188 -1.6718,0.42188 -1.4532,0 -2.3594,-0.92188 -0=
.8906,-0.9375 -0.8906,-2.6875 z m 1.2031,0 q 0,1.32813 0.5781,1.98438 0.593=
8,0.65625 1.4688,0.65625 0.875,0 1.4531,-0.65625 0.5781,-0.67188 0.5781,-2.=
03125 0,-1.28125 -0.5937,-1.9375 -0.5782,-0.65625 -1.4375,-0.65625 -0.875,0=
 -1.4688,0.65625 -0.5781,0.65625 -0.5781,1.98437 z m 7.9281,3.45313 -2.125,=
-6.90625 h 1.2188 l 1.0937,3.98437 0.4219,1.48438 q 0.016,-0.10938 0.3594,-=
1.42188 l 1.0937,-4.04687 h 1.2031 l 1.0313,4 0.3437,1.32812 0.4063,-1.3437=
5 1.1719,-3.98437 h 1.1406 l -2.1563,6.90625 h -1.2187 l -1.0938,-4.14063 -=
0.2656,-1.17187 -1.4062,5.3125 z m 8.3439,2.65625 v -9.5625 h 1.0781 v 0.89=
062 q 0.375,-0.53125 0.8437,-0.78125 0.4844,-0.26562 1.1563,-0.26562 0.875,=
0 1.5469,0.45312 0.6875,0.45313 1.0312,1.28125 0.3438,0.82813 0.3438,1.8281=
3 0,1.04687 -0.375,1.90625 -0.375,0.84375 -1.1094,1.29687 -0.7188,0.45313 -=
1.5313,0.45313 -0.5781,0 -1.0468,-0.25 -0.4688,-0.25 -0.7657,-0.625 v 3.375=
 z m 1.0625,-6.07813 q 0,1.34375 0.5312,1.98438 0.5469,0.625 1.3125,0.625 0=
.7813,0 1.3438,-0.65625 0.5625,-0.65625 0.5625,-2.04688 0,-1.3125 -0.5469,-=
1.96875 -0.5469,-0.67187 -1.2969,-0.67187 -0.75,0 -1.3281,0.70312 -0.5781,0=
.70313 -0.5781,2.03125 z m 10.8656,2.5625 q -0.6563,0.5625 -1.2657,0.79688 =
-0.5937,0.21875 -1.2812,0.21875 -1.1406,0 -1.75,-0.54688 -0.6094,-0.5625 -0=
.6094,-1.4375 0,-0.5 0.2188,-0.92187 0.2343,-0.42188 0.6093,-0.67188 0.375,=
-0.25 0.8438,-0.39062 0.3437,-0.0781 1.0469,-0.17188 1.4218,-0.17187 2.0937=
,-0.40625 0,-0.23437 0,-0.29687 0,-0.71875 -0.3281,-1.01563 -0.4531,-0.3906=
2 -1.3438,-0.39062 -0.8125,0 -1.2187,0.29687 -0.3906,0.28125 -0.5781,1.0156=
3 l -1.1407,-0.15625 q 0.1563,-0.73438 0.5157,-1.1875 0.3593,-0.45313 1.031=
2,-0.6875 0.6719,-0.25 1.5625,-0.25 0.8906,0 1.4375,0.20312 0.5625,0.20313 =
0.8125,0.53125 0.2656,0.3125 0.375,0.79688 0.047,0.29687 0.047,1.07812 v 1.=
5625 q 0,1.625 0.078,2.0625 0.078,0.4375 0.2969,0.82813 h -1.2188 q -0.1875=
,-0.35938 -0.2343,-0.85938 z m -0.094,-2.60937 q -0.6407,0.26562 -1.9219,0.=
4375 -0.7188,0.10937 -1.0156,0.25 -0.2969,0.125 -0.4688,0.375 -0.1562,0.25 =
-0.1562,0.54687 0,0.46875 0.3437,0.78125 0.3594,0.3125 1.0469,0.3125 0.6719=
,0 1.2031,-0.29687 0.5313,-0.29688 0.7813,-0.8125 0.1875,-0.39063 0.1875,-1=
.17188 z m 5.5531,2.42187 0.1718,1.03125 q -0.5,0.10938 -0.8906,0.10938 -0.=
6406,0 -1,-0.20313 -0.3437,-0.20312 -0.4844,-0.53125 -0.1406,-0.32812 -0.14=
06,-1.39062 v -3.96875 h -0.8594 v -0.90625 h 0.8594 v -1.71875 l 1.1719,-0=
.70313 v 2.42188 h 1.1719 v 0.90625 h -1.1719 v 4.04687 q 0,0.5 0.047,0.640=
63 0.062,0.14062 0.2031,0.23437 0.1406,0.0781 0.4063,0.0781 0.2031,0 0.5156=
,-0.0469 z m 1.1405,1.04688 v -9.54688 h 1.1719 v 3.42188 q 0.8281,-0.9375 =
2.0781,-0.9375 0.7656,0 1.3281,0.29687 0.5625,0.29688 0.8125,0.84375 0.25,0=
.53125 0.25,1.54688 v 4.375 h -1.1719 v -4.375 q 0,-0.89063 -0.3906,-1.2812=
5 -0.375,-0.40625 -1.0781,-0.40625 -0.5156,0 -0.9844,0.28125 -0.4531,0.2656=
2 -0.6562,0.73437 -0.1875,0.45313 -0.1875,1.26563 v 3.78125 z m 15.6311,-0.=
85938 q -0.6563,0.5625 -1.2656,0.79688 -0.5938,0.21875 -1.2813,0.21875 -1.1=
406,0 -1.75,-0.54688 -0.6094,-0.5625 -0.6094,-1.4375 0,-0.5 0.2188,-0.92187=
 0.2344,-0.42188 0.6094,-0.67188 0.375,-0.25 0.8437,-0.39062 0.3438,-0.0781=
 1.0469,-0.17188 1.4219,-0.17187 2.0937,-0.40625 0,-0.23437 0,-0.29687 0,-0=
.71875 -0.3281,-1.01563 -0.4531,-0.39062 -1.3437,-0.39062 -0.8125,0 -1.2188=
,0.29687 -0.3906,0.28125 -0.5781,1.01563 l -1.1406,-0.15625 q 0.1562,-0.734=
38 0.5156,-1.1875 0.3594,-0.45313 1.0312,-0.6875 0.6719,-0.25 1.5625,-0.25 =
0.8907,0 1.4375,0.20312 0.5625,0.20313 0.8125,0.53125 0.2657,0.3125 0.375,0=
.79688 0.047,0.29687 0.047,1.07812 v 1.5625 q 0,1.625 0.078,2.0625 0.078,0.=
4375 0.2969,0.82813 h -1.2187 q -0.1875,-0.35938 -0.2344,-0.85938 z m -0.09=
4,-2.60937 q -0.6406,0.26562 -1.9219,0.4375 -0.7187,0.10937 -1.0156,0.25 -0=
.2969,0.125 -0.4688,0.375 -0.1562,0.25 -0.1562,0.54687 0,0.46875 0.3437,0.7=
8125 0.3594,0.3125 1.0469,0.3125 0.6719,0 1.2031,-0.29687 0.5313,-0.29688 0=
.7813,-0.8125 0.1875,-0.39063 0.1875,-1.17188 z m 2.975,3.46875 v -6.90625 =
h 1.0625 v 1.04687 q 0.4062,-0.73437 0.7343,-0.96875 0.3438,-0.23437 0.7657=
,-0.23437 0.5937,0 1.2031,0.375 l -0.4063,1.07812 q -0.4375,-0.25 -0.8593,-=
0.25 -0.3907,0 -0.7032,0.23438 -0.2968,0.23437 -0.4218,0.64062 -0.2032,0.62=
5 -0.2032,1.35938 v 3.625 z m 9.1883,-2.21875 1.2031,0.14062 q -0.2812,1.06=
25 -1.0625,1.65625 -0.7656,0.57813 -1.9687,0.57813 -1.5156,0 -2.4063,-0.937=
5 -0.8906,-0.9375 -0.8906,-2.60938 0,-1.75 0.8906,-2.70312 0.9063,-0.96875 =
2.3438,-0.96875 1.3906,0 2.2656,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937=
 0,0.3125 h -5.1562 q 0.062,1.14062 0.6406,1.75 0.5781,0.59375 1.4375,0.593=
75 0.6562,0 1.1094,-0.32813 0.4531,-0.34375 0.7187,-1.07812 z m -3.8437,-1.=
90625 h 3.8593 q -0.078,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.4531,-=
0.6875 -0.8125,0 -1.3594,0.54688 -0.5468,0.53125 -0.6093,1.4375 z m 11.0374=
,3.26562 q -0.6562,0.5625 -1.2656,0.79688 -0.5937,0.21875 -1.2812,0.21875 -=
1.1407,0 -1.75,-0.54688 -0.6094,-0.5625 -0.6094,-1.4375 0,-0.5 0.2187,-0.92=
187 0.2344,-0.42188 0.6094,-0.67188 0.375,-0.25 0.8438,-0.39062 0.3437,-0.0=
781 1.0468,-0.17188 1.4219,-0.17187 2.0938,-0.40625 0,-0.23437 0,-0.29687 0=
,-0.71875 -0.3281,-1.01563 -0.4532,-0.39062 -1.3438,-0.39062 -0.8125,0 -1.2=
187,0.29687 -0.3907,0.28125 -0.5782,1.01563 l -1.1406,-0.15625 q 0.1563,-0.=
73438 0.5156,-1.1875 0.3594,-0.45313 1.0313,-0.6875 0.6719,-0.25 1.5625,-0.=
25 0.8906,0 1.4375,0.20312 0.5625,0.20313 0.8125,0.53125 0.2656,0.3125 0.37=
5,0.79688 0.047,0.29687 0.047,1.07812 v 1.5625 q 0,1.625 0.078,2.0625 0.078=
,0.4375 0.2969,0.82813 h -1.2188 q -0.1875,-0.35938 -0.2344,-0.85938 z m -0=
.094,-2.60937 q -0.6406,0.26562 -1.9218,0.4375 -0.7188,0.10937 -1.0157,0.25=
 -0.2968,0.125 -0.4687,0.375 -0.1563,0.25 -0.1563,0.54687 0,0.46875 0.3438,=
0.78125 0.3594,0.3125 1.0469,0.3125 0.6718,0 1.2031,-0.29687 0.5312,-0.2968=
8 0.7812,-0.8125 0.1875,-0.39063 0.1875,-1.17188 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path316" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 711.36619,166.86352 1.2656,0.3125 q -0.3906,1.5625 -1.4219=
,2.375 -1.0312,0.8125 -2.5312,0.8125 -1.5313,0 -2.5,-0.625 -0.9688,-0.625 -=
1.4844,-1.8125 -0.5,-1.1875 -0.5,-2.5625 0,-1.48438 0.5625,-2.59375 0.5781,=
-1.10938 1.625,-1.6875 1.0625,-0.57813 2.3281,-0.57813 1.4219,0 2.3907,0.73=
438 0.9843,0.71875 1.375,2.04687 l -1.25,0.29688 q -0.3282,-1.04688 -0.9688=
,-1.51563 -0.625,-0.48437 -1.5781,-0.48437 -1.0938,0 -1.8438,0.53125 -0.734=
3,0.53125 -1.0312,1.42187 -0.2969,0.875 -0.2969,1.82813 0,1.21875 0.3438,2.=
125 0.3593,0.90625 1.1093,1.35937 0.75,0.4375 1.625,0.4375 1.0625,0 1.7969,=
-0.60937 0.7344,-0.60938 0.9844,-1.8125 z m 2.2345,-0.10938 q 0,-1.92187 1.=
0781,-2.84375 0.8906,-0.76562 2.1719,-0.76562 1.4219,0 2.3281,0.9375 0.9063=
,0.92187 0.9063,2.57812 0,1.32813 -0.4063,2.09375 -0.3906,0.76563 -1.1562,1=
.1875 -0.7657,0.42188 -1.6719,0.42188 -1.4531,0 -2.3594,-0.92188 -0.8906,-0=
.9375 -0.8906,-2.6875 z m 1.2031,0 q 0,1.32813 0.5781,1.98438 0.5938,0.6562=
5 1.4688,0.65625 0.875,0 1.4531,-0.65625 0.5781,-0.67188 0.5781,-2.03125 0,=
-1.28125 -0.5937,-1.9375 -0.5781,-0.65625 -1.4375,-0.65625 -0.875,0 -1.4688=
,0.65625 -0.5781,0.65625 -0.5781,1.98437 z m 6.6469,3.45313 v -6.90625 h 1.=
0625 v 0.98437 q 0.75,-1.14062 2.1875,-1.14062 0.625,0 1.1562,0.21875 0.531=
3,0.21875 0.7813,0.59375 0.2656,0.35937 0.375,0.85937 0.062,0.32813 0.062,1=
.14063 v 4.25 h -1.1719 v -4.20313 q 0,-0.71875 -0.1406,-1.0625 -0.1407,-0.=
35937 -0.4844,-0.5625 -0.3438,-0.21875 -0.8125,-0.21875 -0.75,0 -1.2969,0.4=
6875 -0.5469,0.46875 -0.5469,1.79688 v 3.78125 z m 9.9749,-1.04688 0.1719,1=
.03125 q -0.5,0.10938 -0.8906,0.10938 -0.6406,0 -1,-0.20313 -0.3438,-0.2031=
2 -0.4844,-0.53125 -0.1406,-0.32812 -0.1406,-1.39062 v -3.96875 h -0.8594 v=
 -0.90625 h 0.8594 v -1.71875 l 1.1719,-0.70313 v 2.42188 h 1.1718 v 0.9062=
5 h -1.1718 v 4.04687 q 0,0.5 0.047,0.64063 0.062,0.14062 0.2031,0.23437 0.=
1406,0.0781 0.4062,0.0781 0.2032,0 0.5157,-0.0469 z m 5.8749,-1.17187 1.203=
1,0.14062 q -0.2812,1.0625 -1.0625,1.65625 -0.7656,0.57813 -1.9687,0.57813 =
-1.5156,0 -2.4063,-0.9375 -0.8906,-0.9375 -0.8906,-2.60938 0,-1.75 0.8906,-=
2.70312 0.9063,-0.96875 2.3438,-0.96875 1.3906,0 2.2656,0.9375 0.875,0.9375=
 0.875,2.65625 0,0.10937 0,0.3125 h -5.1562 q 0.062,1.14062 0.6406,1.75 0.5=
781,0.59375 1.4375,0.59375 0.6562,0 1.1094,-0.32813 0.4531,-0.34375 0.7187,=
-1.07812 z m -3.8437,-1.90625 h 3.8593 q -0.078,-0.85938 -0.4375,-1.29688 -=
0.5625,-0.6875 -1.4531,-0.6875 -0.8125,0 -1.3594,0.54688 -0.5468,0.53125 -0=
.6093,1.4375 z m 5.7406,4.125 2.5312,-3.59375 -2.3437,-3.3125 h 1.4687 l 1.=
0625,1.60937 q 0.2969,0.46875 0.4844,0.78125 0.2812,-0.4375 0.5156,-0.76562=
 l 1.1719,-1.625 h 1.4062 l -2.3906,3.25 2.5625,3.65625 h -1.4375 l -1.4219=
,-2.14063 -0.375,-0.59375 -1.8125,2.73438 z m 10.0078,-1.04688 0.1719,1.031=
25 q -0.5,0.10938 -0.8907,0.10938 -0.6406,0 -1,-0.20313 -0.3437,-0.20312 -0=
.4843,-0.53125 -0.1407,-0.32812 -0.1407,-1.39062 v -3.96875 h -0.8593 v -0.=
90625 h 0.8593 v -1.71875 l 1.1719,-0.70313 v 2.42188 h 1.1719 v 0.90625 h =
-1.1719 v 4.04687 q 0,0.5 0.047,0.64063 0.062,0.14062 0.2031,0.23437 0.1407=
,0.0781 0.4063,0.0781 0.2031,0 0.5156,-0.0469 z m 4.8434,1.04688 v -6.90625=
 h 1.0469 v 0.96875 q 0.3281,-0.51563 0.8594,-0.8125 0.5468,-0.3125 1.2343,=
-0.3125 0.7813,0 1.2657,0.3125 0.4843,0.3125 0.6875,0.89062 0.8281,-1.20312=
 2.1406,-1.20312 1.0312,0 1.5781,0.57812 0.5625,0.5625 0.5625,1.73438 v 4.7=
5 h -1.1719 v -4.35938 q 0,-0.70312 -0.125,-1 -0.1093,-0.3125 -0.4062,-0.5 =
-0.2969,-0.1875 -0.7031,-0.1875 -0.7188,0 -1.2032,0.48438 -0.4843,0.48437 -=
0.4843,1.54687 v 4.01563 h -1.1719 v -4.48438 q 0,-0.78125 -0.2969,-1.17187=
 -0.2812,-0.39063 -0.9219,-0.39063 -0.5,0 -0.9218,0.26563 -0.4219,0.25 -0.6=
094,0.75 -0.1875,0.5 -0.1875,1.45312 v 3.57813 z m 15.8369,-2.21875 1.2031,=
0.14062 q -0.2812,1.0625 -1.0625,1.65625 -0.7656,0.57813 -1.9687,0.57813 -1=
.5157,0 -2.4063,-0.9375 -0.8906,-0.9375 -0.8906,-2.60938 0,-1.75 0.8906,-2.=
70312 0.9063,-0.96875 2.3438,-0.96875 1.3906,0 2.2656,0.9375 0.875,0.9375 0=
.875,2.65625 0,0.10937 0,0.3125 h -5.1563 q 0.062,1.14062 0.6407,1.75 0.578=
1,0.59375 1.4375,0.59375 0.6562,0 1.1093,-0.32813 0.4532,-0.34375 0.7188,-1=
.07812 z m -3.8438,-1.90625 h 3.8594 q -0.078,-0.85938 -0.4375,-1.29688 -0.=
5625,-0.6875 -1.4531,-0.6875 -0.8125,0 -1.3594,0.54688 -0.5469,0.53125 -0.6=
094,1.4375 z m 6.5219,4.125 v -6.90625 h 1.0468 v 0.96875 q 0.3282,-0.51563=
 0.8594,-0.8125 0.5469,-0.3125 1.2344,-0.3125 0.7812,0 1.2656,0.3125 0.4844=
,0.3125 0.6875,0.89062 0.8281,-1.20312 2.1406,-1.20312 1.0313,0 1.5782,0.57=
812 0.5625,0.5625 0.5625,1.73438 v 4.75 h -1.1719 v -4.35938 q 0,-0.70312 -=
0.125,-1 -0.1094,-0.3125 -0.4063,-0.5 -0.2968,-0.1875 -0.7031,-0.1875 -0.71=
87,0 -1.2031,0.48438 -0.4844,0.48437 -0.4844,1.54687 v 4.01563 h -1.1719 v =
-4.48438 q 0,-0.78125 -0.2968,-1.17187 -0.2813,-0.39063 -0.9219,-0.39063 -0=
.5,0 -0.9219,0.26563 -0.4219,0.25 -0.6094,0.75 -0.1875,0.5 -0.1875,1.45312 =
v 3.57813 z m 10.6649,-3.45313 q 0,-1.92187 1.0781,-2.84375 0.8906,-0.76562=
 2.1719,-0.76562 1.4219,0 2.3281,0.9375 0.9063,0.92187 0.9063,2.57812 0,1.3=
2813 -0.4063,2.09375 -0.3906,0.76563 -1.1562,1.1875 -0.7657,0.42188 -1.6719=
,0.42188 -1.4531,0 -2.3594,-0.92188 -0.8906,-0.9375 -0.8906,-2.6875 z m 1.2=
031,0 q 0,1.32813 0.5781,1.98438 0.5938,0.65625 1.4688,0.65625 0.875,0 1.45=
31,-0.65625 0.5781,-0.67188 0.5781,-2.03125 0,-1.28125 -0.5937,-1.9375 -0.5=
781,-0.65625 -1.4375,-0.65625 -0.875,0 -1.4688,0.65625 -0.5781,0.65625 -0.5=
781,1.98437 z m 6.6313,3.45313 v -6.90625 h 1.0625 v 1.04687 q 0.4062,-0.73=
437 0.7343,-0.96875 0.3438,-0.23437 0.7657,-0.23437 0.5937,0 1.2031,0.375 l=
 -0.4063,1.07812 q -0.4375,-0.25 -0.8593,-0.25 -0.3907,0 -0.7032,0.23438 -0=
.2968,0.23437 -0.4218,0.64062 -0.2032,0.625 -0.2032,1.35938 v 3.625 z m 4.4=
07,2.65625 -0.125,-1.09375 q 0.375,0.10937 0.6563,0.10937 0.3906,0 0.625,-0=
.14062 0.2344,-0.125 0.3906,-0.35938 0.1094,-0.17187 0.3594,-0.875 0.031,-0=
.0937 0.1094,-0.28125 l -2.625,-6.92187 h 1.2656 l 1.4375,4 q 0.2812,0.7656=
2 0.5,1.59375 0.2031,-0.79688 0.4687,-1.57813 l 1.4844,-4.01562 h 1.1719 l =
-2.625,7.01562 q -0.4219,1.14063 -0.6563,1.57813 -0.3125,0.57812 -0.7187,0.=
84375 -0.4063,0.28125 -0.9688,0.28125 -0.3281,0 -0.75,-0.15625 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path318" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 712.39569,205.4041 v -9.54688 h 6.4375 v 1.125 h -5.1719 v=
 2.96875 h 4.4688 v 1.125 h -4.4688 v 4.32813 z m 12.4382,-0.85938 q -0.656=
2,0.5625 -1.2656,0.79688 -0.5937,0.21875 -1.2812,0.21875 -1.1407,0 -1.75,-0=
.54688 -0.6094,-0.5625 -0.6094,-1.4375 0,-0.5 0.2187,-0.92187 0.2344,-0.421=
88 0.6094,-0.67188 0.375,-0.25 0.8438,-0.39062 0.3437,-0.0781 1.0468,-0.171=
88 1.4219,-0.17187 2.0938,-0.40625 0,-0.23437 0,-0.29687 0,-0.71875 -0.3281=
,-1.01563 -0.4532,-0.39062 -1.3438,-0.39062 -0.8125,0 -1.2187,0.29687 -0.39=
07,0.28125 -0.5782,1.01563 l -1.1406,-0.15625 q 0.1563,-0.73438 0.5156,-1.1=
875 0.3594,-0.45313 1.0313,-0.6875 0.6719,-0.25 1.5625,-0.25 0.8906,0 1.437=
5,0.20312 0.5625,0.20313 0.8125,0.53125 0.2656,0.3125 0.375,0.79688 0.047,0=
.29687 0.047,1.07812 v 1.5625 q 0,1.625 0.078,2.0625 0.078,0.4375 0.2969,0.=
82813 h -1.2188 q -0.1875,-0.35938 -0.2344,-0.85938 z m -0.094,-2.60937 q -=
0.6406,0.26562 -1.9218,0.4375 -0.7188,0.10937 -1.0157,0.25 -0.2968,0.125 -0=
.4687,0.375 -0.1563,0.25 -0.1563,0.54687 0,0.46875 0.3438,0.78125 0.3594,0.=
3125 1.0469,0.3125 0.6718,0 1.2031,-0.29687 0.5312,-0.29688 0.7812,-0.8125 =
0.1875,-0.39063 0.1875,-1.17188 z m 2.5219,1.40625 1.1562,-0.1875 q 0.1094,=
0.70312 0.5469,1.07812 0.4531,0.35938 1.25,0.35938 0.8125,0 1.2031,-0.32813=
 0.3907,-0.32812 0.3907,-0.76562 0,-0.39063 -0.3594,-0.625 -0.2344,-0.15625=
 -1.1875,-0.39063 -1.2969,-0.32812 -1.7969,-0.5625 -0.4844,-0.25 -0.75,-0.6=
5625 -0.25,-0.42187 -0.25,-0.9375 0,-0.45312 0.2031,-0.84375 0.2188,-0.4062=
5 0.5782,-0.67187 0.2812,-0.1875 0.75,-0.32813 0.4687,-0.14062 1.0156,-0.14=
062 0.8125,0 1.4219,0.23437 0.6093,0.23438 0.9062,0.64063 0.2969,0.39062 0.=
4063,1.0625 l -1.1407,0.15625 q -0.078,-0.53125 -0.4531,-0.82813 -0.375,-0.=
3125 -1.0625,-0.3125 -0.8125,0 -1.1562,0.26563 -0.3438,0.26562 -0.3438,0.62=
5 0,0.23437 0.1406,0.42187 0.1563,0.1875 0.4532,0.3125 0.1718,0.0625 1.0312=
,0.29688 1.25,0.32812 1.7344,0.54687 0.5,0.20313 0.7812,0.60938 0.2813,0.40=
625 0.2813,1 0,0.59375 -0.3438,1.10937 -0.3437,0.51563 -1,0.79688 -0.6406,0=
.28125 -1.4531,0.28125 -1.3437,0 -2.0469,-0.5625 -0.7031,-0.5625 -0.9062,-1=
.65625 z m 9.6953,1.01562 0.1719,1.03125 q -0.5,0.10938 -0.8907,0.10938 -0.=
6406,0 -1,-0.20313 -0.3437,-0.20312 -0.4843,-0.53125 -0.1407,-0.32812 -0.14=
07,-1.39062 v -3.96875 h -0.8593 v -0.90625 h 0.8593 v -1.71875 l 1.1719,-0=
.70313 v 2.42188 h 1.1719 v 0.90625 h -1.1719 v 4.04687 q 0,0.5 0.047,0.640=
63 0.062,0.14062 0.2031,0.23437 0.1407,0.0781 0.4063,0.0781 0.2031,0 0.5156=
,-0.0469 z m 1.1405,3.70313 v -9.5625 h 1.0781 v 0.89062 q 0.375,-0.53125 0=
.8438,-0.78125 0.4843,-0.26562 1.1562,-0.26562 0.875,0 1.5469,0.45312 0.687=
5,0.45313 1.0312,1.28125 0.3438,0.82813 0.3438,1.82813 0,1.04687 -0.375,1.9=
0625 -0.375,0.84375 -1.1094,1.29687 -0.7187,0.45313 -1.5312,0.45313 -0.5782=
,0 -1.0469,-0.25 -0.4688,-0.25 -0.7656,-0.625 v 3.375 z m 1.0625,-6.07813 q=
 0,1.34375 0.5312,1.98438 0.5469,0.625 1.3125,0.625 0.7813,0 1.3438,-0.6562=
5 0.5625,-0.65625 0.5625,-2.04688 0,-1.3125 -0.5469,-1.96875 -0.5469,-0.671=
87 -1.2969,-0.67187 -0.75,0 -1.3281,0.70312 -0.5781,0.70313 -0.5781,2.03125=
 z m 10.8656,2.5625 q -0.6563,0.5625 -1.2656,0.79688 -0.5938,0.21875 -1.281=
3,0.21875 -1.1406,0 -1.75,-0.54688 -0.6094,-0.5625 -0.6094,-1.4375 0,-0.5 0=
.2188,-0.92187 0.2344,-0.42188 0.6094,-0.67188 0.375,-0.25 0.8437,-0.39062 =
0.3438,-0.0781 1.0469,-0.17188 1.4219,-0.17187 2.0937,-0.40625 0,-0.23437 0=
,-0.29687 0,-0.71875 -0.3281,-1.01563 -0.4531,-0.39062 -1.3437,-0.39062 -0.=
8125,0 -1.2188,0.29687 -0.3906,0.28125 -0.5781,1.01563 l -1.1406,-0.15625 q=
 0.1562,-0.73438 0.5156,-1.1875 0.3594,-0.45313 1.0312,-0.6875 0.6719,-0.25=
 1.5625,-0.25 0.8907,0 1.4375,0.20312 0.5625,0.20313 0.8125,0.53125 0.2657,=
0.3125 0.375,0.79688 0.047,0.29687 0.047,1.07812 v 1.5625 q 0,1.625 0.078,2=
.0625 0.078,0.4375 0.2969,0.82813 h -1.2187 q -0.1875,-0.35938 -0.2344,-0.8=
5938 z m -0.094,-2.60937 q -0.6406,0.26562 -1.9219,0.4375 -0.7187,0.10937 -=
1.0156,0.25 -0.2969,0.125 -0.4688,0.375 -0.1562,0.25 -0.1562,0.54687 0,0.46=
875 0.3437,0.78125 0.3594,0.3125 1.0469,0.3125 0.6719,0 1.2031,-0.29687 0.5=
313,-0.29688 0.7813,-0.8125 0.1875,-0.39063 0.1875,-1.17188 z m 5.5531,2.42=
187 0.1719,1.03125 q -0.5,0.10938 -0.8907,0.10938 -0.6406,0 -1,-0.20313 -0.=
3437,-0.20312 -0.4843,-0.53125 -0.1407,-0.32812 -0.1407,-1.39062 v -3.96875=
 h -0.8593 v -0.90625 h 0.8593 v -1.71875 l 1.1719,-0.70313 v 2.42188 h 1.1=
719 v 0.90625 h -1.1719 v 4.04687 q 0,0.5 0.047,0.64063 0.062,0.14062 0.203=
1,0.23437 0.1407,0.0781 0.4063,0.0781 0.2031,0 0.5156,-0.0469 z m 1.1405,1.=
04688 v -9.54688 h 1.1719 v 3.42188 q 0.8281,-0.9375 2.0781,-0.9375 0.7656,=
0 1.3281,0.29687 0.5625,0.29688 0.8125,0.84375 0.25,0.53125 0.25,1.54688 v =
4.375 h -1.1719 v -4.375 q 0,-0.89063 -0.3906,-1.28125 -0.375,-0.40625 -1.0=
781,-0.40625 -0.5156,0 -0.9844,0.28125 -0.4531,0.26562 -0.6562,0.73437 -0.1=
875,0.45313 -0.1875,1.26563 v 3.78125 z m 15.631,-0.85938 q -0.6562,0.5625 =
-1.2656,0.79688 -0.5937,0.21875 -1.2812,0.21875 -1.1407,0 -1.75,-0.54688 -0=
.6094,-0.5625 -0.6094,-1.4375 0,-0.5 0.2187,-0.92187 0.2344,-0.42188 0.6094=
,-0.67188 0.375,-0.25 0.8438,-0.39062 0.3437,-0.0781 1.0468,-0.17188 1.4219=
,-0.17187 2.0938,-0.40625 0,-0.23437 0,-0.29687 0,-0.71875 -0.3281,-1.01563=
 -0.4532,-0.39062 -1.3438,-0.39062 -0.8125,0 -1.2187,0.29687 -0.3907,0.2812=
5 -0.5782,1.01563 l -1.1406,-0.15625 q 0.1563,-0.73438 0.5156,-1.1875 0.359=
4,-0.45313 1.0313,-0.6875 0.6719,-0.25 1.5625,-0.25 0.8906,0 1.4375,0.20312=
 0.5625,0.20313 0.8125,0.53125 0.2656,0.3125 0.375,0.79688 0.047,0.29687 0.=
047,1.07812 v 1.5625 q 0,1.625 0.078,2.0625 0.078,0.4375 0.2969,0.82813 h -=
1.2188 q -0.1875,-0.35938 -0.2344,-0.85938 z m -0.094,-2.60937 q -0.6406,0.=
26562 -1.9218,0.4375 -0.7188,0.10937 -1.0157,0.25 -0.2968,0.125 -0.4687,0.3=
75 -0.1563,0.25 -0.1563,0.54687 0,0.46875 0.3438,0.78125 0.3594,0.3125 1.04=
69,0.3125 0.6718,0 1.2031,-0.29687 0.5312,-0.29688 0.7812,-0.8125 0.1875,-0=
.39063 0.1875,-1.17188 z m 2.975,3.46875 v -6.90625 h 1.0625 v 1.04687 q 0.=
4063,-0.73437 0.7344,-0.96875 0.3437,-0.23437 0.7656,-0.23437 0.5938,0 1.20=
31,0.375 l -0.4062,1.07812 q -0.4375,-0.25 -0.8594,-0.25 -0.3906,0 -0.7031,=
0.23438 -0.2969,0.23437 -0.4219,0.64062 -0.2031,0.625 -0.2031,1.35938 v 3.6=
25 z m 9.1884,-2.21875 1.2031,0.14062 q -0.2812,1.0625 -1.0625,1.65625 -0.7=
656,0.57813 -1.9687,0.57813 -1.5156,0 -2.4063,-0.9375 -0.8906,-0.9375 -0.89=
06,-2.60938 0,-1.75 0.8906,-2.70312 0.9063,-0.96875 2.3438,-0.96875 1.3906,=
0 2.2656,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.1562 q 0=
.062,1.14062 0.6406,1.75 0.5781,0.59375 1.4375,0.59375 0.6562,0 1.1094,-0.3=
2813 0.4531,-0.34375 0.7187,-1.07812 z m -3.8437,-1.90625 h 3.8593 q -0.078=
,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.4531,-0.6875 -0.8125,0 -1.359=
4,0.54688 -0.5468,0.53125 -0.6093,1.4375 z m 11.0374,3.26562 q -0.6562,0.56=
25 -1.2656,0.79688 -0.5937,0.21875 -1.2812,0.21875 -1.1407,0 -1.75,-0.54688=
 -0.6094,-0.5625 -0.6094,-1.4375 0,-0.5 0.2187,-0.92187 0.2344,-0.42188 0.6=
094,-0.67188 0.375,-0.25 0.8438,-0.39062 0.3437,-0.0781 1.0468,-0.17188 1.4=
219,-0.17187 2.0938,-0.40625 0,-0.23437 0,-0.29687 0,-0.71875 -0.3281,-1.01=
563 -0.4532,-0.39062 -1.3438,-0.39062 -0.8125,0 -1.2187,0.29687 -0.3907,0.2=
8125 -0.5782,1.01563 l -1.1406,-0.15625 q 0.1563,-0.73438 0.5156,-1.1875 0.=
3594,-0.45313 1.0313,-0.6875 0.6719,-0.25 1.5625,-0.25 0.8906,0 1.4375,0.20=
312 0.5625,0.20313 0.8125,0.53125 0.2656,0.3125 0.375,0.79688 0.047,0.29687=
 0.047,1.07812 v 1.5625 q 0,1.625 0.078,2.0625 0.078,0.4375 0.2969,0.82813 =
h -1.2188 q -0.1875,-0.35938 -0.2344,-0.85938 z m -0.094,-2.60937 q -0.6406=
,0.26562 -1.9218,0.4375 -0.7188,0.10937 -1.0157,0.25 -0.2968,0.125 -0.4687,=
0.375 -0.1563,0.25 -0.1563,0.54687 0,0.46875 0.3438,0.78125 0.3594,0.3125 1=
.0469,0.3125 0.6718,0 1.2031,-0.29687 0.5312,-0.29688 0.7812,-0.8125 0.1875=
,-0.39063 0.1875,-1.17188 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path320" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 707.87269,240.60097 v -9.54689 h 1.2969 l 5.0156,7.50002 v=
 -7.50002 h 1.2031 v 9.54689 h -1.2969 l -5.0156,-7.5 v 7.5 z m 14.2189,-2.=
21875 1.2032,0.14063 q -0.2813,1.0625 -1.0625,1.65625 -0.7657,0.57812 -1.96=
88,0.57812 -1.5156,0 -2.4062,-0.9375 -0.8907,-0.9375 -0.8907,-2.60937 0,-1.=
75 0.8907,-2.70313 0.9062,-0.96875 2.3437,-0.96875 1.3906,0 2.2656,0.9375 0=
.875,0.9375 0.875,2.65625 0,0.10938 0,0.3125 h -5.1562 q 0.062,1.14063 0.64=
06,1.75 0.5781,0.59375 1.4375,0.59375 0.6563,0 1.1094,-0.32812 0.4531,-0.34=
375 0.7187,-1.07813 z m -3.8437,-1.90625 h 3.8594 q -0.078,-0.85937 -0.4375=
,-1.29687 -0.5625,-0.6875 -1.4532,-0.6875 -0.8125,0 -1.3593,0.54687 -0.5469=
,0.53125 -0.6094,1.4375 z m 5.7406,4.125 2.5312,-3.59375 -2.3437,-3.3125 h =
1.4687 l 1.0625,1.60938 q 0.2969,0.46875 0.4844,0.78125 0.2813,-0.4375 0.51=
56,-0.76563 l 1.1719,-1.625 h 1.4063 l -2.3907,3.25 2.5625,3.65625 h -1.437=
5 l -1.4218,-2.14062 -0.375,-0.59375 -1.8125,2.73437 z m 10.0078,-1.04687 0=
.1719,1.03125 q -0.5,0.10937 -0.8907,0.10937 -0.6406,0 -1,-0.20312 -0.3437,=
-0.20313 -0.4843,-0.53125 -0.1407,-0.32813 -0.1407,-1.39063 v -3.96875 h -0=
.8593 v -0.90625 h 0.8593 v -1.71875 l 1.1719,-0.70314 v 2.42189 h 1.1719 v=
 0.90625 h -1.1719 v 4.04688 q 0,0.5 0.047,0.64062 0.062,0.14063 0.2031,0.2=
3438 0.1407,0.0781 0.4063,0.0781 0.2031,0 0.5156,-0.0469 z m 4.8434,1.04687=
 v -6.90625 h 1.0625 v 0.98438 q 0.75,-1.14063 2.1875,-1.14063 0.625,0 1.15=
63,0.21875 0.5312,0.21875 0.7812,0.59375 0.2657,0.35938 0.375,0.85938 0.062=
,0.32812 0.062,1.14062 v 4.25 h -1.1718 v -4.20312 q 0,-0.71875 -0.1407,-1.=
0625 -0.1406,-0.35938 -0.4843,-0.5625 -0.3438,-0.21875 -0.8125,-0.21875 -0.=
75,0 -1.2969,0.46875 -0.5469,0.46875 -0.5469,1.79687 v 3.78125 z m 6.975,-3=
.45312 q 0,-1.92188 1.0781,-2.84375 0.8907,-0.76563 2.1719,-0.76563 1.4219,=
0 2.3281,0.9375 0.9063,0.92188 0.9063,2.57813 0,1.32812 -0.4063,2.09375 -0.=
3906,0.76562 -1.1562,1.1875 -0.7656,0.42187 -1.6719,0.42187 -1.4531,0 -2.35=
94,-0.92187 -0.8906,-0.9375 -0.8906,-2.6875 z m 1.2031,0 q 0,1.32812 0.5782=
,1.98437 0.5937,0.65625 1.4687,0.65625 0.875,0 1.4531,-0.65625 0.5782,-0.67=
187 0.5782,-2.03125 0,-1.28125 -0.5938,-1.9375 -0.5781,-0.65625 -1.4375,-0.=
65625 -0.875,0 -1.4687,0.65625 -0.5782,0.65625 -0.5782,1.98438 z m 11.1313,=
3.45312 v -0.875 q -0.6563,1.03125 -1.9375,1.03125 -0.8125,0 -1.5157,-0.453=
12 -0.6875,-0.45313 -1.0781,-1.26563 -0.375,-0.82812 -0.375,-1.89062 0,-1.0=
3125 0.3438,-1.875 0.3437,-0.84375 1.0312,-1.28125 0.7031,-0.45313 1.5469,-=
0.45313 0.625,0 1.1094,0.26563 0.5,0.25 0.7968,0.67187 v -3.42189 h 1.1719 =
v 9.54689 z m -3.7032,-3.45312 q 0,1.32812 0.5625,1.98437 0.5625,0.65625 1.=
3282,0.65625 0.7656,0 1.2968,-0.625 0.5313,-0.625 0.5313,-1.90625 0,-1.4218=
7 -0.5469,-2.07812 -0.5469,-0.67188 -1.3437,-0.67188 -0.7813,0 -1.3125,0.64=
063 -0.5157,0.625 -0.5157,2 z m 11.3656,1.23437 1.2032,0.14063 q -0.2813,1.=
0625 -1.0625,1.65625 -0.7657,0.57812 -1.9688,0.57812 -1.5156,0 -2.4062,-0.9=
375 -0.8907,-0.9375 -0.8907,-2.60937 0,-1.75 0.8907,-2.70313 0.9062,-0.9687=
5 2.3437,-0.96875 1.3906,0 2.2656,0.9375 0.875,0.9375 0.875,2.65625 0,0.109=
38 0,0.3125 h -5.1562 q 0.062,1.14063 0.6406,1.75 0.5781,0.59375 1.4375,0.5=
9375 0.6563,0 1.1094,-0.32812 0.4531,-0.34375 0.7187,-1.07813 z m -3.8437,-=
1.90625 h 3.8594 q -0.078,-0.85937 -0.4375,-1.29687 -0.5625,-0.6875 -1.4532=
,-0.6875 -0.8125,0 -1.3593,0.54687 -0.5469,0.53125 -0.6094,1.4375 z m 9.896=
7,-0.57812 q 0,-1.6875 0.3438,-2.71875 0.3593,-1.03125 1.0468,-1.59375 0.68=
75,-0.56252 1.7188,-0.56252 0.7812,0 1.3594,0.3125 0.5781,0.29689 0.9531,0.=
89064 0.375,0.57813 0.5937,1.42188 0.2188,0.82812 0.2188,2.25 0,1.67187 -0.=
3594,2.70312 -0.3437,1.03125 -1.0312,1.59375 -0.6719,0.5625 -1.7344,0.5625 =
-1.375,0 -2.1563,-0.98437 -0.9531,-1.1875 -0.9531,-3.875 z m 1.2031,0 q 0,2=
.34375 0.5469,3.125 0.5625,0.78125 1.3594,0.78125 0.8125,0 1.3594,-0.78125 =
0.5625,-0.78125 0.5625,-3.125 0,-2.35938 -0.5625,-3.125 -0.5469,-0.78125 -1=
.3594,-0.78125 -0.8125,0 -1.2969,0.6875 -0.6094,0.875 -0.6094,3.21875 z m 1=
0.2405,7.35937 v -9.5625 h 1.0781 v 0.89063 q 0.375,-0.53125 0.8438,-0.7812=
5 0.4844,-0.26563 1.1562,-0.26563 0.875,0 1.5469,0.45313 0.6875,0.45312 1.0=
313,1.28125 0.3437,0.82812 0.3437,1.82812 0,1.04688 -0.375,1.90625 -0.375,0=
.84375 -1.1094,1.29688 -0.7187,0.45312 -1.5312,0.45312 -0.5781,0 -1.0469,-0=
.25 -0.4687,-0.25 -0.7656,-0.625 v 3.375 z m 1.0625,-6.07812 q 0,1.34375 0.=
5313,1.98437 0.5468,0.625 1.3125,0.625 0.7812,0 1.3437,-0.65625 0.5625,-0.6=
5625 0.5625,-2.04687 0,-1.3125 -0.5469,-1.96875 -0.5468,-0.67188 -1.2968,-0=
.67188 -0.75,0 -1.3282,0.70313 -0.5781,0.70312 -0.5781,2.03125 z m 8.9125,2=
.375 0.1719,1.03125 q -0.5,0.10937 -0.8907,0.10937 -0.6406,0 -1,-0.20312 -0=
.3437,-0.20313 -0.4843,-0.53125 -0.1407,-0.32813 -0.1407,-1.39063 v -3.9687=
5 h -0.8593 v -0.90625 h 0.8593 v -1.71875 l 1.1719,-0.70314 v 2.42189 h 1.=
1719 v 0.90625 h -1.1719 v 4.04688 q 0,0.5 0.047,0.64062 0.062,0.14063 0.20=
32,0.23438 0.1406,0.0781 0.4062,0.0781 0.2031,0 0.5156,-0.0469 z m 1.1248,1=
.04687 v -6.90625 h 1.0625 v 1.04688 q 0.4063,-0.73438 0.7344,-0.96875 0.34=
37,-0.23438 0.7656,-0.23438 0.5938,0 1.2031,0.375 l -0.4062,1.07813 q -0.43=
75,-0.25 -0.8594,-0.25 -0.3906,0 -0.7031,0.23437 -0.2969,0.23438 -0.4219,0.=
64063 -0.2031,0.625 -0.2031,1.35937 v 3.625 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path322" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 707.87269,275.7978 v -9.54688 h 1.2969 l 5.0156,7.5 v -7.5=
 h 1.2031 v 9.54688 h -1.2969 l -5.0156,-7.5 v 7.5 z m 14.2189,-2.21875 1.2=
032,0.14062 q -0.2813,1.0625 -1.0625,1.65625 -0.7657,0.57813 -1.9688,0.5781=
3 -1.5156,0 -2.4062,-0.9375 -0.8907,-0.9375 -0.8907,-2.60938 0,-1.75 0.8907=
,-2.70312 0.9062,-0.96875 2.3437,-0.96875 1.3906,0 2.2656,0.9375 0.875,0.93=
75 0.875,2.65625 0,0.10937 0,0.3125 h -5.1562 q 0.062,1.14062 0.6406,1.75 0=
.5781,0.59375 1.4375,0.59375 0.6563,0 1.1094,-0.32813 0.4531,-0.34375 0.718=
7,-1.07812 z m -3.8437,-1.90625 h 3.8594 q -0.078,-0.85938 -0.4375,-1.29688=
 -0.5625,-0.6875 -1.4532,-0.6875 -0.8125,0 -1.3593,0.54688 -0.5469,0.53125 =
-0.6094,1.4375 z m 5.7406,4.125 2.5312,-3.59375 -2.3437,-3.3125 h 1.4687 l =
1.0625,1.60937 q 0.2969,0.46875 0.4844,0.78125 0.2813,-0.4375 0.5156,-0.765=
62 l 1.1719,-1.625 h 1.4063 l -2.3907,3.25 2.5625,3.65625 h -1.4375 l -1.42=
18,-2.14063 -0.375,-0.59375 -1.8125,2.73438 z m 10.0078,-1.04688 0.1719,1.0=
3125 q -0.5,0.10938 -0.8907,0.10938 -0.6406,0 -1,-0.20313 -0.3437,-0.20312 =
-0.4843,-0.53125 -0.1407,-0.32812 -0.1407,-1.39062 v -3.96875 h -0.8593 v -=
0.90625 h 0.8593 v -1.71875 l 1.1719,-0.70313 v 2.42188 h 1.1719 v 0.90625 =
h -1.1719 v 4.04687 q 0,0.5 0.047,0.64063 0.062,0.14062 0.2031,0.23437 0.14=
07,0.0781 0.4063,0.0781 0.2031,0 0.5156,-0.0469 z m 4.8434,1.04688 v -6.906=
25 h 1.0625 v 0.98437 q 0.75,-1.14062 2.1875,-1.14062 0.625,0 1.1563,0.2187=
5 0.5312,0.21875 0.7812,0.59375 0.2657,0.35937 0.375,0.85937 0.062,0.32813 =
0.062,1.14063 v 4.25 h -1.1718 v -4.20313 q 0,-0.71875 -0.1407,-1.0625 -0.1=
406,-0.35937 -0.4843,-0.5625 -0.3438,-0.21875 -0.8125,-0.21875 -0.75,0 -1.2=
969,0.46875 -0.5469,0.46875 -0.5469,1.79688 v 3.78125 z m 6.975,-3.45313 q =
0,-1.92187 1.0781,-2.84375 0.8907,-0.76562 2.1719,-0.76562 1.4219,0 2.3281,=
0.9375 0.9063,0.92187 0.9063,2.57812 0,1.32813 -0.4063,2.09375 -0.3906,0.76=
563 -1.1562,1.1875 -0.7656,0.42188 -1.6719,0.42188 -1.4531,0 -2.3594,-0.921=
88 -0.8906,-0.9375 -0.8906,-2.6875 z m 1.2031,0 q 0,1.32813 0.5782,1.98438 =
0.5937,0.65625 1.4687,0.65625 0.875,0 1.4531,-0.65625 0.5782,-0.67188 0.578=
2,-2.03125 0,-1.28125 -0.5938,-1.9375 -0.5781,-0.65625 -1.4375,-0.65625 -0.=
875,0 -1.4687,0.65625 -0.5782,0.65625 -0.5782,1.98437 z m 11.1313,3.45313 v=
 -0.875 q -0.6563,1.03125 -1.9375,1.03125 -0.8125,0 -1.5157,-0.45313 -0.687=
5,-0.45312 -1.0781,-1.26562 -0.375,-0.82813 -0.375,-1.89063 0,-1.03125 0.34=
38,-1.875 0.3437,-0.84375 1.0312,-1.28125 0.7031,-0.45312 1.5469,-0.45312 0=
.625,0 1.1094,0.26562 0.5,0.25 0.7968,0.67188 v -3.42188 h 1.1719 v 9.54688=
 z m -3.7032,-3.45313 q 0,1.32813 0.5625,1.98438 0.5625,0.65625 1.3282,0.65=
625 0.7656,0 1.2968,-0.625 0.5313,-0.625 0.5313,-1.90625 0,-1.42188 -0.5469=
,-2.07813 -0.5469,-0.67187 -1.3437,-0.67187 -0.7813,0 -1.3125,0.64062 -0.51=
57,0.625 -0.5157,2 z m 11.3656,1.23438 1.2032,0.14062 q -0.2813,1.0625 -1.0=
625,1.65625 -0.7657,0.57813 -1.9688,0.57813 -1.5156,0 -2.4062,-0.9375 -0.89=
07,-0.9375 -0.8907,-2.60938 0,-1.75 0.8907,-2.70312 0.9062,-0.96875 2.3437,=
-0.96875 1.3906,0 2.2656,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.31=
25 h -5.1562 q 0.062,1.14062 0.6406,1.75 0.5781,0.59375 1.4375,0.59375 0.65=
63,0 1.1094,-0.32813 0.4531,-0.34375 0.7187,-1.07812 z m -3.8437,-1.90625 h=
 3.8594 q -0.078,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.4532,-0.6875 =
-0.8125,0 -1.3593,0.54688 -0.5469,0.53125 -0.6094,1.4375 z m 14.3186,4.125 =
h -1.1719 v -7.46875 q -0.4219,0.40625 -1.1094,0.8125 -0.6875,0.40625 -1.23=
43,0.60937 v -1.14062 q 0.9843,-0.45313 1.7187,-1.10938 0.7344,-0.67187 1.0=
313,-1.28125 h 0.7656 z m 7.0217,2.65625 v -9.5625 h 1.0781 v 0.89062 q 0.3=
75,-0.53125 0.8438,-0.78125 0.4844,-0.26562 1.1562,-0.26562 0.875,0 1.5469,=
0.45312 0.6875,0.45313 1.0313,1.28125 0.3437,0.82813 0.3437,1.82813 0,1.046=
87 -0.375,1.90625 -0.375,0.84375 -1.1094,1.29687 -0.7187,0.45313 -1.5312,0.=
45313 -0.5781,0 -1.0469,-0.25 -0.4687,-0.25 -0.7656,-0.625 v 3.375 z m 1.06=
25,-6.07813 q 0,1.34375 0.5313,1.98438 0.5468,0.625 1.3125,0.625 0.7812,0 1=
.3437,-0.65625 0.5625,-0.65625 0.5625,-2.04688 0,-1.3125 -0.5469,-1.96875 -=
0.5468,-0.67187 -1.2968,-0.67187 -0.75,0 -1.3282,0.70312 -0.5781,0.70313 -0=
.5781,2.03125 z m 8.9125,2.375 0.1719,1.03125 q -0.5,0.10938 -0.8907,0.1093=
8 -0.6406,0 -1,-0.20313 -0.3437,-0.20312 -0.4843,-0.53125 -0.1407,-0.32812 =
-0.1407,-1.39062 v -3.96875 h -0.8593 v -0.90625 h 0.8593 v -1.71875 l 1.17=
19,-0.70313 v 2.42188 h 1.1719 v 0.90625 h -1.1719 v 4.04687 q 0,0.5 0.047,=
0.64063 0.062,0.14062 0.2032,0.23437 0.1406,0.0781 0.4062,0.0781 0.2031,0 0=
.5156,-0.0469 z m 1.1248,1.04688 v -6.90625 h 1.0625 v 1.04687 q 0.4063,-0.=
73437 0.7344,-0.96875 0.3437,-0.23437 0.7656,-0.23437 0.5938,0 1.2031,0.375=
 l -0.4062,1.07812 q -0.4375,-0.25 -0.8594,-0.25 -0.3906,0 -0.7031,0.23438 =
-0.2969,0.23437 -0.4219,0.64062 -0.2031,0.625 -0.2031,1.35938 v 3.625 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path324" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 707.87269,310.99465 v -9.54688 h 1.2969 l 5.0156,7.5 v -7.=
5 h 1.2031 v 9.54688 h -1.2969 l -5.0156,-7.5 v 7.5 z m 14.2189,-2.21875 1.=
2032,0.14062 q -0.2813,1.0625 -1.0625,1.65625 -0.7657,0.57813 -1.9688,0.578=
13 -1.5156,0 -2.4062,-0.9375 -0.8907,-0.9375 -0.8907,-2.60938 0,-1.75 0.890=
7,-2.70312 0.9062,-0.96875 2.3437,-0.96875 1.3906,0 2.2656,0.9375 0.875,0.9=
375 0.875,2.65625 0,0.10937 0,0.3125 h -5.1562 q 0.062,1.14062 0.6406,1.75 =
0.5781,0.59375 1.4375,0.59375 0.6563,0 1.1094,-0.32813 0.4531,-0.34375 0.71=
87,-1.07812 z m -3.8437,-1.90625 h 3.8594 q -0.078,-0.85938 -0.4375,-1.2968=
8 -0.5625,-0.6875 -1.4532,-0.6875 -0.8125,0 -1.3593,0.54688 -0.5469,0.53125=
 -0.6094,1.4375 z m 5.7406,4.125 2.5312,-3.59375 -2.3437,-3.3125 h 1.4687 l=
 1.0625,1.60937 q 0.2969,0.46875 0.4844,0.78125 0.2813,-0.4375 0.5156,-0.76=
562 l 1.1719,-1.625 h 1.4063 l -2.3907,3.25 2.5625,3.65625 h -1.4375 l -1.4=
218,-2.14063 -0.375,-0.59375 -1.8125,2.73438 z m 10.0078,-1.04688 0.1719,1.=
03125 q -0.5,0.10938 -0.8907,0.10938 -0.6406,0 -1,-0.20313 -0.3437,-0.20312=
 -0.4843,-0.53125 -0.1407,-0.32812 -0.1407,-1.39062 v -3.96875 h -0.8593 v =
-0.90625 h 0.8593 v -1.71875 l 1.1719,-0.70313 v 2.42188 h 1.1719 v 0.90625=
 h -1.1719 v 4.04687 q 0,0.5 0.047,0.64063 0.062,0.14062 0.2031,0.23437 0.1=
407,0.0781 0.4063,0.0781 0.2031,0 0.5156,-0.0469 z m 4.8434,1.04688 v -6.90=
625 h 1.0625 v 0.98437 q 0.75,-1.14062 2.1875,-1.14062 0.625,0 1.1563,0.218=
75 0.5312,0.21875 0.7812,0.59375 0.2657,0.35937 0.375,0.85937 0.062,0.32813=
 0.062,1.14063 v 4.25 h -1.1718 v -4.20313 q 0,-0.71875 -0.1407,-1.0625 -0.=
1406,-0.35937 -0.4843,-0.5625 -0.3438,-0.21875 -0.8125,-0.21875 -0.75,0 -1.=
2969,0.46875 -0.5469,0.46875 -0.5469,1.79688 v 3.78125 z m 6.975,-3.45313 q=
 0,-1.92187 1.0781,-2.84375 0.8907,-0.76562 2.1719,-0.76562 1.4219,0 2.3281=
,0.9375 0.9063,0.92187 0.9063,2.57812 0,1.32813 -0.4063,2.09375 -0.3906,0.7=
6563 -1.1562,1.1875 -0.7656,0.42188 -1.6719,0.42188 -1.4531,0 -2.3594,-0.92=
188 -0.8906,-0.9375 -0.8906,-2.6875 z m 1.2031,0 q 0,1.32813 0.5782,1.98438=
 0.5937,0.65625 1.4687,0.65625 0.875,0 1.4531,-0.65625 0.5782,-0.67188 0.57=
82,-2.03125 0,-1.28125 -0.5938,-1.9375 -0.5781,-0.65625 -1.4375,-0.65625 -0=
.875,0 -1.4687,0.65625 -0.5782,0.65625 -0.5782,1.98437 z m 11.1313,3.45313 =
v -0.875 q -0.6563,1.03125 -1.9375,1.03125 -0.8125,0 -1.5157,-0.45313 -0.68=
75,-0.45312 -1.0781,-1.26562 -0.375,-0.82813 -0.375,-1.89063 0,-1.03125 0.3=
438,-1.875 0.3437,-0.84375 1.0312,-1.28125 0.7031,-0.45312 1.5469,-0.45312 =
0.625,0 1.1094,0.26562 0.5,0.25 0.7968,0.67188 v -3.42188 h 1.1719 v 9.5468=
8 z m -3.7032,-3.45313 q 0,1.32813 0.5625,1.98438 0.5625,0.65625 1.3282,0.6=
5625 0.7656,0 1.2968,-0.625 0.5313,-0.625 0.5313,-1.90625 0,-1.42188 -0.546=
9,-2.07813 -0.5469,-0.67187 -1.3437,-0.67187 -0.7813,0 -1.3125,0.64062 -0.5=
157,0.625 -0.5157,2 z m 11.3656,1.23438 1.2032,0.14062 q -0.2813,1.0625 -1.=
0625,1.65625 -0.7657,0.57813 -1.9688,0.57813 -1.5156,0 -2.4062,-0.9375 -0.8=
907,-0.9375 -0.8907,-2.60938 0,-1.75 0.8907,-2.70312 0.9062,-0.96875 2.3437=
,-0.96875 1.3906,0 2.2656,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3=
125 h -5.1562 q 0.062,1.14062 0.6406,1.75 0.5781,0.59375 1.4375,0.59375 0.6=
563,0 1.1094,-0.32813 0.4531,-0.34375 0.7187,-1.07812 z m -3.8437,-1.90625 =
h 3.8594 q -0.078,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.4532,-0.6875=
 -0.8125,0 -1.3593,0.54688 -0.5469,0.53125 -0.6094,1.4375 z m 16.053,3 v 1.=
125 h -6.2969 q -0.016,-0.42188 0.1406,-0.8125 0.2344,-0.64063 0.7656,-1.26=
563 0.5313,-0.625 1.5313,-1.45312 1.5625,-1.26563 2.1094,-2.01563 0.5468,-0=
.75 0.5468,-1.40625 0,-0.70312 -0.5,-1.17187 -0.5,-0.48438 -1.2968,-0.48438=
 -0.8594,0 -1.375,0.51563 -0.5,0.5 -0.5,1.39062 l -1.2032,-0.10937 q 0.125,=
-1.35938 0.9219,-2.0625 0.8125,-0.70313 2.1719,-0.70313 1.375,0 2.1719,0.76=
563 0.8125,0.75 0.8125,1.875 0,0.57812 -0.2344,1.14062 -0.2344,0.54688 -0.7=
813,1.15625 -0.5468,0.60938 -1.8125,1.67188 -1.0468,0.89062 -1.3593,1.21875=
 -0.2969,0.3125 -0.4844,0.625 z m 5.2873,3.78125 v -9.5625 h 1.0781 v 0.890=
62 q 0.375,-0.53125 0.8438,-0.78125 0.4844,-0.26562 1.1562,-0.26562 0.875,0=
 1.5469,0.45312 0.6875,0.45313 1.0313,1.28125 0.3437,0.82813 0.3437,1.82813=
 0,1.04687 -0.375,1.90625 -0.375,0.84375 -1.1094,1.29687 -0.7187,0.45313 -1=
.5312,0.45313 -0.5781,0 -1.0469,-0.25 -0.4687,-0.25 -0.7656,-0.625 v 3.375 =
z m 1.0625,-6.07813 q 0,1.34375 0.5313,1.98438 0.5468,0.625 1.3125,0.625 0.=
7812,0 1.3437,-0.65625 0.5625,-0.65625 0.5625,-2.04688 0,-1.3125 -0.5469,-1=
.96875 -0.5468,-0.67187 -1.2968,-0.67187 -0.75,0 -1.3282,0.70312 -0.5781,0.=
70313 -0.5781,2.03125 z m 8.9125,2.375 0.1719,1.03125 q -0.5,0.10938 -0.890=
7,0.10938 -0.6406,0 -1,-0.20313 -0.3437,-0.20312 -0.4843,-0.53125 -0.1407,-=
0.32812 -0.1407,-1.39062 v -3.96875 h -0.8593 v -0.90625 h 0.8593 v -1.7187=
5 l 1.1719,-0.70313 v 2.42188 h 1.1719 v 0.90625 h -1.1719 v 4.04687 q 0,0.=
5 0.047,0.64063 0.062,0.14062 0.2032,0.23437 0.1406,0.0781 0.4062,0.0781 0.=
2031,0 0.5156,-0.0469 z m 1.1248,1.04688 v -6.90625 h 1.0625 v 1.04687 q 0.=
4063,-0.73437 0.7344,-0.96875 0.3437,-0.23437 0.7656,-0.23437 0.5938,0 1.20=
31,0.375 l -0.4062,1.07812 q -0.4375,-0.25 -0.8594,-0.25 -0.3906,0 -0.7031,=
0.23438 -0.2969,0.23437 -0.4219,0.64062 -0.2031,0.625 -0.2031,1.35938 v 3.6=
25 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path326" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 706.76639,346.19152 v -9.54687 h 1.2968 l 5.0157,7.5 v -7.=
5 h 1.2031 v 9.54687 h -1.2969 l -5.0156,-7.5 v 7.5 z m 14.2188,-2.21875 1.=
2032,0.14063 q -0.2813,1.0625 -1.0625,1.65625 -0.7657,0.57812 -1.9688,0.578=
12 -1.5156,0 -2.4062,-0.9375 -0.8907,-0.9375 -0.8907,-2.60937 0,-1.75 0.890=
7,-2.70313 0.9062,-0.96875 2.3437,-0.96875 1.3906,0 2.2656,0.9375 0.875,0.9=
375 0.875,2.65625 0,0.10938 0,0.3125 h -5.1562 q 0.062,1.14063 0.6406,1.75 =
0.5781,0.59375 1.4375,0.59375 0.6563,0 1.1094,-0.32812 0.4531,-0.34375 0.71=
87,-1.07813 z m -3.8437,-1.90625 h 3.8594 q -0.078,-0.85937 -0.4375,-1.2968=
7 -0.5625,-0.6875 -1.4532,-0.6875 -0.8125,0 -1.3593,0.54687 -0.5469,0.53125=
 -0.6094,1.4375 z m 5.7406,4.125 2.5312,-3.59375 -2.3437,-3.3125 h 1.4687 l=
 1.0625,1.60938 q 0.2969,0.46875 0.4844,0.78125 0.2812,-0.4375 0.5156,-0.76=
563 l 1.1719,-1.625 h 1.4062 l -2.3906,3.25 2.5625,3.65625 h -1.4375 l -1.4=
219,-2.14062 -0.375,-0.59375 -1.8125,2.73437 z m 10.0078,-1.04687 0.1719,1.=
03125 q -0.5,0.10937 -0.8907,0.10937 -0.6406,0 -1,-0.20312 -0.3437,-0.20313=
 -0.4843,-0.53125 -0.1407,-0.32813 -0.1407,-1.39063 v -3.96875 h -0.8593 v =
-0.90625 h 0.8593 v -1.71875 l 1.1719,-0.70312 v 2.42187 h 1.1719 v 0.90625=
 h -1.1719 v 4.04688 q 0,0.5 0.047,0.64062 0.062,0.14063 0.2031,0.23438 0.1=
407,0.0781 0.4063,0.0781 0.2031,0 0.5156,-0.0469 z m 4.8435,1.04687 v -6.90=
625 h 1.0625 v 0.98438 q 0.75,-1.14063 2.1875,-1.14063 0.625,0 1.1562,0.218=
75 0.5313,0.21875 0.7813,0.59375 0.2656,0.35938 0.375,0.85938 0.062,0.32812=
 0.062,1.14062 v 4.25 h -1.1719 v -4.20312 q 0,-0.71875 -0.1406,-1.0625 -0.=
1406,-0.35938 -0.4844,-0.5625 -0.3437,-0.21875 -0.8125,-0.21875 -0.75,0 -1.=
2969,0.46875 -0.5468,0.46875 -0.5468,1.79687 v 3.78125 z m 6.975,-3.45312 q=
 0,-1.92188 1.0781,-2.84375 0.8906,-0.76563 2.1719,-0.76563 1.4218,0 2.3281=
,0.9375 0.9062,0.92188 0.9062,2.57813 0,1.32812 -0.4062,2.09375 -0.3906,0.7=
6562 -1.1563,1.1875 -0.7656,0.42187 -1.6718,0.42187 -1.4532,0 -2.3594,-0.92=
187 -0.8906,-0.9375 -0.8906,-2.6875 z m 1.2031,0 q 0,1.32812 0.5781,1.98437=
 0.5938,0.65625 1.4688,0.65625 0.875,0 1.4531,-0.65625 0.5781,-0.67187 0.57=
81,-2.03125 0,-1.28125 -0.5937,-1.9375 -0.5782,-0.65625 -1.4375,-0.65625 -0=
.875,0 -1.4688,0.65625 -0.5781,0.65625 -0.5781,1.98438 z m 11.1312,3.45312 =
v -0.875 q -0.6562,1.03125 -1.9375,1.03125 -0.8125,0 -1.5156,-0.45312 -0.68=
75,-0.45313 -1.0781,-1.26563 -0.375,-0.82812 -0.375,-1.89062 0,-1.03125 0.3=
437,-1.875 0.3438,-0.84375 1.0313,-1.28125 0.7031,-0.45313 1.5468,-0.45313 =
0.625,0 1.1094,0.26563 0.5,0.25 0.7969,0.67187 v -3.42187 h 1.1719 v 9.5468=
7 z m -3.7031,-3.45312 q 0,1.32812 0.5625,1.98437 0.5625,0.65625 1.3281,0.6=
5625 0.7656,0 1.2969,-0.625 0.5312,-0.625 0.5312,-1.90625 0,-1.42187 -0.546=
8,-2.07812 -0.5469,-0.67188 -1.3438,-0.67188 -0.7812,0 -1.3125,0.64063 -0.5=
156,0.625 -0.5156,2 z m 11.3656,1.23437 1.2031,0.14063 q -0.2812,1.0625 -1.=
0625,1.65625 -0.7656,0.57812 -1.9687,0.57812 -1.5157,0 -2.4063,-0.9375 -0.8=
906,-0.9375 -0.8906,-2.60937 0,-1.75 0.8906,-2.70313 0.9063,-0.96875 2.3438=
,-0.96875 1.3906,0 2.2656,0.9375 0.875,0.9375 0.875,2.65625 0,0.10938 0,0.3=
125 h -5.1563 q 0.062,1.14063 0.6407,1.75 0.5781,0.59375 1.4375,0.59375 0.6=
562,0 1.1093,-0.32812 0.4532,-0.34375 0.7188,-1.07813 z m -3.8438,-1.90625 =
h 3.8594 q -0.078,-0.85937 -0.4375,-1.29687 -0.5625,-0.6875 -1.4531,-0.6875=
 -0.8125,0 -1.3594,0.54687 -0.5469,0.53125 -0.6094,1.4375 z m 10.3655,4.125=
 v -9.54687 h 1.2969 l 5.0156,7.5 v -7.5 h 1.2031 v 9.54687 h -1.2968 l -5.=
0157,-7.5 v 7.5 z m 13.1875,2.65625 v -9.5625 h 1.0781 v 0.89063 q 0.375,-0=
.53125 0.8438,-0.78125 0.4844,-0.26563 1.1562,-0.26563 0.875,0 1.5469,0.453=
13 0.6875,0.45312 1.0313,1.28125 0.3437,0.82812 0.3437,1.82812 0,1.04688 -0=
.375,1.90625 -0.375,0.84375 -1.1094,1.29688 -0.7187,0.45312 -1.5312,0.45312=
 -0.5781,0 -1.0469,-0.25 -0.4687,-0.25 -0.7656,-0.625 v 3.375 z m 1.0625,-6=
.07812 q 0,1.34375 0.5313,1.98437 0.5468,0.625 1.3125,0.625 0.7812,0 1.3437=
,-0.65625 0.5625,-0.65625 0.5625,-2.04687 0,-1.3125 -0.5469,-1.96875 -0.546=
8,-0.67188 -1.2968,-0.67188 -0.75,0 -1.3282,0.70313 -0.5781,0.70312 -0.5781=
,2.03125 z m 8.9125,2.375 0.1719,1.03125 q -0.5,0.10937 -0.8906,0.10937 -0.=
6407,0 -1,-0.20312 -0.3438,-0.20313 -0.4844,-0.53125 -0.1406,-0.32813 -0.14=
06,-1.39063 v -3.96875 h -0.8594 v -0.90625 h 0.8594 v -1.71875 l 1.1718,-0=
.70312 v 2.42187 h 1.1719 v 0.90625 h -1.1719 v 4.04688 q 0,0.5 0.047,0.640=
62 0.062,0.14063 0.2031,0.23438 0.1407,0.0781 0.4063,0.0781 0.2031,0 0.5156=
,-0.0469 z m 1.1249,1.04687 v -6.90625 h 1.0625 v 1.04688 q 0.4062,-0.73438=
 0.7343,-0.96875 0.3438,-0.23438 0.7657,-0.23438 0.5937,0 1.2031,0.375 l -0=
.4063,1.07813 q -0.4375,-0.25 -0.8593,-0.25 -0.3907,0 -0.7032,0.23437 -0.29=
68,0.23438 -0.4218,0.64063 -0.2032,0.625 -0.2032,1.35937 v 3.625 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path328" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       fill-opacity=3D"0"=0D
> -       d=3D"m 637.25669,45.783637 h 230.3306 v 27.46457 h -230.3306 z"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path330" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 661.78699,67.583637 v -6.90625 h 1.0625 v 1.04687 q 0.4063=
,-0.73437 0.7344,-0.96875 0.3438,-0.23437 0.7656,-0.23437 0.5938,0 1.2032,0=
.375 l -0.4063,1.07812 q -0.4375,-0.25 -0.8594,-0.25 -0.3906,0 -0.7031,0.23=
438 -0.2969,0.23437 -0.4219,0.64062 -0.2031,0.625 -0.2031,1.35938 v 3.625 z=
 m 7.0166,-1.04688 0.1719,1.03125 q -0.5,0.10938 -0.8907,0.10938 -0.6406,0 =
-1,-0.20313 -0.3437,-0.20312 -0.4843,-0.53125 -0.1407,-0.32812 -0.1407,-1.3=
9062 v -3.96875 h -0.8593 v -0.90625 h 0.8593 v -1.71875 l 1.1719,-0.70313 =
v 2.42188 h 1.1719 v 0.90625 h -1.1719 v 4.04687 q 0,0.5 0.047,0.64063 0.06=
2,0.14062 0.2031,0.23437 0.1407,0.0781 0.4063,0.0781 0.2031,0 0.5156,-0.046=
9 z m 5.8748,-1.17187 1.2031,0.14062 q -0.2812,1.0625 -1.0625,1.65625 -0.76=
56,0.57813 -1.9687,0.57813 -1.5156,0 -2.4063,-0.9375 -0.8906,-0.9375 -0.890=
6,-2.60938 0,-1.75 0.8906,-2.70312 0.9063,-0.96875 2.3438,-0.96875 1.3906,0=
 2.2656,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.1562 q 0.=
062,1.14062 0.6406,1.75 0.5781,0.59375 1.4375,0.59375 0.6562,0 1.1094,-0.32=
813 0.4531,-0.34375 0.7187,-1.07812 z m -3.8437,-1.90625 h 3.8593 q -0.078,=
-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.4531,-0.6875 -0.8125,0 -1.3594=
,0.54688 -0.5468,0.53125 -0.6093,1.4375 z m 5.4437,6.78125 v -0.85938 h 7.7=
656 v 0.85938 z m 8.4906,-2.65625 v -6.90625 h 1.0625 v 0.98437 q 0.75,-1.1=
4062 2.1875,-1.14062 0.625,0 1.1562,0.21875 0.5313,0.21875 0.7813,0.59375 0=
.2656,0.35937 0.375,0.85937 0.062,0.32813 0.062,1.14063 v 4.25 h -1.1719 v =
-4.20313 q 0,-0.71875 -0.1406,-1.0625 -0.1407,-0.35937 -0.4844,-0.5625 -0.3=
438,-0.21875 -0.8125,-0.21875 -0.75,0 -1.2969,0.46875 -0.5469,0.46875 -0.54=
69,1.79688 v 3.78125 z m 6.975,-3.45313 q 0,-1.92187 1.0781,-2.84375 0.8906=
,-0.76562 2.1719,-0.76562 1.4218,0 2.3281,0.9375 0.9062,0.92187 0.9062,2.57=
812 0,1.32813 -0.4062,2.09375 -0.3906,0.76563 -1.1563,1.1875 -0.7656,0.4218=
8 -1.6718,0.42188 -1.4532,0 -2.3594,-0.92188 -0.8906,-0.9375 -0.8906,-2.687=
5 z m 1.2031,0 q 0,1.32813 0.5781,1.98438 0.5938,0.65625 1.4688,0.65625 0.8=
75,0 1.4531,-0.65625 0.5781,-0.67188 0.5781,-2.03125 0,-1.28125 -0.5937,-1.=
9375 -0.5782,-0.65625 -1.4375,-0.65625 -0.875,0 -1.4688,0.65625 -0.5781,0.6=
5625 -0.5781,1.98437 z m 11.1312,3.45313 v -0.875 q -0.6563,1.03125 -1.9375=
,1.03125 -0.8125,0 -1.5156,-0.45313 -0.6875,-0.45312 -1.0782,-1.26562 -0.37=
5,-0.82813 -0.375,-1.89063 0,-1.03125 0.3438,-1.875 0.3437,-0.84375 1.0312,=
-1.28125 0.7032,-0.45312 1.5469,-0.45312 0.625,0 1.1094,0.26562 0.5,0.25 0.=
7969,0.67188 v -3.42188 h 1.1718 v 9.54688 z m -3.7031,-3.45313 q 0,1.32813=
 0.5625,1.98438 0.5625,0.65625 1.3281,0.65625 0.7656,0 1.2969,-0.625 0.5312=
,-0.625 0.5312,-1.90625 0,-1.42188 -0.5469,-2.07813 -0.5468,-0.67187 -1.343=
7,-0.67187 -0.7813,0 -1.3125,0.64062 -0.5156,0.625 -0.5156,2 z m 11.3656,1.=
23438 1.2031,0.14062 q -0.2813,1.0625 -1.0625,1.65625 -0.7656,0.57813 -1.96=
88,0.57813 -1.5156,0 -2.4062,-0.9375 -0.8906,-0.9375 -0.8906,-2.60938 0,-1.=
75 0.8906,-2.70312 0.9062,-0.96875 2.3437,-0.96875 1.3907,0 2.2657,0.9375 0=
.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.1563 q 0.062,1.14062 0.64=
06,1.75 0.5782,0.59375 1.4375,0.59375 0.6563,0 1.1094,-0.32813 0.4531,-0.34=
375 0.7188,-1.07812 z m -3.8438,-1.90625 h 3.8594 q -0.078,-0.85938 -0.4375=
,-1.29688 -0.5625,-0.6875 -1.4531,-0.6875 -0.8125,0 -1.3594,0.54688 -0.5469=
,0.53125 -0.6094,1.4375 z m 9.7874,0.67187 q 0,-1.92187 1.0781,-2.84375 0.8=
906,-0.76562 2.1719,-0.76562 1.4219,0 2.3281,0.9375 0.9063,0.92187 0.9063,2=
.57812 0,1.32813 -0.4063,2.09375 -0.3906,0.76563 -1.1562,1.1875 -0.7657,0.4=
2188 -1.6719,0.42188 -1.4531,0 -2.3594,-0.92188 -0.8906,-0.9375 -0.8906,-2.=
6875 z m 1.2031,0 q 0,1.32813 0.5781,1.98438 0.5938,0.65625 1.4688,0.65625 =
0.875,0 1.4531,-0.65625 0.5781,-0.67188 0.5781,-2.03125 0,-1.28125 -0.5937,=
-1.9375 -0.5781,-0.65625 -1.4375,-0.65625 -0.875,0 -1.4688,0.65625 -0.5781,=
0.65625 -0.5781,1.98437 z m 7.725,3.45313 h -1.0781 v -9.54688 h 1.1718 v 3=
.40625 q 0.7344,-0.92187 1.8907,-0.92187 0.6406,0 1.2031,0.26562 0.5781,0.2=
5 0.9375,0.71875 0.375,0.45313 0.5781,1.10938 0.2031,0.65625 0.2031,1.40625=
 0,1.78125 -0.875,2.75 -0.875,0.96875 -2.1093,0.96875 -1.2188,0 -1.9219,-1.=
01563 z m 0,-3.5 q 0,1.23437 0.3281,1.78125 0.5625,0.90625 1.5,0.90625 0.76=
56,0 1.3281,-0.65625 0.5625,-0.67188 0.5625,-2 0,-1.34375 -0.5468,-1.98438 =
-0.5313,-0.65625 -1.2969,-0.65625 -0.7656,0 -1.3281,0.67188 -0.5469,0.67187=
 -0.5469,1.9375 z m 6.3343,-4.6875 v -1.35938 h 1.1719 v 1.35938 z m -1.484=
3,10.875 0.2187,-1 q 0.3594,0.0937 0.5469,0.0937 0.3594,0 0.5312,-0.25 0.18=
75,-0.23438 0.1875,-1.1875 v -7.25 h 1.1719 v 7.28125 q 0,1.28125 -0.3281,1=
.78125 -0.4375,0.65625 -1.4063,0.65625 -0.4843,0 -0.9218,-0.125 z m 9.1798,=
-4.90625 1.2031,0.14062 q -0.2812,1.0625 -1.0625,1.65625 -0.7656,0.57813 -1=
.9687,0.57813 -1.5156,0 -2.4063,-0.9375 -0.8906,-0.9375 -0.8906,-2.60938 0,=
-1.75 0.8906,-2.70312 0.9063,-0.96875 2.3438,-0.96875 1.3906,0 2.2656,0.937=
5 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.1562 q 0.062,1.14062 0=
.6406,1.75 0.5781,0.59375 1.4375,0.59375 0.6562,0 1.1094,-0.32813 0.4531,-0=
.34375 0.7187,-1.07812 z m -3.8437,-1.90625 h 3.8593 q -0.078,-0.85938 -0.4=
375,-1.29688 -0.5625,-0.6875 -1.4531,-0.6875 -0.8125,0 -1.3594,0.54688 -0.5=
468,0.53125 -0.6093,1.4375 z m 11.0374,1.59375 1.1563,0.15625 q -0.1875,1.1=
875 -0.9688,1.85937 -0.7812,0.67188 -1.9218,0.67188 -1.4063,0 -2.2813,-0.92=
188 -0.8594,-0.9375 -0.8594,-2.65625 0,-1.125 0.375,-1.96875 0.375,-0.84375=
 1.125,-1.25 0.7657,-0.42187 1.6563,-0.42187 1.125,0 1.8437,0.57812 0.7188,=
0.5625 0.9219,1.60938 l -1.1406,0.17187 q -0.1719,-0.70312 -0.5938,-1.04687=
 -0.4062,-0.35938 -0.9843,-0.35938 -0.8907,0 -1.4532,0.64063 -0.5468,0.6406=
2 -0.5468,2 0,1.40625 0.5312,2.03125 0.5469,0.625 1.4063,0.625 0.6875,0 1.1=
406,-0.42188 0.4687,-0.42187 0.5937,-1.29687 z m 4.711,1.48437 0.1719,1.031=
25 q -0.5,0.10938 -0.8907,0.10938 -0.6406,0 -1,-0.20313 -0.3437,-0.20312 -0=
.4843,-0.53125 -0.1407,-0.32812 -0.1407,-1.39062 v -3.96875 h -0.8593 v -0.=
90625 h 0.8593 v -1.71875 l 1.1719,-0.70313 v 2.42188 h 1.1719 v 0.90625 h =
-1.1719 v 4.04687 q 0,0.5 0.047,0.64063 0.062,0.14062 0.2031,0.23437 0.1407=
,0.0781 0.4063,0.0781 0.2031,0 0.5156,-0.0469 z m 4.8434,1.04688 v -6.90625=
 h 1.0469 v 0.96875 q 0.3281,-0.51563 0.8594,-0.8125 0.5469,-0.3125 1.2344,=
-0.3125 0.7812,0 1.2656,0.3125 0.4844,0.3125 0.6875,0.89062 0.8281,-1.20312=
 2.1406,-1.20312 1.0313,0 1.5781,0.57812 0.5625,0.5625 0.5625,1.73438 v 4.7=
5 h -1.1718 v -4.35938 q 0,-0.70312 -0.125,-1 -0.1094,-0.3125 -0.4063,-0.5 =
-0.2969,-0.1875 -0.7031,-0.1875 -0.7188,0 -1.2031,0.48438 -0.4844,0.48437 -=
0.4844,1.54687 v 4.01563 h -1.1719 v -4.48438 q 0,-0.78125 -0.2969,-1.17187=
 -0.2812,-0.39063 -0.9218,-0.39063 -0.5,0 -0.9219,0.26563 -0.4219,0.25 -0.6=
094,0.75 -0.1875,0.5 -0.1875,1.45312 v 3.57813 z m 15.8369,-2.21875 1.2031,=
0.14062 q -0.2812,1.0625 -1.0625,1.65625 -0.7656,0.57813 -1.9687,0.57813 -1=
.5157,0 -2.4063,-0.9375 -0.8906,-0.9375 -0.8906,-2.60938 0,-1.75 0.8906,-2.=
70312 0.9063,-0.96875 2.3438,-0.96875 1.3906,0 2.2656,0.9375 0.875,0.9375 0=
.875,2.65625 0,0.10937 0,0.3125 h -5.1563 q 0.062,1.14062 0.6407,1.75 0.578=
1,0.59375 1.4375,0.59375 0.6562,0 1.1093,-0.32813 0.4532,-0.34375 0.7188,-1=
.07812 z m -3.8438,-1.90625 h 3.8594 q -0.078,-0.85938 -0.4375,-1.29688 -0.=
5625,-0.6875 -1.4531,-0.6875 -0.8125,0 -1.3594,0.54688 -0.5469,0.53125 -0.6=
094,1.4375 z m 6.5219,4.125 v -6.90625 h 1.0469 v 0.96875 q 0.3281,-0.51563=
 0.8593,-0.8125 0.5469,-0.3125 1.2344,-0.3125 0.7813,0 1.2656,0.3125 0.4844=
,0.3125 0.6875,0.89062 0.8282,-1.20312 2.1407,-1.20312 1.0312,0 1.5781,0.57=
812 0.5625,0.5625 0.5625,1.73438 v 4.75 h -1.1719 v -4.35938 q 0,-0.70312 -=
0.125,-1 -0.1094,-0.3125 -0.4062,-0.5 -0.2969,-0.1875 -0.7032,-0.1875 -0.71=
87,0 -1.2031,0.48438 -0.4844,0.48437 -0.4844,1.54687 v 4.01563 h -1.1718 v =
-4.48438 q 0,-0.78125 -0.2969,-1.17187 -0.2813,-0.39063 -0.9219,-0.39063 -0=
.5,0 -0.9219,0.26563 -0.4218,0.25 -0.6093,0.75 -0.1875,0.5 -0.1875,1.45312 =
v 3.57813 z m 10.6649,-3.45313 q 0,-1.92187 1.0781,-2.84375 0.8907,-0.76562=
 2.1719,-0.76562 1.4219,0 2.3281,0.9375 0.9063,0.92187 0.9063,2.57812 0,1.3=
2813 -0.4063,2.09375 -0.3906,0.76563 -1.1562,1.1875 -0.7656,0.42188 -1.6719=
,0.42188 -1.4531,0 -2.3594,-0.92188 -0.8906,-0.9375 -0.8906,-2.6875 z m 1.2=
031,0 q 0,1.32813 0.5782,1.98438 0.5937,0.65625 1.4687,0.65625 0.875,0 1.45=
31,-0.65625 0.5782,-0.67188 0.5782,-2.03125 0,-1.28125 -0.5938,-1.9375 -0.5=
781,-0.65625 -1.4375,-0.65625 -0.875,0 -1.4687,0.65625 -0.5782,0.65625 -0.5=
782,1.98437 z m 6.6313,3.45313 v -6.90625 h 1.0625 v 1.04687 q 0.4062,-0.73=
437 0.7343,-0.96875 0.3438,-0.23437 0.7657,-0.23437 0.5937,0 1.2031,0.375 l=
 -0.4063,1.07812 q -0.4375,-0.25 -0.8593,-0.25 -0.3907,0 -0.7032,0.23438 -0=
.2968,0.23437 -0.4218,0.64062 -0.2032,0.625 -0.2032,1.35938 v 3.625 z m 4.4=
071,2.65625 -0.125,-1.09375 q 0.375,0.10937 0.6562,0.10937 0.3906,0 0.625,-=
0.14062 0.2344,-0.125 0.3906,-0.35938 0.1094,-0.17187 0.3594,-0.875 0.031,-=
0.0937 0.1094,-0.28125 l -2.625,-6.92187 h 1.2656 l 1.4375,4 q 0.2813,0.765=
62 0.5,1.59375 0.2031,-0.79688 0.4688,-1.57813 l 1.4843,-4.01562 h 1.1719 l=
 -2.625,7.01562 q -0.4219,1.14063 -0.6562,1.57813 -0.3125,0.57812 -0.7188,0=
.84375 -0.4062,0.28125 -0.9687,0.28125 -0.3282,0 -0.75,-0.15625 z m 10.3983=
,-2.65625 v -9.54688 h 1.1718 v 9.54688 z m 7.4923,-0.85938 q -0.6563,0.562=
5 -1.2656,0.79688 -0.5938,0.21875 -1.2813,0.21875 -1.1406,0 -1.75,-0.54688 =
-0.6094,-0.5625 -0.6094,-1.4375 0,-0.5 0.2188,-0.92187 0.2344,-0.42188 0.60=
94,-0.67188 0.375,-0.25 0.8437,-0.39062 0.3438,-0.0781 1.0469,-0.17188 1.42=
19,-0.17187 2.0937,-0.40625 0,-0.23437 0,-0.29687 0,-0.71875 -0.3281,-1.015=
63 -0.4531,-0.39062 -1.3437,-0.39062 -0.8125,0 -1.2188,0.29687 -0.3906,0.28=
125 -0.5781,1.01563 l -1.1406,-0.15625 q 0.1562,-0.73438 0.5156,-1.1875 0.3=
594,-0.45313 1.0312,-0.6875 0.6719,-0.25 1.5625,-0.25 0.8907,0 1.4375,0.203=
12 0.5625,0.20313 0.8125,0.53125 0.2657,0.3125 0.375,0.79688 0.047,0.29687 =
0.047,1.07812 v 1.5625 q 0,1.625 0.078,2.0625 0.078,0.4375 0.2969,0.82813 h=
 -1.2187 q -0.1875,-0.35938 -0.2344,-0.85938 z m -0.094,-2.60937 q -0.6406,=
0.26562 -1.9219,0.4375 -0.7187,0.10937 -1.0156,0.25 -0.2969,0.125 -0.4688,0=
.375 -0.1562,0.25 -0.1562,0.54687 0,0.46875 0.3437,0.78125 0.3594,0.3125 1.=
0469,0.3125 0.6719,0 1.2031,-0.29687 0.5313,-0.29688 0.7813,-0.8125 0.1875,=
-0.39063 0.1875,-1.17188 z m 2.9437,6.125 -0.125,-1.09375 q 0.375,0.10937 0=
.6563,0.10937 0.3906,0 0.625,-0.14062 0.2343,-0.125 0.3906,-0.35938 0.1094,=
-0.17187 0.3594,-0.875 0.031,-0.0937 0.1093,-0.28125 l -2.625,-6.92187 h 1.=
2657 l 1.4375,4 q 0.2812,0.76562 0.5,1.59375 0.2031,-0.79688 0.4687,-1.5781=
3 l 1.4844,-4.01562 h 1.1719 l -2.625,7.01562 q -0.4219,1.14063 -0.6563,1.5=
7813 -0.3125,0.57812 -0.7187,0.84375 -0.4063,0.28125 -0.9688,0.28125 -0.328=
1,0 -0.75,-0.15625 z m 6.2735,-6.10938 q 0,-1.92187 1.0781,-2.84375 0.8906,=
-0.76562 2.1719,-0.76562 1.4218,0 2.3281,0.9375 0.9062,0.92187 0.9062,2.578=
12 0,1.32813 -0.4062,2.09375 -0.3906,0.76563 -1.1563,1.1875 -0.7656,0.42188=
 -1.6718,0.42188 -1.4532,0 -2.3594,-0.92188 -0.8906,-0.9375 -0.8906,-2.6875=
 z m 1.2031,0 q 0,1.32813 0.5781,1.98438 0.5938,0.65625 1.4688,0.65625 0.87=
5,0 1.4531,-0.65625 0.5781,-0.67188 0.5781,-2.03125 0,-1.28125 -0.5937,-1.9=
375 -0.5782,-0.65625 -1.4375,-0.65625 -0.875,0 -1.4688,0.65625 -0.5781,0.65=
625 -0.5781,1.98437 z m 11.1781,3.45313 v -1.01563 q -0.8125,1.17188 -2.187=
5,1.17188 -0.6094,0 -1.1406,-0.23438 -0.5313,-0.23437 -0.7969,-0.57812 -0.2=
5,-0.35938 -0.3594,-0.875 -0.062,-0.34375 -0.062,-1.09375 v -4.28125 h 1.17=
19 v 3.82812 q 0,0.92188 0.062,1.23438 0.1094,0.46875 0.4687,0.73437 0.3594=
,0.25 0.8907,0.25 0.5156,0 0.9843,-0.26562 0.4688,-0.26563 0.6563,-0.73438 =
0.1875,-0.46875 0.1875,-1.34375 v -3.70312 h 1.1719 v 6.90625 z m 5.4437,-1=
.04688 0.1719,1.03125 q -0.5,0.10938 -0.8906,0.10938 -0.6407,0 -1,-0.20313 =
-0.3438,-0.20312 -0.4844,-0.53125 -0.1406,-0.32812 -0.1406,-1.39062 v -3.96=
875 h -0.8594 v -0.90625 h 0.8594 v -1.71875 l 1.1718,-0.70313 v 2.42188 h =
1.1719 v 0.90625 h -1.1719 v 4.04687 q 0,0.5 0.047,0.64063 0.062,0.14062 0.=
2032,0.23437 0.1406,0.0781 0.4062,0.0781 0.2031,0 0.5156,-0.0469 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path332"=0D
> -       style=3D"fill:#008033" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       fill-opacity=3D"0"=0D
> -       d=3D"m 816.20809,219.40832 c 7.1841,0 13.0079,2.83072 13.0079,6.3=
226 v 53.98471 c 0,3.49188 5.8238,6.3226 13.0078,6.3226 v 0 c -7.184,0 -13.=
0078,2.83072 -13.0078,6.3226 v 53.98471 0 c 0,3.49189 -5.8238,6.32261 -13.0=
079,6.32261 z"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path334" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       fill-opacity=3D"0"=0D
> -       d=3D"m 816.20809,219.40832 c 7.1841,0 13.0079,2.83072 13.0079,6.3=
226 v 53.98471 c 0,3.49188 5.8238,6.3226 13.0078,6.3226 v 0 c -7.184,0 -13.=
0078,2.83072 -13.0078,6.3226 v 53.98471 0 c 0,3.49189 -5.8238,6.32261 -13.0=
079,6.32261"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path336" />=0D
> -    <path=0D
> -       stroke=3D"#595959"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linejoin=3D"round"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"m 816.20809,219.40832 c 7.1841,0 13.0079,2.83072 13.0079,6.3=
226 v 53.98471 c 0,3.49188 5.8238,6.3226 13.0078,6.3226 v 0 c -7.184,0 -13.=
0078,2.83072 -13.0078,6.3226 v 53.98471 0 c 0,3.49189 -5.8238,6.32261 -13.0=
079,6.32261"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path338"=0D
> -       style=3D"fill:none" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       fill-opacity=3D"0"=0D
> -       d=3D"m 823.16869,253.99886 h 99.4015 v 27.46457 h -99.4015 z"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path340" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 832.96559,274.51885 v -6.21875 h 0.9375 v 0.875 q 0.6875,-=
1.01563 1.9844,-1.01563 0.5625,0 1.0312,0.20313 0.4844,0.20312 0.7188,0.531=
25 0.2343,0.32812 0.3281,0.76562 0.047,0.29688 0.047,1.03125 v 3.82813 h -1=
.0469 v -3.78125 q 0,-0.65625 -0.125,-0.96875 -0.125,-0.3125 -0.4375,-0.5 -=
0.3125,-0.20313 -0.7344,-0.20313 -0.6718,0 -1.1718,0.4375 -0.4844,0.42188 -=
0.4844,1.60938 v 3.40625 z m 7.6426,0 h -0.9844 v -8.59375 h 1.0625 v 3.062=
5 q 0.6719,-0.82813 1.7031,-0.82813 0.5781,0 1.0781,0.23438 0.5157,0.21875 =
0.8438,0.64062 0.3437,0.42188 0.5312,1.01563 0.1875,0.59375 0.1875,1.26562 =
0,1.59375 -0.7968,2.46875 -0.7969,0.875 -1.8907,0.875 -1.1093,0 -1.7343,-0.=
92187 z m -0.016,-3.15625 q 0,1.10937 0.3125,1.60937 0.5,0.8125 1.3437,0.81=
25 0.6875,0 1.1875,-0.59375 0.5157,-0.59375 0.5157,-1.79687 0,-1.21875 -0.4=
844,-1.79688 -0.4844,-0.57812 -1.1719,-0.57812 -0.6875,0 -1.2031,0.60937 -0=
.5,0.59375 -0.5,1.73438 z m 4.7363,5.54687 v -0.76562 h 7 v 0.76562 z m 11.=
9082,-4.39062 1.0938,0.125 q -0.25,0.95312 -0.9532,1.48437 -0.7031,0.53125 =
-1.7812,0.53125 -1.3594,0 -2.1719,-0.84375 -0.7969,-0.84375 -0.7969,-2.3593=
7 0,-1.5625 0.8125,-2.42188 0.8125,-0.875 2.0938,-0.875 1.25,0 2.0312,0.843=
75 0.7969,0.84375 0.7969,2.39063 0,0.0937 0,0.28125 h -4.6406 q 0.062,1.031=
25 0.5781,1.57812 0.5156,0.53125 1.2969,0.53125 0.5781,0 0.9844,-0.29687 0.=
4218,-0.3125 0.6562,-0.96875 z m -3.4531,-1.70313 h 3.4687 q -0.062,-0.7968=
7 -0.3906,-1.1875 -0.5156,-0.60937 -1.3125,-0.60937 -0.7344,0 -1.2344,0.484=
37 -0.4843,0.48438 -0.5312,1.3125 z m 9.9082,3.70313 v -0.78125 q -0.5938,0=
.92187 -1.7344,0.92187 -0.75,0 -1.375,-0.40625 -0.625,-0.42187 -0.9687,-1.1=
5625 -0.3438,-0.73437 -0.3438,-1.6875 0,-0.92187 0.3125,-1.6875 0.3125,-0.7=
6562 0.9375,-1.15625 0.625,-0.40625 1.3906,-0.40625 0.5625,0 1,0.23438 0.43=
75,0.23437 0.7188,0.60937 v -3.07812 h 1.0469 v 8.59375 z m -3.3281,-3.1093=
8 q 0,1.20313 0.5,1.79688 0.5,0.57812 1.1875,0.57812 0.6875,0 1.1718,-0.562=
5 0.4844,-0.5625 0.4844,-1.71875 0,-1.28125 -0.5,-1.875 -0.4844,-0.59375 -1=
.2031,-0.59375 -0.7031,0 -1.1719,0.57813 -0.4687,0.5625 -0.4687,1.79687 z m=
 5.7675,3.625 1.0313,0.15625 q 0.062,0.46875 0.3594,0.6875 0.3906,0.29688 1=
.0625,0.29688 0.7343,0 1.125,-0.29688 0.4062,-0.29687 0.5468,-0.8125 0.094,=
-0.32812 0.078,-1.35937 -0.6875,0.8125 -1.7187,0.8125 -1.2813,0 -1.9844,-0.=
92188 -0.7031,-0.9375 -0.7031,-2.21875 0,-0.89062 0.3125,-1.64062 0.3281,-0=
.76563 0.9375,-1.17188 0.6093,-0.40625 1.4375,-0.40625 1.1093,0 1.8281,0.89=
063 v -0.75 h 0.9687 v 5.375 q 0,1.45312 -0.2968,2.0625 -0.2969,0.60937 -0.=
9375,0.95312 -0.6407,0.35938 -1.5782,0.35938 -1.1093,0 -1.7968,-0.5 -0.6875=
,-0.5 -0.6719,-1.51563 z m 0.875,-3.73437 q 0,1.21875 0.4844,1.78125 0.4844=
,0.5625 1.2188,0.5625 0.7343,0 1.2187,-0.5625 0.5,-0.5625 0.5,-1.75 0,-1.14=
063 -0.5156,-1.71875 -0.5,-0.57813 -1.2188,-0.57813 -0.7031,0 -1.2031,0.578=
13 -0.4844,0.5625 -0.4844,1.6875 z m 10.252,1.21875 1.0937,0.125 q -0.25,0.=
95312 -0.9531,1.48437 -0.7031,0.53125 -1.7812,0.53125 -1.3594,0 -2.1719,-0.=
84375 -0.7969,-0.84375 -0.7969,-2.35937 0,-1.5625 0.8125,-2.42188 0.8125,-0=
.875 2.0938,-0.875 1.25,0 2.0312,0.84375 0.7969,0.84375 0.7969,2.39063 0,0.=
0937 0,0.28125 h -4.6406 q 0.062,1.03125 0.5781,1.57812 0.5156,0.53125 1.29=
69,0.53125 0.5781,0 0.9843,-0.29687 0.4219,-0.3125 0.6563,-0.96875 z m -3.4=
531,-1.70313 h 3.4687 q -0.062,-0.79687 -0.3906,-1.1875 -0.5156,-0.60937 -1=
.3125,-0.60937 -0.7344,0 -1.2344,0.48437 -0.4844,0.48438 -0.5312,1.3125 z m=
 5.455,1.84375 1.0313,-0.15625 q 0.094,0.625 0.4844,0.95313 0.4062,0.32812 =
1.1406,0.32812 0.7187,0 1.0625,-0.28125 0.3594,-0.29687 0.3594,-0.70312 0,-=
0.35938 -0.3125,-0.5625 -0.2188,-0.14063 -1.0782,-0.35938 -1.1562,-0.29687 =
-1.6093,-0.5 -0.4375,-0.21875 -0.6719,-0.59375 -0.2344,-0.375 -0.2344,-0.84=
375 0,-0.40625 0.1875,-0.76562 0.1875,-0.35938 0.5156,-0.59375 0.25,-0.1718=
8 0.6719,-0.29688 0.4219,-0.125 0.9219,-0.125 0.7187,0 1.2656,0.21875 0.562=
5,0.20313 0.8281,0.5625 0.2657,0.35938 0.3594,0.95313 l -1.0312,0.14062 q -=
0.062,-0.46875 -0.4063,-0.73437 -0.3281,-0.28125 -0.9531,-0.28125 -0.7188,0=
 -1.0313,0.25 -0.3125,0.23437 -0.3125,0.5625 0,0.20312 0.125,0.35937 0.1407=
,0.17188 0.4063,0.28125 0.1562,0.0625 0.9375,0.26563 1.125,0.3125 1.5625,0.=
5 0.4375,0.1875 0.6875,0.54687 0.25,0.35938 0.25,0.90625 0,0.53125 -0.3125,=
1 -0.2969,0.45313 -0.875,0.71875 -0.5781,0.25 -1.3125,0.25 -1.2188,0 -1.859=
4,-0.5 -0.625,-0.51562 -0.7969,-1.5 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path342" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 360.61488,75.514867 V 322.89017"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path344" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 521.53879,75.514867 V 322.89017"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path346" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 360.11618,76.013557 H 522.03739"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path348" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 360.11618,111.21041 H 522.03739"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path350" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 360.11618,146.40726 H 522.03739"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path352" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 360.11618,181.60412 H 522.03739"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path354" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 360.11618,216.80095 H 522.03739"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path356" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 360.11618,251.99782 H 522.03739"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path358" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 360.11618,287.19466 H 522.03739"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path360" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 360.11618,322.3915 H 522.03739"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path362" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 381.0367,94.751057 1.20312,-0.10938 q 0.0781,0.71875 0.390=
63,1.1875 0.3125,0.45313 0.95312,0.73438 0.65625,0.28125 1.46875,0.28125 0.=
71875,0 1.26563,-0.21875 0.5625,-0.21875 0.82812,-0.57813 0.26563,-0.375 0.=
26563,-0.82812 0,-0.45313 -0.26563,-0.78125 -0.25,-0.32813 -0.84375,-0.5625=
 -0.39062,-0.15625 -1.70312,-0.46875 -1.3125,-0.3125 -1.84375,-0.59375 -0.6=
7188,-0.35938 -1.01563,-0.89063 -0.32812,-0.53125 -0.32812,-1.1875 0,-0.718=
75 0.40625,-1.34375 0.40625,-0.625 1.1875,-0.95312 0.79687,-0.32813 1.76562=
,-0.32813 1.04688,0 1.85938,0.34375 0.8125,0.34375 1.25,1.01563 0.4375,0.65=
625 0.46875,1.48437 l -1.20313,0.0937 q -0.10937,-0.90625 -0.67187,-1.35937=
 -0.5625,-0.46875 -1.65625,-0.46875 -1.14063,0 -1.67188,0.42187 -0.51562,0.=
42188 -0.51562,1.01563 0,0.51562 0.35937,0.84375 0.375,0.32812 1.90625,0.68=
75 1.54688,0.34375 2.10938,0.59375 0.84375,0.39062 1.23437,0.98437 0.39063,=
0.57813 0.39063,1.35938 0,0.75 -0.4375,1.4375 -0.42188,0.67187 -1.25,1.0468=
7 -0.8125,0.35938 -1.82813,0.35938 -1.29687,0 -2.17187,-0.375 -0.875,-0.375=
 -1.375,-1.125 -0.5,-0.76563 -0.53125,-1.71875 z m 8.73352,-0.39063 q 0,-1.=
92187 1.07813,-2.84375 0.89062,-0.76562 2.17187,-0.76562 1.42188,0 2.32813,=
0.9375 0.90625,0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.39063,=
0.76563 -1.15625,1.1875 -0.76563,0.42188 -1.67188,0.42188 -1.45312,0 -2.359=
37,-0.92188 -0.89063,-0.9375 -0.89063,-2.6875 z m 1.20313,0 q 0,1.32813 0.5=
7812,1.98438 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45313,-0.65625 0.578=
12,-0.67188 0.57812,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57812,-0.65625 =
-1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57812,0.65625 -0.57812,1.9843=
7 z m 11.1781,3.45313 v -1.01563 q -0.8125,1.17188 -2.1875,1.17188 -0.60938=
,0 -1.14063,-0.23438 -0.53125,-0.23437 -0.79687,-0.57812 -0.25,-0.35938 -0.=
35938,-0.875 -0.0625,-0.34375 -0.0625,-1.09375 v -4.28125 h 1.17188 v 3.828=
12 q 0,0.92188 0.0625,1.23438 0.10937,0.46875 0.46875,0.73437 0.35937,0.25 =
0.89062,0.25 0.51563,0 0.98438,-0.26562 0.46875,-0.26563 0.65625,-0.73438 0=
.1875,-0.46875 0.1875,-1.34375 v -3.70312 h 1.17187 v 6.90625 z m 2.8656,0 =
v -6.90625 h 1.0625 v 1.04687 q 0.40625,-0.73437 0.73437,-0.96875 0.34375,-=
0.23437 0.76563,-0.23437 0.59375,0 1.20312,0.375 l -0.40625,1.07812 q -0.43=
75,-0.25 -0.85937,-0.25 -0.39063,0 -0.70313,0.23438 -0.29687,0.23437 -0.421=
87,0.64062 -0.20313,0.625 -0.20313,1.35938 v 3.625 z m 8.9696,-2.53125 1.15=
625,0.15625 q -0.1875,1.1875 -0.96875,1.85937 -0.78125,0.67188 -1.92187,0.6=
7188 -1.40625,0 -2.28125,-0.92188 -0.85938,-0.9375 -0.85938,-2.65625 0,-1.1=
25 0.375,-1.96875 0.375,-0.84375 1.125,-1.25 0.76563,-0.42187 1.65625,-0.42=
187 1.125,0 1.84375,0.57812 0.71875,0.5625 0.92188,1.60938 l -1.14063,0.171=
87 q -0.17187,-0.70312 -0.59375,-1.04687 -0.40625,-0.35938 -0.98437,-0.3593=
8 -0.89063,0 -1.45313,0.64063 -0.54687,0.64062 -0.54687,2 0,1.40625 0.53125=
,2.03125 0.54687,0.625 1.40625,0.625 0.6875,0 1.14062,-0.42188 0.46875,-0.4=
2187 0.59375,-1.29687 z m 6.88281,0.3125 1.20313,0.14062 q -0.28125,1.0625 =
-1.0625,1.65625 -0.76563,0.57813 -1.96875,0.57813 -1.51563,0 -2.40625,-0.93=
75 -0.89063,-0.9375 -0.89063,-2.60938 0,-1.75 0.89063,-2.70312 0.90625,-0.9=
6875 2.34375,-0.96875 1.39062,0 2.26562,0.9375 0.875,0.9375 0.875,2.65625 0=
,0.10937 0,0.3125 h -5.15625 q 0.0625,1.14062 0.64063,1.75 0.57812,0.59375 =
1.4375,0.59375 0.65625,0 1.10937,-0.32813 0.45313,-0.34375 0.71875,-1.07812=
 z m -3.84375,-1.90625 h 3.85938 q -0.0781,-0.85938 -0.4375,-1.29688 -0.562=
5,-0.6875 -1.45313,-0.6875 -0.8125,0 -1.35937,0.54688 -0.54688,0.53125 -0.6=
0938,1.4375 z m 10.36548,4.125 v -9.54688 h 1.29688 l 5.01562,7.5 v -7.5 h =
1.20313 v 9.54688 h -1.29688 l -5.01562,-7.5 v 7.5 z m 9.04703,-3.45313 q 0=
,-1.92187 1.07813,-2.84375 0.89062,-0.76562 2.17187,-0.76562 1.42188,0 2.32=
813,0.9375 0.90625,0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.39=
063,0.76563 -1.15625,1.1875 -0.76563,0.42188 -1.67188,0.42188 -1.45312,0 -2=
.35937,-0.92188 -0.89063,-0.9375 -0.89063,-2.6875 z m 1.20313,0 q 0,1.32813=
 0.57812,1.98438 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45313,-0.65625 0=
.57812,-0.67188 0.57812,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57812,-0.65=
625 -1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57812,0.65625 -0.57812,1.=
98437 z m 11.13122,3.45313 v -0.875 q -0.65625,1.03125 -1.9375,1.03125 -0.8=
125,0 -1.51562,-0.45313 -0.6875,-0.45312 -1.07813,-1.26562 -0.375,-0.82813 =
-0.375,-1.89063 0,-1.03125 0.34375,-1.875 0.34375,-0.84375 1.03125,-1.28125=
 0.70313,-0.45312 1.54688,-0.45312 0.625,0 1.10937,0.26562 0.5,0.25 0.79688=
,0.67188 v -3.42188 h 1.17187 v 9.54688 z m -3.70312,-3.45313 q 0,1.32813 0=
.5625,1.98438 0.5625,0.65625 1.32812,0.65625 0.76563,0 1.29688,-0.625 0.531=
25,-0.625 0.53125,-1.90625 0,-1.42188 -0.54688,-2.07813 -0.54687,-0.67187 -=
1.34375,-0.67187 -0.78125,0 -1.3125,0.64062 -0.51562,0.625 -0.51562,2 z m 1=
1.3656,1.23438 1.20312,0.14062 q -0.28125,1.0625 -1.0625,1.65625 -0.76562,0=
.57813 -1.96875,0.57813 -1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375 -0.890=
62,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.39=
063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.156=
25 q 0.0625,1.14062 0.64062,1.75 0.57813,0.59375 1.4375,0.59375 0.65625,0 1=
.10938,-0.32813 0.45312,-0.34375 0.71875,-1.07812 z m -3.84375,-1.90625 h 3=
.85937 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.45312,-0.6875=
 -0.8125,0 -1.35938,0.54688 -0.54687,0.53125 -0.60937,1.4375 z m 6.19372,-0=
.57813 q 0,-1.6875 0.34375,-2.71875 0.35938,-1.03125 1.04688,-1.59375 0.687=
5,-0.5625 1.71875,-0.5625 0.78125,0 1.35937,0.3125 0.57813,0.29688 0.95313,=
0.89063 0.375,0.57812 0.59375,1.42187 0.21875,0.82813 0.21875,2.25 0,1.6718=
8 -0.35938,2.70313 -0.34375,1.03125 -1.03125,1.59375 -0.67187,0.5625 -1.734=
37,0.5625 -1.375,0 -2.15625,-0.98438 -0.95313,-1.1875 -0.95313,-3.875 z m 1=
.20313,0 q 0,2.34375 0.54687,3.125 0.5625,0.78125 1.35938,0.78125 0.8125,0 =
1.35937,-0.78125 0.5625,-0.78125 0.5625,-3.125 0,-2.35937 -0.5625,-3.125 -0=
.54687,-0.78125 -1.35937,-0.78125 -0.8125,0 -1.29688,0.6875 -0.60937,0.875 =
-0.60937,3.21875 z m 9.80295,1.25 q 0,-1.92187 1.07812,-2.84375 0.89063,-0.=
76562 2.17188,-0.76562 1.42187,0 2.32812,0.9375 0.90625,0.92187 0.90625,2.5=
7812 0,1.32813 -0.40625,2.09375 -0.39062,0.76563 -1.15625,1.1875 -0.76562,0=
.42188 -1.67187,0.42188 -1.45313,0 -2.35938,-0.92188 -0.89062,-0.9375 -0.89=
062,-2.6875 z m 1.20312,0 q 0,1.32813 0.57813,1.98438 0.59375,0.65625 1.468=
75,0.65625 0.875,0 1.45312,-0.65625 0.57813,-0.67188 0.57813,-2.03125 0,-1.=
28125 -0.59375,-1.9375 -0.57813,-0.65625 -1.4375,-0.65625 -0.875,0 -1.46875=
,0.65625 -0.57813,0.65625 -0.57813,1.98437 z m 6.9281,3.45313 v -6 h -1.031=
25 v -0.90625 h 1.03125 v -0.73438 q 0,-0.70312 0.125,-1.04687 0.17188,-0.4=
5313 0.59375,-0.73438 0.42188,-0.28125 1.20313,-0.28125 0.48437,0 1.09375,0=
.10938 l -0.1875,1.03125 q -0.35938,-0.0625 -0.6875,-0.0625 -0.53125,0 -0.7=
5,0.23437 -0.21875,0.21875 -0.21875,0.84375 v 0.64063 h 1.34375 v 0.90625 h=
 -1.34375 v 6 z m 3.4621,0 v -6 h -1.03125 v -0.90625 h 1.03125 v -0.73438 =
q 0,-0.70312 0.125,-1.04687 0.17187,-0.45313 0.59375,-0.73438 0.42187,-0.28=
125 1.20312,-0.28125 0.48438,0 1.09375,0.10938 l -0.1875,1.03125 q -0.35937=
,-0.0625 -0.6875,-0.0625 -0.53125,0 -0.75,0.23437 -0.21875,0.21875 -0.21875=
,0.84375 v 0.64063 h 1.34375 v 0.90625 h -1.34375 v 6 z m 2.953,-2.0625 1.1=
5625,-0.1875 q 0.10938,0.70312 0.54688,1.07812 0.45312,0.35938 1.25,0.35938=
 0.8125,0 1.20312,-0.32813 0.39063,-0.32812 0.39063,-0.76562 0,-0.39063 -0.=
35938,-0.625 -0.23437,-0.15625 -1.1875,-0.39063 -1.29687,-0.32812 -1.79687,=
-0.5625 -0.48438,-0.25 -0.75,-0.65625 -0.25,-0.42187 -0.25,-0.9375 0,-0.453=
12 0.20312,-0.84375 0.21875,-0.40625 0.57813,-0.67187 0.28125,-0.1875 0.75,=
-0.32813 0.46875,-0.14062 1.01562,-0.14062 0.8125,0 1.42188,0.23437 0.60937=
,0.23438 0.90625,0.64063 0.29687,0.39062 0.40625,1.0625 l -1.14063,0.15625 =
q -0.0781,-0.53125 -0.45312,-0.82813 -0.375,-0.3125 -1.0625,-0.3125 -0.8125=
,0 -1.15625,0.26563 -0.34375,0.26562 -0.34375,0.625 0,0.23437 0.14062,0.421=
87 0.15625,0.1875 0.45313,0.3125 0.17187,0.0625 1.03125,0.29688 1.25,0.3281=
2 1.73437,0.54687 0.5,0.20313 0.78125,0.60938 0.28125,0.40625 0.28125,1 0,0=
.59375 -0.34375,1.10937 -0.34375,0.51563 -1,0.79688 -0.64062,0.28125 -1.453=
12,0.28125 -1.34375,0 -2.04688,-0.5625 -0.70312,-0.5625 -0.90625,-1.65625 z=
 m 11.86719,-0.15625 1.20312,0.14062 q -0.28125,1.0625 -1.0625,1.65625 -0.7=
6562,0.57813 -1.96875,0.57813 -1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375 =
-0.89062,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-0.96875 2.34375,-0.9687=
5 1.39063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h =
-5.15625 q 0.0625,1.14062 0.64062,1.75 0.57813,0.59375 1.4375,0.59375 0.656=
25,0 1.10938,-0.32813 0.45312,-0.34375 0.71875,-1.07812 z m -3.84375,-1.906=
25 h 3.85937 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.45312,-=
0.6875 -0.8125,0 -1.35938,0.54688 -0.54687,0.53125 -0.60937,1.4375 z m 9.08=
435,3.07812 0.17188,1.03125 q -0.5,0.10938 -0.89063,0.10938 -0.64062,0 -1,-=
0.20313 -0.34375,-0.20312 -0.48437,-0.53125 -0.14063,-0.32812 -0.14063,-1.3=
9062 v -3.96875 h -0.85937 v -0.90625 h 0.85937 v -1.71875 l 1.17188,-0.703=
13 v 2.42188 h 1.17187 v 0.90625 h -1.17187 v 4.04687 q 0,0.5 0.0469,0.6406=
3 0.0625,0.14062 0.20313,0.23437 0.14062,0.0781 0.40625,0.0781 0.20312,0 0.=
51562,-0.0469 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path364" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 381.0367,129.94791 1.20312,-0.10938 q 0.0781,0.71875 0.390=
63,1.1875 0.3125,0.45313 0.95312,0.73438 0.65625,0.28125 1.46875,0.28125 0.=
71875,0 1.26563,-0.21875 0.5625,-0.21875 0.82812,-0.57813 0.26563,-0.375 0.=
26563,-0.82812 0,-0.45313 -0.26563,-0.78125 -0.25,-0.32813 -0.84375,-0.5625=
 -0.39062,-0.15625 -1.70312,-0.46875 -1.3125,-0.3125 -1.84375,-0.59375 -0.6=
7188,-0.35938 -1.01563,-0.89063 -0.32812,-0.53125 -0.32812,-1.1875 0,-0.718=
75 0.40625,-1.34375 0.40625,-0.625 1.1875,-0.95312 0.79687,-0.32813 1.76562=
,-0.32813 1.04688,0 1.85938,0.34375 0.8125,0.34375 1.25,1.01563 0.4375,0.65=
625 0.46875,1.48437 l -1.20313,0.0937 q -0.10937,-0.90625 -0.67187,-1.35937=
 -0.5625,-0.46875 -1.65625,-0.46875 -1.14063,0 -1.67188,0.42187 -0.51562,0.=
42188 -0.51562,1.01563 0,0.51562 0.35937,0.84375 0.375,0.32812 1.90625,0.68=
75 1.54688,0.34375 2.10938,0.59375 0.84375,0.39062 1.23437,0.98437 0.39063,=
0.57813 0.39063,1.35938 0,0.75 -0.4375,1.4375 -0.42188,0.67187 -1.25,1.0468=
7 -0.8125,0.35938 -1.82813,0.35938 -1.29687,0 -2.17187,-0.375 -0.875,-0.375=
 -1.375,-1.125 -0.5,-0.76563 -0.53125,-1.71875 z m 8.73352,-0.39063 q 0,-1.=
92187 1.07813,-2.84375 0.89062,-0.76562 2.17187,-0.76562 1.42188,0 2.32813,=
0.9375 0.90625,0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.39063,=
0.76563 -1.15625,1.1875 -0.76563,0.42188 -1.67188,0.42188 -1.45312,0 -2.359=
37,-0.92188 -0.89063,-0.9375 -0.89063,-2.6875 z m 1.20313,0 q 0,1.32813 0.5=
7812,1.98438 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45313,-0.65625 0.578=
12,-0.67188 0.57812,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57812,-0.65625 =
-1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57812,0.65625 -0.57812,1.9843=
7 z m 11.1781,3.45313 v -1.01563 q -0.8125,1.17188 -2.1875,1.17188 -0.60938=
,0 -1.14063,-0.23438 -0.53125,-0.23437 -0.79687,-0.57812 -0.25,-0.35938 -0.=
35938,-0.875 -0.0625,-0.34375 -0.0625,-1.09375 v -4.28125 h 1.17188 v 3.828=
12 q 0,0.92188 0.0625,1.23438 0.10937,0.46875 0.46875,0.73437 0.35937,0.25 =
0.89062,0.25 0.51563,0 0.98438,-0.26562 0.46875,-0.26563 0.65625,-0.73438 0=
.1875,-0.46875 0.1875,-1.34375 v -3.70312 h 1.17187 v 6.90625 z m 2.8656,0 =
v -6.90625 h 1.0625 v 1.04687 q 0.40625,-0.73437 0.73437,-0.96875 0.34375,-=
0.23437 0.76563,-0.23437 0.59375,0 1.20312,0.375 l -0.40625,1.07812 q -0.43=
75,-0.25 -0.85937,-0.25 -0.39063,0 -0.70313,0.23438 -0.29687,0.23437 -0.421=
87,0.64062 -0.20313,0.625 -0.20313,1.35938 v 3.625 z m 8.9696,-2.53125 1.15=
625,0.15625 q -0.1875,1.1875 -0.96875,1.85937 -0.78125,0.67188 -1.92187,0.6=
7188 -1.40625,0 -2.28125,-0.92188 -0.85938,-0.9375 -0.85938,-2.65625 0,-1.1=
25 0.375,-1.96875 0.375,-0.84375 1.125,-1.25 0.76563,-0.42187 1.65625,-0.42=
187 1.125,0 1.84375,0.57812 0.71875,0.5625 0.92188,1.60938 l -1.14063,0.171=
87 q -0.17187,-0.70312 -0.59375,-1.04687 -0.40625,-0.35938 -0.98437,-0.3593=
8 -0.89063,0 -1.45313,0.64063 -0.54687,0.64062 -0.54687,2 0,1.40625 0.53125=
,2.03125 0.54687,0.625 1.40625,0.625 0.6875,0 1.14062,-0.42188 0.46875,-0.4=
2187 0.59375,-1.29687 z m 6.88281,0.3125 1.20313,0.14062 q -0.28125,1.0625 =
-1.0625,1.65625 -0.76563,0.57813 -1.96875,0.57813 -1.51563,0 -2.40625,-0.93=
75 -0.89063,-0.9375 -0.89063,-2.60938 0,-1.75 0.89063,-2.70312 0.90625,-0.9=
6875 2.34375,-0.96875 1.39062,0 2.26562,0.9375 0.875,0.9375 0.875,2.65625 0=
,0.10937 0,0.3125 h -5.15625 q 0.0625,1.14062 0.64063,1.75 0.57812,0.59375 =
1.4375,0.59375 0.65625,0 1.10937,-0.32813 0.45313,-0.34375 0.71875,-1.07812=
 z m -3.84375,-1.90625 h 3.85938 q -0.0781,-0.85938 -0.4375,-1.29688 -0.562=
5,-0.6875 -1.45313,-0.6875 -0.8125,0 -1.35937,0.54688 -0.54688,0.53125 -0.6=
0938,1.4375 z m 10.36548,4.125 v -9.54688 h 1.29688 l 5.01562,7.5 v -7.5 h =
1.20313 v 9.54688 h -1.29688 l -5.01562,-7.5 v 7.5 z m 9.04703,-3.45313 q 0=
,-1.92187 1.07813,-2.84375 0.89062,-0.76562 2.17187,-0.76562 1.42188,0 2.32=
813,0.9375 0.90625,0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.39=
063,0.76563 -1.15625,1.1875 -0.76563,0.42188 -1.67188,0.42188 -1.45312,0 -2=
.35937,-0.92188 -0.89063,-0.9375 -0.89063,-2.6875 z m 1.20313,0 q 0,1.32813=
 0.57812,1.98438 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45313,-0.65625 0=
.57812,-0.67188 0.57812,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57812,-0.65=
625 -1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57812,0.65625 -0.57812,1.=
98437 z m 11.13122,3.45313 v -0.875 q -0.65625,1.03125 -1.9375,1.03125 -0.8=
125,0 -1.51562,-0.45313 -0.6875,-0.45312 -1.07813,-1.26562 -0.375,-0.82813 =
-0.375,-1.89063 0,-1.03125 0.34375,-1.875 0.34375,-0.84375 1.03125,-1.28125=
 0.70313,-0.45312 1.54688,-0.45312 0.625,0 1.10937,0.26562 0.5,0.25 0.79688=
,0.67188 v -3.42188 h 1.17187 v 9.54688 z m -3.70312,-3.45313 q 0,1.32813 0=
.5625,1.98438 0.5625,0.65625 1.32812,0.65625 0.76563,0 1.29688,-0.625 0.531=
25,-0.625 0.53125,-1.90625 0,-1.42188 -0.54688,-2.07813 -0.54687,-0.67187 -=
1.34375,-0.67187 -0.78125,0 -1.3125,0.64062 -0.51562,0.625 -0.51562,2 z m 1=
1.3656,1.23438 1.20312,0.14062 q -0.28125,1.0625 -1.0625,1.65625 -0.76562,0=
.57813 -1.96875,0.57813 -1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375 -0.890=
62,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.39=
063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.156=
25 q 0.0625,1.14062 0.64062,1.75 0.57813,0.59375 1.4375,0.59375 0.65625,0 1=
.10938,-0.32813 0.45312,-0.34375 0.71875,-1.07812 z m -3.84375,-1.90625 h 3=
.85937 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.45312,-0.6875=
 -0.8125,0 -1.35938,0.54688 -0.54687,0.53125 -0.60937,1.4375 z m 10.6156,4.=
125 h -1.17188 v -7.46875 q -0.42187,0.40625 -1.10937,0.8125 -0.6875,0.4062=
5 -1.23438,0.60937 v -1.14062 q 0.98438,-0.45313 1.71875,-1.10938 0.73438,-=
0.67187 1.03125,-1.28125 h 0.76563 z m 6.5842,-3.45313 q 0,-1.92187 1.07812=
,-2.84375 0.89063,-0.76562 2.17188,-0.76562 1.42187,0 2.32812,0.9375 0.9062=
5,0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.39062,0.76563 -1.15=
625,1.1875 -0.76562,0.42188 -1.67187,0.42188 -1.45313,0 -2.35938,-0.92188 -=
0.89062,-0.9375 -0.89062,-2.6875 z m 1.20312,0 q 0,1.32813 0.57813,1.98438 =
0.59375,0.65625 1.46875,0.65625 0.875,0 1.45312,-0.65625 0.57813,-0.67188 0=
.57813,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57813,-0.65625 -1.4375,-0.65=
625 -0.875,0 -1.46875,0.65625 -0.57813,0.65625 -0.57813,1.98437 z m 6.9281,=
3.45313 v -6 h -1.03125 v -0.90625 h 1.03125 v -0.73438 q 0,-0.70312 0.125,=
-1.04687 0.17188,-0.45313 0.59375,-0.73438 0.42188,-0.28125 1.20313,-0.2812=
5 0.48437,0 1.09375,0.10938 l -0.1875,1.03125 q -0.35938,-0.0625 -0.6875,-0=
.0625 -0.53125,0 -0.75,0.23437 -0.21875,0.21875 -0.21875,0.84375 v 0.64063 =
h 1.34375 v 0.90625 h -1.34375 v 6 z m 3.4621,0 v -6 h -1.03125 v -0.90625 =
h 1.03125 v -0.73438 q 0,-0.70312 0.125,-1.04687 0.17187,-0.45313 0.59375,-=
0.73438 0.42187,-0.28125 1.20312,-0.28125 0.48438,0 1.09375,0.10938 l -0.18=
75,1.03125 q -0.35937,-0.0625 -0.6875,-0.0625 -0.53125,0 -0.75,0.23437 -0.2=
1875,0.21875 -0.21875,0.84375 v 0.64063 h 1.34375 v 0.90625 h -1.34375 v 6 =
z m 2.953,-2.0625 1.15625,-0.1875 q 0.10938,0.70312 0.54688,1.07812 0.45312=
,0.35938 1.25,0.35938 0.8125,0 1.20312,-0.32813 0.39063,-0.32812 0.39063,-0=
.76562 0,-0.39063 -0.35938,-0.625 -0.23437,-0.15625 -1.1875,-0.39063 -1.296=
87,-0.32812 -1.79687,-0.5625 -0.48438,-0.25 -0.75,-0.65625 -0.25,-0.42187 -=
0.25,-0.9375 0,-0.45312 0.20312,-0.84375 0.21875,-0.40625 0.57813,-0.67187 =
0.28125,-0.1875 0.75,-0.32813 0.46875,-0.14062 1.01562,-0.14062 0.8125,0 1.=
42188,0.23437 0.60937,0.23438 0.90625,0.64063 0.29687,0.39062 0.40625,1.062=
5 l -1.14063,0.15625 q -0.0781,-0.53125 -0.45312,-0.82813 -0.375,-0.3125 -1=
.0625,-0.3125 -0.8125,0 -1.15625,0.26563 -0.34375,0.26562 -0.34375,0.625 0,=
0.23437 0.14062,0.42187 0.15625,0.1875 0.45313,0.3125 0.17187,0.0625 1.0312=
5,0.29688 1.25,0.32812 1.73437,0.54687 0.5,0.20313 0.78125,0.60938 0.28125,=
0.40625 0.28125,1 0,0.59375 -0.34375,1.10937 -0.34375,0.51563 -1,0.79688 -0=
.64062,0.28125 -1.45312,0.28125 -1.34375,0 -2.04688,-0.5625 -0.70312,-0.562=
5 -0.90625,-1.65625 z m 11.86719,-0.15625 1.20312,0.14062 q -0.28125,1.0625=
 -1.0625,1.65625 -0.76562,0.57813 -1.96875,0.57813 -1.51562,0 -2.40625,-0.9=
375 -0.89062,-0.9375 -0.89062,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-0.=
96875 2.34375,-0.96875 1.39063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 =
0,0.10937 0,0.3125 h -5.15625 q 0.0625,1.14062 0.64062,1.75 0.57813,0.59375=
 1.4375,0.59375 0.65625,0 1.10938,-0.32813 0.45312,-0.34375 0.71875,-1.0781=
2 z m -3.84375,-1.90625 h 3.85937 q -0.0781,-0.85938 -0.4375,-1.29688 -0.56=
25,-0.6875 -1.45312,-0.6875 -0.8125,0 -1.35938,0.54688 -0.54687,0.53125 -0.=
60937,1.4375 z m 9.08435,3.07812 0.17188,1.03125 q -0.5,0.10938 -0.89063,0.=
10938 -0.64062,0 -1,-0.20313 -0.34375,-0.20312 -0.48437,-0.53125 -0.14063,-=
0.32812 -0.14063,-1.39062 v -3.96875 h -0.85937 v -0.90625 h 0.85937 v -1.7=
1875 l 1.17188,-0.70313 v 2.42188 h 1.17187 v 0.90625 h -1.17187 v 4.04687 =
q 0,0.5 0.0469,0.64063 0.0625,0.14062 0.20313,0.23437 0.14062,0.0781 0.4062=
5,0.0781 0.20312,0 0.51562,-0.0469 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path366" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 378.07888,165.14477 1.20313,-0.10938 q 0.0781,0.71875 0.39=
062,1.1875 0.3125,0.45313 0.95313,0.73438 0.65625,0.28125 1.46875,0.28125 0=
.71875,0 1.26562,-0.21875 0.5625,-0.21875 0.82813,-0.57813 0.26562,-0.375 0=
.26562,-0.82812 0,-0.45313 -0.26562,-0.78125 -0.25,-0.32813 -0.84375,-0.562=
5 -0.39063,-0.15625 -1.70313,-0.46875 -1.3125,-0.3125 -1.84375,-0.59375 -0.=
67187,-0.35938 -1.01562,-0.89063 -0.32813,-0.53125 -0.32813,-1.1875 0,-0.71=
875 0.40625,-1.34375 0.40625,-0.625 1.1875,-0.95312 0.79688,-0.32813 1.7656=
3,-0.32813 1.04687,0 1.85937,0.34375 0.8125,0.34375 1.25,1.01563 0.4375,0.6=
5625 0.46875,1.48437 l -1.20312,0.0937 q -0.10938,-0.90625 -0.67188,-1.3593=
7 -0.5625,-0.46875 -1.65625,-0.46875 -1.14062,0 -1.67187,0.42187 -0.51563,0=
.42188 -0.51563,1.01563 0,0.51562 0.35938,0.84375 0.375,0.32812 1.90625,0.6=
875 1.54687,0.34375 2.10937,0.59375 0.84375,0.39062 1.23438,0.98437 0.39062=
,0.57813 0.39062,1.35938 0,0.75 -0.4375,1.4375 -0.42187,0.67187 -1.25,1.046=
87 -0.8125,0.35938 -1.82812,0.35938 -1.29688,0 -2.17188,-0.375 -0.875,-0.37=
5 -1.375,-1.125 -0.5,-0.76563 -0.53125,-1.71875 z m 8.73352,-0.39063 q 0,-1=
.92187 1.07813,-2.84375 0.89062,-0.76562 2.17187,-0.76562 1.42188,0 2.32813=
,0.9375 0.90625,0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.39063=
,0.76563 -1.15625,1.1875 -0.76563,0.42188 -1.67188,0.42188 -1.45312,0 -2.35=
937,-0.92188 -0.89063,-0.9375 -0.89063,-2.6875 z m 1.20313,0 q 0,1.32813 0.=
57812,1.98438 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45313,-0.65625 0.57=
812,-0.67188 0.57812,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57812,-0.65625=
 -1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57812,0.65625 -0.57812,1.984=
37 z m 11.1781,3.45313 v -1.01563 q -0.8125,1.17188 -2.1875,1.17188 -0.6093=
8,0 -1.14063,-0.23438 -0.53125,-0.23437 -0.79687,-0.57812 -0.25,-0.35938 -0=
.35938,-0.875 -0.0625,-0.34375 -0.0625,-1.09375 v -4.28125 h 1.17188 v 3.82=
812 q 0,0.92188 0.0625,1.23438 0.10937,0.46875 0.46875,0.73437 0.35937,0.25=
 0.89062,0.25 0.51563,0 0.98438,-0.26562 0.46875,-0.26563 0.65625,-0.73438 =
0.1875,-0.46875 0.1875,-1.34375 v -3.70312 h 1.17187 v 6.90625 z m 2.8656,0=
 v -6.90625 h 1.0625 v 1.04687 q 0.40625,-0.73437 0.73437,-0.96875 0.34375,=
-0.23437 0.76563,-0.23437 0.59375,0 1.20312,0.375 l -0.40625,1.07812 q -0.4=
375,-0.25 -0.85937,-0.25 -0.39063,0 -0.70313,0.23438 -0.29687,0.23437 -0.42=
187,0.64062 -0.20313,0.625 -0.20313,1.35938 v 3.625 z m 8.9696,-2.53125 1.1=
5625,0.15625 q -0.1875,1.1875 -0.96875,1.85937 -0.78125,0.67188 -1.92187,0.=
67188 -1.40625,0 -2.28125,-0.92188 -0.85938,-0.9375 -0.85938,-2.65625 0,-1.=
125 0.375,-1.96875 0.375,-0.84375 1.125,-1.25 0.76563,-0.42187 1.65625,-0.4=
2187 1.125,0 1.84375,0.57812 0.71875,0.5625 0.92188,1.60938 l -1.14063,0.17=
187 q -0.17187,-0.70312 -0.59375,-1.04687 -0.40625,-0.35938 -0.98437,-0.359=
38 -0.89063,0 -1.45313,0.64063 -0.54687,0.64062 -0.54687,2 0,1.40625 0.5312=
5,2.03125 0.54687,0.625 1.40625,0.625 0.6875,0 1.14062,-0.42188 0.46875,-0.=
42187 0.59375,-1.29687 z m 6.88281,0.3125 1.20313,0.14062 q -0.28125,1.0625=
 -1.0625,1.65625 -0.76563,0.57813 -1.96875,0.57813 -1.51563,0 -2.40625,-0.9=
375 -0.89063,-0.9375 -0.89063,-2.60938 0,-1.75 0.89063,-2.70312 0.90625,-0.=
96875 2.34375,-0.96875 1.39062,0 2.26562,0.9375 0.875,0.9375 0.875,2.65625 =
0,0.10937 0,0.3125 h -5.15625 q 0.0625,1.14062 0.64063,1.75 0.57812,0.59375=
 1.4375,0.59375 0.65625,0 1.10937,-0.32813 0.45313,-0.34375 0.71875,-1.0781=
2 z m -3.84375,-1.90625 h 3.85938 q -0.0781,-0.85938 -0.4375,-1.29688 -0.56=
25,-0.6875 -1.45313,-0.6875 -0.8125,0 -1.35937,0.54688 -0.54688,0.53125 -0.=
60938,1.4375 z m 10.36548,4.125 v -9.54688 h 1.29688 l 5.01562,7.5 v -7.5 h=
 1.20313 v 9.54688 h -1.29688 l -5.01562,-7.5 v 7.5 z m 9.04703,-3.45313 q =
0,-1.92187 1.07813,-2.84375 0.89062,-0.76562 2.17187,-0.76562 1.42188,0 2.3=
2813,0.9375 0.90625,0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.3=
9063,0.76563 -1.15625,1.1875 -0.76563,0.42188 -1.67188,0.42188 -1.45312,0 -=
2.35937,-0.92188 -0.89063,-0.9375 -0.89063,-2.6875 z m 1.20313,0 q 0,1.3281=
3 0.57812,1.98438 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45313,-0.65625 =
0.57812,-0.67188 0.57812,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57812,-0.6=
5625 -1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57812,0.65625 -0.57812,1=
.98437 z m 11.13122,3.45313 v -0.875 q -0.65625,1.03125 -1.9375,1.03125 -0.=
8125,0 -1.51562,-0.45313 -0.6875,-0.45312 -1.07813,-1.26562 -0.375,-0.82813=
 -0.375,-1.89063 0,-1.03125 0.34375,-1.875 0.34375,-0.84375 1.03125,-1.2812=
5 0.70313,-0.45312 1.54688,-0.45312 0.625,0 1.10937,0.26562 0.5,0.25 0.7968=
8,0.67188 v -3.42188 h 1.17187 v 9.54688 z m -3.70312,-3.45313 q 0,1.32813 =
0.5625,1.98438 0.5625,0.65625 1.32812,0.65625 0.76563,0 1.29688,-0.625 0.53=
125,-0.625 0.53125,-1.90625 0,-1.42188 -0.54688,-2.07813 -0.54687,-0.67187 =
-1.34375,-0.67187 -0.78125,0 -1.3125,0.64062 -0.51562,0.625 -0.51562,2 z m =
11.3656,1.23438 1.20312,0.14062 q -0.28125,1.0625 -1.0625,1.65625 -0.76562,=
0.57813 -1.96875,0.57813 -1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375 -0.89=
062,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.3=
9063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.15=
625 q 0.0625,1.14062 0.64062,1.75 0.57813,0.59375 1.4375,0.59375 0.65625,0 =
1.10938,-0.32813 0.45312,-0.34375 0.71875,-1.07812 z m -3.84375,-1.90625 h =
3.85937 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.45312,-0.687=
5 -0.8125,0 -1.35938,0.54688 -0.54687,0.53125 -0.60937,1.4375 z m 10.36545,=
4.125 v -9.54688 h 1.29687 l 5.01563,7.5 v -7.5 h 1.20312 v 9.54688 h -1.29=
687 l -5.01563,-7.5 v 7.5 z m 12.75003,-3.45313 q 0,-1.92187 1.07812,-2.843=
75 0.89063,-0.76562 2.17188,-0.76562 1.42187,0 2.32812,0.9375 0.90625,0.921=
87 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.39062,0.76563 -1.15625,1.1=
875 -0.76562,0.42188 -1.67187,0.42188 -1.45313,0 -2.35938,-0.92188 -0.89062=
,-0.9375 -0.89062,-2.6875 z m 1.20312,0 q 0,1.32813 0.57813,1.98438 0.59375=
,0.65625 1.46875,0.65625 0.875,0 1.45312,-0.65625 0.57813,-0.67188 0.57813,=
-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57813,-0.65625 -1.4375,-0.65625 -0.=
875,0 -1.46875,0.65625 -0.57813,0.65625 -0.57813,1.98437 z m 6.9281,3.45313=
 v -6 h -1.03125 v -0.90625 h 1.03125 v -0.73438 q 0,-0.70312 0.125,-1.0468=
7 0.17188,-0.45313 0.59375,-0.73438 0.42188,-0.28125 1.20313,-0.28125 0.484=
37,0 1.09375,0.10938 l -0.1875,1.03125 q -0.35938,-0.0625 -0.6875,-0.0625 -=
0.53125,0 -0.75,0.23437 -0.21875,0.21875 -0.21875,0.84375 v 0.64063 h 1.343=
75 v 0.90625 h -1.34375 v 6 z m 3.4621,0 v -6 h -1.03125 v -0.90625 h 1.031=
25 v -0.73438 q 0,-0.70312 0.125,-1.04687 0.17187,-0.45313 0.59375,-0.73438=
 0.42187,-0.28125 1.20312,-0.28125 0.48438,0 1.09375,0.10938 l -0.1875,1.03=
125 q -0.35937,-0.0625 -0.6875,-0.0625 -0.53125,0 -0.75,0.23437 -0.21875,0.=
21875 -0.21875,0.84375 v 0.64063 h 1.34375 v 0.90625 h -1.34375 v 6 z m 2.9=
5297,-2.0625 1.15625,-0.1875 q 0.10938,0.70312 0.54688,1.07812 0.45312,0.35=
938 1.25,0.35938 0.8125,0 1.20312,-0.32813 0.39063,-0.32812 0.39063,-0.7656=
2 0,-0.39063 -0.35938,-0.625 -0.23437,-0.15625 -1.1875,-0.39063 -1.29687,-0=
.32812 -1.79687,-0.5625 -0.48438,-0.25 -0.75,-0.65625 -0.25,-0.42187 -0.25,=
-0.9375 0,-0.45312 0.20312,-0.84375 0.21875,-0.40625 0.57813,-0.67187 0.281=
25,-0.1875 0.75,-0.32813 0.46875,-0.14062 1.01562,-0.14062 0.8125,0 1.42188=
,0.23437 0.60937,0.23438 0.90625,0.64063 0.29687,0.39062 0.40625,1.0625 l -=
1.14063,0.15625 q -0.0781,-0.53125 -0.45312,-0.82813 -0.375,-0.3125 -1.0625=
,-0.3125 -0.8125,0 -1.15625,0.26563 -0.34375,0.26562 -0.34375,0.625 0,0.234=
37 0.14062,0.42187 0.15625,0.1875 0.45313,0.3125 0.17187,0.0625 1.03125,0.2=
9688 1.25,0.32812 1.73437,0.54687 0.5,0.20313 0.78125,0.60938 0.28125,0.406=
25 0.28125,1 0,0.59375 -0.34375,1.10937 -0.34375,0.51563 -1,0.79688 -0.6406=
2,0.28125 -1.45312,0.28125 -1.34375,0 -2.04688,-0.5625 -0.70312,-0.5625 -0.=
90625,-1.65625 z m 11.86719,-0.15625 1.20312,0.14062 q -0.28125,1.0625 -1.0=
625,1.65625 -0.76562,0.57813 -1.96875,0.57813 -1.51562,0 -2.40625,-0.9375 -=
0.89062,-0.9375 -0.89062,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-0.96875=
 2.34375,-0.96875 1.39063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,0.1=
0937 0,0.3125 h -5.15625 q 0.0625,1.14062 0.64062,1.75 0.57813,0.59375 1.43=
75,0.59375 0.65625,0 1.10938,-0.32813 0.45312,-0.34375 0.71875,-1.07812 z m=
 -3.84375,-1.90625 h 3.85937 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625,-0=
.6875 -1.45312,-0.6875 -0.8125,0 -1.35938,0.54688 -0.54687,0.53125 -0.60937=
,1.4375 z m 9.08435,3.07812 0.17185,1.03125 q -0.49998,0.10938 -0.8906,0.10=
938 -0.64063,0 -1,-0.20313 -0.34375,-0.20312 -0.48438,-0.53125 -0.14062,-0.=
32812 -0.14062,-1.39062 v -3.96875 h -0.85938 v -0.90625 h 0.85938 v -1.718=
75 l 1.17187,-0.70313 v 2.42188 h 1.17188 v 0.90625 h -1.17188 v 4.04687 q =
0,0.5 0.0469,0.64063 0.0625,0.14062 0.20312,0.23437 0.14063,0.0781 0.40625,=
0.0781 0.20313,0 0.51563,-0.0469 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path368" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 374.07084,203.4041 v -9.54688 h 6.90625 v 1.125 h -5.64062=
 v 2.92188 h 5.28125 v 1.125 h -5.28125 v 3.25 h 5.85937 v 1.125 z m 8.7178=
7,0 v -6.90625 h 1.0625 v 0.98437 q 0.75,-1.14062 2.1875,-1.14062 0.625,0 1=
.15625,0.21875 0.53125,0.21875 0.78125,0.59375 0.26562,0.35937 0.375,0.8593=
7 0.0625,0.32813 0.0625,1.14063 v 4.25 h -1.17188 v -4.20313 q 0,-0.71875 -=
0.14062,-1.0625 -0.14063,-0.35937 -0.48438,-0.5625 -0.34375,-0.21875 -0.812=
5,-0.21875 -0.75,0 -1.29687,0.46875 -0.54688,0.46875 -0.54688,1.79688 v 3.7=
8125 z m 11.81872,2.65625 v -3.39063 q -0.26562,0.39063 -0.76562,0.64063 -0=
.48438,0.25 -1.04688,0.25 -1.21875,0 -2.10937,-0.98438 -0.89063,-0.98437 -0=
.89063,-2.6875 0,-1.04687 0.35938,-1.875 0.35937,-0.82812 1.04687,-1.25 0.6=
875,-0.42187 1.51563,-0.42187 1.28125,0 2.01562,1.07812 v -0.92187 h 1.0468=
8 v 9.5625 z m -3.60937,-6.125 q 0,1.32812 0.5625,2 0.5625,0.65625 1.34375,=
0.65625 0.75,0 1.28125,-0.625 0.54687,-0.64063 0.54687,-1.9375 0,-1.375 -0.=
57812,-2.0625 -0.5625,-0.70313 -1.32813,-0.70313 -0.76562,0 -1.29687,0.6562=
5 -0.53125,0.64063 -0.53125,2.01563 z m 11.14685,3.46875 v -1.01563 q -0.81=
25,1.17188 -2.1875,1.17188 -0.60938,0 -1.14063,-0.23438 -0.53125,-0.23437 -=
0.79687,-0.57812 -0.25,-0.35938 -0.35938,-0.875 -0.0625,-0.34375 -0.0625,-1=
.09375 v -4.28125 h 1.17188 v 3.82812 q 0,0.92188 0.0625,1.23438 0.10937,0.=
46875 0.46875,0.73437 0.35937,0.25 0.89062,0.25 0.51563,0 0.98438,-0.26562 =
0.46875,-0.26563 0.65625,-0.73438 0.1875,-0.46875 0.1875,-1.34375 v -3.7031=
2 h 1.17187 v 6.90625 z m 7.6156,-2.21875 1.20312,0.14062 q -0.28125,1.0625=
 -1.0625,1.65625 -0.76562,0.57813 -1.96875,0.57813 -1.51562,0 -2.40625,-0.9=
375 -0.89062,-0.9375 -0.89062,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-0.=
96875 2.34375,-0.96875 1.39063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 =
0,0.10937 0,0.3125 h -5.15625 q 0.0625,1.14062 0.64062,1.75 0.57813,0.59375=
 1.4375,0.59375 0.65625,0 1.10938,-0.32813 0.45312,-0.34375 0.71875,-1.0781=
2 z m -3.84375,-1.90625 h 3.85937 q -0.0781,-0.85938 -0.4375,-1.29688 -0.56=
25,-0.6875 -1.45312,-0.6875 -0.8125,0 -1.35938,0.54688 -0.54687,0.53125 -0.=
60937,1.4375 z m 11.0531,4.125 v -1.01563 q -0.8125,1.17188 -2.1875,1.17188=
 -0.60938,0 -1.14063,-0.23438 -0.53125,-0.23437 -0.79687,-0.57812 -0.25,-0.=
35938 -0.35938,-0.875 -0.0625,-0.34375 -0.0625,-1.09375 v -4.28125 h 1.1718=
8 v 3.82812 q 0,0.92188 0.0625,1.23438 0.10937,0.46875 0.46875,0.73437 0.35=
937,0.25 0.89062,0.25 0.51563,0 0.98438,-0.26562 0.46875,-0.26563 0.65625,-=
0.73438 0.1875,-0.46875 0.1875,-1.34375 v -3.70312 h 1.17187 v 6.90625 z m =
7.6156,-2.21875 1.20312,0.14062 q -0.28125,1.0625 -1.0625,1.65625 -0.76562,=
0.57813 -1.96875,0.57813 -1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375 -0.89=
062,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.3=
9063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.15=
625 q 0.0625,1.14062 0.64062,1.75 0.57813,0.59375 1.4375,0.59375 0.65625,0 =
1.10938,-0.32813 0.45312,-0.34375 0.71875,-1.07812 z m -3.84375,-1.90625 h =
3.85937 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.45312,-0.687=
5 -0.8125,0 -1.35938,0.54688 -0.54687,0.53125 -0.60937,1.4375 z m 10.36548,=
4.125 v -9.54688 h 1.29687 l 5.01563,7.5 v -7.5 h 1.20312 v 9.54688 h -1.29=
687 l -5.01563,-7.5 v 7.5 z m 9.04703,-3.45313 q 0,-1.92187 1.07812,-2.8437=
5 0.89063,-0.76562 2.17188,-0.76562 1.42187,0 2.32812,0.9375 0.90625,0.9218=
7 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.39062,0.76563 -1.15625,1.18=
75 -0.76562,0.42188 -1.67187,0.42188 -1.45313,0 -2.35938,-0.92188 -0.89062,=
-0.9375 -0.89062,-2.6875 z m 1.20312,0 q 0,1.32813 0.57813,1.98438 0.59375,=
0.65625 1.46875,0.65625 0.875,0 1.45312,-0.65625 0.57813,-0.67188 0.57813,-=
2.03125 0,-1.28125 -0.59375,-1.9375 -0.57813,-0.65625 -1.4375,-0.65625 -0.8=
75,0 -1.46875,0.65625 -0.57813,0.65625 -0.57813,1.98437 z m 11.13123,3.4531=
3 v -0.875 q -0.65625,1.03125 -1.9375,1.03125 -0.8125,0 -1.51563,-0.45313 -=
0.6875,-0.45312 -1.07812,-1.26562 -0.375,-0.82813 -0.375,-1.89063 0,-1.0312=
5 0.34375,-1.875 0.34375,-0.84375 1.03125,-1.28125 0.70312,-0.45312 1.54687=
,-0.45312 0.625,0 1.10938,0.26562 0.5,0.25 0.79687,0.67188 v -3.42188 h 1.1=
7188 v 9.54688 z m -3.70313,-3.45313 q 0,1.32813 0.5625,1.98438 0.5625,0.65=
625 1.32813,0.65625 0.76562,0 1.29687,-0.625 0.53125,-0.625 0.53125,-1.9062=
5 0,-1.42188 -0.54687,-2.07813 -0.54688,-0.67187 -1.34375,-0.67187 -0.78125=
,0 -1.3125,0.64062 -0.51563,0.625 -0.51563,2 z m 11.3656,1.23438 1.20313,0.=
14062 q -0.28125,1.0625 -1.0625,1.65625 -0.76563,0.57813 -1.96875,0.57813 -=
1.51563,0 -2.40625,-0.9375 -0.89063,-0.9375 -0.89063,-2.60938 0,-1.75 0.890=
63,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.39062,0 2.26562,0.9375 0.87=
5,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.15625 q 0.0625,1.14062 0.640=
63,1.75 0.57812,0.59375 1.4375,0.59375 0.65625,0 1.10937,-0.32813 0.45313,-=
0.34375 0.71875,-1.07812 z m -3.84375,-1.90625 h 3.85938 q -0.0781,-0.85938=
 -0.4375,-1.29688 -0.5625,-0.6875 -1.45313,-0.6875 -0.8125,0 -1.35937,0.546=
88 -0.54688,0.53125 -0.60938,1.4375 z m 9.8967,-0.57813 q 0,-1.6875 0.34375=
,-2.71875 0.35938,-1.03125 1.04688,-1.59375 0.6875,-0.5625 1.71875,-0.5625 =
0.78125,0 1.35937,0.3125 0.57813,0.29688 0.95313,0.89063 0.375,0.57812 0.59=
375,1.42187 0.21875,0.82813 0.21875,2.25 0,1.67188 -0.35938,2.70313 -0.3437=
5,1.03125 -1.03125,1.59375 -0.67187,0.5625 -1.73437,0.5625 -1.375,0 -2.1562=
5,-0.98438 -0.95313,-1.1875 -0.95313,-3.875 z m 1.20313,0 q 0,2.34375 0.546=
87,3.125 0.5625,0.78125 1.35938,0.78125 0.8125,0 1.35937,-0.78125 0.5625,-0=
.78125 0.5625,-3.125 0,-2.35937 -0.5625,-3.125 -0.54687,-0.78125 -1.35937,-=
0.78125 -0.8125,0 -1.29688,0.6875 -0.60937,0.875 -0.60937,3.21875 z m 9.802=
97,1.25 q 0,-1.92187 1.07813,-2.84375 0.89062,-0.76562 2.17187,-0.76562 1.4=
2188,0 2.32813,0.9375 0.90625,0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.=
09375 -0.39063,0.76563 -1.15625,1.1875 -0.76563,0.42188 -1.67188,0.42188 -1=
.45312,0 -2.35937,-0.92188 -0.89063,-0.9375 -0.89063,-2.6875 z m 1.20313,0 =
q 0,1.32813 0.57812,1.98438 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45313=
,-0.65625 0.57812,-0.67188 0.57812,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.=
57812,-0.65625 -1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57812,0.65625 =
-0.57812,1.98437 z m 6.9281,3.45313 v -6 h -1.03125 v -0.90625 h 1.03125 v =
-0.73438 q 0,-0.70312 0.125,-1.04687 0.17187,-0.45313 0.59375,-0.73438 0.42=
187,-0.28125 1.20312,-0.28125 0.48438,0 1.09375,0.10938 l -0.1875,1.03125 q=
 -0.35937,-0.0625 -0.6875,-0.0625 -0.53125,0 -0.75,0.23437 -0.21875,0.21875=
 -0.21875,0.84375 v 0.64063 h 1.34375 v 0.90625 h -1.34375 v 6 z m 3.4621,0=
 v -6 h -1.03125 v -0.90625 h 1.03125 v -0.73438 q 0,-0.70312 0.125,-1.0468=
7 0.17187,-0.45313 0.59375,-0.73438 0.42187,-0.28125 1.20312,-0.28125 0.484=
38,0 1.09375,0.10938 l -0.1875,1.03125 q -0.35937,-0.0625 -0.6875,-0.0625 -=
0.53125,0 -0.75,0.23437 -0.21875,0.21875 -0.21875,0.84375 v 0.64063 h 1.343=
75 v 0.90625 h -1.34375 v 6 z m 2.95297,-2.0625 1.15625,-0.1875 q 0.10937,0=
.70312 0.54687,1.07812 0.45313,0.35938 1.25,0.35938 0.8125,0 1.20313,-0.328=
13 0.39062,-0.32812 0.39062,-0.76562 0,-0.39063 -0.35937,-0.625 -0.23438,-0=
.15625 -1.1875,-0.39063 -1.29688,-0.32812 -1.79688,-0.5625 -0.48437,-0.25 -=
0.75,-0.65625 -0.25,-0.42187 -0.25,-0.9375 0,-0.45312 0.20313,-0.84375 0.21=
875,-0.40625 0.57812,-0.67187 0.28125,-0.1875 0.75,-0.32813 0.46875,-0.1406=
2 1.01563,-0.14062 0.8125,0 1.42187,0.23437 0.60938,0.23438 0.90625,0.64063=
 0.29688,0.39062 0.40625,1.0625 l -1.14062,0.15625 q -0.0781,-0.53125 -0.45=
313,-0.82813 -0.375,-0.3125 -1.0625,-0.3125 -0.8125,0 -1.15625,0.26563 -0.3=
4375,0.26562 -0.34375,0.625 0,0.23437 0.14063,0.42187 0.15625,0.1875 0.4531=
2,0.3125 0.17188,0.0625 1.03125,0.29688 1.25,0.32812 1.73438,0.54687 0.5,0.=
20313 0.78125,0.60938 0.28125,0.40625 0.28125,1 0,0.59375 -0.34375,1.10937 =
-0.34375,0.51563 -1,0.79688 -0.64063,0.28125 -1.45313,0.28125 -1.34375,0 -2=
.04687,-0.5625 -0.70313,-0.5625 -0.90625,-1.65625 z m 11.86719,-0.15625 1.2=
0311,0.14062 q -0.2812,1.0625 -1.06249,1.65625 -0.76562,0.57813 -1.96875,0.=
57813 -1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375 -0.89062,-2.60938 0,-1.7=
5 0.89062,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.39063,0 2.26563,0.93=
75 0.87501,0.9375 0.87501,2.65625 0,0.10937 0,0.3125 h -5.15626 q 0.0625,1.=
14062 0.64062,1.75 0.57813,0.59375 1.4375,0.59375 0.65625,0 1.10938,-0.3281=
3 0.45312,-0.34375 0.71875,-1.07812 z m -3.84375,-1.90625 h 3.85937 q -0.07=
81,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.45312,-0.6875 -0.8125,0 -1.=
35938,0.54688 -0.54687,0.53125 -0.60937,1.4375 z m 9.08436,3.07812 0.1719,1=
.03125 q -0.5,0.10938 -0.8907,0.10938 -0.6406,0 -1,-0.20313 -0.3437,-0.2031=
2 -0.4843,-0.53125 -0.1407,-0.32812 -0.1407,-1.39062 v -3.96875 h -0.8593 v=
 -0.90625 h 0.8593 v -1.71875 l 1.1719,-0.70313 v 2.42188 h 1.1719 v 0.9062=
5 h -1.1719 v 4.04687 q 0,0.5 0.047,0.64063 0.062,0.14062 0.2031,0.23437 0.=
1407,0.0781 0.4063,0.0781 0.2031,0 0.5156,-0.0469 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path370" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 374.07084,238.60097 v -9.54689 h 6.90625 v 1.125 h -5.6406=
2 v 2.92189 h 5.28125 v 1.125 h -5.28125 v 3.25 h 5.85937 v 1.125 z m 8.717=
87,0 v -6.90625 h 1.0625 v 0.98438 q 0.75,-1.14063 2.1875,-1.14063 0.625,0 =
1.15625,0.21875 0.53125,0.21875 0.78125,0.59375 0.26562,0.35938 0.375,0.859=
38 0.0625,0.32812 0.0625,1.14062 v 4.25 h -1.17188 v -4.20312 q 0,-0.71875 =
-0.14062,-1.0625 -0.14063,-0.35938 -0.48438,-0.5625 -0.34375,-0.21875 -0.81=
25,-0.21875 -0.75,0 -1.29687,0.46875 -0.54688,0.46875 -0.54688,1.79687 v 3.=
78125 z m 11.81872,2.65625 v -3.39062 q -0.26562,0.39062 -0.76562,0.64062 -=
0.48438,0.25 -1.04688,0.25 -1.21875,0 -2.10937,-0.98437 -0.89063,-0.98438 -=
0.89063,-2.6875 0,-1.04688 0.35938,-1.875 0.35937,-0.82813 1.04687,-1.25 0.=
6875,-0.42188 1.51563,-0.42188 1.28125,0 2.01562,1.07813 v -0.92188 h 1.046=
88 v 9.5625 z m -3.60937,-6.125 q 0,1.32813 0.5625,2 0.5625,0.65625 1.34375=
,0.65625 0.75,0 1.28125,-0.625 0.54687,-0.64062 0.54687,-1.9375 0,-1.375 -0=
.57812,-2.0625 -0.5625,-0.70312 -1.32813,-0.70312 -0.76562,0 -1.29687,0.656=
25 -0.53125,0.64062 -0.53125,2.01562 z m 11.14685,3.46875 v -1.01562 q -0.8=
125,1.17187 -2.1875,1.17187 -0.60938,0 -1.14063,-0.23437 -0.53125,-0.23438 =
-0.79687,-0.57813 -0.25,-0.35937 -0.35938,-0.875 -0.0625,-0.34375 -0.0625,-=
1.09375 v -4.28125 h 1.17188 v 3.82813 q 0,0.92187 0.0625,1.23437 0.10937,0=
.46875 0.46875,0.73438 0.35937,0.25 0.89062,0.25 0.51563,0 0.98438,-0.26563=
 0.46875,-0.26562 0.65625,-0.73437 0.1875,-0.46875 0.1875,-1.34375 v -3.703=
13 h 1.17187 v 6.90625 z m 7.6156,-2.21875 1.20312,0.14063 q -0.28125,1.062=
5 -1.0625,1.65625 -0.76562,0.57812 -1.96875,0.57812 -1.51562,0 -2.40625,-0.=
9375 -0.89062,-0.9375 -0.89062,-2.60937 0,-1.75 0.89062,-2.70313 0.90625,-0=
.96875 2.34375,-0.96875 1.39063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625=
 0,0.10938 0,0.3125 h -5.15625 q 0.0625,1.14063 0.64062,1.75 0.57813,0.5937=
5 1.4375,0.59375 0.65625,0 1.10938,-0.32812 0.45312,-0.34375 0.71875,-1.078=
13 z m -3.84375,-1.90625 h 3.85937 q -0.0781,-0.85937 -0.4375,-1.29687 -0.5=
625,-0.6875 -1.45312,-0.6875 -0.8125,0 -1.35938,0.54687 -0.54687,0.53125 -0=
.60937,1.4375 z m 11.0531,4.125 v -1.01562 q -0.8125,1.17187 -2.1875,1.1718=
7 -0.60938,0 -1.14063,-0.23437 -0.53125,-0.23438 -0.79687,-0.57813 -0.25,-0=
.35937 -0.35938,-0.875 -0.0625,-0.34375 -0.0625,-1.09375 v -4.28125 h 1.171=
88 v 3.82813 q 0,0.92187 0.0625,1.23437 0.10937,0.46875 0.46875,0.73438 0.3=
5937,0.25 0.89062,0.25 0.51563,0 0.98438,-0.26563 0.46875,-0.26562 0.65625,=
-0.73437 0.1875,-0.46875 0.1875,-1.34375 v -3.70313 h 1.17187 v 6.90625 z m=
 7.6156,-2.21875 1.20312,0.14063 q -0.28125,1.0625 -1.0625,1.65625 -0.76562=
,0.57812 -1.96875,0.57812 -1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375 -0.8=
9062,-2.60937 0,-1.75 0.89062,-2.70313 0.90625,-0.96875 2.34375,-0.96875 1.=
39063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,0.10938 0,0.3125 h -5.1=
5625 q 0.0625,1.14063 0.64062,1.75 0.57813,0.59375 1.4375,0.59375 0.65625,0=
 1.10938,-0.32812 0.45312,-0.34375 0.71875,-1.07813 z m -3.84375,-1.90625 h=
 3.85937 q -0.0781,-0.85937 -0.4375,-1.29687 -0.5625,-0.6875 -1.45312,-0.68=
75 -0.8125,0 -1.35938,0.54687 -0.54687,0.53125 -0.60937,1.4375 z m 10.36548=
,4.125 v -9.54689 h 1.29687 l 5.01563,7.50002 v -7.50002 h 1.20312 v 9.5468=
9 h -1.29687 l -5.01563,-7.50002 v 7.50002 z m 9.04703,-3.45312 q 0,-1.9218=
8 1.07812,-2.84375 0.89063,-0.76563 2.17188,-0.76563 1.42187,0 2.32812,0.93=
75 0.90625,0.92188 0.90625,2.57813 0,1.32812 -0.40625,2.09375 -0.39062,0.76=
562 -1.15625,1.1875 -0.76562,0.42187 -1.67187,0.42187 -1.45313,0 -2.35938,-=
0.92187 -0.89062,-0.9375 -0.89062,-2.6875 z m 1.20312,0 q 0,1.32812 0.57813=
,1.98437 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45312,-0.65625 0.57813,-=
0.67187 0.57813,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57813,-0.65625 -1.4=
375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57813,0.65625 -0.57813,1.98438 z =
m 11.13123,3.45312 v -0.875 q -0.65625,1.03125 -1.9375,1.03125 -0.8125,0 -1=
.51563,-0.45312 -0.6875,-0.45313 -1.07812,-1.26563 -0.375,-0.82812 -0.375,-=
1.89062 0,-1.03125 0.34375,-1.875 0.34375,-0.84375 1.03125,-1.28125 0.70312=
,-0.45313 1.54687,-0.45313 0.625,0 1.10938,0.26563 0.5,0.25 0.79687,0.67187=
 v -3.42189 h 1.17188 v 9.54689 z m -3.70313,-3.45312 q 0,1.32812 0.5625,1.=
98437 0.5625,0.65625 1.32813,0.65625 0.76562,0 1.29687,-0.625 0.53125,-0.62=
5 0.53125,-1.90625 0,-1.42187 -0.54687,-2.07812 -0.54688,-0.67188 -1.34375,=
-0.67188 -0.78125,0 -1.3125,0.64063 -0.51563,0.625 -0.51563,2 z m 11.3656,1=
.23437 1.20313,0.14063 q -0.28125,1.0625 -1.0625,1.65625 -0.76563,0.57812 -=
1.96875,0.57812 -1.51563,0 -2.40625,-0.9375 -0.89063,-0.9375 -0.89063,-2.60=
937 0,-1.75 0.89063,-2.70313 0.90625,-0.96875 2.34375,-0.96875 1.39062,0 2.=
26562,0.9375 0.875,0.9375 0.875,2.65625 0,0.10938 0,0.3125 h -5.15625 q 0.0=
625,1.14063 0.64063,1.75 0.57812,0.59375 1.4375,0.59375 0.65625,0 1.10937,-=
0.32812 0.45313,-0.34375 0.71875,-1.07813 z m -3.84375,-1.90625 h 3.85938 q=
 -0.0781,-0.85937 -0.4375,-1.29687 -0.5625,-0.6875 -1.45313,-0.6875 -0.8125=
,0 -1.35937,0.54687 -0.54688,0.53125 -0.60938,1.4375 z m 14.31858,4.125 h -=
1.17188 v -7.46877 q -0.42187,0.40627 -1.10937,0.81252 -0.6875,0.40625 -1.2=
3438,0.60937 v -1.14064 q 0.98438,-0.45312 1.71875,-1.10937 0.73438,-0.6718=
8 1.03125,-1.28125 h 0.76563 z m 6.58422,-3.45312 q 0,-1.92188 1.07813,-2.8=
4375 0.89062,-0.76563 2.17187,-0.76563 1.42188,0 2.32813,0.9375 0.90625,0.9=
2188 0.90625,2.57813 0,1.32812 -0.40625,2.09375 -0.39063,0.76562 -1.15625,1=
.1875 -0.76563,0.42187 -1.67188,0.42187 -1.45312,0 -2.35937,-0.92187 -0.890=
63,-0.9375 -0.89063,-2.6875 z m 1.20313,0 q 0,1.32812 0.57812,1.98437 0.593=
75,0.65625 1.46875,0.65625 0.875,0 1.45313,-0.65625 0.57812,-0.67187 0.5781=
2,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57812,-0.65625 -1.4375,-0.65625 -=
0.875,0 -1.46875,0.65625 -0.57812,0.65625 -0.57812,1.98438 z m 6.9281,3.453=
12 v -6 h -1.03125 v -0.90625 h 1.03125 v -0.73439 q 0,-0.70313 0.125,-1.04=
688 0.17187,-0.45312 0.59375,-0.73437 0.42187,-0.28125 1.20312,-0.28125 0.4=
8438,0 1.09375,0.10937 l -0.1875,1.03125 q -0.35937,-0.0625 -0.6875,-0.0625=
 -0.53125,0 -0.75,0.23438 -0.21875,0.21875 -0.21875,0.84375 v 0.64064 h 1.3=
4375 v 0.90625 h -1.34375 v 6 z m 3.4621,0 v -6 h -1.03125 v -0.90625 h 1.0=
3125 v -0.73439 q 0,-0.70313 0.125,-1.04688 0.17187,-0.45312 0.59375,-0.734=
37 0.42187,-0.28125 1.20312,-0.28125 0.48438,0 1.09375,0.10937 l -0.1875,1.=
03125 q -0.35937,-0.0625 -0.6875,-0.0625 -0.53125,0 -0.75,0.23438 -0.21875,=
0.21875 -0.21875,0.84375 v 0.64064 h 1.34375 v 0.90625 h -1.34375 v 6 z m 2=
.95297,-2.0625 1.15625,-0.1875 q 0.10937,0.70313 0.54687,1.07813 0.45313,0.=
35937 1.25,0.35937 0.8125,0 1.20313,-0.32812 0.39062,-0.32813 0.39062,-0.76=
563 0,-0.39062 -0.35937,-0.625 -0.23438,-0.15625 -1.1875,-0.39062 -1.29688,=
-0.32813 -1.79688,-0.5625 -0.48437,-0.25 -0.75,-0.65625 -0.25,-0.42188 -0.2=
5,-0.9375 0,-0.45313 0.20313,-0.84375 0.21875,-0.40625 0.57812,-0.67188 0.2=
8125,-0.1875 0.75,-0.32812 0.46875,-0.14063 1.01563,-0.14063 0.8125,0 1.421=
87,0.23438 0.60938,0.23437 0.90625,0.64062 0.29688,0.39063 0.40625,1.0625 l=
 -1.14062,0.15625 q -0.0781,-0.53125 -0.45313,-0.82812 -0.375,-0.3125 -1.06=
25,-0.3125 -0.8125,0 -1.15625,0.26562 -0.34375,0.26563 -0.34375,0.625 0,0.2=
3438 0.14063,0.42188 0.15625,0.1875 0.45312,0.3125 0.17188,0.0625 1.03125,0=
.29687 1.25,0.32813 1.73438,0.54688 0.5,0.20312 0.78125,0.60937 0.28125,0.4=
0625 0.28125,1 0,0.59375 -0.34375,1.10938 -0.34375,0.51562 -1,0.79687 -0.64=
063,0.28125 -1.45313,0.28125 -1.34375,0 -2.04687,-0.5625 -0.70313,-0.5625 -=
0.90625,-1.65625 z m 11.86719,-0.15625 1.20311,0.14063 q -0.2812,1.0625 -1.=
06249,1.65625 -0.76562,0.57812 -1.96875,0.57812 -1.51562,0 -2.40625,-0.9375=
 -0.89062,-0.9375 -0.89062,-2.60937 0,-1.75 0.89062,-2.70313 0.90625,-0.968=
75 2.34375,-0.96875 1.39063,0 2.26563,0.9375 0.87501,0.9375 0.87501,2.65625=
 0,0.10938 0,0.3125 h -5.15626 q 0.0625,1.14063 0.64062,1.75 0.57813,0.5937=
5 1.4375,0.59375 0.65625,0 1.10938,-0.32812 0.45312,-0.34375 0.71875,-1.078=
13 z m -3.84375,-1.90625 h 3.85937 q -0.0781,-0.85937 -0.4375,-1.29687 -0.5=
625,-0.6875 -1.45312,-0.6875 -0.8125,0 -1.35938,0.54687 -0.54687,0.53125 -0=
.60937,1.4375 z m 9.08436,3.07813 0.1719,1.03125 q -0.5,0.10937 -0.8907,0.1=
0937 -0.6406,0 -1,-0.20312 -0.3437,-0.20313 -0.4843,-0.53125 -0.1407,-0.328=
13 -0.1407,-1.39063 v -3.96875 h -0.8593 v -0.90625 h 0.8593 v -1.71877 l 1=
.1719,-0.70312 v 2.42189 h 1.1719 v 0.90625 h -1.1719 v 4.04688 q 0,0.5 0.0=
47,0.64062 0.062,0.14063 0.2031,0.23438 0.1407,0.0781 0.4063,0.0781 0.2031,=
0 0.5156,-0.0469 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path372" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 374.07084,273.7978 v -9.54688 h 6.90625 v 1.125 h -5.64062=
 v 2.92188 h 5.28125 v 1.125 h -5.28125 v 3.25 h 5.85937 v 1.125 z m 8.7178=
7,0 v -6.90625 h 1.0625 v 0.98437 q 0.75,-1.14062 2.1875,-1.14062 0.625,0 1=
.15625,0.21875 0.53125,0.21875 0.78125,0.59375 0.26562,0.35937 0.375,0.8593=
7 0.0625,0.32813 0.0625,1.14063 v 4.25 h -1.17188 v -4.20313 q 0,-0.71875 -=
0.14062,-1.0625 -0.14063,-0.35937 -0.48438,-0.5625 -0.34375,-0.21875 -0.812=
5,-0.21875 -0.75,0 -1.29687,0.46875 -0.54688,0.46875 -0.54688,1.79688 v 3.7=
8125 z m 11.81872,2.65625 v -3.39063 q -0.26562,0.39063 -0.76562,0.64063 -0=
.48438,0.25 -1.04688,0.25 -1.21875,0 -2.10937,-0.98438 -0.89063,-0.98437 -0=
.89063,-2.6875 0,-1.04687 0.35938,-1.875 0.35937,-0.82812 1.04687,-1.25 0.6=
875,-0.42187 1.51563,-0.42187 1.28125,0 2.01562,1.07812 v -0.92187 h 1.0468=
8 v 9.5625 z m -3.60937,-6.125 q 0,1.32812 0.5625,2 0.5625,0.65625 1.34375,=
0.65625 0.75,0 1.28125,-0.625 0.54687,-0.64063 0.54687,-1.9375 0,-1.375 -0.=
57812,-2.0625 -0.5625,-0.70313 -1.32813,-0.70313 -0.76562,0 -1.29687,0.6562=
5 -0.53125,0.64063 -0.53125,2.01563 z m 11.14685,3.46875 v -1.01563 q -0.81=
25,1.17188 -2.1875,1.17188 -0.60938,0 -1.14063,-0.23438 -0.53125,-0.23437 -=
0.79687,-0.57812 -0.25,-0.35938 -0.35938,-0.875 -0.0625,-0.34375 -0.0625,-1=
.09375 v -4.28125 h 1.17188 v 3.82812 q 0,0.92188 0.0625,1.23438 0.10937,0.=
46875 0.46875,0.73437 0.35937,0.25 0.89062,0.25 0.51563,0 0.98438,-0.26562 =
0.46875,-0.26563 0.65625,-0.73438 0.1875,-0.46875 0.1875,-1.34375 v -3.7031=
2 h 1.17187 v 6.90625 z m 7.6156,-2.21875 1.20312,0.14062 q -0.28125,1.0625=
 -1.0625,1.65625 -0.76562,0.57813 -1.96875,0.57813 -1.51562,0 -2.40625,-0.9=
375 -0.89062,-0.9375 -0.89062,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-0.=
96875 2.34375,-0.96875 1.39063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 =
0,0.10937 0,0.3125 h -5.15625 q 0.0625,1.14062 0.64062,1.75 0.57813,0.59375=
 1.4375,0.59375 0.65625,0 1.10938,-0.32813 0.45312,-0.34375 0.71875,-1.0781=
2 z m -3.84375,-1.90625 h 3.85937 q -0.0781,-0.85938 -0.4375,-1.29688 -0.56=
25,-0.6875 -1.45312,-0.6875 -0.8125,0 -1.35938,0.54688 -0.54687,0.53125 -0.=
60937,1.4375 z m 11.0531,4.125 v -1.01563 q -0.8125,1.17188 -2.1875,1.17188=
 -0.60938,0 -1.14063,-0.23438 -0.53125,-0.23437 -0.79687,-0.57812 -0.25,-0.=
35938 -0.35938,-0.875 -0.0625,-0.34375 -0.0625,-1.09375 v -4.28125 h 1.1718=
8 v 3.82812 q 0,0.92188 0.0625,1.23438 0.10937,0.46875 0.46875,0.73437 0.35=
937,0.25 0.89062,0.25 0.51563,0 0.98438,-0.26562 0.46875,-0.26563 0.65625,-=
0.73438 0.1875,-0.46875 0.1875,-1.34375 v -3.70312 h 1.17187 v 6.90625 z m =
7.6156,-2.21875 1.20312,0.14062 q -0.28125,1.0625 -1.0625,1.65625 -0.76562,=
0.57813 -1.96875,0.57813 -1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375 -0.89=
062,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.3=
9063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.15=
625 q 0.0625,1.14062 0.64062,1.75 0.57813,0.59375 1.4375,0.59375 0.65625,0 =
1.10938,-0.32813 0.45312,-0.34375 0.71875,-1.07812 z m -3.84375,-1.90625 h =
3.85937 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.45312,-0.687=
5 -0.8125,0 -1.35938,0.54688 -0.54687,0.53125 -0.60937,1.4375 z m 10.36548,=
4.125 v -9.54688 h 1.29687 l 5.01563,7.5 v -7.5 h 1.20312 v 9.54688 h -1.29=
687 l -5.01563,-7.5 v 7.5 z m 9.04703,-3.45313 q 0,-1.92187 1.07812,-2.8437=
5 0.89063,-0.76562 2.17188,-0.76562 1.42187,0 2.32812,0.9375 0.90625,0.9218=
7 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.39062,0.76563 -1.15625,1.18=
75 -0.76562,0.42188 -1.67187,0.42188 -1.45313,0 -2.35938,-0.92188 -0.89062,=
-0.9375 -0.89062,-2.6875 z m 1.20312,0 q 0,1.32813 0.57813,1.98438 0.59375,=
0.65625 1.46875,0.65625 0.875,0 1.45312,-0.65625 0.57813,-0.67188 0.57813,-=
2.03125 0,-1.28125 -0.59375,-1.9375 -0.57813,-0.65625 -1.4375,-0.65625 -0.8=
75,0 -1.46875,0.65625 -0.57813,0.65625 -0.57813,1.98437 z m 11.13123,3.4531=
3 v -0.875 q -0.65625,1.03125 -1.9375,1.03125 -0.8125,0 -1.51563,-0.45313 -=
0.6875,-0.45312 -1.07812,-1.26562 -0.375,-0.82813 -0.375,-1.89063 0,-1.0312=
5 0.34375,-1.875 0.34375,-0.84375 1.03125,-1.28125 0.70312,-0.45312 1.54687=
,-0.45312 0.625,0 1.10938,0.26562 0.5,0.25 0.79687,0.67188 v -3.42188 h 1.1=
7188 v 9.54688 z m -3.70313,-3.45313 q 0,1.32813 0.5625,1.98438 0.5625,0.65=
625 1.32813,0.65625 0.76562,0 1.29687,-0.625 0.53125,-0.625 0.53125,-1.9062=
5 0,-1.42188 -0.54687,-2.07813 -0.54688,-0.67187 -1.34375,-0.67187 -0.78125=
,0 -1.3125,0.64062 -0.51563,0.625 -0.51563,2 z m 11.3656,1.23438 1.20313,0.=
14062 q -0.28125,1.0625 -1.0625,1.65625 -0.76563,0.57813 -1.96875,0.57813 -=
1.51563,0 -2.40625,-0.9375 -0.89063,-0.9375 -0.89063,-2.60938 0,-1.75 0.890=
63,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.39062,0 2.26562,0.9375 0.87=
5,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.15625 q 0.0625,1.14062 0.640=
63,1.75 0.57812,0.59375 1.4375,0.59375 0.65625,0 1.10937,-0.32813 0.45313,-=
0.34375 0.71875,-1.07812 z m -3.84375,-1.90625 h 3.85938 q -0.0781,-0.85938=
 -0.4375,-1.29688 -0.5625,-0.6875 -1.45313,-0.6875 -0.8125,0 -1.35937,0.546=
88 -0.54688,0.53125 -0.60938,1.4375 z m 16.05295,3 v 1.125 h -6.29687 q -0.=
0156,-0.42188 0.14062,-0.8125 0.23438,-0.64063 0.76563,-1.26563 0.53125,-0.=
625 1.53125,-1.45312 1.5625,-1.26563 2.10937,-2.01563 0.54688,-0.75 0.54688=
,-1.40625 0,-0.70312 -0.5,-1.17187 -0.5,-0.48438 -1.29688,-0.48438 -0.85937=
,0 -1.375,0.51563 -0.5,0.5 -0.5,1.39062 l -1.20312,-0.10937 q 0.125,-1.3593=
8 0.92187,-2.0625 0.8125,-0.70313 2.17188,-0.70313 1.375,0 2.17187,0.76563 =
0.8125,0.75 0.8125,1.875 0,0.57812 -0.23437,1.14062 -0.23438,0.54688 -0.781=
25,1.15625 -0.54688,0.60938 -1.8125,1.67188 -1.04688,0.89062 -1.35938,1.218=
75 -0.29687,0.3125 -0.48437,0.625 z m 4.84985,-2.32813 q 0,-1.92187 1.07813=
,-2.84375 0.89062,-0.76562 2.17187,-0.76562 1.42188,0 2.32813,0.9375 0.9062=
5,0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.39063,0.76563 -1.15=
625,1.1875 -0.76563,0.42188 -1.67188,0.42188 -1.45312,0 -2.35937,-0.92188 -=
0.89063,-0.9375 -0.89063,-2.6875 z m 1.20313,0 q 0,1.32813 0.57812,1.98438 =
0.59375,0.65625 1.46875,0.65625 0.875,0 1.45313,-0.65625 0.57812,-0.67188 0=
.57812,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57812,-0.65625 -1.4375,-0.65=
625 -0.875,0 -1.46875,0.65625 -0.57812,0.65625 -0.57812,1.98437 z m 6.9281,=
3.45313 v -6 h -1.03125 v -0.90625 h 1.03125 v -0.73438 q 0,-0.70312 0.125,=
-1.04687 0.17187,-0.45313 0.59375,-0.73438 0.42187,-0.28125 1.20312,-0.2812=
5 0.48438,0 1.09375,0.10938 l -0.1875,1.03125 q -0.35937,-0.0625 -0.6875,-0=
.0625 -0.53125,0 -0.75,0.23437 -0.21875,0.21875 -0.21875,0.84375 v 0.64063 =
h 1.34375 v 0.90625 h -1.34375 v 6 z m 3.4621,0 v -6 h -1.03125 v -0.90625 =
h 1.03125 v -0.73438 q 0,-0.70312 0.125,-1.04687 0.17187,-0.45313 0.59375,-=
0.73438 0.42187,-0.28125 1.20312,-0.28125 0.48438,0 1.09375,0.10938 l -0.18=
75,1.03125 q -0.35937,-0.0625 -0.6875,-0.0625 -0.53125,0 -0.75,0.23437 -0.2=
1875,0.21875 -0.21875,0.84375 v 0.64063 h 1.34375 v 0.90625 h -1.34375 v 6 =
z m 2.95297,-2.0625 1.15625,-0.1875 q 0.10937,0.70312 0.54687,1.07812 0.453=
13,0.35938 1.25,0.35938 0.8125,0 1.20313,-0.32813 0.39062,-0.32812 0.39062,=
-0.76562 0,-0.39063 -0.35937,-0.625 -0.23438,-0.15625 -1.1875,-0.39063 -1.2=
9688,-0.32812 -1.79688,-0.5625 -0.48437,-0.25 -0.75,-0.65625 -0.25,-0.42187=
 -0.25,-0.9375 0,-0.45312 0.20313,-0.84375 0.21875,-0.40625 0.57812,-0.6718=
7 0.28125,-0.1875 0.75,-0.32813 0.46875,-0.14062 1.01563,-0.14062 0.8125,0 =
1.42187,0.23437 0.60938,0.23438 0.90625,0.64063 0.29688,0.39062 0.40625,1.0=
625 l -1.14062,0.15625 q -0.0781,-0.53125 -0.45313,-0.82813 -0.375,-0.3125 =
-1.0625,-0.3125 -0.8125,0 -1.15625,0.26563 -0.34375,0.26562 -0.34375,0.625 =
0,0.23437 0.14063,0.42187 0.15625,0.1875 0.45312,0.3125 0.17188,0.0625 1.03=
125,0.29688 1.25,0.32812 1.73438,0.54687 0.5,0.20313 0.78125,0.60938 0.2812=
5,0.40625 0.28125,1 0,0.59375 -0.34375,1.10937 -0.34375,0.51563 -1,0.79688 =
-0.64063,0.28125 -1.45313,0.28125 -1.34375,0 -2.04687,-0.5625 -0.70313,-0.5=
625 -0.90625,-1.65625 z m 11.86719,-0.15625 1.20311,0.14062 q -0.2812,1.062=
5 -1.06249,1.65625 -0.76562,0.57813 -1.96875,0.57813 -1.51562,0 -2.40625,-0=
.9375 -0.89062,-0.9375 -0.89062,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-=
0.96875 2.34375,-0.96875 1.39063,0 2.26563,0.9375 0.87501,0.9375 0.87501,2.=
65625 0,0.10937 0,0.3125 h -5.15626 q 0.0625,1.14062 0.64062,1.75 0.57813,0=
.59375 1.4375,0.59375 0.65625,0 1.10938,-0.32813 0.45312,-0.34375 0.71875,-=
1.07812 z m -3.84375,-1.90625 h 3.85937 q -0.0781,-0.85938 -0.4375,-1.29688=
 -0.5625,-0.6875 -1.45312,-0.6875 -0.8125,0 -1.35938,0.54688 -0.54687,0.531=
25 -0.60937,1.4375 z m 9.08436,3.07812 0.1719,1.03125 q -0.5,0.10938 -0.890=
7,0.10938 -0.6406,0 -1,-0.20313 -0.3437,-0.20312 -0.4843,-0.53125 -0.1407,-=
0.32812 -0.1407,-1.39062 v -3.96875 h -0.8593 v -0.90625 h 0.8593 v -1.7187=
5 l 1.1719,-0.70313 v 2.42188 h 1.1719 v 0.90625 h -1.1719 v 4.04687 q 0,0.=
5 0.047,0.64063 0.062,0.14062 0.2031,0.23437 0.1407,0.0781 0.4063,0.0781 0.=
2031,0 0.5156,-0.0469 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path374" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 372.96448,308.99465 v -9.54688 h 6.90625 v 1.125 h -5.6406=
2 v 2.92188 h 5.28125 v 1.125 h -5.28125 v 3.25 h 5.85937 v 1.125 z m 8.717=
9,0 v -6.90625 h 1.0625 v 0.98437 q 0.75,-1.14062 2.1875,-1.14062 0.625,0 1=
.15625,0.21875 0.53125,0.21875 0.78125,0.59375 0.26562,0.35937 0.375,0.8593=
7 0.0625,0.32813 0.0625,1.14063 v 4.25 h -1.17188 v -4.20313 q 0,-0.71875 -=
0.14062,-1.0625 -0.14063,-0.35937 -0.48438,-0.5625 -0.34375,-0.21875 -0.812=
5,-0.21875 -0.75,0 -1.29687,0.46875 -0.54688,0.46875 -0.54688,1.79688 v 3.7=
8125 z m 11.81872,2.65625 v -3.39063 q -0.26562,0.39063 -0.76562,0.64063 -0=
.48438,0.25 -1.04688,0.25 -1.21875,0 -2.10937,-0.98438 -0.89063,-0.98437 -0=
.89063,-2.6875 0,-1.04687 0.35938,-1.875 0.35937,-0.82812 1.04687,-1.25 0.6=
875,-0.42187 1.51563,-0.42187 1.28125,0 2.01562,1.07812 v -0.92187 h 1.0468=
8 v 9.5625 z m -3.60937,-6.125 q 0,1.32812 0.5625,2 0.5625,0.65625 1.34375,=
0.65625 0.75,0 1.28125,-0.625 0.54687,-0.64063 0.54687,-1.9375 0,-1.375 -0.=
57812,-2.0625 -0.5625,-0.70313 -1.32813,-0.70313 -0.76562,0 -1.29687,0.6562=
5 -0.53125,0.64063 -0.53125,2.01563 z m 11.14685,3.46875 v -1.01563 q -0.81=
25,1.17188 -2.1875,1.17188 -0.60938,0 -1.14063,-0.23438 -0.53125,-0.23437 -=
0.79687,-0.57812 -0.25,-0.35938 -0.35938,-0.875 -0.0625,-0.34375 -0.0625,-1=
.09375 v -4.28125 h 1.17188 v 3.82812 q 0,0.92188 0.0625,1.23438 0.10937,0.=
46875 0.46875,0.73437 0.35937,0.25 0.89062,0.25 0.51563,0 0.98438,-0.26562 =
0.46875,-0.26563 0.65625,-0.73438 0.1875,-0.46875 0.1875,-1.34375 v -3.7031=
2 h 1.17187 v 6.90625 z m 7.6156,-2.21875 1.20312,0.14062 q -0.28125,1.0625=
 -1.0625,1.65625 -0.76562,0.57813 -1.96875,0.57813 -1.51562,0 -2.40625,-0.9=
375 -0.89062,-0.9375 -0.89062,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-0.=
96875 2.34375,-0.96875 1.39063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 =
0,0.10937 0,0.3125 h -5.15625 q 0.0625,1.14062 0.64062,1.75 0.57813,0.59375=
 1.4375,0.59375 0.65625,0 1.10938,-0.32813 0.45312,-0.34375 0.71875,-1.0781=
2 z m -3.84375,-1.90625 h 3.85937 q -0.0781,-0.85938 -0.4375,-1.29688 -0.56=
25,-0.6875 -1.45312,-0.6875 -0.8125,0 -1.35938,0.54688 -0.54687,0.53125 -0.=
60937,1.4375 z m 11.0531,4.125 v -1.01563 q -0.8125,1.17188 -2.1875,1.17188=
 -0.60938,0 -1.14063,-0.23438 -0.53125,-0.23437 -0.79687,-0.57812 -0.25,-0.=
35938 -0.35938,-0.875 -0.0625,-0.34375 -0.0625,-1.09375 v -4.28125 h 1.1718=
8 v 3.82812 q 0,0.92188 0.0625,1.23438 0.10937,0.46875 0.46875,0.73437 0.35=
937,0.25 0.89062,0.25 0.51563,0 0.98438,-0.26562 0.46875,-0.26563 0.65625,-=
0.73438 0.1875,-0.46875 0.1875,-1.34375 v -3.70312 h 1.17187 v 6.90625 z m =
7.6156,-2.21875 1.20312,0.14062 q -0.28125,1.0625 -1.0625,1.65625 -0.76562,=
0.57813 -1.96875,0.57813 -1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375 -0.89=
062,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.3=
9063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.15=
625 q 0.0625,1.14062 0.64062,1.75 0.57813,0.59375 1.4375,0.59375 0.65625,0 =
1.10938,-0.32813 0.45312,-0.34375 0.71875,-1.07812 z m -3.84375,-1.90625 h =
3.85937 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.45312,-0.687=
5 -0.8125,0 -1.35938,0.54688 -0.54687,0.53125 -0.60937,1.4375 z m 10.36545,=
4.125 v -9.54688 h 1.29687 l 5.01563,7.5 v -7.5 h 1.20312 v 9.54688 h -1.29=
687 l -5.01563,-7.5 v 7.5 z m 9.04703,-3.45313 q 0,-1.92187 1.07812,-2.8437=
5 0.89063,-0.76562 2.17188,-0.76562 1.42187,0 2.32812,0.9375 0.90625,0.9218=
7 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.39062,0.76563 -1.15625,1.18=
75 -0.76562,0.42188 -1.67187,0.42188 -1.45313,0 -2.35938,-0.92188 -0.89062,=
-0.9375 -0.89062,-2.6875 z m 1.20312,0 q 0,1.32813 0.57813,1.98438 0.59375,=
0.65625 1.46875,0.65625 0.875,0 1.45312,-0.65625 0.57813,-0.67188 0.57813,-=
2.03125 0,-1.28125 -0.59375,-1.9375 -0.57813,-0.65625 -1.4375,-0.65625 -0.8=
75,0 -1.46875,0.65625 -0.57813,0.65625 -0.57813,1.98437 z m 11.13123,3.4531=
3 v -0.875 q -0.65625,1.03125 -1.9375,1.03125 -0.8125,0 -1.51563,-0.45313 -=
0.6875,-0.45312 -1.07812,-1.26562 -0.375,-0.82813 -0.375,-1.89063 0,-1.0312=
5 0.34375,-1.875 0.34375,-0.84375 1.03125,-1.28125 0.70312,-0.45312 1.54687=
,-0.45312 0.625,0 1.10938,0.26562 0.5,0.25 0.79687,0.67188 v -3.42188 h 1.1=
7188 v 9.54688 z m -3.70313,-3.45313 q 0,1.32813 0.5625,1.98438 0.5625,0.65=
625 1.32813,0.65625 0.76562,0 1.29687,-0.625 0.53125,-0.625 0.53125,-1.9062=
5 0,-1.42188 -0.54687,-2.07813 -0.54688,-0.67187 -1.34375,-0.67187 -0.78125=
,0 -1.3125,0.64062 -0.51563,0.625 -0.51563,2 z m 11.3656,1.23438 1.20313,0.=
14062 q -0.28125,1.0625 -1.0625,1.65625 -0.76563,0.57813 -1.96875,0.57813 -=
1.51563,0 -2.40625,-0.9375 -0.89063,-0.9375 -0.89063,-2.60938 0,-1.75 0.890=
63,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.39062,0 2.26562,0.9375 0.87=
5,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.15625 q 0.0625,1.14062 0.640=
63,1.75 0.57812,0.59375 1.4375,0.59375 0.65625,0 1.10937,-0.32813 0.45313,-=
0.34375 0.71875,-1.07812 z m -3.84375,-1.90625 h 3.85938 q -0.0781,-0.85938=
 -0.4375,-1.29688 -0.5625,-0.6875 -1.45313,-0.6875 -0.8125,0 -1.35937,0.546=
88 -0.54688,0.53125 -0.60938,1.4375 z m 10.36548,4.125 v -9.54688 h 1.29688=
 l 5.01562,7.5 v -7.5 h 1.20313 v 9.54688 h -1.29688 l -5.01562,-7.5 v 7.5 =
z m 12.75,-3.45313 q 0,-1.92187 1.07813,-2.84375 0.89062,-0.76562 2.17187,-=
0.76562 1.42188,0 2.32813,0.9375 0.90625,0.92187 0.90625,2.57812 0,1.32813 =
-0.40625,2.09375 -0.39063,0.76563 -1.15625,1.1875 -0.76563,0.42188 -1.67188=
,0.42188 -1.45312,0 -2.35937,-0.92188 -0.89063,-0.9375 -0.89063,-2.6875 z m=
 1.20313,0 q 0,1.32813 0.57812,1.98438 0.59375,0.65625 1.46875,0.65625 0.87=
5,0 1.45313,-0.65625 0.57812,-0.67188 0.57812,-2.03125 0,-1.28125 -0.59375,=
-1.9375 -0.57812,-0.65625 -1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.578=
12,0.65625 -0.57812,1.98437 z m 6.9281,3.45313 v -6 h -1.03125 v -0.90625 h=
 1.03125 v -0.73438 q 0,-0.70312 0.125,-1.04687 0.17187,-0.45313 0.59375,-0=
.73438 0.42187,-0.28125 1.20312,-0.28125 0.48438,0 1.09375,0.10938 l -0.187=
5,1.03125 q -0.35937,-0.0625 -0.6875,-0.0625 -0.53125,0 -0.75,0.23437 -0.21=
875,0.21875 -0.21875,0.84375 v 0.64063 h 1.34375 v 0.90625 h -1.34375 v 6 z=
 m 3.46209,0 v -6 h -1.03125 v -0.90625 h 1.03125 v -0.73438 q 0,-0.70312 0=
.125,-1.04687 0.17188,-0.45313 0.59375,-0.73438 0.42188,-0.28125 1.20313,-0=
.28125 0.48437,0 1.09375,0.10938 l -0.1875,1.03125 q -0.35938,-0.0625 -0.68=
75,-0.0625 -0.53125,0 -0.75,0.23437 -0.21875,0.21875 -0.21875,0.84375 v 0.6=
4063 h 1.34375 v 0.90625 h -1.34375 v 6 z m 2.95301,-2.0625 1.15625,-0.1875=
 q 0.10937,0.70312 0.54687,1.07812 0.45313,0.35938 1.25,0.35938 0.8125,0 1.=
20313,-0.32813 0.39062,-0.32812 0.39062,-0.76562 0,-0.39063 -0.35937,-0.625=
 -0.23438,-0.15625 -1.1875,-0.39063 -1.29688,-0.32812 -1.79688,-0.5625 -0.4=
8437,-0.25 -0.75,-0.65625 -0.25,-0.42187 -0.25,-0.9375 0,-0.45312 0.20313,-=
0.84375 0.21875,-0.40625 0.57812,-0.67187 0.28125,-0.1875 0.75,-0.32813 0.4=
6875,-0.14062 1.01563,-0.14062 0.8125,0 1.42187,0.23437 0.60938,0.23438 0.9=
0625,0.64063 0.29688,0.39062 0.40625,1.0625 l -1.14062,0.15625 q -0.0781,-0=
.53125 -0.45313,-0.82813 -0.375,-0.3125 -1.0625,-0.3125 -0.8125,0 -1.15625,=
0.26563 -0.34375,0.26562 -0.34375,0.625 0,0.23437 0.14063,0.42187 0.15625,0=
.1875 0.45312,0.3125 0.17188,0.0625 1.03125,0.29688 1.25,0.32812 1.73438,0.=
54687 0.5,0.20313 0.78125,0.60938 0.28125,0.40625 0.28125,1 0,0.59375 -0.34=
375,1.10937 -0.34375,0.51563 -1,0.79688 -0.64063,0.28125 -1.45313,0.28125 -=
1.34375,0 -2.04687,-0.5625 -0.70313,-0.5625 -0.90625,-1.65625 z m 11.86715,=
-0.15625 1.2032,0.14062 q -0.2813,1.0625 -1.0625,1.65625 -0.76567,0.57813 -=
1.96879,0.57813 -1.51563,0 -2.40625,-0.9375 -0.89063,-0.9375 -0.89063,-2.60=
938 0,-1.75 0.89063,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.39062,0 2.=
26559,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.15622 q 0.0=
625,1.14062 0.64063,1.75 0.57812,0.59375 1.4375,0.59375 0.65625,0 1.10937,-=
0.32813 0.45313,-0.34375 0.71872,-1.07812 z m -3.84372,-1.90625 h 3.85942 q=
 -0.078,-0.85938 -0.43754,-1.29688 -0.5625,-0.6875 -1.45313,-0.6875 -0.8125=
,0 -1.35937,0.54688 -0.54688,0.53125 -0.60938,1.4375 z m 9.08432,3.07812 0.=
1719,1.03125 q -0.5,0.10938 -0.8906,0.10938 -0.6406,0 -1,-0.20313 -0.3438,-=
0.20312 -0.4844,-0.53125 -0.1406,-0.32812 -0.1406,-1.39062 v -3.96875 h -0.=
8594 v -0.90625 h 0.8594 v -1.71875 l 1.1719,-0.70313 v 2.42188 h 1.1718 v =
0.90625 h -1.1718 v 4.04687 q 0,0.5 0.047,0.64063 0.062,0.14062 0.2031,0.23=
437 0.1406,0.0781 0.4062,0.0781 0.2032,0 0.5157,-0.0469 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path376" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       fill-opacity=3D"0"=0D
> -       d=3D"m 327.9666,40.550037 h 280.09449 v 27.46457 H 327.9666 Z"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path378" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 346.58571,59.006287 1.26562,0.3125 q -0.39062,1.5625 -1.42=
187,2.375 -1.03125,0.8125 -2.53125,0.8125 -1.53125,0 -2.5,-0.625 -0.96875,-=
0.625 -1.48438,-1.8125 -0.5,-1.1875 -0.5,-2.5625 0,-1.48438 0.5625,-2.59375=
 0.57813,-1.10938 1.625,-1.6875 1.0625,-0.57813 2.32813,-0.57813 1.42187,0 =
2.39062,0.73438 0.98438,0.71875 1.375,2.04687 l -1.25,0.29688 q -0.32812,-1=
.04688 -0.96875,-1.51563 -0.625,-0.48437 -1.57812,-0.48437 -1.09375,0 -1.84=
375,0.53125 -0.73438,0.53125 -1.03125,1.42187 -0.29688,0.875 -0.29688,1.828=
13 0,1.21875 0.34375,2.125 0.35938,0.90625 1.10938,1.35937 0.75,0.4375 1.62=
5,0.4375 1.0625,0 1.79687,-0.60937 0.73438,-0.60938 0.98438,-1.8125 z m 2.6=
8765,-4.84375 v -1.35938 h 1.17188 v 1.35938 z m 0,8.1875 v -6.90625 h 1.17=
188 v 6.90625 z m 2.92984,0 v -6.90625 h 1.0625 v 1.04687 q 0.40625,-0.7343=
7 0.73438,-0.96875 0.34375,-0.23437 0.76562,-0.23437 0.59375,0 1.20313,0.37=
5 l -0.40625,1.07812 q -0.4375,-0.25 -0.85938,-0.25 -0.39062,0 -0.70312,0.2=
3438 -0.29688,0.23437 -0.42188,0.64062 -0.20312,0.625 -0.20312,1.35938 v 3.=
625 z m 8.96964,-2.53125 1.15625,0.15625 q -0.1875,1.1875 -0.96875,1.85937 =
-0.78125,0.67188 -1.92188,0.67188 -1.40625,0 -2.28125,-0.92188 -0.85937,-0.=
9375 -0.85937,-2.65625 0,-1.125 0.375,-1.96875 0.375,-0.84375 1.125,-1.25 0=
.76562,-0.42187 1.65625,-0.42187 1.125,0 1.84375,0.57812 0.71875,0.5625 0.9=
2187,1.60938 l -1.14062,0.17187 q -0.17188,-0.70312 -0.59375,-1.04687 -0.40=
625,-0.35938 -0.98438,-0.35938 -0.89062,0 -1.45312,0.64063 -0.54688,0.64062=
 -0.54688,2 0,1.40625 0.53125,2.03125 0.54688,0.625 1.40625,0.625 0.6875,0 =
1.14063,-0.42188 0.46875,-0.42187 0.59375,-1.29687 z m 6.67969,2.53125 v -1=
.01563 q -0.8125,1.17188 -2.1875,1.17188 -0.60938,0 -1.14063,-0.23438 -0.53=
125,-0.23437 -0.79687,-0.57812 -0.25,-0.35938 -0.35938,-0.875 -0.0625,-0.34=
375 -0.0625,-1.09375 v -4.28125 h 1.17188 v 3.82812 q 0,0.92188 0.0625,1.23=
438 0.10937,0.46875 0.46875,0.73437 0.35937,0.25 0.89062,0.25 0.51563,0 0.9=
8438,-0.26562 0.46875,-0.26563 0.65625,-0.73438 0.1875,-0.46875 0.1875,-1.3=
4375 v -3.70312 h 1.17187 v 6.90625 z m 2.8656,0 v -9.54688 H 371.89 v 9.54=
688 z m 7.49234,-0.85938 q -0.65625,0.5625 -1.26563,0.79688 -0.59375,0.2187=
5 -1.28125,0.21875 -1.14062,0 -1.75,-0.54688 -0.60937,-0.5625 -0.60937,-1.4=
375 0,-0.5 0.21875,-0.92187 0.23437,-0.42188 0.60937,-0.67188 0.375,-0.25 0=
.84375,-0.39062 0.34375,-0.0781 1.04688,-0.17188 1.42187,-0.17187 2.09375,-=
0.40625 0,-0.23437 0,-0.29687 0,-0.71875 -0.32813,-1.01563 -0.45312,-0.3906=
2 -1.34375,-0.39062 -0.8125,0 -1.21875,0.29687 -0.39062,0.28125 -0.57812,1.=
01563 l -1.14063,-0.15625 q 0.15625,-0.73438 0.51563,-1.1875 0.35937,-0.453=
13 1.03125,-0.6875 0.67187,-0.25 1.5625,-0.25 0.89062,0 1.4375,0.20312 0.56=
25,0.20313 0.8125,0.53125 0.26562,0.3125 0.375,0.79688 0.0469,0.29687 0.046=
9,1.07812 v 1.5625 q 0,1.625 0.0781,2.0625 0.0781,0.4375 0.29687,0.82813 h =
-1.21875 q -0.1875,-0.35938 -0.23437,-0.85938 z m -0.0937,-2.60937 q -0.640=
63,0.26562 -1.92188,0.4375 -0.71875,0.10937 -1.01562,0.25 -0.29688,0.125 -0=
.46875,0.375 -0.15625,0.25 -0.15625,0.54687 0,0.46875 0.34375,0.78125 0.359=
37,0.3125 1.04687,0.3125 0.67188,0 1.20313,-0.29687 0.53125,-0.29688 0.7812=
5,-0.8125 0.1875,-0.39063 0.1875,-1.17188 z m 2.97497,3.46875 v -6.90625 h =
1.0625 v 1.04687 q 0.40625,-0.73437 0.73438,-0.96875 0.34375,-0.23437 0.765=
62,-0.23437 0.59375,0 1.20313,0.375 l -0.40625,1.07812 q -0.4375,-0.25 -0.8=
5938,-0.25 -0.39062,0 -0.70312,0.23438 -0.29688,0.23437 -0.42188,0.64062 -0=
.20312,0.625 -0.20312,1.35938 v 3.625 z m 8.15698,0 v -6.90625 h 1.04688 v =
0.96875 q 0.32812,-0.51563 0.85937,-0.8125 0.54688,-0.3125 1.23438,-0.3125 =
0.78125,0 1.26562,0.3125 0.48438,0.3125 0.6875,0.89062 0.82813,-1.20312 2.1=
4063,-1.20312 1.03125,0 1.57812,0.57812 0.5625,0.5625 0.5625,1.73438 v 4.75=
 h -1.17187 v -4.35938 q 0,-0.70312 -0.125,-1 -0.10938,-0.3125 -0.40625,-0.=
5 -0.29688,-0.1875 -0.70313,-0.1875 -0.71875,0 -1.20312,0.48438 -0.48438,0.=
48437 -0.48438,1.54687 v 4.01563 h -1.17187 v -4.48438 q 0,-0.78125 -0.2968=
8,-1.17187 -0.28125,-0.39063 -0.92187,-0.39063 -0.5,0 -0.92188,0.26563 -0.4=
2187,0.25 -0.60937,0.75 -0.1875,0.5 -0.1875,1.45312 v 3.57813 z m 15.8368,-=
2.21875 1.20312,0.14062 q -0.28125,1.0625 -1.0625,1.65625 -0.76562,0.57813 =
-1.96875,0.57813 -1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375 -0.89062,-2.6=
0938 0,-1.75 0.89062,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.39063,0 2=
.26563,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.15625 q 0.=
0625,1.14062 0.64062,1.75 0.57813,0.59375 1.4375,0.59375 0.65625,0 1.10938,=
-0.32813 0.45312,-0.34375 0.71875,-1.07812 z m -3.84375,-1.90625 h 3.85937 =
q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.45312,-0.6875 -0.812=
5,0 -1.35938,0.54688 -0.54687,0.53125 -0.60937,1.4375 z m 6.52185,4.125 v -=
6.90625 h 1.04687 v 0.96875 q 0.32813,-0.51563 0.85938,-0.8125 0.54687,-0.3=
125 1.23437,-0.3125 0.78125,0 1.26563,0.3125 0.48437,0.3125 0.6875,0.89062 =
0.82812,-1.20312 2.14062,-1.20312 1.03125,0 1.57813,0.57812 0.5625,0.5625 0=
.5625,1.73438 v 4.75 h -1.17188 v -4.35938 q 0,-0.70312 -0.125,-1 -0.10937,=
-0.3125 -0.40625,-0.5 -0.29687,-0.1875 -0.70312,-0.1875 -0.71875,0 -1.20313=
,0.48438 -0.48437,0.48437 -0.48437,1.54687 v 4.01563 h -1.17188 v -4.48438 =
q 0,-0.78125 -0.29687,-1.17187 -0.28125,-0.39063 -0.92188,-0.39063 -0.5,0 -=
0.92187,0.26563 -0.42188,0.25 -0.60938,0.75 -0.1875,0.5 -0.1875,1.45312 v 3=
.57813 z m 10.66494,-3.45313 q 0,-1.92187 1.07813,-2.84375 0.89062,-0.76562=
 2.17187,-0.76562 1.42188,0 2.32813,0.9375 0.90625,0.92187 0.90625,2.57812 =
0,1.32813 -0.40625,2.09375 -0.39063,0.76563 -1.15625,1.1875 -0.76563,0.4218=
8 -1.67188,0.42188 -1.45312,0 -2.35937,-0.92188 -0.89063,-0.9375 -0.89063,-=
2.6875 z m 1.20313,0 q 0,1.32813 0.57812,1.98438 0.59375,0.65625 1.46875,0.=
65625 0.875,0 1.45313,-0.65625 0.57812,-0.67188 0.57812,-2.03125 0,-1.28125=
 -0.59375,-1.9375 -0.57812,-0.65625 -1.4375,-0.65625 -0.875,0 -1.46875,0.65=
625 -0.57812,0.65625 -0.57812,1.98437 z m 6.63122,3.45313 v -6.90625 h 1.06=
25 v 1.04687 q 0.40625,-0.73437 0.73438,-0.96875 0.34375,-0.23437 0.76562,-=
0.23437 0.59375,0 1.20313,0.375 l -0.40625,1.07812 q -0.4375,-0.25 -0.85938=
,-0.25 -0.39062,0 -0.70312,0.23438 -0.29688,0.23437 -0.42188,0.64062 -0.203=
12,0.625 -0.20312,1.35938 v 3.625 z m 4.40711,2.65625 -0.125,-1.09375 q 0.3=
75,0.10937 0.65625,0.10937 0.39062,0 0.625,-0.14062 0.23437,-0.125 0.39062,=
-0.35938 0.10938,-0.17187 0.35938,-0.875 0.0312,-0.0937 0.10937,-0.28125 l =
-2.625,-6.92187 h 1.26563 l 1.4375,4 q 0.28125,0.76562 0.5,1.59375 0.20312,=
-0.79688 0.46875,-1.57813 l 1.48437,-4.01562 h 1.17188 l -2.625,7.01562 q -=
0.42188,1.14063 -0.65625,1.57813 -0.3125,0.57812 -0.71875,0.84375 -0.40625,=
0.28125 -0.96875,0.28125 -0.32813,0 -0.75,-0.15625 z m 10.39831,-2.65625 v =
-9.54688 h 1.17188 v 9.54688 z m 7.49234,-0.85938 q -0.65625,0.5625 -1.2656=
2,0.79688 -0.59375,0.21875 -1.28125,0.21875 -1.14063,0 -1.75,-0.54688 -0.60=
938,-0.5625 -0.60938,-1.4375 0,-0.5 0.21875,-0.92187 0.23438,-0.42188 0.609=
38,-0.67188 0.375,-0.25 0.84375,-0.39062 0.34375,-0.0781 1.04687,-0.17188 1=
.42188,-0.17187 2.09375,-0.40625 0,-0.23437 0,-0.29687 0,-0.71875 -0.32812,=
-1.01563 -0.45313,-0.39062 -1.34375,-0.39062 -0.8125,0 -1.21875,0.29687 -0.=
39063,0.28125 -0.57813,1.01563 l -1.14062,-0.15625 q 0.15625,-0.73438 0.515=
62,-1.1875 0.35938,-0.45313 1.03125,-0.6875 0.67188,-0.25 1.5625,-0.25 0.89=
063,0 1.4375,0.20312 0.5625,0.20313 0.8125,0.53125 0.26563,0.3125 0.375,0.7=
9688 0.0469,0.29687 0.0469,1.07812 v 1.5625 q 0,1.625 0.0781,2.0625 0.0781,=
0.4375 0.29688,0.82813 h -1.21875 q -0.1875,-0.35938 -0.23438,-0.85938 z m =
-0.0937,-2.60937 q -0.64062,0.26562 -1.92187,0.4375 -0.71875,0.10937 -1.015=
63,0.25 -0.29687,0.125 -0.46875,0.375 -0.15625,0.25 -0.15625,0.54687 0,0.46=
875 0.34375,0.78125 0.35938,0.3125 1.04688,0.3125 0.67187,0 1.20312,-0.2968=
7 0.53125,-0.29688 0.78125,-0.8125 0.1875,-0.39063 0.1875,-1.17188 z m 2.94=
373,6.125 -0.125,-1.09375 q 0.375,0.10937 0.65625,0.10937 0.39062,0 0.625,-=
0.14062 0.23437,-0.125 0.39062,-0.35938 0.10938,-0.17187 0.35938,-0.875 0.0=
312,-0.0937 0.10937,-0.28125 l -2.625,-6.92187 h 1.26563 l 1.4375,4 q 0.281=
25,0.76562 0.5,1.59375 0.20312,-0.79688 0.46875,-1.57813 l 1.48437,-4.01562=
 h 1.17188 l -2.625,7.01562 q -0.42188,1.14063 -0.65625,1.57813 -0.3125,0.5=
7812 -0.71875,0.84375 -0.40625,0.28125 -0.96875,0.28125 -0.32813,0 -0.75,-0=
.15625 z m 6.27344,-6.10938 q 0,-1.92187 1.07812,-2.84375 0.89063,-0.76562 =
2.17188,-0.76562 1.42187,0 2.32812,0.9375 0.90625,0.92187 0.90625,2.57812 0=
,1.32813 -0.40625,2.09375 -0.39062,0.76563 -1.15625,1.1875 -0.76562,0.42188=
 -1.67187,0.42188 -1.45313,0 -2.35938,-0.92188 -0.89062,-0.9375 -0.89062,-2=
.6875 z m 1.20312,0 q 0,1.32813 0.57813,1.98438 0.59375,0.65625 1.46875,0.6=
5625 0.875,0 1.45312,-0.65625 0.57813,-0.67188 0.57813,-2.03125 0,-1.28125 =
-0.59375,-1.9375 -0.57813,-0.65625 -1.4375,-0.65625 -0.875,0 -1.46875,0.656=
25 -0.57813,0.65625 -0.57813,1.98437 z m 11.1781,3.45313 v -1.01563 q -0.81=
25,1.17188 -2.1875,1.17188 -0.60937,0 -1.14062,-0.23438 -0.53125,-0.23437 -=
0.79688,-0.57812 -0.25,-0.35938 -0.35937,-0.875 -0.0625,-0.34375 -0.0625,-1=
.09375 v -4.28125 h 1.17187 v 3.82812 q 0,0.92188 0.0625,1.23438 0.10938,0.=
46875 0.46875,0.73437 0.35938,0.25 0.89063,0.25 0.51562,0 0.98437,-0.26562 =
0.46875,-0.26563 0.65625,-0.73438 0.1875,-0.46875 0.1875,-1.34375 v -3.7031=
2 h 1.17188 v 6.90625 z m 5.44373,-1.04688 0.17187,1.03125 q -0.5,0.10938 -=
0.89062,0.10938 -0.64063,0 -1,-0.20313 -0.34375,-0.20312 -0.48438,-0.53125 =
-0.14062,-0.32812 -0.14062,-1.39062 v -3.96875 h -0.85938 v -0.90625 h 0.85=
938 v -1.71875 l 1.17187,-0.70313 v 2.42188 h 1.17188 v 0.90625 h -1.17188 =
v 4.04687 q 0,0.5 0.0469,0.64063 0.0625,0.14062 0.20312,0.23437 0.14063,0.0=
781 0.40625,0.0781 0.20313,0 0.51563,-0.0469 z m 5.12472,1.04688 v -6 h -1.=
03125 v -0.90625 h 1.03125 v -0.73438 q 0,-0.70312 0.125,-1.04687 0.17188,-=
0.45313 0.59375,-0.73438 0.42188,-0.28125 1.20313,-0.28125 0.48437,0 1.0937=
5,0.10938 l -0.1875,1.03125 q -0.35938,-0.0625 -0.6875,-0.0625 -0.53125,0 -=
0.75,0.23437 -0.21875,0.21875 -0.21875,0.84375 v 0.64063 h 1.34375 v 0.9062=
5 h -1.34375 v 6 z m 2.98423,-3.45313 q 0,-1.92187 1.07812,-2.84375 0.89063=
,-0.76562 2.17188,-0.76562 1.42187,0 2.32812,0.9375 0.90625,0.92187 0.90625=
,2.57812 0,1.32813 -0.40625,2.09375 -0.39062,0.76563 -1.15625,1.1875 -0.765=
62,0.42188 -1.67187,0.42188 -1.45313,0 -2.35938,-0.92188 -0.89062,-0.9375 -=
0.89062,-2.6875 z m 1.20312,0 q 0,1.32813 0.57813,1.98438 0.59375,0.65625 1=
.46875,0.65625 0.875,0 1.45312,-0.65625 0.57813,-0.67188 0.57813,-2.03125 0=
,-1.28125 -0.59375,-1.9375 -0.57813,-0.65625 -1.4375,-0.65625 -0.875,0 -1.4=
6875,0.65625 -0.57813,0.65625 -0.57813,1.98437 z m 6.63123,3.45313 v -6.906=
25 h 1.0625 v 1.04687 q 0.40625,-0.73437 0.73437,-0.96875 0.34375,-0.23437 =
0.76563,-0.23437 0.59375,0 1.20312,0.375 l -0.40625,1.07812 q -0.4375,-0.25=
 -0.85937,-0.25 -0.39063,0 -0.70313,0.23438 -0.29687,0.23437 -0.42187,0.640=
62 -0.20313,0.625 -0.20313,1.35938 v 3.625 z m 8.15698,2.65625 v -9.5625 h =
1.07812 v 0.89062 q 0.375,-0.53125 0.84375,-0.78125 0.48438,-0.26562 1.1562=
5,-0.26562 0.875,0 1.54688,0.45312 0.68752,0.45313 1.03122,1.28125 0.3438,0=
.82813 0.3438,1.82813 0,1.04687 -0.375,1.90625 -0.375,0.84375 -1.1094,1.296=
87 -0.71875,0.45313 -1.53125,0.45313 -0.57812,0 -1.04687,-0.25 -0.46875,-0.=
25 -0.76563,-0.625 v 3.375 z m 1.0625,-6.07813 q 0,1.34375 0.53125,1.98438 =
0.54687,0.625 1.3125,0.625 0.78125,0 1.34375,-0.65625 0.5625,-0.65625 0.562=
5,-2.04688 0,-1.3125 -0.54688,-1.96875 -0.54687,-0.67187 -1.29687,-0.67187 =
-0.75,0 -1.32813,0.70312 -0.57812,0.70313 -0.57812,2.03125 z m 11.08432,1.2=
0313 1.2031,0.14062 q -0.2812,1.0625 -1.0625,1.65625 -0.7656,0.57813 -1.968=
7,0.57813 -1.5156,0 -2.4063,-0.9375 -0.8906,-0.9375 -0.8906,-2.60938 0,-1.7=
5 0.8906,-2.70312 0.9063,-0.96875 2.3438,-0.96875 1.3906,0 2.2656,0.9375 0.=
875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.1562 q 0.062,1.14062 0.640=
6,1.75 0.5781,0.59375 1.4375,0.59375 0.6562,0 1.1094,-0.32813 0.4531,-0.343=
75 0.7187,-1.07812 z m -3.8437,-1.90625 h 3.8593 q -0.078,-0.85938 -0.4375,=
-1.29688 -0.5625,-0.6875 -1.4531,-0.6875 -0.8125,0 -1.3594,0.54688 -0.5468,=
0.53125 -0.6093,1.4375 z m 6.5219,4.125 v -6.90625 h 1.0625 v 0.98437 q 0.7=
5,-1.14062 2.1875,-1.14062 0.625,0 1.1562,0.21875 0.5313,0.21875 0.7813,0.5=
9375 0.2656,0.35937 0.375,0.85937 0.062,0.32813 0.062,1.14063 v 4.25 h -1.1=
719 v -4.20313 q 0,-0.71875 -0.1406,-1.0625 -0.1407,-0.35937 -0.4844,-0.562=
5 -0.3438,-0.21875 -0.8125,-0.21875 -0.75,0 -1.2969,0.46875 -0.5469,0.46875=
 -0.5469,1.79688 v 3.78125 z m 11.8968,0 v -0.875 q -0.6562,1.03125 -1.9375=
,1.03125 -0.8125,0 -1.5156,-0.45313 -0.6875,-0.45312 -1.0781,-1.26562 -0.37=
5,-0.82813 -0.375,-1.89063 0,-1.03125 0.3437,-1.875 0.3438,-0.84375 1.0313,=
-1.28125 0.7031,-0.45312 1.5468,-0.45312 0.625,0 1.1094,0.26562 0.5,0.25 0.=
7969,0.67188 v -3.42188 h 1.1719 v 9.54688 z m -3.7031,-3.45313 q 0,1.32813=
 0.5625,1.98438 0.5625,0.65625 1.3281,0.65625 0.7656,0 1.2969,-0.625 0.5312=
,-0.625 0.5312,-1.90625 0,-1.42188 -0.5468,-2.07813 -0.5469,-0.67187 -1.343=
8,-0.67187 -0.7812,0 -1.3125,0.64062 -0.5156,0.625 -0.5156,2 z m 6.6468,-4.=
73437 v -1.35938 h 1.1719 v 1.35938 z m 0,8.1875 v -6.90625 h 1.1719 v 6.90=
625 z m 2.9455,0 v -6.90625 h 1.0625 v 0.98437 q 0.75,-1.14062 2.1875,-1.14=
062 0.625,0 1.1562,0.21875 0.5313,0.21875 0.7813,0.59375 0.2656,0.35937 0.3=
75,0.85937 0.062,0.32813 0.062,1.14063 v 4.25 h -1.1719 v -4.20313 q 0,-0.7=
1875 -0.1406,-1.0625 -0.1407,-0.35937 -0.4844,-0.5625 -0.3438,-0.21875 -0.8=
125,-0.21875 -0.75,0 -1.2969,0.46875 -0.5469,0.46875 -0.5469,1.79688 v 3.78=
125 z m 7.1937,0.57812 1.1406,0.15625 q 0.078,0.53125 0.4063,0.78125 0.4375=
,0.3125 1.1875,0.3125 0.8125,0 1.25,-0.32812 0.4531,-0.3125 0.6093,-0.90625=
 0.094,-0.35938 0.078,-1.5 -0.7656,0.90625 -1.9062,0.90625 -1.4375,0 -2.218=
8,-1.03125 -0.7812,-1.03125 -0.7812,-2.46875 0,-0.98438 0.3594,-1.8125 0.35=
93,-0.84375 1.0312,-1.29688 0.6875,-0.45312 1.6094,-0.45312 1.2187,0 2.0156=
,0.98437 v -0.82812 h 1.0781 v 5.96875 q 0,1.60937 -0.3281,2.28125 -0.3281,=
0.6875 -1.0469,1.07812 -0.7031,0.39063 -1.75,0.39063 -1.2343,0 -2,-0.5625 -=
0.75,-0.5625 -0.7343,-1.67188 z m 0.9844,-4.15625 q 0,1.35938 0.5312,1.9843=
8 0.5469,0.625 1.3594,0.625 0.7969,0 1.3437,-0.625 0.5469,-0.625 0.5469,-1.=
95313 0,-1.26562 -0.5625,-1.90625 -0.5625,-0.64062 -1.3594,-0.64062 -0.7656=
,0 -1.3125,0.64062 -0.5468,0.625 -0.5468,1.875 z m 9.8811,1.51563 1.1562,-0=
.1875 q 0.1094,0.70312 0.5469,1.07812 0.4531,0.35938 1.25,0.35938 0.8125,0 =
1.2031,-0.32813 0.3907,-0.32812 0.3907,-0.76562 0,-0.39063 -0.3594,-0.625 -=
0.2344,-0.15625 -1.1875,-0.39063 -1.2969,-0.32812 -1.7969,-0.5625 -0.4844,-=
0.25 -0.75,-0.65625 -0.25,-0.42187 -0.25,-0.9375 0,-0.45312 0.2031,-0.84375=
 0.2188,-0.40625 0.5782,-0.67187 0.2812,-0.1875 0.75,-0.32813 0.4687,-0.140=
62 1.0156,-0.14062 0.8125,0 1.4219,0.23437 0.6093,0.23438 0.9062,0.64063 0.=
2969,0.39062 0.4063,1.0625 l -1.1407,0.15625 q -0.078,-0.53125 -0.4531,-0.8=
2813 -0.375,-0.3125 -1.0625,-0.3125 -0.8125,0 -1.1562,0.26563 -0.3438,0.265=
62 -0.3438,0.625 0,0.23437 0.1406,0.42187 0.1563,0.1875 0.4532,0.3125 0.171=
8,0.0625 1.0312,0.29688 1.25,0.32812 1.7344,0.54687 0.5,0.20313 0.7812,0.60=
938 0.2813,0.40625 0.2813,1 0,0.59375 -0.3438,1.10937 -0.3437,0.51563 -1,0.=
79688 -0.6406,0.28125 -1.4531,0.28125 -1.3437,0 -2.0469,-0.5625 -0.7031,-0.=
5625 -0.9062,-1.65625 z m 9.6953,1.01562 0.1719,1.03125 q -0.5,0.10938 -0.8=
907,0.10938 -0.6406,0 -1,-0.20313 -0.3437,-0.20312 -0.4843,-0.53125 -0.1407=
,-0.32812 -0.1407,-1.39062 v -3.96875 h -0.8593 v -0.90625 h 0.8593 v -1.71=
875 l 1.1719,-0.70313 v 2.42188 h 1.1719 v 0.90625 h -1.1719 v 4.04687 q 0,=
0.5 0.047,0.64063 0.062,0.14062 0.2031,0.23437 0.1407,0.0781 0.4063,0.0781 =
0.2031,0 0.5156,-0.0469 z m 1.1249,1.04688 v -6.90625 h 1.0625 v 1.04687 q =
0.4062,-0.73437 0.7343,-0.96875 0.3438,-0.23437 0.7657,-0.23437 0.5937,0 1.=
2031,0.375 l -0.4063,1.07812 q -0.4375,-0.25 -0.8593,-0.25 -0.3907,0 -0.703=
2,0.23438 -0.2968,0.23437 -0.4218,0.64062 -0.2032,0.625 -0.2032,1.35938 v 3=
.625 z m 9.1883,-2.21875 1.2031,0.14062 q -0.2812,1.0625 -1.0625,1.65625 -0=
.7656,0.57813 -1.9687,0.57813 -1.5156,0 -2.4063,-0.9375 -0.8906,-0.9375 -0.=
8906,-2.60938 0,-1.75 0.8906,-2.70312 0.9063,-0.96875 2.3438,-0.96875 1.390=
6,0 2.2656,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.1562 q=
 0.062,1.14062 0.6406,1.75 0.5781,0.59375 1.4375,0.59375 0.6562,0 1.1094,-0=
.32813 0.4531,-0.34375 0.7187,-1.07812 z m -3.8437,-1.90625 h 3.8593 q -0.0=
78,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.4531,-0.6875 -0.8125,0 -1.3=
594,0.54688 -0.5468,0.53125 -0.6093,1.4375 z m 11.0374,3.26562 q -0.6562,0.=
5625 -1.2656,0.79688 -0.5937,0.21875 -1.2812,0.21875 -1.1407,0 -1.75,-0.546=
88 -0.6094,-0.5625 -0.6094,-1.4375 0,-0.5 0.2187,-0.92187 0.2344,-0.42188 0=
.6094,-0.67188 0.375,-0.25 0.8438,-0.39062 0.3437,-0.0781 1.0468,-0.17188 1=
.4219,-0.17187 2.0938,-0.40625 0,-0.23437 0,-0.29687 0,-0.71875 -0.3281,-1.=
01563 -0.4532,-0.39062 -1.3438,-0.39062 -0.8125,0 -1.2187,0.29687 -0.3907,0=
.28125 -0.5782,1.01563 l -1.1406,-0.15625 q 0.1563,-0.73438 0.5156,-1.1875 =
0.3594,-0.45313 1.0313,-0.6875 0.6719,-0.25 1.5625,-0.25 0.8906,0 1.4375,0.=
20312 0.5625,0.20313 0.8125,0.53125 0.2656,0.3125 0.375,0.79688 0.047,0.296=
87 0.047,1.07812 v 1.5625 q 0,1.625 0.078,2.0625 0.078,0.4375 0.2969,0.8281=
3 h -1.2188 q -0.1875,-0.35938 -0.2344,-0.85938 z m -0.094,-2.60937 q -0.64=
06,0.26562 -1.9218,0.4375 -0.7188,0.10937 -1.0157,0.25 -0.2968,0.125 -0.468=
7,0.375 -0.1563,0.25 -0.1563,0.54687 0,0.46875 0.3438,0.78125 0.3594,0.3125=
 1.0469,0.3125 0.6718,0 1.2031,-0.29687 0.5312,-0.29688 0.7812,-0.8125 0.18=
75,-0.39063 0.1875,-1.17188 z m 2.9906,3.46875 v -6.90625 h 1.0469 v 0.9687=
5 q 0.3281,-0.51563 0.8594,-0.8125 0.5469,-0.3125 1.2344,-0.3125 0.7812,0 1=
.2656,0.3125 0.4844,0.3125 0.6875,0.89062 0.8281,-1.20312 2.1406,-1.20312 1=
.0313,0 1.5781,0.57812 0.5625,0.5625 0.5625,1.73438 v 4.75 h -1.1718 v -4.3=
5938 q 0,-0.70312 -0.125,-1 -0.1094,-0.3125 -0.4063,-0.5 -0.2969,-0.1875 -0=
.7031,-0.1875 -0.7188,0 -1.2031,0.48438 -0.4844,0.48437 -0.4844,1.54687 v 4=
.01563 h -1.1719 v -4.48438 q 0,-0.78125 -0.2969,-1.17187 -0.2812,-0.39063 =
-0.9218,-0.39063 -0.5,0 -0.9219,0.26563 -0.4219,0.25 -0.6094,0.75 -0.1875,0=
.5 -0.1875,1.45312 v 3.57813 z m 10.6337,-2.0625 1.1563,-0.1875 q 0.1093,0.=
70312 0.5468,1.07812 0.4532,0.35938 1.25,0.35938 0.8125,0 1.2032,-0.32813 0=
.3906,-0.32812 0.3906,-0.76562 0,-0.39063 -0.3594,-0.625 -0.2344,-0.15625 -=
1.1875,-0.39063 -1.2969,-0.32812 -1.7969,-0.5625 -0.4843,-0.25 -0.75,-0.656=
25 -0.25,-0.42187 -0.25,-0.9375 0,-0.45312 0.2032,-0.84375 0.2187,-0.40625 =
0.5781,-0.67187 0.2812,-0.1875 0.75,-0.32813 0.4687,-0.14062 1.0156,-0.1406=
2 0.8125,0 1.4219,0.23437 0.6094,0.23438 0.9062,0.64063 0.2969,0.39062 0.40=
63,1.0625 l -1.1406,0.15625 q -0.078,-0.53125 -0.4532,-0.82813 -0.375,-0.31=
25 -1.0625,-0.3125 -0.8125,0 -1.1562,0.26563 -0.3438,0.26562 -0.3438,0.625 =
0,0.23437 0.1407,0.42187 0.1562,0.1875 0.4531,0.3125 0.1719,0.0625 1.0312,0=
.29688 1.25,0.32812 1.7344,0.54687 0.5,0.20313 0.7813,0.60938 0.2812,0.4062=
5 0.2812,1 0,0.59375 -0.3437,1.10937 -0.3438,0.51563 -1,0.79688 -0.6407,0.2=
8125 -1.4532,0.28125 -1.3437,0 -2.0468,-0.5625 -0.7032,-0.5625 -0.9063,-1.6=
5625 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path380"=0D
> -       style=3D"fill:#88aa00" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       fill-opacity=3D"0"=0D
> -       d=3D"m 517.42329,154.1406 h 115.4646 v 27.46455 h -115.4646 z"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path382" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 533.48579,171.64496 1.125,0.29687 q -0.3594,1.39063 -1.281=
3,2.125 -0.9218,0.73438 -2.2656,0.73438 -1.3906,0 -2.2656,-0.5625 -0.875,-0=
.5625 -1.3281,-1.625 -0.4532,-1.07813 -0.4532,-2.3125 0,-1.34375 0.5157,-2.=
34375 0.5156,-1 1.4531,-1.51563 0.9531,-0.51562 2.0937,-0.51562 1.2813,0 2.=
1563,0.65625 0.8906,0.65625 1.2344,1.84375 l -1.125,0.26562 q -0.2969,-0.93=
75 -0.875,-1.35937 -0.5625,-0.4375 -1.4219,-0.4375 -0.9844,0 -1.6563,0.4843=
7 -0.6562,0.46875 -0.9375,1.26563 -0.2656,0.79687 -0.2656,1.65625 0,1.09375=
 0.3125,1.90625 0.3281,0.8125 1,1.21875 0.6719,0.40625 1.4688,0.40625 0.953=
1,0 1.6093,-0.54688 0.6719,-0.54687 0.9063,-1.64062 z m 2.4004,-4.35938 v -=
1.21875 h 1.0625 v 1.21875 z m 0,7.375 v -6.21875 h 1.0625 v 6.21875 z m 2.=
6504,0 v -6.21875 h 0.9531 v 0.9375 q 0.3594,-0.65625 0.6563,-0.85937 0.312=
5,-0.21875 0.6875,-0.21875 0.5312,0 1.0781,0.32812 l -0.3594,0.98438 q -0.3=
906,-0.23438 -0.7656,-0.23438 -0.3594,0 -0.6406,0.21875 -0.2657,0.20313 -0.=
375,0.57813 -0.1875,0.5625 -0.1875,1.21875 v 3.26562 z m 8.0742,-2.28125 1.=
0312,0.14063 q -0.1718,1.0625 -0.875,1.67187 -0.7031,0.60938 -1.7187,0.6093=
8 -1.2813,0 -2.0625,-0.82813 -0.7656,-0.84375 -0.7656,-2.40625 0,-1 0.3281,=
-1.75 0.3437,-0.76562 1.0156,-1.14062 0.6875,-0.375 1.5,-0.375 1,0 1.6406,0=
.51562 0.6563,0.5 0.8438,1.45313 l -1.0313,0.15625 q -0.1406,-0.625 -0.5156=
,-0.9375 -0.375,-0.32813 -0.9062,-0.32813 -0.7969,0 -1.2969,0.57813 -0.5,0.=
5625 -0.5,1.79687 0,1.26563 0.4844,1.82813 0.4843,0.5625 1.25,0.5625 0.625,=
0 1.0312,-0.375 0.4219,-0.375 0.5469,-1.17188 z m 6.0156,2.28125 v -0.92187=
 q -0.7344,1.0625 -1.9844,1.0625 -0.5468,0 -1.0312,-0.20313 -0.4688,-0.2187=
5 -0.7031,-0.53125 -0.2344,-0.32812 -0.3282,-0.79687 -0.062,-0.29688 -0.062=
,-0.98438 v -3.84375 h 1.0625 v 3.45313 q 0,0.8125 0.062,1.10937 0.094,0.40=
625 0.4063,0.65625 0.3281,0.23438 0.8125,0.23438 0.4687,0 0.875,-0.23438 0.=
4219,-0.25 0.5937,-0.67187 0.1875,-0.42188 0.1875,-1.21875 v -3.32813 h 1.0=
469 v 6.21875 z m 2.5645,0 v -8.59375 h 1.0625 v 8.59375 z m 6.7597,-0.7656=
2 q -0.5937,0.5 -1.1406,0.70312 -0.5312,0.20313 -1.1562,0.20313 -1.0313,0 -=
1.5782,-0.5 -0.5468,-0.5 -0.5468,-1.28125 0,-0.45313 0.2031,-0.82813 0.2031=
,-0.39062 0.5469,-0.60937 0.3437,-0.23438 0.7656,-0.34375 0.2969,-0.0937 0.=
9375,-0.17188 1.2656,-0.14062 1.875,-0.35937 0,-0.21875 0,-0.26563 0,-0.656=
25 -0.2969,-0.92187 -0.4062,-0.34375 -1.2031,-0.34375 -0.7344,0 -1.0938,0.2=
6562 -0.3593,0.25 -0.5312,0.90625 l -1.0313,-0.14062 q 0.1407,-0.65625 0.46=
88,-1.0625 0.3281,-0.40625 0.9375,-0.625 0.6094,-0.21875 1.4062,-0.21875 0.=
7969,0 1.2969,0.1875 0.5,0.1875 0.7344,0.46875 0.2344,0.28125 0.3281,0.7187=
5 0.047,0.26562 0.047,0.96875 v 1.40625 q 0,1.46875 0.062,1.85937 0.078,0.3=
9063 0.2813,0.75 h -1.1094 q -0.1563,-0.32812 -0.2031,-0.76562 z m -0.094,-=
2.35938 q -0.5781,0.23438 -1.7187,0.40625 -0.6563,0.0937 -0.9219,0.21875 -0=
.2656,0.10938 -0.4219,0.32813 -0.1406,0.21875 -0.1406,0.5 0,0.42187 0.3125,=
0.70312 0.3281,0.28125 0.9375,0.28125 0.6094,0 1.0781,-0.26562 0.4844,-0.26=
563 0.7032,-0.73438 0.1718,-0.35937 0.1718,-1.04687 z m 2.6895,3.125 v -6.2=
1875 h 0.9531 v 0.9375 q 0.3594,-0.65625 0.6563,-0.85937 0.3125,-0.21875 0.=
6875,-0.21875 0.5312,0 1.0781,0.32812 l -0.3594,0.98438 q -0.3906,-0.23438 =
-0.7656,-0.23438 -0.3594,0 -0.6406,0.21875 -0.2657,0.20313 -0.375,0.57813 -=
0.1875,0.5625 -0.1875,1.21875 v 3.26562 z m 8.3144,0 h -0.9843 v -8.59375 h=
 1.0625 v 3.0625 q 0.6718,-0.82812 1.7031,-0.82812 0.5781,0 1.0781,0.23437 =
0.5156,0.21875 0.8438,0.64063 0.3437,0.42187 0.5312,1.01562 0.1875,0.59375 =
0.1875,1.26563 0,1.59375 -0.7969,2.46875 -0.7968,0.875 -1.8906,0.875 -1.109=
4,0 -1.7344,-0.92188 z m -0.016,-3.15625 q 0,1.10938 0.3125,1.60938 0.5,0.8=
125 1.3438,0.8125 0.6875,0 1.1875,-0.59375 0.5156,-0.59375 0.5156,-1.79688 =
0,-1.21875 -0.4844,-1.79687 -0.4843,-0.57813 -1.1718,-0.57813 -0.6875,0 -1.=
2032,0.60938 -0.5,0.59375 -0.5,1.73437 z m 9.7989,3.15625 v -0.92187 q -0.7=
344,1.0625 -1.9844,1.0625 -0.5469,0 -1.0313,-0.20313 -0.4687,-0.21875 -0.70=
31,-0.53125 -0.2344,-0.32812 -0.3281,-0.79687 -0.062,-0.29688 -0.062,-0.984=
38 v -3.84375 h 1.0625 v 3.45313 q 0,0.8125 0.062,1.10937 0.094,0.40625 0.4=
062,0.65625 0.3282,0.23438 0.8125,0.23438 0.4688,0 0.875,-0.23438 0.4219,-0=
.25 0.5938,-0.67187 0.1875,-0.42188 0.1875,-1.21875 v -3.32813 h 1.0469 v 6=
.21875 z m 2.8457,0 v -5.40625 h -0.9375 v -0.8125 h 0.9375 v -0.67187 q 0,=
-0.625 0.1093,-0.92188 0.1563,-0.42187 0.5313,-0.67187 0.3906,-0.25 1.0781,=
-0.25 0.4531,0 0.9844,0.10937 l -0.1563,0.90625 q -0.3281,-0.0469 -0.625,-0=
.0469 -0.4843,0 -0.6875,0.20312 -0.1875,0.20313 -0.1875,0.76563 v 0.57812 h=
 1.2188 v 0.8125 h -1.2188 v 5.40625 z m 5.9961,-1.85937 1.0312,-0.15625 q =
0.094,0.625 0.4844,0.95312 0.4062,0.32813 1.1406,0.32813 0.7188,0 1.0625,-0=
.28125 0.3594,-0.29688 0.3594,-0.70313 0,-0.35937 -0.3125,-0.5625 -0.2188,-=
0.14062 -1.0781,-0.35937 -1.1563,-0.29688 -1.6094,-0.5 -0.4375,-0.21875 -0.=
6719,-0.59375 -0.2344,-0.375 -0.2344,-0.84375 0,-0.40625 0.1875,-0.76563 0.=
1875,-0.35937 0.5157,-0.59375 0.25,-0.17187 0.6718,-0.29687 0.4219,-0.125 0=
.9219,-0.125 0.7188,0 1.2656,0.21875 0.5625,0.20312 0.8282,0.5625 0.2656,0.=
35937 0.3593,0.95312 l -1.0312,0.14063 q -0.062,-0.46875 -0.4063,-0.73438 -=
0.3281,-0.28125 -0.9531,-0.28125 -0.7187,0 -1.0312,0.25 -0.3125,0.23438 -0.=
3125,0.5625 0,0.20313 0.125,0.35938 0.1406,0.17187 0.4062,0.28125 0.1563,0.=
0625 0.9375,0.26562 1.125,0.3125 1.5625,0.5 0.4375,0.1875 0.6875,0.54688 0.=
25,0.35937 0.25,0.90625 0,0.53125 -0.3125,1 -0.2969,0.45312 -0.875,0.71875 =
-0.5781,0.25 -1.3125,0.25 -1.2187,0 -1.8594,-0.5 -0.625,-0.51563 -0.7968,-1=
.5 z m 8.7187,0.92187 0.1563,0.92188 q -0.4532,0.0937 -0.7969,0.0937 -0.578=
1,0 -0.8906,-0.17188 -0.3125,-0.1875 -0.4532,-0.48437 -0.125,-0.29688 -0.12=
5,-1.25 v -3.57813 h -0.7656 v -0.8125 h 0.7656 v -1.54687 l 1.0469,-0.625 =
v 2.17187 h 1.0625 v 0.8125 h -1.0625 v 3.64063 q 0,0.45312 0.047,0.57812 0=
.062,0.125 0.1875,0.20313 0.125,0.0781 0.3594,0.0781 0.1875,0 0.4687,-0.031=
2 z m 5.0996,0.17188 q -0.5937,0.5 -1.1406,0.70312 -0.5313,0.20313 -1.1563,=
0.20313 -1.0312,0 -1.5781,-0.5 -0.5469,-0.5 -0.5469,-1.28125 0,-0.45313 0.2=
032,-0.82813 0.2031,-0.39062 0.5468,-0.60937 0.3438,-0.23438 0.7657,-0.3437=
5 0.2968,-0.0937 0.9375,-0.17188 1.2656,-0.14062 1.875,-0.35937 0,-0.21875 =
0,-0.26563 0,-0.65625 -0.2969,-0.92187 -0.4063,-0.34375 -1.2031,-0.34375 -0=
.7344,0 -1.0938,0.26562 -0.3594,0.25 -0.5312,0.90625 l -1.0313,-0.14062 q 0=
.1406,-0.65625 0.4688,-1.0625 0.3281,-0.40625 0.9375,-0.625 0.6093,-0.21875=
 1.4062,-0.21875 0.7969,0 1.2969,0.1875 0.5,0.1875 0.7344,0.46875 0.2343,0.=
28125 0.3281,0.71875 0.047,0.26562 0.047,0.96875 v 1.40625 q 0,1.46875 0.06=
2,1.85937 0.078,0.39063 0.2812,0.75 h -1.1093 q -0.1563,-0.32812 -0.2032,-0=
.76562 z m -0.094,-2.35938 q -0.5781,0.23438 -1.7187,0.40625 -0.6563,0.0937=
 -0.9219,0.21875 -0.2656,0.10938 -0.4219,0.32813 -0.1406,0.21875 -0.1406,0.=
5 0,0.42187 0.3125,0.70312 0.3281,0.28125 0.9375,0.28125 0.6094,0 1.0781,-0=
.26562 0.4844,-0.26563 0.7031,-0.73438 0.1719,-0.35937 0.1719,-1.04687 z m =
2.6895,3.125 v -6.21875 h 0.9531 v 0.9375 q 0.3594,-0.65625 0.6563,-0.85937=
 0.3125,-0.21875 0.6875,-0.21875 0.5312,0 1.0781,0.32812 l -0.3594,0.98438 =
q -0.3906,-0.23438 -0.7656,-0.23438 -0.3594,0 -0.6406,0.21875 -0.2657,0.203=
13 -0.375,0.57813 -0.1875,0.5625 -0.1875,1.21875 v 3.26562 z m 6.3086,-0.93=
75 0.1562,0.92188 q -0.4531,0.0937 -0.7969,0.0937 -0.5781,0 -0.8906,-0.1718=
8 -0.3125,-0.1875 -0.4531,-0.48437 -0.125,-0.29688 -0.125,-1.25 v -3.57813 =
h -0.7656 v -0.8125 h 0.7656 v -1.54687 l 1.0469,-0.625 v 2.17187 h 1.0625 =
v 0.8125 h -1.0625 v 3.64063 q 0,0.45312 0.047,0.57812 0.062,0.125 0.1875,0=
.20313 0.125,0.0781 0.3594,0.0781 0.1875,0 0.4687,-0.0312 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path384" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       fill-opacity=3D"0"=0D
> -       d=3D"m 590.79859,181.60515 h -61.2598"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path386" />=0D
> -    <path=0D
> -       stroke=3D"#595959"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linejoin=3D"round"=0D
> -       stroke-linecap=3D"butt"=0D
> -       stroke-dasharray=3D"8, 3"=0D
> -       d=3D"m 590.79859,181.60515 h -55.2598"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path388"=0D
> -       style=3D"fill:#00ffcc" />=0D
> -    <path=0D
> -       fill=3D"#595959"=0D
> -       stroke=3D"#595959"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"m 535.53879,179.95344 -4.5381,1.65172 4.5381,1.65173 z"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path390" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       fill-opacity=3D"0"=0D
> -       d=3D"m 521.92459,298.1406 h 115.4645 v 27.46457 h -115.4645 z"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path392" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       d=3D"m 537.98709,315.64498 1.125,0.29687 q -0.3594,1.39063 -1.281=
3,2.125 -0.9218,0.73438 -2.2656,0.73438 -1.3906,0 -2.2656,-0.5625 -0.875,-0=
.5625 -1.3281,-1.625 -0.4532,-1.07813 -0.4532,-2.3125 0,-1.34375 0.5157,-2.=
34375 0.5156,-1 1.4531,-1.51563 0.9531,-0.51562 2.0937,-0.51562 1.2813,0 2.=
1563,0.65625 0.8906,0.65625 1.2344,1.84375 l -1.125,0.26562 q -0.2969,-0.93=
75 -0.875,-1.35937 -0.5625,-0.4375 -1.4219,-0.4375 -0.9844,0 -1.6563,0.4843=
7 -0.6562,0.46875 -0.9375,1.26563 -0.2656,0.79687 -0.2656,1.65625 0,1.09375=
 0.3125,1.90625 0.3281,0.8125 1,1.21875 0.6719,0.40625 1.4688,0.40625 0.953=
1,0 1.6093,-0.54688 0.6719,-0.54687 0.9063,-1.64062 z m 2.4004,-4.35938 v -=
1.21875 h 1.0625 v 1.21875 z m 0,7.375 v -6.21875 h 1.0625 v 6.21875 z m 2.=
6504,0 v -6.21875 h 0.9531 v 0.9375 q 0.3594,-0.65625 0.6563,-0.85937 0.312=
5,-0.21875 0.6875,-0.21875 0.5312,0 1.0781,0.32812 l -0.3594,0.98438 q -0.3=
906,-0.23438 -0.7656,-0.23438 -0.3594,0 -0.6406,0.21875 -0.2657,0.20313 -0.=
375,0.57813 -0.1875,0.5625 -0.1875,1.21875 v 3.26562 z m 8.0742,-2.28125 1.=
0312,0.14063 q -0.1718,1.0625 -0.875,1.67187 -0.7031,0.60938 -1.7187,0.6093=
8 -1.2813,0 -2.0625,-0.82813 -0.7656,-0.84375 -0.7656,-2.40625 0,-1 0.3281,=
-1.75 0.3437,-0.76562 1.0156,-1.14062 0.6875,-0.375 1.5,-0.375 1,0 1.6406,0=
.51562 0.6563,0.5 0.8438,1.45313 l -1.0313,0.15625 q -0.1406,-0.625 -0.5156=
,-0.9375 -0.375,-0.32813 -0.9062,-0.32813 -0.7969,0 -1.2969,0.57813 -0.5,0.=
5625 -0.5,1.79687 0,1.26563 0.4844,1.82813 0.4843,0.5625 1.25,0.5625 0.625,=
0 1.0312,-0.375 0.4219,-0.375 0.5469,-1.17188 z m 6.0156,2.28125 v -0.92187=
 q -0.7344,1.0625 -1.9844,1.0625 -0.5468,0 -1.0312,-0.20313 -0.4688,-0.2187=
5 -0.7031,-0.53125 -0.2344,-0.32812 -0.3282,-0.79687 -0.062,-0.29688 -0.062=
,-0.98438 v -3.84375 h 1.0625 v 3.45313 q 0,0.8125 0.062,1.10937 0.094,0.40=
625 0.4063,0.65625 0.3281,0.23438 0.8125,0.23438 0.4687,0 0.875,-0.23438 0.=
4219,-0.25 0.5937,-0.67187 0.1875,-0.42188 0.1875,-1.21875 v -3.32813 h 1.0=
469 v 6.21875 z m 2.5645,0 v -8.59375 h 1.0625 v 8.59375 z m 6.7597,-0.7656=
2 q -0.5937,0.5 -1.1406,0.70312 -0.5312,0.20313 -1.1562,0.20313 -1.0313,0 -=
1.5782,-0.5 -0.5468,-0.5 -0.5468,-1.28125 0,-0.45313 0.2031,-0.82813 0.2031=
,-0.39062 0.5469,-0.60937 0.3437,-0.23438 0.7656,-0.34375 0.2969,-0.0937 0.=
9375,-0.17188 1.2656,-0.14062 1.875,-0.35937 0,-0.21875 0,-0.26563 0,-0.656=
25 -0.2969,-0.92187 -0.4062,-0.34375 -1.2031,-0.34375 -0.7344,0 -1.0938,0.2=
6562 -0.3593,0.25 -0.5312,0.90625 l -1.0313,-0.14062 q 0.1407,-0.65625 0.46=
88,-1.0625 0.3281,-0.40625 0.9375,-0.625 0.6094,-0.21875 1.4062,-0.21875 0.=
7969,0 1.2969,0.1875 0.5,0.1875 0.7344,0.46875 0.2344,0.28125 0.3281,0.7187=
5 0.047,0.26562 0.047,0.96875 v 1.40625 q 0,1.46875 0.062,1.85937 0.078,0.3=
9063 0.2813,0.75 h -1.1094 q -0.1563,-0.32812 -0.2031,-0.76562 z m -0.094,-=
2.35938 q -0.5781,0.23438 -1.7187,0.40625 -0.6563,0.0937 -0.9219,0.21875 -0=
.2656,0.10938 -0.4219,0.32813 -0.1406,0.21875 -0.1406,0.5 0,0.42187 0.3125,=
0.70312 0.3281,0.28125 0.9375,0.28125 0.6094,0 1.0781,-0.26562 0.4844,-0.26=
563 0.7032,-0.73438 0.1718,-0.35937 0.1718,-1.04687 z m 2.6895,3.125 v -6.2=
1875 h 0.9531 v 0.9375 q 0.3594,-0.65625 0.6563,-0.85937 0.3125,-0.21875 0.=
6875,-0.21875 0.5312,0 1.0781,0.32812 l -0.3594,0.98438 q -0.3906,-0.23438 =
-0.7656,-0.23438 -0.3594,0 -0.6406,0.21875 -0.2657,0.20313 -0.375,0.57813 -=
0.1875,0.5625 -0.1875,1.21875 v 3.26562 z m 8.3144,0 h -0.9843 v -8.59375 h=
 1.0625 v 3.0625 q 0.6718,-0.82812 1.7031,-0.82812 0.5781,0 1.0781,0.23437 =
0.5156,0.21875 0.8438,0.64063 0.3437,0.42187 0.5312,1.01562 0.1875,0.59375 =
0.1875,1.26563 0,1.59375 -0.7969,2.46875 -0.7968,0.875 -1.8906,0.875 -1.109=
4,0 -1.7344,-0.92188 z m -0.016,-3.15625 q 0,1.10938 0.3125,1.60938 0.5,0.8=
125 1.3438,0.8125 0.6875,0 1.1875,-0.59375 0.5156,-0.59375 0.5156,-1.79688 =
0,-1.21875 -0.4844,-1.79687 -0.4843,-0.57813 -1.1718,-0.57813 -0.6875,0 -1.=
2032,0.60938 -0.5,0.59375 -0.5,1.73437 z m 9.7989,3.15625 v -0.92187 q -0.7=
344,1.0625 -1.9844,1.0625 -0.5469,0 -1.0313,-0.20313 -0.4687,-0.21875 -0.70=
31,-0.53125 -0.2344,-0.32812 -0.3281,-0.79687 -0.062,-0.29688 -0.062,-0.984=
38 v -3.84375 h 1.0625 v 3.45313 q 0,0.8125 0.062,1.10937 0.094,0.40625 0.4=
062,0.65625 0.3282,0.23438 0.8125,0.23438 0.4688,0 0.875,-0.23438 0.4219,-0=
.25 0.5938,-0.67187 0.1875,-0.42188 0.1875,-1.21875 v -3.32813 h 1.0469 v 6=
.21875 z m 2.8457,0 v -5.40625 h -0.9375 v -0.8125 h 0.9375 v -0.67187 q 0,=
-0.625 0.1093,-0.92188 0.1563,-0.42187 0.5313,-0.67187 0.3906,-0.25 1.0781,=
-0.25 0.4531,0 0.9844,0.10937 l -0.1563,0.90625 q -0.3281,-0.0469 -0.625,-0=
.0469 -0.4843,0 -0.6875,0.20312 -0.1875,0.20313 -0.1875,0.76563 v 0.57812 h=
 1.2188 v 0.8125 h -1.2188 v 5.40625 z m 10.6679,-2 1.0938,0.125 q -0.25,0.=
95313 -0.9531,1.48438 -0.7032,0.53125 -1.7813,0.53125 -1.3594,0 -2.1719,-0.=
84375 -0.7968,-0.84375 -0.7968,-2.35938 0,-1.5625 0.8125,-2.42187 0.8125,-0=
.875 2.0937,-0.875 1.25,0 2.0313,0.84375 0.7968,0.84375 0.7968,2.39062 0,0.=
0937 0,0.28125 h -4.6406 q 0.062,1.03125 0.5781,1.57813 0.5157,0.53125 1.29=
69,0.53125 0.5781,0 0.9844,-0.29688 0.4219,-0.3125 0.6562,-0.96875 z m -3.4=
531,-1.70312 h 3.4688 q -0.062,-0.79688 -0.3907,-1.1875 -0.5156,-0.60938 -1=
.3125,-0.60938 -0.7343,0 -1.2343,0.48438 -0.4844,0.48437 -0.5313,1.3125 z m=
 5.877,3.70312 v -6.21875 h 0.9375 v 0.875 q 0.6875,-1.01562 1.9843,-1.0156=
2 0.5625,0 1.0313,0.20312 0.4844,0.20313 0.7187,0.53125 0.2344,0.32813 0.32=
82,0.76563 0.047,0.29687 0.047,1.03125 v 3.82812 h -1.0469 v -3.78125 q 0,-=
0.65625 -0.125,-0.96875 -0.125,-0.3125 -0.4375,-0.5 -0.3125,-0.20312 -0.734=
4,-0.20312 -0.6719,0 -1.1719,0.4375 -0.4843,0.42187 -0.4843,1.60937 v 3.406=
25 z m 10.705,0 v -0.78125 q -0.5937,0.92188 -1.7343,0.92188 -0.75,0 -1.375=
,-0.40625 -0.625,-0.42188 -0.9688,-1.15625 -0.3437,-0.73438 -0.3437,-1.6875=
 0,-0.92188 0.3125,-1.6875 0.3125,-0.76563 0.9375,-1.15625 0.625,-0.40625 1=
.3906,-0.40625 0.5625,0 1,0.23437 0.4375,0.23438 0.7187,0.60938 v -3.07813 =
h 1.0469 v 8.59375 z m -3.3281,-3.10937 q 0,1.20312 0.5,1.79687 0.5,0.57813=
 1.1875,0.57813 0.6875,0 1.1719,-0.5625 0.4844,-0.5625 0.4844,-1.71875 0,-1=
.28125 -0.5,-1.875 -0.4844,-0.59375 -1.2032,-0.59375 -0.7031,0 -1.1718,0.57=
812 -0.4688,0.5625 -0.4688,1.79688 z"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path394" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       fill-opacity=3D"0"=0D
> -       d=3D"m 587.53349,322.39257 h -61.2598"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path396" />=0D
> -    <path=0D
> -       stroke=3D"#595959"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linejoin=3D"round"=0D
> -       stroke-linecap=3D"butt"=0D
> -       stroke-dasharray=3D"8, 3"=0D
> -       d=3D"m 587.53349,322.39257 h -55.2598"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path398"=0D
> -       style=3D"fill:#00ffcc" />=0D
> -    <path=0D
> -       fill=3D"#595959"=0D
> -       stroke=3D"#595959"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"m 532.27369,320.74084 -4.5381,1.65173 4.5381,1.65174 z"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path400" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       fill-opacity=3D"0"=0D
> -       d=3D"M 272.64375,180.18784 358.15556,77.542157"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path402" />=0D
> -    <path=0D
> -       stroke=3D"#a61c00"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linejoin=3D"round"=0D
> -       stroke-linecap=3D"butt"=0D
> -       stroke-dasharray=3D"1, 3"=0D
> -       d=3D"M 272.64375,180.18784 354.31514,82.152067"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path404" />=0D
> -    <path=0D
> -       fill=3D"#a61c00"=0D
> -       stroke=3D"#a61c00"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"m 355.58421,83.209287 1.63562,-4.54392 -4.17374,2.42948 z"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path406" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       fill-opacity=3D"0"=0D
> -       d=3D"m 272.24478,215.52642 88,105.60629"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path408" />=0D
> -    <path=0D
> -       stroke=3D"#a61c00"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linejoin=3D"round"=0D
> -       stroke-linecap=3D"butt"=0D
> -       stroke-dasharray=3D"1, 3"=0D
> -       d=3D"m 272.24478,215.52642 84.15903,100.99686"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path410" />=0D
> -    <path=0D
> -       fill=3D"#a61c00"=0D
> -       stroke=3D"#a61c00"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"m 355.1349,317.58065 4.17404,2.42899 -1.6362,-4.54374 z"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path412" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       fill-opacity=3D"0"=0D
> -       d=3D"M 272.24478,368.30334 684.11879,77.531667"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path414" />=0D
> -    <path=0D
> -       stroke=3D"#274e13"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linejoin=3D"round"=0D
> -       stroke-linecap=3D"butt"=0D
> -       stroke-dasharray=3D"1, 3"=0D
> -       d=3D"M 272.24478,368.30334 679.21719,80.992057"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path416" />=0D
> -    <path=0D
> -       fill=3D"#274e13"=0D
> -       stroke=3D"#274e13"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"m 680.16979,82.341417 2.7547,-3.96662 -4.6599,1.2679 z"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path418" />=0D
> -    <path=0D
> -       fill=3D"#000000"=0D
> -       fill-opacity=3D"0"=0D
> -       d=3D"M 272.24478,417.58678 688.21329,356.48442"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path420" />=0D
> -    <path=0D
> -       stroke=3D"#595959"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linejoin=3D"round"=0D
> -       stroke-linecap=3D"butt"=0D
> -       stroke-dasharray=3D"1, 3"=0D
> -       d=3D"M 272.24478,417.58678 682.27699,357.35643"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path422" />=0D
> -    <path=0D
> -       fill=3D"#595959"=0D
> -       stroke=3D"#595959"=0D
> -       stroke-width=3D"1"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"m 682.51709,358.99062 4.2499,-2.29373 -4.73,-0.97467 z"=0D
> -       fill-rule=3D"evenodd"=0D
> -       id=3D"path424" />=0D
> -    <rect=0D
> -       style=3D"fill:none;fill-opacity:1;stroke:#741b47;stroke-width:1.1=
461;stroke-opacity:1"=0D
> -       id=3D"rect1"=0D
> -       width=3D"860.90546"=0D
> -       height=3D"529.77783"=0D
> -       x=3D"51.046341"=0D
> -       y=3D"34.574326" />=0D
> -    <text=0D
> -       xml:space=3D"preserve"=0D
> -       id=3D"text1"=0D
> -       style=3D"white-space:pre;shape-inside:url(#rect2);fill:none;strok=
e:#741b47;stroke-width:1.151" />=0D
> -    <text=0D
> -       xml:space=3D"preserve"=0D
> -       style=3D"fill:none;stroke:#741b47;stroke-width:1.151"=0D
> -       x=3D"159.96594"=0D
> -       y=3D"437.608"=0D
> -       id=3D"text3"><tspan=0D
> -         sodipodi:role=3D"line"=0D
> -         id=3D"tspan3"=0D
> -         x=3D"159.96594"=0D
> -         y=3D"437.608" /></text>=0D
> -    <text=0D
> -       xml:space=3D"preserve"=0D
> -       id=3D"text4"=0D
> -       style=3D"fill:none;stroke:#741b47;stroke-width:1.151;white-space:=
pre;shape-inside:url(#rect5)" />=0D
> -    <text=0D
> -       xml:space=3D"preserve"=0D
> -       id=3D"text6"=0D
> -       style=3D"fill:none;stroke:#741b47;stroke-width:1.151;-inkscape-fo=
nt-specification:Arial;font-family:Arial;font-weight:normal;font-style:norm=
al;font-stretch:normal;font-variant:normal;line-height:0;white-space:pre;sh=
ape-inside:url(#rect7)" />=0D
> -    <use=0D
> -       x=3D"0"=0D
> -       y=3D"0"=0D
> -       xlink:href=3D"#path290"=0D
> -       id=3D"use8" />=0D
> -    <text=0D
> -       xml:space=3D"preserve"=0D
> -       id=3D"text16"=0D
> -       style=3D"fill:#000000;-inkscape-font-specification:Arial;font-fam=
ily:Arial;font-weight:normal;font-style:normal;font-stretch:normal;font-var=
iant:normal;line-height:0;fill-rule:evenodd;fill-opacity:1;white-space:pre;=
shape-inside:url(#rect16)" />=0D
> -    <text=0D
> -       xml:space=3D"preserve"=0D
> -       style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;line-height:0;font-family:Arial;-inkscape-font-specifi=
cation:'Arial, Normal';fill:#000000;fill-opacity:1;fill-rule:evenodd;font-s=
ize:12px;font-variant-ligatures:normal;font-variant-caps:normal;font-varian=
t-numeric:normal;font-variant-east-asian:normal"=0D
> -       x=3D"171.56448"=0D
> -       y=3D"438.474"=0D
> -       id=3D"text17"><tspan=0D
> -         sodipodi:role=3D"line"=0D
> -         id=3D"tspan17"=0D
> -         x=3D"171.56448"=0D
> -         y=3D"438.474">Node 1 xstats</tspan></text>=0D
> -    <text=0D
> -       xml:space=3D"preserve"=0D
> -       style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:12px;line-height:0;font-family:Arial;-inksca=
pe-font-specification:'Arial, Normal';font-variant-ligatures:normal;font-va=
riant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:norma=
l;fill:#000000;fill-opacity:1;fill-rule:evenodd"=0D
> -       x=3D"646.48962"=0D
> -       y=3D"409.63776"=0D
> -       id=3D"text17-1"><tspan=0D
> -         sodipodi:role=3D"line"=0D
> -         id=3D"tspan17-02"=0D
> -         x=3D"646.48962"=0D
> -         y=3D"409.63776">Node 1 </tspan></text>=0D
> -    <text=0D
> -       xml:space=3D"preserve"=0D
> -       style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:9.33333px;line-height:0;font-family:Arial;-i=
nkscape-font-specification:'Arial, Normal';font-variant-ligatures:normal;fo=
nt-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:=
normal;fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke-width:0.820641"=
=0D
> -       x=3D"717.65833"=0D
> -       y=3D"393.14011"=0D
> -       id=3D"text17-1-3"=0D
> -       transform=3D"scale(0.96355962,1.0378185)"><tspan=0D
> -         sodipodi:role=3D"line"=0D
> -         id=3D"tspan17-02-9"=0D
> -         x=3D"717.65833"=0D
> -         y=3D"393.14011"=0D
> -         style=3D"font-style:normal;font-variant:normal;font-weight:norm=
al;font-stretch:normal;font-size:9.33333px;font-family:Arial;-inkscape-font=
-specification:'Arial, Normal';font-variant-ligatures:normal;font-variant-c=
aps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;strok=
e-width:0.820641">xstat 1 </tspan></text>=0D
> -    <text=0D
> -       xml:space=3D"preserve"=0D
> -       style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:9.33333px;line-height:0;font-family:Arial;-i=
nkscape-font-specification:'Arial, Normal';font-variant-ligatures:normal;fo=
nt-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:=
normal;fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke-width:0.820641"=
=0D
> -       x=3D"731.20496"=0D
> -       y=3D"421.08084"=0D
> -       id=3D"text17-1-3-4"=0D
> -       transform=3D"scale(0.96355962,1.0378185)"><tspan=0D
> -         sodipodi:role=3D"line"=0D
> -         id=3D"tspan17-02-9-9"=0D
> -         x=3D"731.20496"=0D
> -         y=3D"421.08084"=0D
> -         style=3D"font-style:normal;font-variant:normal;font-weight:norm=
al;font-stretch:normal;font-size:9.33333px;font-family:Arial;-inkscape-font=
-specification:'Arial, Normal';font-variant-ligatures:normal;font-variant-c=
aps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;strok=
e-width:0.820641">xstat 1 </tspan></text>=0D
> -    <text=0D
> -       xml:space=3D"preserve"=0D
> -       style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:9.33333px;line-height:0;font-family:Arial;-i=
nkscape-font-specification:'Arial, Normal';font-variant-ligatures:normal;fo=
nt-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:=
normal;fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke-width:0.820641"=
=0D
> -       x=3D"723.08594"=0D
> -       y=3D"450.06653"=0D
> -       id=3D"text17-1-3-4-5"=0D
> -       transform=3D"scale(0.96355962,1.0378185)"><tspan=0D
> -         sodipodi:role=3D"line"=0D
> -         id=3D"tspan17-02-9-9-6"=0D
> -         x=3D"723.08594"=0D
> -         y=3D"450.06653"=0D
> -         style=3D"font-style:normal;font-variant:normal;font-weight:norm=
al;font-stretch:normal;font-size:9.33333px;font-family:Arial;-inkscape-font=
-specification:'Arial, Normal';font-variant-ligatures:normal;font-variant-c=
aps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;strok=
e-width:0.820641">xstat 1 </tspan></text>=0D
> -    <text=0D
> -       xml:space=3D"preserve"=0D
> -       style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:9.33333px;line-height:0;font-family:Arial;-i=
nkscape-font-specification:'Arial, Normal';font-variant-ligatures:normal;fo=
nt-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:=
normal;fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke-width:0.820641"=
=0D
> -       x=3D"748.5882"=0D
> -       y=3D"393.18039"=0D
> -       id=3D"text17-1-3-5"=0D
> -       transform=3D"scale(0.96355962,1.0378185)"><tspan=0D
> -         sodipodi:role=3D"line"=0D
> -         id=3D"tspan17-02-9-3"=0D
> -         x=3D"748.5882"=0D
> -         y=3D"393.18039"=0D
> -         style=3D"font-style:normal;font-variant:normal;font-weight:norm=
al;font-stretch:normal;font-size:9.33333px;font-family:Arial;-inkscape-font=
-specification:'Arial, Normal';font-variant-ligatures:normal;font-variant-c=
aps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;strok=
e-width:0.820641">xstat 2 </tspan></text>=0D
> -    <text=0D
> -       xml:space=3D"preserve"=0D
> -       style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:9.33333333px;line-height:0;font-family:Arial=
;-inkscape-font-specification:'Arial, Normal';fill:#000000;fill-opacity:1;f=
ill-rule:evenodd;stroke-width:0.820641;font-variant-ligatures:normal;font-v=
ariant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:norm=
al"=0D
> -       x=3D"793.07227"=0D
> -       y=3D"421.1171"=0D
> -       id=3D"text17-1-3-5-7"=0D
> -       transform=3D"scale(0.96355962,1.0378185)"><tspan=0D
> -         sodipodi:role=3D"line"=0D
> -         id=3D"tspan17-02-9-3-6"=0D
> -         x=3D"793.07227"=0D
> -         y=3D"421.1171"=0D
> -         style=3D"stroke-width:0.820641;-inkscape-font-specification:'Ar=
ial, Normal';font-family:Arial;font-weight:normal;font-style:normal;font-st=
retch:normal;font-variant:normal;font-size:9.33333333px;font-variant-ligatu=
res:normal;font-variant-caps:normal;font-variant-numeric:normal;font-varian=
t-east-asian:normal">xstat 2 </tspan></text>=0D
> -    <text=0D
> -       xml:space=3D"preserve"=0D
> -       style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:9.33333px;line-height:0;font-family:Arial;-i=
nkscape-font-specification:'Arial, Normal';font-variant-ligatures:normal;fo=
nt-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:=
normal;fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke-width:0.820641"=
=0D
> -       x=3D"765.38727"=0D
> -       y=3D"450.09952"=0D
> -       id=3D"text17-1-3-5-7-6"=0D
> -       transform=3D"scale(0.96355962,1.0378185)"><tspan=0D
> -         sodipodi:role=3D"line"=0D
> -         id=3D"tspan17-02-9-3-6-0"=0D
> -         x=3D"765.38727"=0D
> -         y=3D"450.09952"=0D
> -         style=3D"font-style:normal;font-variant:normal;font-weight:norm=
al;font-stretch:normal;font-size:9.33333px;font-family:Arial;-inkscape-font=
-specification:'Arial, Normal';font-variant-ligatures:normal;font-variant-c=
aps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;strok=
e-width:0.820641">xstat 2 </tspan></text>=0D
> -    <text=0D
> -       xml:space=3D"preserve"=0D
> -       style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:9.33333333px;line-height:0;font-family:Arial=
;-inkscape-font-specification:'Arial, Normal';fill:#000000;fill-opacity:1;f=
ill-rule:evenodd;stroke-width:0.820641;font-variant-ligatures:normal;font-v=
ariant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:norm=
al"=0D
> -       x=3D"763.57843"=0D
> -       y=3D"479.1445"=0D
> -       id=3D"text17-1-3-5-7-6-7"=0D
> -       transform=3D"scale(0.96355962,1.0378185)"><tspan=0D
> -         sodipodi:role=3D"line"=0D
> -         id=3D"tspan17-02-9-3-6-0-5"=0D
> -         x=3D"763.57843"=0D
> -         y=3D"479.1445"=0D
> -         style=3D"stroke-width:0.820641;-inkscape-font-specification:'Ar=
ial, Normal';font-family:Arial;font-weight:normal;font-style:normal;font-st=
retch:normal;font-variant:normal;font-size:9.33333333px;font-variant-ligatu=
res:normal;font-variant-caps:normal;font-variant-numeric:normal;font-varian=
t-east-asian:normal">xstat N </tspan></text>=0D
> -    <text=0D
> -       xml:space=3D"preserve"=0D
> -       style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:9.33333px;line-height:0;font-family:Arial;-i=
nkscape-font-specification:'Arial, Normal';font-variant-ligatures:normal;fo=
nt-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:=
normal;fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke-width:0.820641"=
=0D
> -       x=3D"779.73914"=0D
> -       y=3D"393.17386"=0D
> -       id=3D"text17-1-3-5-6"=0D
> -       transform=3D"scale(0.96355962,1.0378185)"><tspan=0D
> -         sodipodi:role=3D"line"=0D
> -         id=3D"tspan17-02-9-3-5"=0D
> -         x=3D"779.73914"=0D
> -         y=3D"393.17386"=0D
> -         style=3D"font-style:normal;font-variant:normal;font-weight:norm=
al;font-stretch:normal;font-size:9.33333px;font-family:Arial;-inkscape-font=
-specification:'Arial, Normal';font-variant-ligatures:normal;font-variant-c=
aps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;strok=
e-width:0.820641">xstat 3 </tspan></text>=0D
> -    <text=0D
> -       xml:space=3D"preserve"=0D
> -       style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:9.33333px;line-height:0;font-family:Arial;-i=
nkscape-font-specification:'Arial, Normal';font-variant-ligatures:normal;fo=
nt-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:=
normal;fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke-width:0.820641"=
=0D
> -       x=3D"807.05823"=0D
> -       y=3D"450.12637"=0D
> -       id=3D"text17-1-3-5-6-0"=0D
> -       transform=3D"scale(0.96355962,1.0378185)"><tspan=0D
> -         sodipodi:role=3D"line"=0D
> -         id=3D"tspan17-02-9-3-5-6"=0D
> -         x=3D"807.05823"=0D
> -         y=3D"450.12637"=0D
> -         style=3D"font-style:normal;font-variant:normal;font-weight:norm=
al;font-stretch:normal;font-size:9.33333px;font-family:Arial;-inkscape-font=
-specification:'Arial, Normal';font-variant-ligatures:normal;font-variant-c=
aps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;strok=
e-width:0.820641">xstat 3 </tspan></text>=0D
> -    <text=0D
> -       xml:space=3D"preserve"=0D
> -       style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:9.33333px;line-height:0;font-family:Arial;-i=
nkscape-font-specification:'Arial, Normal';font-variant-ligatures:normal;fo=
nt-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:=
normal;fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke-width:0.820641"=
=0D
> -       x=3D"811.46503"=0D
> -       y=3D"393.10345"=0D
> -       id=3D"text17-1-3-5-6-9"=0D
> -       transform=3D"scale(0.96355962,1.0378185)"><tspan=0D
> -         sodipodi:role=3D"line"=0D
> -         id=3D"tspan17-02-9-3-5-9"=0D
> -         x=3D"811.46503"=0D
> -         y=3D"393.10345"=0D
> -         style=3D"font-style:normal;font-variant:normal;font-weight:norm=
al;font-stretch:normal;font-size:9.33333px;font-family:Arial;-inkscape-font=
-specification:'Arial, Normal';font-variant-ligatures:normal;font-variant-c=
aps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;strok=
e-width:0.820641">xstat 4 </tspan></text>=0D
> -    <text=0D
> -       xml:space=3D"preserve"=0D
> -       style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:12px;line-height:0;font-family:Arial;-inksca=
pe-font-specification:'Arial, Normal';font-variant-ligatures:normal;font-va=
riant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:norma=
l;fill:#000000;fill-opacity:1;fill-rule:evenodd"=0D
> -       x=3D"647.08496"=0D
> -       y=3D"438.59705"=0D
> -       id=3D"text17-1-2"><tspan=0D
> -         sodipodi:role=3D"line"=0D
> -         id=3D"tspan17-02-6"=0D
> -         x=3D"647.08496"=0D
> -         y=3D"438.59705">Node 4 </tspan></text>=0D
> -    <text=0D
> -       xml:space=3D"preserve"=0D
> -       style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:12px;line-height:0;font-family:Arial;-inksca=
pe-font-specification:'Arial, Normal';font-variant-ligatures:normal;font-va=
riant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:norma=
l;fill:#000000;fill-opacity:1;fill-rule:evenodd"=0D
> -       x=3D"647.08643"=0D
> -       y=3D"468.59579"=0D
> -       id=3D"text17-1-2-4"><tspan=0D
> -         sodipodi:role=3D"line"=0D
> -         id=3D"tspan17-02-6-2"=0D
> -         x=3D"647.08643"=0D
> -         y=3D"468.59579">Node 8 </tspan></text>=0D
> -    <text=0D
> -       xml:space=3D"preserve"=0D
> -       style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:12px;line-height:0;font-family:Arial;-inksca=
pe-font-specification:'Arial, Normal';font-variant-ligatures:normal;font-va=
riant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:norma=
l;fill:#000000;fill-opacity:1;fill-rule:evenodd"=0D
> -       x=3D"647.08948"=0D
> -       y=3D"498.58841"=0D
> -       id=3D"text17-1-2-4-2"><tspan=0D
> -         sodipodi:role=3D"line"=0D
> -         id=3D"tspan17-02-6-2-1"=0D
> -         x=3D"647.08948"=0D
> -         y=3D"498.58841">Node N </tspan></text>=0D
> -    <text=0D
> -       xml:space=3D"preserve"=0D
> -       style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;line-height:0;font-family:Arial;-inkscape-font-specifi=
cation:'Arial, Normal';fill:#000000;fill-opacity:1;fill-rule:evenodd;font-s=
ize:12px;font-variant-ligatures:normal;font-variant-caps:normal;font-varian=
t-numeric:normal;font-variant-east-asian:normal"=0D
> -       x=3D"171.51901"=0D
> -       y=3D"463.50073"=0D
> -       id=3D"text17-9"><tspan=0D
> -         sodipodi:role=3D"line"=0D
> -         id=3D"tspan17-0"=0D
> -         x=3D"171.51901"=0D
> -         y=3D"463.50073">Node 4 xstats</tspan></text>=0D
> -    <text=0D
> -       xml:space=3D"preserve"=0D
> -       style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;line-height:0;font-family:Arial;-inkscape-font-specifi=
cation:'Arial, Normal';fill:#000000;fill-opacity:1;fill-rule:evenodd;font-s=
ize:12px;font-variant-ligatures:normal;font-variant-caps:normal;font-varian=
t-numeric:normal;font-variant-east-asian:normal"=0D
> -       x=3D"171.66028"=0D
> -       y=3D"488.6954"=0D
> -       id=3D"text17-9-7"><tspan=0D
> -         sodipodi:role=3D"line"=0D
> -         id=3D"tspan17-0-6"=0D
> -         x=3D"171.66028"=0D
> -         y=3D"488.6954">Node 8 xstats</tspan></text>=0D
> -    <text=0D
> -       xml:space=3D"preserve"=0D
> -       style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;line-height:0;font-family:Arial;-inkscape-font-specifi=
cation:'Arial, Normal';fill:#000000;fill-opacity:1;fill-rule:evenodd;font-s=
ize:12px;font-variant-ligatures:normal;font-variant-caps:normal;font-varian=
t-numeric:normal;font-variant-east-asian:normal"=0D
> -       x=3D"171.61055"=0D
> -       y=3D"513.5614"=0D
> -       id=3D"text17-9-7-1"><tspan=0D
> -         sodipodi:role=3D"line"=0D
> -         id=3D"tspan17-0-6-1"=0D
> -         x=3D"171.61055"=0D
> -         y=3D"513.5614">Node N xstats</tspan></text>=0D
> -    <text=0D
> -       xml:space=3D"preserve"=0D
> -       id=3D"text18"=0D
> -       style=3D"fill:#000000;-inkscape-font-specification:Arial;font-fam=
ily:Arial;font-weight:normal;font-style:normal;font-stretch:normal;font-var=
iant:normal;line-height:0;fill-rule:evenodd;fill-opacity:1;white-space:pre;=
shape-inside:url(#rect18)" />=0D
> -    <text=0D
> -       xml:space=3D"preserve"=0D
> -       id=3D"text19"=0D
> -       style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:13.3333px;line-height:0;font-family:Arial;-i=
nkscape-font-specification:Arial;white-space:pre;shape-inside:url(#rect19);=
fill:#008033;fill-opacity:1;fill-rule:evenodd"=0D
> -       transform=3D"translate(9.7511214,-22.752617)"><tspan=0D
> -         x=3D"656.57617"=0D
> -         y=3D"403.47359"=0D
> -         id=3D"tspan2">rte_node xstat memory layout</tspan></text>=0D
> -    <text=0D
> -       xml:space=3D"preserve"=0D
> -       id=3D"text19-3"=0D
> -       style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:13.3333px;line-height:0;font-family:Arial;-i=
nkscape-font-specification:Arial;white-space:pre;shape-inside:url(#rect19-5=
);fill:#008033;fill-opacity:1;fill-rule:evenodd"=0D
> -       transform=3D"matrix(1,0,0,1.3775713,-86.925353,-93.357559)" />=0D
> -    <rect=0D
> -       style=3D"fill:none;fill-opacity:1;fill-rule:evenodd;stroke:#1155c=
c;stroke-width:0.975519;stroke-opacity:1"=0D
> -       id=3D"rect20"=0D
> -       width=3D"121.46339"=0D
> -       height=3D"119.3132"=0D
> -       x=3D"689.06696"=0D
> -       y=3D"390.52017" />=0D
> -    <path=0D
> -       stroke=3D"#1155cc"=0D
> -       stroke-width=3D"0.969816"=0D
> -       stroke-linecap=3D"butt"=0D
> -       d=3D"M 689.31334,480.57387 H 811.05822"=0D
> -       fill-rule=3D"nonzero"=0D
> -       id=3D"path310-0-5" />=0D
> -    <path=0D
> -       style=3D"fill:none;fill-opacity:1;fill-rule:evenodd;stroke:#59595=
9;stroke-dasharray:1, 3;stroke-dashoffset:0;stroke-opacity:1;marker-end:url=
(#Triangle)"=0D
> -       d=3D"M 274.42435,420.14046 C 682.15366,393.93914 683.99234,393.65=
184 683.99234,393.65184"=0D
> -       id=3D"path20"=0D
> -       sodipodi:nodetypes=3D"cc" />=0D
> -    <path=0D
> -       style=3D"fill:none;fill-opacity:1;fill-rule:evenodd;stroke:#59595=
9;stroke-dasharray:1, 3;stroke-dashoffset:0;stroke-opacity:1;marker-end:url=
(#Triangle-0)"=0D
> -       d=3D"M 273.95206,520.01368 C 680.76203,508.98154 685.1289,509.153=
92 685.1289,509.15392"=0D
> -       id=3D"path20-9"=0D
> -       sodipodi:nodetypes=3D"cc" />=0D
> -    <path=0D
> -       style=3D"fill:none;fill-opacity:1;fill-rule:evenodd;stroke:#1155c=
c;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"=0D
> -       d=3D"m 719.87654,390.57304 c -0.0406,30.30974 -0.0406,30.30974 -0=
.0406,30.30974 v 0"=0D
> -       id=3D"path21" />=0D
> -    <path=0D
> -       style=3D"fill:none;fill-opacity:1;fill-rule:evenodd;stroke:#1155c=
c;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"=0D
> -       d=3D"m 749.50421,420.67017 c -0.0406,30.30974 -0.0406,30.30974 -0=
.0406,30.30974 v 0"=0D
> -       id=3D"path21-8" />=0D
> -    <path=0D
> -       style=3D"fill:none;fill-opacity:1;fill-rule:evenodd;stroke:#1155c=
c;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"=0D
> -       d=3D"m 729.7747,450.11771 c -0.0406,30.30974 -0.0406,30.30974 -0.=
0406,30.30974 v 0"=0D
> -       id=3D"path21-8-6" />=0D
> -    <path=0D
> -       style=3D"fill:none;fill-opacity:1;fill-rule:evenodd;stroke:#1155c=
c;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"=0D
> -       d=3D"m 770.41929,450.27903 c -0.0406,30.30974 -0.0406,30.30974 -0=
.0406,30.30974 v 0"=0D
> -       id=3D"path21-8-6-2" />=0D
> -    <path=0D
> -       style=3D"fill:none;fill-opacity:1;fill-rule:evenodd;stroke:#1155c=
c;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"=0D
> -       d=3D"m 749.58061,390.87575 c -0.0406,30.30974 -0.0406,30.30974 -0=
.0406,30.30974 v 0"=0D
> -       id=3D"path21-3" />=0D
> -    <path=0D
> -       style=3D"fill:none;fill-opacity:1;fill-rule:evenodd;stroke:#1155c=
c;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"=0D
> -       d=3D"m 779.67339,389.9164 c -0.0406,30.30974 -0.0406,30.30974 -0.=
0406,30.30974 v 0"=0D
> -       id=3D"path21-3-4" />=0D
> -    <text=0D
> -       xml:space=3D"preserve"=0D
> -       style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:13.3333px;line-height:0;font-family:Arial;-i=
nkscape-font-specification:Arial;fill:none;fill-opacity:1;fill-rule:evenodd=
;stroke:#1155cc;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"=
=0D
> -       x=3D"615.2713"=0D
> -       y=3D"435.30963"=0D
> -       id=3D"text21"><tspan=0D
> -         sodipodi:role=3D"line"=0D
> -         id=3D"tspan21"=0D
> -         x=3D"615.2713"=0D
> -         y=3D"435.30963" /></text>=0D
> -  </g>=0D
> +  <sodipodi:namedview=0D
> +     id=3D"namedview56"=0D
> +     pagecolor=3D"#505050"=0D
> +     bordercolor=3D"#ffffff"=0D
> +     borderopacity=3D"1"=0D
> +     inkscape:showpageshadow=3D"0"=0D
> +     inkscape:pageopacity=3D"0"=0D
> +     inkscape:pagecheckerboard=3D"1"=0D
> +     inkscape:deskcolor=3D"#d1d1d1"=0D
> +     showgrid=3D"false"=0D
> +     inkscape:zoom=3D"1.3717872"=0D
> +     inkscape:cx=3D"356.83377"=0D
> +     inkscape:cy=3D"244.20697"=0D
> +     inkscape:window-width=3D"2556"=0D
> +     inkscape:window-height=3D"1394"=0D
> +     inkscape:window-x=3D"0"=0D
> +     inkscape:window-y=3D"0"=0D
> +     inkscape:window-maximized=3D"0"=0D
> +     inkscape:current-layer=3D"svg56" />=0D
> +  <style=0D
> +     id=3D"style1">=0D
> +    text { font-family: sans-serif; font-size: 12px; }=0D
> +    text.title { font-size: 13px; fill: #009900; font-weight: bold; }=0D
> +    text.label { fill: #000000; }=0D
> +    text.italic { font-style: italic; fill: #666666; font-size: 11px; }=
=0D
> +    text.brace { font-size: 12px; fill: #000000; }=0D
> +    rect.cell { fill: #ffffff; stroke: #333333; stroke-width: 1; }=0D
> +    rect.header { fill: #f8f8f0; stroke: #333333; stroke-width: 1; }=0D
> +    line.arrow { stroke: #999999; stroke-width: 1; stroke-dasharray: 5,3=
; }=0D
> +    line.brace-line { stroke: #000000; stroke-width: 1; }=0D
> +  </style>=0D
> +  <rect=0D
> +     style=3D"fill:#ffffff;fill-opacity:1;stroke:none;stroke-linecap:rou=
nd;stroke-dasharray:4, 8;stroke-opacity:1;paint-order:markers fill stroke"=
=0D
> +     id=3D"rect2"=0D
> +     width=3D"820"=0D
> +     height=3D"540"=0D
> +     x=3D"0"=0D
> +     y=3D"0"=0D
> +     sodipodi:insensitive=3D"true" />=0D
> +  <path=0D
> +     style=3D"font-variation-settings:normal;opacity:1;vector-effect:non=
e;fill:none;fill-opacity:1;stroke:#009900;stroke-width:1px;stroke-linecap:b=
utt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:4, 8;stroke-=
dashoffset:0;stroke-opacity:0.733333;-inkscape-stroke:none;stop-color:#0000=
00;stop-opacity:1"=0D
> +     d=3D"m 215.11719,269.87695 365.21484,-112"=0D
> +     id=3D"path56"=0D
> +     sodipodi:nodetypes=3D"cc" />=0D
> +  <!-- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D -->=0D
> +  <!-- rte_graph object memory layout (left column) -->=0D
> +  <!-- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D -->=0D
> +  <text=0D
> +     x=3D"19.517578"=0D
> +     y=3D"21.559082"=0D
> +     class=3D"title"=0D
> +     id=3D"text1"=0D
> +     style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:13px;font-family:sans-serif;-inkscape-font-spe=
cification:'sans-serif, Normal';font-variant-ligatures:normal;font-variant-=
caps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;fill=
:#3e3e3e;fill-opacity:1">rte_graph object memory layout</text>=0D
> +  <!-- Graph Header -->=0D
> +  <rect=0D
> +     x=3D"35.117188"=0D
> +     y=3D"29.876953"=0D
> +     width=3D"180"=0D
> +     height=3D"40"=0D
> +     class=3D"header"=0D
> +     id=3D"rect1"=0D
> +     style=3D"fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-opacity:=
1" />=0D
> +  <text=0D
> +     x=3D"125.11719"=0D
> +     y=3D"44.876953"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text2">Graph Header</text>=0D
> +  <text=0D
> +     x=3D"125.11719"=0D
> +     y=3D"59.876953"=0D
> +     class=3D"italic"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text3"=0D
> +     style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:11px;font-family:Monospace;-inkscape-font-spec=
ification:'Monospace, Normal';font-variant-ligatures:normal;font-variant-ca=
ps:normal;font-variant-numeric:normal;font-variant-east-asian:normal">struc=
t rte_graph</text>=0D
> +  <!-- Scheduling table -->=0D
> +  <rect=0D
> +     x=3D"35.117188"=0D
> +     y=3D"109.87695"=0D
> +     width=3D"180"=0D
> +     height=3D"28"=0D
> +     class=3D"cell"=0D
> +     id=3D"rect3"=0D
> +     style=3D"fill:#b3e7f6;fill-opacity:1;stroke:#000000;stroke-opacity:=
1" />=0D
> +  <text=0D
> +     x=3D"125.11719"=0D
> +     y=3D"128.87695"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text4">Scheduling table</text>=0D
> +  <!-- Pending bitmap -->=0D
> +  <rect=0D
> +     x=3D"35.117188"=0D
> +     y=3D"137.87695"=0D
> +     width=3D"180"=0D
> +     height=3D"44.834362"=0D
> +     class=3D"cell"=0D
> +     id=3D"rect4"=0D
> +     style=3D"fill:#fffbda;fill-opacity:1;stroke:#000000;stroke-opacity:=
1" />=0D
> +  <text=0D
> +     x=3D"125.11719"=0D
> +     y=3D"156.87695"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text5">Pending bitmap</text>=0D
> +  <!-- Source pending bitmap -->=0D
> +  <rect=0D
> +     x=3D"35.117188"=0D
> +     y=3D"182.71132"=0D
> +     width=3D"180"=0D
> +     height=3D"41.165638"=0D
> +     class=3D"cell"=0D
> +     id=3D"rect5"=0D
> +     style=3D"fill:#fffbda;fill-opacity:1;stroke:#000000;stroke-opacity:=
1" />=0D
> +  <text=0D
> +     x=3D"125.11719"=0D
> +     y=3D"200.87695"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text6">Source nodes bitmap</text>=0D
> +  <!-- Fence -->=0D
> +  <rect=0D
> +     x=3D"35.117188"=0D
> +     y=3D"69.876953"=0D
> +     width=3D"180"=0D
> +     height=3D"36"=0D
> +     class=3D"header"=0D
> +     id=3D"rect6"=0D
> +     style=3D"fill:#ffa6a6;fill-opacity:1;stroke:#000000;stroke-opacity:=
1" />=0D
> +  <text=0D
> +     x=3D"125.11719"=0D
> +     y=3D"83.876953"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text7">Fence</text>=0D
> +  <text=0D
> +     x=3D"125.11719"=0D
> +     y=3D"97.876953"=0D
> +     class=3D"italic"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text8"=0D
> +     style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:11px;font-family:Monospace;-inkscape-font-spec=
ification:'Monospace, Normal';font-variant-ligatures:normal;font-variant-ca=
ps:normal;font-variant-numeric:normal;font-variant-east-asian:normal">RTE_G=
RAPH_FENCE</text>=0D
> +  <!-- Node 0 -->=0D
> +  <rect=0D
> +     x=3D"35.117188"=0D
> +     y=3D"229.87695"=0D
> +     width=3D"180"=0D
> +     height=3D"40"=0D
> +     class=3D"cell"=0D
> +     id=3D"rect8"=0D
> +     style=3D"fill:#d7fbe0;fill-opacity:1;stroke:#000000;stroke-opacity:=
1" />=0D
> +  <text=0D
> +     x=3D"125.11719"=0D
> +     y=3D"246.87695"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text9">Node 0</text>=0D
> +  <text=0D
> +     x=3D"125.11719"=0D
> +     y=3D"261.87695"=0D
> +     class=3D"italic"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text10"=0D
> +     style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:11px;font-family:Monospace;-inkscape-font-spec=
ification:'Monospace, Normal';font-variant-ligatures:normal;font-variant-ca=
ps:normal;font-variant-numeric:normal;font-variant-east-asian:normal">struc=
t rte_node</text>=0D
> +  <!-- Node 1 -->=0D
> +  <rect=0D
> +     x=3D"35.117188"=0D
> +     y=3D"269.87695"=0D
> +     width=3D"180"=0D
> +     height=3D"40"=0D
> +     class=3D"cell"=0D
> +     id=3D"rect10"=0D
> +     style=3D"fill:#d7fbe0;fill-opacity:1;stroke:#000000;stroke-opacity:=
1" />=0D
> +  <text=0D
> +     x=3D"125.11719"=0D
> +     y=3D"286.87695"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text11">Node 1</text>=0D
> +  <text=0D
> +     x=3D"125.11719"=0D
> +     y=3D"301.87695"=0D
> +     class=3D"italic"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text12"=0D
> +     style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:11px;font-family:Monospace;-inkscape-font-spec=
ification:'Monospace, Normal';font-variant-ligatures:normal;font-variant-ca=
ps:normal;font-variant-numeric:normal;font-variant-east-asian:normal">struc=
t rte_node</text>=0D
> +  <!-- Node 2 -->=0D
> +  <rect=0D
> +     x=3D"35.117188"=0D
> +     y=3D"309.87695"=0D
> +     width=3D"180"=0D
> +     height=3D"40"=0D
> +     class=3D"cell"=0D
> +     id=3D"rect12"=0D
> +     style=3D"fill:#d7fbe0;fill-opacity:1;stroke:#000000;stroke-opacity:=
1" />=0D
> +  <text=0D
> +     x=3D"125.11719"=0D
> +     y=3D"326.87695"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text13">Node 2</text>=0D
> +  <text=0D
> +     x=3D"125.11719"=0D
> +     y=3D"341.87695"=0D
> +     class=3D"italic"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text14"=0D
> +     style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:11px;font-family:Monospace;-inkscape-font-spec=
ification:'Monospace, Normal';font-variant-ligatures:normal;font-variant-ca=
ps:normal;font-variant-numeric:normal;font-variant-east-asian:normal">struc=
t rte_node</text>=0D
> +  <!-- Node N -->=0D
> +  <rect=0D
> +     x=3D"35.117188"=0D
> +     y=3D"357.87695"=0D
> +     width=3D"180"=0D
> +     height=3D"40"=0D
> +     class=3D"cell"=0D
> +     id=3D"rect14"=0D
> +     style=3D"fill:#d7fbe0;fill-opacity:1;stroke:#000000;stroke-opacity:=
1" />=0D
> +  <text=0D
> +     x=3D"125.11719"=0D
> +     y=3D"374.87695"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text15">Node N</text>=0D
> +  <text=0D
> +     x=3D"125.11719"=0D
> +     y=3D"389.87695"=0D
> +     class=3D"italic"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text16"=0D
> +     style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:11px;font-family:Monospace;-inkscape-font-spec=
ification:'Monospace, Normal';font-variant-ligatures:normal;font-variant-ca=
ps:normal;font-variant-numeric:normal;font-variant-east-asian:normal">struc=
t rte_node</text>=0D
> +  <!-- dots between Node 2 and Node N -->=0D
> +  <text=0D
> +     x=3D"125.11719"=0D
> +     y=3D"353.87695"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text17">...</text>=0D
> +  <!-- nb_nodes brace -->=0D
> +  <line=0D
> +     x1=3D"25.117188"=0D
> +     y1=3D"229.87695"=0D
> +     x2=3D"25.117188"=0D
> +     y2=3D"397.87695"=0D
> +     class=3D"brace-line"=0D
> +     id=3D"line17" />=0D
> +  <line=0D
> +     x1=3D"25.117188"=0D
> +     y1=3D"229.87695"=0D
> +     x2=3D"30.117188"=0D
> +     y2=3D"229.87695"=0D
> +     class=3D"brace-line"=0D
> +     id=3D"line18" />=0D
> +  <line=0D
> +     x1=3D"25.117188"=0D
> +     y1=3D"397.87695"=0D
> +     x2=3D"30.117188"=0D
> +     y2=3D"397.87695"=0D
> +     class=3D"brace-line"=0D
> +     id=3D"line19" />=0D
> +  <text=0D
> +     x=3D"-313.87695"=0D
> +     y=3D"17.117188"=0D
> +     class=3D"brace"=0D
> +     text-anchor=3D"middle"=0D
> +     transform=3D"rotate(-90)"=0D
> +     id=3D"text19">nb_nodes</text>=0D
> +  <!-- Node xstats -->=0D
> +  <rect=0D
> +     x=3D"35.117188"=0D
> +     y=3D"405.87695"=0D
> +     width=3D"180"=0D
> +     height=3D"38.393005"=0D
> +     class=3D"cell"=0D
> +     id=3D"rect19"=0D
> +     style=3D"fill:#fbccff;fill-opacity:1;stroke:#000000;stroke-opacity:=
1" />=0D
> +  <text=0D
> +     x=3D"125.11719"=0D
> +     y=3D"429.54709"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text20">Node 1 xstats</text>=0D
> +  <!-- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D -->=0D
> +  <!-- Bitmap scheduling layout (center column) -->=0D
> +  <!-- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D -->=0D
> +  <text=0D
> +     x=3D"350.58447"=0D
> +     y=3D"19.876953"=0D
> +     class=3D"title"=0D
> +     id=3D"text24"=0D
> +     style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:13px;font-family:sans-serif;-inkscape-font-spe=
cification:'sans-serif, Normal';font-variant-ligatures:normal;font-variant-=
caps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;fill=
:#1f297a;fill-opacity:1">Scheduling table</text>=0D
> +  <!-- Arrow from scheduling table to bitmap layout -->=0D
> +  <rect=0D
> +     x=3D"305.11719"=0D
> +     y=3D"29.876953"=0D
> +     width=3D"200"=0D
> +     height=3D"28"=0D
> +     class=3D"cell"=0D
> +     id=3D"rect24"=0D
> +     style=3D"fill:#b3e7f6;fill-opacity:1;stroke:#000000;stroke-opacity:=
1" />=0D
> +  <text=0D
> +     x=3D"405.11719"=0D
> +     y=3D"47.876953"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text25">Node 0 offset (depth 0)</text>=0D
> +  <rect=0D
> +     x=3D"305.11719"=0D
> +     y=3D"57.876953"=0D
> +     width=3D"200"=0D
> +     height=3D"28"=0D
> +     class=3D"cell"=0D
> +     id=3D"rect25"=0D
> +     style=3D"fill:#b3e7f6;fill-opacity:1;stroke:#000000;stroke-opacity:=
1" />=0D
> +  <text=0D
> +     x=3D"405.11719"=0D
> +     y=3D"75.876953"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text26">Node 1 offset</text>=0D
> +  <rect=0D
> +     x=3D"305.11719"=0D
> +     y=3D"85.876953"=0D
> +     width=3D"200"=0D
> +     height=3D"28"=0D
> +     class=3D"cell"=0D
> +     id=3D"rect26"=0D
> +     style=3D"fill:#b3e7f6;fill-opacity:1;stroke:#000000;stroke-opacity:=
1" />=0D
> +  <text=0D
> +     x=3D"405.11719"=0D
> +     y=3D"103.87695"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text27">Node 2 offset</text>=0D
> +  <text=0D
> +     x=3D"405.11719"=0D
> +     y=3D"121.87695"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text28">...</text>=0D
> +  <rect=0D
> +     x=3D"305.11719"=0D
> +     y=3D"127.87695"=0D
> +     width=3D"200"=0D
> +     height=3D"28"=0D
> +     class=3D"cell"=0D
> +     id=3D"rect28"=0D
> +     style=3D"fill:#b3e7f6;fill-opacity:1;stroke:#000000;stroke-opacity:=
1" />=0D
> +  <text=0D
> +     x=3D"405.11719"=0D
> +     y=3D"145.87695"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text29">Node N offset (depth max)</text>=0D
> +  <!-- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D -->=0D
> +  <!-- rte_node object memory layout (right column) -->=0D
> +  <!-- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D -->=0D
> +  <text=0D
> +     x=3D"555.31494"=0D
> +     y=3D"146.68994"=0D
> +     class=3D"title"=0D
> +     id=3D"text30"=0D
> +     style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:13px;font-family:sans-serif;-inkscape-font-spe=
cification:'sans-serif, Normal';font-variant-ligatures:normal;font-variant-=
caps:normal;font-variant-numeric:normal;font-variant-east-asian:normal">rte=
_node object memory layout</text>=0D
> +  <!-- Arrow from Node N to rte_node layout -->=0D
> +  <rect=0D
> +     x=3D"580.33203"=0D
> +     y=3D"157.87695"=0D
> +     width=3D"155.55365"=0D
> +     height=3D"28"=0D
> +     class=3D"cell"=0D
> +     id=3D"rect30"=0D
> +     style=3D"fill:#d7fbe0;fill-opacity:1;stroke:#000000;stroke-opacity:=
1" />=0D
> +  <text=0D
> +     x=3D"657.83936"=0D
> +     y=3D"175.87695"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text31">Fence</text>=0D
> +  <rect=0D
> +     x=3D"580.33203"=0D
> +     y=3D"185.87695"=0D
> +     width=3D"155.55365"=0D
> +     height=3D"36"=0D
> +     class=3D"cell"=0D
> +     id=3D"rect31"=0D
> +     style=3D"fill:#d7fbe0;fill-opacity:1;stroke:#000000;stroke-opacity:=
1" />=0D
> +  <text=0D
> +     x=3D"658.2583"=0D
> +     y=3D"200.87695"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text32">Slowpath area</text>=0D
> +  <text=0D
> +     x=3D"658.24585"=0D
> +     y=3D"214.87695"=0D
> +     class=3D"italic"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text33">(incl. sched_idx)</text>=0D
> +  <rect=0D
> +     x=3D"580.33203"=0D
> +     y=3D"221.87695"=0D
> +     width=3D"155.55365"=0D
> +     height=3D"28"=0D
> +     class=3D"cell"=0D
> +     id=3D"rect33"=0D
> +     style=3D"fill:#d7fbe0;fill-opacity:1;stroke:#000000;stroke-opacity:=
1" />=0D
> +  <text=0D
> +     x=3D"657.95068"=0D
> +     y=3D"239.87695"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text34">Context memory</text>=0D
> +  <rect=0D
> +     x=3D"580.33203"=0D
> +     y=3D"249.87695"=0D
> +     width=3D"155.55365"=0D
> +     height=3D"28"=0D
> +     class=3D"cell"=0D
> +     id=3D"rect34"=0D
> +     style=3D"fill:#d7fbe0;fill-opacity:1;stroke:#000000;stroke-opacity:=
1" />=0D
> +  <text=0D
> +     x=3D"658.06494"=0D
> +     y=3D"267.87695"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text35">Fastpath area</text>=0D
> +  <rect=0D
> +     x=3D"580.33203"=0D
> +     y=3D"277.87695"=0D
> +     width=3D"155.55365"=0D
> +     height=3D"28"=0D
> +     class=3D"cell"=0D
> +     id=3D"rect35"=0D
> +     style=3D"fill:#d7fbe0;fill-opacity:1;stroke:#000000;stroke-opacity:=
1" />=0D
> +  <text=0D
> +     x=3D"657.52002"=0D
> +     y=3D"295.87695"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text36">Next node 0 ptr</text>=0D
> +  <rect=0D
> +     x=3D"580.33203"=0D
> +     y=3D"305.87695"=0D
> +     width=3D"155.55365"=0D
> +     height=3D"28"=0D
> +     class=3D"cell"=0D
> +     id=3D"rect36"=0D
> +     style=3D"fill:#d7fbe0;fill-opacity:1;stroke:#000000;stroke-opacity:=
1" />=0D
> +  <text=0D
> +     x=3D"657.52002"=0D
> +     y=3D"323.87695"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text37">Next node 1 ptr</text>=0D
> +  <rect=0D
> +     x=3D"580.33203"=0D
> +     y=3D"347.87695"=0D
> +     width=3D"155.55365"=0D
> +     height=3D"28"=0D
> +     class=3D"cell"=0D
> +     id=3D"rect38"=0D
> +     style=3D"fill:#d7fbe0;fill-opacity:1;stroke:#000000;stroke-opacity:=
1" />=0D
> +  <text=0D
> +     x=3D"657.52002"=0D
> +     y=3D"365.87695"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text39">Next node N ptr</text>=0D
> +  <!-- nb_edges brace -->=0D
> +  <line=0D
> +     x1=3D"746.33203"=0D
> +     y1=3D"277.8587"=0D
> +     x2=3D"746.33203"=0D
> +     y2=3D"375.8952"=0D
> +     class=3D"brace-line"=0D
> +     id=3D"line39" />=0D
> +  <line=0D
> +     x1=3D"741.33203"=0D
> +     y1=3D"277.8587"=0D
> +     x2=3D"746.33203"=0D
> +     y2=3D"277.8587"=0D
> +     class=3D"brace-line"=0D
> +     id=3D"line40" />=0D
> +  <line=0D
> +     x1=3D"741.33203"=0D
> +     y1=3D"375.8952"=0D
> +     x2=3D"746.33203"=0D
> +     y2=3D"375.8952"=0D
> +     class=3D"brace-line"=0D
> +     id=3D"line41" />=0D
> +  <text=0D
> +     x=3D"784.33203"=0D
> +     y=3D"329.87695"=0D
> +     class=3D"brace"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text41">nb_edges</text>=0D
> +  <!-- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D -->=0D
> +  <!-- rte_node xstat memory layout (bottom right) -->=0D
> +  <!-- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D -->=0D
> +  <text=0D
> +     x=3D"382.12714"=0D
> +     y=3D"403.88254"=0D
> +     class=3D"title"=0D
> +     id=3D"text42"=0D
> +     style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:13px;font-family:sans-serif;-inkscape-font-spe=
cification:'sans-serif, Normal';font-variant-ligatures:normal;font-variant-=
caps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;fill=
:#990091;fill-opacity:1">rte_node xstats memory layout</text>=0D
> +  <!-- Arrow from Node N xstats -->=0D
> +  <!-- Node 1 xstats: 4 xstats -->=0D
> +  <!-- Node 4 xstats: 2 xstats -->=0D
> +  <!-- Node 8 xstats: 3 xstats -->=0D
> +  <!-- Node N xstats: 1 xstat -->=0D
> +  <path=0D
> +     style=3D"font-variation-settings:normal;opacity:1;vector-effect:non=
e;fill:none;fill-opacity:1;stroke:#009900;stroke-width:1px;stroke-linecap:b=
utt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:4, 8;stroke-=
dashoffset:0;stroke-opacity:0.733333;-inkscape-stroke:none;stop-color:#0000=
00;stop-opacity:1"=0D
> +     d=3D"m 215.11719,309.87695 365.21484,66"=0D
> +     id=3D"path57"=0D
> +     sodipodi:nodetypes=3D"cc" />=0D
> +  <path=0D
> +     style=3D"font-variation-settings:normal;opacity:1;vector-effect:non=
e;fill:none;fill-opacity:1;stroke:#215fe5;stroke-width:1px;stroke-linecap:b=
utt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:4, 8;stroke-=
dashoffset:0;stroke-opacity:1;-inkscape-stroke:none;stop-color:#000000;stop=
-opacity:1"=0D
> +     d=3D"m 215.11719,109.87695 90,-79.999997"=0D
> +     id=3D"path58"=0D
> +     sodipodi:nodetypes=3D"cc" />=0D
> +  <path=0D
> +     style=3D"font-variation-settings:normal;opacity:1;vector-effect:non=
e;fill:none;fill-opacity:1;stroke:#215fe5;stroke-width:1px;stroke-linecap:b=
utt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:4, 8;stroke-=
dashoffset:0;stroke-opacity:1;-inkscape-stroke:none;stop-color:#000000;stop=
-opacity:1"=0D
> +     d=3D"m 215.11719,137.87695 90,18"=0D
> +     id=3D"path59"=0D
> +     sodipodi:nodetypes=3D"cc" />=0D
> +  <text=0D
> +     x=3D"125.68945"=0D
> +     y=3D"172.06445"=0D
> +     class=3D"italic"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text59"=0D
> +     style=3D"font-style:italic;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:10px;font-family:sans-serif;-inkscape-font-spe=
cification:'sans-serif, Italic';font-variant-ligatures:normal;font-variant-=
caps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;text=
-anchor:middle;fill:#666666">one uint64_t word per node</text>=0D
> +  <text=0D
> +     x=3D"125.11719"=0D
> +     y=3D"214.87695"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text60"=0D
> +     style=3D"font-style:italic;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:10px;font-family:sans-serif;-inkscape-font-spe=
cification:'sans-serif, Italic';font-variant-ligatures:normal;font-variant-=
caps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;text=
-anchor:middle;fill:#666666;fill-opacity:1">Seeded to pending on walk start=
</text>=0D
> +  <rect=0D
> +     style=3D"fill:none;stroke:#000000;stroke-width:1;stroke-linecap:rou=
nd;stroke-linejoin:miter;stroke-dasharray:4.00001, 8;stroke-dashoffset:0;st=
roke-opacity:1;paint-order:markers fill stroke"=0D
> +     id=3D"rect22"=0D
> +     width=3D"90.698799"=0D
> +     height=3D"112.00012"=0D
> +     x=3D"439.24158"=0D
> +     y=3D"414.93521" />=0D
> +  <rect=0D
> +     x=3D"439.24158"=0D
> +     y=3D"414.93527"=0D
> +     width=3D"90.698799"=0D
> +     height=3D"22"=0D
> +     class=3D"cell"=0D
> +     style=3D"fill:#fbccff;fill-opacity:1;stroke:#000000;stroke-opacity:=
1"=0D
> +     id=3D"rect23" />=0D
> +  <text=0D
> +     x=3D"484.77899"=0D
> +     y=3D"429.57541"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     style=3D"font-size:10px"=0D
> +     id=3D"text23">xstat0</text>=0D
> +  <path=0D
> +     style=3D"font-variation-settings:normal;opacity:1;vector-effect:non=
e;fill:none;fill-opacity:1;stroke:#f04dff;stroke-width:1px;stroke-linecap:b=
utt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:4, 8;stroke-=
dashoffset:0;stroke-opacity:1;-inkscape-stroke:none;stop-color:#000000;stop=
-opacity:1"=0D
> +     d=3D"M 215.11719,483.66296 439.24158,526.9353"=0D
> +     id=3D"path54"=0D
> +     sodipodi:nodetypes=3D"cc" />=0D
> +  <rect=0D
> +     x=3D"35.117188"=0D
> +     y=3D"445.26996"=0D
> +     width=3D"180"=0D
> +     height=3D"38.393005"=0D
> +     class=3D"cell"=0D
> +     id=3D"rect54"=0D
> +     style=3D"fill:#fbccff;fill-opacity:1;stroke:#000000;stroke-opacity:=
1" />=0D
> +  <text=0D
> +     x=3D"125.11719"=0D
> +     y=3D"468.94009"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text56">Node 7 xstats</text>=0D
> +  <rect=0D
> +     x=3D"35.117188"=0D
> +     y=3D"491.9743"=0D
> +     width=3D"180"=0D
> +     height=3D"38.393005"=0D
> +     class=3D"cell"=0D
> +     id=3D"rect56"=0D
> +     style=3D"fill:#fbccff;fill-opacity:1;stroke:#000000;stroke-opacity:=
1" />=0D
> +  <text=0D
> +     x=3D"125.11719"=0D
> +     y=3D"515.64447"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text57">Node N xstats</text>=0D
> +  <text=0D
> +     x=3D"120.69043"=0D
> +     y=3D"488.99603"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text58">...</text>=0D
> +  <line=0D
> +     x1=3D"542.88934"=0D
> +     y1=3D"414.93527"=0D
> +     x2=3D"542.88934"=0D
> +     y2=3D"526.9353"=0D
> +     class=3D"brace-line"=0D
> +     id=3D"line61" />=0D
> +  <line=0D
> +     x1=3D"537.88934"=0D
> +     y1=3D"414.93527"=0D
> +     x2=3D"542.88934"=0D
> +     y2=3D"414.93527"=0D
> +     class=3D"brace-line"=0D
> +     id=3D"line62" />=0D
> +  <line=0D
> +     x1=3D"537.88934"=0D
> +     y1=3D"526.9353"=0D
> +     x2=3D"542.88934"=0D
> +     y2=3D"526.9353"=0D
> +     class=3D"brace-line"=0D
> +     id=3D"line63" />=0D
> +  <text=0D
> +     x=3D"576.78027"=0D
> +     y=3D"467.90891"=0D
> +     class=3D"brace"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text63"><tspan=0D
> +       sodipodi:role=3D"line"=0D
> +       id=3D"tspan63"=0D
> +       x=3D"576.78027"=0D
> +       y=3D"467.90891">cache</tspan><tspan=0D
> +       sodipodi:role=3D"line"=0D
> +       id=3D"tspan64"=0D
> +       x=3D"576.78027"=0D
> +       y=3D"482.90891">line</tspan></text>=0D
> +  <rect=0D
> +     x=3D"439.24158"=0D
> +     y=3D"436.93527"=0D
> +     width=3D"90.698799"=0D
> +     height=3D"22"=0D
> +     class=3D"cell"=0D
> +     style=3D"fill:#fbccff;fill-opacity:1;stroke:#000000;stroke-opacity:=
1"=0D
> +     id=3D"rect64" />=0D
> +  <text=0D
> +     x=3D"484.77899"=0D
> +     y=3D"451.57541"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     style=3D"font-size:10px"=0D
> +     id=3D"text64">xstat1</text>=0D
> +  <rect=0D
> +     x=3D"439.24158"=0D
> +     y=3D"470.93527"=0D
> +     width=3D"90.698799"=0D
> +     height=3D"22"=0D
> +     class=3D"cell"=0D
> +     style=3D"fill:#fbccff;fill-opacity:1;stroke:#000000;stroke-opacity:=
1"=0D
> +     id=3D"rect65" />=0D
> +  <text=0D
> +     x=3D"484.77899"=0D
> +     y=3D"485.57541"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     style=3D"font-size:10px"=0D
> +     id=3D"text65">xstatN</text>=0D
> +  <text=0D
> +     x=3D"485.8313"=0D
> +     y=3D"465.24936"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text66">...</text>=0D
> +  <path=0D
> +     style=3D"font-variation-settings:normal;opacity:1;vector-effect:non=
e;fill:none;fill-opacity:1;stroke:#f04dff;stroke-width:1px;stroke-linecap:b=
utt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:4, 8;stroke-=
dashoffset:0;stroke-opacity:1;-inkscape-stroke:none;stop-color:#000000;stop=
-opacity:1"=0D
> +     d=3D"M 215.11719,445.26996 439.24158,414.93527"=0D
> +     id=3D"path66"=0D
> +     sodipodi:nodetypes=3D"cc" />=0D
> +  <text=0D
> +     x=3D"669.32764"=0D
> +     y=3D"342.00354"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text67">...</text>=0D
> +  <path=0D
> +     style=3D"font-variation-settings:normal;opacity:1;vector-effect:non=
e;fill:none;fill-opacity:1;stroke:#ffbb4c;stroke-width:1px;stroke-linecap:b=
utt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:4, 8;stroke-=
dashoffset:0;stroke-opacity:1;-inkscape-stroke:none;marker-end:url(#Triangl=
e);stop-color:#000000;stop-opacity:1"=0D
> +     d=3D"M 272.58698,191.75977 221.56049,164.4668"=0D
> +     id=3D"path67"=0D
> +     sodipodi:nodetypes=3D"cc" />=0D
> +  <text=0D
> +     x=3D"318.07004"=0D
> +     y=3D"192.13014"=0D
> +     class=3D"label"=0D
> +     text-anchor=3D"middle"=0D
> +     id=3D"text68"><tspan=0D
> +       sodipodi:role=3D"line"=0D
> +       id=3D"tspan68"=0D
> +       x=3D"318.07004"=0D
> +       y=3D"192.13014">bit set to 1</tspan><tspan=0D
> +       sodipodi:role=3D"line"=0D
> +       id=3D"tspan69"=0D
> +       x=3D"318.07004"=0D
> +       y=3D"207.13014">when node has work</tspan></text>=0D
>  </svg>=0D
> diff --git a/lib/graph/graph.c b/lib/graph/graph.c=0D
> index 5f8ada218552..58e4ec1bc519 100644=0D
> --- a/lib/graph/graph.c=0D
> +++ b/lib/graph/graph.c=0D
> @@ -334,20 +334,6 @@ graph_mem_fixup_secondary(struct rte_graph *graph)=0D
>  	return graph_mem_fixup_node_ctx(graph);=0D
>  }=0D
>=0D
> -static bool=0D
> -graph_src_node_avail(struct graph *graph)=0D
> -{=0D
> -	struct graph_node *graph_node;=0D
> -=0D
> -	STAILQ_FOREACH(graph_node, &graph->node_list, next)=0D
> -		if ((graph_node->node->flags & RTE_NODE_SOURCE_F) &&=0D
> -		    (graph_node->node->lcore_id =3D=3D RTE_MAX_LCORE ||=0D
> -		     graph->lcore_id =3D=3D graph_node->node->lcore_id))=0D
> -			return true;=0D
> -=0D
> -	return false;=0D
> -}=0D
> -=0D
>  RTE_EXPORT_SYMBOL(rte_graph_model_mcore_dispatch_core_bind)=0D
>  int=0D
>  rte_graph_model_mcore_dispatch_core_bind(rte_graph_t id, int lcore)=0D
> @@ -375,9 +361,8 @@ rte_graph_model_mcore_dispatch_core_bind(rte_graph_t =
id, int lcore)=0D
>  	graph->graph->dispatch.lcore_id =3D graph->lcore_id;=0D
>  	graph->socket =3D rte_lcore_to_socket_id(lcore);=0D
>=0D
> -	/* check the availability of source node */=0D
> -	if (!graph_src_node_avail(graph))=0D
> -		graph->graph->head =3D 0;=0D
> +	/* Rebuild source bitmap with only source nodes bound to this lcore */=
=0D
> +	graph_src_bitmap_rebuild(graph);=0D
>=0D
>  	return 0;=0D
>=0D
> @@ -484,6 +469,10 @@ rte_graph_create(const char *name, struct rte_graph_=
param *prm)=0D
>  	if (graph_has_isolated_node(graph))=0D
>  		goto graph_cleanup;=0D
>=0D
> +	/* Compute topological depth for bitmap scheduling order */=0D
> +	if (graph_topo_order_compute(graph))=0D
> +		goto graph_cleanup;=0D
> +=0D
>  	/* Initialize pcap config. */=0D
>  	graph_pcap_enable(prm->pcap_enable);=0D
>=0D
> @@ -598,6 +587,10 @@ graph_clone(struct graph *parent_graph, const char *=
name, struct rte_graph_param=0D
>  	if (graph_adjacency_list_update(graph))=0D
>  		goto graph_cleanup;=0D
>=0D
> +	/* Compute topological depth for bitmap scheduling order */=0D
> +	if (graph_topo_order_compute(graph))=0D
> +		goto graph_cleanup;=0D
> +=0D
>  	/* Initialize the graph object */=0D
>  	graph->src_node_count =3D parent_graph->src_node_count;=0D
>  	graph->node_count =3D parent_graph->node_count;=0D
> diff --git a/lib/graph/graph_debug.c b/lib/graph/graph_debug.c=0D
> index e3b8cccdc1f0..8e99fa1b0fb8 100644=0D
> --- a/lib/graph/graph_debug.c=0D
> +++ b/lib/graph/graph_debug.c=0D
> @@ -15,8 +15,8 @@ graph_dump(FILE *f, struct graph *g)=0D
>=0D
>  	fprintf(f, "graph <%s>\n", g->name);=0D
>  	fprintf(f, "  id=3D%" PRIu32 "\n", g->id);=0D
> -	fprintf(f, "  cir_start=3D%" PRIu32 "\n", g->cir_start);=0D
> -	fprintf(f, "  cir_mask=3D%" PRIu32 "\n", g->cir_mask);=0D
> +	fprintf(f, "  sched_table_off=3D%" PRIu32 "\n", g->sched_table_off);=0D
> +	fprintf(f, "  nb_sched_words=3D%" PRIu16 "\n", g->nb_sched_words);=0D
>  	fprintf(f, "  addr=3D%p\n", g);=0D
>  	fprintf(f, "  graph=3D%p\n", g->graph);=0D
>  	fprintf(f, "  mem_sz=3D%zu\n", g->mem_sz);=0D
> @@ -63,14 +63,14 @@ rte_graph_obj_dump(FILE *f, struct rte_graph *g, bool=
 all)=0D
>=0D
>  	fprintf(f, "graph <%s> @ %p\n", g->name, g);=0D
>  	fprintf(f, "  id=3D%" PRIu32 "\n", g->id);=0D
> -	fprintf(f, "  head=3D%" PRId32 "\n", (int32_t)g->head);=0D
> -	fprintf(f, "  tail=3D%" PRId32 "\n", (int32_t)g->tail);=0D
> -	fprintf(f, "  cir_mask=3D0x%" PRIx32 "\n", g->cir_mask);=0D
>  	fprintf(f, "  nb_nodes=3D%" PRId32 "\n", g->nb_nodes);=0D
> +	fprintf(f, "  nb_sched_words=3D%" PRIu16 "\n", g->nb_sched_words);=0D
>  	fprintf(f, "  socket=3D%d\n", g->socket);=0D
>  	fprintf(f, "  fence=3D0x%" PRIx64 "\n", g->fence);=0D
>  	fprintf(f, "  nodes_start=3D0x%" PRIx32 "\n", g->nodes_start);=0D
> -	fprintf(f, "  cir_start=3D%p\n", g->cir_start);=0D
> +	fprintf(f, "  sched_table=3D%p\n", g->sched_table);=0D
> +	fprintf(f, "  pending=3D%p\n", g->pending);=0D
> +	fprintf(f, "  src_pending=3D%p\n", g->src_pending);=0D
>=0D
>  	rte_graph_foreach_node(count, off, g, n) {=0D
>  		if (!all && n->idx =3D=3D 0)=0D
> diff --git a/lib/graph/graph_ops.c b/lib/graph/graph_ops.c=0D
> index a3548ec804f6..6e114ff667be 100644=0D
> --- a/lib/graph/graph_ops.c=0D
> +++ b/lib/graph/graph_ops.c=0D
> @@ -167,3 +167,49 @@ graph_has_isolated_node(struct graph *graph)=0D
>  fail:=0D
>  	return 1;=0D
>  }=0D
> +=0D
> +int=0D
> +graph_topo_order_compute(struct graph *graph)=0D
> +{=0D
> +	struct graph_node **queue, *v;=0D
> +	uint16_t head =3D 0, tail =3D 0;=0D
> +	struct graph_node *graph_node;=0D
> +	rte_node_t nb_nodes;=0D
> +	rte_edge_t i;=0D
> +	size_t sz;=0D
> +=0D
> +	nb_nodes =3D graph_nodes_count(graph);=0D
> +	/* Queue may contain duplicates in diamond-shaped graphs */=0D
> +	sz =3D sizeof(struct graph_node *) * nb_nodes * nb_nodes;=0D
> +	queue =3D malloc(sz);=0D
> +	if (queue =3D=3D NULL)=0D
> +		SET_ERR_JMP(ENOMEM, fail, "Failed to alloc topo queue");=0D
> +=0D
> +	STAILQ_FOREACH(graph_node, &graph->node_list, next)=0D
> +		graph_node->topo_order =3D 0;=0D
> +=0D
> +	STAILQ_FOREACH(graph_node, &graph->node_list, next) {=0D
> +		if (graph_node->node->flags & RTE_NODE_SOURCE_F)=0D
> +			queue[tail++] =3D graph_node;=0D
> +	}=0D
> +=0D
> +	while (head !=3D tail) {=0D
> +		v =3D queue[head++];=0D
> +		for (i =3D 0; i < v->node->nb_edges; i++) {=0D
> +			struct graph_node *child =3D v->adjacency_list[i];=0D
> +			uint32_t depth =3D v->topo_order + 1;=0D
> +=0D
> +			/* Cap depth at nb_nodes to handle cycles */=0D
> +			if (depth > child->topo_order && depth <=3D nb_nodes) {=0D
> +				child->topo_order =3D depth;=0D
> +				queue[tail++] =3D child;=0D
> +			}=0D
> +		}=0D
> +	}=0D
> +=0D
> +	free(queue);=0D
> +	return 0;=0D
> +=0D
> +fail:=0D
> +	return -rte_errno;=0D
> +}=0D
> diff --git a/lib/graph/graph_populate.c b/lib/graph/graph_populate.c=0D
> index 026daecb2122..5c6829a7c756 100644=0D
> --- a/lib/graph/graph_populate.c=0D
> +++ b/lib/graph/graph_populate.c=0D
> @@ -3,6 +3,8 @@=0D
>   */=0D
>=0D
>=0D
> +#include <stdlib.h>=0D
> +=0D
>  #include <rte_common.h>=0D
>  #include <rte_errno.h>=0D
>  #include <rte_malloc.h>=0D
> @@ -15,19 +17,27 @@ static size_t=0D
>  graph_fp_mem_calc_size(struct graph *graph)=0D
>  {=0D
>  	struct graph_node *graph_node;=0D
> -	rte_node_t val;=0D
> +	uint16_t nwords;=0D
>  	size_t sz;=0D
>=0D
>  	/* Graph header */=0D
>  	sz =3D sizeof(struct rte_graph);=0D
> -	/* Source nodes list */=0D
> -	sz +=3D sizeof(rte_graph_off_t) * graph->src_node_count;=0D
> -	/* Circular buffer for pending streams of size number of nodes */=0D
> -	val =3D rte_align32pow2(graph->node_count * sizeof(rte_graph_off_t));=0D
> -	sz =3D RTE_ALIGN(sz, val);=0D
> -	graph->cir_start =3D sz;=0D
> -	graph->cir_mask =3D rte_align32pow2(graph->node_count) - 1;=0D
> -	sz +=3D val;=0D
> +=0D
> +	/* Schedule table: node offset indexed by sched_idx */=0D
> +	sz =3D RTE_ALIGN(sz, RTE_CACHE_LINE_SIZE);=0D
> +	graph->sched_table_off =3D sz;=0D
> +	sz +=3D sizeof(rte_graph_off_t) * graph->node_count;=0D
> +=0D
> +	/* Pending and source pending bitmaps */=0D
> +	nwords =3D (graph->node_count + 63) / 64;=0D
> +	graph->nb_sched_words =3D nwords;=0D
> +	sz =3D RTE_ALIGN(sz, RTE_CACHE_LINE_SIZE);=0D
> +	graph->pending_off =3D sz;=0D
> +	sz +=3D sizeof(uint64_t) * nwords;=0D
> +	sz =3D RTE_ALIGN(sz, RTE_CACHE_LINE_SIZE);=0D
> +	graph->src_pending_off =3D sz;=0D
> +	sz +=3D sizeof(uint64_t) * nwords;=0D
> +=0D
>  	/* Fence */=0D
>  	sz +=3D sizeof(RTE_GRAPH_FENCE);=0D
>  	sz =3D RTE_ALIGN(sz, RTE_CACHE_LINE_SIZE);=0D
> @@ -54,20 +64,34 @@ graph_fp_mem_calc_size(struct graph *graph)=0D
>  }=0D
>=0D
>  static void=0D
> -graph_header_popluate(struct graph *_graph)=0D
> +graph_header_populate(struct graph *_graph)=0D
>  {=0D
>  	struct rte_graph *graph =3D _graph->graph;=0D
>=0D
> -	graph->tail =3D 0;=0D
> -	graph->head =3D (int32_t)-_graph->src_node_count;=0D
> -	graph->cir_mask =3D _graph->cir_mask;=0D
>  	graph->nb_nodes =3D _graph->node_count;=0D
> -	graph->cir_start =3D RTE_PTR_ADD(graph, _graph->cir_start);=0D
> +	graph->nb_sched_words =3D _graph->nb_sched_words;=0D
> +	graph->sched_table =3D RTE_PTR_ADD(graph, _graph->sched_table_off);=0D
> +	graph->pending =3D RTE_PTR_ADD(graph, _graph->pending_off);=0D
> +	graph->src_pending =3D RTE_PTR_ADD(graph, _graph->src_pending_off);=0D
>  	graph->nodes_start =3D _graph->nodes_start;=0D
>  	graph->socket =3D _graph->socket;=0D
>  	graph->id =3D _graph->id;=0D
>  	memcpy(graph->name, _graph->name, RTE_GRAPH_NAMESIZE);=0D
>  	graph->fence =3D RTE_GRAPH_FENCE;=0D
> +=0D
> +	memset(graph->pending, 0, sizeof(uint64_t) * _graph->nb_sched_words);=0D
> +	memset(graph->src_pending, 0, sizeof(uint64_t) * _graph->nb_sched_words=
);=0D
> +}=0D
> +=0D
> +static int=0D
> +graph_node_topo_cmp(const void *a, const void *b)=0D
> +{=0D
> +	const struct graph_node *const *na =3D a;=0D
> +	const struct graph_node *const *nb =3D b;=0D
> +=0D
> +	if ((*na)->topo_order !=3D (*nb)->topo_order)=0D
> +		return (int)(*na)->topo_order - (int)(*nb)->topo_order;=0D
> +	return (int)(*na)->node->id - (int)(*nb)->node->id;=0D
>  }=0D
>=0D
>  static void=0D
> @@ -76,15 +100,26 @@ graph_nodes_populate(struct graph *_graph)=0D
>  	rte_graph_off_t xstat_off =3D _graph->xstats_start;=0D
>  	rte_graph_off_t off =3D _graph->nodes_start;=0D
>  	struct rte_graph *graph =3D _graph->graph;=0D
> -	struct graph_node *graph_node;=0D
> +	struct graph_node **sorted, *graph_node;=0D
>  	rte_edge_t count, nb_edges;=0D
>  	rte_node_t pid;=0D
> +	uint32_t n;=0D
>=0D
> -	STAILQ_FOREACH(graph_node, &_graph->node_list, next) {=0D
> +	/* Build a sorted array of graph_node pointers by (topo_order, id) */=0D
> +	sorted =3D calloc(_graph->node_count, sizeof(*sorted));=0D
> +	RTE_VERIFY(sorted !=3D NULL);=0D
> +	n =3D 0;=0D
> +	STAILQ_FOREACH(graph_node, &_graph->node_list, next)=0D
> +		sorted[n++] =3D graph_node;=0D
> +	qsort(sorted, n, sizeof(*sorted), graph_node_topo_cmp);=0D
> +=0D
> +	for (n =3D 0; n < _graph->node_count; n++) {=0D
> +		graph_node =3D sorted[n];=0D
>  		struct rte_node *node =3D RTE_PTR_ADD(graph, off);=0D
>  		memset(node, 0, sizeof(*node));=0D
>  		node->fence =3D RTE_GRAPH_FENCE;=0D
>  		node->off =3D off;=0D
> +		node->sched_idx =3D n;=0D
>  		if (graph_pcap_is_enable()) {=0D
>  			node->process =3D graph_pcap_dispatch;=0D
>  			node->original_process =3D graph_node->node->process;=0D
> @@ -123,8 +158,14 @@ graph_nodes_populate(struct graph *_graph)=0D
>  		off +=3D sizeof(struct rte_node *) * nb_edges;=0D
>  		off =3D RTE_ALIGN(off, RTE_CACHE_LINE_SIZE);=0D
>  		node->next =3D off;=0D
> +=0D
> +		/* Fill the schedule table */=0D
> +		graph->sched_table[n] =3D node->off;=0D
> +=0D
>  		__rte_node_stream_alloc(graph, node);=0D
>  	}=0D
> +=0D
> +	free(sorted);=0D
>  }=0D
>=0D
>  struct rte_node *=0D
> @@ -179,12 +220,11 @@ graph_node_nexts_populate(struct graph *_graph)=0D
>  }=0D
>=0D
>  static int=0D
> -graph_src_nodes_offset_populate(struct graph *_graph)=0D
> +graph_src_bitmap_populate(struct graph *_graph)=0D
>  {=0D
>  	struct rte_graph *graph =3D _graph->graph;=0D
>  	struct graph_node *graph_node;=0D
>  	struct rte_node *node;=0D
> -	int32_t head =3D -1;=0D
>  	const char *name;=0D
>=0D
>  	STAILQ_FOREACH(graph_node, &_graph->node_list, next) {=0D
> @@ -195,7 +235,7 @@ graph_src_nodes_offset_populate(struct graph *_graph)=
=0D
>  				SET_ERR_JMP(EINVAL, fail, "%s not found", name);=0D
>=0D
>  			__rte_node_stream_alloc(graph, node);=0D
> -			graph->cir_start[head--] =3D node->off;=0D
> +			__rte_node_pending_set(graph->src_pending, node);=0D
>  		}=0D
>  	}=0D
>=0D
> @@ -204,17 +244,42 @@ graph_src_nodes_offset_populate(struct graph *_grap=
h)=0D
>  	return -rte_errno;=0D
>  }=0D
>=0D
> +void=0D
> +graph_src_bitmap_rebuild(struct graph *_graph)=0D
> +{=0D
> +	struct rte_graph *graph =3D _graph->graph;=0D
> +	struct graph_node *graph_node;=0D
> +	struct rte_node *node;=0D
> +	const char *name;=0D
> +=0D
> +	memset(graph->src_pending, 0,=0D
> +	       sizeof(uint64_t) * graph->nb_sched_words);=0D
> +=0D
> +	STAILQ_FOREACH(graph_node, &_graph->node_list, next) {=0D
> +		if (!(graph_node->node->flags & RTE_NODE_SOURCE_F))=0D
> +			continue;=0D
> +		if (graph_node->node->lcore_id !=3D RTE_MAX_LCORE &&=0D
> +		    graph_node->node->lcore_id !=3D _graph->lcore_id)=0D
> +			continue;=0D
> +		name =3D graph_node->node->name;=0D
> +		node =3D graph_node_name_to_ptr(graph, name);=0D
> +		if (node =3D=3D NULL)=0D
> +			continue;=0D
> +		__rte_node_pending_set(graph->src_pending, node);=0D
> +	}=0D
> +}=0D
> +=0D
>  static int=0D
>  graph_fp_mem_populate(struct graph *graph)=0D
>  {=0D
>  	int rc;=0D
>=0D
> -	graph_header_popluate(graph);=0D
> +	graph_header_populate(graph);=0D
>  	if (graph_pcap_is_enable())=0D
>  		graph_pcap_init(graph);=0D
>  	graph_nodes_populate(graph);=0D
>  	rc =3D graph_node_nexts_populate(graph);=0D
> -	rc |=3D graph_src_nodes_offset_populate(graph);=0D
> +	rc |=3D graph_src_bitmap_populate(graph);=0D
>=0D
>  	return rc;=0D
>  }=0D
> diff --git a/lib/graph/graph_private.h b/lib/graph/graph_private.h=0D
> index 26cdc6637192..6b986ea10b78 100644=0D
> --- a/lib/graph/graph_private.h=0D
> +++ b/lib/graph/graph_private.h=0D
> @@ -82,6 +82,7 @@ struct graph_node {=0D
>  	STAILQ_ENTRY(graph_node) next; /**< Next graph node in the list. */=0D
>  	struct node *node; /**< Pointer to internal node. */=0D
>  	bool visited;      /**< Flag used in BFS to mark node visited. */=0D
> +	uint32_t topo_order; /**< Topological depth from source nodes. */=0D
>  	struct graph_node *adjacency_list[]; /**< Adjacency list of the node. *=
/=0D
>  };=0D
>=0D
> @@ -98,19 +99,23 @@ struct graph {=0D
>  	const struct rte_memzone *mz;=0D
>  	/**< Memzone to store graph data. */=0D
>  	rte_graph_off_t nodes_start;=0D
> -	/**< Node memory start offset in graph reel. */=0D
> +	/**< Node memory start offset in graph memory. */=0D
>  	rte_graph_off_t xstats_start;=0D
> -	/**< Node xstats memory start offset in graph reel. */=0D
> +	/**< Node xstats memory start offset in graph memory. */=0D
>  	rte_node_t src_node_count;=0D
>  	/**< Number of source nodes in a graph. */=0D
>  	struct rte_graph *graph;=0D
>  	/**< Pointer to graph data. */=0D
>  	rte_node_t node_count;=0D
>  	/**< Total number of nodes. */=0D
> -	uint32_t cir_start;=0D
> -	/**< Circular buffer start offset in graph reel. */=0D
> -	uint32_t cir_mask;=0D
> -	/**< Circular buffer mask for wrap around. */=0D
> +	uint32_t sched_table_off;=0D
> +	/**< Schedule table start offset in graph memory. */=0D
> +	uint32_t pending_off;=0D
> +	/**< Pending bitmap start offset in graph memory. */=0D
> +	uint32_t src_pending_off;=0D
> +	/**< Source pending bitmap start offset in graph memory. */=0D
> +	uint16_t nb_sched_words;=0D
> +	/**< Number of uint64_t words in pending bitmaps. */=0D
>  	rte_graph_t id;=0D
>  	/**< Graph identifier. */=0D
>  	rte_graph_t parent_id;=0D
> @@ -347,6 +352,20 @@ rte_node_t graph_nodes_count(struct graph *graph);=0D
>   */=0D
>  void graph_mark_nodes_as_not_visited(struct graph *graph);=0D
>=0D
> +/**=0D
> + * @internal=0D
> + *=0D
> + * Compute topological depth for all nodes via BFS from source nodes.=0D
> + *=0D
> + * @param graph=0D
> + *   Pointer to the internal graph object.=0D
> + *=0D
> + * @return=0D
> + *   - 0: Success.=0D
> + *   - <0: Not enough memory for BFS queue.=0D
> + */=0D
> +int graph_topo_order_compute(struct graph *graph);=0D
> +=0D
>  /* Fast path graph memory populate unctions */=0D
>=0D
>  /**=0D
> @@ -378,6 +397,16 @@ int graph_fp_mem_create(struct graph *graph);=0D
>   */=0D
>  int graph_fp_mem_destroy(struct graph *graph);=0D
>=0D
> +/**=0D
> + * @internal=0D
> + *=0D
> + * Rebuild the source pending bitmap based on lcore affinity.=0D
> + *=0D
> + * @param graph=0D
> + *   Pointer to the internal graph object.=0D
> + */=0D
> +void graph_src_bitmap_rebuild(struct graph *graph);=0D
> +=0D
>  /* Lookup functions */=0D
>  /**=0D
>   * @internal=0D
> diff --git a/lib/graph/rte_graph_model_mcore_dispatch.h b/lib/graph/rte_g=
raph_model_mcore_dispatch.h=0D
> index e39d0e9abd70..b11068886cb1 100644=0D
> --- a/lib/graph/rte_graph_model_mcore_dispatch.h=0D
> +++ b/lib/graph/rte_graph_model_mcore_dispatch.h=0D
> @@ -77,9 +77,13 @@ int rte_graph_model_mcore_dispatch_node_lcore_affinity=
_set(const char *name,=0D
>  							   unsigned int lcore_id);=0D
>=0D
>  /**=0D
> - * Perform graph walk on the circular buffer and invoke the process func=
tion=0D
> + * Perform graph walk on the pending bitmap and invoke the process funct=
ion=0D
>   * of the nodes and collect the stats.=0D
>   *=0D
> + * Nodes are visited in topological order (upstream before downstream).=
=0D
> + * Source nodes are seeded into the pending bitmap at the start of each =
walk.=0D
> + * Nodes with different lcore affinity are dispatched to their target lc=
ore.=0D
> + *=0D
>   * @param graph=0D
>   *   Graph pointer returned from rte_graph_lookup function.=0D
>   *=0D
> @@ -88,20 +92,28 @@ int rte_graph_model_mcore_dispatch_node_lcore_affinit=
y_set(const char *name,=0D
>  static inline void=0D
>  rte_graph_walk_mcore_dispatch(struct rte_graph *graph)=0D
>  {=0D
> -	const rte_graph_off_t *cir_start =3D graph->cir_start;=0D
> -	const rte_node_t mask =3D graph->cir_mask;=0D
> -	uint32_t head =3D graph->head;=0D
> +	const uint16_t nwords =3D graph->nb_sched_words;=0D
>  	struct rte_node *node;=0D
> +	uint16_t word, bit;=0D
>=0D
>  	if (graph->dispatch.wq !=3D NULL)=0D
>  		__rte_graph_mcore_dispatch_sched_wq_process(graph);=0D
>=0D
> -	while (likely(head !=3D graph->tail)) {=0D
> -		node =3D (struct rte_node *)RTE_PTR_ADD(graph, cir_start[(int32_t)head=
++]);=0D
> +	/* Seed pending bitmap with source nodes bound to this lcore */=0D
> +	for (word =3D 0; word < nwords; word++)=0D
> +		graph->pending[word] |=3D graph->src_pending[word];=0D
>=0D
> -		/* skip the src nodes which not bind with current worker */=0D
> -		if ((int32_t)head < 1 && node->dispatch.lcore_id !=3D graph->dispatch.=
lcore_id)=0D
> -			continue;=0D
> +	for (;;) {=0D
> +		/* find first word with any pending bit */=0D
> +		for (word =3D 0; word < nwords; word++)=0D
> +			if (graph->pending[word])=0D
> +				break;=0D
> +		if (word =3D=3D nwords)=0D
> +			break; /* no more pending nodes */=0D
> +=0D
> +		bit =3D rte_ctz64(graph->pending[word]);=0D
> +		graph->pending[word] &=3D ~(1ULL << bit);=0D
> +		node =3D __rte_graph_pending_node(graph, word, bit);=0D
>=0D
>  		/* Schedule the node until all task/objs are done */=0D
>  		if (node->dispatch.lcore_id !=3D RTE_MAX_LCORE &&=0D
> @@ -111,11 +123,7 @@ rte_graph_walk_mcore_dispatch(struct rte_graph *grap=
h)=0D
>  			continue;=0D
>=0D
>  		__rte_node_process(graph, node);=0D
> -=0D
> -		head =3D likely((int32_t)head > 0) ? head & mask : head;=0D
>  	}=0D
> -=0D
> -	graph->tail =3D 0;=0D
>  }=0D
>=0D
>  #ifdef __cplusplus=0D
> diff --git a/lib/graph/rte_graph_model_rtc.h b/lib/graph/rte_graph_model_=
rtc.h=0D
> index 4b6236e301e3..8b3f29ffe318 100644=0D
> --- a/lib/graph/rte_graph_model_rtc.h=0D
> +++ b/lib/graph/rte_graph_model_rtc.h=0D
> @@ -6,9 +6,12 @@=0D
>  #include "rte_graph_worker_common.h"=0D
>=0D
>  /**=0D
> - * Perform graph walk on the circular buffer and invoke the process func=
tion=0D
> + * Perform graph walk on the pending bitmap and invoke the process funct=
ion=0D
>   * of the nodes and collect the stats.=0D
>   *=0D
> + * Nodes are visited in topological order (upstream before downstream).=
=0D
> + * Source nodes are seeded into the pending bitmap at the start of each =
walk.=0D
> + *=0D
>   * @param graph=0D
>   *   Graph pointer returned from rte_graph_lookup function.=0D
>   *=0D
> @@ -17,30 +20,50 @@=0D
>  static inline void=0D
>  rte_graph_walk_rtc(struct rte_graph *graph)=0D
>  {=0D
> -	const rte_graph_off_t *cir_start =3D graph->cir_start;=0D
> -	const rte_node_t mask =3D graph->cir_mask;=0D
> -	uint32_t head =3D graph->head;=0D
> +	const uint16_t nwords =3D graph->nb_sched_words;=0D
>  	struct rte_node *node;=0D
> +	uint16_t word, bit;=0D
>=0D
>  	/*=0D
> -	 * Walk on the source node(s) ((cir_start - head) -> cir_start) and the=
n=0D
> -	 * on the pending streams (cir_start -> (cir_start + mask) -> cir_start=
)=0D
> -	 * in a circular buffer fashion.=0D
> +	 * Nodes are assigned a bit position (sched_idx) sorted by=0D
> +	 * (topo_order, node_id) at graph creation time. Source nodes have=0D
> +	 * topo_order 0, so they always come first.=0D
>  	 *=0D
> -	 *	+-----+ <=3D cir_start - head [number of source nodes]=0D
> -	 *	|     |=0D
> -	 *	| ... | <=3D source nodes=0D
> -	 *	|     |=0D
> -	 *	+-----+ <=3D cir_start [head =3D 0] [tail =3D 0]=0D
> -	 *	|     |=0D
> -	 *	| ... | <=3D pending streams=0D
> -	 *	|     |=0D
> -	 *	+-----+ <=3D cir_start + mask=0D
> +	 * sched_table[] maps bit positions to node offsets:=0D
> +	 *=0D
> +	 *   pending[]         sched_table[]=0D
> +	 *   +----------+      +------------------+=0D
> +	 *   | word 0   | ---> | src_node_0       | bit 0 (depth=3D0)=0D
> +	 *   | 1100...1 |      | src_node_1       | bit 1 (depth=3D0)=0D
> +	 *   |          |      | eth_input        | bit 2 (depth=3D1)=0D
> +	 *   |          |      | mpls_input       | bit 3 (depth=3D2)=0D
> +	 *   |          |      | ipv4_input       | bit 4 (depth=3D3)=0D
> +	 *   |          |      | ...              |=0D
> +	 *   +----------+      +------------------+=0D
> +	 *   | word 1   | ---> | ip4_rewrite      | bit 64 (depth=3D4)=0D
> +	 *   | ...      |      | ...              |=0D
> +	 *   +----------+      +------------------+=0D
> +	 *=0D
> +	 * Walk: for each word, find lowest set bit (rte_ctz64), process=0D
> +	 * that node, clear the bit, re-read the word (processing may=0D
> +	 * have set new bits), repeat.=0D
>  	 */=0D
> -	while (likely(head !=3D graph->tail)) {=0D
> -		node =3D (struct rte_node *)RTE_PTR_ADD(graph, cir_start[(int32_t)head=
++]);=0D
> +=0D
> +	/* Seed pending bitmap with source nodes */=0D
> +	for (word =3D 0; word < nwords; word++)=0D
> +		graph->pending[word] |=3D graph->src_pending[word];=0D
> +=0D
> +	for (;;) {=0D
> +		/* find first word with any pending bit */=0D
> +		for (word =3D 0; word < nwords; word++)=0D
> +			if (graph->pending[word])=0D
> +				break;=0D
> +		if (word =3D=3D nwords)=0D
> +			break; /* no more pending nodes */=0D
> +=0D
> +		bit =3D rte_ctz64(graph->pending[word]);=0D
> +		graph->pending[word] &=3D ~(1ULL << bit);=0D
> +		node =3D __rte_graph_pending_node(graph, word, bit);=0D
>  		__rte_node_process(graph, node);=0D
> -		head =3D likely((int32_t)head > 0) ? head & mask : head;=0D
>  	}=0D
> -	graph->tail =3D 0;=0D
>  }=0D
> diff --git a/lib/graph/rte_graph_worker.h b/lib/graph/rte_graph_worker.h=
=0D
> index b0f952a82cc9..e513d7a655d9 100644=0D
> --- a/lib/graph/rte_graph_worker.h=0D
> +++ b/lib/graph/rte_graph_worker.h=0D
> @@ -14,7 +14,7 @@ extern "C" {=0D
>  #endif=0D
>=0D
>  /**=0D
> - * Perform graph walk on the circular buffer and invoke the process func=
tion=0D
> + * Perform graph walk on the pending bitmap and invoke the process funct=
ion=0D
>   * of the nodes and collect the stats.=0D
>   *=0D
>   * @param graph=0D
> diff --git a/lib/graph/rte_graph_worker_common.h b/lib/graph/rte_graph_wo=
rker_common.h=0D
> index 4ab53a533e4c..53cb7c113508 100644=0D
> --- a/lib/graph/rte_graph_worker_common.h=0D
> +++ b/lib/graph/rte_graph_worker_common.h=0D
> @@ -49,15 +49,14 @@ SLIST_HEAD(rte_graph_rq_head, rte_graph);=0D
>   */=0D
>  struct __rte_cache_aligned rte_graph {=0D
>  	/* Fast path area. */=0D
> -	uint32_t tail;		     /**< Tail of circular buffer. */=0D
> -	uint32_t head;		     /**< Head of circular buffer. */=0D
> -	uint32_t cir_mask;	     /**< Circular buffer wrap around mask. */=0D
>  	rte_node_t nb_nodes;	     /**< Number of nodes in the graph. */=0D
> -	rte_graph_off_t *cir_start;  /**< Pointer to circular buffer. */=0D
>  	rte_graph_off_t nodes_start; /**< Offset at which node memory starts. *=
/=0D
> +	rte_graph_off_t *sched_table; /**< Node offset indexed by sched_idx. */=
=0D
> +	uint64_t *pending;	     /**< Bitmap of pending nodes. */=0D
> +	uint64_t *src_pending;	     /**< Bitmap of source nodes (constant). */=
=0D
> +	uint16_t nb_sched_words;     /**< Number of uint64_t words in pending b=
itmaps. */=0D
>  	uint8_t model;		     /**< graph model */=0D
> -	uint8_t reserved1;	     /**< Reserved for future use. */=0D
> -	uint16_t reserved2;	     /**< Reserved for future use. */=0D
> +	/* 26 bytes padding */=0D
>  	union {=0D
>  		/* Fast schedule area for mcore dispatch model */=0D
>  		struct {=0D
> @@ -98,6 +97,7 @@ struct __rte_cache_aligned rte_node {=0D
>  	rte_node_t id;		/**< Node identifier. */=0D
>  	rte_node_t parent_id;	/**< Parent Node identifier. */=0D
>  	rte_edge_t nb_edges;	/**< Number of edges from this node. */=0D
> +	uint16_t sched_idx;	/**< Bit position in pending bitmap. */=0D
>  	uint32_t realloc_count;	/**< Number of times realloced. */=0D
>=0D
>  	char parent[RTE_NODE_NAMESIZE];	/**< Parent node name. */=0D
> @@ -132,7 +132,7 @@ struct __rte_cache_aligned rte_node {=0D
>  		}; /**< Node Context. */=0D
>  		uint16_t size;		/**< Total number of objects available. */=0D
>  		uint16_t idx;		/**< Number of objects used. */=0D
> -		rte_graph_off_t off;	/**< Offset of node in the graph reel. */=0D
> +		rte_graph_off_t off;	/**< Offset of node in the graph memory. */=0D
>  		uint64_t total_cycles;	/**< Cycles spent in this node. */=0D
>  		uint64_t total_calls;	/**< Calls done to this node. */=0D
>  		uint64_t total_objs;	/**< Objects processed by this node. */=0D
> @@ -187,12 +187,12 @@ void __rte_node_stream_alloc_size(struct rte_graph =
*graph,=0D
>  /**=0D
>   * @internal=0D
>   *=0D
> - * Enqueue a given node to the tail of the graph reel.=0D
> + * Process a node's pending objects and collect stats.=0D
>   *=0D
>   * @param graph=0D
>   *   Pointer Graph object.=0D
>   * @param node=0D
> - *   Pointer to node object to be enqueued.=0D
> + *   Pointer to node object to be processed.=0D
>   */=0D
>  static __rte_always_inline void=0D
>  __rte_node_process(struct rte_graph *graph, struct rte_node *node)=0D
> @@ -220,21 +220,42 @@ __rte_node_process(struct rte_graph *graph, struct =
rte_node *node)=0D
>  /**=0D
>   * @internal=0D
>   *=0D
> - * Enqueue a given node to the tail of the graph reel.=0D
> + * Get a pointer to a node from the scheduling table.=0D
>   *=0D
>   * @param graph=0D
>   *   Pointer Graph object.=0D
> + * @param word=0D
> + *   Offset in the pending bitmap.=0D
> + * @param bit=0D
> + *   Bit number.=0D
> + *=0D
> + * @return=0D
> + *   Pointer to the node.=0D
> + */=0D
> +static __rte_always_inline struct rte_node *=0D
> +__rte_graph_pending_node(struct rte_graph *graph, uint16_t word, uint16_=
t bit)=0D
> +{=0D
> +	const uint16_t index =3D (word * sizeof(*graph->pending) * CHAR_BIT) + =
bit;=0D
> +	const rte_graph_off_t node_offset =3D graph->sched_table[index];=0D
> +	return RTE_PTR_ADD(graph, node_offset);=0D
> +}=0D
> +=0D
> +/**=0D
> + * @internal=0D
> + *=0D
> + * Mark a node as pending in the graph scheduling bitmap.=0D
> + *=0D
> + * @param bitmap=0D
> + *   Either graph->pending or graph->src_pending.=0D
>   * @param node=0D
> - *   Pointer to node object to be enqueued.=0D
> + *   Pointer to node object to be marked pending.=0D
>   */=0D
>  static __rte_always_inline void=0D
> -__rte_node_enqueue_tail_update(struct rte_graph *graph, struct rte_node =
*node)=0D
> +__rte_node_pending_set(uint64_t *bitmap, struct rte_node *node)=0D
>  {=0D
> -	uint32_t tail;=0D
> -=0D
> -	tail =3D graph->tail;=0D
> -	graph->cir_start[tail++] =3D node->off;=0D
> -	graph->tail =3D tail & graph->cir_mask;=0D
> +	const uint16_t word =3D node->sched_idx / (sizeof(*bitmap) * CHAR_BIT);=
=0D
> +	const uint16_t bit =3D node->sched_idx % (sizeof(*bitmap) * CHAR_BIT);=
=0D
> +	bitmap[word] |=3D 1ULL << bit;=0D
>  }=0D
>=0D
>  /**=0D
> @@ -242,8 +263,8 @@ __rte_node_enqueue_tail_update(struct rte_graph *grap=
h, struct rte_node *node)=0D
>   *=0D
>   * Enqueue sequence prologue function.=0D
>   *=0D
> - * Updates the node to tail of graph reel and resizes the number of obje=
cts=0D
> - * available in the stream as needed.=0D
> + * Marks the node as pending in the scheduling bitmap and resizes the nu=
mber=0D
> + * of objects available in the stream as needed.=0D
>   *=0D
>   * @param graph=0D
>   *   Pointer to the graph object.=0D
> @@ -259,9 +280,8 @@ __rte_node_enqueue_prologue(struct rte_graph *graph, =
struct rte_node *node,=0D
>  			    const uint16_t idx, const uint16_t space)=0D
>  {=0D
>=0D
> -	/* Add to the pending stream list if the node is new */=0D
>  	if (idx =3D=3D 0)=0D
> -		__rte_node_enqueue_tail_update(graph, node);=0D
> +		__rte_node_pending_set(graph->pending, node);=0D
>=0D
>  	if (unlikely(node->size < (idx + space)))=0D
>  		__rte_node_stream_alloc_size(graph, node, node->size + space);=0D
> @@ -293,7 +313,7 @@ __rte_node_next_node_get(struct rte_node *node, rte_e=
dge_t next)=0D
>=0D
>  /**=0D
>   * Enqueue the objs to next node for further processing and set=0D
> - * the next node to pending state in the circular buffer.=0D
> + * the next node to pending state in the scheduling bitmap.=0D
>   *=0D
>   * @param graph=0D
>   *   Graph pointer returned from rte_graph_lookup().=0D
> @@ -321,7 +341,7 @@ rte_node_enqueue(struct rte_graph *graph, struct rte_=
node *node,=0D
>=0D
>  /**=0D
>   * Enqueue only one obj to next node for further processing and=0D
> - * set the next node to pending state in the circular buffer.=0D
> + * set the next node to pending state in the scheduling bitmap.=0D
>   *=0D
>   * @param graph=0D
>   *   Graph pointer returned from rte_graph_lookup().=0D
> @@ -347,7 +367,7 @@ rte_node_enqueue_x1(struct rte_graph *graph, struct r=
te_node *node,=0D
>=0D
>  /**=0D
>   * Enqueue only two objs to next node for further processing and=0D
> - * set the next node to pending state in the circular buffer.=0D
> + * set the next node to pending state in the scheduling bitmap.=0D
>   * Same as rte_node_enqueue_x1 but enqueue two objs.=0D
>   *=0D
>   * @param graph=0D
> @@ -377,7 +397,7 @@ rte_node_enqueue_x2(struct rte_graph *graph, struct r=
te_node *node,=0D
>=0D
>  /**=0D
>   * Enqueue only four objs to next node for further processing and=0D
> - * set the next node to pending state in the circular buffer.=0D
> + * set the next node to pending state in the scheduling bitmap.=0D
>   * Same as rte_node_enqueue_x1 but enqueue four objs.=0D
>   *=0D
>   * @param graph=0D
> @@ -414,7 +434,7 @@ rte_node_enqueue_x4(struct rte_graph *graph, struct r=
te_node *node,=0D
>=0D
>  /**=0D
>   * Enqueue objs to multiple next nodes for further processing and=0D
> - * set the next nodes to pending state in the circular buffer.=0D
> + * set the next nodes to pending state in the scheduling bitmap.=0D
>   * objs[i] will be enqueued to nexts[i].=0D
>   *=0D
>   * @param graph=0D
> @@ -472,7 +492,7 @@ rte_node_next_stream_get(struct rte_graph *graph, str=
uct rte_node *node,=0D
>  }=0D
>=0D
>  /**=0D
> - * Put the next stream to pending state in the circular buffer=0D
> + * Put the next stream to pending state in the scheduling bitmap=0D
>   * for further processing. Should be invoked after rte_node_next_stream_=
get().=0D
>   *=0D
>   * @param graph=0D
> @@ -496,7 +516,7 @@ rte_node_next_stream_put(struct rte_graph *graph, str=
uct rte_node *node,=0D
>=0D
>  	node =3D __rte_node_next_node_get(node, next);=0D
>  	if (node->idx =3D=3D 0)=0D
> -		__rte_node_enqueue_tail_update(graph, node);=0D
> +		__rte_node_pending_set(graph->pending, node);=0D
>=0D
>  	node->idx +=3D idx;=0D
>  }=0D
> @@ -530,7 +550,7 @@ rte_node_next_stream_move(struct rte_graph *graph, st=
ruct rte_node *src,=0D
>  		src->objs =3D dobjs;=0D
>  		src->size =3D dsz;=0D
>  		dst->idx =3D src->idx;=0D
> -		__rte_node_enqueue_tail_update(graph, dst);=0D
> +		__rte_node_pending_set(graph->pending, dst);=0D
>  	} else { /* Move the objects from src node to dst node */=0D
>  		rte_node_enqueue(graph, src, next, src->objs, src->idx);=0D
>  	}=0D
> --=0D
> 2.55.0=0D
