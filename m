Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E27CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 16:39:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C77840E18;
	Mon,  5 Oct 2026 18:38:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id AD05640DDD
 for <dev@dpdk.org>; Mon,  5 Oct 2026 18:38:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791218324; x=1822754324;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=d8LwzMjWqWDC5Pw8P0r6QYSRT3ABCtINfXDnJbAufmM=;
 b=IiogMEZ/Ec40yTpj4YlZWZpBTTmLW4KGTLotUX9EFOQTz5SZSr3BJlqu
 +qt+PaPg/TH7JLhpCiGf1/HI+/hM7ft8fM0jtTxdjCub7huDz9nfy311i
 rHR/S9SYEdsVjqE+yQiFRT5nA/fL66FZy4YyCLyPPpF27HyB7VhPXZ0Wf
 w09rQCqDJJOqzOGJuRGSkkV05Ebv40by7G9ygMZU9RM0W20GJtLEc0tbh
 LP3fiKe1ZlBuwuNibV5gZ3Wt4WgG4V/2uG3lFCIbncIkUkwrdiqXgA4H7
 eJbdv5/UpWFz1NjC3ZdXIo7VY3X1tUKQSZwA+ZyxOdlK0iD7u614bAYks A==;
X-CSE-ConnectionGUID: sspOEPYFSZ6nIOSma9fC5w==
X-CSE-MsgGUID: +9CbwwOzSaOGwt+oysPeSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="90665291"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="90665291"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 09:38:43 -0700
X-CSE-ConnectionGUID: E17qzWFQSdyLiCjc6Kqmzg==
X-CSE-MsgGUID: NEuxEtYhTNWzY3+ddrf09Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="945715"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa011.fm.intel.com with ESMTP; 05 Oct 2026 09:38:42 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 07/24] net/ixgbe: reimplement ethertype parser
Date: Mon,  5 Oct 2026 17:38:02 +0100
Message-ID: <163b2a51dfcc723b000a8da6c99fa48aa1d2f323.1791218155.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791218154.git.anatoly.burakov@intel.com>
 <cover.1791218154.git.anatoly.burakov@intel.com>
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
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  92 ------
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        |   4 -
 drivers/net/intel/ixgbe/ixgbe_flow.c          | 220 +------------
 drivers/net/intel/ixgbe/ixgbe_flow.h          |   8 +
 .../net/intel/ixgbe/ixgbe_flow_ethertype.c    | 299 ++++++++++++++++++
 drivers/net/intel/ixgbe/meson.build           |   1 +
 6 files changed, 314 insertions(+), 310 deletions(-)
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_ethertype.c

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 56dbf288a94..55e1de85d09 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -6850,20 +6850,6 @@ ixgbe_ethertype_filter_program(struct ixgbe_hw *hw, uint8_t idx,
 	IXGBE_WRITE_FLUSH(hw);
 }
 
-static int
-ixgbe_ethertype_table_lookup(const struct ixgbe_ethertype_table *table,
-			uint16_t ethertype)
-{
-	int idx;
-
-	for (idx = 0; idx < IXGBE_MAX_ETQF_FILTERS; idx++) {
-		if (table->entries[idx].used &&
-				table->entries[idx].ethertype == ethertype)
-			return idx;
-	}
-	return -ENOENT;
-}
-
 int
 ixgbe_ethertype_table_add(struct ixgbe_ethertype_table *table,
 			uint16_t ethertype, uint32_t etqf, uint32_t etqs)
@@ -6901,42 +6887,6 @@ ixgbe_ethertype_table_del(struct ixgbe_ethertype_table *table, uint8_t idx)
 	return 0;
 }
 
