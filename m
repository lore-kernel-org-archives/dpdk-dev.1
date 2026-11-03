Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064F2606BA2C
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YWhgGkBu
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0B5F42E98;
	Tue,  3 Nov 2026 16:13:34 +0100 (CET)
Received: from mta0.migadu.com (out-25.mta0.migadu.com [91.218.175.25])
 by mails.dpdk.org (Postfix) with ESMTPS id 22DD342E9F
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:13:33 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=l2zBiqt371cmpvNsjYtBoSLTAk03kbeP+Vz33/Q6PTs=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718812; v=1; x=1794323612;
 b=YWhgGkBu5053Av5PwxxwkSD9B0J6rU6WNd50VUmUHujLlQmjEqFKMQoy5ARepNvl5KJ7SyPg
 vItXVvg0xDvDMSGxE4m0fYTqgOy81o7nhXSrgoBOglT6VoaupA9+7WX3L0ZmgH/Qn8TY8YKAzt0
 WuCGlnFfwTqU7riO+NW8ZiIE=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 981fecd384851c87;
 Tue, 03 Nov 2026 15:13:32 +0000
X-Mizu-Trace-ID: 981fecd384851c87
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 128/227] net/mlx4: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:26 +0800
Message-ID: <20261103145306.487255-129-chengwen.feng@linux.dev>
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
and comments to the NUMA node terminology, and switch calls to
the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/net/mlx4/mlx4.c       |  8 ++++----
 drivers/net/mlx4/mlx4_mr.c    | 12 ++++++------
 drivers/net/mlx4/mlx4_utils.c | 14 +++++++-------
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/mlx4/mlx4.c b/drivers/net/mlx4/mlx4.c
index dbcd98d49f..eb70d96136 100644
--- a/drivers/net/mlx4/mlx4.c
+++ b/drivers/net/mlx4/mlx4.c
@@ -104,7 +104,7 @@ mlx4_init_shared_data(void)
 			/* Allocate shared memory. */
 			mz = rte_memzone_reserve(MZ_MLX4_PMD_SHARED_DATA,
 						 sizeof(*mlx4_shared_data),
-						 SOCKET_ID_ANY, 0);
+						 RTE_NUMA_ID_ANY, 0);
 			if (mz == NULL) {
 				ERROR("Cannot allocate mlx4 shared data");
 				ret = -rte_errno;
@@ -151,7 +151,7 @@ mlx4_alloc_verbs_buf(size_t size, void *data)
 	struct mlx4_priv *priv = data;
 	void *ret;
 	size_t alignment = sysconf(_SC_PAGESIZE);
-	unsigned int socket = SOCKET_ID_ANY;
+	unsigned int socket = RTE_NUMA_ID_ANY;
 
 	if (priv->verbs_alloc_ctx.type == MLX4_VERBS_ALLOC_TYPE_TX_QUEUE) {
 		const struct txq *txq = priv->verbs_alloc_ctx.obj;
@@ -164,7 +164,7 @@ mlx4_alloc_verbs_buf(size_t size, void *data)
 		socket = rxq->socket;
 	}
 	MLX4_ASSERT(data != NULL);
-	ret = rte_malloc_socket(__func__, size, alignment, socket);
+	ret = rte_malloc_numa(__func__, size, alignment, socket);
 	if (!ret && size)
 		rte_errno = ENOMEM;
 	return ret;
@@ -208,7 +208,7 @@ mlx4_proc_priv_init(struct rte_eth_dev *dev)
 	 */
 	ppriv_size = sizeof(struct mlx4_proc_priv) +
 		     dev->data->nb_tx_queues * sizeof(void *);
-	ppriv = rte_zmalloc_socket("mlx4_proc_priv", ppriv_size,
+	ppriv = rte_zmalloc_numa("mlx4_proc_priv", ppriv_size,
 				   RTE_CACHE_LINE_SIZE, dev->device->numa_node);
 	if (!ppriv) {
 		rte_errno = ENOMEM;
diff --git a/drivers/net/mlx4/mlx4_mr.c b/drivers/net/mlx4/mlx4_mr.c
index 5e2c2dbf85..5499029159 100644
--- a/drivers/net/mlx4/mlx4_mr.c
+++ b/drivers/net/mlx4/mlx4_mr.c
@@ -71,7 +71,7 @@ mr_btree_expand(struct mlx4_mr_btree *bt, int n)
 	if (n <= bt->size)
 		return ret;
 	/*
-	 * Downside of directly using rte_realloc() is that SOCKET_ID_ANY is
+	 * Downside of directly using rte_realloc() is that RTE_NUMA_ID_ANY is
 	 * used inside if there's no room to expand. Because this is a quite
 	 * rare case and a part of very slow path, it is very acceptable.
 	 * Initially cache_bh[] will be given practically enough space and once
@@ -206,7 +206,7 @@ mlx4_mr_btree_init(struct mlx4_mr_btree *bt, int n, int socket)
 		return -rte_errno;
 	}
 	memset(bt, 0, sizeof(*bt));
-	bt->table = rte_calloc_socket("B-tree table",
+	bt->table = rte_calloc_numa("B-tree table",
 				      n, sizeof(struct mlx4_mr_cache),
 				      0, socket);
 	if (bt->table == NULL) {
@@ -658,11 +658,11 @@ mlx4_mr_create_primary(struct rte_eth_dev *dev, struct mlx4_mr_cache *entry,
 	      data.start, data.end, msl->page_sz, ms_n);
 	/* Size of memory for bitmap. */
 	bmp_size = rte_bitmap_get_memory_footprint(ms_n);
-	mr = rte_zmalloc_socket(NULL,
+	mr = rte_zmalloc_numa(NULL,
 				RTE_ALIGN_CEIL(sizeof(*mr),
 					       RTE_CACHE_LINE_SIZE) +
 				bmp_size,
-				RTE_CACHE_LINE_SIZE, msl->socket_id);
+				RTE_CACHE_LINE_SIZE, msl->numa_id);
 	if (mr == NULL) {
 		WARN("port %u unable to allocate memory for a new MR of"
 		     " address (%p).",
@@ -773,7 +773,7 @@ mlx4_mr_create_primary(struct rte_eth_dev *dev, struct mlx4_mr_cache *entry,
 	/*
 	 * Finally create a verbs MR for the memory chunk. ibv_reg_mr() can be
 	 * called with holding the memory lock because it doesn't use
-	 * mlx4_alloc_buf_extern() which eventually calls rte_malloc_socket()
+	 * mlx4_alloc_buf_extern() which eventually calls rte_malloc_numa()
 	 * through mlx4_alloc_verbs_buf().
 	 */
 	mr->ibv_mr = mlx4_glue->reg_mr(priv->pd, (void *)data.start, len,
@@ -1223,7 +1223,7 @@ mlx4_mr_update_ext_mp_cb(struct rte_mempool *mp, void *opaque,
 	rte_rwlock_read_unlock(&priv->mr.rwlock);
 	if (lkey != UINT32_MAX)
 		return;
-	mr = rte_zmalloc_socket(NULL,
+	mr = rte_zmalloc_numa(NULL,
 				RTE_ALIGN_CEIL(sizeof(*mr),
 					       RTE_CACHE_LINE_SIZE),
 				RTE_CACHE_LINE_SIZE, mp->numa_id);
diff --git a/drivers/net/mlx4/mlx4_utils.c b/drivers/net/mlx4/mlx4_utils.c
index 614dc197d9..3615bfa5b9 100644
--- a/drivers/net/mlx4/mlx4_utils.c
+++ b/drivers/net/mlx4/mlx4_utils.c
@@ -81,9 +81,9 @@ mlx4_mallocv_inline(const char *type, const struct mlx4_malloc_vec *vec,
 	if (fill)
 		return size;
 	if (!zero)
-		data = rte_malloc_socket(type, size, least, socket);
+		data = rte_malloc_numa(type, size, least, socket);
 	else
-		data = rte_zmalloc_socket(type, size, least, socket);
+		data = rte_zmalloc_numa(type, size, least, socket);
 	if (data) {
 		fill = 1;
 		goto fill;
@@ -138,7 +138,7 @@ size_t
 mlx4_mallocv(const char *type, const struct mlx4_malloc_vec *vec,
 	     unsigned int cnt)
 {
-	return mlx4_mallocv_inline(type, vec, cnt, 0, SOCKET_ID_ANY);
+	return mlx4_mallocv_inline(type, vec, cnt, 0, RTE_NUMA_ID_ANY);
 }
 
 /**
@@ -151,7 +151,7 @@ size_t
 mlx4_zmallocv(const char *type, const struct mlx4_malloc_vec *vec,
 	      unsigned int cnt)
 {
-	return mlx4_mallocv_inline(type, vec, cnt, 1, SOCKET_ID_ANY);
+	return mlx4_mallocv_inline(type, vec, cnt, 1, RTE_NUMA_ID_ANY);
 }
 
 /**
@@ -160,11 +160,11 @@ mlx4_zmallocv(const char *type, const struct mlx4_malloc_vec *vec,
  * This function takes one additional parameter.
  *
  * @param socket
- *   NUMA socket to allocate memory on. If SOCKET_ID_ANY is used, this
+ *   NUMA socket to allocate memory on. If RTE_NUMA_ID_ANY is used, this
  *   function will behave the same as mlx4_mallocv().
  *
  * @see mlx4_mallocv()
- * @see rte_malloc_socket()
+ * @see rte_malloc_numa()
  */
 size_t
 mlx4_mallocv_socket(const char *type, const struct mlx4_malloc_vec *vec,
@@ -178,7 +178,7 @@ mlx4_mallocv_socket(const char *type, const struct mlx4_malloc_vec *vec,
  * mlx4_zmalloc_socket().
  *
  * @see mlx4_mallocv_socket()
- * @see rte_zmalloc_socket()
+ * @see rte_zmalloc_numa()
  */
 size_t
 mlx4_zmallocv_socket(const char *type, const struct mlx4_malloc_vec *vec,
-- 
2.55.0

