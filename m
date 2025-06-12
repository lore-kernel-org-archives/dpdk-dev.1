Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFF7C71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 00:13:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 892AC4021F;
	Thu, 12 Jun 2025 02:13:47 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 8C59740156
 for <dev@dpdk.org>; Thu, 12 Jun 2025 02:13:45 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BLIOnb031124;
 Wed, 11 Jun 2025 17:13:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=+0PgVny1y/0/zSqZ5tX7NDL
 Hv1isltDXJOCuAQZL9RU=; b=ByqaM/psf0+3r5/GhwL7bk5bhEQpBIrlwFvEf6K
 vY/CKd54nwfEymcrZYtuIoV/4zNzivjbpgZIQeqav3WsRhuPAG2IQk1kMGX/89rl
 ottl4e3t3+4Ij0a2tqyvpXdldRJXt6bN62tF5I92uY00H82JGzanS0rlWku166mR
 1VCyz6zLtFDOITqU2Zk0t0uqOoudoSzOAl5YOe0RAhxiBt702oy3IirkdmZoHbhJ
 eR/a9wz9jhe3SlsAKTl3q27Rohfqr2Qlq6TCkAcVkAH6C4lzAj+kbhn2xiuGT93K
 Z8jQbKyVlxUVSIWW/zYgHUqIyH9lwG0/xLR5EBzFBXR7uzQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 477hkj09tk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Jun 2025 17:13:44 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 11 Jun 2025 17:13:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 11 Jun 2025 17:13:43 -0700
Received: from LYYJYPGKF4.marvell.com (unknown [10.28.164.240])
 by maili.marvell.com (Postfix) with ESMTP id 8BCAE3F704F;
 Wed, 11 Jun 2025 17:13:41 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, <thomas@monjalon.net>, <david.marchand@redhat.com>, 
 Pavan Nikhilesh <pbhagavatula@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH] test/event: fix event vector adapter timeouts
Date: Thu, 12 Jun 2025 05:43:38 +0530
Message-ID: <20250612001338.71098-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=brFMBFai c=1 sm=1 tr=0 ts=684a1bb8 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=wxKO5gzuCnPz8EOAqREA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: PNOgQwlmoApE-_hw5b18qvdjyiyeGg4y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDIwMyBTYWx0ZWRfX94HjK6oqA9tb
 IbVMswnOiB96o/gnorNvhzxMBh7VP8o+R1r2xvqn2+Azf1+BhmFmabqypEv1zrTDhS9hp/z5QyI
 JgAtQWufXn7dbOUvveRo4aO39BGzSpD2cM/pDO6hduALvvp4bm4GHV4FP3nIgSeJ1RevbL8GiV7
 6eQGwA7rPKzhEGYz4iwd6UlXtgwxT4z5wQFbRsW2JQqGyf+4vHFITPej4vcQEGqmxSWOyl9z7Lw
 5qpX3WzeMhzqBM2WOg9lfRy43lQtqWMVUxFs0IyKYmmgPgUsECXROc9PXNHVuBLxBWysQt2J+5r
 j8lZmtdDC/uQkVYPuNgQPGLXOhdIKHNIcocHqV1YEqEdd/mMt+jww7EGIOg1FAXHJwTdzbE+LtI
 Zj3e/omjBfHkWj8SUTyjV6Tx51Bu6uZirn0mB5sE2OKtUYCIehUiIiijmvz4KK9LbZOMILrD
X-Proofpoint-GUID: PNOgQwlmoApE-_hw5b18qvdjyiyeGg4y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_10,2025-06-10_01,2025-03-28_01
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

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

Update event vector adapter test to depend on service
core cycles instead of system cycles when waiting for
events.
Reorder event_type check to make sure event received
is a vector before dereferencing vector structure.

Bugzilla ID: 1720
Fixes: de09387f1313 ("eventdev/vector: add default software vector adapter")

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 app/test/test_event_vector_adapter.c | 111 +++++++++++++++++----------
 1 file changed, 70 insertions(+), 41 deletions(-)

diff --git a/app/test/test_event_vector_adapter.c b/app/test/test_event_vector_adapter.c
index 1441b0ff17bb..ae173c771589 100644
--- a/app/test/test_event_vector_adapter.c
+++ b/app/test/test_event_vector_adapter.c
@@ -10,7 +10,7 @@
 #include "test.h"
 
 #ifdef RTE_EXEC_ENV_WINDOWS
