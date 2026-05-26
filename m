Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ACACD5BDE
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 23:27:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2466340BA3;
	Wed, 27 May 2026 01:26:16 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id 5D89A40A89
 for <dev@dpdk.org>; Wed, 27 May 2026 01:26:09 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2ef2a1cc06dso3667416eec.0
 for <dev@dpdk.org>; Tue, 26 May 2026 16:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779837968;
 x=1780442768; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PznqqSezaXC7pgR8pla3KxOXEuwwYv6++wFFs21oqTU=;
 b=CiEuI7IlmwJ9hC2tF6ZDaQRCL1cMNXwDnpWWRB5T2Hs4dq8IctRf7jWVhVcndCpZ7u
 T+cWFvAOG34nmPLpxDs0/b3AJSYcb5X/8DiGvZ+KJGQPvsJM0MhvKdUaDmBSWUfBe3pm
 Wt4K8JUE1dvM5ckV4WIRZYusySpiXDQ+b2MUbQISQnfrMCzIQk1J12zd1NWCCQkpRbwN
 WtfJRvdZnEGaiEu5DzOV7rt7qfE/oYEdsZVXh11jxYyMSb9cA/FMv+nC1JcCpKFsHv5c
 0Lsd3pg/KFT4/pGDmMR2FGEU/Ac2CaY1kZiL6o8umT4xBMNS1fRibH9Ms+YNXVnMkNFT
 IMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779837968; x=1780442768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PznqqSezaXC7pgR8pla3KxOXEuwwYv6++wFFs21oqTU=;
 b=j3KpC9umA9NXioJ4TIFAdx6rSQk3Pv7XdA5Lm0UVTiZAapcQp4QJjGPjgCpSmiCJ6g
 nIbdxPKRu8InNqc3LqNkm7yrjyDyJBHe048C16iNOH8di8lds5Jc3C7G0wynb2jR3iBk
 yV4dd6iyJd4L44PtInSqywhHraNhUKjptQcne9CztCnNvt8W3sBlWSOH9J4zh4Ka0xdG
 yrUbl3T4ox3hSfmhwN7EGvHNKIzENNH37GKE7AQTmQQ93uegVnosXhQrZfLCVhPD18Eb
 +F9+1Z0yIIvGGxhHA5Z3J6zB/Dw9DfoWL2qcnww+lAlSa5LB8KRqknpHEsBxrXorAFJa
 KgWw==
X-Gm-Message-State: AOJu0Yy7790uX24lApCkrvoOCepW+yHnRC8fUpaldgcZy9JWIr7Z4DIJ
 0ej3lfTn4MUZUMbloK4aAykgYCYXGTMI9aQ8M3B9Bk1U+yhFMFfW/smx9CLAzFrFVIaZE/7Q19w
 ei8Jd
X-Gm-Gg: Acq92OGzV17WeLiEP3CeQldAdkZd3RGVcQr1uI5Osoi7m4C2sEOjdj2Db25H/I8TNxE
 PUm8jYrSiACEe6ApekDABRO/ktqcqsUVTrRzByRYsL3pgz1d7PvjzMhnkQRQS3LsN2oVG8GLuqD
 YAgSpuMGDbT6D7cP+GslAnaokU6bk/nlpAUkoJNDgEVSXDre2VW90OwCKuzW/vnXTBLdWzMdPsc
 qfCj1NLGeFhjmf45dnbbEocZbognIpe0TT0bXP9EkliT4fbYzKerbKjEtMwlLmd+QYKTFTutEGr
 IaCg1CcrZgDBSlVZ7p2gvu4IXuKnasngYGAEqktawZpIyN+NADmG0RdVEA9pOTXK9fo9ItpkpTD
 lSJ+2quAI1E283ZsAGM9s0DuA5XnQnWlDwoSbm1A4iXiDIr+p3S89LB80unzvlA1UTgrTDUOPvT
 r0gjQV0W5Ix4eWBpH35AlHhTX8l5kBHJnEVR5jwzSq24POokQI2mGddey25qhgyg==
