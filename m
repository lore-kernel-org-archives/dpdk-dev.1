Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C63C369AB
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 12:12:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 301E840A6C;
	Tue, 15 Apr 2025 14:12:37 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 14AC6402A1
 for <dev@dpdk.org>; Tue, 15 Apr 2025 14:12:35 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F6iVVA029009;
 Tue, 15 Apr 2025 05:12:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
 v7PRG0ehnHLGs94G/yIWIoGTE4L8RoTdgL3oX0GOMs=; b=WH5FAnvBvOFSKyXZ8
 /Ef0eFOokQvCr88VjvDoVykH28C4uRkFM85J7lmYC5rctRCVo3sWeLCfiY775/iO
 6rMtbUp91TAfXuDIQAGaaSuj/cd5iuV7es2OQAiN98jayf1nsan0uveEVyPmhEMy
 /YiM8Uj9ARjTTid31drVKaCvyRjZZLKBHUHdyZB+YMETwJw38WUFH7J5swDSizRa
 idu6Tdb5dKVhbyodjZ6wF36nvuvghkf4lS0VgK0PyIQYLcscycIOjT1RpIgjYYOw
 tnwcmf1v1r1nFJuEjqCGlxXCTcWr4PmTowCMPbBKzQmCGh+nDGYXgqOxpcXYG4J+
 XhiBw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4608x9d9uq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Apr 2025 05:12:35 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 15 Apr 2025 05:12:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 15 Apr 2025 05:12:33 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id EC0A867398;
 Tue, 15 Apr 2025 05:12:30 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v1 12/12] app/graph: add IP6 lookup mode command
Date: Tue, 15 Apr 2025 17:40:52 +0530
Message-ID: <20250415121052.1497155-13-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250415121052.1497155-1-adwivedi@marvell.com>
References: <20250415121052.1497155-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=avOyCTZV c=1 sm=1 tr=0 ts=67fe4d33 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=NvoTrfNON8ucx747TIAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Ket9iNgThIueOYoxrODZNyPnnmRMxBrI
X-Proofpoint-ORIG-GUID: Ket9iNgThIueOYoxrODZNyPnnmRMxBrI
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

Adds a command to setup lookup mode for IP6 packets. By default LPM
mode is used.
FIB can be given as a lookup mode by specifying the mode in CLI file.
When FIB is given as lookup mode, the next node of packet classification
node is updated to use IP6 lookup fib node.

Signed-off-by: Ankur Dwivedi <adwivedi@marvell.com>
---
 app/graph/commands.list    |  1 +
 app/graph/ip6_route.c      | 33 +++++++++++++++++++++++++++++----
 app/graph/l3fwd.c          | 12 ++++++++++++
 app/graph/module_api.h     |  6 ++++++
 doc/guides/tools/graph.rst | 12 ++++++++----
 5 files changed, 56 insertions(+), 8 deletions(-)

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
index cb64e66026..3c9f8d2f8b 100644
--- a/app/graph/l3fwd.c
+++ b/app/graph/l3fwd.c
@@ -65,6 +65,18 @@ l3fwd_pattern_configure(void)
 		rte_node_edge_update(pkt_cls, IP4_LKUP_INACTIVE_EDGE, &lpm_n, 1);
 	}
 
+	if (ip6_lookup_m == IP6_LOOKUP_FIB) {
+		const char *fib6_n = "ip6_lookup_fib";
+		const char *lpm6_n = "ip6_lookup";
+		rte_node_t pkt_cls;
+#define IP6_LKUP_ACTIVE_EDGE 2
+#define IP6_LKUP_INACTIVE_EDGE 4
+
+		pkt_cls = rte_node_from_name("pkt_cls");
+		rte_node_edge_update(pkt_cls, IP6_LKUP_ACTIVE_EDGE, &fib6_n, 1);
+		rte_node_edge_update(pkt_cls, IP6_LKUP_INACTIVE_EDGE, &lpm6_n, 1);
+	}
+
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
 		rte_graph_t graph_id;
 		rte_edge_t i;
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

