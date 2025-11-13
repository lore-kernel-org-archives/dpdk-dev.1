Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A22CD6E42
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 12:27:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C17A40B9E;
	Thu, 13 Nov 2025 13:27:31 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010048.outbound.protection.outlook.com
 [52.101.193.48])
 by mails.dpdk.org (Postfix) with ESMTP id 9FA6D40151;
 Thu, 13 Nov 2025 13:27:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBKQG88R8C2ehXrRjSBEW50aom5DlxdzixoK7Iq8vEfekHZiF64Dx6HCvO/+0sULciKS6A8etZB7y6B8jBW3cunN1ithweW1SXD0TuSeBHpPA3gwMyKiNRUAGfkSoTZ5pNApp8iIeAmpEuZjOEjvnsiZ0iaUiBqo8VWGbLJ/o6VUiEHHkjMsU0v8oL0/qY3JWWG+wrBDzWYqSGqM/rGETz6UvCVam1wqbTyI0qHsJs+nAevxZ2e0x8PIrlSXZKxwi70cVdchJMAv+3C62GQyMsnQg09pcTCD+vCalr/TO24r8rXG+sNgslMJdSFEXltCVSgnHbLLJ/VOCxvp1uXyqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqUbTtIDH/AtUqaQMWBkmfyW1vzt8YerhwgnOAdWZE0=;
 b=F9TB+iYVsyGzW7FiyKTpxiPYqNHcgXYujXrAbScHMKv3bvMnExRoPSROq6KoirkXKSXhAA0pk80rDDWjY+SAPBuG6h+IgCissqCPwcJj0VC2T+XuTZ7pJvCoYWQ7xRJI13k1CBwcPsjOITmZLOeJ670MpSfnl/qMgess3VwtBc1mbFtE85BBTdpL/i+5qj4fdBARHtoLC9mZARwOPgvcZHVERXmc7CA1wqHv02UP3kcK8CYH6UpV9pJVmW5l6ZElBKZqDTCqoPUI5UfWTJkV7Jvh5mkue6DhqgKGAZzJlkgYqgumSKctpu6Z4qXUlvD0iWjjvkTtjLFVGo2cafYBNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqUbTtIDH/AtUqaQMWBkmfyW1vzt8YerhwgnOAdWZE0=;
 b=ghnQtBGchFcdSvN2MxJmpKIF5renVrt3qLRnSP59aX+K03/YDKdVW4vBovvSVGHKcvvdenD+6/pi+8rnKHaAfA+2upKxrarVwQbtgORBTpktybBLgtXOTRIxWTXY/JcrJzf8tXiBz+8b+MnSDlr25QQccaUs7k+sETKJHuckGqxLMnioHmzbbi9hHwDl8beIZYOn4bC/9lXBFapKiJkBtINobndoTjS8+4f6x1vdm40NntUhIhxj1YPp6MbAlFfiwOcBoILaLXQQ9D5HG431XWqmSlozemB1PTgw5ePiLEK5F3L+6cirxqYVOVj2poL3yQRrHUVMnsr/MYGH0DaLtA==
