Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6E9EA3F22
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 16:14:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABAF040A76;
	Tue, 10 Feb 2026 17:14:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id B6B6840687
 for <dev@dpdk.org>; Tue, 10 Feb 2026 17:14:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770740050; x=1802276050;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=oanRrHLpDnVCJ1NEcJfhieiQoU6ARcZjRdY2QyJtQQY=;
 b=EolWJJaeCnyRlnBONt5CPWEj+GWDGO8h9f9awMTLH2h7W83cAz9jldrX
 JPVsfZCTcJdufqB2qmRpkUQO74z88JmaraM4kZgR4ZeiiHwaZNB+RjKcU
 Vcsq3YpHtZ9jYUvyN6l/H25K2H7xVecY15RuTpAQLBNET1a8RT06iKa4J
 45dl60GM/UNdAJZ3rpe81dhez556pkpWQpXl1mZmruLLxNpI8PX5axzav
 BWIooXFbRa442qBXcI/EuF69kh65zNWIHstX9nXDd6yQ/Hr68PGd3h3FT
 P6zhK8RkvRP1w1oNCkR25gfckdhvbjRzcssJ1dRC1zJK2kB2GufgjMFeT Q==;
X-CSE-ConnectionGUID: EZ9EINi4SkWGtgCKE/3Uqw==
X-CSE-MsgGUID: nJoFX14lR624ffALY+/HhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="89286185"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="89286185"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 08:14:09 -0800
X-CSE-ConnectionGUID: qL3H6KaYQ7aYT0SZ8wXiFQ==
X-CSE-MsgGUID: TILB/a+JSxKsqEZAKhI8Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216127726"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 10 Feb 2026 08:14:08 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 04/26] net/i40e: get rid of global filter variables
Date: Tue, 10 Feb 2026 16:13:33 +0000
Message-ID: <4d4008d9965c5eccfbf64f0423d4329241463e27.1770739924.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770739924.git.anatoly.burakov@intel.com>
 <cover.1770739924.git.anatoly.burakov@intel.com>
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

Currently, i40e driver relies on global state to work around the fact that
`rte_flow_validate()` is being called directly from `rte_flow_create()`,
and it not being possible to pass state between two functions. Fix that by
making a small wrapper around validation that will create a dummy context.

