Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E701606A327
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FM9Mqf0L
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BB9542F35;
	Tue,  3 Nov 2026 16:19:45 +0100 (CET)
Received: from mta1.migadu.com (out-137.mta1.migadu.com [95.215.58.137])
 by mails.dpdk.org (Postfix) with ESMTPS id 4E36E427E0
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:19:44 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=HsRWUhRgTkx+xeMqnWbikbOLYwG7SbgNSmWJLyxFvNw=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719183; v=1; x=1794323983;
 b=FM9Mqf0L5fhEapVXpcLYPZzyQ8wNyGuThrgwsWUlcVCLXOw/sElPzIAZ5vP/A2lieBjJGwkP
 LwK5EufTTECT1W745gRU6H4I/HLQwE4Jw7kjJa7IELzA7RjGEdFPTI/bNdyw7U9l10avuF6SE2z
 zjSxQ7cBdWLRl+SYsRcXJhmY=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 83e5bc1781a787df;
 Tue, 03 Nov 2026 15:19:43 +0000
X-Mizu-Trace-ID: 83e5bc1781a787df
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 169/227] drivers: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:07 +0800
Message-ID: <20261103145306.487255-170-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename socket_id parameters, internal structure fields, variables
and comments to the NUMA node terminology across the mlx5 common
and net drivers, and switch calls to the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 .../common/mlx5/linux/mlx5_common_auxiliary.c |  6 +--
 drivers/common/mlx5/linux/mlx5_nl.c           |  4 +-
 drivers/common/mlx5/mlx5_common.c             |  4 +-
 drivers/common/mlx5/mlx5_common_mr.c          | 16 +++---
 drivers/common/mlx5/mlx5_common_mr.h          |  2 +-
 drivers/common/mlx5/mlx5_common_utils.c       |  6 +--
 drivers/common/mlx5/mlx5_devx_cmds.c          | 50 +++++++++----------
 drivers/common/mlx5/mlx5_malloc.c             | 10 ++--
 drivers/common/mlx5/mlx5_malloc.h             |  4 +-
 drivers/common/mlx5/windows/mlx5_common_os.c  |  4 +-
 drivers/net/mlx5/hws/mlx5dr_internal.h        |  4 +-
 drivers/net/mlx5/linux/mlx5_ethdev_os.c       |  8 +--
 drivers/net/mlx5/linux/mlx5_os.c              | 14 +++---
 drivers/net/mlx5/linux/mlx5_verbs.c           |  6 +--
 drivers/net/mlx5/linux/mlx5_vlan_os.c         |  2 +-
 drivers/net/mlx5/mlx5.c                       | 16 +++---
 drivers/net/mlx5/mlx5_devx.c                  | 12 ++---
 drivers/net/mlx5/mlx5_ethdev.c                |  6 +--
 drivers/net/mlx5/mlx5_flow.c                  |  2 +-
 drivers/net/mlx5/mlx5_flow_aso.c              |  8 +--
 drivers/net/mlx5/mlx5_flow_dv.c               | 32 ++++++------
 drivers/net/mlx5/mlx5_flow_flex.c             |  4 +-
 drivers/net/mlx5/mlx5_flow_geneve.c           |  2 +-
 drivers/net/mlx5/mlx5_flow_hw.c               | 48 +++++++++---------
 drivers/net/mlx5/mlx5_flow_meter.c            | 14 +++---
 drivers/net/mlx5/mlx5_flow_quota.c            |  6 +--
 drivers/net/mlx5/mlx5_flow_verbs.c            |  2 +-
 drivers/net/mlx5/mlx5_hws_cnt.c               | 30 +++++------
 drivers/net/mlx5/mlx5_nta_sample.c            | 16 +++---
 drivers/net/mlx5/mlx5_nta_split.c             |  2 +-
 drivers/net/mlx5/mlx5_rss.c                   |  4 +-
 drivers/net/mlx5/mlx5_rxq.c                   |  4 +-
 drivers/net/mlx5/mlx5_stats.c                 |  2 +-
 drivers/net/mlx5/mlx5_trigger.c               |  2 +-
 drivers/net/mlx5/mlx5_tx.c                    |  2 +-
 drivers/net/mlx5/mlx5_utils.c                 | 30 +++++------
 drivers/net/mlx5/windows/mlx5_flow_os.c       |  4 +-
 drivers/net/mlx5/windows/mlx5_os.c            |  8 +--
 38 files changed, 198 insertions(+), 198 deletions(-)

diff --git a/drivers/common/mlx5/linux/mlx5_common_auxiliary.c b/drivers/common/mlx5/linux/mlx5_common_auxiliary.c
index 3ee2f4638a..d54e681b42 100644
--- a/drivers/common/mlx5/linux/mlx5_common_auxiliary.c
+++ b/drivers/common/mlx5/linux/mlx5_common_auxiliary.c
@@ -97,14 +97,14 @@ mlx5_auxiliary_get_numa(const struct rte_auxiliary_device *dev)
 	char numa_path[PATH_MAX];
 
 	if (mlx5_auxiliary_get_pci_path(dev, numa_path, sizeof(numa_path)) != 0)
-		return SOCKET_ID_ANY;
+		return RTE_NUMA_ID_ANY;
 	if (strcat(numa_path, "/numa_node") == NULL) {
 		rte_errno = ENAMETOOLONG;
-		return SOCKET_ID_ANY;
+		return RTE_NUMA_ID_ANY;
 	}
 	if (eal_parse_sysfs_value(numa_path, &numa) != 0) {
 		rte_errno = EINVAL;
-		return SOCKET_ID_ANY;
+		return RTE_NUMA_ID_ANY;
 	}
 	return (int)numa;
 }
