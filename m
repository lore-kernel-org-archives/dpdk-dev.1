Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5932FC021A4
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 11:05:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1ADE40B8F;
	Sun, 16 Feb 2025 12:05:11 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by mails.dpdk.org (Postfix) with ESMTP id B850D40A8A
 for <dev@dpdk.org>; Sun, 16 Feb 2025 12:05:09 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ru8gUfVv0Lkpk3xkDccsgVGhQY71HwVhdktMnPBWhPahY+Hz//TjXzXfJQrWvGebwDn3appd413uob2hyvCWOvj73g+v6uz1LmgFG39WwH48Hd2yuwQHFKmqKMGylVHxa5tezf40xIlQZwl1ffdep/NxEUTi1WOwkN7GCdjMtvb23w5k7FUvJxUj6movFtUoe+4t8FaCN9AQl6tHEiGUeEFvL3vkJZF2YoKWHDnuVNdHzF/HMz9Ij2KU7KQVse7xgGDNKVg5g3Vq+BFpzdDOIX8aIUF1/jVimSu3JtDr7sYwsF9Lvt52wXKqw7C86zIL5/0+cKwHdRdre8lF7o3YDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxC6GUMpOyzzvJ8z8J/b/gqiepOMS83odAJFQ+5UO+0=;
 b=qNCUpg1aOQO6Z3cCVBHdlpsz8zBiqMUGSKxDDiFa9Gwb3cvMY0YBkxDQa+mYsb+nZJPCPspMwc3oKZ5bavkNOyMrHYt+Bi6mTTMf6uP9kM8fI+Itg+9YA/JNLh0Hj5hIfBLqbNQr6vK1YJ+E9D55BO4FyP/SZlj0MTHT3PJTdBJqnPWypZj3bLTFC/3oMfwrWoEUDrSccKLv2Q+6YMfoQAJJ652q1YkpzlyXUMB35YI4rqjau0ZuxkoZPZHl1CkNmTBic/9tPHaapdv4uRK8xBR/VpaZ0feqD9d2UPNcRaPzVUau/TXVRkexdMbnK4LmN/Z6nxGA3NV+bTg/R44Kdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxC6GUMpOyzzvJ8z8J/b/gqiepOMS83odAJFQ+5UO+0=;
 b=r2zF/a2neLAi+K/8EE8dwO2nT0CitWFu+gS0RjyxPXLJI75xD19nN5QioI9MdDeK19nujMnUKtZi3qQebjfDDGzaQNdGlKylg1AuWQtq6KKebH7zz+tU+jyTWWvcrwnfXPgxrp0BLP7/aKzLiaWhrKeTysv6fB+aGI7+fviB0PqiYtSQKihnePL0Bfzt8rQgPVbFTTNmIdGYl2DiOygbsaH+8PTTGVuIcMWhdYNoTPdHFqhfqvXBNJ4I6SQc4sn8QnQQgLHF34FE4t8zTfDhgJzLCVdXiZoHYGlLOZSVgqnrvgwpu8WoP867lT3q2SUnQXpOWtTNDmyBJUS8OFOKIQ==
