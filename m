Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8056CFEFB58
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 14:32:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86886409FA;
	Fri, 27 Feb 2026 15:32:18 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
 by mails.dpdk.org (Postfix) with ESMTP id DC0DA402C5;
 Fri, 27 Feb 2026 15:32:16 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FEZnaRQ4q7f2UAJQeH6/+i+ka6A3Q/lv7cl84NwfBOCghpk+U4Js2ZsIqt7MDXQpue8ZKu9J6eZl3Xd07+L12/dLUa1eahW3oKTTxNQW4YBAfBfb0t866SgbXuUbntZi5Kk2FXsBYCCQpxnv71fPjhfIErvokHmf2BLh+NfXVcwnQP3SLa/Q7WS69t4ij+rWSbil2soMZQCuwZLt5ypYSHnm6edZpPVE6xtz0p4bbtVB17gyjjeI81SORVtoZctp/nRaYPsChtN22Fzrxpt8l07TZIHDreljPKcCSo3I4xB4xOv5WTURA1qYkuiDfc71dhJfr9uoRH4KIKBU17qc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQPu2Bs5C64Ln4X9TSp1SnG5N6eHpGE9GLfOroQhijs=;
 b=tb4GtAuDP7SJypBngPxRRDNqkNv4DfFXvyMUfxXbwk0gWkLw7Prk3UZFd/LZAQDfKvv4DXXkzVpwSViqpjl+v+tDQexv6MkTaRWvwOaezPpbDkcPzkfsgJmDGqEhgU7qiFk2B3uNJo0V5RAIezbgAJyt2aebIathXYhrMCWQ6uOv3WbjpCxXXLfQlxEvWvF+U+VJiPBMwuy5HbMZWwcqMRo+uC77a829/wfmc23TGVaeSzZXeieUnwZFpcOea/mVgTS3u71jOUnjNkwUlxSM0+ReD17QmEucBccFGwpjolfqsjpgTZ/pJCux+JEWi8f8fc1tCsQSewONZf+4pbUQdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQPu2Bs5C64Ln4X9TSp1SnG5N6eHpGE9GLfOroQhijs=;
 b=2ZuuTwNuwr+vVLcPsI8BDvF/QyT4TIpr3vHJn1BkgUn856S2f8zM2f+1wV7l4d7obgD5STmYrvyYFHeejOGvz9z3/rW/Fu/9xjp7RumibGLS9o4Gpy1NZk/WxDu59hinrHxv4Fv76hDibXIXLP0RqETVVKheIPiegCxZQSYMoEc=
Received: from BYAPR11CA0105.namprd11.prod.outlook.com (2603:10b6:a03:f4::46)
 by CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Fri, 27 Feb
 2026 14:32:09 +0000
