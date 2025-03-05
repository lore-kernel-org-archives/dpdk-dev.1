Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63B9C282E3
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 12:52:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B3524042E;
	Wed,  5 Mar 2025 13:52:29 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
 by mails.dpdk.org (Postfix) with ESMTP id F07464025F
 for <dev@dpdk.org>; Wed,  5 Mar 2025 13:52:27 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdRMaGvX2yy3Rsf3EdaEEFKkFdvPsVOLgo1CWdO3+a92CLC+2YJTPgWZ833XyctNq7jQK13dmZUYEtb4AAUB9/Q6iG3werFqpgTFQIvZWlnkr2nKeEM3jLV6NCxFR4fWSLj2SnI4NwSap+qEyQorw06Ie9mYf2dQ4+tlfdJnbyKHFY/Jc6N6uQKSmZ6uRnLBCuF723wsEp579cA7/W/LUpu2yWrotJcYe7KTstW3dd7VtDh6OyHDEX5KG+A/gRZ+Y6kPg9CItGKRc6K393d/WrBB8OVSigEjXlDT0HUCwlJ7nVNehdz9by7/OGQIXAdWKc8NDVk+FBoz5ZSmSg3t6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPg1bGkfVBVDc6YOWIPVLSbFelklzB5WlhPSy7HbxX0=;
 b=rlpcnjkJkaiLipdnzC53bsVF9Zxh7dFq4FTtAkfeqT+qxfDmXcbLKOL64k7+V+NYvSidadPzLon5PTLQGy/GimoZTsYv0ffyNmZuFBBVw3F3gBKgQDem7ZXtLIqQSUGb6Sfd+1q7BVytpXlmy9BYCU3RXBAyruW7SccLlKc1D034ucmIgnDMyABpA8RZSTVLU4sgtlWNRwXgPKzDZq7h/LrK+P34evXALkxsHa+acs9MTirjHZdYfWz56xmJ5TSGgdVmSDKLB/Wjuujy0ajfCT0J49RuG3EeZxloikoukVJjpoRge0AqQwQ7p14Zremb/Sa+aF70v1N6DhkUNqtdYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPg1bGkfVBVDc6YOWIPVLSbFelklzB5WlhPSy7HbxX0=;
 b=AILuLQmn45VYv+9Rn7W8GJOwOJNFX4ndONDV33Qvsn9uScnYwqo/8hRmAygCm8UEVmsxuvEUSQATZEHXuSJS9rwiiI/mQyWIIKK5qWaN5fJjTN3HSl9rDtQsBUM0KSoDTOGSvstPrXyx1Jzz0uNc1cExA5/yxDgzMHbqXrVmChr4IeF9I7UHfzZe6fEl9NU7yM1nO9oBV2xUhM342vawXKn9yx8nPE+VMNoOhhBZfaZVbZ2x2eZ0NVKuOArrQe8LdimeMx33jTDiJIgpi+UoSfPRTdrEqN1h5Tqnmq+HA6cNTKcijtjji2dTsiVkKkywvM/+gTMxvepaPQsZjD5hfA==
