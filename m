Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB6ACD5BB0
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 15:16:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2B6240DCB;
	Fri, 22 May 2026 17:15:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 3C3CA4003C
 for <dev@dpdk.org>; Fri, 22 May 2026 17:15:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779462902; x=1810998902;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=zCXQkSqOtFml/Uc1Xwu019PhxTjR+bGbzOD9GwcTBgE=;
 b=gCoD7caS9ppIHZ40oo2Sf2QMZjg32FZsOznZw6gpiRV8jHZFLcO8iNXh
 0PNXObfuUyUUbvsw34S+N3qtQymSOT6cIK1OGMifVh9JbJPJp2gYrKe6y
 aI09HqWM49TcOdH/xkbiusaw/kVRcWmxQywyqwgZzTVj5utWlqYss+7cD
 nSD6ncNqM+lihz+5+nuiZWK6+E8Ye/61iDR0OGSzLy6P+plQeDw8YEAs6
 qH3Z5kWrAr3Yevu8zqye8KBrLwt7b8u42jU9ralgIxvljfRoYcqDuHdna
 FdRVnYrj8lWiFjz+tK9+fAClg0n4gEMUN+ytfIgvatrkuwmVotHov1I86 Q==;
X-CSE-ConnectionGUID: nBKhq5RnSyWVqG+DBPfT+w==
X-CSE-MsgGUID: 5vZtN3b7Si+Gnhdor15TTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="97969171"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="97969171"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 08:15:02 -0700
X-CSE-ConnectionGUID: cGSPEk6bQ56XKcHrmuQSow==
X-CSE-MsgGUID: eJNY1gcNTzCv/KkE5cVhSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="245213996"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 22 May 2026 08:15:02 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 16/26] net/iavf: use common flow attribute checks
Date: Fri, 22 May 2026 16:14:25 +0100
Message-ID: <39856a9470140f8108cddc9da6f07ba8c40c8d16.1779462699.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779462698.git.anatoly.burakov@intel.com>
 <cover.1779462698.git.anatoly.burakov@intel.com>
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

Replace custom attr checks with a call to common checks. Flow subscription
engine supports priority but other engines don't, so we move the attribute
checks into the engines.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_fdir.c         |  8 ++-
 drivers/net/intel/iavf/iavf_fsub.c         | 20 ++++++-
 drivers/net/intel/iavf/iavf_generic_flow.c | 67 +++-------------------
 drivers/net/intel/iavf/iavf_generic_flow.h |  2 +-
 drivers/net/intel/iavf/iavf_hash.c         | 10 ++--
 drivers/net/intel/iavf/iavf_ipsec_crypto.c |  8 ++-
 6 files changed, 43 insertions(+), 72 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_fdir.c b/drivers/net/intel/iavf/iavf_fdir.c
index 91485ad360..91efc986d8 100644
--- a/drivers/net/intel/iavf/iavf_fdir.c
+++ b/drivers/net/intel/iavf/iavf_fdir.c
@@ -17,6 +17,7 @@
 
 #include "iavf.h"
 #include "iavf_generic_flow.h"
+#include "../common/flow_check.h"
 #include "virtchnl.h"
 #include "iavf_rxtx.h"
 
