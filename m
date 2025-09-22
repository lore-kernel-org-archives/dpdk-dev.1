Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51E1CAC592
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 07:02:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C1B0402EF;
	Mon, 22 Sep 2025 09:02:29 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011005.outbound.protection.outlook.com [52.101.57.5])
 by mails.dpdk.org (Postfix) with ESMTP id 56448402ED
 for <dev@dpdk.org>; Mon, 22 Sep 2025 09:02:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVs9F2+S6RRd99C96ysWlgq6dQXLXWLyIoiDRgILonyUn7hIb6HJdh7fLosSGJi+KlQwwCOoNh3OIGPX8VrcLUimT0nVQ9TSPd4zv664YftySNC82cYcOqO2NTJ2uigTX7O+89ro7er2dcBhca2ODBsetnMxjz1MjzRAmOLiW4nj+dhS/vXF84pX8OpzfW8Z4WZK0E6KxEcPi9m/T6rW9FatDoQBu3JUYKbuZrNdJnkow61mKs7wyXkibNXg5MVB+0JHwSDaxJRw9CbjnSEQ+ugmI3b6ayQeKSKgZsPzOJo2SodTAGe5TNvhUSIHTLjfbJkIjY1wS6wB1LqRRqns2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKJ5qNzrtD82/dTX02bvwqxzhYXC4BoJTn75y1bMbfY=;
 b=ThvHGl/V8SkGn0k+j6CCulJr3PG5YAP+mtJP4c6g8HEwb/SCC10cNCINERKhTO4joA/CbISneSOkA4X8ywZ3j4kwEWQU5gC7eHmI0pdH3c04rIkeYmdGtSbxIe2FGTVYjPEHeM6u1e3wzepMfvBs4djCW7spqbrUrNdrJCu3/HJ5C1Jln9J7H0T8ZVmbE8Ht/l+u0KGhiwUmsrCnsa10kQ4Us0h/LGkVOVVNmKYcwgYmS8/AdgEe6lpcXCByvp9LpjeRmtqfkeAuZCI6VKvY1gKUm9Yf56MW2Xf4BHisLqOTtrby42Kggpu1v9SxKnvGZLAR9Jn6rcDEL+PzCcxzrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKJ5qNzrtD82/dTX02bvwqxzhYXC4BoJTn75y1bMbfY=;
 b=RtR0dYLQP/avJ59RWtmqQlH4ik7AWwuyWKEh5AyEnw51f2xqEPOWrxUX68xCc9eEAn35y8idcOPaGEaArrI170t/bx5IwAlAIFDfLBGPcZhI6/7PCteneeb6U8SOZKVU3zpil2wo33yfCGvD1aiMu19LhugTyM8nbW+stYYVMcU=