Additionally, tunnel filter doesn't appear to be used by anything and so is
omitted from the structure.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.h |  16 ++--
 drivers/net/intel/i40e/i40e_flow.c   | 117 ++++++++++++++-------------
 2 files changed, 68 insertions(+), 65 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index cab6d7e9dc..0de036f2d9 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -1304,12 +1304,14 @@ struct i40e_vf_representor {
 
 extern const struct rte_flow_ops i40e_flow_ops;
 
-union i40e_filter_t {
-	struct rte_eth_ethertype_filter ethertype_filter;
-	struct i40e_fdir_filter_conf fdir_filter;
-	struct rte_eth_tunnel_filter_conf tunnel_filter;
-	struct i40e_tunnel_filter_conf consistent_tunnel_filter;
-	struct i40e_rte_flow_rss_conf rss_conf;
+struct i40e_filter_ctx {
+	union {
+		struct rte_eth_ethertype_filter ethertype_filter;
+		struct i40e_fdir_filter_conf fdir_filter;
+		struct i40e_tunnel_filter_conf consistent_tunnel_filter;
+		struct i40e_rte_flow_rss_conf rss_conf;
+	};
+	enum rte_filter_type type;
 };
 
 typedef int (*parse_filter_t)(struct rte_eth_dev *dev,
@@ -1317,7 +1319,7 @@ typedef int (*parse_filter_t)(struct rte_eth_dev *dev,
 			      const struct rte_flow_item pattern[],
 			      const struct rte_flow_action actions[],
 			      struct rte_flow_error *error,
-			      union i40e_filter_t *filter);
+			      struct i40e_filter_ctx *filter);
 struct i40e_valid_pattern {
 	enum rte_flow_item_type *items;
 	parse_filter_t parse_filter;
diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 2374b9bbca..e611de0c06 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -80,37 +80,37 @@ static int i40e_flow_parse_ethertype_filter(struct rte_eth_dev *dev,
 				    const struct rte_flow_item pattern[],
 				    const struct rte_flow_action actions[],
 				    struct rte_flow_error *error,
-				    union i40e_filter_t *filter);
+				    struct i40e_filter_ctx *filter);
 static int i40e_flow_parse_fdir_filter(struct rte_eth_dev *dev,
 				       const struct rte_flow_attr *attr,
 				       const struct rte_flow_item pattern[],
 				       const struct rte_flow_action actions[],
 				       struct rte_flow_error *error,
-				       union i40e_filter_t *filter);
+				       struct i40e_filter_ctx *filter);
 static int i40e_flow_parse_vxlan_filter(struct rte_eth_dev *dev,
 					const struct rte_flow_attr *attr,
 					const struct rte_flow_item pattern[],
 					const struct rte_flow_action actions[],
 					struct rte_flow_error *error,
-					union i40e_filter_t *filter);
+					struct i40e_filter_ctx *filter);
 static int i40e_flow_parse_nvgre_filter(struct rte_eth_dev *dev,
 					const struct rte_flow_attr *attr,
 					const struct rte_flow_item pattern[],
 					const struct rte_flow_action actions[],
 					struct rte_flow_error *error,
-					union i40e_filter_t *filter);
+					struct i40e_filter_ctx *filter);
 static int i40e_flow_parse_mpls_filter(struct rte_eth_dev *dev,
 				       const struct rte_flow_attr *attr,
 				       const struct rte_flow_item pattern[],
 				       const struct rte_flow_action actions[],
 				       struct rte_flow_error *error,
-				       union i40e_filter_t *filter);
+				       struct i40e_filter_ctx *filter);
 static int i40e_flow_parse_gtp_filter(struct rte_eth_dev *dev,
 				      const struct rte_flow_attr *attr,
 				      const struct rte_flow_item pattern[],
 				      const struct rte_flow_action actions[],
 				      struct rte_flow_error *error,
-				      union i40e_filter_t *filter);
+				      struct i40e_filter_ctx *filter);
 static int i40e_flow_destroy_ethertype_filter(struct i40e_pf *pf,
 				      struct i40e_ethertype_filter *filter);
 static int i40e_flow_destroy_tunnel_filter(struct i40e_pf *pf,
@@ -124,7 +124,7 @@ i40e_flow_parse_qinq_filter(struct rte_eth_dev *dev,
 			      const struct rte_flow_item pattern[],
 			      const struct rte_flow_action actions[],
 			      struct rte_flow_error *error,
-			      union i40e_filter_t *filter);
+			      struct i40e_filter_ctx *filter);
 static int
 i40e_flow_parse_qinq_pattern(struct rte_eth_dev *dev,
 			      const struct rte_flow_item *pattern,
@@ -136,7 +136,7 @@ static int i40e_flow_parse_l4_cloud_filter(struct rte_eth_dev *dev,
 					   const struct rte_flow_item pattern[],
 					   const struct rte_flow_action actions[],
 					   struct rte_flow_error *error,
-					   union i40e_filter_t *filter);
+					   struct i40e_filter_ctx *filter);
 const struct rte_flow_ops i40e_flow_ops = {
 	.validate = i40e_flow_validate,
 	.create = i40e_flow_create,
@@ -145,8 +145,6 @@ const struct rte_flow_ops i40e_flow_ops = {
 	.query = i40e_flow_query,
 };
 
-static union i40e_filter_t cons_filter;
-static enum rte_filter_type cons_filter_type = RTE_ETH_FILTER_NONE;
 /* internal pattern w/o VOID items */
 struct rte_flow_item g_items[32];
 
@@ -1454,10 +1452,9 @@ i40e_flow_parse_ethertype_filter(struct rte_eth_dev *dev,
 				 const struct rte_flow_item pattern[],
 				 const struct rte_flow_action actions[],
 				 struct rte_flow_error *error,
-				 union i40e_filter_t *filter)
+				 struct i40e_filter_ctx *filter)
 {
-	struct rte_eth_ethertype_filter *ethertype_filter =
-		&filter->ethertype_filter;
+	struct rte_eth_ethertype_filter *ethertype_filter = &filter->ethertype_filter;
 	int ret;
 
 	ret = i40e_flow_parse_ethertype_pattern(dev, pattern, error,
@@ -1474,7 +1471,7 @@ i40e_flow_parse_ethertype_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	cons_filter_type = RTE_ETH_FILTER_ETHERTYPE;
+	filter->type = RTE_ETH_FILTER_ETHERTYPE;
 
 	return ret;
 }
@@ -2549,7 +2546,7 @@ i40e_flow_parse_fdir_filter(struct rte_eth_dev *dev,
 			    const struct rte_flow_item pattern[],
 			    const struct rte_flow_action actions[],
 			    struct rte_flow_error *error,
-			    union i40e_filter_t *filter)
+			    struct i40e_filter_ctx *filter)
 {
 	struct i40e_fdir_filter_conf *fdir_filter = &filter->fdir_filter;
 	int ret;
@@ -2566,7 +2563,7 @@ i40e_flow_parse_fdir_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	cons_filter_type = RTE_ETH_FILTER_FDIR;
+	filter->type = RTE_ETH_FILTER_FDIR;
 
 	return 0;
 }
