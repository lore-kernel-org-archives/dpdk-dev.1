Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82571C79F9E
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 15:22:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68F2A410F2;
	Tue,  8 Sep 2026 17:22:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id F1B6E410DF
 for <dev@dpdk.org>; Tue,  8 Sep 2026 17:22:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788880925; x=1820416925;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=sLco9ddZ6UnLhcYCWoDv0rcQV/tOMtaj8gsL1k+nTh0=;
 b=JmN40DjFvcXYYqdQoUMnPpUj3qzP5RbOqWHBRjLKeTj/TrtbWPbIdzPB
 qVYaC9/qOE9RAJPrQFG58h+COhlwoxtazMoixcN9YApRz5+PsSGFAUCCC
 D0b2A1dQITvCrKIMcV6FoiTVzMcm377AhiADqhk7lssk6wXCZD2TMPwkX
 +JBIzZBaqyQTLyzd3dELU5DhQpTfQgSU+ZTftT0B9HigDGbOIhO9ACvMx
 42vflMvA2TlMafItMyspZthGZRSxjobcpW/3WWZS1Dce0o61z+qpUkRap
 swBS4+PKRdZdcB6GKTfudPoa8sA0i9LKsTXyirYr2jyI3QTKpzWR5NkcS Q==;
X-CSE-ConnectionGUID: 3q3/6JQLT825ZBetpu6PtA==
X-CSE-MsgGUID: BdWGkj8GTV6UXq23EAFIfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89330154"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="89330154"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 08:22:04 -0700
X-CSE-ConnectionGUID: 0UZiIC6XRJSUs5Jje9KVKg==
X-CSE-MsgGUID: ycbOWyW2Sti6PFZF5/H3nA==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 08 Sep 2026 08:22:02 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 05/19] net/ixgbe: reimplement ethertype parser
Date: Tue,  8 Sep 2026 16:20:47 +0100
Message-ID: <45908d074690b8a7d0d288827334ef3853497818.1788880123.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1788880122.git.anatoly.burakov@intel.com>
 <cover.1788880122.git.anatoly.burakov@intel.com>
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

Use the new flow graph API and the common parsing framework to implement
flow parser for ethertype.

The old ethertype parser was accepting certain things that were later
rejected by the actual ethertype installation code, in particular DROP
action as well as dst MAC address filtering. This was removed from the
graph parser.

The ethertype filter tracking table is used by the rte_flow ethertype
engine, but it is also in use by other features, so the filter tracking
is refactored to be properly shared between the engine and other features
that write into the same table.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        | 186 +++++------
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        |  89 ++----
 drivers/net/intel/ixgbe/ixgbe_flow.c          | 219 +------------
 drivers/net/intel/ixgbe/ixgbe_flow.h          |   8 +
 .../net/intel/ixgbe/ixgbe_flow_ethertype.c    | 295 ++++++++++++++++++
 drivers/net/intel/ixgbe/ixgbe_pf.c            |  49 +--
 drivers/net/intel/ixgbe/meson.build           |   1 +
 7 files changed, 429 insertions(+), 418 deletions(-)
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_ethertype.c

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 20807534cd..8cd57c1ee7 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -2961,6 +2961,10 @@ ixgbe_dev_stop(struct rte_eth_dev *dev)
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return -E_RTE_SECONDARY;
 
+	/* disable timestamping; the application must re-enable it after restart */
+	if (adapter->filter.timesync_installed)
+		ixgbe_timesync_disable(dev);
+
 	ixgbe_dev_wait_setup_link_complete(dev, 0);
 
 	/* disable interrupts */
@@ -6852,76 +6856,51 @@ ixgbe_add_del_ntuple_filter(struct ixgbe_adapter *adapter,
 	return 0;
 }
 