-int
-ixgbe_add_del_ethertype_filter(struct ixgbe_adapter *adapter,
-			struct rte_eth_ethertype_filter *filter, bool add)
-{
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
-	struct ixgbe_ethertype_table *table =
-		&IXGBE_DEV_PRIVATE_TO_FILTER_INFO(adapter)->ethertype_table;
-	uint32_t etqf, etqs;
-	int idx;
-
-	if (filter->queue >= IXGBE_MAX_RX_QUEUE_NUM ||
-		filter->ether_type == RTE_ETHER_TYPE_IPV4 ||
-		filter->ether_type == RTE_ETHER_TYPE_IPV6 ||
-		filter->flags & (RTE_ETHTYPE_FLAGS_MAC | RTE_ETHTYPE_FLAGS_DROP))
-		return -EINVAL;
-
-	if (add) {
-		etqf = IXGBE_ETQF_FILTER_EN | filter->ether_type;
-		etqs = IXGBE_ETQS_QUEUE_EN |
-			(((uint32_t)filter->queue << IXGBE_ETQS_RX_QUEUE_SHIFT) &
-			IXGBE_ETQS_RX_QUEUE);
-		idx = ixgbe_ethertype_table_add(table, filter->ether_type, etqf, etqs);
-		if (idx < 0)
-			return idx;
-	} else {
-		idx = ixgbe_ethertype_table_lookup(table, filter->ether_type);
-		if (idx < 0)
-			return idx;
-		ixgbe_ethertype_table_del(table, idx);
-		etqf = 0;
-		etqs = 0;
-	}
-	ixgbe_ethertype_filter_program(hw, idx, etqf, etqs);
-	return 0;
-}
-
 static int
 ixgbe_dev_flow_ops_get(__rte_unused struct rte_eth_dev *dev,
 		       const struct rte_flow_ops **ops)
@@ -8399,27 +8349,6 @@ ixgbe_ntuple_filter_restore(struct rte_eth_dev *dev)
 	}
 }
 
-/* restore ethernet type filter */
-static inline void
-ixgbe_ethertype_filter_restore(struct rte_eth_dev *dev)
-{
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct ixgbe_filter_info *filter_info =
-		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
-	int i;
-
-	for (i = 0; i < IXGBE_MAX_ETQF_FILTERS; i++) {
-		/* skip over entries not managed by rte_flow */
-		if (i == filter_info->timesync_idx ||
-				i == filter_info->antispoof_idx||
-				!filter_info->ethertype_table.entries[i].used)
-			continue;
-		ixgbe_ethertype_filter_program(hw, i,
-			filter_info->ethertype_table.entries[i].etqf,
-			filter_info->ethertype_table.entries[i].etqs);
-	}
-}
-
 /* restore SYN filter */
 static inline void
 ixgbe_syn_filter_restore(struct rte_eth_dev *dev)
@@ -8475,7 +8404,6 @@ static int
 ixgbe_filter_restore(struct rte_eth_dev *dev)
 {
 	ixgbe_ntuple_filter_restore(dev);
-	ixgbe_ethertype_filter_restore(dev);
 	ixgbe_syn_filter_restore(dev);
 	ixgbe_fdir_filter_restore(dev);
 	ixgbe_l2_tn_filter_restore(dev);
@@ -8514,26 +8442,6 @@ ixgbe_clear_all_ntuple_filter(struct rte_eth_dev *dev)
 		ixgbe_remove_5tuple_filter(adapter, p_5tuple);
 }
 
-/* remove all the ether type filters */
-void
-ixgbe_clear_all_ethertype_filter(struct rte_eth_dev *dev)
-{
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct ixgbe_filter_info *filter_info =
-		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
-	int i;
-
-	for (i = 0; i < IXGBE_MAX_ETQF_FILTERS; i++) {
-		/* only clear rte_flow filters */
-		if (!filter_info->ethertype_table.entries[i].used ||
-			(filter_info->timesync_installed && i == filter_info->timesync_idx) ||
-			(filter_info->antispoof_installed && i == filter_info->antispoof_idx))
-			continue;
-		ixgbe_ethertype_table_del(&filter_info->ethertype_table, i);
-		ixgbe_ethertype_filter_program(hw, i, 0, 0);
-	}
-}
-
 /* remove the SYN filter */
 void
 ixgbe_clear_syn_filter(struct rte_eth_dev *dev)
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index fd819490f32..00d63a5bd51 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -676,9 +676,6 @@ bool ixgbe_rss_update_sp(enum ixgbe_mac_type mac_type);
 int ixgbe_add_del_ntuple_filter(struct ixgbe_adapter *adapter,
 			struct rte_eth_ntuple_filter *filter,
 			bool add);
