Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C09F9D0EF
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 19:39:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51EFB4028F;
	Tue, 14 Apr 2026 21:39:32 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011069.outbound.protection.outlook.com [40.107.208.69])
 by mails.dpdk.org (Postfix) with ESMTP id 011AF4028D
 for <dev@dpdk.org>; Tue, 14 Apr 2026 21:39:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hV/qo7b7M7PLU7iSM4CleI+ju/0jsw44mxPm1ORJ+0mKN+asmq5Qqt8GAG+htmIgzvpZ+UF8M960Qanr6yLu9lICK6q0FMmwAFWPwfB6Bb6gaImmWbDAQlIm7O54QgzB3sL4a9DjOT8Mguum44Li0Kfu+ItalxWoJ1cwQ+1WBnmHUkeMLofyX38mIy/pAx+q5nW6FZzB5lcajzFhwgrP3xcoZIaEGPpwABXDxev1xYHDF1291ZpKEKFlexFZxmoaXQCSEhO04HYz0vYu8P13RnjXfItIu10xV5auHfXOST6iIIwAs14vbJ0dlYKLJHIsAtJslAJRF96HbxbB7Ey0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XUBkGEKRvju8KParOg3HsgH8li/5HvkABbb4ggn5wA=;
 b=P6339D/DT6UWVWSlEAHhIyZLX3RO2fHKIZSxd70tKOXD5FcyRfiTf0W/yxyYje1cvXNFCsbmua5Kz3PU4rALxIv2CZMHdL3b/1WFhSaEDLJMRrZ2ejkGPf88ISv7VVTsdf3+4NdgHfmqgrQk5D/bKmlKFrt3pAbyY7k6EdRs/pLc+MEcDrmnWWl6jSZ1vpG2LOrmUnh7weQ9qZXyp78gXm0dNRf/aVCcVY3shJTjOaw4revT/7QlIne/XXeIlM8noAjeQsJsOtWDISWM984lWRYX3L6OL7qQb68kOdnZqLfF8H2VOhhtHEUMe4qnPJts366Woo5+rOp1mWx1niObqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XUBkGEKRvju8KParOg3HsgH8li/5HvkABbb4ggn5wA=;
 b=dZ45c+HrfRgVo01N/L2HpcyJLE/epL4+EEDWzwrzfXXkro8OMNfI2ytdkDi3PtHCofB5OJYEpxbJTfS4i1VBnNz7GaxGVQXyQXXARwc3bt5e4MffexvIO+nm1t+YIQEHGid5TIziB8W4SFMhKyr52uipHWQQVdNl4XEgdc5jXCs=
