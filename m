Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EA9C021B0
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 13:43:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34268410EA;
	Wed, 19 Feb 2025 14:43:37 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013009.outbound.protection.outlook.com
 [40.107.162.9]) by mails.dpdk.org (Postfix) with ESMTP id 33CED410E3
 for <dev@dpdk.org>; Wed, 19 Feb 2025 14:43:35 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISTT7lbb8oQorRr+quLfiemjiEnKPOo3xvOtCVMwhd6XxIIGunsg7QaiDgcOOg50U2GSzJU7xfpibRG7MR0ihIjTezWQDNtdggucsTPOtqrGcOB3ZeCpg5p3GMzfRVPU0LebY4cCuBsd3OqeXuo20GmfoWNGAqLh+YlPtFimt27bg4kHrJbtUzDqgJ/f1lllfh8Rhbn0trOmqpy6qqqaJXdOw3go77MCKhRf/W4Mf9jHGnTF43HznxQB9ufWcgK9du44hv/m4pNu97WwRxZP7B5hi+Btp5vdY5S9YUsZiH8amYowZg7GltYC2j/AolhvA83+uu0DIwWik0z7p9WGRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YwcRUQHmb5jVB1H2MNkIc9jc0uRBmS6p4BV5ldWWks=;
 b=Jy/yU/MnjEPln84/t5O2o/8SyDlqBOiiorNxIwbzBrQSthgUJn2XoBoHW3afn4H1mTpFaJ3oBiVrXx6GFcmdeyeP2nSD805pEYPH8RiSboV3XjNEoqbJ7c6tkznFrnJYjqLh7kFo1atsN9CZXbA/vyWKCsVffgOti1jTQ5bz410Gl/MI0chhT7DJHSfBBJV4nOwRExd6dcNsDX2535A4ih28SrW9YT8xCfZXEmIBjspfTYBcRiB2N3m+ROgZYiyTImZqZvOgD+lik/jXmcQx3eoCnC3YRcuLg6Te/Oq4oZWKTuv2ugmOYOgrki/D/zGPpyqIrhZAqBnmsEDfLbdn9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YwcRUQHmb5jVB1H2MNkIc9jc0uRBmS6p4BV5ldWWks=;
 b=Bvwuphwmy3qdHHNDeBw8b1br5sRCxXZwvhaG75mA9fk4s51iU+Vjz+ILvMNbrVTtSkG92vJyLozn1GQArwJQUyhKbKyZCbu3S2oJYs0uEPGOFgX1Iw1aqg4ec3Z6dkOpDQ53UDj2bR7S97akY+5JVNOHyHeYquFXVBFKESLcTZ2kBvvISpRoHpy6Ytj79MNrbGkSfPVLI9DKQpyv9//EDDrdCLbKhWX9+DoLc3Rgh6GLLuPZ8SSRXS+UZ3bpB+xkSg9sbQyOqLImuXoT3isdghAqKQrLwtHsRvXb6wP8V8JXvjPaotM63AVUOYeOF9cX5dbrH3H8tt0U53zCetPxXw==
