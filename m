Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80E3CAC592
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 07:01:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED276402EF;
	Mon, 22 Sep 2025 09:00:59 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
 by mails.dpdk.org (Postfix) with ESMTP id 18E6B402ED
 for <dev@dpdk.org>; Mon, 22 Sep 2025 09:00:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvw/HkmpoPsec0qY/idBinGfWEZK4ivc0t9mqLeX9osGqnLpYmud46NFdrhLNp7tty7lyA+mGMn8yRGmJJYrLC79Z6rBXVVUGgAdVLjwY5sVGrKs/j3nA/t8v6KCpR4QFjskEAKIlkgVPMDKktU5ZHaL6UA2/YDEmyZEjFnwcIuw3mhsIO+9GYahviTEMuZRVYUoVyIjGN6+Yzq5ZV06/ApT1SbuYvRtHPVij6YMKHFboOcyKwwKdLtgI1YbyFQVEkMevXS2EljfKv/CwDAgOa2r59ny2/1XF+CEVKe1qX/GWakvwD/MujV9E0Q1gHH3oJKDgkb4YxR8nMzxQbyNYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKJ5qNzrtD82/dTX02bvwqxzhYXC4BoJTn75y1bMbfY=;
 b=O2G3f5b6GvisxClzptTrbojfU4AhH8T5DiaYo2h448DAM8OiU8R2uSiQOIdYI4+4lYk/0S8L0bu+VXQ9FDja+DUvJGkBfyzKNPtCq5TKpRg2EynVBoTbSa9ExIKoP0dhY16Wd3bsSCHpjvhCvdcT+rjL/WAldwVcPSACGK0SZ4NRe8k9kXYju6O8T9vsPXi7rd0aDTw+GD7FGAfmX/3IavIh5o1JEkoQ9l1HyHJ25Ap+jN0XUkOFwqyO9iHadV/Rs0Jcc7Y/uQazTzo9hxvoFOuMVZ75EU6zVmsb2a6M0BgdaPg9xJOzOrkxlX6Z5FZ9/fziTTVCLtNd+QLNJTHTwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKJ5qNzrtD82/dTX02bvwqxzhYXC4BoJTn75y1bMbfY=;
 b=yJqPp6JxSQs/VqeqBCPWQE3RJeLtkLWnHQB3Bi62lxntjtohz09mtAH02OJEaJZwQqYRNVr+iS3tYehy2HsauxnsFA/eL5kxxVLfOTDLfm4YSnnJqhXOGl4TIIkAxBmQ9LUJGvqOIW+tKlkMZ80WI5S/CvjGFBpbqPbj+gP3hWQ=
