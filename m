Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586FEE9E310
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 14:22:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73F3D40DCB;
	Wed, 11 Feb 2026 15:21:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 7F97540A77
 for <dev@dpdk.org>; Wed, 11 Feb 2026 15:21:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770819670; x=1802355670;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=HFfdZZPZRG9Cby6/xSS+BcUl1EECP34Z3h+KIY6ZNrI=;
 b=ODuqUfgFLhdc+yakTN73TspXnBagIHdiEDW6tuLVRUKHEUL+LY6qk5VG
 oMkdTsvnlwojqCL1+5sjIFbHRkCg6/e16Mth4bmEXzgWwhsxW+njYOJI8
 ErAOirSbAZl5CaK8QGk0ppWC7KrSFbuoZyRDnRu3lbX4326nPFi683NZR
 9ICMYpXSZEpx5/jY0k5h14VGpX1aE+Yy7hiVcAnIl46AMmKAa74uChDEC
 7CVXA/1jxP62Khc3Ya/0DiT+TjUrRUKzdT+hqjnmbEUnWArWgUihTgB5y
 6Pt1nuKCJzEzRp3cXbiULTxruILihkxPLd6ZOMTb7xCNU5IkK2CQyLf1G w==;
X-CSE-ConnectionGUID: 930uPXRCRTCk2QgdV1WuYQ==
X-CSE-MsgGUID: 0cAdVWliReW0HllWNO0eew==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71866749"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71866749"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 06:21:10 -0800
X-CSE-ConnectionGUID: 2uHj8vDnRIOTEes8+xaxRQ==
X-CSE-MsgGUID: bf4tLeWUSWK7/xGozTYd0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211569163"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 11 Feb 2026 06:21:10 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 11/25] net/i40e: refactor RSS flow parameter checks
Date: Wed, 11 Feb 2026 14:20:28 +0000
Message-ID: <78a48a85c23e45d01fbf99e618aaa1d0c4d62edf.1770819434.git.anatoly.burakov@intel.com>
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

Currently, the hash parser parameter checks are somewhat confusing as they
have multiple mutually exclusive code paths and requirements, and it's
difficult to reason about them because RSS flow parsing is interspersed
with validation checks.

To address that, refactor hash engine error checking to perform almost all
validation at the beginning, with only happy paths being implemented in
actual parsing functions.

Some parameter combinations that were previously ignored (and perhaps
produced a warning) are now explicitly rejected:

