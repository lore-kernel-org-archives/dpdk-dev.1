Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7F7606A320
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:47:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55C5840F1A;
	Fri, 23 Oct 2026 15:44:40 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 73DA540E4F
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:28 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5696E20002B;
 Fri, 23 Oct 2026 15:44:28 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ED85C20003F;
 Fri, 23 Oct 2026 15:44:27 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E8DDF180006C;
 Fri, 23 Oct 2026 21:44:26 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 33/65] event/dpaa2: rework self test for dynamic link
 and balance check
Date: Fri, 23 Oct 2026 19:13:13 +0530
Message-ID: <20261023134346.37727-34-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
References: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
 <20261023134346.37727-1-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jun Yang <jun.yang@nxp.com>

The eventdev self test linked every queue to every port during device
setup, which prevented individual test cases from exercising their own
queue-to-port topologies and made enqueue/dequeue accounting unreliable.

Rework the self test as follows:

- Move queue-to-port linking out of _eventdev_setup() into each test
  case, so every test establishes the link topology it needs.
- Convert the test mode selector to a bitmask and add an atomic port
  setup path (RTE_DPAA2_EVENT_PORT_CFG_ATOMIC), used by the
  multi-queue/multi-port dequeue test.
- Return the number of dequeued events from consume_events() and assert
  that the dequeued count matches the injected count, verifying balance
  between ingress and egress.
- Retry enqueue until the event is accepted so injection no longer
  silently drops events.
- Propagate meaningful error codes (-ENOMEM, -EINVAL, -ETIMEDOUT,
  -ENODEV, and the underlying ret) instead of a bare -1.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/event/dpaa2/dpaa2_eventdev_selftest.c | 336 ++++++++++--------
 1 file changed, 197 insertions(+), 139 deletions(-)

diff --git a/drivers/event/dpaa2/dpaa2_eventdev_selftest.c b/drivers/event/dpaa2/dpaa2_eventdev_selftest.c
index 2c688bd194..569621dc39 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev_selftest.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev_selftest.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018-2019 NXP
+ * Copyright 2018-2019, 2026 NXP
  */
 
 #include <rte_stdatomic.h>
@@ -20,6 +20,7 @@
 #include <bus_vdev_driver.h>
 #include <rte_test.h>
 #include <bus_fslmc_driver.h>
+#include <rte_pmd_dpaa2.h>
 
 #include "dpaa2_eventdev.h"
 #include "dpaa2_eventdev_logs.h"
@@ -105,63 +106,64 @@ devconf_set_default_sane_values(struct rte_event_dev_config *dev_conf,
 }
 
 enum {
-	TEST_EVENTDEV_SETUP_DEFAULT,
-	TEST_EVENTDEV_SETUP_PRIORITY,
-	TEST_EVENTDEV_SETUP_DEQUEUE_TIMEOUT,
+	TEST_EVENTDEV_SETUP_DEFAULT = (1 << 0),
+	TEST_EVENTDEV_SETUP_PRIORITY = (1 << 1),
+	TEST_EVENTDEV_SETUP_DEQUEUE_TIMEOUT = (1 << 2),
+	TEST_EVENTDEV_SETUP_ATOMIC = (1 << 3)
 };
 
 static int
 _eventdev_setup(int mode)
 {
-	int i, ret;
+	int ret;
 	struct rte_event_dev_config dev_conf;
 	struct rte_event_dev_info info;
 	const char *pool_name = "evdev_dpaa2_test_pool";
+	uint32_t queue_count, port_count, i;
+	uint8_t step;
+	struct rte_event_port_conf port_conf, *pport_conf;
 
 	/* Create and destroy pool for each test case to make it standalone */
 	eventdev_test_mempool = rte_pktmbuf_pool_create(pool_name,
-					MAX_EVENTS,
+					1024 /*TOTAL_EVENTS*/,
 					0 /*MBUF_CACHE_SIZE*/,
 					0,
-					512, /* Use very small mbufs */
+					2048 + 256 /*512*/, /* Use very small mbufs */
 					rte_socket_id());
 	if (!eventdev_test_mempool) {
 		dpaa2_evdev_err("ERROR creating mempool");
-		return -1;
+		return -ENOMEM;
 	}
 
 	ret = rte_event_dev_info_get(evdev, &info);
 	RTE_TEST_ASSERT_SUCCESS(ret, "Failed to get event dev info");
 	RTE_TEST_ASSERT(info.max_num_events >= (int32_t)MAX_EVENTS,
 			"ERROR max_num_events=%d < max_events=%d",
-				info.max_num_events, MAX_EVENTS);
+			info.max_num_events, MAX_EVENTS);
 
 	devconf_set_default_sane_values(&dev_conf, &info);
