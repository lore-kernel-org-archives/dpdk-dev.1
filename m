Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63F1CD98D2
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 09:29:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D235542F75;
	Thu, 11 Jun 2026 11:29:34 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id B673842E98
 for <dev@dpdk.org>; Thu, 11 Jun 2026 09:51:51 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2bf2247e38eso78303115ad.3
 for <dev@dpdk.org>; Thu, 11 Jun 2026 00:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781164311; x=1781769111; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NumvtYXa/1WGG8iNJGH4DAX5FC9DugPqh2UOhsfXSoE=;
 b=T8H8bCrdBdRok0A1pqs8LTq9hwB2qlgwRUB8FTlkWpYETZgCpGhzrYbILRuQJao/T8
 NfEQNhn3QEQjlww/W5zDthUp7uLrEZZymCXy+sQo4hxMhXUEkMtkjr8+bj3dtf26N+0z
 ivuR8RJG6W3drv8P+vIUIu0/MwXjIzzUvn5LTdfJHA1WS6PjbOFKlvirxfkvRTYo5CvV
 YMRlWOwzDt5xvX1xbK+h1ja3q4cJknjYk/akxJpc2T6G75R7s5F/x4WVTGSfnxaboBYY
 mPTxbzcRn2mejiX6H+fbUdlKOf8JxWakImHmstBPWD3iDzBniSkCtP0zL6Y+ViuztCK4
 mk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781164311; x=1781769111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NumvtYXa/1WGG8iNJGH4DAX5FC9DugPqh2UOhsfXSoE=;
 b=OsKgFG4XZ65I1kMjIspMDrfnrRWjz/6Rdx3ziW/KNv2XmaGZ9AASa6VZGszGXJbF+S
 3FquxoHL4bASkUKLtwxfkwwUZgLlxtS5Pzh5G1AR9d6I8om4ZiL+U5mtq5obnWh6dlT4
 JtoC+F+sqHi70GlZp8rjLBnBODyNyrB1g0q5NGqsw5od28lrwlycW8eAhIRWs5lAVNDA
 P1yO7YTxWRIiEdu6SKrzM49fJtYCXxzl1gKlV8Fyway/H1CDk4SNczEDp5FzDTjjHLiZ
 2bJAau8coDF85KhPwrj1kjpxRZJCTstUxtwCUObRdBRhqXAo+lp4QtBdQOIjQmPi1p6+
 KWIQ==
X-Gm-Message-State: AOJu0Yy1SLZGiBvQkXRn4PCgZuPQro0irGVnzUqSzsLgoyukZRiBMAqq
 w8W+3uuiiv+anLTDP6kaBcAvw98ge4uLOw4XXxl1wIwKMwX0hCIAWIGyG4MMtseOtQ==
X-Gm-Gg: Acq92OHhMbShIkHZEvtp6Gca7z5bp7p2CdgOFYgqxPnXUQ9HPeqXAfSLI1jUvTLky9a
 ueJuAUydlkIaBvZVtYyXKHlajUzNVzeHwq0nhxFllAxR2G7tXXCl79Lcx+G8Rs8hPZLdL4kRQGa
 mxlJ3dNlaeWfc+Ep49IZZxbUA1knASoOhrWpx65yzEBs25QgzCyCg0AbtedJnzXMDOYf0VH8gK8
 F7rF0WJBZUF/guSjKcWd5zkIoEKseTTmMf+Y8CQkgp87hJ+lWJeB14N3l1Sns38OAKYsnP2P7zt
 bqo7zr8mkr+AcX5F1iXv5Vl5P8HtmJcyVVcSIOfBvR6I+T4IIzpd6Oxhstu1Y738IBpgortIOIP
 XMqpajFAKdhHkkCSUvtnSxjok3vkbmpnKy4eEIS/DiI3EIbrQ+8eTzqFp21cZqwwcMDnisijq+1
 xK+4DFO046VF66chY1XnvUwxpsGnCPLwIHnHUhTnmexhgu1w==
X-Received: by 2002:a17:903:2c0c:b0:2c1:98b7:ecf3 with SMTP id
 d9443c01a7336-2c2f1eba128mr19132975ad.23.1781164310600; 
 Thu, 11 Jun 2026 00:51:50 -0700 (PDT)
Received: from localhost ([61.119.121.204]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f8679esm260198355ad.21.2026.06.11.00.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 00:51:50 -0700 (PDT)
From: Linhu Li <lilinhu618@gmail.com>
To: dev@dpdk.org
Cc: stable@dpdk.org,
	dsosnowski@nvidia.com,
	Linhu Li <lilinhu618@gmail.com>
Subject: [PATCH v4] net/mlx5: fix counter TAILQ race between free and query
 callback
Date: Thu, 11 Jun 2026 15:51:47 +0800
Message-Id: <20260611075147.38924-1-lilinhu618@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260604101112.72177-1-lilinhu618@gmail.com>
References: <20260604101112.72177-1-lilinhu618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jun 2026 11:29:33 +0200
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

Fixes: ac79183dc6f7 ("net/mlx5: optimize free counter lookup")
Cc: stable@dpdk.org

Signed-off-by: Linhu Li <lilinhu618@gmail.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 doc/guides/rel_notes/release_26_07.rst | 21 +++++++++++++++++
 drivers/net/mlx5/mlx5_flow.c           | 31 ++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index b8a3e2ced9..30a9564884 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -153,6 +153,27 @@ ABI Changes
 * No ABI change that would break compatibility with 25.11.
 
 
+Fixed Issues
+------------
+
+.. This section should contain fixed issues in this release. Sample format:
+
+   * **Add a title in the past tense with a full stop.**
+
+     Add a short 1-2 sentence description of the fix in the past tense.
+
+   This section is a comment. Do not overwrite or remove it.
+   Also, make sure to start the actual text at the margin.
+   =======================================================
+
+* **net/mlx5: Fixed counter TAILQ race between free and query callback.**
+
+  Fixed a race condition where concurrent counter free operations and async
+  query completions could corrupt the counter free list, causing counter leaks.
+  The issue occurred when non-PMD threads were preempted between reading
+  ``query_gen`` and inserting into the counter list.
+
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
-- 
2.39.3 (Apple Git-146)

