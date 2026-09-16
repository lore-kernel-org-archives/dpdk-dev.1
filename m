Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAD4C88E77
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 12:19:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DAF942EFE;
	Wed, 16 Sep 2026 14:18:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 7F6C842EF1
 for <dev@dpdk.org>; Wed, 16 Sep 2026 14:18:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789561124; x=1821097124;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Z0YhW3IKqOyAMHaeT1woXdxQpoODc0zHBUtDd36QjVI=;
 b=jYm1sgUq2iFa7485SH5s7Qqtq5P0BsC7bMGh/xBcP0Eygmfn6uD3Ky4h
 0OgxbCVjaO+EIQX8gyyNMNasTnl+3xFamAHlBzowYtkU/dIp8UpbWiQdP
 Jy5lDTBIs6BqdrxqnJcDnIUGG9J36+qhXBdYYm2rUioXmw/qOWOBgTj9I
 k2jULFqRbSiptT9jY6R98ceLaFxnV3Hazk5BQZIAalXH9dgSpvjaJ7GaZ
 2+EftvIlGFEfK99idGXKpbtrUqVohboYhNxOHBEZvq6lLHHqXTWiaAAgh
 8b60uM5VycbatMZqovTmO+k9K4tekmBpWB1GzmI8qPo2JGAfBIKTAEr7W w==;
X-CSE-ConnectionGUID: OPFVuQ+sTX2+IIQ7QlLAZw==
X-CSE-MsgGUID: AKDZX47/QsG/L5k8swdoBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112702949"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="112702949"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 05:18:43 -0700
X-CSE-ConnectionGUID: 9rXeV81JToS77zgu8CaY8g==
X-CSE-MsgGUID: Y1PgJ+h/QJqejtOiJAIAxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="272850252"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 16 Sep 2026 05:18:43 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 07/19] net/ixgbe: reimplement L2 tunnel parser
Date: Wed, 16 Sep 2026 13:18:13 +0100
Message-ID: <d900162f8a32939c4b8c2a3a178abfd35b0851dd.1789560945.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1789560943.git.anatoly.burakov@intel.com>
 <cover.1789560943.git.anatoly.burakov@intel.com>
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
flow parser for L2 tunnel.

There are two L2-tag-related features in the driver: the global per-port
one, and the one that can direct traffic to specific queues (the one the
engine targets). The former is left completely untouched, while the latter
one is migrated to use engine infrastructure and use internal tracking.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c     | 248 +---------------
 drivers/net/intel/ixgbe/ixgbe_ethdev.h     |  26 +-
 drivers/net/intel/ixgbe/ixgbe_flow.c       | 206 +------------
 drivers/net/intel/ixgbe/ixgbe_flow.h       |   1 +
 drivers/net/intel/ixgbe/ixgbe_flow_l2tun.c | 317 +++++++++++++++++++++
 drivers/net/intel/ixgbe/meson.build        |   1 +
 6 files changed, 326 insertions(+), 473 deletions(-)
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_l2tun.c

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 00ba6f32fa9..3923a00c284 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -149,7 +149,6 @@ static int eth_ixgbe_dev_uninit(struct rte_eth_dev *eth_dev);
 static int ixgbe_fdir_filter_init(struct rte_eth_dev *eth_dev);
 static int ixgbe_fdir_filter_uninit(struct rte_eth_dev *eth_dev);
 static int ixgbe_l2_tn_filter_init(struct rte_eth_dev *eth_dev);
-static int ixgbe_l2_tn_filter_uninit(struct rte_eth_dev *eth_dev);
 static int ixgbe_ntuple_filter_uninit(struct rte_eth_dev *eth_dev);
 static int ixgbe_dev_configure(struct rte_eth_dev *dev);
 static int ixgbe_dev_start(struct rte_eth_dev *dev);
@@ -1392,7 +1391,6 @@ eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 	return 0;
 
 err_flow_engine_conf_init:
-	ixgbe_l2_tn_filter_uninit(eth_dev);
 err_l2_tn_filter_init:
 	ixgbe_fdir_filter_uninit(eth_dev);
 err_fdir_filter_init:
@@ -1462,25 +1460,6 @@ static int ixgbe_fdir_filter_uninit(struct rte_eth_dev *eth_dev)
 	return 0;
 }
 
