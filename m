Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC939CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:06:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CF8E42E8C;
	Tue, 29 Sep 2026 16:04:43 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id E313342E5C
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:04:31 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-880cb967dffso489995b3a.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790690671;
 x=1791295471; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UjrxmA2pT5zIXwxt9qK2KBnRK/G2I1BiLZ7w9vnJIlQ=;
 b=w2+P5cqXImSJnaz3sa8ILShjnru5C+5tMBU/vLPMSCWSYTEWmAgF57y7mUMkI937GT
 OWygllk6iK8KvvSOaNtQV9tXjUsAH/6Ph5YTJ77fRXdctrr0lPQoe2oYg1zqncY2rT15
 e0cV9beNwc62yvgIYzksmEaNb+gJCnqgOsAMScb8wjkEmuMPSv/VO7irdfJHSE11c8cs
 7JzJsVgz7XVP6ZDw9d3ZhAhOyEar3dWWL8fYkT0Yoa6ICOUfmlZSDoMpjMD8i4nlJiLa
 pjQK1efkdsy1s+YQ6Ib5tci3E2nTrp1rlTemuLY3j+GHpgnwNlmCVGuqQUKMXgfLHNlx
 OvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790690671; x=1791295471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UjrxmA2pT5zIXwxt9qK2KBnRK/G2I1BiLZ7w9vnJIlQ=;
 b=Amr6jzF5eQpEt1dWOhWpvH7ThoMqjCmb9ZOae+t1zTz1uBjwlWeYsn2RKo57wusGBM
 2+gjBPTBuna3TvUUsScU7L04enmheo5gbPvynKGyAQeGN1JeJnCu3JM/kjC1/DmprVi/
 8hbT2JXG5cLOLzo4bDBBR9vRZbhDydl+WrRbPmPv7F2K6EMXjPVZX917Xkqrc+GwQlhZ
 ubdk/Om2UeDF8uOcv7ctKOevEL48nAnQg5IB8uYbT9g0MKSYiAlnl/h/UvBlCXEr7shz
 JLTm/97ylfj7GqkMLa2j3pFLpm3o1K/Eld0o1DDku3VWA5EouW1gtQfl7JgvXmYIIQvg
 Yzrw==
X-Gm-Message-State: AFuF++mkUUWpdiwDtouX0g4Y6qm9gVaU8DTWPWoqDBVfueS4Gy4H1MLV
 27vkNt25peuwxeeluCsvbxcud6/Fe9BiYvk/Hjyl9URrQed96xpmeb3q8uqRqKq9RJnIM/3z4cK
 K3BW8tf4=
X-Gm-Gg: AYBFou3C4ZwsrTDf2E1phOXUz2fbPdRVBDEBTpa30h167u/B+G9bb5GNIc+WL4f/MxC
 GFjSq+6xaheiSUlz+G/pNL5z/opo5yKdt3c18mjGxxOBlZb8uXy3jmLe1Eh4byi+0QELhsA+BpT
 66WcEh23bvUP6xZ2Ycstp89GfAIqv2UKNKUYrmX8UP9Dwc2Zaha/mitmdqMGQzixztf99K7JxVY
 U+eUaY8nS8vZiZ0qvWTxB+wqzqZyEnkM2vZPLGeo918e7TTL4iJAsqiAEldJNdNZb/SSo4Icdrw
 kVuB2WIOEjFC6n+y9D5z0W9Ra0/FVV4gDFVq2m2p5s+9Wm9EelfxEbeVGBL2KQj8NP6gO3h7Lgd
 9bAFYVFZ1CU+8PkndOdXVksQlWcOBc6aYv/0lL+4EWJ0Gi3EdpOwLn+fMeZObDMmJ+qvUByhyVz
 DDfGEzjdkjCpPcll6+o6QPWLuzoAxrvioQatmH8P0Aba51IQRF+jh30KUcvxE8nqSQhu+bcw8+K
 fmhBmjLOuU0XCYJlQIiQ7IhCiTIsDbFc6sxgQ==
