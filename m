Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15395C79F9E
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 15:23:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6296142686;
	Tue,  8 Sep 2026 17:22:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id D59FC4028D
 for <dev@dpdk.org>; Tue,  8 Sep 2026 17:22:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788880932; x=1820416932;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=WW6bgj9zcJiPeZ0LVhcZtUXDMY+b8Ga9MaTZFdGSA3g=;
 b=Wy3yoKGUO0Agj3M96auajkzPe2JbIBNozSvWBtTDv1DuzirCluIBC5lc
 +4tt9X4P+exGrrPpVOIrAhCpcdCoaZKkS8XRCjgOdG8S51meaxT5JJcg2
 CRRAtlfk+RukOCoqrPTi+Bn+Vga+nSfalZ84M8laKrgF7n/3TaZKAuJmG
 oWBUK2rX+qZKQNOYJb3KpzIP0FYm2wF0T0ZHkHYPn3lt/DBiMJB99vihs
 u9Sug44jkLrm5UuJKqaFUgQJoRfN8ZvAITVdUF1GxSQeGsx6egJi8oaGZ
 NpLN3iQvMIN0i3jurq0+AFgnnpnudd8hBzvtsW4FKr3GAKpFhwL1ZHNT0 Q==;
X-CSE-ConnectionGUID: wWxClmUfSRqh4WmTQP12oA==
X-CSE-MsgGUID: poOl7NKKRYKgjCiJZSZh5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89330175"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="89330175"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 08:22:12 -0700
X-CSE-ConnectionGUID: XSc2QySdQRGg2QPn36F4pA==
X-CSE-MsgGUID: qyUXjYmpT2eT+s2q/Q6MGQ==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 08 Sep 2026 08:22:09 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 10/19] net/ixgbe: reimplement FDIR parser
Date: Tue,  8 Sep 2026 16:20:52 +0100
Message-ID: <eab8aac256b7e5ac8ad08da8dec0f1ef20ed39fc.1788880124.git.anatoly.burakov@intel.com>
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
flow parser for flow director.

The FDIR flow tracking is moved inside the new engine, and the FDIR code is
refactored to not mix software tracking with HW writes.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c    |   99 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h    |   71 +-
 drivers/net/intel/ixgbe/ixgbe_fdir.c      |  304 +---
 drivers/net/intel/ixgbe/ixgbe_flow.c      | 1587 +------------------
 drivers/net/intel/ixgbe/ixgbe_flow.h      |    2 +
 drivers/net/intel/ixgbe/ixgbe_flow_fdir.c | 1703 +++++++++++++++++++++
 drivers/net/intel/ixgbe/meson.build       |    1 +
 7 files changed, 1848 insertions(+), 1919 deletions(-)
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_fdir.c

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index f1541a1554..94af935390 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -144,8 +144,6 @@ static const char * const ixgbevf_valid_arguments[] = {
 
 static int eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params);
 static int eth_ixgbe_dev_uninit(struct rte_eth_dev *eth_dev);
-static int ixgbe_fdir_filter_init(struct rte_eth_dev *eth_dev);
-static int ixgbe_fdir_filter_uninit(struct rte_eth_dev *eth_dev);
 static int ixgbe_l2_tn_filter_init(struct rte_eth_dev *eth_dev);
 static int ixgbe_dev_configure(struct rte_eth_dev *dev);
 static int ixgbe_dev_start(struct rte_eth_dev *dev);
@@ -1316,11 +1314,6 @@ eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 	memset(filter_info, 0,
 	       sizeof(struct ixgbe_filter_info));
 
-	/* initialize flow director filter list & hash */
-	ret = ixgbe_fdir_filter_init(eth_dev);
-	if (ret)
-		goto err_fdir_filter_init;
-
 	/* initialize l2 tunnel filter list & hash */
 	ret = ixgbe_l2_tn_filter_init(eth_dev);
 	if (ret)
@@ -1345,8 +1338,6 @@ eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 
 err_flow_engine_conf_init:
 err_l2_tn_filter_init:
-	ixgbe_fdir_filter_uninit(eth_dev);
-err_fdir_filter_init:
 	ixgbe_disable_intr(hw);
 	rte_intr_disable(intr_handle);
 	rte_intr_callback_unregister(intr_handle,
@@ -1376,32 +1367,24 @@ eth_ixgbe_dev_uninit(struct rte_eth_dev *eth_dev)
 	return 0;
 }
 
-static int ixgbe_fdir_filter_uninit(struct rte_eth_dev *eth_dev)
+void
+ixgbe_fdir_state_detach(struct ixgbe_fdir_state *state)
 {
-	struct ixgbe_hw_fdir_info *fdir_info =
-		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(eth_dev->data->dev_private);
-	struct ixgbe_fdir_filter *fdir_filter;
+	if (--state->refcnt > 0)
+		return;
 
-	rte_free(fdir_info->hash_map);
-	rte_hash_free(fdir_info->hash_handle);
-
-	while ((fdir_filter = TAILQ_FIRST(&fdir_info->fdir_list))) {
-		TAILQ_REMOVE(&fdir_info->fdir_list,
-			     fdir_filter,
-			     entries);
-		rte_free(fdir_filter);
-	}
-
-	return 0;
+	state->adapter->fdir_state = NULL;
+	rte_hash_free(state->hash_handle);
+	rte_free(state);
 }
 
