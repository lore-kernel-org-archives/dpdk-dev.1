Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938B1C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 14:03:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72C5140DDD;
	Thu, 20 Aug 2026 16:02:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 756854067A
 for <dev@dpdk.org>; Thu, 20 Aug 2026 16:02:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787234522; x=1818770522;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=uSFcLl4Zr9sFm+0evXUtdbS2xDDmsVJhPsHz58UD8YA=;
 b=KRWYVME1i4EMlatdVQNTN0XXhm44j83JQI0wDjl2KKkh4MXlmvPlPlz7
 BGMZyLX5c9ihmhTFctXHdU0RvYCEn/klDdP5nu9RMziDV8KE7RuD3by0R
 8MUAKRIgZc7dEeq2Zyelatq4AU4GXjKbizGyK/463v+X9Q6GFfhcJUPXj
 ui8r/CJRqq27Zh1db1rGprNJffqrAEQNPSk3Fy459noMmjxtnXNMj2ehd
 ZxAuVaL5HWyUqjFHT6INgBFvxkXjDp3iWdcWbAAAWZoSg5aOujf/yaEDZ
 zJcVr1Kz2hQ1xRUQoSJJKFQc9wWHKZCjtmZyr/sx7q5kQqG6sFuyoZdlQ A==;
X-CSE-ConnectionGUID: uVYNWVtCTduHMqMviNNQ+Q==
X-CSE-MsgGUID: IkXAVLK7Qpa7iXenOMO9ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="75300336"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="75300336"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 07:02:01 -0700
X-CSE-ConnectionGUID: K5SPEzZURICLPKHL6Fw+uQ==
X-CSE-MsgGUID: J8Ogy0xpQ/Kcx7v+7/zn9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="264719723"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 20 Aug 2026 07:01:59 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 11/21] net/ixgbe: reimplement hash parser
Date: Thu, 20 Aug 2026 15:00:56 +0100
Message-ID: <d4cb02f3020172ed0c0bbaee258edbc76c75cf28.1787233988.git.anatoly.burakov@intel.com>
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
flow parser for RSS configuration.

RSS flow parser doesn't really parse any "flows", it was completely
ignoring the flow patterns and was only looking at actions. It will
therefore not specify a pattern graph and will thus match NULL pattern,
empty patterns (START -> END), and ANY patterns (START -> ANY -> END).

RSS was the last engine using "filter list", so that is now removed.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c    |   6 -
 drivers/net/intel/ixgbe/ixgbe_ethdev.h    |   9 +-
 drivers/net/intel/ixgbe/ixgbe_flow.c      | 406 +---------------------
 drivers/net/intel/ixgbe/ixgbe_flow.h      |   1 +
 drivers/net/intel/ixgbe/ixgbe_flow_hash.c | 178 ++++++++++
 drivers/net/intel/ixgbe/meson.build       |   1 +
 6 files changed, 191 insertions(+), 410 deletions(-)
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_hash.c

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index e8736be337..2116e7c164 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -1335,9 +1335,6 @@ eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 	if (ret)
 		goto err_l2_tn_filter_init;
 
-	/* initialize flow filter lists */
-	ixgbe_filterlist_init(eth_dev);
-
 	/* initialize bandwidth configuration info */
 	memset(bw_conf, 0, sizeof(struct ixgbe_bw_conf));
 
@@ -3153,9 +3150,6 @@ ixgbe_dev_close(struct rte_eth_dev *dev)
 	/* Remove all ntuple filters of the device */
 	ixgbe_ntuple_filter_uninit(dev);
 
-	/* clear all the filters list */
-	ixgbe_filterlist_flush(dev);
-
 	/* Remove all Traffic Manager configuration */
 	ixgbe_tm_conf_uninit(dev);
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index b7c795611f..1c18728f11 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -348,10 +348,9 @@ struct ixgbe_l2_tn_info {
 	uint16_t e_tag_ether_type; /* ether type for e-tag */
 };
 
