Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E938D606A684
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Nov 2026 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nSVNEa7k
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCDC3406B6;
	Tue, 24 Nov 2026 19:03:36 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by mails.dpdk.org (Postfix) with ESMTPS id F04CB40653
 for <dev@dpdk.org>; Tue, 24 Nov 2026 19:03:34 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4bb72b44a97so41935045e9.0
 for <dev@dpdk.org>; Tue, 24 Nov 2026 10:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795543414; x=1796148214; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V+s0V8ernO5RFTPMPZpbI9keiwd6m1/Eg44UxL0o4sQ=;
 b=nSVNEa7kVSAeh08ARITlfBqtIMnbdfp8xI8pDhVSqmgUoiv27cdVqEnVUBLNI5AUpW
 HiFHmmYlasxtcQYNilpJXhNRgJF6ocsog8C3g01u+TOcHAr/GxLHUBkqP7MRjDY+GO1w
 xVbQD0TntOLAxhUB1eShAHGQHj1Z+VKBj/bqNCqEc7Kcfok1JgonnlMJMHrGxu3Y6Dw5
 Qd6Wx8E8cydT/g7/4U3iNDQdK1lFD0EQAzT3I4aURAcdg8lzvfdVMS8gQITzaX1XMPeL
 jffafAqaQpDmbe8zstN0OCbK49o4p2WFErECxgdPuOUJ/3ixLS+cz4bch/Gu2fedUJ2p
 MEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795543414; x=1796148214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V+s0V8ernO5RFTPMPZpbI9keiwd6m1/Eg44UxL0o4sQ=;
 b=VIOXBW3EGt+UkF2MuyxZ0GcrrnVB0MMFYO0yCsn/RMeP1y0q9bttIf7LX2VLOXARsC
 gp7YqomPMHq41OysTxCn9HksYnPURQ1zotPlsg4GvPTj5sRdrN2xax8wQv6kSka35pJ4
 06UgEScElLeZx4i6Xsh/z05xFwjMFoqouETFR+Si8mtatTLVnIBVdWO5jdU97S+YmYai
 R7XzXZGAH+wggbgflPSVkfAvVox5ssJNHZTrPcVySYOxj5nsR70HpqzjPorxyEjXWbyw
 L2lG5ZGvjh70TV3pm5xEKqtRC40lGxGrCNSEJCQSpK2BjQ8SGyIaHhJOV1lij54BDS4o
 k4gA==
X-Gm-Message-State: APuU4Z+Igd4qAM5CejOKDWkOX1x1iGxsDB2NUF/2zSKZ7HfpQsxDV98r
 JmPohP4KIs732dd2vUHgvfHoYdyA9u8kyNAECqHoxaw2A6IMqJCfNDAg
X-Gm-Gg: AZFdTZfIQix+VRk5J3T9EKUazCEMEMg45/7rTkcQNKNilO7GlvsSMUeUHwEQctj9cLR
 9G7Yv6SC1L47AbzUhVZeTu5+93ZZo2PNcZmLOI6kAu+6C1VGXURtPKK7P9L4GX5RDJ+wgOG4W7V
 c3YV1zykQXWN+d1eLDmAyf5PABEMv2hZSOQH6nzPn2HD0DMb/OBPv+Czs7jKQkEt2eQbm2OSnUs
 b3jJaVOONhwbOuba63NZ49b27DUnl6n/uhvd7ussSZ8XKa8/wf8Ky3BH6J0UgJpN+EQNbNrWTWd
 8uZgbNdi0ePZi4+dJf5ilj7jsMzwZK0Xnq6Vq582hl47Yan0XuptRhqsiV5lzC7adI74eUOzeRd
 bR1gxwks9KhunVYOekTPTXDPgVqjjj0VEf8ExCTLh7EV10Ey4KjtL9hoB9Hrp9QGY8Bw0dmOsxE
 VMWICW/6/1E85bu8MRuoZDPvlgPwa5Zhm/gg+tuUpTYWf+n6rPySWKCiy38X+x53vBqkb9LQqQh
 AF95NODsVQZr+cGPihN4kR157u74R9WlHI2pptK+4dH0bVfYmL1iKF5NVnFRj8Dc2NuZLFAovnM
 Tl3xY1WMW3LMKc1eVMXmcdpXiSKJcDYeXfl6bU7mGhJxSd/2+nPB43//cTmG
