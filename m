Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714C3C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 14:02:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06DF540B97;
	Thu, 20 Aug 2026 16:02:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 0C12340A81
 for <dev@dpdk.org>; Thu, 20 Aug 2026 16:01:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787234517; x=1818770517;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=RqwiiVTXP0HgS1QDXACxmpe4Fel3Rk/BEm3a8OqiSMY=;
 b=WG2F2E/Ce8PJ8TxXCU1s+0hPt1BFUNbDxacHrBJ6WPvKOZDT1JX7H2f9
 X6LDk1JRox3o+07CMA4g/HtoyeVtVaKhf3Zb884tc8mypPxtLMc0DACVs
 Cky4W4rs28A3NrWK5XPjhXMzF0bZlj6AleVI9yP3pTj+ra6iPuVt/c2pf
 aHLbAflV1Vz/Y6XWqn+ybRMqufmHxu4sQGC4/XJqj+8bdpyPF8JTlzBLi
 uTkELkuElOM9O59kI34zxhLg3UrYfXZbIGCrH8Y3h+QeScxTv7kpkqX/g
 ehh3Vz2PBzlnDfrM3dqhRwUUbSjr/wDun+hXRU7gkUcF/nSwR10hJ1vzY A==;
X-CSE-ConnectionGUID: i/Hlw0L8RiOlWXK7IVBhHQ==
X-CSE-MsgGUID: 62XSXwTBQpqTPGRUkDtVAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="75300321"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="75300321"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 07:01:50 -0700
X-CSE-ConnectionGUID: ZEMEhAXfTnGsK79pJqby4A==
X-CSE-MsgGUID: wu+RkUypTjOAjuBlGwO1qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="264719691"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 20 Aug 2026 07:01:48 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 05/21] net/ixgbe: reimplement ethertype parser
Date: Thu, 20 Aug 2026 15:00:50 +0100
Message-ID: <b2e7f9de9ccb05d71eb7e7fbfd0014d525a4be11.1787233987.git.anatoly.burakov@intel.com>
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
flow parser for ethertype.

