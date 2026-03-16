Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383DEF53D7E
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 17:31:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF18840DF8;
	Mon, 16 Mar 2026 18:28:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 3B79840A87
 for <dev@dpdk.org>; Mon, 16 Mar 2026 18:28:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773682104; x=1805218104;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=M32NbhKAcH5Ttq+wQSZXgUJloocEwB9waAa6/l9nzco=;
 b=Z07LgbsxUKsZT3DcPumM45S1FG2yatUqDOfvl8CqA1SqinUyNSb5KUwU
 XhKztjGTgrogELhDgJqKeYe9ZWa2zduzCT+RbvvCBBMkMk1SI03aVrt2Q
 f1v//x9V0iPqGP7cs9WofbJF+y3N82XVu8AUzqM0RUF10hQlPvQThg7ZK
 hmko0v10pXL4YlkCFoCe6358lpC6u46bGtf2tALW3RLVMpqajaxI6XBz+
 FBelVx4EAL2OAURGMg340yrSJp0qRJwvMc4+Plcl5OMK8EzizN6JqWV1y
 nNG53yj1syQdTg6MTLSjplx5qEachcuPBnAI3kpcydYGlp6GttkBhRLP+ A==;
X-CSE-ConnectionGUID: qYMQLTQTT2u2R4wmC51v8g==
X-CSE-MsgGUID: M55PoeTvQPmWtcwB+IAkPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86059677"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="86059677"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 10:28:24 -0700
X-CSE-ConnectionGUID: WyK0EWPGSDePSiNFWBkMgw==
X-CSE-MsgGUID: gB1y2bF5SHK31+MJz+EtfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221228322"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 16 Mar 2026 10:28:23 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH v1 21/21] net/i40e: reimplement hash parser
Date: Mon, 16 Mar 2026 17:27:49 +0000
Message-ID: <2f8842b5f8280cba0bc4260773aa13e809b520fc.1773681366.git.anatoly.burakov@intel.com>
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
flow parser for RSS.

The RSS parser was bypassing the other generic infrastructure, probably
because it was very convoluted and did not map onto that model very well.
It has now been made a first-class citizen.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.h    |    5 -
 drivers/net/intel/i40e/i40e_flow.c      |  178 +---
 drivers/net/intel/i40e/i40e_flow.h      |    6 +
 drivers/net/intel/i40e/i40e_flow_hash.c | 1289 +++++++++++++++++++++++
 drivers/net/intel/i40e/i40e_hash.c      |  980 +----------------
 drivers/net/intel/i40e/i40e_hash.h      |    8 +-
 drivers/net/intel/i40e/meson.build      |    1 +
 7 files changed, 1308 insertions(+), 1159 deletions(-)
 create mode 100644 drivers/net/intel/i40e/i40e_flow_hash.c

diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 2503830f22..d69e671cca 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -1291,11 +1291,6 @@ struct i40e_vf_representor {
 
 extern const struct rte_flow_ops i40e_flow_ops;
 
-struct i40e_filter_ctx {
-	struct i40e_rte_flow_rss_conf rss_conf;
-	enum rte_filter_type type;
-};
-
 int i40e_dev_switch_queues(struct i40e_pf *pf, bool on);
 int i40e_vsi_release(struct i40e_vsi *vsi);
 struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf,
diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 2b4a4dd12c..a269efdec4 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -39,6 +39,9 @@ const struct ci_flow_engine_list i40e_flow_engine_list = {
 		&i40e_flow_engine_tunnel_mpls,
 		&i40e_flow_engine_tunnel_gtp,
 		&i40e_flow_engine_tunnel_l4,
+		&i40e_flow_engine_hash_pattern,
+		&i40e_flow_engine_hash_vlan,
+		&i40e_flow_engine_hash_empty,
 	}
 };
 
@@ -164,40 +167,6 @@ i40e_flow_fdir_get_pctype_value(struct i40e_pf *pf,
 	return I40E_FILTER_PCTYPE_INVALID;
 }
 
