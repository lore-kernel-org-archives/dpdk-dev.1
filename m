Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6EBCD3447
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 22:05:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C693640649;
	Sun, 10 May 2026 00:04:55 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id DFC9640649
 for <dev@dpdk.org>; Sun, 10 May 2026 00:04:53 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 3152B7A0060;
 Sat,  9 May 2026 18:04:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Sat, 09 May 2026 18:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1778364293; x=
 1778450693; bh=UUFgdOMZnV+pzp6iGATtOLdAeg4z74Jpr9HTELDiIwc=; b=N
 UbURgNfknI/jqKPoXdUP/GN9kH5dBPfuaAW4GbRz2+EvOPeR3B3SrXSxZ4HRU0ZW
 Anh2i+qqiCQu9O7lkVtNrrdUb2VyFG4UxqN71n2DqjZKHwEWHPhLFxA6v8klTixZ
 1MkmidtRd6gXthEjMQ6oYFhEvQ6LnLqupmh25TTN/9DX+4kgrgJwEPo8V9qK8hIP
 xUeXN5P43GpbSQCEYXGKPS+m5/wUykSIoHJMJrBIT38+i0cCdXllXPFe7w0LKswj
 tXyw58q1kI5xdMFfhJPPWe2s1kdPfWNsoexQRFS5y4y6hGt1hNrU9b6p8MkEsM/v
 /zKZQrisMzJRuLzgUxFNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1778364293; x=1778450693; bh=U
 UFgdOMZnV+pzp6iGATtOLdAeg4z74Jpr9HTELDiIwc=; b=WFnuZHyf3oq+P2Dpk
 UJhMpZIxWm2uAvJSM76FM1z5mr3/oxzNChnF5FXYU+TJ0sx5tlHAhe407pea6qbh
 Et6aml2t8rPryZ0Vs0yrDBV5sejC/FeK0lf9OlmIL1Irq59jw8s8AmznFmQa2ZTo
 x/lXKI2qa6h0uR8HhJlSg30KjFwY9bnlEXOEc0fyQ2bBds4fJ61bhB7U3K3HMmn7
 O33itVwFSsCOy7RzkdOuiQQ3+cXTtX4/OZjHOZ6bHICi0CXE2mqB+hu+NaBZ3kgI
 +H6TN/FhfkBAJMmLaUm7xOc/R1WK+Lq6to4mX0Uuz+T4CSYtbfd5gLy4xOF6c7If
 /ccPg==
X-ME-Sender: <xms:hK__aeFML9CEUXKONvlPylDWBmd9p9rBD6hE_AwQa-4MMTehirg-PA>
 <xme:hK__afyXQzJfSO8-Wr4QRbYHQbP7HVNeY0ZBYkTBQwEkVY6gKH8tvOQsuGAWMV5lO
 F5Yn9i31gbGbmx07OsmuT3FybST7Ir2LyZ6DdCxIo2Jn_nEX20qFw>
X-ME-Received: <xmr:hK__aY0aq46iCz-0knpq15oWWPvzwX_vj5D0tPfwp3xhq2bMSBlxqrxoiWjFKomJnv6NaajZa6cUnu4ovNyFxa7Ha2-_Dp4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudegfeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedutddp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtg
 hpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghp
 thhtohepughsohhsnhhofihskhhisehnvhhiughirgdrtghomhdprhgtphhtthhopehvih
 grtghhvghslhgrvhhosehnvhhiughirgdrtghomhdprhgtphhtthhopegsihhnghiisehn
 vhhiughirgdrtghomhdprhgtphhtthhopehorhhikhgrsehnvhhiughirgdrtghomhdprh
 gtphhtthhopehsuhgrnhhmihhnghhmsehnvhhiughirgdrtghomhdprhgtphhtthhopehm
 rghtrghnsehnvhhiughirgdrtghomhdprhgtphhtthhopehfrghniihhrghnghdrohhssh
 esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:hK__afrifLB5f83rsT_kRGfhy42PAOtiox5bz235V_o5bbxeHihMIA>
 <xmx:hK__aVV5N9fziCcsNeNik0HtULtI4Ng3eVzlrKy_-GM8lP3Vgqmnww>
 <xmx:hK__aYoIcjqM-ZJo2iKn-V3m2_h6dh8AKCIuGq3G5PoRme2sHXbE2A>
 <xmx:hK__acB2jz34pr2n56vo82uo6p3GuLE-T_jW34cUkbtNMITeVRp-aA>
 <xmx:ha__aYhoAMZkcKNVYPNFkCCOkBCz9f_ZMGlNY7jdQdQUmFMxr4aQLcwN>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 May 2026 18:04:51 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>
Subject: [PATCH v2 08/10] common/mlx5: remove callbacks for MR registration
Date: Sat,  9 May 2026 23:56:59 +0200
Message-ID: <20260509220356.3679114-9-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260509220356.3679114-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260509220356.3679114-1-thomas@monjalon.net>
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

