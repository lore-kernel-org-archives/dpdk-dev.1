Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF97E9E30D
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 14:22:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16E6740B95;
	Wed, 11 Feb 2026 15:21:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 54FED40A76
 for <dev@dpdk.org>; Wed, 11 Feb 2026 15:21:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770819669; x=1802355669;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=btHKn5JVJ95+GwzL80gyg2yVYr/isykcPD4isi2HZqQ=;
 b=VM24ihcgWc8qqS6Lzu+WsXf3rLWp3/11aIPJTCfD6Fef02mVlMxCz0sh
 D+VrQjoXgQAKbymPbZmB+MvLLtpJQvP0DR2eT3D+Y2nTWzO0E2nf6Mc8y
 9kPwmNpuf2ttaCl4GQ/VHSENVh+C0SLhXBeXvSaH6luOlI6cFjNR+meah
 YwWhOwCozwkERptIuKnmsJGODRJaGx6obeKjeAe6Ctxm0nYEqhEWsTIHu
 3H8mtGGm3AuZUvaDHERqWzdrMHZ9vWIIW8fLtzoGYmZgVIj6ACT8Dk9rX
 y/SUtAqMDMj3gVqR/+D2C4KLFXxRX5fT2pfV+oNug9WUkKQ4a6QiTTvCe Q==;
X-CSE-ConnectionGUID: svpNNsjCQ9OzcdgEvpJOrg==
X-CSE-MsgGUID: E+YZyvomSoOAkjKaLL7zog==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71866747"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71866747"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 06:21:09 -0800
X-CSE-ConnectionGUID: 33R98l+VSt6DaR2kPu5VRQ==
X-CSE-MsgGUID: 7uUuqvmuQX+Lr9HHSNiMLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211569155"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 11 Feb 2026 06:21:08 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 10/25] net/i40e: use common flow attribute checks
Date: Wed, 11 Feb 2026 14:20:27 +0000
Message-ID: <56fde40b78d3b79aa7737003fb3b3fdcb441398b.1770819434.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770819433.git.anatoly.burakov@intel.com>
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
index 025901edb6..312a9db12d 100644
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
index c5bb787f28..05abaf8ce3 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -25,6 +25,8 @@
 #include "i40e_ethdev.h"
 #include "i40e_hash.h"
 
+#include "../common/flow_check.h"
+
 #define I40E_IPV6_TC_MASK	(0xFF << I40E_FDIR_IPv6_TC_OFFSET)
 #define I40E_IPV6_FRAG_HEADER	44
 #define I40E_TENANT_ARRAY_NUM	3
