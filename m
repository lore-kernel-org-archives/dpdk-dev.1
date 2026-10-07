Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E904CA5FF1
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 10:52:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 009E942E50;
	Wed,  7 Oct 2026 12:51:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 0D05F42E37
 for <dev@dpdk.org>; Wed,  7 Oct 2026 12:50:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791370259; x=1822906259;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=cEfOfPw5zExpt89GlR7K7QCA5ib2d0v0O9Yal4U5MWY=;
 b=IwcDCK+bFvenmOL1ag7SXfAQtRXXZT5H0dFLx3qxCQZGNgZkeIw4+WZt
 iJmIG8KPBLThg4fDLb0sQwIPP9cp3R+bL5v7VvY1YXXJNtU83Rtnjiwlc
 7d+XyvCjdoLRDp+mBKCuYGUHM2j9wg/0oMaYkO3/G/z5OiBSbjeHfbrje
 /pcZHgaHXXv3mDOBo8BD3f3CuC8Y0xZdBoXLL04L64rdfahshqjZ46Jwc
 Ja4TmSTEmomOe+xLBQJSMeFtpm/iZCWde2bVKAl3g9gqpGrDUR3+M3/hW
 srt3iOAhoyU6vEPc3FhR3oRvexgExo+ey5iCg4NR+0D9kiYfDZJM1aMvx Q==;
X-CSE-ConnectionGUID: aMmz2qHgQ36LgeEyo2BD4w==
X-CSE-MsgGUID: jquIvYxzTq27wb5RaNfINw==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="121837"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="121837"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 03:50:59 -0700
X-CSE-ConnectionGUID: pP+uIyEERo6FIBdbyHn8gw==
X-CSE-MsgGUID: GUF/pdZ5Qs+MQrkK9NG4zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="280652160"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 07 Oct 2026 03:50:58 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 20/25] net/i40e: reimplement ethertype parser
Date: Wed,  7 Oct 2026 11:50:15 +0100
Message-ID: <8ccdb3e8bce026c061e48e4b4ef6a472bd0eef84.1791369981.git.anatoly.burakov@intel.com>
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

Use the new flow graph API and the common parsing framework to implement
flow parser for Ethertype.

The ethertype filter tracking has been moved completely inside the new
engine, and the ethertype code is refactored to enabled that use case by
decoupling hardware writes from software tracking.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c         | 260 +-------------
 drivers/net/intel/i40e/i40e_ethdev.h         |  30 +-
 drivers/net/intel/i40e/i40e_flow.c           | 298 +---------------
 drivers/net/intel/i40e/i40e_flow.h           |   4 +
 drivers/net/intel/i40e/i40e_flow_ethertype.c | 351 +++++++++++++++++++
 drivers/net/intel/i40e/meson.build           |   1 +
 6 files changed, 370 insertions(+), 574 deletions(-)
 create mode 100644 drivers/net/intel/i40e/i40e_flow_ethertype.c

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 92aa0e39554..94bf6ee392a 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -392,12 +392,6 @@ static int i40e_set_default_mac_addr(struct rte_eth_dev *dev,
 
 static int i40e_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu);
 
-static int i40e_ethertype_filter_convert(
-	const struct rte_eth_ethertype_filter *input,
-	struct i40e_ethertype_filter *filter);
-static int i40e_sw_ethertype_filter_insert(struct i40e_pf *pf,
-				   struct i40e_ethertype_filter *filter);
-
 static int i40e_tunnel_filter_convert(
 	struct i40e_aqc_cloud_filters_element_bb *cld_filter,
 	struct i40e_tunnel_filter *tunnel_filter);
@@ -405,7 +399,6 @@ static int i40e_sw_tunnel_filter_insert(struct i40e_pf *pf,
 				struct i40e_tunnel_filter *tunnel_filter);
 static int i40e_cloud_filter_qinq_create(struct i40e_pf *pf);
 
-static void i40e_ethertype_filter_restore(struct i40e_pf *pf);
 static void i40e_tunnel_filter_restore(struct i40e_pf *pf);
 static void i40e_filter_restore(struct i40e_pf *pf);
 static void i40e_notify_all_vfs_link_status(struct rte_eth_dev *dev);
@@ -1003,51 +996,6 @@ config_floating_veb(struct rte_eth_dev *dev)
 #define I40E_L2_TAGS_S_TAG_SHIFT 1
 #define I40E_L2_TAGS_S_TAG_MASK I40E_MASK(0x1, I40E_L2_TAGS_S_TAG_SHIFT)
 
-static int
-i40e_init_ethtype_filter_list(struct rte_eth_dev *dev)
-{
-	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-	struct i40e_ethertype_rule *ethertype_rule = &pf->ethertype;
-	char ethertype_hash_name[RTE_HASH_NAMESIZE];
-	int ret;
-
-	struct rte_hash_parameters ethertype_hash_params = {
-		.name = ethertype_hash_name,
-		.entries = I40E_MAX_ETHERTYPE_FILTER_NUM,
-		.key_len = sizeof(struct i40e_ethertype_filter_input),
-		.hash_func = rte_hash_crc,
-		.hash_func_init_val = 0,
-		.socket_id = rte_socket_id(),
-	};
-
-	/* Initialize ethertype filter rule list and hash */
-	TAILQ_INIT(&ethertype_rule->ethertype_list);
-	snprintf(ethertype_hash_name, RTE_HASH_NAMESIZE,
-		 "ethertype_%s", dev->device->name);
-	ethertype_rule->hash_table = rte_hash_create(&ethertype_hash_params);
-	if (!ethertype_rule->hash_table) {
-		PMD_INIT_LOG(ERR, "Failed to create ethertype hash table!");
-		return -EINVAL;
-	}
-	ethertype_rule->hash_map = rte_zmalloc("i40e_ethertype_hash_map",
-				       sizeof(struct i40e_ethertype_filter *) *
-				       I40E_MAX_ETHERTYPE_FILTER_NUM,
-				       0);
-	if (!ethertype_rule->hash_map) {
-		PMD_INIT_LOG(ERR,
-			     "Failed to allocate memory for ethertype hash map!");
-		ret = -ENOMEM;
-		goto err_ethertype_hash_map_alloc;
-	}
-
-	return 0;
-
-err_ethertype_hash_map_alloc:
-	rte_hash_free(ethertype_rule->hash_table);
-
-	return ret;
-}
-
 static int
 i40e_init_tunnel_filter_list(struct rte_eth_dev *dev)
 {
@@ -1831,9 +1779,6 @@ eth_i40e_dev_init(struct rte_eth_dev *dev, void *init_params __rte_unused)
 	/* Initialize the filter invalidation configuration */
 	i40e_init_filter_invalidation(pf);
 
-	ret = i40e_init_ethtype_filter_list(dev);
-	if (ret < 0)
-		goto err_init_ethtype_filter_list;
 	ret = i40e_init_tunnel_filter_list(dev);
 	if (ret < 0)
 		goto err_init_tunnel_filter_list;
@@ -1865,9 +1810,6 @@ eth_i40e_dev_init(struct rte_eth_dev *dev, void *init_params __rte_unused)
 	rte_hash_free(pf->tunnel.hash_table);
 	rte_free(pf->tunnel.hash_map);
 err_init_tunnel_filter_list:
-	rte_hash_free(pf->ethertype.hash_table);
-	rte_free(pf->ethertype.hash_map);
-err_init_ethtype_filter_list:
 	rte_intr_callback_unregister(intr_handle,
 		i40e_dev_interrupt_handler, dev);
 	rte_free(dev->data->mac_addrs);
@@ -1890,24 +1832,6 @@ eth_i40e_dev_init(struct rte_eth_dev *dev, void *init_params __rte_unused)
 	return ret;
 }
 
