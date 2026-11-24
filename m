Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811A0606A33B
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Nov 2026 18:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IrIl5Bfn
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0997E40693;
	Tue, 24 Nov 2026 19:03:39 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by mails.dpdk.org (Postfix) with ESMTPS id 7B8B7406BB
 for <dev@dpdk.org>; Tue, 24 Nov 2026 19:03:37 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so35332045e9.2
 for <dev@dpdk.org>; Tue, 24 Nov 2026 10:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795543417; x=1796148217; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zkYVssqorXq5DAwy8W3lZXVPD9cKtcNBAuDdvMAB21Y=;
 b=IrIl5BfnWq6/KsPCe5uBgEH9LP7sLH1KnFhoHJfKEGnMZxXemSntrTiXARJr/ON4Zc
 p3xbTAMahmbFhM8rdO5h6mql7esbgUSynnHZb812cRrVn/03ikWf62T3uED+915Su6uV
 y06jSrCDbJjOwh5kuFcYHRhuQXfqQM/bO/vwR4LGPgLPUb84LeEkzJBpSiuTEDFyDPBL
 eEoX6jbNtQlvw5JW7IOtV+q0B5SfqLsRvzmLS8bTvUjJfSQqhue/kAPdOv2QafIHjpyL
 1nBk1dusGVTWLS4hsFuNSl4l+tpq0P4CEcyAEhrm0DjOvM0BTjn6hXxd/rNXyrKEZbRv
 L9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795543417; x=1796148217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zkYVssqorXq5DAwy8W3lZXVPD9cKtcNBAuDdvMAB21Y=;
 b=kqvqS/8fYUwViPu6OCQJzvvX7X7IO4bz6bGMqAcRDau9cxL8xa+nplHYMEuQqUDvp5
 P2BuCNCaIEYuKd/BZ2P6q6g4j1nM7phTviEvQ9n7FmqPyfRJNxPUVZIUgt7ZVsRQ+UG+
 DYqdHbjXulv0n1E/bf/RAiac2wHTl5X60EvtyRg73pU/LBzr0grLavbmfPjhDZK6m2uH
 EJ+N9M68ABhP1OrRzlakO4z8RLGw9PscDHzCGTMQ3EGytDlWrY3IYqWzSwtc+RwL+sWR
 +aiZeWcuZwy0ccd4I9uzdbld6IiXx8OMoAJ39GPc26cODiMSuTUznbnPjjvg6dQLCXAV
 MNzQ==
X-Gm-Message-State: APuU4Z/wvhcUPfcuNvJmWkDuqKXbX5jw2y56oS1IZ3FSCw1878xq0IHK
 R93RCC1/nnLOftpGxy9/x5duLnhQB7nbKvH4Gn1aa7cn3wbzwZ1XJtCg
X-Gm-Gg: AZFdTZd+QqPQo49qo+mLX2t1vxW+ajHRgN+w0Krs0/KFtlD2uAPpCimgQCXc1AanEua
 Kp4FxiyLmM98CUWr45j5gGWUZyoFbim2jmJ7MnScobZNhTLNX0oql80Q8hhw2nbRgjFZUhYrrnb
 wc47nlaRZ6toSYz814lopU6r3uBEkv5lptWoHXP2Aj5iq+x0Ob7NRdwQkkFmyyUFoztYj/v8XF9
 7NPGZ652OYeZK1AFKAFYvxeL4MFqKHlazIpeDz+wTNpSmYocexCH6QM9inqLL9zzM1x8w1JQ0yB
 n4B+RyrssTtPex8ox6bmsAbtJlSZsoAmf5JJ3Fh2Sz0v9VMPv+qOCf6KJjif65yl0Dwgn1K1BuF
 Ow7moyLZ5+lZfU1i7fSYynpleI/ELE0sRQEJwigRIUjro1u9GchNqAUywn0xw/jzNdVQuCNWsOr
 +Wh1C66j+4Mr4k4mPCpezLIVeGj3DgZHLSC3nuOlGBzD5QldP1EHLfDroxE7sVHPctU+tRlI7W+
 RAoCe/UZXGk6mIoWMf6ibKv7bC9+9e/F+Atjkuc2WqhN4f1zSJtuQMMyYGyXkC292Df2O8Du4v4
 Agj3usQjO6ylNx77qQeSqrNdc5d9aTesKm60kueA+xrM3x/yPGqCSvjqySTYHtAt+AAbszH2qgG
 qPyLFWw==
X-Received: by 2002:a05:600c:4f0d:b0:4bb:5c97:f4b1 with SMTP id
 5b1f17b1804b1-4bb8881941bmr356234685e9.24.1795543416772; 
 Tue, 24 Nov 2026 10:03:36 -0800 (PST)
