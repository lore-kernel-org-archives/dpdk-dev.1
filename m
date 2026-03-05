Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36888F47CA4
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 17:54:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7594E4279D;
	Thu,  5 Mar 2026 18:53:40 +0100 (CET)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48]) by mails.dpdk.org (Postfix) with ESMTP id 0C21341611
 for <dev@dpdk.org>; Thu,  5 Mar 2026 18:53:38 +0100 (CET)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-89a1347051aso49627456d6.2
 for <dev@dpdk.org>; Thu, 05 Mar 2026 09:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772733217;
 x=1773338017; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B6pkQwBwY/iHqZicCe5r0fEWGeSlRRmNN033pnA7arQ=;
 b=dpw8CwMWwdwSbnbIZb8GiV0f1nqGWowiCKUtWWv/YLSmYVXkr3Hx0Ej5eJP8MeuCyG
 pYy49+CwkR4/o5hf3SZDPi2rF62NUKm0i4CZIOzAbUUpKllkL1nDUTbQ/jqdpcQ2BUXT
 Q7H2y2omDmepNZqFlDY4OwTHrw62PfHW9AHmua0OQfogb1nAfL1Gje7wpB5KMrbsm5Uk
 ojykw5+/LWG5bKQd9qsmK/MmiG7OgNxGBb4p6imy0ZosEJB6TWZJIcC5hBDpQqDisdC8
 TXzXtRMwwb67NxCCHkeuzxhOFG6KmmcPQ8wN9CzBn1S/YAFa38aG4zfHd2GnC/oAXMcx
 TCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772733217; x=1773338017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B6pkQwBwY/iHqZicCe5r0fEWGeSlRRmNN033pnA7arQ=;
 b=KgUXVXGnNomV17cfjELjRIMHiYgBY8BEjMz/CNLSORN0PfPd5F8BycJzk/1RUBlyLG
 MefbA6qrEFuiaOMvID59D+0r1LjdzEvlWwFDSGp0T+iMLx74PtJJ/MiBFONcpfwKDdRt
 lU2/86rYFeO0HE2oA5WAzQveg1DYDnaxfFx/QlO7Gs9E+OF+wKuAqpCmMLzzNM57SEKd
 Z5TbfqwzC20K9REdY4i4pURefH2U0SxS+KoxoePRPnGh9Os0hxFTZECbhVx/IdmFcK+v
 /f1TSW1hoZH6Q1SuXjQYV+dv50yRqx3l5nJnveSwsPmysQxkMCsROQq4Zw03ae7s1M0m
 +BpA==
X-Gm-Message-State: AOJu0YyNf+oujtRdQhUdpUORQhrILk69kpFuWjUWPKgjkr9VVRuahGuy
 BNZoAVoAtB2B5ghZq4KRBxMUJIkqdj3NZjXVhQazatKhmyliyOMtiOGZELqhp6zpBTeA4KvNhjR
 FquG6
X-Gm-Gg: ATEYQzx3u5/uqg/Z/h42QUgcsym95cqEbNbo9jnYFd/zu4/DzBFqEry6EDtcxtBbl0Y
 bdPTpIKIh8otoIdWaM7g9nkzV25IRzf59XmtvNs1ubuWN/eVNS5JBf9XhY8cZfxl/WjcGYxzD3T
 TK2ewuXpPTdZ7vynrA8nLDq59YDUIvVxongg29SquMMpQIuKYWa57OiRUU46n+vJ0rEiFdb/PCh
 yb5u5uSW+2AmP5tGDWapC648x/oG1zoh0nrQXxAmoMD3lxZnNOWU62TRWJfuUEN8/B4+iTP8IOy
 DJgy8aGh/e7Gpl0k17Dy4LR0kZxV2EuQK6oAD+LutgGOTKxsxJ0ggPjLvQzIcFiXseZKbF1m5D3
 NJQ/Om4E065hhCz7kwuGfyqmkcujP7iOzkuQteTaiRU11CcVOEqcqy7EroN9Q7XcYBTa2vjoYQ0
 QUZxIzZAxA8PfXWShzoXvJKJ35cxgD87VjOKF6dAHHBPQQ26pzah4b69HYcHJ8/w==
X-Received: by 2002:a05:6214:1d0b:b0:893:348e:4126 with SMTP id
 6a1803df08f44-89a19e65ddamr98296516d6.61.1772733217349; 
 Thu, 05 Mar 2026 09:53:37 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a05b72186sm80667766d6.50.2026.03.05.09.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 09:53:36 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v4 06/11] test/timer: replace volatile with C11 atomics
