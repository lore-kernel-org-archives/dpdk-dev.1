Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975AF606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:50:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B922427CA;
	Fri, 23 Oct 2026 15:45:16 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 948D040E37
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:45:00 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6AFFB200041;
 Fri, 23 Oct 2026 15:45:00 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 35A0D200045;
 Fri, 23 Oct 2026 15:45:00 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D738818000B5;
 Fri, 23 Oct 2026 21:44:58 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 63/65] event/dpaa2: support multi-port enqueue in
 selftest random event generator
Date: Fri, 23 Oct 2026 19:13:43 +0530
Message-ID: <20261023134346.37727-64-prashant.gupta_3@nxp.com>
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

The DPAA2 eventdev selftest helper generate_random_events() used to
hard-code port 0 both as the only port linked to all queues and as the
source port for every enqueued event. That worked for the single-port
tests but made it impossible to exercise the multi-port dequeue path
correctly: test_multi_queue_enq_multi_port_deq() was enqueuing all
events from port 0 while expecting workers on every port to drain them,
which does not match how real multi-port setups are configured.

Rework the helper and its callers so that ordering/port fan-out is
driven by the test, not baked into the generator:

 - generate_random_events() now takes an array of port ids and a port
   count. It links the full queue set to each of those ports and
   round-robins the source port of generated events across them
   (rte_rand() % nr_ports) instead of always using port 0.

 - test_multi_queue_enq_single_port_deq() and test_dev_stop_flush()
   pass a single-element {0} array, preserving their previous behavior.

 - test_multi_queue_enq_multi_port_deq() queries the device port count
   (capped at MAX_PORTS), builds the port id array, and only then
   generates events, so events are actually spread across all ports
   that workers will dequeue from.

Also split the teardown for test_dev_stop_flush: because the stop-flush
callback already frees mbufs back to the pool, calling the standard
eventdev_teardown() (which does extra cleanup assuming a live mempool
state) was fragile. Introduce eventdev_stop_flush_teardown() that only
frees the mempool, and wire it into the DPAA2_TEST_RUN entry for
test_dev_stop_flush.

No functional change for the single-port tests; the multi-port test
now actually tests multi-port enqueue + multi-port dequeue.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/event/dpaa2/dpaa2_eventdev_selftest.c | 44 ++++++++++++-------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/event/dpaa2/dpaa2_eventdev_selftest.c b/drivers/event/dpaa2/dpaa2_eventdev_selftest.c
index 569621dc39..6162932a5c 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev_selftest.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev_selftest.c
@@ -227,6 +227,12 @@ eventdev_teardown(void)
 	rte_mempool_free(eventdev_test_mempool);
 }
 
+static void
+eventdev_stop_flush_teardown(void)
+{
+	rte_mempool_free(eventdev_test_mempool);
+}
+
 static void
 update_event_and_validation_attr(struct rte_mbuf *m, struct rte_event *ev,
 	uint32_t flow_id, uint8_t event_type,
@@ -305,7 +311,8 @@ check_excess_events(uint8_t port)
 }
 
 static int
-generate_random_events(const unsigned int total_events)
+generate_random_events(const uint32_t total_events,
+	uint8_t port_ids[], uint32_t nr_ports)
 {
 	struct rte_event_dev_info info;
 	uint32_t queue_count, i;
@@ -320,10 +327,11 @@ generate_random_events(const unsigned int total_events)
 	for (i = 0; i < queue_count; i++)
 		queues[i] = i;
 
-	ret = rte_event_port_link(evdev, 0, queues, NULL,
-			queue_count);
-	RTE_TEST_ASSERT(ret >= 0, "Failed to link %d queues port0",
-		queue_count);
+	for (i = 0; i < nr_ports; i++) {
+		ret = rte_event_port_link(evdev, port_ids[i], queues, NULL, queue_count);
+		RTE_TEST_ASSERT(ret >= 0, "Failed to link %d queues port.%d",
+			queue_count, port_ids[i]);
+	}
 
 	ret = rte_event_dev_info_get(evdev, &info);
 	RTE_TEST_ASSERT_SUCCESS(ret, "Failed to get event dev info");
@@ -333,7 +341,7 @@ generate_random_events(const unsigned int total_events)
 			rte_rand() % 256 /* sub_event_type */,
 			rte_rand() % (RTE_SCHED_TYPE_PARALLEL + 1),
 			rte_rand() % queue_count,
-			0 /* port */,
+			rte_rand() % nr_ports,
 			1 /* events */);
 		if (ret)
 			return ret;
@@ -341,7 +349,6 @@ generate_random_events(const unsigned int total_events)
 	return ret;
 }
 
-
 static int
 validate_event(struct rte_event *ev)
 {
@@ -475,8 +482,9 @@ test_multi_queue_enq_single_port_deq(void)
 {
 	int ret;
 	uint32_t dq_events;
+	uint8_t port_id = 0;
 
-	ret = generate_random_events(MAX_EVENTS);
+	ret = generate_random_events(MAX_EVENTS, &port_id, 1);
 	if (ret)
 		return ret;
 
@@ -608,13 +616,10 @@ static int
 test_multi_queue_enq_multi_port_deq(void)
 {
 	const unsigned int total_events = MAX_EVENTS;
-	uint32_t nr_ports;
+	uint32_t nr_ports, i;
+	uint8_t port_ids[MAX_PORTS];
 	int ret;
 
-	ret = generate_random_events(total_events);
-	if (ret)
-		return ret;
-
 	RTE_TEST_ASSERT_SUCCESS(rte_event_dev_attr_get(evdev,
 		RTE_EVENT_DEV_ATTR_PORT_COUNT, &nr_ports),
 		"Port count get failed");
@@ -625,6 +630,14 @@ test_multi_queue_enq_multi_port_deq(void)
 			__func__, nr_ports, rte_lcore_count() - 1);
 		return -EINVAL;
 	}
+	if (nr_ports > MAX_PORTS)
+		nr_ports = MAX_PORTS;
+
+	for (i = 0; i < nr_ports; i++)
+		port_ids[i] = i;
+	ret = generate_random_events(total_events, port_ids, nr_ports);
+	if (ret)
+		return ret;
 
 	return launch_workers_and_wait(worker_multi_port_fn,
 				worker_multi_port_fn, total_events,
@@ -646,8 +659,9 @@ test_dev_stop_flush(void)
 {
 	unsigned int total_events = MAX_EVENTS, count = 0;
 	int ret;
+	uint8_t port_id = 0;
 
-	ret = generate_random_events(total_events);
+	ret = generate_random_events(total_events, &port_id, 1);
 	if (ret)
 		return -1;
 
@@ -861,7 +875,7 @@ test_eventdev_dpaa2(void)
 			test_simple_enqdeq_parallel);
 	DPAA2_TEST_RUN(eventdev_setup, eventdev_teardown,
 			test_multi_queue_enq_single_port_deq);
-	DPAA2_TEST_RUN(eventdev_setup, eventdev_teardown,
+	DPAA2_TEST_RUN(eventdev_setup, eventdev_stop_flush_teardown,
 			test_dev_stop_flush);
 	DPAA2_TEST_RUN(eventdev_atomic_port_setup, eventdev_teardown,
 			test_multi_queue_enq_multi_port_deq);
-- 
2.43.0

