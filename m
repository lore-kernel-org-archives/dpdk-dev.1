Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219BDCA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 16:39:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1943B40E28;
	Mon,  5 Oct 2026 18:38:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 8018340DD8
 for <dev@dpdk.org>; Mon,  5 Oct 2026 18:38:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791218326; x=1822754326;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=91ZBtTIXY9ae1gAl2hDLY1GUWDE0o1wdrid3kGz47zs=;
 b=e/cnD9aFRdTSifuzfr4RQO1EhtpF+Y5QKWDXUlGNxTdyZiFNGllfeUCl
 IDYwl0ib3qh2/QiNjNApqySHk2zfJbto8HmtQ2GdtQvCzJEH9jB9EU2n7
 PN3pZ07FpGW3ieY/cqjwv6Q06h8OrOIkqaGwXdv35fUFbKHuTjoktuIiU
 76Gby/ySuXyNjMTDHhieHDYDXaZO0+oGxFzl4n7ozQ5KK2+R2TV7FgVda
 1q9X7m+3dClbEeSHMLnqlXNvsAg7VJchQrrlDuoNWt41zAxR2SKmZOilg
 5UvYsy2Na7fTHgbzZsqP41hcCifnqfMXx8gA5pDAwlk4vTlkSLYLN1S/C w==;
X-CSE-ConnectionGUID: 8U5TZtcvT06DTOPv74alkg==
X-CSE-MsgGUID: YpcmfmQVSG+/lvokdyvbmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="90665300"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="90665300"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 09:38:46 -0700
X-CSE-ConnectionGUID: qOQXpQ2BQ6qAXf9lCKFmaQ==
X-CSE-MsgGUID: PAaznD1wQJ2aAUWcWYS4iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="945723"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa011.fm.intel.com with ESMTP; 05 Oct 2026 09:38:45 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 09/24] net/ixgbe: reimplement syn parser
Date: Mon,  5 Oct 2026 17:38:04 +0100
Message-ID: <e7bc5f0266e3a80e4952a4413248ec2837848abb.1791218155.git.anatoly.burakov@intel.com>
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
flow parser for SYN.

As a result of this migration, queue index validation has changed:

- queue is now validated at parse time against the configured number of Rx
  queues (nb_rx_queues), rather than at install time against the hardware
  maximum (IXGBE_MAX_RX_QUEUE_NUM)
- the per-function queue bound check in ixgbe_syn_filter_set() has been
  removed as it is no longer needed

The syn filter tracking infrastructure is moved completely inside the new
engine and is removed from the rest of the driver.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c   |  70 +----
 drivers/net/intel/ixgbe/ixgbe_ethdev.h   |   7 +-
 drivers/net/intel/ixgbe/ixgbe_flow.c     | 249 +-----------------
 drivers/net/intel/ixgbe/ixgbe_flow.h     |   1 +
 drivers/net/intel/ixgbe/ixgbe_flow_syn.c | 312 +++++++++++++++++++++++
 drivers/net/intel/ixgbe/meson.build      |   1 +
 6 files changed, 319 insertions(+), 321 deletions(-)
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_syn.c

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 55e1de85d09..64013c137a7 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -6463,43 +6463,11 @@ ixgbevf_set_default_mac_addr(struct rte_eth_dev *dev,
 	return 0;
 }
 
-int
-ixgbe_syn_filter_set(struct ixgbe_adapter *adapter,
-			struct rte_eth_syn_filter *filter,
-			bool add)
+void
+ixgbe_syn_filter_program(struct ixgbe_hw *hw, uint32_t synqf)
 {
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
-	struct ixgbe_filter_info *filter_info =
-		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(adapter);
-	uint32_t syn_info;
-	uint32_t synqf;
-
-	if (filter->queue >= IXGBE_MAX_RX_QUEUE_NUM)
-		return -EINVAL;
-
-	syn_info = filter_info->syn_info;
-
-	if (add) {
-		if (syn_info & IXGBE_SYN_FILTER_ENABLE)
-			return -EINVAL;
-		synqf = (uint32_t)(((filter->queue << IXGBE_SYN_FILTER_QUEUE_SHIFT) &
-			IXGBE_SYN_FILTER_QUEUE) | IXGBE_SYN_FILTER_ENABLE);
-
-		if (filter->hig_pri)
-			synqf |= IXGBE_SYN_FILTER_SYNQFP;
-		else
-			synqf &= ~IXGBE_SYN_FILTER_SYNQFP;
-	} else {
-		synqf = IXGBE_READ_REG(hw, IXGBE_SYNQF);
-		if (!(syn_info & IXGBE_SYN_FILTER_ENABLE))
-			return -ENOENT;
-		synqf &= ~(IXGBE_SYN_FILTER_QUEUE | IXGBE_SYN_FILTER_ENABLE);
-	}
-
-	filter_info->syn_info = synqf;
 	IXGBE_WRITE_REG(hw, IXGBE_SYNQF, synqf);
 	IXGBE_WRITE_FLUSH(hw);
-	return 0;
 }
 
 
