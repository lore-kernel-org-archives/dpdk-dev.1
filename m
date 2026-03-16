Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBE1F53D80
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 17:30:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CF8840B99;
	Mon, 16 Mar 2026 18:28:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 26606406B6
 for <dev@dpdk.org>; Mon, 16 Mar 2026 18:28:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773682096; x=1805218096;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ATY0PXg607CogEd3qnVg/DPduoNUeDHx+N/t+O3ZmkY=;
 b=CWBsOJlfz2YtHz6td5zgtUrUxl20LJIilLX8t7amURxqxpdwcNWj8X46
 kjAUXdeHNNOsyMPaQNl4o+2Qd6/3fX1bSCgzLfX35j6Gjrw25dW+f7/0b
 e51FKr8UaQRckiAH/8D7hy5P0UYlpFbsk8Zi9NjInmf/llpaZbKsyOnEW
 BIimjGXNTtAgTHSKUCLhs+96wv9uvgQ6rH57mX8jdcMjXXBxlkwgDbN9h
 e4P66z5uVb3SmQPlCaEkRlTCZA/WZJucXJtJ2Thic1jo+EJPu99vF/dV+
 6U9E9WNiblSVIj0mJt0OlcMSCLDaYvHn4bJCjd4hqZD1n1h9fYQWG+eYL Q==;
X-CSE-ConnectionGUID: 5SHSgZJTTEaxMWCn70mblQ==
X-CSE-MsgGUID: AMNUl+pmQ2CpJoiRu+kYuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86059650"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="86059650"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 10:28:16 -0700
X-CSE-ConnectionGUID: C8YHNeIRQfqfbs9AmLyAyA==
X-CSE-MsgGUID: FESivxzjRxO7lg3C/cK6ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221228261"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 16 Mar 2026 10:28:15 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH v1 14/21] net/i40e: reimplement FDIR parser
Date: Mon, 16 Mar 2026 17:27:42 +0000
Message-ID: <9f642b3f7785e6717828376c7d121d9dbc9e9cba.1773681365.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773681363.git.anatoly.burakov@intel.com>
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

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c    |   48 -
 drivers/net/intel/i40e/i40e_ethdev.h    |   25 +-
 drivers/net/intel/i40e/i40e_fdir.c      |   47 -
 drivers/net/intel/i40e/i40e_flow.c      | 1965 +----------------------
 drivers/net/intel/i40e/i40e_flow.h      |    6 +
 drivers/net/intel/i40e/i40e_flow_fdir.c | 1806 +++++++++++++++++++++
 drivers/net/intel/i40e/meson.build      |    1 +
 7 files changed, 1824 insertions(+), 2074 deletions(-)
 create mode 100644 drivers/net/intel/i40e/i40e_flow_fdir.c

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index b71a4fb0d1..d4b5d36465 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -1104,10 +1104,6 @@ i40e_init_fdir_filter_list(struct rte_eth_dev *dev)
 	uint32_t alloc = hw->func_caps.fd_filters_guaranteed;
 	uint32_t best = hw->func_caps.fd_filters_best_effort;
 	enum i40e_filter_pctype pctype;
-	struct rte_bitmap *bmp = NULL;
-	uint32_t bmp_size;
-	void *mem = NULL;
-	uint32_t i = 0;
 	int ret;
 
 	struct rte_hash_parameters fdir_hash_params = {
@@ -1164,50 +1160,8 @@ i40e_init_fdir_filter_list(struct rte_eth_dev *dev)
 
 	PMD_DRV_LOG(INFO, "FDIR guarantee space: %u, best_effort space %u.", alloc, best);
 
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
 	return 0;
 
-err_fdir_bmp_alloc:
-	rte_free(mem);
-err_fdir_mem_alloc:
-	rte_free(fdir_info->fdir_flow_pool.pool);
-err_fdir_bitmap_flow_alloc:
 	rte_free(fdir_info->fdir_filter_array);
 err_fdir_filter_array_alloc:
 	rte_free(fdir_info->hash_map);
@@ -1940,8 +1894,6 @@ i40e_fdir_memory_cleanup(struct i40e_pf *pf)
 	/* flow director memory cleanup */
 	rte_free(fdir_info->hash_map);
 	rte_hash_free(fdir_info->hash_table);
-	rte_free(fdir_info->fdir_flow_pool.bitmap);
-	rte_free(fdir_info->fdir_flow_pool.pool);
 	rte_free(fdir_info->fdir_filter_array);
 }
 
diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 118ba8a6c7..7c4786bec0 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -718,28 +718,12 @@ struct i40e_fdir_filter {
 	struct i40e_fdir_filter_conf fdir;
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
 TAILQ_HEAD(i40e_fdir_filter_list, i40e_fdir_filter);
 /*
  *  A structure used to define fields of a FDIR related info.
  */
 struct i40e_fdir_info {
+	uint64_t num_fdir_flows;
 	struct i40e_vsi *fdir_vsi;     /* pointer to fdir VSI structure */
 	uint16_t match_counter_index;  /* Statistic counter index used for fdir*/
 	struct ci_tx_queue *txq;
@@ -790,8 +774,6 @@ struct i40e_fdir_info {
 	uint32_t fdir_guarantee_free_space;
 	/* the fdir total guaranteed space */
 	uint32_t fdir_guarantee_total_space;
-	/* the pre-allocated pool of the rte_flow */
-	struct i40e_fdir_flow_pool fdir_flow_pool;
 
 	/* Mark if flex pit and mask is set */
 	bool flex_pit_flag[I40E_MAX_FLXPLD_LAYER];
@@ -1311,7 +1293,6 @@ extern const struct rte_flow_ops i40e_flow_ops;
 
 struct i40e_filter_ctx {
 	union {
-		struct i40e_fdir_filter_conf fdir_filter;
 		struct i40e_tunnel_filter_conf consistent_tunnel_filter;
 		struct i40e_rte_flow_rss_conf rss_conf;
 	};
@@ -1408,10 +1389,6 @@ uint64_t i40e_get_default_input_set(uint16_t pctype);
 int i40e_ethertype_filter_set(struct i40e_pf *pf,
 			      struct rte_eth_ethertype_filter *filter,
 			      bool add);
-struct rte_flow *
-i40e_fdir_entry_pool_get(struct i40e_fdir_info *fdir_info);
-void i40e_fdir_entry_pool_put(struct i40e_fdir_info *fdir_info,
-		struct rte_flow *flow);
 int i40e_flow_add_del_fdir_filter(struct rte_eth_dev *dev,
 			      const struct i40e_fdir_filter_conf *filter,
 			      bool add);
diff --git a/drivers/net/intel/i40e/i40e_fdir.c b/drivers/net/intel/i40e/i40e_fdir.c
index 3b099d5a9e..8f72801206 100644
--- a/drivers/net/intel/i40e/i40e_fdir.c
+++ b/drivers/net/intel/i40e/i40e_fdir.c
@@ -1093,53 +1093,6 @@ i40e_sw_fdir_filter_del(struct i40e_pf *pf, struct i40e_fdir_input *input)
 	return 0;
 }
 
-struct rte_flow *
-i40e_fdir_entry_pool_get(struct i40e_fdir_info *fdir_info)
-{
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
-	ret = rte_bitmap_scan(fdir_info->fdir_flow_pool.bitmap, &pos,
-			&slab);
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
-	rte_bitmap_clear(fdir_info->fdir_flow_pool.bitmap, pos);
-	flow = &fdir_info->fdir_flow_pool.pool[pos].flow;
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
-	rte_bitmap_set(fdir_info->fdir_flow_pool.bitmap, f->idx);
-}
-
 static int
 i40e_flow_store_flex_pit(struct i40e_pf *pf,
 			 struct i40e_fdir_flex_pit *flex_pit,
diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 68155a58b4..44dcb4f5b2 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -32,12 +32,10 @@
 const struct ci_flow_engine_list i40e_flow_engine_list = {
 	{
 		&i40e_flow_engine_ethertype,
+		&i40e_flow_engine_fdir,
 	}
 };
 
-#define I40E_IPV6_TC_MASK	(0xFF << I40E_FDIR_IPv6_TC_OFFSET)
-#define I40E_IPV6_FRAG_HEADER	44
-#define I40E_TENANT_ARRAY_NUM	3
 #define I40E_VLAN_TCI_MASK	0xFFFF
 #define I40E_VLAN_PRI_MASK	0xE000
 #define I40E_VLAN_CFI_MASK	0x1000
@@ -62,23 +60,10 @@ static int i40e_flow_query(struct rte_eth_dev *dev,
 			   struct rte_flow *flow,
 			   const struct rte_flow_action *actions,
 			   void *data, struct rte_flow_error *error);
-static int i40e_flow_parse_fdir_pattern(struct rte_eth_dev *dev,
-					const struct rte_flow_item *pattern,
-					struct rte_flow_error *error,
-					struct i40e_fdir_filter_conf *filter);
-static int i40e_flow_parse_fdir_action(struct rte_eth_dev *dev,
-				       const struct rte_flow_action *actions,
-				       struct rte_flow_error *error,
-				       struct i40e_fdir_filter_conf *filter);
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
@@ -101,7 +86,6 @@ static int i40e_flow_parse_gtp_filter(struct rte_eth_dev *dev,
 				      struct i40e_filter_ctx *filter);
 static int i40e_flow_destroy_tunnel_filter(struct i40e_pf *pf,
 					   struct i40e_tunnel_filter *filter);
-static int i40e_flow_flush_fdir_filter(struct i40e_pf *pf);
 static int i40e_flow_flush_tunnel_filter(struct i40e_pf *pf);
 static int
 i40e_flow_parse_qinq_filter(struct rte_eth_dev *dev,
@@ -128,19 +112,6 @@ const struct rte_flow_ops i40e_flow_ops = {
 	.query = i40e_flow_query,
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
@@ -178,30 +149,6 @@ static enum rte_flow_item_type pattern_fdir_ipv4_gtpu[] = {
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
@@ -239,581 +186,6 @@ static enum rte_flow_item_type pattern_fdir_ipv6_gtpu[] = {
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
@@ -926,138 +298,7 @@ static enum rte_flow_item_type pattern_qinq_1[] = {
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
@@ -1080,9 +321,6 @@ static struct i40e_valid_pattern i40e_supported_patterns[] = {
 	{ pattern_fdir_ipv6_gtpu, i40e_flow_parse_gtp_filter },
 	/* QINQ */
 	{ pattern_qinq_1, i40e_flow_parse_qinq_filter },
-	/* L2TPv3 over IP */
-	{ pattern_fdir_ipv4_l2tpv3oip, i40e_flow_parse_fdir_filter },
-	{ pattern_fdir_ipv6_l2tpv3oip, i40e_flow_parse_fdir_filter },
 	/* L4 over port */
 	{ pattern_fdir_ipv4_udp, i40e_flow_parse_l4_cloud_filter },
 	{ pattern_fdir_ipv4_tcp, i40e_flow_parse_l4_cloud_filter },
@@ -1209,47 +447,7 @@ i40e_get_outer_vlan(struct rte_eth_dev *dev, uint16_t *tpid)
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
 				struct i40e_fdir_filter_conf *filter)
@@ -1316,1023 +514,6 @@ i40e_flow_fdir_get_pctype_value(struct i40e_pf *pf,
 	return I40E_FILTER_PCTYPE_INVALID;
 }
 
-static void
-i40e_flow_set_filter_spi(struct i40e_fdir_filter_conf *filter,
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
-			     struct i40e_fdir_filter_conf *filter)
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
-				ret = i40e_get_outer_vlan(dev, &tpid);
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
-				if (vlan_mask->hdr.vlan_tci !=
-				    rte_cpu_to_be_16(I40E_VLAN_TCI_MASK) &&
-				    vlan_mask->hdr.vlan_tci !=
-				    rte_cpu_to_be_16(I40E_VLAN_PRI_MASK) &&
-				    vlan_mask->hdr.vlan_tci !=
-				    rte_cpu_to_be_16(I40E_VLAN_CFI_MASK) &&
-				    vlan_mask->hdr.vlan_tci !=
-				    rte_cpu_to_be_16(I40E_VLAN_VID_MASK)) {
-					rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ITEM,
-						   item,
-						   "Unsupported TCI mask.");
-				}
-				input_set |= I40E_INSET_VLAN_INNER;
-				filter->input.flow_ext.vlan_tci =
-					vlan_spec->hdr.vlan_tci;
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
-				ret = i40e_get_outer_vlan(dev, &tpid);
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
-				rte_memcpy(filter->input.flow.ipv6_flow.src_ip,
-					   &ipv6_spec->hdr.src_addr, 16);
-				rte_memcpy(filter->input.flow.ipv6_flow.dst_ip,
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
-				if (raw_spec->length != raw_mask->length) {
-					rte_flow_error_set(error, EINVAL,
-							   RTE_FLOW_ERROR_TYPE_ITEM,
-							   item,
-							   "RAW spec and mask length mismatch");
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
-			    struct i40e_fdir_filter_conf *filter)
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
-	struct i40e_fdir_filter_conf *fdir_filter = &filter->fdir_filter;
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
@@ -3632,7 +1813,6 @@ i40e_flow_create(struct rte_eth_dev *dev,
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	struct i40e_filter_ctx filter_ctx = {0};
 	struct rte_flow *flow = NULL;
-	struct i40e_fdir_info *fdir_info = &pf->fdir;
 	int ret;
 
 	/* try the new engine first */
@@ -3645,55 +1825,15 @@ i40e_flow_create(struct rte_eth_dev *dev,
 	if (ret < 0)
 		return NULL;
 
-	if (filter_ctx.type == RTE_ETH_FILTER_FDIR) {
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
-	case RTE_ETH_FILTER_FDIR:
-		ret = i40e_flow_add_del_fdir_filter(dev, &filter_ctx.fdir_filter, 1);
-		if (ret)
-			goto free_flow;
-		flow->rule = TAILQ_LAST(&pf->fdir.fdir_list,
-					i40e_fdir_filter_list);
-		break;
 	case RTE_ETH_FILTER_TUNNEL:
 		ret = i40e_dev_consistent_tunnel_filter_set(pf,
 				&filter_ctx.consistent_tunnel_filter, 1);
@@ -3722,10 +1862,7 @@ i40e_flow_create(struct rte_eth_dev *dev,
 			   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
 			   "Failed to create flow.");
 
-	if (filter_ctx.type != RTE_ETH_FILTER_FDIR)
-		rte_free(flow);
-	else
-		i40e_fdir_entry_pool_put(fdir_info, flow);
+	rte_free(flow);
 
 	return NULL;
 }
@@ -3737,7 +1874,6 @@ i40e_flow_destroy(struct rte_eth_dev *dev,
 {
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	enum rte_filter_type filter_type = flow->filter_type;
-	struct i40e_fdir_info *fdir_info = &pf->fdir;
 	int ret = 0;
 
 	/* try the new engine first */
@@ -3751,16 +1887,6 @@ i40e_flow_destroy(struct rte_eth_dev *dev,
 		ret = i40e_flow_destroy_tunnel_filter(pf,
 			      (struct i40e_tunnel_filter *)flow->rule);
 		break;
-	case RTE_ETH_FILTER_FDIR:
-		ret = i40e_flow_add_del_fdir_filter(dev,
-				&((struct i40e_fdir_filter *)flow->rule)->fdir,
-				0);
-
-		/* If the last flow is destroyed, disable fdir. */
-		if (!ret && TAILQ_EMPTY(&pf->fdir.fdir_list)) {
-			i40e_fdir_rx_proc_enable(dev, 0);
-		}
-		break;
 	case RTE_ETH_FILTER_HASH:
 		ret = i40e_hash_filter_destroy(pf, flow->rule);
 		break;
@@ -3773,10 +1899,7 @@ i40e_flow_destroy(struct rte_eth_dev *dev,
 
 	if (!ret) {
 		TAILQ_REMOVE(&pf->flow_list, flow, node);
-		if (filter_type == RTE_ETH_FILTER_FDIR)
-			i40e_fdir_entry_pool_put(fdir_info, flow);
-		else
-			rte_free(flow);
+		rte_free(flow);
 
 	} else
 		rte_flow_error_set(error, -ret,
@@ -3856,14 +1979,6 @@ i40e_flow_flush(struct rte_eth_dev *dev, struct rte_flow_error *error)
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
@@ -3880,66 +1995,6 @@ i40e_flow_flush(struct rte_eth_dev *dev, struct rte_flow_error *error)
 	return ret;
 }
 
-static int
-i40e_flow_flush_fdir_filter(struct i40e_pf *pf)
-{
-	struct rte_eth_dev *dev = &rte_eth_devices[pf->dev_data->port_id];
-	struct i40e_fdir_info *fdir_info = &pf->fdir;
-	struct i40e_fdir_filter *fdir_filter;
-	enum i40e_filter_pctype pctype;
-	struct rte_flow *flow;
-	void *temp;
-	int ret;
-	uint32_t i = 0;
-
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
-	}
-
-	return ret;
-}
-
 /* Flush all tunnel filters */
 static int
 i40e_flow_flush_tunnel_filter(struct i40e_pf *pf)
diff --git a/drivers/net/intel/i40e/i40e_flow.h b/drivers/net/intel/i40e/i40e_flow.h
index d6efd95216..e6ad1afdba 100644
--- a/drivers/net/intel/i40e/i40e_flow.h
+++ b/drivers/net/intel/i40e/i40e_flow.h
@@ -8,13 +8,19 @@
 #include "../common/flow_engine.h"
 
 int i40e_get_outer_vlan(struct rte_eth_dev *dev, uint16_t *tpid);
+uint8_t
+i40e_flow_fdir_get_pctype_value(struct i40e_pf *pf,
+		enum rte_flow_item_type item_type,
+		struct i40e_fdir_filter_conf *filter);
 
 enum i40e_flow_engine_type {
 	I40E_FLOW_ENGINE_TYPE_ETHERTYPE = 0,
+	I40E_FLOW_ENGINE_TYPE_FDIR,
 };
 
 extern const struct ci_flow_engine_list i40e_flow_engine_list;
 
 extern const struct ci_flow_engine i40e_flow_engine_ethertype;
+extern const struct ci_flow_engine i40e_flow_engine_fdir;
 
 #endif /* _I40E_FLOW_H_ */
diff --git a/drivers/net/intel/i40e/i40e_flow_fdir.c b/drivers/net/intel/i40e/i40e_flow_fdir.c
new file mode 100644
index 0000000000..87435e9d2b
--- /dev/null
+++ b/drivers/net/intel/i40e/i40e_flow_fdir.c
@@ -0,0 +1,1806 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include "i40e_ethdev.h"
+#include "i40e_flow.h"
+
+#include <rte_bitmap.h>
+#include <rte_malloc.h>
+
+#include "../common/flow_engine.h"
+#include "../common/flow_check.h"
+#include "../common/flow_util.h"
+
+struct i40e_fdir_ctx {
+	struct ci_flow_engine_ctx base;
+	struct i40e_fdir_filter_conf fdir_filter;
+	enum rte_flow_item_type custom_pctype;
+	struct flex_item {
+		size_t size;
+		size_t offset;
+	} flex_data[I40E_MAX_FLXPLD_FIED];
+};
+
+struct i40e_flow_engine_fdir_flow {
+	struct rte_flow base;
+	struct i40e_fdir_filter_conf fdir_filter;
+};
+
+struct i40e_fdir_flow_pool_entry {
+	struct i40e_flow_engine_fdir_flow flow;
+	uint32_t idx;
+};
+
+struct i40e_fdir_engine_priv {
+	struct rte_bitmap *bmp;
+	struct i40e_fdir_flow_pool_entry *pool;
+};
+
+#define I40E_FDIR_FLOW_ENTRY(flow_ptr) \
+	container_of((flow_ptr), struct i40e_fdir_flow_pool_entry, flow)
+
+#define I40E_IPV6_FRAG_HEADER	44
+#define I40E_IPV6_TC_MASK	(0xFF << I40E_FDIR_IPv6_TC_OFFSET)
+#define I40E_VLAN_TCI_MASK	0xFFFF
+#define I40E_VLAN_PRI_MASK	0xE000
+#define I40E_VLAN_CFI_MASK	0x1000
+#define I40E_VLAN_VID_MASK	0x0FFF
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
+	I40E_FDIR_NODE_START = RTE_FLOW_NODE_FIRST,
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
+	struct i40e_fdir_filter_conf *fdir_conf = &fdir_ctx->fdir_filter;
+	const struct rte_flow_item_eth *eth_spec = item->spec;
+	const struct rte_flow_item_eth *eth_mask = item->mask;
+	uint16_t tpid, ether_type;
+	uint64_t input_set = 0;
+	int ret;
+
+	/* Set layer index for L2 flexible payload (after ETH/VLAN) */
+	fdir_conf->input.flow_ext.layer_idx = I40E_FLXPLD_L2_IDX;
+
+	/* set packet type */
+	fdir_conf->input.pctype = I40E_FILTER_PCTYPE_L2_PAYLOAD;
+
+	/* do we need to set up MAC addresses? */
+	if (eth_spec == NULL && eth_mask == NULL)
+		return 0;
+
+	/* do we care for source address? */
+	if (CI_FIELD_IS_MASKED(&eth_mask->hdr.src_addr)) {
+		fdir_conf->input.flow.l2_flow.src = eth_spec->hdr.src_addr;
+		input_set |= I40E_INSET_SMAC;
+	}
+	/* do we care for destination address? */
+	if (CI_FIELD_IS_MASKED(&eth_mask->hdr.dst_addr)) {
+		fdir_conf->input.flow.l2_flow.dst = eth_spec->hdr.dst_addr;
+		input_set |= I40E_INSET_DMAC;
+	}
+
+	/* do we care for ethertype? */
+	if (eth_mask->hdr.ether_type) {
+		ether_type = rte_be_to_cpu_16(eth_spec->hdr.ether_type);
+		ret = i40e_get_outer_vlan(fdir_ctx->base.dev, &tpid);
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
+		fdir_conf->input.flow.l2_flow.ether_type = eth_spec->hdr.ether_type;
+		input_set |= I40E_INSET_LAST_ETHER_TYPE;
+	}
+
+	fdir_conf->input.flow_ext.input_set = input_set;
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
+	const struct i40e_fdir_filter_conf *filter = &fdir_ctx->fdir_filter;
+	uint16_t ether_type;
+
+	if (vlan_spec == NULL && vlan_mask == NULL)
+		return 0;
+
+	/* TCI mask is required but must be one of the supported masks */
+	if (vlan_mask->hdr.vlan_tci != rte_cpu_to_be_16(I40E_VLAN_TCI_MASK) &&
+	    vlan_mask->hdr.vlan_tci != rte_cpu_to_be_16(I40E_VLAN_PRI_MASK) &&
+	    vlan_mask->hdr.vlan_tci != rte_cpu_to_be_16(I40E_VLAN_CFI_MASK) &&
+	    vlan_mask->hdr.vlan_tci != rte_cpu_to_be_16(I40E_VLAN_VID_MASK)) {
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
+	if (filter->input.flow_ext.input_set & I40E_INSET_LAST_ETHER_TYPE) {
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
+	struct i40e_fdir_filter_conf *filter = &fdir_ctx->fdir_filter;
+
+	/* Set layer index for L2 flexible payload (after ETH/VLAN) */
+	filter->input.flow_ext.layer_idx = I40E_FLXPLD_L2_IDX;
+
+	/* set packet type */
+	filter->input.pctype = I40E_FILTER_PCTYPE_L2_PAYLOAD;
+
+	if (vlan_spec == NULL && vlan_mask == NULL)
+		return 0;
+
+	/* Store TCI value if requested */
+	if (vlan_mask->hdr.vlan_tci) {
+		filter->input.flow_ext.vlan_tci = vlan_spec->hdr.vlan_tci;
+		filter->input.flow_ext.input_set |= I40E_INSET_VLAN_INNER;
+	}
+
+	/* if ethertype specified, store it */
+	if (vlan_mask->hdr.eth_proto) {
+		uint16_t tpid, ether_type;
+		int ret;
+
+		ether_type = rte_be_to_cpu_16(vlan_spec->hdr.eth_proto);
+
+		ret = i40e_get_outer_vlan(fdir_ctx->base.dev, &tpid);
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
+		filter->input.flow.l2_flow.ether_type = vlan_spec->hdr.eth_proto;
+		filter->input.flow_ext.input_set |= I40E_INSET_LAST_ETHER_TYPE;
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
+	struct i40e_fdir_filter_conf *filter = &fdir_ctx->fdir_filter;
+
+	/* Set layer index for L2 flexible payload (after ETH/VLAN) */
+	filter->input.flow_ext.layer_idx = I40E_FLXPLD_L3_IDX;
+
+	/* set packet type */
+	filter->input.pctype = I40E_FILTER_PCTYPE_NONF_IPV4_OTHER;
+
+	/* set up flow type */
+	filter->input.flow_ext.inner_ip = false;
+	filter->input.flow_ext.oip_type = I40E_FDIR_IPTYPE_IPV4;
+
+	if (ipv4_mask == NULL && ipv4_spec == NULL)
+		return 0;
+
+	/* Mark that IPv4 fields are used */
+	if (!CI_FIELD_IS_ZERO(&ipv4_mask->hdr.next_proto_id)) {
+		filter->input.flow.ip4_flow.proto = ipv4_spec->hdr.next_proto_id;
+		filter->input.flow_ext.input_set |= I40E_INSET_IPV4_PROTO;
+	}
+	if (!CI_FIELD_IS_ZERO(&ipv4_mask->hdr.type_of_service)) {
+		filter->input.flow.ip4_flow.tos = ipv4_spec->hdr.type_of_service;
+		filter->input.flow_ext.input_set |= I40E_INSET_IPV4_TOS;
+	}
+	if (!CI_FIELD_IS_ZERO(&ipv4_mask->hdr.time_to_live)) {
+		filter->input.flow.ip4_flow.ttl = ipv4_spec->hdr.time_to_live;
+		filter->input.flow_ext.input_set |= I40E_INSET_IPV4_TTL;
+	}
+	if (!CI_FIELD_IS_ZERO(&ipv4_mask->hdr.src_addr)) {
+		filter->input.flow.ip4_flow.src_ip = ipv4_spec->hdr.src_addr;
+		filter->input.flow_ext.input_set |= I40E_INSET_IPV4_SRC;
+	}
+	if (!CI_FIELD_IS_ZERO(&ipv4_mask->hdr.dst_addr)) {
+		filter->input.flow.ip4_flow.dst_ip = ipv4_spec->hdr.dst_addr;
+		filter->input.flow_ext.input_set |= I40E_INSET_IPV4_DST;
+	}
+
+	/* do we have range? */
+	if (ipv4_last == NULL) {
+		filter->input.pctype = I40E_FILTER_PCTYPE_FRAG_IPV4;
+		filter->input.flow_ext.customized_pctype = true;
+	}
+
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
+	struct i40e_fdir_filter_conf *filter = &fdir_ctx->fdir_filter;
+
+	/* Set layer index for L2 flexible payload (after ETH/VLAN) */
+	filter->input.flow_ext.layer_idx = I40E_FLXPLD_L3_IDX;
+
+	/* set packet type */
+	filter->input.pctype = I40E_FILTER_PCTYPE_NONF_IPV6_OTHER;
+
+	/* set up flow type */
+	filter->input.flow_ext.inner_ip = false;
+	filter->input.flow_ext.oip_type = I40E_FDIR_IPTYPE_IPV6;
+
+	if (ipv6_mask == NULL && ipv6_spec == NULL)
+		return 0;
+	if (CI_FIELD_IS_MASKED(&ipv6_mask->hdr.src_addr)) {
+		memcpy(&filter->input.flow.ipv6_flow.src_ip, &ipv6_spec->hdr.src_addr, sizeof(ipv6_spec->hdr.src_addr));
+		filter->input.flow_ext.input_set |= I40E_INSET_IPV6_SRC;
+	}
+	if (CI_FIELD_IS_MASKED(&ipv6_mask->hdr.dst_addr)) {
+		memcpy(&filter->input.flow.ipv6_flow.dst_ip, &ipv6_spec->hdr.dst_addr, sizeof(ipv6_spec->hdr.dst_addr));
+		filter->input.flow_ext.input_set |= I40E_INSET_IPV6_DST;
+	}
+
+	if (!CI_FIELD_IS_ZERO(&ipv6_mask->hdr.vtc_flow)) {
+		rte_be32_t vtc_flow = rte_be_to_cpu_32(ipv6_mask->hdr.vtc_flow);
+		uint8_t tc = (uint8_t)(vtc_flow & I40E_IPV6_TC_MASK) >> I40E_FDIR_IPv6_TC_OFFSET;
+		filter->input.flow.ipv6_flow.tc = tc;
+		filter->input.flow_ext.input_set |= I40E_INSET_IPV6_TC;
+	}
+	if (!CI_FIELD_IS_ZERO(&ipv6_mask->hdr.proto)) {
+		filter->input.flow.ipv6_flow.proto = ipv6_spec->hdr.proto;
+		filter->input.flow_ext.input_set |= I40E_INSET_IPV6_NEXT_HDR;
+	}
+	if (!CI_FIELD_IS_ZERO(&ipv6_mask->hdr.hop_limits)) {
+		filter->input.flow.ipv6_flow.hop_limits = ipv6_spec->hdr.hop_limits;
+		filter->input.flow_ext.input_set |= I40E_INSET_IPV6_HOP_LIMIT;
+	}
+	/* mark as fragment traffic if necessary */
+	if (ipv6_spec->hdr.proto == I40E_IPV6_FRAG_HEADER) {
+		filter->input.pctype = I40E_FILTER_PCTYPE_FRAG_IPV6;
+	}
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
+	const struct i40e_fdir_filter_conf *filter = &fdir_ctx->fdir_filter;
+	const struct rte_flow_item_tcp *tcp_spec = item->spec;
+	const struct rte_flow_item_tcp *tcp_mask = item->mask;
+
+	/* cannot match both fragmented and TCP */
+	if (filter->input.pctype == I40E_FILTER_PCTYPE_FRAG_IPV4 ||
+	    filter->input.pctype == I40E_FILTER_PCTYPE_FRAG_IPV6) {
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
+	struct i40e_fdir_filter_conf *filter = &fdir_ctx->fdir_filter;
+	const struct rte_flow_item_tcp *tcp_spec = item->spec;
+	const struct rte_flow_item_tcp *tcp_mask = item->mask;
+	rte_be16_t src_spec, dst_spec, src_mask, dst_mask;
+	bool is_ipv4;
+
+	/* Set layer index for L4 flexible payload */
+	filter->input.flow_ext.layer_idx = I40E_FLXPLD_L4_IDX;
+
+	/* set packet type depending on L3 type */
+	if (filter->input.flow_ext.oip_type == I40E_FDIR_IPTYPE_IPV4) {
+		filter->input.pctype = I40E_FILTER_PCTYPE_NONF_IPV4_TCP;
+	} else if (filter->input.flow_ext.oip_type == I40E_FDIR_IPTYPE_IPV6) {
+		filter->input.pctype = I40E_FILTER_PCTYPE_NONF_IPV6_TCP;
+	}
+
+	if (tcp_spec == NULL && tcp_mask == NULL)
+		return 0;
+
+	src_spec = tcp_spec->hdr.src_port;
+	dst_spec = tcp_spec->hdr.dst_port;
+	src_mask = tcp_mask->hdr.src_port;
+	dst_mask = tcp_mask->hdr.dst_port;
+	is_ipv4 = filter->input.flow_ext.oip_type == I40E_FDIR_IPTYPE_IPV4;
+
+	if (is_ipv4) {
+		if (src_mask != 0) {
+			filter->input.flow_ext.input_set |= I40E_INSET_SRC_PORT;
+			filter->input.flow.tcp4_flow.src_port = src_spec;
+		}
+		if (dst_mask) {
+			filter->input.flow_ext.input_set |= I40E_INSET_DST_PORT;
+			filter->input.flow.tcp4_flow.dst_port = dst_spec;
+		}
+	} else {
+		if (src_mask != 0) {
+			filter->input.flow_ext.input_set |= I40E_INSET_SRC_PORT;
+			filter->input.flow.tcp6_flow.src_port = src_spec;
+		}
+		if (dst_mask) {
+			filter->input.flow_ext.input_set |= I40E_INSET_DST_PORT;
+			filter->input.flow.tcp6_flow.dst_port = dst_spec;
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
+	const struct i40e_fdir_filter_conf *filter = &fdir_ctx->fdir_filter;
+	const struct rte_flow_item_udp *udp_spec = item->spec;
+	const struct rte_flow_item_udp *udp_mask = item->mask;
+
+	/* cannot match both fragmented and TCP */
+	if (filter->input.pctype == I40E_FILTER_PCTYPE_FRAG_IPV4 ||
+	    filter->input.pctype == I40E_FILTER_PCTYPE_FRAG_IPV6) {
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
+	struct i40e_fdir_filter_conf *filter = &fdir_ctx->fdir_filter;
+	const struct rte_flow_item_udp *udp_spec = item->spec;
+	const struct rte_flow_item_udp *udp_mask = item->mask;
+	rte_be16_t src_spec, dst_spec, src_mask, dst_mask;
+	bool is_ipv4;
+
+	/* Set layer index for L4 flexible payload */
+	filter->input.flow_ext.layer_idx = I40E_FLXPLD_L4_IDX;
+
+	/* set packet type depending on L3 type */
+	if (filter->input.flow_ext.oip_type == I40E_FDIR_IPTYPE_IPV4) {
+		filter->input.pctype = I40E_FILTER_PCTYPE_NONF_IPV4_UDP;
+	} else if (filter->input.flow_ext.oip_type == I40E_FDIR_IPTYPE_IPV6) {
+		filter->input.pctype = I40E_FILTER_PCTYPE_NONF_IPV6_UDP;
+	}
+
+	/* set UDP */
+	filter->input.flow_ext.is_udp = true;
+
+	if (udp_spec == NULL && udp_mask == NULL)
+		return 0;
+
+	src_spec = udp_spec->hdr.src_port;
+	dst_spec = udp_spec->hdr.dst_port;
+	src_mask = udp_mask->hdr.src_port;
+	dst_mask = udp_mask->hdr.dst_port;
+	is_ipv4 = filter->input.flow_ext.oip_type == I40E_FDIR_IPTYPE_IPV4;
+
+	if (is_ipv4) {
+		if (src_mask) {
+			filter->input.flow_ext.input_set |= I40E_INSET_SRC_PORT;
+			filter->input.flow.udp4_flow.src_port = src_spec;
+		}
+		if (dst_mask) {
+			filter->input.flow_ext.input_set |= I40E_INSET_DST_PORT;
+			filter->input.flow.udp4_flow.dst_port = dst_spec;
+		}
+	} else {
+		if (src_mask) {
+			filter->input.flow_ext.input_set |= I40E_INSET_SRC_PORT;
+			filter->input.flow.udp6_flow.src_port = src_spec;
+		}
+		if (dst_mask) {
+			filter->input.flow_ext.input_set |= I40E_INSET_DST_PORT;
+			filter->input.flow.udp6_flow.dst_port = dst_spec;
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
+	const struct i40e_fdir_filter_conf *filter = &fdir_ctx->fdir_filter;
+	const struct rte_flow_item_sctp *sctp_spec = item->spec;
+	const struct rte_flow_item_sctp *sctp_mask = item->mask;
+
+	/* cannot match both fragmented and TCP */
+	if (filter->input.pctype == I40E_FILTER_PCTYPE_FRAG_IPV4 ||
+	    filter->input.pctype == I40E_FILTER_PCTYPE_FRAG_IPV6) {
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
+	struct i40e_fdir_filter_conf *filter = &fdir_ctx->fdir_filter;
+	const struct rte_flow_item_sctp *sctp_spec = item->spec;
+	const struct rte_flow_item_sctp *sctp_mask = item->mask;
+	rte_be16_t src_spec, dst_spec, src_mask, dst_mask, tag_spec, tag_mask;
+	bool is_ipv4;
+
+	/* Set layer index for L4 flexible payload */
+	filter->input.flow_ext.layer_idx = I40E_FLXPLD_L4_IDX;
+
+	/* set packet type depending on L3 type */
+	if (filter->input.flow_ext.oip_type == I40E_FDIR_IPTYPE_IPV4) {
+		filter->input.pctype = I40E_FILTER_PCTYPE_NONF_IPV4_SCTP;
+	} else if (filter->input.flow_ext.oip_type == I40E_FDIR_IPTYPE_IPV6) {
+		filter->input.pctype = I40E_FILTER_PCTYPE_NONF_IPV6_SCTP;
+	}
+
+	if (sctp_spec == NULL && sctp_mask == NULL)
+		return 0;
+
+	if (!CI_FIELD_IS_ZERO(&sctp_mask->hdr.tag)) {
+		filter->input.flow_ext.input_set |= I40E_INSET_SCTP_VT;
+	}
+
+	src_spec = sctp_spec->hdr.src_port;
+	dst_spec = sctp_spec->hdr.dst_port;
+	src_mask = sctp_mask->hdr.src_port;
+	dst_mask = sctp_mask->hdr.dst_port;
+	tag_spec = sctp_spec->hdr.tag;
+	tag_mask = sctp_mask->hdr.tag;
+	is_ipv4 = filter->input.flow_ext.oip_type == I40E_FDIR_IPTYPE_IPV4;
+
+	if (is_ipv4) {
+		if (src_mask) {
+			filter->input.flow_ext.input_set |= I40E_INSET_SRC_PORT;
+			filter->input.flow.sctp4_flow.src_port = src_spec;
+		}
+		if (dst_mask) {
+			filter->input.flow_ext.input_set |= I40E_INSET_DST_PORT;
+			filter->input.flow.sctp4_flow.dst_port = dst_spec;
+		}
+		if (tag_mask) {
+			filter->input.flow_ext.input_set |= I40E_INSET_SCTP_VT;
+			filter->input.flow.sctp4_flow.verify_tag = tag_spec;
+		}
+	} else {
+		if (src_mask) {
+			filter->input.flow_ext.input_set |= I40E_INSET_SRC_PORT;
+			filter->input.flow.sctp6_flow.src_port = src_spec;
+		}
+		if (dst_mask) {
+			filter->input.flow_ext.input_set |= I40E_INSET_DST_PORT;
+			filter->input.flow.sctp6_flow.dst_port = dst_spec;
+		}
+		if (tag_mask) {
+			filter->input.flow_ext.input_set |= I40E_INSET_SCTP_VT;
+			filter->input.flow.sctp6_flow.verify_tag = tag_spec;
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
+	const struct i40e_fdir_filter_conf *filter = &fdir_ctx->fdir_filter;
+	const struct rte_eth_dev *dev = fdir_ctx->base.dev;
+	const struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	const struct rte_flow_item_raw *raw_spec = item->spec;
+	const struct rte_flow_item_raw *raw_mask = item->mask;
+	enum i40e_flxpld_layer_idx raw_id = filter->input.flow_ext.raw_id;
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
+	/* Check spec/mask lengths */
+	if (raw_spec->length != raw_mask->length) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid RAW length");
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
+	/* Offset must be non-negative */
+	if (raw_spec->offset < 0) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"RAW offset must be non-negative");
+	}
+
+	/*
+	 * RAW node can be triggered multiple times, each time we will be copying more data to the
+	 * flexbyte buffer. we need to validate total size/offset against max allowed because we
+	 * cannot overflow our flexbyte buffer.
+	 *
+	 * all data in the flex pit is stored in units of 2 bytes (words), but all the limits are in
+	 * bytes, so we need to convert sizes/offsets accordingly.
+	 */
+
+	/* flex size/offset for current item (in bytes) */
+	spec_size = raw_spec->length;
+	spec_offset = raw_spec->offset;
+
+	/* accumulate all raw items size/offset */
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
+	if (spec_size + new_src_offset > I40E_MAX_FLX_SOURCE_OFF) {
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
+	struct i40e_fdir_filter_conf *filter = &fdir_ctx->fdir_filter;
+	const struct rte_flow_item_raw *raw_spec = item->spec;
+	const struct rte_flow_item_raw *raw_mask = item->mask;
+	enum i40e_flxpld_layer_idx raw_id = filter->input.flow_ext.raw_id;
+	enum i40e_flxpld_layer_idx layer_idx = filter->input.flow_ext.layer_idx;
+	size_t flex_pit_field_idx = layer_idx * I40E_MAX_FLXPLD_FIED + raw_id;
+	struct i40e_fdir_flex_pit *flex_pit;
+	size_t spec_size, spec_offset, i;
+	size_t total_size, new_src_offset;
+
+	/* flex size for current item */
+	spec_size = raw_spec->length;
+	spec_offset = raw_spec->offset;
+
+	/* store these for future reference */
+	fdir_ctx->flex_data[raw_id].size = spec_size;
+	fdir_ctx->flex_data[raw_id].offset = spec_offset;
+
+	/* accumulate all raw items size/offset */
+	total_size = 0;
+	new_src_offset = 0;
+	for (i = 0; i < raw_id; i++) {
+		const struct flex_item *fi = &fdir_ctx->flex_data[i];
+		total_size += fi->size;
+		/* offset is relative to end of previous item */
+		new_src_offset += fi->offset + fi->size;
+	}
+
+	/* copy bytes into the flex pit buffer */
+	for (i = 0; i < spec_size; i++) {
+		/* convert to byte offset */
+		const size_t start = total_size * sizeof(uint16_t);
+		size_t j = start + i;
+		filter->input.flow_ext.flexbytes[j] = raw_spec->pattern[i];
+		filter->input.flow_ext.flex_mask[j] = raw_mask->pattern[i];
+	}
+
+	/* populate flex pit */
+	flex_pit = &filter->input.flow_ext.flex_pit[flex_pit_field_idx];
+	/* convert to words (2-byte units) */
+	flex_pit->src_offset = (uint16_t)new_src_offset / sizeof(uint16_t);
+	flex_pit->dst_offset = (uint16_t)total_size / sizeof(uint16_t);
+	flex_pit->size = (uint16_t)spec_size / sizeof(uint16_t);
+
+	/* increment raw item index */
+	filter->input.flow_ext.raw_id++;
+
+	/* mark as flex flow */
+	filter->input.flow_ext.is_flex_flow = true;
+
+	return 0;
+}
+
+static int
+i40e_fdir_node_esp_validate(const void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct i40e_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_eth_dev *dev = fdir_ctx->base.dev;
+	const struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
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
+	struct i40e_fdir_filter_conf *filter = &fdir_ctx->fdir_filter;
+	const struct rte_flow_item_esp *esp_spec = item->spec;
+	bool is_ipv4 = filter->input.flow_ext.oip_type == I40E_FDIR_IPTYPE_IPV4;
+	bool is_udp = filter->input.flow_ext.is_udp;
+
+	/* ESP uses customized pctype */
+	filter->input.flow_ext.customized_pctype = true;
+	fdir_ctx->custom_pctype = item->type;
+
+	if (is_ipv4) {
+		if (is_udp)
+			filter->input.flow.esp_ipv4_udp_flow.spi = esp_spec->hdr.spi;
+		else {
+			filter->input.flow.esp_ipv4_flow.spi = esp_spec->hdr.spi;
+		}
+	} else {
+		if (is_udp)
+			filter->input.flow.esp_ipv6_udp_flow.spi = esp_spec->hdr.spi;
+		else {
+			filter->input.flow.esp_ipv6_flow.spi = esp_spec->hdr.spi;
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
+	struct i40e_fdir_filter_conf *filter = &fdir_ctx->fdir_filter;
+	const struct rte_flow_item_l2tpv3oip *l2tp_spec = item->spec;
+
+	/* L2TPv3 uses customized pctype */
+	filter->input.flow_ext.customized_pctype = true;
+	fdir_ctx->custom_pctype = item->type;
+
+	/* Store session_id in appropriate flow union member based on IP version */
+	if (filter->input.flow_ext.oip_type == I40E_FDIR_IPTYPE_IPV4) {
+		filter->input.flow.ip4_l2tpv3oip_flow.session_id = l2tp_spec->session_id;
+	} else if (filter->input.flow_ext.oip_type == I40E_FDIR_IPTYPE_IPV6) {
+		filter->input.flow.ip6_l2tpv3oip_flow.session_id = l2tp_spec->session_id;
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
+	const struct rte_eth_dev *dev = fdir_ctx->base.dev;
+	const struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
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
+	struct i40e_fdir_filter_conf *filter = &fdir_ctx->fdir_filter;
+	const struct rte_flow_item_gtp *gtp_spec = item->spec;
+
+	/* Mark as GTP tunnel with customized pctype */
+	filter->input.flow_ext.customized_pctype = true;
+	fdir_ctx->custom_pctype = item->type;
+
+	filter->input.flow.gtp_flow.teid = gtp_spec->teid;
+
+	return 0;
+}
+
+static int
+i40e_fdir_node_inner_ipv4_process(void *ctx, const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_fdir_ctx *fdir_ctx = ctx;
+	struct i40e_fdir_filter_conf *filter = &fdir_ctx->fdir_filter;
+
+	/* Mark as inner IP */
+	filter->input.flow_ext.inner_ip = true;
+	filter->input.flow_ext.iip_type = I40E_FDIR_IPTYPE_IPV4;
+
+	return 0;
+}
+
+static int
+i40e_fdir_node_inner_ipv6_process(void *ctx, const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_fdir_ctx *fdir_ctx = ctx;
+	struct i40e_fdir_filter_conf *filter = &fdir_ctx->fdir_filter;
+
+	/* Mark as inner IP */
+	filter->input.flow_ext.inner_ip = true;
+	filter->input.flow_ext.iip_type = I40E_FDIR_IPTYPE_IPV6;
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
+	const struct i40e_fdir_filter_conf *filter = &fdir_ctx->fdir_filter;
+	uint64_t input_set = filter->input.flow_ext.input_set;
+	enum i40e_filter_pctype pctype = filter->input.pctype;
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
+	      filter->input.flow_ext.is_flex_flow)) {
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
+	if (!filter->input.flow_ext.customized_pctype) {
+		/* validate the input set for the built-in pctype */
+		if (i40e_validate_input_set(pctype, RTE_ETH_FILTER_FDIR, input_set) != 0) {
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM, item,
+					"Invalid input set");
+			return -rte_errno;
+		}
+	}
+
+	return 0;
+}
+
+static int
+i40e_fdir_node_end_process(void *ctx __rte_unused, const struct rte_flow_item *item __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct i40e_fdir_ctx *fdir_ctx = ctx;
+	struct i40e_fdir_filter_conf *filter = &fdir_ctx->fdir_filter;
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(fdir_ctx->base.dev->data->dev_private);
+
+	/* Get customized pctype value */
+	if (filter->input.flow_ext.customized_pctype) {
+		enum i40e_filter_pctype pctype = i40e_flow_fdir_get_pctype_value(pf,
+				fdir_ctx->custom_pctype, filter);
+		if (pctype == I40E_FILTER_PCTYPE_INVALID) {
+			rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM, item,
+					"Unsupported packet type");
+			return -rte_errno;
+		}
+		/* update FDIR packet type */
+		filter->input.pctype = pctype;
+	}
+
+	return 0;
+}
+
+const struct rte_flow_graph i40e_fdir_graph = {
+	.nodes = (struct rte_flow_graph_node[]) {
+		[I40E_FDIR_NODE_START] = { .name = "START" },
+		[I40E_FDIR_NODE_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY |
+				       RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_fdir_node_eth_validate,
+			.process = i40e_fdir_node_eth_process,
+		},
+		[I40E_FDIR_NODE_VLAN] = {
+			.name = "VLAN",
+			.type = RTE_FLOW_ITEM_TYPE_VLAN,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY |
+				       RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_fdir_node_vlan_validate,
+			.process = i40e_fdir_node_vlan_process,
+		},
+		[I40E_FDIR_NODE_IPV4] = {
+			.name = "IPv4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY |
+				       RTE_FLOW_NODE_EXPECT_SPEC_MASK |
+				       RTE_FLOW_NODE_EXPECT_RANGE,
+			.validate = i40e_fdir_node_ipv4_validate,
+			.process = i40e_fdir_node_ipv4_process,
+		},
+		[I40E_FDIR_NODE_IPV6] = {
+			.name = "IPv6",
+			.type = RTE_FLOW_ITEM_TYPE_IPV6,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY |
+				       RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_fdir_node_ipv6_validate,
+			.process = i40e_fdir_node_ipv6_process,
+		},
+		[I40E_FDIR_NODE_TCP] = {
+			.name = "TCP",
+			.type = RTE_FLOW_ITEM_TYPE_TCP,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY |
+				       RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_fdir_node_tcp_validate,
+			.process = i40e_fdir_node_tcp_process,
+		},
+		[I40E_FDIR_NODE_UDP] = {
+			.name = "UDP",
+			.type = RTE_FLOW_ITEM_TYPE_UDP,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY |
+				       RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_fdir_node_udp_validate,
+			.process = i40e_fdir_node_udp_process,
+		},
+		[I40E_FDIR_NODE_SCTP] = {
+			.name = "SCTP",
+			.type = RTE_FLOW_ITEM_TYPE_SCTP,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY |
+				       RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_fdir_node_sctp_validate,
+			.process = i40e_fdir_node_sctp_process,
+		},
+		[I40E_FDIR_NODE_ESP] = {
+			.name = "ESP",
+			.type = RTE_FLOW_ITEM_TYPE_ESP,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_fdir_node_esp_validate,
+			.process = i40e_fdir_node_esp_process,
+		},
+		[I40E_FDIR_NODE_L2TPV3OIP] = {
+			.name = "L2TPV3OIP",
+			.type = RTE_FLOW_ITEM_TYPE_L2TPV3OIP,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_fdir_node_l2tpv3oip_validate,
+			.process = i40e_fdir_node_l2tpv3oip_process,
+		},
+		[I40E_FDIR_NODE_GTPC] = {
+			.name = "GTPC",
+			.type = RTE_FLOW_ITEM_TYPE_GTPC,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_fdir_node_gtp_validate,
+			.process = i40e_fdir_node_gtp_process,
+		},
+		[I40E_FDIR_NODE_GTPU] = {
+			.name = "GTPU",
+			.type = RTE_FLOW_ITEM_TYPE_GTPU,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = i40e_fdir_node_gtp_validate,
+			.process = i40e_fdir_node_gtp_process,
+		},
+		[I40E_FDIR_NODE_INNER_IPV4] = {
+			.name = "INNER_IPv4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+			.validate = i40e_fdir_node_ipv4_validate,
+			.process = i40e_fdir_node_inner_ipv4_process,
+		},
+		[I40E_FDIR_NODE_INNER_IPV6] = {
+			.name = "INNER_IPv6",
+			.type = RTE_FLOW_ITEM_TYPE_IPV6,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+			.validate = i40e_fdir_node_ipv6_validate,
+			.process = i40e_fdir_node_inner_ipv6_process,
+		},
+		[I40E_FDIR_NODE_RAW] = {
+			.name = "RAW",
+			.type = RTE_FLOW_ITEM_TYPE_RAW,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
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
+	.edges = (struct rte_flow_graph_edge[]) {
+		[I40E_FDIR_NODE_START] = {
+			.next = (const size_t[]) {
+				I40E_FDIR_NODE_ETH,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_ETH] = {
+			.next = (const size_t[]) {
+				I40E_FDIR_NODE_VLAN,
+				I40E_FDIR_NODE_IPV4,
+				I40E_FDIR_NODE_IPV6,
+				I40E_FDIR_NODE_RAW,
+				I40E_FDIR_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_VLAN] = {
+			.next = (const size_t[]) {
+				I40E_FDIR_NODE_IPV4,
+				I40E_FDIR_NODE_IPV6,
+				I40E_FDIR_NODE_RAW,
+				I40E_FDIR_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_IPV4] = {
+			.next = (const size_t[]) {
+				I40E_FDIR_NODE_TCP,
+				I40E_FDIR_NODE_UDP,
+				I40E_FDIR_NODE_SCTP,
+				I40E_FDIR_NODE_ESP,
+				I40E_FDIR_NODE_L2TPV3OIP,
+				I40E_FDIR_NODE_RAW,
+				I40E_FDIR_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_IPV6] = {
+			.next = (const size_t[]) {
+				I40E_FDIR_NODE_TCP,
+				I40E_FDIR_NODE_UDP,
+				I40E_FDIR_NODE_SCTP,
+				I40E_FDIR_NODE_ESP,
+				I40E_FDIR_NODE_L2TPV3OIP,
+				I40E_FDIR_NODE_RAW,
+				I40E_FDIR_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_TCP] = {
+			.next = (const size_t[]) {
+				I40E_FDIR_NODE_RAW,
+				I40E_FDIR_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_UDP] = {
+			.next = (const size_t[]) {
+				I40E_FDIR_NODE_GTPC,
+				I40E_FDIR_NODE_GTPU,
+				I40E_FDIR_NODE_ESP,
+				I40E_FDIR_NODE_RAW,
+				I40E_FDIR_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_SCTP] = {
+			.next = (const size_t[]) {
+				I40E_FDIR_NODE_RAW,
+				I40E_FDIR_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_ESP] = {
+			.next = (const size_t[]) {
+				I40E_FDIR_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_L2TPV3OIP] = {
+			.next = (const size_t[]) {
+				I40E_FDIR_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_GTPC] = {
+			.next = (const size_t[]) {
+				I40E_FDIR_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_GTPU] = {
+			.next = (const size_t[]) {
+				I40E_FDIR_NODE_INNER_IPV4,
+				I40E_FDIR_NODE_INNER_IPV6,
+				I40E_FDIR_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_INNER_IPV4] = {
+			.next = (const size_t[]) {
+				I40E_FDIR_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_INNER_IPV6] = {
+			.next = (const size_t[]) {
+				I40E_FDIR_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[I40E_FDIR_NODE_RAW] = {
+			.next = (const size_t[]) {
+				I40E_FDIR_NODE_RAW,
+				I40E_FDIR_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
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
+i40e_fdir_ctx_parse(const struct rte_flow_action *actions,
+		const struct rte_flow_attr *attr,
+		struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	struct i40e_adapter *adapter = ctx->dev->data->dev_private;
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
+i40e_fdir_flow_install(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct i40e_flow_engine_fdir_flow *fdir_flow = (struct i40e_flow_engine_fdir_flow *)flow;
+	struct rte_eth_dev *dev = flow->dev;
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	bool need_teardown = false;
+	bool need_rx_proc_disable = false;
+	int ret;
+
+	/* if fdir is not configured, configure it */
+	if (pf->fdir.fdir_vsi == NULL) {
+		ret = i40e_fdir_setup(pf);
+		if (ret != I40E_SUCCESS) {
+			ret = rte_flow_error_set(error, ENOTSUP,
+					RTE_FLOW_ERROR_TYPE_HANDLE,
+					NULL, "Failed to setup fdir.");
+			goto err;
+		}
+		/* if something failed down the line, teardown is needed */
+		need_teardown = true;
+		ret = i40e_fdir_configure(dev);
+		if (ret < 0) {
+			ret = rte_flow_error_set(error, ENOTSUP,
+					RTE_FLOW_ERROR_TYPE_HANDLE,
+					NULL, "Failed to configure fdir.");
+			goto err;
+		}
+	}
+
+	/* if this is first flow, enable fdir check for rx queues */
+	if (pf->fdir.num_fdir_flows == 0) {
+		i40e_fdir_rx_proc_enable(dev, 1);
+		/* if something failed down the line, we need to disable fdir check for rx queues */
+		need_rx_proc_disable = true;
+	}
+
+	ret = i40e_flow_add_del_fdir_filter(dev, &fdir_flow->fdir_filter, 1);
+	if (ret != 0) {
+		ret = rte_flow_error_set(error, ENOTSUP,
+				RTE_FLOW_ERROR_TYPE_HANDLE,
+				NULL, "Failed to add fdir filter.");
+		goto err;
+	}
+
+	/* we got flows now */
+	pf->fdir.num_fdir_flows++;
+
+	return 0;
+err:
+	if (need_rx_proc_disable)
+		i40e_fdir_rx_proc_enable(dev, 0);
+	if (need_teardown)
+		i40e_fdir_teardown(pf);
+	return ret;
+}
+
+static int
+i40e_fdir_flow_uninstall(struct ci_flow *flow, struct rte_flow_error *error __rte_unused)
+{
+	struct rte_eth_dev *dev = flow->dev;
+	struct i40e_flow_engine_fdir_flow *fdir_flow = (struct i40e_flow_engine_fdir_flow *)flow;
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	int ret;
+
+	ret = i40e_flow_add_del_fdir_filter(dev, &fdir_flow->fdir_filter, 0);
+	if (ret != 0) {
+		return rte_flow_error_set(error, ENOTSUP,
+				RTE_FLOW_ERROR_TYPE_HANDLE,
+				NULL, "Failed to delete fdir filter.");
+	}
+
+	/* we are removing a flow */
+	if (pf->fdir.num_fdir_flows > 0)
+		pf->fdir.num_fdir_flows--;
+
+	/* if there are no more flows, disable fdir check for rx queues and teardown fdir */
+	if (pf->fdir.num_fdir_flows == 0) {
+		i40e_fdir_rx_proc_enable(dev, 0);
+		i40e_fdir_teardown(pf);
+	}
+
+	return 0;
+}
+
+static int
+i40e_fdir_flow_engine_init(const struct ci_flow_engine *engine,
+		struct rte_eth_dev *dev,
+		void *priv_data)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct i40e_fdir_info *fdir_info = &pf->fdir;
+	struct i40e_fdir_engine_priv *priv = priv_data;
+	struct i40e_fdir_flow_pool_entry *pool;
+	struct rte_bitmap *bmp;
+	uint32_t bmp_size;
+	void *bmp_mem;
+	uint32_t i;
+
+	pool = rte_zmalloc(engine->name,
+			fdir_info->fdir_space_size * sizeof(*pool), 0);
+	if (pool == NULL)
+		return -ENOMEM;
+
+	bmp_size = rte_bitmap_get_memory_footprint(fdir_info->fdir_space_size);
+	bmp_mem = rte_zmalloc("fdir_bmap", bmp_size, RTE_CACHE_LINE_SIZE);
+	if (bmp_mem == NULL) {
+		rte_free(pool);
+		return -ENOMEM;
+	}
+
+	bmp = rte_bitmap_init(fdir_info->fdir_space_size, bmp_mem, bmp_size);
+	if (bmp == NULL) {
+		if (bmp_mem != NULL)
+			rte_free(bmp_mem);
+		if (pool != NULL)
+			rte_free(pool);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < fdir_info->fdir_space_size; i++) {
+		pool[i].idx = i;
+		rte_bitmap_set(bmp, i);
+	}
+
+	priv->pool = pool;
+	priv->bmp = bmp;
+
+	return 0;
+}
+
+static void
+i40e_fdir_flow_engine_uninit(const struct ci_flow_engine *engine __rte_unused,
+		void *priv_data)
+{
+	struct i40e_fdir_engine_priv *priv = priv_data;
+
+	if (priv->bmp != NULL)
+		rte_free(priv->bmp);
+	if (priv->pool != NULL)
+		rte_free(priv->pool);
+}
+
+static struct ci_flow *
+i40e_fdir_flow_alloc(const struct ci_flow_engine *engine,
+		struct rte_eth_dev *dev)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct i40e_fdir_info *fdir_info = &pf->fdir;
+	struct i40e_fdir_engine_priv *priv = ci_flow_engine_priv(&pf->flow_engine_conf, engine->type);
+	uint64_t slab = 0;
+	uint32_t pos = 0;
+	uint32_t bit;
+	int ret;
+
+	if (priv == NULL || priv->pool == NULL || priv->bmp == NULL)
+		return NULL;
+
+	if (fdir_info->fdir_actual_cnt >= fdir_info->fdir_space_size)
+		return NULL;
+
+	ret = rte_bitmap_scan(priv->bmp, &pos, &slab);
+	if (ret == 0)
+		return NULL;
+
+	bit = rte_bsf64(slab);
+	pos += bit;
+	rte_bitmap_clear(priv->bmp, pos);
+
+	memset(&priv->pool[pos].flow, 0, sizeof(priv->pool[pos].flow));
+	return (struct ci_flow *)&priv->pool[pos].flow;
+}
+
+static void
+i40e_fdir_flow_free(struct ci_flow *flow)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(flow->dev->data->dev_private);
+	struct i40e_fdir_engine_priv *priv = ci_flow_engine_priv(&pf->flow_engine_conf, flow->engine_type);
+	struct i40e_fdir_flow_pool_entry *entry;
+
+	entry = I40E_FDIR_FLOW_ENTRY((struct i40e_flow_engine_fdir_flow *)flow);
+	rte_bitmap_set(priv->bmp, entry->idx);
+}
+
+const struct ci_flow_engine_ops i40e_flow_engine_fdir_ops = {
+	.init = i40e_fdir_flow_engine_init,
+	.uninit = i40e_fdir_flow_engine_uninit,
+	.flow_alloc = i40e_fdir_flow_alloc,
+	.flow_free = i40e_fdir_flow_free,
+	.ctx_parse = i40e_fdir_ctx_parse,
+	.flow_install = i40e_fdir_flow_install,
+	.flow_uninstall = i40e_fdir_flow_uninstall,
+};
+
+const struct ci_flow_engine i40e_flow_engine_fdir = {
+	.name = "i40e_fdir",
+	.type = I40E_FLOW_ENGINE_TYPE_FDIR,
+	.ops = &i40e_flow_engine_fdir_ops,
+	.ctx_size = sizeof(struct i40e_fdir_ctx),
+	.flow_size = sizeof(struct i40e_flow_engine_fdir_flow),
+	.priv_size = sizeof(struct i40e_fdir_engine_priv),
+	.graph = &i40e_fdir_graph,
+};
diff --git a/drivers/net/intel/i40e/meson.build b/drivers/net/intel/i40e/meson.build
index bff0518fc9..0638f873dd 100644
--- a/drivers/net/intel/i40e/meson.build
+++ b/drivers/net/intel/i40e/meson.build
@@ -26,6 +26,7 @@ sources += files(
         'i40e_fdir.c',
         'i40e_flow.c',
         'i40e_flow_ethertype.c',
+        'i40e_flow_fdir.c',
         'i40e_tm.c',
         'i40e_hash.c',
         'i40e_vf_representor.c',
-- 
2.47.3

