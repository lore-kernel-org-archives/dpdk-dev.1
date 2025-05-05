Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA26C369C2
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 06:21:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B4414065F;
	Mon,  5 May 2025 08:21:15 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 93C1C4065F
 for <dev@dpdk.org>; Mon,  5 May 2025 08:21:14 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5454OnBL007885;
 Sun, 4 May 2025 23:21:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
 qaISKzX7s2vy1TPSnxG3O1P/CeN0msW0r629uejN+I=; b=XmcS4AVGWryO1LX9X
 0NYZRjvez3SogbkO6or23BiUUnFRAkwDTUw0GGn9Xo8++dBt0bTAhQKTI8J7DPkF
 bL0kn7BSzNL5m1+28S98RS6mm5LsXdu0jOVH0JdXn/XI4Ey+wgSBZpjWn9XzsbLq
 /4vx86NEgvLXCAaWp+dfKQAl9pdsx8yKxyIPvasu+YgJeG+tksu3ZYZGr4ExCzvR
 6KhhvIbIqhwmpYFfEEfQW/r1pFtiyRdEskUEtJiB2AUupaOGqwfxAbiwOMYKep1G
 FyaqDbNrhcwXaNyJR4aBYLFTLsTWrUOBY1bEOl3XGJmy+LyQVYtaHkVIFAde+tji
 mGSlA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46ehxkrffh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 04 May 2025 23:21:10 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 4 May 2025 23:21:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 4 May 2025 23:21:09 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.37.22])
 by maili.marvell.com (Postfix) with ESMTP id 78E983F708A;
 Sun,  4 May 2025 23:21:07 -0700 (PDT)
From: <kirankumark@marvell.com>
To: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan
 <yanzhirun_163@163.com>
CC: <dev@dpdk.org>
Subject: [PATCH v6 3/3] test/graph: fix graph autotest second run test failure
Date: Mon, 5 May 2025 11:50:55 +0530
Message-ID: <20250505062056.570488-3-kirankumark@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250505062056.570488-1-kirankumark@marvell.com>
References: <20241126044402.1209998-1-kirankumark@marvell.com>
 <20250505062056.570488-1-kirankumark@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: cdTJ2qoNbratzRTw0cbYHp3D71CDsEmD
X-Proofpoint-GUID: cdTJ2qoNbratzRTw0cbYHp3D71CDsEmD
X-Authority-Analysis: v=2.4 cv=QOFoRhLL c=1 sm=1 tr=0 ts=681858d6 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=MqI-DGuoOvG9Fh05Se8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDA1NyBTYWx0ZWRfX4aOLI5lPsLqW
 YYiUn0xkJ6LR0YIAgCm/qiNSPP2SrCpbrY/AwzeiKw9CzFXSXv7q5ne7fFMcVIdZS7xGm7gZAXv
 51DPqm0bls2Z2viFJnLSzJEuZWslmKUT0Ka/Gc37JT6dl7uJVMSL1wFqIrfCYeLbBuE3H8ILsgL
 k2aR86wdXaja7B1pkwIvGutM+F8WRA7mVqKDIfk+tK2JhxKG97XhPTGhC9ZUcAl6wOg1oh/zIE+
 4DUHczRn4+Jv2rbtBl7tU8UuXAzRawB7ibvwXvH0G8ALr2XUR8HNQ0GWDx0ALxQgthp3Hgc8vIq
 4JhhUccMsmbK5PRfyGFPmL2EKCHuwjnl4zANT5dBapM0hglDN0LS9rrdPFPy5sKw51PzIIBaMox
 l9s62gBiUhma9lM2iuy8wOMb+K7jPbnV47S4xe5BO7wX51xnzrkqpZoJpSzsZRxIU18bVK6a
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

The graph autotest second run test is failing due to the
node name is already present in the node list. Adding changes
to free nodes at the time of test cleanup.

Fixes: 6b89650418fe ("test/graph: add functional tests")

Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>
Series-Acked-by: Jerin Jacob <jerinj@marvell.com>
---
* V6 changes:
 - Rebase to latest main
 app/test/test_graph.c | 95 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 90 insertions(+), 5 deletions(-)

diff --git a/app/test/test_graph.c b/app/test/test_graph.c
index 2840a25b13..635b8dd527 100644
--- a/app/test/test_graph.c
+++ b/app/test/test_graph.c
@@ -68,6 +68,8 @@ static void *mbuf_p[MAX_NODES + 1][MBUFF_SIZE];
 static rte_graph_t graph_id;
 static uint64_t obj_stats[MAX_NODES + 1];
 static uint64_t fn_calls[MAX_NODES + 1];
