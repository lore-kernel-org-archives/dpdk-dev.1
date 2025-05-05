Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17567C369C2
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 06:21:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8431040658;
	Mon,  5 May 2025 08:21:12 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2EB1F40656
 for <dev@dpdk.org>; Mon,  5 May 2025 08:21:11 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5452eFes007254;
 Sun, 4 May 2025 23:21:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=7
 fs7+FMR2a7qCMssoeYuqaykEfforhi0qcSDXHWvr/0=; b=CohIosP0pa/YP1iUh
 ZFiamKDvtlONWBeK9aWe2SMgR2nAkIOSn7GwH5inkkLE0uAFTXEjQOFyi0ys+3rU
 Qk66rmRNkofeibdaLSR5jDsAUAU1GD0mYb69HzAJm91aJ1moSaa1giMsnfOftGmY
 IlbGg+8WclAoaAhwpfSlgytZz1g4dW2Wqwhrv3FlnAte0+ZWvZyhYwhapxG2oNvm
 RVaOpodQW3N7E+fN14hszJMcSZ0ARpxsKjzQPIjznXm1d9X0a33q/q8sTXDB8/xe
 Yh9AiH8D2/ArLjJMslnjNBvaPJsn/JimT4Iv+/jnb7pw0FFDnQrbueM6B0kNDvWg
 ml41Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46djnjj99w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 04 May 2025 23:21:07 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 4 May 2025 23:21:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 4 May 2025 23:21:05 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.37.22])
 by maili.marvell.com (Postfix) with ESMTP id 9B28D3F7092;
 Sun,  4 May 2025 23:21:03 -0700 (PDT)
From: <kirankumark@marvell.com>
To: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan
 <yanzhirun_163@163.com>
CC: <dev@dpdk.org>
Subject: [PATCH v6 2/3] graph: add support for node free API
Date: Mon, 5 May 2025 11:50:54 +0530
Message-ID: <20250505062056.570488-2-kirankumark@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250505062056.570488-1-kirankumark@marvell.com>
References: <20241126044402.1209998-1-kirankumark@marvell.com>
 <20250505062056.570488-1-kirankumark@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDA1NyBTYWx0ZWRfX+C85LWsVRlgg
 VFJobCIH74rwon2+u4n8FGIWpk19VZVfArTTbhk3GEzlxXocIMhzPlS7w1NJpH0hBOySJh7OjY7
 LPvB1gUa4NYPXTeLzv4WZzrmsgFgxX2nEfZguId+zQdEwo/MiSViZjV1h9pZ52N775flXcpmKzk
 MyBOoMPJXt+3vD20hKYdEt6fC+iMzQGYU7O2tIMOjFx5sbATXZ2c6SYRoIKNhHTIGLpWcFoeAkk
 l6UG25pZZW2pWP52XVzmJtwbhzE8AE+xMOSTGI494qfYQM2ckHdW0Hg5M/GkaJ6Is7ZW4LEIZB7
 AYTANnWWuBfQnyftV8YPomvSxyR3tGRfiVTnd9gd2HFsBoH9Dw7dmwWNr7odjTjzMoiipq14T+G
 /Js6A8XP1K82opvqlefLtN1Mv6xcQXOz/dEr2eAjeaPjYpQaPBR3DDiscEdFohAsDJ1EDZeA
X-Proofpoint-ORIG-GUID: 4oaj6kUy9v3lfHL0IkIDoDV__nf9dMNn
X-Proofpoint-GUID: 4oaj6kUy9v3lfHL0IkIDoDV__nf9dMNn
X-Authority-Analysis: v=2.4 cv=XNwwSRhE c=1 sm=1 tr=0 ts=681858d3 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=_KCPTIYsx23brUyM_XUA:9
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

