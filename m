Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C1CCA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 16:40:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56F7740E37;
	Mon,  5 Oct 2026 18:38:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id ECF2840E2E
 for <dev@dpdk.org>; Mon,  5 Oct 2026 18:38:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791218331; x=1822754331;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ZD432mn/X0YDlcVKhmJkmVqI/igftl0OuoBFZWE9PVw=;
 b=GHiWFVKo0BpFhiHI2g331WEjnaxxrlcCWKTr0AW/yHFcL+eT5S3/1/2/
 OFti0TicVTXikm/7UduEr1t2qnk1Jgg8BTdTZnJH5rwwpGi2DJLyDrHo+
 c5ddGYRrDR1xRIjuZdRJaGtoPS4QIv7dBl/ves5oMFQktE70HUvXu1d2F
 DHiYau7T/1H1xmkM6/iR4bAw+mE69Qws6W8gsHUUGLG5M7vqetwjC6sqT
 K7uw8UskAcNGQOedl1oUoWV1UGDvlBpJBHy1FMM/y7UfmJER8L1ZdLh1j
 FJBc71YHM+PHkNUWSkT88zp/RKfhEQLGiSNW4XxIe6QBZphyVdx+VH33J Q==;
X-CSE-ConnectionGUID: LNo8BfADS+GX4k7CP2/fxQ==
X-CSE-MsgGUID: lNJULe2cQ7m3gv6Tg1utyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="90665316"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="90665316"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 09:38:50 -0700
X-CSE-ConnectionGUID: 8bnRLA2fRkG6oAALSiD5sQ==
X-CSE-MsgGUID: QKq60UnOSuqeZUrjNl4IIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="945752"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa011.fm.intel.com with ESMTP; 05 Oct 2026 09:38:49 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 12/24] net/ixgbe: reimplement ntuple parser
Date: Mon,  5 Oct 2026 17:38:07 +0100
Message-ID: <b2d8f06b78a201f3b78ee0bb25641b56b36e43df.1791218156.git.anatoly.burakov@intel.com>
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

Use the new flow graph API and the common parsing framework to implement
flow parser for ntuple.

The 5tuple filter tracking infrastructure is moved completely inside the
new engine and is removed from the rest of the driver.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c      | 348 +---------
 drivers/net/intel/ixgbe/ixgbe_ethdev.h      |  28 +-
 drivers/net/intel/ixgbe/ixgbe_flow.c        | 478 +-------------
 drivers/net/intel/ixgbe/ixgbe_flow.h        |   1 +
 drivers/net/intel/ixgbe/ixgbe_flow_ntuple.c | 694 ++++++++++++++++++++
 drivers/net/intel/ixgbe/meson.build         |   1 +
 6 files changed, 724 insertions(+), 826 deletions(-)
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_ntuple.c

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index c8821a34112..db5e36adcc9 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -150,7 +150,6 @@ static int eth_ixgbe_dev_uninit(struct rte_eth_dev *eth_dev);
 static int ixgbe_fdir_filter_init(struct rte_eth_dev *eth_dev);
 static int ixgbe_fdir_filter_uninit(struct rte_eth_dev *eth_dev);
 static int ixgbe_l2_tn_filter_init(struct rte_eth_dev *eth_dev);
-static int ixgbe_ntuple_filter_uninit(struct rte_eth_dev *eth_dev);
 static int ixgbe_dev_configure(struct rte_eth_dev *dev);
 static int ixgbe_dev_start(struct rte_eth_dev *dev);
 static int ixgbe_dev_stop(struct rte_eth_dev *dev);
@@ -301,10 +300,6 @@ static int ixgbevf_add_mac_addr(struct rte_eth_dev *dev,
 static void ixgbevf_remove_mac_addr(struct rte_eth_dev *dev, uint32_t index);
 static int ixgbevf_set_default_mac_addr(struct rte_eth_dev *dev,
 					     struct rte_ether_addr *mac_addr);
-static int ixgbe_add_5tuple_filter(struct ixgbe_adapter *adapter,
-			struct ixgbe_5tuple_filter *filter);
-static void ixgbe_remove_5tuple_filter(struct ixgbe_adapter *adapter,
-			struct ixgbe_5tuple_filter *filter);
 static int ixgbe_dev_flow_ops_get(struct rte_eth_dev *dev,
 				  const struct rte_flow_ops **ops);
 static int ixgbevf_dev_set_mtu(struct rte_eth_dev *dev, uint16_t mtu);
@@ -1266,9 +1261,6 @@ eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 	memset(filter_info, 0,
 	       sizeof(struct ixgbe_filter_info));
 
-	/* initialize 5tuple filter list */
-	TAILQ_INIT(&filter_info->fivetuple_list);
-
 	/* initialize flow director filter list & hash */
 	ret = ixgbe_fdir_filter_init(eth_dev);
 	if (ret)
@@ -1328,24 +1320,6 @@ eth_ixgbe_dev_uninit(struct rte_eth_dev *eth_dev)
 	return 0;
 }
 
-static int ixgbe_ntuple_filter_uninit(struct rte_eth_dev *eth_dev)
-{
-	struct ixgbe_filter_info *filter_info =
-		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(eth_dev->data->dev_private);
-	struct ixgbe_5tuple_filter *p_5tuple;
-
-	while ((p_5tuple = TAILQ_FIRST(&filter_info->fivetuple_list))) {
-		TAILQ_REMOVE(&filter_info->fivetuple_list,
-			     p_5tuple,
-			     entries);
-		rte_free(p_5tuple);
-	}
-	memset(filter_info->fivetuple_mask, 0,
-	       sizeof(uint32_t) * IXGBE_5TUPLE_ARRAY_SIZE);
-
-	return 0;
-}
-
 static int ixgbe_fdir_filter_uninit(struct rte_eth_dev *eth_dev)
 {
 	struct ixgbe_hw_fdir_info *fdir_info =
@@ -3051,9 +3025,6 @@ ixgbe_dev_close(struct rte_eth_dev *dev)
 	/* remove all the fdir filters & hash */
 	ixgbe_fdir_filter_uninit(dev);
 
-	/* Remove all ntuple filters of the device */
-	ixgbe_ntuple_filter_uninit(dev);
-
 	/* clear all the filters list */
 	ixgbe_filterlist_flush(dev);
 
@@ -6418,134 +6389,50 @@ ixgbe_syn_filter_program(struct ixgbe_hw *hw, uint32_t synqf)
 	IXGBE_WRITE_FLUSH(hw);
 }
 
