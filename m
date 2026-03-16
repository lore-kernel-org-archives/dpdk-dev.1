Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D46F53D80
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 17:28:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CD2B4067E;
	Mon, 16 Mar 2026 18:28:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 0B60E4066E
 for <dev@dpdk.org>; Mon, 16 Mar 2026 18:28:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773682086; x=1805218086;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=pkbLSbm6Nam/zQP7KkKosc3SXHPRx/PHhwkwNJ3XjuQ=;
 b=cISnAwDqbG3yVEksRWu9Hb+H7q0QWEhvBBctkErkbTlpxCfFlPlD95o/
 welIx7pCaMX7EXiAIPqhqDU2J99azUo15FbdaPVx++OVlghxjIN/4++zp
 /I5kMJfw/lw+Bo5gcx8aUDrqMGHjn/I2cJULKL7pHoNNKz9rhfvfO5vp9
 Ay85U7c3X+1TpIy1vYXKvmguAsc++PkKTKouMUvsiimsIhsePD+UjCIDk
 xDKki4GEZ8wjY03vJjD7mZoTgyEDaDtRA58jErZfubJiv2G1+eym9kaPb
 Xgt3CTd/9FtXalYewyFd59pHUTE9/3pFyR3BLS6HPSO2epl5cy/aBp2sl w==;
X-CSE-ConnectionGUID: 2PrBTkrCRnOYNac09Lkw5A==
X-CSE-MsgGUID: 0N+DkpDQS2qPdUv39p/ulw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86059620"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="86059620"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 10:28:05 -0700
X-CSE-ConnectionGUID: JbcXODk+TcCD8cyXIBFavA==
X-CSE-MsgGUID: 1ra9vuL+TFKNGddJsaye2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221228214"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 16 Mar 2026 10:28:05 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [RFC PATCH v1 06/21] net/ixgbe: reimplement syn parser
Date: Mon, 16 Mar 2026 17:27:34 +0000
Message-ID: <b69c9069b269e99f6946973117696c766ecd6ecc.1773681364.git.anatoly.burakov@intel.com>
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
flow parser for SYN.

As a result of this migration, queue index validation has changed:

- queue is now validated at parse time against the configured number of Rx
  queues (nb_rx_queues), rather than at install time against the hardware
  maximum (IXGBE_MAX_RX_QUEUE_NUM)
