Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED142CCFA13
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 11:14:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E7E64028C;
	Thu, 30 Apr 2026 13:14:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 3B77A40661
 for <dev@dpdk.org>; Thu, 30 Apr 2026 13:14:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777547692; x=1809083692;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=aanBnTlCx5/D7Anjm//Eb5xJePW6ogz+QRK0By0qdmY=;
 b=hLmJ7WohKXJpksqnGUBM9knbMajeIy+HN9HIng0WBJxINrvuLGD+N/RD
 1pWoiCcEigeg0ijcnLWPJ776arYOF2NCO/U/EIjpbyAS+C5pnwpru5Ezo
 61bdh7UZZMa9GFOwNUgmLGwHKECJY2P7pI9CxlfjFwYM3r4f4ihcqgFV0
 1+Kd2HCnFkfQ5rTuuPw3u4Ih3Im4ki+C3WTS/SAWm6fFu/ON5fczwPIj0
 Y+Oc5e0snzkTZRpBmyppCjArk4YfQkT8r6AzYcdrX4q6jG3BLfR8bJr5F
 ybw5BNkQABWeLpgJ3hPVEO2PPQbqHo93WMy1Xa9p5ecQjpcxVzYxbdg10 A==;
X-CSE-ConnectionGUID: V/s2h4ErSuCsG70l04s9Sg==
X-CSE-MsgGUID: dm6H4fNJQhmcdF485b0crA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78482255"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="78482255"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 04:14:52 -0700
X-CSE-ConnectionGUID: 6PrbCzM9STuFAbBmJkzkLQ==
X-CSE-MsgGUID: 7w2a5p6dTZG7re04nBTJPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="234444674"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 30 Apr 2026 04:14:50 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Wei Dai <wei.dai@intel.com>, Beilei Xing <beilei.xing@intel.com>,
 Wenzhuo Lu <wenzhuo.lu@intel.com>, Wei Zhao <wei.zhao1@intel.com>
Subject: [PATCH v1 01/15] net/ixgbe: fix flows not being scoped to port
Date: Thu, 30 Apr 2026 12:14:30 +0100
Message-ID: <e364e965ce422e91dd1c400733d23219b0bcf2ad.1777547413.git.anatoly.burakov@intel.com>
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

