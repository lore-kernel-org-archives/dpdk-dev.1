Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6664DC021BF
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 14:02:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75C2D40668;
	Wed, 26 Feb 2025 15:02:08 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by mails.dpdk.org (Postfix) with ESMTP id 8295F40667
 for <dev@dpdk.org>; Wed, 26 Feb 2025 15:02:06 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uneELlZ2Ciia4GbPEAJnV9lHy8whiNWqiGyRFWEocBruN3XMPsYdBKQI2Kihl8awlExEEkGtF6JnkNMIujA1sm6Hh+QKqgm8rJKciZnlNleHKkcMsWi+3hKYc1ZM06fyNc+md3uOI12hoH39xPMjf2H+F7tDlHj8LNH0d8mh3nSjXlMi8lZj+tJlcPRVatOsYTOpasOygI8xGw/P42HxDscAsqtD50d8s7ZtV3f4ybInPxqFno6DIfgtlG32cFk5rzfLTLjfDdI8W3uuAhBVy726M9TdIg5J/8BzEwRZo4yLP5reDtkhNpUl3ZZqOjqDOpRFMshz5vSHnfdAX1387Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmvmzDPUKeS9AI2Zmk7UDWWoBnEWcmOI3+UW3nIk9Io=;
 b=AteBPY5xecBllCIab4cONlZHa8MdHm/FIgi2jkADiA7SHPJQjvgbXsosn5xBdAUE2vQ5ObljU74LpVV+JAoLz8Fo1ZrYfY37xq6BLVh5NspHKxvYLxi5fpxDmp/yPgu6HF7SST/Kq2GZ/DiBk6iH5xszbdSbPXcdXbZIynRIN/xMoiqj9jAcFuFmkKZREs5ju2d+j4O0VW4FJfY+w4XQ7oWos64tOqsMVu4X8X6a9sZRyXTTaTILYKk6Tq3CtvJahtTLFHUUqpYSDQTb1rEJt3r6IyeuihRPD1LYx4RKVSH7QXB4QM0gMXfJVDjO8cLmmcexgEg2gjzwcME+phahSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmvmzDPUKeS9AI2Zmk7UDWWoBnEWcmOI3+UW3nIk9Io=;
 b=CjO588nCJ/eO+UUDIiybpy7p6mqthKLyOB3ddsRDYl5xMzXgwJo5LYrDo9GyUin6AVU2zi8QKQy5Qr38K1Jt835sSfMxdmYA9BMcjVfV/46Pw44Gi8xfiId9rob4gAgq1C08DFGqfVxOKbGj/vU2i3q1OHqTQRqf7pkrX5LGkJIVvcxJ8vWndkWnoWaLU2ichSptxsyzSrHNEFn99qkO8wvqT/OVZAzo7Bfa+xXTgfsQ5HXLblYq8QEBYBgSmEqN66gAHu5eiKfnizFllrmOwv0kDtygTR+or/Bkh60dqE8GvggpY908CG6XHkjipAgfvj2zvp2o4OIzP8Rtzf3i+w==