diff --git a/drivers/common/mlx5/linux/mlx5_nl.c b/drivers/common/mlx5/linux/mlx5_nl.c
index 3fabcfaee0..d2e762ad73 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.c
+++ b/drivers/common/mlx5/linux/mlx5_nl.c
@@ -400,7 +400,7 @@ mlx5_nl_recv(int nlsk_fd, uint32_t sn, int (*cb)(struct nlmsghdr *, void *arg),
 			if (recv_bytes < MLX5_RECV_BUF_SIZE)
 				recv_bytes = MLX5_RECV_BUF_SIZE;
 			mlx5_free(buf);
-			buf = mlx5_malloc(0, recv_bytes, 0, SOCKET_ID_ANY);
+			buf = mlx5_malloc(0, recv_bytes, 0, RTE_NUMA_ID_ANY);
 			if (!buf) {
 				rte_errno = ENOMEM;
 				ret = -rte_errno;
@@ -1338,7 +1338,7 @@ mlx5_nl_portnum(int nl, const char *name, struct mlx5_dev_info *dev_info)
 		size = (data.portnum + 1) * sizeof(struct mlx5_port_nl_info);
 		dev_info->port_info = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE, size,
 						  RTE_CACHE_LINE_SIZE,
-						  SOCKET_ID_ANY);
+						  RTE_NUMA_ID_ANY);
 		if (dev_info->port_info == NULL) {
 			memset(dev_info, 0, sizeof(*dev_info));
 			rte_errno = ENOMEM;
diff --git a/drivers/common/mlx5/mlx5_common.c b/drivers/common/mlx5/mlx5_common.c
index f4b8904366..de20f97ef3 100644
--- a/drivers/common/mlx5/mlx5_common.c
+++ b/drivers/common/mlx5/mlx5_common.c
@@ -854,7 +854,7 @@ mlx5_common_probe_again_args_validate(struct mlx5_common_device *cdev,
 		return 0;
 	config = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE,
 			     sizeof(struct mlx5_common_dev_config),
-			     RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+			     RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	if (config == NULL) {
 		rte_errno = -ENOMEM;
 		return -rte_errno;
@@ -1135,7 +1135,7 @@ mlx5_common_dev_dma_map(struct rte_device *rte_dev, void *addr,
 		return -1;
 	}
 	mr = mlx5_create_mr_ext(dev->pd, (uintptr_t)addr, len,
-				SOCKET_ID_ANY);
+				RTE_NUMA_ID_ANY);
 	if (!mr) {
 		DRV_LOG(WARNING, "Device %s unable to DMA map", rte_dev->name);
 		rte_errno = EINVAL;
diff --git a/drivers/common/mlx5/mlx5_common_mr.c b/drivers/common/mlx5/mlx5_common_mr.c
index cf39aa93e7..ff0c41ecec 100644
--- a/drivers/common/mlx5/mlx5_common_mr.c
+++ b/drivers/common/mlx5/mlx5_common_mr.c
@@ -88,14 +88,14 @@ mr_btree_expand(struct mlx5_mr_btree *bt, uint32_t n)
 	if (n <= bt->size)
 		return ret;
 	/*
-	 * Downside of directly using rte_realloc() is that SOCKET_ID_ANY is
+	 * Downside of directly using rte_realloc() is that RTE_NUMA_ID_ANY is
 	 * used inside if there's no room to expand. Because this is a quite
 	 * rare case and a part of very slow path, it is very acceptable.
 	 * Initially cache_bh[] will be given practically enough space and once
 	 * it is expanded, expansion wouldn't be needed again ever.
 	 */
 	mem = mlx5_realloc(bt->table, MLX5_MEM_RTE | MLX5_MEM_ZERO,
-			   n * sizeof(struct mr_cache_entry), 0, SOCKET_ID_ANY);
+			   n * sizeof(struct mr_cache_entry), 0, RTE_NUMA_ID_ANY);
 	if (mem == NULL) {
 		/* Not an error, B-tree search will be skipped. */
 		DRV_LOG(WARNING, "failed to expand MR B-tree (%p) table",
@@ -773,7 +773,7 @@ mlx5_mr_create_primary(void *pd,
 	bmp_size = rte_bitmap_get_memory_footprint(ms_n);
 	mr = mlx5_malloc(MLX5_MEM_RTE |  MLX5_MEM_ZERO,
 			 RTE_ALIGN_CEIL(sizeof(*mr), RTE_CACHE_LINE_SIZE) +
-			 bmp_size, RTE_CACHE_LINE_SIZE, msl->socket_id);
+			 bmp_size, RTE_CACHE_LINE_SIZE, msl->numa_id);
 	if (mr == NULL) {
 		DRV_LOG(DEBUG, "Unable to allocate memory for a new MR of"
 		      " address (%p).", (void *)addr);
@@ -909,7 +909,7 @@ mlx5_mr_create_primary(void *pd,
 	/*
 	 * Finally create an MR for the memory chunk. Verbs: ibv_reg_mr() can
 	 * be called with holding the memory lock because it doesn't use
-	 * mlx5_alloc_buf_extern() which eventually calls rte_malloc_socket()
+	 * mlx5_alloc_buf_extern() which eventually calls rte_malloc_numa()
 	 * through mlx5_alloc_verbs_buf().
 	 */
 	mlx5_os_reg_mr(pd, (void *)data.start, len, &mr->pmd_mr);
@@ -1186,13 +1186,13 @@ mlx5_mr_flush_local_cache(struct mlx5_mr_ctrl *mr_ctrl)
  *   Pointer to MR structure on success, NULL otherwise.
  */
 struct mlx5_mr *
-mlx5_create_mr_ext(void *pd, uintptr_t addr, size_t len, int socket_id)
+mlx5_create_mr_ext(void *pd, uintptr_t addr, size_t len, int numa_id)
 {
 	struct mlx5_mr *mr = NULL;
 
 	mr = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO,
 			 RTE_ALIGN_CEIL(sizeof(*mr), RTE_CACHE_LINE_SIZE),
-			 RTE_CACHE_LINE_SIZE, socket_id);
+			 RTE_CACHE_LINE_SIZE, numa_id);
 	if (mr == NULL)
 		return NULL;
 	mlx5_os_reg_mr(pd, (void *)addr, len, &mr->pmd_mr);
@@ -1592,7 +1592,7 @@ mlx5_mempool_reg_create(struct rte_mempool *mp, unsigned int mrs_n,
 
 	mpr = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO,
 			  sizeof(struct mlx5_mempool_reg),
-			  RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+			  RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	if (mpr == NULL) {
 		DRV_LOG(ERR, "Cannot allocate mempool %s registration object",
 			mp->name);
@@ -1600,7 +1600,7 @@ mlx5_mempool_reg_create(struct rte_mempool *mp, unsigned int mrs_n,
 	}
 	mpr->mrs = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO,
 			       mrs_n * sizeof(struct mlx5_mempool_mr),
-			       RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+			       RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	if (!mpr->mrs) {
 		DRV_LOG(ERR, "Cannot allocate mempool %s registration MRs",
 			mp->name);
diff --git a/drivers/common/mlx5/mlx5_common_mr.h b/drivers/common/mlx5/mlx5_common_mr.h
index 5fb931a1b5..5d1e601fa2 100644
--- a/drivers/common/mlx5/mlx5_common_mr.h
+++ b/drivers/common/mlx5/mlx5_common_mr.h
@@ -224,7 +224,7 @@ struct mlx5_mr *
 mlx5_mr_lookup_list(struct mlx5_mr_share_cache *share_cache,
 		    struct mr_cache_entry *entry, uintptr_t addr);
 struct mlx5_mr *
-mlx5_create_mr_ext(void *pd, uintptr_t addr, size_t len, int socket_id);
+mlx5_create_mr_ext(void *pd, uintptr_t addr, size_t len, int numa_id);
 void mlx5_mr_free(struct mlx5_mr *mr);
 __rte_internal
 uint32_t
diff --git a/drivers/common/mlx5/mlx5_common_utils.c b/drivers/common/mlx5/mlx5_common_utils.c
index 14056cebcb..d6989cbaec 100644
--- a/drivers/common/mlx5/mlx5_common_utils.c
+++ b/drivers/common/mlx5/mlx5_common_utils.c
@@ -46,7 +46,7 @@ mlx5_list_create(const char *name, void *ctx, bool lcores_share,
 	}
 	list = mlx5_malloc(MLX5_MEM_ZERO,
 			   sizeof(*list) + (lcores_share ? sizeof(*gc) : 0),
-			   0, SOCKET_ID_ANY);
+			   0, RTE_NUMA_ID_ANY);
 
 	if (!list)
 		return NULL;
@@ -183,7 +183,7 @@ _mlx5_list_register(struct mlx5_list_inconst *l_inconst,
 	if (unlikely(!l_inconst->cache[lcore_index])) {
 		l_inconst->cache[lcore_index] = mlx5_malloc(0,
 					sizeof(struct mlx5_list_cache),
-					RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+					RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 		if (!l_inconst->cache[lcore_index]) {
 			rte_errno = ENOMEM;
 			return NULL;
@@ -423,7 +423,7 @@ mlx5_hlist_create(const char *name, uint32_t size, bool direct_key,
 		alloc_size += sizeof(struct mlx5_list_cache)  * act_size;
 	/* Using zmalloc, then no need to initialize the heads. */
 	h = mlx5_malloc(MLX5_MEM_ZERO, alloc_size, RTE_CACHE_LINE_SIZE,
-			SOCKET_ID_ANY);
+			RTE_NUMA_ID_ANY);
 	if (!h) {
 		DRV_LOG(ERR, "No memory for hash list %s creation",
 			name ? name : "None");
diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c b/drivers/common/mlx5/mlx5_devx_cmds.c
index e5d9c92779..f7ab1f3f1d 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.c
+++ b/drivers/common/mlx5/mlx5_devx_cmds.c
@@ -185,7 +185,7 @@ mlx5_devx_cmd_flow_counter_alloc_general(void *ctx,
 		struct mlx5_devx_counter_attr *attr)
 {
 	struct mlx5_devx_obj *dcs = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*dcs),
-						0, SOCKET_ID_ANY);
+						0, RTE_NUMA_ID_ANY);
 	uint32_t in[MLX5_ST_SZ_DW(alloc_flow_counter_in)]   = {0};
 	uint32_t out[MLX5_ST_SZ_DW(alloc_flow_counter_out)] = {0};
 
@@ -234,7 +234,7 @@ struct mlx5_devx_obj *
 mlx5_devx_cmd_flow_counter_alloc(void *ctx, uint32_t bulk_n_128)
 {
 	struct mlx5_devx_obj *dcs = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*dcs),
-						0, SOCKET_ID_ANY);
+						0, RTE_NUMA_ID_ANY);
 	uint32_t in[MLX5_ST_SZ_DW(alloc_flow_counter_in)]   = {0};
 	uint32_t out[MLX5_ST_SZ_DW(alloc_flow_counter_out)] = {0};
 
@@ -379,7 +379,7 @@ mlx5_devx_cmd_mkey_create(void *ctx,
 	uint32_t out[MLX5_ST_SZ_DW(create_mkey_out)] = {0};
 	void *mkc;
 	struct mlx5_devx_obj *mkey = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*mkey),
-						 0, SOCKET_ID_ANY);
+						 0, RTE_NUMA_ID_ANY);
 	size_t pgsize;
 	uint32_t translation_size;
 
@@ -795,7 +795,7 @@ mlx5_devx_cmd_create_flex_parser(void *ctx,
 	void *in_arc = MLX5_ADDR_OF(parse_graph_flex, flex, input_arc);
 	void *out_arc = MLX5_ADDR_OF(parse_graph_flex, flex, output_arc);
 	struct mlx5_devx_obj *parse_flex_obj = mlx5_malloc
-		     (MLX5_MEM_ZERO, sizeof(*parse_flex_obj), 0, SOCKET_ID_ANY);
+		     (MLX5_MEM_ZERO, sizeof(*parse_flex_obj), 0, RTE_NUMA_ID_ANY);
 	uint32_t i;
 
 	if (!parse_flex_obj) {
@@ -1830,7 +1830,7 @@ mlx5_devx_cmd_create_tir(void *ctx,
 	void *tir_ctx, *outer, *inner, *rss_key;
 	struct mlx5_devx_obj *tir = NULL;
 
-	tir = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*tir), 0, SOCKET_ID_ANY);
+	tir = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*tir), 0, RTE_NUMA_ID_ANY);
 	if (!tir) {
 		DRV_LOG(ERR, "Failed to allocate TIR data");
 		rte_errno = ENOMEM;
@@ -1987,13 +1987,13 @@ mlx5_devx_cmd_create_rqt(void *ctx,
 	struct mlx5_devx_obj *rqt = NULL;
 	unsigned int i;
 
-	in = mlx5_malloc(MLX5_MEM_ZERO, inlen, 0, SOCKET_ID_ANY);
+	in = mlx5_malloc(MLX5_MEM_ZERO, inlen, 0, RTE_NUMA_ID_ANY);
 	if (!in) {
 		DRV_LOG(ERR, "Failed to allocate RQT IN data");
 		rte_errno = ENOMEM;
 		return NULL;
 	}
-	rqt = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*rqt), 0, SOCKET_ID_ANY);
+	rqt = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*rqt), 0, RTE_NUMA_ID_ANY);
 	if (!rqt) {
 		DRV_LOG(ERR, "Failed to allocate RQT data");
 		rte_errno = ENOMEM;
@@ -2037,7 +2037,7 @@ mlx5_devx_cmd_modify_rqt(struct mlx5_devx_obj *rqt,
 	uint32_t inlen = MLX5_ST_SZ_BYTES(modify_rqt_in) +
 			 rqt_attr->rqt_actual_size * sizeof(uint32_t);
 	uint32_t out[MLX5_ST_SZ_DW(modify_rqt_out)] = {0};
-	uint32_t *in = mlx5_malloc(MLX5_MEM_ZERO, inlen, 0, SOCKET_ID_ANY);
+	uint32_t *in = mlx5_malloc(MLX5_MEM_ZERO, inlen, 0, RTE_NUMA_ID_ANY);
 	void *rqt_ctx;
 	unsigned int i;
 	int ret;
@@ -2090,7 +2090,7 @@ mlx5_devx_cmd_create_sq(void *ctx,
 	struct mlx5_devx_wq_attr *wq_attr;
 	struct mlx5_devx_obj *sq = NULL;
 
-	sq = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*sq), 0, SOCKET_ID_ANY);
+	sq = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*sq), 0, RTE_NUMA_ID_ANY);
 	if (!sq) {
 		DRV_LOG(ERR, "Failed to allocate SQ data");
 		rte_errno = ENOMEM;
@@ -2230,7 +2230,7 @@ mlx5_devx_cmd_create_tis(void *ctx,
 	struct mlx5_devx_obj *tis = NULL;
 	void *tis_ctx;
 
-	tis = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*tis), 0, SOCKET_ID_ANY);
+	tis = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*tis), 0, RTE_NUMA_ID_ANY);
 	if (!tis) {
 		DRV_LOG(ERR, "Failed to allocate TIS object");
 		rte_errno = ENOMEM;
@@ -2272,7 +2272,7 @@ mlx5_devx_cmd_create_td(void *ctx)
 	uint32_t out[MLX5_ST_SZ_DW(alloc_transport_domain_out)] = {0};
 	struct mlx5_devx_obj *td = NULL;
 
-	td = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*td), 0, SOCKET_ID_ANY);
+	td = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*td), 0, RTE_NUMA_ID_ANY);
 	if (!td) {
 		DRV_LOG(ERR, "Failed to allocate TD object");
 		rte_errno = ENOMEM;
@@ -2367,7 +2367,7 @@ mlx5_devx_cmd_create_cq(void *ctx, struct mlx5_devx_cq_attr *attr)
 	uint32_t out[MLX5_ST_SZ_DW(create_cq_out)] = {0};
 	struct mlx5_devx_obj *cq_obj = mlx5_malloc(MLX5_MEM_ZERO,
 						   sizeof(*cq_obj),
-						   0, SOCKET_ID_ANY);
+						   0, RTE_NUMA_ID_ANY);
 	void *cqctx = MLX5_ADDR_OF(create_cq_in, in, cq_context);
 
 	if (!cq_obj) {
@@ -2465,7 +2465,7 @@ mlx5_devx_cmd_create_virtq(void *ctx,
 	uint32_t out[MLX5_ST_SZ_DW(general_obj_out_cmd_hdr)] = {0};
 	struct mlx5_devx_obj *virtq_obj = mlx5_malloc(MLX5_MEM_ZERO,
 						     sizeof(*virtq_obj),
-						     0, SOCKET_ID_ANY);
+						     0, RTE_NUMA_ID_ANY);
 	void *virtq = MLX5_ADDR_OF(create_virtq_in, in, virtq);
 	void *hdr = MLX5_ADDR_OF(create_virtq_in, in, hdr);
 	void *virtctx = MLX5_ADDR_OF(virtio_net_q, virtq, virtio_q_context);
@@ -2684,7 +2684,7 @@ mlx5_devx_cmd_create_qp(void *ctx,
 	uint32_t out[MLX5_ST_SZ_DW(create_qp_out)] = {0};
 	struct mlx5_devx_obj *qp_obj = mlx5_malloc(MLX5_MEM_ZERO,
 						   sizeof(*qp_obj),
-						   0, SOCKET_ID_ANY);
+						   0, RTE_NUMA_ID_ANY);
 	void *qpc = MLX5_ADDR_OF(create_qp_in, in, qpc);
 
 	if (!qp_obj) {
@@ -2864,7 +2864,7 @@ mlx5_devx_cmd_create_virtio_q_counters(void *ctx)
 	uint32_t out[MLX5_ST_SZ_DW(general_obj_out_cmd_hdr)] = {0};
 	struct mlx5_devx_obj *couners_obj = mlx5_malloc(MLX5_MEM_ZERO,
 						       sizeof(*couners_obj), 0,
-						       SOCKET_ID_ANY);
+						       RTE_NUMA_ID_ANY);
 	void *hdr = MLX5_ADDR_OF(create_virtio_q_counters_in, in, hdr);
 
 	if (!couners_obj) {
@@ -2948,7 +2948,7 @@ mlx5_devx_cmd_create_flow_hit_aso_obj(void *ctx, uint32_t pd)
 	void *ptr = NULL;
 
 	flow_hit_aso_obj = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*flow_hit_aso_obj),
-				       0, SOCKET_ID_ANY);
+				       0, RTE_NUMA_ID_ANY);
 	if (!flow_hit_aso_obj) {
 		DRV_LOG(ERR, "Failed to allocate FLOW_HIT_ASO object data");
 		rte_errno = ENOMEM;
@@ -2986,7 +2986,7 @@ struct mlx5_devx_obj *
 mlx5_devx_cmd_alloc_pd(void *ctx)
 {
 	struct mlx5_devx_obj *ppd =
-		mlx5_malloc(MLX5_MEM_ZERO, sizeof(*ppd), 0, SOCKET_ID_ANY);
+		mlx5_malloc(MLX5_MEM_ZERO, sizeof(*ppd), 0, RTE_NUMA_ID_ANY);
 	u32 in[MLX5_ST_SZ_DW(alloc_pd_in)] = {0};
 	u32 out[MLX5_ST_SZ_DW(alloc_pd_out)] = {0};
 
@@ -3034,7 +3034,7 @@ mlx5_devx_cmd_create_flow_meter_aso_obj(void *ctx, uint32_t pd,
 
 	flow_meter_aso_obj = mlx5_malloc(MLX5_MEM_ZERO,
 						sizeof(*flow_meter_aso_obj),
-						0, SOCKET_ID_ANY);
+						0, RTE_NUMA_ID_ANY);
 	if (!flow_meter_aso_obj) {
 		DRV_LOG(ERR, "Failed to allocate FLOW_METER_ASO object data");
 		rte_errno = ENOMEM;
@@ -3087,7 +3087,7 @@ mlx5_devx_cmd_create_conn_track_offload_obj(void *ctx, uint32_t pd,
 	void *ptr;
 
 	ct_aso_obj = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*ct_aso_obj),
-				 0, SOCKET_ID_ANY);
+				 0, RTE_NUMA_ID_ANY);
 	if (!ct_aso_obj) {
 		DRV_LOG(ERR, "Failed to allocate CONN_TRACK_OFFLOAD object.");
 		rte_errno = ENOMEM;
@@ -3132,7 +3132,7 @@ mlx5_devx_cmd_create_geneve_tlv_option(void *ctx,
 	uint32_t out[MLX5_ST_SZ_DW(general_obj_out_cmd_hdr)] = {0};
 	struct mlx5_devx_obj *geneve_tlv_opt_obj = mlx5_malloc(MLX5_MEM_ZERO,
 						   sizeof(*geneve_tlv_opt_obj),
-						   0, SOCKET_ID_ANY);
+						   0, RTE_NUMA_ID_ANY);
 
 	if (!geneve_tlv_opt_obj) {
 		DRV_LOG(ERR, "Failed to allocate GENEVE TLV option object.");
@@ -3271,7 +3271,7 @@ mlx5_devx_cmd_queue_counter_alloc(void *ctx, int *syndrome)
 {
 	int status;
 	struct mlx5_devx_obj *dcs = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*dcs), 0,
-						SOCKET_ID_ANY);
+						RTE_NUMA_ID_ANY);
 	uint32_t in[MLX5_ST_SZ_DW(alloc_q_counter_in)]   = {0};
 	uint32_t out[MLX5_ST_SZ_DW(alloc_q_counter_out)] = {0};
 
@@ -3353,7 +3353,7 @@ mlx5_devx_cmd_create_dek_obj(void *ctx, struct mlx5_devx_dek_attr *attr)
 	void *ptr = NULL, *key_addr = NULL;
 
 	dek_obj = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*dek_obj),
