Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB83B606EE97
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=G5y22F8x
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4FF5410FC;
	Tue,  3 Nov 2026 15:55:35 +0100 (CET)
Received: from mta0.migadu.com (out-224.mta0.migadu.com [91.218.175.224])
 by mails.dpdk.org (Postfix) with ESMTPS id BF9CF41132
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:55:33 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=bYnsQF2GrdOYVMbzmYjbSTvY0MUYaTbt1IHNv/U+Hvc=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717733; v=1; x=1794322533;
 b=G5y22F8x01nbFlMbFR05d/kpu3cUd5m+4nL8x4wIQMkbh/V9j7auBlZOJIZKlLsNp+04sF7g
 pAUVrWP8owuQkIxrcLAKkRWFiMZzHAmF3l2Y+BBmN0x1oRSfvejjqflphnP7+urCZcOe5MAc20B
 KfUkzkCIs2RnFk037iJkMFhg=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 202a67208dc8fce8;
 Tue, 03 Nov 2026 14:55:23 +0000
X-Mizu-Trace-ID: 202a67208dc8fce8
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 015/227] graph: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:33 +0800
Message-ID: <20261103145306.487255-16-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename the numa_id fields of rte_graph_param,
rte_graph_cluster_stats_param and rte_graph (were socket_id and
socket), keeping the old names as deprecated union aliases, and
update in-tree users accordingly.

Also rename socket_id parameters, internal variables, dump
output and comments to the NUMA node terminology, and switch
internal calls to rte_zmalloc_numa(), rte_realloc_numa(),
rte_numa_id(), rte_lcore_to_numa_id() and RTE_NUMA_ID_ANY.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/graph/graph.c                          |  4 ++--
 app/graph/l2fwd.c                          |  2 +-
 app/graph/l3fwd.c                          | 10 +++++-----
 app/test/test_graph.c                      |  6 +++---
 app/test/test_graph_feature_arc.c          |  2 +-
 lib/graph/graph.c                          | 14 +++++++-------
 lib/graph/graph_debug.c                    |  2 +-
 lib/graph/graph_feature_arc.c              |  4 ++--
 lib/graph/graph_pcap.c                     |  2 +-
 lib/graph/graph_populate.c                 |  4 ++--
 lib/graph/graph_private.h                  |  4 ++--
 lib/graph/graph_stats.c                    | 18 +++++++++---------
 lib/graph/rte_graph.h                      | 21 ++++++++++++++++++---
 lib/graph/rte_graph_model_mcore_dispatch.c |  4 ++--
 lib/graph/rte_graph_worker_common.h        | 10 +++++++++-
 15 files changed, 65 insertions(+), 42 deletions(-)

diff --git a/app/graph/graph.c b/app/graph/graph.c
index 77f1e7cd71..5afed64421 100644
--- a/app/graph/graph.c
+++ b/app/graph/graph.c
@@ -218,7 +218,7 @@ graph_stats_print_to_file(void)
 
 	memset(&s_param, 0, sizeof(s_param));
 	s_param.f = fp;
-	s_param.socket_id = SOCKET_ID_ANY;
+	s_param.numa_id = RTE_NUMA_ID_ANY;
 	s_param.graph_patterns = &pattern;
 	s_param.nb_graph_patterns = 1;
 
@@ -372,7 +372,7 @@ graph_stats_print(void)
 	/* Prepare stats object */
 	memset(&s_param, 0, sizeof(s_param));
 	s_param.f = stdout;
-	s_param.socket_id = SOCKET_ID_ANY;
+	s_param.numa_id = RTE_NUMA_ID_ANY;
 	s_param.graph_patterns = &pattern;
 	s_param.nb_graph_patterns = 1;
 
diff --git a/app/graph/l2fwd.c b/app/graph/l2fwd.c
index 20894b64fe..3011c70fa4 100644
--- a/app/graph/l2fwd.c
+++ b/app/graph/l2fwd.c
@@ -65,7 +65,7 @@ l2fwd_pattern_configure(void)
 		}
 
 		graph_conf.nb_node_patterns = nb_patterns + i;
