Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945CCCAC597
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 14:44:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A46E2406B7;
	Mon, 15 Sep 2025 16:43:41 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
 by mails.dpdk.org (Postfix) with ESMTP id C88004066D
 for <dev@dpdk.org>; Mon, 15 Sep 2025 16:43:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1pU3ignMvCqcCrDCs6qlFj9WY00TMF5wt4xAx7OuftLfMQl5rv+wD14X3c+dtq5hn/Ed3xTDwK1HMSN079bc0Qg6bGN/CmtQjTJBE/r09yc+n7rsO2hFTsaXGL7nClw86Fo0ydfKmpxD9/tgkB878Q8dIo7B0BAFLjbmek8htuVwLCA4hXJGjRGA1H6DX9sS3GjhTM00u+98zBMinhlcOe1O99udVgheynjO2XiM71pNx2AsTMobKyNzg9HgxHYFgKVb2YdS3J2qOXwadDvcBoxNuGSSnYTHx3Sb6Mk9XvJ+9ocZzuMiIuo1OSHSpyWheWvw56gUDxfYbLuHaDj6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+CPJaDhJiWRFrtgGmAnzCo/Rb+qSMTVfLDfSrBVmE4=;
 b=VGBnyy9a9e2r+F4ND0QdE4wtPa4ps1PTQE0Xlmt6sULYjkN6gS+EmVau99jF0FHONlO6M8clHzGxpgoGXtgBRNFohCXX1EAVwi+LFkFg4bV5RyeHUSj0tX5kcNFxjelO/zTQR8uNF4xcfYrwL6tZ2IjTX2xJDjSn83YkYqbrSdSwgh+G+WixCaw67jkTu4vbJx+f0c3eWhH2ZtyRCp0tc/gMxIEKWfIgnIc1l+zfGxyiPObiutzF/3fHfk7wIOOEfHkZN5fkzdqULjFy3pb+61rjeET/fNME8bl8xZMVEjoTlXW3ySooOHt1RzIpXREKESyIYqIZQuouicscMQGVEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+CPJaDhJiWRFrtgGmAnzCo/Rb+qSMTVfLDfSrBVmE4=;
 b=V/YFD2sym0whl8AZxbnhE2SPMHGt6qIHXMzSyKo7NX8bfa20lWN/o7RKeAc8m4khL72iqV2QO9IMmu1Zmxv1tlGyFhO62xLOx3kMQXwjhUSs8YhC9WtHsHGneDFmIunrXm5FIGzKFzMyae2GKwDo6ap+S9AJPBiGHtI5rHFJW8o1O7TgMkhLefYFdR29eqSN8A7GsU3dqnGosHNoSJDEh5INEuNw18BMxm46EeWBAsyXGHL8/6GWXIJSOPZrjcGlIJwrps1EsLy0HchL2+3axW25DzEw0RxXa0ErKFBO1u8t6irL9UFRR1fpTQWeRd11zDSxuyjEHQGzAj3HYqLSqQ==
