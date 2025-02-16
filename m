Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6EAC021A4
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 11:05:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CA3C40DD2;
	Sun, 16 Feb 2025 12:05:19 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by mails.dpdk.org (Postfix) with ESMTP id 42EFB40DCE
 for <dev@dpdk.org>; Sun, 16 Feb 2025 12:05:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deRJH6WzuqASNey23ZFu2qQHpVnsw43+n9uTmLgm4cp4nXMdiCJbxl9X9WlN8dzT9B0nSvmwu1JeUub8UOlLGNCFfeyo3Wx9mLsGbF1mgX4l5Y2SpbdmFbzeyIsM7NLtjUHhDvAs7n43Ji4cj3hvl6CS0YPRQc4CY+KO5RZSB13Qp523Acc0YjDFILdIQ2ockzO5e56aGKXCk1q5InvufLKYQ9V5CHmyXh01T999kv19yyjojC1m+aYKN8dfe7TVjKssjmBuN/aPZ8OnvKgEST0Y8sXk3RSeRr60s6k1ZwkkwrIR0AHtYq9g9IioZxGy0+VjZUGlHm4seOHgeTstPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pgIY3Cbm/xJA6Xi9P1dhmc/yKdHSnXpEuc9AaZm3nc=;
 b=xa/V75z3WQkrVT1IoRiOsLLeBfCTUJsHPsRgZNgVTFRulNOzP3FUDUPCWz4IJtzCpHc5MjdMEf85uvbPL/8gtvDtNpS4HInhmlgfltkVT753IEnQT6RhCLudYewo+pcBH7DXhtIVdrmqx7BedjvhRTTE1rrE7dL0aQQXwOvhW9zrjHyKqs8oWCukZYS1MGOd5o5TR3/+eGbBQkO4asQg7VUQQj88OWCYIznCCXZpPeOoQ3yDitkDrJJPrwH5lTzZpYLGPOT7jc+SNTYqp0COGEV864FrBNgUdCW2Q0zeh5zIvsd5rwhzpJAIFm9swk/qK8ymQurJ+DEX/e5WZaX73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pgIY3Cbm/xJA6Xi9P1dhmc/yKdHSnXpEuc9AaZm3nc=;
 b=kLTMNrsGEgOK7pmr0D22A0PxKh0DLwIB12CLZEb/ojl1jsFDOf05Jti3x4KFh3ne/RADzb/ByMFLxR7E59e0gQuAKOOITW8Lnj1sIgEis8kcJU1uA/1dAei/F26GqF8l/3ND6iiGskq0qHoY/rje8HJbl20MoFf1/itFxmfUS8l+0UtTVXlNXBfDTDqeYprvJfwzPvfCxTImZ0CH1qOFv6au9Zn6Mju8X7yKli2FMc2jKVwXlp6ZbaU2xr/I5jEWKChb4qoVxEi90WoxQwudVvykHPQrAkXr5mEGfiSvbM/ieiH7fcMnY7GcKKwN8N4np0jl0YhWPHJ/4DzbxzuZuQ==
