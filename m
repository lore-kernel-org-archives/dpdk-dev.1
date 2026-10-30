Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E17606A323
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Df9utmtX
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F68040A6B;
	Fri, 30 Oct 2026 10:40:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 0417240A81
 for <dev@dpdk.org>; Fri, 30 Oct 2026 10:40:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793353256; x=1824889256;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=GS8OC1FN0pGOnJ7vbuNNgeeRujyx9humGyfS/qy/xcI=;
 b=Df9utmtX8vTQXDXf24fu3kTNvqpR7xjk5S73Sz7Z7axZ8kQyteooz10R
 z4AedUaxaA7No/bJjWOs9wS5McrKklcsu8lzcjOqX+jFd6M0ELh5CsKgt
 crJq0CSVqVhaLlAf7F7MGPB5jCOToBipHtQbOLqi6WtftviFv7lFcoSYK
 Jj5gMBOiDUerGXwhSFXMJ4iW8jTPsUbDxmAFV9t1Sq2lqeh1iAzTO/VS3
 jb163FnWhYgYR591X2vxMUdykpRmzARNx09nvqTrvNaPUF/OmqIdX57eE
 p0WEFbPCrlhQX1KNIazBcEQ0ckCsb5yGWR6nSf9OGhS/VIez6dqT/BYdS A==;
X-CSE-ConnectionGUID: LZX70zdBR1+bS7igMz0erQ==
X-CSE-MsgGUID: x6IhmExPSoyOvpce9PWQuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2126047"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2126047"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 02:40:55 -0700
X-CSE-ConnectionGUID: sjHSX465SO61ycdrGaHz9w==
X-CSE-MsgGUID: zRSZSm0hT3WIdioT6PDtPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5299614"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 30 Oct 2026 02:40:54 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 4/9] net/i40e: fix FDIR ethertype match with other items
Date: Fri, 30 Oct 2026 09:40:17 +0000
Message-ID: <864cc113059c3f47c176b75292bd995e8d82f132.1793353214.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <5e64cc416c8ab3b038eee6bb55836e0b8ed507ab.1793353214.git.anatoly.burakov@intel.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An FDIR filter matching the ETH ethertype can only match the ethertype,
but the FDIR parser accepted it together with other pattern items.

Reject the ethertype in the FDIR graph, and move ethertype matching to
a separate FDIR engine that only accepts an ETH item followed by END.

Fixes: 05432a6e4676 ("net/i40e: reimplement FDIR parser")

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_fdir.c      |   4 +-
 drivers/net/intel/i40e/i40e_flow.c      |   1 +
 drivers/net/intel/i40e/i40e_flow.h      |   1 +
 drivers/net/intel/i40e/i40e_flow_fdir.c | 178 ++++++++++++++++--------
 4 files changed, 126 insertions(+), 58 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_fdir.c b/drivers/net/intel/i40e/i40e_fdir.c