X-Received: by 2002:a05:600c:3ba4:b0:4ba:493b:3401 with SMTP id
 5b1f17b1804b1-4bb8880abafmr369178925e9.9.1795543414237; 
 Tue, 24 Nov 2026 10:03:34 -0800 (PST)
Received: from freepad.home ([2a01:e0a:1248:bd70:ee15:c1ae:fed0:c345])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9846sm535005275e9.11.2026.11.24.10.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:03:33 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: vladimir.medvedkin@intel.com
Cc: dev@dpdk.org,
	rjarry@redhat.com,
	Maxime Leroy <maxime@leroys.fr>
Subject: [RFC v2 07/13] fib: add shared tbl8 pool
Date: Tue, 24 Nov 2026 19:02:43 +0100
Message-ID: <20261124180249.1099506-8-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124180249.1099506-1-maxime@leroys.fr>
References: <20260331214117.142495-1-maxime@leroys.fr>
 <20261124180249.1099506-1-maxime@leroys.fr>
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

The tbl8 groups reserved by the routes are counted in the pool, next
to the groups taken from the free list and those used by the
dataplanes. A route is admitted when the reservations of all the FIBs
of the pool still fit its capacity, so the groups reserved by a FIB
can not be taken by another one. Freeing a FIB returns its groups and
its reservation to the pool.

The per-FIB RCU defer queue callback is shared across both backends
(fib_tbl8_pool_rcu_free_cb). The pool keeps a list of its FIBs, whose
node is embedded in the dataplane struct, so registering allocates
nothing. When the pool runs out of groups, the defer queues of all
its FIBs are reclaimed, not only the one of the FIB doing the update.
Freeing a FIB of a shared pool waits for the readers before emptying
its defer queue, so that its groups return to the pool.

New public API:
  - rte_fib_tbl8_pool_create()
  - rte_fib_tbl8_pool_free()

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 doc/api/doxy-api-index.md         |   3 +-
 doc/guides/prog_guide/fib_lib.rst |  27 +++++
 lib/fib/dir24_8.c                 | 162 +++++++++++--------------
 lib/fib/dir24_8.h                 |   7 +-
 lib/fib/fib_tbl8_pool.c           | 192 ++++++++++++++++++++++++++++++
 lib/fib/fib_tbl8_pool.h           | 108 +++++++++++++++++
 lib/fib/meson.build               |   5 +-
 lib/fib/rte_fib.h                 |   3 +
 lib/fib/rte_fib6.h                |   3 +
 lib/fib/rte_fib_tbl8_pool.h       |  85 +++++++++++++
 lib/fib/trie.c                    | 192 ++++++++++++++----------------
 lib/fib/trie.h                    |   8 +-
 12 files changed, 589 insertions(+), 206 deletions(-)
 create mode 100644 lib/fib/fib_tbl8_pool.c
 create mode 100644 lib/fib/fib_tbl8_pool.h
 create mode 100644 lib/fib/rte_fib_tbl8_pool.h

diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
index 62390f7be3..730f68db4a 100644
--- a/doc/api/doxy-api-index.md
+++ b/doc/api/doxy-api-index.md
@@ -151,7 +151,8 @@ The public API headers are grouped by topics:
   [RIB IPv4](@ref rte_rib.h),
   [RIB IPv6](@ref rte_rib6.h),
   [FIB IPv4](@ref rte_fib.h),
