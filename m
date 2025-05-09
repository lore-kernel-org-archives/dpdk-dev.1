Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7950BC3ABC3
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 06:46:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A15B840674;
	Fri,  9 May 2025 08:46:21 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id F086E402F1
 for <dev@dpdk.org>; Fri,  9 May 2025 08:46:19 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548NIha9003978;
 Thu, 8 May 2025 23:46:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=h
 FAxVoEnRFB36upzobp2yMK7hcPeEL8zByJ+Rmk32tE=; b=XxE0gar4J/VXOoPHs
 WqOQB+7Ncsg1cD/4tx5LDEKcjMFSzAFyjCNY77VjcPQOxSBnUt5xsvJw2LXBSr5i
 1Of2EzUXV8/523gIeGV2y5a+KfJnMf3v6//VlXDTSO1XlZWY26hdShs+I4rdmQmp
 MxT14TbQdBHvLZUm5CYafUDSPkl3Qz59kppeAJr4ZJKddjPfbv5w9R2cebJaKNk8
 HuMDqe/d2mkRfWe0q2wt8WfAeWVs90eYVGw70/8foVdQLXbfeJGoKZDbFXfz3doR
 Pwg5ZnIRQFXLj2nG0LWQrtsbl7T+PdKV5Fgvc0Z/yPfARnW35l8zQ/qX3NbPYvU7
 9PvLg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46h65x0pc7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 23:46:19 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 8 May 2025 23:46:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 8 May 2025 23:46:18 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id 15CB13F7063;
 Thu,  8 May 2025 23:46:14 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>, <nsaxena@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v2 13/13] app/graph: add IP6 lookup mode command
Date: Fri, 9 May 2025 12:14:48 +0530
Message-ID: <20250509064448.724019-14-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250509064448.724019-1-adwivedi@marvell.com>
References: <20250415121052.1497155-1-adwivedi@marvell.com>
 <20250509064448.724019-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ZdsdNtVA c=1 sm=1 tr=0 ts=681da4bb cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=uxt5wEsAh8ZO_iMQKQYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA2MyBTYWx0ZWRfX6v92b9t/lNC7
 5iXYzmrGPjnUv2p0cDvVJ2+1jO/HI8VUfoWL0wsmyNf888PVLAeey2zI8oKd3yTrhjOAqd0gyyO
 jgqRbcveouo2uFV5BKVsBwWBQ7BueOBJIngqkik94FFNyqfHy+E3BiwHr9/FoTWaDvzi6jdfmLB
 iFfZWQA51NAJQEexZ5DtybfMY7hUeuRMZ1GTHL0yhQUuuRXeiTh/ANlFgx///Dyax4LqGf5GZA4
 JPk3VQEZmoB9aaDcQ8jHSffevjVaf/tujKePaop3t6BPkuDTYn+cqNdl4U4QxBvd4Pk9hx7uqzP
 oUv/f10VTr9CVZriGYKNApHQ1SV1VVSkCyRSRolwtxd0prWQLa5SluURcLn6WdpIgO0cWLDAbd5
 Vf1YBfkjYU0eF/218bUx4iTSxcuDOIDvIIjwBvYDK94BvnCH0bb8mcTO6SMARgO4sQVsf3OB
X-Proofpoint-GUID: 4bpS6QOZsThoME4dTngY_rZZ5cFRCz0T
X-Proofpoint-ORIG-GUID: 4bpS6QOZsThoME4dTngY_rZZ5cFRCz0T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_02,2025-05-08_04,2025-02-21_01
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

Adds a command to setup lookup mode for IP6 packets. By default LPM
mode is used.
FIB can be given as a lookup mode by specifying the mode in CLI file.
When FIB is given as lookup mode, the next node of packet classification
node is updated to use IP6 lookup fib node.

Signed-off-by: Ankur Dwivedi <adwivedi@marvell.com>
---
 app/graph/commands.list    |  1 +
 app/graph/ip6_route.c      | 33 +++++++++++++++++++++++++++++----
 app/graph/l3fwd.c          | 34 ++++++++++++++++++++++++++++++++++
 app/graph/module_api.h     |  6 ++++++
 doc/guides/tools/graph.rst | 12 ++++++++----
 5 files changed, 78 insertions(+), 8 deletions(-)

diff --git a/app/graph/commands.list b/app/graph/commands.list
index 7a1bf0c708..ffdab4fc97 100644
--- a/app/graph/commands.list
+++ b/app/graph/commands.list
@@ -27,6 +27,7 @@ ipv4_lookup mode <STRING>lkup_mode                       # Set IPv4 lookup mode
 help ipv4_lookup                                         # Print help on ipv4_lookup commands
 
 ipv6_lookup route add ipv6 <IPv6>ip netmask <IPv6>mask via <IPv6>via_ip # Add IPv6 route to LPM6 table
