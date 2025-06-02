Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04091C5B549
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 06:37:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62BDD402EA;
	Mon,  2 Jun 2025 08:37:09 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 48E99402E1
 for <dev@dpdk.org>; Mon,  2 Jun 2025 08:37:06 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 551MEgOc028737;
 Sun, 1 Jun 2025 23:37:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
 3h2IL19h1BaFwMZaMCE4ErGnLV0BMjRVjIai0lPhgk=; b=Uly8OoIoSYZj+JadZ
 HkIRp2h+KdzCakPF7lf8vKSP20qC6TXalNKnv3ZNA8rOrqYiU/W3gFbzdlOhah1u
 vwEY733Btn2hl4pP50nwbw6cI3Lr5xxXJ+P1KOH4a43H6khGVn33QylibGZC2TtF
 P11ZQrR/vrHsgzFrivDfFNdWh8CmQ/4nPmH+xSqY9WSyS+jq56myojkebr3xVhnc
 kBP4kGJVKpbj15/rPn+Uo7Qa1H2FZ1vI29GXbmG0j/FIuoqtRyxCvXIgKwk8yq8e
 mj3FyOpCCGjDc0Zqyh4eawgCSDzuaW+9IaBBt2mKbIBw0UUEMgpak5lvBo2EzEwz
 ENrDw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 470ye00n1c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 01 Jun 2025 23:37:05 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 1 Jun 2025 23:37:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 1 Jun 2025 23:37:04 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id 1E5A63F704B;
 Sun,  1 Jun 2025 23:37:00 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>, <nsaxena@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v3 02/14] node: add IP4 lookup FIB node
Date: Mon, 2 Jun 2025 12:06:27 +0530
Message-ID: <20250602063639.198550-3-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250602063639.198550-1-adwivedi@marvell.com>
References: <20250509064448.724019-1-adwivedi@marvell.com>
 <20250602063639.198550-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDA1NSBTYWx0ZWRfX9aI3vl5auSPa
 lBaFHxKwdZPuRuwAwKTE4AR+v00KR/K54tjaVlI9IoDTAX24aUVPm+JQD6TJAoQY330NwtPL61y
 Zup2V1Sv+v9B3uIEDGywKCwEz+Y9fHjhHslVvMq13gl0WVBZRG1K+ClTqO20yQpGbyxGYIrgWyg
 pFjDYuZkE7zJdr23mBPSNXoRil1alW2oF6qn+0YJ5h0YdF3FSjOF0/3tJ7chIhNbKPR+XygXmiI
 hQoqpzS3Xaq9OZvKHC1lqHrdYmviUgl4LJE9qJuuvjCasL0yHIYOLaEgUrqZrR8EUWG+6UNGfCO
 o+/zmPONnj+417bpJmr5jCp5E+OiUwTn/GVSVe/HeWqmOC6V08DzklcgbWMovIXkKiYPR/d6T/x
 AFh1DgZOCNoktmU0CbDTa98BWbFVhADXOezZnW3tyYnMSoAgUBRcdcQFBLTGfA25hbss9/8W
X-Authority-Analysis: v=2.4 cv=Iv8ecK/g c=1 sm=1 tr=0 ts=683d4691 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=EON3tCc8ftYOkJwuPaQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: ArmhTd3B3jWIK2GMMxx4Faws6uXIT90K
X-Proofpoint-GUID: ArmhTd3B3jWIK2GMMxx4Faws6uXIT90K
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

Adds a lookup FIB node for IP4.
Adds a public function to do fib configuration from application.

Signed-off-by: Ankur Dwivedi <adwivedi@marvell.com>
---
 lib/node/ip4_lookup_fib.c   | 141 ++++++++++++++++++++++++++++++++++++
 lib/node/meson.build        |   3 +-
 lib/node/rte_node_ip4_api.h |  15 ++++
 3 files changed, 158 insertions(+), 1 deletion(-)
 create mode 100644 lib/node/ip4_lookup_fib.c