-static int
-i40e_flow_check(struct rte_eth_dev *dev,
-		   const struct rte_flow_attr *attr,
-		   const struct rte_flow_item pattern[],
-		   const struct rte_flow_action actions[],
-		   struct i40e_filter_ctx *filter_ctx,
-		   struct rte_flow_error *error)
-{
-	int ret;
-
-	ret = ci_flow_check_attr(attr, NULL, error);
-	if (ret) {
-		return ret;
-	}
-	/* action and pattern validation will happen in each respective engine */
-
-	if (!pattern) {
-		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM_NUM,
-				   NULL, "NULL pattern.");
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
-	/* try parsing as RSS */
-	filter_ctx->type = RTE_ETH_FILTER_HASH;
-	return i40e_hash_parse(dev, pattern, actions, &filter_ctx->rss_conf, error);
-}
-
 static int
 i40e_flow_validate(struct rte_eth_dev *dev,
 		   const struct rte_flow_attr *attr,
@@ -206,17 +175,9 @@ i40e_flow_validate(struct rte_eth_dev *dev,
 		   struct rte_flow_error *error)
 {
 	struct i40e_pf *pf = dev->data->dev_private;
-	/* creates dummy context */
-	struct i40e_filter_ctx filter_ctx = {0};
-	int ret;
 
-	/* try the new engine first */
-	ret = ci_flow_validate(&pf->flow_engine_conf, &i40e_flow_engine_list,
+	return ci_flow_validate(&pf->flow_engine_conf, &i40e_flow_engine_list,
 			attr, pattern, actions, error);
-	if (ret == 0)
-		return 0;
-
-	return i40e_flow_check(dev, attr, pattern, actions, &filter_ctx, error);
 }
 
 static struct rte_flow *
@@ -227,52 +188,9 @@ i40e_flow_create(struct rte_eth_dev *dev,
 		 struct rte_flow_error *error)
 {
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-	struct i40e_filter_ctx filter_ctx = {0};
-	struct rte_flow *flow = NULL;
-	int ret;
 
-	/* try the new engine first */
-	flow = ci_flow_create(&pf->flow_engine_conf, &i40e_flow_engine_list,
+	return ci_flow_create(&pf->flow_engine_conf, &i40e_flow_engine_list,
 			attr, pattern, actions, error);
-	if (flow != NULL)
-		return flow;
-
-	ret = i40e_flow_check(dev, attr, pattern, actions, &filter_ctx, error);
-	if (ret < 0)
-		return NULL;
-
-	flow = rte_zmalloc("i40e_flow", sizeof(struct rte_flow), 0);
-	if (!flow) {
-		rte_flow_error_set(error, ENOMEM,
-					RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-					"Failed to allocate memory");
-		return flow;
-	}
-
-	switch (filter_ctx.type) {
-	case RTE_ETH_FILTER_HASH:
-		ret = i40e_hash_filter_create(pf, &filter_ctx.rss_conf);
-		if (ret)
-			goto free_flow;
-		flow->rule = TAILQ_LAST(&pf->rss_config_list,
-					i40e_rss_conf_list);
-		break;
-	default:
-		goto free_flow;
-	}
-
-	flow->filter_type = filter_ctx.type;
-	TAILQ_INSERT_TAIL(&pf->flow_list, flow, node);
-	return flow;
-
-free_flow:
-	rte_flow_error_set(error, -ret,
-			   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-			   "Failed to create flow.");
-
-	rte_free(flow);
-
-	return NULL;
 }
 
 static int
@@ -281,55 +199,17 @@ i40e_flow_destroy(struct rte_eth_dev *dev,
 		  struct rte_flow_error *error)
 {
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-	enum rte_filter_type filter_type = flow->filter_type;
-	int ret = 0;
 
-	/* try the new engine first */
-	ret = ci_flow_destroy(&pf->flow_engine_conf, &i40e_flow_engine_list,
+	return ci_flow_destroy(&pf->flow_engine_conf, &i40e_flow_engine_list,
 			flow, error);
-	if (ret == 0)
-		return 0;
-
-	switch (filter_type) {
-	case RTE_ETH_FILTER_HASH:
-		ret = i40e_hash_filter_destroy(pf, flow->rule);
-		break;
-	default:
-		PMD_DRV_LOG(WARNING, "Filter type (%d) not supported",
-			    filter_type);
-		ret = -EINVAL;
-		break;
-	}
-
-	if (!ret) {
-		TAILQ_REMOVE(&pf->flow_list, flow, node);
-		rte_free(flow);
-
-	} else
-		rte_flow_error_set(error, -ret,
-				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-				   "Failed to destroy flow.");
-
-	return ret;
 }
 
 static int
 i40e_flow_flush(struct rte_eth_dev *dev, struct rte_flow_error *error)
 {
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-	int ret;
 
-	/* flush the new engine first */
-	ret = ci_flow_flush(&pf->flow_engine_conf, &i40e_flow_engine_list, error);
-	if (ret != 0)
-		return ret;
-
-	ret = i40e_hash_filter_flush(pf);
-	if (ret)
-		rte_flow_error_set(error, -ret,
-				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-				   "Failed to flush RSS flows.");
-	return ret;
+	return ci_flow_flush(&pf->flow_engine_conf, &i40e_flow_engine_list, error);
 }
 
 static int
@@ -338,48 +218,8 @@ i40e_flow_query(struct rte_eth_dev *dev,
 		const struct rte_flow_action *actions,
 		void *data, struct rte_flow_error *error)
 {
-	struct i40e_pf *pf = dev->data->dev_private;
-	struct i40e_rss_filter *rss_rule = (struct i40e_rss_filter *)flow->rule;
-	enum rte_filter_type filter_type = flow->filter_type;
-	struct rte_flow_action_rss *rss_conf = data;
-	int ret;
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 
-	/* try the new engine first */
-	ret = ci_flow_query(&pf->flow_engine_conf, &i40e_flow_engine_list,
+	return ci_flow_query(&pf->flow_engine_conf, &i40e_flow_engine_list,
 			flow, actions, data, error);
-	if (ret == 0)
-		return 0;
-
-	if (!rss_rule) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_HANDLE,
-				   NULL, "Invalid rule");
-		return -rte_errno;
-	}
-
-	for (; actions->type != RTE_FLOW_ACTION_TYPE_END; actions++) {
-		switch (actions->type) {
-		case RTE_FLOW_ACTION_TYPE_VOID:
-			break;
-		case RTE_FLOW_ACTION_TYPE_RSS:
-			if (filter_type != RTE_ETH_FILTER_HASH) {
-				rte_flow_error_set(error, ENOTSUP,
-						   RTE_FLOW_ERROR_TYPE_ACTION,
-						   actions,
-						   "action not supported");
-				return -rte_errno;
-			}
-			rte_memcpy(rss_conf,
-				   &rss_rule->rss_filter_info.conf,
-				   sizeof(struct rte_flow_action_rss));
-			break;
-		default:
-			return rte_flow_error_set(error, ENOTSUP,
-						  RTE_FLOW_ERROR_TYPE_ACTION,
-						  actions,
-						  "action not supported");
-		}
-	}
-
-	return 0;
 }
diff --git a/drivers/net/intel/i40e/i40e_flow.h b/drivers/net/intel/i40e/i40e_flow.h
index 24683dcff9..db4dbceca3 100644
--- a/drivers/net/intel/i40e/i40e_flow.h
+++ b/drivers/net/intel/i40e/i40e_flow.h
@@ -22,6 +22,9 @@ enum i40e_flow_engine_type {
 	I40E_FLOW_ENGINE_TYPE_TUNNEL_MPLS,
 	I40E_FLOW_ENGINE_TYPE_TUNNEL_GTP,
 	I40E_FLOW_ENGINE_TYPE_TUNNEL_L4,
+	I40E_FLOW_ENGINE_TYPE_HASH_PATTERN,
+	I40E_FLOW_ENGINE_TYPE_HASH_VLAN,
+	I40E_FLOW_ENGINE_TYPE_HASH_EMPTY,
 };
 
 extern const struct ci_flow_engine_list i40e_flow_engine_list;
@@ -34,5 +37,8 @@ extern const struct ci_flow_engine i40e_flow_engine_tunnel_nvgre;
 extern const struct ci_flow_engine i40e_flow_engine_tunnel_mpls;
 extern const struct ci_flow_engine i40e_flow_engine_tunnel_gtp;
 extern const struct ci_flow_engine i40e_flow_engine_tunnel_l4;
+extern const struct ci_flow_engine i40e_flow_engine_hash_pattern;
+extern const struct ci_flow_engine i40e_flow_engine_hash_vlan;
+extern const struct ci_flow_engine i40e_flow_engine_hash_empty;
 
 #endif /* _I40E_FLOW_H_ */
diff --git a/drivers/net/intel/i40e/i40e_flow_hash.c b/drivers/net/intel/i40e/i40e_flow_hash.c
new file mode 100644
index 0000000000..90ce7c7057
--- /dev/null
+++ b/drivers/net/intel/i40e/i40e_flow_hash.c
@@ -0,0 +1,1289 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include "i40e_ethdev.h"
+#include "i40e_flow.h"
+#include "i40e_hash.h"
+
+#include "../common/flow_engine.h"
+#include "../common/flow_check.h"
+#include "../common/flow_util.h"
+
+struct i40e_hash_ctx {
+	struct ci_flow_engine_ctx base;
+	struct i40e_rte_flow_rss_conf rss_conf;
+	uint32_t pctype;
+	bool customized_ptype;
+};
+
+struct i40e_flow_engine_hash_flow {
+	struct rte_flow base;
+	struct i40e_rte_flow_rss_conf rss_conf;
+};
+
+#define I40E_VLAN_TCI_MASK	((0x7) << 13)
+
+#define I40E_HASH_L4_TYPES		(RTE_ETH_RSS_NONFRAG_IPV4_TCP | \
+					RTE_ETH_RSS_NONFRAG_IPV4_UDP | \
+					RTE_ETH_RSS_NONFRAG_IPV4_SCTP | \
+					RTE_ETH_RSS_NONFRAG_IPV6_TCP | \
+					RTE_ETH_RSS_NONFRAG_IPV6_UDP | \
+					RTE_ETH_RSS_NONFRAG_IPV6_SCTP)
+
+#define I40E_HASH_L2_RSS_MASK		(RTE_ETH_RSS_VLAN | RTE_ETH_RSS_ETH | \
+					RTE_ETH_RSS_L2_SRC_ONLY | \
+					RTE_ETH_RSS_L2_DST_ONLY)
+
+#define I40E_HASH_L23_RSS_MASK		(I40E_HASH_L2_RSS_MASK | \
+					RTE_ETH_RSS_L3_SRC_ONLY | \
+					RTE_ETH_RSS_L3_DST_ONLY)
+
+#define I40E_HASH_IPV4_L23_RSS_MASK	(RTE_ETH_RSS_IPV4 | I40E_HASH_L23_RSS_MASK)
+#define I40E_HASH_IPV6_L23_RSS_MASK	(RTE_ETH_RSS_IPV6 | I40E_HASH_L23_RSS_MASK)
+
+#define I40E_HASH_L234_RSS_MASK		(I40E_HASH_L23_RSS_MASK | \
+					RTE_ETH_RSS_PORT | RTE_ETH_RSS_L4_SRC_ONLY | \
+					RTE_ETH_RSS_L4_DST_ONLY)
+
+#define I40E_HASH_IPV4_L234_RSS_MASK	(I40E_HASH_L234_RSS_MASK | RTE_ETH_RSS_IPV4)
+#define I40E_HASH_IPV6_L234_RSS_MASK	(I40E_HASH_L234_RSS_MASK | RTE_ETH_RSS_IPV6)
+
+/* Structure of mapping RSS type to input set */
+struct i40e_hash_map_rss_inset {
+	uint64_t rss_type;
+	uint64_t inset;
+};
+
+const struct i40e_hash_map_rss_inset i40e_hash_rss_inset[] = {
+	/* IPv4 */
+	{ RTE_ETH_RSS_IPV4, I40E_INSET_IPV4_SRC | I40E_INSET_IPV4_DST },
+	{ RTE_ETH_RSS_FRAG_IPV4, I40E_INSET_IPV4_SRC | I40E_INSET_IPV4_DST },
+
+	{ RTE_ETH_RSS_NONFRAG_IPV4_OTHER,
+	  I40E_INSET_IPV4_SRC | I40E_INSET_IPV4_DST },
+
+	{ RTE_ETH_RSS_NONFRAG_IPV4_TCP, I40E_INSET_IPV4_SRC | I40E_INSET_IPV4_DST |
+	  I40E_INSET_SRC_PORT | I40E_INSET_DST_PORT },
+
+	{ RTE_ETH_RSS_NONFRAG_IPV4_UDP, I40E_INSET_IPV4_SRC | I40E_INSET_IPV4_DST |
+	  I40E_INSET_SRC_PORT | I40E_INSET_DST_PORT },
+
+	{ RTE_ETH_RSS_NONFRAG_IPV4_SCTP, I40E_INSET_IPV4_SRC | I40E_INSET_IPV4_DST |
+	  I40E_INSET_SRC_PORT | I40E_INSET_DST_PORT | I40E_INSET_SCTP_VT },
+
+	/* IPv6 */
+	{ RTE_ETH_RSS_IPV6, I40E_INSET_IPV6_SRC | I40E_INSET_IPV6_DST },
+	{ RTE_ETH_RSS_FRAG_IPV6, I40E_INSET_IPV6_SRC | I40E_INSET_IPV6_DST },
+
+	{ RTE_ETH_RSS_NONFRAG_IPV6_OTHER,
+	  I40E_INSET_IPV6_SRC | I40E_INSET_IPV6_DST },
+
+	{ RTE_ETH_RSS_NONFRAG_IPV6_TCP, I40E_INSET_IPV6_SRC | I40E_INSET_IPV6_DST |
+	  I40E_INSET_SRC_PORT | I40E_INSET_DST_PORT },
+
+	{ RTE_ETH_RSS_NONFRAG_IPV6_UDP, I40E_INSET_IPV6_SRC | I40E_INSET_IPV6_DST |
+	  I40E_INSET_SRC_PORT | I40E_INSET_DST_PORT },
+
+	{ RTE_ETH_RSS_NONFRAG_IPV6_SCTP, I40E_INSET_IPV6_SRC | I40E_INSET_IPV6_DST |
+	  I40E_INSET_SRC_PORT | I40E_INSET_DST_PORT | I40E_INSET_SCTP_VT },
+
+	/* Port */
+	{ RTE_ETH_RSS_PORT, I40E_INSET_SRC_PORT | I40E_INSET_DST_PORT },
+
+	/* Ether */
+	{ RTE_ETH_RSS_L2_PAYLOAD, I40E_INSET_LAST_ETHER_TYPE },
+	{ RTE_ETH_RSS_ETH, I40E_INSET_DMAC | I40E_INSET_SMAC },
+
+	/* VLAN */
+	{ RTE_ETH_RSS_S_VLAN, I40E_INSET_VLAN_OUTER },
+	{ RTE_ETH_RSS_C_VLAN, I40E_INSET_VLAN_INNER },
+};
+
+static uint64_t
+i40e_hash_get_inset(uint64_t rss_types, bool symmetric_enable)
+{
+	uint64_t mask, inset = 0;
+	int i;
+
+	for (i = 0; i < (int)RTE_DIM(i40e_hash_rss_inset); i++) {
+		if (rss_types & i40e_hash_rss_inset[i].rss_type)
+			inset |= i40e_hash_rss_inset[i].inset;
+	}
+
+	if (!inset)
+		return 0;
+
+	/* If SRC_ONLY and DST_ONLY of the same level are used simultaneously,
+	 * it is the same case as none of them are added.
+	 */
+	mask = rss_types & (RTE_ETH_RSS_L2_SRC_ONLY | RTE_ETH_RSS_L2_DST_ONLY);
+	if (mask == RTE_ETH_RSS_L2_SRC_ONLY)
+		inset &= ~I40E_INSET_DMAC;
+	else if (mask == RTE_ETH_RSS_L2_DST_ONLY)
+		inset &= ~I40E_INSET_SMAC;
+
+	mask = rss_types & (RTE_ETH_RSS_L3_SRC_ONLY | RTE_ETH_RSS_L3_DST_ONLY);
+	if (mask == RTE_ETH_RSS_L3_SRC_ONLY)
+		inset &= ~(I40E_INSET_IPV4_DST | I40E_INSET_IPV6_DST);
+	else if (mask == RTE_ETH_RSS_L3_DST_ONLY)
+		inset &= ~(I40E_INSET_IPV4_SRC | I40E_INSET_IPV6_SRC);
+
+	mask = rss_types & (RTE_ETH_RSS_L4_SRC_ONLY | RTE_ETH_RSS_L4_DST_ONLY);
+	if (mask == RTE_ETH_RSS_L4_SRC_ONLY)
+		inset &= ~I40E_INSET_DST_PORT;
+	else if (mask == RTE_ETH_RSS_L4_DST_ONLY)
+		inset &= ~I40E_INSET_SRC_PORT;
+
+	if (rss_types & I40E_HASH_L4_TYPES) {
+		uint64_t l3_mask = rss_types &
+				   (RTE_ETH_RSS_L3_SRC_ONLY | RTE_ETH_RSS_L3_DST_ONLY);
+		uint64_t l4_mask = rss_types &
+				   (RTE_ETH_RSS_L4_SRC_ONLY | RTE_ETH_RSS_L4_DST_ONLY);
+
+		if (l3_mask && !l4_mask)
+			inset &= ~(I40E_INSET_SRC_PORT | I40E_INSET_DST_PORT);
+		else if (!l3_mask && l4_mask)
+			inset &= ~(I40E_INSET_IPV4_DST | I40E_INSET_IPV6_DST |
+				 I40E_INSET_IPV4_SRC | I40E_INSET_IPV6_SRC);
+	}
+
+	/* SCTP Verification Tag is not required in hash computation for SYMMETRIC_TOEPLITZ */
+	if (symmetric_enable) {
+		mask = rss_types & RTE_ETH_RSS_NONFRAG_IPV4_SCTP;
+		if (mask == RTE_ETH_RSS_NONFRAG_IPV4_SCTP)
+			inset &= ~I40E_INSET_SCTP_VT;
+
+		mask = rss_types & RTE_ETH_RSS_NONFRAG_IPV6_SCTP;
+		if (mask == RTE_ETH_RSS_NONFRAG_IPV6_SCTP)
+			inset &= ~I40E_INSET_SCTP_VT;
+	}
+
+	return inset;
+}
+
+/*
+ * Hash pattern graph implementation
+ * Pattern: START -> ETH -> [VLAN] -> [VLAN] -> (IPv4|IPv6) -> (TCP|UDP|SCTP|ESP|L2TPV3OIP|AH)
+ *          START -> ETH -> [VLAN] -> [VLAN] -> (IPv4|IPv6) frag
+ *          START -> ETH -> [VLAN] -> [VLAN] -> (IPv4|IPv6) -> UDP -> (GTPC|ESP|GTPU)
+ *          START -> ETH -> [VLAN] -> [VLAN] -> (IPv4|IPv6) -> UDP -> GTPU -> (IPv4|IPv6)
+ */
+enum i40e_hash_pattern_node_id {
+	I40E_HASH_PATTERN_NODE_START = RTE_FLOW_NODE_FIRST,
+	I40E_HASH_PATTERN_NODE_ETH,
+	I40E_HASH_PATTERN_NODE_OUTER_VLAN,
+	I40E_HASH_PATTERN_NODE_INNER_VLAN,
+	I40E_HASH_PATTERN_NODE_IPV4,
+	I40E_HASH_PATTERN_NODE_IPV6,
+	I40E_HASH_PATTERN_NODE_IPV6_FRAG,
+	I40E_HASH_PATTERN_NODE_TCP,
+	I40E_HASH_PATTERN_NODE_UDP,
+	I40E_HASH_PATTERN_NODE_SCTP,
+	I40E_HASH_PATTERN_NODE_ESP,
+	I40E_HASH_PATTERN_NODE_GTPU,
+	I40E_HASH_PATTERN_NODE_GTPC,
+	I40E_HASH_PATTERN_NODE_L2TPV3OIP,
+	I40E_HASH_PATTERN_NODE_AH,
+	I40E_HASH_PATTERN_NODE_INNER_IPV4,
+	I40E_HASH_PATTERN_NODE_INNER_IPV6,
+	I40E_HASH_PATTERN_NODE_END,
+	I40E_HASH_PATTERN_NODE_MAX,
+};
+
+static int
+i40e_hash_pattern_node_eth_process(void *ctx,
+		const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_hash_ctx *hash_ctx = ctx;
+	hash_ctx->pctype = I40E_FILTER_PCTYPE_L2_PAYLOAD;
+	return 0;
+}
+
+static int
+i40e_hash_pattern_node_ipv4_process(void *ctx,
+		const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_hash_ctx *hash_ctx = ctx;
+	/* hash parser does not differentiate between frag and non-frag IPv4 until later */
+	hash_ctx->pctype = I40E_FILTER_PCTYPE_NONF_IPV4_OTHER;
+	return 0;
+}
+
+static int
+i40e_hash_pattern_node_ipv6_process(void *ctx,
+		const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_hash_ctx *hash_ctx = ctx;
+	hash_ctx->pctype = I40E_FILTER_PCTYPE_NONF_IPV6_OTHER;
+	return 0;
+}
+
+static int
+i40e_hash_pattern_node_ipv6_frag_process(void *ctx,
+		const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_hash_ctx *hash_ctx = ctx;
+	hash_ctx->pctype = I40E_FILTER_PCTYPE_FRAG_IPV6;
+	return 0;
+}
+
+static int
+i40e_hash_pattern_node_tcp_process(void *ctx,
+		const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_hash_ctx *hash_ctx = ctx;
+	hash_ctx->pctype = (hash_ctx->pctype == I40E_FILTER_PCTYPE_NONF_IPV4_OTHER) ?
+			  I40E_FILTER_PCTYPE_NONF_IPV4_TCP :
+			  I40E_FILTER_PCTYPE_NONF_IPV6_TCP;
+	return 0;
+}
+
+static int
+i40e_hash_pattern_node_udp_process(void *ctx,
+		const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_hash_ctx *hash_ctx = ctx;
+	hash_ctx->pctype = (hash_ctx->pctype == I40E_FILTER_PCTYPE_NONF_IPV4_OTHER) ?
+			  I40E_FILTER_PCTYPE_NONF_IPV4_UDP :
+			  I40E_FILTER_PCTYPE_NONF_IPV6_UDP;
+	return 0;
+}
+
+static int
+i40e_hash_pattern_node_sctp_process(void *ctx,
+		const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_hash_ctx *hash_ctx = ctx;
+	hash_ctx->pctype = (hash_ctx->pctype == I40E_FILTER_PCTYPE_NONF_IPV4_OTHER) ?
+			  I40E_FILTER_PCTYPE_NONF_IPV4_SCTP :
+			  I40E_FILTER_PCTYPE_NONF_IPV6_SCTP;
+	return 0;
+}
+
+static int
+i40e_hash_pattern_node_esp_process(void *ctx,
+		const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_hash_ctx *hash_ctx = ctx;
+	bool ipv4 = false;
+	bool udp = false;
+
+	/* ESP can be over IP or over UDP */
+	ipv4 = (hash_ctx->pctype == I40E_FILTER_PCTYPE_NONF_IPV4_OTHER ||
+		hash_ctx->pctype == I40E_FILTER_PCTYPE_NONF_IPV4_UDP);
+	udp = (hash_ctx->pctype == I40E_FILTER_PCTYPE_NONF_IPV4_UDP ||
+		hash_ctx->pctype == I40E_FILTER_PCTYPE_NONF_IPV6_UDP);
+	if (udp) {
+		hash_ctx->pctype = ipv4 ? I40E_CUSTOMIZED_ESP_IPV4_UDP : I40E_CUSTOMIZED_ESP_IPV6_UDP;
+	} else {
+		hash_ctx->pctype = ipv4 ? I40E_CUSTOMIZED_ESP_IPV4 : I40E_CUSTOMIZED_ESP_IPV6;
+	}
+	hash_ctx->customized_ptype = true;
+	return 0;
+}
+
+static int
+i40e_hash_pattern_node_gtpu_process(void *ctx,
+		const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_hash_ctx *hash_ctx = ctx;
+
+	/* GTPU pctype does not differentiate between IPv4 and IPv6 */
+	hash_ctx->pctype = I40E_CUSTOMIZED_GTPU;
+	hash_ctx->customized_ptype = true;
+	return 0;
+}
+
+static int
+i40e_hash_pattern_node_gtpc_process(void *ctx,
+		const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_hash_ctx *hash_ctx = ctx;
+
+	/* GTPC pctype does not differentiate between IPv4 and IPv6 */
+	hash_ctx->pctype = I40E_CUSTOMIZED_GTPC;
+	hash_ctx->customized_ptype = true;
+	return 0;
+}
+
+static int
+i40e_hash_pattern_node_l2tpv3oip_process(void *ctx,
+		const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_hash_ctx *hash_ctx = ctx;
+	hash_ctx->pctype = (hash_ctx->pctype == I40E_FILTER_PCTYPE_NONF_IPV4_OTHER) ?
+			  I40E_CUSTOMIZED_IPV4_L2TPV3 :
+			  I40E_CUSTOMIZED_IPV6_L2TPV3;
+	hash_ctx->customized_ptype = true;
+	return 0;
+}
+
+static int
+i40e_hash_pattern_node_ah_process(void *ctx,
+		const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_hash_ctx *hash_ctx = ctx;
+
+	hash_ctx->pctype = (hash_ctx->pctype == I40E_FILTER_PCTYPE_NONF_IPV4_OTHER) ?
+			  I40E_CUSTOMIZED_AH_IPV4 :
+			  I40E_CUSTOMIZED_AH_IPV6;
+	hash_ctx->customized_ptype = true;
+	return 0;
+}
+
+static int
+i40e_hash_pattern_node_inner_ipv4_process(void *ctx,
+		const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_hash_ctx *hash_ctx = ctx;
+
+	/* inner IP patterns are always over GTP-U */
+	hash_ctx->pctype = I40E_CUSTOMIZED_GTPU_IPV4;
+	hash_ctx->customized_ptype = true;
+	return 0;
+}
+
+static int
+i40e_hash_pattern_node_inner_ipv6_process(void *ctx,
+		const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_hash_ctx *hash_ctx = ctx;
+
+	/* inner IP patterns are always over GTP-U */
+	hash_ctx->pctype = I40E_CUSTOMIZED_GTPU_IPV6;
+	hash_ctx->customized_ptype = true;
+	return 0;
+}
+
+static int
+i40e_hash_pattern_node_end_process(void *ctx,
+		const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_hash_ctx *hash_ctx = ctx;
+
+	/* if RSS hash type for IPv4 frag was requested, change pctype */
+	if (hash_ctx->pctype == I40E_FILTER_PCTYPE_NONF_IPV4_OTHER &&
+	    (hash_ctx->rss_conf.conf.types & RTE_ETH_RSS_FRAG_IPV4))
+		hash_ctx->pctype = I40E_FILTER_PCTYPE_FRAG_IPV4;
+
+	return 0;
+}
+
+const struct rte_flow_graph i40e_hash_pattern_graph = {
+	.nodes = (struct rte_flow_graph_node[]) {
+		[I40E_HASH_PATTERN_NODE_START] = {
+			.name = "START",
+		},
+		[I40E_HASH_PATTERN_NODE_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+			.process = i40e_hash_pattern_node_eth_process,
+		},
+		[I40E_HASH_PATTERN_NODE_OUTER_VLAN] = {
+			.name = "OUTER_VLAN",
+			.type = RTE_FLOW_ITEM_TYPE_VLAN,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+		},
+		[I40E_HASH_PATTERN_NODE_INNER_VLAN] = {
+			.name = "INNER_VLAN",
+			.type = RTE_FLOW_ITEM_TYPE_VLAN,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+		},
+		[I40E_HASH_PATTERN_NODE_IPV4] = {
+			.name = "IPv4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+			.process = i40e_hash_pattern_node_ipv4_process,
+		},
+		[I40E_HASH_PATTERN_NODE_IPV6] = {
+			.name = "IPv6",
+			.type = RTE_FLOW_ITEM_TYPE_IPV6,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+			.process = i40e_hash_pattern_node_ipv6_process,
+		},
+		[I40E_HASH_PATTERN_NODE_IPV6_FRAG] = {
+			.name = "IPv6_FRAG",
+			.type = RTE_FLOW_ITEM_TYPE_IPV6,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+			.process = i40e_hash_pattern_node_ipv6_frag_process,
+		},
+		[I40E_HASH_PATTERN_NODE_TCP] = {
+			.name = "TCP",
+			.type = RTE_FLOW_ITEM_TYPE_TCP,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+			.process = i40e_hash_pattern_node_tcp_process,
+		},
+		[I40E_HASH_PATTERN_NODE_UDP] = {
+			.name = "UDP",
+			.type = RTE_FLOW_ITEM_TYPE_UDP,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+			.process = i40e_hash_pattern_node_udp_process,
+		},
+		[I40E_HASH_PATTERN_NODE_SCTP] = {
+			.name = "SCTP",
+			.type = RTE_FLOW_ITEM_TYPE_SCTP,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+			.process = i40e_hash_pattern_node_sctp_process,
+		},
+		[I40E_HASH_PATTERN_NODE_ESP] = {
+			.name = "ESP",
+			.type = RTE_FLOW_ITEM_TYPE_ESP,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+			.process = i40e_hash_pattern_node_esp_process,
+		},
+		[I40E_HASH_PATTERN_NODE_GTPU] = {
+			.name = "GTPU",
+			.type = RTE_FLOW_ITEM_TYPE_GTPU,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+			.process = i40e_hash_pattern_node_gtpu_process,
+		},
+		[I40E_HASH_PATTERN_NODE_GTPC] = {
+			.name = "GTPC",
+			.type = RTE_FLOW_ITEM_TYPE_GTPC,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+			.process = i40e_hash_pattern_node_gtpc_process,
+		},
+		[I40E_HASH_PATTERN_NODE_L2TPV3OIP] = {
+			.name = "L2TPV3OIP",
+			.type = RTE_FLOW_ITEM_TYPE_L2TPV3OIP,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+			.process = i40e_hash_pattern_node_l2tpv3oip_process,
+		},
+		[I40E_HASH_PATTERN_NODE_AH] = {
+			.name = "AH",
+			.type = RTE_FLOW_ITEM_TYPE_AH,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+			.process = i40e_hash_pattern_node_ah_process,
+		},
+		[I40E_HASH_PATTERN_NODE_INNER_IPV4] = {
+			.name = "INNER_IPV4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+			.process = i40e_hash_pattern_node_inner_ipv4_process,
+		},
+		[I40E_HASH_PATTERN_NODE_INNER_IPV6] = {
+			.name = "INNER_IPV6",
+			.type = RTE_FLOW_ITEM_TYPE_IPV6,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+			.process = i40e_hash_pattern_node_inner_ipv6_process,
+		},
+		[I40E_HASH_PATTERN_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+			.process = i40e_hash_pattern_node_end_process,
+		},
+	},
+	.edges = (struct rte_flow_graph_edge[]) {
+		[I40E_HASH_PATTERN_NODE_START] = {
+			.next = (const size_t[]) {
+				I40E_HASH_PATTERN_NODE_ETH,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_HASH_PATTERN_NODE_ETH] = {
+			.next = (const size_t[]) {
+				I40E_HASH_PATTERN_NODE_OUTER_VLAN,
+				I40E_HASH_PATTERN_NODE_IPV4,
+				I40E_HASH_PATTERN_NODE_IPV6,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_HASH_PATTERN_NODE_OUTER_VLAN] = {
+			.next = (const size_t[]) {
+				I40E_HASH_PATTERN_NODE_INNER_VLAN,
+				I40E_HASH_PATTERN_NODE_IPV4,
+				I40E_HASH_PATTERN_NODE_IPV6,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_HASH_PATTERN_NODE_INNER_VLAN] = {
+			.next = (const size_t[]) {
+				I40E_HASH_PATTERN_NODE_IPV4,
+				I40E_HASH_PATTERN_NODE_IPV6,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_HASH_PATTERN_NODE_IPV4] = {
+			.next = (const size_t[]) {
+				I40E_HASH_PATTERN_NODE_TCP,
+				I40E_HASH_PATTERN_NODE_UDP,
+				I40E_HASH_PATTERN_NODE_SCTP,
+				I40E_HASH_PATTERN_NODE_ESP,
+				I40E_HASH_PATTERN_NODE_L2TPV3OIP,
+				I40E_HASH_PATTERN_NODE_AH,
+			}
+		},
+		[I40E_HASH_PATTERN_NODE_IPV6] = {
+			.next = (const size_t[]) {
+				I40E_HASH_PATTERN_NODE_IPV6_FRAG,
+				I40E_HASH_PATTERN_NODE_TCP,
+				I40E_HASH_PATTERN_NODE_UDP,
+				I40E_HASH_PATTERN_NODE_SCTP,
+				I40E_HASH_PATTERN_NODE_ESP,
+				I40E_HASH_PATTERN_NODE_L2TPV3OIP,
+				I40E_HASH_PATTERN_NODE_AH,
+			}
+		},
+		[I40E_HASH_PATTERN_NODE_IPV6_FRAG] = {
+			.next = (const size_t[]) {
+				I40E_HASH_PATTERN_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_HASH_PATTERN_NODE_TCP] = {
+			.next = (const size_t[]) {
+				I40E_HASH_PATTERN_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_HASH_PATTERN_NODE_UDP] = {
+			.next = (const size_t[]) {
+				I40E_HASH_PATTERN_NODE_GTPU,
+				I40E_HASH_PATTERN_NODE_GTPC,
+				I40E_HASH_PATTERN_NODE_ESP,
+				I40E_HASH_PATTERN_NODE_END,
+			}
+		},
+		[I40E_HASH_PATTERN_NODE_SCTP] = {
+			.next = (const size_t[]) {
+				I40E_HASH_PATTERN_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_HASH_PATTERN_NODE_ESP] = {
+			.next = (const size_t[]) {
+				I40E_HASH_PATTERN_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_HASH_PATTERN_NODE_GTPU] = {
+			.next = (const size_t[]) {
+				I40E_HASH_PATTERN_NODE_INNER_IPV4,
+				I40E_HASH_PATTERN_NODE_INNER_IPV6,
+				I40E_HASH_PATTERN_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_HASH_PATTERN_NODE_GTPC] = {
+			.next = (const size_t[]) {
+				I40E_HASH_PATTERN_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_HASH_PATTERN_NODE_L2TPV3OIP] = {
+			.next = (const size_t[]) {
+				I40E_HASH_PATTERN_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_HASH_PATTERN_NODE_AH] = {
+			.next = (const size_t[]) {
+				I40E_HASH_PATTERN_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_HASH_PATTERN_NODE_INNER_IPV4] = {
+			.next = (const size_t[]) {
+				I40E_HASH_PATTERN_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_HASH_PATTERN_NODE_INNER_IPV6] = {
+			.next = (const size_t[]) {
+				I40E_HASH_PATTERN_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+/*
+ * Hash VLAN graph implementation
+ * Pattern: START -> VLAN -> END
+ */
+enum i40e_hash_vlan_node_id {
+	I40E_HASH_VLAN_NODE_START = RTE_FLOW_NODE_FIRST,
+	I40E_HASH_VLAN_NODE_VLAN,
+	I40E_HASH_VLAN_NODE_END,
+	I40E_HASH_VLAN_NODE_MAX,
+};
+
+static int
+i40e_hash_node_vlan_validate(const void *ctx __rte_unused, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_item_vlan *vlan_mask = item->mask;
+
+	/* for mask, VLAN/TCI must be masked appropriately */
+	if (rte_be_to_cpu_16(vlan_mask->hdr.vlan_tci) != I40E_VLAN_TCI_MASK) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid VLAN mask");
+	}
+	return 0;
+}
+
+static int
+i40e_hash_node_vlan_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_hash_ctx *hash_ctx = ctx;
+	const struct rte_flow_item_vlan *vlan_spec = item->spec;
+
+	hash_ctx->rss_conf.region_priority = rte_cpu_to_be_16(vlan_spec->hdr.vlan_tci) >> 13;
+
+	return 0;
+}
+
+const struct rte_flow_graph i40e_hash_vlan_graph = {
+	.nodes = (struct rte_flow_graph_node[]) {
+		[I40E_HASH_VLAN_NODE_START] = {
+			.name = "START",
+		},
+		[I40E_HASH_VLAN_NODE_VLAN] = {
+			.name = "VLAN",
+			.type = RTE_FLOW_ITEM_TYPE_VLAN,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_hash_node_vlan_validate,
+			.process = i40e_hash_node_vlan_process,
+		},
+	},
+	.edges = (struct rte_flow_graph_edge[]) {
+		[I40E_HASH_VLAN_NODE_START] = {
+			.next = (const size_t[]) {
+				I40E_HASH_VLAN_NODE_VLAN,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_HASH_VLAN_NODE_VLAN] = {
+			.next = (const size_t[]) {
+				I40E_HASH_VLAN_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+static bool
+i40e_hash_validate_rss_types(uint64_t rss_types)
+{
+	uint64_t type, mask;
+
+	/* Validate L2 */
+	type = RTE_ETH_RSS_ETH & rss_types;
+	mask = (RTE_ETH_RSS_L2_SRC_ONLY | RTE_ETH_RSS_L2_DST_ONLY) & rss_types;
+	if (!type && mask)
+		return false;
+
+	/* Validate L3 */
+	type = (I40E_HASH_L4_TYPES | RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_FRAG_IPV4 |
+	       RTE_ETH_RSS_NONFRAG_IPV4_OTHER | RTE_ETH_RSS_IPV6 |
+	       RTE_ETH_RSS_FRAG_IPV6 | RTE_ETH_RSS_NONFRAG_IPV6_OTHER) & rss_types;
+	mask = (RTE_ETH_RSS_L3_SRC_ONLY | RTE_ETH_RSS_L3_DST_ONLY) & rss_types;
+	if (!type && mask)
+		return false;
+
+	/* Validate L4 */
+	type = (I40E_HASH_L4_TYPES | RTE_ETH_RSS_PORT) & rss_types;
+	mask = (RTE_ETH_RSS_L4_SRC_ONLY | RTE_ETH_RSS_L4_DST_ONLY) & rss_types;
+	if (!type && mask)
+		return false;
+
+	return true;
+}
+
+static int
+i40e_hash_validate_rss_common(const struct rte_flow_action_rss *rss_act,
+		struct rte_flow_error *error)
+{
+	/* symmetric toeplitz is only supported when a specific pattern is provided */
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
+i40e_hash_pattern_rss_check(const struct ci_flow_actions *actions,
+		const struct ci_flow_actions_check_param *param __rte_unused,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_action_rss *rss_act = actions->actions[0]->conf;
+
+	/* queue list is not supported */
+	if (rss_act->queue_num == 0) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+				"RSS queues not supported when pattern specified");
+	}
+
+	/* disallow unsupported hash functions */
+	switch (rss_act->func) {
+	case RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ:
+	case RTE_ETH_HASH_FUNCTION_DEFAULT:
+	case RTE_ETH_HASH_FUNCTION_TOEPLITZ:
+	case RTE_ETH_HASH_FUNCTION_SIMPLE_XOR:
+		break;
+	default:
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+				"RSS hash function not supported when pattern specified");
+	}
+
+	if (!i40e_hash_validate_rss_types(rss_act->types))
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF,
+				rss_act, "RSS types are invalid");
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
+i40e_hash_pattern_ctx_parse(const struct rte_flow_action actions[],
+		const struct rte_flow_attr *attr,
+		struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	struct i40e_hash_ctx *hash_ctx = (struct i40e_hash_ctx *)ctx;
+	struct ci_flow_actions parsed_actions = {0};
+	struct ci_flow_actions_check_param param = {
+		.allowed_types = (enum rte_flow_action_type[]) {
+			RTE_FLOW_ACTION_TYPE_RSS,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.max_actions = 1,
+		.driver_ctx = ctx->dev,
+		.check = i40e_hash_pattern_rss_check,
+	};
+	const struct rte_flow_action_rss *rss_act;
+	int ret;
+
+	ret = ci_flow_check_attr(attr, NULL, error);
+	if (ret != 0)
+		return ret;
+
+	ret = ci_flow_check_actions(actions, &param, &parsed_actions, error);
+	if (ret != 0)
+		return ret;
+
+	rss_act = parsed_actions.actions[0]->conf;
+
+	hash_ctx->rss_conf.symmetric_enable =
+			rss_act->func == RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ;
+	hash_ctx->rss_conf.conf.func = rss_act->func;
+	hash_ctx->rss_conf.conf.types = rss_act->types;
+
+	if (rss_act->key_len != 0) {
+		memcpy(hash_ctx->rss_conf.key, rss_act->key, I40E_RSS_KEY_LEN);
+		hash_ctx->rss_conf.conf.key = hash_ctx->rss_conf.key;
+		hash_ctx->rss_conf.conf.key_len = rss_act->key_len;
+	}
+
+	hash_ctx->rss_conf.inset = i40e_hash_get_inset(rss_act->types,
+			hash_ctx->rss_conf.symmetric_enable);
+
+	return 0;
+}
+
+static uint64_t
+i40e_hash_get_x722_ext_pctypes(uint8_t match_pctype)
+{
+	uint64_t pctypes = 0;
+
+	switch (match_pctype) {
+	case I40E_FILTER_PCTYPE_NONF_IPV4_TCP:
+		pctypes = BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV4_TCP_SYN_NO_ACK);
+		break;
+
+	case I40E_FILTER_PCTYPE_NONF_IPV4_UDP:
+		pctypes = BIT_ULL(I40E_FILTER_PCTYPE_NONF_UNICAST_IPV4_UDP) |
+			  BIT_ULL(I40E_FILTER_PCTYPE_NONF_MULTICAST_IPV4_UDP);
+		break;
+
+	case I40E_FILTER_PCTYPE_NONF_IPV6_TCP:
+		pctypes = BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV6_TCP_SYN_NO_ACK);
+		break;
+
+	case I40E_FILTER_PCTYPE_NONF_IPV6_UDP:
+		pctypes = BIT_ULL(I40E_FILTER_PCTYPE_NONF_UNICAST_IPV6_UDP) |
+			  BIT_ULL(I40E_FILTER_PCTYPE_NONF_MULTICAST_IPV6_UDP);
+		break;
+	}
+
+	return pctypes;
+}
+
+static int
+i40e_hash_translate_gtp_inset(struct i40e_rte_flow_rss_conf *rss_conf,
+			      struct rte_flow_error *error)
+{
+	if (rss_conf->inset &
+	    (I40E_INSET_IPV4_SRC | I40E_INSET_IPV6_SRC |
+	    I40E_INSET_DST_PORT | I40E_INSET_SRC_PORT))
+		return rte_flow_error_set(error, ENOTSUP,
+					  RTE_FLOW_ERROR_TYPE_ACTION_CONF,
+					  NULL,
+					  "Only support external destination IP");
+
+	if (rss_conf->inset & I40E_INSET_IPV4_DST)
+		rss_conf->inset = (rss_conf->inset & ~I40E_INSET_IPV4_DST) |
+				  I40E_INSET_TUNNEL_IPV4_DST;
+
+	if (rss_conf->inset & I40E_INSET_IPV6_DST)
+		rss_conf->inset = (rss_conf->inset & ~I40E_INSET_IPV6_DST) |
+				  I40E_INSET_TUNNEL_IPV6_DST;
+
+	return 0;
+}
+
+static int
+i40e_hash_pattern_ctx_validate(struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(ctx->dev->data->dev_private);
+	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(ctx->dev->data->dev_private);
+	struct i40e_hash_ctx *hash_ctx = (struct i40e_hash_ctx *)ctx;
+	const struct hash_type_to_pattern {
+		uint32_t pctype;
+		uint64_t valid_rss_flags;
+	} valid_pctype_to_pattern[] = {
+		/* Ether */
+		{I40E_FILTER_PCTYPE_L2_PAYLOAD, I40E_HASH_L2_RSS_MASK | RTE_ETH_RSS_L2_PAYLOAD},
+		/* IP */
+		{I40E_FILTER_PCTYPE_NONF_IPV4_OTHER, RTE_ETH_RSS_NONFRAG_IPV4_OTHER | I40E_HASH_IPV4_L23_RSS_MASK},
+		{I40E_FILTER_PCTYPE_NONF_IPV6_OTHER, RTE_ETH_RSS_NONFRAG_IPV6_OTHER | I40E_HASH_IPV6_L23_RSS_MASK},
+		/* IP fragmented */
+		{I40E_FILTER_PCTYPE_FRAG_IPV4, RTE_ETH_RSS_FRAG_IPV4 | I40E_HASH_IPV4_L23_RSS_MASK},
+		{I40E_FILTER_PCTYPE_FRAG_IPV6, RTE_ETH_RSS_FRAG_IPV6 | I40E_HASH_IPV6_L23_RSS_MASK},
+		/* TCP */
+		{I40E_FILTER_PCTYPE_NONF_IPV4_TCP, RTE_ETH_RSS_NONFRAG_IPV4_TCP | I40E_HASH_IPV4_L234_RSS_MASK},
+		{I40E_FILTER_PCTYPE_NONF_IPV6_TCP, RTE_ETH_RSS_NONFRAG_IPV6_TCP | I40E_HASH_IPV6_L234_RSS_MASK},
+		/* UDP */
+		{I40E_FILTER_PCTYPE_NONF_IPV4_UDP, RTE_ETH_RSS_NONFRAG_IPV4_UDP | I40E_HASH_IPV4_L234_RSS_MASK},
+		{I40E_FILTER_PCTYPE_NONF_IPV6_UDP, RTE_ETH_RSS_NONFRAG_IPV6_UDP | I40E_HASH_IPV6_L234_RSS_MASK},
+		/* SCTP */
+		{I40E_FILTER_PCTYPE_NONF_IPV4_SCTP, RTE_ETH_RSS_NONFRAG_IPV4_SCTP | I40E_HASH_IPV4_L234_RSS_MASK},
+		{I40E_FILTER_PCTYPE_NONF_IPV6_SCTP, RTE_ETH_RSS_NONFRAG_IPV6_SCTP | I40E_HASH_IPV6_L234_RSS_MASK},
+		/* AH */
+		{I40E_CUSTOMIZED_AH_IPV4, RTE_ETH_RSS_AH},
+		{I40E_CUSTOMIZED_AH_IPV6, RTE_ETH_RSS_AH},
+		/* L2TPV3 */
+		{I40E_CUSTOMIZED_IPV4_L2TPV3, RTE_ETH_RSS_L2TPV3},
+		{I40E_CUSTOMIZED_IPV6_L2TPV3, RTE_ETH_RSS_L2TPV3},
+		/* ESP */
+		{I40E_CUSTOMIZED_ESP_IPV4, RTE_ETH_RSS_ESP},
+		{I40E_CUSTOMIZED_ESP_IPV6, RTE_ETH_RSS_ESP},
+		{I40E_CUSTOMIZED_ESP_IPV4_UDP, RTE_ETH_RSS_ESP},
+		{I40E_CUSTOMIZED_ESP_IPV6_UDP, RTE_ETH_RSS_ESP},
+		/* GTPC */
+		{I40E_CUSTOMIZED_GTPC, I40E_HASH_IPV4_L234_RSS_MASK},
+		{I40E_CUSTOMIZED_GTPC, I40E_HASH_IPV6_L234_RSS_MASK},
+		/* GTPU */
+		{I40E_CUSTOMIZED_GTPU, I40E_HASH_IPV4_L234_RSS_MASK},
+		{I40E_CUSTOMIZED_GTPU, I40E_HASH_IPV6_L234_RSS_MASK},
+		/* IP over GTPU */
+		{I40E_CUSTOMIZED_GTPU_IPV4, RTE_ETH_RSS_GTPU},
+		{I40E_CUSTOMIZED_GTPU_IPV6, RTE_ETH_RSS_GTPU},
+	};
+	size_t i;
+
+	for (i = 0; i < RTE_DIM(valid_pctype_to_pattern); i++) {
+		uint32_t pctype = valid_pctype_to_pattern[i].pctype;
+		uint64_t flags = valid_pctype_to_pattern[i].valid_rss_flags;
+
+		if (pctype != hash_ctx->pctype)
+			continue;
+
+		/* find if our ptype works with specified RSS types */
+		if ((hash_ctx->rss_conf.conf.types & ~flags) != 0) {
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ACTION_CONF, &hash_ctx->rss_conf.conf,
+					"Some RSS types are not supported for the specified pattern");
+		}
+
+		/* for customized pctypes, find if it's supported */
+		if (hash_ctx->customized_ptype) {
+			struct i40e_customized_pctype *ct;
+
+			ct = i40e_find_customized_pctype(pf, pctype);
+
+			if (ct == NULL || !ct->valid) {
+				return rte_flow_error_set(error, EINVAL,
+						RTE_FLOW_ERROR_TYPE_ACTION_CONF, &hash_ctx->rss_conf.conf,
+						"Specified pattern is not supported by the device");
+			}
+			hash_ctx->rss_conf.config_pctypes |= BIT_ULL(ct->pctype);
+
+			/* GTPC/GTPU endpoints require special handling */
+			return i40e_hash_translate_gtp_inset(&hash_ctx->rss_conf, error);
+		} else {
+			hash_ctx->rss_conf.config_pctypes |= BIT_ULL(pctype);
+
+			/* X722 needs special handling */
+			if (hw->mac.type == I40E_MAC_X722) {
+				uint64_t types = i40e_hash_get_x722_ext_pctypes(pctype);
+				hash_ctx->rss_conf.config_pctypes |= types;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int
+i40e_hash_queue_region_check(const struct ci_flow_actions *actions,
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
+i40e_hash_vlan_ctx_parse(const struct rte_flow_action actions[],
+		const struct rte_flow_attr *attr,
+		struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	struct i40e_hash_ctx *hash_ctx = (struct i40e_hash_ctx *)ctx;
+	struct ci_flow_actions parsed_actions = {0};
+	struct ci_flow_actions_check_param param = {
+		.allowed_types = (enum rte_flow_action_type[]) {
+			RTE_FLOW_ACTION_TYPE_RSS,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.max_actions = 1,
+		.driver_ctx = ctx->dev,
+		.check = i40e_hash_queue_region_check,
+	};
+	const struct rte_flow_action_rss *rss_act;
+	int ret;
+
+	ret = ci_flow_check_attr(attr, NULL, error);
+	if (ret != 0)
+		return ret;
+
+	ret = ci_flow_check_actions(actions, &param, &parsed_actions, error);
+	if (ret != 0)
+		return ret;
+
+	rss_act = parsed_actions.actions[0]->conf;
+	hash_ctx->rss_conf.conf.func = rss_act->func;
+	hash_ctx->rss_conf.region_queue_num = rss_act->queue_num;
+	hash_ctx->rss_conf.region_queue_start = rss_act->queue[0];
+
+	return 0;
+}
+
+static int
+i40e_hash_queue_list_check(const struct ci_flow_actions *actions,
+		const struct ci_flow_actions_check_param *param,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_action_rss *rss_act = actions->actions[0]->conf;
+	struct rte_eth_dev *dev = param->driver_ctx;
+	struct i40e_pf *pf;
+	struct i40e_hw *hw;
+	uint16_t max_queue;
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
+}
+
+static int
+i40e_hash_empty_ctx_parse(const struct rte_flow_action actions[],
+		const struct rte_flow_attr *attr,
+		struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	struct i40e_hash_ctx *hash_ctx = (struct i40e_hash_ctx *)ctx;
+	struct ci_flow_actions parsed_actions = {0};
+	struct ci_flow_actions_check_param param = {
+		.allowed_types = (enum rte_flow_action_type[]) {
+			RTE_FLOW_ACTION_TYPE_RSS,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.max_actions = 1,
+		.driver_ctx = ctx->dev,
+		.check = i40e_hash_queue_list_check,
+	};
+	const struct rte_flow_action_rss *rss_act;
+	int ret;
+
+	ret = ci_flow_check_attr(attr, NULL, error);
+	if (ret != 0)
+		return ret;
+
+	ret = ci_flow_check_actions(actions, &param, &parsed_actions, error);
+	if (ret != 0)
+		return ret;
+
+	rss_act = parsed_actions.actions[0]->conf;
+	hash_ctx->rss_conf.conf.func = rss_act->func;
+
+	/* if we have queues, copy them */
+	if (rss_act->queue_num > 0) {
+		memcpy(hash_ctx->rss_conf.queue,
+				rss_act->queue,
+				rss_act->queue_num * sizeof(hash_ctx->rss_conf.queue[0]));
+		hash_ctx->rss_conf.conf.queue = hash_ctx->rss_conf.queue;
+		hash_ctx->rss_conf.conf.queue_num = rss_act->queue_num;
+	/* if we have key, copy it */
+	} else if (rss_act->key_len > 0) {
+		memcpy(hash_ctx->rss_conf.key,
+				rss_act->key,
+				rss_act->key_len);
+		hash_ctx->rss_conf.conf.key = hash_ctx->rss_conf.key;
+		hash_ctx->rss_conf.conf.key_len = rss_act->key_len;
+	}
+
+	return 0;
+}
+
+static int
+i40e_hash_ctx_to_flow(const struct ci_flow_engine_ctx *ctx,
+		struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct i40e_hash_ctx *hash_ctx = (const struct i40e_hash_ctx *)ctx;
+	struct i40e_flow_engine_hash_flow *hash_flow = (struct i40e_flow_engine_hash_flow *)flow;
+
+	hash_flow->rss_conf = hash_ctx->rss_conf;
+
+	return 0;
+}
+
+static int
+i40e_hash_flow_install(struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_flow_engine_hash_flow *hash_flow = (struct i40e_flow_engine_hash_flow *)flow;
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(flow->dev->data->dev_private);
+	int ret;
+
+	ret = i40e_hash_filter_create(pf, &hash_flow->rss_conf);
+	if (ret < 0) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, flow,
+				"Failed to create hash filter");
+	}
+	return 0;
+}
+
+static int
+i40e_hash_flow_uninstall(struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_flow_engine_hash_flow *hash_flow = (struct i40e_flow_engine_hash_flow *)flow;
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(flow->dev->data->dev_private);
+	int ret;
+
+	ret = i40e_hash_filter_destroy(pf, &hash_flow->rss_conf);
+	if (ret < 0) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, flow,
+				"Failed to destroy hash filter");
+	}
+	return 0;
+}
+
+static int
+i40e_hash_flow_query(struct ci_flow *flow,
+		const struct rte_flow_action *action,
+		void *data,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_flow_engine_hash_flow *hash_flow = (struct i40e_flow_engine_hash_flow *)flow;
+	struct i40e_rte_flow_rss_conf *rss_conf = data;
+
+	if (action->type != RTE_FLOW_ACTION_TYPE_RSS) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, action,
+				"Unsupported action for query");
+	}
+
+	memcpy(rss_conf, &hash_flow->rss_conf, sizeof(*rss_conf));
+	return 0;
+}
+
+const struct ci_flow_engine_ops i40e_flow_engine_hash_pattern_ops = {
+	.ctx_parse = i40e_hash_pattern_ctx_parse,
+	.ctx_validate = i40e_hash_pattern_ctx_validate,
+	.ctx_to_flow = i40e_hash_ctx_to_flow,
+	.flow_install = i40e_hash_flow_install,
+	.flow_uninstall = i40e_hash_flow_uninstall,
+	.flow_query = i40e_hash_flow_query,
+};
+
+const struct ci_flow_engine_ops i40e_flow_engine_hash_vlan_ops = {
+	.ctx_parse = i40e_hash_vlan_ctx_parse,
+	.ctx_to_flow = i40e_hash_ctx_to_flow,
+	.flow_install = i40e_hash_flow_install,
+	.flow_uninstall = i40e_hash_flow_uninstall,
+	.flow_query = i40e_hash_flow_query,
+};
+
+const struct ci_flow_engine_ops i40e_flow_engine_hash_empty_ops = {
+	.ctx_parse = i40e_hash_empty_ctx_parse,
+	.ctx_to_flow = i40e_hash_ctx_to_flow,
+	.flow_install = i40e_hash_flow_install,
+	.flow_uninstall = i40e_hash_flow_uninstall,
+	.flow_query = i40e_hash_flow_query,
+};
+
+const struct ci_flow_engine i40e_flow_engine_hash_pattern = {
+	.name = "i40e_hash_pattern",
+	.type = I40E_FLOW_ENGINE_TYPE_HASH_PATTERN,
+	.ops = &i40e_flow_engine_hash_pattern_ops,
+	.graph = &i40e_hash_pattern_graph,
+	.ctx_size = sizeof(struct i40e_hash_ctx),
+	.flow_size = sizeof(struct i40e_flow_engine_hash_flow),
+};
+
+const struct ci_flow_engine i40e_flow_engine_hash_vlan = {
+	.name = "i40e_hash_vlan",
+	.type = I40E_FLOW_ENGINE_TYPE_HASH_VLAN,
+	.ops = &i40e_flow_engine_hash_vlan_ops,
+	.graph = &i40e_hash_vlan_graph,
+	.ctx_size = sizeof(struct i40e_hash_ctx),
+	.flow_size = sizeof(struct i40e_flow_engine_hash_flow),
+};
+
+const struct ci_flow_engine i40e_flow_engine_hash_empty = {
+	.name = "i40e_hash_empty",
+	.type = I40E_FLOW_ENGINE_TYPE_HASH_EMPTY,
+	.ops = &i40e_flow_engine_hash_empty_ops,
+	.ctx_size = sizeof(struct i40e_hash_ctx),
+	.flow_size = sizeof(struct i40e_flow_engine_hash_flow),
+};
diff --git a/drivers/net/intel/i40e/i40e_hash.c b/drivers/net/intel/i40e/i40e_hash.c
index 4379ef2be8..e416465713 100644
--- a/drivers/net/intel/i40e/i40e_hash.c
+++ b/drivers/net/intel/i40e/i40e_hash.c
@@ -17,224 +17,6 @@
 #include "i40e_hash.h"
 
 #include "../common/flow_check.h"
-
-#ifndef BIT
-#define BIT(n)				(1UL << (n))
-#endif
-
-#ifndef BIT_ULL
-#define BIT_ULL(n)			(1ULL << (n))
-#endif
-
-/* Pattern item headers */
-#define I40E_HASH_HDR_ETH		0x01ULL
-#define I40E_HASH_HDR_IPV4		0x10ULL
-#define I40E_HASH_HDR_IPV6		0x20ULL
-#define I40E_HASH_HDR_IPV6_FRAG		0x40ULL
-#define I40E_HASH_HDR_TCP		0x100ULL
-#define I40E_HASH_HDR_UDP		0x200ULL
-#define I40E_HASH_HDR_SCTP		0x400ULL
-#define I40E_HASH_HDR_ESP		0x10000ULL
-#define I40E_HASH_HDR_L2TPV3		0x20000ULL
-#define I40E_HASH_HDR_AH		0x40000ULL
-#define I40E_HASH_HDR_GTPC		0x100000ULL
-#define I40E_HASH_HDR_GTPU		0x200000ULL
-
-#define I40E_HASH_HDR_INNER_SHIFT	32
-#define I40E_HASH_HDR_IPV4_INNER	(I40E_HASH_HDR_IPV4 << \
-					I40E_HASH_HDR_INNER_SHIFT)
-#define I40E_HASH_HDR_IPV6_INNER	(I40E_HASH_HDR_IPV6 << \
-					I40E_HASH_HDR_INNER_SHIFT)
-
-/* ETH */
-#define I40E_PHINT_ETH			I40E_HASH_HDR_ETH
-
-/* IPv4 */
-#define I40E_PHINT_IPV4			(I40E_HASH_HDR_ETH | I40E_HASH_HDR_IPV4)
-#define I40E_PHINT_IPV4_TCP		(I40E_PHINT_IPV4 | I40E_HASH_HDR_TCP)
-#define I40E_PHINT_IPV4_UDP		(I40E_PHINT_IPV4 | I40E_HASH_HDR_UDP)
-#define I40E_PHINT_IPV4_SCTP		(I40E_PHINT_IPV4 | I40E_HASH_HDR_SCTP)
-
-/* IPv6 */
-#define I40E_PHINT_IPV6			(I40E_HASH_HDR_ETH | I40E_HASH_HDR_IPV6)
-#define I40E_PHINT_IPV6_FRAG		(I40E_PHINT_IPV6 | \
-					 I40E_HASH_HDR_IPV6_FRAG)
-#define I40E_PHINT_IPV6_TCP		(I40E_PHINT_IPV6 | I40E_HASH_HDR_TCP)
-#define I40E_PHINT_IPV6_UDP		(I40E_PHINT_IPV6 | I40E_HASH_HDR_UDP)
-#define I40E_PHINT_IPV6_SCTP		(I40E_PHINT_IPV6 | I40E_HASH_HDR_SCTP)
-
-/* ESP */
-#define I40E_PHINT_IPV4_ESP		(I40E_PHINT_IPV4 | I40E_HASH_HDR_ESP)
-#define I40E_PHINT_IPV6_ESP		(I40E_PHINT_IPV6 | I40E_HASH_HDR_ESP)
-#define I40E_PHINT_IPV4_UDP_ESP		(I40E_PHINT_IPV4_UDP | \
-					I40E_HASH_HDR_ESP)
-#define I40E_PHINT_IPV6_UDP_ESP		(I40E_PHINT_IPV6_UDP | \
-					I40E_HASH_HDR_ESP)
-
-/* GTPC */
-#define I40E_PHINT_IPV4_GTPC		(I40E_PHINT_IPV4_UDP | \
-					I40E_HASH_HDR_GTPC)
-#define I40E_PHINT_IPV6_GTPC		(I40E_PHINT_IPV6_UDP | \
-					I40E_HASH_HDR_GTPC)
-
-/* GTPU */
-#define I40E_PHINT_IPV4_GTPU		(I40E_PHINT_IPV4_UDP | \
-					I40E_HASH_HDR_GTPU)
-#define I40E_PHINT_IPV4_GTPU_IPV4	(I40E_PHINT_IPV4_GTPU | \
-					I40E_HASH_HDR_IPV4_INNER)
-#define I40E_PHINT_IPV4_GTPU_IPV6	(I40E_PHINT_IPV4_GTPU | \
-					I40E_HASH_HDR_IPV6_INNER)
-#define I40E_PHINT_IPV6_GTPU		(I40E_PHINT_IPV6_UDP | \
-					I40E_HASH_HDR_GTPU)
-#define I40E_PHINT_IPV6_GTPU_IPV4	(I40E_PHINT_IPV6_GTPU | \
-					I40E_HASH_HDR_IPV4_INNER)
-#define I40E_PHINT_IPV6_GTPU_IPV6	(I40E_PHINT_IPV6_GTPU | \
-					I40E_HASH_HDR_IPV6_INNER)
-
-/* L2TPV3 */
-#define I40E_PHINT_IPV4_L2TPV3		(I40E_PHINT_IPV4 | I40E_HASH_HDR_L2TPV3)
-#define I40E_PHINT_IPV6_L2TPV3		(I40E_PHINT_IPV6 | I40E_HASH_HDR_L2TPV3)
-
-/* AH */
-#define I40E_PHINT_IPV4_AH		(I40E_PHINT_IPV4 | I40E_HASH_HDR_AH)
-#define I40E_PHINT_IPV6_AH		(I40E_PHINT_IPV6 | I40E_HASH_HDR_AH)
-
-/* Structure of mapping RSS type to input set */
-struct i40e_hash_map_rss_inset {
-	uint64_t rss_type;
-	uint64_t inset;
-};
-
-const struct i40e_hash_map_rss_inset i40e_hash_rss_inset[] = {
-	/* IPv4 */
-	{ RTE_ETH_RSS_IPV4, I40E_INSET_IPV4_SRC | I40E_INSET_IPV4_DST },
-	{ RTE_ETH_RSS_FRAG_IPV4, I40E_INSET_IPV4_SRC | I40E_INSET_IPV4_DST },
-
-	{ RTE_ETH_RSS_NONFRAG_IPV4_OTHER,
-	  I40E_INSET_IPV4_SRC | I40E_INSET_IPV4_DST },
-
-	{ RTE_ETH_RSS_NONFRAG_IPV4_TCP, I40E_INSET_IPV4_SRC | I40E_INSET_IPV4_DST |
-	  I40E_INSET_SRC_PORT | I40E_INSET_DST_PORT },
-
-	{ RTE_ETH_RSS_NONFRAG_IPV4_UDP, I40E_INSET_IPV4_SRC | I40E_INSET_IPV4_DST |
-	  I40E_INSET_SRC_PORT | I40E_INSET_DST_PORT },
-
-	{ RTE_ETH_RSS_NONFRAG_IPV4_SCTP, I40E_INSET_IPV4_SRC | I40E_INSET_IPV4_DST |
-	  I40E_INSET_SRC_PORT | I40E_INSET_DST_PORT | I40E_INSET_SCTP_VT },
-
-	/* IPv6 */
-	{ RTE_ETH_RSS_IPV6, I40E_INSET_IPV6_SRC | I40E_INSET_IPV6_DST },
-	{ RTE_ETH_RSS_FRAG_IPV6, I40E_INSET_IPV6_SRC | I40E_INSET_IPV6_DST },
-
-	{ RTE_ETH_RSS_NONFRAG_IPV6_OTHER,
-	  I40E_INSET_IPV6_SRC | I40E_INSET_IPV6_DST },
-
-	{ RTE_ETH_RSS_NONFRAG_IPV6_TCP, I40E_INSET_IPV6_SRC | I40E_INSET_IPV6_DST |
-	  I40E_INSET_SRC_PORT | I40E_INSET_DST_PORT },
-
-	{ RTE_ETH_RSS_NONFRAG_IPV6_UDP, I40E_INSET_IPV6_SRC | I40E_INSET_IPV6_DST |
-	  I40E_INSET_SRC_PORT | I40E_INSET_DST_PORT },
-
-	{ RTE_ETH_RSS_NONFRAG_IPV6_SCTP, I40E_INSET_IPV6_SRC | I40E_INSET_IPV6_DST |
-	  I40E_INSET_SRC_PORT | I40E_INSET_DST_PORT | I40E_INSET_SCTP_VT },
-
-	/* Port */
-	{ RTE_ETH_RSS_PORT, I40E_INSET_SRC_PORT | I40E_INSET_DST_PORT },
-
-	/* Ether */
-	{ RTE_ETH_RSS_L2_PAYLOAD, I40E_INSET_LAST_ETHER_TYPE },
-	{ RTE_ETH_RSS_ETH, I40E_INSET_DMAC | I40E_INSET_SMAC },
-
-	/* VLAN */
-	{ RTE_ETH_RSS_S_VLAN, I40E_INSET_VLAN_OUTER },
-	{ RTE_ETH_RSS_C_VLAN, I40E_INSET_VLAN_INNER },
-};
-
-#define I40E_HASH_VOID_NEXT_ALLOW	BIT_ULL(RTE_FLOW_ITEM_TYPE_ETH)
-
-#define I40E_HASH_ETH_NEXT_ALLOW	(BIT_ULL(RTE_FLOW_ITEM_TYPE_IPV4) | \
-					BIT_ULL(RTE_FLOW_ITEM_TYPE_IPV6) | \
-					BIT_ULL(RTE_FLOW_ITEM_TYPE_VLAN))
-
-#define I40E_HASH_IP_NEXT_ALLOW		(BIT_ULL(RTE_FLOW_ITEM_TYPE_TCP) | \
-					BIT_ULL(RTE_FLOW_ITEM_TYPE_UDP) | \
-					BIT_ULL(RTE_FLOW_ITEM_TYPE_SCTP) | \
-					BIT_ULL(RTE_FLOW_ITEM_TYPE_ESP) | \
-					BIT_ULL(RTE_FLOW_ITEM_TYPE_L2TPV3OIP) |\
-					BIT_ULL(RTE_FLOW_ITEM_TYPE_AH))
-
-#define I40E_HASH_IPV6_NEXT_ALLOW	(I40E_HASH_IP_NEXT_ALLOW | \
-					BIT_ULL(RTE_FLOW_ITEM_TYPE_IPV6_FRAG_EXT))
-
-#define I40E_HASH_UDP_NEXT_ALLOW	(BIT_ULL(RTE_FLOW_ITEM_TYPE_GTPU) | \
-					BIT_ULL(RTE_FLOW_ITEM_TYPE_GTPC))
-
-#define I40E_HASH_GTPU_NEXT_ALLOW	(BIT_ULL(RTE_FLOW_ITEM_TYPE_IPV4) | \
-					BIT_ULL(RTE_FLOW_ITEM_TYPE_IPV6))
-
-static const uint64_t pattern_next_allow_items[] = {
-	[RTE_FLOW_ITEM_TYPE_VOID] = I40E_HASH_VOID_NEXT_ALLOW,
-	[RTE_FLOW_ITEM_TYPE_ETH] = I40E_HASH_ETH_NEXT_ALLOW,
-	[RTE_FLOW_ITEM_TYPE_IPV4] = I40E_HASH_IP_NEXT_ALLOW,
-	[RTE_FLOW_ITEM_TYPE_IPV6] = I40E_HASH_IPV6_NEXT_ALLOW,
-	[RTE_FLOW_ITEM_TYPE_UDP] = I40E_HASH_UDP_NEXT_ALLOW,
-	[RTE_FLOW_ITEM_TYPE_GTPU] = I40E_HASH_GTPU_NEXT_ALLOW,
-};
-
-static const uint64_t pattern_item_header[] = {
-	[RTE_FLOW_ITEM_TYPE_ETH] = I40E_HASH_HDR_ETH,
-	[RTE_FLOW_ITEM_TYPE_IPV4] = I40E_HASH_HDR_IPV4,
-	[RTE_FLOW_ITEM_TYPE_IPV6] = I40E_HASH_HDR_IPV6,
-	[RTE_FLOW_ITEM_TYPE_IPV6_FRAG_EXT] = I40E_HASH_HDR_IPV6_FRAG,
-	[RTE_FLOW_ITEM_TYPE_TCP] = I40E_HASH_HDR_TCP,
-	[RTE_FLOW_ITEM_TYPE_UDP] = I40E_HASH_HDR_UDP,
-	[RTE_FLOW_ITEM_TYPE_SCTP] = I40E_HASH_HDR_SCTP,
-	[RTE_FLOW_ITEM_TYPE_ESP] = I40E_HASH_HDR_ESP,
-	[RTE_FLOW_ITEM_TYPE_GTPC] = I40E_HASH_HDR_GTPC,
-	[RTE_FLOW_ITEM_TYPE_GTPU] = I40E_HASH_HDR_GTPU,
-	[RTE_FLOW_ITEM_TYPE_L2TPV3OIP] = I40E_HASH_HDR_L2TPV3,
-	[RTE_FLOW_ITEM_TYPE_AH] = I40E_HASH_HDR_AH,
-};
-
-/* Structure of matched pattern */
-struct i40e_hash_match_pattern {
-	uint64_t pattern_type;
-	uint64_t rss_mask;	/* Supported RSS type for this pattern */
-	bool custom_pctype_flag;/* true for custom packet type */
-	uint8_t pctype;
-};
-
-#define I40E_HASH_MAP_PATTERN(pattern, rss_mask, pctype) { \
-	pattern, rss_mask, false, pctype  }
-
-#define I40E_HASH_MAP_CUS_PATTERN(pattern, rss_mask, cus_pctype) { \
-	pattern, rss_mask, true, cus_pctype }
-
-#define I40E_HASH_L2_RSS_MASK		(RTE_ETH_RSS_VLAN | RTE_ETH_RSS_ETH | \
-					RTE_ETH_RSS_L2_SRC_ONLY | \
-					RTE_ETH_RSS_L2_DST_ONLY)
-
-#define I40E_HASH_L23_RSS_MASK		(I40E_HASH_L2_RSS_MASK | \
-					RTE_ETH_RSS_L3_SRC_ONLY | \
-					RTE_ETH_RSS_L3_DST_ONLY)
-
-#define I40E_HASH_IPV4_L23_RSS_MASK	(RTE_ETH_RSS_IPV4 | I40E_HASH_L23_RSS_MASK)
-#define I40E_HASH_IPV6_L23_RSS_MASK	(RTE_ETH_RSS_IPV6 | I40E_HASH_L23_RSS_MASK)
-
-#define I40E_HASH_L234_RSS_MASK		(I40E_HASH_L23_RSS_MASK | \
-					RTE_ETH_RSS_PORT | RTE_ETH_RSS_L4_SRC_ONLY | \
-					RTE_ETH_RSS_L4_DST_ONLY)
-
-#define I40E_HASH_IPV4_L234_RSS_MASK	(I40E_HASH_L234_RSS_MASK | RTE_ETH_RSS_IPV4)
-#define I40E_HASH_IPV6_L234_RSS_MASK	(I40E_HASH_L234_RSS_MASK | RTE_ETH_RSS_IPV6)
-
-#define I40E_HASH_L4_TYPES		(RTE_ETH_RSS_NONFRAG_IPV4_TCP | \
-					RTE_ETH_RSS_NONFRAG_IPV4_UDP | \
-					RTE_ETH_RSS_NONFRAG_IPV4_SCTP | \
-					RTE_ETH_RSS_NONFRAG_IPV6_TCP | \
-					RTE_ETH_RSS_NONFRAG_IPV6_UDP | \
-					RTE_ETH_RSS_NONFRAG_IPV6_SCTP)
-
 const uint8_t i40e_rss_key_default[] = {
 	0x44, 0x39, 0x79, 0x6b,
 	0xb5, 0x4c, 0x50, 0x23,
@@ -251,395 +33,6 @@ const uint8_t i40e_rss_key_default[] = {
 	0x81, 0x15, 0x03, 0x66
 };
 
-/* Current supported patterns and RSS types.
- * All items that have the same pattern types are together.
- */
-static const struct i40e_hash_match_pattern match_patterns[] = {
-	/* Ether */
-	I40E_HASH_MAP_PATTERN(I40E_PHINT_ETH,
-			      RTE_ETH_RSS_L2_PAYLOAD | I40E_HASH_L2_RSS_MASK,
-			      I40E_FILTER_PCTYPE_L2_PAYLOAD),
-
-	/* IPv4 */
-	I40E_HASH_MAP_PATTERN(I40E_PHINT_IPV4,
-			      RTE_ETH_RSS_FRAG_IPV4 | I40E_HASH_IPV4_L23_RSS_MASK,
-			      I40E_FILTER_PCTYPE_FRAG_IPV4),
-
-	I40E_HASH_MAP_PATTERN(I40E_PHINT_IPV4,
-			      RTE_ETH_RSS_NONFRAG_IPV4_OTHER |
-			      I40E_HASH_IPV4_L23_RSS_MASK,
-			      I40E_FILTER_PCTYPE_NONF_IPV4_OTHER),
-
-	I40E_HASH_MAP_PATTERN(I40E_PHINT_IPV4_TCP,
-			      RTE_ETH_RSS_NONFRAG_IPV4_TCP |
-			      I40E_HASH_IPV4_L234_RSS_MASK,
-			      I40E_FILTER_PCTYPE_NONF_IPV4_TCP),
-
-	I40E_HASH_MAP_PATTERN(I40E_PHINT_IPV4_UDP,
-			      RTE_ETH_RSS_NONFRAG_IPV4_UDP |
-			      I40E_HASH_IPV4_L234_RSS_MASK,
-			      I40E_FILTER_PCTYPE_NONF_IPV4_UDP),
-
-	I40E_HASH_MAP_PATTERN(I40E_PHINT_IPV4_SCTP,
-			      RTE_ETH_RSS_NONFRAG_IPV4_SCTP |
-			      I40E_HASH_IPV4_L234_RSS_MASK,
-			      I40E_FILTER_PCTYPE_NONF_IPV4_SCTP),
-
-	/* IPv6 */
-	I40E_HASH_MAP_PATTERN(I40E_PHINT_IPV6,
-			      RTE_ETH_RSS_FRAG_IPV6 | I40E_HASH_IPV6_L23_RSS_MASK,
-			      I40E_FILTER_PCTYPE_FRAG_IPV6),
-
-	I40E_HASH_MAP_PATTERN(I40E_PHINT_IPV6,
-			      RTE_ETH_RSS_NONFRAG_IPV6_OTHER |
-			      I40E_HASH_IPV6_L23_RSS_MASK,
-			      I40E_FILTER_PCTYPE_NONF_IPV6_OTHER),
-
-	I40E_HASH_MAP_PATTERN(I40E_PHINT_IPV6_FRAG,
-			      RTE_ETH_RSS_FRAG_IPV6 | I40E_HASH_L23_RSS_MASK,
-			      I40E_FILTER_PCTYPE_FRAG_IPV6),
-
-	I40E_HASH_MAP_PATTERN(I40E_PHINT_IPV6_TCP,
-			      RTE_ETH_RSS_NONFRAG_IPV6_TCP |
-			      I40E_HASH_IPV6_L234_RSS_MASK,
-			      I40E_FILTER_PCTYPE_NONF_IPV6_TCP),
-
-	I40E_HASH_MAP_PATTERN(I40E_PHINT_IPV6_UDP,
-			      RTE_ETH_RSS_NONFRAG_IPV6_UDP |
-			      I40E_HASH_IPV6_L234_RSS_MASK,
-			      I40E_FILTER_PCTYPE_NONF_IPV6_UDP),
-
-	I40E_HASH_MAP_PATTERN(I40E_PHINT_IPV6_SCTP,
-			      RTE_ETH_RSS_NONFRAG_IPV6_SCTP |
-			      I40E_HASH_IPV6_L234_RSS_MASK,
-			      I40E_FILTER_PCTYPE_NONF_IPV6_SCTP),
-
-	/* ESP */
-	I40E_HASH_MAP_CUS_PATTERN(I40E_PHINT_IPV4_ESP,
-				  RTE_ETH_RSS_ESP, I40E_CUSTOMIZED_ESP_IPV4),
-	I40E_HASH_MAP_CUS_PATTERN(I40E_PHINT_IPV6_ESP,
-				  RTE_ETH_RSS_ESP, I40E_CUSTOMIZED_ESP_IPV6),
-	I40E_HASH_MAP_CUS_PATTERN(I40E_PHINT_IPV4_UDP_ESP,
-				  RTE_ETH_RSS_ESP, I40E_CUSTOMIZED_ESP_IPV4_UDP),
-	I40E_HASH_MAP_CUS_PATTERN(I40E_PHINT_IPV6_UDP_ESP,
-				  RTE_ETH_RSS_ESP, I40E_CUSTOMIZED_ESP_IPV6_UDP),
-
-	/* GTPC */
-	I40E_HASH_MAP_CUS_PATTERN(I40E_PHINT_IPV4_GTPC,
-				  I40E_HASH_IPV4_L234_RSS_MASK,
-				  I40E_CUSTOMIZED_GTPC),
-	I40E_HASH_MAP_CUS_PATTERN(I40E_PHINT_IPV6_GTPC,
-				  I40E_HASH_IPV6_L234_RSS_MASK,
-				  I40E_CUSTOMIZED_GTPC),
-
-	/* GTPU */
-	I40E_HASH_MAP_CUS_PATTERN(I40E_PHINT_IPV4_GTPU,
-				  I40E_HASH_IPV4_L234_RSS_MASK,
-				  I40E_CUSTOMIZED_GTPU),
-	I40E_HASH_MAP_CUS_PATTERN(I40E_PHINT_IPV4_GTPU_IPV4,
-				  RTE_ETH_RSS_GTPU, I40E_CUSTOMIZED_GTPU_IPV4),
-	I40E_HASH_MAP_CUS_PATTERN(I40E_PHINT_IPV4_GTPU_IPV6,
-				  RTE_ETH_RSS_GTPU, I40E_CUSTOMIZED_GTPU_IPV6),
-	I40E_HASH_MAP_CUS_PATTERN(I40E_PHINT_IPV6_GTPU,
-				  I40E_HASH_IPV6_L234_RSS_MASK,
-				  I40E_CUSTOMIZED_GTPU),
-	I40E_HASH_MAP_CUS_PATTERN(I40E_PHINT_IPV6_GTPU_IPV4,
-				  RTE_ETH_RSS_GTPU, I40E_CUSTOMIZED_GTPU_IPV4),
-	I40E_HASH_MAP_CUS_PATTERN(I40E_PHINT_IPV6_GTPU_IPV6,
-				  RTE_ETH_RSS_GTPU, I40E_CUSTOMIZED_GTPU_IPV6),
-
-	/* L2TPV3 */
-	I40E_HASH_MAP_CUS_PATTERN(I40E_PHINT_IPV4_L2TPV3,
-				  RTE_ETH_RSS_L2TPV3, I40E_CUSTOMIZED_IPV4_L2TPV3),
-	I40E_HASH_MAP_CUS_PATTERN(I40E_PHINT_IPV6_L2TPV3,
-				  RTE_ETH_RSS_L2TPV3, I40E_CUSTOMIZED_IPV6_L2TPV3),
-
-	/* AH */
-	I40E_HASH_MAP_CUS_PATTERN(I40E_PHINT_IPV4_AH, RTE_ETH_RSS_AH,
-				  I40E_CUSTOMIZED_AH_IPV4),
-	I40E_HASH_MAP_CUS_PATTERN(I40E_PHINT_IPV6_AH, RTE_ETH_RSS_AH,
-				  I40E_CUSTOMIZED_AH_IPV6),
-};
-
-static int
-i40e_hash_get_pattern_type(const struct rte_flow_item pattern[],
-			   uint64_t *pattern_types,
-			   struct rte_flow_error *error)
-{
-	const char *message = "Pattern not supported";
-	enum rte_flow_item_type prev_item_type = RTE_FLOW_ITEM_TYPE_VOID;
-	enum rte_flow_item_type last_item_type = prev_item_type;
-	uint64_t item_hdr, pattern_hdrs = 0;
-	bool inner_flag = false;
-	int vlan_count = 0;
-
-	for (; pattern->type != RTE_FLOW_ITEM_TYPE_END; pattern++) {
-		if (pattern->type == RTE_FLOW_ITEM_TYPE_VOID)
-			continue;
-
-		if (pattern->mask || pattern->spec || pattern->last) {
-			message = "Header info should not be specified";
-			goto not_sup;
-		}
-
-		/* Check the previous item allows this sub-item. */
-		if (prev_item_type >= (enum rte_flow_item_type)
-				RTE_DIM(pattern_next_allow_items) ||
-		    !(pattern_next_allow_items[prev_item_type] &
-				BIT_ULL(pattern->type)))
-			goto not_sup;
-
-		/* For VLAN item, it does no matter about to pattern type
-		 * recognition. So just count the number of VLAN and do not
-		 * change the value of variable `prev_item_type`.
-		 */
-		last_item_type = pattern->type;
-		if (last_item_type == RTE_FLOW_ITEM_TYPE_VLAN) {
-			if (vlan_count >= 2)
-				goto not_sup;
-			vlan_count++;
-			continue;
-		}
-
-		prev_item_type = last_item_type;
-		if (last_item_type >= (enum rte_flow_item_type)
-				RTE_DIM(pattern_item_header))
-			goto not_sup;
-
-		item_hdr = pattern_item_header[last_item_type];
-		assert(item_hdr);
-
-		if (inner_flag) {
-			item_hdr <<= I40E_HASH_HDR_INNER_SHIFT;
-
-			/* Inner layer should not have GTPU item */
-			if (last_item_type == RTE_FLOW_ITEM_TYPE_GTPU)
-				goto not_sup;
-		} else {
-			if (last_item_type == RTE_FLOW_ITEM_TYPE_GTPU) {
-				inner_flag = true;
-				vlan_count = 0;
-			}
-		}
-
-		if (item_hdr & pattern_hdrs)
-			goto not_sup;
-
-		pattern_hdrs |= item_hdr;
-	}
-
-	if (pattern_hdrs && last_item_type != RTE_FLOW_ITEM_TYPE_VLAN) {
-		*pattern_types = pattern_hdrs;
-		return 0;
-	}
-
-not_sup:
-	return rte_flow_error_set(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_ITEM,
-				  pattern, message);
-}
-
-static uint64_t
-i40e_hash_get_x722_ext_pctypes(uint8_t match_pctype)
-{
-	uint64_t pctypes = 0;
-
-	switch (match_pctype) {
-	case I40E_FILTER_PCTYPE_NONF_IPV4_TCP:
-		pctypes = BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV4_TCP_SYN_NO_ACK);
-		break;
-
-	case I40E_FILTER_PCTYPE_NONF_IPV4_UDP:
-		pctypes = BIT_ULL(I40E_FILTER_PCTYPE_NONF_UNICAST_IPV4_UDP) |
-			  BIT_ULL(I40E_FILTER_PCTYPE_NONF_MULTICAST_IPV4_UDP);
-		break;
-
-	case I40E_FILTER_PCTYPE_NONF_IPV6_TCP:
-		pctypes = BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV6_TCP_SYN_NO_ACK);
-		break;
-
-	case I40E_FILTER_PCTYPE_NONF_IPV6_UDP:
-		pctypes = BIT_ULL(I40E_FILTER_PCTYPE_NONF_UNICAST_IPV6_UDP) |
-			  BIT_ULL(I40E_FILTER_PCTYPE_NONF_MULTICAST_IPV6_UDP);
-		break;
-	}
-
-	return pctypes;
-}
-
-static int
-i40e_hash_translate_gtp_inset(struct i40e_rte_flow_rss_conf *rss_conf,
-			      struct rte_flow_error *error)
-{
-	if (rss_conf->inset &
-	    (I40E_INSET_IPV4_SRC | I40E_INSET_IPV6_SRC |
-	    I40E_INSET_DST_PORT | I40E_INSET_SRC_PORT))
-		return rte_flow_error_set(error, ENOTSUP,
-					  RTE_FLOW_ERROR_TYPE_ACTION_CONF,
-					  NULL,
-					  "Only support external destination IP");
-
-	if (rss_conf->inset & I40E_INSET_IPV4_DST)
-		rss_conf->inset = (rss_conf->inset & ~I40E_INSET_IPV4_DST) |
-				  I40E_INSET_TUNNEL_IPV4_DST;
-
-	if (rss_conf->inset & I40E_INSET_IPV6_DST)
-		rss_conf->inset = (rss_conf->inset & ~I40E_INSET_IPV6_DST) |
-				  I40E_INSET_TUNNEL_IPV6_DST;
-
-	return 0;
-}
-
-static int
-i40e_hash_get_pctypes(const struct rte_eth_dev *dev,
-		      const struct i40e_hash_match_pattern *match,
-		      struct i40e_rte_flow_rss_conf *rss_conf,
-		      struct rte_flow_error *error)
-{
-	if (match->custom_pctype_flag) {
-		struct i40e_pf *pf;
-		struct i40e_customized_pctype *custom_type;
-
-		pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-		custom_type = i40e_find_customized_pctype(pf, match->pctype);
-		if (!custom_type || !custom_type->valid)
-			return rte_flow_error_set(error, ENOTSUP,
-						  RTE_FLOW_ERROR_TYPE_ITEM,
-						  NULL, "PCTYPE not supported");
-
-		rss_conf->config_pctypes |= BIT_ULL(custom_type->pctype);
-
-		if (match->pctype == I40E_CUSTOMIZED_GTPU ||
-		    match->pctype == I40E_CUSTOMIZED_GTPC)
-			return i40e_hash_translate_gtp_inset(rss_conf, error);
-	} else {
-		struct i40e_hw *hw =
-				I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-		uint64_t types;
-
-		rss_conf->config_pctypes |= BIT_ULL(match->pctype);
-		if (hw->mac.type == I40E_MAC_X722) {
-			types = i40e_hash_get_x722_ext_pctypes(match->pctype);
-			rss_conf->config_pctypes |= types;
-		}
-	}
-
-	return 0;
-}
-
-static int
-i40e_hash_get_pattern_pctypes(const struct rte_eth_dev *dev,
-			      const struct rte_flow_item pattern[],
-			      const struct rte_flow_action_rss *rss_act,
-			      struct i40e_rte_flow_rss_conf *rss_conf,
-			      struct rte_flow_error *error)
-{
-	uint64_t pattern_types = 0;
-	bool match_flag = false;
-	int i, ret;
-
-	ret = i40e_hash_get_pattern_type(pattern, &pattern_types, error);
-	if (ret)
-		return ret;
-
-	for (i = 0; i < (int)RTE_DIM(match_patterns); i++) {
-		const struct i40e_hash_match_pattern *match =
-							&match_patterns[i];
-
-		/* Check pattern types match. All items that have the same
-		 * pattern types are together, so if the pattern types match
-		 * previous item but they doesn't match current item, it means
-		 * the pattern types do not match all remain items.
-		 */
-		if (pattern_types != match->pattern_type) {
-			if (match_flag)
-				break;
-			continue;
-		}
-		match_flag = true;
-
-		/* Check RSS types match */
-		if (!(rss_act->types & ~match->rss_mask)) {
-			ret = i40e_hash_get_pctypes(dev, match,
-						    rss_conf, error);
-			if (ret)
-				return ret;
-		}
-	}
-
-	if (rss_conf->config_pctypes)
-		return 0;
-
-	if (match_flag)
-		return rte_flow_error_set(error, ENOTSUP,
-					  RTE_FLOW_ERROR_TYPE_ACTION_CONF,
-					  NULL, "RSS types not supported");
-
-	return rte_flow_error_set(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_ITEM,
-				  NULL, "Pattern not supported");
-}
-
-static uint64_t
-i40e_hash_get_inset(uint64_t rss_types, bool symmetric_enable)
-{
-	uint64_t mask, inset = 0;
-	int i;
-
-	for (i = 0; i < (int)RTE_DIM(i40e_hash_rss_inset); i++) {
-		if (rss_types & i40e_hash_rss_inset[i].rss_type)
-			inset |= i40e_hash_rss_inset[i].inset;
-	}
-
-	if (!inset)
-		return 0;
-
-	/* If SRC_ONLY and DST_ONLY of the same level are used simultaneously,
-	 * it is the same case as none of them are added.
-	 */
-	mask = rss_types & (RTE_ETH_RSS_L2_SRC_ONLY | RTE_ETH_RSS_L2_DST_ONLY);
-	if (mask == RTE_ETH_RSS_L2_SRC_ONLY)
-		inset &= ~I40E_INSET_DMAC;
-	else if (mask == RTE_ETH_RSS_L2_DST_ONLY)
-		inset &= ~I40E_INSET_SMAC;
-
-	mask = rss_types & (RTE_ETH_RSS_L3_SRC_ONLY | RTE_ETH_RSS_L3_DST_ONLY);
-	if (mask == RTE_ETH_RSS_L3_SRC_ONLY)
-		inset &= ~(I40E_INSET_IPV4_DST | I40E_INSET_IPV6_DST);
-	else if (mask == RTE_ETH_RSS_L3_DST_ONLY)
-		inset &= ~(I40E_INSET_IPV4_SRC | I40E_INSET_IPV6_SRC);
-
-	mask = rss_types & (RTE_ETH_RSS_L4_SRC_ONLY | RTE_ETH_RSS_L4_DST_ONLY);
-	if (mask == RTE_ETH_RSS_L4_SRC_ONLY)
-		inset &= ~I40E_INSET_DST_PORT;
-	else if (mask == RTE_ETH_RSS_L4_DST_ONLY)
-		inset &= ~I40E_INSET_SRC_PORT;
-
-	if (rss_types & I40E_HASH_L4_TYPES) {
-		uint64_t l3_mask = rss_types &
-				   (RTE_ETH_RSS_L3_SRC_ONLY | RTE_ETH_RSS_L3_DST_ONLY);
-		uint64_t l4_mask = rss_types &
-				   (RTE_ETH_RSS_L4_SRC_ONLY | RTE_ETH_RSS_L4_DST_ONLY);
-
-		if (l3_mask && !l4_mask)
-			inset &= ~(I40E_INSET_SRC_PORT | I40E_INSET_DST_PORT);
-		else if (!l3_mask && l4_mask)
-			inset &= ~(I40E_INSET_IPV4_DST | I40E_INSET_IPV6_DST |
-				 I40E_INSET_IPV4_SRC | I40E_INSET_IPV6_SRC);
-	}
-
-	/* SCTP Verification Tag is not required in hash computation for SYMMETRIC_TOEPLITZ */
-	if (symmetric_enable) {
-		mask = rss_types & RTE_ETH_RSS_NONFRAG_IPV4_SCTP;
-		if (mask == RTE_ETH_RSS_NONFRAG_IPV4_SCTP)
-			inset &= ~I40E_INSET_SCTP_VT;
-
-		mask = rss_types & RTE_ETH_RSS_NONFRAG_IPV6_SCTP;
-		if (mask == RTE_ETH_RSS_NONFRAG_IPV6_SCTP)
-			inset &= ~I40E_INSET_SCTP_VT;
-	}
-
-	return inset;
-}
-
 static int
 i40e_hash_config_func(struct i40e_hw *hw, enum rte_eth_hash_function func)
 {
@@ -921,375 +314,6 @@ i40e_hash_config(struct i40e_pf *pf,
 	return 0;
 }
 
-static void
-i40e_hash_parse_key(const struct rte_flow_action_rss *rss_act,
-		    struct i40e_rte_flow_rss_conf *rss_conf)
-{
-	const uint8_t *key = rss_act->key;
-
-	if (key == NULL) {
-		memcpy(rss_conf->key, i40e_rss_key_default, sizeof(rss_conf->key));
-	} else {
-		memcpy(rss_conf->key, key, sizeof(rss_conf->key));
-	}
-
-	rss_conf->conf.key = rss_conf->key;
-	rss_conf->conf.key_len = sizeof(rss_conf->key);
-}
-
-static int
-i40e_hash_parse_pattern_act(const struct rte_eth_dev *dev,
-			    const struct rte_flow_item pattern[],
-			    const struct rte_flow_action_rss *rss_act,
-			    struct i40e_rte_flow_rss_conf *rss_conf,
-			    struct rte_flow_error *error)
-{
-	rss_conf->symmetric_enable = rss_act->func == RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ;
-
-	if (rss_act->key_len)
-		i40e_hash_parse_key(rss_act, rss_conf);
-
-	rss_conf->conf.func = rss_act->func;
-	rss_conf->conf.types = rss_act->types;
-	rss_conf->inset = i40e_hash_get_inset(rss_act->types, rss_conf->symmetric_enable);
-
-	return i40e_hash_get_pattern_pctypes(dev, pattern, rss_act,
-					     rss_conf, error);
-}
-
-static int
-i40e_hash_parse_queues(const struct rte_flow_action_rss *rss_act,
-		       struct i40e_rte_flow_rss_conf *rss_conf)
-{
-	memcpy(rss_conf->queue, rss_act->queue,
-	       rss_act->queue_num * sizeof(rss_conf->queue[0]));
-	rss_conf->conf.queue = rss_conf->queue;
-	rss_conf->conf.queue_num = rss_act->queue_num;
-	return 0;
-}
-
-static int
-i40e_hash_parse_queue_region(const struct rte_flow_item pattern[],
-			     const struct rte_flow_action_rss *rss_act,
-			     struct i40e_rte_flow_rss_conf *rss_conf,
-			     struct rte_flow_error *error)
-{
-	const struct rte_flow_item_vlan *vlan_spec, *vlan_mask;
-
-	vlan_spec = pattern->spec;
-	vlan_mask = pattern->mask;
-
-	/* VLAN must have spec and mask */
-	if (vlan_spec == NULL || vlan_mask == NULL) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM, &pattern[0],
-				"VLAN pattern spec and mask required");
-	}
-	/* for mask, VLAN/TCI must be masked appropriately */
-	if ((rte_be_to_cpu_16(vlan_mask->hdr.vlan_tci) >> 13) != 0x7) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM, &pattern[0],
-				"VLAN pattern mask invalid");
-	}
-
-	/* Use a 64 bit variable to represent all queues in a region. */
-	RTE_BUILD_BUG_ON(I40E_MAX_Q_PER_TC > 64);
-
-	rss_conf->region_queue_num = (uint8_t)rss_act->queue_num;
-	rss_conf->region_queue_start = rss_act->queue[0];
-	rss_conf->region_priority = rte_be_to_cpu_16(vlan_spec->hdr.vlan_tci) >> 13;
-	return 0;
-}
-
-static bool
-i40e_hash_validate_rss_types(uint64_t rss_types)
-{
-	uint64_t type, mask;
-
-	/* Validate L2 */
-	type = RTE_ETH_RSS_ETH & rss_types;
-	mask = (RTE_ETH_RSS_L2_SRC_ONLY | RTE_ETH_RSS_L2_DST_ONLY) & rss_types;
-	if (!type && mask)
-		return false;
-
-	/* Validate L3 */
-	type = (I40E_HASH_L4_TYPES | RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_FRAG_IPV4 |
-	       RTE_ETH_RSS_NONFRAG_IPV4_OTHER | RTE_ETH_RSS_IPV6 |
-	       RTE_ETH_RSS_FRAG_IPV6 | RTE_ETH_RSS_NONFRAG_IPV6_OTHER) & rss_types;
-	mask = (RTE_ETH_RSS_L3_SRC_ONLY | RTE_ETH_RSS_L3_DST_ONLY) & rss_types;
-	if (!type && mask)
-		return false;
-
-	/* Validate L4 */
-	type = (I40E_HASH_L4_TYPES | RTE_ETH_RSS_PORT) & rss_types;
-	mask = (RTE_ETH_RSS_L4_SRC_ONLY | RTE_ETH_RSS_L4_DST_ONLY) & rss_types;
-	if (!type && mask)
-		return false;
-
-	return true;
-}
-
-static int
-i40e_hash_validate_rss_pattern(const struct ci_flow_actions *actions,
-	const struct ci_flow_actions_check_param *param __rte_unused,
-	struct rte_flow_error *error)
-{
-	const struct rte_flow_action_rss *rss_act = actions->actions[0]->conf;
-
-	/* queue list is not supported */
-	if (rss_act->queue_num == 0) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
-				"RSS queues not supported when pattern specified");
-	}
-
-	/* disallow unsupported hash functions */
-	switch (rss_act->func) {
-	case RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ:
-	case RTE_ETH_HASH_FUNCTION_DEFAULT:
-	case RTE_ETH_HASH_FUNCTION_TOEPLITZ:
-	case RTE_ETH_HASH_FUNCTION_SIMPLE_XOR:
-		break;
-	default:
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
-				"RSS hash function not supported when pattern specified");
-	}
-
-	if (!i40e_hash_validate_rss_types(rss_act->types))
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION_CONF,
-				rss_act, "RSS types are invalid");
-
-	/* check RSS key length if it is specified */
-	if (rss_act->key_len != 0 && rss_act->key_len != I40E_RSS_KEY_LEN) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
-				"RSS key length must be 52 bytes");
-	}
-
-	return 0;
-}
-
-static int
-i40e_hash_validate_rss_common(const struct rte_flow_action_rss *rss_act,
-		struct rte_flow_error *error)
-{
-	/* for empty patterns, symmetric toeplitz is not supported */
-	if (rss_act->func == RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
-				"Symmetric hash function not supported without specific patterns");
-	}
-
-	/* hash types are not supported for global RSS configuration */
-	if (rss_act->types != 0) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
-				"RSS types not supported without a pattern");
-	}
-
-	/* check RSS key length if it is specified */
-	if (rss_act->key_len != 0 && rss_act->key_len != I40E_RSS_KEY_LEN) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
-				"RSS key length must be 52 bytes");
-	}
-
-	return 0;
-}
-
-static int
-i40e_hash_validate_queue_region(const struct ci_flow_actions *actions,
-		const struct ci_flow_actions_check_param *param,
-		struct rte_flow_error *error)
-{
-	const struct rte_flow_action_rss *rss_act = actions->actions[0]->conf;
-	struct rte_eth_dev *dev = param->driver_ctx;
-	const struct i40e_pf *pf;
-	uint64_t hash_queues;
-
-	if (i40e_hash_validate_rss_common(rss_act, error))
-		return -rte_errno;
-
-	RTE_BUILD_BUG_ON(sizeof(hash_queues) != sizeof(pf->hash_enabled_queues));
-
-	/* having RSS key is not supported */
-	if (rss_act->key != NULL) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
-				"RSS key not supported");
-	}
-
-	/* queue region must be specified */
-	if (rss_act->queue_num == 0) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
-				"RSS queues missing");
-	}
-
-	/* queue region must be power of two */
-	if (!rte_is_power_of_2(rss_act->queue_num)) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
-				"RSS queue number must be power of two");
-	}
-
-	/* generic checks already filtered out discontiguous/non-unique RSS queues */
-
-	/* queues must not exceed maximum queues per traffic class */
-	if (rss_act->queue[rss_act->queue_num - 1] >= I40E_MAX_Q_PER_TC) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
-				"Invalid RSS queue index");
-	}
-
-	/* queues must be in LUT */
-	pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-	hash_queues = (BIT_ULL(rss_act->queue[0] + rss_act->queue_num) - 1) &
-			~(BIT_ULL(rss_act->queue[0]) - 1);
-
-	if (hash_queues & ~pf->hash_enabled_queues) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION_CONF,
-				rss_act, "Some queues are not in LUT");
-	}
-
-	return 0;
-}
-
-static int
-i40e_hash_validate_queue_list(const struct ci_flow_actions *actions,
-		const struct ci_flow_actions_check_param *param,
-		struct rte_flow_error *error)
-{
-	const struct rte_flow_action_rss *rss_act = actions->actions[0]->conf;
-	struct rte_eth_dev *dev = param->driver_ctx;
-	struct i40e_pf *pf;
-	struct i40e_hw *hw;
-	uint16_t max_queue;
-	bool has_queue, has_key;
-
-	if (i40e_hash_validate_rss_common(rss_act, error))
-		return -rte_errno;
-
-	has_queue = rss_act->queue != NULL;
-	has_key = rss_act->key != NULL;
-
-	/* if we have queues, we must not have key */
-	if (has_queue && has_key) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
-				"RSS key for queue region is not supported");
-	}
-
-	/* if there are no queues, no further checks needed */
-	if (!has_queue)
-		return 0;
-
-	/* check queue number limits */
-	hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	if (rss_act->queue_num > hw->func_caps.rss_table_size) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION_CONF,
-				rss_act, "Too many RSS queues");
-	}
-
-	pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-	if (pf->dev_data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG)
-		max_queue = i40e_pf_calc_configured_queues_num(pf);
-	else
-		max_queue = pf->dev_data->nb_rx_queues;
-
-	max_queue = RTE_MIN(max_queue, I40E_MAX_Q_PER_TC);
-
-	/* we know RSS queues are contiguous so we only need to check last queue */
-	if (rss_act->queue[rss_act->queue_num - 1] >= max_queue) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
-				"Invalid RSS queue");
-	}
-
-	return 0;
-}
-
-int
-i40e_hash_parse(struct rte_eth_dev *dev,
-		const struct rte_flow_item pattern[],
-		const struct rte_flow_action actions[],
-		struct i40e_rte_flow_rss_conf *rss_conf,
-		struct rte_flow_error *error)
-{
-	struct ci_flow_actions parsed_actions;
-	struct ci_flow_actions_check_param ac_param = {
-		.allowed_types = (enum rte_flow_action_type[]) {
-			RTE_FLOW_ACTION_TYPE_RSS,
-			RTE_FLOW_ACTION_TYPE_END
-		},
-		.max_actions = 1,
-		.driver_ctx = dev
-		/* each pattern type will add specific check function */
-	};
-	const struct rte_flow_action_rss *rss_act;
-	int ret;
-
-	/*
-	 * We have two possible paths: global RSS configuration, and an RSS pattern action.
-	 *
-	 * For global patterns, we act on two types of flows:
-	 * - Empty pattern ([END])
-	 * - VLAN pattern ([VLAN] -> [END])
-	 *
-	 * Everything else is handled by pattern action parser.
-	 */
-	bool is_empty, is_vlan;
-
-	while (pattern->type == RTE_FLOW_ITEM_TYPE_VOID)
-		pattern++;
-
-	is_empty = pattern[0].type == RTE_FLOW_ITEM_TYPE_END;
-	is_vlan = pattern[0].type == RTE_FLOW_ITEM_TYPE_VLAN &&
-			pattern[1].type == RTE_FLOW_ITEM_TYPE_END;
-
-	/* VLAN path */
-	if (is_vlan) {
-		ac_param.check = i40e_hash_validate_queue_region;
-		ret = ci_flow_check_actions(actions, &ac_param, &parsed_actions, error);
-		if (ret)
-			return ret;
-		rss_act = parsed_actions.actions[0]->conf;
-		/* set up RSS functions */
-		rss_conf->conf.func = rss_act->func;
-		return i40e_hash_parse_queue_region(pattern, rss_act, rss_conf, error);
-	}
-	/* Empty pattern path */
-	if (is_empty) {
-		ac_param.check = i40e_hash_validate_queue_list;
-		ret = ci_flow_check_actions(actions, &ac_param, &parsed_actions, error);
-		if (ret)
-			return ret;
-		rss_act = parsed_actions.actions[0]->conf;
-		rss_conf->conf.func = rss_act->func;
-		/* if there is a queue list, take that path */
-		if (rss_act->queue != NULL) {
-			return i40e_hash_parse_queues(rss_act, rss_conf);
-		}
-		/* otherwise just parse RSS key */
-		if (rss_act->key != NULL) {
-			i40e_hash_parse_key(rss_act, rss_conf);
-		}
-		return 0;
-	}
-	ac_param.check = i40e_hash_validate_rss_pattern;
-	ret = ci_flow_check_actions(actions, &ac_param, &parsed_actions, error);
-	if (ret)
-		return ret;
-	rss_act = parsed_actions.actions[0]->conf;
-
-	/* pattern case */
-	return i40e_hash_parse_pattern_act(dev, pattern, rss_act, rss_conf, error);
-}
-
 static void
 i40e_invalid_rss_filter(const struct i40e_rte_flow_rss_conf *ref_conf,
 			struct i40e_rte_flow_rss_conf *conf)