-int
-ixgbe_add_del_ethertype_filter(struct ixgbe_adapter *adapter,
-			struct rte_eth_ethertype_filter *filter,
-			bool add)
+void
+ixgbe_ethertype_filter_program(struct ixgbe_hw *hw, uint8_t idx,
+			uint32_t etqf, uint32_t etqs)
 {
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
-	struct ixgbe_filter_info *filter_info =
-		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(adapter);
-	uint32_t etqf = 0;
-	uint32_t etqs = 0;
-	int ret;
-	struct ixgbe_ethertype_filter ethertype_filter;
-
-	if (filter->queue >= IXGBE_MAX_RX_QUEUE_NUM)
-		return -EINVAL;
-
-	if (filter->ether_type == RTE_ETHER_TYPE_IPV4 ||
-		filter->ether_type == RTE_ETHER_TYPE_IPV6) {
-		PMD_DRV_LOG(ERR, "unsupported ether_type(0x%04x) in"
-			" ethertype filter.", filter->ether_type);
-		return -EINVAL;
-	}
-
-	if (filter->flags & RTE_ETHTYPE_FLAGS_MAC) {
-		PMD_DRV_LOG(ERR, "mac compare is unsupported.");
-		return -EINVAL;
-	}
-	if (filter->flags & RTE_ETHTYPE_FLAGS_DROP) {
-		PMD_DRV_LOG(ERR, "drop option is unsupported.");
-		return -EINVAL;
-	}
-
-	ret = ixgbe_ethertype_filter_lookup(filter_info, filter->ether_type);
-	if (ret >= 0 && add) {
-		PMD_DRV_LOG(ERR, "ethertype (0x%04x) filter exists.",
-			    filter->ether_type);
-		return -EEXIST;
-	}
-	if (ret < 0 && !add) {
-		PMD_DRV_LOG(ERR, "ethertype (0x%04x) filter doesn't exist.",
-			    filter->ether_type);
-		return -ENOENT;
-	}
-
-	if (add) {
-		etqf = IXGBE_ETQF_FILTER_EN;
-		etqf |= (uint32_t)filter->ether_type;
-		etqs |= (uint32_t)((filter->queue <<
-				    IXGBE_ETQS_RX_QUEUE_SHIFT) &
-				    IXGBE_ETQS_RX_QUEUE);
-		etqs |= IXGBE_ETQS_QUEUE_EN;
-
-		ethertype_filter.ethertype = filter->ether_type;
-		ethertype_filter.etqf = etqf;
-		ethertype_filter.etqs = etqs;
-		ethertype_filter.conf = FALSE;
-		ret = ixgbe_ethertype_filter_insert(filter_info,
-						    &ethertype_filter);
-		if (ret < 0) {
-			PMD_DRV_LOG(ERR, "ethertype filters are full.");
-			return -ENOSPC;
-		}
-	} else {
-		ret = ixgbe_ethertype_filter_remove(filter_info, (uint8_t)ret);
-		if (ret < 0)
-			return -ENOSYS;
-	}
-	IXGBE_WRITE_REG(hw, IXGBE_ETQF(ret), etqf);
-	IXGBE_WRITE_REG(hw, IXGBE_ETQS(ret), etqs);
+	IXGBE_WRITE_REG(hw, IXGBE_ETQF(idx), etqf);
+	IXGBE_WRITE_REG(hw, IXGBE_ETQS(idx), etqs);
 	IXGBE_WRITE_FLUSH(hw);
+}
+
+int
+ixgbe_ethertype_table_add(struct ixgbe_ethertype_table *table,
+			uint16_t ethertype, uint32_t etqf, uint32_t etqs)
+{
+	int free_idx = -1;
+	int i;
+
+	for (i = 0; i < IXGBE_MAX_ETQF_FILTERS; i++) {
+		if (table->mask & (1u << i)) {
+			if (table->entries[i].ethertype == ethertype)
+				return -EEXIST;
+		} else if (free_idx < 0) {
+			free_idx = i;
+		}
+	}
+	if (free_idx < 0)
+		return -ENOSPC;
+
+	table->mask |= 1u << free_idx;
+	table->entries[free_idx].ethertype = ethertype;
+	table->entries[free_idx].etqf = etqf;
+	table->entries[free_idx].etqs = etqs;
+
+	return free_idx;
+}
+
+int
+ixgbe_ethertype_table_del(struct ixgbe_ethertype_table *table, uint8_t idx)
+{
+	if (idx >= IXGBE_MAX_ETQF_FILTERS || !(table->mask & (1u << idx)))
+		return -ENOENT;
+
+	table->mask &= ~(1u << idx);
+	table->entries[idx].ethertype = 0;
+	table->entries[idx].etqf = 0;
+	table->entries[idx].etqs = 0;
 
 	return 0;
 }
@@ -7159,8 +7138,11 @@ static int
 ixgbe_timesync_enable(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct ixgbe_filter_info *filter_info =
+		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
 	uint32_t tsync_ctl;
 	uint32_t tsauxc;
+	uint32_t etqf;
 	struct timespec ts;
 
 	memset(&ts, 0, sizeof(struct timespec));
@@ -7182,10 +7164,19 @@ ixgbe_timesync_enable(struct rte_eth_dev *dev)
 	ixgbe_start_timecounters(dev);
 
 	/* Enable L2 filtering of IEEE1588/802.1AS Ethernet frame types. */
-	IXGBE_WRITE_REG(hw, IXGBE_ETQF(IXGBE_ETQF_FILTER_1588),
-			(RTE_ETHER_TYPE_1588 |
-			 IXGBE_ETQF_FILTER_EN |
-			 IXGBE_ETQF_1588));
+	etqf = RTE_ETHER_TYPE_1588 | IXGBE_ETQF_FILTER_EN | IXGBE_ETQF_1588;
+	if (!filter_info->timesync_installed) {
+		int idx = ixgbe_ethertype_table_add(&filter_info->ethertype_table,
+				RTE_ETHER_TYPE_1588, etqf, 0);
+
+		if (idx < 0) {
+			PMD_DRV_LOG(ERR, "no free ETQF slot for 1588 timestamping");
+			return idx;
+		}
+		filter_info->timesync_idx = idx;
+		filter_info->timesync_installed = true;
+	}
+	ixgbe_ethertype_filter_program(hw, filter_info->timesync_idx, etqf, 0);
 
 	/* Enable timestamping of received PTP packets. */
 	tsync_ctl = IXGBE_READ_REG(hw, IXGBE_TSYNCRXCTL);
@@ -7209,6 +7200,8 @@ static int
 ixgbe_timesync_disable(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct ixgbe_filter_info *filter_info =
+		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
 	uint32_t tsync_ctl;
 
 	/* Disable timestamping of transmitted PTP packets. */
@@ -7222,7 +7215,12 @@ ixgbe_timesync_disable(struct rte_eth_dev *dev)
 	IXGBE_WRITE_REG(hw, IXGBE_TSYNCRXCTL, tsync_ctl);
 
 	/* Disable L2 filtering of IEEE1588/802.1AS Ethernet frame types. */
-	IXGBE_WRITE_REG(hw, IXGBE_ETQF(IXGBE_ETQF_FILTER_1588), 0);
+	if (filter_info->timesync_installed) {
+		ixgbe_ethertype_filter_program(hw, filter_info->timesync_idx, 0, 0);
+		ixgbe_ethertype_table_del(&filter_info->ethertype_table,
+				filter_info->timesync_idx);
+		filter_info->timesync_installed = false;
+	}
 
 	/* Stop incrementing the System Time registers. */
 	IXGBE_WRITE_REG(hw, IXGBE_TIMINCA, 0);
@@ -8364,26 +8362,6 @@ ixgbe_ntuple_filter_restore(struct rte_eth_dev *dev)
 	}
 }
 
