Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26A1C43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 13:18:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFB6A4026F;
	Fri,  3 Jul 2026 15:18:20 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 10ED74003C
 for <dev@dpdk.org>; Fri,  3 Jul 2026 15:18:20 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id C0D82205F2;
 Fri,  3 Jul 2026 15:18:18 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Fri, 3 Jul 2026 15:18:18 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Jerin Jacob <jerinj@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>,
 Saeed Bishara <saeed.bishara.os@gmail.com>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v6] graph: add optional profiling stats
Date: Fri,  3 Jul 2026 13:18:11 +0000
Message-ID: <20260703131811.3013265-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260619202047.2809165-1-mb@smartsharesystems.com>
References: <20260619202047.2809165-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 03 Jul 2026 13:18:18.0525 (UTC)
 FILETIME=[69D824D0:01DD0AEE]
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
v6:
* Consolidate the four histogram entries into one array. (Saeed Bishara)
* Sample at 32 objs instead of RTE_GRAPH_BURST_SIZE/2. (Saeed Bishara)
* Moved stats to different location in rte_node structure. (Jerin)
* Minor details to please checkpatch.
v5:
* Added stats for a half burst and a full burst.
v4:
* Added documentation. (AI)
* Added more comments. (AI)
* Improved dump. (AI)
* Debug shows both cycles/call and cycles/obj.
v3:
* Debug shows cycles/obj instead of cycles/call.
* Fixed missing --in-reply-to.
v2:
* Fixed indentation.
---
 config/rte_config.h                 |  1 +
 doc/guides/prog_guide/graph_lib.rst |  1 +
 lib/graph/graph_debug.c             | 47 +++++++++++++++++++++++++++++
 lib/graph/node.c                    |  2 ++
 lib/graph/rte_graph_worker_common.h | 29 ++++++++++++++++--
 5 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/config/rte_config.h b/config/rte_config.h
index 0447cdf2ad..f5eff3d6dc 100644
--- a/config/rte_config.h
+++ b/config/rte_config.h
@@ -106,6 +106,7 @@
 /* rte_graph defines */
 #define RTE_GRAPH_BURST_SIZE 256
 #define RTE_LIBRTE_GRAPH_STATS 1
+// RTE_GRAPH_PROFILE is not set
 
 /****** driver defines ********/
 
diff --git a/doc/guides/prog_guide/graph_lib.rst b/doc/guides/prog_guide/graph_lib.rst
index 8dd49c19d2..bc36042296 100644
--- a/doc/guides/prog_guide/graph_lib.rst
+++ b/doc/guides/prog_guide/graph_lib.rst
@@ -49,6 +49,7 @@ Performance tuning parameters
   RTE_GRAPH_BURST_SIZE config option.
   The testing shows, on x86 and arm64 servers, The sweet spot is 256 burst
   size. While on arm64 embedded SoCs, it is either 64 or 128.
+- Enable the ``RTE_GRAPH_PROFILE`` config option for more profiling details.
 - Disable node statistics (using ``RTE_LIBRTE_GRAPH_STATS`` config option)
   if not needed.
 
diff --git a/lib/graph/graph_debug.c b/lib/graph/graph_debug.c
index e3b8cccdc1..145649db65 100644
--- a/lib/graph/graph_debug.c
+++ b/lib/graph/graph_debug.c
@@ -93,6 +93,53 @@ rte_graph_obj_dump(FILE *f, struct rte_graph *g, bool all)
 				n->dispatch.total_sched_fail);
 		}
 		fprintf(f, "       total_calls=%" PRId64 "\n", n->total_calls);
+		if (rte_graph_has_stats_feature()) {
+			fprintf(f, "       total_cycles=%" PRIu64 ", avg cycles/call=%.1f\n",
+					n->total_cycles,
+					n->total_calls == 0 ? (double)0 :
+					(double)n->total_cycles / (double)n->total_calls);
+		}
+#ifdef RTE_GRAPH_PROFILE
+		int64_t calls_other = n->total_calls;
+		int64_t cycles_other = n->total_cycles;
+		int64_t objs_other = n->total_objs;
+		for (int idx = 0; idx <= 4; idx++) {
+			uint64_t calls;
+			uint64_t cycles;
+			double objs_per_call;
+			if (idx <= 3) {
+				uint16_t idx_objs = (const uint16_t []){0, 1, 32, RTE_GRAPH_BURST_SIZE}[idx];
+				fprintf(f, "       objs[%u]\n", idx_objs);
+				calls = n->usage_stats[idx].calls;
+				cycles = n->usage_stats[idx].cycles;
+				objs_per_call = (double)idx_objs;
+				calls_other -= calls;
+				cycles_other -= cycles;
+				objs_other -= idx_objs * calls;
+			} else {
+				fprintf(f, "       objs[other]\n");
+				if (calls_other > 0 && cycles_other > 0 && objs_other > 0) {
+					calls = calls_other;
+					cycles = cycles_other;
+					objs_per_call = (double)objs_other / (double)calls_other;
+					fprintf(f, "         avg objs/call=%.1f\n", objs_per_call);
+				} else {
+					calls = 0;
+					cycles = 0;
+					objs_per_call = 0.0;
+				}
+			}
+			fprintf(f, "         calls=%" PRIu64, calls);
+			if (calls != 0)
+				fprintf(f, ", cycles=%" PRIu64 ", avg cycles/call=%.1f",
+						cycles,
+						(double)cycles / (double)calls);
+			if (calls != 0 && objs_per_call != 0.0)
+				fprintf(f, ", avg cycles/obj=%.1f",
+						(double)cycles / (double)calls / objs_per_call);
+			fprintf(f, "\n");
+		}
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
index 4ab53a533e..bac0fc534e 100644
--- a/lib/graph/rte_graph_worker_common.h
+++ b/lib/graph/rte_graph_worker_common.h
@@ -121,6 +121,14 @@ struct __rte_cache_aligned rte_node {
 	rte_graph_off_t xstat_off; /**< Offset to xstat counters. */
 
 	/** Fast path area cache line 2. */
+#ifdef RTE_GRAPH_PROFILE
+	/** Usage when this node processed 0, 1, 32 or a full burst of objects. */
+	struct __rte_cache_aligned {
+		uint64_t calls;     /**< Calls done. */
+		uint64_t cycles;    /**< Cycles spent. */
+	} usage_stats[4];
+	/** Fast path area cache line 3. */
+#endif
 	__extension__ struct __rte_cache_aligned {
 #define RTE_NODE_CTX_SZ 16
 		union {
@@ -148,8 +156,10 @@ struct __rte_cache_aligned rte_node {
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
 
@@ -206,11 +216,24 @@ __rte_node_process(struct rte_graph *graph, struct rte_node *node)
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
+		} else if (rc == 32) {
+			node->usage_stats[2].calls++;
+			node->usage_stats[2].cycles += cycles;
+		} else if (rc == RTE_GRAPH_BURST_SIZE) {
+			node->usage_stats[3].calls++;
+			node->usage_stats[3].cycles += cycles;
+		}
+#endif
 	} else {
 		node->process(graph, node, objs, node->idx);
 	}
-- 
2.43.0

