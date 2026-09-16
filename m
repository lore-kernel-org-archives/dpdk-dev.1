Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D629C88E77
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 12:20:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F84D42F2B;
	Wed, 16 Sep 2026 14:18:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id BBA2942F0D
 for <dev@dpdk.org>; Wed, 16 Sep 2026 14:18:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789561130; x=1821097130;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=0xMAvU04A0O435gPwIfXZFqw1e5KArMvG1Ai0kows/g=;
 b=QWKQgV7gi0FW6R+tXPmyAdmcGw4Zerbc5RaBm2GalKt5u70CfW1YKsYM
 Dpj48oQG5f/E3UOZfRPJAkPSqvzzSA8T1flkpNXoc4rMkpTqnbPXQVmk7
 Pw+Hqcma6cm2IXImDjPxRHhOJ/1r19VQgs8CgzrXBBQkcTVYMb53gMh5j
 O8td1xjCSgo8JZLEgDaBE3srYMY3r+gl5bWfV6ceVFtNJGbFjn2wClZwC
 Xvz/xqvLY9qsgHPHnOgA1T4w6oGfhZpyu37Gs8MOyk7dnmbZc9y47yMyo
 HAO5afQYGww3N22oTgDAgtJEz9lFSp1+E5NboISvKCSPGLr1ZvgE/H9zB w==;
X-CSE-ConnectionGUID: juvZ+diTRzGC0PnqSmOMjQ==
X-CSE-MsgGUID: SEIDW4gRRnqpTk7V+s39RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112702958"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="112702958"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 05:18:49 -0700
X-CSE-ConnectionGUID: bU+QazoaSAClNbidWX4rZg==
X-CSE-MsgGUID: kAMtQGlyTQ2hCzrCPSaT0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="272850272"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 16 Sep 2026 05:18:49 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 11/19] net/ixgbe: reimplement hash parser
Date: Wed, 16 Sep 2026 13:18:17 +0100
Message-ID: <cc6363a66e98e41defc05be3a4e63b4fc1e26674.1789560946.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1789560943.git.anatoly.burakov@intel.com>
 <cover.1789560943.git.anatoly.burakov@intel.com>
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
therefore not specify a pattern graph and will match NULL pattern, empty
patterns (START -> END), and ANY patterns (START -> ANY -> END).

RSS was the last engine using "filter list", so that is now removed. The
RSS engine filter tracking was also moved completely into the new engine,
and all of the "filter list" infrastructure is removed for good.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c    |  30 --
 drivers/net/intel/ixgbe/ixgbe_ethdev.h    |  18 +-
 drivers/net/intel/ixgbe/ixgbe_flow.c      | 415 +---------------------
 drivers/net/intel/ixgbe/ixgbe_flow.h      |   1 +
 drivers/net/intel/ixgbe/ixgbe_flow_hash.c | 212 +++++++++++
 drivers/net/intel/ixgbe/ixgbe_rxtx.c      |  48 +--
 drivers/net/intel/ixgbe/meson.build       |   1 +
 7 files changed, 235 insertions(+), 490 deletions(-)
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_hash.c

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index eaa19f041aa..78f3ab57aea 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -347,7 +347,6 @@ static int ixgbe_dev_udp_tunnel_port_add(struct rte_eth_dev *dev,
 					 struct rte_eth_udp_tunnel *udp_tunnel);
 static int ixgbe_dev_udp_tunnel_port_del(struct rte_eth_dev *dev,
 					 struct rte_eth_udp_tunnel *udp_tunnel);