X-Received: by 2002:a05:7300:6417:b0:2ed:7e1:975 with SMTP id
 5a478bee46e88-3044903799bmr10243236eec.1.1779837968332; 
 Tue, 26 May 2026 16:26:08 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230f1bsm11296132eec.14.2026.05.26.16.26.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 16:26:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v4 21/27] drivers/event: replace rte_atomic32 in selftests
Date: Tue, 26 May 2026 16:24:11 -0700
Message-ID: <20260526232542.620966-22-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526232542.620966-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
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

Last callers in these selftests of the rte_atomicNN_*() family,
which is being deprecated.

Convert total_events from rte_atomic32_t to RTE_ATOMIC(uint32_t)
for the stack-local instance and __rte_atomic uint32_t * for the
pointer in test_core_param. Switch reads and updates to
rte_atomic_*_explicit().

Reads in the busy-loop checks and progress logs use relaxed: the
counter is purely a "drained yet?" signal and no data is published
through it. The fetch_sub on the dequeue path uses release in
octeontx (preserving the publish-after-mbuf-free ordering already
implied by the seq_cst sub it replaces) and relaxed in dpaa2.

The stack-local atomic_total_events is initialized by direct
assignment instead of rte_atomic32_set(), since it is written
before any worker is launched.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/event/dpaa2/dpaa2_eventdev_selftest.c | 26 ++++----
 drivers/event/octeontx/ssovf_evdev_selftest.c | 61 ++++++++++---------
 2 files changed, 47 insertions(+), 40 deletions(-)

diff --git a/drivers/event/dpaa2/dpaa2_eventdev_selftest.c b/drivers/event/dpaa2/dpaa2_eventdev_selftest.c
index 9d4938efe6..2c688bd194 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev_selftest.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev_selftest.c
@@ -2,7 +2,7 @@
  * Copyright 2018-2019 NXP
  */
 
-#include <rte_atomic.h>
+#include <rte_stdatomic.h>
 #include <rte_common.h>
 #include <rte_cycles.h>
 #include <rte_debug.h>
