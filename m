Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11EDE9129D
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 09:27:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F50440E35;
	Thu,  5 Feb 2026 10:27:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C2E9540E36
 for <dev@dpdk.org>; Thu,  5 Feb 2026 10:27:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770283639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OYXRvEWrnHP0AbLBf6GnrviBsbQy6OSPdhOUZvt8ZwU=;
 b=GXrILNHrB4Z/mk55eO1y3nc860qlO+TGAYKCGGCZRl7O82ZK3t5zLwb27e9cT8EIqulesw
 ySBCXMoQCIi5Ljh9Zd+vfQiSq+xTzwiIBTrFC1FBxnxv7q178JnyqCh0IMDRYksbyr0cuM
 x5/K73uOY8cIDUw7J4SAnp0aT9TLvoA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-BgirsnNzORqdYFpmXlS-Ww-1; Thu,
 05 Feb 2026 04:27:15 -0500
X-MC-Unique: BgirsnNzORqdYFpmXlS-Ww-1
X-Mimecast-MFC-AGG-ID: BgirsnNzORqdYFpmXlS-Ww_1770283634
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04DF918001F6; Thu,  5 Feb 2026 09:27:14 +0000 (UTC)
Received: from ringo.home (unknown [10.44.33.219])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1BC9E300DDA2; Thu,  5 Feb 2026 09:27:11 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org, Jerin Jacob <jerinj@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [RFC PATCH dpdk 2/3] graph: add deferred enqueue API for batch
 processing
Date: Thu,  5 Feb 2026 10:26:35 +0100
Message-ID: <20260205092630.100488-9-rjarry@redhat.com>
In-Reply-To: <20260205092630.100488-6-rjarry@redhat.com>
References: <20260205092630.100488-6-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CPQ3fAeXBhCDkBNPdOj2OtDWGYXLKmD3zbEo4aJ1NIE_1770283634
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

Add rte_node_enqueue_deferred() which tracks runs of consecutive
objects going to the same edge and flushes them efficiently in bulk.
When all objects go to the same edge (the common case), the function
uses rte_node_next_stream_move() which swaps pointers instead of
copying data.

The deferred state (run_start and last_edge) is stored in the node
fast-path cache line 1, keeping it close to other frequently accessed
node data. The last_edge is preserved across node invocations,
allowing speculation: if traffic continues to the same destination,
no action is needed until the edge changes.

The flush is performed automatically at the end of node processing
by __rte_node_process().

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 lib/graph/graph_populate.c          |  1 +
 lib/graph/rte_graph_worker_common.h | 75 +++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/lib/graph/graph_populate.c b/lib/graph/graph_populate.c
index 026daecb2122..fda46a7dd386 100644
--- a/lib/graph/graph_populate.c
+++ b/lib/graph/graph_populate.c
@@ -84,6 +84,7 @@ graph_nodes_populate(struct graph *_graph)
 		struct rte_node *node = RTE_PTR_ADD(graph, off);
 		memset(node, 0, sizeof(*node));
 		node->fence = RTE_GRAPH_FENCE;