-	if (mode == TEST_EVENTDEV_SETUP_DEQUEUE_TIMEOUT)
+	if (mode & TEST_EVENTDEV_SETUP_DEQUEUE_TIMEOUT)
 		dev_conf.event_dev_cfg |= RTE_EVENT_DEV_CFG_PER_DEQUEUE_TIMEOUT;
 
 	ret = rte_event_dev_configure(evdev, &dev_conf);
 	RTE_TEST_ASSERT_SUCCESS(ret, "Failed to configure eventdev");
 
-	uint32_t queue_count;
 	RTE_TEST_ASSERT_SUCCESS(rte_event_dev_attr_get(evdev,
-			    RTE_EVENT_DEV_ATTR_QUEUE_COUNT,
-			    &queue_count), "Queue count get failed");
-
-	if (mode == TEST_EVENTDEV_SETUP_PRIORITY) {
-		if (queue_count > 8) {
-			dpaa2_evdev_err(
-				"test expects the unique priority per queue");
-			return -ENOTSUP;
+		RTE_EVENT_DEV_ATTR_QUEUE_COUNT, &queue_count),
+		"Queue count get failed");
+
+	if (mode & TEST_EVENTDEV_SETUP_PRIORITY) {
+		if (!queue_count) {
+			dpaa2_evdev_err("No queue available");
+			return -EINVAL;
 		}
 
 		/* Configure event queues(0 to n) with
 		 * RTE_EVENT_DEV_PRIORITY_HIGHEST to
 		 * RTE_EVENT_DEV_PRIORITY_LOWEST
 		 */
-		uint8_t step = (RTE_EVENT_DEV_PRIORITY_LOWEST + 1) /
-				queue_count;
-		for (i = 0; i < (int)queue_count; i++) {
+		step = (RTE_EVENT_DEV_PRIORITY_LOWEST + 1) / queue_count;
+		for (i = 0; i < queue_count; i++) {
 			struct rte_event_queue_conf queue_conf;
 
 			ret = rte_event_queue_default_conf_get(evdev, i,
@@ -170,29 +172,33 @@ _eventdev_setup(int mode)
 					i);
 			queue_conf.priority = i * step;
 			ret = rte_event_queue_setup(evdev, i, &queue_conf);
-			RTE_TEST_ASSERT_SUCCESS(ret, "Failed to setup queue=%d",
-					i);
+			RTE_TEST_ASSERT_SUCCESS(ret, "Failed to setup queue=%d", i);
 		}
-
 	} else {
 		/* Configure event queues with default priority */
-		for (i = 0; i < (int)queue_count; i++) {
+		for (i = 0; i < queue_count; i++) {
 			ret = rte_event_queue_setup(evdev, i, NULL);
-			RTE_TEST_ASSERT_SUCCESS(ret, "Failed to setup queue=%d",
-					i);
+			RTE_TEST_ASSERT_SUCCESS(ret, "Failed to setup queue=%d", i);
 		}
 	}
+
 	/* Configure event ports */
-	uint32_t port_count;
 	RTE_TEST_ASSERT_SUCCESS(rte_event_dev_attr_get(evdev,
-				RTE_EVENT_DEV_ATTR_PORT_COUNT,
-				&port_count), "Port count get failed");
-	for (i = 0; i < (int)port_count; i++) {
-		ret = rte_event_port_setup(evdev, i, NULL);
+		RTE_EVENT_DEV_ATTR_PORT_COUNT, &port_count),
+		"Port count get failed");
+	for (i = 0; i < port_count; i++) {
+		if (mode & TEST_EVENTDEV_SETUP_ATOMIC) {
+			pport_conf = &port_conf;
+			memset(pport_conf, 0, sizeof(struct rte_event_port_conf));
+			ret = rte_event_port_default_conf_get(evdev, i, pport_conf);
+			RTE_TEST_ASSERT_SUCCESS(ret,
+				"Failed to get default conf of port=%d", i);
+			pport_conf->event_port_cfg = RTE_DPAA2_EVENT_PORT_CFG_ATOMIC;
+		} else {
+			pport_conf = NULL;
+		}
+		ret = rte_event_port_setup(evdev, i, pport_conf);
 		RTE_TEST_ASSERT_SUCCESS(ret, "Failed to setup port=%d", i);
-		ret = rte_event_port_link(evdev, i, NULL, NULL, 0);
-		RTE_TEST_ASSERT(ret >= 0, "Failed to link all queues port=%d",
-				i);
 	}
 
 	ret = rte_event_dev_start(evdev);
@@ -207,6 +213,13 @@ eventdev_setup(void)
 	return _eventdev_setup(TEST_EVENTDEV_SETUP_DEFAULT);
 }
 