Currently, ixgbe keeps `rte_flow`` software state in global static lists
without tracking which port created each rule. As a result, a rule
removal request can affect rules that belong to another port (for example,
a flow flush command will drop *all* flows from *all* ixgbe ports).

Fix this by moving the flow lists to adapter structure.

Fixes: 72c135a89f80 ("net/ixgbe: create consistent filter")
Cc: wei.zhao1@intel.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
Depends-on: series-38016 ("Implement flow dump")

 drivers/net/intel/ixgbe/ixgbe_ethdev.c |   4 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h |  21 ++-
 drivers/net/intel/ixgbe/ixgbe_flow.c   | 247 +++++++++++--------------
 3 files changed, 126 insertions(+), 146 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 57d929cf2c..9454cbee0a 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -1334,7 +1334,7 @@ eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 		goto err_l2_tn_filter_init;
 
 	/* initialize flow filter lists */
-	ixgbe_filterlist_init();
+	ixgbe_filterlist_init(eth_dev);
 
 	/* initialize bandwidth configuration info */
 	memset(bw_conf, 0, sizeof(struct ixgbe_bw_conf));
@@ -3137,7 +3137,7 @@ ixgbe_dev_close(struct rte_eth_dev *dev)
 	ixgbe_ntuple_filter_uninit(dev);
 
 	/* clear all the filters list */
-	ixgbe_filterlist_flush();
+	ixgbe_filterlist_flush(dev);
 
 	/* Remove all Traffic Manager configuration */
 	ixgbe_tm_conf_uninit(dev);
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 3f00896943..38d476d309 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -455,6 +455,19 @@ struct ixgbe_tm_conf {
 	bool committed;
 };
 
+struct ixgbe_filter_ele_base;
+TAILQ_HEAD(ixgbe_filter_ele_list, ixgbe_filter_ele_base);
+
+struct ixgbe_flow_lists {
+	struct ixgbe_filter_ele_list ntuple_list;
+	struct ixgbe_filter_ele_list ethertype_list;
+	struct ixgbe_filter_ele_list syn_list;
+	struct ixgbe_filter_ele_list fdir_list;
+	struct ixgbe_filter_ele_list l2_tunnel_list;
+	struct ixgbe_filter_ele_list rss_list;
+	struct ixgbe_filter_ele_list flow_list;
+};
+
 /*
  * Structure to store private data for each driver instance (for each port).
  */
@@ -476,6 +489,7 @@ struct ixgbe_adapter {
 	struct ixgbe_bypass_info    bps;
 #endif /* RTE_LIBRTE_IXGBE_BYPASS */
 	struct ixgbe_filter_info    filter;
+	struct ixgbe_flow_lists     flow_lists;
 	struct ixgbe_l2_tn_info     l2_tn;
 	struct ixgbe_bw_conf        bw_conf;
 	struct ixgbe_ipsec          ipsec;
@@ -560,6 +574,9 @@ uint16_t ixgbe_vf_representor_tx_burst(void *tx_queue, struct rte_mbuf **tx_pkts
 #define IXGBE_DEV_PRIVATE_TO_FILTER_INFO(adapter) \
 	(&((struct ixgbe_adapter *)adapter)->filter)
 
+#define IXGBE_DEV_PRIVATE_TO_FLOW_LISTS(adapter) \
+	(&((struct ixgbe_adapter *)adapter)->flow_lists)
+
 #define IXGBE_DEV_PRIVATE_TO_L2_TN_INFO(adapter) \
 	(&((struct ixgbe_adapter *)adapter)->l2_tn)
 
@@ -690,8 +707,8 @@ ixgbe_dev_l2_tunnel_filter_add(struct rte_eth_dev *dev,
 int
 ixgbe_dev_l2_tunnel_filter_del(struct rte_eth_dev *dev,
 			       struct ixgbe_l2_tunnel_conf *l2_tunnel);
-void ixgbe_filterlist_init(void);
-void ixgbe_filterlist_flush(void);
+void ixgbe_filterlist_init(struct rte_eth_dev *dev);
+void ixgbe_filterlist_flush(struct rte_eth_dev *dev);
 /*
  * Flow director function prototypes
  */
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index e40ece9755..c3abba4a90 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -24,6 +24,7 @@
 #include <rte_eal.h>
 #include <rte_alarm.h>
 #include <rte_ether.h>
+#include <rte_tailq.h>
 #include <ethdev_driver.h>
 #include <rte_malloc.h>
 #include <rte_random.h>
@@ -50,58 +51,46 @@
 #define IXGBE_MAX_N_TUPLE_PRIO 7
 #define IXGBE_MAX_FLX_SOURCE_OFF 62
 
+struct ixgbe_filter_ele_base {
+	TAILQ_ENTRY(ixgbe_filter_ele_base) entries;
+};
+
 /* ntuple filter list structure */
 struct ixgbe_ntuple_filter_ele {
-	TAILQ_ENTRY(ixgbe_ntuple_filter_ele) entries;
+	struct ixgbe_filter_ele_base base;
 	struct rte_eth_ntuple_filter filter_info;
 };
 /* ethertype filter list structure */
 struct ixgbe_ethertype_filter_ele {
-	TAILQ_ENTRY(ixgbe_ethertype_filter_ele) entries;
+	struct ixgbe_filter_ele_base base;
 	struct rte_eth_ethertype_filter filter_info;
 };
 /* syn filter list structure */
 struct ixgbe_eth_syn_filter_ele {
-	TAILQ_ENTRY(ixgbe_eth_syn_filter_ele) entries;
+	struct ixgbe_filter_ele_base base;
 	struct rte_eth_syn_filter filter_info;
 };
 /* fdir filter list structure */
 struct ixgbe_fdir_rule_ele {
-	TAILQ_ENTRY(ixgbe_fdir_rule_ele) entries;
+	struct ixgbe_filter_ele_base base;
 	struct ixgbe_fdir_rule filter_info;
 };
 /* l2_tunnel filter list structure */
 struct ixgbe_eth_l2_tunnel_conf_ele {
-	TAILQ_ENTRY(ixgbe_eth_l2_tunnel_conf_ele) entries;
+	struct ixgbe_filter_ele_base base;
 	struct ixgbe_l2_tunnel_conf filter_info;
 };
 /* rss filter list structure */
 struct ixgbe_rss_conf_ele {
-	TAILQ_ENTRY(ixgbe_rss_conf_ele) entries;
+	struct ixgbe_filter_ele_base base;
 	struct ixgbe_rte_flow_rss_conf filter_info;
 };
 /* ixgbe_flow memory list structure */
 struct ixgbe_flow_mem {
-	TAILQ_ENTRY(ixgbe_flow_mem) entries;
+	struct ixgbe_filter_ele_base base;
 	struct rte_flow *flow;
 };
 
-TAILQ_HEAD(ixgbe_ntuple_filter_list, ixgbe_ntuple_filter_ele);
-TAILQ_HEAD(ixgbe_ethertype_filter_list, ixgbe_ethertype_filter_ele);
-TAILQ_HEAD(ixgbe_syn_filter_list, ixgbe_eth_syn_filter_ele);
-TAILQ_HEAD(ixgbe_fdir_rule_filter_list, ixgbe_fdir_rule_ele);
-TAILQ_HEAD(ixgbe_l2_tunnel_filter_list, ixgbe_eth_l2_tunnel_conf_ele);
-TAILQ_HEAD(ixgbe_rss_filter_list, ixgbe_rss_conf_ele);
-TAILQ_HEAD(ixgbe_flow_mem_list, ixgbe_flow_mem);
-
-static struct ixgbe_ntuple_filter_list filter_ntuple_list;
-static struct ixgbe_ethertype_filter_list filter_ethertype_list;
-static struct ixgbe_syn_filter_list filter_syn_list;
-static struct ixgbe_fdir_rule_filter_list filter_fdir_list;
-static struct ixgbe_l2_tunnel_filter_list filter_l2_tunnel_list;
-static struct ixgbe_rss_filter_list filter_rss_list;
-static struct ixgbe_flow_mem_list ixgbe_flow_list;
-
 /**
  * Endless loop will never happen with below assumption
  * 1. there is at least one no-void item(END)
@@ -3014,76 +3003,52 @@ ixgbe_clear_rss_filter(struct rte_eth_dev *dev)
 }
 
 void
-ixgbe_filterlist_init(void)
+ixgbe_filterlist_init(struct rte_eth_dev *dev)
 {
-	TAILQ_INIT(&filter_ntuple_list);
-	TAILQ_INIT(&filter_ethertype_list);
-	TAILQ_INIT(&filter_syn_list);
-	TAILQ_INIT(&filter_fdir_list);
-	TAILQ_INIT(&filter_l2_tunnel_list);
-	TAILQ_INIT(&filter_rss_list);
-	TAILQ_INIT(&ixgbe_flow_list);
+	struct ixgbe_flow_lists *flow_lists =
+		IXGBE_DEV_PRIVATE_TO_FLOW_LISTS(dev->data->dev_private);
+
+	TAILQ_INIT(&flow_lists->ntuple_list);
+	TAILQ_INIT(&flow_lists->ethertype_list);
+	TAILQ_INIT(&flow_lists->syn_list);
+	TAILQ_INIT(&flow_lists->fdir_list);
+	TAILQ_INIT(&flow_lists->l2_tunnel_list);
+	TAILQ_INIT(&flow_lists->rss_list);
+	TAILQ_INIT(&flow_lists->flow_list);
+}
+
+static void
+ixgbe_filter_flush(struct ixgbe_filter_ele_list *list)
+{
+	struct ixgbe_filter_ele_base *ele, *tmp;
+
+	RTE_TAILQ_FOREACH_SAFE(ele, list, entries, tmp) {
+		TAILQ_REMOVE(list, ele, entries);
+		rte_free(ele);
+	}
 }
 
 void
-ixgbe_filterlist_flush(void)
+ixgbe_filterlist_flush(struct rte_eth_dev *dev)
 {
-	struct ixgbe_ntuple_filter_ele *ntuple_filter_ptr;
-	struct ixgbe_ethertype_filter_ele *ethertype_filter_ptr;
-	struct ixgbe_eth_syn_filter_ele *syn_filter_ptr;
-	struct ixgbe_eth_l2_tunnel_conf_ele *l2_tn_filter_ptr;
-	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
-	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
-	struct ixgbe_rss_conf_ele *rss_filter_ptr;
+	struct ixgbe_flow_lists *flow_lists =
+		IXGBE_DEV_PRIVATE_TO_FLOW_LISTS(dev->data->dev_private);
+	struct ixgbe_filter_ele_base *ele, *tmp;
 
-	while ((ntuple_filter_ptr = TAILQ_FIRST(&filter_ntuple_list))) {
-		TAILQ_REMOVE(&filter_ntuple_list,
-				 ntuple_filter_ptr,
-				 entries);
-		rte_free(ntuple_filter_ptr);
-	}
+	ixgbe_filter_flush(&flow_lists->ntuple_list);
+	ixgbe_filter_flush(&flow_lists->ethertype_list);
+	ixgbe_filter_flush(&flow_lists->syn_list);
+	ixgbe_filter_flush(&flow_lists->l2_tunnel_list);
+	ixgbe_filter_flush(&flow_lists->fdir_list);
+	ixgbe_filter_flush(&flow_lists->rss_list);
 
-	while ((ethertype_filter_ptr = TAILQ_FIRST(&filter_ethertype_list))) {
-		TAILQ_REMOVE(&filter_ethertype_list,
-				 ethertype_filter_ptr,
-				 entries);
-		rte_free(ethertype_filter_ptr);
-	}
+	RTE_TAILQ_FOREACH_SAFE(ele, &flow_lists->flow_list, entries, tmp) {
+		struct ixgbe_flow_mem *ixgbe_flow_mem_ptr =
+			(struct ixgbe_flow_mem *)ele;
 
-	while ((syn_filter_ptr = TAILQ_FIRST(&filter_syn_list))) {
-		TAILQ_REMOVE(&filter_syn_list,
-				 syn_filter_ptr,
-				 entries);
-		rte_free(syn_filter_ptr);
-	}
-
-	while ((l2_tn_filter_ptr = TAILQ_FIRST(&filter_l2_tunnel_list))) {
-		TAILQ_REMOVE(&filter_l2_tunnel_list,
-				 l2_tn_filter_ptr,
-				 entries);
-		rte_free(l2_tn_filter_ptr);
-	}
-
-	while ((fdir_rule_ptr = TAILQ_FIRST(&filter_fdir_list))) {
-		TAILQ_REMOVE(&filter_fdir_list,
-				 fdir_rule_ptr,
-				 entries);
-		rte_free(fdir_rule_ptr);
-	}
-
-	while ((rss_filter_ptr = TAILQ_FIRST(&filter_rss_list))) {
-		TAILQ_REMOVE(&filter_rss_list,
-				 rss_filter_ptr,
-				 entries);
-		rte_free(rss_filter_ptr);
-	}
-
-	while ((ixgbe_flow_mem_ptr = TAILQ_FIRST(&ixgbe_flow_list))) {
-		TAILQ_REMOVE(&ixgbe_flow_list,
-				 ixgbe_flow_mem_ptr,
-				 entries);
+		TAILQ_REMOVE(&flow_lists->flow_list, ele, entries);
 		rte_free(ixgbe_flow_mem_ptr->flow);
-		rte_free(ixgbe_flow_mem_ptr);
+		rte_free(ele);
 	}
 }
 
@@ -3117,6 +3082,8 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
 	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
+	struct ixgbe_flow_lists *flow_lists =
+		IXGBE_DEV_PRIVATE_TO_FLOW_LISTS(dev->data->dev_private);
 	uint8_t first_mask = FALSE;
 
 	flow = rte_zmalloc("ixgbe_rte_flow", sizeof(struct rte_flow), 0);
@@ -3132,8 +3099,8 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 		return NULL;
 	}
 	ixgbe_flow_mem_ptr->flow = flow;
-	TAILQ_INSERT_TAIL(&ixgbe_flow_list,
-				ixgbe_flow_mem_ptr, entries);
+	TAILQ_INSERT_TAIL(&flow_lists->flow_list,
+				&ixgbe_flow_mem_ptr->base, entries);
 
 	/**
 	 *  Special case for flow action type RTE_FLOW_ACTION_TYPE_SECURITY
@@ -3160,8 +3127,8 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 			rte_memcpy(&ntuple_filter_ptr->filter_info,
 				&ntuple_filter,
 				sizeof(struct rte_eth_ntuple_filter));
-			TAILQ_INSERT_TAIL(&filter_ntuple_list,
-				ntuple_filter_ptr, entries);
+			TAILQ_INSERT_TAIL(&flow_lists->ntuple_list,
+				&ntuple_filter_ptr->base, entries);
 			flow->rule = ntuple_filter_ptr;
 			flow->filter_type = RTE_ETH_FILTER_NTUPLE;
 			return flow;
@@ -3186,8 +3153,8 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 			rte_memcpy(&ethertype_filter_ptr->filter_info,
 				&ethertype_filter,
 				sizeof(struct rte_eth_ethertype_filter));
-			TAILQ_INSERT_TAIL(&filter_ethertype_list,
-				ethertype_filter_ptr, entries);
+			TAILQ_INSERT_TAIL(&flow_lists->ethertype_list,
+				&ethertype_filter_ptr->base, entries);
 			flow->rule = ethertype_filter_ptr;
 			flow->filter_type = RTE_ETH_FILTER_ETHERTYPE;
 			return flow;
@@ -3210,8 +3177,8 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 			rte_memcpy(&syn_filter_ptr->filter_info,
 				&syn_filter,
 				sizeof(struct rte_eth_syn_filter));
-			TAILQ_INSERT_TAIL(&filter_syn_list,
-				syn_filter_ptr,
+			TAILQ_INSERT_TAIL(&flow_lists->syn_list,
+				&syn_filter_ptr->base,
 				entries);
 			flow->rule = syn_filter_ptr;
 			flow->filter_type = RTE_ETH_FILTER_SYN;
@@ -3273,8 +3240,8 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 				rte_memcpy(&fdir_rule_ptr->filter_info,
 					&fdir_rule,
 					sizeof(struct ixgbe_fdir_rule));
-				TAILQ_INSERT_TAIL(&filter_fdir_list,
-					fdir_rule_ptr, entries);
+				TAILQ_INSERT_TAIL(&flow_lists->fdir_list,
+					&fdir_rule_ptr->base, entries);
 				flow->rule = fdir_rule_ptr;
 				flow->filter_type = RTE_ETH_FILTER_FDIR;
 
@@ -3310,8 +3277,8 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 			rte_memcpy(&l2_tn_filter_ptr->filter_info,
 				&l2_tn_filter,
 				sizeof(struct ixgbe_l2_tunnel_conf));
-			TAILQ_INSERT_TAIL(&filter_l2_tunnel_list,
-				l2_tn_filter_ptr, entries);
+			TAILQ_INSERT_TAIL(&flow_lists->l2_tunnel_list,
+				&l2_tn_filter_ptr->base, entries);
 			flow->rule = l2_tn_filter_ptr;
 			flow->filter_type = RTE_ETH_FILTER_L2_TUNNEL;
 			return flow;
@@ -3332,8 +3299,8 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 			}
 			ixgbe_rss_conf_init(&rss_filter_ptr->filter_info,
 					    &rss_conf.conf);
-			TAILQ_INSERT_TAIL(&filter_rss_list,
-				rss_filter_ptr, entries);
+			TAILQ_INSERT_TAIL(&flow_lists->rss_list,
+				&rss_filter_ptr->base, entries);
 			flow->rule = rss_filter_ptr;
 			flow->filter_type = RTE_ETH_FILTER_HASH;
 			return flow;
@@ -3341,8 +3308,8 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	}
 
 out:
-	TAILQ_REMOVE(&ixgbe_flow_list,
-		ixgbe_flow_mem_ptr, entries);
+	TAILQ_REMOVE(&flow_lists->flow_list,
+		&ixgbe_flow_mem_ptr->base, entries);
 	rte_flow_error_set(error, -ret,
 			   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
 			   "Failed to create flow.");
@@ -3434,11 +3401,27 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	struct ixgbe_eth_syn_filter_ele *syn_filter_ptr;
 	struct ixgbe_eth_l2_tunnel_conf_ele *l2_tn_filter_ptr;
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
-	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
+	struct ixgbe_filter_ele_base *flow_mem_base;
 	struct ixgbe_hw_fdir_info *fdir_info =
 		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
+	struct ixgbe_flow_lists *flow_lists =
+		IXGBE_DEV_PRIVATE_TO_FLOW_LISTS(dev->data->dev_private);
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
 
+	/* Validate ownership before touching HW/SW state. */
+	TAILQ_FOREACH(flow_mem_base, &flow_lists->flow_list, entries) {
+		struct ixgbe_flow_mem *ixgbe_flow_mem_ptr =
+			(struct ixgbe_flow_mem *)flow_mem_base;
+
+		if (ixgbe_flow_mem_ptr->flow == pmd_flow)
+			break;
+	}
+	if (flow_mem_base == NULL) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Flow not found for this port");
+	}
+
 	/* Special case for SECURITY flows */
 	if (flow->is_security) {
 		ret = 0;
@@ -3454,8 +3437,8 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 			sizeof(struct rte_eth_ntuple_filter));
 		ret = ixgbe_add_del_ntuple_filter(dev, &ntuple_filter, FALSE);
 		if (!ret) {
-			TAILQ_REMOVE(&filter_ntuple_list,
-			ntuple_filter_ptr, entries);
+			TAILQ_REMOVE(&flow_lists->ntuple_list,
+				&ntuple_filter_ptr->base, entries);
 			rte_free(ntuple_filter_ptr);
 		}
 		break;
@@ -3468,8 +3451,8 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		ret = ixgbe_add_del_ethertype_filter(dev,
 				&ethertype_filter, FALSE);
 		if (!ret) {
-			TAILQ_REMOVE(&filter_ethertype_list,
-				ethertype_filter_ptr, entries);
+			TAILQ_REMOVE(&flow_lists->ethertype_list,
+				&ethertype_filter_ptr->base, entries);
 			rte_free(ethertype_filter_ptr);
 		}
 		break;
@@ -3481,8 +3464,8 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 			sizeof(struct rte_eth_syn_filter));
 		ret = ixgbe_syn_filter_set(dev, &syn_filter, FALSE);
 		if (!ret) {
-			TAILQ_REMOVE(&filter_syn_list,
-				syn_filter_ptr, entries);
+			TAILQ_REMOVE(&flow_lists->syn_list,
+				&syn_filter_ptr->base, entries);
 			rte_free(syn_filter_ptr);
 		}
 		break;
@@ -3493,10 +3476,10 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 			sizeof(struct ixgbe_fdir_rule));
 		ret = ixgbe_fdir_filter_program(dev, &fdir_rule, TRUE, FALSE);
 		if (!ret) {
-			TAILQ_REMOVE(&filter_fdir_list,
-				fdir_rule_ptr, entries);
+			TAILQ_REMOVE(&flow_lists->fdir_list,
+				&fdir_rule_ptr->base, entries);
 			rte_free(fdir_rule_ptr);
-			if (TAILQ_EMPTY(&filter_fdir_list))
+			if (TAILQ_EMPTY(&flow_lists->fdir_list))
 				fdir_info->mask_added = false;
 		}
 		break;
@@ -3507,8 +3490,8 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 			sizeof(struct ixgbe_l2_tunnel_conf));
 		ret = ixgbe_dev_l2_tunnel_filter_del(dev, &l2_tn_filter);
 		if (!ret) {
-			TAILQ_REMOVE(&filter_l2_tunnel_list,
-				l2_tn_filter_ptr, entries);
+			TAILQ_REMOVE(&flow_lists->l2_tunnel_list,
+				&l2_tn_filter_ptr->base, entries);
 			rte_free(l2_tn_filter_ptr);
 		}
 		break;
@@ -3518,8 +3501,8 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		ret = ixgbe_config_rss_filter(dev,
 					&rss_filter_ptr->filter_info, FALSE);
 		if (!ret) {
-			TAILQ_REMOVE(&filter_rss_list,
-				rss_filter_ptr, entries);
+			TAILQ_REMOVE(&flow_lists->rss_list,
+				&rss_filter_ptr->base, entries);
 			rte_free(rss_filter_ptr);
 		}
 		break;
@@ -3538,14 +3521,8 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	}
 
 free:
-	TAILQ_FOREACH(ixgbe_flow_mem_ptr, &ixgbe_flow_list, entries) {
-		if (ixgbe_flow_mem_ptr->flow == pmd_flow) {
-			TAILQ_REMOVE(&ixgbe_flow_list,
-				ixgbe_flow_mem_ptr, entries);
-			rte_free(ixgbe_flow_mem_ptr);
-			break;
-		}
-	}
+	TAILQ_REMOVE(&flow_lists->flow_list, flow_mem_base, entries);
+	rte_free(flow_mem_base);
 	rte_free(flow);
 
 	return ret;
@@ -3578,7 +3555,7 @@ ixgbe_flow_flush(struct rte_eth_dev *dev,
 
 	ixgbe_clear_rss_filter(dev);
 
-	ixgbe_filterlist_flush();
+	ixgbe_filterlist_flush(dev);
 
 	return 0;
 }
@@ -3639,22 +3616,7 @@ ixgbe_flow_rule_data(const struct rte_flow *flow)
 	if (flow->is_security || flow->rule == NULL)
 		return NULL;
 
-	switch (flow->filter_type) {
-	case RTE_ETH_FILTER_NTUPLE:
-		return RTE_PTR_ADD(flow->rule, sizeof(TAILQ_ENTRY(ixgbe_ntuple_filter_ele)));
-	case RTE_ETH_FILTER_ETHERTYPE:
-		return RTE_PTR_ADD(flow->rule, sizeof(TAILQ_ENTRY(ixgbe_ethertype_filter_ele)));
-	case RTE_ETH_FILTER_SYN:
-		return RTE_PTR_ADD(flow->rule, sizeof(TAILQ_ENTRY(ixgbe_eth_syn_filter_ele)));
-	case RTE_ETH_FILTER_FDIR:
-		return RTE_PTR_ADD(flow->rule, sizeof(TAILQ_ENTRY(ixgbe_fdir_rule_ele)));
-	case RTE_ETH_FILTER_L2_TUNNEL:
-		return RTE_PTR_ADD(flow->rule, sizeof(TAILQ_ENTRY(ixgbe_eth_l2_tunnel_conf_ele)));
-	case RTE_ETH_FILTER_HASH:
-		return RTE_PTR_ADD(flow->rule, sizeof(TAILQ_ENTRY(ixgbe_rss_conf_ele)));
-	default:
-		return NULL;
-	}
+	return RTE_PTR_ADD(flow->rule, sizeof(struct ixgbe_filter_ele_base));
 }
 
 static void
@@ -3684,15 +3646,16 @@ ixgbe_flow_dump_blob(FILE *file, const char *engine,
 }
 
 static int
-ixgbe_flow_dev_dump(struct rte_eth_dev *dev __rte_unused,
+ixgbe_flow_dev_dump(struct rte_eth_dev *dev,
 		    struct rte_flow *flow,
 		    FILE *file,
 		    struct rte_flow_error *error)
 {
-	struct ixgbe_flow_mem *flow_mem_base;
+	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	struct ixgbe_filter_ele_base *flow_mem_base;
 	bool found = false;
 
-	TAILQ_FOREACH(flow_mem_base, &ixgbe_flow_list, entries) {
+	TAILQ_FOREACH(flow_mem_base, &ad->flow_lists.flow_list, entries) {
 		struct ixgbe_flow_mem *ixgbe_flow_mem_ptr =
 			(struct ixgbe_flow_mem *)flow_mem_base;
 		struct rte_flow *p_flow = ixgbe_flow_mem_ptr->flow;
-- 
2.47.3

