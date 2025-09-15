Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECD6CAC597
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 14:43:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 199B640677;
	Mon, 15 Sep 2025 16:43:27 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
 by mails.dpdk.org (Postfix) with ESMTP id 880B74065F
 for <dev@dpdk.org>; Mon, 15 Sep 2025 16:43:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZETW/7G5YHjeNUJ7oYMSX8zBXWb2J+ZMUmrNwQgu8sQejVSyBSFvzBz7k/0HUrARAZM4PuAH6yB/subyIDe7CgCdh99DMtDdHr+AXGLjLd65EW4o0mdCYYhQwvJiTodGR4tFOE3ww8PStcLhiPIdfWNPr4dlmc1At114V1/jKq01JIanDBHNnSJgMJ1aE9Vr8szYw+cRmWG/DSz1QsxbImpdddZnITRzqnMYSwKlhOz8ulrfBxnkOt9Kq2R8PPMq0U0iqAIXoBmbP1whGsYmXvc2xHeelizGH2gpwgTpENqEbkLgFut4r2Q6lRwWET/qWbnyQQhQeLhd8qJJyE3d5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/6rkHaMlKoh7IZSmqLRpmR/l07dOetQ1fXR6TInOjQ=;
 b=eqHp34fFd7dkkcnoFIx2GHX5i9sNpgkMuU9Q8Ws5EqVu+Of86EzIObevgFXCbmceA/70ciguoGggkBK1IO18a93OlzD30FwsxQE3zVr30z+3KyP1RX5uanO+4eedoVQEcq03EKEZNEjv4PnllPpllWcoTm6d1H6mKS0sbBORnMW8wRYa2oeNZGTPSTJH1Ojv1/Th0x8haQMXf1APWgF4vQ5EVQozKZ4z85gVMgNL2q5c2HcmBB0njtfsf7p9UI0a11XMe2+BHPpQi76dxa3Tne+iKea4Av+6/0dRUQSZaADlmc6c0MuT4YJEEJgCDrqZNmgzSmwrQRJ4m+/z+LGx+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/6rkHaMlKoh7IZSmqLRpmR/l07dOetQ1fXR6TInOjQ=;
 b=gfSmj9T8A0YiSdwCoo6TXIQp1Kz1Jx/41SjNXIv6T180aTQQqBQ0DI9dz/m8+m3XszupiTrIz4AGbFHnlrtqKTlZNSy9HqZ3mOUDTpUnYo2F6QfiRInWYO6vjIYbvgKW+EDsT5j2/HPHk+3qChk1PcSpKgxAkAIIvYPWUhp8T2pxhEvRjEt76OJTkD8wYChh7I9hCv5KRv0VTkJTVpi9/j77Hbq/XC/twrY22xJB/Wf47RahrnEH3YzrJjVQMXUrtDWvLQAsmhdIgLLAGdaihvk5oTz8lovJsv1VZg04NWtmtgMCGwKM7NHjQpGOZdfhDsY69UlwTS6+06k+B7ziKw==
Received: from PH1PEPF0001330F.namprd07.prod.outlook.com (2603:10b6:518:1::a)
 by MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 14:43:22 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2a01:111:f403:c91d::1) by PH1PEPF0001330F.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Mon,
 15 Sep 2025 14:43:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 14:43:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 07:43:03 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 07:43:01 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>, "Elena
 Agostini" <eagostini@nvidia.com>
