Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1D2CCD184
	for <dpdk-dev@archiver.kernel.org>; Sat, 18 Oct 2025 06:48:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58B4D402A2;
	Sat, 18 Oct 2025 08:48:56 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010061.outbound.protection.outlook.com [52.101.61.61])
 by mails.dpdk.org (Postfix) with ESMTP id 3AA4F400D7
 for <dev@dpdk.org>; Sat, 18 Oct 2025 08:48:55 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksEFe6j6ToqYmLKSlZLNfKPjEFbCQ3EjhnDsu3QVezb7MTvjx0KdN7lD9OPkXE7jBgzDQ1pRlsdFcEewlznZfzrqQg7CBtxTYhluR4ubJ8x6kcWRRS+auMiw6oAdRJF0Dqpa1b6vRStGHJ6FYmxgmD5ewkMaScs+9NiMHaHiv0O5Q8Ep0jLYGUHZJya9Lla2xi/qsyf8sJ0kbBroPZLHvQCc3WegT1gQv6yAkfed+M3bNnF6FZ21jT5aVE+CXo/hkdsJuJ/pniuq+fT/uoPMyvhAZDEGI7ykax2Q/tk38ldiZG4+K8heqghWLE/kZlKMXy3un04kza12GjZFrUXlQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNOYklhfXEUrOFCVXXh3bpZkob2gfZz4IsGOCo4SDJk=;
 b=KKF45B0u4mgJSpezbE9Q6OCJoYpC1ULEXCLteHF+MqpaeqR4HpdMN6wxQsqdvPengWWD26EPCKOYawUfkMfWsZS/Yv2ZTEyp8eUjD4VTtvkHyLhj/+oHiJ73VvOyZT2FmdFOG/RjSiDwQXro4654FC47uT3+5GW1tHewXx/LogfrPk3MvJ7XesNWkewqIetLBCby2KxHYgQkwywFsGSABDG5nLQP/N8ZTIKxRV6AFngBqvDkGrZzHjQYRiKYm7F+ShOLjwphYs4GUYKIkq4B8VTgPaSy7Vi46yhtia/RyQATenRz5GWffWzE3U3jTFH0fG51Q3Nyk8m5v0QRWlpZKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNOYklhfXEUrOFCVXXh3bpZkob2gfZz4IsGOCo4SDJk=;
 b=XJfSbg9qhqzBW4zRVBETLaGTmoF32LB3E/4CkAbsihEWYFphluBIa5xy/m2s3tUW4enjWaz0S0GQpTiCxwOpPkMA/r2SWOFzurZQQQbrITXVCSpCa/KyNBS16P/gB4ekwCgkEdDweXLgq+8iM0XC9rddSV3BkLGEiISwCMWRSTA=