+static int
+eventdev_atomic_port_setup(void)
+{
+	return _eventdev_setup(TEST_EVENTDEV_SETUP_DEFAULT |
+		TEST_EVENTDEV_SETUP_ATOMIC);
+}
+
 static void
 eventdev_teardown(void)
 {
@@ -216,9 +229,9 @@ eventdev_teardown(void)
 
 static void
 update_event_and_validation_attr(struct rte_mbuf *m, struct rte_event *ev,
-			uint32_t flow_id, uint8_t event_type,
-			uint8_t sub_event_type, uint8_t sched_type,
-			uint8_t queue, uint8_t port, uint8_t seq)
+	uint32_t flow_id, uint8_t event_type,
+	uint8_t sub_event_type, uint8_t sched_type,
+	uint8_t queue, uint8_t port, uint8_t seq)
 {
 	struct event_attr *attr;
 
@@ -249,6 +262,7 @@ inject_events(uint32_t flow_id, uint8_t event_type, uint8_t sub_event_type,
 {
 	struct rte_mbuf *m;
 	unsigned int i;
+	uint16_t eq, err_count;
 
 	for (i = 0; i < events; i++) {
 		struct rte_event ev = {.event = 0, .u64 = 0};
@@ -258,7 +272,16 @@ inject_events(uint32_t flow_id, uint8_t event_type, uint8_t sub_event_type,
 
 		update_event_and_validation_attr(m, &ev, flow_id, event_type,
 			sub_event_type, sched_type, queue, port, i);
-		rte_event_enqueue_burst(evdev, port, &ev, 1);
+		err_count = 0;
+eq_again:
+		eq = rte_event_enqueue_burst(evdev, port, &ev, 1);
+		if (eq != 1) {
+			dpaa2_evdev_err("Failed, eq(%d) != 1", eq);
+			if (err_count > 10)
+				return -EBUSY;
+			err_count++;
+			goto eq_again;
+		}
 	}
 	return 0;
 }
@@ -271,7 +294,7 @@ check_excess_events(uint8_t port)
 	struct rte_event ev;
 
 	/* Check for excess events, try for a few times and exit */
-	for (i = 0; i < 32; i++) {
+	for (i = 0; i < 4; i++) {
 		valid_event = rte_event_dequeue_burst(evdev, port, &ev, 1, 0);
 
 		RTE_TEST_ASSERT_SUCCESS(valid_event,
@@ -285,27 +308,35 @@ static int
 generate_random_events(const unsigned int total_events)
 {
 	struct rte_event_dev_info info;
-	unsigned int i;
+	uint32_t queue_count, i;
+	uint8_t queues[RTE_EVENT_MAX_QUEUES_PER_DEV];
 	int ret;
 
-	uint32_t queue_count;
 	RTE_TEST_ASSERT_SUCCESS(rte_event_dev_attr_get(evdev,
-			    RTE_EVENT_DEV_ATTR_QUEUE_COUNT,
-			    &queue_count), "Queue count get failed");
+		RTE_EVENT_DEV_ATTR_QUEUE_COUNT, &queue_count),
+		"Queue count get failed");
+	if (queue_count > RTE_EVENT_MAX_QUEUES_PER_DEV)
+		queue_count = RTE_EVENT_MAX_QUEUES_PER_DEV;
+	for (i = 0; i < queue_count; i++)
+		queues[i] = i;
+
+	ret = rte_event_port_link(evdev, 0, queues, NULL,
+			queue_count);
+	RTE_TEST_ASSERT(ret >= 0, "Failed to link %d queues port0",
+		queue_count);
 
 	ret = rte_event_dev_info_get(evdev, &info);
 	RTE_TEST_ASSERT_SUCCESS(ret, "Failed to get event dev info");
 	for (i = 0; i < total_events; i++) {
-		ret = inject_events(
-			rte_rand() % info.max_event_queue_flows /*flow_id */,
+		ret = inject_events(rte_rand() % info.max_event_queue_flows /*flow_id */,
 			RTE_EVENT_TYPE_CPU /* event_type */,
 			rte_rand() % 256 /* sub_event_type */,
 			rte_rand() % (RTE_SCHED_TYPE_PARALLEL + 1),
-			rte_rand() % queue_count /* queue */,
+			rte_rand() % queue_count,
 			0 /* port */,
 			1 /* events */);
 		if (ret)
-			return -1;
+			return ret;
 	}
 	return ret;
 }
@@ -339,7 +370,8 @@ typedef int (*validate_event_cb)(uint32_t index, uint8_t port,
 				 struct rte_event *ev);
 
 static int
-consume_events(uint8_t port, const uint32_t total_events, validate_event_cb fn)
+consume_events(uint8_t port, const uint32_t total_events,
+	uint32_t *dq_events, validate_event_cb fn)
 {
 	int ret;
 	uint16_t valid_event;
@@ -349,7 +381,7 @@ consume_events(uint8_t port, const uint32_t total_events, validate_event_cb fn)
 	while (1) {
 		if (++forward_progress_cnt > UINT16_MAX) {
 			dpaa2_evdev_err("Detected deadlock");
-			return -1;
+			return -ETIMEDOUT;
 		}
 
 		valid_event = rte_event_dequeue_burst(evdev, port, &ev, 1, 0);
@@ -359,9 +391,9 @@ consume_events(uint8_t port, const uint32_t total_events, validate_event_cb fn)
 		forward_progress_cnt = 0;
 		ret = validate_event(&ev);
 		if (ret)
-			return -1;
+			return ret;
 
-		if (fn != NULL) {
+		if (fn) {
 			ret = fn(index, port, &ev);
 			RTE_TEST_ASSERT_SUCCESS(ret,
 				"Failed to validate test specific event");
@@ -374,6 +406,9 @@ consume_events(uint8_t port, const uint32_t total_events, validate_event_cb fn)
 			break;
 	}
 
+	if (dq_events)
+		*dq_events = events;
+
 	return check_excess_events(port);
 }
 
@@ -394,18 +429,28 @@ static int
 test_simple_enqdeq(uint8_t sched_type)
 {
 	int ret;
+	uint8_t queue = 0;
+	uint32_t total_dq = 0;
+
+	ret = rte_event_port_link(evdev, 0, &queue, NULL, 1);
+	RTE_TEST_ASSERT(ret >= 0, "Failed to link 1 queues port0");
 
 	ret = inject_events(0 /*flow_id */,
-				RTE_EVENT_TYPE_CPU /* event_type */,
-				0 /* sub_event_type */,
-				sched_type,
-				0 /* queue */,
-				0 /* port */,
-				MAX_EVENTS);
+			RTE_EVENT_TYPE_CPU /* event_type */,
+			0 /* sub_event_type */,
+			sched_type,
+			0 /* queue */,
+			0 /* port */,
+			MAX_EVENTS);
 	if (ret)
-		return -1;
+		return ret;
 
-	return consume_events(0 /* port */, MAX_EVENTS,	validate_simple_enqdeq);
+	ret = consume_events(0/* port */, MAX_EVENTS,	&total_dq, validate_simple_enqdeq);
+	RTE_TEST_ASSERT(!ret, "Failed to consume event from port0");
+	RTE_TEST_ASSERT(total_dq == MAX_EVENTS,
+		"total_dq(%d) != MAX_EVENTS(8)", total_dq);
+
+	return ret;
 }
 
 static int
@@ -429,12 +474,18 @@ static int
 test_multi_queue_enq_single_port_deq(void)
 {
 	int ret;
+	uint32_t dq_events;
 
 	ret = generate_random_events(MAX_EVENTS);
 	if (ret)
-		return -1;
+		return ret;
+
+	ret = consume_events(0/* port */, MAX_EVENTS, &dq_events, NULL);
+	RTE_TEST_ASSERT(!ret, "Failed to consume event from port0");
+	RTE_TEST_ASSERT(dq_events == MAX_EVENTS,
+		"dq_events(%d) != MAX_EVENTS(8)", dq_events);
 
-	return consume_events(0 /* port */, MAX_EVENTS, NULL);
+	return ret;
 }
 
 static int
@@ -479,8 +530,7 @@ wait_workers_to_join(int lcore, const __rte_atomic uint32_t *count)
 			print_cycles = new_cycles;
 		}
 		if (new_cycles - cycles > rte_get_timer_hz() * 10) {
-			dpaa2_evdev_info(
-				"%s: No schedules for seconds, deadlock (%u)",
+			dpaa2_evdev_info("%s: No schedules for seconds, deadlock (%d)",
 				__func__,
 				rte_atomic_load_explicit(count, rte_memory_order_relaxed));
 			rte_event_dev_dump(evdev, stdout);
@@ -495,8 +545,8 @@ wait_workers_to_join(int lcore, const __rte_atomic uint32_t *count)
 
 static int
 launch_workers_and_wait(int (*main_worker)(void *),
-			int (*workers)(void *), uint32_t total_events,
-			uint8_t nb_workers, uint8_t sched_type)
+	int (*workers)(void *), uint32_t total_events,
+	uint8_t nb_workers, uint8_t sched_type)
 {
 	uint8_t port = 0;
 	int w_lcore;
@@ -513,13 +563,13 @@ launch_workers_and_wait(int (*main_worker)(void *),
 
 	param = malloc(sizeof(struct test_core_param) * nb_workers);
 	if (!param)
-		return -1;
+		return -ENOMEM;
 
 	ret = rte_event_dequeue_timeout_ticks(evdev,
 		rte_rand() % 10000000/* 10ms */, &dequeue_tmo_ticks);
 	if (ret) {
 		free(param);
-		return -1;
+		return ret;
 	}
 
 	param[0].total_events = &atomic_total_events;
@@ -563,22 +613,22 @@ test_multi_queue_enq_multi_port_deq(void)
 
 	ret = generate_random_events(total_events);
 	if (ret)
-		return -1;
+		return ret;
 
 	RTE_TEST_ASSERT_SUCCESS(rte_event_dev_attr_get(evdev,
-				RTE_EVENT_DEV_ATTR_PORT_COUNT,
-				&nr_ports), "Port count get failed");
+		RTE_EVENT_DEV_ATTR_PORT_COUNT, &nr_ports),
+		"Port count get failed");
 	nr_ports = RTE_MIN(nr_ports, rte_lcore_count() - 1);
 
 	if (!nr_ports) {
 		dpaa2_evdev_err("%s: Not enough ports=%d or workers=%d",
-				__func__, nr_ports, rte_lcore_count() - 1);
-		return 0;
+			__func__, nr_ports, rte_lcore_count() - 1);
+		return -EINVAL;
 	}
 
 	return launch_workers_and_wait(worker_multi_port_fn,
-					worker_multi_port_fn, total_events,
-					nr_ports, 0xff /* invalid */);
+				worker_multi_port_fn, total_events,
+				nr_ports, 0xff /* invalid */);
 }
 
 static
@@ -589,7 +639,6 @@ void flush(uint8_t dev_id, struct rte_event event, void *arg)
 	RTE_SET_USED(dev_id);
 	if (event.event_type == RTE_EVENT_TYPE_CPU)
 		*count = *count + 1;
-
 }
 
 static int
@@ -610,8 +659,8 @@ test_dev_stop_flush(void)
 	if (ret)
 		return -3;
 	RTE_TEST_ASSERT_EQUAL(total_events, count,
-				"count mismatch total_events=%d count=%d",
-				total_events, count);
+		"count mismatch total_events=%d count=%d",
+		total_events, count);
 	return 0;
 }
 
