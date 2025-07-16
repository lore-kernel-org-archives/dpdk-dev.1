Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83618C83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 13:04:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92DE340697;
	Wed, 16 Jul 2025 15:03:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 763BF40608
 for <dev@dpdk.org>; Wed, 16 Jul 2025 15:03:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752671019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=30GsHTSVY2AJSMo8ajxcQXw5cLacU5kmM0+uMvkj03c=;
 b=FPaqNOrhop3fP8BZWqxqRNXMe4kGFeclilIAlNamOLW+QW+4zkowZTZk06a5pYztbfpSs3
 FcJ3Refa2cLBou6sJuj7G0JCg2YWC4FtLjrH5jEKl+jVvA/MrvqyKlXEL3W6uPU/MSI4OR
 VdFJzLuG2Y5D6ie2K98T4nWa0lziKA4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-KYA8Y-HbM3i9jgEmKSshBQ-1; Wed,
 16 Jul 2025 09:03:35 -0400
X-MC-Unique: KYA8Y-HbM3i9jgEmKSshBQ-1
X-Mimecast-MFC-AGG-ID: KYA8Y-HbM3i9jgEmKSshBQ_1752671014
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 730C41800282; Wed, 16 Jul 2025 13:03:34 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.235])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D70A0195E773; Wed, 16 Jul 2025 13:03:31 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Kiran Kumar K <kirankumark@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [PATCH v4 14/22] graph: fix unaligned access in stats
Date: Wed, 16 Jul 2025 15:02:01 +0200
Message-ID: <20250716130212.1736407-15-david.marchand@redhat.com>
In-Reply-To: <20250716130212.1736407-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250716130212.1736407-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -rifzRQZJsSSCDqoBJ56_zIPnjaiCDBVpnpaVrj_kfY_1752671014
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
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

UBSan reports:

    ../lib/graph/graph_stats.c:208:13: runtime error:
            member access within misaligned address 0x000054742c50
            for type 'struct rte_graph_cluster_stats',
            which requires 64 byte alignment

    ../lib/graph/graph_stats.c:257:12: runtime error:
            member access within misaligned address 0x00002219fd30
            for type 'struct rte_graph_cluster_stats',
            which requires 64 byte alignment

The current code goes into various complex (non aligned) reallocations /
memset / memcpy.

Simplify this by computing how many nodes are present in the
cluster of graphes.
Then directly call rte_malloc for the whole stats object.

As a bonus, this change also fixes leaks:
- if any error occurred before call to rte_malloc, since the xstats
  objects stored in the glibc allocated stats object were not freed,
- if an allocation failure occurs, with constructs using
  ptr = realloc(ptr, sz), since the original ptr is lost,

Fixes: af1ae8b6a32c ("graph: implement stats")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Kiran Kumar K <kirankumark@marvell.com>
---
 lib/graph/graph_stats.c | 102 +++++++++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 44 deletions(-)

diff --git a/lib/graph/graph_stats.c b/lib/graph/graph_stats.c
index 583ad8dbd5..e0fc8fd25c 100644
--- a/lib/graph/graph_stats.c
+++ b/lib/graph/graph_stats.c
@@ -37,7 +37,6 @@ struct __rte_cache_aligned rte_graph_cluster_stats {
 	int socket_id;
 	bool dispatch;
 	void *cookie;
-	size_t sz;
 
 	struct cluster_node clusters[];
 };
@@ -178,15 +177,55 @@ graph_cluster_stats_cb_dispatch(bool is_first, bool is_last, void *cookie,
 	return graph_cluster_stats_cb(true, is_first, is_last, cookie, stat);
 };
 
