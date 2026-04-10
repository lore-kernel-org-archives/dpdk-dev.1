Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A211DF44866
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 13:14:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8872E402D8;
	Fri, 10 Apr 2026 15:13:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id B6FE74064E
 for <dev@dpdk.org>; Fri, 10 Apr 2026 15:13:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775826817; x=1807362817;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=wAHQrdRAcODIwRnKCtzoC4nwlo5tf1IwU/TT2av3WRs=;
 b=D/wdl459QrqYOouQsTXD/Q1ZIYHFSpWOnmayPwsIlJGT400PKfw84yj0
 RZhJvDqGGD4ne1WgQ2caaVT/ll3WQp8pFtmNG3E8YoWWCEBpMBpUOo3hn
 eO/U/Lym/bOA3Dgp7AuCoXhCl0aH5/nXpXFcW3+hZf5NEwcsamM5dmlWW
 e40/2c4JQTkDWIIFyIr1NXb1mZk38iTWH8sMm/iKS77rKguVs0kurfWWY
 gn1eMhs0T40ACPDbmHrwHOfpUxcNZhWOXEjCJdIk9XqI5kOggzqCHNJVd
 LHdAynoSXpLTSry3HZ6dYW8pdIoT2GfpPMpZQgBTzywN4AVG+XpWoIZ7I Q==;
X-CSE-ConnectionGUID: hkzBcYruTaSfY1onZKS9YQ==
X-CSE-MsgGUID: dINR3m3yQqmFiSCiSgyu8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76736317"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="76736317"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 06:13:36 -0700
X-CSE-ConnectionGUID: T2a3FOZNSZiSeM15lQLRhA==
X-CSE-MsgGUID: WKG/HMUgTEycWsKyfNqAzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="234084627"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 10 Apr 2026 06:13:35 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 04/29] net/ixgbe: use adapter in flow-related calls
Date: Fri, 10 Apr 2026 14:12:58 +0100
Message-ID: <ee372b81daa4cea52c499241bbdc1fb09affb3a3.1775826526.git.anatoly.burakov@intel.com>
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

Currently, a lot of rte_flow-related code paths depend on using the `dev`
pointer. This has been okay up until now, because all the infrastructure
surrounding rte_flow has been ad-hoc and did not have any persistent driver
identification mechanism that works across multiple drivers, so any API
call was tied to immediate rte_eth_dev API invocation.

