Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB959CCD19F
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 16:34:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03C2342D76;
	Fri, 17 Oct 2025 18:34:27 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
 by mails.dpdk.org (Postfix) with ESMTP id D7953400D7
 for <dev@dpdk.org>; Fri, 17 Oct 2025 18:34:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6/5iAaE5aLlc2N5E6v0XJnt15RxYgxwOSm1rt9H67pAPP9yzuU7QuZVtwnumiCcESJCaR+RoowzlUChMqJZsfgZs6wTVrKrUGy3BdBfyCD0uzpT6xyUjfJCU9s0cTYYcFQ+FpISRQY6mOU7jxrEHJ1U6C9fJdryHK6AHtSS5pz/ROkkYPGef6JGbLpRScBDWt3caN/gEl/XQ/v4PYxvr/EMUqhiBhf2WSJm8It0Q+GFc3dwHVCSIESYFL44YHIQjBNhAsHa9ikAF24Hsxz9KCFRvZsmOzCt/8vHF4vbmtaqcyljojamlYb+7tTK3RYb7sAXv0a5YEOWcX2EeM93Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6USWGyRX9qV3OtsDSl680mqguQH6BpXrfRzjjqZ2dtY=;
 b=T0yncGDJVc4zDMRVN1gxRVngc+vXG/ovdAXvmZXdM+Mq7uJjdAC2bXxoPC1Ok5OwlsO3tL4/HQTkiHoXNNUgrE+f1mQVkvqtVhnzkDRknzTAn98s+2nkahS6zri9QH6Ye7VBILTTeCmUl1Qy3DiIBaFFre2cGi13Kp0Xd4BM+jVm+/Rt+XBY4AwZN5l/dsV6wETTTt3pDHry054EU572kovZGSOxyz5M7cR7bBlfhChfBgYYLIOJqxQIBNC3U3XXbyluzU+eAOIzmaO3Mj/WI+H9+JUifq97IGk/3sXRSOi6ocGeo9RkGAtyxDgAL9oXOsTIQAQwhQZbz/A887Y9Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6USWGyRX9qV3OtsDSl680mqguQH6BpXrfRzjjqZ2dtY=;
 b=wM4egGGcyKOYJg9+ZWpecLdYBm5UGefY/YQzfu76Rw8kkBaMD69FmsMycZZByeu4xwHxXNlpzzMhJK5qUaity/4L5cTqb3hyUjPf2qxAAyrP9amaWUhbqShEWUgKapOdRyqIRL/Sq6yNuTKCOAJUYGt5qdDUxI4TdKFwgTmOVwA=
