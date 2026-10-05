Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D315CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 16:40:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F6D040ED3;
	Mon,  5 Oct 2026 18:38:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 2933F40E3B
 for <dev@dpdk.org>; Mon,  5 Oct 2026 18:38:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791218335; x=1822754335;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=kOiaRzD9LE3onAF3nufiRSz0SxekKK4vvjN3lB+I8dI=;
 b=njrsaMSE6mlZK1uGOXOw7bljjDHiv9w31fFS8j9GvEvPvyrXkF3eyNu2
 dSiXgSd7pFuL22ns15U1o5hRFU5jI8HJR/ycvcPqev8XbMkp0YILh3RkS
 ZAQfBujl/laamdUR8E1hoa/8EgC+BJlIdE4MBu26WDeyWKdxcBAnquc97
 g8iH+YWL6CJqoy4kcAlQUx0iSWyBi/6nLQWtBUpnlYUG98HazTTZOerlj
 cKW63kzzJRWHyeYciH1YxOdejqozohe5jXpJyWpFCGW6k9vvT9GfAQqH1
 ThJuA0xlwo+wfqms9tRPyqlVAr96l6VzPEamVNSYfXe1Fg9KTwuTowazQ g==;
X-CSE-ConnectionGUID: GZGYVxocS62NSpXGDo2AZA==
X-CSE-MsgGUID: ZdsoSQyGTDS3gn5wjpt7Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="90665332"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="90665332"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 09:38:54 -0700
X-CSE-ConnectionGUID: oNIjLt0hQKaurcQi1OFQZQ==
X-CSE-MsgGUID: uHxpcfyoSvy1pF3PIU7Dvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="945772"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa011.fm.intel.com with ESMTP; 05 Oct 2026 09:38:54 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 15/24] net/ixgbe: don't embed RSS conf in filter structs
Date: Mon,  5 Oct 2026 17:38:10 +0100
Message-ID: <487297a997b31f78ea7642d228fd6d264fbbba37.1791218156.git.anatoly.burakov@intel.com>
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

Currently, the RSS configuration driver structure directly embeds rte_flow
RSS configuration item, which makes it so 1) the structure actually has
duplicate data (or, to be more precise, a local copy of data pointed to by
the RSS conf), and 2) direct struct assignments don't work because the RSS
conf contains pointers.

Fix the structure to not embed RSS conf, and instead just store the data
directly, so that we can perform struct assignments without any problems
with poiinters.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c |  2 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h | 18 ++++----
 drivers/net/intel/ixgbe/ixgbe_flow.c   | 37 +++++++++-------
 drivers/net/intel/ixgbe/ixgbe_rxtx.c   | 61 ++++++++++++--------------
 4 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 3228d1c5be3..2a1819c0f3e 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -7830,7 +7830,7 @@ ixgbe_rss_filter_restore(struct rte_eth_dev *dev)
 	struct ixgbe_filter_info *filter_info =
 		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(adapter);
 
-	if (filter_info->rss_info.conf.queue_num)
+	if (filter_info->rss_info.queue_num)
 		ixgbe_config_rss_filter(adapter,
 			&filter_info->rss_info, TRUE);
 }
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 06edca96698..d769e375269 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -209,9 +209,11 @@ struct ixgbe_fdir_state {
 	struct ixgbe_fdir_mask_state mask_conf;
 };
 
