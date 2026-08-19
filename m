Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24138C5DF81
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 14:24:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A80B40678;
	Wed, 19 Aug 2026 16:24:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 409F0402C4
 for <dev@dpdk.org>; Wed, 19 Aug 2026 16:24:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787149443; x=1818685443;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=x+7HJFU2nFkU9YQV9EPnIrpYEqKgmb0DrYZ8WB+zHUc=;
 b=R+RFHdjYQQyE5Sv6rVJseE6bExcdIGqhWDzuT0/X+gzBLVueS/oxjEFY
 SBKSqC2JuQnpPE0gcoMGxFxZ+FjApSQJaWEnYeZdYG/CF6nL4Ic/OzxuJ
 2AT29unc4e3ip2oLqiX7yaS2vxh5MACfLVaqih4hBIotx8HHUCo455q53
 uOgxRFytrHIQWwosaOrqBG3PXJJpa7oseVorF9sgLP95TXvfgn4HbolSl
 LyIujdrbezNpiJXs4DSgNPj/+xHWpfrG0bMg7jylTbPFSnZ4S32Qjudbk
 UCXKjr9dmW1YLG8N9/ySGPevIk/LVfWWowfQmTDfYdnWNUlQ8STEqzEHl w==;
X-CSE-ConnectionGUID: uToIZGKRTtK44z7ZB06k6w==
X-CSE-MsgGUID: adbOD5K1R9SocJ/XlpwNsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="86785505"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="86785505"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 07:24:03 -0700
X-CSE-ConnectionGUID: DNb1AgzvS1SlTU4LPcwZwQ==
X-CSE-MsgGUID: vMSuvcu+QHKnOfmzIttAVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="261357656"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa006.fm.intel.com with ESMTP; 19 Aug 2026 07:24:02 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 2/2] net/i40e: move mutable fields out of RSS config
Date: Wed, 19 Aug 2026 15:23:57 +0100
Message-ID: <bfd90d7d858b171b8951d6dfc3595755ec84c0c7.1787149329.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787149329.git.anatoly.burakov@intel.com>
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

Currently, the RSS filter configuration structure contains both data that
is received from rte_flow API call, as well as some metadata for internal
use (to decide on whether to reset the RSS configuration when removing the
flow).

To separate these, move the metadata out of RSS configuration into a
separate structure stored in RSS filter node.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.h |  7 +++
 drivers/net/intel/i40e/i40e_hash.c   | 86 ++++++++++++++--------------
 2 files changed, 50 insertions(+), 43 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index b6f341169f..1e64a2d280 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -1071,7 +1071,13 @@ struct i40e_rte_flow_rss_conf {
 	uint8_t region_priority;	/**< queue region priority */
 	uint8_t region_queue_num;	/**< region queue number */
 	uint16_t region_queue_start;	/**< region queue start */
+};
 