@@ -8349,23 +8317,6 @@ ixgbe_ntuple_filter_restore(struct rte_eth_dev *dev)
 	}
 }
 
-/* restore SYN filter */
-static inline void
-ixgbe_syn_filter_restore(struct rte_eth_dev *dev)
-{
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct ixgbe_filter_info *filter_info =
-		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
-	uint32_t synqf;
-
-	synqf = filter_info->syn_info;
-
-	if (synqf & IXGBE_SYN_FILTER_ENABLE) {
-		IXGBE_WRITE_REG(hw, IXGBE_SYNQF, synqf);
-		IXGBE_WRITE_FLUSH(hw);
-	}
-}
-
 /* restore L2 tunnel filter */
 static inline void
 ixgbe_l2_tn_filter_restore(struct rte_eth_dev *dev)
@@ -8404,7 +8355,6 @@ static int
 ixgbe_filter_restore(struct rte_eth_dev *dev)
 {
 	ixgbe_ntuple_filter_restore(dev);
-	ixgbe_syn_filter_restore(dev);
 	ixgbe_fdir_filter_restore(dev);
 	ixgbe_l2_tn_filter_restore(dev);
 	ixgbe_rss_filter_restore(dev);
@@ -8442,22 +8392,6 @@ ixgbe_clear_all_ntuple_filter(struct rte_eth_dev *dev)
 		ixgbe_remove_5tuple_filter(adapter, p_5tuple);
 }
 
