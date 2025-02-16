Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75773C02198
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 11:05:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D7A240DD7;
	Sun, 16 Feb 2025 12:05:33 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by mails.dpdk.org (Postfix) with ESMTP id 7848C40A89
 for <dev@dpdk.org>; Sun, 16 Feb 2025 12:05:31 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bda0L04lJk9kQVnKkTmlt8Mi3PAtfXeKYajkkKFNHufrJevFiFni/o8XDfKR+GmLLfLHGG9B1FXESe0p7Efgyyu9mL3Mpxvw2Aea/L5rM+8Mzf96SP6sMadjK6OBiwzAClaN+Y74mwrEgH7NItMOnBN1Cj8s2ZQPgN9JI2fQEDPJecPVrLw3RviKR4+Y/dneANb0UZvlM3wqhXivzhh3PmlLDiLW5ko8nQ0jZJxjYviQEQ7DXfnEhl6VDMUjsgCUAKd+NULAiT0Bh+rQCMVmoGHe08L4vx8ev4HyipZ5Nj2Bz7ZzrI89KIn7oya2mD937/B1zYUcdrFyiKSJIIzpDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qwwqf3hze/ljutYkB+W3eUCaeCGCR4YszTSyrY9sRrc=;
 b=d+imzImslFwUyaKl1q0EsSbk5+hf6QsGBugXf04XssV/AD0C9m3TtXcc0S6tH2YQX/thM1DfCPYl/jUPnsv8J4zbwWOAaxcrPlKyUYz3DujV7BaKEn6YrX6VPdRniO94uXfcATTFQVd+LjTEX1EWXegT2QYyfiNBB75wkUqrJVaxolf81ofpLbC+rUIgbp2+jn84oTEyhgoIX1whWXfGctg7IGRxAbeLk/3gN2C1piRdxVn1yxJKfHvHa44Cr+1WBMwbSVTLR1EBHDSx1AmbrqJAjcBWaQQyhjTXhgHPBRtMfehhk/mMBZxxHB+njwRAJgPQo3mffOi8X0IHFen5zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qwwqf3hze/ljutYkB+W3eUCaeCGCR4YszTSyrY9sRrc=;
 b=Lgq/pa/1IbDM1MR0UqRMYk2rLwU/7Z7ShCBKu9ghfjzWrS5WQ/q3AZ/p4Q1qfoSvrC5nqt6ujbQhhX1onof0n2XS5sxZcHqX23M3EG2PYMrGAal6lA7ySm+Vqu8gppNlUz7Xv8JsRZUtFOMsII60sLkoS+sy6+B4vz8cIP8xTasu2ekffes4xe4jO/fTcFsImvDsQtiNnUV1RT2B3iSQRHMX20OTaDpY5Ouju+pPg+zOzzgxPniFZL75DjZ66TYy3T/yJNSVP5scwzDW/XaAcszbOZHM8hAPJf4LjeM7CjFgQUPt8E2aaqM18O7ws9xYI86vVRkD5oVd/zTBrWBjbg==