-			      0, SOCKET_ID_ANY);
+			      0, RTE_NUMA_ID_ANY);
 	if (dek_obj == NULL) {
 		DRV_LOG(ERR, "Failed to allocate DEK object data");
 		rte_errno = ENOMEM;
@@ -3405,7 +3405,7 @@ mlx5_devx_cmd_create_import_kek_obj(void *ctx,
 	void *ptr = NULL, *key_addr = NULL;
 
 	import_kek_obj = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*import_kek_obj),
-				     0, SOCKET_ID_ANY);
+				     0, RTE_NUMA_ID_ANY);
 	if (import_kek_obj == NULL) {
 		DRV_LOG(ERR, "Failed to allocate IMPORT_KEK object data");
 		rte_errno = ENOMEM;
@@ -3453,7 +3453,7 @@ mlx5_devx_cmd_create_credential_obj(void *ctx,
 	void *ptr = NULL, *credential_addr = NULL;
 
 	credential_obj = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*credential_obj),
-				     0, SOCKET_ID_ANY);
+				     0, RTE_NUMA_ID_ANY);
 	if (credential_obj == NULL) {
 		DRV_LOG(ERR, "Failed to allocate CREDENTIAL object data");
 		rte_errno = ENOMEM;
@@ -3502,7 +3502,7 @@ mlx5_devx_cmd_create_crypto_login_obj(void *ctx,
 	void *ptr = NULL, *credential_addr = NULL;
 
 	crypto_login_obj = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*crypto_login_obj),
-				       0, SOCKET_ID_ANY);
+				       0, RTE_NUMA_ID_ANY);
 	if (crypto_login_obj == NULL) {
 		DRV_LOG(ERR, "Failed to allocate CRYPTO_LOGIN object data");
 		rte_errno = ENOMEM;
diff --git a/drivers/common/mlx5/mlx5_malloc.c b/drivers/common/mlx5/mlx5_malloc.c
index 86e2b8881e..3538542221 100644
--- a/drivers/common/mlx5/mlx5_malloc.c
+++ b/drivers/common/mlx5/mlx5_malloc.c
@@ -165,8 +165,8 @@ mlx5_alloc_align(size_t size, unsigned int align, unsigned int zero)
 static void *
 mlx5_malloc_socket_internal(size_t size, unsigned int align, int socket, bool zero)
 {
-	return zero ? rte_zmalloc_socket(NULL, size, align, socket) :
-		      rte_malloc_socket(NULL, size, align, socket);
+	return zero ? rte_zmalloc_numa(NULL, size, align, socket) :
+		      rte_malloc_numa(NULL, size, align, socket);
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(mlx5_malloc)
@@ -188,9 +188,9 @@ mlx5_malloc(uint32_t flags, size_t size, unsigned int align, int socket)
 		rte_mem = mlx5_sys_mem.enable ? false : true;
 	if (rte_mem) {
 		addr = mlx5_malloc_socket_internal(size, align, socket, !!(flags & MLX5_MEM_ZERO));
-		if (addr == NULL && socket != SOCKET_ID_ANY && (flags & MLX5_NUMA_TOLERANT)) {
+		if (addr == NULL && socket != RTE_NUMA_ID_ANY && (flags & MLX5_NUMA_TOLERANT)) {
 			size_t alloc_size = size;
-			addr = mlx5_malloc_socket_internal(size, align, SOCKET_ID_ANY,
+			addr = mlx5_malloc_socket_internal(size, align, RTE_NUMA_ID_ANY,
 				!!(flags & MLX5_MEM_ZERO));
 			if (addr) {
 				DRV_LOG(WARNING, "Allocated %p (size %zu socket %d) through NUMA tolerant fallback",
@@ -245,7 +245,7 @@ mlx5_realloc(void *addr, uint32_t flags, size_t size, unsigned int align,
 	}
 	/* Allocate memory from rte memory. */
 	if (rte_mem) {
-		new_addr = rte_realloc_socket(addr, size, align, socket);
+		new_addr = rte_realloc_numa(addr, size, align, socket);
 		mlx5_mem_update_msl(new_addr);
 #ifdef RTE_PMD_MLX5_DEBUG
 		if (new_addr)
diff --git a/drivers/common/mlx5/mlx5_malloc.h b/drivers/common/mlx5/mlx5_malloc.h
index 46ea5bc8f0..705396ef4d 100644
--- a/drivers/common/mlx5/mlx5_malloc.h
+++ b/drivers/common/mlx5/mlx5_malloc.h
@@ -106,9 +106,9 @@ void mlx5_free(void *addr);
 #if defined(RTE_TOOLCHAIN_GCC) || defined(RTE_TOOLCHAIN_CLANG)
 #define mlx5_malloc_numa_tolerant(flags, size, align, socket) (__extension__ ({ \
 		void *mem = mlx5_malloc((uint32_t)(flags), (size_t)(size), (align), (socket)); \
-		if ((mem == NULL) && ((int)(socket) != SOCKET_ID_ANY)) { \
+		if ((mem == NULL) && ((int)(socket) != RTE_NUMA_ID_ANY)) { \
 			mem = mlx5_malloc((uint32_t)(flags), (size_t)(size), \
-					  (align), SOCKET_ID_ANY); \
+					  (align), RTE_NUMA_ID_ANY); \
 			if (mem) { \
 				DRV_LOG(WARNING, \
 				"Allocated %p (size %zu socket %d) through NUMA tolerant fallback", \
diff --git a/drivers/common/mlx5/windows/mlx5_common_os.c b/drivers/common/mlx5/windows/mlx5_common_os.c
index bdafb95df9..9ffc80e0f5 100644
--- a/drivers/common/mlx5/windows/mlx5_common_os.c
+++ b/drivers/common/mlx5/windows/mlx5_common_os.c
@@ -84,7 +84,7 @@ mlx5_os_pd_prepare(struct mlx5_common_device *cdev)
 {
 	struct mlx5_pd *pd;
 
-	pd = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*pd), 0, SOCKET_ID_ANY);
+	pd = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*pd), 0, RTE_NUMA_ID_ANY);
 	if (!pd)
 		return -1;
 	struct mlx5_devx_obj *obj = mlx5_devx_cmd_alloc_pd(cdev->ctx);
@@ -321,7 +321,7 @@ mlx5_os_umem_reg(void *ctx, void *addr, size_t size, uint32_t access)
 	struct mlx5_devx_umem *umem;
 
 	umem = mlx5_malloc(MLX5_MEM_ZERO,
-		(sizeof(*umem)), 0, SOCKET_ID_ANY);
+		(sizeof(*umem)), 0, RTE_NUMA_ID_ANY);
 	if (!umem) {
 		errno = ENOMEM;
 		return NULL;
diff --git a/drivers/net/mlx5/hws/mlx5dr_internal.h b/drivers/net/mlx5/hws/mlx5dr_internal.h
index 3c27206043..a75f38a4ab 100644
--- a/drivers/net/mlx5/hws/mlx5dr_internal.h
+++ b/drivers/net/mlx5/hws/mlx5dr_internal.h
@@ -74,7 +74,7 @@ static inline void *simple_malloc(size_t size)
 	return mlx5_malloc(MLX5_MEM_SYS,
 			   size,
 			   MLX5_MALLOC_ALIGNMENT,
-			   SOCKET_ID_ANY);
+			   RTE_NUMA_ID_ANY);
 }
 
 static inline void *simple_calloc(size_t nmemb, size_t size)
@@ -82,7 +82,7 @@ static inline void *simple_calloc(size_t nmemb, size_t size)
 	return mlx5_malloc(MLX5_MEM_SYS | MLX5_MEM_ZERO,
 			   nmemb * size,
 			   MLX5_MALLOC_ALIGNMENT,
-			   SOCKET_ID_ANY);
+			   RTE_NUMA_ID_ANY);
 }
 
 static inline void simple_free(void *addr)
diff --git a/drivers/net/mlx5/linux/mlx5_ethdev_os.c b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
index f6394ebd19..0536432af1 100644
--- a/drivers/net/mlx5/linux/mlx5_ethdev_os.c
+++ b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
@@ -1305,7 +1305,7 @@ int mlx5_get_module_eeprom(struct rte_eth_dev *dev,
 	}
 	eeprom = mlx5_malloc(MLX5_MEM_ZERO,
 			     (sizeof(struct ethtool_eeprom) + info->length), 0,
-			     SOCKET_ID_ANY);
+			     RTE_NUMA_ID_ANY);
 	if (!eeprom) {
 		DRV_LOG(WARNING, "port %u cannot allocate memory for "
 			"eeprom data", dev->data->port_id);
@@ -1879,7 +1879,7 @@ mlx5_os_stats_init(struct rte_eth_dev *dev)
 	str_sz = max_stats_n * ETH_GSTRING_LEN;
 	strings = (struct ethtool_gstrings *)
 		  mlx5_malloc(0, str_sz + sizeof(struct ethtool_gstrings), 0,
-			      SOCKET_ID_ANY);
+			      RTE_NUMA_ID_ANY);
 	if (!strings) {
 		DRV_LOG(WARNING, "port %u unable to allocate memory for xstats",
 			dev->data->port_id);
@@ -1954,7 +1954,7 @@ int mlx5_get_flag_dropless_rq(struct rte_eth_dev *dev)
 	int ret;
 
 	sset_info = mlx5_malloc(0, sizeof(struct ethtool_sset_info) +
-			sizeof(uint32_t), 0, SOCKET_ID_ANY);
+			sizeof(uint32_t), 0, RTE_NUMA_ID_ANY);
 	if (sset_info == NULL) {
 		rte_errno = ENOMEM;
 		return -rte_errno;
@@ -1998,7 +1998,7 @@ int mlx5_get_flag_dropless_rq(struct rte_eth_dev *dev)
 	str_sz = ETH_GSTRING_LEN * len;
 	strings = (struct ethtool_gstrings *)
 		  mlx5_malloc(0, str_sz + sizeof(struct ethtool_gstrings), 0,
-			      SOCKET_ID_ANY);
+			      RTE_NUMA_ID_ANY);
 	if (!strings) {
 		DRV_LOG(WARNING, "port %u unable to allocate memory for"
 			" private flags", dev->data->port_id);
diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 4c35737292..351314401d 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -903,7 +903,7 @@ mlx5_init_shared_data(void)
 			/* Allocate shared memory. */
 			mz = rte_memzone_reserve(MZ_MLX5_PMD_SHARED_DATA,
 						 sizeof(*mlx5_shared_data),
-						 SOCKET_ID_ANY, 0);
+						 RTE_NUMA_ID_ANY, 0);
 			if (mz == NULL) {
 				DRV_LOG(ERR,
 					"Cannot allocate mlx5 shared data");
@@ -1440,7 +1440,7 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	/* Allocate private eth device data. */
 	priv = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE,
 			   sizeof(*priv),
-			   RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+			   RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	if (priv == NULL) {
 		DRV_LOG(ERR, "priv allocation failure");
 		err = ENOMEM;
@@ -1451,7 +1451,7 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	priv->pci_dev = spawn->pci_dev;
 	priv->mac = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE,
 				sizeof(*priv->mac) * sh->dev_cap.max_mac_addrs,
-				RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+				RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	if (priv->mac == NULL) {
 		DRV_LOG(ERR, "Failed to allocate MAC address array.");
 		err = ENOMEM;
@@ -1459,7 +1459,7 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	}
 	priv->mac_own = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE,
 				    RTE_BITSET_SIZE(sh->dev_cap.max_mac_addrs),
-				    RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+				    RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	if (priv->mac_own == NULL) {
 		DRV_LOG(ERR, "Failed to allocate MAC ownership bitmap.");
 		err = ENOMEM;
@@ -1821,7 +1821,7 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 		priv->ext_rxqs = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE,
 					     sizeof(struct mlx5_external_q) *
 					     MLX5_MAX_EXT_RX_QUEUES, 0,
-					     SOCKET_ID_ANY);
+					     RTE_NUMA_ID_ANY);
 		if (priv->ext_rxqs == NULL) {
 			DRV_LOG(ERR, "Fail to allocate external RxQ array.");
 			err = ENOMEM;
@@ -1830,7 +1830,7 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 		priv->ext_txqs = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE,
 					     sizeof(struct mlx5_external_q) *
 					     MLX5_MAX_EXT_TX_QUEUES, 0,
-					     SOCKET_ID_ANY);
+					     RTE_NUMA_ID_ANY);
 		if (priv->ext_txqs == NULL) {
 			DRV_LOG(ERR, "Fail to allocate external TxQ array.");
 			err = ENOMEM;
@@ -2684,7 +2684,7 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
 	/* Now we can determine the maximal amount of devices to be spawned. */
 	list = mlx5_malloc(MLX5_MEM_ZERO,
 			   sizeof(struct mlx5_dev_spawn_data) * (np ? np : nd),
-			   RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+			   RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	if (!list) {
 		DRV_LOG(ERR, "Spawn data array allocation failure.");
 		rte_errno = ENOMEM;
diff --git a/drivers/net/mlx5/linux/mlx5_verbs.c b/drivers/net/mlx5/linux/mlx5_verbs.c
index ce0a26c62b..08bd1f640a 100644
--- a/drivers/net/mlx5/linux/mlx5_verbs.c
+++ b/drivers/net/mlx5/linux/mlx5_verbs.c
@@ -697,7 +697,7 @@ mlx5_rxq_ibv_obj_drop_create(struct rte_eth_dev *dev)
 
 	if (rxq != NULL)
 		return 0;
-	rxq = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*rxq), 0, SOCKET_ID_ANY);
+	rxq = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*rxq), 0, RTE_NUMA_ID_ANY);
 	if (rxq == NULL) {
 		DRV_LOG(DEBUG, "Port %u cannot allocate drop Rx queue memory.",
 		      dev->data->port_id);
@@ -706,7 +706,7 @@ mlx5_rxq_ibv_obj_drop_create(struct rte_eth_dev *dev)
 	}
 	priv->drop_queue.rxq = rxq;
 	rxq_ctrl = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*rxq_ctrl), 0,
-			       SOCKET_ID_ANY);
+			       RTE_NUMA_ID_ANY);
 	if (rxq_ctrl == NULL) {
 		DRV_LOG(DEBUG, "Port %u cannot allocate drop Rx queue control memory.",
 		      dev->data->port_id);
@@ -715,7 +715,7 @@ mlx5_rxq_ibv_obj_drop_create(struct rte_eth_dev *dev)
 	}
 	rxq->ctrl = rxq_ctrl;
 	rxq_obj = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*rxq_obj), 0,
-			      SOCKET_ID_ANY);
+			      RTE_NUMA_ID_ANY);
 	if (rxq_obj == NULL) {
 		DRV_LOG(DEBUG, "Port %u cannot allocate drop Rx queue memory.",
 		      dev->data->port_id);
diff --git a/drivers/net/mlx5/linux/mlx5_vlan_os.c b/drivers/net/mlx5/linux/mlx5_vlan_os.c
index 353484de3f..c04671f453 100644
--- a/drivers/net/mlx5/linux/mlx5_vlan_os.c
+++ b/drivers/net/mlx5/linux/mlx5_vlan_os.c
@@ -127,7 +127,7 @@ mlx5_vlan_vmwa_init(struct rte_eth_dev *dev, uint32_t ifindex)
 		return NULL;
 	}
 	vmwa = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*vmwa), sizeof(uint32_t),
