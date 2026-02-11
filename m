Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED82E9E310
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 14:21:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A9C840A6E;
	Wed, 11 Feb 2026 15:21:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 73B2B40671
 for <dev@dpdk.org>; Wed, 11 Feb 2026 15:21:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770819663; x=1802355663;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=7YPqwrrJrpM7USmnwUEaJ7C0Ndj58qlVkoQ5uCe0mkU=;
 b=VRtAeL7tf865xJRsKmD90sIW5ZCTbyWC0R2nWvX+9UfamneBGJr7unO9
 4ZR/FUMEEOyylaubNjXv/RoApkWC930gROeEblpBKuMLjq+fThDPL9Ci/
 KwzJL+KiZRoVghmwiYNLlZ7HAlfT1u4+5Xs7NUw23F5zqX0/M4sHqtls2
 wgrvitvZXDe4D10orn/lwk9abvrBZhkuDVRbjIoLSnNtWUdiWEG727+sv
 PnnhlMKYdc8sEhCNOA2vCq3kqs0ElYuwQxe6IKnopSgV68OqH38cwnFaS
 uzHVVuKPP18uHdx4Vlfos8rUZ6nVS0/3k1tWDKhdazLWWSx8f39uDzpIW Q==;
X-CSE-ConnectionGUID: /7ZwoGvERZC/+frXSzyXRw==
X-CSE-MsgGUID: qkbInpUFSHiPUNOx30cwsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71866734"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71866734"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 06:21:03 -0800
X-CSE-ConnectionGUID: 4N5yfIP2Tmil0Fl1KeWtPA==
X-CSE-MsgGUID: GbhIr4jfQCa0QfQmnkkJpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211569125"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 11 Feb 2026 06:21:03 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 05/25] net/ixgbe: use common checks in L2 tunnel filter
Date: Wed, 11 Feb 2026 14:20:22 +0000
Message-ID: <d2c61c12fb6c505f55cc83330fa640b30823031b.1770819434.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770819433.git.anatoly.burakov@intel.com>
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

Use the common attr and action parsing infrastructure in L2 tunnel filter.
Some checks have become more stringent as a result, in particular, group
attribute is now explicitly rejected instead of being ignored.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 148 +++++++++------------------
 1 file changed, 47 insertions(+), 101 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 0aa96f04bb..00104636a7 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -145,6 +145,7 @@ ixgbe_flow_actions_check(const struct ci_flow_actions *actions,
 {
 	const struct rte_flow_action *action;
 	struct rte_eth_dev *dev = (struct rte_eth_dev *)param->driver_ctx;
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	size_t idx;
 
 	for (idx = 0; idx < actions->count; idx++) {
@@ -162,6 +163,17 @@ ixgbe_flow_actions_check(const struct ci_flow_actions *actions,
 			}
 			break;
 		}
+		case RTE_FLOW_ACTION_TYPE_VF:
+		{
+			const struct rte_flow_action_vf *vf = action->conf;
+			if (vf->id >= pci_dev->max_vfs) {
+				return rte_flow_error_set(error, EINVAL,
+						RTE_FLOW_ERROR_TYPE_ACTION,
+						action,
+						"VF id out of range");
+			}
+			break;
+		}
 		default:
 			/* no specific validation */
 			break;
@@ -869,12 +881,6 @@ ixgbe_parse_ethertype_filter(struct rte_eth_dev *dev, const struct rte_flow_attr
 	if (ret)
 		return ret;
 
-	/* only one action is supported */
-	if (parsed_actions.count > 1) {
-		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
-					  parsed_actions.actions[1],
-					  "Only one action can be specified at a time");
-	}
 	action = parsed_actions.actions[0];
 
 	ret = cons_parse_ethertype_filter(pattern, action, filter, error);
@@ -1120,40 +1126,16 @@ ixgbe_parse_syn_filter(struct rte_eth_dev *dev, const struct rte_flow_attr *attr
  */
 static int
 cons_parse_l2_tn_filter(struct rte_eth_dev *dev,
-			const struct rte_flow_attr *attr,
 			const struct rte_flow_item pattern[],
-			const struct rte_flow_action actions[],
+			const struct rte_flow_action *action,
 			struct ixgbe_l2_tunnel_conf *filter,
 			struct rte_flow_error *error)
 {
 	const struct rte_flow_item *item;
 	const struct rte_flow_item_e_tag *e_tag_spec;
 	const struct rte_flow_item_e_tag *e_tag_mask;
-	const struct rte_flow_action *act;
-	const struct rte_flow_action_vf *act_vf;
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 
-	if (!pattern) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM_NUM,
-			NULL, "NULL pattern.");
-		return -rte_errno;
-	}
-
-	if (!actions) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ACTION_NUM,
-				   NULL, "NULL action.");
-		return -rte_errno;
-	}
-
-	if (!attr) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ATTR,
-				   NULL, "NULL attribute.");
-		return -rte_errno;
-	}
-
 	/* The first not void item should be e-tag. */
 	item = next_no_void_pattern(pattern, NULL);
 	if (item->type != RTE_FLOW_ITEM_TYPE_E_TAG) {
@@ -1211,71 +1193,13 @@ cons_parse_l2_tn_filter(struct rte_eth_dev *dev,
 		return -rte_errno;
 	}
 
-	/* parse attr */
-	/* must be input direction */
-	if (!attr->ingress) {
-		memset(filter, 0, sizeof(struct ixgbe_l2_tunnel_conf));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ATTR_INGRESS,
-			attr, "Only support ingress.");
-		return -rte_errno;
-	}
-
-	/* not supported */
-	if (attr->egress) {
-		memset(filter, 0, sizeof(struct ixgbe_l2_tunnel_conf));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ATTR_EGRESS,
-			attr, "Not support egress.");
-		return -rte_errno;
-	}
-
-	/* not supported */
-	if (attr->transfer) {
-		memset(filter, 0, sizeof(struct ixgbe_l2_tunnel_conf));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ATTR_TRANSFER,
-			attr, "No support for transfer.");
-		return -rte_errno;
-	}
-
-	/* not supported */
-	if (attr->priority) {
-		memset(filter, 0, sizeof(struct ixgbe_l2_tunnel_conf));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY,
-			attr, "Not support priority.");
-		return -rte_errno;
-	}
-
-	/* check if the first not void action is VF or PF. */
-	act = next_no_void_action(actions, NULL);
-	if (act->type != RTE_FLOW_ACTION_TYPE_VF &&
-			act->type != RTE_FLOW_ACTION_TYPE_PF) {
-		memset(filter, 0, sizeof(struct ixgbe_l2_tunnel_conf));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ACTION,
-			act, "Not supported action.");
-		return -rte_errno;
-	}
-
-	if (act->type == RTE_FLOW_ACTION_TYPE_VF) {
-		act_vf = (const struct rte_flow_action_vf *)act->conf;
+	if (action->type == RTE_FLOW_ACTION_TYPE_VF) {
+		const struct rte_flow_action_vf *act_vf = action->conf;
 		filter->pool = act_vf->id;
 	} else {
 		filter->pool = pci_dev->max_vfs;
 	}
 
-	/* check if the next not void item is END */
-	act = next_no_void_action(actions, act);
-	if (act->type != RTE_FLOW_ACTION_TYPE_END) {
-		memset(filter, 0, sizeof(struct ixgbe_l2_tunnel_conf));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ACTION,
-			act, "Not supported action.");
-		return -rte_errno;
-	}
-
 	return 0;
 }
 