- if no pattern is specified, RSS types are rejected
- for queue lists and regions, RSS key is rejected

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_flow.c |  13 +-
 drivers/net/intel/i40e/i40e_hash.c | 427 +++++++++++++++++------------
 drivers/net/intel/i40e/i40e_hash.h |   2 +-
 3 files changed, 264 insertions(+), 178 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 05abaf8ce3..ad80883f13 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -3701,6 +3701,7 @@ i40e_flow_check(struct rte_eth_dev *dev,
 	if (ret) {
 		return ret;
 	}
+	/* action and pattern validation will happen in each respective engine */
 
 	if (!pattern) {
 		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM_NUM,
@@ -3715,13 +3716,11 @@ i40e_flow_check(struct rte_eth_dev *dev,
 		return -rte_errno;
 	}
 
-	/* Get the non-void item of action */
-	while ((actions + i)->type == RTE_FLOW_ACTION_TYPE_VOID)
-		i++;
-
-	if ((actions + i)->type == RTE_FLOW_ACTION_TYPE_RSS) {
-		filter_ctx->type = RTE_ETH_FILTER_HASH;
-		return i40e_hash_parse(dev, pattern, actions + i, &filter_ctx->rss_conf, error);
+	/* try parsing as RSS */
+	filter_ctx->type = RTE_ETH_FILTER_HASH;
+	ret = i40e_hash_parse(dev, pattern, actions, &filter_ctx->rss_conf, error);
+	if (!ret) {
+		return ret;
 	}
 
 	i = 0;
diff --git a/drivers/net/intel/i40e/i40e_hash.c b/drivers/net/intel/i40e/i40e_hash.c
index cbb377295d..c6b48a9fc1 100644
--- a/drivers/net/intel/i40e/i40e_hash.c
+++ b/drivers/net/intel/i40e/i40e_hash.c
@@ -16,6 +16,8 @@
 #include "i40e_ethdev.h"
 #include "i40e_hash.h"
 
+#include "../common/flow_check.h"
+
 #ifndef BIT
 #define BIT(n)				(1UL << (n))
 #endif
@@ -925,12 +927,7 @@ i40e_hash_parse_key(const struct rte_flow_action_rss *rss_act,
 {
 	const uint8_t *key = rss_act->key;
 
-	if (!key || rss_act->key_len != sizeof(rss_conf->key)) {
-		if (rss_act->key_len != sizeof(rss_conf->key))
-			PMD_DRV_LOG(WARNING,
-				    "RSS key length invalid, must be %u bytes, now set key to default",
-				    (uint32_t)sizeof(rss_conf->key));
-
+	if (key == NULL) {
 		memcpy(rss_conf->key, i40e_rss_key_default, sizeof(rss_conf->key));
 	} else {
 		memcpy(rss_conf->key, key, sizeof(rss_conf->key));
@@ -941,45 +938,29 @@ i40e_hash_parse_key(const struct rte_flow_action_rss *rss_act,
 }
 
 static int
-i40e_hash_parse_queues(const struct rte_eth_dev *dev,
-		       const struct rte_flow_action_rss *rss_act,
-		       struct i40e_rte_flow_rss_conf *rss_conf,
-		       struct rte_flow_error *error)
+i40e_hash_parse_pattern_act(const struct rte_eth_dev *dev,
+			    const struct rte_flow_item pattern[],
+			    const struct rte_flow_action_rss *rss_act,
+			    struct i40e_rte_flow_rss_conf *rss_conf,
+			    struct rte_flow_error *error)
 {
-	struct i40e_pf *pf;
-	struct i40e_hw *hw;
-	uint16_t i;
-	size_t max_queue;
-
-	hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	if (!rss_act->queue_num ||
-	    rss_act->queue_num > hw->func_caps.rss_table_size)
-		return rte_flow_error_set(error, EINVAL,
-					  RTE_FLOW_ERROR_TYPE_ACTION_CONF,
-					  NULL, "Invalid RSS queue number");
+	rss_conf->symmetric_enable = rss_act->func == RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ;
 
 	if (rss_act->key_len)
-		PMD_DRV_LOG(WARNING,
-			    "RSS key is ignored when queues specified");
+		i40e_hash_parse_key(rss_act, rss_conf);
 
-	pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-	if (pf->dev_data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG)
-		max_queue = i40e_pf_calc_configured_queues_num(pf);
-	else
-		max_queue = pf->dev_data->nb_rx_queues;
+	rss_conf->conf.func = rss_act->func;
+	rss_conf->conf.types = rss_act->types;
+	rss_conf->inset = i40e_hash_get_inset(rss_act->types, rss_conf->symmetric_enable);
 
-	max_queue = RTE_MIN(max_queue, I40E_MAX_Q_PER_TC);
-
-	for (i = 0; i < rss_act->queue_num; i++) {
-		if (rss_act->queue[i] >= max_queue)
-			break;
-	}
-
-	if (i < rss_act->queue_num)
-		return rte_flow_error_set(error, EINVAL,
-					  RTE_FLOW_ERROR_TYPE_ACTION_CONF,
-					  NULL, "Invalid RSS queues");
+	return i40e_hash_get_pattern_pctypes(dev, pattern, rss_act,
+					     rss_conf, error);
+}
 
+static int
+i40e_hash_parse_queues(const struct rte_flow_action_rss *rss_act,
+		       struct i40e_rte_flow_rss_conf *rss_conf)
+{
 	memcpy(rss_conf->queue, rss_act->queue,
 	       rss_act->queue_num * sizeof(rss_conf->queue[0]));
 	rss_conf->conf.queue = rss_conf->queue;
@@ -988,113 +969,38 @@ i40e_hash_parse_queues(const struct rte_eth_dev *dev,
 }
 
 static int
-i40e_hash_parse_queue_region(const struct rte_eth_dev *dev,
-			     const struct rte_flow_item pattern[],
+i40e_hash_parse_queue_region(const struct rte_flow_item pattern[],
 			     const struct rte_flow_action_rss *rss_act,
 			     struct i40e_rte_flow_rss_conf *rss_conf,
 			     struct rte_flow_error *error)
 {
-	struct i40e_pf *pf;
 	const struct rte_flow_item_vlan *vlan_spec, *vlan_mask;
-	uint64_t hash_queues;
-	uint32_t i;
-
-	if (pattern[1].type != RTE_FLOW_ITEM_TYPE_END)
-		return rte_flow_error_set(error, ENOTSUP,
-					  RTE_FLOW_ERROR_TYPE_ITEM_NUM,
-					  &pattern[1],
-					  "Pattern not supported.");
 
 	vlan_spec = pattern->spec;
 	vlan_mask = pattern->mask;
-	if (!vlan_spec || !vlan_mask ||
-	    (rte_be_to_cpu_16(vlan_mask->hdr.vlan_tci) >> 13) != 7)
-		return rte_flow_error_set(error, EINVAL,
-					  RTE_FLOW_ERROR_TYPE_ITEM, pattern,
-					  "Pattern error.");
 
-	if (!rss_act->queue)
+	/* VLAN must have spec and mask */
+	if (vlan_spec == NULL || vlan_mask == NULL) {
 		return rte_flow_error_set(error, EINVAL,
-					  RTE_FLOW_ERROR_TYPE_ACTION_CONF,
-					  NULL, "Queues not specified");
-
-	if (rss_act->key_len)
-		PMD_DRV_LOG(WARNING,
-			    "RSS key is ignored when configure queue region");
+				RTE_FLOW_ERROR_TYPE_ITEM, &pattern[0],
+				"VLAN pattern spec and mask required");
+	}
+	/* for mask, VLAN/TCI must be masked appropriately */
+	if ((rte_be_to_cpu_16(vlan_mask->hdr.vlan_tci) >> 13) != 0x7) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, &pattern[0],
+				"VLAN pattern mask invalid");
+	}
 
 	/* Use a 64 bit variable to represent all queues in a region. */
 	RTE_BUILD_BUG_ON(I40E_MAX_Q_PER_TC > 64);
 
-	if (!rss_act->queue_num ||
-	    !rte_is_power_of_2(rss_act->queue_num) ||
-	    rss_act->queue_num + rss_act->queue[0] > I40E_MAX_Q_PER_TC)
-		return rte_flow_error_set(error, EINVAL,
-					  RTE_FLOW_ERROR_TYPE_ACTION_CONF,
-					  NULL, "Queue number error");
-
-	for (i = 1; i < rss_act->queue_num; i++) {
-		if (rss_act->queue[i - 1] + 1 != rss_act->queue[i])
-			break;
-	}
-
-	if (i < rss_act->queue_num)
-		return rte_flow_error_set(error, EINVAL,
-					  RTE_FLOW_ERROR_TYPE_ACTION_CONF,
-					  NULL,
-					  "Queues must be incremented continuously");
-
-	/* Map all queues to bits of uint64_t */
-	hash_queues = (BIT_ULL(rss_act->queue[0] + rss_act->queue_num) - 1) &
-		      ~(BIT_ULL(rss_act->queue[0]) - 1);
-
-	pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-	if (hash_queues & ~pf->hash_enabled_queues)
-		return rte_flow_error_set(error, EINVAL,
-					  RTE_FLOW_ERROR_TYPE_ACTION_CONF,
-					  NULL, "Some queues are not in LUT");
-
 	rss_conf->region_queue_num = (uint8_t)rss_act->queue_num;
 	rss_conf->region_queue_start = rss_act->queue[0];
 	rss_conf->region_priority = rte_be_to_cpu_16(vlan_spec->hdr.vlan_tci) >> 13;
 	return 0;
 }
 
-static int
-i40e_hash_parse_global_conf(const struct rte_eth_dev *dev,
-			    const struct rte_flow_item pattern[],
-			    const struct rte_flow_action_rss *rss_act,
-			    struct i40e_rte_flow_rss_conf *rss_conf,
-			    struct rte_flow_error *error)
-{
-	if (rss_act->func == RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ)
-		return rte_flow_error_set(error, EINVAL,
-					  RTE_FLOW_ERROR_TYPE_ACTION_CONF,
-					  NULL,
-					  "Symmetric function should be set with pattern types");
-
-	rss_conf->conf.func = rss_act->func;
-
-	if (rss_act->types)
-		PMD_DRV_LOG(WARNING,
-			    "RSS types are ignored when no pattern specified");
-
-	if (pattern[0].type == RTE_FLOW_ITEM_TYPE_VLAN)
-		return i40e_hash_parse_queue_region(dev, pattern, rss_act,
-						    rss_conf, error);
-
-	if (rss_act->queue)
-		return i40e_hash_parse_queues(dev, rss_act, rss_conf, error);
-
-	if (rss_act->key_len) {
-		i40e_hash_parse_key(rss_act, rss_conf);
-		return 0;
-	}
-
-	if (rss_act->func == RTE_ETH_HASH_FUNCTION_DEFAULT)
-		PMD_DRV_LOG(WARNING, "Nothing change");
-	return 0;
-}
-
 static bool
 i40e_hash_validate_rss_types(uint64_t rss_types)
 {
@@ -1124,83 +1030,264 @@ i40e_hash_validate_rss_types(uint64_t rss_types)
 }
 
 static int
-i40e_hash_parse_pattern_act(const struct rte_eth_dev *dev,
-			    const struct rte_flow_item pattern[],
-			    const struct rte_flow_action_rss *rss_act,
-			    struct i40e_rte_flow_rss_conf *rss_conf,
-			    struct rte_flow_error *error)
+i40e_hash_validate_rss_pattern(const struct ci_flow_actions *actions,
+	const struct ci_flow_actions_check_param *param __rte_unused,
+	struct rte_flow_error *error)
 {
-	if (rss_act->queue)
+	const struct rte_flow_action_rss *rss_act = actions->actions[0]->conf;
+
+	/* queue list is not supported */
+	if (rss_act->queue_num == 0) {
 		return rte_flow_error_set(error, EINVAL,
-					  RTE_FLOW_ERROR_TYPE_ACTION_CONF,
-					  NULL,
-					  "RSS Queues not supported when pattern specified");
-	rss_conf->symmetric_enable = false;  /* by default, symmetric is disabled */
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+				"RSS queues not supported when pattern specified");
+	}
 
+	/* disallow unsupported hash functions */
 	switch (rss_act->func) {
 	case RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ:
-		rss_conf->symmetric_enable = true;
-		break;
 	case RTE_ETH_HASH_FUNCTION_DEFAULT:
 	case RTE_ETH_HASH_FUNCTION_TOEPLITZ:
 	case RTE_ETH_HASH_FUNCTION_SIMPLE_XOR:
 		break;
 	default:
 		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION_CONF,
-				NULL,
-				"RSS hash function not supported "
-				"when pattern specified");
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+				"RSS hash function not supported when pattern specified");
 	}
 
 	if (!i40e_hash_validate_rss_types(rss_act->types))
 		return rte_flow_error_set(error, EINVAL,
-					  RTE_FLOW_ERROR_TYPE_ACTION_CONF,
-					  NULL, "RSS types are invalid");
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF,
+				rss_act, "RSS types are invalid");
 
-	if (rss_act->key_len)
-		i40e_hash_parse_key(rss_act, rss_conf);
+	/* check RSS key length if it is specified */
+	if (rss_act->key_len != 0 && rss_act->key_len != I40E_RSS_KEY_LEN) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+				"RSS key length must be 52 bytes");
+	}
 
-	rss_conf->conf.func = rss_act->func;
-	rss_conf->conf.types = rss_act->types;
-	rss_conf->inset = i40e_hash_get_inset(rss_act->types, rss_conf->symmetric_enable);
+	return 0;
+}
 
