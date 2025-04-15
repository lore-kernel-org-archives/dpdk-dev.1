Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE38C369B4
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 12:11:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74FB540689;
	Tue, 15 Apr 2025 14:11:58 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1BC764067B
 for <dev@dpdk.org>; Tue, 15 Apr 2025 14:11:56 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FBKPpE019908;
 Tue, 15 Apr 2025 05:11:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=s
 Wj4zTiLeuT/lvCsAZUtmfFW1VpZZcgCksT+hfa7dwQ=; b=kF2DWsvlKPFsj+8u+
 dEu4MyDIZSNkFZYeHn+QcsYr6WHAo0p8oguwX/jTOGL9+/WzGTcs2hlOKmhS6Ndo
 8A8Gjwn50YtyysKjNN1oGCHZOOtvRDLnOp8uG9qz/18kwW0C1/8vr14CI7oTzKFT
 8sHN9hLtBdNoQ9INkKpb83cS+UFwKdoLcHv4TQW76/2UsivpCEmBhBuEGhEkP2sF
 vEu2KMN5VkaoBfh9MeddhastzLiy8kPHU7DMg1jfMhYfJeQFuUIsC+q7xAnv33QM
 RtlLIUYwNWP8webe1ExFN55e/maXg0yi1936NzpUbnmk7W/qdJYB7kGUz7OdfYze
 PUv/w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 461pg703jw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Apr 2025 05:11:56 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 15 Apr 2025 05:11:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 15 Apr 2025 05:11:54 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id 9F81967399;
 Tue, 15 Apr 2025 05:11:51 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v1 06/12] app/graph: add IP4 lookup mode command
Date: Tue, 15 Apr 2025 17:40:46 +0530
Message-ID: <20250415121052.1497155-7-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250415121052.1497155-1-adwivedi@marvell.com>
References: <20250415121052.1497155-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: AG_CaXYfsupYUWHm-uihwittQapEhiVU
X-Proofpoint-ORIG-GUID: AG_CaXYfsupYUWHm-uihwittQapEhiVU
X-Authority-Analysis: v=2.4 cv=Gp1C+l1C c=1 sm=1 tr=0 ts=67fe4d0c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=NvoTrfNON8ucx747TIAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
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

Adds a command to setup lookup mode for IP4 packets. By default the
LPM mode is used.
FIB can be given as a lookup mode by specifying the mode in CLI file.
When FIB is given as lookup mode, the next node of packet classification
node is updated to use IP4 lookup fib node.

Signed-off-by: Ankur Dwivedi <adwivedi@marvell.com>
---
 app/graph/commands.list    |  1 +
 app/graph/ip4_route.c      | 34 ++++++++++++++++++++++++++++++----
 app/graph/l3fwd.c          | 12 ++++++++++++
 app/graph/module_api.h     |  7 +++++++
 doc/guides/tools/graph.rst | 12 ++++++++----
 5 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/app/graph/commands.list b/app/graph/commands.list
index c027f73b0e..7a1bf0c708 100644
--- a/app/graph/commands.list
+++ b/app/graph/commands.list
@@ -23,6 +23,7 @@ ethdev_rx map port <STRING>dev queue <UINT32>qid core <UINT32>core_id # Port-Que
 help ethdev_rx                                           # Print help on ethdev_rx commands
 
 ipv4_lookup route add ipv4 <IPv4>ip netmask <IPv4>mask via <IPv4>via_ip # Add IPv4 route to LPM table
+ipv4_lookup mode <STRING>lkup_mode                       # Set IPv4 lookup mode
 help ipv4_lookup                                         # Print help on ipv4_lookup commands
 
 ipv6_lookup route add ipv6 <IPv6>ip netmask <IPv6>mask via <IPv6>via_ip # Add IPv6 route to LPM6 table
diff --git a/app/graph/ip4_route.c b/app/graph/ip4_route.c
index 48ea912597..9af2c26078 100644
--- a/app/graph/ip4_route.c
+++ b/app/graph/ip4_route.c
@@ -18,8 +18,13 @@
 static const char
 cmd_ipv4_lookup_help[] = "ipv4_lookup route add ipv4 <ip> netmask <mask> via <ip>";
 
+static const char
+cmd_ipv4_lookup_mode_help[] = "ipv4_lookup mode <lpm|fib>";
+
 struct ip4_route route4 = TAILQ_HEAD_INITIALIZER(route4);
 