-  [FIB IPv6](@ref rte_fib6.h)
+  [FIB IPv6](@ref rte_fib6.h),
+  [FIB tbl8 pool](@ref rte_fib_tbl8_pool.h)
 
 - **hashes**:
   [hash](@ref rte_hash.h),
diff --git a/doc/guides/prog_guide/fib_lib.rst b/doc/guides/prog_guide/fib_lib.rst
index 41ab5764b6..151ae38f2b 100644
--- a/doc/guides/prog_guide/fib_lib.rst
+++ b/doc/guides/prog_guide/fib_lib.rst
@@ -127,6 +127,33 @@ An entry in a tbl8 contains the following fields:
 * 1 bit indicating if the lookup should proceed inside the tbl8.
 
 
+tbl8 pool
+---------
+
+The tbl8 groups of the DIR-24-8 and TRIE algorithms come from a tbl8 pool.
+By default each FIB creates its own pool of ``num_tbl8`` groups.
+
+A pool can also be created with ``rte_fib_tbl8_pool_create()`` and given in the
+``tbl8_pool`` field of the configuration of several FIBs, IPv4 or IPv6,
+using the same next hop size. These FIBs then share the groups of the pool,
+for example with one FIB per VRF: a FIB with few long prefixes leaves room
+to the others.
+
+Each route reserves in the pool the tbl8 groups it may need.
+An add is refused with ``-ENOSPC`` when the reservations of all the FIBs
+of the pool would exceed its capacity, so that the groups needed by the
+accepted routes are kept for them. Groups waiting in an RCU defer queue
+are not available until the readers are done with them.
+Freeing a FIB returns its groups and its reservation to the pool.
+When the pool is shared and the FIB has an RCU defer queue,
+``rte_fib_free()`` and ``rte_fib6_free()`` first wait for the readers
+to report a quiescent state, so that the groups waiting in the queue
+also return to the pool.
+
+The pool is not thread safe: the updates of all the FIBs sharing it,
+their creation and their destruction must be serialized by the caller.
+
+
 Use cases
 ---------
 
diff --git a/lib/fib/dir24_8.c b/lib/fib/dir24_8.c
index 7e5f094a3a..a8ae7310aa 100644
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
-	if (unlikely(tbl8_idx == -ENOSPC && dp->dq &&
-			!rte_rcu_qsbr_dq_reclaim(dp->dq, 1, NULL, NULL, NULL)))
-		tbl8_idx = tbl8_get(dp);
+	if (unlikely(tbl8_idx == -ENOSPC &&
+			fib_tbl8_pool_reclaim(dp->pool, 1) != 0))
+		tbl8_idx = fib_tbl8_pool_get(dp->pool);
 
 	if (tbl8_idx < 0)
 		return tbl8_idx;
@@ -197,27 +174,10 @@ tbl8_alloc(struct dir24_8_tbl *dp, uint64_t nh)
 	fib_tbl8_write((void *)tbl8_ptr, nh|
 		DIR24_8_EXT_ENT, dp->nh_sz,
 		FIB_TBL8_GRP_NUM_ENT);
+	dp->pool->cur_tbl8s++;
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
@@ -275,11 +235,12 @@ tbl8_recycle(struct dir24_8_tbl *dp, uint32_t ip, uint64_t tbl8_idx)
 		break;
 	}
 
