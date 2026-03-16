Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DFFF4644B
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 10:55:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C06940B98;
	Mon, 16 Mar 2026 11:53:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 4C41640A6C
 for <dev@dpdk.org>; Mon, 16 Mar 2026 11:53:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773658401; x=1805194401;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=AYa1N5ICgIlcEmka4QemFPXtnvcfJFbrF9WWj93plb0=;
 b=fYvOSkxH3McpCEsndROcOBmjS/FQ4TDLnCyKe0RTMjR/jrEIlrj1XjYv
 beiWnBMqs0WsJI3DZ1O/20hJv6p8ITBBalIc+ctKroGurwGcnD6tK6Zud
 BF3tnqq6G/yg2fopuqtEDurxgE5SrNUVqKP8TU01j6Tf27QI62hjmdfo9
 4831EN3qc93pViftFL7btqTLmRjGeaHGGK79V+qPI4x9zywNx+CfH5apP
 NOnpzbDcGHVtTHxxh/SE8YaRogHMkAMXAzRpg/yyi/V77MHIj3QS8Bi+c
 lkwfCDHEHnLXcWvyzD+yloyfeXiNqxcCY+EwlwnKFmwkwNqGeFA6i8zIE g==;
X-CSE-ConnectionGUID: CVIqZtAsQvuRI6w3vhqfqw==
X-CSE-MsgGUID: c8a6S2+tR+mX9rU3cZ2tMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="62237440"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="62237440"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 03:53:20 -0700
X-CSE-ConnectionGUID: MMMTjaKQQ5auSy/kKdY29g==
X-CSE-MsgGUID: wZEFzhX3TLqKjhs3/bx7Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221826800"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 16 Mar 2026 03:53:19 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 21/25] net/ice: use common flow attribute checks
Date: Mon, 16 Mar 2026 10:52:46 +0000
Message-ID: <f0e9535ed20aceece84d264aff74f1b675b6495b.1773658290.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773658289.git.anatoly.burakov@intel.com>
 <cover.1773658289.git.anatoly.burakov@intel.com>
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
index 6754a40044..0421578b32 100644
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
index 5b27f5a077..f5b832b863 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -15,6 +15,8 @@
 #include "ice_rxtx.h"
 #include "ice_generic_flow.h"
 
+#include "../common/flow_check.h"
+
 #define ICE_FDIR_IPV6_TC_OFFSET		20
 #define ICE_IPV6_TC_MASK		(0xFF << ICE_FDIR_IPV6_TC_OFFSET)
 
@@ -2796,7 +2798,7 @@ ice_fdir_parse(struct ice_adapter *ad,
 	       uint32_t array_len,
 	       const struct rte_flow_item pattern[],
 	       const struct rte_flow_action actions[],
-	       uint32_t priority __rte_unused,
+	       const struct rte_flow_attr *attr,
 	       void **meta,
 	       struct rte_flow_error *error)
 {
@@ -2807,6 +2809,10 @@ ice_fdir_parse(struct ice_adapter *ad,
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
index 62f0c334a1..fe903a975c 100644
--- a/drivers/net/intel/ice/ice_generic_flow.c
+++ b/drivers/net/intel/ice/ice_generic_flow.c
@@ -16,6 +16,7 @@
 #include <rte_malloc.h>
 #include <rte_tailq.h>
 
+#include "../common/flow_check.h"
 #include "ice_ethdev.h"
 #include "ice_generic_flow.h"
 
@@ -1959,7 +1960,7 @@ enum rte_flow_item_type pattern_eth_ipv6_udp_l2tpv2_ppp_ipv6_tcp[] = {
 typedef bool (*parse_engine_t)(struct ice_adapter *ad,
 			       struct rte_flow *flow,
 			       struct ice_flow_parser *parser,
-			       uint32_t priority,
+			       const struct rte_flow_attr *attr,
 			       const struct rte_flow_item pattern[],
 			       const struct rte_flow_action actions[],
 			       struct rte_flow_error *error);
@@ -2045,44 +2046,6 @@ ice_flow_uninit(struct ice_adapter *ad)
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
@@ -2360,7 +2323,7 @@ static bool
 ice_parse_engine_create(struct ice_adapter *ad,
 		struct rte_flow *flow,
 		struct ice_flow_parser *parser,
-		uint32_t priority,
+		const struct rte_flow_attr *attr,
 		const struct rte_flow_item pattern[],
 		const struct rte_flow_action actions[],
 		struct rte_flow_error *error)
@@ -2378,7 +2341,7 @@ ice_parse_engine_create(struct ice_adapter *ad,
 	if (parser->parse_pattern_action(ad,
 					 parser->array,
 					 parser->array_len,
-					 pattern, actions, priority, &meta, error) < 0)
+					 pattern, actions, attr, &meta, error) < 0)
 		return false;
 
 	RTE_ASSERT(parser->engine->create != NULL);
@@ -2390,7 +2353,7 @@ static bool
 ice_parse_engine_validate(struct ice_adapter *ad,
 		struct rte_flow *flow __rte_unused,
 		struct ice_flow_parser *parser,
-		uint32_t priority,
+		const struct rte_flow_attr *attr,
 		const struct rte_flow_item pattern[],
 		const struct rte_flow_action actions[],
 		struct rte_flow_error *error)
@@ -2407,7 +2370,7 @@ ice_parse_engine_validate(struct ice_adapter *ad,
 	return parser->parse_pattern_action(ad,
 					    parser->array,
 					    parser->array_len,
-					    pattern, actions, priority,
+					    pattern, actions, attr,
 					    NULL, error) >= 0;
 }
 
@@ -2435,7 +2398,6 @@ ice_flow_process_filter(struct rte_eth_dev *dev,
 		parse_engine_t ice_parse_engine,
 		struct rte_flow_error *error)
 {
-	int ret = ICE_ERR_NOT_SUPPORTED;
 	struct ice_adapter *ad =
 		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct ice_flow_parser *parser;
@@ -2460,15 +2422,10 @@ ice_flow_process_filter(struct rte_eth_dev *dev,
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
@@ -2489,7 +2446,7 @@ ice_flow_process_filter(struct rte_eth_dev *dev,
 			return -rte_errno;
 		}
 
-		if (ice_parse_engine(ad, flow, parser, attr->priority,
+		if (ice_parse_engine(ad, flow, parser, attr,
 				pattern, actions, error)) {
 			*engine = parser->engine;
 			return 0;
diff --git a/drivers/net/intel/ice/ice_generic_flow.h b/drivers/net/intel/ice/ice_generic_flow.h
index 1b5514d5df..b9d6149d82 100644
--- a/drivers/net/intel/ice/ice_generic_flow.h
+++ b/drivers/net/intel/ice/ice_generic_flow.h
@@ -522,7 +522,7 @@ typedef int (*parse_pattern_action_t)(struct ice_adapter *ad,
 		uint32_t array_len,
 		const struct rte_flow_item pattern[],
 		const struct rte_flow_action actions[],
-		uint32_t priority,
+		const struct rte_flow_attr *attr,
 		void **meta,
 		struct rte_flow_error *error);
 
diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
index 77829e607b..bd42bc2a4a 100644
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
 
@@ -1185,7 +1187,7 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 			uint32_t array_len,
 			const struct rte_flow_item pattern[],
 			const struct rte_flow_action actions[],
-			uint32_t priority,
+			const struct rte_flow_attr *attr,
 			void **meta,
 			struct rte_flow_error *error)
 {
@@ -1194,8 +1196,9 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
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
index b25e5eaad3..d8c0e7c59c 100644
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