@@ -621,8 +670,8 @@ validate_queue_to_port_single_link(uint32_t index, uint8_t port,
 {
 	RTE_SET_USED(index);
 	RTE_TEST_ASSERT_EQUAL(port, ev->queue_id,
-				"queue mismatch enq=%d deq =%d",
-				port, ev->queue_id);
+		"queue mismatch enq=%d deq =%d",
+		port, ev->queue_id);
 	return 0;
 }
 
@@ -633,39 +682,32 @@ validate_queue_to_port_single_link(uint32_t index, uint8_t port,
 static int
 test_queue_to_port_single_link(void)
 {
-	int i, nr_links, ret;
-
-	uint32_t port_count;
+	int ret;
+	uint8_t queue;
+	uint32_t port_count, queue_count, nr_links, total_events, i;
+	uint32_t dq_events = 0, total_dqs = 0;
 
 	RTE_TEST_ASSERT_SUCCESS(rte_event_dev_attr_get(evdev,
-				RTE_EVENT_DEV_ATTR_PORT_COUNT,
-				&port_count), "Port count get failed");
-
-	/* Unlink all connections that created in eventdev_setup */
-	for (i = 0; i < (int)port_count; i++) {
-		ret = rte_event_port_unlink(evdev, i, NULL, 0);
-		RTE_TEST_ASSERT(ret >= 0,
-				"Failed to unlink all queues port=%d", i);
-	}
-
-	uint32_t queue_count;
+		RTE_EVENT_DEV_ATTR_PORT_COUNT, &port_count),
+		"Port count get failed");
 
 	RTE_TEST_ASSERT_SUCCESS(rte_event_dev_attr_get(evdev,
-			    RTE_EVENT_DEV_ATTR_QUEUE_COUNT,
-			    &queue_count), "Queue count get failed");
+		RTE_EVENT_DEV_ATTR_QUEUE_COUNT, &queue_count),
+		"Queue count get failed");
 
 	nr_links = RTE_MIN(port_count, queue_count);
