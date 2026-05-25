Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C09CD5BC9
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 14:09:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD72240DCD;
	Mon, 25 May 2026 16:07:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 385D340B9E
 for <dev@dpdk.org>; Mon, 25 May 2026 16:07:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779718041; x=1811254041;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=R1MdMhsyi299roEil07iWugik+n/cEHHgbQgdMMix8Q=;
 b=NxkqC3peV+btT0OvX2CdigX+uxeVIlEARrIDMxCmfp/Yv3RPf+4bIogT
 UGZUQdby++TpQm04s73bmUB1nnMQDHxus2Ji22xBaSDWg0n03iWuWJBgN
 EiVv/pnlzOABCsLiNFAFtgO3x7ecpjL/sSJ/04Rjov2bmBvfnmXm0t1Mw
 VI7Q5eYMgHNGv4xBF3tV/DxVQfBmFngCqJmD6JzwAq9NqJeYPQrs4d3bT
 dAhr+996I+gaCBTQjPMixbZy1CASfQ0pp921aY/VTDl0+vRbYGyPflylY
 ylVsJcsTCRLLvlmCdev/saDGyS0nV74gmSxQw80qPANDrDo8ERfFMQeBI w==;
X-CSE-ConnectionGUID: 9nMp9lYwTIKNuMGQHqBV2w==
X-CSE-MsgGUID: DbHE7GltQD+/fCKQFD19uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="84392536"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="84392536"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 07:07:21 -0700
X-CSE-ConnectionGUID: mQgZaJxMQjGW3F2ayjlLQg==
X-CSE-MsgGUID: bHvnKii+TVWQo7+DgRqasg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="246692415"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 25 May 2026 07:07:20 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 23/27] net/ice: use common flow attribute checks
Date: Mon, 25 May 2026 15:06:42 +0100
Message-ID: <6c0aa87765a01900f09409cbd292fd3ab9cd1d08.1779717944.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779717943.git.anatoly.burakov@intel.com>
 <cover.1779717943.git.anatoly.burakov@intel.com>
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

From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

Replace custom attr checks with a call to common checks. Switch engine
supports priority (0 or 1) but other engines don't, so we move the
attribute checks into the engines.

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ice/ice_acl_filter.c    |  9 ++--
 drivers/net/intel/ice/ice_fdir_filter.c   |  8 ++-
 drivers/net/intel/ice/ice_generic_flow.c  | 59 +++--------------------
 drivers/net/intel/ice/ice_generic_flow.h  |  2 +-
 drivers/net/intel/ice/ice_hash.c          | 11 +++--
 drivers/net/intel/ice/ice_switch_filter.c | 22 +++++++--
 6 files changed, 48 insertions(+), 63 deletions(-)

diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
index 3939579598..0b50f06c46 100644
--- a/drivers/net/intel/ice/ice_acl_filter.c
+++ b/drivers/net/intel/ice/ice_acl_filter.c
@@ -27,6 +27,8 @@
 #include "ice_generic_flow.h"
 #include "base/ice_flow.h"
 
+#include "../common/flow_check.h"
+
 #define MAX_ACL_SLOTS_ID 2048
 
 #define ICE_ACL_INSET_ETH_IPV4 ( \