Received: from BL1P223CA0035.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::19)
 by DS0PR12MB8042.namprd12.prod.outlook.com (2603:10b6:8:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Sat, 18 Oct
 2025 06:48:51 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:5b6:cafe::1f) by BL1P223CA0035.outlook.office365.com
 (2603:10b6:208:5b6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Sat,
 18 Oct 2025 06:48:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Sat, 18 Oct 2025 06:48:51 +0000
Received: from epycpwr02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 23:48:49 -0700
From: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
To: <bruce.richardson@intel.com>, <honnappa.nagarahalli@arm.com>,
 <anatoly.burakov@intel.com>, <jerinj@marvell.com>, <radu.nicolau@intel.com>,
 <gakhil@marvell.com>, <cristian.dumitrescu@intel.com>,
 <ferruh.yigit@amd.com>, <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>
Subject: [PATCH v2] test/ring_perf: add optional cross L3 core selection
Date: Sat, 18 Oct 2025 06:48:27 +0000
Message-ID: <20251018064831.1153059-1-sivaprasad.tummala@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <https://patches.dpdk.org/project/dpdk/patch/20251017163407.845502-1-sivaprasad.tummala@amd.com>
References: <https://patches.dpdk.org/project/dpdk/patch/20251017163407.845502-1-sivaprasad.tummala@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|DS0PR12MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: d6cef8f3-6c06-4f2d-3cfa-08de0e126606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elIvcVgzblF3SEVoTWE4czF5b093VUlyUUxHTVlXVnExNWZjQ1ZqTTlSRHJT?=
 =?utf-8?B?Unl0WS9ndWNQeHAwS1VlTnl0VHJMV2pXb05JNm1zMzg0N3ZTRzFBbFAzaFM1?=
 =?utf-8?B?N2w5ZmJHekZJMVpKUTEwRUhQbUkrRW9WZldDVTNkUk5oaFU4Y2lNS2Vuejlk?=
 =?utf-8?B?aWZnVjNOaHlDSlRyRVozL0tqWWhVUVlFU050SThqWnFwNjlSSW9jQ1BNODJk?=
 =?utf-8?B?OHI3U0hKZ0RXU0JzQTFDd3MzUDBLTGRXTm5aUy9vL2F5OWxUeVZLVGZEYi9t?=
 =?utf-8?B?Y0FGWlZtVjZvNDcvekwwb3d2aStYelFUQmRjdXVuak14SG92OC9sUkNwdUVP?=
 =?utf-8?B?cTQ1SnRkNjZBaXpGZE0vQy9HbWNhZkFKQnNrUkh6VjQrempGN2tCVFNNRWp3?=
 =?utf-8?B?ODFuNzdwb2ZvSlFoMXd3eTA5SUtKcFhVbStidENlYnRURytVZFk4K3FWQy9K?=
 =?utf-8?B?SHRFb2hyei9jdFhnaVF2RTlSaEFyKzR1MmhtOExsT2RacktBYlRaU2kwSkVI?=
 =?utf-8?B?WTg3QlptaFJyOURhU1dHYnAwOUxtVjNrWVZ0TlpVSjBlRVFjYit5aGxuMlg3?=
 =?utf-8?B?SWVkTGxrZGtSS1NNam1kNG0yOXJPQ1hSUVduZDh4bTBuVklOeDBxRDJMa0M2?=
 =?utf-8?B?MWFTdytLSTFFSnRqeEpxc0dpeWw4Mndvdmc2SnMrT3pIZnhFQWp4Z2ltQ2l4?=
 =?utf-8?B?YXZ6N3lsaGw0UUJFWVFWWng2M05mdkpmdW5uczdZb1RvS0poYXNuckJXcXNK?=
 =?utf-8?B?UG01b1Nwc1dCblQ0WDYySCtLVEthQTEzR3paaGdTTm9SVDI0TzBUWktMRUhQ?=
 =?utf-8?B?WFNEU3Mra3JHQ1Q1SERiSldESlNqZjJUL29MRUFpdzQyWUZ3QVJSK0ZpVTc4?=
 =?utf-8?B?NmxGRnQvZ2xmVUN3N3NmcThKeFZCVVBlT2twSlgvVkY1a1IyTlNNT2pxZ2tK?=
 =?utf-8?B?Qm1vT1N0QnQyNDZhOHRqU09QQW9MbHpIQ1RRL0pEQ1JFYXNTYTRXOGUyR2Zp?=
 =?utf-8?B?eGo2c2dWVFNEdENmam94VWlyYkc2ZFNUNVZQSUZLWFFqbzY3bE16Zml2OExq?=
 =?utf-8?B?YVg3NzRuazViWk12SHpNb08rTjFaVVJuMHRuUkFkWkFITzRsU2M4QlpIWTdD?=
 =?utf-8?B?c1VDWndhOGF4SDAvVUJnd1RnMWt0S2J0QWF6YkExYVFDdmZSSXJ2VUhKblda?=
 =?utf-8?B?djFidTJEMGRjVkhCbWFReFo0Q25xK0pJVTF0c091QURjV0o5dnZUby9JNE40?=
 =?utf-8?B?MzBRR05jL1Y3c2d3UEpqMW01dTdFR3lRYUY1M01QTURTcmdzTlVMU0VaZ0Fp?=
 =?utf-8?B?a3ZUWHdRVEhvaUdwK1F6NHFQalJqNTFwNFNqdnY5RWpMV3JHSjJEeEhqVHdU?=
 =?utf-8?B?MEcxbGg2eXhncEVSaGIwL3o3VG9tOWFXR1NOckh2SHE0WnNNSVNFalNsL0I2?=
 =?utf-8?B?K2ZDYjZEMUJSbnJOTW1MYTN0R2FCWHVlOVBWWHcvalhkbzhrSTNsSE5rTGlJ?=
 =?utf-8?B?UkRBZmN0cFU0Vjh5dVc1RUNuMzZiWU5XRmwwRWNFYmdQcXdpM2lXTEh2STEv?=
 =?utf-8?B?QjhJZzZtN25SOHcxdDRMSkM4VnBqNUoxNkNFdGg2RFVMcE5neGNIcWtXRlJJ?=
 =?utf-8?B?a0ZqeUpKSzhMeXB1cDJSaVFIcVZ4Y2ZZQlJDOVM0enU1SWJENEhIY2I2QnM5?=
 =?utf-8?B?MlBvZnhEN3U5eWtBc2dxYkk4THBYNW8yL1Zrb083N1BaZzdkNG9LYlJSZmx0?=
 =?utf-8?B?V1ErWlNYeXo4eks4cllRaTE2dzgraUNCTTZjQW1KVFk0MW1LdzNEMWtwa0xt?=
 =?utf-8?B?amJ6ZjNKQTZKVEV4MHZ5YnNLM3hOMlc5ZlRqcUJtdkd2T2FIYmRMU1FoSVho?=
 =?utf-8?B?eU5pUGJlN0xqd3JXd2VmZmdRL2h5bkpPYklZVFdrclozVGxvVDZCc2ExSXVE?=
 =?utf-8?B?SjdtTDdLdjhSc2FnQ3J2NWtNdWdncExBYThTQ1FMSHFvMG5Pd0hZMGNhUVlB?=
 =?utf-8?B?ZzVTNDJiSWRMS000VlJ2MUZzNVVQNzk0WE5GMHVudTNZODMxUFNlS0JFRmFo?=
 =?utf-8?B?UFVxeGFlUmtXYituemZYdFJ5cTgwYTcvSEdzL1lXdXdzTUtaTHo5OWdqOHor?=
 =?utf-8?Q?pmXc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2025 06:48:51.6639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6cef8f3-6c06-4f2d-3cfa-08de0e126606
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8042
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

Enhances test_ring_perf to optionally select two cores on
the same socket but on different L3 caches using hwloc.

This allows performance characterization of ring library
on processors with split L3 cache architectures, providing
more realistic measurements of inter-core communication
and cache effects.

The feature is conditional on hwloc being present, ensuring
builds succeed on systems without hwloc.

Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>

v2:
* Localized hwloc dependency to test app only.
* Optimized get_two_l3caches() by moving socket and L3 cache ID
  retrieval to the outer loop.
---
 app/meson.build           |  8 ++++-
 app/test/test_ring_perf.c | 76 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/app/meson.build b/app/meson.build
index 1798db3ae4..5443043f0c 100644
--- a/app/meson.build
+++ b/app/meson.build
@@ -46,6 +46,12 @@ if get_option('default_library') == 'static' and not is_windows
     default_ldflags += ['-Wl,--export-dynamic']
 endif
 
+hwloc_dep = dependency('hwloc', required : false)
+if hwloc_dep.found()
+  default_cflags += ['-DHAVE_HWLOC=1']
+  message('hwloc found — enabling L3 cache–aware topology support')
+endif
+
 foreach app:apps
     name = app
     build = true
@@ -60,7 +66,7 @@ foreach app:apps
 
     # use "deps" for internal DPDK dependencies, and "ext_deps" for
     # external package/library requirements
-    ext_deps = []
+    ext_deps = [hwloc_dep]
     deps = []
 
     if not enable_apps.contains(app)
diff --git a/app/test/test_ring_perf.c b/app/test/test_ring_perf.c
index 9a2a481458..51585d647b 100644
--- a/app/test/test_ring_perf.c
+++ b/app/test/test_ring_perf.c
@@ -15,6 +15,10 @@
 #include "test.h"
 #include "test_ring.h"
 
+#ifdef HAVE_HWLOC
+#include <hwloc.h>
+#endif /* HAVE_HWLOC */
+
 /*
  * Ring performance test cases, measures performance of various operations
  * using rdtsc for legacy and 16B size ring elements.
@@ -122,6 +126,70 @@ get_two_cores(struct lcore_pair *lcp)
 	return 1;
 }
 
+#ifdef HAVE_HWLOC
+
+#if HWLOC_API_VERSION < 0x20000
+#define hwloc_get_next_obj_cpuset_by_type_compat(t, s, ty, p) \
+	hwloc_get_next_obj_covering_cpuset_by_type(t, ty, p, s)
+#else
+#define hwloc_get_next_obj_cpuset_by_type_compat(t, s, ty, p) \
+	hwloc_get_next_obj_covering_cpuset_by_type(t, s, ty, p)
+#endif
+
+static int
+get_l3_cache_id(unsigned int cpu_id)
+{
+	hwloc_bitmap_t cpuset = hwloc_bitmap_alloc();
+	hwloc_topology_t topo;
+	hwloc_obj_t obj;
+	int l3_id = -1;
+
+	if (hwloc_topology_init(&topo) < 0 ||
+		hwloc_topology_load(topo) < 0) {
+		hwloc_bitmap_free(cpuset);
+		return -1;
+	}
+
+	hwloc_bitmap_only(cpuset, cpu_id);
+
+	obj = hwloc_get_next_obj_cpuset_by_type_compat(
+		topo, cpuset, HWLOC_OBJ_L3CACHE, NULL);
+
+	if (obj)
+		l3_id = (int)obj->logical_index;
+
+	hwloc_bitmap_free(cpuset);
+	hwloc_topology_destroy(topo);
+
+	return l3_id;
+}
+
+static int
+get_two_l3caches(struct lcore_pair *lcp)
+{
+	unsigned int id1, id2;
+	unsigned int c1, c2, s1, s2;
+	RTE_LCORE_FOREACH(id1) {
+		c1 = get_l3_cache_id(id1);
+		s1 = rte_lcore_to_socket_id(id1);
+
+		RTE_LCORE_FOREACH(id2) {
+			if (id1 == id2)
+				continue;
+
+			c2 = get_l3_cache_id(id2);
+			s2 = rte_lcore_to_socket_id(id2);
+			if ((c1 != c2) && (s1 == s2)) {
+				lcp->c1 = id1;
+				lcp->c2 = id2;
+				return 0;
+			}
+		}
+	}
+	return 1;
+}
+#endif /* HAVE_HWLOC */
+
 static int
 get_two_sockets(struct lcore_pair *lcp)
 {
@@ -483,6 +551,14 @@ test_ring_perf_esize_run_on_two_cores(
 		if (run_on_core_pair(&cores, param1, param2) < 0)
 			return -1;
 	}
+#ifdef HAVE_HWLOC
+	if (get_two_l3caches(&cores) == 0) {
+		printf("\n### Testing using two cores on same socket"
+			" with different L3 caches ###\n");
+		if (run_on_core_pair(&cores, param1, param2) < 0)
+			return -1;
+	}
+#endif /* HAVE_HWLOC */
 	if (get_two_sockets(&cores) == 0) {
 		printf("\n### Testing using two NUMA nodes ###\n");
 		if (run_on_core_pair(&cores, param1, param2) < 0)
-- 
2.43.0

