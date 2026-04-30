Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B623BFF8875
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 11:15:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37C3440A84;
	Thu, 30 Apr 2026 13:15:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id B352740A6C
 for <dev@dpdk.org>; Thu, 30 Apr 2026 13:15:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777547705; x=1809083705;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=C6ZXOoF8d7McXTEc+jMUySqeApWobUtFEOrK6S2yvvI=;
 b=MWL4PolwUPidVLnh13aGpUwZ0ex7/HpLlc8DBu1OK2nf+j+dQDA/vGAS
 YDwvgD/zlErpVdOuonNeu7s5vbd/TD/foqeYrSvPj/+7GJOeDO8hzjtAE
 /CU8cHNWmv4YDJNimjOdbg54tAzeQPEYuIG6chWphdwVG8a61pQe+1Jww
 7ZQR/BOCJXqImhSLDDszPFOoVenxw19TdIbvcStQtQzGVBTKAoxI2STot
 dLdshzWO+xD7KS86Lb4WdgkPcekf4RPgopwcOyDGaknY/54gct6U7CRj3
 CyRRAs6laIEXpFTW752zZ6cXQ7kewzM/2wYglBBlu9GNynLIiy93Te201 g==;
X-CSE-ConnectionGUID: kZ7FVU1ITa2sB0d2g6yjew==
X-CSE-MsgGUID: WEQLFgNcSTiAJ67Ga3hSWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78482280"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="78482280"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 04:15:04 -0700
X-CSE-ConnectionGUID: vmKxoqsXR/qm+uHbmD2l5g==
X-CSE-MsgGUID: qU7Nq2QvQ+q5ZEMnTAidkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="234444778"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 30 Apr 2026 04:15:04 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 09/15] net/ixgbe: remove redundant flow tracking lists
Date: Thu, 30 Apr 2026 12:14:38 +0100
Message-ID: <5b5c70e64ba0127b10252de16b7fe0990de50cb3.1777547413.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1777547413.git.anatoly.burakov@intel.com>
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

Keep flow rule ownership in `ixgbe_flow_list` and drop duplicate per-type
tracking lists in the flow path.