-static int ixgbe_fdir_filter_init(struct rte_eth_dev *eth_dev)
+struct ixgbe_fdir_state *
+ixgbe_fdir_state_attach(struct rte_eth_dev_data *dev_data)
 {
-	struct ixgbe_hw_fdir_info *fdir_info =
-		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(eth_dev->data->dev_private);
-	char fdir_hash_name[RTE_HASH_NAMESIZE];
-	struct rte_hash_parameters fdir_hash_params = {
-		.name = fdir_hash_name,
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev_data->dev_private);
+	struct ixgbe_fdir_state *state = adapter->fdir_state;
+	struct rte_hash_parameters hash_params = {
+		.name = "ixgbe_fdir_hash",
 		.entries = IXGBE_MAX_FDIR_FILTER_NUM,
 		.key_len = sizeof(union ixgbe_atr_input),
 		.hash_func = rte_hash_crc,
@@ -1409,31 +1392,36 @@ static int ixgbe_fdir_filter_init(struct rte_eth_dev *eth_dev)
 		.socket_id = rte_socket_id(),
 	};
 
-	TAILQ_INIT(&fdir_info->fdir_list);
-	snprintf(fdir_hash_name, RTE_HASH_NAMESIZE,
-		 "fdir_%s", eth_dev->device->name);
-	fdir_info->hash_handle = rte_hash_create(&fdir_hash_params);
-	if (!fdir_info->hash_handle) {
-		PMD_INIT_LOG(ERR, "Failed to create fdir hash table!");
-		return -EINVAL;
-	}
-	fdir_info->hash_map = rte_zmalloc("ixgbe",
-					  sizeof(struct ixgbe_fdir_filter *) *
-					  IXGBE_MAX_FDIR_FILTER_NUM,
-					  0);
-	if (!fdir_info->hash_map) {
-		PMD_INIT_LOG(ERR,
-			     "Failed to allocate memory for fdir hash map!");
-		rte_hash_free(fdir_info->hash_handle);
-		return -ENOMEM;
+	if (state == NULL) {
+		state = rte_zmalloc("ixgbe_fdir_state", sizeof(*state), 0);
+		if (state == NULL) {
+			PMD_INIT_LOG(ERR, "Failed to allocate fdir state!");
+			return NULL;
+		}
+
+		state->hash_handle = rte_hash_create(&hash_params);
+		if (state->hash_handle == NULL) {
+			PMD_INIT_LOG(ERR, "Failed to create fdir hash table!");
+			goto fail;
+		}
+
+		state->adapter = adapter;
+		state->mode = RTE_FDIR_MODE_NONE;
+
+		/* drop queue is always fixed */
+		IXGBE_DEV_PRIVATE_TO_FDIR_CONF(adapter)->drop_queue = IXGBE_FDIR_DROP_QUEUE;
+
+		adapter->fdir_state = state;
 	}
-	fdir_info->n_flows = 0;
-	fdir_info->mask_added = FALSE;
 
-	/* drop queue is always fixed */
-	IXGBE_DEV_FDIR_CONF(eth_dev)->drop_queue = IXGBE_FDIR_DROP_QUEUE;
+	/* callers are serialized by the flow framework, so no atomics needed */
+	state->refcnt++;
 
-	return 0;
+	return state;
+fail:
+	rte_hash_free(state->hash_handle);
+	rte_free(state);
+	return NULL;
 }
 
 static int ixgbe_l2_tn_filter_init(struct rte_eth_dev *eth_dev)
@@ -2937,6 +2925,9 @@ ixgbe_dev_stop(struct rte_eth_dev *dev)
 	/* reset hierarchy commit */
 	tm_conf->committed = false;
 
+	/* the reset above wiped the flow director setup, kept flows are replayed on start */
+	ixgbe_fdir_hw_invalidate(dev);
+
 	adapter->rss_reta_updated = 0;
 
 	hw->adapter_stopped = true;
@@ -3081,9 +3072,6 @@ ixgbe_dev_close(struct rte_eth_dev *dev)
 	/* uninitialize PF if max_vfs not zero */
 	ixgbe_pf_host_uninit(dev);
 
-	/* remove all the fdir filters & hash */
-	ixgbe_fdir_filter_uninit(dev);
-
 	/* clear all the filters list */
 	ixgbe_filterlist_flush(dev);
 
@@ -7861,7 +7849,6 @@ ixgbe_rss_filter_restore(struct rte_eth_dev *dev)
 static int
 ixgbe_filter_restore(struct rte_eth_dev *dev)
 {
-	ixgbe_fdir_filter_restore(dev);
 	ixgbe_rss_filter_restore(dev);
 
 	return 0;
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index bd66d4afd9..8c1f421651 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -50,6 +50,7 @@
 #define IXGBE_VMDQ_DCB_NB_QUEUES     IXGBE_MAX_RX_QUEUE_NUM
 #define IXGBE_DCB_NB_QUEUES          IXGBE_MAX_RX_QUEUE_NUM
 #define IXGBE_NONE_MODE_TX_NB_QUEUES 64
+#define IXGBE_MAX_FLX_SOURCE_OFF 62
 
 #ifndef NBBY
 #define NBBY	8	/* number of bits in a byte */
@@ -160,17 +161,6 @@ struct ixgbe_hw_fdir_mask {
 	uint8_t  tunnel_type_mask;
 };
 
-struct ixgbe_fdir_filter {
-	TAILQ_ENTRY(ixgbe_fdir_filter) entries;
-	union ixgbe_atr_input ixgbe_fdir; /* key of fdir filter*/
-	uint32_t fdirflags; /* drop or forward */
-	uint32_t fdirhash; /* hash value for fdir */
-	uint8_t queue; /* assigned rx queue */
-};
-
-/* list of fdir filters */
-TAILQ_HEAD(ixgbe_fdir_filter_list, ixgbe_fdir_filter);
-
 struct ixgbe_fdir_rule {
 	struct ixgbe_hw_fdir_mask mask;
 	union ixgbe_atr_input ixgbe_fdir; /* key of fdir filter*/
@@ -194,12 +184,43 @@ struct ixgbe_hw_fdir_info {
 	uint64_t    remove;
 	uint64_t    f_add;
 	uint64_t    f_remove;
-	struct ixgbe_fdir_filter_list fdir_list; /* filter list*/
-	/* store the pointers of the filters, index is the hash value. */
-	struct ixgbe_fdir_filter **hash_map;
+};
+
+/* per-flow object of the fdir flow engines, private to ixgbe_flow_fdir.c */
+struct ixgbe_fdir_flow;
+
+/*
+ * Per-device state owned by the flow director flow engines.
+ *
+ * The fdir and fdir_tunnel engines drive the same hardware block, so this is
+ * shared between them: it is created by whichever of the two initializes first
+ * and destroyed by whichever uninitializes last, tracked by `refcnt`. Access is
+ * serialized by the flow framework's per-device config lock.
+ *
+ * `hash_handle` tracks every registered filter, keyed by `union ixgbe_atr_input`,
+ * and exists to reject duplicate filters: two filters with the same key would
+ * otherwise collide in the same hardware slot.
+ *
+ * The hardware has only one global input mask for all filters, so `mask`,
+ * `flex_bytes_offset` and `mode` are claimed by the first registered filter and
+ * every later filter has to agree with them. They are released once the last
+ * filter is unregistered.
+ */
+struct ixgbe_fdir_state {
+	/* device this state belongs to, needed to detach on engine uninit */
+	struct ixgbe_adapter *adapter;
 	struct rte_hash *hash_handle; /* cuckoo hash handler */
-	uint32_t n_flows;
-	bool mask_added; /* If already got mask from consistent filter */
+	struct ixgbe_hw_fdir_mask mask;
+	enum rte_fdir_mode mode;
+	uint8_t flex_bytes_offset;
+	/* true once a filter that actually carries a mask has claimed the above */
+	bool mask_added;
+	/* false whenever the hardware may have lost the global fdir setup */
+	bool hw_configured;
+	/* false when the claimed mask has not been written to hardware yet */
+	bool mask_programmed;
+	uint32_t nb_registered;
+	uint16_t refcnt;
 };
 
 struct ixgbe_rte_flow_rss_conf {
@@ -438,6 +459,8 @@ struct ixgbe_adapter {
 	struct ixgbe_macsec_setting	macsec_setting;
 	struct rte_eth_fdir_conf    fdir_conf;
 	struct ixgbe_hw_fdir_info   fdir;
+	/* shared by the fdir and fdir_tunnel flow engines, NULL if neither is enabled */
+	struct ixgbe_fdir_state     *fdir_state;
 	struct ixgbe_interrupt      intr;
 	struct ixgbe_stat_mapping_registers stat_mappings;
 	struct ixgbe_vfta           shadow_vfta;
@@ -684,10 +707,19 @@ int ixgbe_fdir_set_input_mask(struct ixgbe_adapter *adapter,
 			      enum rte_fdir_mode mode);
 int ixgbe_fdir_set_flexbytes_offset(struct ixgbe_adapter *adapter,
 				    uint16_t offset);
+struct ixgbe_fdir_state *ixgbe_fdir_state_attach(struct rte_eth_dev_data *dev_data);
+void ixgbe_fdir_state_detach(struct ixgbe_fdir_state *state);
+void ixgbe_fdir_hw_invalidate(struct rte_eth_dev *dev);
+bool ixgbe_fdir_mode_is_perfect(enum rte_fdir_mode mode);
+uint32_t ixgbe_fdir_compute_hash(struct ixgbe_adapter *adapter,
+				 struct ixgbe_fdir_rule *rule);
 int ixgbe_fdir_filter_program(struct ixgbe_adapter *adapter,
-		struct rte_eth_fdir_conf *fdir_conf,
 		struct ixgbe_fdir_rule *rule,
-		bool del, bool update);
+		uint8_t queue,
+		uint32_t fdircmd_flags,
+		uint32_t fdirhash);
+int ixgbe_fdir_filter_clear(struct ixgbe_adapter *adapter, uint32_t fdirhash);
+int ixgbe_fdir_reset_tables(struct ixgbe_adapter *adapter);
 void ixgbe_fdir_info_get(struct rte_eth_dev *dev,
 			 struct rte_eth_fdir_info *fdir_info);
 void ixgbe_fdir_stats_get(struct rte_eth_dev *dev,
@@ -718,9 +750,6 @@ int ixgbe_pf_host_configure(struct rte_eth_dev *eth_dev);
 
 uint32_t ixgbe_convert_vm_rx_mask_to_val(uint16_t rx_mask, uint32_t orig_val);
 
-void ixgbe_fdir_filter_restore(struct rte_eth_dev *dev);
-int ixgbe_clear_all_fdir_filter(struct rte_eth_dev *dev);
-
 extern const struct rte_flow_ops ixgbe_flow_ops;
 
 int ixgbe_disable_sec_tx_path_generic(struct ixgbe_hw *hw);
diff --git a/drivers/net/intel/ixgbe/ixgbe_fdir.c b/drivers/net/intel/ixgbe/ixgbe_fdir.c
index b32dc54287..1adaf739c5 100644
--- a/drivers/net/intel/ixgbe/ixgbe_fdir.c
+++ b/drivers/net/intel/ixgbe/ixgbe_fdir.c
@@ -36,7 +36,6 @@
 #define SIG_BUCKET_256KB_HASH_MASK      0x7FFF  /* 15 bits */
 #define IXGBE_DEFAULT_FLEXBYTES_OFFSET  12 /* default flexbytes offset in bytes */
 #define IXGBE_FDIR_MAX_FLEX_LEN         2 /* len in bytes of flexbytes */
-#define IXGBE_MAX_FLX_SOURCE_OFF        62
 #define IXGBE_FDIRCTRL_FLEX_MASK        (0x1F << IXGBE_FDIRCTRL_FLEX_SHIFT)
 #define IXGBE_FDIRCMD_CMD_INTERVAL_US   10
 
@@ -101,7 +100,6 @@ static int fdir_write_perfect_filter_82599(struct ixgbe_hw *hw,
 static int fdir_add_signature_filter_82599(struct ixgbe_hw *hw,
 		union ixgbe_atr_input *input, u8 queue, uint32_t fdircmd,
 		uint32_t fdirhash);
-static int ixgbe_fdir_flush(struct rte_eth_dev *dev);
 
 /**
  * This function is based on ixgbe_fdir_enable_82599() in base/ixgbe_82599.c.
@@ -974,218 +972,81 @@ fdir_erase_filter_82599(struct ixgbe_hw *hw, uint32_t fdirhash)
 
 }
 
-static inline struct ixgbe_fdir_filter *
-ixgbe_fdir_filter_lookup(struct ixgbe_hw_fdir_info *fdir_info,
-			 union ixgbe_atr_input *key)
+/* hardware loses its flow director setup across a stop/start cycle */
+void
+ixgbe_fdir_hw_invalidate(struct rte_eth_dev *dev)
 {
-	int ret;
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	struct ixgbe_fdir_state *state = adapter->fdir_state;
 
-	ret = rte_hash_lookup(fdir_info->hash_handle, (const void *)key);
-	if (ret < 0)
-		return NULL;
-
-	return fdir_info->hash_map[ret];
+	if (state != NULL) {
+		state->hw_configured = false;
+		state->mask_programmed = false;
+	}
 }
 
-static inline int
-ixgbe_insert_fdir_filter(struct ixgbe_hw_fdir_info *fdir_info,
-			 struct ixgbe_fdir_filter *fdir_filter)
+bool
+ixgbe_fdir_mode_is_perfect(enum rte_fdir_mode mode)
 {
-	int ret;
-
-	ret = rte_hash_add_key(fdir_info->hash_handle,
-			       &fdir_filter->ixgbe_fdir);
-
-	if (ret < 0) {
-		PMD_DRV_LOG(ERR,
-			    "Failed to insert fdir filter to hash table %d!",
-			    ret);
-		return ret;
-	}
-
-	fdir_info->hash_map[ret] = fdir_filter;
-
-	TAILQ_INSERT_TAIL(&fdir_info->fdir_list, fdir_filter, entries);
-
-	return 0;
+	return mode >= RTE_FDIR_MODE_PERFECT && mode <= RTE_FDIR_MODE_PERFECT_TUNNEL;
 }
 
-static inline int
-ixgbe_remove_fdir_filter(struct ixgbe_hw_fdir_info *fdir_info,
-			 union ixgbe_atr_input *key)
+uint32_t
+ixgbe_fdir_compute_hash(struct ixgbe_adapter *adapter, struct ixgbe_fdir_rule *rule)
 {
-	int ret;
-	struct ixgbe_fdir_filter *fdir_filter;
-
-	ret = rte_hash_del_key(fdir_info->hash_handle, key);
-
-	if (ret < 0) {
-		PMD_DRV_LOG(ERR, "No such fdir filter to delete %d!", ret);
-		return ret;
-	}
+	const struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_PRIVATE_TO_FDIR_CONF(adapter);
+	uint32_t fdirhash;
 
-	fdir_filter = fdir_info->hash_map[ret];
-	fdir_info->hash_map[ret] = NULL;
+	if (!ixgbe_fdir_mode_is_perfect(rule->mode))
+		return atr_compute_sig_hash_82599(&rule->ixgbe_fdir, fdir_conf->pballoc);
 
-	TAILQ_REMOVE(&fdir_info->fdir_list, fdir_filter, entries);
-	rte_free(fdir_filter);
+	fdirhash = atr_compute_perfect_hash_82599(&rule->ixgbe_fdir, fdir_conf->pballoc);
+	fdirhash |= rule->soft_id << IXGBE_FDIRHASH_SIG_SW_INDEX_SHIFT;
 
-	return 0;
+	return fdirhash;
 }
 
 int
 ixgbe_fdir_filter_program(struct ixgbe_adapter *adapter,
-		struct rte_eth_fdir_conf *fdir_conf,
 		struct ixgbe_fdir_rule *rule,
-		bool del,
-		bool update)
+		uint8_t queue,
+		uint32_t fdircmd_flags,
+		uint32_t fdirhash)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
-	uint32_t fdircmd_flags;
-	uint32_t fdirhash;
-	uint8_t queue;
-	bool is_perfect = FALSE;
 	int err;
-	struct ixgbe_hw_fdir_info *info =
-		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
-	enum rte_fdir_mode fdir_mode = fdir_conf->mode;
-	struct ixgbe_fdir_filter *node;
-	bool add_node = FALSE;
 
-	if (fdir_mode == RTE_FDIR_MODE_NONE ||
-	    fdir_mode != rule->mode)
-		return -ENOTSUP;
-
-	/*
-	 * Sanity check for x550 and E610.
-	 * When adding a new filter with flow type set to IPv4,
-	 * the flow director mask should be configed before,
-	 * and the L4 protocol and ports are masked.
-	 */
-	if ((!del) &&
-	    (hw->mac.type == ixgbe_mac_X550 ||
-	     hw->mac.type == ixgbe_mac_X550EM_x ||
-	     hw->mac.type == ixgbe_mac_X550EM_a ||
-	     hw->mac.type == ixgbe_mac_E610) &&
-	    (rule->ixgbe_fdir.formatted.flow_type ==
-	     IXGBE_ATR_FLOW_TYPE_IPV4 ||
-	     rule->ixgbe_fdir.formatted.flow_type ==
-	     IXGBE_ATR_FLOW_TYPE_IPV6) &&
-	    (info->mask.src_port_mask != 0 ||
-	     info->mask.dst_port_mask != 0) &&
-	    (rule->mode != RTE_FDIR_MODE_PERFECT_MAC_VLAN &&
-	     rule->mode != RTE_FDIR_MODE_PERFECT_TUNNEL)) {
-		PMD_DRV_LOG(ERR, "By this device,"
-			    " IPv4 is not supported without"
-			    " L4 protocol and ports masked!");
-		return -ENOTSUP;
-	}
-
-	if (fdir_mode >= RTE_FDIR_MODE_PERFECT &&
-	    fdir_mode <= RTE_FDIR_MODE_PERFECT_TUNNEL)
-		is_perfect = TRUE;
-
-	if (is_perfect) {
-		if (rule->ixgbe_fdir.formatted.flow_type &
-		    IXGBE_ATR_L4TYPE_IPV6_MASK) {
-			PMD_DRV_LOG(ERR, "IPv6 is not supported in"
-				    " perfect mode!");
-			return -ENOTSUP;
-		}
-		fdirhash = atr_compute_perfect_hash_82599(&rule->ixgbe_fdir,
-				fdir_conf->pballoc);
-		fdirhash |= rule->soft_id <<
-			IXGBE_FDIRHASH_SIG_SW_INDEX_SHIFT;
-	} else
-		fdirhash = atr_compute_sig_hash_82599(&rule->ixgbe_fdir,
-				fdir_conf->pballoc);
-
-	if (del) {
-		err = ixgbe_remove_fdir_filter(info, &rule->ixgbe_fdir);
-		if (err < 0)
-			return err;
-
-		err = fdir_erase_filter_82599(hw, fdirhash);
-		if (err < 0)
-			PMD_DRV_LOG(ERR, "Fail to delete FDIR filter!");
-		else
-			PMD_DRV_LOG(DEBUG, "Success to delete FDIR filter!");
-		return err;
-	}
-	/* add or update an fdir filter*/
-	fdircmd_flags = (update) ? IXGBE_FDIRCMD_FILTER_UPDATE : 0;
-	if (rule->fdirflags & IXGBE_FDIRCMD_DROP) {
-		if (is_perfect) {
-			queue = fdir_conf->drop_queue;
-			fdircmd_flags |= IXGBE_FDIRCMD_DROP;
-		} else {
-			PMD_DRV_LOG(ERR, "Drop option is not supported in"
-				    " signature mode.");
-			return -EINVAL;
-		}
-	} else if (rule->queue < IXGBE_MAX_RX_QUEUE_NUM)
-		queue = (uint8_t)rule->queue;
+	if (ixgbe_fdir_mode_is_perfect(rule->mode))
+		err = fdir_write_perfect_filter_82599(hw, &rule->ixgbe_fdir, queue,
+				fdircmd_flags, fdirhash, rule->mode);
 	else
-		return -EINVAL;
+		err = fdir_add_signature_filter_82599(hw, &rule->ixgbe_fdir, queue,
+				fdircmd_flags, fdirhash);
 
-	node = ixgbe_fdir_filter_lookup(info, &rule->ixgbe_fdir);
-	if (node) {
-		if (update) {
-			node->fdirflags = fdircmd_flags;
-			node->fdirhash = fdirhash;
-			node->queue = queue;
-		} else {
-			PMD_DRV_LOG(ERR, "Conflict with existing fdir filter!");
-			return -EINVAL;
-		}
-	} else {
-		add_node = TRUE;
-		node = rte_zmalloc("ixgbe_fdir",
-				   sizeof(struct ixgbe_fdir_filter),
-				   0);
-		if (!node)
-			return -ENOMEM;
-		memcpy(&node->ixgbe_fdir,
-				 &rule->ixgbe_fdir,
-				 sizeof(union ixgbe_atr_input));
-		node->fdirflags = fdircmd_flags;
-		node->fdirhash = fdirhash;
-		node->queue = queue;
-
-		err = ixgbe_insert_fdir_filter(info, node);
-		if (err < 0) {
-			rte_free(node);
-			return err;
-		}
-	}
-
-	if (is_perfect) {
-		err = fdir_write_perfect_filter_82599(hw, &rule->ixgbe_fdir,
-						      queue, fdircmd_flags,
-						      fdirhash, fdir_mode);
-	} else {
-		err = fdir_add_signature_filter_82599(hw, &rule->ixgbe_fdir,
-						      queue, fdircmd_flags,
-						      fdirhash);
-	}
-	if (err < 0) {
+	if (err < 0)
 		PMD_DRV_LOG(ERR, "Fail to add FDIR filter!");
 
-		if (add_node)
-			(void)ixgbe_remove_fdir_filter(info, &rule->ixgbe_fdir);
-	} else {
-		PMD_DRV_LOG(DEBUG, "Success to add FDIR filter");
-	}
+	return err;
+}
+
+int
+ixgbe_fdir_filter_clear(struct ixgbe_adapter *adapter, uint32_t fdirhash)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
+	int err;
+
+	err = fdir_erase_filter_82599(hw, fdirhash);
+	if (err < 0)
+		PMD_DRV_LOG(ERR, "Fail to delete FDIR filter!");
 
 	return err;
 }
 
-static int
-ixgbe_fdir_flush(struct rte_eth_dev *dev)
+int
+ixgbe_fdir_reset_tables(struct ixgbe_adapter *adapter)
 {
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct ixgbe_hw_fdir_info *info =
-			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
+	struct ixgbe_hw_fdir_info *info = IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
 	int ret;
 
 	ret = ixgbe_reinit_fdir_tables_82599(hw);
@@ -1318,76 +1179,3 @@ ixgbe_fdir_stats_get(struct rte_eth_dev *dev, struct rte_eth_fdir_stats *fdir_st
 		fdir_stats->guarant_cnt = max_num * 4 - fdir_stats->free;
 
 }
-
-/* restore flow director filter */
-void
-ixgbe_fdir_filter_restore(struct rte_eth_dev *dev)
-{
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
-	struct ixgbe_hw_fdir_info *fdir_info =
-		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
-	struct ixgbe_fdir_filter *node;
-	bool is_perfect = FALSE;
-	enum rte_fdir_mode fdir_mode = fdir_conf->mode;
-
-	if (fdir_mode >= RTE_FDIR_MODE_PERFECT &&
-	    fdir_mode <= RTE_FDIR_MODE_PERFECT_TUNNEL)
-		is_perfect = TRUE;
-
-	if (is_perfect) {
-		TAILQ_FOREACH(node, &fdir_info->fdir_list, entries) {
-			(void)fdir_write_perfect_filter_82599(hw,
-							      &node->ixgbe_fdir,
-							      node->queue,
-							      node->fdirflags,
-							      node->fdirhash,
-							      fdir_mode);
-		}
-	} else {
-		TAILQ_FOREACH(node, &fdir_info->fdir_list, entries) {
-			(void)fdir_add_signature_filter_82599(hw,
-							      &node->ixgbe_fdir,
-							      node->queue,
-							      node->fdirflags,
-							      node->fdirhash);
-		}
-	}
-}
-
-/* remove all the flow director filters */
-int
-ixgbe_clear_all_fdir_filter(struct rte_eth_dev *dev)
-{
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
-	struct ixgbe_hw_fdir_info *fdir_info =
-		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
-	struct ixgbe_fdir_filter *fdir_filter;
-	bool had_flows;
-	int ret = 0;
-
-	had_flows = (fdir_info->n_flows != 0);
-
-	/* flush flow director */
-	rte_hash_reset(fdir_info->hash_handle);
-	memset(fdir_info->hash_map, 0,
-	       sizeof(struct ixgbe_fdir_filter *) * IXGBE_MAX_FDIR_FILTER_NUM);
-	while ((fdir_filter = TAILQ_FIRST(&fdir_info->fdir_list))) {
-		TAILQ_REMOVE(&fdir_info->fdir_list,
-			     fdir_filter,
-			     entries);
-		rte_free(fdir_filter);
-	}
-	fdir_info->n_flows = 0;
-
-	/* reset internal FDIR state */
-	fdir_info->mask = (struct ixgbe_hw_fdir_mask){0};
-	fdir_info->flex_bytes_offset = 0;
-	fdir_info->mask_added = FALSE;
-	fdir_conf->mode = RTE_FDIR_MODE_NONE;
-
-	if (had_flows)
-		ret = ixgbe_fdir_flush(dev);
-
-	return ret;
-}
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 4c268ac7f1..868d65b2a8 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -50,17 +50,10 @@
 #include "../common/flow_engine.h"
 #include "ixgbe_flow.h"
 
-#define IXGBE_MAX_FLX_SOURCE_OFF 62
-
 struct ixgbe_filter_ele_base {
 	TAILQ_ENTRY(ixgbe_filter_ele_base) entries;
 };
 
-/* fdir filter list structure */
-struct ixgbe_fdir_rule_ele {
-	struct ixgbe_filter_ele_base base;
-	struct ixgbe_fdir_rule filter_info;
-};
 /* rss filter list structure */
 struct ixgbe_rss_conf_ele {
 	struct ixgbe_filter_ele_base base;
@@ -79,28 +72,10 @@ const struct ci_flow_engine_list ixgbe_flow_engine_list = {
 		&ixgbe_l2_tunnel_flow_engine,
 		&ixgbe_ntuple_flow_engine,
 		&ixgbe_security_flow_engine,
+		&ixgbe_fdir_flow_engine,
+		&ixgbe_fdir_tunnel_flow_engine,
 	},
 };
-
-/**
- * Endless loop will never happen with below assumption
- * 1. there is at least one no-void item(END)
- * 2. cur is before END.
- */
-static inline
-const struct rte_flow_item *next_no_void_pattern(
-		const struct rte_flow_item pattern[],
-		const struct rte_flow_item *cur)
-{
-	const struct rte_flow_item *next =
-		cur ? cur + 1 : &pattern[0];
-	while (1) {
-		if (next->type != RTE_FLOW_ITEM_TYPE_VOID)
-			return next;
-		next++;
-	}
-}
-
 /*
  * All ixgbe engines mostly check the same stuff, so use a common check.
  */
@@ -156,1491 +131,6 @@ ixgbe_flow_actions_check(const struct ci_flow_actions *actions,
  * normally the packets should use network order.
  */
 
-/* search next no void pattern and skip fuzzy */
-static inline
-const struct rte_flow_item *next_no_fuzzy_pattern(
-		const struct rte_flow_item pattern[],
-		const struct rte_flow_item *cur)
-{
-	const struct rte_flow_item *next =
-		next_no_void_pattern(pattern, cur);
-	while (1) {
-		if (next->type != RTE_FLOW_ITEM_TYPE_FUZZY)
-			return next;
-		next = next_no_void_pattern(pattern, next);
-	}
-}
-
-static inline uint8_t signature_match(const struct rte_flow_item pattern[])
-{
-	const struct rte_flow_item_fuzzy *spec, *last, *mask;
-	const struct rte_flow_item *item;
-	uint32_t sh, lh, mh;
-	int i = 0;
-
-	while (1) {
-		item = pattern + i;
-		if (item->type == RTE_FLOW_ITEM_TYPE_END)
-			break;
-
-		if (item->type == RTE_FLOW_ITEM_TYPE_FUZZY) {
-			spec = item->spec;
-			last = item->last;
-			mask = item->mask;
-
-			if (!spec || !mask)
-				return 0;
-
-			sh = spec->thresh;
-
-			if (!last)
-				lh = sh;
-			else
-				lh = last->thresh;
-
-			mh = mask->thresh;
-			sh = sh & mh;
-			lh = lh & mh;
-
-			if (!sh || sh > lh)
-				return 0;
-
-			return 1;
-		}
-
-		i++;
-	}
-
-	return 0;
-}
-
-/**
- * Parse the rule to see if it is a IP or MAC VLAN flow director rule.
- * And get the flow director filter info BTW.
- * UDP/TCP/SCTP PATTERN:
- * The first not void item can be ETH or IPV4 or IPV6
- * The second not void item must be IPV4 or IPV6 if the first one is ETH.
- * The next not void item could be UDP or TCP or SCTP (optional)
- * The next not void item could be RAW (for flexbyte, optional)
- * The next not void item must be END.
- * A Fuzzy Match pattern can appear at any place before END.
- * Fuzzy Match is optional for IPV4 but is required for IPV6
- * MAC VLAN PATTERN:
- * The first not void item must be ETH.
- * The second not void item must be MAC VLAN.
- * The next not void item must be END.
- * ACTION:
- * The first not void action should be QUEUE or DROP.
- * The second not void optional action should be MARK,
- * mark_id is a uint32_t number.
- * The next not void action should be END.
- * UDP/TCP/SCTP pattern example:
- * ITEM		Spec			Mask
- * ETH		NULL			NULL
- * IPV4		src_addr 192.168.1.20	0xFFFFFFFF
- *		dst_addr 192.167.3.50	0xFFFFFFFF
- * UDP/TCP/SCTP	src_port	80	0xFFFF
- *		dst_port	80	0xFFFF
- * FLEX	relative	0	0x1
- *		search		0	0x1
- *		reserved	0	0
- *		offset		12	0xFFFFFFFF
- *		limit		0	0xFFFF
- *		length		2	0xFFFF
- *		pattern[0]	0x86	0xFF
- *		pattern[1]	0xDD	0xFF
- * END
- * MAC VLAN pattern example:
- * ITEM		Spec			Mask
- * ETH		dst_addr
-		{0xAC, 0x7B, 0xA1,	{0xFF, 0xFF, 0xFF,
-		0x2C, 0x6D, 0x36}	0xFF, 0xFF, 0xFF}
- * MAC VLAN	tci	0x2016		0xEFFF
- * END
- * Other members in mask and spec should set to 0x00.
- * Item->last should be NULL.
- */
-static int
-ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
-			       const struct rte_flow_item pattern[],
-			       const struct ci_flow_actions *parsed_actions,
-			       struct ixgbe_fdir_rule *rule,
-			       struct rte_flow_error *error)
-{
-	const struct rte_flow_item *item;
-	const struct rte_flow_item_eth *eth_spec;
-	const struct rte_flow_item_eth *eth_mask;
-	const struct rte_flow_item_ipv4 *ipv4_spec;
-	const struct rte_flow_item_ipv4 *ipv4_mask;
-	const struct rte_flow_item_ipv6 *ipv6_spec;
-	const struct rte_flow_item_ipv6 *ipv6_mask;
-	const struct rte_flow_item_tcp *tcp_spec;
-	const struct rte_flow_item_tcp *tcp_mask;
-	const struct rte_flow_item_udp *udp_spec;
-	const struct rte_flow_item_udp *udp_mask;
-	const struct rte_flow_item_sctp *sctp_spec;
-	const struct rte_flow_item_sctp *sctp_mask;
-	const struct rte_flow_item_vlan *vlan_spec;
-	const struct rte_flow_item_vlan *vlan_mask;
-	const struct rte_flow_item_raw *raw_mask;
-	const struct rte_flow_item_raw *raw_spec;
-	const struct rte_flow_action *fwd_action, *aux_action;
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	uint8_t j;
-
-	fwd_action = parsed_actions->actions[0];
-	/* can be NULL */
-	aux_action = parsed_actions->actions[1];
-
-	/**
-	 * Some fields may not be provided. Set spec to 0 and mask to default
-	 * value. So, we need not do anything for the not provided fields later.
-	 */
-	memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-	memset(&rule->mask, 0xFF, sizeof(struct ixgbe_hw_fdir_mask));
-	rule->mask.vlan_tci_mask = 0;
-	rule->mask.flex_bytes_mask = 0;
-	rule->mask.l4_proto_match = 0;
-	rule->mask.dst_port_mask = 0;
-	rule->mask.src_port_mask = 0;
-
-	/* check if this is a signature match */
-	if (signature_match(pattern))
-		rule->mode = RTE_FDIR_MODE_SIGNATURE;
-	else
-		rule->mode = RTE_FDIR_MODE_PERFECT;
-
-	/* set up action */
-	if (fwd_action->type == RTE_FLOW_ACTION_TYPE_QUEUE) {
-		const struct rte_flow_action_queue *q_act = fwd_action->conf;
-		rule->queue = q_act->index;
-	} else {
-		/* signature mode does not support drop action. */
-		if (rule->mode == RTE_FDIR_MODE_SIGNATURE) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION, fwd_action,
-				"Signature mode does not support drop action.");
-			return -rte_errno;
-		}
-		rule->fdirflags = IXGBE_FDIRCMD_DROP;
-	}
-
-	/* set up mark action */
-	if (aux_action != NULL && aux_action->type == RTE_FLOW_ACTION_TYPE_MARK) {
-		const struct rte_flow_action_mark *m_act = aux_action->conf;
-		rule->soft_id = m_act->id;
-	}
-
-	/**
-	 * The first not void item should be
-	 * MAC or IPv4 or TCP or UDP or SCTP.
-	 */
-	item = next_no_fuzzy_pattern(pattern, NULL);
-	if (item->type != RTE_FLOW_ITEM_TYPE_ETH &&
-	    item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
-	    item->type != RTE_FLOW_ITEM_TYPE_IPV6 &&
-	    item->type != RTE_FLOW_ITEM_TYPE_TCP &&
-	    item->type != RTE_FLOW_ITEM_TYPE_UDP &&
-	    item->type != RTE_FLOW_ITEM_TYPE_SCTP) {
-		memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by fdir filter");
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
-	if (item->type == RTE_FLOW_ITEM_TYPE_ETH) {
-		/**
-		 * Only support vlan and dst MAC address,
-		 * others should be masked.
-		 */
-		if (item->spec && !item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		if (item->spec) {
-			rule->b_spec = TRUE;
-			eth_spec = item->spec;
-
-			/* Get the dst MAC. */
-			for (j = 0; j < RTE_ETHER_ADDR_LEN; j++) {
-				rule->ixgbe_fdir.formatted.inner_mac[j] =
-					eth_spec->hdr.dst_addr.addr_bytes[j];
-			}
-		}
-
-
-		if (item->mask) {
-
-			rule->b_mask = TRUE;
-			eth_mask = item->mask;
-
-			/* Ether type should be masked. */
-			if (eth_mask->hdr.ether_type ||
-			    rule->mode == RTE_FDIR_MODE_SIGNATURE) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-
-			/* If ethernet has meaning, it means MAC VLAN mode. */
-			rule->mode = RTE_FDIR_MODE_PERFECT_MAC_VLAN;
-
-			/**
-			 * src MAC address must be masked,
-			 * and don't support dst MAC address mask.
-			 */
-			for (j = 0; j < RTE_ETHER_ADDR_LEN; j++) {
-				if (eth_mask->hdr.src_addr.addr_bytes[j] ||
-					eth_mask->hdr.dst_addr.addr_bytes[j] != 0xFF) {
-					memset(rule, 0,
-					sizeof(struct ixgbe_fdir_rule));
-					rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-					return -rte_errno;
-				}
-			}
-
-			/* When no VLAN, considered as full mask. */
-			rule->mask.vlan_tci_mask = rte_cpu_to_be_16(0xEFFF);
-		}
-		/*** If both spec and mask are item,
-		 * it means don't care about ETH.
-		 * Do nothing.
-		 */
-
-		/**
-		 * Check if the next not void item is vlan or ipv4.
-		 * IPv6 is not supported.
-		 */
-		item = next_no_fuzzy_pattern(pattern, item);
-		if (rule->mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN) {
-			if (item->type != RTE_FLOW_ITEM_TYPE_VLAN) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-		} else {
-			if (item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
-					item->type != RTE_FLOW_ITEM_TYPE_VLAN) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-		}
-	}
-
-	if (item->type == RTE_FLOW_ITEM_TYPE_VLAN) {
-		if (!(item->spec && item->mask)) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-
-		vlan_spec = item->spec;
-		vlan_mask = item->mask;
-
-		rule->ixgbe_fdir.formatted.vlan_id = vlan_spec->hdr.vlan_tci;
-
-		rule->mask.vlan_tci_mask = vlan_mask->hdr.vlan_tci;
-		rule->mask.vlan_tci_mask &= rte_cpu_to_be_16(0xEFFF);
-		/* More than one tags are not supported. */
-
-		/* Next not void item must be END */
-		item = next_no_fuzzy_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_END) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/* Get the IPV4 info. */
-	if (item->type == RTE_FLOW_ITEM_TYPE_IPV4) {
-		/**
-		 * Set the flow type even if there's no content
-		 * as we must have a flow type.
-		 */
-		rule->ixgbe_fdir.formatted.flow_type =
-			IXGBE_ATR_FLOW_TYPE_IPV4;
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-		/**
-		 * Only care about src & dst addresses,
-		 * others should be masked.
-		 */
-		if (!item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		rule->b_mask = TRUE;
-		ipv4_mask = item->mask;
-		if (ipv4_mask->hdr.version_ihl ||
-		    ipv4_mask->hdr.type_of_service ||
-		    ipv4_mask->hdr.total_length ||
-		    ipv4_mask->hdr.packet_id ||
-		    ipv4_mask->hdr.fragment_offset ||
-		    ipv4_mask->hdr.time_to_live ||
-		    ipv4_mask->hdr.next_proto_id ||
-		    ipv4_mask->hdr.hdr_checksum) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		rule->mask.dst_ipv4_mask = ipv4_mask->hdr.dst_addr;
-		rule->mask.src_ipv4_mask = ipv4_mask->hdr.src_addr;
-
-		if (item->spec) {
-			rule->b_spec = TRUE;
-			ipv4_spec = item->spec;
-			rule->ixgbe_fdir.formatted.dst_ip[0] =
-				ipv4_spec->hdr.dst_addr;
-			rule->ixgbe_fdir.formatted.src_ip[0] =
-				ipv4_spec->hdr.src_addr;
-		}
-
-		/**
-		 * Check if the next not void item is
-		 * TCP or UDP or SCTP or END.
-		 */
-		item = next_no_fuzzy_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_TCP &&
-		    item->type != RTE_FLOW_ITEM_TYPE_UDP &&
-		    item->type != RTE_FLOW_ITEM_TYPE_SCTP &&
-		    item->type != RTE_FLOW_ITEM_TYPE_END &&
-		    item->type != RTE_FLOW_ITEM_TYPE_RAW) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/* Get the IPV6 info. */
-	if (item->type == RTE_FLOW_ITEM_TYPE_IPV6) {
-		/**
-		 * Set the flow type even if there's no content
-		 * as we must have a flow type.
-		 */
-		rule->ixgbe_fdir.formatted.flow_type =
-			IXGBE_ATR_FLOW_TYPE_IPV6;
-
-		/**
-		 * 1. must signature match
-		 * 2. not support last
-		 * 3. mask must not null
-		 */
-		if (rule->mode != RTE_FDIR_MODE_SIGNATURE ||
-		    item->last ||
-		    !item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-
-		rule->b_mask = TRUE;
-		ipv6_mask = item->mask;
-		if (ipv6_mask->hdr.vtc_flow ||
-		    ipv6_mask->hdr.payload_len ||
-		    ipv6_mask->hdr.proto ||
-		    ipv6_mask->hdr.hop_limits) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		/* check src addr mask */
-		for (j = 0; j < 16; j++) {
-			if (ipv6_mask->hdr.src_addr.a[j] == 0) {
-				rule->mask.src_ipv6_mask &= ~(1 << j);
-			} else if (ipv6_mask->hdr.src_addr.a[j] != UINT8_MAX) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-		}
-
-		/* check dst addr mask */
-		for (j = 0; j < 16; j++) {
-			if (ipv6_mask->hdr.dst_addr.a[j] == 0) {
-				rule->mask.dst_ipv6_mask &= ~(1 << j);
-			} else if (ipv6_mask->hdr.dst_addr.a[j] != UINT8_MAX) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-		}
-
-		if (item->spec) {
-			rule->b_spec = TRUE;
-			ipv6_spec = item->spec;
-			memcpy(rule->ixgbe_fdir.formatted.src_ip,
-				   &ipv6_spec->hdr.src_addr, 16);
-			memcpy(rule->ixgbe_fdir.formatted.dst_ip,
-				   &ipv6_spec->hdr.dst_addr, 16);
-		}
-
-		/**
-		 * Check if the next not void item is
-		 * TCP or UDP or SCTP or END.
-		 */
-		item = next_no_fuzzy_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_TCP &&
-		    item->type != RTE_FLOW_ITEM_TYPE_UDP &&
-		    item->type != RTE_FLOW_ITEM_TYPE_SCTP &&
-		    item->type != RTE_FLOW_ITEM_TYPE_END &&
-		    item->type != RTE_FLOW_ITEM_TYPE_RAW) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/* Get the TCP info. */
-	if (item->type == RTE_FLOW_ITEM_TYPE_TCP) {
-		/**
-		 * Set the flow type even if there's no content
-		 * as we must have a flow type.
-		 */
-		rule->ixgbe_fdir.formatted.flow_type |=
-			IXGBE_ATR_L4TYPE_TCP;
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-		tcp_mask = item->mask;
-		if (tcp_mask != NULL) {
-			/**
-			 * Only care about src & dst ports,
-			 * others should be masked.
-			 */
-			rule->b_mask = TRUE;
-			if (tcp_mask->hdr.sent_seq ||
-			    tcp_mask->hdr.recv_ack ||
-			    tcp_mask->hdr.data_off ||
-			    tcp_mask->hdr.tcp_flags ||
-			    tcp_mask->hdr.rx_win ||
-			    tcp_mask->hdr.cksum ||
-			    tcp_mask->hdr.tcp_urp) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-			rule->mask.src_port_mask = tcp_mask->hdr.src_port;
-			rule->mask.dst_port_mask = tcp_mask->hdr.dst_port;
-
-			if (item->spec) {
-				rule->b_spec = TRUE;
-				tcp_spec = item->spec;
-				rule->ixgbe_fdir.formatted.src_port =
-					tcp_spec->hdr.src_port;
-				rule->ixgbe_fdir.formatted.dst_port =
-					tcp_spec->hdr.dst_port;
-			}
-		} else if (item->spec != NULL) {
-			/* No port mask means protocol-only match; spec is invalid. */
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		item = next_no_fuzzy_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_RAW &&
-		    item->type != RTE_FLOW_ITEM_TYPE_END) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-	}
-
-	/* Get the UDP info */
-	if (item->type == RTE_FLOW_ITEM_TYPE_UDP) {
-		/**
-		 * Set the flow type even if there's no content
-		 * as we must have a flow type.
-		 */
-		rule->ixgbe_fdir.formatted.flow_type |=
-			IXGBE_ATR_L4TYPE_UDP;
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-		udp_mask = item->mask;
-		if (udp_mask != NULL) {
-			/**
-			 * Only care about src & dst ports,
-			 * others should be masked.
-			 */
-			rule->b_mask = TRUE;
-			if (udp_mask->hdr.dgram_len ||
-			    udp_mask->hdr.dgram_cksum) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-			rule->mask.src_port_mask = udp_mask->hdr.src_port;
-			rule->mask.dst_port_mask = udp_mask->hdr.dst_port;
-
-			if (item->spec) {
-				rule->b_spec = TRUE;
-				udp_spec = item->spec;
-				rule->ixgbe_fdir.formatted.src_port =
-					udp_spec->hdr.src_port;
-				rule->ixgbe_fdir.formatted.dst_port =
-					udp_spec->hdr.dst_port;
-			}
-		} else if (item->spec != NULL) {
-			/* No port mask means protocol-only match; spec is invalid. */
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		item = next_no_fuzzy_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_RAW &&
-		    item->type != RTE_FLOW_ITEM_TYPE_END) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-	}
-
-	/* Get the SCTP info */
-	if (item->type == RTE_FLOW_ITEM_TYPE_SCTP) {
-		/**
-		 * Set the flow type even if there's no content
-		 * as we must have a flow type.
-		 */
-		rule->ixgbe_fdir.formatted.flow_type |=
-			IXGBE_ATR_L4TYPE_SCTP;
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-
-		sctp_mask = item->mask;
-		if (sctp_mask != NULL) {
-			/* only some mac types support sctp port masking */
-			if (hw->mac.type == ixgbe_mac_X550 ||
-			    hw->mac.type == ixgbe_mac_X550EM_x ||
-			    hw->mac.type == ixgbe_mac_X550EM_a ||
-			    hw->mac.type == ixgbe_mac_E610) {
-				/**
-				 * Only care about src & dst ports,
-				 * others should be masked.
-				 */
-				rule->b_mask = TRUE;
-				if (sctp_mask->hdr.tag ||
-				    sctp_mask->hdr.cksum) {
-					memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-					rte_flow_error_set(error, EINVAL,
-						RTE_FLOW_ERROR_TYPE_ITEM,
-						item, "Not supported by fdir filter");
-					return -rte_errno;
-				}
-				rule->mask.src_port_mask = sctp_mask->hdr.src_port;
-				rule->mask.dst_port_mask = sctp_mask->hdr.dst_port;
-
-				if (item->spec) {
-					rule->b_spec = TRUE;
-					sctp_spec = item->spec;
-					rule->ixgbe_fdir.formatted.src_port =
-						sctp_spec->hdr.src_port;
-					rule->ixgbe_fdir.formatted.dst_port =
-						sctp_spec->hdr.dst_port;
-				}
-			/* others even sctp port masking is not supported */
-			} else if (sctp_mask->hdr.src_port ||
-				   sctp_mask->hdr.dst_port ||
-				   sctp_mask->hdr.tag ||
-				   sctp_mask->hdr.cksum) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-		} else if (item->spec != NULL) {
-			/* No port mask means protocol-only match; spec is invalid. */
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		item = next_no_fuzzy_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_RAW &&
-			item->type != RTE_FLOW_ITEM_TYPE_END) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/* Get the flex byte info */
-	if (item->type == RTE_FLOW_ITEM_TYPE_RAW) {
-		/* Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-		/* mask should not be null */
-		if (!item->mask || !item->spec) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		raw_mask = item->mask;
-
-		/* check mask */
-		if (raw_mask->relative != 0x1 ||
-		    raw_mask->search != 0x1 ||
-		    raw_mask->reserved != 0x0 ||
-		    (uint32_t)raw_mask->offset != 0xffffffff ||
-		    raw_mask->limit != 0xffff ||
-		    raw_mask->length != 0xffff) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		raw_spec = item->spec;
-
-		/* check spec */
-		if (raw_spec->relative != 0 ||
-		    raw_spec->search != 0 ||
-		    raw_spec->reserved != 0 ||
-		    raw_spec->offset > IXGBE_MAX_FLX_SOURCE_OFF ||
-		    raw_spec->offset % 2 ||
-		    raw_spec->limit != 0 ||
-		    raw_spec->length != 2 ||
-		    /* pattern can't be 0xffff */
-		    (raw_spec->pattern[0] == 0xff &&
-		     raw_spec->pattern[1] == 0xff)) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		/* check pattern mask */
-		if (raw_mask->pattern[0] != 0xff ||
-		    raw_mask->pattern[1] != 0xff) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		rule->mask.flex_bytes_mask = 0xffff;
-		rule->ixgbe_fdir.formatted.flex_bytes =
-			(((uint16_t)raw_spec->pattern[1]) << 8) |
-			raw_spec->pattern[0];
-		rule->flex_bytes_offset = raw_spec->offset;
-	}
-
-	if (item->type != RTE_FLOW_ITEM_TYPE_END) {
-		/* check if the next not void item is END */
-		item = next_no_fuzzy_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_END) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/* L4 protocol matching is enabled when parser selected an L4 type. */
-	rule->mask.l4_proto_match =
-		(rule->ixgbe_fdir.formatted.flow_type & IXGBE_ATR_L4TYPE_MASK) != 0;
-
-	return 0;
-}
-
-#define NVGRE_PROTOCOL 0x6558
-
-/**
- * Parse the rule to see if it is a VxLAN or NVGRE flow director rule.
- * And get the flow director filter info BTW.
- * VxLAN PATTERN:
- * The first not void item must be ETH.
- * The second not void item must be IPV4/ IPV6.
- * The third not void item must be NVGRE.
- * The next not void item must be END.
- * NVGRE PATTERN:
- * The first not void item must be ETH.
- * The second not void item must be IPV4/ IPV6.
- * The third not void item must be NVGRE.
- * The next not void item must be END.
- * ACTION:
- * The first not void action should be QUEUE or DROP.
- * The second not void optional action should be MARK,
- * mark_id is a uint32_t number.
- * The next not void action should be END.
- * VxLAN pattern example:
- * ITEM		Spec			Mask
- * ETH		NULL			NULL
- * IPV4/IPV6	NULL			NULL
- * UDP		NULL			NULL
- * VxLAN	vni{0x00, 0x32, 0x54}	{0xFF, 0xFF, 0xFF}
- * MAC VLAN	tci	0x2016		0xEFFF
- * END
- * NEGRV pattern example:
- * ITEM		Spec			Mask
- * ETH		NULL			NULL
- * IPV4/IPV6	NULL			NULL
- * NVGRE	protocol	0x6558	0xFFFF
- *		tni{0x00, 0x32, 0x54}	{0xFF, 0xFF, 0xFF}
- * MAC VLAN	tci	0x2016		0xEFFF
- * END
- * other members in mask and spec should set to 0x00.
- * item->last should be NULL.
- */
-static int
-ixgbe_parse_fdir_filter_tunnel(const struct rte_flow_item pattern[],
-			       const struct ci_flow_actions *parsed_actions,
-			       struct ixgbe_fdir_rule *rule,
-			       struct rte_flow_error *error)
-{
-	const struct rte_flow_item *item;
-	const struct rte_flow_item_vxlan *vxlan_spec;
-	const struct rte_flow_item_vxlan *vxlan_mask;
-	const struct rte_flow_item_nvgre *nvgre_spec;
-	const struct rte_flow_item_nvgre *nvgre_mask;
-	const struct rte_flow_item_eth *eth_spec;
-	const struct rte_flow_item_eth *eth_mask;
-	const struct rte_flow_item_vlan *vlan_spec;
-	const struct rte_flow_item_vlan *vlan_mask;
-	const struct rte_flow_action *fwd_action, *aux_action;
-	uint32_t j;
-
-	fwd_action = parsed_actions->actions[0];
-	/* can be NULL */
-	aux_action = parsed_actions->actions[1];
-
-	/**
-	 * Some fields may not be provided. Set spec to 0 and mask to default
-	 * value. So, we need not do anything for the not provided fields later.
-	 */
-	memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-	memset(&rule->mask, 0xFF, sizeof(struct ixgbe_hw_fdir_mask));
-	rule->mask.vlan_tci_mask = 0;
-
-	/* set up queue/drop action */
-	if (fwd_action->type == RTE_FLOW_ACTION_TYPE_QUEUE) {
-		const struct rte_flow_action_queue *q_act = fwd_action->conf;
-		rule->queue = q_act->index;
-	} else {
-		rule->fdirflags = IXGBE_FDIRCMD_DROP;
-	}
-
-	/* set up mark action */
-	if (aux_action != NULL && aux_action->type == RTE_FLOW_ACTION_TYPE_MARK) {
-		const struct rte_flow_action_mark *mark = aux_action->conf;
-		rule->soft_id = mark->id;
-	}
-
-	/**
-	 * The first not void item should be
-	 * MAC or IPv4 or IPv6 or UDP or VxLAN.
-	 */
-	item = next_no_void_pattern(pattern, NULL);
-	if (item->type != RTE_FLOW_ITEM_TYPE_ETH &&
-	    item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
-	    item->type != RTE_FLOW_ITEM_TYPE_IPV6 &&
-	    item->type != RTE_FLOW_ITEM_TYPE_UDP &&
-	    item->type != RTE_FLOW_ITEM_TYPE_VXLAN &&
-	    item->type != RTE_FLOW_ITEM_TYPE_NVGRE) {
-		memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by fdir filter");
-		return -rte_errno;
-	}
-
-	rule->mode = RTE_FDIR_MODE_PERFECT_TUNNEL;
-
-	/* Skip MAC. */
-	if (item->type == RTE_FLOW_ITEM_TYPE_ETH) {
-		/* Only used to describe the protocol stack. */
-		if (item->spec || item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		/* Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-
-		/* Check if the next not void item is IPv4 or IPv6. */
-		item = next_no_void_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
-		    item->type != RTE_FLOW_ITEM_TYPE_IPV6) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/* Skip IP. */
-	if (item->type == RTE_FLOW_ITEM_TYPE_IPV4 ||
-	    item->type == RTE_FLOW_ITEM_TYPE_IPV6) {
-		/* Only used to describe the protocol stack. */
-		if (item->spec || item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
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
-		/* Check if the next not void item is UDP or NVGRE. */
-		item = next_no_void_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_UDP &&
-		    item->type != RTE_FLOW_ITEM_TYPE_NVGRE) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/* Skip UDP. */
-	if (item->type == RTE_FLOW_ITEM_TYPE_UDP) {
-		/* Only used to describe the protocol stack. */
-		if (item->spec || item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
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
-		/* Check if the next not void item is VxLAN. */
-		item = next_no_void_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_VXLAN) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/* Get the VxLAN info */
-	if (item->type == RTE_FLOW_ITEM_TYPE_VXLAN) {
-		rule->ixgbe_fdir.formatted.tunnel_type =
-				IXGBE_FDIR_VXLAN_TUNNEL_TYPE;
-
-		/* Only care about VNI, others should be masked. */
-		if (!item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-		rule->b_mask = TRUE;
-
-		/* Tunnel type is always meaningful. */
-		rule->mask.tunnel_type_mask = 1;
-
-		vxlan_mask = item->mask;
-		if (vxlan_mask->hdr.flags) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		/* VNI must be totally masked or not. */
-		if ((vxlan_mask->hdr.vni[0] || vxlan_mask->hdr.vni[1] ||
-			vxlan_mask->hdr.vni[2]) &&
-			((vxlan_mask->hdr.vni[0] != 0xFF) ||
-			(vxlan_mask->hdr.vni[1] != 0xFF) ||
-				(vxlan_mask->hdr.vni[2] != 0xFF))) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		memcpy(&rule->mask.tunnel_id_mask, vxlan_mask->hdr.vni,
-			RTE_DIM(vxlan_mask->hdr.vni));
-
-		if (item->spec) {
-			rule->b_spec = TRUE;
-			vxlan_spec = item->spec;
-			memcpy(((uint8_t *)
-				&rule->ixgbe_fdir.formatted.tni_vni),
-				vxlan_spec->hdr.vni, RTE_DIM(vxlan_spec->hdr.vni));
-		}
-	}
-
-	/* Get the NVGRE info */
-	if (item->type == RTE_FLOW_ITEM_TYPE_NVGRE) {
-		rule->ixgbe_fdir.formatted.tunnel_type =
-				IXGBE_FDIR_NVGRE_TUNNEL_TYPE;
-
-		/**
-		 * Only care about flags0, flags1, protocol and TNI,
-		 * others should be masked.
-		 */
-		if (!item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-		rule->b_mask = TRUE;
-
-		/* Tunnel type is always meaningful. */
-		rule->mask.tunnel_type_mask = 1;
-
-		nvgre_mask = item->mask;
-		if (nvgre_mask->flow_id) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		if (nvgre_mask->protocol &&
-		    nvgre_mask->protocol != 0xFFFF) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		if (nvgre_mask->c_k_s_rsvd0_ver &&
-		    nvgre_mask->c_k_s_rsvd0_ver !=
-			rte_cpu_to_be_16(0xFFFF)) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		/* TNI must be totally masked or not. */
-		if (nvgre_mask->tni[0] &&
-		    ((nvgre_mask->tni[0] != 0xFF) ||
-		    (nvgre_mask->tni[1] != 0xFF) ||
-		    (nvgre_mask->tni[2] != 0xFF))) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		/* tni is a 24-bits bit field */
-		memcpy(&rule->mask.tunnel_id_mask, nvgre_mask->tni,
-			RTE_DIM(nvgre_mask->tni));
-		rule->mask.tunnel_id_mask <<= 8;
-
-		if (item->spec) {
-			rule->b_spec = TRUE;
-			nvgre_spec = item->spec;
-			if (nvgre_spec->c_k_s_rsvd0_ver !=
-			    rte_cpu_to_be_16(0x2000) &&
-				nvgre_mask->c_k_s_rsvd0_ver) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-			if (nvgre_mask->protocol &&
-			    nvgre_spec->protocol !=
-			    rte_cpu_to_be_16(NVGRE_PROTOCOL)) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-			/* tni is a 24-bits bit field */
-			memcpy(&rule->ixgbe_fdir.formatted.tni_vni,
-			nvgre_spec->tni, RTE_DIM(nvgre_spec->tni));
-		}
-	}
-
-	/* check if the next not void item is MAC */
-	item = next_no_void_pattern(pattern, item);
-	if (item->type != RTE_FLOW_ITEM_TYPE_ETH) {
-		memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by fdir filter");
-		return -rte_errno;
-	}
-
-	/**
-	 * Only support vlan and dst MAC address,
-	 * others should be masked.
-	 */
-
-	if (!item->mask) {
-		memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by fdir filter");
-		return -rte_errno;
-	}
-	/*Not supported last point for range*/
-	if (item->last) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			item, "Not supported last point for range");
-		return -rte_errno;
-	}
-	rule->b_mask = TRUE;
-	eth_mask = item->mask;
-
-	/* Ether type should be masked. */
-	if (eth_mask->hdr.ether_type) {
-		memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by fdir filter");
-		return -rte_errno;
-	}
-
-	/* src MAC address should be masked. */
-	for (j = 0; j < RTE_ETHER_ADDR_LEN; j++) {
-		if (eth_mask->hdr.src_addr.addr_bytes[j]) {
-			memset(rule, 0,
-			       sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-	rule->mask.mac_addr_byte_mask = 0;
-	for (j = 0; j < RTE_ETHER_ADDR_LEN; j++) {
-		/* It's a per byte mask. */
-		if (eth_mask->hdr.dst_addr.addr_bytes[j] == 0xFF) {
-			rule->mask.mac_addr_byte_mask |= 0x1 << j;
-		} else if (eth_mask->hdr.dst_addr.addr_bytes[j]) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/* When no vlan, considered as full mask. */
-	rule->mask.vlan_tci_mask = rte_cpu_to_be_16(0xEFFF);
-
-	if (item->spec) {
-		rule->b_spec = TRUE;
-		eth_spec = item->spec;
-
-		/* Get the dst MAC. */
-		for (j = 0; j < RTE_ETHER_ADDR_LEN; j++) {
-			rule->ixgbe_fdir.formatted.inner_mac[j] =
-				eth_spec->hdr.dst_addr.addr_bytes[j];
-		}
-	}
-
-	/**
-	 * Check if the next not void item is vlan or ipv4.
-	 * IPv6 is not supported.
-	 */
-	item = next_no_void_pattern(pattern, item);
-	if ((item->type != RTE_FLOW_ITEM_TYPE_VLAN) &&
-		(item->type != RTE_FLOW_ITEM_TYPE_IPV4)) {
-		memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by fdir filter");
-		return -rte_errno;
-	}
-	/*Not supported last point for range*/
-	if (item->last) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			item, "Not supported last point for range");
-		return -rte_errno;
-	}
-
-	if (item->type == RTE_FLOW_ITEM_TYPE_VLAN) {
-		if (!(item->spec && item->mask)) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		vlan_spec = item->spec;
-		vlan_mask = item->mask;
-
-		rule->ixgbe_fdir.formatted.vlan_id = vlan_spec->hdr.vlan_tci;
-
-		rule->mask.vlan_tci_mask = vlan_mask->hdr.vlan_tci;
-		rule->mask.vlan_tci_mask &= rte_cpu_to_be_16(0xEFFF);
-		/* More than one tags are not supported. */
-
-		/* check if the next not void item is END */
-		item = next_no_void_pattern(pattern, item);
-
-		if (item->type != RTE_FLOW_ITEM_TYPE_END) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/**
-	 * If the tags is 0, it means don't care about the VLAN.
-	 * Do nothing.
-	 */
-
-	return 0;
-}
-
-/*
- * Check flow director actions
- */
-static int
-ixgbe_fdir_actions_check(const struct ci_flow_actions *parsed_actions,
-	const struct ci_flow_actions_check_param *param __rte_unused,
-	struct rte_flow_error *error)
-{
-	const enum rte_flow_action_type fwd_actions[] = {
-		RTE_FLOW_ACTION_TYPE_QUEUE,
-		RTE_FLOW_ACTION_TYPE_DROP,
-		RTE_FLOW_ACTION_TYPE_END
-	};
-	const struct rte_flow_action *action;
-
-	/* do the generic checks first */
-	int ret = ixgbe_flow_actions_check(parsed_actions, param, error);
-	if (ret)
-		return ret;
-
-	/* first action must be a forwarding action */
-	action = parsed_actions->actions[0];
-	if (!ci_flow_action_type_in_list(action->type, fwd_actions)) {
-		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
-					  action, "First action must be QUEUE or DROP");
-	}
-
-	/* second action, if specified, must not be a forwarding action */
-	action = parsed_actions->actions[1];
-	if (action != NULL && ci_flow_action_type_in_list(action->type, fwd_actions)) {
-		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
-					  action, "Conflicting actions");
-	}
-	return 0;
-}
-
-static int
-ixgbe_parse_fdir_filter(struct rte_eth_dev *dev,
-		const struct rte_flow_attr *attr,
-		const struct rte_flow_item pattern[],
-		const struct rte_flow_action actions[],
-		struct ixgbe_fdir_rule *rule,
-		struct rte_flow_error *error)
-{
-	int ret;
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_PRIVATE_TO_FDIR_CONF(adapter);
-	struct ci_flow_actions parsed_actions;
-	struct ci_flow_actions_check_param ap_param = {
-		.allowed_types = (const enum rte_flow_action_type[]){
-			/* queue/mark/drop allowed here */
-			RTE_FLOW_ACTION_TYPE_QUEUE,
-			RTE_FLOW_ACTION_TYPE_DROP,
-			RTE_FLOW_ACTION_TYPE_MARK,
-			RTE_FLOW_ACTION_TYPE_END
-		},
-		.driver_ctx = dev->data,
-		.check = ixgbe_fdir_actions_check
-	};
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
-	fdir_conf->drop_queue = IXGBE_FDIR_DROP_QUEUE;
-
-	ret = ixgbe_parse_fdir_filter_normal(dev, pattern, &parsed_actions, rule, error);
-	if (!ret)
-		return 0;
-
-	return ixgbe_parse_fdir_filter_tunnel(pattern, &parsed_actions,
-		rule, error);
-}
-
-static int
-ixgbe_fdir_process_rule(struct ixgbe_adapter *adapter,
-		struct ixgbe_hw_fdir_info *fdir_info,
-		struct ixgbe_fdir_rule *fdir_rule,
-		bool *first_mask,
-		struct rte_flow_error *error)
-{
-	bool flex_byte_offset_changed;
-	int ret;
-
-	/* rule must have a spec to be valid */
-	if (!fdir_rule->b_spec)
-		return rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			NULL, "No filter spec");
-
-	/* if rule doesn't have a mask, nothing to be done */
-	if (!fdir_rule->b_mask)
-		return 0;
-
-	/* if we already have a mask, check if it's compatible */
-	if (fdir_info->mask_added) {
-		ret = memcmp(&fdir_info->mask, &fdir_rule->mask,
-				sizeof(struct ixgbe_hw_fdir_mask));
-		if (ret)
-			return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				NULL, "Mask mismatch");
-
-		if (fdir_rule->mask.flex_bytes_mask &&
-		    fdir_info->flex_bytes_offset !=
-		    fdir_rule->flex_bytes_offset)
-			return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				NULL, "Flex bytes offset mismatch");
-
-		/* success */
-		return 0;
-	}
-
-	/* we don't have a mask yet, so set it up based on this rule */
-	flex_byte_offset_changed =
-			fdir_info->flex_bytes_offset !=
-			fdir_rule->flex_bytes_offset;
-
-	if (fdir_rule->mask.flex_bytes_mask != 0 && flex_byte_offset_changed) {
-		ret = ixgbe_fdir_set_flexbytes_offset(adapter,
-				fdir_rule->flex_bytes_offset);
-		if (ret)
-			return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				NULL,
-				"Failed to set flex bytes offset");
-	}
-
-	ret = ixgbe_fdir_set_input_mask(adapter, &fdir_rule->mask,
-			fdir_rule->mode);
-	if (ret)
-		return rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			NULL, "Failed to set fdir mask");
-
-	/* let the caller know that we've installed a mask */
-	*first_mask = true;
-
-	return 0;
-}
-
-static int
-ixgbe_fdir_flow_program(struct rte_eth_dev *dev,
-		struct ixgbe_adapter *adapter,
-		struct ixgbe_fdir_rule *fdir_rule,
-		bool *first_mask,
-		struct rte_flow_error *error)
-{
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
-	struct rte_eth_fdir_conf local_fdir_conf = *fdir_conf;
-	struct ixgbe_hw_fdir_info *fdir_info =
-			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
-	int ret;
-
-	if (fdir_rule->queue >= dev->data->nb_rx_queues) {
-		return rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ACTION,
-			NULL, "queue id > max number of queues");
-	}
-
-	local_fdir_conf.mode = fdir_rule->mode;
-
-	/* Configure FDIR mode if this is the first filter */
-	if (fdir_conf->mode == RTE_FDIR_MODE_NONE) {
-		ret = ixgbe_fdir_configure(adapter, &local_fdir_conf, &fdir_rule->mask);
-		if (ret) {
-			return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				NULL, "Failed to configure fdir mode");
-		}
-	} else if (fdir_conf->mode != fdir_rule->mode) {
-		return rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			NULL, "Conflict with existing fdir mode");
-	}
-
-	/* Process and validate rule spec and mask */
-	ret = ixgbe_fdir_process_rule(adapter, fdir_info, fdir_rule,
-		first_mask, error);
-	if (ret)
-		return ret;
-
-	/* Program the filter */
-	ret = ixgbe_fdir_filter_program(adapter, &local_fdir_conf,
-			fdir_rule, FALSE, FALSE);
-	if (ret)
-		return rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			NULL, "Failed to add fdir filter");
-
-	return 0;
-}
-
 /* Flow actions check specific to RSS filter */
 static int
 ixgbe_flow_actions_check_rss(const struct ci_flow_actions *parsed_actions,
@@ -1784,14 +274,9 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 		  struct rte_flow_error *error)
 {
 	int ret;
-	struct ixgbe_adapter *adapter =
-		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct ixgbe_fdir_rule fdir_rule;
-	struct ixgbe_hw_fdir_info *fdir_info =
-		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct ixgbe_rte_flow_rss_conf rss_conf;
 	struct rte_flow *flow = NULL;
-	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
 	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
 
@@ -1818,39 +303,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	TAILQ_INSERT_TAIL(&adapter->flow_list,
 				&ixgbe_flow_mem_ptr->base, entries);
 
-	memset(&fdir_rule, 0, sizeof(struct ixgbe_fdir_rule));
-	ret = ixgbe_parse_fdir_filter(dev, attr, pattern,
-				actions, &fdir_rule, error);
-	if (!ret) {
-		struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
-		bool first_mask = false;
-
-		ret = ixgbe_fdir_flow_program(dev, adapter, &fdir_rule,
-			&first_mask, error);
-		if (ret)
-			goto out;
-
-		fdir_rule_ptr = rte_zmalloc("ixgbe_fdir_filter",
-				sizeof(struct ixgbe_fdir_rule_ele), 0);
-		if (!fdir_rule_ptr) {
-			PMD_DRV_LOG(ERR, "failed to allocate memory");
-			goto out;
-		}
-		/* update global state */
-		if (first_mask) {
-			fdir_info->mask_added = TRUE;
-			fdir_info->mask = fdir_rule.mask;
-			fdir_info->flex_bytes_offset = fdir_rule.flex_bytes_offset;
-		}
-		fdir_info->n_flows++;
-		fdir_conf->mode = fdir_rule.mode;
-
-		fdir_rule_ptr->filter_info = fdir_rule;
-		flow->rule = fdir_rule_ptr;
-		flow->filter_type = RTE_ETH_FILTER_FDIR;
-		return flow;
-	}
-
 	memset(&rss_conf, 0, sizeof(struct ixgbe_rte_flow_rss_conf));
 	ret = ixgbe_parse_rss_filter(dev, attr,
 					actions, &rss_conf, error);
@@ -1895,7 +347,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 		struct rte_flow_error *error)
 {
 	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct ixgbe_fdir_rule fdir_rule;
 	struct ixgbe_rte_flow_rss_conf rss_conf;
 	int ret;
 
@@ -1906,12 +357,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 
 	/* fall back to legacy engines */
 
-	memset(&fdir_rule, 0, sizeof(struct ixgbe_fdir_rule));
-	ret = ixgbe_parse_fdir_filter(dev, attr, pattern,
-				actions, &fdir_rule, error);
-	if (!ret)
-		return 0;
-
 	memset(&rss_conf, 0, sizeof(struct ixgbe_rte_flow_rss_conf));
 	ret = ixgbe_parse_rss_filter(dev, attr,
 					actions, &rss_conf, error);
@@ -1930,12 +375,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct rte_flow *pmd_flow = flow;
 	enum rte_filter_type filter_type = pmd_flow->filter_type;
-	struct ixgbe_fdir_rule fdir_rule;
-	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_filter_ele_base *flow_mem_base;
-	struct ixgbe_hw_fdir_info *fdir_info =
-		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
 
 	/* try the new flow engine first */
@@ -1960,20 +400,6 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	}
 
 	switch (filter_type) {
-	case RTE_ETH_FILTER_FDIR:
-		fdir_rule_ptr = (struct ixgbe_fdir_rule_ele *)pmd_flow->rule;
-		fdir_rule = fdir_rule_ptr->filter_info;
-		ret = ixgbe_fdir_filter_program(adapter, fdir_conf, &fdir_rule, TRUE, FALSE);
-		if (!ret) {
-			rte_free(fdir_rule_ptr);
-			if (fdir_info->n_flows > 0 && --(fdir_info->n_flows) == 0) {
-				fdir_info->mask_added = false;
-				fdir_info->mask = (struct ixgbe_hw_fdir_mask){0};
-				fdir_info->flex_bytes_offset = 0;
-				fdir_conf->mode = RTE_FDIR_MODE_NONE;
-			}
-		}
-		break;
 	case RTE_ETH_FILTER_HASH:
 		rss_filter_ptr = (struct ixgbe_rss_conf_ele *)
 				pmd_flow->rule;
@@ -2018,13 +444,6 @@ ixgbe_flow_flush(struct rte_eth_dev *dev,
 		return ret;
 	}
 
-	ret = ixgbe_clear_all_fdir_filter(dev);
-	if (ret < 0) {
-		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_HANDLE,
-					NULL, "Failed to flush rule");
-		return ret;
-	}
-
 	ixgbe_clear_rss_filter(dev);
 
 	ixgbe_filterlist_flush(dev);
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.h b/drivers/net/intel/ixgbe/ixgbe_flow.h
index 87cf028245..256e0478f5 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.h
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.h
@@ -20,5 +20,7 @@ extern const struct ci_flow_engine ixgbe_syn_flow_engine;
 extern const struct ci_flow_engine ixgbe_l2_tunnel_flow_engine;
 extern const struct ci_flow_engine ixgbe_ntuple_flow_engine;
 extern const struct ci_flow_engine ixgbe_security_flow_engine;
+extern const struct ci_flow_engine ixgbe_fdir_flow_engine;
+extern const struct ci_flow_engine ixgbe_fdir_tunnel_flow_engine;
 
 #endif /*  _IXGBE_FLOW_H_ */
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow_fdir.c b/drivers/net/intel/ixgbe/ixgbe_flow_fdir.c
new file mode 100644
index 0000000000..90e3cf69ef
--- /dev/null
+++ b/drivers/net/intel/ixgbe/ixgbe_flow_fdir.c
@@ -0,0 +1,1703 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include <rte_common.h>
+#include <rte_flow.h>
+#include <flow_graph.h>
+#include <rte_ether.h>
+#include <rte_hash.h>
+
+#include "ixgbe_ethdev.h"
+#include "ixgbe_flow.h"
+#include "../common/flow_check.h"
+#include "../common/flow_util.h"
+#include "../common/flow_engine.h"
+
+struct ixgbe_fdir_flow {
+	struct rte_flow flow;
+	struct ixgbe_fdir_rule rule;
+	/* resolved at ctx_to_flow time, written to hardware at install time */
+	uint32_t fdirhash;
+	uint32_t fdircmd_flags;
+	uint8_t queue;
+};
+
+/* both fdir engines get their own priv, all pointing at the same shared state */
+struct ixgbe_fdir_priv {
+	struct ixgbe_fdir_state *state;
+};
+
+struct ixgbe_fdir_ctx {
+	struct ci_flow_engine_ctx base;
+	struct ixgbe_fdir_rule rule;
+	bool supports_sctp_ports;
+	const struct rte_flow_action *fwd_action;
+	const struct rte_flow_action *aux_action;
+};
+
+#define IXGBE_FDIR_VLAN_TCI_MASK	rte_cpu_to_be_16(0xEFFF)
+#define NVGRE_FLAGS 0x2000
+#define NVGRE_PROTOCOL 0x6558
+
+/**
+ * FDIR normal graph implementation
+ * Pattern: START -> [ETH] -> (IPv4|IPv6) -> [TCP|UDP|SCTP] -> [RAW] -> END
+ * Pattern: START -> ETH -> VLAN -> END
+ */
+
+enum ixgbe_fdir_normal_node_id {
+	IXGBE_FDIR_NORMAL_NODE_START = FLOW_GRAPH_NODE_FIRST,
+	IXGBE_FDIR_NORMAL_NODE_ETH,
+	IXGBE_FDIR_NORMAL_NODE_VLAN,
+	IXGBE_FDIR_NORMAL_NODE_IPV4,
+	IXGBE_FDIR_NORMAL_NODE_IPV6,
+	IXGBE_FDIR_NORMAL_NODE_TCP,
+	IXGBE_FDIR_NORMAL_NODE_UDP,
+	IXGBE_FDIR_NORMAL_NODE_SCTP,
+	IXGBE_FDIR_NORMAL_NODE_RAW,
+	IXGBE_FDIR_NORMAL_NODE_END,
+	IXGBE_FDIR_NORMAL_NODE_MAX,
+};
+
+static int
+ixgbe_validate_fdir_normal_eth(const void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct ixgbe_fdir_ctx *fdir_ctx = (const struct ixgbe_fdir_ctx *)ctx;
+	const struct rte_flow_item_eth *eth_mask = item->mask;
+
+	if (item->spec == NULL && item->mask == NULL)
+		return 0;
+
+	/* we cannot have ETH item in signature mode */
+	if (fdir_ctx->rule.mode == RTE_FDIR_MODE_SIGNATURE) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"ETH item not supported in signature mode");
+	}
+	/* ethertype isn't supported by FDIR */
+	if (!CI_FIELD_IS_ZERO(&eth_mask->hdr.ether_type)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Ethertype filtering not supported");
+	}
+	/* source address mask must be all zeroes */
+	if (!CI_FIELD_IS_ZERO(&eth_mask->hdr.src_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Source MAC filtering not supported");
+	}
+	/* destination address mask must be all ones */
+	if (!CI_FIELD_IS_MASKED(&eth_mask->hdr.dst_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Destination MAC filtering must be exact match");
+	}
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_normal_eth(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+	const struct rte_flow_item_eth *eth_spec = item->spec;
+	const struct rte_flow_item_eth *eth_mask = item->mask;
+
+
+	if (eth_spec == NULL && eth_mask == NULL)
+		return 0;
+
+	/* copy dst MAC */
+	rule->b_spec = TRUE;
+	memcpy(rule->ixgbe_fdir.formatted.inner_mac, eth_spec->hdr.dst_addr.addr_bytes,
+			RTE_ETHER_ADDR_LEN);
+
+	/* set tunnel type */
+	rule->mode = RTE_FDIR_MODE_PERFECT_MAC_VLAN;
+	/* when no VLAN specified, set full mask */
+	rule->b_mask = TRUE;
+	rule->mask.vlan_tci_mask = IXGBE_FDIR_VLAN_TCI_MASK;
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_normal_vlan(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct rte_flow_item_vlan *vlan_spec = item->spec;
+	const struct rte_flow_item_vlan *vlan_mask = item->mask;
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	rule->ixgbe_fdir.formatted.vlan_id = vlan_spec->hdr.vlan_tci;
+
+	rule->mask.vlan_tci_mask = vlan_mask->hdr.vlan_tci;
+	rule->mask.vlan_tci_mask &= IXGBE_FDIR_VLAN_TCI_MASK;
+
+	return 0;
+}
+
+static int
+ixgbe_validate_fdir_normal_ipv4(const void *ctx,
+			    const struct rte_flow_item *item,
+			    struct rte_flow_error *error)
+{
+	const struct rte_flow_item_ipv4 *ipv4_mask = item->mask;
+	const struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	if (rule->mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"IPv4 not supported with ETH/VLAN items");
+	}
+
+	if (ipv4_mask->hdr.version_ihl ||
+	    ipv4_mask->hdr.type_of_service ||
+	    ipv4_mask->hdr.total_length ||
+	    ipv4_mask->hdr.packet_id ||
+	    ipv4_mask->hdr.fragment_offset ||
+	    ipv4_mask->hdr.time_to_live ||
+	    ipv4_mask->hdr.next_proto_id ||
+	    ipv4_mask->hdr.hdr_checksum) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Only src/dst addresses supported");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_normal_ipv4(void *ctx,
+			   const struct rte_flow_item *item,
+			   struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_ipv4 *ipv4_spec = item->spec;
+	const struct rte_flow_item_ipv4 *ipv4_mask = item->mask;
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	rule->ixgbe_fdir.formatted.flow_type = IXGBE_ATR_FLOW_TYPE_IPV4;
+
+	/* spec may not be present */
+	if (ipv4_spec) {
+		rule->b_spec = TRUE;
+		rule->ixgbe_fdir.formatted.dst_ip[0] = ipv4_spec->hdr.dst_addr;
+		rule->ixgbe_fdir.formatted.src_ip[0] = ipv4_spec->hdr.src_addr;
+	}
+
+	rule->b_mask = TRUE;
+	rule->mask.dst_ipv4_mask = ipv4_mask->hdr.dst_addr;
+	rule->mask.src_ipv4_mask = ipv4_mask->hdr.src_addr;
+
+	return 0;
+}
+
+static int
+ixgbe_validate_fdir_normal_ipv6(const void *ctx,
+			    const struct rte_flow_item *item,
+			    struct rte_flow_error *error)
+{
+	const struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_ipv6 *ipv6_mask = item->mask;
+	const struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	if (rule->mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"IPv6 not supported with ETH/VLAN items");
+	}
+
+	if (rule->mode != RTE_FDIR_MODE_SIGNATURE) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"IPv6 only supported in signature mode");
+	}
+
+	ipv6_mask = item->mask;
+
+	if (ipv6_mask->hdr.vtc_flow ||
+	    ipv6_mask->hdr.payload_len ||
+	    ipv6_mask->hdr.proto ||
+	    ipv6_mask->hdr.hop_limits) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Only src/dst addresses supported");
+	}
+
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&ipv6_mask->hdr.src_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Partial src address masks not supported");
+	}
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&ipv6_mask->hdr.dst_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Partial dst address masks not supported");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_normal_ipv6(void *ctx,
+			   const struct rte_flow_item *item,
+			   struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_ipv6 *ipv6_spec = item->spec;
+	const struct rte_flow_item_ipv6 *ipv6_mask = item->mask;
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+	uint8_t j;
+
+	rule->ixgbe_fdir.formatted.flow_type = IXGBE_ATR_FLOW_TYPE_IPV6;
+
+	/* spec may not be present */
+	if (ipv6_spec) {
+		rule->b_spec = TRUE;
+		memcpy(rule->ixgbe_fdir.formatted.src_ip, &ipv6_spec->hdr.src_addr,
+				sizeof(struct rte_ipv6_addr));
+		memcpy(rule->ixgbe_fdir.formatted.dst_ip, &ipv6_spec->hdr.dst_addr,
+				sizeof(struct rte_ipv6_addr));
+	}
+
+	rule->b_mask = TRUE;
+	for (j = 0; j < sizeof(struct rte_ipv6_addr); j++) {
+		if (ipv6_mask->hdr.src_addr.a[j] == 0)
+			rule->mask.src_ipv6_mask &= ~(1 << j);
+		if (ipv6_mask->hdr.dst_addr.a[j] == 0)
+			rule->mask.dst_ipv6_mask &= ~(1 << j);
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_validate_fdir_normal_tcp(const void *ctx,
+			   const struct rte_flow_item *item,
+			   struct rte_flow_error *error)
+{
+	const struct rte_flow_item_tcp *tcp_mask = item->mask;
+	const struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	if (rule->mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"TCP not supported with ETH/VLAN items");
+	}
+
+	if (tcp_mask == NULL)
+		return 0;
+
+	if (tcp_mask->hdr.sent_seq ||
+	    tcp_mask->hdr.recv_ack ||
+	    tcp_mask->hdr.data_off ||
+	    tcp_mask->hdr.tcp_flags ||
+	    tcp_mask->hdr.rx_win ||
+	    tcp_mask->hdr.cksum ||
+	    tcp_mask->hdr.tcp_urp) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Only src/dst ports supported");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_normal_tcp(void *ctx,
+			  const struct rte_flow_item *item,
+			  struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_tcp *tcp_spec = item->spec;
+	const struct rte_flow_item_tcp *tcp_mask = item->mask;
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	rule->ixgbe_fdir.formatted.flow_type |= IXGBE_ATR_L4TYPE_TCP;
+
+	if (tcp_mask != NULL) {
+		rule->b_mask = TRUE;
+		rule->mask.src_port_mask = tcp_mask->hdr.src_port;
+		rule->mask.dst_port_mask = tcp_mask->hdr.dst_port;
+	}
+
+	if (tcp_spec != NULL) {
+		rule->b_spec = TRUE;
+		rule->ixgbe_fdir.formatted.src_port = tcp_spec->hdr.src_port;
+		rule->ixgbe_fdir.formatted.dst_port = tcp_spec->hdr.dst_port;
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_validate_fdir_normal_udp(const void *ctx,
+			   const struct rte_flow_item *item,
+			   struct rte_flow_error *error)
+{
+	const struct rte_flow_item_udp *udp_mask = item->mask;
+	const struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	if (rule->mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"UDP not supported with ETH/VLAN items");
+	}
+
+	if (udp_mask == NULL)
+		return 0;
+
+	if (udp_mask->hdr.dgram_len ||
+	    udp_mask->hdr.dgram_cksum) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Only src/dst ports supported");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_normal_udp(void *ctx,
+			  const struct rte_flow_item *item,
+			  struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_udp *udp_spec = item->spec;
+	const struct rte_flow_item_udp *udp_mask = item->mask;
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	rule->ixgbe_fdir.formatted.flow_type |= IXGBE_ATR_L4TYPE_UDP;
+
+	if (udp_mask != NULL) {
+		rule->b_mask = TRUE;
+		rule->mask.src_port_mask = udp_mask->hdr.src_port;
+		rule->mask.dst_port_mask = udp_mask->hdr.dst_port;
+	}
+
+	if (udp_spec != NULL) {
+		rule->b_spec = TRUE;
+		rule->ixgbe_fdir.formatted.src_port = udp_spec->hdr.src_port;
+		rule->ixgbe_fdir.formatted.dst_port = udp_spec->hdr.dst_port;
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_validate_fdir_normal_sctp(const void *ctx,
+			    const struct rte_flow_item *item,
+			    struct rte_flow_error *error)
+{
+	const struct rte_flow_item_sctp *sctp_mask = item->mask;
+	const struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	if (rule->mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"SCTP not supported with ETH/VLAN items");
+	}
+
+	if (sctp_mask == NULL)
+		return 0;
+
+
+	/* Tag and checksum not supported */
+	if (sctp_mask->hdr.tag ||
+	    sctp_mask->hdr.cksum) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"SCTP tag/cksum not supported");
+	}
+
+	/*
+	 * SCTP mask is not NULL, which means we are potentially looking at
+	 * masking SCTP ports, so check hardware support.
+	 */
+	if (!fdir_ctx->supports_sctp_ports) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"SCTP port filtering not supported by hardware");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_normal_sctp(void *ctx,
+			   const struct rte_flow_item *item,
+			   struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_sctp *sctp_spec = item->spec;
+	const struct rte_flow_item_sctp *sctp_mask = item->mask;
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	rule->ixgbe_fdir.formatted.flow_type |= IXGBE_ATR_L4TYPE_SCTP;
+
+	if (sctp_mask != NULL) {
+		rule->b_mask = TRUE;
+		rule->mask.src_port_mask = sctp_mask->hdr.src_port;
+		rule->mask.dst_port_mask = sctp_mask->hdr.dst_port;
+	}
+
+	if (sctp_spec != NULL) {
+		rule->b_spec = TRUE;
+		rule->ixgbe_fdir.formatted.src_port = sctp_spec->hdr.src_port;
+		rule->ixgbe_fdir.formatted.dst_port = sctp_spec->hdr.dst_port;
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_validate_fdir_normal_raw(const void *ctx __rte_unused,
+			   const struct rte_flow_item *item,
+			   struct rte_flow_error *error)
+{
+	const struct rte_flow_item_raw *raw_spec;
+	const struct rte_flow_item_raw *raw_mask;
+
+	raw_spec = item->spec;
+	raw_mask = item->mask;
+
+	if (raw_spec->pattern == NULL) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid RAW spec");
+	}
+
+	if (raw_mask->pattern == NULL) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid RAW mask");
+	}
+
+	if (raw_mask->length != raw_spec->length &&
+			raw_mask->length != 0xffff) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid RAW mask");
+	}
+
+	if (raw_mask->relative != 0x1 ||
+	    raw_mask->search != 0x1 ||
+	    raw_mask->reserved != 0x0 ||
+	    (uint32_t)raw_mask->offset != 0xffffffff ||
+	    raw_mask->limit != 0xffff) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid RAW mask");
+	}
+
+	if (raw_spec->relative != 0 ||
+	    raw_spec->search != 0 ||
+	    raw_spec->reserved != 0 ||
+	    raw_spec->offset > IXGBE_MAX_FLX_SOURCE_OFF ||
+	    raw_spec->offset % 2 ||
+	    raw_spec->limit != 0 ||
+	    raw_spec->length != 2 ||
+	    (raw_spec->pattern[0] == 0xff &&
+	     raw_spec->pattern[1] == 0xff)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid RAW spec");
+	}
+
+	if (raw_mask->pattern[0] != 0xff ||
+	    raw_mask->pattern[1] != 0xff) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"RAW pattern must be fully masked");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_normal_raw(void *ctx,
+			  const struct rte_flow_item *item,
+			  struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_raw *raw_spec = item->spec;
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	rule->b_spec = TRUE;
+	rule->ixgbe_fdir.formatted.flex_bytes =
+		(((uint16_t)raw_spec->pattern[1]) << 8) | raw_spec->pattern[0];
+	rule->flex_bytes_offset = raw_spec->offset;
+
+	rule->b_mask = TRUE;
+	rule->mask.flex_bytes_mask = 0xffff;
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_normal_end(void *ctx, const struct rte_flow_item *item __rte_unused,
+			  struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+
+	/* check if we need L4 protocol */
+	if (fdir_ctx->rule.ixgbe_fdir.formatted.flow_type & IXGBE_ATR_L4TYPE_MASK)
+		fdir_ctx->rule.mask.l4_proto_match = 1;
+
+	return 0;
+}
+
+static const struct flow_graph ixgbe_fdir_normal_graph = {
+	.ignore_nodes = (enum rte_flow_item_type[]) {
+		RTE_FLOW_ITEM_TYPE_FUZZY,
+		RTE_FLOW_ITEM_TYPE_END,
+	},
+	.nodes = (struct flow_graph_node[]) {
+		[IXGBE_FDIR_NORMAL_NODE_START] = {
+			.name = "START",
+		},
+		[IXGBE_FDIR_NORMAL_NODE_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.validate = ixgbe_validate_fdir_normal_eth,
+			.process = ixgbe_process_fdir_normal_eth,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+			               FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+		},
+		[IXGBE_FDIR_NORMAL_NODE_VLAN] = {
+			.name = "VLAN",
+			.type = RTE_FLOW_ITEM_TYPE_VLAN,
+			.process = ixgbe_process_fdir_normal_vlan,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+		},
+		[IXGBE_FDIR_NORMAL_NODE_IPV4] = {
+			.name = "IPV4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.validate = ixgbe_validate_fdir_normal_ipv4,
+			.process = ixgbe_process_fdir_normal_ipv4,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_MASK |
+				       FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+		},
+		[IXGBE_FDIR_NORMAL_NODE_IPV6] = {
+			.name = "IPV6",
+			.type = RTE_FLOW_ITEM_TYPE_IPV6,
+			.validate = ixgbe_validate_fdir_normal_ipv6,
+			.process = ixgbe_process_fdir_normal_ipv6,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_MASK |
+				       FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+		},
+		[IXGBE_FDIR_NORMAL_NODE_TCP] = {
+			.name = "TCP",
+			.type = RTE_FLOW_ITEM_TYPE_TCP,
+			.validate = ixgbe_validate_fdir_normal_tcp,
+			.process = ixgbe_process_fdir_normal_tcp,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+			               FLOW_GRAPH_NODE_EXPECT_MASK |
+			               FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+		},
+		[IXGBE_FDIR_NORMAL_NODE_UDP] = {
+			.name = "UDP",
+			.type = RTE_FLOW_ITEM_TYPE_UDP,
+			.validate = ixgbe_validate_fdir_normal_udp,
+			.process = ixgbe_process_fdir_normal_udp,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+			               FLOW_GRAPH_NODE_EXPECT_MASK |
+			               FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+		},
+		[IXGBE_FDIR_NORMAL_NODE_SCTP] = {
+			.name = "SCTP",
+			.type = RTE_FLOW_ITEM_TYPE_SCTP,
+			.validate = ixgbe_validate_fdir_normal_sctp,
+			.process = ixgbe_process_fdir_normal_sctp,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+				       FLOW_GRAPH_NODE_EXPECT_MASK |
+				       FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+		},
+		[IXGBE_FDIR_NORMAL_NODE_RAW] = {
+			.name = "RAW",
+			.type = RTE_FLOW_ITEM_TYPE_RAW,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = ixgbe_validate_fdir_normal_raw,
+			.process = ixgbe_process_fdir_normal_raw,
+		},
+		[IXGBE_FDIR_NORMAL_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+			.process = ixgbe_process_fdir_normal_end,
+		},
+	},
+	.edges = (struct flow_graph_edge[]) {
+		[IXGBE_FDIR_NORMAL_NODE_START] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_NORMAL_NODE_ETH,
+				IXGBE_FDIR_NORMAL_NODE_IPV4,
+				IXGBE_FDIR_NORMAL_NODE_IPV6,
+				IXGBE_FDIR_NORMAL_NODE_TCP,
+				IXGBE_FDIR_NORMAL_NODE_UDP,
+				IXGBE_FDIR_NORMAL_NODE_SCTP,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_NORMAL_NODE_ETH] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_NORMAL_NODE_VLAN,
+				IXGBE_FDIR_NORMAL_NODE_IPV4,
+				IXGBE_FDIR_NORMAL_NODE_IPV6,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_NORMAL_NODE_VLAN] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_NORMAL_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_NORMAL_NODE_IPV4] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_NORMAL_NODE_TCP,
+				IXGBE_FDIR_NORMAL_NODE_UDP,
+				IXGBE_FDIR_NORMAL_NODE_SCTP,
+				IXGBE_FDIR_NORMAL_NODE_RAW,
+				IXGBE_FDIR_NORMAL_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_NORMAL_NODE_IPV6] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_NORMAL_NODE_TCP,
+				IXGBE_FDIR_NORMAL_NODE_UDP,
+				IXGBE_FDIR_NORMAL_NODE_SCTP,
+				IXGBE_FDIR_NORMAL_NODE_RAW,
+				IXGBE_FDIR_NORMAL_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_NORMAL_NODE_TCP] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_NORMAL_NODE_RAW,
+				IXGBE_FDIR_NORMAL_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_NORMAL_NODE_UDP] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_NORMAL_NODE_RAW,
+				IXGBE_FDIR_NORMAL_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_NORMAL_NODE_SCTP] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_NORMAL_NODE_RAW,
+				IXGBE_FDIR_NORMAL_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_NORMAL_NODE_RAW] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_NORMAL_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+/**
+ * FDIR tunnel graph implementation (VxLAN and NVGRE)
+ * Pattern: START -> [OUTER_ETH] -> (OUTER_IPv4|OUTER_IPv6) -> [UDP] -> (VXLAN|NVGRE) -> INNER_ETH -> [VLAN] -> END
+ * VxLAN:  START -> [OUTER_ETH] -> (OUTER_IPv4|OUTER_IPv6) -> UDP -> VXLAN -> INNER_ETH -> [VLAN] -> END
+ * NVGRE:  START -> [OUTER_ETH] -> (OUTER_IPv4|OUTER_IPv6) -> NVGRE -> INNER_ETH -> [VLAN] -> END
+ */
+
+enum ixgbe_fdir_tunnel_node_id {
+	IXGBE_FDIR_TUNNEL_NODE_START = FLOW_GRAPH_NODE_FIRST,
+	IXGBE_FDIR_TUNNEL_NODE_OUTER_ETH,
+	IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV4,
+	IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV6,
+	IXGBE_FDIR_TUNNEL_NODE_UDP,
+	IXGBE_FDIR_TUNNEL_NODE_VXLAN,
+	IXGBE_FDIR_TUNNEL_NODE_NVGRE,
+	IXGBE_FDIR_TUNNEL_NODE_INNER_ETH,
+	IXGBE_FDIR_TUNNEL_NODE_INNER_IPV4,
+	IXGBE_FDIR_TUNNEL_NODE_VLAN,
+	IXGBE_FDIR_TUNNEL_NODE_END,
+	IXGBE_FDIR_TUNNEL_NODE_MAX,
+};
+
+static int
+ixgbe_validate_fdir_tunnel_vxlan(const void *ctx __rte_unused,
+				 const struct rte_flow_item *item,
+				 struct rte_flow_error *error)
+{
+	const struct rte_flow_item_vxlan *vxlan_mask = item->mask;
+
+	if (vxlan_mask->hdr.flags) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"VxLAN flags must be masked");
+	}
+
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&vxlan_mask->hdr.vni)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Partial VNI mask not supported");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_tunnel_vxlan(void *ctx,
+				const struct rte_flow_item *item,
+				struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_vxlan *vxlan_spec = item->spec;
+	const struct rte_flow_item_vxlan *vxlan_mask = item->mask;
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	rule->ixgbe_fdir.formatted.tunnel_type = IXGBE_FDIR_VXLAN_TUNNEL_TYPE;
+
+	/* spec is optional */
+	if (vxlan_spec != NULL) {
+		rule->b_spec = TRUE;
+		memcpy(((uint8_t *)&rule->ixgbe_fdir.formatted.tni_vni), vxlan_spec->hdr.vni,
+				RTE_DIM(vxlan_spec->hdr.vni));
+	}
+
+	rule->b_mask = TRUE;
+	rule->mask.tunnel_type_mask = 1;
+	memcpy(&rule->mask.tunnel_id_mask, vxlan_mask->hdr.vni, RTE_DIM(vxlan_mask->hdr.vni));
+
+	return 0;
+}
+
+static int
+ixgbe_validate_fdir_tunnel_nvgre(const void *ctx __rte_unused,
+				 const struct rte_flow_item *item,
+				 struct rte_flow_error *error)
+{
+	const struct rte_flow_item_nvgre *nvgre_mask;
+
+	nvgre_mask = item->mask;
+
+	if (nvgre_mask->flow_id) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"NVGRE flow ID must not be masked");
+	}
+
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&nvgre_mask->protocol)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"NVGRE protocol must be fully masked or unmasked");
+	}
+
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&nvgre_mask->c_k_s_rsvd0_ver)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"NVGRE flags must be fully masked or unmasked");
+	}
+
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&nvgre_mask->tni)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Partial TNI mask not supported");
+	}
+
+	/* if spec is present, validate flags and protocol values */
+	if (item->spec) {
+		const struct rte_flow_item_nvgre *nvgre_spec = item->spec;
+
+		if (nvgre_mask->c_k_s_rsvd0_ver &&
+		    nvgre_spec->c_k_s_rsvd0_ver != rte_cpu_to_be_16(NVGRE_FLAGS)) {
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM, item,
+					"NVGRE flags must be 0x2000");
+		}
+		if (nvgre_mask->protocol &&
+		    nvgre_spec->protocol != rte_cpu_to_be_16(NVGRE_PROTOCOL)) {
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM, item,
+					"NVGRE protocol must be 0x6558");
+		}
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_tunnel_nvgre(void *ctx,
+				const struct rte_flow_item *item,
+				struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_nvgre *nvgre_spec = item->spec;
+	const struct rte_flow_item_nvgre *nvgre_mask = item->mask;
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	rule->ixgbe_fdir.formatted.tunnel_type = IXGBE_FDIR_NVGRE_TUNNEL_TYPE;
+
+	/* spec is optional */
+	if (nvgre_spec != NULL) {
+		rule->b_spec = TRUE;
+		memcpy(&fdir_ctx->rule.ixgbe_fdir.formatted.tni_vni,
+				nvgre_spec->tni, RTE_DIM(nvgre_spec->tni));
+	}
+
+	rule->b_mask = TRUE;
+	rule->mask.tunnel_type_mask = 1;
+	memcpy(&rule->mask.tunnel_id_mask, nvgre_mask->tni, RTE_DIM(nvgre_mask->tni));
+	rule->mask.tunnel_id_mask <<= 8;
+	return 0;
+}
+
+static int
+ixgbe_validate_fdir_tunnel_inner_eth(const void *ctx __rte_unused,
+				     const struct rte_flow_item *item,
+				     struct rte_flow_error *error)
+{
+	const struct rte_flow_item_eth *eth_mask = item->mask;
+
+	if (eth_mask->hdr.ether_type != 0) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Ether type mask not supported");
+	}
+
+	/* src addr must not be masked */
+	if (!CI_FIELD_IS_ZERO(&eth_mask->hdr.src_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Masking not supported for src MAC address");
+	}
+
+	/* dst addr must be either fully masked or fully unmasked */
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&eth_mask->hdr.dst_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Partial masks not supported for dst MAC address");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_tunnel_inner_eth(void *ctx,
+				    const struct rte_flow_item *item,
+				    struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_eth *eth_spec = item->spec;
+	const struct rte_flow_item_eth *eth_mask = item->mask;
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+	uint8_t j;
+
+	/* spec is optional */
+	if (eth_spec != NULL) {
+		rule->b_spec = TRUE;
+		memcpy(&rule->ixgbe_fdir.formatted.inner_mac,
+				eth_spec->hdr.dst_addr.addr_bytes,
+				RTE_ETHER_ADDR_LEN);
+	}
+
+	rule->b_mask = TRUE;
+	rule->mask.mac_addr_byte_mask = 0;
+	for (j = 0; j < RTE_ETHER_ADDR_LEN; j++) {
+		if (eth_mask->hdr.dst_addr.addr_bytes[j] == 0xFF) {
+			rule->mask.mac_addr_byte_mask |= 0x1 << j;
+		}
+	}
+
+	/* When no vlan, considered as full mask. */
+	rule->mask.vlan_tci_mask = IXGBE_FDIR_VLAN_TCI_MASK;
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_tunnel_vlan(void *ctx,
+			       const struct rte_flow_item *item,
+			       struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_vlan *vlan_spec = item->spec;
+	const struct rte_flow_item_vlan *vlan_mask = item->mask;
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	rule->ixgbe_fdir.formatted.vlan_id = vlan_spec->hdr.vlan_tci;
+
+	rule->mask.vlan_tci_mask = vlan_mask->hdr.vlan_tci;
+	rule->mask.vlan_tci_mask &= IXGBE_FDIR_VLAN_TCI_MASK;
+
+	return 0;
+}
+
+static const struct flow_graph ixgbe_fdir_tunnel_graph = {
+	.nodes = (struct flow_graph_node[]) {
+		[IXGBE_FDIR_TUNNEL_NODE_START] = {
+			.name = "START",
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_OUTER_ETH] = {
+			.name = "OUTER_ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV4] = {
+			.name = "OUTER_IPV4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV6] = {
+			.name = "OUTER_IPV6",
+			.type = RTE_FLOW_ITEM_TYPE_IPV6,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_UDP] = {
+			.name = "UDP",
+			.type = RTE_FLOW_ITEM_TYPE_UDP,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_VXLAN] = {
+			.name = "VXLAN",
+			.type = RTE_FLOW_ITEM_TYPE_VXLAN,
+			.validate = ixgbe_validate_fdir_tunnel_vxlan,
+			.process = ixgbe_process_fdir_tunnel_vxlan,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_MASK |
+				FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_NVGRE] = {
+			.name = "NVGRE",
+			.type = RTE_FLOW_ITEM_TYPE_NVGRE,
+			.validate = ixgbe_validate_fdir_tunnel_nvgre,
+			.process = ixgbe_process_fdir_tunnel_nvgre,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_MASK |
+				FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_INNER_ETH] = {
+			.name = "INNER_ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.validate = ixgbe_validate_fdir_tunnel_inner_eth,
+			.process = ixgbe_process_fdir_tunnel_inner_eth,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_MASK |
+				FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_INNER_IPV4] = {
+			.name = "INNER_IPV4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_VLAN] = {
+			.name = "VLAN",
+			.type = RTE_FLOW_ITEM_TYPE_VLAN,
+			.process = ixgbe_process_fdir_tunnel_vlan,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	},
+	.edges = (struct flow_graph_edge[]) {
+		[IXGBE_FDIR_TUNNEL_NODE_START] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_TUNNEL_NODE_OUTER_ETH,
+				IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV4,
+				IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV6,
+				IXGBE_FDIR_TUNNEL_NODE_UDP,
+				IXGBE_FDIR_TUNNEL_NODE_VXLAN,
+				IXGBE_FDIR_TUNNEL_NODE_NVGRE,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_OUTER_ETH] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV4,
+				IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV6,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV4] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_TUNNEL_NODE_UDP,
+				IXGBE_FDIR_TUNNEL_NODE_NVGRE,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV6] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_TUNNEL_NODE_UDP,
+				IXGBE_FDIR_TUNNEL_NODE_NVGRE,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_UDP] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_TUNNEL_NODE_VXLAN,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_VXLAN] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_TUNNEL_NODE_INNER_ETH,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_NVGRE] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_TUNNEL_NODE_INNER_ETH,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_INNER_ETH] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_TUNNEL_NODE_VLAN,
+				IXGBE_FDIR_TUNNEL_NODE_INNER_IPV4,
+				IXGBE_FDIR_TUNNEL_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_VLAN] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_TUNNEL_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+static inline uint8_t
+signature_match(const struct rte_flow_item *item)
+{
+	const struct rte_flow_item_fuzzy *spec, *last, *mask;
+	uint32_t sh, lh, mh;
+
+	spec = item->spec;
+	last = item->last;
+	mask = item->mask;
+
+	if (spec == NULL || mask == NULL)
+		return 0;
+
+	sh = spec->thresh;
+
+	if (last == NULL)
+		lh = sh;
+	else
+		lh = last->thresh;
+
+	mh = mask->thresh;
+	sh = sh & mh;
+	lh = lh & mh;
+
+	/*
+	 * A fuzzy item selects signature mode only when the masked threshold range
+	 * is non-empty. Otherwise this stays a perfect-match rule.
+	 */
+	if (!sh || sh > lh)
+		return 0;
+
+	return 1;
+}
+
+/* pre-parse pattern to determine if this is a signature or perfect match rule */
+static int
+ixgbe_fdir_pattern_parse(struct ci_flow_engine_ctx *ctx,
+		const struct rte_flow_item pattern[],
+		struct rte_flow_error *error)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = (struct ixgbe_fdir_ctx *)ctx;
+	const struct rte_flow_item *item;
+	bool found = false;
+
+	fdir_ctx->rule.mode = RTE_FDIR_MODE_PERFECT;
+
+	for (item = pattern; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
+		if (item->type != RTE_FLOW_ITEM_TYPE_FUZZY)
+			continue;
+
+		if (found) {
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM, item,
+					"Multiple FUZZY items not supported");
+		}
+		found = true;
+
+		if (signature_match(item))
+			fdir_ctx->rule.mode = RTE_FDIR_MODE_SIGNATURE;
+
+		break;
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_fdir_actions_check(const struct ci_flow_actions *parsed_actions,
+	const struct ci_flow_actions_check_param *param __rte_unused,
+	struct rte_flow_error *error)
+{
+	const enum rte_flow_action_type fwd_actions[] = {
+		RTE_FLOW_ACTION_TYPE_QUEUE,
+		RTE_FLOW_ACTION_TYPE_DROP,
+		RTE_FLOW_ACTION_TYPE_END
+	};
+	const struct rte_flow_action *action;
+
+	/* do the generic checks first */
+	int ret = ixgbe_flow_actions_check(parsed_actions, param, error);
+	if (ret)
+		return ret;
+
+	/* first action must be a forwarding action */
+	action = parsed_actions->actions[0];
+	if (!ci_flow_action_type_in_list(action->type, fwd_actions)) {
+		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+					  action, "First action must be QUEUE or DROP");
+	}
+	/* second action, if specified, must not be a forwarding action */
+	action = parsed_actions->actions[1];
+	if (action != NULL && ci_flow_action_type_in_list(action->type, fwd_actions)) {
+		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+					  action, "Conflicting actions");
+	}
+	return 0;
+}
+
+static int
+ixgbe_flow_fdir_ctx_finalize(struct ci_flow_engine_ctx *ctx, struct rte_flow_error *error)
+{
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(ctx->dev_data->dev_private);
+	struct ixgbe_fdir_ctx *fdir_ctx = (struct ixgbe_fdir_ctx *)ctx;
+	struct rte_eth_fdir_conf *global_fdir_conf = IXGBE_DEV_PRIVATE_TO_FDIR_CONF(adapter);
+
+	/* DROP action should not be used with signature matches */
+	if ((fdir_ctx->rule.mode == RTE_FDIR_MODE_SIGNATURE) &&
+	    (fdir_ctx->fwd_action->type == RTE_FLOW_ACTION_TYPE_DROP)) {
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+			"DROP action not allowed with signature mode");
+	}
+
+	/* check for conflicting filter modes */
+	if (global_fdir_conf->mode != RTE_FDIR_MODE_NONE &&
+			global_fdir_conf->mode != fdir_ctx->rule.mode) {
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+			"Conflicting filter modes");
+	}
+
+	/* rules without spec aren't allowed */
+	if (!fdir_ctx->rule.b_spec) {
+		return rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+			"Rule spec cannot be empty");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_flow_fdir_ctx_init_common(const struct rte_flow_action *actions,
+		const struct rte_flow_attr *attr,
+		struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = (struct ixgbe_fdir_ctx *)ctx;
+	struct ci_flow_actions parsed_actions;
+	struct ci_flow_actions_check_param ap_param = {
+		.allowed_types = (const enum rte_flow_action_type[]){
+			/* queue/mark/drop allowed here */
+			RTE_FLOW_ACTION_TYPE_QUEUE,
+			RTE_FLOW_ACTION_TYPE_DROP,
+			RTE_FLOW_ACTION_TYPE_MARK,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.driver_ctx = ctx->dev_data,
+		.check = ixgbe_fdir_actions_check
+	};
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
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
+	fdir_ctx->fwd_action = parsed_actions.actions[0];
+	/* can be NULL */
+	fdir_ctx->aux_action = parsed_actions.actions[1];
+
+	/* set up forward/drop action */
+	if (fdir_ctx->fwd_action->type == RTE_FLOW_ACTION_TYPE_QUEUE) {
+		const struct rte_flow_action_queue *q_act = fdir_ctx->fwd_action->conf;
+		rule->queue = q_act->index;
+	} else {
+		rule->fdirflags = IXGBE_FDIRCMD_DROP;
+	}
+
+	/* set up mark action */
+	if (fdir_ctx->aux_action != NULL && fdir_ctx->aux_action->type == RTE_FLOW_ACTION_TYPE_MARK) {
+		const struct rte_flow_action_mark *m_act = fdir_ctx->aux_action->conf;
+		rule->soft_id = m_act->id;
+	}
+
+	return ret;
+}
+
+static int
+ixgbe_flow_fdir_ctx_init(const struct rte_flow_action *actions,
+		const struct rte_flow_attr *attr,
+		struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(ctx->dev_data->dev_private);
+	struct ixgbe_fdir_ctx *fdir_ctx = (struct ixgbe_fdir_ctx *)ctx;
+	int ret;
+
+	/* call into common part first */
+	ret = ixgbe_flow_fdir_ctx_init_common(actions, attr, ctx, error);
+	if (ret)
+		return ret;
+
+	/* some hardware does not support SCTP matching */
+	if (hw->mac.type == ixgbe_mac_X550 ||
+			hw->mac.type == ixgbe_mac_X550EM_x ||
+			hw->mac.type == ixgbe_mac_X550EM_a ||
+			hw->mac.type == ixgbe_mac_E610)
+		fdir_ctx->supports_sctp_ports = true;
+
+	/*
+	 * Some fields may not be provided. Set spec to 0 and mask to default
+	 * value. So, we need not do anything for the not provided fields later.
+	 */
+	memset(&fdir_ctx->rule.mask, 0xFF, sizeof(struct ixgbe_hw_fdir_mask));
+	fdir_ctx->rule.mask.vlan_tci_mask = 0;
+	fdir_ctx->rule.mask.flex_bytes_mask = 0;
+	fdir_ctx->rule.mask.dst_port_mask = 0;
+	fdir_ctx->rule.mask.src_port_mask = 0;
+	fdir_ctx->rule.mask.l4_proto_match = 0;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_fdir_tunnel_ctx_init(const struct rte_flow_action *actions,
+		const struct rte_flow_attr *attr,
+		struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = (struct ixgbe_fdir_ctx *)ctx;
+	int ret;
+
+	/* call into common part first */
+	ret = ixgbe_flow_fdir_ctx_init_common(actions, attr, ctx, error);
+	if (ret)
+		return ret;
+
+	/**
+	 * Some fields may not be provided. Set spec to 0 and mask to default
+	 * value. So, we need not do anything for the not provided fields later.
+	 */
+	memset(&fdir_ctx->rule.mask, 0xFF, sizeof(struct ixgbe_hw_fdir_mask));
+	fdir_ctx->rule.mask.vlan_tci_mask = 0;
+	fdir_ctx->rule.mask.flex_bytes_mask = 0;
+	fdir_ctx->rule.mask.dst_port_mask = 0;
+	fdir_ctx->rule.mask.src_port_mask = 0;
+	fdir_ctx->rule.mask.l4_proto_match = 0;
+
+	fdir_ctx->rule.mode = RTE_FDIR_MODE_PERFECT_TUNNEL;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_fdir_ctx_to_flow(const struct ci_flow_engine_ctx *ctx,
+		struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(ctx->dev_data->dev_private);
+	const struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_PRIVATE_TO_FDIR_CONF(adapter);
+	const struct ixgbe_fdir_ctx *fdir_ctx = (const struct ixgbe_fdir_ctx *)ctx;
+	struct ixgbe_fdir_flow *fdir_flow = (struct ixgbe_fdir_flow *)flow;
+
+	fdir_flow->rule = fdir_ctx->rule;
+
+	if (fdir_flow->rule.fdirflags & IXGBE_FDIRCMD_DROP) {
+		fdir_flow->fdircmd_flags = IXGBE_FDIRCMD_DROP;
+		fdir_flow->queue = fdir_conf->drop_queue;
+	} else {
+		fdir_flow->fdircmd_flags = 0;
+		fdir_flow->queue = fdir_flow->rule.queue;
+	}
+
+	fdir_flow->fdirhash = ixgbe_fdir_compute_hash(adapter, &fdir_flow->rule);
+
+	return 0;
+}
+
+static bool
+ixgbe_fdir_table_contains(const struct ixgbe_fdir_state *state,
+		const struct ixgbe_fdir_rule *rule)
+{
+	return rte_hash_lookup(state->hash_handle, &rule->ixgbe_fdir) >= 0;
+}
+
+static int
+ixgbe_fdir_table_add(struct ixgbe_fdir_state *state,
+		struct ixgbe_fdir_flow *fdir_flow)
+{
+	if (rte_hash_add_key(state->hash_handle, &fdir_flow->rule.ixgbe_fdir) < 0)
+		return -ENOSPC;
+
+	return 0;
+}
+
+static int
+ixgbe_fdir_table_del(struct ixgbe_fdir_state *state,
+		struct ixgbe_fdir_flow *fdir_flow)
+{
+	if (rte_hash_del_key(state->hash_handle, &fdir_flow->rule.ixgbe_fdir) < 0)
+		return -ENOENT;
+
+	return 0;
+}
+
+/*
+ * The hardware has a single global input mask, so the first filter to carry one
+ * claims it and every later filter has to agree with it.
+ */
+static bool
+ixgbe_fdir_mask_is_compatible(const struct ixgbe_fdir_state *state,
+		const struct ixgbe_fdir_rule *rule)
+{
+	if (!state->mask_added || !rule->b_mask)
+		return true;
+	if (memcmp(&state->mask, &rule->mask, sizeof(state->mask)) != 0)
+		return false;
+
+	return rule->mask.flex_bytes_mask == 0 ||
+			state->flex_bytes_offset == rule->flex_bytes_offset;
+}
+
+/* take a reference on the global mode and mask on behalf of a new filter */
+static void
+ixgbe_fdir_mask_claim(struct ixgbe_fdir_state *state,
+		const struct ixgbe_fdir_rule *rule)
+{
+	if (state->nb_registered == 0)
+		state->mode = rule->mode;
+
+	/*
+	 * Take the mask from the first filter so the block gets configured with
+	 * something valid, then let the first filter that carries a real mask
+	 * claim it for good.
+	 */
+	if (state->nb_registered == 0 || (rule->b_mask && !state->mask_added)) {
+		state->mask = rule->mask;
+		state->flex_bytes_offset = rule->flex_bytes_offset;
+		state->mask_added = rule->b_mask;
+		state->mask_programmed = false;
+	}
+	state->nb_registered++;
+}
+
+/* drop a reference; the next filter to be registered gets to pick the mask again */
+static void
+ixgbe_fdir_mask_release(struct ixgbe_fdir_state *state)
+{
+	if (--state->nb_registered > 0)
+		return;
+
+	state->mask = (struct ixgbe_hw_fdir_mask){ 0 };
+	state->flex_bytes_offset = 0;
+	state->mask_added = false;
+	state->mask_programmed = false;
+	state->mode = RTE_FDIR_MODE_NONE;
+}
+
+static int
+ixgbe_flow_fdir_flow_register(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct ixgbe_fdir_flow *fdir_flow = (struct ixgbe_fdir_flow *)flow;
+	struct ixgbe_fdir_priv *priv = flow->engine_priv;
+	struct ixgbe_fdir_state *state = priv->state;
+	struct ixgbe_fdir_rule *rule = &fdir_flow->rule;
+
+	if (ixgbe_fdir_table_contains(state, rule)) {
+		return rte_flow_error_set(error, EEXIST,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Conflict with existing flow director filter");
+	}
+
+	if (!ixgbe_fdir_mask_is_compatible(state, rule)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Flow mask is incompatible with existing rules");
+	}
+
+	if (ixgbe_fdir_table_add(state, fdir_flow) != 0) {
+		return rte_flow_error_set(error, ENOSPC,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Flow director filter table is full");
+	}
+
+	ixgbe_fdir_mask_claim(state, rule);
+
+	return 0;
+}
+
+static int
+ixgbe_flow_fdir_flow_unregister(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct ixgbe_fdir_flow *fdir_flow = (struct ixgbe_fdir_flow *)flow;
+	struct ixgbe_fdir_priv *priv = flow->engine_priv;
+	struct ixgbe_fdir_state *state = priv->state;
+	int ret;
+
+	ret = ixgbe_fdir_table_del(state, fdir_flow);
+	if (ret == -ENOENT) {
+		return rte_flow_error_set(error, ENOENT,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Flow director filter is missing from the filter table");
+	}
+
+	ixgbe_fdir_mask_release(state);
+
+	return 0;
+}
+
+static int
+ixgbe_flow_fdir_configure_hw(struct ixgbe_adapter *adapter,
+		struct ixgbe_fdir_state *state,
+		struct rte_flow_error *error)
+{
+	struct rte_eth_fdir_conf *global_fdir_conf = IXGBE_DEV_PRIVATE_TO_FDIR_CONF(adapter);
+	struct rte_eth_fdir_conf local_fdir_conf = *global_fdir_conf;
+	int ret;
+
+	local_fdir_conf.mode = state->mode;
+
+	ret = ixgbe_fdir_configure(adapter, &local_fdir_conf, &state->mask);
+	if (ret != 0) {
+		return rte_flow_error_set(error, -ret,
+			RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+			"Failed to configure flow director");
+	}
+
+	global_fdir_conf->mode = state->mode;
+	state->hw_configured = true;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_fdir_program_mask(struct ixgbe_adapter *adapter,
+		struct ixgbe_fdir_state *state,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_hw_fdir_info *global_fdir_info = IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
+	int ret;
+
+	if (state->mask.flex_bytes_mask != 0) {
+		ret = ixgbe_fdir_set_flexbytes_offset(adapter, state->flex_bytes_offset);
+		if (ret != 0) {
+			return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Failed to set flex bytes offset");
+		}
+	}
+
+	ret = ixgbe_fdir_set_input_mask(adapter, &state->mask, state->mode);
+	if (ret != 0) {
+		return rte_flow_error_set(error, -ret,
+			RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+			"Failed to set input mask");
+	}
+
+	/* record what is now in hardware for ixgbe_fdir_info_get() */
+	global_fdir_info->mask = state->mask;
+	global_fdir_info->flex_bytes_offset = state->flex_bytes_offset;
+	state->mask_programmed = true;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_fdir_flow_install(struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(flow->dev_data->dev_private);
+	struct ixgbe_fdir_flow *fdir_flow = (struct ixgbe_fdir_flow *)flow;
+	struct ixgbe_fdir_priv *priv = flow->engine_priv;
+	struct ixgbe_fdir_state *state = priv->state;
+	int ret;
+
+	if (!state->hw_configured) {
+		ret = ixgbe_flow_fdir_configure_hw(adapter, state, error);
+		if (ret != 0)
+			return ret;
+	}
+
+	if (!state->mask_programmed) {
+		ret = ixgbe_flow_fdir_program_mask(adapter, state, error);
+		if (ret != 0)
+			return ret;
+	}
+
+	ret = ixgbe_fdir_filter_program(adapter, &fdir_flow->rule, fdir_flow->queue,
+			fdir_flow->fdircmd_flags, fdir_flow->fdirhash);
+	if (ret != 0) {
+		return rte_flow_error_set(error, -ret,
+			RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+			"Failed to program flow director filter");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_flow_fdir_flow_uninstall(struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(flow->dev_data->dev_private);
+	struct rte_eth_fdir_conf *global_fdir_conf = IXGBE_DEV_PRIVATE_TO_FDIR_CONF(adapter);
+	struct ixgbe_fdir_flow *fdir_flow = (struct ixgbe_fdir_flow *)flow;
+	struct ixgbe_fdir_priv *priv = flow->engine_priv;
+	struct ixgbe_fdir_state *state = priv->state;
+	int ret;
+
+	ret = ixgbe_fdir_filter_clear(adapter, fdir_flow->fdirhash);
+	if (ret != 0) {
+		return rte_flow_error_set(error, -ret,
+			RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+			"Failed to remove flow director filter");
+	}
+
+	/* unregister has not run yet, so this filter is still counted */
+	if (state->nb_registered > 1)
+		return 0;
+
+	state->hw_configured = false;
+	state->mask_programmed = false;
+	global_fdir_conf->mode = RTE_FDIR_MODE_NONE;
+
+	ret = ixgbe_fdir_reset_tables(adapter);
+	if (ret != 0) {
+		return rte_flow_error_set(error, -ret,
+			RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+			"Failed to reset flow director tables");
+	}
+
+	return 0;
+}
+
+static void
+ixgbe_flow_fdir_engine_uninit(const struct ci_flow_engine *engine __rte_unused,
+		void *priv)
+{
+	struct ixgbe_fdir_priv *fdir_priv = priv;
+
+	ixgbe_fdir_state_detach(fdir_priv->state);
+}
+
+static int
+ixgbe_flow_fdir_state_attach(struct rte_eth_dev_data *dev_data, void *priv)
+{
+	struct ixgbe_fdir_priv *fdir_priv = priv;
+
+	fdir_priv->state = ixgbe_fdir_state_attach(dev_data);
+
+	return fdir_priv->state == NULL ? -ENOMEM : 0;
+}
+
+static int
+ixgbe_flow_fdir_engine_init(const struct ci_flow_engine *engine __rte_unused,
+		struct rte_eth_dev_data *dev_data,
+		void *priv)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev_data->dev_private);
+
+	if (hw->mac.type != ixgbe_mac_82599EB &&
+			hw->mac.type != ixgbe_mac_X540 &&
+			hw->mac.type != ixgbe_mac_X550 &&
+			hw->mac.type != ixgbe_mac_X550EM_x &&
+			hw->mac.type != ixgbe_mac_X550EM_a &&
+			hw->mac.type != ixgbe_mac_E610)
+		return -ENOTSUP;
+
+	return ixgbe_flow_fdir_state_attach(dev_data, priv);
+}
+
+static int
+ixgbe_flow_fdir_tunnel_engine_init(const struct ci_flow_engine *engine __rte_unused,
+		struct rte_eth_dev_data *dev_data,
+		void *priv)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev_data->dev_private);
+
+	if (hw->mac.type != ixgbe_mac_X550 &&
+			hw->mac.type != ixgbe_mac_X550EM_x &&
+			hw->mac.type != ixgbe_mac_X550EM_a &&
+			hw->mac.type != ixgbe_mac_E610)
+		return -ENOTSUP;
+
+	return ixgbe_flow_fdir_state_attach(dev_data, priv);
+}
+
+static const struct ci_flow_engine_ops ixgbe_fdir_ops = {
+	.engine_init = ixgbe_flow_fdir_engine_init,
+	.engine_uninit = ixgbe_flow_fdir_engine_uninit,
+	.ctx_init = ixgbe_flow_fdir_ctx_init,
+	.pattern_parse = ixgbe_fdir_pattern_parse,
+	.ctx_finalize = ixgbe_flow_fdir_ctx_finalize,
+	.ctx_to_flow = ixgbe_flow_fdir_ctx_to_flow,
+	.flow_register = ixgbe_flow_fdir_flow_register,
+	.flow_unregister = ixgbe_flow_fdir_flow_unregister,
+	.flow_install = ixgbe_flow_fdir_flow_install,
+	.flow_uninstall = ixgbe_flow_fdir_flow_uninstall,
+};
+
+static const struct ci_flow_engine_ops ixgbe_fdir_tunnel_ops = {
+	.engine_init = ixgbe_flow_fdir_tunnel_engine_init,
+	.engine_uninit = ixgbe_flow_fdir_engine_uninit,
+	.ctx_init = ixgbe_flow_fdir_tunnel_ctx_init,
+	.ctx_finalize = ixgbe_flow_fdir_ctx_finalize,
+	.ctx_to_flow = ixgbe_flow_fdir_ctx_to_flow,
+	.flow_register = ixgbe_flow_fdir_flow_register,
+	.flow_unregister = ixgbe_flow_fdir_flow_unregister,
+	.flow_install = ixgbe_flow_fdir_flow_install,
+	.flow_uninstall = ixgbe_flow_fdir_flow_uninstall,
+};
+
+const struct ci_flow_engine ixgbe_fdir_flow_engine = {
+	.name = "fdir",
+	.ctx_size = sizeof(struct ixgbe_fdir_ctx),
+	.flow_size = sizeof(struct ixgbe_fdir_flow),
+	.priv_size = sizeof(struct ixgbe_fdir_priv),
+	.ops = &ixgbe_fdir_ops,
+	.graph = &ixgbe_fdir_normal_graph,
+};
+
+const struct ci_flow_engine ixgbe_fdir_tunnel_flow_engine = {
+	.name = "fdir_tunnel",
+	.ctx_size = sizeof(struct ixgbe_fdir_ctx),
+	.flow_size = sizeof(struct ixgbe_fdir_flow),
+	.priv_size = sizeof(struct ixgbe_fdir_priv),
+	.ops = &ixgbe_fdir_tunnel_ops,
+	.graph = &ixgbe_fdir_tunnel_graph,
+};
diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
index 12ba639b70..2487f6a522 100644
--- a/drivers/net/intel/ixgbe/meson.build
+++ b/drivers/net/intel/ixgbe/meson.build
@@ -31,6 +31,7 @@ sources += files(
         'ixgbe_flow_l2tun.c',
         'ixgbe_flow_ntuple.c',
         'ixgbe_flow_security.c',
+        'ixgbe_flow_fdir.c',
         'ixgbe_ipsec.c',
         'ixgbe_pf.c',
         'ixgbe_rxtx.c',
-- 
2.52.0