X-Received: by 2002:a05:6a00:1582:b0:87d:d574:b389 with SMTP id
 d2e1a72fcca58-88561142e19mr1337434b3a.14.1790690670913; 
 Tue, 29 Sep 2026 07:04:30 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e1066470sm998330b3a.18.2026.09.29.07.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:04:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v9 18/25] drivers/event: replace rte_atomic32 in selftests
Date: Tue, 29 Sep 2026 07:02:04 -0700
Message-ID: <20260929140409.234453-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929140409.234453-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260929140409.234453-1-stephen@networkplumber.org>
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
 drivers/event/octeontx/ssovf_evdev_selftest.c | 57 ++++++++++---------
 2 files changed, 43 insertions(+), 40 deletions(-)

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
index b54ae126d2..e51b89a31e 100644
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
@@ -613,13 +613,12 @@ launch_workers_and_wait(int (*main_worker)(void *),
 	int w_lcore;
 	int ret;
 	struct test_core_param *param;
-	rte_atomic32_t atomic_total_events;
+	RTE_ATOMIC(uint32_t) atomic_total_events = total_events;
 	uint64_t dequeue_tmo_ticks;
 
 	if (!nb_workers)
 		return 0;
 
-	rte_atomic32_set(&atomic_total_events, total_events);
 	seqn_list_init();
 
 	param = malloc(sizeof(struct test_core_param) * nb_workers);
@@ -889,10 +888,10 @@ worker_flow_based_pipeline(void *arg)
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
@@ -910,7 +909,8 @@ worker_flow_based_pipeline(void *arg)
 		} else if (ev.sub_event_type == 1) { /* Events from stage 1*/
 			if (seqn_list_update(*rte_event_pmd_selftest_seqn(ev.mbuf)) == 0) {
 				rte_pktmbuf_free(ev.mbuf);
-				rte_atomic32_sub(total_events, 1);
+				rte_atomic_fetch_sub_explicit(total_events, 1,
+							      rte_memory_order_release);
 			} else {
 				ssovf_log_dbg("Failed to update seqn_list");
 				return -1;
@@ -1044,10 +1044,10 @@ worker_group_based_pipeline(void *arg)
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
@@ -1065,7 +1065,8 @@ worker_group_based_pipeline(void *arg)
 		} else if (ev.queue_id == 1) { /* Events from stage 1(group 1)*/
 			if (seqn_list_update(*rte_event_pmd_selftest_seqn(ev.mbuf)) == 0) {
 				rte_pktmbuf_free(ev.mbuf);
-				rte_atomic32_sub(total_events, 1);
+				rte_atomic_fetch_sub_explicit(total_events, 1,
+							      rte_memory_order_release);
 			} else {
 				ssovf_log_dbg("Failed to update seqn_list");
 				return -1;
@@ -1203,16 +1204,16 @@ worker_flow_based_pipeline_max_stages_rand_sched_type(void *arg)
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
+			rte_atomic_fetch_sub_explicit(total_events, 1, rte_memory_order_release);
 		} else {
 			ev.event_type = RTE_EVENT_TYPE_CPU;
 			ev.sub_event_type++;
@@ -1278,16 +1279,16 @@ worker_queue_based_pipeline_max_stages_rand_sched_type(void *arg)
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
+			rte_atomic_fetch_sub_explicit(total_events, 1, rte_memory_order_release);
 		} else {
 			ev.event_type = RTE_EVENT_TYPE_CPU;
 			ev.queue_id++;
@@ -1320,16 +1321,16 @@ worker_mixed_pipeline_max_stages_rand_sched_type(void *arg)
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
+			rte_atomic_fetch_sub_explicit(total_events, 1, rte_memory_order_release);
 		} else {
 			ev.event_type = RTE_EVENT_TYPE_CPU;
 			ev.queue_id++;
-- 
2.53.0

