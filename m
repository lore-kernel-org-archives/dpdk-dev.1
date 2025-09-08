Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500BDCA1016
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 16:35:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57F7840615;
	Mon,  8 Sep 2025 18:35:53 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
 by mails.dpdk.org (Postfix) with ESMTP id E941340608;
 Mon,  8 Sep 2025 18:35:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGn9uKxc/Wrautifu12O9J6xP99Os92UsjFDwd7upwwfbbZh5OnEoB18bqdI2L+4rE7TzVRyverrTtK1ZRny4gBI9ibee1tBEgBuSLefThiNwpFNgpeu2rR6ecLKdVoy2ikysUoQcPk3gd08zJlrAqKatWeTKGTw73BIz/5dpPK0d/FjB/Nvfsqr4zxBLhiKJJyYHLrSaEj9190f+2cji8Uph1a81GdA0bDSuK886Q+TS0wGZLF6tJzdswa9x4RTn096PZ3vGCLcm9A/4g6FBQLQgcsUI0f5EEPnFAWgjGV9CTwhwNQUKA846JrBiLBrD0RSbd2V8mqAW8EFuMUmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPQXRcaHHz33ltCkVvUpQpedvEFIcK7WRt+gYWDknTM=;
 b=HNgCDgJeP4qhXcmh6lM5xPL875FTre0T9bUtDwnkfSP/NzO8cNhzO7UuHukwoExVMYS6/5jDPM7Di96oL57MDj6XPSe4X2EOsiRhpyKT67JSFdHVex3e/P34QcV5Z8ntgGynKMTyOrMmz653vxIwCGWJpwyWELaSGIUDcL3b5ArCmJSfQc6JjSoxnFF53CaMBbI2wx0oauNg6RcF5YTuTJPJYqgCz9AYltv6Ae1pSPytiuspUTkBUX3gPII5rCPAbMlCw/xnUTNSp40wzUub83xYwLHV54gkI+UjD0NpOAbSCNwCABNKQaVZQJbHBMVUgC0HFFCELvkbbkPx2P1lPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPQXRcaHHz33ltCkVvUpQpedvEFIcK7WRt+gYWDknTM=;
 b=pNBcJDrbjFFamhDtRSAC+wklyROgdJ5eqAyr56V/h61cP3pOLy762r9wMOL4FE4YnnYtTemN0b9HWBX/RrNlUCjurgnPrZ//nZLXYXRU/bONsXUQLyG9b/2OiDC12+N8AFx5UJkVVldyknTsK4fvzzqt9up+k2azTeJd+7q7pzcLCcT+xauQkni4xBTA9/ZETfJJElHbaGmu5N1I++S6J6xIgR2mQnK/pfpr0Ww9pJovgTLlWaqq4vIEW57aniLNh0xye12u/es6dSDSbmGm3p8eOZxgKjG32JX8R+HvOhaokljCwZemLFYLmam5GI4nLF90FqZsteQWxQ33jGQTeg==
