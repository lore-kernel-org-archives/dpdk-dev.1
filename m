Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7C0F53D7E
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 17:30:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3C5040B94;
	Mon, 16 Mar 2026 18:28:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id DFCB040A73
 for <dev@dpdk.org>; Mon, 16 Mar 2026 18:28:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773682097; x=1805218097;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=BydQEhpYYAkQlPVHiR4zFPL9XkFyyZNYklc2Hd7VHOU=;
 b=WKU//WjhORxJV3xozprmaYCurcfi3DruEc9vvgZt//BKdkVgppZQnrE6
 K1/zkkQ1EJ5UA3KB3fIYbEuu+xY8L+BHhNxtvoWjJ9hMsQMwcQnslHhTM
 bMNXqKIWeUVWN4Jdqfqg5lwQ327sccIEXMTCKgzbkcI1HnSOERg/h6UgR
 Cg1h1qLflcoHerT25fi4rqXzNn2vflvUoPMlgMbqRv3svmFGVQl1kqpjR
 +ROT6wK98nDQTCsQkKCR5wS12DTCulZozGPcuwi1qU+5v4d+meUUJruG7
 YTo/GBHgCHiTu7FFKWrwkfe1Q1M3XRiAK4uEumbhfqLNARTYBMr7BP1DJ g==;
X-CSE-ConnectionGUID: wwbY7G2qTkm2YV1yRaAyig==
X-CSE-MsgGUID: gb2cISoYRIKtUtuMIM7iIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86059653"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="86059653"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 10:28:16 -0700
X-CSE-ConnectionGUID: 1QQzBUfURk+bGvFZkpWdEg==
X-CSE-MsgGUID: qLeoYYt3S7iescLaqffVMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221228268"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 16 Mar 2026 10:28:16 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH v1 15/21] net/i40e: reimplement tunnel QinQ parser
Date: Mon, 16 Mar 2026 17:27:43 +0000
Message-ID: <2fb9f69c4f44e6af1bdad2ecf09fbc4c45f69e01.1773681365.git.anatoly.burakov@intel.com>
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

Use the new flow graph API and the common parsing framework to implement
flow parser for tunnel QinQ filters.

As a result of transitioning to more formalized VLAN validation, some
checks have become more stringent:

- VLAN TCI mask is now required to be fully masked (all-ones); previously
  the mask was only checked for eth_proto and any non-zero vlan_tci mask
  value was silently accepted

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_flow.c        | 132 +--------
 drivers/net/intel/i40e/i40e_flow.h        |   2 +
 drivers/net/intel/i40e/i40e_flow_tunnel.c | 338 ++++++++++++++++++++++
 drivers/net/intel/i40e/meson.build        |   1 +
 4 files changed, 342 insertions(+), 131 deletions(-)
 create mode 100644 drivers/net/intel/i40e/i40e_flow_tunnel.c

diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 44dcb4f5b2..3ca528a1f3 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -33,6 +33,7 @@ const struct ci_flow_engine_list i40e_flow_engine_list = {
 	{
 		&i40e_flow_engine_ethertype,
 		&i40e_flow_engine_fdir,
+		&i40e_flow_engine_tunnel_qinq,
 	}
 };
 
