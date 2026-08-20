Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45A9C5DF87
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 14:04:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9BA440E30;
	Thu, 20 Aug 2026 16:02:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 4B23D40DCB
 for <dev@dpdk.org>; Thu, 20 Aug 2026 16:02:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787234534; x=1818770534;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=pS+euHDP0YaJZHRunSWhNHIJQ3gaZyLmmW796c/FZu0=;
 b=iy3wZnMZDbkmL7Dd6Ft+225GnedQaoIlBRdpLfOAyZSMa5HJF3rVwoCo
 3er0mjAyHVylf8Ot8EKGbp82TSYLVmd4mapdOUpyvWAdCrlZ+qiwagxz1
 o9n8j18En2fMWwjxvquYzPNAI3aGHaHUreuOVYEoVm0o+RTzZH0zRMyr3
 ahEPkndT5iN0e3w74j0/4XgMlZO+5HYX/zqG5uHJHuVnMWffkrDevlrVd
 pzI7LvWHOozje8+jMPczjBgzppAjWmyOLYNJ8xMosZHsoHvzh/HXD3Gp4
 7gB/kKfGKCcFpk5Ye/p2SELF/Evu8ZNh31iz6Q36eVEFNI9+tyhGmv/Uv w==;
X-CSE-ConnectionGUID: T5rrcy0wT2mAICBsnD5WIA==
X-CSE-MsgGUID: PTzp7mkyRjmzPRBLJ363gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="75300361"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="75300361"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 07:02:12 -0700
X-CSE-ConnectionGUID: eo64vgSpTfOLJgWpBpProQ==
X-CSE-MsgGUID: PLRO26jsSBGFEorCcRvi2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="264719790"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 20 Aug 2026 07:02:11 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 18/21] net/i40e: reimplement MPLS parser
Date: Thu, 20 Aug 2026 15:01:03 +0100
Message-ID: <aa4332c56d92a1cfc3201d32a137116ad7bc9102.1787233989.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787233986.git.anatoly.burakov@intel.com>
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
flow parser for MPLS tunnels.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_flow.c        | 195 +---------------------
 drivers/net/intel/i40e/i40e_flow.h        |   1 +
 drivers/net/intel/i40e/i40e_flow_tunnel.c | 173 +++++++++++++++++++
 3 files changed, 175 insertions(+), 194 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 99d118e1be..3d94c04872 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -37,6 +37,7 @@ const struct ci_flow_engine_list i40e_flow_engine_list = {
 		&i40e_flow_engine_tunnel_qinq,
 		&i40e_flow_engine_tunnel_vxlan,
 		&i40e_flow_engine_tunnel_nvgre,
+		&i40e_flow_engine_tunnel_mpls,
 	}
 };
 
@@ -67,11 +68,6 @@ static int i40e_flow_parse_tunnel_action(struct rte_eth_dev *dev,
 				 const struct rte_flow_action *actions,
 				 struct rte_flow_error *error,
 				 struct i40e_tunnel_filter_conf *filter);
