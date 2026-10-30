Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1178B606A32F
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZrDv9GFg
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77F2D40A77;
	Fri, 30 Oct 2026 10:40:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTPS id D81C840A77
 for <dev@dpdk.org>; Fri, 30 Oct 2026 10:40:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793353253; x=1824889253;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=7G8OoLGXfuJKcOpzuixEOhvJxFnvtP08/QQI2jr1OPo=;
 b=ZrDv9GFgPW0ua3bUeARfSwJNPoagJaXS1JN9uWjDA48VvMlrOgWthpts
 BK8DzufWtQ1opVkIrc3xNy2ysf+qZ02xwBl8eKg0xqLoU8l69TSQBrzPp
 d3X2PbvkQ44sX3m6JApmgqAx+uq9T5yyFl4V6VH3aoKbZI3IyMepDwKyM
 u5Jy4GW7g2Mx5EO28ZbZgjSRF6+8gY2twbpPD4hngGkY17cG0EISdnD3e
 dbS59sU8tZqgH3x4TeYZUfo65LEZj+hxXRl0MzNZKd7IZe30gYLPRfmSz
 7Lx2saZ1m6vyjvOtpxPaUyORDaEQr1DCfabxjG0MeR94eLBemkvi2Z+Gb w==;
X-CSE-ConnectionGUID: KSNa9dYbQvqlin4JPWAf3Q==
X-CSE-MsgGUID: Vr6Gzy5/TdSzCpbbqt0PiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2126039"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2126039"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 02:40:52 -0700
X-CSE-ConnectionGUID: gjeuwot/R5ymn0SSi9ogew==
X-CSE-MsgGUID: MimghOZAQD+/QpGMzsSyCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5299611"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 30 Oct 2026 02:40:52 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 3/9] net/i40e: move FDIR flow state out of the flow engine
Date: Fri, 30 Oct 2026 09:40:16 +0000
Message-ID: <249992c854b4c41c263c6bf0039bd0f06baf21ff.1793353214.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <5e64cc416c8ab3b038eee6bb55836e0b8ed507ab.1793353214.git.anatoly.burakov@intel.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The FDIR flow pool, its free bitmap, and the duplicate filter hash table
are currently owned by the FDIR flow engine. We will be adding another
FDIR-based engine, so this shared state needs to move into the driver.

The pool and bitmap could be moved as is, but they are built around the
FDIR engine's flow structure, which is private to the engine, so the
driver would become tightly coupled to the engine's flow definitions.
The custom allocation scheme gives us nothing over a regular mempool
other than slightly lower memory usage. Rather than introduce that
coupling, replace the pool and bitmap with a mempool sized from the
FDIR engine flow size.

Allocate the hash table and the mempool at device init, and free them
at device close.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c    |   6 +-
 drivers/net/intel/i40e/i40e_ethdev.h    |  12 +-
 drivers/net/intel/i40e/i40e_fdir.c      |  59 +++++++++-
 drivers/net/intel/i40e/i40e_flow_fdir.c | 147 +++---------------------
 4 files changed, 91 insertions(+), 133 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index cc000ec2a8b..4e66959c6a2 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -1660,7 +1660,9 @@ eth_i40e_dev_init(struct rte_eth_dev *dev, void *init_params __rte_unused)
 	/* Initialize the filter invalidation configuration */
 	i40e_init_filter_invalidation(pf);
 
-	i40e_fdir_flow_store_init(dev);
+	ret = i40e_fdir_flow_store_init(dev);
+	if (ret < 0)
+		goto err_fdir_flow_store_init;
 	/* after device init, tunnel configuration is in its default state */
 	pf->tunnel_state = (struct i40e_tunnel_state){0};
 
@@ -1679,6 +1681,8 @@ eth_i40e_dev_init(struct rte_eth_dev *dev, void *init_params __rte_unused)
 	return 0;
 
 err_flow_engine_conf_init:
+	i40e_fdir_flow_store_free(&pf->fdir);
+err_fdir_flow_store_init:
 	rte_intr_callback_unregister(intr_handle,
 		i40e_dev_interrupt_handler, dev);
 	rte_free(dev->data->mac_addrs);
diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 77f79fc7da7..e5e136f5540 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -780,6 +780,14 @@ struct i40e_fdir_tmpl_store {
 	struct i40e_fdir_tmpl_list list;
 };
 
+/* tracking for rte_flow filters; shared by all FDIR flow engines */
+struct i40e_fdir_flow_store {
+	/* preallocated flows, one per FDIR filter */
+	struct rte_mempool *pool;
+	/* used to reject duplicate filters */
+	struct rte_hash *hash_table;
+};
+
 /*
  *  A structure used to define fields of a FDIR related info.
  */
