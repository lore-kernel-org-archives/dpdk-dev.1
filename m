Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDE9C369B4
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 12:12:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F240540693;
	Tue, 15 Apr 2025 14:12:09 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 52FE640693
 for <dev@dpdk.org>; Tue, 15 Apr 2025 14:12:08 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FBK7rd019498;
 Tue, 15 Apr 2025 05:12:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=j
 mPZN7l66ggyM/Wz5ggFGE599adSEls6RhM31O8LyeQ=; b=aqsYKIA1IMg1nMa0X
 8buOdNWSeyhlfoD4LoxS0uBeGAl1eKbnJxTv9pypidTIpcPSjnikr1XTa0+H6a6k
 qn72hnxl4r/E05GhkSrMPM53+lC5Cyz0IeDgLdgukoewrsJHVTjgn3BSU1wEpRSc
 yG+5eo6BFU6VC1M89G2hyTau4RKIq+ekt1j6f/W5v2rUG7zEZkg/XNX9tyuJr1DR
 PkkvcqWxwiw2fibt60zbK4/b28DWmsJnutAL3DnsQ1sEV50kUV+MVYkGhmoAz0dg
 zfz9lhsnVz6pQZWZYS1QPqiyqCMGN7O7dJrQ0mVyTpbNtYY1KC3ToAQU+4rjqt+L
 nqDkw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 461pg703mp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Apr 2025 05:12:07 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 15 Apr 2025 05:12:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 15 Apr 2025 05:12:06 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id 56CCD67398;
 Tue, 15 Apr 2025 05:12:03 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v1 08/12] node: add IP6 lookup FIB node
Date: Tue, 15 Apr 2025 17:40:48 +0530
Message-ID: <20250415121052.1497155-9-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250415121052.1497155-1-adwivedi@marvell.com>
References: <20250415121052.1497155-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: q3DfpySuddFQMWM3TYVEO_Y-ilU3fm9C
X-Proofpoint-ORIG-GUID: q3DfpySuddFQMWM3TYVEO_Y-ilU3fm9C
X-Authority-Analysis: v=2.4 cv=Gp1C+l1C c=1 sm=1 tr=0 ts=67fe4d17 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=qC2c8u15EQ-1HYTfKtsA:9
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

Adds a lookup FIB node for IP6.

Signed-off-by: Ankur Dwivedi <adwivedi@marvell.com>
---
 lib/node/ip6_lookup_fib.c | 124 ++++++++++++++++++++++++++++++++++++++
 lib/node/meson.build      |   1 +
 2 files changed, 125 insertions(+)
 create mode 100644 lib/node/ip6_lookup_fib.c