+enum ip4_lookup_mode ip4_lookup_m = IP4_LOOKUP_LPM;
+
 void
 route_ip4_list_clean(void)
 {
@@ -62,6 +67,7 @@ route4_rewirte_table_update(struct route_ipv4_config *ipv4route)
 {
 	uint8_t depth;
 	int portid;
+	int rc;
 
 	portid = ethdev_portid_by_ip4(ipv4route->via, ipv4route->netmask);
 	if (portid < 0) {
@@ -71,8 +77,14 @@ route4_rewirte_table_update(struct route_ipv4_config *ipv4route)
 
 	depth = convert_netmask_to_depth(ipv4route->netmask);
 
-	return rte_node_ip4_route_add(ipv4route->ip, depth, portid,
-			RTE_NODE_IP4_LOOKUP_NEXT_REWRITE);
+	if (ip4_lookup_m == IP4_LOOKUP_FIB)
+		rc = rte_node_ip4_fib_route_add(ipv4route->ip, depth, portid,
+				RTE_NODE_IP4_LOOKUP_NEXT_REWRITE);
+	else
+		rc = rte_node_ip4_route_add(ipv4route->ip, depth, portid,
+				RTE_NODE_IP4_LOOKUP_NEXT_REWRITE);
+
+	return rc;
 }
 
 static int
@@ -134,9 +146,9 @@ cmd_help_ipv4_lookup_parsed(__rte_unused void *parsed_result, __rte_unused struc
 
 	len = strlen(conn->msg_out);
 	conn->msg_out += len;
-	snprintf(conn->msg_out, conn->msg_out_len_max, "\n%s\n%s\n",
+	snprintf(conn->msg_out, conn->msg_out_len_max, "\n%s\n%s\n%s\n",
 		 "--------------------------- ipv4_lookup command help ---------------------------",
-		 cmd_ipv4_lookup_help);
+		 cmd_ipv4_lookup_help, cmd_ipv4_lookup_mode_help);
 
 	len = strlen(conn->msg_out);
 	conn->msg_out_len_max -= len;
@@ -158,3 +170,17 @@ cmd_ipv4_lookup_route_add_ipv4_parsed(void *parsed_result, __rte_unused struct c
 	if (rc < 0)
 		printf(MSG_CMD_FAIL, res->ipv4_lookup);
 }
+
+void
+cmd_ipv4_lookup_mode_parsed(void *parsed_result, __rte_unused struct cmdline *cl,
+			    void *data __rte_unused)
+{
+	struct cmd_ipv4_lookup_mode_result *res = parsed_result;
+
+	if (!strcmp(res->lkup_mode, "lpm"))
+		ip4_lookup_m = IP4_LOOKUP_LPM;
+	else if (!strcmp(res->lkup_mode, "fib"))
+		ip4_lookup_m = IP4_LOOKUP_FIB;
+	else
+		printf(MSG_CMD_FAIL, res->ipv4_lookup);
+}
diff --git a/app/graph/l3fwd.c b/app/graph/l3fwd.c
index a2648df27d..cb64e66026 100644
--- a/app/graph/l3fwd.c
+++ b/app/graph/l3fwd.c
@@ -53,6 +53,18 @@ l3fwd_pattern_configure(void)
 	graph_conf.num_pkt_to_capture = pcap_pkts_count;
 	graph_conf.pcap_filename = strdup(pcap_file);
 
+	if (ip4_lookup_m == IP4_LOOKUP_FIB) {
+		const char *fib_n = "ip4_lookup_fib";
+		const char *lpm_n = "ip4_lookup";
+		rte_node_t pkt_cls;
+#define IP4_LKUP_ACTIVE_EDGE 1
+#define IP4_LKUP_INACTIVE_EDGE 3
+
+		pkt_cls = rte_node_from_name("pkt_cls");
+		rte_node_edge_update(pkt_cls, IP4_LKUP_ACTIVE_EDGE, &fib_n, 1);
+		rte_node_edge_update(pkt_cls, IP4_LKUP_INACTIVE_EDGE, &lpm_n, 1);
+	}
+
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
 		rte_graph_t graph_id;
 		rte_edge_t i;
diff --git a/app/graph/module_api.h b/app/graph/module_api.h
index b872872dc1..b8188d30d5 100644
--- a/app/graph/module_api.h
+++ b/app/graph/module_api.h
@@ -27,6 +27,13 @@
 extern volatile bool force_quit;
 extern struct conn *conn;
 
+enum ip4_lookup_mode {
+	IP4_LOOKUP_LPM,
+	IP4_LOOKUP_FIB
+};
+
+extern enum ip4_lookup_mode ip4_lookup_m;
+
 bool app_graph_stats_enabled(void);
 bool app_graph_exit(void);
 
diff --git a/doc/guides/tools/graph.rst b/doc/guides/tools/graph.rst
index d8c147d73e..2caf441591 100644
--- a/doc/guides/tools/graph.rst
+++ b/doc/guides/tools/graph.rst
@@ -235,10 +235,14 @@ file to express the requested use case configuration.
    |                                      | | message.                        |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
    | | ipv4_lookup route add ipv4 <ip>    | | Command to add a route into     | :ref:`3 <scopes>` |    Yes   |
-   | |  netmask <mask> via <ip>           | | ``ipv4_lookup`` LPM table. It is|                   |          |
-   |                                      | | needed if user wishes to route  |                   |          |
-   |                                      | | the packets based on LPM lookup |                   |          |
-   |                                      | | table.                          |                   |          |
+   | |  netmask <mask> via <ip>           | | ``ipv4_lookup`` LPM table or    |                   |          |
+   |                                      | | FIB. It is needed if user wishes|                   |          |
+   |                                      | | to route the packets based on   |                   |          |
+   |                                      | | LPM lookup table or FIB.        |                   |          |
+   +--------------------------------------+-----------------------------------+-------------------+----------+
+   | | ipv4_lookup mode <lpm|fib>         | | Command to set ipv4 lookup mode | :ref:`1 <scopes>` |    Yes   |
+   |                                      | | to either LPM or FIB. By default|                   |          |
+   |                                      | | the lookup mode is LPM.         |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
    | help ipv4_lookup                     | | Command to dump ``ipv4_lookup`` | :ref:`2 <scopes>` |    Yes   |
    |                                      | | help message.                   |                   |          |
-- 
2.25.1

