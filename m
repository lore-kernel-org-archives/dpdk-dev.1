Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC8DCD6E6B
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 12:39:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68584402CC;
	Thu,  4 Jun 2026 14:39:15 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 4E82D402E0
 for <dev@dpdk.org>; Thu,  4 Jun 2026 12:11:25 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-36bcf3d2565so352449a91.3
 for <dev@dpdk.org>; Thu, 04 Jun 2026 03:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780567884; x=1781172684; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/73zjf44wMst5mK7oJiSaP1WtZJytkseRpD3MANfBzE=;
 b=QSkVR31OwN2IUv2pvlJEOcb4QX/Gkgi5r/qFMGd7EQiHjmgvnmTGbyP02vG5SRuK0E
 gUDIFF5Et98CdEnMrNiFCigZ1AmHFQwxmsAUinIRi4Z1PQSlgP2bPd2zu7Q5BeifbJUw
 +PNsoRJQW8+Ow49u5uaT3NQvwKFLI1CX1kqi9a6t9xSaP7cJkMfQqk7c4P9WQGnfMIDL
 bKwDmH7LeXrxOA/HaEPKc/HyAhKfoL7rjyvip2HRfYLHcbD+VMzdwL/wFuQsh2wACFvi
 PQnGPlHVaqOe5Kp0MJJaynj4UNp9RcGP/+FCKrr9Yc5EO+/NlSH02Pe2fRZWlK3f4ZON
 mb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780567884; x=1781172684;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/73zjf44wMst5mK7oJiSaP1WtZJytkseRpD3MANfBzE=;
 b=GaYcJShwdpuSrrC1+s85nTAQ7xR6XtwPSdrBj3DThDqURChM315STE8Uft18SnvEGx
 svQgRAZfMUUZXc3aRQQP44YRlxWQFpSxYFEqMBzptAQ39pm+GteiqJmWd9nSetEZwwS5
 JTIZ2yMPOm4bxORA+qfSZ5AQU8zZkXz05igc4cjf3v3+z+6rE0bR5ApUOIQiXNM9T0tW
 VMe1nMTQKaGJ55DoU4rp5Q5DqL9dnPuaVNz0tGpYxU9tsiD632OYnpQVLq69gCK6ZSKo
 w9VOEKOD/fHMNSkaFmLC0thc/VvNRcv6v9jBsmB4cehA+RrhYyHNix4lSnghQ3J+bq9k
 ei+Q==
X-Gm-Message-State: AOJu0Ywr4ohVqAUiSfb/K8qYHhXqrh6GjFzgKhOzM2HoMSO7Cd6q7CQz
 WAJzmePBm4WC6jayqa4DcG8pw54iUkAxILmjjYNyFnRFIvY3DlNXPcea0WiwoT5FU7M6
X-Gm-Gg: Acq92OH9wdMCt+BoN/8AncQxIWf1C9/6F1VmirFOtDjOwzbVK4/VjpXI1LzGylryszG
 wX155HQyTA/kxTntL5J7lVaH/Hrq/bHAX6PHrNcIqF+bCR6mdZXH7yXd5Hk5QvEWdwOY16job/h
 tsUNdzBKcnphqeAFKvC5W70ogUPqR+h5VzptDya9Rde3wCDUrTr/GlOr5IvraUJkX8PRelZw3mk
 pVES7N4iQNtrBiWSOKOEWWvs5EW9Ou72ue//c/W2IMtzFAb23Mvk06IXXqAhu77/68YANGIOd85
 pgzYg580pFdyP6lny/lqGOJ5OjL3VzOWbXazsFD/vdjGR4zZoJjzcMpobZJHwFGgUV3Q5yGyzaZ
 SLHSG3mWtL5zuayJB4VaGfoCZ6FMjGHGS08EZp51HtaCc12uDk/1iI+gDD0eKXl7HZwYBgZVHDU
 M4khYYLUok1yhv0WuqKLCeEd8cwj1yk8uaxCMVip413+ljiA==
X-Received: by 2002:a17:90b:2d8d:b0:36b:e8b9:46a4 with SMTP id
 98e67ed59e1d1-36e32285cf3mr7076915a91.14.1780567884241; 
 Thu, 04 Jun 2026 03:11:24 -0700 (PDT)
Received: from localhost ([61.119.121.204]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36e719b640esm3583264a91.2.2026.06.04.03.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 03:11:23 -0700 (PDT)
From: Laaahu <lilinhu618@gmail.com>
To: dev@dpdk.org
Cc: stable@dpdk.org,
	lilinhu <lilinhu618@gmail.com>
Subject: [PATCH] net/mlx5: fix counter TAILQ race between free and query
 callback
Date: Thu,  4 Jun 2026 18:11:12 +0800
Message-Id: <20260604101112.72177-1-lilinhu618@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 04 Jun 2026 14:39:14 +0200
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

From: lilinhu <lilinhu618@gmail.com>

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
TAILQ_CONCAT run concurrently on the same list with no
synchronization and corrupt it: the pool-local list ends up with a
NULL head but a dangling tqh_last, and the global free list tail no
longer points to the real tail. The just-freed counter and every
counter inserted afterwards become unreachable and are leaked.

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

Signed-off-by: lilinhu <lilinhu618@gmail.com>
---
 drivers/net/mlx5/mlx5_flow.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 915ea29a5a..20aad87f5d 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -9904,6 +9904,20 @@ mlx5_flow_async_pool_query_handle(struct mlx5_dev_ctx_shared *sh,
 
 	if (unlikely(status)) {
 		raw_to_free = pool->raw_hw;
+		/*
+		 * The query failed, so the freed counters accumulated in the
+		 * old-gen list during this round would otherwise be stranded.
+		 * Move them back to the global free list to avoid a leak when
+		 * queries fail persistently.
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
@@ -9913,11 +9927,20 @@ mlx5_flow_async_pool_query_handle(struct mlx5_dev_ctx_shared *sh,
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