-	const unsigned int total_events = MAX_EVENTS / nr_links;
+	total_events = MAX_EVENTS / nr_links;
 
-	/* Link queue x to port x and inject events to queue x through port x */
 	for (i = 0; i < nr_links; i++) {
-		uint8_t queue = (uint8_t)i;
-
+		queue = i;
 		ret = rte_event_port_link(evdev, i, &queue, NULL, 1);
 		RTE_TEST_ASSERT(ret == 1, "Failed to link queue to port %d", i);
+	}
 
-		ret = inject_events(
-			0x100 /*flow_id */,
+	/* Link queue x to port x and inject events to queue x through port x */
+	for (i = 0; i < nr_links; i++) {
+		queue = i;
+		ret = inject_events(0x100 /*flow_id */,
 			RTE_EVENT_TYPE_CPU /* event_type */,
 			rte_rand() % 256 /* sub_event_type */,
 			rte_rand() % (RTE_SCHED_TYPE_PARALLEL + 1),
@@ -673,16 +715,21 @@ test_queue_to_port_single_link(void)
 			i /* port */,
 			total_events /* events */);
 		if (ret)
-			return -1;
+			return ret;
 	}
 
 	/* Verify the events generated from correct queue */
 	for (i = 0; i < nr_links; i++) {
 		ret = consume_events(i /* port */, total_events,
+				&dq_events,
 				validate_queue_to_port_single_link);
 		if (ret)
-			return -1;
+			return ret;
+		total_dqs += dq_events;
 	}
+	RTE_TEST_ASSERT(total_dqs == total_events * nr_links,
+		"total_dqs(%d) != total_events(%d) * nr_links(%d)",
+		total_dqs, total_events, nr_links);
 
 	return 0;
 }
