Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D033C83F17
	for <dpdk-dev@archiver.kernel.org>; Sun, 13 Jul 2025 06:34:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 377FF402E5;
	Sun, 13 Jul 2025 08:34:43 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by mails.dpdk.org (Postfix) with ESMTP id F30FA4028F
 for <dev@dpdk.org>; Sun, 13 Jul 2025 08:34:41 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoR2TQV8q8QSL9jpE1miVlK3jJqLy/iH0RIozFn5hhgLEm94CVo8bY2kNh0GuqEZ0llXyBHSPA7N+thJ97vY+7fYHkoLx9QZc18AhoiBeRA3zN1kPmu7JSw4czl0Uc57vjoiuN1TZlUEetLVumKE7iiWFApVN6qX9oHuGtRkRsKOcw0E50okKDBPsKpscb5Jn+lweJNpoIQC6BWy13hnVKP11dYlB11wtni2/zg+uPQWTXDV6jfjTgr1f9yghEd9Ud9aF9KLCWvFuGli7OmwlpPMwbeZPbIloQNNqnqdwrJZ2eg/yuJlbSXMoMerCOpOC+IN9M0c2rsX1O5TqqH65w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfLvkQXjWzcsbY/fi2cHx/j47KFgSbAWgBvxqKh6aMg=;
 b=xSXIUjnWUmExooAxWANyn7SYV0sNaIQZ+RglGVIJeBr22+9NAttLF8Nksb0+wJn/D6Nd9CAoagif/FawrltKIznbUUt1eiE69sUgBORQ7WbV86rzVPfQ2DVZN1LCkj3C9qLnLe+O9NLOZXAR/b6Gm0okXnbeN+YOTnM3sFDJcrMGZVP53HUQbc3SveZxF2DejD7XwMs4N0JiAEP4z7fu67nMrJNnaIR+BWwDaX040ivVAIjA42S275hLLTGT9PyXuL7uMmuKUHRNfTJ5yZZciMmEhxAjWHVt3pEncvdCr+ruXaLf7TIlG6166xdGO4GIes//u9pho287RIkaOR8IGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfLvkQXjWzcsbY/fi2cHx/j47KFgSbAWgBvxqKh6aMg=;
 b=EVAQy2pfbgZSvOE9S8S/NR1PqBAxP/UEnSiICwKr4bIPv9IGbFdB8oZIu/JCMzucigLVUPLJIi+EiSvVdZ4QsikbHFYUe5qV9Rbojz1Qh7zMSPiJcoywFH7xZHyfA2MT89+yBB8NlYDgMkGaYOt90Sb02+jUhNTmSphe8Wg7Q1cVy0JTJdZBXG0XJmFHNPB220o7CPRuxQOoHwBgJCxiiKdndWPKuohxPr8BzJ/AyJCsmqCdwPA7ZuUo1lM4jjPNQJ6ge0APRmbHzwPbIEDmxn+bA7nEY9+IJyRi6Ofh8HOTW+QiJFxv2RDLFgSaFjGsihjbdVuGNwhMED541IIlEQ==