Received: from DS7PR05CA0040.namprd05.prod.outlook.com (2603:10b6:8:2f::33) by
 CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.18; Sun, 16 Feb 2025 11:05:28 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::87) by DS7PR05CA0040.outlook.office365.com
 (2603:10b6:8:2f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.11 via Frontend Transport; Sun,
 16 Feb 2025 11:05:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sun, 16 Feb 2025 11:05:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 16 Feb
 2025 03:05:15 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 16 Feb
 2025 03:05:12 -0800
From: Hamdan Igbaria <hamdani@nvidia.com>
To: <hamdani@nvidia.com>, <viacheslavo@nvidia.com>, <thomas@monjalon.net>,
 <suanmingm@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: <dev@dpdk.org>, Erez Shitrit <erezsh@nvidia.com>
Subject: [PATCH 8/8] net/mlx5/hws: support debug information for new domains
Date: Sun, 16 Feb 2025 13:04:14 +0200
Message-ID: <20250216110414.10926-8-hamdani@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20250216110414.10926-1-hamdani@nvidia.com>
References: <20250216110414.10926-1-hamdani@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|CYXPR12MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ec2c0a-5c57-4b5b-f633-08dd4e79d24d
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iLW8Kbw8HZx5BXp3n1z8XatOWQEucgQSReYeNTMp75el1rLkFCJ16yjcRQZ4?=
 =?us-ascii?Q?GE7mR8ngZ8OFgvTmN0I7CYz+bBVcSZdQzqWVDCADxJg/ARnv//VSBfl9QSEO?=
 =?us-ascii?Q?muZR50CGnzWz7GbyDkC431FbPmEDmJi/kcZxN/KwVPFXtdXggTW5cShSZBIi?=
 =?us-ascii?Q?niJtA/Z1kM19PlzFHjPXVABiG8S4mf9ZtWogbuGlJotnk0nQcmsVza9M+jD+?=
 =?us-ascii?Q?M5h235ZJzWI84q/6dRnU32562TUjx8whYFMNBCOeGBCdY0kteS3eMWqsuJ8Y?=
 =?us-ascii?Q?I9+9l+sBddpK+f59KOe8u76hOledpySTYfYYr5dp3qtPynuBAQxrzfsfYW2d?=
 =?us-ascii?Q?zwaXLfsMjilNClBMWB3R5NQLXV+Gj+RDpF8krkEzVsqP98I0M5KC+ExaK+Tf?=
 =?us-ascii?Q?7BFPjD0yexfk3R7JNJNb/6jHh2y3oK3BJ21ttfqPy0DyJkvEyg/MAl1o6xrw?=
 =?us-ascii?Q?bug1cGFgo1XAWSdkxeKeo+ZMH7TcCYPamnzmTjRLPioVUdDt3CbVF/UHqAfE?=
 =?us-ascii?Q?SgHmlryxMlq2eHev/zTUEspWLHphzOM7G3tbxwEJZ7gxdCX1TGAVPvVJiCQU?=
 =?us-ascii?Q?J0AT869iaLLHSLGyy91Lk3Sjs1ZVtcRTiPTnlc7oC/oaHvWzNZm4EYN1GTsd?=
 =?us-ascii?Q?zxe04WwV1/04cIiKTW3SJyfN9pkawdzed5qohFa4SVxm8yTvnC5LxwJ7zQ9e?=
 =?us-ascii?Q?Y2qmAZgpNcZXpFFPDnL/w1swybM706NjxSlCWKXn7e17+ASchqHS8HIw7Mb9?=
 =?us-ascii?Q?6iLyfPbRBtExhLSMAYFl2BS2Her365kulIf3buhGvIeqOwCSJLuuuoHhvtSG?=
 =?us-ascii?Q?Ndwixh/j2wESRkJF0GyYNRz9eiUhNyY2fSSpI+h6Ytc4WxEvsEXP/K4FEp3j?=
 =?us-ascii?Q?Zu+sgoHNeSCTk0RVn/gFYXWS+ajIzpYa1DHavF+k0YqTxjldS8w48sPS+/nE?=
 =?us-ascii?Q?2sVcQDgl1V2ZPr1Zwfp3VXvoJsvFqZp4m5DsY7dWrUa/91O72voJ06BZ2vJg?=
 =?us-ascii?Q?5ROlKwoz+BALwkztsqG9oUxRdkn2AnfUurUPev7zYm66g1QPE5yljkVQMiFV?=
 =?us-ascii?Q?12zuC4PGEO6ZhB80lsepqbHZrpqM/klwrSOI7awrw+5NV9goBtBjWbNqjl4b?=
 =?us-ascii?Q?0EVIEI2OFqp9/qf1KVULNBh4a1TPTmoQH2QTWExrlEbwAWv6gNWHD9bcd4mB?=
 =?us-ascii?Q?Q7y8E9a4fIz5/0OikBoqBWLJTPw4OFsb03W7Y0NqF8oQ3FsHU8mhIvnHCBXn?=
 =?us-ascii?Q?T3d+bi5yJ8hvn1l9YP6oEHpHWEEbxYu7f4GnfIpdqzaJakVbWkyGpBgs+pR9?=
 =?us-ascii?Q?Bh+26hs3FjZMjyS0PiZd2HqI1N/pD+G3qb9TAzbrA/dzW3dNuk+AHsET809W?=
 =?us-ascii?Q?cg4CSKP2qwiLK5rSqWIStptz440tIyEO2Gr4B69mXAvRsttP+OT9Mt1Q+KD6?=
 =?us-ascii?Q?dDTvEGn3F20cGcVMxN08diLrwdl/t7obhjd5sSUV9zxXYLU3XVbvelVhilAn?=
 =?us-ascii?Q?m+o6GJRIuXoqxKo=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2025 11:05:28.1562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ec2c0a-5c57-4b5b-f633-08dd4e79d24d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441
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

From: Erez Shitrit <erezsh@nvidia.com>

In order to have the details of the new specific domains.

Signed-off-by: Erez Shitrit <erezsh@nvidia.com>
Signed-off-by: Hamdan Igbaria <hamdani@nvidia.com>
Acked-by: Matan Azrad <matan@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_debug.c b/drivers/net/mlx5/hws/mlx5dr_debug.c
index 8684a8197a..7480300de8 100644
--- a/drivers/net/mlx5/hws/mlx5dr_debug.c
+++ b/drivers/net/mlx5/hws/mlx5dr_debug.c
@@ -232,7 +232,7 @@ static int mlx5dr_debug_dump_matcher(FILE *f, struct mlx5dr_matcher *matcher)
 	ste_pool = matcher->match_ste.pool;
 	if (ste_pool) {
 		ste_0 = mlx5dr_pool_chunk_get_base_devx_obj(ste_pool, ste);
-		if (tbl_type == MLX5DR_TABLE_TYPE_FDB)
+		if (tbl_type == MLX5DR_TABLE_TYPE_FDB || tbl_type == MLX5DR_TABLE_TYPE_FDB_TX)
 			ste_1 = mlx5dr_pool_chunk_get_base_devx_obj_mirror(ste_pool, ste);
 	} else {
 		ste_0 = NULL;
@@ -251,7 +251,7 @@ static int mlx5dr_debug_dump_matcher(FILE *f, struct mlx5dr_matcher *matcher)
 	ste_pool = matcher->action_ste.pool;
 	if (ste_pool) {
 		ste_0 = mlx5dr_pool_chunk_get_base_devx_obj(ste_pool, ste);
-		if (tbl_type == MLX5DR_TABLE_TYPE_FDB)
+		if (tbl_type == MLX5DR_TABLE_TYPE_FDB || tbl_type == MLX5DR_TABLE_TYPE_FDB_TX)
 			ste_1 = mlx5dr_pool_chunk_get_base_devx_obj_mirror(ste_pool, ste);
 	} else {
 		ste_0 = NULL;
-- 
2.21.0

