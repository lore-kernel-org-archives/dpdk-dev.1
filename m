Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638ACF4485A
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 13:15:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF24C406B7;
	Fri, 10 Apr 2026 15:13:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 09797406A2
 for <dev@dpdk.org>; Fri, 10 Apr 2026 15:13:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775826827; x=1807362827;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=50lTTjjIbMe8p/OKdtPr6T1D9M3Xy5UtLbgeBxPLg6Q=;
 b=nHSfdPPrbkzuc9eL9UqEOzzorxxe4xZi565RPPApKn+iObEdr/xlpVXd
 smDRiz/TUS0ELkl+PJUVgVPPIBsWDiyWB2f1l47M0XQ5MXhXHNVuX54CR
 aYVhijlXEMCN8ERF/ac7S5JanRF4lCGiXah42UG9MzFTqXDIkFor9gL/R
 H0Nju9ZlquuQQrtzuizNTMvGn4FTaSrDPySR4o2V3pmQZamvo+3qOD4C8
 tWNNcBjl7dTRraz/QQQWx6znYcJMbjxEU3AFmGIyhZcuSHBJUGBwRbttg
 LMZgfV/iFrCCgW9rP9t1OGBgXEwagqUsHpIai1x6D7d181ZCF3TQeYgEz w==;
X-CSE-ConnectionGUID: jjV/AfayTtSs3cLeZSCqLg==
X-CSE-MsgGUID: sNSnA7MhTKuEhPX5qNJ3zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76736335"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="76736335"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 06:13:47 -0700
X-CSE-ConnectionGUID: KrathjrWTRSsUBIhjFBqWQ==
X-CSE-MsgGUID: +zgGiNvlQRyBvRwEf2NpUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="234084672"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 10 Apr 2026 06:13:46 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 14/29] net/i40e: use common flow attribute checks
Date: Fri, 10 Apr 2026 14:13:08 +0100
Message-ID: <23a3402b08512648fcae7fc13a391f7f44177456.1775826526.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1775826526.git.anatoly.burakov@intel.com>
 <cover.1775826526.git.anatoly.burakov@intel.com>
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
index 967af052ff..0543f7f297 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -26,6 +26,8 @@
 #include "i40e_ethdev.h"
 #include "i40e_hash.h"
 
+#include "../common/flow_check.h"
+
 #define I40E_IPV6_TC_MASK	(0xFF << I40E_FDIR_IPv6_TC_OFFSET)
 #define I40E_IPV6_FRAG_HEADER	44
 #define I40E_TENANT_ARRAY_NUM	3
