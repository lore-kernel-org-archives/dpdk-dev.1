Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A64CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 21:38:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B6184065D;
	Tue, 19 May 2026 23:38:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 16FBF4065B
 for <dev@dpdk.org>; Tue, 19 May 2026 23:38:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779226716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4TRlefyuLKmMpDlQIpn+hr/rc284S910MPsP3CQOlk=;
 b=hg2Mf4Hkdw0ZkaNJCuqTi0IqtMtFok63M7kQGCpxArcFbrhIdPRbMktfBAMTXTK8UR3gBA
 EPexO6VZ38QriG97Ia/OM32tGc7ZkYmDTXvAMlPvCLuym1e5Oa/9aC8mDuAUg3aGzaehNv
 z6ZDh3UYYEkaEMsMBAap4t7XTYs+1bI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-iXXgixYBPL-NowCi-FAlrg-1; Tue,
 19 May 2026 17:38:33 -0400
X-MC-Unique: iXXgixYBPL-NowCi-FAlrg-1
X-Mimecast-MFC-AGG-ID: iXXgixYBPL-NowCi-FAlrg_1779226712
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E640195608D; Tue, 19 May 2026 21:38:32 +0000 (UTC)
Received: from ringo.redhat.com (unknown [10.44.48.86])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DFFAA1684; Tue, 19 May 2026 21:38:29 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org, Jerin Jacob <jerinj@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH dpdk v2 1/2] graph: add diamond topology performance test
Date: Tue, 19 May 2026 23:38:21 +0200
Message-ID: <20260519213822.735891-2-rjarry@redhat.com>
In-Reply-To: <20260519213822.735891-1-rjarry@redhat.com>
References: <20260519101232.541102-2-rjarry@redhat.com>
 <20260519213822.735891-1-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QJ0O5HNzHTNyA4QTSU_y-UyOaihi7w8Zx7lxg0oq1Bw_1779226712
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

Add a fan-out-then-converge test case to graph_perf_autotest. The
fan_out node sends 50% of objects to a converge node (edge 0) and
50% to a branch node (edge 1). The branch node forwards everything
to the same converge node.

Because converge is edge 0, a FIFO scheduler visits it before the
branch has run, causing two visits at 128 objs/call each. This
topology is used in a follow-up patch to demonstrate the benefit of
priority-based scheduling.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 app/test/test_graph_perf.c | 130 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 129 insertions(+), 1 deletion(-)

diff --git a/app/test/test_graph_perf.c b/app/test/test_graph_perf.c
index 983735c2d9c4..c509d364b826 100644
--- a/app/test/test_graph_perf.c
+++ b/app/test/test_graph_perf.c
@@ -263,7 +263,7 @@ graph_perf_teardown(void)
 }
 
 static inline rte_node_t