+	dp->pool->cur_tbl8s--;
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
@@ -310,14 +271,15 @@ install_to_fib(struct dir24_8_tbl *dp, uint32_t ledge, uint32_t redge,
 				 * needs tbl8 for ledge and redge.
 				 */
 				tbl8_idx = tbl8_alloc(dp, tbl24_tmp);
-				tmp_tbl8_idx = tbl8_get(dp);
+				tmp_tbl8_idx = fib_tbl8_pool_get(dp->pool);
 				if (tbl8_idx < 0)
 					return -ENOSPC;
 				else if (tmp_tbl8_idx < 0) {
-					tbl8_put(dp, tbl8_idx);
+					dp->pool->cur_tbl8s--;
+					fib_tbl8_pool_cleanup_and_free(dp->pool, tbl8_idx);
 					return -ENOSPC;
 				}
-				tbl8_put(dp, tmp_tbl8_idx);
+				fib_tbl8_pool_put(dp->pool, tmp_tbl8_idx);
 				/*update dir24 entry with tbl8 index*/
 				fib_tbl8_write(get_tbl24_p(dp, ledge,
 					dp->nh_sz), (tbl8_idx << 1)|
@@ -483,7 +445,7 @@ dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 			tmp = rte_rib_get_nxt(rib, ip, 24, NULL,
 				RTE_RIB_GET_NXT_COVER);
 			if ((tmp == NULL) &&
-				(dp->rsvd_tbl8s >= dp->number_tbl8s))
+				(dp->pool->rsvd_tbl8s >= dp->pool->num_tbl8s))
 				return -ENOSPC;
 
 		}
@@ -503,8 +465,10 @@ dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 			return ret;
 		}
 successfully_added:
-		if ((depth > 24) && (tmp == NULL))
+		if ((depth > 24) && (tmp == NULL)) {
 			dp->rsvd_tbl8s++;
+			dp->pool->rsvd_tbl8s++;
+		}
 		return 0;
 	case RTE_FIB_DEL:
 		if (node == NULL)
@@ -523,8 +487,10 @@ dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 			if (depth > 24) {
 				tmp = rte_rib_get_nxt(rib, ip, 24, NULL,
 					RTE_RIB_GET_NXT_COVER);
-				if (tmp == NULL)
+				if (tmp == NULL) {
 					dp->rsvd_tbl8s--;
+					dp->pool->rsvd_tbl8s--;
+				}
 			}
 		}
 		return ret;
@@ -539,18 +505,13 @@ dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
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
@@ -559,46 +520,49 @@ dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
 
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
+	dp->consumer.dq = &dp->dq;
+	fib_tbl8_pool_register(pool, &dp->consumer);
 
 	/* Init table with default value */
 	fib_tbl8_write(dp->tbl24, (def_nh << 1), nh_sz, 1 << 24);
@@ -610,10 +574,26 @@ void
 dir24_8_free(void *p)
 {
 	struct dir24_8_tbl *dp = (struct dir24_8_tbl *)p;
+	bool shared = dp->pool->refcnt > 1;
+	uint64_t val;
+	uint32_t i;
 
+	fib_tbl8_pool_unregister(dp->pool, &dp->consumer);
+	if (shared && dp->dq != NULL)
+		rte_rcu_qsbr_synchronize(dp->v, RTE_QSBR_THRID_INVALID);
 	rte_rcu_qsbr_dq_delete(dp->dq);
-	rte_free(dp->tbl8_pool);
-	rte_free(dp->tbl8);
+	if (shared) {
+		for (i = 0; i < DIR24_8_TBL24_NUM_ENT; i++) {
+			val = get_tbl24(dp, i << 8, dp->nh_sz);
+			if ((val & DIR24_8_EXT_ENT) == DIR24_8_EXT_ENT) {
+				dp->pool->cur_tbl8s--;
+				fib_tbl8_pool_cleanup_and_free(dp->pool,
+					val >> 1);
+			}
+		}
+		dp->pool->rsvd_tbl8s -= dp->rsvd_tbl8s;
+	}
+	fib_tbl8_pool_unref(dp->pool);
 	rte_free(dp);
 }
 