+ipv6_lookup mode <STRING>lkup_mode                       # Set IPv6 lookup mode
 help ipv6_lookup                                         # Print help on ipv6_lookup commands
 
 neigh add ipv4 <IPv4>ip <STRING>mac                      # Add static neighbour for IPv4
diff --git a/app/graph/ip6_route.c b/app/graph/ip6_route.c
index ec53239b06..14c0c83638 100644
--- a/app/graph/ip6_route.c
+++ b/app/graph/ip6_route.c
@@ -19,8 +19,13 @@
 static const char
 cmd_ipv6_lookup_help[] = "ipv6_lookup route add ipv6 <ip> netmask <mask> via <ip>";
 
+static const char
+cmd_ipv6_lookup_mode_help[] = "ipv6_lookup mode <lpm|fib>";
+
 struct ip6_route route6 = TAILQ_HEAD_INITIALIZER(route6);
 
+enum ip6_lookup_mode ip6_lookup_m = IP6_LOOKUP_LPM;
+
 void
 route_ip6_list_clean(void)
 {
@@ -49,6 +54,7 @@ route6_rewirte_table_update(struct route_ipv6_config *ipv6route)
 {
 	uint8_t depth;
 	int portid;
+	int rc;
 
 	portid = ethdev_portid_by_ip6(&ipv6route->gateway, &ipv6route->mask);
 	if (portid < 0) {
@@ -57,9 +63,14 @@ route6_rewirte_table_update(struct route_ipv6_config *ipv6route)
 	}
 	depth = rte_ipv6_mask_depth(&ipv6route->mask);
 
-	return rte_node_ip6_route_add(&ipv6route->ip, depth, portid,
-			RTE_NODE_IP6_LOOKUP_NEXT_REWRITE);
+	if (ip6_lookup_m == IP6_LOOKUP_FIB)
+		rc = rte_node_ip6_fib_route_add(&ipv6route->ip, depth, portid,
+				RTE_NODE_IP6_LOOKUP_NEXT_REWRITE);
+	else
+		rc = rte_node_ip6_route_add(&ipv6route->ip, depth, portid,
+				RTE_NODE_IP6_LOOKUP_NEXT_REWRITE);
 
+	return rc;
 }
 
 static int
@@ -120,9 +131,9 @@ cmd_help_ipv6_lookup_parsed(__rte_unused void *parsed_result, __rte_unused struc
 
 	len = strlen(conn->msg_out);
 	conn->msg_out += len;
-	snprintf(conn->msg_out, conn->msg_out_len_max, "\n%s\n%s\n",
+	snprintf(conn->msg_out, conn->msg_out_len_max, "\n%s\n%s\n%s\n",
 		 "--------------------------- ipv6_lookup command help ---------------------------",
-		 cmd_ipv6_lookup_help);
+		 cmd_ipv6_lookup_help, cmd_ipv6_lookup_mode_help);
 
 	len = strlen(conn->msg_out);
 	conn->msg_out_len_max -= len;
@@ -144,3 +155,17 @@ cmd_ipv6_lookup_route_add_ipv6_parsed(void *parsed_result, __rte_unused struct c
 	if (rc)
 		printf(MSG_CMD_FAIL, res->ipv6_lookup);
 }
+
+void
+cmd_ipv6_lookup_mode_parsed(void *parsed_result, __rte_unused struct cmdline *cl,
+			    void *data __rte_unused)
+{
+	struct cmd_ipv6_lookup_mode_result *res = parsed_result;
+
+	if (!strcmp(res->lkup_mode, "lpm"))
+		ip6_lookup_m = IP6_LOOKUP_LPM;
+	else if (!strcmp(res->lkup_mode, "fib"))
+		ip6_lookup_m = IP6_LOOKUP_FIB;
+	else
+		printf(MSG_CMD_FAIL, res->ipv6_lookup);
+}
diff --git a/app/graph/l3fwd.c b/app/graph/l3fwd.c
index 48dff9fa07..fe25e43da8 100644
--- a/app/graph/l3fwd.c
+++ b/app/graph/l3fwd.c
@@ -16,6 +16,7 @@
 #include <rte_lcore.h>
 #include <rte_node_eth_api.h>
 #include <rte_node_ip4_api.h>
+#include <rte_node_ip6_api.h>
 #include <rte_node_pkt_cls_api.h>
 
 #include "module_api.h"
@@ -37,6 +38,22 @@ setup_fib(int socket)
 	return rte_node_ip4_fib_create(socket, &conf);
 }
 
+static int
+setup_fib6(int socket)
+{
+	struct rte_fib6_conf conf;
+
+#define FIB6_MAX_ROUTES (UINT16_MAX)
+#define FIB6_NUM_TBL8   (UINT16_MAX / 2)
+	conf.type = RTE_FIB6_TRIE;
+	conf.max_routes = FIB6_MAX_ROUTES;
+	conf.rib_ext_sz = 0;
+	conf.trie.nh_sz = RTE_FIB6_TRIE_4B;
+	conf.trie.num_tbl8 = FIB6_NUM_TBL8;
+
+	return rte_node_ip6_fib_create(socket, &conf);
+}
+
 static int
 l3fwd_pattern_configure(void)
 {
@@ -82,6 +99,16 @@ l3fwd_pattern_configure(void)
 		rte_node_edge_update(pkt_cls, RTE_NODE_PKT_CLS_NEXT_IP4_LOOKUP_FIB, &lpm_n, 1);
 	}
 
+	if (ip6_lookup_m == IP6_LOOKUP_FIB) {
+		const char *fib6_n = "ip6_lookup_fib";
+		const char *lpm6_n = "ip6_lookup";
+		rte_node_t pkt_cls;
+
+		pkt_cls = rte_node_from_name("pkt_cls");
+		rte_node_edge_update(pkt_cls, RTE_NODE_PKT_CLS_NEXT_IP6_LOOKUP, &fib6_n, 1);
+		rte_node_edge_update(pkt_cls, RTE_NODE_PKT_CLS_NEXT_IP6_LOOKUP_FIB, &lpm6_n, 1);
+	}
+
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
 		rte_graph_t graph_id;
 		rte_edge_t i;
@@ -114,6 +141,13 @@ l3fwd_pattern_configure(void)
 						graph_conf.socket_id);
 		}
 
