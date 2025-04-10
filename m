Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80FCC369A9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 18:01:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF97B40A73;
	Thu, 10 Apr 2025 20:01:21 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id E535640A6E
 for <dev@dpdk.org>; Thu, 10 Apr 2025 20:01:19 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AF39oK009187;
 Thu, 10 Apr 2025 11:01:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=U
 NzC8IgDyqXBXCIiMDAqi3HjU6JSr1OdMR+cFjZkfWA=; b=UPHAWBgdQjFm7NND2
 AGtJbCqus22IcMvamW17dhYuRKt8hD0TzxttDOdF9TSvzIq/iSyU5MA+rItkGKYB
 IdDmH7VNxWtDOwyXqZHyQbomKFVtY2aTHkzY7y8fQnJ4L3vuQl0zROIwrBDe/bFv
 UdFm2vvSMbqozHSePfAmjS315n1MPQlt8z+NTxt86AJl92PHrH9MFlyfOY96FzLM
 lXK+5DlsgBGAmucHdgpuGvmgKeYfkourQSNA9VeyJbvMGLGdHbiwtvSupXoSRl/V
 OHPOEnks8pYjZLONNJ8OhQribZBDySz16Y9OLR3grQBMJDdKqMQPb8bnObzdUMm3
 ppjDQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45wp0c44sx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Apr 2025 11:01:18 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 10 Apr 2025 11:01:17 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 10 Apr 2025 11:01:17 -0700
Received: from MININT-80QBFE8.corp.innovium.com (unknown [10.28.164.118])
 by maili.marvell.com (Postfix) with ESMTP id 5C9C13F7065;
 Thu, 10 Apr 2025 11:01:12 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, <pravin.pathak@intel.com>, <hemant.agrawal@nxp.com>, 
 <sachin.saxena@nxp.com>, <mattias.ronnblom@ericsson.com>,
 <liangma@liangbit.com>, <peter.mccarthy@intel.com>,
 <harry.van.haaren@intel.com>, <erik.g.carrillo@intel.com>,
 <abhinandan.gujjar@intel.com>, <amitprakashs@marvell.com>,
 <s.v.naga.harish.k@intel.com>, <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [PATCH 2/3] eventdev: add default software vector adapter
Date: Thu, 10 Apr 2025 23:30:40 +0530
Message-ID: <20250410180056.10368-3-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250410180056.10368-1-pbhagavatula@marvell.com>
References: <20250326131441.5965-2-pbhagavatula@marvell.com>
 <20250410180056.10368-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: z3rTGYkxotpIdr4g_P8M3HsYWiBcU11O
X-Proofpoint-ORIG-GUID: z3rTGYkxotpIdr4g_P8M3HsYWiBcU11O
X-Authority-Analysis: v=2.4 cv=H47bw/Yi c=1 sm=1 tr=0 ts=67f8076e cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=tdHoNQqk6jB-gyBn54MA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_05,2025-04-10_01,2024-11-22_01
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

When event device PMD doesn't support vector adapter,
the library will fallback to software implementation
which relies on service core to check for timeouts
and vectorizes the objects on enqueue.

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 app/test/meson.build                    |   1 +
 app/test/test_event_vector_adapter.c    | 682 ++++++++++++++++++++++++
 lib/eventdev/eventdev_pmd.h             |   2 +
 lib/eventdev/rte_event_vector_adapter.c | 392 ++++++++++++++
 lib/eventdev/rte_eventdev.c             |   2 +
 5 files changed, 1079 insertions(+)
 create mode 100644 app/test/test_event_vector_adapter.c

