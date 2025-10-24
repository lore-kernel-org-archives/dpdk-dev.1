Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40414CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 14:16:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CC0540151;
	Fri, 24 Oct 2025 16:16:58 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013016.outbound.protection.outlook.com
 [40.107.201.16]) by mails.dpdk.org (Postfix) with ESMTP id F10AF40150
 for <dev@dpdk.org>; Fri, 24 Oct 2025 16:16:56 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnV43Zu9+FQak81/Y7BoKNEdYSVnH/+t2ddMUmvdVL8EmZqwxMxrN+vO2G8M0dC0hMM3DEVxMDRHZlvLEv0vRqRsvBPUhyF0gdIRnGfoZ69hQKtMGrquYCu4pfTs2hPkOs4BVFTHPovsOw3XZrDrN0wSKLhvrR3wjpcp80vo6nJK/z9Cx4qtJAyQyXrrNquCv5UIv74INI7ODHpQAq9i+KsFZ5MPFH+ORkHTjofm6/XjPLZm1s8J+JmxzlcKuPsxyt362ULsZGALaFOYS4VQnnQuCSXYdanLeJVkuUyahHdvx4Evbp6nxcyW7jj6kO/2h6M/0ojYPY4cs1DnkzpFcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFeH/Z4Fb6TPwu4/abyAgt++IqZaw67HFnyRLw93lH0=;
 b=EsJxH2RzGbB+fzB9fl53ZRgWY5jaERdMZOOJ+npR+4IrB9zoQThTPaOp5Fuoywpc/WMGjE0BqZCWPNIG+LwM/0r2YWSNAqPkZp3KzEFgXf8VBx2IZDwQhBsKmC/WRZq6GcbUBNoT+SHwE0DKs7/kxelYYL9d3NJdgGntbkZF2qlwfeZk5qx8BsfnQ3zc2Ebi6IxPujrkoL/pH210fIQwQeyWQeYlhnvb7A1l2BQL9IhKRE8jsmlMAoNryfJonUm+N9QFdT5z00z21NQMXCU65GFJbtVLJ3vyvkqkjMrLDQzqbnJo2fjfWnWeh2O3p6RYBmvNaEr/E9QGqb0JSmDhTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFeH/Z4Fb6TPwu4/abyAgt++IqZaw67HFnyRLw93lH0=;
 b=YUL+Gl3BtZT+SKmlwvDuEHyP+1vgd+yI01esAD5pHqeyOCy6LLN3sWqGFHjQieDJ9iaKcQL5aq4YhBNeXbmZkp1LBtLTr8+4RUDzEPbb9ngepdMwDsA9wb2XZUHOgECJWraVp7yKw1qEos1+WXEWiLKV0wMnN2ATre3UXb+PPrs=