Received: from CY5PR16CA0022.namprd16.prod.outlook.com (2603:10b6:930:10::34)
 by DM4PR12MB6350.namprd12.prod.outlook.com (2603:10b6:8:a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Sun, 16 Feb
 2025 11:05:05 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:930:10:cafe::65) by CY5PR16CA0022.outlook.office365.com
 (2603:10b6:930:10::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.18 via Frontend Transport; Sun,
 16 Feb 2025 11:05:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sun, 16 Feb 2025 11:05:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 16 Feb
 2025 03:04:55 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 16 Feb
 2025 03:04:52 -0800
From: Hamdan Igbaria <hamdani@nvidia.com>
To: <hamdani@nvidia.com>, <viacheslavo@nvidia.com>, <thomas@monjalon.net>,
 <suanmingm@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: <dev@dpdk.org>, Erez Shitrit <erezsh@nvidia.com>
Subject: [PATCH 3/8] net/mlx5/hws: context changes to support unified domain
Date: Sun, 16 Feb 2025 13:04:09 +0200
Message-ID: <20250216110414.10926-3-hamdani@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|DM4PR12MB6350:EE_
X-MS-Office365-Filtering-Correlation-Id: c21169b9-0d9f-4973-f7c4-08dd4e79c441
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/FhLlf55LvRtEw/LVA/ddoDfajs0cfnpnxftK9k1q76SmBUujYkKNoiw/Agh?=
 =?us-ascii?Q?Nc550vO/JAiIzK+QALu79M+wsb7b5SM3ZY9wtIth+eQ+/VEVRqTcQjdSXAxf?=
 =?us-ascii?Q?vxYmexlY3uphusrww9QemN1gYlKQ5ys+PKWhhT9K5Vi5b1Sog6ayYKEt9tiS?=
 =?us-ascii?Q?jaQwvx8mCM66Lq5nndD9Oz6G9XkdyY9y1oUjHHGVwYfOSxSyiGRZNR6a1XKn?=
 =?us-ascii?Q?lboc9KI62+07lH+llXxpl7o/NQlmxpOMv/lO8C57iVNA+/xG6HGlVYFCq4gr?=
 =?us-ascii?Q?56mLkgYva+kONMU7a7HjoAt41HHeVywEomoC/CCd0eS5w+Ng/OGv0rIfTOFO?=
 =?us-ascii?Q?+Vc+ICNzm4rSvtOSJmkyb1zhlAHEZk/3BdyIGmTHI3R+Y63poN50vlhoQQwL?=
 =?us-ascii?Q?2W/DF343MsTWBZK8MzWa98uEThTjCdE6XJ0fTE+/A8xoLvNqZ2hf4xt+Hhzf?=
 =?us-ascii?Q?N/PuhvHYnPdjA9y4ZeQdM8fxT/f/t/FBCbro3+h84ZRs1/ixs6afoCkxwvxr?=
 =?us-ascii?Q?4zxhd/oQ9kCj5X29USnSwNkzwTMnEBvLFLzgjyLiEfl4l13qZNyk/5uUR3vU?=
 =?us-ascii?Q?sMRFq2LPX3wiBfrwiyVlUZGZy9RtvOKTr13RNHFPQcU1zSZSVAE57ih2d+cQ?=
 =?us-ascii?Q?J+pangYFPaOZPP55N6DQwavixYJFSKskiWlKa2GSF6p7ItTlWmz4Dp/TFT5w?=
 =?us-ascii?Q?OUdXos4RoryyZ9X3WmryWnjXF7cyHkkoSSl/m093C4SVxlYXod6ArpU9YmVk?=
 =?us-ascii?Q?sv1MSt23hGWpKVkNAKb15O7HTH3R305TRBsTb0jrF6kEfCeiozl+6KTO9kdd?=
 =?us-ascii?Q?51OBvPtn6mfmHN0aEfd19rVJsL3ea9w9WpdVdqCvqlgRFN30VbyH7LvqjDaS?=
 =?us-ascii?Q?ChKFO77b2EEfBWFoHGqcR6xLvlgkfJllKYjg9+eJfZdIPovAONFYDeVtkdXg?=
 =?us-ascii?Q?hvZgVCu/pu7rANyy9gRpjeWksUYV9UQvPPhHzN/oSqfzQP2COJCAbB31g5yQ?=
 =?us-ascii?Q?eIMShSJBvtqx57EsmzN+sagLL/Lg7x/16ZP6CutA0Cpoep2m7Ahn8tqgzywa?=
 =?us-ascii?Q?6nZCN2iw5whJy7CguNWkRtHI16X+KfoUFPtMmcUoD9VWBGLibsoMIP73cQnJ?=
 =?us-ascii?Q?ungIyNZVPtyO1B6EhzLS3FAg4OkV4tzcUrE5IbuCvgeKl0vYhTHhqEAboi/Z?=
 =?us-ascii?Q?qO5c4E7RC0kyMGQgsvEoIslVX6dvCzljhzJgbtGgkcbDTHgoUfGkpgb02KPz?=
 =?us-ascii?Q?MqvMjKURccnXEV0AbWwhuIhCP+FPH/A/DtSWc8o05qXdqQqnZ7OpL5wSdo/E?=
 =?us-ascii?Q?H+3ZQB0jvZROKjwb8PJHx9JuW2N/dfM2JAAzSwbJAq2Oy34b/5W4Ak4/Qu1C?=
 =?us-ascii?Q?+TAnXwtMYd42HXlQtahLXYXj86veT5y5IY5Dbxi0eBC29232TQ+or6RKLkl/?=
 =?us-ascii?Q?GJpL4AzCihSOeqGbfNsjEL12zEf1tZHseBaBL9jttcNSvFNGQ8dGekg74gD6?=
 =?us-ascii?Q?ZBkcB4dKqmtZkeY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2025 11:05:04.6051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c21169b9-0d9f-4973-f7c4-08dd4e79c441
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6350
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

Context creates its pools according to the table type.

Signed-off-by: Erez Shitrit <erezsh@nvidia.com>
Signed-off-by: Hamdan Igbaria <hamdani@nvidia.com>
Acked-by: Matan Azrad <matan@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_context.c | 21 ++++++++++++++++++++-
 drivers/net/mlx5/hws/mlx5dr_context.h |  3 +++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_context.c b/drivers/net/mlx5/hws/mlx5dr_context.c
index 24741afe58..91d05f1f86 100644
--- a/drivers/net/mlx5/hws/mlx5dr_context.c
+++ b/drivers/net/mlx5/hws/mlx5dr_context.c
@@ -19,6 +19,24 @@ uint8_t mlx5dr_context_get_reparse_mode(struct mlx5dr_context *ctx)
 	return MLX5_IFC_RTC_REPARSE_ALWAYS;
 }
 
