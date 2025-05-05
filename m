Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7D9C369C2
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 06:24:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01A5040650;
	Mon,  5 May 2025 08:24:45 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id DDE5A4025D
 for <dev@dpdk.org>; Mon,  5 May 2025 08:24:43 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5452eFex007254;
 Sun, 4 May 2025 23:24:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=G
 Kp8hXbLftVy5AgRNf8APaFnuQdGeHTPGCFoemGyEz0=; b=Xh+Fu0yRkuiIgr2A+
 WoE3lgpPf+qwLRqlpT63yPD8Fnuev/i1pqFyE5XjdPHQHveQ2hb1qsExZ4ltgPLo
 0VMF04NCnGGssdJWp97mX0p20CNT9sQS4r89Q5kD2JRH4iyksqIqkroEaowQvI/F
 3FVMYQoXWzFiBaABcGah/zOEHJISW8QWadGP63Zo5G/6oy/gHzF+IqqcFQ3Kh74J
 yVBfXhiaaMjH3sbPW8DaxZnl2ru6cNbF6SU2SBT9N2ZYNG+Vz4fh0L+OW2LITF1S
 Pp5FP0I8ZGsrbPOgt/6aoM7VSmTbrS8d+GLEbBjN99SSeqxEalEBzVHI3ABIcPFm
 J0JAQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46djnjj9e1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 04 May 2025 23:24:39 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 4 May 2025 23:24:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 4 May 2025 23:24:34 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.37.22])
 by maili.marvell.com (Postfix) with ESMTP id 532773F7073;
 Sun,  4 May 2025 23:24:32 -0700 (PDT)
From: <kirankumark@marvell.com>
To: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan
 <yanzhirun_163@163.com>
CC: <dev@dpdk.org>
Subject: [PATCH v7 1/3] graph: avoid global node ID counter
Date: Mon, 5 May 2025 11:54:19 +0530
Message-ID: <20250505062422.588450-1-kirankumark@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20241126044402.1209998-1-kirankumark@marvell.com>
References: <20241126044402.1209998-1-kirankumark@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDA1OCBTYWx0ZWRfX1C+yCn/W8RCV
 m1qHKFwTJCZbv/wl3Pvg+8MdfF8MUhBAA0dWDiuiDZTscNh8suIUCxON5xuJXx9FgTkHUVB7+NJ
 2YoAHp0Qa3ub9Y/X/FPdXXvoV7gxCiEQNOwUpWAAE1cYdJj/SHko+atsi5eBuCS3ydbkQCI/0MG
 jHjqDvWV0zUD9S7Y/7ME0d2x2i1urrgBPEfNudhg5ikVvUvugk9wA8GZsV7zOaXS53PTjc+AqT+
 u+GhAio+2TStVyQ9vGFVTkWn165PI9uinr3uv1k4v+LRN1pTUY/KlVqBiYdH7DBcOiaSlsc84PY
 sgnxjxvgxkeWfo0rHll4OefrY4va0lA0tglkB60rNnXVBX3rLdWVEPc+dgPLgJjYzRtjsgdBnvI
 vQF9AZ5Gt+jVQjK+bb6OR2PckDPZYTetbgnId2C9gsUGHNEiux9bWwaC33bO5seejnn0ZmBT
X-Proofpoint-ORIG-GUID: BJJRoB73TS8KjjyUjZN8dW-gqwqn7lj-
X-Proofpoint-GUID: BJJRoB73TS8KjjyUjZN8dW-gqwqn7lj-
X-Authority-Analysis: v=2.4 cv=XNwwSRhE c=1 sm=1 tr=0 ts=681859a7 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=dZ_QEZhM9UTCNBGJqFYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_03,2025-04-30_01,2025-02-21_01
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

From: Kiran Kumar K <kirankumark@marvell.com>