@@ -71,40 +73,32 @@ static int i40e_flow_parse_tunnel_action(struct rte_eth_dev *dev,
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
@@ -118,7 +112,6 @@ static int i40e_flow_flush_ethertype_filter(struct i40e_pf *pf);
 static int i40e_flow_flush_tunnel_filter(struct i40e_pf *pf);
 static int
 i40e_flow_parse_qinq_filter(struct rte_eth_dev *dev,
-			      const struct rte_flow_attr *attr,
 			      const struct rte_flow_item pattern[],
 			      const struct rte_flow_action actions[],
 			      struct rte_flow_error *error,
@@ -130,7 +123,6 @@ i40e_flow_parse_qinq_pattern(struct rte_eth_dev *dev,
 			      struct i40e_tunnel_filter_conf *filter);
 
 static int i40e_flow_parse_l4_cloud_filter(struct rte_eth_dev *dev,
-					   const struct rte_flow_attr *attr,
 					   const struct rte_flow_item pattern[],
 					   const struct rte_flow_action actions[],
 					   struct rte_flow_error *error,
@@ -1208,54 +1200,6 @@ i40e_find_parse_filter_func(struct rte_flow_item *pattern, uint32_t *idx)
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
 static int
 i40e_get_outer_vlan(struct rte_eth_dev *dev, uint16_t *tpid)
 {
@@ -1443,7 +1387,6 @@ i40e_flow_parse_ethertype_action(struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_ethertype_filter(struct rte_eth_dev *dev,
-				 const struct rte_flow_attr *attr,
 				 const struct rte_flow_item pattern[],
 				 const struct rte_flow_action actions[],
 				 struct rte_flow_error *error,
@@ -1462,10 +1405,6 @@ i40e_flow_parse_ethertype_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_ETHERTYPE;
 
 	return ret;
@@ -2551,7 +2490,6 @@ i40e_flow_parse_fdir_action(struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_fdir_filter(struct rte_eth_dev *dev,
-			    const struct rte_flow_attr *attr,
 			    const struct rte_flow_item pattern[],
 			    const struct rte_flow_action actions[],
 			    struct rte_flow_error *error,
@@ -2568,10 +2506,6 @@ i40e_flow_parse_fdir_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_FDIR;
 
 	return 0;
@@ -2836,7 +2770,6 @@ i40e_flow_parse_l4_pattern(const struct rte_flow_item *pattern,
 
 static int
 i40e_flow_parse_l4_cloud_filter(struct rte_eth_dev *dev,
-				const struct rte_flow_attr *attr,
 				const struct rte_flow_item pattern[],
 				const struct rte_flow_action actions[],
 				struct rte_flow_error *error,
@@ -2853,10 +2786,6 @@ i40e_flow_parse_l4_cloud_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
@@ -3087,7 +3016,6 @@ i40e_flow_parse_vxlan_pattern(__rte_unused struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_vxlan_filter(struct rte_eth_dev *dev,
-			     const struct rte_flow_attr *attr,
 			     const struct rte_flow_item pattern[],
 			     const struct rte_flow_action actions[],
 			     struct rte_flow_error *error,
@@ -3105,10 +3033,6 @@ i40e_flow_parse_vxlan_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
@@ -3338,7 +3262,6 @@ i40e_flow_parse_nvgre_pattern(__rte_unused struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_nvgre_filter(struct rte_eth_dev *dev,
-			     const struct rte_flow_attr *attr,
 			     const struct rte_flow_item pattern[],
 			     const struct rte_flow_action actions[],
 			     struct rte_flow_error *error,
@@ -3356,10 +3279,6 @@ i40e_flow_parse_nvgre_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
@@ -3494,7 +3413,6 @@ i40e_flow_parse_mpls_pattern(__rte_unused struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_mpls_filter(struct rte_eth_dev *dev,
-			    const struct rte_flow_attr *attr,
 			    const struct rte_flow_item pattern[],
 			    const struct rte_flow_action actions[],
 			    struct rte_flow_error *error,
@@ -3512,10 +3430,6 @@ i40e_flow_parse_mpls_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
@@ -3646,7 +3560,6 @@ i40e_flow_parse_gtp_pattern(struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_gtp_filter(struct rte_eth_dev *dev,
-			   const struct rte_flow_attr *attr,
 			   const struct rte_flow_item pattern[],
 			   const struct rte_flow_action actions[],
 			   struct rte_flow_error *error,
@@ -3664,10 +3577,6 @@ i40e_flow_parse_gtp_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
@@ -3763,7 +3672,6 @@ i40e_flow_parse_qinq_pattern(__rte_unused struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_qinq_filter(struct rte_eth_dev *dev,
-			      const struct rte_flow_attr *attr,
 			      const struct rte_flow_item pattern[],
 			      const struct rte_flow_action actions[],
 			      struct rte_flow_error *error,
@@ -3781,10 +3689,6 @@ i40e_flow_parse_qinq_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
@@ -3803,7 +3707,12 @@ i40e_flow_check(struct rte_eth_dev *dev,
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
@@ -3818,22 +3727,11 @@ i40e_flow_check(struct rte_eth_dev *dev,
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
@@ -3858,6 +3756,7 @@ i40e_flow_check(struct rte_eth_dev *dev,
 	i40e_pattern_skip_void_item(items, pattern);
 
 	i = 0;
+	ret = I40E_NOT_SUPPORTED;
 	do {
 		parse_filter = i40e_find_parse_filter_func(items, &i);
 		if (!parse_filter && !flag) {
@@ -3870,7 +3769,7 @@ i40e_flow_check(struct rte_eth_dev *dev,
 		}
 
 		if (parse_filter)
-			ret = parse_filter(dev, attr, items, actions, error, filter_ctx);
+			ret = parse_filter(dev, items, actions, error, filter_ctx);
 
 		flag = true;
 	} while ((ret < 0) && (i < RTE_DIM(i40e_supported_patterns)));
-- 
2.47.3

