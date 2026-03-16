Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159CDF53D81
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 17:29:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37D0E40A73;
	Mon, 16 Mar 2026 18:28:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 7A02840661
 for <dev@dpdk.org>; Mon, 16 Mar 2026 18:28:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773682096; x=1805218096;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Mhf7QkdAqq6HOfSsF67mperuNmnyOZXDurlQyDsMjKU=;
 b=aUHuwaTQioW0WkHWHOwua2cCk3I8JE0Z75gqdtxtTDxBXspx/LH3KLI8
 DOKKoQ2PNSLMhi3MrCF1OIIHNwbIJqNDYNrLbufgVRAvAhQ7EVWi23mUJ
 M7FwjOk4FgbpAyd0CZBLjTsvwisUylGrNZw8uKJJyVwsqnUzVjGaPbEHy
 vzIOiKBXb367lFQZ2xJkjKdwgpnHQGPYFkE9YJJdGqG+JRdjgmaAMudgH
 8wEppxH12t/4TGLZex6Z+Lr7A2L3visYNwBtdJJiCd+FVjb3KDxbd1tCX
 ilEkDN0TQxCdczb8AsXZxcyK+IU2uEh2pYKiNPU0ilwgojcXqsky8vdSv Q==;
X-CSE-ConnectionGUID: j16c4lzOQIqAMvGfZYJtuw==
X-CSE-MsgGUID: h446QsnlSEaLd3uTFSnqsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86059647"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="86059647"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 10:28:14 -0700
X-CSE-ConnectionGUID: Kl3uPGvzR02Sp3+gLSDA2w==
X-CSE-MsgGUID: nYhxycrJSPiFEtNN9Yr7Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221228246"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 16 Mar 2026 10:28:11 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [RFC PATCH v1 11/21] net/ixgbe: reimplement hash parser
Date: Mon, 16 Mar 2026 17:27:39 +0000
Message-ID: <44ca3311460e354ca45cb2e94efc015517c71cee.1773681365.git.anatoly.burakov@intel.com>
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
flow parser for RSS configuration.

RSS flow parser doesn't really parse any "flows", it was completely
ignoring the flow patterns and was only looking at actions. It will
therefore not specify a pattern graph and will thus match NULL pattern,
empty patterns (START -> END), and ANY patterns (START -> ANY -> END).

RSS was the last engine using "filter list", so that is now removed.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c    |   6 -
 drivers/net/intel/ixgbe/ixgbe_ethdev.h    |   5 +-
 drivers/net/intel/ixgbe/ixgbe_flow.c      | 277 +---------------------
 drivers/net/intel/ixgbe/ixgbe_flow.h      |   2 +
 drivers/net/intel/ixgbe/ixgbe_flow_hash.c | 182 ++++++++++++++
 drivers/net/intel/ixgbe/meson.build       |   1 +
 6 files changed, 193 insertions(+), 280 deletions(-)
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_hash.c

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 442e4d96c6..7ecfebdb25 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -1334,9 +1334,6 @@ eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 	if (ret)
 		goto err_l2_tn_filter_init;
 
-	/* initialize flow filter lists */
-	ixgbe_filterlist_init();
-
 	/* initialize bandwidth configuration info */
 	memset(bw_conf, 0, sizeof(struct ixgbe_bw_conf));
 
@@ -3141,9 +3138,6 @@ ixgbe_dev_close(struct rte_eth_dev *dev)
 	/* Remove all ntuple filters of the device */
 	ixgbe_ntuple_filter_uninit(dev);
 
-	/* clear all the filters list */
-	ixgbe_filterlist_flush();
-
 	/* Remove all Traffic Manager configuration */
 	ixgbe_tm_conf_uninit(dev);
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 17b9fa918f..182b013dc4 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -346,10 +346,9 @@ struct ixgbe_l2_tn_info {
 	uint16_t e_tag_ether_type; /* ether type for e-tag */
 };
 