This removes redundant TAILQ bookkeeping for ntuple, ethertype, syn, FDIR,
l2 tunnel, and RSS rules while preserving behavior.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.h | 15 +---
 drivers/net/intel/ixgbe/ixgbe_flow.c   | 96 ++++++--------------------
 2 files changed, 21 insertions(+), 90 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 6147cd6bdf..f49a179082 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -460,16 +460,6 @@ struct ixgbe_tm_conf {
 struct ixgbe_filter_ele_base;
 TAILQ_HEAD(ixgbe_filter_ele_list, ixgbe_filter_ele_base);
 
-struct ixgbe_flow_lists {
-	struct ixgbe_filter_ele_list ntuple_list;
-	struct ixgbe_filter_ele_list ethertype_list;
-	struct ixgbe_filter_ele_list syn_list;
-	struct ixgbe_filter_ele_list fdir_list;
-	struct ixgbe_filter_ele_list l2_tunnel_list;
-	struct ixgbe_filter_ele_list rss_list;
-	struct ixgbe_filter_ele_list flow_list;
-};
-
 /*
  * Structure to store private data for each driver instance (for each port).
  */
@@ -491,7 +481,7 @@ struct ixgbe_adapter {
 	struct ixgbe_bypass_info    bps;
 #endif /* RTE_LIBRTE_IXGBE_BYPASS */
 	struct ixgbe_filter_info    filter;
-	struct ixgbe_flow_lists     flow_lists;
+	struct ixgbe_filter_ele_list flow_list;
 	struct ixgbe_l2_tn_info     l2_tn;
 	struct ixgbe_bw_conf        bw_conf;
 	struct ixgbe_ipsec          ipsec;
@@ -577,9 +567,6 @@ uint16_t ixgbe_vf_representor_tx_burst(void *tx_queue, struct rte_mbuf **tx_pkts
 #define IXGBE_DEV_PRIVATE_TO_FILTER_INFO(adapter) \
 	(&((struct ixgbe_adapter *)adapter)->filter)
 
-#define IXGBE_DEV_PRIVATE_TO_FLOW_LISTS(adapter) \
-	(&((struct ixgbe_adapter *)adapter)->flow_lists)
-
 #define IXGBE_DEV_PRIVATE_TO_L2_TN_INFO(adapter) \
 	(&((struct ixgbe_adapter *)adapter)->l2_tn)
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index b68934e911..128efd3f86 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -3002,49 +3002,25 @@ ixgbe_clear_rss_filter(struct rte_eth_dev *dev)
 void
 ixgbe_filterlist_init(struct rte_eth_dev *dev)
 {
-	struct ixgbe_flow_lists *flow_lists =
-		IXGBE_DEV_PRIVATE_TO_FLOW_LISTS(dev->data->dev_private);
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 
-	TAILQ_INIT(&flow_lists->ntuple_list);
-	TAILQ_INIT(&flow_lists->ethertype_list);
-	TAILQ_INIT(&flow_lists->syn_list);
-	TAILQ_INIT(&flow_lists->fdir_list);
-	TAILQ_INIT(&flow_lists->l2_tunnel_list);
-	TAILQ_INIT(&flow_lists->rss_list);
-	TAILQ_INIT(&flow_lists->flow_list);
-}
-
-static void
-ixgbe_filter_flush(struct ixgbe_filter_ele_list *list)
-{
-	struct ixgbe_filter_ele_base *ele, *tmp;
-
-	RTE_TAILQ_FOREACH_SAFE(ele, list, entries, tmp) {
-		TAILQ_REMOVE(list, ele, entries);
-		rte_free(ele);
-	}
+	TAILQ_INIT(&adapter->flow_list);
 }
 
 void
 ixgbe_filterlist_flush(struct rte_eth_dev *dev)
 {
-	struct ixgbe_flow_lists *flow_lists =
-		IXGBE_DEV_PRIVATE_TO_FLOW_LISTS(dev->data->dev_private);
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct ixgbe_filter_ele_base *ele, *tmp;
 
-	ixgbe_filter_flush(&flow_lists->ntuple_list);
-	ixgbe_filter_flush(&flow_lists->ethertype_list);
-	ixgbe_filter_flush(&flow_lists->syn_list);
-	ixgbe_filter_flush(&flow_lists->l2_tunnel_list);
-	ixgbe_filter_flush(&flow_lists->fdir_list);
-	ixgbe_filter_flush(&flow_lists->rss_list);
-
-	RTE_TAILQ_FOREACH_SAFE(ele, &flow_lists->flow_list, entries, tmp) {
+	RTE_TAILQ_FOREACH_SAFE(ele, &adapter->flow_list, entries, tmp) {
 		struct ixgbe_flow_mem *ixgbe_flow_mem_ptr =
 			(struct ixgbe_flow_mem *)ele;
+		struct rte_flow *flow = ixgbe_flow_mem_ptr->flow;
 
-		TAILQ_REMOVE(&flow_lists->flow_list, ele, entries);
-		rte_free(ixgbe_flow_mem_ptr->flow);
+		TAILQ_REMOVE(&adapter->flow_list, ele, entries);
+		rte_free(flow->rule);
+		rte_free(flow);
 		rte_free(ele);
 	}
 }
@@ -3079,8 +3055,7 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
 	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
-	struct ixgbe_flow_lists *flow_lists =
-		IXGBE_DEV_PRIVATE_TO_FLOW_LISTS(dev->data->dev_private);
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	uint8_t first_mask = FALSE;
 
 	flow = rte_zmalloc("ixgbe_rte_flow", sizeof(struct rte_flow), 0);
@@ -3096,7 +3071,7 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 		return NULL;
 	}
 	ixgbe_flow_mem_ptr->flow = flow;
-	TAILQ_INSERT_TAIL(&flow_lists->flow_list,
+	TAILQ_INSERT_TAIL(&adapter->flow_list,
 				&ixgbe_flow_mem_ptr->base, entries);
 
 	/**
@@ -3124,8 +3099,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 			rte_memcpy(&ntuple_filter_ptr->filter_info,
 				&ntuple_filter,
 				sizeof(struct rte_eth_ntuple_filter));
-			TAILQ_INSERT_TAIL(&flow_lists->ntuple_list,
-				&ntuple_filter_ptr->base, entries);
 			flow->rule = ntuple_filter_ptr;
 			flow->filter_type = RTE_ETH_FILTER_NTUPLE;
 			return flow;
@@ -3150,8 +3123,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 			rte_memcpy(&ethertype_filter_ptr->filter_info,
 				&ethertype_filter,
 				sizeof(struct rte_eth_ethertype_filter));
-			TAILQ_INSERT_TAIL(&flow_lists->ethertype_list,
-				&ethertype_filter_ptr->base, entries);
 			flow->rule = ethertype_filter_ptr;
 			flow->filter_type = RTE_ETH_FILTER_ETHERTYPE;
 			return flow;
@@ -3174,9 +3145,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 			rte_memcpy(&syn_filter_ptr->filter_info,
 				&syn_filter,
 				sizeof(struct rte_eth_syn_filter));
-			TAILQ_INSERT_TAIL(&flow_lists->syn_list,
-				&syn_filter_ptr->base,
-				entries);
 			flow->rule = syn_filter_ptr;
 			flow->filter_type = RTE_ETH_FILTER_SYN;
 			return flow;
@@ -3237,8 +3205,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 				rte_memcpy(&fdir_rule_ptr->filter_info,
 					&fdir_rule,
 					sizeof(struct ixgbe_fdir_rule));
-				TAILQ_INSERT_TAIL(&flow_lists->fdir_list,
-					&fdir_rule_ptr->base, entries);
 				flow->rule = fdir_rule_ptr;
 				flow->filter_type = RTE_ETH_FILTER_FDIR;
 				fdir_info->n_flows++;
@@ -3275,8 +3241,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 			rte_memcpy(&l2_tn_filter_ptr->filter_info,
 				&l2_tn_filter,
 				sizeof(struct ixgbe_l2_tunnel_conf));
-			TAILQ_INSERT_TAIL(&flow_lists->l2_tunnel_list,
-				&l2_tn_filter_ptr->base, entries);
 			flow->rule = l2_tn_filter_ptr;
 			flow->filter_type = RTE_ETH_FILTER_L2_TUNNEL;
 			return flow;
@@ -3297,8 +3261,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 			}
 			ixgbe_rss_conf_init(&rss_filter_ptr->filter_info,
 					    &rss_conf.conf);
-			TAILQ_INSERT_TAIL(&flow_lists->rss_list,
-				&rss_filter_ptr->base, entries);
 			flow->rule = rss_filter_ptr;
 			flow->filter_type = RTE_ETH_FILTER_HASH;
 			return flow;
@@ -3306,7 +3268,7 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	}
 
 out:
-	TAILQ_REMOVE(&flow_lists->flow_list,
+	TAILQ_REMOVE(&adapter->flow_list,
 		&ixgbe_flow_mem_ptr->base, entries);
 	rte_flow_error_set(error, -ret,
 			   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
@@ -3400,14 +3362,13 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	struct ixgbe_eth_l2_tunnel_conf_ele *l2_tn_filter_ptr;
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_filter_ele_base *flow_mem_base;
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct ixgbe_hw_fdir_info *fdir_info =
 		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
-	struct ixgbe_flow_lists *flow_lists =
-		IXGBE_DEV_PRIVATE_TO_FLOW_LISTS(dev->data->dev_private);
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
 
 	/* Validate ownership before touching HW/SW state. */
-	TAILQ_FOREACH(flow_mem_base, &flow_lists->flow_list, entries) {
+	TAILQ_FOREACH(flow_mem_base, &adapter->flow_list, entries) {
 		struct ixgbe_flow_mem *ixgbe_flow_mem_ptr =
 			(struct ixgbe_flow_mem *)flow_mem_base;
 
@@ -3434,11 +3395,8 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 			&ntuple_filter_ptr->filter_info,
 			sizeof(struct rte_eth_ntuple_filter));
 		ret = ixgbe_add_del_ntuple_filter(dev, &ntuple_filter, FALSE);
-		if (!ret) {
-			TAILQ_REMOVE(&flow_lists->ntuple_list,
-				&ntuple_filter_ptr->base, entries);
+		if (!ret)
 			rte_free(ntuple_filter_ptr);
-		}
 		break;
 	case RTE_ETH_FILTER_ETHERTYPE:
 		ethertype_filter_ptr = (struct ixgbe_ethertype_filter_ele *)
@@ -3448,11 +3406,8 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 			sizeof(struct rte_eth_ethertype_filter));
 		ret = ixgbe_add_del_ethertype_filter(dev,
 				&ethertype_filter, FALSE);
-		if (!ret) {
-			TAILQ_REMOVE(&flow_lists->ethertype_list,
-				&ethertype_filter_ptr->base, entries);
+		if (!ret)
 			rte_free(ethertype_filter_ptr);
-		}
 		break;
 	case RTE_ETH_FILTER_SYN:
 		syn_filter_ptr = (struct ixgbe_eth_syn_filter_ele *)
@@ -3461,11 +3416,8 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 			&syn_filter_ptr->filter_info,
 			sizeof(struct rte_eth_syn_filter));
 		ret = ixgbe_syn_filter_set(dev, &syn_filter, FALSE);
-		if (!ret) {
-			TAILQ_REMOVE(&flow_lists->syn_list,
-				&syn_filter_ptr->base, entries);
+		if (!ret)
 			rte_free(syn_filter_ptr);
-		}
 		break;
 	case RTE_ETH_FILTER_FDIR:
 		fdir_rule_ptr = (struct ixgbe_fdir_rule_ele *)pmd_flow->rule;
@@ -3475,8 +3427,6 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		ret = ixgbe_fdir_filter_program(dev, &fdir_rule, TRUE, FALSE);
 		if (!ret) {
 			struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
-			TAILQ_REMOVE(&flow_lists->fdir_list,
-				&fdir_rule_ptr->base, entries);
 			rte_free(fdir_rule_ptr);
 			if (fdir_info->n_flows > 0 && --(fdir_info->n_flows) == 0) {
 				fdir_info->mask_added = false;
@@ -3492,22 +3442,16 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		rte_memcpy(&l2_tn_filter, &l2_tn_filter_ptr->filter_info,
 			sizeof(struct ixgbe_l2_tunnel_conf));
 		ret = ixgbe_dev_l2_tunnel_filter_del(dev, &l2_tn_filter);
-		if (!ret) {
-			TAILQ_REMOVE(&flow_lists->l2_tunnel_list,
-				&l2_tn_filter_ptr->base, entries);
+		if (!ret)
 			rte_free(l2_tn_filter_ptr);
-		}
 		break;
 	case RTE_ETH_FILTER_HASH:
 		rss_filter_ptr = (struct ixgbe_rss_conf_ele *)
 				pmd_flow->rule;
 		ret = ixgbe_config_rss_filter(dev,
 					&rss_filter_ptr->filter_info, FALSE);
-		if (!ret) {
-			TAILQ_REMOVE(&flow_lists->rss_list,
-				&rss_filter_ptr->base, entries);
+		if (!ret)
 			rte_free(rss_filter_ptr);
-		}
 		break;
 	default:
 		PMD_DRV_LOG(WARNING, "Filter type (%d) not supported",
@@ -3524,7 +3468,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	}
 
 free:
-	TAILQ_REMOVE(&flow_lists->flow_list, flow_mem_base, entries);
+	TAILQ_REMOVE(&adapter->flow_list, flow_mem_base, entries);
 	rte_free(flow_mem_base);
 	rte_free(flow);
 
@@ -3658,7 +3602,7 @@ ixgbe_flow_dev_dump(struct rte_eth_dev *dev,
 	struct ixgbe_filter_ele_base *flow_mem_base;
 	bool found = false;
 
-	TAILQ_FOREACH(flow_mem_base, &ad->flow_lists.flow_list, entries) {
+	TAILQ_FOREACH(flow_mem_base, &ad->flow_list, entries) {
 		struct ixgbe_flow_mem *ixgbe_flow_mem_ptr =
 			(struct ixgbe_flow_mem *)flow_mem_base;
 		struct rte_flow *p_flow = ixgbe_flow_mem_ptr->flow;
-- 
2.47.3

