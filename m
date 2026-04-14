Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D881F9D0EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 19:39:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4085B4028F;
	Tue, 14 Apr 2026 21:39:55 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013019.outbound.protection.outlook.com
 [40.93.201.19]) by mails.dpdk.org (Postfix) with ESMTP id 3EBB54028D
 for <dev@dpdk.org>; Tue, 14 Apr 2026 21:39:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ig8yw5n58je2OwFMPY6LG0s+ExnpEHS2zsdkX7acQAXkdoBjgiNSCz0wtsnD6AXvwVvwOZGCkYB7U4LcwDe337H3Sp9smHMIUQ/J9jQI2LfwykuHbesikrwFDWNCeS+du8vAwcXIX3rI4dA9d+b7PNnotdKlOEcONL7Z99iGajEBNNSusgXSMx7l4iZwUzCWdXkpJ7lBDx0bnC6JRLxdy7djahvNPgrSEp4rwgx1O0RsFTTcgPIHXFmujCi2ZtKrW3XmU2xBWUqt9tfadkfssiU4tl5DkRUs83J3GX3TlJbMbvYi5kcmEv9aOcvBbjXqHHGli/XwnmO+FJNPbbx6QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFWWafRjRWXzLTusBjiOmSsmS7EFzMlQKt+RRo3Wxls=;
 b=qVIn9VDIUybVx+GmZ1rIE3oUVZR/erlZ6tGl0H0ZGJVxxsDBbmKTydVWMKC07asGPtABAOe48yGwTaK+xen191V/8ld/m5wuiadxX+c39Hu2DyeTsFE/aFZ+5ub0Aotw3PrvP/JnT8+N63ngbq2ozWWe7aWDBOiE5CZTev0PNFKvQIB+VM7a94fFOHMSrYDeRP+9et3OJdxVoFK5sHmv4DQSmgMBsGZbkgBJZc1ncvR/iMP1SvTSFNdgjFS5bPgPdPMRWhPkAdsUkapIX4zJHJJ45bhwJKKuAUC9tTbJMioDVMdRYmHF251bFx1AILuQghjvePnWqp/b7n53NWEW3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFWWafRjRWXzLTusBjiOmSsmS7EFzMlQKt+RRo3Wxls=;
 b=OyaD7aJzpxGPKtNf+gelCmF164qs9ZiLsdiOQW4FhH4CM4jAoW3jaFFigSlTqFDP1ENVvj7/Xv39HvMjebSAPz3sSiA2/GvkrjTmY7xcl/PwgFX52k/gznWb+4gJe8pVQi/ooO/WqOJF/+rnKZdWi/sKkoFf1qSHmi2P1l+Yqbw=