Received: from SN7PR04CA0229.namprd04.prod.outlook.com (2603:10b6:806:127::24)
 by CH8PR12MB9768.namprd12.prod.outlook.com (2603:10b6:610:260::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Sun, 13 Jul
 2025 06:34:38 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:127:cafe::96) by SN7PR04CA0229.outlook.office365.com
 (2603:10b6:806:127::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.28 via Frontend Transport; Sun,
 13 Jul 2025 06:34:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Sun, 13 Jul 2025 06:34:38 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 12 Jul
 2025 23:34:27 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 12 Jul
 2025 23:34:26 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Sat, 12 Jul 2025 23:34:25 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <thomas@monjalon.net>, Shani Peretz
 <shperetz@nvidia.com>, Aman Singh <aman.deep.singh@intel.com>, Yuying Zhang
 <yuying.zhang@intel.com>
Subject: [PATCH v9 1/1] app/testpmd: canonicalize short PCI name format
Date: Sun, 13 Jul 2025 09:34:17 +0300
Message-ID: <20250713063417.10998-2-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250713063417.10998-1-shperetz@nvidia.com>
References: <20250708083740.128610-2-shperetz@nvidia.com>
 <20250713063417.10998-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|CH8PR12MB9768:EE_
X-MS-Office365-Filtering-Correlation-Id: d2246a61-9854-427f-9ee8-08ddc1d75747
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CrAvhS18YwnFEgi/wtM4xanE/G02jt/1IJH10ibh5rLixhGsd0FrnNGt9NwU?=
 =?us-ascii?Q?pa971fTPCv3pqdMAX05HoDwtrCI2QPDUVObJnP63hK59d7p1NDasIgyHFXQL?=
 =?us-ascii?Q?1+8MX/AQ1XwUvqAP5ApIj7nJSn3G0NmG3KvhfQtKzOhU2SV8r/a20kqyQUsH?=
 =?us-ascii?Q?wMGPv36QLLL82yR1umKmDCy/SKZfwnfAPrynQ7y57UyxTbqNaVmh3l0BGWTF?=
 =?us-ascii?Q?RLesa/imBHVqIwg12KRyKkTKn1p09MmGLJnwHEw2V7NtLnlel74aMx4lJYDi?=
 =?us-ascii?Q?cC5pm//aFuBJVlvisPR1cu0wDO+8o/e/xbKHsIEr1ViWjyzLGwghi7PyfYWt?=
 =?us-ascii?Q?tWIt9LEP5l9353D1WFb4mdvzB7wj3z7o5r95G8FXEzUGwEolseVYA/5FXGe9?=
 =?us-ascii?Q?7zLSqs0mDiWjdVeRsE0r9YtPlUHT9XX6fJbdRVQKCP2Dq1S++Hs/jxHo4dRH?=
 =?us-ascii?Q?F0HujLYuupEu9/1ykPBYmEMysXikiAIgaXC2g3cjEQ4/tv1vRcD0mE68vRg+?=
 =?us-ascii?Q?kft0ixUMGJn7qESDuAI1voV6Ek3SrKpRpbFAhrHudCldGWEA4o0fjzWCVekh?=
 =?us-ascii?Q?oVwlL2dhCQyZ4fg13R0Z90I9UrbeB6bd+szd+hUp+vszwkuPkb+C60JOFApr?=
 =?us-ascii?Q?5tx5GUna9/EqvfrRyfB4soRLFu6y0xp1IBDz/Ev/CkOZIZ5pf0LO00QFjxO2?=
 =?us-ascii?Q?wSRyFV0W8vPpw56D5q5XlpO8BoQG5aDkXZ8he/MyUZZ1rvmE2tkvH2pXDpd/?=
 =?us-ascii?Q?M5P//d9iSP7IcBvsHbcjXqwv4nKGyXH0DSEdTHpxlmoSxXNBA7hubYeV5oS0?=
 =?us-ascii?Q?28C+617i+WJ8kv8BPwYJKS8o98dCEg7lSVSdCjemwJ2YeV+3n9hbFIPFK324?=
 =?us-ascii?Q?pw4XknTvZASS6112ZFeIchOK/OiqNz7Zf9ozokPccuWU9abL4/B8MB4j6HdL?=
 =?us-ascii?Q?Glg33bzA7EkwYBGW1Osdq2bTMcbSvwnMxhUfbhdkq4ju4kexF5tb330k6WES?=
 =?us-ascii?Q?5AlBpLNr1rLRMqpWjEA9nlHdPfDJ70FrRAb8bb/CDpMGqM3YBg77jGr6MVRf?=
 =?us-ascii?Q?Nera7YU95X32eOkImyie/+CJwC0uLgoZoTjvhDIrqN4+6BLr0GdWg/Ofn4vd?=
 =?us-ascii?Q?VMR9yN6aiPDP+w8fiQ1Uq1DOyldVyYfobFbvDNCquiX01ytTXPSfuXJfGI/H?=
 =?us-ascii?Q?Fkh7I9i6ZO3jcLdlbAGjPU1a4hOe3FhUL/6RLcBrfRN+dwqvffojpPjZ2roG?=
 =?us-ascii?Q?p5mEA+TvVk+XiS96289l+6IeKMKURgPwYALa/ZH37JgKXY7vzK9uluVcfBvC?=
 =?us-ascii?Q?2JC9npr2Syv1vWUkIpmvZ6L5Mh3+OIPkn7zjtQnyOUzvxogUoZnUKeW2ZBY1?=
 =?us-ascii?Q?5vPrg9HoB93/ESZDSgfbPkw4xc5p8gq9GeeP3+9aZpNCrvbp79MVfT2Q5RQn?=
 =?us-ascii?Q?MoRXGVsDKBPrVP02vSRN8H+c9u4rwpEV4MMNX8Wn85BmKTplA8FE9WjXDukI?=
 =?us-ascii?Q?SXd1YtwaPhUSqil6FI6E+aNW/jrqsIUFANuh?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 06:34:38.1426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2246a61-9854-427f-9ee8-08ddc1d75747
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9768
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

when providing short format PCI device names in devargs
(e.g. "08:00:0") it is converted and stored as long format.
however when attach_port is called from testpmd, the user might
provide a short format, which will be passed to find_device with
a comparison function that simply compare strings, which will
cause find_device not to find any device.

This fix canonicalize the user provided string before it is being
passed to find_device.

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 app/test-pmd/meson.build |  2 +-
 app/test-pmd/testpmd.c   | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/app/test-pmd/meson.build b/app/test-pmd/meson.build
index 000548c261..83163a5406 100644
--- a/app/test-pmd/meson.build
+++ b/app/test-pmd/meson.build
@@ -34,7 +34,7 @@ if dpdk_conf.has('RTE_HAS_JANSSON')
     ext_deps += jansson_dep
 endif
 
-deps += ['ethdev', 'cmdline']
+deps += ['ethdev', 'cmdline', 'pci']
 if dpdk_conf.has('RTE_CRYPTO_SCHEDULER')
     deps += 'crypto_scheduler'
 endif
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index bb88555328..569b9e3113 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -47,6 +47,7 @@
 #include <rte_ethdev.h>
 #include <rte_dev.h>
 #include <rte_string_fns.h>
+#include <rte_pci.h>
 #ifdef RTE_NET_IXGBE
 #include <rte_pmd_ixgbe.h>
 #endif
@@ -3407,11 +3408,35 @@ reset_port(portid_t pid)
 	printf("Done\n");
 }
 
