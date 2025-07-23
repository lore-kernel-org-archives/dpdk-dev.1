Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F66C83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 16:50:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 863AC410D3;
	Wed, 23 Jul 2025 18:50:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 40F9840F16
 for <dev@dpdk.org>; Wed, 23 Jul 2025 18:50:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753289434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x83o1acJqyVH4c2VZi7OWK1zBsofapo/LLzajwQf658=;
 b=ar5FJmiUk3N133pR2swkUiffgJzKCTMhEwDq/nm9lUMat012ryGDb43ASY+Z8rkEDJwefo
 90+71mv3h26ISpN8SFIB9/3pLmKkKLNWgXG+smQ3+8LkjI6Rk96LN633rpAj3n8Hbv9Y6t
 B0NF26ASzTuTHD7tinzPc/T80YCi2+g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-hRShyfnePBmyyt5FTrIwBA-1; Wed,
 23 Jul 2025 12:50:33 -0400
X-MC-Unique: hRShyfnePBmyyt5FTrIwBA-1
X-Mimecast-MFC-AGG-ID: hRShyfnePBmyyt5FTrIwBA_1753289432
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7388D1800284; Wed, 23 Jul 2025 16:50:32 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.165])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 30D4C180045B; Wed, 23 Jul 2025 16:50:29 +0000 (UTC)
From: Christophe Fontaine <cfontain@redhat.com>
To: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Cc: dev@dpdk.org,
	Christophe Fontaine <cfontain@redhat.com>
Subject: [PATCH 2/2] graph: add callback in dispatch mode
Date: Wed, 23 Jul 2025 18:50:01 +0200
Message-ID: <20250723165001.11162-3-cfontain@redhat.com>
In-Reply-To: <20250723165001.11162-1-cfontain@redhat.com>
References: <20250723165001.11162-1-cfontain@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3PtHHLiOBwpJM1fW1pNbJYw8q5F78PyyFxkMaJp_seU_1753289432
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

In dispatch mode, the assumption is that the graphs will be
polled continuously: there is no way to know when packets are transferred
from one graph to another.

Introduce a callback to be notified when packets are enqueue in the work
queue: this can be useful if we want to wake up a thread.
This sleep/wake up mechanism is deferred to the application.

Signed-off-by: Christophe Fontaine <cfontain@redhat.com>
---
 lib/graph/graph.c                          | 10 +++++++---
 lib/graph/rte_graph.h                      | 14 ++++++++++++++
 lib/graph/rte_graph_model_mcore_dispatch.c |  2 ++
 lib/graph/rte_graph_worker_common.h        |  2 ++
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/lib/graph/graph.c b/lib/graph/graph.c
index 146d0a12b4..61159edc72 100644
--- a/lib/graph/graph.c
+++ b/lib/graph/graph.c
@@ -600,9 +600,13 @@ graph_clone(struct graph *parent_graph, const char *name, struct rte_graph_param
 	graph->graph->model = parent_graph->graph->model;
 
 	/* Create the graph schedule work queue */
-	if (rte_graph_worker_model_get(graph->graph) == RTE_GRAPH_MODEL_MCORE_DISPATCH &&
-	    graph_sched_wq_create(graph, parent_graph, prm))
-		goto graph_mem_destroy;
+	if (rte_graph_worker_model_get(graph->graph) == RTE_GRAPH_MODEL_MCORE_DISPATCH) {
+		if (graph_sched_wq_create(graph, parent_graph, prm))
+			goto graph_mem_destroy;
+
+		graph->graph->dispatch.notify_cb = prm->dispatch.notify_cb;
+		graph->graph->dispatch.cb_priv = prm->dispatch.cb_priv;
+	}
 
 	/* Call init() of the all the nodes in the graph */
 	if (graph_node_init(graph))
diff --git a/lib/graph/rte_graph.h b/lib/graph/rte_graph.h
index 097d0dc9d5..16b1dbac3f 100644
--- a/lib/graph/rte_graph.h
+++ b/lib/graph/rte_graph.h
@@ -150,6 +150,18 @@ typedef void (*rte_node_fini_t)(const struct rte_graph *graph,
 typedef int (*rte_graph_cluster_stats_cb_t)(bool is_first, bool is_last,
 	     void *cookie, const struct rte_graph_cluster_node_stats *stats);
 
+
+/**
+ * Graph dispatch enqueue notification callback.
+ *
+ * @param graph
+ *   Current graph
+ * @param cb_priv
+ *   Opaque argument given to the callback.
+ *
+ */
+typedef void (*packets_enqueued_cb)(struct rte_graph *graph, uint64_t priv);
+
 /**
  * Structure to hold configuration parameters for creating the graph.
  *
@@ -172,6 +184,8 @@ struct rte_graph_param {
 		struct {
 			uint32_t wq_size_max; /**< Maximum size of workqueue for dispatch model. */
 			uint32_t mp_capacity; /**< Capacity of memory pool for dispatch model. */
+			packets_enqueued_cb notify_cb;
+			uint64_t cb_priv;
 		} dispatch;
 	};
 };
diff --git a/lib/graph/rte_graph_model_mcore_dispatch.c b/lib/graph/rte_graph_model_mcore_dispatch.c
index 70f0069bc1..706b5469f0 100644
--- a/lib/graph/rte_graph_model_mcore_dispatch.c
+++ b/lib/graph/rte_graph_model_mcore_dispatch.c
@@ -102,6 +102,8 @@ __graph_sched_node_enqueue(struct rte_node *node, struct rte_graph *graph)
 	if (node->idx > 0)
 		goto submit_again;
 
+	if (graph->dispatch.notify_cb)
+		graph->dispatch.notify_cb(graph, graph->dispatch.cb_priv);
 	return true;
 
 fallback:
diff --git a/lib/graph/rte_graph_worker_common.h b/lib/graph/rte_graph_worker_common.h
index aef0f65673..221deceaee 100644
--- a/lib/graph/rte_graph_worker_common.h
+++ b/lib/graph/rte_graph_worker_common.h
@@ -68,6 +68,8 @@ struct __rte_cache_aligned rte_graph {
 			unsigned int lcore_id;  /**< The graph running Lcore. */
 			struct rte_ring *wq;    /**< The work-queue for pending streams. */
 			struct rte_mempool *mp; /**< The mempool for scheduling streams. */
+			packets_enqueued_cb notify_cb; /**< callback when a packet crosses lcores */
+			uint64_t cb_priv; /**< Opaque parameter for notify_cb */
 		} dispatch; /** Only used by dispatch model */
 	};
 	SLIST_ENTRY(rte_graph) next;   /* The next for rte_graph list */
-- 
2.43.5

