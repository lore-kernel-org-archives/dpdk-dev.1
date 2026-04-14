Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C882BF9D0F3
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 19:41:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 261E540649;
	Tue, 14 Apr 2026 21:41:39 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011034.outbound.protection.outlook.com
 [40.93.194.34]) by mails.dpdk.org (Postfix) with ESMTP id 323B24028F
 for <dev@dpdk.org>; Tue, 14 Apr 2026 21:41:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVCc4elz7JSAoLL6y50kMErK3omF9uBmYhFEmGAcOSYKQiFV8B7YsxrYQhS3AhJGs00Ip7hnCY7kK7MOdBrZRx3I8LfKCCY82h/hxUTBDxn6iDe+4qcQDR1kTacgIDtQ9wAv9xw+Wq2EucrL7RVnJlFqKRRN2Qzgs7G41qb6NftVwxkBvGATMNH9Yn0alNZZHXNqJMpmwc+Yl+d6rfZMeEheyrG2lw7rZnnlG+KhpaCFGajO9OQO1kNm2vlbz6sSwqRKwCSC4JpKckwxu0sY2zboFNojxUtpESj1CZa+zj/n0Egh5G2+pDsiAzlxYgh//8ITMARDqeqLpK74LcZOZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVKODLKmKrdKGwfQuwgVvSA6R8mcpOVadcvebfKfc9o=;
 b=x/rdioyPoCTR5VPlH+Uw4TeDlvkzNcVKPyxZxxOnTwgWcELiref7ez0ODcv54G1j66KRavxQss+E60s0kwCq69honKLJJqoSbLo2sGwL366r/l5SPGPxrd/wDwN1E1NSuGXlZ9rjoKyn1N0VmI5w80Zr0Ad5BYAdl3uXWMr3UITL41JCAXReA2RYpjX5upJLv6fehldAb4iJU7KN8Ek3h8dfRaxPpIIQuV+pImBXe7SpejGhPOhlWH4prwWARjvlTNbEGHOTP+s06JK5oTGKOAI9oTlcMGE3QgA2LMFKNGxVTQahowTyjRTF+WKJOfJvAUtTdRkx0kVJjpOVd2xJHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVKODLKmKrdKGwfQuwgVvSA6R8mcpOVadcvebfKfc9o=;
 b=Nwcb74SUZ0OwGOAzGUskMbY0+BPEHRmakMhQsQAW6MsZt4Wdw8kRsLvYBK9vxiqiPwc79vfJ2Xyx90msgf2xw/1goWxOCcZezRTbDILK7UKnMj6IbdIUTQr/iEijxsmMNV/wnMErTX8H7PqkiggWqiAOVjcQtTihmWwPEpktNz8=