-static int __rte_unused
+static int
 test_event_vector_adapter(void)
 {
 	printf("event_vector_adapter not supported on Windows, skipping test\n");
@@ -39,12 +39,37 @@ static int adapter_slcore = -1;
 static uint8_t evdev;
 static bool using_services;
 static uint8_t vector_adptr_id;
+static uint32_t vector_service_id = UINT32_MAX;
+static uint32_t evdev_service_id = UINT32_MAX;
+static uint64_t vector_tmo_us;
 static uint8_t evdev_max_queues;
 static struct rte_mempool *vector_mp;
 
 static uint64_t objs[MAX_VECTOR_SIZE] = {0xDEADBEAF, 0xDEADBEEF, 0xDEADC0DE, 0xDEADCAFE,
 					 0xDEADFACE, 0xDEADFADE, 0xDEADFAAA, 0xDEADFAAB};
 
+static void
+wait_service_us(uint32_t service_id, uint64_t us)
+{
+#define USEC2TICK(__us, __freq) (((__us) * (__freq)) / 1E6)
+	uint64_t service_cycles;
+	uint64_t cycles = USEC2TICK(us, rte_get_timer_hz());
+
+	if (service_id == UINT32_MAX) {
+		rte_delay_us(us);
+		return;
+	}
+
+	rte_service_attr_reset_all(service_id);
+	do {
+		service_cycles = 0;
+		if (vector_service_id != UINT32_MAX)
+			rte_service_attr_get(vector_service_id, RTE_SERVICE_ATTR_CYCLES,
+					     &service_cycles);
+		rte_delay_us(us);
+	} while ((vector_service_id != UINT32_MAX && service_cycles < cycles));
+}
+
 static int
 test_event_vector_adapter_create_multi(void)
 {
@@ -121,7 +146,7 @@ test_event_vector_adapter_create(void)
 	conf.event_dev_id = evdev;
 	conf.socket_id = rte_socket_id();
 	conf.vector_sz = RTE_MIN(MAX_VECTOR_SIZE, info.max_vector_sz);
-	conf.vector_timeout_ns = info.max_vector_timeout_ns;
+	conf.vector_timeout_ns = RTE_MIN(1E6, info.max_vector_timeout_ns);
 	conf.vector_mp = vector_mp;
 
 	conf.ev.queue_id = 0;
@@ -150,7 +175,12 @@ test_event_vector_adapter_create(void)
 			    "Failed to map adapter service");
 		TEST_ASSERT(rte_service_runstate_set(service_id, 1) == 0,
 			    "Failed to start adapter service");
+		rte_service_set_stats_enable(service_id, 1);
+		vector_service_id = service_id;
 	}
+
+	vector_tmo_us = (conf.vector_timeout_ns / 1E3) * 2;
+
 	return TEST_SUCCESS;
 }
 
@@ -171,6 +201,7 @@ test_event_vector_adapter_free(void)
 				rte_service_lcore_del(adapter_slcore);
 			}
 			adapter_slcore = -1;
+			vector_service_id = UINT32_MAX;
 		}
 		rte_event_vector_adapter_destroy(adapter);
 	}
@@ -191,21 +222,22 @@ test_event_vector_adapter_enqueue(void)
 	ret = rte_event_vector_adapter_enqueue(adapter, objs, MAX_VECTOR_SIZE, 0);
 	TEST_ASSERT((ret == MAX_VECTOR_SIZE), "Failed to enqueue event vector %d", ret);
 
+	wait_service_us(vector_service_id, 1E2);
 	for (i = 0; i < MAX_RETRIES; i++) {
 		ret = rte_event_dequeue_burst(evdev, 0, &ev, 1, 0);
 		if (ret)
 			break;
 
-		rte_delay_ms(1);
+		wait_service_us(evdev_service_id, 1E2);
 	}
 
 	TEST_ASSERT((ret == 1), "Failed to dequeue event vector %d", ret);
