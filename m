Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C87606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 12:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hp/l6dKP
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FE4E40687;
	Tue, 20 Oct 2026 14:11:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 551DF4066C
 for <dev@dpdk.org>; Tue, 20 Oct 2026 14:11:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792498277; x=1824034277;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=jaUBQ9n/2nIN1/x34bt+/InPxlV49GAIPq4qG9ocmjQ=;
 b=hp/l6dKPdLg/xWNBJN6257qpItlScw+OifPFfM34kTh4/+Hip7b5nhw2
 uv3VHcsm4x4xRjmAupWKv6XHEvcZ/GRsK8ZD7AgOcGMXZnqN0lWpOQ+C0
 s55h3T7nh2k5N27Dc2GKQ+eKDKZ0jhpoKkf914z7ge5t0ZUwY+yYpoVlV
 uw/AgD89cPURXlKQz/nVj7JyvRoJFR1gxG9o6l533pCfyZlP0Tm+KZmD8
 MdpVIgiISYZy91v7g9n53Hqdgbw7Pjn5YQK1hSYlKjsCHA3xps+U4181q
 YSNdq95d/hwEHbtrMK1JQ+t58zG1254I0a9fYOe+/q/iQ3Tx484mTiPun g==;
X-CSE-ConnectionGUID: re8fZn7LTZ6qJgB1hcOWTQ==
X-CSE-MsgGUID: +21A431HQTyDZOCxgtj13Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1101789"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1101789"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 05:11:17 -0700
X-CSE-ConnectionGUID: vbxRegYpTTOXmAV876A4cg==
X-CSE-MsgGUID: fkFYmQiLRHi7GFt5avf8QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3253905"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 20 Oct 2026 05:11:17 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 3/6] net/ice: standardize VOID handling in flow parsers
Date: Tue, 20 Oct 2026 13:11:06 +0100
Message-ID: <12811edcc0860be69711f2856fbab6fe82e27b57.1792498154.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792498154.git.anatoly.burakov@intel.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VOID handling differs between pattern matching and engine parsing.
Pattern matching relies on a temporary copy with VOID items removed,
while engines handle them independently. This temporary copy makes memory
management complicated, so we want to get rid of it.

However, before we can do that, we first need to standardize traversal of
the pattern so that all engines can skip over VOID items. Add shared
helpers to skip VOID items and iterate over non-VOID items, and use them
in pattern matching and all engines; also use them for item counting,
lookahead and RAW item lookup.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/ice_acl_filter.c    |  4 +---
 drivers/net/intel/ice/ice_fdir_filter.c   |  8 +++-----
 drivers/net/intel/ice/ice_generic_flow.c  | 11 +++++------
 drivers/net/intel/ice/ice_generic_flow.h  | 14 ++++++++++++++
 drivers/net/intel/ice/ice_hash.c          |  6 ++++--
 drivers/net/intel/ice/ice_switch_filter.c |  8 ++------
 6 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
