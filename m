Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A10CAC597
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 14:43:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 767F540674;
	Mon, 15 Sep 2025 16:43:40 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013021.outbound.protection.outlook.com
 [40.93.201.21]) by mails.dpdk.org (Postfix) with ESMTP id E78A940674
 for <dev@dpdk.org>; Mon, 15 Sep 2025 16:43:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkPkeMIycVkmYBUvzIeCACM8MBMCOGabCYLyaG+vykIAWMw6I1mqeyVGGTbvdt3jPPhG0Dx9It3cNDk4lTdllML9VY/hRiykw+ylV5d0l+WAlRiLs7WPqXJxeVs6J8Lb9KphwdYg6IRjStKBqJybuiOF3s1lFoyvKxP6Cdy1hbPq2CU1jw0uJZzc8TDsQ3iwhYFGoHTl+EArJ448mHYrr/j1RJ0LB+nRsad947c65TjS2tfWZ1eLTYiMEpv44HJ0nSAWDG/cZKPqah+XyC1W6fTmtHv723hyqFNfqMQKN5S5t0d8xiYwhLbjoTik2FR/h5hkM/5axA0WaM8wFURwGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9t1k2+ILCxso3Vi4ocYMJfYhu0w8G+wa9Gf+KsjmQMw=;
 b=E6G5ohewt4s8i+el6+Q8diDGf7CPHYj8s/WEqpNbuGSSg6JpbTdKuzpGVieVXHrYkgimwvyiXKggx6y3BTfCVOyXUhQlcI2Ad0KEetZhO0WfZqAzKi9G47I0r+lxYUnQw/kD5AiKfO2vRAiHHzwvSHEOxcMVltpHjg7rdhUVW9WeCmWnIfeJ1K50Mtd5UHSWsUYG1baTChE2ry1lR7T1FtA9YFS1L1KxvZo7utOq/0NOWLKLX4Kl+AMDTVdjvDrP4AC2ic21hyFOnLlI/+TpurREyiX8MS9fvvpesae8lOXS70JyniqLg5enc9xj5U81X1C6ruYIIqP0lFwB3LAIkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9t1k2+ILCxso3Vi4ocYMJfYhu0w8G+wa9Gf+KsjmQMw=;
 b=CmJR3o4vLxm42yEtz2dGCxuBGM2Ec+5Z5D6a32cXoSax8OEA5TmBQcDVePy2sSE5B6RzdLNLlKjg4OvW9FitvNeGxUM0A6Z/svs0MvCuziOcuk4VBi4412a30M4mjqNCahKuLIX6iSXlb140hmx4HHQ0zhzXv0V5l0+z4z+wVe+STdWK8hduzk2YUrbaTr3C49Xeejs4+06nmA00al5T/DgXIhnVFnYLGY9blD3pQGYz3s1Co670AqVd6fy3XWNLI7E59uNIjylWS9QVXiTQjnDGKRMPXhF8QebcpFX9lwmdz92szdfZgshgYCSFVPY5xgWGe1nu9DR5rq1ZlpSnYA==