@@ -1287,29 +1211,51 @@ ixgbe_parse_l2_tn_filter(struct rte_eth_dev *dev,
 			struct ixgbe_l2_tunnel_conf *l2_tn_filter,
 			struct rte_flow_error *error)
 {
-	int ret = 0;
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
-	uint16_t vf_num;
-
-	ret = cons_parse_l2_tn_filter(dev, attr, pattern,
-				actions, l2_tn_filter, error);
+	struct ci_flow_actions parsed_actions;
+	struct ci_flow_actions_check_param ap_param = {
+		.allowed_types = (const enum rte_flow_action_type[]){
+			/* only vf/pf is allowed here */
+			RTE_FLOW_ACTION_TYPE_VF,
+			RTE_FLOW_ACTION_TYPE_PF,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.driver_ctx = dev,
+		.check = ixgbe_flow_actions_check,
+		.max_actions = 1,
+	};
+	int ret = 0;
+	const struct rte_flow_action *action;
 
 	if (hw->mac.type != ixgbe_mac_X550 &&
 		hw->mac.type != ixgbe_mac_X550EM_x &&
 		hw->mac.type != ixgbe_mac_X550EM_a &&
 		hw->mac.type != ixgbe_mac_E610) {
-		memset(l2_tn_filter, 0, sizeof(struct ixgbe_l2_tunnel_conf));
 		rte_flow_error_set(error, EINVAL,
 			RTE_FLOW_ERROR_TYPE_ITEM,
 			NULL, "Not supported by L2 tunnel filter");
 		return -rte_errno;
 	}
 
-	vf_num = pci_dev->max_vfs;
+	/* validate attributes */
+	ret = ci_flow_check_attr(attr, NULL, error);
+	if (ret)
+		return ret;
 
-	if (l2_tn_filter->pool > vf_num)
-		return -rte_errno;
+	/* parse requested actions */
+	ret = ci_flow_check_actions(actions, &ap_param, &parsed_actions, error);
+	if (ret)
+		return ret;
+
+	/* only one action is supported */
+	if (parsed_actions.count > 1) {
+		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+					  parsed_actions.actions[1],
+					  "Only one action can be specified at a time");
+	}
+	action = parsed_actions.actions[0];
+
+	ret = cons_parse_l2_tn_filter(dev, pattern, action, l2_tn_filter, error);
 
 	return ret;
 }
-- 
2.47.3