Received: from CH5P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::7)
 by PH7PR12MB7236.namprd12.prod.outlook.com (2603:10b6:510:207::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 19:39:42 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::32) by CH5P221CA0014.outlook.office365.com
 (2603:10b6:610:1f2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 19:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 19:39:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 14:39:41 -0500
Received: from BLRVIVARGHE.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 12:39:38 -0700
From: Vipin Varghese <vipin.varghese@amd.com>
To: <dev@dpdk.org>, <sivaprasad.tummala@amd.com>
CC: <konstantin.ananyev@huawei.com>, <wathsala.vithanage@arm.com>,
 <bruce.richardson@intel.com>, <viktorin@cesnet.cz>,
 <mb@smartsharesystems.com>
Subject: [PATCH v5 v5 1/3] eal/topology: add Topology grouping for lcores
Date: Wed, 15 Apr 2026 01:08:19 +0530
Message-ID: <20260414193850.1696-2-vipin.varghese@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|PH7PR12MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: f1010972-982c-4c47-2684-08de9a5d92dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gck5KGVPYIekGacnx9yvz3alLMAY866kujGEeWIMWzyps3It52MO1iRtUwCvHYwe7qACSWFhYJHApsn/1rgvOq7Vx9rxVccSlWjCWLeJCkixDaSr0/a7lqlodclncZvp4+QIdSsDsRUsi4fuq4PChsjNVkgDOujCqn0wdTGJIYUDmjm4tum26ARsHL3d5C9TB/awhJQl+HjXRNE1HUitTm6HugaX7UFzKBAACRoIyVyTHERis1+4GB3+TagdP1D7/uqROZ/IDThHinwy7CUhMiT/ktmOJsg1pdCCP9Nr2gymlW2Wiq45FccnGWs+Owxyt3gAOoQske4EA2AneOGjnkVbCZFl+AdkfhRhqTMs0dhnjSwgOSobZU8IC8UImiNBshXygOo5p6k/iBr+Yo/D2aIjgTvpddQ8QTmOHeHqkOekXi7oW9HhDjtAyjlPskkghCWPne+a0QW0mcbxfAFZ08CcJrK0sEeEXpQ3Zah0BkVvsSYpYw09njjqFQUf+Wbc2/pc/g0W5YFr11YDg5bt8Tx4jOorKzH3X/n1S/StB5b0FtXbXxjdpwk0uW1W7yH5WbZymJNWY7CD/K2JCX8i5XXQHBHDLYn0izYJCZw1FRWinMRAm+/vOrJTJf4Wx12bZREZc12JP7hw4RYOuUEkGa9wEdn8Rdss5jilpGiAsAhQ0ckwrgfDLSeOG7m2Ta000SxeY69vp9F80WCvaGcSfbdkT3VA6u30rdp115Dh6xDbY9x0ddXZQLuN+UnOhSnwaiQhb/8nbhcQ7/l7evt/rA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nTjt2V0MKETdMBJxGBeK8Ddpl4BZbRMQsjpUR6EQ67VKRnSZswyy4l0xj6MiGz6yVm4mwGoa9MthmJOqZJLyyg7GkIVlTc/nghjT190IFi2c/Rwyw94AGBrOKa3YogzdqW2uXdoz+lveDFjWYGhghLfEUiXRekxl12auiy+X6gXgRbWp2M6yY9ldc+6rmrddE5gIl5ZhAM5y7ilItC6fImv0DhdtOK8t7aJZ8rJvYlmUP3GtTJYmO1Jw1HCYTHdDNWyRfS9PujIQ9fdF3UMZeNMpAEdSQhGfexoqlDp3BxYukH1fm9/rFXnZN+A8CI0Kqr+BqhlY/AeNDFclrKPqJj21u/OX5HOg1VIbMjU+qUzP+gcOai8WgSHlWp1cj41B9IMn2eJ058xxB60aOjPAkUtTRN79YVqt3E+zdCp9DW61xBWeebFtN7clS9mXTNr+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 19:39:41.9179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1010972-982c-4c47-2684-08de9a5d92dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7236
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

This patch introduces NUMA topology awareness in relation
to DPDK logical cores. The goal is to expose API which allows
users to select optimal logical cores for any application.
These logical cores can be selected from various NUMA domains
like CPU and I/O.

Change Summary:
 - Add concept of domain partitioning based on CPU and I/O topology.
 - Group DPDK logical cores iinto groups of L1|L2|L3|L4|IO.
 - Add supportor helper MACRO as iterator.

v4 changes:
 - cross compilation failure on ARM: Pavan Nikhilesh Bhagavatula
 - update helloworld for L4

v3 changes:
 - fix typo from SE_NO_TOPOLOGY to USE_NO_TOPOLOGY

Reason:
 - Applications can performs better using lcores within the same domain.
 - In pipeline and graph application; sharing cache reduces memory access.
 - Use L2|L3 cache-id to configure Data injection & PQoS.
 - Integrate hwloc-dev library, which allows
   -- grouping into DPDK favourable domain
   -- reverse lookup from lcore to domain-id.
   -- ensure no ABI breakage with versions of hwloc-dev
   -- consistent mapping even with DPDK lcore option `R`.

Library dependency: hwloc-dev

RTE_TOPO API:
+++++++++++++

Domain Enumeration
 - rte_topo_get_domain_count(domain_sel)

Lcore Enumeration
 - rte_topo_get_lcore_count_from_domain(domain_sel, domain_idx)
 - rte_topo_get_nth_lcore_in_domain(domain_sel, domain_idx, lcore_pos)
 - rte_topo_get_next_lcore(lcore, skip_main, wrap, flag)
 - rte_topo_get_nth_lcore_from_domain(domain_idx, lcore_pos, wrap, flag)

Domain Lookup
 - rte_topo_get_domain_index_from_lcore(domain_sel, lcore)
 - rte_topo_is_main_lcore_in_domain(domain_sel, domain_idx)

Cpuset
 - rte_topo_get_lcore_cpuset_in_domain(domain_sel, domain_idx)

Debug
 - rte_topo_dump(FILE *f)

Platform tested on:
-------------------
 - AMD EPYC MILAN
 - AMD EPYC GENOA
 - AMD EPYC SIENA
 - AMD EPYC TURIN
 - AMD EPYC TURIN-DENSE
 - AMD EPYC SORANO
 - ARM AMPERE
 - INTEL XEON GNR-SP
 - INTEL XEON SPR-SP
 - NVIDIA GRACE SUPERCHIP

Signed-off-by: Vipin Varghese <vipin.varghese@amd.com>
---
 config/meson.build             |  18 +
 lib/eal/common/eal_private.h   |  74 ++++
 lib/eal/common/eal_topology.c  | 746 +++++++++++++++++++++++++++++++++
 lib/eal/common/meson.build     |   1 +
 lib/eal/freebsd/eal.c          |  10 +-
 lib/eal/include/meson.build    |   1 +
 lib/eal/include/rte_topology.h | 255 +++++++++++
 lib/eal/linux/eal.c            |   7 +
 lib/eal/meson.build            |   4 +
 9 files changed, 1115 insertions(+), 1 deletion(-)
 create mode 100644 lib/eal/common/eal_topology.c
 create mode 100644 lib/eal/include/rte_topology.h

diff --git a/config/meson.build b/config/meson.build
index 9ba7b9a338..db2faccdbc 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -245,6 +245,24 @@ if find_libnuma
     endif
 endif
 
+has_libhwloc = false
+find_libhwloc = true
+
+if meson.is_cross_build() and not meson.get_external_property('hwloc', true)
+    # don't look for libhwloc if explicitly disabled in cross build
+    find_libhwloc = false
+endif
+
+if find_libhwloc
+    hwloc_dep = cc.find_library('hwloc', required: false)
+    if hwloc_dep.found() and cc.has_header('hwloc.h')
+        dpdk_conf.set10('RTE_LIBHWLOC_PROBE', true)
+        has_libhwloc = true
+        #add_project_link_arguments('-lhwloc', language: 'c')
+        #dpdk_extra_ldflags += '-lhwloc'
+    endif
+endif
+
 has_libfdt = false
 fdt_dep = cc.find_library('fdt', required: false)
 if fdt_dep.found() and cc.has_header('fdt.h') and cc.links(min_c_code, dependencies: fdt_dep)
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index e032dd10c9..904df0d0b7 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -9,12 +9,17 @@
 #include <stdint.h>
 #include <stdio.h>
 #include <sys/queue.h>
+#include <rte_os.h>
 
 #include <dev_driver.h>
 #include <rte_lcore.h>
 #include <rte_log.h>
 #include <rte_memory.h>
 
+#ifdef RTE_LIBHWLOC_PROBE
+#include <hwloc.h>
+#endif
+
 #include "eal_internal_cfg.h"
 
 /**
@@ -40,6 +45,63 @@ struct lcore_config {
 
 extern struct lcore_config lcore_config[RTE_MAX_LCORE];
 
+struct core_domain_mapping {
+	rte_cpuset_t core_set;	/**< cpu_set representing lcores within domain */
+	uint16_t core_count;	/**< dpdk enabled lcores within domain */
+	uint16_t *cores;	/**< list of cores */
+};
+
+struct lcore_mapping {
+	uint16_t cpu;
+	uint16_t numa_domain;
+	uint16_t l4_domain;
+	uint16_t l3_domain;
+	uint16_t l2_domain;
+	uint16_t l1_domain;
+	uint16_t numa_cacheid;
+	uint16_t l4_cacheid;
+	uint16_t l3_cacheid;
+	uint16_t l2_cacheid;
+	uint16_t l1_cacheid;
+};
+
+#define RTE_TOPO_MAX_CPU_CORES 2048
+
+struct topology_config {
+#ifdef RTE_LIBHWLOC_PROBE
+	hwloc_topology_t topology;
+#endif
+
+	/* domain count */
+	uint16_t l1_count;
+	uint16_t l2_count;
+	uint16_t l3_count;
+	uint16_t l4_count;
+	uint16_t numa_count;
+
+	/* total cores under all domain */
+	uint16_t l1_core_count;
+	uint16_t l2_core_count;
+	uint16_t l3_core_count;
+	uint16_t l4_core_count;
+	uint16_t numa_core_count;
+
+	/* dpdk lcore to cpu core map */
+	uint16_t lcore_to_cpu_map[RTE_TOPO_MAX_CPU_CORES];
+
+	/* two dimensional array for each domain */
+	struct core_domain_mapping **l1;
+	struct core_domain_mapping **l2;
+	struct core_domain_mapping **l3;
+	struct core_domain_mapping **l4;
+	struct core_domain_mapping **numa;
+
+	/* reverse map lcore to domain lookup */
+	struct lcore_mapping lcore_map[RTE_MAX_LCORE];
+};
+extern struct topology_config topo_cnfg;
+
+
 /**
  * The global RTE configuration structure.
  */
@@ -102,6 +164,18 @@ char *eal_cpuset_to_str(const rte_cpuset_t *cpuset);
  */
 int rte_eal_memzone_init(void);
 