-/* remove the SYN filter */
-void
-ixgbe_clear_syn_filter(struct rte_eth_dev *dev)
-{
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct ixgbe_filter_info *filter_info =
-		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
-
-	if (filter_info->syn_info & IXGBE_SYN_FILTER_ENABLE) {
-		filter_info->syn_info = 0;
-
-		IXGBE_WRITE_REG(hw, IXGBE_SYNQF, 0);
-		IXGBE_WRITE_FLUSH(hw);
-	}
-}
-
 /* remove all the L2 tunnel filters */
 int
 ixgbe_clear_all_l2_tn_filter(struct rte_eth_dev *dev)
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 00d63a5bd51..6f1ed43cb74 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -311,8 +311,6 @@ struct ixgbe_filter_info {
 	/* Bit mask for every used 5tuple filter */
 	uint32_t fivetuple_mask[IXGBE_5TUPLE_ARRAY_SIZE];
 	struct ixgbe_5tuple_filter_list fivetuple_list;
-	/* store the SYN filter info */
-	uint32_t syn_info;
 	/* store the rss filter info */
 	struct ixgbe_rte_flow_rss_conf rss_info;
 	/* shared EtherType (ETQF) slot table */
@@ -676,15 +674,13 @@ bool ixgbe_rss_update_sp(enum ixgbe_mac_type mac_type);
 int ixgbe_add_del_ntuple_filter(struct ixgbe_adapter *adapter,
 			struct rte_eth_ntuple_filter *filter,
 			bool add);
-int ixgbe_syn_filter_set(struct ixgbe_adapter *adapter,
-			struct rte_eth_syn_filter *filter,
-			bool add);
 
 void ixgbe_ethertype_filter_program(struct ixgbe_hw *hw, uint8_t idx,
 			uint32_t etqf, uint32_t etqs);
 int ixgbe_ethertype_table_add(struct ixgbe_ethertype_table *table,
 			uint16_t ethertype, uint32_t etqf, uint32_t etqs);
 int ixgbe_ethertype_table_del(struct ixgbe_ethertype_table *table, uint8_t idx);
+void ixgbe_syn_filter_program(struct ixgbe_hw *hw, uint32_t synqf);
 
 /**
  * l2 tunnel configuration.
@@ -757,7 +753,6 @@ int ixgbe_clear_all_fdir_filter(struct rte_eth_dev *dev);
 extern const struct rte_flow_ops ixgbe_flow_ops;
 
 void ixgbe_clear_all_ntuple_filter(struct rte_eth_dev *dev);
-void ixgbe_clear_syn_filter(struct rte_eth_dev *dev);
 int ixgbe_clear_all_l2_tn_filter(struct rte_eth_dev *dev);
 
 int ixgbe_disable_sec_tx_path_generic(struct ixgbe_hw *hw);
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index f41f5501d88..4286e2f2382 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -63,11 +63,6 @@ struct ixgbe_ntuple_filter_ele {
 	struct ixgbe_filter_ele_base base;
 	struct rte_eth_ntuple_filter filter_info;
 };
-/* syn filter list structure */
-struct ixgbe_eth_syn_filter_ele {
-	struct ixgbe_filter_ele_base base;
-	struct rte_eth_syn_filter filter_info;
-};
 /* fdir filter list structure */
 struct ixgbe_fdir_rule_ele {
 	struct ixgbe_filter_ele_base base;
@@ -92,7 +87,8 @@ struct ixgbe_flow_mem {
 const struct ci_flow_engine_list ixgbe_flow_engine_list = {
 	{
 		&ixgbe_ethertype_flow_engine,
-	}
+		&ixgbe_syn_flow_engine,
+	},
 };
 
 /**
@@ -666,205 +662,6 @@ ixgbe_parse_ntuple_filter(struct rte_eth_dev *dev,
 	return 0;
 }
 
-/**
- * Parse the rule to see if it is a TCP SYN rule.
- * And get the TCP SYN filter info BTW.
- * pattern:
- * The first not void item must be ETH.
- * The second not void item must be IPV4 or IPV6.
- * The third not void item must be TCP.
- * The next not void item must be END.
- * action:
- * The first not void action should be QUEUE.
- * The next not void action should be END.
- * pattern example:
- * ITEM		Spec			Mask
- * ETH		NULL			NULL
- * IPV4/IPV6	NULL			NULL
- * TCP		tcp_flags	0x02	0xFF
- * END
- * other members in mask and spec should set to 0x00.
- * item->last should be NULL.
- */
-static int
-cons_parse_syn_filter(const struct rte_flow_attr *attr, const struct rte_flow_item pattern[],
-		const struct rte_flow_action_queue *q_act, struct rte_eth_syn_filter *filter,
-		struct rte_flow_error *error)
-{
-	const struct rte_flow_item *item;
-	const struct rte_flow_item_tcp *tcp_spec;
-	const struct rte_flow_item_tcp *tcp_mask;
-
-
-	/* the first not void item should be MAC or IPv4 or IPv6 or TCP */
-	item = next_no_void_pattern(pattern, NULL);
-	if (item->type != RTE_FLOW_ITEM_TYPE_ETH &&
-	    item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
-	    item->type != RTE_FLOW_ITEM_TYPE_IPV6 &&
-	    item->type != RTE_FLOW_ITEM_TYPE_TCP) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by syn filter");
-		return -rte_errno;
-	}
-		/*Not supported last point for range*/
-	if (item->last) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			item, "Not supported last point for range");
-		return -rte_errno;
-	}
-
-	/* Skip Ethernet */
-	if (item->type == RTE_FLOW_ITEM_TYPE_ETH) {
-		/* if the item is MAC, the content should be NULL */
-		if (item->spec || item->mask) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Invalid SYN address mask");
-			return -rte_errno;
-		}
-
-		/* check if the next not void item is IPv4 or IPv6 */
-		item = next_no_void_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
-		    item->type != RTE_FLOW_ITEM_TYPE_IPV6) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by syn filter");
-			return -rte_errno;
-		}
-	}
-
-	/* Skip IP */
-	if (item->type == RTE_FLOW_ITEM_TYPE_IPV4 ||
-	    item->type == RTE_FLOW_ITEM_TYPE_IPV6) {
-		/* if the item is IP, the content should be NULL */
-		if (item->spec || item->mask) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Invalid SYN mask");
-			return -rte_errno;
-		}
-
-		/* check if the next not void item is TCP */
-		item = next_no_void_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_TCP) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by syn filter");
-			return -rte_errno;
-		}
-	}
-
-	/* Get the TCP info. Only support SYN. */
-	if (!item->spec || !item->mask) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Invalid SYN mask");
-		return -rte_errno;
-	}
-	/*Not supported last point for range*/
-	if (item->last) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			item, "Not supported last point for range");
-		return -rte_errno;
-	}
-
-	tcp_spec = item->spec;
-	tcp_mask = item->mask;
-	if (!(tcp_spec->hdr.tcp_flags & RTE_TCP_SYN_FLAG) ||
-	    tcp_mask->hdr.src_port ||
-	    tcp_mask->hdr.dst_port ||
-	    tcp_mask->hdr.sent_seq ||
-	    tcp_mask->hdr.recv_ack ||
-	    tcp_mask->hdr.data_off ||
-	    tcp_mask->hdr.tcp_flags != RTE_TCP_SYN_FLAG ||
-	    tcp_mask->hdr.rx_win ||
-	    tcp_mask->hdr.cksum ||
-	    tcp_mask->hdr.tcp_urp) {
-		memset(filter, 0, sizeof(struct rte_eth_syn_filter));
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by syn filter");
-		return -rte_errno;
-	}
-
-	/* check if the next not void item is END */
-	item = next_no_void_pattern(pattern, item);
-	if (item->type != RTE_FLOW_ITEM_TYPE_END) {
-		memset(filter, 0, sizeof(struct rte_eth_syn_filter));
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by syn filter");
-		return -rte_errno;
-	}
-
-	filter->queue = q_act->index;
-
-	/* Support 2 priorities, the lowest or highest. */
-	if (attr->priority == 0) {
-		filter->hig_pri = 1;
-	} else if (attr->priority == (uint32_t)~0U) {
-		filter->hig_pri = 0;
-	} else {
-		memset(filter, 0, sizeof(struct rte_eth_syn_filter));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY,
-			attr, "Priority can be 0 or 0xFFFFFFFF");
-		return -rte_errno;
-	}
-
-	return 0;
-}
-
-static int
-ixgbe_parse_syn_filter(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
-		const struct rte_flow_item pattern[], const struct rte_flow_action actions[],
-		struct rte_eth_syn_filter *filter, struct rte_flow_error *error)
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
-		.driver_ctx = dev->data,
-		.check = ixgbe_flow_actions_check,
-		.max_actions = 1,
-	};
-	struct ci_flow_attr_check_param attr_param = {
-		.allow_priority = true,
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
-	ret = ci_flow_check_attr(attr, &attr_param, error);
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
-	return cons_parse_syn_filter(attr, pattern, action->conf, filter, error);
-}
-
 /**
  * Parse the rule to see if it is a L2 tunnel rule.
  * And get the L2 tunnel filter info BTW.
@@ -2655,7 +2452,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	struct ixgbe_adapter *adapter =
 		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct rte_eth_ntuple_filter ntuple_filter;
-	struct rte_eth_syn_filter syn_filter;
 	struct ixgbe_fdir_rule fdir_rule;
 	struct ixgbe_l2_tunnel_conf l2_tn_filter;
 	struct ixgbe_hw_fdir_info *fdir_info =
@@ -2663,7 +2459,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	struct ixgbe_rte_flow_rss_conf rss_conf;
 	struct rte_flow *flow = NULL;
 	struct ixgbe_ntuple_filter_ele *ntuple_filter_ptr;
-	struct ixgbe_eth_syn_filter_ele *syn_filter_ptr;
 	struct ixgbe_eth_l2_tunnel_conf_ele *l2_tn_filter_ptr;
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
@@ -2724,28 +2519,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 		return flow;
 	}
 
-	memset(&syn_filter, 0, sizeof(struct rte_eth_syn_filter));
-	ret = ixgbe_parse_syn_filter(dev, attr, pattern,
-				actions, &syn_filter, error);
-	if (!ret) {
-		syn_filter_ptr = rte_zmalloc("ixgbe_syn_filter",
-			sizeof(struct ixgbe_eth_syn_filter_ele), 0);
-		if (!syn_filter_ptr) {
-			PMD_DRV_LOG(ERR, "failed to allocate memory");
-			ret = -ENOMEM;
-			goto out;
-		}
-		syn_filter_ptr->filter_info = syn_filter;
-		ret = ixgbe_syn_filter_set(adapter, &syn_filter, TRUE);
-		if (ret) {
-			rte_free(syn_filter_ptr);
-			goto out;
-		}
-		flow->rule = syn_filter_ptr;
-		flow->filter_type = RTE_ETH_FILTER_SYN;
-		return flow;
-	}
-
 	memset(&fdir_rule, 0, sizeof(struct ixgbe_fdir_rule));
 	ret = ixgbe_parse_fdir_filter(dev, attr, pattern,
 				actions, &fdir_rule, error);
@@ -2854,7 +2627,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 {
 	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct rte_eth_ntuple_filter ntuple_filter;
-	struct rte_eth_syn_filter syn_filter;
 	struct ixgbe_l2_tunnel_conf l2_tn_filter;
 	struct ixgbe_fdir_rule fdir_rule;
 	struct ixgbe_rte_flow_rss_conf rss_conf;
@@ -2880,12 +2652,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 	if (!ret)
 		return 0;
 
-	memset(&syn_filter, 0, sizeof(struct rte_eth_syn_filter));
-	ret = ixgbe_parse_syn_filter(dev, attr, pattern,
-				actions, &syn_filter, error);
-	if (!ret)
-		return 0;
-
 	memset(&fdir_rule, 0, sizeof(struct ixgbe_fdir_rule));
 	ret = ixgbe_parse_fdir_filter(dev, attr, pattern,
 				actions, &fdir_rule, error);
@@ -2917,11 +2683,9 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	struct rte_flow *pmd_flow = flow;
 	enum rte_filter_type filter_type = pmd_flow->filter_type;
 	struct rte_eth_ntuple_filter ntuple_filter;
-	struct rte_eth_syn_filter syn_filter;
 	struct ixgbe_fdir_rule fdir_rule;
 	struct ixgbe_l2_tunnel_conf l2_tn_filter;
 	struct ixgbe_ntuple_filter_ele *ntuple_filter_ptr;
-	struct ixgbe_eth_syn_filter_ele *syn_filter_ptr;
 	struct ixgbe_eth_l2_tunnel_conf_ele *l2_tn_filter_ptr;
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_filter_ele_base *flow_mem_base;
@@ -2966,14 +2730,6 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		if (!ret)
 			rte_free(ntuple_filter_ptr);
 		break;
-	case RTE_ETH_FILTER_SYN:
-		syn_filter_ptr = (struct ixgbe_eth_syn_filter_ele *)
-				pmd_flow->rule;
-		syn_filter = syn_filter_ptr->filter_info;
-		ret = ixgbe_syn_filter_set(adapter, &syn_filter, FALSE);
-		if (!ret)
-			rte_free(syn_filter_ptr);
-		break;
 	case RTE_ETH_FILTER_FDIR:
 		fdir_rule_ptr = (struct ixgbe_fdir_rule_ele *)pmd_flow->rule;
 		fdir_rule = fdir_rule_ptr->filter_info;
@@ -3042,7 +2798,6 @@ ixgbe_flow_flush(struct rte_eth_dev *dev,
 	}
 
 	ixgbe_clear_all_ntuple_filter(dev);
-	ixgbe_clear_syn_filter(dev);
 
 	ret = ixgbe_clear_all_fdir_filter(dev);
 	if (ret < 0) {
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.h b/drivers/net/intel/ixgbe/ixgbe_flow.h
index d7694283a54..453a23d3b63 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.h
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.h
@@ -16,5 +16,6 @@ ixgbe_flow_actions_check(const struct ci_flow_actions *actions,
 extern const struct ci_flow_engine_list ixgbe_flow_engine_list;
 
 extern const struct ci_flow_engine ixgbe_ethertype_flow_engine;
+extern const struct ci_flow_engine ixgbe_syn_flow_engine;
 
 #endif /*  _IXGBE_FLOW_H_ */
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow_syn.c b/drivers/net/intel/ixgbe/ixgbe_flow_syn.c
new file mode 100644
index 00000000000..ec15b97de04
--- /dev/null
+++ b/drivers/net/intel/ixgbe/ixgbe_flow_syn.c
@@ -0,0 +1,312 @@
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
+struct ixgbe_syn_flow {
+	struct rte_flow flow;
+	struct rte_eth_syn_filter syn;
+};
+
+struct ixgbe_syn_ctx {
+	struct ci_flow_engine_ctx base;
+	struct rte_eth_syn_filter syn;
+};
+
+struct ixgbe_syn_priv {
+	bool installed; /* hardware supports a single SYN filter */
+};
+
+/**
+ * SYN filter graph implementation
+ * Pattern: START -> [ETH -> (IPV4|IPV6)] -> TCP -> END
+ */
+
+enum ixgbe_syn_node_id {
+	IXGBE_SYN_NODE_START = FLOW_GRAPH_NODE_FIRST,
+	IXGBE_SYN_NODE_ETH,
+	IXGBE_SYN_NODE_IPV4,
+	IXGBE_SYN_NODE_IPV6,
+	IXGBE_SYN_NODE_TCP,
+	IXGBE_SYN_NODE_END,
+	IXGBE_SYN_NODE_MAX,
+};
+
+static int
+ixgbe_validate_syn_tcp(const void *ctx __rte_unused,
+		       const struct rte_flow_item *item,
+		       struct rte_flow_error *error)
+{
+	const struct rte_flow_item_tcp *tcp_spec;
+	const struct rte_flow_item_tcp *tcp_mask;
+
+	tcp_spec = item->spec;
+	tcp_mask = ci_flow_item_mask(item);
+
+	/* SYN flag must be set in spec */
+	if (!(tcp_spec->hdr.tcp_flags & RTE_TCP_SYN_FLAG)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"TCP SYN flag must be set");
+	}
+
+	/* Mask must match only SYN flag */
+	if (tcp_mask->hdr.tcp_flags != RTE_TCP_SYN_FLAG) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"TCP flags mask must match SYN only");
+	}
+
+	/* All other TCP fields must have zero mask */
+	if (tcp_mask->hdr.src_port ||
+	    tcp_mask->hdr.dst_port ||
+	    tcp_mask->hdr.sent_seq ||
+	    tcp_mask->hdr.recv_ack ||
+	    tcp_mask->hdr.data_off ||
+	    tcp_mask->hdr.rx_win ||
+	    tcp_mask->hdr.cksum ||
+	    tcp_mask->hdr.tcp_urp) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Only TCP flags filtering supported");
+	}
+
+	return 0;
+}
+
+static const struct flow_graph ixgbe_syn_graph = {
+	.nodes = (struct flow_graph_node[]) {
+		[IXGBE_SYN_NODE_START] = {
+			.name = "START",
+		},
+		[IXGBE_SYN_NODE_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+		},
+		[IXGBE_SYN_NODE_IPV4] = {
+			.name = "IPV4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+		},
+		[IXGBE_SYN_NODE_IPV6] = {
+			.name = "IPV6",
+			.type = RTE_FLOW_ITEM_TYPE_IPV6,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+		},
+		[IXGBE_SYN_NODE_TCP] = {
+			.name = "TCP",
+			.type = RTE_FLOW_ITEM_TYPE_TCP,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC,
+			.validate = ixgbe_validate_syn_tcp,
+		},
+		[IXGBE_SYN_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	},
+	.edges = (struct flow_graph_edge[]) {
+		[IXGBE_SYN_NODE_START] = {
+			.next = (size_t[]) {
+				IXGBE_SYN_NODE_ETH,
+				IXGBE_SYN_NODE_IPV4,
+				IXGBE_SYN_NODE_IPV6,
+				IXGBE_SYN_NODE_TCP,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_SYN_NODE_ETH] = {
+			.next = (size_t[]) {
+				IXGBE_SYN_NODE_IPV4,
+				IXGBE_SYN_NODE_IPV6,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_SYN_NODE_IPV4] = {
+			.next = (size_t[]) {
+				IXGBE_SYN_NODE_TCP,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_SYN_NODE_IPV6] = {
+			.next = (size_t[]) {
+				IXGBE_SYN_NODE_TCP,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_SYN_NODE_TCP] = {
+			.next = (size_t[]) {
+				IXGBE_SYN_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+static int
+ixgbe_flow_syn_ctx_init(const struct rte_flow_action actions[],
+		const struct rte_flow_attr *attr,
+		struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_syn_ctx *syn_ctx = (struct ixgbe_syn_ctx *)ctx;
+	struct ci_flow_actions parsed_actions;
+	struct ci_flow_actions_check_param ap_param = {
+		.allowed_types = (const enum rte_flow_action_type[]){
+			/* only queue is allowed here */
+			RTE_FLOW_ACTION_TYPE_QUEUE,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.driver_ctx = ctx->dev_data,
+		.check = ixgbe_flow_actions_check,
+		.max_actions = 1,
+	};
+	struct ci_flow_attr_check_param attr_param = {
+		.allow_priority = true,
+	};
+	const struct rte_flow_action_queue *q_act;
+	int ret;
+
+	/* validate attributes */
+	ret = ci_flow_check_attr(attr, &attr_param, error);
+	if (ret)
+		return ret;
+
+	/* check priority */
+	if (attr->priority != 0 && attr->priority != (uint32_t)~0U) {
+		return rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY,
+			attr, "Priority can be 0 or 0xFFFFFFFF");
+	}
+
+	/* parse requested actions */
+	ret = ci_flow_check_actions(actions, &ap_param, &parsed_actions, error);
+	if (ret)
+		return ret;
+
+	q_act = parsed_actions.actions[0]->conf;
+
+	syn_ctx->syn.queue = q_act->index;
+
+	/* Support 2 priorities. rte_flow priority 0 is highest */
+	syn_ctx->syn.hig_pri = attr->priority == 0;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_syn_ctx_to_flow(const struct ci_flow_engine_ctx *ctx,
+		struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct ixgbe_syn_ctx *syn_ctx = (const struct ixgbe_syn_ctx *)ctx;
+	struct ixgbe_syn_flow *syn_flow = (struct ixgbe_syn_flow *)flow;
+
+	syn_flow->syn = syn_ctx->syn;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_syn_flow_register(struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_syn_priv *priv = flow->engine_priv;
+
+	/* hardware supports a single SYN filter */
+	if (priv->installed) {
+		return rte_flow_error_set(error, EEXIST,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"SYN filter already exists");
+	}
+
+	priv->installed = true;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_syn_flow_unregister(struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_syn_priv *priv = flow->engine_priv;
+
+	priv->installed = false;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_syn_flow_install(struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_syn_flow *syn_flow = (struct ixgbe_syn_flow *)flow;
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(flow->dev_data->dev_private);
+	uint32_t synqf;
+
+	synqf = ((syn_flow->syn.queue << IXGBE_SYN_FILTER_QUEUE_SHIFT) &
+			IXGBE_SYN_FILTER_QUEUE) | IXGBE_SYN_FILTER_ENABLE;
+	if (syn_flow->syn.hig_pri)
+		synqf |= IXGBE_SYN_FILTER_SYNQFP;
+
+	ixgbe_syn_filter_program(hw, synqf);
+
+	return 0;
+}
+
+static int
+ixgbe_flow_syn_flow_uninstall(struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(flow->dev_data->dev_private);
+
+	ixgbe_syn_filter_program(hw, 0);
+
+	return 0;
+}
+
+static int
+ixgbe_flow_syn_engine_init(const struct ci_flow_engine *engine __rte_unused,
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
+static const struct ci_flow_engine_ops ixgbe_syn_ops = {
+	.engine_init = ixgbe_flow_syn_engine_init,
+	.ctx_init = ixgbe_flow_syn_ctx_init,
+	.ctx_to_flow = ixgbe_flow_syn_ctx_to_flow,
+	.flow_register = ixgbe_flow_syn_flow_register,
+	.flow_unregister = ixgbe_flow_syn_flow_unregister,
+	.flow_install = ixgbe_flow_syn_flow_install,
+	.flow_uninstall = ixgbe_flow_syn_flow_uninstall,
+};
+
+const struct ci_flow_engine ixgbe_syn_flow_engine = {
+	.name = "ixgbe_syn",
+	.ctx_size = sizeof(struct ixgbe_syn_ctx),
+	.flow_size = sizeof(struct ixgbe_syn_flow),
+	.priv_size = sizeof(struct ixgbe_syn_priv),
+	.ops = &ixgbe_syn_ops,
+	.graph = &ixgbe_syn_graph,
+};
diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
index f2857feab76..1ef818fa67a 100644
--- a/drivers/net/intel/ixgbe/meson.build
+++ b/drivers/net/intel/ixgbe/meson.build
@@ -27,6 +27,7 @@ sources += files(
         'ixgbe_fdir.c',
         'ixgbe_flow.c',
         'ixgbe_flow_ethertype.c',
+        'ixgbe_flow_syn.c',
         'ixgbe_ipsec.c',
         'ixgbe_pf.c',
         'ixgbe_rxtx.c',
-- 
2.52.0

