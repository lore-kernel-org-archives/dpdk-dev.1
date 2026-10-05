Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A335CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 16:40:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F09AD40E4A;
	Mon,  5 Oct 2026 18:38:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 3C96D409FA
 for <dev@dpdk.org>; Mon,  5 Oct 2026 18:38:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791218332; x=1822754332;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=utx4BBkoo6KeNjWh0dc9IPxMUt9EWk1lXVJukqIpijM=;
 b=F3vXU4sjN1LaP8rjPSxMsOM7gblWrtDsjrf3bJNADUHjw7DJPp+k1SKl
 bJ+mBDKAfnaWj6oyzvMMosMbBUDEKt/JOiksCAMlPNt9Psjmdd4aDwaoa
 PG3VJ2wb7o0PdaQlFiRDgxCatuG19B5cDea5rFME1NUySekgMgwbjrZzL
 3Q1EQ2eZn/uJVaEaEM1tRf9TxrlW5aGQvh/aKpUxAq4A3sSvcSn+r1lsW
 zy8WfcMZqCPTgK1EhvuAl4W0QfaBE4XH7QoHo0KLiE/Gm2peLm1Ie2993
 com9OmqXHe9Q+maq1M1RVijJagT16E2EOeQe6dabAd9hTtdiyIs/W/Jil w==;
X-CSE-ConnectionGUID: 23EVjyNVQQGupqFbxPAPYA==
X-CSE-MsgGUID: EBsUi1UtSLyffVSCtxzZZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="90665321"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="90665321"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 09:38:52 -0700
X-CSE-ConnectionGUID: i11sR3BzRmW+UQDYukpB5Q==
X-CSE-MsgGUID: o0EPkDyrQ7mK7u89aN4kpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="945759"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa011.fm.intel.com with ESMTP; 05 Oct 2026 09:38:51 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 13/24] net/ixgbe: reimplement security parser
Date: Mon,  5 Oct 2026 17:38:08 +0100
Message-ID: <09322d8a8b130293c530b6979385204fe5657c4d.1791218156.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791218154.git.anatoly.burakov@intel.com>
 <cover.1791218154.git.anatoly.burakov@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Use the new flow graph API and common flow engine infrastructure to
implement flow parser for security filter. As a result, flow item checks
have become more stringent:

- Mask is now explicitly validated to not have unsupported items in it,
  when previously they were ignored
- Mask is also validated to mask src/dst addresses, as otherwise it is
  inconsistent with rte_flow API
- The security engine was only looking for IPv4/IPv6 pattern items and
  completely ignored both prefix and suffix. This logic has been replaced
  by allowing [ETH]/IP/[UDP|ESP] patterns, as is used in ipsec-gw app

Previously, security parser was a special case, now it is a first class
citizen. All decryption SA tracking has been moved into the engine, as the
engine is now the authoritative source of new Rx flows and the state of
the Rx SA table (the Tx SA table is still up to IPsec code to manage).

Because IPsec code does not manage the Rx SA table now, a synchronization
mechanism is needed to prevent IPsec code from deallocating a security
session when it is still referenced by security flows, so the security
session is now atomically refcounted. For Tx, the refcount is effectively
a noop, whereas for Rx it is now managed by rte_flow security engine.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        |   2 -
 drivers/net/intel/ixgbe/ixgbe_flow.c          | 120 +---
 drivers/net/intel/ixgbe/ixgbe_flow.h          |   1 +
 drivers/net/intel/ixgbe/ixgbe_flow_security.c | 586 ++++++++++++++++++
 drivers/net/intel/ixgbe/ixgbe_ipsec.c         | 361 +++++------
 drivers/net/intel/ixgbe/ixgbe_ipsec.h         |  50 +-
 drivers/net/intel/ixgbe/meson.build           |   1 +
 7 files changed, 773 insertions(+), 348 deletions(-)
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_security.c

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index daab7fb0d5a..798623e0068 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -313,8 +313,6 @@ struct ixgbe_l2_tn_info {
 struct rte_flow {
 	struct ci_flow flow;
 	enum rte_filter_type filter_type;
-	/* security flows are not rte_filter_type */
-	bool is_security;
 	void *rule;
 };
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 54c87baade5..475f024df9e 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -78,6 +78,7 @@ const struct ci_flow_engine_list ixgbe_flow_engine_list = {
 		&ixgbe_syn_flow_engine,
 		&ixgbe_l2_tunnel_flow_engine,
 		&ixgbe_ntuple_flow_engine,
+		&ixgbe_security_flow_engine,
 	},
 };
 
@@ -155,94 +156,6 @@ ixgbe_flow_actions_check(const struct ci_flow_actions *actions,
  * normally the packets should use network order.
  */
 
-static int
-ixgbe_parse_security_filter(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
-		const struct rte_flow_item pattern[], const struct rte_flow_action actions[],
-		struct rte_flow_error *error)
-{
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	const struct rte_flow_action_security *security;
-	struct rte_security_session *session;
-	const struct rte_flow_item *item;
-	struct ci_flow_actions parsed_actions;
-	struct ci_flow_actions_check_param ap_param = {
-		.allowed_types = (const enum rte_flow_action_type[]){
-			/* only security is allowed here */
-			RTE_FLOW_ACTION_TYPE_SECURITY,
-			RTE_FLOW_ACTION_TYPE_END
-		},
-		.max_actions = 1,
-	};
-	const struct rte_flow_action *action;
-	struct ip_spec spec;
-	int ret;
-
-	if (hw->mac.type != ixgbe_mac_82599EB &&
-			hw->mac.type != ixgbe_mac_X540 &&
-			hw->mac.type != ixgbe_mac_X550 &&
-			hw->mac.type != ixgbe_mac_X550EM_x &&
-			hw->mac.type != ixgbe_mac_X550EM_a &&
-			hw->mac.type != ixgbe_mac_E610)
-		return -ENOTSUP;
-
-	/* validate attributes */
-	ret = ci_flow_check_attr(attr, NULL, error);
-	if (ret)
-		return ret;
-
-	/* parse requested actions */
-	ret = ci_flow_check_actions(actions, &ap_param, &parsed_actions, error);
-	if (ret)
-		return ret;
-
-	action = parsed_actions.actions[0];
-	security = action->conf;
-
-	/* get the IP pattern*/
-	item = next_no_void_pattern(pattern, NULL);
-	while (item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
-			item->type != RTE_FLOW_ITEM_TYPE_IPV6) {
-		if (item->last || item->type == RTE_FLOW_ITEM_TYPE_END) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "IP pattern missing.");
-			return -rte_errno;
-		}
-		item = next_no_void_pattern(pattern, item);
-	}
-	if (item->spec == NULL) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM_SPEC, item,
-				"NULL IP pattern.");
-		return -rte_errno;
-	}
-	spec.is_ipv6 = item->type == RTE_FLOW_ITEM_TYPE_IPV6;
-	if (spec.is_ipv6) {
-		const struct rte_flow_item_ipv6 *ipv6 = item->spec;
-		spec.spec.ipv6 = *ipv6;
-	} else {
-		const struct rte_flow_item_ipv4 *ipv4 = item->spec;
-		spec.spec.ipv4 = *ipv4;
-	}
-
-	/*
-	 * we get pointer to security session from security action, which is
-	 * const. however, we do need to act on the session, so either we do
-	 * some kind of pointer based lookup to get session pointer internally
-	 * (which quickly gets unwieldy for lots of flows case), or we simply
-	 * cast away constness. the latter path was chosen.
-	 */
-	session = RTE_CAST_PTR(struct rte_security_session *, security->security_session);
-	ret = ixgbe_crypto_add_ingress_sa_from_flow(session, &spec);
-	if (ret) {
-		rte_flow_error_set(error, -ret,
-				RTE_FLOW_ERROR_TYPE_ACTION, action,
-				"Failed to add security session.");
-		return -rte_errno;
-	}
-	return 0;
-}
-
 /* search next no void pattern and skip fuzzy */
 static inline
 const struct rte_flow_item *next_no_fuzzy_pattern(
@@ -1909,15 +1822,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	TAILQ_INSERT_TAIL(&adapter->flow_list,
 				&ixgbe_flow_mem_ptr->base, entries);
 
-	/**
-	 *  Special case for flow action type RTE_FLOW_ACTION_TYPE_SECURITY
-	 */
-	ret = ixgbe_parse_security_filter(dev, attr, pattern, actions, error);
-	if (!ret) {
-		flow->is_security = true;
-		return flow;
-	}
-
 	memset(&fdir_rule, 0, sizeof(struct ixgbe_fdir_rule));
 	ret = ixgbe_parse_fdir_filter(dev, attr, pattern,
 				actions, &fdir_rule, error);
@@ -2013,13 +1917,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 
 	/* fall back to legacy engines */
 
-	/**
-	 *  Special case for flow action type RTE_FLOW_ACTION_TYPE_SECURITY
-	 */
-	ret = ixgbe_parse_security_filter(dev, attr, pattern, actions, error);
-	if (!ret)
-		return 0;
-
 	memset(&fdir_rule, 0, sizeof(struct ixgbe_fdir_rule));
 	ret = ixgbe_parse_fdir_filter(dev, attr, pattern,
 				actions, &fdir_rule, error);
@@ -2073,12 +1970,6 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 				"Flow not found for this port");
 	}
 