-int ixgbe_add_del_ethertype_filter(struct ixgbe_adapter *adapter,
-			struct rte_eth_ethertype_filter *filter,
-			bool add);
 int ixgbe_syn_filter_set(struct ixgbe_adapter *adapter,
 			struct rte_eth_syn_filter *filter,
 			bool add);
@@ -759,7 +756,6 @@ int ixgbe_clear_all_fdir_filter(struct rte_eth_dev *dev);
 
 extern const struct rte_flow_ops ixgbe_flow_ops;
 
-void ixgbe_clear_all_ethertype_filter(struct rte_eth_dev *dev);
 void ixgbe_clear_all_ntuple_filter(struct rte_eth_dev *dev);
 void ixgbe_clear_syn_filter(struct rte_eth_dev *dev);
 int ixgbe_clear_all_l2_tn_filter(struct rte_eth_dev *dev);
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index dffc7ccdc80..acd5f8cdb11 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -63,11 +63,6 @@ struct ixgbe_ntuple_filter_ele {
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
@@ -94,7 +89,11 @@ struct ixgbe_flow_mem {
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
@@ -118,7 +117,7 @@ const struct rte_flow_item *next_no_void_pattern(
 /*
  * All ixgbe engines mostly check the same stuff, so use a common check.
  */
-static int
+int
 ixgbe_flow_actions_check(const struct ci_flow_actions *actions,
 		const struct ci_flow_actions_check_param *param,
 		struct rte_flow_error *error)
@@ -667,169 +666,6 @@ ixgbe_parse_ntuple_filter(struct rte_eth_dev *dev,
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
@@ -2819,7 +2655,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	struct ixgbe_adapter *adapter =
 		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct rte_eth_ntuple_filter ntuple_filter;
-	struct rte_eth_ethertype_filter ethertype_filter;
 	struct rte_eth_syn_filter syn_filter;
 	struct ixgbe_fdir_rule fdir_rule;
 	struct ixgbe_l2_tunnel_conf l2_tn_filter;
@@ -2828,7 +2663,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	struct ixgbe_rte_flow_rss_conf rss_conf;
 	struct rte_flow *flow = NULL;
 	struct ixgbe_ntuple_filter_ele *ntuple_filter_ptr;
-	struct ixgbe_ethertype_filter_ele *ethertype_filter_ptr;
 	struct ixgbe_eth_syn_filter_ele *syn_filter_ptr;
 	struct ixgbe_eth_l2_tunnel_conf_ele *l2_tn_filter_ptr;
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
@@ -2890,29 +2724,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 		return flow;
 	}
 
-	memset(&ethertype_filter, 0, sizeof(struct rte_eth_ethertype_filter));
-	ret = ixgbe_parse_ethertype_filter(dev, attr, pattern,
-				actions, &ethertype_filter, error);
-	if (!ret) {
-		ethertype_filter_ptr = rte_zmalloc("ixgbe_ethertype_filter",
-			sizeof(struct ixgbe_ethertype_filter_ele), 0);
-		if (!ethertype_filter_ptr) {
-			PMD_DRV_LOG(ERR, "failed to allocate memory");
-			ret = -ENOMEM;
-			goto out;
-		}
-		ethertype_filter_ptr->filter_info = ethertype_filter;
-		ret = ixgbe_add_del_ethertype_filter(adapter,
-				&ethertype_filter, TRUE);
-		if (ret) {
-			rte_free(ethertype_filter_ptr);
-			goto out;
-		}
-		flow->rule = ethertype_filter_ptr;
-		flow->filter_type = RTE_ETH_FILTER_ETHERTYPE;
-		return flow;
-	}
-
 	memset(&syn_filter, 0, sizeof(struct rte_eth_syn_filter));
 	ret = ixgbe_parse_syn_filter(dev, attr, pattern,
 				actions, &syn_filter, error);
@@ -3043,7 +2854,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 {
 	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct rte_eth_ntuple_filter ntuple_filter;
-	struct rte_eth_ethertype_filter ethertype_filter;
 	struct rte_eth_syn_filter syn_filter;
 	struct ixgbe_l2_tunnel_conf l2_tn_filter;
 	struct ixgbe_fdir_rule fdir_rule;
@@ -3070,12 +2880,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
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
@@ -3113,12 +2917,10 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
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
@@ -3164,15 +2966,6 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		if (!ret)
 			rte_free(ntuple_filter_ptr);
 		break;
-	case RTE_ETH_FILTER_ETHERTYPE:
-		ethertype_filter_ptr = (struct ixgbe_ethertype_filter_ele *)
-					pmd_flow->rule;
-		ethertype_filter = ethertype_filter_ptr->filter_info;
-		ret = ixgbe_add_del_ethertype_filter(adapter,
-				&ethertype_filter, FALSE);
-		if (!ret)
-			rte_free(ethertype_filter_ptr);
-		break;
 	case RTE_ETH_FILTER_SYN:
 		syn_filter_ptr = (struct ixgbe_eth_syn_filter_ele *)
 				pmd_flow->rule;
@@ -3249,7 +3042,6 @@ ixgbe_flow_flush(struct rte_eth_dev *dev,
 	}
 
 	ixgbe_clear_all_ntuple_filter(dev);
-	ixgbe_clear_all_ethertype_filter(dev);
 	ixgbe_clear_syn_filter(dev);
 
 	ret = ixgbe_clear_all_fdir_filter(dev);
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.h b/drivers/net/intel/ixgbe/ixgbe_flow.h
index 5e68c9886c1..d7694283a54 100644
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
index 00000000000..d5178426570
--- /dev/null
+++ b/drivers/net/intel/ixgbe/ixgbe_flow_ethertype.c
@@ -0,0 +1,299 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include <rte_flow.h>
+#include <flow_graph.h>
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
+	uint8_t idx;
+	uint16_t ether_type;
+	uint16_t queue;
+	uint32_t etqf;
+	uint32_t etqs;
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
+	IXGBE_ETHERTYPE_NODE_START = FLOW_GRAPH_NODE_FIRST,
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
+	eth_mask = ci_flow_item_mask(item);
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
+static const struct flow_graph ixgbe_ethertype_graph = {
+	.nodes = (struct flow_graph_node[]) {
+		[IXGBE_ETHERTYPE_NODE_START] = {
+			.name = "START",
+		},
+		[IXGBE_ETHERTYPE_NODE_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC,
+			.validate = ixgbe_ethertype_node_eth_validate,
+			.process = ixgbe_ethertype_node_eth_process,
+		},
+		[IXGBE_ETHERTYPE_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	},
+	.edges = (struct flow_graph_edge[]) {
+		[IXGBE_ETHERTYPE_NODE_START] = {
+			.next = (size_t[]) {
+				IXGBE_ETHERTYPE_NODE_ETH,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_ETHERTYPE_NODE_ETH] = {
+			.next = (size_t[]) {
+				IXGBE_ETHERTYPE_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+static int
+ixgbe_flow_ethertype_ctx_init(const struct rte_flow_action *actions,
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
+	ethertype_flow->ether_type = ethertype_ctx->filter.ether_type;
+	ethertype_flow->queue = ethertype_ctx->filter.queue;
+
+	/* build the ETQF/ETQS register values from the parsed filter */
+	ethertype_flow->etqf = IXGBE_ETQF_FILTER_EN | (uint32_t)ethertype_flow->ether_type;
+	ethertype_flow->etqs = ((uint32_t)ethertype_flow->queue <<
+			IXGBE_ETQS_RX_QUEUE_SHIFT) & IXGBE_ETQS_RX_QUEUE;
+	ethertype_flow->etqs |= IXGBE_ETQS_QUEUE_EN;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_ethertype_register(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct ixgbe_ethertype_flow *ethertype_flow = (struct ixgbe_ethertype_flow *)flow;
+	struct ixgbe_filter_info *filter_info =
+		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(flow->dev_data->dev_private);
+	int idx;
+
+	idx = ixgbe_ethertype_table_add(&filter_info->ethertype_table,
+			ethertype_flow->ether_type, ethertype_flow->etqf,
+			ethertype_flow->etqs);
+	if (idx == -EEXIST) {
+		return rte_flow_error_set(error, EEXIST,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Ethertype filter already exists");
+	}
+	if (idx == -ENOSPC) {
+		return rte_flow_error_set(error, ENOSPC,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Ethertype filters are full");
+	}
+	if (idx < 0) {
+		return rte_flow_error_set(error, -idx,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Failed to register Ethertype filter");
+	}
+	ethertype_flow->idx = idx;
+	return 0;
+}
+
+static int
+ixgbe_flow_ethertype_unregister(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct ixgbe_ethertype_flow *ethertype_flow = (struct ixgbe_ethertype_flow *)flow;
+	struct ixgbe_filter_info *filter_info =
+		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(flow->dev_data->dev_private);
+	int ret;
+
+	ret = ixgbe_ethertype_table_del(&filter_info->ethertype_table,
+			ethertype_flow->idx);
+	if (ret != 0) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Ethertype filter slot not found on unregister");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_flow_ethertype_install(struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_ethertype_flow *ethertype_flow = (struct ixgbe_ethertype_flow *)flow;
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(flow->dev_data->dev_private);
+
+	ixgbe_ethertype_filter_program(hw, ethertype_flow->idx,
+			ethertype_flow->etqf, ethertype_flow->etqs);
+
+	return 0;
+}
+
+static int
+ixgbe_flow_ethertype_uninstall(struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_ethertype_flow *ethertype_flow = (struct ixgbe_ethertype_flow *)flow;
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(flow->dev_data->dev_private);
+
+	ixgbe_ethertype_filter_program(hw, ethertype_flow->idx, 0, 0);
+
+	return 0;
+}
+
+static int
+ixgbe_flow_ethertype_engine_init(const struct ci_flow_engine *engine __rte_unused,
+		struct rte_eth_dev_data *dev_data,
+		void *priv __rte_unused)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev_data->dev_private);
+
+	/* Ethertype filtering (ETQF) is only available on these MACs. */
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
+	.ctx_init = ixgbe_flow_ethertype_ctx_init,
+	.ctx_to_flow = ixgbe_flow_ethertype_ctx_to_flow,
+	.flow_register = ixgbe_flow_ethertype_register,
+	.flow_unregister = ixgbe_flow_ethertype_unregister,
+	.flow_install = ixgbe_flow_ethertype_install,
+	.flow_uninstall = ixgbe_flow_ethertype_uninstall,
+};
+
+const struct ci_flow_engine ixgbe_ethertype_flow_engine = {
+	.name = "ixgbe_ethertype",
+	.ctx_size = sizeof(struct ixgbe_ethertype_ctx),
+	.flow_size = sizeof(struct ixgbe_ethertype_flow),
+	.graph = &ixgbe_ethertype_graph,
+	.ops = &ixgbe_ethertype_ops,
+};
diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
index 0531d37acd3..f2857feab76 100644
--- a/drivers/net/intel/ixgbe/meson.build
+++ b/drivers/net/intel/ixgbe/meson.build
@@ -26,6 +26,7 @@ sources += files(
         'ixgbe_ethdev.c',
         'ixgbe_fdir.c',
         'ixgbe_flow.c',
+        'ixgbe_flow_ethertype.c',
         'ixgbe_ipsec.c',
         'ixgbe_pf.c',
         'ixgbe_rxtx.c',
-- 
2.52.0

