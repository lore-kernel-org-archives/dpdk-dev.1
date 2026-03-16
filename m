Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA68F53D7E
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 17:30:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5415D40DCE;
	Mon, 16 Mar 2026 18:28:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 72C6040B92
 for <dev@dpdk.org>; Mon, 16 Mar 2026 18:28:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773682100; x=1805218100;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=1ePgGyfLYoGT/EMB+NPF2lcNfziGWB+Cge8cFusCABg=;
 b=NgHCXlTgfNZimiNkFXm1rm56re+dX68snt7s9/BaMfkNf3YRirioJZqG
 bfwpq5pWkRHyuB3lgIxp+An5uJZt5Jz2MC6SUOjjNWcpDHicdJvQ8QESt
 Y84raIaS10X0EHKVIyQAbX8IAMS0Os5YRcQ9EwAJpK4yOpdF2D5NGbFXZ
 SLuWsG416DJ0mefZy/Yh7s8onTE23pzRi+CwqtyKHEzgGwHJEZkJ8MESv
 l39uqc9PKrmK2c9fvSz0MAoiX6ZZCQ6V7kaGazziXF9lKKBjopVdfIJSH
 WlYDT/VOgIg0T+S/tA4l9P++cQAWi16gP+LZ2p6/J/VzZR86L1NO1a1Pn w==;
X-CSE-ConnectionGUID: aIoi4kyeSX2j4yYkwmPLuw==
X-CSE-MsgGUID: T6rSSTBBQPiWaYS2AgOpOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86059662"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="86059662"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 10:28:19 -0700
X-CSE-ConnectionGUID: lFgty2LrSHid6GKCqTOM9g==
X-CSE-MsgGUID: 2ZLm69yuS7SkUT07KCEI2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221228284"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 16 Mar 2026 10:28:18 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH v1 17/21] net/i40e: reimplement NVGRE parser
Date: Mon, 16 Mar 2026 17:27:45 +0000
Message-ID: <779f26494d598a69896fbc03ab4df72d527ab5eb.1773681366.git.anatoly.burakov@intel.com>
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
flow parser for NVGRE tunnels.

For VLAN nodes we will use existing VLAN node validation which is more
stringent, so we no longer allow any non-zero `vlan_tci` mask, only full
mask.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_flow.c        | 295 +---------------------
 drivers/net/intel/i40e/i40e_flow.h        |   2 +
 drivers/net/intel/i40e/i40e_flow_tunnel.c | 207 +++++++++++++++
 3 files changed, 210 insertions(+), 294 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 1b1547a8ac..c2c9bec9ce 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -35,14 +35,10 @@ const struct ci_flow_engine_list i40e_flow_engine_list = {
 		&i40e_flow_engine_fdir,
 		&i40e_flow_engine_tunnel_qinq,
 		&i40e_flow_engine_tunnel_vxlan,
+		&i40e_flow_engine_tunnel_nvgre,
 	}
 };
 