-	/* Special case for SECURITY flows */
-	if (flow->is_security) {
-		ret = 0;
-		goto free;
-	}
-
 	switch (filter_type) {
 	case RTE_ETH_FILTER_FDIR:
 		fdir_rule_ptr = (struct ixgbe_fdir_rule_ele *)pmd_flow->rule;
@@ -2116,7 +2007,6 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		return ret;
 	}
 
-free:
 	TAILQ_REMOVE(&adapter->flow_list, flow_mem_base, entries);
 	rte_free(flow_mem_base);
 	rte_free(flow);
@@ -2158,9 +2048,6 @@ ixgbe_flow_flush(struct rte_eth_dev *dev,
 static const char *
 ixgbe_flow_rule_engine_name(const struct rte_flow *flow)
 {
-	if (flow->is_security)
-		return "security";
-
 	switch (flow->filter_type) {
 	case RTE_ETH_FILTER_ETHERTYPE:
 		return "ethertype";
@@ -2180,9 +2067,6 @@ ixgbe_flow_rule_engine_name(const struct rte_flow *flow)
 static size_t
 ixgbe_flow_rule_size(const struct rte_flow *flow)
 {
-	if (flow->is_security)
-		return 0;
-
 	switch (flow->filter_type) {
 	case RTE_ETH_FILTER_ETHERTYPE:
 		return sizeof(struct rte_eth_ethertype_filter);
@@ -2202,7 +2086,7 @@ ixgbe_flow_rule_size(const struct rte_flow *flow)
 static const void *
 ixgbe_flow_rule_data(const struct rte_flow *flow)
 {
-	if (flow->is_security || flow->rule == NULL)
+	if (flow->rule == NULL)
 		return NULL;
 
 	return RTE_PTR_ADD(flow->rule, sizeof(struct ixgbe_filter_ele_base));
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.h b/drivers/net/intel/ixgbe/ixgbe_flow.h
index 6f082e9402f..87cf0282454 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.h
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.h
@@ -19,5 +19,6 @@ extern const struct ci_flow_engine ixgbe_ethertype_flow_engine;
 extern const struct ci_flow_engine ixgbe_syn_flow_engine;
 extern const struct ci_flow_engine ixgbe_l2_tunnel_flow_engine;
 extern const struct ci_flow_engine ixgbe_ntuple_flow_engine;
+extern const struct ci_flow_engine ixgbe_security_flow_engine;
 
 #endif /*  _IXGBE_FLOW_H_ */
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow_security.c b/drivers/net/intel/ixgbe/ixgbe_flow_security.c
new file mode 100644
index 00000000000..3ed2ba844b0
--- /dev/null
+++ b/drivers/net/intel/ixgbe/ixgbe_flow_security.c
@@ -0,0 +1,586 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include <rte_common.h>
+#include <rte_flow.h>
+#include <flow_graph.h>
+#include <rte_ether.h>
+#include <rte_security_driver.h>
+
+#include "ixgbe_ethdev.h"
+#include "ixgbe_flow.h"
+#include "../common/flow_check.h"
+#include "../common/flow_util.h"
+#include "../common/flow_engine.h"
+
+struct ixgbe_security_ip_spec {
+	bool is_ipv6;
+	union {
+		struct rte_flow_item_ipv4 ipv4;
+		struct rte_flow_item_ipv6 ipv6;
+	} spec;
+};
+
+struct ixgbe_security_filter {
+	struct rte_security_session *session;
+	struct ixgbe_crypto_rx_sa sa;
+};
+
+struct ixgbe_security_flow {
+	struct rte_flow flow;
+	struct ixgbe_security_filter security;
+};
+
+struct ixgbe_security_ctx {
+	struct ci_flow_engine_ctx base;
+	struct ixgbe_security_ip_spec spec;
+	struct rte_security_session *session;
+};
+
+struct ixgbe_security_ip_slot {
+	ci_usage_count_t use_count;
+	struct ipaddr ip;
+};
+
+struct ixgbe_security_priv {
+	struct ixgbe_security_ip_slot ip_slots[IPSEC_MAX_RX_IP_COUNT];
+	struct ixgbe_security_flow *sa_slots[IPSEC_MAX_SA_COUNT];
+};
+
+/**
+ * Ingress security filter graph implementation
+ * Pattern: START -> [ETH] -> IPV4 | IPV6 -> [ESP | UDP -> ESP] -> END
+ */
+
+enum ixgbe_security_node_id {
+	IXGBE_SECURITY_NODE_START = FLOW_GRAPH_NODE_FIRST,
+	IXGBE_SECURITY_NODE_ETH,
+	IXGBE_SECURITY_NODE_IPV4,
+	IXGBE_SECURITY_NODE_IPV6,
+	IXGBE_SECURITY_NODE_UDP,
+	IXGBE_SECURITY_NODE_ESP,
+	IXGBE_SECURITY_NODE_END,
+	IXGBE_SECURITY_NODE_MAX,
+};
+
+static int
+ixgbe_validate_security_ipv4(const void *ctx __rte_unused,
+		const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_item_ipv4 *ipv4_mask = ci_flow_item_mask(item);
+
+	/* only src/dst addresses are supported */
+	if (ipv4_mask->hdr.version_ihl ||
+	    ipv4_mask->hdr.type_of_service ||
+	    ipv4_mask->hdr.total_length ||
+	    ipv4_mask->hdr.packet_id ||
+	    ipv4_mask->hdr.fragment_offset ||
+	    ipv4_mask->hdr.next_proto_id ||
+	    ipv4_mask->hdr.time_to_live ||
+	    ipv4_mask->hdr.hdr_checksum) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid IPv4 mask");
+	}
+
+	/* both src/dst addresses must be fully masked */
+	if (!CI_FIELD_IS_MASKED(&ipv4_mask->hdr.src_addr) ||
+	    !CI_FIELD_IS_MASKED(&ipv4_mask->hdr.dst_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid IPv4 mask");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_security_ipv4(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_security_ctx *sec_ctx = (struct ixgbe_security_ctx *)ctx;
+	const struct rte_flow_item_ipv4 *ipv4_spec = item->spec;
+
+	/* copy entire spec */
+	sec_ctx->spec.spec.ipv4 = *ipv4_spec;
+	sec_ctx->spec.is_ipv6 = false;
+
+	return 0;
+}
+
+static int
+ixgbe_validate_security_ipv6(const void *ctx __rte_unused,
+			  const struct rte_flow_item *item,
+			  struct rte_flow_error *error)
+{
+	const struct rte_flow_item_ipv6 *ipv6_mask = ci_flow_item_mask(item);
+
+	/* only src/dst addresses are supported */
+	if (ipv6_mask->hdr.vtc_flow ||
+	    ipv6_mask->hdr.payload_len ||
+	    ipv6_mask->hdr.proto ||
+	    ipv6_mask->hdr.hop_limits) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid IPv6 mask");
+	}
+	/* both src/dst addresses must be fully masked */
+	if (!CI_FIELD_IS_MASKED(&ipv6_mask->hdr.src_addr) ||
+	    !CI_FIELD_IS_MASKED(&ipv6_mask->hdr.dst_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid IPv6 mask");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_security_ipv6(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_security_ctx *sec_ctx = (struct ixgbe_security_ctx *)ctx;
+	const struct rte_flow_item_ipv6 *ipv6_spec = item->spec;
+
+	/* copy entire spec */
+	sec_ctx->spec.spec.ipv6 = *ipv6_spec;
+	sec_ctx->spec.is_ipv6 = true;
+
+	return 0;
+}
+
+static const struct flow_graph ixgbe_security_graph = {
+	.nodes = (struct flow_graph_node[]) {
+		[IXGBE_SECURITY_NODE_START] = {
+			.name = "START",
+		},
+		[IXGBE_SECURITY_NODE_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+		},
+		[IXGBE_SECURITY_NODE_IPV4] = {
+			.name = "IPV4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC,
+			.validate = ixgbe_validate_security_ipv4,
+			.process = ixgbe_process_security_ipv4,
+		},
+		[IXGBE_SECURITY_NODE_IPV6] = {
+			.name = "IPV6",
+			.type = RTE_FLOW_ITEM_TYPE_IPV6,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC,
+			.validate = ixgbe_validate_security_ipv6,
+			.process = ixgbe_process_security_ipv6,
+		},
+		[IXGBE_SECURITY_NODE_UDP] = {
+			.name = "UDP",
+			.type = RTE_FLOW_ITEM_TYPE_UDP,
+			/* for backwards compatibility, ignore all contents */
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+				       FLOW_GRAPH_NODE_EXPECT_SPEC,
+		},
+		[IXGBE_SECURITY_NODE_ESP] = {
+			.name = "ESP",
+			.type = RTE_FLOW_ITEM_TYPE_ESP,
+			/* for backwards compatibility, ignore all contents */
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+				       FLOW_GRAPH_NODE_EXPECT_SPEC,
+		},
+		[IXGBE_SECURITY_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	},
+	.edges = (struct flow_graph_edge[]) {
+		[IXGBE_SECURITY_NODE_START] = {
+			.next = (size_t[]) {
+				IXGBE_SECURITY_NODE_ETH,
+				IXGBE_SECURITY_NODE_IPV4,
+				IXGBE_SECURITY_NODE_IPV6,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_SECURITY_NODE_ETH] = {
+			.next = (size_t[]) {
+				IXGBE_SECURITY_NODE_IPV4,
+				IXGBE_SECURITY_NODE_IPV6,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_SECURITY_NODE_IPV4] = {
+			.next = (size_t[]) {
+				IXGBE_SECURITY_NODE_UDP,
+				IXGBE_SECURITY_NODE_ESP,
+				IXGBE_SECURITY_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_SECURITY_NODE_IPV6] = {
+			.next = (size_t[]) {
+				IXGBE_SECURITY_NODE_UDP,
+				IXGBE_SECURITY_NODE_ESP,
+				IXGBE_SECURITY_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_SECURITY_NODE_UDP] = {
+			.next = (size_t[]) {
+				IXGBE_SECURITY_NODE_ESP,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_SECURITY_NODE_ESP] = {
+			.next = (size_t[]) {
+				IXGBE_SECURITY_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+static int
+ixgbe_flow_security_ctx_init(const struct rte_flow_action *actions,
+		const struct rte_flow_attr *attr,
+		struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_security_ctx *sec_ctx = (struct ixgbe_security_ctx *)ctx;
+	struct ci_flow_actions parsed_actions;
+	struct ci_flow_actions_check_param ap_param = {
+		.allowed_types = (const enum rte_flow_action_type[]){
+			/* only security is allowed here */
+			RTE_FLOW_ACTION_TYPE_SECURITY,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.max_actions = 1,
+	};
+	const struct rte_flow_action_security *security;
+	struct rte_security_session *session;
+	const struct ixgbe_crypto_session *ic_session;
+	int ret;
+
+	/* validate attributes */
+	ret = ci_flow_check_attr(attr, NULL, error);
+	if (ret)
+		return ret;
+
+	/* parse requested actions */
+	ret = ci_flow_check_actions(actions, &ap_param, &parsed_actions, error);
+	if (ret)
+		return ret;
+
+	security = (const struct rte_flow_action_security *)parsed_actions.actions[0]->conf;
+
+	if (security->security_session == NULL) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, parsed_actions.actions[0],
+				"NULL security session");
+	}
+
+	/* cast away constness since we need to store the session pointer in the context */
+	session = RTE_CAST_PTR(struct rte_security_session *, security->security_session);
+
+	/* verify that the session is of a correct type */
+	ic_session = SECURITY_GET_SESS_PRIV(session);
+	if (ic_session->dev_data != ctx->dev_data) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, parsed_actions.actions[0],
+				"Security session was created for a different device");
+	}
+	if (ic_session->op != IXGBE_OP_AUTHENTICATED_DECRYPTION) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, parsed_actions.actions[0],
+				"Only authenticated decryption is supported");
+	}
+	sec_ctx->session = session;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_security_ctx_to_flow(const struct ci_flow_engine_ctx *ctx,
+		struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct ixgbe_security_ctx *security_ctx = (const struct ixgbe_security_ctx *)ctx;
+	struct ixgbe_security_flow *security_flow = (struct ixgbe_security_flow *)flow;
+	struct ixgbe_security_filter *filter = &security_flow->security;
+	const struct ixgbe_crypto_session *ic_session;
+
+	filter->session = security_ctx->session;
+	ic_session = SECURITY_GET_SESS_PRIV(filter->session);
+	filter->sa.key = ic_session->key;
+	filter->sa.salt = ic_session->salt;
+	filter->sa.spi = ic_session->spi;
+	filter->sa.mode = IPSRXMOD_VALID | IPSRXMOD_PROTO | IPSRXMOD_DECRYPT;
+	/* slot indices stay out of range until the flow is registered */
+	filter->sa.sa_idx = IPSEC_MAX_SA_COUNT;
+	filter->sa.ip_idx = IPSEC_MAX_RX_IP_COUNT;
+	if (security_ctx->spec.is_ipv6) {
+		filter->sa.dst_ip.type = IPv6;
+		filter->sa.mode |= IPSRXMOD_IPV6;
+		memcpy(filter->sa.dst_ip.ipv6,
+				&security_ctx->spec.spec.ipv6.hdr.dst_addr,
+				sizeof(filter->sa.dst_ip.ipv6));
+	} else {
+		filter->sa.dst_ip.type = IPv4;
+		filter->sa.dst_ip.ipv4 = security_ctx->spec.spec.ipv4.hdr.dst_addr;
+	}
+
+	return 0;
+}
+
+static bool
+ixgbe_security_ip_equal(const struct ipaddr *lhs, const struct ipaddr *rhs)
+{
+	if (lhs->type != rhs->type)
+		return false;
+	if (lhs->type == IPv4)
+		return lhs->ipv4 == rhs->ipv4;
+
+	return memcmp(lhs->ipv6, rhs->ipv6, sizeof(lhs->ipv6)) == 0;
+}
+
+/* two SA filters are the same rule if they match the same SPI and destination IP */
+static bool
+ixgbe_security_sa_key_equal(const struct ixgbe_crypto_rx_sa *lhs,
+		const struct ixgbe_crypto_rx_sa *rhs)
+{
+	return lhs->spi == rhs->spi &&
+			ixgbe_security_ip_equal(&lhs->dst_ip, &rhs->dst_ip);
+}
+
+static int
+ixgbe_security_sa_slot_find(const struct ixgbe_security_priv *priv,
+		const struct ixgbe_security_flow *security_flow)
+{
+	uint32_t free_idx = IPSEC_MAX_SA_COUNT;
+	uint32_t idx;
+
+	for (idx = 0; idx < IPSEC_MAX_SA_COUNT; idx++) {
+		const struct ixgbe_security_flow *registered = priv->sa_slots[idx];
+
+		if (registered == NULL) {
+			if (free_idx == IPSEC_MAX_SA_COUNT)
+				free_idx = idx;
+			continue;
+		}
+		if (ixgbe_security_sa_key_equal(&registered->security.sa,
+				&security_flow->security.sa))
+			return -EEXIST;
+	}
+	if (free_idx == IPSEC_MAX_SA_COUNT)
+		return -ENOSPC;
+
+	return (int)free_idx;
+}
+
+static int
+ixgbe_security_ip_slot_find(const struct ixgbe_security_priv *priv,
+		const struct ipaddr *ip)
+{
+	uint32_t free_idx = IPSEC_MAX_RX_IP_COUNT;
+	uint32_t idx;
+
+	for (idx = 0; idx < IPSEC_MAX_RX_IP_COUNT; idx++) {
+		if (priv->ip_slots[idx].use_count == 0) {
+			if (free_idx == IPSEC_MAX_RX_IP_COUNT)
+				free_idx = idx;
+			continue;
+		}
+		if (ixgbe_security_ip_equal(&priv->ip_slots[idx].ip, ip))
+			return (int)idx;
+	}
+	if (free_idx == IPSEC_MAX_RX_IP_COUNT)
+		return -ENOSPC;
+
+	return (int)free_idx;
+}
+
+static void
+ixgbe_security_ip_slot_get(struct ixgbe_security_priv *priv, uint32_t idx,
+		const struct ipaddr *ip)
+{
+	struct ixgbe_security_ip_slot *slot = &priv->ip_slots[idx];
+
+	if (ci_usage_count_claim(&slot->use_count))
+		slot->ip = *ip;
+}
+
+static void
+ixgbe_security_ip_slot_put(struct ixgbe_security_priv *priv, uint32_t idx)
+{
+	struct ixgbe_security_ip_slot *slot = &priv->ip_slots[idx];
+
+	if (ci_usage_count_release(&slot->use_count))
+		*slot = (struct ixgbe_security_ip_slot){0};
+}
+
+static bool
+ixgbe_security_flow_is_registered(const struct ixgbe_security_flow *security_flow)
+{
+	const struct ixgbe_security_priv *priv = security_flow->flow.flow.engine_priv;
+	const struct ixgbe_crypto_rx_sa *sa = &security_flow->security.sa;
+
+	return sa->ip_idx < IPSEC_MAX_RX_IP_COUNT &&
+			sa->sa_idx < IPSEC_MAX_SA_COUNT &&
+			priv->sa_slots[sa->sa_idx] == security_flow &&
+			priv->ip_slots[sa->ip_idx].use_count != 0 &&
+			ixgbe_security_ip_equal(&priv->ip_slots[sa->ip_idx].ip,
+					&sa->dst_ip);
+}
+
+static int
+ixgbe_flow_security_flow_register(struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_security_flow *security_flow = (struct ixgbe_security_flow *)flow;
+	struct ixgbe_security_priv *priv = flow->engine_priv;
+	struct ixgbe_security_filter *filter = &security_flow->security;
+	int sa_idx, ip_idx, ret;
+
+	sa_idx = ixgbe_security_sa_slot_find(priv, security_flow);
+	if (sa_idx == -EEXIST) {
+		return rte_flow_error_set(error, EEXIST,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Ingress security filter already exists");
+	}
+	if (sa_idx == -ENOSPC) {
+		return rte_flow_error_set(error, ENOSPC,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Ingress security SA table is full");
+	}
+	if (sa_idx < 0) {
+		return rte_flow_error_set(error, -sa_idx,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Failed to reserve ingress security SA slot");
+	}
+
+	ip_idx = ixgbe_security_ip_slot_find(priv, &filter->sa.dst_ip);
+	if (ip_idx == -ENOSPC) {
+		return rte_flow_error_set(error, ENOSPC,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Ingress security IP table is full");
+	}
+	if (ip_idx < 0) {
+		return rte_flow_error_set(error, -ip_idx,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Failed to reserve ingress security IP slot");
+	}
+
+	ret = ixgbe_crypto_session_acquire(filter->session);
+	if (ret != 0) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Failed to acquire ingress security session");
+	}
+
+	/* every resource is acquired by this point, so nothing below may fail */
+	filter->sa.sa_idx = sa_idx;
+	filter->sa.ip_idx = ip_idx;
+	priv->sa_slots[sa_idx] = security_flow;
+	ixgbe_security_ip_slot_get(priv, ip_idx, &filter->sa.dst_ip);
+
+	return 0;
+}
+
+static int
+ixgbe_flow_security_flow_unregister(struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_security_flow *security_flow = (struct ixgbe_security_flow *)flow;
+	struct ixgbe_security_priv *priv = flow->engine_priv;
+	struct ixgbe_security_filter *filter = &security_flow->security;
+	int ret;
+
+	if (!ixgbe_security_flow_is_registered(security_flow)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_HANDLE, flow,
+				"Ingress security flow registration is invalid");
+	}
+	ret = ixgbe_crypto_session_release(filter->session);
+	if (ret != 0) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_HANDLE, flow,
+				"Failed to release ingress security session");
+	}
+
+	priv->sa_slots[filter->sa.sa_idx] = NULL;
+	ixgbe_security_ip_slot_put(priv, filter->sa.ip_idx);
+	return 0;
+}
+
+static int
+ixgbe_flow_security_flow_install(struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_security_flow *security_flow = (struct ixgbe_security_flow *)flow;
+
+	if (!ixgbe_security_flow_is_registered(security_flow)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_HANDLE, flow,
+				"Ingress security flow registration is invalid");
+	}
+
+	ixgbe_crypto_install_rx_sa(flow->dev_data, &security_flow->security.sa);
+	return 0;
+}
+
+static int
+ixgbe_flow_security_flow_uninstall(struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_security_flow *security_flow = (struct ixgbe_security_flow *)flow;
+	struct ixgbe_security_priv *priv = flow->engine_priv;
+	const struct ixgbe_crypto_rx_sa *sa = &security_flow->security.sa;
+
+	if (!ixgbe_security_flow_is_registered(security_flow)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_HANDLE, flow,
+				"Ingress security flow registration is invalid");
+	}
+
+	ixgbe_crypto_uninstall_rx_sa(flow->dev_data, sa,
+			ci_usage_count_is_last(&priv->ip_slots[sa->ip_idx].use_count));
+	return 0;
+}
+
+static int
+ixgbe_flow_security_engine_init(const struct ci_flow_engine *engine __rte_unused,
+		struct rte_eth_dev_data *dev_data,
+		void *priv __rte_unused)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev_data->dev_private);
+
+	if (hw->mac.type == ixgbe_mac_82599EB ||
+			hw->mac.type == ixgbe_mac_X540 ||
+			hw->mac.type == ixgbe_mac_X550 ||
+			hw->mac.type == ixgbe_mac_X550EM_x ||
+			hw->mac.type == ixgbe_mac_X550EM_a ||
+			hw->mac.type == ixgbe_mac_E610)
+		return 0;
+
+	return -ENOTSUP;
+}
+
+static const struct ci_flow_engine_ops ixgbe_security_ops = {
+	.engine_init = ixgbe_flow_security_engine_init,
+	.ctx_init = ixgbe_flow_security_ctx_init,
+	.ctx_to_flow = ixgbe_flow_security_ctx_to_flow,
+	.flow_register = ixgbe_flow_security_flow_register,
+	.flow_unregister = ixgbe_flow_security_flow_unregister,
+	.flow_install = ixgbe_flow_security_flow_install,
+	.flow_uninstall = ixgbe_flow_security_flow_uninstall,
+};
+
+const struct ci_flow_engine ixgbe_security_flow_engine = {
+	.name = "ixgbe_security",
+	.ctx_size = sizeof(struct ixgbe_security_ctx),
+	.flow_size = sizeof(struct ixgbe_security_flow),
+	.priv_size = sizeof(struct ixgbe_security_priv),
+	.ops = &ixgbe_security_ops,
+	.graph = &ixgbe_security_graph,
+};
diff --git a/drivers/net/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
index 3c35326016b..944cb0ff423 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
@@ -30,12 +30,6 @@
 	IXGBE_WRITE_REG_THEN_POLL_MASK(hw, IXGBE_IPSTXIDX, reg_val, \
 	IPSRXIDX_WRITE, IXGBE_REGISTER_POLL_WAIT_5_MS)
 
-#define CMP_IP(a, b) (\
-	(a).ipv6[0] == (b).ipv6[0] && \
-	(a).ipv6[1] == (b).ipv6[1] && \
-	(a).ipv6[2] == (b).ipv6[2] && \
-	(a).ipv6[3] == (b).ipv6[3])
-
 static inline void
 ixgbe_crypto_write_rx_ip(struct ixgbe_hw *hw, uint32_t idx,
 		const struct ipaddr *ip, bool enable)
@@ -137,195 +131,165 @@ ixgbe_crypto_clear_ipsec_tables(struct rte_eth_dev *dev)
 		ixgbe_crypto_write_tx_key(hw, i, key, 0, false);
 	}
 
-	memset(priv->rx_ip_tbl, 0, sizeof(priv->rx_ip_tbl));
-	memset(priv->rx_sa_tbl, 0, sizeof(priv->rx_sa_tbl));
-	memset(priv->tx_sa_tbl, 0, sizeof(priv->tx_sa_tbl));
+	*priv->tx_sa_tbl = (struct ixgbe_crypto_tx_sa_table){0};
+}
+
+void
+ixgbe_crypto_install_rx_sa(struct rte_eth_dev_data *dev_data,
+		const struct ixgbe_crypto_rx_sa *sa)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev_data->dev_private);
+	uint8_t key[16];
+
+	ixgbe_crypto_write_rx_ip(hw, sa->ip_idx, &sa->dst_ip, true);
+	ixgbe_crypto_write_rx_spi(hw, sa->sa_idx, sa->spi, sa->ip_idx, true);
+	memcpy(key, sa->key, sizeof(key));
+	ixgbe_crypto_write_rx_key(hw, sa->sa_idx, (const uint8_t *)key,
+			sa->salt, sa->mode, true);
+	rte_memzero_explicit(key, sizeof(key));
+}
+
+void
+ixgbe_crypto_uninstall_rx_sa(struct rte_eth_dev_data *dev_data,
+		const struct ixgbe_crypto_rx_sa *sa, bool clear_ip)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev_data->dev_private);
+	const uint8_t key[16] = {0};
+
+	ixgbe_crypto_write_rx_spi(hw, sa->sa_idx, 0, 0, false);
+	ixgbe_crypto_write_rx_key(hw, sa->sa_idx, key, 0, 0, false);
+	if (clear_ip) {
+		const struct ipaddr ip = {0};
+
+		ixgbe_crypto_write_rx_ip(hw, sa->ip_idx, &ip, false);
+	}
 }
 
 static int
-ixgbe_crypto_add_sa(struct ixgbe_crypto_session *ic_session)
+ixgbe_crypto_add_tx_sa(struct ixgbe_crypto_session *ic_session)
 {
 	struct rte_eth_dev_data *dev_data = ic_session->dev_data;
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev_data->dev_private);
 	struct ixgbe_ipsec *priv = IXGBE_DEV_PRIVATE_TO_IPSEC(dev_data->dev_private);
-	int i, sa_index = -1;
-	uint8_t key[16] = {0};
-
-	if (ic_session->op == IXGBE_OP_AUTHENTICATED_DECRYPTION) {
-		struct ixgbe_crypto_rx_ip_table *rxip;
-		struct ixgbe_crypto_rx_sa_table *rxsa;
-		int ip_index = -1, free_index = -1;
-
-		/* Find a match in the IP table*/
-		for (i = 0; i < IPSEC_MAX_RX_IP_COUNT; i++) {
-			if (CMP_IP(priv->rx_ip_tbl[i].ip,
-				   ic_session->dst_ip)) {
-				ip_index = i;
-				break;
-			}
-			if (free_index == -1 && priv->rx_ip_tbl[i].ref_count == 0)
-				free_index = i;
-		}
-		/* If no match, find a free entry in the IP table*/
-		if (ip_index < 0)
-			ip_index = free_index;
-
-		/* Fail if no match and no free entries*/
-		if (ip_index < 0) {
-			PMD_DRV_LOG(ERR, "No free entry left in the Rx IP table");
-			return -ENOSPC;
-		}
-		rxip = &priv->rx_ip_tbl[ip_index];
-
-		/* Find a free entry in the SA table*/
-		for (i = 0; i < IPSEC_MAX_SA_COUNT; i++) {
-			if (priv->rx_sa_tbl[i].used == 0) {
-				sa_index = i;
-				break;
-			}
-		}
-		/* Fail if no free entries*/
-		if (sa_index < 0) {
-			PMD_DRV_LOG(ERR, "No free entry left in the Rx SA table");
-			return -ENOSPC;
-		}
-		rxsa = &priv->rx_sa_tbl[sa_index];
-
-		rxip->ref_count++;
-		memcpy(&rxip->ip, &ic_session->dst_ip, sizeof(rxip->ip));
-
-		rxsa->spi = ic_session->spi;
-		rxsa->ip_index = ip_index;
-		rxsa->mode = IPSRXMOD_VALID | IPSRXMOD_PROTO | IPSRXMOD_DECRYPT;
-		if (ic_session->dst_ip.type == IPv6)
-			rxsa->mode |= IPSRXMOD_IPV6;
-
-		rxsa->used = 1;
-
-		/* write IP table entry*/
-		ixgbe_crypto_write_rx_ip(hw, ip_index, &rxip->ip, true);
-
-		/* write SPI table entry*/
-		ixgbe_crypto_write_rx_spi(hw, sa_index, rxsa->spi, ip_index, true);
-
-		/* write Key table entry*/
-		memcpy(key, ic_session->key, ic_session->key_len);
-
-		ixgbe_crypto_write_rx_key(hw, sa_index, key,
-				ic_session->salt, rxsa->mode, true);
-
-		rte_memzero_explicit(key, sizeof(key));
-
-	} else { /* sess->dir == RTE_CRYPTO_OUTBOUND */
-		struct ixgbe_crypto_tx_sa_table *txsa;
-
-		/* Find a free entry in the SA table*/
-		for (i = 0; i < IPSEC_MAX_SA_COUNT; i++) {
-			if (priv->tx_sa_tbl[i].used == 0) {
-				sa_index = i;
-				break;
-			}
+	struct ixgbe_crypto_tx_sa_table *txsa;
+	uint8_t key[16];
+	int sa_index = -1;
+	int i;
+
+	for (i = 0; i < IPSEC_MAX_SA_COUNT; i++) {
+		if (priv->tx_sa_tbl[i].used == 0) {
+			sa_index = i;
+			break;
 		}
-		/* Fail if no free entries*/
-		if (sa_index < 0) {
-			PMD_DRV_LOG(ERR, "No free entry left in the Tx SA table");
-			return -ENOSPC;
-		}
-		txsa = &priv->tx_sa_tbl[sa_index];
-
-		txsa->spi = ic_session->spi;
-		txsa->used = 1;
-		ic_session->sa_index = sa_index;
-
-		memcpy(key, ic_session->key, ic_session->key_len);
-
-		/* write Key table entry*/
-		ixgbe_crypto_write_tx_key(hw, sa_index, key, ic_session->salt, true);
-
-		rte_memzero_explicit(key, sizeof(key));
 	}
+	if (sa_index < 0) {
+		PMD_DRV_LOG(ERR, "No free entry left in the Tx SA table");
+		return -ENOSPC;
+	}
+	txsa = &priv->tx_sa_tbl[sa_index];
+	txsa->spi = ic_session->spi;
+	txsa->used = 1;
+	ic_session->sa_index = sa_index;
+
+	memcpy(key, ic_session->key, ic_session->key_len);
+	ixgbe_crypto_write_tx_key(hw, sa_index, (const uint8_t *)key,
+			ic_session->salt, true);
+	rte_memzero_explicit(key, sizeof(key));
 
 	return 0;
 }
 
 static int
-ixgbe_crypto_remove_sa(struct ixgbe_crypto_session *ic_session)
+ixgbe_crypto_remove_tx_sa(struct ixgbe_crypto_session *ic_session)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(ic_session->dev_data->dev_private);
 	struct ixgbe_ipsec *priv =
 			IXGBE_DEV_PRIVATE_TO_IPSEC(ic_session->dev_data->dev_private);
+	struct ixgbe_crypto_tx_sa_table *txsa;
 	const uint8_t key[16] = {0};
-	int i, sa_index = -1;
 
-	if (ic_session->op == IXGBE_OP_AUTHENTICATED_DECRYPTION) {
-		struct ixgbe_crypto_rx_ip_table *rxip;
-		struct ixgbe_crypto_rx_sa_table *rxsa;
-		int ip_index = -1;
+	if (ic_session->sa_index >= IPSEC_MAX_SA_COUNT)
+		return -ENOENT;
+	txsa = &priv->tx_sa_tbl[ic_session->sa_index];
+	if (txsa->used == 0 || txsa->spi != ic_session->spi)
+		return -ENOENT;
 
-		/* Find a match in the IP table*/
-		for (i = 0; i < IPSEC_MAX_RX_IP_COUNT; i++) {
-			if (CMP_IP(priv->rx_ip_tbl[i].ip, ic_session->dst_ip)) {
-				ip_index = i;
-				break;
-			}
-		}
+	ixgbe_crypto_write_tx_key(hw, ic_session->sa_index, key, 0, false);
+	*txsa = (struct ixgbe_crypto_tx_sa_table){0};
 
-		/* Fail if no match*/
-		if (ip_index < 0) {
-			PMD_DRV_LOG(ERR, "Entry not found in the Rx IP table");
-			return -ENOENT;
-		}
-		rxip = &priv->rx_ip_tbl[ip_index];
+	return 0;
+}
 
-		/* Find a free entry in the SA table*/
-		for (i = 0; i < IPSEC_MAX_SA_COUNT; i++) {
-			if (priv->rx_sa_tbl[i].spi == ic_session->spi) {
-				sa_index = i;
-				break;
-			}
-		}
-		/* Fail if no match*/
-		if (sa_index < 0) {
-			PMD_DRV_LOG(ERR, "Entry not found in the Rx SA table");
-			return -ENOENT;
-		}
-		rxsa = &priv->rx_sa_tbl[sa_index];
+static int
+ixgbe_crypto_session_state_acquire(struct ixgbe_crypto_session *ic_session)
+{
+	uint16_t expected;
 
-		/* Disable and clear Rx SPI and key table entries*/
-		ixgbe_crypto_write_rx_spi(hw, sa_index, 0, 0, false);
-		ixgbe_crypto_write_rx_key(hw, sa_index, key, 0, 0, false);
-
-		/* Clear the SA table entry*/
-		*rxsa = (struct ixgbe_crypto_rx_sa_table){0};
+	expected = rte_atomic_load_explicit(&ic_session->refcnt,
+			rte_memory_order_acquire);
+	while (expected != IXGBE_SECURITY_SESSION_DESTROYING) {
+		if (expected >= IXGBE_SECURITY_SESSION_REFCNT_MAX)
+			return -ENOSPC;
+		if (rte_atomic_compare_exchange_strong_explicit(&ic_session->refcnt,
+				&expected, expected + 1,
+				rte_memory_order_acq_rel, rte_memory_order_acquire))
+			return 0;
+	}
 
-		/* If last used then clear the IP table entry*/
-		rxip->ref_count--;
-		if (rxip->ref_count == 0) {
-			const struct ipaddr ip = {0};
-			ixgbe_crypto_write_rx_ip(hw, ip_index, &ip, false);
-			*rxip = (struct ixgbe_crypto_rx_ip_table){0};
-		}
-	} else { /* session->dir == RTE_CRYPTO_OUTBOUND */
-		struct ixgbe_crypto_tx_sa_table *txsa;
+	return -EBUSY;
+}
 
-		/* Find a match in the SA table*/
-		for (i = 0; i < IPSEC_MAX_SA_COUNT; i++) {
-			if (priv->tx_sa_tbl[i].spi == ic_session->spi) {
-				sa_index = i;
-				break;
-			}
-		}
-		/* Fail if no match entries*/
-		if (sa_index < 0) {
-			PMD_DRV_LOG(ERR, "Entry not found in the Tx SA table");
-			return -ENOENT;
-		}
-		txsa = &priv->tx_sa_tbl[sa_index];
+static int
+ixgbe_crypto_session_state_release(struct ixgbe_crypto_session *ic_session)
+{
+	uint16_t expected;
 
-		ixgbe_crypto_write_tx_key(hw, sa_index, key, 0, false);
-		*txsa = (struct ixgbe_crypto_tx_sa_table){0};
+	expected = rte_atomic_load_explicit(&ic_session->refcnt,
+			rte_memory_order_acquire);
+	while (expected != IXGBE_SECURITY_SESSION_DESTROYING) {
+		if (expected == IXGBE_SECURITY_SESSION_UNBOUND)
+			return -EINVAL;
+		if (rte_atomic_compare_exchange_strong_explicit(&ic_session->refcnt,
+				&expected, expected - 1,
+				rte_memory_order_release, rte_memory_order_relaxed))
+			return 0;
 	}
 
+	return -EINVAL;
+}
+
+int
+ixgbe_crypto_session_acquire(struct rte_security_session *session)
+{
+	struct ixgbe_crypto_session *ic_session = SECURITY_GET_SESS_PRIV(session);
+
+	return ixgbe_crypto_session_state_acquire(ic_session);
+}
+
+int
+ixgbe_crypto_session_release(struct rte_security_session *session)
+{
+	struct ixgbe_crypto_session *ic_session = SECURITY_GET_SESS_PRIV(session);
+
+	return ixgbe_crypto_session_state_release(ic_session);
+}
+
+static int
+ixgbe_crypto_session_disable(struct rte_security_session *session)
+{
+	struct ixgbe_crypto_session *ic_session = SECURITY_GET_SESS_PRIV(session);
+	uint16_t expected;
+
+	/*
+	 * Rx sessions must have no flow references before removal. Tx sessions
+	 * retain the reference acquired when their SA was allocated.
+	 */
+	expected = ic_session->op == IXGBE_OP_AUTHENTICATED_DECRYPTION ?
+			IXGBE_SECURITY_SESSION_UNBOUND : 1;
+	if (!rte_atomic_compare_exchange_strong_explicit(&ic_session->refcnt,
+			&expected, IXGBE_SECURITY_SESSION_DESTROYING,
+			rte_memory_order_acq_rel, rte_memory_order_acquire))
+		return -EBUSY;
 	return 0;
 }
 
@@ -338,6 +302,7 @@ ixgbe_crypto_create_session(void *device,
 	struct ixgbe_crypto_session *ic_session = SECURITY_GET_SESS_PRIV(session);
 	struct rte_crypto_aead_xform *aead_xform;
 	struct rte_eth_conf *dev_conf = &eth_dev->data->dev_conf;
+	int ret;
 
 	if (conf->crypto_xform->type != RTE_CRYPTO_SYM_XFORM_AEAD ||
 			conf->crypto_xform->aead.algo !=
@@ -369,18 +334,30 @@ ixgbe_crypto_create_session(void *device,
 		}
 	}
 
-	ic_session->key = aead_xform->key.data;
+	memcpy(ic_session->key, aead_xform->key.data, sizeof(ic_session->key));
 	ic_session->key_len = aead_xform->key.length;
 	memcpy(&ic_session->salt,
 	       &aead_xform->key.data[aead_xform->key.length], 4);
 	ic_session->spi = conf->ipsec.spi;
 	ic_session->dev_data = eth_dev->data;
 
+	rte_atomic_store_explicit(&ic_session->refcnt,
+			IXGBE_SECURITY_SESSION_UNBOUND,
+			rte_memory_order_relaxed);
+
+	/* only handle tx, as rx sessions are created by rte_flow */
 	if (ic_session->op == IXGBE_OP_AUTHENTICATED_ENCRYPTION) {
-		if (ixgbe_crypto_add_sa(ic_session)) {
+		if (ixgbe_crypto_add_tx_sa(ic_session)) {
 			PMD_DRV_LOG(ERR, "Failed to add SA");
+			rte_memzero_explicit(ic_session, sizeof(*ic_session));
 			return -EPERM;
 		}
+		ret = ixgbe_crypto_session_state_acquire(ic_session);
+		if (ret != 0) {
+			ixgbe_crypto_remove_tx_sa(ic_session);
+			rte_memzero_explicit(ic_session, sizeof(*ic_session));
+			return ret;
+		}
 	}
 
 	return 0;
@@ -398,18 +375,30 @@ ixgbe_crypto_remove_session(void *device,
 {
 	struct rte_eth_dev *eth_dev = device;
 	struct ixgbe_crypto_session *ic_session = SECURITY_GET_SESS_PRIV(session);
+	int ret;
 
 	if (eth_dev->data != ic_session->dev_data) {
 		PMD_DRV_LOG(ERR, "Session not bound to this device");
 		return -ENODEV;
 	}
 
-	if (ixgbe_crypto_remove_sa(ic_session)) {
-		PMD_DRV_LOG(ERR, "Failed to remove session");
-		return -EFAULT;
+	if (ixgbe_crypto_session_disable(session) < 0) {
+		PMD_DRV_LOG(ERR, "Session is still in use");
+		return -EBUSY;
 	}
 
-	memset(ic_session, 0, sizeof(struct ixgbe_crypto_session));
+	if (ic_session->op == IXGBE_OP_AUTHENTICATED_ENCRYPTION) {
+		ret = ixgbe_crypto_remove_tx_sa(ic_session);
+		if (ret != 0) {
+			PMD_DRV_LOG(ERR, "Failed to remove session");
+			/* set refcnt back to 1 to re-enable the session */
+			rte_atomic_store_explicit(&ic_session->refcnt, 1,
+					rte_memory_order_release);
+			return ret;
+		}
+	}
+
+	rte_memzero_explicit(ic_session, sizeof(*ic_session));
 	return 0;
 }
 
@@ -632,34 +621,6 @@ ixgbe_crypto_enable_ipsec(struct rte_eth_dev *dev)
 	return 0;
 }
 
-int
-ixgbe_crypto_add_ingress_sa_from_flow(struct rte_security_session *sess,
-		const struct ip_spec *spec)
-{
-	struct ixgbe_crypto_session *ic_session = SECURITY_GET_SESS_PRIV(sess);
-
-	if (ic_session->op == IXGBE_OP_AUTHENTICATED_DECRYPTION) {
-		if (spec->is_ipv6) {
-			const struct rte_flow_item_ipv6 *ipv6 = &spec->spec.ipv6;
-			ic_session->src_ip.type = IPv6;
-			ic_session->dst_ip.type = IPv6;
-			memcpy(ic_session->src_ip.ipv6,
-				   &ipv6->hdr.src_addr, 16);
-			memcpy(ic_session->dst_ip.ipv6,
-				   &ipv6->hdr.dst_addr, 16);
-		} else {
-			const struct rte_flow_item_ipv4 *ipv4 = &spec->spec.ipv4;
-			ic_session->src_ip.type = IPv4;
-			ic_session->dst_ip.type = IPv4;
-			ic_session->src_ip.ipv4 = ipv4->hdr.src_addr;
-			ic_session->dst_ip.ipv4 = ipv4->hdr.dst_addr;
-		}
-		return ixgbe_crypto_add_sa(ic_session);
-	}
-
-	return 0;
-}
-
 static struct rte_security_ops ixgbe_security_ops = {
 	.session_create = ixgbe_crypto_create_session,
 	.session_update = NULL,
diff --git a/drivers/net/intel/ixgbe/ixgbe_ipsec.h b/drivers/net/intel/ixgbe/ixgbe_ipsec.h
index 1099b5f598b..a872a64788b 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ipsec.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ipsec.h
@@ -8,6 +8,7 @@
 #include <ethdev_driver.h>
 #include <rte_security.h>
 #include <rte_security_driver.h>
+#include <rte_stdatomic.h>
 
 #include <rte_flow.h>
 
@@ -33,6 +34,9 @@
 
 #define IPSEC_MAX_RX_IP_COUNT           128
 #define IPSEC_MAX_SA_COUNT              1024
+#define IXGBE_SECURITY_SESSION_UNBOUND  0
+#define IXGBE_SECURITY_SESSION_REFCNT_MAX IPSEC_MAX_SA_COUNT
+#define IXGBE_SECURITY_SESSION_DESTROYING UINT16_MAX
 
 #define ESP_ICV_SIZE 16
 #define ESP_TRAILER_SIZE 2
@@ -67,32 +71,30 @@ struct ipaddr {
 /** inline crypto crypto private session structure */
 struct __rte_cache_aligned ixgbe_crypto_session {
 	enum ixgbe_operation op;
-	const uint8_t *key;
+	RTE_ATOMIC(uint16_t) refcnt;
+	uint8_t key[16];
 	uint32_t key_len;
 	uint32_t salt;
 	uint32_t sa_index;
 	uint32_t spi;
-	struct ipaddr src_ip;
-	struct ipaddr dst_ip;
 	struct rte_eth_dev_data *dev_data;
 };
 
-struct ixgbe_crypto_rx_ip_table {
-	struct ipaddr ip;
-	uint16_t ref_count;
-};
-struct ixgbe_crypto_rx_sa_table {
-	uint32_t spi;
-	uint32_t ip_index;
-	uint8_t  mode;
-	uint8_t  used;
-};
-
 struct ixgbe_crypto_tx_sa_table {
 	uint32_t spi;
 	uint8_t  used;
 };
 
+struct ixgbe_crypto_rx_sa {
+	struct ipaddr dst_ip;
+	const uint8_t *key;
+	uint32_t salt;
+	uint32_t spi;
+	uint32_t mode;
+	uint32_t ip_idx;
+	uint32_t sa_idx;
+};
+
 union ixgbe_crypto_tx_desc_md {
 	uint64_t data;
 	struct {
@@ -106,25 +108,17 @@ union ixgbe_crypto_tx_desc_md {
 };
 
 struct ixgbe_ipsec {
-	struct ixgbe_crypto_rx_ip_table rx_ip_tbl[IPSEC_MAX_RX_IP_COUNT];
-	struct ixgbe_crypto_rx_sa_table rx_sa_tbl[IPSEC_MAX_SA_COUNT];
 	struct ixgbe_crypto_tx_sa_table tx_sa_tbl[IPSEC_MAX_SA_COUNT];
 };
 
 
 int ixgbe_ipsec_ctx_create(struct rte_eth_dev *dev);
 int ixgbe_crypto_enable_ipsec(struct rte_eth_dev *dev);
-
-struct ip_spec {
-	bool is_ipv6;
-	union {
-		struct rte_flow_item_ipv4 ipv4;
-		struct rte_flow_item_ipv6 ipv6;
-	} spec;
-};
-int ixgbe_crypto_add_ingress_sa_from_flow(struct rte_security_session *sess,
-		const struct ip_spec *ip_spec);
-
-
+void ixgbe_crypto_install_rx_sa(struct rte_eth_dev_data *dev_data,
+		const struct ixgbe_crypto_rx_sa *sa);
+void ixgbe_crypto_uninstall_rx_sa(struct rte_eth_dev_data *dev_data,
+		const struct ixgbe_crypto_rx_sa *sa, bool clear_ip);
+int ixgbe_crypto_session_acquire(struct rte_security_session *session);
+int ixgbe_crypto_session_release(struct rte_security_session *session);
 
 #endif /*IXGBE_IPSEC_H_*/
diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
index 90cc88f0027..12ba639b702 100644
--- a/drivers/net/intel/ixgbe/meson.build
+++ b/drivers/net/intel/ixgbe/meson.build
@@ -30,6 +30,7 @@ sources += files(
         'ixgbe_flow_syn.c',
         'ixgbe_flow_l2tun.c',
         'ixgbe_flow_ntuple.c',
+        'ixgbe_flow_security.c',
         'ixgbe_ipsec.c',
         'ixgbe_pf.c',
         'ixgbe_rxtx.c',
-- 
2.52.0

