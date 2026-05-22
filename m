Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A907CD5BB0
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 15:15:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA76040A84;
	Fri, 22 May 2026 17:15:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 3269F40689
 for <dev@dpdk.org>; Fri, 22 May 2026 17:14:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779462896; x=1810998896;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=KO0fmHAVnoiht73nnwgd65vlfuHRz+yxWR4aK2jir7A=;
 b=cok/Bs8YCbn4H/TImI7rC9jGIldS6Uzjibqhqvo5rV5xwV5LnyQdOXeE
 MVYI26aevaPOgajNKkn5OwXKWW+KMspTCdfHYlgZuDrMmSLGPVrP+H3/B
 WdRnwAPCtTO7jNYUZJubUteuSlfcAc1Psu9rJN2aJchfnmuq/gUsbtl+r
 ZWWacq6HFBgPilOVdSTARoIhMX98cih9wV/F9XkHOVFNvPrQi7SWv3ruH
 CQKITkdcQxcviGK8Gx2kWV36gKdmKTVczd2wnI85y5I9V6MM2GArhsgjf
 2NfeWB1EFos7oS2reGceVzRZcXS0fxpH38BALj+4a15NyoEVx0LW61PbT A==;
X-CSE-ConnectionGUID: u9D2UhggS4WwrVhbNSZ2EA==
X-CSE-MsgGUID: hht/uh2/RE2fM3CRQdzW0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="97969165"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="97969165"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 08:14:56 -0700
X-CSE-ConnectionGUID: i9JEZ/LmRNCJkEgK2XdcsA==
X-CSE-MsgGUID: emDVd8FfRWOm2ZBNkcrx4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="245213972"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 22 May 2026 08:14:56 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 11/26] net/i40e: use common flow attribute checks
Date: Fri, 22 May 2026 16:14:20 +0100
Message-ID: <d98b70cb6335a3b76553583dba7297d4e6b41fd0.1779462699.git.anatoly.burakov@intel.com>
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

