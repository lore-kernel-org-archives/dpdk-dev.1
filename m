Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B7AEA7196
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Apr 2026 11:18:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 478D040291;
	Sun, 19 Apr 2026 13:18:16 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by mails.dpdk.org (Postfix) with ESMTP id C1CAE4021E
 for <dev@dpdk.org>; Sun, 19 Apr 2026 13:18:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RayoZH/8j5WEpNt8CxLasfccTDEtl2gzRVa4ZnTrSNuIwAiJHvpu2YeNevi5zzCpHdjTA+x/ONWZpa5oDgwKHNuBCnCJT8sPk1lxlQpjnTclw3KoNIhvfnKd8+VgJCvGmK1zbcoc5WeosGyyTtv8t0WehjOb6WolyCnF06ZU0pIVT6+X3AC3ldw3Un6/FZ1f23u9Ro637FJzgcBteVmXnjYTJlGXMdHKCp+LVB3br99F84eW8F84XYFH/h1vSjKR/ILl0fRXTEq9lcBL32cIWdV9I+u6JoMtjeaBEQL4cnP8a37OIaiTXNvQLydHzkoJltBUktbXQx41tzUfUp9hhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1xI9leMztOgKV5tCUx14hki469tw6c4AS0+etxdD84=;
 b=siZGTD0NxewpZFpl5RBq0wXwprkwAiqfIl/HZMG1S01F4BYcFOIkffaVPBrTPiUpZ/iUyYvbkhfzgzYFQlJ2t9PKkxzxMftJcmhluIW7jZoEJa03rbQZzjfmd+jjmu3AEc7gXe/+BpiCxqW48VSNodT7P9HkXpgYf5dHnIJRhODH8o83WprB1F03AqNoapofO3e1CoPosYdSHPq8X4hFLxTywtwQoGvmYoXU7JXL2GB89M0+DErqzGlLmwXyNfnsOqggLqp84Q5UYWK2LTmCuypUL9tsydal8XSY/RUPXqYARfbjL2s8i7pGoD8dWF18LZ+Ykc5FwqMhZIdEA/S4IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1xI9leMztOgKV5tCUx14hki469tw6c4AS0+etxdD84=;
 b=SJoTyFeuvrJZYwyIRdy0/sUgjyG1MPoSvwXMkRkrZRSquFOXloilm8U4qNz6FLUHt68SsRtA5Gg2FBVQm2qe2rRsO8P1rTKu2ITi/ZCk/s2p/LJFtgK37GkQGjbEkFHhy2cI3u5z52GC71PWw2Ci97w/3Xy/0rr3t3ymWn+ZthbfWTf8TF7ZuXvb9nVwSLu2k31fC5z62+neQCg1QLlg73lPEZdrDPlypiCss1jpRuHVfHliWgrzHAfQruL6ejS5D+uRSIu19nb/6L8FsZVHWvVOuPmGVVHCFzaeMJZjEfF5x8ZlZbB2rs8hadzgY/aqFVQO0NhsKd/8Cc15Ha+X8A==
