Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797F9CD98F2
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 20:25:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 775B34028F;
	Fri, 19 Jun 2026 22:25:43 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 11ECB40289
 for <dev@dpdk.org>; Fri, 19 Jun 2026 22:25:42 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id A6142201E4;
 Fri, 19 Jun 2026 22:25:41 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Fri, 19 Jun 2026 22:25:33 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Jerin Jacob <jerinj@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v2] graph: add optional profiling stats
Date: Fri, 19 Jun 2026 20:25:32 +0000
Message-ID: <20260619202532.2809261-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 19 Jun 2026 20:25:33.0998 (UTC)
 FILETIME=[C7FE64E0:01DD0029]
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

Added graph node profiling stats, build time configurable by enabling
RTE_GRAPH_PROFILE in rte_config.h.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
v2:
* Fix indentation.
---
 config/rte_config.h                 |  1 +
 lib/graph/graph_debug.c             | 29 ++++++++++++++++++++++++++++-
 lib/graph/node.c                    |  2 ++
 lib/graph/rte_graph_worker_common.h | 23 ++++++++++++++++++++---
 4 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/config/rte_config.h b/config/rte_config.h
index 0447cdf2ad..1942c1b1ec 100644
--- a/config/rte_config.h
+++ b/config/rte_config.h
@@ -106,6 +106,7 @@
 /* rte_graph defines */
 #define RTE_GRAPH_BURST_SIZE 256
 #define RTE_LIBRTE_GRAPH_STATS 1
+/* RTE_GRAPH_PROFILE is not set */
 
 /****** driver defines ********/
 
diff --git a/lib/graph/graph_debug.c b/lib/graph/graph_debug.c
index e3b8cccdc1..b1028f88ed 100644
--- a/lib/graph/graph_debug.c
+++ b/lib/graph/graph_debug.c
@@ -92,7 +92,34 @@ rte_graph_obj_dump(FILE *f, struct rte_graph *g, bool all)
 			fprintf(f, "       total_sched_fail=%" PRId64 "\n",
 				n->dispatch.total_sched_fail);
 		}
-		fprintf(f, "       total_calls=%" PRId64 "\n", n->total_calls);
+		fprintf(f, "       total_calls=%" PRIu64 "\n", n->total_calls);
+		fprintf(f, "       total_cycles=%" PRIu64 "\n", n->total_cycles);
+#ifdef RTE_GRAPH_PROFILE
+		uint64_t calls_2_or_more = n->total_calls -
+				(n->usage_stats[0].calls + n->usage_stats[1].calls);
+		double avg_objs_2_or_more = calls_2_or_more == 0 ? (double)2 :
+				(double)(n->total_objs - n->usage_stats[1].calls) /
+				(double)calls_2_or_more;
+		fprintf(f, "       calls_0=%" PRIu64 ", _1=%" PRIu64 ", _%.1f=%" PRIu64 "\n",
+				n->usage_stats[0].calls,
+				n->usage_stats[1].calls,
+				avg_objs_2_or_more,
+				calls_2_or_more);
+		fprintf(f, "       cycles_0=%" PRIu64 ", _1=%" PRIu64 ", _%.1f=%" PRIu64 "\n",
+				n->usage_stats[0].cycles,
+				n->usage_stats[1].cycles,
+				avg_objs_2_or_more,
+				n->total_cycles -
+				(n->usage_stats[0].cycles + n->usage_stats[1].cycles));
+		fprintf(f, "       cycles_per_call_1=%.1f, _%.1f=%.1f\n",
+				n->usage_stats[1].calls == 0 ? (double)0 :
+				(double)n->usage_stats[1].cycles / (double)n->usage_stats[1].calls,
+				avg_objs_2_or_more,
+				calls_2_or_more == 0 ? (double)0 :
+				(double)(n->total_cycles -
+				(n->usage_stats[0].cycles + n->usage_stats[1].cycles)) /
+				(double)calls_2_or_more);
+#endif
 		for (i = 0; i < n->nb_edges; i++)
 			fprintf(f, "          edge[%d] <%s>\n", i,
 				n->nodes[i]->name);
diff --git a/lib/graph/node.c b/lib/graph/node.c
index 1fce3e6632..19b38881ae 100644
--- a/lib/graph/node.c
+++ b/lib/graph/node.c
@@ -110,10 +110,12 @@ __rte_node_register(const struct rte_node_register *reg)
 	rte_edge_t i;
 	size_t sz;
 
+#ifndef RTE_GRAPH_PROFILE
 	/* Limit Node specific metadata to one cacheline on 64B CL machine */
 	RTE_BUILD_BUG_ON((offsetof(struct rte_node, nodes) -
 			  offsetof(struct rte_node, ctx)) !=
 			 RTE_CACHE_LINE_MIN_SIZE);
+#endif
 
 	graph_spinlock_lock();
 
diff --git a/lib/graph/rte_graph_worker_common.h b/lib/graph/rte_graph_worker_common.h
index 4ab53a533e..43ce23765b 100644
--- a/lib/graph/rte_graph_worker_common.h
+++ b/lib/graph/rte_graph_worker_common.h
@@ -144,12 +144,22 @@ struct __rte_cache_aligned rte_node {
 			rte_node_process_t process; /**< Process function. */
 			uint64_t process_u64;
 		};
+		/** Fast path area cache line 3. */
+#ifdef RTE_GRAPH_PROFILE
+		struct {
+			uint64_t calls;
+			uint64_t cycles;
+		} usage_stats[2];	/**< Usage when this node processed 0 or 1 objects. */
+		/** Fast path area cache line 4. */
+#endif
 		alignas(RTE_CACHE_LINE_MIN_SIZE) struct rte_node *nodes[]; /**< Next nodes. */
 	};
 };
 
+#ifndef RTE_GRAPH_PROFILE
 static_assert(offsetof(struct rte_node, nodes) - offsetof(struct rte_node, ctx)
 	== RTE_CACHE_LINE_MIN_SIZE, "rte_node fast path area must fit in 64 bytes");
+#endif
 
 /**
  * @internal
@@ -197,7 +207,7 @@ void __rte_node_stream_alloc_size(struct rte_graph *graph,
 static __rte_always_inline void
 __rte_node_process(struct rte_graph *graph, struct rte_node *node)
 {
-	uint64_t start;
+	uint64_t cycles;
 	uint16_t rc;
 	void **objs;
 
@@ -206,11 +216,18 @@ __rte_node_process(struct rte_graph *graph, struct rte_node *node)
 	rte_prefetch0(objs);
 
 	if (rte_graph_has_stats_feature()) {
-		start = rte_rdtsc();
+		cycles = -rte_rdtsc();
 		rc = node->process(graph, node, objs, node->idx);
-		node->total_cycles += rte_rdtsc() - start;
+		cycles += rte_rdtsc();
+		node->total_cycles += cycles;
 		node->total_calls++;
 		node->total_objs += rc;
+#ifdef RTE_GRAPH_PROFILE
+		if (rc <= 1) {
+			node->usage_stats[rc].calls++;
+			node->usage_stats[rc].cycles += cycles;
+		}
+#endif
 	} else {
 		node->process(graph, node, objs, node->idx);
 	}
-- 
2.43.0

