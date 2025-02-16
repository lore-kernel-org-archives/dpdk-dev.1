Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734F5C021A4
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 11:05:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94E6F40B9B;
	Sun, 16 Feb 2025 12:05:12 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
 by mails.dpdk.org (Postfix) with ESMTP id 53E8540B90
 for <dev@dpdk.org>; Sun, 16 Feb 2025 12:05:10 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rvh0E4KsH484kyCT/QqBmW2cYGU1MNwaDn1kj2teZ8p/aI293IHaGvN8mA5prQIzC1BzpTxVn7eHE1QpaWTt9Oo7f/fMq6KO8yjg/7V7cs4En43MwB5y/1zZQrdGsIjjLIVrC3+1aMLk4ja3HIb81n0A1pSdJh1e1XWhpUxZslMlcEn4BZHKPd4ozCt2Taf9tXRNZHz62Y5rcA2Y/WMMMx8AEMfka6UjAW/f1IBYAOQ72zCoJ69S+8ce9L5blBcHpjgOuKW1dpaIZqxrgwkpL5f17xcRDgc7i72Uz/9dYkYE+Q/uunhZIEmZ/GGjiLsmZykZpAL2Y0DvLAWT78vcOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IRM0MEUSQRxqOvAKU/3n61OxLFJCzmQCcu11Pp8S6Y=;
 b=moXJusFMp7LzuICwtogERD1Z3RinofgzKZ+R30nywSa8VeUYVAiuHxz/5a58B1jO59p40HU/FHbckfSqhxmT/y6E2K9xsANMfYgF2wvgk35FicLFJP/F9f7oNQkNIqJN/BpjSA14P84xKsZ8IK4bKjV0O947HQWE4toxYVsvrw5Srr+c/wt0qiCeUxD4PaRRALo9MriTPOUTT8eUPFExK8yMBmqL28hwz2f3DJ8+0ewpGQGj9NSbdjK7fOtFt4CGzVeyI4CPHGmtGvIKLovnCK7zcEj1MvnYa12uiMF28CpV7RGC6tp+wKS6JsiDHyESHD6bx/FSReotBUvSZMzQXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IRM0MEUSQRxqOvAKU/3n61OxLFJCzmQCcu11Pp8S6Y=;
 b=P4AverJ93N7Bijv30+b4Ie/uKSMa0enKm6WHWFZJaKdcXaQf9xXwsvWdJpvW+lsYzVNQnVFIVbR8OYrXIadMugmfyw7oryXXsm2YkctCRA88TOHgReVc7OfjOvS37E1wrPaY2/A8RGJlyA/wu3djJ9sTgzROSk6EkOdV4lNkac+xUom32fKRfCJkBjMuTLyzonHr0Wo911uJq/KclstuIMOpX3YuHadXo8M2CIvD/6q0TbYApejBNOSxXba/HYKtSPdjMy3+5LYENe4KvdfnKJmCwDVLZVJuA6ZrFjm2irW+C913nz1GendIyLG70G9VxHKJIt/GO/ldvrMLvueBzg==