Received: from SJ0PR05CA0106.namprd05.prod.outlook.com (2603:10b6:a03:334::21)
 by SA3PR12MB8761.namprd12.prod.outlook.com (2603:10b6:806:312::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 16:34:23 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::20) by SJ0PR05CA0106.outlook.office365.com
 (2603:10b6:a03:334::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Fri,
 17 Oct 2025 16:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 16:34:22 +0000
Received: from epycpwr02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 09:34:21 -0700
From: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
To: <david.hunt@intel.com>, <honnappa.nagarahalli@arm.com>,
 <anatoly.burakov@intel.com>, <jerinj@marvell.com>, <radu.nicolau@intel.com>,
 <gakhil@marvell.com>, <cristian.dumitrescu@intel.com>,
 <ferruh.yigit@amd.com>, <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>
Subject: [PATCH] test/ring_perf: add optional cross L3 core selection
Date: Fri, 17 Oct 2025 16:34:04 +0000
Message-ID: <20251017163407.845502-1-sivaprasad.tummala@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|SA3PR12MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a38af7-e775-4173-2470-08de0d9b075e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVgzTTQvdFkvVCtjZ2QxakNqT24xTm82V0g2L0IraUtvb1R5UmRUaDhyYnJt?=
 =?utf-8?B?Z1phUG1yek8wTWhycFQydEthZGxxanpSekVEeHRqV3JqNXBOem9KSFNuOExY?=
 =?utf-8?B?NmRSODJQSXNGa3ZOeFlqV2RicXpWRThtQjQ0Y2VJUjdNb3dpU0REdGJWWFNs?=
 =?utf-8?B?SHVYZUVySmlTQjd1T25EcHBTWFQrMkJLby94U3dhR0VBZWVHNE5LUXJLc2J3?=
 =?utf-8?B?RlhFaERsbTBreTQ1Z1BySzNGc1FERXlXVUROSUtjOTRqR05GQW1aaDJDcDlQ?=
 =?utf-8?B?MktuOCt1SUJWSEpPbVF5MnVlWndMY3lqTHhRNE9PQ2d0VmU3V2tyanBJQy9U?=
 =?utf-8?B?UjZlNy9Xd2s5SWgwZU5pdnRFcFQ2N0JZb0FHQmJ3V25GSXFlM256bFRpSzRk?=
 =?utf-8?B?R1I2bDluNFhkTHNLbmRIeDYzb0d4TFFGZk5pYURyNkxjWmhYeEcvSlFEaElI?=
 =?utf-8?B?TEcrMzc5VWJmVDN3RjNPUXcwWW5GNGhGb0VXeU16cHpSQjVlaXRzU24zSk54?=
 =?utf-8?B?NXgzbDRDRkFYTjg5WmpJMGZEcWJ5U3NqZHg2MGliajY0TUUrNThwbnFTMHBz?=
 =?utf-8?B?SnBDUlJlcUttRWVVdjdURWxHbWJkTHB1bmN1VzIxbnM3TkdQdlZ3MjFDbnNY?=
 =?utf-8?B?bkpOaEJrYWlGVXhHTW9GQlpTWm52b0JBTlUvZ1dyMmxoWEc5bEsxbytRK1NS?=
 =?utf-8?B?VjdxM1NURFc4cXIyektmRFBmZEwxNGpoaytBTnl3NzJ6aThUVkxOL2J0VDJ3?=
 =?utf-8?B?OHRDYjgwaGtOdXFGc205elRiUzB3aVp1SnZkRFFLTXArZnYwWHRZMHJvYlQ2?=
 =?utf-8?B?V1ZGRWhHUUJQbUc4UlFpSFhld0dXZGg5NC9pc2NycFlzL2l6V0ZsV1B6Mnlj?=
 =?utf-8?B?YllnckhDb2pXeS9HcEIzSUFVNzk5YUR2T3JQb3NmcUxCQ0taK0ZiOGpMZmlD?=
 =?utf-8?B?N3FjQWU3b0tVL0VBUnNrQWdmWWtSV1RSekZTaTZwb3k3YU51M2VaWW82dWhl?=
 =?utf-8?B?WklTOHg0UXZHMzNqWlRIL1lMRDMwMjZIbHJROUV1ajdaQmtSdWRrcVBqT1pn?=
 =?utf-8?B?RWhndW0zYVZPc0RSaHY4ZzkzcVc2QXllbEV6YXh2NXVab3ZMUFErZisyb3VY?=
 =?utf-8?B?WlFoYjlHUHJxdE5kK3ZvRTdQT1VWa3hEemxVaHZkcE8vMU5UUzA4aW11SXI2?=
 =?utf-8?B?ZUhTelVVaWhWQTUzU0ExRFU4c3BFMUhpdTNUa29rRHdzOVh4TVJma1ZkdStZ?=
 =?utf-8?B?N2VQMjR0OTBlL2RRYTZSWWNyT2JYUVo4WE1rL1hqc2NXMnQ3RTFrZUFERysr?=
 =?utf-8?B?R1NhajBwT2RwZ2xWSWRSbFhmblFkTnRWelRrR3BWeStSVVhQc2ZHaFJ1MjE4?=
 =?utf-8?B?Q0k5QUZZUUp6eGlGSHZzdXV1Z0NHalBuUXFFMUU3Sy93QmpmdERCOXc5bkJn?=
 =?utf-8?B?OXpWK3QxR1ZqZE1LSDFUTVpKWURBNytDQkZyUGJDWUh2d3ovQ0w5emF0R2Fw?=
 =?utf-8?B?SnVINStvbjhreVpSeExtcXdLYy9EbXd2SnRqQmlIYnJsRkg3TEVwQ1BDYnNX?=
 =?utf-8?B?Um01RnZRalJteDdjUGNQSXNQNEwzdUhvNDBac2Z5YUp6UVlTUUtYSXdSaEhT?=
 =?utf-8?B?b3NtOUNoOGFuNnQ2QkRIMmNQNVl3ZmtLdFlCaVlMZzJuVUR0bjFFMjQ5RGlr?=
 =?utf-8?B?T2ZJck42aHBSbVZOWE00MzNtQTQwc09PL1J5V2xxWlI2UHBvT2xoT2ozb1pV?=
 =?utf-8?B?MWNDK3R2T05leUdoaHBLc1FJbXEvTTI5ODVjQStlM3UrcEJGd3FWOHZvcDJo?=
 =?utf-8?B?VGFLM2poaDdsMzlrdndrR3h1bnRsRlJ3U0RBSWs2MkxnSVVwM2piejIrdGpQ?=
 =?utf-8?B?U0ZkUW4rV1hGVzhwMkhSUlFXMDkxTHd4RGJUMEpuSHNnOW82bkRjeklqTVVo?=
 =?utf-8?B?aEhIWGJRd0w1UWkrYkl5dVlnVVY5ZE1OL2hyaUhycXVOc2NmTTRMUGIyODZz?=
 =?utf-8?B?SzhwNEVBc1RhbWRaME53VDJSZTFoRTQ1K3dFMmFBUnRwQWczK1BDbnN6WlRi?=
 =?utf-8?B?Z2wyUzY5Q2ZuU0hDc25EYjE1T0JGc2xnQmFPOTUvV0RlM0lvM2hudzJrTGVD?=
 =?utf-8?Q?juQY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:34:22.6548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a38af7-e775-4173-2470-08de0d9b075e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8761
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
---
 app/test/test_ring_perf.c | 75 +++++++++++++++++++++++++++++++++++++++
 config/meson.build        |  8 +++++
 2 files changed, 83 insertions(+)

diff --git a/app/test/test_ring_perf.c b/app/test/test_ring_perf.c
index 9a2a481458..2003949649 100644
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
@@ -122,6 +126,69 @@ get_two_cores(struct lcore_pair *lcp)
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
+		RTE_LCORE_FOREACH(id2) {
+			if (id1 == id2)
+				continue;
+
+			c1 = get_l3_cache_id(id1);
+			c2 = get_l3_cache_id(id2);
+			s1 = rte_lcore_to_socket_id(id1);
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
@@ -483,6 +550,14 @@ test_ring_perf_esize_run_on_two_cores(
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
diff --git a/config/meson.build b/config/meson.build
index b8c1f127a2..75630254f2 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -313,6 +313,14 @@ else
     add_project_arguments('-include', 'rte_config.h', language: 'c')
 endif
 
+hwloc_dep = dependency('hwloc', required : false)
+if hwloc_dep.found()
+  add_project_arguments('-DHAVE_HWLOC=1', language : 'c')
+  add_project_link_arguments('-lhwloc', language: 'c')
+  dpdk_extra_ldflags += '-lhwloc'
+  message('hwloc found — enabling L3 cache–aware topology support')
+endif
+
 # enable extra warnings and disable any unwanted warnings
 # -Wall is added by default at warning level 1, and -Wextra
 # at warning level 2 (DPDK default)
-- 
2.43.0

