Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCEBCA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 16:39:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25D6140DDD;
	Mon,  5 Oct 2026 18:38:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 6250640BA3
 for <dev@dpdk.org>; Mon,  5 Oct 2026 18:38:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791218322; x=1822754322;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=DLW5nzH3+ulqzuTpZDjLnhDpXZQhhT/NZmgRJhDx9bw=;
 b=e30EEufs+VdveIlnJaBSOn1rn+lI2DZBA8uZS24gLFCIvxRmoQhCxWPa
 R3ZJ2kHb9vBifnbjkSvCQhqi4wmE1Z4jYhYRMYSE8+5visx15rUiIT2Gi
 Sm2xXTQB9Ob1kiSzZp644q22pswoV0OzwpY+/jEC2wU7kHqXmO2zqvr4o
 HjHqrqA4NsFfjjlvQJRd8XLUBx3307fPyQpPuJ8FIWvsx3nLz5yV3vTjV
 esUoOZumeKBYRyNwcxljNUFsywgVfWNwv1q4i7W1rLAHPD3H1DadoIltW
 g4GR1oKjCxMYFyirFhTUVIehzGdf1IONj8wd2CtxXvsG+rt3dv6vAwkuL w==;
X-CSE-ConnectionGUID: R3E6hnsKR7mbw3stgJGbfw==
X-CSE-MsgGUID: hxGjjAwORCOuA9U5jG7tUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="90665287"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="90665287"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 09:38:42 -0700
X-CSE-ConnectionGUID: mx8f194IS1ynwBysYJXZ9g==
X-CSE-MsgGUID: U8gtTd+dSf+glp96K2ckfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="945709"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa011.fm.intel.com with ESMTP; 05 Oct 2026 09:38:41 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Wei Dai <wei.dai@picocom.com>, Wei Zhao <wei.zhao1@intel.com>,
 Wenzhuo Lu <wenzhuo.lu@intel.com>, Beilei Xing <beilei.xing@intel.com>
Subject: [PATCH v4 06/24] net/ixgbe: make ethertype filter table dynamic
Date: Mon,  5 Oct 2026 17:38:01 +0100
Message-ID: <436f0ba60dbec12636977277aed12e022762da59.1791218155.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791218154.git.anatoly.burakov@intel.com>
 <cover.1791218154.git.anatoly.burakov@intel.com>
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

Currently, when installing Ethertype filters, some of the filters will be
installed at a fixed offset into the Ethertype filter table (such as
timesync filter), which interferes with rte_flow-provided Ethertype flows
which install into "first available slot" without checking if the slot was
actually "available".

Rework the Ethertype filter infrastructure to reserve Ethertype filter
slots dynamically in a centralized manner, so that timesync, anti-spoof,
and rte_flow provided Ethertype filters do not step on each others' toes.

Fixes: 72c135a89f80 ("net/ixgbe: create consistent filter")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 205 +++++++++++++++----------
 drivers/net/intel/ixgbe/ixgbe_ethdev.h |  85 +++-------
 drivers/net/intel/ixgbe/ixgbe_pf.c     |  49 +++---
 3 files changed, 172 insertions(+), 167 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 14e4bb7c1d3..56dbf288a94 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -6841,77 +6841,99 @@ ixgbe_add_del_ntuple_filter(struct ixgbe_adapter *adapter,
 	return 0;
 }
 