-graph_node_get(const char *pname, char *nname)
+graph_node_get(const char *pname, const char *nname)
 {
 	rte_node_t pnode_id = rte_node_from_name(pname);
 	char lookup_name[RTE_NODE_NAMESIZE];
@@ -1042,6 +1042,132 @@ graph_init_parallel_tree(void)
  *	snk_map[][2] = { {50, 50}, {50, 50}, {0, 0}, {0, 0} }
  */
 
+/* Graph Topology: fan-out-then-converge (diamond)
+ *
+ *   src --> fan_out --(50%)-------------------+-> converge --(100%)--> sink
+ *                   `-(50%)--> branch -(100%)-'
+ *
+ * The fan_out node enqueues to converge (edge 0) before branch (edge 1).
+ * With a FIFO scheduler, converge is visited first with only 50% of the
+ * objects, then branch runs and re-enqueues to converge for a second visit.
+ * With priority-based bitmap scheduling, branch (priority -1) runs before
+ * converge (priority 0), so converge accumulates all objects and is visited
+ * only once.
+ */
+static inline int
+graph_init_diamond(void)
+{
+	rte_node_t fan_out, branch, converge, src, snk;
+	struct test_graph_perf *graph_data;
+	struct rte_graph_param gconf = {0};
+	struct test_node_data *node_data;
+	const struct rte_memzone *mz;
+	const char *edge_names[2];
+	char *node_patterns[5];
+	rte_graph_t graph_id;
+
+	mz = rte_memzone_reserve(TEST_GRAPH_PERF_MZ,
+				 sizeof(struct test_graph_perf), 0, 0);
+	if (mz == NULL) {
+		printf("Failed to allocate graph common memory\n");
+		return -ENOMEM;
+	}
+	graph_data = mz->addr;
+	graph_data->nb_nodes = 5;
+	graph_data->node_data = calloc(5, sizeof(struct test_node_data));
+	if (graph_data->node_data == NULL)
+		goto memzone_free;
+
+	/* Clone all nodes */
+	src = graph_node_get(TEST_GRAPH_SRC_NAME, "0");
+	fan_out = graph_node_get(TEST_GRAPH_WRK_NAME, "fan");
+	/* converge must be edge 0 from fan_out so FIFO visits it first */
+	converge = graph_node_get(TEST_GRAPH_WRK_NAME, "conv");
+	branch = graph_node_get(TEST_GRAPH_WRK_NAME, "br");
+	snk = graph_node_get(TEST_GRAPH_SNK_NAME, "0");
+
+	if (src == RTE_NODE_ID_INVALID || fan_out == RTE_NODE_ID_INVALID ||
+	    converge == RTE_NODE_ID_INVALID || branch == RTE_NODE_ID_INVALID ||
+	    snk == RTE_NODE_ID_INVALID) {
+		printf("Failed to create nodes\n");
+		goto data_free;
+	}
+
+	/* src -> fan_out (100%) */
+	edge_names[0] = rte_node_id_to_name(fan_out);
+	rte_node_edge_update(src, 0, edge_names, 1);
+	node_data = &graph_data->node_data[0];
+	node_data->node_id = src;
+	node_data->is_sink = false;
+	node_data->next_nodes[0] = fan_out;
+	node_data->next_percentage[0] = 100;
+
+	/* fan_out: edge 0 -> converge (50%), edge 1 -> branch (50%) */
+	edge_names[0] = rte_node_id_to_name(converge);
+	edge_names[1] = rte_node_id_to_name(branch);
+	rte_node_edge_update(fan_out, 0, edge_names, 2);
+	node_data = &graph_data->node_data[1];
+	node_data->node_id = fan_out;
+	node_data->is_sink = false;
+	node_data->next_nodes[0] = converge;
+	node_data->next_percentage[0] = 50;
+	node_data->next_nodes[1] = branch;
+	node_data->next_percentage[1] = 50;
+
+	/* branch -> converge (100%) */
+	edge_names[0] = rte_node_id_to_name(converge);
+	rte_node_edge_update(branch, 0, edge_names, 1);
+	node_data = &graph_data->node_data[2];
+	node_data->node_id = branch;
+	node_data->is_sink = false;
+	node_data->next_nodes[0] = converge;
+	node_data->next_percentage[0] = 100;
+
+	/* converge -> sink (100%) */
+	edge_names[0] = rte_node_id_to_name(snk);
+	rte_node_edge_update(converge, 0, edge_names, 1);
+	node_data = &graph_data->node_data[3];
+	node_data->node_id = converge;
+	node_data->is_sink = false;
+	node_data->next_nodes[0] = snk;
+	node_data->next_percentage[0] = 100;
+
+	/* sink */
+	node_data = &graph_data->node_data[4];
+	node_data->node_id = snk;
+	node_data->is_sink = true;
+
+	node_patterns[0] = rte_node_id_to_name(src);
+	node_patterns[1] = rte_node_id_to_name(fan_out);
+	node_patterns[2] = rte_node_id_to_name(converge);
+	node_patterns[3] = rte_node_id_to_name(branch);
+	node_patterns[4] = rte_node_id_to_name(snk);
+
+	gconf.socket_id = SOCKET_ID_ANY;
+	gconf.nb_node_patterns = 5;
+	gconf.node_patterns = (const char **)(uintptr_t)node_patterns;
+
+	graph_id = rte_graph_create("graph_diamond", &gconf);
+	if (graph_id == RTE_GRAPH_ID_INVALID) {
+		printf("Graph creation failed with error = %d\n", rte_errno);
+		goto data_free;
+	}
+	graph_data->graph_id = graph_id;
+	return 0;
+
+data_free:
+	free(graph_data->node_data);
+memzone_free:
+	rte_memzone_free(mz);
+	return -ENOMEM;
+}
+
+static inline int
+graph_diamond_1src_1snk(void)
+{
+	return measure_perf();
+}
+
 static struct unit_test_suite graph_perf_testsuite = {
 	.suite_name = "Graph library performance test suite",
 	.setup = graph_perf_setup,
@@ -1061,6 +1187,8 @@ static struct unit_test_suite graph_perf_testsuite = {
 			     graph_reverse_tree_3s_4n_1src_1snk),
 		TEST_CASE_ST(graph_init_parallel_tree, graph_fini,
 			     graph_parallel_tree_5s_4n_4src_4snk),
+		TEST_CASE_ST(graph_init_diamond, graph_fini,
+			     graph_diamond_1src_1snk),
 		TEST_CASES_END(), /**< NULL terminate unit test array */
 	},
 };
-- 
2.54.0

