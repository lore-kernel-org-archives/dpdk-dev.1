Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06890C369BD
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Apr 2025 07:11:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA30B40657;
	Sat, 19 Apr 2025 09:11:29 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E7AC64060F
 for <dev@dpdk.org>; Sat, 19 Apr 2025 09:11:27 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53J6PHh3012571;
 Sat, 19 Apr 2025 00:11:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=x
 KodXLLHQ607+2jv0JNR4tsrBKbv5HJxaLXvKqlOfvA=; b=JRQBYsHgAIC6CUW/5
 40liSY9a7O3Cs7+Ghw9ciN1s5elmjvIdAC0PFgo/FToADSRlEONiQ/YWlvbxAdep
 ngBSYYwvKy9GneuPi4uVuen8cRud/3KVjiBKZOepTMcmOdVPQJR+3I/EzsruIrxT
 j83FPQlcuFb9Rukz4wiAoQnEs30xx2YFeZARy+rwMw926u7Ov/OWH+3MWWb/gE8W
 ZUHxPpOF/BeIZUmB2fRga1vuujH4uH8eSoHhO6TzqQTWRNo2BnB3f7s/CGOEiUda
 O9ymlAYTVh+bEk0nu8pvWSVHXDgXKExYJLlSqR/CuLQaDObEDZg/qNBcxrLgjiw4
 oulrw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 463gjn9yer-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 19 Apr 2025 00:11:23 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 19 Apr 2025 00:11:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 19 Apr 2025 00:11:22 -0700
Received: from cavium-PowerEdge-R640.. (unknown [10.28.36.207])
 by maili.marvell.com (Postfix) with ESMTP id 3750A3F71C0;
 Sat, 19 Apr 2025 00:11:17 -0700 (PDT)
From: Nitin Saxena <nsaxena@marvell.com>
To: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan
 <yanzhirun_163@163.com>, Robin Jarry <rjarry@redhat.com>,
 Christophe Fontaine <cfontain@redhat.com>
CC: <dev@dpdk.org>, Nitin Saxena <nsaxena16@gmail.com>
Subject: [PATCH v7 4/5] app/graph: add custom feature nodes for ip4 output arc
Date: Sat, 19 Apr 2025 12:40:44 +0530
Message-ID: <20250419071047.1334983-5-nsaxena@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250419071047.1334983-1-nsaxena@marvell.com>
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250419071047.1334983-1-nsaxena@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=bKQWIO+Z c=1 sm=1 tr=0 ts=68034c9b cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=fI6_JadbsYlu-91u4DgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: tuwGVgigYABbGitoUM5ExQKRcXt21jNV
X-Proofpoint-ORIG-GUID: tuwGVgigYABbGitoUM5ExQKRcXt21jNV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_02,2025-04-17_01,2024-11-22_01
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

- Added cmdline argument "--enable-graph-feature-arc" to call
  rte_graph_feature_arc_init() before rte_graph_create() which creates
  in-built arcs and feature nodes
- Added custom feature nodes in app/graph which are added to ip4 output
  arc.
- Custom features can be enabled/disabled at runtime on any ethdev via
  CLI.

graph> help feature
graph> feature enable <arc name> <feature name> <port-id>
graph> feature disable <arc name> <feature name> <port-id>
graph> graph stats show

Signed-off-by: Nitin Saxena <nsaxena@marvell.com>
---
 app/graph/commands.list     |   6 ++
 app/graph/feature.c         | 141 +++++++++++++++++++++++++++++
 app/graph/feature.h         |  13 +++
 app/graph/graph.c           |   4 +
 app/graph/ip4_output_hook.c | 174 ++++++++++++++++++++++++++++++++++++
 app/graph/main.c            |  15 +++-
 app/graph/meson.build       |   2 +
 app/graph/module_api.h      |   2 +
 8 files changed, 356 insertions(+), 1 deletion(-)
 create mode 100644 app/graph/feature.c
 create mode 100644 app/graph/feature.h
 create mode 100644 app/graph/ip4_output_hook.c

diff --git a/app/graph/commands.list b/app/graph/commands.list
index c027f73b0e..49d81f50ae 100644
--- a/app/graph/commands.list
+++ b/app/graph/commands.list
@@ -31,3 +31,9 @@ help ipv6_lookup                                         # Print help on ipv6_lo
 neigh add ipv4 <IPv4>ip <STRING>mac                      # Add static neighbour for IPv4
 neigh add ipv6 <IPv6>ip <STRING>mac                      # Add static neighbour for IPv6
 help neigh                                               # Print help on neigh commands