+	TEST_ASSERT((ev.event_type == (RTE_EVENT_TYPE_VECTOR | RTE_EVENT_TYPE_CPU)),
+		    "Invalid event type %d", ev.event_type);
 
 	TEST_ASSERT((ev.vec->nb_elem == MAX_VECTOR_SIZE), "Incomplete event vector %d",
 		    ev.vec->nb_elem);
 	TEST_ASSERT((ev.queue_id == 0), "Invalid event type %d", ev.queue_id);
-	TEST_ASSERT((ev.event_type == (RTE_EVENT_TYPE_VECTOR | RTE_EVENT_TYPE_CPU)),
-		    "Invalid event type %d", ev.event_type);
 	TEST_ASSERT((ev.sched_type == RTE_SCHED_TYPE_PARALLEL), "Invalid sched type %d",
 		    ev.sched_type);
 
@@ -219,38 +251,33 @@ test_event_vector_adapter_enqueue(void)
 static int
 test_event_vector_adapter_enqueue_tmo(void)
 {
-	struct rte_event_vector_adapter_info info;
 	struct rte_event_vector_adapter *adapter;
 	uint16_t vec_sz = MAX_VECTOR_SIZE - 4;
 	struct rte_event ev;
 	int ret, i;
 
-	memset(&info, 0, sizeof(info));
-	ret = rte_event_vector_adapter_info_get(evdev, &info);
-	TEST_ASSERT_SUCCESS(ret, "Failed to get event vector adapter info");
-
 	adapter = rte_event_vector_adapter_lookup(vector_adptr_id);
 	TEST_ASSERT(adapter != NULL, "Failed to lookup event vector adapter");
 
 	ret = rte_event_vector_adapter_enqueue(adapter, objs, vec_sz, 0);
 	TEST_ASSERT((ret == vec_sz), "Failed to enqueue event vector %d", ret);
 
-	rte_delay_us(info.max_vector_timeout_ns / 1000);
+	wait_service_us(vector_service_id, vector_tmo_us);
 
 	for (i = 0; i < MAX_RETRIES; i++) {
 		ret = rte_event_dequeue_burst(evdev, 0, &ev, 1, 0);
 		if (ret)
 			break;
 
-		rte_delay_ms(1);
+		wait_service_us(evdev_service_id, 1E2);
 	}
 
 	TEST_ASSERT((ret == 1), "Failed to dequeue event vector %d", ret);
+	TEST_ASSERT((ev.event_type == (RTE_EVENT_TYPE_VECTOR | RTE_EVENT_TYPE_CPU)),
+		    "Invalid event type %d", ev.event_type);
 
 	TEST_ASSERT((ev.vec->nb_elem == vec_sz), "Incomplete event vector %d", ev.vec->nb_elem);
 	TEST_ASSERT((ev.queue_id == 0), "Invalid event type %d", ev.queue_id);
-	TEST_ASSERT((ev.event_type == (RTE_EVENT_TYPE_VECTOR | RTE_EVENT_TYPE_CPU)),
-		    "Invalid event type %d", ev.event_type);
 	TEST_ASSERT((ev.sched_type == RTE_SCHED_TYPE_PARALLEL), "Invalid sched type %d",
 		    ev.sched_type);
 
@@ -278,12 +305,13 @@ test_event_vector_adapter_enqueue_fallback(void)
 	ret = rte_event_vector_adapter_enqueue(adapter, objs, 1, 0);
 	TEST_ASSERT((ret == 1), "Failed to enqueue event vector %d", ret);
 
+	wait_service_us(vector_service_id, vector_tmo_us);
 	for (i = 0; i < MAX_RETRIES; i++) {
 		ret = rte_event_dequeue_burst(evdev, 0, &ev, 1, 0);
 		if (ret)
 			break;
 
-		rte_delay_ms(1);
+		wait_service_us(evdev_service_id, 1E2);
 	}
 
 	TEST_ASSERT((ret == 1), "Failed to dequeue event vector %d", ret);
@@ -300,17 +328,12 @@ test_event_vector_adapter_enqueue_fallback(void)
 static int
 test_event_vector_adapter_enqueue_sov(void)
 {
-	struct rte_event_vector_adapter_info info;
 	struct rte_event_vector_adapter *adapter;
 	uint16_t vec_sz = MAX_VECTOR_SIZE - 4;
 	struct rte_event ev;
 	uint32_t caps;
 	int ret, i;
 
-	memset(&info, 0, sizeof(info));
-	ret = rte_event_vector_adapter_info_get(evdev, &info);
-	TEST_ASSERT_SUCCESS(ret, "Failed to get event vector adapter info");
-
 	caps = 0;
 	ret = rte_event_vector_adapter_caps_get(evdev, &caps);
 	TEST_ASSERT_SUCCESS(ret, "Failed to get event vector adapter caps");
@@ -329,30 +352,34 @@ test_event_vector_adapter_enqueue_sov(void)
 	ret = rte_event_vector_adapter_enqueue(adapter, &objs[vec_sz], 2, RTE_EVENT_VECTOR_ENQ_SOV);
 	TEST_ASSERT((ret == 2), "Failed to enqueue event vector %d", ret);
 
+	wait_service_us(vector_service_id, vector_tmo_us);
 	for (i = 0; i < MAX_RETRIES; i++) {
 		ret = rte_event_dequeue_burst(evdev, 0, &ev, 1, 0);
 		if (ret)
 			break;
 
-		rte_delay_ms(1);
+		wait_service_us(evdev_service_id, 1E2);
 	}
 
+	TEST_ASSERT((ret == 1), "Failed to dequeue event vector %d", ret);
+	TEST_ASSERT((ev.event_type == (RTE_EVENT_TYPE_VECTOR | RTE_EVENT_TYPE_CPU)),
+		    "Invalid event type %d", ev.event_type);
+	TEST_ASSERT((ev.vec->nb_elem == vec_sz), "Incorrect event vector %d", ev.vec->nb_elem);
+
 	for (i = 0; i < vec_sz; i++)
 		TEST_ASSERT((ev.vec->u64s[i] == objs[i]), "Invalid object in event vector %" PRIx64,
 			    ev.vec->u64s[i]);
 
-	TEST_ASSERT((ret == 1), "Failed to dequeue event vector %d", ret);
-	TEST_ASSERT((ev.vec->nb_elem == vec_sz), "Incorrect event vector %d", ev.vec->nb_elem);
-
-	rte_delay_us(info.max_vector_timeout_ns / 1000);
 	for (i = 0; i < MAX_RETRIES; i++) {
 		ret = rte_event_dequeue_burst(evdev, 0, &ev, 1, 0);
 		if (ret)
 			break;
 
-		rte_delay_ms(1);
+		wait_service_us(evdev_service_id, 1E2);
 	}
 	TEST_ASSERT((ret == 1), "Failed to dequeue event vector %d", ret);
+	TEST_ASSERT((ev.event_type == (RTE_EVENT_TYPE_VECTOR | RTE_EVENT_TYPE_CPU)),
+		    "Invalid event type %d", ev.event_type);
 	TEST_ASSERT((ev.vec->nb_elem == 2), "Incorrect event vector %d", ev.vec->nb_elem);
 
 	for (i = 0; i < 2; i++)
@@ -365,17 +392,12 @@ test_event_vector_adapter_enqueue_sov(void)
 static int
 test_event_vector_adapter_enqueue_eov(void)
 {
-	struct rte_event_vector_adapter_info info;
 	struct rte_event_vector_adapter *adapter;
 	uint16_t vec_sz = MAX_VECTOR_SIZE - 4;
 	struct rte_event ev;
 	uint32_t caps;
 	int ret, i;
 
-	memset(&info, 0, sizeof(info));
-	ret = rte_event_vector_adapter_info_get(evdev, &info);
-	TEST_ASSERT_SUCCESS(ret, "Failed to get event vector adapter info");
-
 	caps = 0;
 	ret = rte_event_vector_adapter_caps_get(evdev, &caps);
 	TEST_ASSERT_SUCCESS(ret, "Failed to get event vector adapter caps");
@@ -399,10 +421,12 @@ test_event_vector_adapter_enqueue_eov(void)
 		if (ret)
 			break;
 
-		rte_delay_ms(1);
+		wait_service_us(evdev_service_id, 1E2);
 	}
 
 	TEST_ASSERT((ret == 1), "Failed to dequeue event vector %d", ret);
+	TEST_ASSERT((ev.event_type == (RTE_EVENT_TYPE_VECTOR | RTE_EVENT_TYPE_CPU)),
+		    "Invalid event type %d", ev.event_type);
 	TEST_ASSERT((ev.vec->nb_elem == vec_sz + 1), "Incorrect event vector %d", ev.vec->nb_elem);
 
 	ret = rte_event_vector_adapter_enqueue(adapter, objs, MAX_VECTOR_SIZE - 1, 0);
@@ -417,10 +441,12 @@ test_event_vector_adapter_enqueue_eov(void)
 		if (ret)
 			break;
 
-		rte_delay_ms(1);
+		wait_service_us(evdev_service_id, 1E2);
 	}
 
 	TEST_ASSERT((ret == 1), "Failed to dequeue event vector %d", ret);
+	TEST_ASSERT((ev.event_type == (RTE_EVENT_TYPE_VECTOR | RTE_EVENT_TYPE_CPU)),
+		    "Invalid event type %d", ev.event_type);
 	TEST_ASSERT((ev.vec->nb_elem == MAX_VECTOR_SIZE), "Incorrect event vector %d",
 		    ev.vec->nb_elem);
 
@@ -431,14 +457,17 @@ test_event_vector_adapter_enqueue_eov(void)
 	TEST_ASSERT((ev.vec->u64s[MAX_VECTOR_SIZE - 1] == objs[vec_sz]),
 		    "Invalid object in event vector %" PRIx64, ev.vec->u64s[MAX_VECTOR_SIZE - 1]);
 
+	wait_service_us(vector_service_id, vector_tmo_us);
 	for (i = 0; i < MAX_RETRIES; i++) {
 		ret = rte_event_dequeue_burst(evdev, 0, &ev, 1, 0);
 		if (ret)
 			break;
 
-		rte_delay_ms(1);
+		wait_service_us(evdev_service_id, 1E2);
 	}
 	TEST_ASSERT((ret == 1), "Failed to dequeue event vector %d", ret);
+	TEST_ASSERT((ev.event_type == (RTE_EVENT_TYPE_VECTOR | RTE_EVENT_TYPE_CPU)),
+		    "Invalid event type %d", ev.event_type);
 	TEST_ASSERT((ev.vec->nb_elem == vec_sz - 1), "Incorrect event vector %d", ev.vec->nb_elem);
 
 	for (i = 0; i < vec_sz - 1; i++)
@@ -483,7 +512,7 @@ test_event_vector_adapter_enqueue_sov_eov(void)
 		if (ret)
 			break;
 
-		rte_delay_ms(1);
+		wait_service_us(evdev_service_id, 1E2);
 	}
 
 	TEST_ASSERT((ret == 1), "Failed to dequeue event vector %d", ret);