Received: from MW4PR03CA0062.namprd03.prod.outlook.com (2603:10b6:303:b6::7)
 by SN7PR12MB7884.namprd12.prod.outlook.com (2603:10b6:806:343::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Sun, 16 Feb
 2025 11:05:05 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:303:b6:cafe::be) by MW4PR03CA0062.outlook.office365.com
 (2603:10b6:303:b6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Sun,
 16 Feb 2025 11:05:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sun, 16 Feb 2025 11:05:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 16 Feb
 2025 03:04:48 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 16 Feb
 2025 03:04:46 -0800
From: Hamdan Igbaria <hamdani@nvidia.com>
To: <hamdani@nvidia.com>, <viacheslavo@nvidia.com>, <thomas@monjalon.net>,
 <suanmingm@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: <dev@dpdk.org>, Erez Shitrit <erezsh@nvidia.com>
Subject: [PATCH 2/8] net/mlx5/hws: add new type to existing table-types
Date: Sun, 16 Feb 2025 13:04:08 +0200
Message-ID: <20250216110414.10926-2-hamdani@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b0d9d1b-0fbb-47f1-78b2-08dd4e79c3ec
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2kbZV6JxIgmrd8aYSbxGAOKCrhUdqlOghHhRw2kO3FyHhOoAwejuAXQNfbJx?=
 =?us-ascii?Q?uG/R+7HaWV5tDYdaAHWvMHMgf3RQEusye1/yl1YUpKFk3M63WqfzApT4LJAx?=
 =?us-ascii?Q?l+1o2DaSCnXQulQAhhUQu7bM8SbRrWQO0jBqZM8wckqdTMLubqFDqzn+KRuY?=
 =?us-ascii?Q?aVovdpX6ieloiuIeeIBltZ8HwhAsYE48VyiCMuQ+THhSrD2nYYlPg0Wcbl6t?=
 =?us-ascii?Q?D/mVHtpKoXSUk9bUmrkps6jWgLD9mJQw2LRQQsZsZBU0MnFMnGZb5HYs3yEB?=
 =?us-ascii?Q?Ghj2MrZJWOMqkZNHtwM8qzsA4CX1I4UfR5dQ1oX9O2kGSNlEkkweFnaJvA4m?=
 =?us-ascii?Q?xxtnqb7FLRCXzxWodZ9YC9CJZ9x0CEBsKTbCPAZXxiYrRTRuic06O7JBC6Lz?=
 =?us-ascii?Q?fsZZ59U6oywx+69Pzt38RPUmXkTEZ2psm03Tp2/YmghwN30003IlcWfGGdGj?=
 =?us-ascii?Q?Afasu/G7OnJ/Jg+UdmmXrdlppn4tyGOEw31TSgHrx0gD/4+CX48jtyoh7+oG?=
 =?us-ascii?Q?hVzJmbadR3t/T2grscf16Ah3otQJ7y3bJIrnDLMdSiMfMuUSwRbRl6he1CsT?=
 =?us-ascii?Q?qtRptw2xUKn8q7lhZm5n+RgyXK6qkpSrCvnEjbAcTTSPMiz88Q2SliKt7YjV?=
 =?us-ascii?Q?vqUF1qfeLkY3WW9rsy+ynpucOB/cg6apPWV/GkWk7YwwYDOpYNX6+q+NrUbW?=
 =?us-ascii?Q?cyi7os1eEW9nddjyZQ2ydmEKpQ1kmG2ZCOLL3xCeTByyJYwANoFgpm93Ae4o?=
 =?us-ascii?Q?Q23p/lfSEYeDhYmfcOXO+lL32ujZZRM1gDFN4I6JKs4EcBUheTqSqrHSP//o?=
 =?us-ascii?Q?Ga8PDtRNmrxNv3eba7IGSkVrRIHAXjKBXbJuToowfCL9X+v7SbKRx6ZtOQCz?=
 =?us-ascii?Q?Kj1DT0XlCrSLf4ZwD/irl2z/z791CGYarYGrwt5pXJEuHppMX9rscRzoGk4p?=
 =?us-ascii?Q?7E2UiLxTTqZjhmAtsVRNMcANn207+0mJkWSV6/cOwz9uhqeIX8jbQ3ZAkJrE?=
 =?us-ascii?Q?tKdNN7bW/MN+o/Ad8WRCEQ1W0JpZK7QENbQJF8NPtCH9ZVzL1f4dp587ftxg?=
 =?us-ascii?Q?KgMLpgoGoF9tOZrf/8M3iVSw3+0Tsu6surI4Q/cu/0bP0/Pk0F8Edbto94ee?=
 =?us-ascii?Q?fa5qtQWmYkfZk6D5E61kdYFetVFjYEiN2RNjnVPc/R/ijE46Sa5KDRRA+UXW?=
 =?us-ascii?Q?3HsRAaFFvjNjzAfDaRwBXhc7UM7jBJxm+Mph9kJBbl3WApa6isjyHIiHvvzY?=
 =?us-ascii?Q?QdVCuwGZKtfaySjbmJYkGyQrH4pc2WL5LC/uigCKD8JBOWvgZWpQRWA0c2zC?=
 =?us-ascii?Q?w/khjdj6gd77La1jDs9XFyosU5WTwNUhP5RJ+w/wqWaJkwMtZ1Qeq7r1F3DX?=
 =?us-ascii?Q?xOOWEosHNVnyPO7k622B17kIr5WU70zhE2PeJJbxIyrzePqM/tV77ZBqxwNk?=
 =?us-ascii?Q?/0rAGtxxgsrN6oXWtUG/5jV0ByPMODV6UXbONOKcUSR6g1BT6CO579YjEWz1?=
 =?us-ascii?Q?1ZPas17nu2flTYM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2025 11:05:04.0448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0d9d1b-0fbb-47f1-78b2-08dd4e79c3ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884
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

Type MLX5DR_TABLE_TYPE_FDB handles two types of rules and matching one
for FDB_RX and one for FDB_TX, now we separate FDB type to 3 sub
domains, RX / TX and UNIFIED.
The RX and TX as before, the new one UNIFIED will use for rules /
actions that are common to both RX and TX.

Signed-off-by: Erez Shitrit <erezsh@nvidia.com>
Signed-off-by: Hamdan Igbaria <hamdani@nvidia.com>
Acked-by: Matan Azrad <matan@nvidia.com>
---
 drivers/common/mlx5/mlx5_prm.h      |  1 +
 drivers/net/mlx5/hws/mlx5dr.h       |  3 +++
 drivers/net/mlx5/hws/mlx5dr_table.c | 15 +----------
 drivers/net/mlx5/hws/mlx5dr_table.h | 40 ++++++++++++++++++++++++-----
 4 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_prm.h b/drivers/common/mlx5/mlx5_prm.h
index 6e141b6520..3fc3b0cd2a 100644
--- a/drivers/common/mlx5/mlx5_prm.h
+++ b/drivers/common/mlx5/mlx5_prm.h
@@ -5122,6 +5122,7 @@ enum {
 	FS_FT_FDB = 0x4,
 	FS_FT_FDB_RX = 0xa,
 	FS_FT_FDB_TX = 0xb,
+	FS_FT_FDB_UNIFIED = 0xc,
 };
 
 struct mlx5_ifc_flow_table_context_bits {
diff --git a/drivers/net/mlx5/hws/mlx5dr.h b/drivers/net/mlx5/hws/mlx5dr.h
index 7097d22099..e0e7f5c147 100644
--- a/drivers/net/mlx5/hws/mlx5dr.h
+++ b/drivers/net/mlx5/hws/mlx5dr.h
@@ -17,6 +17,9 @@ enum mlx5dr_table_type {
 	MLX5DR_TABLE_TYPE_NIC_RX,
 	MLX5DR_TABLE_TYPE_NIC_TX,
 	MLX5DR_TABLE_TYPE_FDB,
+	MLX5DR_TABLE_TYPE_FDB_RX,
+	MLX5DR_TABLE_TYPE_FDB_TX,
+	MLX5DR_TABLE_TYPE_FDB_UNIFIED,
 	MLX5DR_TABLE_TYPE_MAX,
 };
 
diff --git a/drivers/net/mlx5/hws/mlx5dr_table.c b/drivers/net/mlx5/hws/mlx5dr_table.c
index 634b484a94..d0df40a6c1 100644
--- a/drivers/net/mlx5/hws/mlx5dr_table.c
+++ b/drivers/net/mlx5/hws/mlx5dr_table.c
@@ -333,20 +333,7 @@ static int mlx5dr_table_init(struct mlx5dr_table *tbl)
 	if (ret)
 		return ret;
 
-	switch (tbl->type) {
-	case MLX5DR_TABLE_TYPE_NIC_RX:
-		tbl->fw_ft_type = FS_FT_NIC_RX;
-		break;
-	case MLX5DR_TABLE_TYPE_NIC_TX:
-		tbl->fw_ft_type = FS_FT_NIC_TX;
-		break;
-	case MLX5DR_TABLE_TYPE_FDB:
-		tbl->fw_ft_type = FS_FT_FDB;
-		break;
-	default:
-		assert(0);
-		break;
-	}
+	mlx5dr_table_get_fw_ft_type(tbl->type, (uint8_t *)&tbl->fw_ft_type);
 
 	pthread_spin_lock(&ctx->ctrl_lock);
 	tbl->ft = mlx5dr_table_create_default_ft(tbl->ctx->ibv_ctx, tbl);
diff --git a/drivers/net/mlx5/hws/mlx5dr_table.h b/drivers/net/mlx5/hws/mlx5dr_table.h
index 32f2574a97..1c0eb6adf8 100644
--- a/drivers/net/mlx5/hws/mlx5dr_table.h
+++ b/drivers/net/mlx5/hws/mlx5dr_table.h
@@ -32,15 +32,21 @@ static inline
 uint32_t mlx5dr_table_get_res_fw_ft_type(enum mlx5dr_table_type tbl_type,
 					 bool is_mirror)
 {
-	if (tbl_type == MLX5DR_TABLE_TYPE_NIC_RX)
+	switch (tbl_type) {
+	case MLX5DR_TABLE_TYPE_NIC_RX:
 		return FS_FT_NIC_RX;
-	else if (tbl_type == MLX5DR_TABLE_TYPE_NIC_TX)
+	case MLX5DR_TABLE_TYPE_NIC_TX:
 		return FS_FT_NIC_TX;
-	else if (tbl_type == MLX5DR_TABLE_TYPE_FDB)
+	case MLX5DR_TABLE_TYPE_FDB:
+	case MLX5DR_TABLE_TYPE_FDB_RX:
+	case MLX5DR_TABLE_TYPE_FDB_TX:
 		return is_mirror ? FS_FT_FDB_TX : FS_FT_FDB_RX;
-
-	assert(0);
-	return 0;
+	case MLX5DR_TABLE_TYPE_FDB_UNIFIED:
+		return FS_FT_FDB_UNIFIED;
+	default:
+		assert(0);
+		return 0;
+	}
 }
 
 static inline bool mlx5dr_table_is_root(struct mlx5dr_table *tbl)
@@ -48,6 +54,28 @@ static inline bool mlx5dr_table_is_root(struct mlx5dr_table *tbl)
 	return (tbl->level == MLX5DR_ROOT_LEVEL);
 }
 
+static inline
+void mlx5dr_table_get_fw_ft_type(enum mlx5dr_table_type type,
+				 uint8_t *ret_type)
+{
+	switch (type) {
+	case MLX5DR_TABLE_TYPE_NIC_RX:
+		*ret_type = FS_FT_NIC_RX;
+		break;
+	case MLX5DR_TABLE_TYPE_NIC_TX:
+		*ret_type = FS_FT_NIC_TX;
+		break;
+	case MLX5DR_TABLE_TYPE_FDB:
+	case MLX5DR_TABLE_TYPE_FDB_RX:
+	case MLX5DR_TABLE_TYPE_FDB_TX:
+	case MLX5DR_TABLE_TYPE_FDB_UNIFIED:
+		*ret_type = FS_FT_FDB;
+		break;
+	default:
+		assert(0);
+	}
+}
+
 struct mlx5dr_devx_obj *mlx5dr_table_create_default_ft(struct ibv_context *ibv,
 						       struct mlx5dr_table *tbl);
 
-- 
2.21.0

