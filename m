Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072EBC369AB
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Apr 2025 15:17:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 455F440664;
	Mon, 21 Apr 2025 17:17:39 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0765340662
 for <dev@dpdk.org>; Mon, 21 Apr 2025 17:17:37 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LAUZKP024380;
 Mon, 21 Apr 2025 08:17:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=w
 5RuZMOyPeGFKrYc92/94f4m6aDJI22b58ZR/sc82pU=; b=Bs4vXrFZhR4VSxiD8
 ZvgHf6+JDMzcKRg5aMd2rVmiPTcnOE2G7l9N4QcytYWb1u72z9PvWAGKjmXdKR5W
 jdvD61UPewubPsD7RjB7p0dA66BBylcy85uQGcifoe2+hB0wNJWcDsa9LgmnYdbK
 O6jxUl4JyevJptAs1uVzUBGmsotz0nf+3erKZ4GyqgN67wqkpA+cafC3wdlFkJrV
 oFKKzGOpk9TNmfbC8EX4EJqii0xOlo8IM8gLeMESjQGvdc/obnM8Lcr0EUNT8VhT
 dSAjopMm/sJBhwBnDO+PV7FXO0Z0iL1jt79uC6ObohV/KGB1i+Z/s9O0UmG1HftO
 2AFfQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 464vkb27wa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Apr 2025 08:17:33 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 21 Apr 2025 08:17:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Apr 2025 08:17:32 -0700
Received: from cavium-PowerEdge-R640.. (unknown [10.28.36.207])
 by maili.marvell.com (Postfix) with ESMTP id 1FB463F7066;
 Mon, 21 Apr 2025 08:17:29 -0700 (PDT)
From: Nitin Saxena <nsaxena@marvell.com>
To: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan
 <yanzhirun_163@163.com>, Robin Jarry <rjarry@redhat.com>,
 Christophe Fontaine <cfontain@redhat.com>
CC: <dev@dpdk.org>, Nitin Saxena <nsaxena16@gmail.com>
Subject: [PATCH v9 3/5] ip4: add ip4 output feature arc
Date: Mon, 21 Apr 2025 20:47:14 +0530
Message-ID: <20250421151718.2172470-4-nsaxena@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250421151718.2172470-1-nsaxena@marvell.com>
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250421151718.2172470-1-nsaxena@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=JLU7s9Kb c=1 sm=1 tr=0 ts=6806618d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=lmGZzNc0xgync0l5liwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: Ed5cCWU9XtufQiWd3YFw16-5Kxz9Y5qT
X-Proofpoint-GUID: Ed5cCWU9XtufQiWd3YFw16-5Kxz9Y5qT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_07,2025-04-21_02,2024-11-22_01
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

- Added ip4 output arc to allow applications to hook feature nodes in ip4
egress direction
- Added interface_tx node as end feature to ip4 output arc

Signed-off-by: Nitin Saxena <nsaxena@marvell.com>
---
 lib/node/ethdev_ctrl.c               |   8 +
 lib/node/interface_tx_feature.c      | 213 ++++++++++++++++++++
 lib/node/interface_tx_feature_priv.h |  33 ++++
 lib/node/ip4_rewrite.c               | 286 ++++++++++++++++++++++++++-
 lib/node/meson.build                 |   1 +
 lib/node/node_private.h              |   1 +
 lib/node/rte_node_ip4_api.h          |   4 +
 7 files changed, 539 insertions(+), 7 deletions(-)
 create mode 100644 lib/node/interface_tx_feature.c
 create mode 100644 lib/node/interface_tx_feature_priv.h

diff --git a/lib/node/ethdev_ctrl.c b/lib/node/ethdev_ctrl.c
index dca7e817f9..f717903731 100644
--- a/lib/node/ethdev_ctrl.c
+++ b/lib/node/ethdev_ctrl.c
@@ -15,6 +15,7 @@
 #include "ethdev_tx_priv.h"
 #include "ip4_rewrite_priv.h"
 #include "ip6_rewrite_priv.h"