Received: from SJ0PR05CA0112.namprd05.prod.outlook.com (2603:10b6:a03:334::27)
 by MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Mon, 22 Sep
 2025 07:00:54 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::b9) by SJ0PR05CA0112.outlook.office365.com
 (2603:10b6:a03:334::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Mon,
 22 Sep 2025 07:00:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 07:00:54 +0000
Received: from BLRVIVARGHE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 22 Sep
 2025 00:00:50 -0700
From: Vipin Varghese <vipin.varghese@amd.com>
To: <john.mcnamara@intel.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>, <dev@dpdk.org>
CC: Thiyagarajan P <Thiyagarajan.P@amd.com>
Subject: [PATCH] doc: update AMD EPYC guide
Date: Mon, 22 Sep 2025 12:29:51 +0530
Message-ID: <20250922065952.1057-1-vipin.varghese@amd.com>
X-Mailer: git-send-email 2.47.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|MN0PR12MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a26192c-bf35-4348-38e6-08ddf9a5c631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zPBOo1a9b8Oj31u8PYClvooYA6o62wQAGMnbxzfDWj+S35ru55Ve/dcmzfg8?=
 =?us-ascii?Q?0JKyx7kD6ir6vxGrfNIXAl8nCh97k+0X1euLEVaqMsODLuNppArDNQ5E6vLa?=
 =?us-ascii?Q?0wkXcl5SsOOwAvwDTpZYfOEHIPfgCckqUCSSsyCXI2oUphO8p37rhUqZDOJI?=
 =?us-ascii?Q?QLv7oBbedRJ/mf93/f6OlbgP1bzDuphkjm4jrrunX4m3TEeo3fHXxXybx6EZ?=
 =?us-ascii?Q?Nn5GQNogyhgy1Zqw97D7M982sSqyBMoFsOvTobxdcrju3iteGCkDIl7WLX7u?=
 =?us-ascii?Q?zQNwV4s3eEtdpe5muQDGawg977t/f1/wRZ1r+aRbSqkTCNTCcOiFvhAGtHxm?=
 =?us-ascii?Q?sSpz0zVmS1e+v9HTSjKzg02XBOr3apJ+72foX6F8QLKVY90rI0bifGiqHdO9?=
 =?us-ascii?Q?/KM3BPDPk/DoaGyRU/WCSpbSDYMALcnWIGItMFqMd4nMdEZHkRl9ly7GJK5s?=
 =?us-ascii?Q?fmYR3IprZMXcBBU1OMMkQylJoSrR2dlvf6dUcIRHkPcIn3yjytFZOYc6Jnyy?=
 =?us-ascii?Q?FOWvEqlGxLZHPOuG3Cg2Qi1n+O7AO7yk4L+AM4v7EXsR3em9JE6Nh/4ViqZF?=
 =?us-ascii?Q?1+sebZr0+aAgLRQjJWxM4LjQfa6VRwlhXeMiozQxR7bE+IiCc0VfwUwcDSN6?=
 =?us-ascii?Q?ItYP5m0KM2ypRd9ngn4xsl3Kar8QzUUoc876as7bRRnlgCI69fWqC3zUjr05?=
 =?us-ascii?Q?AIRtAcM6QDlWGhA8H8Z/51Z+KG9/Tm5EuFsNnm82DHF30qIC8jRdzy/tEgc/?=
 =?us-ascii?Q?JRkMVmbmikuQMlST01x3R4LXvDXUq+wVc5wc+/4bdfWVovCaOYZ0R61Lu9Jf?=
 =?us-ascii?Q?v7hhvdWqg1w2KoiZIKDCswy/AqtcjFdRrwAHQw9WOjLg3dQTDLn9AAAy22eV?=
 =?us-ascii?Q?lWCTnQTBeFZL0tlPMvhAJK/Cgc1oDXNoyyKeEZM3ouKed18z6zjcGU3RyiAI?=
 =?us-ascii?Q?+Lmisj05s7RtAJltII7uxq0RMOijafeRq2erh8iOb5AU9VtY1MWY3ar5JWkA?=
 =?us-ascii?Q?QJUSuAg496iSark2YFp61vcOGQX6JQ+DKzpBfjfpZ6WhdUC1+L+WILAUzMsV?=
 =?us-ascii?Q?vh/eYGKnOFicAUfxlp5jNOtkaFJ3uIT7hymrCy0UKWSYmbfBZHixEoL31541?=
 =?us-ascii?Q?+ULKvmXatG1JgqwSY59djfCL4lu+yEBaGdj31gTsAc9Tnm/nP7xZBC7kzjQg?=
 =?us-ascii?Q?Gb/Ln3cqkz1/osthjwkcIJuxVpcF1ADZIYlpCG3s4k8k2sQqFqsgSiGbbVQQ?=
 =?us-ascii?Q?EGpb2pAbLkAiEA1fVEbNnaOtZtBMQijPX0yCgtcb+G0urGtljoYRvQgicRr+?=
 =?us-ascii?Q?bL0ywdSI63FxLj0qBe1D32lBA5Uow7RmdtIFDmJlDwH6Mq5KoKILJmwdOj+m?=
 =?us-ascii?Q?q+hGQopCY0M0YxlYNjnFLgt4D0tGOGSvl548/hx/1HEVYCfMZTqczDrsI3Eq?=
 =?us-ascii?Q?L1lZbZxz0Fw99YWlkK/m5nG+gzQRix+Bpm+f0QSXoYV2QCBAdaCVOQYp2LCw?=
 =?us-ascii?Q?zimWw6BkTlxVyTrBu0MNmV6BeRm13vAcAd7ia8shmn8jaa2Yq0YYTROPKQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 07:00:54.5164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a26192c-bf35-4348-38e6-08ddf9a5c631
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932
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