+
+feature arcs                                             # show all feature arcs
+feature <STRING>name show                                # Show feature arc details
+feature enable <STRING>arc_name <STRING>feature_name <UINT16>interface   # Enable feature on interface
+feature disable <STRING>arc_name <STRING>feature_name <UINT16>interface  # Disable feature on interface
+help feature                                             # Print help on feature command
diff --git a/app/graph/feature.c b/app/graph/feature.c
new file mode 100644
index 0000000000..2cf21b11ce
--- /dev/null
+++ b/app/graph/feature.c
@@ -0,0 +1,141 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell International Ltd.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <cmdline_parse.h>
+#include <cmdline_parse_num.h>
+#include <cmdline_parse_string.h>
+#include <cmdline_socket.h>
+#include <rte_ethdev.h>
+
+#include "module_api.h"
+
+static const char
+cmd_feature_arcs_help[] = "feature arcs    # Display all feature arcs";
+
+static const char
+cmd_feature_show_help[] = "feature <arc_name> show   # Display features within an arc";
+
+static const char
+cmd_feature_enable_help[] = "feature enable <arc name> <feature name> <port-id>";
+
+static const char
+cmd_feature_disable_help[] = "feature disable <arc name> <feature name> <port-id>";
+
+static void
+feature_show(const char *arc_name)
+{
+	rte_graph_feature_arc_t _arc;
+	uint32_t length, count, i;
+
+	length = strlen(conn->msg_out);
+	conn->msg_out += length;
+
+	if (rte_graph_feature_arc_lookup_by_name(arc_name, &_arc) < 0)
+		return;
+
+	count = rte_graph_feature_arc_num_features(_arc);
+
+	if (count) {
+		snprintf(conn->msg_out, conn->msg_out_len_max, "\n%s%s%s\n",
+			 "----------------------------- feature arc: ",
+			 rte_graph_feature_arc_get(_arc)->feature_arc_name,
+			 " -----------------------------");
+		for (i = 0; i < count; i++)
+			snprintf(conn->msg_out + strlen(conn->msg_out),
+				 conn->msg_out_len_max, "%s\n",
+				 rte_graph_feature_arc_feature_to_name(_arc, i));
+	}
+	length = strlen(conn->msg_out);
+	conn->msg_out_len_max -= length;
+}
+
+static void
+feature_arcs_show(void)
+{
+	uint32_t length, count, i;
+	char **names;
+
+	length = strlen(conn->msg_out);
+	conn->msg_out += length;
+
+	count = rte_graph_feature_arc_names_get(NULL);
+
+	if (count) {
+		names = malloc(count);
+		if (!names) {
+			snprintf(conn->msg_out, conn->msg_out_len_max, "Failed to allocate memory\n");
+			return;
+		}
+		count = rte_graph_feature_arc_names_get(names);
+		snprintf(conn->msg_out, conn->msg_out_len_max, "\n%s\n",
+			 "----------------------------- feature arcs -----------------------------");
+		for (i = 0; i < count; i++)
+			feature_show(names[i]);
+		free(names);
+	}
+	length = strlen(conn->msg_out);
+	conn->msg_out_len_max -= length;
+}
+
+void
+cmd_feature_parsed(void *parsed_result, __rte_unused struct cmdline *cl,
+		   __rte_unused void *data)
+{
+	struct cmd_feature_result *res = parsed_result;
+
+	feature_show(res->name);
+}
+
+
+void
+cmd_feature_arcs_parsed(__rte_unused void *parsed_result, __rte_unused struct cmdline *cl,
+			__rte_unused void *data)
+{
+		feature_arcs_show();
+}
+
+void
+cmd_feature_enable_parsed(void *parsed_result, __rte_unused struct cmdline *cl,
+			  __rte_unused void *data)
+{
+	struct cmd_feature_enable_result *res = parsed_result;
+	rte_graph_feature_arc_t arc;
+
+	if (!rte_graph_feature_arc_lookup_by_name(res->arc_name, &arc))
+		rte_graph_feature_enable(arc, res->interface, res->feature_name,
+					 res->interface, NULL);
+}
+
+void
+cmd_feature_disable_parsed(void *parsed_result, __rte_unused struct cmdline *cl,
+			   __rte_unused void *data)
+{
+	struct cmd_feature_disable_result *res = parsed_result;
+	rte_graph_feature_arc_t arc;
+
+	if (!rte_graph_feature_arc_lookup_by_name(res->arc_name, &arc))
+		rte_graph_feature_disable(arc, res->interface, res->feature_name, NULL);
+
+}
+
+void
+cmd_help_feature_parsed(__rte_unused void *parsed_result, __rte_unused struct cmdline *cl,
+			__rte_unused void *data)
+{
+	size_t len;
+
+	len = strlen(conn->msg_out);
+	conn->msg_out += len;
+	snprintf(conn->msg_out, conn->msg_out_len_max, "\n%s\n%s\n%s\n%s\n%s\n",
+		 "----------------------------- feature command help -----------------------------",
+		 cmd_feature_arcs_help, cmd_feature_show_help, cmd_feature_enable_help,
+		 cmd_feature_disable_help);
+
+	len = strlen(conn->msg_out);
+	conn->msg_out_len_max -= len;
+}
diff --git a/app/graph/feature.h b/app/graph/feature.h
new file mode 100644
index 0000000000..76393dabc6
--- /dev/null
+++ b/app/graph/feature.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell International Ltd.
+ */
+
+#ifndef APP_GRAPH_FEATURE_H
+#define APP_GRAPH_FEATURE_H
+
+#include <cmdline_parse.h>
+#include <rte_graph_feature_arc_worker.h>
+
+int feature_enable(const char *arc_name, const char *feature_name, uint16_t portid);
+int feature_disable(const char *arc_name, const char *feature_name, uint16_t portid);
+#endif
diff --git a/app/graph/graph.c b/app/graph/graph.c
index 3af031cbaf..77f1e7cd71 100644
--- a/app/graph/graph.c
+++ b/app/graph/graph.c
@@ -12,6 +12,7 @@
 #include <cmdline_socket.h>
 #include <rte_ethdev.h>
 #include <rte_graph_worker.h>
