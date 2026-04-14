Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE54F9D0F3
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 19:41:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB7344028F;
	Tue, 14 Apr 2026 21:41:00 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010048.outbound.protection.outlook.com [52.101.56.48])
 by mails.dpdk.org (Postfix) with ESMTP id 4136A4028D
 for <dev@dpdk.org>; Tue, 14 Apr 2026 21:40:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqClSY9PS+wkUqtAwajI99XPRNE2S0WXkZDDZ7idRcGoc0mh95d14IAgncjVpwhF1OeLUYbU8Hw5Bl566KM0EY8l/44jNS9ZqgPjw4FrLDbPUHVl5iUq8x/DtsqP+HmDshExUGwpPfD9xFkWyWhQVLg6kv4d0KT5NOR6xqBOt+FgWHSCOtQg1cXB+MPPES1uCU1SuSPUuxcMSrx3xV1WEbMweA0imkByHjyJLHNGdJJho6yPpYYHbaSlhdZYwFzm45UM/hlNlFuKJbG/hatO9MWV851AJggfD66qGRuVK9DngFVoyqSyBH6txqEM6Glxk6UwcMzVLLHItAdnhRGeoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J422DUjrXoQuV53SZqbij8969m5oH40vn15nJCdpsmE=;
 b=nxa8TSeYEsnoGdG9N0L+62jSQ2A8wu/93UlscHjvPvw4Ru6bbZErEz8e1qLGQL3iOVEXA8zbwY8KsEGlGR0ro2sfsmYyWfeCLZp/TlMSY0erpE8FINZN2BF7bxoacWI5Zb926SiVgterJvmO8NqXNi2iHQjwPhSNVEoA3gPIT6hC23XlbtuKgmNnbBuSnj44dwFiY1vdAigzwttDgMn22TdG4SbnbhI2ZeXqSTDAON4+SupvMpxy90Ltcb/cbrf9qZxl6x11JBe/ZlXLLzSxaCrzWyooEnbyDArwAH5PfE8EJ6HSKHQYJWhEBm0clsupI6FlCGk8CRXXw/zKxSdJDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J422DUjrXoQuV53SZqbij8969m5oH40vn15nJCdpsmE=;
 b=u3EbpZle/V7VqawtHbkHkNczI59a4cA3IG2CvJ/YzmUANpqngK+f7WB2Wba0IDc6VV1yQ9VcwLcs1ni5Uv3bnooCTmegTIOI/y2pvFzF5difg7fIHt6N4H51ZV8cb+3lT5XL/CWB0FVEpnj1t+Xmh7hwlBAJ9U5J6Y6naABssRk=