@@ -49,7 +49,7 @@ struct event_attr {
 };
 
 struct test_core_param {
-	rte_atomic32_t *total_events;
+	__rte_atomic uint32_t *total_events;
 	uint64_t dequeue_tmo_ticks;
 	uint8_t port;
 	uint8_t sched_type;
@@ -444,10 +444,10 @@ worker_multi_port_fn(void *arg)
 	struct rte_event ev;
 	uint16_t valid_event;
 	uint8_t port = param->port;
-	rte_atomic32_t *total_events = param->total_events;
+	__rte_atomic uint32_t *total_events = param->total_events;
 	int ret;
 
-	while (rte_atomic32_read(total_events) > 0) {
+	while (rte_atomic_load_explicit(total_events, rte_memory_order_relaxed) > 0) {
 		valid_event = rte_event_dequeue_burst(evdev, port, &ev, 1, 0);
 		if (!valid_event)
 			continue;
@@ -455,13 +455,15 @@ worker_multi_port_fn(void *arg)
 		ret = validate_event(&ev);
 		RTE_TEST_ASSERT_SUCCESS(ret, "Failed to validate event");
 		rte_pktmbuf_free(ev.mbuf);
-		rte_atomic32_sub(total_events, 1);
+
+		rte_atomic_fetch_sub_explicit(total_events, 1,
+					      rte_memory_order_relaxed);
 	}
 	return 0;
 }
 
 static int
-wait_workers_to_join(int lcore, const rte_atomic32_t *count)
+wait_workers_to_join(int lcore, const __rte_atomic uint32_t *count)
 {
 	uint64_t cycles, print_cycles;
 
@@ -472,15 +474,15 @@ wait_workers_to_join(int lcore, const rte_atomic32_t *count)
 		uint64_t new_cycles = rte_get_timer_cycles();
 
 		if (new_cycles - print_cycles > rte_get_timer_hz()) {
-			dpaa2_evdev_dbg("\r%s: events %d", __func__,
-				rte_atomic32_read(count));
+			dpaa2_evdev_dbg("\r%s: events %u", __func__,
+					rte_atomic_load_explicit(count, rte_memory_order_relaxed));
 			print_cycles = new_cycles;
 		}
 		if (new_cycles - cycles > rte_get_timer_hz() * 10) {
 			dpaa2_evdev_info(
-				"%s: No schedules for seconds, deadlock (%d)",
+				"%s: No schedules for seconds, deadlock (%u)",
 				__func__,
-				rte_atomic32_read(count));
+				rte_atomic_load_explicit(count, rte_memory_order_relaxed));
 			rte_event_dev_dump(evdev, stdout);
 			cycles = new_cycles;
 			return -1;
@@ -500,13 +502,13 @@ launch_workers_and_wait(int (*main_worker)(void *),
 	int w_lcore;
 	int ret;
 	struct test_core_param *param;
-	rte_atomic32_t atomic_total_events;
+	RTE_ATOMIC(uint32_t) atomic_total_events;
 	uint64_t dequeue_tmo_ticks;
 
 	if (!nb_workers)
 		return 0;
 
-	rte_atomic32_set(&atomic_total_events, total_events);
+	atomic_total_events = total_events;
 	RTE_BUILD_BUG_ON(NUM_PACKETS < MAX_EVENTS);
 
 	param = malloc(sizeof(struct test_core_param) * nb_workers);
diff --git a/drivers/event/octeontx/ssovf_evdev_selftest.c b/drivers/event/octeontx/ssovf_evdev_selftest.c
index b54ae126d2..5eeed2b2ce 100644
--- a/drivers/event/octeontx/ssovf_evdev_selftest.c
+++ b/drivers/event/octeontx/ssovf_evdev_selftest.c
@@ -4,7 +4,7 @@
 
 #include <stdlib.h>
 
-#include <rte_atomic.h>
+#include <rte_stdatomic.h>
 #include <rte_common.h>
 #include <rte_cycles.h>
 #include <rte_debug.h>
@@ -84,7 +84,7 @@ seqn_list_check(int limit)
 }
 
 struct test_core_param {
-	rte_atomic32_t *total_events;
+	__rte_atomic uint32_t *total_events;
 	uint64_t dequeue_tmo_ticks;
 	uint8_t port;
 	uint8_t sched_type;
@@ -558,10 +558,10 @@ worker_multi_port_fn(void *arg)
 	struct rte_event ev;
 	uint16_t valid_event;
 	uint8_t port = param->port;
-	rte_atomic32_t *total_events = param->total_events;
+	__rte_atomic uint32_t *total_events = param->total_events;
 	int ret;
 
-	while (rte_atomic32_read(total_events) > 0) {
+	while (rte_atomic_load_explicit(total_events, rte_memory_order_relaxed) > 0) {
 		valid_event = rte_event_dequeue_burst(evdev, port, &ev, 1, 0);
 		if (!valid_event)
 			continue;
@@ -569,13 +569,14 @@ worker_multi_port_fn(void *arg)
 		ret = validate_event(&ev);
 		RTE_TEST_ASSERT_SUCCESS(ret, "Failed to validate event");
 		rte_pktmbuf_free(ev.mbuf);
-		rte_atomic32_sub(total_events, 1);
+
+		rte_atomic_fetch_sub_explicit(total_events, 1, rte_memory_order_release);
 	}
 	return 0;
 }
 
 static inline int
-wait_workers_to_join(int lcore, const rte_atomic32_t *count)
+wait_workers_to_join(int lcore, const __rte_atomic uint32_t *count)
 {
 	uint64_t cycles, print_cycles;
 	RTE_SET_USED(count);
@@ -583,17 +584,16 @@ wait_workers_to_join(int lcore, const rte_atomic32_t *count)
 	print_cycles = cycles = rte_get_timer_cycles();
 	while (rte_eal_get_lcore_state(lcore) != WAIT) {
 		uint64_t new_cycles = rte_get_timer_cycles();
+		uint32_t cur_count = rte_atomic_load_explicit(count, rte_memory_order_relaxed);
 
 		if (new_cycles - print_cycles > rte_get_timer_hz()) {
-			ssovf_log_dbg("\r%s: events %d", __func__,
-				rte_atomic32_read(count));
+			ssovf_log_dbg("\r%s: events %u", __func__, cur_count);
 			print_cycles = new_cycles;
 		}
 		if (new_cycles - cycles > rte_get_timer_hz() * 10) {
 			ssovf_log_dbg(
-				"%s: No schedules for seconds, deadlock (%d)",
-				__func__,
-				rte_atomic32_read(count));
+				"%s: No schedules for seconds, deadlock (%u)",
+				__func__, cur_count);
 			rte_event_dev_dump(evdev, stdout);
 			cycles = new_cycles;
 			return -1;
@@ -613,13 +613,13 @@ launch_workers_and_wait(int (*main_worker)(void *),
 	int w_lcore;
 	int ret;
 	struct test_core_param *param;
-	rte_atomic32_t atomic_total_events;
+	RTE_ATOMIC(uint32_t) atomic_total_events;
 	uint64_t dequeue_tmo_ticks;
 
 	if (!nb_workers)
 		return 0;
 
-	rte_atomic32_set(&atomic_total_events, total_events);
+	atomic_total_events = total_events;
 	seqn_list_init();
 
 	param = malloc(sizeof(struct test_core_param) * nb_workers);
@@ -889,10 +889,10 @@ worker_flow_based_pipeline(void *arg)
 	uint16_t valid_event;
 	uint8_t port = param->port;
 	uint8_t new_sched_type = param->sched_type;
-	rte_atomic32_t *total_events = param->total_events;
+	__rte_atomic uint32_t *total_events = param->total_events;
 	uint64_t dequeue_tmo_ticks = param->dequeue_tmo_ticks;
 
-	while (rte_atomic32_read(total_events) > 0) {
+	while (rte_atomic_load_explicit(total_events, rte_memory_order_relaxed) > 0) {
 		valid_event = rte_event_dequeue_burst(evdev, port, &ev, 1,
 					dequeue_tmo_ticks);
 		if (!valid_event)
@@ -910,7 +910,8 @@ worker_flow_based_pipeline(void *arg)
 		} else if (ev.sub_event_type == 1) { /* Events from stage 1*/
 			if (seqn_list_update(*rte_event_pmd_selftest_seqn(ev.mbuf)) == 0) {
 				rte_pktmbuf_free(ev.mbuf);
-				rte_atomic32_sub(total_events, 1);
+				rte_atomic_fetch_sub_explicit(total_events, 1,
+							      rte_memory_order_release);
 			} else {
 				ssovf_log_dbg("Failed to update seqn_list");
 				return -1;
@@ -1044,10 +1045,10 @@ worker_group_based_pipeline(void *arg)
 	uint16_t valid_event;
 	uint8_t port = param->port;
 	uint8_t new_sched_type = param->sched_type;
-	rte_atomic32_t *total_events = param->total_events;
+	__rte_atomic uint32_t *total_events = param->total_events;
 	uint64_t dequeue_tmo_ticks = param->dequeue_tmo_ticks;
 
-	while (rte_atomic32_read(total_events) > 0) {
+	while (rte_atomic_load_explicit(total_events, rte_memory_order_relaxed) > 0) {
 		valid_event = rte_event_dequeue_burst(evdev, port, &ev, 1,
 					dequeue_tmo_ticks);
 		if (!valid_event)
@@ -1065,7 +1066,8 @@ worker_group_based_pipeline(void *arg)
 		} else if (ev.queue_id == 1) { /* Events from stage 1(group 1)*/
 			if (seqn_list_update(*rte_event_pmd_selftest_seqn(ev.mbuf)) == 0) {
 				rte_pktmbuf_free(ev.mbuf);
-				rte_atomic32_sub(total_events, 1);
+				rte_atomic_fetch_sub_explicit(total_events, 1,
+							      rte_memory_order_release);
 			} else {
 				ssovf_log_dbg("Failed to update seqn_list");
 				return -1;
@@ -1203,16 +1205,17 @@ worker_flow_based_pipeline_max_stages_rand_sched_type(void *arg)
 	struct rte_event ev;
 	uint16_t valid_event;
 	uint8_t port = param->port;
-	rte_atomic32_t *total_events = param->total_events;
+	__rte_atomic uint32_t *total_events = param->total_events;
 
-	while (rte_atomic32_read(total_events) > 0) {
+	while (rte_atomic_load_explicit(total_events, rte_memory_order_relaxed) > 0) {
 		valid_event = rte_event_dequeue_burst(evdev, port, &ev, 1, 0);
 		if (!valid_event)
 			continue;
 
 		if (ev.sub_event_type == 255) { /* last stage */
 			rte_pktmbuf_free(ev.mbuf);
-			rte_atomic32_sub(total_events, 1);
+			rte_atomic_fetch_sub_explicit(total_events, 1,
+							      rte_memory_order_release);
 		} else {
 			ev.event_type = RTE_EVENT_TYPE_CPU;
 			ev.sub_event_type++;
@@ -1278,16 +1281,17 @@ worker_queue_based_pipeline_max_stages_rand_sched_type(void *arg)
 			    RTE_EVENT_DEV_ATTR_QUEUE_COUNT,
 			    &queue_count), "Queue count get failed");
 	uint8_t nr_queues = queue_count;
-	rte_atomic32_t *total_events = param->total_events;
+	__rte_atomic uint32_t *total_events = param->total_events;
 
-	while (rte_atomic32_read(total_events) > 0) {
+	while (rte_atomic_load_explicit(total_events, rte_memory_order_relaxed) > 0) {
 		valid_event = rte_event_dequeue_burst(evdev, port, &ev, 1, 0);
 		if (!valid_event)
 			continue;
 
 		if (ev.queue_id == nr_queues - 1) { /* last stage */
 			rte_pktmbuf_free(ev.mbuf);
-			rte_atomic32_sub(total_events, 1);
+			rte_atomic_fetch_sub_explicit(total_events, 1,
+							      rte_memory_order_release);
 		} else {
 			ev.event_type = RTE_EVENT_TYPE_CPU;
 			ev.queue_id++;
@@ -1320,16 +1324,17 @@ worker_mixed_pipeline_max_stages_rand_sched_type(void *arg)
 			    RTE_EVENT_DEV_ATTR_QUEUE_COUNT,
 			    &queue_count), "Queue count get failed");
 	uint8_t nr_queues = queue_count;
-	rte_atomic32_t *total_events = param->total_events;
+	__rte_atomic uint32_t *total_events = param->total_events;
 
-	while (rte_atomic32_read(total_events) > 0) {
+	while (rte_atomic_load_explicit(total_events, rte_memory_order_relaxed) > 0) {
 		valid_event = rte_event_dequeue_burst(evdev, port, &ev, 1, 0);
 		if (!valid_event)
 			continue;
 
 		if (ev.queue_id == nr_queues - 1) { /* Last stage */
 			rte_pktmbuf_free(ev.mbuf);
-			rte_atomic32_sub(total_events, 1);
+			rte_atomic_fetch_sub_explicit(total_events, 1,
+						      rte_memory_order_release);
 		} else {
 			ev.event_type = RTE_EVENT_TYPE_CPU;
 			ev.queue_id++;
-- 
2.53.0

