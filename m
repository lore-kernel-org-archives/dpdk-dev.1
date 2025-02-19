Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2B6C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 13:43:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04D63411F3;
	Wed, 19 Feb 2025 14:43:40 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013055.outbound.protection.outlook.com [40.107.159.55])
 by mails.dpdk.org (Postfix) with ESMTP id 7EF42410EE
 for <dev@dpdk.org>; Wed, 19 Feb 2025 14:43:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAtY6TTxdFbO/z0VJUSV4V6Z4ypOiZR2RzExn5xm1dnMwOgsJA2/oPdOZqXCyBj2GARh/2bMPPljrQOrJ0ipkaTcJd2qqLCledibPR64WN2IoboVnfEUaFY04TT2dZD3OKcXP55jgElcwvO/kAULBZz04HO4Tc6xYpVvD8DR3UZsvni+lggWQD77D6v7wpuQzFX4BzDuav+83OAh5xhYypWNINa8IqdFDQlvoZ1Sp8msNGhyM4sX8VvWvybSwIehWYiLBZTrOdB+wwr4U/C2eOho/Zhk0x0gpMwh+nVqbr3zeaWcAinDvibkgpET3jIZVOpnSyPN7SdJvYW1fPBwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gnjswsq/EDevsB7dSaE3iNoVbU6HrfKTZxj8nAzsaTo=;
 b=uL40h03f6JsPKuigFfzrfOaoKCjaQCApjDmr2aC4Q/y/CG02pvZyuMEXmFeIXi4338XU0Ol+EDO21w8VNpI0lD6D9qF4gX1v6UaXxam3Vv6RBPem94odjiilTjY6lTjzQpsJomt406F5hw8OPU4FG3nUxYcNX2SnBb+LVs8ZwsruTIDV0xtVYTJ24VRj8XHdprx4UJ7eEnazG2K3ZetI/Srh0PN89P9VYWUt+7O+q3AEqE2hMNf+qZlMJR7dLpApL4iGmkgtqbaZ7+lgidvc1YccDOx6peNicFBlVAFGTU+x8vZqTAbfVEJmxNaRF88EiVCkxJVwNqnD8sxidJ1x2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gnjswsq/EDevsB7dSaE3iNoVbU6HrfKTZxj8nAzsaTo=;
 b=dKtUmxCKH7F8/ae4Kt8cDspySsqR0nt03Uh6mcGyue71Ij9tN7VVJxF9tnu+kij0mGrgVeJ1RgbWtG+gmFBf+3TOnfTH6L3qWvpUKrcXE6JTjtg86XsG4pCgZL0L46tT3dog/qI4L1dFHl0PO3AABYJa5OvDRmQE57U8w1dnFnEMhYQLFrfKbGITHbn5yUwNK3CPN0VZXfwB0UPCGlI+Vt3kBcZZXDrr/DeI0sX7Vle/TS1gue5Xd0ig7dqyQKEqKWn+DcGnyZ/dawU/LbOFn8oGCaWDf0WCfYBl62JyYMx5h433FpxHNC9Pw88LlBT4BnW36+xTnifKv7E7BbLRKA==