@@ -1594,7 +1595,7 @@ iavf_fdir_parse(struct iavf_adapter *ad,
 		uint32_t array_len,
 		const struct rte_flow_item pattern[],
 		const struct rte_flow_action actions[],
-		uint32_t priority,
+		const struct rte_flow_attr *attr,
 		void **meta,
 		struct rte_flow_error *error)
 {
@@ -1605,8 +1606,9 @@ iavf_fdir_parse(struct iavf_adapter *ad,
 
 	memset(filter, 0, sizeof(*filter));
 
-	if (priority >= 1)
-		return -rte_errno;
+	ret = ci_flow_check_attr(attr, NULL, error);
+	if (ret)
+		return ret;
 
 	item = iavf_search_pattern_match_item(pattern, array, array_len, error);
 	if (!item)
diff --git a/drivers/net/intel/iavf/iavf_fsub.c b/drivers/net/intel/iavf/iavf_fsub.c
index 8275c4b6c0..65172467b5 100644
--- a/drivers/net/intel/iavf/iavf_fsub.c
+++ b/drivers/net/intel/iavf/iavf_fsub.c
@@ -20,6 +20,7 @@
 #include <rte_flow.h>
 #include <iavf.h>
 #include "iavf_generic_flow.h"
+#include "../common/flow_check.h"
 
 #define MAX_QGRP_NUM_TYPE      7
 #define IAVF_IPV6_ADDR_LENGTH  16
@@ -650,12 +651,15 @@ iavf_fsub_parse(struct iavf_adapter *ad,
 		uint32_t array_len,
 		const struct rte_flow_item pattern[],
 		const struct rte_flow_action actions[],
-		uint32_t priority,
+		const struct rte_flow_attr *attr,
 		void **meta,
 		struct rte_flow_error *error)
 {
 	struct iavf_fsub_conf *filter;
 	struct iavf_pattern_match_item *pattern_match_item = NULL;
+	struct ci_flow_attr_check_param attr_param = {
+		.allow_priority = true,
+	};
 	int ret = 0;
 
 	filter = rte_zmalloc(NULL, sizeof(*filter), 0);
@@ -666,6 +670,18 @@ iavf_fsub_parse(struct iavf_adapter *ad,
 		return -ENOMEM;
 	}
 
+	ret = ci_flow_check_attr(attr, &attr_param, error);
+	if (ret)
+		goto error;
+
+	if (attr->priority > 1) {
+		rte_flow_error_set(error, EINVAL,
+				   RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY,
+				   attr, "Only support priority 0 and 1.");
+		ret = -rte_errno;
+		goto error;
+	}
+
 	/* search flow subscribe pattern */
 	pattern_match_item = iavf_search_pattern_match_item(pattern, array,
 							    array_len, error);
@@ -687,7 +703,7 @@ iavf_fsub_parse(struct iavf_adapter *ad,
 		goto error;
 
 	/* parse flow subscribe pattern action */
-	ret = iavf_fsub_parse_action((void *)ad, actions, priority,
+	ret = iavf_fsub_parse_action((void *)ad, actions, attr->priority,
 				     error, filter);
 
 error:
diff --git a/drivers/net/intel/iavf/iavf_generic_flow.c b/drivers/net/intel/iavf/iavf_generic_flow.c
index b4a3991689..371ad1b356 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.c
+++ b/drivers/net/intel/iavf/iavf_generic_flow.c
@@ -1791,7 +1791,7 @@ enum rte_flow_item_type iavf_pattern_eth_ipv6_udp_l2tpv2_ppp_ipv6_tcp[] = {
 typedef struct iavf_flow_engine * (*parse_engine_t)(struct iavf_adapter *ad,
 		struct rte_flow *flow,
 		struct iavf_parser_list *parser_list,
-		uint32_t priority,
+		const struct rte_flow_attr *attr,
 		const struct rte_flow_item pattern[],
 		const struct rte_flow_action actions[],
 		struct rte_flow_error *error);
@@ -1945,45 +1945,6 @@ iavf_unregister_parser(struct iavf_flow_parser *parser,
 	}
 }
 
-static int
-iavf_flow_valid_attr(const struct rte_flow_attr *attr,
-		     struct rte_flow_error *error)
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
-	/* support priority for flow subscribe */
-	if (attr->priority > 1) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY,
-				attr, "Only support priority 0 and 1.");
-		return -rte_errno;
-	}
-
-	/* Not supported */
-	if (attr->group) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ATTR_GROUP,
-				attr, "Not support group.");
-		return -rte_errno;
-	}
-
-	return 0;
-}
-
 /* Find the first VOID or non-VOID item pointer */
 static const struct rte_flow_item *
 iavf_find_first_item(const struct rte_flow_item *item, bool is_void)
@@ -2112,7 +2073,7 @@ static struct iavf_flow_engine *
 iavf_parse_engine_create(struct iavf_adapter *ad,
 		struct rte_flow *flow,
 		struct iavf_parser_list *parser_list,
-		uint32_t priority,
+		const struct rte_flow_attr *attr,
 		const struct rte_flow_item pattern[],
 		const struct rte_flow_action actions[],
 		struct rte_flow_error *error)
@@ -2126,7 +2087,7 @@ iavf_parse_engine_create(struct iavf_adapter *ad,
 		if (parser_node->parser->parse_pattern_action(ad,
 				parser_node->parser->array,
 				parser_node->parser->array_len,
-				pattern, actions, priority, &meta, error) < 0)
+				pattern, actions, attr, &meta, error) < 0)
 			continue;
 
 		engine = parser_node->parser->engine;
@@ -2142,7 +2103,7 @@ static struct iavf_flow_engine *
 iavf_parse_engine_validate(struct iavf_adapter *ad,
 		struct rte_flow *flow,
 		struct iavf_parser_list *parser_list,
-		uint32_t priority,
+		const struct rte_flow_attr *attr,
 		const struct rte_flow_item pattern[],
 		const struct rte_flow_action actions[],
 		struct rte_flow_error *error)
@@ -2156,7 +2117,7 @@ iavf_parse_engine_validate(struct iavf_adapter *ad,
 		if (parser_node->parser->parse_pattern_action(ad,
 				parser_node->parser->array,
 				parser_node->parser->array_len,
-				pattern, actions, priority, &meta, error) < 0)
+				pattern, actions, attr, &meta, error) < 0)
 			continue;
 
 		engine = parser_node->parser->engine;
