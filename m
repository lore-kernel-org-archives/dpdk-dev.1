Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06F6C54F30
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 May 2025 15:39:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04BA540697;
	Sat, 24 May 2025 17:39:53 +0200 (CEST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45]) by mails.dpdk.org (Postfix) with ESMTP id CD78F40263
 for <dev@dpdk.org>; Sat, 24 May 2025 17:39:51 +0200 (CEST)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-ad51ba0af48so347874666b.0
 for <dev@dpdk.org>; Sat, 24 May 2025 08:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1748101191;
 x=1748705991; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c4WSyXXKKvSQVDQ2cXmsmf9mLw71dz1IqE39D7lXAlU=;
 b=kncWYAzeEdnl3lpB78W4Tetz4MrKuINWvJ5Ef7Az8L3qeq2OU2HC6dDfVMyHDZJnQN
 TRvkUGP7YOwtqDZV9OSTcX0ZzpAUpgzTbQ9HHOsne3WnEhT0Gd/wNuHaN/BYYiEmDPy8
 T8MqAXmf0l7VYGnM09YRMRjvuvPFoYMzUo1BADLAn2/F7sWWjCWbr60DGkGG+T3HuOdP
 Ithxf+JHmrbpJkLYUZIYW1K/PSDw/wLbD6uHyXYNZo4bp+Kgil0GP8mfy5vBCMhc/VTP
 ttDxysfyJlk99qyc2gWiHX7ONsI0Ta9YRJerOZychYv3lXk55d3dx8CLmGqvfE3haS1p
 ZETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748101191; x=1748705991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c4WSyXXKKvSQVDQ2cXmsmf9mLw71dz1IqE39D7lXAlU=;
 b=M2oyMdbNVllgLWfBN08C5UWo//JFqx3txYLRqGXdGdLZ4kGXklApQ2MPi5eT8rDPo/
 eMxpHOLGm29Ctl+2HXBbCMrZz4zR3CtulQHu6wo6uzqPh7vVie9pdL9FXGeO5ZV2ys7D
 djgs05zBOVi9CV5NCvBs2AiTahEtWHDCl9UvSkIxJKOkxZvhfogx0mdpHVQi2R+lylrk
 aLmxmHUDKkNlB1zAXOFEJgXv/oXDQ26GhN9HaAZVgsMq84Z8K/291uoArg9lXvt35lpY
 xDTvVXvAkRxTqSRF+jJXcJCWucDtagIbU6OHTuD/1txbFjK0nf2JedylY3JTcDUGri5T
 PLOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuzTGHpprxo/bc8k6y6kK92vb/H4zcIcy8XBXu8/SYLTlwZKipYJPYkEDUS7VLYL/DKUk=@dpdk.org
X-Gm-Message-State: AOJu0Yzu03VHrFYsaAY/UQ4Z6sVaiHbxb3vTstXE5mJB1wYVXUse7HHi
 YyCdAPVoLEVdguj7TZbGft8F6XRS3D0hZUcsDqe8do3APk67cvM38452ZZehvEoK+LM=
X-Gm-Gg: ASbGncsTANG/IbmxypOgujCEmSwO+LLwmF6moNShHcVtZJxxPXbiQ5uzsiNJOWDOKv+
 msy1cV+qxI4Zckkd4HnO9H8gCn3/28S/Z3za/+AIc3gF45guqEHFM44jLqd52rgfPqMOJ3G9fF5
 IYGpL8xhZqXuHxcftuKyYki67LrF6zt03RGfj+G/IiyovdcBkEZjRRN75B/m1Y3QIolZAVUY6xV
 Wp9AKRu49AbI1bPecoCnIlpYtR/b2veoLvXRF00dtwt2ZIfD6uTZ0XdrtuTHbGcfXKEPaZoDyM6
 DVKLc9UCY3YVBKYPuOFYHxx0UJt40HV+8oRObpftA1l2vVBYMQf4aUqNqykj1Y1essnMLkgj2Au
 VDrRgdJ8+1zBFYvzBtS1iM9n2EltG