@@ -73,40 +75,32 @@ static int i40e_flow_parse_tunnel_action(struct rte_eth_dev *dev,
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
@@ -120,7 +114,6 @@ static int i40e_flow_flush_ethertype_filter(struct i40e_pf *pf);
 static int i40e_flow_flush_tunnel_filter(struct i40e_pf *pf);
 static int
 i40e_flow_parse_qinq_filter(struct rte_eth_dev *dev,
-			      const struct rte_flow_attr *attr,
 			      const struct rte_flow_item pattern[],
 			      const struct rte_flow_action actions[],
 			      struct rte_flow_error *error,
@@ -132,7 +125,6 @@ i40e_flow_parse_qinq_pattern(struct rte_eth_dev *dev,
 			      struct i40e_tunnel_filter_conf *filter);
 
 static int i40e_flow_parse_l4_cloud_filter(struct rte_eth_dev *dev,
-					   const struct rte_flow_attr *attr,
 					   const struct rte_flow_item pattern[],
 					   const struct rte_flow_action actions[],
 					   struct rte_flow_error *error,
@@ -1210,54 +1202,6 @@ i40e_find_parse_filter_func(struct rte_flow_item *pattern, uint32_t *idx)
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
@@ -1445,7 +1389,6 @@ i40e_flow_parse_ethertype_action(struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_ethertype_filter(struct rte_eth_dev *dev,
-				 const struct rte_flow_attr *attr,
 				 const struct rte_flow_item pattern[],
 				 const struct rte_flow_action actions[],
 				 struct rte_flow_error *error,
@@ -1464,10 +1407,6 @@ i40e_flow_parse_ethertype_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_ETHERTYPE;
 
 	return ret;
@@ -2539,7 +2478,6 @@ i40e_flow_parse_fdir_action(struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_fdir_filter(struct rte_eth_dev *dev,
-			    const struct rte_flow_attr *attr,
 			    const struct rte_flow_item pattern[],
 			    const struct rte_flow_action actions[],
 			    struct rte_flow_error *error,
@@ -2556,10 +2494,6 @@ i40e_flow_parse_fdir_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_FDIR;
 
 	return 0;
@@ -2824,7 +2758,6 @@ i40e_flow_parse_l4_pattern(const struct rte_flow_item *pattern,
 
 static int
 i40e_flow_parse_l4_cloud_filter(struct rte_eth_dev *dev,
-				const struct rte_flow_attr *attr,
 				const struct rte_flow_item pattern[],
 				const struct rte_flow_action actions[],
 				struct rte_flow_error *error,
@@ -2841,10 +2774,6 @@ i40e_flow_parse_l4_cloud_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
@@ -3075,7 +3004,6 @@ i40e_flow_parse_vxlan_pattern(__rte_unused struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_vxlan_filter(struct rte_eth_dev *dev,
-			     const struct rte_flow_attr *attr,
 			     const struct rte_flow_item pattern[],
 			     const struct rte_flow_action actions[],
 			     struct rte_flow_error *error,
@@ -3093,10 +3021,6 @@ i40e_flow_parse_vxlan_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
@@ -3326,7 +3250,6 @@ i40e_flow_parse_nvgre_pattern(__rte_unused struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_nvgre_filter(struct rte_eth_dev *dev,
-			     const struct rte_flow_attr *attr,
 			     const struct rte_flow_item pattern[],
 			     const struct rte_flow_action actions[],
 			     struct rte_flow_error *error,
@@ -3344,10 +3267,6 @@ i40e_flow_parse_nvgre_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
@@ -3482,7 +3401,6 @@ i40e_flow_parse_mpls_pattern(__rte_unused struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_mpls_filter(struct rte_eth_dev *dev,
-			    const struct rte_flow_attr *attr,
 			    const struct rte_flow_item pattern[],
 			    const struct rte_flow_action actions[],
 			    struct rte_flow_error *error,
@@ -3500,10 +3418,6 @@ i40e_flow_parse_mpls_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
@@ -3634,7 +3548,6 @@ i40e_flow_parse_gtp_pattern(struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_gtp_filter(struct rte_eth_dev *dev,
-			   const struct rte_flow_attr *attr,
 			   const struct rte_flow_item pattern[],
 			   const struct rte_flow_action actions[],
 			   struct rte_flow_error *error,
@@ -3652,10 +3565,6 @@ i40e_flow_parse_gtp_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
@@ -3751,7 +3660,6 @@ i40e_flow_parse_qinq_pattern(__rte_unused struct rte_eth_dev *dev,
 
 static int
 i40e_flow_parse_qinq_filter(struct rte_eth_dev *dev,
-			      const struct rte_flow_attr *attr,
 			      const struct rte_flow_item pattern[],
 			      const struct rte_flow_action actions[],
 			      struct rte_flow_error *error,
@@ -3769,10 +3677,6 @@ i40e_flow_parse_qinq_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = i40e_flow_parse_attr(attr, error);
-	if (ret)
-		return ret;
-
 	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
@@ -3791,7 +3695,12 @@ i40e_flow_check(struct rte_eth_dev *dev,
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
@@ -3806,22 +3715,11 @@ i40e_flow_check(struct rte_eth_dev *dev,
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
@@ -3846,6 +3744,7 @@ i40e_flow_check(struct rte_eth_dev *dev,
 	i40e_pattern_skip_void_item(items, pattern);
 
 	i = 0;
+	ret = I40E_NOT_SUPPORTED;
 	do {
 		parse_filter = i40e_find_parse_filter_func(items, &i);
 		if (!parse_filter && !flag) {
@@ -3858,7 +3757,7 @@ i40e_flow_check(struct rte_eth_dev *dev,
 		}
 
 		if (parse_filter)
-			ret = parse_filter(dev, attr, items, actions, error, filter_ctx);
+			ret = parse_filter(dev, items, actions, error, filter_ctx);
 
 		flag = true;
 	} while ((ret < 0) && (i < RTE_DIM(i40e_supported_patterns)));
-- 
2.47.3