+/* no driver-specific data needed */
 struct rte_flow {
 	struct ci_flow flow;
-	enum rte_filter_type filter_type;
-	void *rule;
 };
 
 struct ixgbe_macsec_setting {
@@ -459,9 +458,6 @@ struct ixgbe_tm_conf {
 	bool committed;
 };
 
-struct ixgbe_filter_ele_base;
-TAILQ_HEAD(ixgbe_filter_ele_list, ixgbe_filter_ele_base);
-
 /*
  * Structure to store private data for each driver instance (for each port).
  */
@@ -483,7 +479,6 @@ struct ixgbe_adapter {
 	struct ixgbe_bypass_info    bps;
 #endif /* RTE_LIBRTE_IXGBE_BYPASS */
 	struct ixgbe_filter_info    filter;
-	struct ixgbe_filter_ele_list flow_list;
 	struct ixgbe_l2_tn_info     l2_tn;
 	struct ixgbe_bw_conf        bw_conf;
 	struct ixgbe_ipsec          ipsec;
@@ -704,8 +699,6 @@ ixgbe_dev_l2_tunnel_filter_add(struct ixgbe_adapter *adapter,
 int
 ixgbe_dev_l2_tunnel_filter_del(struct ixgbe_adapter *adapter,
 			       struct ixgbe_l2_tunnel_conf *l2_tunnel);
-void ixgbe_filterlist_init(struct rte_eth_dev *dev);
-void ixgbe_filterlist_flush(struct rte_eth_dev *dev);
 /*
  * Flow director function prototypes
  */
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index cc9a42a17e..7cc53354ec 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -51,21 +51,6 @@
 #include "../common/flow_engine.h"
 #include "ixgbe_flow.h"
 
-struct ixgbe_filter_ele_base {
-	TAILQ_ENTRY(ixgbe_filter_ele_base) entries;
-};
-
-/* rss filter list structure */
-struct ixgbe_rss_conf_ele {
-	struct ixgbe_filter_ele_base base;
-	struct ixgbe_rte_flow_rss_conf filter_info;
-};
-/* ixgbe_flow memory list structure */
-struct ixgbe_flow_mem {
-	struct ixgbe_filter_ele_base base;
-	struct rte_flow *flow;
-};
-
 const struct ci_flow_engine_list ixgbe_flow_engine_list = {
 	{
 		&ixgbe_ethertype_flow_engine,
@@ -75,6 +60,7 @@ const struct ci_flow_engine_list ixgbe_flow_engine_list = {
 		&ixgbe_security_flow_engine,
 		&ixgbe_fdir_flow_engine,
 		&ixgbe_fdir_tunnel_flow_engine,
+		&ixgbe_hash_flow_engine,
 	},
 };
 /*
@@ -132,96 +118,6 @@ ixgbe_flow_actions_check(const struct ci_flow_actions *actions,
  * normally the packets should use network order.
  */
 
-/* Flow actions check specific to RSS filter */
-static int
-ixgbe_flow_actions_check_rss(const struct ci_flow_actions *parsed_actions,
-		const struct ci_flow_actions_check_param *param,
-		struct rte_flow_error *error)
-{
-	const struct rte_flow_action *action = parsed_actions->actions[0];
-	const struct rte_flow_action_rss *rss_act = action->conf;
-	struct rte_eth_dev_data *dev_data = param->driver_ctx;
-	const size_t rss_key_len = sizeof(((struct ixgbe_rte_flow_rss_conf *)0)->key);
-	size_t q_idx, q;
-
-	/* check if queue list is not empty */
-	if (rss_act->queue_num == 0) {
-		return rte_flow_error_set(error, ENOTSUP,
-			RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
-			"RSS queue list is empty");
-	}
-
-	/* check if each RSS queue is valid */
-	for (q_idx = 0; q_idx < rss_act->queue_num; q_idx++) {
-		q = rss_act->queue[q_idx];
-		if (q >= dev_data->nb_rx_queues) {
-			return rte_flow_error_set(error, ENOTSUP,
-				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
-				"Invalid RSS queue specified");
-		}
-	}
-
-	/* only support default hash function */
-	if (rss_act->func != RTE_ETH_HASH_FUNCTION_DEFAULT) {
-		return rte_flow_error_set(error, ENOTSUP,
-			RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
-			"Non-default RSS hash functions are not supported");
-	}
-	/* levels aren't supported */
-	if (rss_act->level) {
-		return rte_flow_error_set(error, ENOTSUP,
-			RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
-			"A nonzero RSS encapsulation level is not supported");
-	}
-	/* check key length */
-	if (rss_act->key_len != 0 && rss_act->key_len != rss_key_len) {
-		return rte_flow_error_set(error, ENOTSUP,
-			RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
-			"RSS key must be exactly 40 bytes long");
-	}
-	return 0;
-}
-
-static int
-ixgbe_parse_rss_filter(struct rte_eth_dev *dev,
-			const struct rte_flow_attr *attr,
-			const struct rte_flow_action actions[],
-			struct ixgbe_rte_flow_rss_conf *rss_conf,
-			struct rte_flow_error *error)
-{
-	struct ci_flow_actions parsed_actions;
-	struct ci_flow_actions_check_param ap_param = {
-		.allowed_types = (const enum rte_flow_action_type[]){
-			/* only rss allowed here */
-			RTE_FLOW_ACTION_TYPE_RSS,
-			RTE_FLOW_ACTION_TYPE_END
-		},
-		.driver_ctx = dev->data,
-		.check = ixgbe_flow_actions_check_rss,
-		.max_actions = 1,
-	};
-	int ret;
-	const struct rte_flow_action *action;
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
-	action = parsed_actions.actions[0];
-
-	if (ixgbe_rss_conf_init(rss_conf, action->conf))
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION, NULL,
-				"RSS context initialization failure");
-
-	return 0;
-}
-
 /* remove the rss filter */
 static void
 ixgbe_clear_rss_filter(struct rte_eth_dev *dev)
@@ -235,32 +131,6 @@ ixgbe_clear_rss_filter(struct rte_eth_dev *dev)
 		ixgbe_config_rss_filter(adapter, &filter_info->rss_info, FALSE);
 }
 
-void
-ixgbe_filterlist_init(struct rte_eth_dev *dev)
-{
-	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-
-	TAILQ_INIT(&adapter->flow_list);
-}
-
-void
-ixgbe_filterlist_flush(struct rte_eth_dev *dev)
-{
-	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct ixgbe_filter_ele_base *ele, *tmp;
-
-	RTE_TAILQ_FOREACH_SAFE(ele, &adapter->flow_list, entries, tmp) {
-		struct ixgbe_flow_mem *ixgbe_flow_mem_ptr =
-			(struct ixgbe_flow_mem *)ele;
-		struct rte_flow *flow = ixgbe_flow_mem_ptr->flow;
-
-		TAILQ_REMOVE(&adapter->flow_list, ele, entries);
-		rte_free(flow->rule);
-		rte_free(flow);
-		rte_free(ele);
-	}
-}
-
 /**
  * Create or destroy a flow rule.
  * Theorically one rule can match more than one filters.
@@ -274,65 +144,9 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 		  const struct rte_flow_action actions[],
 		  struct rte_flow_error *error)
 {
-	int ret;
-	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct ixgbe_rte_flow_rss_conf rss_conf;
-	struct rte_flow *flow = NULL;
-	struct ixgbe_rss_conf_ele *rss_filter_ptr;
-	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
+	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 
-	/* try the new flow engine first */
-	flow = ci_flow_create(&adapter->flow_engine_conf, attr, pattern, actions, error);
-	if (flow != NULL)
-		return flow;
-
-	/* fall back to legacy flow engines */
-
-	flow = rte_zmalloc("ixgbe_rte_flow", sizeof(struct rte_flow), 0);
-	if (!flow) {
-		PMD_DRV_LOG(ERR, "failed to allocate memory");
-		return (struct rte_flow *)flow;
-	}
-	ixgbe_flow_mem_ptr = rte_zmalloc("ixgbe_flow_mem",
-			sizeof(struct ixgbe_flow_mem), 0);
-	if (!ixgbe_flow_mem_ptr) {
-		PMD_DRV_LOG(ERR, "failed to allocate memory");
-		rte_free(flow);
-		return NULL;
-	}
-	ixgbe_flow_mem_ptr->flow = flow;
-	TAILQ_INSERT_TAIL(&adapter->flow_list,
-				&ixgbe_flow_mem_ptr->base, entries);
-
-	memset(&rss_conf, 0, sizeof(struct ixgbe_rte_flow_rss_conf));
-	ret = ixgbe_parse_rss_filter(dev, attr,
-					actions, &rss_conf, error);
-	if (!ret) {
-		ret = ixgbe_config_rss_filter(adapter, &rss_conf, TRUE);
-		if (!ret) {
-			rss_filter_ptr = rte_zmalloc("ixgbe_rss_filter",
-				sizeof(struct ixgbe_rss_conf_ele), 0);
-			if (!rss_filter_ptr) {
-				PMD_DRV_LOG(ERR, "failed to allocate memory");
-				goto out;
-			}
-			ixgbe_rss_conf_init(&rss_filter_ptr->filter_info,
-					    &rss_conf.conf);
-			flow->rule = rss_filter_ptr;
-			flow->filter_type = RTE_ETH_FILTER_HASH;
-			return flow;
-		}
-	}
-
-out:
-	TAILQ_REMOVE(&adapter->flow_list,
-		&ixgbe_flow_mem_ptr->base, entries);
-	rte_flow_error_set(error, -ret,
-			   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-			   "Failed to create flow.");
-	rte_free(ixgbe_flow_mem_ptr);
-	rte_free(flow);
-	return NULL;
+	return ci_flow_create(&ad->flow_engine_conf, attr, pattern, actions, error);
 }
 
 /**
@@ -348,21 +162,8 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 		struct rte_flow_error *error)
 {
 	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct ixgbe_rte_flow_rss_conf rss_conf;
-	int ret;
 
-	/* try the new flow engine first */
-	ret = ci_flow_validate(&ad->flow_engine_conf, attr, pattern, actions, error);
-	if (ret == 0)
-		return ret;
-
-	/* fall back to legacy engines */
-
-	memset(&rss_conf, 0, sizeof(struct ixgbe_rte_flow_rss_conf));
-	ret = ixgbe_parse_rss_filter(dev, attr,
-					actions, &rss_conf, error);
-
-	return ret;
+	return ci_flow_validate(&ad->flow_engine_conf, attr, pattern, actions, error);
 }
 
 /* Destroy a flow rule on ixgbe. */