Received: from MW4PR04CA0270.namprd04.prod.outlook.com (2603:10b6:303:88::35)
 by DS7PR12MB6008.namprd12.prod.outlook.com (2603:10b6:8:7f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 16:35:41 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:303:88:cafe::53) by MW4PR04CA0270.outlook.office365.com
 (2603:10b6:303:88::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 16:35:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 16:35:36 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 09:35:06 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 09:35:02 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 8 Sep 2025 09:35:00 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <thomas@monjalon.net>, Shani Peretz <shperetz@nvidia.com>,
 <stable@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>, "Dmitry
 Kozlyuk" <dmitry.kozliuk@gmail.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>, Alejandro Lucero
 <alejandro.lucero@netronome.com>
Subject: [PATCH] eal: fix DMA mask validation inconsistency in IOVA VA
Date: Mon, 8 Sep 2025 19:34:55 +0300
Message-ID: <20250908163456.420268-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|DS7PR12MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d1054c7-aa3e-4ae8-b8a0-08ddeef5bdf9
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y5DQY7vvHW1AQ8wPQU6QT0LC9/cV4oTu5UnEFoZBfiteQVF18gE920z0wQDy?=
 =?us-ascii?Q?M4rDSSGoymJu+roKIqAIqffMWHutmT6vY+mMW31Ed8aUSdXqEvHBnnmKHgTw?=
 =?us-ascii?Q?Stdn8TxWRCzi4v/CmmQbXJ8JOdPoNcfdj3ieGC5Oso1mHhfAoEdDLxS3YEyB?=
 =?us-ascii?Q?+mSk50vVK8ByTVJYKEK0SkVUdZ4H7uircQyuXAsw3x5NuIVbxmjyVa8nbr9x?=
 =?us-ascii?Q?psdyf7MlsY3Laf1coV0YFbxTyOKZKBp4IQ4jc1Ckp1BMwx17cxZmOkphtcNc?=
 =?us-ascii?Q?/ZIDMhZZIdo+7aEAPeS96oqRwmYSINvGCV2Qo8s5xljJ+qeoZK2bDqew4ZpO?=
 =?us-ascii?Q?36qSat/vB9snJkM6GvhWci6lYCzL9UkcPsTUqJbinPoUNQ0XDN37qCZDMPUg?=
 =?us-ascii?Q?npfHpy5T1tjBeo0Pz9klAaH6YmBHyHi6Dafpan6NnLRn87CdBPJyyecFGJdQ?=
 =?us-ascii?Q?v1UwdKhjBVM349caUdAdJYks7zdguvUAJpSdI4P+An+oiaPFL1oUHSjjkzjW?=
 =?us-ascii?Q?uSwcU2OkTVdqB+YSsQ9iQVcbUYU5lkzeH7Foa4JzP8N/e058jQX7B6kEUd6J?=
 =?us-ascii?Q?v74bEUe38CAiw1HpjpqbppjHXyjtA7BiD79MF50I+M0PWilCED27hfc0kzVm?=
 =?us-ascii?Q?E+0vt9JYapbrb3OyhFdeDTHxTOc/t2FtZdU5BcAl9VvPYPxCKF5omOOfB7ls?=
 =?us-ascii?Q?eN1ouAJr5IVy/XFPHmDwzabbkxy/A/zVsAVAabBZE3i4R48v6pTFeJ9fTLUH?=
 =?us-ascii?Q?4GmrUoy+NsgfND3EbiEOWojGR91PNWLNaTNHVqCLhiD5BBpkr8LDSGXv+VSc?=
 =?us-ascii?Q?Hu0ql/HGbQa0LiB9DNV3kvt98ltqvTn2pVykZRW73I8PXFwRG4yJ42S/1Jow?=
 =?us-ascii?Q?9Flt88odL5bq56YzJHzlZCQFoXCjRUx1j3hbCtF54BN/5ZriHen3Wl9iO1na?=
 =?us-ascii?Q?L+LQLucbSeGxbSO5irGow3hfrs3wj73rYUfWS42iPo7PH5Z3KuHNEHUw+mL+?=
 =?us-ascii?Q?fXe8HvNIIOZAMAzxnORox0i3tnNIPTuQM4a8gIUDnNNPEMlkLWvSiRWlfQg2?=
 =?us-ascii?Q?Ct62+m9lwMDE58Fv0765d6S+O87Av6cTaFdiuGYxdpKSTEkiyxCm73QHFYpm?=
 =?us-ascii?Q?mx5cQDN0shrG0ygxAKlnacDddts9ynjViThGjP+59T+yYcsJ06AB2RfLrovD?=
 =?us-ascii?Q?a+dXlXB6cFz7HU/F0i1vta8/1/zuSkasu/4w8D5ncbcYq9bxk7n805ao5WwT?=
 =?us-ascii?Q?PH/8JrYsd4CyOpTgpyy4U3W0E1dQaAFZBCqR4lyUpNYhDOK3biKiI7sFId8/?=
 =?us-ascii?Q?vfxBK4fzvbybl3UpN2eScMryDjfUWYLIYeLAkyYJ87WK+xHk0A4Mo5Mg8VOR?=
 =?us-ascii?Q?7/EKHvHF/YWT/1dw2MoqPFsAfQT8qkeHIcrnTS+930P7e/TenRNntvTSj6Yp?=
 =?us-ascii?Q?q9sC5uiEmMnyJ/UCkaBbZYIbVflI566ogoJZs4xfL41qyCmYM9niUbFCyGqp?=
 =?us-ascii?Q?1EqG3Y5QymzzaZ8JliDTIm8n1DIcV38/smge?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:35:36.4091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1054c7-aa3e-4ae8-b8a0-08ddeef5bdf9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6008
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

When --iova-mode is explicitly specified in command line, DMA mask
constraints were not being validated, leading to potential runtime
failures when device DMA capabilities are exceeded.

The issue occurred because rte_bus_get_iommu_class() was only called
during IOVA mode auto-detection, but this function has the important
side effect of triggering DMA mask detection (e.g., Intel IOMMU
address width checking via pci_device_iommu_support_va()).

This created an inconsistency, when choosing explicit mode,
the DMA checks are bypassed, but when choosing auto-detection mode,
the constraints are checked and enforced.

The fix moves rte_bus_get_iommu_class() outside the conditional logic
to ensure it's always called during EAL initialization.

Fixes: 4374ebc24bc1 ("malloc: modify error message for DMA mask check")
Cc: stable@dpdk.org

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 lib/eal/freebsd/eal.c | 6 +++++-
 lib/eal/linux/eal.c   | 5 ++++-
 lib/eal/windows/eal.c | 5 ++++-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index c1ab8d86d2..0f957919d3 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -670,12 +670,16 @@ rte_eal_init(int argc, char **argv)
 	 * with a message describing the cause.
 	 */
 	has_phys_addr = internal_conf->no_hugetlbfs == 0;
+
+	/* Always call rte_bus_get_iommu_class() to trigger DMA mask detection and validation */
+	enum rte_iova_mode bus_iova_mode = rte_bus_get_iommu_class();
+
 	iova_mode = internal_conf->iova_mode;
 	if (iova_mode == RTE_IOVA_DC) {
 		EAL_LOG(DEBUG, "Specific IOVA mode is not requested, autodetecting");
 		if (has_phys_addr) {
 			EAL_LOG(DEBUG, "Selecting IOVA mode according to bus requests");
-			iova_mode = rte_bus_get_iommu_class();
+			iova_mode = bus_iova_mode;
 			if (iova_mode == RTE_IOVA_DC) {
 				if (!RTE_IOVA_IN_MBUF) {
 					iova_mode = RTE_IOVA_VA;
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 52efb8626b..3a0c9c9db6 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -1042,10 +1042,13 @@ rte_eal_init(int argc, char **argv)
 
 	phys_addrs = rte_eal_using_phys_addrs() != 0;
 
+	/* Always call rte_bus_get_iommu_class() to trigger DMA mask detection and validation */
+	enum rte_iova_mode bus_iova_mode = rte_bus_get_iommu_class();
+
 	/* if no EAL option "--iova-mode=<pa|va>", use bus IOVA scheme */
 	if (internal_conf->iova_mode == RTE_IOVA_DC) {
 		/* autodetect the IOVA mapping mode */
-		enum rte_iova_mode iova_mode = rte_bus_get_iommu_class();
+		enum rte_iova_mode iova_mode = bus_iova_mode;
 
 		if (iova_mode == RTE_IOVA_DC) {
 			EAL_LOG(DEBUG, "Buses did not request a specific IOVA mode.");
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 4f0a164d9b..2502ec3c3d 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -348,12 +348,15 @@ rte_eal_init(int argc, char **argv)
 		has_phys_addr = false;
 	}
 
+	/* Always call rte_bus_get_iommu_class() to trigger DMA mask detection and validation */
+	enum rte_iova_mode bus_iova_mode = rte_bus_get_iommu_class();
+
 	iova_mode = internal_conf->iova_mode;
 	if (iova_mode == RTE_IOVA_DC) {
 		EAL_LOG(DEBUG, "Specific IOVA mode is not requested, autodetecting");
 		if (has_phys_addr) {
 			EAL_LOG(DEBUG, "Selecting IOVA mode according to bus requests");
-			iova_mode = rte_bus_get_iommu_class();
+			iova_mode = bus_iova_mode;
 			if (iova_mode == RTE_IOVA_DC) {
 				if (!RTE_IOVA_IN_MBUF) {
 					iova_mode = RTE_IOVA_VA;
-- 
2.34.1