-static int ixgbe_l2_tn_filter_uninit(struct rte_eth_dev *eth_dev)
-{
-	struct ixgbe_l2_tn_info *l2_tn_info =
-		IXGBE_DEV_PRIVATE_TO_L2_TN_INFO(eth_dev->data->dev_private);
-	struct ixgbe_l2_tn_filter *l2_tn_filter;
-
-	rte_free(l2_tn_info->hash_map);
-	rte_hash_free(l2_tn_info->hash_handle);
-
-	while ((l2_tn_filter = TAILQ_FIRST(&l2_tn_info->l2_tn_list))) {
-		TAILQ_REMOVE(&l2_tn_info->l2_tn_list,
-			     l2_tn_filter,
-			     entries);
-		rte_free(l2_tn_filter);
-	}
-
-	return 0;
-}
-
 static int ixgbe_fdir_filter_init(struct rte_eth_dev *eth_dev)
 {
 	struct ixgbe_hw_fdir_info *fdir_info =
@@ -1526,34 +1505,7 @@ static int ixgbe_l2_tn_filter_init(struct rte_eth_dev *eth_dev)
 {
 	struct ixgbe_l2_tn_info *l2_tn_info =
 		IXGBE_DEV_PRIVATE_TO_L2_TN_INFO(eth_dev->data->dev_private);
-	char l2_tn_hash_name[RTE_HASH_NAMESIZE];
-	struct rte_hash_parameters l2_tn_hash_params = {
-		.name = l2_tn_hash_name,
-		.entries = IXGBE_MAX_L2_TN_FILTER_NUM,
-		.key_len = sizeof(struct ixgbe_l2_tn_key),
-		.hash_func = rte_hash_crc,
-		.hash_func_init_val = 0,
-		.socket_id = rte_socket_id(),
-	};
 
-	TAILQ_INIT(&l2_tn_info->l2_tn_list);
-	snprintf(l2_tn_hash_name, RTE_HASH_NAMESIZE,
-		 "l2_tn_%s", eth_dev->device->name);
-	l2_tn_info->hash_handle = rte_hash_create(&l2_tn_hash_params);
-	if (!l2_tn_info->hash_handle) {
-		PMD_INIT_LOG(ERR, "Failed to create L2 TN hash table!");
-		return -EINVAL;
-	}
-	l2_tn_info->hash_map = rte_zmalloc("ixgbe",
-				   sizeof(struct ixgbe_l2_tn_filter *) *
-				   IXGBE_MAX_L2_TN_FILTER_NUM,
-				   0);
-	if (!l2_tn_info->hash_map) {
-		PMD_INIT_LOG(ERR,
-			"Failed to allocate memory for L2 TN hash map!");
-		rte_hash_free(l2_tn_info->hash_handle);
-		return -ENOMEM;
-	}
 	l2_tn_info->e_tag_en = FALSE;
 	l2_tn_info->e_tag_fwd_en = FALSE;
 	l2_tn_info->e_tag_ether_type = RTE_ETHER_TYPE_ETAG;
@@ -3197,9 +3149,6 @@ ixgbe_dev_close(struct rte_eth_dev *dev)
 	/* remove all the fdir filters & hash */
 	ixgbe_fdir_filter_uninit(dev);
 
-	/* remove all the L2 tunnel filters & hash */
-	ixgbe_l2_tn_filter_uninit(dev);
-
 	/* Remove all ntuple filters of the device */
 	ixgbe_ntuple_filter_uninit(dev);
 
@@ -7745,7 +7694,7 @@ ixgbe_e_tag_enable(struct ixgbe_hw *hw)
 	return 0;
 }
 
-static int
+int
 ixgbe_e_tag_filter_del(struct ixgbe_adapter *adapter,
 		       struct ixgbe_l2_tunnel_conf *l2_tunnel)
 {
@@ -7782,7 +7731,7 @@ ixgbe_e_tag_filter_del(struct ixgbe_adapter *adapter,
 	return ret;
 }
 
-static int
+int
 ixgbe_e_tag_filter_add(struct ixgbe_adapter *adapter,
 		       struct ixgbe_l2_tunnel_conf *l2_tunnel)
 {
@@ -7824,154 +7773,6 @@ ixgbe_e_tag_filter_add(struct ixgbe_adapter *adapter,
 	return -EINVAL;
 }
 
-static inline struct ixgbe_l2_tn_filter *
-ixgbe_l2_tn_filter_lookup(struct ixgbe_l2_tn_info *l2_tn_info,
-			  struct ixgbe_l2_tn_key *key)
-{
-	int ret;
-
-	ret = rte_hash_lookup(l2_tn_info->hash_handle, (const void *)key);
-	if (ret < 0)
-		return NULL;
-
-	return l2_tn_info->hash_map[ret];
-}
-
-static inline int
-ixgbe_insert_l2_tn_filter(struct ixgbe_l2_tn_info *l2_tn_info,
-			  struct ixgbe_l2_tn_filter *l2_tn_filter)
-{
-	int ret;
-
-	ret = rte_hash_add_key(l2_tn_info->hash_handle,
-			       &l2_tn_filter->key);
-
-	if (ret < 0) {
-		PMD_DRV_LOG(ERR,
-			    "Failed to insert L2 tunnel filter"
-			    " to hash table %d!",
-			    ret);
-		return ret;
-	}
-
-	l2_tn_info->hash_map[ret] = l2_tn_filter;
-
-	TAILQ_INSERT_TAIL(&l2_tn_info->l2_tn_list, l2_tn_filter, entries);
-
-	return 0;
-}
-
-static inline int
-ixgbe_remove_l2_tn_filter(struct ixgbe_l2_tn_info *l2_tn_info,
-			  struct ixgbe_l2_tn_key *key)
-{
-	int ret;
-	struct ixgbe_l2_tn_filter *l2_tn_filter;
-
-	ret = rte_hash_del_key(l2_tn_info->hash_handle, key);
-
-	if (ret < 0) {
-		PMD_DRV_LOG(ERR,
-			    "No such L2 tunnel filter to delete %d!",
-			    ret);
-		return ret;
-	}
-
-	l2_tn_filter = l2_tn_info->hash_map[ret];
-	l2_tn_info->hash_map[ret] = NULL;
-
-	TAILQ_REMOVE(&l2_tn_info->l2_tn_list, l2_tn_filter, entries);
-	rte_free(l2_tn_filter);
-
-	return 0;
-}
-
-/* Add l2 tunnel filter */
-int
-ixgbe_dev_l2_tunnel_filter_add(struct ixgbe_adapter *adapter,
-			       struct ixgbe_l2_tunnel_conf *l2_tunnel,
-			       bool restore)
-{
-	int ret;
-	struct ixgbe_l2_tn_info *l2_tn_info =
-		IXGBE_DEV_PRIVATE_TO_L2_TN_INFO(adapter);
-	struct ixgbe_l2_tn_key key;
-	struct ixgbe_l2_tn_filter *node;
-
-	if (!restore) {
-		key.l2_tn_type = l2_tunnel->l2_tunnel_type;
-		key.tn_id = l2_tunnel->tunnel_id;
-
-		node = ixgbe_l2_tn_filter_lookup(l2_tn_info, &key);
-
-		if (node) {
-			PMD_DRV_LOG(ERR,
-				    "The L2 tunnel filter already exists!");
-			return -EINVAL;
-		}
-
-		node = rte_zmalloc("ixgbe_l2_tn",
-				   sizeof(struct ixgbe_l2_tn_filter),
-				   0);
-		if (!node)
-			return -ENOMEM;
-
-		memcpy(&node->key,
-				 &key,
-				 sizeof(struct ixgbe_l2_tn_key));
-		node->pool = l2_tunnel->pool;
-		ret = ixgbe_insert_l2_tn_filter(l2_tn_info, node);
-		if (ret < 0) {
-			rte_free(node);
-			return ret;
-		}
-	}
-
-	switch (l2_tunnel->l2_tunnel_type) {
-	case RTE_ETH_L2_TUNNEL_TYPE_E_TAG:
-		ret = ixgbe_e_tag_filter_add(adapter, l2_tunnel);
-		break;
-	default:
-		PMD_DRV_LOG(ERR, "Invalid tunnel type");
-		ret = -EINVAL;
-		break;
-	}
-
-	if ((!restore) && (ret < 0))
-		(void)ixgbe_remove_l2_tn_filter(l2_tn_info, &key);
-
-	return ret;
-}
-
-/* Delete l2 tunnel filter */
-int
-ixgbe_dev_l2_tunnel_filter_del(struct ixgbe_adapter *adapter,
-			       struct ixgbe_l2_tunnel_conf *l2_tunnel)
-{
-	int ret;
-	struct ixgbe_l2_tn_info *l2_tn_info =
-		IXGBE_DEV_PRIVATE_TO_L2_TN_INFO(adapter);
-	struct ixgbe_l2_tn_key key;
-
-	key.l2_tn_type = l2_tunnel->l2_tunnel_type;
-	key.tn_id = l2_tunnel->tunnel_id;
-	ret = ixgbe_remove_l2_tn_filter(l2_tn_info, &key);
-	if (ret < 0)
-		return ret;
-
-	switch (l2_tunnel->l2_tunnel_type) {
-	case RTE_ETH_L2_TUNNEL_TYPE_E_TAG:
-		ret = ixgbe_e_tag_filter_del(adapter, l2_tunnel);
-		break;
-	default:
-		PMD_DRV_LOG(ERR, "Invalid tunnel type");
-		ret = -EINVAL;
-		break;
-	}
-
-	return ret;
-}
-
 static int
 ixgbe_e_tag_forwarding_en_dis(struct rte_eth_dev *dev, bool en)
 {
@@ -8369,26 +8170,6 @@ ixgbe_ntuple_filter_restore(struct rte_eth_dev *dev)
 	}
 }
 
-/* restore L2 tunnel filter */
-static inline void
-ixgbe_l2_tn_filter_restore(struct rte_eth_dev *dev)
-{
-	struct ixgbe_adapter *adapter =
-		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct ixgbe_l2_tn_info *l2_tn_info =
-		IXGBE_DEV_PRIVATE_TO_L2_TN_INFO(adapter);
-	struct ixgbe_l2_tn_filter *node;
-	struct ixgbe_l2_tunnel_conf l2_tn_conf;
-
-	TAILQ_FOREACH(node, &l2_tn_info->l2_tn_list, entries) {
-		l2_tn_conf.l2_tunnel_type = node->key.l2_tn_type;
-		l2_tn_conf.tunnel_id      = node->key.tn_id;
-		l2_tn_conf.pool           = node->pool;
-		(void)ixgbe_dev_l2_tunnel_filter_add(adapter,
-						     &l2_tn_conf, TRUE);
-	}
-}
-
 /* restore rss filter */
 static inline void
 ixgbe_rss_filter_restore(struct rte_eth_dev *dev)
@@ -8408,7 +8189,6 @@ ixgbe_filter_restore(struct rte_eth_dev *dev)
 {
 	ixgbe_ntuple_filter_restore(dev);
 	ixgbe_fdir_filter_restore(dev);
-	ixgbe_l2_tn_filter_restore(dev);
 	ixgbe_rss_filter_restore(dev);
 
 	return 0;
@@ -8444,30 +8224,6 @@ ixgbe_clear_all_ntuple_filter(struct rte_eth_dev *dev)
 		ixgbe_remove_5tuple_filter(adapter, p_5tuple);
 }
 
-/* remove all the L2 tunnel filters */
-int
-ixgbe_clear_all_l2_tn_filter(struct rte_eth_dev *dev)
-{
-	struct ixgbe_adapter *adapter =
-			IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct ixgbe_l2_tn_info *l2_tn_info =
-		IXGBE_DEV_PRIVATE_TO_L2_TN_INFO(dev->data->dev_private);
-	struct ixgbe_l2_tn_filter *l2_tn_filter;
-	struct ixgbe_l2_tunnel_conf l2_tn_conf;
-	int ret = 0;
-
-	while ((l2_tn_filter = TAILQ_FIRST(&l2_tn_info->l2_tn_list))) {
-		l2_tn_conf.l2_tunnel_type = l2_tn_filter->key.l2_tn_type;
-		l2_tn_conf.tunnel_id      = l2_tn_filter->key.tn_id;
-		l2_tn_conf.pool           = l2_tn_filter->pool;
-		ret = ixgbe_dev_l2_tunnel_filter_del(adapter, &l2_tn_conf);
-		if (ret < 0)
-			return ret;
-	}
-
-	return 0;
-}
-
 void
 ixgbe_dev_macsec_setting_save(struct rte_eth_dev *dev,
 				struct ixgbe_macsec_setting *macsec_setting)
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index ec216ec8c1f..b252fd39731 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -327,23 +327,7 @@ struct ixgbe_filter_info {
 	uint8_t antispoof_idx;
 };
 
-struct ixgbe_l2_tn_key {
-	enum rte_eth_tunnel_type          l2_tn_type;
-	uint32_t                          tn_id;
-};
-
-struct ixgbe_l2_tn_filter {
-	TAILQ_ENTRY(ixgbe_l2_tn_filter)    entries;
-	struct ixgbe_l2_tn_key             key;
-	uint32_t                           pool;
-};
-
-TAILQ_HEAD(ixgbe_l2_tn_filter_list, ixgbe_l2_tn_filter);
-
 struct ixgbe_l2_tn_info {
-	struct ixgbe_l2_tn_filter_list      l2_tn_list;
-	struct ixgbe_l2_tn_filter         **hash_map;
-	struct rte_hash                    *hash_handle;
 	bool e_tag_en; /* e-tag enabled */
 	bool e_tag_fwd_en; /* e-tag based forwarding enabled */
 	uint16_t e_tag_ether_type; /* ether type for e-tag */
@@ -702,12 +686,11 @@ struct ixgbe_l2_tunnel_conf {
 };
 
 int
-ixgbe_dev_l2_tunnel_filter_add(struct ixgbe_adapter *adapter,
-			       struct ixgbe_l2_tunnel_conf *l2_tunnel,
-			       bool restore);
+ixgbe_e_tag_filter_add(struct ixgbe_adapter *adapter,
+		       struct ixgbe_l2_tunnel_conf *l2_tunnel);
 int
-ixgbe_dev_l2_tunnel_filter_del(struct ixgbe_adapter *adapter,
-			       struct ixgbe_l2_tunnel_conf *l2_tunnel);
+ixgbe_e_tag_filter_del(struct ixgbe_adapter *adapter,
+		       struct ixgbe_l2_tunnel_conf *l2_tunnel);
 void ixgbe_filterlist_init(struct rte_eth_dev *dev);
 void ixgbe_filterlist_flush(struct rte_eth_dev *dev);
 /*
@@ -761,7 +744,6 @@ int ixgbe_clear_all_fdir_filter(struct rte_eth_dev *dev);
 extern const struct rte_flow_ops ixgbe_flow_ops;
 
 void ixgbe_clear_all_ntuple_filter(struct rte_eth_dev *dev);
-int ixgbe_clear_all_l2_tn_filter(struct rte_eth_dev *dev);
 
 int ixgbe_disable_sec_tx_path_generic(struct ixgbe_hw *hw);
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index dc55fbd724e..7b7dd404aa8 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -68,11 +68,6 @@ struct ixgbe_fdir_rule_ele {
 	struct ixgbe_filter_ele_base base;
 	struct ixgbe_fdir_rule filter_info;
 };
-/* l2_tunnel filter list structure */
-struct ixgbe_eth_l2_tunnel_conf_ele {
-	struct ixgbe_filter_ele_base base;
-	struct ixgbe_l2_tunnel_conf filter_info;
-};
 /* rss filter list structure */
 struct ixgbe_rss_conf_ele {
 	struct ixgbe_filter_ele_base base;
@@ -88,6 +83,7 @@ const struct ci_flow_engine_list ixgbe_flow_engine_list = {
 	{
 		&ixgbe_ethertype_flow_engine,
 		&ixgbe_syn_flow_engine,
+		&ixgbe_l2_tunnel_flow_engine,
 	},
 };
 
@@ -662,161 +658,6 @@ ixgbe_parse_ntuple_filter(struct rte_eth_dev *dev,
 	return 0;
 }
 
-/**
- * Parse the rule to see if it is a L2 tunnel rule.
- * And get the L2 tunnel filter info BTW.
- * Only support E-tag now.
- * pattern:
- * The first not void item can be E_TAG.
- * The next not void item must be END.
- * action:
- * The first not void action should be VF or PF.
- * The next not void action should be END.
- * pattern example:
- * ITEM		Spec			Mask
- * E_TAG	grp		0x1	0x3
-		e_cid_base	0x309	0xFFF
- * END
- * other members in mask and spec should set to 0x00.
- * item->last should be NULL.
- */
-static int
-cons_parse_l2_tn_filter(struct rte_eth_dev *dev,
-			const struct rte_flow_item pattern[],
-			const struct rte_flow_action *action,
-			struct ixgbe_l2_tunnel_conf *filter,
-			struct rte_flow_error *error)
-{
-	const struct rte_flow_item *item;
-	const struct rte_flow_item_e_tag *e_tag_spec;
-	const struct rte_flow_item_e_tag *e_tag_mask;
-	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-
-	/* The first not void item should be e-tag. */
-	item = next_no_void_pattern(pattern, NULL);
-	if (item->type != RTE_FLOW_ITEM_TYPE_E_TAG) {
-		memset(filter, 0, sizeof(struct ixgbe_l2_tunnel_conf));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by L2 tunnel filter");
-		return -rte_errno;
-	}
-
-	if (!item->spec || !item->mask) {
-		memset(filter, 0, sizeof(struct ixgbe_l2_tunnel_conf));
-		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by L2 tunnel filter");
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
-	e_tag_spec = item->spec;
-	e_tag_mask = item->mask;
-
-	/* Only care about GRP and E cid base. */
-	if (e_tag_mask->epcp_edei_in_ecid_b ||
-	    e_tag_mask->in_ecid_e ||
-	    e_tag_mask->ecid_e ||
-	    e_tag_mask->rsvd_grp_ecid_b != rte_cpu_to_be_16(0x3FFF)) {
-		memset(filter, 0, sizeof(struct ixgbe_l2_tunnel_conf));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by L2 tunnel filter");
-		return -rte_errno;
-	}
-
-	filter->l2_tunnel_type = RTE_ETH_L2_TUNNEL_TYPE_E_TAG;
-	/**
-	 * grp and e_cid_base are bit fields and only use 14 bits.
-	 * e-tag id is taken as little endian by HW.
-	 */
-	filter->tunnel_id = rte_be_to_cpu_16(e_tag_spec->rsvd_grp_ecid_b);
-
-	/* check if the next not void item is END */
-	item = next_no_void_pattern(pattern, item);
-	if (item->type != RTE_FLOW_ITEM_TYPE_END) {
-		memset(filter, 0, sizeof(struct ixgbe_l2_tunnel_conf));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by L2 tunnel filter");
-		return -rte_errno;
-	}
-
-	if (action->type == RTE_FLOW_ACTION_TYPE_VF) {
-		const struct rte_flow_action_vf *act_vf = action->conf;
-		filter->pool = act_vf->id;
-	} else {
-		filter->pool = ad->max_vfs;
-	}
-
-	return 0;
-}
-
-static int
-ixgbe_parse_l2_tn_filter(struct rte_eth_dev *dev,
-			const struct rte_flow_attr *attr,
-			const struct rte_flow_item pattern[],
-			const struct rte_flow_action actions[],
-			struct ixgbe_l2_tunnel_conf *l2_tn_filter,
-			struct rte_flow_error *error)
-{
-	struct rte_eth_dev_data *dev_data = dev->data;
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev_data->dev_private);
-	struct ci_flow_actions parsed_actions;
-	struct ci_flow_actions_check_param ap_param = {
-		.allowed_types = (const enum rte_flow_action_type[]){
-			/* only vf/pf is allowed here */
-			RTE_FLOW_ACTION_TYPE_VF,
-			RTE_FLOW_ACTION_TYPE_PF,
-			RTE_FLOW_ACTION_TYPE_END
-		},
-		.driver_ctx = dev_data,
-		.check = ixgbe_flow_actions_check,
-		.max_actions = 1,
-	};
-	int ret = 0;
-	const struct rte_flow_action *action;
-
-	if (hw->mac.type != ixgbe_mac_X550 &&
-		hw->mac.type != ixgbe_mac_X550EM_x &&
-		hw->mac.type != ixgbe_mac_X550EM_a &&
-		hw->mac.type != ixgbe_mac_E610) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			NULL, "Not supported by L2 tunnel filter");
-		return -rte_errno;
-	}
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
-	/* only one action is supported */
-	if (parsed_actions.count > 1) {
-		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
-					  parsed_actions.actions[1],
-					  "Only one action can be specified at a time");
-	}
-	action = parsed_actions.actions[0];
-
-	ret = cons_parse_l2_tn_filter(dev, pattern, action, l2_tn_filter, error);
-
-	return ret;
-}
-
 /* search next no void pattern and skip fuzzy */
 static inline
 const struct rte_flow_item *next_no_fuzzy_pattern(
@@ -2453,13 +2294,11 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct rte_eth_ntuple_filter ntuple_filter;
 	struct ixgbe_fdir_rule fdir_rule;
-	struct ixgbe_l2_tunnel_conf l2_tn_filter;
 	struct ixgbe_hw_fdir_info *fdir_info =
 		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
 	struct ixgbe_rte_flow_rss_conf rss_conf;
 	struct rte_flow *flow = NULL;
 	struct ixgbe_ntuple_filter_ele *ntuple_filter_ptr;
-	struct ixgbe_eth_l2_tunnel_conf_ele *l2_tn_filter_ptr;
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
 	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
@@ -2550,25 +2389,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 		return flow;
 	}
 
-	memset(&l2_tn_filter, 0, sizeof(struct ixgbe_l2_tunnel_conf));
-	ret = ixgbe_parse_l2_tn_filter(dev, attr, pattern,
-					actions, &l2_tn_filter, error);
-	if (!ret) {
-		ret = ixgbe_dev_l2_tunnel_filter_add(adapter, &l2_tn_filter, FALSE);
-		if (!ret) {
-			l2_tn_filter_ptr = rte_zmalloc("ixgbe_l2_tn_filter",
-				sizeof(struct ixgbe_eth_l2_tunnel_conf_ele), 0);
-			if (!l2_tn_filter_ptr) {
-				PMD_DRV_LOG(ERR, "failed to allocate memory");
-				goto out;
-			}
-			l2_tn_filter_ptr->filter_info = l2_tn_filter;
-			flow->rule = l2_tn_filter_ptr;
-			flow->filter_type = RTE_ETH_FILTER_L2_TUNNEL;
-			return flow;
-		}
-	}
-
 	memset(&rss_conf, 0, sizeof(struct ixgbe_rte_flow_rss_conf));
 	ret = ixgbe_parse_rss_filter(dev, attr,
 					actions, &rss_conf, error);
@@ -2614,7 +2434,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 {
 	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct rte_eth_ntuple_filter ntuple_filter;
-	struct ixgbe_l2_tunnel_conf l2_tn_filter;
 	struct ixgbe_fdir_rule fdir_rule;
 	struct ixgbe_rte_flow_rss_conf rss_conf;
 	int ret;
@@ -2645,12 +2464,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 	if (!ret)
 		return 0;
 
-	memset(&l2_tn_filter, 0, sizeof(struct ixgbe_l2_tunnel_conf));
-	ret = ixgbe_parse_l2_tn_filter(dev, attr, pattern,
-				actions, &l2_tn_filter, error);
-	if (!ret)
-		return 0;
-
 	memset(&rss_conf, 0, sizeof(struct ixgbe_rte_flow_rss_conf));
 	ret = ixgbe_parse_rss_filter(dev, attr,
 					actions, &rss_conf, error);
@@ -2671,9 +2484,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	enum rte_filter_type filter_type = pmd_flow->filter_type;
 	struct rte_eth_ntuple_filter ntuple_filter;
 	struct ixgbe_fdir_rule fdir_rule;
-	struct ixgbe_l2_tunnel_conf l2_tn_filter;
 	struct ixgbe_ntuple_filter_ele *ntuple_filter_ptr;
-	struct ixgbe_eth_l2_tunnel_conf_ele *l2_tn_filter_ptr;
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_filter_ele_base *flow_mem_base;
 	struct ixgbe_hw_fdir_info *fdir_info =
@@ -2731,14 +2542,6 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 			}
 		}
 		break;
