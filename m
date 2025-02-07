Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F726C02198
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 01:39:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C43D1402D5;
	Fri,  7 Feb 2025 02:39:49 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by mails.dpdk.org (Postfix) with ESMTP id 2DC0A402A7
 for <dev@dpdk.org>; Fri,  7 Feb 2025 02:39:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=fOV86
 9R3C4VfoDh6CynT67n+yMKoHzLx77TSzMiHn2U=; b=TEsZCynSScZhwr3JVWRdp
 jKmWn05HIQQuYOQtQb85t57JdfWYOItNyHr9KkuoyPwzC+LzFzOqC0VBMJx8OAn1
 Mkv6Bjb8FyACRYa12HFcMQGWgLVntums3xnFPwL4MSaFk0BeNEWS1rsF9fmL/Ryt
 QEJ+P88+B+QdZRW904FUZQ=
Received: from localhost.localdomain.localdomain (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wDHXWtfZKVnXOtwKA--.63092S2; 
 Fri, 07 Feb 2025 09:39:44 +0800 (CST)
From: Huichao Cai <chcchc88@163.com>
To: jerinj@marvell.com, kirankumark@marvell.com, ndabilpuram@marvell.com,
 yanzhirun_163@163.com
Cc: dev@dpdk.org
Subject: [PATCH v8] graph: mcore: optimize graph search
Date: Fri,  7 Feb 2025 09:39:39 +0800
Message-Id: <20250207013939.1783-1-chcchc88@163.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250206025322.2182-1-chcchc88@163.com>
References: <20250206025322.2182-1-chcchc88@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDHXWtfZKVnXOtwKA--.63092S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF1rJF4fKF48JFWkCw4DJwb_yoW5CFW7p3
 WfKFWrGrZ8tF1rKrn2gF48XFW8J3Wqq3y2gryxW3WfJrs8Jr1xury8AFy3KF47JrZxC3W7
 uw4jqryUGr1DW37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UJb15UUUUU=
X-Originating-IP: [1.202.233.207]
X-CM-SenderInfo: pfkfuxrfyyqiywtou0bp/1tbiIBzsF2elYik2HQAAsl
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

In the function __rte_graph_mcore_dispatch_sched_node_enqueue,
use a slower loop to search for the graph, modify the search logic
to record the result of the first search, and use this record for
subsequent searches to improve search speed.

Signed-off-by: Huichao Cai <chcchc88@163.com>
---
 devtools/libabigail.abignore               |  5 +++++
 doc/guides/rel_notes/release_25_03.rst     |  1 +
 lib/graph/rte_graph_model_mcore_dispatch.c | 11 +++++++----
 lib/graph/rte_graph_worker_common.h        |  1 +
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/devtools/libabigail.abignore b/devtools/libabigail.abignore
index 21b8cd6113..8876aaee2e 100644
--- a/devtools/libabigail.abignore
+++ b/devtools/libabigail.abignore
@@ -33,3 +33,8 @@
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ; Temporary exceptions till next major ABI version ;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+[suppress_type]
+        name = rte_node
+        has_size_change = no
+        has_data_member_inserted_between =
+{offset_after(original_process), offset_of(xstat_off)}
\ No newline at end of file
diff --git a/doc/guides/rel_notes/release_25_03.rst b/doc/guides/rel_notes/release_25_03.rst
index 269ab6f68a..16a888fd19 100644
--- a/doc/guides/rel_notes/release_25_03.rst
+++ b/doc/guides/rel_notes/release_25_03.rst
@@ -150,6 +150,7 @@ ABI Changes
 
 * No ABI change that would break compatibility with 24.11.
 
+* graph: Added ``graph`` field to the ``dispatch`` structure in the ``rte_node`` structure.
 
 Known Issues
 ------------
diff --git a/lib/graph/rte_graph_model_mcore_dispatch.c b/lib/graph/rte_graph_model_mcore_dispatch.c
index a590fc9497..a81d338227 100644
--- a/lib/graph/rte_graph_model_mcore_dispatch.c
+++ b/lib/graph/rte_graph_model_mcore_dispatch.c
@@ -118,11 +118,14 @@ __rte_graph_mcore_dispatch_sched_node_enqueue(struct rte_node *node,
 					      struct rte_graph_rq_head *rq)
 {
 	const unsigned int lcore_id = node->dispatch.lcore_id;
-	struct rte_graph *graph;
+	struct rte_graph *graph = node->dispatch.graph;
 
-	SLIST_FOREACH(graph, rq, next)
-		if (graph->dispatch.lcore_id == lcore_id)
-			break;
+	if (unlikely((!graph) || (graph->dispatch.lcore_id != lcore_id))) {
+		SLIST_FOREACH(graph, rq, next)
+			if (graph->dispatch.lcore_id == lcore_id)
+				break;
+		node->dispatch.graph = graph;
+	}
 
 	return graph != NULL ? __graph_sched_node_enqueue(node, graph) : false;
 }
diff --git a/lib/graph/rte_graph_worker_common.h b/lib/graph/rte_graph_worker_common.h
index d3ec88519d..aef0f65673 100644
--- a/lib/graph/rte_graph_worker_common.h
+++ b/lib/graph/rte_graph_worker_common.h
@@ -110,6 +110,7 @@ struct __rte_cache_aligned rte_node {
 			unsigned int lcore_id;  /**< Node running lcore. */
 			uint64_t total_sched_objs; /**< Number of objects scheduled. */
 			uint64_t total_sched_fail; /**< Number of scheduled failure. */
+			struct rte_graph *graph;  /**< Graph corresponding to lcore_id. */
 		} dispatch;
 	};
 
-- 
2.33.0

