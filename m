Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC657F53D80
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 17:29:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39C5040A70;
	Mon, 16 Mar 2026 18:28:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 567CD40650
 for <dev@dpdk.org>; Mon, 16 Mar 2026 18:28:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773682089; x=1805218089;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=P2pOxFYqxDYfw1dOdEPoM9LPtEV72IccNSL6h+dntgA=;
 b=BObuNAV572Un7nPtPEbuuZEmNTgj8PSPjNRKvs7queZRoy93T/dGiCCv
 N4BVOzeJNYqVD4INaELwZ45g02OOWge9Uoz0ZQJDuTOFlmDaMHNNnQ5dC
 lkiF4FoAdiJyE6tfkWvFQzcxArYaVbOwLSO3k47AYJaNwE7xs+ZLkluvh
 I5p19s+CdTqilVk3vExntu9agkm+KzDQ2GfLaH+uSQuIg/pQM5CxCKACO
 zkLlv4FYQQJnHghyjojDRg7687DufWRW/9QivUPpNBvQWxLs5iBgckFaU
 zcNEj6rZJ3BWvnIczFoMxUqe5JX2NJvalhY+Vx40RhhH0e9fjuF71ysHd Q==;
X-CSE-ConnectionGUID: 2HUTU6mAREmk+QodRON0tQ==
X-CSE-MsgGUID: gj81sYsUSq2bDGOMFnvXmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86059632"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="86059632"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 10:28:09 -0700
X-CSE-ConnectionGUID: FFGoR/ZrScO0mo1laKWifg==
X-CSE-MsgGUID: 89dMj6rkReSZHQow3feu9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221228233"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 16 Mar 2026 10:28:08 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [RFC PATCH v1 09/21] net/ixgbe: reimplement security parser
Date: Mon, 16 Mar 2026 17:27:37 +0000
Message-ID: <a12363ed2b25bb524aec689c5a2ecbb07199ecd4.1773681365.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773681363.git.anatoly.burakov@intel.com>
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

Previously, security parser was a special case, now it is a first class
citizen.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        |   2 -
 drivers/net/intel/ixgbe/ixgbe_flow.c          | 112 +------
 drivers/net/intel/ixgbe/ixgbe_flow.h          |   2 +
 drivers/net/intel/ixgbe/ixgbe_flow_security.c | 297 ++++++++++++++++++
 drivers/net/intel/ixgbe/meson.build           |   1 +
 5 files changed, 301 insertions(+), 113 deletions(-)
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_security.c

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index eaeeb35dea..ccfe23c233 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -348,8 +348,6 @@ struct ixgbe_l2_tn_info {
 struct rte_flow {
 	struct ci_flow flow;
 	enum rte_filter_type filter_type;
-	/* security flows are not rte_filter_type */
-	bool is_security;
 	void *rule;
 };
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index f509b47733..74ddc699fa 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -80,6 +80,7 @@ const struct ci_flow_engine_list ixgbe_flow_engine_list = {
 		&ixgbe_syn_flow_engine,
 		&ixgbe_l2_tunnel_flow_engine,
 		&ixgbe_ntuple_flow_engine,
+		&ixgbe_security_flow_engine,
 	},
 };
 