Received: from SA0PR11CA0128.namprd11.prod.outlook.com (2603:10b6:806:131::13)
 by DM3PR12MB9391.namprd12.prod.outlook.com (2603:10b6:0:3d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 14:43:34 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:131:cafe::f) by SA0PR11CA0128.outlook.office365.com
 (2603:10b6:806:131::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 14:43:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 14:43:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 07:43:13 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 07:43:11 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 eagostini <eagostini@nvidia.com>
Subject: [PATCH 8/9] gpu/cuda: extend NVIDIA GPU device ID list
Date: Mon, 15 Sep 2025 17:41:35 +0300
Message-ID: <20250915144137.54858-8-getelson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|DM3PR12MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: ccbdef75-1eda-4cb8-ae2d-08ddf4663f3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Za9pxc7Ts31nzMFtSeVjHzKKzMni678raQ2VBHdlsPIzQ3VP1Odynd2fnFHS?=
 =?us-ascii?Q?YKhI/J6xnKflKwydDk2HrnQFaiJj+TvGL2K/a2R46OLvfo6GQFw+1+TcDazQ?=
 =?us-ascii?Q?+N02nO3J9GICm60BNga1fowV8kwWvB1jndVNdupMicTEvVjfXslEXqs1niPx?=
 =?us-ascii?Q?yr78KUVJqrZLbBhgvK2JDWi20cmFNSpEe61nVNJE6xk3Vkk8w5z6Se16Qf98?=
 =?us-ascii?Q?ZK1qLKaHaLD6dwWfZZjk3XL1NlkmcHvoXEcOT+hov3E/PsFkDYMQ5zQ8r5YD?=
 =?us-ascii?Q?VoS+53EH7s1Dnb7VX9om/NRut84NSIat6JvGvQZbfpb3h2Cw3WJ6IH7NUDVp?=
 =?us-ascii?Q?FjZ5KxwLI98MmCQ/vA+WND0YbhXl44K7cwWsNNxPKSqzL8Sd9rYnhiSi9ZPn?=
 =?us-ascii?Q?iRSi1oK4rvzmZT6vjmjO8XP8adbyABMlk2A6vo5W7HAfQjxoXM7s9neghjLp?=
 =?us-ascii?Q?J77lA2y8TSar2TCeFPkRNIJ+IQcVv7jGKPyiVy5prENwhsuvpRTwy6ALcipK?=
 =?us-ascii?Q?QvNHkRubfxFSVzO/fPKRDoTpSsx8d11Cre8H2riUGmTny8X4a28SeqU+fo0K?=
 =?us-ascii?Q?5Axx2YRfc/F9qyA9VCStmbF4VQ36ynXvNtP7ynx3QLHIxpG0PKCavSE9j9y6?=
 =?us-ascii?Q?N5MROUunzUJxZZW2nHB8vLV/uo8U5og1xPYh/W0vyrB1een8ye3h/7p7A9hv?=
 =?us-ascii?Q?xMc6E51UWoIEpjWtngYgm1mjGWlmJ7rCvngHbvp/ivmpEHsmLzg3+aR+2HZf?=
 =?us-ascii?Q?eby5y1QCJNLg4YanpciCG0CQkk79Hjc1mprCrSnvtjEz95XX1h9DeBF/FLoa?=
 =?us-ascii?Q?N1k9TxbAU7FPUXJjQ/rRniagpM5Xpo2G/ng5pylM6umlfo+kmQPGlOqk6POy?=
 =?us-ascii?Q?5wx3MjR2xHjuJTavP/n+CQH9mEQ1/sFbwiyLW6oFDwMXJpzW0pq8dgTSbfm1?=
 =?us-ascii?Q?vs+5V8jhvLY9AmSq3Tbb1K4fUlo0++10XKVCgFTrW1tDggNeSrrofEJI9lHE?=
 =?us-ascii?Q?umouTDHoWVRpq5zo2FjweAVUhbZvH144l/DvwwGhgjsI16Y4AxeYPg6NB0l0?=
 =?us-ascii?Q?ANHdF9+PGQ79Mu5nqlskcFYa0vyA3x5Wod/95uCUGW1/DABLpAQQrHH3FvsV?=
 =?us-ascii?Q?3Y5dCdtWAjZseELFQr0SpUy8cRCcnYUjRjE2k9CEt4pP/iHv9xT+yeh/msLD?=
 =?us-ascii?Q?QZwjAsTlHsCUi7p0SL7a5WuMfBUc8gnjuHqnKPYfj0qfzIqgYyNrrgLjGHUF?=
 =?us-ascii?Q?bcR0ApyJyQqb5ZEOt1G2XZcOFAZM+eIeJa7IQ7Q1xnwddZUk5C5SLdPpkgSv?=
 =?us-ascii?Q?jhj6gPmAVTmlE2cu6IBT1d39Wc5Q13yoMMCmg1XCfDfmCQZSXR9YCx3QWQe2?=
 =?us-ascii?Q?7Jw2QxWSCGXBCbFeUIhC/GlzX+GWJSkjl7LCOkeBUbtEpVvKKVnki36hb8kk?=
 =?us-ascii?Q?f4t9PNvX6j0XGvnsqevRw83UN/1D6BH8DKJKuRr1phRdzAO05yRAKqB9wYeh?=
 =?us-ascii?Q?X7qou9MTmU9MaB/w/qQr+xPn/ISoJau6YOIt?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 14:43:33.9969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbdef75-1eda-4cb8-ae2d-08ddf4663f3f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9391
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

Add more IDs for Laptop and Embedded GPUs.

Signed-off-by: eagostini <eagostini@nvidia.com>
---
 drivers/gpu/cuda/cuda.c    | 138 ++++++++++++++++++++++++++++++++++---
 drivers/gpu/cuda/devices.h |  36 +++++++++-
 2 files changed, 164 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/cuda/cuda.c b/drivers/gpu/cuda/cuda.c
index fb8aaf67fc..e050b6370b 100644
--- a/drivers/gpu/cuda/cuda.c
+++ b/drivers/gpu/cuda/cuda.c
@@ -223,14 +223,6 @@ static const struct rte_pci_id pci_id_cuda_map[] = {
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
 				NVIDIA_RTX_A4500)
 	},
-	{
-		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_RTX_A4500_LAPTOP)
-	},
-	{
-		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_RTX_A4500_EMBEDDED)
-	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
 				NVIDIA_RTX_A5500)
