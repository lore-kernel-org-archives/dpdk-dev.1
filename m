Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F91C3ABBC
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 06:46:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E76B40430;
	Fri,  9 May 2025 08:45:54 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 48A0A402E7
 for <dev@dpdk.org>; Fri,  9 May 2025 08:45:53 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5492iIDW030900;
 Thu, 8 May 2025 23:45:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=c
 5s4YLCdtcINaujq3EZxw0hdavoh2JBLx+iLCQq1Qak=; b=G3YabzhKy2Ibldg2j
 Hj6iOYJjREzMqB+OKAbQGxP0JOtK2XRA0v2UOr2rU2QjGSshPII6A+h+aBw3pTXJ
 Jz8TZoP3viiRfZFyqWonpSJcpKnm6T9I+D6iOVJN1UK+1BEZn+l38rtEXZicBWJl
 qptPhdSR5cSKVCcEOSPmfJ4RyGQrfS3JhIGPAKYMZKEceavzIXgX7Zw1j6Ybsz/9
 lKDQFtLa0oQSzZzeIOHisJaTh6SZB6Gn08PKVwewTGMDRiEfrT9Q1KMeVB4Re8Eh
 HUXMHzqLHVR9NsG9N0cAVBk9PO5vm7/qF/PURCA99N5mBPs2ws5Mz+mxzqfzN5c1
 gtKSg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46h96c0cjj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 23:45:52 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 8 May 2025 23:45:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 8 May 2025 23:45:51 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id 9BD033F704F;
 Thu,  8 May 2025 23:45:48 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>, <nsaxena@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v2 09/13] node: add IP6 lookup FIB node
Date: Fri, 9 May 2025 12:14:44 +0530
Message-ID: <20250509064448.724019-10-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250509064448.724019-1-adwivedi@marvell.com>
References: <20250415121052.1497155-1-adwivedi@marvell.com>
 <20250509064448.724019-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA2MyBTYWx0ZWRfX9erZ5i7zpGCH
 cSLhsPWeXXKD+E7jTaKWtWTYb4V3YMr5DTcy/W8CIXtBQMu1CT5tcaC2bcl2tbqmt9EYAeyI22P
 ap2cf1Nt4w/PxGjjuuP1+mpJQ9NAjy9U1WA8YBxSBBOb2C6QCyQR3wwdtIb/F6suUZoPvf/ol/G
 h+eeE15KikWVk+UzuNam538LhKkD52Rj7TFf+toQjNZ4+7MfaU7KibbP/fvD3ZX9cndjgQ2iF6z
 3zt0VMAko8OMUWfetNLFbITnA5Xr3Dqgxb/hKWcJR/j69/ePghXKbielVyPs3UZXf7BDYGkspXL
 qWzFFvi1H37cuxxxV4xKG1jPJgJfjCO2tVPFQF6hk6obX1WcW/XTJ780uUFiRktczPkjHXI/y2S
 n7fZoSJKffzDqINgxwFUxFlAU14O0JeqGIph0U1Fmbx+A/qAsEo5PuIGWSTBxulrTWzkPS9M
X-Proofpoint-GUID: wmkROy34pNR2HcxSEN_kwCD1dSO3rVvm
X-Proofpoint-ORIG-GUID: wmkROy34pNR2HcxSEN_kwCD1dSO3rVvm
X-Authority-Analysis: v=2.4 cv=dpXbC0g4 c=1 sm=1 tr=0 ts=681da4a0 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=MTiQbDV8bN19jQCZShcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
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

Adds a lookup FIB node for IP6.
Adds a public function to do fib configuration from application.

Signed-off-by: Ankur Dwivedi <adwivedi@marvell.com>
---
 lib/node/ip6_lookup_fib.c   | 139 ++++++++++++++++++++++++++++++++++++
 lib/node/meson.build        |   1 +
 lib/node/rte_node_ip6_api.h |  15 ++++
 3 files changed, 155 insertions(+)
 create mode 100644 lib/node/ip6_lookup_fib.c

diff --git a/lib/node/ip6_lookup_fib.c b/lib/node/ip6_lookup_fib.c
new file mode 100644
index 0000000000..a4f9f53644
--- /dev/null
+++ b/lib/node/ip6_lookup_fib.c
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell.
+ */
+
+#include <eal_export.h>
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
+#define FIB6_DEFAULT_MAX_ROUTES (UINT16_MAX)
+#define FIB6_DEFAULT_NUM_TBL8   (UINT16_MAX / 2)
+#define FIB6_DEFAULT_NH (RTE_NODE_IP6_LOOKUP_NEXT_PKT_DROP << 16)
+
+#define IP6_LOOKUP_FIB_NODE(ctx) \
+	(((struct ip6_lookup_fib_node_ctx *)ctx)->fib6)
+
+#define IP6_LOOKUP_FIB_NODE_PRIV1_OFF(ctx) \
+	(((struct ip6_lookup_fib_node_ctx *)ctx)->mbuf_priv1_off)
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip6_fib_create, 25.07)
+int
+rte_node_ip6_fib_create(int socket, struct rte_fib6_conf *conf)
+{
+	struct ip6_lookup_fib_node_main *nm = &ip6_lookup_fib_nm;
+	char s[RTE_FIB6_NAMESIZE];
+
+	/* One fib6 per socket */
+	if (nm->fib6[socket])
+		return 0;
+
+	conf->default_nh = FIB6_DEFAULT_NH;
+	snprintf(s, sizeof(s), "IPV6_LOOKUP_FIB_%u", socket);
+	nm->fib6[socket] = rte_fib6_create(s, socket, conf);
+	if (nm->fib6[socket] == NULL)
+		return -rte_errno;
+
+	return 0;
+}
+
+static int
+setup_fib6(int socket)
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
+	conf.max_routes = FIB6_DEFAULT_MAX_ROUTES;
+	conf.rib_ext_sz = 0;
+	conf.trie.nh_sz = RTE_FIB6_TRIE_4B;
+	conf.trie.num_tbl8 = FIB6_DEFAULT_NUM_TBL8;
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
+		init_once = 1;
+	}
+
+	rc = setup_fib6(graph->socket);
+	if (rc) {
+		node_err("ip6_lookup_fib", "Failed to setup fib6 for sock %u, rc=%d",
+				graph->socket, rc);
+		return rc;
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
index 8112cf7f5b..5ff52a2c44 100644
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
diff --git a/lib/node/rte_node_ip6_api.h b/lib/node/rte_node_ip6_api.h
index 2875bc981a..1d2b190724 100644
--- a/lib/node/rte_node_ip6_api.h
+++ b/lib/node/rte_node_ip6_api.h
@@ -17,6 +17,7 @@
  */
 #include <rte_common.h>
 #include <rte_compat.h>
+#include <rte_fib6.h>
 #include <rte_ip6.h>
 
 #ifdef __cplusplus
@@ -71,6 +72,20 @@ __rte_experimental
 int rte_node_ip6_rewrite_add(uint16_t next_hop, uint8_t *rewrite_data,
 			     uint8_t rewrite_len, uint16_t dst_port);
 
+/**
+ * Create ipv6 FIB.
+ *
+ * @param socket
+ *   NUMA socket for FIB memory allocation.
+ * @param conf
+ *   Structure containing FIB configuration.
+ *
+ * @return
+ *   0 on success, negative otherwise.
+ */
+__rte_experimental
+int rte_node_ip6_fib_create(int socket, struct rte_fib6_conf *conf);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.25.1

