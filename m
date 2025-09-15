Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCE2CAC597
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 14:43:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8295440687;
	Mon, 15 Sep 2025 16:43:33 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
 by mails.dpdk.org (Postfix) with ESMTP id 503054067D
 for <dev@dpdk.org>; Mon, 15 Sep 2025 16:43:31 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmq5qJ9fX+cblu8otsXx4Rqo0zeGq8KQ9NVauTNY1dbQPsn5Hoo+M4Y25VsM7hjv/RLXKlRKjKL4hYTEFmKCRvjpNBGd3eC/iVjEVSm9psaWUaGD1WoGx81DYSi6Sa3DblmxkVTLiU9RFz45wlsi3T/EMIeGn0mt5MK5whpDzTvz5O+6fRqgLJSUkIurE57jkA+sCafJAQIlpAstBNKzxXfXKAWqrGmkxUb1otCQwBjwLgPWHyC4wQEQ0eZ4OcRDCKX8QtR2XiX8e+xWqQJaNt7/oBvlHkT/j6FeWzrrA2162K+yrCi3VUlaQ3yWl1QUn8nopYkxnx2l5FpR9bzMHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iG5vA07cpIEp4fI29AD/6hspLtnjxIoiEzJZ1pKEDVQ=;
 b=L3d+QX30dxAFs9KXpiTevQrnR0Hxco+a7AfGCPjOv6CaeJBQrRqQSC/k78gz8o5Jq5psSiVjirPYgKHrruis9DpaYD/eEPVhOhgQ4so+4u3gNQmPeK/+DdmvQ3SbcHLLp9Y4cyvaW0EZ7mc52Ri09PJUX+PKrNC5TfB8RbeiHjZ/acNE8CXwbDIBkBp4uH637Z8yvSZ5t4FAiJvAVxK8aSYIN4j7myu9IHnNSupc38nBPi2mOi6fVYdSYosDE0ZbIfgY5ybkz2vpE9/g8UZ8jkRpope0LwQaR7TGIS/w2wpJNrcfWuQz7du+e8G9gx6yPB8YV5kN+bmA+OsiTmHVfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iG5vA07cpIEp4fI29AD/6hspLtnjxIoiEzJZ1pKEDVQ=;
 b=HlXLL+XEuDhp2F/nIT69rnI/eurfzJ9cXwAEgnRuoHZuEwJlSgtCIAJl/VPhvtad4UDrBW4Fh9Q5ec05z9gnNYcFOPvuy8wFHIC0ejdR7jInxT1ugmcDaAL2/waiGCjToD5vuBUqq8ZFqoAdptCqRmfQLdiPBlmwnpEA3/N0TfcgvCdK3ZfFvZdt6Kl0Ex3RuszMW4fj7dSyYuLfA0MkHPwXXjqGa72BkWL2a1TPQ0AikS5DLlHhz8Upq96HkOF3KgeAzg1flYow/xIgTaWm4hOFJd13IgNZ9T3ZFkUVzpqsTbMYRTlXfHXArI/3vmBGx01+yGbsDX0GO7hZYO+FgA==
