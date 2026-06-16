Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE6FCD98E2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 13:52:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B30394027F;
	Wed, 17 Jun 2026 15:52:06 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id D6EB14065D
 for <dev@dpdk.org>; Tue, 16 Jun 2026 10:03:57 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-36b9ec98144so3392322a91.1
 for <dev@dpdk.org>; Tue, 16 Jun 2026 01:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781597037; x=1782201837; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w+x0ssWT7SAJynLotZs7QdCWw3168EwmB/vfsk4cdbE=;
 b=Wr/JiYPrWSPP3T0OYNVm+dNrcJnRCH+g7uxfRFFVQDb3r0wLjZei5/Rgl2ymoOq48R
 Pt2+8R0CgF7ZpbUZI99vGpPd4MVE18khjo44bxzBt+I6Suo7+jqLC4pV4OufUw2Ll8/I
 cXcgrv9O5QUyAbFFj9S5V+rQn5sVZUTKtGH45FfgjPMV4bnYOhfyMFcCfwfVa9iY0JRj
 pFJEHKdnQ4aM1bpJm9IUlnyFcmvkdSqIh6ueoBKcDMFSq/0YX08hX9jrCvgNFu4LjwVy
 l/4L6LIXJA6xUUkPHJT8hQCmf58aT8Ekb9HVjd0rxl0OQj0ip7OWYPIKpnR8D2OWWtEN
 Pwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781597037; x=1782201837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w+x0ssWT7SAJynLotZs7QdCWw3168EwmB/vfsk4cdbE=;
 b=XjfjQud3mpHqJBgaC9jURR0EYloub+PTYnwWBG0gksop2TBIV8KvUuisRutcGaOst3
 6ZLwdr740ysi3avftSSNGFRnaputUbo/L/yW6cESRrxDa0ZEgv4Pgl59BVg2zB7k63Di
 bnKIfwzqLvdLgI5btv7ugM/ue/8HdpEz3FlieTYdxQXc7GQ0jJbQHcupfE5PuFo4n9es
 8Cw3EpX9NaAZ8C720p0rc0f97BUh9b9ApWVBUNuXnf0Knx+4GmEg1MNLuYGPthK50dih
 02sOMvWaH/7iUESNXL7oucoQKtR/j1NnqXvjwkGQd8QN568CYkwrD1/SWbTQtEZz44gH
 +D9A==
X-Gm-Message-State: AOJu0YzPPgnGb6asU9MOKAGpJ9hoYwhoODcOwyFj36dlQK4b6AQgJK2Z
 GyiGcTegTUhZrRIRAAVB/38owwBd/duAoF6eUZ+15cHZ+LPB0r9v2gkiYjkQtIVV1bBL
X-Gm-Gg: Acq92OF0moHEu8vfX736cYHiEvQUykBLu74M1CJaIG0FBkuDmQgEXdb8hN+aN71jyLy
 Qw7wcuLrIyW9+thLMWg98mhbE0t+EEMsbK4/1xKBpyxJxEKstuvWJj2FhCDRiS/1Bf11uL1E3z0
 oHp9E/jP1CgOTAg2QybJw7SfIUtoDvy4XPnNwsAF7HnZdwt8/sSgeoq2Pzgvg5fDtkwbwyFYw9W
 1WfXbXLcWNMa9XijLnLQcD5q4j9a/uTAm1sRmlNAcgJZPxRoKOrBkKCSdsssX0/6OGtF7O4pz02
 WwSnJms8h0aSl2JHiLHeKeFPEzlFNe0+/GjjhETcEDyKHozm8CvnsXHax7NG7mgd6nQoq5F38uU
 cs4gafVcAEstszz4DBgq3SBximNYjPoT+//jQk/Rzaw3ag5RMdfyuOFl42u/aeqr24Qu1PsD2+H
 JwAacb8Y/CUhaUlIDxBdB70hI0/Jt/ZWJhlhw=
X-Received: by 2002:a17:90b:28c7:b0:36a:95c:7613 with SMTP id
 98e67ed59e1d1-37c5233ff67mr2955250a91.10.1781597036780; 
 Tue, 16 Jun 2026 01:03:56 -0700 (PDT)
Received: from localhost ([61.119.121.206]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c521a959bsm2011535a91.2.2026.06.16.01.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 01:03:56 -0700 (PDT)
From: Linhu Li <lilinhu618@gmail.com>
To: dev@dpdk.org
Cc: stable@dpdk.org,
	dsosnowski@nvidia.com,
	Linhu Li <lilinhu618@gmail.com>
Subject: [PATCH v5] net/mlx5: fix counter TAILQ race between free and query
 callback
Date: Tue, 16 Jun 2026 16:03:52 +0800
Message-Id: <20260616080352.10378-1-lilinhu618@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260604101112.72177-1-lilinhu618@gmail.com>
References: <20260604101112.72177-1-lilinhu618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 17 Jun 2026 15:52:05 +0200
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

 doc/guides/rel_notes/release_26_07.rst |  6 +++++
 drivers/net/mlx5/mlx5_flow.c           | 31 ++++++++++++++++++++++++++
 drivers/net/mlx5/mlx5_flow_dv.c        | 12 +++++-----
 3 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index b8a3e2ced9..6c6f0aa696 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -90,6 +90,11 @@ New Features
   * Added support for transmitting LLDP packets based on mbuf packet type.
   * Implemented AVX2 context descriptor transmit paths.
 
+* **Updated NVIDIA mlx5 driver.**
+
+  Fixed counter free list corruption when counter free operations race with
+  asynchronous query completions.
+
 * **Updated PCAP ethernet driver.**
 
   * Added support for VLAN insertion and stripping.
@@ -153,6 +158,7 @@ ABI Changes
 * No ABI change that would break compatibility with 25.11.
 
 
+
 Known Issues
 ------------
 
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 915ea29a5a..2f785d58ec 100644
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
index c2a2874913..060ccdeec2 100644
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

