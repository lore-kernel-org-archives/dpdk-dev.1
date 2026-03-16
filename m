Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861EBF4644B
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 10:54:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C7534067D;
	Mon, 16 Mar 2026 11:53:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 1B77540672
 for <dev@dpdk.org>; Mon, 16 Mar 2026 11:53:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773658389; x=1805194389;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=8oexHKBUipKDDDP2ZwF6tCZymSuNl2feQ67xbO14wzc=;
 b=KdfrrJpHDMGw+JmNvDz00E7y/RZHG3J68j7Y6Fx9m3qwCveOaZzbRmAz
 EHoLy0v4Fyn4LgCDZhyk/UoCJSetCkWAp+fUWKBotvpCBYVrifYRH/IyC
 cUWBDWYTYPvQoUtvttVyKUS4asdicX39zn2CyGG7deNF+8e0DVlEqCZMk
 jemFUiwFL9MI8xfHbC79bJ3lwhlXBKhEx+qyClRMy1OBF7LZVLwPrZfKV
 wGkVeRo2Ks35s04FdnWDvESdawtLrf2oRaFByeasdt3DqtdPmYHln/rpO
 aexlNp2kcnSHH6rI5BGqH4Upsfu22T5Ql13rv+bLoWfMTAOGFNWetN3G7 A==;
