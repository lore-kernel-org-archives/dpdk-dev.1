Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CF8CD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 07:25:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 764F842EC8;
	Thu, 11 Jun 2026 09:25:16 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 6FAB2400D5
 for <dev@dpdk.org>; Wed, 10 Jun 2026 08:34:30 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-36babe2c4bdso3909046a91.1
 for <dev@dpdk.org>; Tue, 09 Jun 2026 23:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781073269; x=1781678069; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IWc8FV6OJ6smYqyddwBiPKcH8LIn04Ceoc6SaocJIt0=;
 b=kqETcFJvReL36E6z14wGRqSTusZbQf+9VxaoakRTKzEc4JM4rUHFfDl2CyyZd72c58
 7zuHLdLaR7piLFNsE7i5GrliRtvk2IjPEGMYQJZ4yyRY5T62IcmXlOZwc3+z5lq7N7Ka
 piBJYWbRKvm2NmXoineXrkVWCz1n4oLujEvGT5PwM1iWP9zjKfVAqgFQ1oYnNLuXiZmB
 cgXXxp19/4KwN+If9jpVvwDmkFf17BOuJ4SoF3fpbtm9rQyzleHgHFTgO3tpVcDgb2ZJ
 993+tRLylQEABJq7Lv7X0gtCjqFVpK45S3dDI1gXq07cvni++mj2ApsIqa6fBTz6sTBh
 m+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781073269; x=1781678069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IWc8FV6OJ6smYqyddwBiPKcH8LIn04Ceoc6SaocJIt0=;
 b=Jh0W42vxqp+ds4cT5a6f8EokHhxbq1bykKe8eGxWe90FaxdBUmWWOtsAk3AZyojBTB
 eP+P7BVuAyzFQ6OaNJK1A0hVzNiWJpriTW6IR8j+hhqC1IlmV3kjwH2HBewXrnYxjCxT
 kDDxhIuUJ2vpQNtDHwzG2MLZe3EKv0WfksqRbdXmYR8ftc3Qw3Cu/SHq65r7dlQV5q/h
 cn3arnZhIbzNPaV+IueoDUGVEvuvbPWzMu3+CkFQ9uB++8KPYwdQ5R9r5hoiWFr4v2d+
 aYz8NfuP1tDAU66+5SUeRXZVZnrOaFeN2K4QLMxf7AXNOtYeSn1hToGxutjUTNTkL6sA
 DxEA==
X-Gm-Message-State: AOJu0Yx9oH3NbrXwWGE3QzyhHPywXbJ/vJpNhFR+3hiplczbBjlYnr2x
 GQwaLGJgEwKfp9uFmOBxXyAh33/hOFmPN1K9xtdG6hWlJw8W9C7fDe87W8R5OgQtuQ==
X-Gm-Gg: Acq92OEbiOfEElJ5cX5jzpjpYlYiaE13IOwnRpb09pUZ87mfbVQeSAHiUIfrJ22/R9O
 O0G+ZqPAwV0xYNvW+Jq509aquS2sLAMTCkYmO85VBhJ6mvs9qrXvyJtlnMwrW0I5rf6I3TCmleM
 6gxJKZoWRkW+7vIzeoV0+h8ORrRXEN47qdEYcXFYI9O7CZRE+x8UU0VTpJi3wk2z4v8oGFzrFmp
 NFQMtTjfPBY7+9N13RMdPpm4AyMAf9JklzQsekctu/wyHvtpAcHDtZEGAEQGTf29ilf4yw5MKOD
 9QDzpwi+x2lsiRyiP06Gw/l4aARb6rc85As/wlUO3Ii/Ix0Inaqx6axhctic+M6eXCaWDoAkfXz
 MqMOqWHY+GGWKtogJCM2v2ureOrN6xaCEz4ReJOwHKQvL9NXin6divwScBi4SS8lCXEZ/RBQLcx
 ZK/b0MVsipKJrfd4FAEKQP0GohJr2DtFQcN1lmtcUWo5jZzQ==
X-Received: by 2002:a17:90b:1641:b0:36b:71e6:3de3 with SMTP id
 98e67ed59e1d1-370ee33d32emr23613352a91.3.1781073269407; 
 Tue, 09 Jun 2026 23:34:29 -0700 (PDT)
Received: from localhost ([61.119.121.203]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f711e52b0sm22091499a91.15.2026.06.09.23.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 23:34:28 -0700 (PDT)
From: Linhu Li <lilinhu618@gmail.com>
To: dev@dpdk.org
Cc: stable@dpdk.org,
	dsosnowski@nvidia.com,
	Linhu Li <lilinhu618@gmail.com>
Subject: [PATCH v3] net/mlx5: fix counter TAILQ race between free and query
 callback
Date: Wed, 10 Jun 2026 14:34:25 +0800
Message-Id: <20260610063425.73808-1-lilinhu618@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260604101112.72177-1-lilinhu618@gmail.com>
References: <20260604101112.72177-1-lilinhu618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jun 2026 09:25:15 +0200
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
because the query callback and the release function operate on different lists.
That holds only if the free path always observes the up-to-date query_gen. It
can be violated:

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
TAILQ_CONCAT run concurrently on the same list with no synchronization and
corrupt it: the pool-local list ends up with a NULL head but a dangling
tqh_last, and the global free list tail no longer points to the real tail. The just-
freed counter and every counter inserted afterwards become unreachable
and are leaked.

Non-PMD threads can be preempted for hundreds of microseconds under
CPU pressure, which is well within the async query round-trip time, so the
window is reachable in practice.

Fix it by taking pool->csl in the query completion callback before operating on
pool->counters[query_gen], serializing the CONCAT with any concurrent
INSERT. The lock is taken once per pool per query completion in the eal-intr-
thread context, not on the datapath, so the cost is negligible. Lock order is
pool->csl then cmng->csl, matching all other sites.

Also handle the error path: previously the counters accumulated in
pool->counters[query_gen] were abandoned when a query failed. Move
them back to the global free list to avoid a leak on persistent query failures.

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