@@ -504,7 +533,7 @@ test_event_vector_adapter_enqueue_sov_eov(void)
 		if (ret)
 			break;
 
-		rte_delay_ms(1);
+		wait_service_us(evdev_service_id, 1E2);
 	}
 	TEST_ASSERT((ret == 1), "Failed to dequeue event vector %d", ret);
 	if (info.min_vector_sz > 1)
@@ -538,7 +567,7 @@ test_event_vector_adapter_enqueue_flush(void)
 		if (ret)
 			break;
 
-		rte_delay_ms(1);
+		wait_service_us(evdev_service_id, 1E2);
 	}
 
 	TEST_ASSERT((ret == 1), "Failed to dequeue event vector %d", ret);
@@ -598,6 +627,8 @@ eventdev_setup(void)
 				    "Failed to map evdev service");
 		TEST_ASSERT_SUCCESS(rte_service_runstate_set(service_id, 1),
 				    "Failed to start evdev service");
+		rte_service_set_stats_enable(service_id, 1);
+		evdev_service_id = service_id;
 	}
 
 	ret = rte_event_dev_start(evdev);
@@ -669,7 +700,7 @@ static struct unit_test_suite functional_testsuite = {
 	}
 };
 
-static int __rte_unused
+static int
 test_event_vector_adapter(void)
 {
 	return unit_test_suite_runner(&functional_testsuite);
@@ -677,6 +708,4 @@ test_event_vector_adapter(void)
 
 #endif
 
-/* disabled because of reported failures, waiting for a fix
- * REGISTER_FAST_TEST(event_vector_adapter_autotest, true, true, test_event_vector_adapter);
- */
+REGISTER_FAST_TEST(event_vector_adapter_autotest, true, true, test_event_vector_adapter);
-- 
2.39.5 (Apple Git-154)