Received: from SA1PR04CA0006.namprd04.prod.outlook.com (2603:10b6:806:2ce::6)
 by SJ2PR12MB8157.namprd12.prod.outlook.com (2603:10b6:a03:4fa::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 14:43:30 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::f2) by SA1PR04CA0006.outlook.office365.com
 (2603:10b6:806:2ce::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Mon,
 15 Sep 2025 14:43:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 14:43:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 07:43:11 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 07:43:08 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 eagostini <eagostini@nvidia.com>
Subject: [PATCH 7/9] gpu/cuda: extend NVIDIA GPU device ID list
Date: Mon, 15 Sep 2025 17:41:34 +0300
Message-ID: <20250915144137.54858-7-getelson@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250915144137.54858-1-getelson@nvidia.com>
References: <20250915144137.54858-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|SJ2PR12MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: dc03ac52-5fd6-4f72-b8a9-08ddf4663cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MUHQTDTtz2bQvjd0cdOutEv22sNHnOccSCMJqzvwt5wW2RA9yiS6Z6qIcVAu?=
 =?us-ascii?Q?bV74BWOrD90Axu4+8JO6qn8kSOoOM/l+fGJN3uBhUbpdet3hf2hbawdl2Pd9?=
 =?us-ascii?Q?hBekg+ndVCq+OYM33WdjXieFlLEYHV3wCIh4JyiGrgJhFWTZ2kho5uO4MOeJ?=
 =?us-ascii?Q?/dmJF/ILuOom5R2ZJitKFeTp4R1vN0PJOQJ+OpMTJv74SE+GEOSTbrGDfwFg?=
 =?us-ascii?Q?Di0lIH6J2L3oqEZselZuH3MpkKBXJtdoCFJzAIa+jA6UT4iThgaBfNwYGTCu?=
 =?us-ascii?Q?OMBRyNF/i/Zoe++8flZiqriyN6Bi6p8WGHogAQ0eMOoL1YLI922L+I0T8v8R?=
 =?us-ascii?Q?zRWEmdkYhombOK63Nyz5p0EFFqt8zMmHd/wIn9gS6BLS1wCodRKOTo5Hh099?=
 =?us-ascii?Q?aU/jm30d8TjesWvO6skXdVGMc3UP9hvsgAeegfWWs3P6oW55/UPJHLYBTB+u?=
 =?us-ascii?Q?bqruU73qGXChUzCA+rTCzfQo0jcZco2z5PfKNoZXW8d9Ult715kh2Cj+m6Qh?=
 =?us-ascii?Q?9ve6YiJOBFtO9OJaPrUcAIBA4I3Wpi7xoyzkHwieyAEOw6ltc0y4eWmqTbdn?=
 =?us-ascii?Q?By9Af8gnQV+mWlAAvPd4JLs9cZijfK4qGmIqygO2Zd0l9koiOeX2aBQB2BgR?=
 =?us-ascii?Q?PCv9BzxqSziKE2pAQRCgfe9eUfmK1k+o8MUurRgoVRlu42C5gEjHLwQVMz8u?=
 =?us-ascii?Q?i1m/BD1wclDbpS4e3eqEG+3cN3gejhDRHjBc7f+w2GGstf3h0+X/fULtaA/4?=
 =?us-ascii?Q?jOmcbrltQYNkaTSpvTJL3zaOau4P49ycWFcWDWHpwIVMMLbxiG0cV/UgnPJI?=
 =?us-ascii?Q?jXN1CUtxR1ODIHdwU03VoTotOoFMsiZJMqY1pRa/6APKuIdvcu+PBBrj+nfY?=
 =?us-ascii?Q?ZHWxbyaiFtpES2vMABKLakLeLyKaHf1RrDQRj8684meYtH0KFo++susYcVyP?=
 =?us-ascii?Q?aUnfrLSC7mh5wpc5MW2BHqKmXWXwWlWOh5pJD3Ie3pyeGsECnEHI904NQHZW?=
 =?us-ascii?Q?TTlRLy7YTF6bz7usENoKhgP9Bg8csHJk4qwKoF/QBTDNX+PQJzK5Nw1pMI8a?=
 =?us-ascii?Q?vtUJ+j///NTMg0gqhvcYy2+dv8PfmDy3/IgKTMj7YvmxZmtBxF9t5pO5RUyH?=
 =?us-ascii?Q?eJp0SYyCiv6crAZe9fCQbwlnAWMTkKujYndQ+e6O7fqZl3ZC63iFOzDlA1SV?=
 =?us-ascii?Q?Q3mEm4gV+Ee5JsZZj4UzOz86bzKCtmbqvBhkNQOiIDnk1WNObFWqxYLswxOv?=
 =?us-ascii?Q?ZsYG1ifqVbb6l6s7fwrJ2FRA1IltoA4+6cRSvgzpb5SVkaNb5gmnfnHGSXLd?=
 =?us-ascii?Q?9n2v7eZcVs6BQexkc4hYOBcEKxaJ+aiaRNjhW026yvIGtlxiHtFgd4z+8OCb?=
 =?us-ascii?Q?Hsl+pHOV4k+M154Zf4MxPMWdy5J4e2VUa44FHx0A7CNt1GbhL0LH1RFVu5Ho?=
 =?us-ascii?Q?Q+DJxkIv+QA4NlZLg06pcHcdNs/WbB5BvFT2ubE7NPN9+ZPf6ThZ3K8bgifz?=
 =?us-ascii?Q?LIJ7DqDP/kchreaxfPVpWQlS4suAXSF6nep0Tb5M2dCdwoqGZ+fuQyNsWA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 14:43:29.7077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc03ac52-5fd6-4f72-b8a9-08ddf4663cac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8157
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

From: eagostini <eagostini@nvidia.com>

Add new NVIDIA GPU IDs taken from public driver list.
https://github.com/NVIDIA/open-gpu-kernel-modules/blob/e45d91de0224e17a6bf7c971d8f165090b3c07a6/src/nvidia/generated/g_nv_name_released.h

Signed-off-by: eagostini <eagostini@nvidia.com>
---
 drivers/gpu/cuda/cuda.c    | 240 +++++++++++++++++++++++++++----------
 drivers/gpu/cuda/devices.h | 151 ++++++++++++-----------
 2 files changed, 264 insertions(+), 127 deletions(-)

diff --git a/drivers/gpu/cuda/cuda.c b/drivers/gpu/cuda/cuda.c
index a94c4baa64..fb8aaf67fc 100644
--- a/drivers/gpu/cuda/cuda.c
+++ b/drivers/gpu/cuda/cuda.c
@@ -65,35 +65,79 @@ RTE_LOG_REGISTER_DEFAULT(cuda_logtype, NOTICE);
 static const struct rte_pci_id pci_id_cuda_map[] = {
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_A40_DEVICE_ID)
+				NVIDIA_GPU_M40_24GB)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_A30_24GB_DEVICE_ID)
+				NVIDIA_GPU_V100_32GB_SXM3_H_DEVICE_ID)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_A30X_24GB_DPU_DEVICE_ID)
+				NVIDIA_GPU_TITAN_V_CEO_ED)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_TITAN_Xp_COLLECTORS_EDITION)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_GPU_V100_SXM2_16GB_LS)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_GPU_V100_16GB_DGXS_DEVICE_ID)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_GPU_V100_16GB_FHHL_DEVICE_ID)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_GPU_V100_PCIE_16GB_LS)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_GPU_V100_SXM2_32GB_LS)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_GPU_V100_32GB_PCIE_DEVICE_ID)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_GPU_V100_32GB_DGXS_DEVICE_ID)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_A10_24GB_DEVICE_ID)
+				NVIDIA_GPU_V100_SXM3_32GB_H)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_A10G_DEVICE_ID)
+				NVIDIA_TITAN_V_JHH_SE)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_A10M_DEVICE_ID)
+				NVIDIA_T1000)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_A800_DEVICE_ID)
+				NVIDIA_T600)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_A100_40GB_SXM4_DEVICE_ID)
+				NVIDIA_T400)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_T1000_8GB)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_T400_4GB)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_A100_PG509_200)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
@@ -101,23 +145,39 @@ static const struct rte_pci_id pci_id_cuda_map[] = {
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_A100_80GB_SXM4_DEVICE_ID)
+				NVIDIA_A100_SXM4_80GB)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_A100_SXM_64GB)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_A100_80GB_PCIE_DEVICE_ID)
+				NVIDIA_A100_80GB_PCIe)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_PG506_232)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_A30)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
 				NVIDIA_GPU_A100X_80GB_DPU_DEVICE_ID)
 	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_GPU_A30X_24GB_DPU_DEVICE_ID)
