Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15D7C79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 15:24:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70B27427A2;
	Tue,  8 Sep 2026 17:22:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 5DFF340EE1
 for <dev@dpdk.org>; Tue,  8 Sep 2026 17:22:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788880945; x=1820416945;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=AXoy/J+6pvRn+vRb/yZQbD5yRpk5VGFOq55izt5iz50=;
 b=NflnDDmWxuri25NYGWekIJELR0oSP8BGTQmS/y9r3z1jWDukhM0sDD/H
 URdsqEhu60q9Dp8iF/zCoomrVv5lnWV2xdM58LWiQZ2LuwFNP4SgSEYjQ
 aq4jWEveHv1S0OeGYHiJkNOxobnef+5kz5Bvb+zMy/7s2oCLS8TwvYgoL
 bRJKevuwwK7rEzDyMq49osBwf0rRoaB089gLMExf/+YSaZ7znO2L7U49s
 YJhvGwYJ4A8Zrw2eX/joRmvyXhhMUTYMkD5jks5X3ZGQytMZtOmPQ5MgY
 qpySFIds3Q/jWvnqykZ/JwuvTBz2/hodoadWPfMLBc0Ht8R31gLyMjR5/ w==;
X-CSE-ConnectionGUID: 6VOdZh74QlKYdFV8WNacDw==
X-CSE-MsgGUID: dLMM25rvR6WR4Tmf5/T5jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89330226"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="89330226"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 08:22:24 -0700
X-CSE-ConnectionGUID: 7ub95tIGSVuZvi6es1o3zg==
X-CSE-MsgGUID: 3WZJkryFQ+2dSuxkLD+VmA==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 08 Sep 2026 08:22:22 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 15/19] net/i40e: refactor FDIR engine infrastructure
Date: Tue,  8 Sep 2026 16:20:57 +0100
Message-ID: <bcdaeb40fd42c0e7bf1148ad8f075bda0fe56e96.1788880125.git.anatoly.burakov@intel.com>
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

Currently, there are multiple problems with how i40e flow directory feature
is implemented, both in terms of how it works with rte_flow, and how it
integrates with the PMD-specific packet template API.

For one, these two subsystems, while using shared infrastructure, do not
really interact or cooperate, and are built on top of special cases in FDIR
path. More specifically, the packet template code does not store its
packet in the hash map, and has a different hashing scheme, yet it still
registers itself in FDIR flow list, hash table, and hash map. This list
is then used by `dev_start` to restore FDIR filters that user has
inserted into the list. These filters, as written, cannot be reprogrammed
that way because the information a filter restore function would need is
lost on insert (the packet pointer is not added to the hash map).

Another issue is that while rte_flow FDIR code does lazy FDIR init on first
added flow, the packet template API does not, even though it too relies on
the same hardware feature, nor does it ever do teardown on last FDIR flow.

Yet another issue is how the "filter restore" code itself is implemented,
namely that currently it simply does not work. When doing filter restore,
the driver will walk every FDIR filter stored in the TAILQ, and attempt to
program it. However, inside the program function, there is a deduplication
check (to see if flow being installed is already present in the flow hash
table), which fails because the flows we are programming come from the same
list that is being checked for deduplication, which makes the entire filter
restore a no-op.

The FDIR filter programming code itself also has a number of readability
problems as well as being otherwise hard to use - SW bookkeeping,
validation, and flow programming is interspersed within the code, and it
is difficult to reason about what happens when the code is called from
this or that context.

So, this refactor does the following:

- Reorganize FDIR internals to track packet templates and rte_flow FDIR
  flows separately
- Refactor FDIR init/teardown to always happen on first/last rule, so that
  whichever API happens to call FDIR first, the state is consistent
- Rework the FDIR code to disentangle FDIR flow rule programming, Flex PIT
  checks, SW bookkeeping, etc. from each other
- Remove both the rte_flow FDIR TAILQ and the hash map (filter array)
  structure, because they are redundant (information about the flow is
  already stored in the rte_flow flow list, and hash_map structure only
  stored pointers to data we also have in that same list)
- Fix FDIR filter restore to replay all configuration correctly, as well as
  re-init the FDIR queue enablement tracking
- Rework the internal FDIR global state data structure to make a little
  more sense by grouping things that belong together into structures

Additionally, there was a delay mechanism at flow director rule program
time, as when programming a rule we might not know if it's actually
possible to install the rule, because space for the rules may come either
from our own pool, or it may come from a pool that is shared with other
VSI's. However, it only makes sense to wait on rule create (i.e. when it is
programmed into the hardware for the first time), but not when we are
replaying or removing these rules. So, adjust the waiting mechanism to only
wait on FDIR rule creation.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c  |  168 +---
 drivers/net/intel/i40e/i40e_ethdev.h  |  126 ++-
 drivers/net/intel/i40e/i40e_fdir.c    | 1134 +++++++++++++++++--------
 drivers/net/intel/i40e/i40e_flow.c    |  131 +--
 drivers/net/intel/i40e/rte_pmd_i40e.c |    4 +-
 5 files changed, 928 insertions(+), 635 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 8c009e98ba..25062fe695 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -1041,129 +1041,6 @@ i40e_init_tunnel_filter_list(struct rte_eth_dev *dev)
 	return ret;
 }
 
-static int
-i40e_init_fdir_filter_list(struct rte_eth_dev *dev)
-{
-	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
-	struct i40e_fdir_info *fdir_info = &pf->fdir;
-	char fdir_hash_name[RTE_HASH_NAMESIZE];
-	uint32_t alloc = hw->func_caps.fd_filters_guaranteed;
-	uint32_t best = hw->func_caps.fd_filters_best_effort;
-	enum i40e_filter_pctype pctype;
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
-	/* Initialize flow director filter rule list and hash */
-	TAILQ_INIT(&fdir_info->fdir_list);
-	snprintf(fdir_hash_name, RTE_HASH_NAMESIZE,
-		 "fdir_%s", dev->device->name);
-	fdir_info->hash_table = rte_hash_create(&fdir_hash_params);
-	if (!fdir_info->hash_table) {
-		PMD_INIT_LOG(ERR, "Failed to create fdir hash table!");
-		return -EINVAL;
-	}
-
-	fdir_info->hash_map = rte_zmalloc("i40e_fdir_hash_map",
-					  sizeof(struct i40e_fdir_filter *) *
-					  I40E_MAX_FDIR_FILTER_NUM,
-					  0);
-	if (!fdir_info->hash_map) {
-		PMD_INIT_LOG(ERR,
-			     "Failed to allocate memory for fdir hash map!");
-		ret = -ENOMEM;
-		goto err_fdir_hash_map_alloc;
-	}
-
-	fdir_info->fdir_filter_array = rte_zmalloc("fdir_filter",
-			sizeof(struct i40e_fdir_filter) *
-			I40E_MAX_FDIR_FILTER_NUM,
-			0);
-
-	if (!fdir_info->fdir_filter_array) {
-		PMD_INIT_LOG(ERR,
-			     "Failed to allocate memory for fdir filter array!");
-		ret = -ENOMEM;
-		goto err_fdir_filter_array_alloc;
-	}
-
-	for (pctype = I40E_FILTER_PCTYPE_NONF_IPV4_UDP;
-	     pctype <= I40E_FILTER_PCTYPE_L2_PAYLOAD; pctype++)
-		pf->fdir.flow_count[pctype] = 0;
-
-	fdir_info->fdir_space_size = alloc + best;
-	fdir_info->fdir_actual_cnt = 0;
-	fdir_info->fdir_guarantee_total_space = alloc;
-	fdir_info->fdir_guarantee_free_space =
-		fdir_info->fdir_guarantee_total_space;
-
-	PMD_DRV_LOG(INFO, "FDIR guarantee space: %u, best_effort space %u.", alloc, best);
-
-	fdir_info->fdir_flow_pool.pool =
-			rte_zmalloc("i40e_fdir_entry",
-				sizeof(struct i40e_fdir_entry) *
-				fdir_info->fdir_space_size,
-				0);
-
-	if (!fdir_info->fdir_flow_pool.pool) {
-		PMD_INIT_LOG(ERR,
-			     "Failed to allocate memory for bitmap flow!");
-		ret = -ENOMEM;
-		goto err_fdir_bitmap_flow_alloc;
-	}
-
-	for (i = 0; i < fdir_info->fdir_space_size; i++)
-		fdir_info->fdir_flow_pool.pool[i].idx = i;
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
-	fdir_info->fdir_flow_pool.bitmap = bmp;
-
-	return 0;
-
-err_fdir_bmp_alloc:
-	rte_free(mem);
-err_fdir_mem_alloc:
-	rte_free(fdir_info->fdir_flow_pool.pool);
-err_fdir_bitmap_flow_alloc:
-	rte_free(fdir_info->fdir_filter_array);
-err_fdir_filter_array_alloc:
-	rte_free(fdir_info->hash_map);
-err_fdir_hash_map_alloc:
-	rte_hash_free(fdir_info->hash_table);
-
-	return ret;
-}
-
 static void
 i40e_init_customized_info(struct i40e_pf *pf)
 {
@@ -1782,9 +1659,9 @@ eth_i40e_dev_init(struct rte_eth_dev *dev, void *init_params __rte_unused)
 	ret = i40e_init_tunnel_filter_list(dev);
 	if (ret < 0)
 		goto err_init_tunnel_filter_list;
-	ret = i40e_init_fdir_filter_list(dev);
+	ret = i40e_fdir_flow_store_init(dev);
 	if (ret < 0)
-		goto err_init_fdir_filter_list;
+		goto err_init_fdir_flow_store;
 
 	/* initialize flow engine configuration */
 	ret = ci_flow_engine_conf_init(&pf->flow_engine_conf,
@@ -1801,12 +1678,8 @@ eth_i40e_dev_init(struct rte_eth_dev *dev, void *init_params __rte_unused)
 	return 0;
 
 err_flow_engine_conf_init:
-	rte_free(pf->fdir.fdir_flow_pool.bitmap);
-	rte_free(pf->fdir.fdir_flow_pool.pool);
-	rte_free(pf->fdir.fdir_filter_array);
-	rte_free(pf->fdir.hash_map);
-	rte_hash_free(pf->fdir.hash_table);
-err_init_fdir_filter_list:
+	i40e_fdir_flow_store_free(&pf->fdir);
+err_init_fdir_flow_store:
 	rte_hash_free(pf->tunnel.hash_table);
 	rte_free(pf->tunnel.hash_map);
 err_init_tunnel_filter_list:
@@ -1849,32 +1722,13 @@ i40e_rm_tunnel_filter_list(struct i40e_pf *pf)
 	}
 }
 
-static void
-i40e_rm_fdir_filter_list(struct i40e_pf *pf)
-{
-	struct i40e_fdir_filter *p_fdir;
-	struct i40e_fdir_info *fdir_info;
-
-	fdir_info = &pf->fdir;
-
-	/* Remove all flow director rules */
-	while ((p_fdir = TAILQ_FIRST(&fdir_info->fdir_list)))
-		TAILQ_REMOVE(&fdir_info->fdir_list, p_fdir, rules);
-}
-
 static void
 i40e_fdir_memory_cleanup(struct i40e_pf *pf)
 {
-	struct i40e_fdir_info *fdir_info;
+	struct i40e_fdir_info *fdir_info = &pf->fdir;
 
-	fdir_info = &pf->fdir;
-
-	/* flow director memory cleanup */
-	rte_free(fdir_info->hash_map);
-	rte_hash_free(fdir_info->hash_table);
-	rte_free(fdir_info->fdir_flow_pool.bitmap);
-	rte_free(fdir_info->fdir_flow_pool.pool);
-	rte_free(fdir_info->fdir_filter_array);
+	i40e_fdir_flow_store_free(fdir_info);
+	i40e_fdir_tmpl_store_free(fdir_info);
 }
 
 void i40e_flex_payload_reg_set_default(struct i40e_hw *hw)
