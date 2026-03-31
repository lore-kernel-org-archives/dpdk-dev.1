Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1666C10F9304
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 21:41:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E033240DD3;
	Tue, 31 Mar 2026 23:41:42 +0200 (CEST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id A04D940DCE
 for <dev@dpdk.org>; Tue, 31 Mar 2026 23:41:41 +0200 (CEST)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-486fe655187so80378415e9.2
 for <dev@dpdk.org>; Tue, 31 Mar 2026 14:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774993301; x=1775598101; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lBZkYI/R5YmP3k7y+iSM05F3PtjUtx1n3/YvrHR468w=;
 b=QntAccmFPIHyrt+H1AomSs9n7Y3H7x2PYuuiIPBOfuKxZwH+3Rleg2ihITufN2ZwF5
 gLg3fkTkyM2Sg+ov5CCT2w/0nCY2Dp29zzYKoezN5SOf6kjIjWTRFaMiOAQp/tWZMohI
 3crlvZ8cypUxkgKxjmCe4m9DYIk6bxySiDZha4KLj0YSG4E9bKz01sOguDQtxvNM326r
 qnDuj47wgngruxXhsbejakN4szgmE1xRD8zho4OsuRYi/6RvGK/wOYom6K8AjcBxMVXc
 TvYyKvUIdFzL3h1bK9VGAiJx6xgx8VIq4wriTMc2bF4DB4kdOK1n9yVkbXa9GX96rWm6
 jA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774993301; x=1775598101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lBZkYI/R5YmP3k7y+iSM05F3PtjUtx1n3/YvrHR468w=;
 b=ZRwk6la4kfqDmzqQDtACDgkh4E8cR546DCXDBKB3hzhWsZexeB35LfpMqVxbbjHitc
 PmaqI49qaHUBSEnN4hf8mOP5aPV7BJSg/lN80LG3G14EgvFDLnEfZjsbrda+0TaoAgv+
 lw4oYkS/tMEhirpaUjeB3ryCiBmHfNhSF5hV/ZxW2BOeL1ce3dXJyH3668hq9pHrsKlE
 59Wv9cCxG9kLpaa9XNBE39LTBG6a2WAp9SdiZN20CotBYIs+5XYZm7X0XFBMdMUTx9Sg
 fducmLPXXtNpT//VxsQNdX1MOIjmsjeMWXSeY7XHIfQSmXfazAfJLTBd18KWsATqIrGR
 P5Ew==
X-Gm-Message-State: AOJu0YzH/bqVZgKOzRtOvXq9Rg/nqqVdOIvOwhrYfuxFlKo7bzxr3hf7
 FG27CrxX1crNWkN7xH1AFsHH9UMaPtsP8HTVBQQhc84+dIwM1lo7jTrmCxVVNA==
X-Gm-Gg: ATEYQzzHmr0tzrrztbhP9Pk82+q5JvpXYsbcfGAL9agfNnSrAbJklgmIHtpJkV8L1A3
 KCnDBlE3GPzbhChv8pSfLES7JmPbb4b8/8LdfsCT5OxOrphF/oqmGtiJM7yDg6OYF6Z762TsVA9
 leAr46R4FjFES+oBQUIQddNZLwpV3h8yMsj+M4wVfNTGJwUBACZknrgxs5+YqDPXg80cPGTRQ8g
 7duSPC21ChkFZ+NLsspYbd6GUo9zpnZJsx8fEUGICMHk45sXAp8RrSzz+2lR8Ie7q67McFtV53c
 QIPdUuRGy7+dl3Yxma+oOguHjYWQaZS/uUWhofpQ48pbhpT8+lGdsSGB027yct2VX0RK3gCzkjq
 ad3VTTHTpS7lidybwkDFA08SgP7VDL8u/71PNpwUEgh1o5k+O/xlGZ4ml8d+uJnPUBSoUv0OCUh
 Md/CVUtAetU9UkBk1fmdpuJr1G3x8=
X-Received: by 2002:a05:600c:3e1b:b0:485:ae14:8173 with SMTP id
 5b1f17b1804b1-4888355e47fmr16948125e9.1.1774993300959; 
 Tue, 31 Mar 2026 14:41:40 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:5eee:7f89:5053:515f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c561750sm89755295e9.2.2026.03.31.14.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 14:41:40 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com, rjarry@redhat.com,
 Maxime Leroy <maxime@leroys.fr>
Subject: [RFC 3/5] fib: add shared tbl8 pool
Date: Tue, 31 Mar 2026 23:41:15 +0200
Message-ID: <20260331214117.142495-4-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331214117.142495-1-maxime@leroys.fr>
References: <20260331214117.142495-1-maxime@leroys.fr>
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

Replace the per-FIB tbl8 allocation with a common refcounted tbl8
pool (fib_tbl8_pool).

A FIB can either use an internal pool (created transparently from the
existing num_tbl8 config parameter) or attach to an external shared
pool via the new tbl8_pool config field. The shared pool allows
multiple FIB instances (e.g. one per VRF) to draw tbl8 groups from
the same memory, reducing overall allocation.

The pool is refcounted: internal pools start at refcount 1 and are
freed when the owning FIB is destroyed. External pools are
incremented on FIB attach and decremented on FIB detach; the creator
releases its reference via rte_fib_tbl8_pool_free().

The per-FIB RCU defer queue callback is shared across both backends
(fib_tbl8_pool_rcu_free_cb).

New public API:
  - rte_fib_tbl8_pool_create()
  - rte_fib_tbl8_pool_free()

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 lib/fib/dir24_8.c           | 128 ++++++++++---------------------
 lib/fib/dir24_8.h           |   6 +-
 lib/fib/fib_tbl8_pool.c     | 148 ++++++++++++++++++++++++++++++++++++
 lib/fib/fib_tbl8_pool.h     |  74 ++++++++++++++++++
 lib/fib/meson.build         |   5 +-
 lib/fib/rte_fib.h           |   3 +
 lib/fib/rte_fib6.h          |   3 +
 lib/fib/rte_fib_tbl8_pool.h |  76 ++++++++++++++++++
 lib/fib/trie.c              | 134 ++++++++++----------------------
 lib/fib/trie.h              |   6 +-
 10 files changed, 394 insertions(+), 189 deletions(-)
 create mode 100644 lib/fib/fib_tbl8_pool.c
 create mode 100644 lib/fib/fib_tbl8_pool.h
 create mode 100644 lib/fib/rte_fib_tbl8_pool.h

diff --git a/lib/fib/dir24_8.c b/lib/fib/dir24_8.c
index 935eca12c3..b8e588a56a 100644
--- a/lib/fib/dir24_8.c
+++ b/lib/fib/dir24_8.c
@@ -152,41 +152,18 @@ dir24_8_get_lookup_fn(void *p, enum rte_fib_lookup_type type, bool be_addr)
 	return NULL;
 }
 
