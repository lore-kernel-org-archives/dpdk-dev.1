Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188AFC5DF87
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 14:04:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F15F640E43;
	Thu, 20 Aug 2026 16:02:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id BE5B840DCB
 for <dev@dpdk.org>; Thu, 20 Aug 2026 16:02:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787234535; x=1818770535;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=WK87xJcOOULqcG2IAcY7ABycVo+KNYeYw3pFJXwtFqc=;
 b=NEUZgo1SZVrjnhVWQTXHwj/DLT0X+4CvWuDJEaWBEXl1YP8z32EjC0uO
 9OmCLiQMtV08F4MSir1MlG1B/eTUYmMUVVZuEqxK/DxdT5PKEq++uLO1J
 IT8agGYXH0l1lHN9u9Xr6I6gcrGfXZujLgqMXWc31n81Rspl2bmdZ3yH/
 wkIN3ukof6uYTT9aQ6JjUJYX1XuH5fjn53t/QYSNHDETkwX/EFDdjIW+/
 Sil2UqkS17U6oTojbdU6cnUHNl500Z9No9zOTPCItfAobdxwSwJov5deq
 ZNnYum69GWGaOtmnj8dnCXaBApqJtUoGF+A2VNqk1QJoHZOgc2ScEH22B w==;
X-CSE-ConnectionGUID: oe56wrHfTre91Ku87VvE2A==
X-CSE-MsgGUID: q97L/uz3QmGDgpfhw2JdJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="75300367"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="75300367"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 07:02:14 -0700
X-CSE-ConnectionGUID: bzGQSESeQ06WqIK+MQQRyQ==
X-CSE-MsgGUID: viMbk2s/SD2DpfEgQ11FGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="264719798"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 20 Aug 2026 07:02:13 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 19/21] net/i40e: reimplement gtp parser
Date: Thu, 20 Aug 2026 15:01:04 +0100
Message-ID: <15e3da6a3e872d92b8b3e4d6a4bceb4b3e184e54.1787233989.git.anatoly.burakov@intel.com>
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
flow parser for GTP tunnels.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_flow.c        | 191 +---------------------
 drivers/net/intel/i40e/i40e_flow.h        |   1 +
 drivers/net/intel/i40e/i40e_flow_tunnel.c | 174 ++++++++++++++++++++
 3 files changed, 176 insertions(+), 190 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 3d94c04872..358d87a3ea 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -38,6 +38,7 @@ const struct ci_flow_engine_list i40e_flow_engine_list = {
 		&i40e_flow_engine_tunnel_vxlan,
 		&i40e_flow_engine_tunnel_nvgre,
 		&i40e_flow_engine_tunnel_mpls,
+		&i40e_flow_engine_tunnel_gtp,
 	}
 };
 
@@ -68,11 +69,6 @@ static int i40e_flow_parse_tunnel_action(struct rte_eth_dev *dev,
 				 const struct rte_flow_action *actions,
 				 struct rte_flow_error *error,
 				 struct i40e_tunnel_filter_conf *filter);
-static int i40e_flow_parse_gtp_filter(struct rte_eth_dev *dev,
-				      const struct rte_flow_item pattern[],
-				      const struct rte_flow_action actions[],
-				      struct rte_flow_error *error,
-				      struct i40e_filter_ctx *filter);
 static int i40e_flow_destroy_tunnel_filter(struct i40e_pf *pf,
 					   struct i40e_tunnel_filter *filter);
 static int i40e_flow_flush_tunnel_filter(struct i40e_pf *pf);
@@ -112,22 +108,6 @@ static enum rte_flow_item_type pattern_fdir_ipv4_sctp[] = {
 	RTE_FLOW_ITEM_TYPE_END,
 };
 