@@ -693,8 +740,8 @@ validate_queue_to_port_multi_link(uint32_t index, uint8_t port,
 {
 	RTE_SET_USED(index);
 	RTE_TEST_ASSERT_EQUAL(port, (ev->queue_id & 0x1),
-				"queue mismatch enq=%d deq =%d",
-				port, ev->queue_id);
+		"queue mismatch enq=%d deq =%d",
+		port, ev->queue_id);
 	return 0;
 }
 
@@ -705,46 +752,48 @@ validate_queue_to_port_multi_link(uint32_t index, uint8_t port,
 static int
 test_queue_to_port_multi_link(void)
 {
-	int ret, port0_events = 0, port1_events = 0;
+	int ret;
 	uint8_t queue, port;
-	uint32_t nr_queues = 0;
-	uint32_t nr_ports = 0;
+	uint32_t nr_queues = 0, total_events, even_idx = 0, odd_idx = 0;
+	uint32_t nr_ports = 0, dq_events, port0_events = 0, port1_events = 0;
+	uint8_t even_queues[RTE_EVENT_MAX_QUEUES_PER_DEV];
+	uint8_t odd_queues[RTE_EVENT_MAX_QUEUES_PER_DEV];
 
 	RTE_TEST_ASSERT_SUCCESS(rte_event_dev_attr_get(evdev,
-			    RTE_EVENT_DEV_ATTR_QUEUE_COUNT,
-			    &nr_queues), "Queue count get failed");
-
+		RTE_EVENT_DEV_ATTR_QUEUE_COUNT, &nr_queues),
+		"Queue count get failed");
 	RTE_TEST_ASSERT_SUCCESS(rte_event_dev_attr_get(evdev,
-				RTE_EVENT_DEV_ATTR_QUEUE_COUNT,
-				&nr_queues), "Queue count get failed");
-	RTE_TEST_ASSERT_SUCCESS(rte_event_dev_attr_get(evdev,
-				RTE_EVENT_DEV_ATTR_PORT_COUNT,
-				&nr_ports), "Port count get failed");
+		RTE_EVENT_DEV_ATTR_PORT_COUNT, &nr_ports),
+		"Port count get failed");
 
 	if (nr_ports < 2) {
 		dpaa2_evdev_err("%s: Not enough ports to test ports=%d",
-				__func__, nr_ports);
-		return 0;
+			__func__, nr_ports);
+		return -ENODEV;
 	}
 