@@ -1459,13 +483,13 @@ i40e_hash_reset_conf(struct i40e_pf *pf,
 
 int
 i40e_hash_filter_destroy(struct i40e_pf *pf,
-			 const struct i40e_rss_filter *rss_filter)
+			 const struct i40e_rte_flow_rss_conf *rss_conf)
 {
 	struct i40e_rss_filter *filter;
 	int ret;
 
 	TAILQ_FOREACH(filter, &pf->rss_config_list, next) {
-		if (rss_filter == filter) {
+		if (rss_conf == &filter->rss_filter_info) {
 			ret = i40e_hash_reset_conf(pf,
 						   &filter->rss_filter_info);
 			if (ret)
diff --git a/drivers/net/intel/i40e/i40e_hash.h b/drivers/net/intel/i40e/i40e_hash.h
index 99df4bccd0..a3c1588e93 100644
--- a/drivers/net/intel/i40e/i40e_hash.h
+++ b/drivers/net/intel/i40e/i40e_hash.h
@@ -13,18 +13,12 @@
 extern "C" {
 #endif
 
-int i40e_hash_parse(struct rte_eth_dev *dev,
-		    const struct rte_flow_item pattern[],
-		    const struct rte_flow_action actions[],
-		    struct i40e_rte_flow_rss_conf *rss_conf,
-		    struct rte_flow_error *error);
-
 int i40e_hash_filter_create(struct i40e_pf *pf,
 			    struct i40e_rte_flow_rss_conf *rss_conf);
 
 int i40e_hash_filter_restore(struct i40e_pf *pf);
 int i40e_hash_filter_destroy(struct i40e_pf *pf,
-			     const struct i40e_rss_filter *rss_filter);
+			     const struct i40e_rte_flow_rss_conf *rss_conf);
 int i40e_hash_filter_flush(struct i40e_pf *pf);
 
 #define I40E_RSS_KEY_LEN ((I40E_PFQF_HKEY_MAX_INDEX + 1) * sizeof(uint32_t))
diff --git a/drivers/net/intel/i40e/meson.build b/drivers/net/intel/i40e/meson.build
index 9cff46b5e6..bb15d10f95 100644
--- a/drivers/net/intel/i40e/meson.build
+++ b/drivers/net/intel/i40e/meson.build
@@ -28,6 +28,7 @@ sources += files(
         'i40e_flow_ethertype.c',
         'i40e_flow_fdir.c',
         'i40e_flow_tunnel.c',
+        'i40e_flow_hash.c',
         'i40e_tm.c',
         'i40e_hash.c',
         'i40e_vf_representor.c',
-- 
2.47.3

