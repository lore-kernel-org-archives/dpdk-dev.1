Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65632F53D80
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 17:30:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0544040DDC;
	Mon, 16 Mar 2026 18:28:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 3BD8340A87
 for <dev@dpdk.org>; Mon, 16 Mar 2026 18:28:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773682101; x=1805218101;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Z24BBSEuhR8byZlOGII41YdlQV/Yp8/M3OWyeIFHZ5M=;
 b=U4EPSYSzsJzEXvbe25V9x/4N2yS/5U8gVowZZ20WEsMiAxuYPwr1ZwiN
 zpQVhZ3BkUUTjiBFIkMzPd7BB4rVL0u6E3Lh9eUc3jGagsPekv1EH7I3n
 KIkMKn+Y/tSv9lpGt/Kc2+FssQe1gQprFO3wfLkZRB3h2aOb53GKPVwER
 gw/0rrotHqxxVcCgoKo/71hdx+6mEehlMhTEbjuw9s4SKmekafXK2rVqU
 ZvAro59aWvdRpCZq+0wXBEj4UnPelFmBTvUwmbb+W6foNtyja69PZQucc
 2VSm6ndjyaCYTA2gmdQJdxG2Iq/+7nPoYsnXTCt2NJAKHQOH/RCW+HBOS Q==;
X-CSE-ConnectionGUID: IpGPCcfPRYCw5n5bFgOSNw==
X-CSE-MsgGUID: 4c9mRc06TMGXIFUGIMQeAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86059664"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="86059664"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 10:28:20 -0700
X-CSE-ConnectionGUID: IWbF8lxMSEajnwIyc9RFig==
X-CSE-MsgGUID: OligKPs3T9G4z39W1wNMDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221228294"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 16 Mar 2026 10:28:20 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH v1 18/21] net/i40e: reimplement MPLS parser
Date: Mon, 16 Mar 2026 17:27:46 +0000
Message-ID: <feb466988c8680749da68bc1dcf2a0e03f14f5a6.1773681366.git.anatoly.burakov@intel.com>
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
flow parser for MPLS tunnels.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_flow.c        | 195 +---------------------
 drivers/net/intel/i40e/i40e_flow.h        |   2 +
 drivers/net/intel/i40e/i40e_flow_tunnel.c | 174 +++++++++++++++++++
 3 files changed, 177 insertions(+), 194 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index c2c9bec9ce..98a0ecbf3c 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -36,6 +36,7 @@ const struct ci_flow_engine_list i40e_flow_engine_list = {
 		&i40e_flow_engine_tunnel_qinq,
 		&i40e_flow_engine_tunnel_vxlan,
 		&i40e_flow_engine_tunnel_nvgre,
+		&i40e_flow_engine_tunnel_mpls,
 	}
 };
 
@@ -62,11 +63,6 @@ static int i40e_flow_parse_tunnel_action(struct rte_eth_dev *dev,
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
@@ -163,45 +159,7 @@ static enum rte_flow_item_type pattern_fdir_ipv6_gtpu[] = {
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
@@ -703,157 +661,6 @@ i40e_check_tunnel_filter_type(uint8_t filter_type)
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
-			rte_memcpy(((uint8_t *)&label_be + 1),
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
index 161fa76b14..55e6b5dbdd 100644
--- a/drivers/net/intel/i40e/i40e_flow.h
+++ b/drivers/net/intel/i40e/i40e_flow.h
@@ -20,6 +20,7 @@ enum i40e_flow_engine_type {
 	I40E_FLOW_ENGINE_TYPE_TUNNEL_QINQ,
 	I40E_FLOW_ENGINE_TYPE_TUNNEL_VXLAN,
 	I40E_FLOW_ENGINE_TYPE_TUNNEL_NVGRE,
+	I40E_FLOW_ENGINE_TYPE_TUNNEL_MPLS,
 };
 
 extern const struct ci_flow_engine_list i40e_flow_engine_list;
@@ -29,5 +30,6 @@ extern const struct ci_flow_engine i40e_flow_engine_fdir;
 extern const struct ci_flow_engine i40e_flow_engine_tunnel_qinq;
 extern const struct ci_flow_engine i40e_flow_engine_tunnel_vxlan;
 extern const struct ci_flow_engine i40e_flow_engine_tunnel_nvgre;
+extern const struct ci_flow_engine i40e_flow_engine_tunnel_mpls;
 
 #endif /* _I40E_FLOW_H_ */
diff --git a/drivers/net/intel/i40e/i40e_flow_tunnel.c b/drivers/net/intel/i40e/i40e_flow_tunnel.c
index 643272a895..a7184d2d50 100644
--- a/drivers/net/intel/i40e/i40e_flow_tunnel.c
+++ b/drivers/net/intel/i40e/i40e_flow_tunnel.c
@@ -666,6 +666,171 @@ const struct rte_flow_graph i40e_tunnel_nvgre_graph = {
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
+const struct rte_flow_graph i40e_tunnel_mpls_graph = {
+	.nodes = (struct rte_flow_graph_node[]) {
+		[I40E_TUNNEL_MPLS_NODE_START] = {
+			.name = "START",
+		},
+		[I40E_TUNNEL_MPLS_NODE_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+		},
+		[I40E_TUNNEL_NVGRE_NODE_IPV4] = {
+			.name = "IPv4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+			.process = i40e_tunnel_node_ipv4_process,
+		},
+		[I40E_TUNNEL_NVGRE_NODE_IPV6] = {
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
@@ -846,6 +1011,15 @@ const struct ci_flow_engine i40e_flow_engine_tunnel_vxlan = {
 	.graph = &i40e_tunnel_vxlan_graph,
 };
 
+const struct ci_flow_engine i40e_flow_engine_tunnel_mpls = {
+	.name = "i40e_tunnel_mpls",
+	.type = I40E_FLOW_ENGINE_TYPE_TUNNEL_MPLS,
+	.ops = &i40e_flow_engine_tunnel_ops,
+	.ctx_size = sizeof(struct i40e_tunnel_ctx),
+	.flow_size = sizeof(struct i40e_tunnel_flow),
+	.graph = &i40e_tunnel_mpls_graph,
+};
+
 const struct ci_flow_engine i40e_flow_engine_tunnel_qinq = {
 	.name = "i40e_tunnel_qinq",
 	.type = I40E_FLOW_ENGINE_TYPE_TUNNEL_QINQ,
-- 
2.47.3