Received: from SJ0PR13CA0191.namprd13.prod.outlook.com (2603:10b6:a03:2c3::16)
 by LV8PR12MB9358.namprd12.prod.outlook.com (2603:10b6:408:201::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 12:27:26 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::ed) by SJ0PR13CA0191.outlook.office365.com
 (2603:10b6:a03:2c3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.7 via Frontend Transport; Thu,
 13 Nov 2025 12:27:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 12:27:25 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 04:27:24 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Nov 2025 04:27:23 -0800
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 13
 Nov 2025 04:27:20 -0800
From: Itai Sharoni <isharoni@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, Itai Sharoni
 <isharoni@nvidia.com>, <stable@dpdk.org>, Bing Zhao <bingz@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Ori
 Kam" <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Ophir Munk <ophirmu@nvidia.com>
Subject: [PATCH] net/mlx5/windows: fix match criteria in flow creation
Date: Thu, 13 Nov 2025 14:26:41 +0200
Message-ID: <20251113122642.1193-1-isharoni@nvidia.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|LV8PR12MB9358:EE_
X-MS-Office365-Filtering-Correlation-Id: 03385da5-319c-425a-2d4f-08de22b000e0
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Td0xwOdbkvCsrwBnHZYnWJdqeQYKyAs5LsHd7iPtfyXpq8scByBMU1T5geaP?=
 =?us-ascii?Q?WNtoLseJzDrRDGNohZfOD9Ey8Io/MxoLtLL7+AddNVnBlXb415M/jsfczAEO?=
 =?us-ascii?Q?ZiT8nTfK+S55T27P76qdNcqwf7DwyLYhA3Aj6xtKSjq9e80FYLKPvh61Iqoo?=
 =?us-ascii?Q?prGGuGZmDa+WYAfd/vYSmU9Y1NzRJdGNdQcMP5EElY9ER4Y7lNiQ1LOk8iej?=
 =?us-ascii?Q?bx/wVzue9JVKNWue5LzyzGEsdDbCIHGvJk15J4dFT9xPsk/qZc85dV4erUNo?=
 =?us-ascii?Q?8mjV/Iq1b6zbNJGcpwGUoF6aua7jA7oPn0eWm/FNTisKHvx/3yGYXKHrXNEM?=
 =?us-ascii?Q?7GSvwoSp952TUelo6X/PyQsjX8ISKNCTYihWvE5cq0Hk7zt2ZCJsk7q6iqlV?=
 =?us-ascii?Q?fLr6IXD0lO6nbe1D10m2Hgxvh2F7rse6Kw8vhr/y1uaPab5+iByEL53xvQ6t?=
 =?us-ascii?Q?arSrLy4XVDKW0jYHwmH3DRA6IRDepDiqauNZtu/CAcFzIITQs5Nj/eVkuU3E?=
 =?us-ascii?Q?nCHsJdy4IStk1zSxv+IUdF2S9IxjtOda5j79kxCo2OzXOZ5tZOTIqN69Pijt?=
 =?us-ascii?Q?HSRPLDdatM+9ZJ9R3qhKyx3NZIiTwtHtjvtxbixf94KPu6V7HwUpgyf0H45D?=
 =?us-ascii?Q?wNs+kRjxGiv9bY24tba7D4/K70+GPE5BQf6BAFCvvzusLHIcNP2N/d+Nd1W+?=
 =?us-ascii?Q?T6BGqNNuel+Os5KL2mEvD3kHvo7Cn2J8cV7BoS12FPZZMaCQgYpepuPkEY9X?=
 =?us-ascii?Q?vxj3i87zP20rV+azllq0WecUI0rZ4e31+2F27U3zrr9aHg2a1JjudfaF+Zvp?=
 =?us-ascii?Q?tOgq0p1EY+9CwKRKi9a0PnRHQpp7JMR/JuflA5pAcBDmXaX3UOK4PqccEcxo?=
 =?us-ascii?Q?0c68yaMTbzDSX76wtc7sPQa2dNYOewFr3CCEMSJNEmcIOM35w++Z0Z0agGI5?=
 =?us-ascii?Q?3ckC1/GRSApWVtB170ODs+5lVLIemh6E4/Hu1BA+5zfiRNrs7Fi4hFzE2M0v?=
 =?us-ascii?Q?vOUSDklX3wbttnrCTosXyGGtH2qyDoxANArwKcwEco7b4FnCW8ru3pguOCGE?=
 =?us-ascii?Q?uBSeXSkWoC3P98ewC8ms4qkhJVExpE10wCP624tSn3oOVOy0TdccIzaVfP4V?=
 =?us-ascii?Q?FUG2jgPnkbvULFhj6ZG1uALHgInxwxV/ZgPxLgRcvly+dok6pGKUaRnfr2L6?=
 =?us-ascii?Q?srqQVquC42dI58AkgvdNec2Bx3MwWdJ0oGaYSGlz8twHeJZm3IzSXDhfBY3+?=
 =?us-ascii?Q?f/wmrALUGlqYP2KAveT5ZALzevYy/0CahFv8rSx9rvZRRuWUqwfjDoWTpiwl?=
 =?us-ascii?Q?XuKzFcjAtQcFwKIct3xCLzD1dmKRIjOD3QZQAbBdyOPuSIWS9nJge8a+6tKM?=
 =?us-ascii?Q?Jayl6pwRehPQj+hPcXQxD7Hmdv+dSwQDpBWS/tC8g9J8oyoNIQw98I816j/0?=
 =?us-ascii?Q?Sy87rxP8TrWweTBVNoEESyZdhbH9em6IpCkREGSQ4dI1uNc15cwsuwbcKD0r?=
 =?us-ascii?Q?vVJm8IzLoeHcQ38IeUPqCk20Fk44Q1kRuIfhxIFMcof/rBf5MqkUWFIoTx/E?=
 =?us-ascii?Q?clw98pZxsBVXZdKP9K0=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 12:27:25.7261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03385da5-319c-425a-2d4f-08de22b000e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9358
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

Currently the Windows implementation hardcodes match criteria to
MLX5_MATCH_OUTER_HEADERS when creating flow rules, which prevents
matching on inner headers and other criteria types like NVGRE.

The fix uses the matcher's match_criteria_enable attribute instead
of hardcoding OUTER_HEADERS, and moves the assignment outside the
action switch block to apply to all cases.

NVGRE item type is also added to the supported items list.

Fixes: 1d194496b9d1 ("net/mlx5: create flow rule on Windows")
Cc: stable@dpdk.org

Signed-off-by: Itai Sharoni <isharoni@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 .mailmap                                | 1 +
 drivers/net/mlx5/windows/mlx5_flow_os.c | 4 ++--
 drivers/net/mlx5/windows/mlx5_flow_os.h | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 50a59a596a..83c2ea91a4 100644
--- a/.mailmap
+++ b/.mailmap
@@ -639,6 +639,7 @@ Intiyaz Basha <intiyaz.basha@caviumnetworks.com>
 Ioana Ciornei <ioana.ciornei@nxp.com>
 Isaac Boukris <iboukris@gmail.com>
 Itamar Gozlan <igozlan@nvidia.com>
+Itai Sharoni <isharoni@nvidia.com>
 Itsuro Oda <oda@valinux.co.jp>
 Ivan Boule <ivan.boule@6wind.com>
 Ivan Dyukov <i.dyukov@samsung.com>
diff --git a/drivers/net/mlx5/windows/mlx5_flow_os.c b/drivers/net/mlx5/windows/mlx5_flow_os.c
index 7a625fb880..15c6fc5613 100644
--- a/drivers/net/mlx5/windows/mlx5_flow_os.c
+++ b/drivers/net/mlx5/windows/mlx5_flow_os.c
@@ -219,9 +219,9 @@ mlx5_flow_os_create_flow(void *matcher, void *match_value,
 		default:
 			break;
 		}
-		MLX5_SET(devx_fs_rule_add_in, in, match_criteria_enable,
-			 MLX5_MATCH_OUTER_HEADERS);
 	}
+	MLX5_SET(devx_fs_rule_add_in, in, match_criteria_enable,
+		mlx5_matcher->attr.match_criteria_enable);
 	*flow = mlx5_glue->devx_fs_rule_add(mlx5_matcher->ctx, in, sizeof(in));
 	return (*flow) ? 0 : -1;
 }
diff --git a/drivers/net/mlx5/windows/mlx5_flow_os.h b/drivers/net/mlx5/windows/mlx5_flow_os.h
index 2cd4e95325..c087bca4be 100644
--- a/drivers/net/mlx5/windows/mlx5_flow_os.h
+++ b/drivers/net/mlx5/windows/mlx5_flow_os.h
@@ -47,6 +47,7 @@ mlx5_flow_os_item_supported(int item)
 	case RTE_FLOW_ITEM_TYPE_IPV6:
 	case RTE_FLOW_ITEM_TYPE_VLAN:
 	case RTE_FLOW_ITEM_TYPE_ESP:
+	case RTE_FLOW_ITEM_TYPE_NVGRE:
 		return true;
 	default:
 		return false;
-- 
2.28.0.windows.1