@@ -87,17 +88,6 @@ static int i40e_flow_parse_gtp_filter(struct rte_eth_dev *dev,
 static int i40e_flow_destroy_tunnel_filter(struct i40e_pf *pf,
 					   struct i40e_tunnel_filter *filter);
 static int i40e_flow_flush_tunnel_filter(struct i40e_pf *pf);
-static int
-i40e_flow_parse_qinq_filter(struct rte_eth_dev *dev,
-			      const struct rte_flow_item pattern[],
-			      const struct rte_flow_action actions[],
-			      struct rte_flow_error *error,
-			      struct i40e_filter_ctx *filter);
-static int
-i40e_flow_parse_qinq_pattern(struct rte_eth_dev *dev,
-			      const struct rte_flow_item *pattern,
-			      struct rte_flow_error *error,
-			      struct i40e_tunnel_filter_conf *filter);
 
 static int i40e_flow_parse_l4_cloud_filter(struct rte_eth_dev *dev,
 					   const struct rte_flow_item pattern[],
@@ -291,13 +281,6 @@ static enum rte_flow_item_type pattern_mpls_4[] = {
 	RTE_FLOW_ITEM_TYPE_END,
 };
 
-static enum rte_flow_item_type pattern_qinq_1[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
 static struct i40e_valid_pattern i40e_supported_patterns[] = {
 	/* VXLAN */
 	{ pattern_vxlan_1, i40e_flow_parse_vxlan_filter },
@@ -319,8 +302,6 @@ static struct i40e_valid_pattern i40e_supported_patterns[] = {
 	{ pattern_fdir_ipv4_gtpu, i40e_flow_parse_gtp_filter },
 	{ pattern_fdir_ipv6_gtpc, i40e_flow_parse_gtp_filter },
 	{ pattern_fdir_ipv6_gtpu, i40e_flow_parse_gtp_filter },
-	/* QINQ */
-	{ pattern_qinq_1, i40e_flow_parse_qinq_filter },
 	/* L4 over port */
 	{ pattern_fdir_ipv4_udp, i40e_flow_parse_l4_cloud_filter },
 	{ pattern_fdir_ipv4_tcp, i40e_flow_parse_l4_cloud_filter },
@@ -1586,117 +1567,6 @@ i40e_flow_parse_gtp_filter(struct rte_eth_dev *dev,
 	return ret;
 }
 
-/* 1. Last in item should be NULL as range is not supported.
- * 2. Supported filter types: QINQ.
- * 3. Mask of fields which need to be matched should be
- *    filled with 1.
- * 4. Mask of fields which needn't to be matched should be
- *    filled with 0.
- */
-static int
-i40e_flow_parse_qinq_pattern(__rte_unused struct rte_eth_dev *dev,
-			      const struct rte_flow_item *pattern,
-			      struct rte_flow_error *error,
-			      struct i40e_tunnel_filter_conf *filter)
-{
-	const struct rte_flow_item *item = pattern;
-	const struct rte_flow_item_vlan *vlan_spec = NULL;
-	const struct rte_flow_item_vlan *vlan_mask = NULL;
-	const struct rte_flow_item_vlan *i_vlan_spec = NULL;
-	const struct rte_flow_item_vlan *i_vlan_mask = NULL;
-	const struct rte_flow_item_vlan *o_vlan_spec = NULL;
-	const struct rte_flow_item_vlan *o_vlan_mask = NULL;
-
-	enum rte_flow_item_type item_type;
-	bool vlan_flag = 0;
-
-	for (; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ITEM,
-					   item,
-					   "Not support range");
-			return -rte_errno;
-		}
-		item_type = item->type;
-		switch (item_type) {
-		case RTE_FLOW_ITEM_TYPE_ETH:
-			if (item->spec || item->mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid ETH item");
-				return -rte_errno;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_VLAN:
-			vlan_spec = item->spec;
-			vlan_mask = item->mask;
-
-			if (!(vlan_spec && vlan_mask) ||
-			    vlan_mask->hdr.eth_proto) {
-				rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ITEM,
-					   item,
-					   "Invalid vlan item");
-				return -rte_errno;
-			}
-
-			if (!vlan_flag) {
-				o_vlan_spec = vlan_spec;
-				o_vlan_mask = vlan_mask;
-				vlan_flag = 1;
-			} else {
-				i_vlan_spec = vlan_spec;
-				i_vlan_mask = vlan_mask;
-				vlan_flag = 0;
-			}
-			break;
-
-		default:
-			break;
-		}
-	}
-
-	/* Get filter specification */
-	if (o_vlan_mask != NULL &&  i_vlan_mask != NULL) {
-		filter->outer_vlan = rte_be_to_cpu_16(o_vlan_spec->hdr.vlan_tci);
-		filter->inner_vlan = rte_be_to_cpu_16(i_vlan_spec->hdr.vlan_tci);
-	} else {
-			rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ITEM,
-					   NULL,
-					   "Invalid filter type");
-			return -rte_errno;
-	}
-
-	filter->tunnel_type = I40E_TUNNEL_TYPE_QINQ;
-	return 0;
-}
-
-static int
-i40e_flow_parse_qinq_filter(struct rte_eth_dev *dev,
-			      const struct rte_flow_item pattern[],
-			      const struct rte_flow_action actions[],
-			      struct rte_flow_error *error,
-			      struct i40e_filter_ctx *filter)
-{
-	struct i40e_tunnel_filter_conf *tunnel_filter = &filter->consistent_tunnel_filter;
-	int ret;
-
-	ret = i40e_flow_parse_qinq_pattern(dev, pattern,
-					     error, tunnel_filter);
-	if (ret)
-		return ret;
-
-	ret = i40e_flow_parse_tunnel_action(dev, actions, error, tunnel_filter);
-	if (ret)
-		return ret;
-
-	filter->type = RTE_ETH_FILTER_TUNNEL;
-
-	return ret;
-}
 
 static int
 i40e_flow_check(struct rte_eth_dev *dev,
diff --git a/drivers/net/intel/i40e/i40e_flow.h b/drivers/net/intel/i40e/i40e_flow.h
index e6ad1afdba..c578351eb4 100644
--- a/drivers/net/intel/i40e/i40e_flow.h
+++ b/drivers/net/intel/i40e/i40e_flow.h
@@ -16,11 +16,13 @@ i40e_flow_fdir_get_pctype_value(struct i40e_pf *pf,
 enum i40e_flow_engine_type {
 	I40E_FLOW_ENGINE_TYPE_ETHERTYPE = 0,
 	I40E_FLOW_ENGINE_TYPE_FDIR,
+	I40E_FLOW_ENGINE_TYPE_TUNNEL_QINQ,
 };
 
 extern const struct ci_flow_engine_list i40e_flow_engine_list;
 
 extern const struct ci_flow_engine i40e_flow_engine_ethertype;
 extern const struct ci_flow_engine i40e_flow_engine_fdir;
+extern const struct ci_flow_engine i40e_flow_engine_tunnel_qinq;
 
 #endif /* _I40E_FLOW_H_ */
diff --git a/drivers/net/intel/i40e/i40e_flow_tunnel.c b/drivers/net/intel/i40e/i40e_flow_tunnel.c
new file mode 100644
index 0000000000..621354d6ea
--- /dev/null
+++ b/drivers/net/intel/i40e/i40e_flow_tunnel.c
@@ -0,0 +1,338 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include "i40e_ethdev.h"
+#include "i40e_flow.h"
+
+#include "../common/flow_engine.h"
+#include "../common/flow_check.h"
+#include "../common/flow_util.h"
+
+struct i40e_tunnel_ctx {
+	struct ci_flow_engine_ctx base;
+	struct i40e_tunnel_filter_conf filter;
+};
+
+struct i40e_tunnel_flow {
+	struct rte_flow base;
+	struct i40e_tunnel_filter_conf filter;
+};
+
+/**
+ * QinQ tunnel filter graph implementation
+ * Pattern: START -> ETH -> OUTER_VLAN -> INNER_VLAN -> END
+ */
+enum i40e_tunnel_qinq_node_id {
+	I40E_TUNNEL_QINQ_NODE_START = RTE_FLOW_NODE_FIRST,
+	I40E_TUNNEL_QINQ_NODE_ETH,
+	I40E_TUNNEL_QINQ_NODE_OUTER_VLAN,
+	I40E_TUNNEL_QINQ_NODE_INNER_VLAN,
+	I40E_TUNNEL_QINQ_NODE_END,
+	I40E_TUNNEL_QINQ_NODE_MAX,
+};
+
+static int
+i40e_tunnel_node_vlan_validate(const void *ctx __rte_unused, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_item_vlan *vlan_mask = item->mask;
+
+	/* matching eth proto not supported */
+	if (vlan_mask->hdr.eth_proto) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid VLAN mask");
+	}
+
+	/* VLAN TCI must be fully masked */
+	if (!CI_FIELD_IS_MASKED(&vlan_mask->hdr.vlan_tci)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid VLAN mask");
+	}
+
+	return 0;
+}
+
+/* common VLAN processing for both outer and inner VLAN nodes */
+static int
+i40e_tunnel_node_vlan_process(struct i40e_tunnel_ctx *tunnel_ctx,
+		const struct rte_flow_item *item, bool is_inner)
+{
+	const struct rte_flow_item_vlan *vlan_spec = item->spec;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	/* Store the VLAN ID and set filter flag */
+	if (is_inner) {
+		tunnel_filter->inner_vlan = rte_be_to_cpu_16(vlan_spec->hdr.vlan_tci);
+		tunnel_filter->filter_type |= RTE_ETH_TUNNEL_FILTER_IVLAN;
+	} else {
+		tunnel_filter->outer_vlan = rte_be_to_cpu_16(vlan_spec->hdr.vlan_tci);
+		/* no special flag for outer VLAN matching */
+	}
+
+	return 0;
+}
+
+static int
+i40e_tunnel_node_outer_vlan_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+
+	return i40e_tunnel_node_vlan_process(tunnel_ctx, item, false);
+}
+
+static int
+i40e_tunnel_node_inner_vlan_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+
+	return i40e_tunnel_node_vlan_process(tunnel_ctx, item, true);
+}
+
+static int
+i40e_tunnel_qinq_node_end_process(void *ctx, const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	tunnel_filter->tunnel_type = I40E_TUNNEL_TYPE_QINQ;
+
+	/* QinQ filter is not meant to set this flag */
+	tunnel_filter->filter_type &= ~RTE_ETH_TUNNEL_FILTER_IVLAN;
+
+	return 0;
+}
+
+const struct rte_flow_graph i40e_tunnel_qinq_graph = {
+	.nodes = (struct rte_flow_graph_node[]) {
+		[I40E_TUNNEL_QINQ_NODE_START] = {
+			.name = "START",
+		},
+		[I40E_TUNNEL_QINQ_NODE_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+		},
+		[I40E_TUNNEL_QINQ_NODE_OUTER_VLAN] = {
+			.name = "OUTER_VLAN",
+			.type = RTE_FLOW_ITEM_TYPE_VLAN,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_vlan_validate,
+			.process = i40e_tunnel_node_outer_vlan_process,
+		},
+		[I40E_TUNNEL_QINQ_NODE_INNER_VLAN] = {
+			.name = "INNER_VLAN",
+			.type = RTE_FLOW_ITEM_TYPE_VLAN,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_vlan_validate,
+			.process = i40e_tunnel_node_inner_vlan_process,
+		},
+		[I40E_TUNNEL_QINQ_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+			.process = i40e_tunnel_qinq_node_end_process,
+		},
+	},
+	.edges = (struct rte_flow_graph_edge[]) {
+		[I40E_TUNNEL_QINQ_NODE_START] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_QINQ_NODE_ETH,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_QINQ_NODE_ETH] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_QINQ_NODE_OUTER_VLAN,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_QINQ_NODE_OUTER_VLAN] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_QINQ_NODE_INNER_VLAN,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_QINQ_NODE_INNER_VLAN] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_QINQ_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+static int
+i40e_tunnel_action_check(const struct ci_flow_actions *actions,
+		const struct ci_flow_actions_check_param *param,
+		struct rte_flow_error *error)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(param->driver_ctx);
+	const struct rte_flow_action *first, *second;
+	const struct rte_flow_action_queue *act_q;
+	bool is_to_vf;
+
+	first = actions->actions[0];
+	/* can be NULL */
+	second = actions->actions[1];
+
+	/* first action must be PF or VF */
+	if (first->type == RTE_FLOW_ACTION_TYPE_VF) {
+		const struct rte_flow_action_vf *vf = first->conf;
+		if (vf->id >= pf->vf_num) {
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ACTION, first,
+					"Invalid VF ID for tunnel filter");
+		}
+		is_to_vf = true;
+	} else if (first->type != RTE_FLOW_ACTION_TYPE_PF) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, first,
+				"Unsupported action");
+	}
+
+	/* check if second action is QUEUE */
+	if (second == NULL)
+		return 0;
+
+	if (second->type != RTE_FLOW_ACTION_TYPE_QUEUE) {
+		return rte_flow_error_set(error, EINVAL,
+					  RTE_FLOW_ERROR_TYPE_ACTION, second,
+					  "Unsupported action");
+	}
+
+	act_q = second->conf;
+	/* check queue ID for PF flow */
+	if (!is_to_vf && act_q->index >= pf->dev_data->nb_rx_queues) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, act_q,
+				"Invalid queue ID for tunnel filter");
+	}
+	/* check queue ID for VF flow */
+	if (is_to_vf && act_q->index >= pf->vf_nb_qps) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, act_q,
+				"Invalid queue ID for tunnel filter");
+	}
+
+	return 0;
+}
+
+static int
+i40e_tunnel_ctx_parse(const struct rte_flow_action actions[],
+		const struct rte_flow_attr *attr,
+		struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	struct i40e_tunnel_ctx *tunnel_ctx = (struct i40e_tunnel_ctx *)ctx;
+	struct ci_flow_actions parsed_actions = {0};
+	struct ci_flow_actions_check_param ac_param = {
+		.allowed_types = (enum rte_flow_action_type[]) {
+			RTE_FLOW_ACTION_TYPE_QUEUE,
+			RTE_FLOW_ACTION_TYPE_PF,
+			RTE_FLOW_ACTION_TYPE_VF,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.max_actions = 2,
+		.check = i40e_tunnel_action_check,
+		.driver_ctx = ctx->dev->data->dev_private,
+	};
+	const struct rte_flow_action *first, *second;
+	const struct rte_flow_action_queue *act_q;
+	int ret;
+
+	ret = ci_flow_check_attr(attr, NULL, error);
+	if (ret)
+		return ret;
+
+	ret = ci_flow_check_actions(actions, &ac_param, &parsed_actions, error);
+	if (ret)
+		return ret;
+
+	first = parsed_actions.actions[0];
+	/* can be NULL */
+	second = parsed_actions.actions[1];
+
+	if (first->type == RTE_FLOW_ACTION_TYPE_VF) {
+		const struct rte_flow_action_vf *vf = first->conf;
+		tunnel_ctx->filter.vf_id = vf->id;
+		tunnel_ctx->filter.is_to_vf = 1;
+	} else if (first->type == RTE_FLOW_ACTION_TYPE_PF) {
+		tunnel_ctx->filter.is_to_vf = 0;
+	}
+
+	/* check if second action is QUEUE */
+	if (second == NULL)
+		return 0;
+
+	act_q = second->conf;
+	tunnel_ctx->filter.queue_id = act_q->index;
+
+	return 0;
+}
+
+static int
+i40e_tunnel_ctx_to_flow(const struct ci_flow_engine_ctx *ctx,
+		struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct i40e_tunnel_ctx *tunnel_ctx = (const struct i40e_tunnel_ctx *)ctx;
+	struct i40e_tunnel_flow *tunnel_flow = (struct i40e_tunnel_flow *)flow;
+
+	/* copy filter configuration from context to flow */
+	tunnel_flow->filter = tunnel_ctx->filter;
+
+	return 0;
+}
+
+static int
+i40e_tunnel_flow_install(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(flow->dev->data->dev_private);
+	struct i40e_tunnel_flow *tunnel_flow = (struct i40e_tunnel_flow *)flow;
+	int ret;
+
+	ret = i40e_dev_consistent_tunnel_filter_set(pf, &tunnel_flow->filter, 1);
+	if (ret) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Failed to install tunnel filter");
+	}
+	return 0;
+}
+
+static int
+i40e_tunnel_flow_uninstall(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(flow->dev->data->dev_private);
+	struct i40e_tunnel_flow *tunnel_flow = (struct i40e_tunnel_flow *)flow;
+	int ret;
+
+	ret = i40e_dev_consistent_tunnel_filter_set(pf, &tunnel_flow->filter, 0);
+	if (ret) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Failed to uninstall tunnel filter");
+	}
+	return 0;
+}
+
+const struct ci_flow_engine_ops i40e_flow_engine_tunnel_ops = {
+	.ctx_parse = i40e_tunnel_ctx_parse,
+	.ctx_to_flow = i40e_tunnel_ctx_to_flow,
+	.flow_install = i40e_tunnel_flow_install,
+	.flow_uninstall = i40e_tunnel_flow_uninstall,
+};
+
+const struct ci_flow_engine i40e_flow_engine_tunnel_qinq = {
+	.name = "i40e_tunnel_qinq",
+	.type = I40E_FLOW_ENGINE_TYPE_TUNNEL_QINQ,
+	.ops = &i40e_flow_engine_tunnel_ops,
+	.ctx_size = sizeof(struct i40e_tunnel_ctx),
+	.flow_size = sizeof(struct i40e_tunnel_flow),
+	.graph = &i40e_tunnel_qinq_graph,
+};
diff --git a/drivers/net/intel/i40e/meson.build b/drivers/net/intel/i40e/meson.build
index 0638f873dd..9cff46b5e6 100644
--- a/drivers/net/intel/i40e/meson.build
+++ b/drivers/net/intel/i40e/meson.build
@@ -27,6 +27,7 @@ sources += files(
         'i40e_flow.c',
         'i40e_flow_ethertype.c',
         'i40e_flow_fdir.c',
+        'i40e_flow_tunnel.c',
         'i40e_tm.c',
         'i40e_hash.c',
         'i40e_vf_representor.c',
-- 
2.47.3