-		graph_conf.socket_id = rte_lcore_to_socket_id(lcore_id);
+		graph_conf.numa_id = rte_lcore_to_numa_id(lcore_id);
 
 		snprintf(qconf->name, sizeof(qconf->name), "worker_%u",
 				lcore_id);
diff --git a/app/graph/l3fwd.c b/app/graph/l3fwd.c
index fe25e43da8..9dc84b7338 100644
--- a/app/graph/l3fwd.c
+++ b/app/graph/l3fwd.c
@@ -129,23 +129,23 @@ l3fwd_pattern_configure(void)
 		}
 
 		graph_conf.nb_node_patterns = nb_patterns + i;
-		graph_conf.socket_id = rte_lcore_to_socket_id(lcore_id);
+		graph_conf.numa_id = rte_lcore_to_numa_id(lcore_id);
 
 		snprintf(qconf->name, sizeof(qconf->name), "worker_%u",
 				lcore_id);
 
 		if (ip4_lookup_m == IP4_LOOKUP_FIB) {
-			rc = setup_fib(graph_conf.socket_id);
+			rc = setup_fib(graph_conf.numa_id);
 			if (rc < 0)
 				rte_exit(EXIT_FAILURE, "Unable to setup fib for socket %u\n",
-						graph_conf.socket_id);
+						graph_conf.numa_id);
 		}
 
 		if (ip6_lookup_m == IP6_LOOKUP_FIB) {
-			rc = setup_fib6(graph_conf.socket_id);
+			rc = setup_fib6(graph_conf.numa_id);
 			if (rc < 0)
 				rte_exit(EXIT_FAILURE, "Unable to setup fib6 for socket %u\n",
-						graph_conf.socket_id);
+						graph_conf.numa_id);
 		}
 
 		graph_id = rte_graph_create(qconf->name, &graph_conf);
diff --git a/app/test/test_graph.c b/app/test/test_graph.c
index 042fc9d3a2..c082aab3a6 100644
--- a/app/test/test_graph.c
+++ b/app/test/test_graph.c
@@ -694,7 +694,7 @@ test_create_graph(void)
 		"test_node00-test_node33", "test_node00-dummy_node",
 	};
 	struct rte_graph_param gconf = {
-		.socket_id = SOCKET_ID_ANY,
+		.numa_id = RTE_NUMA_ID_ANY,
 		.nb_node_patterns = 6,
 		.node_patterns = node_patterns_dummy,
 	};