Received: from CH2PR10CA0020.namprd10.prod.outlook.com (2603:10b6:610:4c::30)
 by SJ2PR12MB8882.namprd12.prod.outlook.com (2603:10b6:a03:537::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 19:40:51 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::63) by CH2PR10CA0020.outlook.office365.com
 (2603:10b6:610:4c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.47 via Frontend Transport; Tue,
 14 Apr 2026 19:40:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 19:40:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 14:40:49 -0500
Received: from BLRVIVARGHE.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 12:40:46 -0700
From: Vipin Varghese <vipin.varghese@amd.com>
To: <dev@dpdk.org>, <sivaprasad.tummala@amd.com>
CC: <konstantin.ananyev@huawei.com>, <wathsala.vithanage@arm.com>,
 <bruce.richardson@intel.com>, <viktorin@cesnet.cz>,
 <mb@smartsharesystems.com>
Subject: [PATCH v5 v5 2/3] app: add topology aware test case
Date: Wed, 15 Apr 2026 01:08:20 +0530
Message-ID: <20260414193850.1696-3-vipin.varghese@amd.com>
X-Mailer: git-send-email 2.47.0.windows.1
In-Reply-To: <20260414193850.1696-1-vipin.varghese@amd.com>
References: <20241105102849.1947-1-vipin.varghese@amd.com>
 <20260414193850.1696-1-vipin.varghese@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|SJ2PR12MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bd2ffde-091d-4ff7-16db-08de9a5dbb2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NPoY9OBtTMOyr/u2n0sFmbSfolmpkfLq1UciFsopRHEvGfGZH80f2P5AP6bwqTfrGbl2rwTlpNSuy21060fF06nJYSxaIee+aracc3ZxbUbCRKnOnMwGrrwyeCz8Akm/tI5lTywYklk/jUnoazE0adQJ2gmXfQESQZ1Iy2xjJk9oL+hWWXotjLJLKcG/GLtwmxRgcT+iIUshZvtweh48BTHr3Gb8i8Axa7vVOjSOUT1cE4Ett1ss8GiajjtTEhmA1dmM299EsLDDGo/br1xIFWGNG+wZi2A34/xS8keOdziJr32G+Vx6SlTUpZ4G8nqno8QLUOxaSg7DfqQrVTpXVUENrErlj1koqMvWJGO0L6LNEuja7IGJiBeuzZbjWSBJb+JFg8Y+CGfKP8gP0tqCvHeeK3f5gqMOk9/RrfZhS1hpQiXlygJU3WEcog8aawJFqAS1JOwtqQOx/stGoRJbYtVs/do8c9YN3vZHUq/TqgtTnBjEJcvmRuG8x24vrTNjz0hzm5R+bxm6qMNNKIzDUQkYypwttovlL5w98m9QbYk5oTPkv2VC3sUObTJGuWbKIxZ6eiiUWhDJyRO5/asUh+9bG3H+27u3DP6GduruXn9sjqpQZmEOfPaHWeL/LcYfgaKA7Xt2li68H93mNbwdv5UeDUWBHSU+eQFpi0/5C8zzLAj/YZbsGBdU45XPpgG/hqcjAzEfGX2aM3UyuvSwPzw1peWYQ0IIMpO4T8B8FeTarPJmVNnAud9AG/Ent6hQ5sdwiBGd9ZwRoUjWb9RskQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TIvNLHUsxnDrvwUoKC4JeN/nKFnwUVsChF9vnj/ZevMPKQrF0Bkbir8Otb0WAktdnBkxrNZWMqCWWiVLAVqAzCiS5rhvYCMHyIIYT2cJ3XEVtT9m5H+dq1Hro8KKkqaljC5RpbzpvoUtn/yodS9uS+1ioLQ2o+5RXvo7omQctjwvm0TbPRkI8972mKRYn2QpRUGIQEbAsic4yHFRsSvQe9gkui7gy81AbLhJ3yq+vBsFZQiH00eadOjokLW0Kh7k7ccM2KS4yjJKl9ruAqyMhM9vPJaPKNGAx2tpFvkHSkkrMtrVFNzJSil3Qd9W5nJ/NMBDM5SUOZ7w3zEgzhL0O9R4Hkh+jD8l8BqjHClhLiu0bFr733+12xwoHrnBkckO4ouyNhzI8ViSQhWIL7F4PuWde8b4TrZynTSnjtMHDrS3oGOBv2ieDj8ZK0CEG3Wi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 19:40:49.5519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd2ffde-091d-4ff7-16db-08de9a5dbb2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8882
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

changes:
 - rework stack and ring with domain lcores
 - add new test cases for topology API

ring_test inspired from 20251024141635.3939617-1-sivaprasad.tummala@amd.com

Suggested-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Signed-off-by: Vipin Varghese <vipin.varghese@amd.com>
---
 app/test/meson.build       |   1 +
 app/test/test_ring_perf.c  | 416 ++++++++++++++++++++++-
 app/test/test_stack_perf.c | 409 ++++++++++++++++++++++
 app/test/test_topology.c   | 676 +++++++++++++++++++++++++++++++++++++
 4 files changed, 1499 insertions(+), 3 deletions(-)
 create mode 100644 app/test/test_topology.c

diff --git a/app/test/meson.build b/app/test/meson.build
index 7d458f9c07..f584ea66c1 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -207,6 +207,7 @@ source_file_deps = {
     'test_timer_perf.c': ['timer'],
     'test_timer_racecond.c': ['timer'],
     'test_timer_secondary.c': ['timer'],
+    'test_topology.c': [],
     'test_trace.c': [],
     'test_trace_perf.c': [],
     'test_trace_register.c': [],
diff --git a/app/test/test_ring_perf.c b/app/test/test_ring_perf.c
index 9a2a481458..1f0fd8a0fa 100644
--- a/app/test/test_ring_perf.c
+++ b/app/test/test_ring_perf.c
@@ -10,6 +10,9 @@
 #include <rte_cycles.h>
 #include <rte_launch.h>
 #include <rte_pause.h>
+#ifdef RTE_LIBHWLOC_PROBE
+#include <rte_topology.h>
+#endif
 #include <string.h>
 
 #include "test.h"
@@ -74,7 +77,7 @@ test_ring_print_test_string(unsigned int api_type, int esize,
 static int
 get_two_hyperthreads(struct lcore_pair *lcp)
 {
-	unsigned id1, id2;
+	unsigned int id1, id2;
 	unsigned c1, c2, s1, s2;
 	RTE_LCORE_FOREACH(id1) {
 		/* inner loop just re-reads all id's. We could skip the first few
@@ -101,7 +104,7 @@ get_two_hyperthreads(struct lcore_pair *lcp)
 static int
 get_two_cores(struct lcore_pair *lcp)
 {
-	unsigned id1, id2;
+	unsigned int id1, id2;
 	unsigned c1, c2, s1, s2;
 	RTE_LCORE_FOREACH(id1) {
 		RTE_LCORE_FOREACH(id2) {
@@ -125,7 +128,7 @@ get_two_cores(struct lcore_pair *lcp)
 static int
 get_two_sockets(struct lcore_pair *lcp)
 {
-	unsigned id1, id2;
+	unsigned int id1, id2;
 	unsigned s1, s2;
 	RTE_LCORE_FOREACH(id1) {
 		RTE_LCORE_FOREACH(id2) {
@@ -143,6 +146,359 @@ get_two_sockets(struct lcore_pair *lcp)
 	return 1;
 }
 
+#ifdef RTE_LIBHWLOC_PROBE
+static int
+get_same_numa_domains(struct lcore_pair *lcp)
+{
+	if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_NUMA) == 0)
+		return 1;
+
+	unsigned int id1 = RTE_MAX_LCORE, id2 = RTE_MAX_LCORE;
+	unsigned int domain = 0;
+
+	RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_NUMA) {
+		if ((id1 != RTE_MAX_LCORE) && (id2 != RTE_MAX_LCORE))
+			break;
+
+		if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_NUMA, domain) < 2)
+			continue;
+
+		id1 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_NUMA);
+		id2 = rte_topo_get_nth_lcore_from_domain(domain, 1, 0, RTE_TOPO_DOMAIN_NUMA);
+	}
+
+	if ((id1 == RTE_MAX_LCORE) || (id2 == RTE_MAX_LCORE))
+		return 2;
+
+	if (id1 == id2)
+		return 3;
+
+	lcp->c1 = id1;
+	lcp->c2 = id2;
+
+	return 0;
+}
+
+static int
+get_same_l4_domains(struct lcore_pair *lcp)
+{
+	if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L4) == 0)
+		return 1;
+
+	unsigned int id1 = RTE_MAX_LCORE, id2 = RTE_MAX_LCORE;
+	unsigned int domain = 0;
+
+	RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L4) {
+		if ((id1 != RTE_MAX_LCORE) && (id2 != RTE_MAX_LCORE))
+			break;
+
+		if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_L4, domain) < 2)
+			continue;
+
+		id1 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L4);
+		id2 = rte_topo_get_nth_lcore_from_domain(domain, 1, 0, RTE_TOPO_DOMAIN_L4);
+	}
+
+	if ((id1 == RTE_MAX_LCORE) || (id2 == RTE_MAX_LCORE))
+		return 2;
+
+	if (id1 == id2)
+		return 3;
+
+	lcp->c1 = id1;
+	lcp->c2 = id2;
+	return 0;
+}
+
+static int
+get_same_l3_domains(struct lcore_pair *lcp)
+{	if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L3) == 0)
+		return 1;
+
+	unsigned int id1 = RTE_MAX_LCORE, id2 = RTE_MAX_LCORE;
+	unsigned int domain = 0;
+
+	RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L3) {
+		if ((id1 != RTE_MAX_LCORE) && (id2 != RTE_MAX_LCORE))
+			break;
+
+		if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_L3, domain) < 2)
+			continue;
+
+		id1 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L3);
+		id2 = rte_topo_get_nth_lcore_from_domain(domain, 1, 0, RTE_TOPO_DOMAIN_L3);
+	}
+
+	if ((id1 == RTE_MAX_LCORE) || (id2 == RTE_MAX_LCORE))
+		return 2;
+
+	if (id1 == id2)
+		return 3;
+
+	lcp->c1 = id1;
+	lcp->c2 = id2;
+
+	return 0;
+
+}
+
+static int
+get_same_l2_domains(struct lcore_pair *lcp)
+{	if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L2) == 0)
+		return 1;
+
+	unsigned int id1 = RTE_MAX_LCORE, id2 = RTE_MAX_LCORE;
+	unsigned int domain = 0;
+
+	RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L2) {
+		if ((id1 != RTE_MAX_LCORE) && (id2 != RTE_MAX_LCORE))
+			break;
+
+		if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_L2, domain) < 2)
+			continue;
+
+		id1 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L2);
+		id2 = rte_topo_get_nth_lcore_from_domain(domain, 1, 0, RTE_TOPO_DOMAIN_L2);
+	}
+
+	if ((id1 == RTE_MAX_LCORE) || (id2 == RTE_MAX_LCORE))
+		return 2;
+
+	if (id1 == id2)
+		return 3;
+
+	lcp->c1 = id1;
+	lcp->c2 = id2;
+
+	return 0;
+
+}
+
+static int
+get_same_l1_domains(struct lcore_pair *lcp)
+{
+	if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L1) == 0)
+		return 1;
+
+	unsigned int id1 = RTE_MAX_LCORE, id2 = RTE_MAX_LCORE;
+	unsigned int domain = 0;
+
+	RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L1) {
+		if ((id1 != RTE_MAX_LCORE) && (id2 != RTE_MAX_LCORE))
+			break;
+
+		if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_L1, domain) < 2)
+			continue;
+
+		id1 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L1);
+		id2 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L1);
+	}
+
+	if ((id1 == RTE_MAX_LCORE) || (id2 == RTE_MAX_LCORE))
+		return 2;
+
+	if (id1 == id2)
+		return 3;
+
+	lcp->c1 = id1;
+	lcp->c2 = id2;
+
+	return 0;
+
+}
+static int
+get_two_numa_domains(struct lcore_pair *lcp)
+{
+	if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_NUMA) < 2)
+		return 1;
+
+	unsigned int id1 = RTE_MAX_LCORE, id2 = RTE_MAX_LCORE;
+	unsigned int domain = 0;
+
+	RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_NUMA) {
+		if ((id1 != RTE_MAX_LCORE) && (id2 != RTE_MAX_LCORE))
+			break;
+
+		if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_NUMA, domain) == 0)
+			continue;
+
+		if (id1 == RTE_MAX_LCORE) {
+			id1 = rte_topo_get_nth_lcore_from_domain(domain,
+				0, 0, RTE_TOPO_DOMAIN_NUMA);
+			continue;
+		}
+		if (id2 == RTE_MAX_LCORE) {
+			id2 = rte_topo_get_nth_lcore_from_domain(domain,
+				0, 0, RTE_TOPO_DOMAIN_NUMA);
+			continue;
+		}
+	}
+
+	if ((id1 == RTE_MAX_LCORE) || (id2 == RTE_MAX_LCORE))
+		return 2;
+
+	if (id1 == id2)
+		return 3;
+
+	lcp->c1 = id1;
+	lcp->c2 = id2;
+
+	return 0;
+}
+
+static int
+get_two_l4_domains(struct lcore_pair *lcp)
+{
+	if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L4) < 2)
+		return 1;
+
+	unsigned int id1 = RTE_MAX_LCORE, id2 = RTE_MAX_LCORE;
+	unsigned int domain = 0;
+
+	RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L4) {
+		if ((id1 != RTE_MAX_LCORE) && (id2 != RTE_MAX_LCORE))
+			break;
+
+		if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_L4, domain) == 0)
+			continue;
+
+		if (id1 == RTE_MAX_LCORE) {
+			id1 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L4);
+			continue;
+		}
+		if (id2 == RTE_MAX_LCORE) {
+			id2 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L4);
+			continue;
+		}
+	}
+
+	if ((id1 == RTE_MAX_LCORE) || (id2 == RTE_MAX_LCORE))
+		return 2;
+
+	if (id1 == id2)
+		return 3;
+
+	lcp->c1 = id1;
+	lcp->c2 = id2;
+	return 0;
+}
+
+static int
+get_two_l3_domains(struct lcore_pair *lcp)
+{	if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L3) < 2)
+		return 1;
+
+	unsigned int id1 = RTE_MAX_LCORE, id2 = RTE_MAX_LCORE;
+	unsigned int domain = 0;
+
+	RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L3) {
+		if ((id1 != RTE_MAX_LCORE) && (id2 != RTE_MAX_LCORE))
+			break;
+
+		if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_L3, domain) == 0)
+			continue;
+
+		if (id1 == RTE_MAX_LCORE) {
+			id1 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L3);
+			continue;
+		}
+		if (id2 == RTE_MAX_LCORE) {
+			id2 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L3);
+			continue;
+		}
+	}
+
+	if ((id1 == RTE_MAX_LCORE) || (id2 == RTE_MAX_LCORE))
+		return 2;
+
+	if (id1 == id2)
+		return 3;
+
+	lcp->c1 = id1;
+	lcp->c2 = id2;
+
+	return 0;
+
+}
+
+static int
+get_two_l2_domains(struct lcore_pair *lcp)
+{	if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L2) < 2)
+		return 1;
+
+	unsigned int id1 = RTE_MAX_LCORE, id2 = RTE_MAX_LCORE;
+	unsigned int domain = 0;
+
+	RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L2) {
+		if ((id1 != RTE_MAX_LCORE) && (id2 != RTE_MAX_LCORE))
+			break;
+
+		if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_L2, domain) == 0)
+			continue;
+
+		if (id1 == RTE_MAX_LCORE) {
+			id1 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L2);
+			continue;
+		}
+		if (id2 == RTE_MAX_LCORE) {
+			id2 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L2);
+			continue;
+		}
+	}
+
+	if ((id1 == RTE_MAX_LCORE) || (id2 == RTE_MAX_LCORE))
+		return 2;
+
+	if (id1 == id2)
+		return 3;
+
+	lcp->c1 = id1;
+	lcp->c2 = id2;
+
+	return 0;
+
+}
+
+static int
+get_two_l1_domains(struct lcore_pair *lcp)
+{
+	if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L1) < 2)
+		return 1;
+
+	unsigned int id1 = RTE_MAX_LCORE, id2 = RTE_MAX_LCORE;
+	unsigned int domain = 0;
+
+	RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L1) {
+		if ((id1 != RTE_MAX_LCORE) && (id2 != RTE_MAX_LCORE))
+			break;
+
+		if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_L1, domain) == 0)
+			continue;
+
+		if (id1 == RTE_MAX_LCORE) {
+			id1 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L1);
+			continue;
+		}
+		if (id2 == RTE_MAX_LCORE) {
+			id2 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L1);
+			continue;
+		}
+	}
+
+	if ((id1 == RTE_MAX_LCORE) || (id2 == RTE_MAX_LCORE))
+		return 2;
+
+	if (id1 == id2)
+		return 3;
+
+	lcp->c1 = id1;
+	lcp->c2 = id2;
+
+	return 0;
+
+}
+#endif
+
 /* Get cycle counts for dequeuing from an empty ring. Should be 2 or 3 cycles */
 static void
 test_empty_dequeue(struct rte_ring *r, const int esize,
@@ -488,6 +844,60 @@ test_ring_perf_esize_run_on_two_cores(
 		if (run_on_core_pair(&cores, param1, param2) < 0)
 			return -1;
 	}
+#ifdef RTE_LIBHWLOC_PROBE
+	if (rte_lcore_count() > 2) {
+		if (get_same_numa_domains(&cores) == 0) {
+			printf("\n### Testing using same numa domain nodes ###\n");
+			if (run_on_core_pair(&cores, param1, param2) < 0)
+				return -1;
+		}
+		if (get_same_l4_domains(&cores) == 0) {
+			printf("\n### Testing using same l4 domain nodes ###\n");
+			if (run_on_core_pair(&cores, param1, param2) < 0)
+				return -1;
+		}
+		if (get_same_l3_domains(&cores) == 0) {
+			printf("\n### Testing using same l3 domain nodes ###\n");
+			if (run_on_core_pair(&cores, param1, param2) < 0)
+				return -1;
+		}
+		if (get_same_l2_domains(&cores) == 0) {
+			printf("\n### Testing using same l2 domain nodes ###\n");
+			if (run_on_core_pair(&cores, param1, param2) < 0)
+				return -1;
+		}
+		if (get_same_l1_domains(&cores) == 0) {
+			printf("\n### Testing using same l1 domain nodes ###\n");
+			if (run_on_core_pair(&cores, param1, param2) < 0)
+				return -1;
+		}
+		if (get_two_numa_domains(&cores) == 0) {
+			printf("\n### Testing using two numa domain nodes ###\n");
+			if (run_on_core_pair(&cores, param1, param2) < 0)
+				return -1;
+		}
+		if (get_two_l4_domains(&cores) == 0) {
+			printf("\n### Testing using two l4 domain nodes ###\n");
+			if (run_on_core_pair(&cores, param1, param2) < 0)
+				return -1;
+		}
+		if (get_two_l3_domains(&cores) == 0) {
+			printf("\n### Testing using two l3 domain nodes ###\n");
+			if (run_on_core_pair(&cores, param1, param2) < 0)
+				return -1;
+		}
+		if (get_two_l2_domains(&cores) == 0) {
+			printf("\n### Testing using two l2 domain nodes ###\n");
+			if (run_on_core_pair(&cores, param1, param2) < 0)
+				return -1;
+		}
+		if (get_two_l1_domains(&cores) == 0) {
+			printf("\n### Testing using two l1 domain nodes ###\n");
+			if (run_on_core_pair(&cores, param1, param2) < 0)
+				return -1;
+		}
+	}
+#endif
 	return 0;
 }
 
diff --git a/app/test/test_stack_perf.c b/app/test/test_stack_perf.c
index 3f17a2606c..e5b038a3e8 100644
--- a/app/test/test_stack_perf.c
+++ b/app/test/test_stack_perf.c
@@ -10,6 +10,9 @@
 #include <rte_launch.h>
 #include <rte_pause.h>
 #include <rte_stack.h>
+#ifdef RTE_LIBHWLOC_PROBE
+#include <rte_topology.h>
+#endif
 
 #include "test.h"
 
@@ -105,6 +108,367 @@ get_two_sockets(struct lcore_pair *lcp)
 	return 1;
 }
 
+#ifdef RTE_LIBHWLOC_PROBE
+static int
+get_same_numa_domains(struct lcore_pair *lcp)
+{
+	if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_NUMA) == 0)
+		return 1;
+
+	unsigned int id1 = RTE_MAX_LCORE, id2 = RTE_MAX_LCORE;
+	unsigned int domain = 0;
+
+	RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_NUMA) {
+		if ((id1 != RTE_MAX_LCORE) && (id2 != RTE_MAX_LCORE))
+			break;
+
+		if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_NUMA, domain) < 2)
+			continue;
+
+		id1 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_NUMA);
+		id2 = rte_topo_get_nth_lcore_from_domain(domain, 1, 0, RTE_TOPO_DOMAIN_NUMA);
+	}
+
+	if ((id1 == RTE_MAX_LCORE) || (id2 == RTE_MAX_LCORE))
+		return 2;
+
+	if (id1 == id2)
+		return 3;
+
+	lcp->c1 = id1;
+	lcp->c2 = id2;
+
+	return 0;
+}
+
+static int
+get_same_l4_domains(struct lcore_pair *lcp)
+{
+	if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L4) == 0)
+		return 1;
+
+	unsigned int id1 = RTE_MAX_LCORE, id2 = RTE_MAX_LCORE;
+	unsigned int domain = 0;
+
+	RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L4) {
+		if ((id1 != RTE_MAX_LCORE) && (id2 != RTE_MAX_LCORE))
+			break;
+
+		if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_L4, domain) < 2)
+			continue;
+
+		id1 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L4);
+		id2 = rte_topo_get_nth_lcore_from_domain(domain, 1, 0, RTE_TOPO_DOMAIN_L4);
+	}
+
+	if ((id1 == RTE_MAX_LCORE) || (id2 == RTE_MAX_LCORE))
+		return 2;
+
+	if (id1 == id2)
+		return 3;
+
+	lcp->c1 = id1;
+	lcp->c2 = id2;
+
+	return 0;
+}
+
+static int
+get_same_l3_domains(struct lcore_pair *lcp)
+{
+	if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L3) == 0)
+		return 1;
+
+	unsigned int id1 = RTE_MAX_LCORE, id2 = RTE_MAX_LCORE;
+	unsigned int domain = 0;
+
+	RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L3) {
+		if ((id1 != RTE_MAX_LCORE) && (id2 != RTE_MAX_LCORE))
+			break;
+
+		if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_L3, domain) < 2)
+			continue;
+
+		id1 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L3);
+		id2 = rte_topo_get_nth_lcore_from_domain(domain, 1, 0, RTE_TOPO_DOMAIN_L3);
+	}
+
+	if ((id1 == RTE_MAX_LCORE) || (id2 == RTE_MAX_LCORE))
+		return 2;
+
+	if (id1 == id2)
+		return 3;
+
+	lcp->c1 = id1;
+	lcp->c2 = id2;
+
+	return 0;
+}
+
+static int
+get_same_l2_domains(struct lcore_pair *lcp)
+{
+	if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L2) == 0)
+		return 1;
+
+	unsigned int id1 = RTE_MAX_LCORE, id2 = RTE_MAX_LCORE;
+	unsigned int domain = 0;
+
+	RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L2) {
+		if ((id1 != RTE_MAX_LCORE) && (id2 != RTE_MAX_LCORE))
+			break;
+
+		if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_L2, domain) < 2)
+			continue;
+
+		id1 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L2);
+		id2 = rte_topo_get_nth_lcore_from_domain(domain, 1, 0, RTE_TOPO_DOMAIN_L2);
+	}
+
+	if ((id1 == RTE_MAX_LCORE) || (id2 == RTE_MAX_LCORE))
+		return 2;
+
+	if (id1 == id2)
+		return 3;
+
+	lcp->c1 = id1;
+	lcp->c2 = id2;
+
+	return 0;
+}
+
+static int
+get_same_l1_domains(struct lcore_pair *lcp)
+{
+	if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L1) == 0)
+		return 1;
+
+	unsigned int id1 = RTE_MAX_LCORE, id2 = RTE_MAX_LCORE;
+	unsigned int domain = 0;
+
+	RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L1) {
+		if (rte_topo_is_main_lcore_in_domain(domain, RTE_TOPO_DOMAIN_L1))
+			continue;
+
+		if ((id1 != RTE_MAX_LCORE) && (id2 != RTE_MAX_LCORE))
+			break;
+
+		if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_L1, domain) < 2)
+			continue;
+
+		id1 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L1);
+		id2 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L1);
+	}
+
+	if ((id1 == RTE_MAX_LCORE) || (id2 == RTE_MAX_LCORE))
+		return 2;
+
+	if (id1 == id2)
+		return 3;
+
+	lcp->c1 = id1;
+	lcp->c2 = id2;
+
+	return 0;
+}
+static int
+get_two_numa_domains(struct lcore_pair *lcp)
+{
+	if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_NUMA) < 2)
+		return 1;
+
+	unsigned int id1 = RTE_MAX_LCORE, id2 = RTE_MAX_LCORE;
+	unsigned int domain = 0;
+
+	RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_NUMA) {
+		if ((id1 != RTE_MAX_LCORE) && (id2 != RTE_MAX_LCORE))
+			break;
+
+		if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_NUMA, domain) == 0)
+			continue;
+
+		if (id1 == RTE_MAX_LCORE) {
+			id1 = rte_topo_get_nth_lcore_from_domain(domain,
+				0, 0, RTE_TOPO_DOMAIN_NUMA);
+			continue;
+		}
+
+		if (id2 == RTE_MAX_LCORE) {
+			id2 = rte_topo_get_nth_lcore_from_domain(domain,
+				0, 0, RTE_TOPO_DOMAIN_NUMA);
+			continue;
+		}
+	}
+
+	if ((id1 == RTE_MAX_LCORE) || (id2 == RTE_MAX_LCORE))
+		return 2;
+
+	if (id1 == id2)
+		return 3;
+
+	lcp->c1 = id1;
+	lcp->c2 = id2;
+
+	return 0;
+}
+
+static int
+get_two_l4_domains(struct lcore_pair *lcp)
+{
+	if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L4) < 2)
+		return 1;
+
+	unsigned int id1 = RTE_MAX_LCORE, id2 = RTE_MAX_LCORE;
+	unsigned int domain = 0;
+
+	RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L4) {
+		if ((id1 != RTE_MAX_LCORE) && (id2 != RTE_MAX_LCORE))
+			break;
+
+		if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_L4, domain) == 0)
+			continue;
+
+		if (id1 == RTE_MAX_LCORE) {
+			id1 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L4);
+			continue;
+		}
+		if (id2 == RTE_MAX_LCORE) {
+			id2 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L4);
+			continue;
+		}
+	}
+
+	if ((id1 == RTE_MAX_LCORE) || (id2 == RTE_MAX_LCORE))
+		return 2;
+
+	if (id1 == id2)
+		return 3;
+
+	lcp->c1 = id1;
+	lcp->c2 = id2;
+
+	return 0;
+}
+
+static int
+get_two_l3_domains(struct lcore_pair *lcp)
+{
+	if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L3) < 2)
+		return 1;
+
+	unsigned int id1 = RTE_MAX_LCORE, id2 = RTE_MAX_LCORE;
+	unsigned int domain = 0;
+
+	RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L3) {
+		if ((id1 != RTE_MAX_LCORE) && (id2 != RTE_MAX_LCORE))
+			break;
+
+		if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_L3, domain) == 0)
+			continue;
+
+		if (id1 == RTE_MAX_LCORE) {
+			id1 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L3);
+			continue;
+		}
+
+		if (id2 == RTE_MAX_LCORE) {
+			id2 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L3);
+			continue;
+		}
+	}
+
+	if ((id1 == RTE_MAX_LCORE) || (id2 == RTE_MAX_LCORE))
+		return 2;
+
+	if (id1 == id2)
+		return 3;
+
+	lcp->c1 = id1;
+	lcp->c2 = id2;
+
+	return 0;
+}
+
+static int
+get_two_l2_domains(struct lcore_pair *lcp)
+{
+	if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L2) < 2)
+		return 1;
+
+	unsigned int id1 = RTE_MAX_LCORE, id2 = RTE_MAX_LCORE;
+	unsigned int domain = 0;
+
+	RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L2) {
+		if ((id1 != RTE_MAX_LCORE) && (id2 != RTE_MAX_LCORE))
+			break;
+
+		if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_L2, domain) == 0)
+			continue;
+
+		if (id1 == RTE_MAX_LCORE) {
+			id1 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L2);
+			continue;
+		}
+
+		if (id2 == RTE_MAX_LCORE) {
+			id2 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L2);
+			continue;
+		}
+	}
+
+	if ((id1 == RTE_MAX_LCORE) || (id2 == RTE_MAX_LCORE))
+		return 2;
+
+	if (id1 == id2)
+		return 3;
+
+	lcp->c1 = id1;
+	lcp->c2 = id2;
+
+	return 0;
+}
+
+static int
+get_two_l1_domains(struct lcore_pair *lcp)
+{
+	if (rte_topo_get_domain_count(RTE_TOPO_DOMAIN_L1) < 2)
+		return 1;
+
+	unsigned int id1 = RTE_MAX_LCORE, id2 = RTE_MAX_LCORE;
+	unsigned int domain = 0;
+
+	RTE_TOPO_FOREACH_DOMAIN(domain, RTE_TOPO_DOMAIN_L1) {
+		if ((id1 != RTE_MAX_LCORE) && (id2 != RTE_MAX_LCORE))
+			break;
+
+		if (rte_topo_get_lcore_count_from_domain(RTE_TOPO_DOMAIN_L1, domain) == 0)
+			continue;
+
+		if (id1 == RTE_MAX_LCORE) {
+			id1 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L1);
+			continue;
+		}
+
+		if (id2 == RTE_MAX_LCORE) {
+			id2 = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L1);
+			continue;
+		}
+	}
+
+	if ((id1 == RTE_MAX_LCORE) || (id2 == RTE_MAX_LCORE))
+		return 2;
+
+	if (id1 == id2)
+		return 3;
+
+	lcp->c1 = id1;
+	lcp->c2 = id2;
+
+	return 0;
+}
+#endif
+
+
 /* Measure the cycle cost of popping an empty stack. */
 static void
 test_empty_pop(struct rte_stack *s)