+	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
 				NVIDIA_GPU_GA100_PG506_207)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_GA100_PCIE)
+				NVIDIA_A100_PCIE_40GB)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
@@ -125,199 +185,259 @@ static const struct rte_pci_id pci_id_cuda_map[] = {
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_A800_80GB_SXM_DEVICE_ID)
+				NVIDIA_A800_SXM4_80GB)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-			NVIDIA_GPU_A800_80GB_DEVICE_ID)
+				NVIDIA_A800_80GB_PCIe)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-			NVIDIA_GPU_A800_40GB_DEVICE_ID)
+				NVIDIA_A800_40GB_Active)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-			NVIDIA_GPU_A800_80GB_ROYB_DEVICE_ID)
+				NVIDIA_A800_SXM4_40GB)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-			NVIDIA_GPU_GA100_80GB_ROYB_DEVICE_ID)
+				NVIDIA_AX800)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_V100_16GB_SXM2_DEVICE_ID)
+				NVIDIA_GPU_QUADRO_RTX_6000)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_V100_16GB_DGXS_DEVICE_ID)
+				NVIDIA_GPU_QUADRO_RTX_8000)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_V100_16GB_FHHL_DEVICE_ID)
+				NVIDIA_RTX_A6000)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_V100_16GB_PCIE_DEVICE_ID)
+				NVIDIA_RTX_A5000)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_V100_32GB_SXM2_DEVICE_ID)
+				NVIDIA_RTX_A4500)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_V100_32GB_PCIE_DEVICE_ID)
+				NVIDIA_RTX_A4500_LAPTOP)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_V100_32GB_DGXS_DEVICE_ID)
+				NVIDIA_RTX_A4500_EMBEDDED)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_V100_32GB_SXM3_DEVICE_ID)
+				NVIDIA_RTX_A5500)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_V100_32GB_SXM3_H_DEVICE_ID)
+				NVIDIA_A40)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_V100_SXM2)
+				NVIDIA_A10)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_V100S_PCIE)
+				NVIDIA_A10G)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_TITAN_V_CEO_ED)
+				NVIDIA_A10M)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_GV100GL_PG500_216)
+				NVIDIA_H100_NVL)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_GV100GL_PG503_216)
+				NVIDIA_H800_PCIe)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_TU102_TITAN_RTX)
+				NVIDIA_H800)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_TU102GL_QUADRO_RTX)
+				NVIDIA_H20)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_GV100_QUADRO_DEVICE_ID)
+				NVIDIA_H100_80GB_HBM3)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_QUADRO_RTX_4000)
+				NVIDIA_H100_PCIe)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_QUADRO_RTX_5000)
+				NVIDIA_GPU_H100_80GB_DEVICE_ID)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_QUADRO_RTX_6000)
+				NVIDIA_H200)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_QUADRO_RTX_8000)
+				NVIDIA_H100)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_H800_NVL)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_QUADRO_RTX_A4000)
+				NVIDIA_GH200_120GB)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_QUADRO_RTX_A6000)
+				NVIDIA_GPU_H100_GH3_DEVICE_ID)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_QUADRO_RTX_A5000)
+				NVIDIA_RTX_A4000)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_QUADRO_RTX_A4500)
+				NVIDIA_RTX_A4000H)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_QUADRO_RTX_A5500)
+				NVIDIA_RTX_A2000)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_QUADRO_RTX_A2000)
+				NVIDIA_RTX_A2000_12GB)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_QUADRO_RTX_A2000_12GB)
+				NVIDIA_RTX_A1000)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_T4G)
+				NVIDIA_RTX_A400)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_T4)
+				NVIDIA_A16)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_H100_GH1_DEVICE_ID)
+				NVIDIA_RTX_6000_ADA)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_H100_GH3_DEVICE_ID)
+				NVIDIA_RTX_5000_ADA)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_5880_ADA)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_L40)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_L40G_1B)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_L40S)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_L20)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_4000_SFF_ADA)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_H100L_DEVICE_ID)
+				NVIDIA_RTX_4500_ADA)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_H100XM_DEVICE_ID)
+				NVIDIA_RTX_4000_ADA)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-			NVIDIA_GPU_H100_PCIE_DEVICE_ID)
+				NVIDIA_L2)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-			NVIDIA_GPU_H100_GENERIC_DEVICE_ID)
+				NVIDIA_L4)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-			NVIDIA_GPU_H100_80GB_DEVICE_ID)
+				NVIDIA_RTX_2000_ADA)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-			NVIDIA_GPU_H800_PCIE_DEVICE_ID)
+				NVIDIA_GPU_GRID_M10_0B)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-			NVIDIA_GPU_H800_DEVICE_ID)
+				NVIDIA_GPU_GRID_V100L_1B)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-			NVIDIA_GPU_H800L_DEVICE_ID)
+				NVIDIA_GPU_GV100GL_PG500_216)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_GPU_GV100GL_PG503_216)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_GPU_V100_SXM2)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_GPU_GRID_V100S_1B)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-			NVIDIA_GPU_L40_DEVICE_ID)
+				NVIDIA_GPU_GRID_RTX6000_1Q)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-			NVIDIA_GPU_L40S_DEVICE_ID)
+				NVIDIA_GPU_GRID_RTX_T10_4)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_GPU_GRID_RTX6000P_1B)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_GPU_TU102_TITAN_RTX)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_GPU_QUADRO_RTX_4000)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_GPU_QUADRO_RTX_5000)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_GPU_T4G)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-			NVIDIA_GPU_L40G_DEVICE_ID)
+				NVIDIA_GPU_GRID_T4_1B)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-			NVIDIA_GPU_L4_DEVICE_ID)
+				NVIDIA_H100XS_1_8CME)
 	},
 	{
 		.device_id = 0
diff --git a/drivers/gpu/cuda/devices.h b/drivers/gpu/cuda/devices.h
index 9b5299f3f1..bc096bc4cf 100644
--- a/drivers/gpu/cuda/devices.h
+++ b/drivers/gpu/cuda/devices.h
@@ -10,82 +10,99 @@
 
 /* NVIDIA GPU device IDs */
 
-#define NVIDIA_GPU_A40_DEVICE_ID (0x2235)
-#define NVIDIA_GPU_A30_24GB_DEVICE_ID (0x20b7)
-#define NVIDIA_GPU_A30X_24GB_DPU_DEVICE_ID (0x20b9)
-#define NVIDIA_GPU_A10_24GB_DEVICE_ID (0x2236)
-#define NVIDIA_GPU_A10G_DEVICE_ID (0x2237)
-#define NVIDIA_GPU_A10M_DEVICE_ID (0x2238)
-#define NVIDIA_GPU_A800_DEVICE_ID (0x2238)
-
-#define NVIDIA_GPU_A100_40GB_SXM4_DEVICE_ID (0x20b0)
-#define NVIDIA_GPU_A100_40GB_PCIE_DEVICE_ID (0x20b1)
-#define NVIDIA_GPU_A100_80GB_SXM4_DEVICE_ID (0x20b2)
-#define NVIDIA_GPU_A100_80GB_PCIE_DEVICE_ID (0x20b5)
-#define NVIDIA_GPU_A100X_80GB_DPU_DEVICE_ID (0x20b8)
-
-#define NVIDIA_GPU_GA100_PG506_207 (0x20f0)
-#define NVIDIA_GPU_GA100_PCIE (0x20f1)
-#define NVIDIA_GPU_GA100_PG506_217 (0x20f2)
-#define NVIDIA_GPU_A800_80GB_SXM_DEVICE_ID (0x20f3)
-#define NVIDIA_GPU_A800_80GB_DEVICE_ID (0x20f5)
-#define NVIDIA_GPU_A800_40GB_DEVICE_ID (0x20f6)
-#define NVIDIA_GPU_A800_80GB_ROYB_DEVICE_ID (0x20bd)
-#define NVIDIA_GPU_GA100_80GB_ROYB_DEVICE_ID (0x20fd)
-
-#define NVIDIA_GPU_V100_16GB_SXM2_DEVICE_ID (0x1db1)
+#define NVIDIA_GPU_M40_24GB (0x17fd)
+#define NVIDIA_GPU_V100_32GB_SXM3_H_DEVICE_ID (0x131d)
+#define NVIDIA_GPU_TITAN_V_CEO_ED (0x12eb)
+#define NVIDIA_TITAN_Xp_COLLECTORS_EDITION (0x1b02)
+#define NVIDIA_GPU_V100_SXM2_16GB_LS (0x1db1)
 #define NVIDIA_GPU_V100_16GB_DGXS_DEVICE_ID (0x1db2)
 #define NVIDIA_GPU_V100_16GB_FHHL_DEVICE_ID (0x1db3)
-#define NVIDIA_GPU_V100_16GB_PCIE_DEVICE_ID (0x1db4)
-
-#define NVIDIA_GPU_V100_32GB_SXM2_DEVICE_ID (0x1db5)
+#define NVIDIA_GPU_V100_PCIE_16GB_LS (0x1db4)
+#define NVIDIA_GPU_V100_SXM2_32GB_LS (0x1db5)
 #define NVIDIA_GPU_V100_32GB_PCIE_DEVICE_ID (0x1db6)
 #define NVIDIA_GPU_V100_32GB_DGXS_DEVICE_ID (0x1db7)
-#define NVIDIA_GPU_V100_32GB_SXM3_DEVICE_ID (0x1db8)
-#define NVIDIA_GPU_V100_32GB_SXM3_H_DEVICE_ID (0x131d)
-
-#define NVIDIA_GPU_V100_SXM2 (0x1df5)
-#define NVIDIA_GPU_V100S_PCIE (0x1df6)
-
-#define NVIDIA_GPU_TITAN_V_CEO_ED (0x12eb)
-
+#define NVIDIA_GPU_V100_SXM3_32GB_H (0x1db8)
+#define NVIDIA_TITAN_V_JHH_SE (0x1dba)
+#define NVIDIA_T1000 (0x1fb0)
+#define NVIDIA_T600 (0x1fb1)
+#define NVIDIA_T400 (0x1fb2)
+#define NVIDIA_T1000_8GB (0x1ff0)
+#define NVIDIA_T400_4GB (0x1ff2)
+#define NVIDIA_A100_PG509_200 (0x20b0)
+#define NVIDIA_GPU_A100_40GB_PCIE_DEVICE_ID (0x20b1)
+#define NVIDIA_A100_SXM4_80GB (0x20b2)
+#define NVIDIA_A100_SXM_64GB (0x20b3)
+#define NVIDIA_A100_80GB_PCIe (0x20b5)
+#define NVIDIA_PG506_232 (0x20b6)
+#define NVIDIA_A30 (0x20b7)
+#define NVIDIA_GPU_A100X_80GB_DPU_DEVICE_ID (0x20b8)
+#define NVIDIA_GPU_A30X_24GB_DPU_DEVICE_ID (0x20b9)
+#define NVIDIA_GPU_GA100_PG506_207 (0x20f0)
+#define NVIDIA_A100_PCIE_40GB (0x20f1)
+#define NVIDIA_GPU_GA100_PG506_217 (0x20f2)
+#define NVIDIA_A800_SXM4_80GB (0x20f3)
+#define NVIDIA_A800_80GB_PCIe (0x20f5)
+#define NVIDIA_A800_40GB_Active (0x20f6)
+#define NVIDIA_A800_SXM4_40GB (0x20bd)
+#define NVIDIA_AX800 (0x20fd)
+#define NVIDIA_GPU_QUADRO_RTX_6000 (0x13d9)
+#define NVIDIA_GPU_QUADRO_RTX_8000 (0x13d8)
+#define NVIDIA_RTX_A6000 (0x2230)
+#define NVIDIA_RTX_A5000 (0x2231)
+#define NVIDIA_RTX_A4500 (0x2232)
+#define NVIDIA_RTX_A4500_LAPTOP (0x24ba)
+#define NVIDIA_RTX_A4500_EMBEDDED (0x24fa)
+#define NVIDIA_RTX_A5500 (0x2233)
+#define NVIDIA_A40 (0x2235)
+#define NVIDIA_A10 (0x2236)
+#define NVIDIA_A10G (0x2237)
+#define NVIDIA_A10M (0x2238)
+#define NVIDIA_H100_NVL (0x2321)
+#define NVIDIA_H800_PCIe (0x2322)
+#define NVIDIA_H800 (0x2324)
+#define NVIDIA_H20 (0x2329)
+#define NVIDIA_H100_80GB_HBM3 (0x2330)
+#define NVIDIA_H100_PCIe (0x2331)
+#define NVIDIA_GPU_H100_80GB_DEVICE_ID (0x2313)
+#define NVIDIA_H200 (0x2335)
+#define NVIDIA_H100 (0x2339)
+#define NVIDIA_H800_NVL (0x233a)
+#define NVIDIA_GH200_120GB (0x2342)
+#define NVIDIA_GPU_H100_GH3_DEVICE_ID (0x237e)
+#define NVIDIA_RTX_A4000 (0x24b0)
+#define NVIDIA_RTX_A4000H (0x24b1)
+#define NVIDIA_RTX_A2000 (0x2531)
+#define NVIDIA_RTX_A2000_12GB (0x2571)
+#define NVIDIA_RTX_A1000 (0x25b0)
+#define NVIDIA_RTX_A400 (0x25b2)
+#define NVIDIA_A16 (0x25b6)
+#define NVIDIA_RTX_6000_ADA (0x26b1)
+#define NVIDIA_RTX_5000_ADA (0x26b2)
+#define NVIDIA_RTX_5880_ADA (0x26b3)
+#define NVIDIA_L40 (0x26b5)
+#define NVIDIA_L40G_1B (0x26b8)
+#define NVIDIA_L40S (0x26b9)
+#define NVIDIA_L20 (0x26ba)
+#define NVIDIA_RTX_4000_SFF_ADA (0x27b0)
+#define NVIDIA_RTX_4500_ADA (0x27b1)
+#define NVIDIA_RTX_4000_ADA (0x27b2)
+#define NVIDIA_L2 (0x27b6)
+#define NVIDIA_L4 (0x27b8)
+#define NVIDIA_RTX_2000_ADA (0x28b0)
+#define NVIDIA_GPU_GRID_M10_0B (0x13bd)
+#define NVIDIA_GPU_GRID_V100L_1B (0x1db3)
 #define NVIDIA_GPU_GV100GL_PG500_216 (0x1df0)
 #define NVIDIA_GPU_GV100GL_PG503_216 (0x1df2)
-
+#define NVIDIA_GPU_V100_SXM2 (0x1df5)
+#define NVIDIA_GPU_GRID_V100S_1B (0x1df6)
+#define NVIDIA_GPU_GRID_RTX6000_1Q (0x1e30)
+#define NVIDIA_GPU_GRID_RTX_T10_4 (0x1e37)
+#define NVIDIA_GPU_GRID_RTX6000P_1B (0x1e78)
 #define NVIDIA_GPU_TU102_TITAN_RTX (0x1e02)
-#define NVIDIA_GPU_TU102GL_QUADRO_RTX (0x1e78)
-
-#define NVIDIA_GPU_GV100_QUADRO_DEVICE_ID (0x1dba)
 #define NVIDIA_GPU_QUADRO_RTX_4000 (0x1eb1)
 #define NVIDIA_GPU_QUADRO_RTX_5000 (0x1eb0)
-#define NVIDIA_GPU_QUADRO_RTX_6000 (0x13d9)
-#define NVIDIA_GPU_QUADRO_RTX_8000 (0x13d8)
-#define NVIDIA_GPU_QUADRO_RTX_A4000 (0x24b0)
-#define NVIDIA_GPU_QUADRO_RTX_A6000 (0x2230)
-#define NVIDIA_GPU_QUADRO_RTX_A5000 (0x2231)
-#define NVIDIA_GPU_QUADRO_RTX_A4500 (0x2232)
-#define NVIDIA_GPU_QUADRO_RTX_A5500 (0x2233)
-#define NVIDIA_GPU_QUADRO_RTX_A2000 (0x2531)
-#define NVIDIA_GPU_QUADRO_RTX_A2000_12GB (0x2571)
-
 #define NVIDIA_GPU_T4G (0x1eb4)
-#define NVIDIA_GPU_T4 (0x1eb8)
-
-#define NVIDIA_GPU_H100_GH1_DEVICE_ID (0x2342)
-#define NVIDIA_GPU_H100_GH3_DEVICE_ID (0x237e)
-#define NVIDIA_GPU_H100L_DEVICE_ID (0x2321)
-#define NVIDIA_GPU_H100XM_DEVICE_ID (0x2330)
-#define NVIDIA_GPU_H100_PCIE_DEVICE_ID (0x2331)
-#define NVIDIA_GPU_H100_GENERIC_DEVICE_ID (0x2339)
-#define NVIDIA_GPU_H100_80GB_DEVICE_ID (0x2313)
-
-#define NVIDIA_GPU_H800_PCIE_DEVICE_ID (0x2322)
-#define NVIDIA_GPU_H800_DEVICE_ID (0x2324)
-#define NVIDIA_GPU_H800L_DEVICE_ID (0x233a)
-
-#define NVIDIA_GPU_L40_DEVICE_ID (0x26b5)
-#define NVIDIA_GPU_L40S_DEVICE_ID (0x26b9)
-#define NVIDIA_GPU_L40G_DEVICE_ID (0x26b8)
+#define NVIDIA_GPU_GRID_T4_1B (0x1eb8)
+#define NVIDIA_H100XS_1_8CME (0x2337)
 
-#define NVIDIA_GPU_L4_DEVICE_ID (0x27b8)
 #endif /* CUDA_DEVICES_H */
-- 
2.48.1

