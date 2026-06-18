Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF956CD98F8
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 08:03:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04B854028C;
	Fri, 19 Jun 2026 10:03:32 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id D78A840268
 for <dev@dpdk.org>; Thu, 18 Jun 2026 11:14:54 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2bf125989f2so4717605ad.3
 for <dev@dpdk.org>; Thu, 18 Jun 2026 02:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781774094; x=1782378894; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BrZm+n8xqMMu0sfz12jUCswXwSOoe6jtuZE62R1owdc=;
 b=J94NlC1/RGvLv6+s01YELdexHopS82WPHUgW71inkcPHodVI/Nb3H/pkMl35+3k/hC
 1oLg6uIh5GWF8grcSuYCQO2JuDjSEwAkW0qO04+Dg6DIzrfxrKybEepBG1+dnsKPINjv
 n+2GHXUfx7bMwOeo72fR706g167zW6f8LpMSzlAFVD1jzx1kVY2UBhD6mjXSn3qJKQeF
 wFnIH+g/TJpgUQ5KU/QErXKp2vcJRHTeNppq4lJmaztSLjjsc9hwUR+rWtDoMhYzQ8jU
 TjJCQxUZi44D9KRIS1cD9Cwg0E8vPdQ+uACzg6q8Niq/2ZMPkBVPgH70lOv+s/QEKiHq
 E+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781774094; x=1782378894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BrZm+n8xqMMu0sfz12jUCswXwSOoe6jtuZE62R1owdc=;
 b=aE/VPIU3MOTwgPGi5vFtiiabzeyrR+/85uuaIw2YWEs2zpBUyRQtgEuHykKF8mYsOD
 gnHSvA4astkZkJQy6zLyHw9YJT6F6Zf7pWmGY9vl3kFSWFK8OIUCtGayfC50454VGOTk
 3HA1hO2ew7LVMcZPG5r7UBjqop7mf0MNPTcQiXiFK5+V+dyuiOxMdeM7Lso/idM0tweJ
 HKkSysAG7t+LA4JQDJ7Dp/5vuZdUbaFL4oVQtPe0J0IxuSo7Fv8G319Y9Ia9qFU8jvBe
 AVmY72ply2xwaQ7jfaSl1l4V1vw4v+ZPCUXZ3k7qnIIir+0J6S0EKVTuGZ2M8DLAKAAo
 jtxA==
X-Gm-Message-State: AOJu0YyJFSVeSZwaVAu7xaxefdwNoqSYvdfzlv9zzkQ+AkloLjUzQSiM
 R8gOTldu49FX6vZ/0gEiABtfWwNU9Qgg7W6zzbpEeTHNC9AESMPI0sXeXfJN5hs=
X-Gm-Gg: AfdE7cls3XO3Ve4Zsur5ut74IKg39Q02rc/eoj6khWIk09ZDboFAb+1qHb/bFOGdSng
 +7nL4MU+e5rqtTwYQ2S1g8Gnz0UlJojw7FtKK76npfKxMX5uhY4hc7ESG95eIpoXQLs0w3HnCBR
 okVyMRKFPPa2/EicOsb7a0DiBl2ZDg6O5gRpEsi2I1rM/cDVxyO8L0R2vZHyX7WTCqvRI+90b4A
 ABaKNDdU3cd3ZmI8sFTZWuspxjcgR7U6udNllYyUGaXXGxaaUa6K3Y9aGO+HDDXGKwXcUvqeaFc
 FJaS2BGMUTLYG/DU+XwefAwJq/7NHkc5sUGRdnnbOhH5dU/s78Pbk6+PLZigNpUnY7Mr4EhF/aw
 pdtqfR/TpmR4h4okdNMRY+LpkkapdZMv5S+wumBqAaw3fRQABeub3bWqxbYKlkFuZzFc2kWUrWN
 x3RwHHFxTCD8WTFZ8gRIvxc9g45xPjrqAeydM=
X-Received: by 2002:a17:903:2990:b0:2c0:b9a1:6493 with SMTP id
 d9443c01a7336-2c6bc0b5814mr78993635ad.10.1781774093786; 
 Thu, 18 Jun 2026 02:14:53 -0700 (PDT)