@@ -331,6 +695,51 @@ __test_stack_perf(uint32_t flags)
 		run_on_core_pair(&cores, s, bulk_push_pop);
 	}
 
+#ifdef RTE_LIBHWLOC_PROBE
+	if (rte_lcore_count() > 2) {
+		if (get_same_numa_domains(&cores) == 0) {
+			printf("\n### Testing using same numa domain nodes ###\n");
+			run_on_core_pair(&cores, s, bulk_push_pop);
+		}
+		if (get_same_l4_domains(&cores) == 0) {
+			printf("\n### Testing using same l4 domain nodes ###\n");
+			run_on_core_pair(&cores, s, bulk_push_pop);
+		}
+		if (get_same_l3_domains(&cores) == 0) {
+			printf("\n### Testing using same l3 domain nodes ###\n");
+			run_on_core_pair(&cores, s, bulk_push_pop);
+		}
+		if (get_same_l2_domains(&cores) == 0) {
+			printf("\n### Testing using same l2 domain nodes ###\n");
+			run_on_core_pair(&cores, s, bulk_push_pop);
+		}
+		if (get_same_l1_domains(&cores) == 0) {
+			printf("\n### Testing using same l1 domain nodes ###\n");
+			run_on_core_pair(&cores, s, bulk_push_pop);
+		}
+		if (get_two_numa_domains(&cores) == 0) {
+			printf("\n### Testing using two numa domain nodes ###\n");
+			run_on_core_pair(&cores, s, bulk_push_pop);
+		}
+		if (get_two_l4_domains(&cores) == 0) {
+			printf("\n### Testing using two l4 domain nodes ###\n");
+			run_on_core_pair(&cores, s, bulk_push_pop);
+		}
+		if (get_two_l3_domains(&cores) == 0) {
+			printf("\n### Testing using two l3 domain nodes ###\n");
+			run_on_core_pair(&cores, s, bulk_push_pop);
+		}
+		if (get_two_l2_domains(&cores) == 0) {
+			printf("\n### Testing using two l2 domain nodes ###\n");
+			run_on_core_pair(&cores, s, bulk_push_pop);
+		}
+		if (get_two_l1_domains(&cores) == 0) {
+			printf("\n### Testing using two l1 domain nodes ###\n");
+			run_on_core_pair(&cores, s, bulk_push_pop);
+		}
+	}
+#endif
+
 	printf("\n### Testing on all %u lcores ###\n", rte_lcore_count());
 	run_on_n_cores(s, bulk_push_pop, rte_lcore_count());
 