Received: from CWLP265CA0520.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18c::23)
 by PAXPR07MB7823.eurprd07.prod.outlook.com (2603:10a6:102:15c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 12:52:24 +0000
Received: from AMS0EPF0000019C.eurprd05.prod.outlook.com
 (2603:10a6:400:18c:cafe::1e) by CWLP265CA0520.outlook.office365.com
 (2603:10a6:400:18c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Wed,
 5 Mar 2025 12:52:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AMS0EPF0000019C.mail.protection.outlook.com (10.167.16.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 12:52:24 +0000
Received: from seliiuvd00917.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.67) with Microsoft SMTP Server
 id 15.2.1544.14; Wed, 5 Mar 2025 13:52:17 +0100
From: Luka Jankovic <luka.jankovic@ericsson.com>
To: <luka.jankovic@ericsson.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <mattias.ronnblom@ericsson.com>,
 <pbhagavatula@marvell.com>
Subject: [PATCH] eventdev: atomic common for test-eventdev app
Date: Wed, 5 Mar 2025 13:52:13 +0100
Message-ID: <20250305125215.2870237-2-luka.jankovic@ericsson.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20250305125215.2870237-1-luka.jankovic@ericsson.com>
References: <20250219134325.1195531-1-luka.jankovic@ericsson.com>
 <20250305125215.2870237-1-luka.jankovic@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019C:EE_|PAXPR07MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: a83d8a34-3cdb-45bb-f730-08dd5be49376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EPI9iV+32HkMVXKNs7wDhCfIp9WL27OUrYQd0ycn/XR5J6TWDW3yLGvBtQb4?=
 =?us-ascii?Q?jaS88czXpxelvjDRal85w4l4FDicQ4jNeLj40ElMO/CYbU5yhfIh0I/9PmvY?=
 =?us-ascii?Q?vVB2M1nHxEKvz5KB1nCjPzpuT1WsT+97Zg5/9xbAovJI/QFK2GU99i6RfnRA?=
 =?us-ascii?Q?BZqXiaYo9Vca8lTZfSdlR99kIQLaOVzwmMro1yChIEAkjj9UOqWXjmOg3qcI?=
 =?us-ascii?Q?yGpVEKJMSHECRx+W45GLPeuJvMU8mblDt7xtHGTZBaTS6eQ4QSOCKsleuJCM?=
 =?us-ascii?Q?0Wg5Z6swmT+33ibXRmrQnABrHSFELMtx5oHkveKfKliTBU3HyMBbP8bSrD8W?=
 =?us-ascii?Q?56GsHP0WtWXdsfgttAIYa5qzg25z1G3NZQt3ip3902IndF5y8l4KnZI3rGJ7?=
 =?us-ascii?Q?q/QgPOhM1loUvuqHuSKxwcsfZmOhZ6Rt41F/0fKDwTjmyAngZt71EcnWu3p/?=
 =?us-ascii?Q?4J51LKl7cv3lw6m0oYwrr+0/+2iK3KDi1i6/ysLgDqL0fE7B+ttc6rjI8TgD?=
 =?us-ascii?Q?oiy6BgzMjvdh0jAUMPro1ZAvSdMvULL/JZB6ri6zsaw9leMqtYOIrHrLR2rC?=
 =?us-ascii?Q?TpnsJQOSAygWLUI0zI1pOlmWq3y3PL//VHAhUJO9jYrr/WkvM6umrxHMBbUR?=
 =?us-ascii?Q?xtkTv8LxrmU6nNcYvb7QqIfQr7BXa5rVbQ1M7VrwoY0lZc3pA/MEWIS2F2po?=
 =?us-ascii?Q?DqTV1xBLDcFCy7Aa5/+fLjVcEZQ7kXEN1gdMkGGim3U8siRkZovQHvUXXEkg?=
 =?us-ascii?Q?m4Rdgm16jKDNvF/IcD8iVsGZUMosiXencMYNJ0Ezc5Zv4Ujruaeiv0O7pNrU?=
 =?us-ascii?Q?nXyo3fkY7UBw0zkIdChvlKVxmNKA6TX8pNkE1s1yIcfDmt2fTLm6vNYRvlby?=
 =?us-ascii?Q?McXoPR43JCX7J+7YFUFGzEL6unKxsLDOpOEKRU5jvuD05kq7kDgyUdp2hgRl?=
 =?us-ascii?Q?gntCHPOQA06Ct0C+X4FbDpJlyQi1ehrk4C66cizj6ey8A8+aWollt/lebgfT?=
 =?us-ascii?Q?+XTnZQnbB9Phb2JiwQjPiyCVHlBQa+eY/Nn4cm9O6qvSzWj6QMwfiJx4Jl4v?=
 =?us-ascii?Q?vRY7QBsCVhDXChC1u8GjR6tIy/XxrQZShDHyt3LyTcpQZz+Ld/Adby3G6Jpn?=
 =?us-ascii?Q?LnrftEGI0yMdGr22BtMpaEmodleCAZ3xZBQLLflk6ggChDoYL8uoHPJk/+Yr?=
 =?us-ascii?Q?PMtaU4mO35P3e9rba6hO8pmGU9j+DQ/QzBbWEVVw7m15NyUw1re7m8D1l8AS?=
 =?us-ascii?Q?eSKZyzeglkxtt+nzzJVFoZsSkZ7TWBH/9YJxwnLXl+ZZBjxwLjOvmGOfzNCb?=
 =?us-ascii?Q?/hTLUWuxIaTUBhvCqX1llYceAuw8GweB5Cq4Ah/h2SKfdBhZaQaRXNamgzm1?=
 =?us-ascii?Q?vWAFikhYp5QvK2fmfi/SSiMbz0CbiJR0MSnQNpHGskJGqhpmg4QR2L8sCWtS?=
 =?us-ascii?Q?hT/jkdKZ95ue9aAf8e8ZbOkSY8T0mP3vyvU1CnGlXSrUUZ45a/Tdq94Pxaut?=
 =?us-ascii?Q?msG5+jVBkbL/7PQ=3D?=
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 12:52:24.0571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a83d8a34-3cdb-45bb-f730-08dd5be49376
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7823
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

Introduce changes required for atomic tests to run atomic tests.

- Producer port maintenance
- Common spinlock implementation

Signed-off-by: Luka Jankovic <luka.jankovic@ericsson.com>
Tested-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 app/test-eventdev/evt_common.h         |   9 ++
 app/test-eventdev/meson.build          |   1 +
 app/test-eventdev/test_atomic_common.c | 136 +++++++++++++++++++++++++
 app/test-eventdev/test_atomic_common.h |  87 ++++++++++++++++
 doc/guides/rel_notes/release_25_03.rst |   5 +
 5 files changed, 238 insertions(+)
 create mode 100644 app/test-eventdev/test_atomic_common.c
 create mode 100644 app/test-eventdev/test_atomic_common.h

diff --git a/app/test-eventdev/evt_common.h b/app/test-eventdev/evt_common.h
index 63b782f11a..74f9d187f3 100644
--- a/app/test-eventdev/evt_common.h
+++ b/app/test-eventdev/evt_common.h
@@ -138,6 +138,15 @@ evt_has_flow_id(uint8_t dev_id)
 			true : false;
 }

+static inline bool
+evt_is_maintenance_free(uint8_t dev_id)
+{
+	struct rte_event_dev_info dev_info;
+
+	rte_event_dev_info_get(dev_id, &dev_info);
+	return dev_info.event_dev_cap & RTE_EVENT_DEV_CAP_MAINTENANCE_FREE;
+}
+
 static inline int
 evt_service_setup(uint32_t service_id)
 {
diff --git a/app/test-eventdev/meson.build b/app/test-eventdev/meson.build
index f0da9fadf2..926593b1a6 100644
--- a/app/test-eventdev/meson.build
+++ b/app/test-eventdev/meson.build
@@ -15,6 +15,7 @@ sources = files(
         'test_order_atq.c',
         'test_order_common.c',
         'test_order_queue.c',
+        'test_atomic_common.c',
         'test_perf_atq.c',
         'test_perf_common.c',
         'test_perf_queue.c',
diff --git a/app/test-eventdev/test_atomic_common.c b/app/test-eventdev/test_atomic_common.c
new file mode 100644
index 0000000000..618b92750c
--- /dev/null
+++ b/app/test-eventdev/test_atomic_common.c
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Ericsson AB
+ */
+
+#include "test_atomic_common.h"
+
+static inline bool
+test_done(struct test_order *const t)
+{
+	return t->err || t->result == EVT_TEST_SUCCESS;
+}
+
+static inline int
+atomic_producer(void *arg)
+{
+	struct prod_data *p = arg;
+	struct test_order *t = p->t;
+	struct evt_options *opt = t->opt;
+	const uint8_t dev_id = p->dev_id;
+	const uint8_t port = p->port_id;
+	struct rte_mempool *pool = t->pool;
+	const uint64_t nb_pkts = t->nb_pkts;
+	uint32_t *producer_flow_seq = t->producer_flow_seq;
+	const uint32_t nb_flows = t->nb_flows;
+	uint64_t count = 0;
+	struct rte_mbuf *m;
+	struct rte_event ev;
+
+	if (opt->verbose_level > 1)
+		printf("%s(): lcore %d dev_id %d port=%d queue=%d\n",
+			__func__, rte_lcore_id(), dev_id, port, p->queue_id);
+
+	ev = (struct rte_event) {
+		.op = RTE_EVENT_OP_NEW,
+		.queue_id = p->queue_id,
+		.sched_type = RTE_SCHED_TYPE_ATOMIC,
+		.priority = RTE_EVENT_DEV_PRIORITY_NORMAL,
+		.event_type = RTE_EVENT_TYPE_CPU,
+		.sub_event_type = 0
+	};
+
+	while (count < nb_pkts && t->err == false) {
+		m = rte_pktmbuf_alloc(pool);
+		if (m == NULL)
+			continue;
+
+		/* Maintain seq number per flow */
+
+		const flow_id_t flow = rte_rand_max(nb_flows);
+
+		*order_mbuf_flow_id(t, m) = flow;
+		*order_mbuf_seqn(t, m) = producer_flow_seq[flow]++;
+
+		ev.flow_id = flow;
+		ev.mbuf = m;
+
+		while (rte_event_enqueue_burst(dev_id, port, &ev, 1) != 1) {
+			if (t->err)
+				break;
+			rte_pause();
+		}
+
+		count++;
+	}
+
+	if (!evt_is_maintenance_free(dev_id)) {
+		while (!test_done(t)) {
+			rte_event_maintain(dev_id, port, RTE_EVENT_DEV_MAINT_OP_FLUSH);
+			rte_pause();
+		}
+	}
+
+	return 0;
+}
+
+int
+atomic_launch_lcores(struct evt_test *test, struct evt_options *opt,
+		int (*worker)(void *))
+{
+	int ret, lcore_id;
+	struct test_order *t = evt_test_priv(test);
+
+	/* launch workers */
+
+	int wkr_idx = 0;
+	RTE_LCORE_FOREACH_WORKER(lcore_id) {
+		if (!(opt->wlcores[lcore_id]))
+			continue;
+
+		ret = rte_eal_remote_launch(worker, &t->worker[wkr_idx], lcore_id);
+		if (ret) {
+			evt_err("failed to launch worker %d", lcore_id);
+			return ret;
+		}
+		wkr_idx++;
+	}
+
+	/* launch producer */
+	int plcore = evt_get_first_active_lcore(opt->plcores);
+
+	ret = rte_eal_remote_launch(atomic_producer, &t->prod, plcore);
+	if (ret) {
+		evt_err("failed to launch order_producer %d", plcore);
+		return ret;
+	}
+
+	uint64_t prev_time = rte_get_timer_cycles();
+	int64_t prev_outstanding_pkts = -1;
+
+	while (t->err == false) {
+		uint64_t current_time = rte_get_timer_cycles();
+		int64_t outstanding_pkts = rte_atomic_load_explicit(
+				&t->outstand_pkts, rte_memory_order_relaxed);
+
+		if (outstanding_pkts <= 0) {
+			t->result = EVT_TEST_SUCCESS;
+			break;
+		}
+
+		if (current_time - prev_time > rte_get_timer_hz() * IDLE_TIMEOUT) {
+			printf(CLGRN "\r%" PRId64 "" CLNRM, outstanding_pkts);
+			fflush(stdout);
+			if (prev_outstanding_pkts == outstanding_pkts) {
+				rte_event_dev_dump(opt->dev_id, stdout);
+				evt_err("No events processed during one period, deadlock");
+				t->err = true;
+				break;
+			}
+			prev_outstanding_pkts = outstanding_pkts;
+			prev_time = current_time;
+		}
+	}
+	printf("\r");
+
+	return 0;
+}
diff --git a/app/test-eventdev/test_atomic_common.h b/app/test-eventdev/test_atomic_common.h
new file mode 100644
index 0000000000..a3cec4791d
--- /dev/null
+++ b/app/test-eventdev/test_atomic_common.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Ericsson AB
+ */
+
+#ifndef _TEST_ATOMIC_COMMON_H
+#define _TEST_ATOMIC_COMMON_H
+
+#include <stdio.h>
+#include <stdbool.h>
+
+#include <rte_eventdev.h>
+
+#include "evt_common.h"
+#include "evt_options.h"
+#include "evt_test.h"
+
+#include "test_order_common.h"
+
+#define IDLE_TIMEOUT 1
+
+static inline uint32_t
+get_lock_idx(int stage, flow_id_t flow, uint32_t nb_flows)
+{
+	return (stage * nb_flows) + flow;
+}
+
+static inline bool
+atomic_spinlock_trylock(rte_spinlock_t atomic_locks[],
+		uint32_t stage,
+		uint32_t flow,
+		uint32_t nb_flows)
+{
+	return rte_spinlock_trylock(&atomic_locks[get_lock_idx(stage, flow, nb_flows)]);
+}
+
+static inline void
+atomic_spinlock_unlock(rte_spinlock_t atomic_locks[],
+		uint32_t stage,
+		uint32_t flow,
+		uint32_t nb_flows)
+{
+	rte_spinlock_unlock(&atomic_locks[get_lock_idx(stage, flow, nb_flows)]);
+}
+
+static inline void
+atomic_lock_verify(rte_spinlock_t atomic_locks[],
+		uint32_t stage,
+		uint32_t flow,
+		uint32_t nb_flows,
+		struct test_order *const t,
+		uint32_t port)
+{
+	if (!atomic_spinlock_trylock(atomic_locks, stage, flow, nb_flows)) {
+
+		evt_err("q=%u, flow=%x atomicity error: port %u tried to take held spinlock %p",
+				stage, flow, port,
+				&atomic_locks[get_lock_idx(stage, flow, nb_flows)]);
+		t->err = true;
+	}
+}
+
+static inline rte_spinlock_t *
+atomic_init_locks(uint32_t nb_stages, uint32_t nb_flows)
+{
+	const uint32_t num_locks = nb_stages * nb_flows;
+
+	rte_spinlock_t *atomic_locks = rte_calloc(NULL, num_locks, sizeof(rte_spinlock_t), 0);
+
+	if (atomic_locks == NULL)
+		evt_err("Unable to allocate memory for spinlocks.");
+
+	for (uint32_t i = 0; i < num_locks; i++)
+		rte_spinlock_init(&atomic_locks[i]);
+
+	return atomic_locks;
+}
+
+static inline flow_id_t *
+order_mbuf_flow_id(struct test_order *t, struct rte_mbuf *mbuf)
+{
+	return RTE_MBUF_DYNFIELD(mbuf, t->flow_id_dynfield_offset, flow_id_t *);
+}
+
+int atomic_launch_lcores(struct evt_test *test, struct evt_options *opt,
+		int (*worker)(void *));
+
+#endif
diff --git a/doc/guides/rel_notes/release_25_03.rst b/doc/guides/rel_notes/release_25_03.rst
index a8c76f11ff..881fe5671a 100644
--- a/doc/guides/rel_notes/release_25_03.rst
+++ b/doc/guides/rel_notes/release_25_03.rst
@@ -166,6 +166,11 @@ New Features

   See the :doc:`../compressdevs/zsda` guide for more details on the new driver.

+* **Added atomic tests to the dpdk-test-eventdev test application.**
+
+  Added two atomic tests: ``atomic_queue`` and ``atomic_atq``. They work in the same way as
+  the corresponding ordered tests but exclusively use atomic queues.
+  Atomicity is verified using spinlocks.

 Removed Items
 -------------
--
2.36.0