-	case RTE_ETH_FILTER_L2_TUNNEL:
-		l2_tn_filter_ptr = (struct ixgbe_eth_l2_tunnel_conf_ele *)
-				pmd_flow->rule;
-		l2_tn_filter = l2_tn_filter_ptr->filter_info;
-		ret = ixgbe_dev_l2_tunnel_filter_del(adapter, &l2_tn_filter);
-		if (!ret)
-			rte_free(l2_tn_filter_ptr);
-		break;
 	case RTE_ETH_FILTER_HASH:
 		rss_filter_ptr = (struct ixgbe_rss_conf_ele *)
 				pmd_flow->rule;
@@ -2793,13 +2596,6 @@ ixgbe_flow_flush(struct rte_eth_dev *dev,
 		return ret;
 	}
 
-	ret = ixgbe_clear_all_l2_tn_filter(dev);
-	if (ret < 0) {
-		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_HANDLE,
-					NULL, "Failed to flush rule");
-		return ret;
-	}
-
 	ixgbe_clear_rss_filter(dev);
 
 	ixgbe_filterlist_flush(dev);
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.h b/drivers/net/intel/ixgbe/ixgbe_flow.h
index 453a23d3b63..ba0486b2c0e 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.h
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.h
@@ -17,5 +17,6 @@ extern const struct ci_flow_engine_list ixgbe_flow_engine_list;
 
 extern const struct ci_flow_engine ixgbe_ethertype_flow_engine;
 extern const struct ci_flow_engine ixgbe_syn_flow_engine;
