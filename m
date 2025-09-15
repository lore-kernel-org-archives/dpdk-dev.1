Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F74CAC597
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 14:43:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3083240663;
	Mon, 15 Sep 2025 16:43:22 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
 by mails.dpdk.org (Postfix) with ESMTP id 9C5AC4065F
 for <dev@dpdk.org>; Mon, 15 Sep 2025 16:43:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBMrpKwflORMSJu5UjxEnROeQw8ZOTuhw2tLs4Zwfa+eKMEQu6sQFoXP5wtFsRNGGyWIKdmzB7D5bYfrAUsVPoFFLxA2A8NF4APPlAM4K/eqWaa9aoKyXQuSVTSYDe9L8mD3uKBmqdWzSOZVinTqhXpiw4YZmebK7VKVe98eWiLRc5P1Oq7XnnNEGMGq7IfkCBkXl4jzXbqty6OV800abyt5ALzikQdxDaz46kCx73AiVLDQRYcoEUcK8MFlZWpLFrvuLBMvyWWcszd6IUnhsYjL9sq5gYORU62kCYp2xvtBc8biQcLx+gMClB317sZlvRfp7JNcoPAbArFFOOAucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+H5tfWBSCZhSb2YAj+5QHXSaVOoZ09mLcv8PX4+NOMI=;
 b=KSPmvb1GoKycIgMPtay0+eI/7QEm1cm9NrP4iEiJ7XL5bsR3ZA/KSf9s3TAEzcFuR7urtH2aJdZrgs4QgkI1a0hTMguuBfrOiaxAL+kj7ZvR/cKu02yFG+O2eQ48S4I2+0245HH0u4BAmmuLZ6kTSsU/WAQgzZIqhCxOX1aJEqJFR5BVioICd3WIt7SFLk6C/i74furEoRkpYOKivV/HtKjbD+7WNPNvJAP4jCrYJBJQMADccGK6EF8HzaBXap+0Em2SIdZR82HljGKy2Fwbtq84HY8zEBcudVzYwhgHwIsUW9/NMcNwi1bH8UXoKZNMeQ9u4fkCDECqbGMOvEQyVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+H5tfWBSCZhSb2YAj+5QHXSaVOoZ09mLcv8PX4+NOMI=;
 b=S7hm6OdCeLTviCg7baavkdO8JqboNSViZgtOtbwm4IehRhieeHgXLaeGIbNayWHHJyA6xp+ObMKJYaEcuCmKw+G/m6K5o5jq85VPJAytRdVvqqpGWhYo2aD+W0X/XJy1ac9xt3uBCva7Ga8plU6jUtb2D5+X0on9ojFRc1tKBVKb5jFyxBc5HHwa0giLZLRLkCbgvbamX9yRKZ3D0CjHgRZadGrqN//3lPUDPeF7wof3tQyNvuMHfOCFlgza+aKKEVKgXOzo+XCNkR06jhdwj53haPOCZ0lqk9AVZ6O8/18iy0vjMHIZo5iI1v767vDsFyKjmtBihmJyVMujIB63jQ==
