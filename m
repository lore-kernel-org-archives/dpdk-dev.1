Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340F9C3ABBC
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 06:45:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75879402E6;
	Fri,  9 May 2025 08:45:11 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id EEDAB4026B
 for <dev@dpdk.org>; Fri,  9 May 2025 08:45:09 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548NIha1003978;
 Thu, 8 May 2025 23:45:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
 3h2IL19h1BaFwMZaMCE4ErGnLV0BMjRVjIai0lPhgk=; b=ehxttPsFGe4K3MUEs
 sYOUYmD81GNLeXdIXjTRgcNfacaSTNs+hTp8owsi+0sFF2hPXJN6iThgwTUoCd/V
 N9Hu1qmrLyOU3jRbl6M10YN4/RX0hBxPKsI03VAKSbqjbvDRMENvGY+259z2MK0+
 QdezOiR2aqrGPlefIBuSuuATIBOpyqMW6eEBX0K21/U9x5vXJHq+D1EWmyMxLIes
 J4DcXkATYB60QJgDOQURvoZZqtaZQAm49G/0l5bazM+u5hBG81sS9bvSx8YivxDN
 pOmut05eCCJuQ1SkZ4e8WWg2b9Spte9HjP9JC2j3kUT55Jgad1yPgguVUXmul2w0
 jtc8w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46h65x0p91-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 23:45:09 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 8 May 2025 23:45:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 8 May 2025 23:45:07 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id E3FB83F704F;
 Thu,  8 May 2025 23:45:04 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>, <nsaxena@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v2 02/13] node: add IP4 lookup FIB node
Date: Fri, 9 May 2025 12:14:37 +0530
Message-ID: <20250509064448.724019-3-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250509064448.724019-1-adwivedi@marvell.com>
References: <20250415121052.1497155-1-adwivedi@marvell.com>
 <20250509064448.724019-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ZdsdNtVA c=1 sm=1 tr=0 ts=681da475 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=EON3tCc8ftYOkJwuPaQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA2MyBTYWx0ZWRfXzJR3Ly4ZpN/G
 jdpnf3xueAO8D+KyghOxXr4cck3aUxWLa0/FYSI1y5lsZTOUwqJA3rEY07drFIbYY9J7IzHPGMT
 sPzrhZTfBk/kDMSFNjYrYQ074xiKegPJJBHRppDbP5XHN4Mm0erAo7Uo77ChubF4pMhUigkXo4D
 XZa4MZ6ABqqSqIfwxNbgxe6U7A9VfwW1oUzgGLzsqTCIJZ+kIax5F9H0xc+6QeqDhUdlAKgDpBg
 g4ahSU2Ww6kq4SLuJcQI2f+WVNr3tZF5dmjzjWMms4CPwIZ1EHYaIufsEF/4fPEirl8TwOD3T9B
 WhcrkmBH9Lwof3XwMNMAmvIfI11Wv8t7J2SmF1XoUkdyPAc9NTaMK+tlAjLt4x+5AY6qBugtS5j
 zhbYbmRZL7fUBZ92leCQIqg8x9NArA9qHr2cFKddd2uW81HpG8yTkkgRL6oVOzFcOwKC1Q8m
X-Proofpoint-GUID: bpWwtRqktLgVdH8NZukRMOwcL-FP90v5
X-Proofpoint-ORIG-GUID: bpWwtRqktLgVdH8NZukRMOwcL-FP90v5
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