Received: from PH7P220CA0037.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::18)
 by DS4PR12MB9611.namprd12.prod.outlook.com (2603:10b6:8:277::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Sun, 19 Apr
 2026 11:18:09 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::38) by PH7P220CA0037.outlook.office365.com
 (2603:10b6:510:32b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Sun,
 19 Apr 2026 11:18:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Sun, 19 Apr 2026 11:18:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 19 Apr
 2026 04:17:50 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 19 Apr
 2026 04:17:47 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: <dev@dpdk.org>
CC: <thomas@monjalon.net>, <dsosnowski@nvidia.com>
Subject: [PATCH] common/mlx5: add ConnectX-10 SmartNIC
Date: Sun, 19 Apr 2026 14:17:21 +0300
Message-ID: <20260419111721.7301-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|DS4PR12MB9611:EE_
X-MS-Office365-Filtering-Correlation-Id: 58397231-5db7-4e90-6ca8-08de9e05564d
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 02bBGEagcAxUL2FTeDhuB3MSuyuzt8iauJieu2TiEZfPn1MGsSAcuNvm8OJE4DBbhmBWSvH45U52bUAP0w/6zKPvh26VMSTBekEgjCp/R0lRJR3kqDtYOMZL5CYdvktFvMIsMSU2sXRfex4r/82aO6WBlD4ZrB11iTzkkmc7Jf4zEQ+yeVHWffz7t2Z5Sa8XdE/9vqCD3xHflxlJMbvmWR3BB2GOq9tyCtLfufHTKFHIscK377y1rG34pa3KcdDEZ2tH/mMh2Vr/Lx1wEj/ps6MecszunCAfR5+D35BfqF0rz5Fj5uLUVj8YI6aYI3JiTQmRzAGY2rNKXCSALS6lzUZeRSWguoQ1E8m/1K5UmvI75Ur83lVooi651bo3h3eIp3Ib3c7GbUZqb8lkwV5QN0LpvAcp6OL2CLpqhAA1GKMKo9+bJSv5E56p+MxUrOwa0f7EH80Uqdn+IKlchMDmDACRw9jv05ojQ5lgvcvIeCPkFelxduyH4Gy1r1AsHDtKMzPmtFib+P7vOkq3cSksAFlbpXtZ6pucE5aOEJ5fuC0Lf+Oc1tLIOW8ELEFomDpNIvEFc7+EnuRV8+5D/KujhCm3iSKXPpE4c2mDzyMQLt5+tJTgFKr0Qql+gXJntlzmA+HWhJuNIHzU/l/dSYqu+I8Jxw7/O85OgOnoxrVvMF8+5vUXrkIyCE55iL5uAv4cPRDBn1ebGywbkagdsBUSmA21bGgpDqfoKTMujWiXgN6wT2nzmJ53lHlXxh3R4u0Jnc8SgfyfdpL0kVmdHozdgA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uZoxxh3nYhs0qS2MjbYkCLnarrAidA7YexRKpcfYX1pOren74EL5cTJO2bXyo7OjpCKZbC2IPkTAxjYL3bDL7x2oDZY6iKMWoTz9A7F6Cub5Ye3SX5M+U37Zf5qWc+maEVAnB8oV3ZQoUtfnTmj6LsYY5lp12OUKDOMhCAVmwtZKHzfOtZYG+ZKhmQ6KgumZG8sSKitMDRjBuIIjCUZt5TVEi76e31Zuu1WFbdONqRtRbVPGzI606iK7tota7FBjV3Ymod7st1y3x6TZ/tXrKyxc928yUm+sQ184Dis+/0AW9aEzWM1TQYMpMCsc7dTeoQyUz0Rc3ap3Kx9Pls8H0ANW4/KoAl0lTlLIafGC5Lek61OnFqOvxoQDIA0QtHOB/hp+Zx4FtTSFIqTIAIwCtB8OOyNO9M0T29r21CNKsUFInOPRiY+zH+gg9nbeSD3z
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2026 11:18:09.1651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58397231-5db7-4e90-6ca8-08de9e05564d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9611
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

This adds the ConnectX-10 SmartNIC device ID to the
list of NVIDIA devices that run the mlx5 drivers.
The device is still in development stage.

Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>
---
 drivers/common/mlx5/mlx5_common.h | 1 +
 drivers/crypto/mlx5/mlx5_crypto.c | 4 ++++
 drivers/net/mlx5/mlx5.c           | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/drivers/common/mlx5/mlx5_common.h b/drivers/common/mlx5/mlx5_common.h
index 47fcc3fb06..b8f0235f47 100644
--- a/drivers/common/mlx5/mlx5_common.h
+++ b/drivers/common/mlx5/mlx5_common.h
@@ -155,6 +155,7 @@ enum {
 	PCI_DEVICE_ID_MELLANOX_BLUEFIELD3 = 0Xa2dc,
 	PCI_DEVICE_ID_MELLANOX_CONNECTX8 = 0x1023,
 	PCI_DEVICE_ID_MELLANOX_CONNECTX9 = 0x1025,
+	PCI_DEVICE_ID_MELLANOX_CONNECTX10 = 0x1027,
 	PCI_DEVICE_ID_MELLANOX_BLUEFIELD4 = 0xa2df,
 };
 
diff --git a/drivers/crypto/mlx5/mlx5_crypto.c b/drivers/crypto/mlx5/mlx5_crypto.c
index 240e8bb858..e974297961 100644
--- a/drivers/crypto/mlx5/mlx5_crypto.c
+++ b/drivers/crypto/mlx5/mlx5_crypto.c
@@ -491,6 +491,10 @@ static const struct rte_pci_id mlx5_crypto_pci_id_map[] = {
 			RTE_PCI_DEVICE(PCI_VENDOR_ID_MELLANOX,
 					PCI_DEVICE_ID_MELLANOX_CONNECTX9)
 		},
+		{
+			RTE_PCI_DEVICE(PCI_VENDOR_ID_MELLANOX,
+					PCI_DEVICE_ID_MELLANOX_CONNECTX10)
+		},
 		{
 			RTE_PCI_DEVICE(PCI_VENDOR_ID_MELLANOX,
 					PCI_DEVICE_ID_MELLANOX_BLUEFIELD4)
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index c24c9b306d..bf19364a07 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -3921,6 +3921,10 @@ static const struct rte_pci_id mlx5_pci_id_map[] = {
 		RTE_PCI_DEVICE(PCI_VENDOR_ID_MELLANOX,
 				PCI_DEVICE_ID_MELLANOX_CONNECTX9)
 	},
+	{
+		RTE_PCI_DEVICE(PCI_VENDOR_ID_MELLANOX,
+				PCI_DEVICE_ID_MELLANOX_CONNECTX10)
+	},
 	{
 		RTE_PCI_DEVICE(PCI_VENDOR_ID_MELLANOX,
 				PCI_DEVICE_ID_MELLANOX_BLUEFIELD4)
-- 
2.53.0