+/**
+ * Initialize the topology structure using HWLOC Library
+ */
+__rte_internal
+int rte_eal_topology_init(void);
+
+/**
+ * Release the memory held by Topology structure
+ */
+__rte_internal
+int rte_eal_topology_release(void);
+
 /**
  * Fill configuration with number of physical and logical processors
  *
diff --git a/lib/eal/common/eal_topology.c b/lib/eal/common/eal_topology.c
new file mode 100644
index 0000000000..7362d8e723
--- /dev/null
+++ b/lib/eal/common/eal_topology.c
@@ -0,0 +1,746 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 AMD Corporation
+ */
+
+#include <inttypes.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <rte_topology.h>
+#include <rte_malloc.h>
+
+#include <eal_export.h>
+#include "eal_private.h"
+
+struct topology_config topo_cnfg;
+
+#ifdef RTE_LIBHWLOC_PROBE
+static inline bool is_valid_single_domain(unsigned int domainbits)
+{
+	if ((domainbits == 0) || (domainbits & ~RTE_TOPO_DOMAIN_ALL))
+		return false;
+
+	return (__builtin_popcount(domainbits) == 1);
+}
+
+static unsigned int
+get_domain_count(unsigned int domain_sel)
+{
+	if (is_valid_single_domain(domain_sel) == false)
+		return 0;
+
+	unsigned int domain_cnt =
+		(domain_sel & RTE_TOPO_DOMAIN_NUMA) ? topo_cnfg.numa_count :
+		(domain_sel & RTE_TOPO_DOMAIN_L4) ? topo_cnfg.l4_count :
+		(domain_sel & RTE_TOPO_DOMAIN_L3) ? topo_cnfg.l3_count :
+		(domain_sel & RTE_TOPO_DOMAIN_L2) ? topo_cnfg.l2_count :
+		(domain_sel & RTE_TOPO_DOMAIN_L1) ? topo_cnfg.l1_count : 0;
+
+	return domain_cnt;
+}
+
+static struct core_domain_mapping *
+get_domain_lcore_mapping(unsigned int domain_sel, unsigned int domain_indx)
+{
+	if (is_valid_single_domain(domain_sel) == false)
+		return NULL;
+
+	if (domain_indx >= get_domain_count(domain_sel))
+		return NULL;
+
+	struct core_domain_mapping *ptr =
+		(domain_sel & RTE_TOPO_DOMAIN_NUMA) ? topo_cnfg.numa[domain_indx] :
+		(domain_sel & RTE_TOPO_DOMAIN_L4) ? topo_cnfg.l4[domain_indx] :
+		(domain_sel & RTE_TOPO_DOMAIN_L3) ? topo_cnfg.l3[domain_indx] :
+		(domain_sel & RTE_TOPO_DOMAIN_L2) ? topo_cnfg.l2[domain_indx] :
+		(domain_sel & RTE_TOPO_DOMAIN_L1) ? topo_cnfg.l1[domain_indx] : NULL;
+
+	return ptr;
+}
+
+static unsigned int
+get_domain_lcore_count(unsigned int domain_sel)
+{
+	if (is_valid_single_domain(domain_sel) == false)
+		return 0;
+
+	return ((domain_sel & RTE_TOPO_DOMAIN_NUMA) ? topo_cnfg.numa_core_count :
+		(domain_sel & RTE_TOPO_DOMAIN_L4) ? topo_cnfg.l4_core_count :
+		(domain_sel & RTE_TOPO_DOMAIN_L3) ? topo_cnfg.l3_core_count :
+		(domain_sel & RTE_TOPO_DOMAIN_L2) ? topo_cnfg.l2_core_count :
+		(domain_sel & RTE_TOPO_DOMAIN_L1) ? topo_cnfg.l1_core_count : 0);
+}
+
+static unsigned int
+get_lcore_count_from_domain_index(unsigned int domain_sel, unsigned int domain_indx)
+{
+	if ((is_valid_single_domain(domain_sel) == false) ||
+		(domain_indx >= get_domain_count(domain_sel)))
+		return 0;
+
+	struct core_domain_mapping *ptr = get_domain_lcore_mapping(domain_sel, domain_indx);
+	if (ptr == NULL)
+		return 0;
+
+	return ptr->core_count;
+}
+
+static uint16_t
+get_lcore_from_domain_position(unsigned int domain_sel, unsigned int domain_indx, unsigned int pos)
+{
+	if (pos >= RTE_MAX_LCORE)
+		return RTE_MAX_LCORE;
+
+	struct core_domain_mapping *ptr = get_domain_lcore_mapping(domain_sel, domain_indx);
+	if (ptr == NULL)
+		return RTE_MAX_LCORE;
+
+	if (pos >= ptr->core_count)
+		return RTE_MAX_LCORE;
+
+	return ptr->cores[pos];
+}
+#endif
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_topo_get_domain_index_from_lcore, 26.07)
+int
+rte_topo_get_domain_index_from_lcore(unsigned int domain_sel, uint16_t lcore)
+{
+#ifdef RTE_LIBHWLOC_PROBE
+	if (!rte_lcore_is_enabled(lcore))
+		return -1;
+
+	if (is_valid_single_domain(domain_sel) == false)
+		return -2;
+
+	return ((domain_sel & RTE_TOPO_DOMAIN_NUMA) ? topo_cnfg.lcore_map[lcore].numa_domain :
+		(domain_sel & RTE_TOPO_DOMAIN_L4) ? topo_cnfg.lcore_map[lcore].l4_domain :
+		(domain_sel & RTE_TOPO_DOMAIN_L3) ? topo_cnfg.lcore_map[lcore].l3_domain :
+		(domain_sel & RTE_TOPO_DOMAIN_L2) ? topo_cnfg.lcore_map[lcore].l2_domain :
+		(domain_sel & RTE_TOPO_DOMAIN_L1) ? topo_cnfg.lcore_map[lcore].l1_domain : -3);
+#else
+	RTE_SET_USED(domain_sel);
+	RTE_SET_USED(lcore);
+	return -3;
+#endif
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_topo_get_domain_count, 26.07)
+unsigned int rte_topo_get_domain_count(unsigned int domain_sel)
+{
+#ifdef RTE_LIBHWLOC_PROBE
+	return get_domain_count(domain_sel);
+#else
+	RTE_SET_USED(domain_sel);
+#endif
+
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_topo_get_lcore_count_from_domain, 26.07)
+unsigned int
+rte_topo_get_lcore_count_from_domain(unsigned int domain_sel __rte_unused,
+unsigned int domain_indx __rte_unused)
+{
+#ifdef RTE_LIBHWLOC_PROBE
+	return get_lcore_count_from_domain_index(domain_sel, domain_indx);
+#else
+	RTE_SET_USED(domain_sel);
+	RTE_SET_USED(domain_indx);
+#endif
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_topo_get_nth_lcore_in_domain, 26.07)
+unsigned int
+rte_topo_get_nth_lcore_in_domain(unsigned int domain_sel __rte_unused,
+unsigned int domain_indx __rte_unused, unsigned int lcore_pos __rte_unused)
+{
+#ifdef RTE_LIBHWLOC_PROBE
+	return get_lcore_from_domain_position(domain_sel, domain_indx, lcore_pos);
+#else
+	RTE_SET_USED(domain_sel);
+	RTE_SET_USED(domain_indx);
+	RTE_SET_USED(lcore_pos);
+#endif
+	return RTE_MAX_LCORE;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_topo_get_lcore_cpuset_in_domain, 26.07)
+rte_cpuset_t
+rte_topo_get_lcore_cpuset_in_domain(unsigned int domain_sel __rte_unused,
+unsigned int domain_indx __rte_unused)
+{
+	rte_cpuset_t ret_cpu_set;
+	CPU_ZERO(&ret_cpu_set);
+
+#ifdef RTE_LIBHWLOC_PROBE
+	const struct core_domain_mapping *ptr = get_domain_lcore_mapping(domain_sel, domain_indx);
+
+	if ((ptr == NULL) || (ptr->core_count == 0))
+		return ret_cpu_set;
+
+	CPU_OR(&ret_cpu_set, &ret_cpu_set, &ptr->core_set);
+#else
+	RTE_SET_USED(domain_sel);
+	RTE_SET_USED(domain_indx);
+#endif
+
+	return ret_cpu_set;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_topo_is_main_lcore_in_domain, 26.07)
+bool
+rte_topo_is_main_lcore_in_domain(unsigned int domain_sel __rte_unused,
+unsigned int domain_indx __rte_unused)
+{
+#ifdef RTE_LIBHWLOC_PROBE
+	const unsigned int main_lcore = rte_get_main_lcore();
+	const struct core_domain_mapping *ptr = get_domain_lcore_mapping(domain_sel, domain_indx);
+
+	if ((ptr == NULL) || (ptr->core_count == 0))
+		return false;
+
+	return CPU_ISSET(main_lcore, &ptr->core_set);
+#else
+	RTE_SET_USED(domain_sel);
+	RTE_SET_USED(domain_indx);
+#endif
+
+	return false;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_topo_get_nth_lcore_from_domain, 26.07)
+unsigned int
+rte_topo_get_nth_lcore_from_domain(unsigned int domain_indx __rte_unused,
+unsigned int lcore_pos __rte_unused,
+int wrap __rte_unused, uint32_t flag __rte_unused)
+{
+#ifdef RTE_LIBHWLOC_PROBE
+	const unsigned int lcore_in_domain = get_domain_lcore_count(flag);
+	const unsigned int domain_count = get_domain_count(flag);
+
+	if ((domain_count == 0) || (lcore_in_domain <= 1))
+		return RTE_MAX_LCORE;
+
+	const bool find_first_lcore_in_first_domain =
+			((domain_indx == RTE_TOPO_DOMAIN_MAX) &&
+				(lcore_pos == RTE_TOPO_DOMAIN_LCORE_POS_MAX)) ? true : false;
+	const bool find_domain_from_lcore_pos =
+			((domain_indx == RTE_TOPO_DOMAIN_MAX) &&
+				(lcore_pos < RTE_TOPO_DOMAIN_LCORE_POS_MAX)) ? true : false;
+
+	struct core_domain_mapping *ptr = NULL;
+
+	/* if user has passed invalid lcore id, get the first valid lcore */
+	if (find_first_lcore_in_first_domain) {
+		for (unsigned int domain_index = 0; domain_index < domain_count; domain_index++) {
+			ptr = get_domain_lcore_mapping(flag, domain_index);
+			if ((ptr == NULL) || (ptr->core_count == 0))
+				continue;
+
+			/* get first lcore from valid domain based on the flag */
+			for (unsigned int i = 0; i < ptr->core_count; i++) {
+				uint16_t lcore = ptr->cores[i];
+
+				EAL_LOG(DEBUG, "Found lcore (%u) in domain (%d) at pos %u",
+					lcore, domain_index, i);
+				return lcore;
+			}
+		}
+
+		return RTE_MAX_LCORE;
+	}
+
+	/* if user has passed lcore pos, get lcore from matching domian */
+	if (find_domain_from_lcore_pos) {
+		for (unsigned int domain_index = 0; domain_index < domain_count; domain_index++) {
+			unsigned int pos_lcore = lcore_pos;
+			ptr = get_domain_lcore_mapping(flag, domain_index);
+			if ((ptr == NULL) || (ptr->core_count == 0))
+				continue;
+
+			if (wrap)
+				pos_lcore = (ptr->core_count > lcore_pos) ?
+					lcore_pos : lcore_pos %  ptr->core_count;
+
+			/* get first lcore from valid domain based on the flag */
+			for (unsigned int i = pos_lcore; i < ptr->core_count; i++) {
+				uint16_t lcore = ptr->cores[i];
+
+				EAL_LOG(DEBUG, "Found lcore (%u) in domain (%d) at pos %u",
+					lcore, domain_index, i);
+				return lcore;
+			}
+		}
+
+		return RTE_MAX_LCORE;
+	}
+
+	if (wrap)
+		domain_indx = domain_indx % domain_count;
+
+	/* get cores set in domain_indx */
+	ptr = get_domain_lcore_mapping(flag, domain_indx);
+	if ((ptr == NULL) || (ptr->core_count == 0))
+		return RTE_MAX_LCORE;
+
+	if (wrap)
+		lcore_pos = lcore_pos % ptr->core_count;
+
+	if (lcore_pos >= ptr->core_count)
+		return RTE_MAX_LCORE;
+
+	EAL_LOG(DEBUG, "lcore pos (%u) from domain (%u)", lcore_pos, domain_indx);
+
+	bool wrap_once = false;
+	unsigned int new_lcore_pos = lcore_pos;
+
+	while (1) {
+		if (new_lcore_pos >= ptr->core_count) {
+			if (!wrap)
+				return RTE_MAX_LCORE;
+
+			if ((wrap == true) && (wrap_once == true))
+				return RTE_MAX_LCORE;
+
+			new_lcore_pos = 0;
+			wrap_once = true;
+		}
+
+		/* check if the domain has cores_to_skip */
+		uint16_t new_lcore = ptr->cores[new_lcore_pos];
+
+		EAL_LOG(DEBUG, "Selected core (%u) at position %u", new_lcore, new_lcore_pos);
+		return new_lcore;
+	}
+
+#else
+	RTE_SET_USED(domain_indx);
+	RTE_SET_USED(lcore_pos);
+	RTE_SET_USED(wrap);
+	RTE_SET_USED(flag);
+#endif
+
+	return RTE_MAX_LCORE;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_topo_get_next_lcore, 26.07)
+unsigned int
+rte_topo_get_next_lcore(uint16_t lcore __rte_unused,
+bool skip_main __rte_unused, bool wrap __rte_unused, uint32_t flag __rte_unused)
+{
+#ifdef RTE_LIBHWLOC_PROBE
+	const uint16_t main_lcore = rte_get_main_lcore();
+	const unsigned int lcore_in_domain = get_domain_lcore_count(flag);
+	const unsigned int domain_count = get_domain_count(flag);
+
+	if ((domain_count == 0) || (lcore_in_domain <= 1))
+		return RTE_MAX_LCORE;
+
+	if (wrap)
+		lcore = lcore % RTE_MAX_LCORE;
+
+	if ((lcore >= RTE_MAX_LCORE) && (wrap == false))
+		return RTE_MAX_LCORE;
+
+	int lcore_domain = rte_topo_get_domain_index_from_lcore(flag, lcore);
+	if (lcore_domain < 0)
+		return RTE_MAX_LCORE;
+
+	struct core_domain_mapping *ptr = get_domain_lcore_mapping(flag, lcore_domain);
+	if ((ptr == NULL) || (ptr->core_count == 0))
+		return RTE_MAX_LCORE;
+
+	unsigned int lcore_pos = RTE_TOPO_DOMAIN_LCORE_POS_MAX;
+	for (unsigned int i = 0; i < ptr->core_count; i++) {
+		uint16_t find_lcore = ptr->cores[i];
+
+		if (lcore == find_lcore) {
+			lcore_pos = i;
+			break;
+		}
+	}
+
+	if (lcore_pos == RTE_TOPO_DOMAIN_LCORE_POS_MAX)
+		return RTE_MAX_LCORE;
+
+	EAL_LOG(DEBUG, "lcore pos (%u) from domain (%u)", lcore_pos, lcore_domain);
+
+	bool wrap_once = false;
+	unsigned int new_lcore_pos = lcore_pos + 1;
+
+	while (1) {
+		if (new_lcore_pos >= ptr->core_count) {
+			if (!wrap)
+				return RTE_MAX_LCORE;
+
+			if ((wrap == true) && (wrap_once == true))
+				return RTE_MAX_LCORE;
+
+			new_lcore_pos = 0;
+			wrap_once = true;
+		}
+
+		/* check if the domain has cores_to_skip */
+		uint16_t new_lcore = ptr->cores[new_lcore_pos];
+		bool main_in_domain = rte_topo_is_main_lcore_in_domain(flag, lcore_domain);
+
+		if (main_in_domain) {
+			if ((skip_main) && (new_lcore == main_lcore)) {
+				new_lcore_pos++;
+				continue;
+			}
+		}
+
+		EAL_LOG(DEBUG, "Selected core (%u) at position %u", new_lcore, new_lcore_pos);
+		return new_lcore;
+	}
+
+#else
+	RTE_SET_USED(skip_main);
+	RTE_SET_USED(wrap);
+	RTE_SET_USED(flag);
+#endif
+
+	return RTE_MAX_LCORE;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_topo_dump, 26.07)
+void
+rte_topo_dump(FILE *f)
+{
+#ifdef RTE_LIBHWLOC_PROBE
+	static const unsigned int domain_types[] = {
+		RTE_TOPO_DOMAIN_NUMA,
+		RTE_TOPO_DOMAIN_L4,
+		RTE_TOPO_DOMAIN_L3,
+		RTE_TOPO_DOMAIN_L2,
+		RTE_TOPO_DOMAIN_L1
+	};
+
+	fprintf(f, "| %15s | %15s | %15s | %15s |\n",
+		"Domain-Name", "Domains", "Domains-with-lcore", "Domain-total-lcore");
+	fprintf(f, "----------------------------------------------------------------------------------------------\n");
+	for (unsigned int d = 0; d < RTE_DIM(domain_types); d++) {
+		unsigned int domain = RTE_TOPO_DOMAIN_MAX;
+		unsigned int domain_valid_count = 0;
+		unsigned int domain_valid_lcore_count = 0;
+
+		RTE_TOPO_FOREACH_DOMAIN(domain, domain_types[d]) {
+			if (rte_topo_get_lcore_count_from_domain(domain_types[d], domain))
+				domain_valid_count += 1;
+			domain_valid_lcore_count +=
+				rte_topo_get_lcore_count_from_domain(domain_types[d], domain);
+		}
+
+		fprintf(f, "| %15s | %15u | %15u | %15u |\n",
+			(domain_types[d] == RTE_TOPO_DOMAIN_NUMA) ? "NUMA" :
+			(domain_types[d] == RTE_TOPO_DOMAIN_L4) ? "L4" :
+			(domain_types[d] == RTE_TOPO_DOMAIN_L3) ? "L3" :
+			(domain_types[d] == RTE_TOPO_DOMAIN_L2) ? "L2" :
+			(domain_types[d] == RTE_TOPO_DOMAIN_L1) ? "L1" : NULL,
+			rte_topo_get_domain_count(domain_types[d]),
+			domain_valid_count,
+			domain_valid_lcore_count);
+	}
+	fprintf(f, "----------------------------------------------------------------------------------------------\n\n");
+
+	fprintf(f, "| %15s | %15s | %15s |\n",
+		"Domain-Name", "Domain-Index", "lcores");
+	fprintf(f, "----------------------------------------------------------------------------------------------");
+	for (unsigned int d = 0; d < RTE_DIM(domain_types); d++) {
+		unsigned int domain = RTE_TOPO_DOMAIN_MAX;
+
+		RTE_TOPO_FOREACH_DOMAIN(domain, domain_types[d]) {
+			if (rte_topo_get_lcore_count_from_domain(domain_types[d], domain) == 0)
+				continue;
+
+			fprintf(f, "\n| %15s | %15u | ",
+				(domain_types[d] == RTE_TOPO_DOMAIN_NUMA) ? "NUMA" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L4) ? "L4" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L3) ? "L3" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L2) ? "L2" :
+				(domain_types[d] == RTE_TOPO_DOMAIN_L1) ? "L1" : NULL,
+				domain);
+
+			uint16_t lcore = RTE_MAX_LCORE;
+			unsigned int pos = 0;
+			RTE_TOPO_FOREACH_LCORE_IN_DOMAIN(lcore, domain, pos, domain_types[d])
+				fprintf(f, " %u ", lcore);
+		}
+	}
+	fprintf(f, "\n----------------------------------------------------------------------------------------------\n\n");
+
+	fprintf(f, "| %10s |  %10s | %10s | %10s | %10s | %10s | %10s |\n",
+		"lcore", "cpu", "NUMA-Index", "L4-Index", "L3-Index", "L2-Index", "L1-Index");
+	fprintf(f, "------------------------------------------------------------------------------\n");
+	for (unsigned int i = 0; i < RTE_MAX_LCORE; i++) {
+		if (rte_lcore_is_enabled(i) == false)
+			continue;
+
+		fprintf(f, "| %10u |  %10u | %10u | %10u | %10u | %10u | %10u |\n",
+			i,
+			topo_cnfg.lcore_map[i].cpu,
+			topo_cnfg.lcore_map[i].numa_domain,
+			topo_cnfg.lcore_map[i].l4_domain,
+			topo_cnfg.lcore_map[i].l3_domain,
+			topo_cnfg.lcore_map[i].l2_domain,
+			topo_cnfg.lcore_map[i].l1_domain);
+	}
+	fprintf(f, "------------------------------------------------------------------------------\n\n");
+
+	fprintf(f, "| %10s |  %10s | %10s | %10s | %10s | %10s | %10s |\n",
+		"lcore", "cpu", "NUMA-cacheid", "L4-cacheid", "L3-cacheid", "L2-cacheid", "L1-cacheid");
+	fprintf(f, "------------------------------------------------------------------------------\n");
+	for (unsigned int i = 0; i < RTE_MAX_LCORE; i++) {
+		if (rte_lcore_is_enabled(i) == false)
+			continue;
+
+		fprintf(f, "| %10u |  %10u | %10u | %10u | %10u | %10u | %10u |\n",
+			i,
+			topo_cnfg.lcore_map[i].cpu,
+			topo_cnfg.lcore_map[i].numa_cacheid,
+			topo_cnfg.lcore_map[i].l4_cacheid,
+			topo_cnfg.lcore_map[i].l3_cacheid,
+			topo_cnfg.lcore_map[i].l2_cacheid,
+			topo_cnfg.lcore_map[i].l1_cacheid);
+	}
+	fprintf(f, "------------------------------------------------------------------------------\n\n");
+
+#else
+	RTE_SET_USED(f);
+#endif
+}
+
+#ifdef RTE_LIBHWLOC_PROBE
+static int
+lcore_to_core(unsigned int lcore)
+{
+	rte_cpuset_t cpu;
+	CPU_ZERO(&cpu);
+
+	cpu = rte_lcore_cpuset(lcore);
+
+	for (int i = 0; i < RTE_TOPO_MAX_CPU_CORES; i++) {
+		if (CPU_ISSET(i, &cpu))
+			return i;
+	}
+
+	return -1;
+}
+
+static int
+eal_topology_map_layer(hwloc_topology_t topology, int depth,
+uint16_t *layer_cnt, struct core_domain_mapping ***layer_ptr,
+uint16_t *total_core_cnt, const char *layer_name)
+{
+	if (depth == HWLOC_TYPE_DEPTH_UNKNOWN || *layer_cnt == 0)
+		return 0;
+
+	*layer_ptr = rte_malloc(NULL, sizeof(struct core_domain_mapping *) * (*layer_cnt), 0);
+	if (*layer_ptr == NULL)
+		return -1;
+
+	/* create lcore-domain-mapping */
+	for (uint16_t j = 0; j < *layer_cnt; j++) {
+		hwloc_obj_t obj = hwloc_get_obj_by_depth(topology, depth, j);
+		int cpu_count = hwloc_bitmap_weight(obj->cpuset);
+		if (cpu_count == -1)
+			continue;
+
+		struct core_domain_mapping *dm =
+			rte_zmalloc(NULL, sizeof(struct core_domain_mapping), 0);
+		if (!dm)
+			return -1;
+
+		(*layer_ptr)[j] = dm;
+		CPU_ZERO(&dm->core_set);
+		dm->core_count = 0;
+
+		dm->cores = rte_malloc(NULL, sizeof(uint16_t) * cpu_count, 0);
+		if (!dm->cores)
+			return -1;
+	}
+
+	/* populate lcore-mapping */
+	for (uint16_t j = 0; j < *layer_cnt; j++) {
+		hwloc_obj_t obj = hwloc_get_obj_by_depth(topology, depth, j);
+		if (!obj || hwloc_bitmap_iszero(obj->cpuset))
+			continue;
+
+		int cpu_id = -1;
+		while ((cpu_id = hwloc_bitmap_next(obj->cpuset, cpu_id)) != -1) {
+			if (!rte_lcore_is_enabled(cpu_id))
+				continue;
+
+			EAL_LOG(DEBUG, " %s domain (%u) lcore %u, logical %u, os %u",
+				layer_name, j, cpu_id, obj->logical_index, obj->os_index);
+
+			int cpu_core = lcore_to_core(cpu_id);
+			if (cpu_core == -1)
+				return -1;
+
+			topo_cnfg.lcore_map[cpu_id].cpu = (uint16_t) cpu_core;
+
+			for (uint16_t k = 0; k < *layer_cnt; k++) {
+				hwloc_obj_t obj_core =
+					hwloc_get_obj_by_depth(topology, depth, k);
+				int cpu_count_core =
+					hwloc_bitmap_weight(obj_core->cpuset);
+				if (cpu_count_core == -1)
+					continue;
+
+				if (hwloc_bitmap_isset(obj_core->cpuset,
+					topo_cnfg.lcore_map[cpu_id]. cpu)) {
+					if (strncmp(layer_name, "NUMA", 4) == 0) {
+						topo_cnfg.lcore_map[cpu_id].numa_domain = k;
+						topo_cnfg.lcore_map[cpu_id].numa_cacheid =
+							obj_core->logical_index;
+					} else if (strncmp(layer_name, "L4", 2) == 0) {
+						topo_cnfg.lcore_map[cpu_id].l4_domain = k;
+						topo_cnfg.lcore_map[cpu_id].l4_cacheid =
+							obj_core->logical_index;
+					} else if (strncmp(layer_name, "L3", 2) == 0) {
+						topo_cnfg.lcore_map[cpu_id].l3_domain = k;
+						topo_cnfg.lcore_map[cpu_id].l3_cacheid =
+							obj_core->logical_index;
+					} else if (strncmp(layer_name, "L2", 2) == 0) {
+						topo_cnfg.lcore_map[cpu_id].l2_domain = k;
+						topo_cnfg.lcore_map[cpu_id].l2_cacheid =
+							obj_core->logical_index;
+					} else if (strncmp(layer_name, "L1", 2) == 0) {
+						topo_cnfg.lcore_map[cpu_id].l1_domain = k;
+						topo_cnfg.lcore_map[cpu_id].l1_cacheid =
+							obj_core->logical_index;
+					}
+
+					/* populate lcore-domain-mapping */
+					struct core_domain_mapping *dm = (*layer_ptr)[k];
+					if (dm == NULL)
+						return -2;
+
+					dm->cores[dm->core_count++] = (uint16_t)cpu_id;
+					CPU_SET(cpu_id, &dm->core_set);
+
+					(*total_core_cnt)++;
+					break;
+				}
+			}
+		}
+	}
+
+	return 0;
+}
+#endif
+
+/*
+ * Use HWLOC library to parse L1|L2|L3|NUMA-IO on the running target machine.
+ * Store the topology structure in memory.
+ */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eal_topology_init)
+int rte_eal_topology_init(void)
+{
+#ifdef RTE_LIBHWLOC_PROBE
+	memset(&topo_cnfg, 0, sizeof(struct topology_config));
+
+	if (hwloc_topology_init(&topo_cnfg.topology) < 0)
+		return -1;
+
+	if (hwloc_topology_load(topo_cnfg.topology) < 0) {
+		hwloc_topology_destroy(topo_cnfg.topology);
+		return -2;
+	}
+
+	struct {
+		int depth;
+		uint16_t *count;
+		struct core_domain_mapping ***ptr;
+		uint16_t *total_cores;
+		const char *name;
+	} layers[] = {
+		{ hwloc_get_type_depth(topo_cnfg.topology, HWLOC_OBJ_L1CACHE),
+			&topo_cnfg.l1_count, &topo_cnfg.l1, &topo_cnfg.l1_core_count, "L1" },
+		{ hwloc_get_type_depth(topo_cnfg.topology, HWLOC_OBJ_L2CACHE),
+			&topo_cnfg.l2_count, &topo_cnfg.l2, &topo_cnfg.l2_core_count, "L2" },
+		{ hwloc_get_type_depth(topo_cnfg.topology, HWLOC_OBJ_L3CACHE),
+			&topo_cnfg.l3_count, &topo_cnfg.l3, &topo_cnfg.l3_core_count, "L3" },
+		{ hwloc_get_type_depth(topo_cnfg.topology, HWLOC_OBJ_L4CACHE),
+			&topo_cnfg.l4_count, &topo_cnfg.l4, &topo_cnfg.l4_core_count, "L4" },
+		{ hwloc_get_type_depth(topo_cnfg.topology, HWLOC_OBJ_NUMANODE),
+			&topo_cnfg.numa_count, &topo_cnfg.numa, &topo_cnfg.numa_core_count, "NUMA" }
+	};
+
+	for (int i = 0; i < 5; i++) {
+		*layers[i].count = hwloc_get_nbobjs_by_depth(topo_cnfg.topology, layers[i].depth);
+		if (eal_topology_map_layer(topo_cnfg.topology, layers[i].depth, layers[i].count,
+			layers[i].ptr, layers[i].total_cores, layers[i].name) < 0) {
+			rte_eal_topology_release();
+			return -1;
+		}
+	}
+
+	hwloc_topology_destroy(topo_cnfg.topology);
+	topo_cnfg.topology = NULL;
+#endif
+
+	return 0;
+}
+
+
+#ifdef RTE_LIBHWLOC_PROBE
+struct domain_store {
+	struct core_domain_mapping **map;
+	uint16_t count;
+	uint16_t core_count;
+	const char *name;
+};
+
+static void
+release_domain(struct domain_store *d)
+{
+	if (!d->map) {
+		d->count = 0;
+		d->core_count = 0;
+		return;
+	}
+
+	for (int i = 0; i < d->count; i++) {
+		if (!d->map[i])
+			continue;
+		rte_free(d->map[i]->cores);
+		d->map[i]->cores = NULL;
+		rte_free(d->map[i]);
+		d->map[i] = NULL;
+	}
+
+	rte_free(d->map);
+	d->map = NULL;
+}
+#endif
+
+/*
+ * release HWLOC topology structure memory
+ */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eal_topology_release)
+int
+rte_eal_topology_release(void)
+{
+#ifdef RTE_LIBHWLOC_PROBE
+
+	struct domain_store domains[] = {
+		{ topo_cnfg.l1,   topo_cnfg.l1_count,   topo_cnfg.l1_core_count,   "L1"   },
+		{ topo_cnfg.l2,   topo_cnfg.l2_count,   topo_cnfg.l2_core_count,   "L2"   },
+		{ topo_cnfg.l3,   topo_cnfg.l3_count,   topo_cnfg.l3_core_count,   "L3"   },
+		{ topo_cnfg.l4,   topo_cnfg.l4_count,   topo_cnfg.l4_core_count,   "L4"   },
+		{ topo_cnfg.numa, topo_cnfg.numa_count,  topo_cnfg.numa_core_count, "NUMA" },
+	};
+
+	for (unsigned int d = 0; d < RTE_DIM(domains); d++) {
+		EAL_LOG(DEBUG, "release %s domain memory", domains[d].name);
+		release_domain(&domains[d]);
+	}
+#endif
+
+	return 0;
+}
diff --git a/lib/eal/common/meson.build b/lib/eal/common/meson.build
index e273745e93..834ed2130b 100644
--- a/lib/eal/common/meson.build
+++ b/lib/eal/common/meson.build
@@ -50,6 +50,7 @@ if not is_windows
             'eal_common_trace.c',
             'eal_common_trace_ctf.c',
             'eal_common_trace_utils.c',