+static uint32_t dummy_nodes_id[MAX_NODES];
+static uint32_t dummy_nodes_id_count;

 const char *node_patterns[] = {
 	"test_node_source1",	   "test_node00",
@@ -541,6 +543,66 @@ test_lookup_functions(void)
 	return 0;
 }

+static int
+test_node_id(void)
+{
+	uint32_t node_id, odummy_id, dummy_id, dummy_id1;
+
+	node_id = rte_node_from_name("test_node00");
+
+	dummy_id = rte_node_clone(node_id, "test_node_id00");
+	if (rte_node_is_invalid(dummy_id)) {
+		printf("Got invalid id when clone\n");
+		return -1;
+	}
+
+	dummy_id1 = rte_node_clone(node_id, "test_node_id01");
+	if (rte_node_is_invalid(dummy_id1)) {
+		printf("Got invalid id when clone\n");
+		return -1;
+	}
+
+	/* Expect next node id to be node_id + 1 */
+	if ((dummy_id + 1) != dummy_id1) {
+		printf("Node id didn't match, expected = %d got = %d\n",
+		       dummy_id+1, dummy_id1);
+		return -1;
+	}
+
+	odummy_id = dummy_id;
+	/* Free one of the cloned node */
+	if (rte_node_free(dummy_id)) {
+		printf("Failed to free node\n");
+		return -1;
+	}
+
+	/* Clone again, should get the same id, that is freed */
+	dummy_id = rte_node_clone(node_id, "test_node_id00");
+	if (rte_node_is_invalid(dummy_id)) {
+		printf("Got invalid id when clone\n");
+		return -1;
+	}
+
+	if (dummy_id != odummy_id) {
+		printf("Node id didn't match, expected = %d got = %d\n",
+		       odummy_id, dummy_id);
+		return -1;
+	}
+
+	/* Free the node */
+	if (rte_node_free(dummy_id)) {
+		printf("Failed to free node\n");
+		return -1;
+	}
+
+	if (rte_node_free(dummy_id1)) {
+		printf("Failed to free node\n");
+		return -1;
+	}
+
+	return 0;
+}
+
 static int
 test_node_clone(void)
 {
@@ -551,11 +613,12 @@ test_node_clone(void)
 	node_id = rte_node_from_name("test_node00");
 	tm->test_node[0].idx = node_id;

-	dummy_id = rte_node_clone(node_id, "test_node00");
-	if (rte_node_is_invalid(dummy_id)) {
+	dummy_nodes_id[dummy_nodes_id_count] = rte_node_clone(node_id, "test_node00");
+	if (rte_node_is_invalid(dummy_nodes_id[dummy_nodes_id_count])) {
 		printf("Got invalid id when clone, Expecting fail\n");
 		return -1;
 	}
+	dummy_nodes_id_count++;

 	/* Clone with same name, should fail */
 	dummy_id = rte_node_clone(node_id, "test_node00");
@@ -635,15 +698,15 @@ test_create_graph(void)
 		.nb_node_patterns = 6,
 		.node_patterns = node_patterns_dummy,
 	};
-	uint32_t dummy_node_id;
 	uint32_t node_id;

 	node_id = rte_node_from_name("test_node00");
-	dummy_node_id = rte_node_clone(node_id, "dummy_node");
-	if (rte_node_is_invalid(dummy_node_id)) {
+	dummy_nodes_id[dummy_nodes_id_count] = rte_node_clone(node_id, "dummy_node");
+	if (rte_node_is_invalid(dummy_nodes_id[dummy_nodes_id_count])) {
 		printf("Got invalid node id\n");
 		return -1;
 	}
+	dummy_nodes_id_count++;

 	graph_id = rte_graph_create("worker0", &gconf);
 	if (graph_id != RTE_GRAPH_ID_INVALID) {
@@ -1026,17 +1089,39 @@ graph_setup(void)
 	}
 	printf("test_node_clone: pass\n");

+	if (test_node_id()) {
+		printf("test_node_id: fail\n");
+		return -1;
+	}
+	printf("test_node_id: pass\n");
+
 	return 0;
 }

 static void
 graph_teardown(void)
 {
+	uint32_t i;
 	int id;

 	id = rte_graph_destroy(rte_graph_from_name("worker0"));
 	if (id)
 		printf("Graph Destroy failed\n");
+
+	for (i = 1; i < MAX_NODES; i++) {
+		if (rte_node_free(test_main.test_node[i].idx)) {
+			printf("Node free failed\n");
+			return;
+		}
+	}
+
+	for (i = 0; i < dummy_nodes_id_count; i++) {
+		if (rte_node_free(dummy_nodes_id[i])) {
+			printf("Node free failed\n");
+			return;
+		}
+	}
+	dummy_nodes_id_count = 0;
 }

 static struct unit_test_suite graph_testsuite = {
--
2.48.1

