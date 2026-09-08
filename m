Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC5BC79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 15:24:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFD94427AD;
	Tue,  8 Sep 2026 17:22:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 2910640EE1
 for <dev@dpdk.org>; Tue,  8 Sep 2026 17:22:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788880947; x=1820416947;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Y5gSKAy+HaXoqGTOXgYvc12bD5o0eM0DZlMXH4QLrQQ=;
 b=Y4w1SZPBmN293O6Bk+lbyUSfziUd8PhZ45Rsa4Smf6Rdoaj3Er3vHWa0
 RVqKpBTKM47wA5w/ipHzBosoTQ+w1jFBh1JEdSY4x8VwPijRFT5LO6QSl
 DjtTq6hOm4EGv+TnWVsvMFzwKMOicWaT/whH9r4gT7tuV9x/KhUxjccBG
 vlxlzscAN7AfnKp3iU/Q5buqyrzE0XxGaH3fyrGTK5N2kNpbkhEdKN6V8
 RaJKJFB+WmDtQcM9OPQMj7t6WsSASpIBV3aMyaW2fq5Vp6OkFB2dCDOto
 upzvJ6aqPeZmPa1s4FqLzw3VGqXDPA1sm8uxdGyj2s0auggopF+cBsWI0 g==;
X-CSE-ConnectionGUID: yaKkSPGiTySq/58YuJgWvA==
X-CSE-MsgGUID: ccMpIzxZTGW2jZ9U/kmI5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89330231"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="89330231"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 08:22:26 -0700
X-CSE-ConnectionGUID: Kp7aJZpaSG+0UsiG3ErNxw==
X-CSE-MsgGUID: NR7OqM6VTCefan5+J+RcuA==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 08 Sep 2026 08:22:24 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 16/19] net/i40e: reimplement FDIR parser
Date: Tue,  8 Sep 2026 16:20:58 +0100
Message-ID: <a612cb4d223b6ebc0f759a093470a0045d85b348.1788880125.git.anatoly.burakov@intel.com>
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

As a result of transitioning to more formalized validation, some checks
have become more stringent. In particular, some protocols (such as SCTP)
were previously accepting non-zero or invalid masks and either ignoring
them or misinterpreting them to mean "fully masked". This has now been
corrected.

The FDIR engine in i40e has also relied on a custom memory allocation
scheme for fdir flows - also migrated to the new infrastructure.

Finally, some of the FDIR infrastructure has been migrated into the new
flow engine, so that the engine itself is managing its own allocator and
its own flow deduplication scheme.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c    |   11 +-
 drivers/net/intel/i40e/i40e_ethdev.h    |   64 +-
 drivers/net/intel/i40e/i40e_fdir.c      |  351 +---
 drivers/net/intel/i40e/i40e_flow.c      | 1916 +--------------------
 drivers/net/intel/i40e/i40e_flow.h      |    5 +
 drivers/net/intel/i40e/i40e_flow_fdir.c | 2056 +++++++++++++++++++++++
 drivers/net/intel/i40e/meson.build      |    1 +
 7 files changed, 2126 insertions(+), 2278 deletions(-)
 create mode 100644 drivers/net/intel/i40e/i40e_flow_fdir.c

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 25062fe695..572dfff13a 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -1659,9 +1659,7 @@ eth_i40e_dev_init(struct rte_eth_dev *dev, void *init_params __rte_unused)
 	ret = i40e_init_tunnel_filter_list(dev);
 	if (ret < 0)
 		goto err_init_tunnel_filter_list;
