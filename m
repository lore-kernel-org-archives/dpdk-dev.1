Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BADCAC59A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 06:48:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6901B402B7;
	Thu, 18 Sep 2025 08:48:21 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011052.outbound.protection.outlook.com
 [40.93.194.52]) by mails.dpdk.org (Postfix) with ESMTP id E6F7D4027A;
 Thu, 18 Sep 2025 08:48:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzZNj6Zx/kbm6bzdRZQKjd0h0YSprlCtpA2bpCimZK1a6nnkSoR4rVFL3UAJApTLnr8/IXL7UH3q0kLdvtT05hfH1TuWRpuWgVvs803pFTkaEDcq96zaCmBEzlkozUbCN9s/cGMcOQOPv2t3tY5+NI1ikDTwhtUcqzDAtqt1IVw82kVgN74EHSxApzIycV/PRdi39o3siasVwKIMi2d3HJxk1+SnJc2twygnLsUl16nIFJXDEnlqNLpasONvT2XoDfyEuezXHYgS0wkuESCzzOpgSb8xsv+2uWxzNvSqzVnvHPeVnUivH7qFFwWQ31OUKPZn4wblAQW21YerKjRdGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPQXRcaHHz33ltCkVvUpQpedvEFIcK7WRt+gYWDknTM=;
 b=arEcSvDQA9FeKGxYPq0XSuV4fcMTu0kzi5X3Ti0jLm7AX9O042szjBpzSoln9qsH+OqH10iLfPZ/0K+3d1FzOiNfscyYnEmkg58EQP2gCMtCVUCdlOrF4tSjeqKMYfkni+EUfHaOnWXmA+xu32qpZ8KxaYjd9+9vvIAKzjpstdDMQ3bxK7Ih8mJisft+4oZFgOmoKTPh57osrOdn331ce9C3/H0aKBcWG648XgS0aV6ZKyXlJ13B1YU3m3f9HDZnv/NV8EMwOQ0Us3mZDMQi194x7CZq219fHXV3qI1M6BBf1jLf3I/BEFDmpG123HPVvEg/iZaJ3Ezt7+e0o3/f+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPQXRcaHHz33ltCkVvUpQpedvEFIcK7WRt+gYWDknTM=;
 b=DaXpCqL9Ls8Ke3GCPsjrpaCxfBDpoLhQ4kXdIlZq5w1uNXWQZfptGeujY4IwqDpjZ/vrD454Ay0ffqNfdgD0NjNP31pYni5ZBetx4v+TIXHYICXfN1+rnZz+BdIrZvMzmL8ljiZ1UkiAikjHDTT7Y+sO32GhwdbCrgF8nnZGMj8oM8vxOcBu+DpfRsodRBoB+T66zo7Ci1tGtV19GCt+Us5VaLxXeI18e07M9vegiAUtQk0qkLRpv/1iTgDSvJ9P1DaL1mK4wbmNCE125rQNqO290bxYMB0kVHOOIB7/AmKh6u+VNW85QdzJu3MzvXJm0S+T9drxDMlllv6L5CQP7Q==