@@ -371,63 +172,9 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		struct rte_flow *flow,
 		struct rte_flow_error *error)
 {
-	int ret;
-	struct ixgbe_adapter *adapter =
-		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct rte_flow *pmd_flow = flow;
-	enum rte_filter_type filter_type = pmd_flow->filter_type;
-	struct ixgbe_filter_ele_base *flow_mem_base;
-	struct ixgbe_rss_conf_ele *rss_filter_ptr;
+	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 
-	/* try the new flow engine first */
-	ret = ci_flow_destroy(&adapter->flow_engine_conf, flow, error);
-	if (ret == 0)
-		return 0;
-
-	/* fall back to legacy engines */
-
-	/* Validate ownership before touching HW/SW state. */
-	TAILQ_FOREACH(flow_mem_base, &adapter->flow_list, entries) {
-		struct ixgbe_flow_mem *ixgbe_flow_mem_ptr =
-			(struct ixgbe_flow_mem *)flow_mem_base;
-
-		if (ixgbe_flow_mem_ptr->flow == pmd_flow)
-			break;
-	}
-	if (flow_mem_base == NULL) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-				"Flow not found for this port");
-	}
-
-	switch (filter_type) {
-	case RTE_ETH_FILTER_HASH:
-		rss_filter_ptr = (struct ixgbe_rss_conf_ele *)
-				pmd_flow->rule;
-		ret = ixgbe_config_rss_filter(adapter,
-					&rss_filter_ptr->filter_info, FALSE);
-		if (!ret)
-			rte_free(rss_filter_ptr);
-		break;
-	default:
-		PMD_DRV_LOG(WARNING, "Filter type (%d) not supported",
-			    filter_type);
-		ret = -EINVAL;
-		break;
-	}
-
-	if (ret) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_HANDLE,
-				NULL, "Failed to destroy flow");
-		return ret;
-	}
-
-	TAILQ_REMOVE(&adapter->flow_list, flow_mem_base, entries);
-	rte_free(flow_mem_base);
-	rte_free(flow);
-
-	return ret;
+	return ci_flow_destroy(&ad->flow_engine_conf, flow, error);
 }
 
 /*  Destroy all flow rules associated with a port on ixgbe. */