Received: from MW4PR03CA0327.namprd03.prod.outlook.com (2603:10b6:303:dd::32)
 by PH0PR12MB8005.namprd12.prod.outlook.com (2603:10b6:510:26c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Mon, 22 Sep
 2025 07:02:24 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::7) by MW4PR03CA0327.outlook.office365.com
 (2603:10b6:303:dd::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 07:02:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 07:02:23 +0000
Received: from BLRVIVARGHE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 22 Sep
 2025 00:01:07 -0700
From: Vipin Varghese <vipin.varghese@amd.com>
To: <john.mcnamara@intel.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>, <dev@dpdk.org>
CC: Thiyagarajan P <Thiyagarajan.P@amd.com>
Subject: [PATCH] doc: update AMD EPYC guide
Date: Mon, 22 Sep 2025 12:30:16 +0530
Message-ID: <20250922070016.1066-1-vipin.varghese@amd.com>
X-Mailer: git-send-email 2.47.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|PH0PR12MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 7452ac3c-8ab8-45e3-5d5d-08ddf9a5fb61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Uqk9hOwsMEOFxVOBZYRw+jHWOV1JJHkscFT8GnhFT9JVURdasX343hQKMt5K?=
 =?us-ascii?Q?qd3vek9k8RfqGkXnbUtU/m+ojv9ffVpLhhaZOuMWFatGt8errfc1nd7B1Kw5?=
 =?us-ascii?Q?u5JJdYACd9IrWNjvMUYcyhYSaTQBoAdJnin2cBGJ8HaxgWnvy3q6mhR5B1Nr?=
 =?us-ascii?Q?GLIXOqC+Q4tZZKrs8kRRL4+77Fpl04jhAGYR5pIS7049O3CRBQ2GD5toRy5i?=
 =?us-ascii?Q?X4+Ad6fUFKD5RR4S48td8QAT0sWt/znIb7aJV1uBwXHoq9JQB/LjVfN6YYjT?=
 =?us-ascii?Q?iplJzRZ6hOvV7JI+M4VJkWF9STRTmw7To9CShWi6HWLjuqRAB5rUFXLbADLm?=
 =?us-ascii?Q?BQS4/5BzPvoimfIXmZ3WOmOvSKLlBqTCkIFsuVsmu8NfBkxDNeuXDlhyZYdU?=
 =?us-ascii?Q?covpg0pSyJOJNZxKTVry3u/oMcp9zDi9WCGPmEK8Qervg5F5E2ppy02f7yrW?=
 =?us-ascii?Q?OXiL9vsX4rzGzVR3NSGk9si68KuQrUnwgSrMXQe/5/JegHM1Tm3c7l3U3ibI?=
 =?us-ascii?Q?TWboYrYRL/gXQdnIx+fGoV7aQvoAu3anZS/No8/OEDonU7aan5itgZUc6gaO?=
 =?us-ascii?Q?qfeLUY4zsnIzEOJILV/6vcnyXLBBW13dIhTnPcMBl8r5eUR99D++2MqKTrSB?=
 =?us-ascii?Q?/FPuE9GyE7oALVTtH+GNGsSdJQIJstAsbUI7ue6Ex1UCDZh6yUDLDpVQ4yvV?=
 =?us-ascii?Q?dRtCBtJOXiN7Sp5zUlZ5P+tJ9OdTDo5qbVDbsJGi0a3JEeK9MsYbA7bt38og?=
 =?us-ascii?Q?yMD8gCfUj2+JVLRv02SQT5WrFa+q+F0//CLZhyL9TZUxgnio66nZregI5Ym/?=
 =?us-ascii?Q?IYrb59jatlNsCRXIQHUMAQv8bz4Trs36ai87w2T//f5XAYrEa4UD6byO3/mK?=
 =?us-ascii?Q?Cd6sRiuW5xKlUEzMDxgYyAXct2dfoA8XeTaSpIa1dq30lMWAKrmsPLITgq0Q?=
 =?us-ascii?Q?tyvqSG5kQnnuSA/d+eVCWD+iXitB5K0gxmPoEVmFbo+JjGSkrvYrFDPOh2fS?=
 =?us-ascii?Q?BQzEOjMGz3eUTGJh2WDEAdmSl1dK7NXoV+edOvHNdtS5xQPX5s+QCvnGruna?=
 =?us-ascii?Q?kYtI9QQHVzsSVR4vz8Cx6+Diyyq+hZUb5YTH/9U5zK9/zo196A3d39aw9hm8?=
 =?us-ascii?Q?8TxZ5r170JuKEegeb8eS6w2TafoNZ1xnMsxzHAqhQ0/hQFtdNUrpFphmUNfP?=
 =?us-ascii?Q?YuYBUDG0BaGbX5+mX/DxYmZB451pXBzwENgSO3YNaRymna12P9dc8s3WA5Ho?=
 =?us-ascii?Q?k+DV4CNuquRxo72RX2JUL/YENjHjsqw28VpLWBsJBVLfUb7cujmP98gUHUQT?=
 =?us-ascii?Q?fc2tUvm8VHtXym/yy5QBdkddLeyIWnFLqMg8oyGGs6yw/Ff2xUCTp2gEwqE9?=
 =?us-ascii?Q?2radJAh2VgiLcKf1CULgboDsegHjKfU5rr6LkfkVAa7Rv+HomInyI8vaek6w?=
 =?us-ascii?Q?we4WRNjgUJuVnIsnxw718V/BJIQNxqLqNB+zlaiQiiN2I4A3BjV872B3udIK?=
 =?us-ascii?Q?ZC6b6ml8tRUytuH3x161KG3cEgkG/Jje9+zq3JTh60m8krfJ5HheDxn2VQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 07:02:23.7513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7452ac3c-8ab8-45e3-5d5d-08ddf9a5fb61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8005
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

 1. fix spelling from `SIENNA` to `SIENA`
 2. add tuning guide for zen5 AMD Epyc 9005
 3. add uncore power details
 4. update on using AMD Solarflare X4 and X2

Signed-off-by: Vipin Varghese <vipin.varghese@amd.com>
Tested-by: Thiyagarajan P <Thiyagarajan.P@amd.com>
---
 doc/guides/linux_gsg/amd_platform.rst | 40 +++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/doc/guides/linux_gsg/amd_platform.rst b/doc/guides/linux_gsg/amd_platform.rst
index 43d85273e2..c0cc5e291e 100644
--- a/doc/guides/linux_gsg/amd_platform.rst
+++ b/doc/guides/linux_gsg/amd_platform.rst
@@ -22,7 +22,9 @@ Tuning Guides for AMD EPYC SoC
 
 #. `GENOA <https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/tuning-guides/58017-amd-epyc-9004-tg-data-plane-dpdk.pdf>`_
 
-#. `BERGAMO|SIENNA <https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/tuning-guides/58310_amd-epyc-8004-tg-data-plane-dpdk.pdf>`_
+#. `BERGAMO|SIENA <https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/tuning-guides/58310_amd-epyc-8004-tg-data-plane-dpdk.pdf>`_
+
+#. `TURIN <https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/tuning-guides/58468_amd-epyc-9005-tg-data-plane-dpdk.pdf>`_
 
 
 General Requirements
@@ -86,10 +88,42 @@ Core
 ~~~~
 
 AMD EPYC SoC supports CPU power functions via ``rte_power`` API from `23.11 LTS` onwards.
-These are tested and validated on MILAN, GENOA, BERGAMO and SIENA
-using Linux kernel `6.4` and above with ``amd_pstate`` power driver.
+These are tested and validated on MILAN, GENOA, BERGAMO, SIENA and TURIN
+using Linux kernel `6.4` and above with ``amd_pstate`` power driver in ``passive`` mode.
 
 .. note::
 
    * Power libraries are supported on Linux only.
    * DPDK uncore support on Linux is work in progress.
+
+Uncore
+~~~~~~
+
+AMD EPYC SoC support UNCORE power functions via ``rte_power_uncore`` from `25.03` onwards.
+These are tested and validated on GENOA, SIENA and TURIN. Please refer the tuning guides
+to enable ``HSMP`` and DPDK power management guide.
+
+
+NIC
+---
+
+To use Solarflare x4 on AMD EPYC TURIN, please ensure the following
+
+#. Upgrade Linux or Distro version to 6.13 or higher.
+
+#. Disable PCIe power option via ``vfio-pci.disable_idle_d3=1`` in GRUB.
+
+#. Enable the hardware with ``out of tree sfc (contact Solarflare)`` Linux Kernel Driver first; then bind with ``vfio-pci`` next.
+
+#. Please use PMD args ``fw_variant=ultra-low-latency,perf_profile=throughput``.
+
+To use Solarflare x2 on AMD EPYC TURIN, please ensure the following
+
+#. Upgrade Linux or Distro version to 6.13 or higher.
+
+#. Disable PCIe power option via ``vfio-pci.disable_idle_d3=1`` in GRUB.
+
+#. Enable the hardware with ``sfc`` Linux Kernel Driver first; then bind with ``vfio-pci`` next.
+
+#. Please use PMD args ``fw_variant=ultra-low-latency,perf_profile=throughput``.
+
-- 
2.48.1