+/* no driver-specific data needed */
 struct rte_flow {
 	struct ci_flow flow;
-	enum rte_filter_type filter_type;
-	void *rule;
 };
 
 struct ixgbe_macsec_setting {
@@ -691,8 +690,6 @@ ixgbe_dev_l2_tunnel_filter_add(struct rte_eth_dev *dev,
 int
 ixgbe_dev_l2_tunnel_filter_del(struct rte_eth_dev *dev,
 			       struct ixgbe_l2_tunnel_conf *l2_tunnel);
-void ixgbe_filterlist_init(void);
-void ixgbe_filterlist_flush(void);
 /*
  * Flow director function prototypes
  */
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index ea32025079..9efad51177 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -48,23 +48,6 @@
 #include "../common/flow_engine.h"
 #include "ixgbe_flow.h"
 
-/* rss filter list structure */
-struct ixgbe_rss_conf_ele {
-	TAILQ_ENTRY(ixgbe_rss_conf_ele) entries;
-	struct ixgbe_rte_flow_rss_conf filter_info;
-};
-/* ixgbe_flow memory list structure */
-struct ixgbe_flow_mem {
-	TAILQ_ENTRY(ixgbe_flow_mem) entries;
-	struct rte_flow *flow;
-};
-
-TAILQ_HEAD(ixgbe_rss_filter_list, ixgbe_rss_conf_ele);
-TAILQ_HEAD(ixgbe_flow_mem_list, ixgbe_flow_mem);
-
-static struct ixgbe_rss_filter_list filter_rss_list;
-static struct ixgbe_flow_mem_list ixgbe_flow_list;
-
 const struct ci_flow_engine_list ixgbe_flow_engine_list = {
 	{
 		&ixgbe_ethertype_flow_engine,
@@ -74,6 +57,7 @@ const struct ci_flow_engine_list ixgbe_flow_engine_list = {
 		&ixgbe_security_flow_engine,
 		&ixgbe_fdir_flow_engine,
 		&ixgbe_fdir_tunnel_flow_engine,
+		&ixgbe_hash_flow_engine,
 	},
 };
 /*
@@ -131,102 +115,6 @@ ixgbe_flow_actions_check(const struct ci_flow_actions *actions,
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
-	struct rte_eth_dev *dev = param->driver_ctx;
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
-		if (q >= dev->data->nb_rx_queues) {
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
-	/* filter out unsupported RSS types */
-	if ((rss_act->types & ~IXGBE_RSS_OFFLOAD_ALL) != 0) {
-		return rte_flow_error_set(error, ENOTSUP,
-			RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
-			"Invalid RSS type specified");
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
-		.driver_ctx = dev,
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
@@ -238,35 +126,6 @@ ixgbe_clear_rss_filter(struct rte_eth_dev *dev)
 		ixgbe_config_rss_filter(dev, &filter_info->rss_info, FALSE);
 }
 
-void
-ixgbe_filterlist_init(void)
-{
-	TAILQ_INIT(&filter_rss_list);
-	TAILQ_INIT(&ixgbe_flow_list);
-}
-
-void
-ixgbe_filterlist_flush(void)
-{
-	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
-	struct ixgbe_rss_conf_ele *rss_filter_ptr;
-
-	while ((rss_filter_ptr = TAILQ_FIRST(&filter_rss_list))) {
-		TAILQ_REMOVE(&filter_rss_list,
-				 rss_filter_ptr,
-				 entries);
-		rte_free(rss_filter_ptr);
-	}
-
-	while ((ixgbe_flow_mem_ptr = TAILQ_FIRST(&ixgbe_flow_list))) {
-		TAILQ_REMOVE(&ixgbe_flow_list,
-				 ixgbe_flow_mem_ptr,
-				 entries);
-		rte_free(ixgbe_flow_mem_ptr->flow);
-		rte_free(ixgbe_flow_mem_ptr);
-	}
-}
-
 /**
  * Create or destroy a flow rule.
  * Theorically one rule can match more than one filters.
@@ -281,68 +140,9 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 		  struct rte_flow_error *error)
 {
 	struct ixgbe_adapter *ad = dev->data->dev_private;
-	int ret;
-	struct ixgbe_rte_flow_rss_conf rss_conf;
-	struct rte_flow *flow = NULL;
-	struct ixgbe_rss_conf_ele *rss_filter_ptr;
-	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
 
-	/* try the new flow engine first */
-	flow = ci_flow_create(&ad->flow_engine_conf, &ixgbe_flow_engine_list,
+	return ci_flow_create(&ad->flow_engine_conf, &ixgbe_flow_engine_list,
 		attr, pattern, actions, error);
-	if (flow != NULL) {
-		return flow;
-	}
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
-	TAILQ_INSERT_TAIL(&ixgbe_flow_list,
-				ixgbe_flow_mem_ptr, entries);
-
-	memset(&rss_conf, 0, sizeof(struct ixgbe_rte_flow_rss_conf));
-	ret = ixgbe_parse_rss_filter(dev, attr,
-					actions, &rss_conf, error);
-	if (!ret) {
-		ret = ixgbe_config_rss_filter(dev, &rss_conf, TRUE);
-		if (!ret) {
-			rss_filter_ptr = rte_zmalloc("ixgbe_rss_filter",
-				sizeof(struct ixgbe_rss_conf_ele), 0);
-			if (!rss_filter_ptr) {
-				PMD_DRV_LOG(ERR, "failed to allocate memory");
-				goto out;
-			}
-			ixgbe_rss_conf_init(&rss_filter_ptr->filter_info,
-					    &rss_conf.conf);
-			TAILQ_INSERT_TAIL(&filter_rss_list,
-				rss_filter_ptr, entries);
-			flow->rule = rss_filter_ptr;
-			flow->filter_type = RTE_ETH_FILTER_HASH;
-			return flow;
-		}
-	}
-
-out:
-	TAILQ_REMOVE(&ixgbe_flow_list,
-		ixgbe_flow_mem_ptr, entries);
-	rte_flow_error_set(error, -ret,
-			   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-			   "Failed to create flow.");
-	rte_free(ixgbe_flow_mem_ptr);
-	rte_free(flow);
-	return NULL;
 }
 
 /**
@@ -358,22 +158,9 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 		struct rte_flow_error *error)
 {
 	struct ixgbe_adapter *ad = dev->data->dev_private;
-	struct ixgbe_rte_flow_rss_conf rss_conf;
-	int ret;
 
-	/* try the new flow engine first */
-	ret = ci_flow_validate(&ad->flow_engine_conf, &ixgbe_flow_engine_list,
+	return ci_flow_validate(&ad->flow_engine_conf, &ixgbe_flow_engine_list,
 		attr, pattern, actions, error);
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
 }
 
 /* Destroy a flow rule on ixgbe. */
@@ -383,58 +170,8 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		struct rte_flow_error *error)
 {
 	struct ixgbe_adapter *ad = dev->data->dev_private;
-	int ret;
-	struct rte_flow *pmd_flow = flow;
-	enum rte_filter_type filter_type = pmd_flow->filter_type;
-	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
-	struct ixgbe_rss_conf_ele *rss_filter_ptr;
 
-	/* try the new flow engine first */
-	ret = ci_flow_destroy(&ad->flow_engine_conf,
-			&ixgbe_flow_engine_list, flow, error);
-	if (ret == 0) {
-		return 0;
-	}
-
-	/* fall back to legacy engines */
-
-	switch (filter_type) {
-	case RTE_ETH_FILTER_HASH:
-		rss_filter_ptr = (struct ixgbe_rss_conf_ele *)
-				pmd_flow->rule;
-		ret = ixgbe_config_rss_filter(dev,
-					&rss_filter_ptr->filter_info, FALSE);
-		if (!ret) {
-			TAILQ_REMOVE(&filter_rss_list,
-				rss_filter_ptr, entries);
-			rte_free(rss_filter_ptr);
-		}
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
-	TAILQ_FOREACH(ixgbe_flow_mem_ptr, &ixgbe_flow_list, entries) {
-		if (ixgbe_flow_mem_ptr->flow == pmd_flow) {
-			TAILQ_REMOVE(&ixgbe_flow_list,
-				ixgbe_flow_mem_ptr, entries);
-			rte_free(ixgbe_flow_mem_ptr);
-			break;
-		}
-	}
-	rte_free(flow);
-
-	return ret;
+	return ci_flow_destroy(&ad->flow_engine_conf, &ixgbe_flow_engine_list, flow, error);
 }
 
 /*  Destroy all flow rules associated with a port on ixgbe. */
@@ -445,13 +182,15 @@ ixgbe_flow_flush(struct rte_eth_dev *dev,
 	struct ixgbe_adapter *ad = dev->data->dev_private;
 	int ret = 0;
 
-	/* flush all flows from the new flow engine */
+	/* flush the flow engine */
 	ret = ci_flow_flush(&ad->flow_engine_conf, &ixgbe_flow_engine_list, error);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "Failed to flush flow");
 		return ret;
 	}
 
+	/* normally this shouldn't be necessary */
+
 	ixgbe_clear_all_ntuple_filter(dev);
 	ixgbe_clear_all_ethertype_filter(dev);
 	ixgbe_clear_syn_filter(dev);
@@ -472,8 +211,6 @@ ixgbe_flow_flush(struct rte_eth_dev *dev,
 
 	ixgbe_clear_rss_filter(dev);
 
-	ixgbe_filterlist_flush();
-
 	return 0;
 }
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.h b/drivers/net/intel/ixgbe/ixgbe_flow.h
index 91ee5106e3..7a5dd09551 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.h
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.h
@@ -16,6 +16,7 @@ enum ixgbe_flow_engine_type {
 	IXGBE_FLOW_ENGINE_TYPE_SECURITY,
 	IXGBE_FLOW_ENGINE_TYPE_FDIR,
 	IXGBE_FLOW_ENGINE_TYPE_FDIR_TUNNEL,
+	IXGBE_FLOW_ENGINE_TYPE_HASH,
 };
 
 int
@@ -32,5 +33,6 @@ extern const struct ci_flow_engine ixgbe_ntuple_flow_engine;
 extern const struct ci_flow_engine ixgbe_security_flow_engine;
 extern const struct ci_flow_engine ixgbe_fdir_flow_engine;
 extern const struct ci_flow_engine ixgbe_fdir_tunnel_flow_engine;
+extern const struct ci_flow_engine ixgbe_hash_flow_engine;
 
 #endif /*  _IXGBE_FLOW_H_ */
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow_hash.c b/drivers/net/intel/ixgbe/ixgbe_flow_hash.c
new file mode 100644
index 0000000000..db9678b914
--- /dev/null
+++ b/drivers/net/intel/ixgbe/ixgbe_flow_hash.c
@@ -0,0 +1,182 @@
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
+	const struct rte_eth_dev *dev = param->driver_ctx;
+	const size_t rss_key_len = sizeof(((struct ixgbe_rte_flow_rss_conf *)0)->key);
+
+	/* check if queue list is not empty */
+	if (rss_act->queue_num == 0) {
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+			"RSS queue list is empty");
+	}
+
+	if (rss_act->queue[rss_act->queue_num - 1] >= dev->data->nb_rx_queues) {
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+			"Invalid RSS queue specified");
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
+	/* filter out unsupported RSS types */
+	if ((rss_act->types & ~IXGBE_RSS_OFFLOAD_ALL) != 0) {
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+			"Invalid RSS type specified");
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
+		.driver_ctx = ctx->dev,
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
+	struct rte_eth_dev *dev = flow->dev;
+	int ret;
+
+	ret = ixgbe_config_rss_filter(dev, &hash_flow->rss_conf, TRUE);
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
+	struct rte_eth_dev *dev = flow->dev;
+	struct ixgbe_adapter *adapter = dev->data->dev_private;
+	struct ixgbe_filter_info *filter_info = IXGBE_DEV_PRIVATE_TO_FILTER_INFO(adapter);
+	int ret;
+
+	ret = ixgbe_config_rss_filter(dev, &filter_info->rss_info, FALSE);
+	if (ret != 0) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, flow,
+				"Failed to uninstall RSS filter");
+	}
+	return 0;
+}
+
+const struct ci_flow_engine_ops ixgbe_hash_ops = {
+	/* RSS engine always available */
+	.ctx_parse = ixgbe_flow_hash_ctx_parse,
+	.ctx_to_flow = ixgbe_flow_hash_ctx_to_flow,
+	.flow_install = ixgbe_flow_hash_flow_install,
+	.flow_uninstall = ixgbe_flow_hash_flow_uninstall,
+};
+
+const struct ci_flow_engine ixgbe_hash_flow_engine = {
+	.name = "ixgbe_hash",
+	.ctx_size = sizeof(struct ixgbe_hash_ctx),
+	.flow_size = sizeof(struct ixgbe_hash_flow),
+	.type = IXGBE_FLOW_ENGINE_TYPE_HASH,
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
2.47.3