@@ -799,6 +807,7 @@ struct i40e_fdir_info {
 
 	struct i40e_fdir_state fdir_state;
 	struct i40e_fdir_tmpl_store tmpls;
+	struct i40e_fdir_flow_store flow_store;
 
 	/*
 	 * Priority ordering at filter invalidation(destroying a flow) between
@@ -1425,7 +1434,8 @@ bool i40e_fdir_filter_needs_status_wait(const struct i40e_pf *pf,
 					uint32_t filter_count);
 enum i40e_filter_pctype i40e_fdir_filter_pctype(const struct i40e_fdir_filter *filter);
 void i40e_fdir_tmpl_store_free(struct i40e_fdir_info *fdir_info);
-void i40e_fdir_flow_store_init(struct rte_eth_dev *dev);
+int i40e_fdir_flow_store_init(struct rte_eth_dev *dev);
+void i40e_fdir_flow_store_free(struct i40e_fdir_info *fdir_info);
 int i40e_fdir_inset_check(struct i40e_pf *pf,
 		enum i40e_filter_pctype pctype,
 		uint64_t input_set);
diff --git a/drivers/net/intel/i40e/i40e_fdir.c b/drivers/net/intel/i40e/i40e_fdir.c
index 2464eb47c22..c520baf619f 100644
--- a/drivers/net/intel/i40e/i40e_fdir.c
+++ b/drivers/net/intel/i40e/i40e_fdir.c
@@ -15,6 +15,7 @@
 #include <rte_log.h>
 #include <rte_memzone.h>
 #include <rte_malloc.h>
+#include <rte_mempool.h>
 #include <rte_arp.h>
 #include <rte_ip.h>
 #include <rte_udp.h>
@@ -28,6 +29,7 @@
 #include "base/i40e_type.h"
 #include "base/i40e_prototype.h"
 #include "i40e_ethdev.h"
+#include "i40e_flow.h"
 #include "i40e_rxtx.h"
 
 #define I40E_FDIR_MZ_NAME          "FDIR_MEMZONE"
@@ -960,14 +962,26 @@ i40e_fdir_programming_status_cleanup(struct ci_rx_queue *rxq)
 		PMD_DRV_LOG(INFO, "error report captured.");
 }
 
-void
+int
 i40e_fdir_flow_store_init(struct rte_eth_dev *dev)
 {
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
 	struct i40e_fdir_info *fdir_info = &pf->fdir;
+	struct i40e_fdir_flow_store *store = &fdir_info->flow_store;
 	uint32_t alloc = hw->func_caps.fd_filters_guaranteed;
 	uint32_t best = hw->func_caps.fd_filters_best_effort;
+	char fdir_hash_name[RTE_HASH_NAMESIZE];
+	struct rte_hash_parameters fdir_hash_params = {
+		.name = fdir_hash_name,
+		.entries = I40E_MAX_FDIR_FILTER_NUM,
+		.key_len = sizeof(struct i40e_fdir_input),
+		.hash_func = rte_hash_crc,
+		.hash_func_init_val = 0,
+		.socket_id = rte_socket_id(),
+	};
+	char fdir_pool_name[RTE_MEMPOOL_NAMESIZE];
+	int ret;
 
 	fdir_info->fdir_space_size = alloc + best;
 	fdir_info->fdir_rule_count = 0;
@@ -975,6 +989,48 @@ i40e_fdir_flow_store_init(struct rte_eth_dev *dev)
 	fdir_info->fdir_guarantee_total_space = alloc;
 
 	PMD_DRV_LOG(INFO, "FDIR guarantee space: %u, best_effort space %u.", alloc, best);
+
+	if ((pf->flags & I40E_FLAG_FDIR) == 0 || fdir_info->fdir_space_size == 0)
+		return 0;
+
+	snprintf(fdir_hash_name, sizeof(fdir_hash_name), "fdir_%s", dev->data->name);
+	store->hash_table = rte_hash_create(&fdir_hash_params);
+	if (store->hash_table == NULL) {
+		PMD_INIT_LOG(ERR, "Failed to create fdir hash table: %s", rte_strerror(rte_errno));
+		ret = -rte_errno;
+		goto err;
+	}
+
+	snprintf(fdir_pool_name, sizeof(fdir_pool_name), "fdir_%s", dev->data->name);
+	store->pool = rte_mempool_create(fdir_pool_name, fdir_info->fdir_space_size,
+			i40e_flow_engine_fdir.flow_size, 0, 0, NULL, NULL, NULL, NULL,
+			rte_socket_id(),
+			/* pack flows tightly */
+			RTE_MEMPOOL_F_NO_SPREAD | RTE_MEMPOOL_F_NO_CACHE_ALIGN |
+			RTE_MEMPOOL_F_NO_IOVA_CONTIG |
+			/* flows are only accessed under the flow engine lock */
+			RTE_MEMPOOL_F_SP_PUT | RTE_MEMPOOL_F_SC_GET);
+	if (store->pool == NULL) {
+		PMD_INIT_LOG(ERR, "Failed to create fdir flow pool: %s", rte_strerror(rte_errno));
+		ret = -rte_errno;
+		goto err;
+	}
+
+	return 0;
+err:
+	i40e_fdir_flow_store_free(fdir_info);
+	return ret;
+}
+
+void
+i40e_fdir_flow_store_free(struct i40e_fdir_info *fdir_info)
+{
+	struct i40e_fdir_flow_store *store = &fdir_info->flow_store;
+
+	rte_mempool_free(store->pool);
+	rte_hash_free(store->hash_table);
+	store->pool = NULL;
+	store->hash_table = NULL;
 }
 
 static uint32_t