@@ -970,7 +972,7 @@ ice_acl_parse(struct ice_adapter *ad,
 	       uint32_t array_len,
 	       const struct rte_flow_item pattern[],
 	       const struct rte_flow_action actions[],
-	       uint32_t priority,
+	       const struct rte_flow_attr *attr,
 	       void **meta,
 	       struct rte_flow_error *error)
 {
@@ -980,8 +982,9 @@ ice_acl_parse(struct ice_adapter *ad,
 	uint64_t input_set;
 	int ret;
 
-	if (priority >= 1)
-		return -rte_errno;
+	ret = ci_flow_check_attr(attr, NULL, error);
+	if (ret)
+		return ret;
 
 	memset(filter, 0, sizeof(*filter));
 	item = ice_search_pattern_match_item(ad, pattern, array, array_len,
diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index 2511aecc7e..4efa078aca 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -15,6 +15,8 @@
 #include "ice_rxtx.h"
 #include "ice_generic_flow.h"
 
+#include "../common/flow_check.h"
+
 #define ICE_FDIR_IPV6_TC_OFFSET		20
 #define ICE_IPV6_TC_MASK		(0xFF << ICE_FDIR_IPV6_TC_OFFSET)
 
@@ -2808,7 +2810,7 @@ ice_fdir_parse(struct ice_adapter *ad,
 	       uint32_t array_len,
 	       const struct rte_flow_item pattern[],
 	       const struct rte_flow_action actions[],
-	       uint32_t priority __rte_unused,
+	       const struct rte_flow_attr *attr,
 	       void **meta,
 	       struct rte_flow_error *error)
 {
@@ -2819,6 +2821,10 @@ ice_fdir_parse(struct ice_adapter *ad,
 	bool raw = false;
 	int ret;
 
+	ret = ci_flow_check_attr(attr, NULL, error);
+	if (ret)
+		return ret;
+
 	memset(filter, 0, sizeof(*filter));
 	item = ice_search_pattern_match_item(ad, pattern, array, array_len,
 					     error);
diff --git a/drivers/net/intel/ice/ice_generic_flow.c b/drivers/net/intel/ice/ice_generic_flow.c
index 0880542851..cbc3d78079 100644
--- a/drivers/net/intel/ice/ice_generic_flow.c
+++ b/drivers/net/intel/ice/ice_generic_flow.c
@@ -17,6 +17,7 @@
 #include <rte_malloc.h>
 #include <rte_tailq.h>
 
+#include "../common/flow_check.h"
 #include "ice_ethdev.h"
 #include "ice_generic_flow.h"
 
@@ -1965,7 +1966,7 @@ enum rte_flow_item_type pattern_eth_ipv6_udp_l2tpv2_ppp_ipv6_tcp[] = {
 typedef bool (*parse_engine_t)(struct ice_adapter *ad,
 			       struct rte_flow *flow,
 			       struct ice_flow_parser *parser,
-			       uint32_t priority,
+			       const struct rte_flow_attr *attr,
 			       const struct rte_flow_item pattern[],
 			       const struct rte_flow_action actions[],
 			       struct rte_flow_error *error);
@@ -2051,44 +2052,6 @@ ice_flow_uninit(struct ice_adapter *ad)
 	}
 }
 
-static int
-ice_flow_valid_attr(const struct rte_flow_attr *attr,
-		    struct rte_flow_error *error)
-{
-	/* Must be input direction */
-	if (!attr->ingress) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ATTR_INGRESS,
-				attr, "Only support ingress.");
-		return -rte_errno;
-	}
-
-	/* Not supported */
-	if (attr->egress) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ATTR_EGRESS,
-				attr, "Not support egress.");
-		return -rte_errno;
-	}
-
-	/* Not supported */
-	if (attr->transfer) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ATTR_TRANSFER,
-				   attr, "Not support transfer.");
-		return -rte_errno;
-	}
-
-	if (attr->priority > 1) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY,
-				   attr, "Only support priority 0 and 1.");
-		return -rte_errno;
-	}
-
-	return 0;
-}
-
 /* Find the first VOID or non-VOID item pointer */
 static const struct rte_flow_item *
 ice_find_first_item(const struct rte_flow_item *item, bool is_void)
@@ -2366,7 +2329,7 @@ static bool
 ice_parse_engine_create(struct ice_adapter *ad,
 		struct rte_flow *flow,
 		struct ice_flow_parser *parser,
-		uint32_t priority,
+		const struct rte_flow_attr *attr,
 		const struct rte_flow_item pattern[],
 		const struct rte_flow_action actions[],
 		struct rte_flow_error *error)
@@ -2384,7 +2347,7 @@ ice_parse_engine_create(struct ice_adapter *ad,
 	if (parser->parse_pattern_action(ad,
 					 parser->array,
 					 parser->array_len,
-					 pattern, actions, priority, &meta, error) < 0)
+					 pattern, actions, attr, &meta, error) < 0)
 		return false;
 
 	RTE_ASSERT(parser->engine->create != NULL);
@@ -2396,7 +2359,7 @@ static bool
 ice_parse_engine_validate(struct ice_adapter *ad,
 		struct rte_flow *flow __rte_unused,
 		struct ice_flow_parser *parser,
-		uint32_t priority,
+		const struct rte_flow_attr *attr,
 		const struct rte_flow_item pattern[],
 		const struct rte_flow_action actions[],
 		struct rte_flow_error *error)
@@ -2413,7 +2376,7 @@ ice_parse_engine_validate(struct ice_adapter *ad,
 	return parser->parse_pattern_action(ad,
 					    parser->array,
 					    parser->array_len,
-					    pattern, actions, priority,
+					    pattern, actions, attr,
 					    NULL, error) >= 0;
 }
 
@@ -2441,7 +2404,6 @@ ice_flow_process_filter(struct rte_eth_dev *dev,
 		parse_engine_t ice_parse_engine,
 		struct rte_flow_error *error)
 {
-	int ret = ICE_ERR_NOT_SUPPORTED;
 	struct ice_adapter *ad =
 		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct ice_flow_parser *parser;
@@ -2466,15 +2428,10 @@ ice_flow_process_filter(struct rte_eth_dev *dev,
 		return -rte_errno;
 	}
 
-	ret = ice_flow_valid_attr(attr, error);
-	if (ret)
-		return ret;
-
 	*engine = NULL;
 	/* always try hash engine first */
 	if (ice_parse_engine(ad, flow, &ice_hash_parser,
-			     attr->priority, pattern,
-			     actions, error)) {
+			     attr, pattern, actions, error)) {
 		*engine = ice_hash_parser.engine;
 		return 0;
 	}
@@ -2495,7 +2452,7 @@ ice_flow_process_filter(struct rte_eth_dev *dev,
 			return -rte_errno;
 		}
 