Received: from PH8P221CA0055.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::8)
 by MN2PR12MB4359.namprd12.prod.outlook.com (2603:10b6:208:265::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 19:41:33 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:510:349:cafe::39) by PH8P221CA0055.outlook.office365.com
 (2603:10b6:510:349::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Tue,
 14 Apr 2026 19:41:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 19:41:32 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 14:41:32 -0500
Received: from BLRVIVARGHE.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 12:41:30 -0700
From: Vipin Varghese <vipin.varghese@amd.com>
To: <dev@dpdk.org>, <sivaprasad.tummala@amd.com>
CC: <konstantin.ananyev@huawei.com>, <wathsala.vithanage@arm.com>,
 <bruce.richardson@intel.com>, <viktorin@cesnet.cz>,
 <mb@smartsharesystems.com>
Subject: [PATCH v5 v5 3/3] doc: add new section topology
Date: Wed, 15 Apr 2026 01:08:21 +0530
Message-ID: <20260414193850.1696-4-vipin.varghese@amd.com>
X-Mailer: git-send-email 2.47.0.windows.1
In-Reply-To: <20260414193850.1696-1-vipin.varghese@amd.com>
References: <20241105102849.1947-1-vipin.varghese@amd.com>
 <20260414193850.1696-1-vipin.varghese@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|MN2PR12MB4359:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b39a3f-057c-4cd3-19aa-08de9a5dd502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fbOoBK1Cxa26rl1HL5D7b91mlqUERR1uZdp0WwbXYTLfrnuMWH0Gl5quhYktjlOtPhkpTH8f2AH4zdeWsIljnF1DohzLaBlKvEdDRBWc+/JBz/O3py61f1b8EgJF0ElAhqdciR/Uuo/976POZdEm/GM+jIOcWPWmaO1QL9vx5f0IqenyZEfqpI+2l1YUbCY7tLdzdRCn/srpVspQHP7HXGL7FblQxNiqj3p187u9YiOMfe5/ECosr1SDIi59EONgpOcTG0ZIjWdVO3weDaSYPtvaq6zIC5PMAv0Z85fOOk0mAoCuVzLDOZCEwgmioQB62+7c4kKRVSEIlP9J8xtBQ/ZpFP/a8aOl5jCeHhmfN+DAJZkpEHUedoxIJzJdsDoW/h5VdrjNIfy87NXGxQEGm2DhCPQd6ZYEELGkaaMLZqaBgSEFpaRUhULECVl4EYr0HdVfbWGrnBy+SE2LKtHYStYSmHg5HkwIUFRlxtoPQXJ7abd+Oj3OetJDdrwlVWfe5Xw4H1gIL7gC5xHUrU8SseGEuuOzc785HJYScqUpdSx4tS0gsXAFy8ygw+ARXewP6UlF3Y6e0pn3EeAcVi7Ef6uuPGTaP8jJK83zP9QwOLyswgHNsjVs9lQICidNbGKX8asfMvHy+0lpWRnos5MCEBQt3OrCfv1+HmIBKvFi7T3LrGe9I+ve8B1YoastekrzTsKJhn9PiJvgVV1na52UrntiwxvCsc+RVF0auzBssaqj79eRzU8l3MShPAgX2+pLnjSn4IxClULnIWL3DbVuwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2j2jnojpWbF+ynuAQ1fOCQ0hZ9PlPYl22MsP4UmtNL4a8b8oCcBMP6g5QhGCYZFsKaP745j0b7ne3kyplGu3ITe3sHRwySVcA3j/Cq6SBoWy4UXoQwSPVOvvpJeBOlYPW96LBbUZ9Whf6h61aYi/yGFr9GeLclCrb7cGpZ0ORGP/wEJyAaZJVSfEh5UVnDHWCP89Rrfcv6ATGh1jYls5YbQJzt3KWBMNGYm2x0kC5wuKjwD6ewKDRcDNagcEoWu6CKPCkc2SVO5Pcoti2sl5C/FjuUrW4/9zj4p+4QbngYAxj8eTdFl0fboEXyL8NQYmxcdi9ImZui7mlkZB80i9duiUmbJ8Jd++k/ebjAN9LhRo6WbfH0uA15fM+KSJPcp5Q2DmIWAtqCmalaGwvbB9LIJzvZ36K33esuzGj+Gj9+4yME7WffWBOFni36UBnzpx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 19:41:32.8639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b39a3f-057c-4cd3-19aa-08de9a5dd502
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359
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
 - add new section under utility
 - include rte_topo API and usuage

Signed-off-by: Vipin Varghese <vipin.varghese@amd.com>
---
 doc/api/doxy-api-index.md              |   1 +
 doc/guides/prog_guide/index.rst        |   3 +-
 doc/guides/prog_guide/topology_lib.rst | 155 +++++++++++++++++++++++++
 3 files changed, 158 insertions(+), 1 deletion(-)
 create mode 100644 doc/guides/prog_guide/topology_lib.rst

diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
index 9296042119..e8655fb956 100644
--- a/doc/api/doxy-api-index.md
+++ b/doc/api/doxy-api-index.md
@@ -102,6 +102,7 @@ The public API headers are grouped by topics:
   [interrupts](@ref rte_interrupts.h),
   [launch](@ref rte_launch.h),
   [lcore](@ref rte_lcore.h),
+  [topology](@ref rte_topology.h),
   [service cores](@ref rte_service.h),
   [keepalive](@ref rte_keepalive.h),
   [power/freq](@ref rte_power_cpufreq.h),
diff --git a/doc/guides/prog_guide/index.rst b/doc/guides/prog_guide/index.rst
index e6f24945b0..8e1153acef 100644
--- a/doc/guides/prog_guide/index.rst
+++ b/doc/guides/prog_guide/index.rst
@@ -133,9 +133,10 @@ Utility Libraries
     pcapng_lib
     bpf_lib
     trace_lib
+    topology_lib
 
 
-Howto Guides
+How to Guides
 -------------
 
 .. toctree::
diff --git a/doc/guides/prog_guide/topology_lib.rst b/doc/guides/prog_guide/topology_lib.rst
new file mode 100644
index 0000000000..42af7e5793
--- /dev/null
+++ b/doc/guides/prog_guide/topology_lib.rst
@@ -0,0 +1,155 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2026 AMD Inc.
+
+Topology Library
+================
+
+Overview
+--------
+
+The Topology library provides NUMA‑aware grouping of DPDK logical cores
+based on CPU-CACHE and I/O topology.
+
+It exposes APIs that allow applications to query topology domains and
+enumerate logical cores within those domains. This enables topology‑aware
+core selection for improved locality and performance.
+
+The library integrates with the ``hwloc`` library to obtain hardware
+topology information while maintaining ABI stability.
+
+Motivation
+----------
+
+Application performance can be improved when:
+
+- DPDK libraries and PMDs operate within the same topology domain
+- Cache sharing is maximized in pipeline and graph applications
+- Cache identifiers (L2/L3) are used for:
+  - Data placement
+  - Platform QoS (PQoS) configuration
+
+This library provides a consistent topology view, including support for
+EAL lcore reordering via the ``-R`` option.
+
+Functionality
+-------------
+
+The Topology library provides the following functionality:
+
+- Partitioning of logical cores into topology domains
+- Support for CPU and I/O based domain selection
+- Grouping of lcores by hierarchy levels: L1, L2, L3, L4, IO
+- Reverse lookup from lcore to domain index
+- Helper APIs for lcore and domain iteration
+
+Dependencies
+------------
+
+- ``hwloc-dev`` tested on `2.10.0`
+
+The dependency is used to:
+
+- Discover system topology
+- Group logical cores into DPDK‑specific domains
+- Provide stable mappings across EAL configurations
+
+API Overview
+------------
+
+All APIs are provided under the ``RTE_TOPO`` namespace.
+
+Domain Enumeration
+------------------
+
+Get the number of domains for a selected topology type.
+
+.. code-block:: c
+
+   uint32_t
+   rte_topo_get_domain_count(enum rte_topo_domain_sel domain_sel);
+
+Lcore Enumeration
+-----------------
+
+Enumerate logical cores within a topology domain.
+
+.. code-block:: c
+
+   uint32_t
+   rte_topo_get_lcore_count_from_domain(
+       enum rte_topo_domain_sel domain_sel,
+       uint32_t domain_idx);
+
+   unsigned int
+   rte_topo_get_nth_lcore_in_domain(
+       enum rte_topo_domain_sel domain_sel,
+       uint32_t domain_idx,
+       uint32_t lcore_pos);
+
+Iterate over logical cores with optional filtering.
+
+.. code-block:: c
+
+   unsigned int
+   rte_topo_get_next_lcore(
+       unsigned int lcore,
+       bool skip_main,
+       bool wrap,
+       uint32_t flag);
+
+   unsigned int
+   rte_topo_get_nth_lcore_from_domain(
+       uint32_t domain_idx,
+       uint32_t lcore_pos,
+       bool wrap,
+       uint32_t flag);
+
+Domain Lookup
+-------------
+
+Query the domain associated with a logical core.
+
+.. code-block:: c
+
+   int
+   rte_topo_get_domain_index_from_lcore(
+       enum rte_topo_domain_sel domain_sel,
+       unsigned int lcore);
+
+Check whether the main lcore belongs to a domain.
+
+.. code-block:: c
+
+   bool
+   rte_topo_is_main_lcore_in_domain(
+       enum rte_topo_domain_sel domain_sel,
+       uint32_t domain_idx);
+
+CPU Set Access
+--------------
+
+Retrieve the CPU set associated with a topology domain.
+
+.. code-block:: c
+
+   const rte_cpuset_t *
+   rte_topo_get_lcore_cpuset_in_domain(
+       enum rte_topo_domain_sel domain_sel,
+       uint32_t domain_idx);
+
+Debug Support
+-------------
+
+Dump topology information for debugging purposes.
+
+.. code-block:: c
+
+   void
+   rte_topo_dump(FILE *f);
+
+Usage Notes
+-----------
+
+- Domain‑aware lcore selection can reduce remote memory access.
+- Cache‑level domains are suitable for cache‑sensitive workloads.
+- Topology mappings remain stable across EAL lcore configurations.
-- 
2.43.0