Received: from PH7P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::30)
 by CH3PR12MB9393.namprd12.prod.outlook.com (2603:10b6:610:1c5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 14:43:28 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:510:32a:cafe::a) by PH7P221CA0022.outlook.office365.com
 (2603:10b6:510:32a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 14:43:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 14:43:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 07:43:08 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 07:43:06 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>, "Elena
 Agostini" <eagostini@nvidia.com>
Subject: [PATCH 6/9] gpu/cuda: more gpu ID for h100 and l40
Date: Mon, 15 Sep 2025 17:41:33 +0300
Message-ID: <20250915144137.54858-6-getelson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|CH3PR12MB9393:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c10ac1d-288a-4bfd-d969-08ddf4663bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fh5b4jp8KIQ3s6tqH0ugPHW59WzBkwaQqnlug8MJO5YnhuZGCblxuFsi+UsH?=
 =?us-ascii?Q?UrVNK0s123DTkrsQHXXjpRlHs/Qc172HK6uxawUfWfafNweBqoeaxSAub6N5?=
 =?us-ascii?Q?oMw1QQn+TWhqgHk+WD0tcNowvL13DGmIeUPh5r8eOzjtpnHjz4R1MRWpye6/?=
 =?us-ascii?Q?6QAo/gOjSyMORBg/A9bkKG0qRGyC1+18pGpRaWdxLd1DV8wDIASpuhYbKeJN?=
 =?us-ascii?Q?FQcs/LPYp7GuUHe7yHC6R7e6YhUH09EyevNcT2JWjAVHwvI878RgkaC4dPt/?=
 =?us-ascii?Q?d424TOJK/wNUIc6ba8NZtFZHyMcY8F2PlqBLxDo14VFJ4PUUQFJH83jXZNPC?=
 =?us-ascii?Q?D8xZEkLehBcURzTXCUxdMJRa0X55g7LVdQvKV0bLP4eF4f2cjKLcWWAjmcsk?=
 =?us-ascii?Q?4M97/Ce0khF+QoW85OWl0JT/2LyxoeBDc8SKXGGk6eDVeCfxMt4AyNSwbpzm?=
 =?us-ascii?Q?LJWnjIsMR3dcHGMF2DODTkxHOjKtk8zZ7NBqVGxu4elV1ZO7RHsejCFxi6Js?=
 =?us-ascii?Q?tHAV8et73KzTZ2zukGYkbY5HN03yQa40zLRslnH/zB3fBK04qYptUUXoR0zW?=
 =?us-ascii?Q?K5CYToFrOXNevOmkxlNCn8pvRtwVUJ/lQa72hR1M/av4L03zh9U2jaRQwM84?=
 =?us-ascii?Q?I+Z/WamL1kQtjNxiyJcK3HE1QB2du9uI2MfrNr/UxweK209LN3w86v20naOT?=
 =?us-ascii?Q?Tw9RUBcVJOLh+yusxHtqqOmTMsBRRMsQHBArov0sElQnVTIWWvVDNtoVb59M?=
 =?us-ascii?Q?GC7os4UwaORFw9mLxKt2ZfKEyW3SDBZRFJ83Yq84r1uYbeeHykLIqVRIst6I?=
 =?us-ascii?Q?4xc3gRCT5fe3XxowQlN3Hq4u4bCQKbfm7Br/9sY922LdcPlzYesrxi/9hVsE?=
 =?us-ascii?Q?oXAiWSmcn7qodH5VBxvLNCM26ZSowhwYU6T0zfrWVmcl6Su9wmRSnwvk/rZ4?=
 =?us-ascii?Q?CHluc1SUtoLecp6+dq/P1qYtET1wFFt84kGoEFs0uuLyoPlJzUvsjV8iJYar?=
 =?us-ascii?Q?CwOZbdyzLInUUQth7cDI2rx3sspRFO/rivMXNjYqgIU1jCAMAqeujkQPeiM0?=
 =?us-ascii?Q?Zxhx+GrL3fUzZ0ettrJrXq0i9GpzTXkpl54tc9hAQxmOmvni0ivYXmiC46hW?=
 =?us-ascii?Q?FUSIu9r2Q9Fo4MJrYXugaODh5nHjepLcr8KehyC3XN7DXWcFZObGIvhHStSH?=
 =?us-ascii?Q?tbW0IPA60BQVvxTS7XjssQ4U1/rXih8wIxf7H97Pkme9osUvWJxnckr5/DjY?=
 =?us-ascii?Q?LJdaAG49dYz9BC90bE/34kkF60ANOW1yNxjhP8mSRLua6aZpRIBkK6A8MW0Y?=
 =?us-ascii?Q?RxaD9TPhiaM0/yvCcFGSSsVKqoDoAIc7nhslynWO+sPC8NywdmVD2Phg0a8r?=
 =?us-ascii?Q?HQswMTNYrukVs4FTMBSh5aQqmpcPB4ck3oQXpTQEo3N8iy1iYPlERE12ujkD?=
 =?us-ascii?Q?aOF+p1nqs3O5wc1ulr/NKX8v/fyey0LQ9luceNgV8qUcKcW12XNA3ZrNsYhB?=
 =?us-ascii?Q?4UN13lqklY5qDluh9Y13pNFajjXnKWQo5QV8?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 14:43:28.1021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c10ac1d-288a-4bfd-d969-08ddf4663bba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9393
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

More gpu devices for h100 and l40

Signed-off-by: Elena Agostini <eagostini@nvidia.com>
---
 drivers/gpu/cuda/cuda.c    | 66 ++++++++++++++++++++++++++++++++++----
 drivers/gpu/cuda/devices.h | 23 ++++++++++---
 2 files changed, 78 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/cuda/cuda.c b/drivers/gpu/cuda/cuda.c
index 16778e1160..a94c4baa64 100644
--- a/drivers/gpu/cuda/cuda.c
+++ b/drivers/gpu/cuda/cuda.c
@@ -87,6 +87,10 @@ static const struct rte_pci_id pci_id_cuda_map[] = {
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
 				NVIDIA_GPU_A10M_DEVICE_ID)
 	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_GPU_A800_DEVICE_ID)
+	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
 				NVIDIA_GPU_A100_40GB_SXM4_DEVICE_ID)
