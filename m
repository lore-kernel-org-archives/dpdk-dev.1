Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A2CC18E7C
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 16:05:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 914EE40662;
	Wed, 26 Feb 2025 17:05:25 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by mails.dpdk.org (Postfix) with ESMTP id 01FD94026C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 17:05:22 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnMZh7YmVJSKta4utNDDuA9pFDuLv0qYTCiKowFWkf7zfGUX15l+9FPry2UR0HogIcl95SZFtbz4nm0N5snc0JbwFHHQgRfSWnoU5/jtunC9STD2sN5kpqpt97bf60kuHzLEWEd2sWl4IP+ILg1NI9o3pFEFwNiLEa2hcSqgkb5YAHadnSgVgON7aiZLJgqYJB0nxPMyLa02NOmzJMqfck3GVD9mZxd7jTzDuE/4kcZPH1O/LmtVkPn5C8QhF0fO+H7zO29mU2vzE+wudtPp3Usdh4qoesSxhp0d+T/KTLLV1v8uzlXFUn9ik9SUjo6CmStiCtjlowuMzZiiRAFRvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HI9sNrFdTB8R6JUhwEeP265WoCt7xhqk+3Pgl0RCQfo=;
 b=pYsvpNF9Ya82OBjLLR0gpO6os2OXTV5iv7VwCrq+Y4zU9ZNTFQn1rPrscua/nMlnfdxhpQjzEaqYAqQtSBDK09OLgKpms6Z8ePkh7Wdt4k08NvYNnVcaOBDGNWzJY3ZMLSfRDW/UUlU+UVss0D6huBAgzF8+5zXgpfLzKkeeFcWgDg3w1Ha+KKGzI8f/MIkLGG2qOkSD58jGbrK8mezSwIbmhG2zSTO+r6p0RPEI9e8Im3gqRuxgn8I3mRYU1rApZsl9OHnWvoVbZhvKNwicwVCsDXOfDwJMvqktas7hSGLqivu3YblutfYT7htzeMom+XC2HdYaVzaGvfJbR/mF8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HI9sNrFdTB8R6JUhwEeP265WoCt7xhqk+3Pgl0RCQfo=;
 b=rM+CIj/4j1JLaPmr077g7YAt8KHLctyXH9gseHdXZn95HIRoK7KbxtX3beEwRW6OZfYWxZN1vCpjWKbjN0nA5xVeBDD6obQyesfDjBBJGomdeRWw+0zoYWZcNsWA+YQV1b7HSSxyhqjmEDqS13stZ6r7qclmeQpbBNF3R5JOjvGoAO2/90jCoqA+ad8Xyk9c7k8khY8PMQ7DrcTgOWNWLPb0Z1aQj7rdHDCYJL0FkeyprcXma/hPUlcb2k3cOrj7R8u/iIgT21VIIAcPOpH9n0NrU1UenGXGGiKXIcXc0p6PimrVvWC5+7ob1wdzXgyHvCzmfLh7hJUeBFJ4R/v0dg==