-	ret = i40e_fdir_flow_store_init(dev);
-	if (ret < 0)
-		goto err_init_fdir_flow_store;
+	i40e_fdir_flow_store_init(dev);
 
 	/* initialize flow engine configuration */
 	ret = ci_flow_engine_conf_init(&pf->flow_engine_conf,
@@ -1678,8 +1676,6 @@ eth_i40e_dev_init(struct rte_eth_dev *dev, void *init_params __rte_unused)
 	return 0;
 
 err_flow_engine_conf_init:
-	i40e_fdir_flow_store_free(&pf->fdir);
-err_init_fdir_flow_store:
 	rte_hash_free(pf->tunnel.hash_table);
 	rte_free(pf->tunnel.hash_map);
 err_init_tunnel_filter_list:
@@ -1727,7 +1723,6 @@ i40e_fdir_memory_cleanup(struct i40e_pf *pf)
 {
 	struct i40e_fdir_info *fdir_info = &pf->fdir;
 
-	i40e_fdir_flow_store_free(fdir_info);
 	i40e_fdir_tmpl_store_free(fdir_info);
 }
 
@@ -2588,9 +2583,7 @@ i40e_dev_close(struct rte_eth_dev *dev)
 	/* Remove all flows */
 	while ((p_flow = TAILQ_FIRST(&pf->flow_list))) {
 		TAILQ_REMOVE(&pf->flow_list, p_flow, node);
-		/* Do not free FDIR flows since they are static allocated */
-		if (p_flow->filter_type != RTE_ETH_FILTER_FDIR)
-			rte_free(p_flow);
+		rte_free(p_flow);
 	}
 
 	/* release the fdir static allocated memory */
diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 3b6868fe7c..7a326fa75b 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -522,6 +522,9 @@ struct i40e_vmdq_info {
 #define I40E_WORD(hi, lo) (uint16_t)((((hi) << 8) & 0xFF00) | ((lo) & 0xFF))
 #define I40E_FLEX_WORD_MASK(off) (0x80 >> (off))
 #define I40E_FDIR_IPv6_TC_OFFSET	20
+#define I40E_IPV6_TC_MASK	(0xFF << I40E_FDIR_IPv6_TC_OFFSET)
+#define I40E_IPV6_FRAG_HEADER	44
+#define I40E_VLAN_TCI_MASK	(RTE_VLAN_PRI_MASK | RTE_VLAN_DEI_MASK | RTE_VLAN_ID_MASK)
 
 /* A structure used to define the input for GTP flow */
 struct i40e_gtp_flow {
@@ -735,23 +738,6 @@ struct i40e_fdir_tmpl_key {
 	const uint8_t *packet;
 };
 
-/* fdir memory pool entry */
-struct i40e_fdir_entry {
-	struct rte_flow flow;
-	uint32_t idx;
-};
-
-/* pre-allocated fdir memory pool */
-struct i40e_fdir_flow_pool {
-	/* a bitmap to manage the fdir pool */
-	struct rte_bitmap *bitmap;
-	/* the size the pool is pf->fdir->fdir_space_size */
-	struct i40e_fdir_entry *pool;
-};
-
-#define FLOW_TO_FLOW_BITMAP(f) \
-	container_of((f), struct i40e_fdir_entry, flow)
-
 TAILQ_HEAD(i40e_fdir_tmpl_list, i40e_fdir_tmpl_filter);
 
 /* tracking for rte_flow-backed filters */
@@ -774,11 +760,8 @@ struct i40e_fdir_layer_state {
 	uint32_t flex_flow_count;
 };
 
+/* global flex PIT configuration tracking */
 struct i40e_fdir_flow_store {
-	struct rte_hash *hash_table;
-	/* the pre-allocated pool of the rte_flow */
-	struct i40e_fdir_flow_pool flow_pool;
-
 	struct i40e_fdir_pctype_state pctype[I40E_FILTER_PCTYPE_MAX];
 	struct i40e_fdir_layer_state layer[I40E_MAX_FLXPLD_LAYER];
 };
@@ -1335,7 +1318,6 @@ extern const struct rte_flow_ops i40e_flow_ops;
 
 struct i40e_filter_ctx {
 	union {
-		struct i40e_fdir_filter fdir_filter;
 		struct i40e_tunnel_filter_conf consistent_tunnel_filter;
 		struct i40e_rte_flow_rss_conf rss_conf;
 	};
@@ -1384,8 +1366,9 @@ void i40e_vsi_enable_queues_intr(struct i40e_vsi *vsi);
 const struct rte_memzone *i40e_memzone_reserve(const char *name,
 					uint32_t len,
 					int socket_id);
-int i40e_fdir_configure(struct rte_eth_dev *dev);
-void i40e_fdir_rx_proc_sync(struct rte_eth_dev *dev);
+int i40e_fdir_configure(struct i40e_pf *pf);
+void i40e_fdir_rx_proc_sync(struct rte_eth_dev_data *dev_data);
+int i40e_fdir_engine_init(struct i40e_pf *pf);
 void i40e_fdir_teardown(struct i40e_pf *pf);
 enum i40e_filter_pctype
 	i40e_flowtype_to_pctype(const struct i40e_adapter *adapter,
@@ -1425,38 +1408,35 @@ uint64_t i40e_get_default_input_set(uint16_t pctype);
 int i40e_ethertype_filter_program(struct i40e_pf *pf,
 			      struct rte_eth_ethertype_filter *filter,
 			      bool add);
-struct rte_flow *
-i40e_fdir_entry_pool_get(struct i40e_fdir_info *fdir_info);
-void i40e_fdir_entry_pool_put(struct i40e_fdir_info *fdir_info,
-		struct rte_flow *flow);
 int i40e_fdir_tmpl_add_del(struct rte_eth_dev *dev,
 			   const struct i40e_fdir_filter *filter,
 			   bool add);
-struct i40e_fdir_filter *
-i40e_fdir_filter_lookup(struct i40e_fdir_info *fdir_info,
-			const struct i40e_fdir_input *input);
-int i40e_fdir_filter_validate(struct rte_eth_dev *dev,
-			      const struct i40e_fdir_filter *filter);
-int i40e_fdir_filter_register(struct rte_eth_dev *dev,
-			      const struct i40e_fdir_filter *filter,
-			      struct i40e_fdir_filter **node);
-int i40e_fdir_filter_unregister(struct rte_eth_dev *dev,
-				struct i40e_fdir_filter *node);
-int i40e_fdir_filter_program(struct rte_eth_dev *dev,
+int i40e_fdir_filter_program(struct i40e_pf *pf,
 			     const struct i40e_fdir_filter *filter,
 			     bool add, bool wait_status);
 bool i40e_fdir_filter_needs_status_wait(const struct i40e_pf *pf,
 					uint32_t filter_count);
+enum i40e_filter_pctype i40e_fdir_filter_pctype(const struct i40e_fdir_filter *filter);
 void i40e_fdir_tmpl_store_free(struct i40e_fdir_info *fdir_info);
-int i40e_fdir_flow_store_init(struct rte_eth_dev *dev);
-void i40e_fdir_flow_store_free(struct i40e_fdir_info *fdir_info);
+void i40e_fdir_flow_store_init(struct rte_eth_dev *dev);
+int i40e_fdir_inset_check(struct i40e_pf *pf,
+		enum i40e_filter_pctype pctype,
+		uint64_t input_set);
+int i40e_fdir_flex_check(struct i40e_pf *pf,
+		const struct i40e_fdir_filter *filter,
+		enum i40e_filter_pctype pctype,
+		struct i40e_fdir_flex_mask *flex_mask);
+void i40e_fdir_flex_store(struct i40e_pf *pf,
+		const struct i40e_fdir_filter *filter,
+		enum i40e_filter_pctype pctype,
+		const struct i40e_fdir_flex_mask *flex_mask);
 int i40e_dev_tunnel_filter_set(struct i40e_pf *pf,
 			       struct rte_eth_tunnel_filter_conf *tunnel_filter,
 			       uint8_t add);
 int i40e_dev_consistent_tunnel_filter_set(struct i40e_pf *pf,
 				  struct i40e_tunnel_filter_conf *tunnel_filter,
 				  uint8_t add);
-int i40e_fdir_flush(struct rte_eth_dev *dev);
+int i40e_fdir_flush(struct i40e_pf *pf);
 int i40e_find_all_vlan_for_mac(struct i40e_vsi *vsi,
 			       struct i40e_macvlan_filter *mv_f,
 			       int num, struct rte_ether_addr *addr);
diff --git a/drivers/net/intel/i40e/i40e_fdir.c b/drivers/net/intel/i40e/i40e_fdir.c
index 182894cdde..750613af89 100644
--- a/drivers/net/intel/i40e/i40e_fdir.c
+++ b/drivers/net/intel/i40e/i40e_fdir.c
@@ -371,14 +371,14 @@ i40e_init_flx_pld(struct i40e_pf *pf)
  * Match flow director RX processing to whether any filter is registered.
  */
 void
-i40e_fdir_rx_proc_sync(struct rte_eth_dev *dev)
+i40e_fdir_rx_proc_sync(struct rte_eth_dev_data *data)
 {
-	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(data->dev_private);
 	bool on = pf->fdir.fdir_actual_cnt > 0;
 	uint16_t i;
 
-	for (i = 0; i < dev->data->nb_rx_queues; i++) {
-		struct ci_rx_queue *rxq = dev->data->rx_queues[i];
+	for (i = 0; i < data->nb_rx_queues; i++) {
+		struct ci_rx_queue *rxq = data->rx_queues[i];
 
 		if (rxq == NULL)
 			continue;
@@ -391,10 +391,9 @@ i40e_fdir_rx_proc_sync(struct rte_eth_dev *dev)
  * Configure flow director related setting
  */
 int
-i40e_fdir_configure(struct rte_eth_dev *dev)
+i40e_fdir_configure(struct i40e_pf *pf)
 {
-	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
 	uint32_t val;
 	int ret = 0;
 
@@ -404,7 +403,7 @@ i40e_fdir_configure(struct rte_eth_dev *dev)
 	* If filters exist, flush them.
 	*/
 	if (i40e_fdir_empty(hw) < 0) {
-		ret = i40e_fdir_flush(dev);
+		ret = i40e_fdir_flush(pf);
 		if (ret) {
 			PMD_DRV_LOG(ERR, "failed to flush fdir table.");
 			return ret;
@@ -424,10 +423,9 @@ i40e_fdir_configure(struct rte_eth_dev *dev)
 /*
  * Bring up the flow director engine on first use.
  */
-static int
-i40e_fdir_engine_init(struct rte_eth_dev *dev)
+int
+i40e_fdir_engine_init(struct i40e_pf *pf)
 {
-	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	int ret;
 
 	if (pf->fdir.fdir_vsi != NULL)
@@ -439,7 +437,7 @@ i40e_fdir_engine_init(struct rte_eth_dev *dev)
 		return -ENOTSUP;
 	}
 
-	ret = i40e_fdir_configure(dev);
+	ret = i40e_fdir_configure(pf);
 	if (ret < 0) {
 		PMD_DRV_LOG(ERR, "Failed to configure fdir.");
 		i40e_fdir_teardown(pf);
@@ -1021,149 +1019,20 @@ i40e_fdir_programming_status_cleanup(struct ci_rx_queue *rxq)
 		PMD_DRV_LOG(INFO, "error report captured.");
 }
 
-/* Add a flow director filter into the SW hash table */
-static int
-i40e_fdir_filter_hash_add(struct i40e_pf *pf,
-			  const struct i40e_fdir_filter *filter,
-			  struct i40e_fdir_filter **node)
-{
-	struct i40e_fdir_flow_store *flows = &pf->fdir.flows;
-	int ret;
-
-	ret = rte_hash_lookup(flows->hash_table, &filter->input);
-	if (ret >= 0) {
-		PMD_DRV_LOG(ERR, "Failed to add fdir filter to hash table %d!",
-			    ret);
-		return -EEXIST;
-	}
-
-	ret = rte_hash_add_key(flows->hash_table, &filter->input);
-	if (ret < 0) {
-		PMD_DRV_LOG(ERR,
-			    "Failed to insert fdir filter to hash table %d!",
-			    ret);
-		return ret;
-	}
-
-	**node = *filter;
-
-	return 0;
-}
-
-/* Delete a flow director filter from the SW hash table */
-static int
-i40e_fdir_filter_hash_del(struct i40e_pf *pf,
-			  const struct i40e_fdir_filter *node)
-{
-	int ret;
-
-	ret = rte_hash_del_key(pf->fdir.flows.hash_table, &node->input);
-	if (ret < 0) {
-		PMD_DRV_LOG(ERR,
-			    "Failed to delete fdir filter from hash table %d!",
-			    ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-int
+void
 i40e_fdir_flow_store_init(struct rte_eth_dev *dev)
 {
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
 	struct i40e_fdir_info *fdir_info = &pf->fdir;
-	struct i40e_fdir_flow_store *flows = &fdir_info->flows;
-	char fdir_hash_name[RTE_HASH_NAMESIZE];
 	uint32_t alloc = hw->func_caps.fd_filters_guaranteed;
 	uint32_t best = hw->func_caps.fd_filters_best_effort;
-	struct rte_bitmap *bmp = NULL;
-	uint32_t bmp_size;
-	void *mem = NULL;
-	uint32_t i = 0;
-	int ret;
-
-	struct rte_hash_parameters fdir_hash_params = {
-		.name = fdir_hash_name,
-		.entries = I40E_MAX_FDIR_FILTER_NUM,
-		.key_len = sizeof(struct i40e_fdir_input),
-		.hash_func = rte_hash_crc,
-		.hash_func_init_val = 0,
-		.socket_id = rte_socket_id(),
-	};
-
-	snprintf(fdir_hash_name, RTE_HASH_NAMESIZE,
-		 "fdir_%s", dev->device->name);
-	flows->hash_table = rte_hash_create(&fdir_hash_params);
-	if (!flows->hash_table) {
-		PMD_INIT_LOG(ERR, "Failed to create fdir hash table!");
-		return -EINVAL;
-	}
 
 	fdir_info->fdir_space_size = alloc + best;
 	fdir_info->fdir_actual_cnt = 0;
 	fdir_info->fdir_guarantee_total_space = alloc;
 
 	PMD_DRV_LOG(INFO, "FDIR guarantee space: %u, best_effort space %u.", alloc, best);
-
-	flows->flow_pool.pool =
-			rte_zmalloc("i40e_fdir_entry",
-				sizeof(struct i40e_fdir_entry) *
-				fdir_info->fdir_space_size,
-				0);
-
-	if (!flows->flow_pool.pool) {
-		PMD_INIT_LOG(ERR,
-			     "Failed to allocate memory for bitmap flow!");
-		ret = -ENOMEM;
-		goto err_fdir_bitmap_flow_alloc;
-	}
-
-	for (i = 0; i < fdir_info->fdir_space_size; i++)
-		flows->flow_pool.pool[i].idx = i;
-
-	bmp_size =
-		rte_bitmap_get_memory_footprint(fdir_info->fdir_space_size);
-	mem = rte_zmalloc("fdir_bmap", bmp_size, RTE_CACHE_LINE_SIZE);
-	if (mem == NULL) {
-		PMD_INIT_LOG(ERR,
-			     "Failed to allocate memory for fdir bitmap!");
-		ret = -ENOMEM;
-		goto err_fdir_mem_alloc;
-	}
-	bmp = rte_bitmap_init(fdir_info->fdir_space_size, mem, bmp_size);
-	if (bmp == NULL) {
-		PMD_INIT_LOG(ERR,
-			     "Failed to initialization fdir bitmap!");
-		ret = -ENOMEM;
-		goto err_fdir_bmp_alloc;
-	}
-	for (i = 0; i < fdir_info->fdir_space_size; i++)
-		rte_bitmap_set(bmp, i);
-
-	flows->flow_pool.bitmap = bmp;
-
-	return 0;
-
-err_fdir_bmp_alloc:
-	rte_free(mem);
-err_fdir_mem_alloc:
-	rte_free(flows->flow_pool.pool);
-err_fdir_bitmap_flow_alloc:
-	rte_hash_free(flows->hash_table);
-
-	return ret;
-}
-
-void
-i40e_fdir_flow_store_free(struct i40e_fdir_info *fdir_info)
-{
-	struct i40e_fdir_flow_store *flows = &fdir_info->flows;
-
-	rte_free(flows->flow_pool.bitmap);
-	rte_free(flows->flow_pool.pool);
-	rte_hash_free(flows->hash_table);
 }
 
 static uint32_t
@@ -1282,53 +1151,6 @@ i40e_fdir_tmpl_lookup(struct i40e_fdir_info *fdir_info,
 	return &fdir_info->tmpls.filter_array[ret];
 }
 
-struct rte_flow *
-i40e_fdir_entry_pool_get(struct i40e_fdir_info *fdir_info)
-{
-	struct i40e_fdir_flow_pool *pool = &fdir_info->flows.flow_pool;
-	struct rte_flow *flow = NULL;
-	uint64_t slab = 0;
-	uint32_t pos = 0;
-	uint32_t i = 0;
-	int ret;
-
-	if (fdir_info->fdir_actual_cnt >=
-			fdir_info->fdir_space_size) {
-		PMD_DRV_LOG(ERR, "Fdir space full");
-		return NULL;
-	}
-
-	ret = rte_bitmap_scan(pool->bitmap, &pos, &slab);
-
-	/* normally this won't happen as the fdir_actual_cnt should be
-	 * same with the number of the set bits in fdir_flow_pool,
-	 * but anyway handle this error condition here for safe
-	 */
-	if (ret == 0) {
-		PMD_DRV_LOG(ERR, "fdir_actual_cnt out of sync");
-		return NULL;
-	}
-
-	i = rte_bsf64(slab);
-	pos += i;
-	rte_bitmap_clear(pool->bitmap, pos);
-	flow = &pool->pool[pos].flow;
-
-	memset(flow, 0, sizeof(struct rte_flow));
-
-	return flow;
-}
-
-void
-i40e_fdir_entry_pool_put(struct i40e_fdir_info *fdir_info,
-		struct rte_flow *flow)
-{
-	struct i40e_fdir_entry *f;
-
-	f = FLOW_TO_FLOW_BITMAP(flow);
-	rte_bitmap_set(fdir_info->flows.flow_pool.bitmap, f->idx);
-}
-
 static int
 i40e_fdir_check_flex_pit(struct i40e_pf *pf,
 			 const struct i40e_fdir_flex_pit *flex_pit,
@@ -1483,7 +1305,7 @@ i40e_fdir_flex_msk_program(struct i40e_pf *pf,
 	return 0;
 }
 
-static int
+int
 i40e_fdir_flex_check(struct i40e_pf *pf,
 		     const struct i40e_fdir_filter *filter,
 		     enum i40e_filter_pctype pctype,
@@ -1521,7 +1343,7 @@ i40e_fdir_flex_check(struct i40e_pf *pf,
 	return 0;
 }
 
-static void
+void
 i40e_fdir_flex_store(struct i40e_pf *pf,
 		      const struct i40e_fdir_filter *filter,
 		      enum i40e_filter_pctype pctype,
@@ -1544,7 +1366,7 @@ i40e_fdir_flex_store(struct i40e_pf *pf,
 }
 
 /* Validate an input set against what earlier filters on this pctype established */
-static int
+int
 i40e_fdir_inset_check(struct i40e_pf *pf,
 		      enum i40e_filter_pctype pctype,
 		      uint64_t input_set)
@@ -1628,9 +1450,8 @@ i40e_fdir_inset_program(struct i40e_pf *pf,
 }
 
 static inline unsigned char *
-i40e_find_available_buffer(struct rte_eth_dev *dev)
+i40e_find_available_buffer(struct i40e_pf *pf)
 {
-	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	struct i40e_fdir_info *fdir_info = &pf->fdir;
 	struct ci_tx_queue *txq = pf->fdir.txq;
 
@@ -1666,7 +1487,7 @@ i40e_find_available_buffer(struct rte_eth_dev *dev)
 	return (unsigned char *)fdir_info->prg_pkt[txq->tx_tail >> 1];
 }
 
-static enum i40e_filter_pctype
+enum i40e_filter_pctype
 i40e_fdir_filter_pctype(const struct i40e_fdir_filter *filter)
 {
 	if (filter->input.flow_ext.pkt_template)
@@ -1691,7 +1512,7 @@ i40e_fdir_filter_needs_status_wait(const struct i40e_pf *pf,
  * Only inspects the filter itself; conflicts against already registered
  * filters are detected by i40e_fdir_filter_register().
  */
-int
+static int
 i40e_fdir_filter_validate(struct rte_eth_dev *dev,
 			  const struct i40e_fdir_filter *filter)
 {
@@ -1719,111 +1540,14 @@ i40e_fdir_filter_validate(struct rte_eth_dev *dev,
 	return 0;
 }
 
-/**
- * Records the filter and everything derived from it.
- */
-int
-i40e_fdir_filter_register(struct rte_eth_dev *dev,
-			  const struct i40e_fdir_filter *filter,
-			  struct i40e_fdir_filter **node)
-{
-	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-	enum i40e_filter_pctype pctype = i40e_fdir_filter_pctype(filter);
-	uint64_t input_set = filter->input.flow_ext.input_set;
-	struct i40e_fdir_flow_store *flows = &pf->fdir.flows;
-	struct i40e_fdir_pctype_state *state = &flows->pctype[pctype];
-	struct i40e_fdir_layer_state *layer = NULL;
-	struct i40e_fdir_flex_mask flex_mask;
-	bool common_pctype;
-	int ret;
-
-	ret = i40e_fdir_engine_init(dev);
-	if (ret < 0)
-		return ret;
-
-	/* check input set if the packet type is common */
-	common_pctype = !filter->input.flow_ext.customized_pctype;
-
-	if (common_pctype) {
-		ret = i40e_fdir_inset_check(pf, pctype, input_set);
-		if (ret < 0)
-			return ret;
-	}
-
-	/* check if flex flow configuration is valid */
-	if (filter->input.flow_ext.is_flex_flow) {
-		ret = i40e_fdir_flex_check(pf, filter, pctype, &flex_mask);
-		if (ret < 0)
-			return ret;
-	}
-
-	/* register the flow with the hash table */
-	ret = i40e_fdir_filter_hash_add(pf, filter, node);
-	if (ret < 0) {
-		PMD_DRV_LOG(ERR, "Conflict with existing flow director rules!");
-		return ret;
-	}
-
-	/* save additional configuration */
-	if (common_pctype)
-		state->input_set = input_set;
-
-	if (filter->input.flow_ext.is_flex_flow) {
-		i40e_fdir_flex_store(pf, filter, pctype, &flex_mask);
-		layer = &flows->layer[filter->input.flow_ext.layer_idx];
-		layer->flex_flow_count++;
-		layer->flex_pit_flag = true;
-		state->flex_mask_flag = true;
-	}
-
-	state->flow_count++;
-	pf->fdir.fdir_actual_cnt++;
-
-	i40e_fdir_rx_proc_sync(dev);
-
-	return 0;
-}
-
-/**
- * i40e_fdir_filter_unregister - drop software ownership of a filter.
- */
-int
-i40e_fdir_filter_unregister(struct rte_eth_dev *dev,
-			    struct i40e_fdir_filter *node)
-{
-	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-	enum i40e_filter_pctype pctype = i40e_fdir_filter_pctype(node);
-	enum i40e_flxpld_layer_idx layer_idx = node->input.flow_ext.layer_idx;
-	bool is_flex_flow = node->input.flow_ext.is_flex_flow;
-	struct i40e_fdir_flow_store *flows = &pf->fdir.flows;
-	struct i40e_fdir_pctype_state *state = &flows->pctype[pctype];
-	struct i40e_fdir_layer_state *layer = &flows->layer[layer_idx];
-	int ret;
-
-	ret = i40e_fdir_filter_hash_del(pf, node);
-	if (ret < 0)
-		return ret;
-
-	if (is_flex_flow && --layer->flex_flow_count == 0)
-		layer->flex_pit_flag = false;
-
-	if (--state->flow_count == 0)
-		state->flex_mask_flag = false;
-
-	pf->fdir.fdir_actual_cnt--;
-
-	i40e_fdir_rx_proc_sync(dev);
-
-	return 0;
-}
-
 /* Take software ownership of a packet template filter, owning its packet */
 static int
 i40e_fdir_tmpl_register(struct rte_eth_dev *dev,
 			const struct i40e_fdir_filter *filter,
 			struct i40e_fdir_tmpl_filter **node)
 {
-	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct rte_eth_dev_data *dev_data = dev->data;
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev_data->dev_private);
 	const struct i40e_raw_flow *raw = &filter->input.flow.raw_flow;
 	struct i40e_fdir_info *fdir_info = &pf->fdir;
 	struct i40e_fdir_tmpl_filter *tmpl;
@@ -1831,7 +1555,7 @@ i40e_fdir_tmpl_register(struct rte_eth_dev *dev,
 	uint8_t *packet;
 	int ret;
 
-	ret = i40e_fdir_engine_init(dev);
+	ret = i40e_fdir_engine_init(pf);
 	if (ret < 0)
 		return ret;
 
@@ -1869,7 +1593,7 @@ i40e_fdir_tmpl_register(struct rte_eth_dev *dev,
 
 	fdir_info->fdir_actual_cnt++;
 
-	i40e_fdir_rx_proc_sync(dev);
+	i40e_fdir_rx_proc_sync(dev_data);
 
 	*node = tmpl;
 
@@ -1902,7 +1626,7 @@ i40e_fdir_tmpl_unregister(struct rte_eth_dev *dev,
 
 	fdir_info->fdir_actual_cnt--;
 
-	i40e_fdir_rx_proc_sync(dev);
+	i40e_fdir_rx_proc_sync(dev->data);
 
 	return 0;
 }
@@ -1915,12 +1639,11 @@ i40e_fdir_tmpl_unregister(struct rte_eth_dev *dev,
  * filter. The caller is responsible for having validated and registered it.
  */
 int
-i40e_fdir_filter_program(struct rte_eth_dev *dev,
+i40e_fdir_filter_program(struct i40e_pf *pf,
 			 const struct i40e_fdir_filter *filter,
 			 bool add, bool wait_status)
 {
-	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
 	enum i40e_filter_pctype pctype = i40e_fdir_filter_pctype(filter);
 	unsigned char *pkt;
 	int ret;
@@ -1947,7 +1670,7 @@ i40e_fdir_filter_program(struct rte_eth_dev *dev,
 		}
 	}
 
-	pkt = i40e_find_available_buffer(dev);
+	pkt = i40e_find_available_buffer(pf);
 	if (pkt == NULL) {
 		PMD_DRV_LOG(ERR, "No buffer available to program fdir filter.");
 		return -ENOSPC;
@@ -2007,7 +1730,7 @@ i40e_fdir_tmpl_add_del(struct rte_eth_dev *dev,
 		if (ret < 0)
 			return ret;
 
-		ret = i40e_fdir_filter_program(dev, &node->fdir, true,
+		ret = i40e_fdir_filter_program(pf, &node->fdir, true,
 				i40e_fdir_filter_needs_status_wait(pf, cnt));
 		if (ret < 0) {
 			i40e_fdir_tmpl_unregister(dev, node);
@@ -2026,7 +1749,7 @@ i40e_fdir_tmpl_add_del(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
-	ret = i40e_fdir_filter_program(dev, &node->fdir, false, false);
+	ret = i40e_fdir_filter_program(pf, &node->fdir, false, false);
 	if (ret < 0)
 		return ret;
 
@@ -2187,9 +1910,8 @@ i40e_flow_fdir_filter_programming(struct i40e_pf *pf,
  * @pf: board private structure
  */
 int
-i40e_fdir_flush(struct rte_eth_dev *dev)
+i40e_fdir_flush(struct i40e_pf *pf)
 {
-	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
 	uint32_t reg;
 	uint16_t guarant_cnt, best_cnt;
@@ -2372,28 +2094,15 @@ i40e_fdir_filter_restore(struct i40e_pf *pf)
 {
 	struct rte_eth_dev *dev = I40E_VSI_TO_ETH_DEV(pf->main_vsi);
 	struct i40e_fdir_tmpl_filter *tmpl;
-	struct rte_flow *flow;
 	int ret;
 
-	i40e_fdir_rx_proc_sync(dev);
+	i40e_fdir_rx_proc_sync(dev->data);
 
 	if (pf->fdir.fdir_vsi == NULL)
 		return;
 
-	TAILQ_FOREACH(flow, &pf->flow_list, node) {
-		struct i40e_fdir_filter *node = flow->rule;
-
-		if (flow->filter_type != RTE_ETH_FILTER_FDIR)
-			continue;
-
-		ret = i40e_fdir_filter_program(dev, node, true, false);
-		if (ret < 0)
-			PMD_DRV_LOG(ERR,
-				    "Failed to restore flow director filter: %d", ret);
-	}
-
 	TAILQ_FOREACH(tmpl, &pf->fdir.tmpls.list, rules) {
-		ret = i40e_fdir_filter_program(dev, &tmpl->fdir, true, false);
+		ret = i40e_fdir_filter_program(pf, &tmpl->fdir, true, false);
 		if (ret < 0)
 			PMD_DRV_LOG(ERR,
 				    "Failed to restore flow director template: %d", ret);
diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 200de80863..104749eb8c 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -33,14 +33,10 @@
 const struct ci_flow_engine_list i40e_flow_engine_list = {
 	{
 		&i40e_flow_engine_ethertype,
+		&i40e_flow_engine_fdir,
 	}
 };
 
-#define I40E_IPV6_TC_MASK	(0xFF << I40E_FDIR_IPv6_TC_OFFSET)
-#define I40E_IPV6_FRAG_HEADER	44
-#define I40E_TENANT_ARRAY_NUM	3
-#define I40E_VLAN_TCI_MASK	0xFFFF
-
 static int i40e_flow_validate(struct rte_eth_dev *dev,
 			      const struct rte_flow_attr *attr,
 			      const struct rte_flow_item pattern[],
@@ -64,23 +60,10 @@ static int i40e_flow_dev_dump(struct rte_eth_dev *dev,
 			      struct rte_flow *flow,
 			      FILE *file,
 			      struct rte_flow_error *error);
-static int i40e_flow_parse_fdir_pattern(struct rte_eth_dev *dev,
-					const struct rte_flow_item *pattern,
-					struct rte_flow_error *error,
-					struct i40e_fdir_filter *filter);
-static int i40e_flow_parse_fdir_action(struct rte_eth_dev *dev,
-				       const struct rte_flow_action *actions,
-				       struct rte_flow_error *error,
-				       struct i40e_fdir_filter *filter);
 static int i40e_flow_parse_tunnel_action(struct rte_eth_dev *dev,
 				 const struct rte_flow_action *actions,
 				 struct rte_flow_error *error,
 				 struct i40e_tunnel_filter_conf *filter);
-static int i40e_flow_parse_fdir_filter(struct rte_eth_dev *dev,
-				       const struct rte_flow_item pattern[],
-				       const struct rte_flow_action actions[],
-				       struct rte_flow_error *error,
-				       struct i40e_filter_ctx *filter);
 static int i40e_flow_parse_vxlan_filter(struct rte_eth_dev *dev,
 					const struct rte_flow_item pattern[],
 					const struct rte_flow_action actions[],
@@ -103,7 +86,6 @@ static int i40e_flow_parse_gtp_filter(struct rte_eth_dev *dev,
 				      struct i40e_filter_ctx *filter);
 static int i40e_flow_destroy_tunnel_filter(struct i40e_pf *pf,
 					   struct i40e_tunnel_filter *filter);
-static int i40e_flow_flush_fdir_filter(struct i40e_pf *pf);
 static int i40e_flow_flush_tunnel_filter(struct i40e_pf *pf);
 static int
 i40e_flow_parse_qinq_filter(struct rte_eth_dev *dev,
@@ -131,19 +113,6 @@ const struct rte_flow_ops i40e_flow_ops = {
 	.dev_dump = i40e_flow_dev_dump,
 };
 
-/* Pattern matched ethertype filter */
-static enum rte_flow_item_type pattern_ethertype[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-/* Pattern matched flow director filter */
-static enum rte_flow_item_type pattern_fdir_ipv4[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
 static enum rte_flow_item_type pattern_fdir_ipv4_udp[] = {
 	RTE_FLOW_ITEM_TYPE_ETH,
 	RTE_FLOW_ITEM_TYPE_IPV4,
@@ -181,30 +150,6 @@ static enum rte_flow_item_type pattern_fdir_ipv4_gtpu[] = {
 	RTE_FLOW_ITEM_TYPE_END,
 };
 
-static enum rte_flow_item_type pattern_fdir_ipv4_gtpu_ipv4[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_GTPU,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv4_gtpu_ipv6[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_GTPU,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv6[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
 static enum rte_flow_item_type pattern_fdir_ipv6_udp[] = {
 	RTE_FLOW_ITEM_TYPE_ETH,
 	RTE_FLOW_ITEM_TYPE_IPV6,
@@ -242,581 +187,6 @@ static enum rte_flow_item_type pattern_fdir_ipv6_gtpu[] = {
 	RTE_FLOW_ITEM_TYPE_END,
 };
 
-static enum rte_flow_item_type pattern_fdir_ipv6_gtpu_ipv4[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_GTPU,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv6_gtpu_ipv6[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_GTPU,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ethertype_raw_1[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ethertype_raw_2[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ethertype_raw_3[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv4_raw_1[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv4_raw_2[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv4_raw_3[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv4_udp_raw_1[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv4_udp_raw_2[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv4_udp_raw_3[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv4_tcp_raw_1[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_TCP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv4_tcp_raw_2[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_TCP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv4_tcp_raw_3[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_TCP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv4_sctp_raw_1[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_SCTP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv4_sctp_raw_2[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_SCTP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv4_sctp_raw_3[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_SCTP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv6_raw_1[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv6_raw_2[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv6_raw_3[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv6_udp_raw_1[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv6_udp_raw_2[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv6_udp_raw_3[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv6_tcp_raw_1[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_TCP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv6_tcp_raw_2[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_TCP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv6_tcp_raw_3[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_TCP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv6_sctp_raw_1[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_SCTP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv6_sctp_raw_2[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_SCTP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv6_sctp_raw_3[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_SCTP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ethertype_vlan[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv4[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv4_udp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv4_tcp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_TCP,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv4_sctp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_SCTP,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv6[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv6_udp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv6_tcp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_TCP,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv6_sctp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_SCTP,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ethertype_vlan_raw_1[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ethertype_vlan_raw_2[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ethertype_vlan_raw_3[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv4_raw_1[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv4_raw_2[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv4_raw_3[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv4_udp_raw_1[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv4_udp_raw_2[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv4_udp_raw_3[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv4_tcp_raw_1[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_TCP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv4_tcp_raw_2[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_TCP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv4_tcp_raw_3[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_TCP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv4_sctp_raw_1[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_SCTP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv4_sctp_raw_2[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_SCTP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv4_sctp_raw_3[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_SCTP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv6_raw_1[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv6_raw_2[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv6_raw_3[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv6_udp_raw_1[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv6_udp_raw_2[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv6_udp_raw_3[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv6_tcp_raw_1[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_TCP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv6_tcp_raw_2[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_TCP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv6_tcp_raw_3[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_TCP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv6_sctp_raw_1[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_SCTP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv6_sctp_raw_2[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_SCTP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_vlan_ipv6_sctp_raw_3[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_VLAN,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_SCTP,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_RAW,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
 /* Pattern matched tunnel filter */
 static enum rte_flow_item_type pattern_vxlan_1[] = {
 	RTE_FLOW_ITEM_TYPE_ETH,
@@ -929,138 +299,7 @@ static enum rte_flow_item_type pattern_qinq_1[] = {
 	RTE_FLOW_ITEM_TYPE_END,
 };
 
-static enum rte_flow_item_type pattern_fdir_ipv4_l2tpv3oip[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_L2TPV3OIP,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv6_l2tpv3oip[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_L2TPV3OIP,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv4_esp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_ESP,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv6_esp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_ESP,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv4_udp_esp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_ESP,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-static enum rte_flow_item_type pattern_fdir_ipv6_udp_esp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_ESP,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
 static struct i40e_valid_pattern i40e_supported_patterns[] = {
-	/* FDIR - support default flow type without flexible payload*/
-	{ pattern_ethertype, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv4, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv4_udp, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv4_tcp, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv4_sctp, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv4_gtpc, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv4_gtpu, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv4_gtpu_ipv4, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv4_gtpu_ipv6, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv4_esp, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv4_udp_esp, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv6, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv6_udp, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv6_tcp, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv6_sctp, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv6_gtpc, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv6_gtpu, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv6_gtpu_ipv4, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv6_gtpu_ipv6, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv6_esp, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv6_udp_esp, i40e_flow_parse_fdir_filter },
-	/* FDIR - support default flow type with flexible payload */
-	{ pattern_fdir_ethertype_raw_1, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ethertype_raw_2, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ethertype_raw_3, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv4_raw_1, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv4_raw_2, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv4_raw_3, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv4_udp_raw_1, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv4_udp_raw_2, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv4_udp_raw_3, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv4_tcp_raw_1, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv4_tcp_raw_2, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv4_tcp_raw_3, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv4_sctp_raw_1, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv4_sctp_raw_2, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv4_sctp_raw_3, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv6_raw_1, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv6_raw_2, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv6_raw_3, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv6_udp_raw_1, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv6_udp_raw_2, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv6_udp_raw_3, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv6_tcp_raw_1, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv6_tcp_raw_2, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv6_tcp_raw_3, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv6_sctp_raw_1, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv6_sctp_raw_2, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv6_sctp_raw_3, i40e_flow_parse_fdir_filter },
-	/* FDIR - support single vlan input set */
-	{ pattern_fdir_ethertype_vlan, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv4, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv4_udp, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv4_tcp, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv4_sctp, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv6, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv6_udp, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv6_tcp, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv6_sctp, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ethertype_vlan_raw_1, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ethertype_vlan_raw_2, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ethertype_vlan_raw_3, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv4_raw_1, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv4_raw_2, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv4_raw_3, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv4_udp_raw_1, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv4_udp_raw_2, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv4_udp_raw_3, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv4_tcp_raw_1, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv4_tcp_raw_2, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv4_tcp_raw_3, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv4_sctp_raw_1, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv4_sctp_raw_2, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv4_sctp_raw_3, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv6_raw_1, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv6_raw_2, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv6_raw_3, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv6_udp_raw_1, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv6_udp_raw_2, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv6_udp_raw_3, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv6_tcp_raw_1, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv6_tcp_raw_2, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv6_tcp_raw_3, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv6_sctp_raw_1, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv6_sctp_raw_2, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_vlan_ipv6_sctp_raw_3, i40e_flow_parse_fdir_filter },
 	/* VXLAN */
 	{ pattern_vxlan_1, i40e_flow_parse_vxlan_filter },
 	{ pattern_vxlan_2, i40e_flow_parse_vxlan_filter },
@@ -1083,9 +322,6 @@ static struct i40e_valid_pattern i40e_supported_patterns[] = {
 	{ pattern_fdir_ipv6_gtpu, i40e_flow_parse_gtp_filter },
 	/* QINQ */
 	{ pattern_qinq_1, i40e_flow_parse_qinq_filter },
-	/* L2TPv3 over IP */
-	{ pattern_fdir_ipv4_l2tpv3oip, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv6_l2tpv3oip, i40e_flow_parse_fdir_filter },
 	/* L4 over port */
 	{ pattern_fdir_ipv4_udp, i40e_flow_parse_l4_cloud_filter },
 	{ pattern_fdir_ipv4_tcp, i40e_flow_parse_l4_cloud_filter },
@@ -1191,8 +427,6 @@ static const char *
 i40e_flow_rule_name(enum rte_filter_type filter_type)
 {
 	switch (filter_type) {
-	case RTE_ETH_FILTER_FDIR:
-		return "fdir";
 	case RTE_ETH_FILTER_TUNNEL:
 		return "tunnel";
 	case RTE_ETH_FILTER_HASH:
@@ -1206,8 +440,6 @@ static size_t
 i40e_flow_rule_size(enum rte_filter_type filter_type)
 {
 	switch (filter_type) {
-	case RTE_ETH_FILTER_FDIR:
-		return sizeof(struct i40e_fdir_filter);
 	case RTE_ETH_FILTER_TUNNEL:
 		return sizeof(struct i40e_tunnel_filter);
 	case RTE_ETH_FILTER_HASH:
@@ -1332,47 +564,7 @@ i40e_get_outer_vlan(struct i40e_pf *pf, uint16_t *tpid)
 	return 0;
 }
 
-static int
-i40e_flow_check_raw_item(const struct rte_flow_item *item,
-			 const struct rte_flow_item_raw *raw_spec,
-			 struct rte_flow_error *error)
-{
-	if (!raw_spec->relative) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ITEM,
-				   item,
-				   "Relative should be 1.");
-		return -rte_errno;
-	}
-
-	if (raw_spec->offset % sizeof(uint16_t)) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ITEM,
-				   item,
-				   "Offset should be even.");
-		return -rte_errno;
-	}
-
-	if (raw_spec->search || raw_spec->limit) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ITEM,
-				   item,
-				   "search or limit is not supported.");
-		return -rte_errno;
-	}
-
-	if (raw_spec->offset < 0) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ITEM,
-				   item,
-				   "Offset should be non-negative.");
-		return -rte_errno;
-	}
-	return 0;
-}
-
-
-static uint8_t
+uint8_t
 i40e_flow_fdir_get_pctype_value(struct i40e_pf *pf,
 				enum rte_flow_item_type item_type,
 				struct i40e_fdir_filter *filter)
@@ -1439,1013 +631,6 @@ i40e_flow_fdir_get_pctype_value(struct i40e_pf *pf,
 	return I40E_FILTER_PCTYPE_INVALID;
 }
 
-static void
-i40e_flow_set_filter_spi(struct i40e_fdir_filter *filter,
-	const struct rte_flow_item_esp *esp_spec)
-{
-	if (filter->input.flow_ext.oip_type ==
-		I40E_FDIR_IPTYPE_IPV4) {
-		if (filter->input.flow_ext.is_udp)
-			filter->input.flow.esp_ipv4_udp_flow.spi =
-				esp_spec->hdr.spi;
-		else
-			filter->input.flow.esp_ipv4_flow.spi =
-				esp_spec->hdr.spi;
-	}
-	if (filter->input.flow_ext.oip_type ==
-		I40E_FDIR_IPTYPE_IPV6) {
-		if (filter->input.flow_ext.is_udp)
-			filter->input.flow.esp_ipv6_udp_flow.spi =
-				esp_spec->hdr.spi;
-		else
-			filter->input.flow.esp_ipv6_flow.spi =
-				esp_spec->hdr.spi;
-	}
-}
-
-/* 1. Last in item should be NULL as range is not supported.
- * 2. Supported patterns: refer to array i40e_supported_patterns.
- * 3. Default supported flow type and input set: refer to array
- *    valid_fdir_inset_table in i40e_ethdev.c.
- * 4. Mask of fields which need to be matched should be
- *    filled with 1.
- * 5. Mask of fields which needn't to be matched should be
- *    filled with 0.
- * 6. GTP profile supports GTPv1 only.
- * 7. GTP-C response message ('source_port' = 2123) is not supported.
- */
-static int
-i40e_flow_parse_fdir_pattern(struct rte_eth_dev *dev,
-			     const struct rte_flow_item *pattern,
-			     struct rte_flow_error *error,
-			     struct i40e_fdir_filter *filter)
-{
-	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-	const struct rte_flow_item *item = pattern;
-	const struct rte_flow_item_eth *eth_spec, *eth_mask;
-	const struct rte_flow_item_vlan *vlan_spec, *vlan_mask;
-	const struct rte_flow_item_ipv4 *ipv4_spec, *ipv4_last, *ipv4_mask;
-	const struct rte_flow_item_ipv6 *ipv6_spec, *ipv6_mask;
-	const struct rte_flow_item_tcp *tcp_spec, *tcp_mask;
-	const struct rte_flow_item_udp *udp_spec, *udp_mask;
-	const struct rte_flow_item_sctp *sctp_spec, *sctp_mask;
-	const struct rte_flow_item_gtp *gtp_spec, *gtp_mask;
-	const struct rte_flow_item_esp *esp_spec, *esp_mask;
-	const struct rte_flow_item_raw *raw_spec, *raw_mask;
-	const struct rte_flow_item_l2tpv3oip *l2tpv3oip_spec, *l2tpv3oip_mask;
-
-	uint8_t pctype = 0;
-	uint64_t input_set = I40E_INSET_NONE;
-	enum rte_flow_item_type item_type;
-	enum rte_flow_item_type next_type;
-	enum rte_flow_item_type l3 = RTE_FLOW_ITEM_TYPE_END;
-	enum rte_flow_item_type cus_proto = RTE_FLOW_ITEM_TYPE_END;
-	uint32_t i, j;
-	uint8_t  ipv6_addr_mask[16] = {
-		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
-		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
-	enum i40e_flxpld_layer_idx layer_idx = I40E_FLXPLD_L2_IDX;
-	uint8_t raw_id = 0;
-	int32_t off_arr[I40E_MAX_FLXPLD_FIED];
-	uint16_t len_arr[I40E_MAX_FLXPLD_FIED];
-	struct i40e_fdir_flex_pit flex_pit;
-	uint8_t next_dst_off = 0;
-	uint16_t flex_size;
-	uint16_t ether_type;
-	uint32_t vtc_flow_cpu;
-	bool outer_ip = true;
-	uint8_t field_idx;
-	int ret;
-	uint16_t tpid;
-
-	memset(off_arr, 0, sizeof(off_arr));
-	memset(len_arr, 0, sizeof(len_arr));
-	filter->input.flow_ext.customized_pctype = false;
-	for (; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
-		if (item->last && item->type != RTE_FLOW_ITEM_TYPE_IPV4) {
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
-			next_type = (item + 1)->type;
-
-			if (next_type == RTE_FLOW_ITEM_TYPE_END &&
-						(!eth_spec || !eth_mask)) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "NULL eth spec/mask.");
-				return -rte_errno;
-			}
-
-			if (eth_spec && eth_mask) {
-				if (rte_is_broadcast_ether_addr(&eth_mask->hdr.dst_addr) &&
-					rte_is_zero_ether_addr(&eth_mask->hdr.src_addr)) {
-					filter->input.flow.l2_flow.dst =
-						eth_spec->hdr.dst_addr;
-					input_set |= I40E_INSET_DMAC;
-				} else if (rte_is_zero_ether_addr(&eth_mask->hdr.dst_addr) &&
-					rte_is_broadcast_ether_addr(&eth_mask->hdr.src_addr)) {
-					filter->input.flow.l2_flow.src =
-						eth_spec->hdr.src_addr;
-					input_set |= I40E_INSET_SMAC;
-				} else if (rte_is_broadcast_ether_addr(&eth_mask->hdr.dst_addr) &&
-					rte_is_broadcast_ether_addr(&eth_mask->hdr.src_addr)) {
-					filter->input.flow.l2_flow.dst =
-						eth_spec->hdr.dst_addr;
-					filter->input.flow.l2_flow.src =
-						eth_spec->hdr.src_addr;
-					input_set |= (I40E_INSET_DMAC | I40E_INSET_SMAC);
-				} else if (!rte_is_zero_ether_addr(&eth_mask->hdr.src_addr) ||
-					   !rte_is_zero_ether_addr(&eth_mask->hdr.dst_addr)) {
-					rte_flow_error_set(error, EINVAL,
-						      RTE_FLOW_ERROR_TYPE_ITEM,
-						      item,
-						      "Invalid MAC_addr mask.");
-					return -rte_errno;
-				}
-			}
-			if (eth_spec && eth_mask &&
-			next_type == RTE_FLOW_ITEM_TYPE_END) {
-				if (eth_mask->hdr.ether_type != RTE_BE16(0xffff)) {
-					rte_flow_error_set(error, EINVAL,
-						      RTE_FLOW_ERROR_TYPE_ITEM,
-						      item,
-						      "Invalid type mask.");
-					return -rte_errno;
-				}
-
-				ether_type = rte_be_to_cpu_16(eth_spec->hdr.ether_type);
-
-				if (ether_type == RTE_ETHER_TYPE_IPV4 ||
-				    ether_type == RTE_ETHER_TYPE_IPV6) {
-					rte_flow_error_set(error, EINVAL,
-						     RTE_FLOW_ERROR_TYPE_ITEM,
-						     item,
-						     "Unsupported ether_type.");
-					return -rte_errno;
-				}
-				ret = i40e_get_outer_vlan(pf, &tpid);
-				if (ret != 0) {
-					rte_flow_error_set(error, EIO,
-							RTE_FLOW_ERROR_TYPE_ITEM,
-							item,
-							"Can not get the Ethertype identifying the L2 tag");
-					return -rte_errno;
-				}
-				if (ether_type == tpid) {
-					rte_flow_error_set(error, EINVAL,
-						     RTE_FLOW_ERROR_TYPE_ITEM,
-						     item,
-						     "Unsupported ether_type.");
-					return -rte_errno;
-				}
-
-				input_set |= I40E_INSET_LAST_ETHER_TYPE;
-				filter->input.flow.l2_flow.ether_type =
-					eth_spec->hdr.ether_type;
-			}
-
-			pctype = I40E_FILTER_PCTYPE_L2_PAYLOAD;
-			layer_idx = I40E_FLXPLD_L2_IDX;
-
-			break;
-		case RTE_FLOW_ITEM_TYPE_VLAN:
-			vlan_spec = item->spec;
-			vlan_mask = item->mask;
-
-			RTE_ASSERT(!(input_set & I40E_INSET_LAST_ETHER_TYPE));
-			if (vlan_spec && vlan_mask) {
-				if (vlan_mask->hdr.vlan_tci != 0 &&
-				    vlan_mask->hdr.vlan_tci !=
-				    rte_cpu_to_be_16(I40E_VLAN_TCI_MASK)) {
-					rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Unsupported TCI mask.");
-					return -rte_errno;
-				}
-				if (vlan_mask->hdr.vlan_tci != 0) {
-					input_set |= I40E_INSET_VLAN_INNER;
-					filter->input.flow_ext.vlan_tci = vlan_spec->hdr.vlan_tci;
-				}
-			}
-			if (vlan_spec && vlan_mask && vlan_mask->hdr.eth_proto) {
-				if (vlan_mask->hdr.eth_proto != RTE_BE16(0xffff)) {
-					rte_flow_error_set(error, EINVAL,
-						      RTE_FLOW_ERROR_TYPE_ITEM,
-						      item,
-						      "Invalid inner_type"
-						      " mask.");
-					return -rte_errno;
-				}
-
-				ether_type =
-					rte_be_to_cpu_16(vlan_spec->hdr.eth_proto);
-
-				if (ether_type == RTE_ETHER_TYPE_IPV4 ||
-				    ether_type == RTE_ETHER_TYPE_IPV6) {
-					rte_flow_error_set(error, EINVAL,
-						     RTE_FLOW_ERROR_TYPE_ITEM,
-						     item,
-						     "Unsupported inner_type.");
-					return -rte_errno;
-				}
-				ret = i40e_get_outer_vlan(pf, &tpid);
-				if (ret != 0) {
-					rte_flow_error_set(error, EIO,
-							RTE_FLOW_ERROR_TYPE_ITEM,
-							item,
-							"Can not get the Ethertype identifying the L2 tag");
-					return -rte_errno;
-				}
-				if (ether_type == tpid) {
-					rte_flow_error_set(error, EINVAL,
-						     RTE_FLOW_ERROR_TYPE_ITEM,
-						     item,
-						     "Unsupported ether_type.");
-					return -rte_errno;
-				}
-
-				input_set |= I40E_INSET_LAST_ETHER_TYPE;
-				filter->input.flow.l2_flow.ether_type =
-					vlan_spec->hdr.eth_proto;
-			}
-
-			pctype = I40E_FILTER_PCTYPE_L2_PAYLOAD;
-			layer_idx = I40E_FLXPLD_L2_IDX;
-
-			break;
-		case RTE_FLOW_ITEM_TYPE_IPV4:
-			l3 = RTE_FLOW_ITEM_TYPE_IPV4;
-			ipv4_spec = item->spec;
-			ipv4_mask = item->mask;
-			ipv4_last = item->last;
-			pctype = I40E_FILTER_PCTYPE_NONF_IPV4_OTHER;
-			layer_idx = I40E_FLXPLD_L3_IDX;
-
-			if (ipv4_last) {
-				if (!ipv4_spec || !ipv4_mask || !outer_ip) {
-					rte_flow_error_set(error, EINVAL,
-						RTE_FLOW_ERROR_TYPE_ITEM,
-						item,
-						"Not support range");
-					return -rte_errno;
-				}
-				/* Only fragment_offset supports range */
-				if (ipv4_last->hdr.version_ihl ||
-				    ipv4_last->hdr.type_of_service ||
-				    ipv4_last->hdr.total_length ||
-				    ipv4_last->hdr.packet_id ||
-				    ipv4_last->hdr.time_to_live ||
-				    ipv4_last->hdr.next_proto_id ||
-				    ipv4_last->hdr.hdr_checksum ||
-				    ipv4_last->hdr.src_addr ||
-				    ipv4_last->hdr.dst_addr) {
-					rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Not support range");
-					return -rte_errno;
-				}
-			}
-			if (ipv4_spec && ipv4_mask && outer_ip) {
-				/* Check IPv4 mask and update input set */
-				if (ipv4_mask->hdr.version_ihl ||
-				    ipv4_mask->hdr.total_length ||
-				    ipv4_mask->hdr.packet_id ||
-				    ipv4_mask->hdr.hdr_checksum) {
-					rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid IPv4 mask.");
-					return -rte_errno;
-				}
-
-				if (ipv4_mask->hdr.src_addr == UINT32_MAX)
-					input_set |= I40E_INSET_IPV4_SRC;
-				if (ipv4_mask->hdr.dst_addr == UINT32_MAX)
-					input_set |= I40E_INSET_IPV4_DST;
-				if (ipv4_mask->hdr.type_of_service == UINT8_MAX)
-					input_set |= I40E_INSET_IPV4_TOS;
-				if (ipv4_mask->hdr.time_to_live == UINT8_MAX)
-					input_set |= I40E_INSET_IPV4_TTL;
-				if (ipv4_mask->hdr.next_proto_id == UINT8_MAX)
-					input_set |= I40E_INSET_IPV4_PROTO;
-
-				/* Check if it is fragment. */
-				uint16_t frag_mask =
-					ipv4_mask->hdr.fragment_offset;
-				uint16_t frag_spec =
-					ipv4_spec->hdr.fragment_offset;
-				uint16_t frag_last = 0;
-				if (ipv4_last)
-					frag_last =
-					ipv4_last->hdr.fragment_offset;
-				if (frag_mask) {
-					frag_mask = rte_be_to_cpu_16(frag_mask);
-					frag_spec = rte_be_to_cpu_16(frag_spec);
-					frag_last = rte_be_to_cpu_16(frag_last);
-					/* frag_off mask has to be 0x3fff */
-					if (frag_mask !=
-					    (RTE_IPV4_HDR_OFFSET_MASK |
-					    RTE_IPV4_HDR_MF_FLAG)) {
-						rte_flow_error_set(error,
-						   EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid IPv4 fragment_offset mask");
-						return -rte_errno;
-					}
-					/*
-					 * non-frag rule:
-					 * mask=0x3fff,spec=0
-					 * frag rule:
-					 * mask=0x3fff,spec=0x8,last=0x2000
-					 */
-					if (frag_spec ==
-					    (1 << RTE_IPV4_HDR_FO_SHIFT) &&
-					    frag_last == RTE_IPV4_HDR_MF_FLAG) {
-						pctype =
-						  I40E_FILTER_PCTYPE_FRAG_IPV4;
-					} else if (frag_spec || frag_last) {
-						rte_flow_error_set(error,
-						   EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid IPv4 fragment_offset rule");
-						return -rte_errno;
-					}
-				} else if (frag_spec || frag_last) {
-					rte_flow_error_set(error,
-						EINVAL,
-						RTE_FLOW_ERROR_TYPE_ITEM,
-						item,
-						"Invalid fragment_offset");
-					return -rte_errno;
-				}
-
-				if (input_set & (I40E_INSET_DMAC | I40E_INSET_SMAC)) {
-					if (input_set & (I40E_INSET_IPV4_SRC |
-						I40E_INSET_IPV4_DST | I40E_INSET_IPV4_TOS |
-						I40E_INSET_IPV4_TTL | I40E_INSET_IPV4_PROTO)) {
-						rte_flow_error_set(error, EINVAL,
-							RTE_FLOW_ERROR_TYPE_ITEM,
-							item,
-							"L2 and L3 input set are exclusive.");
-						return -rte_errno;
-					}
-				} else {
-					/* Get the filter info */
-					filter->input.flow.ip4_flow.proto =
-						ipv4_spec->hdr.next_proto_id;
-					filter->input.flow.ip4_flow.tos =
-						ipv4_spec->hdr.type_of_service;
-					filter->input.flow.ip4_flow.ttl =
-						ipv4_spec->hdr.time_to_live;
-					filter->input.flow.ip4_flow.src_ip =
-						ipv4_spec->hdr.src_addr;
-					filter->input.flow.ip4_flow.dst_ip =
-						ipv4_spec->hdr.dst_addr;
-
-					filter->input.flow_ext.inner_ip = false;
-					filter->input.flow_ext.oip_type =
-						I40E_FDIR_IPTYPE_IPV4;
-				}
-			} else if (!ipv4_spec && !ipv4_mask && !outer_ip) {
-				filter->input.flow_ext.inner_ip = true;
-				filter->input.flow_ext.iip_type =
-					I40E_FDIR_IPTYPE_IPV4;
-			} else if (!ipv4_spec && !ipv4_mask && outer_ip) {
-				filter->input.flow_ext.inner_ip = false;
-				filter->input.flow_ext.oip_type =
-					I40E_FDIR_IPTYPE_IPV4;
-			} else if ((ipv4_spec || ipv4_mask) && !outer_ip) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid inner IPv4 mask.");
-				return -rte_errno;
-			}
-
-			if (outer_ip)
-				outer_ip = false;
-
-			break;
-		case RTE_FLOW_ITEM_TYPE_IPV6:
-			l3 = RTE_FLOW_ITEM_TYPE_IPV6;
-			ipv6_spec = item->spec;
-			ipv6_mask = item->mask;
-			pctype = I40E_FILTER_PCTYPE_NONF_IPV6_OTHER;
-			layer_idx = I40E_FLXPLD_L3_IDX;
-
-			if (ipv6_spec && ipv6_mask && outer_ip) {
-				/* Check IPv6 mask and update input set */
-				if (ipv6_mask->hdr.payload_len) {
-					rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid IPv6 mask");
-					return -rte_errno;
-				}
-
-				if (!memcmp(&ipv6_mask->hdr.src_addr,
-					    ipv6_addr_mask,
-					    sizeof(ipv6_mask->hdr.src_addr)))
-					input_set |= I40E_INSET_IPV6_SRC;
-				if (!memcmp(&ipv6_mask->hdr.dst_addr,
-					    ipv6_addr_mask,
-					    sizeof(ipv6_mask->hdr.dst_addr)))
-					input_set |= I40E_INSET_IPV6_DST;
-
-				if ((ipv6_mask->hdr.vtc_flow &
-				     rte_cpu_to_be_32(I40E_IPV6_TC_MASK))
-				    == rte_cpu_to_be_32(I40E_IPV6_TC_MASK))
-					input_set |= I40E_INSET_IPV6_TC;
-				if (ipv6_mask->hdr.proto == UINT8_MAX)
-					input_set |= I40E_INSET_IPV6_NEXT_HDR;
-				if (ipv6_mask->hdr.hop_limits == UINT8_MAX)
-					input_set |= I40E_INSET_IPV6_HOP_LIMIT;
-
-				/* Get filter info */
-				vtc_flow_cpu =
-				      rte_be_to_cpu_32(ipv6_spec->hdr.vtc_flow);
-				filter->input.flow.ipv6_flow.tc =
-					(uint8_t)(vtc_flow_cpu >>
-						  I40E_FDIR_IPv6_TC_OFFSET);
-				filter->input.flow.ipv6_flow.proto =
-					ipv6_spec->hdr.proto;
-				filter->input.flow.ipv6_flow.hop_limits =
-					ipv6_spec->hdr.hop_limits;
-
-				filter->input.flow_ext.inner_ip = false;
-				filter->input.flow_ext.oip_type =
-					I40E_FDIR_IPTYPE_IPV6;
-
-				memcpy(filter->input.flow.ipv6_flow.src_ip,
-					   &ipv6_spec->hdr.src_addr, 16);
-				memcpy(filter->input.flow.ipv6_flow.dst_ip,
-					   &ipv6_spec->hdr.dst_addr, 16);
-
-				/* Check if it is fragment. */
-				if (ipv6_spec->hdr.proto ==
-				    I40E_IPV6_FRAG_HEADER)
-					pctype = I40E_FILTER_PCTYPE_FRAG_IPV6;
-			} else if (!ipv6_spec && !ipv6_mask && !outer_ip) {
-				filter->input.flow_ext.inner_ip = true;
-				filter->input.flow_ext.iip_type =
-					I40E_FDIR_IPTYPE_IPV6;
-			} else if (!ipv6_spec && !ipv6_mask && outer_ip) {
-				filter->input.flow_ext.inner_ip = false;
-				filter->input.flow_ext.oip_type =
-					I40E_FDIR_IPTYPE_IPV6;
-			} else if ((ipv6_spec || ipv6_mask) && !outer_ip) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid inner IPv6 mask");
-				return -rte_errno;
-			}
-
-			if (outer_ip)
-				outer_ip = false;
-			break;
-		case RTE_FLOW_ITEM_TYPE_TCP:
-			tcp_spec = item->spec;
-			tcp_mask = item->mask;
-
-			if (l3 == RTE_FLOW_ITEM_TYPE_IPV4)
-				pctype =
-					I40E_FILTER_PCTYPE_NONF_IPV4_TCP;
-			else if (l3 == RTE_FLOW_ITEM_TYPE_IPV6)
-				pctype =
-					I40E_FILTER_PCTYPE_NONF_IPV6_TCP;
-			if (tcp_spec && tcp_mask) {
-				/* Check TCP mask and update input set */
-				if (tcp_mask->hdr.sent_seq ||
-				    tcp_mask->hdr.recv_ack ||
-				    tcp_mask->hdr.data_off ||
-				    tcp_mask->hdr.tcp_flags ||
-				    tcp_mask->hdr.rx_win ||
-				    tcp_mask->hdr.cksum ||
-				    tcp_mask->hdr.tcp_urp) {
-					rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid TCP mask");
-					return -rte_errno;
-				}
-
-				if (tcp_mask->hdr.src_port == UINT16_MAX)
-					input_set |= I40E_INSET_SRC_PORT;
-				if (tcp_mask->hdr.dst_port == UINT16_MAX)
-					input_set |= I40E_INSET_DST_PORT;
-
-				if (input_set & (I40E_INSET_DMAC | I40E_INSET_SMAC)) {
-					if (input_set &
-						(I40E_INSET_SRC_PORT | I40E_INSET_DST_PORT)) {
-						rte_flow_error_set(error, EINVAL,
-							RTE_FLOW_ERROR_TYPE_ITEM,
-							item,
-							"L2 and L4 input set are exclusive.");
-						return -rte_errno;
-					}
-				} else {
-					/* Get filter info */
-					if (l3 == RTE_FLOW_ITEM_TYPE_IPV4) {
-						filter->input.flow.tcp4_flow.src_port =
-							tcp_spec->hdr.src_port;
-						filter->input.flow.tcp4_flow.dst_port =
-							tcp_spec->hdr.dst_port;
-					} else if (l3 == RTE_FLOW_ITEM_TYPE_IPV6) {
-						filter->input.flow.tcp6_flow.src_port =
-							tcp_spec->hdr.src_port;
-						filter->input.flow.tcp6_flow.dst_port =
-							tcp_spec->hdr.dst_port;
-					}
-				}
-			}
-
-			layer_idx = I40E_FLXPLD_L4_IDX;
-
-			break;
-		case RTE_FLOW_ITEM_TYPE_UDP:
-			udp_spec = item->spec;
-			udp_mask = item->mask;
-
-			if (l3 == RTE_FLOW_ITEM_TYPE_IPV4)
-				pctype =
-					I40E_FILTER_PCTYPE_NONF_IPV4_UDP;
-			else if (l3 == RTE_FLOW_ITEM_TYPE_IPV6)
-				pctype =
-					I40E_FILTER_PCTYPE_NONF_IPV6_UDP;
-
-			if (udp_spec && udp_mask) {
-				/* Check UDP mask and update input set*/
-				if (udp_mask->hdr.dgram_len ||
-				    udp_mask->hdr.dgram_cksum) {
-					rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid UDP mask");
-					return -rte_errno;
-				}
-
-				if (udp_mask->hdr.src_port == UINT16_MAX)
-					input_set |= I40E_INSET_SRC_PORT;
-				if (udp_mask->hdr.dst_port == UINT16_MAX)
-					input_set |= I40E_INSET_DST_PORT;
-
-				if (input_set & (I40E_INSET_DMAC | I40E_INSET_SMAC)) {
-					if (input_set &
-						(I40E_INSET_SRC_PORT | I40E_INSET_DST_PORT)) {
-						rte_flow_error_set(error, EINVAL,
-							RTE_FLOW_ERROR_TYPE_ITEM,
-							item,
-							"L2 and L4 input set are exclusive.");
-						return -rte_errno;
-					}
-				} else {
-					/* Get filter info */
-					if (l3 == RTE_FLOW_ITEM_TYPE_IPV4) {
-						filter->input.flow.udp4_flow.src_port =
-							udp_spec->hdr.src_port;
-						filter->input.flow.udp4_flow.dst_port =
-							udp_spec->hdr.dst_port;
-					} else if (l3 == RTE_FLOW_ITEM_TYPE_IPV6) {
-						filter->input.flow.udp6_flow.src_port =
-							udp_spec->hdr.src_port;
-						filter->input.flow.udp6_flow.dst_port =
-							udp_spec->hdr.dst_port;
-					}
-				}
-			}
-			filter->input.flow_ext.is_udp = true;
-			layer_idx = I40E_FLXPLD_L4_IDX;
-
-			break;
-		case RTE_FLOW_ITEM_TYPE_GTPC:
-		case RTE_FLOW_ITEM_TYPE_GTPU:
-			if (!pf->gtp_support) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Unsupported protocol");
-				return -rte_errno;
-			}
-
-			gtp_spec = item->spec;
-			gtp_mask = item->mask;
-
-			if (gtp_spec && gtp_mask) {
-				if (gtp_mask->hdr.gtp_hdr_info ||
-				    gtp_mask->hdr.msg_type ||
-				    gtp_mask->hdr.plen ||
-				    gtp_mask->hdr.teid != UINT32_MAX) {
-					rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid GTP mask");
-					return -rte_errno;
-				}
-
-				filter->input.flow.gtp_flow.teid =
-					gtp_spec->hdr.teid;
-				filter->input.flow_ext.customized_pctype = true;
-				cus_proto = item_type;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_ESP:
-			if (!pf->esp_support) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Unsupported ESP protocol");
-				return -rte_errno;
-			}
-
-			esp_spec = item->spec;
-			esp_mask = item->mask;
-
-			if (!esp_spec || !esp_mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid ESP item");
-				return -rte_errno;
-			}
-
-			if (esp_spec && esp_mask) {
-				if (esp_mask->hdr.spi != UINT32_MAX) {
-					rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid ESP mask");
-					return -rte_errno;
-				}
-				i40e_flow_set_filter_spi(filter, esp_spec);
-				filter->input.flow_ext.customized_pctype = true;
-				cus_proto = item_type;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_SCTP:
-			sctp_spec = item->spec;
-			sctp_mask = item->mask;
-
-			if (l3 == RTE_FLOW_ITEM_TYPE_IPV4)
-				pctype =
-					I40E_FILTER_PCTYPE_NONF_IPV4_SCTP;
-			else if (l3 == RTE_FLOW_ITEM_TYPE_IPV6)
-				pctype =
-					I40E_FILTER_PCTYPE_NONF_IPV6_SCTP;
-
-			if (sctp_spec && sctp_mask) {
-				/* Check SCTP mask and update input set */
-				if (sctp_mask->hdr.cksum) {
-					rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Invalid UDP mask");
-					return -rte_errno;
-				}
-
-				if (sctp_mask->hdr.src_port == UINT16_MAX)
-					input_set |= I40E_INSET_SRC_PORT;
-				if (sctp_mask->hdr.dst_port == UINT16_MAX)
-					input_set |= I40E_INSET_DST_PORT;
-				if (sctp_mask->hdr.tag == UINT32_MAX)
-					input_set |= I40E_INSET_SCTP_VT;
-
-				/* Get filter info */
-				if (l3 == RTE_FLOW_ITEM_TYPE_IPV4) {
-					filter->input.flow.sctp4_flow.src_port =
-						sctp_spec->hdr.src_port;
-					filter->input.flow.sctp4_flow.dst_port =
-						sctp_spec->hdr.dst_port;
-					filter->input.flow.sctp4_flow.verify_tag
-						= sctp_spec->hdr.tag;
-				} else if (l3 == RTE_FLOW_ITEM_TYPE_IPV6) {
-					filter->input.flow.sctp6_flow.src_port =
-						sctp_spec->hdr.src_port;
-					filter->input.flow.sctp6_flow.dst_port =
-						sctp_spec->hdr.dst_port;
-					filter->input.flow.sctp6_flow.verify_tag
-						= sctp_spec->hdr.tag;
-				}
-			}
-
-			layer_idx = I40E_FLXPLD_L4_IDX;
-
-			break;
-		case RTE_FLOW_ITEM_TYPE_RAW:
-			raw_spec = item->spec;
-			raw_mask = item->mask;
-
-			if (!raw_spec || !raw_mask) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "NULL RAW spec/mask");
-				return -rte_errno;
-			}
-
-			if (pf->support_multi_driver) {
-				rte_flow_error_set(error, ENOTSUP,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Unsupported flexible payload.");
-				return -rte_errno;
-			}
-
-			ret = i40e_flow_check_raw_item(item, raw_spec, error);
-			if (ret < 0)
-				return ret;
-
-			off_arr[raw_id] = raw_spec->offset;
-			len_arr[raw_id] = raw_spec->length;
-
-			flex_size = 0;
-			memset(&flex_pit, 0, sizeof(struct i40e_fdir_flex_pit));
-			field_idx = layer_idx * I40E_MAX_FLXPLD_FIED + raw_id;
-			flex_pit.size =
-				raw_spec->length / sizeof(uint16_t);
-			flex_pit.dst_offset =
-				next_dst_off / sizeof(uint16_t);
-
-			for (i = 0; i <= raw_id; i++) {
-				if (i == raw_id)
-					flex_pit.src_offset +=
-						raw_spec->offset /
-						sizeof(uint16_t);
-				else
-					flex_pit.src_offset +=
-						(off_arr[i] + len_arr[i]) /
-						sizeof(uint16_t);
-				flex_size += len_arr[i];
-			}
-			if (((flex_pit.src_offset + flex_pit.size) >=
-			     I40E_MAX_FLX_SOURCE_OFF / sizeof(uint16_t)) ||
-				flex_size > I40E_FDIR_MAX_FLEXLEN) {
-				rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ITEM,
-					   item,
-					   "Exceeds maximal payload limit.");
-				return -rte_errno;
-			}
-
-			if (raw_spec->length != 0) {
-				if (raw_spec->pattern == NULL) {
-					rte_flow_error_set(error, EINVAL,
-							   RTE_FLOW_ERROR_TYPE_ITEM,
-							   item,
-							   "NULL RAW spec pattern");
-					return -rte_errno;
-				}
-				if (raw_mask->pattern == NULL) {
-					rte_flow_error_set(error, EINVAL,
-							   RTE_FLOW_ERROR_TYPE_ITEM,
-							   item,
-							   "NULL RAW mask pattern");
-					return -rte_errno;
-				}
-			}
-
-			for (i = 0; i < raw_spec->length; i++) {
-				j = i + next_dst_off;
-				if (j >= RTE_ETH_FDIR_MAX_FLEXLEN ||
-						j >= I40E_FDIR_MAX_FLEX_LEN)
-					break;
-				filter->input.flow_ext.flexbytes[j] =
-					raw_spec->pattern[i];
-				filter->input.flow_ext.flex_mask[j] =
-					raw_mask->pattern[i];
-			}
-
-			next_dst_off += raw_spec->length;
-			raw_id++;
-
-			filter->input.flow_ext.flex_pit[field_idx] = flex_pit;
-			filter->input.flow_ext.layer_idx = layer_idx;
-			filter->input.flow_ext.raw_id = raw_id;
-			filter->input.flow_ext.is_flex_flow = true;
-			break;
-		case RTE_FLOW_ITEM_TYPE_L2TPV3OIP:
-			l2tpv3oip_spec = item->spec;
-			l2tpv3oip_mask = item->mask;
-
-			if (!l2tpv3oip_spec || !l2tpv3oip_mask)
-				break;
-
-			if (l2tpv3oip_mask->session_id != UINT32_MAX) {
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item,
-					"Invalid L2TPv3 mask");
-				return -rte_errno;
-			}
-
-			if (l3 == RTE_FLOW_ITEM_TYPE_IPV4) {
-				filter->input.flow.ip4_l2tpv3oip_flow.session_id =
-					l2tpv3oip_spec->session_id;
-				filter->input.flow_ext.oip_type =
-					I40E_FDIR_IPTYPE_IPV4;
-			} else if (l3 == RTE_FLOW_ITEM_TYPE_IPV6) {
-				filter->input.flow.ip6_l2tpv3oip_flow.session_id =
-					l2tpv3oip_spec->session_id;
-				filter->input.flow_ext.oip_type =
-					I40E_FDIR_IPTYPE_IPV6;
-			}
-
-			filter->input.flow_ext.customized_pctype = true;
-			cus_proto = item_type;
-			break;
-		default:
-			break;
-		}
-	}
-
-	/* Get customized pctype value */
-	if (filter->input.flow_ext.customized_pctype) {
-		pctype = i40e_flow_fdir_get_pctype_value(pf, cus_proto, filter);
-		if (pctype == I40E_FILTER_PCTYPE_INVALID) {
-			rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ITEM,
-					   item,
-					   "Unsupported pctype");
-			return -rte_errno;
-		}
-	}
-
-	/* If customized pctype is not used, set fdir configuration.*/
-	if (!filter->input.flow_ext.customized_pctype) {
-		/* Check if the input set is valid */
-		if (i40e_validate_input_set(pctype, RTE_ETH_FILTER_FDIR,
-						input_set) != 0) {
-			rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ITEM,
-					   item,
-					   "Invalid input set");
-			return -rte_errno;
-		}
-
-		filter->input.flow_ext.input_set = input_set;
-	}
-
-	filter->input.pctype = pctype;
-
-	return 0;
-}
-
-/* Parse to get the action info of a FDIR filter.
- * FDIR action supports QUEUE or (QUEUE + MARK).
- */
-static int
-i40e_flow_parse_fdir_action(struct rte_eth_dev *dev,
-			    const struct rte_flow_action *actions,
-			    struct rte_flow_error *error,
-			    struct i40e_fdir_filter *filter)
-{
-	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-	struct ci_flow_actions parsed_actions = {0};
-	struct ci_flow_actions_check_param ac_param = {
-		.allowed_types = (enum rte_flow_action_type[]) {
-			RTE_FLOW_ACTION_TYPE_QUEUE,
-			RTE_FLOW_ACTION_TYPE_DROP,
-			RTE_FLOW_ACTION_TYPE_PASSTHRU,
-			RTE_FLOW_ACTION_TYPE_MARK,
-			RTE_FLOW_ACTION_TYPE_FLAG,
-			RTE_FLOW_ACTION_TYPE_RSS,
-			RTE_FLOW_ACTION_TYPE_END
-		},
-		.max_actions = 2,
-	};
-	const struct rte_flow_action *first, *second;
-	int ret;
-
-	ret = ci_flow_check_actions(actions, &ac_param, &parsed_actions, error);
-	if (ret)
-		return ret;
-	first = parsed_actions.actions[0];
-	/* can be NULL */
-	second = parsed_actions.actions[1];
-
-	switch (first->type) {
-	case RTE_FLOW_ACTION_TYPE_QUEUE:
-	{
-		const struct rte_flow_action_queue *act_q = first->conf;
-		/* check against PF constraints */
-		if (!filter->input.flow_ext.is_vf && act_q->index >= pf->dev_data->nb_rx_queues) {
-			return rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ACTION, first,
-					"Invalid queue ID for FDIR");
-		}
-		/* check against VF constraints */
-		if (filter->input.flow_ext.is_vf && act_q->index >= pf->vf_nb_qps) {
-			return rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ACTION, first,
-					"Invalid queue ID for FDIR");
-		}
-		filter->action.rx_queue = act_q->index;
-		filter->action.behavior = I40E_FDIR_ACCEPT;
-		break;
-	}
-	case RTE_FLOW_ACTION_TYPE_DROP:
-		filter->action.behavior = I40E_FDIR_REJECT;
-		break;
-	case RTE_FLOW_ACTION_TYPE_PASSTHRU:
-		filter->action.behavior = I40E_FDIR_PASSTHRU;
-		break;
-	case RTE_FLOW_ACTION_TYPE_MARK:
-	{
-		const struct rte_flow_action_mark *act_m = first->conf;
-		filter->action.behavior = I40E_FDIR_PASSTHRU;
-		filter->action.report_status = I40E_FDIR_REPORT_ID;
-		filter->soft_id = act_m->id;
-		break;
-	}
-	default:
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION, first,
-				"Invalid first action for FDIR");
-	}
-
-	/* do we have another? */
-	if (second == NULL)
-		return 0;
-
-	switch (second->type) {
-	case RTE_FLOW_ACTION_TYPE_MARK:
-	{
-		const struct rte_flow_action_mark *act_m = second->conf;
-		/* only one mark action can be specified */
-		if (first->type == RTE_FLOW_ACTION_TYPE_MARK) {
-			return rte_flow_error_set(error, EINVAL,
-						  RTE_FLOW_ERROR_TYPE_ACTION, second,
-						  "Invalid second action for FDIR");
-		}
-		filter->action.report_status = I40E_FDIR_REPORT_ID;
-		filter->soft_id = act_m->id;
-		break;
-	}
-	case RTE_FLOW_ACTION_TYPE_FLAG:
-	{
-		/* mark + flag is unsupported */
-		if (first->type == RTE_FLOW_ACTION_TYPE_MARK) {
-			return rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ACTION, second,
-					"Invalid second action for FDIR");
-		}
-		filter->action.report_status = I40E_FDIR_NO_REPORT_STATUS;
-		break;
-	}
-	case RTE_FLOW_ACTION_TYPE_RSS:
-		/* RSS filter only can be after passthru or mark */
-		if (first->type != RTE_FLOW_ACTION_TYPE_PASSTHRU &&
-				first->type != RTE_FLOW_ACTION_TYPE_MARK) {
-			return rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ACTION, second,
-					"Invalid second action for FDIR");
-		}
-		break;
-	default:
-		return rte_flow_error_set(error, EINVAL,
-					  RTE_FLOW_ERROR_TYPE_ACTION, second,
-					  "Invalid second action for FDIR");
-	}
-
-	return 0;
-}
-
-static int
-i40e_flow_parse_fdir_filter(struct rte_eth_dev *dev,
-			    const struct rte_flow_item pattern[],
-			    const struct rte_flow_action actions[],
-			    struct rte_flow_error *error,
-			    struct i40e_filter_ctx *filter)
-{
-	struct i40e_fdir_filter *fdir_filter = &filter->fdir_filter;
-	int ret;
-
-	ret = i40e_flow_parse_fdir_pattern(dev, pattern, error, fdir_filter);
-	if (ret)
-		return ret;
-
-	ret = i40e_flow_parse_fdir_action(dev, actions, error, fdir_filter);
-	if (ret)
-		return ret;
-
-	filter->type = RTE_ETH_FILTER_FDIR;
-
-	return 0;
-}
-
 /* Parse to get the action info of a tunnel filter
  * Tunnel action only supports PF, VF and QUEUE.
  */
@@ -3743,7 +1928,6 @@ i40e_flow_create(struct rte_eth_dev *dev,
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	struct i40e_filter_ctx filter_ctx = {0};
 	struct rte_flow *flow = NULL;
-	struct i40e_fdir_info *fdir_info = &pf->fdir;
 	int ret;
 
 	/* try the new engine first */
@@ -3755,46 +1939,15 @@ i40e_flow_create(struct rte_eth_dev *dev,
 	if (ret < 0)
 		return NULL;
 
-	if (filter_ctx.type == RTE_ETH_FILTER_FDIR) {
-		flow = i40e_fdir_entry_pool_get(fdir_info);
-		if (flow == NULL) {
-			rte_flow_error_set(error, ENOBUFS,
-			   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-			   "Fdir space full");
-
-			return flow;
-		}
-	} else {
-		flow = rte_zmalloc("i40e_flow", sizeof(struct rte_flow), 0);
-		if (!flow) {
-			rte_flow_error_set(error, ENOMEM,
-					   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-					   "Failed to allocate memory");
-			return flow;
-		}
+	flow = rte_zmalloc("i40e_flow", sizeof(struct rte_flow), 0);
+	if (!flow) {
+		rte_flow_error_set(error, ENOMEM,
+					RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+					"Failed to allocate memory");
+		return flow;
 	}
 
 	switch (filter_ctx.type) {
-	case RTE_ETH_FILTER_FDIR: {
-		struct i40e_fdir_filter *node;
-
-		ret = i40e_fdir_filter_validate(dev, &filter_ctx.fdir_filter);
-		if (ret)
-			goto free_flow;
-		ret = i40e_fdir_filter_register(dev, &filter_ctx.fdir_filter,
-						&node);
-		if (ret)
-			goto free_flow;
-		ret = i40e_fdir_filter_program(dev, node, 1,
-				i40e_fdir_filter_needs_status_wait(pf,
-					fdir_info->fdir_actual_cnt - 1));
-		if (ret) {
-			i40e_fdir_filter_unregister(dev, node);
-			goto free_flow;
-		}
-		flow->rule = node;
-		break;
-	}
 	case RTE_ETH_FILTER_TUNNEL:
 		ret = i40e_dev_consistent_tunnel_filter_set(pf,
 				&filter_ctx.consistent_tunnel_filter, 1);
@@ -3823,10 +1976,7 @@ i40e_flow_create(struct rte_eth_dev *dev,
 			   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
 			   "Failed to create flow.");
 
-	if (filter_ctx.type != RTE_ETH_FILTER_FDIR)
-		rte_free(flow);
-	else
-		i40e_fdir_entry_pool_put(fdir_info, flow);
+	rte_free(flow);
 
 	return NULL;
 }
@@ -3838,7 +1988,6 @@ i40e_flow_destroy(struct rte_eth_dev *dev,
 {
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	enum rte_filter_type filter_type = flow->filter_type;
-	struct i40e_fdir_info *fdir_info = &pf->fdir;
 	int ret = 0;
 
 	/* try the new engine first */
@@ -3851,15 +2000,6 @@ i40e_flow_destroy(struct rte_eth_dev *dev,
 		ret = i40e_flow_destroy_tunnel_filter(pf,
 			      (struct i40e_tunnel_filter *)flow->rule);
 		break;
-	case RTE_ETH_FILTER_FDIR: {
-		struct i40e_fdir_filter *node = flow->rule;
-
-		ret = i40e_fdir_filter_program(dev, node, 0, false);
-		if (ret)
-			break;
-		ret = i40e_fdir_filter_unregister(dev, node);
-		break;
-	}
 	case RTE_ETH_FILTER_HASH:
 		ret = i40e_hash_filter_destroy(pf, flow->rule);
 		break;
@@ -3872,10 +2012,7 @@ i40e_flow_destroy(struct rte_eth_dev *dev,
 
 	if (!ret) {
 		TAILQ_REMOVE(&pf->flow_list, flow, node);
-		if (filter_type == RTE_ETH_FILTER_FDIR)
-			i40e_fdir_entry_pool_put(fdir_info, flow);
-		else
-			rte_free(flow);
+		rte_free(flow);
 
 	} else
 		rte_flow_error_set(error, -ret,
@@ -3955,14 +2092,6 @@ i40e_flow_flush(struct rte_eth_dev *dev, struct rte_flow_error *error)
 	if (ret != 0)
 		return ret;
 
-	ret = i40e_flow_flush_fdir_filter(pf);
-	if (ret) {
-		rte_flow_error_set(error, -ret,
-				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-				   "Failed to flush FDIR flows.");
-		return -rte_errno;
-	}
-
 	ret = i40e_flow_flush_tunnel_filter(pf);
 	if (ret) {
 		rte_flow_error_set(error, -ret,
@@ -3979,31 +2108,6 @@ i40e_flow_flush(struct rte_eth_dev *dev, struct rte_flow_error *error)
 	return ret;
 }
 
-static int
-i40e_flow_flush_fdir_filter(struct i40e_pf *pf)
-{
-	struct rte_eth_dev *dev = &rte_eth_devices[pf->dev_data->port_id];
-	struct i40e_fdir_info *fdir_info = &pf->fdir;
-	struct rte_flow *flow;
-	void *temp;
-	int ret;
-
-	RTE_TAILQ_FOREACH_SAFE(flow, &pf->flow_list, node, temp) {
-		if (flow->filter_type != RTE_ETH_FILTER_FDIR)
-			continue;
-		ret = i40e_fdir_filter_program(dev, flow->rule, false, false);
-		if (ret < 0)
-			return ret;
-		ret = i40e_fdir_filter_unregister(dev, flow->rule);
-		if (ret < 0)
-			return ret;
-		TAILQ_REMOVE(&pf->flow_list, flow, node);
-		i40e_fdir_entry_pool_put(fdir_info, flow);
-	}
-
-	return 0;
-}
-
 /* Flush all tunnel filters */
 static int
 i40e_flow_flush_tunnel_filter(struct i40e_pf *pf)
diff --git a/drivers/net/intel/i40e/i40e_flow.h b/drivers/net/intel/i40e/i40e_flow.h
index 11d13a76fe..6823dbef33 100644
--- a/drivers/net/intel/i40e/i40e_flow.h
+++ b/drivers/net/intel/i40e/i40e_flow.h
@@ -8,9 +8,14 @@
 #include "../common/flow_engine.h"
 
 int i40e_get_outer_vlan(struct i40e_pf *pf, uint16_t *tpid);
+uint8_t
+i40e_flow_fdir_get_pctype_value(struct i40e_pf *pf,
+		enum rte_flow_item_type item_type,
+		struct i40e_fdir_filter *filter);
 
 extern const struct ci_flow_engine_list i40e_flow_engine_list;
 
 extern const struct ci_flow_engine i40e_flow_engine_ethertype;
+extern const struct ci_flow_engine i40e_flow_engine_fdir;
 
 #endif /* _I40E_FLOW_H_ */
diff --git a/drivers/net/intel/i40e/i40e_flow_fdir.c b/drivers/net/intel/i40e/i40e_flow_fdir.c
new file mode 100644
index 0000000000..1bd92fd31a
--- /dev/null
+++ b/drivers/net/intel/i40e/i40e_flow_fdir.c
@@ -0,0 +1,2056 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include "i40e_ethdev.h"
+#include "i40e_flow.h"
+
+#include <rte_bitmap.h>
+#include <rte_malloc.h>
+#include <rte_hash_crc.h>
+
+#include "../common/flow_engine.h"
+#include "../common/flow_check.h"
+#include "../common/flow_util.h"
+
+struct i40e_fdir_ctx {
+	struct ci_flow_engine_ctx base;
+	struct i40e_fdir_filter fdir_filter;
+	enum rte_flow_item_type custom_pctype;
+	struct flex_item {
+		size_t size;
+		size_t offset;
+	} flex_data[I40E_MAX_FLXPLD_FIED];
+};
+
+struct i40e_flow_engine_fdir_flow {
+	struct rte_flow base;
+	struct i40e_fdir_filter fdir_filter;
+	bool installed;
+};
+
+struct i40e_fdir_flow_pool_entry {
+	struct i40e_flow_engine_fdir_flow flow;
+	uint32_t idx;
+};
+
+struct i40e_fdir_engine_priv {
+	struct i40e_fdir_flow_pool_entry *pool;
+	struct rte_bitmap *bitmap;
+	struct rte_hash *hash_table;
+};
+
+#define I40E_FDIR_FLOW_ENTRY(flow_ptr) \
+	container_of((flow_ptr), struct i40e_fdir_flow_pool_entry, flow)
+
+/**
+ * FDIR graph implementation (non-tunnel)
+ * Pattern: START -> ETH -> [VLAN] -> (IPv4 | IPv6) -> [TCP | UDP | SCTP | ESP | L2TPv3 | GTP] -> END
+ * With RAW flexible payload support:
+ *   - L2: ETH/VLAN -> RAW -> RAW -> RAW -> END
+ *   - L3: IPv4/IPv6 -> RAW -> RAW -> RAW -> END
+ *   - L4: TCP/UDP/SCTP -> RAW -> RAW -> RAW -> END
+ * GTP tunnel support:
+ *   - IPv4/IPv6 -> UDP -> GTP -> END (GTP-C, GTP-U outer)
+ *   - IPv4/IPv6 -> UDP -> GTP -> IPv4/IPv6 -> END (GTP-U with inner IP)
+ */
+
+enum i40e_fdir_node_id {
+	I40E_FDIR_NODE_START = FLOW_GRAPH_NODE_FIRST,
+	I40E_FDIR_NODE_ETH,
+	I40E_FDIR_NODE_VLAN,
+	I40E_FDIR_NODE_IPV4,
+	I40E_FDIR_NODE_IPV6,
+	I40E_FDIR_NODE_TCP,
+	I40E_FDIR_NODE_UDP,
+	I40E_FDIR_NODE_SCTP,
+	I40E_FDIR_NODE_ESP,
+	I40E_FDIR_NODE_L2TPV3OIP,
+	I40E_FDIR_NODE_GTPC,
+	I40E_FDIR_NODE_GTPU,
+	I40E_FDIR_NODE_INNER_IPV4,
+	I40E_FDIR_NODE_INNER_IPV6,
+	I40E_FDIR_NODE_RAW,
+	I40E_FDIR_NODE_END,
+	I40E_FDIR_NODE_MAX,
+};
+
+static int
+i40e_fdir_node_eth_validate(const void *ctx __rte_unused, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_item_eth *eth_spec = item->spec;
+	const struct rte_flow_item_eth *eth_mask = item->mask;
+	bool no_src_mac, no_dst_mac, src_mac, dst_mac;
+
+	/* may be empty */
+	if (eth_spec == NULL && eth_mask == NULL)
+		return 0;
+
+	/* source and destination masks may be all zero or all one */
+	no_src_mac = CI_FIELD_IS_ZERO(&eth_mask->hdr.src_addr);
+	no_dst_mac = CI_FIELD_IS_ZERO(&eth_mask->hdr.dst_addr);
+	src_mac = CI_FIELD_IS_MASKED(&eth_mask->hdr.src_addr);
+	dst_mac = CI_FIELD_IS_MASKED(&eth_mask->hdr.dst_addr);
+
+	/* can't be all zero */
+	if (no_src_mac && no_dst_mac) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item, "Invalid eth mask");
+	}
+	/* can't be neither zero nor ones */
+	if ((!no_src_mac && !src_mac) ||
+	    (!no_dst_mac && !dst_mac)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item, "Invalid eth mask");
+	}
+
+	/* ethertype can either be unmasked or fully masked */
+	if (CI_FIELD_IS_ZERO(&eth_mask->hdr.ether_type))
+		return 0;
+
+	if (!CI_FIELD_IS_MASKED(&eth_mask->hdr.ether_type)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item, "Invalid ethertype mask");
+	}
+
+	/* Check for valid ethertype (not IPv4/IPv6) */
+	uint16_t ether_type = rte_be_to_cpu_16(eth_spec->hdr.ether_type);
+	if (ether_type == RTE_ETHER_TYPE_IPV4 ||
+	    ether_type == RTE_ETHER_TYPE_IPV6) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"IPv4/IPv6 not supported by ethertype filter");
+	}
+
+	return 0;
+}
+
+static int
+i40e_fdir_node_eth_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	struct i40e_fdir_ctx *fdir_ctx = ctx;
+	struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
+	const struct rte_flow_item_eth *eth_spec = item->spec;
+	const struct rte_flow_item_eth *eth_mask = item->mask;
+	uint16_t tpid, ether_type;
+	uint64_t input_set = 0;
+	int ret;
+
+	/* Set layer index for L2 flexible payload (after ETH/VLAN) */
+	fdir_filter->input.flow_ext.layer_idx = I40E_FLXPLD_L2_IDX;
+
+	/* set packet type */
+	fdir_filter->input.pctype = I40E_FILTER_PCTYPE_L2_PAYLOAD;
+
+	/* do we need to set up MAC addresses? */
+	if (eth_spec == NULL && eth_mask == NULL)
+		return 0;
+
+	/* do we care for source address? */
+	if (CI_FIELD_IS_MASKED(&eth_mask->hdr.src_addr)) {
+		fdir_filter->input.flow.l2_flow.src = eth_spec->hdr.src_addr;
+		input_set |= I40E_INSET_SMAC;
+	}
+	/* do we care for destination address? */
+	if (CI_FIELD_IS_MASKED(&eth_mask->hdr.dst_addr)) {
+		fdir_filter->input.flow.l2_flow.dst = eth_spec->hdr.dst_addr;
+		input_set |= I40E_INSET_DMAC;
+	}
+
+	/* do we care for ethertype? */
+	if (eth_mask->hdr.ether_type) {
+		struct i40e_pf *pf =
+				I40E_DEV_PRIVATE_TO_PF(fdir_ctx->base.dev_data->dev_private);
+
+		ether_type = rte_be_to_cpu_16(eth_spec->hdr.ether_type);
+		ret = i40e_get_outer_vlan(pf, &tpid);
+		if (ret != 0) {
+			return rte_flow_error_set(error, EIO,
+					RTE_FLOW_ERROR_TYPE_ITEM, item,
+					"Can not get the Ethertype identifying the L2 tag");
+		}
+		if (ether_type == tpid) {
+			return rte_flow_error_set(error, EINVAL,
+						RTE_FLOW_ERROR_TYPE_ITEM, item,
+						"Unsupported ether_type in control packet filter.");
+		}
+		fdir_filter->input.flow.l2_flow.ether_type = eth_spec->hdr.ether_type;
+		input_set |= I40E_INSET_LAST_ETHER_TYPE;
+	}
+
+	fdir_filter->input.flow_ext.input_set = input_set;
+
+	return 0;
+}
+
+static int
+i40e_fdir_node_vlan_validate(const void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_item_vlan *vlan_spec = item->spec;
+	const struct rte_flow_item_vlan *vlan_mask = item->mask;
+	const struct i40e_fdir_ctx *fdir_ctx = ctx;
+	const struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
+	uint16_t ether_type;
+
+	if (vlan_spec == NULL && vlan_mask == NULL)
+		return 0;
+
+	/* TCI mask can be either fully disabled or fully enabled. */
+	if (vlan_mask->hdr.vlan_tci != 0 &&
+	    vlan_mask->hdr.vlan_tci != rte_cpu_to_be_16(I40E_VLAN_TCI_MASK)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Unsupported TCI mask");
+	}
+	if (CI_FIELD_IS_ZERO(&vlan_mask->hdr.eth_proto))
+		return 0;
+
+	if (!CI_FIELD_IS_MASKED(&vlan_mask->hdr.eth_proto)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid VLAN header mask");
+	}
+
+	/* can't match on eth_proto as we're already matching on ethertype */
+	if (fdir_filter->input.flow_ext.input_set & I40E_INSET_LAST_ETHER_TYPE) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Cannot set two ethertype filters");
+	}
+
+	ether_type = rte_be_to_cpu_16(vlan_spec->hdr.eth_proto);
+	if (ether_type == RTE_ETHER_TYPE_IPV4 ||
+	    ether_type == RTE_ETHER_TYPE_IPV6) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"IPv4/IPv6 not supported by VLAN protocol filter");
+	}
+
+	return 0;
+}
+
+static int
+i40e_fdir_node_vlan_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_item_vlan *vlan_spec = item->spec;
+	const struct rte_flow_item_vlan *vlan_mask = item->mask;
+	struct i40e_fdir_ctx *fdir_ctx = ctx;
+	struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
+
+	/* Set layer index for L2 flexible payload (after ETH/VLAN) */
+	fdir_filter->input.flow_ext.layer_idx = I40E_FLXPLD_L2_IDX;
+
+	/* set packet type */
+	fdir_filter->input.pctype = I40E_FILTER_PCTYPE_L2_PAYLOAD;
+
+	if (vlan_spec == NULL && vlan_mask == NULL)
+		return 0;
+
+	/* Store TCI value if requested */
+	if (vlan_mask->hdr.vlan_tci) {
+		fdir_filter->input.flow_ext.vlan_tci = vlan_spec->hdr.vlan_tci;
+		fdir_filter->input.flow_ext.input_set |= I40E_INSET_VLAN_INNER;
+	}
+
+	/* if ethertype specified, store it */
+	if (vlan_mask->hdr.eth_proto) {
+		struct i40e_pf *pf =
+				I40E_DEV_PRIVATE_TO_PF(fdir_ctx->base.dev_data->dev_private);
+		uint16_t tpid, ether_type;
+		int ret;
+
+		ether_type = rte_be_to_cpu_16(vlan_spec->hdr.eth_proto);
+
+		ret = i40e_get_outer_vlan(pf, &tpid);
+		if (ret != 0) {
+			return rte_flow_error_set(error, EIO,
+					RTE_FLOW_ERROR_TYPE_ITEM, item,
+					"Can not get the Ethertype identifying the L2 tag");
+		}
+		if (ether_type == tpid) {
+			return rte_flow_error_set(error, EINVAL,
+						RTE_FLOW_ERROR_TYPE_ITEM, item,
+						"Unsupported ether_type in control packet filter.");
+		}
+		fdir_filter->input.flow.l2_flow.ether_type = vlan_spec->hdr.eth_proto;
+		fdir_filter->input.flow_ext.input_set |= I40E_INSET_LAST_ETHER_TYPE;
+	}
+
+	return 0;
+}
+
+static int
+i40e_fdir_node_ipv4_validate(const void *ctx __rte_unused, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_item_ipv4 *ipv4_spec = item->spec;
+	const struct rte_flow_item_ipv4 *ipv4_mask = item->mask;
+	const struct rte_flow_item_ipv4 *ipv4_last = item->last;
+
+	if (ipv4_mask == NULL && ipv4_spec == NULL)
+		return 0;
+
+	/* Validate mask fields */
+	if (ipv4_mask->hdr.version_ihl ||
+			ipv4_mask->hdr.total_length ||
+			ipv4_mask->hdr.packet_id ||
+			ipv4_mask->hdr.hdr_checksum) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid IPv4 header mask");
+	}
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&ipv4_mask->hdr.src_addr) ||
+			!CI_FIELD_IS_ZERO_OR_MASKED(&ipv4_mask->hdr.dst_addr) ||
+			!CI_FIELD_IS_ZERO_OR_MASKED(&ipv4_mask->hdr.type_of_service) ||
+			!CI_FIELD_IS_ZERO_OR_MASKED(&ipv4_mask->hdr.time_to_live) ||
+			!CI_FIELD_IS_ZERO_OR_MASKED(&ipv4_mask->hdr.next_proto_id)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid IPv4 header mask");
+	}
+
+	if (ipv4_last == NULL)
+		return 0;
+
+	/* Only fragment_offset supports range */
+	if (ipv4_last->hdr.version_ihl ||
+	    ipv4_last->hdr.type_of_service ||
+	    ipv4_last->hdr.total_length ||
+	    ipv4_last->hdr.packet_id ||
+	    ipv4_last->hdr.time_to_live ||
+	    ipv4_last->hdr.next_proto_id ||
+	    ipv4_last->hdr.hdr_checksum ||
+	    ipv4_last->hdr.src_addr ||
+	    ipv4_last->hdr.dst_addr) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"IPv4 range only supported for fragment_offset");
+	}
+
+	/* Validate fragment_offset range values */
+	uint16_t frag_mask = rte_be_to_cpu_16(ipv4_mask->hdr.fragment_offset);
+	uint16_t frag_spec = rte_be_to_cpu_16(ipv4_spec->hdr.fragment_offset);
+	uint16_t frag_last = rte_be_to_cpu_16(ipv4_last->hdr.fragment_offset);
+
+	/* Mask must be 0x3fff (fragment offset + MF flag) */
+	if (frag_mask != (RTE_IPV4_HDR_OFFSET_MASK | RTE_IPV4_HDR_MF_FLAG)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid IPv4 fragment_offset mask");
+	}
+
+	/* Only allow: frag rule (spec=0x8, last=0x2000) or non-frag (spec=0, last=0) */
+	if (frag_spec == (1 << RTE_IPV4_HDR_FO_SHIFT) &&
+	    frag_last == RTE_IPV4_HDR_MF_FLAG)
+		return 0; /* Fragment rule */
+
+	if (frag_spec == 0 && frag_last == 0)
+		return 0; /* Non-fragment rule */
+
+	return rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_ITEM, item,
+			"Invalid IPv4 fragment_offset rule");
+}
+
+static int
+i40e_fdir_node_ipv4_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct rte_flow_item_ipv4 *ipv4_spec = item->spec;
+	const struct rte_flow_item_ipv4 *ipv4_mask = item->mask;
+	const struct rte_flow_item_ipv4 *ipv4_last = item->last;
+	struct i40e_fdir_ctx *fdir_ctx = ctx;
+	struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
+	uint16_t frag_spec, frag_last;
+
+	/* Set layer index for L2 flexible payload (after ETH/VLAN) */
+	fdir_filter->input.flow_ext.layer_idx = I40E_FLXPLD_L3_IDX;
+
+	/* set packet type */
+	fdir_filter->input.pctype = I40E_FILTER_PCTYPE_NONF_IPV4_OTHER;
+
+	/* set up flow type */
+	fdir_filter->input.flow_ext.inner_ip = false;
+	fdir_filter->input.flow_ext.oip_type = I40E_FDIR_IPTYPE_IPV4;
+
+	if (ipv4_mask == NULL && ipv4_spec == NULL)
+		return 0;
+
+	/* Mark that IPv4 fields are used */
+	if (!CI_FIELD_IS_ZERO(&ipv4_mask->hdr.next_proto_id)) {
+		fdir_filter->input.flow.ip4_flow.proto = ipv4_spec->hdr.next_proto_id;
+		fdir_filter->input.flow_ext.input_set |= I40E_INSET_IPV4_PROTO;
+	}
+	if (!CI_FIELD_IS_ZERO(&ipv4_mask->hdr.type_of_service)) {
+		fdir_filter->input.flow.ip4_flow.tos = ipv4_spec->hdr.type_of_service;
+		fdir_filter->input.flow_ext.input_set |= I40E_INSET_IPV4_TOS;
+	}
+	if (!CI_FIELD_IS_ZERO(&ipv4_mask->hdr.time_to_live)) {
+		fdir_filter->input.flow.ip4_flow.ttl = ipv4_spec->hdr.time_to_live;
+		fdir_filter->input.flow_ext.input_set |= I40E_INSET_IPV4_TTL;
+	}
+	if (!CI_FIELD_IS_ZERO(&ipv4_mask->hdr.src_addr)) {
+		fdir_filter->input.flow.ip4_flow.src_ip = ipv4_spec->hdr.src_addr;
+		fdir_filter->input.flow_ext.input_set |= I40E_INSET_IPV4_SRC;
+	}
+	if (!CI_FIELD_IS_ZERO(&ipv4_mask->hdr.dst_addr)) {
+		fdir_filter->input.flow.ip4_flow.dst_ip = ipv4_spec->hdr.dst_addr;
+		fdir_filter->input.flow_ext.input_set |= I40E_INSET_IPV4_DST;
+	}
+
+	/* do we have range? */
+	if (ipv4_last == NULL)
+		return 0;
+
+	/* frag mask is already known to be non-zero */
+	frag_spec = rte_be_to_cpu_16(ipv4_spec->hdr.fragment_offset);
+	frag_last = rte_be_to_cpu_16(ipv4_last->hdr.fragment_offset);
+	/* frag spec and last are already known to be either 0 or valid */
+
+	/* is range specified for fragment_offset? */
+	if (frag_spec != 0 && frag_last != 0)
+		fdir_filter->input.pctype = I40E_FILTER_PCTYPE_FRAG_IPV4;
+
+	return 0;
+}
+
+static int
+i40e_fdir_node_ipv6_validate(const void *ctx __rte_unused, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_item_ipv6 *ipv6_spec = item->spec;
+	const struct rte_flow_item_ipv6 *ipv6_mask = item->mask;
+	if (ipv6_mask == NULL && ipv6_spec == NULL)
+		return 0;
+
+	/* payload len isn't supported */
+	if (ipv6_mask->hdr.payload_len) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid IPv6 header mask");
+	}
+	/* source and destination mask can either be all zeroes or all ones */
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&ipv6_mask->hdr.src_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid IPv6 source address mask");
+	}
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&ipv6_mask->hdr.dst_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid IPv6 destination address mask");
+	}
+
+	/* check other supported fields */
+	if (!ci_is_zero_or_masked(ipv6_mask->hdr.vtc_flow, rte_cpu_to_be_32(I40E_IPV6_TC_MASK)) ||
+	    !CI_FIELD_IS_ZERO_OR_MASKED(&ipv6_mask->hdr.proto) ||
+	    !CI_FIELD_IS_ZERO_OR_MASKED(&ipv6_mask->hdr.hop_limits)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid IPv6 header mask");
+	}
+
+	return 0;
+}
+
+static int
+i40e_fdir_node_ipv6_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct rte_flow_item_ipv6 *ipv6_spec = item->spec;
+	const struct rte_flow_item_ipv6 *ipv6_mask = item->mask;
+	struct i40e_fdir_ctx *fdir_ctx = ctx;
+	struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
+
+	/* Set layer index for L2 flexible payload (after ETH/VLAN) */
+	fdir_filter->input.flow_ext.layer_idx = I40E_FLXPLD_L3_IDX;
+
+	/* set packet type */
+	fdir_filter->input.pctype = I40E_FILTER_PCTYPE_NONF_IPV6_OTHER;
+
+	/* set up flow type */
+	fdir_filter->input.flow_ext.inner_ip = false;
+	fdir_filter->input.flow_ext.oip_type = I40E_FDIR_IPTYPE_IPV6;
+
+	if (ipv6_mask == NULL && ipv6_spec == NULL)
+		return 0;
+	if (CI_FIELD_IS_MASKED(&ipv6_mask->hdr.src_addr)) {
+		memcpy(&fdir_filter->input.flow.ipv6_flow.src_ip, &ipv6_spec->hdr.src_addr, sizeof(ipv6_spec->hdr.src_addr));
+		fdir_filter->input.flow_ext.input_set |= I40E_INSET_IPV6_SRC;
+	}
+	if (CI_FIELD_IS_MASKED(&ipv6_mask->hdr.dst_addr)) {
+		memcpy(&fdir_filter->input.flow.ipv6_flow.dst_ip, &ipv6_spec->hdr.dst_addr, sizeof(ipv6_spec->hdr.dst_addr));
+		fdir_filter->input.flow_ext.input_set |= I40E_INSET_IPV6_DST;
+	}
+
+	if (!CI_FIELD_IS_ZERO(&ipv6_mask->hdr.vtc_flow)) {
+		rte_be32_t vtc_flow = rte_be_to_cpu_32(ipv6_spec->hdr.vtc_flow);
+		uint8_t tc = (uint8_t)((vtc_flow & I40E_IPV6_TC_MASK) >> I40E_FDIR_IPv6_TC_OFFSET);
+		fdir_filter->input.flow.ipv6_flow.tc = tc;
+		fdir_filter->input.flow_ext.input_set |= I40E_INSET_IPV6_TC;
+	}
+	if (!CI_FIELD_IS_ZERO(&ipv6_mask->hdr.proto)) {
+		fdir_filter->input.flow.ipv6_flow.proto = ipv6_spec->hdr.proto;
+		fdir_filter->input.flow_ext.input_set |= I40E_INSET_IPV6_NEXT_HDR;
+	}
+	if (!CI_FIELD_IS_ZERO(&ipv6_mask->hdr.hop_limits)) {
+		fdir_filter->input.flow.ipv6_flow.hop_limits = ipv6_spec->hdr.hop_limits;
+		fdir_filter->input.flow_ext.input_set |= I40E_INSET_IPV6_HOP_LIMIT;
+	}
+	/* mark as fragment traffic if necessary */
+	if (ipv6_spec->hdr.proto == I40E_IPV6_FRAG_HEADER)
+		fdir_filter->input.pctype = I40E_FILTER_PCTYPE_FRAG_IPV6;
+
+
+	return 0;
+}
+
+static int
+i40e_fdir_node_tcp_validate(const void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct i40e_fdir_ctx *fdir_ctx = ctx;
+	const struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
+	const struct rte_flow_item_tcp *tcp_spec = item->spec;
+	const struct rte_flow_item_tcp *tcp_mask = item->mask;
+
+	/* cannot match both fragmented and TCP */
+	if (fdir_filter->input.pctype == I40E_FILTER_PCTYPE_FRAG_IPV4 ||
+	    fdir_filter->input.pctype == I40E_FILTER_PCTYPE_FRAG_IPV6) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Cannot combine fragmented IP and TCP match");
+	}
+
+	if (tcp_spec == NULL && tcp_mask == NULL)
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
+				"Invalid TCP header mask");
+	}
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&tcp_mask->hdr.src_port) ||
+	    !CI_FIELD_IS_ZERO_OR_MASKED(&tcp_mask->hdr.dst_port)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid TCP header mask");
+	}
+	return 0;
+}
+
+static int
+i40e_fdir_node_tcp_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_fdir_ctx *fdir_ctx = ctx;
+	struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
+	const struct rte_flow_item_tcp *tcp_spec = item->spec;
+	const struct rte_flow_item_tcp *tcp_mask = item->mask;
+	rte_be16_t src_spec, dst_spec, src_mask, dst_mask;
+	bool is_ipv4;
+
+	/* Set layer index for L4 flexible payload */
+	fdir_filter->input.flow_ext.layer_idx = I40E_FLXPLD_L4_IDX;
+
+	/* set packet type depending on L3 type */
+	if (fdir_filter->input.flow_ext.oip_type == I40E_FDIR_IPTYPE_IPV4) {
+		fdir_filter->input.pctype = I40E_FILTER_PCTYPE_NONF_IPV4_TCP;
+	} else if (fdir_filter->input.flow_ext.oip_type == I40E_FDIR_IPTYPE_IPV6) {
+		fdir_filter->input.pctype = I40E_FILTER_PCTYPE_NONF_IPV6_TCP;
+	}
+
+	if (tcp_spec == NULL && tcp_mask == NULL)
+		return 0;
+
+	src_spec = tcp_spec->hdr.src_port;
+	dst_spec = tcp_spec->hdr.dst_port;
+	src_mask = tcp_mask->hdr.src_port;
+	dst_mask = tcp_mask->hdr.dst_port;
+	is_ipv4 = fdir_filter->input.flow_ext.oip_type == I40E_FDIR_IPTYPE_IPV4;
+
+	if (is_ipv4) {
+		if (src_mask != 0) {
+			fdir_filter->input.flow_ext.input_set |= I40E_INSET_SRC_PORT;
+			fdir_filter->input.flow.tcp4_flow.src_port = src_spec;
+		}
+		if (dst_mask) {
+			fdir_filter->input.flow_ext.input_set |= I40E_INSET_DST_PORT;
+			fdir_filter->input.flow.tcp4_flow.dst_port = dst_spec;
+		}
+	} else {
+		if (src_mask != 0) {
+			fdir_filter->input.flow_ext.input_set |= I40E_INSET_SRC_PORT;
+			fdir_filter->input.flow.tcp6_flow.src_port = src_spec;
+		}
+		if (dst_mask) {
+			fdir_filter->input.flow_ext.input_set |= I40E_INSET_DST_PORT;
+			fdir_filter->input.flow.tcp6_flow.dst_port = dst_spec;
+		}
+	}
+
+	return 0;
+}
+
+static int
+i40e_fdir_node_udp_validate(const void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct i40e_fdir_ctx *fdir_ctx = ctx;
+	const struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
+	const struct rte_flow_item_udp *udp_spec = item->spec;
+	const struct rte_flow_item_udp *udp_mask = item->mask;
+
+	/* cannot match both fragmented and TCP */
+	if (fdir_filter->input.pctype == I40E_FILTER_PCTYPE_FRAG_IPV4 ||
+	    fdir_filter->input.pctype == I40E_FILTER_PCTYPE_FRAG_IPV6) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Cannot combine fragmented IP and UDP match");
+	}
+
+	if (udp_spec == NULL && udp_mask == NULL)
+		return 0;
+
+	if (udp_mask->hdr.dgram_len || udp_mask->hdr.dgram_cksum) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid UDP header mask");
+	}
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&udp_mask->hdr.src_port) ||
+	    !CI_FIELD_IS_ZERO_OR_MASKED(&udp_mask->hdr.dst_port)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid UDP header mask");
+	}
+	return 0;
+}
+
+static int
+i40e_fdir_node_udp_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_fdir_ctx *fdir_ctx = ctx;
+	struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
+	const struct rte_flow_item_udp *udp_spec = item->spec;
+	const struct rte_flow_item_udp *udp_mask = item->mask;
+	rte_be16_t src_spec, dst_spec, src_mask, dst_mask;
+	bool is_ipv4;
+
+	/* Set layer index for L4 flexible payload */
+	fdir_filter->input.flow_ext.layer_idx = I40E_FLXPLD_L4_IDX;
+
+	/* set packet type depending on L3 type */
+	if (fdir_filter->input.flow_ext.oip_type == I40E_FDIR_IPTYPE_IPV4) {
+		fdir_filter->input.pctype = I40E_FILTER_PCTYPE_NONF_IPV4_UDP;
+	} else if (fdir_filter->input.flow_ext.oip_type == I40E_FDIR_IPTYPE_IPV6) {
+		fdir_filter->input.pctype = I40E_FILTER_PCTYPE_NONF_IPV6_UDP;
+	}
+
+	/* set UDP */
+	fdir_filter->input.flow_ext.is_udp = true;
+
+	if (udp_spec == NULL && udp_mask == NULL)
+		return 0;
+
+	src_spec = udp_spec->hdr.src_port;
+	dst_spec = udp_spec->hdr.dst_port;
+	src_mask = udp_mask->hdr.src_port;
+	dst_mask = udp_mask->hdr.dst_port;
+	is_ipv4 = fdir_filter->input.flow_ext.oip_type == I40E_FDIR_IPTYPE_IPV4;
+
+	if (is_ipv4) {
+		if (src_mask) {
+			fdir_filter->input.flow_ext.input_set |= I40E_INSET_SRC_PORT;
+			fdir_filter->input.flow.udp4_flow.src_port = src_spec;
+		}
+		if (dst_mask) {
+			fdir_filter->input.flow_ext.input_set |= I40E_INSET_DST_PORT;
+			fdir_filter->input.flow.udp4_flow.dst_port = dst_spec;
+		}
+	} else {
+		if (src_mask) {
+			fdir_filter->input.flow_ext.input_set |= I40E_INSET_SRC_PORT;
+			fdir_filter->input.flow.udp6_flow.src_port = src_spec;
+		}
+		if (dst_mask) {
+			fdir_filter->input.flow_ext.input_set |= I40E_INSET_DST_PORT;
+			fdir_filter->input.flow.udp6_flow.dst_port = dst_spec;
+		}
+	}
+
+	return 0;
+}
+
+static int
+i40e_fdir_node_sctp_validate(const void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct i40e_fdir_ctx *fdir_ctx = ctx;
+	const struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
+	const struct rte_flow_item_sctp *sctp_spec = item->spec;
+	const struct rte_flow_item_sctp *sctp_mask = item->mask;
+
+	/* cannot match both fragmented and TCP */
+	if (fdir_filter->input.pctype == I40E_FILTER_PCTYPE_FRAG_IPV4 ||
+	    fdir_filter->input.pctype == I40E_FILTER_PCTYPE_FRAG_IPV6) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Cannot combine fragmented IP and SCTP match");
+	}
+
+	if (sctp_spec == NULL && sctp_mask == NULL)
+		return 0;
+
+	if (sctp_mask->hdr.cksum) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid SCTP header mask");
+	}
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&sctp_mask->hdr.src_port) ||
+	    !CI_FIELD_IS_ZERO_OR_MASKED(&sctp_mask->hdr.dst_port) ||
+	    !CI_FIELD_IS_ZERO_OR_MASKED(&sctp_mask->hdr.tag)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid SCTP header mask");
+	}
+	return 0;
+}
+
+static int
+i40e_fdir_node_sctp_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_fdir_ctx *fdir_ctx = ctx;
+	struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
+	const struct rte_flow_item_sctp *sctp_spec = item->spec;
+	const struct rte_flow_item_sctp *sctp_mask = item->mask;
+	rte_be16_t src_spec, dst_spec, src_mask, dst_mask, tag_spec, tag_mask;
+	bool is_ipv4;
+
+	/* Set layer index for L4 flexible payload */
+	fdir_filter->input.flow_ext.layer_idx = I40E_FLXPLD_L4_IDX;
+
+	/* set packet type depending on L3 type */
+	if (fdir_filter->input.flow_ext.oip_type == I40E_FDIR_IPTYPE_IPV4) {
+		fdir_filter->input.pctype = I40E_FILTER_PCTYPE_NONF_IPV4_SCTP;
+	} else if (fdir_filter->input.flow_ext.oip_type == I40E_FDIR_IPTYPE_IPV6) {
+		fdir_filter->input.pctype = I40E_FILTER_PCTYPE_NONF_IPV6_SCTP;
+	}
+
+	if (sctp_spec == NULL && sctp_mask == NULL)
+		return 0;
+
+	if (!CI_FIELD_IS_ZERO(&sctp_mask->hdr.tag)) {
+		fdir_filter->input.flow_ext.input_set |= I40E_INSET_SCTP_VT;
+	}
+
+	src_spec = sctp_spec->hdr.src_port;
+	dst_spec = sctp_spec->hdr.dst_port;
+	src_mask = sctp_mask->hdr.src_port;
+	dst_mask = sctp_mask->hdr.dst_port;
+	tag_spec = sctp_spec->hdr.tag;
+	tag_mask = sctp_mask->hdr.tag;
+	is_ipv4 = fdir_filter->input.flow_ext.oip_type == I40E_FDIR_IPTYPE_IPV4;
+
+	if (is_ipv4) {
+		if (src_mask) {
+			fdir_filter->input.flow_ext.input_set |= I40E_INSET_SRC_PORT;
+			fdir_filter->input.flow.sctp4_flow.src_port = src_spec;
+		}
+		if (dst_mask) {
+			fdir_filter->input.flow_ext.input_set |= I40E_INSET_DST_PORT;
+			fdir_filter->input.flow.sctp4_flow.dst_port = dst_spec;
+		}
+		if (tag_mask) {
+			fdir_filter->input.flow_ext.input_set |= I40E_INSET_SCTP_VT;
+			fdir_filter->input.flow.sctp4_flow.verify_tag = tag_spec;
+		}
+	} else {
+		if (src_mask) {
+			fdir_filter->input.flow_ext.input_set |= I40E_INSET_SRC_PORT;
+			fdir_filter->input.flow.sctp6_flow.src_port = src_spec;
+		}
+		if (dst_mask) {
+			fdir_filter->input.flow_ext.input_set |= I40E_INSET_DST_PORT;
+			fdir_filter->input.flow.sctp6_flow.dst_port = dst_spec;
+		}
+		if (tag_mask) {
+			fdir_filter->input.flow_ext.input_set |= I40E_INSET_SCTP_VT;
+			fdir_filter->input.flow.sctp6_flow.verify_tag = tag_spec;
+		}
+	}
+
+	return 0;
+}
+
+static int
+i40e_fdir_node_raw_validate(const void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct i40e_fdir_ctx *fdir_ctx = ctx;
+	const struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
+	const struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(fdir_ctx->base.dev_data->dev_private);
+	const struct rte_flow_item_raw *raw_spec = item->spec;
+	const struct rte_flow_item_raw *raw_mask = item->mask;
+	enum i40e_flxpld_layer_idx raw_id = fdir_filter->input.flow_ext.raw_id;
+	size_t spec_size, spec_offset;
+	size_t total_size, i;
+	size_t new_src_offset;
+
+	/* we shouldn't write to global registers on some hardware */
+	if (pf->support_multi_driver) {
+		return rte_flow_error_set(error, ENOTSUP,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Unsupported flexible payload.");
+	}
+
+	/* Check max RAW items limit */
+	RTE_BUILD_BUG_ON(I40E_MAX_FLXPLD_LAYER != I40E_MAX_FLXPLD_FIED);
+	if (raw_id >= I40E_MAX_FLXPLD_LAYER) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Maximum 3 RAW items allowed per layer");
+	}
+
+	if (raw_spec->pattern == NULL) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"RAW spec pattern must not be NULL");
+	}
+
+	if (raw_mask->pattern == NULL) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"RAW mask pattern must not be NULL");
+	}
+
+	if (raw_mask->length != raw_spec->length &&
+	    raw_mask->length != 0xffff) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"RAW mask length must match spec length or be 0xffff");
+	}
+
+	if (raw_mask->relative || raw_mask->search ||
+	    raw_mask->reserved || raw_mask->offset || raw_mask->limit) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"RAW mask control fields are not supported");
+	}
+
+	/* Relative offset is mandatory */
+	if (!raw_spec->relative) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"RAW relative must be 1");
+	}
+
+	/* Offset must be 16-bit aligned */
+	if (raw_spec->offset % sizeof(uint16_t)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"RAW offset must be even");
+	}
+
+	/* Search and limit not supported */
+	if (raw_spec->search || raw_spec->limit) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"RAW search/limit not supported");
+	}
+
+	if (raw_spec->reserved) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"RAW reserved field must be zero");
+	}
+
+	/* Offset must be non-negative */
+	if (raw_spec->offset < 0) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"RAW offset must be non-negative");
+	}
+
+	/* flex size/offset for current item (in bytes) */
+	spec_size = raw_spec->length;
+	spec_offset = raw_spec->offset;
+
+	/*
+	 * RAW node can be triggered multiple times, each time we will be copying more data to the
+	 * flexbyte buffer. we need to validate total size/offset against max allowed because we
+	 * cannot overflow our flexbyte buffer.
+	 */
+
+	/* accumulate previous raw items' size/offset */
+	total_size = 0;
+	new_src_offset = 0;
+	for (i = 0; i < raw_id; i++) {
+		const struct flex_item *fi = &fdir_ctx->flex_data[i];
+		total_size += fi->size;
+		/* offset is relative to end of previous item */
+		new_src_offset += fi->offset + fi->size;
+	}
+	/* add current item to totals */
+	total_size += spec_size;
+	new_src_offset += spec_offset;
+
+	/* validate against max offset/size */
+	if (spec_size + new_src_offset >= I40E_MAX_FLX_SOURCE_OFF) {
+		return rte_flow_error_set(error, EINVAL,
+						RTE_FLOW_ERROR_TYPE_ITEM, item,
+						"RAW total offset exceeds maximum");
+	}
+	if (total_size > I40E_FDIR_MAX_FLEXLEN) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"RAW total size exceeds maximum");
+	}
+
+	return 0;
+}
+
+static int
+i40e_fdir_node_raw_process(void *ctx,
+			    const struct rte_flow_item *item,
+			    struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_fdir_ctx *fdir_ctx = ctx;
+	struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
+	const struct rte_flow_item_raw *raw_spec = item->spec;
+	const struct rte_flow_item_raw *raw_mask = item->mask;
+	enum i40e_flxpld_layer_idx raw_id = fdir_filter->input.flow_ext.raw_id;
+	enum i40e_flxpld_layer_idx layer_idx = fdir_filter->input.flow_ext.layer_idx;
+	size_t flex_pit_field_idx = layer_idx * I40E_MAX_FLXPLD_FIED + raw_id;
+	struct i40e_fdir_flex_pit *flex_pit;
+	size_t spec_size, spec_offset, i;
+	size_t total_size, new_src_offset;
+
+	/* flex size for current item */
+	spec_size = raw_spec->length;
+	spec_offset = raw_spec->offset;
+
+	/* accumulate previous raw items' size/offset */
+	total_size = 0;
+	new_src_offset = 0;
+	for (i = 0; i < raw_id; i++) {
+		const struct flex_item *fi = &fdir_ctx->flex_data[i];
+		total_size += fi->size;
+		/* offset is relative to end of previous item */
+		new_src_offset += fi->offset + fi->size;
+	}
+	/* src offset must also include current offset */
+	new_src_offset += spec_offset;
+
+	/* store the current data */
+	fdir_ctx->flex_data[raw_id].size = spec_size;
+	fdir_ctx->flex_data[raw_id].offset = spec_offset;
+
+	/* copy bytes from current spec into the flex pit buffer */
+	for (i = 0; i < spec_size; i++) {
+		const size_t j = total_size + i;
+		fdir_filter->input.flow_ext.flexbytes[j] = raw_spec->pattern[i];
+		fdir_filter->input.flow_ext.flex_mask[j] = raw_mask->pattern[i];
+	}
+
+	/*
+	 * all metadata in the flex pit is stored in units of 2 bytes (words),
+	 * but all the limits are in bytes, so we need to convert sizes/offsets
+	 * accordingly.
+	 */
+
+	/* pick our flex pit */
+	flex_pit = &fdir_filter->input.flow_ext.flex_pit[flex_pit_field_idx];
+	/* convert to words (2-byte units) */
+	flex_pit->src_offset = (uint16_t)new_src_offset / sizeof(uint16_t);
+	flex_pit->dst_offset = (uint16_t)total_size / sizeof(uint16_t);
+	flex_pit->size = (uint16_t)spec_size / sizeof(uint16_t);
+
+	/* increment raw item index */
+	fdir_filter->input.flow_ext.raw_id++;
+
+	/* mark as flex flow */
+	fdir_filter->input.flow_ext.is_flex_flow = true;
+
+	return 0;
+}
+
+static int
+i40e_fdir_node_esp_validate(const void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct i40e_fdir_ctx *fdir_ctx = ctx;
+	const struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(fdir_ctx->base.dev_data->dev_private);
+	const struct rte_flow_item_esp *esp_mask = item->mask;
+
+	if (!pf->esp_support) {
+		return rte_flow_error_set(error, ENOTSUP,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Protocol not supported");
+	}
+
+	/* SPI must be fully masked */
+	if (!CI_FIELD_IS_MASKED(&esp_mask->hdr.spi)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid ESP header mask");
+	}
+	return 0;
+}
+
+static int
+i40e_fdir_node_esp_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_fdir_ctx *fdir_ctx = ctx;
+	struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
+	const struct rte_flow_item_esp *esp_spec = item->spec;
+	bool is_ipv4 = fdir_filter->input.flow_ext.oip_type == I40E_FDIR_IPTYPE_IPV4;
+	bool is_udp = fdir_filter->input.flow_ext.is_udp;
+
+	/* ESP uses customized pctype */
+	fdir_filter->input.flow_ext.customized_pctype = true;
+	fdir_ctx->custom_pctype = item->type;
+
+	if (is_ipv4) {
+		if (is_udp)
+			fdir_filter->input.flow.esp_ipv4_udp_flow.spi = esp_spec->hdr.spi;
+		else {
+			fdir_filter->input.flow.esp_ipv4_flow.spi = esp_spec->hdr.spi;
+		}
+	} else {
+		if (is_udp)
+			fdir_filter->input.flow.esp_ipv6_udp_flow.spi = esp_spec->hdr.spi;
+		else {
+			fdir_filter->input.flow.esp_ipv6_flow.spi = esp_spec->hdr.spi;
+		}
+	}
+
+	return 0;
+}
+
+static int
+i40e_fdir_node_l2tpv3oip_validate(const void *ctx __rte_unused,
+				   const struct rte_flow_item *item,
+				   struct rte_flow_error *error)
+{
+	const struct rte_flow_item_l2tpv3oip *l2tp_mask = item->mask;
+
+	if (!CI_FIELD_IS_MASKED(&l2tp_mask->session_id)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid L2TPv3oIP header mask");
+	}
+	return 0;
+
+}
+
+static int
+i40e_fdir_node_l2tpv3oip_process(void *ctx,
+				  const struct rte_flow_item *item,
+				  struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_fdir_ctx *fdir_ctx = ctx;
+	struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
+	const struct rte_flow_item_l2tpv3oip *l2tp_spec = item->spec;
+
+	/* L2TPv3 uses customized pctype */
+	fdir_filter->input.flow_ext.customized_pctype = true;
+	fdir_ctx->custom_pctype = item->type;
+
+	/* Store session_id in appropriate flow union member based on IP version */
+	if (fdir_filter->input.flow_ext.oip_type == I40E_FDIR_IPTYPE_IPV4) {
+		fdir_filter->input.flow.ip4_l2tpv3oip_flow.session_id = l2tp_spec->session_id;
+	} else if (fdir_filter->input.flow_ext.oip_type == I40E_FDIR_IPTYPE_IPV6) {
+		fdir_filter->input.flow.ip6_l2tpv3oip_flow.session_id = l2tp_spec->session_id;
+	}
+
+	return 0;
+}
+
+static int
+i40e_fdir_node_gtp_validate(const void *ctx __rte_unused, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct i40e_fdir_ctx *fdir_ctx = ctx;
+	const struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(fdir_ctx->base.dev_data->dev_private);
+	const struct rte_flow_item_gtp *gtp_mask = item->mask;
+
+	/* DDP may not support this packet type */
+	if (!pf->gtp_support) {
+		return rte_flow_error_set(error, ENOTSUP,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Protocol not supported");
+	}
+
+	if (gtp_mask->hdr.gtp_hdr_info ||
+	    gtp_mask->hdr.msg_type ||
+	    gtp_mask->hdr.plen) {
+		return rte_flow_error_set(error, EINVAL,
+					  RTE_FLOW_ERROR_TYPE_ITEM, item,
+					  "Invalid GTP header mask");
+	}
+	/* if GTP is specified, TEID must be masked */
+	if (!CI_FIELD_IS_MASKED(&gtp_mask->hdr.teid)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid GTP header mask");
+	}
+	return 0;
+}
+
+static int
+i40e_fdir_node_gtp_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_fdir_ctx *fdir_ctx = ctx;
+	struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
+	const struct rte_flow_item_gtp *gtp_spec = item->spec;
+
+	/* Mark as GTP tunnel with customized pctype */
+	fdir_filter->input.flow_ext.customized_pctype = true;
+	fdir_ctx->custom_pctype = item->type;
+
+	fdir_filter->input.flow.gtp_flow.teid = gtp_spec->teid;
+
+	return 0;
+}
+
+static int
+i40e_fdir_node_inner_ipv4_process(void *ctx, const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_fdir_ctx *fdir_ctx = ctx;
+	struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
+
+	/* Mark as inner IP */
+	fdir_filter->input.flow_ext.inner_ip = true;
+	fdir_filter->input.flow_ext.iip_type = I40E_FDIR_IPTYPE_IPV4;
+
+	return 0;
+}
+
+static int
+i40e_fdir_node_inner_ipv6_process(void *ctx, const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_fdir_ctx *fdir_ctx = ctx;
+	struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
+
+	/* Mark as inner IP */
+	fdir_filter->input.flow_ext.inner_ip = true;
+	fdir_filter->input.flow_ext.iip_type = I40E_FDIR_IPTYPE_IPV6;
+
+	return 0;
+}
+
+/* END node validation for FDIR - performs pctype determination and input_set validation */
+static int
+i40e_fdir_node_end_validate(const void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct i40e_fdir_ctx *fdir_ctx = ctx;
+	const struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
+	uint64_t input_set = fdir_filter->input.flow_ext.input_set;
+	enum i40e_filter_pctype pctype = fdir_filter->input.pctype;
+
+	/*
+	 * Before sending the configuration down to hardware, we need to make
+	 * sure that the configuration makes sense - more specifically, that the
+	 * input set is a valid one that is actually supported by the hardware.
+	 * This is validated for built-in ptypes, however for customized ptypes,
+	 * the validation is skipped, and we have no way of validating the input
+	 * set because we do not have that information at our disposal - the
+	 * input set for customized packet type is not available through DDP
+	 * queries.
+	 *
+	 * However, we do know that some things are unsupported by the hardware no matter the
+	 * configuration. We can check for them here.
+	 */
+	const uint64_t i40e_l2_input_set = I40E_INSET_DMAC | I40E_INSET_SMAC;
+	const uint64_t i40e_l3_input_set = (I40E_INSET_IPV4_SRC | I40E_INSET_IPV4_DST |
+					    I40E_INSET_IPV4_TOS | I40E_INSET_IPV4_TTL |
+					    I40E_INSET_IPV4_PROTO);
+	const uint64_t i40e_l4_input_set = (I40E_INSET_SRC_PORT | I40E_INSET_DST_PORT);
+	const bool l2_in_set = (input_set & i40e_l2_input_set) != 0;
+	const bool l3_in_set = (input_set & i40e_l3_input_set) != 0;
+	const bool l4_in_set = (input_set & i40e_l4_input_set) != 0;
+
+	/* if we're matching ethertype, we may be matching L2 only, and cannot have RAW patterns */
+	if ((input_set & I40E_INSET_LAST_ETHER_TYPE) != 0 &&
+	     (pctype != I40E_FILTER_PCTYPE_L2_PAYLOAD ||
+	      fdir_filter->input.flow_ext.is_flex_flow)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Cannot match ethertype with L3/L4 or RAW patterns");
+	}
+
+	/* L2 and L3 input sets are exclusive */
+	if (l2_in_set && l3_in_set) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Matching both L2 and L3 is not supported");
+	}
+	/* L2 and L4 input sets are exclusive */
+	if (l2_in_set && l4_in_set) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Matching both L2 and L4 is not supported");
+	}
+
+	/* if we are using one of the builtin packet types, validate it */
+	if (!fdir_filter->input.flow_ext.customized_pctype) {
+		/* validate the input set for the built-in pctype */
+		if (i40e_validate_input_set(pctype, RTE_ETH_FILTER_FDIR, input_set) != 0) {
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM, item,
+					"Invalid input set");
+		}
+	}
+
+	return 0;
+}
+
+static int
+i40e_fdir_node_end_process(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	struct i40e_fdir_ctx *fdir_ctx = ctx;
+	struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(fdir_ctx->base.dev_data->dev_private);
+
+	/* Get customized pctype value */
+	if (fdir_filter->input.flow_ext.customized_pctype) {
+		enum i40e_filter_pctype pctype = i40e_flow_fdir_get_pctype_value(pf,
+				fdir_ctx->custom_pctype, fdir_filter);
+		if (pctype == I40E_FILTER_PCTYPE_INVALID) {
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM, item,
+					"Unsupported packet type");
+		}
+		/* update FDIR packet type */
+		fdir_filter->input.pctype = pctype;
+	}
+
+	return 0;
+}
+
+static const struct flow_graph i40e_fdir_graph = {
+	.nodes = (struct flow_graph_node[]) {
+		[I40E_FDIR_NODE_START] = { .name = "START" },
+		[I40E_FDIR_NODE_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+				       FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_fdir_node_eth_validate,
+			.process = i40e_fdir_node_eth_process,
+		},
+		[I40E_FDIR_NODE_VLAN] = {
+			.name = "VLAN",
+			.type = RTE_FLOW_ITEM_TYPE_VLAN,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+				       FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_fdir_node_vlan_validate,
+			.process = i40e_fdir_node_vlan_process,
+		},
+		[I40E_FDIR_NODE_IPV4] = {
+			.name = "IPv4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+				       FLOW_GRAPH_NODE_EXPECT_SPEC_MASK |
+				       FLOW_GRAPH_NODE_EXPECT_RANGE,
+			.validate = i40e_fdir_node_ipv4_validate,
+			.process = i40e_fdir_node_ipv4_process,
+		},
+		[I40E_FDIR_NODE_IPV6] = {
+			.name = "IPv6",
+			.type = RTE_FLOW_ITEM_TYPE_IPV6,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+				       FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_fdir_node_ipv6_validate,
+			.process = i40e_fdir_node_ipv6_process,
+		},
+		[I40E_FDIR_NODE_TCP] = {
+			.name = "TCP",
+			.type = RTE_FLOW_ITEM_TYPE_TCP,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+				       FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_fdir_node_tcp_validate,
+			.process = i40e_fdir_node_tcp_process,
+		},
+		[I40E_FDIR_NODE_UDP] = {
+			.name = "UDP",
+			.type = RTE_FLOW_ITEM_TYPE_UDP,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+				       FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_fdir_node_udp_validate,
+			.process = i40e_fdir_node_udp_process,
+		},
+		[I40E_FDIR_NODE_SCTP] = {
+			.name = "SCTP",
+			.type = RTE_FLOW_ITEM_TYPE_SCTP,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+				       FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_fdir_node_sctp_validate,
+			.process = i40e_fdir_node_sctp_process,
+		},
+		[I40E_FDIR_NODE_ESP] = {
+			.name = "ESP",
+			.type = RTE_FLOW_ITEM_TYPE_ESP,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_fdir_node_esp_validate,
+			.process = i40e_fdir_node_esp_process,
+		},
+		[I40E_FDIR_NODE_L2TPV3OIP] = {
+			.name = "L2TPV3OIP",
+			.type = RTE_FLOW_ITEM_TYPE_L2TPV3OIP,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_fdir_node_l2tpv3oip_validate,
+			.process = i40e_fdir_node_l2tpv3oip_process,
+		},
+		[I40E_FDIR_NODE_GTPC] = {
+			.name = "GTPC",
+			.type = RTE_FLOW_ITEM_TYPE_GTPC,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_fdir_node_gtp_validate,
+			.process = i40e_fdir_node_gtp_process,
+		},
+		[I40E_FDIR_NODE_GTPU] = {
+			.name = "GTPU",
+			.type = RTE_FLOW_ITEM_TYPE_GTPU,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_fdir_node_gtp_validate,
+			.process = i40e_fdir_node_gtp_process,
+		},
+		[I40E_FDIR_NODE_INNER_IPV4] = {
+			.name = "INNER_IPv4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+			.validate = i40e_fdir_node_ipv4_validate,
+			.process = i40e_fdir_node_inner_ipv4_process,
+		},
+		[I40E_FDIR_NODE_INNER_IPV6] = {
+			.name = "INNER_IPv6",
+			.type = RTE_FLOW_ITEM_TYPE_IPV6,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+			.validate = i40e_fdir_node_ipv6_validate,
+			.process = i40e_fdir_node_inner_ipv6_process,
+		},
+		[I40E_FDIR_NODE_RAW] = {
+			.name = "RAW",
+			.type = RTE_FLOW_ITEM_TYPE_RAW,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_fdir_node_raw_validate,
+			.process = i40e_fdir_node_raw_process,
+		},
+		[I40E_FDIR_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+			.validate = i40e_fdir_node_end_validate,
+			.process = i40e_fdir_node_end_process
+		},
+	},
+	.edges = (struct flow_graph_edge[]) {
+		[I40E_FDIR_NODE_START] = {
+			.next = (size_t[]) {
+				I40E_FDIR_NODE_ETH,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_ETH] = {
+			.next = (size_t[]) {
+				I40E_FDIR_NODE_VLAN,
+				I40E_FDIR_NODE_IPV4,
+				I40E_FDIR_NODE_IPV6,
+				I40E_FDIR_NODE_RAW,
+				I40E_FDIR_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_VLAN] = {
+			.next = (size_t[]) {
+				I40E_FDIR_NODE_IPV4,
+				I40E_FDIR_NODE_IPV6,
+				I40E_FDIR_NODE_RAW,
+				I40E_FDIR_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_IPV4] = {
+			.next = (size_t[]) {
+				I40E_FDIR_NODE_TCP,
+				I40E_FDIR_NODE_UDP,
+				I40E_FDIR_NODE_SCTP,
+				I40E_FDIR_NODE_ESP,
+				I40E_FDIR_NODE_L2TPV3OIP,
+				I40E_FDIR_NODE_RAW,
+				I40E_FDIR_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_IPV6] = {
+			.next = (size_t[]) {
+				I40E_FDIR_NODE_TCP,
+				I40E_FDIR_NODE_UDP,
+				I40E_FDIR_NODE_SCTP,
+				I40E_FDIR_NODE_ESP,
+				I40E_FDIR_NODE_L2TPV3OIP,
+				I40E_FDIR_NODE_RAW,
+				I40E_FDIR_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_TCP] = {
+			.next = (size_t[]) {
+				I40E_FDIR_NODE_RAW,
+				I40E_FDIR_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_UDP] = {
+			.next = (size_t[]) {
+				I40E_FDIR_NODE_GTPC,
+				I40E_FDIR_NODE_GTPU,
+				I40E_FDIR_NODE_ESP,
+				I40E_FDIR_NODE_RAW,
+				I40E_FDIR_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_SCTP] = {
+			.next = (size_t[]) {
+				I40E_FDIR_NODE_RAW,
+				I40E_FDIR_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_ESP] = {
+			.next = (size_t[]) {
+				I40E_FDIR_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_L2TPV3OIP] = {
+			.next = (size_t[]) {
+				I40E_FDIR_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_GTPC] = {
+			.next = (size_t[]) {
+				I40E_FDIR_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_GTPU] = {
+			.next = (size_t[]) {
+				I40E_FDIR_NODE_INNER_IPV4,
+				I40E_FDIR_NODE_INNER_IPV6,
+				I40E_FDIR_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_INNER_IPV4] = {
+			.next = (size_t[]) {
+				I40E_FDIR_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_INNER_IPV6] = {
+			.next = (size_t[]) {
+				I40E_FDIR_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_RAW] = {
+			.next = (size_t[]) {
+				I40E_FDIR_NODE_RAW,
+				I40E_FDIR_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+static int
+i40e_fdir_action_check(const struct ci_flow_actions *actions,
+		const struct ci_flow_actions_check_param *param,
+		struct rte_flow_error *error)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(param->driver_ctx);
+	const struct rte_flow_action *first, *second;
+
+	first = actions->actions[0];
+	/* can be NULL */
+	second = actions->actions[1];
+
+	switch (first->type) {
+	case RTE_FLOW_ACTION_TYPE_QUEUE:
+	{
+		const struct rte_flow_action_queue *act_q = first->conf;
+		/* check against PF constraints */
+		if (act_q->index >= pf->dev_data->nb_rx_queues) {
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ACTION, first,
+					"Invalid queue ID for FDIR");
+		}
+		break;
+	}
+	case RTE_FLOW_ACTION_TYPE_DROP:
+	case RTE_FLOW_ACTION_TYPE_PASSTHRU:
+	case RTE_FLOW_ACTION_TYPE_MARK:
+		break;
+	default:
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, first,
+				"Invalid first action for FDIR");
+	}
+
+	/* do we have another? */
+	if (second == NULL)
+		return 0;
+
+	switch (second->type) {
+	case RTE_FLOW_ACTION_TYPE_MARK:
+	{
+		/* only one mark action can be specified */
+		if (first->type == RTE_FLOW_ACTION_TYPE_MARK) {
+			return rte_flow_error_set(error, EINVAL,
+						  RTE_FLOW_ERROR_TYPE_ACTION, second,
+						  "Invalid second action for FDIR");
+		}
+		break;
+	}
+	case RTE_FLOW_ACTION_TYPE_FLAG:
+	{
+		/* mark + flag is unsupported */
+		if (first->type == RTE_FLOW_ACTION_TYPE_MARK) {
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ACTION, second,
+					"Invalid second action for FDIR");
+		}
+		break;
+	}
+	case RTE_FLOW_ACTION_TYPE_RSS:
+		/* RSS filter only can be after passthru or mark */
+		if (first->type != RTE_FLOW_ACTION_TYPE_PASSTHRU &&
+				first->type != RTE_FLOW_ACTION_TYPE_MARK) {
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ACTION, second,
+					"Invalid second action for FDIR");
+		}
+		break;
+	default:
+		return rte_flow_error_set(error, EINVAL,
+					  RTE_FLOW_ERROR_TYPE_ACTION, second,
+					  "Invalid second action for FDIR");
+	}
+
+	return 0;
+}
+
+static int
+i40e_fdir_ctx_init(const struct rte_flow_action *actions,
+		const struct rte_flow_attr *attr,
+		struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	struct i40e_adapter *adapter = I40E_DEV_PRIVATE_TO_ADAPTER(ctx->dev_data->dev_private);
+	struct i40e_fdir_ctx *fdir_ctx = (struct i40e_fdir_ctx *)ctx;
+	struct ci_flow_actions parsed_actions = {0};
+	struct ci_flow_actions_check_param ac_param = {
+		.allowed_types = (enum rte_flow_action_type[]) {
+			RTE_FLOW_ACTION_TYPE_QUEUE,
+			RTE_FLOW_ACTION_TYPE_DROP,
+			RTE_FLOW_ACTION_TYPE_PASSTHRU,
+			RTE_FLOW_ACTION_TYPE_MARK,
+			RTE_FLOW_ACTION_TYPE_FLAG,
+			RTE_FLOW_ACTION_TYPE_RSS,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.max_actions = 2,
+		.driver_ctx = adapter,
+		.check = i40e_fdir_action_check,
+	};
+	int ret;
+	const struct rte_flow_action *first, *second;
+
+	ret = ci_flow_check_attr(attr, NULL, error);
+	if (ret) {
+		return ret;
+	}
+
+	ret = ci_flow_check_actions(actions, &ac_param, &parsed_actions, error);
+	if (ret) {
+		return ret;
+	}
+
+	first = parsed_actions.actions[0];
+	/* can be NULL */
+	second = parsed_actions.actions[1];
+
+	if (first->type == RTE_FLOW_ACTION_TYPE_QUEUE) {
+		const struct rte_flow_action_queue *act_q = first->conf;
+		fdir_ctx->fdir_filter.action.rx_queue = act_q->index;
+		fdir_ctx->fdir_filter.action.behavior = I40E_FDIR_ACCEPT;
+	} else if (first->type == RTE_FLOW_ACTION_TYPE_DROP) {
+		fdir_ctx->fdir_filter.action.behavior = I40E_FDIR_REJECT;
+	} else if (first->type == RTE_FLOW_ACTION_TYPE_PASSTHRU) {
+		fdir_ctx->fdir_filter.action.behavior = I40E_FDIR_PASSTHRU;
+	} else if (first->type == RTE_FLOW_ACTION_TYPE_MARK) {
+		const struct rte_flow_action_mark *act_m = first->conf;
+		fdir_ctx->fdir_filter.action.behavior = I40E_FDIR_PASSTHRU;
+		fdir_ctx->fdir_filter.action.report_status = I40E_FDIR_REPORT_ID;
+		fdir_ctx->fdir_filter.soft_id = act_m->id;
+	}
+
+	if (second != NULL) {
+		if (second->type == RTE_FLOW_ACTION_TYPE_MARK) {
+			const struct rte_flow_action_mark *act_m = second->conf;
+			fdir_ctx->fdir_filter.action.report_status = I40E_FDIR_REPORT_ID;
+			fdir_ctx->fdir_filter.soft_id = act_m->id;
+		} else if (second->type == RTE_FLOW_ACTION_TYPE_FLAG) {
+			fdir_ctx->fdir_filter.action.report_status = I40E_FDIR_NO_REPORT_STATUS;
+		}
+		/* RSS action does nothing */
+	}
+	return 0;
+}
+
+static int
+i40e_fdir_ctx_to_flow(const struct ci_flow_engine_ctx *ctx,
+		struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct i40e_fdir_ctx *fdir_ctx = (const struct i40e_fdir_ctx *)ctx;
+	struct i40e_flow_engine_fdir_flow *fdir_flow = (struct i40e_flow_engine_fdir_flow *)flow;
+
+	fdir_flow->fdir_filter = fdir_ctx->fdir_filter;
+
+	return 0;
+}
+
+/* Add a flow director filter into the SW hash table */
+static int
+i40e_fdir_filter_hash_add(struct i40e_fdir_engine_priv *priv,
+		const struct i40e_fdir_input *filter_key)
+{
+	int ret;
+
+	/* try to find the filter in the hash table first */
+	ret = rte_hash_lookup(priv->hash_table, filter_key);
+	if (ret >= 0) {
+		PMD_DRV_LOG(ERR, "Filter already exists!");
+		return -EEXIST;
+	}
+
+	ret = rte_hash_add_key(priv->hash_table, filter_key);
+	if (ret < 0) {
+		PMD_DRV_LOG(ERR, "Failed to insert fdir filter: %s", rte_strerror(-ret));
+		return ret;
+	}
+
+	return 0;
+}
+
+/* Delete a flow director filter from the SW hash table */
+static int
+i40e_fdir_filter_hash_del(struct i40e_fdir_engine_priv *priv,
+		const struct i40e_fdir_input *filter_key)
+{
+	int ret;
+
+	ret = rte_hash_del_key(priv->hash_table, filter_key);
+	if (ret < 0) {
+		PMD_DRV_LOG(ERR,
+			    "Failed to delete fdir filter: %s", rte_strerror(-ret));
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * Records the filter and everything derived from it.
+ */
+static int
+i40e_fdir_filter_register(struct i40e_fdir_engine_priv *priv,
+		struct i40e_pf *pf,
+		const struct i40e_fdir_filter *filter,
+		struct rte_flow_error *error)
+{
+	struct rte_eth_dev_data *dev_data = pf->dev_data;
+	enum i40e_filter_pctype pctype = i40e_fdir_filter_pctype(filter);
+	uint64_t input_set = filter->input.flow_ext.input_set;
+	struct i40e_fdir_flow_store *flows = &pf->fdir.flows;
+	struct i40e_fdir_pctype_state *state = &flows->pctype[pctype];
+	struct i40e_fdir_layer_state *layer = NULL;
+	struct i40e_fdir_flex_mask flex_mask = {0};
+	bool common_pctype, needs_teardown = false;
+	int ret;
+
+	ret = i40e_fdir_engine_init(pf);
+	if (ret < 0) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Failed to initialize flow director engine");
+	}
+	/* if we are initializing, we tear it down */
+	needs_teardown = pf->fdir.fdir_actual_cnt == 0;
+
+	/* check input set if the packet type is common */
+	common_pctype = !filter->input.flow_ext.customized_pctype;
+
+	if (common_pctype) {
+		ret = i40e_fdir_inset_check(pf, pctype, input_set);
+		if (ret < 0) {
+			ret = rte_flow_error_set(error, -ret,
+					RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+					"Invalid input set");
+			goto err;
+		}
+	}
+
+	/* check if flex flow configuration is valid */
+	if (filter->input.flow_ext.is_flex_flow) {
+		ret = i40e_fdir_flex_check(pf, filter, pctype, &flex_mask);
+		if (ret < 0) {
+			ret = rte_flow_error_set(error, -ret,
+					RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+					"Invalid flex flow configuration");
+			goto err;
+		}
+	}
+
+	/* register the flow with the hash table */
+	ret = i40e_fdir_filter_hash_add(priv, &filter->input);
+	if (ret < 0) {
+		ret = rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Failed to register fdir filter");
+		goto err;
+	}
+
+	/* save additional configuration */
+	if (common_pctype)
+		state->input_set = input_set;
+
+	if (filter->input.flow_ext.is_flex_flow) {
+		i40e_fdir_flex_store(pf, filter, pctype, &flex_mask);
+		layer = &flows->layer[filter->input.flow_ext.layer_idx];
+		layer->flex_flow_count++;
+		layer->flex_pit_flag = true;
+		state->flex_mask_flag = true;
+	}
+
+	state->flow_count++;
+	pf->fdir.fdir_actual_cnt++;
+
+	/* synchronize fdir processing queue flags */
+	i40e_fdir_rx_proc_sync(dev_data);
+
+	return 0;
+err:
+	if (needs_teardown)
+		i40e_fdir_teardown(pf);
+
+	return ret;
+}
+
+/**
+ * i40e_fdir_filter_unregister - drop software ownership of a filter.
+ */
+static int
+i40e_fdir_filter_unregister(struct i40e_fdir_engine_priv *priv,
+		struct i40e_pf *pf,
+		const struct i40e_fdir_filter *filter,
+		struct rte_flow_error *error)
+{
+	struct rte_eth_dev_data *dev_data = pf->dev_data;
+	enum i40e_filter_pctype pctype = i40e_fdir_filter_pctype(filter);
+	enum i40e_flxpld_layer_idx layer_idx = filter->input.flow_ext.layer_idx;
+	bool is_flex_flow = filter->input.flow_ext.is_flex_flow;
+	struct i40e_fdir_flow_store *flows = &pf->fdir.flows;
+	struct i40e_fdir_pctype_state *state = &flows->pctype[pctype];
+	struct i40e_fdir_layer_state *layer = &flows->layer[layer_idx];
+	int ret;
+
+	ret = i40e_fdir_filter_hash_del(priv, &filter->input);
+	if (ret < 0) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Failed to unregister fdir filter");
+	}
+
+	if (is_flex_flow && --layer->flex_flow_count == 0)
+		layer->flex_pit_flag = false;
+
+	if (--state->flow_count == 0)
+		state->flex_mask_flag = false;
+
+	pf->fdir.fdir_actual_cnt--;
+
+	/* synchronize fdir processing queue flags */
+	i40e_fdir_rx_proc_sync(dev_data);
+
+	/* if there are no more FDIR flows, teardown FDIR */
+	if (pf->fdir.fdir_actual_cnt == 0)
+		i40e_fdir_teardown(pf);
+
+	return 0;
+}
+
+static int
+i40e_fdir_flow_register(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct i40e_fdir_engine_priv *priv = flow->engine_priv;
+	struct i40e_flow_engine_fdir_flow *fdir_flow = (struct i40e_flow_engine_fdir_flow *)flow;
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(flow->dev_data->dev_private);
+
+	/*
+	 * fdir_space_size is a hardware capacity limit, not just the size of the
+	 * allocator's SW tracking pool. If it's already reached, reject the flow
+	 * here instead of letting the allocator's rte_zmalloc fallback paper
+	 * over a request hardware has no room for.
+	 */
+	if (pf->fdir.fdir_actual_cnt >= pf->fdir.fdir_space_size) {
+		return rte_flow_error_set(error, ENOSPC,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"FDIR filter space is full");
+	}
+
+	return i40e_fdir_filter_register(priv, pf, &fdir_flow->fdir_filter, error);
+}
+
+static int
+i40e_fdir_flow_unregister(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct i40e_fdir_engine_priv *priv = flow->engine_priv;
+	struct i40e_flow_engine_fdir_flow *fdir_flow = (struct i40e_flow_engine_fdir_flow *)flow;
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(flow->dev_data->dev_private);
+
+	return i40e_fdir_filter_unregister(priv, pf, &fdir_flow->fdir_filter, error);
+}
+
+static int
+i40e_fdir_flow_install(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct i40e_flow_engine_fdir_flow *fdir_flow = (struct i40e_flow_engine_fdir_flow *)flow;
+	struct rte_eth_dev_data *dev_data = flow->dev_data;
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev_data->dev_private);
+	bool needs_wait;
+	int ret;
+
+	/*
+	 * when installing a flow, it may so happen that the flow is being
+	 * allocated from shared fdir pool, so we need to wait for adminq to
+	 * return status to know if the flow was actually installed.
+	 *
+	 * however, there are cases where the wait is not needed. one case is
+	 * when we are re-installing the flow (HW will update existing filter so
+	 * the flow is already there). another case is if we know that we are
+	 * not using the shared pool.
+	 */
+	needs_wait = fdir_flow->installed == false &&
+		i40e_fdir_filter_needs_status_wait(pf, pf->fdir.fdir_actual_cnt);
+
+	ret = i40e_fdir_filter_program(pf, &fdir_flow->fdir_filter, true, needs_wait);
+	if (ret != 0) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_HANDLE, flow,
+				"Failed to program fdir filter.");
+	}
+
+	/* flow is installed, don't wait next time */
+	fdir_flow->installed = true;
+
+	return 0;
+}
+
+static int
+i40e_fdir_flow_uninstall(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct rte_eth_dev_data *dev_data = flow->dev_data;
+	struct i40e_flow_engine_fdir_flow *fdir_flow = (struct i40e_flow_engine_fdir_flow *)flow;
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev_data->dev_private);
+	int ret;
+
+	/* removal does not need wait */
+	ret = i40e_fdir_filter_program(pf, &fdir_flow->fdir_filter, false, false);
+	if (ret != 0) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_HANDLE,
+				flow, "Failed to deprogram fdir filter.");
+	}
+	return 0;
+}
+
+static int
+i40e_fdir_flow_engine_init(const struct ci_flow_engine *engine,
+		struct rte_eth_dev_data *dev_data,
+		void *priv_data)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev_data->dev_private);
+	struct i40e_fdir_info *fdir_info = &pf->fdir;
+	struct i40e_fdir_engine_priv *priv = priv_data;
+	char fdir_hash_name[RTE_HASH_NAMESIZE];
+	struct i40e_fdir_flow_pool_entry *pool;
+	struct rte_hash *hash_table;
+	struct rte_bitmap *bmp;
+	uint32_t bmp_size;
+	void *bmp_mem;
+	uint32_t i;
+	int ret;
+
+	snprintf(fdir_hash_name, sizeof(fdir_hash_name), "fdir_hash_%s", engine->name);
+
+	struct rte_hash_parameters fdir_hash_params = {
+		.name = fdir_hash_name,
+		.entries = I40E_MAX_FDIR_FILTER_NUM,
+		.key_len = sizeof(struct i40e_fdir_input),
+		.hash_func = rte_hash_crc,
+		.hash_func_init_val = 0,
+		.socket_id = rte_socket_id(),
+	};
+
+	hash_table = rte_hash_create(&fdir_hash_params);
+	if (hash_table == NULL) {
+		PMD_INIT_LOG(ERR, "Failed to create fdir hash table: %s", rte_strerror(rte_errno));
+		ret = -rte_errno;
+		goto err_hash;
+	}
+
+	pool = rte_zmalloc(engine->name,
+			fdir_info->fdir_space_size * sizeof(*pool), 0);
+	if (pool == NULL) {
+		PMD_INIT_LOG(ERR, "Failed to allocate fdir pool");
+		ret = -ENOMEM;
+		goto err_pool;
+	}
+
+	bmp_size = rte_bitmap_get_memory_footprint(fdir_info->fdir_space_size);
+	bmp_mem = rte_zmalloc("fdir_bmap", bmp_size, RTE_CACHE_LINE_SIZE);
+	if (bmp_mem == NULL) {
+		PMD_INIT_LOG(ERR, "Failed to allocate fdir bitmap");
+		ret = -ENOMEM;
+		goto err_bitmap_mem;
+	}
+
+	bmp = rte_bitmap_init(fdir_info->fdir_space_size, bmp_mem, bmp_size);
+	if (bmp == NULL) {
+		PMD_INIT_LOG(ERR, "Failed to initialize fdir bitmap: %s", rte_strerror(rte_errno));
+		ret = -rte_errno;
+		goto err_bitmap;
+	}
+
+	for (i = 0; i < fdir_info->fdir_space_size; i++) {
+		pool[i].idx = i;
+		rte_bitmap_set(bmp, i);
+	}
+
+	priv->pool = pool;
+	priv->bitmap = bmp;
+	priv->hash_table = hash_table;
+
+	return 0;
+err_bitmap:
+	rte_free(bmp_mem);
+err_bitmap_mem:
+	rte_free(pool);
+err_pool:
+	rte_hash_free(hash_table);
+err_hash:
+	return ret;
+}
+
+static void
+i40e_fdir_flow_engine_uninit(const struct ci_flow_engine *engine __rte_unused,
+		void *priv_data)
+{
+	struct i40e_fdir_engine_priv *priv = priv_data;
+
+	rte_free(priv->bitmap);
+	rte_free(priv->pool);
+	rte_hash_free(priv->hash_table);
+}
+
+static struct ci_flow *
+i40e_fdir_flow_alloc(const struct ci_flow_engine *engine __rte_unused,
+		struct rte_eth_dev_data *dev_data,
+		void *priv_data)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev_data->dev_private);
+	struct i40e_fdir_info *fdir_info = &pf->fdir;
+	struct i40e_fdir_engine_priv *priv = priv_data;
+	struct i40e_flow_engine_fdir_flow *flow;
+	uint64_t slab = 0;
+	uint32_t pos = 0;
+	uint32_t bit;
+	size_t mem_sz;
+	int ret;
+
+	if (fdir_info->fdir_actual_cnt >= fdir_info->fdir_space_size)
+		return NULL;
+
+	ret = rte_bitmap_scan(priv->bitmap, &pos, &slab);
+	if (ret == 0)
+		return NULL;
+
+	bit = rte_bsf64(slab);
+	pos += bit;
+	rte_bitmap_clear(priv->bitmap, pos);
+
+	flow = &priv->pool[pos].flow;
+	/* do not touch ci_flow members, they are initialized by the caller */
+	mem_sz = sizeof(*flow) - sizeof(struct ci_flow);
+
+	memset(RTE_PTR_ADD(flow, sizeof(struct ci_flow)), 0, mem_sz);
+	return (struct ci_flow *)flow;
+}
+
+static void
+i40e_fdir_flow_free(struct ci_flow *flow,
+		struct rte_eth_dev_data *dev_data __rte_unused,
+		void *priv_data)
+{
+	struct i40e_fdir_engine_priv *priv = priv_data;
+	struct i40e_fdir_flow_pool_entry *entry;
+
+	entry = I40E_FDIR_FLOW_ENTRY((struct i40e_flow_engine_fdir_flow *)flow);
+	/* idx is not set at alloc, it's set at init */
+	rte_bitmap_set(priv->bitmap, entry->idx);
+}
+
+static const struct ci_flow_engine_ops i40e_flow_engine_fdir_ops = {
+	.engine_init = i40e_fdir_flow_engine_init,
+	.engine_uninit = i40e_fdir_flow_engine_uninit,
+	.flow_alloc = i40e_fdir_flow_alloc,
+	.flow_free = i40e_fdir_flow_free,
+	.ctx_init = i40e_fdir_ctx_init,
+	.ctx_to_flow = i40e_fdir_ctx_to_flow,
+	.flow_register = i40e_fdir_flow_register,
+	.flow_unregister = i40e_fdir_flow_unregister,
+	.flow_install = i40e_fdir_flow_install,
+	.flow_uninstall = i40e_fdir_flow_uninstall,
+};
+
+const struct ci_flow_engine i40e_flow_engine_fdir = {
+	.name = "fdir",
+	.ops = &i40e_flow_engine_fdir_ops,
+	.ctx_size = sizeof(struct i40e_fdir_ctx),
+	.flow_size = sizeof(struct i40e_flow_engine_fdir_flow),
+	.priv_size = sizeof(struct i40e_fdir_engine_priv),
+	.graph = &i40e_fdir_graph,
+};
diff --git a/drivers/net/intel/i40e/meson.build b/drivers/net/intel/i40e/meson.build
index ddc97f9b3b..c07257cb80 100644
--- a/drivers/net/intel/i40e/meson.build
+++ b/drivers/net/intel/i40e/meson.build
@@ -34,6 +34,7 @@ sources += files(
         'i40e_fdir.c',
         'i40e_flow.c',
         'i40e_flow_ethertype.c',
+        'i40e_flow_fdir.c',
         'i40e_tm.c',
         'i40e_hash.c',
         'i40e_vf_representor.c',
-- 
2.52.0