+		node->deferred_last_edge = RTE_EDGE_ID_INVALID;
 		node->off = off;
 		if (graph_pcap_is_enable()) {
 			node->process = graph_pcap_dispatch;
diff --git a/lib/graph/rte_graph_worker_common.h b/lib/graph/rte_graph_worker_common.h
index 7fda67c07169..c6741d44877c 100644
--- a/lib/graph/rte_graph_worker_common.h
+++ b/lib/graph/rte_graph_worker_common.h
@@ -119,6 +119,8 @@ struct __rte_cache_aligned rte_node {
 	/** Fast path area cache line 1. */
 	alignas(RTE_CACHE_LINE_MIN_SIZE)
 	rte_graph_off_t xstat_off; /**< Offset to xstat counters. */
+	uint16_t deferred_run_start; /**< Used by rte_node_enqueue_deferred(). */
+	rte_edge_t deferred_last_edge; /**< Used by rte_node_enqueue_deferred(). */
 
 	/** Fast path area cache line 2. */
 	__extension__ struct __rte_cache_aligned {
@@ -184,6 +186,8 @@ void __rte_node_stream_alloc_size(struct rte_graph *graph,
 
 /* Fast path helper functions */
 
+static inline void __rte_node_enqueue_deferred_flush(struct rte_graph *, struct rte_node *);
+
 /**
  * @internal
  *
@@ -204,6 +208,8 @@ __rte_node_process(struct rte_graph *graph, struct rte_node *node)
 	RTE_ASSERT(node->fence == RTE_GRAPH_FENCE);
 	objs = node->objs;
 	rte_prefetch0(objs);
+	node->deferred_run_start = 0;
+	/* Keep deferred_last_edge from previous invocation for speculation */
 
 	if (rte_graph_has_stats_feature()) {
 		start = rte_rdtsc();
@@ -214,6 +220,10 @@ __rte_node_process(struct rte_graph *graph, struct rte_node *node)
 	} else {
 		node->process(graph, node, objs, node->idx);
 	}
+
+	if (node->deferred_last_edge != RTE_EDGE_ID_INVALID)
+		__rte_node_enqueue_deferred_flush(graph, node);
+
 	node->idx = 0;
 }
 
@@ -412,6 +422,8 @@ rte_node_enqueue_x4(struct rte_graph *graph, struct rte_node *node,
 	node->idx = idx;
 }
 
+static inline void rte_node_next_stream_move(struct rte_graph *, struct rte_node *, rte_edge_t);
+
 /**
  * Enqueue objs to multiple next nodes for further processing and
  * set the next nodes to pending state in the circular buffer.
@@ -547,6 +559,69 @@ rte_node_next_stream_move(struct rte_graph *graph, struct rte_node *src,
 	}
 }
 
+/**
+ * Enqueue objects to a next node in a cache-efficient deferred manner.
+ *
+ * This function tracks runs of objects going to the same edge. When the edge
+ * changes, the previous run is flushed using bulk enqueue. At the end of node
+ * processing, any remaining objects are flushed automatically. When all
+ * objects go to the same edge (the common case), rte_node_next_stream_move()
+ * is used which swaps pointers instead of copying.
+ *
+ * The function does not require consecutive idx values. It can be called with
+ * any stride (e.g., 0, 4, 8, ... to process batches of 4). All objects from
+ * the previous idx up to the current one are considered part of the current
+ * run until the edge changes.
+ *
+ * For homogeneous traffic, the destination node structure is touched once
+ * per batch instead of once per object, reducing cache line bouncing.
+ *
+ * @param graph
+ *   Graph pointer returned from rte_graph_lookup().
+ * @param node
+ *   Current node pointer.
+ * @param next
+ *   Next node edge index.
+ * @param idx
+ *   Index of the current object being processed in node->objs[].
+ *
+ * @see rte_node_next_stream_move().
+ */
+static inline void
+rte_node_enqueue_deferred(struct rte_graph *graph, struct rte_node *node,
+			  rte_edge_t next, uint16_t idx)
+{
+	if (next != node->deferred_last_edge) {
+		/* edge changed, flush previous run if not empty */
+		if (idx > node->deferred_run_start)
+			rte_node_enqueue(graph, node, node->deferred_last_edge,
+					 &node->objs[node->deferred_run_start],
+					 idx - node->deferred_run_start);
+		node->deferred_run_start = idx;
+		node->deferred_last_edge = next;
+	}
+}
+
+/**
+ * @internal
+ * Flush any pending deferred enqueue at end of node processing.
+ */
+static inline void
+__rte_node_enqueue_deferred_flush(struct rte_graph *graph, struct rte_node *node)
+{
+	const uint16_t run_start = node->deferred_run_start;
+	const uint16_t count = node->idx;
+
+	if (run_start == 0 && count != 0) {
+		/* All packets went to the same edge - use stream move (pointer swap) */
+		rte_node_next_stream_move(graph, node, node->deferred_last_edge);
+	} else if (run_start < count) {
+		/* flush final run */
+		rte_node_enqueue(graph, node, node->deferred_last_edge,
+				 &node->objs[run_start], count - run_start);
+	}
+}
+
 /**
  * Test the validity of model.
  *
-- 
2.52.0

