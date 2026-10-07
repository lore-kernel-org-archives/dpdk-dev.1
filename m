Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324F1CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 10:51:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C18D427C6;
	Wed,  7 Oct 2026 12:50:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 37076427A8
 for <dev@dpdk.org>; Wed,  7 Oct 2026 12:50:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791370239; x=1822906239;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=m5gsiVe92Ccvnvt0snLo/RkO4KZyUfN/69VsFwUN+i0=;
 b=bnHPmIzG3CNo/x5snqkPwsj+IDDI0Wlj62Dd0EMvta9meW8Ih63TVnbD
 SYU71P2fWE6R5/PcA4TTjGhJh9P2mXKCjrsIuZLfv9nwucbY45nC8zhMx
 zODO+et/hV+bd/EUSnsohXjzFPz3DT3J8j9vs1yCAZA2ssJlL5YmHD6Yy
 SGGKsp2IC2atoLnUMYvzsjdt7J7oWzhymcIn51m8mYBoofWDTGd2Yo/Cg
 GuXbTVUl/7C0Ho0DcPBKJ5f6QK42vKLLgkc/WcOJRjD7IFHMLH3IBoBx+
 U2MwEHefoFVTKLDycN+pkKQxCQYA2GbPTQQ17Hjf6dIuhCxE7CdUOWDpJ A==;
X-CSE-ConnectionGUID: 7A1fXQj+TcC5gHuJfX6lZg==
X-CSE-MsgGUID: bKBJMiLwRxOUOaoVLuN36Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="121814"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="121814"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 03:50:39 -0700
X-CSE-ConnectionGUID: T1WUSjJmSBSmS8eck0Mcew==
X-CSE-MsgGUID: s0n9jeVITzmwCck80WbfGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="280652088"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 07 Oct 2026 03:50:37 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Wei Zhao <wei.zhao1@intel.com>, Wenzhuo Lu <wenzhuo.lu@intel.com>,
 Beilei Xing <beilei.xing@intel.com>, Wei Dai <wei.dai@picocom.com>
Subject: [PATCH v5 06/25] net/ixgbe: make ethertype filter table dynamic
Date: Wed,  7 Oct 2026 11:50:01 +0100
Message-ID: <83cdc448391d50fc89bff30474fa6d6ac20f07c8.1791369980.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791369979.git.anatoly.burakov@intel.com>
 <cover.1791369979.git.anatoly.burakov@intel.com>
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
index 353fae87247..fc0276588b0 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -6856,77 +6856,99 @@ ixgbe_add_del_ntuple_filter(struct ixgbe_adapter *adapter,
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
 
@@ -7163,12 +7185,29 @@ static int
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
 
@@ -7186,10 +7225,7 @@ ixgbe_timesync_enable(struct rte_eth_dev *dev)
 	ixgbe_start_timecounters(dev);
 
 	/* Enable L2 filtering of IEEE1588/802.1AS Ethernet frame types. */
-	IXGBE_WRITE_REG(hw, IXGBE_ETQF(IXGBE_ETQF_FILTER_1588),
-			(RTE_ETHER_TYPE_1588 |
-			 IXGBE_ETQF_FILTER_EN |
-			 IXGBE_ETQF_1588));
+	ixgbe_ethertype_filter_program(hw, filter_info->timesync_idx, etqf, 0);
 
 	/* Enable timestamping of received PTP packets. */
 	tsync_ctl = IXGBE_READ_REG(hw, IXGBE_TSYNCRXCTL);
@@ -7213,6 +7249,8 @@ static int
 ixgbe_timesync_disable(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct ixgbe_filter_info *filter_info =
+		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
 	uint32_t tsync_ctl;
 
 	/* Disable timestamping of transmitted PTP packets. */
@@ -7226,7 +7264,12 @@ ixgbe_timesync_disable(struct rte_eth_dev *dev)
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
@@ -8381,13 +8424,14 @@ ixgbe_ethertype_filter_restore(struct rte_eth_dev *dev)
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
 
@@ -8495,14 +8539,13 @@ ixgbe_clear_all_ethertype_filter(struct rte_eth_dev *dev)
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
index 71dce0651dc..9aadcd4f7c7 100644
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
@@ -785,55 +795,4 @@ void ixgbe_dev_macsec_setting_save(struct rte_eth_dev *dev,
 
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

