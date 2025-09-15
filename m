Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF4ECAC597
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 14:43:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5540340658;
	Mon, 15 Sep 2025 16:43:20 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011024.outbound.protection.outlook.com [52.101.57.24])
 by mails.dpdk.org (Postfix) with ESMTP id 8A8CB40658
 for <dev@dpdk.org>; Mon, 15 Sep 2025 16:43:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pvc+fZa4yINxWOj2lGrkPQRAQXjpXoCN4zwkq+Q3H0dsTcKtsHe5MK+6j2smL/3azZg0kwuHPdjTon/VFgjmxBgEd006JNYoZSb36B6jbOZxAUgicxQLTd/JiKdep4nF5kAth71DC7akW4a21rQECZzbstqmPgCTFjeVkqyULC8UhZJOYoLlMVLgb5nfrLdvM4ysJWqZSNxMl/ryUa3M4ovjg1a/4kjbkSgF1jWDaecgL1S7sHATl+UfV8u/TvbbQqMu09voCfAJc9nDORUIP25jF+V20BnVveSSqAN5vGTXJS1SXhOKXbGp/Q46mDdrXN1t0ErQGsaCz48rc0o2pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aiuDP9iveKhzdUrcRv7oEbTS4UEEef7ucR6SX/gLH1c=;
 b=LrJjjG70h4pWEmTGTD7oWJKZU3f2THcp8hex6MqC2+ipHcvCWx3xVUKoWt8LqPP5/RX5Eq929Znx1xc99RAxCCmrNgWscPuXTSgf+XrCD9eedZ7h2IQ5jEk7SMUAGGWZRrcd0wLdzzBm3jtX0yVT7t83A/EgRhqD3S/GWHGphokpKysfrzj6kftS1CgkZ2b+AW+4CabFuG/4ukMuWaC0t+4NYUJCZV53ov5texoW4VTsSB7iUwkIOLrXJdgvhTdNMGiMo8XYQ/RY7c5GLHkdYiBRQj9l56mSDlQTURFjA6ovE4e388lzCtKk7gMib8GPQOIVyzZsDIMQddiV47+7ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiuDP9iveKhzdUrcRv7oEbTS4UEEef7ucR6SX/gLH1c=;
 b=MYQRA/HFkUENmxFoIGobuphq+3qJBBxvRnHR7Zd8Qo60gt2YRDR4bTY67ZYqqnBaUm8W39dKBVmW8mY42TmQS/Defpc6jwoQzMBBNKjfVitIHWI91e1+jDeWsoT3wXE4awYSSOo0YibRek1cZGkf80nw5Xc6GJNJc/vNu+dZP2pUjNXJg/rE2ybtbn5hl0Ifaa/aqVo/P5qIYXysC6aHKhtCFzWXI90ADGzF2F6lzsiyHM4vWfRN0DEQAkKHSjrdoXFbLGz1TtTVUzno4u/ucvh/WFVdD9vf5kGA5CPWeNY8xBJSivRw/adHRseW1+vyElSpcC/o4vtqL11YAJ0wcA==
