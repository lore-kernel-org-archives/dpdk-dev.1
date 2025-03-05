Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADEAC19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 14:13:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9A0A40611;
	Wed,  5 Mar 2025 15:13:04 +0100 (CET)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazon11012010.outbound.protection.outlook.com [52.101.71.10])
 by mails.dpdk.org (Postfix) with ESMTP id E9BD64060A
 for <dev@dpdk.org>; Wed,  5 Mar 2025 15:13:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HG2lN7YvvBiVBZI6dEjt6zuDQyCefjOrSt+WDij2LkfxcRZZtB5s8h8+LOmn4q6j3ECGNZ9XJLnqTBW2AbiPt/o5XsgnOfXDfMJ4dv5auBNRhtnF0Ww7nE3PmTfFdtfRZknCKSpHYEzJyarUVGchRUOpFs6Yym7YIXQRbXHPwvsfndyH92xRHfDMy6fSY1+lgCfq1tOL+ihMP+9TjTMwltaLrOus0yOAdwYYfT7LMsbUwUSez+z6ThOw3tPG9JBJEjUdYAlJC9THzemoUdmcA0sJMtWUaeEuZsUjJZ42+qj+Ps6AM/CoGa3yMg4QhCl2xrMmwrXz51ugoaOYj5ydUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fZprKvdBJPkDtRtzo4cSZ30Vu5DL+CinEHreIpozVg=;
 b=yTqr/vOnSF6AjGGzaFWGobqDvCSutuRyM3Q4gGirC0ucJefQFcwUpxY7h6rLuUwiEDjuAsWeqJARjJRuz2bDFxZwQRXkZPXy+Rxc9qvLsmD6uCphzWD+Ld2ETcOHROzLaE5zMls5wKhPCIC7zLw4zcNhp3OQYsAxdAObQjcw7wI7IvULH4HAYGsOjYWNnmO4xmLFSkziyPyTDMX5VLZn+QoRLqZGBO00JBDhzE6087f6WTvCY/WGpCKkT1upgnj58nQ3A8uTBYe8lBqxvKc2TTBPoRhnF/4y0L4dpvnZIWsotJ0ItQcmTlGjR66euaAtKuC8Z5XtgFn1h3eUwp54bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fZprKvdBJPkDtRtzo4cSZ30Vu5DL+CinEHreIpozVg=;
 b=yEAb7CYtsu3FgmoKiDXSPvR2hM1XFx1awi6aI93mWq8DUZv6zeY7EthX8Cj+YW9lyjAwxA2NgFDI6SNKZDabEec41FNXa4UJQudTAJNxroXylguked1X3R1F43OEjx9l5FyJigSSEGvNKnzzKagAQLnD+Ay9kfrkY7Xcy2171a2FapgjAy4wR9tI8ieyiNePEchXnUBxQ4wPdyvxds9437iCBO1+rS1dTwROFLyTTLbRwWaUesXLColoFf1En6am96pJGinsKYlWnO1ZPKwC17AyO40ifqOMjA5FPIJ9g/NVTzk9tkcK9Cn4QR8F80/8uYk1aUrK2l1wZkubd85hiQ==