Received: from AS4PR10CA0028.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::13)
 by PA4PR07MB7149.eurprd07.prod.outlook.com (2603:10a6:102:ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 13:43:31 +0000
Received: from AM4PEPF00027A6B.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::c2) by AS4PR10CA0028.outlook.office365.com
 (2603:10a6:20b:5d8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Wed,
 19 Feb 2025 13:43:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM4PEPF00027A6B.mail.protection.outlook.com (10.167.16.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 13:43:31 +0000
Received: from seliiuvd00917.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.62) with Microsoft SMTP Server
 id 15.2.1544.14; Wed, 19 Feb 2025 14:43:30 +0100
From: Luka Jankovic <luka.jankovic@ericsson.com>
To: <luka.jankovic@ericsson.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <mattias.ronnblom@ericsson.com>,
 <pbhagavatula@marvell.com>
Subject: [RFC v7 1/4] eventdev: atomic common for test-eventdev app
Date: Wed, 19 Feb 2025 14:43:22 +0100
Message-ID: <20250219134325.1195531-2-luka.jankovic@ericsson.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20250219134325.1195531-1-luka.jankovic@ericsson.com>
References: <20250124095937.1436673-1-luka.jankovic@ericsson.com>
 <20250219134325.1195531-1-luka.jankovic@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6B:EE_|PA4PR07MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: dfdaffc6-5ce1-41e1-8d8b-08dd50eb65f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yWbsCyHzH/iSRW4v/RbfbfNitzFuz9vtnZOT2dhCvgfXALxxg0J2XHjVqPjh?=
 =?us-ascii?Q?mNuJSa46HX9aEoOelkI8MkdQ7r2QTVJjoR6lf461wyfBWtUOWhpqEFsP4iY3?=
 =?us-ascii?Q?5AJ3KnaO44VlmUEnV/EEtB1iwie5XSjaXtbq13pRWSQFuzoCC9XBwhUWUGSr?=
 =?us-ascii?Q?M0f+RjbWjI8jOmUp+iUeM27tB1jahdtQCxAfKftvg3fEexQzu4JK3OxXgnGx?=
 =?us-ascii?Q?QeqsDnEGjBAXHj6yPX9KGd1YKt4O/oqazWxFN/8fduCgLs6D9SQeW+/kCwXi?=
 =?us-ascii?Q?gBTJ7PkHzvWfN6n3TJbWwecP3WbbDxJVmHTuB+vOmPq0DF8kC+fq8gKN9MBy?=
 =?us-ascii?Q?8HV/VrvAsLnkU24EaAut8BoYmwE61MKzPsP3woK8M1F2BiZNMQ0NT0jxYM/H?=
 =?us-ascii?Q?M5NuCl+rZditlIajr208As3zTKnyVbvWOubysis/VvV1SM/C1s8pXMMu4x4G?=
 =?us-ascii?Q?VDH5rj6kO2O/0R5ir85L9jOeVXq+Qu4LVNGglDgn2kYegO0xx9urC98FfSjT?=
 =?us-ascii?Q?sYcB6lc/GwK4bVb1lSRyZjyQ2tF62RHHv4H08zzPMhmmzHos89wfSJgXtgGJ?=
 =?us-ascii?Q?OCx9VEyMJmW3OGc7cfzSHLdhq7QLLQntWsplmq/sgZyJkEepoL2r6QsVBxOm?=
 =?us-ascii?Q?33ozpZX3iZfjOI61JsZYBBALslLW3vABhD7HZoIxJfGbQ+gxeJOepriSgPFN?=
 =?us-ascii?Q?4i/rjhlysYwrtZob5IsK5mOaocIVjMVhhg4Mrtj4msvYeu+wp6cKB3axZGrT?=
 =?us-ascii?Q?kUEHi9CaqgpPvSxfSsFS0GlH9341VFNHL228Igsh/KGhAdLovPoXIFRkwryO?=
 =?us-ascii?Q?quamigGEPP6EwALTWgrJ6eGoGiTj+YSKppKiAHKLCCqqVCQ2gUszsVJNXGZT?=
 =?us-ascii?Q?0aH2lxIxS7WhnuqQ/As9t6IdRPtgQu0qxnGoNQV9WA9n3mXGVTwaWuH+kqjr?=
 =?us-ascii?Q?ORONFZ37vqei0rNPBPtjbToXrOf/hWVU2ve8eDY41stQFnEqxVnHtxlcEDJe?=
 =?us-ascii?Q?6tB6oHZU1c7InV34ZKqbfJFAIuRrZgaY8D8UKMlQHyFq9SsflR1v77yTEu4J?=
 =?us-ascii?Q?RGx7g5zOAJtzha2raCZH4Hz66PpiwTs4NWiRKLn/wQ5wxdmYMorBBJaJLi1O?=
 =?us-ascii?Q?plmXH5mfe0KfvflBsqFvzHMKROqxrdgh467TyyQB9nQJfD8VM6ViL6Kt73A5?=
 =?us-ascii?Q?3JFrN15ZurjUgNwW2QiVlA/Yd1ExDj5E3xjAE4TlXDb8JuE7gxev0rBu8Lnr?=
 =?us-ascii?Q?KLk/gu3OwcrF8C3fRlckoozrJtQR7pwbH+xKDro/LutpbQT57ik00sUeHADV?=
 =?us-ascii?Q?luxQtgdUgW8EV7hDOx57xuOvQ18dcc0PcL0wgKea9quw1OYEsO+mAdH+hHQG?=
 =?us-ascii?Q?Hhoc/A7gu+UXltNCL9ba0697OmOq3fy78AcIdnplqG6SKxHXb9UspmEGWEZ6?=
 =?us-ascii?Q?BjPQGsjJYxVaVyTj8M7MQc+ABGLanzzmCynJ5rHhk4RAELu7tBN5P9GPIEMg?=
 =?us-ascii?Q?ZklDooYQxNn/hTE=3D?=
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 13:43:31.3915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfdaffc6-5ce1-41e1-8d8b-08dd50eb65f4
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A6B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7149
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
---
 app/test-eventdev/evt_common.h         |   9 ++
 app/test-eventdev/meson.build          |   1 +
 app/test-eventdev/test_atomic_common.c | 134 +++++++++++++++++++++++++
 app/test-eventdev/test_atomic_common.h |  85 ++++++++++++++++
 4 files changed, 229 insertions(+)
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
index ab8769c755..78af30cb10 100644
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
index 0000000000..79b7b77101
--- /dev/null
+++ b/app/test-eventdev/test_atomic_common.c
@@ -0,0 +1,134 @@
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
+
+
diff --git a/app/test-eventdev/test_atomic_common.h b/app/test-eventdev/test_atomic_common.h
new file mode 100644
index 0000000000..3f1dd2bbdb
--- /dev/null
+++ b/app/test-eventdev/test_atomic_common.h
@@ -0,0 +1,85 @@
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
+	if (atomic_locks == NULL) {
+		evt_err("Unable to allocate memory for spinlocks.");
+	}
+
+	for (uint32_t i = 0; i < num_locks; i++) {
+		rte_spinlock_init(&atomic_locks[i]);
+	}
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
-- 
2.34.1