Add support for rte_node_free API to free the node and its
memory, if node is not part of any of the created graphs.

Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>
Acked-by: Jerin Jacob <jerinj@marvell.com>
---
 lib/graph/graph.c         | 16 ++++++++++++++++
 lib/graph/graph_private.h | 13 +++++++++++++
 lib/graph/node.c          | 26 ++++++++++++++++++++++++++
 lib/graph/rte_graph.h     | 15 +++++++++++++++
 4 files changed, 70 insertions(+)

diff --git a/lib/graph/graph.c b/lib/graph/graph.c
index fe12bd3753..0975bd8d49 100644
--- a/lib/graph/graph.c
+++ b/lib/graph/graph.c
@@ -21,6 +21,22 @@
 static struct graph_head graph_list = STAILQ_HEAD_INITIALIZER(graph_list);
 static rte_spinlock_t graph_lock = RTE_SPINLOCK_INITIALIZER;
 
+bool
+graph_is_node_active_in_graph(struct node *node)
+{
+	struct graph *graph;
+
+	STAILQ_FOREACH(graph, &graph_list, next) {
+		struct graph_node *graph_node;
+
+		STAILQ_FOREACH(graph_node, &graph->node_list, next)
+			if (graph_node->node == node)
+				return 1;
+	}
+
+	return 0;
+}
+
 /* Private functions */
 static struct graph *
 graph_from_id(rte_graph_t id)
diff --git a/lib/graph/graph_private.h b/lib/graph/graph_private.h
index 3529640abf..eee5be6a34 100644
--- a/lib/graph/graph_private.h
+++ b/lib/graph/graph_private.h
@@ -440,4 +440,17 @@ int graph_sched_wq_create(struct graph *_graph, struct graph *_parent_graph,
  */
 void graph_sched_wq_destroy(struct graph *_graph);
 
+/**
+ * @internal
+ *
+ * Check if given node present in any of the created graphs.
+ *
+ * @param node
+ *   The node object
+ *
+ * @return
+ *   0 if not present in any graph, else return 1.
+ */
+bool graph_is_node_active_in_graph(struct node *_node);
+
 #endif /* _RTE_GRAPH_PRIVATE_H_ */
diff --git a/lib/graph/node.c b/lib/graph/node.c
index 53a3f3f2d4..c1b5878592 100644
--- a/lib/graph/node.c
+++ b/lib/graph/node.c
@@ -493,3 +493,29 @@ rte_node_max_count(void)
 	}
 	return node_id;
 }
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_free, 25.7)
+int
+rte_node_free(rte_node_t id)
+{
+	struct node *node;
+	int rc = -1;
+
+	if (node_from_id(id) == NULL)
+		goto fail;
+
+	graph_spinlock_lock();
+	STAILQ_FOREACH(node, &node_list, next) {
+		if (id == node->id) {
+			if (!graph_is_node_active_in_graph(node)) {
+				STAILQ_REMOVE(&node_list, node, node, next);
+				free(node);
+				rc = 0;
+			}
+			break;
+		}
+	}
+	graph_spinlock_unlock();
+fail:
+	return rc;
+}
diff --git a/lib/graph/rte_graph.h b/lib/graph/rte_graph.h
index f5e575dbed..097d0dc9d5 100644
--- a/lib/graph/rte_graph.h
+++ b/lib/graph/rte_graph.h
@@ -22,6 +22,7 @@
 #include <stdio.h>
 
 #include <rte_common.h>
+#include <rte_compat.h>
 
 #ifdef __cplusplus
 extern "C" {
@@ -661,6 +662,20 @@ rte_node_is_invalid(rte_node_t id)
 	return (id == RTE_NODE_ID_INVALID);
 }
 
+/**
+ * Release the memory allocated for a node created using RTE_NODE_REGISTER or rte_node_clone,
+ * if it is not linked to any graphs.
+ *
+ * @param id
+ *   Node id to check.
+ *
+ * @return
+ *   - 0: Success.
+ *   -<0: Failure.
+ */
+__rte_experimental
+int rte_node_free(rte_node_t id);
+
 /**
  * Test the validity of edge id.
  *
-- 
2.48.1