index c520baf619f..69b3b763bae 100644
--- a/drivers/net/intel/i40e/i40e_fdir.c
+++ b/drivers/net/intel/i40e/i40e_fdir.c
@@ -1003,7 +1003,9 @@ i40e_fdir_flow_store_init(struct rte_eth_dev *dev)
 
 	snprintf(fdir_pool_name, sizeof(fdir_pool_name), "fdir_%s", dev->data->name);
 	store->pool = rte_mempool_create(fdir_pool_name, fdir_info->fdir_space_size,
-			i40e_flow_engine_fdir.flow_size, 0, 0, NULL, NULL, NULL, NULL,
+			RTE_MAX(i40e_flow_engine_fdir.flow_size,
+				i40e_flow_engine_fdir_ethertype.flow_size),
+			0, 0, NULL, NULL, NULL, NULL,
 			rte_socket_id(),
 			/* pack flows tightly */
 			RTE_MEMPOOL_F_NO_SPREAD | RTE_MEMPOOL_F_NO_CACHE_ALIGN |
diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 82a77064f06..0c73f0f13a7 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -34,6 +34,7 @@ const struct ci_flow_engine_list i40e_flow_engine_list = {
 	{
 		&i40e_flow_engine_ethertype,
 		&i40e_flow_engine_fdir,
+		&i40e_flow_engine_fdir_ethertype,
 		&i40e_flow_engine_tunnel_qinq,
 		&i40e_flow_engine_tunnel_vxlan,
 		&i40e_flow_engine_tunnel_nvgre,
diff --git a/drivers/net/intel/i40e/i40e_flow.h b/drivers/net/intel/i40e/i40e_flow.h
index 31269d4d93a..1577df4993e 100644
--- a/drivers/net/intel/i40e/i40e_flow.h
+++ b/drivers/net/intel/i40e/i40e_flow.h
@@ -17,6 +17,7 @@ extern const struct ci_flow_engine_list i40e_flow_engine_list;
 
 extern const struct ci_flow_engine i40e_flow_engine_ethertype;
 extern const struct ci_flow_engine i40e_flow_engine_fdir;
+extern const struct ci_flow_engine i40e_flow_engine_fdir_ethertype;
 extern const struct ci_flow_engine i40e_flow_engine_tunnel_qinq;
 extern const struct ci_flow_engine i40e_flow_engine_tunnel_vxlan;
 extern const struct ci_flow_engine i40e_flow_engine_tunnel_nvgre;
diff --git a/drivers/net/intel/i40e/i40e_flow_fdir.c b/drivers/net/intel/i40e/i40e_flow_fdir.c
index 45a93defa7a..ba8c18250c8 100644
--- a/drivers/net/intel/i40e/i40e_flow_fdir.c
+++ b/drivers/net/intel/i40e/i40e_flow_fdir.c
@@ -70,9 +70,8 @@ static int
 i40e_fdir_node_eth_validate(const void *ctx __rte_unused, const struct rte_flow_item *item,
 		struct rte_flow_error *error)
 {
-	const struct rte_flow_item_eth *eth_spec = item->spec;
 	const struct rte_flow_item_eth *eth_mask = ci_flow_item_mask(item);
-	bool no_src_mac, no_dst_mac, src_mac, dst_mac, no_etype;
+	bool no_src_mac, no_dst_mac, src_mac, dst_mac;
 
 	/* may be empty */
 	if (eth_mask == NULL)
@@ -81,12 +80,15 @@ i40e_fdir_node_eth_validate(const void *ctx __rte_unused, const struct rte_flow_
 	/* source and destination masks may be all zero or all one */
 	no_src_mac = CI_FIELD_IS_ZERO(&eth_mask->hdr.src_addr);
 	no_dst_mac = CI_FIELD_IS_ZERO(&eth_mask->hdr.dst_addr);
-	no_etype = CI_FIELD_IS_ZERO(&eth_mask->hdr.ether_type);
 	src_mac = CI_FIELD_IS_MASKED(&eth_mask->hdr.src_addr);
 	dst_mac = CI_FIELD_IS_MASKED(&eth_mask->hdr.dst_addr);
 
+	if (!CI_FIELD_IS_ZERO(&eth_mask->hdr.ether_type)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item, "Ethertype match not supported");
+	}
 	/* can't be all zero */
-	if (no_src_mac && no_dst_mac && no_etype) {
+	if (no_src_mac && no_dst_mac) {
 		return rte_flow_error_set(error, EINVAL,
 				RTE_FLOW_ERROR_TYPE_ITEM, item, "Invalid eth mask");
 	}
@@ -97,38 +99,18 @@ i40e_fdir_node_eth_validate(const void *ctx __rte_unused, const struct rte_flow_
 				RTE_FLOW_ERROR_TYPE_ITEM, item, "Invalid eth mask");
 	}
 
-	/* ethertype can either be unmasked or fully masked */
-	if (no_etype)
-		return 0;
-
-	if (!CI_FIELD_IS_MASKED(&eth_mask->hdr.ether_type)) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM, item, "Invalid ethertype mask");
-	}
-
-	/* Check for valid ethertype (not IPv4/IPv6) */
-	uint16_t ether_type = rte_be_to_cpu_16(eth_spec->hdr.ether_type);
-	if (ether_type == RTE_ETHER_TYPE_IPV4 ||
-	    ether_type == RTE_ETHER_TYPE_IPV6) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM, item,
-				"IPv4/IPv6 not supported by ethertype filter");
-	}
-
 	return 0;
 }
 
 static int
 i40e_fdir_node_eth_process(void *ctx, const struct rte_flow_item *item,
-		struct rte_flow_error *error)
+		struct rte_flow_error *error __rte_unused)
 {
 	struct i40e_fdir_ctx *fdir_ctx = ctx;
 	struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
 	const struct rte_flow_item_eth *eth_spec = item->spec;
 	const struct rte_flow_item_eth *eth_mask = ci_flow_item_mask(item);
-	uint16_t tpid, ether_type;
 	uint64_t input_set = 0;
-	int ret;
 
 	/* Set layer index for L2 flexible payload (after ETH/VLAN) */
 	fdir_filter->input.flow_ext.layer_idx = I40E_FLXPLD_L2_IDX;
@@ -151,40 +133,17 @@ i40e_fdir_node_eth_process(void *ctx, const struct rte_flow_item *item,
 		input_set |= I40E_INSET_DMAC;
 	}
 
-	/* do we care for ethertype? */
-	if (eth_mask->hdr.ether_type) {
-		struct i40e_pf *pf =
-				I40E_DEV_PRIVATE_TO_PF(fdir_ctx->base.dev_data->dev_private);
-
-		ether_type = rte_be_to_cpu_16(eth_spec->hdr.ether_type);
-		ret = i40e_get_outer_vlan(pf, &tpid);
-		if (ret != 0) {
-			return rte_flow_error_set(error, EIO,
-					RTE_FLOW_ERROR_TYPE_ITEM, item,
-					"Can not get the Ethertype identifying the L2 tag");
-		}
-		if (ether_type == tpid) {
-			return rte_flow_error_set(error, EINVAL,
-						RTE_FLOW_ERROR_TYPE_ITEM, item,
-						"Unsupported ether_type in control packet filter.");
-		}
-		fdir_filter->input.flow.l2_flow.ether_type = eth_spec->hdr.ether_type;
-		input_set |= I40E_INSET_LAST_ETHER_TYPE;
-	}
-
 	fdir_filter->input.flow_ext.input_set = input_set;
 
 	return 0;
 }
 
 static int