diff --git a/app/test/test_topology.c b/app/test/test_topology.c
new file mode 100644
index 0000000000..f2244ad807
--- /dev/null
+++ b/app/test/test_topology.c
@@ -0,0 +1,676 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 AMD Corporation
+ */
+
+#include <sched.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <rte_common.h>
+#include <rte_errno.h>
+#include <rte_lcore.h>
+#include <rte_thread.h>
+#include <rte_topology.h>
+
+#include "test.h"
+
+#ifndef _POSIX_PRIORITY_SCHEDULING
+/* sched_yield(2):
+ * POSIX systems on which sched_yield() is available define
+ * _POSIX_PRIORITY_SCHEDULING in <unistd.h>.
+ */
+#define sched_yield()
+#endif
+
+#ifdef RTE_LIBHWLOC_PROBE
+
+static const unsigned int domain_types[] = {
+	RTE_TOPO_DOMAIN_NUMA,
+	RTE_TOPO_DOMAIN_L4,
+	RTE_TOPO_DOMAIN_L3,
+	RTE_TOPO_DOMAIN_L2,
+	RTE_TOPO_DOMAIN_L1
+};
+
+static int
+test_topology_macro(void)
+{
+	unsigned int total_lcores = 0;
+	unsigned int total_wrkr_lcores = 0;
+
+	unsigned int count_lcore = 0;
+	unsigned int total_lcore = 0;
+	unsigned int total_wrkr_lcore = 0;
+
+	unsigned int lcore = 0, pos = 0, domain = 0;
+
+	/* get topology core count */
+	lcore = -1;
+	RTE_LCORE_FOREACH(lcore)
+		total_lcores += 1;
+
+	lcore = -1;
+	RTE_LCORE_FOREACH_WORKER(lcore)
+		total_wrkr_lcores += 1;
+
+	RTE_TEST_ASSERT(((total_wrkr_lcores + 1) == total_lcores),
+		"fail in MACRO for RTE_LCORE_FOREACH\n");
+
+	RTE_LOG(DEBUG, USER1, "Lcore: %u, Lcore Worker: %u\n", total_lcores, total_wrkr_lcores);
+	RTE_LOG(DEBUG, USER1, "| %10s | %10s | %10s | %10s |\n",
+		"domain name", "count", "LCORE", "WORKER");
+	RTE_LOG(DEBUG, USER1, "------------------------------------------------------\n");
+
+	for (unsigned int d = 0; d < RTE_DIM(domain_types); d++) {
+		count_lcore = 0;
+		total_lcore = 0;
+		total_wrkr_lcore = 0;
+		domain = RTE_TOPO_DOMAIN_MAX;
+		RTE_TOPO_FOREACH_DOMAIN(domain, domain_types[d]) {
+			count_lcore +=
+				rte_topo_get_lcore_count_from_domain(domain_types[d], domain);
+
+			lcore = RTE_MAX_LCORE;
+			pos = 0;
+			RTE_TOPO_FOREACH_LCORE_IN_DOMAIN(lcore, domain, pos, domain_types[d])
+				total_lcore += 1;
+
+			/* skip domain */
+			if (rte_topo_is_main_lcore_in_domain(domain, domain_types[d]))
+				continue;
+
+			lcore = RTE_MAX_LCORE;
+			RTE_TOPO_FOREACH_WORKER_LCORE_IN_DOMAIN(lcore, domain, domain_types[d]) {
+				total_wrkr_lcore += 1;
+			}
+		}
+
+		if (count_lcore) {
+			RTE_TEST_ASSERT((total_wrkr_lcore < total_lcore),
+				"unexpected workers in %s domain!\n",
+				(domain_types[d] == RTE_TOPO_DOMAIN_NUMA) ? "NUMA" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L4) ? "L4" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L3) ? "L3" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L2) ? "L2" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L1) ? "L1" : NULL);
+
+			RTE_LOG(DEBUG, USER1, "| %10s | %10u | %10u | %10u |\n",
+				(domain_types[d] == RTE_TOPO_DOMAIN_NUMA) ? "NUMA" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L4) ? "L4" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L3) ? "L3" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L2) ? "L2" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L1) ? "L1" : NULL,
+				rte_topo_get_domain_count(domain_types[d]),
+				total_lcore, total_wrkr_lcore);
+		}
+	}
+	RTE_LOG(DEBUG, USER1, "---------------------------------------------------------\n");
+
+	printf("INFO: lcore DOMAIN macro: success!\n");
+	return TEST_SUCCESS;
+}
+
+static int
+test_lcore_count_from_domain(void)
+{
+	unsigned int total_lcores = 0;
+	unsigned int total_domain_lcores = 0;
+	unsigned int domain_count;
+	unsigned int i;
+
+	/* get topology core count */
+	total_lcores = rte_lcore_count();
+
+	RTE_LOG(DEBUG, USER1, "| %10s | %10s |\n", "domain", " LCORE");
+	RTE_LOG(DEBUG, USER1, "---------------------------------------\n");
+	RTE_LOG(DEBUG, USER1, "| %10s | %10u |\n", "rte_lcore", total_lcores);
+
+	for (unsigned int d = 0; d < RTE_DIM(domain_types); d++) {
+		total_domain_lcores = 0;
+		domain_count = rte_topo_get_domain_count(domain_types[d]);
+		for (i = 0; i < domain_count; i++)
+			total_domain_lcores +=
+				rte_topo_get_lcore_count_from_domain(domain_types[d], i);
+
+		if (domain_count) {
+			RTE_TEST_ASSERT((total_domain_lcores == total_lcores),
+				"domain %s lcores does not match!\n",
+				(domain_types[d] == RTE_TOPO_DOMAIN_NUMA) ? "NUMA" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L4) ? "L4" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L3) ? "L3" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L2) ? "L2" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L1) ? "L1" : NULL);
+
+			RTE_LOG(DEBUG, USER1, "| %10s | %10u |\n",
+				(domain_types[d] == RTE_TOPO_DOMAIN_NUMA) ? "NUMA" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L4) ? "L4" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L3) ? "L3" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L2) ? "L2" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L1) ? "L1" : NULL,
+				total_domain_lcores);
+		}
+	}
+	RTE_LOG(DEBUG, USER1, "---------------------------------------\n");
+
+	printf("INFO: lcore count domain API: success\n");
+	return TEST_SUCCESS;
+}
+
+#ifdef RTE_HAS_CPUSET
+static int
+test_lcore_cpuset_from_domain(void)
+{
+	unsigned int domain_count;
+	uint16_t dmn_idx;
+	rte_cpuset_t cpu_set_list;
+
+	for (unsigned int d = 0; d < RTE_DIM(domain_types); d++) {
+		domain_count = rte_topo_get_domain_count(domain_types[d]);
+		for (dmn_idx = 0; dmn_idx < domain_count; dmn_idx++) {
+			cpu_set_list = rte_topo_get_lcore_cpuset_in_domain(domain_types[d],
+				dmn_idx);
+
+			for (uint16_t cpu_idx = 0; cpu_idx < RTE_MAX_LCORE; cpu_idx++) {
+				if (CPU_ISSET(cpu_idx, &cpu_set_list))
+					RTE_TEST_ASSERT(rte_lcore_is_enabled(cpu_idx), "%s domain at %u lcore %u not enabled!\n",
+					(domain_types[d] == RTE_TOPO_DOMAIN_NUMA) ? "NUMA" :
+					(domain_types[d] == RTE_TOPO_DOMAIN_L4) ? "L4" :
+					(domain_types[d] == RTE_TOPO_DOMAIN_L3) ? "L3" :
+					(domain_types[d] == RTE_TOPO_DOMAIN_L2) ? "L2" :
+					(domain_types[d] == RTE_TOPO_DOMAIN_L1) ? "L1" : NULL,
+					dmn_idx, cpu_idx);
+
+			}
+		}
+	}
+	printf("INFO: topology cpuset: success!\n");
+
+	for (unsigned int d = 0; d < RTE_DIM(domain_types); d++) {
+		cpu_set_list = rte_topo_get_lcore_cpuset_in_domain(domain_types[d], UINT32_MAX);
+		RTE_TEST_ASSERT((CPU_COUNT(&cpu_set_list) == 0),
+			"lcore not expected for %s domain invalid index!\n",
+			(domain_types[d] == RTE_TOPO_DOMAIN_NUMA) ? "NUMA" :
+			(domain_types[d] == RTE_TOPO_DOMAIN_L4) ? "L4" :
+			(domain_types[d] == RTE_TOPO_DOMAIN_L3) ? "L3" :
+			(domain_types[d] == RTE_TOPO_DOMAIN_L2) ? "L2" :
+			(domain_types[d] == RTE_TOPO_DOMAIN_L1) ? "L1" : NULL);
+	}
+
+	printf("INFO: cpuset_in_domain API: success!\n");
+	return TEST_SUCCESS;
+}
+#endif
+
+static int
+test_main_lcore_in_domain(void)
+{
+	for (unsigned int d = 0; d < RTE_DIM(domain_types); d++) {
+		bool main_lcore_found = false;
+		unsigned int domain_count = rte_topo_get_domain_count(domain_types[d]);
+		for (unsigned int dmn_idx = 0; dmn_idx < domain_count; dmn_idx++) {
+			main_lcore_found = rte_topo_is_main_lcore_in_domain(RTE_TOPO_DOMAIN_NUMA,
+				dmn_idx);
+			if (main_lcore_found)
+				break;
+		}
+
+		if (domain_count)
+			RTE_TEST_ASSERT((main_lcore_found == true),
+			"main lcore is not found in %s domain!\n",
+			(domain_types[d] == RTE_TOPO_DOMAIN_NUMA) ? "NUMA" :
+			(domain_types[d] == RTE_TOPO_DOMAIN_L4) ? "L4" :
+			(domain_types[d] == RTE_TOPO_DOMAIN_L3) ? "L3" :
+			(domain_types[d] == RTE_TOPO_DOMAIN_L2) ? "L2" :
+			(domain_types[d] == RTE_TOPO_DOMAIN_L1) ? "L1" : NULL);
+	}
+
+	printf("INFO: is_main_lcore_in_domain API: success!\n");
+	return TEST_SUCCESS;
+}
+
+static int
+test_lcore_from_domain_negative(void)
+{
+	for (unsigned int d = 0; d < RTE_DIM(domain_types); d++) {
+		const unsigned int domain_count = rte_topo_get_domain_count(domain_types[d]);
+		if (domain_count)
+			RTE_TEST_ASSERT(
+				(rte_topo_get_lcore_count_from_domain(domain_types[d],
+					domain_count) == 0),
+				"domain %s API inconsistent for numa\n",
+				(domain_types[d] == RTE_TOPO_DOMAIN_NUMA) ? "NUMA" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L4) ? "L4" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L3) ? "L3" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L2) ? "L2" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L1) ? "L1" : NULL);
+	}
+
+	printf("INFO: lcore domain API: success!\n");
+	return TEST_SUCCESS;
+}
+
+static int
+test_wrap_with_skip_main_edge_case(void)
+{
+	const unsigned int main_lcore = rte_get_main_lcore();
+
+	for (unsigned int d = 0; d < RTE_DIM(domain_types); d++) {
+		const unsigned int domain_count = rte_topo_get_domain_count(domain_types[d]);
+		for (unsigned int domain_index = 0; domain_index < domain_count; domain_index++) {
+			unsigned int lcores_in_domain_index =
+				rte_topo_get_lcore_count_from_domain(domain_types[d],
+					domain_index);
+
+			if (lcores_in_domain_index &&
+				(rte_topo_is_main_lcore_in_domain(domain_types[d],
+					lcores_in_domain_index))) {
+
+				if (lcores_in_domain_index == 1)
+					continue;
+
+				for (unsigned int i = 0; i < lcores_in_domain_index; i++) {
+					const uint16_t next_lcore =
+						rte_topo_get_nth_lcore_from_domain(domain_index,
+							i, 0, domain_types[d]);
+
+					RTE_TEST_ASSERT(next_lcore != main_lcore,
+						"expected domain %s, main lcore %u, to be skipped!",
+						(domain_types[d] == RTE_TOPO_DOMAIN_NUMA) ? "NUMA" :
+						(domain_types[d] == RTE_TOPO_DOMAIN_L4) ? "L4" :
+						(domain_types[d] == RTE_TOPO_DOMAIN_L3) ? "L3" :
+						(domain_types[d] == RTE_TOPO_DOMAIN_L2) ? "L2" :
+						(domain_types[d] == RTE_TOPO_DOMAIN_L1) ? "L1" :
+						NULL,
+						main_lcore);
+				}
+			}
+		}
+	}
+
+	printf("INFO: skip main lcore API: success!\n");
+	return TEST_SUCCESS;
+}
+
+static int
+test_invalid_domain_selector(void)
+{
+	unsigned int count;
+	unsigned int lcore;
+	rte_cpuset_t cpuset;
+
+	/* Test with completely invalid domain selector */
+	count = rte_topo_get_domain_count(0xDEADBEEF);
+	RTE_TEST_ASSERT((count == 0), "Invalid domain selector should return 0 count\n");
+
+	/* Test with 0 (no bits set) */
+	count = rte_topo_get_domain_count(0);
+	RTE_TEST_ASSERT((count == 0), "Zero domain selector should return 0 count\n");
+
+	/* Test count_from_domain with invalid selector */
+	count = rte_topo_get_lcore_count_from_domain(0xBADC0DE, 0);
+	RTE_TEST_ASSERT((count == 0), "Invalid domain should return 0 cores\n");
+
+	/* Test get_lcore_in_domain with invalid selector */
+	lcore = rte_topo_get_nth_lcore_in_domain(0xBADC0DE, 0, 0);
+	RTE_TEST_ASSERT((lcore == RTE_MAX_LCORE), "Invalid domain should return RTE_MAX_LCORE\n");
+
+	/* Test cpuset with invalid selector */
+	cpuset = rte_topo_get_lcore_cpuset_in_domain(0xBADC0DE, 0);
+	RTE_TEST_ASSERT((CPU_COUNT(&cpuset) == 0), "Invalid domain should return empty cpuset\n");
+
+	printf("INFO: Invalid domain selector test: success\n");
+	return TEST_SUCCESS;
+}
+
+static int
+test_multiple_invalid_inputs(void)
+{
+	if (rte_lcore_count() == 1) {
+		printf("INFO: topology MACRO test requires more than 1 core, skipping!\n");
+		return TEST_SKIPPED;
+	}
+
+	/* Test all APIs with multiple types of invalid inputs */
+	unsigned int invalid_domains[] = {
+		0,             /* No bits set */
+		0xFFFFFFFF,    /* All bits set (not a single domain) */
+		0x80000000,    /* Bit outside valid range */
+		0x12345678,    /* Random invalid value */
+	};
+
+	for (int i = 0; i < 4; i++) {
+		unsigned int domain = invalid_domains[i];
+
+		/* All should return safe defaults */
+		RTE_TEST_ASSERT((rte_topo_get_domain_count(domain) == 0),
+			"Invalid domain 0x%x should have NO count\n", domain);
+		RTE_TEST_ASSERT((rte_topo_get_lcore_count_from_domain(domain, 0) == 0),
+			"Invalid domain 0x%x should have NO cores\n", domain);
+		RTE_TEST_ASSERT((rte_topo_get_nth_lcore_in_domain(domain, 0, 0) == RTE_MAX_LCORE),
+			"Invalid domain 0x%x should return MAX_LCORE\n", domain);
+	}
+
+	printf("INFO: Multiple invalid inputs test: success\n");
+	return TEST_SUCCESS;
+}
+
+static int
+test_large_index_values(void)
+{
+	if (rte_lcore_count() == 1) {
+		printf("INFO: topology MACRO test requires more than 1 core, skipping!\n");
+		return TEST_SKIPPED;
+	}
+
+	uint16_t test_lcore = 0;
+	unsigned int large_indices[] = {
+		RTE_MAX_LCORE,
+		RTE_MAX_LCORE + 1,
+		UINT32_MAX,
+		0x7FFFFFFF,
+	};
+
+	for (unsigned int d = 0; d < RTE_DIM(domain_types); d++) {
+		for (unsigned int i = 0; i < RTE_DIM(large_indices); i++) {
+			unsigned int idx = large_indices[i];
+
+			/* Should all handle gracefully and return safe defaults */
+			test_lcore = rte_topo_get_lcore_count_from_domain(domain_types[d], idx);
+			RTE_TEST_ASSERT(test_lcore == 0,
+				"Large index %u in domain %s should return 0 cores\n",
+				idx,
+				(domain_types[d] == RTE_TOPO_DOMAIN_NUMA) ? "NUMA" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L4) ? "L4" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L3) ? "L3" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L2) ? "L2" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L1) ? "L1" : NULL);
+
+			test_lcore = rte_topo_get_nth_lcore_in_domain(domain_types[d], idx, 0);
+			RTE_TEST_ASSERT(test_lcore == RTE_MAX_LCORE,
+				"Large index %u in domain %s should return MAX_LCORE\n",
+				idx,
+				(domain_types[d] == RTE_TOPO_DOMAIN_NUMA) ? "NUMA" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L4) ? "L4" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L3) ? "L3" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L2) ? "L2" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L1) ? "L1" : NULL);
+
+#ifdef RTE_HAS_CPUSET
+			rte_cpuset_t cpuset = rte_topo_get_lcore_cpuset_in_domain(domain_types[d],
+				idx);
+			RTE_TEST_ASSERT(CPU_COUNT(&cpuset) == 0,
+				"Large index %u in domain %s should return empty cpuset",
+				idx,
+				(domain_types[d] == RTE_TOPO_DOMAIN_NUMA) ? "NUMA" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L4) ? "L4" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L3) ? "L3" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L2) ? "L2" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L1) ? "L1" : NULL);
+#endif
+		}
+	}
+
+	printf("INFO: Large index values test: success\n");
+	return TEST_SUCCESS;
+}
+
+
+static int
+test_domain_next_lcore_no_wrap(void)
+{
+	if (rte_lcore_count() == 1) {
+		printf("INFO: topology MACRO test requires more than 1 core, skipping!\n");
+		return TEST_SKIPPED;
+	}
+
+	for (unsigned int d = 0; d < RTE_DIM(domain_types); d++) {
+		const unsigned int lcores_in_domain = rte_topo_get_domain_count(domain_types[d]);
+
+		for (unsigned int domain_index = 0; domain_index < lcores_in_domain;
+			domain_index++) {
+			unsigned int lcores_in_domain_index =
+				rte_topo_get_lcore_count_from_domain(domain_types[d],
+					domain_index);
+
+			for (unsigned int i = 0; i < lcores_in_domain_index; i++) {
+				const uint16_t curr_lcore =
+					rte_topo_get_nth_lcore_from_domain(domain_index,
+						i, 0, domain_types[d]);
+
+				const uint16_t wrap_lcore =
+					rte_topo_get_nth_lcore_from_domain(domain_index,
+						lcores_in_domain_index + i, 0, domain_types[d]);
+
+				RTE_TEST_ASSERT(wrap_lcore == RTE_MAX_LCORE,
+					"expected domain %s, lcore %u, wrapped lcore %u should be RTE_MAX_LCORE!",
+					(domain_types[d] == RTE_TOPO_DOMAIN_NUMA) ? "NUMA" :
+					(domain_types[d] == RTE_TOPO_DOMAIN_L4) ? "L4" :
+					(domain_types[d] == RTE_TOPO_DOMAIN_L3) ? "L3" :
+					(domain_types[d] == RTE_TOPO_DOMAIN_L2) ? "L2" :
+					(domain_types[d] == RTE_TOPO_DOMAIN_L1) ? "L1" : NULL,
+					curr_lcore, wrap_lcore);
+			}
+		}
+	}
+
+	printf("INFO: next lcore in domain test: success\n");
+	return TEST_SUCCESS;
+}
+
+static int
+test_domain_next_lcore_wrap(void)
+{
+	for (unsigned int d = 0; d < RTE_DIM(domain_types); d++) {
+		const unsigned int lcores_in_domain = rte_topo_get_domain_count(domain_types[d]);
+		for (unsigned int domain_index = 0; domain_index < lcores_in_domain;
+			domain_index++) {
+			unsigned int lcores_in_domain_index =
+				rte_topo_get_lcore_count_from_domain(domain_types[d],
+					domain_index);
+
+			for (unsigned int i = 0; i < lcores_in_domain_index; i++) {
+				const uint16_t curr_lcore =
+					rte_topo_get_nth_lcore_from_domain(domain_index, i, 0,
+						domain_types[d]);
+				const uint16_t wrap_lcore =
+					rte_topo_get_nth_lcore_from_domain(domain_index,
+						lcores_in_domain_index + i, 1, domain_types[d]);
+
+				RTE_TEST_ASSERT(curr_lcore == wrap_lcore,
+					"expected domain %s, lcore %u, wrapped lcore %u not same!",
+					(domain_types[d] == RTE_TOPO_DOMAIN_NUMA) ? "NUMA" :
+					(domain_types[d] == RTE_TOPO_DOMAIN_L4) ? "L4" :
+					(domain_types[d] == RTE_TOPO_DOMAIN_L3) ? "L3" :
+					(domain_types[d] == RTE_TOPO_DOMAIN_L2) ? "L2" :
+					(domain_types[d] == RTE_TOPO_DOMAIN_L1) ? "L1" : NULL,
+					curr_lcore, wrap_lcore);
+			}
+		}
+	}
+
+	printf("INFO: wrap next lcore in domain test: success\n");
+	return TEST_SUCCESS;
+}
+
+
+static int
+test_multibit_domain_selector(void)
+{
+	const unsigned int bad_sel = RTE_TOPO_DOMAIN_L1 | RTE_TOPO_DOMAIN_L2;
+
+	unsigned int count;
+	unsigned int lcore;
+	rte_cpuset_t cpuset;
+
+	count = rte_topo_get_domain_count(bad_sel);
+	RTE_TEST_ASSERT(count == 0,
+		"Multi-bit selector should return 0 domains");
+
+	count = rte_topo_get_lcore_count_from_domain(bad_sel, 0);
+	RTE_TEST_ASSERT(count == 0,
+		"Multi-bit selector should return 0 lcores");
+
+	lcore = rte_topo_get_nth_lcore_in_domain(bad_sel, 0, 0);
+	RTE_TEST_ASSERT(lcore == RTE_MAX_LCORE,
+		"Multi-bit selector should return RTE_MAX_LCORE");
+
+#ifdef RTE_HAS_CPUSET
+	cpuset = rte_topo_get_lcore_cpuset_in_domain(bad_sel, 0);
+	RTE_TEST_ASSERT(CPU_COUNT(&cpuset) == 0,
+		"Multi-bit selector should return empty cpuset");
+#endif
+
+	printf("INFO: invalid domain select test: success\n");
+	return TEST_SUCCESS;
+}
+
+static int
+test_domain_lcore_round_trip(void)
+{
+	for (unsigned int d = 0; d < RTE_DIM(domain_types); d++) {
+		unsigned int dom_cnt = rte_topo_get_domain_count(domain_types[d]);
+
+		for (unsigned int i = 0; i < dom_cnt; i++) {
+			unsigned int lcnt =
+				rte_topo_get_lcore_count_from_domain(domain_types[d], i);
+
+			for (unsigned int p = 0; p < lcnt; p++) {
+				uint16_t lcore =
+					rte_topo_get_nth_lcore_in_domain(domain_types[d], i, p);
+
+				int idx =
+					rte_topo_get_domain_index_from_lcore(domain_types[d],
+						lcore);
+
+				RTE_TEST_ASSERT(idx == (int)i,
+					"Round-trip mismatch: domain %u lcore %u -> idx %d",
+					i, lcore, idx);
+			}
+		}
+	}
+
+	printf("INFO: lcore domain cross test: success\n");
+	return TEST_SUCCESS;
+}
+
+static int
+test_domain_lcore_ordering(void)
+{
+	unsigned int domain = RTE_TOPO_DOMAIN_L1;
+	if (rte_topo_get_domain_count(domain) == 0)
+		return TEST_SKIPPED;
+
+	unsigned int lcnt = rte_topo_get_lcore_count_from_domain(domain, 0);
+
+	uint16_t prev = 0;
+	bool first = true;
+
+	for (unsigned int i = 0; i < lcnt; i++) {
+		uint16_t cur = rte_topo_get_nth_lcore_in_domain(domain, 0, i);
+
+		if (!first)
+			RTE_TEST_ASSERT(cur > prev, "Lcore ordering not strictly increasing");
+		first = false;
+		prev = cur;
+	}
+
+	printf("INFO: lcores ascending domain test: success\n");
+	return TEST_SUCCESS;
+}
+
+static int
+test_cpuset_matches_lcore_list(void)
+{
+#ifdef RTE_HAS_CPUSET
+	unsigned int domain = RTE_TOPO_DOMAIN_L1;
+	if (rte_topo_get_domain_count(domain) == 0)
+		return TEST_SKIPPED;
+
+	rte_cpuset_t cpuset = rte_topo_get_lcore_cpuset_in_domain(domain, 0);
+
+	unsigned int lcnt = rte_topo_get_lcore_count_from_domain(domain, 0);
+
+	for (unsigned int i = 0; i < lcnt; i++) {
+		int16_t lc = rte_topo_get_nth_lcore_in_domain(domain, 0, i);
+
+	RTE_TEST_ASSERT(CPU_ISSET(lc, &cpuset),
+		"Cpuset missing lcore %u", lc);
+	}
+
+	RTE_TEST_ASSERT(((unsigned int)CPU_COUNT(&cpuset) == lcnt), "Cpuset contains extra CPUs");
+
+	printf("INFO: cpuset lcore cross test: success\n");
+	return TEST_SUCCESS;
+#else
+	return TEST_SKIPPED;
+#endif
+}
+#endif
+
+static int
+test_topology_lcores(void)
+{
+#ifdef RTE_LIBHWLOC_PROBE
+	printf("\nTopology test\n");
+
+	printf("\nLcore dump mapped to topology\n");
+	rte_topo_dump(stdout);
+	printf("\n\n");
+
+	if (rte_lcore_count() == 1) {
+		RTE_LOG(INFO, USER1, "topology MACRO test requires more than 1 core, skipping!\n");
+		return TEST_SKIPPED;
+	}
+
+	if (test_topology_macro() < 0)
+		return TEST_FAILED;
+
+	if (test_lcore_count_from_domain() < 0)
+		return TEST_FAILED;
+
+	if (test_lcore_from_domain_negative() < 0)
+		return TEST_FAILED;
+
+#ifdef RTE_HAS_CPUSET
+	if (test_lcore_cpuset_from_domain() < 0)
+		return TEST_FAILED;
+#endif
+
+	if (test_main_lcore_in_domain() < 0)
+		return TEST_FAILED;
+
+	if (test_wrap_with_skip_main_edge_case() < 0)
+		return TEST_FAILED;
+
+	if (test_invalid_domain_selector() < 0)
+		return TEST_FAILED;
+
+	if (test_multiple_invalid_inputs() < 0)
+		return TEST_FAILED;
+
+	if (test_large_index_values() < 0)
+		return TEST_FAILED;
+
+	if (test_domain_next_lcore_no_wrap() < 0)
+		return TEST_FAILED;
+
+	if (test_domain_next_lcore_wrap() < 0)
+		return TEST_FAILED;
+
+	if (test_multibit_domain_selector() < 0)
+		return TEST_FAILED;
+
+	if (test_domain_lcore_round_trip() < 0)
+		return TEST_FAILED;
+
+	if (test_domain_lcore_ordering() < 0)
+		return TEST_FAILED;
+
+	if (test_cpuset_matches_lcore_list() < 0)
+		return TEST_FAILED;
+#endif
+
+	return TEST_SUCCESS;
+}
+
+REGISTER_FAST_TEST(topology_autotest, NOHUGE_OK, ASAN_OK, test_topology_lcores);
-- 
2.43.0