+static char *
+convert_pci_address_format(const char *identifier, char *pci_buffer, size_t buf_size)
+{
+	struct rte_devargs da;
+	struct rte_pci_addr pci_addr;
+
+	if (rte_devargs_parse(&da, identifier) != 0)
+		return NULL;
+
+	if (da.bus == NULL)
+		return NULL;
+
+	if (strcmp(rte_bus_name(da.bus), "pci") != 0)
+		return NULL;
+
+	if (rte_pci_addr_parse(da.name, &pci_addr) != 0)
+		return NULL;
+
+	rte_pci_device_name(&pci_addr, pci_buffer, buf_size);
+	return pci_buffer;
+}
+
 void
 attach_port(char *identifier)
 {
 	portid_t pi;
 	struct rte_dev_iterator iterator;
+	char *long_identifier;
+	char long_format[PCI_PRI_STR_SIZE];
 
 	printf("Attaching a new port...\n");
 
@@ -3420,6 +3445,11 @@ attach_port(char *identifier)
 		return;
 	}
 
+	/* For PCI device convert to canonical format */
+	long_identifier = convert_pci_address_format(identifier, long_format, sizeof(long_format));
+	if (long_identifier != NULL)
+		identifier = long_identifier;
+
 	if (rte_dev_probe(identifier) < 0) {
 		TESTPMD_LOG(ERR, "Failed to attach port %s\n", identifier);
 		return;
-- 
2.34.1