-i40e_fdir_node_vlan_validate(const void *ctx, const struct rte_flow_item *item,
+i40e_fdir_node_vlan_validate(const void *ctx __rte_unused, const struct rte_flow_item *item,
 		struct rte_flow_error *error)
 {
 	const struct rte_flow_item_vlan *vlan_spec = item->spec;
 	const struct rte_flow_item_vlan *vlan_mask = ci_flow_item_mask(item);
-	const struct i40e_fdir_ctx *fdir_ctx = ctx;
-	const struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
 	uint16_t ether_type;
 
 	if (vlan_mask == NULL)
@@ -206,13 +165,6 @@ i40e_fdir_node_vlan_validate(const void *ctx, const struct rte_flow_item *item,
 				"Invalid VLAN header mask");
 	}
 
-	/* can't match on eth_proto as we're already matching on ethertype */
-	if (fdir_filter->input.flow_ext.input_set & I40E_INSET_LAST_ETHER_TYPE) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM, item,
-				"Cannot set two ethertype filters");
-	}
-
 	ether_type = rte_be_to_cpu_16(vlan_spec->hdr.eth_proto);
 	if (ether_type == RTE_ETHER_TYPE_IPV4 ||
 	    ether_type == RTE_ETHER_TYPE_IPV6) {
@@ -1388,7 +1340,6 @@ static const struct flow_graph i40e_fdir_graph = {
 				I40E_FDIR_NODE_IPV4,
 				I40E_FDIR_NODE_IPV6,
 				I40E_FDIR_NODE_RAW,
-				I40E_FDIR_NODE_END,
 				FLOW_GRAPH_NODE_EDGE_END
 			}
 		},
@@ -1524,6 +1475,111 @@ static const struct flow_graph i40e_fdir_graph = {
 	},
 };
 
