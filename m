Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4538C021B0
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 13:43:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69FE9410FC;
	Wed, 19 Feb 2025 14:43:38 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
 by mails.dpdk.org (Postfix) with ESMTP id 1D41A410E8
 for <dev@dpdk.org>; Wed, 19 Feb 2025 14:43:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqxQ1VDCGxv4hyMCyhXb1E9/L8z+OwAHGealOm7RW9lPCsQeW3F9e3aL3SBAZhbD8g5tT/5aHcX3IeP/zT3U/V2MHB1UHqXG0KjJWG7UJCU5awLTcTO6FFtNj6WeQLHdw0Ln+Q/7hQFAosjyEbfG+hwINderIfxnVpQf4QXdeNF6VAoYTOQ9aEShDliWz2FLkv0dt5qnMnfDeo68LKL+PvFbpmMHi6b6PxTsTrq+l5kiYgtMQ4gzrnUUhdOTomSA8BeiBYojuoCThgCiWakbsz5ipjacc+W1YDAXOyCMOCM/7GvoJdoUsLIZ23Y160QjmcL5f3oIRIyDm4tAN6IvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dF4/9f0PVbRH0fu/eKU/PpZvdcIec9W/2LKT3lEvyDo=;
 b=VsXsjiRBgMejNMQwcpwm/iLthkEWN+tI8cP6781LHXY8ym3LF3na9IIgHGO0ILfSkcyDnczufUvAYAb50YEBOBMic7TwEt/VLRJILSg0/8c3zA6bFwGuGFcSW+/Uad6aE6qYB7wp++8FABGji+s8AZorNFjbLoXD5qM/FTVC/bJjx8o1kX67w7VhD5Fv1tezRit61WBwyL8uWXmQ3uC+zmsSfs83XbrV/bn7prp4Gbmw8OBf0QGV4PBHe5eJhPshX7Fri/YupAOA9Bk737tZBtyxmNNRvP9dJPEISq00iJq1/y+oV4te/9nmtPiDW/vhBHUdMw5bhSHGIyUKblvFJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dF4/9f0PVbRH0fu/eKU/PpZvdcIec9W/2LKT3lEvyDo=;
 b=PGWrTFIwtHTyC0DMhrUuZS6xm1zSerRdRm8HGfIKw5WWch4pNgjzMko/5/q/nciZU52OYp3cGG2xi7ESN5DkW6moWqMjPYzIlxouuIKJOkXsfstNK8Glh9NAlk9FWslrsY/WwwWtwEKiRaazSFYgYEHJ9uXb45eZHEpEAzxq1XQbBcVnVdSnsy9fCZmgjyd89eKZXM4C22R0ELt2AVaBn54/YrKskdiqGaS/GmSJf+9JR46DI2+VSKeUowZ35ncSV4cHlkIkWPwVEvf51vVtlu3HgjY6eVEDKoUhmWHk7GU2D/+OeHZ6fMS1RvrBnunmU0jPPRTxfMsaXtXEuz2CkA==