-static int ixgbe_filter_restore(struct rte_eth_dev *dev);
 static void ixgbe_l2_tunnel_conf(struct rte_eth_dev *dev);
 static int ixgbe_wait_for_link_up(struct ixgbe_hw *hw);
 static int devarg_handle_int(__rte_unused const char *key, const char *value,
@@ -1364,9 +1363,6 @@ eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 	if (ret)
 		goto err_flow_engine_conf_init;
 
-	/* initialize flow filter lists */
-	ixgbe_filterlist_init(eth_dev);
-
 	/* initialize bandwidth configuration info */
 	memset(bw_conf, 0, sizeof(struct ixgbe_bw_conf));
 
@@ -2845,7 +2841,6 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
 	/* resume enabled intr since hw reset */
 	ixgbe_enable_intr(dev);
 	ixgbe_l2_tunnel_conf(dev);
-	ixgbe_filter_restore(dev);
 
 	if (tm_conf->root && !tm_conf->committed)
 		PMD_DRV_LOG(WARNING,
@@ -3106,9 +3101,6 @@ ixgbe_dev_close(struct rte_eth_dev *dev)
 	/* uninitialize PF if max_vfs not zero */
 	ixgbe_pf_host_uninit(dev);
 
-	/* clear all the filters list */
-	ixgbe_filterlist_flush(dev);
-
 	/* Remove all Traffic Manager configuration */
 	ixgbe_tm_conf_uninit(dev);
 
@@ -7866,28 +7858,6 @@ int ixgbe_enable_sec_tx_path_generic(struct ixgbe_hw *hw)
 	return IXGBE_SUCCESS;
 }
 
-/* restore rss filter */
-static inline void
-ixgbe_rss_filter_restore(struct rte_eth_dev *dev)
-{
-	struct ixgbe_adapter *adapter =
-		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct ixgbe_filter_info *filter_info =
-		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(adapter);
-
-	if (filter_info->rss_info.conf.queue_num)
-		ixgbe_config_rss_filter(adapter,
-			&filter_info->rss_info, TRUE);
-}
-
-static int
-ixgbe_filter_restore(struct rte_eth_dev *dev)
-{
-	ixgbe_rss_filter_restore(dev);
-
-	return 0;
-}
-
 static void
 ixgbe_l2_tunnel_conf(struct rte_eth_dev *dev)
 {
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index e20f94a9621..4143fffa814 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -305,8 +305,6 @@ struct ixgbe_ethertype_table {
  * Structure to store filters' info.
  */
 struct ixgbe_filter_info {
-	/* store the rss filter info */
-	struct ixgbe_rte_flow_rss_conf rss_info;
 	/* shared EtherType (ETQF) slot table */
 	struct ixgbe_ethertype_table ethertype_table;
 	/* 1588 timestamping ETQF slot (valid when timesync_installed) */
@@ -323,10 +321,9 @@ struct ixgbe_l2_tn_info {
 	uint16_t e_tag_ether_type; /* ether type for e-tag */
 };
 
+/* no driver-specific data needed */
 struct rte_flow {
 	struct ci_flow flow;
-	enum rte_filter_type filter_type;
-	void *rule;
 };
 
 struct ixgbe_macsec_setting {
@@ -434,9 +431,6 @@ struct ixgbe_tm_conf {
 	bool committed;
 };
 
-struct ixgbe_filter_ele_base;
-TAILQ_HEAD(ixgbe_filter_ele_list, ixgbe_filter_ele_base);
-
 /*
  * Structure to store private data for each driver instance (for each port).
  */
@@ -459,7 +453,6 @@ struct ixgbe_adapter {
 	struct ixgbe_bypass_info    bps;
 #endif /* RTE_LIBRTE_IXGBE_BYPASS */
 	struct ixgbe_filter_info    filter;
-	struct ixgbe_filter_ele_list flow_list;
 	struct ixgbe_l2_tn_info     l2_tn;
 	struct ixgbe_bw_conf        bw_conf;
 	struct ixgbe_ipsec          ipsec;
@@ -681,8 +674,6 @@ ixgbe_e_tag_filter_add(struct ixgbe_adapter *adapter,
 int
 ixgbe_e_tag_filter_del(struct ixgbe_adapter *adapter,
 		       struct ixgbe_l2_tunnel_conf *l2_tunnel);
-void ixgbe_filterlist_init(struct rte_eth_dev *dev);
-void ixgbe_filterlist_flush(struct rte_eth_dev *dev);
 /*
  * Flow director function prototypes
  */
@@ -754,10 +745,9 @@ int ixgbe_set_queue_rate_limit(struct rte_eth_dev *dev, uint16_t queue_idx,
 			       uint32_t tx_rate);
 int ixgbe_rss_conf_init(struct ixgbe_rte_flow_rss_conf *out,
 			const struct rte_flow_action_rss *in);
-int ixgbe_action_rss_same(const struct rte_flow_action_rss *comp,
-			  const struct rte_flow_action_rss *with);
-int ixgbe_config_rss_filter(struct ixgbe_adapter *adapter,
-		struct ixgbe_rte_flow_rss_conf *conf, bool add);
+void ixgbe_hw_rss_filter_program(struct ixgbe_hw *hw,
+		struct ixgbe_rte_flow_rss_conf *conf);
+void ixgbe_hw_rss_filter_clear(struct ixgbe_hw *hw);
 
 void ixgbe_dev_macsec_register_enable(struct rte_eth_dev *dev,
 		struct ixgbe_macsec_setting *macsec_setting);
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 868d65b2a88..f853e71d5c7 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -50,21 +50,6 @@
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
@@ -74,6 +59,7 @@ const struct ci_flow_engine_list ixgbe_flow_engine_list = {
 		&ixgbe_security_flow_engine,
 		&ixgbe_fdir_flow_engine,
 		&ixgbe_fdir_tunnel_flow_engine,
+		&ixgbe_hash_flow_engine,
 	},
 };
 /*
@@ -131,135 +117,6 @@ ixgbe_flow_actions_check(const struct ci_flow_actions *actions,
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
-/* remove the rss filter */
-static void
-ixgbe_clear_rss_filter(struct rte_eth_dev *dev)
-{
-	struct ixgbe_adapter *adapter =
-		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct ixgbe_filter_info *filter_info =
-		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
-
-	if (filter_info->rss_info.conf.queue_num)
-		ixgbe_config_rss_filter(adapter, &filter_info->rss_info, FALSE);
-}
-
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
@@ -273,65 +130,9 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
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
@@ -347,21 +148,8 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
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
@@ -370,63 +158,9 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
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
@@ -437,95 +171,16 @@ ixgbe_flow_flush(struct rte_eth_dev *dev,
 	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	int ret = 0;
 
-	/* flush all flows from the new flow engine */
+	/* flush the flow engine */
 	ret = ci_flow_flush(&ad->flow_engine_conf, error);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "Failed to flush flow");
 		return ret;
 	}
 
-	ixgbe_clear_rss_filter(dev);
-
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
@@ -533,62 +188,8 @@ ixgbe_flow_dev_dump(struct rte_eth_dev *dev,
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
index 256e0478f58..959b2c95947 100644
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
index 00000000000..2bbdcf2c7c9
--- /dev/null
+++ b/drivers/net/intel/ixgbe/ixgbe_flow_hash.c
@@ -0,0 +1,212 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include <rte_common.h>
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
+struct ixgbe_hash_priv {
+	/* the single installed RSS flow, NULL when none is configured */
+	struct ixgbe_hash_flow *active;
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
+ixgbe_flow_hash_ctx_init(const struct rte_flow_action *actions,
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
+ixgbe_flow_hash_flow_register(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct ixgbe_hash_flow *hash_flow = (struct ixgbe_hash_flow *)flow;
+	struct ixgbe_hash_priv *priv = flow->engine_priv;
+
+	/* hardware supports a single RSS filter at a time */
+	if (priv->active != NULL) {
+		return rte_flow_error_set(error, EEXIST,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"An RSS filter is already configured");
+	}
+
+	priv->active = hash_flow;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_hash_flow_unregister(struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_hash_flow *hash_flow = (struct ixgbe_hash_flow *)flow;
+	struct ixgbe_hash_priv *priv = flow->engine_priv;
+
+	if (priv->active != hash_flow) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"RSS filter is not registered");
+	}
+
+	priv->active = NULL;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_hash_flow_install(struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_hash_flow *hash_flow = (struct ixgbe_hash_flow *)flow;
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(flow->dev_data->dev_private);
+
+	ixgbe_hw_rss_filter_program(hw, &hash_flow->rss_conf);
+
+	return 0;
+}
+
+static int
+ixgbe_flow_hash_flow_uninstall(struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(flow->dev_data->dev_private);
+
+	ixgbe_hw_rss_filter_clear(hw);
+
+	return 0;
+}
+
+static const struct ci_flow_engine_ops ixgbe_hash_ops = {
+	/* RSS engine always available */
+	.ctx_init = ixgbe_flow_hash_ctx_init,
+	.ctx_to_flow = ixgbe_flow_hash_ctx_to_flow,
+	.flow_register = ixgbe_flow_hash_flow_register,
+	.flow_unregister = ixgbe_flow_hash_flow_unregister,
+	.flow_install = ixgbe_flow_hash_flow_install,
+	.flow_uninstall = ixgbe_flow_hash_flow_uninstall,
+};
+
+const struct ci_flow_engine ixgbe_hash_flow_engine = {
+	.name = "ixgbe_hash",
+	.ctx_size = sizeof(struct ixgbe_hash_ctx),
+	.flow_size = sizeof(struct ixgbe_hash_flow),
+	.priv_size = sizeof(struct ixgbe_hash_priv),
+	.ops = &ixgbe_hash_ops,
+	/* RSS does not accept patterns */
+};
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 60222693fe8..7e251dff368 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -6117,25 +6117,10 @@ ixgbe_rss_conf_init(struct ixgbe_rte_flow_rss_conf *out,
 	return 0;
 }
 
-int
-ixgbe_action_rss_same(const struct rte_flow_action_rss *comp,
-		      const struct rte_flow_action_rss *with)
+void
+ixgbe_hw_rss_filter_program(struct ixgbe_hw *hw,
+		struct ixgbe_rte_flow_rss_conf *conf)
 {
-	return (comp->func == with->func &&
-		comp->level == with->level &&
-		comp->types == with->types &&
-		comp->key_len == with->key_len &&
-		comp->queue_num == with->queue_num &&
-		!memcmp(comp->key, with->key, with->key_len) &&
-		!memcmp(comp->queue, with->queue,
-			sizeof(*with->queue) * with->queue_num));
-}
-
-int
-ixgbe_config_rss_filter(struct ixgbe_adapter *adapter,
-		struct ixgbe_rte_flow_rss_conf *conf, bool add)
-{
-	struct ixgbe_hw *hw;
 	uint32_t reta;
 	uint16_t i;
 	uint16_t j;
@@ -6147,27 +6132,11 @@ ixgbe_config_rss_filter(struct ixgbe_adapter *adapter,
 		.rss_key_len = conf->conf.key_len,
 		.rss_hf = conf->conf.types,
 	};
-	struct ixgbe_filter_info *filter_info =
-		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(adapter);
 
 	PMD_INIT_FUNC_TRACE();
-	hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
 
 	sp_reta_size = ixgbe_reta_size_get(hw->mac.type);
 
-	if (!add) {
-		if (ixgbe_action_rss_same(&filter_info->rss_info.conf,
-					  &conf->conf)) {
-			ixgbe_mrqc_rss_remove(hw);
-			memset(&filter_info->rss_info, 0,
-				sizeof(struct ixgbe_rte_flow_rss_conf));
-			return 0;
-		}
-		return -EINVAL;
-	}
-
-	if (filter_info->rss_info.conf.queue_num)
-		return -EINVAL;
 	/* Fill in redirection table
 	 * The byte-swap is needed because NIC registers are in
 	 * little-endian order.
@@ -6189,14 +6158,15 @@ ixgbe_config_rss_filter(struct ixgbe_adapter *adapter,
 	 */
 	if ((rss_conf.rss_hf & IXGBE_RSS_OFFLOAD_ALL) == 0) {
 		ixgbe_mrqc_rss_remove(hw);
-		return 0;
+		return;
 	}
 	if (rss_conf.rss_key == NULL)
 		rss_conf.rss_key = rss_intel_key; /* Default hash key */
 	ixgbe_hw_rss_hash_set(hw, &rss_conf);
+}
 
-	if (ixgbe_rss_conf_init(&filter_info->rss_info, &conf->conf))
-		return -EINVAL;
-
-	return 0;
+void
+ixgbe_hw_rss_filter_clear(struct ixgbe_hw *hw)
+{
+	ixgbe_mrqc_rss_remove(hw);
 }
diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
index 2487f6a522f..7e267008351 100644
--- a/drivers/net/intel/ixgbe/meson.build
+++ b/drivers/net/intel/ixgbe/meson.build
@@ -32,6 +32,7 @@ sources += files(
         'ixgbe_flow_ntuple.c',
         'ixgbe_flow_security.c',
         'ixgbe_flow_fdir.c',
+        'ixgbe_flow_hash.c',
         'ixgbe_ipsec.c',
         'ixgbe_pf.c',
         'ixgbe_rxtx.c',
-- 
2.52.0