Received: from localhost ([61.119.121.206]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c6bbc5323csm50321195ad.45.2026.06.18.02.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 02:14:53 -0700 (PDT)
From: Linhu Li <lilinhu618@gmail.com>
To: dev@dpdk.org
Cc: stable@dpdk.org,
	dsosnowski@nvidia.com,
	Linhu Li <lilinhu618@gmail.com>
Subject: [PATCH v6] net/mlx5: fix counter TAILQ race between free and query
 callback
Date: Thu, 18 Jun 2026 17:14:50 +0800
Message-Id: <20260618091450.19204-1-lilinhu618@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260604101112.72177-1-lilinhu618@gmail.com>
References: <20260604101112.72177-1-lilinhu618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 19 Jun 2026 10:03:30 +0200
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

flow_dv_counter_free() inserts counters into
pool->counters[pool->query_gen] under pool->csl. Meanwhile,
mlx5_flow_async_pool_query_handle() moves counters from
pool->counters[query_gen ^ 1] to the global free list via
TAILQ_CONCAT while holding only cmng->csl, not pool->csl.

The comment in flow_dv_counter_free() claims the lock is not needed
because the query callback and the release function operate on
different lists. That holds only if the free path always observes
the up-to-date query_gen. It can be violated:

1. A counter free thread (non-PMD, e.g. OVS offload thread) reads
   pool->query_gen == 0 and is about to insert into counters[0].
2. The free thread is preempted by the OS scheduler; it is a regular
   pthread, not pinned to a core.
3. The eal-intr-thread alarm fires: query_gen++ (now 1) and the async
   query is sent.
4. Hardware completes the query and the callback runs TAILQ_CONCAT on
   counters[0] (= query_gen ^ 1).
5. The free thread resumes and runs TAILQ_INSERT_TAIL on counters[0]
   concurrently with step 4 on another core.

Because the two paths take different locks, TAILQ_INSERT_TAIL and
TAILQ_CONCAT run concurrently on the same list with no synchronization
and corrupt it: the pool-local list ends up with a NULL head but a
dangling tqh_last, and the global free list tail no longer points to
the real tail. The just-freed counter and every counter inserted
afterwards become unreachable and are leaked.

Non-PMD threads can be preempted for hundreds of microseconds under
CPU pressure, which is well within the async query round-trip time,
so the window is reachable in practice.

Fix it by taking pool->csl in the query completion callback before
operating on pool->counters[query_gen], serializing the CONCAT with
any concurrent INSERT. The lock is taken once per pool per query
completion in the eal-intr-thread context, not on the datapath, so
the cost is negligible. Lock order is pool->csl then cmng->csl,
matching all other sites.

Also handle the error path: previously the counters accumulated in
pool->counters[query_gen] were abandoned when a query failed. Move
them back to the global free list to avoid a leak on persistent
query failures.

Additionally, fix a second independent race in flow_dv_counter_free():
TAILQ_INSERT_TAIL is passed &pool->counters[pool->query_gen] directly,
but the macro evaluates its head argument multiple times. Since
pool->query_gen is a volatile bit-field, if mlx5_flow_query_alarm()
increments query_gen between two evaluations of the macro, the same
insertion can operate on two different lists: the earlier steps update
counters[0] while the later steps update counters[1], leaving both
lists with inconsistent metadata and leaking the counter. Fix by
caching pool->query_gen into a local variable before calling the macro.

Fixes: ac79183dc6f7 ("net/mlx5: optimize free counter lookup")
Cc: stable@dpdk.org

Signed-off-by: Linhu Li <lilinhu618@gmail.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---

v6:
- Rebased onto latest main to resolve a release notes conflict: a new
  mlx5 entry was added upstream after v5, so this patch now adds its
  fix as a sub-bullet under the existing "Updated NVIDIA mlx5 ethernet
  driver" entry instead of a separate item.

v5:
- Added fix for Race 2: cache pool->query_gen into a local variable
  before TAILQ_INSERT_TAIL to prevent the macro from evaluating the
  volatile bit-field multiple times and crossing generation lists.
- Updated release notes: moved the fix entry under "Updated NVIDIA mlx5
  driver" in New Features instead of using a separate "Fixed Issues" section.

v4:
- Fixed commit log line length over 75 characters.

v3:
- Added release notes entry.
- Added function comment in mlx5_flow_async_pool_query_handle().
- Clarified error path comment to note it is safe for transient failures.

v2:
- Fixed Signed-off-by to use full name.

 doc/guides/rel_notes/release_26_07.rst |  2 ++
 drivers/net/mlx5/mlx5_flow.c           | 31 ++++++++++++++++++++++++++
 drivers/net/mlx5/mlx5_flow_dv.c        | 12 +++++-----
 3 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 5d7aa8d1bf..cdbd28ef4f 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -139,6 +139,8 @@ New Features
 * **Updated NVIDIA mlx5 ethernet driver.**
 
   * Added support for selective Rx in scalar SPRQ Rx path.
+  * Fixed counter free list corruption when counter free operations race with
+    asynchronous query completions.
 
 * **Updated PCAP ethernet driver.**
 
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index a95dd9dc94..b0eac185b5 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -9893,6 +9893,13 @@ void
 mlx5_flow_async_pool_query_handle(struct mlx5_dev_ctx_shared *sh,
 				  uint64_t async_id, int status)
 {
+	/*
+	 * Handle async counter pool query completion.
+	 * query_gen is flipped each round: freed counters go into [query_gen],
+	 * while this callback moves [query_gen ^ 1] to the global free list.
+	 * pool->csl must be held when operating on pool->counters[] to serialize
+	 * with concurrent free-path insertions.
+	 */
 	struct mlx5_flow_counter_pool *pool =
 		(struct mlx5_flow_counter_pool *)(uintptr_t)async_id;
 	struct mlx5_counter_stats_raw *raw_to_free;
@@ -9904,6 +9911,21 @@ mlx5_flow_async_pool_query_handle(struct mlx5_dev_ctx_shared *sh,
 
 	if (unlikely(status)) {
 		raw_to_free = pool->raw_hw;
+		/*
+		 * The query failed, so the freed counters accumulated
+		 * in the old-gen list would otherwise be stranded.
+		 * Move them back to the global free list. This is safe
+		 * for both transient and persistent failures: the
+		 * counters are still valid and can be reused.
+		 */
+		if (!TAILQ_EMPTY(&pool->counters[query_gen])) {
+			rte_spinlock_lock(&pool->csl);
+			rte_spinlock_lock(&cmng->csl[cnt_type]);
+			TAILQ_CONCAT(&cmng->counters[cnt_type],
+				     &pool->counters[query_gen], next);
+			rte_spinlock_unlock(&cmng->csl[cnt_type]);
+			rte_spinlock_unlock(&pool->csl);
+		}
 	} else {
 		raw_to_free = pool->raw;
 		if (pool->is_aged)
@@ -9913,11 +9935,20 @@ mlx5_flow_async_pool_query_handle(struct mlx5_dev_ctx_shared *sh,
 		rte_spinlock_unlock(&pool->sl);
 		/* Be sure the new raw counters data is updated in memory. */
 		rte_io_wmb();
+		/*
+		 * A counter free thread may have read a stale query_gen
+		 * before the generation was flipped and could still be
+		 * inserting into this same old-gen list. Hold pool->csl to
+		 * serialize TAILQ_CONCAT with that TAILQ_INSERT_TAIL and
+		 * avoid corrupting the list.
+		 */
 		if (!TAILQ_EMPTY(&pool->counters[query_gen])) {
+			rte_spinlock_lock(&pool->csl);
 			rte_spinlock_lock(&cmng->csl[cnt_type]);
 			TAILQ_CONCAT(&cmng->counters[cnt_type],
 				     &pool->counters[query_gen], next);
 			rte_spinlock_unlock(&cmng->csl[cnt_type]);
+			rte_spinlock_unlock(&pool->csl);
 		}
 	}
 	LIST_INSERT_HEAD(&sh->sws_cmng.free_stat_raws, raw_to_free, next);
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 307354c886..58ebcf87eb 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -7129,6 +7129,7 @@ flow_dv_counter_free(struct rte_eth_dev *dev, uint32_t counter)
 	struct mlx5_flow_counter_pool *pool = NULL;
 	struct mlx5_flow_counter *cnt;
 	enum mlx5_counter_type cnt_type;
+	uint32_t query_gen;
 
 	if (!counter)
 		return;
@@ -7153,16 +7154,17 @@ flow_dv_counter_free(struct rte_eth_dev *dev, uint32_t counter)
 	cnt->pool = pool;
 	/*
 	 * Put the counter back to list to be updated in none fallback mode.
-	 * Currently, we are using two list alternately, while one is in query,
+	 * Currently, we are using two lists alternately, while one is in query,
 	 * add the freed counter to the other list based on the pool query_gen
 	 * value. After query finishes, add counter the list to the global
-	 * container counter list. The list changes while query starts. In
-	 * this case, lock will not be needed as query callback and release
-	 * function both operate with the different list.
+	 * container counter list. Cache query_gen into a local variable before
+	 * TAILQ_INSERT_TAIL, since the macro evaluates its head argument
+	 * multiple times and pool->query_gen is a volatile bit-field.
 	 */
 	if (!priv->sh->sws_cmng.counter_fallback) {
 		rte_spinlock_lock(&pool->csl);
-		TAILQ_INSERT_TAIL(&pool->counters[pool->query_gen], cnt, next);
+		query_gen = pool->query_gen;
+		TAILQ_INSERT_TAIL(&pool->counters[query_gen], cnt, next);
 		rte_spinlock_unlock(&pool->csl);
 	} else {
 		cnt->dcs_when_free = cnt->dcs_when_active;
-- 
2.39.3 (Apple Git-146)