Subject: [PATCH 4/9] gpu/cuda: add new Hopper GPU IDs
Date: Mon, 15 Sep 2025 17:41:31 +0300
Message-ID: <20250915144137.54858-4-getelson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|MN0PR12MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: d654856c-5d1b-44cf-1e25-08ddf46637f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+ESrYPFUJ2+lk+8uXByeo6Yon6v9hhlGaXFhRRiBoQmepwws6HVeRv7fh3mI?=
 =?us-ascii?Q?/X7ahLP/+INMlunqt8K82m2ZDGEQ0pV/ghbtD8jQLmN6i7tm6OdIT2OPzN1w?=
 =?us-ascii?Q?ndIwRWX8qS4ea8c0sw8GlsqIdRDTZKg6dED7n2H0ghg+NKXlkrKZPW326Fj/?=
 =?us-ascii?Q?+pbTWFLYxscsvvUYRNvcCfzRht0dUQ4iR+Sl1O64hQIWUVw6ECT0ODn/ZgUP?=
 =?us-ascii?Q?wP4MoK9eITTTaHUvuSaRQwk87D/ECSvyxzqW9jEakzEYBb9RBhAs8OISGWTe?=
 =?us-ascii?Q?xQaK9+BryYPQRCAqfsSk/orJWtMQDGcRqoyJKcTUJmgORM310dV7YagBNVJ7?=
 =?us-ascii?Q?YwV9D/dV9OFUiu55seL6nGmjSeri7K4aaE1LQDRab1fbAo8gcCG6SKgJzeR9?=
 =?us-ascii?Q?nKqeox3/VKAowzix0u8vG+FitghxnIbvuAoHXWHy7bdwAdlGYlqZ/di+oSpJ?=
 =?us-ascii?Q?MbAjAmGynwHT4q17Z7X+YD1/gy4IFc4dZ63fnOUY46HgkK6WkO75bpt1cvdy?=
 =?us-ascii?Q?uLfUhEmHOJIvH9UP6p7u5UWrGFddV0Rigt8w6LbHR8IOcN9GGxwUmHVZ4BiD?=
 =?us-ascii?Q?TZzzRFwjC3H4AYGswPSxa5E4nIobu4Tr6Z6mgs1KXQNZACV+lZaDQyTgGINC?=
 =?us-ascii?Q?eYZPjvtN2C/j9uOuo/ZBSmAMgBJoJFHj5bVrz1SJ9PUqxeJyqN5PvmW2CZ5C?=
 =?us-ascii?Q?Gli0bafWO8TOpOoTlL5sNls/ixNxjhkxbN+h7L3VbuhEDS0t+2rBZ+7WpuxH?=
 =?us-ascii?Q?30EVtt5+rngc54CX8sJuDmOmct6egPvMvLkN+tVNxrrQfRsxdY5dO/LkqI2I?=
 =?us-ascii?Q?LXOksBp4G5YkkDaJvZzEGBdz0kYWj+RMUWs/k1PV+/8FBcsVMb77q4EtwJ6W?=
 =?us-ascii?Q?LGL4OsOEKGtaBsnLVYUlXoPhijSdyguo/psfajXKBbWUvksgrgBnTxebzwFi?=
 =?us-ascii?Q?O5PM03vmepQjHKBN/EWVBk7PuxcDULkTb7NreI7NT2OYKTRnr1qaqKX7DKSK?=
 =?us-ascii?Q?gfwoDeKwPyzaYwoFGeoJJVWEfXlvOGGnp6VFT6sk4v99yldjn32pfvU/S5V7?=
 =?us-ascii?Q?1niYeQtDpva6Zp3efCCq3IwQD3iSQ2BvT78aebAp37YdbD2eL69xCTy77adt?=
 =?us-ascii?Q?FStKUjf/XNrq9z4B3Xzaab7LF/x6O6se0Y58Ao41FGpzcpFNestb9hyX/fth?=
 =?us-ascii?Q?giiWrm6oGOvAfQZmCwM2pfZs8J1WdrsEE4TAcLB9sPMR4pMWM/etaLN1QGQu?=
 =?us-ascii?Q?GhG4HEXdOB8daJuKjAtiL6Q33fRFuSnYtR8wCuBRwUv0cTRP8kZya6OYOqNh?=
 =?us-ascii?Q?+DG8gI02hefY5Z97NLKvDKUAJVNhu/MZZxKU8HsYZ4ywi+Q1vjmBt6c+iiMW?=
 =?us-ascii?Q?n9vW+HLJDJtBo73VknhUMwxvgnp/IvQh+4eOnXLW1h72ZdfZemqaUzolK7WK?=
 =?us-ascii?Q?odsmwSFMsCfONivd9TCdiU3P7DqUFRgQrSNDqIjOx8l5CDO+FCwl9rhOtwIk?=
 =?us-ascii?Q?tHR//m6Tiy2m1jxbPVJkCrl1ODWobYv6Xbt1?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 14:43:21.7970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d654856c-5d1b-44cf-1e25-08ddf46637f1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5716
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

Add a new NVIDIA Hopper GPU IDs.

Signed-off-by: Elena Agostini <eagostini@nvidia.com>
---
 drivers/gpu/cuda/cuda.c    | 8 ++++++++
 drivers/gpu/cuda/devices.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/cuda/cuda.c b/drivers/gpu/cuda/cuda.c
index 21c4fe9bef..9eb748dd2e 100644
--- a/drivers/gpu/cuda/cuda.c
+++ b/drivers/gpu/cuda/cuda.c
@@ -255,6 +255,14 @@ static const struct rte_pci_id pci_id_cuda_map[] = {
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
 				NVIDIA_GPU_HOPPER_GRACE)
 	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_GPU_H100_GH1_DEVICE_ID)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_GPU_H100_GH3_DEVICE_ID)
+	},
 	{
 		.device_id = 0
 	}
diff --git a/drivers/gpu/cuda/devices.h b/drivers/gpu/cuda/devices.h
index 5d9c7616f2..9f93132217 100644
--- a/drivers/gpu/cuda/devices.h
+++ b/drivers/gpu/cuda/devices.h
@@ -69,5 +69,7 @@
 #define NVIDIA_GPU_T4 (0x1eb8)
 
 #define NVIDIA_GPU_HOPPER_GRACE (0x2342)
+#define NVIDIA_GPU_H100_GH1_DEVICE_ID (0x2342)
+#define NVIDIA_GPU_H100_GH3_DEVICE_ID (0x237e)
 
 #endif /* CUDA_DEVICES_H */
-- 
2.48.1

