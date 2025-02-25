Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06056C021A4
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 00:46:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BAE2427C8;
	Tue, 25 Feb 2025 01:46:19 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by mails.dpdk.org (Postfix) with ESMTP id B98F840EE2
 for <dev@dpdk.org>; Tue, 25 Feb 2025 01:46:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/UUkOU1uXoEoWLatudTV+mudC6kuhC0SWmaN4Unhppv+o9HHBxSbZ6Ho6rKRayd5Df2qQaue0rAZTbXy4siVwXk5HAjnjEIwXLnJrUU6tL39I9J9UB5Uipwxsgh6El8FAQBr1lt9hNIHYvepNMNrpwSXayoQ0IWTJwdkkcyPG9xqA53BEU9904Kqo2l/jlwV/EeWgqnAlw70AORbEDMeUUHScjsDystglCVvyYY2El1h/PatSOCn0MHlVNxjXac4l9EN0J0X1XSExaAAPtqGY2kWvMQ7L3iz9cuLNFckh5J3VznMSbi7TPXHnuTI6fkBke8SgBdmzotFtdxbsOkhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2p6nnSg3NZ/fg45bQOtyeMrF3WLioa4is0HHmOHh99c=;
 b=bATYuaKAJn1SsJGMGcrALYvdbrEn/VOeayOddAVpkwtmBKlP+bqbA4AIUbp5GlOph07lkzYuh16uiINmmxqN3p2uCyZGaumxlHj8LIBMNkdlSyPGmEhLuTdgH6HJbBC+4R4/zKeowNeaT5fvsh6BK/s0Zuk5sultsWi0Fm4u+7TL38eNR4uK3LpVUL3thYpoorJE0wZFEuFQnzR/B8+ycQaz5kbht6bZyg74QJo2CNKRVGvtWp2EgofZ545Ka9JJleNtFspoQRt7Z8xfiu6v/DaGigH417RJFy+gVZnU9i4gBN8XpuCIY7Grp5ySVDN5vErM88QROsDYstit1dbu2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2p6nnSg3NZ/fg45bQOtyeMrF3WLioa4is0HHmOHh99c=;
 b=LFP4B1PZU3bTAYWQysmfZrQFIlv4fq9DhJ+QobCkCU8hiw8DA5PXM5NUGRB3S3QZPpH+M2/aTL0kMyccsjNqCNbs6UFay5hb267aQjymY0Zf4xb0o1vhUUblE7bPI10mH2f2F/bAvr6/6WaFPfhtQqkryKCniGCzsUGinbxo2jpcA9qKfF4wHGsUa1Isr8y9AeVgbjebEwVEtuWAtFX0b6zYtnxDdnjss+4kDN70VPYnQooBBUMyS+rztNAr1KWrBz5gRPRzw5dit82duvTeNDaLob8P6zxE0wowz2WamYBVeJ2FSdunR6EdWVG+OCKYmexXII0X6X0zx1YjtXNP2A==
