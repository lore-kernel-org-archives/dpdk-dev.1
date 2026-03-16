Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB6BF53D82
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 17:29:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C2A4406BA;
	Mon, 16 Mar 2026 18:28:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 91A9A406BA
 for <dev@dpdk.org>; Mon, 16 Mar 2026 18:28:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773682095; x=1805218095;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=LoDV84vSGQUgEpHexAUTvVTqMWzqLXYMzGnbaSJmDTw=;
 b=T0gz5yDoGuqrazqXBzZCC4wgrc74x90FfBIrchsCpDhhPjDOOEC57F0g
 I4Todk9Ywm1F/mgNQwlDDIO4B361JLlgFiK12nHmzcnCRsYjEX59gX/PG
 eYQX7KfWMwKZgTBRspAWQiYZSzci0ZP1KDh6UlMNmHhAsKT2I2220jgxn
 n5fVKAvFzItx5itxDg6MF82RQ6RCwX+hKB+J4469gQJnReb/BNswU+6jM
 QBbctnQu04ACIwFM4XI8V9QCp9vmRz8Hb1HSf4OR0LYIn1ttBC+MwamXd
 bALu2kLUduMZ336x3RSME6zHFkAwOK6voEtHZi9vuCDIqaf2Ly7thuuuy g==;
X-CSE-ConnectionGUID: JwB5lzgWQkig4hZx3E4DAA==
X-CSE-MsgGUID: LPfhwxl1Rw+FC1Y/DzQDhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86059644"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="86059644"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 10:28:14 -0700
X-CSE-ConnectionGUID: jK8xAD2hTE+BEbYzGMGUSg==
X-CSE-MsgGUID: BxxrbzWhSLm8vR7+9RfFUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221228254"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 16 Mar 2026 10:28:13 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH v1 13/21] net/i40e: reimplement ethertype parser
Date: Mon, 16 Mar 2026 17:27:41 +0000
Message-ID: <afd0f89f33dbe6ebd8c8487622ca67303f3bf6bb.1773681365.git.anatoly.burakov@intel.com>
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
flow parser for Ethertype.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.h         |   1 -
 drivers/net/intel/i40e/i40e_flow.c           | 284 +------------------
 drivers/net/intel/i40e/i40e_flow.h           |   8 +
 drivers/net/intel/i40e/i40e_flow_ethertype.c | 258 +++++++++++++++++
 drivers/net/intel/i40e/meson.build           |   1 +
 5 files changed, 273 insertions(+), 279 deletions(-)
 create mode 100644 drivers/net/intel/i40e/i40e_flow_ethertype.c

diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 109ee7f278..118ba8a6c7 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -1311,7 +1311,6 @@ extern const struct rte_flow_ops i40e_flow_ops;
 
 struct i40e_filter_ctx {
 	union {
-		struct rte_eth_ethertype_filter ethertype_filter;
 		struct i40e_fdir_filter_conf fdir_filter;
 		struct i40e_tunnel_filter_conf consistent_tunnel_filter;
 		struct i40e_rte_flow_rss_conf rss_conf;
diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 2f9094bcc7..68155a58b4 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -29,7 +29,11 @@
 
 #include "../common/flow_check.h"
 
-const struct ci_flow_engine_list i40e_flow_engine_list = {0};
+const struct ci_flow_engine_list i40e_flow_engine_list = {
+	{
+		&i40e_flow_engine_ethertype,
+	}
+};
 
 #define I40E_IPV6_TC_MASK	(0xFF << I40E_FDIR_IPv6_TC_OFFSET)
 #define I40E_IPV6_FRAG_HEADER	44
@@ -58,15 +62,6 @@ static int i40e_flow_query(struct rte_eth_dev *dev,
 			   struct rte_flow *flow,
 			   const struct rte_flow_action *actions,
 			   void *data, struct rte_flow_error *error);
-static int
-i40e_flow_parse_ethertype_pattern(struct rte_eth_dev *dev,
-				  const struct rte_flow_item *pattern,
-				  struct rte_flow_error *error,
-				  struct rte_eth_ethertype_filter *filter);
-static int i40e_flow_parse_ethertype_action(struct rte_eth_dev *dev,
-				    const struct rte_flow_action *actions,
-				    struct rte_flow_error *error,
-				    struct rte_eth_ethertype_filter *filter);
 static int i40e_flow_parse_fdir_pattern(struct rte_eth_dev *dev,
 					const struct rte_flow_item *pattern,
 					struct rte_flow_error *error,
@@ -79,11 +74,6 @@ static int i40e_flow_parse_tunnel_action(struct rte_eth_dev *dev,
 				 const struct rte_flow_action *actions,
 				 struct rte_flow_error *error,
 				 struct i40e_tunnel_filter_conf *filter);
-static int i40e_flow_parse_ethertype_filter(struct rte_eth_dev *dev,
-				    const struct rte_flow_item pattern[],
-				    const struct rte_flow_action actions[],
-				    struct rte_flow_error *error,
-				    struct i40e_filter_ctx *filter);
 static int i40e_flow_parse_fdir_filter(struct rte_eth_dev *dev,
 				       const struct rte_flow_item pattern[],
 				       const struct rte_flow_action actions[],
@@ -109,12 +99,9 @@ static int i40e_flow_parse_gtp_filter(struct rte_eth_dev *dev,
 				      const struct rte_flow_action actions[],
 				      struct rte_flow_error *error,
 				      struct i40e_filter_ctx *filter);
-static int i40e_flow_destroy_ethertype_filter(struct i40e_pf *pf,
-				      struct i40e_ethertype_filter *filter);
 static int i40e_flow_destroy_tunnel_filter(struct i40e_pf *pf,
 					   struct i40e_tunnel_filter *filter);
 static int i40e_flow_flush_fdir_filter(struct i40e_pf *pf);
-static int i40e_flow_flush_ethertype_filter(struct i40e_pf *pf);
 static int i40e_flow_flush_tunnel_filter(struct i40e_pf *pf);
 static int
 i40e_flow_parse_qinq_filter(struct rte_eth_dev *dev,
@@ -984,8 +971,6 @@ static enum rte_flow_item_type pattern_fdir_ipv6_udp_esp[] = {
 };
 
 static struct i40e_valid_pattern i40e_supported_patterns[] = {
-	/* Ethertype */
-	{ pattern_ethertype, i40e_flow_parse_ethertype_filter },
 	/* FDIR - support default flow type without flexible payload*/
 	{ pattern_ethertype, i40e_flow_parse_fdir_filter },
 	{ pattern_fdir_ipv4, i40e_flow_parse_fdir_filter },
@@ -1197,7 +1182,7 @@ i40e_find_parse_filter_func(struct rte_flow_item *pattern, uint32_t *idx)
 	return parse_filter;
 }
 
-static int
+int
 i40e_get_outer_vlan(struct rte_eth_dev *dev, uint16_t *tpid)
 {
 	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
@@ -1224,181 +1209,6 @@ i40e_get_outer_vlan(struct rte_eth_dev *dev, uint16_t *tpid)
 	return 0;
 }
 
-/* 1. Last in item should be NULL as range is not supported.
- * 2. Supported filter types: MAC_ETHTYPE and ETHTYPE.
- * 3. SRC mac_addr mask should be 00:00:00:00:00:00.
- * 4. DST mac_addr mask should be 00:00:00:00:00:00 or
- *    FF:FF:FF:FF:FF:FF
- * 5. Ether_type mask should be 0xFFFF.
- */
-static int
-i40e_flow_parse_ethertype_pattern(struct rte_eth_dev *dev,
-				  const struct rte_flow_item *pattern,
-				  struct rte_flow_error *error,
-				  struct rte_eth_ethertype_filter *filter)
-{
-	const struct rte_flow_item *item = pattern;
-	const struct rte_flow_item_eth *eth_spec;
-	const struct rte_flow_item_eth *eth_mask;
-	enum rte_flow_item_type item_type;
-	int ret;
-	uint16_t tpid;
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
-			/* Get the MAC info. */
-			if (!eth_spec || !eth_mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "NULL ETH spec/mask");
-				return -rte_errno;
-			}
-
-			/* Mask bits of source MAC address must be full of 0.
-			 * Mask bits of destination MAC address must be full
-			 * of 1 or full of 0.
-			 */
-			if (!rte_is_zero_ether_addr(&eth_mask->hdr.src_addr) ||
-			    (!rte_is_zero_ether_addr(&eth_mask->hdr.dst_addr) &&
-			     !rte_is_broadcast_ether_addr(&eth_mask->hdr.dst_addr))) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid MAC_addr mask");
-				return -rte_errno;
-			}
-
-			if ((eth_mask->hdr.ether_type & UINT16_MAX) != UINT16_MAX) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid ethertype mask");
-				return -rte_errno;
-			}
-
-			/* If mask bits of destination MAC address
-			 * are full of 1, set RTE_ETHTYPE_FLAGS_MAC.
-			 */
-			if (rte_is_broadcast_ether_addr(&eth_mask->hdr.dst_addr)) {
-				filter->mac_addr = eth_spec->hdr.dst_addr;
-				filter->flags |= RTE_ETHTYPE_FLAGS_MAC;
-			} else {
-				filter->flags &= ~RTE_ETHTYPE_FLAGS_MAC;
-			}
-			filter->ether_type = rte_be_to_cpu_16(eth_spec->hdr.ether_type);
-
-			if (filter->ether_type == RTE_ETHER_TYPE_IPV4 ||
-			    filter->ether_type == RTE_ETHER_TYPE_IPV6 ||
-			    filter->ether_type == RTE_ETHER_TYPE_LLDP) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Unsupported ether_type in control packet filter.");
-				return -rte_errno;
-			}
-
-			ret = i40e_get_outer_vlan(dev, &tpid);
-			if (ret != 0) {
-				rte_flow_error_set(error, EIO,
-						RTE_FLOW_ERROR_TYPE_ITEM,
-						item,
-						"Can not get the Ethertype identifying the L2 tag");
-				return -rte_errno;
-			}
-			if (filter->ether_type == tpid) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Unsupported ether_type in"
-						   " control packet filter.");
-				return -rte_errno;
-			}
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
-/* Ethertype action only supports QUEUE or DROP. */
-static int
-i40e_flow_parse_ethertype_action(struct rte_eth_dev *dev,
-				 const struct rte_flow_action *actions,
-				 struct rte_flow_error *error,
-				 struct rte_eth_ethertype_filter *filter)
-{
-	struct ci_flow_actions parsed_actions = {0};
-	struct ci_flow_actions_check_param ac_param = {
-		.allowed_types = (enum rte_flow_action_type[]) {
-			RTE_FLOW_ACTION_TYPE_QUEUE,
-			RTE_FLOW_ACTION_TYPE_DROP,
-			RTE_FLOW_ACTION_TYPE_END,
-		},
-		.max_actions = 1,
-	};
-	const struct rte_flow_action *action;
-	int ret;
-
-	ret = ci_flow_check_actions(actions, &ac_param, &parsed_actions, error);
-	if (ret)
-		return ret;
-	action = parsed_actions.actions[0];
-
-	if (action->type == RTE_FLOW_ACTION_TYPE_QUEUE) {
-		const struct rte_flow_action_queue *act_q = action->conf;
-		/* check queue index */
-		if (act_q->index >= dev->data->nb_rx_queues) {
-			return rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ACTION, action,
-					"Invalid queue index");
-		}
-		filter->queue = act_q->index;
-	} else if (action->type == RTE_FLOW_ACTION_TYPE_DROP) {
-		filter->flags |= RTE_ETHTYPE_FLAGS_DROP;
-	}
-	return 0;
-}
-
-static int
-i40e_flow_parse_ethertype_filter(struct rte_eth_dev *dev,
-				 const struct rte_flow_item pattern[],
-				 const struct rte_flow_action actions[],
-				 struct rte_flow_error *error,
-				 struct i40e_filter_ctx *filter)
-{
-	struct rte_eth_ethertype_filter *ethertype_filter = &filter->ethertype_filter;
-	int ret;
-
-	ret = i40e_flow_parse_ethertype_pattern(dev, pattern, error,
-						ethertype_filter);
-	if (ret)
-		return ret;
-
-	ret = i40e_flow_parse_ethertype_action(dev, actions, error,
-					       ethertype_filter);
-	if (ret)
-		return ret;
-
-	filter->type = RTE_ETH_FILTER_ETHERTYPE;
-
-	return ret;
-}
-
 static int
 i40e_flow_check_raw_item(const struct rte_flow_item *item,
 			 const struct rte_flow_item_raw *raw_spec,
@@ -3877,13 +3687,6 @@ i40e_flow_create(struct rte_eth_dev *dev,
 	}
 
 	switch (filter_ctx.type) {
-	case RTE_ETH_FILTER_ETHERTYPE:
-		ret = i40e_ethertype_filter_set(pf, &filter_ctx.ethertype_filter, 1);
-		if (ret)
-			goto free_flow;
-		flow->rule = TAILQ_LAST(&pf->ethertype.ethertype_list,
-					i40e_ethertype_filter_list);
-		break;
 	case RTE_ETH_FILTER_FDIR:
 		ret = i40e_flow_add_del_fdir_filter(dev, &filter_ctx.fdir_filter, 1);
 		if (ret)
@@ -3944,10 +3747,6 @@ i40e_flow_destroy(struct rte_eth_dev *dev,
 		return 0;
 
 	switch (filter_type) {
-	case RTE_ETH_FILTER_ETHERTYPE:
-		ret = i40e_flow_destroy_ethertype_filter(pf,
-			 (struct i40e_ethertype_filter *)flow->rule);
-		break;
 	case RTE_ETH_FILTER_TUNNEL:
 		ret = i40e_flow_destroy_tunnel_filter(pf,
 			      (struct i40e_tunnel_filter *)flow->rule);
@@ -3987,41 +3786,6 @@ i40e_flow_destroy(struct rte_eth_dev *dev,
 	return ret;
 }
 
-static int
-i40e_flow_destroy_ethertype_filter(struct i40e_pf *pf,
-				   struct i40e_ethertype_filter *filter)
-{
-	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
-	struct i40e_ethertype_rule *ethertype_rule = &pf->ethertype;
-	struct i40e_ethertype_filter *node;
-	struct i40e_control_filter_stats stats;
-	uint16_t flags = 0;
-	int ret = 0;
-
-	if (!(filter->flags & RTE_ETHTYPE_FLAGS_MAC))
-		flags |= I40E_AQC_ADD_CONTROL_PACKET_FLAGS_IGNORE_MAC;
-	if (filter->flags & RTE_ETHTYPE_FLAGS_DROP)
-		flags |= I40E_AQC_ADD_CONTROL_PACKET_FLAGS_DROP;
-	flags |= I40E_AQC_ADD_CONTROL_PACKET_FLAGS_TO_QUEUE;
-
-	memset(&stats, 0, sizeof(stats));
-	ret = i40e_aq_add_rem_control_packet_filter(hw,
-				    filter->input.mac_addr.addr_bytes,
-				    filter->input.ether_type,
-				    flags, pf->main_vsi->seid,
-				    filter->queue, 0, &stats, NULL);
-	if (ret < 0)
-		return ret;
-
-	node = i40e_sw_ethertype_filter_lookup(ethertype_rule, &filter->input);
-	if (!node)
-		return -EINVAL;
-
-	ret = i40e_sw_ethertype_filter_del(pf, &node->input);
-
-	return ret;
-}
-
 static int
 i40e_flow_destroy_tunnel_filter(struct i40e_pf *pf,
 				struct i40e_tunnel_filter *filter)
@@ -4100,14 +3864,6 @@ i40e_flow_flush(struct rte_eth_dev *dev, struct rte_flow_error *error)
 		return -rte_errno;
 	}
 
-	ret = i40e_flow_flush_ethertype_filter(pf);
-	if (ret) {
-		rte_flow_error_set(error, -ret,
-				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-				   "Failed to ethertype flush flows.");
-		return -rte_errno;
-	}
-
 	ret = i40e_flow_flush_tunnel_filter(pf);
 	if (ret) {
 		rte_flow_error_set(error, -ret,
@@ -4184,34 +3940,6 @@ i40e_flow_flush_fdir_filter(struct i40e_pf *pf)
 	return ret;
 }
 
-/* Flush all ethertype filters */
-static int
-i40e_flow_flush_ethertype_filter(struct i40e_pf *pf)
-{
-	struct i40e_ethertype_filter_list
-		*ethertype_list = &pf->ethertype.ethertype_list;
-	struct i40e_ethertype_filter *filter;
-	struct rte_flow *flow;
-	void *temp;
-	int ret = 0;
-
-	while ((filter = TAILQ_FIRST(ethertype_list))) {
-		ret = i40e_flow_destroy_ethertype_filter(pf, filter);
-		if (ret)
-			return ret;
-	}
-
-	/* Delete ethertype flows in flow list. */
-	RTE_TAILQ_FOREACH_SAFE(flow, &pf->flow_list, node, temp) {
-		if (flow->filter_type == RTE_ETH_FILTER_ETHERTYPE) {
-			TAILQ_REMOVE(&pf->flow_list, flow, node);
-			rte_free(flow);
-		}
-	}
-
-	return ret;
-}
-
 /* Flush all tunnel filters */
 static int
 i40e_flow_flush_tunnel_filter(struct i40e_pf *pf)
diff --git a/drivers/net/intel/i40e/i40e_flow.h b/drivers/net/intel/i40e/i40e_flow.h
index c958868661..d6efd95216 100644
--- a/drivers/net/intel/i40e/i40e_flow.h
+++ b/drivers/net/intel/i40e/i40e_flow.h
@@ -7,6 +7,14 @@
 
 #include "../common/flow_engine.h"
 
+int i40e_get_outer_vlan(struct rte_eth_dev *dev, uint16_t *tpid);
+
+enum i40e_flow_engine_type {
+	I40E_FLOW_ENGINE_TYPE_ETHERTYPE = 0,
+};
+
 extern const struct ci_flow_engine_list i40e_flow_engine_list;
 
+extern const struct ci_flow_engine i40e_flow_engine_ethertype;
+
 #endif /* _I40E_FLOW_H_ */
diff --git a/drivers/net/intel/i40e/i40e_flow_ethertype.c b/drivers/net/intel/i40e/i40e_flow_ethertype.c
new file mode 100644
index 0000000000..2a2e03a764
--- /dev/null
+++ b/drivers/net/intel/i40e/i40e_flow_ethertype.c
@@ -0,0 +1,258 @@
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
+struct i40e_ethertype_ctx {
+	struct ci_flow_engine_ctx base;
+	struct rte_eth_ethertype_filter ethertype;
+};
+
+struct i40e_ethertype_flow {
+	struct rte_flow base;
+	struct rte_eth_ethertype_filter ethertype;
+};
+
+#define I40E_IPV6_FRAG_HEADER	44
+#define I40E_IPV6_TC_MASK	(0xFF << I40E_FDIR_IPv6_TC_OFFSET)
+#define I40E_VLAN_TCI_MASK	0xFFFF
+#define I40E_VLAN_PRI_MASK	0xE000
+#define I40E_VLAN_CFI_MASK	0x1000
+#define I40E_VLAN_VID_MASK	0x0FFF
+
+/**
+ * Ethertype filter graph implementation
+ * Pattern: START -> ETH -> END
+ */
+
+enum i40e_ethertype_node_id {
+	I40E_ETHERTYPE_NODE_START = RTE_FLOW_NODE_FIRST,
+	I40E_ETHERTYPE_NODE_ETH,
+	I40E_ETHERTYPE_NODE_END,
+	I40E_ETHERTYPE_NODE_MAX,
+};
+
+static int
+i40e_ethertype_node_eth_validate(const void *ctx __rte_unused,
+		const struct rte_flow_item *item, struct rte_flow_error *error)
+{
+	const struct rte_flow_item_eth *eth_spec = item->spec;
+	const struct rte_flow_item_eth *eth_mask = item->mask;
+	uint16_t ether_type;
+
+	/* Source MAC mask must be all zeros */
+	if (!CI_FIELD_IS_ZERO(&eth_mask->hdr.src_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Source MAC filtering not supported");
+	}
+
+	/* Dest MAC mask must be all zeros or all ones */
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&eth_mask->hdr.dst_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Dest MAC filtering not supported");
+	}
+
+	/* Ethertype mask must be exact match */
+	if (!CI_FIELD_IS_MASKED(&eth_mask->hdr.ether_type)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Ethertype must be exactly matched");
+	}
+
+	/* Check for valid ethertype (not IPv4/IPv6/LLDP) */
+	ether_type = rte_be_to_cpu_16(eth_spec->hdr.ether_type);
+	if (ether_type == RTE_ETHER_TYPE_IPV4 ||
+	    ether_type == RTE_ETHER_TYPE_IPV6 ||
+	    ether_type == RTE_ETHER_TYPE_VLAN ||
+	    ether_type == RTE_ETHER_TYPE_LLDP) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"IPv4/IPv6/LLDP not supported by ethertype filter");
+	}
+
+	return 0;
+}
+
+static int
+i40e_ethertype_node_eth_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_ethertype_ctx *ethertype_ctx = ctx;
+	struct rte_eth_ethertype_filter *filter = &ethertype_ctx->ethertype;
+	const struct rte_flow_item_eth *eth_spec = item->spec;
+	const struct rte_flow_item_eth *eth_mask = item->mask;
+	int ret;
+	uint16_t tpid, ether_type;
+
+	ether_type = rte_be_to_cpu_16(eth_spec->hdr.ether_type);
+
+	if (CI_FIELD_IS_MASKED(&eth_mask->hdr.dst_addr)) {
+		filter->mac_addr = eth_spec->hdr.dst_addr;
+		filter->flags |= RTE_ETHTYPE_FLAGS_MAC;
+	}
+
+	ret = i40e_get_outer_vlan(ethertype_ctx->base.dev, &tpid);
+	if (ret != 0) {
+		return rte_flow_error_set(error, EIO,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Can not get the Ethertype identifying the L2 tag");
+	}
+	if (ether_type == tpid) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Unsupported ether_type in control packet filter.");
+	}
+	filter->ether_type = ether_type;
+
+	return 0;
+}
+
+const struct rte_flow_graph i40e_ethertype_graph = {
+	.nodes = (struct rte_flow_graph_node[]) {
+		[I40E_ETHERTYPE_NODE_START] = {
+			.name = "START",
+		},
+		[I40E_ETHERTYPE_NODE_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_ethertype_node_eth_validate,
+			.process = i40e_ethertype_node_eth_process,
+		},
+		[I40E_ETHERTYPE_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	},
+	.edges = (struct rte_flow_graph_edge[]) {
+		[I40E_ETHERTYPE_NODE_START] = {
+			.next = (const size_t[]) {
+				I40E_ETHERTYPE_NODE_ETH,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_ETHERTYPE_NODE_ETH] = {
+			.next = (const size_t[]) {
+				I40E_ETHERTYPE_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+static int
+i40e_flow_ethertype_ctx_parse(const struct rte_flow_action *actions,
+		const struct rte_flow_attr *attr,
+		struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	struct i40e_ethertype_ctx *ethertype_ctx = (struct i40e_ethertype_ctx *)ctx;
+	struct rte_eth_dev *dev = ethertype_ctx->base.dev;
+	struct ci_flow_actions parsed_actions = {0};
+	struct ci_flow_actions_check_param ac_param = {
+		.allowed_types = (enum rte_flow_action_type[]) {
+			RTE_FLOW_ACTION_TYPE_QUEUE,
+			RTE_FLOW_ACTION_TYPE_DROP,
+			RTE_FLOW_ACTION_TYPE_END,
+		},
+		.max_actions = 1,
+	};
+	const struct rte_flow_action *action;
+	int ret;
+
+	ret = ci_flow_check_actions(actions, &ac_param, &parsed_actions, error);
+	if (ret)
+		return ret;
+
+	ret = ci_flow_check_attr(attr, NULL, error);
+	if (ret)
+		return ret;
+
+	action = parsed_actions.actions[0];
+
+	if (action->type == RTE_FLOW_ACTION_TYPE_QUEUE) {
+		const struct rte_flow_action_queue *act_q = action->conf;
+		/* check queue index */
+		if (act_q->index >= dev->data->nb_rx_queues) {
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ACTION, action,
+					"Invalid queue index");
+		}
+		ethertype_ctx->ethertype.queue = act_q->index;
+	} else if (action->type == RTE_FLOW_ACTION_TYPE_DROP) {
+		ethertype_ctx->ethertype.flags |= RTE_ETHTYPE_FLAGS_DROP;
+	}
+	return 0;
+}
+
+static int
+i40e_flow_ethertype_ctx_to_flow(const struct ci_flow_engine_ctx *ctx,
+		struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct i40e_ethertype_ctx *ethertype_ctx = (const struct i40e_ethertype_ctx *)ctx;
+	struct i40e_ethertype_flow *ethertype_flow = (struct i40e_ethertype_flow *)flow;
+
+	/* copy ethertype filter configuration to flow */
+	ethertype_flow->ethertype = ethertype_ctx->ethertype;
+
+	return 0;
+}
+
+static int
+i40e_flow_ethertype_install(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct i40e_ethertype_flow *ethertype_flow = (struct i40e_ethertype_flow *)flow;
+	struct rte_eth_dev *dev = flow->dev;
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	int ret;
+
+	ret = i40e_ethertype_filter_set(pf, &ethertype_flow->ethertype, true);
+	if (ret) {
+		return rte_flow_error_set(error, EIO,
+				RTE_FLOW_ERROR_TYPE_HANDLE, flow,
+				"Failed to install ethertype filter");
+	}
+	return 0;
+}
+
+static int
+i40e_flow_ethertype_uninstall(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct i40e_ethertype_flow *ethertype_flow = (struct i40e_ethertype_flow *)flow;
+	struct rte_eth_dev *dev = flow->dev;
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	int ret;
+
+	ret = i40e_ethertype_filter_set(pf, &ethertype_flow->ethertype, false);
+	if (ret) {
+		return rte_flow_error_set(error, EIO,
+				RTE_FLOW_ERROR_TYPE_HANDLE, flow,
+				"Failed to install ethertype filter");
+	}
+	return 0;
+}
+
+const struct ci_flow_engine_ops i40e_flow_engine_ethertype_ops = {
+	.ctx_parse = i40e_flow_ethertype_ctx_parse,
+	.ctx_to_flow = i40e_flow_ethertype_ctx_to_flow,
+	.flow_install = i40e_flow_ethertype_install,
+	.flow_uninstall = i40e_flow_ethertype_uninstall,
+};
+
+const struct ci_flow_engine i40e_flow_engine_ethertype = {
+	.name = "i40e_ethertype",
+	.ctx_size = sizeof(struct i40e_ethertype_ctx),
+	.flow_size = sizeof(struct i40e_ethertype_flow),
+	.type = I40E_FLOW_ENGINE_TYPE_ETHERTYPE,
+	.ops = &i40e_flow_engine_ethertype_ops,
+	.graph = &i40e_ethertype_graph,
+};
diff --git a/drivers/net/intel/i40e/meson.build b/drivers/net/intel/i40e/meson.build
index bccae1ffc1..bff0518fc9 100644
--- a/drivers/net/intel/i40e/meson.build
+++ b/drivers/net/intel/i40e/meson.build
@@ -25,6 +25,7 @@ sources += files(
         'i40e_pf.c',
         'i40e_fdir.c',
         'i40e_flow.c',
+        'i40e_flow_ethertype.c',
         'i40e_tm.c',
         'i40e_hash.c',
         'i40e_vf_representor.c',
-- 
2.47.3