Received: from AM0PR05CA0082.eurprd05.prod.outlook.com (2603:10a6:208:136::22)
 by DBAPR07MB6631.eurprd07.prod.outlook.com (2603:10a6:10:189::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 13:43:33 +0000
Received: from AM4PEPF00027A67.eurprd04.prod.outlook.com
 (2603:10a6:208:136:cafe::13) by AM0PR05CA0082.outlook.office365.com
 (2603:10a6:208:136::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Wed,
 19 Feb 2025 13:43:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM4PEPF00027A67.mail.protection.outlook.com (10.167.16.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 13:43:32 +0000
Received: from seliiuvd00917.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.62) with Microsoft SMTP Server
 id 15.2.1544.14; Wed, 19 Feb 2025 14:43:32 +0100
From: Luka Jankovic <luka.jankovic@ericsson.com>
To: <luka.jankovic@ericsson.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <mattias.ronnblom@ericsson.com>,
 <pbhagavatula@marvell.com>
Subject: [RFC v7 2/4] eventdev: add atomic queue test to test-evnetdev app
Date: Wed, 19 Feb 2025 14:43:23 +0100
Message-ID: <20250219134325.1195531-3-luka.jankovic@ericsson.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20250219134325.1195531-1-luka.jankovic@ericsson.com>
References: <20250124095937.1436673-1-luka.jankovic@ericsson.com>
 <20250219134325.1195531-1-luka.jankovic@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A67:EE_|DBAPR07MB6631:EE_
X-MS-Office365-Filtering-Correlation-Id: fab3fcd7-7a2f-4c0a-a665-08dd50eb66d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dO3JnqIO5QBmRAmZlxCUkMRN57uEY8Znb53P3IPIkUCGrTSnjx1LGMW9cPoQ?=
 =?us-ascii?Q?cKNfbesjSMPeeFN18W38O0hoeeuqySYvaMpXq6Sio98PWTswdT4lZHm/WfwV?=
 =?us-ascii?Q?bzBrGvxEWueAU8lRhoDdKOAdGws4KnObarxnZIsp1qkwYxdg5mdhVPOmANbr?=
 =?us-ascii?Q?Pqwq2k5T30k1KIFDaOM/IpqCX013egIbLmt8IB7J+RC+9uYZ6T5p+K8uC04/?=
 =?us-ascii?Q?jaka954Z+aY/RosPKrC4Pm8eD8xvso4tS9xDaItJhjCFypY4NXO/KjaP9zk+?=
 =?us-ascii?Q?XLouZau80yvkmkObKrSYE9mjDKhF7gILbTIkiMR81FksWQr+QnkjjlDJN313?=
 =?us-ascii?Q?1W+bEa5IY4AYNKPSR9KzcCHTJfKSnWqIRZ134QsoDupOne8IgxCSqqbOaKw9?=
 =?us-ascii?Q?z46moUEO9f1YFE/+0Tvf3X2Xfw8slTFkFRZVk4yQNuq1I3NZ7dhRwIqWUbrl?=
 =?us-ascii?Q?ef0LpHwrvyk/M/b61Rgw6pMlLhpXyKaLn/tc985S5QSEHytjztKDDuQ9upTH?=
 =?us-ascii?Q?6tH9ECLdE5oKRDuINF14D8G8md/lL7V87iR5czpl7b+MUGSHgwwnPKA230Zr?=
 =?us-ascii?Q?4LYSt1ICdYe0JscH9bqBb/tH+1Tki/3rqmzkNjGfheIvMFatk2UTjZaNhW5L?=
 =?us-ascii?Q?F0HzYQcascFA7aD63+PVe3jrYZbEgRwXgJWorPUaSMfU7BtHLXWeCAp6HFHs?=
 =?us-ascii?Q?zuxD/VU2cxJjM5fQmsWAtTXVwPXNqJy/NPbRLQWCn974/hHsyNx+ShnPJzqp?=
 =?us-ascii?Q?4C+Z/oeEb+aLGIkQbIBY/hweB8DUl61hqCwTtzelUz5NLNGHj9GsolePnYv9?=
 =?us-ascii?Q?p1dpoOgr9IZbARYniuxNPr7AwK5Qix8T6xnBhA2MlHMuCkMLSa6P+zgm+pyq?=
 =?us-ascii?Q?YnbMwangQ3EFPLWlX7b1Flkb9ed++jSqXB/dLQxmKtUEKLLqzkx5a+XWoNF1?=
 =?us-ascii?Q?w79cXo6hyDHeQt1VOrCF3TnB6mFAoOdz5if7jlviO42l4h53yTB6++QDP0lU?=
 =?us-ascii?Q?/FIAeorJ707Nl8LgzORYpoB0anHy7txvl9C+oFPOClGMyIT7Vf9Wx5YV2Iid?=
 =?us-ascii?Q?gVyuaylLXjqxuY/Z1TwXfCewsax2OTaEX5qkjngmEFd2IVVLpL4ZquXy9HkO?=
 =?us-ascii?Q?UegVq1G/wo+HumTXDufGFGWbiVl3f+UIN21WB4ISLtJpp1iiSdTfQUto82Ak?=
 =?us-ascii?Q?8QAuV/GR9p2TpZqDTJ43xp8ZmN+9ZYta/04cQYmhFde2XqEevfrfSzEbKmb3?=
 =?us-ascii?Q?1nOUCoMuButQaIkZXj3CLTyLon1/W0pvh6w8DZ/GLOth7TFFPoTKCtncJQDc?=
 =?us-ascii?Q?LJXbI3EyrOHozsBjuiQB1PWGE2BV5JsmNbtgofusVd2psauOiFuztHpyvWWH?=
 =?us-ascii?Q?jIih1BdWbcTqxCjjVgpz5phWL39WnpEib4d/dho4wmkrsxnDnqRYbBq2AP10?=
 =?us-ascii?Q?wwSPmAMOKOu3LkBlI0J2IEuPTLr3pEngdVAdV9j5HgsQrrCVDehfutcN+CHo?=
 =?us-ascii?Q?0twhjV2MrI9fyE4=3D?=
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 13:43:32.8930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fab3fcd7-7a2f-4c0a-a665-08dd50eb66d9
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A67.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6631
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

Add an atomic queue test to the test-eventdev app, which is based on the
order queue test that exclusively uses atomic queues.

Signed-off-by: Luka Jankovic <luka.jankovic@ericsson.com>
---
 app/test-eventdev/meson.build         |   1 +
 app/test-eventdev/test_atomic_queue.c | 230 ++++++++++++++++++++++++++
 2 files changed, 231 insertions(+)
 create mode 100644 app/test-eventdev/test_atomic_queue.c

diff --git a/app/test-eventdev/meson.build b/app/test-eventdev/meson.build
index 78af30cb10..c5d3974bb4 100644
--- a/app/test-eventdev/meson.build
+++ b/app/test-eventdev/meson.build
@@ -16,6 +16,7 @@ sources = files(
         'test_order_common.c',
         'test_order_queue.c',
         'test_atomic_common.c',
+        'test_atomic_queue.c',
         'test_perf_atq.c',
         'test_perf_common.c',
         'test_perf_queue.c',
diff --git a/app/test-eventdev/test_atomic_queue.c b/app/test-eventdev/test_atomic_queue.c
new file mode 100644
index 0000000000..46f9ca98fa
--- /dev/null
+++ b/app/test-eventdev/test_atomic_queue.c
@@ -0,0 +1,230 @@
+#include <stdio.h>
+#include <unistd.h>
+
+#include "test_atomic_common.h"
+
+#define NB_QUEUES 2
+#define NB_STAGES 2
+
+static rte_spinlock_t *atomic_locks;
+
+static inline void
+atomic_queue_process_stage_0(struct test_order *const t,
+		struct rte_event *const ev,
+		uint32_t nb_flows,
+		uint32_t port)
+{
+	const uint32_t flow = *order_mbuf_flow_id(t, ev->mbuf);
+
+	atomic_lock_verify(atomic_locks, 0, flow, nb_flows, t, port);
+
+	ev->queue_id = 1;
+	ev->op = RTE_EVENT_OP_FORWARD;
+	ev->sched_type = RTE_SCHED_TYPE_ATOMIC;
+	ev->event_type = RTE_EVENT_TYPE_CPU;
+
+	atomic_spinlock_unlock(atomic_locks, 0, flow, nb_flows);
+}
+
+static inline void
+atomic_queue_process_stage_1(struct test_order *const t,
+		struct rte_event *const ev,
+		uint32_t nb_flows,
+		rte_spinlock_t *atomic_locks,
+		uint32_t *const expected_flow_seq,
+		RTE_ATOMIC(uint64_t) *const outstand_pkts,
+		uint32_t port)
+{
+	const uint32_t flow = *order_mbuf_flow_id(t, ev->mbuf);
+	const uint32_t seq = *order_mbuf_seqn(t, ev->mbuf);
+
+	atomic_lock_verify(atomic_locks, 1, flow, nb_flows, t, port);
+
+	/* compare the seqn against expected value */
+	if (seq != expected_flow_seq[flow]) {
+		evt_err("flow=%x seqn mismatch got=%x expected=%x", flow, seq,
+				expected_flow_seq[flow]);
+		t->err = true;
+	}
+
+	expected_flow_seq[flow]++;
+	rte_pktmbuf_free(ev->mbuf);
+
+	rte_atomic_fetch_sub_explicit(outstand_pkts, 1, rte_memory_order_relaxed);
+
+	ev->op = RTE_EVENT_OP_RELEASE;
+
+	atomic_spinlock_unlock(atomic_locks, 1, flow, nb_flows);
+}
+
+static int
+atomic_queue_worker_burst(void *arg, bool flow_id_cap, uint32_t max_burst)
+{
+	ORDER_WORKER_INIT;
+	struct rte_event ev[BURST_SIZE];
+	uint16_t i;
+
+	while (t->err == false) {
+
+		uint16_t const nb_rx = rte_event_dequeue_burst(dev_id, port, ev, max_burst, 0);
+
+		if (nb_rx == 0) {
+			if (rte_atomic_load_explicit(outstand_pkts, rte_memory_order_relaxed) <= 0)
+				break;
+			rte_pause();
+			continue;
+		}
+
+		for (i = 0; i < nb_rx; i++) {
+			if (!flow_id_cap)
+				order_flow_id_copy_from_mbuf(t, &ev[i]);
+
+			switch (ev[i].queue_id) {
+			case 0:
+				atomic_queue_process_stage_0(t, &ev[i], nb_flows, port);
+				break;
+			case 1:
+				atomic_queue_process_stage_1(t, &ev[i], nb_flows, atomic_locks, expected_flow_seq,
+						outstand_pkts, port);
+				break;
+			default:
+				order_process_stage_invalid(t, &ev[i]);
+				break;
+			}
+		}
+
+		uint16_t total_enq = 0;
+
+		do {
+			total_enq += rte_event_enqueue_burst(
+					dev_id, port, ev + total_enq, nb_rx - total_enq);
+		} while (total_enq < nb_rx);
+	}
+
+	return 0;
+}
+
+static int
+worker_wrapper(void *arg)
+{
+	struct worker_data *w = arg;
+	int max_burst = evt_has_burst_mode(w->dev_id) ? BURST_SIZE : 1;
+	const bool flow_id_cap = evt_has_flow_id(w->dev_id);
+
+	return atomic_queue_worker_burst(arg, flow_id_cap, max_burst);
+}
+
+static int
+atomic_queue_launch_lcores(struct evt_test *test, struct evt_options *opt)
+{
+	int ret = atomic_launch_lcores(test, opt, worker_wrapper);
+	rte_free(atomic_locks);
+	return ret;
+}
+
+static int
+atomic_queue_eventdev_setup(struct evt_test *test, struct evt_options *opt)
+{
+	int ret;
+
+	const uint8_t nb_workers = evt_nr_active_lcores(opt->wlcores);
+	/* number of active worker cores + 1 producer */
+	const uint8_t nb_ports = nb_workers + 1;
+
+	ret = evt_configure_eventdev(opt, NB_QUEUES, nb_ports);
+	if (ret) {
+		evt_err("failed to configure eventdev %d", opt->dev_id);
+		return ret;
+	}
+
+	/* q0 configuration */
+	struct rte_event_queue_conf q0_atomic_conf = {
+			.priority = RTE_EVENT_DEV_PRIORITY_NORMAL,
+			.schedule_type = RTE_SCHED_TYPE_ATOMIC,
+			.nb_atomic_flows = opt->nb_flows,
+			.nb_atomic_order_sequences = opt->nb_flows,
+	};
+	ret = rte_event_queue_setup(opt->dev_id, 0, &q0_atomic_conf);
+	if (ret) {
+		evt_err("failed to setup queue0 eventdev %d err %d", opt->dev_id, ret);
+		return ret;
+	}
+
+	/* q1 configuration */
+	struct rte_event_queue_conf q1_atomic_conf = {
+			.priority = RTE_EVENT_DEV_PRIORITY_NORMAL,
+			.schedule_type = RTE_SCHED_TYPE_ATOMIC,
+			.nb_atomic_flows = opt->nb_flows,
+			.nb_atomic_order_sequences = opt->nb_flows,
+	};
+	ret = rte_event_queue_setup(opt->dev_id, 1, &q1_atomic_conf);
+	if (ret) {
+		evt_err("failed to setup queue0 eventdev %d err %d", opt->dev_id, ret);
+		return ret;
+	}
+
+	/* setup one port per worker, linking to all queues */
+	ret = order_event_dev_port_setup(test, opt, nb_workers, NB_QUEUES);
+	if (ret)
+		return ret;
+
+	if (!evt_has_distributed_sched(opt->dev_id)) {
+		uint32_t service_id;
+		rte_event_dev_service_id_get(opt->dev_id, &service_id);
+		ret = evt_service_setup(service_id);
+		if (ret) {
+			evt_err("No service lcore found to run event dev.");
+			return ret;
+		}
+	}
+
+	ret = rte_event_dev_start(opt->dev_id);
+	if (ret) {
+		evt_err("failed to start eventdev %d", opt->dev_id);
+		return ret;
+	}
+
+	atomic_locks = atomic_init_locks(NB_STAGES, opt->nb_flows);
+
+	return 0;
+}
+
+static void
+atomic_queue_opt_dump(struct evt_options *opt)
+{
+	order_opt_dump(opt);
+	evt_dump("nb_evdev_queues", "%d", NB_QUEUES);
+}
+
+static bool
+atomic_queue_capability_check(struct evt_options *opt)
+{
+	struct rte_event_dev_info dev_info;
+
+	rte_event_dev_info_get(opt->dev_id, &dev_info);
+	if (dev_info.max_event_queues < NB_QUEUES ||
+			dev_info.max_event_ports < order_nb_event_ports(opt)) {
+		evt_err("not enough eventdev queues=%d/%d or ports=%d/%d", NB_QUEUES,
+				dev_info.max_event_queues, order_nb_event_ports(opt),
+				dev_info.max_event_ports);
+		return false;
+	}
+
+	return true;
+}
+
+static const struct evt_test_ops atomic_queue = {
+	.cap_check        = atomic_queue_capability_check,
+	.opt_check        = order_opt_check,
+	.opt_dump         = atomic_queue_opt_dump,
+	.test_setup       = order_test_setup,
+	.mempool_setup    = order_mempool_setup,
+	.eventdev_setup   = atomic_queue_eventdev_setup,
+	.launch_lcores    = atomic_queue_launch_lcores,
+	.eventdev_destroy = order_eventdev_destroy,
+	.mempool_destroy  = order_mempool_destroy,
+	.test_result      = order_test_result,
+	.test_destroy     = order_test_destroy,
+};
+
+EVT_TEST_REGISTER(atomic_queue);
-- 
2.34.1