There is no need to call the same attribute checks in multiple places
when there are no cases where we do otherwise. Therefore, remove all the
attribute check calls from all filter call paths and instead check the
attributes once at the very beginning of flow validation, and use common
flow attribute checks instead of driver-local ones.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.h |   1 -
 drivers/net/intel/i40e/i40e_flow.c   | 121 +++------------------------
 2 files changed, 10 insertions(+), 112 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index d57c53f661..91ad0f8d0e 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -1315,7 +1315,6 @@ struct i40e_filter_ctx {
 };
 
 typedef int (*parse_filter_t)(struct rte_eth_dev *dev,
-			      const struct rte_flow_attr *attr,
 			      const struct rte_flow_item pattern[],
 			      const struct rte_flow_action actions[],
 			      struct rte_flow_error *error,
diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index c8eaa2b2e5..36e816758c 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -27,6 +27,8 @@
 #include "i40e_ethdev.h"
 #include "i40e_hash.h"
 
+#include "../common/flow_check.h"
+
 #define I40E_IPV6_TC_MASK	(0xFF << I40E_FDIR_IPv6_TC_OFFSET)
 #define I40E_IPV6_FRAG_HEADER	44
 #define I40E_TENANT_ARRAY_NUM	3
@@ -76,40 +78,32 @@ static int i40e_flow_parse_tunnel_action(struct rte_eth_dev *dev,
 				 const struct rte_flow_action *actions,
 				 struct rte_flow_error *error,
 				 struct i40e_tunnel_filter_conf *filter);
-static int i40e_flow_parse_attr(const struct rte_flow_attr *attr,
-				struct rte_flow_error *error);
 static int i40e_flow_parse_ethertype_filter(struct rte_eth_dev *dev,
-				    const struct rte_flow_attr *attr,
 				    const struct rte_flow_item pattern[],
 				    const struct rte_flow_action actions[],
 				    struct rte_flow_error *error,
 				    struct i40e_filter_ctx *filter);
 static int i40e_flow_parse_fdir_filter(struct rte_eth_dev *dev,
-				       const struct rte_flow_attr *attr,
 				       const struct rte_flow_item pattern[],
 				       const struct rte_flow_action actions[],
 				       struct rte_flow_error *error,
 				       struct i40e_filter_ctx *filter);
 static int i40e_flow_parse_vxlan_filter(struct rte_eth_dev *dev,
-					const struct rte_flow_attr *attr,
 					const struct rte_flow_item pattern[],
 					const struct rte_flow_action actions[],
 					struct rte_flow_error *error,
 					struct i40e_filter_ctx *filter);
 static int i40e_flow_parse_nvgre_filter(struct rte_eth_dev *dev,
-					const struct rte_flow_attr *attr,
 					const struct rte_flow_item pattern[],
 					const struct rte_flow_action actions[],
 					struct rte_flow_error *error,
 					struct i40e_filter_ctx *filter);
 static int i40e_flow_parse_mpls_filter(struct rte_eth_dev *dev,
-				       const struct rte_flow_attr *attr,
 				       const struct rte_flow_item pattern[],
 				       const struct rte_flow_action actions[],
 				       struct rte_flow_error *error,
 				       struct i40e_filter_ctx *filter);
 static int i40e_flow_parse_gtp_filter(struct rte_eth_dev *dev,
-				      const struct rte_flow_attr *attr,
 				      const struct rte_flow_item pattern[],
 				      const struct rte_flow_action actions[],
 				      struct rte_flow_error *error,
@@ -123,7 +117,6 @@ static int i40e_flow_flush_ethertype_filter(struct i40e_pf *pf);
 static int i40e_flow_flush_tunnel_filter(struct i40e_pf *pf);
 static int
 i40e_flow_parse_qinq_filter(struct rte_eth_dev *dev,
-			      const struct rte_flow_attr *attr,
 			      const struct rte_flow_item pattern[],
 			      const struct rte_flow_action actions[],
 			      struct rte_flow_error *error,
@@ -135,7 +128,6 @@ i40e_flow_parse_qinq_pattern(struct rte_eth_dev *dev,
 			      struct i40e_tunnel_filter_conf *filter);
 
 static int i40e_flow_parse_l4_cloud_filter(struct rte_eth_dev *dev,
-					   const struct rte_flow_attr *attr,
 					   const struct rte_flow_item pattern[],
 					   const struct rte_flow_action actions[],
 					   struct rte_flow_error *error,
@@ -1214,54 +1206,6 @@ i40e_find_parse_filter_func(struct rte_flow_item *pattern, uint32_t *idx)
 	return parse_filter;
 }
 
-/* Parse attributes */
-static int
-i40e_flow_parse_attr(const struct rte_flow_attr *attr,
-		     struct rte_flow_error *error)
-{
-	/* Must be input direction */
-	if (!attr->ingress) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ATTR_INGRESS,
-				   attr, "Only support ingress.");
-		return -rte_errno;
-	}
-
-	/* Not supported */
-	if (attr->egress) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ATTR_EGRESS,
-				   attr, "Not support egress.");
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
-	/* Not supported */
-	if (attr->priority) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY,
-				   attr, "Not support priority.");
-		return -rte_errno;
-	}
-
-	/* Not supported */
-	if (attr->group) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ATTR_GROUP,
-				   attr, "Not support group.");
-		return -rte_errno;
-	}
-
-	return 0;
-}
-
 #define I40E_FLOW_DUMP_CHUNK_BYTES 32
 
 static const char *