+#include "interface_tx_feature_priv.h"
 #include "node_private.h"

 static struct ethdev_ctrl {
@@ -26,6 +27,7 @@ int
 rte_node_eth_config(struct rte_node_ethdev_config *conf, uint16_t nb_confs,
 		    uint16_t nb_graphs)
 {
+	struct rte_node_register *if_tx_feature_node;
 	struct rte_node_register *ip4_rewrite_node;
 	struct rte_node_register *ip6_rewrite_node;
 	struct ethdev_tx_node_main *tx_node_data;
@@ -37,6 +39,7 @@ rte_node_eth_config(struct rte_node_ethdev_config *conf, uint16_t nb_confs,
 	int i, j, rc;
 	uint32_t id;

+	if_tx_feature_node = if_tx_feature_node_get();
 	ip4_rewrite_node = ip4_rewrite_node_get();
 	ip6_rewrite_node = ip6_rewrite_node_get();
 	tx_node_data = ethdev_tx_node_data_get();
@@ -127,6 +130,11 @@ rte_node_eth_config(struct rte_node_ethdev_config *conf, uint16_t nb_confs,
 		if (rc < 0)
 			return rc;

+		/* Add this tx port node to if_tx_feature_node */
+		rte_node_edge_update(if_tx_feature_node->id, RTE_EDGE_ID_INVALID,
+				     &next_nodes, 1);
+		rc = if_tx_feature_node_set_next(port_id,
+						 rte_node_edge_count(if_tx_feature_node->id) - 1);
 	}

 	ctrl.nb_graphs = nb_graphs;
diff --git a/lib/node/interface_tx_feature.c b/lib/node/interface_tx_feature.c
new file mode 100644
index 0000000000..c8809d5f91
--- /dev/null
+++ b/lib/node/interface_tx_feature.c
@@ -0,0 +1,213 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell International Ltd.
+ */
+
+#include <arpa/inet.h>
+#include <sys/socket.h>
+
+#include <rte_ethdev.h>
+#include <rte_ether.h>
+#include <rte_graph_feature_arc_worker.h>
+#include <rte_malloc.h>
+
+#include "rte_node_ip4_api.h"
+#include "node_private.h"
+#include "interface_tx_feature_priv.h"
+
+#define IF_TX_FEATURE_LAST_NEXT_INDEX(ctx) \
+	(((struct if_tx_feature_node_ctx *)ctx)->last_index)
+/*
+ * @internal array for mapping port to next node index
+ */
+struct if_tx_feature_node_main  {
+	uint16_t next_index[RTE_MAX_ETHPORTS];
+};
+
+struct if_tx_feature_node_ctx {
+	uint16_t last_index;
+};
+
+static struct if_tx_feature_node_main *if_tx_feature_nm;
+
+int
+if_tx_feature_node_set_next(uint16_t port_id, uint16_t next_index)
+{
+	if (if_tx_feature_nm == NULL) {
+		if_tx_feature_nm = rte_zmalloc(
+			"if_tx_feature_nm", sizeof(struct if_tx_feature_node_main),
+			RTE_CACHE_LINE_SIZE);
+		if (if_tx_feature_nm == NULL)
+			return -ENOMEM;
+	}
+	if_tx_feature_nm->next_index[port_id] = next_index;
+
+	return 0;
+}
+
+static int
+if_tx_feature_node_init(const struct rte_graph *graph, struct rte_node *node)
+{
+	RTE_SET_USED(graph);
+
+	/* pkt_drop */
+	IF_TX_FEATURE_LAST_NEXT_INDEX(node->ctx) = 0;
+
+	return 0;
+}
+
+static uint16_t
+if_tx_feature_node_process(struct rte_graph *graph, struct rte_node *node,
+			   void **objs, uint16_t nb_objs)
+{
+	uint16_t held = 0, next0 = 0, next1 = 0, next2 = 0, next3 = 0;
+	struct rte_mbuf *mbuf0, *mbuf1, *mbuf2, *mbuf3, **pkts;
+	uint16_t last_spec = 0, fix_spec = 0;
+	void **to_next, **from;
+	rte_edge_t next_index;
+	uint16_t n_left_from;
+
+	/* Speculative next */
+	next_index = IF_TX_FEATURE_LAST_NEXT_INDEX(node->ctx);
+
+	from = objs;
+	n_left_from = nb_objs;
+	pkts = (struct rte_mbuf **)objs;
+
+	to_next = rte_node_next_stream_get(graph, node, next_index, nb_objs);
+	while (n_left_from > 4) {
+		if (likely(n_left_from > 7)) {
+			/* Prefetch next mbuf */
+			rte_prefetch0(objs[4]);
+			rte_prefetch0(objs[5]);
+			rte_prefetch0(objs[6]);
+			rte_prefetch0(objs[7]);
+		}
+		mbuf0 = pkts[0];
+		mbuf1 = pkts[1];
+		mbuf2 = pkts[2];
+		mbuf3 = pkts[3];
+		pkts += 4;
+		n_left_from -= 4;
+
+		/* port-tx node starts from next edge 1*/
+		next0 = if_tx_feature_nm->next_index[mbuf0->port];
+		next1 = if_tx_feature_nm->next_index[mbuf1->port];
+		next2 = if_tx_feature_nm->next_index[mbuf2->port];
+		next3 = if_tx_feature_nm->next_index[mbuf3->port];
+
+		fix_spec = (next_index ^ next0) | (next_index ^ next1) |
+			(next_index ^ next2) | (next_index ^ next3);
+
+		if (unlikely(fix_spec)) {
+			/* Copy things successfully speculated till now */
+			rte_memcpy(to_next, from,
+				   last_spec * sizeof(from[0]));
+			from += last_spec;
+			to_next += last_spec;
+			held += last_spec;
+			last_spec = 0;
+
+			if (next0 == next_index) {
+				to_next[0] = from[0];
+				to_next++;
+				held++;
+			} else {
+				rte_node_enqueue_x1(graph, node,
+						    next0, from[0]);
+			}
+
+			if (next1 == next_index) {
+				to_next[0] = from[1];
+				to_next++;
+				held++;
+			} else {
+				rte_node_enqueue_x1(graph, node,
+						    next1, from[1]);
+			}
+
+			if (next2 == next_index) {
+				to_next[0] = from[2];
+				to_next++;
+				held++;
+			} else {
+				rte_node_enqueue_x1(graph, node,
+						    next2, from[2]);
+			}
+
+			if (next3 == next_index) {
+				to_next[0] = from[3];
+				to_next++;
+				held++;
+			} else {
+				rte_node_enqueue_x1(graph, node,
+						    next3, from[3]);
+			}
+			from += 4;
+		} else {
+			last_spec += 4;
+		}
+	}
+
+	while (n_left_from > 0) {
+		mbuf0 = pkts[0];
+
+		pkts += 1;
+		n_left_from -= 1;
+
+		next0 = if_tx_feature_nm->next_index[mbuf0->port];
+		if (unlikely(next0 != next_index)) {
+			/* Copy things successfully speculated till now */
+			rte_memcpy(to_next, from,
+				   last_spec * sizeof(from[0]));
+			from += last_spec;
+			to_next += last_spec;
+			held += last_spec;
+			last_spec = 0;
+
+			rte_node_enqueue_x1(graph, node,
+					    next0, from[0]);
+			from += 1;
+		} else {
+			last_spec += 1;
+		}
+	}
+
+	/* !!! Home run !!! */
+	if (likely(last_spec == nb_objs)) {
+		rte_node_next_stream_move(graph, node, next_index);
+		return nb_objs;
+	}
+	held += last_spec;
+	rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
+	rte_node_next_stream_put(graph, node, next_index, held);
+
+	IF_TX_FEATURE_LAST_NEXT_INDEX(node->ctx) = next0;
+
+	return nb_objs;
+}
+
+static struct rte_node_register if_tx_feature_node = {
+	.process = if_tx_feature_node_process,
+	.init = if_tx_feature_node_init,
+	.name = "interface_tx",
+	.nb_edges = 1,
+	.next_nodes = {
+		[0] = "pkt_drop",
+	},
+};
+
+struct rte_node_register *
+if_tx_feature_node_get(void)
+{
+	return &if_tx_feature_node;
+}
+
+RTE_NODE_REGISTER(if_tx_feature_node);
+
+/* if_tx feature node */
+struct rte_graph_feature_register if_tx_feature = {
+	.feature_name = RTE_IP4_OUTPUT_END_FEATURE_NAME,
+	.arc_name = RTE_IP4_OUTPUT_FEATURE_ARC_NAME,
+	.feature_process_fn = if_tx_feature_node_process,
+	.feature_node = &if_tx_feature_node,
+};
diff --git a/lib/node/interface_tx_feature_priv.h b/lib/node/interface_tx_feature_priv.h
new file mode 100644
index 0000000000..846191572d
--- /dev/null
+++ b/lib/node/interface_tx_feature_priv.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell International Ltd.
+ */
+#ifndef __INCLUDE_IF_TX_FEATURE_PRIV_H__
+#define __INCLUDE_IF_TX_FEATURE_PRIV_H__
+
+#include <rte_common.h>
+
+extern struct rte_graph_feature_register if_tx_feature;
+
+/**
+ * @internal
+ *
+ * Get the ipv4 rewrite node.
+ *
+ * @return
+ *   Pointer to the ipv4 rewrite node.
+ */
+struct rte_node_register *if_tx_feature_node_get(void);
+
+/**
+ * @internal
+ *
+ * Set the Edge index of a given port_id.
+ *
+ * @param port_id
+ *   Ethernet port identifier.
+ * @param next_index
+ *   Edge index of the Given Tx node.
+ */
+int if_tx_feature_node_set_next(uint16_t port_id, uint16_t next_index);
+
+#endif /* __INCLUDE_INTERFCE_TX_FEATURE_PRIV_H */
diff --git a/lib/node/ip4_rewrite.c b/lib/node/ip4_rewrite.c
index a9ab5eaa57..37158113c0 100644
--- a/lib/node/ip4_rewrite.c
+++ b/lib/node/ip4_rewrite.c
@@ -1,12 +1,12 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(C) 2020 Marvell International Ltd.
  */
-
 #include <eal_export.h>
 #include <rte_ethdev.h>
 #include <rte_ether.h>
 #include <rte_graph.h>
 #include <rte_graph_worker.h>
+#include <rte_graph_feature_arc_worker.h>
 #include <rte_ip.h>
 #include <rte_malloc.h>
 #include <rte_vect.h>
@@ -15,15 +15,27 @@

 #include "ip4_rewrite_priv.h"
 #include "node_private.h"
+#include "interface_tx_feature_priv.h"
+
+#ifndef RTE_IP4_OUTPUT_ARC_INDEXES
+#define RTE_IP4_OUTPUT_ARC_INDEXES RTE_MAX_ETHPORTS
+#endif

 struct ip4_rewrite_node_ctx {
 	/* Dynamic offset to mbuf priv1 */
 	int mbuf_priv1_off;
+	/* Dynamic offset to feature arc field */
+	int arc_dyn_off;
 	/* Cached next index */
 	uint16_t next_index;
+	/* tx interface of last mbuf */
+	uint16_t last_tx_if;
+	/* Cached feature arc handle */
+	rte_graph_feature_arc_t output_feature_arc;
 };

 static struct ip4_rewrite_node_main *ip4_rewrite_nm;
+static int port_to_next_index_diff = -1;

 #define IP4_REWRITE_NODE_LAST_NEXT(ctx) \
 	(((struct ip4_rewrite_node_ctx *)ctx)->next_index)
@@ -31,16 +43,157 @@ static struct ip4_rewrite_node_main *ip4_rewrite_nm;
 #define IP4_REWRITE_NODE_PRIV1_OFF(ctx) \
 	(((struct ip4_rewrite_node_ctx *)ctx)->mbuf_priv1_off)

-static uint16_t
-ip4_rewrite_node_process(struct rte_graph *graph, struct rte_node *node,
-			 void **objs, uint16_t nb_objs)
+#define IP4_REWRITE_NODE_FEAT_OFF(ctx) \
+	(((struct ip4_rewrite_node_ctx *)ctx)->arc_dyn_off)
+
+#define IP4_REWRITE_NODE_OUTPUT_FEATURE_ARC(ctx) \
+	(((struct ip4_rewrite_node_ctx *)ctx)->output_feature_arc)
+
+#define IP4_REWRITE_NODE_LAST_TX_IF(ctx) \
+	(((struct ip4_rewrite_node_ctx *)ctx)->last_tx_if)
+
+static __rte_always_inline void
+check_output_feature_arc_x1(struct rte_graph_feature_arc *arc, uint16_t *tx_if,
+			    struct rte_mbuf *mbuf0, uint16_t *next0,
+			    uint16_t *last_next_index,
+			    rte_graph_feature_data_t *feature_data, const int feat_dyn)
 {
+	struct rte_graph_feature_arc_mbuf_dynfields *d0 = NULL;
+	uint16_t port0;
+
+	/* make sure packets are not being sent to pkt_drop node */
+	if (likely(*next0 >= port_to_next_index_diff)) {
+
+		port0 = (*next0) - port_to_next_index_diff;
+
+		/* get pointer to feature arc mbuf */
+		d0 = rte_graph_feature_arc_mbuf_dynfields_get(mbuf0, feat_dyn);
+
+		/* Check if last packet's tx port not same as current */
+		if (*tx_if != port0) {
+			if (rte_graph_feature_data_first_feature_get(arc, port0,
+								     &d0->feature_data,
+								     next0)) {
+				mbuf0->port = port0;
+				*last_next_index = *next0;
+			}
+			*tx_if = port0;
+			*feature_data = d0->feature_data;
+		} else {
+			if (rte_graph_feature_data_is_valid(*feature_data)) {
+				*next0 = *last_next_index;
+				mbuf0->port = port0;
+				d0->feature_data = *feature_data;
+			}
+		}
+	}
+}
+
+static __rte_always_inline void
+check_output_feature_arc_x4(struct rte_graph_feature_arc *arc, uint16_t *tx_if,
+			    struct rte_mbuf *mbuf0, struct rte_mbuf *mbuf1,
+			    struct rte_mbuf *mbuf2, struct rte_mbuf *mbuf3,
+			    uint16_t *next0, uint16_t *next1, uint16_t *next2,
+			    uint16_t *next3, uint16_t *last_next_index,
+			    rte_graph_feature_data_t *feature_data, const int feat_dyn)
+{
+	struct rte_graph_feature_arc_mbuf_dynfields *d0 = NULL, *d1 = NULL, *d2 = NULL, *d3 = NULL;
+	uint16_t port0, port1, port2, port3;
+	uint16_t xor = 0;
+
+	/* get pointer to feature arc dyn field */
+	d0 = rte_graph_feature_arc_mbuf_dynfields_get(mbuf0, feat_dyn);
+	d1 = rte_graph_feature_arc_mbuf_dynfields_get(mbuf1, feat_dyn);
+	d2 = rte_graph_feature_arc_mbuf_dynfields_get(mbuf2, feat_dyn);
+	d3 = rte_graph_feature_arc_mbuf_dynfields_get(mbuf3, feat_dyn);
+
+	/*
+	 * Check if all four packets are going to same next_index/port
+	 */
+	xor = (*tx_if + port_to_next_index_diff) ^ (*next0);
+	xor += (*next0) ^ (*next1);
+	xor += (*next1) ^ (*next2);
+	xor += (*next2) ^ (*next3);
+
+	if (xor) {
+		/* packets tx ports are not same, check first feature for each mbuf
+		 * make sure next0 != 0 which is pkt_drop
+		 */
+		port0 = (*next0) - port_to_next_index_diff;
+		port1 = (*next1) - port_to_next_index_diff;
+		port2 = (*next2) - port_to_next_index_diff;
+		port3 = (*next3) - port_to_next_index_diff;
+		if (unlikely((*next0 >= port_to_next_index_diff) &&
+			     rte_graph_feature_data_first_feature_get(arc, port0,
+								      &d0->feature_data,
+								      next0))) {
+			/* update next0 from feature arc */
+			mbuf0->port = port0;
+		}
+
+		if (unlikely((*next1 >= port_to_next_index_diff) &&
+			     rte_graph_feature_data_first_feature_get(arc, port1,
+								      &d1->feature_data,
+								      next1))) {
+			mbuf1->port = port1;
+		}
+
+		if (unlikely((*next2 >= port_to_next_index_diff) &&
+			     rte_graph_feature_data_first_feature_get(arc, port2,
+								      &d2->feature_data,
+								      next2))) {
+			mbuf2->port = port2;
+		}
+
+		if (unlikely((*next3 >= port_to_next_index_diff) &&
+			     rte_graph_feature_data_first_feature_get(arc, port3,
+								      &d3->feature_data,
+								      next3))) {
+			mbuf3->port = port3;
+
+			*tx_if = port3;
+			*last_next_index = *next3;
+		}
+		*feature_data = d3->feature_data;
+	} else {
+		/* All packets are same as last tx port. Check if feature enabled
+		 * on last packet is valid or not. If invalid no need to
+		 * change any next[0-3]
+		 * Also check packet is not being sent to pkt_drop node
+		 */
+		if (unlikely(rte_graph_feature_data_is_valid(*feature_data) &&
+			     (*next0 != 0))) {
+			*next0 = *last_next_index;
+			*next1 = *last_next_index;
+			*next2 = *last_next_index;
+			*next3 = *last_next_index;
+
+			d0->feature_data = *feature_data;
+			d1->feature_data = *feature_data;
+			d2->feature_data = *feature_data;
+			d3->feature_data = *feature_data;
+
+			mbuf0->port = *tx_if;
+			mbuf1->port = *tx_if;
+			mbuf2->port = *tx_if;
+			mbuf3->port = *tx_if;
+		}
+	}
+}
+
+static __rte_always_inline uint16_t
+__ip4_rewrite_node_process(struct rte_graph *graph, struct rte_node *node,
+			   void **objs, uint16_t nb_objs,
+			   const int dyn, const int feat_dyn, const int check_enabled_features,
+			   struct rte_graph_feature_arc *out_feature_arc)
+{
+	rte_graph_feature_data_t feature_data = RTE_GRAPH_FEATURE_DATA_INVALID;
 	struct rte_mbuf *mbuf0, *mbuf1, *mbuf2, *mbuf3, **pkts;
 	struct ip4_rewrite_nh_header *nh = ip4_rewrite_nm->nh;
-	const int dyn = IP4_REWRITE_NODE_PRIV1_OFF(node->ctx);
 	uint16_t next0, next1, next2, next3, next_index;
 	struct rte_ipv4_hdr *ip0, *ip1, *ip2, *ip3;
 	uint16_t n_left_from, held = 0, last_spec = 0;
+	uint16_t last_tx_if, last_next_index;
 	void *d0, *d1, *d2, *d3;
 	void **to_next, **from;
 	rte_xmm_t priv01;
@@ -58,6 +211,28 @@ ip4_rewrite_node_process(struct rte_graph *graph, struct rte_node *node,
 	for (i = 0; i < 4 && i < n_left_from; i++)
 		rte_prefetch0(pkts[i]);

+	if (check_enabled_features) {
+		rte_graph_feature_arc_prefetch(out_feature_arc);
+
+		last_tx_if = IP4_REWRITE_NODE_LAST_TX_IF(node->ctx);
+
+		/* If feature is enabled on last_tx_if, prefetch data
+		 * corresponding to first feature
+		 */
+		if (unlikely(rte_graph_feature_data_first_feature_get(out_feature_arc,
+								      last_tx_if,
+								      &feature_data,
+								      &last_next_index)))
+			rte_graph_feature_arc_feature_data_prefetch(out_feature_arc,
+								    feature_data);
+
+		/* Reset last_tx_if and last_next_index to call feature arc APIs
+		 * for initial packets in every node loop
+		 */
+		last_tx_if = UINT16_MAX;
+		last_next_index = UINT16_MAX;
+	}
+
 	/* Get stream for the speculated next node */
 	to_next = rte_node_next_stream_get(graph, node, next_index, nb_objs);
 	/* Update Ethernet header of pkts */
@@ -79,6 +254,7 @@ ip4_rewrite_node_process(struct rte_graph *graph, struct rte_node *node,

 		pkts += 4;
 		n_left_from -= 4;
+
 		priv01.u64[0] = node_mbuf_priv1(mbuf0, dyn)->u;
 		priv01.u64[1] = node_mbuf_priv1(mbuf1, dyn)->u;
 		priv23.u64[0] = node_mbuf_priv1(mbuf2, dyn)->u;
@@ -133,6 +309,16 @@ ip4_rewrite_node_process(struct rte_graph *graph, struct rte_node *node,
 		ip3->time_to_live = priv23.u16[5] - 1;
 		ip3->hdr_checksum = priv23.u16[6] + priv23.u16[7];

+		/* Once all mbufs are updated with next hop data.
+		 * check if any feature is enabled to override
+		 * next edges
+		 */
+		if (check_enabled_features)
+			check_output_feature_arc_x4(out_feature_arc, &last_tx_if,
+						    mbuf0, mbuf1, mbuf2, mbuf3,
+						    &next0, &next1, &next2, &next3,
+						    &last_next_index, &feature_data, feat_dyn);
+
 		/* Enqueue four to next node */
 		rte_edge_t fix_spec =
 			((next_index == next0) && (next0 == next1) &&
@@ -226,6 +412,11 @@ ip4_rewrite_node_process(struct rte_graph *graph, struct rte_node *node,
 		ip0->hdr_checksum = chksum;
 		ip0->time_to_live = node_mbuf_priv1(mbuf0, dyn)->ttl - 1;

+		if (check_enabled_features)
+			check_output_feature_arc_x1(out_feature_arc, &last_tx_if,
+						    mbuf0, &next0, &last_next_index,
+						    &feature_data, feat_dyn);
+
 		if (unlikely(next_index ^ next0)) {
 			/* Copy things successfully speculated till now */
 			rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
@@ -253,12 +444,47 @@ ip4_rewrite_node_process(struct rte_graph *graph, struct rte_node *node,
 	/* Save the last next used */
 	IP4_REWRITE_NODE_LAST_NEXT(node->ctx) = next_index;

+	if (check_enabled_features)
+		IP4_REWRITE_NODE_LAST_TX_IF(node->ctx) = last_tx_if;
+
 	return nb_objs;
 }

+static uint16_t
+ip4_rewrite_feature_node_process(struct rte_graph *graph, struct rte_node *node,
+				 void **objs, uint16_t nb_objs)
+{
+	const int dyn = IP4_REWRITE_NODE_PRIV1_OFF(node->ctx);
+	const int feat_dyn = IP4_REWRITE_NODE_FEAT_OFF(node->ctx);
+	struct rte_graph_feature_arc *arc = NULL;
+
+	arc = rte_graph_feature_arc_get(IP4_REWRITE_NODE_OUTPUT_FEATURE_ARC(node->ctx));
+	if (unlikely(rte_graph_feature_arc_is_any_feature_enabled(arc) &&
+		     (port_to_next_index_diff > 0)))
+		return __ip4_rewrite_node_process(graph, node, objs, nb_objs, dyn, feat_dyn,
+						  1 /* check features */, arc);
+
+	return __ip4_rewrite_node_process(graph, node, objs, nb_objs, dyn, 0,
+					  0/* don't check features*/,
+					  arc /* don't care*/);
+}
+
+static uint16_t
+ip4_rewrite_node_process(struct rte_graph *graph, struct rte_node *node,
+			 void **objs, uint16_t nb_objs)
+{
+	const int dyn = IP4_REWRITE_NODE_PRIV1_OFF(node->ctx);
+
+	return __ip4_rewrite_node_process(graph, node, objs, nb_objs, dyn, 0,
+					  0/* don't check features*/,
+					  NULL/* don't care */);
+}
+
+
 static int
 ip4_rewrite_node_init(const struct rte_graph *graph, struct rte_node *node)
 {
+	rte_graph_feature_arc_t feature_arc = RTE_GRAPH_FEATURE_ARC_INITIALIZER;
 	static bool init_once;

 	RTE_SET_USED(graph);
@@ -269,9 +495,30 @@ ip4_rewrite_node_init(const struct rte_graph *graph, struct rte_node *node)
 				&node_mbuf_priv1_dynfield_desc);
 		if (node_mbuf_priv1_dynfield_offset < 0)
 			return -rte_errno;
+
+		/* Create ipv4-output feature arc, if not created
+		 */
+		if (rte_graph_feature_arc_lookup_by_name(RTE_IP4_OUTPUT_FEATURE_ARC_NAME,
+						     &feature_arc) < 0) {
+			node_err("ip4_rewrite", "Feature arc \"%s\" not found",
+				 RTE_IP4_OUTPUT_FEATURE_ARC_NAME);
+		} else {
+			node_err("ip4_rewrite", "Feature arc \"%s\" found",
+				 RTE_IP4_OUTPUT_FEATURE_ARC_NAME);
+		}
+
 		init_once = true;
 	}
 	IP4_REWRITE_NODE_PRIV1_OFF(node->ctx) = node_mbuf_priv1_dynfield_offset;
+	IP4_REWRITE_NODE_OUTPUT_FEATURE_ARC(node->ctx) = feature_arc;
+
+	if (rte_graph_feature_arc_get(feature_arc))
+		IP4_REWRITE_NODE_FEAT_OFF(node->ctx) =
+			rte_graph_feature_arc_get(feature_arc)->mbuf_dyn_offset;
+
+	/* By default, set cached next node to pkt_drop */
+	IP4_REWRITE_NODE_LAST_NEXT(node->ctx) = 0;
+	IP4_REWRITE_NODE_LAST_TX_IF(node->ctx) = 0;

 	node_dbg("ip4_rewrite", "Initialized ip4_rewrite node initialized");

@@ -281,6 +528,8 @@ ip4_rewrite_node_init(const struct rte_graph *graph, struct rte_node *node)
 int
 ip4_rewrite_set_next(uint16_t port_id, uint16_t next_index)
 {
+	static int once;
+
 	if (ip4_rewrite_nm == NULL) {
 		ip4_rewrite_nm = rte_zmalloc(
 			"ip4_rewrite", sizeof(struct ip4_rewrite_node_main),
@@ -288,12 +537,15 @@ ip4_rewrite_set_next(uint16_t port_id, uint16_t next_index)
 		if (ip4_rewrite_nm == NULL)
 			return -ENOMEM;
 	}
+	if (!once) {
+		port_to_next_index_diff = next_index - port_id;
+		once = 1;
+	}
 	ip4_rewrite_nm->next_index[port_id] = next_index;

 	return 0;
 }
-
-RTE_EXPORT_SYMBOL(rte_node_ip4_rewrite_add)
+RTE_EXPORT_SYMBOL(rte_node_ip4_rewrite_add);
 int
 rte_node_ip4_rewrite_add(uint16_t next_hop, uint8_t *rewrite_data,
 			 uint8_t rewrite_len, uint16_t dst_port)
@@ -347,3 +599,23 @@ ip4_rewrite_node_get(void)
 }

 RTE_NODE_REGISTER(ip4_rewrite_node);
+
+/* IP4 output arc */
+static struct rte_graph_feature_arc_register ip4_output_arc = {
+	.arc_name = RTE_IP4_OUTPUT_FEATURE_ARC_NAME,
+
+	/* This arc works on all ethdevs */
+	.max_indexes = RTE_IP4_OUTPUT_ARC_INDEXES,
+
+	.start_node = &ip4_rewrite_node,
+
+	/* overwrites start_node->process() function with following only if
+	 * application calls rte_graph_feature_arc_init()
+	 */
+	.start_node_feature_process_fn = ip4_rewrite_feature_node_process,
+
+	/* end feature node of an arc*/
+	.end_feature = &if_tx_feature,
+};
+
+RTE_GRAPH_FEATURE_ARC_REGISTER(ip4_output_arc);
diff --git a/lib/node/meson.build b/lib/node/meson.build
index 0bed97a96c..6a79825b15 100644
--- a/lib/node/meson.build
+++ b/lib/node/meson.build
@@ -24,6 +24,7 @@ sources = files(
         'pkt_cls.c',
         'pkt_drop.c',
         'udp4_input.c',
+        'interface_tx_feature.c',
 )
 headers = files(
         'rte_node_eth_api.h',
diff --git a/lib/node/node_private.h b/lib/node/node_private.h
index 4fafab19be..9488df225c 100644
--- a/lib/node/node_private.h
+++ b/lib/node/node_private.h
@@ -13,6 +13,7 @@
 #include <rte_mbuf_dyn.h>

 #include <rte_graph_worker_common.h>
+#include <rte_graph_feature_arc_worker.h>

 extern int rte_node_logtype;
 #define RTE_LOGTYPE_NODE rte_node_logtype
diff --git a/lib/node/rte_node_ip4_api.h b/lib/node/rte_node_ip4_api.h
index 950751a525..8cfae14b46 100644
--- a/lib/node/rte_node_ip4_api.h
+++ b/lib/node/rte_node_ip4_api.h
@@ -24,6 +24,10 @@
 extern "C" {
 #endif

+/** IP4 output arc */
+#define RTE_IP4_OUTPUT_FEATURE_ARC_NAME "rte_ip4_output_arc"
+#define RTE_IP4_OUTPUT_END_FEATURE_NAME "rte_if_tx_feature"
+
 /**
  * IP4 lookup next nodes.
  */
--
2.43.0

