Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C08C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 08:49:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B383A4065E;
	Thu,  6 Mar 2025 09:49:52 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
 by mails.dpdk.org (Postfix) with ESMTP id 9808140156
 for <dev@dpdk.org>; Thu,  6 Mar 2025 09:49:51 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDw9htxWZMKdIiux1GmCE+ATTvtzhlT8ipfXq6z9Z/o65D/zDM7zsDbkgmgJLsPWLA8C0QPph3AJ2un/5BO9HHn5G9qPVH1b0a155QImcfxdGqZJwGG4MI1qECrKQ6r5XS8t9blOwdVV94AvHzNO+q21Qer0+s/FMR1T8ifQ0ubsbN5gmGjQHhs7tJmBDwa3w9iNHrUwjZ8Lh8VW2eqRELHU+cRnaABJT/+lCS1PheWK+gtkB5DvUXRF3NH1pQ3C5Hv4IjrMrWJs23aFecaZjohTWzcmk/mg7/6f7vAhZQOQ3C/vjfib2vd5Kw1qhEf/DVmBcmSWnocdjc+qjYOhWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zXIli0OXQr7LQq7+JwryJJgm5kY6TFkpqOcFSxAyU0=;
 b=EGcV0tgkKD63s16pqXOJZiPIa96Lwz91av+n774X3BkQtIx40I1D2Trolm6zwwmacI8tPupQx7v2bGETA1ygmVcGXnWfJfRNMGSHCPZiMJbGZaEUqqKZX+JiGXKwuTIsS4s7UyXRb8h7UHyByY3BJQYq31zER0yjw1vW/g+J/BgGnrU/yMdDvM4bRve+YTZOBopvMB+iILDRFuwgcz4mp0JacVlUqGJMgS3t00Cj5pGl8cGqZYJhU3cC0lBq+CCoLQL+0laK7DwfQBdCZNCJJ16+1539TSRMqIo2M6xQlMoslp4DcBJQDdkypesT0R8N87MB98A6yMBKGYYbkeB3JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zXIli0OXQr7LQq7+JwryJJgm5kY6TFkpqOcFSxAyU0=;
 b=uF5ZgHPzat6/cIOFo3mhiLtsn9HQbUYyu1Ug7mc8+LneZXxX/hsdyzn3g6E6FEV7TZm1xca9YpFP6oKhPLuZpy7wX2UNRMcSm54ZuM5A6F2EUbfbifMc13T2SoJhPWpkTpF49TlLaWfAnytK+sGbUXXpsCfVot6r0LbERWRuL6oAIVAFj+/7CV8HVFi7aM2dFUfJ9t5k1GqGwufDeAOO1ii4dkR7qGlwufxA8R7CXYlp8mjpqqiE7W/VvEJSkzB49/1IAPRduhUNR1c8PWXaV4fl/I4iGFgOKQ5+59MM+TkbI2LqQsPtQu3L3u0f0jidpq7fYS3f2+utaYVDSnsfmw==