@@ -121,11 +125,23 @@ static const struct rte_pci_id pci_id_cuda_map[] = {
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_GA100_80GB_ROYB_EB1_DEVICE_ID)
+				NVIDIA_GPU_A800_80GB_SXM_DEVICE_ID)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+			NVIDIA_GPU_A800_80GB_DEVICE_ID)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+			NVIDIA_GPU_A800_40GB_DEVICE_ID)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+			NVIDIA_GPU_A800_80GB_ROYB_DEVICE_ID)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_GA100_80GB_ROYB_DEVICE_ID)
+			NVIDIA_GPU_GA100_80GB_ROYB_DEVICE_ID)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
@@ -249,23 +265,59 @@ static const struct rte_pci_id pci_id_cuda_map[] = {
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_HOPPER_GRACE)
+				NVIDIA_GPU_H100_GH1_DEVICE_ID)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_H100_GH1_DEVICE_ID)
+				NVIDIA_GPU_H100_GH3_DEVICE_ID)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_H100_GH3_DEVICE_ID)
+				NVIDIA_GPU_H100L_DEVICE_ID)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_GPU_H100XM_DEVICE_ID)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+			NVIDIA_GPU_H100_PCIE_DEVICE_ID)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+			NVIDIA_GPU_H100_GENERIC_DEVICE_ID)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+			NVIDIA_GPU_H100_80GB_DEVICE_ID)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+			NVIDIA_GPU_H800_PCIE_DEVICE_ID)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+			NVIDIA_GPU_H800_DEVICE_ID)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+			NVIDIA_GPU_H800L_DEVICE_ID)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+			NVIDIA_GPU_L40_DEVICE_ID)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+			NVIDIA_GPU_L40S_DEVICE_ID)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_H100_80GB_DEVICE_ID_1)
+			NVIDIA_GPU_L40G_DEVICE_ID)
 	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_H100_80GB_DEVICE_ID_2)
+			NVIDIA_GPU_L4_DEVICE_ID)
 	},
 	{
 		.device_id = 0
diff --git a/drivers/gpu/cuda/devices.h b/drivers/gpu/cuda/devices.h
index 2968da2c8f..9b5299f3f1 100644
--- a/drivers/gpu/cuda/devices.h
+++ b/drivers/gpu/cuda/devices.h
@@ -16,6 +16,7 @@
 #define NVIDIA_GPU_A10_24GB_DEVICE_ID (0x2236)
 #define NVIDIA_GPU_A10G_DEVICE_ID (0x2237)
 #define NVIDIA_GPU_A10M_DEVICE_ID (0x2238)
+#define NVIDIA_GPU_A800_DEVICE_ID (0x2238)
 
 #define NVIDIA_GPU_A100_40GB_SXM4_DEVICE_ID (0x20b0)
 #define NVIDIA_GPU_A100_40GB_PCIE_DEVICE_ID (0x20b1)
@@ -26,7 +27,10 @@
 #define NVIDIA_GPU_GA100_PG506_207 (0x20f0)
 #define NVIDIA_GPU_GA100_PCIE (0x20f1)
 #define NVIDIA_GPU_GA100_PG506_217 (0x20f2)
-#define NVIDIA_GPU_GA100_80GB_ROYB_EB1_DEVICE_ID (0x20f5)
+#define NVIDIA_GPU_A800_80GB_SXM_DEVICE_ID (0x20f3)
+#define NVIDIA_GPU_A800_80GB_DEVICE_ID (0x20f5)
+#define NVIDIA_GPU_A800_40GB_DEVICE_ID (0x20f6)
+#define NVIDIA_GPU_A800_80GB_ROYB_DEVICE_ID (0x20bd)
 #define NVIDIA_GPU_GA100_80GB_ROYB_DEVICE_ID (0x20fd)
 
 #define NVIDIA_GPU_V100_16GB_SXM2_DEVICE_ID (0x1db1)
@@ -67,10 +71,21 @@
 #define NVIDIA_GPU_T4G (0x1eb4)
 #define NVIDIA_GPU_T4 (0x1eb8)
 
-#define NVIDIA_GPU_HOPPER_GRACE (0x2342)
 #define NVIDIA_GPU_H100_GH1_DEVICE_ID (0x2342)
 #define NVIDIA_GPU_H100_GH3_DEVICE_ID (0x237e)
-#define NVIDIA_GPU_H100_80GB_DEVICE_ID_1 (0x2331)
-#define NVIDIA_GPU_H100_80GB_DEVICE_ID_2 (0x2313)
+#define NVIDIA_GPU_H100L_DEVICE_ID (0x2321)
+#define NVIDIA_GPU_H100XM_DEVICE_ID (0x2330)
+#define NVIDIA_GPU_H100_PCIE_DEVICE_ID (0x2331)
+#define NVIDIA_GPU_H100_GENERIC_DEVICE_ID (0x2339)
+#define NVIDIA_GPU_H100_80GB_DEVICE_ID (0x2313)
 
+#define NVIDIA_GPU_H800_PCIE_DEVICE_ID (0x2322)
+#define NVIDIA_GPU_H800_DEVICE_ID (0x2324)
+#define NVIDIA_GPU_H800L_DEVICE_ID (0x233a)
+
+#define NVIDIA_GPU_L40_DEVICE_ID (0x26b5)
+#define NVIDIA_GPU_L40S_DEVICE_ID (0x26b9)
+#define NVIDIA_GPU_L40G_DEVICE_ID (0x26b8)
+
+#define NVIDIA_GPU_L4_DEVICE_ID (0x27b8)
 #endif /* CUDA_DEVICES_H */
-- 
2.48.1

