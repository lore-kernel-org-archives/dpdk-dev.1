Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0BBC55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 05:01:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31DDA40A8B;
	Fri, 31 Jul 2026 07:00:22 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id C25A140E0C
 for <dev@dpdk.org>; Fri, 31 Jul 2026 07:00:11 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2cad8076b01so5607225ad.2
 for <dev@dpdk.org>; Thu, 30 Jul 2026 22:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785474011;
 x=1786078811; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PznqqSezaXC7pgR8pla3KxOXEuwwYv6++wFFs21oqTU=;
 b=ewj6IvPA7Qs/W1qDC0ZPCePvWYmhcVmWXZWPuQOt7obKEjIa2VtfntP3STHVCmd5UU
 xSe1KASX+8PjRitNVFwNminvD8QLgCK2DzD424Y7aTUXiS/X7e8FmsT3wdI15rvhrITp
 4rG1+grReTOWQKkVPKcd5XPyWKFsUQjYlhLdm8wiI59yLtyBFy8hAEVG6V/FD/QjdogP
 plGpxEMVQGeyWJ2CDONjNSbIVK80IkTIJGHm86bVKFTBgPsSn8U6nXF222Pwq1P+KLA5
 /kfRoXkoXfDTuSCdvYoKwjG3XOoBTBzewJC3AxWxDv+F9tbYTDNYmvkYYr/HSOQfSep/
 0POw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785474011; x=1786078811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PznqqSezaXC7pgR8pla3KxOXEuwwYv6++wFFs21oqTU=;
 b=WSOX4oZ73mMGpSzwGelZpVS3Xqfv5ZEq5ZAylDkXA3zblh7QHVnWSVelhLqPhPdYg4
 py1vEZVkXWdL+By7IP7U5uMdu6aLIejOc33hUQUQ6HsLaT7HPb8aPDOyjiNuCb8pv8vg
 UZ+ffQN8fq+yfrdFUNv2EG+YmSs2aS0+Nr98eLyEGG9O0O6ucAE/KPx0/1Lr1PY5CBhg
 EOYBzl1ypFs1MGRy+hQznQw5g3MBatfcTwstvLZPZlwVIYm48G3qZHLf68zT5KkSDkBB
 lF569JCfEVZGOqSo84ExnZFJUMlgTLgmnUXOXxDLkI9ciPYk4aOSXfosK4FIH0vCn16P
 cFpQ==
X-Gm-Message-State: AOJu0YxmoCZqSQxLdxGyhkDvtdHuttY0rJIpuw7d0UMjzSkf1PfE9X04
 6ty2ohcvErsDhi0N+jJEagycLfY5QmV++Z6z+Mxpb64y8IaewLJicPz7K61eqo5ZQZGKnaaRkWd
 q5EMS
X-Gm-Gg: AR+sD10wMX4PUPIS3BcsPrPATCplMdQHYClGghWcsl3uh8B+M3YeOu0ArzIwQ1kGhR/
 S30uqMJ/PFMaIcvYPP6pgKVqfXherexOg+dLTxWBEQlImigrrpT9BnbhxMBJLG2dA/y/GQjO2Dr
 s66wZbSuhJsCkuQPYer1//Zo0Mp+aqzQBk2aJRo/PD6Xn1UwdskRRd0TLFgMmhn59Vv5v4NphDi
 FgtZrz9abxfcH80JDYMO8oPgoYt3MVkvadZYuaZOucazhAUsHlaQvJ5EVUe6UYU8H6JjAswULXZ
 nTlPMzHewKhdIyoOZGb1T52eMEPF4dRS/p2qwj2pD8S/tkFGzhcaPfmizJHF2nb2A/hRfLsEBTH
 t05ZYb4kPu3MyiMYH2iXGmLj3X5UlMCpbzPUbTDJ52I7d+Nyb+XJM3xrN+EOD9nKjgeCGe3gPGc
 veVWwWZKLOAH9QwJ/0NlNfqNCN9Vfu1tXoha7XfbjyYvSwtsZF1LSkRAtmDWe0SIanjIf2j8JJw
 HY/DaGk1kZashFu4w5joA1/wC0=
X-Received: by 2002:a05:6a21:1014:b0:3c4:34db:9fbb with SMTP id
 adf61e73a8af0-3c91b38a6c2mr415899637.57.1785474010840; 
 Thu, 30 Jul 2026 22:00:10 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e06f0f9sm823245eec.23.2026.07.30.22.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 22:00:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v6 18/24] drivers/event: replace rte_atomic32 in selftests
Date: Thu, 30 Jul 2026 21:57:56 -0700
Message-ID: <20260731045948.769926-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731045948.769926-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260731045948.769926-1-stephen@networkplumber.org>
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