@@ -1726,6 +1782,7 @@ i40e_fdir_cleanup(struct rte_eth_dev *dev)
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 
 	i40e_fdir_tmpl_store_free(&pf->fdir);
+	i40e_fdir_flow_store_free(&pf->fdir);
 
 	if (pf->fdir.hw_configured) {
 		i40e_fdir_teardown(pf);
diff --git a/drivers/net/intel/i40e/i40e_flow_fdir.c b/drivers/net/intel/i40e/i40e_flow_fdir.c
index 276738907ad..45a93defa7a 100644
--- a/drivers/net/intel/i40e/i40e_flow_fdir.c
+++ b/drivers/net/intel/i40e/i40e_flow_fdir.c
@@ -5,9 +5,7 @@
 #include "i40e_ethdev.h"
 #include "i40e_flow.h"
 
-#include <rte_bitmap.h>
-#include <rte_malloc.h>
-#include <rte_hash_crc.h>
+#include <rte_mempool.h>
 
 #include "../common/flow_engine.h"
 #include "../common/flow_check.h"
@@ -29,20 +27,6 @@ struct i40e_flow_engine_fdir_flow {
 	bool installed;
 };
 
-struct i40e_fdir_flow_pool_entry {
-	struct i40e_flow_engine_fdir_flow flow;
-	uint32_t idx;
-};
-
-struct i40e_fdir_engine_priv {
-	struct i40e_fdir_flow_pool_entry *pool;
-	struct rte_bitmap *bitmap;
-	struct rte_hash *hash_table;
-};
-
-#define I40E_FDIR_FLOW_ENTRY(flow_ptr) \
-	container_of((flow_ptr), struct i40e_fdir_flow_pool_entry, flow)
-
 /**
  * FDIR graph implementation (non-tunnel)
  * Pattern: START -> ETH -> (IPv4 | IPv6) -> [TCP | UDP | SCTP | ESP | L2TPv3 | GTP] -> END
@@ -1698,19 +1682,19 @@ i40e_fdir_ctx_to_flow(const struct ci_flow_engine_ctx *ctx,
 
 /* Add a flow director filter into the SW hash table */
 static int
-i40e_fdir_filter_hash_add(struct i40e_fdir_engine_priv *priv,
+i40e_fdir_filter_hash_add(struct i40e_fdir_flow_store *store,
 		const struct i40e_fdir_input *filter_key)
 {
 	int ret;
 
 	/* try to find the filter in the hash table first */
-	ret = rte_hash_lookup(priv->hash_table, filter_key);
+	ret = rte_hash_lookup(store->hash_table, filter_key);
 	if (ret >= 0) {
 		PMD_DRV_LOG(ERR, "Filter already exists!");
 		return -EEXIST;
 	}
 
-	ret = rte_hash_add_key(priv->hash_table, filter_key);
+	ret = rte_hash_add_key(store->hash_table, filter_key);
 	if (ret < 0) {
 		PMD_DRV_LOG(ERR, "Failed to insert fdir filter: %s", rte_strerror(-ret));
 		return ret;
@@ -1721,12 +1705,12 @@ i40e_fdir_filter_hash_add(struct i40e_fdir_engine_priv *priv,
 
 /* Delete a flow director filter from the SW hash table */
 static int
-i40e_fdir_filter_hash_del(struct i40e_fdir_engine_priv *priv,
+i40e_fdir_filter_hash_del(struct i40e_fdir_flow_store *store,
 		const struct i40e_fdir_input *filter_key)
 {
 	int ret;
 
-	ret = rte_hash_del_key(priv->hash_table, filter_key);
+	ret = rte_hash_del_key(store->hash_table, filter_key);
 	if (ret < 0) {
 		PMD_DRV_LOG(ERR,
 			    "Failed to delete fdir filter: %s", rte_strerror(-ret));
@@ -1742,7 +1726,6 @@ i40e_fdir_filter_hash_del(struct i40e_fdir_engine_priv *priv,
 static int
 i40e_fdir_flow_register(struct ci_flow *flow, struct rte_flow_error *error)
 {
-	struct i40e_fdir_engine_priv *priv = flow->engine_priv;
 	struct i40e_flow_engine_fdir_flow *fdir_flow = (struct i40e_flow_engine_fdir_flow *)flow;
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(flow->dev_data->dev_private);
 	const struct i40e_fdir_filter *filter = &fdir_flow->fdir_filter;
@@ -1791,7 +1774,7 @@ i40e_fdir_flow_register(struct ci_flow *flow, struct rte_flow_error *error)
 	}
 
 	/* register the flow with the hash table */
-	ret = i40e_fdir_filter_hash_add(priv, &filter->input);
+	ret = i40e_fdir_filter_hash_add(&pf->fdir.flow_store, &filter->input);
 	if (ret < 0) {
 		return rte_flow_error_set(error, -ret,
 				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
@@ -1833,7 +1816,6 @@ i40e_fdir_flow_register(struct ci_flow *flow, struct rte_flow_error *error)
 static int
 i40e_fdir_flow_unregister(struct ci_flow *flow, struct rte_flow_error *error)
 {
-	struct i40e_fdir_engine_priv *priv = flow->engine_priv;
 	struct i40e_flow_engine_fdir_flow *fdir_flow = (struct i40e_flow_engine_fdir_flow *)flow;
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(flow->dev_data->dev_private);
 	const struct i40e_fdir_filter *filter = &fdir_flow->fdir_filter;
@@ -1844,7 +1826,7 @@ i40e_fdir_flow_unregister(struct ci_flow *flow, struct rte_flow_error *error)
 	struct i40e_fdir_pctype_state *pctype_state = &fdir->pctype[pctype];
 	int ret;
 
-	ret = i40e_fdir_filter_hash_del(priv, &filter->input);
+	ret = i40e_fdir_filter_hash_del(&pf->fdir.flow_store, &filter->input);
 	if (ret < 0) {
 		return rte_flow_error_set(error, -ret,
 				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
@@ -2053,124 +2035,34 @@ i40e_fdir_flow_uninstall(struct ci_flow *flow, struct rte_flow_error *error)
 }
 
 static int
-i40e_fdir_flow_engine_init(const struct ci_flow_engine *engine,
+i40e_fdir_flow_engine_init(const struct ci_flow_engine *engine __rte_unused,
 		struct rte_eth_dev_data *dev_data,
-		void *priv_data)
+		void *priv_data __rte_unused)
 {
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev_data->dev_private);
-	struct i40e_fdir_info *fdir_info = &pf->fdir;
-	struct i40e_fdir_engine_priv *priv = priv_data;
-	char fdir_hash_name[RTE_HASH_NAMESIZE];
-	struct i40e_fdir_flow_pool_entry *pool;
-	struct rte_hash *hash_table;
-	struct rte_bitmap *bmp;
-	uint32_t bmp_size;
-	void *bmp_mem;
-	uint32_t i;
-	int ret;
 
-	if ((pf->flags & I40E_FLAG_FDIR) == 0 || fdir_info->fdir_space_size == 0)
+	if ((pf->flags & I40E_FLAG_FDIR) == 0 || pf->fdir.fdir_space_size == 0)
 		return -ENOTSUP;
 
-	snprintf(fdir_hash_name, sizeof(fdir_hash_name), "fdir_%s", dev_data->name);
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
-	hash_table = rte_hash_create(&fdir_hash_params);
-	if (hash_table == NULL) {
-		PMD_INIT_LOG(ERR, "Failed to create fdir hash table: %s", rte_strerror(rte_errno));
-		ret = -rte_errno;
-		goto err_hash;
-	}
-
-	pool = rte_zmalloc(engine->name,
-			fdir_info->fdir_space_size * sizeof(*pool), 0);
-	if (pool == NULL) {
-		PMD_INIT_LOG(ERR, "Failed to allocate fdir pool");
-		ret = -ENOMEM;
-		goto err_pool;
-	}
-
-	bmp_size = rte_bitmap_get_memory_footprint(fdir_info->fdir_space_size);
-	bmp_mem = rte_zmalloc("fdir_bmap", bmp_size, RTE_CACHE_LINE_SIZE);
-	if (bmp_mem == NULL) {
-		PMD_INIT_LOG(ERR, "Failed to allocate fdir bitmap");
-		ret = -ENOMEM;
-		goto err_bitmap_mem;
-	}
-
-	bmp = rte_bitmap_init(fdir_info->fdir_space_size, bmp_mem, bmp_size);
-	if (bmp == NULL) {
-		PMD_INIT_LOG(ERR, "Failed to initialize fdir bitmap: %s", rte_strerror(rte_errno));
-		ret = -rte_errno;
-		goto err_bitmap;
-	}
-
-	for (i = 0; i < fdir_info->fdir_space_size; i++) {
-		pool[i].idx = i;
-		rte_bitmap_set(bmp, i);
-	}
-
-	priv->pool = pool;
-	priv->bitmap = bmp;
-	priv->hash_table = hash_table;
-
 	return 0;
-err_bitmap:
-	rte_free(bmp_mem);
-err_bitmap_mem:
-	rte_free(pool);
-err_pool:
-	rte_hash_free(hash_table);
-err_hash:
-	return ret;
-}
-
-static void
-i40e_fdir_flow_engine_uninit(const struct ci_flow_engine *engine __rte_unused,
-		void *priv_data)
-{
-	struct i40e_fdir_engine_priv *priv = priv_data;
-
-	rte_free(priv->bitmap);
-	rte_free(priv->pool);
-	rte_hash_free(priv->hash_table);
 }
 
 static struct ci_flow *
 i40e_fdir_flow_alloc(const struct ci_flow_engine *engine __rte_unused,
 		struct rte_eth_dev_data *dev_data,
-		void *priv_data)
+		void *priv_data __rte_unused)
 {
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev_data->dev_private);
 	struct i40e_fdir_info *fdir_info = &pf->fdir;
-	struct i40e_fdir_engine_priv *priv = priv_data;
 	struct i40e_flow_engine_fdir_flow *flow;
-	uint64_t slab = 0;
-	uint32_t pos = 0;
-	uint32_t bit;
 	size_t mem_sz;
-	int ret;
 
 	if (fdir_info->fdir_rule_count >= fdir_info->fdir_space_size)
 		return NULL;
 
-	ret = rte_bitmap_scan(priv->bitmap, &pos, &slab);
-	if (ret == 0)
+	if (rte_mempool_get(fdir_info->flow_store.pool, (void **)&flow) < 0)
 		return NULL;
 
-	bit = rte_bsf64(slab);
-	pos += bit;
-	rte_bitmap_clear(priv->bitmap, pos);
-
-	flow = &priv->pool[pos].flow;
 	/* do not touch ci_flow members, they are initialized by the caller */
 	mem_sz = sizeof(*flow) - sizeof(struct ci_flow);
 
@@ -2180,20 +2072,16 @@ i40e_fdir_flow_alloc(const struct ci_flow_engine *engine __rte_unused,
 
 static void
 i40e_fdir_flow_free(struct ci_flow *flow,
-		struct rte_eth_dev_data *dev_data __rte_unused,
-		void *priv_data)
+		struct rte_eth_dev_data *dev_data,
+		void *priv_data __rte_unused)
 {
-	struct i40e_fdir_engine_priv *priv = priv_data;
-	struct i40e_fdir_flow_pool_entry *entry;
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev_data->dev_private);
 
-	entry = I40E_FDIR_FLOW_ENTRY((struct i40e_flow_engine_fdir_flow *)flow);
-	/* idx is not set at alloc, it's set at init */
-	rte_bitmap_set(priv->bitmap, entry->idx);
+	rte_mempool_put(pf->fdir.flow_store.pool, flow);
 }
 
 static const struct ci_flow_engine_ops i40e_flow_engine_fdir_ops = {
 	.engine_init = i40e_fdir_flow_engine_init,
-	.engine_uninit = i40e_fdir_flow_engine_uninit,
 	.flow_alloc = i40e_fdir_flow_alloc,
 	.flow_free = i40e_fdir_flow_free,
 	.ctx_init = i40e_fdir_ctx_init,
@@ -2209,6 +2097,5 @@ const struct ci_flow_engine i40e_flow_engine_fdir = {
 	.ops = &i40e_flow_engine_fdir_ops,
 	.ctx_size = sizeof(struct i40e_fdir_ctx),
 	.flow_size = sizeof(struct i40e_flow_engine_fdir_flow),
-	.priv_size = sizeof(struct i40e_fdir_engine_priv),
 	.graph = &i40e_fdir_graph,
 };
-- 
2.52.0