-	/* Unlink all connections that created in eventdev_setup */
-	for (port = 0; port < nr_ports; port++) {
-		ret = rte_event_port_unlink(evdev, port, NULL, 0);
-		RTE_TEST_ASSERT(ret >= 0, "Failed to unlink all queues port=%d",
-					port);
+	for (queue = 0; queue < nr_queues; queue++) {
+		if (queue & 0x1) {
+			odd_queues[odd_idx] = queue;
+			odd_idx++;
+		} else {
+			even_queues[even_idx] = queue;
+			even_idx++;
+		}
 	}
 
-	const unsigned int total_events = MAX_EVENTS / nr_queues;
+	ret = rte_event_port_link(evdev, 0, even_queues, NULL, even_idx);
+	RTE_TEST_ASSERT(ret >= 0, "Failed to link queues port0");
+	ret = rte_event_port_link(evdev, 1, odd_queues, NULL, odd_idx);
+	RTE_TEST_ASSERT(ret >= 0, "Failed to link queues port1");
+
+	total_events = MAX_EVENTS / nr_queues;
 
 	/* Link all even number of queues to port0 and odd numbers to port 1*/
 	for (queue = 0; queue < nr_queues; queue++) {
 		port = queue & 0x1;
-		ret = rte_event_port_link(evdev, port, &queue, NULL, 1);
-		RTE_TEST_ASSERT(ret == 1, "Failed to link queue=%d to port=%d",
-					queue, port);
 
-		ret = inject_events(
-			0x100 /*flow_id */,
+		ret = inject_events(0x100 /*flow_id */,
 			RTE_EVENT_TYPE_CPU /* event_type */,
 			rte_rand() % 256 /* sub_event_type */,
 			rte_rand() % (RTE_SCHED_TYPE_PARALLEL + 1),
@@ -752,7 +801,7 @@ test_queue_to_port_multi_link(void)
 			port /* port */,
 			total_events /* events */);
 		if (ret)
-			return -1;
+			return ret;
 
 		if (port == 0)
 			port0_events += total_events;
@@ -760,14 +809,23 @@ test_queue_to_port_multi_link(void)
 			port1_events += total_events;
 	}
 
-	ret = consume_events(0 /* port */, port0_events,
-				validate_queue_to_port_multi_link);
+	dq_events = 0;
+	ret = consume_events(0/* port */, port0_events, &dq_events,
+			validate_queue_to_port_multi_link);
 	if (ret)
-		return -1;
-	ret = consume_events(1 /* port */, port1_events,
-				validate_queue_to_port_multi_link);
+		return ret;
+	RTE_TEST_ASSERT(dq_events == port0_events,
+		"dq_events(%d) != port0_events(%d)",
+		dq_events, port0_events);
+
+	dq_events = 0;
+	ret = consume_events(1/* port */, port1_events, &dq_events,
+			validate_queue_to_port_multi_link);
 	if (ret)
-		return -1;
+		return ret;
+	RTE_TEST_ASSERT(dq_events == port1_events,
+		"dq_events(%d) != port1_events(%d)",
+		dq_events, port0_events);
 
 	return 0;
 }
@@ -805,7 +863,7 @@ test_eventdev_dpaa2(void)
 			test_multi_queue_enq_single_port_deq);
 	DPAA2_TEST_RUN(eventdev_setup, eventdev_teardown,
 			test_dev_stop_flush);
-	DPAA2_TEST_RUN(eventdev_setup, eventdev_teardown,
+	DPAA2_TEST_RUN(eventdev_atomic_port_setup, eventdev_teardown,
 			test_multi_queue_enq_multi_port_deq);
 	DPAA2_TEST_RUN(eventdev_setup, eventdev_teardown,
 			test_queue_to_port_single_link);
-- 
2.43.0