-/*
- * Get an index of a free tbl8 from the pool
- */
-static inline int32_t
-tbl8_get(struct dir24_8_tbl *dp)
-{
-	if (dp->tbl8_pool_pos == dp->number_tbl8s)
-		/* no more free tbl8 */
-		return -ENOSPC;
-
-	/* next index */
-	return dp->tbl8_pool[dp->tbl8_pool_pos++];
-}
-
-/*
- * Put an index of a free tbl8 back to the pool
- */
-static inline void
-tbl8_put(struct dir24_8_tbl *dp, uint32_t tbl8_ind)
-{
-	dp->tbl8_pool[--dp->tbl8_pool_pos] = tbl8_ind;
-}
-
 static int
 tbl8_alloc(struct dir24_8_tbl *dp, uint64_t nh)
 {
 	int64_t	tbl8_idx;
 	uint8_t	*tbl8_ptr;
 
-	tbl8_idx = tbl8_get(dp);
+	tbl8_idx = fib_tbl8_pool_get(dp->pool);
 
 	/* If there are no tbl8 groups try to reclaim one. */
 	if (unlikely(tbl8_idx == -ENOSPC && dp->dq &&
 			!rte_rcu_qsbr_dq_reclaim(dp->dq, 1, NULL, NULL, NULL)))
-		tbl8_idx = tbl8_get(dp);
+		tbl8_idx = fib_tbl8_pool_get(dp->pool);
 
 	if (tbl8_idx < 0)
 		return tbl8_idx;
@@ -200,24 +177,6 @@ tbl8_alloc(struct dir24_8_tbl *dp, uint64_t nh)
 	return tbl8_idx;
 }
 