The functions register/unregister for a Memory Region (MR)
were not called directly.
There are only 2 implementations for Linux and Windows,
no need of handling this difference with function pointers.
The callback pointers are replaced with direct calls
and link time decision based on the Operating System.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 drivers/common/mlx5/linux/mlx5_common_verbs.c | 26 +++----------
 drivers/common/mlx5/mlx5_common.c             |  6 +--
 drivers/common/mlx5/mlx5_common_mr.c          | 37 ++++++++-----------
 drivers/common/mlx5/mlx5_common_mr.h          | 26 +++----------
 drivers/common/mlx5/windows/mlx5_common_os.c  | 23 ++----------
 drivers/compress/mlx5/mlx5_compress.c         |  4 +-
 drivers/crypto/mlx5/mlx5_crypto.h             |  2 -
 drivers/crypto/mlx5/mlx5_crypto_gcm.c         |  6 +--
 drivers/net/mlx5/mlx5.h                       |  3 +-
 drivers/net/mlx5/mlx5_flow_aso.c              | 21 +++++------
 drivers/net/mlx5/mlx5_flow_hw.c               | 11 ++----
 drivers/net/mlx5/mlx5_flow_quota.c            |  6 +--
 drivers/net/mlx5/mlx5_hws_cnt.c               | 19 ++++------
 13 files changed, 61 insertions(+), 129 deletions(-)

diff --git a/drivers/common/mlx5/linux/mlx5_common_verbs.c b/drivers/common/mlx5/linux/mlx5_common_verbs.c
index 6d44e1f566..5e23c5844d 100644
--- a/drivers/common/mlx5/linux/mlx5_common_verbs.c
+++ b/drivers/common/mlx5/linux/mlx5_common_verbs.c
@@ -106,10 +106,10 @@ mlx5_set_context_attr(struct rte_device *dev, struct ibv_context *ctx)
  * @return
  *   0 on successful registration, -1 otherwise
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_common_verbs_reg_mr)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_reg_mr)
 int
-mlx5_common_verbs_reg_mr(void *pd, void *addr, size_t length,
-			 struct mlx5_pmd_mr *pmd_mr)
+mlx5_os_reg_mr(void *pd, void *addr, size_t length,
+		struct mlx5_pmd_mr *pmd_mr)
 {
 	struct ibv_mr *ibv_mr;
 
@@ -136,9 +136,9 @@ mlx5_common_verbs_reg_mr(void *pd, void *addr, size_t length,
  *   pmd_mr struct set with lkey, address, length and pointer to mr object
  *
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_common_verbs_dereg_mr)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_dereg_mr)
 void
-mlx5_common_verbs_dereg_mr(struct mlx5_pmd_mr *pmd_mr)
+mlx5_os_dereg_mr(struct mlx5_pmd_mr *pmd_mr)
 {
 	if (pmd_mr && pmd_mr->obj != NULL) {
 		claim_zero(mlx5_glue->dereg_mr(pmd_mr->obj));
@@ -146,22 +146,6 @@ mlx5_common_verbs_dereg_mr(struct mlx5_pmd_mr *pmd_mr)
 	}
 }
 
-/**
- * Set the reg_mr and dereg_mr callbacks.
- *
- * @param[out] reg_mr_cb
- *   Pointer to reg_mr func
- * @param[out] dereg_mr_cb
- *   Pointer to dereg_mr func
- */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_set_reg_mr_cb)
-void
-mlx5_os_set_reg_mr_cb(mlx5_reg_mr_t *reg_mr_cb, mlx5_dereg_mr_t *dereg_mr_cb)
-{
-	*reg_mr_cb = mlx5_common_verbs_reg_mr;
-	*dereg_mr_cb = mlx5_common_verbs_dereg_mr;
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_alloc_null_mr)
 struct mlx5_pmd_mr *
 mlx5_os_alloc_null_mr(struct rte_device *dev, void *pd)
diff --git a/drivers/common/mlx5/mlx5_common.c b/drivers/common/mlx5/mlx5_common.c
index f71dbe4637..87de6d0ff0 100644
--- a/drivers/common/mlx5/mlx5_common.c
+++ b/drivers/common/mlx5/mlx5_common.c
@@ -1135,7 +1135,7 @@ mlx5_common_dev_dma_map(struct rte_device *rte_dev, void *addr,
 		return -1;
 	}
 	mr = mlx5_create_mr_ext(dev->pd, (uintptr_t)addr, len,
-				SOCKET_ID_ANY, dev->mr_scache.reg_mr_cb);
+				SOCKET_ID_ANY);
 	if (!mr) {
 		DRV_LOG(WARNING, "Device %s unable to DMA map", rte_dev->name);
 		rte_errno = EINVAL;
@@ -1165,7 +1165,7 @@ mlx5_common_dev_dma_map(struct rte_device *rte_dev, void *addr,
 		ret = mlx5_mr_expand_cache(&dev->mr_scache, size,
 					   rte_dev->numa_node);
 		if (ret < 0) {
-			mlx5_mr_free(mr, dev->mr_scache.dereg_mr_cb);
+			mlx5_mr_free(mr);
 			rte_errno = ret;
 			return -1;
 		}
@@ -1221,7 +1221,7 @@ mlx5_common_dev_dma_unmap(struct rte_device *rte_dev, void *addr,
 	}
 	LIST_REMOVE(mr, mr);
 	DRV_LOG(DEBUG, "MR(%p) is removed from list.", (void *)mr);
-	mlx5_mr_free(mr, dev->mr_scache.dereg_mr_cb);
+	mlx5_mr_free(mr);
 	mlx5_mr_rebuild_cache(&dev->mr_scache);
 	/*
 	 * No explicit wmb is needed after updating dev_gen due to
diff --git a/drivers/common/mlx5/mlx5_common_mr.c b/drivers/common/mlx5/mlx5_common_mr.c
index 64ffc7f4ea..aa2d5e88a4 100644
--- a/drivers/common/mlx5/mlx5_common_mr.c
+++ b/drivers/common/mlx5/mlx5_common_mr.c
@@ -492,12 +492,12 @@ mlx5_mr_lookup_cache(struct mlx5_mr_share_cache *share_cache,
  *   Pointer to MR to free.
  */
 void
-mlx5_mr_free(struct mlx5_mr *mr, mlx5_dereg_mr_t dereg_mr_cb)
+mlx5_mr_free(struct mlx5_mr *mr)
 {
 	if (mr == NULL)
 		return;
 	DRV_LOG(DEBUG, "freeing MR(%p):", (void *)mr);
-	dereg_mr_cb(&mr->pmd_mr);
+	mlx5_os_dereg_mr(&mr->pmd_mr);
 	rte_bitmap_free(mr->ms_bmp);
 	mlx5_free(mr);
 }
@@ -545,7 +545,7 @@ mlx5_mr_garbage_collect(struct mlx5_mr_share_cache *share_cache)
 		struct mlx5_mr *mr = mr_next;
 
 		mr_next = LIST_NEXT(mr, mr);
-		mlx5_mr_free(mr, share_cache->dereg_mr_cb);
+		mlx5_mr_free(mr);
 	}
 }
 