Received: from AM6P191CA0082.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8a::23)
 by GVXPR07MB10217.eurprd07.prod.outlook.com (2603:10a6:150:227::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 13:43:35 +0000
Received: from AM4PEPF00027A6A.eurprd04.prod.outlook.com
 (2603:10a6:209:8a:cafe::50) by AM6P191CA0082.outlook.office365.com
 (2603:10a6:209:8a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Wed,
 19 Feb 2025 13:43:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM4PEPF00027A6A.mail.protection.outlook.com (10.167.16.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 13:43:35 +0000
Received: from seliiuvd00917.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.62) with Microsoft SMTP Server
 id 15.2.1544.14; Wed, 19 Feb 2025 14:43:34 +0100
From: Luka Jankovic <luka.jankovic@ericsson.com>
To: <luka.jankovic@ericsson.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <mattias.ronnblom@ericsson.com>,
 <pbhagavatula@marvell.com>
Subject: [RFC v7 3/4] eventdev: add atomic atq to test-eventdev app
Date: Wed, 19 Feb 2025 14:43:24 +0100
Message-ID: <20250219134325.1195531-4-luka.jankovic@ericsson.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20250219134325.1195531-1-luka.jankovic@ericsson.com>
References: <20250124095937.1436673-1-luka.jankovic@ericsson.com>
 <20250219134325.1195531-1-luka.jankovic@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6A:EE_|GVXPR07MB10217:EE_
X-MS-Office365-Filtering-Correlation-Id: 491a6144-eec7-4d83-31aa-08dd50eb685e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gZqtaYFo7iLZ7Izko2QoGbtZjzDFIWRWSKGN7ROawyxWssDc2HL0p068bJ8D?=
 =?us-ascii?Q?UC4wc7BpenZZLxtQY28VtmKP/FHJ+LLo5F7UvGA7LTba+xUhw7trd8JwGlyI?=
 =?us-ascii?Q?rzSCTz30bh9heSmfc+AuXh7589ZCa31SSn/GfuALaO8Ppu/w8XTQdfccfZkC?=
 =?us-ascii?Q?mR3J3QNIqH+EyLB7hUiNZX0ENzOF5/cmZHnXJV5w1cRCqtzWnFLjERe09oXh?=
 =?us-ascii?Q?GsoCKWMJ8sHO59QzmlGA/nmyaBslwHhK1/FcBZDCPglyBNl99WMkbTt4lC1t?=
 =?us-ascii?Q?i1qvYklibNgKjTyw+zOdTsUm3nPfTyWxkO51fe/zxaKh6/E9jJ0FDRyyYQ/K?=
 =?us-ascii?Q?FKid6EmzFB2h1NO5y/YNDszM95vcudZUdw08EfIz6YdvAAzKmlqL8o6qj9Ij?=
 =?us-ascii?Q?+QrKiOcMr/WIR8L6UbwYoSDRBhsLoIOkTg+V5+v+VvP01XvH7TswJtECrNhp?=
 =?us-ascii?Q?NFyL5ZP+VSyK/ZO6yEouQLGDPe4t5FzjeIuq2qAnNfYFZJxxvgWNm4C/S03t?=
 =?us-ascii?Q?Fcnk7pqw3N0q9loOEUWEkFS3EEoAQ6nsOeP1JqCkw5Q/UekRxh0HndUHsQ5A?=
 =?us-ascii?Q?flc9JBWeIHnV5hTc4wG10OTEnKFtIzt3DBUr4cJFWOOzswMVv2k2x7kQsg9g?=
 =?us-ascii?Q?+RmyQbAqU57Rt11pk4+fBO7sW8CQGnO4Y+qlkYz0t9rqM/EE0PXnHeD9LWtE?=
 =?us-ascii?Q?wDUk2pb1uNV4aUni4PbuCENGlT5dsngDofu6dfhWFSuqXpFW2Mn8zVmV+X+f?=
 =?us-ascii?Q?vqzr+KpCQi9Tm9m5CvQEVkBOOb/D+6u0ASRtaVGsyJtCQRH87llTmmibCopm?=
 =?us-ascii?Q?PdnC9dUYGy3rIcdo56Lei6g6T38gKSCaE/dvPWq26zoNpVDiQOJGf04GEQwL?=
 =?us-ascii?Q?P0HMm6dJ76ymPY+BaEqxPWuOg73E25BRFUQi6xTR/AXjlLkg3k3btfbX2XeV?=
 =?us-ascii?Q?rWmE7uONcFsaYu49/0BcmxDQRYnU0C1h5NL2SKIUivwtZW37d1IPLdikQtt5?=
 =?us-ascii?Q?4gFd3x6tkeTKj4C+k1HubZ+b12zNqGSrGMy6PbT1F5tTKQdc3RNCFdCcTVgI?=
 =?us-ascii?Q?CbLesBUf1hS43d20TiVL5PFMcne0bA+M/B/Uw82iBgsM2+yjOr868ZVV3HV4?=
 =?us-ascii?Q?D2jNLN9mUBu6Wk2jw9JqtIul8XKyIxOZfjqXwM0vnisxg/x/T5oruXBYBO8e?=
 =?us-ascii?Q?MJ1wt6q4jLuCnZ2bUyoXmaJP3eQWtrZAbYDyve9+Y4zokF/mRaU3neXQDphS?=
 =?us-ascii?Q?geJfS3PsPENymNRHwY5d3kVTyw/MDex+L0JSJhao16E6tmE8y9kSGoyKT3Wh?=
 =?us-ascii?Q?IPw3a4M9/0Is3JUxAE0HGHMfssTyD04m0b9jsB3WQV2c1lRr43YXhK4h64zO?=
 =?us-ascii?Q?b63N7Ki4YApvPaW55v49FWsMLAk5rxb55JlpbizsZm4P5oAUgKl1ic9mcy6k?=
 =?us-ascii?Q?eECsdQXqk2NweW45VHe/fHZq3Z9dP6VfmU0clzfWZi7dSWKhnMuJwXtEh/jB?=
 =?us-ascii?Q?8Gqdrx2kwXOL3vw=3D?=
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 13:43:35.4549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 491a6144-eec7-4d83-31aa-08dd50eb685e
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB10217
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

Add an atomic atq test to the test-eventdev app. The test works
in the same way as atomic queue, the difference being that only one
queue capable of all types for both stages.

Signed-off-by: Luka Jankovic <luka.jankovic@ericsson.com>
---
 app/test-eventdev/meson.build       |   1 +
 app/test-eventdev/test_atomic_atq.c | 216 ++++++++++++++++++++++++++++
 2 files changed, 217 insertions(+)
 create mode 100644 app/test-eventdev/test_atomic_atq.c

diff --git a/app/test-eventdev/meson.build b/app/test-eventdev/meson.build
index c5d3974bb4..b7f0929583 100644
--- a/app/test-eventdev/meson.build
+++ b/app/test-eventdev/meson.build
@@ -15,6 +15,7 @@ sources = files(
         'test_order_atq.c',
         'test_order_common.c',
         'test_order_queue.c',
+        'test_atomic_atq.c',
         'test_atomic_common.c',
         'test_atomic_queue.c',
         'test_perf_atq.c',
diff --git a/app/test-eventdev/test_atomic_atq.c b/app/test-eventdev/test_atomic_atq.c
new file mode 100644
index 0000000000..ff9723ca7b
--- /dev/null
+++ b/app/test-eventdev/test_atomic_atq.c
@@ -0,0 +1,216 @@
+#include <stdio.h>
+#include <unistd.h>
+
+#include "test_atomic_common.h"
+
+#define NB_QUEUES 1
+#define NB_STAGES 2
+
+static rte_spinlock_t *atomic_locks;
+
+static inline void
+atomic_atq_process_stage_0(struct test_order *const t,
+		struct rte_event *const ev,
+		uint32_t nb_flows,
+		uint32_t port)
+{
+	const uint32_t flow = *order_mbuf_flow_id(t, ev->mbuf);
+
+	atomic_lock_verify(atomic_locks, 0, flow, nb_flows, t, port);
+
+	ev->sub_event_type = 1;
+	ev->op = RTE_EVENT_OP_FORWARD;
+	ev->sched_type = RTE_SCHED_TYPE_ATOMIC;
+	ev->event_type = RTE_EVENT_TYPE_CPU;
+
+	atomic_spinlock_unlock(atomic_locks, 0, flow, nb_flows);
+}
+
+static inline void
+atomic_atq_process_stage_1(struct test_order *const t,
+		struct rte_event *const ev,
+		uint32_t nb_flows,
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
+atomic_atq_worker_burst(void *arg, bool flow_id_cap, uint32_t max_burst)
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
+			switch (ev[i].sub_event_type) {
+			case 0:
+				atomic_atq_process_stage_0(t, &ev[i], nb_flows, port);
+				break;
+			case 1:
+				atomic_atq_process_stage_1(t, &ev[i], nb_flows, expected_flow_seq,
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
+	return atomic_atq_worker_burst(arg, flow_id_cap, max_burst);
+}
+
+static int
+atomic_atq_launch_lcores(struct evt_test *test, struct evt_options *opt)
+{
+	int ret = atomic_launch_lcores(test, opt, worker_wrapper);
+	rte_free(atomic_locks);
+	return ret;
+}
+
+static int
+atomic_atq_eventdev_setup(struct evt_test *test, struct evt_options *opt)
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
+	/* q0 all types queue configuration */
+	struct rte_event_queue_conf q0_conf = {
+			.priority = RTE_EVENT_DEV_PRIORITY_NORMAL,
+			.event_queue_cfg = RTE_EVENT_QUEUE_CFG_ALL_TYPES,
+			.nb_atomic_flows = opt->nb_flows,
+			.nb_atomic_order_sequences = opt->nb_flows,
+	};
+	ret = rte_event_queue_setup(opt->dev_id, 0, &q0_conf);
+	if (ret) {
+		evt_err("failed to setup queue0 eventdev %d", opt->dev_id);
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
+atomic_atq_opt_dump(struct evt_options *opt)
+{
+	order_opt_dump(opt);
+	evt_dump("nb_evdev_queues", "%d", NB_QUEUES);
+}
+
+static bool
+atomic_atq_capability_check(struct evt_options *opt)
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
+static const struct evt_test_ops atomic_atq = {
+	.cap_check        = atomic_atq_capability_check,
+	.opt_check        = order_opt_check,
+	.opt_dump         = atomic_atq_opt_dump,
+	.test_setup       = order_test_setup,
+	.mempool_setup    = order_mempool_setup,
+	.eventdev_setup   = atomic_atq_eventdev_setup,
+	.launch_lcores    = atomic_atq_launch_lcores,
+	.eventdev_destroy = order_eventdev_destroy,
+	.mempool_destroy  = order_mempool_destroy,
+	.test_result      = order_test_result,
+	.test_destroy     = order_test_destroy,
+};
+
+EVT_TEST_REGISTER(atomic_atq);
-- 
2.34.1