-			   SOCKET_ID_ANY);
+			   RTE_NUMA_ID_ANY);
 	if (!vmwa) {
 		DRV_LOG(WARNING,
 			"Can not allocate memory"
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index e2dbd2977b..91d4bc6a58 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -462,7 +462,7 @@ mlx5_flow_aso_age_mng_init(struct mlx5_dev_ctx_shared *sh)
 	if (sh->aso_age_mng)
 		return 0;
 	sh->aso_age_mng = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*sh->aso_age_mng),
-				      RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+				      RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	if (!sh->aso_age_mng) {
 		DRV_LOG(ERR, "aso_age_mng allocation was failed.");
 		rte_errno = ENOMEM;
@@ -600,7 +600,7 @@ mlx5_flow_counters_mng_init(struct mlx5_dev_ctx_shared *sh)
 		pools = mlx5_malloc(MLX5_MEM_ZERO,
 				    sizeof(struct mlx5_flow_counter_pool *) *
 				    MLX5_COUNTER_POOLS_MAX_NUM,
-				    0, SOCKET_ID_ANY);
+				    0, RTE_NUMA_ID_ANY);
 		if (!pools) {
 			DRV_LOG(ERR,
 				"Counter management allocation was failed.");
@@ -724,7 +724,7 @@ mlx5_aso_flow_mtrs_mng_init(struct mlx5_dev_ctx_shared *sh)
 	if (!sh->mtrmng) {
 		sh->mtrmng = mlx5_malloc(MLX5_MEM_ZERO,
 			sizeof(*sh->mtrmng),
-			RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+			RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 		if (!sh->mtrmng) {
 			DRV_LOG(ERR,
 			"meter management allocation was failed.");
@@ -827,7 +827,7 @@ mlx5_flow_aso_ct_mng_init(struct mlx5_dev_ctx_shared *sh)
 		return 0;
 	sh->ct_mng = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*sh->ct_mng) +
 				 sizeof(struct mlx5_aso_sq) * MLX5_ASO_CT_SQ_NUM,
-				 RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+				 RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	if (!sh->ct_mng) {
 		DRV_LOG(ERR, "ASO CT management allocation failed.");
 		rte_errno = ENOMEM;
@@ -1094,7 +1094,7 @@ mlx5_alloc_srh_flex_parser(struct rte_eth_dev *dev)
 				     rte_memory_order_relaxed) > 0)
 		goto end;
 	priv->sh->srh_flex_parser.flex.devx_fp = mlx5_malloc(MLX5_MEM_ZERO,
-			sizeof(struct mlx5_flex_parser_devx), 0, SOCKET_ID_ANY);
+			sizeof(struct mlx5_flex_parser_devx), 0, RTE_NUMA_ID_ANY);
 	if (!priv->sh->srh_flex_parser.flex.devx_fp) {
 		rte_errno = ENOMEM;
 		goto error;
@@ -1781,7 +1781,7 @@ mlx5_get_physical_device(struct mlx5_common_device *cdev)
 	}
 	phdev = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE,
 			    sizeof(struct mlx5_physical_device),
-			    RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+			    RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	if (!phdev) {
 		DRV_LOG(ERR, "Physical device allocation failure.");
 		rte_errno = ENOMEM;
@@ -1889,7 +1889,7 @@ mlx5_alloc_shared_dev_ctx(const struct mlx5_dev_spawn_data *spawn,
 	sh = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE,
 			 sizeof(struct mlx5_dev_ctx_shared) +
 			 spawn->max_port * sizeof(struct mlx5_dev_shared_port),
-			 RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+			 RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	if (!sh) {
 		DRV_LOG(ERR, "Shared context allocation failure.");
 		rte_errno = ENOMEM;
@@ -3158,7 +3158,7 @@ mlx5_probe_again_args_validate(struct mlx5_common_device *cdev,
 		return 0;
 	config = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE,
 			     sizeof(struct mlx5_sh_config),
-			     RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+			     RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	if (config == NULL) {
 		rte_errno = -ENOMEM;
 		return -rte_errno;
diff --git a/drivers/net/mlx5/mlx5_devx.c b/drivers/net/mlx5/mlx5_devx.c
index ef8f057cf9..aa4783beda 100644
--- a/drivers/net/mlx5/mlx5_devx.c
+++ b/drivers/net/mlx5/mlx5_devx.c
@@ -742,7 +742,7 @@ mlx5_devx_ind_table_create_rqt_attr(struct rte_eth_dev *dev,
 	unsigned int i, j;
 
 	rqt_attr = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*rqt_attr) +
-			      rqt_n * sizeof(uint32_t), 0, SOCKET_ID_ANY);
+			      rqt_n * sizeof(uint32_t), 0, RTE_NUMA_ID_ANY);
 	if (!rqt_attr) {
 		DRV_LOG(ERR, "Port %u cannot allocate RQT resources.",
 			dev->data->port_id);
@@ -1108,7 +1108,7 @@ static int
 mlx5_rxq_devx_obj_drop_create(struct rte_eth_dev *dev)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
-	int socket_id = dev->device->numa_node;
+	int numa_id = dev->device->numa_node;
 	struct mlx5_rxq_priv *rxq;
 	struct mlx5_rxq_ctrl *rxq_ctrl = NULL;
 	struct mlx5_rxq_obj *rxq_obj = NULL;
@@ -1119,7 +1119,7 @@ mlx5_rxq_devx_obj_drop_create(struct rte_eth_dev *dev)
 	 * They are required to hold pointers for cleanup
 	 * and are only accessible via drop queue DevX objects.
 	 */
-	rxq = mlx5_malloc_numa_tolerant(MLX5_MEM_ZERO, sizeof(*rxq), 0, socket_id);
+	rxq = mlx5_malloc_numa_tolerant(MLX5_MEM_ZERO, sizeof(*rxq), 0, numa_id);
 	if (rxq == NULL) {
 		DRV_LOG(ERR, "Port %u could not allocate drop queue private",
 			dev->data->port_id);
@@ -1127,14 +1127,14 @@ mlx5_rxq_devx_obj_drop_create(struct rte_eth_dev *dev)
 		goto error;
 	}
 	rxq_ctrl = mlx5_malloc_numa_tolerant(MLX5_MEM_ZERO, sizeof(*rxq_ctrl),
-			       0, socket_id);
+			       0, numa_id);
 	if (rxq_ctrl == NULL) {
 		DRV_LOG(ERR, "Port %u could not allocate drop queue control",
 			dev->data->port_id);
 		rte_errno = ENOMEM;
 		goto error;
 	}
-	rxq_obj = mlx5_malloc_numa_tolerant(MLX5_MEM_ZERO, sizeof(*rxq_obj), 0, socket_id);
+	rxq_obj = mlx5_malloc_numa_tolerant(MLX5_MEM_ZERO, sizeof(*rxq_obj), 0, numa_id);
 	if (rxq_obj == NULL) {
 		DRV_LOG(ERR, "Port %u could not allocate drop queue object",
 			dev->data->port_id);
@@ -1142,7 +1142,7 @@ mlx5_rxq_devx_obj_drop_create(struct rte_eth_dev *dev)
 		goto error;
 	}
 	/* set the CPU socket ID where the rxq_ctrl was allocated */
-	rxq_ctrl->socket = socket_id;
+	rxq_ctrl->socket = numa_id;
 	rxq_obj->rxq_ctrl = rxq_ctrl;
 	rxq_ctrl->is_hairpin = false;
 	rxq_ctrl->sh = priv->sh;
diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.c
index 26ee58d164..2533b52619 100644
--- a/drivers/net/mlx5/mlx5_ethdev.c
+++ b/drivers/net/mlx5/mlx5_ethdev.c
@@ -85,7 +85,7 @@ mlx5_dev_configure(struct rte_eth_dev *dev)
 	priv->rss_conf.rss_key = mlx5_realloc(priv->rss_conf.rss_key,
 					      MLX5_MEM_RTE,
 					      MLX5_RSS_HASH_KEY_LEN, 0,
-					      SOCKET_ID_ANY);
+					      RTE_NUMA_ID_ANY);
 	if (!priv->rss_conf.rss_key) {
 		DRV_LOG(ERR, "port %u cannot allocate RSS hash key memory (%u)",
 			dev->data->port_id, rxqs_n);
@@ -110,7 +110,7 @@ mlx5_dev_configure(struct rte_eth_dev *dev)
 	priv->rxq_privs = mlx5_realloc(priv->rxq_privs,
 				       MLX5_MEM_RTE | MLX5_MEM_ZERO,
 				       sizeof(void *) * rxqs_n, 0,
-				       SOCKET_ID_ANY);
+				       RTE_NUMA_ID_ANY);
 	if (rxqs_n && priv->rxq_privs == NULL) {
 		DRV_LOG(ERR, "port %u cannot allocate rxq private data",
 			dev->data->port_id);
@@ -187,7 +187,7 @@ mlx5_dev_configure_rss_reta(struct rte_eth_dev *dev)
 	if (priv->skip_default_rss_reta)
 		return ret;
 	rss_queue_arr = mlx5_malloc(0, rxqs_n * sizeof(unsigned int), 0,
-				    SOCKET_ID_ANY);
+				    RTE_NUMA_ID_ANY);
 	if (!rss_queue_arr) {
 		DRV_LOG(ERR, "port %u cannot allocate RSS queue list (%u)",
 			dev->data->port_id, rxqs_n);
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index bba466562c..3a567d7301 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -8558,7 +8558,7 @@ mlx5_ctrl_flow_vlan(struct rte_eth_dev *dev,
 		queue[i] = (*priv->reta_idx)[i];
 
 	entry = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*entry), alignof(typeof(*entry)),
-				RTE_NUMA_ID_ANY);
+		RTE_NUMA_ID_ANY);
 	if (entry == NULL) {
 		rte_errno = ENOMEM;
 		goto err;
diff --git a/drivers/net/mlx5/mlx5_flow_aso.c b/drivers/net/mlx5/mlx5_flow_aso.c
index caaa319d10..47e64ad39c 100644
--- a/drivers/net/mlx5/mlx5_flow_aso.c
+++ b/drivers/net/mlx5/mlx5_flow_aso.c
@@ -52,7 +52,7 @@ mlx5_aso_reg_mr(struct mlx5_common_device *cdev, size_t length,
 	int ret;
 
 	mr->addr = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO, length, 4096,
-			       SOCKET_ID_ANY);
+			       RTE_NUMA_ID_ANY);
 	if (!mr->addr) {
 		DRV_LOG(ERR, "Failed to create ASO bits mem for MR.");
 		return -1;
@@ -241,7 +241,7 @@ mlx5_aso_sq_create(struct mlx5_common_device *cdev, struct mlx5_aso_sq *sq,
 
 	if (mlx5_devx_cq_create(cdev->ctx, &sq->cq.cq_obj,
 				log_desc_n, &cq_attr,
-				SOCKET_ID_ANY))
+				RTE_NUMA_ID_ANY))
 		goto error;
 	sq->cq.cq_ci = 0;
 	sq->cq.log_desc_n = log_desc_n;
@@ -250,7 +250,7 @@ mlx5_aso_sq_create(struct mlx5_common_device *cdev, struct mlx5_aso_sq *sq,
 	/* for mlx5_aso_wqe that is twice the size of mlx5_wqe */
 	log_wqbb_n = sq->log_desc_n + 1;
 	ret = mlx5_devx_sq_create(cdev->ctx, &sq->sq_obj, log_wqbb_n, &sq_attr,
-				  SOCKET_ID_ANY);
+				  RTE_NUMA_ID_ANY);
 	if (ret) {
 		DRV_LOG(ERR, "Can't create SQ object.");
 		rte_errno = ENOMEM;
@@ -303,7 +303,7 @@ mlx5_aso_mtr_queue_init(struct mlx5_dev_ctx_shared *sh,
 	if (hws_pool) {
 		sq = mlx5_malloc(MLX5_MEM_ZERO,
 			sizeof(struct mlx5_aso_sq) * nb_queues,
-			RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+			RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 		if (!sq)
 			return -1;
 		hws_pool->sq = sq;
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 9cb7c59b83..48d36de6ab 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -6863,7 +6863,7 @@ flow_dv_pool_create(struct rte_eth_dev *dev, struct mlx5_devx_obj *dcs,
 	}
 	size += MLX5_COUNTERS_PER_POOL * MLX5_CNT_SIZE;
 	size += (!age ? 0 : MLX5_COUNTERS_PER_POOL * MLX5_AGE_SIZE);
-	pool = mlx5_malloc(MLX5_MEM_ZERO, size, 0, SOCKET_ID_ANY);
+	pool = mlx5_malloc(MLX5_MEM_ZERO, size, 0, RTE_NUMA_ID_ANY);
 	if (!pool) {
 		rte_errno = ENOMEM;
 		return NULL;
@@ -7195,7 +7195,7 @@ flow_dv_mtr_container_resize(struct rte_eth_dev *dev)
 	void *old_pools = pools_mng->pools;
 	uint32_t resize = pools_mng->n + MLX5_MTRS_CONTAINER_RESIZE;
 	uint32_t mem_size = sizeof(struct mlx5_aso_mtr_pool *) * resize;
-	void *pools = mlx5_malloc(MLX5_MEM_ZERO, mem_size, 0, SOCKET_ID_ANY);
+	void *pools = mlx5_malloc(MLX5_MEM_ZERO, mem_size, 0, RTE_NUMA_ID_ANY);
 
 	if (!pools) {
 		rte_errno = ENOMEM;
@@ -7246,7 +7246,7 @@ flow_dv_mtr_pool_create(struct rte_eth_dev *dev, struct mlx5_aso_mtr **mtr_free)
 		rte_errno = ENODATA;
 		return NULL;
 	}
-	pool = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*pool), 0, SOCKET_ID_ANY);
+	pool = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*pool), 0, RTE_NUMA_ID_ANY);
 	if (!pool) {
 		rte_errno = ENOMEM;
 		claim_zero(mlx5_devx_cmd_destroy(dcs));
@@ -10398,7 +10398,7 @@ flow_dev_geneve_tlv_option_resource_register(struct rte_eth_dev *dev,
 		sh->geneve_tlv_option_resource =
 				mlx5_malloc(MLX5_MEM_ZERO,
 						sizeof(*geneve_opt_resource),
-						0, SOCKET_ID_ANY);
+						0, RTE_NUMA_ID_ANY);
 		if (!sh->geneve_tlv_option_resource) {
 			claim_zero(mlx5_devx_cmd_destroy(obj));
 			ret = rte_flow_error_set(error, ENOMEM,
@@ -11782,7 +11782,7 @@ mlx5_flow_matcher_clone_cb(void *tool_ctx __rte_unused,
 							    typeof(*tbl), tbl);
 	struct mlx5_flow_dv_matcher *resource = mlx5_malloc(MLX5_MEM_ANY,
 							    sizeof(*resource),
-							    0, SOCKET_ID_ANY);
+							    0, RTE_NUMA_ID_ANY);
 
 	if (!resource) {
 		rte_flow_error_set(ctx->error, ENOMEM,
@@ -12111,7 +12111,7 @@ mlx5_flow_matcher_create_cb(void *tool_ctx, void *cb_ctx)
 	int ret;
 
 	resource = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*resource), 0,
-			       SOCKET_ID_ANY);
+			       RTE_NUMA_ID_ANY);
 	if (!resource) {
 		rte_flow_error_set(ctx->error, ENOMEM,
 				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
@@ -12993,7 +12993,7 @@ mlx5_flow_dv_dest_array_create_cb(void *tool_ctx __rte_unused, void *cb_ctx)
 		dest_attr[idx] = (struct mlx5dv_dr_action_dest_attr *)
 				 mlx5_malloc(MLX5_MEM_ZERO,
 				 sizeof(struct mlx5dv_dr_action_dest_attr),
-				 0, SOCKET_ID_ANY);
+				 0, RTE_NUMA_ID_ANY);
 		if (!dest_attr[idx]) {
 			rte_flow_error_set(error, ENOMEM,
 					   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
@@ -13641,7 +13641,7 @@ flow_dv_aso_age_pools_resize(struct rte_eth_dev *dev)
 	void *old_pools = mng->pools;
 	uint32_t resize = mng->n + MLX5_ASO_AGE_CONTAINER_RESIZE;
 	uint32_t mem_size = sizeof(struct mlx5_aso_age_pool *) * resize;
-	void *pools = mlx5_malloc(MLX5_MEM_ZERO, mem_size, 0, SOCKET_ID_ANY);
+	void *pools = mlx5_malloc(MLX5_MEM_ZERO, mem_size, 0, RTE_NUMA_ID_ANY);
 
 	if (!pools) {
 		rte_errno = ENOMEM;
@@ -13694,7 +13694,7 @@ flow_dv_age_pool_create(struct rte_eth_dev *dev,
 		DRV_LOG(ERR, "Failed to create flow_hit_aso_obj using DevX.");
 		return NULL;
 	}
-	pool = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*pool), 0, SOCKET_ID_ANY);
+	pool = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*pool), 0, RTE_NUMA_ID_ANY);
 	if (!pool) {
 		claim_zero(mlx5_devx_cmd_destroy(obj));
 		rte_errno = ENOMEM;
@@ -14076,7 +14076,7 @@ flow_dv_aso_ct_pools_resize(struct rte_eth_dev *dev)
 	/* Magic number now, need a macro. */
 	uint32_t resize = mng->n + 64;
 	uint32_t mem_size = sizeof(struct mlx5_aso_ct_pool *) * resize;
-	void *pools = mlx5_malloc(MLX5_MEM_ZERO, mem_size, 0, SOCKET_ID_ANY);
+	void *pools = mlx5_malloc(MLX5_MEM_ZERO, mem_size, 0, RTE_NUMA_ID_ANY);
 
 	if (!pools) {
 		rte_errno = ENOMEM;
@@ -14131,7 +14131,7 @@ flow_dv_ct_pool_create(struct rte_eth_dev *dev,
 	mem_size = sizeof(struct mlx5_aso_ct_action) *
 		   MLX5_ASO_CT_ACTIONS_PER_POOL +
 		   sizeof(*pool);
-	pool = mlx5_malloc(MLX5_MEM_ZERO, mem_size, 0, SOCKET_ID_ANY);
+	pool = mlx5_malloc(MLX5_MEM_ZERO, mem_size, 0, RTE_NUMA_ID_ANY);
 	if (!pool) {
 		rte_errno = ENOMEM;
 		claim_zero(mlx5_devx_cmd_destroy(obj));
@@ -17347,7 +17347,7 @@ __flow_dv_action_rss_update(struct rte_eth_dev *dev, uint32_t idx,
 					  "cannot modify indirection table");
 	queue = mlx5_malloc(MLX5_MEM_ZERO,
 			    RTE_ALIGN_CEIL(queue_size, sizeof(void *)),
-			    0, SOCKET_ID_ANY);
+			    0, RTE_NUMA_ID_ANY);
 	if (!queue)
 		return rte_flow_error_set(error, ENOMEM,
 					  RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
@@ -17885,7 +17885,7 @@ __flow_dv_create_domain_policy_acts(struct rte_eth_dev *dev,
 					  NULL, "Get the wrong "
 					  "rss action struct size");
 				act_cnt->rss = mlx5_malloc(MLX5_MEM_ZERO,
-						rss_size, 0, SOCKET_ID_ANY);
+						rss_size, 0, RTE_NUMA_ID_ANY);
 				if (!act_cnt->rss)
 					return -rte_mtr_error_set(error,
 					  ENOTSUP,
@@ -18631,7 +18631,7 @@ __flow_dv_create_domain_policy_rules(struct rte_eth_dev *dev,
 			continue;
 		color_rule = mlx5_malloc(MLX5_MEM_ZERO,
 				sizeof(struct mlx5_sub_policy_color_rule),
-				0, SOCKET_ID_ANY);
+				0, RTE_NUMA_ID_ANY);
 		if (!color_rule) {
 			DRV_LOG(ERR, "No memory to create color rule.");
 			goto err_exit;
@@ -18913,7 +18913,7 @@ __flow_dv_create_domain_def_policy(struct rte_eth_dev *dev, uint32_t domain)
 	if (!def_policy) {
 		def_policy = mlx5_malloc(MLX5_MEM_ZERO,
 			sizeof(struct mlx5_flow_meter_def_policy),
-			RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+			RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 		if (!def_policy) {
 			DRV_LOG(ERR, "Failed to alloc default policy table.");
 			goto def_policy_error;
@@ -19591,7 +19591,7 @@ flow_dv_meter_hierarchy_rule_create(struct rte_eth_dev *dev,
 			}
 			color_rule = mlx5_malloc(MLX5_MEM_ZERO,
 						 sizeof(struct mlx5_sub_policy_color_rule),
-						 0, SOCKET_ID_ANY);
+						 0, RTE_NUMA_ID_ANY);
 			if (!color_rule) {
 				rte_spinlock_unlock(&mtr_policy->sl);
 				rte_flow_error_set(error, ENOMEM,
diff --git a/drivers/net/mlx5/mlx5_flow_flex.c b/drivers/net/mlx5/mlx5_flow_flex.c
index baa5ddd977..7bac78a7a4 100644
--- a/drivers/net/mlx5/mlx5_flow_flex.c
+++ b/drivers/net/mlx5/mlx5_flow_flex.c
@@ -1478,7 +1478,7 @@ mlx5_flex_parser_create_cb(void *list_ctx, void *ctx)
 	int ret;
 
 	fp = mlx5_malloc(MLX5_MEM_ZERO,	sizeof(struct mlx5_flex_parser_devx),
-			 0, SOCKET_ID_ANY);
+			 0, RTE_NUMA_ID_ANY);
 	if (!fp)
 		return NULL;
 	/* Copy the requested configurations. */
@@ -1551,7 +1551,7 @@ mlx5_flex_parser_clone_cb(void *list_ctx,
 	RTE_SET_USED(list_ctx);
 	RTE_SET_USED(entry);
 	fp = mlx5_malloc(0, sizeof(struct mlx5_flex_parser_devx),
-			 0, SOCKET_ID_ANY);
+			 0, RTE_NUMA_ID_ANY);
 	if (!fp)
 		return NULL;
 	memcpy(fp, ctx, sizeof(struct mlx5_flex_parser_devx));
diff --git a/drivers/net/mlx5/mlx5_flow_geneve.c b/drivers/net/mlx5/mlx5_flow_geneve.c
index 4d57bb763f..5256a73ebc 100644
--- a/drivers/net/mlx5/mlx5_flow_geneve.c
+++ b/drivers/net/mlx5/mlx5_flow_geneve.c
@@ -616,7 +616,7 @@ mlx5_geneve_tlv_options_create(void *ctx,
 
 	options = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE,
 			      sizeof(struct mlx5_geneve_tlv_options),
-			      RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+			      RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	if (options == NULL) {
 		DRV_LOG(ERR,
 			"Failed to allocate memory for GENEVE TLV options.");
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 8dabf21b76..80783ae1ca 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -2420,7 +2420,7 @@ mlx5_tbl_translate_reformat(struct mlx5_priv *priv,
 		shared_rfmt = true;
 	acts->encap_decap = mlx5_malloc(MLX5_MEM_ZERO,
 					sizeof(*acts->encap_decap) + data_size,
-					0, SOCKET_ID_ANY);
+					0, RTE_NUMA_ID_ANY);
 	if (!acts->encap_decap)
 		return rte_flow_error_set(error, ENOMEM,
 					  RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
@@ -2504,7 +2504,7 @@ mlx5_tbl_translate_modify_header(struct rte_eth_dev *dev,
 		return ret;
 	}
 	acts->mhdr = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*acts->mhdr),
-				 0, SOCKET_ID_ANY);
+				 0, RTE_NUMA_ID_ANY);
 	if (!acts->mhdr)
 		return rte_flow_error_set(error, ENOMEM,
 					  RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
@@ -2578,7 +2578,7 @@ mlx5_create_ipv6_ext_reformat(struct rte_eth_dev *dev,
 	flag = mlx5_hw_act_flag[!!attr->group][type];
 	acts->push_remove = mlx5_malloc(MLX5_MEM_ZERO,
 					sizeof(*acts->push_remove) + push_size,
-					0, SOCKET_ID_ANY);
+					0, RTE_NUMA_ID_ANY);
 	if (!acts->push_remove)
 		return -ENOMEM;
 
@@ -5358,7 +5358,7 @@ flow_hw_table_create(struct rte_eth_dev *dev,
 	tbl_mem_size = sizeof(*tbl);
 	tbl_mem_size += nb_action_templates * priv->nb_queue * sizeof(tbl->rule_acts[0]);
 	/* Allocate the table memory. */
-	tbl = mlx5_malloc(MLX5_MEM_ZERO, tbl_mem_size, RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+	tbl = mlx5_malloc(MLX5_MEM_ZERO, tbl_mem_size, RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	if (!tbl)
 		goto error;
 	tbl->cfg = *table_cfg;
@@ -5368,7 +5368,7 @@ flow_hw_table_create(struct rte_eth_dev *dev,
 		goto error;
 	/* Allocate table of auxiliary flow rule structs. */
 	tbl->flow_aux = mlx5_malloc(MLX5_MEM_ZERO, sizeof(struct rte_flow_hw_aux) * nb_flows,
-				    RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+				    RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	if (!tbl->flow_aux)
 		goto error;
 	/* Register the flow group. */
@@ -8275,7 +8275,7 @@ __flow_hw_actions_template_create(struct rte_eth_dev *dev,
 		return NULL;
 	len += RTE_ALIGN(orig_act_len, 16);
 	at = mlx5_malloc(MLX5_MEM_ZERO, len + sizeof(*at),
-			 RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+			 RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	if (!at) {
 		rte_flow_error_set(error, ENOMEM,
 				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
@@ -8484,7 +8484,7 @@ flow_hw_prepend_item(const struct rte_flow_item *items,
 	header_size = sizeof(*copied_items) * (nb_items + 1);
 	total_size = header_size + (size_t)new_item_size;
 
-	copied_items = mlx5_malloc(MLX5_MEM_ZERO, total_size, 0, SOCKET_ID_ANY);
+	copied_items = mlx5_malloc(MLX5_MEM_ZERO, total_size, 0, RTE_NUMA_ID_ANY);
 	if (!copied_items) {
 		rte_flow_error_set(error, ENOMEM,
 				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
@@ -9490,7 +9490,7 @@ flow_hw_pattern_template_create(struct rte_eth_dev *dev,
 	if (!tmpl_items)
 		return NULL;
 
-	it = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*it), 0, SOCKET_ID_ANY);
+	it = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*it), 0, RTE_NUMA_ID_ANY);
 	if (!it) {
 		rte_flow_error_set(error, ENOMEM,
 				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
@@ -9510,7 +9510,7 @@ flow_hw_pattern_template_create(struct rte_eth_dev *dev,
 		goto error;
 	}
 	it_items_size = RTE_ALIGN(it_items_size, 16);
-	it->items = mlx5_malloc(MLX5_MEM_ZERO, it_items_size, 0, SOCKET_ID_ANY);
+	it->items = mlx5_malloc(MLX5_MEM_ZERO, it_items_size, 0, RTE_NUMA_ID_ANY);
 	if (it->items == NULL) {
 		rte_flow_error_set(error, ENOMEM,
 				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
@@ -10006,7 +10006,7 @@ flow_hw_create_vport_actions(struct mlx5_priv *priv)
 	bool unified_fdb = is_unified_fdb(priv);
 	priv->hw_vport = mlx5_malloc(MLX5_MEM_ZERO,
 				     sizeof(*priv->hw_vport) * RTE_MAX_ETHPORTS,
-				     0, SOCKET_ID_ANY);
+				     0, RTE_NUMA_ID_ANY);
 	if (!priv->hw_vport)
 		return -ENOMEM;
 	DRV_LOG(DEBUG, "port %u :: creating vport actions", priv->dev_data->port_id);
@@ -11106,7 +11106,7 @@ flow_hw_create_lacp_miss_tables(struct rte_eth_dev *dev)
 	if (mlx5_flow_is_steering_disabled())
 		return 0;
 
-	hw_lacp_miss = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*hw_lacp_miss), 0, SOCKET_ID_ANY);
+	hw_lacp_miss = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*hw_lacp_miss), 0, RTE_NUMA_ID_ANY);
 	if (!hw_lacp_miss) {
 		DRV_LOG(ERR, "port %u Failed to allocate memory for LACP miss tables",
 			dev->data->port_id);
@@ -11162,7 +11162,7 @@ flow_hw_create_fdb_ctrl_tables(struct rte_eth_dev *dev, struct rte_flow_error *e
 	uint32_t fdb_def_rule = priv->sh->config.fdb_def_rule;
 
 	MLX5_ASSERT(priv->hw_ctrl_fdb == NULL);
-	hw_ctrl_fdb = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*hw_ctrl_fdb), 0, SOCKET_ID_ANY);
+	hw_ctrl_fdb = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*hw_ctrl_fdb), 0, RTE_NUMA_ID_ANY);
 	if (!hw_ctrl_fdb) {
 		DRV_LOG(ERR, "port %u failed to allocate memory for FDB control flow templates",
 			dev->data->port_id);
@@ -11275,7 +11275,7 @@ flow_hw_create_nic_ctrl_tables(struct rte_eth_dev *dev, struct rte_flow_error *e
 	struct mlx5_priv *priv = dev->data->dev_private;
 
 	struct mlx5_flow_hw_ctrl_nic *ctrl = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*ctrl),
-							 0, SOCKET_ID_ANY);
+							 0, RTE_NUMA_ID_ANY);
 	if (!ctrl)
 		return rte_flow_error_set(error, ENOMEM, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
 					  "failed to allocate port control flow table");
@@ -11350,7 +11350,7 @@ flow_hw_ct_pool_create(struct rte_eth_dev *dev,
 	int reg_id;
 	uint32_t flags = 0;
 
-	pool = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*pool), 0, SOCKET_ID_ANY);
+	pool = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*pool), 0, RTE_NUMA_ID_ANY);
 	if (!pool) {
 		rte_errno = ENOMEM;
 		return NULL;
@@ -11426,7 +11426,7 @@ mlx5_flow_ct_init(struct rte_eth_dev *dev,
 				sizeof(*priv->ct_mng);
 		priv->ct_mng = mlx5_malloc(MLX5_MEM_ZERO, mem_size,
 						RTE_CACHE_LINE_SIZE,
-						SOCKET_ID_ANY);
+						RTE_NUMA_ID_ANY);
 		if (!priv->ct_mng)
 			goto err;
 		ret = mlx5_aso_ct_queue_init(priv->sh, priv->ct_mng,
@@ -11763,7 +11763,7 @@ mlx5_flow_hw_create_ctrl_rx_tables(struct rte_eth_dev *dev)
 
 	MLX5_ASSERT(!priv->hw_ctrl_rx);
 	priv->hw_ctrl_rx = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*priv->hw_ctrl_rx),
-				       RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+				       RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	if (!priv->hw_ctrl_rx) {
 		DRV_LOG(ERR, "Failed to allocate memory for Rx control flow tables");
 		rte_errno = ENOMEM;
@@ -11853,7 +11853,7 @@ flow_hw_alloc_copy_config(const struct rte_flow_port_attr *port_attr,
 	unsigned int i;
 
 	hw_attr_size = sizeof(*hw_attr) + nb_queue * sizeof(*hw_attr->queue_attr);
-	hw_attr = mlx5_malloc(MLX5_MEM_ZERO, hw_attr_size, 0, SOCKET_ID_ANY);
+	hw_attr = mlx5_malloc(MLX5_MEM_ZERO, hw_attr_size, 0, RTE_NUMA_ID_ANY);
 	if (!hw_attr) {
 		rte_flow_error_set(error, ENOMEM, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
 				   "Not enough memory to store configuration");
@@ -12078,7 +12078,7 @@ mlx5_hwq_ring_create(uint16_t port_id, uint32_t queue, uint32_t size, const char
 	char mz_name[RTE_MEMZONE_NAMESIZE];
 
 	snprintf(mz_name, sizeof(mz_name), "port_%u_%s_%u", port_id, str, queue);
-	return rte_ring_create(mz_name, size, SOCKET_ID_ANY,
+	return rte_ring_create(mz_name, size, RTE_NUMA_ID_ANY,
 			       RING_F_SP_ENQ | RING_F_SC_DEQ | RING_F_EXACT_SZ);
 }
 
@@ -12266,7 +12266,7 @@ __flow_hw_configure(struct rte_eth_dev *dev,
 	_queue_attr = mlx5_malloc(MLX5_MEM_ZERO,
 				  nb_q_updated *
 				  sizeof(struct rte_flow_queue_attr *),
-				  64, SOCKET_ID_ANY);
+				  64, RTE_NUMA_ID_ANY);
 	if (!_queue_attr) {
 		rte_errno = ENOMEM;
 		goto err;
@@ -12284,7 +12284,7 @@ __flow_hw_configure(struct rte_eth_dev *dev,
 			     sizeof(struct mlx5_hw_q_job)) * _queue_attr[i]->size;
 	}
 	priv->hw_q = mlx5_malloc(MLX5_MEM_ZERO, mem_size,
-				 64, SOCKET_ID_ANY);
+				 64, RTE_NUMA_ID_ANY);
 	if (!priv->hw_q) {
 		rte_errno = ENOMEM;
 		goto err;
@@ -14958,7 +14958,7 @@ mlx5_hw_create_mirror(struct rte_eth_dev *dev,
 		return NULL;
 	}
 	mirror = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*mirror),
-			     0, SOCKET_ID_ANY);
+			     0, RTE_NUMA_ID_ANY);
 	if (!mirror) {
 		rte_flow_error_set(error, ENOMEM, RTE_FLOW_ERROR_TYPE_ACTION,
 				   actions, "Failed to allocate mirror context");
@@ -15040,7 +15040,7 @@ mlx5_create_legacy_indlst(struct rte_eth_dev *dev, uint32_t queue,
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_indlst_legacy *indlst_obj = mlx5_malloc(MLX5_MEM_ZERO,
 							    sizeof(*indlst_obj),
-							    0, SOCKET_ID_ANY);
+							    0, RTE_NUMA_ID_ANY);
 
 	if (!indlst_obj)
 		return NULL;
@@ -15835,7 +15835,7 @@ flow_hw_create_ctrl_flow(struct rte_eth_dev *owner_dev,
 
 	rte_spinlock_lock(&priv->hw_ctrl_lock);
 	entry = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_SYS, sizeof(*entry),
-			    0, SOCKET_ID_ANY);
+			    0, RTE_NUMA_ID_ANY);
 	if (!entry) {
 		DRV_LOG(ERR, "port %u not enough memory to create control flows",
 			proxy_dev->data->port_id);
@@ -17131,7 +17131,7 @@ __mlx5_reformat_create(struct rte_eth_dev *dev,
 		return NULL;
 	}
 	/* Allocate new list entry. */
-	handle = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*handle), 0, SOCKET_ID_ANY);
+	handle = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*handle), 0, RTE_NUMA_ID_ANY);
 	if (!handle) {
 		DRV_LOG(ERR, "Reformat: failed to allocate reformat entry");
 		return NULL;
diff --git a/drivers/net/mlx5/mlx5_flow_meter.c b/drivers/net/mlx5/mlx5_flow_meter.c
index 6d30f31852..8acd6f0944 100644
--- a/drivers/net/mlx5/mlx5_flow_meter.c
+++ b/drivers/net/mlx5/mlx5_flow_meter.c
@@ -95,7 +95,7 @@ mlx5_flow_meter_init_guest(struct rte_eth_dev *dev)
 		goto err;
 	}
 	priv->hws_mpool = mlx5_malloc(MLX5_MEM_ZERO, sizeof(struct mlx5_aso_mtr_pool),
-				      RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+				      RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	if (!priv->hws_mpool) {
 		rte_errno = ENOMEM;
 		ret = -rte_errno;
@@ -217,7 +217,7 @@ mlx5_flow_meter_init(struct rte_eth_dev *dev,
 					 sizeof(struct mlx5_aso_mtr) *
 					 nb_meters,
 					 RTE_CACHE_LINE_SIZE,
-					 SOCKET_ID_ANY);
+					 RTE_NUMA_ID_ANY);
 	if (!priv->mtr_bulk.aso) {
 		ret = ENOMEM;
 		rte_flow_error_set(&error, ENOMEM,
@@ -235,7 +235,7 @@ mlx5_flow_meter_init(struct rte_eth_dev *dev,
 	}
 	priv->hws_mpool = mlx5_malloc(MLX5_MEM_ZERO,
 				sizeof(struct mlx5_aso_mtr_pool),
-				RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+				RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	if (!priv->hws_mpool) {
 		ret = ENOMEM;
 		rte_flow_error_set(&error, ENOMEM,
@@ -273,7 +273,7 @@ mlx5_flow_meter_init(struct rte_eth_dev *dev,
 				    sizeof(struct mlx5_flow_meter_profile) *
 				    nb_meter_profiles,
 				    RTE_CACHE_LINE_SIZE,
-				    SOCKET_ID_ANY);
+				    RTE_NUMA_ID_ANY);
 		if (!priv->mtr_profile_arr) {
 			ret = ENOMEM;
 			rte_flow_error_set(&error, ENOMEM,
@@ -289,7 +289,7 @@ mlx5_flow_meter_init(struct rte_eth_dev *dev,
 				    sizeof(struct mlx5_flow_meter_policy) *
 				    nb_meter_policies,
 				    RTE_CACHE_LINE_SIZE,
-				    SOCKET_ID_ANY);
+				    RTE_NUMA_ID_ANY);
 		if (!priv->mtr_policy_arr) {
 			ret = ENOMEM;
 			rte_flow_error_set(&error, ENOMEM,
@@ -829,7 +829,7 @@ mlx5_flow_meter_profile_add(struct rte_eth_dev *dev,
 		return ret;
 	/* Meter profile memory allocation. */
 	fmp = mlx5_malloc(MLX5_MEM_ZERO, sizeof(struct mlx5_flow_meter_profile),
-			  RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+			  RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	if (fmp == NULL)
 		return -rte_mtr_error_set(error, ENOMEM,
 					  RTE_MTR_ERROR_TYPE_UNSPECIFIED,
@@ -1317,7 +1317,7 @@ mlx5_flow_meter_policy_add(struct rte_eth_dev *dev,
 		policy_size += sizeof(struct mlx5_flow_meter_sub_policy *);
 	}
 	mtr_policy = mlx5_malloc(MLX5_MEM_ZERO, policy_size,
-				 RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+				 RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	if (!mtr_policy)
 		return -rte_mtr_error_set(error, ENOMEM,
 				RTE_MTR_ERROR_TYPE_METER_POLICY, NULL,
diff --git a/drivers/net/mlx5/mlx5_flow_quota.c b/drivers/net/mlx5/mlx5_flow_quota.c
index b661bd376e..9a78b9a778 100644
--- a/drivers/net/mlx5/mlx5_flow_quota.c
+++ b/drivers/net/mlx5/mlx5_flow_quota.c
@@ -391,7 +391,7 @@ mlx5_quota_alloc_sq(struct mlx5_priv *priv)
 
 	qctx->sq = mlx5_malloc(MLX5_MEM_ZERO,
 			       sizeof(qctx->sq[0]) * nb_queues,
-			       0, SOCKET_ID_ANY);
+			       0, RTE_NUMA_ID_ANY);
 	if (!qctx->sq) {
 		DRV_LOG(DEBUG, "QUOTA: failed to allocate SQ pool");
 		return -ENOMEM;
@@ -440,7 +440,7 @@ mlx5_quota_alloc_read_buf(struct mlx5_priv *priv)
 	/* ACCESS MTR ASO WQE reads 2 MTR objects */
 	rd_buf_size = 2 * sq_size_sum * sizeof(buf[0]);
 	buf = mlx5_malloc(MLX5_MEM_ANY | MLX5_MEM_ZERO, rd_buf_size,
-			  page_size, SOCKET_ID_ANY);
+			  page_size, RTE_NUMA_ID_ANY);
 	if (!buf) {
 		DRV_LOG(DEBUG, "QUOTA: failed to allocate MTR ASO READ buffer [1]");
 		return -ENOMEM;
@@ -452,7 +452,7 @@ mlx5_quota_alloc_read_buf(struct mlx5_priv *priv)
 	}
 	qctx->read_buf = mlx5_malloc(MLX5_MEM_ZERO,
 				     sizeof(qctx->read_buf[0]) * nb_queues,
-				     0, SOCKET_ID_ANY);
+				     0, RTE_NUMA_ID_ANY);
 	if (!qctx->read_buf) {
 		DRV_LOG(DEBUG, "QUOTA: failed to allocate MTR ASO READ buffer [2]");
 		return -ENOMEM;
diff --git a/drivers/net/mlx5/mlx5_flow_verbs.c b/drivers/net/mlx5/mlx5_flow_verbs.c
index eb576f73d4..d20c02b2ff 100644
--- a/drivers/net/mlx5/mlx5_flow_verbs.c
+++ b/drivers/net/mlx5/mlx5_flow_verbs.c
@@ -250,7 +250,7 @@ flow_verbs_counter_new(struct rte_eth_dev *dev, uint32_t id __rte_unused)
 		}
 		/* Allocate memory for new pool */
 		size = sizeof(*pool) + sizeof(*cnt) * MLX5_COUNTERS_PER_POOL;
-		pool = mlx5_malloc(MLX5_MEM_ZERO, size, 0, SOCKET_ID_ANY);
+		pool = mlx5_malloc(MLX5_MEM_ZERO, size, 0, RTE_NUMA_ID_ANY);
 		if (!pool)
 			return 0;
 		for (i = 0; i < MLX5_COUNTERS_PER_POOL; ++i) {
diff --git a/drivers/net/mlx5/mlx5_hws_cnt.c b/drivers/net/mlx5/mlx5_hws_cnt.c
index d0c4ead71b..15069d0a4a 100644
--- a/drivers/net/mlx5/mlx5_hws_cnt.c
+++ b/drivers/net/mlx5/mlx5_hws_cnt.c
@@ -30,7 +30,7 @@ __hws_cnt_id_load(struct mlx5_hws_cnt_pool *cpool)
 	cnt_id_t *cnt_arr = NULL;
 
 	cnt_arr = mlx5_malloc(MLX5_MEM_ANY | MLX5_MEM_ZERO,
-			      cnt_num * sizeof(cnt_id_t), 0, SOCKET_ID_ANY);
+			      cnt_num * sizeof(cnt_id_t), 0, RTE_NUMA_ID_ANY);
 	if (cnt_arr == NULL)
 		return -ENOMEM;
 	/*
@@ -280,7 +280,7 @@ mlx5_hws_cnt_raw_data_alloc(struct mlx5_dev_ctx_shared *sh, uint32_t n,
 
 	MLX5_ASSERT(pgsz > 0);
 	mng = mlx5_malloc(MLX5_MEM_ANY | MLX5_MEM_ZERO, sizeof(*mng), 0,
-			SOCKET_ID_ANY);
+			RTE_NUMA_ID_ANY);
 	if (mng == NULL) {
 		rte_flow_error_set(error, ENOMEM,
 				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
@@ -288,7 +288,7 @@ mlx5_hws_cnt_raw_data_alloc(struct mlx5_dev_ctx_shared *sh, uint32_t n,
 		goto error;
 	}
 	mng->raw = mlx5_malloc(MLX5_MEM_ANY | MLX5_MEM_ZERO, sz, pgsz,
-			SOCKET_ID_ANY);
+			RTE_NUMA_ID_ANY);
 	if (mng->raw == NULL) {
 		rte_flow_error_set(error, ENOMEM,
 				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
@@ -389,7 +389,7 @@ mlx5_hws_cnt_cache_init(const struct mlx5_hws_cnt_pool_cfg *pcfg,
 	cache = mlx5_malloc(MLX5_MEM_ANY | MLX5_MEM_ZERO,
 			sizeof(*cache) +
 			sizeof(((struct mlx5_hws_cnt_pool_caches *)0)->qcache[0])
-				* ccfg->q_num, 0, SOCKET_ID_ANY);
+				* ccfg->q_num, 0, RTE_NUMA_ID_ANY);
 	if (cache == NULL)
 		return NULL;
 	/* Store the necessary cache parameters. */
@@ -400,7 +400,7 @@ mlx5_hws_cnt_cache_init(const struct mlx5_hws_cnt_pool_cfg *pcfg,
 	for (qidx = 0; qidx < ccfg->q_num; qidx++) {
 		snprintf(mz_name, sizeof(mz_name), "%s_qc/%x", pcfg->name, qidx);
 		cache->qcache[qidx] = rte_ring_create(mz_name, ccfg->size,
-				SOCKET_ID_ANY,
+				RTE_NUMA_ID_ANY,
 				RING_F_SP_ENQ | RING_F_SC_DEQ |
 				RING_F_EXACT_SZ);
 		if (cache->qcache[qidx] == NULL)
@@ -428,7 +428,7 @@ mlx5_hws_cnt_pool_init(struct mlx5_dev_ctx_shared *sh,
 	MLX5_ASSERT(pcfg);
 	MLX5_ASSERT(ccfg);
 	cntp = mlx5_malloc(MLX5_MEM_ANY | MLX5_MEM_ZERO, sizeof(*cntp), 0,
-			   SOCKET_ID_ANY);
+			   RTE_NUMA_ID_ANY);
 	if (cntp == NULL) {
 		rte_flow_error_set(error, ENOMEM,
 				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
@@ -467,7 +467,7 @@ mlx5_hws_cnt_pool_init(struct mlx5_dev_ctx_shared *sh,
 	cnt_num = RTE_MIN((uint32_t)cnt_num, sh->hws_max_nb_counters);
 	cntp->pool = mlx5_malloc(MLX5_MEM_ANY | MLX5_MEM_ZERO,
 				 sizeof(struct mlx5_hws_cnt) * cnt_num,
-				 0, SOCKET_ID_ANY);
+				 0, RTE_NUMA_ID_ANY);
 	if (cntp->pool == NULL) {
 		rte_flow_error_set(error, ENOMEM,
 				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
@@ -476,7 +476,7 @@ mlx5_hws_cnt_pool_init(struct mlx5_dev_ctx_shared *sh,
 	}
 	snprintf(mz_name, sizeof(mz_name), "%s_F_RING", pcfg->name);
 	cntp->free_list = rte_ring_create_elem(mz_name, sizeof(cnt_id_t),
-				(uint32_t)cnt_num, SOCKET_ID_ANY,
+				(uint32_t)cnt_num, RTE_NUMA_ID_ANY,
 				RING_F_MP_HTS_ENQ | RING_F_MC_HTS_DEQ |
 				RING_F_EXACT_SZ);
 	if (cntp->free_list == NULL) {
@@ -487,7 +487,7 @@ mlx5_hws_cnt_pool_init(struct mlx5_dev_ctx_shared *sh,
 	}
 	snprintf(mz_name, sizeof(mz_name), "%s_R_RING", pcfg->name);
 	cntp->wait_reset_list = rte_ring_create_elem(mz_name, sizeof(cnt_id_t),
-			(uint32_t)cnt_num, SOCKET_ID_ANY,
+			(uint32_t)cnt_num, RTE_NUMA_ID_ANY,
 			RING_F_MP_HTS_ENQ | RING_F_SC_DEQ | RING_F_EXACT_SZ);
 	if (cntp->wait_reset_list == NULL) {
 		rte_flow_error_set(error, ENOMEM,
@@ -497,7 +497,7 @@ mlx5_hws_cnt_pool_init(struct mlx5_dev_ctx_shared *sh,
 	}
 	snprintf(mz_name, sizeof(mz_name), "%s_U_RING", pcfg->name);
 	cntp->reuse_list = rte_ring_create_elem(mz_name, sizeof(cnt_id_t),
-			(uint32_t)cnt_num, SOCKET_ID_ANY,
+			(uint32_t)cnt_num, RTE_NUMA_ID_ANY,
 			RING_F_MP_HTS_ENQ | RING_F_MC_HTS_DEQ | RING_F_EXACT_SZ);
 	if (cntp->reuse_list == NULL) {
 		rte_flow_error_set(error, ENOMEM,
@@ -734,7 +734,7 @@ mlx5_hws_cnt_pool_create(struct rte_eth_dev *dev,
 	int ret = 0;
 	size_t sz;
 
-	mp_name = mlx5_malloc(MLX5_MEM_ZERO, RTE_MEMZONE_NAMESIZE, 0, SOCKET_ID_ANY);
+	mp_name = mlx5_malloc(MLX5_MEM_ZERO, RTE_MEMZONE_NAMESIZE, 0, RTE_NUMA_ID_ANY);
 	if (mp_name == NULL) {
 		ret = rte_flow_error_set(error, ENOMEM, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
 					 "failed to allocate counter pool name prefix");
@@ -853,7 +853,7 @@ mlx5_hws_cnt_svc_init(struct mlx5_dev_ctx_shared *sh,
 	int ret;
 
 	sh->cnt_svc = mlx5_malloc(MLX5_MEM_ANY | MLX5_MEM_ZERO,
-			sizeof(*sh->cnt_svc), 0, SOCKET_ID_ANY);
+			sizeof(*sh->cnt_svc), 0, RTE_NUMA_ID_ANY);
 	if (sh->cnt_svc == NULL)
 		goto err;
 	sh->cnt_svc->query_interval = sh->config.cnt_svc.cycle_time;
@@ -1225,14 +1225,14 @@ mlx5_hws_age_info_init(struct rte_eth_dev *dev, uint16_t nb_queues,
 			      sizeof(struct rte_ring *) * nb_queues;
 
 		age_info->hw_q_age = mlx5_malloc(MLX5_MEM_ANY | MLX5_MEM_ZERO,
-						 size, 0, SOCKET_ID_ANY);
+						 size, 0, RTE_NUMA_ID_ANY);
 		if (age_info->hw_q_age == NULL)
 			return -ENOMEM;
 		for (qidx = 0; qidx < nb_queues; ++qidx) {
 			snprintf(mz_name, sizeof(mz_name),
 				 "port_%u_queue_%u_aged_out_ring",
 				 dev->data->port_id, qidx);
-			r = rte_ring_create(mz_name, ring_size, SOCKET_ID_ANY,
+			r = rte_ring_create(mz_name, ring_size, RTE_NUMA_ID_ANY,
 					    flags);
 			if (r == NULL) {
 				DRV_LOG(ERR, "\"%s\" creation failed: %s",
@@ -1248,7 +1248,7 @@ mlx5_hws_age_info_init(struct rte_eth_dev *dev, uint16_t nb_queues,
 	} else {
 		snprintf(mz_name, sizeof(mz_name), "port_%u_aged_out_ring",
 			 dev->data->port_id);
-		r = rte_ring_create(mz_name, ring_size, SOCKET_ID_ANY, flags);
+		r = rte_ring_create(mz_name, ring_size, RTE_NUMA_ID_ANY, flags);
 		if (r == NULL) {
 			DRV_LOG(ERR, "\"%s\" creation failed: %s", mz_name,
 				rte_strerror(rte_errno));
diff --git a/drivers/net/mlx5/mlx5_nta_sample.c b/drivers/net/mlx5/mlx5_nta_sample.c
index 158720fb87..8bdbec8c89 100644
--- a/drivers/net/mlx5/mlx5_nta_sample.c
+++ b/drivers/net/mlx5/mlx5_nta_sample.c
@@ -164,7 +164,7 @@ mlx5_nta_sample_cached_mirror_create(void *cache_ctx, void *cb_ctx)
 	};
 	struct mlx5_nta_sample_cached_mirror *obj = mlx5_malloc(MLX5_MEM_ANY,
 								sizeof(*obj), 0,
-								SOCKET_ID_ANY);
+								RTE_NUMA_ID_ANY);
 	if (obj == NULL)
 		return NULL;
 	obj->mirror = mlx5_hw_create_mirror(dev, ctx->table_cfg, mirror_actions, NULL);
@@ -187,7 +187,7 @@ mlx5_nta_sample_cached_mirror_clone(void *tool_ctx __rte_unused,
 		container_of(entry, struct mlx5_nta_sample_cached_mirror, entry);
 	struct mlx5_nta_sample_cached_mirror *new_obj = mlx5_malloc(MLX5_MEM_ANY,
 								    sizeof(*new_obj), 0,
-								    SOCKET_ID_ANY);
+								    RTE_NUMA_ID_ANY);
 
 	if (new_obj == NULL)
 		return NULL;
@@ -245,7 +245,7 @@ serialize_actions(struct mlx5_nta_sample_cached_group_ctx *obj_ctx)
 		int size = rte_flow_conv(RTE_FLOW_CONV_OP_ACTIONS, NULL, 0, obj_ctx->actions, NULL);
 		if (size < 0)
 			return size;
-		tgt_buffer = mlx5_malloc(MLX5_MEM_ANY, size, 0, SOCKET_ID_ANY);
+		tgt_buffer = mlx5_malloc(MLX5_MEM_ANY, size, 0, RTE_NUMA_ID_ANY);
 		if (tgt_buffer == NULL)
 			return -ENOMEM;
 		obj_ctx->actions_size = size;
@@ -270,7 +270,7 @@ mlx5_nta_sample_cached_group_create(void *cache_ctx, void *cb_ctx)
 
 	if (actions_size < 0)
 		return NULL;
-	obj = mlx5_malloc(MLX5_MEM_ANY, sizeof(*obj), 0, SOCKET_ID_ANY);
+	obj = mlx5_malloc(MLX5_MEM_ANY, sizeof(*obj), 0, RTE_NUMA_ID_ANY);
 	if (obj == NULL)
 		return NULL;
 	obj->group = alloc_cached_group(dev);
@@ -319,7 +319,7 @@ mlx5_nta_sample_cached_group_clone(void *tool_ctx __rte_unused,
 		container_of(entry, struct mlx5_nta_sample_cached_group, entry);
 	struct mlx5_nta_sample_cached_group *new_obj;
 
-	new_obj = mlx5_malloc(MLX5_MEM_ANY, sizeof(*new_obj), 0, SOCKET_ID_ANY);
+	new_obj = mlx5_malloc(MLX5_MEM_ANY, sizeof(*new_obj), 0, RTE_NUMA_ID_ANY);
 	if (new_obj == NULL)
 		return NULL;
 	memcpy(new_obj, cached_obj, sizeof(*new_obj));
@@ -351,7 +351,7 @@ mlx5_init_nta_sample_context(struct rte_eth_dev *dev)
 		.type = "mlx5_nta_sample"
 	};
 	struct mlx5_nta_sample_ctx *ctx = mlx5_malloc(MLX5_MEM_ZERO,
-						      sizeof(*ctx), 0, SOCKET_ID_ANY);
+						      sizeof(*ctx), 0, RTE_NUMA_ID_ANY);
 
 	if (ctx == NULL)
 		return -ENOMEM;
@@ -744,7 +744,7 @@ mlx5_nta_create_sample_flow(struct rte_eth_dev *dev,
 
 	if (sample_group == 0)
 		return NULL;
-	release = mlx5_malloc(MLX5_MEM_ANY, sizeof(*release), 0, SOCKET_ID_ANY);
+	release = mlx5_malloc(MLX5_MEM_ANY, sizeof(*release), 0, RTE_NUMA_ID_ANY);
 	if (release == NULL) {
 		rte_flow_error_set(error, ENOMEM, RTE_FLOW_ERROR_TYPE_ACTION,
 				   NULL, "Failed to allocate release context");
@@ -804,7 +804,7 @@ mlx5_nta_create_mirror_flow(struct rte_eth_dev *dev,
 	int ret;
 	struct rte_flow_hw *base_flow = NULL;
 	struct mlx5_sample_release_ctx *release = mlx5_malloc(MLX5_MEM_ANY, sizeof(*release),
-							      0, SOCKET_ID_ANY);
+							      0, RTE_NUMA_ID_ANY);
 
 	if (release == NULL) {
 		rte_flow_error_set(error, ENOMEM, RTE_FLOW_ERROR_TYPE_ACTION,
diff --git a/drivers/net/mlx5/mlx5_nta_split.c b/drivers/net/mlx5/mlx5_nta_split.c
index 327930ecb8..f870e0e38a 100644
--- a/drivers/net/mlx5/mlx5_nta_split.c
+++ b/drivers/net/mlx5/mlx5_nta_split.c
@@ -227,7 +227,7 @@ mlx5_flow_nta_split_metadata(struct rte_eth_dev *dev,
 	item_size = sizeof(struct rte_flow_item) * 2 +
 		    sizeof(struct mlx5_rte_flow_item_tag);
 	total_size = pefx_act_size + sfx_act_size + attr_size + item_size;
-	prfx_actions = mlx5_malloc(MLX5_MEM_ZERO, total_size, 0, SOCKET_ID_ANY);
+	prfx_actions = mlx5_malloc(MLX5_MEM_ZERO, total_size, 0, RTE_NUMA_ID_ANY);
 	if (!prfx_actions)
 		return rte_flow_error_set(error, ENOMEM,
 					  RTE_FLOW_ERROR_TYPE_ACTION,
diff --git a/drivers/net/mlx5/mlx5_rss.c b/drivers/net/mlx5/mlx5_rss.c
index e2b478b75c..a2ecd8df8c 100644
--- a/drivers/net/mlx5/mlx5_rss.c
+++ b/drivers/net/mlx5/mlx5_rss.c
@@ -53,7 +53,7 @@ mlx5_rss_hash_update(struct rte_eth_dev *dev,
 		priv->rss_conf.rss_key = mlx5_realloc(priv->rss_conf.rss_key,
 						      MLX5_MEM_RTE,
 						      rss_conf->rss_key_len,
-						      0, SOCKET_ID_ANY);
+						      0, RTE_NUMA_ID_ANY);
 		if (!priv->rss_conf.rss_key) {
 			rte_errno = ENOMEM;
 			return -rte_errno;
@@ -130,7 +130,7 @@ mlx5_rss_reta_index_resize(struct rte_eth_dev *dev, unsigned int reta_size)
 
 	mem = mlx5_realloc(priv->reta_idx, MLX5_MEM_RTE,
 			   reta_size * sizeof((*priv->reta_idx)[0]), 0,
-			   SOCKET_ID_ANY);
+			   RTE_NUMA_ID_ANY);
 	if (!mem) {
 		rte_errno = ENOMEM;
 		return -rte_errno;
diff --git a/drivers/net/mlx5/mlx5_rxq.c b/drivers/net/mlx5/mlx5_rxq.c
index e525cc853d..72f96ba3ad 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -3277,8 +3277,8 @@ mlx5_drop_action_create(struct rte_eth_dev *dev)
 
 	if (priv->drop_queue.hrxq)
 		return priv->drop_queue.hrxq;
-	hrxq = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*hrxq) + MLX5_RSS_HASH_KEY_LEN,
-			0, RTE_NUMA_ID_ANY);
+	hrxq = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*hrxq) + MLX5_RSS_HASH_KEY_LEN, 0,
+		RTE_NUMA_ID_ANY);
 	if (!hrxq) {
 		DRV_LOG(WARNING,
 			"Port %u cannot allocate memory for drop queue.",
diff --git a/drivers/net/mlx5/mlx5_stats.c b/drivers/net/mlx5/mlx5_stats.c
index 1fbd298c77..5fb6c12d11 100644
--- a/drivers/net/mlx5/mlx5_stats.c
+++ b/drivers/net/mlx5/mlx5_stats.c
@@ -354,7 +354,7 @@ mlx5_xstats_reset(struct rte_eth_dev *dev)
 		mlx5_os_stats_init(dev);
 	/* Considering to use stack directly. */
 	counters = mlx5_malloc(MLX5_MEM_SYS, sizeof(*counters) * xstats_ctrl->mlx5_stats_n,
-			       0, SOCKET_ID_ANY);
+			       0, RTE_NUMA_ID_ANY);
 	if (!counters) {
 		DRV_LOG(WARNING, "port %u unable to allocate memory for xstats counters",
 		     dev->data->port_id);
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 1dbde509d2..65d403b9e9 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -126,7 +126,7 @@ mlx5_alloc_null_mbuf(uint32_t data_len)
 		rte_align32pow2(data_len);
 	struct rte_mbuf *m;
 
-	m = mlx5_malloc(MLX5_MEM_ZERO, alloc_size, 0, SOCKET_ID_ANY);
+	m = mlx5_malloc(MLX5_MEM_ZERO, alloc_size, 0, RTE_NUMA_ID_ANY);
 	if (m == NULL)
 		return NULL;
 	m->buf_addr = RTE_PTR_ADD(m, sizeof(*m));
diff --git a/drivers/net/mlx5/mlx5_tx.c b/drivers/net/mlx5/mlx5_tx.c
index 89e38091b4..7069e69b5e 100644
--- a/drivers/net/mlx5/mlx5_tx.c
+++ b/drivers/net/mlx5/mlx5_tx.c
@@ -908,7 +908,7 @@ int rte_pmd_mlx5_pp_rate_table_query(uint16_t port_id,
 		return 0;
 	}
 	seen = mlx5_malloc(MLX5_MEM_SYS | MLX5_MEM_ZERO,
-			   priv->txqs_n * sizeof(*seen), 0, SOCKET_ID_ANY);
+			   priv->txqs_n * sizeof(*seen), 0, RTE_NUMA_ID_ANY);
 	if (seen == NULL)
 		return -ENOMEM;
 	/*
diff --git a/drivers/net/mlx5/mlx5_utils.c b/drivers/net/mlx5/mlx5_utils.c
index 606743c4b7..45e1c50aeb 100644
--- a/drivers/net/mlx5/mlx5_utils.c
+++ b/drivers/net/mlx5/mlx5_utils.c
@@ -18,8 +18,8 @@
 	uint32_t a = (uint32_t)(align); \
 	int so = (int)(socket); \
 	void *mem = p->cfg.malloc(f, s, a, so); \
-	if (mem == NULL && so != SOCKET_ID_ANY) { \
-		mem = p->cfg.malloc(f, s, a, SOCKET_ID_ANY); \
+	if (mem == NULL && so != RTE_NUMA_ID_ANY) { \
+		mem = p->cfg.malloc(f, s, a, RTE_NUMA_ID_ANY); \
 		if (mem) { \
 			DRV_LOG(WARNING, \
 			"Allocated %p (size %zu socket %d) through NUMA tolerant fallback", \
@@ -116,7 +116,7 @@ mlx5_ipool_create(struct mlx5_indexed_pool_config *cfg)
 		return NULL;
 	pool = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*pool) + cfg->grow_trunk *
 			   sizeof(pool->grow_tbl[0]), RTE_CACHE_LINE_SIZE,
-			   SOCKET_ID_ANY);
+			   RTE_NUMA_ID_ANY);
 	if (!pool)
 		return NULL;
 	pool->cfg = *cfg;
@@ -174,7 +174,7 @@ mlx5_ipool_grow(struct mlx5_indexed_pool *pool)
 
 		p = pool_malloc(pool, MLX5_MEM_ZERO, (pool->n_trunk_valid + n_grow) *
 				     sizeof(struct mlx5_indexed_trunk *),
-				     RTE_CACHE_LINE_SIZE, rte_socket_id());
+				     RTE_CACHE_LINE_SIZE, rte_numa_id());
 		if (!p)
 			return -ENOMEM;
 		if (pool->trunks)
@@ -203,7 +203,7 @@ mlx5_ipool_grow(struct mlx5_indexed_pool *pool)
 	trunk_size += RTE_CACHE_LINE_ROUNDUP(data_size * pool->cfg.size);
 	trunk_size += bmp_size;
 	trunk = pool_malloc(pool, MLX5_MEM_ZERO, trunk_size,
-				 RTE_CACHE_LINE_SIZE, rte_socket_id());
+				 RTE_CACHE_LINE_SIZE, rte_numa_id());
 	if (!trunk)
 		return -ENOMEM;
 	pool->trunks[idx] = trunk;
@@ -279,7 +279,7 @@ mlx5_ipool_grow_bmp(struct mlx5_indexed_pool *pool, uint32_t new_size)
 	pool->cache_validator.bmp_mem = pool_malloc(pool, MLX5_MEM_ZERO,
 							 bmp_mem_size,
 							 RTE_CACHE_LINE_SIZE,
-							 rte_socket_id());
+							 rte_numa_id());
 	if (unlikely(!pool->cache_validator.bmp_mem)) {
 		DRV_LOG_IPOOL(ERR, "Unable to allocate memory for a new bitmap");
 		return;
@@ -370,7 +370,7 @@ mlx5_ipool_allocate_from_global(struct mlx5_indexed_pool *pool, int cidx)
 		p = pool_malloc(pool, MLX5_MEM_ZERO, ((trunk_idx + n_grow) *
 			sizeof(struct mlx5_indexed_trunk *)) +
 			(cur_max_idx * sizeof(uint32_t)) + sizeof(*p),
-			RTE_CACHE_LINE_SIZE, rte_socket_id());
+			RTE_CACHE_LINE_SIZE, rte_numa_id());
 		if (!p)
 			return 0;
 		p->trunks = (struct mlx5_indexed_trunk **)&p->idx[cur_max_idx];
@@ -390,7 +390,7 @@ mlx5_ipool_allocate_from_global(struct mlx5_indexed_pool *pool, int cidx)
 	data_size = mlx5_trunk_size_get(pool, trunk_idx);
 	trunk_size += RTE_CACHE_LINE_ROUNDUP(data_size * pool->cfg.size);
 	trunk = pool_malloc(pool, MLX5_MEM_ZERO, trunk_size,
-				 RTE_CACHE_LINE_SIZE, rte_socket_id());
+				 RTE_CACHE_LINE_SIZE, rte_numa_id());
 	if (unlikely(!trunk)) {
 		pool->cfg.free(p);
 		return 0;
@@ -456,7 +456,7 @@ _mlx5_ipool_get_cache(struct mlx5_indexed_pool *pool, int cidx, uint32_t idx)
 		pool->cache[cidx] = pool_malloc(pool, MLX5_MEM_ZERO,
 			sizeof(struct mlx5_ipool_per_lcore) +
 			(pool->cfg.per_core_cache * sizeof(uint32_t)),
-			RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+			RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 		if (!pool->cache[cidx]) {
 			DRV_LOG(ERR, "Ipool cache%d allocate failed\n", cidx);
 			return NULL;
@@ -542,7 +542,7 @@ _mlx5_ipool_malloc_cache(struct mlx5_indexed_pool *pool, int cidx,
 		pool->cache[cidx] = pool_malloc(pool, MLX5_MEM_ZERO,
 			sizeof(struct mlx5_ipool_per_lcore) +
 			(pool->cfg.per_core_cache * sizeof(uint32_t)),
-			RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+			RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 		if (!pool->cache[cidx]) {
 			DRV_LOG(ERR, "Ipool cache%d allocate failed\n", cidx);
 			return NULL;
@@ -604,7 +604,7 @@ _mlx5_ipool_free_cache(struct mlx5_indexed_pool *pool, int cidx, uint32_t idx)
 		pool->cache[cidx] = pool_malloc(pool, MLX5_MEM_ZERO,
 			sizeof(struct mlx5_ipool_per_lcore) +
 			(pool->cfg.per_core_cache * sizeof(uint32_t)),
-			RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+			RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 		if (!pool->cache[cidx]) {
 			DRV_LOG(ERR, "Ipool cache%d allocate failed\n", cidx);
 			return;
@@ -910,7 +910,7 @@ mlx5_ipool_flush_cache(struct mlx5_indexed_pool *pool)
 	bmp_num = mlx5_trunk_idx_offset_get(pool, gc->n_trunk_valid);
 	mem_size = rte_bitmap_get_memory_footprint(bmp_num);
 	pool->bmp_mem = pool_malloc(pool, MLX5_MEM_ZERO, mem_size,
-					 RTE_CACHE_LINE_SIZE, rte_socket_id());
+					 RTE_CACHE_LINE_SIZE, rte_numa_id());
 	if (!pool->bmp_mem) {
 		DRV_LOG(ERR, "Ipool bitmap mem allocate failed.\n");
 		return;
@@ -1045,7 +1045,7 @@ mlx5_l3t_create(enum mlx5_l3t_type type)
 		return NULL;
 	}
 	tbl = mlx5_malloc(MLX5_MEM_ZERO, sizeof(struct mlx5_l3t_tbl), 1,
-			  SOCKET_ID_ANY);
+			  RTE_NUMA_ID_ANY);
 	if (!tbl) {
 		rte_errno = ENOMEM;
 		return NULL;
@@ -1282,7 +1282,7 @@ __l3t_set_entry(struct mlx5_l3t_tbl *tbl, uint32_t idx,
 		g_tbl = mlx5_malloc(MLX5_MEM_ZERO,
 				    sizeof(struct mlx5_l3t_level_tbl) +
 				    sizeof(void *) * MLX5_L3T_GT_SIZE, 1,
-				    SOCKET_ID_ANY);
+				    RTE_NUMA_ID_ANY);
 		if (!g_tbl) {
 			rte_errno = ENOMEM;
 			return -1;
@@ -1298,7 +1298,7 @@ __l3t_set_entry(struct mlx5_l3t_tbl *tbl, uint32_t idx,
 		m_tbl = mlx5_malloc(MLX5_MEM_ZERO,
 				    sizeof(struct mlx5_l3t_level_tbl) +
 				    sizeof(void *) * MLX5_L3T_MT_SIZE, 1,
-				    SOCKET_ID_ANY);
+				    RTE_NUMA_ID_ANY);
 		if (!m_tbl) {
 			rte_errno = ENOMEM;
 			return -1;
diff --git a/drivers/net/mlx5/windows/mlx5_flow_os.c b/drivers/net/mlx5/windows/mlx5_flow_os.c
index 48d9f8520e..6bfccaaa92 100644
--- a/drivers/net/mlx5/windows/mlx5_flow_os.c
+++ b/drivers/net/mlx5/windows/mlx5_flow_os.c
@@ -91,7 +91,7 @@ mlx5_flow_os_create_flow_matcher(void *ctx,
 		mlx5_malloc(MLX5_MEM_ZERO,
 		       sizeof(struct mlx5_matcher) +
 		       MLX5_ST_SZ_BYTES(fte_match_param),
-		       0, SOCKET_ID_ANY);
+		       0, RTE_NUMA_ID_ANY);
 	if (!mlx5_matcher) {
 		rte_errno = ENOMEM;
 		return -rte_errno;
@@ -139,7 +139,7 @@ mlx5_flow_os_create_flow_action_dest_devx_tir(struct mlx5_devx_obj *tir,
 	struct mlx5_action *mlx5_action =
 		mlx5_malloc(MLX5_MEM_ZERO,
 		       sizeof(struct mlx5_action),
-		       0, SOCKET_ID_ANY);
+		       0, RTE_NUMA_ID_ANY);
 
 	if (!mlx5_action) {
 		rte_errno = ENOMEM;
diff --git a/drivers/net/mlx5/windows/mlx5_os.c b/drivers/net/mlx5/windows/mlx5_os.c
index cc60f07e17..99a95e1144 100644
--- a/drivers/net/mlx5/windows/mlx5_os.c
+++ b/drivers/net/mlx5/windows/mlx5_os.c
@@ -108,7 +108,7 @@ mlx5_init_shared_data(void)
 		/* Allocate shared memory. */
 		mz = rte_memzone_reserve(MZ_MLX5_PMD_SHARED_DATA,
 					 sizeof(*mlx5_shared_data),
-					 SOCKET_ID_ANY, 0);
+					 RTE_NUMA_ID_ANY, 0);
 		if (mz == NULL) {
 			DRV_LOG(ERR,
 				"Cannot allocate mlx5 shared data");
@@ -397,7 +397,7 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	/* Allocate private eth device data. */
 	priv = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE,
 			   sizeof(*priv),
-			   RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+			   RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	if (priv == NULL) {
 		DRV_LOG(ERR, "priv allocation failure");
 		err = ENOMEM;
@@ -408,7 +408,7 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	priv->pci_dev = spawn->pci_dev;
 	priv->mac = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE,
 				sizeof(*priv->mac) * sh->dev_cap.max_mac_addrs,
-				RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+				RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	if (priv->mac == NULL) {
 		DRV_LOG(ERR, "Failed to allocate MAC address array.");
 		err = ENOMEM;
@@ -416,7 +416,7 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	}
 	priv->mac_own = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE,
 				    RTE_BITSET_SIZE(sh->dev_cap.max_mac_addrs),
-				    RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+				    RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	if (priv->mac_own == NULL) {
 		DRV_LOG(ERR, "Failed to allocate MAC ownership bitmap.");
 		err = ENOMEM;
-- 
2.55.0

