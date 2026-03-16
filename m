Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2203F53D80
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 17:29:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D84FB40691;
	Mon, 16 Mar 2026 18:28:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id F195D40672
 for <dev@dpdk.org>; Mon, 16 Mar 2026 18:28:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773682087; x=1805218087;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Zai6EAioMND+h0LLNpI5Ttcy9jxx7YM+M2iKbOmt2IQ=;
 b=j6+sGPPpH+ryYW4/obaKNvMQjO6ZdJAmXr5qSueXbtMaQnwxFqx/iiBX
 jgQeADJhV0grQBm8YF9nnic9Mwi3XvP40X8HO42Np14Hcehy1alLEVuUh
 SBFGtr49l8jkXpb0xHixPP2C6PUdyD/2CBAdnx+XwIDYn211zkaCmjkdO
 3rDrKvDDIOrVqy12rcIpZ1WOu8oY0FMDKjNXl8N8Ae7HTmccPqCVjtxga
 xCH5aL/hDF8F10XDrEZKZbogrLgujGoU5go7N/pZaq+NM3KF1dwLmKBDH
 GcStaP0+/CdCNKdogtkBxy4iEJmsRWbqaV60EydftngcdhquRLFUefSmL Q==;
X-CSE-ConnectionGUID: fWgb0VjxQz6ftUDLqi0+Vw==
X-CSE-MsgGUID: k56xgWP2TUasYWlupa4IvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86059627"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="86059627"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 10:28:06 -0700
X-CSE-ConnectionGUID: zJ3ZTZsFTo2RiQZ3rZTUDw==
X-CSE-MsgGUID: mDoDtgzqRomPfxfIDIcmUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221228219"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 16 Mar 2026 10:28:06 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [RFC PATCH v1 07/21] net/ixgbe: reimplement L2 tunnel parser
Date: Mon, 16 Mar 2026 17:27:35 +0000
Message-ID: <a91915b42ca4db9517222215e08fb928bbc14732.1773681364.git.anatoly.burakov@intel.com>
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
flow parser for L2 tunnel.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c       | 217 +-------------------
 drivers/net/intel/ixgbe/ixgbe_flow.h       |   2 +
 drivers/net/intel/ixgbe/ixgbe_flow_l2tun.c | 228 +++++++++++++++++++++
 drivers/net/intel/ixgbe/meson.build        |   1 +
 4 files changed, 232 insertions(+), 216 deletions(-)
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_l2tun.c

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index d99a4a7f2a..313af2362b 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -62,11 +62,6 @@ struct ixgbe_fdir_rule_ele {
 	TAILQ_ENTRY(ixgbe_fdir_rule_ele) entries;
 	struct ixgbe_fdir_rule filter_info;
 };
