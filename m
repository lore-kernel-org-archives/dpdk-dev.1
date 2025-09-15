Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC904CAC592
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 14:43:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8247D4064E;
	Mon, 15 Sep 2025 16:43:17 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013013.outbound.protection.outlook.com
 [40.93.201.13]) by mails.dpdk.org (Postfix) with ESMTP id 95E04402E3
 for <dev@dpdk.org>; Mon, 15 Sep 2025 16:43:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLjzlt6Wuz69csY2/xotUVwCm1hx1UA11LEwm3s86WtojoMN4cbsLHMFchYR9y8L8Ym/2sFI8pIVP+g+30C2HsujVYx5Xpn7XpDmF0vfqxlW29zdH/0uXCAHShxiuiG1zuT9emoI51arGi/kOjI3WHPA8U5+m/x+zoQRQkoSJxuar+vtjI8WdUI1PR9NgROY0hCsZeeEdc6l1lS98sPALu4GIN8VbDUhaWMDRJqBOEGyTbjuA34HeUtFvHLed0h5sbxrGT8M8N3d7OEpOd/6Cr7qY1aBbbthdI66pz6cZn16qdAInkkGs6Nj9Y4oL7enFRNjiRY4G6uoYljiqDbybQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+k7JNwu2RXh+4JwTk7+6kR9x39NbyWA7lI3Z3YIukI=;
 b=GW2BBre4c/fjaIqheTJnI9TKioNAbpGD9y6SX8kvONMK9FONL2n/jp2+QHAKgalIKJ/4/qayv5BQBBm2KGPNuTQtQmA77Fn4iwjYWyzrXzFt/IACy5X1evBYJIdil0X6YQbWoAt5AZSF/V1DZhYburDEhRup7raxwofvhaJySWddb/8YFolxAs3uTS2WmvqY0vPE/hHFWUl2UyJiszmmKhn1NjUWt5ueenW5Gki7ZVYcPNYnCiETUZzxfh3bGViOjOdNOhoiUsVjxADKRLN2bXp91iRU66cExqO5FPApwyTeJVjWw9GUBZBD4O7K5pw2ARWlqjCl2rsLHDqYqIgWew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+k7JNwu2RXh+4JwTk7+6kR9x39NbyWA7lI3Z3YIukI=;
 b=Pg4SfVfFfEAuOMMUkAghzihMuT2e05wE9lhZuJ+FduQpAdg7r279BHPcdOqf8pCySwPPp7VsW/gijNnnharW08KD93IhHZXd24kenFol36Iq/RZwRRsaTDHOEQ5/y+3efCt7OI2gmTOgvWGvps2hKk54xy7nM8p5ydURbc5SwIdJPVujhT9P+4Oqv0zwjOZa8rFiVjD9YFGMQGJkyRgWGSUtSgqgIYOVdS2HkYQOtdv2e1eoVQjHUq6vyFo8r0L67NPftLTaWhS1kjHI6zbX0E+fZFArYwWzATtbCGZYhT6XSFWNGc5Ck4Rsv5EjTQ/nrSzvh/+Kx3l6B5uPyjoAhw==