- the per-function queue bound check in ixgbe_syn_filter_set() has been
  removed as it is no longer needed

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c   |   3 -
 drivers/net/intel/ixgbe/ixgbe_flow.c     | 272 +---------------------
 drivers/net/intel/ixgbe/ixgbe_flow.h     |   2 +
 drivers/net/intel/ixgbe/ixgbe_flow_syn.c | 280 +++++++++++++++++++++++
 drivers/net/intel/ixgbe/meson.build      |   1 +
 5 files changed, 285 insertions(+), 273 deletions(-)
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_syn.c

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index a8ceca6cc6..442e4d96c6 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -6461,9 +6461,6 @@ ixgbe_syn_filter_set(struct rte_eth_dev *dev,
 	uint32_t syn_info;
 	uint32_t synqf;
 
-	if (filter->queue >= IXGBE_MAX_RX_QUEUE_NUM)
-		return -EINVAL;
-
 	syn_info = filter_info->syn_info;
 
 	if (add) {
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 6dda2f6a3c..d99a4a7f2a 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -57,16 +57,6 @@ struct ixgbe_ntuple_filter_ele {
 	TAILQ_ENTRY(ixgbe_ntuple_filter_ele) entries;
 	struct rte_eth_ntuple_filter filter_info;
 };
-/* ethertype filter list structure */
-struct ixgbe_ethertype_filter_ele {
-	TAILQ_ENTRY(ixgbe_ethertype_filter_ele) entries;
-	struct rte_eth_ethertype_filter filter_info;
-};
-/* syn filter list structure */
-struct ixgbe_eth_syn_filter_ele {
-	TAILQ_ENTRY(ixgbe_eth_syn_filter_ele) entries;
-	struct rte_eth_syn_filter filter_info;
-};
 /* fdir filter list structure */
 struct ixgbe_fdir_rule_ele {
 	TAILQ_ENTRY(ixgbe_fdir_rule_ele) entries;
@@ -89,14 +79,12 @@ struct ixgbe_flow_mem {
 };
 
 TAILQ_HEAD(ixgbe_ntuple_filter_list, ixgbe_ntuple_filter_ele);
-TAILQ_HEAD(ixgbe_syn_filter_list, ixgbe_eth_syn_filter_ele);
 TAILQ_HEAD(ixgbe_fdir_rule_filter_list, ixgbe_fdir_rule_ele);
 TAILQ_HEAD(ixgbe_l2_tunnel_filter_list, ixgbe_eth_l2_tunnel_conf_ele);
 TAILQ_HEAD(ixgbe_rss_filter_list, ixgbe_rss_conf_ele);
 TAILQ_HEAD(ixgbe_flow_mem_list, ixgbe_flow_mem);
 
 static struct ixgbe_ntuple_filter_list filter_ntuple_list;
-static struct ixgbe_syn_filter_list filter_syn_list;
 static struct ixgbe_fdir_rule_filter_list filter_fdir_list;
 static struct ixgbe_l2_tunnel_filter_list filter_l2_tunnel_list;
 static struct ixgbe_rss_filter_list filter_rss_list;
@@ -105,7 +93,8 @@ static struct ixgbe_flow_mem_list ixgbe_flow_list;
 const struct ci_flow_engine_list ixgbe_flow_engine_list = {
 	{
 		&ixgbe_ethertype_flow_engine,
-	}
+		&ixgbe_syn_flow_engine,
+	},
 };
 
 /**
@@ -688,205 +677,6 @@ ixgbe_parse_ntuple_filter(struct rte_eth_dev *dev,
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
-	if (!attr->priority) {
-		filter->hig_pri = 0;
-	} else if (attr->priority == (uint32_t)~0U) {
-		filter->hig_pri = 1;
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
-		.driver_ctx = dev,
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
@@ -2549,7 +2339,6 @@ void
 ixgbe_filterlist_init(void)
 {
 	TAILQ_INIT(&filter_ntuple_list);
-	TAILQ_INIT(&filter_syn_list);
 	TAILQ_INIT(&filter_fdir_list);
 	TAILQ_INIT(&filter_l2_tunnel_list);
 	TAILQ_INIT(&filter_rss_list);
@@ -2560,7 +2349,6 @@ void
 ixgbe_filterlist_flush(void)
 {
 	struct ixgbe_ntuple_filter_ele *ntuple_filter_ptr;
-	struct ixgbe_eth_syn_filter_ele *syn_filter_ptr;
 	struct ixgbe_eth_l2_tunnel_conf_ele *l2_tn_filter_ptr;
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
@@ -2573,13 +2361,6 @@ ixgbe_filterlist_flush(void)
 		rte_free(ntuple_filter_ptr);
 	}
 
-	while ((syn_filter_ptr = TAILQ_FIRST(&filter_syn_list))) {
-		TAILQ_REMOVE(&filter_syn_list,
-				 syn_filter_ptr,
-				 entries);
-		rte_free(syn_filter_ptr);
-	}
-
 	while ((l2_tn_filter_ptr = TAILQ_FIRST(&filter_l2_tunnel_list))) {
 		TAILQ_REMOVE(&filter_l2_tunnel_list,
 				 l2_tn_filter_ptr,
@@ -2626,7 +2407,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	struct ixgbe_adapter *ad = dev->data->dev_private;
 	int ret;
 	struct rte_eth_ntuple_filter ntuple_filter;
-	struct rte_eth_syn_filter syn_filter;
 	struct ixgbe_fdir_rule fdir_rule;
 	struct ixgbe_l2_tunnel_conf l2_tn_filter;
 	struct ixgbe_hw_fdir_info *fdir_info =
@@ -2634,7 +2414,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	struct ixgbe_rte_flow_rss_conf rss_conf;
 	struct rte_flow *flow = NULL;
 	struct ixgbe_ntuple_filter_ele *ntuple_filter_ptr;
-	struct ixgbe_eth_syn_filter_ele *syn_filter_ptr;
 	struct ixgbe_eth_l2_tunnel_conf_ele *l2_tn_filter_ptr;
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
@@ -2700,31 +2479,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 		goto out;
 	}
 
-	memset(&syn_filter, 0, sizeof(struct rte_eth_syn_filter));
-	ret = ixgbe_parse_syn_filter(dev, attr, pattern,
-				actions, &syn_filter, error);
-	if (!ret) {
-		ret = ixgbe_syn_filter_set(dev, &syn_filter, TRUE);
-		if (!ret) {
-			syn_filter_ptr = rte_zmalloc("ixgbe_syn_filter",
-				sizeof(struct ixgbe_eth_syn_filter_ele), 0);
-			if (!syn_filter_ptr) {
-				PMD_DRV_LOG(ERR, "failed to allocate memory");
-				goto out;
-			}
-			rte_memcpy(&syn_filter_ptr->filter_info,
-				&syn_filter,
-				sizeof(struct rte_eth_syn_filter));
-			TAILQ_INSERT_TAIL(&filter_syn_list,
-				syn_filter_ptr,
-				entries);
-			flow->rule = syn_filter_ptr;
-			flow->filter_type = RTE_ETH_FILTER_SYN;
-			return flow;
-		}
-		goto out;
-	}
-
 	memset(&fdir_rule, 0, sizeof(struct ixgbe_fdir_rule));
 	ret = ixgbe_parse_fdir_filter(dev, attr, pattern,
 				actions, &fdir_rule, error);
@@ -2870,7 +2624,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 {
 	struct ixgbe_adapter *ad = dev->data->dev_private;
 	struct rte_eth_ntuple_filter ntuple_filter;
-	struct rte_eth_syn_filter syn_filter;
 	struct ixgbe_l2_tunnel_conf l2_tn_filter;
 	struct ixgbe_fdir_rule fdir_rule;
 	struct ixgbe_rte_flow_rss_conf rss_conf;
@@ -2897,12 +2650,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
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
@@ -2933,11 +2680,9 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
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
 	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
@@ -2974,19 +2719,6 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 			rte_free(ntuple_filter_ptr);
 		}
 		break;
-	case RTE_ETH_FILTER_SYN:
-		syn_filter_ptr = (struct ixgbe_eth_syn_filter_ele *)
-				pmd_flow->rule;
-		rte_memcpy(&syn_filter,
-			&syn_filter_ptr->filter_info,
-			sizeof(struct rte_eth_syn_filter));
-		ret = ixgbe_syn_filter_set(dev, &syn_filter, FALSE);
-		if (!ret) {
-			TAILQ_REMOVE(&filter_syn_list,
-				syn_filter_ptr, entries);
-			rte_free(syn_filter_ptr);
-		}
-		break;
 	case RTE_ETH_FILTER_FDIR:
 		fdir_rule_ptr = (struct ixgbe_fdir_rule_ele *)pmd_flow->rule;
 		rte_memcpy(&fdir_rule,
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.h b/drivers/net/intel/ixgbe/ixgbe_flow.h
index f67937f3ea..3a5d0299b3 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.h
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.h
@@ -10,6 +10,7 @@
 
 enum ixgbe_flow_engine_type {
 	IXGBE_FLOW_ENGINE_TYPE_ETHERTYPE = 0,
+	IXGBE_FLOW_ENGINE_TYPE_SYN,
 };
 
 int
@@ -20,5 +21,6 @@ ixgbe_flow_actions_check(const struct ci_flow_actions *actions,
 extern const struct ci_flow_engine_list ixgbe_flow_engine_list;
 
 extern const struct ci_flow_engine ixgbe_ethertype_flow_engine;
+extern const struct ci_flow_engine ixgbe_syn_flow_engine;
 
 #endif /*  _IXGBE_FLOW_H_ */
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow_syn.c b/drivers/net/intel/ixgbe/ixgbe_flow_syn.c
new file mode 100644
index 0000000000..6cde38c326
--- /dev/null
+++ b/drivers/net/intel/ixgbe/ixgbe_flow_syn.c
@@ -0,0 +1,280 @@
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
+/**
+ * SYN filter graph implementation
+ * Pattern: START -> [ETH] -> (IPV4|IPV6) -> TCP -> END
+ */
+
+enum ixgbe_syn_node_id {
+	IXGBE_SYN_NODE_START = RTE_FLOW_NODE_FIRST,
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
+	tcp_mask = item->mask;
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
+const struct rte_flow_graph ixgbe_syn_graph = {
+	.nodes = (struct rte_flow_graph_node[]) {
+		[IXGBE_SYN_NODE_START] = {
+			.name = "START",
+		},
+		[IXGBE_SYN_NODE_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+		},
+		[IXGBE_SYN_NODE_IPV4] = {
+			.name = "IPV4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+		},
+		[IXGBE_SYN_NODE_IPV6] = {
+			.name = "IPV6",
+			.type = RTE_FLOW_ITEM_TYPE_IPV6,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+		},
+		[IXGBE_SYN_NODE_TCP] = {
+			.name = "TCP",
+			.type = RTE_FLOW_ITEM_TYPE_TCP,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = ixgbe_validate_syn_tcp,
+		},
+		[IXGBE_SYN_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	},
+	.edges = (struct rte_flow_graph_edge[]) {
+		[IXGBE_SYN_NODE_START] = {
+			.next = (const size_t[]) {
+				IXGBE_SYN_NODE_ETH,
+				IXGBE_SYN_NODE_IPV4,
+				IXGBE_SYN_NODE_IPV6,
+				IXGBE_SYN_NODE_TCP,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_SYN_NODE_ETH] = {
+			.next = (const size_t[]) {
+				IXGBE_SYN_NODE_IPV4,
+				IXGBE_SYN_NODE_IPV6,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_SYN_NODE_IPV4] = {
+			.next = (const size_t[]) {
+				IXGBE_SYN_NODE_TCP,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_SYN_NODE_IPV6] = {
+			.next = (const size_t[]) {
+				IXGBE_SYN_NODE_TCP,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_SYN_NODE_TCP] = {
+			.next = (const size_t[]) {
+				IXGBE_SYN_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+static int
+ixgbe_flow_syn_ctx_parse(const struct rte_flow_action actions[],
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
+		.driver_ctx = ctx->dev,
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
+	/* Support 2 priorities, the lowest or highest. */
+	syn_ctx->syn.hig_pri = attr->priority == 0 ? 0 : 1;
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
+ixgbe_flow_syn_flow_install(struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_syn_flow *syn_flow = (struct ixgbe_syn_flow *)flow;
+	struct rte_eth_dev *dev = flow->dev;
+	int ret = 0;
+
+	ret = ixgbe_syn_filter_set(dev, &syn_flow->syn, true);
+	if (ret != 0) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_HANDLE, flow,
+				"Failed to install SYN filter");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_flow_syn_flow_uninstall(struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_syn_flow *syn_flow = (struct ixgbe_syn_flow *)flow;
+	struct rte_eth_dev *dev = flow->dev;
+	int ret = 0;
+
+	ret = ixgbe_syn_filter_set(dev, &syn_flow->syn, false);
+	if (ret != 0) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_HANDLE, flow,
+				"Failed to uninstall SYN filter");
+	}
+
+	return 0;
+}
+
+static bool
+ixgbe_flow_syn_is_available(const struct ci_flow_engine *engine __rte_unused,
+		const struct rte_eth_dev *dev)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+
+	return hw->mac.type == ixgbe_mac_82599EB ||
+			hw->mac.type == ixgbe_mac_X540 ||
+			hw->mac.type == ixgbe_mac_X550 ||
+			hw->mac.type == ixgbe_mac_X550EM_x ||
+			hw->mac.type == ixgbe_mac_X550EM_a ||
+			hw->mac.type == ixgbe_mac_E610;
+}
+
+const struct ci_flow_engine_ops ixgbe_syn_ops = {
+	.is_available = ixgbe_flow_syn_is_available,
+	.ctx_parse = ixgbe_flow_syn_ctx_parse,
+	.ctx_to_flow = ixgbe_flow_syn_ctx_to_flow,
+	.flow_install = ixgbe_flow_syn_flow_install,
+	.flow_uninstall = ixgbe_flow_syn_flow_uninstall,
+};
+
+const struct ci_flow_engine ixgbe_syn_flow_engine = {
+	.name = "ixgbe_syn",
+	.ctx_size = sizeof(struct ixgbe_syn_ctx),
+	.flow_size = sizeof(struct ixgbe_syn_flow),
+	.type = IXGBE_FLOW_ENGINE_TYPE_SYN,
+	.ops = &ixgbe_syn_ops,
+	.graph = &ixgbe_syn_graph,
+};
diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
index 54d7e87de8..bd9be0add3 100644
--- a/drivers/net/intel/ixgbe/meson.build
+++ b/drivers/net/intel/ixgbe/meson.build
@@ -12,6 +12,7 @@ sources += files(
         'ixgbe_fdir.c',
         'ixgbe_flow.c',
         'ixgbe_flow_ethertype.c',
+        'ixgbe_flow_syn.c',
         'ixgbe_ipsec.c',
         'ixgbe_pf.c',
         'ixgbe_rxtx.c',
-- 
2.47.3