-static void
-i40e_rm_ethtype_filter_list(struct i40e_pf *pf)
-{
-	struct i40e_ethertype_filter *p_ethertype;
-	struct i40e_ethertype_rule *ethertype_rule;
-
-	ethertype_rule = &pf->ethertype;
-	/* Remove all ethertype filter rules and hash */
-	rte_free(ethertype_rule->hash_map);
-	rte_hash_free(ethertype_rule->hash_table);
-
-	while ((p_ethertype = TAILQ_FIRST(&ethertype_rule->ethertype_list))) {
-		TAILQ_REMOVE(&ethertype_rule->ethertype_list,
-			     p_ethertype, rules);
-		rte_free(p_ethertype);
-	}
-}
-
 static void
 i40e_rm_tunnel_filter_list(struct i40e_pf *pf)
 {
@@ -2805,7 +2729,6 @@ i40e_dev_close(struct rte_eth_dev *dev)
 		i40e_msec_delay(500);
 	} while (retries++ < 5);
 
-	i40e_rm_ethtype_filter_list(pf);
 	i40e_rm_tunnel_filter_list(pf);
 	i40e_rm_fdir_filter_list(pf);
 
@@ -9891,130 +9814,16 @@ i40e_set_hash_inset(struct i40e_hw *hw, uint64_t input_set,
 	return 0;
 }
 
-/* Convert ethertype filter structure */
-static int
-i40e_ethertype_filter_convert(const struct rte_eth_ethertype_filter *input,
-			      struct i40e_ethertype_filter *filter)
-{
-	memcpy(&filter->input.mac_addr, &input->mac_addr,
-		RTE_ETHER_ADDR_LEN);
-	filter->input.ether_type = input->ether_type;
-	filter->flags = input->flags;
-	filter->queue = input->queue;
-
-	return 0;
-}
-
-/* Check if there exists the ethertype filter */
-struct i40e_ethertype_filter *
-i40e_sw_ethertype_filter_lookup(struct i40e_ethertype_rule *ethertype_rule,
-				const struct i40e_ethertype_filter_input *input)
-{
-	int ret;
-
-	ret = rte_hash_lookup(ethertype_rule->hash_table, (const void *)input);
-	if (ret < 0)
-		return NULL;
-
-	return ethertype_rule->hash_map[ret];
-}
-
-/* Add ethertype filter in SW list */
-static int
-i40e_sw_ethertype_filter_insert(struct i40e_pf *pf,
-				struct i40e_ethertype_filter *filter)
-{
-	struct i40e_ethertype_rule *rule = &pf->ethertype;
-	int ret;
-
-	ret = rte_hash_add_key(rule->hash_table, &filter->input);
-	if (ret < 0) {
-		PMD_DRV_LOG(ERR,
-			    "Failed to insert ethertype filter"
-			    " to hash table %d!",
-			    ret);
-		return ret;
-	}
-	rule->hash_map[ret] = filter;
-
-	TAILQ_INSERT_TAIL(&rule->ethertype_list, filter, rules);
-
-	return 0;
-}
-
-/* Delete ethertype filter in SW list */
 int
-i40e_sw_ethertype_filter_del(struct i40e_pf *pf,
-			     struct i40e_ethertype_filter_input *input)
-{
-	struct i40e_ethertype_rule *rule = &pf->ethertype;
-	struct i40e_ethertype_filter *filter;
-	int ret;
-
-	ret = rte_hash_del_key(rule->hash_table, input);
-	if (ret < 0) {
-		PMD_DRV_LOG(ERR,
-			    "Failed to delete ethertype filter"
-			    " to hash table %d!",
-			    ret);
-		return ret;
-	}
-	filter = rule->hash_map[ret];
-	rule->hash_map[ret] = NULL;
-
-	TAILQ_REMOVE(&rule->ethertype_list, filter, rules);
-	rte_free(filter);
-
-	return 0;
-}
-
-/*
- * Configure ethertype filter, which can director packet by filtering
- * with mac address and ether_type or only ether_type
- */
-int
-i40e_ethertype_filter_set(struct i40e_pf *pf,
+i40e_ethertype_filter_program(struct i40e_pf *pf,
 			struct rte_eth_ethertype_filter *filter,
 			bool add)
 {
 	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
-	struct i40e_ethertype_rule *ethertype_rule = &pf->ethertype;
-	struct i40e_ethertype_filter *ethertype_filter, *node;
-	struct i40e_ethertype_filter check_filter;
 	struct i40e_control_filter_stats stats;
 	uint16_t flags = 0;
 	int ret;
 
-	if (filter->queue >= pf->dev_data->nb_rx_queues) {
-		PMD_DRV_LOG(ERR, "Invalid queue ID");
-		return -EINVAL;
-	}
-	if (filter->ether_type == RTE_ETHER_TYPE_IPV4 ||
-		filter->ether_type == RTE_ETHER_TYPE_IPV6) {
-		PMD_DRV_LOG(ERR,
-			"unsupported ether_type(0x%04x) in control packet filter.",
-			filter->ether_type);
-		return -EINVAL;
-	}
-	if (filter->ether_type == RTE_ETHER_TYPE_VLAN)
-		PMD_DRV_LOG(WARNING,
-			"filter vlan ether_type in first tag is not supported.");
-
-	/* Check if there is the filter in SW list */
-	memset(&check_filter, 0, sizeof(check_filter));
-	i40e_ethertype_filter_convert(filter, &check_filter);
-	node = i40e_sw_ethertype_filter_lookup(ethertype_rule,
-					       &check_filter.input);
-	if (add && node) {
-		PMD_DRV_LOG(ERR, "Conflict with existing ethertype rules!");
-		return -EINVAL;
-	}
-
-	if (!add && !node) {
-		PMD_DRV_LOG(ERR, "There's no corresponding ethertype filter!");
-		return -EINVAL;
-	}
-
 	if (!(filter->flags & RTE_ETHTYPE_FLAGS_MAC))
 		flags |= I40E_AQC_ADD_CONTROL_PACKET_FLAGS_IGNORE_MAC;
 	if (filter->flags & RTE_ETHTYPE_FLAGS_DROP)
@@ -10035,25 +9844,7 @@ i40e_ethertype_filter_set(struct i40e_pf *pf,
 	if (ret < 0)
 		return -ENOSYS;
 
-	/* Add or delete a filter in SW list */
-	if (add) {
-		ethertype_filter = rte_zmalloc("ethertype_filter",
-				       sizeof(*ethertype_filter), 0);
-		if (ethertype_filter == NULL) {
-			PMD_DRV_LOG(ERR, "Failed to alloc memory.");
-			return -ENOMEM;
-		}
-
-		memcpy(ethertype_filter, &check_filter,
-			   sizeof(check_filter));
-		ret = i40e_sw_ethertype_filter_insert(pf, ethertype_filter);
-		if (ret < 0)
-			rte_free(ethertype_filter);
-	} else {
-		ret = i40e_sw_ethertype_filter_del(pf, &node->input);
-	}
-
-	return ret;
+	return 0;
 }
 
 static int
@@ -11624,52 +11415,6 @@ i40e_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu __rte_unused)
 	return 0;
 }
 