Received: from CO1PEPF00012E80.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::21) by BYAPR11CA0105.outlook.office365.com
 (2603:10b6:a03:f4::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Fri,
 27 Feb 2026 14:32:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E80.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 14:32:08 +0000
Received: from BLRVIVARGHE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Feb
 2026 08:32:07 -0600
From: Vipin Varghese <vipin.varghese@amd.com>
To: <dev@dpdk.org>
CC: <vipin.varghese@amd.com>, <stable@dpdk.org>
Subject: [PATCH] doc: update AMD EPYC guide
Date: Fri, 27 Feb 2026 20:01:33 +0530
Message-ID: <20260227143133.510-1-vipin.varghese@amd.com>
X-Mailer: git-send-email 2.47.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E80:EE_|CH2PR12MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ef196e-74e8-4e58-6154-08de760cfcfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: VD1H6daP5iUBAWCg8aOrvqQXhMXBoolTF5v9GOxxNHPqCEBJmsGUyDS+KKzvqKZOQckXH08ZIEQWAQvJM6WdBgfwlFugQxMGeUPmTozW0Z2DNXZBbQPmu3qwxeSdRgs+rEyViZA+L79lvMcIgQXu29XGxL9WAU8rhXG5/mMaQSsXBGGfIfYizLmLkKUpFiwAaj+bF8YEBpfbC7zxFmBk31iMzsrqlexZxcgNN/xcUg+xSzsdn9vOJkPIYE1FhoQ7TVkb2xPATvW2uvlT2yNLZsHbjFZIGw7/385VQaX4JqUkgeek2YHk9r+wv9rS9V9qxq1TJ7FTsIn7QTy78w5iW4KYefBsCsgw5WTpeOnFmubUqBxy3R7Qu6u74AmrpqoNJwnYBSrlfUlp9rU7jMxSuVTTQ+wuN00v9OGCDbYhgBGIscmPZwqqHSZwgzlb2GnCcMxLpNxY1Ds/vFcrJmQwt+pmqp14Ikha5sXhn7CDs+0OgsP/72psIj/TKwCwDG0NxZcFRnVfjA7BHeHSMDE/MbRxBktWuYnC5TEA5SbH59fF6aX8HMvzxG0QnDtR5ZxuZtEafW+BAFb7xmCmpeqVlujdMBLPxKw6D2OAu12eG/M4M7qz4SkLnfS2p94DmcRJzTReBs5lPlR2RJ3/E+AoP9ISnmra3CxM8AQNSjGsSK9/fRcc6P58Ay6unezPavd0n6HhsNoqrVBCXtEcFn/06SlT5zhH5s9aGNaDBGhV+OVg+FSRaLswYcLZsMkKgJwlBTd6eTeri4yRknKCu2u11GTm3U87lx1Dx93FhA0CCYbMY3GseVjmgRJ+IHoDwks+Q3FnnIYddbxLJqyOhZ6BuFtyzr4uE1FYTLTIiLctL0o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KtXx1qIQKwfvsVgUs+Uam2p7TiD5Cqddwrsand1q8UN1eEaStRVJ3s2WSgYqJgXzSQ7PUo+d+E2xs/K9xw/Zu9tFNBUlMLz+Wt8JUxX+XdR9klxMwV4fJBc7funFYkullkHTzrZ+kSYvwHN823r8zyE92gDvI2KQxOPyMbDHqgCuFKmxfVipNVVykvHDX+x9CG5NP2m4fS6qpBlPqwEaKhF+dZR3SjtSPij+J+JIn1+B7gH6U8QQ3aH//74A/1CEM5qG1U7T0EamHSKQaeO9ExrIPWrIpoS0OdHItbSc6lO5Ddpn+ZVBWxnLZacpU5RGCYgH1Pgpqin4ujirhE/gssoksw+a660LmgzPa+6ErQmW3+G68uRraeFkdLviQIs0D+dd86Tq7BVhw0TmkQs6XEe9N+sdP78xqj56uA1KAXymxA12qRPaLLmpaFnfpEFk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 14:32:08.7991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ef196e-74e8-4e58-6154-08de760cfcfa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E80.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198
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

1. updated URL for AMD SoC tuning guide.
2. add `ASPM` disable for latency.

Fixes: de1f01a8eabd ("doc: add AMD configuration in Linux guide")
Cc: vipin.varghese@amd.com
Cc: stable@dpdk.org
Signed-off-by: Vipin Varghese <vipin.varghese@amd.com>
Tested-by: Vipin Varghese <vipin.varghese@amd.com>
---
 doc/guides/linux_gsg/amd_platform.rst | 29 ++++++++++++++++++---------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/doc/guides/linux_gsg/amd_platform.rst b/doc/guides/linux_gsg/amd_platform.rst
index 40b65d1c9e..3d395a3605 100644
--- a/doc/guides/linux_gsg/amd_platform.rst
+++ b/doc/guides/linux_gsg/amd_platform.rst
@@ -4,9 +4,9 @@
 How to get best performance on AMD platform
 ===========================================
 
-This document provides a detailed, step-by-step guide
-on configuring AMD EPYC System-on-Chip (SoC) for optimal performance
-in DPDK applications across different SoC families.
+This document provides a detailed, step-by-step guide on configuring
+AMD EPYC System-on-Chip (SoC) for optimal performance in DPDK
+applications across different SoC families.
 
 The overall performance is influenced by factors such as BIOS settings,
 NUMA per socket configuration, memory per NUMA allocation,
@@ -18,13 +18,13 @@ These are covered in various sections of tuning guides shared below.
 Tuning Guides for AMD EPYC SoC
 ------------------------------
 
-#. `MILAN <https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/tuning-guides/data-plane-development-kit-tuning-guide-amd-epyc7003-series-processors.pdf>`_
+#. `MILAN <https://docs.amd.com/v/u/en-US/data-plane-development-kit-tuning-guide-amd-epyc7003-series-processors>`_
 
-#. `GENOA <https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/tuning-guides/58017-amd-epyc-9004-tg-data-plane-dpdk.pdf>`_
+#. `GENOA <https://docs.amd.com/v/u/en-US/58017-amd-epyc-9004-tg-data-plane-dpdk>`_
 
-#. `BERGAMO|SIENA <https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/tuning-guides/58310_amd-epyc-8004-tg-data-plane-dpdk.pdf>`_
+#. `BERGAMO|SIENA <https://docs.amd.com/v/u/en-US/58310_amd-epyc-8004-tg-data-plane-dpdk>`_
 
-#. `TURIN <https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/tuning-guides/58468_amd-epyc-9005-tg-data-plane-dpdk.pdf>`_
+#. `TURIN <https://docs.amd.com/v/u/en-US/58468_amd-epyc-9005-tg-data-plane-dpdk>`_
 
 
 General Requirements
@@ -107,7 +107,13 @@ Please refer the tuning guides to enable ``HSMP`` and DPDK power management guid
 NIC
 ---
 
-To use Solarflare x4 on AMD EPYC TURIN, please ensure the following
+To use NIC in low latency mode, follow the tuning guide to update GRUB with `pcie_aspm=off`.
+
+
+On AMD EPYC TURIN, please ensure the following
+
+Solarflare x4
+~~~~~~~~~~~~~
 
 #. Upgrade Linux or distro version to 6.13 or higher.
 
@@ -118,7 +124,9 @@ To use Solarflare x4 on AMD EPYC TURIN, please ensure the following
 
 #. Please use PMD args ``fw_variant=ultra-low-latency,perf_profile=throughput``.
 
-To use Solarflare x2 on AMD EPYC TURIN, please ensure the following
+
+Solarflare x2
+~~~~~~~~~~~~~
 
 #. Upgrade Linux or distro version to 6.13 or higher.
 
@@ -127,4 +135,5 @@ To use Solarflare x2 on AMD EPYC TURIN, please ensure the following
 #. Enable the hardware with ``sfc`` Linux Kernel Driver first;
    then bind with ``vfio-pci`` next.
 
-#. Please use PMD args ``fw_variant=ultra-low-latency,perf_profile=throughput``.
+#. Use PMD args ``fw_variant=ultra-low-latency,perf_profile=throughput``.
+
-- 
2.43.0