diff --git a/lib/node/ip4_lookup_fib.c b/lib/node/ip4_lookup_fib.c
new file mode 100644
index 0000000000..977d97b713
--- /dev/null
+++ b/lib/node/ip4_lookup_fib.c
@@ -0,0 +1,141 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell.
+ */
+
+#include <eal_export.h>
+#include <rte_errno.h>
+#include <rte_ether.h>
+#include <rte_fib.h>
+#include <rte_graph.h>
+#include <rte_graph_worker.h>
+#include <rte_ip.h>
+
+#include "rte_node_ip4_api.h"
+
+#include "node_private.h"
+
+/* IP4 Lookup global data struct */
+struct ip4_lookup_fib_node_main {
+	struct rte_fib *fib[RTE_MAX_NUMA_NODES];
+};
+
+struct ip4_lookup_fib_node_ctx {
+	/* Socket's FIB */
+	struct rte_fib *fib;
+	/* Dynamic offset to mbuf priv1 */
+	int mbuf_priv1_off;
+};
+
+static struct ip4_lookup_fib_node_main ip4_lookup_fib_nm;
+
+#define FIB_DEFAULT_MAX_ROUTES (UINT16_MAX)
+#define FIB_DEFAULT_NUM_TBL8   (UINT16_MAX / 2)
+#define FIB_DEFAULT_NH (RTE_NODE_IP4_LOOKUP_NEXT_PKT_DROP << 16)
+
+#define IP4_LOOKUP_NODE_FIB(ctx) \
+	(((struct ip4_lookup_fib_node_ctx *)ctx)->fib)
+
+#define IP4_LOOKUP_FIB_NODE_PRIV1_OFF(ctx) \
+	(((struct ip4_lookup_fib_node_ctx *)ctx)->mbuf_priv1_off)
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip4_fib_create, 25.07)
+int
+rte_node_ip4_fib_create(int socket, struct rte_fib_conf *conf)
+{
+	struct ip4_lookup_fib_node_main *nm = &ip4_lookup_fib_nm;
+	char s[RTE_FIB_NAMESIZE];
+
+	/* One fib per socket */
+	if (nm->fib[socket])
+		return 0;
+
+	conf->default_nh = FIB_DEFAULT_NH;
+	snprintf(s, sizeof(s), "IPV4_LOOKUP_FIB_%d", socket);
+	nm->fib[socket] = rte_fib_create(s, socket, conf);
+	if (nm->fib[socket] == NULL)
+		return -rte_errno;
+
+	return 0;
+}
+
+static int
+setup_fib(int socket)
+{
+	struct ip4_lookup_fib_node_main *nm = &ip4_lookup_fib_nm;
+	struct rte_fib_conf conf;
+	char s[RTE_FIB_NAMESIZE];
+
+	/* One fib per socket */
+	if (nm->fib[socket])
+		return 0;
+
+	conf.type = RTE_FIB_DIR24_8;
+	conf.default_nh = FIB_DEFAULT_NH;
+	conf.max_routes = FIB_DEFAULT_MAX_ROUTES;
+	conf.rib_ext_sz = 0;
+	conf.dir24_8.nh_sz = RTE_FIB_DIR24_8_4B;
+	conf.dir24_8.num_tbl8 = FIB_DEFAULT_NUM_TBL8;
+	conf.flags = 0;
+	snprintf(s, sizeof(s), "IPV4_LOOKUP_FIB_%d", socket);
+	nm->fib[socket] = rte_fib_create(s, socket, &conf);
+	if (nm->fib[socket] == NULL)
+		return -rte_errno;
+
+	return 0;
+}
+
+static int
+ip4_lookup_fib_node_init(const struct rte_graph *graph, struct rte_node *node)
+{
+	static uint8_t init_once;
+	int rc;
+
+	RTE_BUILD_BUG_ON(sizeof(struct ip4_lookup_fib_node_ctx) > RTE_NODE_CTX_SZ);
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
+	rc = setup_fib(graph->socket);
+	if (rc) {
+		node_err("ip4_lookup_fib", "Failed to setup fib for sock %u, rc=%d",
+				graph->socket, rc);
+		return rc;
+	}
+
+	/* Update socket's FIB and mbuf dyn priv1 offset in node ctx */
+	IP4_LOOKUP_NODE_FIB(node->ctx) = ip4_lookup_fib_nm.fib[graph->socket];
+	IP4_LOOKUP_FIB_NODE_PRIV1_OFF(node->ctx) = node_mbuf_priv1_dynfield_offset;
+
+	node_dbg("ip4_lookup_fib", "Initialized ip4_lookup_fib node");
+
+	return 0;
+}
+
+static struct rte_node_xstats ip4_lookup_fib_xstats = {
+	.nb_xstats = 1,
+	.xstat_desc = {
+		[0] = "ip4_lookup_fib_error",
+	},
+};
+
+static struct rte_node_register ip4_lookup_fib_node = {
+	.name = "ip4_lookup_fib",
+
+	.init = ip4_lookup_fib_node_init,
+	.xstats = &ip4_lookup_fib_xstats,
+
+	.nb_edges = RTE_NODE_IP4_LOOKUP_NEXT_PKT_DROP + 1,
+	.next_nodes = {
+		[RTE_NODE_IP4_LOOKUP_NEXT_IP4_LOCAL] = "ip4_local",
+		[RTE_NODE_IP4_LOOKUP_NEXT_REWRITE] = "ip4_rewrite",
+		[RTE_NODE_IP4_LOOKUP_NEXT_PKT_DROP] = "pkt_drop",
+	},
+};
+
+RTE_NODE_REGISTER(ip4_lookup_fib_node);
diff --git a/lib/node/meson.build b/lib/node/meson.build
index 0bed97a96c..d2011c8f56 100644
--- a/lib/node/meson.build
+++ b/lib/node/meson.build
@@ -13,6 +13,7 @@ sources = files(
         'ethdev_tx.c',
         'ip4_local.c',
         'ip4_lookup.c',
+        'ip4_lookup_fib.c',
         'ip4_reassembly.c',
         'ip4_rewrite.c',
         'ip6_lookup.c',
@@ -34,4 +35,4 @@ headers = files(
 
 # Strict-aliasing rules are violated by uint8_t[] to context size casts.
 cflags += '-fno-strict-aliasing'
-deps += ['graph', 'mbuf', 'lpm', 'ethdev', 'mempool', 'cryptodev', 'ip_frag']
+deps += ['graph', 'mbuf', 'lpm', 'ethdev', 'mempool', 'cryptodev', 'ip_frag', 'fib']
diff --git a/lib/node/rte_node_ip4_api.h b/lib/node/rte_node_ip4_api.h
index 950751a525..1dac7a4936 100644
--- a/lib/node/rte_node_ip4_api.h
+++ b/lib/node/rte_node_ip4_api.h
@@ -18,6 +18,7 @@
 #include <rte_common.h>
 #include <rte_compat.h>
 
+#include <rte_fib.h>
 #include <rte_graph.h>
 
 #ifdef __cplusplus
@@ -117,6 +118,20 @@ int rte_node_ip4_rewrite_add(uint16_t next_hop, uint8_t *rewrite_data,
 __rte_experimental
 int rte_node_ip4_reassembly_configure(struct rte_node_ip4_reassembly_cfg *cfg, uint16_t cnt);
 
+/**
+ * Create ipv4 FIB.
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
+int rte_node_ip4_fib_create(int socket, struct rte_fib_conf *conf);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.25.1