Received: from CH2PR20CA0006.namprd20.prod.outlook.com (2603:10b6:610:58::16)
 by SJ2PR12MB7823.namprd12.prod.outlook.com (2603:10b6:a03:4c9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 14:02:00 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::3c) by CH2PR20CA0006.outlook.office365.com
 (2603:10b6:610:58::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 14:02:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 14:01:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 06:01:36 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 06:01:34 -0800
From: Suanming Mou <suanmingm@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>, Alex Vesker <valex@nvidia.com>
Subject: [PATCH v2 1/3] net/mlx5/hws: support jump FDB Rx
Date: Wed, 26 Feb 2025 22:01:17 +0800
Message-ID: <20250226140119.2142352-2-suanmingm@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226140119.2142352-1-suanmingm@nvidia.com>
References: <20250225004527.2066812-1-suanmingm@nvidia.com>
 <20250226140119.2142352-1-suanmingm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|SJ2PR12MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: eb1c3e51-a6a2-44bb-ef22-08dd566e23a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?URlsRnV5ENccOPvW7gRl6MLoA5xV3BcgjjlcrQvcBo8qYxaJjgYiqQPkNGtp?=
 =?us-ascii?Q?Rz5RYIw0rDx4iTFM5fmg2P+o/KlvJuJlFzgkrwxwPtyQKcU7tFIq8wwAY05y?=
 =?us-ascii?Q?GRuXz7taB0JGfhNWfd1FshBoVjANqlmxQuYQO0Xo2LcbfaB4JQuu0jc0FKkx?=
 =?us-ascii?Q?2Ezo2jb6QZyXpwBmqzhMNTGiCc4IN6/3LR9bwpVtqntGwIGXgLiQb9nYAFzz?=
 =?us-ascii?Q?H03KugyDP9d2XVtt+g9lXPo0lohnVK5uJlqiUc4wL9Uxtwrs/WJb0USeqfWs?=
 =?us-ascii?Q?sZ5SWIqzAf3SYuj89OzP8vRsYvKUr8NJ5Bsw1Go/kw26sqGmBQCCOkosj0F/?=
 =?us-ascii?Q?9jgPh91QpqYWl3eOfF5ySZt1TlcX/aYxcbJbcP7JhtwR6xj9gBSogT379AgT?=
 =?us-ascii?Q?ZDwggIcu8XMA63Bwxk/uITJevCwxWt1CjFt0kExJIp/IrMGt0Nzkre5gkJOI?=
 =?us-ascii?Q?+DxvNGmKUsqovwcX24cQ9xrruyuRdPHhSJIJO2ct3wd2jjuRJ2LoEX8WxEN/?=
 =?us-ascii?Q?VJHz/418KY+GdUGlescg/ytxZj1o4iODvAKt7XCTDn5r6ta5d2cb3BDEVZQh?=
 =?us-ascii?Q?AzUBXsAc2SUfLoa57y5WmiId8v2dOlJIIy2OvEJ6sz24NRbjNHGno1UX+yZ1?=
 =?us-ascii?Q?jtOR/Gv2TELLR3XyTrN9eVj/OnwPpj091yMaSUhHv1UYW0CHxxXfnOm/oTM7?=
 =?us-ascii?Q?CWw01bg9As/248R2yBEQzjdP5XYDPEq2orz3hZ3lopAwUAZC9VP75f/AQ/o7?=
 =?us-ascii?Q?HFIMtujbJ0ljvAlrmkeJvsHt2hg+Fpo6wuxUcmV6N5FGqv482oMUnYTXPTBa?=
 =?us-ascii?Q?g5HUkt0Fa50DTuyvpawi1Lp1N1BzzMdTlj+nIiZmI9rV1sbS8djtfmeWjcLN?=
 =?us-ascii?Q?F58+Yvpsx8moLFVyn/pJUA2unpDgnsnCedd0TSzqhZWUVWhjlAmM1rIJI/NF?=
 =?us-ascii?Q?pi2HvqBE74aE6iPi2B5JQ2tbLcxS5cWB93BnmRWpGZp3QeylaMqJTr/SyggG?=
 =?us-ascii?Q?SXmr1fa75ZyBTfZ2nsx+cZLzVHbRAR04Vn0eHrAlUeAtekt3YQx+Bl0veiws?=
 =?us-ascii?Q?pALn8hj73v5srrFC8xr6fXzWU+AOp91A9neCtM2RgXubhA4pYg7NT6rFUu/C?=
 =?us-ascii?Q?1eM7HiKkTr01V2ZB/Ld7sQQZ2t6ZzswuS0sZEQXSJbkY0AA3ol0d2wzrOMov?=
 =?us-ascii?Q?+kpFjHd1/B4D29TkS3v1ld/IW385IgqYbue3f3P/fY+MbEmH9FiFa7eorXMv?=
 =?us-ascii?Q?+aBx/Wacryu0z9LtieXJ7U1lTCloQEddICPSJV2n3qxWkMqqmjPh+ohBhb6m?=
 =?us-ascii?Q?QIKcjKm13aGCrUuwRmUMwf5/ocWfN6HQCqBAHYaDis6aPd8sMuO4/HKzgVXS?=
 =?us-ascii?Q?ZqLI01YiF9Ggp/duVmrOImMhwtScEKr3600XRxyzuhCxTgANkKBnMxxL8/wT?=
 =?us-ascii?Q?FOPvk92W8yullD5lRUo6YffsXOa32DNTD7Fn8PVY7TtOSHw8mE0ZD2K6fHKd?=
 =?us-ascii?Q?k1t6YcXOU51potc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 14:01:59.9097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1c3e51-a6a2-44bb-ef22-08dd566e23a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7823
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

Before FW introduced the JUMP_FDB_RX action feature, jump from
FDB Tx to Rx is not allowed. JUMP_FDB_RX feature introduces
the internal loopback for Tx case and allow the REG C0 C1 B be
preserved as well.

This commit adds the JUMP_FDB_RX cap bit check and use
JUMP_FDB_RX instead of FT for dest table FDB Rx case.

Signed-off-by: Suanming Mou <suanmingm@nvidia.com>
Signed-off-by: Alex Vesker <valex@nvidia.com>
---

v2: fix line lengh.

---
 drivers/common/mlx5/mlx5_prm.h        |  9 ++++++++-
 drivers/net/mlx5/hws/mlx5dr_action.c  | 26 +++++++++++++++++++++-----
 drivers/net/mlx5/hws/mlx5dr_action.h  |  4 ++++
 drivers/net/mlx5/hws/mlx5dr_cmd.c     |  9 +++++++++
 drivers/net/mlx5/hws/mlx5dr_cmd.h     |  2 ++
 drivers/net/mlx5/hws/mlx5dr_context.c | 17 +++++++++++++++++
 drivers/net/mlx5/hws/mlx5dr_context.h |  2 ++
 7 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_prm.h b/drivers/common/mlx5/mlx5_prm.h
index 3fc3b0cd2a..84e3347794 100644
--- a/drivers/common/mlx5/mlx5_prm.h
+++ b/drivers/common/mlx5/mlx5_prm.h
@@ -2466,7 +2466,8 @@ struct mlx5_ifc_wqe_based_flow_table_cap_bits {
 	u8 reserved_at_60[0x8];
 	u8 max_header_modify_pattern_length[0x8];
 	u8 ste_format[0x10];
-	u8 stc_action_type[0x80];
+	u8 stc_action_type_63_0[0x40];
+	u8 stc_action_type_127_64[0x40];
 	u8 header_insert_type[0x10];
 	u8 header_remove_type[0x10];
 	u8 trivial_match_definer[0x20];
@@ -3543,6 +3544,11 @@ enum mlx5_ifc_rtc_reparse_mode {
 	MLX5_IFC_RTC_REPARSE_BY_STC = 0x2,
 };
 
+enum mlx5_ifc_stc_action_type_bit_index {
+	MLX5_IFC_STC_ACTION_TYPE_BIT_64_INDEX = 64,
+	MLX5_IFC_STC_ACTION_TYPE_JUMP_FLOW_TABLE_FDB_RX_BIT_INDEX = 71,
+};
+
 #define MLX5_IFC_RTC_LINEAR_LOOKUP_TBL_LOG_MAX 16
 
 struct mlx5_ifc_rtc_bits {
@@ -3621,6 +3627,7 @@ enum mlx5_ifc_stc_action_type {
 	MLX5_IFC_STC_ACTION_TYPE_ALLOW = 0x84,
 	MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_VPORT = 0x85,
 	MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_UPLINK = 0x86,
+	MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_FLOW_TABLE_FDB_RX = 0x87,
 };
 
 enum mlx5_ifc_stc_reparse_mode {
diff --git a/drivers/net/mlx5/hws/mlx5dr_action.c b/drivers/net/mlx5/hws/mlx5dr_action.c
index b9452a3ebc..e21db5b327 100644
--- a/drivers/net/mlx5/hws/mlx5dr_action.c
+++ b/drivers/net/mlx5/hws/mlx5dr_action.c
@@ -803,6 +803,9 @@ int mlx5dr_action_root_build_attr(struct mlx5dr_rule_action rule_actions[],
 
 		switch (action->type) {
 		case MLX5DR_ACTION_TYP_TBL:
+			attr[i].type = MLX5DV_FLOW_ACTION_DEST_DEVX;
+			attr[i].obj = action->dest_tbl.devx_obj->obj;
+			break;
 		case MLX5DR_ACTION_TYP_TIR:
 			attr[i].type = MLX5DV_FLOW_ACTION_DEST_DEVX;
 			attr[i].obj = action->devx_obj;
@@ -1097,6 +1100,17 @@ static void mlx5dr_action_fill_stc_attr(struct mlx5dr_action *action,
 		}
 		break;
 	case MLX5DR_ACTION_TYP_TBL:
+		attr->action_offset = MLX5DR_ACTION_OFFSET_HIT;
+		attr->dest_table_id = obj->id;
+		/* Only for unified FDB Rx case */
+		if (mlx5dr_context_cap_stc(action->ctx,
+		    MLX5_IFC_STC_ACTION_TYPE_JUMP_FLOW_TABLE_FDB_RX_BIT_INDEX) &&
+		    action->dest_tbl.type == MLX5DR_TABLE_TYPE_FDB_RX)
+			attr->action_type = MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_FLOW_TABLE_FDB_RX;
+		else
+			attr->action_type = MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_FT;
+
+		break;
 	case MLX5DR_ACTION_TYP_DEST_ARRAY:
 		attr->action_type = MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_FT;
 		attr->action_offset = MLX5DR_ACTION_OFFSET_HIT;
@@ -1419,17 +1433,19 @@ mlx5dr_action_create_dest_table(struct mlx5dr_context *ctx,
 	if (!action)
 		return NULL;
 
+	action->dest_tbl.type = tbl->type;
+
 	if (mlx5dr_action_is_root_flags(flags)) {
 		if (mlx5dr_context_shared_gvmi_used(ctx))
-			action->devx_obj = tbl->local_ft->obj;
+			action->dest_tbl.devx_obj = tbl->local_ft;
 		else
-			action->devx_obj = tbl->ft->obj;
+			action->dest_tbl.devx_obj = tbl->ft;
 	} else {
+		action->dest_tbl.devx_obj = tbl->ft;
+
 		ret = mlx5dr_action_create_stcs(action, tbl->ft);
 		if (ret)
 			goto free_action;
-
-		action->devx_dest.devx_obj = tbl->ft;
 	}
 
 	return action;
@@ -2526,7 +2542,7 @@ mlx5dr_action_create_dest_array(struct mlx5dr_context *ctx,
 			case MLX5DR_ACTION_TYP_TBL:
 				dest_list[i].destination_type =
 					MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
-				dest_list[i].destination_id = dests[i].dest->devx_dest.devx_obj->id;
+				dest_list[i].destination_id = dests[i].dest->dest_tbl.devx_obj->id;
 				fte_attr.action_flags |= MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
 				fte_attr.ignore_flow_level = 1;
 				break;
diff --git a/drivers/net/mlx5/hws/mlx5dr_action.h b/drivers/net/mlx5/hws/mlx5dr_action.h
index b779e578fd..a582e2abbe 100644
--- a/drivers/net/mlx5/hws/mlx5dr_action.h
+++ b/drivers/net/mlx5/hws/mlx5dr_action.h
@@ -226,6 +226,10 @@ struct mlx5dr_action {
 				struct {
 					struct mlx5dr_matcher *matcher;
 				} jump_to_matcher;
+				struct {
+					struct mlx5dr_devx_obj *devx_obj;
+					enum mlx5dr_table_type type;
+				} dest_tbl;
 			};
 		};
 
diff --git a/drivers/net/mlx5/hws/mlx5dr_cmd.c b/drivers/net/mlx5/hws/mlx5dr_cmd.c
index f609135ccb..9dd01cd583 100644
--- a/drivers/net/mlx5/hws/mlx5dr_cmd.c
+++ b/drivers/net/mlx5/hws/mlx5dr_cmd.c
@@ -466,6 +466,7 @@ mlx5dr_cmd_stc_modify_set_stc_param(struct mlx5dr_cmd_stc_modify_attr *stc_attr,
 		MLX5_SET(stc_ste_param_tir, stc_param, tirn, stc_attr->dest_tir_num);
 		break;
 	case MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_FT:
+	case MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_FLOW_TABLE_FDB_RX:
 		MLX5_SET(stc_ste_param_table, stc_param, table_id, stc_attr->dest_table_id);
 		break;
 	case MLX5_IFC_STC_ACTION_TYPE_ACC_MODIFY_LIST:
@@ -1280,6 +1281,14 @@ int mlx5dr_cmd_query_caps(struct ibv_context *ctx,
 		caps->fdb_unified_en = MLX5_GET(query_hca_cap_out, out,
 						capability.wqe_based_flow_table_cap.
 						fdb_unified_en);
+
+		caps->stc_action_type_63_0 = MLX5_GET64(query_hca_cap_out,
+							out,
+					capability.wqe_based_flow_table_cap.stc_action_type_63_0);
+
+		caps->stc_action_type_127_64 = MLX5_GET64(query_hca_cap_out,
+							  out,
+					capability.wqe_based_flow_table_cap.stc_action_type_127_64);
 	}
 
 	if (caps->eswitch_manager) {
diff --git a/drivers/net/mlx5/hws/mlx5dr_cmd.h b/drivers/net/mlx5/hws/mlx5dr_cmd.h
index 3c615b8925..eb9643c555 100644
--- a/drivers/net/mlx5/hws/mlx5dr_cmd.h
+++ b/drivers/net/mlx5/hws/mlx5dr_cmd.h
@@ -250,6 +250,8 @@ struct mlx5dr_cmd_query_caps {
 	bool roce;
 	uint16_t roce_max_src_udp_port;
 	uint16_t roce_min_src_udp_port;
+	uint64_t stc_action_type_63_0;
+	uint64_t stc_action_type_127_64;
 	bool fdb_unified_en;
 };
 
diff --git a/drivers/net/mlx5/hws/mlx5dr_context.c b/drivers/net/mlx5/hws/mlx5dr_context.c
index 91d05f1f86..a854b83ad8 100644
--- a/drivers/net/mlx5/hws/mlx5dr_context.c
+++ b/drivers/net/mlx5/hws/mlx5dr_context.c
@@ -140,6 +140,23 @@ static int mlx5dr_context_uninit_pd(struct mlx5dr_context *ctx)
 	return 0;
 }
 
+bool mlx5dr_context_cap_stc(struct mlx5dr_context *ctx, uint32_t bit)
+{
+	uint32_t test_bit = bit;
+
+	if (bit >= MLX5_IFC_STC_ACTION_TYPE_BIT_64_INDEX)
+		test_bit -= MLX5_IFC_STC_ACTION_TYPE_BIT_64_INDEX;
+
+	switch (bit) {
+	case MLX5_IFC_STC_ACTION_TYPE_JUMP_FLOW_TABLE_FDB_RX_BIT_INDEX:
+		return ctx->caps->stc_action_type_127_64 & (0x1ull << test_bit);
+	default:
+		break;
+	}
+
+	return false;
+}
+
 static void mlx5dr_context_check_hws_supp(struct mlx5dr_context *ctx)
 {
 	struct mlx5dr_cmd_query_caps *caps = ctx->caps;
diff --git a/drivers/net/mlx5/hws/mlx5dr_context.h b/drivers/net/mlx5/hws/mlx5dr_context.h
index e89a093c77..deb7196e39 100644
--- a/drivers/net/mlx5/hws/mlx5dr_context.h
+++ b/drivers/net/mlx5/hws/mlx5dr_context.h
@@ -75,4 +75,6 @@ uint8_t mlx5dr_context_get_reparse_mode(struct mlx5dr_context *ctx);
 void mlx5dr_context_set_pool_tbl_attr(struct mlx5dr_pool_attr *attr,
 				      enum mlx5dr_table_type table_type);
 
+bool mlx5dr_context_cap_stc(struct mlx5dr_context *ctx, uint32_t bit);
+
 #endif /* MLX5DR_CONTEXT_H_ */
-- 
2.34.1