However, with coming shared infrastructure, we can no longer rely on things
that are process-local (such as `dev` pointer), and because most calls can
be implemented using `adapter` anyway, we'll just switch the flow-related
internal calls to use `adapter` instead of `dev`.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 93 ++++++++++++++------------
 drivers/net/intel/ixgbe/ixgbe_ethdev.h | 23 ++++---
 drivers/net/intel/ixgbe/ixgbe_fdir.c   | 90 +++++++++++++------------
 drivers/net/intel/ixgbe/ixgbe_flow.c   | 43 +++++++-----
 drivers/net/intel/ixgbe/ixgbe_rxtx.c   | 10 +--
 5 files changed, 143 insertions(+), 116 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 076cc632bf..30718a487f 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -302,9 +302,9 @@ static int ixgbevf_add_mac_addr(struct rte_eth_dev *dev,
 static void ixgbevf_remove_mac_addr(struct rte_eth_dev *dev, uint32_t index);
 static int ixgbevf_set_default_mac_addr(struct rte_eth_dev *dev,
 					     struct rte_ether_addr *mac_addr);
-static int ixgbe_add_5tuple_filter(struct rte_eth_dev *dev,
+static int ixgbe_add_5tuple_filter(struct ixgbe_adapter *adapter,
 			struct ixgbe_5tuple_filter *filter);
-static void ixgbe_remove_5tuple_filter(struct rte_eth_dev *dev,
+static void ixgbe_remove_5tuple_filter(struct ixgbe_adapter *adapter,
 			struct ixgbe_5tuple_filter *filter);
 static int ixgbe_dev_flow_ops_get(struct rte_eth_dev *dev,
 				  const struct rte_flow_ops **ops);
@@ -2611,8 +2611,9 @@ ixgbe_flow_ctrl_enable(struct rte_eth_dev *dev, struct ixgbe_hw *hw)
 static int
 ixgbe_dev_start(struct rte_eth_dev *dev)
 {
-	struct ixgbe_hw *hw =
-		IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct ixgbe_adapter *adapter =
+		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
 	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	struct ixgbe_vf_info *vfinfo =
 		*IXGBE_DEV_PRIVATE_TO_P_VFDATA(dev->data->dev_private);
@@ -2719,7 +2720,7 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
 	ixgbe_configure_dcb(dev);
 
 	if (fdir_conf->mode != RTE_FDIR_MODE_NONE) {
-		err = ixgbe_fdir_configure(dev);
+		err = ixgbe_fdir_configure(adapter);
 		if (err)
 			goto error;
 	}
@@ -6445,13 +6446,13 @@ ixgbevf_set_default_mac_addr(struct rte_eth_dev *dev,
 }
 
 int
-ixgbe_syn_filter_set(struct rte_eth_dev *dev,
+ixgbe_syn_filter_set(struct ixgbe_adapter *adapter,
 			struct rte_eth_syn_filter *filter,
 			bool add)
 {
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
 	struct ixgbe_filter_info *filter_info =
-		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
+		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(adapter);
 	uint32_t syn_info;
 	uint32_t synqf;
 
@@ -6499,10 +6500,10 @@ convert_protocol_type(uint8_t protocol_value)
 
 /* inject a 5-tuple filter to HW */
 static inline void
-ixgbe_inject_5tuple_filter(struct rte_eth_dev *dev,
+ixgbe_inject_5tuple_filter(struct ixgbe_adapter *adapter,
 			   struct ixgbe_5tuple_filter *filter)
 {
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
 	int i;
 	uint32_t ftqf, sdpqf;
 	uint32_t l34timir = 0;
@@ -6557,11 +6558,11 @@ ixgbe_inject_5tuple_filter(struct rte_eth_dev *dev,
  *    - On failure, a negative value.
  */
 static int
-ixgbe_add_5tuple_filter(struct rte_eth_dev *dev,
+ixgbe_add_5tuple_filter(struct ixgbe_adapter *adapter,
 			struct ixgbe_5tuple_filter *filter)
 {
 	struct ixgbe_filter_info *filter_info =
-		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
+		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(adapter);
 	int i, idx, shift;
 
 	/*
@@ -6585,7 +6586,7 @@ ixgbe_add_5tuple_filter(struct rte_eth_dev *dev,
 		return -ENOSYS;
 	}
 
-	ixgbe_inject_5tuple_filter(dev, filter);
+	ixgbe_inject_5tuple_filter(adapter, filter);
 
 	return 0;
 }
@@ -6598,12 +6599,12 @@ ixgbe_add_5tuple_filter(struct rte_eth_dev *dev,
  * filter: the pointer of the filter will be removed.
  */
 static void
-ixgbe_remove_5tuple_filter(struct rte_eth_dev *dev,
+ixgbe_remove_5tuple_filter(struct ixgbe_adapter *adapter,
 			struct ixgbe_5tuple_filter *filter)
 {
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
 	struct ixgbe_filter_info *filter_info =
-		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
+		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(adapter);
 	uint16_t index = filter->index;
 
 	filter_info->fivetuple_mask[index / (sizeof(uint32_t) * NBBY)] &=
@@ -6771,12 +6772,12 @@ ntuple_filter_to_5tuple(struct rte_eth_ntuple_filter *filter,
  *    - On failure, a negative value.
  */
 int
-ixgbe_add_del_ntuple_filter(struct rte_eth_dev *dev,
+ixgbe_add_del_ntuple_filter(struct ixgbe_adapter *adapter,
 			struct rte_eth_ntuple_filter *ntuple_filter,
 			bool add)
 {
 	struct ixgbe_filter_info *filter_info =
-		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
+		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(adapter);
 	struct ixgbe_5tuple_filter_info filter_5tuple;
 	struct ixgbe_5tuple_filter *filter;
 	int ret;
@@ -6811,25 +6812,25 @@ ixgbe_add_del_ntuple_filter(struct rte_eth_dev *dev,
 				 &filter_5tuple,
 				 sizeof(struct ixgbe_5tuple_filter_info));
 		filter->queue = ntuple_filter->queue;
-		ret = ixgbe_add_5tuple_filter(dev, filter);
+		ret = ixgbe_add_5tuple_filter(adapter, filter);
 		if (ret < 0) {
 			rte_free(filter);
 			return ret;
 		}
 	} else
-		ixgbe_remove_5tuple_filter(dev, filter);
+		ixgbe_remove_5tuple_filter(adapter, filter);
 
 	return 0;
 }
 
 int
-ixgbe_add_del_ethertype_filter(struct rte_eth_dev *dev,
+ixgbe_add_del_ethertype_filter(struct ixgbe_adapter *adapter,
 			struct rte_eth_ethertype_filter *filter,
 			bool add)
 {
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
 	struct ixgbe_filter_info *filter_info =
-		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
+		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(adapter);
 	uint32_t etqf = 0;
 	uint32_t etqs = 0;
 	int ret;
@@ -7699,11 +7700,11 @@ ixgbe_e_tag_enable(struct ixgbe_hw *hw)
 }
 
 static int
-ixgbe_e_tag_filter_del(struct rte_eth_dev *dev,
+ixgbe_e_tag_filter_del(struct ixgbe_adapter *adapter,
 		       struct ixgbe_l2_tunnel_conf *l2_tunnel)
 {
 	int ret = 0;
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
 	uint32_t i, rar_entries;
 	uint32_t rar_low, rar_high;
 
@@ -7736,11 +7737,11 @@ ixgbe_e_tag_filter_del(struct rte_eth_dev *dev,
 }
 
 static int
-ixgbe_e_tag_filter_add(struct rte_eth_dev *dev,
+ixgbe_e_tag_filter_add(struct ixgbe_adapter *adapter,
 		       struct ixgbe_l2_tunnel_conf *l2_tunnel)
 {
 	int ret = 0;
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
 	uint32_t i, rar_entries;
 	uint32_t rar_low, rar_high;
 
@@ -7752,7 +7753,7 @@ ixgbe_e_tag_filter_add(struct rte_eth_dev *dev,
 	}
 
 	/* One entry for one tunnel. Try to remove potential existing entry. */
-	ixgbe_e_tag_filter_del(dev, l2_tunnel);
+	ixgbe_e_tag_filter_del(adapter, l2_tunnel);
 
 	rar_entries = ixgbe_get_num_rx_addrs(hw);
 
@@ -7841,13 +7842,13 @@ ixgbe_remove_l2_tn_filter(struct ixgbe_l2_tn_info *l2_tn_info,
 
 /* Add l2 tunnel filter */
 int
-ixgbe_dev_l2_tunnel_filter_add(struct rte_eth_dev *dev,
+ixgbe_dev_l2_tunnel_filter_add(struct ixgbe_adapter *adapter,
 			       struct ixgbe_l2_tunnel_conf *l2_tunnel,
 			       bool restore)
 {
 	int ret;
 	struct ixgbe_l2_tn_info *l2_tn_info =
-		IXGBE_DEV_PRIVATE_TO_L2_TN_INFO(dev->data->dev_private);
+		IXGBE_DEV_PRIVATE_TO_L2_TN_INFO(adapter);
 	struct ixgbe_l2_tn_key key;
 	struct ixgbe_l2_tn_filter *node;
 
@@ -7882,7 +7883,7 @@ ixgbe_dev_l2_tunnel_filter_add(struct rte_eth_dev *dev,
 
 	switch (l2_tunnel->l2_tunnel_type) {
 	case RTE_ETH_L2_TUNNEL_TYPE_E_TAG:
-		ret = ixgbe_e_tag_filter_add(dev, l2_tunnel);
+		ret = ixgbe_e_tag_filter_add(adapter, l2_tunnel);
 		break;
 	default:
 		PMD_DRV_LOG(ERR, "Invalid tunnel type");
@@ -7898,12 +7899,12 @@ ixgbe_dev_l2_tunnel_filter_add(struct rte_eth_dev *dev,
 
 /* Delete l2 tunnel filter */
 int
-ixgbe_dev_l2_tunnel_filter_del(struct rte_eth_dev *dev,
+ixgbe_dev_l2_tunnel_filter_del(struct ixgbe_adapter *adapter,
 			       struct ixgbe_l2_tunnel_conf *l2_tunnel)
 {
 	int ret;
 	struct ixgbe_l2_tn_info *l2_tn_info =
-		IXGBE_DEV_PRIVATE_TO_L2_TN_INFO(dev->data->dev_private);
+		IXGBE_DEV_PRIVATE_TO_L2_TN_INFO(adapter);
 	struct ixgbe_l2_tn_key key;
 
 	key.l2_tn_type = l2_tunnel->l2_tunnel_type;
@@ -7914,7 +7915,7 @@ ixgbe_dev_l2_tunnel_filter_del(struct rte_eth_dev *dev,
 
 	switch (l2_tunnel->l2_tunnel_type) {
 	case RTE_ETH_L2_TUNNEL_TYPE_E_TAG:
-		ret = ixgbe_e_tag_filter_del(dev, l2_tunnel);
+		ret = ixgbe_e_tag_filter_del(adapter, l2_tunnel);
 		break;
 	default:
 		PMD_DRV_LOG(ERR, "Invalid tunnel type");
@@ -8311,12 +8312,14 @@ int ixgbe_enable_sec_tx_path_generic(struct ixgbe_hw *hw)
 static inline void
 ixgbe_ntuple_filter_restore(struct rte_eth_dev *dev)
 {
+	struct ixgbe_adapter *adapter =
+		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct ixgbe_filter_info *filter_info =
 		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
 	struct ixgbe_5tuple_filter *node;
 
 	TAILQ_FOREACH(node, &filter_info->fivetuple_list, entries) {
-		ixgbe_inject_5tuple_filter(dev, node);
+		ixgbe_inject_5tuple_filter(adapter, node);
 	}
 }
 
@@ -8361,8 +8364,10 @@ ixgbe_syn_filter_restore(struct rte_eth_dev *dev)
 static inline void
 ixgbe_l2_tn_filter_restore(struct rte_eth_dev *dev)
 {
+	struct ixgbe_adapter *adapter =
+		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct ixgbe_l2_tn_info *l2_tn_info =
-		IXGBE_DEV_PRIVATE_TO_L2_TN_INFO(dev->data->dev_private);
+		IXGBE_DEV_PRIVATE_TO_L2_TN_INFO(adapter);
 	struct ixgbe_l2_tn_filter *node;
 	struct ixgbe_l2_tunnel_conf l2_tn_conf;
 
@@ -8370,7 +8375,8 @@ ixgbe_l2_tn_filter_restore(struct rte_eth_dev *dev)
 		l2_tn_conf.l2_tunnel_type = node->key.l2_tn_type;
 		l2_tn_conf.tunnel_id      = node->key.tn_id;
 		l2_tn_conf.pool           = node->pool;
-		(void)ixgbe_dev_l2_tunnel_filter_add(dev, &l2_tn_conf, TRUE);
+		(void)ixgbe_dev_l2_tunnel_filter_add(adapter,
+						     &l2_tn_conf, TRUE);
 	}
 }
 
@@ -8378,11 +8384,13 @@ ixgbe_l2_tn_filter_restore(struct rte_eth_dev *dev)
 static inline void
 ixgbe_rss_filter_restore(struct rte_eth_dev *dev)
 {
+	struct ixgbe_adapter *adapter =
+		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct ixgbe_filter_info *filter_info =
-		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
+		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(adapter);
 
 	if (filter_info->rss_info.conf.queue_num)
-		ixgbe_config_rss_filter(dev,
+		ixgbe_config_rss_filter(adapter,
 			&filter_info->rss_info, TRUE);
 }
 
@@ -8419,12 +8427,14 @@ ixgbe_l2_tunnel_conf(struct rte_eth_dev *dev)
 void
 ixgbe_clear_all_ntuple_filter(struct rte_eth_dev *dev)
 {
+	struct ixgbe_adapter *adapter =
+		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct ixgbe_filter_info *filter_info =
 		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
 	struct ixgbe_5tuple_filter *p_5tuple;
 
 	while ((p_5tuple = TAILQ_FIRST(&filter_info->fivetuple_list)))
-		ixgbe_remove_5tuple_filter(dev, p_5tuple);
+		ixgbe_remove_5tuple_filter(adapter, p_5tuple);
 }
 
 /* remove all the ether type filters */
@@ -8468,6 +8478,7 @@ ixgbe_clear_syn_filter(struct rte_eth_dev *dev)
 int
 ixgbe_clear_all_l2_tn_filter(struct rte_eth_dev *dev)
 {
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev);
 	struct ixgbe_l2_tn_info *l2_tn_info =
 		IXGBE_DEV_PRIVATE_TO_L2_TN_INFO(dev->data->dev_private);
 	struct ixgbe_l2_tn_filter *l2_tn_filter;
@@ -8478,7 +8489,7 @@ ixgbe_clear_all_l2_tn_filter(struct rte_eth_dev *dev)
 		l2_tn_conf.l2_tunnel_type = l2_tn_filter->key.l2_tn_type;
 		l2_tn_conf.tunnel_id      = l2_tn_filter->key.tn_id;
 		l2_tn_conf.pool           = l2_tn_filter->pool;
-		ret = ixgbe_dev_l2_tunnel_filter_del(dev, &l2_tn_conf);
+		ret = ixgbe_dev_l2_tunnel_filter_del(adapter, &l2_tn_conf);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 04e5e014d9..8eae6fc21f 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -516,6 +516,9 @@ uint16_t ixgbe_vf_representor_tx_burst(void *tx_queue, struct rte_mbuf **tx_pkts
 #define IXGBE_DEV_FDIR_CONF(dev) \
 	(&((struct ixgbe_adapter *)(dev)->data->dev_private)->fdir_conf)
 
+#define IXGBE_DEV_PRIVATE_TO_FDIR_CONF(adapter) \
+	(&(adapter)->fdir_conf)
+
 #define IXGBE_DEV_PRIVATE_TO_ADAPTER(adapter) \
 	((struct ixgbe_adapter *)adapter)
 
@@ -663,13 +666,13 @@ uint32_t ixgbe_rssrk_reg_get(enum ixgbe_mac_type mac_type, uint8_t i);
 
 bool ixgbe_rss_update_sp(enum ixgbe_mac_type mac_type);
 
-int ixgbe_add_del_ntuple_filter(struct rte_eth_dev *dev,
+int ixgbe_add_del_ntuple_filter(struct ixgbe_adapter *adapter,
 			struct rte_eth_ntuple_filter *filter,
 			bool add);
-int ixgbe_add_del_ethertype_filter(struct rte_eth_dev *dev,
+int ixgbe_add_del_ethertype_filter(struct ixgbe_adapter *adapter,
 			struct rte_eth_ethertype_filter *filter,
 			bool add);
-int ixgbe_syn_filter_set(struct rte_eth_dev *dev,
+int ixgbe_syn_filter_set(struct ixgbe_adapter *adapter,
 			struct rte_eth_syn_filter *filter,
 			bool add);
 
@@ -685,22 +688,22 @@ struct ixgbe_l2_tunnel_conf {
 };
 
 int
-ixgbe_dev_l2_tunnel_filter_add(struct rte_eth_dev *dev,
+ixgbe_dev_l2_tunnel_filter_add(struct ixgbe_adapter *adapter,
 			       struct ixgbe_l2_tunnel_conf *l2_tunnel,
 			       bool restore);
 int
-ixgbe_dev_l2_tunnel_filter_del(struct rte_eth_dev *dev,
+ixgbe_dev_l2_tunnel_filter_del(struct ixgbe_adapter *adapter,
 			       struct ixgbe_l2_tunnel_conf *l2_tunnel);
 void ixgbe_filterlist_init(void);
 void ixgbe_filterlist_flush(void);
 /*
  * Flow director function prototypes
  */
-int ixgbe_fdir_configure(struct rte_eth_dev *dev);
-int ixgbe_fdir_set_input_mask(struct rte_eth_dev *dev);
-int ixgbe_fdir_set_flexbytes_offset(struct rte_eth_dev *dev,
+int ixgbe_fdir_configure(struct ixgbe_adapter *adapter);
+int ixgbe_fdir_set_input_mask(struct ixgbe_adapter *adapter);
+int ixgbe_fdir_set_flexbytes_offset(struct ixgbe_adapter *adapter,
 				    uint16_t offset);
-int ixgbe_fdir_filter_program(struct rte_eth_dev *dev,
+int ixgbe_fdir_filter_program(struct ixgbe_adapter *adapter,
 			      struct ixgbe_fdir_rule *rule,
 			      bool del, bool update);
 void ixgbe_fdir_info_get(struct rte_eth_dev *dev,
@@ -760,7 +763,7 @@ int ixgbe_rss_conf_init(struct ixgbe_rte_flow_rss_conf *out,
 			const struct rte_flow_action_rss *in);
 int ixgbe_action_rss_same(const struct rte_flow_action_rss *comp,
 			  const struct rte_flow_action_rss *with);
-int ixgbe_config_rss_filter(struct rte_eth_dev *dev,
+int ixgbe_config_rss_filter(struct ixgbe_adapter *adapter,
 		struct ixgbe_rte_flow_rss_conf *conf, bool add);
 
 void ixgbe_dev_macsec_register_enable(struct rte_eth_dev *dev,
diff --git a/drivers/net/intel/ixgbe/ixgbe_fdir.c b/drivers/net/intel/ixgbe/ixgbe_fdir.c
index e07c2adbda..2ab94e98aa 100644
--- a/drivers/net/intel/ixgbe/ixgbe_fdir.c
+++ b/drivers/net/intel/ixgbe/ixgbe_fdir.c
@@ -79,11 +79,11 @@
 #define IXGBE_FDIRIP6M_INNER_MAC_SHIFT 4
 
 static int fdir_erase_filter_82599(struct ixgbe_hw *hw, uint32_t fdirhash);
-static int fdir_set_input_mask(struct rte_eth_dev *dev,
+static int fdir_set_input_mask(struct ixgbe_adapter *adapter,
 			       const struct rte_eth_fdir_masks *input_mask);
-static int fdir_set_input_mask_82599(struct rte_eth_dev *dev);
-static int fdir_set_input_mask_x550(struct rte_eth_dev *dev);
-static int ixgbe_set_fdir_flex_conf(struct rte_eth_dev *dev,
+static int fdir_set_input_mask_82599(struct ixgbe_adapter *adapter);
+static int fdir_set_input_mask_x550(struct ixgbe_adapter *adapter);
+static int ixgbe_set_fdir_flex_conf(struct ixgbe_adapter *adapter,
 		const struct rte_eth_fdir_flex_conf *conf, uint32_t *fdirctrl);
 static int fdir_enable_82599(struct ixgbe_hw *hw, uint32_t fdirctrl);
 static uint32_t ixgbe_atr_compute_hash_82599(union ixgbe_atr_input *atr_input,
@@ -250,12 +250,13 @@ reverse_fdir_bitmasks(uint16_t hi_dword, uint16_t lo_dword)
  * but makes use of the rte_fdir_masks structure to see which bits to set.
  */
 static int
-fdir_set_input_mask_82599(struct rte_eth_dev *dev)
+fdir_set_input_mask_82599(struct ixgbe_adapter *adapter)
 {
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
+	struct rte_eth_fdir_conf *fdir_conf =
+		IXGBE_DEV_PRIVATE_TO_FDIR_CONF(adapter);
 	struct ixgbe_hw_fdir_info *info =
-			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
+			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
 	/*
 	 * mask VM pool and DIPv6 since there are currently not supported
 	 * mask FLEX byte, it will be set in flex_conf
@@ -335,12 +336,13 @@ fdir_set_input_mask_82599(struct rte_eth_dev *dev)
  * but makes use of the rte_fdir_masks structure to see which bits to set.
  */
 static int
-fdir_set_input_mask_x550(struct rte_eth_dev *dev)
+fdir_set_input_mask_x550(struct ixgbe_adapter *adapter)
 {
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
+	struct rte_eth_fdir_conf *fdir_conf =
+		IXGBE_DEV_PRIVATE_TO_FDIR_CONF(adapter);
 	struct ixgbe_hw_fdir_info *info =
-			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
+			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
 	/* mask VM pool and DIPv6 since there are currently not supported
 	 * mask FLEX byte, it will be set in flex_conf
 	 */
@@ -428,11 +430,11 @@ fdir_set_input_mask_x550(struct rte_eth_dev *dev)
 }
 
 static int
-ixgbe_fdir_store_input_mask_82599(struct rte_eth_dev *dev,
+ixgbe_fdir_store_input_mask_82599(struct ixgbe_adapter *adapter,
 				  const struct rte_eth_fdir_masks *input_mask)
 {
 	struct ixgbe_hw_fdir_info *info =
-		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
+		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
 	uint16_t dst_ipv6m = 0;
 	uint16_t src_ipv6m = 0;
 
@@ -451,11 +453,11 @@ ixgbe_fdir_store_input_mask_82599(struct rte_eth_dev *dev,
 }
 
 static int
-ixgbe_fdir_store_input_mask_x550(struct rte_eth_dev *dev,
+ixgbe_fdir_store_input_mask_x550(struct ixgbe_adapter *adapter,
 				 const struct rte_eth_fdir_masks *input_mask)
 {
 	struct ixgbe_hw_fdir_info *info =
-		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
+		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
 
 	memset(&info->mask, 0, sizeof(struct ixgbe_hw_fdir_mask));
 	info->mask.vlan_tci_mask = input_mask->vlan_tci_mask;
@@ -467,47 +469,49 @@ ixgbe_fdir_store_input_mask_x550(struct rte_eth_dev *dev,
 }
 
 static int
-ixgbe_fdir_store_input_mask(struct rte_eth_dev *dev,
+ixgbe_fdir_store_input_mask(struct ixgbe_adapter *adapter,
 			    const struct rte_eth_fdir_masks *input_mask)
 {
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
+	struct rte_eth_fdir_conf *fdir_conf =
+		IXGBE_DEV_PRIVATE_TO_FDIR_CONF(adapter);
 	enum rte_fdir_mode mode = fdir_conf->mode;
 
 	if (mode >= RTE_FDIR_MODE_SIGNATURE &&
 	    mode <= RTE_FDIR_MODE_PERFECT)
-		return ixgbe_fdir_store_input_mask_82599(dev, input_mask);
+		return ixgbe_fdir_store_input_mask_82599(adapter, input_mask);
 	else if (mode >= RTE_FDIR_MODE_PERFECT_MAC_VLAN &&
 		 mode <= RTE_FDIR_MODE_PERFECT_TUNNEL)
-		return ixgbe_fdir_store_input_mask_x550(dev, input_mask);
+		return ixgbe_fdir_store_input_mask_x550(adapter, input_mask);
 
 	PMD_DRV_LOG(ERR, "Not supported fdir mode - %d!", mode);
 	return -ENOTSUP;
 }
 
 int
-ixgbe_fdir_set_input_mask(struct rte_eth_dev *dev)
+ixgbe_fdir_set_input_mask(struct ixgbe_adapter *adapter)
 {
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
+	struct rte_eth_fdir_conf *fdir_conf =
+		IXGBE_DEV_PRIVATE_TO_FDIR_CONF(adapter);
 	enum rte_fdir_mode mode = fdir_conf->mode;
 
 	if (mode >= RTE_FDIR_MODE_SIGNATURE &&
 	    mode <= RTE_FDIR_MODE_PERFECT)
-		return fdir_set_input_mask_82599(dev);
+		return fdir_set_input_mask_82599(adapter);
 	else if (mode >= RTE_FDIR_MODE_PERFECT_MAC_VLAN &&
 		 mode <= RTE_FDIR_MODE_PERFECT_TUNNEL)
-		return fdir_set_input_mask_x550(dev);
+		return fdir_set_input_mask_x550(adapter);
 
 	PMD_DRV_LOG(ERR, "Not supported fdir mode - %d!", mode);
 	return -ENOTSUP;
 }
 
 int
-ixgbe_fdir_set_flexbytes_offset(struct rte_eth_dev *dev,
+ixgbe_fdir_set_flexbytes_offset(struct ixgbe_adapter *adapter,
 				uint16_t offset)
 {
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
 	struct ixgbe_hw_fdir_info *fdir_info =
-		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
+		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
 	uint32_t fdirctrl;
 	int i;
 
@@ -556,16 +560,16 @@ ixgbe_fdir_set_flexbytes_offset(struct rte_eth_dev *dev,
 }
 
 static int
-fdir_set_input_mask(struct rte_eth_dev *dev,
+fdir_set_input_mask(struct ixgbe_adapter *adapter,
 		    const struct rte_eth_fdir_masks *input_mask)
 {
 	int ret;
 
-	ret = ixgbe_fdir_store_input_mask(dev, input_mask);
+	ret = ixgbe_fdir_store_input_mask(adapter, input_mask);
 	if (ret)
 		return ret;
 
-	return ixgbe_fdir_set_input_mask(dev);
+	return ixgbe_fdir_set_input_mask(adapter);
 }
 
 /*
@@ -573,12 +577,12 @@ fdir_set_input_mask(struct rte_eth_dev *dev,
  * arguments are valid
  */
 static int
-ixgbe_set_fdir_flex_conf(struct rte_eth_dev *dev,
+ixgbe_set_fdir_flex_conf(struct ixgbe_adapter *adapter,
 		const struct rte_eth_fdir_flex_conf *conf, uint32_t *fdirctrl)
 {
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
 	struct ixgbe_hw_fdir_info *info =
-			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
+			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
 	const struct rte_eth_flex_payload_cfg *flex_cfg;
 	const struct rte_eth_fdir_flex_mask *flex_mask;
 	uint32_t fdirm;
@@ -636,10 +640,11 @@ ixgbe_set_fdir_flex_conf(struct rte_eth_dev *dev,
 }
 
 int
-ixgbe_fdir_configure(struct rte_eth_dev *dev)
+ixgbe_fdir_configure(struct ixgbe_adapter *adapter)
 {
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
+	struct rte_eth_fdir_conf *fdir_conf =
+		IXGBE_DEV_PRIVATE_TO_FDIR_CONF(adapter);
 	int err;
 	uint32_t fdirctrl, pbsize;
 	int i;
@@ -686,12 +691,12 @@ ixgbe_fdir_configure(struct rte_eth_dev *dev)
 	for (i = 1; i < 8; i++)
 		IXGBE_WRITE_REG(hw, IXGBE_RXPBSIZE(i), 0);
 
-	err = fdir_set_input_mask(dev, &fdir_conf->mask);
+	err = fdir_set_input_mask(adapter, &fdir_conf->mask);
 	if (err < 0) {
 		PMD_INIT_LOG(ERR, " Error on setting FD mask");
 		return err;
 	}
-	err = ixgbe_set_fdir_flex_conf(dev, &fdir_conf->flex_conf,
+	err = ixgbe_set_fdir_flex_conf(adapter, &fdir_conf->flex_conf,
 				       &fdirctrl);
 	if (err < 0) {
 		PMD_INIT_LOG(ERR, " Error on setting FD flexible arguments.");
@@ -1114,20 +1119,21 @@ ixgbe_remove_fdir_filter(struct ixgbe_hw_fdir_info *fdir_info,
 }
 
 int
-ixgbe_fdir_filter_program(struct rte_eth_dev *dev,
+ixgbe_fdir_filter_program(struct ixgbe_adapter *adapter,
 			  struct ixgbe_fdir_rule *rule,
 			  bool del,
 			  bool update)
 {
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
+	struct rte_eth_fdir_conf *fdir_conf =
+		IXGBE_DEV_PRIVATE_TO_FDIR_CONF(adapter);
 	uint32_t fdircmd_flags;
 	uint32_t fdirhash;
 	uint8_t queue;
 	bool is_perfect = FALSE;
 	int err;
 	struct ixgbe_hw_fdir_info *info =
-		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
+		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
 	enum rte_fdir_mode fdir_mode = fdir_conf->mode;
 	struct ixgbe_fdir_filter *node;
 	bool add_node = FALSE;
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index c40ef02f23..be92e3cdf3 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -2838,6 +2838,7 @@ ixgbe_parse_fdir_filter(struct rte_eth_dev *dev,
 {
 	int ret;
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	fdir_conf->drop_queue = IXGBE_FDIR_DROP_QUEUE;
 
@@ -2871,7 +2872,7 @@ ixgbe_parse_fdir_filter(struct rte_eth_dev *dev,
 
 	if (fdir_conf->mode == RTE_FDIR_MODE_NONE) {
 		fdir_conf->mode = rule->mode;
-		ret = ixgbe_fdir_configure(dev);
+		ret = ixgbe_fdir_configure(adapter);
 		if (ret) {
 			fdir_conf->mode = RTE_FDIR_MODE_NONE;
 			return ret;
@@ -3004,11 +3005,13 @@ ixgbe_parse_rss_filter(struct rte_eth_dev *dev,
 static void
 ixgbe_clear_rss_filter(struct rte_eth_dev *dev)
 {
+	struct ixgbe_adapter *adapter =
+		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct ixgbe_filter_info *filter_info =
 		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
 
 	if (filter_info->rss_info.conf.queue_num)
-		ixgbe_config_rss_filter(dev, &filter_info->rss_info, FALSE);
+		ixgbe_config_rss_filter(adapter, &filter_info->rss_info, FALSE);
 }
 
 void
@@ -3099,13 +3102,15 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 		  struct rte_flow_error *error)
 {
 	int ret;
+	struct ixgbe_adapter *adapter =
+		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct rte_eth_ntuple_filter ntuple_filter;
 	struct rte_eth_ethertype_filter ethertype_filter;
 	struct rte_eth_syn_filter syn_filter;
 	struct ixgbe_fdir_rule fdir_rule;
 	struct ixgbe_l2_tunnel_conf l2_tn_filter;
 	struct ixgbe_hw_fdir_info *fdir_info =
-		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
+		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
 	struct ixgbe_rte_flow_rss_conf rss_conf;
 	struct rte_flow *flow = NULL;
 	struct ixgbe_ntuple_filter_ele *ntuple_filter_ptr;
@@ -3147,7 +3152,7 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 			actions, &ntuple_filter, error);
 
 	if (!ret) {
-		ret = ixgbe_add_del_ntuple_filter(dev, &ntuple_filter, TRUE);
+		ret = ixgbe_add_del_ntuple_filter(adapter, &ntuple_filter, TRUE);
 		if (!ret) {
 			ntuple_filter_ptr = rte_zmalloc("ixgbe_ntuple_filter",
 				sizeof(struct ixgbe_ntuple_filter_ele), 0);
@@ -3171,7 +3176,7 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	ret = ixgbe_parse_ethertype_filter(dev, attr, pattern,
 				actions, &ethertype_filter, error);
 	if (!ret) {
-		ret = ixgbe_add_del_ethertype_filter(dev,
+		ret = ixgbe_add_del_ethertype_filter(adapter,
 				&ethertype_filter, TRUE);
 		if (!ret) {
 			ethertype_filter_ptr = rte_zmalloc(
@@ -3197,7 +3202,7 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	ret = ixgbe_parse_syn_filter(dev, attr, pattern,
 				actions, &syn_filter, error);
 	if (!ret) {
-		ret = ixgbe_syn_filter_set(dev, &syn_filter, TRUE);
+		ret = ixgbe_syn_filter_set(adapter, &syn_filter, TRUE);
 		if (!ret) {
 			syn_filter_ptr = rte_zmalloc("ixgbe_syn_filter",
 				sizeof(struct ixgbe_eth_syn_filter_ele), 0);
@@ -3229,12 +3234,12 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 				*&fdir_info->mask = *&fdir_rule.mask;
 
 				if (fdir_rule.mask.flex_bytes_mask) {
-					ret = ixgbe_fdir_set_flexbytes_offset(dev,
+					ret = ixgbe_fdir_set_flexbytes_offset(adapter,
 						fdir_rule.flex_bytes_offset);
 					if (ret)
 						goto out;
 				}
-				ret = ixgbe_fdir_set_input_mask(dev);
+				ret = ixgbe_fdir_set_input_mask(adapter);
 				if (ret)
 					goto out;
 
@@ -3259,7 +3264,7 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 		}
 
 		if (fdir_rule.b_spec) {
-			ret = ixgbe_fdir_filter_program(dev, &fdir_rule,
+			ret = ixgbe_fdir_filter_program(adapter, &fdir_rule,
 					FALSE, FALSE);
 			if (!ret) {
 				fdir_rule_ptr = rte_zmalloc("ixgbe_fdir_filter",
@@ -3297,7 +3302,7 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	ret = ixgbe_parse_l2_tn_filter(dev, attr, pattern,
 					actions, &l2_tn_filter, error);
 	if (!ret) {
-		ret = ixgbe_dev_l2_tunnel_filter_add(dev, &l2_tn_filter, FALSE);
+		ret = ixgbe_dev_l2_tunnel_filter_add(adapter, &l2_tn_filter, FALSE);
 		if (!ret) {
 			l2_tn_filter_ptr = rte_zmalloc("ixgbe_l2_tn_filter",
 				sizeof(struct ixgbe_eth_l2_tunnel_conf_ele), 0);
@@ -3320,7 +3325,7 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	ret = ixgbe_parse_rss_filter(dev, attr,
 					actions, &rss_conf, error);
 	if (!ret) {
-		ret = ixgbe_config_rss_filter(dev, &rss_conf, TRUE);
+		ret = ixgbe_config_rss_filter(adapter, &rss_conf, TRUE);
 		if (!ret) {
 			rss_filter_ptr = rte_zmalloc("ixgbe_rss_filter",
 				sizeof(struct ixgbe_rss_conf_ele), 0);
@@ -3420,6 +3425,8 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		struct rte_flow_error *error)
 {
 	int ret;
+	struct ixgbe_adapter *adapter =
+		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct rte_flow *pmd_flow = flow;
 	enum rte_filter_type filter_type = pmd_flow->filter_type;
 	struct rte_eth_ntuple_filter ntuple_filter;
@@ -3434,7 +3441,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
 	struct ixgbe_hw_fdir_info *fdir_info =
-		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
+		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
 
 	/* Special case for SECURITY flows */
@@ -3450,7 +3457,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		rte_memcpy(&ntuple_filter,
 			&ntuple_filter_ptr->filter_info,
 			sizeof(struct rte_eth_ntuple_filter));
-		ret = ixgbe_add_del_ntuple_filter(dev, &ntuple_filter, FALSE);
+		ret = ixgbe_add_del_ntuple_filter(adapter, &ntuple_filter, FALSE);
 		if (!ret) {
 			TAILQ_REMOVE(&filter_ntuple_list,
 			ntuple_filter_ptr, entries);
@@ -3463,7 +3470,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		rte_memcpy(&ethertype_filter,
 			&ethertype_filter_ptr->filter_info,
 			sizeof(struct rte_eth_ethertype_filter));
-		ret = ixgbe_add_del_ethertype_filter(dev,
+		ret = ixgbe_add_del_ethertype_filter(adapter,
 				&ethertype_filter, FALSE);
 		if (!ret) {
 			TAILQ_REMOVE(&filter_ethertype_list,
@@ -3477,7 +3484,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		rte_memcpy(&syn_filter,
 			&syn_filter_ptr->filter_info,
 			sizeof(struct rte_eth_syn_filter));
-		ret = ixgbe_syn_filter_set(dev, &syn_filter, FALSE);
+		ret = ixgbe_syn_filter_set(adapter, &syn_filter, FALSE);
 		if (!ret) {
 			TAILQ_REMOVE(&filter_syn_list,
 				syn_filter_ptr, entries);
@@ -3489,7 +3496,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		rte_memcpy(&fdir_rule,
 			&fdir_rule_ptr->filter_info,
 			sizeof(struct ixgbe_fdir_rule));
-		ret = ixgbe_fdir_filter_program(dev, &fdir_rule, TRUE, FALSE);
+		ret = ixgbe_fdir_filter_program(adapter, &fdir_rule, TRUE, FALSE);
 		if (!ret) {
 			TAILQ_REMOVE(&filter_fdir_list,
 				fdir_rule_ptr, entries);
@@ -3503,7 +3510,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 				pmd_flow->rule;
 		rte_memcpy(&l2_tn_filter, &l2_tn_filter_ptr->filter_info,
 			sizeof(struct ixgbe_l2_tunnel_conf));
-		ret = ixgbe_dev_l2_tunnel_filter_del(dev, &l2_tn_filter);
+		ret = ixgbe_dev_l2_tunnel_filter_del(adapter, &l2_tn_filter);
 		if (!ret) {
 			TAILQ_REMOVE(&filter_l2_tunnel_list,
 				l2_tn_filter_ptr, entries);
@@ -3513,7 +3520,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	case RTE_ETH_FILTER_HASH:
 		rss_filter_ptr = (struct ixgbe_rss_conf_ele *)
 				pmd_flow->rule;
-		ret = ixgbe_config_rss_filter(dev,
+		ret = ixgbe_config_rss_filter(adapter,
 					&rss_filter_ptr->filter_info, FALSE);
 		if (!ret) {
 			TAILQ_REMOVE(&filter_rss_list,
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 3be0f0492a..60222693fe 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -6132,7 +6132,7 @@ ixgbe_action_rss_same(const struct rte_flow_action_rss *comp,
 }
 
 int
-ixgbe_config_rss_filter(struct rte_eth_dev *dev,
+ixgbe_config_rss_filter(struct ixgbe_adapter *adapter,
 		struct ixgbe_rte_flow_rss_conf *conf, bool add)
 {
 	struct ixgbe_hw *hw;
@@ -6148,17 +6148,17 @@ ixgbe_config_rss_filter(struct rte_eth_dev *dev,
 		.rss_hf = conf->conf.types,
 	};
 	struct ixgbe_filter_info *filter_info =
-		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
+		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(adapter);
 
 	PMD_INIT_FUNC_TRACE();
-	hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
 
 	sp_reta_size = ixgbe_reta_size_get(hw->mac.type);
 
 	if (!add) {
 		if (ixgbe_action_rss_same(&filter_info->rss_info.conf,
 					  &conf->conf)) {
-			ixgbe_rss_disable(dev);
+			ixgbe_mrqc_rss_remove(hw);
 			memset(&filter_info->rss_info, 0,
 				sizeof(struct ixgbe_rte_flow_rss_conf));
 			return 0;
@@ -6188,7 +6188,7 @@ ixgbe_config_rss_filter(struct rte_eth_dev *dev,
 	 * the RSS hash of input packets.
 	 */
 	if ((rss_conf.rss_hf & IXGBE_RSS_OFFLOAD_ALL) == 0) {
-		ixgbe_rss_disable(dev);
+		ixgbe_mrqc_rss_remove(hw);
 		return 0;
 	}
 	if (rss_conf.rss_key == NULL)
-- 
2.47.3