Received: from BN9PR03CA0978.namprd03.prod.outlook.com (2603:10b6:408:109::23)
 by MW6PR12MB9000.namprd12.prod.outlook.com (2603:10b6:303:24b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 14:43:11 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:109:cafe::c2) by BN9PR03CA0978.outlook.office365.com
 (2603:10b6:408:109::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Mon,
 15 Sep 2025 14:43:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.0 via Frontend Transport; Mon, 15 Sep 2025 14:43:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 07:42:54 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 07:42:52 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>, "Elena
 Agostini" <eagostini@nvidia.com>
Subject: [PATCH 1/9] gpu/cuda: add NVIDIA GPU H100
Date: Mon, 15 Sep 2025 17:41:28 +0300
Message-ID: <20250915144137.54858-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|MW6PR12MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: af433d94-4e8b-495e-657f-08ddf46631a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kNGdAgPssOJwojA8Mxwdp6j7RN036ShoQsuAh+c4Ugr4Jqwyk10tctp3kSv7?=
 =?us-ascii?Q?4fmq9klEylq7ZXDVyhuQQVvyppNj8fIwxqldYefAyaFGZmnHzG7z6NFkULhK?=
 =?us-ascii?Q?X4gb1J7Bdq0i5Pe/2C7Y6Gp4nV0dlEauF8FfJMwp0SNNpWhVT3D188Tsn7Bx?=
 =?us-ascii?Q?JDNFDadsUa0CnZzKesZeNSeZmEBN21PhaBBtCQjOUavfRtVa5prv5USyRNPl?=
 =?us-ascii?Q?TUAfZPq2LRWD9iVZtecKX1prBVxkHDZGMQljy7D4c7f82ekEviB90PD2W5vk?=
 =?us-ascii?Q?2B3iVZeMeno/coItZ/R72JBerkcC5XtBvCwAsNzoyZWjZV0QnBP6Dmk9axtF?=
 =?us-ascii?Q?URyLzq1sGYh+jnXf1wNkTcqiI5w2nsyJBme6Jbeyo60A+mdBamjyan2pzEXA?=
 =?us-ascii?Q?JeFLg8AlTvvJ5rdK1S6fyC6l+Wvhqq2jQ8Thw4wWolCkAMRAxPHa5mwEtkGc?=
 =?us-ascii?Q?vkgItMsN8heAB875VWGK2Tij0P4boklWENrzXA5oKi8WrBtFMhEVRy7hn+NT?=
 =?us-ascii?Q?ngPmh/8jW2W0q7BQSgsizOtsuWUALS+R6UvuV0P/winmeZFX5TZ7N7+j2/z3?=
 =?us-ascii?Q?1oAYh9WIknoKTyYoJrLJgmuTQoon2jP5RdzFqFZAbbLFfQ6OtXoxSoTNfHAg?=
 =?us-ascii?Q?qcpXNNVLQeZ5z9AOK5lKM70KIfsP+nmrYS//9hQlviRncrtazXJOcNTBE4ZI?=
 =?us-ascii?Q?XDu9+7E82lUKmiPwk/yq/5c4cUAwJ24R3+0HL0gv5Pip3ELFQGxci6qf3XyN?=
 =?us-ascii?Q?or9PGN11u1OpkziyFtwq1I8RDxRaJMNvZBvjvEW3h1/scRzk1yQXoyM3u73A?=
 =?us-ascii?Q?iyLGExHM421SEm8PcbZgrZsMHCTutS/GszAy5VucHdVmmC9pLJ7A1RPeFrqD?=
 =?us-ascii?Q?dbEiL6S/QVgd43jZQgs9B0M3raQvbsqWk5QTiu6c/dAtpRBZxcobUfrIi5Yy?=
 =?us-ascii?Q?nLBzIy3neDCbuAHFZ9ZHf/hv4Wq9jRiGfG93KtWxZubWGhYI65fy+VgIopsv?=
 =?us-ascii?Q?gwSEUV+n+ZLNNlRkQFpWp43hiZ/KPdZLZ4HwlK8gpoxAkJq1NN49+PPagR8T?=
 =?us-ascii?Q?9Hsz8zv/bZpjqekAE63OOdgtLNk8DYEifXsD7zCEGkNpRPsipO4Oloxua397?=
 =?us-ascii?Q?38WCchMPaOJHak3xrujafxDr8VlKRhvkFszK7sTZWa3LkFUawtr98RqahlZG?=
 =?us-ascii?Q?S5Wq6/0jcBvVJ9tXC/GQ+BSObPYpk5Ee8nNrXN6ESDWBQA9uwl2DZ2ywTOyQ?=
 =?us-ascii?Q?bhHcZgfQB+GTNM2egOQbaj6FxGugzStaC4vCoczWyd6HaB7c6j28YYUO25X/?=
 =?us-ascii?Q?bvQIF3ddvLtWPIlC2yqgdEkBI9vu/dRkOauR0yFuelpIovnpgR5tjKuBE3yF?=
 =?us-ascii?Q?G0nto1Tx8OH9soWOTfcZZZv+SH5Uikuc8/gLQBqGF1aLRvKVWxD+uP9w77TM?=
 =?us-ascii?Q?c2iTB0S/dtvAn7P8dsHig3sr2DK5iR0xDVoXGzmgDQ3uXcATbLUj7EcjNWcd?=
 =?us-ascii?Q?pNzMZaZjTJsVEn9BbUarLnvXQFkh8YOKO+sy?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 14:43:11.0933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af433d94-4e8b-495e-657f-08ddf46631a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9000
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

From: Elena Agostini <eagostini@nvidia.com>

Add support for new NVIDIA GPU H100.

Signed-off-by: Elena Agostini <eagostini@nvidia.com>
---
 drivers/gpu/cuda/cuda.c    | 4 ++++
 drivers/gpu/cuda/devices.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/cuda/cuda.c b/drivers/gpu/cuda/cuda.c
index a552aabeb8..ff8c29f970 100644
--- a/drivers/gpu/cuda/cuda.c
+++ b/drivers/gpu/cuda/cuda.c
@@ -63,6 +63,10 @@ RTE_LOG_REGISTER_DEFAULT(cuda_logtype, NOTICE);
 
 /* NVIDIA GPU address map */
 static const struct rte_pci_id pci_id_cuda_map[] = {
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_GPU_H100_80GB_DEVICE_ID)
+	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
 				NVIDIA_GPU_A40_DEVICE_ID)
diff --git a/drivers/gpu/cuda/devices.h b/drivers/gpu/cuda/devices.h
index e6502910f3..e45521c7cf 100644
--- a/drivers/gpu/cuda/devices.h
+++ b/drivers/gpu/cuda/devices.h
@@ -10,6 +10,7 @@
 
 /* NVIDIA GPU device IDs */
 
+#define NVIDIA_GPU_H100_80GB_DEVICE_ID (0x2313)
 #define NVIDIA_GPU_A40_DEVICE_ID (0x2235)
 #define NVIDIA_GPU_A30_24GB_DEVICE_ID (0x20b7)
 #define NVIDIA_GPU_A30X_24GB_DPU_DEVICE_ID (0x20b9)
-- 
2.48.1