+            'eal_topology.c',
             'hotplug_mp.c',
             'malloc_mp.c',
             'rte_keepalive.c',
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 60f5e676a8..0d016a379f 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -42,6 +42,8 @@
 #include <rte_devargs.h>
 #include <rte_version.h>
 #include <rte_vfio.h>
+#include <rte_topology.h>
+
 #include <malloc_heap.h>
 #include <telemetry_internal.h>
 
@@ -77,7 +79,6 @@ struct lcore_config lcore_config[RTE_MAX_LCORE];
 RTE_EXPORT_SYMBOL(rte_cycles_vmware_tsc_map)
 int rte_cycles_vmware_tsc_map;
 
-
 int
 eal_clean_runtime_dir(void)
 {
@@ -754,6 +755,12 @@ rte_eal_init(int argc, char **argv)
 			goto err_out;
 	}
 
+	ret = rte_eal_topology_init();
+	if (ret) {
+		rte_eal_init_alert("Cannot invoke topology, skipping topology!!!");
+		rte_errno = ENOTSUP;
+	}
+
 	eal_mcfg_complete();
 
 	return fctret;
@@ -781,6 +788,7 @@ rte_eal_cleanup(void)
 		eal_get_internal_configuration();
 	rte_service_finalize();
 	eal_bus_cleanup();