Received: from freepad.home ([2a01:e0a:1248:bd70:ee15:c1ae:fed0:c345])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8533579csm399586985e9.2.2026.11.24.10.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:03:36 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: vladimir.medvedkin@intel.com
Cc: dev@dpdk.org,
	rjarry@redhat.com,
	Maxime Leroy <maxime@leroys.fr>
Subject: [RFC v2 08/13] fib: add resizable tbl8 pool
Date: Tue, 24 Nov 2026 19:02:44 +0100
Message-ID: <20261124180249.1099506-9-maxime@leroys.fr>
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

Add dynamic resize support to the shared tbl8 pool. When all groups
are in use, the pool doubles its capacity via an RCU-safe pointer
swap.

The resize mechanism:
1. Allocate new tbl8 array (double the current size)
2. Copy existing data
3. Patch all registered dp->tbl8 consumer pointers via SLIST
4. rte_rcu_qsbr_synchronize() to wait for all readers
5. Free old tbl8 array

The list of the FIBs of the pool now also points to the dp->tbl8
field of each FIB, patched on resize.

A new fib_tbl8_pool_alloc() function replaces the per-backend
tbl8_alloc logic: it handles get + RCU reclaim retry + group
initialization in one place. It never resizes the pool.

The pool grows through fib_tbl8_pool_reserve(), called where no
pointer into the tbl8 array is held. The trie keeps such pointers
while it installs a route, so it secures the groups still reserved
in the pool at the start of modify_dp(), before writing the
dataplane. dir24_8 recomputes its pointers after each allocation, so
it reserves one group right before taking it.

RCU is required for resize. It is attached to the pool either with
rte_fib_tbl8_pool_rcu_qsbr_add(), or by the first rte_fib_rcu_qsbr_add()
or rte_fib6_rcu_qsbr_add() of a FIB using the pool. Only an external
pool can be resizable: the internal pool of a FIB keeps the fixed size
given by num_tbl8.

New public API:
  - rte_fib_tbl8_pool_resize()
  - rte_fib_tbl8_pool_rcu_qsbr_add()

New config field:
  - rte_fib_tbl8_pool_conf.max_tbl8 (maximum capacity, 0 keeps
  the pool fixed-size)

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 doc/guides/prog_guide/fib_lib.rst |  10 ++
 lib/fib/dir24_8.c                 |  55 +++++-----
 lib/fib/fib_tbl8_pool.c           | 160 +++++++++++++++++++++++++++++-
 lib/fib/fib_tbl8_pool.h           |  35 ++++++-
 lib/fib/rte_fib_tbl8_pool.h       |  56 ++++++++++-
 lib/fib/trie.c                    |  59 ++++++-----
 6 files changed, 316 insertions(+), 59 deletions(-)

diff --git a/doc/guides/prog_guide/fib_lib.rst b/doc/guides/prog_guide/fib_lib.rst
index 151ae38f2b..9623ffd44b 100644
--- a/doc/guides/prog_guide/fib_lib.rst
+++ b/doc/guides/prog_guide/fib_lib.rst
@@ -150,6 +150,16 @@ When the pool is shared and the FIB has an RCU defer queue,
 to report a quiescent state, so that the groups waiting in the queue
 also return to the pool.
 
+A pool created with a ``max_tbl8`` greater than ``num_tbl8`` grows on demand,
+doubling its capacity up to ``max_tbl8``. It never grows while an update
+holds a pointer into the tbl8 array: the TRIE algorithm grows it before
+writing the dataplane, DIR-24-8 right before taking a group.
+Growing needs an RCU QSBR
+variable, attached with ``rte_fib_tbl8_pool_rcu_qsbr_add()``, or by the first
+``rte_fib_rcu_qsbr_add()`` or ``rte_fib6_rcu_qsbr_add()`` of a FIB using the pool.
+The previous array is freed once the readers are done with it.
+The pool never shrinks.
+
 The pool is not thread safe: the updates of all the FIBs sharing it,
 their creation and their destruction must be serialized by the caller.
 
