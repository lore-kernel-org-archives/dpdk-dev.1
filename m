Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062FACAC597
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 14:43:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B75240676;
	Mon, 15 Sep 2025 16:43:30 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013029.outbound.protection.outlook.com
 [40.93.196.29]) by mails.dpdk.org (Postfix) with ESMTP id 26E4140674
 for <dev@dpdk.org>; Mon, 15 Sep 2025 16:43:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=caf134GkmZuiyEhKWDHKEJKR5b+knuJusAY0UEQ96e1G34E639AJT7i0oWiYUhJRaBhRQ++5nx5FO03xJNQEabVYyr48NJ3dBLV6Pk2Tdeyb4VhPaPMDb/NsvdEWG7X4mfc+qs9c81v0KZKqrPchlXX9ZnO2jK5DhxE958upDp2s+9yKkbCpUvNIowT9dP1Z2SXTEKzffMOHV4TXufdkcbea7DEpa05HR5QuGRhhh0pnpe0E7uSkQoFyyg8O/rWSmXtjUejTT3c8BG/tBlz402DNlS1+OKaRdWoUxkmhls2gyAMARePg7uCOzTVH/0SfKDU+lkpzJVv66iNY3JpI5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHEmDgTLZayztOjSpAP2h0c3LGLapSA6pJGl1n/ra2U=;
 b=UpqkM70y1GckFvIeypYqrCjA5GAPAbAIhXkJPwnWN1gdJZOikSXLEUPauNQ6o7WS0s0EXYVNeG/6hIq3EDvTwS2mDf7DTLx5XoJ4PQjzai4UQWtspbQsEYq1MjcxA1JJHXpdBIep8lkmAhqDeHGB6FE7gC9uKIKTX9UTLKD2RSkwQV8Axtnhlz5wE9FRPScmvVYqs/ehZqwnQkn8I1QoYOLmfiJnkx/B2dV4w6YEeAEX0famQLM0nc/U53Zt6n5WHStfZWa14Lug1rWZRCEt31oGNMSRTClNMgpmgdLHsHF+MoutN81NP9trm0i16X/LMo9kVz1J9lp/85YrEsVfZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHEmDgTLZayztOjSpAP2h0c3LGLapSA6pJGl1n/ra2U=;
 b=RxsvkFaHLNu38Zwm2xSjkg3wKqmp6I2HQnyqklxTV2vPR09I1n5oZb2G7TmjPn9nG1x9mY8ZpirT3heJDvVWrNFkok1mYE7Aed/ple0VmmHvfPlGqB9IFyacnTmumT05HLjhIQS5Swj0vaYZ6Ft83VzAT2WxrfiQu9IzLT0frgkCEk/5ODbPAFqOQ8MZE/RFcNoORzoRavu0CV7mXJVlclQ2faT9OZu8SafsiPQrNCGXvsAK0JSYeKPbBlsyN3QXFyvcecd01Kwk61VPB1UF/+PVh+l4V+dMtngV+YVem0RtTT0lfJbjim+0kXYVb9isAKEJhLuHyWeOughSgb16tA==
Received: from PH1PEPF00013309.namprd07.prod.outlook.com (2603:10b6:518:1::18)
 by DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.21; Mon, 15 Sep 2025 14:43:26 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2a01:111:f403:c91d::1) by PH1PEPF00013309.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Mon,
 15 Sep 2025 14:43:25 +0000
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
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 14:43:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 07:43:06 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 07:43:03 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>, "Elena
 Agostini" <eagostini@nvidia.com>
