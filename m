Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01149C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 09:15:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BA814065A;
	Fri, 21 Aug 2026 11:15:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id BE26C4027B
 for <dev@dpdk.org>; Fri, 21 Aug 2026 11:15:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787303737; x=1818839737;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=aUa3hX5lcD2I4hQydsqx8sAg/JwG+2ANdLxEXuCoxAM=;
 b=BhPR2Sbz5LRbvcnjjn+stxXkefLXxT3FBfFmqmsWosLavhGYP1glmY8j
 xfLp1g2Qe5hpZIdxVqMEKd4sQQvUB6kyPqBgf4G0NybQ12qaCbtWZ7dxs
 N934t1jhOxfSfciiU/daeI1FkGhnyW1lAMVEkqYDNt7Rnz/UPQokhDEtZ
 JRIbo944T3SZlUVFbQgd5XS9swkWuZHlMnVakBaw2c/OFWE4fVpauA9XR
 fqCxaQnTvvfpRMdCzfjgozUbLP4t9PjtpIx1SMv6gmWXV0NNzAAPg/wgQ
 GtiYf37+4+klomL1uM5GQnsuiRsRsHjyloG34NmZOdRAAQQWsW7jTImTR Q==;
X-CSE-ConnectionGUID: iXoQZVlPSFS/wL9jq91WBA==
X-CSE-MsgGUID: xk5DqO2PTlyS6Nhpi1wXWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87979121"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; d="scan'208";a="87979121"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 02:15:36 -0700
X-CSE-ConnectionGUID: 78bS9IkqQX23icMsQP49WA==
X-CSE-MsgGUID: Adky01QKTHWQn66LXeIY2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; d="scan'208";a="269763859"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 21 Aug 2026 02:15:35 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 1/2] net/i40e: do not use flow RSS conf struct
Date: Fri, 21 Aug 2026 10:15:30 +0100
Message-ID: <f7d315f9310b362e46e7a1e342ed20b6576d347e.1787303683.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787303683.git.anatoly.burakov@intel.com>
 <cover.1787303683.git.anatoly.burakov@intel.com>
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

Currently, the RSS filter structure includes an rte_flow RSS conf structure
directly. This is suboptimal, because that structure has pointers in it,
which makes copying data out of this structure a non-trivial operation that
may introduce potentially dangling pointers to queue lists or RSS key.

Replace it with direct members of the RSS config struct, and adjust all
users accordingly.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.h | 11 +++++---
 drivers/net/intel/i40e/i40e_flow.c   | 13 +++++++---
 drivers/net/intel/i40e/i40e_hash.c   | 39 ++++++++++++----------------
 drivers/net/intel/i40e/i40e_hash.h   |  1 -
 4 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 9d9bde6aeb..b6f341169f 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -1053,12 +1053,15 @@ struct i40e_customized_pctype {
 	bool valid;   /* Check if it's valid */
 };
 
+#define I40E_RSS_KEY_LEN ((I40E_PFQF_HKEY_MAX_INDEX + 1) * sizeof(uint32_t))
+
 struct i40e_rte_flow_rss_conf {
-	struct rte_flow_action_rss conf;	/**< RSS parameters. */
+	enum rte_eth_hash_function func;
+	uint64_t types; /**< Specific RSS hash types (see RTE_ETH_RSS_*). */
+	uint32_t key_len; /**< Hash key length in bytes. */
+	uint32_t queue_num; /**< Number of entries in @p queue. */
 
-	uint8_t key[(I40E_VFQF_HKEY_MAX_INDEX > I40E_PFQF_HKEY_MAX_INDEX ?
-		     I40E_VFQF_HKEY_MAX_INDEX : I40E_PFQF_HKEY_MAX_INDEX + 1) *
-		    sizeof(uint32_t)];		/**< Hash key. */
+	uint8_t key[I40E_RSS_KEY_LEN];		/**< Hash key. */
 	uint16_t queue[RTE_ETH_RSS_RETA_SIZE_512];	/**< Queues indices to use. */
 
 	bool symmetric_enable;		/**< true, if enable symmetric */
diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 6eb85a7d0d..a017d3cd44 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -4338,9 +4338,16 @@ i40e_flow_query(struct rte_eth_dev *dev __rte_unused,
 						   "action not supported");
 				return -rte_errno;
 			}