+#include <rte_graph_feature_arc_worker.h>
 #include <rte_log.h>

 #include "graph_priv.h"
@@ -265,6 +266,9 @@ cmd_graph_start_parsed(__rte_unused void *parsed_result, __rte_unused struct cmd
 	uint32_t nb_graphs = 0, nb_conf, i;
 	int rc = -EINVAL;

+	if (app_graph_feature_arc_enabled())
+		rte_graph_feature_arc_init(0);
+
 	conf = graph_rxtx_node_config_get(&nb_conf, &nb_graphs);
 	for (i = 0; i < MAX_GRAPH_USECASES; i++) {
 		if (!strcmp(graph_config.usecases[i].name, "l3fwd")) {
diff --git a/app/graph/ip4_output_hook.c b/app/graph/ip4_output_hook.c
new file mode 100644
index 0000000000..799f82e2e0
--- /dev/null
+++ b/app/graph/ip4_output_hook.c
@@ -0,0 +1,174 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell International Ltd.
+ */
+
+#include <rte_graph.h>
+#include <rte_graph_worker.h>
+#include <rte_graph_feature_arc_worker.h>
+
+#include "rte_node_ip4_api.h"
+
+#define IP4_OUTPUT_HOOK_FEATURE1_NAME "app_ip4_out_feat1"
+#define IP4_OUTPUT_HOOK_FEATURE2_NAME "app_ip4_out_feat2"
+
+struct output_hook_node_ctx {
+	rte_graph_feature_arc_t out_arc;
+	uint16_t last_index;
+};
+
+#define OUTPUT_HOOK_FEATURE_ARC(ctx) \
+	(((struct output_hook_node_ctx *)ctx)->out_arc)
+
+#define OUTPUT_HOOK_LAST_NEXT_INDEX(ctx) \
+	(((struct output_hook_node_ctx *)ctx)->last_index)
+
+static int
+__app_graph_ip4_output_hook_node_init(const struct rte_graph *graph, struct rte_node *node)
+{
+	rte_graph_feature_arc_t feature;
+
+	RTE_SET_USED(graph);
+
+	rte_graph_feature_arc_lookup_by_name(RTE_IP4_OUTPUT_FEATURE_ARC_NAME, &feature);
+
+	OUTPUT_HOOK_FEATURE_ARC(node->ctx) = feature;
+	/* pkt_drop */
+	OUTPUT_HOOK_LAST_NEXT_INDEX(node->ctx) = 0;
+
+	return 0;
+}
+
+static __rte_always_inline uint16_t
+__app_graph_ip4_output_hook_node_process(struct rte_graph *graph, struct rte_node *node,
+					 void **objs, uint16_t nb_objs)
+{
+	struct rte_graph_feature_arc *arc =
+		rte_graph_feature_arc_get(OUTPUT_HOOK_FEATURE_ARC(node->ctx));
+	struct rte_graph_feature_arc_mbuf_dynfields *mbfields = NULL;
+	void **to_next, **from;
+	uint16_t last_spec = 0;
+	rte_edge_t next_index;
+	struct rte_mbuf *mbuf;
+	uint16_t held = 0;
+	uint16_t next;
+	int i;
+
+	/* Speculative next */
+	next_index = OUTPUT_HOOK_LAST_NEXT_INDEX(node->ctx);
+
+	from = objs;
+	to_next = rte_node_next_stream_get(graph, node, next_index, nb_objs);
+	for (i = 0; i < nb_objs; i++) {
+
+		mbuf = (struct rte_mbuf *)objs[i];
+
+		/* Send mbuf to next enabled feature */
+		mbfields = rte_graph_feature_arc_mbuf_dynfields_get(mbuf, arc->mbuf_dyn_offset);
+		rte_graph_feature_data_next_feature_get(arc, &mbfields->feature_data, &next);
+
+		if (unlikely(next_index != next)) {
+			/* Copy things successfully speculated till now */
+			rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
+			from += last_spec;
+			to_next += last_spec;
+			held += last_spec;
+			last_spec = 0;
+
+			rte_node_enqueue_x1(graph, node, next, from[0]);
+			from += 1;
+		} else {
+			last_spec += 1;
+		}
+	}
+	/* !!! Home run !!! */
+	if (likely(last_spec == nb_objs)) {
+		rte_node_next_stream_move(graph, node, next_index);
+		return nb_objs;
+	}
+	held += last_spec;
+	rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
+	rte_node_next_stream_put(graph, node, next_index, held);
+	OUTPUT_HOOK_LAST_NEXT_INDEX(node->ctx) = next;
+
+	return nb_objs;
+}
+
+static int
+app_graph_ip4_output_hook_node1_init(const struct rte_graph *graph, struct rte_node *node)
+{
+	return __app_graph_ip4_output_hook_node_init(graph, node);
+}
+
+static __rte_always_inline uint16_t
+app_graph_ip4_output_hook_node1_process(struct rte_graph *graph, struct rte_node *node,
+					void **objs, uint16_t nb_objs)
+{
+	return __app_graph_ip4_output_hook_node_process(graph, node, objs, nb_objs);
+}
+
+static struct rte_node_register app_graph_ip4_output_hook_node1 = {
+	.process = app_graph_ip4_output_hook_node1_process,
+	.init = app_graph_ip4_output_hook_node1_init,
+	.name = "app_ip4_output_node1",
+	.nb_edges = 2,
+	.next_nodes = {
+		[0] = "pkt_drop",
+		[1] = "pkt_cls",
+	},
+};
+
+RTE_NODE_REGISTER(app_graph_ip4_output_hook_node1);
+
+static int
+app_graph_ip4_output_hook_node2_init(const struct rte_graph *graph, struct rte_node *node)
+{
+	return __app_graph_ip4_output_hook_node_init(graph, node);
+}
+
+static __rte_always_inline uint16_t
+app_graph_ip4_output_hook_node2_process(struct rte_graph *graph, struct rte_node *node,
+					void **objs, uint16_t nb_objs)
+{
+	return __app_graph_ip4_output_hook_node_process(graph, node, objs, nb_objs);
+}
+
+static struct rte_node_register app_graph_ip4_output_hook_node2 = {
+	.process = app_graph_ip4_output_hook_node2_process,
+	.init = app_graph_ip4_output_hook_node2_init,
+	.name = "app_ip4_output_node2",
+	.nb_edges = 1,
+	.next_nodes = {
+		[0] = "pkt_drop",
+	},
+};
+
+/* Override max_index for arc create */
+static uint16_t override_arc_index(void)
+{
+	return 64;
+}
+
+RTE_NODE_REGISTER(app_graph_ip4_output_hook_node2);
+
+/* if feature1 */
+struct rte_graph_feature_register app_graph_ip4_output_hook_feature1 = {
+	.feature_name = IP4_OUTPUT_HOOK_FEATURE1_NAME,
+	.arc_name = RTE_IP4_OUTPUT_FEATURE_ARC_NAME,
+	/* Same as regular function */
+	.feature_process_fn = app_graph_ip4_output_hook_node1_process,
+	.feature_node = &app_graph_ip4_output_hook_node1,
+	.runs_before =  IP4_OUTPUT_HOOK_FEATURE2_NAME,
+	.override_index_cb = override_arc_index,
+};
+
+/* if feature2 (same as f1) */
+struct rte_graph_feature_register app_graph_ip4_output_hook_feature2 = {
+	.feature_name = IP4_OUTPUT_HOOK_FEATURE2_NAME,
+	.arc_name = RTE_IP4_OUTPUT_FEATURE_ARC_NAME,
+	/* Same as regular function */
+	.feature_node = &app_graph_ip4_output_hook_node2,
+	.feature_process_fn = app_graph_ip4_output_hook_node2_process,
+};
+
+RTE_GRAPH_FEATURE_REGISTER(app_graph_ip4_output_hook_feature1);
+RTE_GRAPH_FEATURE_REGISTER(app_graph_ip4_output_hook_feature2);
diff --git a/app/graph/main.c b/app/graph/main.c
index 465376425c..56294f2693 100644
--- a/app/graph/main.c
+++ b/app/graph/main.c
@@ -28,6 +28,7 @@ static struct app_params {
 	struct conn_params conn;
 	char *script_name;
 	bool enable_graph_stats;
+	bool enable_feature_arc;
 } app = {
 	.conn = {
 		.welcome = "\nWelcome!\n\n",
@@ -42,6 +43,7 @@ static struct app_params {
 	},
 	.script_name = NULL,
 	.enable_graph_stats = false,
+	.enable_feature_arc = false,
 };

 static void
@@ -59,6 +61,7 @@ app_args_parse(int argc, char **argv)
 	struct option lgopts[] = {
 		{"help", 0, 0, 'H'},
 		{"enable-graph-stats", 0, 0, 'g'},
+		{"enable-graph-feature-arc", 0, 0, 'f'},
 	};
 	int h_present, p_present, s_present, n_args, i;
 	char *app_name = argv[0];
@@ -81,7 +84,7 @@ app_args_parse(int argc, char **argv)
 	p_present = 0;
 	s_present = 0;

-	while ((opt = getopt_long(argc, argv, "h:p:s:", lgopts, &option_index)) != EOF) {
+	while ((opt = getopt_long(argc, argv, "h:p:s:f", lgopts, &option_index)) != EOF) {
 		switch (opt) {
 		case 'h':
 			if (h_present) {
@@ -142,6 +145,10 @@ app_args_parse(int argc, char **argv)
 			       "--enable-graph-stats");
 			break;

+		case 'f':
+			app.enable_feature_arc = true;
+			break;
+
 		case 'H':
 		default:
 			printf(usage, app_name);
@@ -159,6 +166,12 @@ app_graph_stats_enabled(void)
 	return app.enable_graph_stats;
 }

+bool
+app_graph_feature_arc_enabled(void)
+{
+	return app.enable_feature_arc;
+}
+
 bool
 app_graph_exit(void)
 {
diff --git a/app/graph/meson.build b/app/graph/meson.build
index 344e4a418f..d7e8c431ea 100644
--- a/app/graph/meson.build
+++ b/app/graph/meson.build
@@ -24,6 +24,8 @@ sources = files(
         'mempool.c',
         'neigh.c',
         'utils.c',
+        'feature.c',
+        'ip4_output_hook.c'
 )

 cmd_h = custom_target('commands_hdr',
diff --git a/app/graph/module_api.h b/app/graph/module_api.h
index b872872dc1..25f88e28de 100644
--- a/app/graph/module_api.h
+++ b/app/graph/module_api.h
@@ -20,6 +20,7 @@
 #include "neigh.h"
 #include "route.h"
 #include "utils.h"
+#include "feature.h"

 /*
  * Externs
@@ -28,6 +29,7 @@ extern volatile bool force_quit;
 extern struct conn *conn;

 bool app_graph_stats_enabled(void);
+bool app_graph_feature_arc_enabled(void);
 bool app_graph_exit(void);

 #endif
--
2.43.0