X-CSE-ConnectionGUID: 4u/fYq3sQBus9DBJpo+KCw==
X-CSE-MsgGUID: 0S9AOz93Qm2ZJEUGhTjS9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="62237422"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="62237422"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 03:53:08 -0700
X-CSE-ConnectionGUID: 1D431nutR5S0dg3NdrvBcQ==
X-CSE-MsgGUID: n8d/bc2LQuy2CxL4zTMQ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221826744"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 16 Mar 2026 03:53:07 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 10/25] net/i40e: use common flow attribute checks
Date: Mon, 16 Mar 2026 10:52:35 +0000
Message-ID: <86eed5baa8b126b4f74af482cae607f86392841d.1773658289.git.anatoly.burakov@intel.com>
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
index 84cfddb92d..4d21df327b 100644
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
@@ -74,40 +76,32 @@ static int i40e_flow_parse_tunnel_action(struct rte_eth_dev *dev,
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
@@ -121,7 +115,6 @@ static int i40e_flow_flush_ethertype_filter(struct i40e_pf *pf);
 static int i40e_flow_flush_tunnel_filter(struct i40e_pf *pf);
 static int
 i40e_flow_parse_qinq_filter(struct rte_eth_dev *dev,
-			      const struct rte_flow_attr *attr,
 			      const struct rte_flow_item pattern[],
 			      const struct rte_flow_action actions[],
 			      struct rte_flow_error *error,
@@ -133,7 +126,6 @@ i40e_flow_parse_qinq_pattern(struct rte_eth_dev *dev,
 			      struct i40e_tunnel_filter_conf *filter);
 
 static int i40e_flow_parse_l4_cloud_filter(struct rte_eth_dev *dev,
-					   const struct rte_flow_attr *attr,
 					   const struct rte_flow_item pattern[],
 					   const struct rte_flow_action actions[],
 					   struct rte_flow_error *error,
@@ -1211,54 +1203,6 @@ i40e_find_parse_filter_func(struct rte_flow_item *pattern, uint32_t *idx)
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
@@ -1446,7 +1390,6 @@ i40e_flow_parse_ethertype_action(struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_ethertype_filter(struct rte_eth_dev *dev,
-				 const struct rte_flow_attr *attr,
 				 const struct rte_flow_item pattern[],
 				 const struct rte_flow_action actions[],
 				 struct rte_flow_error *error,
@@ -1465,10 +1408,6 @@ i40e_flow_parse_ethertype_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_ETHERTYPE;
 
 	return ret;
@@ -2564,7 +2503,6 @@ i40e_flow_parse_fdir_action(struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_fdir_filter(struct rte_eth_dev *dev,
-			    const struct rte_flow_attr *attr,
 			    const struct rte_flow_item pattern[],
 			    const struct rte_flow_action actions[],
 			    struct rte_flow_error *error,
@@ -2581,10 +2519,6 @@ i40e_flow_parse_fdir_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_FDIR;
 
 	return 0;
@@ -2849,7 +2783,6 @@ i40e_flow_parse_l4_pattern(const struct rte_flow_item *pattern,
 
 static int
 i40e_flow_parse_l4_cloud_filter(struct rte_eth_dev *dev,
-				const struct rte_flow_attr *attr,
 				const struct rte_flow_item pattern[],
 				const struct rte_flow_action actions[],
 				struct rte_flow_error *error,
@@ -2866,10 +2799,6 @@ i40e_flow_parse_l4_cloud_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
@@ -3100,7 +3029,6 @@ i40e_flow_parse_vxlan_pattern(__rte_unused struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_vxlan_filter(struct rte_eth_dev *dev,
-			     const struct rte_flow_attr *attr,
 			     const struct rte_flow_item pattern[],
 			     const struct rte_flow_action actions[],
 			     struct rte_flow_error *error,
@@ -3118,10 +3046,6 @@ i40e_flow_parse_vxlan_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
@@ -3351,7 +3275,6 @@ i40e_flow_parse_nvgre_pattern(__rte_unused struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_nvgre_filter(struct rte_eth_dev *dev,
-			     const struct rte_flow_attr *attr,
 			     const struct rte_flow_item pattern[],
 			     const struct rte_flow_action actions[],
 			     struct rte_flow_error *error,
@@ -3369,10 +3292,6 @@ i40e_flow_parse_nvgre_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
@@ -3507,7 +3426,6 @@ i40e_flow_parse_mpls_pattern(__rte_unused struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_mpls_filter(struct rte_eth_dev *dev,
-			    const struct rte_flow_attr *attr,
 			    const struct rte_flow_item pattern[],
 			    const struct rte_flow_action actions[],
 			    struct rte_flow_error *error,
@@ -3525,10 +3443,6 @@ i40e_flow_parse_mpls_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
@@ -3659,7 +3573,6 @@ i40e_flow_parse_gtp_pattern(struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_gtp_filter(struct rte_eth_dev *dev,
-			   const struct rte_flow_attr *attr,
 			   const struct rte_flow_item pattern[],
 			   const struct rte_flow_action actions[],
 			   struct rte_flow_error *error,
@@ -3677,10 +3590,6 @@ i40e_flow_parse_gtp_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
@@ -3776,7 +3685,6 @@ i40e_flow_parse_qinq_pattern(__rte_unused struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_qinq_filter(struct rte_eth_dev *dev,
-			      const struct rte_flow_attr *attr,
 			      const struct rte_flow_item pattern[],
 			      const struct rte_flow_action actions[],
 			      struct rte_flow_error *error,
@@ -3794,10 +3702,6 @@ i40e_flow_parse_qinq_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
@@ -3816,7 +3720,12 @@ i40e_flow_check(struct rte_eth_dev *dev,
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
@@ -3831,22 +3740,11 @@ i40e_flow_check(struct rte_eth_dev *dev,
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
@@ -3871,6 +3769,7 @@ i40e_flow_check(struct rte_eth_dev *dev,
 	i40e_pattern_skip_void_item(items, pattern);
 
 	i = 0;
+	ret = I40E_NOT_SUPPORTED;
 	do {
 		parse_filter = i40e_find_parse_filter_func(items, &i);
 		if (!parse_filter && !flag) {
@@ -3883,7 +3782,7 @@ i40e_flow_check(struct rte_eth_dev *dev,
 		}
 
 		if (parse_filter)
-			ret = parse_filter(dev, attr, items, actions, error, filter_ctx);
+			ret = parse_filter(dev, items, actions, error, filter_ctx);
 
 		flag = true;
 	} while ((ret < 0) && (i < RTE_DIM(i40e_supported_patterns)));
-- 
2.47.3