Received: from CH2PR14CA0017.namprd14.prod.outlook.com (2603:10b6:610:60::27)
 by DS0PR12MB7970.namprd12.prod.outlook.com (2603:10b6:8:149::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 00:46:08 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::75) by CH2PR14CA0017.outlook.office365.com
 (2603:10b6:610:60::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Tue,
 25 Feb 2025 00:46:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 00:46:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Feb
 2025 16:45:55 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Feb
 2025 16:45:51 -0800
From: Suanming Mou <suanmingm@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>, Alex Vesker <valex@nvidia.com>
Subject: [PATCH 1/3] net/mlx5/hws: support jump FDB Rx
Date: Tue, 25 Feb 2025 08:45:25 +0800
Message-ID: <20250225004527.2066812-2-suanmingm@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225004527.2066812-1-suanmingm@nvidia.com>
References: <20250225004527.2066812-1-suanmingm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|DS0PR12MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb6bfdc-3f42-4c2e-3be1-08dd5535cada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+5HPm+qkCBezSiozZeXdT6CBoHrBg+GAxvlIkVKXUzxAAs5pExPnwffCtupX?=
 =?us-ascii?Q?njjpxiN3KDQkhlruHGZsk4h8PvZLBefcD38AKg8zdWjXQbfir4p1pV4N23zN?=
 =?us-ascii?Q?rljvgb8rlRo79/AL9NL8O7CcuDZfmaHHEvA3nOFwfK3M2KCvLofGm+fE12Qb?=
 =?us-ascii?Q?14Nctcs69iK/UlRuRspgOUp3PqYprebnGejuQW1IA/YbBxL+4fRrT+Bnj0gN?=
 =?us-ascii?Q?HG+66Mz4oU1DFu9g3JBYPEs9eAXnMOQO/nCMK3bCwS2lMHP4GhEmDtF2PxQr?=
 =?us-ascii?Q?IxWDNoEs3x9MbsA81ojHTVsaQDHfIq2ZTvANmMryoPe2RI809Z+I2AKQ9VB3?=
 =?us-ascii?Q?vPiN7h3887RVYBUlavuwWc/8Nr8a53Sdm0xhBnLMYzbwhjGLGEaPWkprvCLV?=
 =?us-ascii?Q?vo1Ti3/7B+tau9lYNPrbBL0jEqcPzaTXvyo8VqAlDdA3gNShME9E463KLaeL?=
 =?us-ascii?Q?0v66guCOHadT7958r0J2SiYPFxjZvNj+TEbJOEzVnhdVCDEva6/Wf4bZ5Za/?=
 =?us-ascii?Q?U4yoEO0dkYcWnR1EGN11FEzOwRf9XivzmWi3biObzV3mF5nFgNa2PWj8czJ6?=
 =?us-ascii?Q?Dfj6I47GRm8tJE2ojCtLsclNPGULDpqKjERu31aQl7icdmG5SkR2er4CTyI6?=
 =?us-ascii?Q?BfAFeoVbhdi7ueAhlKeAjV02cZGBAi/03Tat5T7v1qpMHGFOiKD52rSTPi1L?=
 =?us-ascii?Q?VbXw/DVHfmPXa7rz8ZriFV63fqbMge+pk4GyunLsL8qDQNOju6Pw4oqCXQXs?=
 =?us-ascii?Q?BhhzLFB/4JkvF+uHeGRppIkMc4zzxwu7BMSdAClF3qOz7LHeTL1J9gLEs8s4?=
 =?us-ascii?Q?Gv2HreJH+RGyYIQuwFuXKsZ7ZIC4ntnvwrp35KfJEtKGvNFCaaXTSQMa8Db6?=
 =?us-ascii?Q?LBmP2ss70Rw++CyVfCwa3JnXhz5Zaa4nN7HaTAT9c4PwdUHFXbFw4rQn5T0m?=
 =?us-ascii?Q?/f6u111WDki6AsdQgDSydCCTLXmhUYEKtOfjwdrPh8Bsv5PpBFgTEjOHH8Ky?=
 =?us-ascii?Q?Pt0l21dj3sS44vSYfcekRJDqw6hW2BrTPT3dnb5iu71oYOS96+kPA5QTgEDi?=
 =?us-ascii?Q?ae4SL2pHEnORu4sxrvYTsbqXoeKTpBO5ITCkTPNYpXhM1P7VsmE1Ls0FeU31?=
 =?us-ascii?Q?djhS2gJKDOgHczCEYPMXt8NXueDZvrlMLQpWEiyhEXBvM/3xt1UxZb+hLCE9?=
 =?us-ascii?Q?c2XgLe8iFWoaTXvdxF9HPJR5EH7EMaW3UW1u5xPShWCptA7IyHcX90Z/yD/4?=
 =?us-ascii?Q?X5VTh60icnbU8fKKtjat4oKXxMfhVVTkRCwtOjRUI8KeiiFn8hTbzOaTibjU?=
 =?us-ascii?Q?dg7leju1bonKXbQVAjDa4kRMMPnzzFY9N5FqAQE87323U5gHDUqp8rDPFLtC?=
 =?us-ascii?Q?p0rqUsDVXH9Bn0SCMpX6i3IiIJMVyAvsFhEeL2h1D9/galUpaEn2EJVawr0e?=
 =?us-ascii?Q?dXH6NjnhQ6nGQX+GRt7AF/bzwZNwA11sSBAz03of6UTXGmPeoLgJLe9vOla0?=
 =?us-ascii?Q?lTytbo8GuLxKCbQ=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 00:46:07.9843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb6bfdc-3f42-4c2e-3be1-08dd5535cada
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7970
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
index f609135ccb..5d1138099d 100644
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
+							capability.wqe_based_flow_table_cap.stc_action_type_63_0);
+
+		caps->stc_action_type_127_64 = MLX5_GET64(query_hca_cap_out,
+							  out,
+							  capability.wqe_based_flow_table_cap.stc_action_type_127_64);
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

