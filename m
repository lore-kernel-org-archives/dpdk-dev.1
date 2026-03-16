Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3994CF53D7E
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 17:30:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C7B340DCD;
	Mon, 16 Mar 2026 18:28:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id ABB3640A82
 for <dev@dpdk.org>; Mon, 16 Mar 2026 18:28:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773682099; x=1805218099;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=XrVb9xA9BNwfeh7miHnc9eTf7tGN0+vdkr43r89WeKE=;
 b=QwZ0wGGpnPRKA5Y8UCsQRskaRV+frIxIYqyR7QEP75X8Schc0Ljh9I/J
 7NLbUVVvO/nuKHX8JtIom69uSth0zDnUiWSlUOYgZcqWc2hrjfQO5ScFa
 MAz6jQcvkzC5FvAREsXGDF3cLuxmvwX2A86qFjuQqZtN0XElai3POZ88F
 tuIvIARf/yP5DITtMhV2+t6uLXtovBoe1jwTMIx5kHPKut3a5JlaopIjp
 ANUdg4T9XrjKbvke0TfLjBAaYKMwpSf3Wtl/hUK4Yi2I9n9lY2N2+iMVA
 lOsPC+XxlfrRyzAPrEE2yRZzay8rVyNxCz9sxb5PZRX2s33Ii+yd7yy2j A==;
X-CSE-ConnectionGUID: S5OLTIKERYW2WZclNTpbKw==
X-CSE-MsgGUID: 7W6fMgpLTcKqxTT36FAFxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86059654"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="86059654"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 10:28:18 -0700
X-CSE-ConnectionGUID: /wF4VggLTuWByzQvQvfZiA==
X-CSE-MsgGUID: 7cYYo3StRQyKtl6+smpe7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221228276"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 16 Mar 2026 10:28:17 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH v1 16/21] net/i40e: reimplement VXLAN parser
Date: Mon, 16 Mar 2026 17:27:44 +0000
Message-ID: <9d5943a44ffb70d8fc4b907e04fb26eceaa85507.1773681366.git.anatoly.burakov@intel.com>
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
flow parser for VXLAN tunnels.

For VLAN nodes we will use existing VLAN node validation which is more
stringent, so we no longer allow any non-zero `vlan_tci` mask, only full
mask.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_flow.c        | 295 +-------------------
 drivers/net/intel/i40e/i40e_flow.h        |   3 +
 drivers/net/intel/i40e/i40e_flow_tunnel.c | 311 ++++++++++++++++++++++
 3 files changed, 325 insertions(+), 284 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 3ca528a1f3..1b1547a8ac 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -34,6 +34,7 @@ const struct ci_flow_engine_list i40e_flow_engine_list = {
 		&i40e_flow_engine_ethertype,
 		&i40e_flow_engine_fdir,
 		&i40e_flow_engine_tunnel_qinq,
+		&i40e_flow_engine_tunnel_vxlan,
 	}
 };
 
@@ -65,11 +66,6 @@ static int i40e_flow_parse_tunnel_action(struct rte_eth_dev *dev,
 				 const struct rte_flow_action *actions,
 				 struct rte_flow_error *error,
 				 struct i40e_tunnel_filter_conf *filter);
