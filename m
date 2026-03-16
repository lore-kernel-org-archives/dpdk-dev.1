Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07015F53D80
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 17:28:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5F0740670;
	Mon, 16 Mar 2026 18:28:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 806764065E
 for <dev@dpdk.org>; Mon, 16 Mar 2026 18:28:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773682085; x=1805218085;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=KaoQ7FkJ2eibAVbgO5H1oQdP552UEI/zl8xyNmV853o=;
 b=DPaR0d2XoZdW+MWLfNpdFUHE3RYmhsvwq5eIzJFP7zmObjt2fNuDIEJh
 kfDo3ZE6UHNb2VRSnzMSLaxSy3OK9nEscui6WmKm2HpIW5gZh7qBkQ/zx
 bkPGw2+GAk/Wu31/I/okFzBA1jH2nVx1hk0x6JUHTDgQwKh6kMtx7Wan1
 WvXg0LvgPbJ0LkHnNCWoNSgu5Joq5tJyLV9/W5usqdnnR3iA6+uZ/zu2i
 2RTJaDSW+Ldv0A/7gPAjOSbLjpfzS9YxtPtVKqxd87hrpThJSUUHMlqLA
 GcDGCWHwbebeyPl3PfUS3YXStXn9QYoYgC2n34VtPZYsG9vZi8QxpUTSS Q==;
X-CSE-ConnectionGUID: edV8hK9IQuuj/1OWwr8R4Q==
X-CSE-MsgGUID: 19yf5azPTzq2CVP4YUgbgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86059619"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="86059619"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 10:28:04 -0700
X-CSE-ConnectionGUID: yalDMlVuRpSK9t0afT2Pfw==
X-CSE-MsgGUID: Y5zeZYLDSTaY0T/oKCol8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221228205"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 16 Mar 2026 10:28:04 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [RFC PATCH v1 05/21] net/ixgbe: reimplement ethertype parser
Date: Mon, 16 Mar 2026 17:27:33 +0000
Message-ID: <d2204fdfb221bff03a7e34bc4861918a9ebc5a9e.1773681364.git.anatoly.burakov@intel.com>
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
flow parser for ethertype.