The old ethertype parser was accepting certain things that were later
rejected by the actual ethertype installation code, in particular DROP
action as well as dst MAC address filtering. This was removed from the
graph parser.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  19 --
 drivers/net/intel/ixgbe/ixgbe_flow.c          | 222 +---------------
 drivers/net/intel/ixgbe/ixgbe_flow.h          |   8 +
 .../net/intel/ixgbe/ixgbe_flow_ethertype.c    | 245 ++++++++++++++++++
 drivers/net/intel/ixgbe/meson.build           |   1 +
 5 files changed, 260 insertions(+), 235 deletions(-)
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_ethertype.c

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index ebc4fab704..5465447bdb 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -6855,25 +6855,6 @@ ixgbe_add_del_ethertype_filter(struct ixgbe_adapter *adapter,
 	int ret;
 	struct ixgbe_ethertype_filter ethertype_filter;
 
-	if (filter->queue >= IXGBE_MAX_RX_QUEUE_NUM)
-		return -EINVAL;
-
-	if (filter->ether_type == RTE_ETHER_TYPE_IPV4 ||
-		filter->ether_type == RTE_ETHER_TYPE_IPV6) {
-		PMD_DRV_LOG(ERR, "unsupported ether_type(0x%04x) in"
-			" ethertype filter.", filter->ether_type);
-		return -EINVAL;
-	}
-
-	if (filter->flags & RTE_ETHTYPE_FLAGS_MAC) {
-		PMD_DRV_LOG(ERR, "mac compare is unsupported.");
-		return -EINVAL;
-	}
-	if (filter->flags & RTE_ETHTYPE_FLAGS_DROP) {
-		PMD_DRV_LOG(ERR, "drop option is unsupported.");
-		return -EINVAL;
-	}
-
 	ret = ixgbe_ethertype_filter_lookup(filter_info, filter->ether_type);
 	if (ret >= 0 && add) {
 		PMD_DRV_LOG(ERR, "ethertype (0x%04x) filter exists.",
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index c5c034144d..55344d67e8 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -64,11 +64,6 @@ struct ixgbe_ntuple_filter_ele {
 	struct ixgbe_filter_ele_base base;
 	struct rte_eth_ntuple_filter filter_info;
 };
-/* ethertype filter list structure */
-struct ixgbe_ethertype_filter_ele {
-	struct ixgbe_filter_ele_base base;
-	struct rte_eth_ethertype_filter filter_info;
-};
 /* syn filter list structure */
 struct ixgbe_eth_syn_filter_ele {
 	struct ixgbe_filter_ele_base base;
@@ -95,7 +90,11 @@ struct ixgbe_flow_mem {
 	struct rte_flow *flow;
 };
 
-const struct ci_flow_engine_list ixgbe_flow_engine_list = {0};
+const struct ci_flow_engine_list ixgbe_flow_engine_list = {
+	{
+		&ixgbe_ethertype_flow_engine,
+	}
+};
 
 /**
  * Endless loop will never happen with below assumption
@@ -119,7 +118,7 @@ const struct rte_flow_item *next_no_void_pattern(
 /*
  * All ixgbe engines mostly check the same stuff, so use a common check.
  */
-static int
+int
 ixgbe_flow_actions_check(const struct ci_flow_actions *actions,
 		const struct ci_flow_actions_check_param *param,
 		struct rte_flow_error *error)
@@ -668,169 +667,6 @@ ixgbe_parse_ntuple_filter(struct rte_eth_dev *dev,
 	return 0;
 }
 
-/**
- * Parse the rule to see if it is a ethertype rule.
- * And get the ethertype filter info BTW.
- * pattern:
- * The first not void item can be ETH.
- * The next not void item must be END.
- * action:
- * The first not void action should be QUEUE.
- * The next not void action should be END.
- * pattern example:
- * ITEM		Spec			Mask
- * ETH		type	0x0807		0xFFFF
- * END
- * other members in mask and spec should set to 0x00.
- * item->last should be NULL.
- */
-static int
-cons_parse_ethertype_filter(const struct rte_flow_item *pattern,
-		const struct rte_flow_action *action,
-		struct rte_eth_ethertype_filter *filter,
-		struct rte_flow_error *error)
-{
-	const struct rte_flow_item *item;
-	const struct rte_flow_item_eth *eth_spec;
-	const struct rte_flow_item_eth *eth_mask;
-
-	item = next_no_void_pattern(pattern, NULL);
-	/* The first non-void item should be MAC. */
-	if (item->type != RTE_FLOW_ITEM_TYPE_ETH) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by ethertype filter");
-		return -rte_errno;
-	}
-
-	/*Not supported last point for range*/
-	if (item->last) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			item, "Not supported last point for range");
-		return -rte_errno;
-	}
-
-	/* Get the MAC info. */
-	if (!item->spec || !item->mask) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by ethertype filter");
-		return -rte_errno;
-	}
-
-	eth_spec = item->spec;
-	eth_mask = item->mask;
-
-	/* Mask bits of source MAC address must be full of 0.
-	 * Mask bits of destination MAC address must be full
-	 * of 1 or full of 0.
-	 */
-	if (!rte_is_zero_ether_addr(&eth_mask->hdr.src_addr) ||
-	    (!rte_is_zero_ether_addr(&eth_mask->hdr.dst_addr) &&
-	     !rte_is_broadcast_ether_addr(&eth_mask->hdr.dst_addr))) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Invalid ether address mask");
-		return -rte_errno;
-	}
-
-	if ((eth_mask->hdr.ether_type & UINT16_MAX) != UINT16_MAX) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Invalid ethertype mask");
-		return -rte_errno;
-	}
-
-	/* If mask bits of destination MAC address
-	 * are full of 1, set RTE_ETHTYPE_FLAGS_MAC.
-	 */
-	if (rte_is_broadcast_ether_addr(&eth_mask->hdr.dst_addr)) {
-		filter->mac_addr = eth_spec->hdr.dst_addr;
-		filter->flags |= RTE_ETHTYPE_FLAGS_MAC;
-	} else {
-		filter->flags &= ~RTE_ETHTYPE_FLAGS_MAC;
-	}
-	filter->ether_type = rte_be_to_cpu_16(eth_spec->hdr.ether_type);
-
-	/* Check if the next non-void item is END. */
-	item = next_no_void_pattern(pattern, item);
-	if (item->type != RTE_FLOW_ITEM_TYPE_END) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by ethertype filter.");
-		return -rte_errno;
-	}
-
-	filter->queue = ((const struct rte_flow_action_queue *)action->conf)->index;
-
-	return 0;
-}
-
-static int
-ixgbe_parse_ethertype_filter(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
-		const struct rte_flow_item pattern[], const struct rte_flow_action actions[],
-		struct rte_eth_ethertype_filter *filter, struct rte_flow_error *error)
-{
-	int ret;
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct ci_flow_actions parsed_actions;
-	struct ci_flow_actions_check_param ap_param = {
-		.allowed_types = (const enum rte_flow_action_type[]){
-			/* only queue is allowed here */
-			RTE_FLOW_ACTION_TYPE_QUEUE,
-			RTE_FLOW_ACTION_TYPE_END
-		},
-		.max_actions = 1,
-		.driver_ctx = dev->data,
-		.check = ixgbe_flow_actions_check
-	};
-	const struct rte_flow_action *action;
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
-
-	ret = cons_parse_ethertype_filter(pattern, action, filter, error);
-	if (ret)
-		return ret;
-
-	if (filter->ether_type == RTE_ETHER_TYPE_IPV4 ||
-		filter->ether_type == RTE_ETHER_TYPE_IPV6) {
-		memset(filter, 0, sizeof(struct rte_eth_ethertype_filter));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			NULL, "IPv4/IPv6 not supported by ethertype filter");
-		return -rte_errno;
-	}
-
-	if (filter->flags & RTE_ETHTYPE_FLAGS_MAC) {
-		memset(filter, 0, sizeof(struct rte_eth_ethertype_filter));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			NULL, "mac compare is unsupported");
-		return -rte_errno;
-	}
-
-	return 0;
-}
-
 /**
  * Parse the rule to see if it is a TCP SYN rule.
  * And get the TCP SYN filter info BTW.
@@ -2816,7 +2652,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	struct ixgbe_adapter *adapter =
 		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct rte_eth_ntuple_filter ntuple_filter;
-	struct rte_eth_ethertype_filter ethertype_filter;
 	struct rte_eth_syn_filter syn_filter;
 	struct ixgbe_fdir_rule fdir_rule;
 	struct ixgbe_l2_tunnel_conf l2_tn_filter;
@@ -2825,7 +2660,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	struct ixgbe_rte_flow_rss_conf rss_conf;
 	struct rte_flow *flow = NULL;
 	struct ixgbe_ntuple_filter_ele *ntuple_filter_ptr;
-	struct ixgbe_ethertype_filter_ele *ethertype_filter_ptr;
 	struct ixgbe_eth_syn_filter_ele *syn_filter_ptr;
 	struct ixgbe_eth_l2_tunnel_conf_ele *l2_tn_filter_ptr;
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
@@ -2887,30 +2721,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 		goto out;
 	}
 
-	memset(&ethertype_filter, 0, sizeof(struct rte_eth_ethertype_filter));
-	ret = ixgbe_parse_ethertype_filter(dev, attr, pattern,
-				actions, &ethertype_filter, error);
-	if (!ret) {
-		ret = ixgbe_add_del_ethertype_filter(adapter,
-				&ethertype_filter, TRUE);
-		if (!ret) {
-			ethertype_filter_ptr = rte_zmalloc(
-				"ixgbe_ethertype_filter",
-				sizeof(struct ixgbe_ethertype_filter_ele), 0);
-			if (!ethertype_filter_ptr) {
-				PMD_DRV_LOG(ERR, "failed to allocate memory");
-				goto out;
-			}
-			memcpy(&ethertype_filter_ptr->filter_info,
-				&ethertype_filter,
-				sizeof(struct rte_eth_ethertype_filter));
-			flow->rule = ethertype_filter_ptr;
-			flow->filter_type = RTE_ETH_FILTER_ETHERTYPE;
-			return flow;
-		}
-		goto out;
-	}
-
 	memset(&syn_filter, 0, sizeof(struct rte_eth_syn_filter));
 	ret = ixgbe_parse_syn_filter(dev, attr, pattern,
 				actions, &syn_filter, error);
@@ -3034,7 +2844,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 {
 	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct rte_eth_ntuple_filter ntuple_filter;
-	struct rte_eth_ethertype_filter ethertype_filter;
 	struct rte_eth_syn_filter syn_filter;
 	struct ixgbe_l2_tunnel_conf l2_tn_filter;
 	struct ixgbe_fdir_rule fdir_rule;
@@ -3061,12 +2870,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 	if (!ret)
 		return 0;
 
-	memset(&ethertype_filter, 0, sizeof(struct rte_eth_ethertype_filter));
-	ret = ixgbe_parse_ethertype_filter(dev, attr, pattern,
-				actions, &ethertype_filter, error);
-	if (!ret)
-		return 0;
-
 	memset(&syn_filter, 0, sizeof(struct rte_eth_syn_filter));
 	ret = ixgbe_parse_syn_filter(dev, attr, pattern,
 				actions, &syn_filter, error);
@@ -3104,12 +2907,10 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	struct rte_flow *pmd_flow = flow;
 	enum rte_filter_type filter_type = pmd_flow->filter_type;
 	struct rte_eth_ntuple_filter ntuple_filter;
-	struct rte_eth_ethertype_filter ethertype_filter;
 	struct rte_eth_syn_filter syn_filter;
 	struct ixgbe_fdir_rule fdir_rule;
 	struct ixgbe_l2_tunnel_conf l2_tn_filter;
 	struct ixgbe_ntuple_filter_ele *ntuple_filter_ptr;
-	struct ixgbe_ethertype_filter_ele *ethertype_filter_ptr;
 	struct ixgbe_eth_syn_filter_ele *syn_filter_ptr;
 	struct ixgbe_eth_l2_tunnel_conf_ele *l2_tn_filter_ptr;
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
@@ -3157,17 +2958,6 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		if (!ret)
 			rte_free(ntuple_filter_ptr);
 		break;
-	case RTE_ETH_FILTER_ETHERTYPE:
-		ethertype_filter_ptr = (struct ixgbe_ethertype_filter_ele *)
-					pmd_flow->rule;
-		memcpy(&ethertype_filter,
-			&ethertype_filter_ptr->filter_info,
-			sizeof(struct rte_eth_ethertype_filter));
-		ret = ixgbe_add_del_ethertype_filter(adapter,
-				&ethertype_filter, FALSE);
-		if (!ret)
-			rte_free(ethertype_filter_ptr);
-		break;
 	case RTE_ETH_FILTER_SYN:
 		syn_filter_ptr = (struct ixgbe_eth_syn_filter_ele *)
 				pmd_flow->rule;
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.h b/drivers/net/intel/ixgbe/ixgbe_flow.h
index 5e68c9886c..d7694283a5 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.h
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.h
@@ -5,8 +5,16 @@
 #ifndef _IXGBE_FLOW_H_
 #define _IXGBE_FLOW_H_
 
+#include "../common/flow_check.h"
 #include "../common/flow_engine.h"
 
+int
+ixgbe_flow_actions_check(const struct ci_flow_actions *actions,
+		const struct ci_flow_actions_check_param *param,
+		struct rte_flow_error *error);
+
 extern const struct ci_flow_engine_list ixgbe_flow_engine_list;
 
+extern const struct ci_flow_engine ixgbe_ethertype_flow_engine;
+
 #endif /*  _IXGBE_FLOW_H_ */
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow_ethertype.c b/drivers/net/intel/ixgbe/ixgbe_flow_ethertype.c
new file mode 100644
index 0000000000..35cbbca609
--- /dev/null
+++ b/drivers/net/intel/ixgbe/ixgbe_flow_ethertype.c
@@ -0,0 +1,245 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include <rte_flow.h>
+#include <rte_flow_graph.h>
+#include <rte_ether.h>
+
+#include "ixgbe_ethdev.h"
+#include "ixgbe_flow.h"
+#include "../common/flow_check.h"
+#include "../common/flow_util.h"
+#include "../common/flow_engine.h"
+
+struct ixgbe_ethertype_flow {
+	struct rte_flow flow;
+	struct rte_eth_ethertype_filter filter;
+};
+
+struct ixgbe_ethertype_ctx {
+	struct ci_flow_engine_ctx base;
+	struct rte_eth_ethertype_filter filter;
+};
+
+/**
+ * Ethertype filter graph implementation
+ * Pattern: START -> ETH -> END
+ */
+
+enum ixgbe_ethertype_node_id {
+	IXGBE_ETHERTYPE_NODE_START = RTE_FLOW_NODE_FIRST,
+	IXGBE_ETHERTYPE_NODE_ETH,
+	IXGBE_ETHERTYPE_NODE_END,
+	IXGBE_ETHERTYPE_NODE_MAX,
+};
+
+static int
+ixgbe_ethertype_node_eth_validate(const void *ctx __rte_unused,
+				  const struct rte_flow_item *item,
+				  struct rte_flow_error *error)
+{
+	const struct rte_flow_item_eth *eth_spec;
+	const struct rte_flow_item_eth *eth_mask;
+
+	eth_spec = item->spec;
+	eth_mask = item->mask;
+
+	/* Source MAC mask must be all zeros */
+	if (!CI_FIELD_IS_ZERO(&eth_mask->hdr.src_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Source MAC filtering not supported");
+	}
+
+	/* Dest MAC mask must be all zeros */
+	if (!CI_FIELD_IS_ZERO(&eth_mask->hdr.dst_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Destination MAC filtering not supported");
+	}
+
+	/* Ethertype mask must be exact match */
+	if (!CI_FIELD_IS_MASKED(&eth_mask->hdr.ether_type)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Ethertype must be exactly matched");
+	}
+
+	/* IPv4/IPv6 ethertypes not supported by hardware */
+	uint16_t ether_type = rte_be_to_cpu_16(eth_spec->hdr.ether_type);
+	if (ether_type == RTE_ETHER_TYPE_IPV4 || ether_type == RTE_ETHER_TYPE_IPV6) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"IPv4/IPv6 not supported by ethertype filter");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_ethertype_node_eth_process(void *ctx,
+				 const struct rte_flow_item *item,
+				 struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_ethertype_ctx *graph_ctx = ctx;
+	const struct rte_flow_item_eth *eth_spec = item->spec;
+
+	graph_ctx->filter.ether_type = rte_be_to_cpu_16(eth_spec->hdr.ether_type);
+
+	return 0;
+}
+
+static const struct rte_flow_graph ixgbe_ethertype_graph = {
+	.nodes = (struct rte_flow_graph_node[]) {
+		[IXGBE_ETHERTYPE_NODE_START] = {
+			.name = "START",
+		},
+		[IXGBE_ETHERTYPE_NODE_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = ixgbe_ethertype_node_eth_validate,
+			.process = ixgbe_ethertype_node_eth_process,
+		},
+		[IXGBE_ETHERTYPE_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	},
+	.edges = (struct rte_flow_graph_edge[]) {
+		[IXGBE_ETHERTYPE_NODE_START] = {
+			.next = (const size_t[]) {
+				IXGBE_ETHERTYPE_NODE_ETH,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_ETHERTYPE_NODE_ETH] = {
+			.next = (const size_t[]) {
+				IXGBE_ETHERTYPE_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+static int
+ixgbe_flow_ethertype_ctx_parse(const struct rte_flow_action *actions,
+		const struct rte_flow_attr *attr,
+		struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	struct ci_flow_actions parsed_actions;
+	struct ci_flow_actions_check_param ap_param = {
+		.allowed_types = (const enum rte_flow_action_type[]){
+			/* only queue is allowed here */
+			RTE_FLOW_ACTION_TYPE_QUEUE,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.max_actions = 1,
+		.driver_ctx = ctx->dev_data,
+		.check = ixgbe_flow_actions_check
+	};
+	struct ixgbe_ethertype_ctx *ethertype_ctx = (struct ixgbe_ethertype_ctx *)ctx;
+	const struct rte_flow_action_queue *q_act;
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
+	q_act = (const struct rte_flow_action_queue *)parsed_actions.actions[0]->conf;
+
+	/* set up filter action */
+	ethertype_ctx->filter.queue = q_act->index;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_ethertype_ctx_to_flow(const struct ci_flow_engine_ctx *ctx,
+		struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct ixgbe_ethertype_ctx *ethertype_ctx = (const struct ixgbe_ethertype_ctx *)ctx;
+	struct ixgbe_ethertype_flow *ethertype_flow = (struct ixgbe_ethertype_flow *)flow;
+
+	/* copy filter configuration */
+	ethertype_flow->filter = ethertype_ctx->filter;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_ethertype_install(struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_ethertype_flow *ethertype_flow = (struct ixgbe_ethertype_flow *)flow;
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(flow->dev_data->dev_private);
+	int ret;
+
+	ret = ixgbe_add_del_ethertype_filter(adapter, &ethertype_flow->filter, TRUE);
+	if (ret) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Failed to add ethertype filter");
+	}
+	return ret;
+}
+
+static int
+ixgbe_flow_ethertype_uninstall(struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_ethertype_flow *ethertype_flow = (struct ixgbe_ethertype_flow *)flow;
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(flow->dev_data->dev_private);
+	int ret;
+
+	ret = ixgbe_add_del_ethertype_filter(adapter, &ethertype_flow->filter, FALSE);
+	if (ret) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Failed to delete ethertype filter");
+	}
+	return ret;
+}
+
+static int
+ixgbe_flow_ethertype_engine_init(const struct ci_flow_engine *engine __rte_unused,
+		struct rte_eth_dev_data *dev_data,
+		void *priv __rte_unused)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev_data->dev_private);
+
+	if (hw->mac.type == ixgbe_mac_82599EB ||
+			hw->mac.type == ixgbe_mac_X540 ||
+			hw->mac.type == ixgbe_mac_X550 ||
+			hw->mac.type == ixgbe_mac_X550EM_x ||
+			hw->mac.type == ixgbe_mac_X550EM_a ||
+			hw->mac.type == ixgbe_mac_E610)
+		return 0;
+
+	return -ENOTSUP;
+}
+
+static const struct ci_flow_engine_ops ixgbe_ethertype_ops = {
+	.engine_init = ixgbe_flow_ethertype_engine_init,
+	.ctx_parse = ixgbe_flow_ethertype_ctx_parse,
+	.ctx_to_flow = ixgbe_flow_ethertype_ctx_to_flow,
+	.flow_install = ixgbe_flow_ethertype_install,
+	.flow_uninstall = ixgbe_flow_ethertype_uninstall,
+};
+
+const struct ci_flow_engine ixgbe_ethertype_flow_engine = {
+	.name = "ethertype",
+	.ctx_size = sizeof(struct ixgbe_ethertype_ctx),
+	.flow_size = sizeof(struct ixgbe_ethertype_flow),
+	.graph = &ixgbe_ethertype_graph,
+	.ops = &ixgbe_ethertype_ops,
+};
diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
index 7e737ee7b4..54d7e87de8 100644
--- a/drivers/net/intel/ixgbe/meson.build
+++ b/drivers/net/intel/ixgbe/meson.build
@@ -11,6 +11,7 @@ sources += files(
         'ixgbe_ethdev.c',
         'ixgbe_fdir.c',
         'ixgbe_flow.c',
+        'ixgbe_flow_ethertype.c',
         'ixgbe_ipsec.c',
         'ixgbe_pf.c',
         'ixgbe_rxtx.c',
-- 
2.52.0