-/* Restore ethertype filter */
-static void
-i40e_ethertype_filter_restore(struct i40e_pf *pf)
-{
-	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
-	struct i40e_ethertype_filter_list
-		*ethertype_list = &pf->ethertype.ethertype_list;
-	struct i40e_ethertype_filter *f;
-	struct i40e_control_filter_stats stats;
-	enum i40e_status_code ret;
-	uint16_t flags;
-	bool stats_valid = false;
-
-	TAILQ_FOREACH(f, ethertype_list, rules) {
-		flags = 0;
-		if (!(f->flags & RTE_ETHTYPE_FLAGS_MAC))
-			flags |= I40E_AQC_ADD_CONTROL_PACKET_FLAGS_IGNORE_MAC;
-		if (f->flags & RTE_ETHTYPE_FLAGS_DROP)
-			flags |= I40E_AQC_ADD_CONTROL_PACKET_FLAGS_DROP;
-		flags |= I40E_AQC_ADD_CONTROL_PACKET_FLAGS_TO_QUEUE;
-
-		ret = i40e_aq_add_rem_control_packet_filter(hw,
-					    f->input.mac_addr.addr_bytes,
-					    f->input.ether_type,
-					    flags, pf->main_vsi->seid,
-					    f->queue, 1, &stats, NULL);
-		if (ret != I40E_SUCCESS) {
-			PMD_DRV_LOG(ERR,
-				    "Failed to restore ethertype filter, ether_type=0x%04x, queue=%u, vsi_seid=%u, err %d",
-				    f->input.ether_type, f->queue,
-				    pf->main_vsi->seid, ret);
-			continue;
-		}
-
-		stats_valid = true;
-	}
-
-	if (stats_valid) {
-		PMD_DRV_LOG(INFO, "Ethertype filter:"
-			    " mac_etype_used = %u, etype_used = %u,"
-			    " mac_etype_free = %u, etype_free = %u",
-			    stats.mac_etype_used, stats.etype_used,
-			    stats.mac_etype_free, stats.etype_free);
-	}
-}
-
 /* Restore tunnel filter */
 static void
 i40e_tunnel_filter_restore(struct i40e_pf *pf)