Received: from SJ0PR13CA0197.namprd13.prod.outlook.com (2603:10b6:a03:2c3::22)
 by DM3PR12MB9350.namprd12.prod.outlook.com (2603:10b6:8:1ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Sun, 16 Feb
 2025 11:05:12 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::7a) by SJ0PR13CA0197.outlook.office365.com
 (2603:10b6:a03:2c3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.11 via Frontend Transport; Sun,
 16 Feb 2025 11:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sun, 16 Feb 2025 11:05:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 16 Feb
 2025 03:04:59 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 16 Feb
 2025 03:04:56 -0800
From: Hamdan Igbaria <hamdani@nvidia.com>
To: <hamdani@nvidia.com>, <viacheslavo@nvidia.com>, <thomas@monjalon.net>,
 <suanmingm@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: <dev@dpdk.org>, Erez Shitrit <erezsh@nvidia.com>
Subject: [PATCH 4/8] net/mlx5/hws: allow table creation from the new types
Date: Sun, 16 Feb 2025 13:04:10 +0200
Message-ID: <20250216110414.10926-4-hamdani@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|DM3PR12MB9350:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e694fe9-d3d4-4ce1-c1d0-08dd4e79c857
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4v9ulzeB+ZLLezb9w3HTS5TpWxjVT3HFqEuDfiipQi4w/tQb+kvQW4Dz9o37?=
 =?us-ascii?Q?9KGwhwkc0/I3PDmyMrzezJZb16z17IM+BGP8FU4buh3rFKhZgi6Pz6XuhwHy?=
 =?us-ascii?Q?+14xFC4T1dKyg1RBu4ZNt6BOduUBEPnMBc8wPqAON2vMOE7CFQLEQ7pAJ476?=
 =?us-ascii?Q?vmhyPrtUpGUhKTXJVYV8qtJbQX0+2puGI2TAD1p78iCYR36RYKrMlYZUAfR6?=
 =?us-ascii?Q?P9YVlsWzBM/DEJ7WVhJRRwd8L6Rg49ytfBsYx+biTUbyPA8+W9sGWCZbMsez?=
 =?us-ascii?Q?ijDR5On2pMz3fb76+XXUUm+3zuDx0HxujfsX49bVmHFBw+cKlBW24ivi6HIc?=
 =?us-ascii?Q?4FVKUzA6Uw0Dqnvmo2AkPLUZ+y659oGzSuK2SUOlM19Zyww2XC0Mjyt4edgD?=
 =?us-ascii?Q?pOaBc9f+Um5IFIZH6pcQXQIHjMw2a3xOfeGymUJBcHy4aQEDopvpXJHplxMC?=
 =?us-ascii?Q?zZyuwsLUI3inPbi0QWeRoAyHsGU/M1maHkLAJykWnywIYrk2NNSbxBYb+/Vv?=
 =?us-ascii?Q?0GTXzfWjoU4sgqAO6UKtTytWQzkcQQ7gOAwBXEU2GXoT1LgkeLPSsHBrjHMd?=
 =?us-ascii?Q?vFMBsZbPLTKSwF0LppfgWYoLSZ5eHWzGVzG9ZkRyIiLB1kr+UB09itYcVAAO?=
 =?us-ascii?Q?C75TpmC3kgatuF3DtW8uET9EVMo3HPHwJ1fBysgSAcZTocdCPFenG2z1Hx3R?=
 =?us-ascii?Q?1PGqYLeG7aoSHHw6myJRW+HDh10sbOq0vtCydCiDP/1jPSJN+vqQfv6RIMWG?=
 =?us-ascii?Q?h2kpT2B1Eu16HOn2AuK5maR+YZSBx1t+W4JGYrQXqRXjdVl83ISrMHjyH+Tz?=
 =?us-ascii?Q?gYMyZyLdwiDnnEiZMJE3WtR0HkS7Xcc2au+jttxdxYcye5MNNeFu1sECT5RM?=
 =?us-ascii?Q?vKd8lseTLeTkfkS19gvXHX8LyWKPGP7ns+sMry0U+dV3z3qvSlOOZzv5HcA1?=
 =?us-ascii?Q?2K54RYJE+F4iD2pSiojFZxRGoXQJiNmpvpO+2vgXYti4PvUnMJZFdoEo5dPp?=
 =?us-ascii?Q?8ANAtNrmJmY1kl48Zc6K+wMnq6WN8ibsTjl2tcccd3Oy56UOexN/fSe/qeN5?=
 =?us-ascii?Q?Rr62+3CuHT1xvwLNGuzP1rMGT5QW3aiu0F8y1ZT40EEwBmc12W8x6kzZDW0/?=
 =?us-ascii?Q?JDNvU82mpzXk04q7b7SVeYZ13Cy8Nu9MEmqMmZ7Nz9oyHrv69RQvudrWkH4U?=
 =?us-ascii?Q?qDJGc4zHQYUj1ZJS/Cq453QLVxumBzULatrGyY3O9nxlwnXJz3uqQxtuw0wT?=
 =?us-ascii?Q?FqANJV6+yrNrBsxuJ6HB09nit4fXJJhLNOFCJOTPb3v+NP39pzMjbcVb+AXY?=
 =?us-ascii?Q?wg/YQNwCC2ecdzHHgLi4yydVLJg9JCN73VkWAT9OF//JPRgoKY+CYWoZ9I2Y?=
 =?us-ascii?Q?nMys0MYhZngKyUCGvMmOl8Cuqa75XwGkp87Xy+avV66tGmz9oryFXj8RXwVT?=
 =?us-ascii?Q?c4EpkBEGNuVYQmgPgcRd3N1jSrDi1oLQv0BniGbrNgGroYawzTRmqB8XOAzq?=
 =?us-ascii?Q?543sMexn/TAZRcI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2025 11:05:11.4276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e694fe9-d3d4-4ce1-c1d0-08dd4e79c857
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9350
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

Take care of table creation from one of the new types that now exposed
to the user (FDB_RX, FDB_TX and FDB_UNIFIED)

Signed-off-by: Erez Shitrit <erezsh@nvidia.com>
Signed-off-by: Hamdan Igbaria <hamdani@nvidia.com>
Acked-by: Matan Azrad <matan@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_action.c |  6 ++---
 drivers/net/mlx5/hws/mlx5dr_cmd.c    |  4 ++--
 drivers/net/mlx5/hws/mlx5dr_table.c  | 35 ++++++++++++++++++++--------
 drivers/net/mlx5/hws/mlx5dr_table.h  | 20 ++++++++++++++++
 4 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_action.c b/drivers/net/mlx5/hws/mlx5dr_action.c
index b038ca6879..8e95abf7da 100644
--- a/drivers/net/mlx5/hws/mlx5dr_action.c
+++ b/drivers/net/mlx5/hws/mlx5dr_action.c
@@ -801,7 +801,7 @@ mlx5dr_action_fixup_stc_attr(struct mlx5dr_context *ctx,
 		break;
 
 	case MLX5_IFC_STC_ACTION_TYPE_ALLOW:
-		if (fw_tbl_type == FS_FT_FDB_TX || fw_tbl_type == FS_FT_FDB_RX) {
+		if (mlx5dr_table_is_fw_fdb_any(fw_tbl_type)) {
 			fixup_stc_attr->action_type = MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_VPORT;
 			fixup_stc_attr->action_offset = stc_attr->action_offset;
 			fixup_stc_attr->stc_offset = stc_attr->stc_offset;
@@ -817,8 +817,8 @@ mlx5dr_action_fixup_stc_attr(struct mlx5dr_context *ctx,
 		if (stc_attr->vport.vport_num != WIRE_PORT)
 			break;
 
-		if (fw_tbl_type == FS_FT_FDB_TX || fw_tbl_type == FS_FT_FDB_RX) {
-			/*The FW doesn't allow to go to wire in the TX/RX by JUMP_TO_VPORT*/
+		if (mlx5dr_table_is_fw_fdb_any(fw_tbl_type)) {
+			/* The FW doesn't allow to go to wire in the TX/RX by JUMP_TO_VPORT */
 			fixup_stc_attr->action_type = MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_UPLINK;
 			fixup_stc_attr->action_offset = stc_attr->action_offset;
 			fixup_stc_attr->stc_offset = stc_attr->stc_offset;
diff --git a/drivers/net/mlx5/hws/mlx5dr_cmd.c b/drivers/net/mlx5/hws/mlx5dr_cmd.c
index 8a788709b5..f609135ccb 100644
--- a/drivers/net/mlx5/hws/mlx5dr_cmd.c
+++ b/drivers/net/mlx5/hws/mlx5dr_cmd.c
@@ -328,14 +328,14 @@ void mlx5dr_cmd_set_attr_connect_miss_tbl(struct mlx5dr_context *ctx,
 {
 	struct mlx5dr_devx_obj *default_miss_tbl;
 
-	if (type != MLX5DR_TABLE_TYPE_FDB && !mlx5dr_context_shared_gvmi_used(ctx))
+	if (!mlx5dr_table_is_fdb_any(type) && !mlx5dr_context_shared_gvmi_used(ctx))
 		return;
 
 	ft_attr->modify_fs = MLX5_IFC_MODIFY_FLOW_TABLE_MISS_ACTION;
 	ft_attr->type = fw_ft_type;
 	ft_attr->table_miss_action = MLX5_IFC_MODIFY_FLOW_TABLE_MISS_ACTION_GOTO_TBL;
 
-	if (type == MLX5DR_TABLE_TYPE_FDB) {
+	if (mlx5dr_table_is_fdb_any(type)) {
 		default_miss_tbl = ctx->common_res[type].default_miss->ft;
 		if (!default_miss_tbl) {
 			assert(false);
diff --git a/drivers/net/mlx5/hws/mlx5dr_table.c b/drivers/net/mlx5/hws/mlx5dr_table.c
index d0df40a6c1..b371f420e6 100644
--- a/drivers/net/mlx5/hws/mlx5dr_table.c
+++ b/drivers/net/mlx5/hws/mlx5dr_table.c
@@ -8,7 +8,7 @@ static void mlx5dr_table_init_next_ft_attr(struct mlx5dr_table *tbl,
 					   struct mlx5dr_cmd_ft_create_attr *ft_attr)
 {
 	ft_attr->type = tbl->fw_ft_type;
-	if (tbl->type == MLX5DR_TABLE_TYPE_FDB)
+	if (mlx5dr_table_is_fdb_any(tbl->type))
 		ft_attr->level = tbl->ctx->caps->fdb_ft.max_level - 1;
 	else
 		ft_attr->level = tbl->ctx->caps->nic_ft.max_level - 1;
@@ -26,7 +26,7 @@ mlx5dr_table_up_default_fdb_miss_tbl(struct mlx5dr_table *tbl)
 	struct mlx5dr_context *ctx = tbl->ctx;
 	uint8_t tbl_type = tbl->type;
 
-	if (tbl->type != MLX5DR_TABLE_TYPE_FDB)
+	if (!mlx5dr_table_is_fdb_any(tbl_type))
 		return 0;
 
 	if (ctx->common_res[tbl_type].default_miss) {
@@ -63,7 +63,7 @@ static void mlx5dr_table_down_default_fdb_miss_tbl(struct mlx5dr_table *tbl)
 	struct mlx5dr_context *ctx = tbl->ctx;
 	uint8_t tbl_type = tbl->type;
 
-	if (tbl->type != MLX5DR_TABLE_TYPE_FDB)
+	if (!mlx5dr_table_is_fdb_any(tbl->type))
 		return;
 
 	default_miss = ctx->common_res[tbl_type].default_miss;
@@ -81,7 +81,7 @@ mlx5dr_table_connect_to_default_miss_tbl(struct mlx5dr_table *tbl,
 	struct mlx5dr_cmd_ft_modify_attr ft_attr = {0};
 	int ret;
 
-	assert(tbl->type == MLX5DR_TABLE_TYPE_FDB);
+	assert(mlx5dr_table_is_fdb_any(tbl->type));
 
 	mlx5dr_cmd_set_attr_connect_miss_tbl(tbl->ctx,
 					     tbl->fw_ft_type,
@@ -109,16 +109,18 @@ mlx5dr_table_create_default_ft(struct ibv_context *ibv,
 	mlx5dr_table_init_next_ft_attr(tbl, &ft_attr);
 
 	ft_obj = mlx5dr_cmd_flow_table_create(ibv, &ft_attr);
-	if (ft_obj && tbl->type == MLX5DR_TABLE_TYPE_FDB) {
+	if (ft_obj && mlx5dr_table_is_fdb_any(tbl->type)) {
 		/* Take/create ref over the default miss */
 		ret = mlx5dr_table_up_default_fdb_miss_tbl(tbl);
 		if (ret) {
-			DR_LOG(ERR, "Failed to get default fdb miss");
+			DR_LOG(ERR, "Failed to get default fdb miss for type: %d\n",
+			       tbl->type);
 			goto free_ft_obj;
 		}
 		ret = mlx5dr_table_connect_to_default_miss_tbl(tbl, ft_obj);
 		if (ret) {
-			DR_LOG(ERR, "Failed connecting to default miss tbl");
+			DR_LOG(ERR, "Failed connecting to default miss tbl (type: %d)",
+			       tbl->type);
 			goto down_miss_tbl;
 		}
 	}
@@ -142,7 +144,7 @@ mlx5dr_table_init_check_hws_support(struct mlx5dr_context *ctx,
 		return rte_errno;
 	}
 
-	if (mlx5dr_context_shared_gvmi_used(ctx) && tbl->type == MLX5DR_TABLE_TYPE_FDB) {
+	if (mlx5dr_context_shared_gvmi_used(ctx) && mlx5dr_table_is_fdb_any(tbl->type)) {
 		DR_LOG(ERR, "FDB with shared port resources is not supported");
 		rte_errno = EOPNOTSUPP;
 		return rte_errno;
@@ -380,11 +382,24 @@ struct mlx5dr_table *mlx5dr_table_create(struct mlx5dr_context *ctx,
 	struct mlx5dr_table *tbl;
 	int ret;
 
-	if (attr->type > MLX5DR_TABLE_TYPE_FDB) {
+	if (attr->type >= MLX5DR_TABLE_TYPE_MAX) {
 		DR_LOG(ERR, "Invalid table type %d", attr->type);
 		return NULL;
 	}
 
+	if (attr->type == MLX5DR_TABLE_TYPE_FDB_UNIFIED && !ctx->caps->fdb_unified_en) {
+		DR_LOG(ERR, "Table type %d not supported by current FW", attr->type);
+		rte_errno = ENOTSUP;
+		return NULL;
+	}
+
+	if ((mlx5dr_table_is_fdb_any(attr->type) && attr->type != MLX5DR_TABLE_TYPE_FDB) &&
+	    !attr->level) {
+		DR_LOG(ERR, "Table type %d not supported by root table", attr->type);
+		rte_errno = ENOTSUP;
+		return NULL;
+	}
+
 	tbl = simple_calloc(1, sizeof(*tbl));
 	if (!tbl) {
 		rte_errno = ENOMEM;
@@ -464,7 +479,7 @@ int mlx5dr_table_ft_set_default_next_ft(struct mlx5dr_table *tbl,
 	if (!tbl->ctx->caps->nic_ft.ignore_flow_level_rtc_valid)
 		return 0;
 
-	if (tbl->type == MLX5DR_TABLE_TYPE_FDB)
+	if (mlx5dr_table_is_fdb_any(tbl->type))
 		return mlx5dr_table_connect_to_default_miss_tbl(tbl, ft_obj);
 
 	ft_attr.type = tbl->fw_ft_type;
diff --git a/drivers/net/mlx5/hws/mlx5dr_table.h b/drivers/net/mlx5/hws/mlx5dr_table.h
index 1c0eb6adf8..6996a90d9b 100644
--- a/drivers/net/mlx5/hws/mlx5dr_table.h
+++ b/drivers/net/mlx5/hws/mlx5dr_table.h
@@ -28,6 +28,26 @@ struct mlx5dr_table {
 	struct mlx5dr_default_miss default_miss;
 };
 
+static inline bool mlx5dr_table_is_fw_fdb_any(uint32_t fw_tbl_type)
+{
+	if (fw_tbl_type == FS_FT_FDB_TX || fw_tbl_type == FS_FT_FDB_RX ||
+	    fw_tbl_type == FS_FT_FDB_UNIFIED)
+		return true;
+
+	return false;
+}
+
+static inline bool mlx5dr_table_is_fdb_any(enum mlx5dr_table_type tbl_type)
+{
+	if (tbl_type == MLX5DR_TABLE_TYPE_FDB ||
+	    tbl_type == MLX5DR_TABLE_TYPE_FDB_TX ||
+	    tbl_type == MLX5DR_TABLE_TYPE_FDB_RX ||
+	    tbl_type == MLX5DR_TABLE_TYPE_FDB_UNIFIED)
+		return true;
+
+	return false;
+}
+
 static inline
 uint32_t mlx5dr_table_get_res_fw_ft_type(enum mlx5dr_table_type tbl_type,
 					 bool is_mirror)
-- 
2.21.0