-		if (ice_parse_engine(ad, flow, parser, attr->priority,
+		if (ice_parse_engine(ad, flow, parser, attr,
 				pattern, actions, error)) {
 			*engine = parser->engine;
 			return 0;
diff --git a/drivers/net/intel/ice/ice_generic_flow.h b/drivers/net/intel/ice/ice_generic_flow.h
index dbb21c47ab..650b43633f 100644
--- a/drivers/net/intel/ice/ice_generic_flow.h
+++ b/drivers/net/intel/ice/ice_generic_flow.h
@@ -525,7 +525,7 @@ typedef int (*parse_pattern_action_t)(struct ice_adapter *ad,
 		uint32_t array_len,
 		const struct rte_flow_item pattern[],
 		const struct rte_flow_action actions[],
-		uint32_t priority,
+		const struct rte_flow_attr *attr,
 		void **meta,
 		struct rte_flow_error *error);
 
diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
index 702f5d8b0c..9a56d7000c 100644
--- a/drivers/net/intel/ice/ice_hash.c
+++ b/drivers/net/intel/ice/ice_hash.c
@@ -26,6 +26,8 @@
 #include "ice_ethdev.h"
 #include "ice_generic_flow.h"
 
+#include "../common/flow_check.h"
+
 #define ICE_PHINT_NONE				0
 #define ICE_PHINT_VLAN				BIT_ULL(0)
 #define ICE_PHINT_PPPOE				BIT_ULL(1)
@@ -107,7 +109,7 @@ ice_hash_parse_pattern_action(struct ice_adapter *ad,
 			uint32_t array_len,
 			const struct rte_flow_item pattern[],
 			const struct rte_flow_action actions[],
-			uint32_t priority,
+			const struct rte_flow_attr *attr,
 			void **meta,
 			struct rte_flow_error *error);
 
@@ -1187,7 +1189,7 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 			uint32_t array_len,
 			const struct rte_flow_item pattern[],
 			const struct rte_flow_action actions[],
-			uint32_t priority,
+			const struct rte_flow_attr *attr,
 			void **meta,
 			struct rte_flow_error *error)
 {
@@ -1196,8 +1198,9 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 	struct ice_rss_meta *rss_meta_ptr;
 	uint64_t phint = ICE_PHINT_NONE;
 
-	if (priority >= 1)
-		return -rte_errno;
+	ret = ci_flow_check_attr(attr, NULL, error);
+	if (ret)
+		return ret;
 
 	rss_meta_ptr = rte_zmalloc(NULL, sizeof(*rss_meta_ptr), 0);
 	if (!rss_meta_ptr) {
diff --git a/drivers/net/intel/ice/ice_switch_filter.c b/drivers/net/intel/ice/ice_switch_filter.c
index 2da8c5c3c8..67943b591c 100644
--- a/drivers/net/intel/ice/ice_switch_filter.c
+++ b/drivers/net/intel/ice/ice_switch_filter.c
@@ -26,6 +26,7 @@
 #include "ice_generic_flow.h"
 #include "ice_dcf_ethdev.h"
 
+#include "../common/flow_check.h"
 
 #define MAX_QGRP_NUM_TYPE	7
 #define MAX_INPUT_SET_BYTE	32
@@ -1768,7 +1769,7 @@ ice_switch_parse_pattern_action(struct ice_adapter *ad,
 		uint32_t array_len,
 		const struct rte_flow_item pattern[],
 		const struct rte_flow_action actions[],
-		uint32_t priority,
+		const struct rte_flow_attr *attr,
 		void **meta,
 		struct rte_flow_error *error)
 {
@@ -1784,6 +1785,21 @@ ice_switch_parse_pattern_action(struct ice_adapter *ad,
 	enum ice_sw_tunnel_type tun_type =
 			ICE_NON_TUN;
 	struct ice_pattern_match_item *pattern_match_item = NULL;
+	struct ci_flow_attr_check_param attr_param = {
+		.allow_priority = true,
+	};
+
+	ret = ci_flow_check_attr(attr, &attr_param, error);
+	if (ret)
+		return ret;
+
+	/* Allow only two priority values - 0 or 1 */
+	if (attr->priority > 1) {
+		rte_flow_error_set(error, EINVAL,
+				   RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY, NULL,
+				   "Invalid priority for switch filter");
+		return -rte_errno;
+	}
 
 	for (; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
 		item_num++;
@@ -1859,10 +1875,10 @@ ice_switch_parse_pattern_action(struct ice_adapter *ad,
 		goto error;
 
 	if (ad->hw.dcf_enabled)
-		ret = ice_switch_parse_dcf_action((void *)ad, actions, priority,
+		ret = ice_switch_parse_dcf_action((void *)ad, actions, attr->priority,
 						  error, &rule_info);
 	else
-		ret = ice_switch_parse_action(pf, actions, priority, error,
+		ret = ice_switch_parse_action(pf, actions, attr->priority, error,
 					      &rule_info);
 
 	if (ret)
-- 
2.47.3