Received: from CY5PR13CA0012.namprd13.prod.outlook.com (2603:10b6:930::23) by
 DS7PR12MB8230.namprd12.prod.outlook.com (2603:10b6:8:ed::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.20; Tue, 14 Apr 2026 19:39:24 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:0:cafe::2f) by CY5PR13CA0012.outlook.office365.com
 (2603:10b6:930::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 19:39:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 19:39:24 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 14:39:23 -0500
Received: from BLRVIVARGHE.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 12:39:20 -0700
From: Vipin Varghese <vipin.varghese@amd.com>
To: <dev@dpdk.org>, <sivaprasad.tummala@amd.com>
CC: <konstantin.ananyev@huawei.com>, <wathsala.vithanage@arm.com>,
 <bruce.richardson@intel.com>, <viktorin@cesnet.cz>,
 <mb@smartsharesystems.com>
Subject: [PATCH v5 0/3] eal/topology: introduce topology-aware lcore grouping
Date: Wed, 15 Apr 2026 01:08:18 +0530
Message-ID: <20260414193850.1696-1-vipin.varghese@amd.com>
X-Mailer: git-send-email 2.47.0.windows.1
In-Reply-To: <20241105102849.1947-1-vipin.varghese@amd.com>
References: <20241105102849.1947-1-vipin.varghese@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|DS7PR12MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: 877a18de-249a-49cd-3975-08de9a5d8891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: wqzg6s8IPxYrzm883QLJAQ0gqqWdOAxXvrzpPCxrHEcvUWovUkILHZUryQDlg9uwABOkpxDFMAIrfwFuEAEmUd9Xtrkc3yEpL2HvtKe7wtiwyx+NJJVCATErUjiN91zXswdKN5PfUEtBxUgbnfrvMBwRAA2oMSY5jbtE7yUd7Ax9WjHLobYWfeEepK55oYDHlXukfJ6Z5hPrXDvqDu0lWBBxVI86zNFPdgscY0aDQozhCRL+ooUjEXpj5aa1eEaQikpTrpAfj9vIZ9WfPj7bM6Jqg0yesqVlrpEygm67KuJQ3x/GbE8TI8WBc/UAhM2q/6FJmNNvML4GaIwv5Ce3YZ8bterBqiaXCriqKCzu0zDf6q8nQH3uyYHaphKzhWqFFQdtkhB2x2edkGVVMk2ZPuTwKGjyFeqfzeGe3uIj7pQTApGbLjI/FpjWm0sjevai6P1OvYnfj7Q2N7HDiaf3IsWlPS6pWbfm/gjH29jWnXz/2W4OjPQImY1ndB7TWVsK6wblOYytD8AoUwOA6bDKIWGArX80uGSiDV+i1IBjJp9Hw7y9pNOSrB6xy/vD/0ZTqdQzoY2oJnj5V8JS02jVBa3K0sVS8gj7XmEGwXG6BqfBtk2iUZb8cNwDohscnF9H9utBy0nedXWPQt+uku/jfD8o4aPIu9DJt/QevpE2EcN71QKn5tTj6lYnUdc/n6tBYV3nVanP9HLd3sJWf8PtshhivPHhgjd4lJaB/Hf87l6NoEzh6lXHV3ACVLo5Nf7S9Zx+U2+GSLNkOSKHWDuMTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Nd1Vt+rQRlaJYwwFQW8MX1Oky8b262RoU4DbE+zEppEXHgMBLZtKCZbW2bN+gXvbfg7tO27sIbYXKRpVPShlotOGqRze6HlrrLMEixirSPLc5qH9bs11inJEFsPDefUrDGPYr+8cDDyiRHgIxvwpruHunuchCpDESOlHEuaXq5lTvBV+EAHDs58FKeRG4pEdXQ4lVMjzaeIVRmLmcVW/5F1pD0+le8x36vvuQqZeesLNHYLpqLX131v/gDxR+uTJ+3pLoMUAYfc6wlzzd9rh/rN56Bija0Gs+ZPv6oi7PLiPsBSFYTds/RhnexoWWiaJyfIEpbr5SB1/ltAntOIjqrCUBUzftMVPnooQAr+WNC6b4c7nDOOLIUXnfYH2DfAuFTEaJbIvNhNDnlmJzqgi8IFUtQSlUJzRNeP0BM8wPXstV/lglfCtvttFGf9+XsJu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 19:39:24.6152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 877a18de-249a-49cd-3975-08de9a5d8891
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8230
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

This series introduces a topology library that groups DPDK lcores based on
CPU cache hierarchy and NUMA topology. The goal is to provide a stable and
explicit API that allows applications to select lcores with better locality
and cache sharing characteristics.

The series includes:
  - EAL support for topology discovery using hwloc and domain-based lcore
    grouping (L1/L2/L3/L4/NUMA)
  - Topology-aware test cases validating API behavior and edge conditions
  - Programmer’s guide describing the topology library and APIs

The API is marked experimental and does not change existing lcore behavior
unless explicitly used by the application.

Changes in v5:
  - Addressed review comments from v4
  - Fixed ARM cross-compilation issues
  - Cleaned up domain iteration and error handling
  - Updated tests to cover domain edge cases
  - Documentation refinements and API usage clarification

Changes in v4:
  - Corrected domain selection semantics
  - Updated example usage
  - Fixed naming and typo issues

Changes in v3:
  - Fixed macro naming (USE_NO_TOPOLOGY)
  - Minor cleanups based on early feedback

Tested on:
  - AMD EPYC (Milan, Genoa, Siena, Turin, Turin-Dense, Sorano)
  - Intel Xeon (SPR-SP, GNR-SP)
  - ARM Ampere
  - NVIDIA Grace Superchip

Dependencies:
  - hwloc-dev (tested with 2.10.0)

Patch breakdown:
  1/3 eal/topology: add topology grouping for lcores
  2/3 app: add topology-aware test cases
  3/3 doc: add topology library documentation

Future Work:
 - integrate into examples
  -- hellowrld: ready
  -- pkt-distributor: in-progress
  -- l2fwd: ready
  -- l3fwd: to start
  -- eventdevpipeline: PoC ready
 - integrate topology test
  -- crypto: yet to start
  -- compression: yet to start
  -- dma: PoC ready
 - add new features for
  -- PQoS: yet to start
  -- Data Injection: PoC with BRDCM Thor-2 ready

Tested OS: Linux only, need help with BSD and Windows

Tested with and without hwloc-dev library for
 - Ampere, aarch64, Neoverse-N1, NUMA-2, 256 CPU threads
 - Grace superchip, aarch64, Neoverse-V2, NUMA-2, 144 CPU threads
 - Intel GNR-SP, 6767P, NUMA-2, 256 Threads
 - AMD EPYC Siena, 8534P, NUMA-1, 128 Threads
 - AMD EPYC Sorano, 8635P, NUMA-1, 168 Threads

Signed-off-by: Vipin Varghese <vipin.varghese@amd.com>
``

Vipin Varghese (3):
  eal/topology: add Topology grouping for lcores
  app: add topology aware test case
  doc: add new section topology

 app/test/meson.build                   |   1 +
 app/test/test_ring_perf.c              | 416 +++++++++++++-
 app/test/test_stack_perf.c             | 409 ++++++++++++++
 app/test/test_topology.c               | 676 ++++++++++++++++++++++
 config/meson.build                     |  18 +
 doc/api/doxy-api-index.md              |   1 +
 doc/guides/prog_guide/index.rst        |   3 +-
 doc/guides/prog_guide/topology_lib.rst | 155 +++++
 lib/eal/common/eal_private.h           |  74 +++
 lib/eal/common/eal_topology.c          | 747 +++++++++++++++++++++++++
 lib/eal/common/meson.build             |   1 +
 lib/eal/freebsd/eal.c                  |  10 +-
 lib/eal/include/meson.build            |   1 +
 lib/eal/include/rte_topology.h         | 255 +++++++++
 lib/eal/linux/eal.c                    |   7 +
 lib/eal/meson.build                    |   4 +
 16 files changed, 2773 insertions(+), 5 deletions(-)
 create mode 100644 app/test/test_topology.c
 create mode 100644 doc/guides/prog_guide/topology_lib.rst
 create mode 100644 lib/eal/common/eal_topology.c
 create mode 100644 lib/eal/include/rte_topology.h

-- 
2.43.0

