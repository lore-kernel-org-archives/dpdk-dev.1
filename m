Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF369CD8CAD
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 07:02:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACA31402BE;
	Tue,  9 Jun 2026 09:02:32 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 21DAC402ED
 for <dev@dpdk.org>; Mon,  8 Jun 2026 15:26:05 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-36babe2c4bdso2522283a91.1
 for <dev@dpdk.org>; Mon, 08 Jun 2026 06:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780925164; x=1781529964; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zQpEFonZfDNVpg2dDfZVJgo+PGGA++DsD8OZa0Pwhuw=;
 b=FedER2zMGKb1THul2N24tqRJ7rXKUWKBiq6LtuulC4plNXxLxKXCaWg1y8GZwbRJ5G
 p1cVtNAgkzvtUIJlNk+5n8M2YVYBAO1NRX1bVdUevpOL96mIwDuxvPUP3ycE6NTFc2sz
 O/SM021X+fYOzZ7TnMxZ1HVYV3f+tdcFncL3fgsvoSFnLiwxYanvrDhLPCwREE7i8U1b
 JQX6iX7XAg4pe7/f6I59eUBi//4XFoWIPxelBIWWtdpq2a3CdhJyd2KU/4KyWyaZXOWA
 oH4R+Mumzx2u3TdZdK7CRY5KE+FcQfvWsQixVRRv238jMFx590frf9tXxnGN81kO9tCd
 Dttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780925164; x=1781529964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zQpEFonZfDNVpg2dDfZVJgo+PGGA++DsD8OZa0Pwhuw=;
 b=MjeuYC1jP0HZozly9rl/o5h1aNh5qDZ/rk/Ec8RpjAKVwjvyITbDRpQil1TtWjBUzf
 DSHgEE+EYK5BU3hlUSEPz6XPUoKlPtXR1rLOTh0Ohu8TeZxHO7+HHOc3WsdePZION4GS
 P0gaqXoEtoSPVPoqgZaxmudnZGIe2kzH24arMooTDK74qQ2DlEdDh/GK4r/VZeY/ocGQ
 Cq6qog+wYozj9bpsFWsJMosTP6wHcrglOPxfoevXK2qrE3KRmD/GfPyj4U/RnWdFQuaz
 1h/oPtsPobKxa1+AyAjEWOO1rsrjBcFarZ9z64IPPw+yfoKjh1Owbm43N9OYSGyLQTW6
 QxrQ==
X-Gm-Message-State: AOJu0YzzDuXpFiWOzfuXBZJ6nokxh79kRnBdXJ4FrXxCdlr/5LFaHEq2
 VtTb8Jf8K8MOO4Bvr7sg39hq21/y3krLa98ybAvxIB90XwsDBrimf6yy5LZd2Cg=
X-Gm-Gg: Acq92OHiy+gozWLHVk3Z/JhgmpruBZBpF9Ff80jmH5L8Wf0W6cfN1LbQa6+YGndP9c3
 fnM63MlQc9W02oit6rk3CJ85+ep3DXrYhUMb91w/H4mSb3800zBIRg/f6TJLuDSvFk5w9KSIw7E
 zhoFnDwcK/OgPoFFAAwEPt+ifM30PaKPmUGyNCNHM9boP94D/UQSo5o/JHN2QJc+HXhZXVn1Q+G
 EZp9p49u2pI+q+3+UqKtKz7fKCeVeZMkzByXZt4TGFV9m9NdNMwwZux6cng1C3KbPbeyA9awqe1
 8HfTT4rD1x3u6k9GWzn73l/mVfHxh3c9iCldDtOCpThy2fbcRSpYzOl+2n95iP7PgtOmOUxPYw9
 3LfZKB8uGIqcmUg/BYfeDKx9Dk3eAHqdMtcl6UnPw0/v27Y7jQCzrtkZf87bveQrkDtpxIYxua+
 FuJzGagkgl6lNY+O3HaAol33ju2dJ/gNW42m7wvTS0+T+nrg==
X-Received: by 2002:a17:90a:d606:b0:36b:5b82:4834 with SMTP id
 98e67ed59e1d1-370ee547414mr16054980a91.7.1780925163981; 
 Mon, 08 Jun 2026 06:26:03 -0700 (PDT)
Received: from localhost ([61.119.121.206]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f68b03ef6sm16385026a91.0.2026.06.08.06.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 06:26:03 -0700 (PDT)
From: Linhu Li <lilinhu618@gmail.com>
To: dev@dpdk.org
Cc: stable@dpdk.org,
	dsosnowski@nvidia.com,
	Linhu Li <lilinhu618@gmail.com>
Subject: [PATCH v2] net/mlx5: fix counter TAILQ race between free and query
 callback
Date: Mon,  8 Jun 2026 21:25:55 +0800
Message-Id: <20260608132555.31439-1-lilinhu618@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260604101112.72177-1-lilinhu618@gmail.com>
References: <20260604101112.72177-1-lilinhu618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 09 Jun 2026 09:02:31 +0200
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

Signed-off-by: Linhu Li <lilinhu618@gmail.com>
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

