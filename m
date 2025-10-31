Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9ACCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 22:13:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C74D4027A;
	Fri, 31 Oct 2025 23:13:35 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8B77340150
 for <dev@dpdk.org>; Fri, 31 Oct 2025 23:13:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761948813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fvEFwP6zmVw+rV8Fg08ILqNgaQmYp8+ItexBsH3GPV0=;
 b=JYnynpGfYTIr994xY+z1AQKzGZBWvjcSTYesUiYX61b4C35u6539cDJljCLOB53wB0d/cO
 5R/jKyX0oYBgXm6bOfNdt1aMckDLstNwKLXiU1834YBVFz0ZJAjD7rGHpMWCX6mCBG6jvs
 /MkSdAF8rLIAmqBdB6WR3k8w7KKLuLs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-aCBJvVsbM1CbBlYQeyAnxg-1; Fri,
 31 Oct 2025 18:13:31 -0400
X-MC-Unique: aCBJvVsbM1CbBlYQeyAnxg-1
X-Mimecast-MFC-AGG-ID: aCBJvVsbM1CbBlYQeyAnxg_1761948810
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B291195608D; Fri, 31 Oct 2025 22:13:30 +0000 (UTC)
Received: from ringo.home (unknown [10.44.32.13])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E64821955BE3; Fri, 31 Oct 2025 22:13:26 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org, Jerin Jacob <jerinj@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>
Cc: stable@dpdk.org
Subject: [PATCH dpdk] graph: fix use-after-free when updating edges with
 active graphs
Date: Fri, 31 Oct 2025 23:13:04 +0100
Message-ID: <20251031221304.394997-2-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -d5VLcntIM_Cmzh6wzO5OU-0OS55lQUIRrbWpWoq0BY_1761948810
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

After creating at least one graph and calling rte_node_edge_update to
add a new edge on a node which is in use in the graph, the node memory
is reallocated but the active graph still has a pointer to the freed
memory.

When destroying the graph, it causes a use-after-free error detected by
libasan:

ERROR: AddressSanitizer: heap-use-after-free
READ of size 8 at 0x7c4baa5e4da8 thread T0
    #0 0x0000005ad224 in graph_node_fini lib/graph/graph.c:256
    #1 0x0000005ae657 in rte_graph_destroy lib/graph/graph.c:504
    ...

freed by thread T0 here:
    #0 0x7f1bac4e5e4b in realloc.part.0 (/lib64/libasan.so.8+0xe5e4b)
    #1 0x0000005ab6d7 in edge_update lib/graph/node.c:271
    #2 0x0000005abb1b in rte_node_edge_update lib/graph/node.c:339
    ...

previously allocated by thread T0 here:
    #0 0x7f1bac4e5e4b in realloc.part.0 (/lib64/libasan.so.8+0xe5e4b)
    #1 0x0000005ab6d7 in edge_update lib/graph/node.c:271
    #2 0x0000005abb1b in rte_node_edge_update lib/graph/node.c:339
    ...

Use malloc+memcpy and add an internal function to replace all references
to the old node memory before freeing it.

Cc: stable@dpdk.org
Fixes: c59dac2ca14a ("graph: implement node operations")

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 lib/graph/graph.c         | 14 ++++++++++++++
 lib/graph/graph_private.h | 12 ++++++++++++
 lib/graph/node.c          |  6 +++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/lib/graph/graph.c b/lib/graph/graph.c
index 61159edc7261..6911ea8abeed 100644
--- a/lib/graph/graph.c
+++ b/lib/graph/graph.c
@@ -277,6 +277,20 @@ graph_node_fini(struct graph *graph)
 						       graph_node->node->name));
 }
 
+void
+graph_node_replace_all(struct node *old, struct node *new)
+{
+	struct graph_node *graph_node;
+	struct graph *graph;
+
+	STAILQ_FOREACH(graph, &graph_list, next) {
+		STAILQ_FOREACH(graph_node, &graph->node_list, next) {
+			if (graph_node->node == old)
+				graph_node->node = new;
+		}
+	}
+}
+
 static struct rte_graph *
 graph_mem_fixup_node_ctx(struct rte_graph *graph)
 {
diff --git a/lib/graph/graph_private.h b/lib/graph/graph_private.h
index 21912c0ae63f..26cdc6637192 100644
--- a/lib/graph/graph_private.h
+++ b/lib/graph/graph_private.h
@@ -299,6 +299,18 @@ int graph_node_has_edge_to_src_node(struct graph *graph);
  */
 int graph_node_has_loop_edge(struct graph *graph);
 
+/**
+ * @internal
+ *
+ * Replace all pointers of a given node with another one in all active graphs.
+ *
+ * @param old
+ *   Node pointer to replace in all graphs.
+ * @param new
+ *   Updated pointer.
+ */
+void graph_node_replace_all(struct node *old, struct node *new);
+
 /**
  * @internal
  *
diff --git a/lib/graph/node.c b/lib/graph/node.c
index cae1c809edc4..e3359fe490a5 100644
--- a/lib/graph/node.c
+++ b/lib/graph/node.c
@@ -325,11 +325,15 @@ edge_update(struct node *node, struct node *prev, rte_edge_t from,
 	need_realloc = max_edges > node->nb_edges;
 	if (need_realloc) {
 		sz = sizeof(struct node) + (max_edges * RTE_NODE_NAMESIZE);
-		new_node = realloc(node, sz);
+		new_node = malloc(sz);
 		if (new_node == NULL) {
 			rte_errno = ENOMEM;
 			goto restore;
 		} else {
+			sz = sizeof(*node) + (node->nb_edges * RTE_NODE_NAMESIZE);
+			memcpy(new_node, node, sz);
+			graph_node_replace_all(node, new_node);
+			free(node);
 			node = new_node;
 		}
 	}
-- 
2.51.1