-static int i40e_flow_parse_mpls_filter(struct rte_eth_dev *dev,
-				       const struct rte_flow_item pattern[],
-				       const struct rte_flow_action actions[],
-				       struct rte_flow_error *error,
-				       struct i40e_filter_ctx *filter);
 static int i40e_flow_parse_gtp_filter(struct rte_eth_dev *dev,
 				      const struct rte_flow_item pattern[],
 				      const struct rte_flow_action actions[],
@@ -169,45 +165,7 @@ static enum rte_flow_item_type pattern_fdir_ipv6_gtpu[] = {
 	RTE_FLOW_ITEM_TYPE_END,
 };
 
-/* Pattern matched tunnel filter */
-static enum rte_flow_item_type pattern_mpls_1[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_MPLS,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_mpls_2[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_MPLS,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_mpls_3[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_GRE,
-	RTE_FLOW_ITEM_TYPE_MPLS,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_mpls_4[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_GRE,
-	RTE_FLOW_ITEM_TYPE_MPLS,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
 static struct i40e_valid_pattern i40e_supported_patterns[] = {
-	/* MPLSoUDP & MPLSoGRE */
-	{ pattern_mpls_1, i40e_flow_parse_mpls_filter },
-	{ pattern_mpls_2, i40e_flow_parse_mpls_filter },
-	{ pattern_mpls_3, i40e_flow_parse_mpls_filter },
-	{ pattern_mpls_4, i40e_flow_parse_mpls_filter },
 	/* GTP-C & GTP-U */
 	{ pattern_fdir_ipv4_gtpc, i40e_flow_parse_gtp_filter },
 	{ pattern_fdir_ipv4_gtpu, i40e_flow_parse_gtp_filter },
@@ -833,157 +791,6 @@ i40e_check_tunnel_filter_type(uint8_t filter_type)
 }
 
 
-/* 1. Last in item should be NULL as range is not supported.
- * 2. Supported filter types: MPLS label.
- * 3. Mask of fields which need to be matched should be
- *    filled with 1.
- * 4. Mask of fields which needn't to be matched should be
- *    filled with 0.
- */
-static int
-i40e_flow_parse_mpls_pattern(__rte_unused struct rte_eth_dev *dev,
-			     const struct rte_flow_item *pattern,
-			     struct rte_flow_error *error,
-			     struct i40e_tunnel_filter_conf *filter)
-{
-	const struct rte_flow_item *item = pattern;
-	const struct rte_flow_item_mpls *mpls_spec;
-	const struct rte_flow_item_mpls *mpls_mask;
-	enum rte_flow_item_type item_type;
-	bool is_mplsoudp = 0; /* 1 - MPLSoUDP, 0 - MPLSoGRE */
-	const uint8_t label_mask[3] = {0xFF, 0xFF, 0xF0};
-	uint32_t label_be = 0;
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
-		case RTE_FLOW_ITEM_TYPE_IPV4:
-			filter->ip_type = I40E_TUNNEL_IPTYPE_IPV4;
-			/* IPv4 is used to describe protocol,
-			 * spec and mask should be NULL.
-			 */
-			if (item->spec || item->mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid IPv4 item");
-				return -rte_errno;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_IPV6:
-			filter->ip_type = I40E_TUNNEL_IPTYPE_IPV6;
-			/* IPv6 is used to describe protocol,
-			 * spec and mask should be NULL.
-			 */
-			if (item->spec || item->mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid IPv6 item");
-				return -rte_errno;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_UDP:
-			/* UDP is used to describe protocol,
-			 * spec and mask should be NULL.
-			 */
-			if (item->spec || item->mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid UDP item");
-				return -rte_errno;
-			}
-			is_mplsoudp = 1;
-			break;
-		case RTE_FLOW_ITEM_TYPE_GRE:
-			/* GRE is used to describe protocol,
-			 * spec and mask should be NULL.
-			 */
-			if (item->spec || item->mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid GRE item");
-				return -rte_errno;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_MPLS:
-			mpls_spec = item->spec;
-			mpls_mask = item->mask;
-
-			if (!mpls_spec || !mpls_mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid MPLS item");
-				return -rte_errno;
-			}
-
-			if (memcmp(mpls_mask->label_tc_s, label_mask, 3)) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid MPLS label mask");
-				return -rte_errno;
-			}
-			memcpy(((uint8_t *)&label_be + 1),
-				   mpls_spec->label_tc_s, 3);
-			filter->tenant_id = rte_be_to_cpu_32(label_be) >> 4;
-			break;
-		default:
-			break;
-		}
-	}
-
-	if (is_mplsoudp)
-		filter->tunnel_type = I40E_TUNNEL_TYPE_MPLSoUDP;
-	else
-		filter->tunnel_type = I40E_TUNNEL_TYPE_MPLSoGRE;
-
-	return 0;
-}
-
-static int
-i40e_flow_parse_mpls_filter(struct rte_eth_dev *dev,
-			    const struct rte_flow_item pattern[],
-			    const struct rte_flow_action actions[],
-			    struct rte_flow_error *error,
-			    struct i40e_filter_ctx *filter)
-{
-	struct i40e_tunnel_filter_conf *tunnel_filter = &filter->consistent_tunnel_filter;
-	int ret;
-
-	ret = i40e_flow_parse_mpls_pattern(dev, pattern,
-					   error, tunnel_filter);
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
-
 /* 1. Last in item should be NULL as range is not supported.
  * 2. Supported filter types: GTP TEID.
  * 3. Mask of fields which need to be matched should be
diff --git a/drivers/net/intel/i40e/i40e_flow.h b/drivers/net/intel/i40e/i40e_flow.h
index 9a206983f1..a32e61ddd6 100644
--- a/drivers/net/intel/i40e/i40e_flow.h
+++ b/drivers/net/intel/i40e/i40e_flow.h
@@ -21,5 +21,6 @@ extern const struct ci_flow_engine i40e_flow_engine_fdir;
 extern const struct ci_flow_engine i40e_flow_engine_tunnel_qinq;
 extern const struct ci_flow_engine i40e_flow_engine_tunnel_vxlan;
 extern const struct ci_flow_engine i40e_flow_engine_tunnel_nvgre;
+extern const struct ci_flow_engine i40e_flow_engine_tunnel_mpls;
 
 #endif /* _I40E_FLOW_H_ */
diff --git a/drivers/net/intel/i40e/i40e_flow_tunnel.c b/drivers/net/intel/i40e/i40e_flow_tunnel.c
index 9b5bd47c0b..22299b4531 100644
--- a/drivers/net/intel/i40e/i40e_flow_tunnel.c
+++ b/drivers/net/intel/i40e/i40e_flow_tunnel.c
@@ -666,6 +666,171 @@ static const struct rte_flow_graph i40e_tunnel_nvgre_graph = {
 	},
 };
 
+/**
+ * MPLS tunnel filter graph implementation
+ * Pattern: START -> ETH -> (IPv4 | IPv6) -> (UDP | GRE) -> MPLS -> END
+ */
+enum i40e_tunnel_mpls_node_id {
+	I40E_TUNNEL_MPLS_NODE_START  = RTE_FLOW_NODE_FIRST,
+	I40E_TUNNEL_MPLS_NODE_ETH,
+	I40E_TUNNEL_MPLS_NODE_IPV4,
+	I40E_TUNNEL_MPLS_NODE_IPV6,
+	I40E_TUNNEL_MPLS_NODE_UDP,
+	I40E_TUNNEL_MPLS_NODE_GRE,
+	I40E_TUNNEL_MPLS_NODE_MPLS,
+	I40E_TUNNEL_MPLS_NODE_END,
+	I40E_TUNNEL_MPLS_NODE_MAX,
+};
+
+static int
+i40e_tunnel_mpls_node_udp_process(void *ctx, const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	tunnel_filter->tunnel_type = I40E_TUNNEL_TYPE_MPLSoUDP;
+
+	return 0;
+}
+
+static int
+i40e_tunnel_mpls_node_gre_process(void *ctx, const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	tunnel_filter->tunnel_type = I40E_TUNNEL_TYPE_MPLSoGRE;
+
+	return 0;
+}
+
+static int
+i40e_tunnel_node_mpls_validate(const void *ctx __rte_unused,
+		const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_item_mpls *mpls_mask = item->mask;
+	const uint8_t label_mask[3] = {0xFF, 0xFF, 0xF0};
+
+	/* MPLS label and TC must be fully masked */
+	if (memcmp(mpls_mask->label_tc_s, label_mask, 3)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid MPLS mask");
+	}
+	return 0;
+}
+
+static int
+i40e_tunnel_node_mpls_process(void *ctx, const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct rte_flow_item_mpls *mpls_spec = item->spec;
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	tunnel_filter->tenant_id = ci_be24_to_cpu(mpls_spec->label_tc_s) >> 4;
+
+	return 0;
+}
+
+static const struct rte_flow_graph i40e_tunnel_mpls_graph = {
+	.nodes = (struct rte_flow_graph_node[]) {
+		[I40E_TUNNEL_MPLS_NODE_START] = {
+			.name = "START",
+		},
+		[I40E_TUNNEL_MPLS_NODE_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+		},
+		[I40E_TUNNEL_MPLS_NODE_IPV4] = {
+			.name = "IPv4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+			.process = i40e_tunnel_node_ipv4_process,
+		},
+		[I40E_TUNNEL_MPLS_NODE_IPV6] = {
+			.name = "IPv6",
+			.type = RTE_FLOW_ITEM_TYPE_IPV6,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+			.process = i40e_tunnel_node_ipv6_process,
+		},
+		[I40E_TUNNEL_MPLS_NODE_UDP] = {
+			.name = "UDP",
+			.type = RTE_FLOW_ITEM_TYPE_UDP,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+			.process = i40e_tunnel_mpls_node_udp_process,
+		},
+		[I40E_TUNNEL_MPLS_NODE_GRE] = {
+			.name = "GRE",
+			.type = RTE_FLOW_ITEM_TYPE_GRE,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+			.process = i40e_tunnel_mpls_node_gre_process,
+		},
+		[I40E_TUNNEL_MPLS_NODE_MPLS] = {
+			.name = "MPLS",
+			.type = RTE_FLOW_ITEM_TYPE_MPLS,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_mpls_validate,
+			.process = i40e_tunnel_node_mpls_process,
+		},
+		[I40E_TUNNEL_MPLS_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	},
+	.edges = (struct rte_flow_graph_edge[]) {
+		[I40E_TUNNEL_MPLS_NODE_START] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_MPLS_NODE_ETH,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_MPLS_NODE_ETH] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_MPLS_NODE_IPV4,
+				I40E_TUNNEL_MPLS_NODE_IPV6,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_MPLS_NODE_IPV4] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_MPLS_NODE_UDP,
+				I40E_TUNNEL_MPLS_NODE_GRE,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_MPLS_NODE_IPV6] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_MPLS_NODE_UDP,
+				I40E_TUNNEL_MPLS_NODE_GRE,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_MPLS_NODE_UDP] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_MPLS_NODE_MPLS,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_MPLS_NODE_GRE] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_MPLS_NODE_MPLS,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_MPLS_NODE_MPLS] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_MPLS_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+	},
+};
+
 static int
 i40e_tunnel_action_check(const struct ci_flow_actions *actions,
 		const struct ci_flow_actions_check_param *param,
@@ -844,6 +1009,14 @@ const struct ci_flow_engine i40e_flow_engine_tunnel_vxlan = {
 	.graph = &i40e_tunnel_vxlan_graph,
 };
 
+const struct ci_flow_engine i40e_flow_engine_tunnel_mpls = {
+	.name = "tunnel_mpls",
+	.ops = &i40e_flow_engine_tunnel_ops,
+	.ctx_size = sizeof(struct i40e_tunnel_ctx),
+	.flow_size = sizeof(struct i40e_tunnel_flow),
+	.graph = &i40e_tunnel_mpls_graph,
+};
+
 const struct ci_flow_engine i40e_flow_engine_tunnel_qinq = {
 	.name = "tunnel_qinq",
 	.ops = &i40e_flow_engine_tunnel_ops,
-- 
2.52.0