-/* l2_tunnel filter list structure */
-struct ixgbe_eth_l2_tunnel_conf_ele {
-	TAILQ_ENTRY(ixgbe_eth_l2_tunnel_conf_ele) entries;
-	struct ixgbe_l2_tunnel_conf filter_info;
-};
 /* rss filter list structure */
 struct ixgbe_rss_conf_ele {
 	TAILQ_ENTRY(ixgbe_rss_conf_ele) entries;
@@ -80,13 +75,11 @@ struct ixgbe_flow_mem {
 
 TAILQ_HEAD(ixgbe_ntuple_filter_list, ixgbe_ntuple_filter_ele);
 TAILQ_HEAD(ixgbe_fdir_rule_filter_list, ixgbe_fdir_rule_ele);
-TAILQ_HEAD(ixgbe_l2_tunnel_filter_list, ixgbe_eth_l2_tunnel_conf_ele);
 TAILQ_HEAD(ixgbe_rss_filter_list, ixgbe_rss_conf_ele);
 TAILQ_HEAD(ixgbe_flow_mem_list, ixgbe_flow_mem);
 
 static struct ixgbe_ntuple_filter_list filter_ntuple_list;
 static struct ixgbe_fdir_rule_filter_list filter_fdir_list;
-static struct ixgbe_l2_tunnel_filter_list filter_l2_tunnel_list;
 static struct ixgbe_rss_filter_list filter_rss_list;
 static struct ixgbe_flow_mem_list ixgbe_flow_list;
 
@@ -94,6 +87,7 @@ const struct ci_flow_engine_list ixgbe_flow_engine_list = {
 	{
 		&ixgbe_ethertype_flow_engine,
 		&ixgbe_syn_flow_engine,
+		&ixgbe_l2_tunnel_flow_engine,
 	},
 };
 
@@ -677,160 +671,6 @@ ixgbe_parse_ntuple_filter(struct rte_eth_dev *dev,
 	return 0;
 }
 
-/**
- * Parse the rule to see if it is a L2 tunnel rule.
- * And get the L2 tunnel filter info BTW.
- * Only support E-tag now.
- * pattern:
- * The first not void item can be E_TAG.
- * The next not void item must be END.
- * action:
- * The first not void action should be VF or PF.
- * The next not void action should be END.
- * pattern example:
- * ITEM		Spec			Mask
- * E_TAG	grp		0x1	0x3
-		e_cid_base	0x309	0xFFF
- * END
- * other members in mask and spec should set to 0x00.
- * item->last should be NULL.
- */
-static int
-cons_parse_l2_tn_filter(struct rte_eth_dev *dev,
-			const struct rte_flow_item pattern[],
-			const struct rte_flow_action *action,
-			struct ixgbe_l2_tunnel_conf *filter,
-			struct rte_flow_error *error)
-{
-	const struct rte_flow_item *item;
-	const struct rte_flow_item_e_tag *e_tag_spec;
-	const struct rte_flow_item_e_tag *e_tag_mask;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
-
-	/* The first not void item should be e-tag. */
-	item = next_no_void_pattern(pattern, NULL);
-	if (item->type != RTE_FLOW_ITEM_TYPE_E_TAG) {
-		memset(filter, 0, sizeof(struct ixgbe_l2_tunnel_conf));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by L2 tunnel filter");
-		return -rte_errno;
-	}
-
-	if (!item->spec || !item->mask) {
-		memset(filter, 0, sizeof(struct ixgbe_l2_tunnel_conf));
-		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by L2 tunnel filter");
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
-	e_tag_spec = item->spec;
-	e_tag_mask = item->mask;
-
-	/* Only care about GRP and E cid base. */
-	if (e_tag_mask->epcp_edei_in_ecid_b ||
-	    e_tag_mask->in_ecid_e ||
-	    e_tag_mask->ecid_e ||
-	    e_tag_mask->rsvd_grp_ecid_b != rte_cpu_to_be_16(0x3FFF)) {
-		memset(filter, 0, sizeof(struct ixgbe_l2_tunnel_conf));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by L2 tunnel filter");
-		return -rte_errno;
-	}
-
-	filter->l2_tunnel_type = RTE_ETH_L2_TUNNEL_TYPE_E_TAG;
-	/**
-	 * grp and e_cid_base are bit fields and only use 14 bits.
-	 * e-tag id is taken as little endian by HW.
-	 */
-	filter->tunnel_id = rte_be_to_cpu_16(e_tag_spec->rsvd_grp_ecid_b);
-
-	/* check if the next not void item is END */
-	item = next_no_void_pattern(pattern, item);
-	if (item->type != RTE_FLOW_ITEM_TYPE_END) {
-		memset(filter, 0, sizeof(struct ixgbe_l2_tunnel_conf));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by L2 tunnel filter");
-		return -rte_errno;
-	}
-
-	if (action->type == RTE_FLOW_ACTION_TYPE_VF) {
-		const struct rte_flow_action_vf *act_vf = action->conf;
-		filter->pool = act_vf->id;
-	} else {
-		filter->pool = pci_dev->max_vfs;
-	}
-
-	return 0;
-}
-
-static int
-ixgbe_parse_l2_tn_filter(struct rte_eth_dev *dev,
-			const struct rte_flow_attr *attr,
-			const struct rte_flow_item pattern[],
-			const struct rte_flow_action actions[],
-			struct ixgbe_l2_tunnel_conf *l2_tn_filter,
-			struct rte_flow_error *error)
-{
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct ci_flow_actions parsed_actions;
-	struct ci_flow_actions_check_param ap_param = {
-		.allowed_types = (const enum rte_flow_action_type[]){
-			/* only vf/pf is allowed here */
-			RTE_FLOW_ACTION_TYPE_VF,
-			RTE_FLOW_ACTION_TYPE_PF,
-			RTE_FLOW_ACTION_TYPE_END
-		},
-		.driver_ctx = dev,
-		.check = ixgbe_flow_actions_check,
-		.max_actions = 1,
-	};
-	int ret = 0;
-	const struct rte_flow_action *action;
-
-	if (hw->mac.type != ixgbe_mac_X550 &&
-		hw->mac.type != ixgbe_mac_X550EM_x &&
-		hw->mac.type != ixgbe_mac_X550EM_a &&
-		hw->mac.type != ixgbe_mac_E610) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			NULL, "Not supported by L2 tunnel filter");
-		return -rte_errno;
-	}
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
-	/* only one action is supported */
-	if (parsed_actions.count > 1) {
-		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
-					  parsed_actions.actions[1],
-					  "Only one action can be specified at a time");
-	}
-	action = parsed_actions.actions[0];
-
-	ret = cons_parse_l2_tn_filter(dev, pattern, action, l2_tn_filter, error);
-
-	return ret;
-}
-
 /* search next no void pattern and skip fuzzy */
 static inline
 const struct rte_flow_item *next_no_fuzzy_pattern(
@@ -2340,7 +2180,6 @@ ixgbe_filterlist_init(void)
 {
 	TAILQ_INIT(&filter_ntuple_list);
 	TAILQ_INIT(&filter_fdir_list);
-	TAILQ_INIT(&filter_l2_tunnel_list);
 	TAILQ_INIT(&filter_rss_list);
 	TAILQ_INIT(&ixgbe_flow_list);
 }
@@ -2349,7 +2188,6 @@ void
 ixgbe_filterlist_flush(void)
 {
 	struct ixgbe_ntuple_filter_ele *ntuple_filter_ptr;
-	struct ixgbe_eth_l2_tunnel_conf_ele *l2_tn_filter_ptr;
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
@@ -2361,13 +2199,6 @@ ixgbe_filterlist_flush(void)
 		rte_free(ntuple_filter_ptr);
 	}
 
-	while ((l2_tn_filter_ptr = TAILQ_FIRST(&filter_l2_tunnel_list))) {
-		TAILQ_REMOVE(&filter_l2_tunnel_list,
-				 l2_tn_filter_ptr,
-				 entries);
-		rte_free(l2_tn_filter_ptr);
-	}
-
 	while ((fdir_rule_ptr = TAILQ_FIRST(&filter_fdir_list))) {
 		TAILQ_REMOVE(&filter_fdir_list,
 				 fdir_rule_ptr,
@@ -2408,13 +2239,11 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	int ret;
 	struct rte_eth_ntuple_filter ntuple_filter;
 	struct ixgbe_fdir_rule fdir_rule;
-	struct ixgbe_l2_tunnel_conf l2_tn_filter;
 	struct ixgbe_hw_fdir_info *fdir_info =
 		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
 	struct ixgbe_rte_flow_rss_conf rss_conf;
 	struct rte_flow *flow = NULL;
 	struct ixgbe_ntuple_filter_ele *ntuple_filter_ptr;
-	struct ixgbe_eth_l2_tunnel_conf_ele *l2_tn_filter_ptr;
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
 	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
@@ -2554,29 +2383,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 		goto out;
 	}
 
-	memset(&l2_tn_filter, 0, sizeof(struct ixgbe_l2_tunnel_conf));
-	ret = ixgbe_parse_l2_tn_filter(dev, attr, pattern,
-					actions, &l2_tn_filter, error);
-	if (!ret) {
-		ret = ixgbe_dev_l2_tunnel_filter_add(dev, &l2_tn_filter, FALSE);
-		if (!ret) {
-			l2_tn_filter_ptr = rte_zmalloc("ixgbe_l2_tn_filter",
-				sizeof(struct ixgbe_eth_l2_tunnel_conf_ele), 0);
-			if (!l2_tn_filter_ptr) {
-				PMD_DRV_LOG(ERR, "failed to allocate memory");
-				goto out;
-			}
-			rte_memcpy(&l2_tn_filter_ptr->filter_info,
-				&l2_tn_filter,
-				sizeof(struct ixgbe_l2_tunnel_conf));
-			TAILQ_INSERT_TAIL(&filter_l2_tunnel_list,
-				l2_tn_filter_ptr, entries);
-			flow->rule = l2_tn_filter_ptr;
-			flow->filter_type = RTE_ETH_FILTER_L2_TUNNEL;
-			return flow;
-		}
-	}
-
 	memset(&rss_conf, 0, sizeof(struct ixgbe_rte_flow_rss_conf));
 	ret = ixgbe_parse_rss_filter(dev, attr,
 					actions, &rss_conf, error);
@@ -2624,7 +2430,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 {
 	struct ixgbe_adapter *ad = dev->data->dev_private;
 	struct rte_eth_ntuple_filter ntuple_filter;
-	struct ixgbe_l2_tunnel_conf l2_tn_filter;
 	struct ixgbe_fdir_rule fdir_rule;
 	struct ixgbe_rte_flow_rss_conf rss_conf;
 	int ret;
@@ -2656,12 +2461,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 	if (!ret)
 		return 0;
 
-	memset(&l2_tn_filter, 0, sizeof(struct ixgbe_l2_tunnel_conf));
-	ret = ixgbe_parse_l2_tn_filter(dev, attr, pattern,
-				actions, &l2_tn_filter, error);
-	if (!ret)
-		return 0;
-
 	memset(&rss_conf, 0, sizeof(struct ixgbe_rte_flow_rss_conf));
 	ret = ixgbe_parse_rss_filter(dev, attr,
 					actions, &rss_conf, error);
@@ -2681,9 +2480,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	enum rte_filter_type filter_type = pmd_flow->filter_type;
 	struct rte_eth_ntuple_filter ntuple_filter;
 	struct ixgbe_fdir_rule fdir_rule;
-	struct ixgbe_l2_tunnel_conf l2_tn_filter;
 	struct ixgbe_ntuple_filter_ele *ntuple_filter_ptr;
-	struct ixgbe_eth_l2_tunnel_conf_ele *l2_tn_filter_ptr;
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
 	struct ixgbe_hw_fdir_info *fdir_info =
@@ -2733,18 +2530,6 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 				fdir_info->mask_added = false;
 		}
 		break;
-	case RTE_ETH_FILTER_L2_TUNNEL:
-		l2_tn_filter_ptr = (struct ixgbe_eth_l2_tunnel_conf_ele *)
-				pmd_flow->rule;
-		rte_memcpy(&l2_tn_filter, &l2_tn_filter_ptr->filter_info,
-			sizeof(struct ixgbe_l2_tunnel_conf));
-		ret = ixgbe_dev_l2_tunnel_filter_del(dev, &l2_tn_filter);
-		if (!ret) {
-			TAILQ_REMOVE(&filter_l2_tunnel_list,
-				l2_tn_filter_ptr, entries);
-			rte_free(l2_tn_filter_ptr);
-		}
-		break;
 	case RTE_ETH_FILTER_HASH:
 		rss_filter_ptr = (struct ixgbe_rss_conf_ele *)
 				pmd_flow->rule;
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.h b/drivers/net/intel/ixgbe/ixgbe_flow.h
index 3a5d0299b3..4dabaca0ed 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.h
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.h
@@ -11,6 +11,7 @@
 enum ixgbe_flow_engine_type {
 	IXGBE_FLOW_ENGINE_TYPE_ETHERTYPE = 0,
 	IXGBE_FLOW_ENGINE_TYPE_SYN,
+	IXGBE_FLOW_ENGINE_TYPE_L2_TUNNEL,
 };
 
 int
@@ -22,5 +23,6 @@ extern const struct ci_flow_engine_list ixgbe_flow_engine_list;
 
 extern const struct ci_flow_engine ixgbe_ethertype_flow_engine;
 extern const struct ci_flow_engine ixgbe_syn_flow_engine;
+extern const struct ci_flow_engine ixgbe_l2_tunnel_flow_engine;
 
 #endif /*  _IXGBE_FLOW_H_ */
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow_l2tun.c b/drivers/net/intel/ixgbe/ixgbe_flow_l2tun.c
new file mode 100644
index 0000000000..bde7af1b78
--- /dev/null
+++ b/drivers/net/intel/ixgbe/ixgbe_flow_l2tun.c
@@ -0,0 +1,228 @@
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
+struct ixgbe_l2_tunnel_flow {
+	struct rte_flow flow;
+	struct ixgbe_l2_tunnel_conf l2_tunnel;
+};
+
+struct ixgbe_l2_tunnel_ctx {
+	struct ci_flow_engine_ctx base;
+	struct ixgbe_l2_tunnel_conf l2_tunnel;
+};
+
+/**
+ * L2 tunnel filter graph implementation (E-TAG)
+ * Pattern: START -> E_TAG -> END
+ */
+
+enum ixgbe_l2_tunnel_node_id {
+	IXGBE_L2_TUNNEL_NODE_START = RTE_FLOW_NODE_FIRST,
+	IXGBE_L2_TUNNEL_NODE_E_TAG,
+	IXGBE_L2_TUNNEL_NODE_END,
+	IXGBE_L2_TUNNEL_NODE_MAX,
+};
+
+static int
+ixgbe_validate_l2_tunnel_e_tag(const void *ctx __rte_unused,
+				const struct rte_flow_item *item,
+				struct rte_flow_error *error)
+{
+	const struct rte_flow_item_e_tag *e_tag_mask;
+
+	e_tag_mask = item->mask;
+
+	/* Only GRP and E-CID base supported (rsvd_grp_ecid_b field) */
+	if (e_tag_mask->epcp_edei_in_ecid_b ||
+	    e_tag_mask->in_ecid_e ||
+	    e_tag_mask->ecid_e ||
+	    rte_be_to_cpu_16(e_tag_mask->rsvd_grp_ecid_b) != 0x3FFF) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Only GRP and E-CID base (14 bits) supported");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_l2_tunnel_e_tag(void *ctx,
+			       const struct rte_flow_item *item,
+			       struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_l2_tunnel_ctx *l2tun_ctx = ctx;
+	const struct rte_flow_item_e_tag *e_tag_spec = item->spec;
+
+	l2tun_ctx->l2_tunnel.l2_tunnel_type = RTE_ETH_L2_TUNNEL_TYPE_E_TAG;
+	l2tun_ctx->l2_tunnel.tunnel_id = rte_be_to_cpu_16(e_tag_spec->rsvd_grp_ecid_b);
+
+	return 0;
+}
+
+const struct rte_flow_graph ixgbe_l2_tunnel_graph = {
+	.nodes = (struct rte_flow_graph_node[]) {
+		[IXGBE_L2_TUNNEL_NODE_START] = {
+			.name = "START",
+		},
+		[IXGBE_L2_TUNNEL_NODE_E_TAG] = {
+			.name = "E_TAG",
+			.type = RTE_FLOW_ITEM_TYPE_E_TAG,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = ixgbe_validate_l2_tunnel_e_tag,
+			.process = ixgbe_process_l2_tunnel_e_tag,
+		},
+		[IXGBE_L2_TUNNEL_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	},
+	.edges = (struct rte_flow_graph_edge[]) {
+		[IXGBE_L2_TUNNEL_NODE_START] = {
+			.next = (const size_t[]) {
+				IXGBE_L2_TUNNEL_NODE_E_TAG,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_L2_TUNNEL_NODE_E_TAG] = {
+			.next = (const size_t[]) {
+				IXGBE_L2_TUNNEL_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+static int
+ixgbe_flow_l2_tunnel_ctx_parse(const struct rte_flow_action *actions,
+		const struct rte_flow_attr *attr,
+		struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_l2_tunnel_ctx *l2tun_ctx = (struct ixgbe_l2_tunnel_ctx *)ctx;
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(ctx->dev);
+	struct ci_flow_actions parsed_actions;
+	struct ci_flow_actions_check_param ap_param = {
+		.allowed_types = (const enum rte_flow_action_type[]){
+			/* only vf/pf is allowed here */
+			RTE_FLOW_ACTION_TYPE_VF,
+			RTE_FLOW_ACTION_TYPE_PF,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.driver_ctx = ctx->dev,
+		.check = ixgbe_flow_actions_check,
+		.max_actions = 1,
+	};
+	const struct rte_flow_action *action;
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
+	action = parsed_actions.actions[0];
+
+	if (action->type == RTE_FLOW_ACTION_TYPE_VF) {
+		const struct rte_flow_action_vf *vf = action->conf;
+		l2tun_ctx->l2_tunnel.pool = vf->id;
+	} else {
+		l2tun_ctx->l2_tunnel.pool = pci_dev->max_vfs;
+	}
+
+	return ret;
+}
+
+static int
+ixgbe_flow_l2_tunnel_ctx_to_flow(const struct ci_flow_engine_ctx *ctx,
+		struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct ixgbe_l2_tunnel_ctx *l2tun_ctx = (const struct ixgbe_l2_tunnel_ctx *)ctx;
+	struct ixgbe_l2_tunnel_flow *l2tun_flow = (struct ixgbe_l2_tunnel_flow *)flow;
+
+	l2tun_flow->l2_tunnel = l2tun_ctx->l2_tunnel;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_l2_tunnel_flow_install(struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_l2_tunnel_flow *l2tun_flow = (struct ixgbe_l2_tunnel_flow *)flow;
+	struct rte_eth_dev *dev = flow->dev;
+	int ret;
+
+	/* yes, false */
+	ret = ixgbe_dev_l2_tunnel_filter_add(dev, &l2tun_flow->l2_tunnel, FALSE);
+	if (ret) {
+		return rte_flow_error_set(error, ret,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Failed to add L2 tunnel filter");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_flow_l2_tunnel_flow_uninstall(struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_l2_tunnel_flow *l2tun_flow = (struct ixgbe_l2_tunnel_flow *)flow;
+	struct rte_eth_dev *dev = flow->dev;
+	int ret;
+
+	ret = ixgbe_dev_l2_tunnel_filter_del(dev, &l2tun_flow->l2_tunnel);
+	if (ret) {
+		return rte_flow_error_set(error, ret,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Failed to remove L2 tunnel filter");
+	}
+
+	return 0;
+}
+
+static bool
+ixgbe_flow_l2_tunnel_is_available(const struct ci_flow_engine *engine __rte_unused,
+		const struct rte_eth_dev *dev)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+
+	return hw->mac.type == ixgbe_mac_X550 ||
+			hw->mac.type == ixgbe_mac_X550EM_x ||
+			hw->mac.type == ixgbe_mac_X550EM_a ||
+			hw->mac.type == ixgbe_mac_E610;
+}
+
+const struct ci_flow_engine_ops ixgbe_l2_tunnel_ops = {
+	.is_available = ixgbe_flow_l2_tunnel_is_available,
+	.ctx_parse = ixgbe_flow_l2_tunnel_ctx_parse,
+	.ctx_to_flow = ixgbe_flow_l2_tunnel_ctx_to_flow,
+	.flow_install = ixgbe_flow_l2_tunnel_flow_install,
+	.flow_uninstall = ixgbe_flow_l2_tunnel_flow_uninstall,
+};
+
+const struct ci_flow_engine ixgbe_l2_tunnel_flow_engine = {
+	.name = "ixgbe_l2_tunnel",
+	.ctx_size = sizeof(struct ixgbe_l2_tunnel_ctx),
+	.flow_size = sizeof(struct ixgbe_l2_tunnel_flow),
+	.type = IXGBE_FLOW_ENGINE_TYPE_L2_TUNNEL,
+	.ops = &ixgbe_l2_tunnel_ops,
+	.graph = &ixgbe_l2_tunnel_graph,
+};
diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
index bd9be0add3..0aaeb82a36 100644
--- a/drivers/net/intel/ixgbe/meson.build
+++ b/drivers/net/intel/ixgbe/meson.build
@@ -13,6 +13,7 @@ sources += files(
         'ixgbe_flow.c',
         'ixgbe_flow_ethertype.c',
         'ixgbe_flow_syn.c',
+        'ixgbe_flow_l2tun.c',
         'ixgbe_ipsec.c',
         'ixgbe_pf.c',
         'ixgbe_rxtx.c',
-- 
2.47.3