diff --git a/app/test/meson.build b/app/test/meson.build
index b6285a6b45..0686f3c1f2 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -79,6 +79,7 @@ source_file_deps = {
     'test_event_eth_tx_adapter.c': ['bus_vdev', 'ethdev', 'net_ring', 'eventdev'],
     'test_event_ring.c': ['eventdev'],
     'test_event_timer_adapter.c': ['ethdev', 'eventdev', 'bus_vdev'],
+    'test_event_vector_adapter.c': ['eventdev', 'bus_vdev'],
     'test_eventdev.c': ['eventdev', 'bus_vdev'],
     'test_external_mem.c': [],
     'test_fbarray.c': [],
diff --git a/app/test/test_event_vector_adapter.c b/app/test/test_event_vector_adapter.c
new file mode 100644
index 0000000000..8754789bef
--- /dev/null
+++ b/app/test/test_event_vector_adapter.c
@@ -0,0 +1,682 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Marvell International Ltd.
+ */
+
+#include <string.h>
+
+#include <rte_common.h>
+#include <rte_malloc.h>
+#include <rte_mempool.h>
+#include <rte_random.h>
+
+#include "test.h"
+
+#ifdef RTE_EXEC_ENV_WINDOWS
+static int
+test_event_vector_adapter(void)
+{
+	printf("event_vector_adapter not supported on Windows, skipping test\n");
+	return TEST_SKIPPED;
+}
+
+#else
+
+#include <rte_bus_vdev.h>
+#include <rte_event_vector_adapter.h>
+#include <rte_eventdev.h>
+#include <rte_launch.h>
+#include <rte_lcore.h>
+#include <rte_mempool.h>
+#include <rte_per_lcore.h>
+#include <rte_random.h>
+#include <rte_service.h>
+#include <stdbool.h>
+
+#define MAX_VECTOR_SIZE 8
+#define MAX_EVENTS	512
+#define MAX_RETRIES	16
+
+static int sw_slcore = -1;
+static int adapter_slcore = -1;
+static uint8_t evdev;
+static bool using_services;
+static uint8_t vector_adptr_id;
+static uint8_t evdev_max_queues;
+static struct rte_mempool *vector_mp;
+
+static uint64_t objs[MAX_VECTOR_SIZE] = {0xDEADBEAF, 0xDEADBEEF, 0xDEADC0DE, 0xDEADCAFE,
+					 0xDEADFACE, 0xDEADFADE, 0xDEADFAAA, 0xDEADFAAB};
+
+static int
+test_event_vector_adapter_create_multi(void)
+{
+	struct rte_event_vector_adapter *adapter[RTE_EVENT_MAX_QUEUES_PER_DEV]
+						[RTE_EVENT_VECTOR_ADAPTER_MAX_INSTANCE_PER_QUEUE];
+	struct rte_event_vector_adapter_conf conf;
+	struct rte_event_vector_adapter_info info;
+	int ret, i, j;
+
+	memset(&conf, 0, sizeof(conf));
+	memset(&info, 0, sizeof(info));
+
+	ret = rte_event_vector_adapter_info_get(evdev, &info);
+	TEST_ASSERT_SUCCESS(ret, "Failed to get event vector adapter info");
+
+	vector_mp = rte_event_vector_pool_create("vector_mp", MAX_EVENTS, 0, MAX_VECTOR_SIZE,
+						 rte_socket_id());
+
+	TEST_ASSERT(vector_mp != NULL, "Failed to create mempool");
+
+	conf.event_dev_id = evdev;
+	conf.socket_id = rte_socket_id();
+	conf.vector_sz = RTE_MIN(MAX_VECTOR_SIZE, info.max_vector_sz);
+	conf.vector_timeout_ns = info.max_vector_timeout_ns;
+	conf.vector_mp = vector_mp;
+
+	conf.ev.queue_id = 0;
+	conf.ev.event_type = RTE_EVENT_TYPE_VECTOR | RTE_EVENT_TYPE_CPU;
+	conf.ev.sched_type = RTE_SCHED_TYPE_PARALLEL;
+
+	for (i = 0; i < evdev_max_queues; i++) {
+		for (j = 0; j < info.max_vector_adapters_per_event_queue; j++) {
+			conf.ev.queue_id = j;
+			adapter[i][j] = rte_event_vector_adapter_create(&conf);
+			TEST_ASSERT(adapter[i][j] != NULL, "Failed to create event vector adapter");
+		}
+	}
+
+	for (i = 0; i < evdev_max_queues; i++)
+		for (j = 0; j < info.max_vector_adapters_per_event_queue; j++)
+			TEST_ASSERT(adapter[i][j] == rte_event_vector_adapter_lookup(
+							     adapter[i][j]->adapter_id),
+				    "Failed to lookup event vector adapter");
+
+	for (i = 0; i < evdev_max_queues; i++)
+		for (j = 0; j < info.max_vector_adapters_per_event_queue; j++)
+			rte_event_vector_adapter_destroy(adapter[i][j]);
+
+	rte_mempool_free(vector_mp);
+	vector_mp = NULL;
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_event_vector_adapter_create(void)
+{
+	struct rte_event_vector_adapter_conf conf;
+	struct rte_event_vector_adapter_info info;
+	struct rte_event_vector_adapter *adapter;
+	uint32_t service_id;
+	int ret;
+
+	memset(&conf, 0, sizeof(conf));
+	memset(&info, 0, sizeof(info));
+
+	ret = rte_event_vector_adapter_info_get(evdev, &info);
+	TEST_ASSERT_SUCCESS(ret, "Failed to get event vector adapter info");
+
+	vector_mp = rte_event_vector_pool_create("vector_mp", MAX_EVENTS, 0, MAX_VECTOR_SIZE,
+						 rte_socket_id());
+	TEST_ASSERT(vector_mp != NULL, "Failed to create mempool");
+
+	conf.event_dev_id = evdev;
+	conf.socket_id = rte_socket_id();
+	conf.vector_sz = RTE_MIN(MAX_VECTOR_SIZE, info.max_vector_sz);
+	conf.vector_timeout_ns = info.max_vector_timeout_ns;
+	conf.vector_mp = vector_mp;
+
+	conf.ev.queue_id = 0;
+	conf.ev.event_type = RTE_EVENT_TYPE_VECTOR | RTE_EVENT_TYPE_CPU;
+	conf.ev.sched_type = RTE_SCHED_TYPE_PARALLEL;
+
+	conf.ev_fallback.event_type = RTE_EVENT_TYPE_CPU;
+	adapter = rte_event_vector_adapter_create(&conf);
+	TEST_ASSERT(adapter != NULL, "Failed to create event vector adapter");
+
+	vector_adptr_id = adapter->adapter_id;
+
+	TEST_ASSERT(adapter == rte_event_vector_adapter_lookup(vector_adptr_id),
+		    "Failed to lookup event vector adapter");
+
+	if (rte_event_vector_adapter_service_id_get(adapter, &service_id) == 0) {
+		if (sw_slcore < 0) {
+			adapter_slcore = rte_get_next_lcore(sw_slcore, 1, 0);
+			TEST_ASSERT_SUCCESS(rte_service_lcore_add(adapter_slcore),
+					    "Failed to add service core");
+			TEST_ASSERT_SUCCESS(rte_service_lcore_start(adapter_slcore),
+					    "Failed to start service core");
+		} else
+			adapter_slcore = sw_slcore;
+		TEST_ASSERT(rte_service_map_lcore_set(service_id, adapter_slcore, 1) == 0,
+			    "Failed to map adapter service");
+		TEST_ASSERT(rte_service_runstate_set(service_id, 1) == 0,
+			    "Failed to start adapter service");
+	}
+	return TEST_SUCCESS;
+}
+
+static void
+test_event_vector_adapter_free(void)
+{
+	struct rte_event_vector_adapter *adapter;
+	uint32_t service_id;
+
+	adapter = rte_event_vector_adapter_lookup(vector_adptr_id);
+
+	if (adapter != NULL) {
+		if (rte_event_vector_adapter_service_id_get(adapter, &service_id) == 0) {
+			rte_service_runstate_set(service_id, 0);
+			rte_service_map_lcore_set(service_id, adapter_slcore, 0);
+			if (adapter_slcore != sw_slcore) {
+				rte_service_lcore_stop(adapter_slcore);
+				rte_service_lcore_del(adapter_slcore);
+			}
+			adapter_slcore = -1;
+		}
+		rte_event_vector_adapter_destroy(adapter);
+	}
+	rte_mempool_free(vector_mp);
+	vector_mp = NULL;
+}
+
+static int
+test_event_vector_adapter_enqueue(void)
+{
+	struct rte_event_vector_adapter *adapter;
+	struct rte_event ev;
+	int ret, i;
+
+	adapter = rte_event_vector_adapter_lookup(vector_adptr_id);
+	TEST_ASSERT(adapter != NULL, "Failed to lookup event vector adapter");
+
+	ret = rte_event_vector_adapter_enqueue(adapter, objs, MAX_VECTOR_SIZE, 0);
+	TEST_ASSERT((ret == MAX_VECTOR_SIZE), "Failed to enqueue event vector %d", ret);
+
+	for (i = 0; i < MAX_RETRIES; i++) {
+		ret = rte_event_dequeue_burst(evdev, 0, &ev, 1, 0);
+		if (ret)
+			break;
+
+		rte_delay_ms(1);
+	}
+
+	TEST_ASSERT((ret == 1), "Failed to dequeue event vector %d", ret);
+
+	TEST_ASSERT((ev.vec->nb_elem == MAX_VECTOR_SIZE), "Incomplete event vector %d",
+		    ev.vec->nb_elem);
+	TEST_ASSERT((ev.queue_id == 0), "Invalid event type %d", ev.queue_id);
+	TEST_ASSERT((ev.event_type == (RTE_EVENT_TYPE_VECTOR | RTE_EVENT_TYPE_CPU)),
+		    "Invalid event type %d", ev.event_type);
+	TEST_ASSERT((ev.sched_type == RTE_SCHED_TYPE_PARALLEL), "Invalid sched type %d",
+		    ev.sched_type);
+
+	for (i = 0; i < MAX_VECTOR_SIZE; i++)
+		TEST_ASSERT((ev.vec->u64s[i] == objs[i]), "Invalid object in event vector %" PRIx64,
+			    ev.vec->u64s[i]);
+	rte_mempool_put(rte_mempool_from_obj(ev.vec), ev.vec);
+	return TEST_SUCCESS;
+}
+
+static int
+test_event_vector_adapter_enqueue_tmo(void)
+{
+	struct rte_event_vector_adapter_info info;
+	struct rte_event_vector_adapter *adapter;
+	uint16_t vec_sz = MAX_VECTOR_SIZE - 4;
+	struct rte_event ev;
+	int ret, i;
+
+	memset(&info, 0, sizeof(info));
+	ret = rte_event_vector_adapter_info_get(evdev, &info);
+	TEST_ASSERT_SUCCESS(ret, "Failed to get event vector adapter info");
+
+	adapter = rte_event_vector_adapter_lookup(vector_adptr_id);
+	TEST_ASSERT(adapter != NULL, "Failed to lookup event vector adapter");
+
+	ret = rte_event_vector_adapter_enqueue(adapter, objs, vec_sz, 0);
+	TEST_ASSERT((ret == vec_sz), "Failed to enqueue event vector %d", ret);
+
+	rte_delay_us(info.max_vector_timeout_ns / 1000);
+
+	for (i = 0; i < MAX_RETRIES; i++) {
+		ret = rte_event_dequeue_burst(evdev, 0, &ev, 1, 0);
+		if (ret)
+			break;
+
+		rte_delay_ms(1);
+	}
+
+	TEST_ASSERT((ret == 1), "Failed to dequeue event vector %d", ret);
+
+	TEST_ASSERT((ev.vec->nb_elem == vec_sz), "Incomplete event vector %d", ev.vec->nb_elem);
+	TEST_ASSERT((ev.queue_id == 0), "Invalid event type %d", ev.queue_id);
+	TEST_ASSERT((ev.event_type == (RTE_EVENT_TYPE_VECTOR | RTE_EVENT_TYPE_CPU)),
+		    "Invalid event type %d", ev.event_type);
+	TEST_ASSERT((ev.sched_type == RTE_SCHED_TYPE_PARALLEL), "Invalid sched type %d",
+		    ev.sched_type);
+
+	for (i = 0; i < vec_sz; i++)
+		TEST_ASSERT((ev.vec->u64s[i] == objs[i]), "Invalid object in event vector %" PRIx64,
+			    ev.vec->u64s[i]);
+	rte_mempool_put(rte_mempool_from_obj(ev.vec), ev.vec);
+	return TEST_SUCCESS;
+}
+
+static int
+test_event_vector_adapter_enqueue_fallback(void)
+{
+	struct rte_event_vector_adapter *adapter;
+	uint64_t vec[MAX_EVENTS];
+	struct rte_event ev;
+	int ret, i;
+
+	adapter = rte_event_vector_adapter_lookup(vector_adptr_id);
+	TEST_ASSERT(adapter != NULL, "Failed to lookup event vector adapter");
+
+	ret = rte_mempool_get_bulk(vector_mp, (void **)vec, MAX_EVENTS);
+	TEST_ASSERT(ret == 0, "Failed to get mempool objects %d", ret);
+
+	ret = rte_event_vector_adapter_enqueue(adapter, objs, 1, 0);
+	TEST_ASSERT((ret == 1), "Failed to enqueue event vector %d", ret);
+
+	for (i = 0; i < MAX_RETRIES; i++) {
+		ret = rte_event_dequeue_burst(evdev, 0, &ev, 1, 0);
+		if (ret)
+			break;
+
+		rte_delay_ms(1);
+	}
+
+	TEST_ASSERT((ret == 1), "Failed to dequeue event vector %d", ret);
+	TEST_ASSERT((ev.event_type == RTE_EVENT_TYPE_CPU), "Incorrect fallback event type %d",
+		    ev.event_type);
+	TEST_ASSERT((ev.sched_type == RTE_SCHED_TYPE_PARALLEL), "Invalid sched type %d",
+		    ev.sched_type);
+
+	rte_mempool_put_bulk(vector_mp, (void **)vec, MAX_EVENTS);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_event_vector_adapter_enqueue_sov(void)
+{
+	struct rte_event_vector_adapter_info info;
+	struct rte_event_vector_adapter *adapter;
+	uint16_t vec_sz = MAX_VECTOR_SIZE - 4;
+	struct rte_event ev;
+	uint32_t caps;
+	int ret, i;
+
+	memset(&info, 0, sizeof(info));
+	ret = rte_event_vector_adapter_info_get(evdev, &info);
+	TEST_ASSERT_SUCCESS(ret, "Failed to get event vector adapter info");
+
+	caps = 0;
+	ret = rte_event_vector_adapter_caps_get(evdev, &caps);
+	TEST_ASSERT_SUCCESS(ret, "Failed to get event vector adapter caps");
+
+	if (!(caps & RTE_EVENT_VECTOR_ADAPTER_CAP_SOV_EOV)) {
+		printf("SOV/EOV not supported, skipping test\n");
+		return TEST_SKIPPED;
+	}
+
+	adapter = rte_event_vector_adapter_lookup(vector_adptr_id);
+	TEST_ASSERT(adapter != NULL, "Failed to lookup event vector adapter");
+
+	ret = rte_event_vector_adapter_enqueue(adapter, objs, vec_sz, 0);
+	TEST_ASSERT((ret == vec_sz), "Failed to enqueue event vector %d", ret);
+
+	ret = rte_event_vector_adapter_enqueue(adapter, &objs[vec_sz], 2, RTE_EVENT_VECTOR_ENQ_SOV);
+	TEST_ASSERT((ret == 2), "Failed to enqueue event vector %d", ret);
+
+	for (i = 0; i < MAX_RETRIES; i++) {
+		ret = rte_event_dequeue_burst(evdev, 0, &ev, 1, 0);
+		if (ret)
+			break;
+
+		rte_delay_ms(1);
+	}
+
+	for (i = 0; i < vec_sz; i++)
+		TEST_ASSERT((ev.vec->u64s[i] == objs[i]), "Invalid object in event vector %" PRIx64,
+			    ev.vec->u64s[i]);
+
+	TEST_ASSERT((ret == 1), "Failed to dequeue event vector %d", ret);
+	TEST_ASSERT((ev.vec->nb_elem == vec_sz), "Incorrect event vector %d", ev.vec->nb_elem);
+
+	rte_delay_us(info.max_vector_timeout_ns / 1000);
+	for (i = 0; i < MAX_RETRIES; i++) {
+		ret = rte_event_dequeue_burst(evdev, 0, &ev, 1, 0);
+		if (ret)
+			break;
+
+		rte_delay_ms(1);
+	}
+	TEST_ASSERT((ret == 1), "Failed to dequeue event vector %d", ret);
+	TEST_ASSERT((ev.vec->nb_elem == 2), "Incorrect event vector %d", ev.vec->nb_elem);
+
+	for (i = 0; i < 2; i++)
+		TEST_ASSERT((ev.vec->u64s[i] == objs[vec_sz + i]),
+			    "Invalid object in event vector %" PRIx64, ev.vec->u64s[i]);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_event_vector_adapter_enqueue_eov(void)
+{
+	struct rte_event_vector_adapter_info info;
+	struct rte_event_vector_adapter *adapter;
+	uint16_t vec_sz = MAX_VECTOR_SIZE - 4;
+	struct rte_event ev;
+	uint32_t caps;
+	int ret, i;
+
+	memset(&info, 0, sizeof(info));
+	ret = rte_event_vector_adapter_info_get(evdev, &info);
+	TEST_ASSERT_SUCCESS(ret, "Failed to get event vector adapter info");
+
+	caps = 0;
+	ret = rte_event_vector_adapter_caps_get(evdev, &caps);
+	TEST_ASSERT_SUCCESS(ret, "Failed to get event vector adapter caps");
+
+	if (!(caps & RTE_EVENT_VECTOR_ADAPTER_CAP_SOV_EOV)) {
+		printf("SOV/EOV not supported, skipping test\n");
+		return TEST_SKIPPED;
+	}
+
+	adapter = rte_event_vector_adapter_lookup(vector_adptr_id);
+	TEST_ASSERT(adapter != NULL, "Failed to lookup event vector adapter");
+
+	ret = rte_event_vector_adapter_enqueue(adapter, objs, vec_sz, 0);
+	TEST_ASSERT((ret == vec_sz), "Failed to enqueue event vector %d", ret);
+
+	ret = rte_event_vector_adapter_enqueue(adapter, &objs[vec_sz], 1, RTE_EVENT_VECTOR_ENQ_EOV);
+	TEST_ASSERT((ret == 1), "Failed to enqueue event vector %d", ret);
+
+	for (i = 0; i < MAX_RETRIES; i++) {
+		ret = rte_event_dequeue_burst(evdev, 0, &ev, 1, 0);
+		if (ret)
+			break;
+
+		rte_delay_ms(1);
+	}
+
+	TEST_ASSERT((ret == 1), "Failed to dequeue event vector %d", ret);
+	TEST_ASSERT((ev.vec->nb_elem == vec_sz + 1), "Incorrect event vector %d", ev.vec->nb_elem);
+
+	ret = rte_event_vector_adapter_enqueue(adapter, objs, MAX_VECTOR_SIZE - 1, 0);
+	TEST_ASSERT((ret == MAX_VECTOR_SIZE - 1), "Failed to enqueue event vector %d", ret);
+
+	ret = rte_event_vector_adapter_enqueue(adapter, &objs[vec_sz], vec_sz,
+					       RTE_EVENT_VECTOR_ENQ_EOV);
+	TEST_ASSERT((ret == vec_sz), "Failed to enqueue event vector %d", ret);
+
+	for (i = 0; i < MAX_RETRIES; i++) {
+		ret = rte_event_dequeue_burst(evdev, 0, &ev, 1, 0);
+		if (ret)
+			break;
+
+		rte_delay_ms(1);
+	}
+
+	TEST_ASSERT((ret == 1), "Failed to dequeue event vector %d", ret);
+	TEST_ASSERT((ev.vec->nb_elem == MAX_VECTOR_SIZE), "Incorrect event vector %d",
+		    ev.vec->nb_elem);
+
+	for (i = 0; i < MAX_VECTOR_SIZE - 1; i++)
+		TEST_ASSERT((ev.vec->u64s[i] == objs[i]), "Invalid object in event vector %" PRIx64,
+			    ev.vec->u64s[i]);
+
+	TEST_ASSERT((ev.vec->u64s[MAX_VECTOR_SIZE - 1] == objs[vec_sz]),
+		    "Invalid object in event vector %" PRIx64, ev.vec->u64s[MAX_VECTOR_SIZE - 1]);
+
+	for (i = 0; i < MAX_RETRIES; i++) {
+		ret = rte_event_dequeue_burst(evdev, 0, &ev, 1, 0);
+		if (ret)
+			break;
+
+		rte_delay_ms(1);
+	}
+	TEST_ASSERT((ret == 1), "Failed to dequeue event vector %d", ret);
+	TEST_ASSERT((ev.vec->nb_elem == vec_sz - 1), "Incorrect event vector %d", ev.vec->nb_elem);
+
+	for (i = 0; i < vec_sz - 1; i++)
+		TEST_ASSERT((ev.vec->u64s[i] == objs[vec_sz + i + 1]),
+			    "Invalid object in event vector %" PRIx64, ev.vec->u64s[i]);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_event_vector_adapter_enqueue_sov_eov(void)
+{
+	struct rte_event_vector_adapter_info info;
+	struct rte_event_vector_adapter *adapter;
+	uint16_t vec_sz = MAX_VECTOR_SIZE - 4;
+	struct rte_event ev;
+	uint32_t caps;
+	int ret, i;
+
+	memset(&info, 0, sizeof(info));
+	ret = rte_event_vector_adapter_info_get(evdev, &info);
+	TEST_ASSERT_SUCCESS(ret, "Failed to get event vector adapter info");
+
+	caps = 0;
+	ret = rte_event_vector_adapter_caps_get(evdev, &caps);
+	TEST_ASSERT_SUCCESS(ret, "Failed to get event vector adapter caps");
+
+	if (!(caps & RTE_EVENT_VECTOR_ADAPTER_CAP_SOV_EOV)) {
+		printf("SOV/EOV not supported, skipping test\n");
+		return TEST_SKIPPED;
+	}
+
+	adapter = rte_event_vector_adapter_lookup(vector_adptr_id);
+	TEST_ASSERT(adapter != NULL, "Failed to lookup event vector adapter");
+
+	ret = rte_event_vector_adapter_enqueue(adapter, objs, vec_sz,
+					       RTE_EVENT_VECTOR_ENQ_SOV | RTE_EVENT_VECTOR_ENQ_EOV);
+	TEST_ASSERT((ret == vec_sz), "Failed to enqueue event vector %d", ret);
+
+	for (i = 0; i < MAX_RETRIES; i++) {
+		ret = rte_event_dequeue_burst(evdev, 0, &ev, 1, 0);
+		if (ret)
+			break;
+
+		rte_delay_ms(1);
+	}
+
+	TEST_ASSERT((ret == 1), "Failed to dequeue event vector %d", ret);
+	TEST_ASSERT((ev.event_type == (RTE_EVENT_TYPE_CPU | RTE_EVENT_TYPE_VECTOR)),
+		    "Incorrect event type %d", ev.event_type);
+	TEST_ASSERT((ev.vec->nb_elem == vec_sz), "Incorrect event vector %d", ev.vec->nb_elem);
+
+	for (i = 0; i < vec_sz; i++)
+		TEST_ASSERT((ev.vec->u64s[i] == objs[i]), "Invalid object in event vector %" PRIx64,
+			    ev.vec->u64s[i]);
+
+	ret = rte_event_vector_adapter_enqueue(adapter, objs, 1,
+					       RTE_EVENT_VECTOR_ENQ_SOV | RTE_EVENT_VECTOR_ENQ_EOV);
+	TEST_ASSERT((ret == 1), "Failed to enqueue event vector %d", ret);
+
+	for (i = 0; i < MAX_RETRIES; i++) {
+		ret = rte_event_dequeue_burst(evdev, 0, &ev, 1, 0);
+		if (ret)
+			break;
+
+		rte_delay_ms(1);
+	}
+	TEST_ASSERT((ret == 1), "Failed to dequeue event vector %d", ret);
+	if (info.min_vector_sz > 1)
+		TEST_ASSERT((ev.event_type == RTE_EVENT_TYPE_CPU), "Incorrect event type %d",
+			    ev.event_type);
+	else
+		TEST_ASSERT((ev.event_type == (RTE_EVENT_TYPE_CPU | RTE_EVENT_TYPE_VECTOR)),
+			    "Incorrect event type %d", ev.event_type);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_event_vector_adapter_enqueue_flush(void)
+{
+	struct rte_event_vector_adapter *adapter;
+	struct rte_event ev;
+	int ret, i;
+
+	adapter = rte_event_vector_adapter_lookup(vector_adptr_id);
+	TEST_ASSERT(adapter != NULL, "Failed to lookup event vector adapter");
+
+	ret = rte_event_vector_adapter_enqueue(adapter, objs, MAX_VECTOR_SIZE - 1, 0);
+	TEST_ASSERT((ret == MAX_VECTOR_SIZE - 1), "Failed to enqueue event vector %d", ret);
+
+	ret = rte_event_vector_adapter_enqueue(adapter, NULL, 0, RTE_EVENT_VECTOR_ENQ_FLUSH);
+	TEST_ASSERT((ret == 0), "Failed to enqueue event vector %d", ret);
+
+	for (i = 0; i < MAX_RETRIES; i++) {
+		ret = rte_event_dequeue_burst(evdev, 0, &ev, 1, 0);
+		if (ret)
+			break;
+
+		rte_delay_ms(1);
+	}
+
+	TEST_ASSERT((ret == 1), "Failed to dequeue event vector %d", ret);
+	TEST_ASSERT((ev.event_type == (RTE_EVENT_TYPE_CPU | RTE_EVENT_TYPE_VECTOR)), "Incorrect event type %d",
+		    ev.event_type);
+	TEST_ASSERT((ev.sched_type == RTE_SCHED_TYPE_PARALLEL), "Invalid sched type %d",
+		    ev.sched_type);
+
+	return TEST_SUCCESS;
+}
+
+static inline int
+eventdev_setup(void)
+{
+	struct rte_event_queue_conf queue_conf;
+	struct rte_event_dev_config conf;
+	struct rte_event_dev_info info;
+	uint32_t service_id;
+	int ret, i;
+
+	ret = rte_event_dev_info_get(evdev, &info);
+	TEST_ASSERT_SUCCESS(ret, "Failed to get event dev info");
+
+	memset(&conf, 0, sizeof(conf));
+	conf.nb_event_port_dequeue_depth = info.max_event_port_dequeue_depth;
+	conf.nb_event_port_enqueue_depth = info.max_event_port_enqueue_depth;
+	conf.nb_event_queue_flows = info.max_event_queue_flows;
+	conf.dequeue_timeout_ns = info.min_dequeue_timeout_ns;
+	conf.nb_events_limit = info.max_num_events;
+	conf.nb_event_queues = info.max_event_queues;
+	conf.nb_event_ports = 1;
+
+	ret = rte_event_dev_configure(evdev, &conf);
+	TEST_ASSERT_SUCCESS(ret, "Failed to configure eventdev");
+
+	ret = rte_event_queue_default_conf_get(evdev, 0, &queue_conf);
+	TEST_ASSERT_SUCCESS(ret, "Failed to get default queue conf");
+
+	queue_conf.schedule_type = RTE_SCHED_TYPE_PARALLEL;
+	for (i = 0; i < info.max_event_queues; i++) {
+		ret = rte_event_queue_setup(evdev, i, &queue_conf);
+		TEST_ASSERT_SUCCESS(ret, "Failed to setup queue=%d", i);
+	}
+
+	/* Configure event port */
+	ret = rte_event_port_setup(evdev, 0, NULL);
+	TEST_ASSERT_SUCCESS(ret, "Failed to setup port=%d", 0);
+	ret = rte_event_port_link(evdev, 0, NULL, NULL, 0);
+	TEST_ASSERT(ret >= 0, "Failed to link all queues port=%d", 0);
+
+	/* If this is a software event device, map and start its service */
+	if (rte_event_dev_service_id_get(evdev, &service_id) == 0) {
+		TEST_ASSERT_SUCCESS(rte_service_lcore_add(sw_slcore), "Failed to add service core");
+		TEST_ASSERT_SUCCESS(rte_service_lcore_start(sw_slcore),
+				    "Failed to start service core");
+		TEST_ASSERT_SUCCESS(rte_service_map_lcore_set(service_id, sw_slcore, 1),
+				    "Failed to map evdev service");
+		TEST_ASSERT_SUCCESS(rte_service_runstate_set(service_id, 1),
+				    "Failed to start evdev service");
+	}
+
+	ret = rte_event_dev_start(evdev);
+	TEST_ASSERT_SUCCESS(ret, "Failed to start device");
+
+	evdev_max_queues = info.max_event_queues;
+
+	return TEST_SUCCESS;
+}
+
+static int
+testsuite_setup(void)
+{
+	uint32_t service_id;
+	uint32_t caps = 0;
+
+	rte_service_lcore_reset_all();
+
+	if (rte_event_dev_count() == 0) {
+		RTE_LOG(DEBUG, EAL,
+			"Failed to find a valid event device... "
+			"testing with event_sw device\n");
+		TEST_ASSERT_SUCCESS(rte_vdev_init("event_sw0", NULL), "Error creating eventdev");
+		evdev = rte_event_dev_get_dev_id("event_sw0");
+	}
+
+	rte_event_vector_adapter_caps_get(evdev, &caps);
+
+	if (rte_event_dev_service_id_get(evdev, &service_id) == 0)
+		using_services = true;
+
+	if (using_services)
+		sw_slcore = rte_get_next_lcore(-1, 1, 0);
+
+	return eventdev_setup();
+}
+
+static void
+testsuite_teardown(void)
+{
+	rte_event_dev_stop(evdev);
+	rte_event_dev_close(evdev);
+}
+
+static struct unit_test_suite functional_testsuite = {
+	.suite_name = "Event vector adapter test suite",
+	.setup = testsuite_setup,
+	.teardown = testsuite_teardown,
+	.unit_test_cases = {
+		TEST_CASE_ST(NULL, test_event_vector_adapter_free,
+			     test_event_vector_adapter_create),
+		TEST_CASE_ST(NULL, test_event_vector_adapter_free,
+			     test_event_vector_adapter_create_multi),
+		TEST_CASE_ST(test_event_vector_adapter_create, test_event_vector_adapter_free,
+			     test_event_vector_adapter_enqueue),
+		TEST_CASE_ST(test_event_vector_adapter_create, test_event_vector_adapter_free,
+			     test_event_vector_adapter_enqueue_tmo),
+		TEST_CASE_ST(test_event_vector_adapter_create, test_event_vector_adapter_free,
+			     test_event_vector_adapter_enqueue_fallback),
+		TEST_CASE_ST(test_event_vector_adapter_create, test_event_vector_adapter_free,
+			     test_event_vector_adapter_enqueue_sov),
+		TEST_CASE_ST(test_event_vector_adapter_create, test_event_vector_adapter_free,
+			     test_event_vector_adapter_enqueue_eov),
+		TEST_CASE_ST(test_event_vector_adapter_create, test_event_vector_adapter_free,
+			     test_event_vector_adapter_enqueue_sov_eov),
+		TEST_CASE_ST(test_event_vector_adapter_create, test_event_vector_adapter_free,
+			     test_event_vector_adapter_enqueue_flush),
+		TEST_CASES_END() /**< NULL terminate unit test array */
+	}
+};
+
+static int
+test_event_vector_adapter(void)
+{
+	return unit_test_suite_runner(&functional_testsuite);
+}
+
+#endif
+
+REGISTER_FAST_TEST(event_vector_adapter_autotest, true, true, test_event_vector_adapter);
diff --git a/lib/eventdev/eventdev_pmd.h b/lib/eventdev/eventdev_pmd.h
index d03461316b..dda8ad82c9 100644
--- a/lib/eventdev/eventdev_pmd.h
+++ b/lib/eventdev/eventdev_pmd.h
@@ -87,6 +87,8 @@ extern int rte_event_logtype;
 #define RTE_EVENT_TIMER_ADAPTER_SW_CAP \
 		RTE_EVENT_TIMER_ADAPTER_CAP_PERIODIC
 
+#define RTE_EVENT_VECTOR_ADAPTER_SW_CAP RTE_EVENT_VECTOR_ADAPTER_CAP_SOV_EOV
+
 #define RTE_EVENTDEV_DETACHED  (0)
 #define RTE_EVENTDEV_ATTACHED  (1)
 
diff --git a/lib/eventdev/rte_event_vector_adapter.c b/lib/eventdev/rte_event_vector_adapter.c
index ff6bc43b17..ad764e2882 100644
--- a/lib/eventdev/rte_event_vector_adapter.c
+++ b/lib/eventdev/rte_event_vector_adapter.c
@@ -23,6 +23,13 @@
 
 #define MZ_NAME_MAX_LEN	    64
 #define DATA_MZ_NAME_FORMAT "vector_adapter_data_%d_%d_%d"
+#define MAX_VECTOR_SIZE	    1024
+#define MIN_VECTOR_SIZE	    1
+#define MAX_VECTOR_NS	    1E9
+#define MIN_VECTOR_NS	    1E5
+#define SERVICE_RING_SZ	    1024
+#define SERVICE_DEQ_SZ	    16
+#define SERVICE_PEND_LIST   32
 
 RTE_LOG_REGISTER_SUFFIX(ev_vector_logtype, adapter.vector, NOTICE);
 #define RTE_LOGTYPE_EVVEC ev_vector_logtype
@@ -48,6 +55,9 @@ struct rte_event_vector_adapter *adapters[RTE_EVENT_MAX_DEVS][RTE_EVENT_MAX_QUEU
 		}                                                                                  \
 	} while (0)
 
+static const struct event_vector_adapter_ops sw_ops;
+static const struct rte_event_vector_adapter_info sw_info;
+
 static int
 validate_conf(const struct rte_event_vector_adapter_conf *conf,
 	      struct rte_event_vector_adapter_info *info)
@@ -222,6 +232,11 @@ rte_event_vector_adapter_create_ext(const struct rte_event_vector_adapter_conf *
 		goto error;
 	}
 
+	if (adapter->ops == NULL) {
+		adapter->ops = &sw_ops;
+		info = sw_info;
+	}
+
 	rc = validate_conf(conf, &info);
 	if (rc < 0) {
 		adapter->ops = NULL;
@@ -347,6 +362,8 @@ rte_event_vector_adapter_lookup(uint32_t adapter_id)
 			return NULL;
 		}
 	}
+	if (adapter->ops == NULL)
+		adapter->ops = &sw_ops;
 
 	adapter->enqueue = adapter->ops->enqueue;
 	adapter->adapter_id = adapter_id;
@@ -408,6 +425,7 @@ rte_event_vector_adapter_info_get(uint8_t event_dev_id, struct rte_event_vector_
 	if (dev->dev_ops->vector_adapter_info_get != NULL)
 		return dev->dev_ops->vector_adapter_info_get(dev, info);
 
+	*info = sw_info;
 	return 0;
 }
 
@@ -470,3 +488,377 @@ rte_event_vector_adapter_stats_reset(struct rte_event_vector_adapter *adapter)
 
 	return 0;
 }
+
+/* Software vector adapter implementation. */
+
+struct sw_vector_adapter_service_data;
+struct sw_vector_adapter_data {
+	uint8_t dev_id;
+	uint8_t port_id;
+	uint16_t vector_sz;
+	uint64_t timestamp;
+	uint64_t event_meta;
+	uint64_t vector_tmo_ticks;
+	uint64_t fallback_event_meta;
+	struct rte_mempool *vector_mp;
+	struct rte_event_vector *vector;
+	rte_spinlock_t lock;
+	struct rte_event_vector_adapter *adapter;
+	struct rte_event_vector_adapter_stats stats;
+	struct sw_vector_adapter_service_data *service_data;
+	RTE_TAILQ_ENTRY(sw_vector_adapter_data) next;
+};
+
+struct sw_vector_adapter_service_data {
+	uint8_t pend_list;
+	uint32_t service_id;
+	struct rte_ring *ring;
+	struct sw_vector_adapter_data *pend[SERVICE_PEND_LIST];
+};
+
+static inline struct sw_vector_adapter_data *
+sw_vector_adapter_priv(const struct rte_event_vector_adapter *adapter)
+{
+	return adapter->data->adapter_priv;
+}
+
+static int
+sw_vector_adapter_flush(struct sw_vector_adapter_data *sw)
+{
+	struct rte_event ev;
+
+	if (sw->vector == NULL)
+		return -ENOBUFS;
+
+	ev.event = sw->event_meta;
+	ev.vec = sw->vector;
+	if (rte_event_enqueue_burst(sw->dev_id, sw->port_id, &ev, 1) != 1)
+		return -ENOSPC;
+
+	sw->vector = NULL;
+	sw->timestamp = 0;
+	return 0;
+}
+
+static void
+sw_vector_adapter_process_pend_list(struct sw_vector_adapter_service_data *service_data)
+{
+	struct sw_vector_adapter_data *sw;
+	int i;
+
+	if (service_data->pend_list == 0)
+		return;
+	for (i = 0; i < SERVICE_PEND_LIST; i++) {
+		if (service_data->pend_list == 0)
+			break;
+		if (service_data->pend[i] == NULL)
+			continue;
+
+		sw = service_data->pend[i];
+		if (sw->vector == NULL) {
+			service_data->pend[i] = NULL;
+			service_data->pend_list--;
+			continue;
+		}
+
+		rte_spinlock_lock(&sw->lock);
+		if (rte_get_tsc_cycles() - sw->timestamp >= sw->vector_tmo_ticks) {
+			if (sw_vector_adapter_flush(sw) != -ENOSPC) {
+				service_data->pend[i] = NULL;
+				service_data->pend_list--;
+			}
+		}
+		rte_spinlock_unlock(&sw->lock);
+	}
+}
+
+static void
+sw_vector_adapter_add_to_pend_list(struct sw_vector_adapter_service_data *service_data,
+				   struct sw_vector_adapter_data *sw)
+{
+	int i, pos = SERVICE_PEND_LIST;
+
+	if (service_data->pend_list >= SERVICE_PEND_LIST) {
+		EVVEC_LOG_ERR("pend list is full");
+		return;
+	}
+	for (i = 0; i < SERVICE_PEND_LIST; i++) {
+		if (service_data->pend[i] == sw)
+			return;
+		if (service_data->pend[i] == NULL)
+			pos = i;
+	}
+	if (pos == SERVICE_PEND_LIST)
+		return;
+	service_data->pend[pos] = sw;
+	service_data->pend_list++;
+}
+
+static int
+sw_vector_adapter_service_func(void *arg)
+{
+	struct sw_vector_adapter_service_data *service_data = arg;
+	struct sw_vector_adapter_data *sw[SERVICE_DEQ_SZ];
+	int n, i;
+
+	sw_vector_adapter_process_pend_list(service_data);
+	/* Dequeue the adapter list and flush the vectors */
+	n = rte_ring_dequeue_burst(service_data->ring, (void **)&sw, SERVICE_DEQ_SZ, NULL);
+	for (i = 0; i < n; i++) {
+
+		if (sw[i]->vector == NULL)
+			continue;
+
+		if (rte_get_tsc_cycles() - sw[i]->timestamp < sw[i]->vector_tmo_ticks) {
+			sw_vector_adapter_add_to_pend_list(service_data, sw[i]);
+		} else {
+			if (!rte_spinlock_trylock(&sw[i]->lock)) {
+				sw_vector_adapter_add_to_pend_list(service_data, sw[i]);
+				continue;
+			}
+			if (sw_vector_adapter_flush(sw[i]) == -ENOSPC)
+				sw_vector_adapter_add_to_pend_list(service_data, sw[i]);
+			else
+				sw[i]->stats.vectors_timedout++;
+			rte_spinlock_unlock(&sw[i]->lock);
+		}
+	}
+
+	return 0;
+}
+
+static int
+sw_vector_adapter_service_init(struct sw_vector_adapter_data *sw)
+{
+#define SW_VECTOR_ADAPTER_SERVICE_FMT "sw_vector_adapter_service"
+	struct sw_vector_adapter_service_data *service_data;
+	struct rte_service_spec service;
+	const struct rte_memzone *mz;
+	struct rte_ring *ring;
+	int ret;
+
+	mz = rte_memzone_lookup(SW_VECTOR_ADAPTER_SERVICE_FMT);
+	if (mz == NULL) {
+		mz = rte_memzone_reserve(SW_VECTOR_ADAPTER_SERVICE_FMT,
+					 sizeof(struct sw_vector_adapter_service_data),
+					 sw->adapter->data->socket_id, 0);
+		if (mz == NULL) {
+			EVVEC_LOG_DBG("failed to reserve memzone for service");
+			return -ENOMEM;
+		}
+		service_data = (struct sw_vector_adapter_service_data *)mz->addr;
+		memset(service_data, 0, sizeof(*service_data));
+
+		ring = rte_ring_create(SW_VECTOR_ADAPTER_SERVICE_FMT, SERVICE_RING_SZ,
+				       sw->adapter->data->socket_id, 0);
+		if (ring == NULL) {
+			EVVEC_LOG_ERR("failed to create ring for service");
+			rte_memzone_free(mz);
+			return -ENOMEM;
+		}
+		service_data->ring = ring;
+
+		memset(&service, 0, sizeof(service));
+		snprintf(service.name, RTE_SERVICE_NAME_MAX, "%s", SW_VECTOR_ADAPTER_SERVICE_FMT);
+		service.callback = sw_vector_adapter_service_func;
+		service.callback_userdata = service_data;
+		service.socket_id = sw->adapter->data->socket_id;
+
+		ret = rte_service_component_register(&service, &service_data->service_id);
+		if (ret < 0) {
+			EVVEC_LOG_ERR("failed to register service %s with id %" PRIu32 ": err = %d",
+				      service.name, service_data->service_id, ret);
+			return -ENOTSUP;
+		}
+		ret = rte_service_component_runstate_set(service_data->service_id, 1);
+		if (ret < 0) {
+			EVVEC_LOG_ERR("failed to set service runstate with id %" PRIu32
+				      ": err = %d",
+				      service_data->service_id, ret);
+			return -ENOTSUP;
+		}
+	}
+	service_data = (struct sw_vector_adapter_service_data *)mz->addr;
+
+	sw->service_data = service_data;
+	sw->adapter->data->unified_service_id = service_data->service_id;
+	sw->adapter->data->service_inited = 1;
+	return 0;
+}
+
+static int
+sw_vector_adapter_create(struct rte_event_vector_adapter *adapter)
+{
+#define NSEC2TICK(__ns, __freq) (((__ns) * (__freq)) / 1E9)
+#define SW_VECTOR_ADAPTER_NAME	64
+	char name[SW_VECTOR_ADAPTER_NAME];
+	struct sw_vector_adapter_data *sw;
+	struct rte_event ev;
+
+	snprintf(name, SW_VECTOR_ADAPTER_NAME, "sw_vector_%" PRIx32, adapter->data->id);
+	sw = rte_zmalloc_socket(name, sizeof(*sw), RTE_CACHE_LINE_SIZE, adapter->data->socket_id);
+	if (sw == NULL) {
+		EVVEC_LOG_ERR("failed to allocate space for private data");
+		rte_errno = ENOMEM;
+		return -1;
+	}
+
+	/* Connect storage to adapter instance */
+	adapter->data->adapter_priv = sw;
+	sw->adapter = adapter;
+	sw->dev_id = adapter->data->event_dev_id;
+	sw->port_id = adapter->data->event_port_id;
+
+	sw->vector_sz = adapter->data->conf.vector_sz;
+	sw->vector_mp = adapter->data->conf.vector_mp;
+	sw->vector_tmo_ticks = NSEC2TICK(adapter->data->conf.vector_timeout_ns, rte_get_timer_hz());
+
+	ev = adapter->data->conf.ev;
+	ev.op = RTE_EVENT_OP_NEW;
+	sw->event_meta = ev.event;
+
+	ev = adapter->data->conf.ev_fallback;
+	ev.op = RTE_EVENT_OP_NEW;
+	ev.priority = adapter->data->conf.ev.priority;
+	ev.queue_id = adapter->data->conf.ev.queue_id;
+	ev.sched_type = adapter->data->conf.ev.sched_type;
+	sw->fallback_event_meta = ev.event;
+
+	rte_spinlock_init(&sw->lock);
+	sw_vector_adapter_service_init(sw);
+
+	return 0;
+}
+
+static int
+sw_vector_adapter_destroy(struct rte_event_vector_adapter *adapter)
+{
+	struct sw_vector_adapter_data *sw = sw_vector_adapter_priv(adapter);
+
+	rte_free(sw);
+	adapter->data->adapter_priv = NULL;
+
+	return 0;
+}
+
+static int
+sw_vector_adapter_flush_single_event(struct sw_vector_adapter_data *sw, uint64_t obj)
+{
+	struct rte_event ev;
+
+	ev.event = sw->fallback_event_meta;
+	ev.u64 = obj;
+	if (rte_event_enqueue_burst(sw->dev_id, sw->port_id, &ev, 1) != 1)
+		return -ENOSPC;
+
+	return 0;
+}
+
+static int
+sw_vector_adapter_enqueue(struct rte_event_vector_adapter *adapter, uint64_t objs[],
+			  uint16_t num_elem, uint64_t flags)
+{
+	struct sw_vector_adapter_data *sw = sw_vector_adapter_priv(adapter);
+	uint16_t cnt = num_elem, n;
+	int ret;
+
+	rte_spinlock_lock(&sw->lock);
+	if (flags & RTE_EVENT_VECTOR_ENQ_FLUSH) {
+		sw_vector_adapter_flush(sw);
+		sw->stats.vectors_flushed++;
+		rte_spinlock_unlock(&sw->lock);
+		return 0;
+	}
+
+	if (num_elem == 0) {
+		rte_spinlock_unlock(&sw->lock);
+		return 0;
+	}
+
+	if (flags & RTE_EVENT_VECTOR_ENQ_SOV && sw->vector != NULL) {
+		while (sw_vector_adapter_flush(sw) != 0)
+			;
+		sw->stats.vectors_flushed++;
+	}
+
+	while (num_elem) {
+		if (sw->vector == NULL) {
+			ret = rte_mempool_get(sw->vector_mp, (void **)&sw->vector);
+			if (ret) {
+				if (sw_vector_adapter_flush_single_event(sw, *objs) == 0) {
+					sw->stats.alloc_failures++;
+					num_elem--;
+					objs++;
+					continue;
+				}
+				rte_errno = -ENOSPC;
+				goto done;
+			}
+			sw->vector->nb_elem = 0;
+			sw->vector->attr_valid = 0;
+			sw->vector->elem_offset = 0;
+		}
+		n = RTE_MIN(sw->vector_sz - sw->vector->nb_elem, num_elem);
+		memcpy(&sw->vector->u64s[sw->vector->nb_elem], objs, n * sizeof(uint64_t));
+		sw->vector->nb_elem += n;
+		num_elem -= n;
+		objs += n;
+
+		if (sw->vector_sz == sw->vector->nb_elem) {
+			ret = sw_vector_adapter_flush(sw);
+			if (ret)
+				goto done;
+			sw->stats.vectorized++;
+		}
+	}
+
+	if (flags & RTE_EVENT_VECTOR_ENQ_EOV && sw->vector != NULL) {
+		while (sw_vector_adapter_flush(sw) != 0)
+			;
+		sw->stats.vectors_flushed++;
+	}
+
+	if (sw->vector != NULL && sw->vector->nb_elem) {
+		sw->timestamp = rte_get_timer_cycles();
+		rte_ring_enqueue(sw->service_data->ring, sw);
+	}
+
+done:
+	rte_spinlock_unlock(&sw->lock);
+	return cnt - num_elem;
+}
+
+static int
+sw_vector_adapter_stats_get(const struct rte_event_vector_adapter *adapter,
+			    struct rte_event_vector_adapter_stats *stats)
+{
+	struct sw_vector_adapter_data *sw = sw_vector_adapter_priv(adapter);
+
+	*stats = sw->stats;
+	return 0;
+}
+
+static int
+sw_vector_adapter_stats_reset(const struct rte_event_vector_adapter *adapter)
+{
+	struct sw_vector_adapter_data *sw = sw_vector_adapter_priv(adapter);
+
+	memset(&sw->stats, 0, sizeof(sw->stats));
+	return 0;
+}
+
+static const struct event_vector_adapter_ops sw_ops = {
+	.create = sw_vector_adapter_create,
+	.destroy = sw_vector_adapter_destroy,
+	.enqueue = sw_vector_adapter_enqueue,
+	.stats_get = sw_vector_adapter_stats_get,
+	.stats_reset = sw_vector_adapter_stats_reset,
+};
+
+static const struct rte_event_vector_adapter_info sw_info = {
+	.min_vector_sz = MIN_VECTOR_SIZE,
+	.max_vector_sz = MAX_VECTOR_SIZE,
+	.min_vector_timeout_ns = MIN_VECTOR_NS,
+	.max_vector_timeout_ns = MAX_VECTOR_NS,
+	.log2_sz = 0,
+};
diff --git a/lib/eventdev/rte_eventdev.c b/lib/eventdev/rte_eventdev.c
index 916bad6c2c..b921142d7b 100644
--- a/lib/eventdev/rte_eventdev.c
+++ b/lib/eventdev/rte_eventdev.c
@@ -272,6 +272,8 @@ rte_event_vector_adapter_caps_get(uint8_t dev_id, uint32_t *caps)
 		return -EINVAL;
 
 	if (dev->dev_ops->vector_adapter_caps_get == NULL)
+		*caps = RTE_EVENT_VECTOR_ADAPTER_SW_CAP;
+	else
 		*caps = 0;
 
 	return dev->dev_ops->vector_adapter_caps_get ?
-- 
2.43.0