+/**
+ * FDIR ethertype graph implementation
+ * Pattern: START -> ETH -> END
+ */
+
+enum i40e_fdir_ethertype_node_id {
+	I40E_FDIR_ETHERTYPE_NODE_START = FLOW_GRAPH_NODE_FIRST,
+	I40E_FDIR_ETHERTYPE_NODE_ETH,
+	I40E_FDIR_ETHERTYPE_NODE_END,
+	I40E_FDIR_ETHERTYPE_NODE_MAX,
+};
+
+static int
+i40e_fdir_ethertype_node_eth_validate(const void *ctx __rte_unused,
+		const struct rte_flow_item *item, struct rte_flow_error *error)
+{
+	const struct rte_flow_item_eth *eth_spec = item->spec;
+	const struct rte_flow_item_eth *eth_mask = ci_flow_item_mask(item);
+	uint16_t ether_type;
+
+	if (!CI_FIELD_IS_ZERO(&eth_mask->hdr.src_addr) ||
+	    !CI_FIELD_IS_ZERO(&eth_mask->hdr.dst_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item, "Invalid eth mask");
+	}
+	if (!CI_FIELD_IS_MASKED(&eth_mask->hdr.ether_type)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item, "Invalid ethertype mask");
+	}
+
+	ether_type = rte_be_to_cpu_16(eth_spec->hdr.ether_type);
+	if (ether_type == RTE_ETHER_TYPE_IPV4 ||
+	    ether_type == RTE_ETHER_TYPE_IPV6) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"IPv4/IPv6 not supported by ethertype filter");
+	}
+
+	return 0;
+}
+
+static int
+i40e_fdir_ethertype_node_eth_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	struct i40e_fdir_ctx *fdir_ctx = ctx;
+	struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(fdir_ctx->base.dev_data->dev_private);
+	const struct rte_flow_item_eth *eth_spec = item->spec;
+	uint16_t tpid;
+	int ret;
+
+	ret = i40e_get_outer_vlan(pf, &tpid);
+	if (ret != 0) {
+		return rte_flow_error_set(error, EIO,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Can not get the Ethertype identifying the L2 tag");
+	}
+	if (rte_be_to_cpu_16(eth_spec->hdr.ether_type) == tpid) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Unsupported ether_type in control packet filter.");
+	}
+
+	fdir_filter->input.flow_ext.layer_idx = I40E_FLXPLD_L2_IDX;
+	fdir_filter->input.pctype = I40E_FILTER_PCTYPE_L2_PAYLOAD;
+	fdir_filter->input.flow.l2_flow.ether_type = eth_spec->hdr.ether_type;
+	fdir_filter->input.flow_ext.input_set = I40E_INSET_LAST_ETHER_TYPE;
+
+	return 0;
+}
+
+static const struct flow_graph i40e_fdir_ethertype_graph = {
+	.nodes = (struct flow_graph_node[]) {
+		[I40E_FDIR_ETHERTYPE_NODE_START] = { .name = "START" },
+		[I40E_FDIR_ETHERTYPE_NODE_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC,
+			.validate = i40e_fdir_ethertype_node_eth_validate,
+			.process = i40e_fdir_ethertype_node_eth_process,
+		},
+		[I40E_FDIR_ETHERTYPE_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+			.validate = i40e_fdir_node_end_validate,
+			.process = i40e_fdir_node_end_process
+		},
+	},
+	.edges = (struct flow_graph_edge[]) {
+		[I40E_FDIR_ETHERTYPE_NODE_START] = {
+			.next = (size_t[]) {
+				I40E_FDIR_ETHERTYPE_NODE_ETH,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_ETHERTYPE_NODE_ETH] = {
+			.next = (size_t[]) {
+				I40E_FDIR_ETHERTYPE_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+	},
+};
+
 static int
 i40e_fdir_action_check(const struct ci_flow_actions *actions,
 		const struct ci_flow_actions_check_param *param,
@@ -2099,3 +2155,11 @@ const struct ci_flow_engine i40e_flow_engine_fdir = {
 	.flow_size = sizeof(struct i40e_flow_engine_fdir_flow),
 	.graph = &i40e_fdir_graph,
 };
+
+const struct ci_flow_engine i40e_flow_engine_fdir_ethertype = {
+	.name = "i40e_fdir_ethertype",
+	.ops = &i40e_flow_engine_fdir_ops,
+	.ctx_size = sizeof(struct i40e_fdir_ctx),
+	.flow_size = sizeof(struct i40e_flow_engine_fdir_flow),
+	.graph = &i40e_fdir_ethertype_graph,
+};
-- 
2.52.0