@@ -1546,7 +1490,6 @@ i40e_flow_parse_ethertype_action(struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_ethertype_filter(struct rte_eth_dev *dev,
-				 const struct rte_flow_attr *attr,
 				 const struct rte_flow_item pattern[],
 				 const struct rte_flow_action actions[],
 				 struct rte_flow_error *error,
@@ -1565,10 +1508,6 @@ i40e_flow_parse_ethertype_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_ETHERTYPE;
 
 	return ret;
@@ -2654,7 +2593,6 @@ i40e_flow_parse_fdir_action(struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_fdir_filter(struct rte_eth_dev *dev,
-			    const struct rte_flow_attr *attr,
 			    const struct rte_flow_item pattern[],
 			    const struct rte_flow_action actions[],
 			    struct rte_flow_error *error,
@@ -2671,10 +2609,6 @@ i40e_flow_parse_fdir_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_FDIR;
 
 	return 0;
@@ -2939,7 +2873,6 @@ i40e_flow_parse_l4_pattern(const struct rte_flow_item *pattern,
 
 static int
 i40e_flow_parse_l4_cloud_filter(struct rte_eth_dev *dev,
-				const struct rte_flow_attr *attr,
 				const struct rte_flow_item pattern[],
 				const struct rte_flow_action actions[],
 				struct rte_flow_error *error,
@@ -2956,10 +2889,6 @@ i40e_flow_parse_l4_cloud_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
@@ -3190,7 +3119,6 @@ i40e_flow_parse_vxlan_pattern(__rte_unused struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_vxlan_filter(struct rte_eth_dev *dev,
-			     const struct rte_flow_attr *attr,
 			     const struct rte_flow_item pattern[],
 			     const struct rte_flow_action actions[],
 			     struct rte_flow_error *error,
@@ -3208,10 +3136,6 @@ i40e_flow_parse_vxlan_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
@@ -3441,7 +3365,6 @@ i40e_flow_parse_nvgre_pattern(__rte_unused struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_nvgre_filter(struct rte_eth_dev *dev,
-			     const struct rte_flow_attr *attr,
 			     const struct rte_flow_item pattern[],
 			     const struct rte_flow_action actions[],
 			     struct rte_flow_error *error,
@@ -3459,10 +3382,6 @@ i40e_flow_parse_nvgre_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
@@ -3597,7 +3516,6 @@ i40e_flow_parse_mpls_pattern(__rte_unused struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_mpls_filter(struct rte_eth_dev *dev,
-			    const struct rte_flow_attr *attr,
 			    const struct rte_flow_item pattern[],
 			    const struct rte_flow_action actions[],
 			    struct rte_flow_error *error,
@@ -3615,10 +3533,6 @@ i40e_flow_parse_mpls_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
@@ -3749,7 +3663,6 @@ i40e_flow_parse_gtp_pattern(struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_gtp_filter(struct rte_eth_dev *dev,
-			   const struct rte_flow_attr *attr,
 			   const struct rte_flow_item pattern[],
 			   const struct rte_flow_action actions[],
 			   struct rte_flow_error *error,
@@ -3767,10 +3680,6 @@ i40e_flow_parse_gtp_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
@@ -3866,7 +3775,6 @@ i40e_flow_parse_qinq_pattern(__rte_unused struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_qinq_filter(struct rte_eth_dev *dev,
-			      const struct rte_flow_attr *attr,
 			      const struct rte_flow_item pattern[],
 			      const struct rte_flow_action actions[],
 			      struct rte_flow_error *error,
@@ -3884,10 +3792,6 @@ i40e_flow_parse_qinq_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
@@ -3906,7 +3810,12 @@ i40e_flow_check(struct rte_eth_dev *dev,
 	uint32_t item_num = 0; /* non-void item number of pattern*/
 	uint32_t i = 0;
 	bool flag = false;
-	int ret = I40E_NOT_SUPPORTED;
+	int ret;
+
+	ret = ci_flow_check_attr(attr, NULL, error);
+	if (ret) {
+		return ret;
+	}
 
 	if (!pattern) {
 		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM_NUM,
@@ -3921,22 +3830,11 @@ i40e_flow_check(struct rte_eth_dev *dev,
 		return -rte_errno;
 	}
 
-	if (!attr) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ATTR,
-				   NULL, "NULL attribute.");
-		return -rte_errno;
-	}
-
 	/* Get the non-void item of action */
 	while ((actions + i)->type == RTE_FLOW_ACTION_TYPE_VOID)
 		i++;
 
 	if ((actions + i)->type == RTE_FLOW_ACTION_TYPE_RSS) {
-		ret = i40e_flow_parse_attr(attr, error);
-		if (ret)
-			return ret;
-
 		filter_ctx->type = RTE_ETH_FILTER_HASH;
 		return i40e_hash_parse(dev, pattern, actions + i, &filter_ctx->rss_conf, error);
 	}
@@ -3961,6 +3859,7 @@ i40e_flow_check(struct rte_eth_dev *dev,
 	i40e_pattern_skip_void_item(items, pattern);
 
 	i = 0;
+	ret = I40E_NOT_SUPPORTED;
 	do {
 		parse_filter = i40e_find_parse_filter_func(items, &i);
 		if (!parse_filter && !flag) {
@@ -3973,7 +3872,7 @@ i40e_flow_check(struct rte_eth_dev *dev,
 		}
 
 		if (parse_filter)
-			ret = parse_filter(dev, attr, items, actions, error, filter_ctx);
+			ret = parse_filter(dev, items, actions, error, filter_ctx);
 
 		flag = true;
 	} while ((ret < 0) && (i < RTE_DIM(i40e_supported_patterns)));
-- 
2.47.3