Subject: [PATCH 5/9] gpu/cuda: add new gpu hopper 80gb device id
Date: Mon, 15 Sep 2025 17:41:32 +0300
Message-ID: <20250915144137.54858-5-getelson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|DS7PR12MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa346e5-183f-42eb-0442-08ddf4663a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MExEq/ZLVy9gemAziDod+5S/axce5tKO78IBWcwcWKgTZYiSqIp4EXpUoQIk?=
 =?us-ascii?Q?7woV1fR57o4UkhD5vH38QB6eoQWEsM/vI93kgg2lazxj5grAjNVxKhbrUpDL?=
 =?us-ascii?Q?FCafU7i1OXuxk7/iSdBYhhGVV0021BI7bflsTH15xK6INNmjW9Kt/NAv8eHa?=
 =?us-ascii?Q?Q+8ftmspma1rYty94R5otHJVspchPWEcEKXOM0Jzf8X8aLJ9PhUT7yZWtWyU?=
 =?us-ascii?Q?swqvuYmkbi7uSkziGGuyNxNMmmieaPBUHBMjhtTkBXo97pSZRlN+Oh0AeRXl?=
 =?us-ascii?Q?D55ihqcVzVD+w0XBqr+PverEXfRIibnN5dKhzTUxgDk2M0Kkcep7Xvd9OIMv?=
 =?us-ascii?Q?XZnvWTiVSCTFZTFDE5Ky0gSyEq2pujhrms/gnx79G9yx3NQflHbxMe+ccQ76?=
 =?us-ascii?Q?l0qkCV8DUYfjmjUc84RvtZIhmTuJ1y7nFLmQKI2J/oP9dMCbvUv6epMG1rf5?=
 =?us-ascii?Q?8/cpuZqxpVTIRRZcOxzkQU5pQRBDmWQidAmWaBqBvv4Q+ft9eaSae4keDLqY?=
 =?us-ascii?Q?11WbfCId8zTwEYZ9D1Rm0hiEk2tVjWhEjBH+8bupfJml1/Ii0ZIw/c1ySkDc?=
 =?us-ascii?Q?jXmF2sy8BbJpbxzxvoTrj++nvh3qZwzY2WKZcRdOPbtJ6Qn9Fv7ZgCfKDjMj?=
 =?us-ascii?Q?7hBEN5fPnVkPf6sXtv/334xdGcv9vxLgXnMD45pgWCeZ/MPgM4cZL1sJGg2p?=
 =?us-ascii?Q?5bnMt3gUEVCMxZcy16vxO1QqsrerXIwVKJ5rrxHIep66pdvzOSDeURaJxi6t?=
 =?us-ascii?Q?cBAeHOeUidoC8KgG2pdXuBORDRJfk2u6ijncuY8f0Om9S4bg+NlqBt7BX3Oy?=
 =?us-ascii?Q?ZBynfeJbOwsfERBh+2l/4j7Dg9ovPEMskmEfrSRF7qTYV63mf0wnuUbhnc8D?=
 =?us-ascii?Q?mI4yAdnWfxpLpOG3q08YCwsGTblay0PE2xUv6t+OV8NV6A/zfvzwFDdYw+66?=
 =?us-ascii?Q?s8a94Uu+91NH5KiFsLLZWHs/RGcRnjBSnZEUS20/bYfWBo4TDhX+iPzBr1fQ?=
 =?us-ascii?Q?KoI4nDUl9beVVd+mlVit/TQI1kb9sSh090M3unpYmg0A3IqJNDLaGzLDNAdk?=
 =?us-ascii?Q?tjurScLuwWu5lODzqqDWA+jsn7RJKg/bfBdLhY8sfayVeGCoC6wwp4PhCqGH?=
 =?us-ascii?Q?Q6HoIh7ZTli0BNw3+Oy4BG1jNp370imGTCu3nk0dCSJPSJMeZCdNAK6sFDAj?=
 =?us-ascii?Q?4P34yetyT5ZgMDj3mtv4qOe28BCTgBaUTL94Wn11PZBsL3TjZoYlBiWEd2UH?=
 =?us-ascii?Q?riIoBz9q5J7GfVJwu7m84E+ITJEVIGzZxflkarOwHBTGawuCSp5AVARIS87d?=
 =?us-ascii?Q?qKGE+IjCOd8Vzk3NkuYd0jigFynZTWLCPsDDTiaM4VhPwtgjKucEoRm3R9eV?=
 =?us-ascii?Q?BRqxMZD+/uSWyp9uJYS+zOV+fP89nscs2aYbgDaFzrmiAixKEd0/OqoRdHuI?=
 =?us-ascii?Q?8Jd5uEeF7JW1YPVHNKwJ/7Gfc2Ej3NslDD9YOKhaNdcK+IpgCK/qxzJzD1EE?=
 =?us-ascii?Q?iSzEvQaFgpCa+YgRsDRv3GTDPwktBJ5dLWIK?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 14:43:25.5315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa346e5-183f-42eb-0442-08ddf4663a2a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6048
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

Added the new Hopper 80GB GPU device ID to the list.

Signed-off-by: Elena Agostini <eagostini@nvidia.com>
---
 drivers/gpu/cuda/cuda.c    | 12 ++++++++----
 drivers/gpu/cuda/devices.h |  3 ++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/cuda/cuda.c b/drivers/gpu/cuda/cuda.c
index 9eb748dd2e..16778e1160 100644
--- a/drivers/gpu/cuda/cuda.c
+++ b/drivers/gpu/cuda/cuda.c
@@ -63,10 +63,6 @@ RTE_LOG_REGISTER_DEFAULT(cuda_logtype, NOTICE);
 
 /* NVIDIA GPU address map */
 static const struct rte_pci_id pci_id_cuda_map[] = {
-	{
-		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
-				NVIDIA_GPU_H100_80GB_DEVICE_ID)
-	},
 	{
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
 				NVIDIA_GPU_A40_DEVICE_ID)
@@ -263,6 +259,14 @@ static const struct rte_pci_id pci_id_cuda_map[] = {
 		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
 				NVIDIA_GPU_H100_GH3_DEVICE_ID)
 	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_GPU_H100_80GB_DEVICE_ID_1)
+	},
+	{
+		RTE_PCI_DEVICE(NVIDIA_GPU_VENDOR_ID,
+				NVIDIA_GPU_H100_80GB_DEVICE_ID_2)
+	},
 	{
 		.device_id = 0
 	}
diff --git a/drivers/gpu/cuda/devices.h b/drivers/gpu/cuda/devices.h
index 9f93132217..2968da2c8f 100644
--- a/drivers/gpu/cuda/devices.h
+++ b/drivers/gpu/cuda/devices.h
@@ -10,7 +10,6 @@
 
 /* NVIDIA GPU device IDs */
 
-#define NVIDIA_GPU_H100_80GB_DEVICE_ID (0x2313)
 #define NVIDIA_GPU_A40_DEVICE_ID (0x2235)
 #define NVIDIA_GPU_A30_24GB_DEVICE_ID (0x20b7)
 #define NVIDIA_GPU_A30X_24GB_DPU_DEVICE_ID (0x20b9)
@@ -71,5 +70,7 @@
 #define NVIDIA_GPU_HOPPER_GRACE (0x2342)
 #define NVIDIA_GPU_H100_GH1_DEVICE_ID (0x2342)
 #define NVIDIA_GPU_H100_GH3_DEVICE_ID (0x237e)
+#define NVIDIA_GPU_H100_80GB_DEVICE_ID_1 (0x2331)
+#define NVIDIA_GPU_H100_80GB_DEVICE_ID_2 (0x2313)
 
 #endif /* CUDA_DEVICES_H */
-- 
2.48.1