@@ -11728,7 +11473,6 @@ i40e_tunnel_filter_restore(struct i40e_pf *pf)
 static void
 i40e_filter_restore(struct i40e_pf *pf)
 {
-	i40e_ethertype_filter_restore(pf);
 	i40e_tunnel_filter_restore(pf);
 	i40e_fdir_filter_restore(pf);
 	(void)i40e_hash_filter_restore(pf);
diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 16b67268f7f..f674f7995d8 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -805,27 +805,6 @@ struct i40e_fdir_info {
 /* Ethertype filter number HW supports */
 #define I40E_MAX_ETHERTYPE_FILTER_NUM 768
 
-/* Ethertype filter struct */
-struct i40e_ethertype_filter_input {
-	struct rte_ether_addr mac_addr;   /* Mac address to match */
-	uint16_t ether_type;          /* Ether type to match */
-};
-
-struct i40e_ethertype_filter {
-	TAILQ_ENTRY(i40e_ethertype_filter) rules;
-	struct i40e_ethertype_filter_input input;
-	uint16_t flags;              /* Flags from RTE_ETHTYPE_FLAGS_* */
-	uint16_t queue;              /* Queue assigned to when match */
-};
-
-TAILQ_HEAD(i40e_ethertype_filter_list, i40e_ethertype_filter);
-
-struct i40e_ethertype_rule {
-	struct i40e_ethertype_filter_list ethertype_list;
-	struct i40e_ethertype_filter  **hash_map;
-	struct rte_hash *hash_table;
-};
-
 /* queue region info */
 struct i40e_queue_region_info {
 	/* the region id for this configuration */
@@ -1176,7 +1155,6 @@ struct i40e_pf {
 	struct i40e_vmdq_info *vmdq;
 
 	struct i40e_fdir_info fdir; /* flow director info */
-	struct i40e_ethertype_rule ethertype; /* Ethertype filter rule */
 	struct i40e_tunnel_rule tunnel; /* Tunnel filter rule */
 	struct i40e_rss_conf_list rss_config_list; /* RSS rule list */
 	struct i40e_queue_regions queue_region; /* queue region info */
@@ -1325,7 +1303,6 @@ extern const struct rte_flow_ops i40e_flow_ops;
 
 struct i40e_filter_ctx {
 	union {
-		struct rte_eth_ethertype_filter ethertype_filter;
 		struct i40e_fdir_filter_conf fdir_filter;
 		struct i40e_tunnel_filter_conf consistent_tunnel_filter;
 		struct i40e_rte_flow_rss_conf rss_conf;
@@ -1407,11 +1384,6 @@ int i40e_rx_burst_mode_get(struct rte_eth_dev *dev, uint16_t queue_id,
 			   struct rte_eth_burst_mode *mode);
 int i40e_tx_burst_mode_get(struct rte_eth_dev *dev, uint16_t queue_id,
 			   struct rte_eth_burst_mode *mode);
-struct i40e_ethertype_filter *
-i40e_sw_ethertype_filter_lookup(struct i40e_ethertype_rule *ethertype_rule,
-			const struct i40e_ethertype_filter_input *input);
-int i40e_sw_ethertype_filter_del(struct i40e_pf *pf,
-				 struct i40e_ethertype_filter_input *input);
 int i40e_sw_fdir_filter_del(struct i40e_pf *pf,
 			    struct i40e_fdir_input *input);
 struct i40e_tunnel_filter *
@@ -1420,7 +1392,7 @@ i40e_sw_tunnel_filter_lookup(struct i40e_tunnel_rule *tunnel_rule,
 int i40e_sw_tunnel_filter_del(struct i40e_pf *pf,
 			      struct i40e_tunnel_filter_input *input);
 uint64_t i40e_get_default_input_set(uint16_t pctype);
-int i40e_ethertype_filter_set(struct i40e_pf *pf,
+int i40e_ethertype_filter_program(struct i40e_pf *pf,
 			      struct rte_eth_ethertype_filter *filter,
 			      bool add);
 struct rte_flow *
diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 7d410b6c33b..8f09dfeb11d 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -30,7 +30,11 @@
 
 #include "../common/flow_check.h"
 
-const struct ci_flow_engine_list i40e_flow_engine_list = {0};
+const struct ci_flow_engine_list i40e_flow_engine_list = {
+	{
+		&i40e_flow_engine_ethertype,
+	}
+};
 
 #define I40E_IPV6_TC_MASK	(0xFF << I40E_FDIR_IPv6_TC_OFFSET)
 #define I40E_IPV6_FRAG_HEADER	44
@@ -60,15 +64,6 @@ static int i40e_flow_dev_dump(struct rte_eth_dev *dev,
 			      struct rte_flow *flow,
 			      FILE *file,
 			      struct rte_flow_error *error);
-static int
-i40e_flow_parse_ethertype_pattern(struct rte_eth_dev *dev,
-				  const struct rte_flow_item *pattern,
-				  struct rte_flow_error *error,
-				  struct rte_eth_ethertype_filter *filter);
-static int i40e_flow_parse_ethertype_action(struct rte_eth_dev *dev,
-				    const struct rte_flow_action *actions,
-				    struct rte_flow_error *error,
-				    struct rte_eth_ethertype_filter *filter);
 static int i40e_flow_parse_fdir_pattern(struct rte_eth_dev *dev,
 					const struct rte_flow_item *pattern,
 					struct rte_flow_error *error,
@@ -81,11 +76,6 @@ static int i40e_flow_parse_tunnel_action(struct rte_eth_dev *dev,
 				 const struct rte_flow_action *actions,
 				 struct rte_flow_error *error,
 				 struct i40e_tunnel_filter_conf *filter);
-static int i40e_flow_parse_ethertype_filter(struct rte_eth_dev *dev,
-				    const struct rte_flow_item pattern[],
-				    const struct rte_flow_action actions[],
-				    struct rte_flow_error *error,
-				    struct i40e_filter_ctx *filter);
 static int i40e_flow_parse_fdir_filter(struct rte_eth_dev *dev,
 				       const struct rte_flow_item pattern[],
 				       const struct rte_flow_action actions[],
@@ -111,12 +101,9 @@ static int i40e_flow_parse_gtp_filter(struct rte_eth_dev *dev,
 				      const struct rte_flow_action actions[],
 				      struct rte_flow_error *error,
 				      struct i40e_filter_ctx *filter);
-static int i40e_flow_destroy_ethertype_filter(struct i40e_pf *pf,
-				      struct i40e_ethertype_filter *filter);
 static int i40e_flow_destroy_tunnel_filter(struct i40e_pf *pf,
 					   struct i40e_tunnel_filter *filter);
 static int i40e_flow_flush_fdir_filter(struct i40e_pf *pf);
-static int i40e_flow_flush_ethertype_filter(struct i40e_pf *pf);
 static int i40e_flow_flush_tunnel_filter(struct i40e_pf *pf);
 static int
 i40e_flow_parse_qinq_filter(struct rte_eth_dev *dev,
@@ -987,8 +974,6 @@ static enum rte_flow_item_type pattern_fdir_ipv6_udp_esp[] = {
 };
 
 static struct i40e_valid_pattern i40e_supported_patterns[] = {
-	/* Ethertype */
-	{ pattern_ethertype, i40e_flow_parse_ethertype_filter },
 	/* FDIR - support default flow type without flexible payload*/
 	{ pattern_ethertype, i40e_flow_parse_fdir_filter },
 	{ pattern_fdir_ipv4, i40e_flow_parse_fdir_filter },
@@ -1206,8 +1191,6 @@ static const char *
 i40e_flow_rule_name(enum rte_filter_type filter_type)
 {
 	switch (filter_type) {
-	case RTE_ETH_FILTER_ETHERTYPE:
-		return "ethertype";
 	case RTE_ETH_FILTER_FDIR:
 		return "fdir";
 	case RTE_ETH_FILTER_TUNNEL:
@@ -1223,8 +1206,6 @@ static size_t
 i40e_flow_rule_size(enum rte_filter_type filter_type)
 {
 	switch (filter_type) {
-	case RTE_ETH_FILTER_ETHERTYPE:
-		return sizeof(struct i40e_ethertype_filter);
 	case RTE_ETH_FILTER_FDIR:
 		return sizeof(struct i40e_fdir_filter);
 	case RTE_ETH_FILTER_TUNNEL:
@@ -1324,11 +1305,11 @@ i40e_flow_dev_dump(struct rte_eth_dev *dev,
 	return 0;
 }
 
-static int
-i40e_get_outer_vlan(struct rte_eth_dev *dev, uint16_t *tpid)
+int
+i40e_get_outer_vlan(struct i40e_pf *pf, uint16_t *tpid)
 {
-	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	int qinq = dev->data->dev_conf.rxmode.offloads &
+	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
+	int qinq = pf->dev_data->dev_conf.rxmode.offloads &
 		RTE_ETH_RX_OFFLOAD_VLAN_EXTEND;
 	uint64_t reg_r = 0;
 	uint16_t reg_id;
@@ -1351,181 +1332,6 @@ i40e_get_outer_vlan(struct rte_eth_dev *dev, uint16_t *tpid)
 	return 0;
 }
 
-/* 1. Last in item should be NULL as range is not supported.
- * 2. Supported filter types: MAC_ETHTYPE and ETHTYPE.
- * 3. SRC mac_addr mask should be 00:00:00:00:00:00.
- * 4. DST mac_addr mask should be 00:00:00:00:00:00 or
- *    FF:FF:FF:FF:FF:FF
- * 5. Ether_type mask should be 0xFFFF.
- */
-static int
-i40e_flow_parse_ethertype_pattern(struct rte_eth_dev *dev,
-				  const struct rte_flow_item *pattern,
-				  struct rte_flow_error *error,
-				  struct rte_eth_ethertype_filter *filter)
-{
-	const struct rte_flow_item *item = pattern;
-	const struct rte_flow_item_eth *eth_spec;
-	const struct rte_flow_item_eth *eth_mask;
-	enum rte_flow_item_type item_type;
-	int ret;
-	uint16_t tpid;
-
-	for (; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ITEM,
-					   item,
-					   "Not support range");
-			return -rte_errno;
-		}
-		item_type = item->type;
-		switch (item_type) {
-		case RTE_FLOW_ITEM_TYPE_ETH:
-			eth_spec = item->spec;
-			eth_mask = item->mask;
-			/* Get the MAC info. */
-			if (!eth_spec || !eth_mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "NULL ETH spec/mask");
-				return -rte_errno;
-			}
-
-			/* Mask bits of source MAC address must be full of 0.
-			 * Mask bits of destination MAC address must be full
-			 * of 1 or full of 0.
-			 */
-			if (!rte_is_zero_ether_addr(&eth_mask->hdr.src_addr) ||
-			    (!rte_is_zero_ether_addr(&eth_mask->hdr.dst_addr) &&
-			     !rte_is_broadcast_ether_addr(&eth_mask->hdr.dst_addr))) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid MAC_addr mask");
-				return -rte_errno;
-			}
-
-			if ((eth_mask->hdr.ether_type & UINT16_MAX) != UINT16_MAX) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid ethertype mask");
-				return -rte_errno;
-			}
-
-			/* If mask bits of destination MAC address
-			 * are full of 1, set RTE_ETHTYPE_FLAGS_MAC.
-			 */
-			if (rte_is_broadcast_ether_addr(&eth_mask->hdr.dst_addr)) {
-				filter->mac_addr = eth_spec->hdr.dst_addr;
-				filter->flags |= RTE_ETHTYPE_FLAGS_MAC;
-			} else {
-				filter->flags &= ~RTE_ETHTYPE_FLAGS_MAC;
-			}
-			filter->ether_type = rte_be_to_cpu_16(eth_spec->hdr.ether_type);
-
-			if (filter->ether_type == RTE_ETHER_TYPE_IPV4 ||
-			    filter->ether_type == RTE_ETHER_TYPE_IPV6 ||
-			    filter->ether_type == RTE_ETHER_TYPE_LLDP) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Unsupported ether_type in control packet filter.");
-				return -rte_errno;
-			}
-
-			ret = i40e_get_outer_vlan(dev, &tpid);
-			if (ret != 0) {
-				rte_flow_error_set(error, EIO,
-						RTE_FLOW_ERROR_TYPE_ITEM,
-						item,
-						"Can not get the Ethertype identifying the L2 tag");
-				return -rte_errno;
-			}
-			if (filter->ether_type == tpid) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Unsupported ether_type in"
-						   " control packet filter.");
-				return -rte_errno;
-			}
-
-			break;
-		default:
-			break;
-		}
-	}
-
-	return 0;
-}
-
-/* Ethertype action only supports QUEUE or DROP. */
-static int
-i40e_flow_parse_ethertype_action(struct rte_eth_dev *dev,
-				 const struct rte_flow_action *actions,
-				 struct rte_flow_error *error,
-				 struct rte_eth_ethertype_filter *filter)
-{
-	struct ci_flow_actions parsed_actions = {0};
-	struct ci_flow_actions_check_param ac_param = {
-		.allowed_types = (enum rte_flow_action_type[]) {
-			RTE_FLOW_ACTION_TYPE_QUEUE,
-			RTE_FLOW_ACTION_TYPE_DROP,
-			RTE_FLOW_ACTION_TYPE_END,
-		},
-		.max_actions = 1,
-	};
-	const struct rte_flow_action *action;
-	int ret;
-
-	ret = ci_flow_check_actions(actions, &ac_param, &parsed_actions, error);
-	if (ret)
-		return ret;
-	action = parsed_actions.actions[0];
-
-	if (action->type == RTE_FLOW_ACTION_TYPE_QUEUE) {
-		const struct rte_flow_action_queue *act_q = action->conf;
-		/* check queue index */
-		if (act_q->index >= dev->data->nb_rx_queues) {
-			return rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ACTION, action,
-					"Invalid queue index");
-		}
-		filter->queue = act_q->index;
-	} else if (action->type == RTE_FLOW_ACTION_TYPE_DROP) {
-		filter->flags |= RTE_ETHTYPE_FLAGS_DROP;
-	}
-	return 0;
-}
-
-static int
-i40e_flow_parse_ethertype_filter(struct rte_eth_dev *dev,
-				 const struct rte_flow_item pattern[],
-				 const struct rte_flow_action actions[],
-				 struct rte_flow_error *error,
-				 struct i40e_filter_ctx *filter)
-{
-	struct rte_eth_ethertype_filter *ethertype_filter = &filter->ethertype_filter;
-	int ret;
-
-	ret = i40e_flow_parse_ethertype_pattern(dev, pattern, error,
-						ethertype_filter);
-	if (ret)
-		return ret;
-
-	ret = i40e_flow_parse_ethertype_action(dev, actions, error,
-					       ethertype_filter);
-	if (ret)
-		return ret;
-
-	filter->type = RTE_ETH_FILTER_ETHERTYPE;
-
-	return ret;
-}
-
 static int
 i40e_flow_check_raw_item(const struct rte_flow_item *item,
 			 const struct rte_flow_item_raw *raw_spec,
@@ -1786,7 +1592,7 @@ i40e_flow_parse_fdir_pattern(struct rte_eth_dev *dev,
 						     "Unsupported ether_type.");
 					return -rte_errno;
 				}
-				ret = i40e_get_outer_vlan(dev, &tpid);
+				ret = i40e_get_outer_vlan(pf, &tpid);
 				if (ret != 0) {
 					rte_flow_error_set(error, EIO,
 							RTE_FLOW_ERROR_TYPE_ITEM,
@@ -1852,7 +1658,7 @@ i40e_flow_parse_fdir_pattern(struct rte_eth_dev *dev,
 						     "Unsupported inner_type.");
 					return -rte_errno;
 				}
-				ret = i40e_get_outer_vlan(dev, &tpid);
+				ret = i40e_get_outer_vlan(pf, &tpid);
 				if (ret != 0) {
 					rte_flow_error_set(error, EIO,
 							RTE_FLOW_ERROR_TYPE_ITEM,
@@ -3991,13 +3797,6 @@ i40e_flow_create(struct rte_eth_dev *dev,
 	}
 
 	switch (filter_ctx.type) {
-	case RTE_ETH_FILTER_ETHERTYPE:
-		ret = i40e_ethertype_filter_set(pf, &filter_ctx.ethertype_filter, 1);
-		if (ret)
-			goto free_flow;
-		flow->rule = TAILQ_LAST(&pf->ethertype.ethertype_list,
-					i40e_ethertype_filter_list);
-		break;
 	case RTE_ETH_FILTER_FDIR:
 		ret = i40e_flow_add_del_fdir_filter(dev, &filter_ctx.fdir_filter, 1);
 		if (ret)
@@ -4057,10 +3856,6 @@ i40e_flow_destroy(struct rte_eth_dev *dev,
 		return 0;
 
 	switch (filter_type) {
-	case RTE_ETH_FILTER_ETHERTYPE:
-		ret = i40e_flow_destroy_ethertype_filter(pf,
-			 (struct i40e_ethertype_filter *)flow->rule);
-		break;
 	case RTE_ETH_FILTER_TUNNEL:
 		ret = i40e_flow_destroy_tunnel_filter(pf,
 			      (struct i40e_tunnel_filter *)flow->rule);
@@ -4100,41 +3895,6 @@ i40e_flow_destroy(struct rte_eth_dev *dev,
 	return ret;
 }
 
-static int
-i40e_flow_destroy_ethertype_filter(struct i40e_pf *pf,
-				   struct i40e_ethertype_filter *filter)
-{
-	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
-	struct i40e_ethertype_rule *ethertype_rule = &pf->ethertype;
-	struct i40e_ethertype_filter *node;
-	struct i40e_control_filter_stats stats;
-	uint16_t flags = 0;
-	int ret = 0;
-
-	if (!(filter->flags & RTE_ETHTYPE_FLAGS_MAC))
-		flags |= I40E_AQC_ADD_CONTROL_PACKET_FLAGS_IGNORE_MAC;
-	if (filter->flags & RTE_ETHTYPE_FLAGS_DROP)
-		flags |= I40E_AQC_ADD_CONTROL_PACKET_FLAGS_DROP;
-	flags |= I40E_AQC_ADD_CONTROL_PACKET_FLAGS_TO_QUEUE;
-
-	memset(&stats, 0, sizeof(stats));
-	ret = i40e_aq_add_rem_control_packet_filter(hw,
-				    filter->input.mac_addr.addr_bytes,
-				    filter->input.ether_type,
-				    flags, pf->main_vsi->seid,
-				    filter->queue, 0, &stats, NULL);
-	if (ret < 0)
-		return ret;
-
-	node = i40e_sw_ethertype_filter_lookup(ethertype_rule, &filter->input);
-	if (!node)
-		return -EINVAL;
-
-	ret = i40e_sw_ethertype_filter_del(pf, &node->input);
-
-	return ret;
-}
-
 static int
 i40e_flow_destroy_tunnel_filter(struct i40e_pf *pf,
 				struct i40e_tunnel_filter *filter)
@@ -4213,14 +3973,6 @@ i40e_flow_flush(struct rte_eth_dev *dev, struct rte_flow_error *error)
 		return -rte_errno;
 	}
 
-	ret = i40e_flow_flush_ethertype_filter(pf);
-	if (ret) {
-		rte_flow_error_set(error, -ret,
-				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-				   "Failed to ethertype flush flows.");
-		return -rte_errno;
-	}
-
 	ret = i40e_flow_flush_tunnel_filter(pf);
 	if (ret) {
 		rte_flow_error_set(error, -ret,
@@ -4297,34 +4049,6 @@ i40e_flow_flush_fdir_filter(struct i40e_pf *pf)
 	return ret;
 }
 
-/* Flush all ethertype filters */
-static int
-i40e_flow_flush_ethertype_filter(struct i40e_pf *pf)
-{
-	struct i40e_ethertype_filter_list
-		*ethertype_list = &pf->ethertype.ethertype_list;
-	struct i40e_ethertype_filter *filter;
-	struct rte_flow *flow;
-	void *temp;
-	int ret = 0;
-
-	while ((filter = TAILQ_FIRST(ethertype_list))) {
-		ret = i40e_flow_destroy_ethertype_filter(pf, filter);
-		if (ret)
-			return ret;
-	}
-
-	/* Delete ethertype flows in flow list. */
-	RTE_TAILQ_FOREACH_SAFE(flow, &pf->flow_list, node, temp) {
-		if (flow->filter_type == RTE_ETH_FILTER_ETHERTYPE) {
-			TAILQ_REMOVE(&pf->flow_list, flow, node);
-			rte_free(flow);
-		}
-	}
-
-	return ret;
-}
-
 /* Flush all tunnel filters */
 static int
 i40e_flow_flush_tunnel_filter(struct i40e_pf *pf)
diff --git a/drivers/net/intel/i40e/i40e_flow.h b/drivers/net/intel/i40e/i40e_flow.h
index c9588686619..11d13a76fe9 100644
--- a/drivers/net/intel/i40e/i40e_flow.h
+++ b/drivers/net/intel/i40e/i40e_flow.h
@@ -7,6 +7,10 @@
 
 #include "../common/flow_engine.h"
 
+int i40e_get_outer_vlan(struct i40e_pf *pf, uint16_t *tpid);
+
 extern const struct ci_flow_engine_list i40e_flow_engine_list;
 
+extern const struct ci_flow_engine i40e_flow_engine_ethertype;
+
 #endif /* _I40E_FLOW_H_ */
diff --git a/drivers/net/intel/i40e/i40e_flow_ethertype.c b/drivers/net/intel/i40e/i40e_flow_ethertype.c
new file mode 100644
index 00000000000..644bff2b1ed
--- /dev/null
+++ b/drivers/net/intel/i40e/i40e_flow_ethertype.c
@@ -0,0 +1,351 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include <rte_hash.h>
+#include <rte_hash_crc.h>
+
+#include "i40e_ethdev.h"
+#include "i40e_flow.h"
+
+#include "../common/flow_engine.h"
+#include "../common/flow_check.h"
+#include "../common/flow_util.h"
+
+struct i40e_ethertype_ctx {
+	struct ci_flow_engine_ctx base;
+	struct rte_eth_ethertype_filter ethertype;
+};
+
+struct i40e_ethertype_flow {
+	struct rte_flow base;
+	struct rte_eth_ethertype_filter ethertype;
+};
+
+/* leading fields of struct rte_eth_ethertype_filter, used as the dedup hash key */
+struct i40e_ethertype_key {
+	struct rte_ether_addr mac_addr;
+	uint16_t ether_type;
+};
+
+struct i40e_ethertype_priv {
+	struct rte_hash *hash_table;
+};
+
+/**
+ * Ethertype filter graph implementation
+ * Pattern: START -> ETH -> END
+ */
+
+enum i40e_ethertype_node_id {
+	I40E_ETHERTYPE_NODE_START = FLOW_GRAPH_NODE_FIRST,
+	I40E_ETHERTYPE_NODE_ETH,
+	I40E_ETHERTYPE_NODE_END,
+	I40E_ETHERTYPE_NODE_MAX,
+};
+
+static int
+i40e_ethertype_node_eth_validate(const void *ctx __rte_unused,
+		const struct rte_flow_item *item, struct rte_flow_error *error)
+{
+	const struct rte_flow_item_eth *eth_spec = item->spec;
+	const struct rte_flow_item_eth *eth_mask = ci_flow_item_mask(item);
+	uint16_t ether_type;
+
+	/* Source MAC mask must be all zeros */
+	if (!CI_FIELD_IS_ZERO(&eth_mask->hdr.src_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Source MAC filtering not supported");
+	}
+
+	/* Dest MAC mask must be all zeros or all ones */
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&eth_mask->hdr.dst_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Dest MAC filtering not supported");
+	}
+
+	/* Ethertype mask must be exact match */
+	if (!CI_FIELD_IS_MASKED(&eth_mask->hdr.ether_type)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Ethertype must be exactly matched");
+	}
+
+	/* Check for valid ethertype (not IPv4/IPv6/LLDP/VLAN) */
+	ether_type = rte_be_to_cpu_16(eth_spec->hdr.ether_type);
+	if (ether_type == RTE_ETHER_TYPE_IPV4 ||
+	    ether_type == RTE_ETHER_TYPE_IPV6 ||
+	    ether_type == RTE_ETHER_TYPE_LLDP ||
+	    ether_type == RTE_ETHER_TYPE_VLAN) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"IPv4/IPv6/LLDP/VLAN not supported by ethertype filter");
+	}
+
+	return 0;
+}
+
+static int
+i40e_ethertype_node_eth_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	struct i40e_ethertype_ctx *ethertype_ctx = ctx;
+	struct rte_eth_ethertype_filter *filter = &ethertype_ctx->ethertype;
+	const struct rte_flow_item_eth *eth_spec = item->spec;
+	const struct rte_flow_item_eth *eth_mask = ci_flow_item_mask(item);
+	uint16_t ether_type, tpid;
+	/* pf cannot be const so it's here rather than in validate() */
+	struct rte_eth_dev_data *dev_data = ethertype_ctx->base.dev_data;
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev_data->dev_private);
+
+	ether_type = rte_be_to_cpu_16(eth_spec->hdr.ether_type);
+
+	if (CI_FIELD_IS_MASKED(&eth_mask->hdr.dst_addr)) {
+		filter->mac_addr = eth_spec->hdr.dst_addr;
+		filter->flags |= RTE_ETHTYPE_FLAGS_MAC;
+	}
+
+	/* Cannot match currently installed VLAN ethertype */
+	if (i40e_get_outer_vlan(pf, &tpid) != 0) {
+		return rte_flow_error_set(error, EIO,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Can not get the Ethertype identifying the L2 tag");
+	}
+	if (ether_type == tpid) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Unsupported ether_type in control packet filter.");
+	}
+
+	filter->ether_type = ether_type;
+
+	return 0;
+}
+
+static const struct flow_graph i40e_ethertype_graph = {
+	.nodes = (struct flow_graph_node[]) {
+		[I40E_ETHERTYPE_NODE_START] = {
+			.name = "START",
+		},
+		[I40E_ETHERTYPE_NODE_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC,
+			.validate = i40e_ethertype_node_eth_validate,
+			.process = i40e_ethertype_node_eth_process,
+		},
+		[I40E_ETHERTYPE_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	},
+	.edges = (struct flow_graph_edge[]) {
+		[I40E_ETHERTYPE_NODE_START] = {
+			.next = (size_t[]) {
+				I40E_ETHERTYPE_NODE_ETH,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_ETHERTYPE_NODE_ETH] = {
+			.next = (size_t[]) {
+				I40E_ETHERTYPE_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+static int
+i40e_flow_ethertype_ctx_init(const struct rte_flow_action *actions,
+		const struct rte_flow_attr *attr,
+		struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	struct i40e_ethertype_ctx *ethertype_ctx = (struct i40e_ethertype_ctx *)ctx;
+	struct rte_eth_dev_data *dev_data = ethertype_ctx->base.dev_data;
+	struct ci_flow_actions parsed_actions = {0};
+	struct ci_flow_actions_check_param ac_param = {
+		.allowed_types = (enum rte_flow_action_type[]) {
+			RTE_FLOW_ACTION_TYPE_QUEUE,
+			RTE_FLOW_ACTION_TYPE_DROP,
+			RTE_FLOW_ACTION_TYPE_END,
+		},
+		.max_actions = 1,
+	};
+	const struct rte_flow_action *action;
+	int ret;
+
+	ret = ci_flow_check_actions(actions, &ac_param, &parsed_actions, error);
+	if (ret)
+		return ret;
+
+	ret = ci_flow_check_attr(attr, NULL, error);
+	if (ret)
+		return ret;
+
+	action = parsed_actions.actions[0];
+
+	if (action->type == RTE_FLOW_ACTION_TYPE_QUEUE) {
+		const struct rte_flow_action_queue *act_q = action->conf;
+		/* check queue index */
+		if (act_q->index >= dev_data->nb_rx_queues) {
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ACTION, action,
+					"Invalid queue index");
+		}
+		ethertype_ctx->ethertype.queue = act_q->index;
+	} else if (action->type == RTE_FLOW_ACTION_TYPE_DROP) {
+		ethertype_ctx->ethertype.flags |= RTE_ETHTYPE_FLAGS_DROP;
+	}
+	return 0;
+}
+
+static int
+i40e_flow_ethertype_ctx_to_flow(const struct ci_flow_engine_ctx *ctx,
+		struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct i40e_ethertype_ctx *ethertype_ctx = (const struct i40e_ethertype_ctx *)ctx;
+	struct i40e_ethertype_flow *ethertype_flow = (struct i40e_ethertype_flow *)flow;
+
+	/* copy ethertype filter configuration to flow */
+	ethertype_flow->ethertype = ethertype_ctx->ethertype;
+
+	return 0;
+}
+
+static int
+i40e_flow_ethertype_register(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct i40e_ethertype_flow *ethertype_flow = (struct i40e_ethertype_flow *)flow;
+	struct i40e_ethertype_priv *priv = flow->engine_priv;
+	struct i40e_ethertype_key key;
+	int ret;
+
+	memcpy(&key, &ethertype_flow->ethertype, sizeof(key));
+
+	if (rte_hash_lookup(priv->hash_table, &key) >= 0) {
+		return rte_flow_error_set(error, EEXIST,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Conflict with existing ethertype filter");
+	}
+
+	ret = rte_hash_add_key(priv->hash_table, &key);
+	if (ret < 0) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Failed to register ethertype filter");
+	}
+
+	return 0;
+}
+
+static int
+i40e_flow_ethertype_unregister(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct i40e_ethertype_flow *ethertype_flow = (struct i40e_ethertype_flow *)flow;
+	struct i40e_ethertype_priv *priv = flow->engine_priv;
+	struct i40e_ethertype_key key;
+	int ret;
+
+	memcpy(&key, &ethertype_flow->ethertype, sizeof(key));
+
+	ret = rte_hash_del_key(priv->hash_table, &key);
+	if (ret < 0) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_HANDLE, flow,
+				"Ethertype filter not found on unregister");
+	}
+
+	return 0;
+}
+
+static int
+i40e_flow_ethertype_install(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct i40e_ethertype_flow *ethertype_flow = (struct i40e_ethertype_flow *)flow;
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(flow->dev_data->dev_private);
+	int ret;
+
+	ret = i40e_ethertype_filter_program(pf, &ethertype_flow->ethertype, true);
+	if (ret) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_HANDLE, flow,
+				"Failed to install ethertype filter");
+	}
+	return 0;
+}
+
+static int
+i40e_flow_ethertype_uninstall(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct i40e_ethertype_flow *ethertype_flow = (struct i40e_ethertype_flow *)flow;
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(flow->dev_data->dev_private);
+	int ret;
+
+	ret = i40e_ethertype_filter_program(pf, &ethertype_flow->ethertype, false);
+	if (ret) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_HANDLE, flow,
+				"Failed to delete ethertype filter");
+	}
+	return 0;
+}
+
+static int
+i40e_flow_ethertype_engine_init(const struct ci_flow_engine *engine __rte_unused,
+		struct rte_eth_dev_data *dev_data, void *priv)
+{
+	char ethertype_hash_name[RTE_HASH_NAMESIZE];
+	struct i40e_ethertype_priv *etype_priv = priv;
+	struct rte_hash_parameters params = {
+		.name = ethertype_hash_name,
+		.entries = I40E_MAX_ETHERTYPE_FILTER_NUM,
+		.key_len = sizeof(struct i40e_ethertype_key),
+		.hash_func = rte_hash_crc,
+		.hash_func_init_val = 0,
+		.socket_id = rte_socket_id(),
+	};
+
+	snprintf(ethertype_hash_name, RTE_HASH_NAMESIZE, "i40e_ethertype_hash_%s", dev_data->name);
+
+	etype_priv->hash_table = rte_hash_create(&params);
+	if (etype_priv->hash_table == NULL) {
+		PMD_INIT_LOG(ERR, "Failed to create ethertype hash table: %s",
+				rte_strerror(rte_errno));
+		return -rte_errno;
+	}
+
+	return 0;
+}
+
+static void
+i40e_flow_ethertype_engine_uninit(const struct ci_flow_engine *engine __rte_unused,
+		void *priv)
+{
+	struct i40e_ethertype_priv *etype_priv = priv;
+
+	rte_hash_free(etype_priv->hash_table);
+}
+
+static const struct ci_flow_engine_ops i40e_flow_engine_ethertype_ops = {
+	.engine_init = i40e_flow_ethertype_engine_init,
+	.engine_uninit = i40e_flow_ethertype_engine_uninit,
+	.ctx_init = i40e_flow_ethertype_ctx_init,
+	.ctx_to_flow = i40e_flow_ethertype_ctx_to_flow,
+	.flow_register = i40e_flow_ethertype_register,
+	.flow_unregister = i40e_flow_ethertype_unregister,
+	.flow_install = i40e_flow_ethertype_install,
+	.flow_uninstall = i40e_flow_ethertype_uninstall,
+};
+
+const struct ci_flow_engine i40e_flow_engine_ethertype = {
+	.name = "i40e_ethertype",
+	.ctx_size = sizeof(struct i40e_ethertype_ctx),
+	.flow_size = sizeof(struct i40e_ethertype_flow),
+	.priv_size = sizeof(struct i40e_ethertype_priv),
+	.ops = &i40e_flow_engine_ethertype_ops,
+	.graph = &i40e_ethertype_graph,
+};
diff --git a/drivers/net/intel/i40e/meson.build b/drivers/net/intel/i40e/meson.build
index 3229233f501..ddc97f9b3bb 100644
--- a/drivers/net/intel/i40e/meson.build
+++ b/drivers/net/intel/i40e/meson.build
@@ -33,6 +33,7 @@ sources += files(
         'i40e_pf.c',
         'i40e_fdir.c',
         'i40e_flow.c',
+        'i40e_flow_ethertype.c',
         'i40e_tm.c',
         'i40e_hash.c',
         'i40e_vf_representor.c',
-- 
2.52.0