@@ -645,8 +625,8 @@ dir24_8_rcu_qsbr_add(struct dir24_8_tbl *dp, struct rte_fib_rcu_config *cfg,
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
index e75bd120ad..9fdb9dbba0 100644
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
@@ -36,7 +34,8 @@ struct dir24_8_tbl {
 	struct rte_rcu_qsbr_dq *dq;	/* RCU QSBR defer queue. */
 	uint64_t	def_nh;		/**< Default next hop */
 	uint64_t	*tbl8;		/**< tbl8 table. */
-	uint32_t	*tbl8_pool;	/**< Stack of free tbl8 indices */
+	struct rte_fib_tbl8_pool *pool;	/**< tbl8 pool */
+	struct fib_tbl8_consumer consumer; /**< Link in the tbl8 pool */
 	/* tbl24 table. */
 	alignas(RTE_CACHE_LINE_SIZE) uint64_t	tbl24[];
 };
diff --git a/lib/fib/fib_tbl8_pool.c b/lib/fib/fib_tbl8_pool.c
new file mode 100644
index 0000000000..f5cecc9fc2
--- /dev/null
+++ b/lib/fib/fib_tbl8_pool.c
@@ -0,0 +1,192 @@
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
+#include <rte_rcu_qsbr.h>
+
+#include "fib_tbl8_pool.h"
+
+static inline uint64_t
+pool_max_tbl8(uint8_t nh_sz)
+{
+	return (1ULL << ((8 << nh_sz) - 1)) - 1;
+}
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
+	pool->pool_pos = 0;
+}
+
+int32_t
+fib_tbl8_pool_get(struct rte_fib_tbl8_pool *pool)
+{
+	if (pool->pool_pos == pool->num_tbl8s)
+		/* no more free tbl8 */
+		return -ENOSPC;
+
+	/* next index */
+	return pool->free_list[pool->pool_pos++];
+}
+
+void
+fib_tbl8_pool_put(struct rte_fib_tbl8_pool *pool, uint32_t idx)
+{
+	RTE_ASSERT(pool->pool_pos > 0);
+	pool->free_list[--pool->pool_pos] = idx;
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
+uint32_t
+fib_tbl8_pool_reclaim(struct rte_fib_tbl8_pool *pool, uint32_t n)
+{
+	struct fib_tbl8_consumer *c;
+	unsigned int freed;
+	uint32_t total = 0;
+
+	SLIST_FOREACH(c, &pool->consumers, next) {
+		if (total >= n)
+			break;
+		if (*c->dq == NULL)
+			continue;
+		freed = 0;
+		rte_rcu_qsbr_dq_reclaim(*c->dq, n - total, &freed, NULL, NULL);
+		total += freed;
+	}
+
+	return total;
+}
+
+void
+fib_tbl8_pool_register(struct rte_fib_tbl8_pool *pool,
+		       struct fib_tbl8_consumer *c)
+{
+	SLIST_INSERT_HEAD(&pool->consumers, c, next);
+}
+
+void
+fib_tbl8_pool_unregister(struct rte_fib_tbl8_pool *pool,
+			 struct fib_tbl8_consumer *c)
+{
+	SLIST_REMOVE(&pool->consumers, c, fib_tbl8_consumer, next);
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
+	RTE_ASSERT(SLIST_EMPTY(&pool->consumers));
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
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib_tbl8_pool_create, 27.03)
+struct rte_fib_tbl8_pool *
+rte_fib_tbl8_pool_create(const char *name,
+			 const struct rte_fib_tbl8_pool_conf *conf)
+{
+	struct rte_fib_tbl8_pool *pool;
+	char mem_name[64];
+
+	if (name == NULL || conf == NULL || conf->num_tbl8 == 0 ||
+	    conf->nh_sz > 3 ||
+	    conf->num_tbl8 > pool_max_tbl8(conf->nh_sz)) {
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
+	SLIST_INIT(&pool->consumers);
+
+	return pool;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib_tbl8_pool_free, 27.03)
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
index 0000000000..669c67f7cb
--- /dev/null
+++ b/lib/fib/fib_tbl8_pool.h
@@ -0,0 +1,108 @@
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
+#include <sys/queue.h>
+
+#include <rte_common.h>
+
+#include "fib_tbl8.h"
+#include "rte_fib_tbl8_pool.h"
+
+struct fib_tbl8_consumer {
+	SLIST_ENTRY(fib_tbl8_consumer) next;
+	struct rte_rcu_qsbr_dq **dq;	/**< Points to the FIB's dp->dq field */
+};
+
+struct rte_fib_tbl8_pool {
+	uint64_t	*tbl8;		/**< tbl8 group array */
+	uint32_t	*free_list;	/**< Stack of free group indices */
+	uint32_t	pool_pos;	/**< Number of groups taken from the free list */
+	uint32_t	cur_tbl8s;	/**< Number of groups used by the dataplanes */
+	uint32_t	rsvd_tbl8s;	/**< Number of groups reserved by the routes */
+	uint32_t	num_tbl8s;	/**< Total number of tbl8 groups */
+	uint8_t		nh_sz;		/**< Nexthop entry size (0-3) */
+	int		socket_id;
+	uint32_t	refcnt;		/**< Reference count */
+	SLIST_HEAD(, fib_tbl8_consumer) consumers; /**< Registered FIBs */
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
+/**
+ * Reclaim up to @p n tbl8 groups from the RCU defer queues of the FIBs
+ * using the pool.
+ *
+ * @return number of groups returned to the pool.
+ */
+uint32_t
+fib_tbl8_pool_reclaim(struct rte_fib_tbl8_pool *pool, uint32_t n);
+
+/**
+ * Register a FIB consumer: its RCU defer queue is reclaimed when the pool
+ * runs out of groups. The consumer is embedded in the dataplane struct of
+ * the FIB.
+ */
+void
+fib_tbl8_pool_register(struct rte_fib_tbl8_pool *pool,
+		       struct fib_tbl8_consumer *c);
+
+/**
+ * Unregister a FIB consumer.
+ */
+void
+fib_tbl8_pool_unregister(struct rte_fib_tbl8_pool *pool,
+			 struct fib_tbl8_consumer *c);
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
index fcbd10de15..f278789476 100644
--- a/lib/fib/rte_fib6.h
+++ b/lib/fib/rte_fib6.h
@@ -19,6 +19,7 @@
 
 #include <rte_ip6.h>
 #include <rte_rcu_qsbr.h>
+#include <rte_fib_tbl8_pool.h>
 
 #ifdef __cplusplus
 extern "C" {
@@ -90,6 +91,8 @@ struct rte_fib6_conf {
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
index 0000000000..18b2fadb29
--- /dev/null
+++ b/lib/fib/rte_fib_tbl8_pool.h
@@ -0,0 +1,85 @@
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
+ *
+ * Reservation: each route reserves in the pool the tbl8 groups it may
+ * need. An add is refused with -ENOSPC when the reservations of all the
+ * FIBs of the pool would exceed its capacity, so that the groups needed
+ * by the accepted routes are kept for them. Groups waiting in an RCU
+ * defer queue are not available until the readers are done with them.
+ * Freeing a FIB returns its groups and its reservation to the pool.
+ * When the pool is shared and the FIB has an RCU defer queue, freeing
+ * the FIB waits for the readers to report a quiescent state.
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
index 22a6e2e863..c5c8f37454 100644
--- a/lib/fib/trie.c
+++ b/lib/fib/trie.c
@@ -100,53 +100,18 @@ trie_get_lookup_fn(void *p, enum rte_fib6_lookup_type type)
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
-	if (unlikely(tbl8_idx == -ENOSPC && dp->dq &&
-			!rte_rcu_qsbr_dq_reclaim(dp->dq, 1, NULL, NULL, NULL)))
-		tbl8_idx = tbl8_get(dp);
+	if (unlikely(tbl8_idx == -ENOSPC &&
+			fib_tbl8_pool_reclaim(dp->pool, 1) != 0))
+		tbl8_idx = fib_tbl8_pool_get(dp->pool);
 
 	if (tbl8_idx < 0)
 		return tbl8_idx;
@@ -155,27 +120,10 @@ tbl8_alloc(struct rte_trie_tbl *dp, uint64_t nh)
 	/*Init tbl8 entries with nexthop from tbl24*/
 	fib_tbl8_write((void *)tbl8_ptr, nh, dp->nh_sz,
 		FIB_TBL8_GRP_NUM_ENT);
-	dp->cur_tbl8s++;
+	dp->pool->cur_tbl8s++;
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
@@ -224,12 +172,12 @@ tbl8_recycle(struct rte_trie_tbl *dp, void *par, uint64_t tbl8_idx)
 		break;
 	}
 
-	dp->cur_tbl8s--;
+	dp->pool->cur_tbl8s--;
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
@@ -494,12 +442,12 @@ modify_dp(struct rte_trie_tbl *dp, struct rte_rib6 *rib,
 	/*
 	 * Check if we can safely allocate new tbl8s further in process of modifying the dataplane.
 	 */
-	uint32_t tbl8s_in_defer_queue = dp->tbl8_pool_pos - dp->cur_tbl8s;
-	if (dp->rsvd_tbl8s + tbl8s_in_defer_queue > dp->number_tbl8s) {
-		rte_rcu_qsbr_dq_reclaim(dp->dq, dp->tbl8_pool_pos - dp->cur_tbl8s,
-			NULL, NULL, NULL);
-		tbl8s_in_defer_queue = dp->tbl8_pool_pos - dp->cur_tbl8s;
-		if (dp->rsvd_tbl8s + tbl8s_in_defer_queue > dp->number_tbl8s)
+	uint32_t tbl8s_in_defer_queue = dp->pool->pool_pos - dp->pool->cur_tbl8s;
+	if (dp->pool->rsvd_tbl8s + tbl8s_in_defer_queue > dp->pool->num_tbl8s) {
+		fib_tbl8_pool_reclaim(dp->pool, tbl8s_in_defer_queue);
+		tbl8s_in_defer_queue = dp->pool->pool_pos - dp->pool->cur_tbl8s;
+		if (dp->pool->rsvd_tbl8s + tbl8s_in_defer_queue >
+				dp->pool->num_tbl8s)
 			return -ENOSPC;
 	}
 
@@ -621,11 +569,12 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 			return -rte_errno;
 
 		new_levels = count_empty_levels(node);
-		if (dp->rsvd_tbl8s + new_levels > dp->number_tbl8s) {
+		if (dp->pool->rsvd_tbl8s + new_levels > dp->pool->num_tbl8s) {
 			rte_rib6_remove(rib, &ip_masked, depth);
 			return -ENOSPC;
 		}
 		dp->rsvd_tbl8s += new_levels;
+		dp->pool->rsvd_tbl8s += new_levels;
 
 		rte_rib6_set_nh(node, next_hop);
 		parent = rte_rib6_lookup_parent(node);
@@ -637,6 +586,7 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 		ret = modify_dp(dp, rib, &ip_masked, depth, next_hop);
 		if (ret != 0) {
 			dp->rsvd_tbl8s -= new_levels;
+			dp->pool->rsvd_tbl8s -= new_levels;
 			rte_rib6_remove(rib, &ip_masked, depth);
 			return ret;
 		}
@@ -659,7 +609,9 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 		if (ret != 0)
 			return ret;
 
-		dp->rsvd_tbl8s -= count_empty_levels(node);
+		new_levels = count_empty_levels(node);
+		dp->rsvd_tbl8s -= new_levels;
+		dp->pool->rsvd_tbl8s -= new_levels;
 		rte_rib6_remove(rib, &ip_masked, depth);
 
 		return 0;
@@ -675,75 +627,109 @@ trie_create(const char *name, int socket_id,
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
+	dp->pool = pool;
+	dp->tbl8 = pool->tbl8;
+	dp->consumer.dq = &dp->dq;
+	fib_tbl8_pool_register(pool, &dp->consumer);
 
-	tbl8_pool_init(dp);
+	fib_tbl8_write(&dp->tbl24, (def_nh << 1), nh_sz, 1 << 24);
 
 	return dp;
 }
 
+static void
+tbl8_free_subtree(struct rte_trie_tbl *dp, uint64_t tbl8_idx)
+{
+	uint64_t val;
+	uint32_t i;
+
+	for (i = 0; i < FIB_TBL8_GRP_NUM_ENT; i++) {
+		val = get_tbl_val_by_idx(dp->tbl8,
+			tbl8_idx * FIB_TBL8_GRP_NUM_ENT + i, dp->nh_sz);
+		if ((val & TRIE_EXT_ENT) == TRIE_EXT_ENT)
+			tbl8_free_subtree(dp, val >> 1);
+	}
+	dp->pool->cur_tbl8s--;
+	fib_tbl8_pool_cleanup_and_free(dp->pool, tbl8_idx);
+}
+
 void
 trie_free(void *p)
 {
 	struct rte_trie_tbl *dp = (struct rte_trie_tbl *)p;
+	bool shared = dp->pool->refcnt > 1;
+	uint64_t val;
+	uint32_t i;
 
+	fib_tbl8_pool_unregister(dp->pool, &dp->consumer);
+	if (shared && dp->dq != NULL)
+		rte_rcu_qsbr_synchronize(dp->v, RTE_QSBR_THRID_INVALID);
 	rte_rcu_qsbr_dq_delete(dp->dq);
-	rte_free(dp->tbl8_pool);
-	rte_free(dp->tbl8);
+	if (shared) {
+		for (i = 0; i < TRIE_TBL24_NUM_ENT; i++) {
+			val = get_tbl_val_by_idx(dp->tbl24, i, dp->nh_sz);
+			if ((val & TRIE_EXT_ENT) == TRIE_EXT_ENT)
+				tbl8_free_subtree(dp, val >> 1);
+		}
+		dp->pool->rsvd_tbl8s -= dp->rsvd_tbl8s;
+	}
+	fib_tbl8_pool_unref(dp->pool);
 	rte_free(dp);
 }
 
@@ -774,8 +760,8 @@ trie_rcu_qsbr_add(struct rte_trie_tbl *dp, struct rte_fib6_rcu_config *cfg,
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
index bea74f1bb6..4c337ebdb0 100644
--- a/lib/fib/trie.h
+++ b/lib/fib/trie.h
@@ -11,7 +11,7 @@
 #include <rte_common.h>
 #include <rte_fib6.h>
 
-#include "fib_tbl8.h"
+#include "fib_tbl8_pool.h"
 
 /**
  * @file
@@ -26,18 +26,16 @@
 #define TRIE_EXT_ENT		1
 
 struct rte_trie_tbl {
-	uint32_t	number_tbl8s;	/**< Total number of tbl8s */
 	uint32_t	rsvd_tbl8s;	/**< Number of reserved tbl8s */
-	uint32_t	cur_tbl8s;	/**< Current cumber of tbl8s */
 	uint64_t	def_nh;		/**< Default next hop */
 	enum rte_fib_trie_nh_sz	nh_sz;	/**< Size of nexthop entry */
 	uint64_t	*tbl8;		/**< tbl8 table. */
-	uint32_t	*tbl8_pool;	/**< bitmap containing free tbl8 idxes*/
-	uint32_t	tbl8_pool_pos;
+	struct rte_fib_tbl8_pool *pool;	/**< tbl8 pool */
 	/* RCU config. */
 	enum rte_fib6_qsbr_mode rcu_mode; /**< Blocking, defer queue. */
 	struct rte_rcu_qsbr *v; /**< RCU QSBR variable. */
 	struct rte_rcu_qsbr_dq *dq; /**< RCU QSBR defer queue. */
+	struct fib_tbl8_consumer consumer; /**< Link in the tbl8 pool */
 	/* tbl24 table. */
 	alignas(RTE_CACHE_LINE_SIZE) uint64_t	tbl24[];
 };
-- 
2.43.0