@@ -2730,7 +2584,6 @@ i40e_dev_close(struct rte_eth_dev *dev)
 	} while (retries++ < 5);
 
 	i40e_rm_tunnel_filter_list(pf);
-	i40e_rm_fdir_filter_list(pf);
 
 	/* Remove all flows */
 	while ((p_flow = TAILQ_FIRST(&pf->flow_list))) {
@@ -9774,7 +9627,12 @@ i40e_filter_input_set_init(struct i40e_pf *pf)
 		/* store the default input set */
 		if (!pf->support_multi_driver)
 			pf->hash_input_set[pctype] = input_set;
-		pf->fdir.input_set[pctype] = input_set;
+		{
+			struct i40e_fdir_pctype_state *state =
+				&pf->fdir.flows.pctype[pctype];
+
+			state->input_set = input_set;
+		}
 	}
 }
 
diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index f674f7995d..3b6868fe7c 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -693,7 +693,7 @@ struct i40e_fdir_action {
 /* A structure used to define the flow director filter entry by filter_ctrl API
  * It supports RTE_ETH_FILTER_FDIR data representation.
  */
-struct i40e_fdir_filter_conf {
+struct i40e_fdir_filter {
 	uint32_t soft_id;
 	/* ID, an unique value is required when deal with FDIR entry */
 	struct i40e_fdir_input input;    /* Input set */
@@ -713,9 +713,26 @@ struct i40e_fdir_flex_mask {
 #define I40E_FILTER_PCTYPE_MAX     64
 #define I40E_MAX_FDIR_FILTER_NUM   (1024 * 8)
 
-struct i40e_fdir_filter {
-	TAILQ_ENTRY(i40e_fdir_filter) rules;
-	struct i40e_fdir_filter_conf fdir;
+/*
+ * A filter added through the PMD packet template API. It owns the raw packet,
+ * and fdir.input.flow.raw_flow.packet points at that copy, so the filter stays
+ * self-contained and can be reprogrammed at any time.
+ */
+struct i40e_fdir_tmpl_filter {
+	TAILQ_ENTRY(i40e_fdir_tmpl_filter) rules;
+	struct i40e_fdir_filter fdir;
+	uint8_t *packet;
+};
+
+/*
+ * Packet templates are keyed on their contents, which are too big for a hash
+ * key, so the key borrows the packet and a custom comparison walks it. The
+ * hash signature is computed by the caller and passed to the _with_hash() API.
+ */
+struct i40e_fdir_tmpl_key {
+	uint16_t pctype;
+	uint32_t length;
+	const uint8_t *packet;
 };
 
 /* fdir memory pool entry */
@@ -735,7 +752,46 @@ struct i40e_fdir_flow_pool {
 #define FLOW_TO_FLOW_BITMAP(f) \
 	container_of((f), struct i40e_fdir_entry, flow)
 
-TAILQ_HEAD(i40e_fdir_filter_list, i40e_fdir_filter);
+TAILQ_HEAD(i40e_fdir_tmpl_list, i40e_fdir_tmpl_filter);
+
+/* tracking for rte_flow-backed filters */
+struct i40e_fdir_pctype_state {
+	/* input set bits for this pctype */
+	uint64_t input_set;
+	uint32_t flow_count;
+	struct i40e_fdir_flex_mask flex_mask;
+	bool flex_mask_flag;
+};
+
+struct i40e_fdir_layer_state {
+	/*
+	 * The rule for extracting a byte stream as flexible payload. Each layer
+	 * can have up to three elements, and all filters sharing the same layer
+	 * reuse the same programmed layout.
+	 */
+	struct i40e_fdir_flex_pit flex_set[I40E_MAX_FLXPLD_FIED];
+	bool flex_pit_flag;
+	uint32_t flex_flow_count;
+};
+
+struct i40e_fdir_flow_store {
+	struct rte_hash *hash_table;
+	/* the pre-allocated pool of the rte_flow */
+	struct i40e_fdir_flow_pool flow_pool;
+
+	struct i40e_fdir_pctype_state pctype[I40E_FILTER_PCTYPE_MAX];
+	struct i40e_fdir_layer_state layer[I40E_MAX_FLXPLD_LAYER];
+};
+
+/* tracking for packet template filters; allocated on first use */
+struct i40e_fdir_tmpl_store {
+	struct rte_hash *hash_table;
+	/* filters indexed by their hash table slot */
+	struct i40e_fdir_tmpl_filter *filter_array;
+	/* these filters have no other owner, so they are enumerated here */
+	struct i40e_fdir_tmpl_list list;
+};
+
 /*
  *  A structure used to define fields of a FDIR related info.
  */
@@ -752,20 +808,8 @@ struct i40e_fdir_info {
 	 */
 	int txq_available_buf_count;
 
-	/* input set bits for each pctype */
-	uint64_t input_set[I40E_FILTER_PCTYPE_MAX];
-	/*
-	 * the rule how bytes stream is extracted as flexible payload
-	 * for each payload layer, the setting can up to three elements
-	 */
-	struct i40e_fdir_flex_pit flex_set[I40E_MAX_FLXPLD_LAYER * I40E_MAX_FLXPLD_FIED];
-	struct i40e_fdir_flex_mask flex_mask[I40E_FILTER_PCTYPE_MAX];
-
-	struct i40e_fdir_filter_list fdir_list;
-	struct i40e_fdir_filter **hash_map;
-	struct rte_hash *hash_table;
-	/* An array to store the inserted rules input */
-	struct i40e_fdir_filter *fdir_filter_array;
+	struct i40e_fdir_flow_store flows;
+	struct i40e_fdir_tmpl_store tmpls;
 
 	/*
 	 * Priority ordering at filter invalidation(destroying a flow) between
@@ -784,22 +828,10 @@ struct i40e_fdir_info {
 	 * shared space
 	 */
 	uint32_t fdir_space_size;
-	/* the actual number of the fdir rules in hardware, initialized as 0 */
+	/* number of filters in hardware, across both stores */
 	uint32_t fdir_actual_cnt;
-	/* the free guaranteed space of the fdir */
-	uint32_t fdir_guarantee_free_space;
 	/* the fdir total guaranteed space */
 	uint32_t fdir_guarantee_total_space;
-	/* the pre-allocated pool of the rte_flow */
-	struct i40e_fdir_flow_pool fdir_flow_pool;
-
-	/* Mark if flex pit and mask is set */
-	bool flex_pit_flag[I40E_MAX_FLXPLD_LAYER];
-	bool flex_mask_flag[I40E_FILTER_PCTYPE_MAX];
-
-	uint32_t flow_count[I40E_FILTER_PCTYPE_MAX];
-
-	uint32_t flex_flow_count[I40E_MAX_FLXPLD_LAYER];
 };
 
 /* Ethertype filter number HW supports */
@@ -1303,7 +1335,7 @@ extern const struct rte_flow_ops i40e_flow_ops;
 
 struct i40e_filter_ctx {
 	union {
-		struct i40e_fdir_filter_conf fdir_filter;
+		struct i40e_fdir_filter fdir_filter;
 		struct i40e_tunnel_filter_conf consistent_tunnel_filter;
 		struct i40e_rte_flow_rss_conf rss_conf;
 	};
@@ -1353,7 +1385,7 @@ const struct rte_memzone *i40e_memzone_reserve(const char *name,
 					uint32_t len,
 					int socket_id);
 int i40e_fdir_configure(struct rte_eth_dev *dev);
-void i40e_fdir_rx_proc_enable(struct rte_eth_dev *dev, bool on);
+void i40e_fdir_rx_proc_sync(struct rte_eth_dev *dev);
 void i40e_fdir_teardown(struct i40e_pf *pf);
 enum i40e_filter_pctype
 	i40e_flowtype_to_pctype(const struct i40e_adapter *adapter,
@@ -1384,8 +1416,6 @@ int i40e_rx_burst_mode_get(struct rte_eth_dev *dev, uint16_t queue_id,
 			   struct rte_eth_burst_mode *mode);
 int i40e_tx_burst_mode_get(struct rte_eth_dev *dev, uint16_t queue_id,
 			   struct rte_eth_burst_mode *mode);
-int i40e_sw_fdir_filter_del(struct i40e_pf *pf,
-			    struct i40e_fdir_input *input);
 struct i40e_tunnel_filter *
 i40e_sw_tunnel_filter_lookup(struct i40e_tunnel_rule *tunnel_rule,
 			     const struct i40e_tunnel_filter_input *input);
@@ -1399,9 +1429,27 @@ struct rte_flow *
 i40e_fdir_entry_pool_get(struct i40e_fdir_info *fdir_info);
 void i40e_fdir_entry_pool_put(struct i40e_fdir_info *fdir_info,
 		struct rte_flow *flow);
-int i40e_flow_add_del_fdir_filter(struct rte_eth_dev *dev,
-			      const struct i40e_fdir_filter_conf *filter,
-			      bool add);
+int i40e_fdir_tmpl_add_del(struct rte_eth_dev *dev,
+			   const struct i40e_fdir_filter *filter,
+			   bool add);
+struct i40e_fdir_filter *
+i40e_fdir_filter_lookup(struct i40e_fdir_info *fdir_info,
+			const struct i40e_fdir_input *input);
+int i40e_fdir_filter_validate(struct rte_eth_dev *dev,
+			      const struct i40e_fdir_filter *filter);
+int i40e_fdir_filter_register(struct rte_eth_dev *dev,
+			      const struct i40e_fdir_filter *filter,
+			      struct i40e_fdir_filter **node);
+int i40e_fdir_filter_unregister(struct rte_eth_dev *dev,
+				struct i40e_fdir_filter *node);
+int i40e_fdir_filter_program(struct rte_eth_dev *dev,
+			     const struct i40e_fdir_filter *filter,
+			     bool add, bool wait_status);
+bool i40e_fdir_filter_needs_status_wait(const struct i40e_pf *pf,
+					uint32_t filter_count);
+void i40e_fdir_tmpl_store_free(struct i40e_fdir_info *fdir_info);
+int i40e_fdir_flow_store_init(struct rte_eth_dev *dev);
+void i40e_fdir_flow_store_free(struct i40e_fdir_info *fdir_info);
 int i40e_dev_tunnel_filter_set(struct i40e_pf *pf,
 			       struct rte_eth_tunnel_filter_conf *tunnel_filter,
 			       uint8_t add);
diff --git a/drivers/net/intel/i40e/i40e_fdir.c b/drivers/net/intel/i40e/i40e_fdir.c
index 8a233f8a97..182894cdde 100644
--- a/drivers/net/intel/i40e/i40e_fdir.c
+++ b/drivers/net/intel/i40e/i40e_fdir.c
@@ -86,17 +86,10 @@
 	(1ULL << RTE_ETH_FLOW_NONFRAG_IPV6_OTHER) | \
 	(1ULL << RTE_ETH_FLOW_L2_PAYLOAD))
 
-static int i40e_fdir_filter_convert(const struct i40e_fdir_filter_conf *input,
-			 struct i40e_fdir_filter *filter);
-static struct i40e_fdir_filter *
-i40e_sw_fdir_filter_lookup(struct i40e_fdir_info *fdir_info,
-			const struct i40e_fdir_input *input);
-static int i40e_sw_fdir_filter_insert(struct i40e_pf *pf,
-				   struct i40e_fdir_filter *filter);
 static int
 i40e_flow_fdir_filter_programming(struct i40e_pf *pf,
 				  enum i40e_filter_pctype pctype,
-				  const struct i40e_fdir_filter_conf *filter,
+				  const struct i40e_fdir_filter *filter,
 				  bool add, bool wait_status);
 
 static int
@@ -256,8 +249,6 @@ i40e_fdir_setup(struct i40e_pf *pf)
 
 	pf->fdir.match_counter_index = I40E_COUNTER_INDEX_FDIR(hw->pf_id);
 	pf->fdir.fdir_actual_cnt = 0;
-	pf->fdir.fdir_guarantee_free_space =
-		pf->fdir.fdir_guarantee_total_space;
 
 	PMD_DRV_LOG(INFO, "FDIR setup successfully, with programming queue %u.",
 		    vsi->base_queue);
@@ -344,46 +335,52 @@ i40e_init_flx_pld(struct i40e_pf *pf)
 	 * of payload as flexible payload.
 	 */
 	for (i = I40E_FLXPLD_L2_IDX; i < I40E_MAX_FLXPLD_LAYER; i++) {
+		struct i40e_fdir_layer_state *layer = &pf->fdir.flows.layer[i];
+		struct i40e_fdir_flex_pit *flex_set = &layer->flex_set[0];
 		index = i * I40E_MAX_FLXPLD_FIED;
-		pf->fdir.flex_set[index].src_offset = 0;
-		pf->fdir.flex_set[index].size = I40E_FDIR_MAX_FLEXWORD_NUM;
-		pf->fdir.flex_set[index].dst_offset = 0;
+		flex_set->src_offset = 0;
+		flex_set->size = I40E_FDIR_MAX_FLEXWORD_NUM;
+		flex_set->dst_offset = 0;
 		I40E_WRITE_REG(hw, I40E_PRTQF_FLX_PIT(index), 0x0000C900);
 		I40E_WRITE_REG(hw,
 			I40E_PRTQF_FLX_PIT(index + 1), 0x0000FC29);/*non-used*/
 		I40E_WRITE_REG(hw,
 			I40E_PRTQF_FLX_PIT(index + 2), 0x0000FC2A);/*non-used*/
-		pf->fdir.flex_pit_flag[i] = 0;
+		layer->flex_pit_flag = false;
 	}
 
 	/* initialize the masks */
 	for (pctype = I40E_FILTER_PCTYPE_NONF_IPV4_UDP;
 	     pctype <= I40E_FILTER_PCTYPE_L2_PAYLOAD; pctype++) {
+		struct i40e_fdir_pctype_state *state = &pf->fdir.flows.pctype[pctype];
 		flow_type = i40e_pctype_to_flowtype(pf->adapter, pctype);
 
 		if (flow_type == RTE_ETH_FLOW_UNKNOWN)
 			continue;
-		pf->fdir.flex_mask[pctype].word_mask = 0;
+		state->flex_mask.word_mask = 0;
 		i40e_write_rx_ctl(hw, I40E_PRTQF_FD_FLXINSET(pctype), 0);
 		for (i = 0; i < I40E_FDIR_BITMASK_NUM_WORD; i++) {
-			pf->fdir.flex_mask[pctype].bitmask[i].offset = 0;
-			pf->fdir.flex_mask[pctype].bitmask[i].mask = 0;
+			state->flex_mask.bitmask[i].offset = 0;
+			state->flex_mask.bitmask[i].mask = 0;
 			i40e_write_rx_ctl(hw, I40E_PRTQF_FD_MSK(pctype, i), 0);
 		}
 	}
 }
 
 /*
- * Enable/disable flow director RX processing in vector routines.
+ * Match flow director RX processing to whether any filter is registered.
  */
 void
-i40e_fdir_rx_proc_enable(struct rte_eth_dev *dev, bool on)
+i40e_fdir_rx_proc_sync(struct rte_eth_dev *dev)
 {
-	int32_t i;
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	bool on = pf->fdir.fdir_actual_cnt > 0;
+	uint16_t i;
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
 		struct ci_rx_queue *rxq = dev->data->rx_queues[i];
-		if (!rxq)
+
+		if (rxq == NULL)
 			continue;
 		rxq->fdir_enabled = on;
 	}
@@ -421,12 +418,37 @@ i40e_fdir_configure(struct rte_eth_dev *dev)
 
 	i40e_init_flx_pld(pf); /* set flex config to default value */
 
-	/* Enable FDIR processing in RX routines */
-	i40e_fdir_rx_proc_enable(dev, 1);
-
 	return ret;
 }
 
+/*
+ * Bring up the flow director engine on first use.
+ */
+static int
+i40e_fdir_engine_init(struct rte_eth_dev *dev)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	int ret;
+
+	if (pf->fdir.fdir_vsi != NULL)
+		return 0;
+
+	ret = i40e_fdir_setup(pf);
+	if (ret != I40E_SUCCESS) {
+		PMD_DRV_LOG(ERR, "Failed to setup fdir.");
+		return -ENOTSUP;
+	}
+
+	ret = i40e_fdir_configure(dev);
+	if (ret < 0) {
+		PMD_DRV_LOG(ERR, "Failed to configure fdir.");
+		i40e_fdir_teardown(pf);
+		return ret;
+	}
+
+	return 0;
+}
+
 
 static struct i40e_customized_pctype *
 i40e_flow_fdir_find_customized_pctype(struct i40e_pf *pf, uint8_t pctype)
@@ -642,7 +664,7 @@ i40e_flow_fdir_construct_pkt(struct i40e_pf *pf,
 	struct rte_ipv6_hdr *esp_ipv6;
 
 	uint8_t size, dst = 0;
-	uint8_t i, pit_idx, set_idx = I40E_FLXPLD_L4_IDX; /* use l4 by default*/
+	uint8_t i, set_idx = I40E_FLXPLD_L4_IDX; /* use l4 by default*/
 	int len;
 	uint8_t pctype = fdir_input->pctype;
 	struct i40e_customized_pctype *cus_pctype;
@@ -894,13 +916,15 @@ i40e_flow_fdir_construct_pkt(struct i40e_pf *pf,
 
 	/* fill the flexbytes to payload */
 	for (i = 0; i < I40E_MAX_FLXPLD_FIED; i++) {
-		pit_idx = set_idx * I40E_MAX_FLXPLD_FIED + i;
-		size = pf->fdir.flex_set[pit_idx].size;
+		const struct i40e_fdir_flex_pit *pit;
+		struct i40e_fdir_layer_state *layer = &pf->fdir.flows.layer[set_idx];
+
+		pit = &layer->flex_set[i];
+		size = pit->size;
 		if (size == 0)
 			continue;
-		dst = pf->fdir.flex_set[pit_idx].dst_offset * sizeof(uint16_t);
-		ptr = payload +
-		      pf->fdir.flex_set[pit_idx].src_offset * sizeof(uint16_t);
+		dst = pit->dst_offset * sizeof(uint16_t);
+		ptr = payload + pit->src_offset * sizeof(uint16_t);
 		(void)memcpy(ptr,
 				 &fdir_input->flow_ext.flexbytes[dst],
 				 size * sizeof(uint16_t));
@@ -997,56 +1021,23 @@ i40e_fdir_programming_status_cleanup(struct ci_rx_queue *rxq)
 		PMD_DRV_LOG(INFO, "error report captured.");
 }
 
+/* Add a flow director filter into the SW hash table */
 static int
-i40e_fdir_filter_convert(const struct i40e_fdir_filter_conf *input,
-			 struct i40e_fdir_filter *filter)
+i40e_fdir_filter_hash_add(struct i40e_pf *pf,
+			  const struct i40e_fdir_filter *filter,
+			  struct i40e_fdir_filter **node)
 {
-	memcpy(&filter->fdir, input, sizeof(struct i40e_fdir_filter_conf));
-	if (input->input.flow_ext.pkt_template) {
-		filter->fdir.input.flow.raw_flow.packet = NULL;
-		filter->fdir.input.flow.raw_flow.length =
-			rte_hash_crc(input->input.flow.raw_flow.packet,
-				     input->input.flow.raw_flow.length,
-				     input->input.flow.raw_flow.pctype);
+	struct i40e_fdir_flow_store *flows = &pf->fdir.flows;
+	int ret;
+
+	ret = rte_hash_lookup(flows->hash_table, &filter->input);
+	if (ret >= 0) {
+		PMD_DRV_LOG(ERR, "Failed to add fdir filter to hash table %d!",
+			    ret);
+		return -EEXIST;
 	}
-	return 0;
-}
 
-/* Check if there exists the flow director filter */
-static struct i40e_fdir_filter *
-i40e_sw_fdir_filter_lookup(struct i40e_fdir_info *fdir_info,
-			const struct i40e_fdir_input *input)
-{
-	int ret;
-
-	if (input->flow_ext.pkt_template)
-		ret = rte_hash_lookup_with_hash(fdir_info->hash_table,
-						(const void *)input,
-						input->flow.raw_flow.length);
-	else
-		ret = rte_hash_lookup(fdir_info->hash_table,
-				      (const void *)input);
-	if (ret < 0)
-		return NULL;
-
-	return fdir_info->hash_map[ret];
-}
-
-/* Add a flow director filter into the SW list */
-static int
-i40e_sw_fdir_filter_insert(struct i40e_pf *pf, struct i40e_fdir_filter *filter)
-{
-	struct i40e_fdir_info *fdir_info = &pf->fdir;
-	struct i40e_fdir_filter *hash_filter;
-	int ret;
-
-	if (filter->fdir.input.flow_ext.pkt_template)
-		ret = rte_hash_add_key_with_hash(fdir_info->hash_table,
-				 &filter->fdir.input,
-				 filter->fdir.input.flow.raw_flow.length);
-	else
-		ret = rte_hash_add_key(fdir_info->hash_table,
-				       &filter->fdir.input);
+	ret = rte_hash_add_key(flows->hash_table, &filter->input);
 	if (ret < 0) {
 		PMD_DRV_LOG(ERR,
 			    "Failed to insert fdir filter to hash table %d!",
@@ -1054,48 +1045,247 @@ i40e_sw_fdir_filter_insert(struct i40e_pf *pf, struct i40e_fdir_filter *filter)
 		return ret;
 	}
 
-	if (fdir_info->hash_map[ret])
-		return -1;
-
-	hash_filter = &fdir_info->fdir_filter_array[ret];
-	memcpy(hash_filter, filter, sizeof(*filter));
-	fdir_info->hash_map[ret] = hash_filter;
-	TAILQ_INSERT_TAIL(&fdir_info->fdir_list, hash_filter, rules);
+	**node = *filter;
 
 	return 0;
 }
 
-/* Delete a flow director filter from the SW list */
-int
-i40e_sw_fdir_filter_del(struct i40e_pf *pf, struct i40e_fdir_input *input)
+/* Delete a flow director filter from the SW hash table */
+static int
+i40e_fdir_filter_hash_del(struct i40e_pf *pf,
+			  const struct i40e_fdir_filter *node)
 {
-	struct i40e_fdir_info *fdir_info = &pf->fdir;
-	struct i40e_fdir_filter *filter;
 	int ret;
 
-	if (input->flow_ext.pkt_template)
-		ret = rte_hash_del_key_with_hash(fdir_info->hash_table,
-						 input,
-						 input->flow.raw_flow.length);
-	else
-		ret = rte_hash_del_key(fdir_info->hash_table, input);
+	ret = rte_hash_del_key(pf->fdir.flows.hash_table, &node->input);
 	if (ret < 0) {
 		PMD_DRV_LOG(ERR,
-			    "Failed to delete fdir filter to hash table %d!",
+			    "Failed to delete fdir filter from hash table %d!",
 			    ret);
 		return ret;
 	}
-	filter = fdir_info->hash_map[ret];
-	fdir_info->hash_map[ret] = NULL;
 
-	TAILQ_REMOVE(&fdir_info->fdir_list, filter, rules);
+	return 0;
+}
+
+int
+i40e_fdir_flow_store_init(struct rte_eth_dev *dev)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
+	struct i40e_fdir_info *fdir_info = &pf->fdir;
+	struct i40e_fdir_flow_store *flows = &fdir_info->flows;
+	char fdir_hash_name[RTE_HASH_NAMESIZE];
+	uint32_t alloc = hw->func_caps.fd_filters_guaranteed;
+	uint32_t best = hw->func_caps.fd_filters_best_effort;
+	struct rte_bitmap *bmp = NULL;
+	uint32_t bmp_size;
+	void *mem = NULL;
+	uint32_t i = 0;
+	int ret;
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
+	snprintf(fdir_hash_name, RTE_HASH_NAMESIZE,
+		 "fdir_%s", dev->device->name);
+	flows->hash_table = rte_hash_create(&fdir_hash_params);
+	if (!flows->hash_table) {
+		PMD_INIT_LOG(ERR, "Failed to create fdir hash table!");
+		return -EINVAL;
+	}
+
+	fdir_info->fdir_space_size = alloc + best;
+	fdir_info->fdir_actual_cnt = 0;
+	fdir_info->fdir_guarantee_total_space = alloc;
+
+	PMD_DRV_LOG(INFO, "FDIR guarantee space: %u, best_effort space %u.", alloc, best);
+
+	flows->flow_pool.pool =
+			rte_zmalloc("i40e_fdir_entry",
+				sizeof(struct i40e_fdir_entry) *
+				fdir_info->fdir_space_size,
+				0);
+
+	if (!flows->flow_pool.pool) {
+		PMD_INIT_LOG(ERR,
+			     "Failed to allocate memory for bitmap flow!");
+		ret = -ENOMEM;
+		goto err_fdir_bitmap_flow_alloc;
+	}
+
+	for (i = 0; i < fdir_info->fdir_space_size; i++)
+		flows->flow_pool.pool[i].idx = i;
+
+	bmp_size =
+		rte_bitmap_get_memory_footprint(fdir_info->fdir_space_size);
+	mem = rte_zmalloc("fdir_bmap", bmp_size, RTE_CACHE_LINE_SIZE);
+	if (mem == NULL) {
+		PMD_INIT_LOG(ERR,
+			     "Failed to allocate memory for fdir bitmap!");
+		ret = -ENOMEM;
+		goto err_fdir_mem_alloc;
+	}
+	bmp = rte_bitmap_init(fdir_info->fdir_space_size, mem, bmp_size);
+	if (bmp == NULL) {
+		PMD_INIT_LOG(ERR,
+			     "Failed to initialization fdir bitmap!");
+		ret = -ENOMEM;
+		goto err_fdir_bmp_alloc;
+	}
+	for (i = 0; i < fdir_info->fdir_space_size; i++)
+		rte_bitmap_set(bmp, i);
+
+	flows->flow_pool.bitmap = bmp;
 
 	return 0;
+
+err_fdir_bmp_alloc:
+	rte_free(mem);
+err_fdir_mem_alloc:
+	rte_free(flows->flow_pool.pool);
+err_fdir_bitmap_flow_alloc:
+	rte_hash_free(flows->hash_table);
+
+	return ret;
+}
+
+void
+i40e_fdir_flow_store_free(struct i40e_fdir_info *fdir_info)
+{
+	struct i40e_fdir_flow_store *flows = &fdir_info->flows;
+
+	rte_free(flows->flow_pool.bitmap);
+	rte_free(flows->flow_pool.pool);
+	rte_hash_free(flows->hash_table);
+}
+
+static uint32_t
+i40e_fdir_tmpl_sig(const struct i40e_raw_flow *raw)
+{
+	return rte_hash_crc(raw->packet, raw->length, raw->pctype);
+}
+
+static int
+i40e_fdir_tmpl_cmp(const void *key1, const void *key2,
+		   size_t key_len __rte_unused)
+{
+	const struct i40e_fdir_tmpl_key *k1 = key1;
+	const struct i40e_fdir_tmpl_key *k2 = key2;
+
+	if (k1->pctype != k2->pctype || k1->length != k2->length)
+		return 1;
+
+	return memcmp(k1->packet, k2->packet, k1->length);
+}
+
+static void
+i40e_fdir_tmpl_key_fill(struct i40e_fdir_tmpl_key *key,
+			const struct i40e_raw_flow *raw,
+			const uint8_t *packet)
+{
+	memset(key, 0, sizeof(*key));
+	key->pctype = raw->pctype;
+	key->length = raw->length;
+	key->packet = packet;
+}
+
+/* The template store is only worth its memory once the API is actually used */
+static int
+i40e_fdir_tmpl_store_init(struct rte_eth_dev *dev)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct i40e_fdir_tmpl_store *tmpls = &pf->fdir.tmpls;
+	char name[RTE_HASH_NAMESIZE];
+	struct rte_hash_parameters params = {
+		.name = name,
+		.entries = I40E_MAX_FDIR_FILTER_NUM,
+		.key_len = sizeof(struct i40e_fdir_tmpl_key),
+		.hash_func = rte_hash_crc,
+		.hash_func_init_val = 0,
+		.socket_id = rte_socket_id(),
+	};
+
+	if (tmpls->hash_table != NULL)
+		return 0;
+
+	/* the packet template store is created on first use */
+	TAILQ_INIT(&tmpls->list);
+
+	snprintf(name, sizeof(name), "fdir_tmpl_%s", dev->device->name);
+	tmpls->hash_table = rte_hash_create(&params);
+	if (tmpls->hash_table == NULL) {
+		PMD_DRV_LOG(ERR, "Failed to create fdir template hash table.");
+		return -ENOMEM;
+	}
+	/* the key only borrows the packet, so contents drive the comparison */
+	rte_hash_set_cmp_func(tmpls->hash_table, i40e_fdir_tmpl_cmp);
+
+	tmpls->filter_array = rte_zmalloc("fdir_tmpl_filter",
+			sizeof(*tmpls->filter_array) * I40E_MAX_FDIR_FILTER_NUM,
+			0);
+	if (tmpls->filter_array == NULL) {
+		PMD_DRV_LOG(ERR,
+			     "Failed to allocate fdir template filter array.");
+		rte_hash_free(tmpls->hash_table);
+		tmpls->hash_table = NULL;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void
+i40e_fdir_tmpl_store_free(struct i40e_fdir_info *fdir_info)
+{
+	struct i40e_fdir_tmpl_store *tmpls = &fdir_info->tmpls;
+	struct i40e_fdir_tmpl_filter *tmpl, *tmp;
+	uint32_t i;
+
+	/* rules in this list point into filter array so no free() needed */
+	RTE_TAILQ_FOREACH_SAFE(tmpl, &tmpls->list, rules, tmp)
+		TAILQ_REMOVE(&tmpls->list, tmpl, rules);
+
+	if (tmpls->filter_array != NULL) {
+		for (i = 0; i < I40E_MAX_FDIR_FILTER_NUM; i++)
+			rte_free(tmpls->filter_array[i].packet);
+		rte_free(tmpls->filter_array);
+		tmpls->filter_array = NULL;
+	}
+	rte_hash_free(tmpls->hash_table);
+	tmpls->hash_table = NULL;
+}
+
+static struct i40e_fdir_tmpl_filter *
+i40e_fdir_tmpl_lookup(struct i40e_fdir_info *fdir_info,
+		      const struct i40e_raw_flow *raw)
+{
+	struct i40e_fdir_tmpl_key key;
+	int ret;
+
+	if (fdir_info->tmpls.hash_table == NULL)
+		return NULL;
+
+	i40e_fdir_tmpl_key_fill(&key, raw, raw->packet);
+
+	ret = rte_hash_lookup_with_hash(fdir_info->tmpls.hash_table, &key,
+					i40e_fdir_tmpl_sig(raw));
+	if (ret < 0)
+		return NULL;
+
+	return &fdir_info->tmpls.filter_array[ret];
 }
 
 struct rte_flow *
 i40e_fdir_entry_pool_get(struct i40e_fdir_info *fdir_info)
 {
+	struct i40e_fdir_flow_pool *pool = &fdir_info->flows.flow_pool;
 	struct rte_flow *flow = NULL;
 	uint64_t slab = 0;
 	uint32_t pos = 0;
@@ -1108,8 +1298,7 @@ i40e_fdir_entry_pool_get(struct i40e_fdir_info *fdir_info)
 		return NULL;
 	}
 
-	ret = rte_bitmap_scan(fdir_info->fdir_flow_pool.bitmap, &pos,
-			&slab);
+	ret = rte_bitmap_scan(pool->bitmap, &pos, &slab);
 
 	/* normally this won't happen as the fdir_actual_cnt should be
 	 * same with the number of the set bits in fdir_flow_pool,
@@ -1122,8 +1311,8 @@ i40e_fdir_entry_pool_get(struct i40e_fdir_info *fdir_info)
 
 	i = rte_bsf64(slab);
 	pos += i;
-	rte_bitmap_clear(fdir_info->fdir_flow_pool.bitmap, pos);
-	flow = &fdir_info->fdir_flow_pool.pool[pos].flow;
+	rte_bitmap_clear(pool->bitmap, pos);
+	flow = &pool->pool[pos].flow;
 
 	memset(flow, 0, sizeof(struct rte_flow));
 
@@ -1137,48 +1326,47 @@ i40e_fdir_entry_pool_put(struct i40e_fdir_info *fdir_info,
 	struct i40e_fdir_entry *f;
 
 	f = FLOW_TO_FLOW_BITMAP(flow);
-	rte_bitmap_set(fdir_info->fdir_flow_pool.bitmap, f->idx);
+	rte_bitmap_set(fdir_info->flows.flow_pool.bitmap, f->idx);
 }
 
 static int
-i40e_flow_store_flex_pit(struct i40e_pf *pf,
-			 struct i40e_fdir_flex_pit *flex_pit,
+i40e_fdir_check_flex_pit(struct i40e_pf *pf,
+			 const struct i40e_fdir_flex_pit *flex_pit,
 			 enum i40e_flxpld_layer_idx layer_idx,
 			 uint8_t raw_id)
 {
-	uint8_t field_idx;
+	struct i40e_fdir_flow_store *flows = &pf->fdir.flows;
+	struct i40e_fdir_layer_state *layer = &flows->layer[layer_idx];
 
-	field_idx = layer_idx * I40E_MAX_FLXPLD_FIED + raw_id;
 	/* Check if the configuration is conflicted */
-	if (pf->fdir.flex_pit_flag[layer_idx] &&
-	    (pf->fdir.flex_set[field_idx].src_offset != flex_pit->src_offset ||
-	     pf->fdir.flex_set[field_idx].size != flex_pit->size ||
-	     pf->fdir.flex_set[field_idx].dst_offset != flex_pit->dst_offset))
+	if (layer->flex_pit_flag &&
+	    (layer->flex_set[raw_id].src_offset !=
+		     flex_pit->src_offset ||
+	     layer->flex_set[raw_id].size != flex_pit->size ||
+	     layer->flex_set[raw_id].dst_offset !=
+		     flex_pit->dst_offset))
 		return -1;
 
 	/* Check if the configuration exists. */
-	if (pf->fdir.flex_pit_flag[layer_idx] &&
-	    (pf->fdir.flex_set[field_idx].src_offset == flex_pit->src_offset &&
-	     pf->fdir.flex_set[field_idx].size == flex_pit->size &&
-	     pf->fdir.flex_set[field_idx].dst_offset == flex_pit->dst_offset))
+	if (layer->flex_pit_flag &&
+	    (layer->flex_set[raw_id].src_offset ==
+		     flex_pit->src_offset &&
+	     layer->flex_set[raw_id].size == flex_pit->size &&
+	     layer->flex_set[raw_id].dst_offset ==
+		     flex_pit->dst_offset))
 		return 1;
 
-	pf->fdir.flex_set[field_idx].src_offset =
-		flex_pit->src_offset;
-	pf->fdir.flex_set[field_idx].size =
-		flex_pit->size;
-	pf->fdir.flex_set[field_idx].dst_offset =
-		flex_pit->dst_offset;
-
 	return 0;
 }
 
 static void
-i40e_flow_set_fdir_flex_pit(struct i40e_pf *pf,
-			    enum i40e_flxpld_layer_idx layer_idx,
-			    uint8_t raw_id)
+i40e_fdir_flex_pit_program(struct i40e_pf *pf,
+			   const struct i40e_fdir_filter *filter)
 {
+	enum i40e_flxpld_layer_idx layer_idx = filter->input.flow_ext.layer_idx;
+	uint8_t raw_id = filter->input.flow_ext.raw_id;
 	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
+	const struct i40e_fdir_flex_pit *pit;
 	uint32_t flx_pit, flx_ort;
 	uint16_t min_next_off = 0;
 	uint8_t field_idx;
@@ -1194,13 +1382,12 @@ i40e_flow_set_fdir_flex_pit(struct i40e_pf *pf,
 	/* Set flex pit */
 	for (i = 0; i < raw_id; i++) {
 		field_idx = layer_idx * I40E_MAX_FLXPLD_FIED + i;
-		flx_pit = MK_FLX_PIT(pf->fdir.flex_set[field_idx].src_offset,
-				     pf->fdir.flex_set[field_idx].size,
-				     pf->fdir.flex_set[field_idx].dst_offset);
+		pit = &filter->input.flow_ext.flex_pit[field_idx];
+		flx_pit = MK_FLX_PIT(pit->src_offset, pit->size,
+				     pit->dst_offset);
 
 		I40E_WRITE_REG(hw, I40E_PRTQF_FLX_PIT(field_idx), flx_pit);
-		min_next_off = pf->fdir.flex_set[field_idx].src_offset +
-			pf->fdir.flex_set[field_idx].size;
+		min_next_off = pit->src_offset + pit->size;
 	}
 
 	for (; i < I40E_MAX_FLXPLD_FIED; i++) {
@@ -1213,104 +1400,181 @@ i40e_flow_set_fdir_flex_pit(struct i40e_pf *pf,
 	}
 }
 
+/* Translate the byte-granular mask supplied by the caller into register form */
 static int
-i40e_flow_store_flex_mask(struct i40e_pf *pf,
-			  enum i40e_filter_pctype pctype,
-			  uint8_t *mask)
+i40e_fdir_flex_mask_convert(const uint8_t *mask,
+			    struct i40e_fdir_flex_mask *flex_mask)
 {
-	struct i40e_fdir_flex_mask flex_mask;
 	uint8_t nb_bitmask = 0;
 	uint16_t mask_tmp;
 	uint8_t i;
 
-	memset(&flex_mask, 0, sizeof(struct i40e_fdir_flex_mask));
+	memset(flex_mask, 0, sizeof(*flex_mask));
 	for (i = 0; i < I40E_FDIR_MAX_FLEX_LEN; i += sizeof(uint16_t)) {
 		mask_tmp = I40E_WORD(mask[i], mask[i + 1]);
 		if (mask_tmp) {
-			flex_mask.word_mask |=
+			flex_mask->word_mask |=
 				I40E_FLEX_WORD_MASK(i / sizeof(uint16_t));
 			if (mask_tmp != UINT16_MAX) {
 				if (nb_bitmask >= I40E_FDIR_BITMASK_NUM_WORD)
 					return -1;
-				flex_mask.bitmask[nb_bitmask].mask = ~mask_tmp;
-				flex_mask.bitmask[nb_bitmask].offset =
+				flex_mask->bitmask[nb_bitmask].mask = ~mask_tmp;
+				flex_mask->bitmask[nb_bitmask].offset =
 					i / sizeof(uint16_t);
 				nb_bitmask++;
 			}
 		}
 	}
-	flex_mask.nb_bitmask = nb_bitmask;
+	flex_mask->nb_bitmask = nb_bitmask;
 
-	if (pf->fdir.flex_mask_flag[pctype] &&
-	    (memcmp(&flex_mask, &pf->fdir.flex_mask[pctype],
+	return 0;
+}
+
+static int
+i40e_fdir_check_flex_mask(struct i40e_pf *pf,
+			  enum i40e_filter_pctype pctype,
+			  const uint8_t *mask,
+			  struct i40e_fdir_flex_mask *flex_mask)
+{
+	struct i40e_fdir_flow_store *flows = &pf->fdir.flows;
+	struct i40e_fdir_pctype_state *state = &flows->pctype[pctype];
+
+	if (i40e_fdir_flex_mask_convert(mask, flex_mask) < 0)
+		return -1;
+
+	if (state->flex_mask_flag &&
+	    (memcmp(flex_mask, &state->flex_mask,
 		    sizeof(struct i40e_fdir_flex_mask))))
 		return -2;
-	else if (pf->fdir.flex_mask_flag[pctype] &&
-		 !(memcmp(&flex_mask, &pf->fdir.flex_mask[pctype],
-			  sizeof(struct i40e_fdir_flex_mask))))
-		return 1;
 
-	pf->fdir.flex_mask[pctype] = flex_mask;
 	return 0;
 }
 
-static void
-i40e_flow_set_fdir_flex_msk(struct i40e_pf *pf,
-			    enum i40e_filter_pctype pctype)
+static int
+i40e_fdir_flex_msk_program(struct i40e_pf *pf,
+			   enum i40e_filter_pctype pctype,
+			   const struct i40e_fdir_filter *filter)
 {
 	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
-	struct i40e_fdir_flex_mask *flex_mask;
+	struct i40e_fdir_flex_mask flex_mask;
 	uint32_t flxinset, fd_mask;
 	uint8_t i;
 
-	/* Set flex mask */
-	flex_mask = &pf->fdir.flex_mask[pctype];
-	flxinset = (flex_mask->word_mask <<
+	if (i40e_fdir_flex_mask_convert(filter->input.flow_ext.flex_mask,
+					&flex_mask) < 0)
+		return -EINVAL;
+
+	flxinset = (flex_mask.word_mask <<
 		    I40E_PRTQF_FD_FLXINSET_INSET_SHIFT) &
 		I40E_PRTQF_FD_FLXINSET_INSET_MASK;
 	i40e_write_rx_ctl(hw, I40E_PRTQF_FD_FLXINSET(pctype), flxinset);
 
-	for (i = 0; i < flex_mask->nb_bitmask; i++) {
-		fd_mask = (flex_mask->bitmask[i].mask <<
+	for (i = 0; i < flex_mask.nb_bitmask; i++) {
+		fd_mask = (flex_mask.bitmask[i].mask <<
 			   I40E_PRTQF_FD_MSK_MASK_SHIFT) &
 			   I40E_PRTQF_FD_MSK_MASK_MASK;
-		fd_mask |= ((flex_mask->bitmask[i].offset +
+		fd_mask |= ((flex_mask.bitmask[i].offset +
 			     I40E_FLX_OFFSET_IN_FIELD_VECTOR) <<
 			    I40E_PRTQF_FD_MSK_OFFSET_SHIFT) &
 				I40E_PRTQF_FD_MSK_OFFSET_MASK;
 		i40e_write_rx_ctl(hw, I40E_PRTQF_FD_MSK(pctype, i), fd_mask);
 	}
 
-	pf->fdir.flex_mask_flag[pctype] = 1;
+	return 0;
 }
 
 static int
-i40e_flow_set_fdir_inset(struct i40e_pf *pf,
-			 enum i40e_filter_pctype pctype,
-			 uint64_t input_set)
+i40e_fdir_flex_check(struct i40e_pf *pf,
+		     const struct i40e_fdir_filter *filter,
+		     enum i40e_filter_pctype pctype,
+		     struct i40e_fdir_flex_mask *flex_mask)
 {
-	uint32_t mask_reg[I40E_INSET_MASK_NUM_REG] = {0};
-	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
-	uint64_t inset_reg = 0;
-	int i, num;
+	enum i40e_flxpld_layer_idx layer_idx = filter->input.flow_ext.layer_idx;
+	int ret;
+	int i;
+
+	for (i = 0; i < filter->input.flow_ext.raw_id; i++) {
+		uint8_t field_idx;
+
+		field_idx = layer_idx * I40E_MAX_FLXPLD_FIED + i;
+		ret = i40e_fdir_check_flex_pit(pf,
+				&filter->input.flow_ext.flex_pit[field_idx],
+				layer_idx, i);
+		if (ret < 0) {
+			PMD_DRV_LOG(ERR,
+				    "Conflict with the first flexible rule.");
+			return -EINVAL;
+		}
+	}
+
+	ret = i40e_fdir_check_flex_mask(pf, pctype,
+					filter->input.flow_ext.flex_mask,
+					flex_mask);
+	if (ret == -1) {
+		PMD_DRV_LOG(ERR, "Exceed maximal number of bitmasks");
+		return -EINVAL;
+	} else if (ret == -2) {
+		PMD_DRV_LOG(ERR, "Conflict with the first flexible rule");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void
+i40e_fdir_flex_store(struct i40e_pf *pf,
+		      const struct i40e_fdir_filter *filter,
+		      enum i40e_filter_pctype pctype,
+		      const struct i40e_fdir_flex_mask *flex_mask)
+{
+	enum i40e_flxpld_layer_idx layer_idx = filter->input.flow_ext.layer_idx;
+	struct i40e_fdir_flow_store *flows = &pf->fdir.flows;
+	struct i40e_fdir_pctype_state *state = &flows->pctype[pctype];
+	struct i40e_fdir_layer_state *layer = &flows->layer[layer_idx];
+	int i;
+
+	for (i = 0; i < filter->input.flow_ext.raw_id; i++) {
+		uint8_t field_idx;
+
+		field_idx = layer_idx * I40E_MAX_FLXPLD_FIED + i;
+		layer->flex_set[i] = filter->input.flow_ext.flex_pit[field_idx];
+	}
+
+	state->flex_mask = *flex_mask;
+}
+
+/* Validate an input set against what earlier filters on this pctype established */
+static int
+i40e_fdir_inset_check(struct i40e_pf *pf,
+		      enum i40e_filter_pctype pctype,
+		      uint64_t input_set)
+{
+	struct i40e_fdir_flow_store *flows = &pf->fdir.flows;
+	struct i40e_fdir_pctype_state *state = &flows->pctype[pctype];
 
-	/* Check if the input set is valid */
 	if (i40e_validate_input_set(pctype, RTE_ETH_FILTER_FDIR,
 				    input_set) != 0) {
 		PMD_DRV_LOG(ERR, "Invalid input set");
 		return -EINVAL;
 	}
 
-	/* Check if the configuration is conflicted */
-	if (pf->fdir.flow_count[pctype] &&
-	    memcmp(&pf->fdir.input_set[pctype], &input_set, sizeof(uint64_t))) {
+	if (state->flow_count && state->input_set != input_set) {
 		PMD_DRV_LOG(ERR, "Conflict with the first rule's input set.");
 		return -EINVAL;
 	}
 
-	if (pf->fdir.flow_count[pctype] &&
-	    !memcmp(&pf->fdir.input_set[pctype], &input_set, sizeof(uint64_t)))
-		return 0;
+	return 0;
+}
+
+static int
+i40e_fdir_inset_program(struct i40e_pf *pf,
+			enum i40e_filter_pctype pctype,
+			uint64_t input_set)
+{
+	uint32_t mask_reg[I40E_INSET_MASK_NUM_REG] = {0};
+	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
+	uint64_t inset_reg = 0;
+	int i, num;
 
 	num = i40e_generate_inset_mask_reg(hw, input_set, mask_reg,
 						 I40E_INSET_MASK_NUM_REG);
@@ -1360,7 +1624,6 @@ i40e_flow_set_fdir_inset(struct i40e_pf *pf,
 
 	I40E_WRITE_FLUSH(hw);
 
-	pf->fdir.input_set[pctype] = input_set;
 	return 0;
 }
 
@@ -1403,166 +1666,298 @@ i40e_find_available_buffer(struct rte_eth_dev *dev)
 	return (unsigned char *)fdir_info->prg_pkt[txq->tx_tail >> 1];
 }
 
+static enum i40e_filter_pctype
+i40e_fdir_filter_pctype(const struct i40e_fdir_filter *filter)
+{
+	if (filter->input.flow_ext.pkt_template)
+		return filter->input.flow.raw_flow.pctype;
+
+	return filter->input.pctype;
+}
+
+bool
+i40e_fdir_filter_needs_status_wait(const struct i40e_pf *pf,
+				   uint32_t filter_count)
+{
+	if (pf->fdir.fdir_invalprio != 1)
+		return true;
+
+	return filter_count >= pf->fdir.fdir_guarantee_total_space;
+}
+
 /**
- * i40e_flow_add_del_fdir_filter - add or remove a flow director filter.
- * @pf: board private structure
- * @filter: fdir filter entry
- * @add: 0 - delete, 1 - add
+ * i40e_fdir_filter_validate - check whether a filter can be accepted at all.
+ *
+ * Only inspects the filter itself; conflicts against already registered
+ * filters are detected by i40e_fdir_filter_register().
  */
 int
-i40e_flow_add_del_fdir_filter(struct rte_eth_dev *dev,
-			      const struct i40e_fdir_filter_conf *filter,
-			      bool add)
+i40e_fdir_filter_validate(struct rte_eth_dev *dev,
+			  const struct i40e_fdir_filter *filter)
 {
-	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-	enum i40e_flxpld_layer_idx layer_idx = I40E_FLXPLD_L2_IDX;
-	struct i40e_fdir_info *fdir_info = &pf->fdir;
-	uint8_t flex_mask[I40E_FDIR_MAX_FLEX_LEN];
-	struct i40e_fdir_filter check_filter; /* Check if the filter exists */
-	struct i40e_fdir_flex_pit flex_pit;
-	enum i40e_filter_pctype pctype;
-	struct i40e_fdir_filter *node;
-	unsigned char *pkt = NULL;
-	bool cfg_flex_pit = true;
-	bool wait_status = true;
-	uint8_t field_idx;
-	int ret = 0;
-	int i;
-
-	if (pf->fdir.fdir_vsi == NULL) {
-		PMD_DRV_LOG(ERR, "FDIR is not enabled");
-		return -ENOTSUP;
-	}
 
 	if (filter->action.rx_queue >= pf->dev_data->nb_rx_queues) {
 		PMD_DRV_LOG(ERR, "Invalid queue ID");
 		return -EINVAL;
 	}
+
 	if (filter->input.flow_ext.is_vf &&
 	    filter->input.flow_ext.dst_id >= pf->vf_num) {
 		PMD_DRV_LOG(ERR, "Invalid VF ID");
 		return -EINVAL;
 	}
-	if (filter->input.flow_ext.pkt_template) {
-		if (filter->input.flow.raw_flow.length > I40E_FDIR_PKT_LEN ||
-		    !filter->input.flow.raw_flow.packet) {
-			PMD_DRV_LOG(ERR, "Invalid raw packet template"
-				" flow filter parameters!");
-			return -EINVAL;
-		}
-		pctype = filter->input.flow.raw_flow.pctype;
-	} else {
-		pctype = filter->input.pctype;
-	}
-
-	/* Check if there is the filter in SW list */
-	memset(&check_filter, 0, sizeof(check_filter));
-	i40e_fdir_filter_convert(filter, &check_filter);
+
+	if (filter->input.flow_ext.pkt_template &&
+	    (filter->input.flow.raw_flow.length > I40E_FDIR_PKT_LEN ||
+	     filter->input.flow.raw_flow.packet == NULL)) {
+		PMD_DRV_LOG(ERR,
+			    "Invalid raw packet template flow filter parameters!");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * Records the filter and everything derived from it.
+ */
+int
+i40e_fdir_filter_register(struct rte_eth_dev *dev,
+			  const struct i40e_fdir_filter *filter,
+			  struct i40e_fdir_filter **node)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	enum i40e_filter_pctype pctype = i40e_fdir_filter_pctype(filter);
+	uint64_t input_set = filter->input.flow_ext.input_set;
+	struct i40e_fdir_flow_store *flows = &pf->fdir.flows;
+	struct i40e_fdir_pctype_state *state = &flows->pctype[pctype];
+	struct i40e_fdir_layer_state *layer = NULL;
+	struct i40e_fdir_flex_mask flex_mask;
+	bool common_pctype;
+	int ret;
+
+	ret = i40e_fdir_engine_init(dev);
+	if (ret < 0)
+		return ret;
+
+	/* check input set if the packet type is common */
+	common_pctype = !filter->input.flow_ext.customized_pctype;
+
+	if (common_pctype) {
+		ret = i40e_fdir_inset_check(pf, pctype, input_set);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* check if flex flow configuration is valid */
+	if (filter->input.flow_ext.is_flex_flow) {
+		ret = i40e_fdir_flex_check(pf, filter, pctype, &flex_mask);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* register the flow with the hash table */
+	ret = i40e_fdir_filter_hash_add(pf, filter, node);
+	if (ret < 0) {
+		PMD_DRV_LOG(ERR, "Conflict with existing flow director rules!");
+		return ret;
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
+	i40e_fdir_rx_proc_sync(dev);
+
+	return 0;
+}
+
+/**
+ * i40e_fdir_filter_unregister - drop software ownership of a filter.
+ */
+int
+i40e_fdir_filter_unregister(struct rte_eth_dev *dev,
+			    struct i40e_fdir_filter *node)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	enum i40e_filter_pctype pctype = i40e_fdir_filter_pctype(node);
+	enum i40e_flxpld_layer_idx layer_idx = node->input.flow_ext.layer_idx;
+	bool is_flex_flow = node->input.flow_ext.is_flex_flow;
+	struct i40e_fdir_flow_store *flows = &pf->fdir.flows;
+	struct i40e_fdir_pctype_state *state = &flows->pctype[pctype];
+	struct i40e_fdir_layer_state *layer = &flows->layer[layer_idx];
+	int ret;
+
+	ret = i40e_fdir_filter_hash_del(pf, node);
+	if (ret < 0)
+		return ret;
+
+	if (is_flex_flow && --layer->flex_flow_count == 0)
+		layer->flex_pit_flag = false;
+
+	if (--state->flow_count == 0)
+		state->flex_mask_flag = false;
+
+	pf->fdir.fdir_actual_cnt--;
+
+	i40e_fdir_rx_proc_sync(dev);
+
+	return 0;
+}
+
+/* Take software ownership of a packet template filter, owning its packet */
+static int
+i40e_fdir_tmpl_register(struct rte_eth_dev *dev,
+			const struct i40e_fdir_filter *filter,
+			struct i40e_fdir_tmpl_filter **node)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	const struct i40e_raw_flow *raw = &filter->input.flow.raw_flow;
+	struct i40e_fdir_info *fdir_info = &pf->fdir;
+	struct i40e_fdir_tmpl_filter *tmpl;
+	struct i40e_fdir_tmpl_key key;
+	uint8_t *packet;
+	int ret;
+
+	ret = i40e_fdir_engine_init(dev);
+	if (ret < 0)
+		return ret;
+
+	ret = i40e_fdir_tmpl_store_init(dev);
+	if (ret < 0)
+		return ret;
+
+	if (i40e_fdir_tmpl_lookup(fdir_info, raw) != NULL) {
+		PMD_DRV_LOG(ERR, "Conflict with existing flow director rules!");
+		return -EEXIST;
+	}
+
+	packet = rte_malloc("fdir_tmpl_packet", raw->length, 0);
+	if (packet == NULL)
+		return -ENOMEM;
+	memcpy(packet, raw->packet, raw->length);
+
+	/* the stored key borrows the packet, so it must point at our copy */
+	i40e_fdir_tmpl_key_fill(&key, raw, packet);
+
+	ret = rte_hash_add_key_with_hash(fdir_info->tmpls.hash_table, &key,
+					 i40e_fdir_tmpl_sig(raw));
+	if (ret < 0) {
+		PMD_DRV_LOG(ERR,
+			    "Failed to insert fdir template to hash table %d!",
+			    ret);
+		rte_free(packet);
+		return ret;
+	}
+
+	tmpl = &fdir_info->tmpls.filter_array[ret];
+	tmpl->fdir = *filter;
+	tmpl->packet = packet;
+	tmpl->fdir.input.flow.raw_flow.packet = packet;
+
+	fdir_info->fdir_actual_cnt++;
+
+	i40e_fdir_rx_proc_sync(dev);
+
+	*node = tmpl;
+
+	return 0;
+}
+
+static int
+i40e_fdir_tmpl_unregister(struct rte_eth_dev *dev,
+			  struct i40e_fdir_tmpl_filter *node)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	const struct i40e_raw_flow *raw = &node->fdir.input.flow.raw_flow;
+	struct i40e_fdir_info *fdir_info = &pf->fdir;
+	struct i40e_fdir_tmpl_key key;
+	int ret;
+
+	i40e_fdir_tmpl_key_fill(&key, raw, raw->packet);
+
+	ret = rte_hash_del_key_with_hash(fdir_info->tmpls.hash_table, &key,
+					 i40e_fdir_tmpl_sig(raw));
+	if (ret < 0) {
+		PMD_DRV_LOG(ERR,
+			    "Failed to delete fdir template from hash table %d!",
+			    ret);
+		return ret;
+	}
+
+	rte_free(node->packet);
+	node->packet = NULL;
+
+	fdir_info->fdir_actual_cnt--;
+
+	i40e_fdir_rx_proc_sync(dev);
+
+	return 0;
+}
+
+/**
+ * i40e_fdir_filter_program - apply a filter to the hardware.
+ *
+ * Derives everything it needs from the filter itself and touches no software
+ * bookkeeping, so it may be called repeatedly to reapply an already registered
+ * filter. The caller is responsible for having validated and registered it.
+ */
+int
+i40e_fdir_filter_program(struct rte_eth_dev *dev,
+			 const struct i40e_fdir_filter *filter,
+			 bool add, bool wait_status)
+{
+	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	enum i40e_filter_pctype pctype = i40e_fdir_filter_pctype(filter);
+	unsigned char *pkt;
+	int ret;
+
+	if (pf->fdir.fdir_vsi == NULL) {
+		PMD_DRV_LOG(ERR, "FDIR is not enabled");
+		return -ENOTSUP;
+	}
 
 	if (add) {
-		/* configure the input set for common PCTYPEs*/
 		if (!filter->input.flow_ext.customized_pctype &&
 		    !filter->input.flow_ext.pkt_template) {
-			ret = i40e_flow_set_fdir_inset(pf, pctype,
+			ret = i40e_fdir_inset_program(pf, pctype,
 					filter->input.flow_ext.input_set);
 			if (ret < 0)
 				return ret;
 		}
 
 		if (filter->input.flow_ext.is_flex_flow) {
-			for (i = 0; i < filter->input.flow_ext.raw_id; i++) {
-				layer_idx = filter->input.flow_ext.layer_idx;
-				field_idx = layer_idx * I40E_MAX_FLXPLD_FIED + i;
-				flex_pit = filter->input.flow_ext.flex_pit[field_idx];
-
-				/* Store flex pit to SW */
-				ret = i40e_flow_store_flex_pit(pf, &flex_pit,
-							       layer_idx, i);
-				if (ret < 0) {
-					PMD_DRV_LOG(ERR, "Conflict with the"
-						    " first flexible rule.");
-					return -EINVAL;
-				} else if (ret > 0) {
-					cfg_flex_pit = false;
-				}
-			}
-
-			/* Store flex mask to SW */
-			for (i = 0; i < I40E_FDIR_MAX_FLEX_LEN; i++)
-				flex_mask[i] =
-					filter->input.flow_ext.flex_mask[i];
-
-			/* Validate the flex mask before writing any hardware
-			 * register. i40e_flow_set_fdir_flex_pit() below programs
-			 * the global GLQF_ORT register, which is shared by all
-			 * PFs on the NIC, so it must not be touched for a rule
-			 * that is going to be rejected.
-			 */
-			ret = i40e_flow_store_flex_mask(pf, pctype, flex_mask);
-			if (ret == -1) {
-				PMD_DRV_LOG(ERR, "Exceed maximal"
-					    " number of bitmasks");
-				return -EINVAL;
-			} else if (ret == -2) {
-				PMD_DRV_LOG(ERR, "Conflict with the"
-					    " first flexible rule");
-				return -EINVAL;
-			}
-
-			if (cfg_flex_pit)
-				i40e_flow_set_fdir_flex_pit(pf, layer_idx,
-						filter->input.flow_ext.raw_id);
-
-			if (ret == 0)
-				i40e_flow_set_fdir_flex_msk(pf, pctype);
+			i40e_fdir_flex_pit_program(pf, filter);
+			ret = i40e_fdir_flex_msk_program(pf, pctype, filter);
+			if (ret < 0)
+				return ret;
 		}
-
-		ret = i40e_sw_fdir_filter_insert(pf, &check_filter);
-		if (ret < 0) {
-			PMD_DRV_LOG(ERR,
-				    "Conflict with existing flow director rules!");
-			return -EINVAL;
-		}
-
-		if (fdir_info->fdir_invalprio == 1 &&
-				fdir_info->fdir_guarantee_free_space > 0)
-			wait_status = false;
-	} else {
-		if (filter->input.flow_ext.is_flex_flow)
-			layer_idx = filter->input.flow_ext.layer_idx;
-
-		node = i40e_sw_fdir_filter_lookup(fdir_info,
-				&check_filter.fdir.input);
-		if (!node) {
-			PMD_DRV_LOG(ERR,
-				    "There's no corresponding flow director filter!");
-			return -EINVAL;
-		}
-
-		ret = i40e_sw_fdir_filter_del(pf, &node->fdir.input);
-		if (ret < 0) {
-			PMD_DRV_LOG(ERR,
-					"Error deleting fdir rule from hash table!");
-			return -EINVAL;
-		}
-
-		pf->fdir.flex_mask_flag[pctype] = 0;
-
-		if (fdir_info->fdir_invalprio == 1)
-			wait_status = false;
 	}
 
-	/* find a buffer to store the pkt */
 	pkt = i40e_find_available_buffer(dev);
-	if (pkt == NULL)
-		goto error_op;
+	if (pkt == NULL) {
+		PMD_DRV_LOG(ERR, "No buffer available to program fdir filter.");
+		return -ENOSPC;
+	}
 
 	memset(pkt, 0, I40E_FDIR_PKT_LEN);
 	ret = i40e_flow_fdir_construct_pkt(pf, &filter->input, pkt);
 	if (ret < 0) {
 		PMD_DRV_LOG(ERR, "construct packet for fdir fails.");
-		goto error_op;
+		return ret;
 	}
 
 	if (hw->mac.type == I40E_MAC_X722) {
@@ -1576,45 +1971,72 @@ i40e_flow_add_del_fdir_filter(struct rte_eth_dev *dev,
 	if (ret < 0) {
 		PMD_DRV_LOG(ERR, "fdir programming fails for PCTYPE(%u).",
 			    pctype);
-		goto error_op;
+		return ret;
 	}
 
-	if (filter->input.flow_ext.is_flex_flow) {
-		if (add) {
-			fdir_info->flex_flow_count[layer_idx]++;
-			pf->fdir.flex_pit_flag[layer_idx] = 1;
-		} else {
-			fdir_info->flex_flow_count[layer_idx]--;
-			if (!fdir_info->flex_flow_count[layer_idx])
-				pf->fdir.flex_pit_flag[layer_idx] = 0;
-		}
-	}
+	return 0;
+}
+
+/**
+ * i40e_fdir_tmpl_add_del - add or remove a packet template filter.
+ * @dev: ethernet device
+ * @filter: fdir filter entry
+ * @add: 0 - delete, 1 - add
+ *
+ * Entry point for the PMD packet template API, whose filters have no rte_flow
+ * handle and so are tracked entirely here.
+ */
+int
+i40e_fdir_tmpl_add_del(struct rte_eth_dev *dev,
+		       const struct i40e_fdir_filter *filter,
+		       bool add)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct i40e_fdir_tmpl_filter *node;
+	int ret;
+
+	ret = i40e_fdir_filter_validate(dev, filter);
+	if (ret < 0)
+		return ret;
 
 	if (add) {
-		fdir_info->flow_count[pctype]++;
-		fdir_info->fdir_actual_cnt++;
-		if (fdir_info->fdir_invalprio == 1 &&
-				fdir_info->fdir_guarantee_free_space > 0)
-			fdir_info->fdir_guarantee_free_space--;
-	} else {
-		fdir_info->flow_count[pctype]--;
-		fdir_info->fdir_actual_cnt--;
-		if (fdir_info->fdir_invalprio == 1 &&
-				fdir_info->fdir_guarantee_free_space <
-				fdir_info->fdir_guarantee_total_space)
-			fdir_info->fdir_guarantee_free_space++;
+		/* register updates count, so store it */
+		uint32_t cnt = pf->fdir.fdir_actual_cnt;
+
+		ret = i40e_fdir_tmpl_register(dev, filter, &node);
+		if (ret < 0)
+			return ret;
+
+		ret = i40e_fdir_filter_program(dev, &node->fdir, true,
+				i40e_fdir_filter_needs_status_wait(pf, cnt));
+		if (ret < 0) {
+			i40e_fdir_tmpl_unregister(dev, node);
+			return ret;
+		}
+
+		TAILQ_INSERT_TAIL(&pf->fdir.tmpls.list, node, rules);
+
+		return 0;
 	}
 
-	return ret;
+	node = i40e_fdir_tmpl_lookup(&pf->fdir, &filter->input.flow.raw_flow);
+	if (node == NULL) {
+		PMD_DRV_LOG(ERR,
+			    "There's no corresponding flow director filter!");
+		return -EINVAL;
+	}
+
+	ret = i40e_fdir_filter_program(dev, &node->fdir, false, false);
+	if (ret < 0)
+		return ret;
+
+	ret = i40e_fdir_tmpl_unregister(dev, node);
+	if (ret < 0)
+		return ret;
 
-error_op:
-	/* roll back */
-	if (add)
-		i40e_sw_fdir_filter_del(pf, &check_filter.fdir.input);
-	else
-		i40e_sw_fdir_filter_insert(pf, &check_filter);
+	TAILQ_REMOVE(&pf->fdir.tmpls.list, node, rules);
 
-	return ret;
+	return 0;
 }
 
 /*
@@ -1629,7 +2051,7 @@ i40e_flow_add_del_fdir_filter(struct rte_eth_dev *dev,
 static int
 i40e_flow_fdir_filter_programming(struct i40e_pf *pf,
 				  enum i40e_filter_pctype pctype,
-				  const struct i40e_fdir_filter_conf *filter,
+				  const struct i40e_fdir_filter *filter,
 				  bool add, bool wait_status)
 {
 	struct ci_tx_queue *txq = pf->fdir.txq;
@@ -1813,6 +2235,9 @@ i40e_fdir_info_get_flex_set(struct i40e_pf *pf,
 	for (layer_idx = I40E_FLXPLD_L2_IDX;
 	     layer_idx <= I40E_FLXPLD_L4_IDX;
 	     layer_idx++) {
+		struct i40e_fdir_layer_state *layer =
+			&pf->fdir.flows.layer[layer_idx];
+
 		if (layer_idx == I40E_FLXPLD_L2_IDX)
 			ptr->type = RTE_ETH_L2_PAYLOAD;
 		else if (layer_idx == I40E_FLXPLD_L3_IDX)
@@ -1821,8 +2246,7 @@ i40e_fdir_info_get_flex_set(struct i40e_pf *pf,
 			ptr->type = RTE_ETH_L4_PAYLOAD;
 
 		for (i = 0; i < I40E_MAX_FLXPLD_FIED; i++) {
-			flex_pit = &pf->fdir.flex_set[layer_idx *
-				I40E_MAX_FLXPLD_FIED + i];
+			flex_pit = &layer->flex_set[i];
 			if (flex_pit->size == 0)
 				continue;
 			src = flex_pit->src_offset * sizeof(uint16_t);
@@ -1850,7 +2274,9 @@ i40e_fdir_info_get_flex_mask(struct i40e_pf *pf,
 	for (i = I40E_FILTER_PCTYPE_NONF_IPV4_UDP;
 	     i <= I40E_FILTER_PCTYPE_L2_PAYLOAD;
 	     i++) {
-		mask =  &pf->fdir.flex_mask[i];
+		struct i40e_fdir_pctype_state *state = &pf->fdir.flows.pctype[i];
+
+		mask = &state->flex_mask;
 		flow_type = i40e_pctype_to_flowtype(pf->adapter,
 						    (enum i40e_filter_pctype)i);
 		if (flow_type == RTE_ETH_FLOW_UNKNOWN)
@@ -1941,29 +2367,35 @@ i40e_fdir_stats_get(struct rte_eth_dev *dev, struct rte_eth_fdir_stats *stat)
 			    I40E_PFQF_FDSTAT_BEST_CNT_SHIFT);
 }
 
-/* Restore flow director filter */
 void
 i40e_fdir_filter_restore(struct i40e_pf *pf)
 {
 	struct rte_eth_dev *dev = I40E_VSI_TO_ETH_DEV(pf->main_vsi);
-	struct i40e_fdir_filter_list *fdir_list = &pf->fdir.fdir_list;
-	struct i40e_fdir_filter *f;
-	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
-	uint32_t fdstat;
-	uint32_t guarant_cnt;  /**< Number of filters in guaranteed spaces. */
-	uint32_t best_cnt;     /**< Number of filters in best effort spaces. */
+	struct i40e_fdir_tmpl_filter *tmpl;
+	struct rte_flow *flow;
+	int ret;
 
-	TAILQ_FOREACH(f, fdir_list, rules)
-		i40e_flow_add_del_fdir_filter(dev, &f->fdir, TRUE);
+	i40e_fdir_rx_proc_sync(dev);
 
-	fdstat = I40E_READ_REG(hw, I40E_PFQF_FDSTAT);
-	guarant_cnt =
-		(uint32_t)((fdstat & I40E_PFQF_FDSTAT_GUARANT_CNT_MASK) >>
-			   I40E_PFQF_FDSTAT_GUARANT_CNT_SHIFT);
-	best_cnt =
-		(uint32_t)((fdstat & I40E_PFQF_FDSTAT_BEST_CNT_MASK) >>
-			   I40E_PFQF_FDSTAT_BEST_CNT_SHIFT);
+	if (pf->fdir.fdir_vsi == NULL)
+		return;
 
-	PMD_DRV_LOG(INFO, "FDIR: Guarant count: %d,  Best count: %d",
-		    guarant_cnt, best_cnt);
+	TAILQ_FOREACH(flow, &pf->flow_list, node) {
+		struct i40e_fdir_filter *node = flow->rule;
+
+		if (flow->filter_type != RTE_ETH_FILTER_FDIR)
+			continue;
+
+		ret = i40e_fdir_filter_program(dev, node, true, false);
+		if (ret < 0)
+			PMD_DRV_LOG(ERR,
+				    "Failed to restore flow director filter: %d", ret);
+	}
+
+	TAILQ_FOREACH(tmpl, &pf->fdir.tmpls.list, rules) {
+		ret = i40e_fdir_filter_program(dev, &tmpl->fdir, true, false);
+		if (ret < 0)
+			PMD_DRV_LOG(ERR,
+				    "Failed to restore flow director template: %d", ret);
+	}
 }
diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 8f09dfeb11..200de80863 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -67,11 +67,11 @@ static int i40e_flow_dev_dump(struct rte_eth_dev *dev,
 static int i40e_flow_parse_fdir_pattern(struct rte_eth_dev *dev,
 					const struct rte_flow_item *pattern,
 					struct rte_flow_error *error,
-					struct i40e_fdir_filter_conf *filter);
+					struct i40e_fdir_filter *filter);
 static int i40e_flow_parse_fdir_action(struct rte_eth_dev *dev,
 				       const struct rte_flow_action *actions,
 				       struct rte_flow_error *error,
-				       struct i40e_fdir_filter_conf *filter);
+				       struct i40e_fdir_filter *filter);
 static int i40e_flow_parse_tunnel_action(struct rte_eth_dev *dev,
 				 const struct rte_flow_action *actions,
 				 struct rte_flow_error *error,
@@ -1375,7 +1375,7 @@ i40e_flow_check_raw_item(const struct rte_flow_item *item,
 static uint8_t
 i40e_flow_fdir_get_pctype_value(struct i40e_pf *pf,
 				enum rte_flow_item_type item_type,
-				struct i40e_fdir_filter_conf *filter)
+				struct i40e_fdir_filter *filter)
 {
 	struct i40e_customized_pctype *cus_pctype = NULL;
 
@@ -1440,7 +1440,7 @@ i40e_flow_fdir_get_pctype_value(struct i40e_pf *pf,
 }
 
 static void
-i40e_flow_set_filter_spi(struct i40e_fdir_filter_conf *filter,
+i40e_flow_set_filter_spi(struct i40e_fdir_filter *filter,
 	const struct rte_flow_item_esp *esp_spec)
 {
 	if (filter->input.flow_ext.oip_type ==
@@ -1478,7 +1478,7 @@ static int
 i40e_flow_parse_fdir_pattern(struct rte_eth_dev *dev,
 			     const struct rte_flow_item *pattern,
 			     struct rte_flow_error *error,
-			     struct i40e_fdir_filter_conf *filter)
+			     struct i40e_fdir_filter *filter)
 {
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	const struct rte_flow_item *item = pattern;
@@ -2310,7 +2310,7 @@ static int
 i40e_flow_parse_fdir_action(struct rte_eth_dev *dev,
 			    const struct rte_flow_action *actions,
 			    struct rte_flow_error *error,
-			    struct i40e_fdir_filter_conf *filter)
+			    struct i40e_fdir_filter *filter)
 {
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	struct ci_flow_actions parsed_actions = {0};
@@ -2430,7 +2430,7 @@ i40e_flow_parse_fdir_filter(struct rte_eth_dev *dev,
 			    struct rte_flow_error *error,
 			    struct i40e_filter_ctx *filter)
 {
-	struct i40e_fdir_filter_conf *fdir_filter = &filter->fdir_filter;
+	struct i40e_fdir_filter *fdir_filter = &filter->fdir_filter;
 	int ret;
 
 	ret = i40e_flow_parse_fdir_pattern(dev, pattern, error, fdir_filter);
@@ -3756,28 +3756,6 @@ i40e_flow_create(struct rte_eth_dev *dev,
 		return NULL;
 
 	if (filter_ctx.type == RTE_ETH_FILTER_FDIR) {
-		/* if this is the first time we're creating an fdir flow */
-		if (pf->fdir.fdir_vsi == NULL) {
-			ret = i40e_fdir_setup(pf);
-			if (ret != I40E_SUCCESS) {
-				rte_flow_error_set(error, ENOTSUP,
-						RTE_FLOW_ERROR_TYPE_HANDLE,
-						NULL, "Failed to setup fdir.");
-				return NULL;
-			}
-			ret = i40e_fdir_configure(dev);
-			if (ret < 0) {
-				rte_flow_error_set(error, ENOTSUP,
-						RTE_FLOW_ERROR_TYPE_HANDLE,
-						NULL, "Failed to configure fdir.");
-				i40e_fdir_teardown(pf);
-				return NULL;
-			}
-		}
-		/* If create the first fdir rule, enable fdir check for rx queues */
-		if (TAILQ_EMPTY(&pf->fdir.fdir_list))
-			i40e_fdir_rx_proc_enable(dev, 1);
-
 		flow = i40e_fdir_entry_pool_get(fdir_info);
 		if (flow == NULL) {
 			rte_flow_error_set(error, ENOBUFS,
@@ -3797,13 +3775,26 @@ i40e_flow_create(struct rte_eth_dev *dev,
 	}
 
 	switch (filter_ctx.type) {
-	case RTE_ETH_FILTER_FDIR:
-		ret = i40e_flow_add_del_fdir_filter(dev, &filter_ctx.fdir_filter, 1);
+	case RTE_ETH_FILTER_FDIR: {
+		struct i40e_fdir_filter *node;
+
+		ret = i40e_fdir_filter_validate(dev, &filter_ctx.fdir_filter);
 		if (ret)
 			goto free_flow;
-		flow->rule = TAILQ_LAST(&pf->fdir.fdir_list,
-					i40e_fdir_filter_list);
+		ret = i40e_fdir_filter_register(dev, &filter_ctx.fdir_filter,
+						&node);
+		if (ret)
+			goto free_flow;
+		ret = i40e_fdir_filter_program(dev, node, 1,
+				i40e_fdir_filter_needs_status_wait(pf,
+					fdir_info->fdir_actual_cnt - 1));
+		if (ret) {
+			i40e_fdir_filter_unregister(dev, node);
+			goto free_flow;
+		}
+		flow->rule = node;
 		break;
+	}
 	case RTE_ETH_FILTER_TUNNEL:
 		ret = i40e_dev_consistent_tunnel_filter_set(pf,
 				&filter_ctx.consistent_tunnel_filter, 1);
@@ -3860,16 +3851,15 @@ i40e_flow_destroy(struct rte_eth_dev *dev,
 		ret = i40e_flow_destroy_tunnel_filter(pf,
 			      (struct i40e_tunnel_filter *)flow->rule);
 		break;
-	case RTE_ETH_FILTER_FDIR:
-		ret = i40e_flow_add_del_fdir_filter(dev,
-				&((struct i40e_fdir_filter *)flow->rule)->fdir,
-				0);
+	case RTE_ETH_FILTER_FDIR: {
+		struct i40e_fdir_filter *node = flow->rule;
 
-		/* If the last flow is destroyed, disable fdir. */
-		if (!ret && TAILQ_EMPTY(&pf->fdir.fdir_list)) {
-			i40e_fdir_rx_proc_enable(dev, 0);
-		}
+		ret = i40e_fdir_filter_program(dev, node, 0, false);
+		if (ret)
+			break;
+		ret = i40e_fdir_filter_unregister(dev, node);
 		break;
+	}
 	case RTE_ETH_FILTER_HASH:
 		ret = i40e_hash_filter_destroy(pf, flow->rule);
 		break;
@@ -3994,59 +3984,24 @@ i40e_flow_flush_fdir_filter(struct i40e_pf *pf)
 {
 	struct rte_eth_dev *dev = &rte_eth_devices[pf->dev_data->port_id];
 	struct i40e_fdir_info *fdir_info = &pf->fdir;
-	struct i40e_fdir_filter *fdir_filter;
-	enum i40e_filter_pctype pctype;
 	struct rte_flow *flow;
 	void *temp;
 	int ret;
-	uint32_t i = 0;
 
-	ret = i40e_fdir_flush(dev);
-	if (!ret) {
-		/* Delete FDIR filters in FDIR list. */
-		while ((fdir_filter = TAILQ_FIRST(&fdir_info->fdir_list))) {
-			ret = i40e_sw_fdir_filter_del(pf,
-						      &fdir_filter->fdir.input);
-			if (ret < 0)
-				return ret;
-		}
-
-		/* Delete FDIR flows in flow list. */
-		RTE_TAILQ_FOREACH_SAFE(flow, &pf->flow_list, node, temp) {
-			if (flow->filter_type == RTE_ETH_FILTER_FDIR) {
-				TAILQ_REMOVE(&pf->flow_list, flow, node);
-			}
-		}
-
-		/* reset bitmap */
-		rte_bitmap_reset(fdir_info->fdir_flow_pool.bitmap);
-		for (i = 0; i < fdir_info->fdir_space_size; i++) {
-			fdir_info->fdir_flow_pool.pool[i].idx = i;
-			rte_bitmap_set(fdir_info->fdir_flow_pool.bitmap, i);
-		}
-
-		fdir_info->fdir_actual_cnt = 0;
-		fdir_info->fdir_guarantee_free_space =
-			fdir_info->fdir_guarantee_total_space;
-		memset(fdir_info->fdir_filter_array,
-			0,
-			sizeof(struct i40e_fdir_filter) *
-			I40E_MAX_FDIR_FILTER_NUM);
-
-		for (pctype = I40E_FILTER_PCTYPE_NONF_IPV4_UDP;
-		     pctype <= I40E_FILTER_PCTYPE_L2_PAYLOAD; pctype++) {
-			pf->fdir.flow_count[pctype] = 0;
-			pf->fdir.flex_mask_flag[pctype] = 0;
-		}
-
-		for (i = 0; i < I40E_MAX_FLXPLD_LAYER; i++)
-			pf->fdir.flex_pit_flag[i] = 0;
-
-		/* Disable FDIR processing as all FDIR rules are now flushed */
-		i40e_fdir_rx_proc_enable(dev, 0);
+	RTE_TAILQ_FOREACH_SAFE(flow, &pf->flow_list, node, temp) {
+		if (flow->filter_type != RTE_ETH_FILTER_FDIR)
+			continue;
+		ret = i40e_fdir_filter_program(dev, flow->rule, false, false);
+		if (ret < 0)
+			return ret;
+		ret = i40e_fdir_filter_unregister(dev, flow->rule);
+		if (ret < 0)
+			return ret;
+		TAILQ_REMOVE(&pf->flow_list, flow, node);
+		i40e_fdir_entry_pool_put(fdir_info, flow);
 	}
 
-	return ret;
+	return 0;
 }
 
 /* Flush all tunnel filters */
diff --git a/drivers/net/intel/i40e/rte_pmd_i40e.c b/drivers/net/intel/i40e/rte_pmd_i40e.c
index 2e7943ef8b..5b9234f8e5 100644
--- a/drivers/net/intel/i40e/rte_pmd_i40e.c
+++ b/drivers/net/intel/i40e/rte_pmd_i40e.c
@@ -3044,7 +3044,7 @@ int rte_pmd_i40e_flow_add_del_packet_template(
 			uint8_t add)
 {
 	struct rte_eth_dev *dev = &rte_eth_devices[port];
-	struct i40e_fdir_filter_conf filter_conf;
+	struct i40e_fdir_filter filter_conf;
 
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
 
@@ -3068,7 +3068,7 @@ int rte_pmd_i40e_flow_add_del_packet_template(
 		(enum i40e_fdir_status)conf->action.report_status;
 	filter_conf.action.flex_off = conf->action.flex_off;
 
-	return i40e_flow_add_del_fdir_filter(dev, &filter_conf, add);
+	return i40e_fdir_tmpl_add_del(dev, &filter_conf, add);
 }
 
 RTE_EXPORT_SYMBOL(rte_pmd_i40e_inset_get)
-- 
2.52.0