-	return i40e_hash_get_pattern_pctypes(dev, pattern, rss_act,
-					     rss_conf, error);
+static int
+i40e_hash_validate_rss_common(const struct rte_flow_action_rss *rss_act,
+		struct rte_flow_error *error)
+{
+	/* for empty patterns, symmetric toeplitz is not supported */
+	if (rss_act->func == RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+				"Symmetric hash function not supported without specific patterns");
+	}
+
+	/* hash types are not supported for global RSS configuration */
+	if (rss_act->types != 0) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+				"RSS types not supported without a pattern");
+	}
+
+	/* check RSS key length if it is specified */
+	if (rss_act->key_len != 0 && rss_act->key_len != I40E_RSS_KEY_LEN) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+				"RSS key length must be 52 bytes");
+	}
+
+	return 0;
+}
+
+static int
+i40e_hash_validate_queue_region(const struct ci_flow_actions *actions,
+		const struct ci_flow_actions_check_param *param,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_action_rss *rss_act = actions->actions[0]->conf;
+	struct rte_eth_dev *dev = param->driver_ctx;
+	const struct i40e_pf *pf;
+	uint64_t hash_queues;
+
+	if (i40e_hash_validate_rss_common(rss_act, error))
+		return -rte_errno;
+
+	RTE_BUILD_BUG_ON(sizeof(hash_queues) != sizeof(pf->hash_enabled_queues));
+
+	/* having RSS key is not supported */
+	if (rss_act->key != NULL) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+				"RSS key not supported");
+	}
+
+	/* queue region must be specified */
+	if (rss_act->queue_num == 0) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+				"RSS queues missing");
+	}
+
+	/* queue region must be power of two */
+	if (!rte_is_power_of_2(rss_act->queue_num)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+				"RSS queue number must be power of two");
+	}
+
+	/* generic checks already filtered out discontiguous/non-unique RSS queues */
+
+	/* queues must not exceed maximum queues per traffic class */
+	if (rss_act->queue[rss_act->queue_num - 1] >= I40E_MAX_Q_PER_TC) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+				"Invalid RSS queue index");
+	}
+
+	/* queues must be in LUT */
+	pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	hash_queues = (BIT_ULL(rss_act->queue[0] + rss_act->queue_num) - 1) &
+			~(BIT_ULL(rss_act->queue[0]) - 1);
+
+	if (hash_queues & ~pf->hash_enabled_queues) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF,
+				rss_act, "Some queues are not in LUT");
+	}
+
+	return 0;
+}
+
+static int
+i40e_hash_validate_queue_list(const struct ci_flow_actions *actions,
+		const struct ci_flow_actions_check_param *param,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_action_rss *rss_act = actions->actions[0]->conf;
+	struct rte_eth_dev *dev = param->driver_ctx;
+	struct i40e_pf *pf;
+	struct i40e_hw *hw;
+	size_t max_queue;
+	bool has_queue, has_key;
+
+	if (i40e_hash_validate_rss_common(rss_act, error))
+		return -rte_errno;
+
+	has_queue = rss_act->queue != NULL;
+	has_key = rss_act->key != NULL;
+
+	/* if we have queues, we must not have key */
+	if (has_queue && has_key) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+				"RSS key for queue region is not supported");
+	}
+
+	/* if there are no queues, no further checks needed */
+	if (!has_queue)
+		return 0;
+
+	/* check queue number limits */
+	hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	if (rss_act->queue_num > hw->func_caps.rss_table_size) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF,
+				rss_act, "Too many RSS queues");
+	}
+
+	pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	if (pf->dev_data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG)
+		max_queue = i40e_pf_calc_configured_queues_num(pf);
+	else
+		max_queue = pf->dev_data->nb_rx_queues;
+
+	max_queue = RTE_MIN(max_queue, I40E_MAX_Q_PER_TC);
+
+	/* we know RSS queues are contiguous so we only need to check last queue */
+	if (rss_act->queue[rss_act->queue_num - 1] >= max_queue) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+				"Invalid RSS queue");
+	}
+
+	return 0;
 }
 
 int