-static void
-tbl8_cleanup_and_free(struct dir24_8_tbl *dp, uint64_t tbl8_idx)
-{
-	uint8_t *ptr = (uint8_t *)dp->tbl8 + (tbl8_idx * FIB_TBL8_GRP_NUM_ENT << dp->nh_sz);
-
-	memset(ptr, 0, FIB_TBL8_GRP_NUM_ENT << dp->nh_sz);
-	tbl8_put(dp, tbl8_idx);
-}
-
-static void
-__rcu_qsbr_free_resource(void *p, void *data, unsigned int n __rte_unused)
-{
-	struct dir24_8_tbl *dp = p;
-	uint64_t tbl8_idx = *(uint64_t *)data;
-
-	tbl8_cleanup_and_free(dp, tbl8_idx);
-}
-
 static void
 tbl8_recycle(struct dir24_8_tbl *dp, uint32_t ip, uint64_t tbl8_idx)
 {
@@ -276,10 +235,10 @@ tbl8_recycle(struct dir24_8_tbl *dp, uint32_t ip, uint64_t tbl8_idx)
 	}
 
 	if (dp->v == NULL) {
-		tbl8_cleanup_and_free(dp, tbl8_idx);
+		fib_tbl8_pool_cleanup_and_free(dp->pool, tbl8_idx);
 	} else if (dp->rcu_mode == RTE_FIB_QSBR_MODE_SYNC) {
 		rte_rcu_qsbr_synchronize(dp->v, RTE_QSBR_THRID_INVALID);
-		tbl8_cleanup_and_free(dp, tbl8_idx);
+		fib_tbl8_pool_cleanup_and_free(dp->pool, tbl8_idx);
 	} else { /* RTE_FIB_QSBR_MODE_DQ */
 		if (rte_rcu_qsbr_dq_enqueue(dp->dq, &tbl8_idx))
 			FIB_LOG(ERR, "Failed to push QSBR FIFO");
@@ -310,14 +269,14 @@ install_to_fib(struct dir24_8_tbl *dp, uint32_t ledge, uint32_t redge,
 				 * needs tbl8 for ledge and redge.
 				 */
 				tbl8_idx = tbl8_alloc(dp, tbl24_tmp);
-				tmp_tbl8_idx = tbl8_get(dp);
+				tmp_tbl8_idx = fib_tbl8_pool_get(dp->pool);
 				if (tbl8_idx < 0)
 					return -ENOSPC;
 				else if (tmp_tbl8_idx < 0) {
-					tbl8_put(dp, tbl8_idx);
+					fib_tbl8_pool_cleanup_and_free(dp->pool, tbl8_idx);
 					return -ENOSPC;
 				}
-				tbl8_put(dp, tmp_tbl8_idx);
+				fib_tbl8_pool_put(dp->pool, tmp_tbl8_idx);
 				/*update dir24 entry with tbl8 index*/
 				fib_tbl8_write(get_tbl24_p(dp, ledge,
 					dp->nh_sz), (tbl8_idx << 1)|
@@ -477,7 +436,7 @@ dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 			tmp = rte_rib_get_nxt(rib, ip, 24, NULL,
 				RTE_RIB_GET_NXT_COVER);
 			if ((tmp == NULL) &&
-				(dp->rsvd_tbl8s >= dp->number_tbl8s))
+				(dp->rsvd_tbl8s >= dp->pool->num_tbl8s))
 				return -ENOSPC;
 
 		}
@@ -533,18 +492,13 @@ dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
 {
 	char mem_name[DIR24_8_NAMESIZE];
 	struct dir24_8_tbl *dp;
+	struct rte_fib_tbl8_pool *pool;
 	uint64_t	def_nh;
-	uint64_t	tbl8_sz;
-	uint32_t	num_tbl8;
-	uint32_t	i;
 	enum rte_fib_dir24_8_nh_sz	nh_sz;
 
 	if ((name == NULL) || (fib_conf == NULL) ||
 			(fib_conf->dir24_8.nh_sz < RTE_FIB_DIR24_8_1B) ||
 			(fib_conf->dir24_8.nh_sz > RTE_FIB_DIR24_8_8B) ||
-			(fib_conf->dir24_8.num_tbl8 >
-			get_max_nh(fib_conf->dir24_8.nh_sz)) ||
-			(fib_conf->dir24_8.num_tbl8 == 0) ||
 			(fib_conf->default_nh >
 			get_max_nh(fib_conf->dir24_8.nh_sz))) {
 		rte_errno = EINVAL;
@@ -553,46 +507,47 @@ dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
 
 	def_nh = fib_conf->default_nh;
 	nh_sz = fib_conf->dir24_8.nh_sz;
-	num_tbl8 = fib_conf->dir24_8.num_tbl8;
+
+	if (fib_conf->dir24_8.tbl8_pool != NULL) {
+		/* External shared pool */
+		pool = fib_conf->dir24_8.tbl8_pool;
+		if (pool->nh_sz != nh_sz) {
+			rte_errno = EINVAL;
+			return NULL;
+		}
+		fib_tbl8_pool_ref(pool);
+	} else {
+		/* Internal pool */
+		if ((fib_conf->dir24_8.num_tbl8 >
+		     get_max_nh(fib_conf->dir24_8.nh_sz)) ||
+		    (fib_conf->dir24_8.num_tbl8 == 0)) {
+			rte_errno = EINVAL;
+			return NULL;
+		}
+		struct rte_fib_tbl8_pool_conf pool_conf = {
+			.num_tbl8 = fib_conf->dir24_8.num_tbl8,
+			.nh_sz = nh_sz,
+			.socket_id = socket_id,
+		};
+		pool = rte_fib_tbl8_pool_create(name, &pool_conf);
+		if (pool == NULL)
+			return NULL;
+	}
 
 	snprintf(mem_name, sizeof(mem_name), "DP_%s", name);
 	dp = rte_zmalloc_socket(name, sizeof(struct dir24_8_tbl) +
 		DIR24_8_TBL24_NUM_ENT * (1 << nh_sz) + sizeof(uint32_t),
 		RTE_CACHE_LINE_SIZE, socket_id);
 	if (dp == NULL) {
+		fib_tbl8_pool_unref(pool);
 		rte_errno = ENOMEM;
 		return NULL;
 	}
 
-	snprintf(mem_name, sizeof(mem_name), "TBL8_%p", dp);
-	tbl8_sz = FIB_TBL8_GRP_NUM_ENT * (1ULL << nh_sz) *
-			(num_tbl8 + 1);
-	dp->tbl8 = rte_zmalloc_socket(mem_name, tbl8_sz,
-			RTE_CACHE_LINE_SIZE, socket_id);
-	if (dp->tbl8 == NULL) {
-		rte_errno = ENOMEM;
-		rte_free(dp);
-		return NULL;
-	}
+	dp->pool = pool;
+	dp->tbl8 = pool->tbl8;
 	dp->def_nh = def_nh;
 	dp->nh_sz = nh_sz;
-	dp->number_tbl8s = num_tbl8;
-
-	snprintf(mem_name, sizeof(mem_name), "TBL8_idxes_%p", dp);
-	dp->tbl8_pool = rte_zmalloc_socket(mem_name,
-			sizeof(uint32_t) * dp->number_tbl8s,
-			RTE_CACHE_LINE_SIZE, socket_id);
-	if (dp->tbl8_pool == NULL) {
-		rte_errno = ENOMEM;
-		rte_free(dp->tbl8);
-		rte_free(dp);
-		return NULL;
-	}
-
-	/* Init pool with all tbl8 indices free */
-	for (i = 0; i < dp->number_tbl8s; i++)
-		dp->tbl8_pool[i] = i;
-	dp->tbl8_pool_pos = 0;
 
 	/* Init table with default value */
 	fib_tbl8_write(dp->tbl24, (def_nh << 1), nh_sz, 1 << 24);
@@ -606,8 +561,7 @@ dir24_8_free(void *p)
 	struct dir24_8_tbl *dp = (struct dir24_8_tbl *)p;
 
 	rte_rcu_qsbr_dq_delete(dp->dq);
-	rte_free(dp->tbl8_pool);
-	rte_free(dp->tbl8);
+	fib_tbl8_pool_unref(dp->pool);
 	rte_free(dp);
 }
 
@@ -639,8 +593,8 @@ dir24_8_rcu_qsbr_add(struct dir24_8_tbl *dp, struct rte_fib_rcu_config *cfg,
 		if (params.max_reclaim_size == 0)
 			params.max_reclaim_size = RTE_FIB_RCU_DQ_RECLAIM_MAX;
 		params.esize = sizeof(uint64_t);
-		params.free_fn = __rcu_qsbr_free_resource;
-		params.p = dp;
+		params.free_fn = fib_tbl8_pool_rcu_free_cb;
+		params.p = dp->pool;
 		params.v = cfg->v;
 		dp->dq = rte_rcu_qsbr_dq_create(&params);
 		if (dp->dq == NULL) {
diff --git a/lib/fib/dir24_8.h b/lib/fib/dir24_8.h
index e75bd120ad..287b91ef4b 100644
--- a/lib/fib/dir24_8.h
+++ b/lib/fib/dir24_8.h
@@ -14,7 +14,7 @@
 #include <rte_branch_prediction.h>
 #include <rte_rcu_qsbr.h>
 
-#include "fib_tbl8.h"
+#include "fib_tbl8_pool.h"
 
 /**
  * @file
@@ -26,9 +26,7 @@
 #define DIR24_8_TBL24_MASK		0xffffff00
 
 struct dir24_8_tbl {
-	uint32_t	number_tbl8s;	/**< Total number of tbl8s */
 	uint32_t	rsvd_tbl8s;	/**< Number of reserved tbl8s */
-	uint32_t	tbl8_pool_pos;	/**< Next free index in pool */
 	enum rte_fib_dir24_8_nh_sz	nh_sz;	/**< Size of nexthop entry */
 	/* RCU config. */
 	enum rte_fib_qsbr_mode rcu_mode;/* Blocking, defer queue. */
@@ -36,7 +34,7 @@ struct dir24_8_tbl {
 	struct rte_rcu_qsbr_dq *dq;	/* RCU QSBR defer queue. */
 	uint64_t	def_nh;		/**< Default next hop */
 	uint64_t	*tbl8;		/**< tbl8 table. */
-	uint32_t	*tbl8_pool;	/**< Stack of free tbl8 indices */
+	struct rte_fib_tbl8_pool *pool;	/**< tbl8 pool */
 	/* tbl24 table. */
 	alignas(RTE_CACHE_LINE_SIZE) uint64_t	tbl24[];
 };
diff --git a/lib/fib/fib_tbl8_pool.c b/lib/fib/fib_tbl8_pool.c
new file mode 100644
index 0000000000..5f8ba74219
--- /dev/null
+++ b/lib/fib/fib_tbl8_pool.c
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Maxime Leroy, Free Mobile
+ */
+
+#include <stdint.h>
+#include <string.h>
+
+#include <eal_export.h>
+#include <rte_debug.h>
+#include <rte_errno.h>
+#include <rte_malloc.h>
+
+#include "fib_tbl8_pool.h"
+
+static void
+pool_init_free_list(struct rte_fib_tbl8_pool *pool)
+{
+	uint32_t i;
+
+	/* put entire range of indexes to the tbl8 pool */
+	for (i = 0; i < pool->num_tbl8s; i++)
+		pool->free_list[i] = i;
+
+	pool->cur_tbl8s = 0;
+}
+
+int32_t
+fib_tbl8_pool_get(struct rte_fib_tbl8_pool *pool)
+{
+	if (pool->cur_tbl8s == pool->num_tbl8s)
+		/* no more free tbl8 */
+		return -ENOSPC;
+
+	/* next index */
+	return pool->free_list[pool->cur_tbl8s++];
+}
+
+void
+fib_tbl8_pool_put(struct rte_fib_tbl8_pool *pool, uint32_t idx)
+{
+	RTE_ASSERT(pool->cur_tbl8s > 0);
+	pool->free_list[--pool->cur_tbl8s] = idx;
+}
+
+void
+fib_tbl8_pool_cleanup_and_free(struct rte_fib_tbl8_pool *pool, uint64_t idx)
+{
+	uint8_t *ptr = (uint8_t *)pool->tbl8 +
+		((idx * FIB_TBL8_GRP_NUM_ENT) << pool->nh_sz);
+
+	memset(ptr, 0, FIB_TBL8_GRP_NUM_ENT << pool->nh_sz);
+	fib_tbl8_pool_put(pool, idx);
+}
+
+void
+fib_tbl8_pool_rcu_free_cb(void *p, void *data,
+			  unsigned int n __rte_unused)
+{
+	struct rte_fib_tbl8_pool *pool = p;
+	uint64_t tbl8_idx = *(uint64_t *)data;
+
+	fib_tbl8_pool_cleanup_and_free(pool, tbl8_idx);
+}
+
+void
+fib_tbl8_pool_ref(struct rte_fib_tbl8_pool *pool)
+{
+	pool->refcnt++;
+}
+
+static void
+pool_free(struct rte_fib_tbl8_pool *pool)
+{
+	rte_free(pool->free_list);
+	rte_free(pool->tbl8);
+	rte_free(pool);
+}
+
+void
+fib_tbl8_pool_unref(struct rte_fib_tbl8_pool *pool)
+{
+	if (--pool->refcnt == 0)
+		pool_free(pool);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib_tbl8_pool_create, 26.07)
+struct rte_fib_tbl8_pool *
+rte_fib_tbl8_pool_create(const char *name,
+			 const struct rte_fib_tbl8_pool_conf *conf)
+{
+	struct rte_fib_tbl8_pool *pool;
+	char mem_name[64];
+
+	if (name == NULL || conf == NULL || conf->num_tbl8 == 0 ||
+	    conf->nh_sz > 3) {
+		rte_errno = EINVAL;
+		return NULL;
+	}
+
+	snprintf(mem_name, sizeof(mem_name), "TBL8_POOL_%s", name);
+	pool = rte_zmalloc_socket(mem_name, sizeof(*pool),
+		RTE_CACHE_LINE_SIZE, conf->socket_id);
+	if (pool == NULL) {
+		rte_errno = ENOMEM;
+		return NULL;
+	}
+
+	pool->nh_sz = conf->nh_sz;
+	pool->num_tbl8s = conf->num_tbl8;
+	pool->socket_id = conf->socket_id;
+	pool->refcnt = 1;
+
+	snprintf(mem_name, sizeof(mem_name), "TBL8_%s", name);
+	pool->tbl8 = rte_zmalloc_socket(mem_name,
+		FIB_TBL8_GRP_NUM_ENT * (1ULL << pool->nh_sz) *
+		(pool->num_tbl8s + 1),
+		RTE_CACHE_LINE_SIZE, conf->socket_id);
+	if (pool->tbl8 == NULL) {
+		rte_errno = ENOMEM;
+		rte_free(pool);
+		return NULL;
+	}
+
+	snprintf(mem_name, sizeof(mem_name), "TBL8_FL_%s", name);
+	pool->free_list = rte_zmalloc_socket(mem_name,
+		sizeof(uint32_t) * pool->num_tbl8s,
+		RTE_CACHE_LINE_SIZE, conf->socket_id);
+	if (pool->free_list == NULL) {
+		rte_errno = ENOMEM;
+		rte_free(pool->tbl8);
+		rte_free(pool);
+		return NULL;
+	}
+
+	pool_init_free_list(pool);
+
+	return pool;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib_tbl8_pool_free, 26.07)
+void
+rte_fib_tbl8_pool_free(struct rte_fib_tbl8_pool *pool)
+{
+	if (pool == NULL)
+		return;
+
+	fib_tbl8_pool_unref(pool);
+}
diff --git a/lib/fib/fib_tbl8_pool.h b/lib/fib/fib_tbl8_pool.h
new file mode 100644
index 0000000000..285f06d87f
--- /dev/null
+++ b/lib/fib/fib_tbl8_pool.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Maxime Leroy, Free Mobile
+ */
+
+#ifndef _FIB_TBL8_POOL_H_
+#define _FIB_TBL8_POOL_H_
+
+/**
+ * @file
+ * Internal tbl8 pool header.
+ *
+ * The pool is not thread-safe. When multiple FIBs share a pool,
+ * all operations (route modifications, FIB creation/destruction)
+ * must be serialized by the caller.
+ */
+
+#include <stdint.h>
+#include <string.h>
+
+#include <rte_common.h>
+
+#include "fib_tbl8.h"
+#include "rte_fib_tbl8_pool.h"
+
+struct rte_fib_tbl8_pool {
+	uint64_t	*tbl8;		/**< tbl8 group array */
+	uint32_t	*free_list;	/**< Stack of free group indices */
+	uint32_t	cur_tbl8s;	/**< Number of allocated groups */
+	uint32_t	num_tbl8s;	/**< Total number of tbl8 groups */
+	uint8_t		nh_sz;		/**< Nexthop entry size (0-3) */
+	int		socket_id;
+	uint32_t	refcnt;		/**< Reference count */
+};
+
+/**
+ * Get a free tbl8 group index from the pool.
+ * @return index on success, -ENOSPC if pool is full
+ */
+int32_t
+fib_tbl8_pool_get(struct rte_fib_tbl8_pool *pool);
+
+/**
+ * Return a tbl8 group index to the pool.
+ */
+void
+fib_tbl8_pool_put(struct rte_fib_tbl8_pool *pool, uint32_t idx);
+
+/**
+ * Clear a tbl8 group and return its index to the pool.
+ */
+void
+fib_tbl8_pool_cleanup_and_free(struct rte_fib_tbl8_pool *pool, uint64_t idx);
+
+/**
+ * RCU defer queue callback for tbl8 group reclamation.
+ * Shared by dir24_8 and trie backends.
+ * Use as params.free_fn with params.p = pool.
+ */
+void
+fib_tbl8_pool_rcu_free_cb(void *p, void *data, unsigned int n);
+
+/**
+ * Increment pool reference count.
+ */
+void
+fib_tbl8_pool_ref(struct rte_fib_tbl8_pool *pool);
+
+/**
+ * Decrement pool reference count. Free the pool if it reaches 0.
+ */
+void
+fib_tbl8_pool_unref(struct rte_fib_tbl8_pool *pool);
+
+#endif /* _FIB_TBL8_POOL_H_ */
diff --git a/lib/fib/meson.build b/lib/fib/meson.build
index 573fc50ff1..6ecd954b26 100644
--- a/lib/fib/meson.build
+++ b/lib/fib/meson.build
@@ -2,8 +2,9 @@
 # Copyright(c) 2018 Vladimir Medvedkin <medvedkinv@gmail.com>
 # Copyright(c) 2019 Intel Corporation
 
-sources = files('rte_fib.c', 'rte_fib6.c', 'dir24_8.c', 'trie.c')
-headers = files('rte_fib.h', 'rte_fib6.h')
+sources = files('rte_fib.c', 'rte_fib6.c', 'dir24_8.c', 'trie.c',
+	'fib_tbl8_pool.c')
+headers = files('rte_fib.h', 'rte_fib6.h', 'rte_fib_tbl8_pool.h')
 deps += ['rib']
 deps += ['rcu']
 deps += ['net']
diff --git a/lib/fib/rte_fib.h b/lib/fib/rte_fib.h
index b16a653535..b8c86566ad 100644
--- a/lib/fib/rte_fib.h
+++ b/lib/fib/rte_fib.h
@@ -19,6 +19,7 @@
 
 #include <rte_common.h>
 #include <rte_rcu_qsbr.h>
+#include <rte_fib_tbl8_pool.h>
 
 #ifdef __cplusplus
 extern "C" {
@@ -107,6 +108,8 @@ struct rte_fib_conf {
 		struct {
 			enum rte_fib_dir24_8_nh_sz nh_sz;
 			uint32_t	num_tbl8;
+			/** Shared tbl8 pool (NULL = internal pool) */
+			struct rte_fib_tbl8_pool *tbl8_pool;
 		} dir24_8;
 	};
 	unsigned int flags; /**< Optional feature flags from RTE_FIB_F_* */
diff --git a/lib/fib/rte_fib6.h b/lib/fib/rte_fib6.h
index 4527328bf0..655a4c9501 100644
--- a/lib/fib/rte_fib6.h
+++ b/lib/fib/rte_fib6.h
@@ -20,6 +20,7 @@
 #include <rte_common.h>
 #include <rte_ip6.h>
 #include <rte_rcu_qsbr.h>
+#include <rte_fib_tbl8_pool.h>
 
 #ifdef __cplusplus
 extern "C" {
@@ -95,6 +96,8 @@ struct rte_fib6_conf {
 		struct {
 			enum rte_fib_trie_nh_sz nh_sz;
 			uint32_t	num_tbl8;
+			/** Shared tbl8 pool (NULL = internal pool) */
+			struct rte_fib_tbl8_pool *tbl8_pool;
 		} trie;
 	};
 };
diff --git a/lib/fib/rte_fib_tbl8_pool.h b/lib/fib/rte_fib_tbl8_pool.h
new file mode 100644
index 0000000000..e362efe74b
--- /dev/null
+++ b/lib/fib/rte_fib_tbl8_pool.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Maxime Leroy, Free Mobile
+ */
+
+#ifndef _RTE_FIB_TBL8_POOL_H_
+#define _RTE_FIB_TBL8_POOL_H_
+
+/**
+ * @file
+ * Shared tbl8 pool for FIB backends.
+ *
+ * A tbl8 pool manages a shared array of tbl8 groups that can be used
+ * across multiple FIB instances (e.g., one per VRF).
+ *
+ * Two modes of operation:
+ *  - Internal pool: set num_tbl8 in the FIB config and leave tbl8_pool
+ *    NULL. The pool is created and destroyed with the FIB.
+ *  - External shared pool: create with rte_fib_tbl8_pool_create(), pass
+ *    the handle via the tbl8_pool config field. Each FIB holds a
+ *    reference; the creator releases its reference with
+ *    rte_fib_tbl8_pool_free(). The pool is freed when the last
+ *    reference is dropped.
+ *
+ * Thread safety: none. The pool is not thread-safe. All operations
+ * on FIBs sharing the same pool (route updates, FIB creation and
+ * destruction, pool create/free) must be serialized by the caller.
+ */
+
+#include <stdint.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct rte_fib_tbl8_pool;
+
+/** tbl8 pool configuration */
+struct rte_fib_tbl8_pool_conf {
+	uint32_t num_tbl8;	/**< Number of tbl8 groups */
+	uint8_t  nh_sz;		/**< Nexthop size: 0=1B, 1=2B, 2=4B, 3=8B */
+	int      socket_id;	/**< NUMA socket for memory allocation */
+};
+
+/**
+ * Create a tbl8 pool.
+ *
+ * @param name
+ *   Pool name (for memory allocation tracking)
+ * @param conf
+ *   Pool configuration
+ * @return
+ *   Pool handle on success, NULL on failure with rte_errno set
+ */
+__rte_experimental
+struct rte_fib_tbl8_pool *
+rte_fib_tbl8_pool_create(const char *name,
+			 const struct rte_fib_tbl8_pool_conf *conf);
+
+/**
+ * Release the creator's reference on a tbl8 pool.
+ *
+ * The pool is freed when the last reference is dropped (i.e. after
+ * all FIBs using this pool have been destroyed).
+ *
+ * @param pool
+ *   Pool handle (NULL is allowed)
+ */
+__rte_experimental
+void
+rte_fib_tbl8_pool_free(struct rte_fib_tbl8_pool *pool);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _RTE_FIB_TBL8_POOL_H_ */
diff --git a/lib/fib/trie.c b/lib/fib/trie.c
index 198fc54395..798d322b1e 100644
--- a/lib/fib/trie.c
+++ b/lib/fib/trie.c
@@ -99,53 +99,18 @@ trie_get_lookup_fn(void *p, enum rte_fib6_lookup_type type)
 	return NULL;
 }
 
-static void
-tbl8_pool_init(struct rte_trie_tbl *dp)
-{
-	uint32_t i;
-
-	/* put entire range of indexes to the tbl8 pool */
-	for (i = 0; i < dp->number_tbl8s; i++)
-		dp->tbl8_pool[i] = i;
-
-	dp->tbl8_pool_pos = 0;
-}
-
-/*
- * Get an index of a free tbl8 from the pool
- */
-static inline int32_t
-tbl8_get(struct rte_trie_tbl *dp)
-{
-	if (dp->tbl8_pool_pos == dp->number_tbl8s)
-		/* no more free tbl8 */
-		return -ENOSPC;
-
-	/* next index */
-	return dp->tbl8_pool[dp->tbl8_pool_pos++];
-}
-
-/*
- * Put an index of a free tbl8 back to the pool
- */
-static inline void
-tbl8_put(struct rte_trie_tbl *dp, uint32_t tbl8_ind)
-{
-	dp->tbl8_pool[--dp->tbl8_pool_pos] = tbl8_ind;
-}
-
 static int
 tbl8_alloc(struct rte_trie_tbl *dp, uint64_t nh)
 {
 	int64_t		tbl8_idx;
 	uint8_t		*tbl8_ptr;
 
-	tbl8_idx = tbl8_get(dp);
+	tbl8_idx = fib_tbl8_pool_get(dp->pool);
 
 	/* If there are no tbl8 groups try to reclaim one. */
 	if (unlikely(tbl8_idx == -ENOSPC && dp->dq &&
 			!rte_rcu_qsbr_dq_reclaim(dp->dq, 1, NULL, NULL, NULL)))
-		tbl8_idx = tbl8_get(dp);
+		tbl8_idx = fib_tbl8_pool_get(dp->pool);
 
 	if (tbl8_idx < 0)
 		return tbl8_idx;
@@ -157,23 +122,6 @@ tbl8_alloc(struct rte_trie_tbl *dp, uint64_t nh)
 	return tbl8_idx;
 }
 
-static void
-tbl8_cleanup_and_free(struct rte_trie_tbl *dp, uint64_t tbl8_idx)
-{
-	uint8_t *ptr = (uint8_t *)dp->tbl8 + (tbl8_idx * FIB_TBL8_GRP_NUM_ENT << dp->nh_sz);
-
-	memset(ptr, 0, FIB_TBL8_GRP_NUM_ENT << dp->nh_sz);
-	tbl8_put(dp, tbl8_idx);
-}
-
-static void
-__rcu_qsbr_free_resource(void *p, void *data, unsigned int n __rte_unused)
-{
-	struct rte_trie_tbl *dp = p;
-	uint64_t tbl8_idx = *(uint64_t *)data;
-	tbl8_cleanup_and_free(dp, tbl8_idx);
-}
-
 static void
 tbl8_recycle(struct rte_trie_tbl *dp, void *par, uint64_t tbl8_idx)
 {
@@ -223,10 +171,10 @@ tbl8_recycle(struct rte_trie_tbl *dp, void *par, uint64_t tbl8_idx)
 	}
 
 	if (dp->v == NULL) {
-		tbl8_cleanup_and_free(dp, tbl8_idx);
+		fib_tbl8_pool_cleanup_and_free(dp->pool, tbl8_idx);
 	} else if (dp->rcu_mode == RTE_FIB6_QSBR_MODE_SYNC) {
 		rte_rcu_qsbr_synchronize(dp->v, RTE_QSBR_THRID_INVALID);
-		tbl8_cleanup_and_free(dp, tbl8_idx);
+		fib_tbl8_pool_cleanup_and_free(dp->pool, tbl8_idx);
 	} else { /* RTE_FIB6_QSBR_MODE_DQ */
 		if (rte_rcu_qsbr_dq_enqueue(dp->dq, &tbl8_idx))
 			FIB_LOG(ERR, "Failed to push QSBR FIFO");
@@ -583,7 +531,7 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 			return 0;
 		}
 
-		if ((depth > 24) && (dp->rsvd_tbl8s + depth_diff > dp->number_tbl8s))
+		if ((depth > 24) && (dp->rsvd_tbl8s + depth_diff > dp->pool->num_tbl8s))
 			return -ENOSPC;
 
 		node = rte_rib6_insert(rib, &ip_masked, depth);
@@ -636,63 +584,66 @@ trie_create(const char *name, int socket_id,
 {
 	char mem_name[TRIE_NAMESIZE];
 	struct rte_trie_tbl *dp = NULL;
+	struct rte_fib_tbl8_pool *pool;
 	uint64_t	def_nh;
-	uint32_t	num_tbl8;
 	enum rte_fib_trie_nh_sz	nh_sz;
 
 	if ((name == NULL) || (conf == NULL) ||
 			(conf->trie.nh_sz < RTE_FIB6_TRIE_2B) ||
 			(conf->trie.nh_sz > RTE_FIB6_TRIE_8B) ||
-			(conf->trie.num_tbl8 >
-			get_max_nh(conf->trie.nh_sz)) ||
-			(conf->trie.num_tbl8 == 0) ||
 			(conf->default_nh >
 			get_max_nh(conf->trie.nh_sz))) {
-
 		rte_errno = EINVAL;
 		return NULL;
 	}
 
 	def_nh = conf->default_nh;
 	nh_sz = conf->trie.nh_sz;
-	num_tbl8 = conf->trie.num_tbl8;
+
+	if (conf->trie.tbl8_pool != NULL) {
+		/* External shared pool: validate nh_sz matches. */
+		pool = conf->trie.tbl8_pool;
+		if (pool->nh_sz != nh_sz) {
+			rte_errno = EINVAL;
+			return NULL;
+		}
+		fib_tbl8_pool_ref(pool);
+	} else {
+		/* Internal pool: create from config. */
+		struct rte_fib_tbl8_pool_conf pool_conf = {
+			.num_tbl8 = conf->trie.num_tbl8,
+			.nh_sz = nh_sz,
+			.socket_id = socket_id,
+		};
+
+		if (conf->trie.num_tbl8 == 0 ||
+		    conf->trie.num_tbl8 >
+		    get_max_nh(nh_sz)) {
+			rte_errno = EINVAL;
+			return NULL;
+		}
+
+		pool = rte_fib_tbl8_pool_create(name, &pool_conf);
+		if (pool == NULL)
+			return NULL;
+	}
 
 	snprintf(mem_name, sizeof(mem_name), "DP_%s", name);
 	dp = rte_zmalloc_socket(name, sizeof(struct rte_trie_tbl) +
 		TRIE_TBL24_NUM_ENT * (1 << nh_sz) + sizeof(uint32_t),
 		RTE_CACHE_LINE_SIZE, socket_id);
 	if (dp == NULL) {
+		fib_tbl8_pool_unref(pool);
 		rte_errno = ENOMEM;
-		return dp;
-	}
-
-	fib_tbl8_write(&dp->tbl24, (def_nh << 1), nh_sz, 1 << 24);
-
-	snprintf(mem_name, sizeof(mem_name), "TBL8_%p", dp);
-	dp->tbl8 = rte_zmalloc_socket(mem_name, FIB_TBL8_GRP_NUM_ENT *
-			(1ll << nh_sz) * (num_tbl8 + 1),
-			RTE_CACHE_LINE_SIZE, socket_id);
-	if (dp->tbl8 == NULL) {
-		rte_errno = ENOMEM;
-		rte_free(dp);
 		return NULL;
 	}
+
 	dp->def_nh = def_nh;
 	dp->nh_sz = nh_sz;
-	dp->number_tbl8s = num_tbl8;
+	dp->pool = pool;
+	dp->tbl8 = pool->tbl8;
 
-	snprintf(mem_name, sizeof(mem_name), "TBL8_idxes_%p", dp);
-	dp->tbl8_pool = rte_zmalloc_socket(mem_name,
-			sizeof(uint32_t) * dp->number_tbl8s,
-			RTE_CACHE_LINE_SIZE, socket_id);
-	if (dp->tbl8_pool == NULL) {
-		rte_errno = ENOMEM;
-		rte_free(dp->tbl8);
-		rte_free(dp);
-		return NULL;
-	}
-
-	tbl8_pool_init(dp);
+	fib_tbl8_write(&dp->tbl24, (def_nh << 1), nh_sz, 1 << 24);
 
 	return dp;
 }
@@ -703,8 +654,7 @@ trie_free(void *p)
 	struct rte_trie_tbl *dp = (struct rte_trie_tbl *)p;
 
 	rte_rcu_qsbr_dq_delete(dp->dq);
-	rte_free(dp->tbl8_pool);
-	rte_free(dp->tbl8);
+	fib_tbl8_pool_unref(dp->pool);
 	rte_free(dp);
 }
 
@@ -735,8 +685,8 @@ trie_rcu_qsbr_add(struct rte_trie_tbl *dp, struct rte_fib6_rcu_config *cfg,
 		if (params.max_reclaim_size == 0)
 			params.max_reclaim_size = RTE_FIB6_RCU_DQ_RECLAIM_MAX;
 		params.esize = sizeof(uint64_t);
-		params.free_fn = __rcu_qsbr_free_resource;
-		params.p = dp;
+		params.free_fn = fib_tbl8_pool_rcu_free_cb;
+		params.p = dp->pool;
 		params.v = cfg->v;
 		dp->dq = rte_rcu_qsbr_dq_create(&params);
 		if (dp->dq == NULL) {
diff --git a/lib/fib/trie.h b/lib/fib/trie.h
index 30fa886792..61df56b1bb 100644
--- a/lib/fib/trie.h
+++ b/lib/fib/trie.h
@@ -11,7 +11,7 @@
 #include <rte_common.h>
 #include <rte_fib6.h>
 
-#include "fib_tbl8.h"
+#include "fib_tbl8_pool.h"
 
 /**
  * @file
@@ -26,13 +26,11 @@
 #define TRIE_EXT_ENT		1
 
 struct rte_trie_tbl {
-	uint32_t	number_tbl8s;	/**< Total number of tbl8s */
 	uint32_t	rsvd_tbl8s;	/**< Number of reserved tbl8s */
 	uint64_t	def_nh;		/**< Default next hop */
 	enum rte_fib_trie_nh_sz	nh_sz;	/**< Size of nexthop entry */
 	uint64_t	*tbl8;		/**< tbl8 table. */
-	uint32_t	*tbl8_pool;	/**< bitmap containing free tbl8 idxes*/
-	uint32_t	tbl8_pool_pos;
+	struct rte_fib_tbl8_pool *pool;	/**< tbl8 pool */
 	/* RCU config. */
 	enum rte_fib6_qsbr_mode rcu_mode; /**< Blocking, defer queue. */
 	struct rte_rcu_qsbr *v; /**< RCU QSBR variable. */
-- 
2.43.0