+	rte_eal_topology_release();
 	rte_mp_channel_cleanup();
 	rte_eal_alarm_cleanup();
 	rte_trace_save();
diff --git a/lib/eal/include/meson.build b/lib/eal/include/meson.build
index aef5824e5f..16857f76bf 100644
--- a/lib/eal/include/meson.build
+++ b/lib/eal/include/meson.build
@@ -50,6 +50,7 @@ headers += files(
         'rte_thread.h',
         'rte_ticketlock.h',
         'rte_time.h',
+        'rte_topology.h',
         'rte_trace.h',
         'rte_trace_point.h',
         'rte_trace_point_register.h',
diff --git a/lib/eal/include/rte_topology.h b/lib/eal/include/rte_topology.h
new file mode 100644
index 0000000000..1ecee6b031
--- /dev/null
+++ b/lib/eal/include/rte_topology.h
@@ -0,0 +1,255 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2010-2014 Intel Corporation
+ */
+
+#ifndef _RTE_TOPO_TOPO_H_
+#define _RTE_TOPO_TOPO_H_
+
+/**
+ * @file
+ *
+ * API for lcore and socket manipulation
+ */
+#include <rte_lcore.h>
+#include <rte_bitops.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * The lcore grouping with in the L1 Domain.
+ */
+#define RTE_TOPO_DOMAIN_L1  RTE_BIT32(0)
+/**
+ * The lcore grouping with in the L2 Domain.
+ */
+#define RTE_TOPO_DOMAIN_L2  RTE_BIT32(1)
+/**
+ * The lcore grouping with in the L3 Domain.
+ */
+#define RTE_TOPO_DOMAIN_L3  RTE_BIT32(2)
+/**
+ * The lcore grouping with in the L4 Domain.
+ */
+#define RTE_TOPO_DOMAIN_L4  RTE_BIT32(3)
+/**
+ * The lcore grouping with in the IO Domain.
+ */
+#define RTE_TOPO_DOMAIN_NUMA  RTE_BIT32(4)
+/**
+ * The lcore grouping with in the SMT Domain (Like L1 Domain).
+ */
+#define RTE_TOPO_DOMAIN_SMT RTE_TOPO_DOMAIN_L1
+/**
+ * The lcore grouping based on Domains (L1|L2|L3|L4|NUMA).
+ */
+#define RTE_TOPO_DOMAIN_ALL (RTE_TOPO_DOMAIN_L1 |	\
+				RTE_TOPO_DOMAIN_L2 |	\
+				RTE_TOPO_DOMAIN_L3 |	\
+				RTE_TOPO_DOMAIN_L4 |	\
+				RTE_TOPO_DOMAIN_NUMA)
+/**
+ * The mask for all bits set for domain
+ */
+#define RTE_TOPO_DOMAIN_MAX RTE_GENMASK32(31, 0)
+#define RTE_TOPO_DOMAIN_LCORE_POS_MAX RTE_GENMASK32(31, 0)
+
+
+/**
+ * Get count for selected domain.
+ *
+ * @param domain_sel
+ *   Domain selection, RTE_TOPO_DOMAIN_[L1|L2|L3|L4|NUMA].
+ * @return
+ *   Number of domains, or 0 if:
+ *   - hwloc not available
+ *   - Invalid domain selector
+ *   - Domain type doesn't exist on system
+ *
+ * @note valid for EAL args of lcore and coremask.
+ *
+ */
+__rte_experimental
+unsigned int rte_topo_get_domain_count(unsigned int domain_sel);
+
+/**
+ * Get count for lcores in a domain.
+ *
+ * @param domain_sel
+ *   Domain selection, RTE_TOPO_DOMAIN_[L1|L2|L3|L4|NUMA].
+ * @param domain_indx
+ *   Domain Index, valid range from 0 to (rte_topo_get_domain_count - 1).
+ * @return
+ *   total count for lcore in a selected index of a domain.
+ *
+ * @note valid for EAL args of lcore and coremask.
+ *
+ */
+__rte_experimental
+unsigned int
+rte_topo_get_lcore_count_from_domain(unsigned int domain_sel, unsigned int domain_indx);
+
+/**
+ * Get domain index using lcore & domain.
+ *
+ * @param domain_sel
+ *   Domain selection, RTE_TOPO_DOMAIN_[L1|L2|L3|L4|NUMA].
+ * @param lcore
+ *   valid lcore within valid selected domain.
+ * @return
+ *   < 0, invalid domain index
+ *   >= 0, valid domain index
+ *
+ * @note valid for EAL args of lcore and coremask.
+ *
+ */
+__rte_experimental
+int
+rte_topo_get_domain_index_from_lcore(unsigned int domain_sel, uint16_t lcore);
+
+/**
+ * Get n'th lcore from a selected domain.
+ *
+ * @param domain_sel
+ *   Domain selection, RTE_TOPO_DOMAIN_[L1|L2|L3|L4|NUMA].
+ * @param domain_indx
+ *   Domain Index, valid range from 0 to (rte_topo_get_domain_count - 1).
+ * @param lcore_pos
+ *   lcore position, valid range from 0 to (dpdk_enabled_lcores in the domain -1)
+ * @return
+ *   lcore from the list for the selected domain.
+ *
+ * @note valid for EAL args of lcore and coremask.
+ *
+ */
+__rte_experimental
+unsigned int
+rte_topo_get_nth_lcore_in_domain(unsigned int domain_sel,
+unsigned int domain_indx, unsigned int lcore_pos);
+
+#ifdef RTE_HAS_CPUSET
+/**
+ * Return cpuset for all lcores in selected domain.
+ *
+ * @param domain_sel
+ *   Domain selection, RTE_TOPO_DOMAIN_[L1|L2|L3|L4|NUMA].
+ * @param domain_indx
+ *   Domain Index, valid range from 0 to (rte_topo_get_domain_count - 1).
+ * @return
+ *   cpuset for all lcores from the selected domain.
+ *
+ * @note valid for EAL args of lcore and coremask.
+ *
+ */
+__rte_experimental
+rte_cpuset_t
+rte_topo_get_lcore_cpuset_in_domain(unsigned int domain_sel, unsigned int domain_indx);
+#endif
+
+/**
+ * Return TRUE|FALSE if main lcore in available in selected domain.
+ *
+ * @param domain_sel
+ *   Domain selection, RTE_TOPO_DOMAIN_[L1|L2|L3|L4|NUMA].
+ * @param domain_indx
+ *   Domain Index, valid range from 0 to (rte_topo_get_domain_count - 1).
+ * @return
+ *   Check if main lcore is avaialable in the selected domain.
+ *
+ * @note valid for EAL args of lcore and coremask.
+ *
+ */
+__rte_experimental
+bool
+rte_topo_is_main_lcore_in_domain(unsigned int domain_sel, unsigned int domain_indx);
+
+/**
+ * Get the enabled lcores from next domain based on extended flag.
+ *
+ * @param lcore
+ *   The current lcore (reference).
+ * @param skip_main
+ *   If true, do not return the ID of the main lcore.
+ * @param wrap
+ *   If true, go back to first core of flag based domain when last core is reached.
+ *   If false, return RTE_MAX_LCORE when no more cores are available.
+ * @param flag
+ *   Allows user to select various domain as specified under RTE_TOPO_DOMAIN_[L1|L2|L3|L4|NUMA]
+ *
+ * @return
+ *   The next lcore_id or RTE_MAX_LCORE if not found.
+ *
+ * @note valid for EAL args of lcore and coremask.
+ *
+ */
+__rte_experimental
+unsigned int
+rte_topo_get_next_lcore(uint16_t lcore,
+bool skip_main, bool wrap, uint32_t flag);
+
+/**
+ * Get the Nth (first|last) lcores from next domain based on extended flag.
+ *
+ * @param domain_indx
+ *   Domain Index, valid range from 0 to (rte_topo_get_domain_count - 1).
+ * @param lcore_pos
+ *   lcore position, valid range from 0 to (dpdk_enabled_lcores in the domain -1)
+ * @param wrap
+ *   If true, go back to first core of flag based domain when last core is reached.
+ *   If false, return RTE_MAX_LCORE when no more cores are available.
+ * @param flag
+ *   Allows user to select various domain as specified under RTE_TOPO_DOMAIN_(L1|L2|L3|L4|NUMA)
+ *
+ * @return
+ *   The next lcore_id or RTE_MAX_LCORE if not found.
+ *
+ * @note valid for EAL args of lcore and coremask.
+ *
+ */
+__rte_experimental
+unsigned int
+rte_topo_get_nth_lcore_from_domain(unsigned int domain_indx, unsigned int lcore_pos,
+int wrap, uint32_t flag);
+
+/**
+ * Dump an internal topo_config to a file.
+ *
+ * Dump all fields for struct topology_config fields,
+ *
+ * @param f
+ *   A pointer to a file for output
+ */
+__rte_experimental
+void
+rte_topo_dump(FILE *f);
+
+#define RTE_TOPO_FOREACH_DOMAIN(domain_index, flag)	\
+	const unsigned int domain_count = rte_topo_get_domain_count(flag);	\
+	for (domain_index = 0; domain_index < domain_count; domain_index++)
+
+#define RTE_TOPO_FOREACH_WORKER_DOMAIN(domain_index, flag)	\
+	const unsigned int domain_count = rte_topo_get_domain_count(flag);	\
+	for (domain_index += (rte_topo_is_main_lcore_in_domain(domain_index, flag)) ? 1 : 0;	\
+		domain_index < domain_count;	\
+		domain_index += (rte_topo_is_main_lcore_in_domain(domain_index + 1, flag)) ? 2 : 1)
+
+#define RTE_TOPO_FOREACH_LCORE_IN_DOMAIN(lcore, domain_indx, lcore_pos, flag)	\
+	for (lcore = rte_topo_get_nth_lcore_from_domain(domain_indx, lcore_pos, 0, flag);	\
+		lcore < RTE_MAX_LCORE;	\
+		lcore = rte_topo_get_nth_lcore_from_domain(domain_indx, ++lcore_pos, 0, flag))
+
+#define RTE_TOPO_FOREACH_WORKER_LCORE_IN_DOMAIN(lcore, domain_indx, flag)	\
+	lcore = rte_topo_get_nth_lcore_from_domain(domain, 0, 0, flag);	\
+	uint16_t main_lcore = rte_get_main_lcore();	\
+	for (lcore = (lcore != main_lcore) ? \
+		lcore : rte_topo_get_next_lcore(lcore, 1, 0, flag);	\
+		lcore < RTE_MAX_LCORE;	\
+		lcore = rte_topo_get_next_lcore(lcore, 1, 0, flag))
+
+#ifdef __cplusplus
+}
+#endif
+
+
+#endif /* _RTE_TOPO_TOPO_H_ */
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index d848de03d8..f6a49badf2 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -42,6 +42,7 @@
 #include <rte_version.h>
 #include <malloc_heap.h>
 #include <rte_vfio.h>
