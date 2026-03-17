Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AD0FD706B
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 10:32:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AEF0402B0;
	Tue, 17 Mar 2026 11:32:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id AD1A140270;
 Tue, 17 Mar 2026 11:32:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773743573; x=1805279573;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Shfg0ARJ8NU2Wc9Kteetkpwb4vjhvn6mVfsKW4+CLlw=;
 b=jFLg62U3VKB+CyircROegx3OW84Kji74WaQT05+GM2Wl6C3Ce6UZvGnm
 PuZ8aCHpF/K2TSTzdoYOWPlckign4w4JJPFTb4cgvqH4od2DDJXKh+faZ
 o7El+S1cJP/csLOgfiVYHkMYGFhSy+t/Tgt+dYyBujsEPjKtTwOq6nqy/
 5++FEJYo/Tbf7OwPxLBWLtiRNbBHX1b7uwaUpFClXPS6DRn1gFseJNlxI
 VgWIau+ftiHM19F/nFz4sI+FCkAnchONdt7X/UAymIC7uXmJHXOwNnHRH
 wELef51L/IswEQYS22HQKOtbw9MRhv7i9y5hi/v4LpBAgkPqfbjmx2Ff3 A==;
X-CSE-ConnectionGUID: YlKiYHJjSjCgRsMNd1LfTw==
X-CSE-MsgGUID: L4vX9N5bSo2GEie9dC4BUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="78376571"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="78376571"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 03:32:50 -0700
X-CSE-ConnectionGUID: 99KV1aZ2QdefDiBSnZCj8A==
X-CSE-MsgGUID: lY76TaDUQwKCNbPqAT0KyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="222280368"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa008.jf.intel.com with ESMTP; 17 Mar 2026 03:32:48 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 vladimir.medvedkin@intel.com, qiming.yang@intel.com, alex.chapman@arm.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH v2] net/ice: fix RSS hash function implementation
Date: Tue, 17 Mar 2026 10:32:03 +0000
Message-Id: <20260317103203.404781-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309023255.308526-1-anurag.mandal@intel.com>
References: <20260309023255.308526-1-anurag.mandal@intel.com>
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

Hash function type is not meaningful for non-empty patterns as they
are per VSI i.e. they are set globally only &  not per pattern.
So, for non-empty patterns, user should not specify hash function.
ICE PMD does not adhere to these rules.

This patch fixes that by implementing the following:
- interpret "default" hash function as "currently set up"
- store the "current" hash function globally per VSI
- for empty patterns, overwrite the setting
- for non-empty patterns, disallow hash function that is not "default"
or does not match currently selected global hash function type

Tested the following:
1. non-empty pattern with default hash function
2. empty pattern with simple_xor/symmetric_toeplitz hash function
3. non-empty pattern with simple_xor/symmetric_toeplitz hash function
4. empty pattern with no/default hash function

Bugzilla ID: 1518
Fixes: 0b952714e9c1 ("net/ice: refactor PF hash flow")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
V2: Addressed Vladimir Medvedkin's feedback
 - interpret "default" hash function as "whatever is currently set up"
 - store the "current" hash function globally somewhere (in VSI context)
 - for empty patterns, overwrite the setting
 - for non-empty patterns, disallow hash function that is not "default" 
   or does not match currently selected global hash function type

 drivers/net/intel/ice/ice_ethdev.c |  3 +++
 drivers/net/intel/ice/ice_ethdev.h |  1 +
 drivers/net/intel/ice/ice_hash.c   | 20 ++++++++++++++++----
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 0d6b030536..0948a8cb23 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -3741,6 +3741,7 @@ static int ice_init_rss(struct ice_pf *pf)
 	vsi->rss_key_size = ICE_AQC_GET_SET_RSS_KEY_DATA_RSS_KEY_SIZE +
 			    ICE_AQC_GET_SET_RSS_KEY_DATA_HASH_KEY_SIZE;
 	vsi->rss_lut_size = pf->hash_lut_size;