@@ -439,6 +431,136 @@ static const struct rte_pci_id pci_id_cuda_map[] = {
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
 				NVIDIA_H100XS_1_8CME)
 	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_T600_Laptop)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_T550_Laptop)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_T600_Laptop_2)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_T1200_Laptop)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_A5500_Laptop)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_A5000_Laptop)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_A4000_Laptop)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_A3000_Laptop)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_A3000_12GB_Laptop)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_A4500_Laptop)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_A3000_12GB_Laptop_2)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_A2000_Laptop)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_A1000_Laptop)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_A2000_8GB_Laptop)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_A500_Laptop)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_A1000_6GB_Laptop)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_A500_Laptop_2)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_5000_Ada_Generation_Laptop)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_4000_Ada_Generation_Laptop)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_3500_Ada_Generation_Laptop)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_3000_Ada_Generation_Laptop)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_2000_Ada_Generation_Laptop)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_1000_Ada_Generation_Laptop)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_500_Ada_Generation_Laptop)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_500_Ada_Generation_Laptop_2)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_A4500_Embedded)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_A1000_Embedded)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_A2000_Embedded)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_A500_Embedded)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_5000_Ada_Generation_Embedded)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_3500_Ada_Generation_Embedded)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_RTX_2000_Ada_Generation_Embedded)
+	},
+
+
 	{
 		.device_id = 0
 	}
diff --git a/drivers/gpu/cuda/devices.h b/drivers/gpu/cuda/devices.h
index bc096bc4cf..9577dd1f2c 100644
--- a/drivers/gpu/cuda/devices.h
+++ b/drivers/gpu/cuda/devices.h
@@ -50,8 +50,6 @@
 #define NVIDIA_RTX_A6000 (0x2230)
 #define NVIDIA_RTX_A5000 (0x2231)
 #define NVIDIA_RTX_A4500 (0x2232)
-#define NVIDIA_RTX_A4500_LAPTOP (0x24ba)
-#define NVIDIA_RTX_A4500_EMBEDDED (0x24fa)
 #define NVIDIA_RTX_A5500 (0x2233)
 #define NVIDIA_A40 (0x2235)
 #define NVIDIA_A10 (0x2236)
@@ -105,4 +103,38 @@
 #define NVIDIA_GPU_GRID_T4_1B (0x1eb8)
 #define NVIDIA_H100XS_1_8CME (0x2337)
 
+#define NVIDIA_T600_Laptop (0x1fb6)
+#define NVIDIA_T550_Laptop (0x1fb7)
+#define NVIDIA_T600_Laptop_2 (0x1fba)
+#define NVIDIA_T1200_Laptop (0x1fbc)
+#define NVIDIA_RTX_A5500_Laptop (0x2438)
+#define NVIDIA_RTX_A5000_Laptop (0x24b6)
+#define NVIDIA_RTX_A4000_Laptop (0x24b7)
+#define NVIDIA_RTX_A3000_Laptop (0x24b8)
+#define NVIDIA_RTX_A3000_12GB_Laptop (0x24b9)
+#define NVIDIA_RTX_A4500_Laptop (0x24ba)
+#define NVIDIA_RTX_A3000_12GB_Laptop_2 (0x24bb)
+#define NVIDIA_RTX_A2000_Laptop (0x25b8)
+#define NVIDIA_RTX_A1000_Laptop (0x25b9)
+#define NVIDIA_RTX_A2000_8GB_Laptop (0x25ba)
+#define NVIDIA_RTX_A500_Laptop (0x25bb)
+#define NVIDIA_RTX_A1000_6GB_Laptop (0x25bc)
+#define NVIDIA_RTX_A500_Laptop_2 (0x25bd)
+#define NVIDIA_RTX_5000_Ada_Generation_Laptop (0x2730)
+#define NVIDIA_RTX_4000_Ada_Generation_Laptop (0x27ba)
+#define NVIDIA_RTX_3500_Ada_Generation_Laptop (0x27bb)
+#define NVIDIA_RTX_3000_Ada_Generation_Laptop (0x2838)
+#define NVIDIA_RTX_2000_Ada_Generation_Laptop (0x28b8)
+#define NVIDIA_RTX_1000_Ada_Generation_Laptop (0x28b9)
+#define NVIDIA_RTX_500_Ada_Generation_Laptop (0x28ba)
+#define NVIDIA_RTX_500_Ada_Generation_Laptop_2 (0x28bb)
+
+#define NVIDIA_RTX_A4500_Embedded (0x24fa)
+#define NVIDIA_RTX_A1000_Embedded (0x25f9)
+#define NVIDIA_RTX_A2000_Embedded (0x25fa)
+#define NVIDIA_RTX_A500_Embedded (0x25fb)
+#define NVIDIA_RTX_5000_Ada_Generation_Embedded (0x2770)
+#define NVIDIA_RTX_3500_Ada_Generation_Embedded (0x27fb)
+#define NVIDIA_RTX_2000_Ada_Generation_Embedded (0x28f8)
+
 #endif /* CUDA_DEVICES_H */
-- 
2.48.1