X-Google-Smtp-Source: AGHT+IG0eGsrHfZbwK9v9kHF5WiexZZGRHNdKjnKuDYtDq9Nk85epkBk5ITreFjbN5mlOXh1IhJ/+A==
X-Received: by 2002:a17:907:9303:b0:ad8:5850:7332 with SMTP id
 a640c23a62f3a-ad859840183mr268625366b.9.1748101191162; 
 Sat, 24 May 2025 08:39:51 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d04f263sm1395378666b.1.2025.05.24.08.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 08:39:50 -0700 (PDT)
Date: Sat, 24 May 2025 08:39:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rakesh Kudurumalla <rkudurumalla@marvell.com>
Cc: <ferruh.yigit@amd.com>, <andrew.rybchenko@oktetlabs.ru>,
 <orika@nvidia.com>, <thomas@monjalon.net>, <dev@dpdk.org>,
 <jerinj@marvell.com>, <ndabilpuram@marvell.com>, <stable@dpdk.org>
Subject: Re: [PATCH v5 1/1] examples/l2fwd-jobstats: fix lock availability
Message-ID: <20250524083943.08660ec0@hermes.local>
In-Reply-To: <20240811155957.576645-1-rkudurumalla@marvell.com>
References: <20240811065819.575759-1-rkudurumalla@marvell.com>
 <20240811155957.576645-1-rkudurumalla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sun, 11 Aug 2024 21:29:57 +0530
Rakesh Kudurumalla <rkudurumalla@marvell.com> wrote:

> Race condition between jobstats and time metrics
> for forwarding and flushing is maintained using spinlock.
> Timer metrics are not displayed properly due to the
> frequent unavailability of the lock.This patch fixes
> the issue by introducing a delay before acquiring
> the lock in the loop. This delay allows for betteravailability
> of the lock, ensuring that show_lcore_stats() can
> periodically update the statistics even when forwarding
> jobs are running.
> 
> Fixes: 204896f8d66c ("examples/l2fwd-jobstats: add new example")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>

The original code is a mess here.
The whole idle job loop here is the problem.
It should use rte_timer_next_ticks() to know when next timer is
about to expire and use that.

And instead of fighting with spin lock, use ticket lock which will
cause in-order waiting.

Something like the following (untested):

diff --git a/examples/l2fwd-jobstats/main.c b/examples/l2fwd-jobstats/main.c
index 308b8edd20..9586d90ab6 100644
--- a/examples/l2fwd-jobstats/main.c
+++ b/examples/l2fwd-jobstats/main.c
@@ -27,7 +27,7 @@
 #include <rte_ethdev.h>
 #include <rte_mempool.h>
 #include <rte_mbuf.h>
-#include <rte_spinlock.h>
+#include <rte_ticketlock.h>
 
 #include <rte_errno.h>
 #include <rte_jobstats.h>
@@ -80,8 +80,7 @@ struct __rte_cache_aligned lcore_queue_conf {
 	struct rte_jobstats idle_job;
 	struct rte_jobstats_context jobs_context;
 
-	RTE_ATOMIC(uint16_t) stats_read_pending;
-	rte_spinlock_t lock;
+	rte_ticketlock_t lock;
 };
 /* >8 End of list of queues to be polled for given lcore. */
 struct lcore_queue_conf lcore_queue_conf[RTE_MAX_LCORE];
@@ -151,9 +150,7 @@ show_lcore_stats(unsigned lcore_id)
 	uint64_t collection_time = rte_get_timer_cycles();
 
 	/* Ask forwarding thread to give us stats. */
-	rte_atomic_store_explicit(&qconf->stats_read_pending, 1, rte_memory_order_relaxed);
-	rte_spinlock_lock(&qconf->lock);
-	rte_atomic_store_explicit(&qconf->stats_read_pending, 0, rte_memory_order_relaxed);
+	rte_ticketlock_lock(&qconf->lock);
 
 	/* Collect context statistics. */
 	stats_period = ctx->state_time - ctx->start_time;