@@ -821,7 +821,7 @@ mlx5_mr_create_primary(void *pd,
 		data.start = RTE_ALIGN_FLOOR(addr, msl->page_sz);
 		data.end = data.start + msl->page_sz;
 		rte_mcfg_mem_read_unlock();
-		mlx5_mr_free(mr, share_cache->dereg_mr_cb);
+		mlx5_mr_free(mr);
 		goto alloc_resources;
 	}
 	MLX5_ASSERT(data.msl == data_re.msl);
@@ -845,7 +845,7 @@ mlx5_mr_create_primary(void *pd,
 		 * Must be unlocked before calling rte_free() because
 		 * mlx5_mr_mem_event_free_cb() can be called inside.
 		 */
-		mlx5_mr_free(mr, share_cache->dereg_mr_cb);
+		mlx5_mr_free(mr);
 		return entry->lkey;
 	}
 	/*
@@ -912,7 +912,7 @@ mlx5_mr_create_primary(void *pd,
 	 * mlx5_alloc_buf_extern() which eventually calls rte_malloc_socket()
 	 * through mlx5_alloc_verbs_buf().
 	 */
-	share_cache->reg_mr_cb(pd, (void *)data.start, len, &mr->pmd_mr);
+	mlx5_os_reg_mr(pd, (void *)data.start, len, &mr->pmd_mr);
 	if (mr->pmd_mr.obj == NULL) {
 		DRV_LOG(DEBUG, "Fail to create an MR for address (%p)",
 		      (void *)addr);
@@ -948,7 +948,7 @@ mlx5_mr_create_primary(void *pd,
 	 * calling rte_free() because mlx5_mr_mem_event_free_cb() can be called
 	 * inside.
 	 */
-	mlx5_mr_free(mr, share_cache->dereg_mr_cb);
+	mlx5_mr_free(mr);
 	return UINT32_MAX;
 }
 
@@ -1139,9 +1139,6 @@ mlx5_mr_release_cache(struct mlx5_mr_share_cache *share_cache)
 int
 mlx5_mr_create_cache(struct mlx5_mr_share_cache *share_cache, int socket)
 {
-	/* Set the reg_mr and dereg_mr callback functions */
-	mlx5_os_set_reg_mr_cb(&share_cache->reg_mr_cb,
-			      &share_cache->dereg_mr_cb);
 	rte_rwlock_init(&share_cache->rwlock);
 	rte_rwlock_init(&share_cache->mprwlock);
 	/* Initialize B-tree and allocate memory for global MR cache table. */
@@ -1189,8 +1186,7 @@ mlx5_mr_flush_local_cache(struct mlx5_mr_ctrl *mr_ctrl)
  *   Pointer to MR structure on success, NULL otherwise.
  */
 struct mlx5_mr *
-mlx5_create_mr_ext(void *pd, uintptr_t addr, size_t len, int socket_id,
-		   mlx5_reg_mr_t reg_mr_cb)
+mlx5_create_mr_ext(void *pd, uintptr_t addr, size_t len, int socket_id)
 {
 	struct mlx5_mr *mr = NULL;
 
@@ -1199,7 +1195,7 @@ mlx5_create_mr_ext(void *pd, uintptr_t addr, size_t len, int socket_id,
 			 RTE_CACHE_LINE_SIZE, socket_id);
 	if (mr == NULL)
 		return NULL;
-	reg_mr_cb(pd, (void *)addr, len, &mr->pmd_mr);
+	mlx5_os_reg_mr(pd, (void *)addr, len, &mr->pmd_mr);
 	if (mr->pmd_mr.obj == NULL) {
 		DRV_LOG(WARNING,
 			"Fail to create MR for address (%p)",
@@ -1624,14 +1620,13 @@ mlx5_mempool_reg_create(struct rte_mempool *mp, unsigned int mrs_n,
  *   Whether @p mpr owns its MRs exclusively, i.e. they are not shared.
  */
 static void
-mlx5_mempool_reg_destroy(struct mlx5_mr_share_cache *share_cache,
-			 struct mlx5_mempool_reg *mpr, bool standalone)
+mlx5_mempool_reg_destroy(struct mlx5_mempool_reg *mpr, bool standalone)
 {
 	if (standalone) {
 		unsigned int i;
 
 		for (i = 0; i < mpr->mrs_n; i++)
-			share_cache->dereg_mr_cb(&mpr->mrs[i].pmd_mr);
+			mlx5_os_dereg_mr(&mpr->mrs[i].pmd_mr);
 		mlx5_free(mpr->mrs);
 	}
 	mlx5_free(mpr);
@@ -1748,7 +1743,7 @@ mlx5_mr_mempool_register_primary(struct mlx5_mr_share_cache *share_cache,
 		const struct mlx5_range *range = &ranges[i];
 		size_t len = range->end - range->start;
 
-		if (share_cache->reg_mr_cb(pd, (void *)range->start, len,
+		if (mlx5_os_reg_mr(pd, (void *)range->start, len,
 		    &mr->pmd_mr) < 0) {
 			DRV_LOG(ERR,
 				"Failed to create an MR in PD %p for address range "
@@ -1763,7 +1758,7 @@ mlx5_mr_mempool_register_primary(struct mlx5_mr_share_cache *share_cache,
 			mp->name);
 	}
 	if (i != ranges_n) {
-		mlx5_mempool_reg_destroy(share_cache, new_mpr, true);
+		mlx5_mempool_reg_destroy(new_mpr, true);
 		rte_errno = EINVAL;
 		goto exit;
 	}
@@ -1785,13 +1780,13 @@ mlx5_mr_mempool_register_primary(struct mlx5_mr_share_cache *share_cache,
 	if (mpr != NULL) {
 		DRV_LOG(DEBUG, "Mempool %s is already registered for PD %p",
 			mp->name, pd);
-		mlx5_mempool_reg_destroy(share_cache, new_mpr, true);
+		mlx5_mempool_reg_destroy(new_mpr, true);
 		rte_errno = EEXIST;
 		goto exit;
 	} else if (old_mpr != NULL) {
 		DRV_LOG(DEBUG, "Mempool %s registration for PD %p updated for external memory",
 			mp->name, pd);
-		mlx5_mempool_reg_destroy(share_cache, old_mpr, standalone);
+		mlx5_mempool_reg_destroy(old_mpr, standalone);
 	}
 exit:
 	free(ranges);
@@ -1860,7 +1855,7 @@ mlx5_mr_mempool_unregister_primary(struct mlx5_mr_share_cache *share_cache,
 		rte_errno = ENOENT;
 		return -1;
 	}
-	mlx5_mempool_reg_destroy(share_cache, mpr, standalone);
+	mlx5_mempool_reg_destroy(mpr, standalone);
 	return 0;
 }
 
diff --git a/drivers/common/mlx5/mlx5_common_mr.h b/drivers/common/mlx5/mlx5_common_mr.h
index 00f3d832c3..5fb931a1b5 100644
--- a/drivers/common/mlx5/mlx5_common_mr.h
+++ b/drivers/common/mlx5/mlx5_common_mr.h
@@ -32,13 +32,6 @@ struct mlx5_pmd_mr {
 	struct mlx5_devx_obj *mkey; /* devx mkey object. */
 };
 
-/**
- * mr operations typedef
- */
-typedef int (*mlx5_reg_mr_t)(void *pd, void *addr, size_t length,
-			     struct mlx5_pmd_mr *pmd_mr);
-typedef void (*mlx5_dereg_mr_t)(struct mlx5_pmd_mr *pmd_mr);
-
 /* Memory Region object. */
 struct mlx5_mr {
 	LIST_ENTRY(mlx5_mr) mr; /**< Pointer to the prev/next entry. */
@@ -88,8 +81,6 @@ struct __rte_packed_begin mlx5_mr_share_cache {
 	struct mlx5_mr_list mr_list; /* Registered MR list. */
 	struct mlx5_mr_list mr_free_list; /* Freed MR list. */
 	struct mlx5_mempool_reg_list mempool_reg_list; /* Mempool database. */
-	mlx5_reg_mr_t reg_mr_cb; /* Callback to reg_mr func */
-	mlx5_dereg_mr_t dereg_mr_cb; /* Callback to dereg_mr func */
 } __rte_packed_end;
 
 /* Multi-Packet RQ buffer header. */
@@ -233,9 +224,8 @@ struct mlx5_mr *
 mlx5_mr_lookup_list(struct mlx5_mr_share_cache *share_cache,
 		    struct mr_cache_entry *entry, uintptr_t addr);
 struct mlx5_mr *
-mlx5_create_mr_ext(void *pd, uintptr_t addr, size_t len, int socket_id,
-		   mlx5_reg_mr_t reg_mr_cb);
-void mlx5_mr_free(struct mlx5_mr *mr, mlx5_dereg_mr_t dereg_mr_cb);
+mlx5_create_mr_ext(void *pd, uintptr_t addr, size_t len, int socket_id);
+void mlx5_mr_free(struct mlx5_mr *mr);
 __rte_internal
 uint32_t
 mlx5_mr_create(struct mlx5_common_device *cdev,
@@ -246,19 +236,13 @@ __rte_internal
 uint32_t
 mlx5_mr_addr2mr_bh(struct mlx5_mr_ctrl *mr_ctrl, uintptr_t addr);
 
-/* mlx5_common_verbs.c */
-
 __rte_internal
 int
-mlx5_common_verbs_reg_mr(void *pd, void *addr, size_t length,
-			 struct mlx5_pmd_mr *pmd_mr);
+mlx5_os_reg_mr(void *pd, void *addr, size_t length,
+		struct mlx5_pmd_mr *pmd_mr);
 __rte_internal
 void
-mlx5_common_verbs_dereg_mr(struct mlx5_pmd_mr *pmd_mr);
-
-__rte_internal
-void
-mlx5_os_set_reg_mr_cb(mlx5_reg_mr_t *reg_mr_cb, mlx5_dereg_mr_t *dereg_mr_cb);
+mlx5_os_dereg_mr(struct mlx5_pmd_mr *pmd_mr);
 
 __rte_internal
 struct mlx5_pmd_mr *
diff --git a/drivers/common/mlx5/windows/mlx5_common_os.c b/drivers/common/mlx5/windows/mlx5_common_os.c
index 692517a9bf..bf1b654da3 100644
--- a/drivers/common/mlx5/windows/mlx5_common_os.c
+++ b/drivers/common/mlx5/windows/mlx5_common_os.c
@@ -377,7 +377,8 @@ mlx5_os_umem_dereg(void *pumem)
  * @return
  *   0 on successful registration, -1 otherwise
  */
-static int
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_reg_mr)
+int
 mlx5_os_reg_mr(void *pd,
 	       void *addr, size_t length, struct mlx5_pmd_mr *pmd_mr)
 {
@@ -425,7 +426,8 @@ mlx5_os_reg_mr(void *pd,
  * @param[in] pmd_mr
  *  Pointer to PMD mr object
  */
-static void
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_dereg_mr)
+void
 mlx5_os_dereg_mr(struct mlx5_pmd_mr *pmd_mr)
 {
 	if (!pmd_mr)
@@ -437,23 +439,6 @@ mlx5_os_dereg_mr(struct mlx5_pmd_mr *pmd_mr)
 	memset(pmd_mr, 0, sizeof(*pmd_mr));
 }
 
-/**
- * Set the reg_mr and dereg_mr callbacks.
- *
- * @param[out] reg_mr_cb
- *   Pointer to reg_mr func
- * @param[out] dereg_mr_cb
- *   Pointer to dereg_mr func
- *
- */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_set_reg_mr_cb)
-void
-mlx5_os_set_reg_mr_cb(mlx5_reg_mr_t *reg_mr_cb, mlx5_dereg_mr_t *dereg_mr_cb)
-{
-	*reg_mr_cb = mlx5_os_reg_mr;
-	*dereg_mr_cb = mlx5_os_dereg_mr;
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_alloc_null_mr)
 struct mlx5_pmd_mr *
 mlx5_os_alloc_null_mr(struct rte_device *dev, void *pd)
diff --git a/drivers/compress/mlx5/mlx5_compress.c b/drivers/compress/mlx5/mlx5_compress.c
index e5325c6150..1361dab630 100644
--- a/drivers/compress/mlx5/mlx5_compress.c
+++ b/drivers/compress/mlx5/mlx5_compress.c
@@ -117,7 +117,7 @@ mlx5_compress_qp_release(struct rte_compressdev *dev, uint16_t qp_id)
 	if (qp->opaque_mr.obj != NULL) {
 		void *opaq = qp->opaque_mr.addr;
 
-		mlx5_common_verbs_dereg_mr(&qp->opaque_mr);
+		mlx5_os_dereg_mr(&qp->opaque_mr);
 		rte_free(opaq);
 	}
 	mlx5_mr_btree_free(&qp->mr_ctrl.cache_bh);
@@ -199,7 +199,7 @@ mlx5_compress_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
 	qp->priv = priv;
 	qp->ops = (struct rte_comp_op **)RTE_ALIGN((uintptr_t)(qp + 1),
 						   RTE_CACHE_LINE_SIZE);
-	if (mlx5_common_verbs_reg_mr(priv->cdev->pd, opaq_buf, qp->entries_n *
+	if (mlx5_os_reg_mr(priv->cdev->pd, opaq_buf, qp->entries_n *
 					sizeof(union mlx5_gga_compress_opaque),
 							 &qp->opaque_mr) != 0) {
 		rte_free(opaq_buf);
diff --git a/drivers/crypto/mlx5/mlx5_crypto.h b/drivers/crypto/mlx5/mlx5_crypto.h
index f9f127e9e6..93a2bb2c78 100644
--- a/drivers/crypto/mlx5/mlx5_crypto.h
+++ b/drivers/crypto/mlx5/mlx5_crypto.h
@@ -40,8 +40,6 @@ struct mlx5_crypto_priv {
 	TAILQ_ENTRY(mlx5_crypto_priv) next;
 	struct mlx5_common_device *cdev; /* Backend mlx5 device. */
 	struct rte_cryptodev *crypto_dev;
-	mlx5_reg_mr_t reg_mr_cb; /* Callback to reg_mr func */
-	mlx5_dereg_mr_t dereg_mr_cb; /* Callback to dereg_mr func */
 	struct mlx5_uar uar; /* User Access Region. */
 	uint32_t max_segs_num; /* Maximum supported data segs. */
 	uint32_t max_klm_num; /* Maximum supported klm. */
diff --git a/drivers/crypto/mlx5/mlx5_crypto_gcm.c b/drivers/crypto/mlx5/mlx5_crypto_gcm.c
index 89f32c7722..1a2600655a 100644
--- a/drivers/crypto/mlx5/mlx5_crypto_gcm.c
+++ b/drivers/crypto/mlx5/mlx5_crypto_gcm.c
@@ -219,7 +219,6 @@ mlx5_crypto_gcm_mkey_klm_update(struct mlx5_crypto_priv *priv,
 static int
 mlx5_crypto_gcm_qp_release(struct rte_cryptodev *dev, uint16_t qp_id)
 {
-	struct mlx5_crypto_priv *priv = dev->data->dev_private;
 	struct mlx5_crypto_qp *qp = dev->data->queue_pairs[qp_id];
 
 	if (qp->umr_qp_obj.qp != NULL)
@@ -231,7 +230,7 @@ mlx5_crypto_gcm_qp_release(struct rte_cryptodev *dev, uint16_t qp_id)
 	if (qp->mr.obj != NULL) {
 		void *opaq = qp->mr.addr;
 
-		priv->dereg_mr_cb(&qp->mr);
+		mlx5_os_dereg_mr(&qp->mr);
 		rte_free(opaq);
 	}
 	mlx5_crypto_indirect_mkeys_release(qp, qp->entries_n);
@@ -363,7 +362,7 @@ mlx5_crypto_gcm_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 		rte_errno = ENOMEM;
 		goto err;
 	}
-	if (priv->reg_mr_cb(priv->cdev->pd, mr_buf, mr_size, &qp->mr) != 0) {
+	if (mlx5_os_reg_mr(priv->cdev->pd, mr_buf, mr_size, &qp->mr) != 0) {
 		rte_free(mr_buf);
 		DRV_LOG(ERR, "Failed to register opaque MR.");
 		rte_errno = ENOMEM;
@@ -1186,7 +1185,6 @@ mlx5_crypto_gcm_init(struct mlx5_crypto_priv *priv)
 
 	/* Override AES-GCM specified ops. */
 	dev_ops->sym_session_configure = mlx5_crypto_sym_gcm_session_configure;
-	mlx5_os_set_reg_mr_cb(&priv->reg_mr_cb, &priv->dereg_mr_cb);
 	dev_ops->queue_pair_setup = mlx5_crypto_gcm_qp_setup;
 	dev_ops->queue_pair_release = mlx5_crypto_gcm_qp_release;
 	if (mlx5_crypto_is_ipsec_opt(priv)) {
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index b7980d329d..167a00936b 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -2690,8 +2690,7 @@ int mlx5_aso_cnt_query(struct mlx5_dev_ctx_shared *sh,
 int mlx5_aso_ct_queue_init(struct mlx5_dev_ctx_shared *sh,
 			   struct mlx5_aso_ct_pools_mng *ct_mng,
 			   uint32_t nb_queues);
-int mlx5_aso_ct_queue_uninit(struct mlx5_dev_ctx_shared *sh,
-			     struct mlx5_aso_ct_pools_mng *ct_mng);
+int mlx5_aso_ct_queue_uninit(struct mlx5_aso_ct_pools_mng *ct_mng);
 int
 mlx5_aso_sq_create(struct mlx5_common_device *cdev, struct mlx5_aso_sq *sq,
 		   void *uar, uint16_t log_desc_n);
diff --git a/drivers/net/mlx5/mlx5_flow_aso.c b/drivers/net/mlx5/mlx5_flow_aso.c
index 5e2a81ef9c..cd84ab1966 100644
--- a/drivers/net/mlx5/mlx5_flow_aso.c
+++ b/drivers/net/mlx5/mlx5_flow_aso.c
@@ -19,17 +19,15 @@
 /**
  * Free MR resources.
  *
- * @param[in] cdev
- *   Pointer to the mlx5 common device.
  * @param[in] mr
  *   MR to free.
  */
 static void
-mlx5_aso_dereg_mr(struct mlx5_common_device *cdev, struct mlx5_pmd_mr *mr)
+mlx5_aso_dereg_mr(struct mlx5_pmd_mr *mr)
 {
 	void *addr = mr->addr;
 
-	cdev->mr_scache.dereg_mr_cb(mr);
+	mlx5_os_dereg_mr(mr);
 	mlx5_free(addr);
 	memset(mr, 0, sizeof(*mr));
 }
@@ -59,7 +57,7 @@ mlx5_aso_reg_mr(struct mlx5_common_device *cdev, size_t length,
 		DRV_LOG(ERR, "Failed to create ASO bits mem for MR.");
 		return -1;
 	}
-	ret = cdev->mr_scache.reg_mr_cb(cdev->pd, mr->addr, length, mr);
+	ret = mlx5_os_reg_mr(cdev->pd, mr->addr, length, mr);
 	if (ret) {
 		DRV_LOG(ERR, "Failed to create direct Mkey.");
 		mlx5_free(mr->addr);
@@ -362,7 +360,7 @@ mlx5_aso_queue_init(struct mlx5_dev_ctx_shared *sh,
 		if (mlx5_aso_sq_create(cdev, &sh->aso_age_mng->aso_sq,
 				       sh->tx_uar.obj,
 				       MLX5_ASO_QUEUE_LOG_DESC)) {
-			mlx5_aso_dereg_mr(cdev, &sh->aso_age_mng->aso_sq.mr);
+			mlx5_aso_dereg_mr(&sh->aso_age_mng->aso_sq.mr);
 			return -1;
 		}
 		mlx5_aso_age_init_sq(&sh->aso_age_mng->aso_sq);
@@ -399,14 +397,14 @@ mlx5_aso_queue_uninit(struct mlx5_dev_ctx_shared *sh,
 
 	switch (aso_opc_mod) {
 	case ASO_OPC_MOD_FLOW_HIT:
-		mlx5_aso_dereg_mr(sh->cdev, &sh->aso_age_mng->aso_sq.mr);
+		mlx5_aso_dereg_mr(&sh->aso_age_mng->aso_sq.mr);
 		sq = &sh->aso_age_mng->aso_sq;
 		break;
 	case ASO_OPC_MOD_POLICER:
 		mlx5_aso_mtr_queue_uninit(sh, NULL, &sh->mtrmng->pools_mng);
 		break;
 	case ASO_OPC_MOD_CONNECTION_TRACKING:
-		mlx5_aso_ct_queue_uninit(sh, sh->ct_mng);
+		mlx5_aso_ct_queue_uninit(sh->ct_mng);
 		break;
 	default:
 		DRV_LOG(ERR, "Unknown ASO operation mode");
@@ -1147,15 +1145,14 @@ __mlx5_aso_ct_get_pool(struct mlx5_dev_ctx_shared *sh,
 }
 
 int
-mlx5_aso_ct_queue_uninit(struct mlx5_dev_ctx_shared *sh,
-			 struct mlx5_aso_ct_pools_mng *ct_mng)
+mlx5_aso_ct_queue_uninit(struct mlx5_aso_ct_pools_mng *ct_mng)
 {
 	uint32_t i;
 
 	/* 64B per object for query. */
 	for (i = 0; i < ct_mng->nb_sq; i++) {
 		if (ct_mng->aso_sqs[i].mr.addr)
-			mlx5_aso_dereg_mr(sh->cdev, &ct_mng->aso_sqs[i].mr);
+			mlx5_aso_dereg_mr(&ct_mng->aso_sqs[i].mr);
 		mlx5_aso_destroy_sq(&ct_mng->aso_sqs[i]);
 	}
 	return 0;
@@ -1197,7 +1194,7 @@ mlx5_aso_ct_queue_init(struct mlx5_dev_ctx_shared *sh,
 error:
 	do {
 		if (ct_mng->aso_sqs[i].mr.addr)
-			mlx5_aso_dereg_mr(sh->cdev, &ct_mng->aso_sqs[i].mr);
+			mlx5_aso_dereg_mr(&ct_mng->aso_sqs[i].mr);
 		mlx5_aso_destroy_sq(&ct_mng->aso_sqs[i]);
 	} while (i--);
 	ct_mng->nb_sq = 0;
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index bca5b2769e..ac589c3ced 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -11096,12 +11096,9 @@ flow_hw_create_nic_ctrl_tables(struct rte_eth_dev *dev, struct rte_flow_error *e
 }
 
 static void
-flow_hw_ct_mng_destroy(struct rte_eth_dev *dev,
-		       struct mlx5_aso_ct_pools_mng *ct_mng)
+flow_hw_ct_mng_destroy(struct mlx5_aso_ct_pools_mng *ct_mng)
 {
-	struct mlx5_priv *priv = dev->data->dev_private;
-
-	mlx5_aso_ct_queue_uninit(priv->sh, ct_mng);
+	mlx5_aso_ct_queue_uninit(ct_mng);
 	mlx5_free(ct_mng);
 }
 
@@ -11240,7 +11237,7 @@ mlx5_flow_ct_init(struct rte_eth_dev *dev,
 		priv->hws_ctpool = NULL;
 	}
 	if (priv->ct_mng) {
-		flow_hw_ct_mng_destroy(dev, priv->ct_mng);
+		flow_hw_ct_mng_destroy(priv->ct_mng);
 		priv->ct_mng = NULL;
 	}
 	return ret;
@@ -11814,7 +11811,7 @@ __mlx5_flow_hw_resource_release(struct rte_eth_dev *dev, bool ctx_close)
 		priv->hws_ctpool = NULL;
 	}
 	if (priv->ct_mng) {
-		flow_hw_ct_mng_destroy(dev, priv->ct_mng);
+		flow_hw_ct_mng_destroy(priv->ct_mng);
 		priv->ct_mng = NULL;
 	}
 	mlx5_flow_quota_destroy(dev);
diff --git a/drivers/net/mlx5/mlx5_flow_quota.c b/drivers/net/mlx5/mlx5_flow_quota.c
index d94167d0b0..b661bd376e 100644
--- a/drivers/net/mlx5/mlx5_flow_quota.c
+++ b/drivers/net/mlx5/mlx5_flow_quota.c
@@ -412,12 +412,11 @@ mlx5_quota_alloc_sq(struct mlx5_priv *priv)
 static void
 mlx5_quota_destroy_read_buf(struct mlx5_priv *priv)
 {
-	struct mlx5_dev_ctx_shared *sh = priv->sh;
 	struct mlx5_quota_ctx *qctx = &priv->quota_ctx;
 
 	if (qctx->mr.lkey) {
 		void *addr = qctx->mr.addr;
-		sh->cdev->mr_scache.dereg_mr_cb(&qctx->mr);
+		mlx5_os_dereg_mr(&qctx->mr);
 		mlx5_free(addr);
 	}
 	if (qctx->read_buf)
@@ -446,8 +445,7 @@ mlx5_quota_alloc_read_buf(struct mlx5_priv *priv)
 		DRV_LOG(DEBUG, "QUOTA: failed to allocate MTR ASO READ buffer [1]");
 		return -ENOMEM;
 	}
-	ret = sh->cdev->mr_scache.reg_mr_cb(sh->cdev->pd, buf,
-					    rd_buf_size, &qctx->mr);
+	ret = mlx5_os_reg_mr(sh->cdev->pd, buf, rd_buf_size, &qctx->mr);
 	if (ret) {
 		DRV_LOG(DEBUG, "QUOTA: failed to register MTR ASO READ MR");
 		return -errno;
diff --git a/drivers/net/mlx5/mlx5_hws_cnt.c b/drivers/net/mlx5/mlx5_hws_cnt.c
index 1b6acb7a3b..d0c4ead71b 100644
--- a/drivers/net/mlx5/mlx5_hws_cnt.c
+++ b/drivers/net/mlx5/mlx5_hws_cnt.c
@@ -259,12 +259,11 @@ mlx5_hws_aging_check(struct mlx5_priv *priv, struct mlx5_hws_cnt_pool *cpool)
 }
 
 static void
-mlx5_hws_cnt_raw_data_free(struct mlx5_dev_ctx_shared *sh,
-			   struct mlx5_hws_cnt_raw_data_mng *mng)
+mlx5_hws_cnt_raw_data_free(struct mlx5_hws_cnt_raw_data_mng *mng)
 {
 	if (mng == NULL)
 		return;
-	sh->cdev->mr_scache.dereg_mr_cb(&mng->mr);
+	mlx5_os_dereg_mr(&mng->mr);
 	mlx5_free(mng->raw);
 	mlx5_free(mng);
 }
@@ -296,8 +295,7 @@ mlx5_hws_cnt_raw_data_alloc(struct mlx5_dev_ctx_shared *sh, uint32_t n,
 				   NULL, "failed to allocate raw counters memory");
 		goto error;
 	}
-	ret = sh->cdev->mr_scache.reg_mr_cb(sh->cdev->pd, mng->raw, sz,
-					    &mng->mr);
+	ret = mlx5_os_reg_mr(sh->cdev->pd, mng->raw, sz, &mng->mr);
 	if (ret) {
 		rte_flow_error_set(error, errno,
 				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
@@ -306,7 +304,7 @@ mlx5_hws_cnt_raw_data_alloc(struct mlx5_dev_ctx_shared *sh, uint32_t n,
 	}
 	return mng;
 error:
-	mlx5_hws_cnt_raw_data_free(sh, mng);
+	mlx5_hws_cnt_raw_data_free(mng);
 	return NULL;
 }
 
@@ -639,8 +637,7 @@ mlx5_hws_cnt_pool_dcs_alloc(struct mlx5_dev_ctx_shared *sh,
 }
 
 static void
-mlx5_hws_cnt_pool_dcs_free(struct mlx5_dev_ctx_shared *sh,
-			   struct mlx5_hws_cnt_pool *cpool)
+mlx5_hws_cnt_pool_dcs_free(struct mlx5_hws_cnt_pool *cpool)
 {
 	uint32_t idx;
 
@@ -649,7 +646,7 @@ mlx5_hws_cnt_pool_dcs_free(struct mlx5_dev_ctx_shared *sh,
 	for (idx = 0; idx < MLX5_HWS_CNT_DCS_NUM; idx++)
 		mlx5_devx_cmd_destroy(cpool->dcs_mng.dcs[idx].obj);
 	if (cpool->raw_mng) {
-		mlx5_hws_cnt_raw_data_free(sh, cpool->raw_mng);
+		mlx5_hws_cnt_raw_data_free(cpool->raw_mng);
 		cpool->raw_mng = NULL;
 	}
 }
@@ -842,8 +839,8 @@ mlx5_hws_cnt_pool_destroy(struct mlx5_dev_ctx_shared *sh,
 	}
 	mlx5_hws_cnt_pool_action_destroy(cpool);
 	if (cpool->cfg.host_cpool == NULL) {
-		mlx5_hws_cnt_pool_dcs_free(sh, cpool);
-		mlx5_hws_cnt_raw_data_free(sh, cpool->raw_mng);
+		mlx5_hws_cnt_pool_dcs_free(cpool);
+		mlx5_hws_cnt_raw_data_free(cpool->raw_mng);
 	}
 	mlx5_free((void *)cpool->cfg.name);
 	mlx5_hws_cnt_pool_deinit(cpool);
-- 
2.54.0