-/* restore ethernet type filter */
-static inline void
-ixgbe_ethertype_filter_restore(struct rte_eth_dev *dev)
-{
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct ixgbe_filter_info *filter_info =
-		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
-	int i;
-
-	for (i = 0; i < IXGBE_MAX_ETQF_FILTERS; i++) {
-		if (filter_info->ethertype_mask & (1 << i)) {
-			IXGBE_WRITE_REG(hw, IXGBE_ETQF(i),
-					filter_info->ethertype_filters[i].etqf);
-			IXGBE_WRITE_REG(hw, IXGBE_ETQS(i),
-					filter_info->ethertype_filters[i].etqs);
-			IXGBE_WRITE_FLUSH(hw);
-		}
-	}
-}
-
 /* restore SYN filter */
 static inline void
 ixgbe_syn_filter_restore(struct rte_eth_dev *dev)
@@ -8439,7 +8417,6 @@ static int
 ixgbe_filter_restore(struct rte_eth_dev *dev)
 {
 	ixgbe_ntuple_filter_restore(dev);
-	ixgbe_ethertype_filter_restore(dev);
 	ixgbe_syn_filter_restore(dev);
 	ixgbe_fdir_filter_restore(dev);
 	ixgbe_l2_tn_filter_restore(dev);
@@ -8478,27 +8455,6 @@ ixgbe_clear_all_ntuple_filter(struct rte_eth_dev *dev)
 		ixgbe_remove_5tuple_filter(adapter, p_5tuple);
 }
 