diff --git a/lib/fib/dir24_8.c b/lib/fib/dir24_8.c
index a8ae7310aa..6cc68649f7 100644
--- a/lib/fib/dir24_8.c
+++ b/lib/fib/dir24_8.c
@@ -155,27 +155,10 @@ dir24_8_get_lookup_fn(void *p, enum rte_fib_lookup_type type, bool be_addr)
 static int
 tbl8_alloc(struct dir24_8_tbl *dp, uint64_t nh)
 {
-	int64_t	tbl8_idx;
-	uint8_t	*tbl8_ptr;
+	if (fib_tbl8_pool_reserve(dp->pool, 1) != 0)
+		return -ENOSPC;
 
-	tbl8_idx = fib_tbl8_pool_get(dp->pool);
-
-	/* If there are no tbl8 groups try to reclaim one. */
-	if (unlikely(tbl8_idx == -ENOSPC &&
-			fib_tbl8_pool_reclaim(dp->pool, 1) != 0))
-		tbl8_idx = fib_tbl8_pool_get(dp->pool);
-
-	if (tbl8_idx < 0)
-		return tbl8_idx;
-	tbl8_ptr = (uint8_t *)dp->tbl8 +
-		((tbl8_idx * FIB_TBL8_GRP_NUM_ENT) <<
-		dp->nh_sz);
-	/*Init tbl8 entries with nexthop from tbl24*/
-	fib_tbl8_write((void *)tbl8_ptr, nh|
-		DIR24_8_EXT_ENT, dp->nh_sz,
-		FIB_TBL8_GRP_NUM_ENT);
-	dp->pool->cur_tbl8s++;
-	return tbl8_idx;
+	return fib_tbl8_pool_alloc(dp->pool, nh | DIR24_8_EXT_ENT);
 }
 
 static void