@@ -2834,10 +2831,9 @@ i40e_flow_parse_l4_cloud_filter(struct rte_eth_dev *dev,
 				const struct rte_flow_item pattern[],
 				const struct rte_flow_action actions[],
 				struct rte_flow_error *error,
-				union i40e_filter_t *filter)
+				struct i40e_filter_ctx *filter)
 {
-	struct i40e_tunnel_filter_conf *tunnel_filter =
-		&filter->consistent_tunnel_filter;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &filter->consistent_tunnel_filter;
 	int ret;
 
 	ret = i40e_flow_parse_l4_pattern(pattern, error, tunnel_filter);
@@ -2852,7 +2848,7 @@ i40e_flow_parse_l4_cloud_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	cons_filter_type = RTE_ETH_FILTER_TUNNEL;
+	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
 }
@@ -3086,10 +3082,9 @@ i40e_flow_parse_vxlan_filter(struct rte_eth_dev *dev,
 			     const struct rte_flow_item pattern[],
 			     const struct rte_flow_action actions[],
 			     struct rte_flow_error *error,
-			     union i40e_filter_t *filter)
+			     struct i40e_filter_ctx *filter)
 {
-	struct i40e_tunnel_filter_conf *tunnel_filter =
-		&filter->consistent_tunnel_filter;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &filter->consistent_tunnel_filter;
 	int ret;
 
 	ret = i40e_flow_parse_vxlan_pattern(dev, pattern,
@@ -3105,7 +3100,7 @@ i40e_flow_parse_vxlan_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	cons_filter_type = RTE_ETH_FILTER_TUNNEL;
+	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
 }
@@ -3338,10 +3333,9 @@ i40e_flow_parse_nvgre_filter(struct rte_eth_dev *dev,
 			     const struct rte_flow_item pattern[],
 			     const struct rte_flow_action actions[],
 			     struct rte_flow_error *error,
-			     union i40e_filter_t *filter)
+			     struct i40e_filter_ctx *filter)
 {
-	struct i40e_tunnel_filter_conf *tunnel_filter =
-		&filter->consistent_tunnel_filter;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &filter->consistent_tunnel_filter;
 	int ret;
 
 	ret = i40e_flow_parse_nvgre_pattern(dev, pattern,
@@ -3357,7 +3351,7 @@ i40e_flow_parse_nvgre_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	cons_filter_type = RTE_ETH_FILTER_TUNNEL;
+	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
 }
@@ -3495,10 +3489,9 @@ i40e_flow_parse_mpls_filter(struct rte_eth_dev *dev,
 			    const struct rte_flow_item pattern[],
 			    const struct rte_flow_action actions[],
 			    struct rte_flow_error *error,
-			    union i40e_filter_t *filter)
+			    struct i40e_filter_ctx *filter)
 {
-	struct i40e_tunnel_filter_conf *tunnel_filter =
-		&filter->consistent_tunnel_filter;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &filter->consistent_tunnel_filter;
 	int ret;
 
 	ret = i40e_flow_parse_mpls_pattern(dev, pattern,
@@ -3514,7 +3507,7 @@ i40e_flow_parse_mpls_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	cons_filter_type = RTE_ETH_FILTER_TUNNEL;
+	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
 }
@@ -3648,10 +3641,9 @@ i40e_flow_parse_gtp_filter(struct rte_eth_dev *dev,
 			   const struct rte_flow_item pattern[],
 			   const struct rte_flow_action actions[],
 			   struct rte_flow_error *error,
-			   union i40e_filter_t *filter)
+			   struct i40e_filter_ctx *filter)
 {
-	struct i40e_tunnel_filter_conf *tunnel_filter =
-		&filter->consistent_tunnel_filter;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &filter->consistent_tunnel_filter;
 	int ret;
 
 	ret = i40e_flow_parse_gtp_pattern(dev, pattern,
@@ -3667,7 +3659,7 @@ i40e_flow_parse_gtp_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	cons_filter_type = RTE_ETH_FILTER_TUNNEL;
+	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
 }
@@ -3766,10 +3758,9 @@ i40e_flow_parse_qinq_filter(struct rte_eth_dev *dev,
 			      const struct rte_flow_item pattern[],
 			      const struct rte_flow_action actions[],
 			      struct rte_flow_error *error,
-			      union i40e_filter_t *filter)
+			      struct i40e_filter_ctx *filter)
 {
-	struct i40e_tunnel_filter_conf *tunnel_filter =
-		&filter->consistent_tunnel_filter;
+	struct i40e_tunnel_filter_conf *tunnel_filter = &filter->consistent_tunnel_filter;
 	int ret;
 
 	ret = i40e_flow_parse_qinq_pattern(dev, pattern,
@@ -3785,16 +3776,17 @@ i40e_flow_parse_qinq_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	cons_filter_type = RTE_ETH_FILTER_TUNNEL;
+	filter->type = RTE_ETH_FILTER_TUNNEL;
 
 	return ret;
 }
 
 static int
-i40e_flow_validate(struct rte_eth_dev *dev,
+i40e_flow_check(struct rte_eth_dev *dev,
 		   const struct rte_flow_attr *attr,
 		   const struct rte_flow_item pattern[],
 		   const struct rte_flow_action actions[],
+		   struct i40e_filter_ctx *filter_ctx,
 		   struct rte_flow_error *error)
 {
 	struct rte_flow_item *items; /* internal pattern w/o VOID items */
@@ -3823,7 +3815,6 @@ i40e_flow_validate(struct rte_eth_dev *dev,
 				   NULL, "NULL attribute.");
 		return -rte_errno;
 	}
-	memset(&cons_filter, 0, sizeof(cons_filter));
 
 	/* Get the non-void item of action */
 	while ((actions + i)->type == RTE_FLOW_ACTION_TYPE_VOID)
@@ -3834,9 +3825,8 @@ i40e_flow_validate(struct rte_eth_dev *dev,
 		if (ret)
 			return ret;
 
-		cons_filter_type = RTE_ETH_FILTER_HASH;
-		return i40e_hash_parse(dev, pattern, actions + i,
-				       &cons_filter.rss_conf, error);
+		filter_ctx->type = RTE_ETH_FILTER_HASH;
+		return i40e_hash_parse(dev, pattern, actions + i, &filter_ctx->rss_conf, error);
 	}
 
 	i = 0;
@@ -3878,8 +3868,7 @@ i40e_flow_validate(struct rte_eth_dev *dev,
 		}
 
 		if (parse_filter)
-			ret = parse_filter(dev, attr, items, actions,
-					   error, &cons_filter);
+			ret = parse_filter(dev, attr, items, actions, error, filter_ctx);
 
 		flag = true;
 	} while ((ret < 0) && (i < RTE_DIM(i40e_supported_patterns)));
@@ -3890,6 +3879,19 @@ i40e_flow_validate(struct rte_eth_dev *dev,
 	return ret;
 }
 
+static int
+i40e_flow_validate(struct rte_eth_dev *dev,
+		   const struct rte_flow_attr *attr,
+		   const struct rte_flow_item pattern[],
+		   const struct rte_flow_action actions[],
+		   struct rte_flow_error *error)
+{
+	/* creates dummy context */
+	struct i40e_filter_ctx filter_ctx = {0};
+
+	return i40e_flow_check(dev, attr, pattern, actions, &filter_ctx, error);
+}
+
 static struct rte_flow *
 i40e_flow_create(struct rte_eth_dev *dev,
 		 const struct rte_flow_attr *attr,
@@ -3898,15 +3900,16 @@ i40e_flow_create(struct rte_eth_dev *dev,
 		 struct rte_flow_error *error)
 {
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct i40e_filter_ctx filter_ctx = {0};
 	struct rte_flow *flow = NULL;
 	struct i40e_fdir_info *fdir_info = &pf->fdir;
 	int ret;
 
-	ret = i40e_flow_validate(dev, attr, pattern, actions, error);
+	ret = i40e_flow_check(dev, attr, pattern, actions, &filter_ctx, error);
 	if (ret < 0)
 		return NULL;
 
-	if (cons_filter_type == RTE_ETH_FILTER_FDIR) {
+	if (filter_ctx.type == RTE_ETH_FILTER_FDIR) {
 		/* if this is the first time we're creating an fdir flow */
 		if (pf->fdir.fdir_vsi == NULL) {
 			ret = i40e_fdir_setup(pf);
@@ -3947,18 +3950,16 @@ i40e_flow_create(struct rte_eth_dev *dev,
 		}
 	}
 
-	switch (cons_filter_type) {
+	switch (filter_ctx.type) {
 	case RTE_ETH_FILTER_ETHERTYPE:
-		ret = i40e_ethertype_filter_set(pf,
-					&cons_filter.ethertype_filter, 1);
+		ret = i40e_ethertype_filter_set(pf, &filter_ctx.ethertype_filter, 1);
 		if (ret)
 			goto free_flow;
 		flow->rule = TAILQ_LAST(&pf->ethertype.ethertype_list,
 					i40e_ethertype_filter_list);
 		break;
 	case RTE_ETH_FILTER_FDIR:
-		ret = i40e_flow_add_del_fdir_filter(dev,
-			       &cons_filter.fdir_filter, 1);
+		ret = i40e_flow_add_del_fdir_filter(dev, &filter_ctx.fdir_filter, 1);
 		if (ret)
 			goto free_flow;
 		flow->rule = TAILQ_LAST(&pf->fdir.fdir_list,
@@ -3966,14 +3967,14 @@ i40e_flow_create(struct rte_eth_dev *dev,
 		break;
 	case RTE_ETH_FILTER_TUNNEL:
 		ret = i40e_dev_consistent_tunnel_filter_set(pf,
-			    &cons_filter.consistent_tunnel_filter, 1);
+				&filter_ctx.consistent_tunnel_filter, 1);
 		if (ret)
 			goto free_flow;
 		flow->rule = TAILQ_LAST(&pf->tunnel.tunnel_list,
 					i40e_tunnel_filter_list);
 		break;
 	case RTE_ETH_FILTER_HASH:
-		ret = i40e_hash_filter_create(pf, &cons_filter.rss_conf);
+		ret = i40e_hash_filter_create(pf, &filter_ctx.rss_conf);
 		if (ret)
 			goto free_flow;
 		flow->rule = TAILQ_LAST(&pf->rss_config_list,
@@ -3983,7 +3984,7 @@ i40e_flow_create(struct rte_eth_dev *dev,
 		goto free_flow;
 	}
 
-	flow->filter_type = cons_filter_type;
+	flow->filter_type = filter_ctx.type;
 	TAILQ_INSERT_TAIL(&pf->flow_list, flow, node);
 	return flow;
 
@@ -3992,7 +3993,7 @@ i40e_flow_create(struct rte_eth_dev *dev,
 			   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
 			   "Failed to create flow.");
 
-	if (cons_filter_type != RTE_ETH_FILTER_FDIR)
+	if (filter_ctx.type != RTE_ETH_FILTER_FDIR)
 		rte_free(flow);
 	else
 		i40e_fdir_entry_pool_put(fdir_info, flow);
-- 
2.47.3