-/* remove all the ether type filters */
-void
-ixgbe_clear_all_ethertype_filter(struct rte_eth_dev *dev)
-{
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct ixgbe_filter_info *filter_info =
-		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
-	int i;
-
-	for (i = 0; i < IXGBE_MAX_ETQF_FILTERS; i++) {
-		if (filter_info->ethertype_mask & (1 << i) &&
-		    !filter_info->ethertype_filters[i].conf) {
-			(void)ixgbe_ethertype_filter_remove(filter_info,
-							    (uint8_t)i);
-			IXGBE_WRITE_REG(hw, IXGBE_ETQF(i), 0);
-			IXGBE_WRITE_REG(hw, IXGBE_ETQS(i), 0);
-			IXGBE_WRITE_FLUSH(hw);
-		}
-	}
-}
-
 /* remove the SYN filter */
 void
 ixgbe_clear_syn_filter(struct rte_eth_dev *dev)
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index cde0ee8fda..3f15b5a0c9 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -298,24 +298,20 @@ struct ixgbe_5tuple_filter {
 	(RTE_ALIGN(IXGBE_MAX_FTQF_FILTERS, (sizeof(uint32_t) * NBBY)) / \
 	 (sizeof(uint32_t) * NBBY))
 
-struct ixgbe_ethertype_filter {
-	uint16_t ethertype;
-	uint32_t etqf;
-	uint32_t etqs;
-	/**
-	 * If this filter is added by configuration,
-	 * it should not be removed.
-	 */
-	bool     conf;
+/* Shared EtherType (ETQF) filter table. */
+struct ixgbe_ethertype_table {
+	uint32_t mask; /* bitmask of used ETQF slots */
+	struct ixgbe_ethertype_entry {
+		uint16_t ethertype; /* ethertype, for dedup */
+		uint32_t etqf; /* ETQF register value */
+		uint32_t etqs; /* ETQS register value */
+	} entries[IXGBE_MAX_ETQF_FILTERS];
 };
 
 /*
  * Structure to store filters' info.
  */
 struct ixgbe_filter_info {
-	uint8_t ethertype_mask;  /* Bit mask for every used ethertype filter */
-	/* store used ethertype filters*/
-	struct ixgbe_ethertype_filter ethertype_filters[IXGBE_MAX_ETQF_FILTERS];
 	/* Bit mask for every used 5tuple filter */
 	uint32_t fivetuple_mask[IXGBE_5TUPLE_ARRAY_SIZE];
 	struct ixgbe_5tuple_filter_list fivetuple_list;
@@ -323,6 +319,14 @@ struct ixgbe_filter_info {
 	uint32_t syn_info;
 	/* store the rss filter info */
 	struct ixgbe_rte_flow_rss_conf rss_info;
+	/* shared EtherType (ETQF) slot table */
+	struct ixgbe_ethertype_table ethertype_table;
+	/* 1588 timestamping ETQF slot (valid when timesync_installed) */
+	bool timesync_installed;
+	uint8_t timesync_idx;
+	/* Tx anti-spoof ETQF slot (valid when antispoof_installed) */
+	bool antispoof_installed;
+	uint8_t antispoof_idx;
 };
 
 struct ixgbe_l2_tn_key {
@@ -680,13 +684,16 @@ bool ixgbe_rss_update_sp(enum ixgbe_mac_type mac_type);
 int ixgbe_add_del_ntuple_filter(struct ixgbe_adapter *adapter,
 			struct rte_eth_ntuple_filter *filter,
 			bool add);
-int ixgbe_add_del_ethertype_filter(struct ixgbe_adapter *adapter,
-			struct rte_eth_ethertype_filter *filter,
-			bool add);
 int ixgbe_syn_filter_set(struct ixgbe_adapter *adapter,
 			struct rte_eth_syn_filter *filter,
 			bool add);
 
+void ixgbe_ethertype_filter_program(struct ixgbe_hw *hw, uint8_t idx,
+			uint32_t etqf, uint32_t etqs);
+int ixgbe_ethertype_table_add(struct ixgbe_ethertype_table *table,
+			uint16_t ethertype, uint32_t etqf, uint32_t etqs);
+int ixgbe_ethertype_table_del(struct ixgbe_ethertype_table *table, uint8_t idx);
+
 /**
  * l2 tunnel configuration.
  */
@@ -757,7 +764,6 @@ int ixgbe_clear_all_fdir_filter(struct rte_eth_dev *dev);
 
 extern const struct rte_flow_ops ixgbe_flow_ops;
 
-void ixgbe_clear_all_ethertype_filter(struct rte_eth_dev *dev);
 void ixgbe_clear_all_ntuple_filter(struct rte_eth_dev *dev);
 void ixgbe_clear_syn_filter(struct rte_eth_dev *dev);
 int ixgbe_clear_all_l2_tn_filter(struct rte_eth_dev *dev);
@@ -792,55 +798,4 @@ void ixgbe_dev_macsec_setting_save(struct rte_eth_dev *dev,
 
 void ixgbe_dev_macsec_setting_reset(struct rte_eth_dev *dev);
 
-static inline int
-ixgbe_ethertype_filter_lookup(struct ixgbe_filter_info *filter_info,
-			      uint16_t ethertype)
-{
-	int i;
-
-	for (i = 0; i < IXGBE_MAX_ETQF_FILTERS; i++) {
-		if (filter_info->ethertype_filters[i].ethertype == ethertype &&
-		    (filter_info->ethertype_mask & (1 << i)))
-			return i;
-	}
-	return -1;
-}
-
-static inline int
-ixgbe_ethertype_filter_insert(struct ixgbe_filter_info *filter_info,
-			      struct ixgbe_ethertype_filter *ethertype_filter)
-{
-	int i;
-
-	for (i = 0; i < IXGBE_MAX_ETQF_FILTERS; i++) {
-		if (!(filter_info->ethertype_mask & (1 << i))) {
-			filter_info->ethertype_mask |= 1 << i;
-			filter_info->ethertype_filters[i].ethertype =
-				ethertype_filter->ethertype;
-			filter_info->ethertype_filters[i].etqf =
-				ethertype_filter->etqf;
-			filter_info->ethertype_filters[i].etqs =
-				ethertype_filter->etqs;
-			filter_info->ethertype_filters[i].conf =
-				ethertype_filter->conf;
-			return i;
-		}
-	}
-	return -1;
-}
-
-static inline int
-ixgbe_ethertype_filter_remove(struct ixgbe_filter_info *filter_info,
-			      uint8_t idx)
-{
-	if (idx >= IXGBE_MAX_ETQF_FILTERS)
-		return -1;
-	filter_info->ethertype_mask &= ~(1 << idx);
-	filter_info->ethertype_filters[idx].ethertype = 0;
-	filter_info->ethertype_filters[idx].etqf = 0;
-	filter_info->ethertype_filters[idx].etqs = 0;
-	filter_info->ethertype_filters[idx].etqs = FALSE;
-	return idx;
-}
-
 #endif /* _IXGBE_ETHDEV_H_ */
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 9babe8eea6..bde8759bf7 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -63,11 +63,6 @@ struct ixgbe_ntuple_filter_ele {
 	struct ixgbe_filter_ele_base base;
 	struct rte_eth_ntuple_filter filter_info;
 };
-/* ethertype filter list structure */
-struct ixgbe_ethertype_filter_ele {
-	struct ixgbe_filter_ele_base base;
-	struct rte_eth_ethertype_filter filter_info;
-};
 /* syn filter list structure */
 struct ixgbe_eth_syn_filter_ele {
 	struct ixgbe_filter_ele_base base;
@@ -94,7 +89,11 @@ struct ixgbe_flow_mem {
 	struct rte_flow *flow;
 };
 
-const struct ci_flow_engine_list ixgbe_flow_engine_list = {0};
+const struct ci_flow_engine_list ixgbe_flow_engine_list = {
+	{
+		&ixgbe_ethertype_flow_engine,
+	}
+};
 
 /**
  * Endless loop will never happen with below assumption
@@ -118,7 +117,7 @@ const struct rte_flow_item *next_no_void_pattern(
 /*
  * All ixgbe engines mostly check the same stuff, so use a common check.
  */
-static int
+int
 ixgbe_flow_actions_check(const struct ci_flow_actions *actions,
 		const struct ci_flow_actions_check_param *param,
 		struct rte_flow_error *error)
@@ -667,169 +666,6 @@ ixgbe_parse_ntuple_filter(struct rte_eth_dev *dev,
 	return 0;
 }
 
-/**
- * Parse the rule to see if it is a ethertype rule.
- * And get the ethertype filter info BTW.
- * pattern:
- * The first not void item can be ETH.
- * The next not void item must be END.
- * action:
- * The first not void action should be QUEUE.
- * The next not void action should be END.
- * pattern example:
- * ITEM		Spec			Mask
- * ETH		type	0x0807		0xFFFF
- * END
- * other members in mask and spec should set to 0x00.
- * item->last should be NULL.
- */
-static int
-cons_parse_ethertype_filter(const struct rte_flow_item *pattern,
-		const struct rte_flow_action *action,
-		struct rte_eth_ethertype_filter *filter,
-		struct rte_flow_error *error)
-{
-	const struct rte_flow_item *item;
-	const struct rte_flow_item_eth *eth_spec;
-	const struct rte_flow_item_eth *eth_mask;
-
-	item = next_no_void_pattern(pattern, NULL);
-	/* The first non-void item should be MAC. */
-	if (item->type != RTE_FLOW_ITEM_TYPE_ETH) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by ethertype filter");
-		return -rte_errno;
-	}
-
-	/*Not supported last point for range*/
-	if (item->last) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			item, "Not supported last point for range");
-		return -rte_errno;
-	}
-
-	/* Get the MAC info. */
-	if (!item->spec || !item->mask) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by ethertype filter");
-		return -rte_errno;
-	}
-
-	eth_spec = item->spec;
-	eth_mask = item->mask;
-
-	/* Mask bits of source MAC address must be full of 0.
-	 * Mask bits of destination MAC address must be full
-	 * of 1 or full of 0.
-	 */
-	if (!rte_is_zero_ether_addr(&eth_mask->hdr.src_addr) ||
-	    (!rte_is_zero_ether_addr(&eth_mask->hdr.dst_addr) &&
-	     !rte_is_broadcast_ether_addr(&eth_mask->hdr.dst_addr))) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Invalid ether address mask");
-		return -rte_errno;
-	}
-
-	if ((eth_mask->hdr.ether_type & UINT16_MAX) != UINT16_MAX) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Invalid ethertype mask");
-		return -rte_errno;
-	}
-
-	/* If mask bits of destination MAC address
-	 * are full of 1, set RTE_ETHTYPE_FLAGS_MAC.
-	 */
-	if (rte_is_broadcast_ether_addr(&eth_mask->hdr.dst_addr)) {
-		filter->mac_addr = eth_spec->hdr.dst_addr;
-		filter->flags |= RTE_ETHTYPE_FLAGS_MAC;
-	} else {
-		filter->flags &= ~RTE_ETHTYPE_FLAGS_MAC;
-	}
-	filter->ether_type = rte_be_to_cpu_16(eth_spec->hdr.ether_type);
-
-	/* Check if the next non-void item is END. */
-	item = next_no_void_pattern(pattern, item);
-	if (item->type != RTE_FLOW_ITEM_TYPE_END) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by ethertype filter.");
-		return -rte_errno;
-	}
-
-	filter->queue = ((const struct rte_flow_action_queue *)action->conf)->index;
-
-	return 0;
-}
-
-static int
-ixgbe_parse_ethertype_filter(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
-		const struct rte_flow_item pattern[], const struct rte_flow_action actions[],
-		struct rte_eth_ethertype_filter *filter, struct rte_flow_error *error)
-{
-	int ret;
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct ci_flow_actions parsed_actions;
-	struct ci_flow_actions_check_param ap_param = {
-		.allowed_types = (const enum rte_flow_action_type[]){
-			/* only queue is allowed here */
-			RTE_FLOW_ACTION_TYPE_QUEUE,
-			RTE_FLOW_ACTION_TYPE_END
-		},
-		.max_actions = 1,
-		.driver_ctx = dev->data,
-		.check = ixgbe_flow_actions_check
-	};
-	const struct rte_flow_action *action;
-
-	if (hw->mac.type != ixgbe_mac_82599EB &&
-			hw->mac.type != ixgbe_mac_X540 &&
-			hw->mac.type != ixgbe_mac_X550 &&
-			hw->mac.type != ixgbe_mac_X550EM_x &&
-			hw->mac.type != ixgbe_mac_X550EM_a &&
-			hw->mac.type != ixgbe_mac_E610)
-		return -ENOTSUP;
-
-	/* validate attributes */
-	ret = ci_flow_check_attr(attr, NULL, error);
-	if (ret)
-		return ret;
-
-	/* parse requested actions */
-	ret = ci_flow_check_actions(actions, &ap_param, &parsed_actions, error);
-	if (ret)
-		return ret;
-
-	action = parsed_actions.actions[0];
-
-	ret = cons_parse_ethertype_filter(pattern, action, filter, error);
-	if (ret)
-		return ret;
-
-	if (filter->ether_type == RTE_ETHER_TYPE_IPV4 ||
-		filter->ether_type == RTE_ETHER_TYPE_IPV6) {
-		memset(filter, 0, sizeof(struct rte_eth_ethertype_filter));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			NULL, "IPv4/IPv6 not supported by ethertype filter");
-		return -rte_errno;
-	}
-
-	if (filter->flags & RTE_ETHTYPE_FLAGS_MAC) {
-		memset(filter, 0, sizeof(struct rte_eth_ethertype_filter));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			NULL, "mac compare is unsupported");
-		return -rte_errno;
-	}
-
-	return 0;
-}
-
 /**
  * Parse the rule to see if it is a TCP SYN rule.
  * And get the TCP SYN filter info BTW.
@@ -2815,7 +2651,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	struct ixgbe_adapter *adapter =
 		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct rte_eth_ntuple_filter ntuple_filter;
-	struct rte_eth_ethertype_filter ethertype_filter;
 	struct rte_eth_syn_filter syn_filter;
 	struct ixgbe_fdir_rule fdir_rule;
 	struct ixgbe_l2_tunnel_conf l2_tn_filter;
@@ -2824,7 +2659,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	struct ixgbe_rte_flow_rss_conf rss_conf;
 	struct rte_flow *flow = NULL;
 	struct ixgbe_ntuple_filter_ele *ntuple_filter_ptr;
-	struct ixgbe_ethertype_filter_ele *ethertype_filter_ptr;
 	struct ixgbe_eth_syn_filter_ele *syn_filter_ptr;
 	struct ixgbe_eth_l2_tunnel_conf_ele *l2_tn_filter_ptr;
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
@@ -2884,28 +2718,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 		goto out;
 	}
 
-	memset(&ethertype_filter, 0, sizeof(struct rte_eth_ethertype_filter));
-	ret = ixgbe_parse_ethertype_filter(dev, attr, pattern,
-				actions, &ethertype_filter, error);
-	if (!ret) {
-		ret = ixgbe_add_del_ethertype_filter(adapter,
-				&ethertype_filter, TRUE);
-		if (!ret) {
-			ethertype_filter_ptr = rte_zmalloc(
-				"ixgbe_ethertype_filter",
-				sizeof(struct ixgbe_ethertype_filter_ele), 0);
-			if (!ethertype_filter_ptr) {
-				PMD_DRV_LOG(ERR, "failed to allocate memory");
-				goto out;
-			}
-			ethertype_filter_ptr->filter_info = ethertype_filter;
-			flow->rule = ethertype_filter_ptr;
-			flow->filter_type = RTE_ETH_FILTER_ETHERTYPE;
-			return flow;
-		}
-		goto out;
-	}
-
 	memset(&syn_filter, 0, sizeof(struct rte_eth_syn_filter));
 	ret = ixgbe_parse_syn_filter(dev, attr, pattern,
 				actions, &syn_filter, error);
@@ -3023,7 +2835,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 {
 	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct rte_eth_ntuple_filter ntuple_filter;
-	struct rte_eth_ethertype_filter ethertype_filter;
 	struct rte_eth_syn_filter syn_filter;
 	struct ixgbe_l2_tunnel_conf l2_tn_filter;
 	struct ixgbe_fdir_rule fdir_rule;
@@ -3050,12 +2861,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 	if (!ret)
 		return 0;
 
-	memset(&ethertype_filter, 0, sizeof(struct rte_eth_ethertype_filter));
-	ret = ixgbe_parse_ethertype_filter(dev, attr, pattern,
-				actions, &ethertype_filter, error);
-	if (!ret)
-		return 0;
-
 	memset(&syn_filter, 0, sizeof(struct rte_eth_syn_filter));
 	ret = ixgbe_parse_syn_filter(dev, attr, pattern,
 				actions, &syn_filter, error);
@@ -3093,12 +2898,10 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	struct rte_flow *pmd_flow = flow;
 	enum rte_filter_type filter_type = pmd_flow->filter_type;
 	struct rte_eth_ntuple_filter ntuple_filter;
-	struct rte_eth_ethertype_filter ethertype_filter;
 	struct rte_eth_syn_filter syn_filter;
 	struct ixgbe_fdir_rule fdir_rule;
 	struct ixgbe_l2_tunnel_conf l2_tn_filter;
 	struct ixgbe_ntuple_filter_ele *ntuple_filter_ptr;
-	struct ixgbe_ethertype_filter_ele *ethertype_filter_ptr;
 	struct ixgbe_eth_syn_filter_ele *syn_filter_ptr;
 	struct ixgbe_eth_l2_tunnel_conf_ele *l2_tn_filter_ptr;
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
@@ -3144,15 +2947,6 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		if (!ret)
 			rte_free(ntuple_filter_ptr);
 		break;
-	case RTE_ETH_FILTER_ETHERTYPE:
-		ethertype_filter_ptr = (struct ixgbe_ethertype_filter_ele *)
-					pmd_flow->rule;
-		ethertype_filter = ethertype_filter_ptr->filter_info;
-		ret = ixgbe_add_del_ethertype_filter(adapter,
-				&ethertype_filter, FALSE);
-		if (!ret)
-			rte_free(ethertype_filter_ptr);
-		break;
 	case RTE_ETH_FILTER_SYN:
 		syn_filter_ptr = (struct ixgbe_eth_syn_filter_ele *)
 				pmd_flow->rule;
@@ -3229,7 +3023,6 @@ ixgbe_flow_flush(struct rte_eth_dev *dev,
 	}
 
 	ixgbe_clear_all_ntuple_filter(dev);
-	ixgbe_clear_all_ethertype_filter(dev);
 	ixgbe_clear_syn_filter(dev);
 
 	ret = ixgbe_clear_all_fdir_filter(dev);
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.h b/drivers/net/intel/ixgbe/ixgbe_flow.h
index 5e68c9886c..d7694283a5 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.h
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.h
@@ -5,8 +5,16 @@
 #ifndef _IXGBE_FLOW_H_
 #define _IXGBE_FLOW_H_
 
+#include "../common/flow_check.h"
 #include "../common/flow_engine.h"
 
+int
+ixgbe_flow_actions_check(const struct ci_flow_actions *actions,
+		const struct ci_flow_actions_check_param *param,
+		struct rte_flow_error *error);
+
 extern const struct ci_flow_engine_list ixgbe_flow_engine_list;
 
+extern const struct ci_flow_engine ixgbe_ethertype_flow_engine;
+
 #endif /*  _IXGBE_FLOW_H_ */
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow_ethertype.c b/drivers/net/intel/ixgbe/ixgbe_flow_ethertype.c
new file mode 100644
index 0000000000..d02d52d538
--- /dev/null
+++ b/drivers/net/intel/ixgbe/ixgbe_flow_ethertype.c
@@ -0,0 +1,295 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include <rte_flow.h>
+#include <flow_graph.h>
+#include <rte_ether.h>
+
+#include "ixgbe_ethdev.h"
+#include "ixgbe_flow.h"
+#include "../common/flow_check.h"
+#include "../common/flow_util.h"
+#include "../common/flow_engine.h"
+
+struct ixgbe_ethertype_flow {
+	struct rte_flow flow;
+	uint16_t ether_type;
+	uint16_t queue;
+	uint32_t etqf;
+	uint32_t etqs;
+	uint8_t index; /* assigned HW slot */
+};
+
+struct ixgbe_ethertype_ctx {
+	struct ci_flow_engine_ctx base;
+	struct rte_eth_ethertype_filter filter;
+};
+
+/**
+ * Ethertype filter graph implementation
+ * Pattern: START -> ETH -> END
+ */
+
+enum ixgbe_ethertype_node_id {
+	IXGBE_ETHERTYPE_NODE_START = FLOW_GRAPH_NODE_FIRST,
+	IXGBE_ETHERTYPE_NODE_ETH,
+	IXGBE_ETHERTYPE_NODE_END,
+	IXGBE_ETHERTYPE_NODE_MAX,
+};
+
+static int
+ixgbe_ethertype_node_eth_validate(const void *ctx __rte_unused,
+				  const struct rte_flow_item *item,
+				  struct rte_flow_error *error)
+{
+	const struct rte_flow_item_eth *eth_spec;
+	const struct rte_flow_item_eth *eth_mask;
+
+	eth_spec = item->spec;
+	eth_mask = item->mask;
+
+	/* Source MAC mask must be all zeros */
+	if (!CI_FIELD_IS_ZERO(&eth_mask->hdr.src_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Source MAC filtering not supported");
+	}
+
+	/* Dest MAC mask must be all zeros */
+	if (!CI_FIELD_IS_ZERO(&eth_mask->hdr.dst_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Destination MAC filtering not supported");
+	}
+
+	/* Ethertype mask must be exact match */
+	if (!CI_FIELD_IS_MASKED(&eth_mask->hdr.ether_type)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Ethertype must be exactly matched");
+	}
+
+	/* IPv4/IPv6 ethertypes not supported by hardware */
+	uint16_t ether_type = rte_be_to_cpu_16(eth_spec->hdr.ether_type);
+	if (ether_type == RTE_ETHER_TYPE_IPV4 || ether_type == RTE_ETHER_TYPE_IPV6) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"IPv4/IPv6 not supported by ethertype filter");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_ethertype_node_eth_process(void *ctx,
+				 const struct rte_flow_item *item,
+				 struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_ethertype_ctx *graph_ctx = ctx;
+	const struct rte_flow_item_eth *eth_spec = item->spec;
+
+	graph_ctx->filter.ether_type = rte_be_to_cpu_16(eth_spec->hdr.ether_type);
+
+	return 0;
+}
+
+static const struct flow_graph ixgbe_ethertype_graph = {
+	.nodes = (struct flow_graph_node[]) {
+		[IXGBE_ETHERTYPE_NODE_START] = {
+			.name = "START",
+		},
+		[IXGBE_ETHERTYPE_NODE_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = ixgbe_ethertype_node_eth_validate,
+			.process = ixgbe_ethertype_node_eth_process,
+		},
+		[IXGBE_ETHERTYPE_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	},
+	.edges = (struct flow_graph_edge[]) {
+		[IXGBE_ETHERTYPE_NODE_START] = {
+			.next = (size_t[]) {
+				IXGBE_ETHERTYPE_NODE_ETH,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_ETHERTYPE_NODE_ETH] = {
+			.next = (size_t[]) {
+				IXGBE_ETHERTYPE_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+static int
+ixgbe_flow_ethertype_ctx_init(const struct rte_flow_action *actions,
+		const struct rte_flow_attr *attr,
+		struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	struct ci_flow_actions parsed_actions;
+	struct ci_flow_actions_check_param ap_param = {
+		.allowed_types = (const enum rte_flow_action_type[]){
+			/* only queue is allowed here */
+			RTE_FLOW_ACTION_TYPE_QUEUE,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.max_actions = 1,
+		.driver_ctx = ctx->dev_data,
+		.check = ixgbe_flow_actions_check
+	};
+	struct ixgbe_ethertype_ctx *ethertype_ctx = (struct ixgbe_ethertype_ctx *)ctx;
+	const struct rte_flow_action_queue *q_act;
+	int ret;
+
+	/* validate attributes */
+	ret = ci_flow_check_attr(attr, NULL, error);
+	if (ret)
+		return ret;
+
+	/* parse requested actions */
+	ret = ci_flow_check_actions(actions, &ap_param, &parsed_actions, error);
+	if (ret)
+		return ret;
+
+	q_act = (const struct rte_flow_action_queue *)parsed_actions.actions[0]->conf;
+
+	/* set up filter action */
+	ethertype_ctx->filter.queue = q_act->index;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_ethertype_ctx_to_flow(const struct ci_flow_engine_ctx *ctx,
+		struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct ixgbe_ethertype_ctx *ethertype_ctx = (const struct ixgbe_ethertype_ctx *)ctx;
+	struct ixgbe_ethertype_flow *ethertype_flow = (struct ixgbe_ethertype_flow *)flow;
+
+	/* copy filter configuration */
+	ethertype_flow->ether_type = ethertype_ctx->filter.ether_type;
+	ethertype_flow->queue = ethertype_ctx->filter.queue;
+
+	/* build the ETQF/ETQS register values from the parsed filter */
+	ethertype_flow->etqf = IXGBE_ETQF_FILTER_EN | (uint32_t)ethertype_flow->ether_type;
+	ethertype_flow->etqs = ((uint32_t)ethertype_flow->queue <<
+			IXGBE_ETQS_RX_QUEUE_SHIFT) & IXGBE_ETQS_RX_QUEUE;
+	ethertype_flow->etqs |= IXGBE_ETQS_QUEUE_EN;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_ethertype_register(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct ixgbe_ethertype_flow *ethertype_flow = (struct ixgbe_ethertype_flow *)flow;
+	struct ixgbe_filter_info *filter_info =
+		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(flow->dev_data->dev_private);
+	int idx;
+
+	idx = ixgbe_ethertype_table_add(&filter_info->ethertype_table,
+			ethertype_flow->ether_type, ethertype_flow->etqf,
+			ethertype_flow->etqs);
+	if (idx == -EEXIST) {
+		return rte_flow_error_set(error, EEXIST,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Ethertype filter already exists");
+	}
+	if (idx == -ENOSPC) {
+		return rte_flow_error_set(error, ENOSPC,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Ethertype filters are full");
+	}
+	ethertype_flow->index = idx;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_ethertype_unregister(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct ixgbe_ethertype_flow *ethertype_flow = (struct ixgbe_ethertype_flow *)flow;
+	struct ixgbe_filter_info *filter_info =
+		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(flow->dev_data->dev_private);
+	int ret;
+
+	ret = ixgbe_ethertype_table_del(&filter_info->ethertype_table,
+			ethertype_flow->index);
+	if (ret != 0) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Ethertype filter slot not found on unregister");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_flow_ethertype_install(struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_ethertype_flow *ethertype_flow = (struct ixgbe_ethertype_flow *)flow;
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(flow->dev_data->dev_private);
+
+	ixgbe_ethertype_filter_program(hw, ethertype_flow->index,
+			ethertype_flow->etqf, ethertype_flow->etqs);
+
+	return 0;
+}
+
+static int
+ixgbe_flow_ethertype_uninstall(struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_ethertype_flow *ethertype_flow = (struct ixgbe_ethertype_flow *)flow;
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(flow->dev_data->dev_private);
+
+	ixgbe_ethertype_filter_program(hw, ethertype_flow->index, 0, 0);
+
+	return 0;
+}
+
+static int
+ixgbe_flow_ethertype_engine_init(const struct ci_flow_engine *engine __rte_unused,
+		struct rte_eth_dev_data *dev_data,
+		void *priv __rte_unused)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev_data->dev_private);
+
+	/* Ethertype filtering (ETQF) is only available on these MACs. */
+	if (hw->mac.type == ixgbe_mac_82599EB ||
+			hw->mac.type == ixgbe_mac_X540 ||
+			hw->mac.type == ixgbe_mac_X550 ||
+			hw->mac.type == ixgbe_mac_X550EM_x ||
+			hw->mac.type == ixgbe_mac_X550EM_a ||
+			hw->mac.type == ixgbe_mac_E610)
+		return 0;
+
+	return -ENOTSUP;
+}
+
+static const struct ci_flow_engine_ops ixgbe_ethertype_ops = {
+	.engine_init = ixgbe_flow_ethertype_engine_init,
+	.ctx_init = ixgbe_flow_ethertype_ctx_init,
+	.ctx_to_flow = ixgbe_flow_ethertype_ctx_to_flow,
+	.flow_register = ixgbe_flow_ethertype_register,
+	.flow_unregister = ixgbe_flow_ethertype_unregister,
+	.flow_install = ixgbe_flow_ethertype_install,
+	.flow_uninstall = ixgbe_flow_ethertype_uninstall,
+};
+
+const struct ci_flow_engine ixgbe_ethertype_flow_engine = {
+	.name = "ethertype",
+	.ctx_size = sizeof(struct ixgbe_ethertype_ctx),
+	.flow_size = sizeof(struct ixgbe_ethertype_flow),
+	.graph = &ixgbe_ethertype_graph,
+	.ops = &ixgbe_ethertype_ops,
+};
diff --git a/drivers/net/intel/ixgbe/ixgbe_pf.c b/drivers/net/intel/ixgbe/ixgbe_pf.c
index 939e7d1417..7616169e08 100644
--- a/drivers/net/intel/ixgbe/ixgbe_pf.c
+++ b/drivers/net/intel/ixgbe/ixgbe_pf.c
@@ -133,12 +133,24 @@ int ixgbe_pf_host_init(struct rte_eth_dev *eth_dev)
 
 void ixgbe_pf_host_uninit(struct rte_eth_dev *eth_dev)
 {
+	struct ixgbe_filter_info *filter_info =
+		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(eth_dev->data->dev_private);
+	struct ixgbe_hw *hw =
+		IXGBE_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
 	struct ixgbe_vf_info **vfinfo;
 	uint16_t vf_num;
 	int ret;
 
 	PMD_INIT_FUNC_TRACE();
 
+	/* release the Tx anti-spoof ETQF slot */
+	if (filter_info->antispoof_installed) {
+		ixgbe_ethertype_filter_program(hw, filter_info->antispoof_idx, 0, 0);
+		ixgbe_ethertype_table_del(&filter_info->ethertype_table,
+				filter_info->antispoof_idx);
+		filter_info->antispoof_installed = false;
+	}
+
 	RTE_ETH_DEV_SRIOV(eth_dev).active = 0;
 	RTE_ETH_DEV_SRIOV(eth_dev).nb_q_per_pool = 0;
 	RTE_ETH_DEV_SRIOV(eth_dev).def_vmdq_idx = 0;
@@ -168,38 +180,29 @@ ixgbe_add_tx_flow_control_drop_filter(struct rte_eth_dev *eth_dev)
 	struct ixgbe_filter_info *filter_info =
 		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(eth_dev->data->dev_private);
 	uint16_t vf_num;
+	uint32_t etqf, etqs;
 	int i;
-	struct ixgbe_ethertype_filter ethertype_filter;
 
 	if (!hw->mac.ops.set_ethertype_anti_spoofing) {
 		PMD_DRV_LOG(INFO, "ether type anti-spoofing is not supported.");
 		return;
 	}
 
-	i = ixgbe_ethertype_filter_lookup(filter_info,
-					  IXGBE_ETHERTYPE_FLOW_CTRL);
-	if (i >= 0) {
-		PMD_DRV_LOG(ERR, "A ether type filter entity for flow control already exists!");
-		return;
-	}
+	etqf = IXGBE_ETQF_FILTER_EN | IXGBE_ETQF_TX_ANTISPOOF |
+			IXGBE_ETHERTYPE_FLOW_CTRL;
+	etqs = 0;
+	if (!filter_info->antispoof_installed) {
+		int idx = ixgbe_ethertype_table_add(&filter_info->ethertype_table,
+				IXGBE_ETHERTYPE_FLOW_CTRL, etqf, etqs);
 
-	ethertype_filter.ethertype = IXGBE_ETHERTYPE_FLOW_CTRL;
-	ethertype_filter.etqf = IXGBE_ETQF_FILTER_EN |
-				IXGBE_ETQF_TX_ANTISPOOF |
-				IXGBE_ETHERTYPE_FLOW_CTRL;
-	ethertype_filter.etqs = 0;
-	ethertype_filter.conf = TRUE;
-	i = ixgbe_ethertype_filter_insert(filter_info,
-					  &ethertype_filter);
-	if (i < 0) {
-		PMD_DRV_LOG(ERR, "Cannot find an unused ether type filter entity for flow control.");
-		return;
+		if (idx < 0) {
+			PMD_DRV_LOG(ERR, "no free ETQF slot for Tx anti-spoof filter");
+			return;
+		}
+		filter_info->antispoof_idx = idx;
+		filter_info->antispoof_installed = true;
 	}
-
-	IXGBE_WRITE_REG(hw, IXGBE_ETQF(i),
-			(IXGBE_ETQF_FILTER_EN |
-			IXGBE_ETQF_TX_ANTISPOOF |
-			IXGBE_ETHERTYPE_FLOW_CTRL));
+	ixgbe_ethertype_filter_program(hw, filter_info->antispoof_idx, etqf, etqs);
 
 	vf_num = dev_num_vf(eth_dev);
 	for (i = 0; i < vf_num; i++)
diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
index 0531d37acd..f2857feab7 100644
--- a/drivers/net/intel/ixgbe/meson.build
+++ b/drivers/net/intel/ixgbe/meson.build
@@ -26,6 +26,7 @@ sources += files(
         'ixgbe_ethdev.c',
         'ixgbe_fdir.c',
         'ixgbe_flow.c',
+        'ixgbe_flow_ethertype.c',
         'ixgbe_ipsec.c',
         'ixgbe_pf.c',
         'ixgbe_rxtx.c',
-- 
2.52.0