Received: from BL1PR13CA0018.namprd13.prod.outlook.com (2603:10b6:208:256::23)
 by SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 16:05:11 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::1c) by BL1PR13CA0018.outlook.office365.com
 (2603:10b6:208:256::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 16:05:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 16:05:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 08:04:51 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 08:04:49 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>, Alex Vesker
 <valex@nvidia.com>
Subject: [PATCH v3 1/3] net/mlx5/hws: support jump FDB Rx
Date: Wed, 26 Feb 2025 17:04:23 +0100
Message-ID: <20250226160425.78147-2-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226160425.78147-1-dsosnowski@nvidia.com>
References: <20250226140119.2142352-1-suanmingm@nvidia.com>
 <20250226160425.78147-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|SJ1PR12MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: 56825f34-5419-46b3-99b5-08dd567f58dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+BtZXcNtosn1XXZnyEA5hQsJCT6mKbg6cTGZ3hBXu+2m7IqysERVmmU6pZbz?=
 =?us-ascii?Q?4eCfJT+334aYBlDJirgYrz1huN/CB4rRE4fbDG7G1SPwpFdPjgmJ3sMnMgXz?=
 =?us-ascii?Q?3jgUEQpe2Hi2Nluq9MZr481FBPHrImuZfeyovZBWounrqcfLK1puT7H1ewu1?=
 =?us-ascii?Q?MHq+jfpV4146bN3qTJotFOrcKudG9ToyeCJFcyOskErBHPKctOAQt5QPk0wM?=
 =?us-ascii?Q?QJ9L2o6OQlBZUbLVGEZR+FgTlbbRW9uYvDPgYEsJOhtBKbR/ANU3vJcrns7A?=
 =?us-ascii?Q?aVPCnvFA57vqkgqYT8W8U9RFQRZLIiDbxUCovyW9RPZaXt8H3bYUvES+9v7Q?=
 =?us-ascii?Q?5jbTqjYq6j0c6lBXJ+42Y/VfyVCvdI4Yaq4Q+9G5ByVv9qSW0qcYUBx87Fm4?=
 =?us-ascii?Q?GVoGXsWIYu6ViTuLxb3vriZjIBaUP4Audpj1alml3YmPy0TxpF0v0rYfQVNk?=
 =?us-ascii?Q?RuD2P4CHW9s5TLXOMfdymM00Fb/BXGPfxiHBQy2/GuU4QKuvJeCfiL6eafQ9?=
 =?us-ascii?Q?V5k9IpcMR31mTsjUdetfZ/uyh0TIBNBBmRGIJMNTy3PylVEQkIztqWrgaAUq?=
 =?us-ascii?Q?7LjBvRKRoPbq5SCqoDVVL8sZfJcDTUzXcPr8vvkDFVjONry90FjEQMC2s8Y6?=
 =?us-ascii?Q?GlOMv2sfetN30xbkCI4QJWh4pk/WuhBzpVBbcrwNhTDwUl9bcJ0OPpdZ4DtD?=
 =?us-ascii?Q?2vIXNc11qmhUvDpjO9r09AGb+XzbaQTNENgwbYk0vJ64AhC6HkbPEhsXwMLV?=
 =?us-ascii?Q?ccGGBwhZUN6lVL6k7L55eqVLA+4eACv7esB9uOYXaLpXKaddfFUiTDBJccOE?=
 =?us-ascii?Q?fVRD/GU1OxJ6PqZYkBG06MoYbF9Ed91dh+PneL5ID1QIDz3SKG7FX/mblzdb?=
 =?us-ascii?Q?n8GMpWy7xxMhOR0G/1FDsL0JvF8NBeS7XrYCMfhuFJxsUfBEYV9BysEDZYWU?=
 =?us-ascii?Q?7v4CBjPC+5LaqdDGouYs1dsH42SxtHulS0wt/NElGqoU0E9w2bhLYM6GadFT?=
 =?us-ascii?Q?WKVthL3smTtLi8QWHcOEiycyWQYn6DG1BbRU3wZfoC+OryzEE3kC2vlc+jtZ?=
 =?us-ascii?Q?ATwJ3O2ljkLySzEUDysPBHGUYeFdU9S2ZisCCjmSFsSu4e1HTXMC4Zuuodh3?=
 =?us-ascii?Q?1T0aO8pLJN5n88Xcz+pl4KcdETkmzfXDBlH419dlSi5A+ptqVOsGTDGicXcz?=
 =?us-ascii?Q?ZGVl5Q2LgXNyUrnUUxuACuniRJkQ1Pr1dsWeUHCjZIAezvNOEc/nLxYG5eWV?=
 =?us-ascii?Q?06bywu3t1++wNUKnDPDazILJKTiIDc4zS9ZbClzPz7B8CXD5D0amcORfAO6i?=
 =?us-ascii?Q?YyDk4+jx5+a8Ku5XE3nIOkuqks5IZjIgfgfcAMWUbQfIUW7nqF0IrQYrwbnF?=
 =?us-ascii?Q?nn7UIscH8pUXa71Lf9pa81IPlFbB9mRNR3AFf0I+0+rW+Fdov3alEOS7DFr4?=
 =?us-ascii?Q?xx/3TCOV9vBxlNoBc9j6CiuJEqZ++JZN+no62KMhyYIq/NwZpuicD2xLO7z1?=
 =?us-ascii?Q?bURVTfJLTaGotqg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 16:05:10.6356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56825f34-5419-46b3-99b5-08dd567f58dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289
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

From: Suanming Mou <suanmingm@nvidia.com>

Before FW introduced the JUMP_FDB_RX action feature, jump from
FDB Tx to Rx is not allowed. JUMP_FDB_RX feature introduces
the internal loopback for Tx case and allow the REG C0 C1 B be
preserved as well.

This commit adds the JUMP_FDB_RX cap bit check and use
JUMP_FDB_RX instead of FT for dest table FDB Rx case.

Signed-off-by: Suanming Mou <suanmingm@nvidia.com>
Signed-off-by: Alex Vesker <valex@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
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
index 0885f8757f..742c274a85 100644
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
index 200a4995d0..c3e67f8a0b 100644
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
index 354d6dd89b..d6bf015d57 100644
--- a/drivers/net/mlx5/hws/mlx5dr_cmd.c
+++ b/drivers/net/mlx5/hws/mlx5dr_cmd.c
@@ -470,6 +470,7 @@ mlx5dr_cmd_stc_modify_set_stc_param(struct mlx5dr_cmd_stc_modify_attr *stc_attr,
 		MLX5_SET(stc_ste_param_tir, stc_param, tirn, stc_attr->dest_tir_num);
 		break;
 	case MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_FT:
+	case MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_FLOW_TABLE_FDB_RX:
 		MLX5_SET(stc_ste_param_table, stc_param, table_id, stc_attr->dest_table_id);
 		break;
 	case MLX5_IFC_STC_ACTION_TYPE_ACC_MODIFY_LIST:
@@ -1284,6 +1285,14 @@ int mlx5dr_cmd_query_caps(struct ibv_context *ctx,
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
2.39.5