Received: from DB8PR09CA0036.eurprd09.prod.outlook.com (2603:10a6:10:a0::49)
 by AS4PR07MB8507.eurprd07.prod.outlook.com (2603:10a6:20b:4e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 14:13:00 +0000
Received: from DU2PEPF0001E9C1.eurprd03.prod.outlook.com
 (2603:10a6:10:a0:cafe::2b) by DB8PR09CA0036.outlook.office365.com
 (2603:10a6:10:a0::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 14:12:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DU2PEPF0001E9C1.mail.protection.outlook.com (10.167.8.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 14:12:59 +0000
Received: from seliiuvd00917.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.63) with Microsoft SMTP Server
 id 15.2.1544.14; Wed, 5 Mar 2025 15:12:58 +0100
From: ejnulak <luka.jankovic@ericsson.com>
To: <luka.jankovic@ericsson.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <mattias.ronnblom@ericsson.com>,
 <pbhagavatula@marvell.com>
Subject: [PATCH v9 1/3] eventdev: atomic common for test-eventdev app
Date: Wed, 5 Mar 2025 15:12:53 +0100
Message-ID: <20250305141255.3031686-2-luka.jankovic@ericsson.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20250305141255.3031686-1-luka.jankovic@ericsson.com>
References: <20250305125215.2870237-1-luka.jankovic@ericsson.com>
 <20250305141255.3031686-1-luka.jankovic@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C1:EE_|AS4PR07MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de10cce-44d2-4be7-92bd-08dd5befd5a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hf4e7oClNe6oeOvDHXaeLD81Jp+yRiSJPSE2CKOVhuEBJLyX/5WTE9/QMZHy?=
 =?us-ascii?Q?1zNfwhbr4IQp1E5TJWHwqWlwBITUxD1FSrDIxKL0DgME05UbbAYV9FXCOR8m?=
 =?us-ascii?Q?gqDReN+Gefg8o5z/9DgLhWnS7Z7b62Q8YWhuk1c1h3m/tbg3ZcYlUk0VSvua?=
 =?us-ascii?Q?trN7/vmNkyxn/3Tj8LC3rfGmKs3MmrwcqtFkLklEvJwig/IJA1AiU8quNZ9F?=
 =?us-ascii?Q?v7V5iYldbCpce86y5tWlRBqc9aMEtgHF+R0j/X0oyaAGVqajBDyQf4X7g1ou?=
 =?us-ascii?Q?FbI7sDaSm5lzn2g9ez+xJKSCjqABlS1UpW7hekBZjtxjECibpnZmwHokAjqu?=
 =?us-ascii?Q?8c0AzQOVrl21o1muZL9KdrhTQjYVP5XfzdulO6RtRitBGMUKUhUqaw0x7oOB?=
 =?us-ascii?Q?fY+sFABWJd+Z8U10gHzQ5PMQ8NNPjtIwXzSUUow/U0TtvZ0AWb+yk0IONjvf?=
 =?us-ascii?Q?P8k6nSOJsxsK9ZAMOF0D3K76MCyLr9YuIPAPpLSIW7KxY8BRKVgtVXKVKacp?=
 =?us-ascii?Q?8CJlYqzZnhDehysf7dPZ3MGNrxLUrDnLHg6BYvXFlkrZcX5EhpkVc+lFZ4Tz?=
 =?us-ascii?Q?23RT4FzS2yDGRvM70yI+PT5Y6tKEA+RApdVWSElgNb+kkbVhpS3BSfyNauOA?=
 =?us-ascii?Q?cLFYUtsHoAMHGkt9fAAK45Cc/9aQwP9yLGdrKOp70lSgd0P8obfeA5GxlkRz?=
 =?us-ascii?Q?p6LiCNQ7n+Qm1SEpuIGLgnca5I6w5XBZYDiXUPlzDDG6SaqOiIurjWpA5xaA?=
 =?us-ascii?Q?fqEJnMvjBqcidI3M3smhEltHEgr/C2s+koU+QdUI0XMkbBsLmo7AIfVagZ9S?=
 =?us-ascii?Q?mgYlNFspXHGMpFWgnG2aXP+YdVtxLByP42caaiLKUXDJ4bpoB0ybemHziG7u?=
 =?us-ascii?Q?C9ejLOLKXqSRTaR3hdmSmqRdAhUaNKqw8gWv2SPc5ZztKhsWlwaAKp3NpCVI?=
 =?us-ascii?Q?eyL2pja1yaLQSOp9+lYpwv+tUPoRq/vfJFnbY2q/zfTZ41OrUnvBO4O4lcZq?=
 =?us-ascii?Q?p/JULCp+pZnqQ/P5TJ3luPPgBMk0EQi1FtAsvRBAATw4wSp/Z8iYIEyQTu+L?=
 =?us-ascii?Q?FA9mU3Q1hMHK+UQ/EyEHsoG3ieDv+9YV9nCU8sRnp1fBdSR65thg75N+wJ5Y?=
 =?us-ascii?Q?g0KnCow8MCpBxilxLWfTi3IGgtlKWD50FZVf+sTuX+vqKYNm33UotsCDu1qj?=
 =?us-ascii?Q?rKCcg0RcC51+RV4ZStq66RMwslPZHlIx1PepJ2B1tYzhamOPBfLUxbFKXNyc?=
 =?us-ascii?Q?4IYJDrGB4Krtgx6bZ1OcknagVmhjDhtF/2BunYQvJRO3rRi5TKGRSrl0UEn1?=
 =?us-ascii?Q?H9zFqOJuEDKUNA7vlzPr2BiGv8EtAnY8PxYldRhOsDKGiE6S16FUdGWM3T0B?=
 =?us-ascii?Q?ZNUN0hAxrqkGnj3bn+afCny9Y7oW42kWo6yA5y7Lqa0fIyN39Zd3vEfWjYa0?=
 =?us-ascii?Q?eY1vYt3RJqW4Cm3+Zt70ysYLVq4k9JqinOhpwAbmKZWeCHpgDbq9It8RpAO1?=
 =?us-ascii?Q?+c7dTKmWtb2nmfpE8Zl3BasUW8etxxYWOukw?=
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 14:12:59.5668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de10cce-44d2-4be7-92bd-08dd5befd5a9
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8507
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

From: Luka Jankovic <luka.jankovic@ericsson.com>

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