-i40e_hash_parse(const struct rte_eth_dev *dev,
+i40e_hash_parse(struct rte_eth_dev *dev,
 		const struct rte_flow_item pattern[],
 		const struct rte_flow_action actions[],
 		struct i40e_rte_flow_rss_conf *rss_conf,
 		struct rte_flow_error *error)
 {
+	struct ci_flow_actions parsed_actions;
+	struct ci_flow_actions_check_param ac_param = {
+		.allowed_types = (enum rte_flow_action_type[]) {
+			RTE_FLOW_ACTION_TYPE_RSS,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.max_actions = 1,
+		.driver_ctx = dev
+		/* each pattern type will add specific check function */
+	};
 	const struct rte_flow_action_rss *rss_act;
+	int ret;
 
-	if (actions[1].type != RTE_FLOW_ACTION_TYPE_END)
-		return rte_flow_error_set(error, EINVAL,
-					  RTE_FLOW_ERROR_TYPE_ACTION,
-					  &actions[1],
-					  "Only support one action for RSS.");
-
-	rss_act = (const struct rte_flow_action_rss *)actions[0].conf;
-	if (rss_act->level)
-		return rte_flow_error_set(error, ENOTSUP,
-					  RTE_FLOW_ERROR_TYPE_ACTION_CONF,
-					  actions,
-					  "RSS level is not supported");
+	/*
+	 * We have two possible paths: global RSS configuration, and an RSS pattern action.
+	 *
+	 * For global patterns, we act on two types of flows:
+	 * - Empty pattern ([END])
+	 * - VLAN pattern ([VLAN] -> [END])
+	 *
+	 * Everything else is handled by pattern action parser.
+	 */
+	bool is_empty, is_vlan;
 
 	while (pattern->type == RTE_FLOW_ITEM_TYPE_VOID)
 		pattern++;
 
-	if (pattern[0].type == RTE_FLOW_ITEM_TYPE_END ||
-	    pattern[0].type == RTE_FLOW_ITEM_TYPE_VLAN)
-		return i40e_hash_parse_global_conf(dev, pattern, rss_act,
-						   rss_conf, error);
+	is_empty = pattern[0].type == RTE_FLOW_ITEM_TYPE_END;
+	is_vlan = pattern[0].type == RTE_FLOW_ITEM_TYPE_VLAN &&
+			pattern[1].type == RTE_FLOW_ITEM_TYPE_END;
 
-	return i40e_hash_parse_pattern_act(dev, pattern, rss_act,
-					   rss_conf, error);
+	/* VLAN path */
+	if (is_vlan) {
+		ac_param.check = i40e_hash_validate_queue_region;
+		ret = ci_flow_check_actions(actions, &ac_param, &parsed_actions, error);
+		if (ret)
+			return ret;
+		rss_act = parsed_actions.actions[0]->conf;
+		/* set up RSS functions */
+		rss_conf->conf.func = rss_act->func;
+		return i40e_hash_parse_queue_region(pattern, rss_act, rss_conf, error);
+	}
+	/* Empty pattern path */
+	if (is_empty) {
+		ac_param.check = i40e_hash_validate_queue_list;
+		ret = ci_flow_check_actions(actions, &ac_param, &parsed_actions, error);
+		if (ret)
+			return ret;
+		rss_act = parsed_actions.actions[0]->conf;
+		rss_conf->conf.func = rss_act->func;
+		/* if there is a queue list, take that path */
+		if (rss_act->queue != NULL) {
+			return i40e_hash_parse_queues(rss_act, rss_conf);
+		}
+		/* otherwise just parse RSS key */
+		if (rss_act->key != NULL) {
+			i40e_hash_parse_key(rss_act, rss_conf);
+		}
+		return 0;
+	}
+	ac_param.check = i40e_hash_validate_rss_pattern;
+	ret = ci_flow_check_actions(actions, &ac_param, &parsed_actions, error);
+	if (ret)
+		return ret;
+	rss_act = parsed_actions.actions[0]->conf;
+
+	/* pattern case */
+	return i40e_hash_parse_pattern_act(dev, pattern, rss_act, rss_conf, error);
 }
 
 static void
diff --git a/drivers/net/intel/i40e/i40e_hash.h b/drivers/net/intel/i40e/i40e_hash.h
index 2513d84565..99df4bccd0 100644
--- a/drivers/net/intel/i40e/i40e_hash.h
+++ b/drivers/net/intel/i40e/i40e_hash.h
@@ -13,7 +13,7 @@
 extern "C" {
 #endif
 
-int i40e_hash_parse(const struct rte_eth_dev *dev,
+int i40e_hash_parse(struct rte_eth_dev *dev,
 		    const struct rte_flow_item pattern[],
 		    const struct rte_flow_action actions[],
 		    struct i40e_rte_flow_rss_conf *rss_conf,
-- 
2.47.3