+#include <rte_topology.h>
 
 #include <telemetry_internal.h>
 #include <eal_export.h>
@@ -927,6 +928,11 @@ rte_eal_init(int argc, char **argv)
 			goto err_out;
 	}
 
+	if (rte_eal_topology_init()) {
+		rte_eal_init_alert("Cannot invoke topology, skipping topologly!!!");
+		rte_errno = ENOTSUP;
+	}
+
 	eal_mcfg_complete();
 
 	return fctret;
@@ -981,6 +987,7 @@ rte_eal_cleanup(void)
 	rte_service_finalize();
 	eal_bus_cleanup();
 	vfio_mp_sync_cleanup();
+	rte_eal_topology_release();
 	rte_mp_channel_cleanup();
 	rte_eal_alarm_cleanup();
 	rte_trace_save();
diff --git a/lib/eal/meson.build b/lib/eal/meson.build
index f9fcee24ee..f6cd81ed8e 100644
--- a/lib/eal/meson.build
+++ b/lib/eal/meson.build
@@ -31,3 +31,7 @@ endif
 if is_freebsd
     annotate_locks = false
 endif
+
+if dpdk_conf.has('RTE_LIBHWLOC_PROBE')
+    ext_deps += hwloc_dep
+endif
-- 
2.43.0