Received: from BYAPR02CA0010.namprd02.prod.outlook.com (2603:10b6:a02:ee::23)
 by IA0PR12MB7676.namprd12.prod.outlook.com (2603:10b6:208:432::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 14:16:53 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::9e) by BYAPR02CA0010.outlook.office365.com
 (2603:10b6:a02:ee::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Fri,
 24 Oct 2025 14:16:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 24 Oct 2025 14:16:52 +0000
Received: from epycpwr02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Oct
 2025 07:16:51 -0700
From: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
To: <bruce.richardson@intel.com>, <honnappa.nagarahalli@arm.com>,
 <anatoly.burakov@intel.com>, <jerinj@marvell.com>, <radu.nicolau@intel.com>,
 <gakhil@marvell.com>, <cristian.dumitrescu@intel.com>,
 <ferruh.yigit@amd.com>, <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>
Subject: [PATCH v3] test/ring_perf: add optional cross L3 core selection
Date: Fri, 24 Oct 2025 14:16:31 +0000
Message-ID: <20251024141635.3939617-1-sivaprasad.tummala@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <https://patches.dpdk.org/project/dpdk/patch/20251018064831.1153059-1-sivaprasad.tummala@amd.com>
References: <https://patches.dpdk.org/project/dpdk/patch/20251018064831.1153059-1-sivaprasad.tummala@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|IA0PR12MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: 42df46c2-3b80-4de5-3efe-08de1307fae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnMvMk1ZRzNDUEJQdnJIN251WWx0MTAwYnlYL0hGMU4wS01KZzU4RU5PcnZF?=
 =?utf-8?B?eHB0REFsbi9yRnpjVjRwS3V0T0JMVzFLZE9tWGpzSDZrN2I3K1gvRXA4MDBE?=
 =?utf-8?B?ZUFObURKQ1hSVzVKNm9Ycnh6dE1QQnd1ZVM3L1U4R2lRTjBOZlIvK2hTcS9m?=
 =?utf-8?B?WHRvc2hGRExXb2pIZWUwaURaZmJzcDhmc2gxZERuRmJoOHhML1NsVVVxV0xl?=
 =?utf-8?B?QUdpUkZWQ1lzQUllK3oxRlduSXlXRUFzMnl5T0c2ZGUyWEx5NkVZNVgzQVFy?=
 =?utf-8?B?VkpOdEtmZGUyQit6WUtjSHNXWHp2VXovc0NrRHdkSEcrdkhHcGVKUzF4Z0Y3?=
 =?utf-8?B?cWxGWEppejVQc3JoU3EwcWlmUTZ6MFZ0WG9tRWhPVkdYL2R5QWxScWM2bUpo?=
 =?utf-8?B?dzYzNk55WG5wcnNYVy9KK3hnSHh0NzBoS3RWdCtOWDA5ZnN4ZTlxK0x4Z0c4?=
 =?utf-8?B?WFE1Sm1yOG9QR3M5Vjg0bFlWRnF6U3Fmb0hRdW1FVmtOMG9ZRU5VbnNxUXpD?=
 =?utf-8?B?VUs3NjhCQ1hrR3pFRGpNZnpOeDZVaGh3UkZvVGNyQzBHa0ZmeENTcU9qMm5C?=
 =?utf-8?B?enFNUHVLYTQ5RjdxYnA1L1NIcUd3VTZENEZtYWIrWVBwZXo2M1hvTE82ZzEw?=
 =?utf-8?B?Y1Q0cm1aRk9sOCtIeThuQWJObDJpczRnU2dGV2VyTmRSNisvdVhlcjNKZndH?=
 =?utf-8?B?Y0ZiUkpOYitXd0NvRzU3ckNwQXJvTWM3anpYRkFJYlF3RmJadmRLL3JZenF3?=
 =?utf-8?B?NkM5YlNEQlRYUStQY3UzRHZ3cWI4R3EvcmNrR0s0L3ZEQU56aDVrVnM3N3Jt?=
 =?utf-8?B?WVhKNUN5OU9TMTRPbVh0NENLU3JmM29ic0ovRDNHbm1iTE42VjdCbTFDM1Rl?=
 =?utf-8?B?eWh0eWFSS0RYalBPb1U1VVBxUlBxM2NMc2hhMTBrb2s0N0ZPNEx2czg4SlFE?=
 =?utf-8?B?Qkl0bDkrZFpiS1oyK2Y2RnhLUkIxWXBFcjhkVm9qaHlNL2pHVzdqeGE3RGEz?=
 =?utf-8?B?VFY1ZWNsZmM1NTlLY2Q1WXJWZ0dQTkp3TThSWnZmaFZadzhweVB4WGd0Mkov?=
 =?utf-8?B?RXQrMy9rZ0V3NnNvYm1jQlBydnI0WnJuMGhuRndzenkxNWpaMXdOYmp5Rm8v?=
 =?utf-8?B?eFhQazAxUm1xdzZpY0tHcGlRNEs5dkVGLzAzQ0FYUDhHN1kyWnRWVW5Kb1BB?=
 =?utf-8?B?Wk1rZk9LVGh1RFVmTHRFNzExWUR1c3lEc21iWWp2MllZUHBERndRMHYvbXFY?=
 =?utf-8?B?QTRUblNXOElDQnorS1R6dlFWN1BOT0M3ZkF4QU1GMFVpQ1FVTlFIMG9CRlJw?=
 =?utf-8?B?S1pVRWNIYzU4SXhrb2R2U1RmeVJWMXRVQ0JON24xOW9EeTFuZXUrZHRuRkZO?=
 =?utf-8?B?NTdoRWZ1dGVTSVBJeWcyR2JrYTBWK0U4RjllQXBORzFUYWVjSnFmU2h5ZXFv?=
 =?utf-8?B?OTM4YmtYQkZQdVFIWms0Zk4yTkhpRzlkbzZ5N3p0WTkyamYyZUJuUlRJa2lG?=
 =?utf-8?B?aXBVV1YzL1U4WFhqY3ZBaG0weVRPdEFVMmNuVnl3MGY1aE1QRzFhS0lsL2ZD?=
 =?utf-8?B?Uk9NMW81ZnhlVkszc09yK0MrYW1Od3JZclE3bCtQN2l2Y0g4WU9FeEFZNkt0?=
 =?utf-8?B?QVVZSC9UdjlBWEhucnlEUmVjQVJPdzhya285UlBRSkkzWGJjK1dVV3lQcTJz?=
 =?utf-8?B?Q2JMaFVGNzB3N0d2Y3FsMkVIWCtlZGNsVkhqVlcvSGwyTFNnYmM2YzBVMlBi?=
 =?utf-8?B?ZUp2RDRNWTVkdmwzendnMUhGRnhYdGlJcmtNblk4NFpTMGY3a3ZTZVRjdFlS?=
 =?utf-8?B?dWRzWVJ3TER4UWtQQnFzWml6aXh6VDlZWTNQZzhrK1picXlNMkZrNTQyTHJW?=
 =?utf-8?B?UDNQSURaSkRFcmszRitlYVc0V3JINlk2dzUzRE44TW0yRkhhMmZQNG5wcG8v?=
 =?utf-8?B?aGZCdE5XU3BSUWFtci9jVXFFK2JJTWVLd01jNzB1aVhyak5nc1ZNdG5nTVlZ?=
 =?utf-8?B?NGhLUjJkMndaWm9TS0VwYndtUEZyVG1USU43Ryt4NGJLcHFiMDVZZExCRGRK?=
 =?utf-8?B?Z1JBTEIrdndrM0ZGRUpQUWlTdlU4bDFwWE5wQm9rQ0E4THgzRFM4K2ZLREJJ?=
 =?utf-8?Q?UjVA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 14:16:52.7075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42df46c2-3b80-4de5-3efe-08de1307fae8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7676
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

v3:
* Localized hwloc dependency only to app/test for targeted linking.

v2:
* Localized hwloc dependency to app only.
* Optimized get_two_l3caches() by moving socket and L3 cache ID
  retrieval to the outer loop.
---
 app/test/meson.build      | 10 ++++++
 app/test/test_ring_perf.c | 76 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/app/test/meson.build b/app/test/meson.build
index 8df8d3edd1..667b191a5f 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -257,6 +257,16 @@ endforeach
 
 cflags += no_wvla_cflag
 
+# Optional hwloc support for L3 cache–aware tests
+hwloc_dep = dependency('hwloc', required: false)
+if hwloc_dep.found()
+  message('hwloc found — enabling L3 cache–aware topology support')
+  cflags += ['-DHAVE_HWLOC=1']
+  ext_deps += hwloc_dep
+else
+  message('hwloc not found — L3 cache–aware tests will be disabled')
+endif
+
 extra_flags = [
         # Strict-aliasing rules are violated by uint8_t[] to context size casts.
         '-fno-strict-aliasing',
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