+void mlx5dr_context_set_pool_tbl_attr(struct mlx5dr_pool_attr *attr,
+				      enum mlx5dr_table_type table_type)
+{
+	attr->table_type = table_type;
+
+	switch (table_type) {
+	case MLX5DR_TABLE_TYPE_FDB_TX:
+		attr->opt_type = MLX5DR_POOL_OPTIMIZE_ORIG;
+		break;
+	case MLX5DR_TABLE_TYPE_FDB_RX:
+		attr->opt_type = MLX5DR_POOL_OPTIMIZE_MIRROR;
+		break;
+	default:
+		attr->opt_type = MLX5DR_POOL_OPTIMIZE_NONE;
+		break;
+	}
+}
+
 static int mlx5dr_context_pools_init(struct mlx5dr_context *ctx,
 				     struct mlx5dr_context_attr *attr)
 {
@@ -41,7 +59,8 @@ static int mlx5dr_context_pools_init(struct mlx5dr_context *ctx,
 	pool_attr.alloc_log_sz = RTE_MAX(max_log_sz, ctx->caps->stc_alloc_log_gran);
 
 	for (i = 0; i < MLX5DR_TABLE_TYPE_MAX; i++) {
-		pool_attr.table_type = i;
+		mlx5dr_context_set_pool_tbl_attr(&pool_attr,
+						 (enum mlx5dr_table_type)i);
 		ctx->stc_pool[i] = mlx5dr_pool_create(ctx, &pool_attr);
 		if (!ctx->stc_pool[i]) {
 			DR_LOG(ERR, "Failed to allocate STC pool [%d]", i);
diff --git a/drivers/net/mlx5/hws/mlx5dr_context.h b/drivers/net/mlx5/hws/mlx5dr_context.h
index 7678232ecc..e89a093c77 100644
--- a/drivers/net/mlx5/hws/mlx5dr_context.h
+++ b/drivers/net/mlx5/hws/mlx5dr_context.h
@@ -72,4 +72,7 @@ bool mlx5dr_context_cap_dynamic_reparse(struct mlx5dr_context *ctx);
 
 uint8_t mlx5dr_context_get_reparse_mode(struct mlx5dr_context *ctx);
 
+void mlx5dr_context_set_pool_tbl_attr(struct mlx5dr_pool_attr *attr,
+				      enum mlx5dr_table_type table_type);
+
 #endif /* MLX5DR_CONTEXT_H_ */
-- 
2.21.0

