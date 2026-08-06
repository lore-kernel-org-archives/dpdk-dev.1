Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA73BC55ABA
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 03:27:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FD7540DD1;
	Thu,  6 Aug 2026 05:26:11 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id 430AD40A67
 for <dev@dpdk.org>; Thu,  6 Aug 2026 05:26:08 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-ca88130e09aso1354574a12.3
 for <dev@dpdk.org>; Wed, 05 Aug 2026 20:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785986767;
 x=1786591567; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PznqqSezaXC7pgR8pla3KxOXEuwwYv6++wFFs21oqTU=;
 b=E4K+6ZTAVFbrw09nPb+NO81uPn+tXJjFJ6w1F+H73lL66VcQ/XoTn7V24SFRyFGoMx
 ODcmL2zAbAWYR95nFBTCrgy718eVoSxt/VnnV8PfKbBpIWG8n7sKb1w9NsRAbtG+AvKu
 f68mZoeuvjn0yC+qlwyo8++oHS6X/11SgzV+z5w86nm/Cbpi5VLNluskDr7Z9hbhlWft
 XkUlUqpcSasMri07YUeWeU9CNHbbAk7HAaa+3RG3EkcpV+0O+zpt/tYeNL4hgmpz7XLn
 kOSAf2/Mxgwc8gDE7wg6T++5ado8DQYQHf6S4hUoeKMFdT+KnCPKwqpUdpnx20O/9PH3
 YZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785986767; x=1786591567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PznqqSezaXC7pgR8pla3KxOXEuwwYv6++wFFs21oqTU=;
 b=kU2tdpkkOXdc2MzYZ5P95IKheOfFQlmOMFP5Qp1zfXK0klcKgKBRTZYhWjlfTUDzzA
 pvrt2cvBeCZ+PEi9EcwJouCpYw6dWMjPYrhWcvxzjyAlHKgSvjBPAPEiA28AMURk/kb4
 7edW10YVyRKYttW+KsqVaPeVjTp0WbQ7m+F2INpn+cUt7Si8dfINC3TpOf0T7zHpAoVZ
 qF7ttq/6BZz3a+u3/mILipi2CNYl6WmyBZl0ZEN0EZ/Z+IFIkNUf+9+VytpVj10QNGE9
 Lsos+C0Mje4FGuPyCrNTXUbz60x6cWoy7yQwYm2Ook1p+JIGf8XmnMb9t0upE68qRvOp
 b6Sg==
X-Gm-Message-State: AOJu0Yw0VNV67QIid7u7p7gRFIt0nb40Ovn/0Kd5ZBS6VMNWijeujvUw
 x6ZPuzGyNdhelKxw5u74R/4jrwMhwSKCgOPErIImpL3uI1r3eEm/U+pBcEHFuwQYYdgUHt+qpUN
 MJ5sber8=
X-Gm-Gg: AR+sD123vVHOmsxgeQKCkd3ORei3ikuf03KlBHXiWVmPxNy+lkQ9m7aP1FjyHJdQFjm
 kyKakVtCDxpSDxK3/B8pE+GdyuwEy5f3QcD3jJUmixiD5s6Ob2PYUfRQFyGnfzqyIA/IEBFDkc9
 jgaK2YBi9Q3f/RajudHF3tnjBwI8KTgS1mFSok40GrkGI5Si5RDJBBqBRIq0HhS0U4Ljp4Az3eD
 pxVqoNqiJguP4Ai0R/+G9nh8XZOBZO4tnvUsmYGijQZ1OzdMw/rBV3+ZbbzLjhK0m9zl0dL/0eG
 CiRgB1UK7gQ5y6WsS12SE1mOgUPQC1oAeP/NgeeIdSb5+THnzU98sgNXMF5eBnjggntE8DzCPSw
 8MwM4n3wU6wwWXtfXJ9RiaL74WtiQgznaa9pULOZZTmQzTedqaraC2tc4tw+aTMicnLMzOECVJH
 0j+knQYh1vnbD30vFTDEJqCUGpX7RcTV7axGTQWQ34kSnJihwHwkxf+ggZgHNqSmHB+N9d+erha
 TQ/8sHAeHpgkNanzO3Np9vpZLPCn5BD9sCCCw==
X-Received: by 2002:a05:6a21:7007:b0:3b4:870e:6f44 with SMTP id
 adf61e73a8af0-3cb85ffca47mr15802160637.35.1785986767355; 
 Wed, 05 Aug 2026 20:26:07 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0c61sm23301631eec.6.2026.08.05.20.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 20:26:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v7 18/24] drivers/event: replace rte_atomic32 in selftests
Date: Wed,  5 Aug 2026 20:23:10 -0700
Message-ID: <20260806032544.21337-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806032544.21337-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260806032544.21337-1-stephen@networkplumber.org>
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

