Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00C0C5B549
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 06:38:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DB6140655;
	Mon,  2 Jun 2025 08:38:14 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 8887940661
 for <dev@dpdk.org>; Mon,  2 Jun 2025 08:38:10 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 551Njbib006517;
 Sun, 1 Jun 2025 23:38:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=h
 FAxVoEnRFB36upzobp2yMK7hcPeEL8zByJ+Rmk32tE=; b=PvHUczPl867wHcBIC
 Rycrx1wOhE7XEVw07uhQdKKA2a2RmPpXlUFQYfaXqootCcl3b/nz3Pnk9Hc+BlvZ
 4bvGUWQKbz5/dBynDwvETBd0zrL1HroQFlJ1jqgBEB7Rctir6puJnFFoWzuotAPb
 p90Lvf/K4LFlDftSAjIofQXEToGgm7H1TBHiNaqnwbzeR+GjR8lZ2oreMGju+UL4
 XDbGt4Q3VaDBIZZdp9x98EqYJMLcz5q65Iiz7Vn3xOn3eyuHkfMEnOx2WuTHmJsg
 cZ/391GjWkikM+NsyQp+aJK9FOgMcX+1giZRrgsDlKJtdVD43FNtarW141smvhnw
 ZgNCg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 470ye00n8h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 01 Jun 2025 23:38:09 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 1 Jun 2025 23:38:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 1 Jun 2025 23:38:08 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id 53DD53F704B;
 Sun,  1 Jun 2025 23:38:05 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>, <nsaxena@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v3 13/14] app/graph: add IP6 lookup mode command
Date: Mon, 2 Jun 2025 12:06:38 +0530
Message-ID: <20250602063639.198550-14-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250602063639.198550-1-adwivedi@marvell.com>
References: <20250509064448.724019-1-adwivedi@marvell.com>
 <20250602063639.198550-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDA1NSBTYWx0ZWRfX4qDZvwIMbqqc
 J7gjfK5CWLfZhbPyFNMtkWS/no+yukaU0mv4a7JXi+MZqQTEcxXbILO4aAjZ//Fhh+LfuceY7PM
 RUqO3llayBF3QlkKU4hE2xKzZHmZW9WoGLTy/qGlNsFv7ANOv2rYmE9xi02MZwAa8YxB2NgFqRH
 QyjD94KEEQQl6qIiZFOZYr1wtfMihCPbMUJfmjBWc1Uah3gohVhn9KDGbliaBeYpki3b8oKZa8V
 TeARYjLLANjltWZQXtdV7eMuin1i9nAETo10fZuZZJQq47dTbad4FdGJFoYM2Fdf+gblM9H614g
 st8REOlTW7MnQLob70DMhs2173IX/d9h6wNljJiz5M5ZcBB3/9TBIyRYSmS6viqQ7T6X+G827bG
 KGU12ExtkPnEtsKL8Z4SilBtjG1OhecLtz4cptLU7+4SA2MO6opLtG3Fk5s91+4qv55WW90u
X-Authority-Analysis: v=2.4 cv=Iv8ecK/g c=1 sm=1 tr=0 ts=683d46d1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=uxt5wEsAh8ZO_iMQKQYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: YV-SfJK3aBGpWS3V_RKP6XSVmQhWaol2
X-Proofpoint-GUID: YV-SfJK3aBGpWS3V_RKP6XSVmQhWaol2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_02,2025-05-30_01,2025-03-28_01
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