-
-static inline enum ixgbe_5tuple_protocol
-convert_protocol_type(uint8_t protocol_value)
+/* program a single ntuple (5-tuple) filter slot into hardware */
+void
+ixgbe_ntuple_filter_program(struct ixgbe_hw *hw, uint16_t index,
+			const struct ixgbe_5tuple_filter_info *filter_info,
+			uint16_t queue)
 {
-	if (protocol_value == IPPROTO_TCP)
-		return IXGBE_FILTER_PROTOCOL_TCP;
-	else if (protocol_value == IPPROTO_UDP)
-		return IXGBE_FILTER_PROTOCOL_UDP;
-	else if (protocol_value == IPPROTO_SCTP)
-		return IXGBE_FILTER_PROTOCOL_SCTP;
-	else
-		return IXGBE_FILTER_PROTOCOL_NONE;
-}
-
-/* inject a 5-tuple filter to HW */
-static inline void
-ixgbe_inject_5tuple_filter(struct ixgbe_adapter *adapter,
-			   struct ixgbe_5tuple_filter *filter)
-{
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
-	int i;
 	uint32_t ftqf, sdpqf;
 	uint32_t l34timir = 0;
 	uint8_t mask = 0xff;
 
-	i = filter->index;
+	sdpqf = (uint32_t)(filter_info->dst_port << IXGBE_SDPQF_DSTPORT_SHIFT);
+	sdpqf = sdpqf | (filter_info->src_port & IXGBE_SDPQF_SRCPORT);
 
-	sdpqf = (uint32_t)(filter->filter_info.dst_port <<
-				IXGBE_SDPQF_DSTPORT_SHIFT);
-	sdpqf = sdpqf | (filter->filter_info.src_port & IXGBE_SDPQF_SRCPORT);
-
-	ftqf = (uint32_t)(filter->filter_info.proto &
-		IXGBE_FTQF_PROTOCOL_MASK);
-	ftqf |= (uint32_t)((filter->filter_info.priority &
+	ftqf = (uint32_t)(filter_info->proto & IXGBE_FTQF_PROTOCOL_MASK);
+	ftqf |= (uint32_t)((filter_info->priority &
 		IXGBE_FTQF_PRIORITY_MASK) << IXGBE_FTQF_PRIORITY_SHIFT);
-	if (filter->filter_info.src_ip_mask == 0) /* 0 means compare. */
+	if (filter_info->src_ip_mask == 0) /* 0 means compare. */
 		mask &= IXGBE_FTQF_SOURCE_ADDR_MASK;
-	if (filter->filter_info.dst_ip_mask == 0)
+	if (filter_info->dst_ip_mask == 0)
 		mask &= IXGBE_FTQF_DEST_ADDR_MASK;
-	if (filter->filter_info.src_port_mask == 0)
+	if (filter_info->src_port_mask == 0)
 		mask &= IXGBE_FTQF_SOURCE_PORT_MASK;
-	if (filter->filter_info.dst_port_mask == 0)
+	if (filter_info->dst_port_mask == 0)
 		mask &= IXGBE_FTQF_DEST_PORT_MASK;
-	if (filter->filter_info.proto_mask == 0)
+	if (filter_info->proto_mask == 0)
 		mask &= IXGBE_FTQF_PROTOCOL_COMP_MASK;
 	ftqf |= mask << IXGBE_FTQF_5TUPLE_MASK_SHIFT;
 	ftqf |= IXGBE_FTQF_POOL_MASK_EN;
 	ftqf |= IXGBE_FTQF_QUEUE_ENABLE;
 
-	IXGBE_WRITE_REG(hw, IXGBE_DAQF(i), filter->filter_info.dst_ip);
-	IXGBE_WRITE_REG(hw, IXGBE_SAQF(i), filter->filter_info.src_ip);
-	IXGBE_WRITE_REG(hw, IXGBE_SDPQF(i), sdpqf);
-	IXGBE_WRITE_REG(hw, IXGBE_FTQF(i), ftqf);
+	IXGBE_WRITE_REG(hw, IXGBE_DAQF(index), filter_info->dst_ip);
+	IXGBE_WRITE_REG(hw, IXGBE_SAQF(index), filter_info->src_ip);
+	IXGBE_WRITE_REG(hw, IXGBE_SDPQF(index), sdpqf);
+	IXGBE_WRITE_REG(hw, IXGBE_FTQF(index), ftqf);
 
 	l34timir |= IXGBE_L34T_IMIR_RESERVE;
-	l34timir |= (uint32_t)(filter->queue <<
-				IXGBE_L34T_IMIR_QUEUE_SHIFT);
-	IXGBE_WRITE_REG(hw, IXGBE_L34T_IMIR(i), l34timir);
+	l34timir |= (uint32_t)(queue << IXGBE_L34T_IMIR_QUEUE_SHIFT);
+	IXGBE_WRITE_REG(hw, IXGBE_L34T_IMIR(index), l34timir);
 }
 
-/*
- * add a 5tuple filter
- *
- * @param
- * dev: Pointer to struct rte_eth_dev.
- * index: the index the filter allocates.
- * filter: pointer to the filter that will be added.
- * rx_queue: the queue id the filter assigned to.
- *
- * @return
- *    - On success, zero.
- *    - On failure, a negative value.
- */
-static int
-ixgbe_add_5tuple_filter(struct ixgbe_adapter *adapter,
-			struct ixgbe_5tuple_filter *filter)
+/* clear a single ntuple (5-tuple) filter slot from hardware */
+void
+ixgbe_ntuple_filter_clear(struct ixgbe_hw *hw, uint16_t index)
 {
-	struct ixgbe_filter_info *filter_info =
-		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(adapter);
-	int i, idx, shift;
-
-	/*
-	 * look for an unused 5tuple filter index,
-	 * and insert the filter to list.
-	 */
-	for (i = 0; i < IXGBE_MAX_FTQF_FILTERS; i++) {
-		idx = i / (sizeof(uint32_t) * NBBY);
-		shift = i % (sizeof(uint32_t) * NBBY);
-		if (!(filter_info->fivetuple_mask[idx] & (1 << shift))) {
-			filter_info->fivetuple_mask[idx] |= 1 << shift;
-			filter->index = i;
-			TAILQ_INSERT_TAIL(&filter_info->fivetuple_list,
-					  filter,
-					  entries);
-			break;
-		}
-	}
-	if (i >= IXGBE_MAX_FTQF_FILTERS) {
-		PMD_DRV_LOG(ERR, "5tuple filters are full.");
-		return -ENOSYS;
-	}
-
-	ixgbe_inject_5tuple_filter(adapter, filter);
-
-	return 0;
-}
-
-/*
- * remove a 5tuple filter
- *
- * @param
- * dev: Pointer to struct rte_eth_dev.
- * filter: the pointer of the filter will be removed.
- */
-static void
-ixgbe_remove_5tuple_filter(struct ixgbe_adapter *adapter,
-			struct ixgbe_5tuple_filter *filter)
-{
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
-	struct ixgbe_filter_info *filter_info =
-		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(adapter);
-	uint16_t index = filter->index;
-
-	filter_info->fivetuple_mask[index / (sizeof(uint32_t) * NBBY)] &=
-				~(1 << (index % (sizeof(uint32_t) * NBBY)));
-	TAILQ_REMOVE(&filter_info->fivetuple_list, filter, entries);
-	rte_free(filter);
-
 	IXGBE_WRITE_REG(hw, IXGBE_DAQF(index), 0);
 	IXGBE_WRITE_REG(hw, IXGBE_SAQF(index), 0);
 	IXGBE_WRITE_REG(hw, IXGBE_SDPQF(index), 0);
@@ -6598,165 +6485,6 @@ ixgbevf_dev_set_mtu(struct rte_eth_dev *dev, uint16_t mtu)
 	return 0;
 }
 
-static inline struct ixgbe_5tuple_filter *
-ixgbe_5tuple_filter_lookup(struct ixgbe_5tuple_filter_list *filter_list,
-			struct ixgbe_5tuple_filter_info *key)
-{
-	struct ixgbe_5tuple_filter *it;
-
-	TAILQ_FOREACH(it, filter_list, entries) {
-		if (memcmp(key, &it->filter_info,
-			sizeof(struct ixgbe_5tuple_filter_info)) == 0) {
-			return it;
-		}
-	}
-	return NULL;
-}
-
-/* translate elements in struct rte_eth_ntuple_filter to struct ixgbe_5tuple_filter_info*/
-static inline int
-ntuple_filter_to_5tuple(struct rte_eth_ntuple_filter *filter,
-			struct ixgbe_5tuple_filter_info *filter_info)
-{
-	if (filter->queue >= IXGBE_MAX_RX_QUEUE_NUM ||
-		filter->priority > IXGBE_5TUPLE_MAX_PRI ||
-		filter->priority < IXGBE_5TUPLE_MIN_PRI)
-		return -EINVAL;
-
-	switch (filter->dst_ip_mask) {
-	case UINT32_MAX:
-		filter_info->dst_ip_mask = 0;
-		filter_info->dst_ip = filter->dst_ip;
-		break;
-	case 0:
-		filter_info->dst_ip_mask = 1;
-		break;
-	default:
-		PMD_DRV_LOG(ERR, "invalid dst_ip mask.");
-		return -EINVAL;
-	}
-
-	switch (filter->src_ip_mask) {
-	case UINT32_MAX:
-		filter_info->src_ip_mask = 0;
-		filter_info->src_ip = filter->src_ip;
-		break;
-	case 0:
-		filter_info->src_ip_mask = 1;
-		break;
-	default:
-		PMD_DRV_LOG(ERR, "invalid src_ip mask.");
-		return -EINVAL;
-	}
-
-	switch (filter->dst_port_mask) {
-	case UINT16_MAX:
-		filter_info->dst_port_mask = 0;
-		filter_info->dst_port = filter->dst_port;
-		break;
-	case 0:
-		filter_info->dst_port_mask = 1;
-		break;
-	default:
-		PMD_DRV_LOG(ERR, "invalid dst_port mask.");
-		return -EINVAL;
-	}
-
-	switch (filter->src_port_mask) {
-	case UINT16_MAX:
-		filter_info->src_port_mask = 0;
-		filter_info->src_port = filter->src_port;
-		break;
-	case 0:
-		filter_info->src_port_mask = 1;
-		break;
-	default:
-		PMD_DRV_LOG(ERR, "invalid src_port mask.");
-		return -EINVAL;
-	}
-
-	switch (filter->proto_mask) {
-	case UINT8_MAX:
-		filter_info->proto_mask = 0;
-		filter_info->proto =
-			convert_protocol_type(filter->proto);
-		break;
-	case 0:
-		filter_info->proto_mask = 1;
-		break;
-	default:
-		PMD_DRV_LOG(ERR, "invalid protocol mask.");
-		return -EINVAL;
-	}
-
-	filter_info->priority = (uint8_t)filter->priority;
-	return 0;
-}
-
-/*
- * add or delete a ntuple filter
- *
- * @param
- * dev: Pointer to struct rte_eth_dev.
- * ntuple_filter: Pointer to struct rte_eth_ntuple_filter
- * add: if true, add filter, if false, remove filter
- *
- * @return
- *    - On success, zero.
- *    - On failure, a negative value.
- */
-int
-ixgbe_add_del_ntuple_filter(struct ixgbe_adapter *adapter,
-			struct rte_eth_ntuple_filter *ntuple_filter,
-			bool add)
-{
-	struct ixgbe_filter_info *filter_info =
-		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(adapter);
-	struct ixgbe_5tuple_filter_info filter_5tuple;
-	struct ixgbe_5tuple_filter *filter;
-	int ret;
-
-	if (ntuple_filter->flags != RTE_5TUPLE_FLAGS) {
-		PMD_DRV_LOG(ERR, "only 5tuple is supported.");
-		return -EINVAL;
-	}
-
-	memset(&filter_5tuple, 0, sizeof(struct ixgbe_5tuple_filter_info));
-	ret = ntuple_filter_to_5tuple(ntuple_filter, &filter_5tuple);
-	if (ret < 0)
-		return ret;
-
-	filter = ixgbe_5tuple_filter_lookup(&filter_info->fivetuple_list,
-					 &filter_5tuple);
-	if (filter != NULL && add) {
-		PMD_DRV_LOG(ERR, "filter exists.");
-		return -EEXIST;
-	}
-	if (filter == NULL && !add) {
-		PMD_DRV_LOG(ERR, "filter doesn't exist.");
-		return -ENOENT;
-	}
-
-	if (add) {
-		filter = rte_zmalloc("ixgbe_5tuple_filter",
-				sizeof(struct ixgbe_5tuple_filter), 0);
-		if (filter == NULL)
-			return -ENOMEM;
-		memcpy(&filter->filter_info,
-				 &filter_5tuple,
-				 sizeof(struct ixgbe_5tuple_filter_info));
-		filter->queue = ntuple_filter->queue;
-		ret = ixgbe_add_5tuple_filter(adapter, filter);
-		if (ret < 0) {
-			rte_free(filter);
-			return ret;
-		}
-	} else
-		ixgbe_remove_5tuple_filter(adapter, filter);
-
-	return 0;
-}
-
 void
 ixgbe_ethertype_filter_program(struct ixgbe_hw *hw, uint8_t idx,
 			uint32_t etqf, uint32_t etqs)
@@ -8102,21 +7830,6 @@ int ixgbe_enable_sec_tx_path_generic(struct ixgbe_hw *hw)
 	return IXGBE_SUCCESS;
 }
 
-/* restore n-tuple filter */
-static inline void
-ixgbe_ntuple_filter_restore(struct rte_eth_dev *dev)
-{
-	struct ixgbe_adapter *adapter =
-		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct ixgbe_filter_info *filter_info =
-		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
-	struct ixgbe_5tuple_filter *node;
-
-	TAILQ_FOREACH(node, &filter_info->fivetuple_list, entries) {
-		ixgbe_inject_5tuple_filter(adapter, node);
-	}
-}
-
 /* restore rss filter */
 static inline void
 ixgbe_rss_filter_restore(struct rte_eth_dev *dev)
@@ -8134,7 +7847,6 @@ ixgbe_rss_filter_restore(struct rte_eth_dev *dev)
 static int
 ixgbe_filter_restore(struct rte_eth_dev *dev)
 {
-	ixgbe_ntuple_filter_restore(dev);
 	ixgbe_fdir_filter_restore(dev);
 	ixgbe_rss_filter_restore(dev);
 
@@ -8157,20 +7869,6 @@ ixgbe_l2_tunnel_conf(struct rte_eth_dev *dev)
 	(void)ixgbe_update_e_tag_eth_type(hw, l2_tn_info->e_tag_ether_type);
 }
 
-/* remove all the n-tuple filters */
-void
-ixgbe_clear_all_ntuple_filter(struct rte_eth_dev *dev)
-{
-	struct ixgbe_adapter *adapter =
-		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct ixgbe_filter_info *filter_info =
-		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
-	struct ixgbe_5tuple_filter *p_5tuple;
-
-	while ((p_5tuple = TAILQ_FIRST(&filter_info->fivetuple_list)))
-		ixgbe_remove_5tuple_filter(adapter, p_5tuple);
-}
-
 void
 ixgbe_dev_macsec_setting_save(struct rte_eth_dev *dev,
 				struct ixgbe_macsec_setting *macsec_setting)
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index a28d1bba3b7..daab7fb0d5a 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -100,8 +100,6 @@
 #define IXGBE_L34T_IMIR_LLI             0x00100000
 #define IXGBE_L34T_IMIR_QUEUE           0x0FE00000
 #define IXGBE_L34T_IMIR_QUEUE_SHIFT     21
-#define IXGBE_5TUPLE_MAX_PRI            7
-#define IXGBE_5TUPLE_MIN_PRI            1
 
 /* The overhead from MTU to max frame size. */
 #define IXGBE_ETH_OVERHEAD (RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN)
@@ -265,8 +263,6 @@ enum ixgbe_5tuple_protocol {
 	IXGBE_FILTER_PROTOCOL_NONE,
 };
 
-TAILQ_HEAD(ixgbe_5tuple_filter_list, ixgbe_5tuple_filter);
-
 struct ixgbe_5tuple_filter_info {
 	uint32_t dst_ip;
 	uint32_t src_ip;
@@ -282,18 +278,6 @@ struct ixgbe_5tuple_filter_info {
 		proto_mask:1;    /* if mask is 1b, do not compare protocol. */
 };
 
-/* 5tuple filter structure */
-struct ixgbe_5tuple_filter {
-	TAILQ_ENTRY(ixgbe_5tuple_filter) entries;
-	uint16_t index;       /* the index of 5tuple filter */
-	struct ixgbe_5tuple_filter_info filter_info;
-	uint16_t queue;       /* rx queue assigned to */
-};
-
-#define IXGBE_5TUPLE_ARRAY_SIZE \
-	(RTE_ALIGN(IXGBE_MAX_FTQF_FILTERS, (sizeof(uint32_t) * NBBY)) / \
-	 (sizeof(uint32_t) * NBBY))
-
 /* Shared EtherType (ETQF) filter table. */
 struct ixgbe_ethertype_table {
 	struct ixgbe_ethertype_entry {
@@ -308,9 +292,6 @@ struct ixgbe_ethertype_table {
  * Structure to store filters' info.
  */
 struct ixgbe_filter_info {
-	/* Bit mask for every used 5tuple filter */
-	uint32_t fivetuple_mask[IXGBE_5TUPLE_ARRAY_SIZE];
-	struct ixgbe_5tuple_filter_list fivetuple_list;
 	/* store the rss filter info */
 	struct ixgbe_rte_flow_rss_conf rss_info;
 	/* shared EtherType (ETQF) slot table */
@@ -655,9 +636,10 @@ uint32_t ixgbe_rssrk_reg_get(enum ixgbe_mac_type mac_type, uint8_t i);
 
 bool ixgbe_rss_update_sp(enum ixgbe_mac_type mac_type);
 
-int ixgbe_add_del_ntuple_filter(struct ixgbe_adapter *adapter,
-			struct rte_eth_ntuple_filter *filter,
-			bool add);
+void ixgbe_ntuple_filter_program(struct ixgbe_hw *hw, uint16_t index,
+			const struct ixgbe_5tuple_filter_info *filter_info,
+			uint16_t queue);
+void ixgbe_ntuple_filter_clear(struct ixgbe_hw *hw, uint16_t index);
 
 void ixgbe_ethertype_filter_program(struct ixgbe_hw *hw, uint8_t idx,
 			uint32_t etqf, uint32_t etqs);
@@ -735,8 +717,6 @@ int ixgbe_clear_all_fdir_filter(struct rte_eth_dev *dev);
 
 extern const struct rte_flow_ops ixgbe_flow_ops;
 
-void ixgbe_clear_all_ntuple_filter(struct rte_eth_dev *dev);
-
 int ixgbe_disable_sec_tx_path_generic(struct ixgbe_hw *hw);
 
 int ixgbe_enable_sec_tx_path_generic(struct ixgbe_hw *hw);
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index ac7c164ba35..54c87baade5 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -50,19 +50,12 @@
 #include "../common/flow_engine.h"
 #include "ixgbe_flow.h"
 
-#define IXGBE_MIN_N_TUPLE_PRIO 1
-#define IXGBE_MAX_N_TUPLE_PRIO 7
 #define IXGBE_MAX_FLX_SOURCE_OFF 62
 
 struct ixgbe_filter_ele_base {
 	TAILQ_ENTRY(ixgbe_filter_ele_base) entries;
 };
 
-/* ntuple filter list structure */
-struct ixgbe_ntuple_filter_ele {
-	struct ixgbe_filter_ele_base base;
-	struct rte_eth_ntuple_filter filter_info;
-};
 /* fdir filter list structure */
 struct ixgbe_fdir_rule_ele {
 	struct ixgbe_filter_ele_base base;
@@ -84,6 +77,7 @@ const struct ci_flow_engine_list ixgbe_flow_engine_list = {
 		&ixgbe_ethertype_flow_engine,
 		&ixgbe_syn_flow_engine,
 		&ixgbe_l2_tunnel_flow_engine,
+		&ixgbe_ntuple_flow_engine,
 	},
 };
 
@@ -161,368 +155,6 @@ ixgbe_flow_actions_check(const struct ci_flow_actions *actions,
  * normally the packets should use network order.
  */
 
-/**
- * Parse the rule to see if it is a n-tuple rule.
- * And get the n-tuple filter info BTW.
- * pattern:
- * The first not void item can be ETH or IPV4.
- * The second not void item must be IPV4 if the first one is ETH.
- * The third not void item must be UDP or TCP.
- * The next not void item must be END.
- * action:
- * The first not void action should be QUEUE.
- * The next not void action should be END.
- * pattern example:
- * ITEM		Spec			Mask
- * ETH		NULL			NULL
- * IPV4		src_addr 192.168.1.20	0xFFFFFFFF
- *		dst_addr 192.167.3.50	0xFFFFFFFF
- *		next_proto_id	17	0xFF
- * UDP/TCP/	src_port	80	0xFFFF
- * SCTP		dst_port	80	0xFFFF
- * END
- * other members in mask and spec should set to 0x00.
- * item->last should be NULL.
- *
- * Special case for flow action type RTE_FLOW_ACTION_TYPE_SECURITY.
- *
- */
-static int
-cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
-			 const struct rte_flow_item pattern[],
-			 const struct rte_flow_action_queue *q_act,
-			 struct rte_eth_ntuple_filter *filter,
-			 struct rte_flow_error *error)
-{
-	const struct rte_flow_item *item;
-	const struct rte_flow_item_ipv4 *ipv4_spec;
-	const struct rte_flow_item_ipv4 *ipv4_mask;
-	const struct rte_flow_item_tcp *tcp_spec;
-	const struct rte_flow_item_tcp *tcp_mask;
-	const struct rte_flow_item_udp *udp_spec;
-	const struct rte_flow_item_udp *udp_mask;
-	const struct rte_flow_item_sctp *sctp_spec;
-	const struct rte_flow_item_sctp *sctp_mask;
-	const struct rte_flow_item_eth *eth_spec;
-	const struct rte_flow_item_eth *eth_mask;
-	const struct rte_flow_item_vlan *vlan_spec;
-	const struct rte_flow_item_vlan *vlan_mask;
-	struct rte_flow_item_eth eth_null;
-	struct rte_flow_item_vlan vlan_null;
-	uint16_t priority;
-
-	/* Priority must be 16-bit */
-	if (attr->priority > UINT16_MAX) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY, attr,
-				"Priority must be 16-bit");
-	}
-
-	memset(&eth_null, 0, sizeof(struct rte_flow_item_eth));
-	memset(&vlan_null, 0, sizeof(struct rte_flow_item_vlan));
-
-	/* the first not void item can be MAC or IPv4 */
-	item = next_no_void_pattern(pattern, NULL);
-
-	if (item->type != RTE_FLOW_ITEM_TYPE_ETH &&
-	    item->type != RTE_FLOW_ITEM_TYPE_IPV4) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by ntuple filter");
-		return -rte_errno;
-	}
-	/* Skip Ethernet */
-	if (item->type == RTE_FLOW_ITEM_TYPE_ETH) {
-		eth_spec = item->spec;
-		eth_mask = item->mask;
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error,
-			  EINVAL,
-			  RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			  item, "Not supported last point for range");
-			return -rte_errno;
-
-		}
-		/* if the first item is MAC, the content should be NULL */
-		if ((item->spec != NULL && memcmp(eth_spec, &eth_null, sizeof(eth_null)) != 0) ||
-		    (item->mask != NULL && memcmp(eth_mask, &eth_null, sizeof(eth_null)) != 0)) {
-			rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM, item,
-					"Not supported by ntuple filter");
-			return -rte_errno;
-		}
-		/* check if the next not void item is IPv4 or Vlan */
-		item = next_no_void_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
-			item->type != RTE_FLOW_ITEM_TYPE_VLAN) {
-			rte_flow_error_set(error,
-			  EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
-			  item, "Not supported by ntuple filter");
-			  return -rte_errno;
-		}
-	}
-
-	if (item->type == RTE_FLOW_ITEM_TYPE_VLAN) {
-		vlan_spec = item->spec;
-		vlan_mask = item->mask;
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error,
-			  EINVAL,
-			  RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			  item, "Not supported last point for range");
-			return -rte_errno;
-		}
-		/* the content should be NULL */
-		if ((item->spec != NULL && memcmp(vlan_spec, &vlan_null, sizeof(vlan_null)) != 0) ||
-		    (item->mask != NULL && memcmp(vlan_mask, &vlan_null, sizeof(vlan_null)) != 0)) {
-			rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM, item,
-					"Not supported by ntuple filter");
-			return -rte_errno;
-		}
-		/* check if the next not void item is IPv4 */
-		item = next_no_void_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_IPV4) {
-			rte_flow_error_set(error,
-			  EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
-			  item, "Not supported by ntuple filter");
-			return -rte_errno;
-		}
-	}
-
-	if (item->mask) {
-		/* get the IPv4 info */
-		if (!item->spec || !item->mask) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Invalid ntuple mask");
-			return -rte_errno;
-		}
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-
-		ipv4_mask = item->mask;
-		/**
-		 * Only support src & dst addresses, protocol,
-		 * others should be masked.
-		 */
-		if (ipv4_mask->hdr.version_ihl ||
-		    ipv4_mask->hdr.type_of_service ||
-		    ipv4_mask->hdr.total_length ||
-		    ipv4_mask->hdr.packet_id ||
-		    ipv4_mask->hdr.fragment_offset ||
-		    ipv4_mask->hdr.time_to_live ||
-		    ipv4_mask->hdr.hdr_checksum) {
-			rte_flow_error_set(error,
-				EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by ntuple filter");
-			return -rte_errno;
-		}
-		if ((ipv4_mask->hdr.src_addr != 0 &&
-			ipv4_mask->hdr.src_addr != UINT32_MAX) ||
-			(ipv4_mask->hdr.dst_addr != 0 &&
-			ipv4_mask->hdr.dst_addr != UINT32_MAX) ||
-			(ipv4_mask->hdr.next_proto_id != UINT8_MAX &&
-			ipv4_mask->hdr.next_proto_id != 0)) {
-			rte_flow_error_set(error,
-				EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by ntuple filter");
-			return -rte_errno;
-		}
-
-		filter->dst_ip_mask = ipv4_mask->hdr.dst_addr;
-		filter->src_ip_mask = ipv4_mask->hdr.src_addr;
-		filter->proto_mask  = ipv4_mask->hdr.next_proto_id;
-
-		ipv4_spec = item->spec;
-		filter->dst_ip = ipv4_spec->hdr.dst_addr;
-		filter->src_ip = ipv4_spec->hdr.src_addr;
-		filter->proto  = ipv4_spec->hdr.next_proto_id;
-	}
-
-	/* check if the next not void item is TCP or UDP */
-	item = next_no_void_pattern(pattern, item);
-	if (item->type != RTE_FLOW_ITEM_TYPE_TCP &&
-	    item->type != RTE_FLOW_ITEM_TYPE_UDP &&
-	    item->type != RTE_FLOW_ITEM_TYPE_SCTP &&
-	    item->type != RTE_FLOW_ITEM_TYPE_END) {
-		memset(filter, 0, sizeof(struct rte_eth_ntuple_filter));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by ntuple filter");
-		return -rte_errno;
-	}
-
-	if ((item->type != RTE_FLOW_ITEM_TYPE_END) &&
-		(!item->spec && !item->mask)) {
-		goto action;
-	}
-
-	/* get the TCP/UDP/SCTP info */
-	if (item->type != RTE_FLOW_ITEM_TYPE_END &&
-		(!item->spec || !item->mask)) {
-		memset(filter, 0, sizeof(struct rte_eth_ntuple_filter));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Invalid ntuple mask");
-		return -rte_errno;
-	}
-
-	/*Not supported last point for range*/
-	if (item->last) {
-		memset(filter, 0, sizeof(struct rte_eth_ntuple_filter));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			item, "Not supported last point for range");
-		return -rte_errno;
-
-	}
-
-	if (item->type == RTE_FLOW_ITEM_TYPE_TCP) {
-		tcp_mask = item->mask;
-
-		/**
-		 * Only support src & dst ports, tcp flags,
-		 * others should be masked.
-		 */
-		if (tcp_mask->hdr.sent_seq ||
-		    tcp_mask->hdr.recv_ack ||
-		    tcp_mask->hdr.data_off ||
-		    tcp_mask->hdr.rx_win ||
-		    tcp_mask->hdr.cksum ||
-		    tcp_mask->hdr.tcp_urp) {
-			memset(filter, 0,
-				sizeof(struct rte_eth_ntuple_filter));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by ntuple filter");
-			return -rte_errno;
-		}
-		if ((tcp_mask->hdr.src_port != 0 &&
-			tcp_mask->hdr.src_port != UINT16_MAX) ||
-			(tcp_mask->hdr.dst_port != 0 &&
-			tcp_mask->hdr.dst_port != UINT16_MAX)) {
-			rte_flow_error_set(error,
-				EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by ntuple filter");
-			return -rte_errno;
-		}
-
-		filter->dst_port_mask  = tcp_mask->hdr.dst_port;
-		filter->src_port_mask  = tcp_mask->hdr.src_port;
-		if (tcp_mask->hdr.tcp_flags == 0xFF) {
-			filter->flags |= RTE_NTUPLE_FLAGS_TCP_FLAG;
-		} else if (!tcp_mask->hdr.tcp_flags) {
-			filter->flags &= ~RTE_NTUPLE_FLAGS_TCP_FLAG;
-		} else {
-			memset(filter, 0, sizeof(struct rte_eth_ntuple_filter));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by ntuple filter");
-			return -rte_errno;
-		}
-
-		tcp_spec = item->spec;
-		filter->dst_port  = tcp_spec->hdr.dst_port;
-		filter->src_port  = tcp_spec->hdr.src_port;
-		filter->tcp_flags = tcp_spec->hdr.tcp_flags;
-	} else if (item->type == RTE_FLOW_ITEM_TYPE_UDP) {
-		udp_mask = item->mask;
-
-		/**
-		 * Only support src & dst ports,
-		 * others should be masked.
-		 */
-		if (udp_mask->hdr.dgram_len ||
-		    udp_mask->hdr.dgram_cksum) {
-			memset(filter, 0,
-				sizeof(struct rte_eth_ntuple_filter));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by ntuple filter");
-			return -rte_errno;
-		}
-		if ((udp_mask->hdr.src_port != 0 &&
-			udp_mask->hdr.src_port != UINT16_MAX) ||
-			(udp_mask->hdr.dst_port != 0 &&
-			udp_mask->hdr.dst_port != UINT16_MAX)) {
-			rte_flow_error_set(error,
-				EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by ntuple filter");
-			return -rte_errno;
-		}
-
-		filter->dst_port_mask = udp_mask->hdr.dst_port;
-		filter->src_port_mask = udp_mask->hdr.src_port;
-
-		udp_spec = item->spec;
-		filter->dst_port = udp_spec->hdr.dst_port;
-		filter->src_port = udp_spec->hdr.src_port;
-	} else if (item->type == RTE_FLOW_ITEM_TYPE_SCTP) {
-		sctp_mask = item->mask;
-
-		/**
-		 * Only support src & dst ports,
-		 * others should be masked.
-		 */
-		if (sctp_mask->hdr.tag ||
-		    sctp_mask->hdr.cksum) {
-			memset(filter, 0,
-				sizeof(struct rte_eth_ntuple_filter));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by ntuple filter");
-			return -rte_errno;
-		}
-
-		filter->dst_port_mask = sctp_mask->hdr.dst_port;
-		filter->src_port_mask = sctp_mask->hdr.src_port;
-
-		sctp_spec = item->spec;
-		filter->dst_port = sctp_spec->hdr.dst_port;
-		filter->src_port = sctp_spec->hdr.src_port;
-	} else {
-		goto action;
-	}
-
-	/* check if the next not void item is END */
-	item = next_no_void_pattern(pattern, item);
-	if (item->type != RTE_FLOW_ITEM_TYPE_END) {
-		memset(filter, 0, sizeof(struct rte_eth_ntuple_filter));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by ntuple filter");
-		return -rte_errno;
-	}
-
-action:
-
-	filter->queue = q_act->index;
-
-	/*
-	 * rte_flow priority: 0 through UINT32_MAX, 0 is highest
-	 *
-	 * ntuple priority: 001b through 111b, 111b is highest
-	 *
-	 * which means we need to transform priority from rte_flow to ntuple:
-	 *
-	 * 1) clamp max value
-	 * 2) reverse
-	 * 3) add min value
-	 */
-	priority = RTE_MIN(IXGBE_MAX_N_TUPLE_PRIO - 1, (uint16_t)attr->priority);
-	priority = IXGBE_MAX_N_TUPLE_PRIO - 1 - priority;
-	priority += IXGBE_MIN_N_TUPLE_PRIO;
-	filter->priority = priority;
-
-	return 0;
-}
-
 static int
 ixgbe_parse_security_filter(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
 		const struct rte_flow_item pattern[], const struct rte_flow_action actions[],
@@ -611,66 +243,6 @@ ixgbe_parse_security_filter(struct rte_eth_dev *dev, const struct rte_flow_attr
 	return 0;
 }
 
-/* a specific function for ixgbe because the flags is specific */
-static int
-ixgbe_parse_ntuple_filter(struct rte_eth_dev *dev,
-			  const struct rte_flow_attr *attr,
-			  const struct rte_flow_item pattern[],
-			  const struct rte_flow_action actions[],
-			  struct rte_eth_ntuple_filter *filter,
-			  struct rte_flow_error *error)
-{
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct ci_flow_attr_check_param attr_param = {
-		.allow_priority = true,
-	};
-	struct ci_flow_actions parsed_actions;
-	struct ci_flow_actions_check_param ap_param = {
-		.allowed_types = (const enum rte_flow_action_type[]){
-			/* only queue is allowed here */
-			RTE_FLOW_ACTION_TYPE_QUEUE,
-			RTE_FLOW_ACTION_TYPE_END
-		},
-		.driver_ctx = dev->data,
-		.check = ixgbe_flow_actions_check,
-		.max_actions = 1,
-	};
-	const struct rte_flow_action *action;
-	int ret;
-
-	if (hw->mac.type != ixgbe_mac_82599EB &&
-			hw->mac.type != ixgbe_mac_X540)
-		return -ENOTSUP;
-
-	/* validate attributes */
-	ret = ci_flow_check_attr(attr, &attr_param, error);
-	if (ret)
-		return ret;
-
-	/* parse requested actions */
-	ret = ci_flow_check_actions(actions, &ap_param, &parsed_actions, error);
-	if (ret)
-		return ret;
-	action = parsed_actions.actions[0];
-
-	ret = cons_parse_ntuple_filter(attr, pattern, action->conf, filter, error);
-	if (ret)
-		return ret;
-
-	/* Ixgbe doesn't support tcp flags. */
-	if (filter->flags & RTE_NTUPLE_FLAGS_TCP_FLAG) {
-		memset(filter, 0, sizeof(struct rte_eth_ntuple_filter));
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ITEM,
-				   NULL, "Not supported by ntuple filter");
-		return -rte_errno;
-	}
-
-	/* fixed value for ixgbe */
-	filter->flags = RTE_5TUPLE_FLAGS;
-	return 0;
-}
-
 /* search next no void pattern and skip fuzzy */
 static inline
 const struct rte_flow_item *next_no_fuzzy_pattern(
@@ -2305,13 +1877,11 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	int ret;
 	struct ixgbe_adapter *adapter =
 		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct rte_eth_ntuple_filter ntuple_filter;
 	struct ixgbe_fdir_rule fdir_rule;
 	struct ixgbe_hw_fdir_info *fdir_info =
 		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
 	struct ixgbe_rte_flow_rss_conf rss_conf;
 	struct rte_flow *flow = NULL;
-	struct ixgbe_ntuple_filter_ele *ntuple_filter_ptr;
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
 	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
@@ -2348,29 +1918,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 		return flow;
 	}
 
-	memset(&ntuple_filter, 0, sizeof(struct rte_eth_ntuple_filter));
-	ret = ixgbe_parse_ntuple_filter(dev, attr, pattern,
-			actions, &ntuple_filter, error);
-
-	if (!ret) {
-		ntuple_filter_ptr = rte_zmalloc("ixgbe_ntuple_filter",
-			sizeof(struct ixgbe_ntuple_filter_ele), 0);
-		if (!ntuple_filter_ptr) {
-			PMD_DRV_LOG(ERR, "failed to allocate memory");
-			ret = -ENOMEM;
-			goto out;
-		}
-		ntuple_filter_ptr->filter_info = ntuple_filter;
-		ret = ixgbe_add_del_ntuple_filter(adapter, &ntuple_filter, TRUE);
-		if (ret) {
-			rte_free(ntuple_filter_ptr);
-			goto out;
-		}
-		flow->rule = ntuple_filter_ptr;
-		flow->filter_type = RTE_ETH_FILTER_NTUPLE;
-		return flow;
-	}
-
 	memset(&fdir_rule, 0, sizeof(struct ixgbe_fdir_rule));
 	ret = ixgbe_parse_fdir_filter(dev, attr, pattern,
 				actions, &fdir_rule, error);
@@ -2455,7 +2002,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 		struct rte_flow_error *error)
 {
 	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct rte_eth_ntuple_filter ntuple_filter;
 	struct ixgbe_fdir_rule fdir_rule;
 	struct ixgbe_rte_flow_rss_conf rss_conf;
 	int ret;
@@ -2474,12 +2020,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 	if (!ret)
 		return 0;
 
-	memset(&ntuple_filter, 0, sizeof(struct rte_eth_ntuple_filter));
-	ret = ixgbe_parse_ntuple_filter(dev, attr, pattern,
-				actions, &ntuple_filter, error);
-	if (!ret)
-		return 0;
-
 	memset(&fdir_rule, 0, sizeof(struct ixgbe_fdir_rule));
 	ret = ixgbe_parse_fdir_filter(dev, attr, pattern,
 				actions, &fdir_rule, error);
@@ -2504,9 +2044,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct rte_flow *pmd_flow = flow;
 	enum rte_filter_type filter_type = pmd_flow->filter_type;
-	struct rte_eth_ntuple_filter ntuple_filter;
 	struct ixgbe_fdir_rule fdir_rule;
-	struct ixgbe_ntuple_filter_ele *ntuple_filter_ptr;
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_filter_ele_base *flow_mem_base;
 	struct ixgbe_hw_fdir_info *fdir_info =
@@ -2542,14 +2080,6 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	}
 
 	switch (filter_type) {
-	case RTE_ETH_FILTER_NTUPLE:
-		ntuple_filter_ptr = (struct ixgbe_ntuple_filter_ele *)
-					pmd_flow->rule;
-		ntuple_filter = ntuple_filter_ptr->filter_info;
-		ret = ixgbe_add_del_ntuple_filter(adapter, &ntuple_filter, FALSE);
-		if (!ret)
-			rte_free(ntuple_filter_ptr);
-		break;
 	case RTE_ETH_FILTER_FDIR:
 		fdir_rule_ptr = (struct ixgbe_fdir_rule_ele *)pmd_flow->rule;
 		fdir_rule = fdir_rule_ptr->filter_info;
@@ -2609,8 +2139,6 @@ ixgbe_flow_flush(struct rte_eth_dev *dev,
 		return ret;
 	}
 
-	ixgbe_clear_all_ntuple_filter(dev);
-
 	ret = ixgbe_clear_all_fdir_filter(dev);
 	if (ret < 0) {
 		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_HANDLE,
@@ -2634,8 +2162,6 @@ ixgbe_flow_rule_engine_name(const struct rte_flow *flow)
 		return "security";
 
 	switch (flow->filter_type) {
-	case RTE_ETH_FILTER_NTUPLE:
-		return "ntuple";
 	case RTE_ETH_FILTER_ETHERTYPE:
 		return "ethertype";
 	case RTE_ETH_FILTER_SYN:
@@ -2658,8 +2184,6 @@ ixgbe_flow_rule_size(const struct rte_flow *flow)
 		return 0;
 
 	switch (flow->filter_type) {
-	case RTE_ETH_FILTER_NTUPLE:
-		return sizeof(struct rte_eth_ntuple_filter);
 	case RTE_ETH_FILTER_ETHERTYPE:
 		return sizeof(struct rte_eth_ethertype_filter);
 	case RTE_ETH_FILTER_SYN:
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.h b/drivers/net/intel/ixgbe/ixgbe_flow.h
index ba0486b2c0e..6f082e9402f 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.h
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.h
@@ -18,5 +18,6 @@ extern const struct ci_flow_engine_list ixgbe_flow_engine_list;
 extern const struct ci_flow_engine ixgbe_ethertype_flow_engine;
 extern const struct ci_flow_engine ixgbe_syn_flow_engine;
 extern const struct ci_flow_engine ixgbe_l2_tunnel_flow_engine;
+extern const struct ci_flow_engine ixgbe_ntuple_flow_engine;
 
 #endif /*  _IXGBE_FLOW_H_ */
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow_ntuple.c b/drivers/net/intel/ixgbe/ixgbe_flow_ntuple.c
new file mode 100644
index 00000000000..aa28195de0a
--- /dev/null
+++ b/drivers/net/intel/ixgbe/ixgbe_flow_ntuple.c
@@ -0,0 +1,694 @@
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
+#define IXGBE_MIN_N_TUPLE_PRIO 1
+#define IXGBE_MAX_N_TUPLE_PRIO 7
+
+struct ixgbe_ntuple_flow {
+	struct rte_flow flow;
+	struct ixgbe_5tuple_filter_info key; /* HW-shaped match key */
+	uint16_t queue;
+	uint16_t index; /* HW filter slot */
+};
+
+/* per-device table of registered filters, indexed by assigned HW slot */
+struct ixgbe_ntuple_priv {
+	struct ixgbe_ntuple_flow *slots[IXGBE_MAX_FTQF_FILTERS];
+};
+
+struct ixgbe_ntuple_ctx {
+	struct ci_flow_engine_ctx base;
+	struct rte_eth_ntuple_filter ntuple;
+};
+
+/**
+ * Ntuple filter graph implementation
+ * Pattern: START -> [ETH] -> [VLAN] -> IPV4 -> [TCP|UDP|SCTP] -> END
+ */
+
+enum ixgbe_ntuple_node_id {
+	IXGBE_NTUPLE_NODE_START = FLOW_GRAPH_NODE_FIRST,
+	IXGBE_NTUPLE_NODE_ETH,
+	IXGBE_NTUPLE_NODE_VLAN,
+	IXGBE_NTUPLE_NODE_IPV4,
+	IXGBE_NTUPLE_NODE_TCP,
+	IXGBE_NTUPLE_NODE_UDP,
+	IXGBE_NTUPLE_NODE_SCTP,
+	IXGBE_NTUPLE_NODE_END,
+	IXGBE_NTUPLE_NODE_MAX,
+};
+
+/* spec and effective mask, if present, must be all-zero */
+static int
+ixgbe_validate_ntuple_empty_item(const struct rte_flow_item *item, size_t size,
+		struct rte_flow_error *error)
+{
+	const void *mask = ci_flow_item_mask(item);
+
+	if ((item->spec != NULL && !ci_is_all_byte(item->spec, size, 0)) ||
+	    (mask != NULL && !ci_is_all_byte(mask, size, 0))) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Not supported by ntuple filter");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_validate_ntuple_eth(const void *ctx __rte_unused,
+		const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	return ixgbe_validate_ntuple_empty_item(item,
+			sizeof(struct rte_flow_item_eth), error);
+}
+
+static int
+ixgbe_validate_ntuple_vlan(const void *ctx __rte_unused,
+		const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	return ixgbe_validate_ntuple_empty_item(item,
+			sizeof(struct rte_flow_item_vlan), error);
+}
+
+static int
+ixgbe_validate_ntuple_ipv4(const void *ctx __rte_unused,
+			   const struct rte_flow_item *item,
+			   struct rte_flow_error *error)
+{
+	const struct rte_flow_item_ipv4 *ipv4_mask;
+
+	ipv4_mask = ci_flow_item_mask(item);
+
+	if (ipv4_mask == NULL)
+		return 0;
+
+	/* Only src/dst addresses and protocol supported */
+	if (ipv4_mask->hdr.version_ihl ||
+	    ipv4_mask->hdr.type_of_service ||
+	    ipv4_mask->hdr.total_length ||
+	    ipv4_mask->hdr.packet_id ||
+	    ipv4_mask->hdr.fragment_offset ||
+	    ipv4_mask->hdr.time_to_live ||
+	    ipv4_mask->hdr.hdr_checksum) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Only src/dst IP and protocol supported");
+	}
+
+	/* Masks must be 0 or all-ones */
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&ipv4_mask->hdr.src_addr) ||
+	    !CI_FIELD_IS_ZERO_OR_MASKED(&ipv4_mask->hdr.dst_addr) ||
+	    !CI_FIELD_IS_ZERO_OR_MASKED(&ipv4_mask->hdr.next_proto_id)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Partial masks not supported");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_ntuple_ipv4(void *ctx,
+			  const struct rte_flow_item *item,
+			  struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_ntuple_ctx *ntuple_ctx = ctx;
+	const struct rte_flow_item_ipv4 *ipv4_spec = item->spec;
+	const struct rte_flow_item_ipv4 *ipv4_mask = ci_flow_item_mask(item);
+
+	if (ipv4_mask == NULL)
+		return 0;
+
+	ntuple_ctx->ntuple.dst_ip = ipv4_spec->hdr.dst_addr;
+	ntuple_ctx->ntuple.src_ip = ipv4_spec->hdr.src_addr;
+	ntuple_ctx->ntuple.proto = ipv4_spec->hdr.next_proto_id;
+
+	ntuple_ctx->ntuple.dst_ip_mask = ipv4_mask->hdr.dst_addr;
+	ntuple_ctx->ntuple.src_ip_mask = ipv4_mask->hdr.src_addr;
+	ntuple_ctx->ntuple.proto_mask = ipv4_mask->hdr.next_proto_id;
+
+	return 0;
+}
+
+/* an empty L4 item still implies its protocol */
+static int
+ixgbe_ntuple_set_l4_proto(struct ixgbe_ntuple_ctx *ntuple_ctx,
+		const struct rte_flow_item *item, uint8_t proto,
+		struct rte_flow_error *error)
+{
+	struct rte_eth_ntuple_filter *ntuple = &ntuple_ctx->ntuple;
+
+	if (ntuple->proto_mask != 0 && ntuple->proto != proto) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"L4 item conflicts with IPv4 protocol");
+	}
+
+	ntuple->proto = proto;
+	ntuple->proto_mask = UINT8_MAX;
+
+	return 0;
+}
+
+static int
+ixgbe_validate_ntuple_tcp(const void *ctx __rte_unused,
+			  const struct rte_flow_item *item,
+			  struct rte_flow_error *error)
+{
+	const struct rte_flow_item_tcp *tcp_mask;
+
+	tcp_mask = ci_flow_item_mask(item);
+
+	if (tcp_mask == NULL)
+		return 0;
+
+	/* Only src/dst ports and tcp_flags supported */
+	if (tcp_mask->hdr.sent_seq ||
+	    tcp_mask->hdr.recv_ack ||
+	    tcp_mask->hdr.data_off ||
+	    tcp_mask->hdr.rx_win ||
+	    tcp_mask->hdr.cksum ||
+	    tcp_mask->hdr.tcp_urp) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Only src/dst ports and flags supported");
+	}
+
+	/* Port masks must be 0 or all-ones */
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&tcp_mask->hdr.src_port) ||
+	    !CI_FIELD_IS_ZERO_OR_MASKED(&tcp_mask->hdr.dst_port)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Partial port masks not supported");
+	}
+
+	/* TCP flags not supported by hardware */
+	if (!CI_FIELD_IS_ZERO(&tcp_mask->hdr.tcp_flags)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"TCP flags filtering not supported");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_ntuple_tcp(void *ctx,
+			 const struct rte_flow_item *item,
+			 struct rte_flow_error *error)
+{
+	struct ixgbe_ntuple_ctx *ntuple_ctx = ctx;
+	const struct rte_flow_item_tcp *tcp_spec = item->spec;
+	const struct rte_flow_item_tcp *tcp_mask = ci_flow_item_mask(item);
+
+	if (tcp_mask == NULL)
+		return ixgbe_ntuple_set_l4_proto(ntuple_ctx, item, IPPROTO_TCP, error);
+
+	ntuple_ctx->ntuple.dst_port = tcp_spec->hdr.dst_port;
+	ntuple_ctx->ntuple.src_port = tcp_spec->hdr.src_port;
+
+	ntuple_ctx->ntuple.dst_port_mask = tcp_mask->hdr.dst_port;
+	ntuple_ctx->ntuple.src_port_mask = tcp_mask->hdr.src_port;
+
+	return 0;
+}
+
+static int
+ixgbe_validate_ntuple_udp(const void *ctx __rte_unused,
+			  const struct rte_flow_item *item,
+			  struct rte_flow_error *error)
+{
+	const struct rte_flow_item_udp *udp_mask;
+
+	udp_mask = ci_flow_item_mask(item);
+
+	if (udp_mask == NULL)
+		return 0;
+
+	/* Only src/dst ports supported */
+	if (udp_mask->hdr.dgram_len ||
+	    udp_mask->hdr.dgram_cksum) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Only src/dst ports supported");
+	}
+
+	/* Port masks must be 0 or all-ones */
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&udp_mask->hdr.src_port) ||
+	    !CI_FIELD_IS_ZERO_OR_MASKED(&udp_mask->hdr.dst_port)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Partial port masks not supported");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_ntuple_udp(void *ctx,
+			 const struct rte_flow_item *item,
+			 struct rte_flow_error *error)
+{
+	struct ixgbe_ntuple_ctx *ntuple_ctx = ctx;
+	const struct rte_flow_item_udp *udp_spec = item->spec;
+	const struct rte_flow_item_udp *udp_mask = ci_flow_item_mask(item);
+
+	if (udp_mask == NULL)
+		return ixgbe_ntuple_set_l4_proto(ntuple_ctx, item, IPPROTO_UDP, error);
+
+	ntuple_ctx->ntuple.dst_port = udp_spec->hdr.dst_port;
+	ntuple_ctx->ntuple.src_port = udp_spec->hdr.src_port;
+
+	ntuple_ctx->ntuple.dst_port_mask = udp_mask->hdr.dst_port;
+	ntuple_ctx->ntuple.src_port_mask = udp_mask->hdr.src_port;
+
+	return 0;
+}
+
+static int
+ixgbe_validate_ntuple_sctp(const void *ctx __rte_unused,
+			   const struct rte_flow_item *item,
+			   struct rte_flow_error *error)
+{
+	const struct rte_flow_item_sctp *sctp_mask;
+
+	sctp_mask = ci_flow_item_mask(item);
+
+	if (sctp_mask == NULL)
+		return 0;
+
+	/* Only src/dst ports supported */
+	if (sctp_mask->hdr.tag ||
+	    sctp_mask->hdr.cksum) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Only src/dst ports supported");
+	}
+
+	/* Port masks must be 0 or all-ones */
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&sctp_mask->hdr.src_port) ||
+	    !CI_FIELD_IS_ZERO_OR_MASKED(&sctp_mask->hdr.dst_port)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Partial port masks not supported");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_ntuple_sctp(void *ctx,
+			  const struct rte_flow_item *item,
+			  struct rte_flow_error *error)
+{
+	struct ixgbe_ntuple_ctx *ntuple_ctx = ctx;
+	const struct rte_flow_item_sctp *sctp_spec = item->spec;
+	const struct rte_flow_item_sctp *sctp_mask = ci_flow_item_mask(item);
+
+	if (sctp_mask == NULL)
+		return ixgbe_ntuple_set_l4_proto(ntuple_ctx, item, IPPROTO_SCTP, error);
+
+	ntuple_ctx->ntuple.dst_port = sctp_spec->hdr.dst_port;
+	ntuple_ctx->ntuple.src_port = sctp_spec->hdr.src_port;
+
+	ntuple_ctx->ntuple.dst_port_mask = sctp_mask->hdr.dst_port;
+	ntuple_ctx->ntuple.src_port_mask = sctp_mask->hdr.src_port;
+
+	return 0;
+}
+
+static const struct flow_graph ixgbe_ntuple_graph = {
+	.nodes = (struct flow_graph_node[]) {
+		[IXGBE_NTUPLE_NODE_START] = {
+			.name = "START",
+		},
+		[IXGBE_NTUPLE_NODE_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+				       FLOW_GRAPH_NODE_EXPECT_SPEC,
+			.validate = ixgbe_validate_ntuple_eth,
+		},
+		[IXGBE_NTUPLE_NODE_VLAN] = {
+			.name = "VLAN",
+			.type = RTE_FLOW_ITEM_TYPE_VLAN,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+				       FLOW_GRAPH_NODE_EXPECT_SPEC,
+			.validate = ixgbe_validate_ntuple_vlan,
+		},
+		[IXGBE_NTUPLE_NODE_IPV4] = {
+			.name = "IPV4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+				       FLOW_GRAPH_NODE_EXPECT_SPEC,
+			.validate = ixgbe_validate_ntuple_ipv4,
+			.process = ixgbe_process_ntuple_ipv4,
+		},
+		[IXGBE_NTUPLE_NODE_TCP] = {
+			.name = "TCP",
+			.type = RTE_FLOW_ITEM_TYPE_TCP,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+				       FLOW_GRAPH_NODE_EXPECT_SPEC,
+			.validate = ixgbe_validate_ntuple_tcp,
+			.process = ixgbe_process_ntuple_tcp,
+		},
+		[IXGBE_NTUPLE_NODE_UDP] = {
+			.name = "UDP",
+			.type = RTE_FLOW_ITEM_TYPE_UDP,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+				       FLOW_GRAPH_NODE_EXPECT_SPEC,
+			.validate = ixgbe_validate_ntuple_udp,
+			.process = ixgbe_process_ntuple_udp,
+		},
+		[IXGBE_NTUPLE_NODE_SCTP] = {
+			.name = "SCTP",
+			.type = RTE_FLOW_ITEM_TYPE_SCTP,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+				       FLOW_GRAPH_NODE_EXPECT_SPEC,
+			.validate = ixgbe_validate_ntuple_sctp,
+			.process = ixgbe_process_ntuple_sctp,
+		},
+		[IXGBE_NTUPLE_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	},
+	.edges = (struct flow_graph_edge[]) {
+		[IXGBE_NTUPLE_NODE_START] = {
+			.next = (size_t[]) {
+				IXGBE_NTUPLE_NODE_ETH,
+				IXGBE_NTUPLE_NODE_IPV4,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_NTUPLE_NODE_ETH] = {
+			.next = (size_t[]) {
+				IXGBE_NTUPLE_NODE_VLAN,
+				IXGBE_NTUPLE_NODE_IPV4,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_NTUPLE_NODE_VLAN] = {
+			.next = (size_t[]) {
+				IXGBE_NTUPLE_NODE_IPV4,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_NTUPLE_NODE_IPV4] = {
+			.next = (size_t[]) {
+				IXGBE_NTUPLE_NODE_TCP,
+				IXGBE_NTUPLE_NODE_UDP,
+				IXGBE_NTUPLE_NODE_SCTP,
+				IXGBE_NTUPLE_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_NTUPLE_NODE_TCP] = {
+			.next = (size_t[]) {
+				IXGBE_NTUPLE_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_NTUPLE_NODE_UDP] = {
+			.next = (size_t[]) {
+				IXGBE_NTUPLE_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_NTUPLE_NODE_SCTP] = {
+			.next = (size_t[]) {
+				IXGBE_NTUPLE_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+static int
+ixgbe_flow_ntuple_ctx_init(const struct rte_flow_action *actions,
+		const struct rte_flow_attr *attr,
+		struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_ntuple_ctx *ntuple_ctx = (struct ixgbe_ntuple_ctx *)ctx;
+	struct ci_flow_attr_check_param attr_param = {
+		.allow_priority = true,
+	};
+	struct ci_flow_actions parsed_actions;
+	struct ci_flow_actions_check_param ap_param = {
+		.allowed_types = (const enum rte_flow_action_type[]){
+			/* only queue is allowed here */
+			RTE_FLOW_ACTION_TYPE_QUEUE,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.driver_ctx = ctx->dev_data,
+		.check = ixgbe_flow_actions_check,
+		.max_actions = 1,
+	};
+	const struct rte_flow_action_queue *q_act;
+	uint16_t priority;
+	int ret;
+
+	/* validate attributes */
+	ret = ci_flow_check_attr(attr, &attr_param, error);
+	if (ret)
+		return ret;
+
+	/* Priority must be 16-bit */
+	if (attr->priority > UINT16_MAX) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY, attr,
+				"Priority must be 16-bit");
+	}
+
+	/* parse requested actions */
+	ret = ci_flow_check_actions(actions, &ap_param, &parsed_actions, error);
+	if (ret)
+		return ret;
+
+	q_act = (const struct rte_flow_action_queue *)parsed_actions.actions[0]->conf;
+
+	ntuple_ctx->ntuple.queue = q_act->index;
+
+	/*
+	* rte_flow priority: 0 through UINT32_MAX, 0 is highest
+	*
+	 * ntuple priority: 001b through 111b, 111b is highest
+	 *
+	 * which means we need to transform priority from rte_flow to ntuple:
+	 *
+	 * 1) clamp max value
+	 * 2) reverse
+	 * 3) add min value
+	 */
+	priority = RTE_MIN(IXGBE_MAX_N_TUPLE_PRIO - 1, (uint16_t)attr->priority);
+	priority = IXGBE_MAX_N_TUPLE_PRIO - 1 - priority;
+	priority += IXGBE_MIN_N_TUPLE_PRIO;
+	ntuple_ctx->ntuple.priority = priority;
+
+	/* fixed value for ixgbe */
+	ntuple_ctx->ntuple.flags = RTE_5TUPLE_FLAGS;
+
+	return 0;
+}
+
+static enum ixgbe_5tuple_protocol
+convert_protocol_type(uint8_t protocol_value)
+{
+	if (protocol_value == IPPROTO_TCP)
+		return IXGBE_FILTER_PROTOCOL_TCP;
+	else if (protocol_value == IPPROTO_UDP)
+		return IXGBE_FILTER_PROTOCOL_UDP;
+	else if (protocol_value == IPPROTO_SCTP)
+		return IXGBE_FILTER_PROTOCOL_SCTP;
+	else
+		return IXGBE_FILTER_PROTOCOL_NONE;
+}
+
+static int
+ixgbe_flow_ntuple_ctx_to_flow(const struct ci_flow_engine_ctx *ctx,
+		struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct ixgbe_ntuple_ctx *ntuple_ctx = (const struct ixgbe_ntuple_ctx *)ctx;
+	struct ixgbe_ntuple_flow *ntuple_flow = (struct ixgbe_ntuple_flow *)flow;
+	const struct rte_eth_ntuple_filter *ntuple = &ntuple_ctx->ntuple;
+	struct ixgbe_5tuple_filter_info *key = &ntuple_flow->key;
+
+	/* mask shape (0 or all-ones) is already guaranteed by the graph */
+	memset(key, 0, sizeof(*key));
+
+	key->dst_ip_mask = ntuple->dst_ip_mask == 0;
+	if (key->dst_ip_mask == 0)
+		key->dst_ip = ntuple->dst_ip;
+	key->src_ip_mask = ntuple->src_ip_mask == 0;
+	if (key->src_ip_mask == 0)
+		key->src_ip = ntuple->src_ip;
+	key->dst_port_mask = ntuple->dst_port_mask == 0;
+	if (key->dst_port_mask == 0)
+		key->dst_port = ntuple->dst_port;
+	key->src_port_mask = ntuple->src_port_mask == 0;
+	if (key->src_port_mask == 0)
+		key->src_port = ntuple->src_port;
+	key->proto_mask = ntuple->proto_mask == 0;
+	if (key->proto_mask == 0)
+		key->proto = convert_protocol_type(ntuple->proto);
+	key->priority = (uint8_t)ntuple->priority;
+
+	ntuple_flow->queue = ntuple->queue;
+
+	return 0;
+}
+
+/* two ntuple filters are the same rule if they match the same 5-tuple key */
+static bool
+ixgbe_ntuple_key_equal(const struct ixgbe_5tuple_filter_info *lhs,
+		const struct ixgbe_5tuple_filter_info *rhs)
+{
+	return memcmp(lhs, rhs, sizeof(*lhs)) == 0;
+}
+
+static int
+ixgbe_ntuple_slot_find(const struct ixgbe_ntuple_priv *priv,
+		const struct ixgbe_ntuple_flow *ntuple_flow)
+{
+	uint16_t free_idx = IXGBE_MAX_FTQF_FILTERS;
+	uint16_t idx;
+
+	for (idx = 0; idx < IXGBE_MAX_FTQF_FILTERS; idx++) {
+		const struct ixgbe_ntuple_flow *registered = priv->slots[idx];
+
+		if (registered == NULL) {
+			if (free_idx == IXGBE_MAX_FTQF_FILTERS)
+				free_idx = idx;
+			continue;
+		}
+		if (ixgbe_ntuple_key_equal(&registered->key, &ntuple_flow->key))
+			return -EEXIST;
+	}
+	if (free_idx == IXGBE_MAX_FTQF_FILTERS)
+		return -ENOSPC;
+
+	return (int)free_idx;
+}
+
+static int
+ixgbe_flow_ntuple_flow_register(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct ixgbe_ntuple_flow *ntuple_flow = (struct ixgbe_ntuple_flow *)flow;
+	struct ixgbe_ntuple_priv *priv = flow->engine_priv;
+	int idx;
+
+	idx = ixgbe_ntuple_slot_find(priv, ntuple_flow);
+	if (idx == -EEXIST) {
+		return rte_flow_error_set(error, EEXIST,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Ntuple filter already exists");
+	}
+	if (idx == -ENOSPC) {
+		return rte_flow_error_set(error, ENOSPC,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Ntuple filter table is full");
+	}
+	if (idx < 0) {
+		return rte_flow_error_set(error, -idx,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Failed to register ntuple filter");
+	}
+
+	priv->slots[idx] = ntuple_flow;
+	ntuple_flow->index = idx;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_ntuple_flow_unregister(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct ixgbe_ntuple_flow *ntuple_flow = (struct ixgbe_ntuple_flow *)flow;
+	struct ixgbe_ntuple_priv *priv = flow->engine_priv;
+
+	if (ntuple_flow->index >= IXGBE_MAX_FTQF_FILTERS ||
+			priv->slots[ntuple_flow->index] != ntuple_flow) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Ntuple filter slot does not match on unregister");
+	}
+
+	priv->slots[ntuple_flow->index] = NULL;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_ntuple_flow_install(struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_ntuple_flow *ntuple_flow = (struct ixgbe_ntuple_flow *)flow;
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(flow->dev_data->dev_private);
+
+	ixgbe_ntuple_filter_program(hw, ntuple_flow->index, &ntuple_flow->key,
+			ntuple_flow->queue);
+
+	return 0;
+}
+
+static int
+ixgbe_flow_ntuple_flow_uninstall(struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_ntuple_flow *ntuple_flow = (struct ixgbe_ntuple_flow *)flow;
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(flow->dev_data->dev_private);
+
+	ixgbe_ntuple_filter_clear(hw, ntuple_flow->index);
+
+	return 0;
+}
+
+static int
+ixgbe_flow_ntuple_engine_init(const struct ci_flow_engine *engine __rte_unused,
+		struct rte_eth_dev_data *dev_data,
+		void *priv __rte_unused)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev_data->dev_private);
+
+	/* only 82599 and X540 have L3/L4 5-tuple (ntuple) filters */
+	if (hw->mac.type == ixgbe_mac_82599EB ||
+			hw->mac.type == ixgbe_mac_X540)
+		return 0;
+
+	return -ENOTSUP;
+}
+
+static const struct ci_flow_engine_ops ixgbe_ntuple_ops = {
+	.engine_init = ixgbe_flow_ntuple_engine_init,
+	.ctx_init = ixgbe_flow_ntuple_ctx_init,
+	.ctx_to_flow = ixgbe_flow_ntuple_ctx_to_flow,
+	.flow_register = ixgbe_flow_ntuple_flow_register,
+	.flow_unregister = ixgbe_flow_ntuple_flow_unregister,
+	.flow_install = ixgbe_flow_ntuple_flow_install,
+	.flow_uninstall = ixgbe_flow_ntuple_flow_uninstall,
+};
+
+const struct ci_flow_engine ixgbe_ntuple_flow_engine = {
+	.name = "ixgbe_ntuple",
+	.ctx_size = sizeof(struct ixgbe_ntuple_ctx),
+	.flow_size = sizeof(struct ixgbe_ntuple_flow),
+	.priv_size = sizeof(struct ixgbe_ntuple_priv),
+	.ops = &ixgbe_ntuple_ops,
+	.graph = &ixgbe_ntuple_graph,
+};
diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
index 91ec2611543..90cc88f0027 100644
--- a/drivers/net/intel/ixgbe/meson.build
+++ b/drivers/net/intel/ixgbe/meson.build
@@ -29,6 +29,7 @@ sources += files(
         'ixgbe_flow_ethertype.c',
         'ixgbe_flow_syn.c',
         'ixgbe_flow_l2tun.c',
+        'ixgbe_flow_ntuple.c',
         'ixgbe_ipsec.c',
         'ixgbe_pf.c',
         'ixgbe_rxtx.c',
-- 
2.52.0

