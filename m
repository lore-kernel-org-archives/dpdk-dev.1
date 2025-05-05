Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBBDC369C2
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 06:24:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB7A440667;
	Mon,  5 May 2025 08:24:47 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0156F40667
 for <dev@dpdk.org>; Mon,  5 May 2025 08:24:46 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54530fkG011430;
 Sun, 4 May 2025 23:24:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=c
 DX6zVldBYsUNQVNkoztCoWLzHOyBrEnti8vB9bT0Qo=; b=dn6m+GTkp0Bw82Eut
 Co3o2aDJeVdBGw2aU5n4YHc31E1WCIL30H+R2wF8IDPBdxhDRL2t2+R1oNPpeof6
 4VdYxwheBRYUN+cTkUz0Uxb/f46HFQR155zVnYpWihLmGvvTjMxcvnQRpvSfGJfh
 trEKlIKfLoC+UFTdQ14n07pLKpkGMcUxTQ4nPhniIGK/JSjnV/9oDdNM1Svxcsa8
 lzYljyzi7ZtO9napooniaOsIFL8qSD9I7RRB5d/M+zsqyx0JjrVVQQhB/4a73cHy
 sEn0i8sO8Hnn0by4HAykc2gLLUfnrBcWQmjfRl8Y+rjGKGHZcXiZoFEeYGXmJPlv
 7UMDg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46ehxprg7p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 04 May 2025 23:24:43 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 4 May 2025 23:24:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 4 May 2025 23:24:42 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.37.22])
 by maili.marvell.com (Postfix) with ESMTP id 35EFA3F7073;
 Sun,  4 May 2025 23:24:39 -0700 (PDT)
From: <kirankumark@marvell.com>
To: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan
 <yanzhirun_163@163.com>
CC: <dev@dpdk.org>
Subject: [PATCH v7 3/3] test/graph: fix graph autotest second run test failure
Date: Mon, 5 May 2025 11:54:21 +0530
Message-ID: <20250505062422.588450-3-kirankumark@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250505062422.588450-1-kirankumark@marvell.com>
References: <20241126044402.1209998-1-kirankumark@marvell.com>
 <20250505062422.588450-1-kirankumark@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: nmalZFYlq5QF-f_XCIntIXApashCyokr
X-Proofpoint-ORIG-GUID: nmalZFYlq5QF-f_XCIntIXApashCyokr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDA1OCBTYWx0ZWRfX6suuhS8FcY3V
 44jLPXTkjTdE2gM1Ov8AxAHTpfx3lRUbC6/7AXpDZHQ9jvc8xHkzaopd9Fgp0bc5kW4DWX1jaUP
 OIH5kMn8S1XQuPhyZAueS1o0PmDEJHCLLIKizfyajwrGcrengKsRv0uj+4aLzLhWQsr+gs1kSuK
 1Bt+kqoX/m4Z9AuDhQ2xXRBG+iui495g7U5nT8n7V2OcVNbOxDq82qFSbzV5JF6TQDoSnONp11X
 XVyOgr/p1nyZxh8R9JtI8N4VKnk/5w9OlPDW2DSz1OEkYDvNyi8K4MhgPSR+9gjX91OqFYEByCJ
 BkChrk+Iz9LIvmznEofzeEZJQa628gB7ihYuDWDSk17b867+0dBBGCHGN43JlfnYdp/nhidtbGh
 nq9vxh/FzH9HW4VTxzbkvrv4900o6MOOSC7Dgqyh6cvSA3XWslMrnkcW04YPwvDLdQ37+4UO
X-Authority-Analysis: v=2.4 cv=U+mSDfru c=1 sm=1 tr=0 ts=681859ab cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=MqI-DGuoOvG9Fh05Se8A:9
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

The graph autotest second run test is failing due to the
node name is already present in the node list. Adding changes
to free nodes at the time of test cleanup.

Fixes: 6b89650418fe ("test/graph: add functional tests")

Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>
Acked-by: Jerin Jacob <jerinj@marvell.com>
---
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