Date: Thu,  5 Mar 2026 09:51:00 -0800
Message-ID: <20260305175326.279891-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305175326.279891-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260305175326.279891-1-stephen@networkplumber.org>
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

Replace volatile variables in test_timer_secondary shared memory
structure with RTE_ATOMIC() and rte_atomic_*_explicit() operations.

Change expected_count and expired_count from int to unsigned int
since they are non-negative counters.

Fixes: 50247fe03fe0 ("test/timer: exercise new APIs in secondary process")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_timer_secondary.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/app/test/test_timer_secondary.c b/app/test/test_timer_secondary.c
index c80dee9c6c..57ab39130d 100644
--- a/app/test/test_timer_secondary.c
+++ b/app/test/test_timer_secondary.c
@@ -12,7 +12,9 @@
 #include <rte_timer.h>
 #include <rte_cycles.h>
 #include <rte_mempool.h>
+#include <rte_pause.h>
 #include <rte_random.h>
+#include <rte_stdatomic.h>
 
 #include "test.h"
 
@@ -41,12 +43,12 @@ struct test_info {
 	unsigned int sec_lcore;
 	unsigned int num_timers;
 	uint32_t timer_data_id;
-	volatile int expected_count;
-	volatile int expired_count;
+	RTE_ATOMIC(unsigned int) expected_count;
+	RTE_ATOMIC(unsigned int) expired_count;
 	struct rte_mempool *tim_mempool;
 	struct rte_timer *expired_timers[NUM_TIMERS_MAX];
 	int expired_timers_idx;
-	volatile int exit_flag;
+	RTE_ATOMIC(int) exit_flag;
 };
 
 static int
@@ -76,7 +78,8 @@ handle_expired_timer(struct rte_timer *tim)
 {
 	struct test_info *test_info = tim->arg;
 
-	test_info->expired_count++;
+	rte_atomic_fetch_add_explicit(&test_info->expired_count, 1,
+				      rte_memory_order_relaxed);
 	test_info->expired_timers[test_info->expired_timers_idx++] = tim;
 }
 
@@ -88,7 +91,8 @@ timer_manage_loop(void *arg)
 	uint64_t prev_tsc = 0, cur_tsc, diff_tsc;
 	struct test_info *test_info = arg;
 
-	while (!test_info->exit_flag) {
+	while (!rte_atomic_load_explicit(&test_info->exit_flag,
+				       rte_memory_order_acquire)) {
 		cur_tsc = rte_rdtsc();
 		diff_tsc = cur_tsc - prev_tsc;
 
@@ -163,7 +167,8 @@ test_timer_secondary(void)
 		/* must set exit flag even on error case, so check ret later */
 
 		rte_delay_ms(500);
-		test_info->exit_flag = 1;
+		rte_atomic_store_explicit(&test_info->exit_flag, 1,
+					  rte_memory_order_release);
 
 		TEST_ASSERT_SUCCESS(ret, "Secondary process execution failed");
 		rte_eal_wait_lcore(*mgr_lcorep);
@@ -172,7 +177,10 @@ test_timer_secondary(void)
 		rte_timer_alt_dump_stats(test_info->timer_data_id, stdout);
 #endif
 
-		return test_info->expected_count == test_info->expired_count ?
+		return rte_atomic_load_explicit(&test_info->expected_count,
+					       rte_memory_order_relaxed) ==
+		       rte_atomic_load_explicit(&test_info->expired_count,
+					       rte_memory_order_relaxed) ?
 			TEST_SUCCESS : TEST_FAILED;
 
 	} else if (proc_type == RTE_PROC_SECONDARY) {
@@ -202,7 +210,8 @@ test_timer_secondary(void)
 			if (ret < 0)
 				return TEST_FAILED;
 
-			test_info->expected_count++;
+			rte_atomic_fetch_add_explicit(&test_info->expected_count,
+						     1, rte_memory_order_relaxed);
 
 			/* randomly leave timer running or stop it */
 			if (rte_rand() & 1)
@@ -211,7 +220,8 @@ test_timer_secondary(void)
 			ret = rte_timer_alt_stop(test_info->timer_data_id,
 						 tim);
 			if (ret == 0) {
-				test_info->expected_count--;
+				rte_atomic_fetch_sub_explicit(&test_info->expected_count,
+							     1, rte_memory_order_relaxed);
 				rte_mempool_put(test_info->tim_mempool,
 						(void *)tim);
 			}
-- 
2.51.0