-			memcpy(rss_conf,
-				   &rss_rule->rss_filter_info.conf,
-				   sizeof(struct rte_flow_action_rss));
+			*rss_conf = (struct rte_flow_action_rss){
+				.func = rss_rule->rss_filter_info.func,
+				.types = rss_rule->rss_filter_info.types,
+				.key_len = rss_rule->rss_filter_info.key_len,
+				.queue_num = rss_rule->rss_filter_info.queue_num,
+				.key = rss_rule->rss_filter_info.key_len ?
+					rss_rule->rss_filter_info.key : NULL,
+				.queue = rss_rule->rss_filter_info.queue_num ?
+					rss_rule->rss_filter_info.queue : NULL,
+			};
 			break;
 		default:
 			return rte_flow_error_set(error, ENOTSUP,
diff --git a/drivers/net/intel/i40e/i40e_hash.c b/drivers/net/intel/i40e/i40e_hash.c
index 6a23e2bf7f..2887460125 100644
--- a/drivers/net/intel/i40e/i40e_hash.c
+++ b/drivers/net/intel/i40e/i40e_hash.c
@@ -747,7 +747,7 @@ i40e_hash_config_pctype(struct i40e_hw *hw,
 			struct i40e_rte_flow_rss_conf *rss_conf,
 			uint32_t pctype)
 {
-	uint64_t rss_types = rss_conf->conf.types;
+	uint64_t rss_types = rss_conf->types;
 	int ret;
 
 	if (rss_types == 0) {
@@ -829,17 +829,16 @@ static int
 i40e_hash_config(struct i40e_pf *pf,
 		 struct i40e_rte_flow_rss_conf *rss_conf)
 {
-	struct rte_flow_action_rss *rss_info = &rss_conf->conf;
 	struct i40e_hw *hw = &pf->adapter->hw;
 	uint64_t pctypes;
 	int ret;
 
-	if (rss_info->func != RTE_ETH_HASH_FUNCTION_DEFAULT) {
-		ret = i40e_hash_config_func(hw, rss_info->func);
+	if (rss_conf->func != RTE_ETH_HASH_FUNCTION_DEFAULT) {
+		ret = i40e_hash_config_func(hw, rss_conf->func);
 		if (ret)
 			return ret;
 
-		if (rss_info->func != RTE_ETH_HASH_FUNCTION_TOEPLITZ)
+		if (rss_conf->func != RTE_ETH_HASH_FUNCTION_TOEPLITZ)
 			rss_conf->misc_reset_flags |=
 					I40E_HASH_FLOW_RESET_FLAG_FUNC;
 	}
@@ -852,9 +851,9 @@ i40e_hash_config(struct i40e_pf *pf,
 		rss_conf->misc_reset_flags |= I40E_HASH_FLOW_RESET_FLAG_REGION;
 	}
 
-	if (rss_info->key_len > 0) {
+	if (rss_conf->key_len > 0) {
 		ret = i40e_set_rss_key(pf->main_vsi, rss_conf->key,
-				       rss_info->key_len);
+				       rss_conf->key_len);
 		if (ret)
 			return ret;
 
@@ -862,13 +861,13 @@ i40e_hash_config(struct i40e_pf *pf,
 	}
 
 	/* Update lookup table */
-	if (rss_info->queue_num > 0) {
+	if (rss_conf->queue_num > 0) {
 		uint8_t lut[RTE_ETH_RSS_RETA_SIZE_512];
 		uint32_t i, j = 0;
 
 		for (i = 0; i < hw->func_caps.rss_table_size; i++) {
-			lut[i] = (uint8_t)rss_info->queue[j];
-			j = (j == rss_info->queue_num - 1) ? 0 : (j + 1);
+			lut[i] = (uint8_t)rss_conf->queue[j];
+			j = (j == rss_conf->queue_num - 1) ? 0 : (j + 1);
 		}
 
 		ret = i40e_set_rss_lut(pf->main_vsi, lut, (uint16_t)i);
@@ -876,7 +875,7 @@ i40e_hash_config(struct i40e_pf *pf,
 			return ret;
 
 		pf->hash_enabled_queues = 0;
-		for (i = 0; i < rss_info->queue_num; i++)
+		for (i = 0; i < rss_conf->queue_num; i++)
 			pf->hash_enabled_queues |= BIT_ULL(lut[i]);
 
 		pf->adapter->rss_reta_updated = 0;
@@ -933,8 +932,7 @@ i40e_hash_parse_key(const struct rte_flow_action_rss *rss_act,
 		memcpy(rss_conf->key, key, sizeof(rss_conf->key));
 	}
 
-	rss_conf->conf.key = rss_conf->key;
-	rss_conf->conf.key_len = sizeof(rss_conf->key);
+	rss_conf->key_len = sizeof(rss_conf->key);
 }
 
 static int
@@ -949,8 +947,8 @@ i40e_hash_parse_pattern_act(const struct rte_eth_dev *dev,
 	if (rss_act->key_len)
 		i40e_hash_parse_key(rss_act, rss_conf);
 
-	rss_conf->conf.func = rss_act->func;
-	rss_conf->conf.types = rss_act->types;
+	rss_conf->func = rss_act->func;
+	rss_conf->types = rss_act->types;
 	rss_conf->inset = i40e_hash_get_inset(rss_act->types, rss_conf->symmetric_enable);
 
 	return i40e_hash_get_pattern_pctypes(dev, pattern, rss_act,
@@ -963,8 +961,7 @@ i40e_hash_parse_queues(const struct rte_flow_action_rss *rss_act,
 {
 	memcpy(rss_conf->queue, rss_act->queue,
 	       rss_act->queue_num * sizeof(rss_conf->queue[0]));
-	rss_conf->conf.queue = rss_conf->queue;
-	rss_conf->conf.queue_num = rss_act->queue_num;
+	rss_conf->queue_num = rss_act->queue_num;
 	return 0;
 }
 
@@ -1277,7 +1274,7 @@ i40e_hash_parse(struct rte_eth_dev *dev,
 			return ret;
 		rss_act = parsed_actions.actions[0]->conf;
 		/* set up RSS functions */
-		rss_conf->conf.func = rss_act->func;
+		rss_conf->func = rss_act->func;
 		return i40e_hash_parse_queue_region(pattern, rss_act, rss_conf, error);
 	}
 	/* Empty pattern path */
@@ -1287,7 +1284,7 @@ i40e_hash_parse(struct rte_eth_dev *dev,
 		if (ret)
 			return ret;
 		rss_act = parsed_actions.actions[0]->conf;
-		rss_conf->conf.func = rss_act->func;
+		rss_conf->func = rss_act->func;
 		/* if there is a queue list, take that path */
 		if (rss_act->queue != NULL)
 			return i40e_hash_parse_queues(rss_act, rss_conf);
@@ -1379,10 +1376,6 @@ i40e_hash_filter_create(struct i40e_pf *pf,
 	new_conf = &filter->rss_filter_info;
 
 	memcpy(new_conf, rss_conf, sizeof(*new_conf));
-	if (new_conf->conf.queue_num)
-		new_conf->conf.queue = new_conf->queue;
-	if (new_conf->conf.key_len)
-		new_conf->conf.key = new_conf->key;
 
 	ret = i40e_hash_config(pf, new_conf);
 	if (ret) {
diff --git a/drivers/net/intel/i40e/i40e_hash.h b/drivers/net/intel/i40e/i40e_hash.h
index 99df4bccd0..3bf30cdee5 100644
--- a/drivers/net/intel/i40e/i40e_hash.h
+++ b/drivers/net/intel/i40e/i40e_hash.h
@@ -27,7 +27,6 @@ int i40e_hash_filter_destroy(struct i40e_pf *pf,
 			     const struct i40e_rss_filter *rss_filter);
 int i40e_hash_filter_flush(struct i40e_pf *pf);
 
-#define I40E_RSS_KEY_LEN ((I40E_PFQF_HKEY_MAX_INDEX + 1) * sizeof(uint32_t))
 extern const uint8_t i40e_rss_key_default[I40E_RSS_KEY_LEN];
 
 #ifdef __cplusplus
-- 
2.52.0