+void
+ixgbe_ethertype_filter_program(struct ixgbe_hw *hw, uint8_t idx,
+			uint32_t etqf, uint32_t etqs)
+{
+	IXGBE_WRITE_REG(hw, IXGBE_ETQF(idx), etqf);
+	IXGBE_WRITE_REG(hw, IXGBE_ETQS(idx), etqs);
+	IXGBE_WRITE_FLUSH(hw);
+}
+
+static int
+ixgbe_ethertype_table_lookup(const struct ixgbe_ethertype_table *table,
+			uint16_t ethertype)
+{
+	int idx;
+
+	for (idx = 0; idx < IXGBE_MAX_ETQF_FILTERS; idx++) {
+		if (table->entries[idx].used &&
+				table->entries[idx].ethertype == ethertype)
+			return idx;
+	}
+	return -ENOENT;
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
+		if (table->entries[i].used) {
+			if (table->entries[i].ethertype == ethertype)
+				return -EEXIST;
+		} else if (free_idx < 0) {
+			free_idx = i;
+		}
+	}
+	if (free_idx < 0)
+		return -ENOSPC;
+
+	table->entries[free_idx].ethertype = ethertype;
+	table->entries[free_idx].etqf = etqf;
+	table->entries[free_idx].etqs = etqs;
+	table->entries[free_idx].used = true;
+
+	return free_idx;
+}
+
+int
+ixgbe_ethertype_table_del(struct ixgbe_ethertype_table *table, uint8_t idx)
+{
+	if (idx >= IXGBE_MAX_ETQF_FILTERS || !table->entries[idx].used)
+		return -ENOENT;
+
+	table->entries[idx] = (struct ixgbe_ethertype_entry){0};
+
+	return 0;
+}
+
 int
 ixgbe_add_del_ethertype_filter(struct ixgbe_adapter *adapter,
-			struct rte_eth_ethertype_filter *filter,
-			bool add)
+			struct rte_eth_ethertype_filter *filter, bool add)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
-	struct ixgbe_filter_info *filter_info =
-		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(adapter);
-	uint32_t etqf = 0;
-	uint32_t etqs = 0;
-	int ret;
-	struct ixgbe_ethertype_filter ethertype_filter;
+	struct ixgbe_ethertype_table *table =
+		&IXGBE_DEV_PRIVATE_TO_FILTER_INFO(adapter)->ethertype_table;
+	uint32_t etqf, etqs;
+	int idx;
 
-	if (filter->queue >= IXGBE_MAX_RX_QUEUE_NUM)
+	if (filter->queue >= IXGBE_MAX_RX_QUEUE_NUM ||
+		filter->ether_type == RTE_ETHER_TYPE_IPV4 ||
+		filter->ether_type == RTE_ETHER_TYPE_IPV6 ||
+		filter->flags & (RTE_ETHTYPE_FLAGS_MAC | RTE_ETHTYPE_FLAGS_DROP))
 		return -EINVAL;
 
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
 	if (add) {
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
+		etqf = IXGBE_ETQF_FILTER_EN | filter->ether_type;
+		etqs = IXGBE_ETQS_QUEUE_EN |
+			(((uint32_t)filter->queue << IXGBE_ETQS_RX_QUEUE_SHIFT) &
+			IXGBE_ETQS_RX_QUEUE);
+		idx = ixgbe_ethertype_table_add(table, filter->ether_type, etqf, etqs);
+		if (idx < 0)
+			return idx;
 	} else {
-		ret = ixgbe_ethertype_filter_remove(filter_info, (uint8_t)ret);
-		if (ret < 0)
-			return -ENOSYS;
+		idx = ixgbe_ethertype_table_lookup(table, filter->ether_type);
+		if (idx < 0)
+			return idx;
+		ixgbe_ethertype_table_del(table, idx);
+		etqf = 0;
+		etqs = 0;
 	}
-	IXGBE_WRITE_REG(hw, IXGBE_ETQF(ret), etqf);
-	IXGBE_WRITE_REG(hw, IXGBE_ETQS(ret), etqs);
-	IXGBE_WRITE_FLUSH(hw);
-
+	ixgbe_ethertype_filter_program(hw, idx, etqf, etqs);
 	return 0;
 }
 