@@ -157,94 +158,6 @@ ixgbe_flow_actions_check(const struct ci_flow_actions *actions,
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
@@ -1837,15 +1750,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	TAILQ_INSERT_TAIL(&ixgbe_flow_list,
 				ixgbe_flow_mem_ptr, entries);
 
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
@@ -1979,13 +1883,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 
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
@@ -2025,12 +1922,6 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 
 	/* fall back to legacy engines */
 
-	/* Special case for SECURITY flows */
-	if (flow->is_security) {
-		ret = 0;
-		goto free;
-	}
-
 	switch (filter_type) {
 	case RTE_ETH_FILTER_FDIR:
 		fdir_rule_ptr = (struct ixgbe_fdir_rule_ele *)pmd_flow->rule;
@@ -2071,7 +1962,6 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		return ret;
 	}
 
-free:
 	TAILQ_FOREACH(ixgbe_flow_mem_ptr, &ixgbe_flow_list, entries) {
 		if (ixgbe_flow_mem_ptr->flow == pmd_flow) {
 			TAILQ_REMOVE(&ixgbe_flow_list,
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.h b/drivers/net/intel/ixgbe/ixgbe_flow.h
index c1df74c0e7..daff23e227 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.h
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.h
@@ -13,6 +13,7 @@ enum ixgbe_flow_engine_type {
 	IXGBE_FLOW_ENGINE_TYPE_SYN,
 	IXGBE_FLOW_ENGINE_TYPE_L2_TUNNEL,
 	IXGBE_FLOW_ENGINE_TYPE_NTUPLE,
+	IXGBE_FLOW_ENGINE_TYPE_SECURITY,
 };
 
 int
@@ -26,5 +27,6 @@ extern const struct ci_flow_engine ixgbe_ethertype_flow_engine;
 extern const struct ci_flow_engine ixgbe_syn_flow_engine;
 extern const struct ci_flow_engine ixgbe_l2_tunnel_flow_engine;
 extern const struct ci_flow_engine ixgbe_ntuple_flow_engine;
+extern const struct ci_flow_engine ixgbe_security_flow_engine;
 
 #endif /*  _IXGBE_FLOW_H_ */
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow_security.c b/drivers/net/intel/ixgbe/ixgbe_flow_security.c
new file mode 100644
index 0000000000..c22cc394e3
--- /dev/null
+++ b/drivers/net/intel/ixgbe/ixgbe_flow_security.c
@@ -0,0 +1,297 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include <rte_common.h>
+#include <rte_flow.h>
+#include <rte_flow_graph.h>
+#include <rte_ether.h>
+#include <rte_security_driver.h>
+
+#include "ixgbe_ethdev.h"
+#include "ixgbe_flow.h"
+#include "../common/flow_check.h"
+#include "../common/flow_util.h"
+#include "../common/flow_engine.h"
+
+struct ixgbe_security_filter {
+	struct ip_spec spec;
+	struct rte_security_session *session;
+};
+
+struct ixgbe_security_flow {
+	struct rte_flow flow;
+	struct ixgbe_security_filter security;
+};
+
+struct ixgbe_security_ctx {
+	struct ci_flow_engine_ctx base;
+	struct ixgbe_security_filter security;
+};
+
+/**
+ * Ntuple security filter graph implementation
+ * Pattern: START -> IPV4 | IPV6 -> END
+ */
+
+enum ixgbe_security_node_id {
+	IXGBE_SECURITY_NODE_START = RTE_FLOW_NODE_FIRST,
+	IXGBE_SECURITY_NODE_IPV4,
+	IXGBE_SECURITY_NODE_IPV6,
+	IXGBE_SECURITY_NODE_END,
+	IXGBE_SECURITY_NODE_MAX,
+};
+
+static int
+ixgbe_validate_security_ipv4(const void *ctx __rte_unused,
+		const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_item_ipv4 *ipv4_mask = item->mask;
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
+	sec_ctx->security.spec.spec.ipv4 = *ipv4_spec;
+	sec_ctx->security.spec.is_ipv6 = false;
+
+	return 0;
+}
+
+static int
+ixgbe_validate_security_ipv6(const void *ctx __rte_unused,
+			  const struct rte_flow_item *item,
+			  struct rte_flow_error *error)
+{
+	const struct rte_flow_item_ipv6 *ipv6_mask = item->mask;
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
+	sec_ctx->security.spec.spec.ipv6 = *ipv6_spec;
+	sec_ctx->security.spec.is_ipv6 = true;
+
+	return 0;
+}
+
+const struct rte_flow_graph ixgbe_security_graph = {
+	.nodes = (struct rte_flow_graph_node[]) {
+		[IXGBE_SECURITY_NODE_START] = {
+			.name = "START",
+		},
+		[IXGBE_SECURITY_NODE_IPV4] = {
+			.name = "IPV4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = ixgbe_validate_security_ipv4,
+			.process = ixgbe_process_security_ipv4,
+		},
+		[IXGBE_SECURITY_NODE_IPV6] = {
+			.name = "IPV6",
+			.type = RTE_FLOW_ITEM_TYPE_IPV6,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = ixgbe_validate_security_ipv6,
+			.process = ixgbe_process_security_ipv6,
+		},
+		[IXGBE_SECURITY_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	},
+	.edges = (struct rte_flow_graph_edge[]) {
+		[IXGBE_SECURITY_NODE_START] = {
+			.next = (const size_t[]) {
+				IXGBE_SECURITY_NODE_IPV4,
+				IXGBE_SECURITY_NODE_IPV6,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_SECURITY_NODE_IPV4] = {
+			.next = (const size_t[]) {
+				IXGBE_SECURITY_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_SECURITY_NODE_IPV6] = {
+			.next = (const size_t[]) {
+				IXGBE_SECURITY_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+static int
+ixgbe_flow_security_ctx_parse(const struct rte_flow_action *actions,
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
+				RTE_FLOW_ERROR_TYPE_ACTION, &parsed_actions.actions[0],
+				"NULL security session");
+	}
+
+	/* cast away constness since we need to store the session pointer in the context */
+	session = RTE_CAST_PTR(struct rte_security_session *, security->security_session);
+
+	/* verify that the session is of a correct type */
+	ic_session = SECURITY_GET_SESS_PRIV(session);
+	if (ic_session->dev != ctx->dev) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, &parsed_actions.actions[0],
+				"Security session was created for a different device");
+	}
+	if (ic_session->op != IXGBE_OP_AUTHENTICATED_DECRYPTION) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, &parsed_actions.actions[0],
+				"Only authenticated decryption is supported");
+	}
+	sec_ctx->security.session = session;
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
+
+	security_flow->security = security_ctx->security;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_security_flow_install(struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_security_flow *security_flow = (struct ixgbe_security_flow *)flow;
+	struct ixgbe_security_filter *filter = &security_flow->security;
+	int ret;
+
+	ret =  ixgbe_crypto_add_ingress_sa_from_flow(filter->session, &filter->spec);
+	if (ret) {
+		return rte_flow_error_set(error, ret,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Failed to add ingress SA from flow");;
+	}
+	return 0;
+}
+
+static bool
+ixgbe_flow_security_is_available(const struct ci_flow_engine *engine __rte_unused,
+		const struct rte_eth_dev *dev)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+
+	return hw->mac.type == ixgbe_mac_82599EB ||
+			hw->mac.type == ixgbe_mac_X540 ||
+			hw->mac.type == ixgbe_mac_X550 ||
+			hw->mac.type == ixgbe_mac_X550EM_x ||
+			hw->mac.type == ixgbe_mac_X550EM_a ||
+			hw->mac.type == ixgbe_mac_E610;
+}
+
+const struct ci_flow_engine_ops ixgbe_security_ops = {
+	.is_available = ixgbe_flow_security_is_available,
+	.ctx_parse = ixgbe_flow_security_ctx_parse,
+	.ctx_to_flow = ixgbe_flow_security_ctx_to_flow,
+	.flow_install = ixgbe_flow_security_flow_install,
+	/* uninstall is not handled in rte_flow */
+};
+
+const struct ci_flow_engine ixgbe_security_flow_engine = {
+	.name = "ixgbe_security",
+	.ctx_size = sizeof(struct ixgbe_security_ctx),
+	.flow_size = sizeof(struct ixgbe_security_flow),
+	.type = IXGBE_FLOW_ENGINE_TYPE_SECURITY,
+	.ops = &ixgbe_security_ops,
+	.graph = &ixgbe_security_graph,
+};
diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
index f3052daf4f..65ffe19939 100644
--- a/drivers/net/intel/ixgbe/meson.build
+++ b/drivers/net/intel/ixgbe/meson.build
@@ -15,6 +15,7 @@ sources += files(
         'ixgbe_flow_syn.c',
         'ixgbe_flow_l2tun.c',
         'ixgbe_flow_ntuple.c',
+        'ixgbe_flow_security.c',
         'ixgbe_ipsec.c',
         'ixgbe_pf.c',
         'ixgbe_rxtx.c',
-- 
2.47.3