+static uint32_t
+cluster_count_nodes(const struct cluster *cluster)
+{
+	rte_node_t *nodes = NULL;
+	uint32_t max_nodes = 0;
+
+	for (unsigned int i = 0; i < cluster->nb_graphs; i++) {
+		struct graph_node *graph_node;
+
+		STAILQ_FOREACH(graph_node, &cluster->graphs[i]->node_list, next) {
+			rte_node_t *new_nodes;
+			unsigned int n;
+
+			for (n = 0; n < max_nodes; n++) {
+				if (nodes[n] != graph_node->node->id)
+					continue;
+				break;
+			}
+			if (n != max_nodes)
+				continue;
+
+			max_nodes++;
+			new_nodes = realloc(nodes, max_nodes * sizeof(nodes[0]));
+			if (new_nodes == NULL) {
+				free(nodes);
+				return 0;
+			}
+			nodes = new_nodes;
+			nodes[n] = graph_node->node->id;
+		}
+	}
+	free(nodes);
+
+	return max_nodes;
+}
+
 static struct rte_graph_cluster_stats *
 stats_mem_init(struct cluster *cluster,
 	       const struct rte_graph_cluster_stats_param *prm)
 {
-	size_t sz = sizeof(struct rte_graph_cluster_stats);
 	struct rte_graph_cluster_stats *stats;
 	rte_graph_cluster_stats_cb_t fn;
 	int socket_id = prm->socket_id;
 	uint32_t cluster_node_size;
+	uint32_t max_nodes;
+
+	max_nodes = cluster_count_nodes(cluster);
+	if (max_nodes == 0)
+		return NULL;
 
 	/* Fix up callback */
 	fn = prm->fn;
@@ -203,25 +242,23 @@ stats_mem_init(struct cluster *cluster,
 	cluster_node_size += cluster->nb_graphs * sizeof(struct rte_node *);
 	cluster_node_size = RTE_ALIGN(cluster_node_size, RTE_CACHE_LINE_SIZE);
 
-	stats = realloc(NULL, sz);
+	stats = rte_zmalloc_socket(NULL, sizeof(struct rte_graph_cluster_stats) +
+		max_nodes * cluster_node_size, 0, socket_id);
 	if (stats) {
-		memset(stats, 0, sz);
 		stats->fn = fn;
 		stats->cluster_node_size = cluster_node_size;
 		stats->max_nodes = 0;
 		stats->socket_id = socket_id;
 		stats->cookie = prm->cookie;
-		stats->sz = sz;
 	}
 
 	return stats;
 }
 
 static int
-stats_mem_populate(struct rte_graph_cluster_stats **stats_in,
+stats_mem_populate(struct rte_graph_cluster_stats *stats,
 		   struct rte_graph *graph, struct graph_node *graph_node)
 {
-	struct rte_graph_cluster_stats *stats = *stats_in;
 	rte_node_t id = graph_node->node->id;
 	struct cluster_node *cluster;
 	struct rte_node *node;
@@ -247,21 +284,12 @@ stats_mem_populate(struct rte_graph_cluster_stats **stats_in,
 		cluster = RTE_PTR_ADD(cluster, stats->cluster_node_size);
 	}
 
-	/* Hey, it is a new node, allocate space for it in the reel */
-	stats = realloc(stats, stats->sz + stats->cluster_node_size);
-	if (stats == NULL)
-		SET_ERR_JMP(ENOMEM, err, "Realloc failed");
-	*stats_in = NULL;
-
-	/* Clear the new struct cluster_node area */
-	cluster = RTE_PTR_ADD(stats, stats->sz),
-	memset(cluster, 0, stats->cluster_node_size);
 	memcpy(cluster->stat.name, graph_node->node->name, RTE_NODE_NAMESIZE);
 	cluster->stat.id = graph_node->node->id;
 	cluster->stat.hz = rte_get_timer_hz();
 	node = graph_node_id_to_ptr(graph, id);
 	if (node == NULL)
-		SET_ERR_JMP(ENOENT, free, "Failed to find node %s in graph %s",
+		SET_ERR_JMP(ENOENT, err, "Failed to find node %s in graph %s",
 			    graph_node->node->name, graph->name);
 	cluster->nodes[cluster->nb_nodes++] = node;
 	if (graph_node->node->xstats) {
@@ -270,7 +298,7 @@ stats_mem_populate(struct rte_graph_cluster_stats **stats_in,
 			sizeof(uint64_t) * graph_node->node->xstats->nb_xstats,
 			RTE_CACHE_LINE_SIZE, stats->socket_id);
 		if (cluster->stat.xstat_count == NULL)
-			SET_ERR_JMP(ENOMEM, free, "Failed to allocate memory node %s graph %s",
+			SET_ERR_JMP(ENOMEM, err, "Failed to allocate memory node %s graph %s",
 				    graph_node->node->name, graph->name);
 
 		cluster->stat.xstat_desc = rte_zmalloc_socket(NULL,
@@ -278,7 +306,7 @@ stats_mem_populate(struct rte_graph_cluster_stats **stats_in,
 			RTE_CACHE_LINE_SIZE, stats->socket_id);
 		if (cluster->stat.xstat_desc == NULL) {
 			rte_free(cluster->stat.xstat_count);
-			SET_ERR_JMP(ENOMEM, free, "Failed to allocate memory node %s graph %s",
+			SET_ERR_JMP(ENOMEM, err, "Failed to allocate memory node %s graph %s",
 				    graph_node->node->name, graph->name);
 		}
 
@@ -288,30 +316,20 @@ stats_mem_populate(struct rte_graph_cluster_stats **stats_in,
 					RTE_NODE_XSTAT_DESC_SIZE) < 0) {
 				rte_free(cluster->stat.xstat_count);
 				rte_free(cluster->stat.xstat_desc);
-				SET_ERR_JMP(E2BIG, free,
+				SET_ERR_JMP(E2BIG, err,
 					    "Error description overflow node %s graph %s",
 					    graph_node->node->name, graph->name);
 			}
 		}
 	}
 
-	stats->sz += stats->cluster_node_size;
 	stats->max_nodes++;
-	*stats_in = stats;
 
 	return 0;
-free:
-	free(stats);
 err:
 	return -rte_errno;
 }
 
-static void
-stats_mem_fini(struct rte_graph_cluster_stats *stats)
-{
-	free(stats);
-}
-
 static void
 cluster_init(struct cluster *cluster)
 {
@@ -381,10 +399,7 @@ struct rte_graph_cluster_stats *
 rte_graph_cluster_stats_create(const struct rte_graph_cluster_stats_param *prm)
 {
 	struct rte_graph_cluster_stats *stats, *rc = NULL;
-	struct graph_node *graph_node;
 	struct cluster cluster;
-	struct graph *graph;
-	const char *pattern;
 	rte_graph_t i;
 
 	/* Sanity checks */
@@ -402,37 +417,36 @@ rte_graph_cluster_stats_create(const struct rte_graph_cluster_stats_param *prm)
 	graph_spinlock_lock();
 	/* Expand graph pattern and add the graph to the cluster */
 	for (i = 0; i < prm->nb_graph_patterns; i++) {
-		pattern = prm->graph_patterns[i];
-		if (expand_pattern_to_cluster(&cluster, pattern))
+		if (expand_pattern_to_cluster(&cluster, prm->graph_patterns[i]))
 			goto bad_pattern;
 	}
 
 	/* Alloc the stats memory */
 	stats = stats_mem_init(&cluster, prm);
 	if (stats == NULL)
-		SET_ERR_JMP(ENOMEM, bad_pattern, "Failed alloc stats memory");
+		SET_ERR_JMP(ENOMEM, bad_pattern, "Failed rte_malloc for stats memory");
 
 	/* Iterate over M(Graph) x N (Nodes in graph) */
 	for (i = 0; i < cluster.nb_graphs; i++) {
+		struct graph_node *graph_node;
+		struct graph *graph;
+
 		graph = cluster.graphs[i];
 		STAILQ_FOREACH(graph_node, &graph->node_list, next) {
 			struct rte_graph *graph_fp = graph->graph;
-			if (stats_mem_populate(&stats, graph_fp, graph_node))
+			if (stats_mem_populate(stats, graph_fp, graph_node))
 				goto realloc_fail;
 		}
 		if (graph->graph->model == RTE_GRAPH_MODEL_MCORE_DISPATCH)
 			stats->dispatch = true;
 	}
 
-	/* Finally copy to hugepage memory to avoid pressure on rte_realloc */
-	rc = rte_malloc_socket(NULL, stats->sz, 0, stats->socket_id);
-	if (rc)
-		rte_memcpy(rc, stats, stats->sz);
-	else
-		SET_ERR_JMP(ENOMEM, realloc_fail, "rte_malloc failed");
+	rc = stats;
+	stats = NULL;
 
 realloc_fail:
-	stats_mem_fini(stats);
+	if (stats != NULL)
+		rte_graph_cluster_stats_destroy(stats);
 bad_pattern:
 	graph_spinlock_unlock();
 	cluster_fini(&cluster);
-- 
2.50.0

