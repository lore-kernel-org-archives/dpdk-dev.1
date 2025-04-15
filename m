Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C14C369AB
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 12:11:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6007940670;
	Tue, 15 Apr 2025 14:11:29 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 3601240671
 for <dev@dpdk.org>; Tue, 15 Apr 2025 14:11:28 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F75gE4031388;
 Tue, 15 Apr 2025 05:11:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=c
 s6gpROydttqZZisPXXI97W6gWb176r+IZSQNskQahA=; b=jEO0KcjE8ZgFIVPS2
 jcwJbectL2jn6M6F1gmULW8FnJQ4cFiHKkuF/+zf9FTvQ5OAyJdxFTHgfapEMZ3G
 yHqa9WkcN5FOZpAFU4yspzpYueaoHyVmk5IM2FPSQs8u4JNd+Z5jp4751aF5itxU
 juhbtAt2jFlZeot405MPr4TiL4sRQIfj4NaEp/fncxcB+HAI6sgU6cwtYFTHlHvW
 nCzlNUFAlIo4RKRKxs5UlWp/HklmyVbOBKRQr9HJcK15pR5/ifcSOSbQddp7z6Qq
 zXXL516F6fQrY2yQHSUZd1SK99Wc8uDK0IqMwIlpXb4gqEjCknsY7NJq24ush8AR
 60wlA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 460cebn0ap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Apr 2025 05:11:27 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 15 Apr 2025 05:11:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 15 Apr 2025 05:11:25 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id 0193767398;
 Tue, 15 Apr 2025 05:11:22 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v1 02/12] node: add IP4 lookup FIB node
Date: Tue, 15 Apr 2025 17:40:42 +0530
Message-ID: <20250415121052.1497155-3-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250415121052.1497155-1-adwivedi@marvell.com>
References: <20250415121052.1497155-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: X_xVB-mQDM9PEMUx0ZOSy58CYR8G2aVE
X-Authority-Analysis: v=2.4 cv=UJfdHDfy c=1 sm=1 tr=0 ts=67fe4cef cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=g0Ge6n1WPfks1cjC5WYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: X_xVB-mQDM9PEMUx0ZOSy58CYR8G2aVE
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

Adds a lookup FIB node for IP4.

Signed-off-by: Ankur Dwivedi <adwivedi@marvell.com>
---
 lib/node/ip4_lookup_fib.c | 127 ++++++++++++++++++++++++++++++++++++++
 lib/node/meson.build      |   3 +-
 2 files changed, 129 insertions(+), 1 deletion(-)
 create mode 100644 lib/node/ip4_lookup_fib.c

diff --git a/lib/node/ip4_lookup_fib.c b/lib/node/ip4_lookup_fib.c
new file mode 100644
index 0000000000..9c71610718
--- /dev/null
+++ b/lib/node/ip4_lookup_fib.c
@@ -0,0 +1,127 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell.
+ */
+
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
+#define FIB_MAX_ROUTES (1 << 16)
+#define FIB_NUM_TBL8   (1 << 15)
+#define FIB_DEFAULT_NH 999
+
+#define IP4_LOOKUP_NODE_FIB(ctx) \
+	(((struct ip4_lookup_fib_node_ctx *)ctx)->fib)
+
+#define IP4_LOOKUP_NODE_PRIV1_OFF(ctx) \
+	(((struct ip4_lookup_fib_node_ctx *)ctx)->mbuf_priv1_off)
+
+static int
+setup_fib(unsigned int socket)
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
+	conf.max_routes = FIB_MAX_ROUTES;
+	conf.rib_ext_sz = 0;
+	conf.dir24_8.nh_sz = RTE_FIB_DIR24_8_4B;
+	conf.dir24_8.num_tbl8 = FIB_NUM_TBL8;
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
+	unsigned int socket;
+	uint16_t lcore_id;
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
+		/* Setup FIB for all sockets */
+		RTE_LCORE_FOREACH(lcore_id)
+		{
+			socket = rte_lcore_to_socket_id(lcore_id);
+			rc = setup_fib(socket);
+			if (rc) {
+				node_err("ip4_lookup_fib",
+					 "Failed to setup fib for sock %u, rc=%d",
+					 socket, rc);
+				return rc;
+			}
+		}
+		init_once = 1;
+	}
+
+	/* Update socket's FIB and mbuf dyn priv1 offset in node ctx */
+	IP4_LOOKUP_NODE_FIB(node->ctx) = ip4_lookup_fib_nm.fib[graph->socket];
+	IP4_LOOKUP_NODE_PRIV1_OFF(node->ctx) = node_mbuf_priv1_dynfield_offset;
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
-- 
2.25.1