diff --git a/lib/node/ip6_lookup_fib.c b/lib/node/ip6_lookup_fib.c
new file mode 100644
index 0000000000..317cb53d7b
--- /dev/null
+++ b/lib/node/ip6_lookup_fib.c
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell.
+ */
+
+#include <rte_errno.h>
+#include <rte_ether.h>
+#include <rte_fib6.h>
+#include <rte_graph.h>
+#include <rte_graph_worker.h>
+#include <rte_ip.h>
+
+#include "rte_node_ip6_api.h"
+
+#include "node_private.h"
+
+/* IP6 Lookup FIB global data struct */
+struct ip6_lookup_fib_node_main {
+	struct rte_fib6 *fib6[RTE_MAX_NUMA_NODES];
+};
+
+struct ip6_lookup_fib_node_ctx {
+	/* Socket's FIB6 */
+	struct rte_fib6 *fib6;
+	/* Dynamic offset to mbuf priv1 */
+	int mbuf_priv1_off;
+};
+
+static struct ip6_lookup_fib_node_main ip6_lookup_fib_nm;
+
+#define FIB6_MAX_ROUTES (1 << 16)
+#define FIB6_NUM_TBL8   (1 << 15)
+#define FIB6_DEFAULT_NH 999
+
+#define IP6_LOOKUP_FIB_NODE(ctx) \
+	(((struct ip6_lookup_fib_node_ctx *)ctx)->fib6)
+
+#define IP6_LOOKUP_FIB_NODE_PRIV1_OFF(ctx) \
+	(((struct ip6_lookup_fib_node_ctx *)ctx)->mbuf_priv1_off)
+
+static int
+setup_fib6(unsigned int socket)
+{
+	struct ip6_lookup_fib_node_main *nm = &ip6_lookup_fib_nm;
+	struct rte_fib6_conf conf;
+	char s[RTE_FIB6_NAMESIZE];
+
+	/* One fib6 per socket */
+	if (nm->fib6[socket])
+		return 0;
+
+	conf.type = RTE_FIB6_TRIE;
+	conf.default_nh = FIB6_DEFAULT_NH;
+	conf.max_routes = FIB6_MAX_ROUTES;
+	conf.rib_ext_sz = 0;
+	conf.trie.nh_sz = RTE_FIB6_TRIE_4B;
+	conf.trie.num_tbl8 = FIB6_NUM_TBL8;
+	snprintf(s, sizeof(s), "IPV6_LOOKUP_FIB_%u", socket);
+	nm->fib6[socket] = rte_fib6_create(s, socket, &conf);
+	if (nm->fib6[socket] == NULL)
+		return -rte_errno;
+
+	return 0;
+}
+
+static int
+ip6_lookup_fib_node_init(const struct rte_graph *graph, struct rte_node *node)
+{
+	static uint8_t init_once;
+	unsigned int socket;
+	uint16_t lcore_id;
+	int rc;
+
+	RTE_BUILD_BUG_ON(sizeof(struct ip6_lookup_fib_node_ctx) > RTE_NODE_CTX_SZ);
+
+	if (!init_once) {
+		node_mbuf_priv1_dynfield_offset = rte_mbuf_dynfield_register(
+				&node_mbuf_priv1_dynfield_desc);
+		if (node_mbuf_priv1_dynfield_offset < 0)
+			return -rte_errno;
+
+		/* Setup FIB6 for all sockets */
+		RTE_LCORE_FOREACH(lcore_id)
+		{
+			socket = rte_lcore_to_socket_id(lcore_id);
+			rc = setup_fib6(socket);
+			if (rc) {
+				node_err("ip6_lookup_fib",
+					 "Failed to setup fib6 for sock %u, rc=%d", socket, rc);
+				return rc;
+			}
+		}
+		init_once = 1;
+	}
+
+	/* Update socket's FIB and mbuf dyn priv1 offset in node ctx */
+	IP6_LOOKUP_FIB_NODE(node->ctx) = ip6_lookup_fib_nm.fib6[graph->socket];
+	IP6_LOOKUP_FIB_NODE_PRIV1_OFF(node->ctx) = node_mbuf_priv1_dynfield_offset;
+
+	node_dbg("ip6_lookup_fib", "Initialized ip6_lookup_fib node");
+
+	return 0;
+}
+
+static struct rte_node_xstats ip6_lookup_fib_xstats = {
+	.nb_xstats = 1,
+	.xstat_desc = {
+		[0] = "ip6_lookup_fib_error",
+	},
+};
+
+static struct rte_node_register ip6_lookup_fib_node = {
+	.name = "ip6_lookup_fib",
+
+	.init = ip6_lookup_fib_node_init,
+	.xstats = &ip6_lookup_fib_xstats,
+
+	.nb_edges = RTE_NODE_IP6_LOOKUP_NEXT_PKT_DROP + 1,
+	.next_nodes = {
+		[RTE_NODE_IP6_LOOKUP_NEXT_REWRITE] = "ip6_rewrite",
+		[RTE_NODE_IP6_LOOKUP_NEXT_PKT_DROP] = "pkt_drop",
+	},
+};
+
+RTE_NODE_REGISTER(ip6_lookup_fib_node);
diff --git a/lib/node/meson.build b/lib/node/meson.build
index d2011c8f56..70216a1a69 100644
--- a/lib/node/meson.build
+++ b/lib/node/meson.build
@@ -17,6 +17,7 @@ sources = files(
         'ip4_reassembly.c',
         'ip4_rewrite.c',
         'ip6_lookup.c',
+        'ip6_lookup_fib.c',
         'ip6_rewrite.c',
         'kernel_rx.c',
         'kernel_tx.c',
-- 
2.25.1