@@ -438,13 +185,15 @@ ixgbe_flow_flush(struct rte_eth_dev *dev,
 	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	int ret = 0;
 
-	/* flush all flows from the new flow engine */
+	/* flush the flow engine */
 	ret = ci_flow_flush(&ad->flow_engine_conf, error);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "Failed to flush flow");
 		return ret;
 	}
 
+	/* normally this shouldn't be necessary */
+
 	ixgbe_clear_all_ntuple_filter(dev);
 	ixgbe_clear_all_ethertype_filter(dev);
 	ixgbe_clear_syn_filter(dev);
@@ -465,90 +214,9 @@ ixgbe_flow_flush(struct rte_eth_dev *dev,
 
 	ixgbe_clear_rss_filter(dev);
 
-	ixgbe_filterlist_flush(dev);
-
 	return 0;
 }
 
-#define IXGBE_FLOW_DUMP_CHUNK_BYTES 32
-
-static const char *
-ixgbe_flow_rule_engine_name(const struct rte_flow *flow)
-{
-	switch (flow->filter_type) {
-	case RTE_ETH_FILTER_NTUPLE:
-		return "ntuple";
-	case RTE_ETH_FILTER_ETHERTYPE:
-		return "ethertype";
-	case RTE_ETH_FILTER_SYN:
-		return "syn";
-	case RTE_ETH_FILTER_FDIR:
-		return "fdir";
-	case RTE_ETH_FILTER_L2_TUNNEL:
-		return "l2_tunnel";
-	case RTE_ETH_FILTER_HASH:
-		return "hash";
-	default:
-		return "unknown";
-	}
-}
-
-static size_t
-ixgbe_flow_rule_size(const struct rte_flow *flow)
-{
-	switch (flow->filter_type) {
-	case RTE_ETH_FILTER_NTUPLE:
-		return sizeof(struct rte_eth_ntuple_filter);
-	case RTE_ETH_FILTER_ETHERTYPE:
-		return sizeof(struct rte_eth_ethertype_filter);
-	case RTE_ETH_FILTER_SYN:
-		return sizeof(struct rte_eth_syn_filter);
-	case RTE_ETH_FILTER_FDIR:
-		return sizeof(struct ixgbe_fdir_rule);
-	case RTE_ETH_FILTER_L2_TUNNEL:
-		return sizeof(struct ixgbe_l2_tunnel_conf);
-	case RTE_ETH_FILTER_HASH:
-		return sizeof(struct ixgbe_rte_flow_rss_conf);
-	default:
-		return 0;
-	}
-}
-
-static const void *
-ixgbe_flow_rule_data(const struct rte_flow *flow)
-{
-	if (flow->rule == NULL)
-		return NULL;
-
-	return RTE_PTR_ADD(flow->rule, sizeof(struct ixgbe_filter_ele_base));
-}
-
-static void
-ixgbe_flow_dump_blob(FILE *file, const char *engine,
-		     const void *data, size_t data_len)
-{
-	const uint8_t *raw = (const uint8_t *)data;
-	const size_t nchunks =
-		(data_len + IXGBE_FLOW_DUMP_CHUNK_BYTES - 1) /
-		IXGBE_FLOW_DUMP_CHUNK_BYTES;
-	char title[64];
-	size_t ci;
-
-	fprintf(file, "FLOW DUMP: driver=ixgbe engine=%s\n", engine);
-	fprintf(file, "FLOW DUMP: DATA size=%zu chunks=%zu chunk_bytes=%d\n",
-		data_len, nchunks, IXGBE_FLOW_DUMP_CHUNK_BYTES);
-
-	for (ci = 0; ci < nchunks; ci++) {
-		const size_t off = ci * IXGBE_FLOW_DUMP_CHUNK_BYTES;
-		const size_t clen =
-			RTE_MIN((size_t)IXGBE_FLOW_DUMP_CHUNK_BYTES, data_len - off);
-
-		snprintf(title, sizeof(title), "FLOW DUMP: chunk %03zu/%03zu",
-			 ci + 1, nchunks);
-		rte_memdump(file, title, raw + off, clen);
-	}
-}
-
 static int
 ixgbe_flow_dev_dump(struct rte_eth_dev *dev,
 		    struct rte_flow *flow,
@@ -556,62 +224,8 @@ ixgbe_flow_dev_dump(struct rte_eth_dev *dev,
 		    struct rte_flow_error *error)
 {
 	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct ixgbe_filter_ele_base *flow_mem_base;
-	bool found = false;
-	int ret;
 
-	/* try the new flow engine first */
-	ret = ci_flow_dump(&ad->flow_engine_conf, flow, file, error);
-
-	/*
-	 * There are multiple possible situations here:
-	 *
-	 * - User requested to dump all flows
-	 * - User requested to dump a specific flow
-	 *
-	 * For the first case, we keep going because legacy engines might still
-	 * have flows we want to dump.
-	 *
-	 * For the second case, we only stop if the flow we were asked to dump
-	 * was found in the new engines, otherwise we keep looking.
-	 */
-	if (flow != NULL && ret == 0)
-		return 0;
-
-	TAILQ_FOREACH(flow_mem_base, &ad->flow_list, entries) {
-		struct ixgbe_flow_mem *ixgbe_flow_mem_ptr =
-			(struct ixgbe_flow_mem *)flow_mem_base;
-		struct rte_flow *p_flow = ixgbe_flow_mem_ptr->flow;
-		const void *rule_data = NULL;
-		const char *engine_name;
-		size_t rule_size = 0;
-
-		if (flow != NULL && p_flow != flow)
-			continue;
-
-		/* this should not happen */
-		if (p_flow->rule == NULL) {
-			PMD_DRV_LOG(DEBUG, "Invalid flow");
-			continue;
-		}
-
-		rule_size = ixgbe_flow_rule_size(p_flow);
-		if (rule_size == 0)
-			continue;
-
-		found = true;
-		rule_data = ixgbe_flow_rule_data(p_flow);
-		engine_name = ixgbe_flow_rule_engine_name(p_flow);
-		ixgbe_flow_dump_blob(file, engine_name,
-			rule_data, rule_size);
-	}
-
-	if (flow != NULL && !found)
-		return rte_flow_error_set(error, ENOENT,
-			RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-			"Flow not found");
-
-	return 0;
+	return ci_flow_dump(&ad->flow_engine_conf, flow, file, error);
 }
 
 const struct rte_flow_ops ixgbe_flow_ops = {
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.h b/drivers/net/intel/ixgbe/ixgbe_flow.h
index 256e0478f5..959b2c9594 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.h
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.h
@@ -22,5 +22,6 @@ extern const struct ci_flow_engine ixgbe_ntuple_flow_engine;
 extern const struct ci_flow_engine ixgbe_security_flow_engine;
 extern const struct ci_flow_engine ixgbe_fdir_flow_engine;
 extern const struct ci_flow_engine ixgbe_fdir_tunnel_flow_engine;
+extern const struct ci_flow_engine ixgbe_hash_flow_engine;
 
 #endif /*  _IXGBE_FLOW_H_ */
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow_hash.c b/drivers/net/intel/ixgbe/ixgbe_flow_hash.c
new file mode 100644
index 0000000000..2361da8613
--- /dev/null
+++ b/drivers/net/intel/ixgbe/ixgbe_flow_hash.c
@@ -0,0 +1,178 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include <rte_common.h>
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
+struct ixgbe_hash_flow {
+	struct rte_flow flow;
+	struct ixgbe_rte_flow_rss_conf rss_conf;
+};
+
+struct ixgbe_hash_ctx {
+	struct ci_flow_engine_ctx base;
+	struct ixgbe_rte_flow_rss_conf rss_conf;
+};
+
+/* Flow actions check specific to RSS filter */
+static int
+ixgbe_flow_actions_check_rss(const struct ci_flow_actions *parsed_actions,
+		const struct ci_flow_actions_check_param *param,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_action *action = parsed_actions->actions[0];
+	const struct rte_flow_action_rss *rss_act = action->conf;
+	const struct rte_eth_dev_data *dev_data = param->driver_ctx;
+	const size_t rss_key_len = sizeof(((struct ixgbe_rte_flow_rss_conf *)0)->key);
+	unsigned i;
+
+	/* check if queue list is not empty */
+	if (rss_act->queue_num == 0) {
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+			"RSS queue list is empty");
+	}
+
+	/* check if all queues are valid */
+	for (i = 0; i < rss_act->queue_num; i++) {
+		if (rss_act->queue[i] >= dev_data->nb_rx_queues) {
+			return rte_flow_error_set(error, ENOTSUP,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+				"Invalid RSS queue specified");
+		}
+	}
+
+	/* only support default hash function */
+	if (rss_act->func != RTE_ETH_HASH_FUNCTION_DEFAULT) {
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+			"Non-default RSS hash functions are not supported");
+	}
+	/* levels aren't supported */
+	if (rss_act->level) {
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+			"A nonzero RSS encapsulation level is not supported");
+	}
+	/* check key length */
+	if (rss_act->key_len != 0 && rss_act->key_len != rss_key_len) {
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+			"RSS key must be exactly 40 bytes long");
+	}
+	return 0;
+}
+
+static int
+ixgbe_flow_hash_ctx_parse(const struct rte_flow_action *actions,
+		const struct rte_flow_attr *attr,
+		struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	struct ci_flow_actions parsed_actions;
+	struct ci_flow_actions_check_param ap_param = {
+		.allowed_types = (const enum rte_flow_action_type[]){
+			/* only rss allowed here */
+			RTE_FLOW_ACTION_TYPE_RSS,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.driver_ctx = ctx->dev_data,
+		.check = ixgbe_flow_actions_check_rss,
+		.max_actions = 1,
+	};
+	struct ixgbe_hash_ctx *hash_ctx = (struct ixgbe_hash_ctx *)ctx;
+	const struct rte_flow_action_rss *rss_conf;
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
+	rss_conf = parsed_actions.actions[0]->conf;
+
+	ret = ixgbe_rss_conf_init(&hash_ctx->rss_conf, rss_conf);
+	if (ret) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, rss_conf,
+				"RSS context initialization failure");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_flow_hash_ctx_to_flow(const struct ci_flow_engine_ctx *ctx,
+		struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct ixgbe_hash_ctx *hash_ctx = (const struct ixgbe_hash_ctx *)ctx;
+	struct ixgbe_hash_flow *hash_flow = (struct ixgbe_hash_flow *)flow;
+
+	hash_flow->rss_conf = hash_ctx->rss_conf;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_hash_flow_install(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct ixgbe_hash_flow *hash_flow = (struct ixgbe_hash_flow *)flow;
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(flow->dev_data->dev_private);
+	int ret;
+
+	ret = ixgbe_config_rss_filter(adapter, &hash_flow->rss_conf, TRUE);
+	if (ret != 0) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, flow,
+				"Failed to install RSS filter");
+	}
+	return 0;
+}
+
+static int
+ixgbe_flow_hash_flow_uninstall(struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(flow->dev_data->dev_private);
+	struct ixgbe_filter_info *filter_info = IXGBE_DEV_PRIVATE_TO_FILTER_INFO(adapter);
+	int ret;
+
+	ret = ixgbe_config_rss_filter(adapter, &filter_info->rss_info, FALSE);
+	if (ret != 0) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, flow,
+				"Failed to uninstall RSS filter");
+	}
+	return 0;
+}
+
+static const struct ci_flow_engine_ops ixgbe_hash_ops = {
+	/* RSS engine always available */
+	.ctx_parse = ixgbe_flow_hash_ctx_parse,
+	.ctx_to_flow = ixgbe_flow_hash_ctx_to_flow,
+	.flow_install = ixgbe_flow_hash_flow_install,
+	.flow_uninstall = ixgbe_flow_hash_flow_uninstall,
+};
+
+const struct ci_flow_engine ixgbe_hash_flow_engine = {
+	.name = "hash",
+	.ctx_size = sizeof(struct ixgbe_hash_ctx),
+	.flow_size = sizeof(struct ixgbe_hash_flow),
+	.ops = &ixgbe_hash_ops,
+	/* RSS does not accept patterns */
+};
diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
index 770125350e..de35833e48 100644
--- a/drivers/net/intel/ixgbe/meson.build
+++ b/drivers/net/intel/ixgbe/meson.build
@@ -17,6 +17,7 @@ sources += files(
         'ixgbe_flow_ntuple.c',
         'ixgbe_flow_security.c',
         'ixgbe_flow_fdir.c',
+        'ixgbe_flow_hash.c',
         'ixgbe_ipsec.c',
         'ixgbe_pf.c',
         'ixgbe_rxtx.c',
-- 
2.52.0