+	vsi->hash_function = rss_conf->algorithm;
 
 	if (nb_q == 0) {
 		PMD_DRV_LOG(WARNING,
@@ -5700,6 +5701,8 @@ ice_rss_hash_update(struct rte_eth_dev *dev,
 	if (rss_conf->rss_hf == 0)
 		pf->rss_hf = 0;
 
+	vsi->hash_function = rss_conf->algorithm;
+
 	/* RSS hash configuration */
 	ice_rss_hash_set(pf, rss_conf->rss_hf);
 
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 4b3718f715..d8a01fe7fa 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -351,6 +351,7 @@ struct ice_vsi {
 	bool offset_loaded;
 	/* holds previous values so limitations can be enlarged to 64 bits */
 	struct ice_vsi_get_stats_fields old_get_stats_fields;
+	enum rte_eth_hash_function hash_function;
 };
 
 enum proto_xtr_type {
diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
index 77829e607b..8e97a6fd42 100644
--- a/drivers/net/intel/ice/ice_hash.c
+++ b/drivers/net/intel/ice/ice_hash.c
@@ -1084,6 +1084,10 @@ ice_any_invalid_rss_type(enum rte_eth_hash_function rss_func,
 	/* check not allowed RSS type */
 	rss_type &= ~VALID_RSS_ATTR;
 
+	/* For Empty patterns */
+	if (!allow_rss_type)
+		return false;
+
 	return ((rss_type & allow_rss_type) != rss_type);
 }
 
@@ -1091,7 +1095,8 @@ static int
 ice_hash_parse_action(struct ice_pattern_match_item *pattern_match_item,
 		const struct rte_flow_action actions[],
 		uint64_t pattern_hint, struct ice_rss_meta *rss_meta,
-		struct rte_flow_error *error)
+		struct rte_flow_error *error,
+		enum rte_eth_hash_function *vsi_hash_function)
 {
 	struct ice_rss_hash_cfg *cfg = pattern_match_item->meta;
 	enum rte_flow_action_type action_type;
@@ -1110,8 +1115,8 @@ ice_hash_parse_action(struct ice_pattern_match_item *pattern_match_item,
 
 			/* Check hash function and save it to rss_meta. */
 			if (pattern_match_item->pattern_list !=
-			    pattern_empty && rss->func ==
-			    RTE_ETH_HASH_FUNCTION_SIMPLE_XOR) {
+			    pattern_empty && rss->func &&
+			    rss->func != *vsi_hash_function) {
 				return rte_flow_error_set(error, ENOTSUP,
 					RTE_FLOW_ERROR_TYPE_ACTION, action,
 					"Not supported flow");
@@ -1119,6 +1124,7 @@ ice_hash_parse_action(struct ice_pattern_match_item *pattern_match_item,
 				   RTE_ETH_HASH_FUNCTION_SIMPLE_XOR){
 				rss_meta->hash_function =
 				RTE_ETH_HASH_FUNCTION_SIMPLE_XOR;
+				*vsi_hash_function = rss_meta->hash_function;
 				return 0;
 			} else if (rss->func ==
 				   RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ) {
@@ -1161,7 +1167,12 @@ ice_hash_parse_action(struct ice_pattern_match_item *pattern_match_item,
 					RTE_FLOW_ERROR_TYPE_ACTION,
 					action, "RSS type not supported");
 
+			/* For Empty patterns*/
+			if (cfg->hash_flds == ICE_HASH_INVALID)
+				cfg->hash_flds = 1;
 			rss_meta->cfg = *cfg;
+			if (rss->func)
+				*vsi_hash_function = rss_meta->hash_function;
 			ice_refine_hash_cfg(&rss_meta->cfg,
 					    rss_type, pattern_hint);
 			break;
@@ -1193,6 +1204,7 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 	struct ice_pattern_match_item *pattern_match_item;
 	struct ice_rss_meta *rss_meta_ptr;
 	uint64_t phint = ICE_PHINT_NONE;
+	struct ice_vsi *vsi = ad->pf.main_vsi;
 
 	if (priority >= 1)
 		return -rte_errno;
@@ -1230,7 +1242,7 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 
 	/* Check rss action. */
 	ret = ice_hash_parse_action(pattern_match_item, actions, phint,
-				    rss_meta_ptr, error);
+				    rss_meta_ptr, error, &vsi->hash_function);
 
 error:
 	if (!ret && meta)
-- 
2.34.1

