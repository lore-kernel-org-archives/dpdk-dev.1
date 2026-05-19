Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87F1CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 21:38:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0839C40659;
	Tue, 19 May 2026 23:38:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id EC8CA40668
 for <dev@dpdk.org>; Tue, 19 May 2026 23:38:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779226725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qw3eSxUFKDZIkeXJ+WtalDzBdOBkx5mVXz+eu9zzN4Y=;
 b=Jei5Zq1wlR/7d2QfnD/aBnf1AqhAaFGke55ZwULgHoT9JKpTLG5bLhCRccKbFKn6GF3ajb
 dpXck5amIC2wA4t4KcYpETfAkOHPF9nEaHSTxXJLQWwq5eqMjRj7JRXCEBluSqIBoyNuqY
 l2OXsjP0dz6tHRAjpvpoIAeFqT6Bw2I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-sSmj-GqhMjKOqLYI8j15gg-1; Tue,
 19 May 2026 17:38:40 -0400
X-MC-Unique: sSmj-GqhMjKOqLYI8j15gg-1
X-Mimecast-MFC-AGG-ID: sSmj-GqhMjKOqLYI8j15gg_1779226719
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A0171956056; Tue, 19 May 2026 21:38:39 +0000 (UTC)
Received: from ringo.redhat.com (unknown [10.44.48.86])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F11A21684; Tue, 19 May 2026 21:38:32 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org, Jerin Jacob <jerinj@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Christophe Fontaine <cfontain@redhat.com>,
 David Marchand <david.marchand@redhat.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH dpdk v2 2/2] graph: replace circular buffer with
 priority-based bitmap
Date: Tue, 19 May 2026 23:38:22 +0200
Message-ID: <20260519213822.735891-3-rjarry@redhat.com>
In-Reply-To: <20260519213822.735891-1-rjarry@redhat.com>
References: <20260519101232.541102-2-rjarry@redhat.com>
 <20260519213822.735891-1-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rVptMJgeEAqhOxSYPvF_GyZOWibdzzz2TDW23-C0LLw_1779226719
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Replace the FIFO circular buffer used to track pending nodes with
a bitmap and a priority-sorted schedule table. Each node can have
a scheduling priority (int16_t, default 0, lower value means visited
first). Source nodes are forced to INT16_MIN so they always run first.

At graph creation time, nodes are sorted by (priority, topo_order,
node_id) and assigned a bit position (sched_idx). The topological depth
is computed via BFS from source nodes so that upstream nodes naturally
come before downstream ones, matching the old FIFO behavior when all
priorities are equal.

This enables reduced node visits in fan-out-then-converge topologies. In
the diamond perf test, the branch node has priority -1 so it runs before
the converge node. With the old circular buffer, the converge node is
visited twice at 128 objs/call (~970M objs/sec). With bitmap scheduling,
it is visited once at 256 objs/call (~1064M objs/sec), a ~10% throughput
improvement.

perf stat on a server CPU shows ~7% more instructions executed but ~7%
higher IPC (1.32 vs 1.23), 16% fewer L1 cache misses, and 8% fewer
branch mispredictions. The bitmap (16 bytes for <64 nodes) is more
cache-friendly than the circular buffer (256+ bytes). Net cycle count
and elapsed time are neutral.

Existing linear and tree topologies show no measurable regression.

Update documentation and memory layout diagrams to reflect the new
bitmap and scheduling table system.

Suggested-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Signed-off-by: Robin Jarry <rjarry@redhat.com>
Cc: Christophe Fontaine <cfontain@redhat.com>
Cc: David Marchand <david.marchand@redhat.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: Maxime Leroy <maxime@leroys.fr>
---
 app/test/test_graph_perf.c                    |   12 +-
 doc/guides/prog_guide/graph_lib.rst           |   37 +-
 .../prog_guide/img/graph_mem_layout.svg       | 1823 +++++++----------
 lib/graph/graph.c                             |   27 +-
 lib/graph/graph_debug.c                       |   12 +-
 lib/graph/graph_ops.c                         |   46 +
 lib/graph/graph_populate.c                    |  119 +-
 lib/graph/graph_private.h                     |   42 +-
 lib/graph/node.c                              |    2 +
 lib/graph/rte_graph.h                         |    1 +
 lib/graph/rte_graph_model_mcore_dispatch.h    |   34 +-
 lib/graph/rte_graph_model_rtc.h               |   65 +-
 lib/graph/rte_graph_worker.h                  |    2 +-
 lib/graph/rte_graph_worker_common.h           |   79 +-
 14 files changed, 1066 insertions(+), 1235 deletions(-)

diff --git a/app/test/test_graph_perf.c b/app/test/test_graph_perf.c
index c509d364b826..8cfae06ef7fc 100644
--- a/app/test/test_graph_perf.c
+++ b/app/test/test_graph_perf.c
@@ -32,6 +32,7 @@ test_graph_perf_func(void)
 #define TEST_GRAPH_SRC_NAME=09     "test_graph_perf_source"
 #define TEST_GRAPH_SRC_BRST_ONE_NAME "test_graph_perf_source_one"
 #define TEST_GRAPH_WRK_NAME=09     "test_graph_perf_worker"
+#define TEST_GRAPH_WRK_HIPRIO_NAME   "test_graph_perf_worker_hiprio"
 #define TEST_GRAPH_SNK_NAME=09     "test_graph_perf_sink"
=20
 #define SOURCES(map)=09     RTE_DIM(map)
@@ -225,6 +226,15 @@ static struct rte_node_register test_graph_perf_worker=
 =3D {
=20
 RTE_NODE_REGISTER(test_graph_perf_worker);
=20
+static struct rte_node_register test_graph_perf_worker_hiprio =3D {
+=09.name =3D TEST_GRAPH_WRK_HIPRIO_NAME,
+=09.process =3D test_perf_node_worker,
+=09.init =3D test_node_ctx_init,
+=09.priority =3D -1,
+};
+
+RTE_NODE_REGISTER(test_graph_perf_worker_hiprio);
+
 /* Last node in graph a.k.a sink node */
 static uint16_t
 test_perf_node_sink(struct rte_graph *graph, struct rte_node *node, void *=
*objs,
@@ -1083,7 +1093,7 @@ graph_init_diamond(void)
 =09fan_out =3D graph_node_get(TEST_GRAPH_WRK_NAME, "fan");
 =09/* converge must be edge 0 from fan_out so FIFO visits it first */
 =09converge =3D graph_node_get(TEST_GRAPH_WRK_NAME, "conv");
-=09branch =3D graph_node_get(TEST_GRAPH_WRK_NAME, "br");
+=09branch =3D graph_node_get(TEST_GRAPH_WRK_HIPRIO_NAME, "br");
 =09snk =3D graph_node_get(TEST_GRAPH_SNK_NAME, "0");
=20
 =09if (src =3D=3D RTE_NODE_ID_INVALID || fan_out =3D=3D RTE_NODE_ID_INVALI=
D ||
diff --git a/doc/guides/prog_guide/graph_lib.rst b/doc/guides/prog_guide/gr=
aph_lib.rst
index 8409e7666e85..9c6d8679b686 100644
--- a/doc/guides/prog_guide/graph_lib.rst
+++ b/doc/guides/prog_guide/graph_lib.rst
@@ -117,13 +117,22 @@ next_node[]:
 The dynamic array to store the downstream nodes connected to this node. Do=
wnstream
 node should not be current node itself or a source node.
=20
+priority:
+^^^^^^^^^
+
+The scheduling priority of the node (``int16_t``, default 0). Nodes with l=
ower
+priority values are visited first during the graph walk. This allows contr=
ol
+over the order in which pending nodes are processed, which can improve pac=
ket
+batching in topologies where multiple paths converge on the same node.
+
 Source node:
 ^^^^^^^^^^^^
=20
 Source nodes are static nodes created using ``RTE_NODE_REGISTER`` by passi=
ng
 ``flags`` as ``RTE_NODE_SOURCE_F``.
-While performing the graph walk, the ``process()`` function of all the sou=
rce
-nodes will be called first. So that these nodes can be used as input nodes=
 for a graph.
+Source nodes are automatically assigned the lowest possible priority
+(``INT16_MIN``) so that their ``process()`` function is always called firs=
t
+during the graph walk. This ensures they act as input nodes for a graph.
=20
 nb_xstats:
 ^^^^^^^^^^
@@ -396,12 +405,26 @@ Graph object memory layout
 Understanding the memory layout helps to debug the graph library and
 improve the performance if needed.
=20
-Graph object consists of a header, circular buffer to store the pending st=
ream
-when walking over the graph, variable-length memory to store the ``rte_nod=
e`` objects,
-and variable-length memory to store the xstat reported by each ``rte_node`=
`.
+A graph object consists of a header, a scheduling table mapping bit positi=
ons to
+node offsets, pending and source bitmaps for tracking which nodes need
+processing, variable-length memory to store the ``rte_node`` objects, and
+variable-length memory to store the xstat reported by each ``rte_node``.
=20
-The graph_nodes_mem_create() creates and populate this memory. The functio=
ns
-such as ``rte_graph_walk()`` and ``rte_node_enqueue_*`` use this memory
+Nodes are sorted by ``(priority, node_id)`` at graph creation time and eac=
h
+node is assigned a bit position in the pending bitmap. During the graph wa=
lk,
+the bitmap is scanned from the lowest bit, so nodes with lower priority va=
lues
+are visited first. Source nodes are always assigned the lowest priority
+(``INT16_MIN``) to ensure they run before any processing node.
+
+This priority-based ordering improves batching in fan-out-then-converge
+topologies. For example, if ``eth_input`` classifies packets to both
+``mpls_input`` and ``ipv4_input``, giving ``mpls_input`` a lower priority =
value
+ensures it runs first. Its output accumulates in ``ipv4_input`` which is t=
hen
+visited only once with all packets, instead of being visited twice (before=
 and
+after MPLS label popping).
+
+The ``graph_fp_mem_create()`` function creates and populates this memory. =
The
+functions such as ``rte_graph_walk()`` and ``rte_node_enqueue_*`` use this=
 memory
 to enable fastpath services.
=20
 Graph feature arc
diff --git a/doc/guides/prog_guide/img/graph_mem_layout.svg b/doc/guides/pr=
og_guide/img/graph_mem_layout.svg
index 3f3a4f3a808e..853987907dec 100644
--- a/doc/guides/prog_guide/img/graph_mem_layout.svg
+++ b/doc/guides/prog_guide/img/graph_mem_layout.svg
@@ -1,65 +1,22 @@
 <?xml version=3D"1.0" encoding=3D"UTF-8" standalone=3D"no"?>
-<!-- Created with Inkscape (http://www.inkscape.org/) -->
 <!-- SPDX-License-Identifier: BSD-3-Clause -->
+
 <!-- Copyright(C) 2020 Marvell International Ltd. -->
+
 <svg
-   width=3D"960"
-   height=3D"600"
-   viewBox=3D"0 0 960 600"
+   width=3D"820"
+   height=3D"540"
+   viewBox=3D"0 0 819.99998 540"
    version=3D"1.1"
-   id=3D"svg1"
-   inkscape:version=3D"1.3.2 (091e20e, 2023-11-25, custom)"
+   id=3D"svg56"
    sodipodi:docname=3D"graph_mem_layout.svg"
+   inkscape:version=3D"1.4.4 (dcaf3e7d9e, 2026-05-05)"
    xmlns:inkscape=3D"http://www.inkscape.org/namespaces/inkscape"
    xmlns:sodipodi=3D"http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
-   xmlns:xlink=3D"http://www.w3.org/1999/xlink"
    xmlns=3D"http://www.w3.org/2000/svg"
    xmlns:svg=3D"http://www.w3.org/2000/svg">
-  <sodipodi:namedview
-     id=3D"namedview1"
-     pagecolor=3D"#ffffff"
-     bordercolor=3D"#000000"
-     borderopacity=3D"0.25"
-     inkscape:showpageshadow=3D"2"
-     inkscape:pageopacity=3D"0.0"
-     inkscape:pagecheckerboard=3D"0"
-     inkscape:deskcolor=3D"#d1d1d1"
-     inkscape:document-units=3D"px"
-     showgrid=3D"true"
-     inkscape:zoom=3D"6.1531386"
-     inkscape:cx=3D"753.51789"
-     inkscape:cy=3D"469.11019"
-     inkscape:window-width=3D"1920"
-     inkscape:window-height=3D"1057"
-     inkscape:window-x=3D"-8"
-     inkscape:window-y=3D"-8"
-     inkscape:window-maximized=3D"1"
-     inkscape:current-layer=3D"layer1">
-    <inkscape:grid
-       id=3D"grid18"
-       units=3D"px"
-       originx=3D"0"
-       originy=3D"0"
-       spacingx=3D"1"
-       spacingy=3D"1"
-       empcolor=3D"#0099e5"
-       empopacity=3D"0.30196078"
-       color=3D"#0099e5"
-       opacity=3D"0.14901961"
-       empspacing=3D"5"
-       dotted=3D"false"
-       gridanglex=3D"30"
-       gridanglez=3D"30"
-       visible=3D"true" />
-  </sodipodi:namedview>
   <defs
-     id=3D"defs1">
-    <rect
-       x=3D"569.30411"
-       y=3D"433.24112"
-       width=3D"99.519047"
-       height=3D"22.294105"
-       id=3D"rect22" />
+     id=3D"defs56">
     <marker
        style=3D"overflow:visible"
        id=3D"Triangle"
@@ -67,8 +24,8 @@
        refY=3D"0"
        orient=3D"auto-start-reverse"
        inkscape:stockid=3D"Triangle arrow"
-       markerWidth=3D"1"
-       markerHeight=3D"1"
+       markerWidth=3D"2"
+       markerHeight=3D"2"
        viewBox=3D"0 0 1 1"
        inkscape:isstock=3D"true"
        inkscape:collect=3D"always"
@@ -79,1065 +36,705 @@
          d=3D"M 5.77,0 -2.88,5 V -5 Z"
          id=3D"path135" />
     </marker>
-    <rect
-       x=3D"656.57551"
-       y=3D"399.79598"
-       width=3D"185.92138"
-       height=3D"16.251869"
-       id=3D"rect19" />
-    <rect
-       x=3D"765.814"
-       y=3D"425.65652"
-       width=3D"104.80528"
-       height=3D"23.902958"
-       id=3D"rect18" />
-    <rect
-       x=3D"650.43626"
-       y=3D"461.97063"
-       width=3D"56.999362"
-       height=3D"17.927219"
-       id=3D"rect16" />
-    <linearGradient
-       id=3D"swatch10"
-       inkscape:swatch=3D"solid">
-      <stop
-         style=3D"stop-color:#090608;stop-opacity:1;"
-         offset=3D"0"
-         id=3D"stop10" />
-    </linearGradient>
-    <rect
-       x=3D"451.39817"
-       y=3D"509.77655"
-       width=3D"136.52266"
-       height=3D"74.007236"
-       id=3D"rect7" />
-    <rect
-       x=3D"334.18174"
-       y=3D"450.01915"
-       width=3D"51.483294"
-       height=3D"22.064269"
-       id=3D"rect6" />
-    <rect
-       x=3D"332.80272"
-       y=3D"483.11556"
-       width=3D"57.918706"
-       height=3D"32.177059"
-       id=3D"rect5" />
-    <rect
-       x=3D"361.3024"
-       y=3D"464.26899"
-       width=3D"133.30496"
-       height=3D"49.644605"
-       id=3D"rect4" />
-    <rect
-       x=3D"155.8289"
-       y=3D"426.57587"
-       width=3D"103.88593"
-       height=3D"13.330496"
-       id=3D"rect2" />
-    <marker
-       style=3D"overflow:visible"
-       id=3D"Triangle-0"
-       refX=3D"0"
-       refY=3D"0"
-       orient=3D"auto-start-reverse"
-       inkscape:stockid=3D"Triangle arrow"
-       markerWidth=3D"1"
-       markerHeight=3D"1"
-       viewBox=3D"0 0 1 1"
-       inkscape:isstock=3D"true"
-       inkscape:collect=3D"always"
-       preserveAspectRatio=3D"xMidYMid">
-      <path
-         transform=3D"scale(0.5)"
-         style=3D"fill:context-stroke;fill-rule:evenodd;stroke:context-str=
oke;stroke-width:1pt"
-         d=3D"M 5.77,0 -2.88,5 V -5 Z"
-         id=3D"path135-2" />
-    </marker>
-    <rect
-       x=3D"656.5755"
-       y=3D"399.79599"
-       width=3D"186.38106"
-       height=3D"37.396793"
-       id=3D"rect19-5" />
   </defs>
-  <g
-     inkscape:label=3D"Layer 1"
-     inkscape:groupmode=3D"layer"
-     id=3D"layer1">
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1.13576"
-       stroke-linecap=3D"butt"
-       d=3D"M 144.20018,75.514867 V 521.03057"
-       fill-rule=3D"nonzero"
-       id=3D"path232" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1.13545"
-       stroke-linecap=3D"butt"
-       d=3D"M 272.64375,75.629785 V 520.91592"
-       fill-rule=3D"nonzero"
-       id=3D"path234" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"M 143.70149,76.013557 H 273.14244"
-       fill-rule=3D"nonzero"
-       id=3D"path236" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"M 143.70149,127.21041 H 273.14244"
-       fill-rule=3D"nonzero"
-       id=3D"path238" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"M 143.70149,180.40726 H 273.14244"
-       fill-rule=3D"nonzero"
-       id=3D"path240" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"M 143.70149,215.60412 H 273.14244"
-       fill-rule=3D"nonzero"
-       id=3D"path242" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"M 143.70149,266.80095 H 273.14244"
-       fill-rule=3D"nonzero"
-       id=3D"path244" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"M 143.70149,317.99782 H 273.14244"
-       fill-rule=3D"nonzero"
-       id=3D"path246" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"M 143.70149,369.19466 H 273.14244"
-       fill-rule=3D"nonzero"
-       id=3D"path248" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"M 143.70149,420.3915 H 273.14244"
-       fill-rule=3D"nonzero"
-       id=3D"path250" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"M 143.59745,445.61126 H 273.0384"
-       fill-rule=3D"nonzero"
-       id=3D"path250-4" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"0.998115"
-       stroke-linecap=3D"butt"
-       d=3D"M 143.86386,470.4766 H 272.81725"
-       fill-rule=3D"nonzero"
-       id=3D"path250-4-4" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"0.998115"
-       stroke-linecap=3D"butt"
-       d=3D"M 144.33823,495.4898 H 273.29162"
-       fill-rule=3D"nonzero"
-       id=3D"path250-4-4-6" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"0.999778"
-       stroke-linecap=3D"butt"
-       d=3D"M 143.81154,520.51707 H 273.19503"
-       fill-rule=3D"nonzero"
-       id=3D"path250-7" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 173.54384,94.079177 v -1.125 l 4.03125,-0.0156 v 3.54688 q -=
0.92188,0.75 -1.92188,1.125 -0.98437,0.35937 -2.03125,0.35937 -1.40625,0 -2=
.5625,-0.59375 -1.14062,-0.60937 -1.73437,-1.73437 -0.57813,-1.14063 -0.578=
13,-2.54688 0,-1.40625 0.57813,-2.60937 0.59375,-1.20313 1.6875,-1.78125 1.=
09375,-0.59375 2.51562,-0.59375 1.03125,0 1.85938,0.34375 0.84375,0.32812 1=
.3125,0.9375 0.48437,0.59375 0.73437,1.54687 l -1.14062,0.3125 q -0.21875,-=
0.71875 -0.53125,-1.14062 -0.3125,-0.42188 -0.90625,-0.67188 -0.59375,-0.25=
 -1.3125,-0.25 -0.875,0 -1.51563,0.26563 -0.625,0.26562 -1.01562,0.70312 -0=
.375,0.42188 -0.59375,0.9375 -0.35938,0.875 -0.35938,1.92188 0,1.26562 0.43=
75,2.125 0.4375,0.85937 1.26563,1.28125 0.84375,0.42187 1.79687,0.42187 0.8=
125,0 1.59375,-0.3125 0.78125,-0.32812 1.1875,-0.6875 v -1.76562 z m 5.7264=
3,3.73437 v -6.90625 h 1.0625 v 1.04688 q 0.40625,-0.73438 0.73437,-0.96875=
 0.34375,-0.23438 0.76563,-0.23438 0.59375,0 1.20312,0.375 l -0.40625,1.078=
13 q -0.4375,-0.25 -0.85937,-0.25 -0.39063,0 -0.70313,0.23437 -0.29687,0.23=
438 -0.42187,0.64063 -0.20313,0.625 -0.20313,1.35937 v 3.625 z m 8.96961,-0=
.85937 q -0.65625,0.5625 -1.26562,0.79687 -0.59375,0.21875 -1.28125,0.21875=
 -1.14063,0 -1.75,-0.54687 -0.60938,-0.5625 -0.60938,-1.4375 0,-0.5 0.21875=
,-0.92188 0.23438,-0.42187 0.60938,-0.67187 0.375,-0.25 0.84375,-0.39063 0.=
34375,-0.0781 1.04687,-0.17187 1.42188,-0.17188 2.09375,-0.40625 0,-0.23438=
 0,-0.29688 0,-0.71875 -0.32812,-1.01562 -0.45313,-0.39063 -1.34375,-0.3906=
3 -0.8125,0 -1.21875,0.29688 -0.39063,0.28125 -0.57813,1.01562 l -1.14062,-=
0.15625 q 0.15625,-0.73437 0.51562,-1.1875 0.35938,-0.45312 1.03125,-0.6875=
 0.67188,-0.25 1.5625,-0.25 0.89063,0 1.4375,0.20313 0.5625,0.20312 0.8125,=
0.53125 0.26563,0.3125 0.375,0.79687 0.0469,0.29688 0.0469,1.07813 v 1.5625=
 q 0,1.625 0.0781,2.0625 0.0781,0.4375 0.29688,0.82812 h -1.21875 q -0.1875=
,-0.35937 -0.23438,-0.85937 z m -0.0937,-2.60938 q -0.64062,0.26563 -1.9218=
7,0.4375 -0.71875,0.10938 -1.01563,0.25 -0.29687,0.125 -0.46875,0.375 -0.15=
625,0.25 -0.15625,0.54688 0,0.46875 0.34375,0.78125 0.35938,0.3125 1.04688,=
0.3125 0.67187,0 1.20312,-0.29688 0.53125,-0.29687 0.78125,-0.8125 0.1875,-=
0.39062 0.1875,-1.17187 z m 2.99061,6.125003 v -9.562503 h 1.07812 v 0.8906=
3 q 0.375,-0.53125 0.84375,-0.78125 0.48438,-0.26563 1.15625,-0.26563 0.875=
,0 1.54688,0.45313 0.6875,0.45312 1.03125,1.28125 0.34375,0.82812 0.34375,1=
.82812 0,1.04688 -0.375,1.90625 -0.375,0.84375 -1.10938,1.29688 -0.71875,0.=
45312 -1.53125,0.45312 -0.57812,0 -1.04687,-0.25 -0.46875,-0.25 -0.76563,-0=
.625 v 3.375003 z m 1.0625,-6.078123 q 0,1.34375 0.53125,1.98437 0.54687,0.=
625 1.3125,0.625 0.78125,0 1.34375,-0.65625 0.5625,-0.65625 0.5625,-2.04687=
 0,-1.3125 -0.54688,-1.96875 -0.54687,-0.67188 -1.29687,-0.67188 -0.75,0 -1=
.32813,0.70313 -0.57812,0.70312 -0.57812,2.03125 z m 6.34997,3.42187 v -9.5=
4687 h 1.17188 v 3.42187 q 0.82812,-0.9375 2.07812,-0.9375 0.76563,0 1.3281=
3,0.29688 0.5625,0.29687 0.8125,0.84375 0.25,0.53125 0.25,1.54687 v 4.375 h=
 -1.17188 v -4.375 q 0,-0.89062 -0.39062,-1.28125 -0.375,-0.40625 -1.07813,=
-0.40625 -0.51562,0 -0.98437,0.28125 -0.45313,0.26563 -0.65625,0.73438 -0.1=
875,0.45312 -0.1875,1.26562 v 3.78125 z m 11.30296,0 v -9.54687 h 1.26563 v=
 3.92187 h 4.95312 v -3.92187 h 1.26563 v 9.54687 h -1.26563 v -4.5 h -4.95=
312 v 4.5 z m 14.17203,-2.21875 1.20313,0.14063 q -0.28125,1.0625 -1.0625,1=
.65625 -0.76563,0.57812 -1.96875,0.57812 -1.51563,0 -2.40625,-0.9375 -0.890=
63,-0.9375 -0.89063,-2.60937 0,-1.75 0.89063,-2.70313 0.90625,-0.96875 2.34=
375,-0.96875 1.39062,0 2.26562,0.9375 0.875,0.9375 0.875,2.65625 0,0.10938 =
0,0.3125 H 220.118 q 0.0625,1.14063 0.64063,1.75 0.57812,0.59375 1.4375,0.5=
9375 0.65625,0 1.10937,-0.32812 0.45313,-0.34375 0.71875,-1.07813 z m -3.84=
375,-1.90625 h 3.85938 q -0.0781,-0.85937 -0.4375,-1.29687 -0.5625,-0.6875 =
-1.45313,-0.6875 -0.8125,0 -1.35937,0.54687 -0.54688,0.53125 -0.60938,1.437=
5 z m 11.03748,3.26563 q -0.65625,0.5625 -1.26563,0.79687 -0.59375,0.21875 =
-1.28125,0.21875 -1.14062,0 -1.75,-0.54687 -0.60937,-0.5625 -0.60937,-1.437=
5 0,-0.5 0.21875,-0.92188 0.23437,-0.42187 0.60937,-0.67187 0.375,-0.25 0.8=
4375,-0.39063 0.34375,-0.0781 1.04688,-0.17187 1.42187,-0.17188 2.09375,-0.=
40625 0,-0.23438 0,-0.29688 0,-0.71875 -0.32813,-1.01562 -0.45312,-0.39063 =
-1.34375,-0.39063 -0.8125,0 -1.21875,0.29688 -0.39062,0.28125 -0.57812,1.01=
562 l -1.14063,-0.15625 q 0.15625,-0.73437 0.51563,-1.1875 0.35937,-0.45312=
 1.03125,-0.6875 0.67187,-0.25 1.5625,-0.25 0.89062,0 1.4375,0.20313 0.5625=
,0.20312 0.8125,0.53125 0.26562,0.3125 0.375,0.79687 0.0469,0.29688 0.0469,=
1.07813 v 1.5625 q 0,1.625 0.0781,2.0625 0.0781,0.4375 0.29687,0.82812 h -1=
.21875 q -0.1875,-0.35937 -0.23437,-0.85937 z m -0.0937,-2.60938 q -0.64063=
,0.26563 -1.92188,0.4375 -0.71875,0.10938 -1.01562,0.25 -0.29688,0.125 -0.4=
6875,0.375 -0.15625,0.25 -0.15625,0.54688 0,0.46875 0.34375,0.78125 0.35937=
,0.3125 1.04687,0.3125 0.67188,0 1.20313,-0.29688 0.53125,-0.29687 0.78125,=
-0.8125 0.1875,-0.39062 0.1875,-1.17187 z m 7.47497,3.46875 v -0.875 q -0.6=
5625,1.03125 -1.9375,1.03125 -0.8125,0 -1.51562,-0.45312 -0.6875,-0.45313 -=
1.07813,-1.26563 -0.375,-0.82812 -0.375,-1.89062 0,-1.03125 0.34375,-1.875 =
0.34375,-0.84375 1.03125,-1.28125 0.70313,-0.45313 1.54688,-0.45313 0.625,0=
 1.10937,0.26563 0.5,0.25 0.79688,0.67187 v -3.42187 h 1.17187 v 9.54687 z =
m -3.70312,-3.45312 q 0,1.32812 0.5625,1.98437 0.5625,0.65625 1.32812,0.656=
25 0.76563,0 1.29688,-0.625 0.53125,-0.625 0.53125,-1.90625 0,-1.42187 -0.5=
4688,-2.07812 -0.54687,-0.67188 -1.34375,-0.67188 -0.78125,0 -1.3125,0.6406=
3 -0.51562,0.625 -0.51562,2 z m 11.3656,1.23437 1.20312,0.14063 q -0.28125,=
1.0625 -1.0625,1.65625 -0.76562,0.57812 -1.96875,0.57812 -1.51562,0 -2.4062=
5,-0.9375 -0.89062,-0.9375 -0.89062,-2.60937 0,-1.75 0.89062,-2.70313 0.906=
25,-0.96875 2.34375,-0.96875 1.39063,0 2.26563,0.9375 0.875,0.9375 0.875,2.=
65625 0,0.10938 0,0.3125 h -5.15625 q 0.0625,1.14063 0.64062,1.75 0.57813,0=
.59375 1.4375,0.59375 0.65625,0 1.10938,-0.32812 0.45312,-0.34375 0.71875,-=
1.07813 z m -3.84375,-1.90625 h 3.85937 q -0.0781,-0.85937 -0.4375,-1.29687=
 -0.5625,-0.6875 -1.45312,-0.6875 -0.8125,0 -1.35938,0.54687 -0.54687,0.531=
25 -0.60937,1.4375 z m 6.50623,4.125 v -6.90625 h 1.0625 v 1.04688 q 0.4062=
5,-0.73438 0.73437,-0.96875 0.34375,-0.23438 0.76563,-0.23438 0.59375,0 1.2=
0312,0.375 l -0.40625,1.07813 q -0.4375,-0.25 -0.85937,-0.25 -0.39063,0 -0.=
70313,0.23437 -0.29687,0.23438 -0.42187,0.64063 -0.20313,0.625 -0.20313,1.3=
5937 v 3.625 z"
-       fill-rule=3D"nonzero"
-       id=3D"path252" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 162.29759,111.45418 1.1875,-0.0781 q 0,0.51563 0.15625,0.875=
 0.15625,0.35938 0.57812,0.59375 0.42188,0.21875 0.96875,0.21875 0.78125,0 =
1.17188,-0.3125 0.39062,-0.3125 0.39062,-0.73437 0,-0.3125 -0.23437,-0.5781=
3 -0.23438,-0.28125 -1.17188,-0.67187 -0.9375,-0.40625 -1.1875,-0.57813 -0.=
4375,-0.26562 -0.67187,-0.625 -0.21875,-0.35937 -0.21875,-0.82812 0,-0.8125=
 0.65625,-1.39063 0.65625,-0.59375 1.82812,-0.59375 1.29688,0 1.96875,0.609=
38 0.6875,0.59375 0.71875,1.57812 l -1.15625,0.0781 q -0.0312,-0.625 -0.453=
12,-0.98438 -0.40625,-0.375 -1.17188,-0.375 -0.60937,0 -0.95312,0.28125 -0.=
32813,0.28125 -0.32813,0.60938 0,0.3125 0.29688,0.5625 0.1875,0.17187 1,0.5=
3125 1.35937,0.57812 1.70312,0.92187 0.5625,0.53125 0.5625,1.3125 0,0.51563=
 -0.3125,1.01563 -0.3125,0.48437 -0.96875,0.78125 -0.64062,0.29687 -1.51562=
,0.29687 -1.20313,0 -2.04688,-0.59375 -0.84375,-0.59375 -0.79687,-1.92187 z=
 m 9.32031,1.40625 -0.20312,0.95312 q -0.42188,0.10938 -0.8125,0.10938 -0.7=
0313,0 -1.125,-0.34375 -0.3125,-0.25 -0.3125,-0.70313 0,-0.23437 0.17187,-1=
.04687 l 0.82813,-4.01563 h -0.92188 l 0.1875,-0.90625 h 0.9375 l 0.34375,-=
1.70312 1.35938,-0.8125 -0.53125,2.51562 h 1.15625 l -0.1875,0.90625 h -1.1=
5625 l -0.79688,3.8125 q -0.15625,0.73438 -0.15625,0.875 0,0.21875 0.10938,=
0.32813 0.125,0.10937 0.40625,0.10937 0.39062,0 0.70312,-0.0781 z m 0.93737=
,0.95312 1.45312,-6.90625 h 1.03125 l -0.28125,1.40625 q 0.53125,-0.79687 1=
.03125,-1.17187 0.51563,-0.39063 1.04688,-0.39063 0.35937,0 0.875,0.25 l -0=
.48438,1.09375 q -0.3125,-0.21875 -0.67187,-0.21875 -0.625,0 -1.28125,0.687=
5 -0.64063,0.6875 -1.01563,2.48438 l -0.57812,2.76562 z m 9.15712,-1.25 q -=
1.23438,1.40625 -2.54688,1.40625 -0.79687,0 -1.29687,-0.45312 -0.48438,-0.4=
6875 -0.48438,-1.125 0,-0.4375 0.21875,-1.5 l 0.84375,-3.98438 h 1.17188 l =
-0.92188,4.40625 q -0.10937,0.5625 -0.10937,0.85938 0,0.39062 0.23437,0.609=
37 0.23438,0.21875 0.70313,0.21875 0.48437,0 0.95312,-0.23437 0.48438,-0.23=
438 0.8125,-0.64063 0.34375,-0.42187 0.5625,-0.98437 0.14063,-0.35938 0.328=
13,-1.25 l 0.625,-2.98438 h 1.1875 l -1.45313,6.90625 h -1.07812 z m 7.4749=
7,-1.26562 1.17188,0.125 q -0.4375,1.29687 -1.26563,1.92187 -0.8125,0.625 -=
1.84375,0.625 -1.14062,0 -1.84375,-0.71875 -0.6875,-0.73437 -0.6875,-2.0468=
7 0,-1.125 0.4375,-2.21875 0.45313,-1.09375 1.28125,-1.65625 0.84375,-0.578=
13 1.92188,-0.57813 1.10937,0 1.76562,0.625 0.65625,0.625 0.65625,1.65625 l=
 -1.15625,0.0781 q -0.0156,-0.65625 -0.39062,-1.01563 -0.375,-0.375 -0.9843=
8,-0.375 -0.70312,0 -1.23437,0.45313 -0.51563,0.4375 -0.8125,1.35937 -0.296=
88,0.90625 -0.29688,1.75 0,0.89063 0.39063,1.34375 0.39062,0.4375 0.96875,0=
.4375 0.5625,0 1.07812,-0.4375 0.53125,-0.4375 0.84375,-1.32812 z m 4.64844=
,1.5625 -0.20313,0.95312 q -0.42187,0.10938 -0.8125,0.10938 -0.70312,0 -1.1=
25,-0.34375 -0.3125,-0.25 -0.3125,-0.70313 0,-0.23437 0.17188,-1.04687 l 0.=
82812,-4.01563 h -0.92187 l 0.1875,-0.90625 h 0.9375 l 0.34375,-1.70312 1.3=
5937,-0.8125 -0.53125,2.51562 h 1.15625 l -0.1875,0.90625 h -1.15625 l -0.7=
9687,3.8125 q -0.15625,0.73438 -0.15625,0.875 0,0.21875 0.10937,0.32813 0.1=
25,0.10937 0.40625,0.10937 0.39063,0 0.70313,-0.0781 z m 4.64035,0.95312 1.=
45312,-6.90625 h 1.03125 l -0.28125,1.40625 q 0.53125,-0.79687 1.03125,-1.1=
7187 0.51563,-0.39063 1.04688,-0.39063 0.35937,0 0.875,0.25 l -0.48438,1.09=
375 q -0.3125,-0.21875 -0.67187,-0.21875 -0.625,0 -1.28125,0.6875 -0.64063,=
0.6875 -1.01563,2.48438 l -0.57812,2.76562 z m 7.20399,-0.95312 -0.20312,0.=
95312 q -0.42188,0.10938 -0.8125,0.10938 -0.70313,0 -1.125,-0.34375 -0.3125=
,-0.25 -0.3125,-0.70313 0,-0.23437 0.17187,-1.04687 l 0.82813,-4.01563 h -0=
.92188 l 0.1875,-0.90625 h 0.9375 l 0.34375,-1.70312 1.35938,-0.8125 -0.531=
25,2.51562 h 1.15625 l -0.1875,0.90625 h -1.15625 l -0.79688,3.8125 q -0.15=
625,0.73438 -0.15625,0.875 0,0.21875 0.10938,0.32813 0.125,0.10937 0.40625,=
0.10937 0.39062,0 0.70312,-0.0781 z m 6.01549,-1.39063 1.15625,0.10938 q -0=
.25,0.85937 -1.14062,1.625 -0.89063,0.76562 -2.125,0.76562 -0.76563,0 -1.40=
625,-0.34375 -0.64063,-0.35937 -0.98438,-1.03125 -0.32812,-0.6875 -0.32812,=
-1.54687 0,-1.14063 0.51562,-2.20313 0.53125,-1.0625 1.35938,-1.57812 0.843=
75,-0.51563 1.8125,-0.51563 1.23437,0 1.96875,0.76563 0.75,0.76562 0.75,2.0=
9375 0,0.5 -0.0937,1.04687 h -5.09375 q -0.0312,0.1875 -0.0312,0.35938 0,0.=
96875 0.4375,1.48437 0.45312,0.5 1.10937,0.5 0.59375,0 1.17188,-0.39062 0.5=
9375,-0.39063 0.92187,-1.14063 z m -3.42187,-1.71875 h 3.875 q 0.0156,-0.18=
75 0.0156,-0.26562 0,-0.875 -0.45312,-1.34375 -0.4375,-0.48438 -1.125,-0.48=
438 -0.76563,0 -1.39063,0.53125 -0.60937,0.51563 -0.92187,1.5625 z m 4.4749=
7,6.71875 v -0.85937 h 7.76563 v 0.85937 z m 8.63123,-2.03125 1.1875,0.1093=
8 q 0,0.40625 0.10937,0.60937 0.10938,0.20313 0.34375,0.3125 0.32813,0.1406=
3 0.82813,0.14063 1.0625,0 1.53125,-0.54688 0.3125,-0.375 0.57812,-1.625 l =
0.10938,-0.5625 q -0.92188,0.9375 -1.95313,0.9375 -1.04687,0 -1.75,-0.76562=
 -0.70312,-0.78125 -0.70312,-2.1875 0,-1.17188 0.54687,-2.14063 0.5625,-0.9=
8437 1.32813,-1.46875 0.76562,-0.5 1.57812,-0.5 1.35938,0 2.09375,1.28125 l=
 0.23438,-1.125 h 1.07812 l -1.39062,6.67188 q -0.21875,1.09375 -0.59375,1.=
70312 -0.375,0.625 -1.03125,0.95313 -0.65625,0.34375 -1.53125,0.34375 -0.82=
813,0 -1.4375,-0.21875 -0.59375,-0.20313 -0.89063,-0.625 -0.29687,-0.40625 =
-0.29687,-0.95313 0,-0.15625 0.0312,-0.34375 z m 1.46875,-3.6875 q 0,0.7187=
5 0.14062,1.07813 0.20313,0.5 0.5625,0.76562 0.35938,0.25 0.79688,0.25 0.57=
812,0 1.14062,-0.40625 0.57813,-0.40625 0.9375,-1.25 0.35938,-0.85937 0.359=
38,-1.625 0,-0.85937 -0.48438,-1.35937 -0.46875,-0.51563 -1.15625,-0.51563 =
-0.4375,0 -0.84375,0.23438 -0.39062,0.23437 -0.75,0.70312 -0.34375,0.46875 =
-0.53125,1.14063 -0.17187,0.65625 -0.17187,0.98437 z m 6.00622,3.0625 1.453=
13,-6.90625 h 1.03125 l -0.28125,1.40625 q 0.53125,-0.79687 1.03125,-1.1718=
7 0.51562,-0.39063 1.04687,-0.39063 0.35938,0 0.875,0.25 l -0.48437,1.09375=
 q -0.3125,-0.21875 -0.67188,-0.21875 -0.625,0 -1.28125,0.6875 -0.64062,0.6=
875 -1.01562,2.48438 l -0.57813,2.76562 z m 9.11025,-0.85937 q -0.625,0.531=
25 -1.1875,0.78125 -0.5625,0.23437 -1.20313,0.23437 -0.96875,0 -1.5625,-0.5=
625 -0.57812,-0.5625 -0.57812,-1.4375 0,-0.57812 0.26562,-1.01562 0.26563,-=
0.45313 0.70313,-0.71875 0.4375,-0.28125 1.0625,-0.39063 0.40625,-0.0781 1.=
51562,-0.125 1.10938,-0.0469 1.59375,-0.23437 0.125,-0.48438 0.125,-0.8125 =
0,-0.40625 -0.29687,-0.64063 -0.40625,-0.32812 -1.1875,-0.32812 -0.75,0 -1.=
21875,0.32812 -0.46875,0.32813 -0.6875,0.9375 l -1.1875,-0.10937 q 0.35937,=
-1.01563 1.14062,-1.5625 0.79688,-0.54688 2,-0.54688 1.28125,0 2.03125,0.60=
938 0.57813,0.45312 0.57813,1.1875 0,0.54687 -0.15625,1.28125 l -0.39063,1.=
71875 q -0.1875,0.8125 -0.1875,1.32812 0,0.32813 0.15625,0.9375 h -1.20312 =
q -0.0937,-0.34375 -0.125,-0.85937 z m 0.42187,-2.64063 q -0.23437,0.0937 -=
0.53125,0.15625 -0.28125,0.0469 -0.9375,0.10938 -1.03125,0.0781 -1.45312,0.=
21875 -0.42188,0.14062 -0.64063,0.45312 -0.21875,0.29688 -0.21875,0.67188 0=
,0.5 0.34375,0.82812 0.34375,0.3125 0.98438,0.3125 0.57812,0 1.10937,-0.312=
5 0.54688,-0.3125 0.85938,-0.85937 0.3125,-0.5625 0.48437,-1.57813 z m 1.74=
06,6.15625 2,-9.5625 h 1.09375 l -0.20312,0.95313 q 0.59375,-0.625 1.07812,=
-0.85938 0.48438,-0.25 1.01563,-0.25 0.98437,0 1.625,0.71875 0.65625,0.7187=
5 0.65625,2.0625 0,1.07813 -0.35938,1.96875 -0.34375,0.875 -0.875,1.42188 -=
0.51562,0.54687 -1.04687,0.79687 -0.53125,0.25 -1.09375,0.25 -1.25,0 -1.921=
88,-1.26562 l -0.78125,3.76562 z m 2.32813,-5.48437 q 0,0.78125 0.10937,1.0=
7812 0.17188,0.42188 0.53125,0.6875 0.375,0.25 0.875,0.25 1.01563,0 1.64063=
,-1.14062 0.625,-1.14063 0.625,-2.32813 0,-0.875 -0.42188,-1.35937 -0.42187=
,-0.48438 -1.04687,-0.48438 -0.45313,0 -0.84375,0.25 -0.375,0.23438 -0.7031=
3,0.70313 -0.32812,0.46875 -0.54687,1.15625 -0.21875,0.6875 -0.21875,1.1875=
 z m 5.66247,2.82812 2,-9.54687 h 1.17188 l -0.76563,3.67187 q 0.65625,-0.6=
4062 1.21875,-0.90625 0.57813,-0.28125 1.17188,-0.28125 0.85937,0 1.32812,0=
.45313 0.48438,0.45312 0.48438,1.1875 0,0.35937 -0.20313,1.34375 l -0.85937=
,4.07812 h -1.17188 l 0.875,-4.1875 q 0.1875,-0.90625 0.1875,-1.14062 0,-0.=
34375 -0.23437,-0.54688 -0.23438,-0.21875 -0.67188,-0.21875 -0.64062,0 -1.2=
1875,0.34375 -0.57812,0.32813 -0.90625,0.90625 -0.32812,0.57813 -0.60937,1.=
875 l -0.60938,2.96875 z"
-       fill-rule=3D"nonzero"
-       id=3D"path254" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 190.99429,149.01041 v -9.54688 h 6.4375 v 1.125 h -5.17188 v=
 2.96875 h 4.46875 v 1.125 h -4.46875 v 4.32813 z m 12.65698,-2.21875 1.203=
13,0.14062 q -0.28125,1.0625 -1.0625,1.65625 -0.76563,0.57813 -1.96875,0.57=
813 -1.51563,0 -2.40625,-0.9375 -0.89063,-0.9375 -0.89063,-2.60938 0,-1.75 =
0.89063,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.39062,0 2.26562,0.9375=
 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.15625 q 0.0625,1.14062 =
0.64063,1.75 0.57812,0.59375 1.4375,0.59375 0.65625,0 1.10937,-0.32813 0.45=
313,-0.34375 0.71875,-1.07812 z m -3.84375,-1.90625 h 3.85938 q -0.0781,-0.=
85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.45313,-0.6875 -0.8125,0 -1.35937,=
0.54688 -0.54688,0.53125 -0.60938,1.4375 z m 6.52185,4.125 v -6.90625 h 1.0=
625 v 0.98437 q 0.75,-1.14062 2.1875,-1.14062 0.625,0 1.15625,0.21875 0.531=
25,0.21875 0.78125,0.59375 0.26563,0.35937 0.375,0.85937 0.0625,0.32813 0.0=
625,1.14063 v 4.25 h -1.17187 v -4.20313 q 0,-0.71875 -0.14063,-1.0625 -0.1=
4062,-0.35937 -0.48437,-0.5625 -0.34375,-0.21875 -0.8125,-0.21875 -0.75,0 -=
1.29688,0.46875 -0.54687,0.46875 -0.54687,1.79688 v 3.78125 z m 11.9281,-2.=
53125 1.15625,0.15625 q -0.1875,1.1875 -0.96875,1.85937 -0.78125,0.67188 -1=
.92187,0.67188 -1.40625,0 -2.28125,-0.92188 -0.85938,-0.9375 -0.85938,-2.65=
625 0,-1.125 0.375,-1.96875 0.375,-0.84375 1.125,-1.25 0.76563,-0.42187 1.6=
5625,-0.42187 1.125,0 1.84375,0.57812 0.71875,0.5625 0.92188,1.60938 l -1.1=
4063,0.17187 q -0.17187,-0.70312 -0.59375,-1.04687 -0.40625,-0.35938 -0.984=
37,-0.35938 -0.89063,0 -1.45313,0.64063 -0.54687,0.64062 -0.54687,2 0,1.406=
25 0.53125,2.03125 0.54687,0.625 1.40625,0.625 0.6875,0 1.14062,-0.42188 0.=
46875,-0.42187 0.59375,-1.29687 z m 6.88282,0.3125 1.20312,0.14062 q -0.281=
25,1.0625 -1.0625,1.65625 -0.76562,0.57813 -1.96875,0.57813 -1.51562,0 -2.4=
0625,-0.9375 -0.89062,-0.9375 -0.89062,-2.60938 0,-1.75 0.89062,-2.70312 0.=
90625,-0.96875 2.34375,-0.96875 1.39063,0 2.26563,0.9375 0.875,0.9375 0.875=
,2.65625 0,0.10937 0,0.3125 h -5.15625 q 0.0625,1.14062 0.64062,1.75 0.5781=
3,0.59375 1.4375,0.59375 0.65625,0 1.10938,-0.32813 0.45312,-0.34375 0.7187=
5,-1.07812 z m -3.84375,-1.90625 h 3.85937 q -0.0781,-0.85938 -0.4375,-1.29=
688 -0.5625,-0.6875 -1.45312,-0.6875 -0.8125,0 -1.35938,0.54688 -0.54687,0.=
53125 -0.60937,1.4375 z"
-       fill-rule=3D"nonzero"
-       id=3D"path256" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 161.95064,158.35416 q 0,0.45312 -0.125,0.85937 -0.125,0.3906=
3 -0.39063,0.73438 -0.25,0.34375 -0.64062,0.60937 -0.375,0.25 -0.89063,0.42=
188 0.34375,0.125 0.54688,0.51562 0.21875,0.39063 0.34375,1.04688 l 0.34375=
,1.85937 q 0.0156,0.125 0.0312,0.23438 0.0156,0.10937 0.0156,0.1875 0,0.062=
5 -0.0312,0.10937 -0.0312,0.0469 -0.10937,0.0781 -0.0625,0.0156 -0.1875,0.0=
156 -0.125,0.0156 -0.3125,0.0156 -0.17188,0 -0.28125,-0.0156 -0.0937,0 -0.1=
5625,-0.0312 -0.0469,-0.0312 -0.0781,-0.0781 -0.0156,-0.0625 -0.0312,-0.140=
63 l -0.32812,-1.98437 q -0.0625,-0.34375 -0.15625,-0.625 -0.0937,-0.28125 =
-0.26563,-0.48438 -0.15625,-0.20312 -0.42187,-0.3125 -0.26563,-0.10937 -0.6=
4063,-0.10937 h -0.75 l -0.71875,3.59375 q -0.0156,0.0469 -0.0469,0.0937 -0=
.0312,0.0312 -0.10938,0.0469 -0.0781,0.0156 -0.1875,0.0312 -0.10937,0.0156 =
-0.26562,0.0156 -0.15625,0 -0.26563,-0.0156 -0.0937,0 -0.15625,-0.0156 -0.0=
625,-0.0312 -0.0937,-0.0625 -0.0156,-0.0469 0,-0.0937 l 1.5625,-7.8125 q 0.=
0469,-0.25 0.20313,-0.34375 0.15625,-0.10938 0.34375,-0.10938 h 1.82812 q 0=
.60938,0 1.0625,0.125 0.45313,0.10938 0.75,0.34375 0.3125,0.21875 0.45313,0=
.54688 0.15625,0.32812 0.15625,0.75 z m -1.20313,0.17187 q 0,-0.21875 -0.07=
81,-0.40625 -0.0781,-0.1875 -0.25,-0.32812 -0.15625,-0.14063 -0.4375,-0.203=
13 -0.26563,-0.0781 -0.64063,-0.0781 h -1.15625 l -0.57812,2.84375 h 0.9843=
7 q 0.57813,0 0.98438,-0.15625 0.42187,-0.15625 0.67187,-0.40625 0.25,-0.26=
563 0.375,-0.59375 0.125,-0.32813 0.125,-0.67188 z m 8.93988,-1.70312 q 0,0=
.0312 0,0.10937 0,0.0625 -0.0156,0.14063 -0.0156,0.0781 -0.0469,0.17187 -0.=
0156,0.0781 -0.0625,0.14063 -0.0312,0.0625 -0.0937,0.10937 -0.0625,0.0469 -=
0.125,0.0469 h -2.35937 l -1.46875,7.29687 q -0.0156,0.0625 -0.0469,0.10938=
 -0.0312,0.0312 -0.10937,0.0469 -0.0625,0.0156 -0.17188,0.0312 -0.10937,0.0=
156 -0.28125,0.0156 -0.15625,0 -0.26562,-0.0156 -0.0937,-0.0156 -0.15625,-0=
.0312 -0.0625,-0.0156 -0.0781,-0.0469 -0.0156,-0.0469 -0.0156,-0.10938 l 1.=
46875,-7.29687 h -2.35938 q -0.0937,0 -0.125,-0.0625 -0.0312,-0.0625 -0.031=
2,-0.15625 0,-0.0469 0,-0.10938 0.0156,-0.0781 0.0312,-0.15625 0.0156,-0.09=
37 0.0469,-0.17187 0.0312,-0.0781 0.0625,-0.14063 0.0469,-0.0781 0.0937,-0.=
10937 0.0469,-0.0469 0.10937,-0.0469 h 5.85938 q 0.0781,0 0.10937,0.0625 0.=
0312,0.0625 0.0312,0.17188 z m 5.83861,-0.0156 q 0,0.0312 0,0.10938 0,0.062=
5 -0.0156,0.14062 -0.0156,0.0781 -0.0469,0.15625 -0.0156,0.0781 -0.0625,0.1=
5625 -0.0312,0.0625 -0.0937,0.10938 -0.0469,0.0469 -0.10937,0.0469 h -3.296=
88 l -0.53125,2.64063 h 2.82813 q 0.0781,0 0.10937,0.0469 0.0469,0.0469 0.0=
469,0.15625 0,0.0312 -0.0156,0.10938 0,0.0625 -0.0156,0.14062 -0.0156,0.078=
1 -0.0469,0.15625 -0.0156,0.0781 -0.0469,0.14063 -0.0312,0.0625 -0.0937,0.1=
0937 -0.0469,0.0469 -0.10938,0.0469 H 171.198 l -0.60938,3 h 3.34375 q 0.06=
25,0 0.10938,0.0625 0.0469,0.0469 0.0469,0.15625 0,0.0469 -0.0156,0.125 0,0=
.0625 -0.0156,0.14062 -0.0156,0.0781 -0.0469,0.15625 -0.0156,0.0781 -0.0625=
,0.15625 -0.0312,0.0625 -0.0937,0.10938 -0.0469,0.0312 -0.10938,0.0312 h -4=
.04687 q -0.0781,0 -0.15625,-0.0156 -0.0625,-0.0312 -0.10938,-0.0781 -0.046=
9,-0.0625 -0.0625,-0.14063 -0.0156,-0.0937 0.0156,-0.21875 l 1.5,-7.51562 q=
 0.0469,-0.25 0.20312,-0.34375 0.15625,-0.10938 0.29688,-0.10938 h 4 q 0.14=
062,0 0.14062,0.21875 z m 5.44538,9.9375 q 0,0.0469 0,0.10938 0,0.0625 -0.0=
156,0.125 -0.0156,0.0625 -0.0469,0.14062 -0.0312,0.0781 -0.0781,0.125 -0.03=
12,0.0625 -0.0781,0.0937 -0.0469,0.0469 -0.10938,0.0469 h -6.26562 q -0.078=
1,0 -0.10938,-0.0625 -0.0312,-0.0625 -0.0312,-0.15625 0,-0.0312 0,-0.0937 0=
,-0.0625 0.0156,-0.14063 0.0156,-0.0625 0.0469,-0.14062 0.0156,-0.0625 0.06=
25,-0.14063 0.0312,-0.0625 0.0781,-0.0937 0.0469,-0.0312 0.10937,-0.0312 h =
6.26563 q 0.0781,0 0.10937,0.0625 0.0469,0.0625 0.0469,0.15625 z m 9.27865,=
-9.23437 q 0,0.0469 -0.0156,0.10937 -0.0156,0.0625 -0.0312,0.14063 -0.0156,=
0.0781 -0.0469,0.15625 -0.0156,0.0781 -0.0469,0.14062 -0.0312,0.0625 -0.078=
1,0.10938 -0.0312,0.0312 -0.0781,0.0312 -0.0937,0 -0.26563,-0.10938 -0.1718=
7,-0.125 -0.45312,-0.26562 -0.26563,-0.15625 -0.67188,-0.26563 -0.39062,-0.=
125 -0.9375,-0.125 -0.57812,0 -1.09375,0.17188 -0.5,0.17187 -0.92187,0.4843=
7 -0.42188,0.29688 -0.75,0.70313 -0.32813,0.40625 -0.5625,0.90625 -0.23438,=
0.48437 -0.35938,1.01562 -0.10937,0.53125 -0.10937,1.07813 0,0.5625 0.15625=
,1.01562 0.17187,0.4375 0.48437,0.73438 0.3125,0.29687 0.75,0.45312 0.4375,=
0.15625 0.98438,0.15625 0.40625,0 0.84375,-0.0937 0.45312,-0.0937 0.82812,-=
0.29687 l 0.48438,-2.4375 h -1.95313 q -0.0781,0 -0.125,-0.0469 -0.0312,-0.=
0625 -0.0312,-0.17187 0,-0.0469 0,-0.10938 0.0156,-0.0781 0.0312,-0.15625 0=
.0156,-0.0781 0.0469,-0.15625 0.0312,-0.0781 0.0625,-0.14062 0.0469,-0.0625=
 0.0937,-0.0937 0.0469,-0.0469 0.10937,-0.0469 h 2.67188 q 0.1875,0 0.26562=
,0.125 0.0781,0.125 0.0312,0.32813 l -0.64062,3.25 q -0.0312,0.125 -0.0781,=
0.20312 -0.0312,0.0625 -0.0937,0.125 -0.0469,0.0625 -0.29687,0.17188 -0.234=
38,0.10937 -0.59375,0.23437 -0.35938,0.10938 -0.8125,0.1875 -0.45313,0.0937=
 -0.95313,0.0937 -0.84375,0 -1.48437,-0.20312 -0.64063,-0.21875 -1.07813,-0=
.64063 -0.4375,-0.42187 -0.67187,-1.01562 -0.21875,-0.59375 -0.21875,-1.328=
13 0,-0.70312 0.15625,-1.375 0.15625,-0.67187 0.45312,-1.28125 0.3125,-0.60=
937 0.75,-1.10937 0.4375,-0.51563 1,-0.89063 0.57813,-0.375 1.25,-0.57812 0=
.6875,-0.21875 1.48438,-0.21875 0.45312,0 0.84375,0.0781 0.40625,0.0781 0.7=
1875,0.20313 0.3125,0.10937 0.51562,0.25 0.21875,0.125 0.29688,0.20312 0.07=
81,0.0625 0.10937,0.14063 0.0312,0.0625 0.0312,0.15625 z m 6.9863,0.84375 q=
 0,0.45312 -0.125,0.85937 -0.125,0.39063 -0.39062,0.73438 -0.25,0.34375 -0.=
64063,0.60937 -0.375,0.25 -0.89062,0.42188 0.34375,0.125 0.54687,0.51562 0.=
21875,0.39063 0.34375,1.04688 l 0.34375,1.85937 q 0.0156,0.125 0.0312,0.234=
38 0.0156,0.10937 0.0156,0.1875 0,0.0625 -0.0312,0.10937 -0.0312,0.0469 -0.=
10938,0.0781 -0.0625,0.0156 -0.1875,0.0156 -0.125,0.0156 -0.3125,0.0156 -0.=
17187,0 -0.28125,-0.0156 -0.0937,0 -0.15625,-0.0312 -0.0469,-0.0312 -0.0781=
,-0.0781 -0.0156,-0.0625 -0.0312,-0.14063 l -0.32813,-1.98437 q -0.0625,-0.=
34375 -0.15625,-0.625 -0.0937,-0.28125 -0.26562,-0.48438 -0.15625,-0.20312 =
-0.42188,-0.3125 -0.26562,-0.10937 -0.64062,-0.10937 h -0.75 l -0.71875,3.5=
9375 q -0.0156,0.0469 -0.0469,0.0937 -0.0312,0.0312 -0.10937,0.0469 -0.0781=
,0.0156 -0.1875,0.0312 -0.10938,0.0156 -0.26563,0.0156 -0.15625,0 -0.26562,=
-0.0156 -0.0937,0 -0.15625,-0.0156 -0.0625,-0.0312 -0.0937,-0.0625 -0.0156,=
-0.0469 0,-0.0937 l 1.5625,-7.8125 q 0.0469,-0.25 0.20312,-0.34375 0.15625,=
-0.10938 0.34375,-0.10938 h 1.82813 q 0.60937,0 1.0625,0.125 0.45312,0.1093=
8 0.75,0.34375 0.3125,0.21875 0.45312,0.54688 0.15625,0.32812 0.15625,0.75 =
z m -1.20312,0.17187 q 0,-0.21875 -0.0781,-0.40625 -0.0781,-0.1875 -0.25,-0=
.32812 -0.15625,-0.14063 -0.4375,-0.20313 -0.26562,-0.0781 -0.64062,-0.0781=
 h -1.15625 l -0.57813,2.84375 h 0.98438 q 0.57812,0 0.98437,-0.15625 0.421=
88,-0.15625 0.67188,-0.40625 0.25,-0.26563 0.375,-0.59375 0.125,-0.32813 0.=
125,-0.67188 z m 8.42425,6.09375 q 0.0312,0.14063 0.0156,0.23438 -0.0156,0.=
0781 -0.0781,0.125 -0.0469,0.0469 -0.1875,0.0469 -0.125,0.0156 -0.34375,0.0=
156 -0.14062,0 -0.25,-0.0156 -0.10937,0 -0.17187,-0.0156 -0.0469,-0.0312 -0=
.0781,-0.0625 -0.0156,-0.0469 -0.0312,-0.0937 l -0.3125,-2.0625 h -3.5 l -1=
.09375,2.03125 q -0.0469,0.0781 -0.0937,0.125 -0.0312,0.0312 -0.10937,0.062=
5 -0.0781,0.0156 -0.20313,0.0156 -0.10937,0.0156 -0.28125,0.0156 -0.20312,0=
 -0.3125,-0.0156 -0.125,-0.0156 -0.15625,-0.0469 -0.0469,-0.0469 -0.0312,-0=
.14063 0.0156,-0.0937 0.0937,-0.23437 l 4.375,-7.8125 q 0.0469,-0.0781 0.09=
37,-0.125 0.0625,-0.0469 0.14063,-0.0625 0.0937,-0.0312 0.21875,-0.0312 0.1=
25,-0.0156 0.3125,-0.0156 0.21875,0 0.34375,0.0156 0.14062,0 0.21875,0.0312=
 0.0937,0.0156 0.125,0.0625 0.0312,0.0469 0.0469,0.125 z m -2.1875,-6.90625=
 v 0 l -2.28125,4.1875 h 2.92188 z m 9.93059,0.85938 q 0,0.34375 -0.0781,0.=
71875 -0.0781,0.375 -0.26562,0.73437 -0.17188,0.35938 -0.4375,0.6875 -0.265=
63,0.32813 -0.65625,0.57813 -0.375,0.23437 -0.875,0.375 -0.5,0.14062 -1.187=
5,0.14062 h -1.15625 l -0.59375,3.04688 q -0.0156,0.0469 -0.0469,0.0937 -0.=
0312,0.0312 -0.10937,0.0469 -0.0781,0.0156 -0.1875,0.0312 -0.10938,0.0156 -=
0.26563,0.0156 -0.15625,0 -0.26562,-0.0156 -0.0937,0 -0.15625,-0.0156 -0.06=
25,-0.0312 -0.0937,-0.0625 -0.0156,-0.0469 0,-0.0937 l 1.54687,-7.78125 q 0=
.0469,-0.26563 0.20313,-0.375 0.17187,-0.10938 0.39062,-0.10938 h 1.65625 q=
 0.32813,0 0.57813,0.0312 0.25,0.0156 0.48437,0.0625 0.35938,0.0781 0.64063=
,0.25 0.28125,0.15625 0.46875,0.40625 0.20312,0.23438 0.29687,0.54688 0.109=
38,0.3125 0.10938,0.6875 z m -1.1875,0.10937 q 0,-0.40625 -0.20313,-0.6875 =
-0.1875,-0.29687 -0.60937,-0.40625 -0.15625,-0.0469 -0.34375,-0.0625 -0.187=
5,-0.0156 -0.40625,-0.0156 h -1.04688 l -0.67187,3.375 h 1.0625 q 0.46875,0=
 0.78125,-0.0937 0.32812,-0.10938 0.5625,-0.28125 0.25,-0.17188 0.40625,-0.=
39063 0.17187,-0.23437 0.26562,-0.46875 0.10938,-0.25 0.15625,-0.5 0.0469,-=
0.25 0.0469,-0.46875 z m 7.76033,6.17188 q -0.0156,0.0469 -0.0469,0.0937 -0=
.0312,0.0312 -0.10937,0.0469 -0.0625,0.0156 -0.17188,0.0312 -0.10937,0.0156=
 -0.28125,0.0156 -0.15625,0 -0.26562,-0.0156 -0.0937,-0.0156 -0.15625,-0.03=
12 -0.0625,-0.0156 -0.0781,-0.0469 -0.0156,-0.0469 0,-0.0937 l 0.73438,-3.7=
5 h -3.82813 l -0.73437,3.75 q -0.0156,0.0469 -0.0469,0.0937 -0.0312,0.0312=
 -0.10937,0.0469 -0.0781,0.0156 -0.1875,0.0312 -0.10938,0.0156 -0.26563,0.0=
156 -0.17187,0 -0.28125,-0.0156 -0.0937,-0.0156 -0.15625,-0.0312 -0.0469,-0=
.0156 -0.0781,-0.0469 -0.0156,-0.0469 0,-0.0937 l 1.60937,-8.10938 q 0.0156=
,-0.0312 0.0469,-0.0625 0.0469,-0.0469 0.10937,-0.0625 0.0781,-0.0312 0.187=
5,-0.0469 0.10938,-0.0156 0.26563,-0.0156 0.15625,0 0.26562,0.0156 0.10938,=
0.0156 0.15625,0.0469 0.0625,0.0156 0.0781,0.0625 0.0156,0.0312 0.0156,0.06=
25 l -0.67187,3.39063 h 3.82812 l 0.67188,-3.39063 q 0.0156,-0.0312 0.0469,=
-0.0625 0.0312,-0.0469 0.0937,-0.0625 0.0781,-0.0312 0.1875,-0.0469 0.10938=
,-0.0156 0.28125,-0.0156 0.15625,0 0.25,0.0156 0.10938,0.0156 0.17188,0.046=
9 0.0625,0.0156 0.0781,0.0625 0.0156,0.0312 0,0.0625 z m 7.38217,1.89062 q =
0,0.0469 0,0.10938 0,0.0625 -0.0156,0.125 -0.0156,0.0625 -0.0469,0.14062 -0=
.0312,0.0781 -0.0781,0.125 -0.0312,0.0625 -0.0781,0.0937 -0.0469,0.0469 -0.=
10938,0.0469 h -6.26562 q -0.0781,0 -0.10938,-0.0625 -0.0312,-0.0625 -0.031=
2,-0.15625 0,-0.0312 0,-0.0937 0,-0.0625 0.0156,-0.14063 0.0156,-0.0625 0.0=
469,-0.14062 0.0156,-0.0625 0.0625,-0.14063 0.0312,-0.0625 0.0781,-0.0937 0=
.0469,-0.0312 0.10937,-0.0312 h 6.26563 q 0.0781,0 0.10937,0.0625 0.0469,0.=
0625 0.0469,0.15625 z m 7.49741,-9.9375 q 0,0.0469 0,0.10938 0,0.0625 -0.01=
56,0.14062 -0.0156,0.0781 -0.0469,0.17188 -0.0312,0.0781 -0.0781,0.15625 -0=
.0312,0.0625 -0.0781,0.10937 -0.0469,0.0469 -0.125,0.0469 h -3.07813 l -0.5=
625,2.85937 h 2.90625 q 0.0781,0 0.10938,0.0625 0.0469,0.0469 0.0469,0.1406=
3 0,0.0625 -0.0156,0.14062 0,0.0625 -0.0156,0.14063 -0.0156,0.0625 -0.0469,=
0.15625 -0.0156,0.0781 -0.0625,0.14062 -0.0312,0.0625 -0.0937,0.10938 -0.04=
69,0.0469 -0.10938,0.0469 h -2.90625 l -0.70312,3.5 q -0.0156,0.0625 -0.046=
9,0.10938 -0.0312,0.0312 -0.10937,0.0469 -0.0625,0.0156 -0.17188,0.0312 -0.=
10937,0.0156 -0.28125,0.0156 -0.15625,0 -0.26562,-0.0156 -0.10938,-0.0156 -=
0.17188,-0.0312 -0.0469,-0.0156 -0.0781,-0.0469 -0.0156,-0.0469 0,-0.10938 =
l 1.5625,-7.79687 q 0.0469,-0.25 0.20312,-0.34375 0.15625,-0.10938 0.29688,=
-0.10938 h 3.78125 q 0.0937,0 0.125,0.0625 0.0312,0.0625 0.0312,0.15625 z m=
 6.32704,0 q 0,0.0312 0,0.10938 0,0.0625 -0.0156,0.14062 -0.0156,0.0781 -0.=
0469,0.15625 -0.0156,0.0781 -0.0625,0.15625 -0.0312,0.0625 -0.0937,0.10938 =
-0.0469,0.0469 -0.10938,0.0469 h -3.29687 l -0.53125,2.64063 h 2.82812 q 0.=
0781,0 0.10938,0.0469 0.0469,0.0469 0.0469,0.15625 0,0.0312 -0.0156,0.10938=
 0,0.0625 -0.0156,0.14062 -0.0156,0.0781 -0.0469,0.15625 -0.0156,0.0781 -0.=
0469,0.14063 -0.0312,0.0625 -0.0937,0.10937 -0.0469,0.0469 -0.10937,0.0469 =
H 235.652 l -0.60937,3 h 3.34375 q 0.0625,0 0.10937,0.0625 0.0469,0.0469 0.=
0469,0.15625 0,0.0469 -0.0156,0.125 0,0.0625 -0.0156,0.14062 -0.0156,0.0781=
 -0.0469,0.15625 -0.0156,0.0781 -0.0625,0.15625 -0.0312,0.0625 -0.0937,0.10=
938 -0.0469,0.0312 -0.10937,0.0312 h -4.04688 q -0.0781,0 -0.15625,-0.0156 =
-0.0625,-0.0312 -0.10937,-0.0781 -0.0469,-0.0625 -0.0625,-0.14063 -0.0156,-=
0.0937 0.0156,-0.21875 l 1.5,-7.51562 q 0.0469,-0.25 0.20313,-0.34375 0.156=
25,-0.10938 0.29687,-0.10938 h 4 q 0.14063,0 0.14063,0.21875 z m 6.711,7.73=
438 q -0.0156,0.14062 -0.0781,0.23437 -0.0625,0.0781 -0.14062,0.14063 -0.06=
25,0.0625 -0.15625,0.0937 -0.0781,0.0156 -0.17188,0.0156 h -0.42187 q -0.17=
188,0 -0.29688,-0.0312 -0.10937,-0.0469 -0.20312,-0.14062 -0.0781,-0.0937 -=
0.15625,-0.23438 -0.0625,-0.15625 -0.14063,-0.39062 l -1.57812,-4.48438 q -=
0.15625,-0.48437 -0.32813,-0.95312 -0.15625,-0.48438 -0.29687,-0.96875 h -0=
.0156 q -0.0781,0.53125 -0.1875,1.0625 -0.0937,0.51562 -0.20312,1.04687 l -=
0.96875,4.90625 q -0.0156,0.0625 -0.0625,0.10938 -0.0312,0.0312 -0.0937,0.0=
469 -0.0625,0.0156 -0.17188,0.0312 -0.10937,0.0156 -0.26562,0.0156 -0.14063=
,0 -0.25,-0.0156 -0.0937,-0.0156 -0.15625,-0.0312 -0.0469,-0.0156 -0.0625,-=
0.0469 -0.0156,-0.0469 0,-0.10938 l 1.54687,-7.76562 q 0.0469,-0.26563 0.21=
875,-0.375 0.17188,-0.10938 0.34375,-0.10938 h 0.5 q 0.15625,0 0.26563,0.03=
12 0.125,0.0312 0.20312,0.125 0.0937,0.0781 0.15625,0.21875 0.0781,0.125 0.=
15625,0.32813 l 1.59375,4.5625 q 0.14063,0.42187 0.28125,0.84375 0.15625,0.=
42187 0.29688,0.84375 h 0.0156 q 0.0937,-0.53125 0.20313,-1.09375 0.10937,-=
0.57813 0.20312,-1.10938 l 0.92188,-4.5625 q 0.0156,-0.0625 0.0469,-0.0937 =
0.0312,-0.0312 0.0937,-0.0625 0.0625,-0.0312 0.15625,-0.0312 0.10938,-0.015=
6 0.26563,-0.0156 0.15625,0 0.25,0.0156 0.10937,0 0.15625,0.0312 0.0625,0.0=
312 0.0781,0.0625 0.0156,0.0312 0.0156,0.0937 z m 9.09039,-7.09375 q 0,0.14=
062 -0.0469,0.34375 -0.0469,0.20312 -0.125,0.32812 -0.0781,0.10938 -0.15625=
,0.10938 -0.0937,0 -0.21875,-0.125 -0.125,-0.125 -0.32812,-0.26563 -0.20313=
,-0.14062 -0.53125,-0.25 -0.32813,-0.125 -0.82813,-0.125 -0.54687,0 -1,0.20=
313 -0.4375,0.20312 -0.8125,0.5625 -0.35937,0.34375 -0.64062,0.79687 -0.265=
63,0.45313 -0.45313,0.95313 -0.17187,0.5 -0.26562,1.01562 -0.0781,0.5 -0.07=
81,0.95313 0,0.51562 0.125,0.92187 0.125,0.40625 0.375,0.6875 0.25,0.28125 =
0.60938,0.42188 0.35937,0.14062 0.8125,0.14062 0.51562,0 0.875,-0.10937 0.3=
75,-0.10938 0.625,-0.25 0.26562,-0.14063 0.4375,-0.25 0.1875,-0.125 0.29687=
,-0.125 0.0781,0 0.10938,0.0625 0.0312,0.0469 0.0312,0.15625 0,0.0312 -0.01=
56,0.0937 -0.0156,0.0625 -0.0312,0.14062 0,0.0625 -0.0156,0.15625 -0.0156,0=
.0781 -0.0469,0.15625 -0.0312,0.0625 -0.0625,0.125 -0.0156,0.0625 -0.0937,0=
.125 -0.0625,0.0625 -0.28125,0.20313 -0.21875,0.125 -0.53125,0.23437 -0.312=
5,0.10938 -0.71875,0.1875 -0.39062,0.0937 -0.82812,0.0937 -0.67188,0 -1.203=
13,-0.20312 -0.53125,-0.20313 -0.90625,-0.57813 -0.375,-0.39062 -0.57812,-0=
.96875 -0.20313,-0.57812 -0.20313,-1.32812 0,-0.60938 0.125,-1.26563 0.1406=
3,-0.65625 0.39063,-1.26562 0.25,-0.625 0.625,-1.17188 0.39062,-0.54687 0.8=
9062,-0.95312 0.5,-0.42188 1.125,-0.65625 0.64063,-0.25 1.39063,-0.25 0.484=
37,0 0.89062,0.10937 0.42188,0.10938 0.70313,0.28125 0.29687,0.15625 0.4218=
7,0.28125 0.14063,0.125 0.14063,0.29688 z m 6.26028,-0.64063 q 0,0.0312 0,0=
.10938 0,0.0625 -0.0156,0.14062 -0.0156,0.0781 -0.0469,0.15625 -0.0156,0.07=
81 -0.0625,0.15625 -0.0312,0.0625 -0.0937,0.10938 -0.0469,0.0469 -0.10937,0=
.0469 h -3.29688 l -0.53125,2.64063 h 2.82813 q 0.0781,0 0.10937,0.0469 0.0=
469,0.0469 0.0469,0.15625 0,0.0312 -0.0156,0.10938 0,0.0625 -0.0156,0.14062=
 -0.0156,0.0781 -0.0469,0.15625 -0.0156,0.0781 -0.0469,0.14063 -0.0312,0.06=
25 -0.0937,0.10937 -0.0469,0.0469 -0.10938,0.0469 h -2.82812 l -0.60936,3 h=
 3.34373 q 0.0625,0 0.10938,0.0625 0.0469,0.0469 0.0469,0.15625 0,0.0469 -0=
.0156,0.125 0,0.0625 -0.0156,0.14062 -0.0156,0.0781 -0.0469,0.15625 -0.0156=
,0.0781 -0.0625,0.15625 -0.0312,0.0625 -0.0937,0.10938 -0.0469,0.0312 -0.10=
938,0.0312 h -4.04686 q -0.0781,0 -0.15625,-0.0156 -0.0625,-0.0312 -0.10937=
,-0.0781 -0.0469,-0.0625 -0.0625,-0.14063 -0.0156,-0.0937 0.0156,-0.21875 l=
 1.49999,-7.51562 q 0.0469,-0.25 0.20312,-0.34375 0.15625,-0.10938 0.29688,=
-0.10938 h 4 q 0.14062,0 0.14062,0.21875 z"
-       fill-rule=3D"nonzero"
-       id=3D"path258" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 173.78297,198.86352 1.26562,0.3125 q -0.39062,1.5625 -1.4218=
7,2.375 -1.03125,0.8125 -2.53125,0.8125 -1.53125,0 -2.5,-0.625 -0.96875,-0.=
625 -1.48438,-1.8125 -0.5,-1.1875 -0.5,-2.5625 0,-1.48438 0.5625,-2.59375 0=
.57813,-1.10938 1.625,-1.6875 1.0625,-0.57813 2.32813,-0.57813 1.42187,0 2.=
39062,0.73438 0.98438,0.71875 1.375,2.04687 l -1.25,0.29688 q -0.32812,-1.0=
4688 -0.96875,-1.51563 -0.625,-0.48437 -1.57812,-0.48437 -1.09375,0 -1.8437=
5,0.53125 -0.73438,0.53125 -1.03125,1.42187 -0.29688,0.875 -0.29688,1.82813=
 0,1.21875 0.34375,2.125 0.35938,0.90625 1.10938,1.35937 0.75,0.4375 1.625,=
0.4375 1.0625,0 1.79687,-0.60937 0.73438,-0.60938 0.98438,-1.8125 z m 2.687=
65,-4.84375 v -1.35938 h 1.17188 v 1.35938 z m 0,8.1875 v -6.90625 h 1.1718=
8 v 6.90625 z m 2.92984,0 v -6.90625 h 1.0625 v 1.04687 q 0.40625,-0.73437 =
0.73438,-0.96875 0.34375,-0.23437 0.76562,-0.23437 0.59375,0 1.20313,0.375 =
l -0.40625,1.07812 q -0.4375,-0.25 -0.85938,-0.25 -0.39062,0 -0.70312,0.234=
38 -0.29688,0.23437 -0.42188,0.64062 -0.20312,0.625 -0.20312,1.35938 v 3.62=
5 z m 8.96962,-2.53125 1.15625,0.15625 q -0.1875,1.1875 -0.96875,1.85937 -0=
.78125,0.67188 -1.92187,0.67188 -1.40625,0 -2.28125,-0.92188 -0.85938,-0.93=
75 -0.85938,-2.65625 0,-1.125 0.375,-1.96875 0.375,-0.84375 1.125,-1.25 0.7=
6563,-0.42187 1.65625,-0.42187 1.125,0 1.84375,0.57812 0.71875,0.5625 0.921=
88,1.60938 l -1.14063,0.17187 q -0.17187,-0.70312 -0.59375,-1.04687 -0.4062=
5,-0.35938 -0.98437,-0.35938 -0.89063,0 -1.45313,0.64063 -0.54687,0.64062 -=
0.54687,2 0,1.40625 0.53125,2.03125 0.54687,0.625 1.40625,0.625 0.6875,0 1.=
14062,-0.42188 0.46875,-0.42187 0.59375,-1.29687 z m 6.67969,2.53125 v -1.0=
1563 q -0.8125,1.17188 -2.1875,1.17188 -0.60937,0 -1.14062,-0.23438 -0.5312=
5,-0.23437 -0.79688,-0.57812 -0.25,-0.35938 -0.35937,-0.875 -0.0625,-0.3437=
5 -0.0625,-1.09375 v -4.28125 h 1.17187 v 3.82812 q 0,0.92188 0.0625,1.2343=
8 0.10938,0.46875 0.46875,0.73437 0.35938,0.25 0.89063,0.25 0.51562,0 0.984=
37,-0.26562 0.46875,-0.26563 0.65625,-0.73438 0.1875,-0.46875 0.1875,-1.343=
75 v -3.70312 h 1.17188 v 6.90625 z m 2.8656,0 v -9.54688 h 1.17188 v 9.546=
88 z m 7.49234,-0.85938 q -0.65625,0.5625 -1.26562,0.79688 -0.59375,0.21875=
 -1.28125,0.21875 -1.14063,0 -1.75,-0.54688 -0.60938,-0.5625 -0.60938,-1.43=
75 0,-0.5 0.21875,-0.92187 0.23438,-0.42188 0.60938,-0.67188 0.375,-0.25 0.=
84375,-0.39062 0.34375,-0.0781 1.04687,-0.17188 1.42188,-0.17187 2.09375,-0=
.40625 0,-0.23437 0,-0.29687 0,-0.71875 -0.32812,-1.01563 -0.45313,-0.39062=
 -1.34375,-0.39062 -0.8125,0 -1.21875,0.29687 -0.39063,0.28125 -0.57813,1.0=
1563 l -1.14062,-0.15625 q 0.15625,-0.73438 0.51562,-1.1875 0.35938,-0.4531=
3 1.03125,-0.6875 0.67188,-0.25 1.5625,-0.25 0.89063,0 1.4375,0.20312 0.562=
5,0.20313 0.8125,0.53125 0.26563,0.3125 0.375,0.79688 0.0469,0.29687 0.0469=
,1.07812 v 1.5625 q 0,1.625 0.0781,2.0625 0.0781,0.4375 0.29688,0.82813 h -=
1.21875 q -0.1875,-0.35938 -0.23438,-0.85938 z m -0.0937,-2.60937 q -0.6406=
2,0.26562 -1.92187,0.4375 -0.71875,0.10937 -1.01563,0.25 -0.29687,0.125 -0.=
46875,0.375 -0.15625,0.25 -0.15625,0.54687 0,0.46875 0.34375,0.78125 0.3593=
8,0.3125 1.04688,0.3125 0.67187,0 1.20312,-0.29687 0.53125,-0.29688 0.78125=
,-0.8125 0.1875,-0.39063 0.1875,-1.17188 z m 2.97498,3.46875 v -6.90625 h 1=
.0625 v 1.04687 q 0.40625,-0.73437 0.73437,-0.96875 0.34375,-0.23437 0.7656=
3,-0.23437 0.59375,0 1.20312,0.375 l -0.40625,1.07812 q -0.4375,-0.25 -0.85=
937,-0.25 -0.39063,0 -0.70313,0.23438 -0.29687,0.23437 -0.42187,0.64062 -0.=
20313,0.625 -0.20313,1.35938 v 3.625 z m 8.25073,0 v -9.54688 h 3.59375 q 1=
.09375,0 1.75,0.29688 0.65625,0.28125 1.03125,0.89062 0.375,0.60938 0.375,1=
.26563 0,0.60937 -0.34375,1.15625 -0.32813,0.53125 -0.98438,0.85937 0.85938=
,0.25 1.32813,0.875 0.46875,0.60938 0.46875,1.4375 0,0.67188 -0.29688,1.25 =
-0.28125,0.57813 -0.70312,0.89063 -0.40625,0.3125 -1.03125,0.46875 -0.625,0=
.15625 -1.54688,0.15625 z m 1.26562,-5.53125 h 2.0625 q 0.84375,0 1.20313,-=
0.10938 0.48437,-0.14062 0.71875,-0.46875 0.25,-0.34375 0.25,-0.84375 0,-0.=
46875 -0.23438,-0.82812 -0.21875,-0.35938 -0.64062,-0.5 -0.42188,-0.14063 -=
1.45313,-0.14063 h -1.90625 z m 0,4.40625 h 2.375 q 0.60938,0 0.85938,-0.04=
69 0.4375,-0.0781 0.73437,-0.25 0.29688,-0.1875 0.48438,-0.53125 0.1875,-0.=
35937 0.1875,-0.8125 0,-0.53125 -0.28125,-0.92187 -0.26563,-0.40625 -0.75,-=
0.5625 -0.48438,-0.15625 -1.40625,-0.15625 h -2.20313 z m 12.06163,1.125 v =
-1.01563 q -0.8125,1.17188 -2.1875,1.17188 -0.60937,0 -1.14062,-0.23438 -0.=
53125,-0.23437 -0.79688,-0.57812 -0.25,-0.35938 -0.35937,-0.875 -0.0625,-0.=
34375 -0.0625,-1.09375 v -4.28125 h 1.17187 v 3.82812 q 0,0.92188 0.0625,1.=
23438 0.10938,0.46875 0.46875,0.73437 0.35938,0.25 0.89063,0.25 0.51562,0 0=
.98437,-0.26562 0.46875,-0.26563 0.65625,-0.73438 0.1875,-0.46875 0.1875,-1=
.34375 v -3.70312 h 1.17188 v 6.90625 z m 3.16248,0 v -6 h -1.03125 v -0.90=
625 h 1.03125 v -0.73438 q 0,-0.70312 0.125,-1.04687 0.17187,-0.45313 0.593=
75,-0.73438 0.42187,-0.28125 1.20312,-0.28125 0.48438,0 1.09375,0.10938 l -=
0.1875,1.03125 q -0.35937,-0.0625 -0.6875,-0.0625 -0.53125,0 -0.75,0.23437 =
-0.21875,0.21875 -0.21875,0.84375 v 0.64063 h 1.34375 v 0.90625 h -1.34375 =
v 6 z m 3.4621,0 v -6 h -1.03125 v -0.90625 h 1.03125 v -0.73438 q 0,-0.703=
12 0.125,-1.04687 0.17187,-0.45313 0.59375,-0.73438 0.42187,-0.28125 1.2031=
2,-0.28125 0.48438,0 1.09375,0.10938 l -0.1875,1.03125 q -0.35937,-0.0625 -=
0.6875,-0.0625 -0.53125,0 -0.75,0.23437 -0.21875,0.21875 -0.21875,0.84375 v=
 0.64063 h 1.34375 v 0.90625 h -1.34375 v 6 z m 8.15611,-2.21875 1.20312,0.=
14062 q -0.28125,1.0625 -1.0625,1.65625 -0.76562,0.57813 -1.96875,0.57813 -=
1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375 -0.89062,-2.60938 0,-1.75 0.890=
62,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.39063,0 2.26563,0.9375 0.87=
5,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.15625 q 0.0625,1.14062 0.640=
62,1.75 0.57813,0.59375 1.4375,0.59375 0.65625,0 1.10938,-0.32813 0.45312,-=
0.34375 0.71875,-1.07812 z m -3.84375,-1.90625 h 3.85937 q -0.0781,-0.85938=
 -0.4375,-1.29688 -0.5625,-0.6875 -1.45312,-0.6875 -0.8125,0 -1.35938,0.546=
88 -0.54687,0.53125 -0.60937,1.4375 z m 6.50622,4.125 v -6.90625 h 1.0625 v=
 1.04687 q 0.40625,-0.73437 0.73438,-0.96875 0.34375,-0.23437 0.76562,-0.23=
437 0.59375,0 1.20313,0.375 l -0.40625,1.07812 q -0.4375,-0.25 -0.85938,-0.=
25 -0.39062,0 -0.70312,0.23438 -0.29688,0.23437 -0.42188,0.64062 -0.20312,0=
.625 -0.20312,1.35938 v 3.625 z"
-       fill-rule=3D"nonzero"
-       id=3D"path260" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 187.94858,237.4041 v -9.54687 h 1.29687 l 5.01563,7.5 v -7.5=
 h 1.20312 v 9.54687 h -1.29687 l -5.01563,-7.5 v 7.5 z m 9.04703,-3.45312 =
q 0,-1.92188 1.07812,-2.84375 0.89063,-0.76563 2.17188,-0.76563 1.42187,0 2=
.32812,0.9375 0.90625,0.92188 0.90625,2.57813 0,1.32812 -0.40625,2.09375 -0=
.39062,0.76562 -1.15625,1.1875 -0.76562,0.42187 -1.67187,0.42187 -1.45313,0=
 -2.35938,-0.92187 -0.89062,-0.9375 -0.89062,-2.6875 z m 1.20312,0 q 0,1.32=
812 0.57813,1.98437 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45312,-0.6562=
5 0.57813,-0.67187 0.57813,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57813,-0=
.65625 -1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57813,0.65625 -0.57813=
,1.98438 z m 11.13123,3.45312 v -0.875 q -0.65625,1.03125 -1.9375,1.03125 -=
0.8125,0 -1.51563,-0.45312 -0.6875,-0.45313 -1.07812,-1.26563 -0.375,-0.828=
12 -0.375,-1.89062 0,-1.03125 0.34375,-1.875 0.34375,-0.84375 1.03125,-1.28=
125 0.70312,-0.45313 1.54687,-0.45313 0.625,0 1.10938,0.26563 0.5,0.25 0.79=
687,0.67187 v -3.42187 h 1.17188 v 9.54687 z m -3.70313,-3.45312 q 0,1.3281=
2 0.5625,1.98437 0.5625,0.65625 1.32813,0.65625 0.76562,0 1.29687,-0.625 0.=
53125,-0.625 0.53125,-1.90625 0,-1.42187 -0.54687,-2.07812 -0.54688,-0.6718=
8 -1.34375,-0.67188 -0.78125,0 -1.3125,0.64063 -0.51563,0.625 -0.51563,2 z =
m 11.36561,1.23437 1.20312,0.14063 q -0.28125,1.0625 -1.0625,1.65625 -0.765=
62,0.57812 -1.96875,0.57812 -1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375 -0=
.89062,-2.60937 0,-1.75 0.89062,-2.70313 0.90625,-0.96875 2.34375,-0.96875 =
1.39063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,0.10938 0,0.3125 h -5=
.15625 q 0.0625,1.14063 0.64062,1.75 0.57813,0.59375 1.4375,0.59375 0.65625=
,0 1.10938,-0.32812 0.45312,-0.34375 0.71875,-1.07813 z m -3.84375,-1.90625=
 h 3.85937 q -0.0781,-0.85937 -0.4375,-1.29687 -0.5625,-0.6875 -1.45312,-0.=
6875 -0.8125,0 -1.35938,0.54687 -0.54687,0.53125 -0.60937,1.4375 z m 9.8967=
1,-0.57812 q 0,-1.6875 0.34375,-2.71875 0.35937,-1.03125 1.04687,-1.59375 0=
.6875,-0.5625 1.71875,-0.5625 0.78125,0 1.35938,0.3125 0.57812,0.29687 0.95=
312,0.89062 0.375,0.57813 0.59375,1.42188 0.21875,0.82812 0.21875,2.25 0,1.=
67187 -0.35937,2.70312 -0.34375,1.03125 -1.03125,1.59375 -0.67188,0.5625 -1=
.73438,0.5625 -1.375,0 -2.15625,-0.98437 -0.95312,-1.1875 -0.95312,-3.875 z=
 m 1.20312,0 q 0,2.34375 0.54688,3.125 0.5625,0.78125 1.35937,0.78125 0.812=
5,0 1.35938,-0.78125 0.5625,-0.78125 0.5625,-3.125 0,-2.35938 -0.5625,-3.12=
5 -0.54688,-0.78125 -1.35938,-0.78125 -0.8125,0 -1.29687,0.6875 -0.60938,0.=
875 -0.60938,3.21875 z"
-       fill-rule=3D"nonzero"
-       id=3D"path262" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 164.51677,251.04473 1.1875,-0.0781 q 0,0.51562 0.15625,0.875=
 0.15625,0.35937 0.57812,0.59375 0.42188,0.21875 0.96875,0.21875 0.78125,0 =
1.17188,-0.3125 0.39062,-0.3125 0.39062,-0.73438 0,-0.3125 -0.23437,-0.5781=
2 -0.23438,-0.28125 -1.17188,-0.67188 -0.9375,-0.40625 -1.1875,-0.57812 -0.=
4375,-0.26563 -0.67187,-0.625 -0.21875,-0.35938 -0.21875,-0.82813 0,-0.8125=
 0.65625,-1.39062 0.65625,-0.59375 1.82812,-0.59375 1.29688,0 1.96875,0.609=
37 0.6875,0.59375 0.71875,1.57813 l -1.15625,0.0781 q -0.0312,-0.625 -0.453=
12,-0.98437 -0.40625,-0.375 -1.17188,-0.375 -0.60937,0 -0.95312,0.28125 -0.=
32813,0.28125 -0.32813,0.60937 0,0.3125 0.29688,0.5625 0.1875,0.17188 1,0.5=
3125 1.35937,0.57813 1.70312,0.92188 0.5625,0.53125 0.5625,1.3125 0,0.51562=
 -0.3125,1.01562 -0.3125,0.48438 -0.96875,0.78125 -0.64062,0.29688 -1.51562=
,0.29688 -1.20313,0 -2.04688,-0.59375 -0.84375,-0.59375 -0.79687,-1.92188 z=
 m 9.32031,1.40625 -0.20312,0.95313 q -0.42188,0.10937 -0.8125,0.10937 -0.7=
0313,0 -1.125,-0.34375 -0.3125,-0.25 -0.3125,-0.70312 0,-0.23438 0.17187,-1=
.04688 l 0.82813,-4.01562 h -0.92188 l 0.1875,-0.90625 h 0.9375 l 0.34375,-=
1.70313 1.35938,-0.8125 -0.53125,2.51563 h 1.15625 l -0.1875,0.90625 h -1.1=
5625 l -0.79688,3.8125 q -0.15625,0.73437 -0.15625,0.875 0,0.21875 0.10938,=
0.32812 0.125,0.10938 0.40625,0.10938 0.39062,0 0.70312,-0.0781 z m 0.93737=
,0.95313 1.45312,-6.90625 h 1.03125 l -0.28125,1.40625 q 0.53125,-0.79688 1=
.03125,-1.17188 0.51563,-0.39062 1.04688,-0.39062 0.35937,0 0.875,0.25 l -0=
.48438,1.09375 q -0.3125,-0.21875 -0.67187,-0.21875 -0.625,0 -1.28125,0.687=
5 -0.64063,0.6875 -1.01563,2.48437 l -0.57812,2.76563 z m 9.15712,-1.25 q -=
1.23438,1.40625 -2.54688,1.40625 -0.79687,0 -1.29687,-0.45313 -0.48438,-0.4=
6875 -0.48438,-1.125 0,-0.4375 0.21875,-1.5 l 0.84375,-3.98437 h 1.17188 l =
-0.92188,4.40625 q -0.10937,0.5625 -0.10937,0.85937 0,0.39063 0.23437,0.609=
38 0.23438,0.21875 0.70313,0.21875 0.48437,0 0.95312,-0.23438 0.48438,-0.23=
437 0.8125,-0.64062 0.34375,-0.42188 0.5625,-0.98438 0.14063,-0.35937 0.328=
13,-1.25 l 0.625,-2.98437 h 1.1875 l -1.45313,6.90625 h -1.07812 z m 7.4749=
7,-1.26563 1.17188,0.125 q -0.4375,1.29688 -1.26563,1.92188 -0.8125,0.625 -=
1.84375,0.625 -1.14062,0 -1.84375,-0.71875 -0.6875,-0.73438 -0.6875,-2.0468=
8 0,-1.125 0.4375,-2.21875 0.45313,-1.09375 1.28125,-1.65625 0.84375,-0.578=
12 1.92188,-0.57812 1.10937,0 1.76562,0.625 0.65625,0.625 0.65625,1.65625 l=
 -1.15625,0.0781 q -0.0156,-0.65625 -0.39062,-1.01562 -0.375,-0.375 -0.9843=
8,-0.375 -0.70312,0 -1.23437,0.45312 -0.51563,0.4375 -0.8125,1.35938 -0.296=
88,0.90625 -0.29688,1.75 0,0.89062 0.39063,1.34375 0.39062,0.4375 0.96875,0=
.4375 0.5625,0 1.07812,-0.4375 0.53125,-0.4375 0.84375,-1.32813 z m 4.64844=
,1.5625 -0.20313,0.95313 q -0.42187,0.10937 -0.8125,0.10937 -0.70312,0 -1.1=
25,-0.34375 -0.3125,-0.25 -0.3125,-0.70312 0,-0.23438 0.17188,-1.04688 l 0.=
82812,-4.01562 h -0.92187 l 0.1875,-0.90625 h 0.9375 l 0.34375,-1.70313 1.3=
5937,-0.8125 -0.53125,2.51563 h 1.15625 l -0.1875,0.90625 h -1.15625 l -0.7=
9687,3.8125 q -0.15625,0.73437 -0.15625,0.875 0,0.21875 0.10937,0.32812 0.1=
25,0.10938 0.40625,0.10938 0.39063,0 0.70313,-0.0781 z m 4.64035,0.95313 1.=
45312,-6.90625 h 1.03125 l -0.28125,1.40625 q 0.53125,-0.79688 1.03125,-1.1=
7188 0.51563,-0.39062 1.04688,-0.39062 0.35937,0 0.875,0.25 l -0.48438,1.09=
375 q -0.3125,-0.21875 -0.67187,-0.21875 -0.625,0 -1.28125,0.6875 -0.64063,=
0.6875 -1.01563,2.48437 l -0.57812,2.76563 z m 7.20399,-0.95313 -0.20312,0.=
95313 q -0.42188,0.10937 -0.8125,0.10937 -0.70313,0 -1.125,-0.34375 -0.3125=
,-0.25 -0.3125,-0.70312 0,-0.23438 0.17187,-1.04688 l 0.82813,-4.01562 h -0=
.92188 l 0.1875,-0.90625 h 0.9375 l 0.34375,-1.70313 1.35938,-0.8125 -0.531=
25,2.51563 h 1.15625 l -0.1875,0.90625 h -1.15625 l -0.79688,3.8125 q -0.15=
625,0.73437 -0.15625,0.875 0,0.21875 0.10938,0.32812 0.125,0.10938 0.40625,=
0.10938 0.39062,0 0.70312,-0.0781 z m 6.01549,-1.39062 1.15625,0.10937 q -0=
.25,0.85938 -1.14062,1.625 -0.89063,0.76563 -2.125,0.76563 -0.76563,0 -1.40=
625,-0.34375 -0.64063,-0.35938 -0.98438,-1.03125 -0.32812,-0.6875 -0.32812,=
-1.54688 0,-1.14062 0.51562,-2.20312 0.53125,-1.0625 1.35938,-1.57813 0.843=
75,-0.51562 1.8125,-0.51562 1.23437,0 1.96875,0.76562 0.75,0.76563 0.75,2.0=
9375 0,0.5 -0.0937,1.04688 h -5.09375 q -0.0312,0.1875 -0.0312,0.35937 0,0.=
96875 0.4375,1.48438 0.45312,0.5 1.10937,0.5 0.59375,0 1.17188,-0.39063 0.5=
9375,-0.39062 0.92187,-1.14062 z m -3.42187,-1.71875 h 3.875 q 0.0156,-0.18=
75 0.0156,-0.26563 0,-0.875 -0.45312,-1.34375 -0.4375,-0.48437 -1.125,-0.48=
437 -0.76563,0 -1.39063,0.53125 -0.60937,0.51562 -0.92187,1.5625 z m 4.4749=
7,6.71875 v -0.85938 h 7.76563 v 0.85938 z m 8.69373,-2.65625 1.45312,-6.90=
625 h 1.0625 l -0.25,1.20312 q 0.6875,-0.71875 1.29688,-1.03125 0.60937,-0.=
32812 1.23437,-0.32812 0.84375,0 1.3125,0.45312 0.48438,0.45313 0.48438,1.2=
1875 0,0.375 -0.17188,1.20313 l -0.875,4.1875 h -1.17187 l 0.92187,-4.375 q=
 0.125,-0.64063 0.125,-0.95313 0,-0.34375 -0.23437,-0.54687 -0.23438,-0.218=
75 -0.6875,-0.21875 -0.90625,0 -1.60938,0.65625 -0.70312,0.64062 -1.03125,2=
.21875 l -0.67187,3.21875 z m 7.63122,-2.625 q 0,-2.01563 1.1875,-3.34375 0=
.98438,-1.09375 2.57813,-1.09375 1.25,0 2.01562,0.78125 0.76563,0.78125 0.7=
6563,2.10937 0,1.1875 -0.48438,2.21875 -0.48437,1.01563 -1.375,1.5625 -0.89=
062,0.54688 -1.875,0.54688 -0.79687,0 -1.46875,-0.34375 -0.65625,-0.34375 -=
1,-0.96875 -0.34375,-0.64063 -0.34375,-1.46875 z m 1.17188,-0.10938 q 0,0.9=
6875 0.46875,1.48438 0.46875,0.5 1.1875,0.5 0.375,0 0.75,-0.15625 0.375,-0.=
15625 0.6875,-0.46875 0.32812,-0.3125 0.54687,-0.70313 0.21875,-0.40625 0.3=
5938,-0.875 0.20312,-0.64062 0.20312,-1.23437 0,-0.9375 -0.46875,-1.45313 -=
0.46875,-0.51562 -1.1875,-0.51562 -0.5625,0 -1.01562,0.26562 -0.45313,0.265=
63 -0.82813,0.78125 -0.35937,0.5 -0.53125,1.17188 -0.17187,0.67187 -0.17187=
,1.20312 z m 10.69372,1.73438 q -1.01562,1.15625 -2.10937,1.15625 -0.98438,=
0 -1.64063,-0.71875 -0.65625,-0.73438 -0.65625,-2.10938 0,-1.26562 0.51563,=
-2.3125 0.51562,-1.04687 1.29687,-1.5625 0.78125,-0.51562 1.5625,-0.51562 1=
.28125,0 1.9375,1.23437 l 0.78125,-3.71875 h 1.17188 l -1.98438,9.54688 h -=
1.09375 z m -3.23437,-1.89063 q 0,0.71875 0.14062,1.14063 0.14063,0.40625 0=
.48438,0.6875 0.34375,0.28125 0.82812,0.28125 0.79688,0 1.45313,-0.84375 0.=
875,-1.10938 0.875,-2.73438 0,-0.8125 -0.4375,-1.26562 -0.42188,-0.46875 -1=
.07813,-0.46875 -0.42187,0 -0.76562,0.1875 -0.34375,0.1875 -0.6875,0.64062 =
-0.34375,0.45313 -0.57813,1.15625 -0.23437,0.6875 -0.23437,1.21875 z m 11.0=
531,0.54688 1.15625,0.10937 q -0.25,0.85938 -1.14062,1.625 -0.89063,0.76563=
 -2.125,0.76563 -0.76563,0 -1.40625,-0.34375 -0.64063,-0.35938 -0.98438,-1.=
03125 -0.32812,-0.6875 -0.32812,-1.54688 0,-1.14062 0.51562,-2.20312 0.5312=
5,-1.0625 1.35938,-1.57813 0.84375,-0.51562 1.8125,-0.51562 1.23437,0 1.968=
75,0.76562 0.75,0.76563 0.75,2.09375 0,0.5 -0.0937,1.04688 h -5.09375 q -0.=
0312,0.1875 -0.0312,0.35937 0,0.96875 0.4375,1.48438 0.45312,0.5 1.10937,0.=
5 0.59375,0 1.17188,-0.39063 0.59375,-0.39062 0.92187,-1.14062 z m -3.42187=
,-1.71875 h 3.875 q 0.0156,-0.1875 0.0156,-0.26563 0,-0.875 -0.45312,-1.343=
75 -0.4375,-0.48437 -1.125,-0.48437 -0.76563,0 -1.39063,0.53125 -0.60937,0.=
51562 -0.92187,1.5625 z"
-       fill-rule=3D"nonzero"
-       id=3D"path264" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 187.94858,288.60097 v -9.54687 h 1.29687 l 5.01563,7.5 v -7.=
5 h 1.20312 v 9.54687 h -1.29687 l -5.01563,-7.5 v 7.5 z m 9.04703,-3.45312=
 q 0,-1.92188 1.07812,-2.84375 0.89063,-0.76563 2.17188,-0.76563 1.42187,0 =
2.32812,0.9375 0.90625,0.92188 0.90625,2.57813 0,1.32812 -0.40625,2.09375 -=
0.39062,0.76562 -1.15625,1.1875 -0.76562,0.42187 -1.67187,0.42187 -1.45313,=
0 -2.35938,-0.92187 -0.89062,-0.9375 -0.89062,-2.6875 z m 1.20312,0 q 0,1.3=
2812 0.57813,1.98437 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45312,-0.656=
25 0.57813,-0.67187 0.57813,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57813,-=
0.65625 -1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57813,0.65625 -0.5781=
3,1.98438 z m 11.13123,3.45312 v -0.875 q -0.65625,1.03125 -1.9375,1.03125 =
-0.8125,0 -1.51563,-0.45312 -0.6875,-0.45313 -1.07812,-1.26563 -0.375,-0.82=
812 -0.375,-1.89062 0,-1.03125 0.34375,-1.875 0.34375,-0.84375 1.03125,-1.2=
8125 0.70312,-0.45313 1.54687,-0.45313 0.625,0 1.10938,0.26563 0.5,0.25 0.7=
9687,0.67187 v -3.42187 h 1.17188 v 9.54687 z m -3.70313,-3.45312 q 0,1.328=
12 0.5625,1.98437 0.5625,0.65625 1.32813,0.65625 0.76562,0 1.29687,-0.625 0=
.53125,-0.625 0.53125,-1.90625 0,-1.42187 -0.54687,-2.07812 -0.54688,-0.671=
88 -1.34375,-0.67188 -0.78125,0 -1.3125,0.64063 -0.51563,0.625 -0.51563,2 z=
 m 11.36561,1.23437 1.20312,0.14063 q -0.28125,1.0625 -1.0625,1.65625 -0.76=
562,0.57812 -1.96875,0.57812 -1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375 -=
0.89062,-2.60937 0,-1.75 0.89062,-2.70313 0.90625,-0.96875 2.34375,-0.96875=
 1.39063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,0.10938 0,0.3125 h -=
5.15625 q 0.0625,1.14063 0.64062,1.75 0.57813,0.59375 1.4375,0.59375 0.6562=
5,0 1.10938,-0.32812 0.45312,-0.34375 0.71875,-1.07813 z m -3.84375,-1.9062=
5 h 3.85937 q -0.0781,-0.85937 -0.4375,-1.29687 -0.5625,-0.6875 -1.45312,-0=
.6875 -0.8125,0 -1.35938,0.54687 -0.54687,0.53125 -0.60937,1.4375 z m 14.31=
858,4.125 h -1.17187 v -7.46875 q -0.42188,0.40625 -1.10938,0.8125 -0.6875,=
0.40625 -1.23437,0.60938 v -1.14063 q 0.98437,-0.45312 1.71875,-1.10937 0.7=
3437,-0.67188 1.03125,-1.28125 h 0.76562 z"
-       fill-rule=3D"nonzero"
-       id=3D"path266" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 164.51677,302.2416 1.1875,-0.0781 q 0,0.51563 0.15625,0.875 =
0.15625,0.35938 0.57812,0.59375 0.42188,0.21875 0.96875,0.21875 0.78125,0 1=
.17188,-0.3125 0.39062,-0.3125 0.39062,-0.73437 0,-0.3125 -0.23437,-0.57813=
 -0.23438,-0.28125 -1.17188,-0.67187 -0.9375,-0.40625 -1.1875,-0.57813 -0.4=
375,-0.26562 -0.67187,-0.625 -0.21875,-0.35937 -0.21875,-0.82812 0,-0.8125 =
0.65625,-1.39063 0.65625,-0.59375 1.82812,-0.59375 1.29688,0 1.96875,0.6093=
8 0.6875,0.59375 0.71875,1.57812 l -1.15625,0.0781 q -0.0312,-0.625 -0.4531=
2,-0.98438 -0.40625,-0.375 -1.17188,-0.375 -0.60937,0 -0.95312,0.28125 -0.3=
2813,0.28125 -0.32813,0.60938 0,0.3125 0.29688,0.5625 0.1875,0.17187 1,0.53=
125 1.35937,0.57812 1.70312,0.92187 0.5625,0.53125 0.5625,1.3125 0,0.51563 =
-0.3125,1.01563 -0.3125,0.48437 -0.96875,0.78125 -0.64062,0.29687 -1.51562,=
0.29687 -1.20313,0 -2.04688,-0.59375 -0.84375,-0.59375 -0.79687,-1.92187 z =
m 9.32031,1.40625 -0.20312,0.95312 q -0.42188,0.10938 -0.8125,0.10938 -0.70=
313,0 -1.125,-0.34375 -0.3125,-0.25 -0.3125,-0.70313 0,-0.23437 0.17187,-1.=
04687 l 0.82813,-4.01563 h -0.92188 l 0.1875,-0.90625 h 0.9375 l 0.34375,-1=
.70312 1.35938,-0.8125 -0.53125,2.51562 h 1.15625 l -0.1875,0.90625 h -1.15=
625 l -0.79688,3.8125 q -0.15625,0.73438 -0.15625,0.875 0,0.21875 0.10938,0=
.32813 0.125,0.10937 0.40625,0.10937 0.39062,0 0.70312,-0.0781 z m 0.93737,=
0.95312 1.45312,-6.90625 h 1.03125 l -0.28125,1.40625 q 0.53125,-0.79687 1.=
03125,-1.17187 0.51563,-0.39063 1.04688,-0.39063 0.35937,0 0.875,0.25 l -0.=
48438,1.09375 q -0.3125,-0.21875 -0.67187,-0.21875 -0.625,0 -1.28125,0.6875=
 -0.64063,0.6875 -1.01563,2.48438 l -0.57812,2.76562 z m 9.15712,-1.25 q -1=
.23438,1.40625 -2.54688,1.40625 -0.79687,0 -1.29687,-0.45312 -0.48438,-0.46=
875 -0.48438,-1.125 0,-0.4375 0.21875,-1.5 l 0.84375,-3.98438 h 1.17188 l -=
0.92188,4.40625 q -0.10937,0.5625 -0.10937,0.85938 0,0.39062 0.23437,0.6093=
7 0.23438,0.21875 0.70313,0.21875 0.48437,0 0.95312,-0.23437 0.48438,-0.234=
38 0.8125,-0.64063 0.34375,-0.42187 0.5625,-0.98437 0.14063,-0.35938 0.3281=
3,-1.25 l 0.625,-2.98438 h 1.1875 l -1.45313,6.90625 h -1.07812 z m 7.47497=
,-1.26562 1.17188,0.125 q -0.4375,1.29687 -1.26563,1.92187 -0.8125,0.625 -1=
.84375,0.625 -1.14062,0 -1.84375,-0.71875 -0.6875,-0.73437 -0.6875,-2.04687=
 0,-1.125 0.4375,-2.21875 0.45313,-1.09375 1.28125,-1.65625 0.84375,-0.5781=
3 1.92188,-0.57813 1.10937,0 1.76562,0.625 0.65625,0.625 0.65625,1.65625 l =
-1.15625,0.0781 q -0.0156,-0.65625 -0.39062,-1.01563 -0.375,-0.375 -0.98438=
,-0.375 -0.70312,0 -1.23437,0.45313 -0.51563,0.4375 -0.8125,1.35937 -0.2968=
8,0.90625 -0.29688,1.75 0,0.89063 0.39063,1.34375 0.39062,0.4375 0.96875,0.=
4375 0.5625,0 1.07812,-0.4375 0.53125,-0.4375 0.84375,-1.32812 z m 4.64844,=
1.5625 -0.20313,0.95312 q -0.42187,0.10938 -0.8125,0.10938 -0.70312,0 -1.12=
5,-0.34375 -0.3125,-0.25 -0.3125,-0.70313 0,-0.23437 0.17188,-1.04687 l 0.8=
2812,-4.01563 h -0.92187 l 0.1875,-0.90625 h 0.9375 l 0.34375,-1.70312 1.35=
937,-0.8125 -0.53125,2.51562 h 1.15625 l -0.1875,0.90625 h -1.15625 l -0.79=
687,3.8125 q -0.15625,0.73438 -0.15625,0.875 0,0.21875 0.10937,0.32813 0.12=
5,0.10937 0.40625,0.10937 0.39063,0 0.70313,-0.0781 z m 4.64035,0.95312 1.4=
5312,-6.90625 h 1.03125 l -0.28125,1.40625 q 0.53125,-0.79687 1.03125,-1.17=
187 0.51563,-0.39063 1.04688,-0.39063 0.35937,0 0.875,0.25 l -0.48438,1.093=
75 q -0.3125,-0.21875 -0.67187,-0.21875 -0.625,0 -1.28125,0.6875 -0.64063,0=
.6875 -1.01563,2.48438 l -0.57812,2.76562 z m 7.20399,-0.95312 -0.20312,0.9=
5312 q -0.42188,0.10938 -0.8125,0.10938 -0.70313,0 -1.125,-0.34375 -0.3125,=
-0.25 -0.3125,-0.70313 0,-0.23437 0.17187,-1.04687 l 0.82813,-4.01563 h -0.=
92188 l 0.1875,-0.90625 h 0.9375 l 0.34375,-1.70312 1.35938,-0.8125 -0.5312=
5,2.51562 h 1.15625 l -0.1875,0.90625 h -1.15625 l -0.79688,3.8125 q -0.156=
25,0.73438 -0.15625,0.875 0,0.21875 0.10938,0.32813 0.125,0.10937 0.40625,0=
.10937 0.39062,0 0.70312,-0.0781 z m 6.01549,-1.39063 1.15625,0.10938 q -0.=
25,0.85937 -1.14062,1.625 -0.89063,0.76562 -2.125,0.76562 -0.76563,0 -1.406=
25,-0.34375 -0.64063,-0.35937 -0.98438,-1.03125 -0.32812,-0.6875 -0.32812,-=
1.54687 0,-1.14063 0.51562,-2.20313 0.53125,-1.0625 1.35938,-1.57812 0.8437=
5,-0.51563 1.8125,-0.51563 1.23437,0 1.96875,0.76563 0.75,0.76562 0.75,2.09=
375 0,0.5 -0.0937,1.04687 h -5.09375 q -0.0312,0.1875 -0.0312,0.35938 0,0.9=
6875 0.4375,1.48437 0.45312,0.5 1.10937,0.5 0.59375,0 1.17188,-0.39062 0.59=
375,-0.39063 0.92187,-1.14063 z m -3.42187,-1.71875 h 3.875 q 0.0156,-0.187=
5 0.0156,-0.26562 0,-0.875 -0.45312,-1.34375 -0.4375,-0.48438 -1.125,-0.484=
38 -0.76563,0 -1.39063,0.53125 -0.60937,0.51563 -0.92187,1.5625 z m 4.47497=
,6.71875 v -0.85937 h 7.76563 v 0.85937 z m 8.69373,-2.65625 1.45312,-6.906=
25 h 1.0625 l -0.25,1.20313 q 0.6875,-0.71875 1.29688,-1.03125 0.60937,-0.3=
2813 1.23437,-0.32813 0.84375,0 1.3125,0.45313 0.48438,0.45312 0.48438,1.21=
875 0,0.375 -0.17188,1.20312 l -0.875,4.1875 h -1.17187 l 0.92187,-4.375 q =
0.125,-0.64062 0.125,-0.95312 0,-0.34375 -0.23437,-0.54688 -0.23438,-0.2187=
5 -0.6875,-0.21875 -0.90625,0 -1.60938,0.65625 -0.70312,0.64063 -1.03125,2.=
21875 l -0.67187,3.21875 z m 7.63122,-2.625 q 0,-2.01562 1.1875,-3.34375 0.=
98438,-1.09375 2.57813,-1.09375 1.25,0 2.01562,0.78125 0.76563,0.78125 0.76=
563,2.10938 0,1.1875 -0.48438,2.21875 -0.48437,1.01562 -1.375,1.5625 -0.890=
62,0.54687 -1.875,0.54687 -0.79687,0 -1.46875,-0.34375 -0.65625,-0.34375 -1=
,-0.96875 -0.34375,-0.64062 -0.34375,-1.46875 z m 1.17188,-0.10937 q 0,0.96=
875 0.46875,1.48437 0.46875,0.5 1.1875,0.5 0.375,0 0.75,-0.15625 0.375,-0.1=
5625 0.6875,-0.46875 0.32812,-0.3125 0.54687,-0.70312 0.21875,-0.40625 0.35=
938,-0.875 0.20312,-0.64063 0.20312,-1.23438 0,-0.9375 -0.46875,-1.45312 -0=
.46875,-0.51563 -1.1875,-0.51563 -0.5625,0 -1.01562,0.26563 -0.45313,0.2656=
2 -0.82813,0.78125 -0.35937,0.5 -0.53125,1.17187 -0.17187,0.67188 -0.17187,=
1.20313 z m 10.69372,1.73437 q -1.01562,1.15625 -2.10937,1.15625 -0.98438,0=
 -1.64063,-0.71875 -0.65625,-0.73437 -0.65625,-2.10937 0,-1.26563 0.51563,-=
2.3125 0.51562,-1.04688 1.29687,-1.5625 0.78125,-0.51563 1.5625,-0.51563 1.=
28125,0 1.9375,1.23438 l 0.78125,-3.71875 h 1.17188 l -1.98438,9.54687 h -1=
.09375 z m -3.23437,-1.89062 q 0,0.71875 0.14062,1.14062 0.14063,0.40625 0.=
48438,0.6875 0.34375,0.28125 0.82812,0.28125 0.79688,0 1.45313,-0.84375 0.8=
75,-1.10937 0.875,-2.73437 0,-0.8125 -0.4375,-1.26563 -0.42188,-0.46875 -1.=
07813,-0.46875 -0.42187,0 -0.76562,0.1875 -0.34375,0.1875 -0.6875,0.64063 -=
0.34375,0.45312 -0.57813,1.15625 -0.23437,0.6875 -0.23437,1.21875 z m 11.05=
31,0.54687 1.15625,0.10938 q -0.25,0.85937 -1.14062,1.625 -0.89063,0.76562 =
-2.125,0.76562 -0.76563,0 -1.40625,-0.34375 -0.64063,-0.35937 -0.98438,-1.0=
3125 -0.32812,-0.6875 -0.32812,-1.54687 0,-1.14063 0.51562,-2.20313 0.53125=
,-1.0625 1.35938,-1.57812 0.84375,-0.51563 1.8125,-0.51563 1.23437,0 1.9687=
5,0.76563 0.75,0.76562 0.75,2.09375 0,0.5 -0.0937,1.04687 h -5.09375 q -0.0=
312,0.1875 -0.0312,0.35938 0,0.96875 0.4375,1.48437 0.45312,0.5 1.10937,0.5=
 0.59375,0 1.17188,-0.39062 0.59375,-0.39063 0.92187,-1.14063 z m -3.42187,=
-1.71875 h 3.875 q 0.0156,-0.1875 0.0156,-0.26562 0,-0.875 -0.45312,-1.3437=
5 -0.4375,-0.48438 -1.125,-0.48438 -0.76563,0 -1.39063,0.53125 -0.60937,0.5=
1563 -0.92187,1.5625 z"
-       fill-rule=3D"nonzero"
-       id=3D"path268" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 187.94858,339.7978 v -9.54688 h 1.29687 l 5.01563,7.5 v -7.5=
 h 1.20312 v 9.54688 h -1.29687 l -5.01563,-7.5 v 7.5 z m 9.04703,-3.45313 =
q 0,-1.92187 1.07812,-2.84375 0.89063,-0.76562 2.17188,-0.76562 1.42187,0 2=
.32812,0.9375 0.90625,0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0=
.39062,0.76563 -1.15625,1.1875 -0.76562,0.42188 -1.67187,0.42188 -1.45313,0=
 -2.35938,-0.92188 -0.89062,-0.9375 -0.89062,-2.6875 z m 1.20312,0 q 0,1.32=
813 0.57813,1.98438 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45312,-0.6562=
5 0.57813,-0.67188 0.57813,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57813,-0=
.65625 -1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57813,0.65625 -0.57813=
,1.98437 z m 11.13123,3.45313 v -0.875 q -0.65625,1.03125 -1.9375,1.03125 -=
0.8125,0 -1.51563,-0.45313 -0.6875,-0.45312 -1.07812,-1.26562 -0.375,-0.828=
13 -0.375,-1.89063 0,-1.03125 0.34375,-1.875 0.34375,-0.84375 1.03125,-1.28=
125 0.70312,-0.45312 1.54687,-0.45312 0.625,0 1.10938,0.26562 0.5,0.25 0.79=
687,0.67188 v -3.42188 h 1.17188 v 9.54688 z m -3.70313,-3.45313 q 0,1.3281=
3 0.5625,1.98438 0.5625,0.65625 1.32813,0.65625 0.76562,0 1.29687,-0.625 0.=
53125,-0.625 0.53125,-1.90625 0,-1.42188 -0.54687,-2.07813 -0.54688,-0.6718=
7 -1.34375,-0.67187 -0.78125,0 -1.3125,0.64062 -0.51563,0.625 -0.51563,2 z =
m 11.36561,1.23438 1.20312,0.14062 q -0.28125,1.0625 -1.0625,1.65625 -0.765=
62,0.57813 -1.96875,0.57813 -1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375 -0=
.89062,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-0.96875 2.34375,-0.96875 =
1.39063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5=
.15625 q 0.0625,1.14062 0.64062,1.75 0.57813,0.59375 1.4375,0.59375 0.65625=
,0 1.10938,-0.32813 0.45312,-0.34375 0.71875,-1.07812 z m -3.84375,-1.90625=
 h 3.85937 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.45312,-0.=
6875 -0.8125,0 -1.35938,0.54688 -0.54687,0.53125 -0.60937,1.4375 z m 16.052=
96,3 v 1.125 h -6.29688 q -0.0156,-0.42188 0.14063,-0.8125 0.23437,-0.64063=
 0.76562,-1.26563 0.53125,-0.625 1.53125,-1.45312 1.5625,-1.26563 2.10938,-=
2.01563 0.54687,-0.75 0.54687,-1.40625 0,-0.70312 -0.5,-1.17187 -0.5,-0.484=
38 -1.29687,-0.48438 -0.85938,0 -1.375,0.51563 -0.5,0.5 -0.5,1.39062 l -1.2=
0313,-0.10937 q 0.125,-1.35938 0.92188,-2.0625 0.8125,-0.70313 2.17187,-0.7=
0313 1.375,0 2.17188,0.76563 0.8125,0.75 0.8125,1.875 0,0.57812 -0.23438,1.=
14062 -0.23437,0.54688 -0.78125,1.15625 -0.54687,0.60938 -1.8125,1.67188 -1=
.04687,0.89062 -1.35937,1.21875 -0.29688,0.3125 -0.48438,0.625 z"
-       fill-rule=3D"nonzero"
-       id=3D"path270" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 164.51677,353.43844 1.1875,-0.0781 q 0,0.51562 0.15625,0.875=
 0.15625,0.35937 0.57812,0.59375 0.42188,0.21875 0.96875,0.21875 0.78125,0 =
1.17188,-0.3125 0.39062,-0.3125 0.39062,-0.73438 0,-0.3125 -0.23437,-0.5781=
2 -0.23438,-0.28125 -1.17188,-0.67188 -0.9375,-0.40625 -1.1875,-0.57812 -0.=
4375,-0.26563 -0.67187,-0.625 -0.21875,-0.35938 -0.21875,-0.82813 0,-0.8125=
 0.65625,-1.39062 0.65625,-0.59375 1.82812,-0.59375 1.29688,0 1.96875,0.609=
37 0.6875,0.59375 0.71875,1.57813 l -1.15625,0.0781 q -0.0312,-0.625 -0.453=
12,-0.98437 -0.40625,-0.375 -1.17188,-0.375 -0.60937,0 -0.95312,0.28125 -0.=
32813,0.28125 -0.32813,0.60937 0,0.3125 0.29688,0.5625 0.1875,0.17188 1,0.5=
3125 1.35937,0.57813 1.70312,0.92188 0.5625,0.53125 0.5625,1.3125 0,0.51562=
 -0.3125,1.01562 -0.3125,0.48438 -0.96875,0.78125 -0.64062,0.29688 -1.51562=
,0.29688 -1.20313,0 -2.04688,-0.59375 -0.84375,-0.59375 -0.79687,-1.92188 z=
 m 9.32031,1.40625 -0.20312,0.95313 q -0.42188,0.10937 -0.8125,0.10937 -0.7=
0313,0 -1.125,-0.34375 -0.3125,-0.25 -0.3125,-0.70312 0,-0.23438 0.17187,-1=
.04688 l 0.82813,-4.01562 h -0.92188 l 0.1875,-0.90625 h 0.9375 l 0.34375,-=
1.70313 1.35938,-0.8125 -0.53125,2.51563 h 1.15625 l -0.1875,0.90625 h -1.1=
5625 l -0.79688,3.8125 q -0.15625,0.73437 -0.15625,0.875 0,0.21875 0.10938,=
0.32812 0.125,0.10938 0.40625,0.10938 0.39062,0 0.70312,-0.0781 z m 0.93737=
,0.95313 1.45312,-6.90625 h 1.03125 l -0.28125,1.40625 q 0.53125,-0.79688 1=
.03125,-1.17188 0.51563,-0.39062 1.04688,-0.39062 0.35937,0 0.875,0.25 l -0=
.48438,1.09375 q -0.3125,-0.21875 -0.67187,-0.21875 -0.625,0 -1.28125,0.687=
5 -0.64063,0.6875 -1.01563,2.48437 l -0.57812,2.76563 z m 9.15712,-1.25 q -=
1.23438,1.40625 -2.54688,1.40625 -0.79687,0 -1.29687,-0.45313 -0.48438,-0.4=
6875 -0.48438,-1.125 0,-0.4375 0.21875,-1.5 l 0.84375,-3.98437 h 1.17188 l =
-0.92188,4.40625 q -0.10937,0.5625 -0.10937,0.85937 0,0.39063 0.23437,0.609=
38 0.23438,0.21875 0.70313,0.21875 0.48437,0 0.95312,-0.23438 0.48438,-0.23=
437 0.8125,-0.64062 0.34375,-0.42188 0.5625,-0.98438 0.14063,-0.35937 0.328=
13,-1.25 l 0.625,-2.98437 h 1.1875 l -1.45313,6.90625 h -1.07812 z m 7.4749=
7,-1.26563 1.17188,0.125 q -0.4375,1.29688 -1.26563,1.92188 -0.8125,0.625 -=
1.84375,0.625 -1.14062,0 -1.84375,-0.71875 -0.6875,-0.73438 -0.6875,-2.0468=
8 0,-1.125 0.4375,-2.21875 0.45313,-1.09375 1.28125,-1.65625 0.84375,-0.578=
12 1.92188,-0.57812 1.10937,0 1.76562,0.625 0.65625,0.625 0.65625,1.65625 l=
 -1.15625,0.0781 q -0.0156,-0.65625 -0.39062,-1.01562 -0.375,-0.375 -0.9843=
8,-0.375 -0.70312,0 -1.23437,0.45312 -0.51563,0.4375 -0.8125,1.35938 -0.296=
88,0.90625 -0.29688,1.75 0,0.89062 0.39063,1.34375 0.39062,0.4375 0.96875,0=
.4375 0.5625,0 1.07812,-0.4375 0.53125,-0.4375 0.84375,-1.32813 z m 4.64844=
,1.5625 -0.20313,0.95313 q -0.42187,0.10937 -0.8125,0.10937 -0.70312,0 -1.1=
25,-0.34375 -0.3125,-0.25 -0.3125,-0.70312 0,-0.23438 0.17188,-1.04688 l 0.=
82812,-4.01562 h -0.92187 l 0.1875,-0.90625 h 0.9375 l 0.34375,-1.70313 1.3=
5937,-0.8125 -0.53125,2.51563 h 1.15625 l -0.1875,0.90625 h -1.15625 l -0.7=
9687,3.8125 q -0.15625,0.73437 -0.15625,0.875 0,0.21875 0.10937,0.32812 0.1=
25,0.10938 0.40625,0.10938 0.39063,0 0.70313,-0.0781 z m 4.64035,0.95313 1.=
45312,-6.90625 h 1.03125 l -0.28125,1.40625 q 0.53125,-0.79688 1.03125,-1.1=
7188 0.51563,-0.39062 1.04688,-0.39062 0.35937,0 0.875,0.25 l -0.48438,1.09=
375 q -0.3125,-0.21875 -0.67187,-0.21875 -0.625,0 -1.28125,0.6875 -0.64063,=
0.6875 -1.01563,2.48437 l -0.57812,2.76563 z m 7.20399,-0.95313 -0.20312,0.=
95313 q -0.42188,0.10937 -0.8125,0.10937 -0.70313,0 -1.125,-0.34375 -0.3125=
,-0.25 -0.3125,-0.70312 0,-0.23438 0.17187,-1.04688 l 0.82813,-4.01562 h -0=
.92188 l 0.1875,-0.90625 h 0.9375 l 0.34375,-1.70313 1.35938,-0.8125 -0.531=
25,2.51563 h 1.15625 l -0.1875,0.90625 h -1.15625 l -0.79688,3.8125 q -0.15=
625,0.73437 -0.15625,0.875 0,0.21875 0.10938,0.32812 0.125,0.10938 0.40625,=
0.10938 0.39062,0 0.70312,-0.0781 z m 6.01549,-1.39062 1.15625,0.10937 q -0=
.25,0.85938 -1.14062,1.625 -0.89063,0.76563 -2.125,0.76563 -0.76563,0 -1.40=
625,-0.34375 -0.64063,-0.35938 -0.98438,-1.03125 -0.32812,-0.6875 -0.32812,=
-1.54688 0,-1.14062 0.51562,-2.20312 0.53125,-1.0625 1.35938,-1.57813 0.843=
75,-0.51562 1.8125,-0.51562 1.23437,0 1.96875,0.76562 0.75,0.76563 0.75,2.0=
9375 0,0.5 -0.0937,1.04688 h -5.09375 q -0.0312,0.1875 -0.0312,0.35937 0,0.=
96875 0.4375,1.48438 0.45312,0.5 1.10937,0.5 0.59375,0 1.17188,-0.39063 0.5=
9375,-0.39062 0.92187,-1.14062 z m -3.42187,-1.71875 h 3.875 q 0.0156,-0.18=
75 0.0156,-0.26563 0,-0.875 -0.45312,-1.34375 -0.4375,-0.48437 -1.125,-0.48=
437 -0.76563,0 -1.39063,0.53125 -0.60937,0.51562 -0.92187,1.5625 z m 4.4749=
7,6.71875 v -0.85938 h 7.76563 v 0.85938 z m 8.69373,-2.65625 1.45312,-6.90=
625 h 1.0625 l -0.25,1.20312 q 0.6875,-0.71875 1.29688,-1.03125 0.60937,-0.=
32812 1.23437,-0.32812 0.84375,0 1.3125,0.45312 0.48438,0.45313 0.48438,1.2=
1875 0,0.375 -0.17188,1.20313 l -0.875,4.1875 h -1.17187 l 0.92187,-4.375 q=
 0.125,-0.64063 0.125,-0.95313 0,-0.34375 -0.23437,-0.54687 -0.23438,-0.218=
75 -0.6875,-0.21875 -0.90625,0 -1.60938,0.65625 -0.70312,0.64062 -1.03125,2=
.21875 l -0.67187,3.21875 z m 7.63122,-2.625 q 0,-2.01563 1.1875,-3.34375 0=
.98438,-1.09375 2.57813,-1.09375 1.25,0 2.01562,0.78125 0.76563,0.78125 0.7=
6563,2.10937 0,1.1875 -0.48438,2.21875 -0.48437,1.01563 -1.375,1.5625 -0.89=
062,0.54688 -1.875,0.54688 -0.79687,0 -1.46875,-0.34375 -0.65625,-0.34375 -=
1,-0.96875 -0.34375,-0.64063 -0.34375,-1.46875 z m 1.17188,-0.10938 q 0,0.9=
6875 0.46875,1.48438 0.46875,0.5 1.1875,0.5 0.375,0 0.75,-0.15625 0.375,-0.=
15625 0.6875,-0.46875 0.32812,-0.3125 0.54687,-0.70313 0.21875,-0.40625 0.3=
5938,-0.875 0.20312,-0.64062 0.20312,-1.23437 0,-0.9375 -0.46875,-1.45313 -=
0.46875,-0.51562 -1.1875,-0.51562 -0.5625,0 -1.01562,0.26562 -0.45313,0.265=
63 -0.82813,0.78125 -0.35937,0.5 -0.53125,1.17188 -0.17187,0.67187 -0.17187=
,1.20312 z m 10.69372,1.73438 q -1.01562,1.15625 -2.10937,1.15625 -0.98438,=
0 -1.64063,-0.71875 -0.65625,-0.73438 -0.65625,-2.10938 0,-1.26562 0.51563,=
-2.3125 0.51562,-1.04687 1.29687,-1.5625 0.78125,-0.51562 1.5625,-0.51562 1=
.28125,0 1.9375,1.23437 l 0.78125,-3.71875 h 1.17188 l -1.98438,9.54688 h -=
1.09375 z m -3.23437,-1.89063 q 0,0.71875 0.14062,1.14063 0.14063,0.40625 0=
.48438,0.6875 0.34375,0.28125 0.82812,0.28125 0.79688,0 1.45313,-0.84375 0.=
875,-1.10938 0.875,-2.73438 0,-0.8125 -0.4375,-1.26562 -0.42188,-0.46875 -1=
.07813,-0.46875 -0.42187,0 -0.76562,0.1875 -0.34375,0.1875 -0.6875,0.64062 =
-0.34375,0.45313 -0.57813,1.15625 -0.23437,0.6875 -0.23437,1.21875 z m 11.0=
531,0.54688 1.15625,0.10937 q -0.25,0.85938 -1.14062,1.625 -0.89063,0.76563=
 -2.125,0.76563 -0.76563,0 -1.40625,-0.34375 -0.64063,-0.35938 -0.98438,-1.=
03125 -0.32812,-0.6875 -0.32812,-1.54688 0,-1.14062 0.51562,-2.20312 0.5312=
5,-1.0625 1.35938,-1.57813 0.84375,-0.51562 1.8125,-0.51562 1.23437,0 1.968=
75,0.76562 0.75,0.76563 0.75,2.09375 0,0.5 -0.0937,1.04688 h -5.09375 q -0.=
0312,0.1875 -0.0312,0.35937 0,0.96875 0.4375,1.48438 0.45312,0.5 1.10937,0.=
5 0.59375,0 1.17188,-0.39063 0.59375,-0.39062 0.92187,-1.14062 z m -3.42187=
,-1.71875 h 3.875 q 0.0156,-0.1875 0.0156,-0.26563 0,-0.875 -0.45312,-1.343=
75 -0.4375,-0.48437 -1.125,-0.48437 -0.76563,0 -1.39063,0.53125 -0.60937,0.=
51562 -0.92187,1.5625 z"
-       fill-rule=3D"nonzero"
-       id=3D"path272" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 186.84224,390.99465 v -9.54688 h 1.29687 l 5.01563,7.5 v -7.=
5 h 1.20312 v 9.54688 h -1.29687 l -5.01563,-7.5 v 7.5 z m 9.04703,-3.45313=
 q 0,-1.92187 1.07812,-2.84375 0.89063,-0.76562 2.17188,-0.76562 1.42187,0 =
2.32812,0.9375 0.90625,0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -=
0.39062,0.76563 -1.15625,1.1875 -0.76562,0.42188 -1.67187,0.42188 -1.45313,=
0 -2.35938,-0.92188 -0.89062,-0.9375 -0.89062,-2.6875 z m 1.20312,0 q 0,1.3=
2813 0.57813,1.98438 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45312,-0.656=
25 0.57813,-0.67188 0.57813,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57813,-=
0.65625 -1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57813,0.65625 -0.5781=
3,1.98437 z m 11.13123,3.45313 v -0.875 q -0.65625,1.03125 -1.9375,1.03125 =
-0.8125,0 -1.51563,-0.45313 -0.6875,-0.45312 -1.07812,-1.26562 -0.375,-0.82=
813 -0.375,-1.89063 0,-1.03125 0.34375,-1.875 0.34375,-0.84375 1.03125,-1.2=
8125 0.70312,-0.45312 1.54687,-0.45312 0.625,0 1.10938,0.26562 0.5,0.25 0.7=
9687,0.67188 v -3.42188 h 1.17188 v 9.54688 z m -3.70313,-3.45313 q 0,1.328=
13 0.5625,1.98438 0.5625,0.65625 1.32813,0.65625 0.76562,0 1.29687,-0.625 0=
.53125,-0.625 0.53125,-1.90625 0,-1.42188 -0.54687,-2.07813 -0.54688,-0.671=
87 -1.34375,-0.67187 -0.78125,0 -1.3125,0.64062 -0.51563,0.625 -0.51563,2 z=
 m 11.3656,1.23438 1.20313,0.14062 q -0.28125,1.0625 -1.0625,1.65625 -0.765=
63,0.57813 -1.96875,0.57813 -1.51563,0 -2.40625,-0.9375 -0.89063,-0.9375 -0=
.89063,-2.60938 0,-1.75 0.89063,-2.70312 0.90625,-0.96875 2.34375,-0.96875 =
1.39062,0 2.26562,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5=
.15625 q 0.0625,1.14062 0.64063,1.75 0.57812,0.59375 1.4375,0.59375 0.65625=
,0 1.10937,-0.32813 0.45313,-0.34375 0.71875,-1.07812 z m -3.84375,-1.90625=
 h 3.85938 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.45313,-0.=
6875 -0.8125,0 -1.35937,0.54688 -0.54688,0.53125 -0.60938,1.4375 z m 10.365=
47,4.125 v -9.54688 h 1.29687 l 5.01563,7.5 v -7.5 h 1.20312 v 9.54688 h -1=
.29687 l -5.01563,-7.5 v 7.5 z"
-       fill-rule=3D"nonzero"
-       id=3D"path274" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 164.51677,404.63527 1.1875,-0.0781 q 0,0.51563 0.15625,0.875=
 0.15625,0.35938 0.57812,0.59375 0.42188,0.21875 0.96875,0.21875 0.78125,0 =
1.17188,-0.3125 0.39062,-0.3125 0.39062,-0.73437 0,-0.3125 -0.23437,-0.5781=
3 -0.23438,-0.28125 -1.17188,-0.67187 -0.9375,-0.40625 -1.1875,-0.57813 -0.=
4375,-0.26562 -0.67187,-0.625 -0.21875,-0.35937 -0.21875,-0.82812 0,-0.8125=
 0.65625,-1.39063 0.65625,-0.59375 1.82812,-0.59375 1.29688,0 1.96875,0.609=
38 0.6875,0.59375 0.71875,1.57812 l -1.15625,0.0781 q -0.0312,-0.625 -0.453=
12,-0.98438 -0.40625,-0.375 -1.17188,-0.375 -0.60937,0 -0.95312,0.28125 -0.=
32813,0.28125 -0.32813,0.60938 0,0.3125 0.29688,0.5625 0.1875,0.17187 1,0.5=
3125 1.35937,0.57812 1.70312,0.92187 0.5625,0.53125 0.5625,1.3125 0,0.51563=
 -0.3125,1.01563 -0.3125,0.48437 -0.96875,0.78125 -0.64062,0.29687 -1.51562=
,0.29687 -1.20313,0 -2.04688,-0.59375 -0.84375,-0.59375 -0.79687,-1.92187 z=
 m 9.32031,1.40625 -0.20312,0.95312 q -0.42188,0.10938 -0.8125,0.10938 -0.7=
0313,0 -1.125,-0.34375 -0.3125,-0.25 -0.3125,-0.70313 0,-0.23437 0.17187,-1=
.04687 l 0.82813,-4.01563 h -0.92188 l 0.1875,-0.90625 h 0.9375 l 0.34375,-=
1.70312 1.35938,-0.8125 -0.53125,2.51562 h 1.15625 l -0.1875,0.90625 h -1.1=
5625 l -0.79688,3.8125 q -0.15625,0.73438 -0.15625,0.875 0,0.21875 0.10938,=
0.32813 0.125,0.10937 0.40625,0.10937 0.39062,0 0.70312,-0.0781 z m 0.93737=
,0.95312 1.45312,-6.90625 h 1.03125 l -0.28125,1.40625 q 0.53125,-0.79687 1=
.03125,-1.17187 0.51563,-0.39063 1.04688,-0.39063 0.35937,0 0.875,0.25 l -0=
.48438,1.09375 q -0.3125,-0.21875 -0.67187,-0.21875 -0.625,0 -1.28125,0.687=
5 -0.64063,0.6875 -1.01563,2.48438 l -0.57812,2.76562 z m 9.15712,-1.25 q -=
1.23438,1.40625 -2.54688,1.40625 -0.79687,0 -1.29687,-0.45312 -0.48438,-0.4=
6875 -0.48438,-1.125 0,-0.4375 0.21875,-1.5 l 0.84375,-3.98438 h 1.17188 l =
-0.92188,4.40625 q -0.10937,0.5625 -0.10937,0.85938 0,0.39062 0.23437,0.609=
37 0.23438,0.21875 0.70313,0.21875 0.48437,0 0.95312,-0.23437 0.48438,-0.23=
438 0.8125,-0.64063 0.34375,-0.42187 0.5625,-0.98437 0.14063,-0.35938 0.328=
13,-1.25 l 0.625,-2.98438 h 1.1875 l -1.45313,6.90625 h -1.07812 z m 7.4749=
7,-1.26562 1.17188,0.125 q -0.4375,1.29687 -1.26563,1.92187 -0.8125,0.625 -=
1.84375,0.625 -1.14062,0 -1.84375,-0.71875 -0.6875,-0.73437 -0.6875,-2.0468=
7 0,-1.125 0.4375,-2.21875 0.45313,-1.09375 1.28125,-1.65625 0.84375,-0.578=
13 1.92188,-0.57813 1.10937,0 1.76562,0.625 0.65625,0.625 0.65625,1.65625 l=
 -1.15625,0.0781 q -0.0156,-0.65625 -0.39062,-1.01563 -0.375,-0.375 -0.9843=
8,-0.375 -0.70312,0 -1.23437,0.45313 -0.51563,0.4375 -0.8125,1.35937 -0.296=
88,0.90625 -0.29688,1.75 0,0.89063 0.39063,1.34375 0.39062,0.4375 0.96875,0=
.4375 0.5625,0 1.07812,-0.4375 0.53125,-0.4375 0.84375,-1.32812 z m 4.64844=
,1.5625 -0.20313,0.95312 q -0.42187,0.10938 -0.8125,0.10938 -0.70312,0 -1.1=
25,-0.34375 -0.3125,-0.25 -0.3125,-0.70313 0,-0.23437 0.17188,-1.04687 l 0.=
82812,-4.01563 h -0.92187 l 0.1875,-0.90625 h 0.9375 l 0.34375,-1.70312 1.3=
5937,-0.8125 -0.53125,2.51562 h 1.15625 l -0.1875,0.90625 h -1.15625 l -0.7=
9687,3.8125 q -0.15625,0.73438 -0.15625,0.875 0,0.21875 0.10937,0.32813 0.1=
25,0.10937 0.40625,0.10937 0.39063,0 0.70313,-0.0781 z m 4.64035,0.95312 1.=
45312,-6.90625 h 1.03125 l -0.28125,1.40625 q 0.53125,-0.79687 1.03125,-1.1=
7187 0.51563,-0.39063 1.04688,-0.39063 0.35937,0 0.875,0.25 l -0.48438,1.09=
375 q -0.3125,-0.21875 -0.67187,-0.21875 -0.625,0 -1.28125,0.6875 -0.64063,=
0.6875 -1.01563,2.48438 l -0.57812,2.76562 z m 7.20399,-0.95312 -0.20312,0.=
95312 q -0.42188,0.10938 -0.8125,0.10938 -0.70313,0 -1.125,-0.34375 -0.3125=
,-0.25 -0.3125,-0.70313 0,-0.23437 0.17187,-1.04687 l 0.82813,-4.01563 h -0=
.92188 l 0.1875,-0.90625 h 0.9375 l 0.34375,-1.70312 1.35938,-0.8125 -0.531=
25,2.51562 h 1.15625 l -0.1875,0.90625 h -1.15625 l -0.79688,3.8125 q -0.15=
625,0.73438 -0.15625,0.875 0,0.21875 0.10938,0.32813 0.125,0.10937 0.40625,=
0.10937 0.39062,0 0.70312,-0.0781 z m 6.01549,-1.39063 1.15625,0.10938 q -0=
.25,0.85937 -1.14062,1.625 -0.89063,0.76562 -2.125,0.76562 -0.76563,0 -1.40=
625,-0.34375 -0.64063,-0.35937 -0.98438,-1.03125 -0.32812,-0.6875 -0.32812,=
-1.54687 0,-1.14063 0.51562,-2.20313 0.53125,-1.0625 1.35938,-1.57812 0.843=
75,-0.51563 1.8125,-0.51563 1.23437,0 1.96875,0.76563 0.75,0.76562 0.75,2.0=
9375 0,0.5 -0.0937,1.04687 h -5.09375 q -0.0312,0.1875 -0.0312,0.35938 0,0.=
96875 0.4375,1.48437 0.45312,0.5 1.10937,0.5 0.59375,0 1.17188,-0.39062 0.5=
9375,-0.39063 0.92187,-1.14063 z m -3.42187,-1.71875 h 3.875 q 0.0156,-0.18=
75 0.0156,-0.26562 0,-0.875 -0.45312,-1.34375 -0.4375,-0.48438 -1.125,-0.48=
438 -0.76563,0 -1.39063,0.53125 -0.60937,0.51563 -0.92187,1.5625 z m 4.4749=
7,6.71875 v -0.85937 h 7.76563 v 0.85937 z m 8.69373,-2.65625 1.45312,-6.90=
625 h 1.0625 l -0.25,1.20313 q 0.6875,-0.71875 1.29688,-1.03125 0.60937,-0.=
32813 1.23437,-0.32813 0.84375,0 1.3125,0.45313 0.48438,0.45312 0.48438,1.2=
1875 0,0.375 -0.17188,1.20312 l -0.875,4.1875 h -1.17187 l 0.92187,-4.375 q=
 0.125,-0.64062 0.125,-0.95312 0,-0.34375 -0.23437,-0.54688 -0.23438,-0.218=
75 -0.6875,-0.21875 -0.90625,0 -1.60938,0.65625 -0.70312,0.64063 -1.03125,2=
.21875 l -0.67187,3.21875 z m 7.63122,-2.625 q 0,-2.01562 1.1875,-3.34375 0=
.98438,-1.09375 2.57813,-1.09375 1.25,0 2.01562,0.78125 0.76563,0.78125 0.7=
6563,2.10938 0,1.1875 -0.48438,2.21875 -0.48437,1.01562 -1.375,1.5625 -0.89=
062,0.54687 -1.875,0.54687 -0.79687,0 -1.46875,-0.34375 -0.65625,-0.34375 -=
1,-0.96875 -0.34375,-0.64062 -0.34375,-1.46875 z m 1.17188,-0.10937 q 0,0.9=
6875 0.46875,1.48437 0.46875,0.5 1.1875,0.5 0.375,0 0.75,-0.15625 0.375,-0.=
15625 0.6875,-0.46875 0.32812,-0.3125 0.54687,-0.70312 0.21875,-0.40625 0.3=
5938,-0.875 0.20312,-0.64063 0.20312,-1.23438 0,-0.9375 -0.46875,-1.45312 -=
0.46875,-0.51563 -1.1875,-0.51563 -0.5625,0 -1.01562,0.26563 -0.45313,0.265=
62 -0.82813,0.78125 -0.35937,0.5 -0.53125,1.17187 -0.17187,0.67188 -0.17187=
,1.20313 z m 10.69372,1.73437 q -1.01562,1.15625 -2.10937,1.15625 -0.98438,=
0 -1.64063,-0.71875 -0.65625,-0.73437 -0.65625,-2.10937 0,-1.26563 0.51563,=
-2.3125 0.51562,-1.04688 1.29687,-1.5625 0.78125,-0.51563 1.5625,-0.51563 1=
.28125,0 1.9375,1.23438 l 0.78125,-3.71875 h 1.17188 l -1.98438,9.54687 h -=
1.09375 z m -3.23437,-1.89062 q 0,0.71875 0.14062,1.14062 0.14063,0.40625 0=
.48438,0.6875 0.34375,0.28125 0.82812,0.28125 0.79688,0 1.45313,-0.84375 0.=
875,-1.10937 0.875,-2.73437 0,-0.8125 -0.4375,-1.26563 -0.42188,-0.46875 -1=
.07813,-0.46875 -0.42187,0 -0.76562,0.1875 -0.34375,0.1875 -0.6875,0.64063 =
-0.34375,0.45312 -0.57813,1.15625 -0.23437,0.6875 -0.23437,1.21875 z m 11.0=
531,0.54687 1.15625,0.10938 q -0.25,0.85937 -1.14062,1.625 -0.89063,0.76562=
 -2.125,0.76562 -0.76563,0 -1.40625,-0.34375 -0.64063,-0.35937 -0.98438,-1.=
03125 -0.32812,-0.6875 -0.32812,-1.54687 0,-1.14063 0.51562,-2.20313 0.5312=
5,-1.0625 1.35938,-1.57812 0.84375,-0.51563 1.8125,-0.51563 1.23437,0 1.968=
75,0.76563 0.75,0.76562 0.75,2.09375 0,0.5 -0.0937,1.04687 h -5.09375 q -0.=
0312,0.1875 -0.0312,0.35938 0,0.96875 0.4375,1.48437 0.45312,0.5 1.10937,0.=
5 0.59375,0 1.17188,-0.39062 0.59375,-0.39063 0.92187,-1.14063 z m -3.42187=
,-1.71875 h 3.875 q 0.0156,-0.1875 0.0156,-0.26562 0,-0.875 -0.45312,-1.343=
75 -0.4375,-0.48438 -1.125,-0.48438 -0.76563,0 -1.39063,0.53125 -0.60937,0.=
51563 -0.92187,1.5625 z"
-       fill-rule=3D"nonzero"
-       id=3D"path276" />
-    <path
-       fill=3D"#000000"
-       fill-opacity=3D"0"
-       d=3D"M 93.256612,37.783637 H 323.58733 v 27.46456 H 93.256612 Z"
-       fill-rule=3D"evenodd"
-       id=3D"path278" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 115.56788,59.583637 v -6.90625 h 1.0625 v 1.04687 q 0.40625,=
-0.73437 0.73438,-0.96875 0.34375,-0.23437 0.76562,-0.23437 0.59375,0 1.203=
13,0.375 l -0.40625,1.07812 q -0.4375,-0.25 -0.85938,-0.25 -0.39062,0 -0.70=
312,0.23438 -0.29688,0.23437 -0.42188,0.64062 -0.20312,0.625 -0.20312,1.359=
38 v 3.625 z m 7.01649,-1.04688 0.17188,1.03125 q -0.5,0.10938 -0.89063,0.1=
0938 -0.64062,0 -1,-0.20313 -0.34375,-0.20312 -0.48437,-0.53125 -0.14063,-0=
.32812 -0.14063,-1.39062 v -3.96875 h -0.85937 v -0.90625 h 0.85937 v -1.71=
875 l 1.17188,-0.70313 v 2.42188 h 1.17187 v 0.90625 h -1.17187 v 4.04687 q=
 0,0.5 0.0469,0.64063 0.0625,0.14062 0.20313,0.23437 0.14062,0.0781 0.40625=
,0.0781 0.20312,0 0.51562,-0.0469 z m 5.87487,-1.17187 1.20311,0.14062 q -0=
.28125,1.0625 -1.06249,1.65625 -0.76562,0.57813 -1.96875,0.57813 -1.51562,0=
 -2.40625,-0.9375 -0.89062,-0.9375 -0.89062,-2.60938 0,-1.75 0.89062,-2.703=
12 0.90625,-0.96875 2.34375,-0.96875 1.39063,0 2.26563,0.9375 0.87499,0.937=
5 0.87499,2.65625 0,0.10937 0,0.3125 h -5.15624 q 0.0625,1.14062 0.64062,1.=
75 0.57813,0.59375 1.4375,0.59375 0.65625,0 1.10938,-0.32813 0.45312,-0.343=
75 0.71875,-1.07812 z m -3.84375,-1.90625 h 3.85937 q -0.0781,-0.85938 -0.4=
375,-1.29688 -0.5625,-0.6875 -1.45312,-0.6875 -0.8125,0 -1.35938,0.54688 -0=
.54687,0.53125 -0.60937,1.4375 z m 5.44372,6.78125 v -0.85938 h 7.76562 v 0=
.85938 z m 8.27185,-2.07813 1.14062,0.15625 q 0.0781,0.53125 0.40625,0.7812=
5 0.4375,0.3125 1.1875,0.3125 0.8125,0 1.25,-0.32812 0.45313,-0.3125 0.6093=
8,-0.90625 0.0937,-0.35938 0.0781,-1.5 -0.76562,0.90625 -1.90625,0.90625 -1=
.4375,0 -2.21875,-1.03125 -0.78125,-1.03125 -0.78125,-2.46875 0,-0.98438 0.=
35938,-1.8125 0.35937,-0.84375 1.03125,-1.29688 0.6875,-0.45312 1.60937,-0.=
45312 1.21875,0 2.01563,0.98437 v -0.82812 h 1.07812 v 5.96875 q 0,1.60937 =
-0.32812,2.28125 -0.32813,0.6875 -1.04688,1.07812 -0.70312,0.39063 -1.75,0.=
39063 -1.23437,0 -2,-0.5625 -0.75,-0.5625 -0.73437,-1.67188 z m 0.98437,-4.=
15625 q 0,1.35938 0.53125,1.98438 0.54688,0.625 1.35938,0.625 0.79687,0 1.3=
4375,-0.625 0.54687,-0.625 0.54687,-1.95313 0,-1.26562 -0.5625,-1.90625 -0.=
5625,-0.64062 -1.35937,-0.64062 -0.76563,0 -1.3125,0.64062 -0.54688,0.625 -=
0.54688,1.875 z m 6.63123,3.57813 v -6.90625 h 1.0625 v 1.04687 q 0.40625,-=
0.73437 0.73437,-0.96875 0.34375,-0.23437 0.76563,-0.23437 0.59375,0 1.2031=
2,0.375 l -0.40625,1.07812 q -0.4375,-0.25 -0.85937,-0.25 -0.39063,0 -0.703=
13,0.23438 -0.29687,0.23437 -0.42187,0.64062 -0.20313,0.625 -0.20313,1.3593=
8 v 3.625 z m 8.96962,-0.85938 q -0.65625,0.5625 -1.26563,0.79688 -0.59375,=
0.21875 -1.28125,0.21875 -1.14062,0 -1.75,-0.54688 -0.60937,-0.5625 -0.6093=
7,-1.4375 0,-0.5 0.21875,-0.92187 0.23437,-0.42188 0.60937,-0.67188 0.375,-=
0.25 0.84375,-0.39062 0.34375,-0.0781 1.04688,-0.17188 1.42187,-0.17187 2.0=
9375,-0.40625 0,-0.23437 0,-0.29687 0,-0.71875 -0.32813,-1.01563 -0.45312,-=
0.39062 -1.34375,-0.39062 -0.8125,0 -1.21875,0.29687 -0.39062,0.28125 -0.57=
812,1.01563 l -1.14063,-0.15625 q 0.15625,-0.73438 0.51563,-1.1875 0.35937,=
-0.45313 1.03125,-0.6875 0.67187,-0.25 1.5625,-0.25 0.89062,0 1.4375,0.2031=
2 0.5625,0.20313 0.8125,0.53125 0.26562,0.3125 0.375,0.79688 0.0469,0.29687=
 0.0469,1.07812 v 1.5625 q 0,1.625 0.0781,2.0625 0.0781,0.4375 0.29687,0.82=
813 h -1.21875 q -0.1875,-0.35938 -0.23437,-0.85938 z m -0.0937,-2.60937 q =
-0.64063,0.26562 -1.92188,0.4375 -0.71875,0.10937 -1.01562,0.25 -0.29688,0.=
125 -0.46875,0.375 -0.15625,0.25 -0.15625,0.54687 0,0.46875 0.34375,0.78125=
 0.35937,0.3125 1.04687,0.3125 0.67188,0 1.20313,-0.29687 0.53125,-0.29688 =
0.78125,-0.8125 0.1875,-0.39063 0.1875,-1.17188 z m 2.9906,6.125 v -9.5625 =
h 1.07812 v 0.89062 q 0.375,-0.53125 0.84375,-0.78125 0.48438,-0.26562 1.15=
625,-0.26562 0.875,0 1.54688,0.45312 0.6875,0.45313 1.03125,1.28125 0.34375=
,0.82813 0.34375,1.82813 0,1.04687 -0.375,1.90625 -0.375,0.84375 -1.10938,1=
.29687 -0.71875,0.45313 -1.53125,0.45313 -0.57812,0 -1.04687,-0.25 -0.46875=
,-0.25 -0.76563,-0.625 v 3.375 z m 1.0625,-6.07813 q 0,1.34375 0.53125,1.98=
438 0.54687,0.625 1.3125,0.625 0.78125,0 1.34375,-0.65625 0.5625,-0.65625 0=
.5625,-2.04688 0,-1.3125 -0.54688,-1.96875 -0.54687,-0.67187 -1.29687,-0.67=
187 -0.75,0 -1.32813,0.70312 -0.57812,0.70313 -0.57812,2.03125 z m 6.34997,=
3.42188 v -9.54688 h 1.17188 v 3.42188 q 0.82812,-0.9375 2.07812,-0.9375 0.=
76563,0 1.32813,0.29687 0.5625,0.29688 0.8125,0.84375 0.25,0.53125 0.25,1.5=
4688 v 4.375 h -1.17188 v -4.375 q 0,-0.89063 -0.39062,-1.28125 -0.375,-0.4=
0625 -1.07813,-0.40625 -0.51562,0 -0.98437,0.28125 -0.45313,0.26562 -0.6562=
5,0.73437 -0.1875,0.45313 -0.1875,1.26563 v 3.78125 z m 10.67797,-3.45313 q=
 0,-1.92187 1.07812,-2.84375 0.89063,-0.76562 2.17188,-0.76562 1.42187,0 2.=
32812,0.9375 0.90625,0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.=
39062,0.76563 -1.15625,1.1875 -0.76562,0.42188 -1.67187,0.42188 -1.45313,0 =
-2.35938,-0.92188 -0.89062,-0.9375 -0.89062,-2.6875 z m 1.20312,0 q 0,1.328=
13 0.57813,1.98438 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45312,-0.65625=
 0.57813,-0.67188 0.57813,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57813,-0.=
65625 -1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57813,0.65625 -0.57813,=
1.98437 z m 7.72498,3.45313 h -1.07813 v -9.54688 h 1.17188 v 3.40625 q 0.7=
3437,-0.92187 1.89062,-0.92187 0.64063,0 1.20313,0.26562 0.57812,0.25 0.937=
5,0.71875 0.375,0.45313 0.57812,1.10938 0.20313,0.65625 0.20313,1.40625 0,1=
.78125 -0.875,2.75 -0.875,0.96875 -2.10938,0.96875 -1.21875,0 -1.92187,-1.0=
1563 z m 0,-3.5 q 0,1.23437 0.32812,1.78125 0.5625,0.90625 1.5,0.90625 0.76=
563,0 1.32813,-0.65625 0.5625,-0.67188 0.5625,-2 0,-1.34375 -0.54688,-1.984=
38 -0.53125,-0.65625 -1.29687,-0.65625 -0.76563,0 -1.32813,0.67188 -0.54687=
,0.67187 -0.54687,1.9375 z m 6.33435,-4.6875 v -1.35938 h 1.17187 v 1.35938=
 z m -1.48438,10.875 0.21875,-1 q 0.35938,0.0937 0.54688,0.0937 0.35937,0 0=
.53125,-0.25 0.1875,-0.23438 0.1875,-1.1875 v -7.25 h 1.17187 v 7.28125 q 0=
,1.28125 -0.32812,1.78125 -0.4375,0.65625 -1.40625,0.65625 -0.48438,0 -0.92=
188,-0.125 z m 9.17984,-4.90625 1.20313,0.14062 q -0.28125,1.0625 -1.0625,1=
.65625 -0.76563,0.57813 -1.96875,0.57813 -1.51563,0 -2.40625,-0.9375 -0.890=
63,-0.9375 -0.89063,-2.60938 0,-1.75 0.89063,-2.70312 0.90625,-0.96875 2.34=
375,-0.96875 1.39062,0 2.26562,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 =
0,0.3125 h -5.15625 q 0.0625,1.14062 0.64063,1.75 0.57812,0.59375 1.4375,0.=
59375 0.65625,0 1.10937,-0.32813 0.45313,-0.34375 0.71875,-1.07812 z m -3.8=
4375,-1.90625 h 3.85938 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875=
 -1.45313,-0.6875 -0.8125,0 -1.35937,0.54688 -0.54688,0.53125 -0.60938,1.43=
75 z m 11.03748,1.59375 1.15625,0.15625 q -0.1875,1.1875 -0.96875,1.85937 -=
0.78125,0.67188 -1.92188,0.67188 -1.40625,0 -2.28125,-0.92188 -0.85937,-0.9=
375 -0.85937,-2.65625 0,-1.125 0.375,-1.96875 0.375,-0.84375 1.125,-1.25 0.=
76562,-0.42187 1.65625,-0.42187 1.125,0 1.84375,0.57812 0.71875,0.5625 0.92=
187,1.60938 l -1.14062,0.17187 q -0.17188,-0.70312 -0.59375,-1.04687 -0.406=
25,-0.35938 -0.98438,-0.35938 -0.89062,0 -1.45312,0.64063 -0.54688,0.64062 =
-0.54688,2 0,1.40625 0.53125,2.03125 0.54688,0.625 1.40625,0.625 0.6875,0 1=
.14063,-0.42188 0.46875,-0.42187 0.59375,-1.29687 z m 4.71094,1.48437 0.171=
87,1.03125 q -0.5,0.10938 -0.89062,0.10938 -0.64063,0 -1,-0.20313 -0.34375,=
-0.20312 -0.48438,-0.53125 -0.14062,-0.32812 -0.14062,-1.39062 v -3.96875 h=
 -0.85938 v -0.90625 h 0.85938 v -1.71875 l 1.17187,-0.70313 v 2.42188 h 1.=
17188 v 0.90625 h -1.17188 v 4.04687 q 0,0.5 0.0469,0.64063 0.0625,0.14062 =
0.20312,0.23437 0.14063,0.0781 0.40625,0.0781 0.20313,0 0.51563,-0.0469 z m=
 4.84347,1.04688 v -6.90625 h 1.04688 v 0.96875 q 0.32812,-0.51563 0.85937,=
-0.8125 0.54688,-0.3125 1.23438,-0.3125 0.78125,0 1.26562,0.3125 0.48438,0.=
3125 0.6875,0.89062 0.82813,-1.20312 2.14063,-1.20312 1.03125,0 1.57812,0.5=
7812 0.5625,0.5625 0.5625,1.73438 v 4.75 h -1.17187 v -4.35938 q 0,-0.70312=
 -0.125,-1 -0.10938,-0.3125 -0.40625,-0.5 -0.29688,-0.1875 -0.70313,-0.1875=
 -0.71875,0 -1.20312,0.48438 -0.48438,0.48437 -0.48438,1.54687 v 4.01563 h =
-1.17187 v -4.48438 q 0,-0.78125 -0.29688,-1.17187 -0.28125,-0.39063 -0.921=
87,-0.39063 -0.5,0 -0.92188,0.26563 -0.42187,0.25 -0.60937,0.75 -0.1875,0.5=
 -0.1875,1.45312 v 3.57813 z m 15.83681,-2.21875 1.20312,0.14062 q -0.28125=
,1.0625 -1.0625,1.65625 -0.76562,0.57813 -1.96875,0.57813 -1.51562,0 -2.406=
25,-0.9375 -0.89062,-0.9375 -0.89062,-2.60938 0,-1.75 0.89062,-2.70312 0.90=
625,-0.96875 2.34375,-0.96875 1.39063,0 2.26563,0.9375 0.875,0.9375 0.875,2=
.65625 0,0.10937 0,0.3125 h -5.15625 q 0.0625,1.14062 0.64062,1.75 0.57813,=
0.59375 1.4375,0.59375 0.65625,0 1.10938,-0.32813 0.45312,-0.34375 0.71875,=
-1.07812 z m -3.8438,-1.90625 h 3.85937 q -0.0781,-0.85938 -0.4375,-1.29688=
 -0.5625,-0.6875 -1.45312,-0.6875 -0.8125,0 -1.35938,0.54688 -0.54687,0.531=
25 -0.60937,1.4375 z m 6.52185,4.125 v -6.90625 h 1.04687 v 0.96875 q 0.328=
13,-0.51563 0.85938,-0.8125 0.54687,-0.3125 1.23437,-0.3125 0.78125,0 1.265=
63,0.3125 0.48437,0.3125 0.6875,0.89062 0.82812,-1.20312 2.14062,-1.20312 1=
.03125,0 1.57813,0.57812 0.5625,0.5625 0.5625,1.73438 v 4.75 h -1.17188 v -=
4.35938 q 0,-0.70312 -0.125,-1 -0.10937,-0.3125 -0.40625,-0.5 -0.29687,-0.1=
875 -0.70312,-0.1875 -0.71875,0 -1.20313,0.48438 -0.48437,0.48437 -0.48437,=
1.54687 v 4.01563 h -1.17188 v -4.48438 q 0,-0.78125 -0.29687,-1.17187 -0.2=
8125,-0.39063 -0.92188,-0.39063 -0.5,0 -0.92187,0.26563 -0.42188,0.25 -0.60=
938,0.75 -0.1875,0.5 -0.1875,1.45312 v 3.57813 z m 10.66493,-3.45313 q 0,-1=
.92187 1.07813,-2.84375 0.89062,-0.76562 2.17187,-0.76562 1.42188,0 2.32813=
,0.9375 0.90625,0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.39063=
,0.76563 -1.15625,1.1875 -0.76563,0.42188 -1.67188,0.42188 -1.45312,0 -2.35=
937,-0.92188 -0.89063,-0.9375 -0.89063,-2.6875 z m 1.20313,0 q 0,1.32813 0.=
57812,1.98438 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45313,-0.65625 0.57=
812,-0.67188 0.57812,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57812,-0.65625=
 -1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57812,0.65625 -0.57812,1.984=
37 z m 6.63122,3.45313 v -6.90625 h 1.0625 v 1.04687 q 0.40625,-0.73437 0.7=
3438,-0.96875 0.34375,-0.23437 0.76562,-0.23437 0.59375,0 1.20313,0.375 l -=
0.40625,1.07812 q -0.4375,-0.25 -0.85938,-0.25 -0.39062,0 -0.70312,0.23438 =
-0.29688,0.23437 -0.42188,0.64062 -0.20312,0.625 -0.20312,1.35938 v 3.625 z=
 m 4.40712,2.65625 -0.125,-1.09375 q 0.375,0.10937 0.65625,0.10937 0.39063,=
0 0.625,-0.14062 0.23438,-0.125 0.39063,-0.35938 0.10937,-0.17187 0.35937,-=
0.875 0.0312,-0.0937 0.10938,-0.28125 l -2.625,-6.92187 h 1.26562 l 1.4375,=
4 q 0.28125,0.76562 0.5,1.59375 0.20313,-0.79688 0.46875,-1.57813 l 1.48438=
,-4.01562 h 1.17187 l -2.625,7.01562 q -0.42187,1.14063 -0.65625,1.57813 -0=
.3125,0.57812 -0.71875,0.84375 -0.40625,0.28125 -0.96875,0.28125 -0.32812,0=
 -0.75,-0.15625 z m 10.39832,-2.65625 v -9.54688 h 1.17187 v 9.54688 z m 7.=
49234,-0.85938 q -0.65625,0.5625 -1.26563,0.79688 -0.59375,0.21875 -1.28125=
,0.21875 -1.14062,0 -1.75,-0.54688 -0.60937,-0.5625 -0.60937,-1.4375 0,-0.5=
 0.21875,-0.92187 0.23437,-0.42188 0.60937,-0.67188 0.375,-0.25 0.84375,-0.=
39062 0.34375,-0.0781 1.04688,-0.17188 1.42187,-0.17187 2.09375,-0.40625 0,=
-0.23437 0,-0.29687 0,-0.71875 -0.32813,-1.01563 -0.45312,-0.39062 -1.34375=
,-0.39062 -0.8125,0 -1.21875,0.29687 -0.39062,0.28125 -0.57812,1.01563 l -1=
.14063,-0.15625 q 0.15625,-0.73438 0.51563,-1.1875 0.35937,-0.45313 1.03125=
,-0.6875 0.67187,-0.25 1.5625,-0.25 0.89062,0 1.4375,0.20312 0.5625,0.20313=
 0.8125,0.53125 0.26562,0.3125 0.375,0.79688 0.0469,0.29687 0.0469,1.07812 =
v 1.5625 q 0,1.625 0.0781,2.0625 0.0781,0.4375 0.29687,0.82813 h -1.21875 q=
 -0.1875,-0.35938 -0.23437,-0.85938 z m -0.0937,-2.60937 q -0.64063,0.26562=
 -1.92188,0.4375 -0.71875,0.10937 -1.01562,0.25 -0.29688,0.125 -0.46875,0.3=
75 -0.15625,0.25 -0.15625,0.54687 0,0.46875 0.34375,0.78125 0.35937,0.3125 =
1.04687,0.3125 0.67188,0 1.20313,-0.29687 0.53125,-0.29688 0.78125,-0.8125 =
0.1875,-0.39063 0.1875,-1.17188 z m 2.94372,6.125 -0.125,-1.09375 q 0.375,0=
.10937 0.65625,0.10937 0.39063,0 0.625,-0.14062 0.23438,-0.125 0.39063,-0.3=
5938 0.10937,-0.17187 0.35937,-0.875 0.0312,-0.0937 0.10938,-0.28125 l -2.6=
25,-6.92187 h 1.26562 l 1.4375,4 q 0.28125,0.76562 0.5,1.59375 0.20313,-0.7=
9688 0.46875,-1.57813 l 1.48438,-4.01562 h 1.17187 l -2.625,7.01562 q -0.42=
187,1.14063 -0.65625,1.57813 -0.3125,0.57812 -0.71875,0.84375 -0.40625,0.28=
125 -0.96875,0.28125 -0.32812,0 -0.75,-0.15625 z m 6.27344,-6.10938 q 0,-1.=
92187 1.07812,-2.84375 0.89063,-0.76562 2.17188,-0.76562 1.42187,0 2.32812,=
0.9375 0.90625,0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.39062,=
0.76563 -1.15625,1.1875 -0.76562,0.42188 -1.67187,0.42188 -1.45313,0 -2.359=
38,-0.92188 -0.89062,-0.9375 -0.89062,-2.6875 z m 1.20312,0 q 0,1.32813 0.5=
7813,1.98438 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45312,-0.65625 0.578=
13,-0.67188 0.57813,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57813,-0.65625 =
-1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57813,0.65625 -0.57813,1.9843=
7 z m 11.17811,3.45313 v -1.01563 q -0.8125,1.17188 -2.1875,1.17188 -0.6093=
8,0 -1.14063,-0.23438 -0.53125,-0.23437 -0.79687,-0.57812 -0.25,-0.35938 -0=
.35938,-0.875 -0.0625,-0.34375 -0.0625,-1.09375 v -4.28125 h 1.17188 v 3.82=
812 q 0,0.92188 0.0625,1.23438 0.10937,0.46875 0.46875,0.73437 0.35937,0.25=
 0.89062,0.25 0.51563,0 0.98438,-0.26562 0.46875,-0.26563 0.65625,-0.73438 =
0.1875,-0.46875 0.1875,-1.34375 v -3.70312 h 1.17187 v 6.90625 z m 5.44372,=
-1.04688 0.17188,1.03125 q -0.5,0.10938 -0.89063,0.10938 -0.64062,0 -1,-0.2=
0313 -0.34375,-0.20312 -0.48437,-0.53125 -0.14063,-0.32812 -0.14063,-1.3906=
2 v -3.96875 h -0.85937 v -0.90625 h 0.85937 v -1.71875 l 1.17188,-0.70313 =
v 2.42188 H 301.87 v 0.90625 h -1.17187 v 4.04687 q 0,0.5 0.0469,0.64063 0.=
0625,0.14062 0.20313,0.23437 0.14062,0.0781 0.40625,0.0781 0.20312,0 0.5156=
2,-0.0469 z"
-       fill-rule=3D"nonzero"
-       id=3D"path280"
-       style=3D"fill:#c8ab37" />
-    <path
-       fill=3D"#000000"
-       fill-opacity=3D"0"
-       d=3D"m 141.69362,420.4057 c -7.18405,0 -13.00787,-0.97061 -13.00787=
,-2.16791 v -97.61697 c 0,-1.1973 -5.82383,-2.16788 -13.00788,-2.16788 v 0 =
c 7.18405,0 13.00788,-0.97061 13.00788,-2.16791 v -97.61696 0 c 0,-1.19729 =
5.82382,-2.16789 13.00787,-2.16789 z"
-       fill-rule=3D"evenodd"
-       id=3D"path282" />
-    <path
-       fill=3D"#000000"
-       fill-opacity=3D"0"
-       d=3D"m 141.69362,420.4057 c -7.18405,0 -13.00787,-0.97061 -13.00787=
,-2.16791 v -97.61697 c 0,-1.1973 -5.82383,-2.16788 -13.00788,-2.16788 v 0 =
c 7.18405,0 13.00788,-0.97061 13.00788,-2.16791 v -97.61696 0 c 0,-1.19729 =
5.82382,-2.16789 13.00787,-2.16789"
-       fill-rule=3D"evenodd"
-       id=3D"path284" />
-    <path
-       stroke=3D"#595959"
-       stroke-width=3D"1"
-       stroke-linejoin=3D"round"
-       stroke-linecap=3D"butt"
-       d=3D"m 141.69362,420.4057 c -7.18405,0 -13.00787,-0.97061 -13.00787=
,-2.16791 v -97.61697 c 0,-1.1973 -5.82383,-2.16788 -13.00788,-2.16788 v 0 =
c 7.18405,0 13.00788,-0.97061 13.00788,-2.16791 v -97.61696 0 c 0,-1.19729 =
5.82382,-2.16789 13.00787,-2.16789"
-       fill-rule=3D"evenodd"
-       id=3D"path286"
-       style=3D"fill:none" />
-    <path
-       fill=3D"#000000"
-       fill-opacity=3D"0"
-       d=3D"m 66.103062,278.3112 h 99.401568 v 27.46457 H 66.103062 Z"
-       fill-rule=3D"evenodd"
-       id=3D"path288" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 75.899942,298.8312 v -6.21875 h 0.9375 v 0.875 q 0.6875,-1.0=
1562 1.98437,-1.01562 0.5625,0 1.03125,0.20312 0.48438,0.20313 0.71875,0.53=
125 0.23438,0.32813 0.32813,0.76563 0.0469,0.29687 0.0469,1.03125 v 3.82812=
 h -1.04687 v -3.78125 q 0,-0.65625 -0.125,-0.96875 -0.125,-0.3125 -0.4375,=
-0.5 -0.3125,-0.20312 -0.73438,-0.20312 -0.67187,0 -1.17187,0.4375 -0.48438=
,0.42187 -0.48438,1.60937 v 3.40625 z m 7.64258,0 h -0.98438 v -8.59375 h 1=
.0625 v 3.0625 q 0.67188,-0.82812 1.70313,-0.82812 0.57812,0 1.07812,0.2343=
7 0.51563,0.21875 0.84375,0.64063 0.34375,0.42187 0.53125,1.01562 0.1875,0.=
59375 0.1875,1.26563 0,1.59375 -0.79687,2.46875 -0.79688,0.875 -1.89063,0.8=
75 -1.10937,0 -1.73437,-0.92188 z m -0.0156,-3.15625 q 0,1.10938 0.3125,1.6=
0938 0.5,0.8125 1.34375,0.8125 0.6875,0 1.1875,-0.59375 0.51562,-0.59375 0.=
51562,-1.79688 0,-1.21875 -0.48437,-1.79687 -0.48438,-0.57813 -1.17188,-0.5=
7813 -0.6875,0 -1.20312,0.60938 -0.5,0.59375 -0.5,1.73437 z m 4.73633,5.546=
88 v -0.76563 h 7 v 0.76563 z m 7.6582,-2.39063 v -6.21875 h 0.9375 v 0.875=
 q 0.6875,-1.01562 1.98437,-1.01562 0.5625,0 1.03125,0.20312 0.484378,0.203=
13 0.718748,0.53125 0.23438,0.32813 0.32813,0.76563 0.0469,0.29687 0.0469,1=
.03125 v 3.82812 h -1.046878 v -3.78125 q 0,-0.65625 -0.125,-0.96875 -0.125=
,-0.3125 -0.4375,-0.5 -0.3125,-0.20312 -0.73437,-0.20312 -0.67188,0 -1.1718=
8,0.4375 -0.48437,0.42187 -0.48437,1.60937 v 3.40625 z m 6.283208,-3.10937 =
q 0,-1.73438 0.95312,-2.5625 0.79688,-0.6875 1.95313,-0.6875 1.28125,0 2.09=
375,0.84375 0.82812,0.82812 0.82812,2.3125 0,1.20312 -0.35937,1.89062 -0.35=
938,0.6875 -1.0625,1.07813 -0.6875,0.375 -1.5,0.375 -1.29688,0 -2.10938,-0.=
82813 -0.79687,-0.84375 -0.79687,-2.42187 z m 1.07812,0 q 0,1.1875 0.51563,=
1.78125 0.53125,0.59375 1.3125,0.59375 0.79687,0 1.3125,-0.59375 0.51562,-0=
.59375 0.51562,-1.8125 0,-1.15625 -0.53125,-1.75 -0.51562,-0.59375 -1.29687=
,-0.59375 -0.78125,0 -1.3125,0.59375 -0.51563,0.57812 -0.51563,1.78125 z m =
10.01758,3.10937 v -0.78125 q -0.59375,0.92188 -1.73437,0.92188 -0.75,0 -1.=
375,-0.40625 -0.625,-0.42188 -0.96875,-1.15625 -0.34375,-0.73438 -0.34375,-=
1.6875 0,-0.92188 0.3125,-1.6875 0.3125,-0.76563 0.9375,-1.15625 0.625,-0.4=
0625 1.39062,-0.40625 0.5625,0 1,0.23437 0.4375,0.23438 0.71875,0.60938 v -=
3.07813 h 1.04688 v 8.59375 z m -3.32812,-3.10937 q 0,1.20312 0.5,1.79687 0=
.5,0.57813 1.1875,0.57813 0.6875,0 1.17187,-0.5625 0.48438,-0.5625 0.48438,=
-1.71875 0,-1.28125 -0.5,-1.875 -0.48438,-0.59375 -1.20313,-0.59375 -0.7031=
2,0 -1.17187,0.57812 -0.46875,0.5625 -0.46875,1.79688 z m 10.2207,1.10937 1=
.09375,0.125 q -0.25,0.95313 -0.95313,1.48438 -0.70312,0.53125 -1.78125,0.5=
3125 -1.35937,0 -2.17187,-0.84375 -0.79688,-0.84375 -0.79688,-2.35938 0,-1.=
5625 0.8125,-2.42187 0.8125,-0.875 2.09375,-0.875 1.25,0 2.03125,0.84375 0.=
79688,0.84375 0.79688,2.39062 0,0.0937 0,0.28125 h -4.64063 q 0.0625,1.0312=
5 0.57813,1.57813 0.51562,0.53125 1.29687,0.53125 0.57813,0 0.98438,-0.2968=
8 0.42187,-0.3125 0.65625,-0.96875 z m -3.45313,-1.70312 h 3.46875 q -0.062=
5,-0.79688 -0.39062,-1.1875 -0.51563,-0.60938 -1.3125,-0.60938 -0.73438,0 -=
1.23438,0.48438 -0.48437,0.48437 -0.53125,1.3125 z m 5.45508,1.84375 1.0312=
5,-0.15625 q 0.0937,0.625 0.48438,0.95312 0.40625,0.32813 1.14062,0.32813 0=
.71875,0 1.0625,-0.28125 0.35938,-0.29688 0.35938,-0.70313 0,-0.35937 -0.31=
25,-0.5625 -0.21875,-0.14062 -1.07813,-0.35937 -1.15625,-0.29688 -1.60937,-=
0.5 -0.4375,-0.21875 -0.67188,-0.59375 -0.23437,-0.375 -0.23437,-0.84375 0,=
-0.40625 0.1875,-0.76563 0.1875,-0.35937 0.51562,-0.59375 0.25,-0.17187 0.6=
7188,-0.29687 0.42187,-0.125 0.92187,-0.125 0.71875,0 1.26563,0.21875 0.562=
5,0.20312 0.82812,0.5625 0.26563,0.35937 0.35938,0.95312 l -1.03125,0.14063=
 q -0.0625,-0.46875 -0.40625,-0.73438 -0.32813,-0.28125 -0.95313,-0.28125 -=
0.71875,0 -1.03125,0.25 -0.3125,0.23438 -0.3125,0.5625 0,0.20313 0.125,0.35=
938 0.14063,0.17187 0.40625,0.28125 0.15625,0.0625 0.9375,0.26562 1.125,0.3=
125 1.5625,0.5 0.4375,0.1875 0.6875,0.54688 0.25,0.35937 0.25,0.90625 0,0.5=
3125 -0.3125,1 -0.29687,0.45312 -0.875,0.71875 -0.57812,0.25 -1.3125,0.25 -=
1.21875,0 -1.85937,-0.5 -0.625,-0.51563 -0.79688,-1.5 z"
-       fill-rule=3D"nonzero"
-       id=3D"path290" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"M 688.20019,75.514867 V 360.08705"
-       fill-rule=3D"nonzero"
-       id=3D"path292" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"M 816.64369,75.514867 V 360.08705"
-       fill-rule=3D"nonzero"
-       id=3D"path294" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"m 687.70149,76.013557 h 129.441"
-       fill-rule=3D"nonzero"
-       id=3D"path296" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"m 687.70149,111.21041 h 129.441"
-       fill-rule=3D"nonzero"
-       id=3D"path298" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"m 687.70149,148.40726 h 129.441"
-       fill-rule=3D"nonzero"
-       id=3D"path300" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"m 687.70149,183.60412 h 129.441"
-       fill-rule=3D"nonzero"
-       id=3D"path302" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"m 687.70149,218.80095 h 129.441"
-       fill-rule=3D"nonzero"
-       id=3D"path304" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"m 687.70149,253.99782 h 129.441"
-       fill-rule=3D"nonzero"
-       id=3D"path306" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"m 687.70149,289.19466 h 129.441"
-       fill-rule=3D"nonzero"
-       id=3D"path308" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"m 687.70149,324.3915 h 129.441"
-       fill-rule=3D"nonzero"
-       id=3D"path310" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"0.969816"
-       stroke-linecap=3D"butt"
-       d=3D"M 688.95796,420.60254 H 810.70284"
-       fill-rule=3D"nonzero"
-       id=3D"path310-0" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"0.9689"
-       stroke-linecap=3D"butt"
-       d=3D"M 689.29865,450.44943 H 810.81369"
-       fill-rule=3D"nonzero"
-       id=3D"path310-0-7" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"m 687.70149,359.58837 h 129.441"
-       fill-rule=3D"nonzero"
-       id=3D"path312" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 734.99429,97.813557 v -9.54688 h 6.4375 v 1.125 h -5.1719 v =
2.96875 h 4.4688 v 1.125 h -4.4688 v 4.32813 z m 12.657,-2.21875 1.2031,0.1=
4062 q -0.2812,1.0625 -1.0625,1.65625 -0.7656,0.57813 -1.9687,0.57813 -1.51=
57,0 -2.4063,-0.9375 -0.8906,-0.9375 -0.8906,-2.60938 0,-1.75 0.8906,-2.703=
12 0.9063,-0.96875 2.3438,-0.96875 1.3906,0 2.2656,0.9375 0.875,0.9375 0.87=
5,2.65625 0,0.10937 0,0.3125 h -5.1563 q 0.062,1.14062 0.6407,1.75 0.5781,0=
.59375 1.4375,0.59375 0.6562,0 1.1093,-0.32813 0.4532,-0.34375 0.7188,-1.07=
812 z m -3.8438,-1.90625 h 3.8594 q -0.078,-0.85938 -0.4375,-1.29688 -0.562=
5,-0.6875 -1.4531,-0.6875 -0.8125,0 -1.3594,0.54688 -0.5469,0.53125 -0.6094=
,1.4375 z m 6.5219,4.125 v -6.90625 h 1.0625 v 0.98437 q 0.75,-1.14062 2.18=
75,-1.14062 0.625,0 1.1562,0.21875 0.5313,0.21875 0.7813,0.59375 0.2656,0.3=
5937 0.375,0.85937 0.062,0.32813 0.062,1.14063 v 4.25 h -1.1719 v -4.20313 =
q 0,-0.71875 -0.1406,-1.0625 -0.1406,-0.35937 -0.4844,-0.5625 -0.3437,-0.21=
875 -0.8125,-0.21875 -0.75,0 -1.2969,0.46875 -0.5468,0.46875 -0.5468,1.7968=
8 v 3.78125 z m 11.9281,-2.53125 1.1562,0.15625 q -0.1875,1.1875 -0.9687,1.=
85937 -0.7813,0.67188 -1.9219,0.67188 -1.4062,0 -2.2812,-0.92188 -0.8594,-0=
.9375 -0.8594,-2.65625 0,-1.125 0.375,-1.96875 0.375,-0.84375 1.125,-1.25 0=
.7656,-0.42187 1.6562,-0.42187 1.125,0 1.8438,0.57812 0.7187,0.5625 0.9219,=
1.60938 l -1.1407,0.17187 q -0.1718,-0.70312 -0.5937,-1.04687 -0.4063,-0.35=
938 -0.9844,-0.35938 -0.8906,0 -1.4531,0.64063 -0.5469,0.64062 -0.5469,2 0,=
1.40625 0.5313,2.03125 0.5468,0.625 1.4062,0.625 0.6875,0 1.1406,-0.42188 0=
.4688,-0.42187 0.5938,-1.29687 z m 6.8828,0.3125 1.2031,0.14062 q -0.2812,1=
.0625 -1.0625,1.65625 -0.7656,0.57813 -1.9687,0.57813 -1.5157,0 -2.4063,-0.=
9375 -0.8906,-0.9375 -0.8906,-2.60938 0,-1.75 0.8906,-2.70312 0.9063,-0.968=
75 2.3438,-0.96875 1.3906,0 2.2656,0.9375 0.875,0.9375 0.875,2.65625 0,0.10=
937 0,0.3125 h -5.1563 q 0.062,1.14062 0.6407,1.75 0.5781,0.59375 1.4375,0.=
59375 0.6562,0 1.1093,-0.32813 0.4532,-0.34375 0.7188,-1.07812 z m -3.8438,=
-1.90625 h 3.8594 q -0.078,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.453=
1,-0.6875 -0.8125,0 -1.3594,0.54688 -0.5469,0.53125 -0.6094,1.4375 z"
-       fill-rule=3D"nonzero"
-       id=3D"path314" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 710.41189,129.94791 1.2031,-0.10938 q 0.078,0.71875 0.3906,1=
.1875 0.3125,0.45313 0.9532,0.73438 0.6562,0.28125 1.4687,0.28125 0.7188,0 =
1.2656,-0.21875 0.5625,-0.21875 0.8282,-0.57813 0.2656,-0.375 0.2656,-0.828=
12 0,-0.45313 -0.2656,-0.78125 -0.25,-0.32813 -0.8438,-0.5625 -0.3906,-0.15=
625 -1.7031,-0.46875 -1.3125,-0.3125 -1.8438,-0.59375 -0.6718,-0.35938 -1.0=
156,-0.89063 -0.3281,-0.53125 -0.3281,-1.1875 0,-0.71875 0.4062,-1.34375 0.=
4063,-0.625 1.1875,-0.95312 0.7969,-0.32813 1.7657,-0.32813 1.0468,0 1.8593=
,0.34375 0.8125,0.34375 1.25,1.01563 0.4375,0.65625 0.4688,1.48437 l -1.203=
1,0.0937 q -0.1094,-0.90625 -0.6719,-1.35937 -0.5625,-0.46875 -1.6563,-0.46=
875 -1.1406,0 -1.6718,0.42187 -0.5157,0.42188 -0.5157,1.01563 0,0.51562 0.3=
594,0.84375 0.375,0.32812 1.9063,0.6875 1.5468,0.34375 2.1093,0.59375 0.843=
8,0.39062 1.2344,0.98437 0.3906,0.57813 0.3906,1.35938 0,0.75 -0.4375,1.437=
5 -0.4218,0.67187 -1.25,1.04687 -0.8125,0.35938 -1.8281,0.35938 -1.2969,0 -=
2.1719,-0.375 -0.875,-0.375 -1.375,-1.125 -0.5,-0.76563 -0.5312,-1.71875 z =
m 9.1553,3.0625 v -9.54688 h 1.1719 v 9.54688 z m 2.5393,-3.45313 q 0,-1.92=
187 1.0781,-2.84375 0.8906,-0.76562 2.1719,-0.76562 1.4218,0 2.3281,0.9375 =
0.9062,0.92187 0.9062,2.57812 0,1.32813 -0.4062,2.09375 -0.3906,0.76563 -1.=
1563,1.1875 -0.7656,0.42188 -1.6718,0.42188 -1.4532,0 -2.3594,-0.92188 -0.8=
906,-0.9375 -0.8906,-2.6875 z m 1.2031,0 q 0,1.32813 0.5781,1.98438 0.5938,=
0.65625 1.4688,0.65625 0.875,0 1.4531,-0.65625 0.5781,-0.67188 0.5781,-2.03=
125 0,-1.28125 -0.5937,-1.9375 -0.5782,-0.65625 -1.4375,-0.65625 -0.875,0 -=
1.4688,0.65625 -0.5781,0.65625 -0.5781,1.98437 z m 7.9281,3.45313 -2.125,-6=
.90625 h 1.2188 l 1.0937,3.98437 0.4219,1.48438 q 0.016,-0.10938 0.3594,-1.=
42188 l 1.0937,-4.04687 h 1.2031 l 1.0313,4 0.3437,1.32812 0.4063,-1.34375 =
1.1719,-3.98437 h 1.1406 l -2.1563,6.90625 h -1.2187 l -1.0938,-4.14063 -0.=
2656,-1.17187 -1.4062,5.3125 z m 8.3439,2.65625 v -9.5625 h 1.0781 v 0.8906=
2 q 0.375,-0.53125 0.8437,-0.78125 0.4844,-0.26562 1.1563,-0.26562 0.875,0 =
1.5469,0.45312 0.6875,0.45313 1.0312,1.28125 0.3438,0.82813 0.3438,1.82813 =
0,1.04687 -0.375,1.90625 -0.375,0.84375 -1.1094,1.29687 -0.7188,0.45313 -1.=
5313,0.45313 -0.5781,0 -1.0468,-0.25 -0.4688,-0.25 -0.7657,-0.625 v 3.375 z=
 m 1.0625,-6.07813 q 0,1.34375 0.5312,1.98438 0.5469,0.625 1.3125,0.625 0.7=
813,0 1.3438,-0.65625 0.5625,-0.65625 0.5625,-2.04688 0,-1.3125 -0.5469,-1.=
96875 -0.5469,-0.67187 -1.2969,-0.67187 -0.75,0 -1.3281,0.70312 -0.5781,0.7=
0313 -0.5781,2.03125 z m 10.8656,2.5625 q -0.6563,0.5625 -1.2657,0.79688 -0=
.5937,0.21875 -1.2812,0.21875 -1.1406,0 -1.75,-0.54688 -0.6094,-0.5625 -0.6=
094,-1.4375 0,-0.5 0.2188,-0.92187 0.2343,-0.42188 0.6093,-0.67188 0.375,-0=
.25 0.8438,-0.39062 0.3437,-0.0781 1.0469,-0.17188 1.4218,-0.17187 2.0937,-=
0.40625 0,-0.23437 0,-0.29687 0,-0.71875 -0.3281,-1.01563 -0.4531,-0.39062 =
-1.3438,-0.39062 -0.8125,0 -1.2187,0.29687 -0.3906,0.28125 -0.5781,1.01563 =
l -1.1407,-0.15625 q 0.1563,-0.73438 0.5157,-1.1875 0.3593,-0.45313 1.0312,=
-0.6875 0.6719,-0.25 1.5625,-0.25 0.8906,0 1.4375,0.20312 0.5625,0.20313 0.=
8125,0.53125 0.2656,0.3125 0.375,0.79688 0.047,0.29687 0.047,1.07812 v 1.56=
25 q 0,1.625 0.078,2.0625 0.078,0.4375 0.2969,0.82813 h -1.2188 q -0.1875,-=
0.35938 -0.2343,-0.85938 z m -0.094,-2.60937 q -0.6407,0.26562 -1.9219,0.43=
75 -0.7188,0.10937 -1.0156,0.25 -0.2969,0.125 -0.4688,0.375 -0.1562,0.25 -0=
.1562,0.54687 0,0.46875 0.3437,0.78125 0.3594,0.3125 1.0469,0.3125 0.6719,0=
 1.2031,-0.29687 0.5313,-0.29688 0.7813,-0.8125 0.1875,-0.39063 0.1875,-1.1=
7188 z m 5.5531,2.42187 0.1718,1.03125 q -0.5,0.10938 -0.8906,0.10938 -0.64=
06,0 -1,-0.20313 -0.3437,-0.20312 -0.4844,-0.53125 -0.1406,-0.32812 -0.1406=
,-1.39062 v -3.96875 h -0.8594 v -0.90625 h 0.8594 v -1.71875 l 1.1719,-0.7=
0313 v 2.42188 h 1.1719 v 0.90625 h -1.1719 v 4.04687 q 0,0.5 0.047,0.64063=
 0.062,0.14062 0.2031,0.23437 0.1406,0.0781 0.4063,0.0781 0.2031,0 0.5156,-=
0.0469 z m 1.1405,1.04688 v -9.54688 h 1.1719 v 3.42188 q 0.8281,-0.9375 2.=
0781,-0.9375 0.7656,0 1.3281,0.29687 0.5625,0.29688 0.8125,0.84375 0.25,0.5=
3125 0.25,1.54688 v 4.375 h -1.1719 v -4.375 q 0,-0.89063 -0.3906,-1.28125 =
-0.375,-0.40625 -1.0781,-0.40625 -0.5156,0 -0.9844,0.28125 -0.4531,0.26562 =
-0.6562,0.73437 -0.1875,0.45313 -0.1875,1.26563 v 3.78125 z m 15.6311,-0.85=
938 q -0.6563,0.5625 -1.2656,0.79688 -0.5938,0.21875 -1.2813,0.21875 -1.140=
6,0 -1.75,-0.54688 -0.6094,-0.5625 -0.6094,-1.4375 0,-0.5 0.2188,-0.92187 0=
.2344,-0.42188 0.6094,-0.67188 0.375,-0.25 0.8437,-0.39062 0.3438,-0.0781 1=
.0469,-0.17188 1.4219,-0.17187 2.0937,-0.40625 0,-0.23437 0,-0.29687 0,-0.7=
1875 -0.3281,-1.01563 -0.4531,-0.39062 -1.3437,-0.39062 -0.8125,0 -1.2188,0=
.29687 -0.3906,0.28125 -0.5781,1.01563 l -1.1406,-0.15625 q 0.1562,-0.73438=
 0.5156,-1.1875 0.3594,-0.45313 1.0312,-0.6875 0.6719,-0.25 1.5625,-0.25 0.=
8907,0 1.4375,0.20312 0.5625,0.20313 0.8125,0.53125 0.2657,0.3125 0.375,0.7=
9688 0.047,0.29687 0.047,1.07812 v 1.5625 q 0,1.625 0.078,2.0625 0.078,0.43=
75 0.2969,0.82813 h -1.2187 q -0.1875,-0.35938 -0.2344,-0.85938 z m -0.094,=
-2.60937 q -0.6406,0.26562 -1.9219,0.4375 -0.7187,0.10937 -1.0156,0.25 -0.2=
969,0.125 -0.4688,0.375 -0.1562,0.25 -0.1562,0.54687 0,0.46875 0.3437,0.781=
25 0.3594,0.3125 1.0469,0.3125 0.6719,0 1.2031,-0.29687 0.5313,-0.29688 0.7=
813,-0.8125 0.1875,-0.39063 0.1875,-1.17188 z m 2.975,3.46875 v -6.90625 h =
1.0625 v 1.04687 q 0.4062,-0.73437 0.7343,-0.96875 0.3438,-0.23437 0.7657,-=
0.23437 0.5937,0 1.2031,0.375 l -0.4063,1.07812 q -0.4375,-0.25 -0.8593,-0.=
25 -0.3907,0 -0.7032,0.23438 -0.2968,0.23437 -0.4218,0.64062 -0.2032,0.625 =
-0.2032,1.35938 v 3.625 z m 9.1883,-2.21875 1.2031,0.14062 q -0.2812,1.0625=
 -1.0625,1.65625 -0.7656,0.57813 -1.9687,0.57813 -1.5156,0 -2.4063,-0.9375 =
-0.8906,-0.9375 -0.8906,-2.60938 0,-1.75 0.8906,-2.70312 0.9063,-0.96875 2.=
3438,-0.96875 1.3906,0 2.2656,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0=
,0.3125 h -5.1562 q 0.062,1.14062 0.6406,1.75 0.5781,0.59375 1.4375,0.59375=
 0.6562,0 1.1094,-0.32813 0.4531,-0.34375 0.7187,-1.07812 z m -3.8437,-1.90=
625 h 3.8593 q -0.078,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.4531,-0.=
6875 -0.8125,0 -1.3594,0.54688 -0.5468,0.53125 -0.6093,1.4375 z m 11.0374,3=
.26562 q -0.6562,0.5625 -1.2656,0.79688 -0.5937,0.21875 -1.2812,0.21875 -1.=
1407,0 -1.75,-0.54688 -0.6094,-0.5625 -0.6094,-1.4375 0,-0.5 0.2187,-0.9218=
7 0.2344,-0.42188 0.6094,-0.67188 0.375,-0.25 0.8438,-0.39062 0.3437,-0.078=
1 1.0468,-0.17188 1.4219,-0.17187 2.0938,-0.40625 0,-0.23437 0,-0.29687 0,-=
0.71875 -0.3281,-1.01563 -0.4532,-0.39062 -1.3438,-0.39062 -0.8125,0 -1.218=
7,0.29687 -0.3907,0.28125 -0.5782,1.01563 l -1.1406,-0.15625 q 0.1563,-0.73=
438 0.5156,-1.1875 0.3594,-0.45313 1.0313,-0.6875 0.6719,-0.25 1.5625,-0.25=
 0.8906,0 1.4375,0.20312 0.5625,0.20313 0.8125,0.53125 0.2656,0.3125 0.375,=
0.79688 0.047,0.29687 0.047,1.07812 v 1.5625 q 0,1.625 0.078,2.0625 0.078,0=
.4375 0.2969,0.82813 h -1.2188 q -0.1875,-0.35938 -0.2344,-0.85938 z m -0.0=
94,-2.60937 q -0.6406,0.26562 -1.9218,0.4375 -0.7188,0.10937 -1.0157,0.25 -=
0.2968,0.125 -0.4687,0.375 -0.1563,0.25 -0.1563,0.54687 0,0.46875 0.3438,0.=
78125 0.3594,0.3125 1.0469,0.3125 0.6718,0 1.2031,-0.29687 0.5312,-0.29688 =
0.7812,-0.8125 0.1875,-0.39063 0.1875,-1.17188 z"
-       fill-rule=3D"nonzero"
-       id=3D"path316" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 711.36619,166.86352 1.2656,0.3125 q -0.3906,1.5625 -1.4219,2=
.375 -1.0312,0.8125 -2.5312,0.8125 -1.5313,0 -2.5,-0.625 -0.9688,-0.625 -1.=
4844,-1.8125 -0.5,-1.1875 -0.5,-2.5625 0,-1.48438 0.5625,-2.59375 0.5781,-1=
.10938 1.625,-1.6875 1.0625,-0.57813 2.3281,-0.57813 1.4219,0 2.3907,0.7343=
8 0.9843,0.71875 1.375,2.04687 l -1.25,0.29688 q -0.3282,-1.04688 -0.9688,-=
1.51563 -0.625,-0.48437 -1.5781,-0.48437 -1.0938,0 -1.8438,0.53125 -0.7343,=
0.53125 -1.0312,1.42187 -0.2969,0.875 -0.2969,1.82813 0,1.21875 0.3438,2.12=
5 0.3593,0.90625 1.1093,1.35937 0.75,0.4375 1.625,0.4375 1.0625,0 1.7969,-0=
.60937 0.7344,-0.60938 0.9844,-1.8125 z m 2.2345,-0.10938 q 0,-1.92187 1.07=
81,-2.84375 0.8906,-0.76562 2.1719,-0.76562 1.4219,0 2.3281,0.9375 0.9063,0=
.92187 0.9063,2.57812 0,1.32813 -0.4063,2.09375 -0.3906,0.76563 -1.1562,1.1=
875 -0.7657,0.42188 -1.6719,0.42188 -1.4531,0 -2.3594,-0.92188 -0.8906,-0.9=
375 -0.8906,-2.6875 z m 1.2031,0 q 0,1.32813 0.5781,1.98438 0.5938,0.65625 =
1.4688,0.65625 0.875,0 1.4531,-0.65625 0.5781,-0.67188 0.5781,-2.03125 0,-1=
.28125 -0.5937,-1.9375 -0.5781,-0.65625 -1.4375,-0.65625 -0.875,0 -1.4688,0=
.65625 -0.5781,0.65625 -0.5781,1.98437 z m 6.6469,3.45313 v -6.90625 h 1.06=
25 v 0.98437 q 0.75,-1.14062 2.1875,-1.14062 0.625,0 1.1562,0.21875 0.5313,=
0.21875 0.7813,0.59375 0.2656,0.35937 0.375,0.85937 0.062,0.32813 0.062,1.1=
4063 v 4.25 h -1.1719 v -4.20313 q 0,-0.71875 -0.1406,-1.0625 -0.1407,-0.35=
937 -0.4844,-0.5625 -0.3438,-0.21875 -0.8125,-0.21875 -0.75,0 -1.2969,0.468=
75 -0.5469,0.46875 -0.5469,1.79688 v 3.78125 z m 9.9749,-1.04688 0.1719,1.0=
3125 q -0.5,0.10938 -0.8906,0.10938 -0.6406,0 -1,-0.20313 -0.3438,-0.20312 =
-0.4844,-0.53125 -0.1406,-0.32812 -0.1406,-1.39062 v -3.96875 h -0.8594 v -=
0.90625 h 0.8594 v -1.71875 l 1.1719,-0.70313 v 2.42188 h 1.1718 v 0.90625 =
h -1.1718 v 4.04687 q 0,0.5 0.047,0.64063 0.062,0.14062 0.2031,0.23437 0.14=
06,0.0781 0.4062,0.0781 0.2032,0 0.5157,-0.0469 z m 5.8749,-1.17187 1.2031,=
0.14062 q -0.2812,1.0625 -1.0625,1.65625 -0.7656,0.57813 -1.9687,0.57813 -1=
.5156,0 -2.4063,-0.9375 -0.8906,-0.9375 -0.8906,-2.60938 0,-1.75 0.8906,-2.=
70312 0.9063,-0.96875 2.3438,-0.96875 1.3906,0 2.2656,0.9375 0.875,0.9375 0=
.875,2.65625 0,0.10937 0,0.3125 h -5.1562 q 0.062,1.14062 0.6406,1.75 0.578=
1,0.59375 1.4375,0.59375 0.6562,0 1.1094,-0.32813 0.4531,-0.34375 0.7187,-1=
.07812 z m -3.8437,-1.90625 h 3.8593 q -0.078,-0.85938 -0.4375,-1.29688 -0.=
5625,-0.6875 -1.4531,-0.6875 -0.8125,0 -1.3594,0.54688 -0.5468,0.53125 -0.6=
093,1.4375 z m 5.7406,4.125 2.5312,-3.59375 -2.3437,-3.3125 h 1.4687 l 1.06=
25,1.60937 q 0.2969,0.46875 0.4844,0.78125 0.2812,-0.4375 0.5156,-0.76562 l=
 1.1719,-1.625 h 1.4062 l -2.3906,3.25 2.5625,3.65625 h -1.4375 l -1.4219,-=
2.14063 -0.375,-0.59375 -1.8125,2.73438 z m 10.0078,-1.04688 0.1719,1.03125=
 q -0.5,0.10938 -0.8907,0.10938 -0.6406,0 -1,-0.20313 -0.3437,-0.20312 -0.4=
843,-0.53125 -0.1407,-0.32812 -0.1407,-1.39062 v -3.96875 h -0.8593 v -0.90=
625 h 0.8593 v -1.71875 l 1.1719,-0.70313 v 2.42188 h 1.1719 v 0.90625 h -1=
.1719 v 4.04687 q 0,0.5 0.047,0.64063 0.062,0.14062 0.2031,0.23437 0.1407,0=
.0781 0.4063,0.0781 0.2031,0 0.5156,-0.0469 z m 4.8434,1.04688 v -6.90625 h=
 1.0469 v 0.96875 q 0.3281,-0.51563 0.8594,-0.8125 0.5468,-0.3125 1.2343,-0=
.3125 0.7813,0 1.2657,0.3125 0.4843,0.3125 0.6875,0.89062 0.8281,-1.20312 2=
.1406,-1.20312 1.0312,0 1.5781,0.57812 0.5625,0.5625 0.5625,1.73438 v 4.75 =
h -1.1719 v -4.35938 q 0,-0.70312 -0.125,-1 -0.1093,-0.3125 -0.4062,-0.5 -0=
.2969,-0.1875 -0.7031,-0.1875 -0.7188,0 -1.2032,0.48438 -0.4843,0.48437 -0.=
4843,1.54687 v 4.01563 h -1.1719 v -4.48438 q 0,-0.78125 -0.2969,-1.17187 -=
0.2812,-0.39063 -0.9219,-0.39063 -0.5,0 -0.9218,0.26563 -0.4219,0.25 -0.609=
4,0.75 -0.1875,0.5 -0.1875,1.45312 v 3.57813 z m 15.8369,-2.21875 1.2031,0.=
14062 q -0.2812,1.0625 -1.0625,1.65625 -0.7656,0.57813 -1.9687,0.57813 -1.5=
157,0 -2.4063,-0.9375 -0.8906,-0.9375 -0.8906,-2.60938 0,-1.75 0.8906,-2.70=
312 0.9063,-0.96875 2.3438,-0.96875 1.3906,0 2.2656,0.9375 0.875,0.9375 0.8=
75,2.65625 0,0.10937 0,0.3125 h -5.1563 q 0.062,1.14062 0.6407,1.75 0.5781,=
0.59375 1.4375,0.59375 0.6562,0 1.1093,-0.32813 0.4532,-0.34375 0.7188,-1.0=
7812 z m -3.8438,-1.90625 h 3.8594 q -0.078,-0.85938 -0.4375,-1.29688 -0.56=
25,-0.6875 -1.4531,-0.6875 -0.8125,0 -1.3594,0.54688 -0.5469,0.53125 -0.609=
4,1.4375 z m 6.5219,4.125 v -6.90625 h 1.0468 v 0.96875 q 0.3282,-0.51563 0=
.8594,-0.8125 0.5469,-0.3125 1.2344,-0.3125 0.7812,0 1.2656,0.3125 0.4844,0=
.3125 0.6875,0.89062 0.8281,-1.20312 2.1406,-1.20312 1.0313,0 1.5782,0.5781=
2 0.5625,0.5625 0.5625,1.73438 v 4.75 h -1.1719 v -4.35938 q 0,-0.70312 -0.=
125,-1 -0.1094,-0.3125 -0.4063,-0.5 -0.2968,-0.1875 -0.7031,-0.1875 -0.7187=
,0 -1.2031,0.48438 -0.4844,0.48437 -0.4844,1.54687 v 4.01563 h -1.1719 v -4=
.48438 q 0,-0.78125 -0.2968,-1.17187 -0.2813,-0.39063 -0.9219,-0.39063 -0.5=
,0 -0.9219,0.26563 -0.4219,0.25 -0.6094,0.75 -0.1875,0.5 -0.1875,1.45312 v =
3.57813 z m 10.6649,-3.45313 q 0,-1.92187 1.0781,-2.84375 0.8906,-0.76562 2=
.1719,-0.76562 1.4219,0 2.3281,0.9375 0.9063,0.92187 0.9063,2.57812 0,1.328=
13 -0.4063,2.09375 -0.3906,0.76563 -1.1562,1.1875 -0.7657,0.42188 -1.6719,0=
.42188 -1.4531,0 -2.3594,-0.92188 -0.8906,-0.9375 -0.8906,-2.6875 z m 1.203=
1,0 q 0,1.32813 0.5781,1.98438 0.5938,0.65625 1.4688,0.65625 0.875,0 1.4531=
,-0.65625 0.5781,-0.67188 0.5781,-2.03125 0,-1.28125 -0.5937,-1.9375 -0.578=
1,-0.65625 -1.4375,-0.65625 -0.875,0 -1.4688,0.65625 -0.5781,0.65625 -0.578=
1,1.98437 z m 6.6313,3.45313 v -6.90625 h 1.0625 v 1.04687 q 0.4062,-0.7343=
7 0.7343,-0.96875 0.3438,-0.23437 0.7657,-0.23437 0.5937,0 1.2031,0.375 l -=
0.4063,1.07812 q -0.4375,-0.25 -0.8593,-0.25 -0.3907,0 -0.7032,0.23438 -0.2=
968,0.23437 -0.4218,0.64062 -0.2032,0.625 -0.2032,1.35938 v 3.625 z m 4.407=
,2.65625 -0.125,-1.09375 q 0.375,0.10937 0.6563,0.10937 0.3906,0 0.625,-0.1=
4062 0.2344,-0.125 0.3906,-0.35938 0.1094,-0.17187 0.3594,-0.875 0.031,-0.0=
937 0.1094,-0.28125 l -2.625,-6.92187 h 1.2656 l 1.4375,4 q 0.2812,0.76562 =
0.5,1.59375 0.2031,-0.79688 0.4687,-1.57813 l 1.4844,-4.01562 h 1.1719 l -2=
.625,7.01562 q -0.4219,1.14063 -0.6563,1.57813 -0.3125,0.57812 -0.7187,0.84=
375 -0.4063,0.28125 -0.9688,0.28125 -0.3281,0 -0.75,-0.15625 z"
-       fill-rule=3D"nonzero"
-       id=3D"path318" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 712.39569,205.4041 v -9.54688 h 6.4375 v 1.125 h -5.1719 v 2=
.96875 h 4.4688 v 1.125 h -4.4688 v 4.32813 z m 12.4382,-0.85938 q -0.6562,=
0.5625 -1.2656,0.79688 -0.5937,0.21875 -1.2812,0.21875 -1.1407,0 -1.75,-0.5=
4688 -0.6094,-0.5625 -0.6094,-1.4375 0,-0.5 0.2187,-0.92187 0.2344,-0.42188=
 0.6094,-0.67188 0.375,-0.25 0.8438,-0.39062 0.3437,-0.0781 1.0468,-0.17188=
 1.4219,-0.17187 2.0938,-0.40625 0,-0.23437 0,-0.29687 0,-0.71875 -0.3281,-=
1.01563 -0.4532,-0.39062 -1.3438,-0.39062 -0.8125,0 -1.2187,0.29687 -0.3907=
,0.28125 -0.5782,1.01563 l -1.1406,-0.15625 q 0.1563,-0.73438 0.5156,-1.187=
5 0.3594,-0.45313 1.0313,-0.6875 0.6719,-0.25 1.5625,-0.25 0.8906,0 1.4375,=
0.20312 0.5625,0.20313 0.8125,0.53125 0.2656,0.3125 0.375,0.79688 0.047,0.2=
9687 0.047,1.07812 v 1.5625 q 0,1.625 0.078,2.0625 0.078,0.4375 0.2969,0.82=
813 h -1.2188 q -0.1875,-0.35938 -0.2344,-0.85938 z m -0.094,-2.60937 q -0.=
6406,0.26562 -1.9218,0.4375 -0.7188,0.10937 -1.0157,0.25 -0.2968,0.125 -0.4=
687,0.375 -0.1563,0.25 -0.1563,0.54687 0,0.46875 0.3438,0.78125 0.3594,0.31=
25 1.0469,0.3125 0.6718,0 1.2031,-0.29687 0.5312,-0.29688 0.7812,-0.8125 0.=
1875,-0.39063 0.1875,-1.17188 z m 2.5219,1.40625 1.1562,-0.1875 q 0.1094,0.=
70312 0.5469,1.07812 0.4531,0.35938 1.25,0.35938 0.8125,0 1.2031,-0.32813 0=
.3907,-0.32812 0.3907,-0.76562 0,-0.39063 -0.3594,-0.625 -0.2344,-0.15625 -=
1.1875,-0.39063 -1.2969,-0.32812 -1.7969,-0.5625 -0.4844,-0.25 -0.75,-0.656=
25 -0.25,-0.42187 -0.25,-0.9375 0,-0.45312 0.2031,-0.84375 0.2188,-0.40625 =
0.5782,-0.67187 0.2812,-0.1875 0.75,-0.32813 0.4687,-0.14062 1.0156,-0.1406=
2 0.8125,0 1.4219,0.23437 0.6093,0.23438 0.9062,0.64063 0.2969,0.39062 0.40=
63,1.0625 l -1.1407,0.15625 q -0.078,-0.53125 -0.4531,-0.82813 -0.375,-0.31=
25 -1.0625,-0.3125 -0.8125,0 -1.1562,0.26563 -0.3438,0.26562 -0.3438,0.625 =
0,0.23437 0.1406,0.42187 0.1563,0.1875 0.4532,0.3125 0.1718,0.0625 1.0312,0=
.29688 1.25,0.32812 1.7344,0.54687 0.5,0.20313 0.7812,0.60938 0.2813,0.4062=
5 0.2813,1 0,0.59375 -0.3438,1.10937 -0.3437,0.51563 -1,0.79688 -0.6406,0.2=
8125 -1.4531,0.28125 -1.3437,0 -2.0469,-0.5625 -0.7031,-0.5625 -0.9062,-1.6=
5625 z m 9.6953,1.01562 0.1719,1.03125 q -0.5,0.10938 -0.8907,0.10938 -0.64=
06,0 -1,-0.20313 -0.3437,-0.20312 -0.4843,-0.53125 -0.1407,-0.32812 -0.1407=
,-1.39062 v -3.96875 h -0.8593 v -0.90625 h 0.8593 v -1.71875 l 1.1719,-0.7=
0313 v 2.42188 h 1.1719 v 0.90625 h -1.1719 v 4.04687 q 0,0.5 0.047,0.64063=
 0.062,0.14062 0.2031,0.23437 0.1407,0.0781 0.4063,0.0781 0.2031,0 0.5156,-=
0.0469 z m 1.1405,3.70313 v -9.5625 h 1.0781 v 0.89062 q 0.375,-0.53125 0.8=
438,-0.78125 0.4843,-0.26562 1.1562,-0.26562 0.875,0 1.5469,0.45312 0.6875,=
0.45313 1.0312,1.28125 0.3438,0.82813 0.3438,1.82813 0,1.04687 -0.375,1.906=
25 -0.375,0.84375 -1.1094,1.29687 -0.7187,0.45313 -1.5312,0.45313 -0.5782,0=
 -1.0469,-0.25 -0.4688,-0.25 -0.7656,-0.625 v 3.375 z m 1.0625,-6.07813 q 0=
,1.34375 0.5312,1.98438 0.5469,0.625 1.3125,0.625 0.7813,0 1.3438,-0.65625 =
0.5625,-0.65625 0.5625,-2.04688 0,-1.3125 -0.5469,-1.96875 -0.5469,-0.67187=
 -1.2969,-0.67187 -0.75,0 -1.3281,0.70312 -0.5781,0.70313 -0.5781,2.03125 z=
 m 10.8656,2.5625 q -0.6563,0.5625 -1.2656,0.79688 -0.5938,0.21875 -1.2813,=
0.21875 -1.1406,0 -1.75,-0.54688 -0.6094,-0.5625 -0.6094,-1.4375 0,-0.5 0.2=
188,-0.92187 0.2344,-0.42188 0.6094,-0.67188 0.375,-0.25 0.8437,-0.39062 0.=
3438,-0.0781 1.0469,-0.17188 1.4219,-0.17187 2.0937,-0.40625 0,-0.23437 0,-=
0.29687 0,-0.71875 -0.3281,-1.01563 -0.4531,-0.39062 -1.3437,-0.39062 -0.81=
25,0 -1.2188,0.29687 -0.3906,0.28125 -0.5781,1.01563 l -1.1406,-0.15625 q 0=
.1562,-0.73438 0.5156,-1.1875 0.3594,-0.45313 1.0312,-0.6875 0.6719,-0.25 1=
.5625,-0.25 0.8907,0 1.4375,0.20312 0.5625,0.20313 0.8125,0.53125 0.2657,0.=
3125 0.375,0.79688 0.047,0.29687 0.047,1.07812 v 1.5625 q 0,1.625 0.078,2.0=
625 0.078,0.4375 0.2969,0.82813 h -1.2187 q -0.1875,-0.35938 -0.2344,-0.859=
38 z m -0.094,-2.60937 q -0.6406,0.26562 -1.9219,0.4375 -0.7187,0.10937 -1.=
0156,0.25 -0.2969,0.125 -0.4688,0.375 -0.1562,0.25 -0.1562,0.54687 0,0.4687=
5 0.3437,0.78125 0.3594,0.3125 1.0469,0.3125 0.6719,0 1.2031,-0.29687 0.531=
3,-0.29688 0.7813,-0.8125 0.1875,-0.39063 0.1875,-1.17188 z m 5.5531,2.4218=
7 0.1719,1.03125 q -0.5,0.10938 -0.8907,0.10938 -0.6406,0 -1,-0.20313 -0.34=
37,-0.20312 -0.4843,-0.53125 -0.1407,-0.32812 -0.1407,-1.39062 v -3.96875 h=
 -0.8593 v -0.90625 h 0.8593 v -1.71875 l 1.1719,-0.70313 v 2.42188 h 1.171=
9 v 0.90625 h -1.1719 v 4.04687 q 0,0.5 0.047,0.64063 0.062,0.14062 0.2031,=
0.23437 0.1407,0.0781 0.4063,0.0781 0.2031,0 0.5156,-0.0469 z m 1.1405,1.04=
688 v -9.54688 h 1.1719 v 3.42188 q 0.8281,-0.9375 2.0781,-0.9375 0.7656,0 =
1.3281,0.29687 0.5625,0.29688 0.8125,0.84375 0.25,0.53125 0.25,1.54688 v 4.=
375 h -1.1719 v -4.375 q 0,-0.89063 -0.3906,-1.28125 -0.375,-0.40625 -1.078=
1,-0.40625 -0.5156,0 -0.9844,0.28125 -0.4531,0.26562 -0.6562,0.73437 -0.187=
5,0.45313 -0.1875,1.26563 v 3.78125 z m 15.631,-0.85938 q -0.6562,0.5625 -1=
.2656,0.79688 -0.5937,0.21875 -1.2812,0.21875 -1.1407,0 -1.75,-0.54688 -0.6=
094,-0.5625 -0.6094,-1.4375 0,-0.5 0.2187,-0.92187 0.2344,-0.42188 0.6094,-=
0.67188 0.375,-0.25 0.8438,-0.39062 0.3437,-0.0781 1.0468,-0.17188 1.4219,-=
0.17187 2.0938,-0.40625 0,-0.23437 0,-0.29687 0,-0.71875 -0.3281,-1.01563 -=
0.4532,-0.39062 -1.3438,-0.39062 -0.8125,0 -1.2187,0.29687 -0.3907,0.28125 =
-0.5782,1.01563 l -1.1406,-0.15625 q 0.1563,-0.73438 0.5156,-1.1875 0.3594,=
-0.45313 1.0313,-0.6875 0.6719,-0.25 1.5625,-0.25 0.8906,0 1.4375,0.20312 0=
.5625,0.20313 0.8125,0.53125 0.2656,0.3125 0.375,0.79688 0.047,0.29687 0.04=
7,1.07812 v 1.5625 q 0,1.625 0.078,2.0625 0.078,0.4375 0.2969,0.82813 h -1.=
2188 q -0.1875,-0.35938 -0.2344,-0.85938 z m -0.094,-2.60937 q -0.6406,0.26=
562 -1.9218,0.4375 -0.7188,0.10937 -1.0157,0.25 -0.2968,0.125 -0.4687,0.375=
 -0.1563,0.25 -0.1563,0.54687 0,0.46875 0.3438,0.78125 0.3594,0.3125 1.0469=
,0.3125 0.6718,0 1.2031,-0.29687 0.5312,-0.29688 0.7812,-0.8125 0.1875,-0.3=
9063 0.1875,-1.17188 z m 2.975,3.46875 v -6.90625 h 1.0625 v 1.04687 q 0.40=
63,-0.73437 0.7344,-0.96875 0.3437,-0.23437 0.7656,-0.23437 0.5938,0 1.2031=
,0.375 l -0.4062,1.07812 q -0.4375,-0.25 -0.8594,-0.25 -0.3906,0 -0.7031,0.=
23438 -0.2969,0.23437 -0.4219,0.64062 -0.2031,0.625 -0.2031,1.35938 v 3.625=
 z m 9.1884,-2.21875 1.2031,0.14062 q -0.2812,1.0625 -1.0625,1.65625 -0.765=
6,0.57813 -1.9687,0.57813 -1.5156,0 -2.4063,-0.9375 -0.8906,-0.9375 -0.8906=
,-2.60938 0,-1.75 0.8906,-2.70312 0.9063,-0.96875 2.3438,-0.96875 1.3906,0 =
2.2656,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.1562 q 0.0=
62,1.14062 0.6406,1.75 0.5781,0.59375 1.4375,0.59375 0.6562,0 1.1094,-0.328=
13 0.4531,-0.34375 0.7187,-1.07812 z m -3.8437,-1.90625 h 3.8593 q -0.078,-=
0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.4531,-0.6875 -0.8125,0 -1.3594,=
0.54688 -0.5468,0.53125 -0.6093,1.4375 z m 11.0374,3.26562 q -0.6562,0.5625=
 -1.2656,0.79688 -0.5937,0.21875 -1.2812,0.21875 -1.1407,0 -1.75,-0.54688 -=
0.6094,-0.5625 -0.6094,-1.4375 0,-0.5 0.2187,-0.92187 0.2344,-0.42188 0.609=
4,-0.67188 0.375,-0.25 0.8438,-0.39062 0.3437,-0.0781 1.0468,-0.17188 1.421=
9,-0.17187 2.0938,-0.40625 0,-0.23437 0,-0.29687 0,-0.71875 -0.3281,-1.0156=
3 -0.4532,-0.39062 -1.3438,-0.39062 -0.8125,0 -1.2187,0.29687 -0.3907,0.281=
25 -0.5782,1.01563 l -1.1406,-0.15625 q 0.1563,-0.73438 0.5156,-1.1875 0.35=
94,-0.45313 1.0313,-0.6875 0.6719,-0.25 1.5625,-0.25 0.8906,0 1.4375,0.2031=
2 0.5625,0.20313 0.8125,0.53125 0.2656,0.3125 0.375,0.79688 0.047,0.29687 0=
.047,1.07812 v 1.5625 q 0,1.625 0.078,2.0625 0.078,0.4375 0.2969,0.82813 h =
-1.2188 q -0.1875,-0.35938 -0.2344,-0.85938 z m -0.094,-2.60937 q -0.6406,0=
.26562 -1.9218,0.4375 -0.7188,0.10937 -1.0157,0.25 -0.2968,0.125 -0.4687,0.=
375 -0.1563,0.25 -0.1563,0.54687 0,0.46875 0.3438,0.78125 0.3594,0.3125 1.0=
469,0.3125 0.6718,0 1.2031,-0.29687 0.5312,-0.29688 0.7812,-0.8125 0.1875,-=
0.39063 0.1875,-1.17188 z"
-       fill-rule=3D"nonzero"
-       id=3D"path320" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 707.87269,240.60097 v -9.54689 h 1.2969 l 5.0156,7.50002 v -=
7.50002 h 1.2031 v 9.54689 h -1.2969 l -5.0156,-7.5 v 7.5 z m 14.2189,-2.21=
875 1.2032,0.14063 q -0.2813,1.0625 -1.0625,1.65625 -0.7657,0.57812 -1.9688=
,0.57812 -1.5156,0 -2.4062,-0.9375 -0.8907,-0.9375 -0.8907,-2.60937 0,-1.75=
 0.8907,-2.70313 0.9062,-0.96875 2.3437,-0.96875 1.3906,0 2.2656,0.9375 0.8=
75,0.9375 0.875,2.65625 0,0.10938 0,0.3125 h -5.1562 q 0.062,1.14063 0.6406=
,1.75 0.5781,0.59375 1.4375,0.59375 0.6563,0 1.1094,-0.32812 0.4531,-0.3437=
5 0.7187,-1.07813 z m -3.8437,-1.90625 h 3.8594 q -0.078,-0.85937 -0.4375,-=
1.29687 -0.5625,-0.6875 -1.4532,-0.6875 -0.8125,0 -1.3593,0.54687 -0.5469,0=
.53125 -0.6094,1.4375 z m 5.7406,4.125 2.5312,-3.59375 -2.3437,-3.3125 h 1.=
4687 l 1.0625,1.60938 q 0.2969,0.46875 0.4844,0.78125 0.2813,-0.4375 0.5156=
,-0.76563 l 1.1719,-1.625 h 1.4063 l -2.3907,3.25 2.5625,3.65625 h -1.4375 =
l -1.4218,-2.14062 -0.375,-0.59375 -1.8125,2.73437 z m 10.0078,-1.04687 0.1=
719,1.03125 q -0.5,0.10937 -0.8907,0.10937 -0.6406,0 -1,-0.20312 -0.3437,-0=
.20313 -0.4843,-0.53125 -0.1407,-0.32813 -0.1407,-1.39063 v -3.96875 h -0.8=
593 v -0.90625 h 0.8593 v -1.71875 l 1.1719,-0.70314 v 2.42189 h 1.1719 v 0=
.90625 h -1.1719 v 4.04688 q 0,0.5 0.047,0.64062 0.062,0.14063 0.2031,0.234=
38 0.1407,0.0781 0.4063,0.0781 0.2031,0 0.5156,-0.0469 z m 4.8434,1.04687 v=
 -6.90625 h 1.0625 v 0.98438 q 0.75,-1.14063 2.1875,-1.14063 0.625,0 1.1563=
,0.21875 0.5312,0.21875 0.7812,0.59375 0.2657,0.35938 0.375,0.85938 0.062,0=
.32812 0.062,1.14062 v 4.25 h -1.1718 v -4.20312 q 0,-0.71875 -0.1407,-1.06=
25 -0.1406,-0.35938 -0.4843,-0.5625 -0.3438,-0.21875 -0.8125,-0.21875 -0.75=
,0 -1.2969,0.46875 -0.5469,0.46875 -0.5469,1.79687 v 3.78125 z m 6.975,-3.4=
5312 q 0,-1.92188 1.0781,-2.84375 0.8907,-0.76563 2.1719,-0.76563 1.4219,0 =
2.3281,0.9375 0.9063,0.92188 0.9063,2.57813 0,1.32812 -0.4063,2.09375 -0.39=
06,0.76562 -1.1562,1.1875 -0.7656,0.42187 -1.6719,0.42187 -1.4531,0 -2.3594=
,-0.92187 -0.8906,-0.9375 -0.8906,-2.6875 z m 1.2031,0 q 0,1.32812 0.5782,1=
.98437 0.5937,0.65625 1.4687,0.65625 0.875,0 1.4531,-0.65625 0.5782,-0.6718=
7 0.5782,-2.03125 0,-1.28125 -0.5938,-1.9375 -0.5781,-0.65625 -1.4375,-0.65=
625 -0.875,0 -1.4687,0.65625 -0.5782,0.65625 -0.5782,1.98438 z m 11.1313,3.=
45312 v -0.875 q -0.6563,1.03125 -1.9375,1.03125 -0.8125,0 -1.5157,-0.45312=
 -0.6875,-0.45313 -1.0781,-1.26563 -0.375,-0.82812 -0.375,-1.89062 0,-1.031=
25 0.3438,-1.875 0.3437,-0.84375 1.0312,-1.28125 0.7031,-0.45313 1.5469,-0.=
45313 0.625,0 1.1094,0.26563 0.5,0.25 0.7968,0.67187 v -3.42189 h 1.1719 v =
9.54689 z m -3.7032,-3.45312 q 0,1.32812 0.5625,1.98437 0.5625,0.65625 1.32=
82,0.65625 0.7656,0 1.2968,-0.625 0.5313,-0.625 0.5313,-1.90625 0,-1.42187 =
-0.5469,-2.07812 -0.5469,-0.67188 -1.3437,-0.67188 -0.7813,0 -1.3125,0.6406=
3 -0.5157,0.625 -0.5157,2 z m 11.3656,1.23437 1.2032,0.14063 q -0.2813,1.06=
25 -1.0625,1.65625 -0.7657,0.57812 -1.9688,0.57812 -1.5156,0 -2.4062,-0.937=
5 -0.8907,-0.9375 -0.8907,-2.60937 0,-1.75 0.8907,-2.70313 0.9062,-0.96875 =
2.3437,-0.96875 1.3906,0 2.2656,0.9375 0.875,0.9375 0.875,2.65625 0,0.10938=
 0,0.3125 h -5.1562 q 0.062,1.14063 0.6406,1.75 0.5781,0.59375 1.4375,0.593=
75 0.6563,0 1.1094,-0.32812 0.4531,-0.34375 0.7187,-1.07813 z m -3.8437,-1.=
90625 h 3.8594 q -0.078,-0.85937 -0.4375,-1.29687 -0.5625,-0.6875 -1.4532,-=
0.6875 -0.8125,0 -1.3593,0.54687 -0.5469,0.53125 -0.6094,1.4375 z m 9.8967,=
-0.57812 q 0,-1.6875 0.3438,-2.71875 0.3593,-1.03125 1.0468,-1.59375 0.6875=
,-0.56252 1.7188,-0.56252 0.7812,0 1.3594,0.3125 0.5781,0.29689 0.9531,0.89=
064 0.375,0.57813 0.5937,1.42188 0.2188,0.82812 0.2188,2.25 0,1.67187 -0.35=
94,2.70312 -0.3437,1.03125 -1.0312,1.59375 -0.6719,0.5625 -1.7344,0.5625 -1=
.375,0 -2.1563,-0.98437 -0.9531,-1.1875 -0.9531,-3.875 z m 1.2031,0 q 0,2.3=
4375 0.5469,3.125 0.5625,0.78125 1.3594,0.78125 0.8125,0 1.3594,-0.78125 0.=
5625,-0.78125 0.5625,-3.125 0,-2.35938 -0.5625,-3.125 -0.5469,-0.78125 -1.3=
594,-0.78125 -0.8125,0 -1.2969,0.6875 -0.6094,0.875 -0.6094,3.21875 z m 10.=
2405,7.35937 v -9.5625 h 1.0781 v 0.89063 q 0.375,-0.53125 0.8438,-0.78125 =
0.4844,-0.26563 1.1562,-0.26563 0.875,0 1.5469,0.45313 0.6875,0.45312 1.031=
3,1.28125 0.3437,0.82812 0.3437,1.82812 0,1.04688 -0.375,1.90625 -0.375,0.8=
4375 -1.1094,1.29688 -0.7187,0.45312 -1.5312,0.45312 -0.5781,0 -1.0469,-0.2=
5 -0.4687,-0.25 -0.7656,-0.625 v 3.375 z m 1.0625,-6.07812 q 0,1.34375 0.53=
13,1.98437 0.5468,0.625 1.3125,0.625 0.7812,0 1.3437,-0.65625 0.5625,-0.656=
25 0.5625,-2.04687 0,-1.3125 -0.5469,-1.96875 -0.5468,-0.67188 -1.2968,-0.6=
7188 -0.75,0 -1.3282,0.70313 -0.5781,0.70312 -0.5781,2.03125 z m 8.9125,2.3=
75 0.1719,1.03125 q -0.5,0.10937 -0.8907,0.10937 -0.6406,0 -1,-0.20312 -0.3=
437,-0.20313 -0.4843,-0.53125 -0.1407,-0.32813 -0.1407,-1.39063 v -3.96875 =
h -0.8593 v -0.90625 h 0.8593 v -1.71875 l 1.1719,-0.70314 v 2.42189 h 1.17=
19 v 0.90625 h -1.1719 v 4.04688 q 0,0.5 0.047,0.64062 0.062,0.14063 0.2032=
,0.23438 0.1406,0.0781 0.4062,0.0781 0.2031,0 0.5156,-0.0469 z m 1.1248,1.0=
4687 v -6.90625 h 1.0625 v 1.04688 q 0.4063,-0.73438 0.7344,-0.96875 0.3437=
,-0.23438 0.7656,-0.23438 0.5938,0 1.2031,0.375 l -0.4062,1.07813 q -0.4375=
,-0.25 -0.8594,-0.25 -0.3906,0 -0.7031,0.23437 -0.2969,0.23438 -0.4219,0.64=
063 -0.2031,0.625 -0.2031,1.35937 v 3.625 z"
-       fill-rule=3D"nonzero"
-       id=3D"path322" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 707.87269,275.7978 v -9.54688 h 1.2969 l 5.0156,7.5 v -7.5 h=
 1.2031 v 9.54688 h -1.2969 l -5.0156,-7.5 v 7.5 z m 14.2189,-2.21875 1.203=
2,0.14062 q -0.2813,1.0625 -1.0625,1.65625 -0.7657,0.57813 -1.9688,0.57813 =
-1.5156,0 -2.4062,-0.9375 -0.8907,-0.9375 -0.8907,-2.60938 0,-1.75 0.8907,-=
2.70312 0.9062,-0.96875 2.3437,-0.96875 1.3906,0 2.2656,0.9375 0.875,0.9375=
 0.875,2.65625 0,0.10937 0,0.3125 h -5.1562 q 0.062,1.14062 0.6406,1.75 0.5=
781,0.59375 1.4375,0.59375 0.6563,0 1.1094,-0.32813 0.4531,-0.34375 0.7187,=
-1.07812 z m -3.8437,-1.90625 h 3.8594 q -0.078,-0.85938 -0.4375,-1.29688 -=
0.5625,-0.6875 -1.4532,-0.6875 -0.8125,0 -1.3593,0.54688 -0.5469,0.53125 -0=
.6094,1.4375 z m 5.7406,4.125 2.5312,-3.59375 -2.3437,-3.3125 h 1.4687 l 1.=
0625,1.60937 q 0.2969,0.46875 0.4844,0.78125 0.2813,-0.4375 0.5156,-0.76562=
 l 1.1719,-1.625 h 1.4063 l -2.3907,3.25 2.5625,3.65625 h -1.4375 l -1.4218=
,-2.14063 -0.375,-0.59375 -1.8125,2.73438 z m 10.0078,-1.04688 0.1719,1.031=
25 q -0.5,0.10938 -0.8907,0.10938 -0.6406,0 -1,-0.20313 -0.3437,-0.20312 -0=
.4843,-0.53125 -0.1407,-0.32812 -0.1407,-1.39062 v -3.96875 h -0.8593 v -0.=
90625 h 0.8593 v -1.71875 l 1.1719,-0.70313 v 2.42188 h 1.1719 v 0.90625 h =
-1.1719 v 4.04687 q 0,0.5 0.047,0.64063 0.062,0.14062 0.2031,0.23437 0.1407=
,0.0781 0.4063,0.0781 0.2031,0 0.5156,-0.0469 z m 4.8434,1.04688 v -6.90625=
 h 1.0625 v 0.98437 q 0.75,-1.14062 2.1875,-1.14062 0.625,0 1.1563,0.21875 =
0.5312,0.21875 0.7812,0.59375 0.2657,0.35937 0.375,0.85937 0.062,0.32813 0.=
062,1.14063 v 4.25 h -1.1718 v -4.20313 q 0,-0.71875 -0.1407,-1.0625 -0.140=
6,-0.35937 -0.4843,-0.5625 -0.3438,-0.21875 -0.8125,-0.21875 -0.75,0 -1.296=
9,0.46875 -0.5469,0.46875 -0.5469,1.79688 v 3.78125 z m 6.975,-3.45313 q 0,=
-1.92187 1.0781,-2.84375 0.8907,-0.76562 2.1719,-0.76562 1.4219,0 2.3281,0.=
9375 0.9063,0.92187 0.9063,2.57812 0,1.32813 -0.4063,2.09375 -0.3906,0.7656=
3 -1.1562,1.1875 -0.7656,0.42188 -1.6719,0.42188 -1.4531,0 -2.3594,-0.92188=
 -0.8906,-0.9375 -0.8906,-2.6875 z m 1.2031,0 q 0,1.32813 0.5782,1.98438 0.=
5937,0.65625 1.4687,0.65625 0.875,0 1.4531,-0.65625 0.5782,-0.67188 0.5782,=
-2.03125 0,-1.28125 -0.5938,-1.9375 -0.5781,-0.65625 -1.4375,-0.65625 -0.87=
5,0 -1.4687,0.65625 -0.5782,0.65625 -0.5782,1.98437 z m 11.1313,3.45313 v -=
0.875 q -0.6563,1.03125 -1.9375,1.03125 -0.8125,0 -1.5157,-0.45313 -0.6875,=
-0.45312 -1.0781,-1.26562 -0.375,-0.82813 -0.375,-1.89063 0,-1.03125 0.3438=
,-1.875 0.3437,-0.84375 1.0312,-1.28125 0.7031,-0.45312 1.5469,-0.45312 0.6=
25,0 1.1094,0.26562 0.5,0.25 0.7968,0.67188 v -3.42188 h 1.1719 v 9.54688 z=
 m -3.7032,-3.45313 q 0,1.32813 0.5625,1.98438 0.5625,0.65625 1.3282,0.6562=
5 0.7656,0 1.2968,-0.625 0.5313,-0.625 0.5313,-1.90625 0,-1.42188 -0.5469,-=
2.07813 -0.5469,-0.67187 -1.3437,-0.67187 -0.7813,0 -1.3125,0.64062 -0.5157=
,0.625 -0.5157,2 z m 11.3656,1.23438 1.2032,0.14062 q -0.2813,1.0625 -1.062=
5,1.65625 -0.7657,0.57813 -1.9688,0.57813 -1.5156,0 -2.4062,-0.9375 -0.8907=
,-0.9375 -0.8907,-2.60938 0,-1.75 0.8907,-2.70312 0.9062,-0.96875 2.3437,-0=
.96875 1.3906,0 2.2656,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125=
 h -5.1562 q 0.062,1.14062 0.6406,1.75 0.5781,0.59375 1.4375,0.59375 0.6563=
,0 1.1094,-0.32813 0.4531,-0.34375 0.7187,-1.07812 z m -3.8437,-1.90625 h 3=
.8594 q -0.078,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.4532,-0.6875 -0=
.8125,0 -1.3593,0.54688 -0.5469,0.53125 -0.6094,1.4375 z m 14.3186,4.125 h =
-1.1719 v -7.46875 q -0.4219,0.40625 -1.1094,0.8125 -0.6875,0.40625 -1.2343=
,0.60937 v -1.14062 q 0.9843,-0.45313 1.7187,-1.10938 0.7344,-0.67187 1.031=
3,-1.28125 h 0.7656 z m 7.0217,2.65625 v -9.5625 h 1.0781 v 0.89062 q 0.375=
,-0.53125 0.8438,-0.78125 0.4844,-0.26562 1.1562,-0.26562 0.875,0 1.5469,0.=
45312 0.6875,0.45313 1.0313,1.28125 0.3437,0.82813 0.3437,1.82813 0,1.04687=
 -0.375,1.90625 -0.375,0.84375 -1.1094,1.29687 -0.7187,0.45313 -1.5312,0.45=
313 -0.5781,0 -1.0469,-0.25 -0.4687,-0.25 -0.7656,-0.625 v 3.375 z m 1.0625=
,-6.07813 q 0,1.34375 0.5313,1.98438 0.5468,0.625 1.3125,0.625 0.7812,0 1.3=
437,-0.65625 0.5625,-0.65625 0.5625,-2.04688 0,-1.3125 -0.5469,-1.96875 -0.=
5468,-0.67187 -1.2968,-0.67187 -0.75,0 -1.3282,0.70312 -0.5781,0.70313 -0.5=
781,2.03125 z m 8.9125,2.375 0.1719,1.03125 q -0.5,0.10938 -0.8907,0.10938 =
-0.6406,0 -1,-0.20313 -0.3437,-0.20312 -0.4843,-0.53125 -0.1407,-0.32812 -0=
.1407,-1.39062 v -3.96875 h -0.8593 v -0.90625 h 0.8593 v -1.71875 l 1.1719=
,-0.70313 v 2.42188 h 1.1719 v 0.90625 h -1.1719 v 4.04687 q 0,0.5 0.047,0.=
64063 0.062,0.14062 0.2032,0.23437 0.1406,0.0781 0.4062,0.0781 0.2031,0 0.5=
156,-0.0469 z m 1.1248,1.04688 v -6.90625 h 1.0625 v 1.04687 q 0.4063,-0.73=
437 0.7344,-0.96875 0.3437,-0.23437 0.7656,-0.23437 0.5938,0 1.2031,0.375 l=
 -0.4062,1.07812 q -0.4375,-0.25 -0.8594,-0.25 -0.3906,0 -0.7031,0.23438 -0=
.2969,0.23437 -0.4219,0.64062 -0.2031,0.625 -0.2031,1.35938 v 3.625 z"
-       fill-rule=3D"nonzero"
-       id=3D"path324" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 707.87269,310.99465 v -9.54688 h 1.2969 l 5.0156,7.5 v -7.5 =
h 1.2031 v 9.54688 h -1.2969 l -5.0156,-7.5 v 7.5 z m 14.2189,-2.21875 1.20=
32,0.14062 q -0.2813,1.0625 -1.0625,1.65625 -0.7657,0.57813 -1.9688,0.57813=
 -1.5156,0 -2.4062,-0.9375 -0.8907,-0.9375 -0.8907,-2.60938 0,-1.75 0.8907,=
-2.70312 0.9062,-0.96875 2.3437,-0.96875 1.3906,0 2.2656,0.9375 0.875,0.937=
5 0.875,2.65625 0,0.10937 0,0.3125 h -5.1562 q 0.062,1.14062 0.6406,1.75 0.=
5781,0.59375 1.4375,0.59375 0.6563,0 1.1094,-0.32813 0.4531,-0.34375 0.7187=
,-1.07812 z m -3.8437,-1.90625 h 3.8594 q -0.078,-0.85938 -0.4375,-1.29688 =
-0.5625,-0.6875 -1.4532,-0.6875 -0.8125,0 -1.3593,0.54688 -0.5469,0.53125 -=
0.6094,1.4375 z m 5.7406,4.125 2.5312,-3.59375 -2.3437,-3.3125 h 1.4687 l 1=
.0625,1.60937 q 0.2969,0.46875 0.4844,0.78125 0.2813,-0.4375 0.5156,-0.7656=
2 l 1.1719,-1.625 h 1.4063 l -2.3907,3.25 2.5625,3.65625 h -1.4375 l -1.421=
8,-2.14063 -0.375,-0.59375 -1.8125,2.73438 z m 10.0078,-1.04688 0.1719,1.03=
125 q -0.5,0.10938 -0.8907,0.10938 -0.6406,0 -1,-0.20313 -0.3437,-0.20312 -=
0.4843,-0.53125 -0.1407,-0.32812 -0.1407,-1.39062 v -3.96875 h -0.8593 v -0=
.90625 h 0.8593 v -1.71875 l 1.1719,-0.70313 v 2.42188 h 1.1719 v 0.90625 h=
 -1.1719 v 4.04687 q 0,0.5 0.047,0.64063 0.062,0.14062 0.2031,0.23437 0.140=
7,0.0781 0.4063,0.0781 0.2031,0 0.5156,-0.0469 z m 4.8434,1.04688 v -6.9062=
5 h 1.0625 v 0.98437 q 0.75,-1.14062 2.1875,-1.14062 0.625,0 1.1563,0.21875=
 0.5312,0.21875 0.7812,0.59375 0.2657,0.35937 0.375,0.85937 0.062,0.32813 0=
.062,1.14063 v 4.25 h -1.1718 v -4.20313 q 0,-0.71875 -0.1407,-1.0625 -0.14=
06,-0.35937 -0.4843,-0.5625 -0.3438,-0.21875 -0.8125,-0.21875 -0.75,0 -1.29=
69,0.46875 -0.5469,0.46875 -0.5469,1.79688 v 3.78125 z m 6.975,-3.45313 q 0=
,-1.92187 1.0781,-2.84375 0.8907,-0.76562 2.1719,-0.76562 1.4219,0 2.3281,0=
.9375 0.9063,0.92187 0.9063,2.57812 0,1.32813 -0.4063,2.09375 -0.3906,0.765=
63 -1.1562,1.1875 -0.7656,0.42188 -1.6719,0.42188 -1.4531,0 -2.3594,-0.9218=
8 -0.8906,-0.9375 -0.8906,-2.6875 z m 1.2031,0 q 0,1.32813 0.5782,1.98438 0=
.5937,0.65625 1.4687,0.65625 0.875,0 1.4531,-0.65625 0.5782,-0.67188 0.5782=
,-2.03125 0,-1.28125 -0.5938,-1.9375 -0.5781,-0.65625 -1.4375,-0.65625 -0.8=
75,0 -1.4687,0.65625 -0.5782,0.65625 -0.5782,1.98437 z m 11.1313,3.45313 v =
-0.875 q -0.6563,1.03125 -1.9375,1.03125 -0.8125,0 -1.5157,-0.45313 -0.6875=
,-0.45312 -1.0781,-1.26562 -0.375,-0.82813 -0.375,-1.89063 0,-1.03125 0.343=
8,-1.875 0.3437,-0.84375 1.0312,-1.28125 0.7031,-0.45312 1.5469,-0.45312 0.=
625,0 1.1094,0.26562 0.5,0.25 0.7968,0.67188 v -3.42188 h 1.1719 v 9.54688 =
z m -3.7032,-3.45313 q 0,1.32813 0.5625,1.98438 0.5625,0.65625 1.3282,0.656=
25 0.7656,0 1.2968,-0.625 0.5313,-0.625 0.5313,-1.90625 0,-1.42188 -0.5469,=
-2.07813 -0.5469,-0.67187 -1.3437,-0.67187 -0.7813,0 -1.3125,0.64062 -0.515=
7,0.625 -0.5157,2 z m 11.3656,1.23438 1.2032,0.14062 q -0.2813,1.0625 -1.06=
25,1.65625 -0.7657,0.57813 -1.9688,0.57813 -1.5156,0 -2.4062,-0.9375 -0.890=
7,-0.9375 -0.8907,-2.60938 0,-1.75 0.8907,-2.70312 0.9062,-0.96875 2.3437,-=
0.96875 1.3906,0 2.2656,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.312=
5 h -5.1562 q 0.062,1.14062 0.6406,1.75 0.5781,0.59375 1.4375,0.59375 0.656=
3,0 1.1094,-0.32813 0.4531,-0.34375 0.7187,-1.07812 z m -3.8437,-1.90625 h =
3.8594 q -0.078,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.4532,-0.6875 -=
0.8125,0 -1.3593,0.54688 -0.5469,0.53125 -0.6094,1.4375 z m 16.053,3 v 1.12=
5 h -6.2969 q -0.016,-0.42188 0.1406,-0.8125 0.2344,-0.64063 0.7656,-1.2656=
3 0.5313,-0.625 1.5313,-1.45312 1.5625,-1.26563 2.1094,-2.01563 0.5468,-0.7=
5 0.5468,-1.40625 0,-0.70312 -0.5,-1.17187 -0.5,-0.48438 -1.2968,-0.48438 -=
0.8594,0 -1.375,0.51563 -0.5,0.5 -0.5,1.39062 l -1.2032,-0.10937 q 0.125,-1=
.35938 0.9219,-2.0625 0.8125,-0.70313 2.1719,-0.70313 1.375,0 2.1719,0.7656=
3 0.8125,0.75 0.8125,1.875 0,0.57812 -0.2344,1.14062 -0.2344,0.54688 -0.781=
3,1.15625 -0.5468,0.60938 -1.8125,1.67188 -1.0468,0.89062 -1.3593,1.21875 -=
0.2969,0.3125 -0.4844,0.625 z m 5.2873,3.78125 v -9.5625 h 1.0781 v 0.89062=
 q 0.375,-0.53125 0.8438,-0.78125 0.4844,-0.26562 1.1562,-0.26562 0.875,0 1=
.5469,0.45312 0.6875,0.45313 1.0313,1.28125 0.3437,0.82813 0.3437,1.82813 0=
,1.04687 -0.375,1.90625 -0.375,0.84375 -1.1094,1.29687 -0.7187,0.45313 -1.5=
312,0.45313 -0.5781,0 -1.0469,-0.25 -0.4687,-0.25 -0.7656,-0.625 v 3.375 z =
m 1.0625,-6.07813 q 0,1.34375 0.5313,1.98438 0.5468,0.625 1.3125,0.625 0.78=
12,0 1.3437,-0.65625 0.5625,-0.65625 0.5625,-2.04688 0,-1.3125 -0.5469,-1.9=
6875 -0.5468,-0.67187 -1.2968,-0.67187 -0.75,0 -1.3282,0.70312 -0.5781,0.70=
313 -0.5781,2.03125 z m 8.9125,2.375 0.1719,1.03125 q -0.5,0.10938 -0.8907,=
0.10938 -0.6406,0 -1,-0.20313 -0.3437,-0.20312 -0.4843,-0.53125 -0.1407,-0.=
32812 -0.1407,-1.39062 v -3.96875 h -0.8593 v -0.90625 h 0.8593 v -1.71875 =
l 1.1719,-0.70313 v 2.42188 h 1.1719 v 0.90625 h -1.1719 v 4.04687 q 0,0.5 =
0.047,0.64063 0.062,0.14062 0.2032,0.23437 0.1406,0.0781 0.4062,0.0781 0.20=
31,0 0.5156,-0.0469 z m 1.1248,1.04688 v -6.90625 h 1.0625 v 1.04687 q 0.40=
63,-0.73437 0.7344,-0.96875 0.3437,-0.23437 0.7656,-0.23437 0.5938,0 1.2031=
,0.375 l -0.4062,1.07812 q -0.4375,-0.25 -0.8594,-0.25 -0.3906,0 -0.7031,0.=
23438 -0.2969,0.23437 -0.4219,0.64062 -0.2031,0.625 -0.2031,1.35938 v 3.625=
 z"
-       fill-rule=3D"nonzero"
-       id=3D"path326" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 706.76639,346.19152 v -9.54687 h 1.2968 l 5.0157,7.5 v -7.5 =
h 1.2031 v 9.54687 h -1.2969 l -5.0156,-7.5 v 7.5 z m 14.2188,-2.21875 1.20=
32,0.14063 q -0.2813,1.0625 -1.0625,1.65625 -0.7657,0.57812 -1.9688,0.57812=
 -1.5156,0 -2.4062,-0.9375 -0.8907,-0.9375 -0.8907,-2.60937 0,-1.75 0.8907,=
-2.70313 0.9062,-0.96875 2.3437,-0.96875 1.3906,0 2.2656,0.9375 0.875,0.937=
5 0.875,2.65625 0,0.10938 0,0.3125 h -5.1562 q 0.062,1.14063 0.6406,1.75 0.=
5781,0.59375 1.4375,0.59375 0.6563,0 1.1094,-0.32812 0.4531,-0.34375 0.7187=
,-1.07813 z m -3.8437,-1.90625 h 3.8594 q -0.078,-0.85937 -0.4375,-1.29687 =
-0.5625,-0.6875 -1.4532,-0.6875 -0.8125,0 -1.3593,0.54687 -0.5469,0.53125 -=
0.6094,1.4375 z m 5.7406,4.125 2.5312,-3.59375 -2.3437,-3.3125 h 1.4687 l 1=
.0625,1.60938 q 0.2969,0.46875 0.4844,0.78125 0.2812,-0.4375 0.5156,-0.7656=
3 l 1.1719,-1.625 h 1.4062 l -2.3906,3.25 2.5625,3.65625 h -1.4375 l -1.421=
9,-2.14062 -0.375,-0.59375 -1.8125,2.73437 z m 10.0078,-1.04687 0.1719,1.03=
125 q -0.5,0.10937 -0.8907,0.10937 -0.6406,0 -1,-0.20312 -0.3437,-0.20313 -=
0.4843,-0.53125 -0.1407,-0.32813 -0.1407,-1.39063 v -3.96875 h -0.8593 v -0=
.90625 h 0.8593 v -1.71875 l 1.1719,-0.70312 v 2.42187 h 1.1719 v 0.90625 h=
 -1.1719 v 4.04688 q 0,0.5 0.047,0.64062 0.062,0.14063 0.2031,0.23438 0.140=
7,0.0781 0.4063,0.0781 0.2031,0 0.5156,-0.0469 z m 4.8435,1.04687 v -6.9062=
5 h 1.0625 v 0.98438 q 0.75,-1.14063 2.1875,-1.14063 0.625,0 1.1562,0.21875=
 0.5313,0.21875 0.7813,0.59375 0.2656,0.35938 0.375,0.85938 0.062,0.32812 0=
.062,1.14062 v 4.25 h -1.1719 v -4.20312 q 0,-0.71875 -0.1406,-1.0625 -0.14=
06,-0.35938 -0.4844,-0.5625 -0.3437,-0.21875 -0.8125,-0.21875 -0.75,0 -1.29=
69,0.46875 -0.5468,0.46875 -0.5468,1.79687 v 3.78125 z m 6.975,-3.45312 q 0=
,-1.92188 1.0781,-2.84375 0.8906,-0.76563 2.1719,-0.76563 1.4218,0 2.3281,0=
.9375 0.9062,0.92188 0.9062,2.57813 0,1.32812 -0.4062,2.09375 -0.3906,0.765=
62 -1.1563,1.1875 -0.7656,0.42187 -1.6718,0.42187 -1.4532,0 -2.3594,-0.9218=
7 -0.8906,-0.9375 -0.8906,-2.6875 z m 1.2031,0 q 0,1.32812 0.5781,1.98437 0=
.5938,0.65625 1.4688,0.65625 0.875,0 1.4531,-0.65625 0.5781,-0.67187 0.5781=
,-2.03125 0,-1.28125 -0.5937,-1.9375 -0.5782,-0.65625 -1.4375,-0.65625 -0.8=
75,0 -1.4688,0.65625 -0.5781,0.65625 -0.5781,1.98438 z m 11.1312,3.45312 v =
-0.875 q -0.6562,1.03125 -1.9375,1.03125 -0.8125,0 -1.5156,-0.45312 -0.6875=
,-0.45313 -1.0781,-1.26563 -0.375,-0.82812 -0.375,-1.89062 0,-1.03125 0.343=
7,-1.875 0.3438,-0.84375 1.0313,-1.28125 0.7031,-0.45313 1.5468,-0.45313 0.=
625,0 1.1094,0.26563 0.5,0.25 0.7969,0.67187 v -3.42187 h 1.1719 v 9.54687 =
z m -3.7031,-3.45312 q 0,1.32812 0.5625,1.98437 0.5625,0.65625 1.3281,0.656=
25 0.7656,0 1.2969,-0.625 0.5312,-0.625 0.5312,-1.90625 0,-1.42187 -0.5468,=
-2.07812 -0.5469,-0.67188 -1.3438,-0.67188 -0.7812,0 -1.3125,0.64063 -0.515=
6,0.625 -0.5156,2 z m 11.3656,1.23437 1.2031,0.14063 q -0.2812,1.0625 -1.06=
25,1.65625 -0.7656,0.57812 -1.9687,0.57812 -1.5157,0 -2.4063,-0.9375 -0.890=
6,-0.9375 -0.8906,-2.60937 0,-1.75 0.8906,-2.70313 0.9063,-0.96875 2.3438,-=
0.96875 1.3906,0 2.2656,0.9375 0.875,0.9375 0.875,2.65625 0,0.10938 0,0.312=
5 h -5.1563 q 0.062,1.14063 0.6407,1.75 0.5781,0.59375 1.4375,0.59375 0.656=
2,0 1.1093,-0.32812 0.4532,-0.34375 0.7188,-1.07813 z m -3.8438,-1.90625 h =
3.8594 q -0.078,-0.85937 -0.4375,-1.29687 -0.5625,-0.6875 -1.4531,-0.6875 -=
0.8125,0 -1.3594,0.54687 -0.5469,0.53125 -0.6094,1.4375 z m 10.3655,4.125 v=
 -9.54687 h 1.2969 l 5.0156,7.5 v -7.5 h 1.2031 v 9.54687 h -1.2968 l -5.01=
57,-7.5 v 7.5 z m 13.1875,2.65625 v -9.5625 h 1.0781 v 0.89063 q 0.375,-0.5=
3125 0.8438,-0.78125 0.4844,-0.26563 1.1562,-0.26563 0.875,0 1.5469,0.45313=
 0.6875,0.45312 1.0313,1.28125 0.3437,0.82812 0.3437,1.82812 0,1.04688 -0.3=
75,1.90625 -0.375,0.84375 -1.1094,1.29688 -0.7187,0.45312 -1.5312,0.45312 -=
0.5781,0 -1.0469,-0.25 -0.4687,-0.25 -0.7656,-0.625 v 3.375 z m 1.0625,-6.0=
7812 q 0,1.34375 0.5313,1.98437 0.5468,0.625 1.3125,0.625 0.7812,0 1.3437,-=
0.65625 0.5625,-0.65625 0.5625,-2.04687 0,-1.3125 -0.5469,-1.96875 -0.5468,=
-0.67188 -1.2968,-0.67188 -0.75,0 -1.3282,0.70313 -0.5781,0.70312 -0.5781,2=
.03125 z m 8.9125,2.375 0.1719,1.03125 q -0.5,0.10937 -0.8906,0.10937 -0.64=
07,0 -1,-0.20312 -0.3438,-0.20313 -0.4844,-0.53125 -0.1406,-0.32813 -0.1406=
,-1.39063 v -3.96875 h -0.8594 v -0.90625 h 0.8594 v -1.71875 l 1.1718,-0.7=
0312 v 2.42187 h 1.1719 v 0.90625 h -1.1719 v 4.04688 q 0,0.5 0.047,0.64062=
 0.062,0.14063 0.2031,0.23438 0.1407,0.0781 0.4063,0.0781 0.2031,0 0.5156,-=
0.0469 z m 1.1249,1.04687 v -6.90625 h 1.0625 v 1.04688 q 0.4062,-0.73438 0=
.7343,-0.96875 0.3438,-0.23438 0.7657,-0.23438 0.5937,0 1.2031,0.375 l -0.4=
063,1.07813 q -0.4375,-0.25 -0.8593,-0.25 -0.3907,0 -0.7032,0.23437 -0.2968=
,0.23438 -0.4218,0.64063 -0.2032,0.625 -0.2032,1.35937 v 3.625 z"
-       fill-rule=3D"nonzero"
-       id=3D"path328" />
-    <path
-       fill=3D"#000000"
-       fill-opacity=3D"0"
-       d=3D"m 637.25669,45.783637 h 230.3306 v 27.46457 h -230.3306 z"
-       fill-rule=3D"evenodd"
-       id=3D"path330" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 661.78699,67.583637 v -6.90625 h 1.0625 v 1.04687 q 0.4063,-=
0.73437 0.7344,-0.96875 0.3438,-0.23437 0.7656,-0.23437 0.5938,0 1.2032,0.3=
75 l -0.4063,1.07812 q -0.4375,-0.25 -0.8594,-0.25 -0.3906,0 -0.7031,0.2343=
8 -0.2969,0.23437 -0.4219,0.64062 -0.2031,0.625 -0.2031,1.35938 v 3.625 z m=
 7.0166,-1.04688 0.1719,1.03125 q -0.5,0.10938 -0.8907,0.10938 -0.6406,0 -1=
,-0.20313 -0.3437,-0.20312 -0.4843,-0.53125 -0.1407,-0.32812 -0.1407,-1.390=
62 v -3.96875 h -0.8593 v -0.90625 h 0.8593 v -1.71875 l 1.1719,-0.70313 v =
2.42188 h 1.1719 v 0.90625 h -1.1719 v 4.04687 q 0,0.5 0.047,0.64063 0.062,=
0.14062 0.2031,0.23437 0.1407,0.0781 0.4063,0.0781 0.2031,0 0.5156,-0.0469 =
z m 5.8748,-1.17187 1.2031,0.14062 q -0.2812,1.0625 -1.0625,1.65625 -0.7656=
,0.57813 -1.9687,0.57813 -1.5156,0 -2.4063,-0.9375 -0.8906,-0.9375 -0.8906,=
-2.60938 0,-1.75 0.8906,-2.70312 0.9063,-0.96875 2.3438,-0.96875 1.3906,0 2=
.2656,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.1562 q 0.06=
2,1.14062 0.6406,1.75 0.5781,0.59375 1.4375,0.59375 0.6562,0 1.1094,-0.3281=
3 0.4531,-0.34375 0.7187,-1.07812 z m -3.8437,-1.90625 h 3.8593 q -0.078,-0=
.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.4531,-0.6875 -0.8125,0 -1.3594,0=
.54688 -0.5468,0.53125 -0.6093,1.4375 z m 5.4437,6.78125 v -0.85938 h 7.765=
6 v 0.85938 z m 8.4906,-2.65625 v -6.90625 h 1.0625 v 0.98437 q 0.75,-1.140=
62 2.1875,-1.14062 0.625,0 1.1562,0.21875 0.5313,0.21875 0.7813,0.59375 0.2=
656,0.35937 0.375,0.85937 0.062,0.32813 0.062,1.14063 v 4.25 h -1.1719 v -4=
.20313 q 0,-0.71875 -0.1406,-1.0625 -0.1407,-0.35937 -0.4844,-0.5625 -0.343=
8,-0.21875 -0.8125,-0.21875 -0.75,0 -1.2969,0.46875 -0.5469,0.46875 -0.5469=
,1.79688 v 3.78125 z m 6.975,-3.45313 q 0,-1.92187 1.0781,-2.84375 0.8906,-=
0.76562 2.1719,-0.76562 1.4218,0 2.3281,0.9375 0.9062,0.92187 0.9062,2.5781=
2 0,1.32813 -0.4062,2.09375 -0.3906,0.76563 -1.1563,1.1875 -0.7656,0.42188 =
-1.6718,0.42188 -1.4532,0 -2.3594,-0.92188 -0.8906,-0.9375 -0.8906,-2.6875 =
z m 1.2031,0 q 0,1.32813 0.5781,1.98438 0.5938,0.65625 1.4688,0.65625 0.875=
,0 1.4531,-0.65625 0.5781,-0.67188 0.5781,-2.03125 0,-1.28125 -0.5937,-1.93=
75 -0.5782,-0.65625 -1.4375,-0.65625 -0.875,0 -1.4688,0.65625 -0.5781,0.656=
25 -0.5781,1.98437 z m 11.1312,3.45313 v -0.875 q -0.6563,1.03125 -1.9375,1=
.03125 -0.8125,0 -1.5156,-0.45313 -0.6875,-0.45312 -1.0782,-1.26562 -0.375,=
-0.82813 -0.375,-1.89063 0,-1.03125 0.3438,-1.875 0.3437,-0.84375 1.0312,-1=
.28125 0.7032,-0.45312 1.5469,-0.45312 0.625,0 1.1094,0.26562 0.5,0.25 0.79=
69,0.67188 v -3.42188 h 1.1718 v 9.54688 z m -3.7031,-3.45313 q 0,1.32813 0=
.5625,1.98438 0.5625,0.65625 1.3281,0.65625 0.7656,0 1.2969,-0.625 0.5312,-=
0.625 0.5312,-1.90625 0,-1.42188 -0.5469,-2.07813 -0.5468,-0.67187 -1.3437,=
-0.67187 -0.7813,0 -1.3125,0.64062 -0.5156,0.625 -0.5156,2 z m 11.3656,1.23=
438 1.2031,0.14062 q -0.2813,1.0625 -1.0625,1.65625 -0.7656,0.57813 -1.9688=
,0.57813 -1.5156,0 -2.4062,-0.9375 -0.8906,-0.9375 -0.8906,-2.60938 0,-1.75=
 0.8906,-2.70312 0.9062,-0.96875 2.3437,-0.96875 1.3907,0 2.2657,0.9375 0.8=
75,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.1563 q 0.062,1.14062 0.6406=
,1.75 0.5782,0.59375 1.4375,0.59375 0.6563,0 1.1094,-0.32813 0.4531,-0.3437=
5 0.7188,-1.07812 z m -3.8438,-1.90625 h 3.8594 q -0.078,-0.85938 -0.4375,-=
1.29688 -0.5625,-0.6875 -1.4531,-0.6875 -0.8125,0 -1.3594,0.54688 -0.5469,0=
.53125 -0.6094,1.4375 z m 9.7874,0.67187 q 0,-1.92187 1.0781,-2.84375 0.890=
6,-0.76562 2.1719,-0.76562 1.4219,0 2.3281,0.9375 0.9063,0.92187 0.9063,2.5=
7812 0,1.32813 -0.4063,2.09375 -0.3906,0.76563 -1.1562,1.1875 -0.7657,0.421=
88 -1.6719,0.42188 -1.4531,0 -2.3594,-0.92188 -0.8906,-0.9375 -0.8906,-2.68=
75 z m 1.2031,0 q 0,1.32813 0.5781,1.98438 0.5938,0.65625 1.4688,0.65625 0.=
875,0 1.4531,-0.65625 0.5781,-0.67188 0.5781,-2.03125 0,-1.28125 -0.5937,-1=
.9375 -0.5781,-0.65625 -1.4375,-0.65625 -0.875,0 -1.4688,0.65625 -0.5781,0.=
65625 -0.5781,1.98437 z m 7.725,3.45313 h -1.0781 v -9.54688 h 1.1718 v 3.4=
0625 q 0.7344,-0.92187 1.8907,-0.92187 0.6406,0 1.2031,0.26562 0.5781,0.25 =
0.9375,0.71875 0.375,0.45313 0.5781,1.10938 0.2031,0.65625 0.2031,1.40625 0=
,1.78125 -0.875,2.75 -0.875,0.96875 -2.1093,0.96875 -1.2188,0 -1.9219,-1.01=
563 z m 0,-3.5 q 0,1.23437 0.3281,1.78125 0.5625,0.90625 1.5,0.90625 0.7656=
,0 1.3281,-0.65625 0.5625,-0.67188 0.5625,-2 0,-1.34375 -0.5468,-1.98438 -0=
.5313,-0.65625 -1.2969,-0.65625 -0.7656,0 -1.3281,0.67188 -0.5469,0.67187 -=
0.5469,1.9375 z m 6.3343,-4.6875 v -1.35938 h 1.1719 v 1.35938 z m -1.4843,=
10.875 0.2187,-1 q 0.3594,0.0937 0.5469,0.0937 0.3594,0 0.5312,-0.25 0.1875=
,-0.23438 0.1875,-1.1875 v -7.25 h 1.1719 v 7.28125 q 0,1.28125 -0.3281,1.7=
8125 -0.4375,0.65625 -1.4063,0.65625 -0.4843,0 -0.9218,-0.125 z m 9.1798,-4=
.90625 1.2031,0.14062 q -0.2812,1.0625 -1.0625,1.65625 -0.7656,0.57813 -1.9=
687,0.57813 -1.5156,0 -2.4063,-0.9375 -0.8906,-0.9375 -0.8906,-2.60938 0,-1=
.75 0.8906,-2.70312 0.9063,-0.96875 2.3438,-0.96875 1.3906,0 2.2656,0.9375 =
0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.1562 q 0.062,1.14062 0.6=
406,1.75 0.5781,0.59375 1.4375,0.59375 0.6562,0 1.1094,-0.32813 0.4531,-0.3=
4375 0.7187,-1.07812 z m -3.8437,-1.90625 h 3.8593 q -0.078,-0.85938 -0.437=
5,-1.29688 -0.5625,-0.6875 -1.4531,-0.6875 -0.8125,0 -1.3594,0.54688 -0.546=
8,0.53125 -0.6093,1.4375 z m 11.0374,1.59375 1.1563,0.15625 q -0.1875,1.187=
5 -0.9688,1.85937 -0.7812,0.67188 -1.9218,0.67188 -1.4063,0 -2.2813,-0.9218=
8 -0.8594,-0.9375 -0.8594,-2.65625 0,-1.125 0.375,-1.96875 0.375,-0.84375 1=
.125,-1.25 0.7657,-0.42187 1.6563,-0.42187 1.125,0 1.8437,0.57812 0.7188,0.=
5625 0.9219,1.60938 l -1.1406,0.17187 q -0.1719,-0.70312 -0.5938,-1.04687 -=
0.4062,-0.35938 -0.9843,-0.35938 -0.8907,0 -1.4532,0.64063 -0.5468,0.64062 =
-0.5468,2 0,1.40625 0.5312,2.03125 0.5469,0.625 1.4063,0.625 0.6875,0 1.140=
6,-0.42188 0.4687,-0.42187 0.5937,-1.29687 z m 4.711,1.48437 0.1719,1.03125=
 q -0.5,0.10938 -0.8907,0.10938 -0.6406,0 -1,-0.20313 -0.3437,-0.20312 -0.4=
843,-0.53125 -0.1407,-0.32812 -0.1407,-1.39062 v -3.96875 h -0.8593 v -0.90=
625 h 0.8593 v -1.71875 l 1.1719,-0.70313 v 2.42188 h 1.1719 v 0.90625 h -1=
.1719 v 4.04687 q 0,0.5 0.047,0.64063 0.062,0.14062 0.2031,0.23437 0.1407,0=
.0781 0.4063,0.0781 0.2031,0 0.5156,-0.0469 z m 4.8434,1.04688 v -6.90625 h=
 1.0469 v 0.96875 q 0.3281,-0.51563 0.8594,-0.8125 0.5469,-0.3125 1.2344,-0=
.3125 0.7812,0 1.2656,0.3125 0.4844,0.3125 0.6875,0.89062 0.8281,-1.20312 2=
.1406,-1.20312 1.0313,0 1.5781,0.57812 0.5625,0.5625 0.5625,1.73438 v 4.75 =
h -1.1718 v -4.35938 q 0,-0.70312 -0.125,-1 -0.1094,-0.3125 -0.4063,-0.5 -0=
.2969,-0.1875 -0.7031,-0.1875 -0.7188,0 -1.2031,0.48438 -0.4844,0.48437 -0.=
4844,1.54687 v 4.01563 h -1.1719 v -4.48438 q 0,-0.78125 -0.2969,-1.17187 -=
0.2812,-0.39063 -0.9218,-0.39063 -0.5,0 -0.9219,0.26563 -0.4219,0.25 -0.609=
4,0.75 -0.1875,0.5 -0.1875,1.45312 v 3.57813 z m 15.8369,-2.21875 1.2031,0.=
14062 q -0.2812,1.0625 -1.0625,1.65625 -0.7656,0.57813 -1.9687,0.57813 -1.5=
157,0 -2.4063,-0.9375 -0.8906,-0.9375 -0.8906,-2.60938 0,-1.75 0.8906,-2.70=
312 0.9063,-0.96875 2.3438,-0.96875 1.3906,0 2.2656,0.9375 0.875,0.9375 0.8=
75,2.65625 0,0.10937 0,0.3125 h -5.1563 q 0.062,1.14062 0.6407,1.75 0.5781,=
0.59375 1.4375,0.59375 0.6562,0 1.1093,-0.32813 0.4532,-0.34375 0.7188,-1.0=
7812 z m -3.8438,-1.90625 h 3.8594 q -0.078,-0.85938 -0.4375,-1.29688 -0.56=
25,-0.6875 -1.4531,-0.6875 -0.8125,0 -1.3594,0.54688 -0.5469,0.53125 -0.609=
4,1.4375 z m 6.5219,4.125 v -6.90625 h 1.0469 v 0.96875 q 0.3281,-0.51563 0=
.8593,-0.8125 0.5469,-0.3125 1.2344,-0.3125 0.7813,0 1.2656,0.3125 0.4844,0=
.3125 0.6875,0.89062 0.8282,-1.20312 2.1407,-1.20312 1.0312,0 1.5781,0.5781=
2 0.5625,0.5625 0.5625,1.73438 v 4.75 h -1.1719 v -4.35938 q 0,-0.70312 -0.=
125,-1 -0.1094,-0.3125 -0.4062,-0.5 -0.2969,-0.1875 -0.7032,-0.1875 -0.7187=
,0 -1.2031,0.48438 -0.4844,0.48437 -0.4844,1.54687 v 4.01563 h -1.1718 v -4=
.48438 q 0,-0.78125 -0.2969,-1.17187 -0.2813,-0.39063 -0.9219,-0.39063 -0.5=
,0 -0.9219,0.26563 -0.4218,0.25 -0.6093,0.75 -0.1875,0.5 -0.1875,1.45312 v =
3.57813 z m 10.6649,-3.45313 q 0,-1.92187 1.0781,-2.84375 0.8907,-0.76562 2=
.1719,-0.76562 1.4219,0 2.3281,0.9375 0.9063,0.92187 0.9063,2.57812 0,1.328=
13 -0.4063,2.09375 -0.3906,0.76563 -1.1562,1.1875 -0.7656,0.42188 -1.6719,0=
.42188 -1.4531,0 -2.3594,-0.92188 -0.8906,-0.9375 -0.8906,-2.6875 z m 1.203=
1,0 q 0,1.32813 0.5782,1.98438 0.5937,0.65625 1.4687,0.65625 0.875,0 1.4531=
,-0.65625 0.5782,-0.67188 0.5782,-2.03125 0,-1.28125 -0.5938,-1.9375 -0.578=
1,-0.65625 -1.4375,-0.65625 -0.875,0 -1.4687,0.65625 -0.5782,0.65625 -0.578=
2,1.98437 z m 6.6313,3.45313 v -6.90625 h 1.0625 v 1.04687 q 0.4062,-0.7343=
7 0.7343,-0.96875 0.3438,-0.23437 0.7657,-0.23437 0.5937,0 1.2031,0.375 l -=
0.4063,1.07812 q -0.4375,-0.25 -0.8593,-0.25 -0.3907,0 -0.7032,0.23438 -0.2=
968,0.23437 -0.4218,0.64062 -0.2032,0.625 -0.2032,1.35938 v 3.625 z m 4.407=
1,2.65625 -0.125,-1.09375 q 0.375,0.10937 0.6562,0.10937 0.3906,0 0.625,-0.=
14062 0.2344,-0.125 0.3906,-0.35938 0.1094,-0.17187 0.3594,-0.875 0.031,-0.=
0937 0.1094,-0.28125 l -2.625,-6.92187 h 1.2656 l 1.4375,4 q 0.2813,0.76562=
 0.5,1.59375 0.2031,-0.79688 0.4688,-1.57813 l 1.4843,-4.01562 h 1.1719 l -=
2.625,7.01562 q -0.4219,1.14063 -0.6562,1.57813 -0.3125,0.57812 -0.7188,0.8=
4375 -0.4062,0.28125 -0.9687,0.28125 -0.3282,0 -0.75,-0.15625 z m 10.3983,-=
2.65625 v -9.54688 h 1.1718 v 9.54688 z m 7.4923,-0.85938 q -0.6563,0.5625 =
-1.2656,0.79688 -0.5938,0.21875 -1.2813,0.21875 -1.1406,0 -1.75,-0.54688 -0=
.6094,-0.5625 -0.6094,-1.4375 0,-0.5 0.2188,-0.92187 0.2344,-0.42188 0.6094=
,-0.67188 0.375,-0.25 0.8437,-0.39062 0.3438,-0.0781 1.0469,-0.17188 1.4219=
,-0.17187 2.0937,-0.40625 0,-0.23437 0,-0.29687 0,-0.71875 -0.3281,-1.01563=
 -0.4531,-0.39062 -1.3437,-0.39062 -0.8125,0 -1.2188,0.29687 -0.3906,0.2812=
5 -0.5781,1.01563 l -1.1406,-0.15625 q 0.1562,-0.73438 0.5156,-1.1875 0.359=
4,-0.45313 1.0312,-0.6875 0.6719,-0.25 1.5625,-0.25 0.8907,0 1.4375,0.20312=
 0.5625,0.20313 0.8125,0.53125 0.2657,0.3125 0.375,0.79688 0.047,0.29687 0.=
047,1.07812 v 1.5625 q 0,1.625 0.078,2.0625 0.078,0.4375 0.2969,0.82813 h -=
1.2187 q -0.1875,-0.35938 -0.2344,-0.85938 z m -0.094,-2.60937 q -0.6406,0.=
26562 -1.9219,0.4375 -0.7187,0.10937 -1.0156,0.25 -0.2969,0.125 -0.4688,0.3=
75 -0.1562,0.25 -0.1562,0.54687 0,0.46875 0.3437,0.78125 0.3594,0.3125 1.04=
69,0.3125 0.6719,0 1.2031,-0.29687 0.5313,-0.29688 0.7813,-0.8125 0.1875,-0=
.39063 0.1875,-1.17188 z m 2.9437,6.125 -0.125,-1.09375 q 0.375,0.10937 0.6=
563,0.10937 0.3906,0 0.625,-0.14062 0.2343,-0.125 0.3906,-0.35938 0.1094,-0=
.17187 0.3594,-0.875 0.031,-0.0937 0.1093,-0.28125 l -2.625,-6.92187 h 1.26=
57 l 1.4375,4 q 0.2812,0.76562 0.5,1.59375 0.2031,-0.79688 0.4687,-1.57813 =
l 1.4844,-4.01562 h 1.1719 l -2.625,7.01562 q -0.4219,1.14063 -0.6563,1.578=
13 -0.3125,0.57812 -0.7187,0.84375 -0.4063,0.28125 -0.9688,0.28125 -0.3281,=
0 -0.75,-0.15625 z m 6.2735,-6.10938 q 0,-1.92187 1.0781,-2.84375 0.8906,-0=
.76562 2.1719,-0.76562 1.4218,0 2.3281,0.9375 0.9062,0.92187 0.9062,2.57812=
 0,1.32813 -0.4062,2.09375 -0.3906,0.76563 -1.1563,1.1875 -0.7656,0.42188 -=
1.6718,0.42188 -1.4532,0 -2.3594,-0.92188 -0.8906,-0.9375 -0.8906,-2.6875 z=
 m 1.2031,0 q 0,1.32813 0.5781,1.98438 0.5938,0.65625 1.4688,0.65625 0.875,=
0 1.4531,-0.65625 0.5781,-0.67188 0.5781,-2.03125 0,-1.28125 -0.5937,-1.937=
5 -0.5782,-0.65625 -1.4375,-0.65625 -0.875,0 -1.4688,0.65625 -0.5781,0.6562=
5 -0.5781,1.98437 z m 11.1781,3.45313 v -1.01563 q -0.8125,1.17188 -2.1875,=
1.17188 -0.6094,0 -1.1406,-0.23438 -0.5313,-0.23437 -0.7969,-0.57812 -0.25,=
-0.35938 -0.3594,-0.875 -0.062,-0.34375 -0.062,-1.09375 v -4.28125 h 1.1719=
 v 3.82812 q 0,0.92188 0.062,1.23438 0.1094,0.46875 0.4687,0.73437 0.3594,0=
.25 0.8907,0.25 0.5156,0 0.9843,-0.26562 0.4688,-0.26563 0.6563,-0.73438 0.=
1875,-0.46875 0.1875,-1.34375 v -3.70312 h 1.1719 v 6.90625 z m 5.4437,-1.0=
4688 0.1719,1.03125 q -0.5,0.10938 -0.8906,0.10938 -0.6407,0 -1,-0.20313 -0=
.3438,-0.20312 -0.4844,-0.53125 -0.1406,-0.32812 -0.1406,-1.39062 v -3.9687=
5 h -0.8594 v -0.90625 h 0.8594 v -1.71875 l 1.1718,-0.70313 v 2.42188 h 1.=
1719 v 0.90625 h -1.1719 v 4.04687 q 0,0.5 0.047,0.64063 0.062,0.14062 0.20=
32,0.23437 0.1406,0.0781 0.4062,0.0781 0.2031,0 0.5156,-0.0469 z"
-       fill-rule=3D"nonzero"
-       id=3D"path332"
-       style=3D"fill:#008033" />
-    <path
-       fill=3D"#000000"
-       fill-opacity=3D"0"
-       d=3D"m 816.20809,219.40832 c 7.1841,0 13.0079,2.83072 13.0079,6.322=
6 v 53.98471 c 0,3.49188 5.8238,6.3226 13.0078,6.3226 v 0 c -7.184,0 -13.00=
78,2.83072 -13.0078,6.3226 v 53.98471 0 c 0,3.49189 -5.8238,6.32261 -13.007=
9,6.32261 z"
-       fill-rule=3D"evenodd"
-       id=3D"path334" />
-    <path
-       fill=3D"#000000"
-       fill-opacity=3D"0"
-       d=3D"m 816.20809,219.40832 c 7.1841,0 13.0079,2.83072 13.0079,6.322=
6 v 53.98471 c 0,3.49188 5.8238,6.3226 13.0078,6.3226 v 0 c -7.184,0 -13.00=
78,2.83072 -13.0078,6.3226 v 53.98471 0 c 0,3.49189 -5.8238,6.32261 -13.007=
9,6.32261"
-       fill-rule=3D"evenodd"
-       id=3D"path336" />
-    <path
-       stroke=3D"#595959"
-       stroke-width=3D"1"
-       stroke-linejoin=3D"round"
-       stroke-linecap=3D"butt"
-       d=3D"m 816.20809,219.40832 c 7.1841,0 13.0079,2.83072 13.0079,6.322=
6 v 53.98471 c 0,3.49188 5.8238,6.3226 13.0078,6.3226 v 0 c -7.184,0 -13.00=
78,2.83072 -13.0078,6.3226 v 53.98471 0 c 0,3.49189 -5.8238,6.32261 -13.007=
9,6.32261"
-       fill-rule=3D"evenodd"
-       id=3D"path338"
-       style=3D"fill:none" />
-    <path
-       fill=3D"#000000"
-       fill-opacity=3D"0"
-       d=3D"m 823.16869,253.99886 h 99.4015 v 27.46457 h -99.4015 z"
-       fill-rule=3D"evenodd"
-       id=3D"path340" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 832.96559,274.51885 v -6.21875 h 0.9375 v 0.875 q 0.6875,-1.=
01563 1.9844,-1.01563 0.5625,0 1.0312,0.20313 0.4844,0.20312 0.7188,0.53125=
 0.2343,0.32812 0.3281,0.76562 0.047,0.29688 0.047,1.03125 v 3.82813 h -1.0=
469 v -3.78125 q 0,-0.65625 -0.125,-0.96875 -0.125,-0.3125 -0.4375,-0.5 -0.=
3125,-0.20313 -0.7344,-0.20313 -0.6718,0 -1.1718,0.4375 -0.4844,0.42188 -0.=
4844,1.60938 v 3.40625 z m 7.6426,0 h -0.9844 v -8.59375 h 1.0625 v 3.0625 =
q 0.6719,-0.82813 1.7031,-0.82813 0.5781,0 1.0781,0.23438 0.5157,0.21875 0.=
8438,0.64062 0.3437,0.42188 0.5312,1.01563 0.1875,0.59375 0.1875,1.26562 0,=
1.59375 -0.7968,2.46875 -0.7969,0.875 -1.8907,0.875 -1.1093,0 -1.7343,-0.92=
187 z m -0.016,-3.15625 q 0,1.10937 0.3125,1.60937 0.5,0.8125 1.3437,0.8125=
 0.6875,0 1.1875,-0.59375 0.5157,-0.59375 0.5157,-1.79687 0,-1.21875 -0.484=
4,-1.79688 -0.4844,-0.57812 -1.1719,-0.57812 -0.6875,0 -1.2031,0.60937 -0.5=
,0.59375 -0.5,1.73438 z m 4.7363,5.54687 v -0.76562 h 7 v 0.76562 z m 11.90=
82,-4.39062 1.0938,0.125 q -0.25,0.95312 -0.9532,1.48437 -0.7031,0.53125 -1=
.7812,0.53125 -1.3594,0 -2.1719,-0.84375 -0.7969,-0.84375 -0.7969,-2.35937 =
0,-1.5625 0.8125,-2.42188 0.8125,-0.875 2.0938,-0.875 1.25,0 2.0312,0.84375=
 0.7969,0.84375 0.7969,2.39063 0,0.0937 0,0.28125 h -4.6406 q 0.062,1.03125=
 0.5781,1.57812 0.5156,0.53125 1.2969,0.53125 0.5781,0 0.9844,-0.29687 0.42=
18,-0.3125 0.6562,-0.96875 z m -3.4531,-1.70313 h 3.4687 q -0.062,-0.79687 =
-0.3906,-1.1875 -0.5156,-0.60937 -1.3125,-0.60937 -0.7344,0 -1.2344,0.48437=
 -0.4843,0.48438 -0.5312,1.3125 z m 9.9082,3.70313 v -0.78125 q -0.5938,0.9=
2187 -1.7344,0.92187 -0.75,0 -1.375,-0.40625 -0.625,-0.42187 -0.9687,-1.156=
25 -0.3438,-0.73437 -0.3438,-1.6875 0,-0.92187 0.3125,-1.6875 0.3125,-0.765=
62 0.9375,-1.15625 0.625,-0.40625 1.3906,-0.40625 0.5625,0 1,0.23438 0.4375=
,0.23437 0.7188,0.60937 v -3.07812 h 1.0469 v 8.59375 z m -3.3281,-3.10938 =
q 0,1.20313 0.5,1.79688 0.5,0.57812 1.1875,0.57812 0.6875,0 1.1718,-0.5625 =
0.4844,-0.5625 0.4844,-1.71875 0,-1.28125 -0.5,-1.875 -0.4844,-0.59375 -1.2=
031,-0.59375 -0.7031,0 -1.1719,0.57813 -0.4687,0.5625 -0.4687,1.79687 z m 5=
.7675,3.625 1.0313,0.15625 q 0.062,0.46875 0.3594,0.6875 0.3906,0.29688 1.0=
625,0.29688 0.7343,0 1.125,-0.29688 0.4062,-0.29687 0.5468,-0.8125 0.094,-0=
.32812 0.078,-1.35937 -0.6875,0.8125 -1.7187,0.8125 -1.2813,0 -1.9844,-0.92=
188 -0.7031,-0.9375 -0.7031,-2.21875 0,-0.89062 0.3125,-1.64062 0.3281,-0.7=
6563 0.9375,-1.17188 0.6093,-0.40625 1.4375,-0.40625 1.1093,0 1.8281,0.8906=
3 v -0.75 h 0.9687 v 5.375 q 0,1.45312 -0.2968,2.0625 -0.2969,0.60937 -0.93=
75,0.95312 -0.6407,0.35938 -1.5782,0.35938 -1.1093,0 -1.7968,-0.5 -0.6875,-=
0.5 -0.6719,-1.51563 z m 0.875,-3.73437 q 0,1.21875 0.4844,1.78125 0.4844,0=
.5625 1.2188,0.5625 0.7343,0 1.2187,-0.5625 0.5,-0.5625 0.5,-1.75 0,-1.1406=
3 -0.5156,-1.71875 -0.5,-0.57813 -1.2188,-0.57813 -0.7031,0 -1.2031,0.57813=
 -0.4844,0.5625 -0.4844,1.6875 z m 10.252,1.21875 1.0937,0.125 q -0.25,0.95=
312 -0.9531,1.48437 -0.7031,0.53125 -1.7812,0.53125 -1.3594,0 -2.1719,-0.84=
375 -0.7969,-0.84375 -0.7969,-2.35937 0,-1.5625 0.8125,-2.42188 0.8125,-0.8=
75 2.0938,-0.875 1.25,0 2.0312,0.84375 0.7969,0.84375 0.7969,2.39063 0,0.09=
37 0,0.28125 h -4.6406 q 0.062,1.03125 0.5781,1.57812 0.5156,0.53125 1.2969=
,0.53125 0.5781,0 0.9843,-0.29687 0.4219,-0.3125 0.6563,-0.96875 z m -3.453=
1,-1.70313 h 3.4687 q -0.062,-0.79687 -0.3906,-1.1875 -0.5156,-0.60937 -1.3=
125,-0.60937 -0.7344,0 -1.2344,0.48437 -0.4844,0.48438 -0.5312,1.3125 z m 5=
.455,1.84375 1.0313,-0.15625 q 0.094,0.625 0.4844,0.95313 0.4062,0.32812 1.=
1406,0.32812 0.7187,0 1.0625,-0.28125 0.3594,-0.29687 0.3594,-0.70312 0,-0.=
35938 -0.3125,-0.5625 -0.2188,-0.14063 -1.0782,-0.35938 -1.1562,-0.29687 -1=
.6093,-0.5 -0.4375,-0.21875 -0.6719,-0.59375 -0.2344,-0.375 -0.2344,-0.8437=
5 0,-0.40625 0.1875,-0.76562 0.1875,-0.35938 0.5156,-0.59375 0.25,-0.17188 =
0.6719,-0.29688 0.4219,-0.125 0.9219,-0.125 0.7187,0 1.2656,0.21875 0.5625,=
0.20313 0.8281,0.5625 0.2657,0.35938 0.3594,0.95313 l -1.0312,0.14062 q -0.=
062,-0.46875 -0.4063,-0.73437 -0.3281,-0.28125 -0.9531,-0.28125 -0.7188,0 -=
1.0313,0.25 -0.3125,0.23437 -0.3125,0.5625 0,0.20312 0.125,0.35937 0.1407,0=
.17188 0.4063,0.28125 0.1562,0.0625 0.9375,0.26563 1.125,0.3125 1.5625,0.5 =
0.4375,0.1875 0.6875,0.54687 0.25,0.35938 0.25,0.90625 0,0.53125 -0.3125,1 =
-0.2969,0.45313 -0.875,0.71875 -0.5781,0.25 -1.3125,0.25 -1.2188,0 -1.8594,=
-0.5 -0.625,-0.51562 -0.7969,-1.5 z"
-       fill-rule=3D"nonzero"
-       id=3D"path342" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"M 360.61488,75.514867 V 322.89017"
-       fill-rule=3D"nonzero"
-       id=3D"path344" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"M 521.53879,75.514867 V 322.89017"
-       fill-rule=3D"nonzero"
-       id=3D"path346" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"M 360.11618,76.013557 H 522.03739"
-       fill-rule=3D"nonzero"
-       id=3D"path348" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"M 360.11618,111.21041 H 522.03739"
-       fill-rule=3D"nonzero"
-       id=3D"path350" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"M 360.11618,146.40726 H 522.03739"
-       fill-rule=3D"nonzero"
-       id=3D"path352" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"M 360.11618,181.60412 H 522.03739"
-       fill-rule=3D"nonzero"
-       id=3D"path354" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"M 360.11618,216.80095 H 522.03739"
-       fill-rule=3D"nonzero"
-       id=3D"path356" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"M 360.11618,251.99782 H 522.03739"
-       fill-rule=3D"nonzero"
-       id=3D"path358" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"M 360.11618,287.19466 H 522.03739"
-       fill-rule=3D"nonzero"
-       id=3D"path360" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"M 360.11618,322.3915 H 522.03739"
-       fill-rule=3D"nonzero"
-       id=3D"path362" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 381.0367,94.751057 1.20312,-0.10938 q 0.0781,0.71875 0.39063=
,1.1875 0.3125,0.45313 0.95312,0.73438 0.65625,0.28125 1.46875,0.28125 0.71=
875,0 1.26563,-0.21875 0.5625,-0.21875 0.82812,-0.57813 0.26563,-0.375 0.26=
563,-0.82812 0,-0.45313 -0.26563,-0.78125 -0.25,-0.32813 -0.84375,-0.5625 -=
0.39062,-0.15625 -1.70312,-0.46875 -1.3125,-0.3125 -1.84375,-0.59375 -0.671=
88,-0.35938 -1.01563,-0.89063 -0.32812,-0.53125 -0.32812,-1.1875 0,-0.71875=
 0.40625,-1.34375 0.40625,-0.625 1.1875,-0.95312 0.79687,-0.32813 1.76562,-=
0.32813 1.04688,0 1.85938,0.34375 0.8125,0.34375 1.25,1.01563 0.4375,0.6562=
5 0.46875,1.48437 l -1.20313,0.0937 q -0.10937,-0.90625 -0.67187,-1.35937 -=
0.5625,-0.46875 -1.65625,-0.46875 -1.14063,0 -1.67188,0.42187 -0.51562,0.42=
188 -0.51562,1.01563 0,0.51562 0.35937,0.84375 0.375,0.32812 1.90625,0.6875=
 1.54688,0.34375 2.10938,0.59375 0.84375,0.39062 1.23437,0.98437 0.39063,0.=
57813 0.39063,1.35938 0,0.75 -0.4375,1.4375 -0.42188,0.67187 -1.25,1.04687 =
-0.8125,0.35938 -1.82813,0.35938 -1.29687,0 -2.17187,-0.375 -0.875,-0.375 -=
1.375,-1.125 -0.5,-0.76563 -0.53125,-1.71875 z m 8.73352,-0.39063 q 0,-1.92=
187 1.07813,-2.84375 0.89062,-0.76562 2.17187,-0.76562 1.42188,0 2.32813,0.=
9375 0.90625,0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.39063,0.=
76563 -1.15625,1.1875 -0.76563,0.42188 -1.67188,0.42188 -1.45312,0 -2.35937=
,-0.92188 -0.89063,-0.9375 -0.89063,-2.6875 z m 1.20313,0 q 0,1.32813 0.578=
12,1.98438 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45313,-0.65625 0.57812=
,-0.67188 0.57812,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57812,-0.65625 -1=
.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57812,0.65625 -0.57812,1.98437 =
z m 11.1781,3.45313 v -1.01563 q -0.8125,1.17188 -2.1875,1.17188 -0.60938,0=
 -1.14063,-0.23438 -0.53125,-0.23437 -0.79687,-0.57812 -0.25,-0.35938 -0.35=
938,-0.875 -0.0625,-0.34375 -0.0625,-1.09375 v -4.28125 h 1.17188 v 3.82812=
 q 0,0.92188 0.0625,1.23438 0.10937,0.46875 0.46875,0.73437 0.35937,0.25 0.=
89062,0.25 0.51563,0 0.98438,-0.26562 0.46875,-0.26563 0.65625,-0.73438 0.1=
875,-0.46875 0.1875,-1.34375 v -3.70312 h 1.17187 v 6.90625 z m 2.8656,0 v =
-6.90625 h 1.0625 v 1.04687 q 0.40625,-0.73437 0.73437,-0.96875 0.34375,-0.=
23437 0.76563,-0.23437 0.59375,0 1.20312,0.375 l -0.40625,1.07812 q -0.4375=
,-0.25 -0.85937,-0.25 -0.39063,0 -0.70313,0.23438 -0.29687,0.23437 -0.42187=
,0.64062 -0.20313,0.625 -0.20313,1.35938 v 3.625 z m 8.9696,-2.53125 1.1562=
5,0.15625 q -0.1875,1.1875 -0.96875,1.85937 -0.78125,0.67188 -1.92187,0.671=
88 -1.40625,0 -2.28125,-0.92188 -0.85938,-0.9375 -0.85938,-2.65625 0,-1.125=
 0.375,-1.96875 0.375,-0.84375 1.125,-1.25 0.76563,-0.42187 1.65625,-0.4218=
7 1.125,0 1.84375,0.57812 0.71875,0.5625 0.92188,1.60938 l -1.14063,0.17187=
 q -0.17187,-0.70312 -0.59375,-1.04687 -0.40625,-0.35938 -0.98437,-0.35938 =
-0.89063,0 -1.45313,0.64063 -0.54687,0.64062 -0.54687,2 0,1.40625 0.53125,2=
.03125 0.54687,0.625 1.40625,0.625 0.6875,0 1.14062,-0.42188 0.46875,-0.421=
87 0.59375,-1.29687 z m 6.88281,0.3125 1.20313,0.14062 q -0.28125,1.0625 -1=
.0625,1.65625 -0.76563,0.57813 -1.96875,0.57813 -1.51563,0 -2.40625,-0.9375=
 -0.89063,-0.9375 -0.89063,-2.60938 0,-1.75 0.89063,-2.70312 0.90625,-0.968=
75 2.34375,-0.96875 1.39062,0 2.26562,0.9375 0.875,0.9375 0.875,2.65625 0,0=
.10937 0,0.3125 h -5.15625 q 0.0625,1.14062 0.64063,1.75 0.57812,0.59375 1.=
4375,0.59375 0.65625,0 1.10937,-0.32813 0.45313,-0.34375 0.71875,-1.07812 z=
 m -3.84375,-1.90625 h 3.85938 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625,=
-0.6875 -1.45313,-0.6875 -0.8125,0 -1.35937,0.54688 -0.54688,0.53125 -0.609=
38,1.4375 z m 10.36548,4.125 v -9.54688 h 1.29688 l 5.01562,7.5 v -7.5 h 1.=
20313 v 9.54688 h -1.29688 l -5.01562,-7.5 v 7.5 z m 9.04703,-3.45313 q 0,-=
1.92187 1.07813,-2.84375 0.89062,-0.76562 2.17187,-0.76562 1.42188,0 2.3281=
3,0.9375 0.90625,0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.3906=
3,0.76563 -1.15625,1.1875 -0.76563,0.42188 -1.67188,0.42188 -1.45312,0 -2.3=
5937,-0.92188 -0.89063,-0.9375 -0.89063,-2.6875 z m 1.20313,0 q 0,1.32813 0=
.57812,1.98438 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45313,-0.65625 0.5=
7812,-0.67188 0.57812,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57812,-0.6562=
5 -1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57812,0.65625 -0.57812,1.98=
437 z m 11.13122,3.45313 v -0.875 q -0.65625,1.03125 -1.9375,1.03125 -0.812=
5,0 -1.51562,-0.45313 -0.6875,-0.45312 -1.07813,-1.26562 -0.375,-0.82813 -0=
.375,-1.89063 0,-1.03125 0.34375,-1.875 0.34375,-0.84375 1.03125,-1.28125 0=
.70313,-0.45312 1.54688,-0.45312 0.625,0 1.10937,0.26562 0.5,0.25 0.79688,0=
.67188 v -3.42188 h 1.17187 v 9.54688 z m -3.70312,-3.45313 q 0,1.32813 0.5=
625,1.98438 0.5625,0.65625 1.32812,0.65625 0.76563,0 1.29688,-0.625 0.53125=
,-0.625 0.53125,-1.90625 0,-1.42188 -0.54688,-2.07813 -0.54687,-0.67187 -1.=
34375,-0.67187 -0.78125,0 -1.3125,0.64062 -0.51562,0.625 -0.51562,2 z m 11.=
3656,1.23438 1.20312,0.14062 q -0.28125,1.0625 -1.0625,1.65625 -0.76562,0.5=
7813 -1.96875,0.57813 -1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375 -0.89062=
,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.3906=
3,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.15625=
 q 0.0625,1.14062 0.64062,1.75 0.57813,0.59375 1.4375,0.59375 0.65625,0 1.1=
0938,-0.32813 0.45312,-0.34375 0.71875,-1.07812 z m -3.84375,-1.90625 h 3.8=
5937 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.45312,-0.6875 -=
0.8125,0 -1.35938,0.54688 -0.54687,0.53125 -0.60937,1.4375 z m 6.19372,-0.5=
7813 q 0,-1.6875 0.34375,-2.71875 0.35938,-1.03125 1.04688,-1.59375 0.6875,=
-0.5625 1.71875,-0.5625 0.78125,0 1.35937,0.3125 0.57813,0.29688 0.95313,0.=
89063 0.375,0.57812 0.59375,1.42187 0.21875,0.82813 0.21875,2.25 0,1.67188 =
-0.35938,2.70313 -0.34375,1.03125 -1.03125,1.59375 -0.67187,0.5625 -1.73437=
,0.5625 -1.375,0 -2.15625,-0.98438 -0.95313,-1.1875 -0.95313,-3.875 z m 1.2=
0313,0 q 0,2.34375 0.54687,3.125 0.5625,0.78125 1.35938,0.78125 0.8125,0 1.=
35937,-0.78125 0.5625,-0.78125 0.5625,-3.125 0,-2.35937 -0.5625,-3.125 -0.5=
4687,-0.78125 -1.35937,-0.78125 -0.8125,0 -1.29688,0.6875 -0.60937,0.875 -0=
.60937,3.21875 z m 9.80295,1.25 q 0,-1.92187 1.07812,-2.84375 0.89063,-0.76=
562 2.17188,-0.76562 1.42187,0 2.32812,0.9375 0.90625,0.92187 0.90625,2.578=
12 0,1.32813 -0.40625,2.09375 -0.39062,0.76563 -1.15625,1.1875 -0.76562,0.4=
2188 -1.67187,0.42188 -1.45313,0 -2.35938,-0.92188 -0.89062,-0.9375 -0.8906=
2,-2.6875 z m 1.20312,0 q 0,1.32813 0.57813,1.98438 0.59375,0.65625 1.46875=
,0.65625 0.875,0 1.45312,-0.65625 0.57813,-0.67188 0.57813,-2.03125 0,-1.28=
125 -0.59375,-1.9375 -0.57813,-0.65625 -1.4375,-0.65625 -0.875,0 -1.46875,0=
.65625 -0.57813,0.65625 -0.57813,1.98437 z m 6.9281,3.45313 v -6 h -1.03125=
 v -0.90625 h 1.03125 v -0.73438 q 0,-0.70312 0.125,-1.04687 0.17188,-0.453=
13 0.59375,-0.73438 0.42188,-0.28125 1.20313,-0.28125 0.48437,0 1.09375,0.1=
0938 l -0.1875,1.03125 q -0.35938,-0.0625 -0.6875,-0.0625 -0.53125,0 -0.75,=
0.23437 -0.21875,0.21875 -0.21875,0.84375 v 0.64063 h 1.34375 v 0.90625 h -=
1.34375 v 6 z m 3.4621,0 v -6 h -1.03125 v -0.90625 h 1.03125 v -0.73438 q =
0,-0.70312 0.125,-1.04687 0.17187,-0.45313 0.59375,-0.73438 0.42187,-0.2812=
5 1.20312,-0.28125 0.48438,0 1.09375,0.10938 l -0.1875,1.03125 q -0.35937,-=
0.0625 -0.6875,-0.0625 -0.53125,0 -0.75,0.23437 -0.21875,0.21875 -0.21875,0=
.84375 v 0.64063 h 1.34375 v 0.90625 h -1.34375 v 6 z m 2.953,-2.0625 1.156=
25,-0.1875 q 0.10938,0.70312 0.54688,1.07812 0.45312,0.35938 1.25,0.35938 0=
.8125,0 1.20312,-0.32813 0.39063,-0.32812 0.39063,-0.76562 0,-0.39063 -0.35=
938,-0.625 -0.23437,-0.15625 -1.1875,-0.39063 -1.29687,-0.32812 -1.79687,-0=
.5625 -0.48438,-0.25 -0.75,-0.65625 -0.25,-0.42187 -0.25,-0.9375 0,-0.45312=
 0.20312,-0.84375 0.21875,-0.40625 0.57813,-0.67187 0.28125,-0.1875 0.75,-0=
.32813 0.46875,-0.14062 1.01562,-0.14062 0.8125,0 1.42188,0.23437 0.60937,0=
.23438 0.90625,0.64063 0.29687,0.39062 0.40625,1.0625 l -1.14063,0.15625 q =
-0.0781,-0.53125 -0.45312,-0.82813 -0.375,-0.3125 -1.0625,-0.3125 -0.8125,0=
 -1.15625,0.26563 -0.34375,0.26562 -0.34375,0.625 0,0.23437 0.14062,0.42187=
 0.15625,0.1875 0.45313,0.3125 0.17187,0.0625 1.03125,0.29688 1.25,0.32812 =
1.73437,0.54687 0.5,0.20313 0.78125,0.60938 0.28125,0.40625 0.28125,1 0,0.5=
9375 -0.34375,1.10937 -0.34375,0.51563 -1,0.79688 -0.64062,0.28125 -1.45312=
,0.28125 -1.34375,0 -2.04688,-0.5625 -0.70312,-0.5625 -0.90625,-1.65625 z m=
 11.86719,-0.15625 1.20312,0.14062 q -0.28125,1.0625 -1.0625,1.65625 -0.765=
62,0.57813 -1.96875,0.57813 -1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375 -0=
.89062,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-0.96875 2.34375,-0.96875 =
1.39063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5=
.15625 q 0.0625,1.14062 0.64062,1.75 0.57813,0.59375 1.4375,0.59375 0.65625=
,0 1.10938,-0.32813 0.45312,-0.34375 0.71875,-1.07812 z m -3.84375,-1.90625=
 h 3.85937 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.45312,-0.=
6875 -0.8125,0 -1.35938,0.54688 -0.54687,0.53125 -0.60937,1.4375 z m 9.0843=
5,3.07812 0.17188,1.03125 q -0.5,0.10938 -0.89063,0.10938 -0.64062,0 -1,-0.=
20313 -0.34375,-0.20312 -0.48437,-0.53125 -0.14063,-0.32812 -0.14063,-1.390=
62 v -3.96875 h -0.85937 v -0.90625 h 0.85937 v -1.71875 l 1.17188,-0.70313=
 v 2.42188 h 1.17187 v 0.90625 h -1.17187 v 4.04687 q 0,0.5 0.0469,0.64063 =
0.0625,0.14062 0.20313,0.23437 0.14062,0.0781 0.40625,0.0781 0.20312,0 0.51=
562,-0.0469 z"
-       fill-rule=3D"nonzero"
-       id=3D"path364" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 381.0367,129.94791 1.20312,-0.10938 q 0.0781,0.71875 0.39063=
,1.1875 0.3125,0.45313 0.95312,0.73438 0.65625,0.28125 1.46875,0.28125 0.71=
875,0 1.26563,-0.21875 0.5625,-0.21875 0.82812,-0.57813 0.26563,-0.375 0.26=
563,-0.82812 0,-0.45313 -0.26563,-0.78125 -0.25,-0.32813 -0.84375,-0.5625 -=
0.39062,-0.15625 -1.70312,-0.46875 -1.3125,-0.3125 -1.84375,-0.59375 -0.671=
88,-0.35938 -1.01563,-0.89063 -0.32812,-0.53125 -0.32812,-1.1875 0,-0.71875=
 0.40625,-1.34375 0.40625,-0.625 1.1875,-0.95312 0.79687,-0.32813 1.76562,-=
0.32813 1.04688,0 1.85938,0.34375 0.8125,0.34375 1.25,1.01563 0.4375,0.6562=
5 0.46875,1.48437 l -1.20313,0.0937 q -0.10937,-0.90625 -0.67187,-1.35937 -=
0.5625,-0.46875 -1.65625,-0.46875 -1.14063,0 -1.67188,0.42187 -0.51562,0.42=
188 -0.51562,1.01563 0,0.51562 0.35937,0.84375 0.375,0.32812 1.90625,0.6875=
 1.54688,0.34375 2.10938,0.59375 0.84375,0.39062 1.23437,0.98437 0.39063,0.=
57813 0.39063,1.35938 0,0.75 -0.4375,1.4375 -0.42188,0.67187 -1.25,1.04687 =
-0.8125,0.35938 -1.82813,0.35938 -1.29687,0 -2.17187,-0.375 -0.875,-0.375 -=
1.375,-1.125 -0.5,-0.76563 -0.53125,-1.71875 z m 8.73352,-0.39063 q 0,-1.92=
187 1.07813,-2.84375 0.89062,-0.76562 2.17187,-0.76562 1.42188,0 2.32813,0.=
9375 0.90625,0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.39063,0.=
76563 -1.15625,1.1875 -0.76563,0.42188 -1.67188,0.42188 -1.45312,0 -2.35937=
,-0.92188 -0.89063,-0.9375 -0.89063,-2.6875 z m 1.20313,0 q 0,1.32813 0.578=
12,1.98438 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45313,-0.65625 0.57812=
,-0.67188 0.57812,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57812,-0.65625 -1=
.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57812,0.65625 -0.57812,1.98437 =
z m 11.1781,3.45313 v -1.01563 q -0.8125,1.17188 -2.1875,1.17188 -0.60938,0=
 -1.14063,-0.23438 -0.53125,-0.23437 -0.79687,-0.57812 -0.25,-0.35938 -0.35=
938,-0.875 -0.0625,-0.34375 -0.0625,-1.09375 v -4.28125 h 1.17188 v 3.82812=
 q 0,0.92188 0.0625,1.23438 0.10937,0.46875 0.46875,0.73437 0.35937,0.25 0.=
89062,0.25 0.51563,0 0.98438,-0.26562 0.46875,-0.26563 0.65625,-0.73438 0.1=
875,-0.46875 0.1875,-1.34375 v -3.70312 h 1.17187 v 6.90625 z m 2.8656,0 v =
-6.90625 h 1.0625 v 1.04687 q 0.40625,-0.73437 0.73437,-0.96875 0.34375,-0.=
23437 0.76563,-0.23437 0.59375,0 1.20312,0.375 l -0.40625,1.07812 q -0.4375=
,-0.25 -0.85937,-0.25 -0.39063,0 -0.70313,0.23438 -0.29687,0.23437 -0.42187=
,0.64062 -0.20313,0.625 -0.20313,1.35938 v 3.625 z m 8.9696,-2.53125 1.1562=
5,0.15625 q -0.1875,1.1875 -0.96875,1.85937 -0.78125,0.67188 -1.92187,0.671=
88 -1.40625,0 -2.28125,-0.92188 -0.85938,-0.9375 -0.85938,-2.65625 0,-1.125=
 0.375,-1.96875 0.375,-0.84375 1.125,-1.25 0.76563,-0.42187 1.65625,-0.4218=
7 1.125,0 1.84375,0.57812 0.71875,0.5625 0.92188,1.60938 l -1.14063,0.17187=
 q -0.17187,-0.70312 -0.59375,-1.04687 -0.40625,-0.35938 -0.98437,-0.35938 =
-0.89063,0 -1.45313,0.64063 -0.54687,0.64062 -0.54687,2 0,1.40625 0.53125,2=
.03125 0.54687,0.625 1.40625,0.625 0.6875,0 1.14062,-0.42188 0.46875,-0.421=
87 0.59375,-1.29687 z m 6.88281,0.3125 1.20313,0.14062 q -0.28125,1.0625 -1=
.0625,1.65625 -0.76563,0.57813 -1.96875,0.57813 -1.51563,0 -2.40625,-0.9375=
 -0.89063,-0.9375 -0.89063,-2.60938 0,-1.75 0.89063,-2.70312 0.90625,-0.968=
75 2.34375,-0.96875 1.39062,0 2.26562,0.9375 0.875,0.9375 0.875,2.65625 0,0=
.10937 0,0.3125 h -5.15625 q 0.0625,1.14062 0.64063,1.75 0.57812,0.59375 1.=
4375,0.59375 0.65625,0 1.10937,-0.32813 0.45313,-0.34375 0.71875,-1.07812 z=
 m -3.84375,-1.90625 h 3.85938 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625,=
-0.6875 -1.45313,-0.6875 -0.8125,0 -1.35937,0.54688 -0.54688,0.53125 -0.609=
38,1.4375 z m 10.36548,4.125 v -9.54688 h 1.29688 l 5.01562,7.5 v -7.5 h 1.=
20313 v 9.54688 h -1.29688 l -5.01562,-7.5 v 7.5 z m 9.04703,-3.45313 q 0,-=
1.92187 1.07813,-2.84375 0.89062,-0.76562 2.17187,-0.76562 1.42188,0 2.3281=
3,0.9375 0.90625,0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.3906=
3,0.76563 -1.15625,1.1875 -0.76563,0.42188 -1.67188,0.42188 -1.45312,0 -2.3=
5937,-0.92188 -0.89063,-0.9375 -0.89063,-2.6875 z m 1.20313,0 q 0,1.32813 0=
.57812,1.98438 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45313,-0.65625 0.5=
7812,-0.67188 0.57812,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57812,-0.6562=
5 -1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57812,0.65625 -0.57812,1.98=
437 z m 11.13122,3.45313 v -0.875 q -0.65625,1.03125 -1.9375,1.03125 -0.812=
5,0 -1.51562,-0.45313 -0.6875,-0.45312 -1.07813,-1.26562 -0.375,-0.82813 -0=
.375,-1.89063 0,-1.03125 0.34375,-1.875 0.34375,-0.84375 1.03125,-1.28125 0=
.70313,-0.45312 1.54688,-0.45312 0.625,0 1.10937,0.26562 0.5,0.25 0.79688,0=
.67188 v -3.42188 h 1.17187 v 9.54688 z m -3.70312,-3.45313 q 0,1.32813 0.5=
625,1.98438 0.5625,0.65625 1.32812,0.65625 0.76563,0 1.29688,-0.625 0.53125=
,-0.625 0.53125,-1.90625 0,-1.42188 -0.54688,-2.07813 -0.54687,-0.67187 -1.=
34375,-0.67187 -0.78125,0 -1.3125,0.64062 -0.51562,0.625 -0.51562,2 z m 11.=
3656,1.23438 1.20312,0.14062 q -0.28125,1.0625 -1.0625,1.65625 -0.76562,0.5=
7813 -1.96875,0.57813 -1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375 -0.89062=
,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.3906=
3,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.15625=
 q 0.0625,1.14062 0.64062,1.75 0.57813,0.59375 1.4375,0.59375 0.65625,0 1.1=
0938,-0.32813 0.45312,-0.34375 0.71875,-1.07812 z m -3.84375,-1.90625 h 3.8=
5937 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.45312,-0.6875 -=
0.8125,0 -1.35938,0.54688 -0.54687,0.53125 -0.60937,1.4375 z m 10.6156,4.12=
5 h -1.17188 v -7.46875 q -0.42187,0.40625 -1.10937,0.8125 -0.6875,0.40625 =
-1.23438,0.60937 v -1.14062 q 0.98438,-0.45313 1.71875,-1.10938 0.73438,-0.=
67187 1.03125,-1.28125 h 0.76563 z m 6.5842,-3.45313 q 0,-1.92187 1.07812,-=
2.84375 0.89063,-0.76562 2.17188,-0.76562 1.42187,0 2.32812,0.9375 0.90625,=
0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.39062,0.76563 -1.1562=
5,1.1875 -0.76562,0.42188 -1.67187,0.42188 -1.45313,0 -2.35938,-0.92188 -0.=
89062,-0.9375 -0.89062,-2.6875 z m 1.20312,0 q 0,1.32813 0.57813,1.98438 0.=
59375,0.65625 1.46875,0.65625 0.875,0 1.45312,-0.65625 0.57813,-0.67188 0.5=
7813,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57813,-0.65625 -1.4375,-0.6562=
5 -0.875,0 -1.46875,0.65625 -0.57813,0.65625 -0.57813,1.98437 z m 6.9281,3.=
45313 v -6 h -1.03125 v -0.90625 h 1.03125 v -0.73438 q 0,-0.70312 0.125,-1=
.04687 0.17188,-0.45313 0.59375,-0.73438 0.42188,-0.28125 1.20313,-0.28125 =
0.48437,0 1.09375,0.10938 l -0.1875,1.03125 q -0.35938,-0.0625 -0.6875,-0.0=
625 -0.53125,0 -0.75,0.23437 -0.21875,0.21875 -0.21875,0.84375 v 0.64063 h =
1.34375 v 0.90625 h -1.34375 v 6 z m 3.4621,0 v -6 h -1.03125 v -0.90625 h =
1.03125 v -0.73438 q 0,-0.70312 0.125,-1.04687 0.17187,-0.45313 0.59375,-0.=
73438 0.42187,-0.28125 1.20312,-0.28125 0.48438,0 1.09375,0.10938 l -0.1875=
,1.03125 q -0.35937,-0.0625 -0.6875,-0.0625 -0.53125,0 -0.75,0.23437 -0.218=
75,0.21875 -0.21875,0.84375 v 0.64063 h 1.34375 v 0.90625 h -1.34375 v 6 z =
m 2.953,-2.0625 1.15625,-0.1875 q 0.10938,0.70312 0.54688,1.07812 0.45312,0=
.35938 1.25,0.35938 0.8125,0 1.20312,-0.32813 0.39063,-0.32812 0.39063,-0.7=
6562 0,-0.39063 -0.35938,-0.625 -0.23437,-0.15625 -1.1875,-0.39063 -1.29687=
,-0.32812 -1.79687,-0.5625 -0.48438,-0.25 -0.75,-0.65625 -0.25,-0.42187 -0.=
25,-0.9375 0,-0.45312 0.20312,-0.84375 0.21875,-0.40625 0.57813,-0.67187 0.=
28125,-0.1875 0.75,-0.32813 0.46875,-0.14062 1.01562,-0.14062 0.8125,0 1.42=
188,0.23437 0.60937,0.23438 0.90625,0.64063 0.29687,0.39062 0.40625,1.0625 =
l -1.14063,0.15625 q -0.0781,-0.53125 -0.45312,-0.82813 -0.375,-0.3125 -1.0=
625,-0.3125 -0.8125,0 -1.15625,0.26563 -0.34375,0.26562 -0.34375,0.625 0,0.=
23437 0.14062,0.42187 0.15625,0.1875 0.45313,0.3125 0.17187,0.0625 1.03125,=
0.29688 1.25,0.32812 1.73437,0.54687 0.5,0.20313 0.78125,0.60938 0.28125,0.=
40625 0.28125,1 0,0.59375 -0.34375,1.10937 -0.34375,0.51563 -1,0.79688 -0.6=
4062,0.28125 -1.45312,0.28125 -1.34375,0 -2.04688,-0.5625 -0.70312,-0.5625 =
-0.90625,-1.65625 z m 11.86719,-0.15625 1.20312,0.14062 q -0.28125,1.0625 -=
1.0625,1.65625 -0.76562,0.57813 -1.96875,0.57813 -1.51562,0 -2.40625,-0.937=
5 -0.89062,-0.9375 -0.89062,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-0.96=
875 2.34375,-0.96875 1.39063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,=
0.10937 0,0.3125 h -5.15625 q 0.0625,1.14062 0.64062,1.75 0.57813,0.59375 1=
.4375,0.59375 0.65625,0 1.10938,-0.32813 0.45312,-0.34375 0.71875,-1.07812 =
z m -3.84375,-1.90625 h 3.85937 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625=
,-0.6875 -1.45312,-0.6875 -0.8125,0 -1.35938,0.54688 -0.54687,0.53125 -0.60=
937,1.4375 z m 9.08435,3.07812 0.17188,1.03125 q -0.5,0.10938 -0.89063,0.10=
938 -0.64062,0 -1,-0.20313 -0.34375,-0.20312 -0.48437,-0.53125 -0.14063,-0.=
32812 -0.14063,-1.39062 v -3.96875 h -0.85937 v -0.90625 h 0.85937 v -1.718=
75 l 1.17188,-0.70313 v 2.42188 h 1.17187 v 0.90625 h -1.17187 v 4.04687 q =
0,0.5 0.0469,0.64063 0.0625,0.14062 0.20313,0.23437 0.14062,0.0781 0.40625,=
0.0781 0.20312,0 0.51562,-0.0469 z"
-       fill-rule=3D"nonzero"
-       id=3D"path366" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 378.07888,165.14477 1.20313,-0.10938 q 0.0781,0.71875 0.3906=
2,1.1875 0.3125,0.45313 0.95313,0.73438 0.65625,0.28125 1.46875,0.28125 0.7=
1875,0 1.26562,-0.21875 0.5625,-0.21875 0.82813,-0.57813 0.26562,-0.375 0.2=
6562,-0.82812 0,-0.45313 -0.26562,-0.78125 -0.25,-0.32813 -0.84375,-0.5625 =
-0.39063,-0.15625 -1.70313,-0.46875 -1.3125,-0.3125 -1.84375,-0.59375 -0.67=
187,-0.35938 -1.01562,-0.89063 -0.32813,-0.53125 -0.32813,-1.1875 0,-0.7187=
5 0.40625,-1.34375 0.40625,-0.625 1.1875,-0.95312 0.79688,-0.32813 1.76563,=
-0.32813 1.04687,0 1.85937,0.34375 0.8125,0.34375 1.25,1.01563 0.4375,0.656=
25 0.46875,1.48437 l -1.20312,0.0937 q -0.10938,-0.90625 -0.67188,-1.35937 =
-0.5625,-0.46875 -1.65625,-0.46875 -1.14062,0 -1.67187,0.42187 -0.51563,0.4=
2188 -0.51563,1.01563 0,0.51562 0.35938,0.84375 0.375,0.32812 1.90625,0.687=
5 1.54687,0.34375 2.10937,0.59375 0.84375,0.39062 1.23438,0.98437 0.39062,0=
.57813 0.39062,1.35938 0,0.75 -0.4375,1.4375 -0.42187,0.67187 -1.25,1.04687=
 -0.8125,0.35938 -1.82812,0.35938 -1.29688,0 -2.17188,-0.375 -0.875,-0.375 =
-1.375,-1.125 -0.5,-0.76563 -0.53125,-1.71875 z m 8.73352,-0.39063 q 0,-1.9=
2187 1.07813,-2.84375 0.89062,-0.76562 2.17187,-0.76562 1.42188,0 2.32813,0=
.9375 0.90625,0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.39063,0=
.76563 -1.15625,1.1875 -0.76563,0.42188 -1.67188,0.42188 -1.45312,0 -2.3593=
7,-0.92188 -0.89063,-0.9375 -0.89063,-2.6875 z m 1.20313,0 q 0,1.32813 0.57=
812,1.98438 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45313,-0.65625 0.5781=
2,-0.67188 0.57812,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57812,-0.65625 -=
1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57812,0.65625 -0.57812,1.98437=
 z m 11.1781,3.45313 v -1.01563 q -0.8125,1.17188 -2.1875,1.17188 -0.60938,=
0 -1.14063,-0.23438 -0.53125,-0.23437 -0.79687,-0.57812 -0.25,-0.35938 -0.3=
5938,-0.875 -0.0625,-0.34375 -0.0625,-1.09375 v -4.28125 h 1.17188 v 3.8281=
2 q 0,0.92188 0.0625,1.23438 0.10937,0.46875 0.46875,0.73437 0.35937,0.25 0=
.89062,0.25 0.51563,0 0.98438,-0.26562 0.46875,-0.26563 0.65625,-0.73438 0.=
1875,-0.46875 0.1875,-1.34375 v -3.70312 h 1.17187 v 6.90625 z m 2.8656,0 v=
 -6.90625 h 1.0625 v 1.04687 q 0.40625,-0.73437 0.73437,-0.96875 0.34375,-0=
.23437 0.76563,-0.23437 0.59375,0 1.20312,0.375 l -0.40625,1.07812 q -0.437=
5,-0.25 -0.85937,-0.25 -0.39063,0 -0.70313,0.23438 -0.29687,0.23437 -0.4218=
7,0.64062 -0.20313,0.625 -0.20313,1.35938 v 3.625 z m 8.9696,-2.53125 1.156=
25,0.15625 q -0.1875,1.1875 -0.96875,1.85937 -0.78125,0.67188 -1.92187,0.67=
188 -1.40625,0 -2.28125,-0.92188 -0.85938,-0.9375 -0.85938,-2.65625 0,-1.12=
5 0.375,-1.96875 0.375,-0.84375 1.125,-1.25 0.76563,-0.42187 1.65625,-0.421=
87 1.125,0 1.84375,0.57812 0.71875,0.5625 0.92188,1.60938 l -1.14063,0.1718=
7 q -0.17187,-0.70312 -0.59375,-1.04687 -0.40625,-0.35938 -0.98437,-0.35938=
 -0.89063,0 -1.45313,0.64063 -0.54687,0.64062 -0.54687,2 0,1.40625 0.53125,=
2.03125 0.54687,0.625 1.40625,0.625 0.6875,0 1.14062,-0.42188 0.46875,-0.42=
187 0.59375,-1.29687 z m 6.88281,0.3125 1.20313,0.14062 q -0.28125,1.0625 -=
1.0625,1.65625 -0.76563,0.57813 -1.96875,0.57813 -1.51563,0 -2.40625,-0.937=
5 -0.89063,-0.9375 -0.89063,-2.60938 0,-1.75 0.89063,-2.70312 0.90625,-0.96=
875 2.34375,-0.96875 1.39062,0 2.26562,0.9375 0.875,0.9375 0.875,2.65625 0,=
0.10937 0,0.3125 h -5.15625 q 0.0625,1.14062 0.64063,1.75 0.57812,0.59375 1=
.4375,0.59375 0.65625,0 1.10937,-0.32813 0.45313,-0.34375 0.71875,-1.07812 =
z m -3.84375,-1.90625 h 3.85938 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625=
,-0.6875 -1.45313,-0.6875 -0.8125,0 -1.35937,0.54688 -0.54688,0.53125 -0.60=
938,1.4375 z m 10.36548,4.125 v -9.54688 h 1.29688 l 5.01562,7.5 v -7.5 h 1=
.20313 v 9.54688 h -1.29688 l -5.01562,-7.5 v 7.5 z m 9.04703,-3.45313 q 0,=
-1.92187 1.07813,-2.84375 0.89062,-0.76562 2.17187,-0.76562 1.42188,0 2.328=
13,0.9375 0.90625,0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.390=
63,0.76563 -1.15625,1.1875 -0.76563,0.42188 -1.67188,0.42188 -1.45312,0 -2.=
35937,-0.92188 -0.89063,-0.9375 -0.89063,-2.6875 z m 1.20313,0 q 0,1.32813 =
0.57812,1.98438 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45313,-0.65625 0.=
57812,-0.67188 0.57812,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57812,-0.656=
25 -1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57812,0.65625 -0.57812,1.9=
8437 z m 11.13122,3.45313 v -0.875 q -0.65625,1.03125 -1.9375,1.03125 -0.81=
25,0 -1.51562,-0.45313 -0.6875,-0.45312 -1.07813,-1.26562 -0.375,-0.82813 -=
0.375,-1.89063 0,-1.03125 0.34375,-1.875 0.34375,-0.84375 1.03125,-1.28125 =
0.70313,-0.45312 1.54688,-0.45312 0.625,0 1.10937,0.26562 0.5,0.25 0.79688,=
0.67188 v -3.42188 h 1.17187 v 9.54688 z m -3.70312,-3.45313 q 0,1.32813 0.=
5625,1.98438 0.5625,0.65625 1.32812,0.65625 0.76563,0 1.29688,-0.625 0.5312=
5,-0.625 0.53125,-1.90625 0,-1.42188 -0.54688,-2.07813 -0.54687,-0.67187 -1=
.34375,-0.67187 -0.78125,0 -1.3125,0.64062 -0.51562,0.625 -0.51562,2 z m 11=
.3656,1.23438 1.20312,0.14062 q -0.28125,1.0625 -1.0625,1.65625 -0.76562,0.=
57813 -1.96875,0.57813 -1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375 -0.8906=
2,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.390=
63,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.1562=
5 q 0.0625,1.14062 0.64062,1.75 0.57813,0.59375 1.4375,0.59375 0.65625,0 1.=
10938,-0.32813 0.45312,-0.34375 0.71875,-1.07812 z m -3.84375,-1.90625 h 3.=
85937 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.45312,-0.6875 =
-0.8125,0 -1.35938,0.54688 -0.54687,0.53125 -0.60937,1.4375 z m 10.36545,4.=
125 v -9.54688 h 1.29687 l 5.01563,7.5 v -7.5 h 1.20312 v 9.54688 h -1.2968=
7 l -5.01563,-7.5 v 7.5 z m 12.75003,-3.45313 q 0,-1.92187 1.07812,-2.84375=
 0.89063,-0.76562 2.17188,-0.76562 1.42187,0 2.32812,0.9375 0.90625,0.92187=
 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.39062,0.76563 -1.15625,1.187=
5 -0.76562,0.42188 -1.67187,0.42188 -1.45313,0 -2.35938,-0.92188 -0.89062,-=
0.9375 -0.89062,-2.6875 z m 1.20312,0 q 0,1.32813 0.57813,1.98438 0.59375,0=
.65625 1.46875,0.65625 0.875,0 1.45312,-0.65625 0.57813,-0.67188 0.57813,-2=
.03125 0,-1.28125 -0.59375,-1.9375 -0.57813,-0.65625 -1.4375,-0.65625 -0.87=
5,0 -1.46875,0.65625 -0.57813,0.65625 -0.57813,1.98437 z m 6.9281,3.45313 v=
 -6 h -1.03125 v -0.90625 h 1.03125 v -0.73438 q 0,-0.70312 0.125,-1.04687 =
0.17188,-0.45313 0.59375,-0.73438 0.42188,-0.28125 1.20313,-0.28125 0.48437=
,0 1.09375,0.10938 l -0.1875,1.03125 q -0.35938,-0.0625 -0.6875,-0.0625 -0.=
53125,0 -0.75,0.23437 -0.21875,0.21875 -0.21875,0.84375 v 0.64063 h 1.34375=
 v 0.90625 h -1.34375 v 6 z m 3.4621,0 v -6 h -1.03125 v -0.90625 h 1.03125=
 v -0.73438 q 0,-0.70312 0.125,-1.04687 0.17187,-0.45313 0.59375,-0.73438 0=
.42187,-0.28125 1.20312,-0.28125 0.48438,0 1.09375,0.10938 l -0.1875,1.0312=
5 q -0.35937,-0.0625 -0.6875,-0.0625 -0.53125,0 -0.75,0.23437 -0.21875,0.21=
875 -0.21875,0.84375 v 0.64063 h 1.34375 v 0.90625 h -1.34375 v 6 z m 2.952=
97,-2.0625 1.15625,-0.1875 q 0.10938,0.70312 0.54688,1.07812 0.45312,0.3593=
8 1.25,0.35938 0.8125,0 1.20312,-0.32813 0.39063,-0.32812 0.39063,-0.76562 =
0,-0.39063 -0.35938,-0.625 -0.23437,-0.15625 -1.1875,-0.39063 -1.29687,-0.3=
2812 -1.79687,-0.5625 -0.48438,-0.25 -0.75,-0.65625 -0.25,-0.42187 -0.25,-0=
.9375 0,-0.45312 0.20312,-0.84375 0.21875,-0.40625 0.57813,-0.67187 0.28125=
,-0.1875 0.75,-0.32813 0.46875,-0.14062 1.01562,-0.14062 0.8125,0 1.42188,0=
.23437 0.60937,0.23438 0.90625,0.64063 0.29687,0.39062 0.40625,1.0625 l -1.=
14063,0.15625 q -0.0781,-0.53125 -0.45312,-0.82813 -0.375,-0.3125 -1.0625,-=
0.3125 -0.8125,0 -1.15625,0.26563 -0.34375,0.26562 -0.34375,0.625 0,0.23437=
 0.14062,0.42187 0.15625,0.1875 0.45313,0.3125 0.17187,0.0625 1.03125,0.296=
88 1.25,0.32812 1.73437,0.54687 0.5,0.20313 0.78125,0.60938 0.28125,0.40625=
 0.28125,1 0,0.59375 -0.34375,1.10937 -0.34375,0.51563 -1,0.79688 -0.64062,=
0.28125 -1.45312,0.28125 -1.34375,0 -2.04688,-0.5625 -0.70312,-0.5625 -0.90=
625,-1.65625 z m 11.86719,-0.15625 1.20312,0.14062 q -0.28125,1.0625 -1.062=
5,1.65625 -0.76562,0.57813 -1.96875,0.57813 -1.51562,0 -2.40625,-0.9375 -0.=
89062,-0.9375 -0.89062,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-0.96875 2=
.34375,-0.96875 1.39063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,0.109=
37 0,0.3125 h -5.15625 q 0.0625,1.14062 0.64062,1.75 0.57813,0.59375 1.4375=
,0.59375 0.65625,0 1.10938,-0.32813 0.45312,-0.34375 0.71875,-1.07812 z m -=
3.84375,-1.90625 h 3.85937 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625,-0.6=
875 -1.45312,-0.6875 -0.8125,0 -1.35938,0.54688 -0.54687,0.53125 -0.60937,1=
.4375 z m 9.08435,3.07812 0.17185,1.03125 q -0.49998,0.10938 -0.8906,0.1093=
8 -0.64063,0 -1,-0.20313 -0.34375,-0.20312 -0.48438,-0.53125 -0.14062,-0.32=
812 -0.14062,-1.39062 v -3.96875 h -0.85938 v -0.90625 h 0.85938 v -1.71875=
 l 1.17187,-0.70313 v 2.42188 h 1.17188 v 0.90625 h -1.17188 v 4.04687 q 0,=
0.5 0.0469,0.64063 0.0625,0.14062 0.20312,0.23437 0.14063,0.0781 0.40625,0.=
0781 0.20313,0 0.51563,-0.0469 z"
-       fill-rule=3D"nonzero"
-       id=3D"path368" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 374.07084,203.4041 v -9.54688 h 6.90625 v 1.125 h -5.64062 v=
 2.92188 h 5.28125 v 1.125 h -5.28125 v 3.25 h 5.85937 v 1.125 z m 8.71787,=
0 v -6.90625 h 1.0625 v 0.98437 q 0.75,-1.14062 2.1875,-1.14062 0.625,0 1.1=
5625,0.21875 0.53125,0.21875 0.78125,0.59375 0.26562,0.35937 0.375,0.85937 =
0.0625,0.32813 0.0625,1.14063 v 4.25 h -1.17188 v -4.20313 q 0,-0.71875 -0.=
14062,-1.0625 -0.14063,-0.35937 -0.48438,-0.5625 -0.34375,-0.21875 -0.8125,=
-0.21875 -0.75,0 -1.29687,0.46875 -0.54688,0.46875 -0.54688,1.79688 v 3.781=
25 z m 11.81872,2.65625 v -3.39063 q -0.26562,0.39063 -0.76562,0.64063 -0.4=
8438,0.25 -1.04688,0.25 -1.21875,0 -2.10937,-0.98438 -0.89063,-0.98437 -0.8=
9063,-2.6875 0,-1.04687 0.35938,-1.875 0.35937,-0.82812 1.04687,-1.25 0.687=
5,-0.42187 1.51563,-0.42187 1.28125,0 2.01562,1.07812 v -0.92187 h 1.04688 =
v 9.5625 z m -3.60937,-6.125 q 0,1.32812 0.5625,2 0.5625,0.65625 1.34375,0.=
65625 0.75,0 1.28125,-0.625 0.54687,-0.64063 0.54687,-1.9375 0,-1.375 -0.57=
812,-2.0625 -0.5625,-0.70313 -1.32813,-0.70313 -0.76562,0 -1.29687,0.65625 =
-0.53125,0.64063 -0.53125,2.01563 z m 11.14685,3.46875 v -1.01563 q -0.8125=
,1.17188 -2.1875,1.17188 -0.60938,0 -1.14063,-0.23438 -0.53125,-0.23437 -0.=
79687,-0.57812 -0.25,-0.35938 -0.35938,-0.875 -0.0625,-0.34375 -0.0625,-1.0=
9375 v -4.28125 h 1.17188 v 3.82812 q 0,0.92188 0.0625,1.23438 0.10937,0.46=
875 0.46875,0.73437 0.35937,0.25 0.89062,0.25 0.51563,0 0.98438,-0.26562 0.=
46875,-0.26563 0.65625,-0.73438 0.1875,-0.46875 0.1875,-1.34375 v -3.70312 =
h 1.17187 v 6.90625 z m 7.6156,-2.21875 1.20312,0.14062 q -0.28125,1.0625 -=
1.0625,1.65625 -0.76562,0.57813 -1.96875,0.57813 -1.51562,0 -2.40625,-0.937=
5 -0.89062,-0.9375 -0.89062,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-0.96=
875 2.34375,-0.96875 1.39063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,=
0.10937 0,0.3125 h -5.15625 q 0.0625,1.14062 0.64062,1.75 0.57813,0.59375 1=
.4375,0.59375 0.65625,0 1.10938,-0.32813 0.45312,-0.34375 0.71875,-1.07812 =
z m -3.84375,-1.90625 h 3.85937 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625=
,-0.6875 -1.45312,-0.6875 -0.8125,0 -1.35938,0.54688 -0.54687,0.53125 -0.60=
937,1.4375 z m 11.0531,4.125 v -1.01563 q -0.8125,1.17188 -2.1875,1.17188 -=
0.60938,0 -1.14063,-0.23438 -0.53125,-0.23437 -0.79687,-0.57812 -0.25,-0.35=
938 -0.35938,-0.875 -0.0625,-0.34375 -0.0625,-1.09375 v -4.28125 h 1.17188 =
v 3.82812 q 0,0.92188 0.0625,1.23438 0.10937,0.46875 0.46875,0.73437 0.3593=
7,0.25 0.89062,0.25 0.51563,0 0.98438,-0.26562 0.46875,-0.26563 0.65625,-0.=
73438 0.1875,-0.46875 0.1875,-1.34375 v -3.70312 h 1.17187 v 6.90625 z m 7.=
6156,-2.21875 1.20312,0.14062 q -0.28125,1.0625 -1.0625,1.65625 -0.76562,0.=
57813 -1.96875,0.57813 -1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375 -0.8906=
2,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.390=
63,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.1562=
5 q 0.0625,1.14062 0.64062,1.75 0.57813,0.59375 1.4375,0.59375 0.65625,0 1.=
10938,-0.32813 0.45312,-0.34375 0.71875,-1.07812 z m -3.84375,-1.90625 h 3.=
85937 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.45312,-0.6875 =
-0.8125,0 -1.35938,0.54688 -0.54687,0.53125 -0.60937,1.4375 z m 10.36548,4.=
125 v -9.54688 h 1.29687 l 5.01563,7.5 v -7.5 h 1.20312 v 9.54688 h -1.2968=
7 l -5.01563,-7.5 v 7.5 z m 9.04703,-3.45313 q 0,-1.92187 1.07812,-2.84375 =
0.89063,-0.76562 2.17188,-0.76562 1.42187,0 2.32812,0.9375 0.90625,0.92187 =
0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.39062,0.76563 -1.15625,1.1875=
 -0.76562,0.42188 -1.67187,0.42188 -1.45313,0 -2.35938,-0.92188 -0.89062,-0=
.9375 -0.89062,-2.6875 z m 1.20312,0 q 0,1.32813 0.57813,1.98438 0.59375,0.=
65625 1.46875,0.65625 0.875,0 1.45312,-0.65625 0.57813,-0.67188 0.57813,-2.=
03125 0,-1.28125 -0.59375,-1.9375 -0.57813,-0.65625 -1.4375,-0.65625 -0.875=
,0 -1.46875,0.65625 -0.57813,0.65625 -0.57813,1.98437 z m 11.13123,3.45313 =
v -0.875 q -0.65625,1.03125 -1.9375,1.03125 -0.8125,0 -1.51563,-0.45313 -0.=
6875,-0.45312 -1.07812,-1.26562 -0.375,-0.82813 -0.375,-1.89063 0,-1.03125 =
0.34375,-1.875 0.34375,-0.84375 1.03125,-1.28125 0.70312,-0.45312 1.54687,-=
0.45312 0.625,0 1.10938,0.26562 0.5,0.25 0.79687,0.67188 v -3.42188 h 1.171=
88 v 9.54688 z m -3.70313,-3.45313 q 0,1.32813 0.5625,1.98438 0.5625,0.6562=
5 1.32813,0.65625 0.76562,0 1.29687,-0.625 0.53125,-0.625 0.53125,-1.90625 =
0,-1.42188 -0.54687,-2.07813 -0.54688,-0.67187 -1.34375,-0.67187 -0.78125,0=
 -1.3125,0.64062 -0.51563,0.625 -0.51563,2 z m 11.3656,1.23438 1.20313,0.14=
062 q -0.28125,1.0625 -1.0625,1.65625 -0.76563,0.57813 -1.96875,0.57813 -1.=
51563,0 -2.40625,-0.9375 -0.89063,-0.9375 -0.89063,-2.60938 0,-1.75 0.89063=
,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.39062,0 2.26562,0.9375 0.875,=
0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.15625 q 0.0625,1.14062 0.64063=
,1.75 0.57812,0.59375 1.4375,0.59375 0.65625,0 1.10937,-0.32813 0.45313,-0.=
34375 0.71875,-1.07812 z m -3.84375,-1.90625 h 3.85938 q -0.0781,-0.85938 -=
0.4375,-1.29688 -0.5625,-0.6875 -1.45313,-0.6875 -0.8125,0 -1.35937,0.54688=
 -0.54688,0.53125 -0.60938,1.4375 z m 9.8967,-0.57813 q 0,-1.6875 0.34375,-=
2.71875 0.35938,-1.03125 1.04688,-1.59375 0.6875,-0.5625 1.71875,-0.5625 0.=
78125,0 1.35937,0.3125 0.57813,0.29688 0.95313,0.89063 0.375,0.57812 0.5937=
5,1.42187 0.21875,0.82813 0.21875,2.25 0,1.67188 -0.35938,2.70313 -0.34375,=
1.03125 -1.03125,1.59375 -0.67187,0.5625 -1.73437,0.5625 -1.375,0 -2.15625,=
-0.98438 -0.95313,-1.1875 -0.95313,-3.875 z m 1.20313,0 q 0,2.34375 0.54687=
,3.125 0.5625,0.78125 1.35938,0.78125 0.8125,0 1.35937,-0.78125 0.5625,-0.7=
8125 0.5625,-3.125 0,-2.35937 -0.5625,-3.125 -0.54687,-0.78125 -1.35937,-0.=
78125 -0.8125,0 -1.29688,0.6875 -0.60937,0.875 -0.60937,3.21875 z m 9.80297=
,1.25 q 0,-1.92187 1.07813,-2.84375 0.89062,-0.76562 2.17187,-0.76562 1.421=
88,0 2.32813,0.9375 0.90625,0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.09=
375 -0.39063,0.76563 -1.15625,1.1875 -0.76563,0.42188 -1.67188,0.42188 -1.4=
5312,0 -2.35937,-0.92188 -0.89063,-0.9375 -0.89063,-2.6875 z m 1.20313,0 q =
0,1.32813 0.57812,1.98438 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45313,-=
0.65625 0.57812,-0.67188 0.57812,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57=
812,-0.65625 -1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57812,0.65625 -0=
.57812,1.98437 z m 6.9281,3.45313 v -6 h -1.03125 v -0.90625 h 1.03125 v -0=
.73438 q 0,-0.70312 0.125,-1.04687 0.17187,-0.45313 0.59375,-0.73438 0.4218=
7,-0.28125 1.20312,-0.28125 0.48438,0 1.09375,0.10938 l -0.1875,1.03125 q -=
0.35937,-0.0625 -0.6875,-0.0625 -0.53125,0 -0.75,0.23437 -0.21875,0.21875 -=
0.21875,0.84375 v 0.64063 h 1.34375 v 0.90625 h -1.34375 v 6 z m 3.4621,0 v=
 -6 h -1.03125 v -0.90625 h 1.03125 v -0.73438 q 0,-0.70312 0.125,-1.04687 =
0.17187,-0.45313 0.59375,-0.73438 0.42187,-0.28125 1.20312,-0.28125 0.48438=
,0 1.09375,0.10938 l -0.1875,1.03125 q -0.35937,-0.0625 -0.6875,-0.0625 -0.=
53125,0 -0.75,0.23437 -0.21875,0.21875 -0.21875,0.84375 v 0.64063 h 1.34375=
 v 0.90625 h -1.34375 v 6 z m 2.95297,-2.0625 1.15625,-0.1875 q 0.10937,0.7=
0312 0.54687,1.07812 0.45313,0.35938 1.25,0.35938 0.8125,0 1.20313,-0.32813=
 0.39062,-0.32812 0.39062,-0.76562 0,-0.39063 -0.35937,-0.625 -0.23438,-0.1=
5625 -1.1875,-0.39063 -1.29688,-0.32812 -1.79688,-0.5625 -0.48437,-0.25 -0.=
75,-0.65625 -0.25,-0.42187 -0.25,-0.9375 0,-0.45312 0.20313,-0.84375 0.2187=
5,-0.40625 0.57812,-0.67187 0.28125,-0.1875 0.75,-0.32813 0.46875,-0.14062 =
1.01563,-0.14062 0.8125,0 1.42187,0.23437 0.60938,0.23438 0.90625,0.64063 0=
.29688,0.39062 0.40625,1.0625 l -1.14062,0.15625 q -0.0781,-0.53125 -0.4531=
3,-0.82813 -0.375,-0.3125 -1.0625,-0.3125 -0.8125,0 -1.15625,0.26563 -0.343=
75,0.26562 -0.34375,0.625 0,0.23437 0.14063,0.42187 0.15625,0.1875 0.45312,=
0.3125 0.17188,0.0625 1.03125,0.29688 1.25,0.32812 1.73438,0.54687 0.5,0.20=
313 0.78125,0.60938 0.28125,0.40625 0.28125,1 0,0.59375 -0.34375,1.10937 -0=
.34375,0.51563 -1,0.79688 -0.64063,0.28125 -1.45313,0.28125 -1.34375,0 -2.0=
4687,-0.5625 -0.70313,-0.5625 -0.90625,-1.65625 z m 11.86719,-0.15625 1.203=
11,0.14062 q -0.2812,1.0625 -1.06249,1.65625 -0.76562,0.57813 -1.96875,0.57=
813 -1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375 -0.89062,-2.60938 0,-1.75 =
0.89062,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.39063,0 2.26563,0.9375=
 0.87501,0.9375 0.87501,2.65625 0,0.10937 0,0.3125 h -5.15626 q 0.0625,1.14=
062 0.64062,1.75 0.57813,0.59375 1.4375,0.59375 0.65625,0 1.10938,-0.32813 =
0.45312,-0.34375 0.71875,-1.07812 z m -3.84375,-1.90625 h 3.85937 q -0.0781=
,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.45312,-0.6875 -0.8125,0 -1.35=
938,0.54688 -0.54687,0.53125 -0.60937,1.4375 z m 9.08436,3.07812 0.1719,1.0=
3125 q -0.5,0.10938 -0.8907,0.10938 -0.6406,0 -1,-0.20313 -0.3437,-0.20312 =
-0.4843,-0.53125 -0.1407,-0.32812 -0.1407,-1.39062 v -3.96875 h -0.8593 v -=
0.90625 h 0.8593 v -1.71875 l 1.1719,-0.70313 v 2.42188 h 1.1719 v 0.90625 =
h -1.1719 v 4.04687 q 0,0.5 0.047,0.64063 0.062,0.14062 0.2031,0.23437 0.14=
07,0.0781 0.4063,0.0781 0.2031,0 0.5156,-0.0469 z"
-       fill-rule=3D"nonzero"
-       id=3D"path370" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 374.07084,238.60097 v -9.54689 h 6.90625 v 1.125 h -5.64062 =
v 2.92189 h 5.28125 v 1.125 h -5.28125 v 3.25 h 5.85937 v 1.125 z m 8.71787=
,0 v -6.90625 h 1.0625 v 0.98438 q 0.75,-1.14063 2.1875,-1.14063 0.625,0 1.=
15625,0.21875 0.53125,0.21875 0.78125,0.59375 0.26562,0.35938 0.375,0.85938=
 0.0625,0.32812 0.0625,1.14062 v 4.25 h -1.17188 v -4.20312 q 0,-0.71875 -0=
.14062,-1.0625 -0.14063,-0.35938 -0.48438,-0.5625 -0.34375,-0.21875 -0.8125=
,-0.21875 -0.75,0 -1.29687,0.46875 -0.54688,0.46875 -0.54688,1.79687 v 3.78=
125 z m 11.81872,2.65625 v -3.39062 q -0.26562,0.39062 -0.76562,0.64062 -0.=
48438,0.25 -1.04688,0.25 -1.21875,0 -2.10937,-0.98437 -0.89063,-0.98438 -0.=
89063,-2.6875 0,-1.04688 0.35938,-1.875 0.35937,-0.82813 1.04687,-1.25 0.68=
75,-0.42188 1.51563,-0.42188 1.28125,0 2.01562,1.07813 v -0.92188 h 1.04688=
 v 9.5625 z m -3.60937,-6.125 q 0,1.32813 0.5625,2 0.5625,0.65625 1.34375,0=
.65625 0.75,0 1.28125,-0.625 0.54687,-0.64062 0.54687,-1.9375 0,-1.375 -0.5=
7812,-2.0625 -0.5625,-0.70312 -1.32813,-0.70312 -0.76562,0 -1.29687,0.65625=
 -0.53125,0.64062 -0.53125,2.01562 z m 11.14685,3.46875 v -1.01562 q -0.812=
5,1.17187 -2.1875,1.17187 -0.60938,0 -1.14063,-0.23437 -0.53125,-0.23438 -0=
.79687,-0.57813 -0.25,-0.35937 -0.35938,-0.875 -0.0625,-0.34375 -0.0625,-1.=
09375 v -4.28125 h 1.17188 v 3.82813 q 0,0.92187 0.0625,1.23437 0.10937,0.4=
6875 0.46875,0.73438 0.35937,0.25 0.89062,0.25 0.51563,0 0.98438,-0.26563 0=
.46875,-0.26562 0.65625,-0.73437 0.1875,-0.46875 0.1875,-1.34375 v -3.70313=
 h 1.17187 v 6.90625 z m 7.6156,-2.21875 1.20312,0.14063 q -0.28125,1.0625 =
-1.0625,1.65625 -0.76562,0.57812 -1.96875,0.57812 -1.51562,0 -2.40625,-0.93=
75 -0.89062,-0.9375 -0.89062,-2.60937 0,-1.75 0.89062,-2.70313 0.90625,-0.9=
6875 2.34375,-0.96875 1.39063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0=
,0.10938 0,0.3125 h -5.15625 q 0.0625,1.14063 0.64062,1.75 0.57813,0.59375 =
1.4375,0.59375 0.65625,0 1.10938,-0.32812 0.45312,-0.34375 0.71875,-1.07813=
 z m -3.84375,-1.90625 h 3.85937 q -0.0781,-0.85937 -0.4375,-1.29687 -0.562=
5,-0.6875 -1.45312,-0.6875 -0.8125,0 -1.35938,0.54687 -0.54687,0.53125 -0.6=
0937,1.4375 z m 11.0531,4.125 v -1.01562 q -0.8125,1.17187 -2.1875,1.17187 =
-0.60938,0 -1.14063,-0.23437 -0.53125,-0.23438 -0.79687,-0.57813 -0.25,-0.3=
5937 -0.35938,-0.875 -0.0625,-0.34375 -0.0625,-1.09375 v -4.28125 h 1.17188=
 v 3.82813 q 0,0.92187 0.0625,1.23437 0.10937,0.46875 0.46875,0.73438 0.359=
37,0.25 0.89062,0.25 0.51563,0 0.98438,-0.26563 0.46875,-0.26562 0.65625,-0=
.73437 0.1875,-0.46875 0.1875,-1.34375 v -3.70313 h 1.17187 v 6.90625 z m 7=
.6156,-2.21875 1.20312,0.14063 q -0.28125,1.0625 -1.0625,1.65625 -0.76562,0=
.57812 -1.96875,0.57812 -1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375 -0.890=
62,-2.60937 0,-1.75 0.89062,-2.70313 0.90625,-0.96875 2.34375,-0.96875 1.39=
063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,0.10938 0,0.3125 h -5.156=
25 q 0.0625,1.14063 0.64062,1.75 0.57813,0.59375 1.4375,0.59375 0.65625,0 1=
.10938,-0.32812 0.45312,-0.34375 0.71875,-1.07813 z m -3.84375,-1.90625 h 3=
.85937 q -0.0781,-0.85937 -0.4375,-1.29687 -0.5625,-0.6875 -1.45312,-0.6875=
 -0.8125,0 -1.35938,0.54687 -0.54687,0.53125 -0.60937,1.4375 z m 10.36548,4=
.125 v -9.54689 h 1.29687 l 5.01563,7.50002 v -7.50002 h 1.20312 v 9.54689 =
h -1.29687 l -5.01563,-7.50002 v 7.50002 z m 9.04703,-3.45312 q 0,-1.92188 =
1.07812,-2.84375 0.89063,-0.76563 2.17188,-0.76563 1.42187,0 2.32812,0.9375=
 0.90625,0.92188 0.90625,2.57813 0,1.32812 -0.40625,2.09375 -0.39062,0.7656=
2 -1.15625,1.1875 -0.76562,0.42187 -1.67187,0.42187 -1.45313,0 -2.35938,-0.=
92187 -0.89062,-0.9375 -0.89062,-2.6875 z m 1.20312,0 q 0,1.32812 0.57813,1=
.98437 0.59375,0.65625 1.46875,0.65625 0.875,0 1.45312,-0.65625 0.57813,-0.=
67187 0.57813,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57813,-0.65625 -1.437=
5,-0.65625 -0.875,0 -1.46875,0.65625 -0.57813,0.65625 -0.57813,1.98438 z m =
11.13123,3.45312 v -0.875 q -0.65625,1.03125 -1.9375,1.03125 -0.8125,0 -1.5=
1563,-0.45312 -0.6875,-0.45313 -1.07812,-1.26563 -0.375,-0.82812 -0.375,-1.=
89062 0,-1.03125 0.34375,-1.875 0.34375,-0.84375 1.03125,-1.28125 0.70312,-=
0.45313 1.54687,-0.45313 0.625,0 1.10938,0.26563 0.5,0.25 0.79687,0.67187 v=
 -3.42189 h 1.17188 v 9.54689 z m -3.70313,-3.45312 q 0,1.32812 0.5625,1.98=
437 0.5625,0.65625 1.32813,0.65625 0.76562,0 1.29687,-0.625 0.53125,-0.625 =
0.53125,-1.90625 0,-1.42187 -0.54687,-2.07812 -0.54688,-0.67188 -1.34375,-0=
.67188 -0.78125,0 -1.3125,0.64063 -0.51563,0.625 -0.51563,2 z m 11.3656,1.2=
3437 1.20313,0.14063 q -0.28125,1.0625 -1.0625,1.65625 -0.76563,0.57812 -1.=
96875,0.57812 -1.51563,0 -2.40625,-0.9375 -0.89063,-0.9375 -0.89063,-2.6093=
7 0,-1.75 0.89063,-2.70313 0.90625,-0.96875 2.34375,-0.96875 1.39062,0 2.26=
562,0.9375 0.875,0.9375 0.875,2.65625 0,0.10938 0,0.3125 h -5.15625 q 0.062=
5,1.14063 0.64063,1.75 0.57812,0.59375 1.4375,0.59375 0.65625,0 1.10937,-0.=
32812 0.45313,-0.34375 0.71875,-1.07813 z m -3.84375,-1.90625 h 3.85938 q -=
0.0781,-0.85937 -0.4375,-1.29687 -0.5625,-0.6875 -1.45313,-0.6875 -0.8125,0=
 -1.35937,0.54687 -0.54688,0.53125 -0.60938,1.4375 z m 14.31858,4.125 h -1.=
17188 v -7.46877 q -0.42187,0.40627 -1.10937,0.81252 -0.6875,0.40625 -1.234=
38,0.60937 v -1.14064 q 0.98438,-0.45312 1.71875,-1.10937 0.73438,-0.67188 =
1.03125,-1.28125 h 0.76563 z m 6.58422,-3.45312 q 0,-1.92188 1.07813,-2.843=
75 0.89062,-0.76563 2.17187,-0.76563 1.42188,0 2.32813,0.9375 0.90625,0.921=
88 0.90625,2.57813 0,1.32812 -0.40625,2.09375 -0.39063,0.76562 -1.15625,1.1=
875 -0.76563,0.42187 -1.67188,0.42187 -1.45312,0 -2.35937,-0.92187 -0.89063=
,-0.9375 -0.89063,-2.6875 z m 1.20313,0 q 0,1.32812 0.57812,1.98437 0.59375=
,0.65625 1.46875,0.65625 0.875,0 1.45313,-0.65625 0.57812,-0.67187 0.57812,=
-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57812,-0.65625 -1.4375,-0.65625 -0.=
875,0 -1.46875,0.65625 -0.57812,0.65625 -0.57812,1.98438 z m 6.9281,3.45312=
 v -6 h -1.03125 v -0.90625 h 1.03125 v -0.73439 q 0,-0.70313 0.125,-1.0468=
8 0.17187,-0.45312 0.59375,-0.73437 0.42187,-0.28125 1.20312,-0.28125 0.484=
38,0 1.09375,0.10937 l -0.1875,1.03125 q -0.35937,-0.0625 -0.6875,-0.0625 -=
0.53125,0 -0.75,0.23438 -0.21875,0.21875 -0.21875,0.84375 v 0.64064 h 1.343=
75 v 0.90625 h -1.34375 v 6 z m 3.4621,0 v -6 h -1.03125 v -0.90625 h 1.031=
25 v -0.73439 q 0,-0.70313 0.125,-1.04688 0.17187,-0.45312 0.59375,-0.73437=
 0.42187,-0.28125 1.20312,-0.28125 0.48438,0 1.09375,0.10937 l -0.1875,1.03=
125 q -0.35937,-0.0625 -0.6875,-0.0625 -0.53125,0 -0.75,0.23438 -0.21875,0.=
21875 -0.21875,0.84375 v 0.64064 h 1.34375 v 0.90625 h -1.34375 v 6 z m 2.9=
5297,-2.0625 1.15625,-0.1875 q 0.10937,0.70313 0.54687,1.07813 0.45313,0.35=
937 1.25,0.35937 0.8125,0 1.20313,-0.32812 0.39062,-0.32813 0.39062,-0.7656=
3 0,-0.39062 -0.35937,-0.625 -0.23438,-0.15625 -1.1875,-0.39062 -1.29688,-0=
.32813 -1.79688,-0.5625 -0.48437,-0.25 -0.75,-0.65625 -0.25,-0.42188 -0.25,=
-0.9375 0,-0.45313 0.20313,-0.84375 0.21875,-0.40625 0.57812,-0.67188 0.281=
25,-0.1875 0.75,-0.32812 0.46875,-0.14063 1.01563,-0.14063 0.8125,0 1.42187=
,0.23438 0.60938,0.23437 0.90625,0.64062 0.29688,0.39063 0.40625,1.0625 l -=
1.14062,0.15625 q -0.0781,-0.53125 -0.45313,-0.82812 -0.375,-0.3125 -1.0625=
,-0.3125 -0.8125,0 -1.15625,0.26562 -0.34375,0.26563 -0.34375,0.625 0,0.234=
38 0.14063,0.42188 0.15625,0.1875 0.45312,0.3125 0.17188,0.0625 1.03125,0.2=
9687 1.25,0.32813 1.73438,0.54688 0.5,0.20312 0.78125,0.60937 0.28125,0.406=
25 0.28125,1 0,0.59375 -0.34375,1.10938 -0.34375,0.51562 -1,0.79687 -0.6406=
3,0.28125 -1.45313,0.28125 -1.34375,0 -2.04687,-0.5625 -0.70313,-0.5625 -0.=
90625,-1.65625 z m 11.86719,-0.15625 1.20311,0.14063 q -0.2812,1.0625 -1.06=
249,1.65625 -0.76562,0.57812 -1.96875,0.57812 -1.51562,0 -2.40625,-0.9375 -=
0.89062,-0.9375 -0.89062,-2.60937 0,-1.75 0.89062,-2.70313 0.90625,-0.96875=
 2.34375,-0.96875 1.39063,0 2.26563,0.9375 0.87501,0.9375 0.87501,2.65625 0=
,0.10938 0,0.3125 h -5.15626 q 0.0625,1.14063 0.64062,1.75 0.57813,0.59375 =
1.4375,0.59375 0.65625,0 1.10938,-0.32812 0.45312,-0.34375 0.71875,-1.07813=
 z m -3.84375,-1.90625 h 3.85937 q -0.0781,-0.85937 -0.4375,-1.29687 -0.562=
5,-0.6875 -1.45312,-0.6875 -0.8125,0 -1.35938,0.54687 -0.54687,0.53125 -0.6=
0937,1.4375 z m 9.08436,3.07813 0.1719,1.03125 q -0.5,0.10937 -0.8907,0.109=
37 -0.6406,0 -1,-0.20312 -0.3437,-0.20313 -0.4843,-0.53125 -0.1407,-0.32813=
 -0.1407,-1.39063 v -3.96875 h -0.8593 v -0.90625 h 0.8593 v -1.71877 l 1.1=
719,-0.70312 v 2.42189 h 1.1719 v 0.90625 h -1.1719 v 4.04688 q 0,0.5 0.047=
,0.64062 0.062,0.14063 0.2031,0.23438 0.1407,0.0781 0.4063,0.0781 0.2031,0 =
0.5156,-0.0469 z"
-       fill-rule=3D"nonzero"
-       id=3D"path372" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 374.07084,273.7978 v -9.54688 h 6.90625 v 1.125 h -5.64062 v=
 2.92188 h 5.28125 v 1.125 h -5.28125 v 3.25 h 5.85937 v 1.125 z m 8.71787,=
0 v -6.90625 h 1.0625 v 0.98437 q 0.75,-1.14062 2.1875,-1.14062 0.625,0 1.1=
5625,0.21875 0.53125,0.21875 0.78125,0.59375 0.26562,0.35937 0.375,0.85937 =
0.0625,0.32813 0.0625,1.14063 v 4.25 h -1.17188 v -4.20313 q 0,-0.71875 -0.=
14062,-1.0625 -0.14063,-0.35937 -0.48438,-0.5625 -0.34375,-0.21875 -0.8125,=
-0.21875 -0.75,0 -1.29687,0.46875 -0.54688,0.46875 -0.54688,1.79688 v 3.781=
25 z m 11.81872,2.65625 v -3.39063 q -0.26562,0.39063 -0.76562,0.64063 -0.4=
8438,0.25 -1.04688,0.25 -1.21875,0 -2.10937,-0.98438 -0.89063,-0.98437 -0.8=
9063,-2.6875 0,-1.04687 0.35938,-1.875 0.35937,-0.82812 1.04687,-1.25 0.687=
5,-0.42187 1.51563,-0.42187 1.28125,0 2.01562,1.07812 v -0.92187 h 1.04688 =
v 9.5625 z m -3.60937,-6.125 q 0,1.32812 0.5625,2 0.5625,0.65625 1.34375,0.=
65625 0.75,0 1.28125,-0.625 0.54687,-0.64063 0.54687,-1.9375 0,-1.375 -0.57=
812,-2.0625 -0.5625,-0.70313 -1.32813,-0.70313 -0.76562,0 -1.29687,0.65625 =
-0.53125,0.64063 -0.53125,2.01563 z m 11.14685,3.46875 v -1.01563 q -0.8125=
,1.17188 -2.1875,1.17188 -0.60938,0 -1.14063,-0.23438 -0.53125,-0.23437 -0.=
79687,-0.57812 -0.25,-0.35938 -0.35938,-0.875 -0.0625,-0.34375 -0.0625,-1.0=
9375 v -4.28125 h 1.17188 v 3.82812 q 0,0.92188 0.0625,1.23438 0.10937,0.46=
875 0.46875,0.73437 0.35937,0.25 0.89062,0.25 0.51563,0 0.98438,-0.26562 0.=
46875,-0.26563 0.65625,-0.73438 0.1875,-0.46875 0.1875,-1.34375 v -3.70312 =
h 1.17187 v 6.90625 z m 7.6156,-2.21875 1.20312,0.14062 q -0.28125,1.0625 -=
1.0625,1.65625 -0.76562,0.57813 -1.96875,0.57813 -1.51562,0 -2.40625,-0.937=
5 -0.89062,-0.9375 -0.89062,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-0.96=
875 2.34375,-0.96875 1.39063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,=
0.10937 0,0.3125 h -5.15625 q 0.0625,1.14062 0.64062,1.75 0.57813,0.59375 1=
.4375,0.59375 0.65625,0 1.10938,-0.32813 0.45312,-0.34375 0.71875,-1.07812 =
z m -3.84375,-1.90625 h 3.85937 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625=
,-0.6875 -1.45312,-0.6875 -0.8125,0 -1.35938,0.54688 -0.54687,0.53125 -0.60=
937,1.4375 z m 11.0531,4.125 v -1.01563 q -0.8125,1.17188 -2.1875,1.17188 -=
0.60938,0 -1.14063,-0.23438 -0.53125,-0.23437 -0.79687,-0.57812 -0.25,-0.35=
938 -0.35938,-0.875 -0.0625,-0.34375 -0.0625,-1.09375 v -4.28125 h 1.17188 =
v 3.82812 q 0,0.92188 0.0625,1.23438 0.10937,0.46875 0.46875,0.73437 0.3593=
7,0.25 0.89062,0.25 0.51563,0 0.98438,-0.26562 0.46875,-0.26563 0.65625,-0.=
73438 0.1875,-0.46875 0.1875,-1.34375 v -3.70312 h 1.17187 v 6.90625 z m 7.=
6156,-2.21875 1.20312,0.14062 q -0.28125,1.0625 -1.0625,1.65625 -0.76562,0.=
57813 -1.96875,0.57813 -1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375 -0.8906=
2,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.390=
63,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.1562=
5 q 0.0625,1.14062 0.64062,1.75 0.57813,0.59375 1.4375,0.59375 0.65625,0 1.=
10938,-0.32813 0.45312,-0.34375 0.71875,-1.07812 z m -3.84375,-1.90625 h 3.=
85937 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.45312,-0.6875 =
-0.8125,0 -1.35938,0.54688 -0.54687,0.53125 -0.60937,1.4375 z m 10.36548,4.=
125 v -9.54688 h 1.29687 l 5.01563,7.5 v -7.5 h 1.20312 v 9.54688 h -1.2968=
7 l -5.01563,-7.5 v 7.5 z m 9.04703,-3.45313 q 0,-1.92187 1.07812,-2.84375 =
0.89063,-0.76562 2.17188,-0.76562 1.42187,0 2.32812,0.9375 0.90625,0.92187 =
0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.39062,0.76563 -1.15625,1.1875=
 -0.76562,0.42188 -1.67187,0.42188 -1.45313,0 -2.35938,-0.92188 -0.89062,-0=
.9375 -0.89062,-2.6875 z m 1.20312,0 q 0,1.32813 0.57813,1.98438 0.59375,0.=
65625 1.46875,0.65625 0.875,0 1.45312,-0.65625 0.57813,-0.67188 0.57813,-2.=
03125 0,-1.28125 -0.59375,-1.9375 -0.57813,-0.65625 -1.4375,-0.65625 -0.875=
,0 -1.46875,0.65625 -0.57813,0.65625 -0.57813,1.98437 z m 11.13123,3.45313 =
v -0.875 q -0.65625,1.03125 -1.9375,1.03125 -0.8125,0 -1.51563,-0.45313 -0.=
6875,-0.45312 -1.07812,-1.26562 -0.375,-0.82813 -0.375,-1.89063 0,-1.03125 =
0.34375,-1.875 0.34375,-0.84375 1.03125,-1.28125 0.70312,-0.45312 1.54687,-=
0.45312 0.625,0 1.10938,0.26562 0.5,0.25 0.79687,0.67188 v -3.42188 h 1.171=
88 v 9.54688 z m -3.70313,-3.45313 q 0,1.32813 0.5625,1.98438 0.5625,0.6562=
5 1.32813,0.65625 0.76562,0 1.29687,-0.625 0.53125,-0.625 0.53125,-1.90625 =
0,-1.42188 -0.54687,-2.07813 -0.54688,-0.67187 -1.34375,-0.67187 -0.78125,0=
 -1.3125,0.64062 -0.51563,0.625 -0.51563,2 z m 11.3656,1.23438 1.20313,0.14=
062 q -0.28125,1.0625 -1.0625,1.65625 -0.76563,0.57813 -1.96875,0.57813 -1.=
51563,0 -2.40625,-0.9375 -0.89063,-0.9375 -0.89063,-2.60938 0,-1.75 0.89063=
,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.39062,0 2.26562,0.9375 0.875,=
0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.15625 q 0.0625,1.14062 0.64063=
,1.75 0.57812,0.59375 1.4375,0.59375 0.65625,0 1.10937,-0.32813 0.45313,-0.=
34375 0.71875,-1.07812 z m -3.84375,-1.90625 h 3.85938 q -0.0781,-0.85938 -=
0.4375,-1.29688 -0.5625,-0.6875 -1.45313,-0.6875 -0.8125,0 -1.35937,0.54688=
 -0.54688,0.53125 -0.60938,1.4375 z m 16.05295,3 v 1.125 h -6.29687 q -0.01=
56,-0.42188 0.14062,-0.8125 0.23438,-0.64063 0.76563,-1.26563 0.53125,-0.62=
5 1.53125,-1.45312 1.5625,-1.26563 2.10937,-2.01563 0.54688,-0.75 0.54688,-=
1.40625 0,-0.70312 -0.5,-1.17187 -0.5,-0.48438 -1.29688,-0.48438 -0.85937,0=
 -1.375,0.51563 -0.5,0.5 -0.5,1.39062 l -1.20312,-0.10937 q 0.125,-1.35938 =
0.92187,-2.0625 0.8125,-0.70313 2.17188,-0.70313 1.375,0 2.17187,0.76563 0.=
8125,0.75 0.8125,1.875 0,0.57812 -0.23437,1.14062 -0.23438,0.54688 -0.78125=
,1.15625 -0.54688,0.60938 -1.8125,1.67188 -1.04688,0.89062 -1.35938,1.21875=
 -0.29687,0.3125 -0.48437,0.625 z m 4.84985,-2.32813 q 0,-1.92187 1.07813,-=
2.84375 0.89062,-0.76562 2.17187,-0.76562 1.42188,0 2.32813,0.9375 0.90625,=
0.92187 0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.39063,0.76563 -1.1562=
5,1.1875 -0.76563,0.42188 -1.67188,0.42188 -1.45312,0 -2.35937,-0.92188 -0.=
89063,-0.9375 -0.89063,-2.6875 z m 1.20313,0 q 0,1.32813 0.57812,1.98438 0.=
59375,0.65625 1.46875,0.65625 0.875,0 1.45313,-0.65625 0.57812,-0.67188 0.5=
7812,-2.03125 0,-1.28125 -0.59375,-1.9375 -0.57812,-0.65625 -1.4375,-0.6562=
5 -0.875,0 -1.46875,0.65625 -0.57812,0.65625 -0.57812,1.98437 z m 6.9281,3.=
45313 v -6 h -1.03125 v -0.90625 h 1.03125 v -0.73438 q 0,-0.70312 0.125,-1=
.04687 0.17187,-0.45313 0.59375,-0.73438 0.42187,-0.28125 1.20312,-0.28125 =
0.48438,0 1.09375,0.10938 l -0.1875,1.03125 q -0.35937,-0.0625 -0.6875,-0.0=
625 -0.53125,0 -0.75,0.23437 -0.21875,0.21875 -0.21875,0.84375 v 0.64063 h =
1.34375 v 0.90625 h -1.34375 v 6 z m 3.4621,0 v -6 h -1.03125 v -0.90625 h =
1.03125 v -0.73438 q 0,-0.70312 0.125,-1.04687 0.17187,-0.45313 0.59375,-0.=
73438 0.42187,-0.28125 1.20312,-0.28125 0.48438,0 1.09375,0.10938 l -0.1875=
,1.03125 q -0.35937,-0.0625 -0.6875,-0.0625 -0.53125,0 -0.75,0.23437 -0.218=
75,0.21875 -0.21875,0.84375 v 0.64063 h 1.34375 v 0.90625 h -1.34375 v 6 z =
m 2.95297,-2.0625 1.15625,-0.1875 q 0.10937,0.70312 0.54687,1.07812 0.45313=
,0.35938 1.25,0.35938 0.8125,0 1.20313,-0.32813 0.39062,-0.32812 0.39062,-0=
.76562 0,-0.39063 -0.35937,-0.625 -0.23438,-0.15625 -1.1875,-0.39063 -1.296=
88,-0.32812 -1.79688,-0.5625 -0.48437,-0.25 -0.75,-0.65625 -0.25,-0.42187 -=
0.25,-0.9375 0,-0.45312 0.20313,-0.84375 0.21875,-0.40625 0.57812,-0.67187 =
0.28125,-0.1875 0.75,-0.32813 0.46875,-0.14062 1.01563,-0.14062 0.8125,0 1.=
42187,0.23437 0.60938,0.23438 0.90625,0.64063 0.29688,0.39062 0.40625,1.062=
5 l -1.14062,0.15625 q -0.0781,-0.53125 -0.45313,-0.82813 -0.375,-0.3125 -1=
.0625,-0.3125 -0.8125,0 -1.15625,0.26563 -0.34375,0.26562 -0.34375,0.625 0,=
0.23437 0.14063,0.42187 0.15625,0.1875 0.45312,0.3125 0.17188,0.0625 1.0312=
5,0.29688 1.25,0.32812 1.73438,0.54687 0.5,0.20313 0.78125,0.60938 0.28125,=
0.40625 0.28125,1 0,0.59375 -0.34375,1.10937 -0.34375,0.51563 -1,0.79688 -0=
.64063,0.28125 -1.45313,0.28125 -1.34375,0 -2.04687,-0.5625 -0.70313,-0.562=
5 -0.90625,-1.65625 z m 11.86719,-0.15625 1.20311,0.14062 q -0.2812,1.0625 =
-1.06249,1.65625 -0.76562,0.57813 -1.96875,0.57813 -1.51562,0 -2.40625,-0.9=
375 -0.89062,-0.9375 -0.89062,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-0.=
96875 2.34375,-0.96875 1.39063,0 2.26563,0.9375 0.87501,0.9375 0.87501,2.65=
625 0,0.10937 0,0.3125 h -5.15626 q 0.0625,1.14062 0.64062,1.75 0.57813,0.5=
9375 1.4375,0.59375 0.65625,0 1.10938,-0.32813 0.45312,-0.34375 0.71875,-1.=
07812 z m -3.84375,-1.90625 h 3.85937 q -0.0781,-0.85938 -0.4375,-1.29688 -=
0.5625,-0.6875 -1.45312,-0.6875 -0.8125,0 -1.35938,0.54688 -0.54687,0.53125=
 -0.60937,1.4375 z m 9.08436,3.07812 0.1719,1.03125 q -0.5,0.10938 -0.8907,=
0.10938 -0.6406,0 -1,-0.20313 -0.3437,-0.20312 -0.4843,-0.53125 -0.1407,-0.=
32812 -0.1407,-1.39062 v -3.96875 h -0.8593 v -0.90625 h 0.8593 v -1.71875 =
l 1.1719,-0.70313 v 2.42188 h 1.1719 v 0.90625 h -1.1719 v 4.04687 q 0,0.5 =
0.047,0.64063 0.062,0.14062 0.2031,0.23437 0.1407,0.0781 0.4063,0.0781 0.20=
31,0 0.5156,-0.0469 z"
-       fill-rule=3D"nonzero"
-       id=3D"path374" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 372.96448,308.99465 v -9.54688 h 6.90625 v 1.125 h -5.64062 =
v 2.92188 h 5.28125 v 1.125 h -5.28125 v 3.25 h 5.85937 v 1.125 z m 8.7179,=
0 v -6.90625 h 1.0625 v 0.98437 q 0.75,-1.14062 2.1875,-1.14062 0.625,0 1.1=
5625,0.21875 0.53125,0.21875 0.78125,0.59375 0.26562,0.35937 0.375,0.85937 =
0.0625,0.32813 0.0625,1.14063 v 4.25 h -1.17188 v -4.20313 q 0,-0.71875 -0.=
14062,-1.0625 -0.14063,-0.35937 -0.48438,-0.5625 -0.34375,-0.21875 -0.8125,=
-0.21875 -0.75,0 -1.29687,0.46875 -0.54688,0.46875 -0.54688,1.79688 v 3.781=
25 z m 11.81872,2.65625 v -3.39063 q -0.26562,0.39063 -0.76562,0.64063 -0.4=
8438,0.25 -1.04688,0.25 -1.21875,0 -2.10937,-0.98438 -0.89063,-0.98437 -0.8=
9063,-2.6875 0,-1.04687 0.35938,-1.875 0.35937,-0.82812 1.04687,-1.25 0.687=
5,-0.42187 1.51563,-0.42187 1.28125,0 2.01562,1.07812 v -0.92187 h 1.04688 =
v 9.5625 z m -3.60937,-6.125 q 0,1.32812 0.5625,2 0.5625,0.65625 1.34375,0.=
65625 0.75,0 1.28125,-0.625 0.54687,-0.64063 0.54687,-1.9375 0,-1.375 -0.57=
812,-2.0625 -0.5625,-0.70313 -1.32813,-0.70313 -0.76562,0 -1.29687,0.65625 =
-0.53125,0.64063 -0.53125,2.01563 z m 11.14685,3.46875 v -1.01563 q -0.8125=
,1.17188 -2.1875,1.17188 -0.60938,0 -1.14063,-0.23438 -0.53125,-0.23437 -0.=
79687,-0.57812 -0.25,-0.35938 -0.35938,-0.875 -0.0625,-0.34375 -0.0625,-1.0=
9375 v -4.28125 h 1.17188 v 3.82812 q 0,0.92188 0.0625,1.23438 0.10937,0.46=
875 0.46875,0.73437 0.35937,0.25 0.89062,0.25 0.51563,0 0.98438,-0.26562 0.=
46875,-0.26563 0.65625,-0.73438 0.1875,-0.46875 0.1875,-1.34375 v -3.70312 =
h 1.17187 v 6.90625 z m 7.6156,-2.21875 1.20312,0.14062 q -0.28125,1.0625 -=
1.0625,1.65625 -0.76562,0.57813 -1.96875,0.57813 -1.51562,0 -2.40625,-0.937=
5 -0.89062,-0.9375 -0.89062,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-0.96=
875 2.34375,-0.96875 1.39063,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,=
0.10937 0,0.3125 h -5.15625 q 0.0625,1.14062 0.64062,1.75 0.57813,0.59375 1=
.4375,0.59375 0.65625,0 1.10938,-0.32813 0.45312,-0.34375 0.71875,-1.07812 =
z m -3.84375,-1.90625 h 3.85937 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625=
,-0.6875 -1.45312,-0.6875 -0.8125,0 -1.35938,0.54688 -0.54687,0.53125 -0.60=
937,1.4375 z m 11.0531,4.125 v -1.01563 q -0.8125,1.17188 -2.1875,1.17188 -=
0.60938,0 -1.14063,-0.23438 -0.53125,-0.23437 -0.79687,-0.57812 -0.25,-0.35=
938 -0.35938,-0.875 -0.0625,-0.34375 -0.0625,-1.09375 v -4.28125 h 1.17188 =
v 3.82812 q 0,0.92188 0.0625,1.23438 0.10937,0.46875 0.46875,0.73437 0.3593=
7,0.25 0.89062,0.25 0.51563,0 0.98438,-0.26562 0.46875,-0.26563 0.65625,-0.=
73438 0.1875,-0.46875 0.1875,-1.34375 v -3.70312 h 1.17187 v 6.90625 z m 7.=
6156,-2.21875 1.20312,0.14062 q -0.28125,1.0625 -1.0625,1.65625 -0.76562,0.=
57813 -1.96875,0.57813 -1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375 -0.8906=
2,-2.60938 0,-1.75 0.89062,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.390=
63,0 2.26563,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.1562=
5 q 0.0625,1.14062 0.64062,1.75 0.57813,0.59375 1.4375,0.59375 0.65625,0 1.=
10938,-0.32813 0.45312,-0.34375 0.71875,-1.07812 z m -3.84375,-1.90625 h 3.=
85937 q -0.0781,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.45312,-0.6875 =
-0.8125,0 -1.35938,0.54688 -0.54687,0.53125 -0.60937,1.4375 z m 10.36545,4.=
125 v -9.54688 h 1.29687 l 5.01563,7.5 v -7.5 h 1.20312 v 9.54688 h -1.2968=
7 l -5.01563,-7.5 v 7.5 z m 9.04703,-3.45313 q 0,-1.92187 1.07812,-2.84375 =
0.89063,-0.76562 2.17188,-0.76562 1.42187,0 2.32812,0.9375 0.90625,0.92187 =
0.90625,2.57812 0,1.32813 -0.40625,2.09375 -0.39062,0.76563 -1.15625,1.1875=
 -0.76562,0.42188 -1.67187,0.42188 -1.45313,0 -2.35938,-0.92188 -0.89062,-0=
.9375 -0.89062,-2.6875 z m 1.20312,0 q 0,1.32813 0.57813,1.98438 0.59375,0.=
65625 1.46875,0.65625 0.875,0 1.45312,-0.65625 0.57813,-0.67188 0.57813,-2.=
03125 0,-1.28125 -0.59375,-1.9375 -0.57813,-0.65625 -1.4375,-0.65625 -0.875=
,0 -1.46875,0.65625 -0.57813,0.65625 -0.57813,1.98437 z m 11.13123,3.45313 =
v -0.875 q -0.65625,1.03125 -1.9375,1.03125 -0.8125,0 -1.51563,-0.45313 -0.=
6875,-0.45312 -1.07812,-1.26562 -0.375,-0.82813 -0.375,-1.89063 0,-1.03125 =
0.34375,-1.875 0.34375,-0.84375 1.03125,-1.28125 0.70312,-0.45312 1.54687,-=
0.45312 0.625,0 1.10938,0.26562 0.5,0.25 0.79687,0.67188 v -3.42188 h 1.171=
88 v 9.54688 z m -3.70313,-3.45313 q 0,1.32813 0.5625,1.98438 0.5625,0.6562=
5 1.32813,0.65625 0.76562,0 1.29687,-0.625 0.53125,-0.625 0.53125,-1.90625 =
0,-1.42188 -0.54687,-2.07813 -0.54688,-0.67187 -1.34375,-0.67187 -0.78125,0=
 -1.3125,0.64062 -0.51563,0.625 -0.51563,2 z m 11.3656,1.23438 1.20313,0.14=
062 q -0.28125,1.0625 -1.0625,1.65625 -0.76563,0.57813 -1.96875,0.57813 -1.=
51563,0 -2.40625,-0.9375 -0.89063,-0.9375 -0.89063,-2.60938 0,-1.75 0.89063=
,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.39062,0 2.26562,0.9375 0.875,=
0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.15625 q 0.0625,1.14062 0.64063=
,1.75 0.57812,0.59375 1.4375,0.59375 0.65625,0 1.10937,-0.32813 0.45313,-0.=
34375 0.71875,-1.07812 z m -3.84375,-1.90625 h 3.85938 q -0.0781,-0.85938 -=
0.4375,-1.29688 -0.5625,-0.6875 -1.45313,-0.6875 -0.8125,0 -1.35937,0.54688=
 -0.54688,0.53125 -0.60938,1.4375 z m 10.36548,4.125 v -9.54688 h 1.29688 l=
 5.01562,7.5 v -7.5 h 1.20313 v 9.54688 h -1.29688 l -5.01562,-7.5 v 7.5 z =
m 12.75,-3.45313 q 0,-1.92187 1.07813,-2.84375 0.89062,-0.76562 2.17187,-0.=
76562 1.42188,0 2.32813,0.9375 0.90625,0.92187 0.90625,2.57812 0,1.32813 -0=
.40625,2.09375 -0.39063,0.76563 -1.15625,1.1875 -0.76563,0.42188 -1.67188,0=
.42188 -1.45312,0 -2.35937,-0.92188 -0.89063,-0.9375 -0.89063,-2.6875 z m 1=
.20313,0 q 0,1.32813 0.57812,1.98438 0.59375,0.65625 1.46875,0.65625 0.875,=
0 1.45313,-0.65625 0.57812,-0.67188 0.57812,-2.03125 0,-1.28125 -0.59375,-1=
.9375 -0.57812,-0.65625 -1.4375,-0.65625 -0.875,0 -1.46875,0.65625 -0.57812=
,0.65625 -0.57812,1.98437 z m 6.9281,3.45313 v -6 h -1.03125 v -0.90625 h 1=
.03125 v -0.73438 q 0,-0.70312 0.125,-1.04687 0.17187,-0.45313 0.59375,-0.7=
3438 0.42187,-0.28125 1.20312,-0.28125 0.48438,0 1.09375,0.10938 l -0.1875,=
1.03125 q -0.35937,-0.0625 -0.6875,-0.0625 -0.53125,0 -0.75,0.23437 -0.2187=
5,0.21875 -0.21875,0.84375 v 0.64063 h 1.34375 v 0.90625 h -1.34375 v 6 z m=
 3.46209,0 v -6 h -1.03125 v -0.90625 h 1.03125 v -0.73438 q 0,-0.70312 0.1=
25,-1.04687 0.17188,-0.45313 0.59375,-0.73438 0.42188,-0.28125 1.20313,-0.2=
8125 0.48437,0 1.09375,0.10938 l -0.1875,1.03125 q -0.35938,-0.0625 -0.6875=
,-0.0625 -0.53125,0 -0.75,0.23437 -0.21875,0.21875 -0.21875,0.84375 v 0.640=
63 h 1.34375 v 0.90625 h -1.34375 v 6 z m 2.95301,-2.0625 1.15625,-0.1875 q=
 0.10937,0.70312 0.54687,1.07812 0.45313,0.35938 1.25,0.35938 0.8125,0 1.20=
313,-0.32813 0.39062,-0.32812 0.39062,-0.76562 0,-0.39063 -0.35937,-0.625 -=
0.23438,-0.15625 -1.1875,-0.39063 -1.29688,-0.32812 -1.79688,-0.5625 -0.484=
37,-0.25 -0.75,-0.65625 -0.25,-0.42187 -0.25,-0.9375 0,-0.45312 0.20313,-0.=
84375 0.21875,-0.40625 0.57812,-0.67187 0.28125,-0.1875 0.75,-0.32813 0.468=
75,-0.14062 1.01563,-0.14062 0.8125,0 1.42187,0.23437 0.60938,0.23438 0.906=
25,0.64063 0.29688,0.39062 0.40625,1.0625 l -1.14062,0.15625 q -0.0781,-0.5=
3125 -0.45313,-0.82813 -0.375,-0.3125 -1.0625,-0.3125 -0.8125,0 -1.15625,0.=
26563 -0.34375,0.26562 -0.34375,0.625 0,0.23437 0.14063,0.42187 0.15625,0.1=
875 0.45312,0.3125 0.17188,0.0625 1.03125,0.29688 1.25,0.32812 1.73438,0.54=
687 0.5,0.20313 0.78125,0.60938 0.28125,0.40625 0.28125,1 0,0.59375 -0.3437=
5,1.10937 -0.34375,0.51563 -1,0.79688 -0.64063,0.28125 -1.45313,0.28125 -1.=
34375,0 -2.04687,-0.5625 -0.70313,-0.5625 -0.90625,-1.65625 z m 11.86715,-0=
.15625 1.2032,0.14062 q -0.2813,1.0625 -1.0625,1.65625 -0.76567,0.57813 -1.=
96879,0.57813 -1.51563,0 -2.40625,-0.9375 -0.89063,-0.9375 -0.89063,-2.6093=
8 0,-1.75 0.89063,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.39062,0 2.26=
559,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.15622 q 0.062=
5,1.14062 0.64063,1.75 0.57812,0.59375 1.4375,0.59375 0.65625,0 1.10937,-0.=
32813 0.45313,-0.34375 0.71872,-1.07812 z m -3.84372,-1.90625 h 3.85942 q -=
0.078,-0.85938 -0.43754,-1.29688 -0.5625,-0.6875 -1.45313,-0.6875 -0.8125,0=
 -1.35937,0.54688 -0.54688,0.53125 -0.60938,1.4375 z m 9.08432,3.07812 0.17=
19,1.03125 q -0.5,0.10938 -0.8906,0.10938 -0.6406,0 -1,-0.20313 -0.3438,-0.=
20312 -0.4844,-0.53125 -0.1406,-0.32812 -0.1406,-1.39062 v -3.96875 h -0.85=
94 v -0.90625 h 0.8594 v -1.71875 l 1.1719,-0.70313 v 2.42188 h 1.1718 v 0.=
90625 h -1.1718 v 4.04687 q 0,0.5 0.047,0.64063 0.062,0.14062 0.2031,0.2343=
7 0.1406,0.0781 0.4062,0.0781 0.2032,0 0.5157,-0.0469 z"
-       fill-rule=3D"nonzero"
-       id=3D"path376" />
-    <path
-       fill=3D"#000000"
-       fill-opacity=3D"0"
-       d=3D"m 327.9666,40.550037 h 280.09449 v 27.46457 H 327.9666 Z"
-       fill-rule=3D"evenodd"
-       id=3D"path378" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 346.58571,59.006287 1.26562,0.3125 q -0.39062,1.5625 -1.4218=
7,2.375 -1.03125,0.8125 -2.53125,0.8125 -1.53125,0 -2.5,-0.625 -0.96875,-0.=
625 -1.48438,-1.8125 -0.5,-1.1875 -0.5,-2.5625 0,-1.48438 0.5625,-2.59375 0=
.57813,-1.10938 1.625,-1.6875 1.0625,-0.57813 2.32813,-0.57813 1.42187,0 2.=
39062,0.73438 0.98438,0.71875 1.375,2.04687 l -1.25,0.29688 q -0.32812,-1.0=
4688 -0.96875,-1.51563 -0.625,-0.48437 -1.57812,-0.48437 -1.09375,0 -1.8437=
5,0.53125 -0.73438,0.53125 -1.03125,1.42187 -0.29688,0.875 -0.29688,1.82813=
 0,1.21875 0.34375,2.125 0.35938,0.90625 1.10938,1.35937 0.75,0.4375 1.625,=
0.4375 1.0625,0 1.79687,-0.60937 0.73438,-0.60938 0.98438,-1.8125 z m 2.687=
65,-4.84375 v -1.35938 h 1.17188 v 1.35938 z m 0,8.1875 v -6.90625 h 1.1718=
8 v 6.90625 z m 2.92984,0 v -6.90625 h 1.0625 v 1.04687 q 0.40625,-0.73437 =
0.73438,-0.96875 0.34375,-0.23437 0.76562,-0.23437 0.59375,0 1.20313,0.375 =
l -0.40625,1.07812 q -0.4375,-0.25 -0.85938,-0.25 -0.39062,0 -0.70312,0.234=
38 -0.29688,0.23437 -0.42188,0.64062 -0.20312,0.625 -0.20312,1.35938 v 3.62=
5 z m 8.96964,-2.53125 1.15625,0.15625 q -0.1875,1.1875 -0.96875,1.85937 -0=
.78125,0.67188 -1.92188,0.67188 -1.40625,0 -2.28125,-0.92188 -0.85937,-0.93=
75 -0.85937,-2.65625 0,-1.125 0.375,-1.96875 0.375,-0.84375 1.125,-1.25 0.7=
6562,-0.42187 1.65625,-0.42187 1.125,0 1.84375,0.57812 0.71875,0.5625 0.921=
87,1.60938 l -1.14062,0.17187 q -0.17188,-0.70312 -0.59375,-1.04687 -0.4062=
5,-0.35938 -0.98438,-0.35938 -0.89062,0 -1.45312,0.64063 -0.54688,0.64062 -=
0.54688,2 0,1.40625 0.53125,2.03125 0.54688,0.625 1.40625,0.625 0.6875,0 1.=
14063,-0.42188 0.46875,-0.42187 0.59375,-1.29687 z m 6.67969,2.53125 v -1.0=
1563 q -0.8125,1.17188 -2.1875,1.17188 -0.60938,0 -1.14063,-0.23438 -0.5312=
5,-0.23437 -0.79687,-0.57812 -0.25,-0.35938 -0.35938,-0.875 -0.0625,-0.3437=
5 -0.0625,-1.09375 v -4.28125 h 1.17188 v 3.82812 q 0,0.92188 0.0625,1.2343=
8 0.10937,0.46875 0.46875,0.73437 0.35937,0.25 0.89062,0.25 0.51563,0 0.984=
38,-0.26562 0.46875,-0.26563 0.65625,-0.73438 0.1875,-0.46875 0.1875,-1.343=
75 v -3.70312 h 1.17187 v 6.90625 z m 2.8656,0 v -9.54688 H 371.89 v 9.5468=
8 z m 7.49234,-0.85938 q -0.65625,0.5625 -1.26563,0.79688 -0.59375,0.21875 =
-1.28125,0.21875 -1.14062,0 -1.75,-0.54688 -0.60937,-0.5625 -0.60937,-1.437=
5 0,-0.5 0.21875,-0.92187 0.23437,-0.42188 0.60937,-0.67188 0.375,-0.25 0.8=
4375,-0.39062 0.34375,-0.0781 1.04688,-0.17188 1.42187,-0.17187 2.09375,-0.=
40625 0,-0.23437 0,-0.29687 0,-0.71875 -0.32813,-1.01563 -0.45312,-0.39062 =
-1.34375,-0.39062 -0.8125,0 -1.21875,0.29687 -0.39062,0.28125 -0.57812,1.01=
563 l -1.14063,-0.15625 q 0.15625,-0.73438 0.51563,-1.1875 0.35937,-0.45313=
 1.03125,-0.6875 0.67187,-0.25 1.5625,-0.25 0.89062,0 1.4375,0.20312 0.5625=
,0.20313 0.8125,0.53125 0.26562,0.3125 0.375,0.79688 0.0469,0.29687 0.0469,=
1.07812 v 1.5625 q 0,1.625 0.0781,2.0625 0.0781,0.4375 0.29687,0.82813 h -1=
.21875 q -0.1875,-0.35938 -0.23437,-0.85938 z m -0.0937,-2.60937 q -0.64063=
,0.26562 -1.92188,0.4375 -0.71875,0.10937 -1.01562,0.25 -0.29688,0.125 -0.4=
6875,0.375 -0.15625,0.25 -0.15625,0.54687 0,0.46875 0.34375,0.78125 0.35937=
,0.3125 1.04687,0.3125 0.67188,0 1.20313,-0.29687 0.53125,-0.29688 0.78125,=
-0.8125 0.1875,-0.39063 0.1875,-1.17188 z m 2.97497,3.46875 v -6.90625 h 1.=
0625 v 1.04687 q 0.40625,-0.73437 0.73438,-0.96875 0.34375,-0.23437 0.76562=
,-0.23437 0.59375,0 1.20313,0.375 l -0.40625,1.07812 q -0.4375,-0.25 -0.859=
38,-0.25 -0.39062,0 -0.70312,0.23438 -0.29688,0.23437 -0.42188,0.64062 -0.2=
0312,0.625 -0.20312,1.35938 v 3.625 z m 8.15698,0 v -6.90625 h 1.04688 v 0.=
96875 q 0.32812,-0.51563 0.85937,-0.8125 0.54688,-0.3125 1.23438,-0.3125 0.=
78125,0 1.26562,0.3125 0.48438,0.3125 0.6875,0.89062 0.82813,-1.20312 2.140=
63,-1.20312 1.03125,0 1.57812,0.57812 0.5625,0.5625 0.5625,1.73438 v 4.75 h=
 -1.17187 v -4.35938 q 0,-0.70312 -0.125,-1 -0.10938,-0.3125 -0.40625,-0.5 =
-0.29688,-0.1875 -0.70313,-0.1875 -0.71875,0 -1.20312,0.48438 -0.48438,0.48=
437 -0.48438,1.54687 v 4.01563 h -1.17187 v -4.48438 q 0,-0.78125 -0.29688,=
-1.17187 -0.28125,-0.39063 -0.92187,-0.39063 -0.5,0 -0.92188,0.26563 -0.421=
87,0.25 -0.60937,0.75 -0.1875,0.5 -0.1875,1.45312 v 3.57813 z m 15.8368,-2.=
21875 1.20312,0.14062 q -0.28125,1.0625 -1.0625,1.65625 -0.76562,0.57813 -1=
.96875,0.57813 -1.51562,0 -2.40625,-0.9375 -0.89062,-0.9375 -0.89062,-2.609=
38 0,-1.75 0.89062,-2.70312 0.90625,-0.96875 2.34375,-0.96875 1.39063,0 2.2=
6563,0.9375 0.875,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.15625 q 0.06=
25,1.14062 0.64062,1.75 0.57813,0.59375 1.4375,0.59375 0.65625,0 1.10938,-0=
.32813 0.45312,-0.34375 0.71875,-1.07812 z m -3.84375,-1.90625 h 3.85937 q =
-0.0781,-0.85938 -0.4375,-1.29688 -0.5625,-0.6875 -1.45312,-0.6875 -0.8125,=
0 -1.35938,0.54688 -0.54687,0.53125 -0.60937,1.4375 z m 6.52185,4.125 v -6.=
90625 h 1.04687 v 0.96875 q 0.32813,-0.51563 0.85938,-0.8125 0.54687,-0.312=
5 1.23437,-0.3125 0.78125,0 1.26563,0.3125 0.48437,0.3125 0.6875,0.89062 0.=
82812,-1.20312 2.14062,-1.20312 1.03125,0 1.57813,0.57812 0.5625,0.5625 0.5=
625,1.73438 v 4.75 h -1.17188 v -4.35938 q 0,-0.70312 -0.125,-1 -0.10937,-0=
.3125 -0.40625,-0.5 -0.29687,-0.1875 -0.70312,-0.1875 -0.71875,0 -1.20313,0=
.48438 -0.48437,0.48437 -0.48437,1.54687 v 4.01563 h -1.17188 v -4.48438 q =
0,-0.78125 -0.29687,-1.17187 -0.28125,-0.39063 -0.92188,-0.39063 -0.5,0 -0.=
92187,0.26563 -0.42188,0.25 -0.60938,0.75 -0.1875,0.5 -0.1875,1.45312 v 3.5=
7813 z m 10.66494,-3.45313 q 0,-1.92187 1.07813,-2.84375 0.89062,-0.76562 2=
.17187,-0.76562 1.42188,0 2.32813,0.9375 0.90625,0.92187 0.90625,2.57812 0,=
1.32813 -0.40625,2.09375 -0.39063,0.76563 -1.15625,1.1875 -0.76563,0.42188 =
-1.67188,0.42188 -1.45312,0 -2.35937,-0.92188 -0.89063,-0.9375 -0.89063,-2.=
6875 z m 1.20313,0 q 0,1.32813 0.57812,1.98438 0.59375,0.65625 1.46875,0.65=
625 0.875,0 1.45313,-0.65625 0.57812,-0.67188 0.57812,-2.03125 0,-1.28125 -=
0.59375,-1.9375 -0.57812,-0.65625 -1.4375,-0.65625 -0.875,0 -1.46875,0.6562=
5 -0.57812,0.65625 -0.57812,1.98437 z m 6.63122,3.45313 v -6.90625 h 1.0625=
 v 1.04687 q 0.40625,-0.73437 0.73438,-0.96875 0.34375,-0.23437 0.76562,-0.=
23437 0.59375,0 1.20313,0.375 l -0.40625,1.07812 q -0.4375,-0.25 -0.85938,-=
0.25 -0.39062,0 -0.70312,0.23438 -0.29688,0.23437 -0.42188,0.64062 -0.20312=
,0.625 -0.20312,1.35938 v 3.625 z m 4.40711,2.65625 -0.125,-1.09375 q 0.375=
,0.10937 0.65625,0.10937 0.39062,0 0.625,-0.14062 0.23437,-0.125 0.39062,-0=
.35938 0.10938,-0.17187 0.35938,-0.875 0.0312,-0.0937 0.10937,-0.28125 l -2=
.625,-6.92187 h 1.26563 l 1.4375,4 q 0.28125,0.76562 0.5,1.59375 0.20312,-0=
.79688 0.46875,-1.57813 l 1.48437,-4.01562 h 1.17188 l -2.625,7.01562 q -0.=
42188,1.14063 -0.65625,1.57813 -0.3125,0.57812 -0.71875,0.84375 -0.40625,0.=
28125 -0.96875,0.28125 -0.32813,0 -0.75,-0.15625 z m 10.39831,-2.65625 v -9=
.54688 h 1.17188 v 9.54688 z m 7.49234,-0.85938 q -0.65625,0.5625 -1.26562,=
0.79688 -0.59375,0.21875 -1.28125,0.21875 -1.14063,0 -1.75,-0.54688 -0.6093=
8,-0.5625 -0.60938,-1.4375 0,-0.5 0.21875,-0.92187 0.23438,-0.42188 0.60938=
,-0.67188 0.375,-0.25 0.84375,-0.39062 0.34375,-0.0781 1.04687,-0.17188 1.4=
2188,-0.17187 2.09375,-0.40625 0,-0.23437 0,-0.29687 0,-0.71875 -0.32812,-1=
.01563 -0.45313,-0.39062 -1.34375,-0.39062 -0.8125,0 -1.21875,0.29687 -0.39=
063,0.28125 -0.57813,1.01563 l -1.14062,-0.15625 q 0.15625,-0.73438 0.51562=
,-1.1875 0.35938,-0.45313 1.03125,-0.6875 0.67188,-0.25 1.5625,-0.25 0.8906=
3,0 1.4375,0.20312 0.5625,0.20313 0.8125,0.53125 0.26563,0.3125 0.375,0.796=
88 0.0469,0.29687 0.0469,1.07812 v 1.5625 q 0,1.625 0.0781,2.0625 0.0781,0.=
4375 0.29688,0.82813 h -1.21875 q -0.1875,-0.35938 -0.23438,-0.85938 z m -0=
.0937,-2.60937 q -0.64062,0.26562 -1.92187,0.4375 -0.71875,0.10937 -1.01563=
,0.25 -0.29687,0.125 -0.46875,0.375 -0.15625,0.25 -0.15625,0.54687 0,0.4687=
5 0.34375,0.78125 0.35938,0.3125 1.04688,0.3125 0.67187,0 1.20312,-0.29687 =
0.53125,-0.29688 0.78125,-0.8125 0.1875,-0.39063 0.1875,-1.17188 z m 2.9437=
3,6.125 -0.125,-1.09375 q 0.375,0.10937 0.65625,0.10937 0.39062,0 0.625,-0.=
14062 0.23437,-0.125 0.39062,-0.35938 0.10938,-0.17187 0.35938,-0.875 0.031=
2,-0.0937 0.10937,-0.28125 l -2.625,-6.92187 h 1.26563 l 1.4375,4 q 0.28125=
,0.76562 0.5,1.59375 0.20312,-0.79688 0.46875,-1.57813 l 1.48437,-4.01562 h=
 1.17188 l -2.625,7.01562 q -0.42188,1.14063 -0.65625,1.57813 -0.3125,0.578=
12 -0.71875,0.84375 -0.40625,0.28125 -0.96875,0.28125 -0.32813,0 -0.75,-0.1=
5625 z m 6.27344,-6.10938 q 0,-1.92187 1.07812,-2.84375 0.89063,-0.76562 2.=
17188,-0.76562 1.42187,0 2.32812,0.9375 0.90625,0.92187 0.90625,2.57812 0,1=
.32813 -0.40625,2.09375 -0.39062,0.76563 -1.15625,1.1875 -0.76562,0.42188 -=
1.67187,0.42188 -1.45313,0 -2.35938,-0.92188 -0.89062,-0.9375 -0.89062,-2.6=
875 z m 1.20312,0 q 0,1.32813 0.57813,1.98438 0.59375,0.65625 1.46875,0.656=
25 0.875,0 1.45312,-0.65625 0.57813,-0.67188 0.57813,-2.03125 0,-1.28125 -0=
.59375,-1.9375 -0.57813,-0.65625 -1.4375,-0.65625 -0.875,0 -1.46875,0.65625=
 -0.57813,0.65625 -0.57813,1.98437 z m 11.1781,3.45313 v -1.01563 q -0.8125=
,1.17188 -2.1875,1.17188 -0.60937,0 -1.14062,-0.23438 -0.53125,-0.23437 -0.=
79688,-0.57812 -0.25,-0.35938 -0.35937,-0.875 -0.0625,-0.34375 -0.0625,-1.0=
9375 v -4.28125 h 1.17187 v 3.82812 q 0,0.92188 0.0625,1.23438 0.10938,0.46=
875 0.46875,0.73437 0.35938,0.25 0.89063,0.25 0.51562,0 0.98437,-0.26562 0.=
46875,-0.26563 0.65625,-0.73438 0.1875,-0.46875 0.1875,-1.34375 v -3.70312 =
h 1.17188 v 6.90625 z m 5.44373,-1.04688 0.17187,1.03125 q -0.5,0.10938 -0.=
89062,0.10938 -0.64063,0 -1,-0.20313 -0.34375,-0.20312 -0.48438,-0.53125 -0=
.14062,-0.32812 -0.14062,-1.39062 v -3.96875 h -0.85938 v -0.90625 h 0.8593=
8 v -1.71875 l 1.17187,-0.70313 v 2.42188 h 1.17188 v 0.90625 h -1.17188 v =
4.04687 q 0,0.5 0.0469,0.64063 0.0625,0.14062 0.20312,0.23437 0.14063,0.078=
1 0.40625,0.0781 0.20313,0 0.51563,-0.0469 z m 5.12472,1.04688 v -6 h -1.03=
125 v -0.90625 h 1.03125 v -0.73438 q 0,-0.70312 0.125,-1.04687 0.17188,-0.=
45313 0.59375,-0.73438 0.42188,-0.28125 1.20313,-0.28125 0.48437,0 1.09375,=
0.10938 l -0.1875,1.03125 q -0.35938,-0.0625 -0.6875,-0.0625 -0.53125,0 -0.=
75,0.23437 -0.21875,0.21875 -0.21875,0.84375 v 0.64063 h 1.34375 v 0.90625 =
h -1.34375 v 6 z m 2.98423,-3.45313 q 0,-1.92187 1.07812,-2.84375 0.89063,-=
0.76562 2.17188,-0.76562 1.42187,0 2.32812,0.9375 0.90625,0.92187 0.90625,2=
.57812 0,1.32813 -0.40625,2.09375 -0.39062,0.76563 -1.15625,1.1875 -0.76562=
,0.42188 -1.67187,0.42188 -1.45313,0 -2.35938,-0.92188 -0.89062,-0.9375 -0.=
89062,-2.6875 z m 1.20312,0 q 0,1.32813 0.57813,1.98438 0.59375,0.65625 1.4=
6875,0.65625 0.875,0 1.45312,-0.65625 0.57813,-0.67188 0.57813,-2.03125 0,-=
1.28125 -0.59375,-1.9375 -0.57813,-0.65625 -1.4375,-0.65625 -0.875,0 -1.468=
75,0.65625 -0.57813,0.65625 -0.57813,1.98437 z m 6.63123,3.45313 v -6.90625=
 h 1.0625 v 1.04687 q 0.40625,-0.73437 0.73437,-0.96875 0.34375,-0.23437 0.=
76563,-0.23437 0.59375,0 1.20312,0.375 l -0.40625,1.07812 q -0.4375,-0.25 -=
0.85937,-0.25 -0.39063,0 -0.70313,0.23438 -0.29687,0.23437 -0.42187,0.64062=
 -0.20313,0.625 -0.20313,1.35938 v 3.625 z m 8.15698,2.65625 v -9.5625 h 1.=
07812 v 0.89062 q 0.375,-0.53125 0.84375,-0.78125 0.48438,-0.26562 1.15625,=
-0.26562 0.875,0 1.54688,0.45312 0.68752,0.45313 1.03122,1.28125 0.3438,0.8=
2813 0.3438,1.82813 0,1.04687 -0.375,1.90625 -0.375,0.84375 -1.1094,1.29687=
 -0.71875,0.45313 -1.53125,0.45313 -0.57812,0 -1.04687,-0.25 -0.46875,-0.25=
 -0.76563,-0.625 v 3.375 z m 1.0625,-6.07813 q 0,1.34375 0.53125,1.98438 0.=
54687,0.625 1.3125,0.625 0.78125,0 1.34375,-0.65625 0.5625,-0.65625 0.5625,=
-2.04688 0,-1.3125 -0.54688,-1.96875 -0.54687,-0.67187 -1.29687,-0.67187 -0=
.75,0 -1.32813,0.70312 -0.57812,0.70313 -0.57812,2.03125 z m 11.08432,1.203=
13 1.2031,0.14062 q -0.2812,1.0625 -1.0625,1.65625 -0.7656,0.57813 -1.9687,=
0.57813 -1.5156,0 -2.4063,-0.9375 -0.8906,-0.9375 -0.8906,-2.60938 0,-1.75 =
0.8906,-2.70312 0.9063,-0.96875 2.3438,-0.96875 1.3906,0 2.2656,0.9375 0.87=
5,0.9375 0.875,2.65625 0,0.10937 0,0.3125 h -5.1562 q 0.062,1.14062 0.6406,=
1.75 0.5781,0.59375 1.4375,0.59375 0.6562,0 1.1094,-0.32813 0.4531,-0.34375=
 0.7187,-1.07812 z m -3.8437,-1.90625 h 3.8593 q -0.078,-0.85938 -0.4375,-1=
.29688 -0.5625,-0.6875 -1.4531,-0.6875 -0.8125,0 -1.3594,0.54688 -0.5468,0.=
53125 -0.6093,1.4375 z m 6.5219,4.125 v -6.90625 h 1.0625 v 0.98437 q 0.75,=
-1.14062 2.1875,-1.14062 0.625,0 1.1562,0.21875 0.5313,0.21875 0.7813,0.593=
75 0.2656,0.35937 0.375,0.85937 0.062,0.32813 0.062,1.14063 v 4.25 h -1.171=
9 v -4.20313 q 0,-0.71875 -0.1406,-1.0625 -0.1407,-0.35937 -0.4844,-0.5625 =
-0.3438,-0.21875 -0.8125,-0.21875 -0.75,0 -1.2969,0.46875 -0.5469,0.46875 -=
0.5469,1.79688 v 3.78125 z m 11.8968,0 v -0.875 q -0.6562,1.03125 -1.9375,1=
.03125 -0.8125,0 -1.5156,-0.45313 -0.6875,-0.45312 -1.0781,-1.26562 -0.375,=
-0.82813 -0.375,-1.89063 0,-1.03125 0.3437,-1.875 0.3438,-0.84375 1.0313,-1=
.28125 0.7031,-0.45312 1.5468,-0.45312 0.625,0 1.1094,0.26562 0.5,0.25 0.79=
69,0.67188 v -3.42188 h 1.1719 v 9.54688 z m -3.7031,-3.45313 q 0,1.32813 0=
.5625,1.98438 0.5625,0.65625 1.3281,0.65625 0.7656,0 1.2969,-0.625 0.5312,-=
0.625 0.5312,-1.90625 0,-1.42188 -0.5468,-2.07813 -0.5469,-0.67187 -1.3438,=
-0.67187 -0.7812,0 -1.3125,0.64062 -0.5156,0.625 -0.5156,2 z m 6.6468,-4.73=
437 v -1.35938 h 1.1719 v 1.35938 z m 0,8.1875 v -6.90625 h 1.1719 v 6.9062=
5 z m 2.9455,0 v -6.90625 h 1.0625 v 0.98437 q 0.75,-1.14062 2.1875,-1.1406=
2 0.625,0 1.1562,0.21875 0.5313,0.21875 0.7813,0.59375 0.2656,0.35937 0.375=
,0.85937 0.062,0.32813 0.062,1.14063 v 4.25 h -1.1719 v -4.20313 q 0,-0.718=
75 -0.1406,-1.0625 -0.1407,-0.35937 -0.4844,-0.5625 -0.3438,-0.21875 -0.812=
5,-0.21875 -0.75,0 -1.2969,0.46875 -0.5469,0.46875 -0.5469,1.79688 v 3.7812=
5 z m 7.1937,0.57812 1.1406,0.15625 q 0.078,0.53125 0.4063,0.78125 0.4375,0=
.3125 1.1875,0.3125 0.8125,0 1.25,-0.32812 0.4531,-0.3125 0.6093,-0.90625 0=
.094,-0.35938 0.078,-1.5 -0.7656,0.90625 -1.9062,0.90625 -1.4375,0 -2.2188,=
-1.03125 -0.7812,-1.03125 -0.7812,-2.46875 0,-0.98438 0.3594,-1.8125 0.3593=
,-0.84375 1.0312,-1.29688 0.6875,-0.45312 1.6094,-0.45312 1.2187,0 2.0156,0=
.98437 v -0.82812 h 1.0781 v 5.96875 q 0,1.60937 -0.3281,2.28125 -0.3281,0.=
6875 -1.0469,1.07812 -0.7031,0.39063 -1.75,0.39063 -1.2343,0 -2,-0.5625 -0.=
75,-0.5625 -0.7343,-1.67188 z m 0.9844,-4.15625 q 0,1.35938 0.5312,1.98438 =
0.5469,0.625 1.3594,0.625 0.7969,0 1.3437,-0.625 0.5469,-0.625 0.5469,-1.95=
313 0,-1.26562 -0.5625,-1.90625 -0.5625,-0.64062 -1.3594,-0.64062 -0.7656,0=
 -1.3125,0.64062 -0.5468,0.625 -0.5468,1.875 z m 9.8811,1.51563 1.1562,-0.1=
875 q 0.1094,0.70312 0.5469,1.07812 0.4531,0.35938 1.25,0.35938 0.8125,0 1.=
2031,-0.32813 0.3907,-0.32812 0.3907,-0.76562 0,-0.39063 -0.3594,-0.625 -0.=
2344,-0.15625 -1.1875,-0.39063 -1.2969,-0.32812 -1.7969,-0.5625 -0.4844,-0.=
25 -0.75,-0.65625 -0.25,-0.42187 -0.25,-0.9375 0,-0.45312 0.2031,-0.84375 0=
.2188,-0.40625 0.5782,-0.67187 0.2812,-0.1875 0.75,-0.32813 0.4687,-0.14062=
 1.0156,-0.14062 0.8125,0 1.4219,0.23437 0.6093,0.23438 0.9062,0.64063 0.29=
69,0.39062 0.4063,1.0625 l -1.1407,0.15625 q -0.078,-0.53125 -0.4531,-0.828=
13 -0.375,-0.3125 -1.0625,-0.3125 -0.8125,0 -1.1562,0.26563 -0.3438,0.26562=
 -0.3438,0.625 0,0.23437 0.1406,0.42187 0.1563,0.1875 0.4532,0.3125 0.1718,=
0.0625 1.0312,0.29688 1.25,0.32812 1.7344,0.54687 0.5,0.20313 0.7812,0.6093=
8 0.2813,0.40625 0.2813,1 0,0.59375 -0.3438,1.10937 -0.3437,0.51563 -1,0.79=
688 -0.6406,0.28125 -1.4531,0.28125 -1.3437,0 -2.0469,-0.5625 -0.7031,-0.56=
25 -0.9062,-1.65625 z m 9.6953,1.01562 0.1719,1.03125 q -0.5,0.10938 -0.890=
7,0.10938 -0.6406,0 -1,-0.20313 -0.3437,-0.20312 -0.4843,-0.53125 -0.1407,-=
0.32812 -0.1407,-1.39062 v -3.96875 h -0.8593 v -0.90625 h 0.8593 v -1.7187=
5 l 1.1719,-0.70313 v 2.42188 h 1.1719 v 0.90625 h -1.1719 v 4.04687 q 0,0.=
5 0.047,0.64063 0.062,0.14062 0.2031,0.23437 0.1407,0.0781 0.4063,0.0781 0.=
2031,0 0.5156,-0.0469 z m 1.1249,1.04688 v -6.90625 h 1.0625 v 1.04687 q 0.=
4062,-0.73437 0.7343,-0.96875 0.3438,-0.23437 0.7657,-0.23437 0.5937,0 1.20=
31,0.375 l -0.4063,1.07812 q -0.4375,-0.25 -0.8593,-0.25 -0.3907,0 -0.7032,=
0.23438 -0.2968,0.23437 -0.4218,0.64062 -0.2032,0.625 -0.2032,1.35938 v 3.6=
25 z m 9.1883,-2.21875 1.2031,0.14062 q -0.2812,1.0625 -1.0625,1.65625 -0.7=
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
,-0.39063 0.1875,-1.17188 z m 2.9906,3.46875 v -6.90625 h 1.0469 v 0.96875 =
q 0.3281,-0.51563 0.8594,-0.8125 0.5469,-0.3125 1.2344,-0.3125 0.7812,0 1.2=
656,0.3125 0.4844,0.3125 0.6875,0.89062 0.8281,-1.20312 2.1406,-1.20312 1.0=
313,0 1.5781,0.57812 0.5625,0.5625 0.5625,1.73438 v 4.75 h -1.1718 v -4.359=
38 q 0,-0.70312 -0.125,-1 -0.1094,-0.3125 -0.4063,-0.5 -0.2969,-0.1875 -0.7=
031,-0.1875 -0.7188,0 -1.2031,0.48438 -0.4844,0.48437 -0.4844,1.54687 v 4.0=
1563 h -1.1719 v -4.48438 q 0,-0.78125 -0.2969,-1.17187 -0.2812,-0.39063 -0=
.9218,-0.39063 -0.5,0 -0.9219,0.26563 -0.4219,0.25 -0.6094,0.75 -0.1875,0.5=
 -0.1875,1.45312 v 3.57813 z m 10.6337,-2.0625 1.1563,-0.1875 q 0.1093,0.70=
312 0.5468,1.07812 0.4532,0.35938 1.25,0.35938 0.8125,0 1.2032,-0.32813 0.3=
906,-0.32812 0.3906,-0.76562 0,-0.39063 -0.3594,-0.625 -0.2344,-0.15625 -1.=
1875,-0.39063 -1.2969,-0.32812 -1.7969,-0.5625 -0.4843,-0.25 -0.75,-0.65625=
 -0.25,-0.42187 -0.25,-0.9375 0,-0.45312 0.2032,-0.84375 0.2187,-0.40625 0.=
5781,-0.67187 0.2812,-0.1875 0.75,-0.32813 0.4687,-0.14062 1.0156,-0.14062 =
0.8125,0 1.4219,0.23437 0.6094,0.23438 0.9062,0.64063 0.2969,0.39062 0.4063=
,1.0625 l -1.1406,0.15625 q -0.078,-0.53125 -0.4532,-0.82813 -0.375,-0.3125=
 -1.0625,-0.3125 -0.8125,0 -1.1562,0.26563 -0.3438,0.26562 -0.3438,0.625 0,=
0.23437 0.1407,0.42187 0.1562,0.1875 0.4531,0.3125 0.1719,0.0625 1.0312,0.2=
9688 1.25,0.32812 1.7344,0.54687 0.5,0.20313 0.7813,0.60938 0.2812,0.40625 =
0.2812,1 0,0.59375 -0.3437,1.10937 -0.3438,0.51563 -1,0.79688 -0.6407,0.281=
25 -1.4532,0.28125 -1.3437,0 -2.0468,-0.5625 -0.7032,-0.5625 -0.9063,-1.656=
25 z"
-       fill-rule=3D"nonzero"
-       id=3D"path380"
-       style=3D"fill:#88aa00" />
-    <path
-       fill=3D"#000000"
-       fill-opacity=3D"0"
-       d=3D"m 517.42329,154.1406 h 115.4646 v 27.46455 h -115.4646 z"
-       fill-rule=3D"evenodd"
-       id=3D"path382" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 533.48579,171.64496 1.125,0.29687 q -0.3594,1.39063 -1.2813,=
2.125 -0.9218,0.73438 -2.2656,0.73438 -1.3906,0 -2.2656,-0.5625 -0.875,-0.5=
625 -1.3281,-1.625 -0.4532,-1.07813 -0.4532,-2.3125 0,-1.34375 0.5157,-2.34=
375 0.5156,-1 1.4531,-1.51563 0.9531,-0.51562 2.0937,-0.51562 1.2813,0 2.15=
63,0.65625 0.8906,0.65625 1.2344,1.84375 l -1.125,0.26562 q -0.2969,-0.9375=
 -0.875,-1.35937 -0.5625,-0.4375 -1.4219,-0.4375 -0.9844,0 -1.6563,0.48437 =
-0.6562,0.46875 -0.9375,1.26563 -0.2656,0.79687 -0.2656,1.65625 0,1.09375 0=
.3125,1.90625 0.3281,0.8125 1,1.21875 0.6719,0.40625 1.4688,0.40625 0.9531,=
0 1.6093,-0.54688 0.6719,-0.54687 0.9063,-1.64062 z m 2.4004,-4.35938 v -1.=
21875 h 1.0625 v 1.21875 z m 0,7.375 v -6.21875 h 1.0625 v 6.21875 z m 2.65=
04,0 v -6.21875 h 0.9531 v 0.9375 q 0.3594,-0.65625 0.6563,-0.85937 0.3125,=
-0.21875 0.6875,-0.21875 0.5312,0 1.0781,0.32812 l -0.3594,0.98438 q -0.390=
6,-0.23438 -0.7656,-0.23438 -0.3594,0 -0.6406,0.21875 -0.2657,0.20313 -0.37=
5,0.57813 -0.1875,0.5625 -0.1875,1.21875 v 3.26562 z m 8.0742,-2.28125 1.03=
12,0.14063 q -0.1718,1.0625 -0.875,1.67187 -0.7031,0.60938 -1.7187,0.60938 =
-1.2813,0 -2.0625,-0.82813 -0.7656,-0.84375 -0.7656,-2.40625 0,-1 0.3281,-1=
.75 0.3437,-0.76562 1.0156,-1.14062 0.6875,-0.375 1.5,-0.375 1,0 1.6406,0.5=
1562 0.6563,0.5 0.8438,1.45313 l -1.0313,0.15625 q -0.1406,-0.625 -0.5156,-=
0.9375 -0.375,-0.32813 -0.9062,-0.32813 -0.7969,0 -1.2969,0.57813 -0.5,0.56=
25 -0.5,1.79687 0,1.26563 0.4844,1.82813 0.4843,0.5625 1.25,0.5625 0.625,0 =
1.0312,-0.375 0.4219,-0.375 0.5469,-1.17188 z m 6.0156,2.28125 v -0.92187 q=
 -0.7344,1.0625 -1.9844,1.0625 -0.5468,0 -1.0312,-0.20313 -0.4688,-0.21875 =
-0.7031,-0.53125 -0.2344,-0.32812 -0.3282,-0.79687 -0.062,-0.29688 -0.062,-=
0.98438 v -3.84375 h 1.0625 v 3.45313 q 0,0.8125 0.062,1.10937 0.094,0.4062=
5 0.4063,0.65625 0.3281,0.23438 0.8125,0.23438 0.4687,0 0.875,-0.23438 0.42=
19,-0.25 0.5937,-0.67187 0.1875,-0.42188 0.1875,-1.21875 v -3.32813 h 1.046=
9 v 6.21875 z m 2.5645,0 v -8.59375 h 1.0625 v 8.59375 z m 6.7597,-0.76562 =
q -0.5937,0.5 -1.1406,0.70312 -0.5312,0.20313 -1.1562,0.20313 -1.0313,0 -1.=
5782,-0.5 -0.5468,-0.5 -0.5468,-1.28125 0,-0.45313 0.2031,-0.82813 0.2031,-=
0.39062 0.5469,-0.60937 0.3437,-0.23438 0.7656,-0.34375 0.2969,-0.0937 0.93=
75,-0.17188 1.2656,-0.14062 1.875,-0.35937 0,-0.21875 0,-0.26563 0,-0.65625=
 -0.2969,-0.92187 -0.4062,-0.34375 -1.2031,-0.34375 -0.7344,0 -1.0938,0.265=
62 -0.3593,0.25 -0.5312,0.90625 l -1.0313,-0.14062 q 0.1407,-0.65625 0.4688=
,-1.0625 0.3281,-0.40625 0.9375,-0.625 0.6094,-0.21875 1.4062,-0.21875 0.79=
69,0 1.2969,0.1875 0.5,0.1875 0.7344,0.46875 0.2344,0.28125 0.3281,0.71875 =
0.047,0.26562 0.047,0.96875 v 1.40625 q 0,1.46875 0.062,1.85937 0.078,0.390=
63 0.2813,0.75 h -1.1094 q -0.1563,-0.32812 -0.2031,-0.76562 z m -0.094,-2.=
35938 q -0.5781,0.23438 -1.7187,0.40625 -0.6563,0.0937 -0.9219,0.21875 -0.2=
656,0.10938 -0.4219,0.32813 -0.1406,0.21875 -0.1406,0.5 0,0.42187 0.3125,0.=
70312 0.3281,0.28125 0.9375,0.28125 0.6094,0 1.0781,-0.26562 0.4844,-0.2656=
3 0.7032,-0.73438 0.1718,-0.35937 0.1718,-1.04687 z m 2.6895,3.125 v -6.218=
75 h 0.9531 v 0.9375 q 0.3594,-0.65625 0.6563,-0.85937 0.3125,-0.21875 0.68=
75,-0.21875 0.5312,0 1.0781,0.32812 l -0.3594,0.98438 q -0.3906,-0.23438 -0=
.7656,-0.23438 -0.3594,0 -0.6406,0.21875 -0.2657,0.20313 -0.375,0.57813 -0.=
1875,0.5625 -0.1875,1.21875 v 3.26562 z m 8.3144,0 h -0.9843 v -8.59375 h 1=
.0625 v 3.0625 q 0.6718,-0.82812 1.7031,-0.82812 0.5781,0 1.0781,0.23437 0.=
5156,0.21875 0.8438,0.64063 0.3437,0.42187 0.5312,1.01562 0.1875,0.59375 0.=
1875,1.26563 0,1.59375 -0.7969,2.46875 -0.7968,0.875 -1.8906,0.875 -1.1094,=
0 -1.7344,-0.92188 z m -0.016,-3.15625 q 0,1.10938 0.3125,1.60938 0.5,0.812=
5 1.3438,0.8125 0.6875,0 1.1875,-0.59375 0.5156,-0.59375 0.5156,-1.79688 0,=
-1.21875 -0.4844,-1.79687 -0.4843,-0.57813 -1.1718,-0.57813 -0.6875,0 -1.20=
32,0.60938 -0.5,0.59375 -0.5,1.73437 z m 9.7989,3.15625 v -0.92187 q -0.734=
4,1.0625 -1.9844,1.0625 -0.5469,0 -1.0313,-0.20313 -0.4687,-0.21875 -0.7031=
,-0.53125 -0.2344,-0.32812 -0.3281,-0.79687 -0.062,-0.29688 -0.062,-0.98438=
 v -3.84375 h 1.0625 v 3.45313 q 0,0.8125 0.062,1.10937 0.094,0.40625 0.406=
2,0.65625 0.3282,0.23438 0.8125,0.23438 0.4688,0 0.875,-0.23438 0.4219,-0.2=
5 0.5938,-0.67187 0.1875,-0.42188 0.1875,-1.21875 v -3.32813 h 1.0469 v 6.2=
1875 z m 2.8457,0 v -5.40625 h -0.9375 v -0.8125 h 0.9375 v -0.67187 q 0,-0=
.625 0.1093,-0.92188 0.1563,-0.42187 0.5313,-0.67187 0.3906,-0.25 1.0781,-0=
.25 0.4531,0 0.9844,0.10937 l -0.1563,0.90625 q -0.3281,-0.0469 -0.625,-0.0=
469 -0.4843,0 -0.6875,0.20312 -0.1875,0.20313 -0.1875,0.76563 v 0.57812 h 1=
.2188 v 0.8125 h -1.2188 v 5.40625 z m 5.9961,-1.85937 1.0312,-0.15625 q 0.=
094,0.625 0.4844,0.95312 0.4062,0.32813 1.1406,0.32813 0.7188,0 1.0625,-0.2=
8125 0.3594,-0.29688 0.3594,-0.70313 0,-0.35937 -0.3125,-0.5625 -0.2188,-0.=
14062 -1.0781,-0.35937 -1.1563,-0.29688 -1.6094,-0.5 -0.4375,-0.21875 -0.67=
19,-0.59375 -0.2344,-0.375 -0.2344,-0.84375 0,-0.40625 0.1875,-0.76563 0.18=
75,-0.35937 0.5157,-0.59375 0.25,-0.17187 0.6718,-0.29687 0.4219,-0.125 0.9=
219,-0.125 0.7188,0 1.2656,0.21875 0.5625,0.20312 0.8282,0.5625 0.2656,0.35=
937 0.3593,0.95312 l -1.0312,0.14063 q -0.062,-0.46875 -0.4063,-0.73438 -0.=
3281,-0.28125 -0.9531,-0.28125 -0.7187,0 -1.0312,0.25 -0.3125,0.23438 -0.31=
25,0.5625 0,0.20313 0.125,0.35938 0.1406,0.17187 0.4062,0.28125 0.1563,0.06=
25 0.9375,0.26562 1.125,0.3125 1.5625,0.5 0.4375,0.1875 0.6875,0.54688 0.25=
,0.35937 0.25,0.90625 0,0.53125 -0.3125,1 -0.2969,0.45312 -0.875,0.71875 -0=
.5781,0.25 -1.3125,0.25 -1.2187,0 -1.8594,-0.5 -0.625,-0.51563 -0.7968,-1.5=
 z m 8.7187,0.92187 0.1563,0.92188 q -0.4532,0.0937 -0.7969,0.0937 -0.5781,=
0 -0.8906,-0.17188 -0.3125,-0.1875 -0.4532,-0.48437 -0.125,-0.29688 -0.125,=
-1.25 v -3.57813 h -0.7656 v -0.8125 h 0.7656 v -1.54687 l 1.0469,-0.625 v =
2.17187 h 1.0625 v 0.8125 h -1.0625 v 3.64063 q 0,0.45312 0.047,0.57812 0.0=
62,0.125 0.1875,0.20313 0.125,0.0781 0.3594,0.0781 0.1875,0 0.4687,-0.0312 =
z m 5.0996,0.17188 q -0.5937,0.5 -1.1406,0.70312 -0.5313,0.20313 -1.1563,0.=
20313 -1.0312,0 -1.5781,-0.5 -0.5469,-0.5 -0.5469,-1.28125 0,-0.45313 0.203=
2,-0.82813 0.2031,-0.39062 0.5468,-0.60937 0.3438,-0.23438 0.7657,-0.34375 =
0.2968,-0.0937 0.9375,-0.17188 1.2656,-0.14062 1.875,-0.35937 0,-0.21875 0,=
-0.26563 0,-0.65625 -0.2969,-0.92187 -0.4063,-0.34375 -1.2031,-0.34375 -0.7=
344,0 -1.0938,0.26562 -0.3594,0.25 -0.5312,0.90625 l -1.0313,-0.14062 q 0.1=
406,-0.65625 0.4688,-1.0625 0.3281,-0.40625 0.9375,-0.625 0.6093,-0.21875 1=
.4062,-0.21875 0.7969,0 1.2969,0.1875 0.5,0.1875 0.7344,0.46875 0.2343,0.28=
125 0.3281,0.71875 0.047,0.26562 0.047,0.96875 v 1.40625 q 0,1.46875 0.062,=
1.85937 0.078,0.39063 0.2812,0.75 h -1.1093 q -0.1563,-0.32812 -0.2032,-0.7=
6562 z m -0.094,-2.35938 q -0.5781,0.23438 -1.7187,0.40625 -0.6563,0.0937 -=
0.9219,0.21875 -0.2656,0.10938 -0.4219,0.32813 -0.1406,0.21875 -0.1406,0.5 =
0,0.42187 0.3125,0.70312 0.3281,0.28125 0.9375,0.28125 0.6094,0 1.0781,-0.2=
6562 0.4844,-0.26563 0.7031,-0.73438 0.1719,-0.35937 0.1719,-1.04687 z m 2.=
6895,3.125 v -6.21875 h 0.9531 v 0.9375 q 0.3594,-0.65625 0.6563,-0.85937 0=
.3125,-0.21875 0.6875,-0.21875 0.5312,0 1.0781,0.32812 l -0.3594,0.98438 q =
-0.3906,-0.23438 -0.7656,-0.23438 -0.3594,0 -0.6406,0.21875 -0.2657,0.20313=
 -0.375,0.57813 -0.1875,0.5625 -0.1875,1.21875 v 3.26562 z m 6.3086,-0.9375=
 0.1562,0.92188 q -0.4531,0.0937 -0.7969,0.0937 -0.5781,0 -0.8906,-0.17188 =
-0.3125,-0.1875 -0.4531,-0.48437 -0.125,-0.29688 -0.125,-1.25 v -3.57813 h =
-0.7656 v -0.8125 h 0.7656 v -1.54687 l 1.0469,-0.625 v 2.17187 h 1.0625 v =
0.8125 h -1.0625 v 3.64063 q 0,0.45312 0.047,0.57812 0.062,0.125 0.1875,0.2=
0313 0.125,0.0781 0.3594,0.0781 0.1875,0 0.4687,-0.0312 z"
-       fill-rule=3D"nonzero"
-       id=3D"path384" />
-    <path
-       fill=3D"#000000"
-       fill-opacity=3D"0"
-       d=3D"m 590.79859,181.60515 h -61.2598"
-       fill-rule=3D"evenodd"
-       id=3D"path386" />
-    <path
-       stroke=3D"#595959"
-       stroke-width=3D"1"
-       stroke-linejoin=3D"round"
-       stroke-linecap=3D"butt"
-       stroke-dasharray=3D"8, 3"
-       d=3D"m 590.79859,181.60515 h -55.2598"
-       fill-rule=3D"evenodd"
-       id=3D"path388"
-       style=3D"fill:#00ffcc" />
-    <path
-       fill=3D"#595959"
-       stroke=3D"#595959"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"m 535.53879,179.95344 -4.5381,1.65172 4.5381,1.65173 z"
-       fill-rule=3D"evenodd"
-       id=3D"path390" />
-    <path
-       fill=3D"#000000"
-       fill-opacity=3D"0"
-       d=3D"m 521.92459,298.1406 h 115.4645 v 27.46457 h -115.4645 z"
-       fill-rule=3D"evenodd"
-       id=3D"path392" />
-    <path
-       fill=3D"#000000"
-       d=3D"m 537.98709,315.64498 1.125,0.29687 q -0.3594,1.39063 -1.2813,=
2.125 -0.9218,0.73438 -2.2656,0.73438 -1.3906,0 -2.2656,-0.5625 -0.875,-0.5=
625 -1.3281,-1.625 -0.4532,-1.07813 -0.4532,-2.3125 0,-1.34375 0.5157,-2.34=
375 0.5156,-1 1.4531,-1.51563 0.9531,-0.51562 2.0937,-0.51562 1.2813,0 2.15=
63,0.65625 0.8906,0.65625 1.2344,1.84375 l -1.125,0.26562 q -0.2969,-0.9375=
 -0.875,-1.35937 -0.5625,-0.4375 -1.4219,-0.4375 -0.9844,0 -1.6563,0.48437 =
-0.6562,0.46875 -0.9375,1.26563 -0.2656,0.79687 -0.2656,1.65625 0,1.09375 0=
.3125,1.90625 0.3281,0.8125 1,1.21875 0.6719,0.40625 1.4688,0.40625 0.9531,=
0 1.6093,-0.54688 0.6719,-0.54687 0.9063,-1.64062 z m 2.4004,-4.35938 v -1.=
21875 h 1.0625 v 1.21875 z m 0,7.375 v -6.21875 h 1.0625 v 6.21875 z m 2.65=
04,0 v -6.21875 h 0.9531 v 0.9375 q 0.3594,-0.65625 0.6563,-0.85937 0.3125,=
-0.21875 0.6875,-0.21875 0.5312,0 1.0781,0.32812 l -0.3594,0.98438 q -0.390=
6,-0.23438 -0.7656,-0.23438 -0.3594,0 -0.6406,0.21875 -0.2657,0.20313 -0.37=
5,0.57813 -0.1875,0.5625 -0.1875,1.21875 v 3.26562 z m 8.0742,-2.28125 1.03=
12,0.14063 q -0.1718,1.0625 -0.875,1.67187 -0.7031,0.60938 -1.7187,0.60938 =
-1.2813,0 -2.0625,-0.82813 -0.7656,-0.84375 -0.7656,-2.40625 0,-1 0.3281,-1=
.75 0.3437,-0.76562 1.0156,-1.14062 0.6875,-0.375 1.5,-0.375 1,0 1.6406,0.5=
1562 0.6563,0.5 0.8438,1.45313 l -1.0313,0.15625 q -0.1406,-0.625 -0.5156,-=
0.9375 -0.375,-0.32813 -0.9062,-0.32813 -0.7969,0 -1.2969,0.57813 -0.5,0.56=
25 -0.5,1.79687 0,1.26563 0.4844,1.82813 0.4843,0.5625 1.25,0.5625 0.625,0 =
1.0312,-0.375 0.4219,-0.375 0.5469,-1.17188 z m 6.0156,2.28125 v -0.92187 q=
 -0.7344,1.0625 -1.9844,1.0625 -0.5468,0 -1.0312,-0.20313 -0.4688,-0.21875 =
-0.7031,-0.53125 -0.2344,-0.32812 -0.3282,-0.79687 -0.062,-0.29688 -0.062,-=
0.98438 v -3.84375 h 1.0625 v 3.45313 q 0,0.8125 0.062,1.10937 0.094,0.4062=
5 0.4063,0.65625 0.3281,0.23438 0.8125,0.23438 0.4687,0 0.875,-0.23438 0.42=
19,-0.25 0.5937,-0.67187 0.1875,-0.42188 0.1875,-1.21875 v -3.32813 h 1.046=
9 v 6.21875 z m 2.5645,0 v -8.59375 h 1.0625 v 8.59375 z m 6.7597,-0.76562 =
q -0.5937,0.5 -1.1406,0.70312 -0.5312,0.20313 -1.1562,0.20313 -1.0313,0 -1.=
5782,-0.5 -0.5468,-0.5 -0.5468,-1.28125 0,-0.45313 0.2031,-0.82813 0.2031,-=
0.39062 0.5469,-0.60937 0.3437,-0.23438 0.7656,-0.34375 0.2969,-0.0937 0.93=
75,-0.17188 1.2656,-0.14062 1.875,-0.35937 0,-0.21875 0,-0.26563 0,-0.65625=
 -0.2969,-0.92187 -0.4062,-0.34375 -1.2031,-0.34375 -0.7344,0 -1.0938,0.265=
62 -0.3593,0.25 -0.5312,0.90625 l -1.0313,-0.14062 q 0.1407,-0.65625 0.4688=
,-1.0625 0.3281,-0.40625 0.9375,-0.625 0.6094,-0.21875 1.4062,-0.21875 0.79=
69,0 1.2969,0.1875 0.5,0.1875 0.7344,0.46875 0.2344,0.28125 0.3281,0.71875 =
0.047,0.26562 0.047,0.96875 v 1.40625 q 0,1.46875 0.062,1.85937 0.078,0.390=
63 0.2813,0.75 h -1.1094 q -0.1563,-0.32812 -0.2031,-0.76562 z m -0.094,-2.=
35938 q -0.5781,0.23438 -1.7187,0.40625 -0.6563,0.0937 -0.9219,0.21875 -0.2=
656,0.10938 -0.4219,0.32813 -0.1406,0.21875 -0.1406,0.5 0,0.42187 0.3125,0.=
70312 0.3281,0.28125 0.9375,0.28125 0.6094,0 1.0781,-0.26562 0.4844,-0.2656=
3 0.7032,-0.73438 0.1718,-0.35937 0.1718,-1.04687 z m 2.6895,3.125 v -6.218=
75 h 0.9531 v 0.9375 q 0.3594,-0.65625 0.6563,-0.85937 0.3125,-0.21875 0.68=
75,-0.21875 0.5312,0 1.0781,0.32812 l -0.3594,0.98438 q -0.3906,-0.23438 -0=
.7656,-0.23438 -0.3594,0 -0.6406,0.21875 -0.2657,0.20313 -0.375,0.57813 -0.=
1875,0.5625 -0.1875,1.21875 v 3.26562 z m 8.3144,0 h -0.9843 v -8.59375 h 1=
.0625 v 3.0625 q 0.6718,-0.82812 1.7031,-0.82812 0.5781,0 1.0781,0.23437 0.=
5156,0.21875 0.8438,0.64063 0.3437,0.42187 0.5312,1.01562 0.1875,0.59375 0.=
1875,1.26563 0,1.59375 -0.7969,2.46875 -0.7968,0.875 -1.8906,0.875 -1.1094,=
0 -1.7344,-0.92188 z m -0.016,-3.15625 q 0,1.10938 0.3125,1.60938 0.5,0.812=
5 1.3438,0.8125 0.6875,0 1.1875,-0.59375 0.5156,-0.59375 0.5156,-1.79688 0,=
-1.21875 -0.4844,-1.79687 -0.4843,-0.57813 -1.1718,-0.57813 -0.6875,0 -1.20=
32,0.60938 -0.5,0.59375 -0.5,1.73437 z m 9.7989,3.15625 v -0.92187 q -0.734=
4,1.0625 -1.9844,1.0625 -0.5469,0 -1.0313,-0.20313 -0.4687,-0.21875 -0.7031=
,-0.53125 -0.2344,-0.32812 -0.3281,-0.79687 -0.062,-0.29688 -0.062,-0.98438=
 v -3.84375 h 1.0625 v 3.45313 q 0,0.8125 0.062,1.10937 0.094,0.40625 0.406=
2,0.65625 0.3282,0.23438 0.8125,0.23438 0.4688,0 0.875,-0.23438 0.4219,-0.2=
5 0.5938,-0.67187 0.1875,-0.42188 0.1875,-1.21875 v -3.32813 h 1.0469 v 6.2=
1875 z m 2.8457,0 v -5.40625 h -0.9375 v -0.8125 h 0.9375 v -0.67187 q 0,-0=
.625 0.1093,-0.92188 0.1563,-0.42187 0.5313,-0.67187 0.3906,-0.25 1.0781,-0=
.25 0.4531,0 0.9844,0.10937 l -0.1563,0.90625 q -0.3281,-0.0469 -0.625,-0.0=
469 -0.4843,0 -0.6875,0.20312 -0.1875,0.20313 -0.1875,0.76563 v 0.57812 h 1=
.2188 v 0.8125 h -1.2188 v 5.40625 z m 10.6679,-2 1.0938,0.125 q -0.25,0.95=
313 -0.9531,1.48438 -0.7032,0.53125 -1.7813,0.53125 -1.3594,0 -2.1719,-0.84=
375 -0.7968,-0.84375 -0.7968,-2.35938 0,-1.5625 0.8125,-2.42187 0.8125,-0.8=
75 2.0937,-0.875 1.25,0 2.0313,0.84375 0.7968,0.84375 0.7968,2.39062 0,0.09=
37 0,0.28125 h -4.6406 q 0.062,1.03125 0.5781,1.57813 0.5157,0.53125 1.2969=
,0.53125 0.5781,0 0.9844,-0.29688 0.4219,-0.3125 0.6562,-0.96875 z m -3.453=
1,-1.70312 h 3.4688 q -0.062,-0.79688 -0.3907,-1.1875 -0.5156,-0.60938 -1.3=
125,-0.60938 -0.7343,0 -1.2343,0.48438 -0.4844,0.48437 -0.5313,1.3125 z m 5=
.877,3.70312 v -6.21875 h 0.9375 v 0.875 q 0.6875,-1.01562 1.9843,-1.01562 =
0.5625,0 1.0313,0.20312 0.4844,0.20313 0.7187,0.53125 0.2344,0.32813 0.3282=
,0.76563 0.047,0.29687 0.047,1.03125 v 3.82812 h -1.0469 v -3.78125 q 0,-0.=
65625 -0.125,-0.96875 -0.125,-0.3125 -0.4375,-0.5 -0.3125,-0.20312 -0.7344,=
-0.20312 -0.6719,0 -1.1719,0.4375 -0.4843,0.42187 -0.4843,1.60937 v 3.40625=
 z m 10.705,0 v -0.78125 q -0.5937,0.92188 -1.7343,0.92188 -0.75,0 -1.375,-=
0.40625 -0.625,-0.42188 -0.9688,-1.15625 -0.3437,-0.73438 -0.3437,-1.6875 0=
,-0.92188 0.3125,-1.6875 0.3125,-0.76563 0.9375,-1.15625 0.625,-0.40625 1.3=
906,-0.40625 0.5625,0 1,0.23437 0.4375,0.23438 0.7187,0.60938 v -3.07813 h =
1.0469 v 8.59375 z m -3.3281,-3.10937 q 0,1.20312 0.5,1.79687 0.5,0.57813 1=
.1875,0.57813 0.6875,0 1.1719,-0.5625 0.4844,-0.5625 0.4844,-1.71875 0,-1.2=
8125 -0.5,-1.875 -0.4844,-0.59375 -1.2032,-0.59375 -0.7031,0 -1.1718,0.5781=
2 -0.4688,0.5625 -0.4688,1.79688 z"
-       fill-rule=3D"nonzero"
-       id=3D"path394" />
-    <path
-       fill=3D"#000000"
-       fill-opacity=3D"0"
-       d=3D"m 587.53349,322.39257 h -61.2598"
-       fill-rule=3D"evenodd"
-       id=3D"path396" />
-    <path
-       stroke=3D"#595959"
-       stroke-width=3D"1"
-       stroke-linejoin=3D"round"
-       stroke-linecap=3D"butt"
-       stroke-dasharray=3D"8, 3"
-       d=3D"m 587.53349,322.39257 h -55.2598"
-       fill-rule=3D"evenodd"
-       id=3D"path398"
-       style=3D"fill:#00ffcc" />
-    <path
-       fill=3D"#595959"
-       stroke=3D"#595959"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"m 532.27369,320.74084 -4.5381,1.65173 4.5381,1.65174 z"
-       fill-rule=3D"evenodd"
-       id=3D"path400" />
-    <path
-       fill=3D"#000000"
-       fill-opacity=3D"0"
-       d=3D"M 272.64375,180.18784 358.15556,77.542157"
-       fill-rule=3D"evenodd"
-       id=3D"path402" />
-    <path
-       stroke=3D"#a61c00"
-       stroke-width=3D"1"
-       stroke-linejoin=3D"round"
-       stroke-linecap=3D"butt"
-       stroke-dasharray=3D"1, 3"
-       d=3D"M 272.64375,180.18784 354.31514,82.152067"
-       fill-rule=3D"evenodd"
-       id=3D"path404" />
-    <path
-       fill=3D"#a61c00"
-       stroke=3D"#a61c00"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"m 355.58421,83.209287 1.63562,-4.54392 -4.17374,2.42948 z"
-       fill-rule=3D"evenodd"
-       id=3D"path406" />
-    <path
-       fill=3D"#000000"
-       fill-opacity=3D"0"
-       d=3D"m 272.24478,215.52642 88,105.60629"
-       fill-rule=3D"evenodd"
-       id=3D"path408" />
-    <path
-       stroke=3D"#a61c00"
-       stroke-width=3D"1"
-       stroke-linejoin=3D"round"
-       stroke-linecap=3D"butt"
-       stroke-dasharray=3D"1, 3"
-       d=3D"m 272.24478,215.52642 84.15903,100.99686"
-       fill-rule=3D"evenodd"
-       id=3D"path410" />
-    <path
-       fill=3D"#a61c00"
-       stroke=3D"#a61c00"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"m 355.1349,317.58065 4.17404,2.42899 -1.6362,-4.54374 z"
-       fill-rule=3D"evenodd"
-       id=3D"path412" />
-    <path
-       fill=3D"#000000"
-       fill-opacity=3D"0"
-       d=3D"M 272.24478,368.30334 684.11879,77.531667"
-       fill-rule=3D"evenodd"
-       id=3D"path414" />
-    <path
-       stroke=3D"#274e13"
-       stroke-width=3D"1"
-       stroke-linejoin=3D"round"
-       stroke-linecap=3D"butt"
-       stroke-dasharray=3D"1, 3"
-       d=3D"M 272.24478,368.30334 679.21719,80.992057"
-       fill-rule=3D"evenodd"
-       id=3D"path416" />
-    <path
-       fill=3D"#274e13"
-       stroke=3D"#274e13"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"m 680.16979,82.341417 2.7547,-3.96662 -4.6599,1.2679 z"
-       fill-rule=3D"evenodd"
-       id=3D"path418" />
-    <path
-       fill=3D"#000000"
-       fill-opacity=3D"0"
-       d=3D"M 272.24478,417.58678 688.21329,356.48442"
-       fill-rule=3D"evenodd"
-       id=3D"path420" />
-    <path
-       stroke=3D"#595959"
-       stroke-width=3D"1"
-       stroke-linejoin=3D"round"
-       stroke-linecap=3D"butt"
-       stroke-dasharray=3D"1, 3"
-       d=3D"M 272.24478,417.58678 682.27699,357.35643"
-       fill-rule=3D"evenodd"
-       id=3D"path422" />
-    <path
-       fill=3D"#595959"
-       stroke=3D"#595959"
-       stroke-width=3D"1"
-       stroke-linecap=3D"butt"
-       d=3D"m 682.51709,358.99062 4.2499,-2.29373 -4.73,-0.97467 z"
-       fill-rule=3D"evenodd"
-       id=3D"path424" />
-    <rect
-       style=3D"fill:none;fill-opacity:1;stroke:#741b47;stroke-width:1.146=
1;stroke-opacity:1"
-       id=3D"rect1"
-       width=3D"860.90546"
-       height=3D"529.77783"
-       x=3D"51.046341"
-       y=3D"34.574326" />
-    <text
-       xml:space=3D"preserve"
-       id=3D"text1"
-       style=3D"white-space:pre;shape-inside:url(#rect2);fill:none;stroke:=
#741b47;stroke-width:1.151" />
-    <text
-       xml:space=3D"preserve"
-       style=3D"fill:none;stroke:#741b47;stroke-width:1.151"
-       x=3D"159.96594"
-       y=3D"437.608"
-       id=3D"text3"><tspan
-         sodipodi:role=3D"line"
-         id=3D"tspan3"
-         x=3D"159.96594"
-         y=3D"437.608" /></text>
-    <text
-       xml:space=3D"preserve"
-       id=3D"text4"
-       style=3D"fill:none;stroke:#741b47;stroke-width:1.151;white-space:pr=
e;shape-inside:url(#rect5)" />
-    <text
-       xml:space=3D"preserve"
-       id=3D"text6"
-       style=3D"fill:none;stroke:#741b47;stroke-width:1.151;-inkscape-font=
-specification:Arial;font-family:Arial;font-weight:normal;font-style:normal=
;font-stretch:normal;font-variant:normal;line-height:0;white-space:pre;shap=
e-inside:url(#rect7)" />
-    <use
-       x=3D"0"
-       y=3D"0"
-       xlink:href=3D"#path290"
-       id=3D"use8" />
-    <text
-       xml:space=3D"preserve"
-       id=3D"text16"
-       style=3D"fill:#000000;-inkscape-font-specification:Arial;font-famil=
y:Arial;font-weight:normal;font-style:normal;font-stretch:normal;font-varia=
nt:normal;line-height:0;fill-rule:evenodd;fill-opacity:1;white-space:pre;sh=
ape-inside:url(#rect16)" />
-    <text
-       xml:space=3D"preserve"
-       style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;line-height:0;font-family:Arial;-inkscape-font-specifica=
tion:'Arial, Normal';fill:#000000;fill-opacity:1;fill-rule:evenodd;font-siz=
e:12px;font-variant-ligatures:normal;font-variant-caps:normal;font-variant-=
numeric:normal;font-variant-east-asian:normal"
-       x=3D"171.56448"
-       y=3D"438.474"
-       id=3D"text17"><tspan
-         sodipodi:role=3D"line"
-         id=3D"tspan17"
-         x=3D"171.56448"
-         y=3D"438.474">Node 1 xstats</tspan></text>
-    <text
-       xml:space=3D"preserve"
-       style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:12px;line-height:0;font-family:Arial;-inkscape=
-font-specification:'Arial, Normal';font-variant-ligatures:normal;font-vari=
ant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;=
fill:#000000;fill-opacity:1;fill-rule:evenodd"
-       x=3D"646.48962"
-       y=3D"409.63776"
-       id=3D"text17-1"><tspan
-         sodipodi:role=3D"line"
-         id=3D"tspan17-02"
-         x=3D"646.48962"
-         y=3D"409.63776">Node 1 </tspan></text>
-    <text
-       xml:space=3D"preserve"
-       style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:9.33333px;line-height:0;font-family:Arial;-ink=
scape-font-specification:'Arial, Normal';font-variant-ligatures:normal;font=
-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:no=
rmal;fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke-width:0.820641"
-       x=3D"717.65833"
-       y=3D"393.14011"
-       id=3D"text17-1-3"
-       transform=3D"scale(0.96355962,1.0378185)"><tspan
-         sodipodi:role=3D"line"
-         id=3D"tspan17-02-9"
-         x=3D"717.65833"
-         y=3D"393.14011"
-         style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:9.33333px;font-family:Arial;-inkscape-font-s=
pecification:'Arial, Normal';font-variant-ligatures:normal;font-variant-cap=
s:normal;font-variant-numeric:normal;font-variant-east-asian:normal;stroke-=
width:0.820641">xstat 1 </tspan></text>
-    <text
-       xml:space=3D"preserve"
-       style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:9.33333px;line-height:0;font-family:Arial;-ink=
scape-font-specification:'Arial, Normal';font-variant-ligatures:normal;font=
-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:no=
rmal;fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke-width:0.820641"
-       x=3D"731.20496"
-       y=3D"421.08084"
-       id=3D"text17-1-3-4"
-       transform=3D"scale(0.96355962,1.0378185)"><tspan
-         sodipodi:role=3D"line"
-         id=3D"tspan17-02-9-9"
-         x=3D"731.20496"
-         y=3D"421.08084"
-         style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:9.33333px;font-family:Arial;-inkscape-font-s=
pecification:'Arial, Normal';font-variant-ligatures:normal;font-variant-cap=
s:normal;font-variant-numeric:normal;font-variant-east-asian:normal;stroke-=
width:0.820641">xstat 1 </tspan></text>
-    <text
-       xml:space=3D"preserve"
-       style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:9.33333px;line-height:0;font-family:Arial;-ink=
scape-font-specification:'Arial, Normal';font-variant-ligatures:normal;font=
-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:no=
rmal;fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke-width:0.820641"
-       x=3D"723.08594"
-       y=3D"450.06653"
-       id=3D"text17-1-3-4-5"
-       transform=3D"scale(0.96355962,1.0378185)"><tspan
-         sodipodi:role=3D"line"
-         id=3D"tspan17-02-9-9-6"
-         x=3D"723.08594"
-         y=3D"450.06653"
-         style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:9.33333px;font-family:Arial;-inkscape-font-s=
pecification:'Arial, Normal';font-variant-ligatures:normal;font-variant-cap=
s:normal;font-variant-numeric:normal;font-variant-east-asian:normal;stroke-=
width:0.820641">xstat 1 </tspan></text>
-    <text
-       xml:space=3D"preserve"
-       style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:9.33333px;line-height:0;font-family:Arial;-ink=
scape-font-specification:'Arial, Normal';font-variant-ligatures:normal;font=
-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:no=
rmal;fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke-width:0.820641"
-       x=3D"748.5882"
-       y=3D"393.18039"
-       id=3D"text17-1-3-5"
-       transform=3D"scale(0.96355962,1.0378185)"><tspan
-         sodipodi:role=3D"line"
-         id=3D"tspan17-02-9-3"
-         x=3D"748.5882"
-         y=3D"393.18039"
-         style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:9.33333px;font-family:Arial;-inkscape-font-s=
pecification:'Arial, Normal';font-variant-ligatures:normal;font-variant-cap=
s:normal;font-variant-numeric:normal;font-variant-east-asian:normal;stroke-=
width:0.820641">xstat 2 </tspan></text>
-    <text
-       xml:space=3D"preserve"
-       style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:9.33333333px;line-height:0;font-family:Arial;-=
inkscape-font-specification:'Arial, Normal';fill:#000000;fill-opacity:1;fil=
l-rule:evenodd;stroke-width:0.820641;font-variant-ligatures:normal;font-var=
iant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:normal=
"
-       x=3D"793.07227"
-       y=3D"421.1171"
-       id=3D"text17-1-3-5-7"
-       transform=3D"scale(0.96355962,1.0378185)"><tspan
-         sodipodi:role=3D"line"
-         id=3D"tspan17-02-9-3-6"
-         x=3D"793.07227"
-         y=3D"421.1171"
-         style=3D"stroke-width:0.820641;-inkscape-font-specification:'Aria=
l, Normal';font-family:Arial;font-weight:normal;font-style:normal;font-stre=
tch:normal;font-variant:normal;font-size:9.33333333px;font-variant-ligature=
s:normal;font-variant-caps:normal;font-variant-numeric:normal;font-variant-=
east-asian:normal">xstat 2 </tspan></text>
-    <text
-       xml:space=3D"preserve"
-       style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:9.33333px;line-height:0;font-family:Arial;-ink=
scape-font-specification:'Arial, Normal';font-variant-ligatures:normal;font=
-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:no=
rmal;fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke-width:0.820641"
-       x=3D"765.38727"
-       y=3D"450.09952"
-       id=3D"text17-1-3-5-7-6"
-       transform=3D"scale(0.96355962,1.0378185)"><tspan
-         sodipodi:role=3D"line"
-         id=3D"tspan17-02-9-3-6-0"
-         x=3D"765.38727"
-         y=3D"450.09952"
-         style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:9.33333px;font-family:Arial;-inkscape-font-s=
pecification:'Arial, Normal';font-variant-ligatures:normal;font-variant-cap=
s:normal;font-variant-numeric:normal;font-variant-east-asian:normal;stroke-=
width:0.820641">xstat 2 </tspan></text>
-    <text
-       xml:space=3D"preserve"
-       style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:9.33333333px;line-height:0;font-family:Arial;-=
inkscape-font-specification:'Arial, Normal';fill:#000000;fill-opacity:1;fil=
l-rule:evenodd;stroke-width:0.820641;font-variant-ligatures:normal;font-var=
iant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:normal=
"
-       x=3D"763.57843"
-       y=3D"479.1445"
-       id=3D"text17-1-3-5-7-6-7"
-       transform=3D"scale(0.96355962,1.0378185)"><tspan
-         sodipodi:role=3D"line"
-         id=3D"tspan17-02-9-3-6-0-5"
-         x=3D"763.57843"
-         y=3D"479.1445"
-         style=3D"stroke-width:0.820641;-inkscape-font-specification:'Aria=
l, Normal';font-family:Arial;font-weight:normal;font-style:normal;font-stre=
tch:normal;font-variant:normal;font-size:9.33333333px;font-variant-ligature=
s:normal;font-variant-caps:normal;font-variant-numeric:normal;font-variant-=
east-asian:normal">xstat N </tspan></text>
-    <text
-       xml:space=3D"preserve"
-       style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:9.33333px;line-height:0;font-family:Arial;-ink=
scape-font-specification:'Arial, Normal';font-variant-ligatures:normal;font=
-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:no=
rmal;fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke-width:0.820641"
-       x=3D"779.73914"
-       y=3D"393.17386"
-       id=3D"text17-1-3-5-6"
-       transform=3D"scale(0.96355962,1.0378185)"><tspan
-         sodipodi:role=3D"line"
-         id=3D"tspan17-02-9-3-5"
-         x=3D"779.73914"
-         y=3D"393.17386"
-         style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:9.33333px;font-family:Arial;-inkscape-font-s=
pecification:'Arial, Normal';font-variant-ligatures:normal;font-variant-cap=
s:normal;font-variant-numeric:normal;font-variant-east-asian:normal;stroke-=
width:0.820641">xstat 3 </tspan></text>
-    <text
-       xml:space=3D"preserve"
-       style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:9.33333px;line-height:0;font-family:Arial;-ink=
scape-font-specification:'Arial, Normal';font-variant-ligatures:normal;font=
-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:no=
rmal;fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke-width:0.820641"
-       x=3D"807.05823"
-       y=3D"450.12637"
-       id=3D"text17-1-3-5-6-0"
-       transform=3D"scale(0.96355962,1.0378185)"><tspan
-         sodipodi:role=3D"line"
-         id=3D"tspan17-02-9-3-5-6"
-         x=3D"807.05823"
-         y=3D"450.12637"
-         style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:9.33333px;font-family:Arial;-inkscape-font-s=
pecification:'Arial, Normal';font-variant-ligatures:normal;font-variant-cap=
s:normal;font-variant-numeric:normal;font-variant-east-asian:normal;stroke-=
width:0.820641">xstat 3 </tspan></text>
-    <text
-       xml:space=3D"preserve"
-       style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:9.33333px;line-height:0;font-family:Arial;-ink=
scape-font-specification:'Arial, Normal';font-variant-ligatures:normal;font=
-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:no=
rmal;fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke-width:0.820641"
-       x=3D"811.46503"
-       y=3D"393.10345"
-       id=3D"text17-1-3-5-6-9"
-       transform=3D"scale(0.96355962,1.0378185)"><tspan
-         sodipodi:role=3D"line"
-         id=3D"tspan17-02-9-3-5-9"
-         x=3D"811.46503"
-         y=3D"393.10345"
-         style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:9.33333px;font-family:Arial;-inkscape-font-s=
pecification:'Arial, Normal';font-variant-ligatures:normal;font-variant-cap=
s:normal;font-variant-numeric:normal;font-variant-east-asian:normal;stroke-=
width:0.820641">xstat 4 </tspan></text>
-    <text
-       xml:space=3D"preserve"
-       style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:12px;line-height:0;font-family:Arial;-inkscape=
-font-specification:'Arial, Normal';font-variant-ligatures:normal;font-vari=
ant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;=
fill:#000000;fill-opacity:1;fill-rule:evenodd"
-       x=3D"647.08496"
-       y=3D"438.59705"
-       id=3D"text17-1-2"><tspan
-         sodipodi:role=3D"line"
-         id=3D"tspan17-02-6"
-         x=3D"647.08496"
-         y=3D"438.59705">Node 4 </tspan></text>
-    <text
-       xml:space=3D"preserve"
-       style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:12px;line-height:0;font-family:Arial;-inkscape=
-font-specification:'Arial, Normal';font-variant-ligatures:normal;font-vari=
ant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;=
fill:#000000;fill-opacity:1;fill-rule:evenodd"
-       x=3D"647.08643"
-       y=3D"468.59579"
-       id=3D"text17-1-2-4"><tspan
-         sodipodi:role=3D"line"
-         id=3D"tspan17-02-6-2"
-         x=3D"647.08643"
-         y=3D"468.59579">Node 8 </tspan></text>
-    <text
-       xml:space=3D"preserve"
-       style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:12px;line-height:0;font-family:Arial;-inkscape=
-font-specification:'Arial, Normal';font-variant-ligatures:normal;font-vari=
ant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;=
fill:#000000;fill-opacity:1;fill-rule:evenodd"
-       x=3D"647.08948"
-       y=3D"498.58841"
-       id=3D"text17-1-2-4-2"><tspan
-         sodipodi:role=3D"line"
-         id=3D"tspan17-02-6-2-1"
-         x=3D"647.08948"
-         y=3D"498.58841">Node N </tspan></text>
-    <text
-       xml:space=3D"preserve"
-       style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;line-height:0;font-family:Arial;-inkscape-font-specifica=
tion:'Arial, Normal';fill:#000000;fill-opacity:1;fill-rule:evenodd;font-siz=
e:12px;font-variant-ligatures:normal;font-variant-caps:normal;font-variant-=
numeric:normal;font-variant-east-asian:normal"
-       x=3D"171.51901"
-       y=3D"463.50073"
-       id=3D"text17-9"><tspan
-         sodipodi:role=3D"line"
-         id=3D"tspan17-0"
-         x=3D"171.51901"
-         y=3D"463.50073">Node 4 xstats</tspan></text>
-    <text
-       xml:space=3D"preserve"
-       style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;line-height:0;font-family:Arial;-inkscape-font-specifica=
tion:'Arial, Normal';fill:#000000;fill-opacity:1;fill-rule:evenodd;font-siz=
e:12px;font-variant-ligatures:normal;font-variant-caps:normal;font-variant-=
numeric:normal;font-variant-east-asian:normal"
-       x=3D"171.66028"
-       y=3D"488.6954"
-       id=3D"text17-9-7"><tspan
-         sodipodi:role=3D"line"
-         id=3D"tspan17-0-6"
-         x=3D"171.66028"
-         y=3D"488.6954">Node 8 xstats</tspan></text>
-    <text
-       xml:space=3D"preserve"
-       style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;line-height:0;font-family:Arial;-inkscape-font-specifica=
tion:'Arial, Normal';fill:#000000;fill-opacity:1;fill-rule:evenodd;font-siz=
e:12px;font-variant-ligatures:normal;font-variant-caps:normal;font-variant-=
numeric:normal;font-variant-east-asian:normal"
-       x=3D"171.61055"
-       y=3D"513.5614"
-       id=3D"text17-9-7-1"><tspan
-         sodipodi:role=3D"line"
-         id=3D"tspan17-0-6-1"
-         x=3D"171.61055"
-         y=3D"513.5614">Node N xstats</tspan></text>
-    <text
-       xml:space=3D"preserve"
-       id=3D"text18"
-       style=3D"fill:#000000;-inkscape-font-specification:Arial;font-famil=
y:Arial;font-weight:normal;font-style:normal;font-stretch:normal;font-varia=
nt:normal;line-height:0;fill-rule:evenodd;fill-opacity:1;white-space:pre;sh=
ape-inside:url(#rect18)" />
-    <text
-       xml:space=3D"preserve"
-       id=3D"text19"
-       style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:13.3333px;line-height:0;font-family:Arial;-ink=
scape-font-specification:Arial;white-space:pre;shape-inside:url(#rect19);fi=
ll:#008033;fill-opacity:1;fill-rule:evenodd"
-       transform=3D"translate(9.7511214,-22.752617)"><tspan
-         x=3D"656.57617"
-         y=3D"403.47359"
-         id=3D"tspan2">rte_node xstat memory layout</tspan></text>
-    <text
-       xml:space=3D"preserve"
-       id=3D"text19-3"
-       style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:13.3333px;line-height:0;font-family:Arial;-ink=
scape-font-specification:Arial;white-space:pre;shape-inside:url(#rect19-5);=
fill:#008033;fill-opacity:1;fill-rule:evenodd"
-       transform=3D"matrix(1,0,0,1.3775713,-86.925353,-93.357559)" />
-    <rect
-       style=3D"fill:none;fill-opacity:1;fill-rule:evenodd;stroke:#1155cc;=
stroke-width:0.975519;stroke-opacity:1"
-       id=3D"rect20"
-       width=3D"121.46339"
-       height=3D"119.3132"
-       x=3D"689.06696"
-       y=3D"390.52017" />
-    <path
-       stroke=3D"#1155cc"
-       stroke-width=3D"0.969816"
-       stroke-linecap=3D"butt"
-       d=3D"M 689.31334,480.57387 H 811.05822"
-       fill-rule=3D"nonzero"
-       id=3D"path310-0-5" />
-    <path
-       style=3D"fill:none;fill-opacity:1;fill-rule:evenodd;stroke:#595959;=
stroke-dasharray:1, 3;stroke-dashoffset:0;stroke-opacity:1;marker-end:url(#=
Triangle)"
-       d=3D"M 274.42435,420.14046 C 682.15366,393.93914 683.99234,393.6518=
4 683.99234,393.65184"
-       id=3D"path20"
-       sodipodi:nodetypes=3D"cc" />
-    <path
-       style=3D"fill:none;fill-opacity:1;fill-rule:evenodd;stroke:#595959;=
stroke-dasharray:1, 3;stroke-dashoffset:0;stroke-opacity:1;marker-end:url(#=
Triangle-0)"
-       d=3D"M 273.95206,520.01368 C 680.76203,508.98154 685.1289,509.15392=
 685.1289,509.15392"
-       id=3D"path20-9"
-       sodipodi:nodetypes=3D"cc" />
-    <path
-       style=3D"fill:none;fill-opacity:1;fill-rule:evenodd;stroke:#1155cc;=
stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
-       d=3D"m 719.87654,390.57304 c -0.0406,30.30974 -0.0406,30.30974 -0.0=
406,30.30974 v 0"
-       id=3D"path21" />
-    <path
-       style=3D"fill:none;fill-opacity:1;fill-rule:evenodd;stroke:#1155cc;=
stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
-       d=3D"m 749.50421,420.67017 c -0.0406,30.30974 -0.0406,30.30974 -0.0=
406,30.30974 v 0"
-       id=3D"path21-8" />
-    <path
-       style=3D"fill:none;fill-opacity:1;fill-rule:evenodd;stroke:#1155cc;=
stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
-       d=3D"m 729.7747,450.11771 c -0.0406,30.30974 -0.0406,30.30974 -0.04=
06,30.30974 v 0"
-       id=3D"path21-8-6" />
-    <path
-       style=3D"fill:none;fill-opacity:1;fill-rule:evenodd;stroke:#1155cc;=
stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
-       d=3D"m 770.41929,450.27903 c -0.0406,30.30974 -0.0406,30.30974 -0.0=
406,30.30974 v 0"
-       id=3D"path21-8-6-2" />
-    <path
-       style=3D"fill:none;fill-opacity:1;fill-rule:evenodd;stroke:#1155cc;=
stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
-       d=3D"m 749.58061,390.87575 c -0.0406,30.30974 -0.0406,30.30974 -0.0=
406,30.30974 v 0"
-       id=3D"path21-3" />
-    <path
-       style=3D"fill:none;fill-opacity:1;fill-rule:evenodd;stroke:#1155cc;=
stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
-       d=3D"m 779.67339,389.9164 c -0.0406,30.30974 -0.0406,30.30974 -0.04=
06,30.30974 v 0"
-       id=3D"path21-3-4" />
-    <text
-       xml:space=3D"preserve"
-       style=3D"font-style:normal;font-variant:normal;font-weight:normal;f=
ont-stretch:normal;font-size:13.3333px;line-height:0;font-family:Arial;-ink=
scape-font-specification:Arial;fill:none;fill-opacity:1;fill-rule:evenodd;s=
troke:#1155cc;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
-       x=3D"615.2713"
-       y=3D"435.30963"
-       id=3D"text21"><tspan
-         sodipodi:role=3D"line"
-         id=3D"tspan21"
-         x=3D"615.2713"
-         y=3D"435.30963" /></text>
-  </g>
+  <sodipodi:namedview
+     id=3D"namedview56"
+     pagecolor=3D"#505050"
+     bordercolor=3D"#ffffff"
+     borderopacity=3D"1"
+     inkscape:showpageshadow=3D"0"
+     inkscape:pageopacity=3D"0"
+     inkscape:pagecheckerboard=3D"1"
+     inkscape:deskcolor=3D"#d1d1d1"
+     showgrid=3D"false"
+     inkscape:zoom=3D"1.3717872"
+     inkscape:cx=3D"356.83377"
+     inkscape:cy=3D"244.20697"
+     inkscape:window-width=3D"2556"
+     inkscape:window-height=3D"1394"
+     inkscape:window-x=3D"0"
+     inkscape:window-y=3D"0"
+     inkscape:window-maximized=3D"0"
+     inkscape:current-layer=3D"svg56" />
+  <style
+     id=3D"style1">
+    text { font-family: sans-serif; font-size: 12px; }
+    text.title { font-size: 13px; fill: #009900; font-weight: bold; }
+    text.label { fill: #000000; }
+    text.italic { font-style: italic; fill: #666666; font-size: 11px; }
+    text.brace { font-size: 12px; fill: #000000; }
+    rect.cell { fill: #ffffff; stroke: #333333; stroke-width: 1; }
+    rect.header { fill: #f8f8f0; stroke: #333333; stroke-width: 1; }
+    line.arrow { stroke: #999999; stroke-width: 1; stroke-dasharray: 5,3; =
}
+    line.brace-line { stroke: #000000; stroke-width: 1; }
+  </style>
+  <rect
+     style=3D"fill:#ffffff;fill-opacity:1;stroke:none;stroke-linecap:round=
;stroke-dasharray:4, 8;stroke-opacity:1;paint-order:markers fill stroke"
+     id=3D"rect2"
+     width=3D"820"
+     height=3D"540"
+     x=3D"0"
+     y=3D"0"
+     sodipodi:insensitive=3D"true" />
+  <path
+     style=3D"font-variation-settings:normal;opacity:1;vector-effect:none;=
fill:none;fill-opacity:1;stroke:#009900;stroke-width:1px;stroke-linecap:but=
t;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:4, 8;stroke-da=
shoffset:0;stroke-opacity:0.733333;-inkscape-stroke:none;stop-color:#000000=
;stop-opacity:1"
+     d=3D"m 215.11719,269.87695 365.21484,-112"
+     id=3D"path56"
+     sodipodi:nodetypes=3D"cc" />
+  <!-- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D -->
+  <!-- rte_graph object memory layout (left column) -->
+  <!-- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D -->
+  <text
+     x=3D"19.517578"
+     y=3D"21.559082"
+     class=3D"title"
+     id=3D"text1"
+     style=3D"font-style:normal;font-variant:normal;font-weight:normal;fon=
t-stretch:normal;font-size:13px;font-family:sans-serif;-inkscape-font-speci=
fication:'sans-serif, Normal';font-variant-ligatures:normal;font-variant-ca=
ps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;fill:#=
3e3e3e;fill-opacity:1">rte_graph object memory layout</text>
+  <!-- Graph Header -->
+  <rect
+     x=3D"35.117188"
+     y=3D"29.876953"
+     width=3D"180"
+     height=3D"40"
+     class=3D"header"
+     id=3D"rect1"
+     style=3D"fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-opacity:1"=
 />
+  <text
+     x=3D"125.11719"
+     y=3D"44.876953"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text2">Graph Header</text>
+  <text
+     x=3D"125.11719"
+     y=3D"59.876953"
+     class=3D"italic"
+     text-anchor=3D"middle"
+     id=3D"text3"
+     style=3D"font-style:normal;font-variant:normal;font-weight:normal;fon=
t-stretch:normal;font-size:11px;font-family:Monospace;-inkscape-font-specif=
ication:'Monospace, Normal';font-variant-ligatures:normal;font-variant-caps=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal">struct =
rte_graph</text>
+  <!-- Scheduling table -->
+  <rect
+     x=3D"35.117188"
+     y=3D"109.87695"
+     width=3D"180"
+     height=3D"28"
+     class=3D"cell"
+     id=3D"rect3"
+     style=3D"fill:#b3e7f6;fill-opacity:1;stroke:#000000;stroke-opacity:1"=
 />
+  <text
+     x=3D"125.11719"
+     y=3D"128.87695"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text4">Scheduling table</text>
+  <!-- Pending bitmap -->
+  <rect
+     x=3D"35.117188"
+     y=3D"137.87695"
+     width=3D"180"
+     height=3D"44.834362"
+     class=3D"cell"
+     id=3D"rect4"
+     style=3D"fill:#fffbda;fill-opacity:1;stroke:#000000;stroke-opacity:1"=
 />
+  <text
+     x=3D"125.11719"
+     y=3D"156.87695"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text5">Pending bitmap</text>
+  <!-- Source pending bitmap -->
+  <rect
+     x=3D"35.117188"
+     y=3D"182.71132"
+     width=3D"180"
+     height=3D"41.165638"
+     class=3D"cell"
+     id=3D"rect5"
+     style=3D"fill:#fffbda;fill-opacity:1;stroke:#000000;stroke-opacity:1"=
 />
+  <text
+     x=3D"125.11719"
+     y=3D"200.87695"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text6">Source nodes bitmap</text>
+  <!-- Fence -->
+  <rect
+     x=3D"35.117188"
+     y=3D"69.876953"
+     width=3D"180"
+     height=3D"36"
+     class=3D"header"
+     id=3D"rect6"
+     style=3D"fill:#ffa6a6;fill-opacity:1;stroke:#000000;stroke-opacity:1"=
 />
+  <text
+     x=3D"125.11719"
+     y=3D"83.876953"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text7">Fence</text>
+  <text
+     x=3D"125.11719"
+     y=3D"97.876953"
+     class=3D"italic"
+     text-anchor=3D"middle"
+     id=3D"text8"
+     style=3D"font-style:normal;font-variant:normal;font-weight:normal;fon=
t-stretch:normal;font-size:11px;font-family:Monospace;-inkscape-font-specif=
ication:'Monospace, Normal';font-variant-ligatures:normal;font-variant-caps=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal">RTE_GRA=
PH_FENCE</text>
+  <!-- Node 0 -->
+  <rect
+     x=3D"35.117188"
+     y=3D"229.87695"
+     width=3D"180"
+     height=3D"40"
+     class=3D"cell"
+     id=3D"rect8"
+     style=3D"fill:#d7fbe0;fill-opacity:1;stroke:#000000;stroke-opacity:1"=
 />
+  <text
+     x=3D"125.11719"
+     y=3D"246.87695"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text9">Node 0</text>
+  <text
+     x=3D"125.11719"
+     y=3D"261.87695"
+     class=3D"italic"
+     text-anchor=3D"middle"
+     id=3D"text10"
+     style=3D"font-style:normal;font-variant:normal;font-weight:normal;fon=
t-stretch:normal;font-size:11px;font-family:Monospace;-inkscape-font-specif=
ication:'Monospace, Normal';font-variant-ligatures:normal;font-variant-caps=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal">struct =
rte_node</text>
+  <!-- Node 1 -->
+  <rect
+     x=3D"35.117188"
+     y=3D"269.87695"
+     width=3D"180"
+     height=3D"40"
+     class=3D"cell"
+     id=3D"rect10"
+     style=3D"fill:#d7fbe0;fill-opacity:1;stroke:#000000;stroke-opacity:1"=
 />
+  <text
+     x=3D"125.11719"
+     y=3D"286.87695"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text11">Node 1</text>
+  <text
+     x=3D"125.11719"
+     y=3D"301.87695"
+     class=3D"italic"
+     text-anchor=3D"middle"
+     id=3D"text12"
+     style=3D"font-style:normal;font-variant:normal;font-weight:normal;fon=
t-stretch:normal;font-size:11px;font-family:Monospace;-inkscape-font-specif=
ication:'Monospace, Normal';font-variant-ligatures:normal;font-variant-caps=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal">struct =
rte_node</text>
+  <!-- Node 2 -->
+  <rect
+     x=3D"35.117188"
+     y=3D"309.87695"
+     width=3D"180"
+     height=3D"40"
+     class=3D"cell"
+     id=3D"rect12"
+     style=3D"fill:#d7fbe0;fill-opacity:1;stroke:#000000;stroke-opacity:1"=
 />
+  <text
+     x=3D"125.11719"
+     y=3D"326.87695"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text13">Node 2</text>
+  <text
+     x=3D"125.11719"
+     y=3D"341.87695"
+     class=3D"italic"
+     text-anchor=3D"middle"
+     id=3D"text14"
+     style=3D"font-style:normal;font-variant:normal;font-weight:normal;fon=
t-stretch:normal;font-size:11px;font-family:Monospace;-inkscape-font-specif=
ication:'Monospace, Normal';font-variant-ligatures:normal;font-variant-caps=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal">struct =
rte_node</text>
+  <!-- Node N -->
+  <rect
+     x=3D"35.117188"
+     y=3D"357.87695"
+     width=3D"180"
+     height=3D"40"
+     class=3D"cell"
+     id=3D"rect14"
+     style=3D"fill:#d7fbe0;fill-opacity:1;stroke:#000000;stroke-opacity:1"=
 />
+  <text
+     x=3D"125.11719"
+     y=3D"374.87695"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text15">Node N</text>
+  <text
+     x=3D"125.11719"
+     y=3D"389.87695"
+     class=3D"italic"
+     text-anchor=3D"middle"
+     id=3D"text16"
+     style=3D"font-style:normal;font-variant:normal;font-weight:normal;fon=
t-stretch:normal;font-size:11px;font-family:Monospace;-inkscape-font-specif=
ication:'Monospace, Normal';font-variant-ligatures:normal;font-variant-caps=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal">struct =
rte_node</text>
+  <!-- dots between Node 2 and Node N -->
+  <text
+     x=3D"125.11719"
+     y=3D"353.87695"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text17">...</text>
+  <!-- nb_nodes brace -->
+  <line
+     x1=3D"25.117188"
+     y1=3D"229.87695"
+     x2=3D"25.117188"
+     y2=3D"397.87695"
+     class=3D"brace-line"
+     id=3D"line17" />
+  <line
+     x1=3D"25.117188"
+     y1=3D"229.87695"
+     x2=3D"30.117188"
+     y2=3D"229.87695"
+     class=3D"brace-line"
+     id=3D"line18" />
+  <line
+     x1=3D"25.117188"
+     y1=3D"397.87695"
+     x2=3D"30.117188"
+     y2=3D"397.87695"
+     class=3D"brace-line"
+     id=3D"line19" />
+  <text
+     x=3D"-313.87695"
+     y=3D"17.117188"
+     class=3D"brace"
+     text-anchor=3D"middle"
+     transform=3D"rotate(-90)"
+     id=3D"text19">nb_nodes</text>
+  <!-- Node xstats -->
+  <rect
+     x=3D"35.117188"
+     y=3D"405.87695"
+     width=3D"180"
+     height=3D"38.393005"
+     class=3D"cell"
+     id=3D"rect19"
+     style=3D"fill:#fbccff;fill-opacity:1;stroke:#000000;stroke-opacity:1"=
 />
+  <text
+     x=3D"125.11719"
+     y=3D"429.54709"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text20">Node 1 xstats</text>
+  <!-- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D -->
+  <!-- Bitmap scheduling layout (center column) -->
+  <!-- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D -->
+  <text
+     x=3D"350.58447"
+     y=3D"19.876953"
+     class=3D"title"
+     id=3D"text24"
+     style=3D"font-style:normal;font-variant:normal;font-weight:normal;fon=
t-stretch:normal;font-size:13px;font-family:sans-serif;-inkscape-font-speci=
fication:'sans-serif, Normal';font-variant-ligatures:normal;font-variant-ca=
ps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;fill:#=
1f297a;fill-opacity:1">Scheduling table</text>
+  <!-- Arrow from scheduling table to bitmap layout -->
+  <rect
+     x=3D"305.11719"
+     y=3D"29.876953"
+     width=3D"200"
+     height=3D"28"
+     class=3D"cell"
+     id=3D"rect24"
+     style=3D"fill:#b3e7f6;fill-opacity:1;stroke:#000000;stroke-opacity:1"=
 />
+  <text
+     x=3D"405.11719"
+     y=3D"47.876953"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text25">Node 0 offset (prio min)</text>
+  <rect
+     x=3D"305.11719"
+     y=3D"57.876953"
+     width=3D"200"
+     height=3D"28"
+     class=3D"cell"
+     id=3D"rect25"
+     style=3D"fill:#b3e7f6;fill-opacity:1;stroke:#000000;stroke-opacity:1"=
 />
+  <text
+     x=3D"405.11719"
+     y=3D"75.876953"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text26">Node 1 offset</text>
+  <rect
+     x=3D"305.11719"
+     y=3D"85.876953"
+     width=3D"200"
+     height=3D"28"
+     class=3D"cell"
+     id=3D"rect26"
+     style=3D"fill:#b3e7f6;fill-opacity:1;stroke:#000000;stroke-opacity:1"=
 />
+  <text
+     x=3D"405.11719"
+     y=3D"103.87695"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text27">Node 2 offset</text>
+  <text
+     x=3D"405.11719"
+     y=3D"121.87695"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text28">...</text>
+  <rect
+     x=3D"305.11719"
+     y=3D"127.87695"
+     width=3D"200"
+     height=3D"28"
+     class=3D"cell"
+     id=3D"rect28"
+     style=3D"fill:#b3e7f6;fill-opacity:1;stroke:#000000;stroke-opacity:1"=
 />
+  <text
+     x=3D"405.11719"
+     y=3D"145.87695"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text29">Node N offset (prio max)</text>
+  <!-- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D -->
+  <!-- rte_node object memory layout (right column) -->
+  <!-- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D -->
+  <text
+     x=3D"555.31494"
+     y=3D"146.68994"
+     class=3D"title"
+     id=3D"text30"
+     style=3D"font-style:normal;font-variant:normal;font-weight:normal;fon=
t-stretch:normal;font-size:13px;font-family:sans-serif;-inkscape-font-speci=
fication:'sans-serif, Normal';font-variant-ligatures:normal;font-variant-ca=
ps:normal;font-variant-numeric:normal;font-variant-east-asian:normal">rte_n=
ode object memory layout</text>
+  <!-- Arrow from Node N to rte_node layout -->
+  <rect
+     x=3D"580.33203"
+     y=3D"157.87695"
+     width=3D"155.55365"
+     height=3D"28"
+     class=3D"cell"
+     id=3D"rect30"
+     style=3D"fill:#d7fbe0;fill-opacity:1;stroke:#000000;stroke-opacity:1"=
 />
+  <text
+     x=3D"657.83936"
+     y=3D"175.87695"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text31">Fence</text>
+  <rect
+     x=3D"580.33203"
+     y=3D"185.87695"
+     width=3D"155.55365"
+     height=3D"36"
+     class=3D"cell"
+     id=3D"rect31"
+     style=3D"fill:#d7fbe0;fill-opacity:1;stroke:#000000;stroke-opacity:1"=
 />
+  <text
+     x=3D"658.2583"
+     y=3D"200.87695"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text32">Slowpath area</text>
+  <text
+     x=3D"658.24585"
+     y=3D"214.87695"
+     class=3D"italic"
+     text-anchor=3D"middle"
+     id=3D"text33">(incl. sched_idx)</text>
+  <rect
+     x=3D"580.33203"
+     y=3D"221.87695"
+     width=3D"155.55365"
+     height=3D"28"
+     class=3D"cell"
+     id=3D"rect33"
+     style=3D"fill:#d7fbe0;fill-opacity:1;stroke:#000000;stroke-opacity:1"=
 />
+  <text
+     x=3D"657.95068"
+     y=3D"239.87695"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text34">Context memory</text>
+  <rect
+     x=3D"580.33203"
+     y=3D"249.87695"
+     width=3D"155.55365"
+     height=3D"28"
+     class=3D"cell"
+     id=3D"rect34"
+     style=3D"fill:#d7fbe0;fill-opacity:1;stroke:#000000;stroke-opacity:1"=
 />
+  <text
+     x=3D"658.06494"
+     y=3D"267.87695"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text35">Fastpath area</text>
+  <rect
+     x=3D"580.33203"
+     y=3D"277.87695"
+     width=3D"155.55365"
+     height=3D"28"
+     class=3D"cell"
+     id=3D"rect35"
+     style=3D"fill:#d7fbe0;fill-opacity:1;stroke:#000000;stroke-opacity:1"=
 />
+  <text
+     x=3D"657.52002"
+     y=3D"295.87695"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text36">Next node 0 ptr</text>
+  <rect
+     x=3D"580.33203"
+     y=3D"305.87695"
+     width=3D"155.55365"
+     height=3D"28"
+     class=3D"cell"
+     id=3D"rect36"
+     style=3D"fill:#d7fbe0;fill-opacity:1;stroke:#000000;stroke-opacity:1"=
 />
+  <text
+     x=3D"657.52002"
+     y=3D"323.87695"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text37">Next node 1 ptr</text>
+  <rect
+     x=3D"580.33203"
+     y=3D"347.87695"
+     width=3D"155.55365"
+     height=3D"28"
+     class=3D"cell"
+     id=3D"rect38"
+     style=3D"fill:#d7fbe0;fill-opacity:1;stroke:#000000;stroke-opacity:1"=
 />
+  <text
+     x=3D"657.52002"
+     y=3D"365.87695"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text39">Next node N ptr</text>
+  <!-- nb_edges brace -->
+  <line
+     x1=3D"746.33203"
+     y1=3D"277.8587"
+     x2=3D"746.33203"
+     y2=3D"375.8952"
+     class=3D"brace-line"
+     id=3D"line39" />
+  <line
+     x1=3D"741.33203"
+     y1=3D"277.8587"
+     x2=3D"746.33203"
+     y2=3D"277.8587"
+     class=3D"brace-line"
+     id=3D"line40" />
+  <line
+     x1=3D"741.33203"
+     y1=3D"375.8952"
+     x2=3D"746.33203"
+     y2=3D"375.8952"
+     class=3D"brace-line"
+     id=3D"line41" />
+  <text
+     x=3D"784.33203"
+     y=3D"329.87695"
+     class=3D"brace"
+     text-anchor=3D"middle"
+     id=3D"text41">nb_edges</text>
+  <!-- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D -->
+  <!-- rte_node xstat memory layout (bottom right) -->
+  <!-- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D -->
+  <text
+     x=3D"382.12714"
+     y=3D"403.88254"
+     class=3D"title"
+     id=3D"text42"
+     style=3D"font-style:normal;font-variant:normal;font-weight:normal;fon=
t-stretch:normal;font-size:13px;font-family:sans-serif;-inkscape-font-speci=
fication:'sans-serif, Normal';font-variant-ligatures:normal;font-variant-ca=
ps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;fill:#=
990091;fill-opacity:1">rte_node xstats memory layout</text>
+  <!-- Arrow from Node N xstats -->
+  <!-- Node 1 xstats: 4 xstats -->
+  <!-- Node 4 xstats: 2 xstats -->
+  <!-- Node 8 xstats: 3 xstats -->
+  <!-- Node N xstats: 1 xstat -->
+  <path
+     style=3D"font-variation-settings:normal;opacity:1;vector-effect:none;=
fill:none;fill-opacity:1;stroke:#009900;stroke-width:1px;stroke-linecap:but=
t;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:4, 8;stroke-da=
shoffset:0;stroke-opacity:0.733333;-inkscape-stroke:none;stop-color:#000000=
;stop-opacity:1"
+     d=3D"m 215.11719,309.87695 365.21484,66"
+     id=3D"path57"
+     sodipodi:nodetypes=3D"cc" />
+  <path
+     style=3D"font-variation-settings:normal;opacity:1;vector-effect:none;=
fill:none;fill-opacity:1;stroke:#215fe5;stroke-width:1px;stroke-linecap:but=
t;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:4, 8;stroke-da=
shoffset:0;stroke-opacity:1;-inkscape-stroke:none;stop-color:#000000;stop-o=
pacity:1"
+     d=3D"m 215.11719,109.87695 90,-79.999997"
+     id=3D"path58"
+     sodipodi:nodetypes=3D"cc" />
+  <path
+     style=3D"font-variation-settings:normal;opacity:1;vector-effect:none;=
fill:none;fill-opacity:1;stroke:#215fe5;stroke-width:1px;stroke-linecap:but=
t;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:4, 8;stroke-da=
shoffset:0;stroke-opacity:1;-inkscape-stroke:none;stop-color:#000000;stop-o=
pacity:1"
+     d=3D"m 215.11719,137.87695 90,18"
+     id=3D"path59"
+     sodipodi:nodetypes=3D"cc" />
+  <text
+     x=3D"125.68945"
+     y=3D"172.06445"
+     class=3D"italic"
+     text-anchor=3D"middle"
+     id=3D"text59"
+     style=3D"font-style:italic;font-variant:normal;font-weight:normal;fon=
t-stretch:normal;font-size:10px;font-family:sans-serif;-inkscape-font-speci=
fication:'sans-serif, Italic';font-variant-ligatures:normal;font-variant-ca=
ps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;text-a=
nchor:middle;fill:#666666">one uint64_t word per node</text>
+  <text
+     x=3D"125.11719"
+     y=3D"214.87695"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text60"
+     style=3D"font-style:italic;font-variant:normal;font-weight:normal;fon=
t-stretch:normal;font-size:10px;font-family:sans-serif;-inkscape-font-speci=
fication:'sans-serif, Italic';font-variant-ligatures:normal;font-variant-ca=
ps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;text-a=
nchor:middle;fill:#666666;fill-opacity:1">Seeded to pending on walk start</=
text>
+  <rect
+     style=3D"fill:none;stroke:#000000;stroke-width:1;stroke-linecap:round=
;stroke-linejoin:miter;stroke-dasharray:4.00001, 8;stroke-dashoffset:0;stro=
ke-opacity:1;paint-order:markers fill stroke"
+     id=3D"rect22"
+     width=3D"90.698799"
+     height=3D"112.00012"
+     x=3D"439.24158"
+     y=3D"414.93521" />
+  <rect
+     x=3D"439.24158"
+     y=3D"414.93527"
+     width=3D"90.698799"
+     height=3D"22"
+     class=3D"cell"
+     style=3D"fill:#fbccff;fill-opacity:1;stroke:#000000;stroke-opacity:1"
+     id=3D"rect23" />
+  <text
+     x=3D"484.77899"
+     y=3D"429.57541"
+     class=3D"label"
+     text-anchor=3D"middle"
+     style=3D"font-size:10px"
+     id=3D"text23">xstat0</text>
+  <path
+     style=3D"font-variation-settings:normal;opacity:1;vector-effect:none;=
fill:none;fill-opacity:1;stroke:#f04dff;stroke-width:1px;stroke-linecap:but=
t;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:4, 8;stroke-da=
shoffset:0;stroke-opacity:1;-inkscape-stroke:none;stop-color:#000000;stop-o=
pacity:1"
+     d=3D"M 215.11719,483.66296 439.24158,526.9353"
+     id=3D"path54"
+     sodipodi:nodetypes=3D"cc" />
+  <rect
+     x=3D"35.117188"
+     y=3D"445.26996"
+     width=3D"180"
+     height=3D"38.393005"
+     class=3D"cell"
+     id=3D"rect54"
+     style=3D"fill:#fbccff;fill-opacity:1;stroke:#000000;stroke-opacity:1"=
 />
+  <text
+     x=3D"125.11719"
+     y=3D"468.94009"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text56">Node 7 xstats</text>
+  <rect
+     x=3D"35.117188"
+     y=3D"491.9743"
+     width=3D"180"
+     height=3D"38.393005"
+     class=3D"cell"
+     id=3D"rect56"
+     style=3D"fill:#fbccff;fill-opacity:1;stroke:#000000;stroke-opacity:1"=
 />
+  <text
+     x=3D"125.11719"
+     y=3D"515.64447"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text57">Node N xstats</text>
+  <text
+     x=3D"120.69043"
+     y=3D"488.99603"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text58">...</text>
+  <line
+     x1=3D"542.88934"
+     y1=3D"414.93527"
+     x2=3D"542.88934"
+     y2=3D"526.9353"
+     class=3D"brace-line"
+     id=3D"line61" />
+  <line
+     x1=3D"537.88934"
+     y1=3D"414.93527"
+     x2=3D"542.88934"
+     y2=3D"414.93527"
+     class=3D"brace-line"
+     id=3D"line62" />
+  <line
+     x1=3D"537.88934"
+     y1=3D"526.9353"
+     x2=3D"542.88934"
+     y2=3D"526.9353"
+     class=3D"brace-line"
+     id=3D"line63" />
+  <text
+     x=3D"576.78027"
+     y=3D"467.90891"
+     class=3D"brace"
+     text-anchor=3D"middle"
+     id=3D"text63"><tspan
+       sodipodi:role=3D"line"
+       id=3D"tspan63"
+       x=3D"576.78027"
+       y=3D"467.90891">cache</tspan><tspan
+       sodipodi:role=3D"line"
+       id=3D"tspan64"
+       x=3D"576.78027"
+       y=3D"482.90891">line</tspan></text>
+  <rect
+     x=3D"439.24158"
+     y=3D"436.93527"
+     width=3D"90.698799"
+     height=3D"22"
+     class=3D"cell"
+     style=3D"fill:#fbccff;fill-opacity:1;stroke:#000000;stroke-opacity:1"
+     id=3D"rect64" />
+  <text
+     x=3D"484.77899"
+     y=3D"451.57541"
+     class=3D"label"
+     text-anchor=3D"middle"
+     style=3D"font-size:10px"
+     id=3D"text64">xstat1</text>
+  <rect
+     x=3D"439.24158"
+     y=3D"470.93527"
+     width=3D"90.698799"
+     height=3D"22"
+     class=3D"cell"
+     style=3D"fill:#fbccff;fill-opacity:1;stroke:#000000;stroke-opacity:1"
+     id=3D"rect65" />
+  <text
+     x=3D"484.77899"
+     y=3D"485.57541"
+     class=3D"label"
+     text-anchor=3D"middle"
+     style=3D"font-size:10px"
+     id=3D"text65">xstatN</text>
+  <text
+     x=3D"485.8313"
+     y=3D"465.24936"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text66">...</text>
+  <path
+     style=3D"font-variation-settings:normal;opacity:1;vector-effect:none;=
fill:none;fill-opacity:1;stroke:#f04dff;stroke-width:1px;stroke-linecap:but=
t;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:4, 8;stroke-da=
shoffset:0;stroke-opacity:1;-inkscape-stroke:none;stop-color:#000000;stop-o=
pacity:1"
+     d=3D"M 215.11719,445.26996 439.24158,414.93527"
+     id=3D"path66"
+     sodipodi:nodetypes=3D"cc" />
+  <text
+     x=3D"669.32764"
+     y=3D"342.00354"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text67">...</text>
+  <path
+     style=3D"font-variation-settings:normal;opacity:1;vector-effect:none;=
fill:none;fill-opacity:1;stroke:#ffbb4c;stroke-width:1px;stroke-linecap:but=
t;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:4, 8;stroke-da=
shoffset:0;stroke-opacity:1;-inkscape-stroke:none;marker-end:url(#Triangle)=
;stop-color:#000000;stop-opacity:1"
+     d=3D"M 272.58698,191.75977 221.56049,164.4668"
+     id=3D"path67"
+     sodipodi:nodetypes=3D"cc" />
+  <text
+     x=3D"318.07004"
+     y=3D"192.13014"
+     class=3D"label"
+     text-anchor=3D"middle"
+     id=3D"text68"><tspan
+       sodipodi:role=3D"line"
+       id=3D"tspan68"
+       x=3D"318.07004"
+       y=3D"192.13014">bit set to 1</tspan><tspan
+       sodipodi:role=3D"line"
+       id=3D"tspan69"
+       x=3D"318.07004"
+       y=3D"207.13014">when node has work</tspan></text>
 </svg>
diff --git a/lib/graph/graph.c b/lib/graph/graph.c
index 6911ea8abeed..4bf54e8db74a 100644
--- a/lib/graph/graph.c
+++ b/lib/graph/graph.c
@@ -334,20 +334,6 @@ graph_mem_fixup_secondary(struct rte_graph *graph)
 =09return graph_mem_fixup_node_ctx(graph);
 }
=20
-static bool
-graph_src_node_avail(struct graph *graph)
-{
-=09struct graph_node *graph_node;
-
-=09STAILQ_FOREACH(graph_node, &graph->node_list, next)
-=09=09if ((graph_node->node->flags & RTE_NODE_SOURCE_F) &&
-=09=09    (graph_node->node->lcore_id =3D=3D RTE_MAX_LCORE ||
-=09=09     graph->lcore_id =3D=3D graph_node->node->lcore_id))
-=09=09=09return true;
-
-=09return false;
-}
-
 RTE_EXPORT_SYMBOL(rte_graph_model_mcore_dispatch_core_bind)
 int
 rte_graph_model_mcore_dispatch_core_bind(rte_graph_t id, int lcore)
@@ -375,9 +361,8 @@ rte_graph_model_mcore_dispatch_core_bind(rte_graph_t id=
, int lcore)
 =09graph->graph->dispatch.lcore_id =3D graph->lcore_id;
 =09graph->socket =3D rte_lcore_to_socket_id(lcore);
=20
-=09/* check the availability of source node */
-=09if (!graph_src_node_avail(graph))
-=09=09graph->graph->head =3D 0;
+=09/* Rebuild source bitmap with only source nodes bound to this lcore */
+=09graph_src_bitmap_rebuild(graph);
=20
 =09return 0;
=20
@@ -484,6 +469,10 @@ rte_graph_create(const char *name, struct rte_graph_pa=
ram *prm)
 =09if (graph_has_isolated_node(graph))
 =09=09goto graph_cleanup;
=20
+=09/* Compute topological depth for priority-based scheduling */
+=09if (graph_topo_order_compute(graph))
+=09=09goto graph_cleanup;
+
 =09/* Initialize pcap config. */
 =09graph_pcap_enable(prm->pcap_enable);
=20
@@ -598,6 +587,10 @@ graph_clone(struct graph *parent_graph, const char *na=
me, struct rte_graph_param
 =09if (graph_adjacency_list_update(graph))
 =09=09goto graph_cleanup;
=20
+=09/* Compute topological depth for priority-based scheduling */
+=09if (graph_topo_order_compute(graph))
+=09=09goto graph_cleanup;
+
 =09/* Initialize the graph object */
 =09graph->src_node_count =3D parent_graph->src_node_count;
 =09graph->node_count =3D parent_graph->node_count;
diff --git a/lib/graph/graph_debug.c b/lib/graph/graph_debug.c
index e3b8cccdc1f0..8e99fa1b0fb8 100644
--- a/lib/graph/graph_debug.c
+++ b/lib/graph/graph_debug.c
@@ -15,8 +15,8 @@ graph_dump(FILE *f, struct graph *g)
=20
 =09fprintf(f, "graph <%s>\n", g->name);
 =09fprintf(f, "  id=3D%" PRIu32 "\n", g->id);
-=09fprintf(f, "  cir_start=3D%" PRIu32 "\n", g->cir_start);
-=09fprintf(f, "  cir_mask=3D%" PRIu32 "\n", g->cir_mask);
+=09fprintf(f, "  sched_table_off=3D%" PRIu32 "\n", g->sched_table_off);
+=09fprintf(f, "  nb_sched_words=3D%" PRIu16 "\n", g->nb_sched_words);
 =09fprintf(f, "  addr=3D%p\n", g);
 =09fprintf(f, "  graph=3D%p\n", g->graph);
 =09fprintf(f, "  mem_sz=3D%zu\n", g->mem_sz);
@@ -63,14 +63,14 @@ rte_graph_obj_dump(FILE *f, struct rte_graph *g, bool a=
ll)
=20
 =09fprintf(f, "graph <%s> @ %p\n", g->name, g);
 =09fprintf(f, "  id=3D%" PRIu32 "\n", g->id);
-=09fprintf(f, "  head=3D%" PRId32 "\n", (int32_t)g->head);
-=09fprintf(f, "  tail=3D%" PRId32 "\n", (int32_t)g->tail);
-=09fprintf(f, "  cir_mask=3D0x%" PRIx32 "\n", g->cir_mask);
 =09fprintf(f, "  nb_nodes=3D%" PRId32 "\n", g->nb_nodes);
+=09fprintf(f, "  nb_sched_words=3D%" PRIu16 "\n", g->nb_sched_words);
 =09fprintf(f, "  socket=3D%d\n", g->socket);
 =09fprintf(f, "  fence=3D0x%" PRIx64 "\n", g->fence);
 =09fprintf(f, "  nodes_start=3D0x%" PRIx32 "\n", g->nodes_start);
-=09fprintf(f, "  cir_start=3D%p\n", g->cir_start);
+=09fprintf(f, "  sched_table=3D%p\n", g->sched_table);
+=09fprintf(f, "  pending=3D%p\n", g->pending);
+=09fprintf(f, "  src_pending=3D%p\n", g->src_pending);
=20
 =09rte_graph_foreach_node(count, off, g, n) {
 =09=09if (!all && n->idx =3D=3D 0)
diff --git a/lib/graph/graph_ops.c b/lib/graph/graph_ops.c
index a3548ec804f6..6e114ff667be 100644
--- a/lib/graph/graph_ops.c
+++ b/lib/graph/graph_ops.c
@@ -167,3 +167,49 @@ graph_has_isolated_node(struct graph *graph)
 fail:
 =09return 1;
 }
+
+int
+graph_topo_order_compute(struct graph *graph)
+{
+=09struct graph_node **queue, *v;
+=09uint16_t head =3D 0, tail =3D 0;
+=09struct graph_node *graph_node;
+=09rte_node_t nb_nodes;
+=09rte_edge_t i;
+=09size_t sz;
+
+=09nb_nodes =3D graph_nodes_count(graph);
+=09/* Queue may contain duplicates in diamond-shaped graphs */
+=09sz =3D sizeof(struct graph_node *) * nb_nodes * nb_nodes;
+=09queue =3D malloc(sz);
+=09if (queue =3D=3D NULL)
+=09=09SET_ERR_JMP(ENOMEM, fail, "Failed to alloc topo queue");
+
+=09STAILQ_FOREACH(graph_node, &graph->node_list, next)
+=09=09graph_node->topo_order =3D 0;
+
+=09STAILQ_FOREACH(graph_node, &graph->node_list, next) {
+=09=09if (graph_node->node->flags & RTE_NODE_SOURCE_F)
+=09=09=09queue[tail++] =3D graph_node;
+=09}
+
+=09while (head !=3D tail) {
+=09=09v =3D queue[head++];
+=09=09for (i =3D 0; i < v->node->nb_edges; i++) {
+=09=09=09struct graph_node *child =3D v->adjacency_list[i];
+=09=09=09uint32_t depth =3D v->topo_order + 1;
+
+=09=09=09/* Cap depth at nb_nodes to handle cycles */
+=09=09=09if (depth > child->topo_order && depth <=3D nb_nodes) {
+=09=09=09=09child->topo_order =3D depth;
+=09=09=09=09queue[tail++] =3D child;
+=09=09=09}
+=09=09}
+=09}
+
+=09free(queue);
+=09return 0;
+
+fail:
+=09return -rte_errno;
+}
diff --git a/lib/graph/graph_populate.c b/lib/graph/graph_populate.c
index 026daecb2122..a05d59a91058 100644
--- a/lib/graph/graph_populate.c
+++ b/lib/graph/graph_populate.c
@@ -3,6 +3,8 @@
  */
=20
=20
+#include <stdlib.h>
+
 #include <rte_common.h>
 #include <rte_errno.h>
 #include <rte_malloc.h>
@@ -15,19 +17,27 @@ static size_t
 graph_fp_mem_calc_size(struct graph *graph)
 {
 =09struct graph_node *graph_node;
-=09rte_node_t val;
+=09uint16_t nwords;
 =09size_t sz;
=20
 =09/* Graph header */
 =09sz =3D sizeof(struct rte_graph);
-=09/* Source nodes list */
-=09sz +=3D sizeof(rte_graph_off_t) * graph->src_node_count;
-=09/* Circular buffer for pending streams of size number of nodes */
-=09val =3D rte_align32pow2(graph->node_count * sizeof(rte_graph_off_t));
-=09sz =3D RTE_ALIGN(sz, val);
-=09graph->cir_start =3D sz;
-=09graph->cir_mask =3D rte_align32pow2(graph->node_count) - 1;
-=09sz +=3D val;
+
+=09/* Schedule table: node offset indexed by sched_idx */
+=09sz =3D RTE_ALIGN(sz, RTE_CACHE_LINE_SIZE);
+=09graph->sched_table_off =3D sz;
+=09sz +=3D sizeof(rte_graph_off_t) * graph->node_count;
+
+=09/* Pending and source pending bitmaps */
+=09nwords =3D (graph->node_count + 63) / 64;
+=09graph->nb_sched_words =3D nwords;
+=09sz =3D RTE_ALIGN(sz, RTE_CACHE_LINE_SIZE);
+=09graph->pending_off =3D sz;
+=09sz +=3D sizeof(uint64_t) * nwords;
+=09sz =3D RTE_ALIGN(sz, RTE_CACHE_LINE_SIZE);
+=09graph->src_pending_off =3D sz;
+=09sz +=3D sizeof(uint64_t) * nwords;
+
 =09/* Fence */
 =09sz +=3D sizeof(RTE_GRAPH_FENCE);
 =09sz =3D RTE_ALIGN(sz, RTE_CACHE_LINE_SIZE);
@@ -54,20 +64,46 @@ graph_fp_mem_calc_size(struct graph *graph)
 }
=20
 static void
-graph_header_popluate(struct graph *_graph)
+graph_header_populate(struct graph *_graph)
 {
 =09struct rte_graph *graph =3D _graph->graph;
=20
-=09graph->tail =3D 0;
-=09graph->head =3D (int32_t)-_graph->src_node_count;
-=09graph->cir_mask =3D _graph->cir_mask;
 =09graph->nb_nodes =3D _graph->node_count;
-=09graph->cir_start =3D RTE_PTR_ADD(graph, _graph->cir_start);
+=09graph->nb_sched_words =3D _graph->nb_sched_words;
+=09graph->sched_table =3D RTE_PTR_ADD(graph, _graph->sched_table_off);
+=09graph->pending =3D RTE_PTR_ADD(graph, _graph->pending_off);
+=09graph->src_pending =3D RTE_PTR_ADD(graph, _graph->src_pending_off);
 =09graph->nodes_start =3D _graph->nodes_start;
 =09graph->socket =3D _graph->socket;
 =09graph->id =3D _graph->id;
 =09memcpy(graph->name, _graph->name, RTE_GRAPH_NAMESIZE);
 =09graph->fence =3D RTE_GRAPH_FENCE;
+
+=09memset(graph->pending, 0, sizeof(uint64_t) * _graph->nb_sched_words);
+=09memset(graph->src_pending, 0, sizeof(uint64_t) * _graph->nb_sched_words=
);
+}
+
+static int16_t
+graph_node_effective_priority(const struct graph_node *gn)
+{
+=09if (gn->node->flags & RTE_NODE_SOURCE_F)
+=09=09return INT16_MIN;
+=09return gn->node->priority;
+}
+
+static int
+graph_node_priority_cmp(const void *a, const void *b)
+{
+=09const struct graph_node *const *na =3D a;
+=09const struct graph_node *const *nb =3D b;
+=09int16_t pa =3D graph_node_effective_priority(*na);
+=09int16_t pb =3D graph_node_effective_priority(*nb);
+
+=09if (pa !=3D pb)
+=09=09return (int)pa - (int)pb;
+=09if ((*na)->topo_order !=3D (*nb)->topo_order)
+=09=09return (int)(*na)->topo_order - (int)(*nb)->topo_order;
+=09return (int)(*na)->node->id - (int)(*nb)->node->id;
 }
=20
 static void
@@ -76,15 +112,26 @@ graph_nodes_populate(struct graph *_graph)
 =09rte_graph_off_t xstat_off =3D _graph->xstats_start;
 =09rte_graph_off_t off =3D _graph->nodes_start;
 =09struct rte_graph *graph =3D _graph->graph;
-=09struct graph_node *graph_node;
+=09struct graph_node **sorted, *graph_node;
 =09rte_edge_t count, nb_edges;
 =09rte_node_t pid;
+=09uint32_t n;
=20
-=09STAILQ_FOREACH(graph_node, &_graph->node_list, next) {
+=09/* Build a sorted array of graph_node pointers by (priority, id) */
+=09sorted =3D calloc(_graph->node_count, sizeof(*sorted));
+=09RTE_VERIFY(sorted !=3D NULL);
+=09n =3D 0;
+=09STAILQ_FOREACH(graph_node, &_graph->node_list, next)
+=09=09sorted[n++] =3D graph_node;
+=09qsort(sorted, n, sizeof(*sorted), graph_node_priority_cmp);
+
+=09for (n =3D 0; n < _graph->node_count; n++) {
+=09=09graph_node =3D sorted[n];
 =09=09struct rte_node *node =3D RTE_PTR_ADD(graph, off);
 =09=09memset(node, 0, sizeof(*node));
 =09=09node->fence =3D RTE_GRAPH_FENCE;
 =09=09node->off =3D off;
+=09=09node->sched_idx =3D n;
 =09=09if (graph_pcap_is_enable()) {
 =09=09=09node->process =3D graph_pcap_dispatch;
 =09=09=09node->original_process =3D graph_node->node->process;
@@ -123,8 +170,14 @@ graph_nodes_populate(struct graph *_graph)
 =09=09off +=3D sizeof(struct rte_node *) * nb_edges;
 =09=09off =3D RTE_ALIGN(off, RTE_CACHE_LINE_SIZE);
 =09=09node->next =3D off;
+
+=09=09/* Fill the schedule table */
+=09=09graph->sched_table[n] =3D node->off;
+
 =09=09__rte_node_stream_alloc(graph, node);
 =09}
+
+=09free(sorted);
 }
=20
 struct rte_node *
@@ -179,12 +232,11 @@ graph_node_nexts_populate(struct graph *_graph)
 }
=20
 static int
-graph_src_nodes_offset_populate(struct graph *_graph)
+graph_src_bitmap_populate(struct graph *_graph)
 {
 =09struct rte_graph *graph =3D _graph->graph;
 =09struct graph_node *graph_node;
 =09struct rte_node *node;
-=09int32_t head =3D -1;
 =09const char *name;
=20
 =09STAILQ_FOREACH(graph_node, &_graph->node_list, next) {
@@ -195,7 +247,7 @@ graph_src_nodes_offset_populate(struct graph *_graph)
 =09=09=09=09SET_ERR_JMP(EINVAL, fail, "%s not found", name);
=20
 =09=09=09__rte_node_stream_alloc(graph, node);
-=09=09=09graph->cir_start[head--] =3D node->off;
+=09=09=09__rte_node_pending_set(graph->src_pending, node);
 =09=09}
 =09}
=20
@@ -204,17 +256,42 @@ graph_src_nodes_offset_populate(struct graph *_graph)
 =09return -rte_errno;
 }
=20
+void
+graph_src_bitmap_rebuild(struct graph *_graph)
+{
+=09struct rte_graph *graph =3D _graph->graph;
+=09struct graph_node *graph_node;
+=09struct rte_node *node;
+=09const char *name;
+
+=09memset(graph->src_pending, 0,
+=09       sizeof(uint64_t) * graph->nb_sched_words);
+
+=09STAILQ_FOREACH(graph_node, &_graph->node_list, next) {
+=09=09if (!(graph_node->node->flags & RTE_NODE_SOURCE_F))
+=09=09=09continue;
+=09=09if (graph_node->node->lcore_id !=3D RTE_MAX_LCORE &&
+=09=09    graph_node->node->lcore_id !=3D _graph->lcore_id)
+=09=09=09continue;
+=09=09name =3D graph_node->node->name;
+=09=09node =3D graph_node_name_to_ptr(graph, name);
+=09=09if (node =3D=3D NULL)
+=09=09=09continue;
+=09=09__rte_node_pending_set(graph->src_pending, node);
+=09}
+}
+
 static int
 graph_fp_mem_populate(struct graph *graph)
 {
 =09int rc;
=20
-=09graph_header_popluate(graph);
+=09graph_header_populate(graph);
 =09if (graph_pcap_is_enable())
 =09=09graph_pcap_init(graph);
 =09graph_nodes_populate(graph);
 =09rc =3D graph_node_nexts_populate(graph);
-=09rc |=3D graph_src_nodes_offset_populate(graph);
+=09rc |=3D graph_src_bitmap_populate(graph);
=20
 =09return rc;
 }
diff --git a/lib/graph/graph_private.h b/lib/graph/graph_private.h
index 26cdc6637192..2c51a808d3b5 100644
--- a/lib/graph/graph_private.h
+++ b/lib/graph/graph_private.h
@@ -49,6 +49,7 @@ struct node {
 =09STAILQ_ENTRY(node) next;      /**< Next node in the list. */
 =09char name[RTE_NODE_NAMESIZE]; /**< Name of the node. */
 =09uint64_t flags;=09=09      /**< Node configuration flag. */
+=09int16_t priority;=09      /**< Scheduling priority. */
 =09unsigned int lcore_id;
 =09/**< Node runs on the Lcore ID used for mcore dispatch model. */
 =09rte_node_process_t process;   /**< Node process function. */
@@ -82,6 +83,7 @@ struct graph_node {
 =09STAILQ_ENTRY(graph_node) next; /**< Next graph node in the list. */
 =09struct node *node; /**< Pointer to internal node. */
 =09bool visited;      /**< Flag used in BFS to mark node visited. */
+=09uint32_t topo_order; /**< Topological depth from source nodes. */
 =09struct graph_node *adjacency_list[]; /**< Adjacency list of the node. *=
/
 };
=20
@@ -98,19 +100,23 @@ struct graph {
 =09const struct rte_memzone *mz;
 =09/**< Memzone to store graph data. */
 =09rte_graph_off_t nodes_start;
-=09/**< Node memory start offset in graph reel. */
+=09/**< Node memory start offset in graph memory. */
 =09rte_graph_off_t xstats_start;
-=09/**< Node xstats memory start offset in graph reel. */
+=09/**< Node xstats memory start offset in graph memory. */
 =09rte_node_t src_node_count;
 =09/**< Number of source nodes in a graph. */
 =09struct rte_graph *graph;
 =09/**< Pointer to graph data. */
 =09rte_node_t node_count;
 =09/**< Total number of nodes. */
-=09uint32_t cir_start;
-=09/**< Circular buffer start offset in graph reel. */
-=09uint32_t cir_mask;
-=09/**< Circular buffer mask for wrap around. */
+=09uint32_t sched_table_off;
+=09/**< Schedule table start offset in graph memory. */
+=09uint32_t pending_off;
+=09/**< Pending bitmap start offset in graph memory. */
+=09uint32_t src_pending_off;
+=09/**< Source pending bitmap start offset in graph memory. */
+=09uint16_t nb_sched_words;
+=09/**< Number of uint64_t words in pending bitmaps. */
 =09rte_graph_t id;
 =09/**< Graph identifier. */
 =09rte_graph_t parent_id;
@@ -347,6 +353,20 @@ rte_node_t graph_nodes_count(struct graph *graph);
  */
 void graph_mark_nodes_as_not_visited(struct graph *graph);
=20
+/**
+ * @internal
+ *
+ * Compute topological depth for all nodes via BFS from source nodes.
+ *
+ * @param graph
+ *   Pointer to the internal graph object.
+ *
+ * @return
+ *   - 0: Success.
+ *   - <0: Not enough memory for BFS queue.
+ */
+int graph_topo_order_compute(struct graph *graph);
+
 /* Fast path graph memory populate unctions */
=20
 /**
@@ -378,6 +398,16 @@ int graph_fp_mem_create(struct graph *graph);
  */
 int graph_fp_mem_destroy(struct graph *graph);
=20
+/**
+ * @internal
+ *
+ * Rebuild the source pending bitmap based on lcore affinity.
+ *
+ * @param graph
+ *   Pointer to the internal graph object.
+ */
+void graph_src_bitmap_rebuild(struct graph *graph);
+
 /* Lookup functions */
 /**
  * @internal
diff --git a/lib/graph/node.c b/lib/graph/node.c
index e3359fe490a5..b5599143b37b 100644
--- a/lib/graph/node.c
+++ b/lib/graph/node.c
@@ -153,6 +153,7 @@ __rte_node_register(const struct rte_node_register *reg=
)
 =09if (rte_strscpy(node->name, reg->name, RTE_NODE_NAMESIZE) < 0)
 =09=09goto free_xstat;
 =09node->flags =3D reg->flags;
+=09node->priority =3D reg->priority;
 =09node->process =3D reg->process;
 =09node->init =3D reg->init;
 =09node->fini =3D reg->fini;
@@ -216,6 +217,7 @@ node_clone(struct node *node, const char *name)
=20
 =09/* Clone the source node */
 =09reg->flags =3D node->flags;
+=09reg->priority =3D node->priority;
 =09reg->process =3D node->process;
 =09reg->init =3D node->init;
 =09reg->fini =3D node->fini;
diff --git a/lib/graph/rte_graph.h b/lib/graph/rte_graph.h
index 7e433f466129..6cd32ec22284 100644
--- a/lib/graph/rte_graph.h
+++ b/lib/graph/rte_graph.h
@@ -496,6 +496,7 @@ struct rte_node_register {
 =09char name[RTE_NODE_NAMESIZE]; /**< Name of the node. */
 =09uint64_t flags;=09=09      /**< Node configuration flag. */
 #define RTE_NODE_SOURCE_F (1ULL << 0) /**< Node type is source. */
+=09int16_t priority; /**< Scheduling priority (lower =3D visited first, de=
fault 0). */
 =09rte_node_process_t process; /**< Node process function. */
 =09rte_node_init_t init;       /**< Node init function. */
 =09rte_node_fini_t fini;       /**< Node fini function. */
diff --git a/lib/graph/rte_graph_model_mcore_dispatch.h b/lib/graph/rte_gra=
ph_model_mcore_dispatch.h
index f9ff3daa88ec..50a473564b56 100644
--- a/lib/graph/rte_graph_model_mcore_dispatch.h
+++ b/lib/graph/rte_graph_model_mcore_dispatch.h
@@ -77,9 +77,13 @@ int rte_graph_model_mcore_dispatch_node_lcore_affinity_s=
et(const char *name,
 =09=09=09=09=09=09=09   unsigned int lcore_id);
=20
 /**
- * Perform graph walk on the circular buffer and invoke the process functi=
on
+ * Perform graph walk on the pending bitmap and invoke the process functio=
n
  * of the nodes and collect the stats.
  *
+ * Nodes are visited in scheduling order (lowest priority value first).
+ * Source nodes are seeded into the pending bitmap at the start of each wa=
lk.
+ * Nodes with different lcore affinity are dispatched to their target lcor=
e.
+ *
  * @param graph
  *   Graph pointer returned from rte_graph_lookup function.
  *
@@ -88,20 +92,28 @@ int rte_graph_model_mcore_dispatch_node_lcore_affinity_=
set(const char *name,
 static inline void
 rte_graph_walk_mcore_dispatch(struct rte_graph *graph)
 {
-=09const rte_graph_off_t *cir_start =3D graph->cir_start;
-=09const rte_node_t mask =3D graph->cir_mask;
-=09uint32_t head =3D graph->head;
+=09const uint16_t nwords =3D graph->nb_sched_words;
 =09struct rte_node *node;
+=09uint16_t word, bit;
=20
 =09if (graph->dispatch.wq !=3D NULL)
 =09=09__rte_graph_mcore_dispatch_sched_wq_process(graph);
=20
-=09while (likely(head !=3D graph->tail)) {
-=09=09node =3D (struct rte_node *)RTE_PTR_ADD(graph, cir_start[(int32_t)he=
ad++]);
+=09/* Seed pending bitmap with source nodes bound to this lcore */
+=09for (word =3D 0; word < nwords; word++)
+=09=09graph->pending[word] |=3D graph->src_pending[word];
=20
-=09=09/* skip the src nodes which not bind with current worker */
-=09=09if ((int32_t)head < 1 && node->dispatch.lcore_id !=3D graph->dispatc=
h.lcore_id)
-=09=09=09continue;
+=09for (;;) {
+=09=09/* find first word with any pending bit */
+=09=09for (word =3D 0; word < nwords; word++)
+=09=09=09if (graph->pending[word])
+=09=09=09=09break;
+=09=09if (word =3D=3D nwords)
+=09=09=09break; /* no more pending nodes */
+
+=09=09bit =3D rte_ctz64(graph->pending[word]);
+=09=09graph->pending[word] &=3D ~(1ULL << bit);
+=09=09node =3D __rte_graph_pending_node(graph, word, bit);
=20
 =09=09/* Schedule the node until all task/objs are done */
 =09=09if (node->dispatch.lcore_id !=3D RTE_MAX_LCORE &&
@@ -111,11 +123,7 @@ rte_graph_walk_mcore_dispatch(struct rte_graph *graph)
 =09=09=09continue;
=20
 =09=09__rte_node_process(graph, node);
-
-=09=09head =3D likely((int32_t)head > 0) ? head & mask : head;
 =09}
-
-=09graph->tail =3D 0;
 }
=20
 #ifdef __cplusplus
diff --git a/lib/graph/rte_graph_model_rtc.h b/lib/graph/rte_graph_model_rt=
c.h
index 4b6236e301e3..38feb3e1ca88 100644
--- a/lib/graph/rte_graph_model_rtc.h
+++ b/lib/graph/rte_graph_model_rtc.h
@@ -6,9 +6,12 @@
 #include "rte_graph_worker_common.h"
=20
 /**
- * Perform graph walk on the circular buffer and invoke the process functi=
on
+ * Perform graph walk on the pending bitmap and invoke the process functio=
n
  * of the nodes and collect the stats.
  *
+ * Nodes are visited in scheduling order (lowest priority value first).
+ * Source nodes are seeded into the pending bitmap at the start of each wa=
lk.
+ *
  * @param graph
  *   Graph pointer returned from rte_graph_lookup function.
  *
@@ -17,30 +20,52 @@
 static inline void
 rte_graph_walk_rtc(struct rte_graph *graph)
 {
-=09const rte_graph_off_t *cir_start =3D graph->cir_start;
-=09const rte_node_t mask =3D graph->cir_mask;
-=09uint32_t head =3D graph->head;
+=09const uint16_t nwords =3D graph->nb_sched_words;
 =09struct rte_node *node;
+=09uint16_t word, bit;
=20
 =09/*
-=09 * Walk on the source node(s) ((cir_start - head) -> cir_start) and the=
n
-=09 * on the pending streams (cir_start -> (cir_start + mask) -> cir_start=
)
-=09 * in a circular buffer fashion.
+=09 * Nodes are assigned a bit position (sched_idx) sorted by (priority,
+=09 * node_id) at graph creation time. Source nodes are forced to INT16_MI=
N
+=09 * priority so they always come first.
 =09 *
-=09 *=09+-----+ <=3D cir_start - head [number of source nodes]
-=09 *=09|     |
-=09 *=09| ... | <=3D source nodes
-=09 *=09|     |
-=09 *=09+-----+ <=3D cir_start [head =3D 0] [tail =3D 0]
-=09 *=09|     |
-=09 *=09| ... | <=3D pending streams
-=09 *=09|     |
-=09 *=09+-----+ <=3D cir_start + mask
+=09 * sched_table[] maps bit positions to node offsets:
+=09 *
+=09 *   pending[]         sched_table[]
+=09 *   +----------+      +------------------+
+=09 *   | word 0   | ---> | src_node_0       | bit 0 (prio=3DINT16_MIN)
+=09 *   | 1100...1 |      | src_node_1       | bit 1 (prio=3DINT16_MIN)
+=09 *   |          |      | mpls_input       | bit 2 (prio=3D-10)
+=09 *   |          |      | ipv4_input       | bit 3 (prio=3D0)
+=09 *   |          |      | ...              |
+=09 *   +----------+      +------------------+
+=09 *   | word 1   | ---> | ip4_rewrite      | bit 64 (prio=3D10)
+=09 *   | ...      |      | ...              |
+=09 *   +----------+      +------------------+
+=09 *
+=09 * Walk: for each word, find lowest set bit (rte_ctz64), process that
+=09 * node, clear the bit, re-read the word (processing may have set new
+=09 * bits), repeat.
+=09 *
+=09 * After each node is processed, restart scanning from word 0 since
+=09 * processing may set bits in any word, including earlier ones.
 =09 */
-=09while (likely(head !=3D graph->tail)) {
-=09=09node =3D (struct rte_node *)RTE_PTR_ADD(graph, cir_start[(int32_t)he=
ad++]);
+
+=09/* Seed pending bitmap with source nodes */
+=09for (word =3D 0; word < nwords; word++)
+=09=09graph->pending[word] |=3D graph->src_pending[word];
+
+=09for (;;) {
+=09=09/* find first word with any pending bit */
+=09=09for (word =3D 0; word < nwords; word++)
+=09=09=09if (graph->pending[word])
+=09=09=09=09break;
+=09=09if (word =3D=3D nwords)
+=09=09=09break; /* no more pending nodes */
+
+=09=09bit =3D rte_ctz64(graph->pending[word]);
+=09=09graph->pending[word] &=3D ~(1ULL << bit);
+=09=09node =3D __rte_graph_pending_node(graph, word, bit);
 =09=09__rte_node_process(graph, node);
-=09=09head =3D likely((int32_t)head > 0) ? head & mask : head;
 =09}
-=09graph->tail =3D 0;
 }
diff --git a/lib/graph/rte_graph_worker.h b/lib/graph/rte_graph_worker.h
index b0f952a82cc9..e513d7a655d9 100644
--- a/lib/graph/rte_graph_worker.h
+++ b/lib/graph/rte_graph_worker.h
@@ -14,7 +14,7 @@ extern "C" {
 #endif
=20
 /**
- * Perform graph walk on the circular buffer and invoke the process functi=
on
+ * Perform graph walk on the pending bitmap and invoke the process functio=
n
  * of the nodes and collect the stats.
  *
  * @param graph
diff --git a/lib/graph/rte_graph_worker_common.h b/lib/graph/rte_graph_work=
er_common.h
index 4ab53a533e4c..0e60486043d8 100644
--- a/lib/graph/rte_graph_worker_common.h
+++ b/lib/graph/rte_graph_worker_common.h
@@ -49,15 +49,14 @@ SLIST_HEAD(rte_graph_rq_head, rte_graph);
  */
 struct __rte_cache_aligned rte_graph {
 =09/* Fast path area. */
-=09uint32_t tail;=09=09     /**< Tail of circular buffer. */
-=09uint32_t head;=09=09     /**< Head of circular buffer. */
-=09uint32_t cir_mask;=09     /**< Circular buffer wrap around mask. */
 =09rte_node_t nb_nodes;=09     /**< Number of nodes in the graph. */
-=09rte_graph_off_t *cir_start;  /**< Pointer to circular buffer. */
 =09rte_graph_off_t nodes_start; /**< Offset at which node memory starts. *=
/
+=09rte_graph_off_t *sched_table; /**< Node offset indexed by sched_idx. */
+=09uint64_t *pending;=09     /**< Bitmap of pending nodes. */
+=09uint64_t *src_pending;=09     /**< Bitmap of source nodes (constant). *=
/
+=09uint16_t nb_sched_words;     /**< Number of uint64_t words in pending b=
itmaps. */
 =09uint8_t model;=09=09     /**< graph model */
-=09uint8_t reserved1;=09     /**< Reserved for future use. */
-=09uint16_t reserved2;=09     /**< Reserved for future use. */
+=09/* 26 bytes padding */
 =09union {
 =09=09/* Fast schedule area for mcore dispatch model */
 =09=09struct {
@@ -98,6 +97,7 @@ struct __rte_cache_aligned rte_node {
 =09rte_node_t id;=09=09/**< Node identifier. */
 =09rte_node_t parent_id;=09/**< Parent Node identifier. */
 =09rte_edge_t nb_edges;=09/**< Number of edges from this node. */
+=09uint16_t sched_idx;=09/**< Bit position in pending bitmap. */
 =09uint32_t realloc_count;=09/**< Number of times realloced. */
=20
 =09char parent[RTE_NODE_NAMESIZE];=09/**< Parent node name. */
@@ -132,7 +132,7 @@ struct __rte_cache_aligned rte_node {
 =09=09}; /**< Node Context. */
 =09=09uint16_t size;=09=09/**< Total number of objects available. */
 =09=09uint16_t idx;=09=09/**< Number of objects used. */
-=09=09rte_graph_off_t off;=09/**< Offset of node in the graph reel. */
+=09=09rte_graph_off_t off;=09/**< Offset of node in the graph memory. */
 =09=09uint64_t total_cycles;=09/**< Cycles spent in this node. */
 =09=09uint64_t total_calls;=09/**< Calls done to this node. */
 =09=09uint64_t total_objs;=09/**< Objects processed by this node. */
@@ -187,12 +187,12 @@ void __rte_node_stream_alloc_size(struct rte_graph *g=
raph,
 /**
  * @internal
  *
- * Enqueue a given node to the tail of the graph reel.
+ * Process a node's pending objects and collect stats.
  *
  * @param graph
  *   Pointer Graph object.
  * @param node
- *   Pointer to node object to be enqueued.
+ *   Pointer to node object to be processed.
  */
 static __rte_always_inline void
 __rte_node_process(struct rte_graph *graph, struct rte_node *node)
@@ -220,21 +220,42 @@ __rte_node_process(struct rte_graph *graph, struct rt=
e_node *node)
 /**
  * @internal
  *
- * Enqueue a given node to the tail of the graph reel.
+ * Get a pointer to a node from the scheduling table.
  *
  * @param graph
  *   Pointer Graph object.
+ * @param word
+ *   Offset in the pending bitmap.
+ * @param bit
+ *   Bit number.
+ *
+ * @return
+ *   Pointer to the node.
+ */
+static __rte_always_inline struct rte_node *
+__rte_graph_pending_node(struct rte_graph *graph, uint16_t word, uint16_t =
bit)
+{
+=09const uint16_t index =3D (word * sizeof(*graph->pending) * CHAR_BIT) + =
bit;
+=09const rte_graph_off_t node_offset =3D graph->sched_table[index];
+=09return RTE_PTR_ADD(graph, node_offset);
+}
+
+/**
+ * @internal
+ *
+ * Mark a node as pending in the graph scheduling bitmap.
+ *
+ * @param bitmap
+ *   Either graph->pending or graph->src_pending.
  * @param node
- *   Pointer to node object to be enqueued.
+ *   Pointer to node object to be marked pending.
  */
 static __rte_always_inline void
-__rte_node_enqueue_tail_update(struct rte_graph *graph, struct rte_node *n=
ode)
+__rte_node_pending_set(uint64_t *bitmap, struct rte_node *node)
 {
-=09uint32_t tail;
-
-=09tail =3D graph->tail;
-=09graph->cir_start[tail++] =3D node->off;
-=09graph->tail =3D tail & graph->cir_mask;
+=09const uint16_t word =3D node->sched_idx / (sizeof(*bitmap) * CHAR_BIT);
+=09const uint16_t bit =3D node->sched_idx % (sizeof(*bitmap) * CHAR_BIT);
+=09bitmap[word] |=3D 1ULL << bit;
 }
=20
 /**
@@ -242,8 +263,8 @@ __rte_node_enqueue_tail_update(struct rte_graph *graph,=
 struct rte_node *node)
  *
  * Enqueue sequence prologue function.
  *
- * Updates the node to tail of graph reel and resizes the number of object=
s
- * available in the stream as needed.
+ * Marks the node as pending in the scheduling bitmap and resizes the numb=
er
+ * of objects available in the stream as needed.
  *
  * @param graph
  *   Pointer to the graph object.
@@ -259,9 +280,8 @@ __rte_node_enqueue_prologue(struct rte_graph *graph, st=
ruct rte_node *node,
 =09=09=09    const uint16_t idx, const uint16_t space)
 {
=20
-=09/* Add to the pending stream list if the node is new */
 =09if (idx =3D=3D 0)
-=09=09__rte_node_enqueue_tail_update(graph, node);
+=09=09__rte_node_pending_set(graph->pending, node);
=20
 =09if (unlikely(node->size < (idx + space)))
 =09=09__rte_node_stream_alloc_size(graph, node, node->size + space);
@@ -293,7 +313,7 @@ __rte_node_next_node_get(struct rte_node *node, rte_edg=
e_t next)
=20
 /**
  * Enqueue the objs to next node for further processing and set
- * the next node to pending state in the circular buffer.
+ * the next node to pending state in the scheduling bitmap.
  *
  * @param graph
  *   Graph pointer returned from rte_graph_lookup().
@@ -321,7 +341,7 @@ rte_node_enqueue(struct rte_graph *graph, struct rte_no=
de *node,
=20
 /**
  * Enqueue only one obj to next node for further processing and
- * set the next node to pending state in the circular buffer.
+ * set the next node to pending state in the scheduling bitmap.
  *
  * @param graph
  *   Graph pointer returned from rte_graph_lookup().
@@ -347,7 +367,7 @@ rte_node_enqueue_x1(struct rte_graph *graph, struct rte=
_node *node,
=20
 /**
  * Enqueue only two objs to next node for further processing and
- * set the next node to pending state in the circular buffer.
+ * set the next node to pending state in the scheduling bitmap.
  * Same as rte_node_enqueue_x1 but enqueue two objs.
  *
  * @param graph
@@ -377,7 +397,7 @@ rte_node_enqueue_x2(struct rte_graph *graph, struct rte=
_node *node,
=20
 /**
  * Enqueue only four objs to next node for further processing and
- * set the next node to pending state in the circular buffer.
+ * set the next node to pending state in the scheduling bitmap.
  * Same as rte_node_enqueue_x1 but enqueue four objs.
  *
  * @param graph
@@ -414,7 +434,7 @@ rte_node_enqueue_x4(struct rte_graph *graph, struct rte=
_node *node,
=20
 /**
  * Enqueue objs to multiple next nodes for further processing and
- * set the next nodes to pending state in the circular buffer.
+ * set the next nodes to pending state in the scheduling bitmap.
  * objs[i] will be enqueued to nexts[i].
  *
  * @param graph
@@ -472,7 +492,7 @@ rte_node_next_stream_get(struct rte_graph *graph, struc=
t rte_node *node,
 }
=20
 /**
- * Put the next stream to pending state in the circular buffer
+ * Put the next stream to pending state in the scheduling bitmap
  * for further processing. Should be invoked after rte_node_next_stream_ge=
t().
  *
  * @param graph
@@ -496,8 +516,7 @@ rte_node_next_stream_put(struct rte_graph *graph, struc=
t rte_node *node,
=20
 =09node =3D __rte_node_next_node_get(node, next);
 =09if (node->idx =3D=3D 0)
-=09=09__rte_node_enqueue_tail_update(graph, node);
-
+=09=09__rte_node_pending_set(graph->pending, node);
 =09node->idx +=3D idx;
 }
=20
@@ -530,7 +549,7 @@ rte_node_next_stream_move(struct rte_graph *graph, stru=
ct rte_node *src,
 =09=09src->objs =3D dobjs;
 =09=09src->size =3D dsz;
 =09=09dst->idx =3D src->idx;
-=09=09__rte_node_enqueue_tail_update(graph, dst);
+=09=09__rte_node_pending_set(graph->pending, dst);
 =09} else { /* Move the objects from src node to dst node */
 =09=09rte_node_enqueue(graph, src, next, src->objs, src->idx);
 =09}
--=20
2.54.0

