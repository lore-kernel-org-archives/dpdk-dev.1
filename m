Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9745CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 13:26:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB83B410E4;
	Thu, 14 Aug 2025 15:26:09 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by mails.dpdk.org (Postfix) with ESMTP id 49723402CA
 for <dev@dpdk.org>; Thu, 14 Aug 2025 15:26:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ve0Iq72ytdLfogZIlY+B/GTh1FNUVKDe1/lzk6f5M18VRJqcyxqiRpNad41xFBPAq7iM7GBGgftlOcqkDu8Zz02KriyDbibzLrczeT8IgcGU/0lOFZgHeNLqjmtozkijyJdeV1aVOgiYTcDg9scsgULEtzNxSvU/5AgT3l97qglSBF5ysIQcpTtSb4iUou2wr6eVvsu7n082sgDJloJp+PYwShLujECOZXYmiGS+VSS+TwW/1MFFsn7staTlfhbDk975srXdT4jSh9kIZ8r3CGWEI8hxrsTjLOVCPU8KU9weJS9fIBaLPbkWPP6+VhyiuExJY/QGGXXYDNVdozJc9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuX0wbdxsMGWLtq4ctlqgP9e/ks7Oi50cyfmvDvzTM4=;
 b=o2TBXC8fuWY9x1r3rj4yPqZ125elsULmJCO5rcbvKSA0njnjlKHkTJhMhJq8njNJPu52L1tMlPJhzzRkhbYXQm8rNZg7+CHnt8EwAcgUA1Oi0ZHjIgEV/kVV03PungXwZmO2PFhiTXG62nM0+5S22DXO8A3PdNkHVUshr82BY/DBlcmDjS/dJygmUAR/w1uqbAHeq1reCug6ROpHlvp5v9LNpsxAwkPq0xiYyJbx74VUb1p12TDIipMFPeFNNb5/l0PZvVOXDDexaFjcOwC2bK0Z+tZ8mpTbXzNKfRXWe24d/4hpiQ+Sv4QYwPL49a3uqChwcib3/MwEGooS8sJNBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuX0wbdxsMGWLtq4ctlqgP9e/ks7Oi50cyfmvDvzTM4=;
 b=dEMLyv8hs2S0X+849USU5BTUkXW/wkMBs6uP7tnKnzBLSJBNS2FJPM67a2OQJMol2+z0pvBysH4/7ymQaA0hg9diFpYneGc+4rdP8ziSTy3IgmYM2ahdph2YFn3aW63VTQPdEjzQUwNvIBYXmp21wqLTZ1NNufIvr/8SjVPlQ2jk6j9TKfoMn1rGhJLEtM4T9DNonYnixbmzwjpg6hmRmoyEZjpHQ2+94FNmRqsLHzNg1x3f/ogHDjYFtafm8Ui+/DHlWLTcRGtOj+3VO0cnkDa6kyBGbp5+rJgw46ksPQMwHMARdctwalqi1oJ1dU1fiGvXvgolITLOc9gkQjIfvA==