+/*
+ * Metadata for an installed RSS filter. Records which parts of the RSS
+ * configuration this filter owns, so they can be reset when filter is removed.
+ */
+struct i40e_rss_filter_data {
 	uint32_t misc_reset_flags;
 #define I40E_HASH_FLOW_RESET_FLAG_FUNC		0x01UL
 #define I40E_HASH_FLOW_RESET_FLAG_KEY		0x02UL
@@ -1088,6 +1094,7 @@ struct i40e_rte_flow_rss_conf {
 struct i40e_rss_filter {
 	TAILQ_ENTRY(i40e_rss_filter) next;
 	struct i40e_rte_flow_rss_conf rss_filter_info;
+	struct i40e_rss_filter_data filter_data;
 };
 
 TAILQ_HEAD(i40e_rss_conf_list, i40e_rss_filter);
diff --git a/drivers/net/intel/i40e/i40e_hash.c b/drivers/net/intel/i40e/i40e_hash.c
index 2887460125..17adcbaa27 100644
--- a/drivers/net/intel/i40e/i40e_hash.c
+++ b/drivers/net/intel/i40e/i40e_hash.c
@@ -827,8 +827,10 @@ i40e_hash_config_region(struct i40e_pf *pf,
 
 static int
 i40e_hash_config(struct i40e_pf *pf,
-		 struct i40e_rte_flow_rss_conf *rss_conf)
+		 struct i40e_rss_filter *filter)
 {
+	struct i40e_rte_flow_rss_conf *rss_conf = &filter->rss_filter_info;
+	struct i40e_rss_filter_data *filter_data = &filter->filter_data;
 	struct i40e_hw *hw = &pf->adapter->hw;
 	uint64_t pctypes;
 	int ret;
@@ -839,7 +841,7 @@ i40e_hash_config(struct i40e_pf *pf,
 			return ret;
 
 		if (rss_conf->func != RTE_ETH_HASH_FUNCTION_TOEPLITZ)
-			rss_conf->misc_reset_flags |=
+			filter_data->misc_reset_flags |=
 					I40E_HASH_FLOW_RESET_FLAG_FUNC;
 	}
 
@@ -848,7 +850,7 @@ i40e_hash_config(struct i40e_pf *pf,
 		if (ret)
 			return ret;
 
-		rss_conf->misc_reset_flags |= I40E_HASH_FLOW_RESET_FLAG_REGION;
+		filter_data->misc_reset_flags |= I40E_HASH_FLOW_RESET_FLAG_REGION;
 	}
 
 	if (rss_conf->key_len > 0) {
@@ -857,7 +859,7 @@ i40e_hash_config(struct i40e_pf *pf,
 		if (ret)
 			return ret;
 
-		rss_conf->misc_reset_flags |= I40E_HASH_FLOW_RESET_FLAG_KEY;
+		filter_data->misc_reset_flags |= I40E_HASH_FLOW_RESET_FLAG_KEY;
 	}
 
 	/* Update lookup table */
@@ -879,7 +881,7 @@ i40e_hash_config(struct i40e_pf *pf,
 			pf->hash_enabled_queues |= BIT_ULL(lut[i]);
 
 		pf->adapter->rss_reta_updated = 0;
-		rss_conf->misc_reset_flags |= I40E_HASH_FLOW_RESET_FLAG_QUEUE;
+		filter_data->misc_reset_flags |= I40E_HASH_FLOW_RESET_FLAG_QUEUE;
 	}
 
 	/* The codes behind configure the input sets and symmetric hash
@@ -906,14 +908,14 @@ i40e_hash_config(struct i40e_pf *pf,
 			if (ret)
 				return ret;
 
-			rss_conf->reset_symmetric_pctypes |= bit;
+			filter_data->reset_symmetric_pctypes |= bit;
 		}
 
 		ret = i40e_hash_config_pctype(hw, rss_conf, idx);
 		if (ret)
 			return ret;
 
-		rss_conf->reset_config_pctypes |= bit;
+		filter_data->reset_config_pctypes |= bit;
 		pctypes &= ~bit;
 	} while (pctypes);
 
@@ -1306,21 +1308,25 @@ i40e_hash_parse(struct rte_eth_dev *dev,
 }
 
 static void
-i40e_invalid_rss_filter(const struct i40e_rte_flow_rss_conf *ref_conf,
-			struct i40e_rte_flow_rss_conf *conf)
+i40e_invalid_rss_filter(const struct i40e_rss_filter *ref,
+			struct i40e_rss_filter *filter)
 {
-	uint32_t reset_flags = conf->misc_reset_flags;
+	const struct i40e_rte_flow_rss_conf *ref_conf = &ref->rss_filter_info;
+	const struct i40e_rss_filter_data *ref_data = &ref->filter_data;
+	const struct i40e_rte_flow_rss_conf *conf = &filter->rss_filter_info;
+	struct i40e_rss_filter_data *data = &filter->filter_data;
+	uint32_t reset_flags = data->misc_reset_flags;
 
-	conf->misc_reset_flags &= ~ref_conf->misc_reset_flags;
+	data->misc_reset_flags &= ~ref_data->misc_reset_flags;
 
 	if ((reset_flags & I40E_HASH_FLOW_RESET_FLAG_REGION) &&
-	    (ref_conf->misc_reset_flags & I40E_HASH_FLOW_RESET_FLAG_REGION) &&
+	    (ref_data->misc_reset_flags & I40E_HASH_FLOW_RESET_FLAG_REGION) &&
 	    (conf->region_queue_start != ref_conf->region_queue_start ||
 	     conf->region_queue_num != ref_conf->region_queue_num))
-		conf->misc_reset_flags |= I40E_HASH_FLOW_RESET_FLAG_REGION;
+		data->misc_reset_flags |= I40E_HASH_FLOW_RESET_FLAG_REGION;
 
-	conf->reset_config_pctypes &= ~ref_conf->reset_config_pctypes;
-	conf->reset_symmetric_pctypes &= ~ref_conf->reset_symmetric_pctypes;
+	data->reset_config_pctypes &= ~ref_data->reset_config_pctypes;
+	data->reset_symmetric_pctypes &= ~ref_data->reset_symmetric_pctypes;
 }
 
 int
@@ -1330,15 +1336,11 @@ i40e_hash_filter_restore(struct i40e_pf *pf)
 	int ret;
 
 	TAILQ_FOREACH(filter, &pf->rss_config_list, next) {
-		struct i40e_rte_flow_rss_conf *rss_conf =
-						&filter->rss_filter_info;
 		struct i40e_rss_filter *prev;
 
-		rss_conf->misc_reset_flags = 0;
-		rss_conf->reset_config_pctypes = 0;
-		rss_conf->reset_symmetric_pctypes = 0;
+		filter->filter_data = (struct i40e_rss_filter_data){0};
 
-		ret = i40e_hash_config(pf, rss_conf);
+		ret = i40e_hash_config(pf, filter);
 		if (ret) {
 			pf->hash_filter_enabled = 0;
 			i40e_pf_disable_rss(pf);
@@ -1351,8 +1353,7 @@ i40e_hash_filter_restore(struct i40e_pf *pf)
 		TAILQ_FOREACH(prev, &pf->rss_config_list, next) {
 			if (prev == filter)
 				break;
-			i40e_invalid_rss_filter(rss_conf,
-						&prev->rss_filter_info);
+			i40e_invalid_rss_filter(filter, prev);
 		}
 	}
 
@@ -1377,7 +1378,7 @@ i40e_hash_filter_create(struct i40e_pf *pf,
 
 	memcpy(new_conf, rss_conf, sizeof(*new_conf));
 
-	ret = i40e_hash_config(pf, new_conf);
+	ret = i40e_hash_config(pf, filter);
 	if (ret) {
 		rte_free(filter);
 		if (i40e_pf_config_rss(pf))
@@ -1389,7 +1390,7 @@ i40e_hash_filter_create(struct i40e_pf *pf,
 
 	/* Invalid previous RSS filter */
 	TAILQ_FOREACH(prev, &pf->rss_config_list, next)
-		i40e_invalid_rss_filter(new_conf, &prev->rss_filter_info);
+		i40e_invalid_rss_filter(filter, prev);
 
 	TAILQ_INSERT_TAIL(&pf->rss_config_list, filter, next);
 	return 0;
@@ -1397,7 +1398,7 @@ i40e_hash_filter_create(struct i40e_pf *pf,
 
 static int
 i40e_hash_reset_conf(struct i40e_pf *pf,
-		     struct i40e_rte_flow_rss_conf *rss_conf)
+		     struct i40e_rss_filter_data *filter_data)
 {
 	struct i40e_hw *hw = &pf->adapter->hw;
 	struct rte_eth_dev *dev;
@@ -1405,32 +1406,32 @@ i40e_hash_reset_conf(struct i40e_pf *pf,
 	uint32_t idx;
 	int ret;
 
-	if (rss_conf->misc_reset_flags & I40E_HASH_FLOW_RESET_FLAG_FUNC) {
+	if (filter_data->misc_reset_flags & I40E_HASH_FLOW_RESET_FLAG_FUNC) {
 		ret = i40e_hash_config_func(hw, RTE_ETH_HASH_FUNCTION_TOEPLITZ);
 		if (ret)
 			return ret;
 
-		rss_conf->misc_reset_flags &= ~I40E_HASH_FLOW_RESET_FLAG_FUNC;
+		filter_data->misc_reset_flags &= ~I40E_HASH_FLOW_RESET_FLAG_FUNC;
 	}
 
-	if (rss_conf->misc_reset_flags & I40E_HASH_FLOW_RESET_FLAG_REGION) {
+	if (filter_data->misc_reset_flags & I40E_HASH_FLOW_RESET_FLAG_REGION) {
 		dev = &rte_eth_devices[pf->dev_data->port_id];
 		ret = i40e_flush_queue_region_all_conf(dev, hw, pf, 0);
 		if (ret)
 			return ret;
 
-		rss_conf->misc_reset_flags &= ~I40E_HASH_FLOW_RESET_FLAG_REGION;
+		filter_data->misc_reset_flags &= ~I40E_HASH_FLOW_RESET_FLAG_REGION;
 	}
 
-	if (rss_conf->misc_reset_flags & I40E_HASH_FLOW_RESET_FLAG_KEY) {
+	if (filter_data->misc_reset_flags & I40E_HASH_FLOW_RESET_FLAG_KEY) {
 		ret = i40e_pf_reset_rss_key(pf);
 		if (ret)
 			return ret;
 
-		rss_conf->misc_reset_flags &= ~I40E_HASH_FLOW_RESET_FLAG_KEY;
+		filter_data->misc_reset_flags &= ~I40E_HASH_FLOW_RESET_FLAG_KEY;
 	}
 
-	if (rss_conf->misc_reset_flags & I40E_HASH_FLOW_RESET_FLAG_QUEUE) {
+	if (filter_data->misc_reset_flags & I40E_HASH_FLOW_RESET_FLAG_QUEUE) {
 		if (!pf->adapter->rss_reta_updated) {
 			ret = i40e_pf_reset_rss_reta(pf);
 			if (ret)
@@ -1438,11 +1439,11 @@ i40e_hash_reset_conf(struct i40e_pf *pf,
 		}
 
 		pf->hash_enabled_queues = 0;
-		rss_conf->misc_reset_flags &= ~I40E_HASH_FLOW_RESET_FLAG_QUEUE;
+		filter_data->misc_reset_flags &= ~I40E_HASH_FLOW_RESET_FLAG_QUEUE;
 	}
 
-	while (rss_conf->reset_config_pctypes) {
-		idx = rte_bsf64(rss_conf->reset_config_pctypes);
+	while (filter_data->reset_config_pctypes) {
+		idx = rte_bsf64(filter_data->reset_config_pctypes);
 
 		i40e_hash_enable_pctype(hw, idx, false);
 		inset = i40e_get_default_input_set(idx);
@@ -1452,17 +1453,17 @@ i40e_hash_reset_conf(struct i40e_pf *pf,
 				return ret;
 		}
 
-		rss_conf->reset_config_pctypes &= ~BIT_ULL(idx);
+		filter_data->reset_config_pctypes &= ~BIT_ULL(idx);
 	}
 
-	while (rss_conf->reset_symmetric_pctypes) {
-		idx = rte_bsf64(rss_conf->reset_symmetric_pctypes);
+	while (filter_data->reset_symmetric_pctypes) {
+		idx = rte_bsf64(filter_data->reset_symmetric_pctypes);
 
 		ret = i40e_hash_config_pctype_symmetric(hw, idx, false);
 		if (ret)
 			return ret;
 
-		rss_conf->reset_symmetric_pctypes &= ~BIT_ULL(idx);
+		filter_data->reset_symmetric_pctypes &= ~BIT_ULL(idx);
 	}
 
 	return 0;
@@ -1477,8 +1478,7 @@ i40e_hash_filter_destroy(struct i40e_pf *pf,
 
 	TAILQ_FOREACH(filter, &pf->rss_config_list, next) {
 		if (rss_filter == filter) {
-			ret = i40e_hash_reset_conf(pf,
-						   &filter->rss_filter_info);
+			ret = i40e_hash_reset_conf(pf, &filter->filter_data);
 			if (ret)
 				return ret;
 
@@ -1505,7 +1505,7 @@ i40e_hash_filter_flush(struct i40e_pf *pf)
 			int ret;
 
 			ret = i40e_hash_reset_conf(pf,
-						   &filter->rss_filter_info);
+						   &filter->filter_data);
 			if (ret)
 				return ret;
 
-- 
2.52.0