-struct ixgbe_rte_flow_rss_conf {
-	struct rte_flow_action_rss conf; /**< RSS parameters. */
-	uint8_t key[IXGBE_HKEY_MAX_INDEX * sizeof(uint32_t)]; /* Hash key. */
+struct ixgbe_rss_conf {
+	uint64_t types; /**< RSS hash types. */
+	uint32_t key_len; /**< Hash key length, 0 for default key. */
+	uint32_t queue_num; /**< Number of entries in queue. */
+	uint8_t key[IXGBE_HKEY_MAX_INDEX * sizeof(uint32_t)]; /**< Hash key. */
 	uint16_t queue[IXGBE_MAX_RX_QUEUE_NUM]; /**< Queues indices to use. */
 };
 
@@ -299,7 +301,7 @@ struct ixgbe_ethertype_table {
  */
 struct ixgbe_filter_info {
 	/* store the rss filter info */
-	struct ixgbe_rte_flow_rss_conf rss_info;
+	struct ixgbe_rss_conf rss_info;
 	/* shared EtherType (ETQF) slot table */
 	struct ixgbe_ethertype_table ethertype_table;
 	/* 1588 timestamping ETQF slot (valid when timesync_installed) */
@@ -738,12 +740,10 @@ void ixgbe_tm_conf_init(struct rte_eth_dev *dev);
 void ixgbe_tm_conf_uninit(struct rte_eth_dev *dev);
 int ixgbe_set_queue_rate_limit(struct rte_eth_dev *dev, uint16_t queue_idx,
 			       uint32_t tx_rate);
-int ixgbe_rss_conf_init(struct ixgbe_rte_flow_rss_conf *out,
-			const struct rte_flow_action_rss *in);
-int ixgbe_action_rss_same(const struct rte_flow_action_rss *comp,
-			  const struct rte_flow_action_rss *with);
+int ixgbe_rss_conf_init(struct ixgbe_rss_conf *out,
+		const struct rte_flow_action_rss *in);
 int ixgbe_config_rss_filter(struct ixgbe_adapter *adapter,
-		struct ixgbe_rte_flow_rss_conf *conf, bool add);
+		const struct ixgbe_rss_conf *conf, bool add);
 
 void ixgbe_dev_macsec_register_enable(struct rte_eth_dev *dev,
 		struct ixgbe_macsec_setting *macsec_setting);
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 98d0af6535c..aca3da5607a 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -57,7 +57,7 @@ struct ixgbe_filter_ele_base {
 /* rss filter list structure */
 struct ixgbe_rss_conf_ele {
 	struct ixgbe_filter_ele_base base;
-	struct ixgbe_rte_flow_rss_conf filter_info;
+	struct ixgbe_rss_conf filter_info;
 };
 /* ixgbe_flow memory list structure */
 struct ixgbe_flow_mem {
@@ -140,7 +140,8 @@ ixgbe_flow_actions_check_rss(const struct ci_flow_actions *parsed_actions,
 	const struct rte_flow_action *action = parsed_actions->actions[0];
 	const struct rte_flow_action_rss *rss_act = action->conf;
 	struct rte_eth_dev_data *dev_data = param->driver_ctx;
-	const size_t rss_key_len = sizeof(((struct ixgbe_rte_flow_rss_conf *)0)->key);
+	const size_t rss_key_len = sizeof(((struct ixgbe_rss_conf *)0)->key);
+	const size_t rss_queue_max = RTE_DIM(((struct ixgbe_rss_conf *)0)->queue);
 	size_t q_idx, q;
 
 	/* check if queue list is not empty */
@@ -149,6 +150,11 @@ ixgbe_flow_actions_check_rss(const struct ci_flow_actions *parsed_actions,
 			RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
 			"RSS queue list is empty");
 	}
+	if (rss_act->queue_num > rss_queue_max) {
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+			"RSS queue list is too long");
+	}
 
 	/* check if each RSS queue is valid */
 	for (q_idx = 0; q_idx < rss_act->queue_num; q_idx++) {
@@ -185,7 +191,7 @@ static int
 ixgbe_parse_rss_filter(struct rte_eth_dev *dev,
 			const struct rte_flow_attr *attr,
 			const struct rte_flow_action actions[],
-			struct ixgbe_rte_flow_rss_conf *rss_conf,
+			struct ixgbe_rss_conf *rss_conf,
 			struct rte_flow_error *error)
 {
 	struct ci_flow_actions parsed_actions;
@@ -199,8 +205,8 @@ ixgbe_parse_rss_filter(struct rte_eth_dev *dev,
 		.check = ixgbe_flow_actions_check_rss,
 		.max_actions = 1,
 	};
+	const struct rte_flow_action_rss *rss_act;
 	int ret;
-	const struct rte_flow_action *action;
 
 	/* validate attributes */
 	ret = ci_flow_check_attr(attr, NULL, error);
@@ -211,12 +217,14 @@ ixgbe_parse_rss_filter(struct rte_eth_dev *dev,
 	ret = ci_flow_check_actions(actions, &ap_param, &parsed_actions, error);
 	if (ret)
 		return ret;
-	action = parsed_actions.actions[0];
+	rss_act = parsed_actions.actions[0]->conf;
 
-	if (ixgbe_rss_conf_init(rss_conf, action->conf))
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+	ret = ixgbe_rss_conf_init(rss_conf, rss_act);
+	if (ret) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
 				"RSS context initialization failure");
+	}
 
 	return 0;
 }
@@ -230,7 +238,7 @@ ixgbe_clear_rss_filter(struct rte_eth_dev *dev)
 	struct ixgbe_filter_info *filter_info =
 		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
 
-	if (filter_info->rss_info.conf.queue_num)
+	if (filter_info->rss_info.queue_num)
 		ixgbe_config_rss_filter(adapter, &filter_info->rss_info, FALSE);
 }
 
@@ -275,7 +283,7 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 {
 	int ret;
 	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct ixgbe_rte_flow_rss_conf rss_conf;
+	struct ixgbe_rss_conf rss_conf = {0};
 	struct rte_flow *flow = NULL;
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
 	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
@@ -303,7 +311,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	TAILQ_INSERT_TAIL(&adapter->flow_list,
 				&ixgbe_flow_mem_ptr->base, entries);
 
-	memset(&rss_conf, 0, sizeof(struct ixgbe_rte_flow_rss_conf));
 	ret = ixgbe_parse_rss_filter(dev, attr,
 					actions, &rss_conf, error);
 	if (!ret) {
@@ -319,8 +326,7 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 			rte_free(rss_filter_ptr);
 			goto out;
 		}
-		ixgbe_rss_conf_init(&rss_filter_ptr->filter_info,
-				    &rss_conf.conf);
+		rss_filter_ptr->filter_info = rss_conf;
 		flow->rule = rss_filter_ptr;
 		flow->filter_type = RTE_ETH_FILTER_HASH;
 		return flow;
@@ -350,7 +356,7 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 		struct rte_flow_error *error)
 {
 	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct ixgbe_rte_flow_rss_conf rss_conf;
+	struct ixgbe_rss_conf rss_conf = {0};
 	int ret;
 
 	/* try the new flow engine first */
@@ -360,7 +366,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 
 	/* fall back to legacy engines */
 
-	memset(&rss_conf, 0, sizeof(struct ixgbe_rte_flow_rss_conf));
 	ret = ixgbe_parse_rss_filter(dev, attr,
 					actions, &rss_conf, error);
 
@@ -488,7 +493,7 @@ ixgbe_flow_rule_size(const struct rte_flow *flow)
 	case RTE_ETH_FILTER_L2_TUNNEL:
 		return sizeof(struct ixgbe_l2_tunnel_conf);
 	case RTE_ETH_FILTER_HASH:
-		return sizeof(struct ixgbe_rte_flow_rss_conf);
+		return sizeof(struct ixgbe_rss_conf);
 	default:
 		return 0;
 	}
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 60222693fe8..f91d648364a 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -6098,42 +6098,40 @@ ixgbevf_dev_rxtx_start(struct rte_eth_dev *dev)
 }
 
 int
-ixgbe_rss_conf_init(struct ixgbe_rte_flow_rss_conf *out,
-		    const struct rte_flow_action_rss *in)
+ixgbe_rss_conf_init(struct ixgbe_rss_conf *out,
+		const struct rte_flow_action_rss *in)
 {
-	if (in->key_len > RTE_DIM(out->key) ||
-	    in->queue_num > RTE_DIM(out->queue))
+	if (in->key_len > RTE_DIM(out->key) || in->queue_num > RTE_DIM(out->queue))
 		return -EINVAL;
-	out->conf = (struct rte_flow_action_rss){
-		.func = in->func,
-		.level = in->level,
+
+	*out = (struct ixgbe_rss_conf){
 		.types = in->types,
 		.key_len = in->key_len,
 		.queue_num = in->queue_num,
-		.key = memcpy(out->key, in->key, in->key_len),
-		.queue = memcpy(out->queue, in->queue,
-				sizeof(*in->queue) * in->queue_num),
 	};
+	if (in->key_len != 0)
+		memcpy(out->key, in->key, in->key_len);
+	if (in->queue_num != 0)
+		memcpy(out->queue, in->queue, sizeof(*in->queue) * in->queue_num);
+
 	return 0;
 }
 
-int
-ixgbe_action_rss_same(const struct rte_flow_action_rss *comp,
-		      const struct rte_flow_action_rss *with)
+static bool
+ixgbe_rss_conf_same(const struct ixgbe_rss_conf *comp,
+		const struct ixgbe_rss_conf *with)
 {
-	return (comp->func == with->func &&
-		comp->level == with->level &&
-		comp->types == with->types &&
+	return comp->types == with->types &&
 		comp->key_len == with->key_len &&
 		comp->queue_num == with->queue_num &&
-		!memcmp(comp->key, with->key, with->key_len) &&
-		!memcmp(comp->queue, with->queue,
-			sizeof(*with->queue) * with->queue_num));
+		memcmp(comp->key, with->key, with->key_len) == 0 &&
+		memcmp(comp->queue, with->queue,
+			sizeof(*with->queue) * with->queue_num) == 0;
 }
 
 int
 ixgbe_config_rss_filter(struct ixgbe_adapter *adapter,
-		struct ixgbe_rte_flow_rss_conf *conf, bool add)
+		const struct ixgbe_rss_conf *conf, bool add)
 {
 	struct ixgbe_hw *hw;
 	uint32_t reta;
@@ -6142,10 +6140,10 @@ ixgbe_config_rss_filter(struct ixgbe_adapter *adapter,
 	uint16_t sp_reta_size;
 	uint32_t reta_reg;
 	struct rte_eth_rss_conf rss_conf = {
-		.rss_key = conf->conf.key_len ?
-			(void *)(uintptr_t)conf->conf.key : NULL,
-		.rss_key_len = conf->conf.key_len,
-		.rss_hf = conf->conf.types,
+		.rss_key = conf->key_len ?
+			(void *)(uintptr_t)conf->key : NULL,
+		.rss_key_len = conf->key_len,
+		.rss_hf = conf->types,
 	};
 	struct ixgbe_filter_info *filter_info =
 		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(adapter);
@@ -6156,17 +6154,15 @@ ixgbe_config_rss_filter(struct ixgbe_adapter *adapter,
 	sp_reta_size = ixgbe_reta_size_get(hw->mac.type);
 
 	if (!add) {
-		if (ixgbe_action_rss_same(&filter_info->rss_info.conf,
-					  &conf->conf)) {
+		if (ixgbe_rss_conf_same(&filter_info->rss_info, conf)) {
 			ixgbe_mrqc_rss_remove(hw);
-			memset(&filter_info->rss_info, 0,
-				sizeof(struct ixgbe_rte_flow_rss_conf));
+			filter_info->rss_info = (struct ixgbe_rss_conf){0};
 			return 0;
 		}
 		return -EINVAL;
 	}
 
-	if (filter_info->rss_info.conf.queue_num)
+	if (filter_info->rss_info.queue_num)
 		return -EINVAL;
 	/* Fill in redirection table
 	 * The byte-swap is needed because NIC registers are in
@@ -6176,9 +6172,9 @@ ixgbe_config_rss_filter(struct ixgbe_adapter *adapter,
 	for (i = 0, j = 0; i < sp_reta_size; i++, j++) {
 		reta_reg = ixgbe_reta_reg_get(hw->mac.type, i);
 
-		if (j == conf->conf.queue_num)
+		if (j == conf->queue_num)
 			j = 0;
-		reta = (reta << 8) | conf->conf.queue[j];
+		reta = (reta << 8) | conf->queue[j];
 		if ((i & 3) == 3)
 			IXGBE_WRITE_REG(hw, reta_reg,
 					rte_bswap32(reta));
@@ -6195,8 +6191,7 @@ ixgbe_config_rss_filter(struct ixgbe_adapter *adapter,
 		rss_conf.rss_key = rss_intel_key; /* Default hash key */
 	ixgbe_hw_rss_hash_set(hw, &rss_conf);
 
-	if (ixgbe_rss_conf_init(&filter_info->rss_info, &conf->conf))
-		return -EINVAL;
+	filter_info->rss_info = *conf;
 
 	return 0;
 }
-- 
2.52.0