Received: from PH8PR07CA0047.namprd07.prod.outlook.com (2603:10b6:510:2cf::10)
 by DS5PPF5A66AFD1C.namprd12.prod.outlook.com (2603:10b6:f:fc00::64d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 14 Aug
 2025 13:26:05 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:510:2cf:cafe::b6) by PH8PR07CA0047.outlook.office365.com
 (2603:10b6:510:2cf::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Thu,
 14 Aug 2025 13:26:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 13:26:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 14 Aug
 2025 06:25:50 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 14 Aug
 2025 06:25:47 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Erez Shitrit <erezsh@nvidia.com>
Subject: [PATCH] net/mlx5: fix mark action creation
Date: Thu, 14 Aug 2025 15:24:11 +0200
Message-ID: <20250814132411.799853-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|DS5PPF5A66AFD1C:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3796a7-f837-486e-f66f-08dddb361ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zSm3bZa4PFFysisE9Vd9DIADXWQnR2HXBFHUiyD6TPBpvbOyRguURW5+iKg9?=
 =?us-ascii?Q?KQZTkn5juXUrxvhkFxOqD2FvOcyH8vU070sXEQ86zLM2jYZ8M1cPa4I5wUXF?=
 =?us-ascii?Q?707s8r+jA/3c9NKmbMKudADgDYGu91k+NLcBEevh9XMIh3lHgHLazEEH3ku8?=
 =?us-ascii?Q?+6/dZEQMO1SjH0xccL6mHmzKrHm73Gxg6dVvL5X/4PQthGXkAAbNRz269QdT?=
 =?us-ascii?Q?C+hUmyJpHN9vT/nFQtvitbHLBgrf4iXWMbTssVynsygK05pLVVqyO7P1drbE?=
 =?us-ascii?Q?FOK94X3AlQmheJTTRB0zryf/Njxj3u1aAkrqKy21aEgVtHserOXo/yDP69Gk?=
 =?us-ascii?Q?pIHj4XD7ZKxeu8VQCtBtiI9ZD968+fWZbfgMPHXpvUW9cnS4qKr4JbvioU6k?=
 =?us-ascii?Q?41Csd7ZQo4t2jeSLMfGFBm2RE5O6LsPyNWNHMc9tibLWJ3gUXt6hR8TGIdAE?=
 =?us-ascii?Q?w5kQJtksQRrTmtmbWsPagWqCYa0E1g4SYj05ZMg7+1dCXaefMiBtbT00NiRL?=
 =?us-ascii?Q?1dKYiE099VUg4gvX1Kml5aDyeLY+3oq52TSySWnwYrozd4L9Fw11vPiVC/10?=
 =?us-ascii?Q?GAYs2XJ2t/3xFXVmtgZRgliGhe4v0bF25i2y191+IWqmsn11AyKIvG/p3oMy?=
 =?us-ascii?Q?jWm/5Pwc0STSwiayIuROvjdyyOoSbMEKknYGMzqEvx4d3fxeIPXmFr3NwV1P?=
 =?us-ascii?Q?GNe1xn4U2SYizZryPZd7e+9IwhKxa3f+38GvMDKmQXXYvVDnsKCazyggZh2K?=
 =?us-ascii?Q?FfR3y/4jz2GJRB7l/Q4q6AEgBAXyqE2W0oolOjfel0lmkrgX6Vh73Vr5WlTH?=
 =?us-ascii?Q?llBRzL5Mn3WtYnjGzulnPzb2QdULRzfMM0zZ5YJUacwDjgJwFWjeOQY7xWfy?=
 =?us-ascii?Q?g4OXBjjFvRAoGBsTo2lsS9C345ipsme7XbxGLwWQbDKjd56gTathlIQlTFVD?=
 =?us-ascii?Q?aA4IaqrhLJXOoqeiPxAeoQs86CzJ4fL6ghTtCTjo0B5GC6m4l3K1NnU69R7i?=
 =?us-ascii?Q?/OQar3G2sqRVj8fJikJQbwVeZTlYp5qH0UjODNkRZdhz7zdNUWCDIv6QujDr?=
 =?us-ascii?Q?F3iAghaylPEOW9MvMv7SLeIu1G331w95XYjoWZ62FEkyKb0lSqrB8uEjKxw7?=
 =?us-ascii?Q?vmf9NdyMiPRsks3Y9mrCJom8+v+HAa7VvGC4Huht/WMVO+5KBcaUjYGEnelh?=
 =?us-ascii?Q?IMay1BnKgCJ3bWZWjFZzaG2VnGVhcDtpLWLA3IFIdyyVJ5n18MpGrStTDAwu?=
 =?us-ascii?Q?SCcGFKRP+a28sj4/4eeNJ6XP32MrF8TaqxZeAD+rP2dL1e5iCWijX7QruIYp?=
 =?us-ascii?Q?maaTQHGhJ/0k+O/PnM8br58sTB6JpAMnQeEarQvQAkU8HL1mxMcWjum2eCt2?=
 =?us-ascii?Q?sGMTK/zFcj10nb2ryLuWVMiBndSLSxiPFBPZtq4/Y063oxV4DDbdiSNbbOn+?=
 =?us-ascii?Q?KX0jBGm60+iaidVGmQtU198Zedj/bi1+2MgzY0snBCvGyX8IK+deVfdbpIPa?=
 =?us-ascii?Q?S7Y0yqxoFriv7eVi3CD/2W0xEFmo1jncGMim?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 13:26:04.7192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3796a7-f837-486e-f66f-08dddb361ec9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5A66AFD1C
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

Mark flow action is implemented using a flow tag action
exposed by HWS layer.
Whenever flow tag action is used in FDB domain,
HWS layer has to create relevant STC for both FDB sides,
i.e., FDB_RX and FDB_TX.
Flow tag action is not supported on FDB_TX.

This patch adds missing STC fixup code when FDB domain is used,
so that on FDB_TX side, NOP action is used in place of flow tag.

It also updates the higher level mlx5 PMD code to reject usage of mark
flow action in actions templates with transfer attribute set,
and prohibits creation of flow tag action on FDB
if it is not supported by current FW.

Fixes: 794b9b37922f ("net/mlx5: allow FDB RSS")

Signed-off-by: Erez Shitrit <erezsh@nvidia.com>
Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
Acked-by: Suanming Mou <suanmingm@nvidia.com>
---
 drivers/common/mlx5/mlx5_devx_cmds.c |  3 +++
 drivers/common/mlx5/mlx5_devx_cmds.h |  1 +
 drivers/common/mlx5/mlx5_prm.h       |  2 +-
 drivers/net/mlx5/hws/mlx5dr_action.c | 10 ++++++++++
 drivers/net/mlx5/mlx5_flow_hw.c      | 12 +++++++++---
 5 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c b/drivers/common/mlx5/mlx5_devx_cmds.c
index cf601254ab..5622847a4a 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.c
+++ b/drivers/common/mlx5/mlx5_devx_cmds.c
@@ -1366,6 +1366,9 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
 		attr->fdb_unified_en = MLX5_GET(wqe_based_flow_table_cap,
 						hcattr,
 						fdb_unified_en);
+		attr->fdb_rx_set_flow_tag_stc = MLX5_GET(wqe_based_flow_table_cap,
+						hcattr,
+						fdb_rx_set_flow_tag_stc);
 		stc_action_type_127_64 = MLX5_GET64(wqe_based_flow_table_cap,
 						    hcattr,
 						    stc_action_type_127_64);
diff --git a/drivers/common/mlx5/mlx5_devx_cmds.h b/drivers/common/mlx5/mlx5_devx_cmds.h
index f5fda02c1e..01dbb40040 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.h
+++ b/drivers/common/mlx5/mlx5_devx_cmds.h
@@ -327,6 +327,7 @@ struct mlx5_hca_attr {
 	uint32_t wqe_based_flow_table_sup:1;
 	uint32_t fdb_unified_en:1;
 	uint32_t jump_fdb_rx_en:1;
+	uint32_t fdb_rx_set_flow_tag_stc:1;
 	uint8_t max_header_modify_pattern_length;
 	uint64_t system_image_guid;
 	uint32_t log_max_conn_track_offload:5;
diff --git a/drivers/common/mlx5/mlx5_prm.h b/drivers/common/mlx5/mlx5_prm.h
index 7accdeab87..2887f7354d 100644
--- a/drivers/common/mlx5/mlx5_prm.h
+++ b/drivers/common/mlx5/mlx5_prm.h
@@ -2480,7 +2480,7 @@ struct mlx5_ifc_wqe_based_flow_table_cap_bits {
 	u8 ste_format_gen_wqe[0x10];
 	u8 linear_match_definer_reg_c3[0x20];
 	u8 fdb_jump_to_tir_stc[0x1];
-	u8 reserved_at_1c1[0x1];
+	u8 fdb_rx_set_flow_tag_stc[0x1];
 	u8 fdb_unified_en[0x1];
 	u8 reserved_at_1c3[0x1d];
 };
diff --git a/drivers/net/mlx5/hws/mlx5dr_action.c b/drivers/net/mlx5/hws/mlx5dr_action.c
index 5e2b845985..c1c6d28ac4 100644
--- a/drivers/net/mlx5/hws/mlx5dr_action.c
+++ b/drivers/net/mlx5/hws/mlx5dr_action.c
@@ -81,6 +81,7 @@ static const uint32_t action_order_arr[MLX5DR_TABLE_TYPE_MAX][MLX5DR_ACTION_TYP_
 		BIT(MLX5DR_ACTION_TYP_POP_VLAN),
 		BIT(MLX5DR_ACTION_TYP_POP_VLAN),
 		BIT(MLX5DR_ACTION_TYP_CTR),
+		BIT(MLX5DR_ACTION_TYP_TAG),
 		BIT(MLX5DR_ACTION_TYP_ASO_METER),
 		BIT(MLX5DR_ACTION_TYP_ASO_CT),
 		BIT(MLX5DR_ACTION_TYP_PUSH_VLAN),
@@ -877,6 +878,15 @@ mlx5dr_action_fixup_stc_attr(struct mlx5dr_context *ctx,
 		use_fixup = true;
 		break;
 
+	case MLX5_IFC_STC_ACTION_TYPE_TAG:
+		if (fw_tbl_type == FS_FT_FDB_TX) {
+			fixup_stc_attr->action_type = MLX5_IFC_STC_ACTION_TYPE_NOP;
+			fixup_stc_attr->action_offset = MLX5DR_ACTION_OFFSET_DW5;
+			fixup_stc_attr->stc_offset = stc_attr->stc_offset;
+			use_fixup = true;
+		}
+		break;
+
 	case MLX5_IFC_STC_ACTION_TYPE_ALLOW:
 		if (mlx5dr_table_is_fw_fdb_any(fw_tbl_type)) {
 			fixup_stc_attr->action_type = MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_VPORT;
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 6dc16f80d3..d98bc3ca8c 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -6898,6 +6898,12 @@ mlx5_hw_validate_action_mark(struct rte_eth_dev *dev,
 		.transfer = template_attr->transfer
 	};
 
+	if (template_attr->transfer &&
+	    !MLX5_SH(dev)->cdev->config.hca_attr.fdb_rx_set_flow_tag_stc)
+		return rte_flow_error_set(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_ACTION,
+					  action,
+					  "mark action not supported for transfer");
+
 	return mlx5_flow_validate_action_mark(dev, action, action_flags,
 					      &attr, error);
 }
@@ -12061,21 +12067,21 @@ __flow_hw_configure(struct rte_eth_dev *dev,
 	for (i = 0; i < MLX5_HW_ACTION_FLAG_MAX; i++) {
 		uint32_t act_flags = 0;
 		uint32_t tag_flags = mlx5_hw_act_flag[i][0];
+		bool tag_fdb_rx = !!priv->sh->cdev->config.hca_attr.fdb_rx_set_flow_tag_stc;
 
 		act_flags = mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_NIC_RX] |
 			    mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_NIC_TX];
 		if (is_proxy) {
-			/* Tag action is valid only in FDB_Rx domain. */
 			if (unified_fdb) {
 				act_flags |=
 					(mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_RX] |
 					 mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_TX] |
 					 mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_UNIFIED]);
-				if (i == MLX5_HW_ACTION_FLAG_NONE_ROOT)
+				if (i == MLX5_HW_ACTION_FLAG_NONE_ROOT && tag_fdb_rx)
 					tag_flags |= mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_RX];
 			} else {
 				act_flags |= mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB];
-				if (i == MLX5_HW_ACTION_FLAG_NONE_ROOT)
+				if (i == MLX5_HW_ACTION_FLAG_NONE_ROOT && tag_fdb_rx)
 					tag_flags |= mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB];
 			}
 		}
-- 
2.39.5