Received: from SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19)
 by SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 06:48:13 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:d1:cafe::99) by SA0PR11CA0104.outlook.office365.com
 (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 06:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 06:48:13 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 17 Sep
 2025 23:48:01 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 17 Sep 2025 23:48:01 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 17 Sep 2025 23:47:59 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <thomas@monjalon.net>, Shani Peretz <shperetz@nvidia.com>,
 <stable@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>, "Dmitry
 Kozlyuk" <dmitry.kozliuk@gmail.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>, Alejandro Lucero
 <alejandro.lucero@netronome.com>
Subject: [PATCH v2] eal: fix DMA mask validation inconsistency in IOVA VA
Date: Thu, 18 Sep 2025 09:47:54 +0300
Message-ID: <20250918064754.6116-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908163456.420268-1-shperetz@nvidia.com>
References: <20250908163456.420268-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|SA1PR12MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: 61bcf294-c658-4f66-0831-08ddf67f56e0
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ck3BvkVJyg8/xjJuUvJzd8BBHSE94FP21or+UKAchLJxbxFyWnuGcEsMxSSL?=
 =?us-ascii?Q?YyA0RaqW5CPQOs1lLW0y/iERPN6EhcrPyYmkUL8GLuFdkr/pzTDsKeJUr2CJ?=
 =?us-ascii?Q?LqTI7Sdsaa75st/+8kWjUDwrLiVzw6+0szYNK5HJMhCdNcgyIjQsbW+M2ek3?=
 =?us-ascii?Q?mDMrIUwuPCJ1Bd6ciTMZZZhTjQS6OQ3c8ZxnLJWouwpZ3yElAULPoemuDBZ5?=
 =?us-ascii?Q?MKkY619aJmm54MhB1ESmDoiH0ByCb1qho8HcH/xQFWb+CgWGhRLZlyKobaw2?=
 =?us-ascii?Q?JfEKjdda7kJJgEYnCV8Lc/2gRsPJP7/T/sANuvwAblkEdETqJnW5vrR+GT5I?=
 =?us-ascii?Q?JlI5SD4SJzUjpJpUQGsuc8KfL1wtujUCuS9CopQqTNVZ+imCAlrsaSPVHNPQ?=
 =?us-ascii?Q?qfUZMyT39Eliohvij+1/7ULfXA0ohNsLv5hQQRi9K9cutkb9G+V9tIrHzxQH?=
 =?us-ascii?Q?oL8O1f8QR5cOh/aA06M4NgIT1QEsAll6AoEh4q8GXDwhud1QKi3qQ7Oc3Os9?=
 =?us-ascii?Q?gmqVaBAH0VVQnL1oNPMRSNnfvbryOst/ij13M04zbYpjVwrqcEGTL/nl4mcv?=
 =?us-ascii?Q?rojWMMsrEb6xs752DKhw4daKnQASkIkHAXnba1unF7Zch9MLIGEv1hTFJi1C?=
 =?us-ascii?Q?SmoLY/7UVAStWuvDTaVexHnKKhgvLCJso2fYqyGmH9nI1XaIr+yispQYRibz?=
 =?us-ascii?Q?cMQjIoruESiI+8dhBTzPPV+Ww1cAnEbrK3iI7N+0nUFau9PqoSRopKY3TgPP?=
 =?us-ascii?Q?/MOD3qmS0cR+rWpfxFSkq0AKm+6T9vNb3gu0438HpjADZ2TC69Naoubfebcq?=
 =?us-ascii?Q?aY31akoUq/B0PGtB0CmhGtR50KRcdihstRdPAwGaqMofunl7nVGb7VVHdffU?=
 =?us-ascii?Q?tvT8YF5oqKpaE3xPYd9+Q9gDUeeLVNzHmcOjPTFtEio1iD7BojG/6iqt83JO?=
 =?us-ascii?Q?JZH7/HkiOhJbdmrhpMW7wwxTndQ0CWJLwhjgOIZCmooHCohSpFWhBHkLdmJm?=
 =?us-ascii?Q?OQyGp4bGVIkH8atLcFjN4So6N5TCQNj4vAdAp5UJDJ7Ol1iHy/iODPmfMTTW?=
 =?us-ascii?Q?b3JdMDwfhgACWzhSvV1nolJkxgc/OkQx4l1/HDavP5Oezc9hNfF5hR984ErQ?=
 =?us-ascii?Q?B5SaQjgNNOgb+0m26kAtzrdpBtZZVUQRJlt6Ux0azm0+U03lKG+citJWK9+U?=
 =?us-ascii?Q?PsPCXZ0yGRMgpsUvKzhRF9JtNBJ6nlBzrFuxD0Ao6f+CGH3qVMUDjLt2OCRV?=
 =?us-ascii?Q?tCa094KPLkS0jBhyjVp4ZXV92Ktukm+45GnvbqTIr4cEaivwUrwLE8sCB/bP?=
 =?us-ascii?Q?TYr5FFay1fYzUxZApppVfCkrMvkQIdDtgcEK3hMy1ZoqjbxasR89djGVAvZd?=
 =?us-ascii?Q?3KHrgg2s676jYUWZDiOfIO3u7v1oyy+8ynl2WckfXrernocBHJCzXwgM1Jy2?=
 =?us-ascii?Q?SntlPYKvN+k5VUTWIKZttEJ7Y/CQWjfgFn3OhgiQQzatWB6XS0F+echIQb7e?=
 =?us-ascii?Q?FmgJGkUu4pWTAa2BSY+MpY0vvnjZva66Odt4?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 06:48:13.3970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bcf294-c658-4f66-0831-08ddf67f56e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699
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