Received: from BL1PR13CA0323.namprd13.prod.outlook.com (2603:10b6:208:2c1::28)
 by PH0PR12MB7929.namprd12.prod.outlook.com (2603:10b6:510:284::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 14:43:16 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::bb) by BL1PR13CA0323.outlook.office365.com
 (2603:10b6:208:2c1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.11 via Frontend Transport; Mon,
 15 Sep 2025 14:43:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 14:43:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 07:43:00 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 07:42:58 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>, "Elena
 Agostini" <eagostini@nvidia.com>
Subject: [PATCH 3/9] [gpu/cuda] New NVIDIA GPU Hopper device ID on Grace
Date: Mon, 15 Sep 2025 17:41:30 +0300
Message-ID: <20250915144137.54858-3-getelson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|PH0PR12MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b7906cd-12e3-44d0-9750-08ddf466348e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j+QLNGJ1PSq8KCj4Z2dHRuVbFnAQnoQ23PzO4H98A+IQ0L6rtM4dIt/oQ53u?=
 =?us-ascii?Q?jRe5j1jurUJpI5+UOCTbubwbwxI9fjCxSEKjJ0icf3kuYhjofdj7WPv7Rx9B?=
 =?us-ascii?Q?TQKbF+VLSRB27Sp8LnvkrJhUGoRdpJAKuzguM/2Cs17+wFo7dU7HcT4BHHGU?=
 =?us-ascii?Q?FpJcAw8uFFSqlnsWTe/Pxcir2L8SctBwi9/61rS83IEVwoJ5cICp8IQPpHxm?=
 =?us-ascii?Q?0P3zDWm7dTtb+Q028BGVSf/YEzNmWIA0U3/xoAP2V09xtoDixA8Ekt0xGXFP?=
 =?us-ascii?Q?MmQmbN4eX1pVGxatKZLgNPnf61YkVR36LduGC0B/HXiFlhdjxWg7Wj1ZO/So?=
 =?us-ascii?Q?mBSXuo8rXK9oMO+dbjUSWQ+c2cV2eLCYk1TWp2/8xhyUIWz4phyPnqLNG5Bi?=
 =?us-ascii?Q?DVNV15HJ20jDWA1PTlAOB7WMS70OH7YTe4VBt99gCsP7FkHjocfmvwcjnNt8?=
 =?us-ascii?Q?hMjKlce/iOqoc4kHuYLUN2X7O80q43tRn6skxOwWPNcTcEppR8q+hZgfhqvd?=
 =?us-ascii?Q?G6OXqtXLtU7w4c3yOiUL5yrV+i7GwrWR73O7JUGciren0XhswoHZdFfORRXO?=
 =?us-ascii?Q?RQT683uJJ2SzAEHFsTK+M/sjerzStDHFiEm1pUXgrVlSdORzA+oN+D4aLnyL?=
 =?us-ascii?Q?Y3InicpJsGZjR+04L8UWHf/EoLAdh/l7NOomWHB8Z/YcA8u2FB2hxj8hf65c?=
 =?us-ascii?Q?dnO67lW9gTTpFAzjpPF/N3eOx17jTFOL4iXr7zLav/mPCT8oYhg54BluaoSR?=
 =?us-ascii?Q?GnOrtcS09SLBNkJDnRwu7Qkm1j9fKNhzS2ApVOsKTDqXgo4VMTJHyC2ZEeUn?=
 =?us-ascii?Q?nrkc1CUELeu9o4qJCATPIyMu0VZqcUQ4dgkNHRDD8DCgGoT4MvhAvrjkn02e?=
 =?us-ascii?Q?WQsm6inD/eDIlIj/xLFUhMHmTe0dmWa4NDyeOJ2vQVMKHmPsIPxynch64CHs?=
 =?us-ascii?Q?1zt6zFA/z1zCAusSh62vKfVvHphhCVZuGe3AcdzUqPHkgWHMvTGnzox7XRf4?=
 =?us-ascii?Q?7F4+Ytdy90qcF/pokyvTeUDbh6LgwlH3KNKVff48Limc4elva7++Wa7LcjsL?=
 =?us-ascii?Q?bspXW9N7GEKVju7vutblXgNcfXGNQOEvs4b3KX+VUai4ZK7HTfg8T4gPDpKj?=
 =?us-ascii?Q?wJ/dUTf7vINJUaJmXTCEM3V9ff37ll9AjLjBmnF7DWN7U/LZXRLhIUL0AvId?=
 =?us-ascii?Q?PVajcWszufPaoH162pY//kgVLIOoLgqxV+q/GXBGZ1+6xK9rnZtQIoNYyFlR?=
 =?us-ascii?Q?SYpijtL6V3yv8oyuWErQVQshBQuPC1GN7TS2dcgdg04bYQvCs8cLjbjdn2Hc?=
 =?us-ascii?Q?8Ys3+yUIZiSpMxWOCbx0mAQM3zWdUeSMyeHMpEtLP+dOiteP9oRI7E/RPoti?=
 =?us-ascii?Q?IFhJytu2I6ab0Me8x3ZH6N7HfngmRQ5tfGJY5EdCPa3UBZZ18lLs4BQ9p6vJ?=
 =?us-ascii?Q?0CEkwk734NPGQIXp6/jvJpWXMvW6E71gQmQ0zal05EkjLVZu2CJdLbNxVpWS?=
 =?us-ascii?Q?9cuoKq5FKKbnelNllilrMrhFmA+nCWYKzH2c?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 14:43:16.0173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7906cd-12e3-44d0-9750-08ddf466348e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7929
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

Signed-off-by: Elena Agostini <eagostini@nvidia.com>
---
 drivers/gpu/cuda/cuda.c    | 4 ++++
 drivers/gpu/cuda/devices.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/cuda/cuda.c b/drivers/gpu/cuda/cuda.c
index 0af955421a..21c4fe9bef 100644
--- a/drivers/gpu/cuda/cuda.c
+++ b/drivers/gpu/cuda/cuda.c
@@ -251,6 +251,10 @@ static const struct rte_pci_id pci_id_cuda_map[] = {
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
 				NVIDIA_GPU_T4)
 	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_GPU_HOPPER_GRACE)
+	},
 	{
 		.device_id = 0
 	}
diff --git a/drivers/gpu/cuda/devices.h b/drivers/gpu/cuda/devices.h
index e138a600d6..5d9c7616f2 100644
--- a/drivers/gpu/cuda/devices.h
+++ b/drivers/gpu/cuda/devices.h
@@ -68,4 +68,6 @@
 #define NVIDIA_GPU_T4G (0x1eb4)
 #define NVIDIA_GPU_T4 (0x1eb8)
 
+#define NVIDIA_GPU_HOPPER_GRACE (0x2342)
+
 #endif /* CUDA_DEVICES_H */
-- 
2.48.1