@@ -7148,12 +7170,29 @@ static int
 ixgbe_timesync_enable(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct ixgbe_filter_info *filter_info =
+		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
 	uint32_t tsync_ctl;
 	uint32_t tsauxc;
+	uint32_t etqf;
 	struct timespec ts;
+	int idx;
 
 	memset(&ts, 0, sizeof(struct timespec));
 
+	/* Reserve the shared ETQF slot before changing timestamp hardware. */
+	etqf = RTE_ETHER_TYPE_1588 | IXGBE_ETQF_FILTER_EN | IXGBE_ETQF_1588;
+	if (!filter_info->timesync_installed) {
+		idx = ixgbe_ethertype_table_add(&filter_info->ethertype_table,
+				RTE_ETHER_TYPE_1588, etqf, 0);
+		if (idx < 0) {
+			PMD_DRV_LOG(ERR, "no free ETQF slot for 1588 timestamping");
+			return idx;
+		}
+		filter_info->timesync_idx = idx;
+		filter_info->timesync_installed = true;
+	}
+
 	/* get current system time */
 	clock_gettime(CLOCK_REALTIME, &ts);
 
@@ -7171,10 +7210,7 @@ ixgbe_timesync_enable(struct rte_eth_dev *dev)
 	ixgbe_start_timecounters(dev);
 
 	/* Enable L2 filtering of IEEE1588/802.1AS Ethernet frame types. */
-	IXGBE_WRITE_REG(hw, IXGBE_ETQF(IXGBE_ETQF_FILTER_1588),
-			(RTE_ETHER_TYPE_1588 |
-			 IXGBE_ETQF_FILTER_EN |
-			 IXGBE_ETQF_1588));
+	ixgbe_ethertype_filter_program(hw, filter_info->timesync_idx, etqf, 0);
 
 	/* Enable timestamping of received PTP packets. */
 	tsync_ctl = IXGBE_READ_REG(hw, IXGBE_TSYNCRXCTL);
@@ -7198,6 +7234,8 @@ static int
 ixgbe_timesync_disable(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct ixgbe_filter_info *filter_info =
+		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
 	uint32_t tsync_ctl;
 
 	/* Disable timestamping of transmitted PTP packets. */
@@ -7211,7 +7249,12 @@ ixgbe_timesync_disable(struct rte_eth_dev *dev)
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
@@ -8366,13 +8409,14 @@ ixgbe_ethertype_filter_restore(struct rte_eth_dev *dev)
 	int i;
 
 	for (i = 0; i < IXGBE_MAX_ETQF_FILTERS; i++) {
-		if (filter_info->ethertype_mask & (1 << i)) {
-			IXGBE_WRITE_REG(hw, IXGBE_ETQF(i),
-					filter_info->ethertype_filters[i].etqf);
-			IXGBE_WRITE_REG(hw, IXGBE_ETQS(i),
-					filter_info->ethertype_filters[i].etqs);
-			IXGBE_WRITE_FLUSH(hw);
-		}
+		/* skip over entries not managed by rte_flow */
+		if (i == filter_info->timesync_idx ||
+				i == filter_info->antispoof_idx||
+				!filter_info->ethertype_table.entries[i].used)
+			continue;
+		ixgbe_ethertype_filter_program(hw, i,
+			filter_info->ethertype_table.entries[i].etqf,
+			filter_info->ethertype_table.entries[i].etqs);
 	}
 }
 
@@ -8480,14 +8524,13 @@ ixgbe_clear_all_ethertype_filter(struct rte_eth_dev *dev)
 	int i;
 
 	for (i = 0; i < IXGBE_MAX_ETQF_FILTERS; i++) {
-		if (filter_info->ethertype_mask & (1 << i) &&
-		    !filter_info->ethertype_filters[i].conf) {
-			(void)ixgbe_ethertype_filter_remove(filter_info,
-							    (uint8_t)i);
-			IXGBE_WRITE_REG(hw, IXGBE_ETQF(i), 0);
-			IXGBE_WRITE_REG(hw, IXGBE_ETQS(i), 0);
-			IXGBE_WRITE_FLUSH(hw);
-		}
+		/* only clear rte_flow filters */
+		if (!filter_info->ethertype_table.entries[i].used ||
+			(filter_info->timesync_installed && i == filter_info->timesync_idx) ||
+			(filter_info->antispoof_installed && i == filter_info->antispoof_idx))
+			continue;
+		ixgbe_ethertype_table_del(&filter_info->ethertype_table, i);
+		ixgbe_ethertype_filter_program(hw, i, 0, 0);
 	}
 }
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 04b449fb70d..fd819490f32 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -294,24 +294,20 @@ struct ixgbe_5tuple_filter {
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
+	struct ixgbe_ethertype_entry {
+		bool used; /* slot is allocated */
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
@@ -319,6 +315,14 @@ struct ixgbe_filter_info {
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
@@ -679,6 +683,12 @@ int ixgbe_syn_filter_set(struct ixgbe_adapter *adapter,
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
@@ -784,55 +794,4 @@ void ixgbe_dev_macsec_setting_save(struct rte_eth_dev *dev,
 
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
diff --git a/drivers/net/intel/ixgbe/ixgbe_pf.c b/drivers/net/intel/ixgbe/ixgbe_pf.c
index 939e7d1417d..7616169e086 100644
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
-- 
2.52.0