-static int i40e_flow_parse_vxlan_filter(struct rte_eth_dev *dev,
-					const struct rte_flow_item pattern[],
-					const struct rte_flow_action actions[],
-					struct rte_flow_error *error,
-					struct i40e_filter_ctx *filter);
 static int i40e_flow_parse_nvgre_filter(struct rte_eth_dev *dev,
 					const struct rte_flow_item pattern[],
 					const struct rte_flow_action actions[],
@@ -177,44 +173,6 @@ static enum rte_flow_item_type pattern_fdir_ipv6_gtpu[] = {
 };
 
 /* Pattern matched tunnel filter */
-static enum rte_flow_item_type pattern_vxlan_1[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_VXLAN,
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_vxlan_2[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_VXLAN,
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_vxlan_3[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_VXLAN,
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_vxlan_4[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_VXLAN,
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
 static enum rte_flow_item_type pattern_nvgre_1[] = {
 	RTE_FLOW_ITEM_TYPE_ETH,
 	RTE_FLOW_ITEM_TYPE_IPV4,
@@ -282,11 +240,6 @@ static enum rte_flow_item_type pattern_mpls_4[] = {
 };
 
 static struct i40e_valid_pattern i40e_supported_patterns[] = {
-	/* VXLAN */
-	{ pattern_vxlan_1, i40e_flow_parse_vxlan_filter },
-	{ pattern_vxlan_2, i40e_flow_parse_vxlan_filter },
-	{ pattern_vxlan_3, i40e_flow_parse_vxlan_filter },
-	{ pattern_vxlan_4, i40e_flow_parse_vxlan_filter },
 	/* NVGRE */
 	{ pattern_nvgre_1, i40e_flow_parse_nvgre_filter },
 	{ pattern_nvgre_2, i40e_flow_parse_nvgre_filter },
@@ -776,253 +729,27 @@ i40e_flow_parse_l4_cloud_filter(struct rte_eth_dev *dev,
 	return ret;
 }
 
-static uint16_t i40e_supported_tunnel_filter_types[] = {
-	RTE_ETH_TUNNEL_FILTER_IMAC | RTE_ETH_TUNNEL_FILTER_TENID |
-	RTE_ETH_TUNNEL_FILTER_IVLAN,
-	RTE_ETH_TUNNEL_FILTER_IMAC | RTE_ETH_TUNNEL_FILTER_IVLAN,
-	RTE_ETH_TUNNEL_FILTER_IMAC | RTE_ETH_TUNNEL_FILTER_TENID,
-	RTE_ETH_TUNNEL_FILTER_OMAC | RTE_ETH_TUNNEL_FILTER_TENID |
-	RTE_ETH_TUNNEL_FILTER_IMAC,
-	RTE_ETH_TUNNEL_FILTER_IMAC,
-};
-
-static int
+int
 i40e_check_tunnel_filter_type(uint8_t filter_type)
 {
+	const uint16_t i40e_supported_tunnel_filter_types[] = {
+		RTE_ETH_TUNNEL_FILTER_IMAC | RTE_ETH_TUNNEL_FILTER_TENID |
+		RTE_ETH_TUNNEL_FILTER_IVLAN,
+		RTE_ETH_TUNNEL_FILTER_IMAC | RTE_ETH_TUNNEL_FILTER_IVLAN,
+		RTE_ETH_TUNNEL_FILTER_IMAC | RTE_ETH_TUNNEL_FILTER_TENID,
+		RTE_ETH_TUNNEL_FILTER_OMAC | RTE_ETH_TUNNEL_FILTER_TENID |
+		RTE_ETH_TUNNEL_FILTER_IMAC,
+		RTE_ETH_TUNNEL_FILTER_IMAC,
+	};
 	uint8_t i;
 
 	for (i = 0; i < RTE_DIM(i40e_supported_tunnel_filter_types); i++) {
 		if (filter_type == i40e_supported_tunnel_filter_types[i])
 			return 0;
 	}
-
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
-i40e_flow_parse_vxlan_pattern(__rte_unused struct rte_eth_dev *dev,
-			      const struct rte_flow_item *pattern,
-			      struct rte_flow_error *error,
-			      struct i40e_tunnel_filter_conf *filter)
-{
-	const struct rte_flow_item *item = pattern;
-	const struct rte_flow_item_eth *eth_spec;
-	const struct rte_flow_item_eth *eth_mask;
-	const struct rte_flow_item_vxlan *vxlan_spec;
-	const struct rte_flow_item_vxlan *vxlan_mask;
-	const struct rte_flow_item_vlan *vlan_spec;
-	const struct rte_flow_item_vlan *vlan_mask;
-	uint8_t filter_type = 0;
-	bool is_vni_masked = 0;
-	uint8_t vni_mask[] = {0xFF, 0xFF, 0xFF};
-	enum rte_flow_item_type item_type;
-	bool vxlan_flag = 0;
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
-				if (!vxlan_flag) {
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
-		case RTE_FLOW_ITEM_TYPE_UDP:
-			/* UDP is used to describe protocol,
-			 * spec and mask should be NULL.
-			 */
-			if (item->spec || item->mask) {
-				rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ITEM,
-					   item,
-					   "Invalid UDP item");
-				return -rte_errno;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_VXLAN:
-			vxlan_spec = item->spec;
-			vxlan_mask = item->mask;
-			/* Check if VXLAN item is used to describe protocol.
-			 * If yes, both spec and mask should be NULL.
-			 * If no, both spec and mask shouldn't be NULL.
-			 */
-			if ((!vxlan_spec && vxlan_mask) ||
-			    (vxlan_spec && !vxlan_mask)) {
-				rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ITEM,
-					   item,
-					   "Invalid VXLAN item");
-				return -rte_errno;
-			}
-
-			/* Check if VNI is masked. */
-			if (vxlan_spec && vxlan_mask) {
-				is_vni_masked =
-					!!memcmp(vxlan_mask->hdr.vni, vni_mask,
-						 RTE_DIM(vni_mask));
-				if (is_vni_masked) {
-					rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid VNI mask");
-					return -rte_errno;
-				}
-
-				rte_memcpy(((uint8_t *)&tenant_id_be + 1),
-					   vxlan_spec->hdr.vni, 3);
-				filter->tenant_id =
-					rte_be_to_cpu_32(tenant_id_be);
-				filter_type |= RTE_ETH_TUNNEL_FILTER_TENID;
-			}
-
-			vxlan_flag = 1;
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
-	filter->tunnel_type = I40E_TUNNEL_TYPE_VXLAN;
-
-	return 0;
-}
-
-static int
-i40e_flow_parse_vxlan_filter(struct rte_eth_dev *dev,
-			     const struct rte_flow_item pattern[],
-			     const struct rte_flow_action actions[],
-			     struct rte_flow_error *error,
-			     struct i40e_filter_ctx *filter)
-{
-	struct i40e_tunnel_filter_conf *tunnel_filter = &filter->consistent_tunnel_filter;
-	int ret;
-
-	ret = i40e_flow_parse_vxlan_pattern(dev, pattern,
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
-
 /* 1. Last in item should be NULL as range is not supported.
  * 2. Supported filter types: IMAC_IVLAN_TENID, IMAC_IVLAN,
  *    IMAC_TENID, OMAC_TENID_IMAC and IMAC.
diff --git a/drivers/net/intel/i40e/i40e_flow.h b/drivers/net/intel/i40e/i40e_flow.h
index c578351eb4..0981b4569a 100644
--- a/drivers/net/intel/i40e/i40e_flow.h
+++ b/drivers/net/intel/i40e/i40e_flow.h
@@ -12,11 +12,13 @@ uint8_t
 i40e_flow_fdir_get_pctype_value(struct i40e_pf *pf,
 		enum rte_flow_item_type item_type,
 		struct i40e_fdir_filter_conf *filter);
+int i40e_check_tunnel_filter_type(uint8_t filter_type);
 
 enum i40e_flow_engine_type {
 	I40E_FLOW_ENGINE_TYPE_ETHERTYPE = 0,
 	I40E_FLOW_ENGINE_TYPE_FDIR,
 	I40E_FLOW_ENGINE_TYPE_TUNNEL_QINQ,
+	I40E_FLOW_ENGINE_TYPE_TUNNEL_VXLAN,
 };
 
 extern const struct ci_flow_engine_list i40e_flow_engine_list;
@@ -24,5 +26,6 @@ extern const struct ci_flow_engine_list i40e_flow_engine_list;
 extern const struct ci_flow_engine i40e_flow_engine_ethertype;
 extern const struct ci_flow_engine i40e_flow_engine_fdir;
 extern const struct ci_flow_engine i40e_flow_engine_tunnel_qinq;
+extern const struct ci_flow_engine i40e_flow_engine_tunnel_vxlan;
 
 #endif /* _I40E_FLOW_H_ */
diff --git a/drivers/net/intel/i40e/i40e_flow_tunnel.c b/drivers/net/intel/i40e/i40e_flow_tunnel.c
index 621354d6ea..ec6107dde0 100644
--- a/drivers/net/intel/i40e/i40e_flow_tunnel.c
+++ b/drivers/net/intel/i40e/i40e_flow_tunnel.c
@@ -166,6 +166,308 @@ const struct rte_flow_graph i40e_tunnel_qinq_graph = {
 	},
 };
 
+/**
+ * VXLAN tunnel filter graph implementation
+ * Pattern: START -> ETH -> (IPv4 | IPv6) -> UDP -> VXLAN -> ETH -> [VLAN] -> END
+ */
+enum i40e_tunnel_vxlan_node_id {
+	I40E_TUNNEL_VXLAN_NODE_START  = RTE_FLOW_NODE_FIRST,
+	I40E_TUNNEL_VXLAN_NODE_OUTER_ETH,
+	I40E_TUNNEL_VXLAN_NODE_IPV4,
+	I40E_TUNNEL_VXLAN_NODE_IPV6,
+	I40E_TUNNEL_VXLAN_NODE_UDP,
+	I40E_TUNNEL_VXLAN_NODE_VXLAN,
+	I40E_TUNNEL_VXLAN_NODE_INNER_ETH,
+	I40E_TUNNEL_VXLAN_NODE_INNER_VLAN,
+	I40E_TUNNEL_VXLAN_NODE_END,
+	I40E_TUNNEL_VXLAN_NODE_MAX,
+};
+
+static int
+i40e_tunnel_node_eth_validate(const void *ctx __rte_unused, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_item_eth *eth_spec = item->spec;
+	const struct rte_flow_item_eth *eth_mask = item->mask;
+
+	/* spec/mask is optional */
+	if (eth_spec == NULL && eth_mask == NULL)
+		return 0;
+
+	/* matching eth type not supported */
+	if (eth_mask->hdr.ether_type) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid ETH mask");
+	}
+
+	/* source MAC must be fully unmasked */
+	if (!CI_FIELD_IS_ZERO(&eth_mask->hdr.src_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid ETH mask");
+	}
+	/* destination MAC must be fully masked */
+	if (!CI_FIELD_IS_MASKED(&eth_mask->hdr.dst_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid ETH mask");
+	}
+
+	return 0;
+}
+
+static int
+i40e_tunnel_eth_process(struct i40e_tunnel_ctx *tunnel_ctx,
+		const struct rte_flow_item *item, bool is_inner)
+{
+	const struct rte_flow_item_eth *eth_spec = item->spec;
+	const struct rte_flow_item_eth *eth_mask = item->mask;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	/* eth spec/mask is optional */
+	if (eth_spec == NULL && eth_mask == NULL)
+		return 0;
+
+	/* Store the MAC addresses and set filter flags */
+	if (is_inner) {
+		memcpy(&tunnel_filter->inner_mac, &eth_spec->hdr.dst_addr,
+				sizeof(tunnel_filter->inner_mac));
+		tunnel_filter->filter_type |= RTE_ETH_TUNNEL_FILTER_IMAC;
+	} else {
+		memcpy(&tunnel_filter->outer_mac, &eth_spec->hdr.dst_addr,
+				sizeof(tunnel_filter->outer_mac));
+		tunnel_filter->filter_type |= RTE_ETH_TUNNEL_FILTER_OMAC;
+	}
+	return 0;
+}
+
+static int
+i40e_tunnel_node_outer_eth_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+
+	return i40e_tunnel_eth_process(tunnel_ctx, item, false);
+}
+
+static int
+i40e_tunnel_inner_eth_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+
+	return i40e_tunnel_eth_process(tunnel_ctx, item, true);
+}
+
+static int
+i40e_tunnel_node_ipv4_process(void *ctx, const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	tunnel_filter->ip_type = I40E_TUNNEL_IPTYPE_IPV4;
+
+	return 0;
+}
+
+static int
+i40e_tunnel_node_ipv6_process(void *ctx, const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	tunnel_filter->ip_type = I40E_TUNNEL_IPTYPE_IPV6;
+
+	return 0;
+}
+
+static int
+i40e_tunnel_node_vxlan_validate(const void *ctx __rte_unused,
+		const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct rte_flow_item_vxlan *vxlan_spec = item->spec;
+	const struct rte_flow_item_vxlan *vxlan_mask = item->mask;
+
+	/* spec/mask are optional */
+	if (vxlan_spec == NULL && vxlan_mask == NULL)
+		return 0;
+
+	/* VNI must be fully masked */
+	if (!CI_FIELD_IS_MASKED(&vxlan_mask->hdr.vni)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid VXLAN mask");
+	}
+	return 0;
+}
+
+static int
+i40e_tunnel_node_vxlan_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct rte_flow_item_vxlan *vxlan_spec = item->spec;
+	const struct rte_flow_item_vxlan *vxlan_mask = item->mask;
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	/* spec/mask are optional */
+	if (vxlan_spec == NULL && vxlan_mask == NULL)
+		return 0;
+
+	/* Store the VNI and set filter flag */
+	tunnel_filter->tenant_id = ci_be24_to_cpu(vxlan_spec->hdr.vni);
+	tunnel_filter->filter_type |= RTE_ETH_TUNNEL_FILTER_TENID;
+
+	return 0;
+}
+
+static int
+i40e_tunnel_node_end_validate(const void *ctx,
+		const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	const struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	/* this shouldn't happen but check this just in case */
+	if (i40e_check_tunnel_filter_type(tunnel_filter->filter_type) != 0) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid tunnel filter configuration");
+	}
+	return 0;
+}
+
+static int
+i40e_tunnel_vxlan_node_end_process(void *ctx, const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
+
+	tunnel_filter->tunnel_type = I40E_TUNNEL_TYPE_VXLAN;
+
+	return 0;
+}
+
+const struct rte_flow_graph i40e_tunnel_vxlan_graph = {
+	.nodes = (struct rte_flow_graph_node[]) {
+		[I40E_TUNNEL_VXLAN_NODE_START] = {
+			.name = "START",
+		},
+		[I40E_TUNNEL_VXLAN_NODE_OUTER_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY |
+			               RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_eth_validate,
+			.process = i40e_tunnel_node_outer_eth_process,
+		},
+		[I40E_TUNNEL_VXLAN_NODE_IPV4] = {
+			.name = "IPv4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+			.process = i40e_tunnel_node_ipv4_process,
+		},
+		[I40E_TUNNEL_VXLAN_NODE_IPV6] = {
+			.name = "IPv6",
+			.type = RTE_FLOW_ITEM_TYPE_IPV6,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+			.process = i40e_tunnel_node_ipv6_process,
+		},
+		[I40E_TUNNEL_VXLAN_NODE_UDP] = {
+			.name = "UDP",
+			.type = RTE_FLOW_ITEM_TYPE_UDP,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+		},
+		[I40E_TUNNEL_VXLAN_NODE_VXLAN] = {
+			.name = "VXLAN",
+			.type = RTE_FLOW_ITEM_TYPE_VXLAN,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY |
+			               RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_vxlan_validate,
+			.process = i40e_tunnel_node_vxlan_process,
+		},
+		[I40E_TUNNEL_VXLAN_NODE_INNER_ETH] = {
+			.name = "INNER_ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY |
+			               RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_eth_validate,
+			.process = i40e_tunnel_inner_eth_process,
+		},
+		[I40E_TUNNEL_VXLAN_NODE_INNER_VLAN] = {
+			.name = "INNER_VLAN",
+			.type = RTE_FLOW_ITEM_TYPE_VLAN,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_tunnel_node_vlan_validate,
+			.process = i40e_tunnel_node_inner_vlan_process,
+		},
+		[I40E_TUNNEL_VXLAN_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+			.validate = i40e_tunnel_node_end_validate,
+			.process = i40e_tunnel_vxlan_node_end_process
+		},
+	},
+	.edges = (struct rte_flow_graph_edge[]) {
+		[I40E_TUNNEL_VXLAN_NODE_START] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_VXLAN_NODE_OUTER_ETH,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_VXLAN_NODE_OUTER_ETH] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_VXLAN_NODE_IPV4,
+				I40E_TUNNEL_VXLAN_NODE_IPV6,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_VXLAN_NODE_IPV4] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_VXLAN_NODE_UDP,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_VXLAN_NODE_IPV6] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_VXLAN_NODE_UDP,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_VXLAN_NODE_UDP] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_VXLAN_NODE_VXLAN,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_VXLAN_NODE_VXLAN] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_VXLAN_NODE_INNER_ETH,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_VXLAN_NODE_INNER_ETH] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_VXLAN_NODE_INNER_VLAN,
+				I40E_TUNNEL_VXLAN_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_TUNNEL_VXLAN_NODE_INNER_VLAN] = {
+			.next = (const size_t[]) {
+				I40E_TUNNEL_VXLAN_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+	},
+};
+
 static int
 i40e_tunnel_action_check(const struct ci_flow_actions *actions,
 		const struct ci_flow_actions_check_param *param,
@@ -328,6 +630,15 @@ const struct ci_flow_engine_ops i40e_flow_engine_tunnel_ops = {
 	.flow_uninstall = i40e_tunnel_flow_uninstall,
 };
 
+const struct ci_flow_engine i40e_flow_engine_tunnel_vxlan = {
+	.name = "i40e_tunnel_vxlan",
+	.type = I40E_FLOW_ENGINE_TYPE_TUNNEL_VXLAN,
+	.ops = &i40e_flow_engine_tunnel_ops,
+	.ctx_size = sizeof(struct i40e_tunnel_ctx),
+	.flow_size = sizeof(struct i40e_tunnel_flow),
+	.graph = &i40e_tunnel_vxlan_graph,
+};
+
 const struct ci_flow_engine i40e_flow_engine_tunnel_qinq = {
 	.name = "i40e_tunnel_qinq",
 	.type = I40E_FLOW_ENGINE_TYPE_TUNNEL_QINQ,
-- 
2.47.3