Received: from DB8P191CA0016.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::26)
 by AS8PR07MB9044.eurprd07.prod.outlook.com (2603:10a6:20b:56a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 08:49:49 +0000
Received: from DB5PEPF00014B91.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::9a) by DB8P191CA0016.outlook.office365.com
 (2603:10a6:10:130::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Thu,
 6 Mar 2025 08:49:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB5PEPF00014B91.mail.protection.outlook.com (10.167.8.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 08:49:49 +0000
Received: from seliiuvd00917.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.61) with Microsoft SMTP Server
 id 15.2.1544.14; Thu, 6 Mar 2025 09:49:48 +0100
From: Luka Jankovic <luka.jankovic@ericsson.com>
To: <luka.jankovic@ericsson.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <mattias.ronnblom@ericsson.com>,
 <pbhagavatula@marvell.com>
Subject: [PATCH v10 1/3] eventdev: atomic common for test-eventdev app
Date: Thu, 6 Mar 2025 09:49:44 +0100
Message-ID: <20250306084946.3699972-2-luka.jankovic@ericsson.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20250306084946.3699972-1-luka.jankovic@ericsson.com>
References: <20250305141255.3031686-1-luka.jankovic@ericsson.com>
 <20250306084946.3699972-1-luka.jankovic@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B91:EE_|AS8PR07MB9044:EE_
X-MS-Office365-Filtering-Correlation-Id: f04ed284-8284-46f5-d954-08dd5c8bdaaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dHCckgjMKRAdM/Adcp+98+r9We9EpI16j01tOn6EIQlpO8B08ug1PkCjqE0p?=
 =?us-ascii?Q?rqYVdMIDXWX2B5Vbzg/84L3sBYlf0evqc1lQYH1ZNB+buAkg76uaL6+BVyrY?=
 =?us-ascii?Q?WC/Ba6p2dl8OS04O/7aYasTkM6gSlac0MMGZ74/e94PVrAKDbBw2GrQCu2z4?=
 =?us-ascii?Q?WYAUr6ULagosbL2ildinGm6f2loVu/4YRPlN3m7ehlhP6QUOU0G9KMQ3YAXX?=
 =?us-ascii?Q?SHOQOsHTvtQDLVXO0kqhjPZ2xaifAN86NkDeIHTHR7cE8b977YsAAR7qrfyK?=
 =?us-ascii?Q?1qLeJ6iqA3g6+SCrYRim1W2US9qXTifT2O5T8TzfdnS6PFhB+VyyWiKSAtY1?=
 =?us-ascii?Q?FuZLEDh1+Qf2crz1EJWcxn0eE+XVkOuJD4ESq2cRoANR/QNbbaVUsiyaR8ta?=
 =?us-ascii?Q?K4XDpIFSJ7R4Qs2pG9qSiSDx6wdX/DmM60MYH4T7HPLbUJzRHQ4Cngt9aO/1?=
 =?us-ascii?Q?l9VfcI6Rz/OQYJ4bxCnGt0I0A8p79R0d9YGOCnym8WGOLMbjseIIYXQvcgVx?=
 =?us-ascii?Q?lP6UQpyE+Xpt4HogdhGnA3QeySbHUw9R3a5ietXUaHhv3WJkovGaMOeYpEOq?=
 =?us-ascii?Q?E9nfVlsItv/868Z3sXnBOV7cWyvxdjLkfeBwF1pWK8sKZ6O9lynSYHyRlnQb?=
 =?us-ascii?Q?0yGKJmWngItlo7U9NFzqBgsdu+U0q+InbJQ6dEnwy/FSlX15VDOlqWwVRm+8?=
 =?us-ascii?Q?toYyz5EfRUAw9MRiw2EPN+hOlqI3F4onpV5jNo6vEiYnRM4vZtCh9RkTY0Rx?=
 =?us-ascii?Q?LFzTZSJ4rwsLvWspedQzx+pKDWbxKsyn8YHLF3r3Udob1xHcc0lIOLebgZhw?=
 =?us-ascii?Q?zym1dmSkd892rua293OiHRky1vaK4IGQeCgMq4h9y5XgUzE60fFKumjDNRt+?=
 =?us-ascii?Q?pZMPfO6di6cxtanpNQdF0FEFqXxPnQxxYyZCRlzCJbM5jd8+INWgdomA/pz8?=
 =?us-ascii?Q?v/6ii/6lja/+rzlES8ayXYcKySJ6mOT+XGfG4h5A7JZee1tF4ymVR4TgspEP?=
 =?us-ascii?Q?sa9IiTLMxRSPpIEyovGaQT80X7Gtgf3q72s/KZgw/s6d1tsW5PuNgdD+He6/?=
 =?us-ascii?Q?QQZpTqzcgQ4GgZW0HkOiH3flnH62y+vAT+0xD2w2iZlD98qPWgd8xyJSF2yR?=
 =?us-ascii?Q?4qGlspuGi4qy2bLthNEL0eq93+lg9v6/1M3ID7amwSmStUeEysA4tL1IAKUr?=
 =?us-ascii?Q?iiL7O9y4GCIK7DZMxYTfu6yyBFZ2R1isVUW9R61z0GFf40GlKcDMt1bJmmoV?=
 =?us-ascii?Q?xGVBBcmwUF3QD6Ivrv+sWgp19tvAzEilOQ6JuuDVyqIIs+mkN29MlUXYIqPm?=
 =?us-ascii?Q?F8c2/29TDaxiTtiRb/8HfzY6LwX4FZl8ayFRoP1VJbpSQZI907m8YhWQD+E8?=
 =?us-ascii?Q?zJoelLC0t9LaNiQ/THZgF68u2sWmWkQO2cWDNF6idU4vCDqe3hdcnnN3Lnep?=
 =?us-ascii?Q?pEdk7JLt+QrVntQ6o5nuWwwfPvGXhOfUWO9KUtL1eWJHqMirvzhYuq79Mde/?=
 =?us-ascii?Q?LNWlMYBBlia2kHc=3D?=
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 08:49:49.4536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f04ed284-8284-46f5-d954-08dd5c8bdaaa
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B91.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9044
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
2.34.1