+		if (ip6_lookup_m == IP6_LOOKUP_FIB) {
+			rc = setup_fib6(graph_conf.socket_id);
+			if (rc < 0)
+				rte_exit(EXIT_FAILURE, "Unable to setup fib6 for socket %u\n",
+						graph_conf.socket_id);
+		}
+
 		graph_id = rte_graph_create(qconf->name, &graph_conf);
 		if (graph_id == RTE_GRAPH_ID_INVALID)
 			rte_exit(EXIT_FAILURE,
diff --git a/app/graph/module_api.h b/app/graph/module_api.h
index b8188d30d5..5e3a384cb0 100644
--- a/app/graph/module_api.h
+++ b/app/graph/module_api.h
@@ -32,7 +32,13 @@ enum ip4_lookup_mode {
 	IP4_LOOKUP_FIB
 };
 
+enum ip6_lookup_mode {
+	IP6_LOOKUP_LPM,
+	IP6_LOOKUP_FIB
+};
+
 extern enum ip4_lookup_mode ip4_lookup_m;
+extern enum ip6_lookup_mode ip6_lookup_m;
 
 bool app_graph_stats_enabled(void);
 bool app_graph_exit(void);
diff --git a/doc/guides/tools/graph.rst b/doc/guides/tools/graph.rst
index 2caf441591..dd525f6037 100644
--- a/doc/guides/tools/graph.rst
+++ b/doc/guides/tools/graph.rst
@@ -248,10 +248,14 @@ file to express the requested use case configuration.
    |                                      | | help message.                   |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
    | | ipv6_lookup route add ipv6 <ip>    | | Command to add a route into     | :ref:`3 <scopes>` |    Yes   |
-   | |  netmask <mask> via <ip>           | | ``ipv6_lookup`` LPM table. It is|                   |          |
-   |                                      | | needed if user wishes to route  |                   |          |
-   |                                      | | the packets based on LPM6 lookup|                   |          |
-   |                                      | | table.                          |                   |          |
+   | |  netmask <mask> via <ip>           | | ``ipv6_lookup`` LPM table or.   |                   |          |
+   |                                      | | FIB. It is needed if user wishes|                   |          |
+   |                                      | | to route the packets based on   |                   |          |
+   |                                      | | LPM6 lookup table or FIB.       |                   |          |
+   +--------------------------------------+-----------------------------------+-------------------+----------+
+   | | ipv6_lookup mode <lpm|fib>         | | Command to set ipv6 lookup mode | :ref:`1 <scopes>` |    Yes   |
+   |                                      | | to either LPM or FIB. By default|                   |          |
+   |                                      | | the lookup mode is LPM.         |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
    | help ipv6_lookup                     | | Command to dump ``ipv6_lookup`` | :ref:`2 <scopes>` |    Yes   |
    |                                      | | help message.                   |                   |          |
-- 
2.25.1