-static enum rte_flow_item_type pattern_fdir_ipv4_gtpc[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_GTPC,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv4_gtpu[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_GTPU,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
 static enum rte_flow_item_type pattern_fdir_ipv6_udp[] = {
 	RTE_FLOW_ITEM_TYPE_ETH,
 	RTE_FLOW_ITEM_TYPE_IPV6,
@@ -149,28 +129,7 @@ static enum rte_flow_item_type pattern_fdir_ipv6_sctp[] = {
 	RTE_FLOW_ITEM_TYPE_END,
 };
 
-static enum rte_flow_item_type pattern_fdir_ipv6_gtpc[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_GTPC,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv6_gtpu[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_GTPU,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
 static struct i40e_valid_pattern i40e_supported_patterns[] = {
-	/* GTP-C & GTP-U */
-	{ pattern_fdir_ipv4_gtpc, i40e_flow_parse_gtp_filter },
-	{ pattern_fdir_ipv4_gtpu, i40e_flow_parse_gtp_filter },
-	{ pattern_fdir_ipv6_gtpc, i40e_flow_parse_gtp_filter },
-	{ pattern_fdir_ipv6_gtpu, i40e_flow_parse_gtp_filter },
 	/* L4 over port */
 	{ pattern_fdir_ipv4_udp, i40e_flow_parse_l4_cloud_filter },
 	{ pattern_fdir_ipv4_tcp, i40e_flow_parse_l4_cloud_filter },
@@ -791,154 +750,6 @@ i40e_check_tunnel_filter_type(uint8_t filter_type)
 }
 
 
-/* 1. Last in item should be NULL as range is not supported.
- * 2. Supported filter types: GTP TEID.
- * 3. Mask of fields which need to be matched should be
- *    filled with 1.
- * 4. Mask of fields which needn't to be matched should be
- *    filled with 0.
- * 5. GTP profile supports GTPv1 only.
- * 6. GTP-C response message ('source_port' = 2123) is not supported.
- */
-static int
-i40e_flow_parse_gtp_pattern(struct rte_eth_dev *dev,
-			    const struct rte_flow_item *pattern,
-			    struct rte_flow_error *error,
-			    struct i40e_tunnel_filter_conf *filter)
-{
-	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-	const struct rte_flow_item *item = pattern;
-	const struct rte_flow_item_gtp *gtp_spec;
-	const struct rte_flow_item_gtp *gtp_mask;
-	enum rte_flow_item_type item_type;
-
-	if (!pf->gtp_support) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ITEM,
-				   item,
-				   "GTP is not supported by default.");
-		return -rte_errno;
-	}
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
-			if (item->spec || item->mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid UDP item");
-				return -rte_errno;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_GTPC:
-		case RTE_FLOW_ITEM_TYPE_GTPU:
-			gtp_spec = item->spec;
-			gtp_mask = item->mask;
-
-			if (!gtp_spec || !gtp_mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid GTP item");
-				return -rte_errno;
-			}
-
-			if (gtp_mask->hdr.gtp_hdr_info ||
-			    gtp_mask->hdr.msg_type ||
-			    gtp_mask->hdr.plen ||
-			    gtp_mask->hdr.teid != UINT32_MAX) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid GTP mask");
-				return -rte_errno;
-			}
-
-			if (item_type == RTE_FLOW_ITEM_TYPE_GTPC)
-				filter->tunnel_type = I40E_TUNNEL_TYPE_GTPC;
-			else if (item_type == RTE_FLOW_ITEM_TYPE_GTPU)
-				filter->tunnel_type = I40E_TUNNEL_TYPE_GTPU;
-
-			filter->tenant_id = rte_be_to_cpu_32(gtp_spec->hdr.teid);
-
-			break;
-		default:
-			break;
-		}
-	}
-
-	return 0;
-}
-
-static int
-i40e_flow_parse_gtp_filter(struct rte_eth_dev *dev,
-			   const struct rte_flow_item pattern[],
-			   const struct rte_flow_action actions[],
-			   struct rte_flow_error *error,
-			   struct i40e_filter_ctx *filter)
-{
-	struct i40e_tunnel_filter_conf *tunnel_filter = &filter->consistent_tunnel_filter;
-	int ret;
-
-	ret = i40e_flow_parse_gtp_pattern(dev, pattern,
-					  error, tunnel_filter);
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
-
 static int
 i40e_flow_check(struct rte_eth_dev *dev,
 		   const struct rte_flow_attr *attr,
diff --git a/drivers/net/intel/i40e/i40e_flow.h b/drivers/net/intel/i40e/i40e_flow.h
index a32e61ddd6..2d2a98333e 100644
--- a/drivers/net/intel/i40e/i40e_flow.h
+++ b/drivers/net/intel/i40e/i40e_flow.h
@@ -22,5 +22,6 @@ extern const struct ci_flow_engine i40e_flow_engine_tunnel_qinq;
 extern const struct ci_flow_engine i40e_flow_engine_tunnel_vxlan;
 extern const struct ci_flow_engine i40e_flow_engine_tunnel_nvgre;
 extern const struct ci_flow_engine i40e_flow_engine_tunnel_mpls;
+extern const struct ci_flow_engine i40e_flow_engine_tunnel_gtp;
 
 #endif /* _I40E_FLOW_H_ */
diff --git a/drivers/net/intel/i40e/i40e_flow_tunnel.c b/drivers/net/intel/i40e/i40e_flow_tunnel.c
index 22299b4531..a74cbca3d5 100644
--- a/drivers/net/intel/i40e/i40e_flow_tunnel.c
+++ b/drivers/net/intel/i40e/i40e_flow_tunnel.c
@@ -831,6 +831,172 @@ static const struct rte_flow_graph i40e_tunnel_mpls_graph = {
 	},
 };
 
+/**
+ * GTP tunnel filter graph implementation
+ * Pattern: START -> ETH -> (IPv4 | IPv6) -> UDP -> (GTPC | GTPU) -> END
+ */
+enum i40e_tunnel_gtp_node_id {
+	I40E_TUNNEL_GTP_NODE_START  = RTE_FLOW_NODE_FIRST,
+	I40E_TUNNEL_GTP_NODE_ETH,
+	I40E_TUNNEL_GTP_NODE_IPV4,
+	I40E_TUNNEL_GTP_NODE_IPV6,
+	I40E_TUNNEL_GTP_NODE_UDP,
+	I40E_TUNNEL_GTP_NODE_GTPC,
+	I40E_TUNNEL_GTP_NODE_GTPU,
+	I40E_TUNNEL_GTP_NODE_END,
+	I40E_TUNNEL_GTP_NODE_MAX,
+};
+
+static int
+i40e_tunnel_node_gtp_validate(const void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_item_gtp *gtp_mask = item->mask;
+	const struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	const struct rte_eth_dev_data *dev_data = tunnel_ctx->base.dev_data;
+	const struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev_data->dev_private);
+
+	/* does HW support GTP? */
+	if (!pf->gtp_support) {
+		return rte_flow_error_set(error, ENOTSUP,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"GTP not supported");
+	}
+
+	/* reject unsupported fields */
+	if (gtp_mask->hdr.gtp_hdr_info ||
+	    gtp_mask->hdr.msg_type ||
+	    gtp_mask->hdr.plen) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid GTP mask");
+	}
+
+	/* teid must be fully masked */
+	if (!CI_FIELD_IS_MASKED(&gtp_mask->hdr.teid)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid GTP mask");
+	}
+	return 0;
+}
+
+static int
+i40e_tunnel_node_gtp_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_item_gtp *gtp_spec = item->spec;
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	if (item->type == RTE_FLOW_ITEM_TYPE_GTPC)
+		tunnel_filter->tunnel_type = I40E_TUNNEL_TYPE_GTPC;
+	else if (item->type == RTE_FLOW_ITEM_TYPE_GTPU)
+		tunnel_filter->tunnel_type = I40E_TUNNEL_TYPE_GTPU;
+	else {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid GTP item type");
+	}
+	tunnel_filter->tenant_id = rte_be_to_cpu_32(gtp_spec->hdr.teid);
+
+	return 0;
+}
+
+static const struct rte_flow_graph i40e_tunnel_gtp_graph = {
+	.nodes = (struct rte_flow_graph_node[]) {
+		[I40E_TUNNEL_GTP_NODE_START] = {
+			.name = "START",
+		},
+		[I40E_TUNNEL_GTP_NODE_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+		},
+		[I40E_TUNNEL_GTP_NODE_IPV4] = {
+			.name = "IPv4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+			.process = i40e_tunnel_node_ipv4_process,
+		},
+		[I40E_TUNNEL_GTP_NODE_IPV6] = {
+			.name = "IPv6",
+			.type = RTE_FLOW_ITEM_TYPE_IPV6,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+			.process = i40e_tunnel_node_ipv6_process,
+		},
+		[I40E_TUNNEL_GTP_NODE_UDP] = {
+			.name = "UDP",
+			.type = RTE_FLOW_ITEM_TYPE_UDP,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+		},
+		[I40E_TUNNEL_GTP_NODE_GTPC] = {
+			.name = "GTPC",
+			.type = RTE_FLOW_ITEM_TYPE_GTPC,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_gtp_validate,
+			.process = i40e_tunnel_node_gtp_process,
+		},
+		[I40E_TUNNEL_GTP_NODE_GTPU] = {
+			.name = "GTPU",
+			.type = RTE_FLOW_ITEM_TYPE_GTPU,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_gtp_validate,
+			.process = i40e_tunnel_node_gtp_process,
+		},
+		[I40E_TUNNEL_GTP_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	},
+	.edges = (struct rte_flow_graph_edge[]) {
+		[I40E_TUNNEL_GTP_NODE_START] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_GTP_NODE_ETH,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_GTP_NODE_ETH] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_GTP_NODE_IPV4,
+				I40E_TUNNEL_GTP_NODE_IPV6,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_GTP_NODE_IPV4] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_GTP_NODE_UDP,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_GTP_NODE_IPV6] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_GTP_NODE_UDP,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_GTP_NODE_UDP] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_GTP_NODE_GTPC,
+				I40E_TUNNEL_GTP_NODE_GTPU,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_GTP_NODE_GTPC] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_GTP_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_GTP_NODE_GTPU] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_GTP_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+	},
+};
+
 static int
 i40e_tunnel_action_check(const struct ci_flow_actions *actions,
 		const struct ci_flow_actions_check_param *param,
@@ -1017,6 +1183,14 @@ const struct ci_flow_engine i40e_flow_engine_tunnel_mpls = {
 	.graph = &i40e_tunnel_mpls_graph,
 };
 
+const struct ci_flow_engine i40e_flow_engine_tunnel_gtp = {
+	.name = "tunnel_gtp",
+	.ops = &i40e_flow_engine_tunnel_ops,
+	.ctx_size = sizeof(struct i40e_tunnel_ctx),
+	.flow_size = sizeof(struct i40e_tunnel_flow),
+	.graph = &i40e_tunnel_gtp_graph,
+};
+
 const struct ci_flow_engine i40e_flow_engine_tunnel_qinq = {
 	.name = "tunnel_qinq",
 	.ops = &i40e_flow_engine_tunnel_ops,
-- 
2.52.0