The node id is determined based on a global variable that is
incremented every time a node is created. Adding changes to
remove the global counter. Make sure that the node list is always
ordered by increasing node ids. When creating a new node, pick a free
id which is not allocated.

Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>
Acked-by: Jerin Jacob <jerinj@marvell.com>
---
* V7 Changes:
 - Updated Acked-by
 lib/graph/graph_populate.c | 11 +++--
 lib/graph/graph_private.h  |  8 ----
 lib/graph/node.c           | 86 ++++++++++++++++++++++++++++++++------
 3 files changed, 82 insertions(+), 23 deletions(-)

diff --git a/lib/graph/graph_populate.c b/lib/graph/graph_populate.c
index 1e6b08319e..026daecb21 100644
--- a/lib/graph/graph_populate.c
+++ b/lib/graph/graph_populate.c
@@ -78,7 +78,6 @@ graph_nodes_populate(struct graph *_graph)
 	struct rte_graph *graph = _graph->graph;
 	struct graph_node *graph_node;
 	rte_edge_t count, nb_edges;
-	const char *parent;
 	rte_node_t pid;

 	STAILQ_FOREACH(graph_node, &_graph->node_list, next) {
@@ -94,8 +93,14 @@ graph_nodes_populate(struct graph *_graph)
 		memcpy(node->name, graph_node->node->name, RTE_GRAPH_NAMESIZE);
 		pid = graph_node->node->parent_id;
 		if (pid != RTE_NODE_ID_INVALID) { /* Cloned node */
-			parent = rte_node_id_to_name(pid);
-			memcpy(node->parent, parent, RTE_GRAPH_NAMESIZE);
+			struct node *pnode;
+
+			STAILQ_FOREACH(pnode, node_list_head_get(), next) {
+				if (pnode->id == pid) {
+					memcpy(node->parent, pnode->name, RTE_GRAPH_NAMESIZE);
+					break;
+				}
+			}
 		}
 		node->id = graph_node->node->id;
 		node->parent_id = pid;
diff --git a/lib/graph/graph_private.h b/lib/graph/graph_private.h
index 813dd78b9d..3529640abf 100644
--- a/lib/graph/graph_private.h
+++ b/lib/graph/graph_private.h
@@ -29,14 +29,6 @@ extern int rte_graph_logtype;
 #define graph_info(...) GRAPH_LOG(INFO, __VA_ARGS__)
 #define graph_dbg(...) GRAPH_LOG(DEBUG, __VA_ARGS__)

-#define ID_CHECK(id, id_max)                                                   \
-	do {                                                                   \
-		if ((id) >= (id_max)) {                                        \
-			rte_errno = EINVAL;                                    \
-			goto fail;                                             \
-		}                                                              \
-	} while (0)
-
 #define SET_ERR_JMP(err, where, fmt, ...)                                      \
 	do {                                                                   \
 		graph_err(fmt, ##__VA_ARGS__);                                 \
diff --git a/lib/graph/node.c b/lib/graph/node.c
index 101981ec24..53a3f3f2d4 100644
--- a/lib/graph/node.c
+++ b/lib/graph/node.c
@@ -16,9 +16,56 @@
 #include "graph_private.h"

 static struct node_head node_list = STAILQ_HEAD_INITIALIZER(node_list);
-static rte_node_t node_id;

-#define NODE_ID_CHECK(id) ID_CHECK(id, node_id)
+static struct node *
+node_from_id(rte_node_t id)
+{
+	struct node *node = NULL;
+
+	graph_spinlock_lock();
+	rte_errno = EINVAL;
+	STAILQ_FOREACH(node, &node_list, next) {
+		if (node->id == id) {
+			rte_errno = 0;
+			goto exit;
+		}
+	}
+exit:
+	graph_spinlock_unlock();
+	return node;
+}
+
+static rte_node_t
+next_next_free_id(void)
+{
+	struct node *node;
+	rte_node_t id = 0;
+
+	STAILQ_FOREACH(node, &node_list, next) {
+		if (id < node->id)
+			break;
+		id = node->id + 1;
+	}
+	return id;
+}
+
+static void
+node_insert_ordered(struct node *node)
+{
+	struct node *after, *g;
+
+	after = NULL;
+	STAILQ_FOREACH(g, &node_list, next) {
+		if (g->id < node->id)
+			after = g;
+		else if (g->id > node->id)
+			break;
+	}
+	if (after == NULL)
+		STAILQ_INSERT_HEAD(&node_list, node, next);
+	else
+		STAILQ_INSERT_AFTER(&node_list, after, node, next);
+}

 /* Private functions */
 struct node_head *
@@ -118,10 +165,10 @@ __rte_node_register(const struct rte_node_register *reg)
 	}

 	node->lcore_id = RTE_MAX_LCORE;
-	node->id = node_id++;
+	node->id = next_next_free_id();

-	/* Add the node at tail */
-	STAILQ_INSERT_TAIL(&node_list, node, next);
+	/* Add the node in ordered list */
+	node_insert_ordered(node);
 	graph_spinlock_unlock();

 	return node->id;
@@ -197,7 +244,9 @@ rte_node_clone(rte_node_t id, const char *name)
 {
 	struct node *node;

-	NODE_ID_CHECK(id);
+	if (node_from_id(id) == NULL)
+		goto fail;
+
 	STAILQ_FOREACH(node, &node_list, next)
 		if (node->id == id)
 			return node_clone(node, name);
@@ -225,7 +274,8 @@ rte_node_id_to_name(rte_node_t id)
 {
 	struct node *node;

-	NODE_ID_CHECK(id);
+	if (node_from_id(id) == NULL)
+		goto fail;
 	STAILQ_FOREACH(node, &node_list, next)
 		if (node->id == id)
 			return node->name;
@@ -240,7 +290,8 @@ rte_node_edge_count(rte_node_t id)
 {
 	struct node *node;

-	NODE_ID_CHECK(id);
+	if (node_from_id(id) == NULL)
+		goto fail;
 	STAILQ_FOREACH(node, &node_list, next)
 		if (node->id == id)
 			return node->nb_edges;
@@ -310,7 +361,8 @@ rte_node_edge_shrink(rte_node_t id, rte_edge_t size)
 	rte_edge_t rc = RTE_EDGE_ID_INVALID;
 	struct node *node;

-	NODE_ID_CHECK(id);
+	if (node_from_id(id) == NULL)
+		goto fail;
 	graph_spinlock_lock();

 	STAILQ_FOREACH(node, &node_list, next) {
@@ -338,7 +390,8 @@ rte_node_edge_update(rte_node_t id, rte_edge_t from, const char **next_nodes,
 	rte_edge_t rc = RTE_EDGE_ID_INVALID;
 	struct node *n, *prev;

-	NODE_ID_CHECK(id);
+	if (node_from_id(id) == NULL)
+		goto fail;
 	graph_spinlock_lock();

 	prev = NULL;
@@ -373,7 +426,8 @@ rte_node_edge_get(rte_node_t id, char *next_nodes[])
 	rte_node_t rc = RTE_NODE_ID_INVALID;
 	struct node *node;

-	NODE_ID_CHECK(id);
+	if (node_from_id(id) == NULL)
+		goto fail;
 	graph_spinlock_lock();

 	STAILQ_FOREACH(node, &node_list, next) {
@@ -397,7 +451,8 @@ node_scan_dump(FILE *f, rte_node_t id, bool all)
 	struct node *node;

 	RTE_ASSERT(f != NULL);
-	NODE_ID_CHECK(id);
+	if (node_from_id(id) == NULL)
+		goto fail;

 	STAILQ_FOREACH(node, &node_list, next) {
 		if (all == true) {
@@ -429,5 +484,12 @@ RTE_EXPORT_SYMBOL(rte_node_max_count)
 rte_node_t
 rte_node_max_count(void)
 {
+	rte_node_t node_id = 0;
+	struct node *node;
+
+	STAILQ_FOREACH(node, &node_list, next) {
+		if (node_id < node->id)
+			node_id = node->id;
+	}
 	return node_id;
 }
--
2.48.1