The old ethertype parser was accepting certain things that were later
rejected by the actual ethertype installation code, in particular DROP
action as well as dst MAC address filtering. This was removed from the
graph parser.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  19 --
 drivers/net/intel/ixgbe/ixgbe_flow.c          | 238 +----------------
 drivers/net/intel/ixgbe/ixgbe_flow.h          |  12 +
 .../net/intel/ixgbe/ixgbe_flow_ethertype.c    | 240 ++++++++++++++++++
 drivers/net/intel/ixgbe/meson.build           |   1 +
 5 files changed, 262 insertions(+), 248 deletions(-)
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_ethertype.c

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index b4435acd20..a8ceca6cc6 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -6841,25 +6841,6 @@ ixgbe_add_del_ethertype_filter(struct rte_eth_dev *dev,
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
index 3f33d28207..6dda2f6a3c 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -46,6 +46,7 @@
 
 #include "../common/flow_check.h"
 #include "../common/flow_engine.h"
+#include "ixgbe_flow.h"
 
 #define IXGBE_MIN_N_TUPLE_PRIO 1
 #define IXGBE_MAX_N_TUPLE_PRIO 7
@@ -88,7 +89,6 @@ struct ixgbe_flow_mem {
 };
 
 TAILQ_HEAD(ixgbe_ntuple_filter_list, ixgbe_ntuple_filter_ele);
-TAILQ_HEAD(ixgbe_ethertype_filter_list, ixgbe_ethertype_filter_ele);
 TAILQ_HEAD(ixgbe_syn_filter_list, ixgbe_eth_syn_filter_ele);
 TAILQ_HEAD(ixgbe_fdir_rule_filter_list, ixgbe_fdir_rule_ele);
 TAILQ_HEAD(ixgbe_l2_tunnel_filter_list, ixgbe_eth_l2_tunnel_conf_ele);
@@ -96,14 +96,17 @@ TAILQ_HEAD(ixgbe_rss_filter_list, ixgbe_rss_conf_ele);
 TAILQ_HEAD(ixgbe_flow_mem_list, ixgbe_flow_mem);
 
 static struct ixgbe_ntuple_filter_list filter_ntuple_list;
-static struct ixgbe_ethertype_filter_list filter_ethertype_list;
 static struct ixgbe_syn_filter_list filter_syn_list;
 static struct ixgbe_fdir_rule_filter_list filter_fdir_list;
 static struct ixgbe_l2_tunnel_filter_list filter_l2_tunnel_list;
 static struct ixgbe_rss_filter_list filter_rss_list;
 static struct ixgbe_flow_mem_list ixgbe_flow_list;
 
-const struct ci_flow_engine_list ixgbe_flow_engine_list = {0};
+const struct ci_flow_engine_list ixgbe_flow_engine_list = {
+	{
+		&ixgbe_ethertype_flow_engine,
+	}
+};
 
 /**
  * Endless loop will never happen with below assumption
@@ -127,14 +130,14 @@ const struct rte_flow_item *next_no_void_pattern(
 /*
  * All ixgbe engines mostly check the same stuff, so use a common check.
  */
-static int
+int
 ixgbe_flow_actions_check(const struct ci_flow_actions *actions,
 		const struct ci_flow_actions_check_param *param,
 		struct rte_flow_error *error)
 {
 	const struct rte_flow_action *action;
-	struct rte_eth_dev *dev = (struct rte_eth_dev *)param->driver_ctx;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	const struct rte_eth_dev *dev = param->driver_ctx;
+	const struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	size_t idx;
 
 	for (idx = 0; idx < actions->count; idx++) {
@@ -685,169 +688,6 @@ ixgbe_parse_ntuple_filter(struct rte_eth_dev *dev,
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
-		.driver_ctx = dev,
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
@@ -2709,7 +2549,6 @@ void
 ixgbe_filterlist_init(void)
 {
 	TAILQ_INIT(&filter_ntuple_list);
-	TAILQ_INIT(&filter_ethertype_list);
 	TAILQ_INIT(&filter_syn_list);
 	TAILQ_INIT(&filter_fdir_list);
 	TAILQ_INIT(&filter_l2_tunnel_list);
@@ -2721,7 +2560,6 @@ void
 ixgbe_filterlist_flush(void)
 {
 	struct ixgbe_ntuple_filter_ele *ntuple_filter_ptr;
-	struct ixgbe_ethertype_filter_ele *ethertype_filter_ptr;
 	struct ixgbe_eth_syn_filter_ele *syn_filter_ptr;
 	struct ixgbe_eth_l2_tunnel_conf_ele *l2_tn_filter_ptr;
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
@@ -2735,13 +2573,6 @@ ixgbe_filterlist_flush(void)
 		rte_free(ntuple_filter_ptr);
 	}
 
-	while ((ethertype_filter_ptr = TAILQ_FIRST(&filter_ethertype_list))) {
-		TAILQ_REMOVE(&filter_ethertype_list,
-				 ethertype_filter_ptr,
-				 entries);
-		rte_free(ethertype_filter_ptr);
-	}
-
 	while ((syn_filter_ptr = TAILQ_FIRST(&filter_syn_list))) {
 		TAILQ_REMOVE(&filter_syn_list,
 				 syn_filter_ptr,
@@ -2795,7 +2626,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	struct ixgbe_adapter *ad = dev->data->dev_private;
 	int ret;
 	struct rte_eth_ntuple_filter ntuple_filter;
-	struct rte_eth_ethertype_filter ethertype_filter;
 	struct rte_eth_syn_filter syn_filter;
 	struct ixgbe_fdir_rule fdir_rule;
 	struct ixgbe_l2_tunnel_conf l2_tn_filter;
@@ -2804,7 +2634,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	struct ixgbe_rte_flow_rss_conf rss_conf;
 	struct rte_flow *flow = NULL;
 	struct ixgbe_ntuple_filter_ele *ntuple_filter_ptr;
-	struct ixgbe_ethertype_filter_ele *ethertype_filter_ptr;
 	struct ixgbe_eth_syn_filter_ele *syn_filter_ptr;
 	struct ixgbe_eth_l2_tunnel_conf_ele *l2_tn_filter_ptr;
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
@@ -2871,32 +2700,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 		goto out;
 	}
 
-	memset(&ethertype_filter, 0, sizeof(struct rte_eth_ethertype_filter));
-	ret = ixgbe_parse_ethertype_filter(dev, attr, pattern,
-				actions, &ethertype_filter, error);
-	if (!ret) {
-		ret = ixgbe_add_del_ethertype_filter(dev,
-				&ethertype_filter, TRUE);
-		if (!ret) {
-			ethertype_filter_ptr = rte_zmalloc(
-				"ixgbe_ethertype_filter",
-				sizeof(struct ixgbe_ethertype_filter_ele), 0);
-			if (!ethertype_filter_ptr) {
-				PMD_DRV_LOG(ERR, "failed to allocate memory");
-				goto out;
-			}
-			rte_memcpy(&ethertype_filter_ptr->filter_info,
-				&ethertype_filter,
-				sizeof(struct rte_eth_ethertype_filter));
-			TAILQ_INSERT_TAIL(&filter_ethertype_list,
-				ethertype_filter_ptr, entries);
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
@@ -3067,7 +2870,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 {
 	struct ixgbe_adapter *ad = dev->data->dev_private;
 	struct rte_eth_ntuple_filter ntuple_filter;
-	struct rte_eth_ethertype_filter ethertype_filter;
 	struct rte_eth_syn_filter syn_filter;
 	struct ixgbe_l2_tunnel_conf l2_tn_filter;
 	struct ixgbe_fdir_rule fdir_rule;
@@ -3095,12 +2897,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
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
@@ -3137,12 +2933,10 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
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
@@ -3180,20 +2974,6 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 			rte_free(ntuple_filter_ptr);
 		}
 		break;
-	case RTE_ETH_FILTER_ETHERTYPE:
-		ethertype_filter_ptr = (struct ixgbe_ethertype_filter_ele *)
-					pmd_flow->rule;
-		rte_memcpy(&ethertype_filter,
-			&ethertype_filter_ptr->filter_info,
-			sizeof(struct rte_eth_ethertype_filter));
-		ret = ixgbe_add_del_ethertype_filter(dev,
-				&ethertype_filter, FALSE);
-		if (!ret) {
-			TAILQ_REMOVE(&filter_ethertype_list,
-				ethertype_filter_ptr, entries);
-			rte_free(ethertype_filter_ptr);
-		}
-		break;
 	case RTE_ETH_FILTER_SYN:
 		syn_filter_ptr = (struct ixgbe_eth_syn_filter_ele *)
 				pmd_flow->rule;
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.h b/drivers/net/intel/ixgbe/ixgbe_flow.h
index 5e68c9886c..f67937f3ea 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.h
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.h
@@ -5,8 +5,20 @@
 #ifndef _IXGBE_FLOW_H_
 #define _IXGBE_FLOW_H_
 
+#include "../common/flow_check.h"
 #include "../common/flow_engine.h"
 
+enum ixgbe_flow_engine_type {
+	IXGBE_FLOW_ENGINE_TYPE_ETHERTYPE = 0,
+};
+
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
index 0000000000..b2bef3ef3a
--- /dev/null
+++ b/drivers/net/intel/ixgbe/ixgbe_flow_ethertype.c
@@ -0,0 +1,240 @@
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
+const struct rte_flow_graph ixgbe_ethertype_graph = {
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
+		.driver_ctx = ctx->dev,
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
+	int ret;
+
+	ret = ixgbe_add_del_ethertype_filter(flow->dev, &ethertype_flow->filter, TRUE);
+	if (ret) {
+		return rte_flow_error_set(error, ret,
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
+	int ret;
+
+	ret = ixgbe_add_del_ethertype_filter(flow->dev, &ethertype_flow->filter, FALSE);
+	if (ret) {
+		return rte_flow_error_set(error, ret,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Failed to delete ethertype filter");
+	}
+	return ret;
+}
+
+static bool
+ixgbe_flow_ethertype_is_available(const struct ci_flow_engine *engine __rte_unused,
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
+const struct ci_flow_engine_ops ixgbe_ethertype_ops = {
+	.is_available = ixgbe_flow_ethertype_is_available,
+	.ctx_parse = ixgbe_flow_ethertype_ctx_parse,
+	.ctx_to_flow = ixgbe_flow_ethertype_ctx_to_flow,
+	.flow_install = ixgbe_flow_ethertype_install,
+	.flow_uninstall = ixgbe_flow_ethertype_uninstall,
+};
+
+const struct ci_flow_engine ixgbe_ethertype_flow_engine = {
+	.name = "ixgbe_ethertype",
+	.ctx_size = sizeof(struct ixgbe_ethertype_ctx),
+	.flow_size = sizeof(struct ixgbe_ethertype_flow),
+	.type = IXGBE_FLOW_ENGINE_TYPE_ETHERTYPE,
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
2.47.3