@@ -2188,7 +2149,6 @@ iavf_flow_process_filter(struct rte_eth_dev *dev,
 		parse_engine_t iavf_parse_engine,
 		struct rte_flow_error *error)
 {
-	int ret = IAVF_ERR_CONFIG;
 	struct iavf_adapter *ad =
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(ad);
@@ -2206,29 +2166,18 @@ iavf_flow_process_filter(struct rte_eth_dev *dev,
 		return -rte_errno;
 	}
 
-	if (!attr) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ATTR,
-				   NULL, "NULL attribute.");
-		return -rte_errno;
-	}
-
-	ret = iavf_flow_valid_attr(attr, error);
-	if (ret)
-		return ret;
-
 	*engine = iavf_parse_engine(ad, flow, &vf->rss_parser_list,
-				    attr->priority, pattern, actions, error);
+				    attr, pattern, actions, error);
 	if (*engine)
 		return 0;
 
 	*engine = iavf_parse_engine(ad, flow, &vf->dist_parser_list,
-				    attr->priority, pattern, actions, error);
+				    attr, pattern, actions, error);
 	if (*engine)
 		return 0;
 
 	*engine = iavf_parse_engine(ad, flow, &vf->ipsec_crypto_parser_list,
-				    attr->priority, pattern, actions, error);
+				    attr, pattern, actions, error);
 	if (*engine)
 		return 0;
 
diff --git a/drivers/net/intel/iavf/iavf_generic_flow.h b/drivers/net/intel/iavf/iavf_generic_flow.h
index 1b87c486d5..6665d68818 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.h
+++ b/drivers/net/intel/iavf/iavf_generic_flow.h
@@ -471,7 +471,7 @@ typedef int (*parse_pattern_action_t)(struct iavf_adapter *ad,
 		uint32_t array_len,
 		const struct rte_flow_item pattern[],
 		const struct rte_flow_action actions[],
-		uint32_t priority,
+		const struct rte_flow_attr *attr,
 		void **meta,
 		struct rte_flow_error *error);
 
diff --git a/drivers/net/intel/iavf/iavf_hash.c b/drivers/net/intel/iavf/iavf_hash.c
index 1617cb1066..1615ba5ce9 100644
--- a/drivers/net/intel/iavf/iavf_hash.c
+++ b/drivers/net/intel/iavf/iavf_hash.c
@@ -22,6 +22,7 @@
 #include "iavf_log.h"
 #include "iavf.h"
 #include "iavf_generic_flow.h"
+#include "../common/flow_check.h"
 
 #define IAVF_PHINT_NONE				0
 #define IAVF_PHINT_GTPU				BIT_ULL(0)
@@ -86,7 +87,7 @@ iavf_hash_parse_pattern_action(struct iavf_adapter *ad,
 			       uint32_t array_len,
 			       const struct rte_flow_item pattern[],
 			       const struct rte_flow_action actions[],
-			       uint32_t priority,
+			       const struct rte_flow_attr *attr,
 			       void **meta,
 			       struct rte_flow_error *error);
 
@@ -1521,7 +1522,7 @@ iavf_hash_parse_pattern_action(__rte_unused struct iavf_adapter *ad,
 			       uint32_t array_len,
 			       const struct rte_flow_item pattern[],
 			       const struct rte_flow_action actions[],
-			       uint32_t priority,
+			       const struct rte_flow_attr *attr,
 			       void **meta,
 			       struct rte_flow_error *error)
 {
@@ -1530,8 +1531,9 @@ iavf_hash_parse_pattern_action(__rte_unused struct iavf_adapter *ad,
 	uint64_t phint = IAVF_PHINT_NONE;
 	int ret = 0;
 
-	if (priority >= 1)
-		return -rte_errno;
+	ret = ci_flow_check_attr(attr, NULL, error);
+	if (ret)
+		return ret;
 
 	rss_meta_ptr = rte_zmalloc(NULL, sizeof(*rss_meta_ptr), 0);
 	if (!rss_meta_ptr) {
diff --git a/drivers/net/intel/iavf/iavf_ipsec_crypto.c b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
index 75da9f6413..be9e297486 100644
--- a/drivers/net/intel/iavf/iavf_ipsec_crypto.c
+++ b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
@@ -14,6 +14,7 @@
 #include "iavf_rxtx.h"
 #include "iavf_log.h"
 #include "iavf_generic_flow.h"
+#include "../common/flow_check.h"
 
 #include "iavf_ipsec_crypto.h"
 #include "iavf_ipsec_crypto_capabilities.h"
@@ -1953,15 +1954,16 @@ iavf_ipsec_flow_parse(struct iavf_adapter *ad,
 		      uint32_t array_len,
 		      const struct rte_flow_item pattern[],
 		      const struct rte_flow_action actions[],
-		      uint32_t priority,
+		      const struct rte_flow_attr *attr,
 		      void **meta,
 		      struct rte_flow_error *error)
 {
 	struct iavf_pattern_match_item *item = NULL;
 	int ret = -1;
 
-	if (priority >= 1)
-		return -rte_errno;
+	ret = ci_flow_check_attr(attr, NULL, error);
+	if (ret)
+		return ret;
 
 	item = iavf_search_pattern_match_item(pattern, array, array_len, error);
 	if (item && item->meta) {
-- 
2.47.3