Received: from BL1PR13CA0324.namprd13.prod.outlook.com (2603:10b6:208:2c1::29)
 by CH8PR12MB9741.namprd12.prod.outlook.com (2603:10b6:610:27a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Mon, 15 Sep
 2025 14:43:14 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::fe) by BL1PR13CA0324.outlook.office365.com
 (2603:10b6:208:2c1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.8 via Frontend Transport; Mon,
 15 Sep 2025 14:43:01 +0000
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
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 14:43:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 07:42:57 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 07:42:55 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>, "Elena
 Agostini" <eagostini@nvidia.com>
Subject: [PATCH 2/9] gpu/cuda: new RoyB A100T GPU ID
Date: Mon, 15 Sep 2025 17:41:29 +0300
Message-ID: <20250915144137.54858-2-getelson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|CH8PR12MB9741:EE_
X-MS-Office365-Filtering-Correlation-Id: a92089c8-6823-489f-7a43-08ddf46633a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gHhQ8XGBJFoX1nXx45KsPAHpfhacBzwpsdaK7yGglVKpfs1VL1atYGoLqYi8?=
 =?us-ascii?Q?ewcnGE2tr2rh2ok7H2GFfeqaYOBr57Pu1efhUjVboKKW5nq9SsOLpdIHi7Bm?=
 =?us-ascii?Q?0Jh/LAGBSLthKzD6mG8a7OuoLXU3+OSb2U0nH232pDOwEbShORuPNsSDl4bZ?=
 =?us-ascii?Q?8aVQYx4FPC3evtSht8Oo3rAeOxQxinjF0XJ5uhWmdOuf6wXnkFuUIbZI6+g4?=
 =?us-ascii?Q?kmOaeJcKzG17rJKtU57lEvVDIir2rUkfFK3ZnmbC/YWwLzdK+gDW9l+m9vSB?=
 =?us-ascii?Q?XgleQNoBXYeIDDVo1aSpTTcq6OEXyO0ip1nd3py6ZXzbbjM5b7jyikcVPshL?=
 =?us-ascii?Q?wJwDHaLn817JNlEPrDLPOGAxWBSMPynoa4mhbXgBAMl6Ddxs/7R2G25VRXOt?=
 =?us-ascii?Q?de18CFbK9dbpmNcBwt7cqdOMY+LzRFAE5L/oBkFIytEiwTFwLizgOqMO89Xb?=
 =?us-ascii?Q?kv6vUKqYGiyMPsFnvp7jpDRKTYZ27bb0ue2PulnG8Lu4ZKe4nZw/CLn5ynWU?=
 =?us-ascii?Q?OWtlTE6da02oQoJd7WpDVT88AIkaoi2H3K1Bb5e7QzV1IbYiPjjVMPyabJ1J?=
 =?us-ascii?Q?TiAcRwDHlegqzjzc6MQTtW+j6Axj+V62oJz6OExscGqR613yzVEQ3hx0zKE5?=
 =?us-ascii?Q?AdBTmhhezIwQcD0KgDCf+w8ZgfxG+f9kF6uEHqZOkD8XvmkPuZ+RJtDgI/66?=
 =?us-ascii?Q?X1F5nV44pMYJxQuWn8Jy56i0T0VWdn118zTbiYHOkoz6eAUT/15WxFIPer9y?=
 =?us-ascii?Q?0neCfKiKyPgOXDcATbJHpX/6X+4y27z3oAZqOIXAAe3FlOBXCQCnUoG5H/oZ?=
 =?us-ascii?Q?ILXJz71c28GU6sc5/FRzJoPLgyYOe7hjkD0V18Lvt6YwHvB5ViySKcwbnN3u?=
 =?us-ascii?Q?A7Nu7Kj/2D/bGAY3xO4sR4V6fWkklo3/KVEA1Hlot5VjoLvZXMWrh0Pu1Nti?=
 =?us-ascii?Q?URk9PgSz7w+axDgJ9wG3N0iMInvODkJaF+gm9ronQgd01AzhQpaY7pwx9L6+?=
 =?us-ascii?Q?sbo2WKiADCJd1ne4NLdC0uN9u4Kp7oH0emACdqeGCj73JiLtT+TTUTz8uTff?=
 =?us-ascii?Q?GkPoPnaDeCo4AaJ/D8IYJdWmyhcWW07zf9dgd/Y6XLTmDthfvxWytapSMfZy?=
 =?us-ascii?Q?IWEYfpU3GTX4hCRIBTTyOaorPxvqjtVwP4gtAjePsc1wFSUg/UFr41f8zOQw?=
 =?us-ascii?Q?wDuZDw/ttkXslwZOCyP/gjoa28aGOvBoXtbNoMD/NBwpNgvXl5KE3scyzARK?=
 =?us-ascii?Q?7gADr0ZwfrYQvvDIQOOIo6RhXt1S9Xf1bi3/XICgjinkScPWBvm4Z7guUGHe?=
 =?us-ascii?Q?u8Mi5uYJ9O9L0sZ3rGyFwLRrOhXkCVFaq1ghnzH8G4cpJdMpFv6maqWNSVRu?=
 =?us-ascii?Q?F+TnOCwZ2fN8GVSKJvwpb76iCkZhD9I6TzAWSedyAdWUR+lHHWugJzncJ/CM?=
 =?us-ascii?Q?8xnPw7EZ1LDc0hPzL+4Ta+E1N83KEhMGoPYM7xHtnuOEshDBbshownm4/w+g?=
 =?us-ascii?Q?BwsJ2QulCH4TvB7sTd4I1y67T2COF/HtlrmD?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 14:43:14.5174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a92089c8-6823-489f-7a43-08ddf46633a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9741
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
 drivers/gpu/cuda/cuda.c    | 8 ++++++++
 drivers/gpu/cuda/devices.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/cuda/cuda.c b/drivers/gpu/cuda/cuda.c
index ff8c29f970..0af955421a 100644
--- a/drivers/gpu/cuda/cuda.c
+++ b/drivers/gpu/cuda/cuda.c
@@ -123,6 +123,14 @@ static const struct rte_pci_id pci_id_cuda_map[] = {
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
 				NVIDIA_GPU_GA100_PG506_217)
 	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_GPU_GA100_80GB_ROYB_EB1_DEVICE_ID)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_GPU_GA100_80GB_ROYB_DEVICE_ID)
+	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
 				NVIDIA_GPU_V100_16GB_SXM2_DEVICE_ID)
diff --git a/drivers/gpu/cuda/devices.h b/drivers/gpu/cuda/devices.h
index e45521c7cf..e138a600d6 100644
--- a/drivers/gpu/cuda/devices.h
+++ b/drivers/gpu/cuda/devices.h
@@ -27,6 +27,8 @@
 #define NVIDIA_GPU_GA100_PG506_207 (0x20f0)
 #define NVIDIA_GPU_GA100_PCIE (0x20f1)
 #define NVIDIA_GPU_GA100_PG506_217 (0x20f2)
+#define NVIDIA_GPU_GA100_80GB_ROYB_EB1_DEVICE_ID (0x20f5)
+#define NVIDIA_GPU_GA100_80GB_ROYB_DEVICE_ID (0x20fd)
 
 #define NVIDIA_GPU_V100_16GB_SXM2_DEVICE_ID (0x1db1)
 #define NVIDIA_GPU_V100_16GB_DGXS_DEVICE_ID (0x1db2)
-- 
2.48.1