index eb5d88ccc5..91f684c9b9 100644
--- a/drivers/net/intel/ice/ice_acl_filter.c
+++ b/drivers/net/intel/ice/ice_acl_filter.c
@@ -664,7 +664,7 @@ ice_acl_parse_pattern(__rte_unused struct ice_adapter *ad,
 	uint64_t input_set = ICE_INSET_NONE;
 	uint8_t flow_type = ICE_FLTR_PTYPE_NONF_NONE;
 
-	for (item = pattern; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
+	ICE_FLOW_FOREACH_ITEM(item, pattern) {
 		item_type = item->type;
 
 		switch (item_type) {
@@ -897,8 +897,6 @@ ice_acl_parse_pattern(__rte_unused struct ice_adapter *ad,
 				}
 			}
 			break;
-		case RTE_FLOW_ITEM_TYPE_VOID:
-			break;
 		default:
 			rte_flow_error_set(error, EINVAL,
 				RTE_FLOW_ERROR_TYPE_ITEM,
diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index 63a0d9fb1f..b1a8753e90 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -1904,7 +1904,7 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 	struct ice_parser_result rslt;
 	uint8_t item_num = 0;
 
-	for (item = pattern; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
+	ICE_FLOW_FOREACH_ITEM(item, pattern) {
 		if (item->type == RTE_FLOW_ITEM_TYPE_VXLAN)
 			tunnel_type = ICE_FDIR_TUNNEL_TYPE_VXLAN;
 		if (item->type == RTE_FLOW_ITEM_TYPE_L2TPV2)
@@ -1922,7 +1922,7 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 	/* This loop parse flow pattern and distinguish Non-tunnel and tunnel
 	 * flow. input_set_i is used for inner part.
 	 */
-	for (item = pattern; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
+	ICE_FLOW_FOREACH_ITEM(item, pattern) {
 		item_type = item->type;
 
 		if (item->last && !(item_type == RTE_FLOW_ITEM_TYPE_IPV4 ||
@@ -2065,7 +2065,7 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 			if (!rte_is_zero_ether_addr(&eth_mask->hdr.src_addr))
 				*input_set |= ICE_INSET_SMAC;
 
-			next_type = (item + 1)->type;
+			next_type = ice_pattern_skip_void(item + 1)->type;
 			/* Ignore this field except for ICE_FLTR_PTYPE_NON_IP_L2 */
 			if (eth_mask->hdr.ether_type == RTE_BE16(0xffff) &&
 			    next_type == RTE_FLOW_ITEM_TYPE_END) {
@@ -2471,8 +2471,6 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 				p_v6->src_port = sctp_spec->hdr.src_port;
 			}
 			break;
-		case RTE_FLOW_ITEM_TYPE_VOID:
-			break;
 		case RTE_FLOW_ITEM_TYPE_VXLAN:
 			l3 = RTE_FLOW_ITEM_TYPE_END;
 			vxlan_spec = item->spec;
diff --git a/drivers/net/intel/ice/ice_generic_flow.c b/drivers/net/intel/ice/ice_generic_flow.c
index 76b3800545..fee048e456 100644
--- a/drivers/net/intel/ice/ice_generic_flow.c
+++ b/drivers/net/intel/ice/ice_generic_flow.c
@@ -2109,16 +2109,15 @@ static bool
 ice_match_pattern(enum rte_flow_item_type *item_array,
 		const struct rte_flow_item *pattern)
 {
-	const struct rte_flow_item *item = pattern;
+	const struct rte_flow_item *item;
 
-	while ((*item_array == item->type) &&
-	       (*item_array != RTE_FLOW_ITEM_TYPE_END)) {
+	ICE_FLOW_FOREACH_ITEM(item, pattern) {
+		if (*item_array != item->type)
+			return false;
 		item_array++;
-		item++;
 	}
 
-	return (*item_array == RTE_FLOW_ITEM_TYPE_END &&
-		item->type == RTE_FLOW_ITEM_TYPE_END);
+	return *item_array == RTE_FLOW_ITEM_TYPE_END;
 }
 
 struct ice_ptype_match {
diff --git a/drivers/net/intel/ice/ice_generic_flow.h b/drivers/net/intel/ice/ice_generic_flow.h
index 650b43633f..983f86a5ab 100644
--- a/drivers/net/intel/ice/ice_generic_flow.h
+++ b/drivers/net/intel/ice/ice_generic_flow.h
@@ -569,6 +569,20 @@ struct ice_flow_parser_node {
 void ice_register_flow_engine(struct ice_flow_engine *engine);
 int ice_flow_init(struct ice_adapter *ad);
 void ice_flow_uninit(struct ice_adapter *ad);
+
+static inline const struct rte_flow_item *
+ice_pattern_skip_void(const struct rte_flow_item *item)
+{
+	while (item->type == RTE_FLOW_ITEM_TYPE_VOID)
+		item++;
+	return item;
+}
+
+#define ICE_FLOW_FOREACH_ITEM(item, pattern) \
+	for ((item) = ice_pattern_skip_void(pattern); \
+	     (item)->type != RTE_FLOW_ITEM_TYPE_END; \
+	     (item) = ice_pattern_skip_void((item) + 1))
+
 struct ice_pattern_match_item *
 ice_search_pattern_match_item(struct ice_adapter *ad,
 			      const struct rte_flow_item pattern[],
diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
index 7a9a4f1a04..13bedfe90c 100644
--- a/drivers/net/intel/ice/ice_hash.c
+++ b/drivers/net/intel/ice/ice_hash.c
@@ -624,7 +624,7 @@ ice_hash_parse_pattern(const struct rte_flow_item pattern[], uint64_t *phint,
 	const struct rte_flow_item *item = pattern;
 	const struct rte_flow_item_gtp_psc *psc;
 
-	for (item = pattern; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
+	ICE_FLOW_FOREACH_ITEM(item, pattern) {
 		if (item->last) {
 			rte_flow_error_set(error, EINVAL,
 					RTE_FLOW_ERROR_TYPE_ITEM, item,
@@ -1235,8 +1235,10 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 		goto error;
 
 	if (phint == ICE_PHINT_RAW) {
+		const struct rte_flow_item *raw_item = ice_pattern_skip_void(pattern);
+
 		rss_meta_ptr->raw.raw_ena = true;
-		ret = ice_hash_parse_raw_pattern(ad, pattern, error, rss_meta_ptr);
+		ret = ice_hash_parse_raw_pattern(ad, raw_item, error, rss_meta_ptr);
 		if (ret) {
 			rte_flow_error_set(error, EINVAL,
 					   RTE_FLOW_ERROR_TYPE_ITEM, NULL,
diff --git a/drivers/net/intel/ice/ice_switch_filter.c b/drivers/net/intel/ice/ice_switch_filter.c
index 6f5af03f6a..6bc1bdd09f 100644
--- a/drivers/net/intel/ice/ice_switch_filter.c
+++ b/drivers/net/intel/ice/ice_switch_filter.c
@@ -489,8 +489,7 @@ ice_switch_parse_pattern(const struct rte_flow_item pattern[],
 	    *tun_type == ICE_NON_TUN_QINQ)
 		qinq_valid = 1;
 
-	for (item = pattern; item->type !=
-			RTE_FLOW_ITEM_TYPE_END; item++) {
+	ICE_FLOW_FOREACH_ITEM(item, pattern) {
 		if (item->last) {
 			rte_flow_error_set(error, EINVAL,
 					RTE_FLOW_ERROR_TYPE_ITEM,
@@ -1378,9 +1377,6 @@ ice_switch_parse_pattern(const struct rte_flow_item pattern[],
 			gtpu_psc_valid = 1;
 			break;
 
-		case RTE_FLOW_ITEM_TYPE_VOID:
-			break;
-
 		default:
 			rte_flow_error_set(error, EINVAL,
 				   RTE_FLOW_ERROR_TYPE_ITEM, pattern,
@@ -1805,7 +1801,7 @@ ice_switch_parse_pattern_action(struct ice_adapter *ad,
 		return -rte_errno;
 	}
 
-	for (; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
+	ICE_FLOW_FOREACH_ITEM(item, pattern) {
 		item_num++;
 		if (item->type == RTE_FLOW_ITEM_TYPE_ETH) {
 			const struct rte_flow_item_eth *eth_mask;
-- 
2.52.0