@@ -253,7 +236,6 @@ install_to_fib(struct dir24_8_tbl *dp, uint32_t ledge, uint32_t redge,
 {
 	uint64_t	tbl24_tmp;
 	int	tbl8_idx;
-	int tmp_tbl8_idx;
 	uint8_t	*tbl8_ptr;
 	uint32_t len;
 
@@ -271,15 +253,13 @@ install_to_fib(struct dir24_8_tbl *dp, uint32_t ledge, uint32_t redge,
 				 * needs tbl8 for ledge and redge.
 				 */
 				tbl8_idx = tbl8_alloc(dp, tbl24_tmp);
-				tmp_tbl8_idx = fib_tbl8_pool_get(dp->pool);
 				if (tbl8_idx < 0)
 					return -ENOSPC;
-				else if (tmp_tbl8_idx < 0) {
+				if (fib_tbl8_pool_reserve(dp->pool, 1) != 0) {
 					dp->pool->cur_tbl8s--;
 					fib_tbl8_pool_cleanup_and_free(dp->pool, tbl8_idx);
 					return -ENOSPC;
 				}
-				fib_tbl8_pool_put(dp->pool, tmp_tbl8_idx);
 				/*update dir24 entry with tbl8 index*/
 				fib_tbl8_write(get_tbl24_p(dp, ledge,
 					dp->nh_sz), (tbl8_idx << 1)|
@@ -445,7 +425,9 @@ dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 			tmp = rte_rib_get_nxt(rib, ip, 24, NULL,
 				RTE_RIB_GET_NXT_COVER);
 			if ((tmp == NULL) &&
-				(dp->pool->rsvd_tbl8s >= dp->pool->num_tbl8s))
+				(dp->pool->rsvd_tbl8s >= (dp->pool->max_tbl8s ?
+					dp->pool->max_tbl8s :
+					dp->pool->num_tbl8s)))
 				return -ENOSPC;
 
 		}
@@ -561,6 +543,8 @@ dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
 	dp->tbl8 = pool->tbl8;
 	dp->def_nh = def_nh;
 	dp->nh_sz = nh_sz;
+
+	dp->consumer.tbl8_ptr = &dp->tbl8;
 	dp->consumer.dq = &dp->dq;
 	fib_tbl8_pool_register(pool, &dp->consumer);
 
@@ -603,6 +587,7 @@ dir24_8_rcu_qsbr_add(struct dir24_8_tbl *dp, struct rte_fib_rcu_config *cfg,
 {
 	struct rte_rcu_qsbr_dq_parameters params = {0};
 	char rcu_dq_name[RTE_RCU_QSBR_DQ_NAMESIZE];
+	bool pool_rcu_added = false;
 
 	if (dp == NULL || cfg == NULL)
 		return -EINVAL;
@@ -610,6 +595,22 @@ dir24_8_rcu_qsbr_add(struct dir24_8_tbl *dp, struct rte_fib_rcu_config *cfg,
 	if (dp->v != NULL)
 		return -EEXIST;
 
+	/* Propagate RCU to the pool for resize if it is resizable */
+	if (dp->pool->max_tbl8s > 0) {
+		if (dp->pool->v != NULL && dp->pool->v != cfg->v)
+			return -EINVAL;
+		if (dp->pool->v == NULL) {
+			struct rte_fib_tbl8_pool_rcu_config pool_rcu = {
+				.v = cfg->v,
+			};
+			int rc = rte_fib_tbl8_pool_rcu_qsbr_add(
+				dp->pool, &pool_rcu);
+			if (rc != 0)
+				return rc;
+			pool_rcu_added = true;
+		}
+	}
+
 	if (cfg->mode == RTE_FIB_QSBR_MODE_SYNC) {
 		/* No other things to do. */
 	} else if (cfg->mode == RTE_FIB_QSBR_MODE_DQ) {
@@ -631,9 +632,13 @@ dir24_8_rcu_qsbr_add(struct dir24_8_tbl *dp, struct rte_fib_rcu_config *cfg,
 		dp->dq = rte_rcu_qsbr_dq_create(&params);
 		if (dp->dq == NULL) {
 			FIB_LOG(ERR, "LPM defer queue creation failed");
+			if (pool_rcu_added)
+				dp->pool->v = NULL;
 			return -rte_errno;
 		}
 	} else {
+		if (pool_rcu_added)
+			dp->pool->v = NULL;
 		return -EINVAL;
 	}
 
diff --git a/lib/fib/fib_tbl8_pool.c b/lib/fib/fib_tbl8_pool.c
index f5cecc9fc2..2ea1484c29 100644
--- a/lib/fib/fib_tbl8_pool.c
+++ b/lib/fib/fib_tbl8_pool.c
@@ -6,11 +6,14 @@
 #include <string.h>
 
 #include <eal_export.h>
+#include <rte_branch_prediction.h>
 #include <rte_debug.h>
 #include <rte_errno.h>
 #include <rte_malloc.h>
 #include <rte_rcu_qsbr.h>
+#include <rte_stdatomic.h>
 
+#include "fib_log.h"
 #include "fib_tbl8_pool.h"
 
 static inline uint64_t
@@ -69,6 +72,91 @@ fib_tbl8_pool_rcu_free_cb(void *p, void *data,
 	fib_tbl8_pool_cleanup_and_free(pool, tbl8_idx);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib_tbl8_pool_resize, 27.03)
+int
+rte_fib_tbl8_pool_resize(struct rte_fib_tbl8_pool *pool,
+			 uint32_t new_num_tbl8)
+{
+	uint32_t new_num, old_num, i;
+	uint64_t *new_tbl8, *old_tbl8;
+	uint32_t *new_fl, *old_fl;
+	char mem_name[64];
+	struct fib_tbl8_consumer *c;
+
+	if (pool == NULL)
+		return -EINVAL;
+	if (pool->v == NULL)
+		return -EINVAL;
+
+	old_num = pool->num_tbl8s;
+	new_num = new_num_tbl8;
+	if (pool->max_tbl8s != 0 && new_num > pool->max_tbl8s)
+		new_num = pool->max_tbl8s;
+	if (new_num <= old_num)
+		return -ENOSPC;
+
+	FIB_LOG(INFO, "Resizing tbl8 pool from %u to %u groups",
+		old_num, new_num);
+
+	snprintf(mem_name, sizeof(mem_name), "TBL8_%u", new_num);
+	new_tbl8 = rte_zmalloc_socket(mem_name,
+		FIB_TBL8_GRP_NUM_ENT * (1ULL << pool->nh_sz) * (new_num + 1),
+		RTE_CACHE_LINE_SIZE, pool->socket_id);
+	if (new_tbl8 == NULL)
+		return -ENOMEM;
+
+	snprintf(mem_name, sizeof(mem_name), "TBL8_FL_%u", new_num);
+	new_fl = rte_zmalloc_socket(mem_name,
+		sizeof(uint32_t) * new_num,
+		RTE_CACHE_LINE_SIZE, pool->socket_id);
+	if (new_fl == NULL) {
+		rte_free(new_tbl8);
+		return -ENOMEM;
+	}
+
+	/* Copy existing tbl8 data */
+	memcpy(new_tbl8, pool->tbl8,
+		FIB_TBL8_GRP_NUM_ENT * (1ULL << pool->nh_sz) * (old_num + 1));
+
+	/*
+	 * Rebuild the free list: copy the existing in-use portion,
+	 * then append new indices at the top.
+	 */
+	memcpy(new_fl, pool->free_list, sizeof(uint32_t) * old_num);
+	for (i = old_num; i < new_num; i++)
+		new_fl[i] = i;
+
+	old_tbl8 = pool->tbl8;
+	old_fl = pool->free_list;
+
+	pool->free_list = new_fl;
+	pool->num_tbl8s = new_num;
+
+	/*
+	 * Ensure copied tbl8 contents are visible before publishing
+	 * the new pointer on weakly ordered architectures.
+	 */
+	rte_atomic_thread_fence(rte_memory_order_release);
+
+	pool->tbl8 = new_tbl8;
+
+	/* Update all registered consumer tbl8 pointers */
+	SLIST_FOREACH(c, &pool->consumers, next)
+		*c->tbl8_ptr = new_tbl8;
+
+	/*
+	 * If RCU is configured, readers may still be accessing old_tbl8.
+	 * Synchronize before freeing.
+	 */
+	if (pool->v != NULL)
+		rte_rcu_qsbr_synchronize(pool->v, RTE_QSBR_THRID_INVALID);
+
+	rte_free(old_tbl8);
+	rte_free(old_fl);
+
+	return 0;
+}
+
 uint32_t
 fib_tbl8_pool_reclaim(struct rte_fib_tbl8_pool *pool, uint32_t n)
 {
@@ -89,6 +177,52 @@ fib_tbl8_pool_reclaim(struct rte_fib_tbl8_pool *pool, uint32_t n)
 	return total;
 }
 
+int
+fib_tbl8_pool_reserve(struct rte_fib_tbl8_pool *pool, uint32_t n)
+{
+	uint32_t avail = pool->num_tbl8s - pool->pool_pos;
+
+	if (avail >= n)
+		return 0;
+
+	fib_tbl8_pool_reclaim(pool, n - avail);
+	avail = pool->num_tbl8s - pool->pool_pos;
+
+	while (avail < n) {
+		if (pool->max_tbl8s == 0 ||
+				rte_fib_tbl8_pool_resize(pool, pool->num_tbl8s * 2) != 0)
+			return -ENOSPC;
+		avail = pool->num_tbl8s - pool->pool_pos;
+	}
+
+	return 0;
+}
+
+int
+fib_tbl8_pool_alloc(struct rte_fib_tbl8_pool *pool, uint64_t nh)
+{
+	int32_t tbl8_idx;
+	uint8_t *tbl8_ptr;
+
+	tbl8_idx = fib_tbl8_pool_get(pool);
+
+	/* If there are no tbl8 groups try to reclaim one. */
+	if (unlikely(tbl8_idx == -ENOSPC &&
+			fib_tbl8_pool_reclaim(pool, 1) != 0))
+		tbl8_idx = fib_tbl8_pool_get(pool);
+
+	if (tbl8_idx < 0)
+		return tbl8_idx;
+
+	tbl8_ptr = (uint8_t *)pool->tbl8 +
+		((tbl8_idx * FIB_TBL8_GRP_NUM_ENT) << pool->nh_sz);
+	/* Init tbl8 entries with nexthop */
+	fib_tbl8_write((void *)tbl8_ptr, nh, pool->nh_sz,
+		       FIB_TBL8_GRP_NUM_ENT);
+	pool->cur_tbl8s++;
+	return tbl8_idx;
+}
+
 void
 fib_tbl8_pool_register(struct rte_fib_tbl8_pool *pool,
 		       struct fib_tbl8_consumer *c)
@@ -135,7 +269,10 @@ rte_fib_tbl8_pool_create(const char *name,
 
 	if (name == NULL || conf == NULL || conf->num_tbl8 == 0 ||
 	    conf->nh_sz > 3 ||
-	    conf->num_tbl8 > pool_max_tbl8(conf->nh_sz)) {
+	    conf->num_tbl8 > pool_max_tbl8(conf->nh_sz) ||
+	    conf->max_tbl8 > pool_max_tbl8(conf->nh_sz) ||
+	    (conf->max_tbl8 != 0 &&
+	     conf->max_tbl8 < conf->num_tbl8)) {
 		rte_errno = EINVAL;
 		return NULL;
 	}
@@ -150,8 +287,10 @@ rte_fib_tbl8_pool_create(const char *name,
 
 	pool->nh_sz = conf->nh_sz;
 	pool->num_tbl8s = conf->num_tbl8;
+	pool->max_tbl8s = conf->max_tbl8;
 	pool->socket_id = conf->socket_id;
 	pool->refcnt = 1;
+	SLIST_INIT(&pool->consumers);
 
 	snprintf(mem_name, sizeof(mem_name), "TBL8_%s", name);
 	pool->tbl8 = rte_zmalloc_socket(mem_name,
@@ -176,7 +315,6 @@ rte_fib_tbl8_pool_create(const char *name,
 	}
 
 	pool_init_free_list(pool);
-	SLIST_INIT(&pool->consumers);
 
 	return pool;
 }
@@ -190,3 +328,21 @@ rte_fib_tbl8_pool_free(struct rte_fib_tbl8_pool *pool)
 
 	fib_tbl8_pool_unref(pool);
 }
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib_tbl8_pool_rcu_qsbr_add, 27.03)
+int
+rte_fib_tbl8_pool_rcu_qsbr_add(struct rte_fib_tbl8_pool *pool,
+			       const struct rte_fib_tbl8_pool_rcu_config *cfg)
+{
+	if (pool == NULL || cfg == NULL || cfg->v == NULL)
+		return -EINVAL;
+
+	if (pool->v != NULL)
+		return -EEXIST;
+
+	if (pool->max_tbl8s == 0)
+		return -ENOTSUP;
+
+	pool->v = cfg->v;
+	return 0;
+}
diff --git a/lib/fib/fib_tbl8_pool.h b/lib/fib/fib_tbl8_pool.h
index 669c67f7cb..fbb7a5ae76 100644
--- a/lib/fib/fib_tbl8_pool.h
+++ b/lib/fib/fib_tbl8_pool.h
@@ -16,6 +16,7 @@
 
 #include <stdint.h>
 #include <string.h>
+
 #include <sys/queue.h>
 
 #include <rte_common.h>
@@ -23,8 +24,10 @@
 #include "fib_tbl8.h"
 #include "rte_fib_tbl8_pool.h"
 
+/** Consumer entry -- tracks each FIB's tbl8 pointer for resize updates. */
 struct fib_tbl8_consumer {
 	SLIST_ENTRY(fib_tbl8_consumer) next;
+	uint64_t **tbl8_ptr;	/**< Points to the FIB's dp->tbl8 field */
 	struct rte_rcu_qsbr_dq **dq;	/**< Points to the FIB's dp->dq field */
 };
 
@@ -34,10 +37,12 @@ struct rte_fib_tbl8_pool {
 	uint32_t	pool_pos;	/**< Number of groups taken from the free list */
 	uint32_t	cur_tbl8s;	/**< Number of groups used by the dataplanes */
 	uint32_t	rsvd_tbl8s;	/**< Number of groups reserved by the routes */
-	uint32_t	num_tbl8s;	/**< Total number of tbl8 groups */
+	uint32_t	num_tbl8s;	/**< Current capacity */
+	uint32_t	max_tbl8s;	/**< Maximum capacity (0 = fixed) */
 	uint8_t		nh_sz;		/**< Nexthop entry size (0-3) */
 	int		socket_id;
 	uint32_t	refcnt;		/**< Reference count */
+	struct rte_rcu_qsbr *v;		/**< RCU QSBR variable (for resize) */
 	SLIST_HEAD(, fib_tbl8_consumer) consumers; /**< Registered FIBs */
 };
 
@@ -90,9 +95,31 @@ uint32_t
 fib_tbl8_pool_reclaim(struct rte_fib_tbl8_pool *pool, uint32_t n);
 
 /**
- * Register a FIB consumer: its RCU defer queue is reclaimed when the pool
- * runs out of groups. The consumer is embedded in the dataplane struct of
- * the FIB.
+ * Make sure at least @p n tbl8 groups are free.
+ *
+ * Reclaims the RCU-deferred groups, then grows a resizable pool.
+ * To be called before an update keeps pointers into the tbl8 array.
+ *
+ * @return 0 on success, -ENOSPC if @p n groups can not be made available.
+ */
+int
+fib_tbl8_pool_reserve(struct rte_fib_tbl8_pool *pool, uint32_t n);
+
+/**
+ * Allocate a tbl8 group and initialise it with @p nh.
+ *
+ * Tries fib_tbl8_pool_get() first; on ENOSPC, tries RCU reclaim.
+ * Never resizes the pool, see fib_tbl8_pool_reserve().
+ *
+ * @return group index on success, negative errno on failure.
+ */
+int
+fib_tbl8_pool_alloc(struct rte_fib_tbl8_pool *pool, uint64_t nh);
+
+/**
+ * Register a FIB consumer: its tbl8 pointer is updated on resize and its
+ * RCU defer queue is reclaimed when the pool runs out of groups.
+ * The consumer is embedded in the dataplane struct of the FIB.
  */
 void
 fib_tbl8_pool_register(struct rte_fib_tbl8_pool *pool,
diff --git a/lib/fib/rte_fib_tbl8_pool.h b/lib/fib/rte_fib_tbl8_pool.h
index 18b2fadb29..c9354cdbad 100644
--- a/lib/fib/rte_fib_tbl8_pool.h
+++ b/lib/fib/rte_fib_tbl8_pool.h
@@ -21,6 +21,12 @@
  *    rte_fib_tbl8_pool_free(). The pool is freed when the last
  *    reference is dropped.
  *
+ * Resizing: if max_tbl8 is set in the pool configuration, the pool
+ * can grow on demand up to that limit. This requires an RCU QSBR
+ * variable (rte_fib_tbl8_pool_rcu_qsbr_add). When max_tbl8 is 0
+ * (default), the pool has a fixed capacity and no RCU is needed
+ * for pool operation.
+ *
  * Thread safety: none. The pool is not thread-safe. All operations
  * on FIBs sharing the same pool (route updates, FIB creation and
  * destruction, pool create/free) must be serialized by the caller.
@@ -37,6 +43,8 @@
 
 #include <stdint.h>
 
+#include <rte_rcu_qsbr.h>
+
 #ifdef __cplusplus
 extern "C" {
 #endif
@@ -45,11 +53,17 @@ struct rte_fib_tbl8_pool;
 
 /** tbl8 pool configuration */
 struct rte_fib_tbl8_pool_conf {
-	uint32_t num_tbl8;	/**< Number of tbl8 groups */
+	uint32_t num_tbl8;	/**< Initial number of tbl8 groups */
+	uint32_t max_tbl8;	/**< Max tbl8 groups (0 = fixed, no resize) */
 	uint8_t  nh_sz;		/**< Nexthop size: 0=1B, 1=2B, 2=4B, 3=8B */
 	int      socket_id;	/**< NUMA socket for memory allocation */
 };
 
+/** RCU QSBR configuration for tbl8 pool resize. */
+struct rte_fib_tbl8_pool_rcu_config {
+	struct rte_rcu_qsbr *v;	/**< RCU QSBR variable */
+};
+
 /**
  * Create a tbl8 pool.
  *
@@ -78,6 +92,46 @@ __rte_experimental
 void
 rte_fib_tbl8_pool_free(struct rte_fib_tbl8_pool *pool);
 
+/**
+ * Associate an RCU QSBR variable with the pool.
+ *
+ * Required for resizable pools so that the old tbl8 array can be
+ * reclaimed safely after a resize.
+ *
+ * @param pool
+ *   Pool handle
+ * @param cfg
+ *   RCU configuration
+ * @return
+ *   0 on success, negative errno on failure
+ */
+__rte_experimental
+int
+rte_fib_tbl8_pool_rcu_qsbr_add(struct rte_fib_tbl8_pool *pool,
+			       const struct rte_fib_tbl8_pool_rcu_config *cfg);
+
+/**
+ * Resize the tbl8 pool to a given capacity.
+ *
+ * The new capacity must be greater than the current capacity and
+ * must not exceed max_tbl8 (if set). Requires RCU to be configured.
+ *
+ * @param pool
+ *   Pool handle
+ * @param new_num_tbl8
+ *   Target number of tbl8 groups
+ * @return
+ *   0 on success
+ *   -EINVAL if RCU is not configured (see rte_fib_tbl8_pool_rcu_qsbr_add)
+ *   -ENOSPC if pool cannot grow (at max capacity or
+ *     new_num_tbl8 <= current capacity)
+ *   -ENOMEM if memory allocation failed
+ */
+__rte_experimental
+int
+rte_fib_tbl8_pool_resize(struct rte_fib_tbl8_pool *pool,
+			 uint32_t new_num_tbl8);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/fib/trie.c b/lib/fib/trie.c
index c5c8f37454..5a1a02e95e 100644
--- a/lib/fib/trie.c
+++ b/lib/fib/trie.c
@@ -103,25 +103,7 @@ trie_get_lookup_fn(void *p, enum rte_fib6_lookup_type type)
 static int
 tbl8_alloc(struct rte_trie_tbl *dp, uint64_t nh)
 {
-	int64_t		tbl8_idx;
-	uint8_t		*tbl8_ptr;
-
-	tbl8_idx = fib_tbl8_pool_get(dp->pool);
-
-	/* If there are no tbl8 groups try to reclaim one. */
-	if (unlikely(tbl8_idx == -ENOSPC &&
-			fib_tbl8_pool_reclaim(dp->pool, 1) != 0))
-		tbl8_idx = fib_tbl8_pool_get(dp->pool);
-
-	if (tbl8_idx < 0)
-		return tbl8_idx;
-	tbl8_ptr = get_tbl_p_by_idx(dp->tbl8,
-		tbl8_idx * FIB_TBL8_GRP_NUM_ENT, dp->nh_sz);
-	/*Init tbl8 entries with nexthop from tbl24*/
-	fib_tbl8_write((void *)tbl8_ptr, nh, dp->nh_sz,
-		FIB_TBL8_GRP_NUM_ENT);
-	dp->pool->cur_tbl8s++;
-	return tbl8_idx;
+	return fib_tbl8_pool_alloc(dp->pool, nh);
 }
 
 static void
@@ -442,13 +424,11 @@ modify_dp(struct rte_trie_tbl *dp, struct rte_rib6 *rib,
 	/*
 	 * Check if we can safely allocate new tbl8s further in process of modifying the dataplane.
 	 */
-	uint32_t tbl8s_in_defer_queue = dp->pool->pool_pos - dp->pool->cur_tbl8s;
-	if (dp->pool->rsvd_tbl8s + tbl8s_in_defer_queue > dp->pool->num_tbl8s) {
-		fib_tbl8_pool_reclaim(dp->pool, tbl8s_in_defer_queue);
-		tbl8s_in_defer_queue = dp->pool->pool_pos - dp->pool->cur_tbl8s;
-		if (dp->pool->rsvd_tbl8s + tbl8s_in_defer_queue >
-				dp->pool->num_tbl8s)
-			return -ENOSPC;
+	if (dp->pool->rsvd_tbl8s > dp->pool->cur_tbl8s) {
+		ret = fib_tbl8_pool_reserve(dp->pool,
+			dp->pool->rsvd_tbl8s - dp->pool->cur_tbl8s);
+		if (ret != 0)
+			return ret;
 	}
 
 	ledge = *ip;
@@ -569,7 +549,9 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 			return -rte_errno;
 
 		new_levels = count_empty_levels(node);
-		if (dp->pool->rsvd_tbl8s + new_levels > dp->pool->num_tbl8s) {
+		if (dp->pool->rsvd_tbl8s + new_levels >
+				(dp->pool->max_tbl8s ? dp->pool->max_tbl8s :
+					dp->pool->num_tbl8s)) {
 			rte_rib6_remove(rib, &ip_masked, depth);
 			return -ENOSPC;
 		}
@@ -685,6 +667,8 @@ trie_create(const char *name, int socket_id,
 	dp->nh_sz = nh_sz;
 	dp->pool = pool;
 	dp->tbl8 = pool->tbl8;
+
+	dp->consumer.tbl8_ptr = &dp->tbl8;
 	dp->consumer.dq = &dp->dq;
 	fib_tbl8_pool_register(pool, &dp->consumer);
 
@@ -739,6 +723,7 @@ trie_rcu_qsbr_add(struct rte_trie_tbl *dp, struct rte_fib6_rcu_config *cfg,
 {
 	struct rte_rcu_qsbr_dq_parameters params = {0};
 	char rcu_dq_name[RTE_RCU_QSBR_DQ_NAMESIZE];
+	bool pool_rcu_added = false;
 
 	if (dp == NULL || cfg == NULL)
 		return -EINVAL;
@@ -746,6 +731,22 @@ trie_rcu_qsbr_add(struct rte_trie_tbl *dp, struct rte_fib6_rcu_config *cfg,
 	if (dp->v != NULL)
 		return -EEXIST;
 
+	/* Propagate RCU to the pool for resize if it is resizable */
+	if (dp->pool->max_tbl8s > 0) {
+		if (dp->pool->v != NULL && dp->pool->v != cfg->v)
+			return -EINVAL;
+		if (dp->pool->v == NULL) {
+			struct rte_fib_tbl8_pool_rcu_config pool_rcu = {
+				.v = cfg->v,
+			};
+			int rc = rte_fib_tbl8_pool_rcu_qsbr_add(
+				dp->pool, &pool_rcu);
+			if (rc != 0)
+				return rc;
+			pool_rcu_added = true;
+		}
+	}
+
 	switch (cfg->mode) {
 	case RTE_FIB6_QSBR_MODE_DQ:
 		/* Init QSBR defer queue. */
@@ -766,6 +767,8 @@ trie_rcu_qsbr_add(struct rte_trie_tbl *dp, struct rte_fib6_rcu_config *cfg,
 		dp->dq = rte_rcu_qsbr_dq_create(&params);
 		if (dp->dq == NULL) {
 			FIB_LOG(ERR, "FIB6 defer queue creation failed");
+			if (pool_rcu_added)
+				dp->pool->v = NULL;
 			return -ENOMEM;
 		}
 		break;
@@ -773,6 +776,8 @@ trie_rcu_qsbr_add(struct rte_trie_tbl *dp, struct rte_fib6_rcu_config *cfg,
 		/* No other things to do. */
 		break;
 	default:
+		if (pool_rcu_added)
+			dp->pool->v = NULL;
 		return -EINVAL;
 	}
 	dp->rcu_mode = cfg->mode;
-- 
2.43.0