+extern const struct ci_flow_engine ixgbe_l2_tunnel_flow_engine;
 
 #endif /*  _IXGBE_FLOW_H_ */
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow_l2tun.c b/drivers/net/intel/ixgbe/ixgbe_flow_l2tun.c
new file mode 100644
index 00000000000..b9c4326487b
--- /dev/null
+++ b/drivers/net/intel/ixgbe/ixgbe_flow_l2tun.c
@@ -0,0 +1,317 @@
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
+struct ixgbe_l2_tunnel_flow {
+	struct rte_flow flow;
+	struct ixgbe_l2_tunnel_conf l2_tunnel;
+};
+
+struct ixgbe_l2_tunnel_ctx {
+	struct ci_flow_engine_ctx base;
+	struct ixgbe_l2_tunnel_conf l2_tunnel;
+};
+
+/* per-device dedup set of installed tunnel ids (hardware matches by id) */
+struct ixgbe_l2_tunnel_priv {
+	uint32_t count;
+	uint32_t tunnel_id[IXGBE_MAX_L2_TN_FILTER_NUM];
+};
+
+/**
+ * L2 tunnel filter graph implementation (E-TAG)
+ * Pattern: START -> E_TAG -> END
+ */
+
+enum ixgbe_l2_tunnel_node_id {
+	IXGBE_L2_TUNNEL_NODE_START = FLOW_GRAPH_NODE_FIRST,
+	IXGBE_L2_TUNNEL_NODE_E_TAG,
+	IXGBE_L2_TUNNEL_NODE_END,
+	IXGBE_L2_TUNNEL_NODE_MAX,
+};
+
+static int
+ixgbe_validate_l2_tunnel_e_tag(const void *ctx __rte_unused,
+				const struct rte_flow_item *item,
+				struct rte_flow_error *error)
+{
+	const struct rte_flow_item_e_tag *e_tag_mask;
+
+	e_tag_mask = item->mask;
+
+	/* Only GRP and E-CID base supported (rsvd_grp_ecid_b field) */
+	if (e_tag_mask->epcp_edei_in_ecid_b ||
+	    e_tag_mask->in_ecid_e ||
+	    e_tag_mask->ecid_e ||
+	    rte_be_to_cpu_16(e_tag_mask->rsvd_grp_ecid_b) != 0x3FFF) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Only GRP and E-CID base (14 bits) supported");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_l2_tunnel_e_tag(void *ctx,
+			       const struct rte_flow_item *item,
+			       struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_l2_tunnel_ctx *l2tun_ctx = ctx;
+	const struct rte_flow_item_e_tag *e_tag_spec = item->spec;
+
+	l2tun_ctx->l2_tunnel.l2_tunnel_type = RTE_ETH_L2_TUNNEL_TYPE_E_TAG;
+	l2tun_ctx->l2_tunnel.tunnel_id = rte_be_to_cpu_16(e_tag_spec->rsvd_grp_ecid_b);
+
+	return 0;
+}
+
+static const struct flow_graph ixgbe_l2_tunnel_graph = {
+	.nodes = (struct flow_graph_node[]) {
+		[IXGBE_L2_TUNNEL_NODE_START] = {
+			.name = "START",
+		},
+		[IXGBE_L2_TUNNEL_NODE_E_TAG] = {
+			.name = "E_TAG",
+			.type = RTE_FLOW_ITEM_TYPE_E_TAG,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = ixgbe_validate_l2_tunnel_e_tag,
+			.process = ixgbe_process_l2_tunnel_e_tag,
+		},
+		[IXGBE_L2_TUNNEL_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	},
+	.edges = (struct flow_graph_edge[]) {
+		[IXGBE_L2_TUNNEL_NODE_START] = {
+			.next = (size_t[]) {
+				IXGBE_L2_TUNNEL_NODE_E_TAG,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_L2_TUNNEL_NODE_E_TAG] = {
+			.next = (size_t[]) {
+				IXGBE_L2_TUNNEL_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+static int
+ixgbe_flow_l2_tunnel_ctx_init(const struct rte_flow_action *actions,
+		const struct rte_flow_attr *attr,
+		struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_l2_tunnel_ctx *l2tun_ctx = (struct ixgbe_l2_tunnel_ctx *)ctx;
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(ctx->dev_data->dev_private);
+	struct ci_flow_actions parsed_actions;
+	struct ci_flow_actions_check_param ap_param = {
+		.allowed_types = (const enum rte_flow_action_type[]){
+			/* only vf/pf is allowed here */
+			RTE_FLOW_ACTION_TYPE_VF,
+			RTE_FLOW_ACTION_TYPE_PF,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.driver_ctx = ctx->dev_data,
+		.check = ixgbe_flow_actions_check,
+		.max_actions = 1,
+	};
+	const struct rte_flow_action *action;
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
+	action = parsed_actions.actions[0];
+
+	if (action->type == RTE_FLOW_ACTION_TYPE_VF) {
+		const struct rte_flow_action_vf *vf = action->conf;
+		l2tun_ctx->l2_tunnel.pool = vf->id;
+	} else {
+		l2tun_ctx->l2_tunnel.pool = adapter->max_vfs;
+	}
+
+	return ret;
+}
+
+static int
+ixgbe_flow_l2_tunnel_ctx_to_flow(const struct ci_flow_engine_ctx *ctx,
+		struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct ixgbe_l2_tunnel_ctx *l2tun_ctx = (const struct ixgbe_l2_tunnel_ctx *)ctx;
+	struct ixgbe_l2_tunnel_flow *l2tun_flow = (struct ixgbe_l2_tunnel_flow *)flow;
+
+	l2tun_flow->l2_tunnel = l2tun_ctx->l2_tunnel;
+
+	return 0;
+}
+
+static int
+ixgbe_l2_tunnel_id_find(const struct ixgbe_l2_tunnel_priv *priv, uint32_t tunnel_id)
+{
+	uint32_t i;
+
+	for (i = 0; i < priv->count; i++) {
+		if (priv->tunnel_id[i] == tunnel_id)
+			return (int)i;
+	}
+
+	return -ENOENT;
+}
+
+static int
+ixgbe_l2_tunnel_id_add(struct ixgbe_l2_tunnel_priv *priv, uint32_t tunnel_id)
+{
+	if (priv->count >= IXGBE_MAX_L2_TN_FILTER_NUM)
+		return -ENOSPC;
+	if (ixgbe_l2_tunnel_id_find(priv, tunnel_id) >= 0)
+		return -EEXIST;
+
+	priv->tunnel_id[priv->count++] = tunnel_id;
+
+	return 0;
+}
+
+static int
+ixgbe_l2_tunnel_id_del(struct ixgbe_l2_tunnel_priv *priv, uint32_t tunnel_id)
+{
+	int idx = ixgbe_l2_tunnel_id_find(priv, tunnel_id);
+
+	if (idx < 0)
+		return -ENOENT;
+
+	/* keep a dense set, order doesn't matter */
+	priv->tunnel_id[idx] = priv->tunnel_id[--priv->count];
+
+	return 0;
+}
+
+static int
+ixgbe_flow_l2_tunnel_flow_register(struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_l2_tunnel_flow *l2tun_flow = (struct ixgbe_l2_tunnel_flow *)flow;
+	struct ixgbe_l2_tunnel_priv *priv = flow->engine_priv;
+	int ret;
+
+	ret = ixgbe_l2_tunnel_id_add(priv, l2tun_flow->l2_tunnel.tunnel_id);
+	if (ret == -ENOSPC) {
+		return rte_flow_error_set(error, ENOSPC,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"L2 tunnel filter table is full");
+	}
+	if (ret == -EEXIST) {
+		return rte_flow_error_set(error, EEXIST,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"L2 tunnel filter already exists");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_flow_l2_tunnel_flow_unregister(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct ixgbe_l2_tunnel_flow *l2tun_flow = (struct ixgbe_l2_tunnel_flow *)flow;
+	struct ixgbe_l2_tunnel_priv *priv = flow->engine_priv;
+
+	if (ixgbe_l2_tunnel_id_del(priv, l2tun_flow->l2_tunnel.tunnel_id) != 0) {
+		return rte_flow_error_set(error, ENOENT,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"L2 tunnel filter not found on unregister");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_flow_l2_tunnel_flow_install(struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_l2_tunnel_flow *l2tun_flow = (struct ixgbe_l2_tunnel_flow *)flow;
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(flow->dev_data->dev_private);
+	int ret;
+
+	ret = ixgbe_e_tag_filter_add(adapter, &l2tun_flow->l2_tunnel);
+	if (ret) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Failed to add L2 tunnel filter");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_flow_l2_tunnel_flow_uninstall(struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_l2_tunnel_flow *l2tun_flow = (struct ixgbe_l2_tunnel_flow *)flow;
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(flow->dev_data->dev_private);
+	int ret;
+
+	ret = ixgbe_e_tag_filter_del(adapter, &l2tun_flow->l2_tunnel);
+	if (ret) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_HANDLE, flow,
+				"Failed to remove L2 tunnel filter");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_flow_l2_tunnel_engine_init(const struct ci_flow_engine *engine __rte_unused,
+		struct rte_eth_dev_data *dev_data,
+		void *priv __rte_unused)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev_data->dev_private);
+
+	if (hw->mac.type == ixgbe_mac_X550 ||
+			hw->mac.type == ixgbe_mac_X550EM_x ||
+			hw->mac.type == ixgbe_mac_X550EM_a ||
+			hw->mac.type == ixgbe_mac_E610)
+		return 0;
+
+	return -ENOTSUP;
+}
+
+static const struct ci_flow_engine_ops ixgbe_l2_tunnel_ops = {
+	.engine_init = ixgbe_flow_l2_tunnel_engine_init,
+	.ctx_init = ixgbe_flow_l2_tunnel_ctx_init,
+	.ctx_to_flow = ixgbe_flow_l2_tunnel_ctx_to_flow,
+	.flow_register = ixgbe_flow_l2_tunnel_flow_register,
+	.flow_unregister = ixgbe_flow_l2_tunnel_flow_unregister,
+	.flow_install = ixgbe_flow_l2_tunnel_flow_install,
+	.flow_uninstall = ixgbe_flow_l2_tunnel_flow_uninstall,
+};
+
+const struct ci_flow_engine ixgbe_l2_tunnel_flow_engine = {
+	.name = "ixgbe_l2_tunnel",
+	.ctx_size = sizeof(struct ixgbe_l2_tunnel_ctx),
+	.flow_size = sizeof(struct ixgbe_l2_tunnel_flow),
+	.priv_size = sizeof(struct ixgbe_l2_tunnel_priv),
+	.ops = &ixgbe_l2_tunnel_ops,
+	.graph = &ixgbe_l2_tunnel_graph,
+};
diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
index 1ef818fa67a..91ec2611543 100644
--- a/drivers/net/intel/ixgbe/meson.build
+++ b/drivers/net/intel/ixgbe/meson.build
@@ -28,6 +28,7 @@ sources += files(
         'ixgbe_flow.c',
         'ixgbe_flow_ethertype.c',
         'ixgbe_flow_syn.c',
+        'ixgbe_flow_l2tun.c',
         'ixgbe_ipsec.c',
         'ixgbe_pf.c',
         'ixgbe_rxtx.c',
-- 
2.52.0