-#define I40E_VLAN_TCI_MASK	0xFFFF
-#define I40E_VLAN_PRI_MASK	0xE000
-#define I40E_VLAN_CFI_MASK	0x1000
-#define I40E_VLAN_VID_MASK	0x0FFF
-
 static int i40e_flow_validate(struct rte_eth_dev *dev,
 			      const struct rte_flow_attr *attr,
 			      const struct rte_flow_item pattern[],
@@ -66,11 +62,6 @@ static int i40e_flow_parse_tunnel_action(struct rte_eth_dev *dev,
 				 const struct rte_flow_action *actions,
 				 struct rte_flow_error *error,
 				 struct i40e_tunnel_filter_conf *filter);
-static int i40e_flow_parse_nvgre_filter(struct rte_eth_dev *dev,
-					const struct rte_flow_item pattern[],
-					const struct rte_flow_action actions[],
-					struct rte_flow_error *error,
-					struct i40e_filter_ctx *filter);
 static int i40e_flow_parse_mpls_filter(struct rte_eth_dev *dev,
 				       const struct rte_flow_item pattern[],
 				       const struct rte_flow_action actions[],
@@ -173,40 +164,6 @@ static enum rte_flow_item_type pattern_fdir_ipv6_gtpu[] = {
 };
 
 /* Pattern matched tunnel filter */
-static enum rte_flow_item_type pattern_nvgre_1[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_NVGRE,
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_nvgre_2[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_NVGRE,
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_nvgre_3[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_NVGRE,
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_nvgre_4[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_NVGRE,
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
 static enum rte_flow_item_type pattern_mpls_1[] = {
 	RTE_FLOW_ITEM_TYPE_ETH,
 	RTE_FLOW_ITEM_TYPE_IPV4,
@@ -240,11 +197,6 @@ static enum rte_flow_item_type pattern_mpls_4[] = {
 };
 
 static struct i40e_valid_pattern i40e_supported_patterns[] = {
-	/* NVGRE */
-	{ pattern_nvgre_1, i40e_flow_parse_nvgre_filter },
-	{ pattern_nvgre_2, i40e_flow_parse_nvgre_filter },
-	{ pattern_nvgre_3, i40e_flow_parse_nvgre_filter },
-	{ pattern_nvgre_4, i40e_flow_parse_nvgre_filter },
 	/* MPLSoUDP & MPLSoGRE */
 	{ pattern_mpls_1, i40e_flow_parse_mpls_filter },
 	{ pattern_mpls_2, i40e_flow_parse_mpls_filter },
@@ -750,251 +702,6 @@ i40e_check_tunnel_filter_type(uint8_t filter_type)
 	return -1;
 }
 
-/* 1. Last in item should be NULL as range is not supported.
- * 2. Supported filter types: IMAC_IVLAN_TENID, IMAC_IVLAN,
- *    IMAC_TENID, OMAC_TENID_IMAC and IMAC.
- * 3. Mask of fields which need to be matched should be
- *    filled with 1.
- * 4. Mask of fields which needn't to be matched should be
- *    filled with 0.
- */
-static int
-i40e_flow_parse_nvgre_pattern(__rte_unused struct rte_eth_dev *dev,
-			      const struct rte_flow_item *pattern,
-			      struct rte_flow_error *error,
-			      struct i40e_tunnel_filter_conf *filter)
-{
-	const struct rte_flow_item *item = pattern;
-	const struct rte_flow_item_eth *eth_spec;
-	const struct rte_flow_item_eth *eth_mask;
-	const struct rte_flow_item_nvgre *nvgre_spec;
-	const struct rte_flow_item_nvgre *nvgre_mask;
-	const struct rte_flow_item_vlan *vlan_spec;
-	const struct rte_flow_item_vlan *vlan_mask;
-	enum rte_flow_item_type item_type;
-	uint8_t filter_type = 0;
-	bool is_tni_masked = 0;
-	uint8_t tni_mask[] = {0xFF, 0xFF, 0xFF};
-	bool nvgre_flag = 0;
-	uint32_t tenant_id_be = 0;
-	int ret;
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
-			eth_spec = item->spec;
-			eth_mask = item->mask;
-
-			/* Check if ETH item is used for place holder.
-			 * If yes, both spec and mask should be NULL.
-			 * If no, both spec and mask shouldn't be NULL.
-			 */
-			if ((!eth_spec && eth_mask) ||
-			    (eth_spec && !eth_mask)) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid ether spec/mask");
-				return -rte_errno;
-			}
-
-			if (eth_spec && eth_mask) {
-				/* DST address of inner MAC shouldn't be masked.
-				 * SRC address of Inner MAC should be masked.
-				 */
-				if (!rte_is_broadcast_ether_addr(&eth_mask->hdr.dst_addr) ||
-				    !rte_is_zero_ether_addr(&eth_mask->hdr.src_addr) ||
-				    eth_mask->hdr.ether_type) {
-					rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid ether spec/mask");
-					return -rte_errno;
-				}
-
-				if (!nvgre_flag) {
-					rte_memcpy(&filter->outer_mac,
-						   &eth_spec->hdr.dst_addr,
-						   RTE_ETHER_ADDR_LEN);
-					filter_type |= RTE_ETH_TUNNEL_FILTER_OMAC;
-				} else {
-					rte_memcpy(&filter->inner_mac,
-						   &eth_spec->hdr.dst_addr,
-						   RTE_ETHER_ADDR_LEN);
-					filter_type |= RTE_ETH_TUNNEL_FILTER_IMAC;
-				}
-			}
-
-			break;
-		case RTE_FLOW_ITEM_TYPE_VLAN:
-			vlan_spec = item->spec;
-			vlan_mask = item->mask;
-			if (!(vlan_spec && vlan_mask) ||
-			    vlan_mask->hdr.eth_proto) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid vlan item");
-				return -rte_errno;
-			}
-
-			if (vlan_spec && vlan_mask) {
-				if (vlan_mask->hdr.vlan_tci ==
-				    rte_cpu_to_be_16(I40E_VLAN_TCI_MASK))
-					filter->inner_vlan =
-					      rte_be_to_cpu_16(vlan_spec->hdr.vlan_tci) &
-					      I40E_VLAN_TCI_MASK;
-				filter_type |= RTE_ETH_TUNNEL_FILTER_IVLAN;
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
-		case RTE_FLOW_ITEM_TYPE_NVGRE:
-			nvgre_spec = item->spec;
-			nvgre_mask = item->mask;
-			/* Check if NVGRE item is used to describe protocol.
-			 * If yes, both spec and mask should be NULL.
-			 * If no, both spec and mask shouldn't be NULL.
-			 */
-			if ((!nvgre_spec && nvgre_mask) ||
-			    (nvgre_spec && !nvgre_mask)) {
-				rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ITEM,
-					   item,
-					   "Invalid NVGRE item");
-				return -rte_errno;
-			}
-
-			if (nvgre_spec && nvgre_mask) {
-				is_tni_masked =
-					!!memcmp(nvgre_mask->tni, tni_mask,
-						 RTE_DIM(tni_mask));
-				if (is_tni_masked) {
-					rte_flow_error_set(error, EINVAL,
-						       RTE_FLOW_ERROR_TYPE_ITEM,
-						       item,
-						       "Invalid TNI mask");
-					return -rte_errno;
-				}
-				if (nvgre_mask->protocol &&
-					nvgre_mask->protocol != 0xFFFF) {
-					rte_flow_error_set(error, EINVAL,
-						RTE_FLOW_ERROR_TYPE_ITEM,
-						item,
-						"Invalid NVGRE item");
-					return -rte_errno;
-				}
-				if (nvgre_mask->c_k_s_rsvd0_ver &&
-					nvgre_mask->c_k_s_rsvd0_ver !=
-					rte_cpu_to_be_16(0xFFFF)) {
-					rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid NVGRE item");
-					return -rte_errno;
-				}
-				if (nvgre_spec->c_k_s_rsvd0_ver !=
-					rte_cpu_to_be_16(0x2000) &&
-					nvgre_mask->c_k_s_rsvd0_ver) {
-					rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid NVGRE item");
-					return -rte_errno;
-				}
-				if (nvgre_mask->protocol &&
-					nvgre_spec->protocol !=
-					rte_cpu_to_be_16(0x6558)) {
-					rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid NVGRE item");
-					return -rte_errno;
-				}
-				rte_memcpy(((uint8_t *)&tenant_id_be + 1),
-					   nvgre_spec->tni, 3);
-				filter->tenant_id =
-					rte_be_to_cpu_32(tenant_id_be);
-				filter_type |= RTE_ETH_TUNNEL_FILTER_TENID;
-			}
-
-			nvgre_flag = 1;
-			break;
-		default:
-			break;
-		}
-	}
-
-	ret = i40e_check_tunnel_filter_type(filter_type);
-	if (ret < 0) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ITEM,
-				   NULL,
-				   "Invalid filter type");
-		return -rte_errno;
-	}
-	filter->filter_type = filter_type;
-
-	filter->tunnel_type = I40E_TUNNEL_TYPE_NVGRE;
-
-	return 0;
-}
-
-static int
-i40e_flow_parse_nvgre_filter(struct rte_eth_dev *dev,
-			     const struct rte_flow_item pattern[],
-			     const struct rte_flow_action actions[],
-			     struct rte_flow_error *error,
-			     struct i40e_filter_ctx *filter)
-{
-	struct i40e_tunnel_filter_conf *tunnel_filter = &filter->consistent_tunnel_filter;
-	int ret;
-
-	ret = i40e_flow_parse_nvgre_pattern(dev, pattern,
-					    error, tunnel_filter);
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
 
 /* 1. Last in item should be NULL as range is not supported.
  * 2. Supported filter types: MPLS label.
diff --git a/drivers/net/intel/i40e/i40e_flow.h b/drivers/net/intel/i40e/i40e_flow.h
index 0981b4569a..161fa76b14 100644
--- a/drivers/net/intel/i40e/i40e_flow.h
+++ b/drivers/net/intel/i40e/i40e_flow.h
@@ -19,6 +19,7 @@ enum i40e_flow_engine_type {
 	I40E_FLOW_ENGINE_TYPE_FDIR,
 	I40E_FLOW_ENGINE_TYPE_TUNNEL_QINQ,
 	I40E_FLOW_ENGINE_TYPE_TUNNEL_VXLAN,
+	I40E_FLOW_ENGINE_TYPE_TUNNEL_NVGRE,
 };
 
 extern const struct ci_flow_engine_list i40e_flow_engine_list;
@@ -27,5 +28,6 @@ extern const struct ci_flow_engine i40e_flow_engine_ethertype;
 extern const struct ci_flow_engine i40e_flow_engine_fdir;
 extern const struct ci_flow_engine i40e_flow_engine_tunnel_qinq;
 extern const struct ci_flow_engine i40e_flow_engine_tunnel_vxlan;
+extern const struct ci_flow_engine i40e_flow_engine_tunnel_nvgre;
 
 #endif /* _I40E_FLOW_H_ */
diff --git a/drivers/net/intel/i40e/i40e_flow_tunnel.c b/drivers/net/intel/i40e/i40e_flow_tunnel.c
index ec6107dde0..643272a895 100644
--- a/drivers/net/intel/i40e/i40e_flow_tunnel.c
+++ b/drivers/net/intel/i40e/i40e_flow_tunnel.c
@@ -468,6 +468,204 @@ const struct rte_flow_graph i40e_tunnel_vxlan_graph = {
 	},
 };
 
+/**
+ * NVGRE tunnel filter graph implementation
+ * Pattern: START -> ETH -> (IPv4 | IPv6) -> NVGRE -> ETH -> [VLAN] -> END
+ */
+enum i40e_tunnel_nvgre_node_id {
+	I40E_TUNNEL_NVGRE_NODE_START  = RTE_FLOW_NODE_FIRST,
+	I40E_TUNNEL_NVGRE_NODE_OUTER_ETH,
+	I40E_TUNNEL_NVGRE_NODE_IPV4,
+	I40E_TUNNEL_NVGRE_NODE_IPV6,
+	I40E_TUNNEL_NVGRE_NODE_NVGRE,
+	I40E_TUNNEL_NVGRE_NODE_INNER_ETH,
+	I40E_TUNNEL_NVGRE_NODE_INNER_VLAN,
+	I40E_TUNNEL_NVGRE_NODE_END,
+	I40E_TUNNEL_NVGRE_NODE_MAX,
+};
+
+static int
+i40e_tunnel_node_nvgre_validate(const void *ctx __rte_unused,
+		const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct rte_flow_item_nvgre *nvgre_spec = item->spec;
+	const struct rte_flow_item_nvgre *nvgre_mask = item->mask;
+
+	/* spec/mask are optional */
+	if (nvgre_spec == NULL && nvgre_mask == NULL)
+		return 0;
+
+	/* TNI must be fully masked */
+	if (!CI_FIELD_IS_MASKED(&nvgre_mask->tni)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM_MASK, item,
+				"Invalid NVGRE mask");
+	}
+	/* protocol must either be unmasked or fully masked */
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&nvgre_mask->protocol)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM_MASK, item,
+				"Invalid NVGRE mask");
+	}
+	/* reserved/version field must either be unmasked or fully masked */
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&nvgre_mask->c_k_s_rsvd0_ver)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM_MASK, item,
+				"Invalid NVGRE mask");
+	}
+	/* if reserved/version field is masked, it must be set to 0x2000 */
+	if (nvgre_mask->c_k_s_rsvd0_ver &&
+			nvgre_spec->c_k_s_rsvd0_ver != rte_cpu_to_be_16(0x2000)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM_MASK, item,
+				"Invalid NVGRE spec");
+	}
+	/* if protocol field is masked, it must be set to 0x6558 */
+	if (nvgre_mask->protocol &&
+			nvgre_spec->protocol != rte_cpu_to_be_16(0x6558)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM_MASK, item,
+				"Invalid NVGRE spec");
+	}
+	return 0;
+}
+
+static int
+i40e_tunnel_node_nvgre_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct rte_flow_item_nvgre *nvgre_spec = item->spec;
+	const struct rte_flow_item_nvgre *nvgre_mask = item->mask;
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	/* spec/mask are optional */
+	if (nvgre_spec == NULL && nvgre_mask == NULL)
+		return 0;
+
+	/* Store the VNI and set filter flag */
+	tunnel_filter->tenant_id = ci_be24_to_cpu(nvgre_spec->tni);
+	tunnel_filter->filter_type |= RTE_ETH_TUNNEL_FILTER_TENID;
+
+	return 0;
+}
+
+static int
+i40e_tunnel_nvgre_node_end_process(void *ctx, const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	tunnel_filter->tunnel_type = I40E_TUNNEL_TYPE_NVGRE;
+
+	return 0;
+}
+
+const struct rte_flow_graph i40e_tunnel_nvgre_graph = {
+	.nodes = (struct rte_flow_graph_node[]) {
+		[I40E_TUNNEL_NVGRE_NODE_START] = {
+			.name = "START",
+		},
+		[I40E_TUNNEL_NVGRE_NODE_OUTER_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY |
+			               RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_eth_validate,
+			.process = i40e_tunnel_node_outer_eth_process,
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
+		[I40E_TUNNEL_NVGRE_NODE_NVGRE] = {
+			.name = "NVGRE",
+			.type = RTE_FLOW_ITEM_TYPE_NVGRE,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY |
+			               RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_nvgre_validate,
+			.process = i40e_tunnel_node_nvgre_process,
+		},
+		[I40E_TUNNEL_NVGRE_NODE_INNER_ETH] = {
+			.name = "INNER_ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY |
+			               RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_eth_validate,
+			.process = i40e_tunnel_inner_eth_process,
+		},
+		[I40E_TUNNEL_NVGRE_NODE_INNER_VLAN] = {
+			.name = "INNER_VLAN",
+			.type = RTE_FLOW_ITEM_TYPE_VLAN,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_vlan_validate,
+			.process = i40e_tunnel_node_inner_vlan_process,
+		},
+		[I40E_TUNNEL_NVGRE_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+			.validate = i40e_tunnel_node_end_validate,
+			.process = i40e_tunnel_nvgre_node_end_process
+		},
+	},
+	.edges = (struct rte_flow_graph_edge[]) {
+		[I40E_TUNNEL_NVGRE_NODE_START] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_NVGRE_NODE_OUTER_ETH,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_NVGRE_NODE_OUTER_ETH] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_NVGRE_NODE_IPV4,
+				I40E_TUNNEL_NVGRE_NODE_IPV6,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_NVGRE_NODE_IPV4] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_NVGRE_NODE_NVGRE,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_NVGRE_NODE_IPV6] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_NVGRE_NODE_NVGRE,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_NVGRE_NODE_NVGRE] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_NVGRE_NODE_INNER_ETH,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_NVGRE_NODE_INNER_ETH] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_NVGRE_NODE_INNER_VLAN,
+				I40E_TUNNEL_NVGRE_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_NVGRE_NODE_INNER_VLAN] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_NVGRE_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+	},
+};
+
 static int
 i40e_tunnel_action_check(const struct ci_flow_actions *actions,
 		const struct ci_flow_actions_check_param *param,
@@ -630,6 +828,15 @@ const struct ci_flow_engine_ops i40e_flow_engine_tunnel_ops = {
 	.flow_uninstall = i40e_tunnel_flow_uninstall,
 };
 
+const struct ci_flow_engine i40e_flow_engine_tunnel_nvgre = {
+	.name = "i40e_tunnel_nvgre",
+	.type = I40E_FLOW_ENGINE_TYPE_TUNNEL_NVGRE,
+	.ops = &i40e_flow_engine_tunnel_ops,
+	.ctx_size = sizeof(struct i40e_tunnel_ctx),
+	.flow_size = sizeof(struct i40e_tunnel_flow),
+	.graph = &i40e_tunnel_nvgre_graph,
+};
+
 const struct ci_flow_engine i40e_flow_engine_tunnel_vxlan = {
 	.name = "i40e_tunnel_vxlan",
 	.type = I40E_FLOW_ENGINE_TYPE_TUNNEL_VXLAN,
-- 
2.47.3

