Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374CDCD5BB8
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 20:00:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41DD540E18;
	Sat, 23 May 2026 21:59:09 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id 83EA240DD2
 for <dev@dpdk.org>; Sat, 23 May 2026 21:59:04 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-3042a388168so2043562eec.1
 for <dev@dpdk.org>; Sat, 23 May 2026 12:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566344;
 x=1780171144; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jqfWI29KLHelMSIvcesQE/3H+ckJ49emjrcjiHw++jI=;
 b=buBl4/56cm+cMaZdZBPB2vi3THYStOCkumaoBUT+6M26D4Hxaia/zjMR0zo1Obk9Z+
 pz8BjUaU+SCR/iXz97ajX5u+Vyk+RLhLWhG+t0gNFiBd9RTGaNLHpCNMS9J62wL+oFtE
 oLLodiaDs9S+OUsyfKTzY4BR78ir1EgYMSCvsXBKct98THsKAn5/5XT9gKPEtx5i1hdt
 CoElSRbRU08DqxpnnileaCbQv26wpOwJvXQTo9OvFKaDeL/VyMMhzvsqcGMBNoy2Q0yT
 zq6bz6Fby91r/FAuXAR0ISHol83FVjIAv9dACLW6yIq2wEP+DF1uGjD5AoYrfnshEyGm
 SnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566344; x=1780171144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jqfWI29KLHelMSIvcesQE/3H+ckJ49emjrcjiHw++jI=;
 b=MN/uCgUE3hBk8/rtsHP+81bV/2OHUVK5Wlgvu+svwz7ZG8ojq6wNij/cC5M84p3Bkt
 0zRZ9GKue5x1ZbhGCtdlR2jRJiYSOGqA4zsTQb5TrGULACxQ7r1ovtegUX10n3gXqfi0
 MubQzH4V1h8zcHe95WSBE4ySLOFbldEbaDCm4XItnl7ae9WxnxjhcZJTjsErMYQCiKQ0
 lhf9/NdH6m7qxnJZt1js1Bnul7YApOlkKo9XO2s0WvDw06ff4f8JPL/nGrY67Q04Gwud
 rMUcY9END7qPEDGx7q5StExT5nhGDPu8a0JOFY42T1jJqwb3cEyZUGS5d1+RS1vPX7US
 /JPQ==
X-Gm-Message-State: AOJu0YwUPalVafdH8mR52Pg9TdBA+7qlX5LSDQQt3GQ9Jl4Yazl/0Yy+
 avPjCfLOExJqfGI/FhFX5biK8CJqYyCixKvG09iBpfdfXegI/DoMlWpJdePpo30x2814HqevbZI
 5fpeS
X-Gm-Gg: Acq92OHAlhAP7xexNTc/1G30dePTMwIBGmSVIoO94DsIs/Rj7a2zcHOHpocldO2Tbkh
 CaFfrNe5W5YrNEFxZvS+BWS/fc0xGoxqKkEciHKcyfAIrfVcg9dJS4XpVAA9ArQ5dpAT/uFDufv
 Vrx4XuIf9kAgXUujqBlU5yoptrBav9+XPi2jlmjO6iv1VqZ4DhsDgxcZnJjr4eK9FOYd2UPS6FO
 vfwXznaqAhlqOzMcdxRHNiWTVUIe4TooZ+R4YLyTddinFQYRisqPy8Uzif9GQlekafORAJ1/FYl
 ihazkNr+mWvxTWiytKcuEj+YafuLI3F2XNCDsuy6lc6/50VwvtwA/gn5m8khuapIDS2fkQCdPGX
 pG9Rbd4YDUtKpyD1u6Nkvjcv5WdWnWKAUTB4oyDFldWTZ2/+eXFZGsylcfrlkaGiknL+PPEdPEn
 8+XQXmjG4kHUZVdlBoJisWpyGcNZQkp6wV3/C0dTJyZs3t/7yIYDBQmDzCYVHzy4pBUh+Vzbdv
X-Received: by 2002:a05:7300:3211:b0:302:b44b:b64a with SMTP id
 5a478bee46e88-3044a3f9bdemr3310385eec.1.1779566343507; 
 Sat, 23 May 2026 12:59:03 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452255234sm4838428eec.20.2026.05.23.12.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:59:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v3 21/27] drivers/event: replace rte_atomic32 in selftests
Date: Sat, 23 May 2026 12:56:35 -0700
Message-ID: <20260523195839.454952-22-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523195839.454952-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195839.454952-1-stephen@networkplumber.org>
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
 drivers/event/dpaa2/dpaa2_eventdev_selftest.c | 26 +++++----
 drivers/event/octeontx/ssovf_evdev_selftest.c | 58 ++++++++++---------
 2 files changed, 46 insertions(+), 38 deletions(-)

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
index b54ae126d2..500762af78 100644
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
@@ -585,15 +586,15 @@ wait_workers_to_join(int lcore, const rte_atomic32_t *count)
 		uint64_t new_cycles = rte_get_timer_cycles();
 
 		if (new_cycles - print_cycles > rte_get_timer_hz()) {
-			ssovf_log_dbg("\r%s: events %d", __func__,
-				rte_atomic32_read(count));
+			ssovf_log_dbg("\r%s: events %u", __func__,
+				      rte_atomic_load_explicit(count, rte_memory_order_relaxed));
 			print_cycles = new_cycles;
 		}
 		if (new_cycles - cycles > rte_get_timer_hz() * 10) {
 			ssovf_log_dbg(
 				"%s: No schedules for seconds, deadlock (%d)",
 				__func__,
-				rte_atomic32_read(count));
+				rte_atomic_load_explicit(count, rte_memory_order_relaxed));
 			rte_event_dev_dump(evdev, stdout);
 			cycles = new_cycles;
 			return -1;
@@ -613,13 +614,13 @@ launch_workers_and_wait(int (*main_worker)(void *),
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
@@ -889,10 +890,10 @@ worker_flow_based_pipeline(void *arg)
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
@@ -910,7 +911,8 @@ worker_flow_based_pipeline(void *arg)
 		} else if (ev.sub_event_type == 1) { /* Events from stage 1*/
 			if (seqn_list_update(*rte_event_pmd_selftest_seqn(ev.mbuf)) == 0) {
 				rte_pktmbuf_free(ev.mbuf);
-				rte_atomic32_sub(total_events, 1);
+				rte_atomic_fetch_sub_explicit(total_events, 1,
+							      rte_memory_order_release);
 			} else {
 				ssovf_log_dbg("Failed to update seqn_list");
 				return -1;
@@ -1044,10 +1046,10 @@ worker_group_based_pipeline(void *arg)
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
@@ -1065,7 +1067,8 @@ worker_group_based_pipeline(void *arg)
 		} else if (ev.queue_id == 1) { /* Events from stage 1(group 1)*/
 			if (seqn_list_update(*rte_event_pmd_selftest_seqn(ev.mbuf)) == 0) {
 				rte_pktmbuf_free(ev.mbuf);
-				rte_atomic32_sub(total_events, 1);
+				rte_atomic_fetch_sub_explicit(total_events, 1,
+							      rte_memory_order_release);
 			} else {
 				ssovf_log_dbg("Failed to update seqn_list");
 				return -1;
@@ -1203,16 +1206,17 @@ worker_flow_based_pipeline_max_stages_rand_sched_type(void *arg)
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
@@ -1278,16 +1282,17 @@ worker_queue_based_pipeline_max_stages_rand_sched_type(void *arg)
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
@@ -1320,16 +1325,17 @@ worker_mixed_pipeline_max_stages_rand_sched_type(void *arg)
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