@@ -195,7 +192,7 @@ show_lcore_stats(unsigned lcore_id)
 	idle_exec_max = qconf->idle_job.max_exec_time;
 	rte_jobstats_reset(&qconf->idle_job);
 
-	rte_spinlock_unlock(&qconf->lock);
+	rte_ticketlock_unlock(&qconf->lock);
 
 	exec -= idle_exec;
 	busy = exec + management;
@@ -478,11 +475,11 @@ l2fwd_main_loop(void)
 	unsigned lcore_id;
 	unsigned i, portid;
 	struct lcore_queue_conf *qconf;
-	uint8_t stats_read_pending = 0;
-	uint8_t need_manage;
+	uint64_t hz;
 
 	lcore_id = rte_lcore_id();
 	qconf = &lcore_queue_conf[lcore_id];
+	hz = rte_get_timer_hz();
 
 	if (qconf->n_rx_port == 0) {
 		RTE_LOG(INFO, L2FWD, "lcore %u has nothing to do\n", lcore_id);
@@ -502,47 +499,22 @@ l2fwd_main_loop(void)
 
 	/* Minimize impact of stats reading. 8< */
 	for (;;) {
-		rte_spinlock_lock(&qconf->lock);
-
-		do {
-			rte_jobstats_context_start(&qconf->jobs_context);
-
-			/* Do the Idle job:
-			 * - Read stats_read_pending flag
-			 * - check if some real job need to be executed
-			 */
-			rte_jobstats_start(&qconf->jobs_context, &qconf->idle_job);
-
-			uint64_t repeats = 0;
-
-			do {
-				uint8_t i;
-				uint64_t now = rte_get_timer_cycles();
-
-				repeats++;
-				need_manage = qconf->flush_timer.expire < now;
-				/* Check if we was esked to give a stats. */
-				stats_read_pending = rte_atomic_load_explicit(
-					&qconf->stats_read_pending,
-					rte_memory_order_relaxed);
-				need_manage |= stats_read_pending;
 
-				for (i = 0; i < qconf->n_rx_port && !need_manage; i++)
-					need_manage = qconf->rx_timers[i].expire < now;
+		rte_ticketlock_lock(&qconf->lock);
 
-			} while (!need_manage);
+		rte_jobstats_context_start(&qconf->jobs_context);
+		rte_jobstats_start(&qconf->jobs_context, &qconf->idle_job);
+		rte_timer_manage();
+		rte_jobstats_context_finish(&qconf->jobs_context);
 
-			if (likely(repeats != 1))
-				rte_jobstats_finish(&qconf->idle_job, qconf->idle_job.target);
-			else
-				rte_jobstats_abort(&qconf->idle_job);
+		int64_t next_ticks = rte_timer_next_ticks();
 
-			rte_timer_manage();
-			rte_jobstats_context_finish(&qconf->jobs_context);
-		} while (likely(stats_read_pending == 0));
+		rte_ticketlock_unlock(&qconf->lock);
 
-		rte_spinlock_unlock(&qconf->lock);
-		rte_pause();
+		if (next_ticks > 0)
+			rte_delay_us((1000000 * next_ticks) / hz);
+		else
+			rte_pause();
 	}
 	/* >8 End of minimize impact of stats reading. */
 }
@@ -972,7 +944,7 @@ main(int argc, char **argv)
 	RTE_LCORE_FOREACH(lcore_id) {
 		qconf = &lcore_queue_conf[lcore_id];
 
-		rte_spinlock_init(&qconf->lock);
+		rte_ticketlock_init(&qconf->lock);
 
 		if (rte_jobstats_context_init(&qconf->jobs_context) != 0)
 			rte_panic("Jobs stats context for core %u init failed\n", lcore_id);