@@ -764,7 +764,7 @@ test_graph_id_collisions(void)
 {
 	static const char *node_patterns[] = {"test_node_source1", "test_node00"};
 	struct rte_graph_param gconf = {
-		.socket_id = SOCKET_ID_ANY,
+		.numa_id = RTE_NUMA_ID_ANY,
 		.nb_node_patterns = 2,
 		.node_patterns = node_patterns,
 	};
@@ -1045,7 +1045,7 @@ test_print_stats(void)
 	/* Prepare stats object */
 	memset(&s_param, 0, sizeof(s_param));
 	s_param.f = stdout;
-	s_param.socket_id = SOCKET_ID_ANY;
+	s_param.numa_id = RTE_NUMA_ID_ANY;
 	s_param.graph_patterns = &pattern;
 	s_param.nb_graph_patterns = 1;
 	s_param.fn = graph_cluster_stats_cb_t;
diff --git a/app/test/test_graph_feature_arc.c b/app/test/test_graph_feature_arc.c
index 1a4bdeee49..114268c85c 100644
--- a/app/test/test_graph_feature_arc.c
+++ b/app/test/test_graph_feature_arc.c
@@ -787,7 +787,7 @@ static int
 create_graph(void)
 {
 	struct rte_graph_param gconf = {
-		.socket_id = SOCKET_ID_ANY,
+		.numa_id = RTE_NUMA_ID_ANY,
 		.nb_node_patterns = RTE_DIM(node_names_feature_arc),
 		.node_patterns = node_names_feature_arc,
 	};
diff --git a/lib/graph/graph.c b/lib/graph/graph.c
index 9789065150..a7ec046d96 100644
--- a/lib/graph/graph.c
+++ b/lib/graph/graph.c
@@ -359,7 +359,7 @@ rte_graph_model_mcore_dispatch_core_bind(rte_graph_t id, int lcore)
 
 	graph->lcore_id = lcore;
 	graph->graph->dispatch.lcore_id = graph->lcore_id;
-	graph->socket = rte_lcore_to_socket_id(lcore);
+	graph->numa_id = rte_lcore_to_numa_id(lcore);
 
 	/* Rebuild source bitmap with only source nodes bound to this lcore */
 	graph_src_bitmap_rebuild(graph);
@@ -477,7 +477,7 @@ rte_graph_create(const char *name, struct rte_graph_param *prm)
 	graph_pcap_enable(prm->pcap_enable);
 
 	/* Initialize graph object */
-	graph->socket = prm->socket_id;
+	graph->numa_id = prm->numa_id;
 	graph->src_node_count = src_node_count;
 	graph->node_count = graph_nodes_count(graph);
 	graph->id = graph_next_free_id();
@@ -596,7 +596,7 @@ graph_clone(struct graph *parent_graph, const char *name, struct rte_graph_param
 	graph->node_count = parent_graph->node_count;
 	graph->parent_id = parent_graph->id;
 	graph->lcore_id = parent_graph->lcore_id;
-	graph->socket = parent_graph->socket;
+	graph->numa_id = parent_graph->numa_id;
 	graph->id = graph_next_free_id();
 
 	/* Allocate the Graph fast path memory and populate the data */
@@ -737,8 +737,8 @@ __rte_node_stream_alloc(struct rte_graph *graph, struct rte_node *node)
 	RTE_VERIFY(size != UINT16_MAX);
 	/* Allocate double amount of size to avoid immediate realloc */
 	size = RTE_MIN(UINT16_MAX, RTE_MAX(RTE_GRAPH_BURST_SIZE, size * 2));
-	node->objs = rte_realloc_socket(node->objs, size * sizeof(void *),
-					RTE_CACHE_LINE_SIZE, graph->socket);
+	node->objs = rte_realloc_numa(node->objs, size * sizeof(void *),
+					RTE_CACHE_LINE_SIZE, graph->numa_id);
 	RTE_VERIFY(node->objs);
 	node->size = size;
 	node->realloc_count++;
@@ -754,8 +754,8 @@ __rte_node_stream_alloc_size(struct rte_graph *graph, struct rte_node *node,
 	RTE_VERIFY(size != UINT16_MAX);
 	/* Allocate double amount of size to avoid immediate realloc */
 	size = RTE_MIN(UINT16_MAX, RTE_MAX(RTE_GRAPH_BURST_SIZE, req_size * 2));
-	node->objs = rte_realloc_socket(node->objs, size * sizeof(void *),
-					RTE_CACHE_LINE_SIZE, graph->socket);
+	node->objs = rte_realloc_numa(node->objs, size * sizeof(void *),
+					RTE_CACHE_LINE_SIZE, graph->numa_id);
 	RTE_VERIFY(node->objs);
 	node->size = size;
 	node->realloc_count++;
diff --git a/lib/graph/graph_debug.c b/lib/graph/graph_debug.c
index aa5cc241a7..89faf70e31 100644
--- a/lib/graph/graph_debug.c
+++ b/lib/graph/graph_debug.c
@@ -66,7 +66,7 @@ rte_graph_obj_dump(FILE *f, struct rte_graph *g, bool all)
 	fprintf(f, "  id=%" PRIu32 "\n", g->id);
 	fprintf(f, "  nb_nodes=%" PRId32 "\n", g->nb_nodes);
 	fprintf(f, "  nb_sched_words=%" PRIu16 "\n", g->nb_sched_words);
-	fprintf(f, "  socket=%d\n", g->socket);
+	fprintf(f, "  numa_id=%d\n", g->numa_id);
 	fprintf(f, "  fence=0x%" PRIx64 "\n", g->fence);
 	fprintf(f, "  nodes_start=0x%" PRIx32 "\n", g->nodes_start);
 	fprintf(f, "  sched_table=%p\n", g->sched_table);
diff --git a/lib/graph/graph_feature_arc.c b/lib/graph/graph_feature_arc.c
index 823aad3e73..9fbf31507a 100644
--- a/lib/graph/graph_feature_arc.c
+++ b/lib/graph/graph_feature_arc.c
@@ -799,7 +799,7 @@ feature_arc_main_init(rte_graph_feature_arc_main_t **pfl, uint32_t max_feature_a
 	sz = sizeof(rte_graph_feature_arc_main_t) +
 		(sizeof(pm->feature_arcs[0]) * max_feature_arcs);
 
-	mz = rte_memzone_reserve(FEATURE_ARC_MEMZONE_NAME, sz, SOCKET_ID_ANY, 0);
+	mz = rte_memzone_reserve(FEATURE_ARC_MEMZONE_NAME, sz, RTE_NUMA_ID_ANY, 0);
 	if (!mz) {
 		graph_err("memzone reserve failed for feature arc main");
 		return -1;
@@ -1260,7 +1260,7 @@ rte_graph_feature_arc_create(struct rte_graph_feature_arc_register *reg,
 	/* Calculate size of feature arc */
 	feature_arc_reg_calc_size(reg, &sz, &first_feat_off, &fdata_off, &feat_sz, &num_index);
 
-	mz = rte_memzone_reserve(reg->arc_name, sz, SOCKET_ID_ANY, 0);
+	mz = rte_memzone_reserve(reg->arc_name, sz, RTE_NUMA_ID_ANY, 0);
 
 	if (!mz) {
 		graph_err("memzone reserve failed for arc: %s of size: %"PRIu64,
diff --git a/lib/graph/graph_pcap.c b/lib/graph/graph_pcap.c
index 78859ec2d4..e4b3a8f78e 100644
--- a/lib/graph/graph_pcap.c
+++ b/lib/graph/graph_pcap.c
@@ -147,7 +147,7 @@ graph_pcap_mp_init(void)
 	pkt_mp = rte_pktmbuf_pool_create_by_ops(GRAPH_PCAP_PKT_POOL,
 			IOV_MAX + RTE_GRAPH_BURST_SIZE,	0, 0,
 			rte_pcapng_mbuf_size(RTE_MBUF_DEFAULT_BUF_SIZE),
-			SOCKET_ID_ANY, "ring_mp_mc");
+			RTE_NUMA_ID_ANY, "ring_mp_mc");
 	if (pkt_mp == NULL) {
 		graph_err("Cannot create mempool for graph pcap capture.");
 		return -1;
diff --git a/lib/graph/graph_populate.c b/lib/graph/graph_populate.c
index 5c6829a7c7..f5f8a78b57 100644
--- a/lib/graph/graph_populate.c
+++ b/lib/graph/graph_populate.c
@@ -74,7 +74,7 @@ graph_header_populate(struct graph *_graph)
 	graph->pending = RTE_PTR_ADD(graph, _graph->pending_off);
 	graph->src_pending = RTE_PTR_ADD(graph, _graph->src_pending_off);
 	graph->nodes_start = _graph->nodes_start;
-	graph->socket = _graph->socket;
+	graph->numa_id = _graph->numa_id;
 	graph->id = _graph->id;
 	memcpy(graph->name, _graph->name, RTE_GRAPH_NAMESIZE);
 	graph->fence = RTE_GRAPH_FENCE;
@@ -291,7 +291,7 @@ graph_fp_mem_create(struct graph *graph)
 	size_t sz;
 
 	sz = graph_fp_mem_calc_size(graph);
-	mz = rte_memzone_reserve(graph->name, sz, graph->socket, 0);
+	mz = rte_memzone_reserve(graph->name, sz, graph->numa_id, 0);
 	if (mz == NULL)
 		SET_ERR_JMP(ENOMEM, fail, "Memzone %s reserve failed",
 			    graph->name);
diff --git a/lib/graph/graph_private.h b/lib/graph/graph_private.h
index 6b986ea10b..b38c632ea5 100644
--- a/lib/graph/graph_private.h
+++ b/lib/graph/graph_private.h
@@ -124,8 +124,8 @@ struct graph {
 	/**< Lcore identifier where the graph prefer to run on. Used for mcore dispatch model. */
 	size_t mem_sz;
 	/**< Memory size of the graph. */
-	int socket;
-	/**< Socket identifier where memory is allocated. */
+	int numa_id;
+	/** NUMA node identifier where memory is allocated. */
 	uint64_t num_pkt_to_capture;
 	/**< Number of packets to be captured per core. */
 	char pcap_filename[RTE_GRAPH_PCAP_FILE_SZ];
diff --git a/lib/graph/graph_stats.c b/lib/graph/graph_stats.c
index b87b5707f7..dc994392ab 100644
--- a/lib/graph/graph_stats.c
+++ b/lib/graph/graph_stats.c
@@ -34,7 +34,7 @@ struct __rte_cache_aligned rte_graph_cluster_stats {
 	rte_graph_cluster_stats_cb_t fn;
 	uint32_t cluster_node_size; /* Size of struct cluster_node */
 	rte_node_t max_nodes;
-	int socket_id;
+	int numa_id;
 	bool dispatch;
 	void *cookie;
 
@@ -219,7 +219,7 @@ stats_mem_init(struct cluster *cluster,
 {
 	struct rte_graph_cluster_stats *stats;
 	rte_graph_cluster_stats_cb_t fn;
-	int socket_id = prm->socket_id;
+	int numa_id = prm->numa_id;
 	uint32_t cluster_node_size;
 	uint32_t max_nodes;
 
@@ -242,13 +242,13 @@ stats_mem_init(struct cluster *cluster,
 	cluster_node_size += cluster->nb_graphs * sizeof(struct rte_node *);
 	cluster_node_size = RTE_ALIGN(cluster_node_size, RTE_CACHE_LINE_SIZE);
 
-	stats = rte_zmalloc_socket(NULL, sizeof(struct rte_graph_cluster_stats) +
-		max_nodes * cluster_node_size, 0, socket_id);
+	stats = rte_zmalloc_numa(NULL, sizeof(struct rte_graph_cluster_stats) +
+		max_nodes * cluster_node_size, 0, numa_id);
 	if (stats) {
 		stats->fn = fn;
 		stats->cluster_node_size = cluster_node_size;
 		stats->max_nodes = 0;
-		stats->socket_id = socket_id;
+		stats->numa_id = numa_id;
 		stats->cookie = prm->cookie;
 	}
 
@@ -294,16 +294,16 @@ stats_mem_populate(struct rte_graph_cluster_stats *stats,
 	cluster->nodes[cluster->nb_nodes++] = node;
 	if (graph_node->node->xstats) {
 		cluster->stat.xstat_cntrs = graph_node->node->xstats->nb_xstats;
-		cluster->stat.xstat_count = rte_zmalloc_socket(NULL,
+		cluster->stat.xstat_count = rte_zmalloc_numa(NULL,
 			sizeof(uint64_t) * graph_node->node->xstats->nb_xstats,
-			RTE_CACHE_LINE_SIZE, stats->socket_id);
+			RTE_CACHE_LINE_SIZE, stats->numa_id);
 		if (cluster->stat.xstat_count == NULL)
 			SET_ERR_JMP(ENOMEM, err, "Failed to allocate memory node %s graph %s",
 				    graph_node->node->name, graph->name);
 
-		cluster->stat.xstat_desc = rte_zmalloc_socket(NULL,
+		cluster->stat.xstat_desc = rte_zmalloc_numa(NULL,
 			RTE_NODE_XSTAT_DESC_SIZE * graph_node->node->xstats->nb_xstats,
-			RTE_CACHE_LINE_SIZE, stats->socket_id);
+			RTE_CACHE_LINE_SIZE, stats->numa_id);
 		if (cluster->stat.xstat_desc == NULL) {
 			rte_free(cluster->stat.xstat_count);
 			SET_ERR_JMP(ENOMEM, err, "Failed to allocate memory node %s graph %s",
diff --git a/lib/graph/rte_graph.h b/lib/graph/rte_graph.h
index b5eb5d820e..b80e0c775b 100644
--- a/lib/graph/rte_graph.h
+++ b/lib/graph/rte_graph.h
@@ -166,7 +166,15 @@ typedef void (*packets_enqueued_cb)(struct rte_graph *graph, uint64_t cb_priv);
  * @see rte_graph_create()
  */
 struct rte_graph_param {
-	int socket_id; /**< Socket id where memory is allocated. */
+	union {
+		/** NUMA node ID where memory is allocated. */
+		int numa_id;
+		/**
+		 * Deprecated alias of numa_id.
+		 */
+		__rte_deprecated_msg("use numa_id")
+		int socket_id;
+	};
 	uint16_t nb_node_patterns;  /**< Number of node patterns. */
 	const char **node_patterns;
 	/**< Array of node patterns based on shell pattern. */
@@ -194,8 +202,15 @@ struct rte_graph_param {
  * @see rte_graph_cluster_stats_create()
  */
 struct rte_graph_cluster_stats_param {
-	int socket_id;
-	/**< Socket id where memory is allocated */
+	union {
+		/** NUMA node ID where memory is allocated */
+		int numa_id;
+		/**
+		 * Deprecated alias of numa_id.
+		 */
+		__rte_deprecated_msg("use numa_id")
+		int socket_id;
+	};
 	rte_graph_cluster_stats_cb_t fn;
 	/**< Stats print callback function. NULL value allowed, in that case,
 	 *   default print stat function used.
diff --git a/lib/graph/rte_graph_model_mcore_dispatch.c b/lib/graph/rte_graph_model_mcore_dispatch.c
index 706b5469f0..ce0538f5b4 100644
--- a/lib/graph/rte_graph_model_mcore_dispatch.c
+++ b/lib/graph/rte_graph_model_mcore_dispatch.c
@@ -25,7 +25,7 @@ graph_sched_wq_create(struct graph *_graph, struct graph *_parent_graph,
 	if (!rte_is_power_of_2(wq_size))
 		flags |= RING_F_EXACT_SZ;
 
-	graph->dispatch.wq = rte_ring_create(graph->name, wq_size, graph->socket,
+	graph->dispatch.wq = rte_ring_create(graph->name, wq_size, graph->numa_id,
 					     flags);
 	if (graph->dispatch.wq == NULL)
 		SET_ERR_JMP(EIO, fail, "Failed to allocate graph WQ");
@@ -37,7 +37,7 @@ graph_sched_wq_create(struct graph *_graph, struct graph *_parent_graph,
 	graph->dispatch.mp = rte_mempool_create(graph->name, wq_size,
 						sizeof(struct graph_mcore_dispatch_wq_node),
 						0, 0, NULL, NULL, NULL, NULL,
-						graph->socket, MEMPOOL_F_SP_PUT);
+						graph->numa_id, MEMPOOL_F_SP_PUT);
 	if (graph->dispatch.mp == NULL)
 		SET_ERR_JMP(EIO, fail_mp,
 			    "Failed to allocate graph WQ schedule entry");
diff --git a/lib/graph/rte_graph_worker_common.h b/lib/graph/rte_graph_worker_common.h
index 7a7da1c34f..02990a4bab 100644
--- a/lib/graph/rte_graph_worker_common.h
+++ b/lib/graph/rte_graph_worker_common.h
@@ -74,7 +74,15 @@ struct __rte_cache_aligned rte_graph {
 	SLIST_ENTRY(rte_graph) next;   /* The next for rte_graph list */
 	/* End of Fast path area.*/
 	rte_graph_t id;	/**< Graph identifier. */
-	int socket;	/**< Socket ID where memory is allocated. */
+	union {
+		/** NUMA node ID where memory is allocated. */
+		int numa_id;
+		/**
+		 * Deprecated alias of numa_id.
+		 */
+		__rte_deprecated_msg("use numa_id")
+		int socket;
+	};
 	char name[RTE_GRAPH_NAMESIZE];	/**< Name of the graph. */
 	bool pcap_enable;	        /**< Pcap trace enabled. */
 	/** Number of packets captured per core. */
-- 
2.55.0

