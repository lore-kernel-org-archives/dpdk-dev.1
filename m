Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76904C5DF87
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 14:03:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2B3F40E11;
	Thu, 20 Aug 2026 16:02:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 0B43140DF5
 for <dev@dpdk.org>; Thu, 20 Aug 2026 16:02:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787234525; x=1818770525;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=GJLr+jo93DqXSTNUQwUL+FGx5AozrmNDWSgZYoOc2Bw=;
 b=Xr30Ews3v/cKDhNGPuE4TpISsmPsRjtb1KU1e3a7bIp+Snsjbgu8EgL4
 ZiS2YnnM3+dMECrQ1PyvO/SRou6KxgO0JXoUQ8HctmPJLPMf3rP/IIJTm
 0frtw1XTXAzpcgvDRRWYZmeW9+jZQAWRdgObpmHAqzT0gnjrKCRqKYs6M
 Cz0xFp+DOJqOsQhM4ECwLkqAQOtTMitnMh2ZhU09+tIL3QhddawQIjEyo
 hF6GGrah05RBxhcnIPxQ9PTa2jJrPvgwexcyx6EiyrHI/2/JTp6rC94by
 dbY4zG7x3/2YMqdbJMHwHCCxT6MHsPtimjtrHWRAjBpI353j6OAp4HPcs Q==;
X-CSE-ConnectionGUID: 0LmG3JyTRqqzVVjhSoFOjQ==
X-CSE-MsgGUID: veVlaaweSrKvp/p8XJjURA==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="75300341"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="75300341"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 07:02:05 -0700
X-CSE-ConnectionGUID: ikcUDFC/To6EyBMybSlokw==
X-CSE-MsgGUID: jyAhGLcQRZGhATBMAiQrXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="264719735"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 20 Aug 2026 07:02:02 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 13/21] net/i40e: reimplement ethertype parser
Date: Thu, 20 Aug 2026 15:00:58 +0100
Message-ID: <461b3eee3e1369bb8155cf0c5fe849e154dbf82a.1787233988.git.anatoly.burakov@intel.com>
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
flow parser for Ethertype.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.h         |   1 -
 drivers/net/intel/i40e/i40e_flow.c           | 294 +------------------
 drivers/net/intel/i40e/i40e_flow.h           |   4 +
 drivers/net/intel/i40e/i40e_flow_ethertype.c | 250 ++++++++++++++++
 drivers/net/intel/i40e/meson.build           |   1 +
 5 files changed, 266 insertions(+), 284 deletions(-)
 create mode 100644 drivers/net/intel/i40e/i40e_flow_ethertype.c

diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 16b67268f7..db04b7de22 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -1325,7 +1325,6 @@ extern const struct rte_flow_ops i40e_flow_ops;
 
 struct i40e_filter_ctx {
 	union {
-		struct rte_eth_ethertype_filter ethertype_filter;
 		struct i40e_fdir_filter_conf fdir_filter;
 		struct i40e_tunnel_filter_conf consistent_tunnel_filter;
 		struct i40e_rte_flow_rss_conf rss_conf;
diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index b8b4e56414..9d52abf6d8 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -30,7 +30,11 @@
 
 #include "../common/flow_check.h"
 
-const struct ci_flow_engine_list i40e_flow_engine_list = {0};
+const struct ci_flow_engine_list i40e_flow_engine_list = {
+	{
+		&i40e_flow_engine_ethertype,
+	}
+};
 
 #define I40E_IPV6_TC_MASK	(0xFF << I40E_FDIR_IPv6_TC_OFFSET)
 #define I40E_IPV6_FRAG_HEADER	44
@@ -60,15 +64,6 @@ static int i40e_flow_dev_dump(struct rte_eth_dev *dev,
 			      struct rte_flow *flow,
 			      FILE *file,
 			      struct rte_flow_error *error);
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
@@ -81,11 +76,6 @@ static int i40e_flow_parse_tunnel_action(struct rte_eth_dev *dev,
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
@@ -111,12 +101,9 @@ static int i40e_flow_parse_gtp_filter(struct rte_eth_dev *dev,
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
@@ -987,8 +974,6 @@ static enum rte_flow_item_type pattern_fdir_ipv6_udp_esp[] = {
 };
 
 static struct i40e_valid_pattern i40e_supported_patterns[] = {
-	/* Ethertype */
-	{ pattern_ethertype, i40e_flow_parse_ethertype_filter },
 	/* FDIR - support default flow type without flexible payload*/
 	{ pattern_ethertype, i40e_flow_parse_fdir_filter },
 	{ pattern_fdir_ipv4, i40e_flow_parse_fdir_filter },
@@ -1324,11 +1309,11 @@ i40e_flow_dev_dump(struct rte_eth_dev *dev,
 	return 0;
 }
 
-static int
-i40e_get_outer_vlan(struct rte_eth_dev *dev, uint16_t *tpid)
+int
+i40e_get_outer_vlan(struct i40e_pf *pf, uint16_t *tpid)
 {
-	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	int qinq = dev->data->dev_conf.rxmode.offloads &
+	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
+	int qinq = pf->dev_data->dev_conf.rxmode.offloads &
 		RTE_ETH_RX_OFFLOAD_VLAN_EXTEND;
 	uint64_t reg_r = 0;
 	uint16_t reg_id;
@@ -1351,181 +1336,6 @@ i40e_get_outer_vlan(struct rte_eth_dev *dev, uint16_t *tpid)
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
@@ -1786,7 +1596,7 @@ i40e_flow_parse_fdir_pattern(struct rte_eth_dev *dev,
 						     "Unsupported ether_type.");
 					return -rte_errno;
 				}
-				ret = i40e_get_outer_vlan(dev, &tpid);
+				ret = i40e_get_outer_vlan(pf, &tpid);
 				if (ret != 0) {
 					rte_flow_error_set(error, EIO,
 							RTE_FLOW_ERROR_TYPE_ITEM,
@@ -1852,7 +1662,7 @@ i40e_flow_parse_fdir_pattern(struct rte_eth_dev *dev,
 						     "Unsupported inner_type.");
 					return -rte_errno;
 				}
-				ret = i40e_get_outer_vlan(dev, &tpid);
+				ret = i40e_get_outer_vlan(pf, &tpid);
 				if (ret != 0) {
 					rte_flow_error_set(error, EIO,
 							RTE_FLOW_ERROR_TYPE_ITEM,
@@ -3991,13 +3801,6 @@ i40e_flow_create(struct rte_eth_dev *dev,
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
@@ -4057,10 +3860,6 @@ i40e_flow_destroy(struct rte_eth_dev *dev,
 		return 0;
 
 	switch (filter_type) {
-	case RTE_ETH_FILTER_ETHERTYPE:
-		ret = i40e_flow_destroy_ethertype_filter(pf,
-			 (struct i40e_ethertype_filter *)flow->rule);
-		break;
 	case RTE_ETH_FILTER_TUNNEL:
 		ret = i40e_flow_destroy_tunnel_filter(pf,
 			      (struct i40e_tunnel_filter *)flow->rule);
@@ -4100,41 +3899,6 @@ i40e_flow_destroy(struct rte_eth_dev *dev,
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
@@ -4213,14 +3977,6 @@ i40e_flow_flush(struct rte_eth_dev *dev, struct rte_flow_error *error)
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
@@ -4297,34 +4053,6 @@ i40e_flow_flush_fdir_filter(struct i40e_pf *pf)
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
index c958868661..11d13a76fe 100644
--- a/drivers/net/intel/i40e/i40e_flow.h
+++ b/drivers/net/intel/i40e/i40e_flow.h
@@ -7,6 +7,10 @@
 
 #include "../common/flow_engine.h"
 
+int i40e_get_outer_vlan(struct i40e_pf *pf, uint16_t *tpid);
+
 extern const struct ci_flow_engine_list i40e_flow_engine_list;
 
+extern const struct ci_flow_engine i40e_flow_engine_ethertype;
+
 #endif /* _I40E_FLOW_H_ */
diff --git a/drivers/net/intel/i40e/i40e_flow_ethertype.c b/drivers/net/intel/i40e/i40e_flow_ethertype.c
new file mode 100644
index 0000000000..e52b1dc322
--- /dev/null
+++ b/drivers/net/intel/i40e/i40e_flow_ethertype.c
@@ -0,0 +1,250 @@
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
+		struct rte_flow_error *error)
+{
+	struct i40e_ethertype_ctx *ethertype_ctx = ctx;
+	struct rte_eth_ethertype_filter *filter = &ethertype_ctx->ethertype;
+	const struct rte_flow_item_eth *eth_spec = item->spec;
+	const struct rte_flow_item_eth *eth_mask = item->mask;
+	uint16_t ether_type, tpid;
+	/* pf cannot be const so it's here rather than in validate() */
+	struct rte_eth_dev_data *dev_data = ethertype_ctx->base.dev_data;
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev_data->dev_private);
+
+	ether_type = rte_be_to_cpu_16(eth_spec->hdr.ether_type);
+
+	if (CI_FIELD_IS_MASKED(&eth_mask->hdr.dst_addr)) {
+		filter->mac_addr = eth_spec->hdr.dst_addr;
+		filter->flags |= RTE_ETHTYPE_FLAGS_MAC;
+	}
+
+	/* Cannot match currently installed VLAN ethertype */
+	if (i40e_get_outer_vlan(pf, &tpid) != 0) {
+		return rte_flow_error_set(error, EIO,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Can not get the Ethertype identifying the L2 tag");
+	}
+	if (ether_type == tpid) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Unsupported ether_type in control packet filter.");
+	}
+
+	filter->ether_type = ether_type;
+
+	return 0;
+}
+
+static const struct rte_flow_graph i40e_ethertype_graph = {
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
+	struct rte_eth_dev_data *dev_data = ethertype_ctx->base.dev_data;
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
+		if (act_q->index >= dev_data->nb_rx_queues) {
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
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(flow->dev_data->dev_private);
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
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(flow->dev_data->dev_private);
+	int ret;
+
+	ret = i40e_ethertype_filter_set(pf, &ethertype_flow->ethertype, false);
+	if (ret) {
+		return rte_flow_error_set(error, EIO,
+				RTE_FLOW_ERROR_TYPE_HANDLE, flow,
+				"Failed to delete ethertype filter");
+	}
+	return 0;
+}
+
+static const struct ci_flow_engine_ops i40e_flow_engine_ethertype_ops = {
+	.ctx_parse = i40e_flow_ethertype_ctx_parse,
+	.ctx_to_flow = i40e_flow_ethertype_ctx_to_flow,
+	.flow_install = i40e_flow_ethertype_install,
+	.flow_uninstall = i40e_flow_ethertype_uninstall,
+};
+
+const struct ci_flow_engine i40e_flow_engine_ethertype = {
+	.name = "ethertype",
+	.ctx_size = sizeof(struct i40e_ethertype_ctx),
+	.flow_size = sizeof(struct i40e_ethertype_flow),
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
2.52.0

