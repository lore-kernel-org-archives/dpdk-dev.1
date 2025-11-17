Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB5ACE8D6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 07:42:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 865724279D;
	Mon, 17 Nov 2025 08:42:42 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
 by mails.dpdk.org (Postfix) with ESMTP id 733E4402A1
 for <dev@dpdk.org>; Mon, 17 Nov 2025 08:42:40 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVAU9/CWD5gwKPWI4osH3DO3I8Aq6EVgfNBL81Y/LULbqp/fy0/fMdI9Ao1W0XtmEV8EWIEXcCaQsIaMZuOStj15NLjDGKmIoB7CM4Ydb52c6B2AF64lFAwHyySYIGjkhEqhQyA5A942OIvbL3P1X2agwK2V2a/zxGXAGpHZ8dHRnvZIRVmgSiIkMx2+H+MzUS8YGjZ22DJoZpIycBIYs2D6sWw/9A5BvLVEzYC1ZxYfZ4mhh1MgrCPMTNXk8gOxLNt4zwG6wp3MzddFWvg0njCQqjlo8JyuaLYTT6+0CwJQX9o6+5CENj5+lTPfRlj/z0AK2IEEznB4elKubsdJfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vYhVWPDFPkx54NCY6z923hHSfEn5pvMyoybDCgelWY=;
 b=sxNxdB+z26LiJkLi0q0u61rQyB22S1+dotmRsIfKI6qDTjc8lYob6c+kszAOsUGzPJl0O4EY6ujFvQOQ+MDyeeEWdqaZqPGNGTo4IjMwBk3eoOZABCC02m07h0Uz0U1QqTIwx2QeqftzC+mmXLNwof3JX/dtu95XYrEV4QKFFjcQ0vXnX07gJWuEOu/07/HVcFuHF06yaJ+86sZbtUC32Er5U05XtkjKPWZtEJXsMpwywQ19fYdutbuZqppHVqFnpnLByOOTW0koMHNuuF6aitKmtoaEiO2g5/3ScydKQgedhBRpi1MctLbCplcIKmY9Gncz4VAd0Rggld4De2/XdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vYhVWPDFPkx54NCY6z923hHSfEn5pvMyoybDCgelWY=;
 b=oiZaDh3gwSn0OxlzbuFRRnNhBUrvM4Soj48ywO112OPEj4+Ugl3Ve14lh9V+UA2cVFRyLCer9vKT33WFwohtQZLri1jdDfbft5Y+MTPpaMr5sMBIL66sdT2GmfZa7O9n15rtTCuGvxEEfsuIvuCVQqQ3/N2rSMUAub1U4BnVb0sx0rEN/m9aVlFqNoL/6m1kRJ0rqleHANRJ5hgJbcObEufK1VrjHVQLPYOeckwfNRwNfTneWUdt/d2xSIVTU7/vF6Us6z8V7AtNWX7CrFdxcDjbIXxljM5JL+f9hG5LloIo7rgX2b01n1VgwKcNhensuq0CvPJKCdswagCrBdYZgQ==
Received: from BYAPR06CA0068.namprd06.prod.outlook.com (2603:10b6:a03:14b::45)
 by MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 07:42:35 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::c1) by BYAPR06CA0068.outlook.office365.com
 (2603:10b6:a03:14b::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Mon,
 17 Nov 2025 07:42:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 07:42:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 23:42:17 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 23:42:13 -0800
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>
CC: <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>
Subject: [PATCH v2 2/2] net/mlx5: use private structure for internal tag item
Date: Mon, 17 Nov 2025 09:41:59 +0200
Message-ID: <20251117074159.9480-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117041537.8161-1-bingz@nvidia.com>
References: <20251117041537.8161-1-bingz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|MN2PR12MB4357:EE_
X-MS-Office365-Filtering-Correlation-Id: ca672269-ed26-4722-3a64-08de25acdf91
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+OKAx4TuxhSz1f7eFklIvD6fCcAdv6/b/3cG1FgiKemo9F+RjYAEU1cAL7Vp?=
 =?us-ascii?Q?cobLbRrrRD6riaXGVuEDvTAEgXgbIE7ATRHXXiRI4LolV25s49h/zJatVGvm?=
 =?us-ascii?Q?nBLo/cfkdNUzCRKLdNLNKzkN4Yq+FtoO8vVGtbFN2QpgvpFQ+ppzcZM/aJm0?=
 =?us-ascii?Q?NRWIwNHa5lFjrBtF/DnGZGVwj36D3RvI1tIxqc1OC6hHhCwJaOBv3p8TAXhb?=
 =?us-ascii?Q?wWt7j+4KRnb9aj9ikxCCxwg4w4uXY+FgnYSNyH6XRwO7zQgAoNkrUwhFxRTt?=
 =?us-ascii?Q?juwoOBiQ9MRC8c0lX36uBz+hdbzJPb4poaHVmM9kmEaxoJokyTXz4/KxEvLm?=
 =?us-ascii?Q?pEcD2mQp81l13y9e6SRsDMT+WEiXtb8h8Fe+luy7+hdKxml26Lvp+Je+ytD1?=
 =?us-ascii?Q?JbiDSWth7DKAo3PfpURLDHuo+pnP6g32JsutwHwm14pYEFR4Kdz4mfq9YVBI?=
 =?us-ascii?Q?9jOVQaoR0MUxbYb4MMzy7LUA3vj834uYexAgf+PArxq8E/UdCyJc8OZjAVTm?=
 =?us-ascii?Q?gCqpD8NQR/w2i0R8eUmtl9Kdrydff/rZelTsZY2CXdBGTG2t47FGxeyvNnKw?=
 =?us-ascii?Q?HKjxbiHQjsdQVVQwhYyUYlq6wwR1cns6v3N+KOnbQwmzOwG8oyVTXB2O682w?=
 =?us-ascii?Q?1U2M+jUD3wEfo4gdpEAhM6168KQShPLeOSQpNavP/OK0QgwsCHIDmBHdLOrP?=
 =?us-ascii?Q?WGQ+GIjicK9RpN3hQQfSqc2wFcoYWuL4rxriHlkU36MydjK6Yq5efqDxjgmi?=
 =?us-ascii?Q?l7RmsFtnH/A1BshXsrgaUIxQmBv1b6i97q2ybm6K78CBd6+8hxPs6ekV0Xz6?=
 =?us-ascii?Q?SyoJjc2jPJsYpXafqNaruCzzmqL4hwP71qxE8VGCSO3ce2/p3UigpepLY7QB?=
 =?us-ascii?Q?pPeUm+FI3Xuf7h7W9UlMt8V83CbtpFF9CuPTrjrI+/61PvM2omldkGOZHzU+?=
 =?us-ascii?Q?GGyoT2aHD7V9UGt22n3CGOu4EXVjHBaQ26xekLifkeUlqJ4oEux5iIOblsyB?=
 =?us-ascii?Q?oz8qX2wPlxHIDOXd9rbd9wHpDhTRWfSsBJpJGL4iBLL16Y1RU1OH7pX294/H?=
 =?us-ascii?Q?hIsM14A30Nk2LBScVBJA1gBlebplKJlVcbcX0iRkfNQbfr9F0m5my5f2AWb+?=
 =?us-ascii?Q?/MP5aWo7PfjOd3+9TLsEpqCzcgR9XQ3XL0ZtwCmqK5E+jpECtUAptieTd0Uc?=
 =?us-ascii?Q?h3NVWZQW9p5XW9ZnmY93p1F6zaUjZoyc3+xWyWw4eLn//IkjBh/zHr8APTmJ?=
 =?us-ascii?Q?9hFbpmreDcweXg2wZAG2gYulmQU5MwK/uMJNcV3ABM5blkv9h1mIhVXLPn0U?=
 =?us-ascii?Q?HfHwdOBZ79TSt1BcnJh2vv6UCFR5+DW617PFJ3j8Jpmb4X5kKneCbGYWfbwt?=
 =?us-ascii?Q?Ck9k3DoIBFFcKPHsts4DcEuq9S2m1+GuijdTBZ/8tNy+0pJGOq5RSNTlbLGy?=
 =?us-ascii?Q?6gM/wyPzYgvhu+9F2Yw+8e3BmMGF6jJ2mF3+qgZ9PkGO8kpyTz2ZQVZoY56Y?=
 =?us-ascii?Q?USq6pzaXK/G5hEP3RfvJTusoFm5Btm4vIsVno+r42k43LXQ5lLbpztgwQo5o?=
 =?us-ascii?Q?F+aHU9kq34+wdEmVrJE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 07:42:34.7626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca672269-ed26-4722-3a64-08de25acdf91
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357
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

The legacy DV API is used to translate the mask of a matcher and the
value of a rule on the root table, no matter it is in SWS or HWS
mode. The structure "mlx5_rte_flow_item_tag" is used instead of
public "rte_flow_item_tag". This is used internally to speed up and
simplify the usage of the available REG_Cs.

Since the offsets of the fields are different, the DV API would get
the incorrect value when constructuing the matcher and value. The
private structure should be used for the DV API. Also, in the
validation stage, the proper structure should be used.

Fixes: 483181f7b6dd ("net/mlx5: support device control of representor matching")
Fixes: ddb68e47331e ("net/mlx5: add extended metadata mode for HWS")
Fixes: 26e1eaf2dac4 ("net/mlx5: support device control for E-Switch default rule")

Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
v2: fix the building failure of the unknown private structure size by
using memcpy
---
 drivers/net/mlx5/mlx5.h         |  4 +--
 drivers/net/mlx5/mlx5_flow_hw.c | 46 ++++++++++++++++-----------------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 7e4bfacd11..3d1b5371f0 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -469,8 +469,8 @@ struct mlx5_flow_hw_pattern_params {
 	struct rte_flow_item items[MLX5_HW_MAX_ITEMS];
 	/** Temporary REPRESENTED_PORT item generated by PMD. */
 	struct rte_flow_item_ethdev port_spec;
-	/** Temporary TAG item generated by PMD. */
-	struct rte_flow_item_tag tag_spec;
+	/** Temporary internal MLX5_TAG item generated by PMD, no more than 2 DWs. */
+	uint8_t mlx5_tag_spec[sizeof(uint32_t) * 2];
 };
 
 /* HW steering flow management job descriptor. */
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index e0f79932a5..f759a50d36 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -3844,6 +3844,10 @@ flow_hw_get_rule_items(struct rte_eth_dev *dev,
 		       struct mlx5_flow_hw_pattern_params *pp)
 {
 	struct rte_flow_pattern_template *pt = table->its[pattern_template_index];
+	struct mlx5_rte_flow_item_tag mlx5_tag = {
+			.id = REG_C_0, /* vport_meta_tag is using C_0 */
+			.data = flow_hw_tx_tag_regc_value(dev),
+		};
 
 	/* Only one implicit item can be added to flow rule pattern. */
 	MLX5_ASSERT(!pt->implicit_port || !pt->implicit_tag);
@@ -3855,7 +3859,7 @@ flow_hw_get_rule_items(struct rte_eth_dev *dev,
 			return NULL;
 		}
 		/* Set up represented port item in pattern params. */
-		pp->port_spec = (struct rte_flow_item_ethdev){
+		pp->port_spec = (struct rte_flow_item_ethdev) {
 			.port_id = dev->data->port_id,
 		};
 		pp->items[0] = (struct rte_flow_item){
@@ -3870,12 +3874,10 @@ flow_hw_get_rule_items(struct rte_eth_dev *dev,
 			return NULL;
 		}
 		/* Set up tag item in pattern params. */
-		pp->tag_spec = (struct rte_flow_item_tag){
-			.data = flow_hw_tx_tag_regc_value(dev),
-		};
-		pp->items[0] = (struct rte_flow_item){
+		rte_memcpy(pp->mlx5_tag_spec, mlx5_tag, sizeof(struct mlx5_rte_flow_item_tag));
+		pp->items[0] = (struct rte_flow_item) {
 			.type = (enum rte_flow_item_type)MLX5_RTE_FLOW_ITEM_TYPE_TAG,
-			.spec = &pp->tag_spec,
+			.spec = (const void *)&pp->mlx5_tag_spec,
 		};
 		rte_memcpy(&pp->items[1], items, sizeof(*items) * pt->orig_item_nb);
 		return pp->items;
@@ -8559,21 +8561,21 @@ __flow_hw_pattern_validate(struct rte_eth_dev *dev,
 		}
 		case MLX5_RTE_FLOW_ITEM_TYPE_TAG:
 		{
-			const struct rte_flow_item_tag *tag =
-				(const struct rte_flow_item_tag *)item->spec;
+			const struct mlx5_rte_flow_item_tag *mlx5_tag =
+				(const struct mlx5_rte_flow_item_tag *)item->spec;
 			uint16_t regcs = (uint8_t)priv->sh->cdev->config.hca_attr.set_reg_c;
 
-			if (!((1 << (tag->index - REG_C_0)) & regcs))
+			if (!((1 << (mlx5_tag->id - REG_C_0)) & regcs))
 				return rte_flow_error_set(error, EINVAL,
 							  RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
 							  NULL,
 							  "Unsupported internal tag index");
-			if (tag_bitmap & (1 << tag->index))
+			if (tag_bitmap & (1 << mlx5_tag->id))
 				return rte_flow_error_set(error, EINVAL,
 							  RTE_FLOW_ERROR_TYPE_ITEM,
 							  NULL,
 							  "Duplicated tag index");
-			tag_bitmap |= 1 << tag->index;
+			tag_bitmap |= 1 << mlx5_tag->id;
 			break;
 		}
 		case RTE_FLOW_ITEM_TYPE_REPRESENTED_PORT:
@@ -9028,13 +9030,13 @@ flow_hw_pattern_template_create(struct rte_eth_dev *dev,
 		.type = RTE_FLOW_ITEM_TYPE_REPRESENTED_PORT,
 		.mask = &rte_flow_item_ethdev_mask,
 	};
-	struct rte_flow_item_tag tag_v = {
+	struct mlx5_rte_flow_item_tag tag_v = {
 		.data = 0,
-		.index = REG_C_0,
+		.id = REG_C_0,
 	};
-	struct rte_flow_item_tag tag_m = {
+	struct mlx5_rte_flow_item_tag tag_m = {
 		.data = flow_hw_tx_tag_regc_mask(dev),
-		.index = 0xff,
+		.id = (enum modify_reg)0xff,
 	};
 	struct rte_flow_item tag = {
 		.type = (enum rte_flow_item_type)MLX5_RTE_FLOW_ITEM_TYPE_TAG,
@@ -10119,11 +10121,11 @@ flow_hw_create_ctrl_regc_sq_pattern_template(struct rte_eth_dev *dev,
 		.relaxed_matching = 0,
 		.transfer = 1,
 	};
-	struct rte_flow_item_tag reg_c0_spec = {
-		.index = (uint8_t)REG_C_0,
+	struct mlx5_rte_flow_item_tag reg_c0_spec = {
+		.id = (uint8_t)REG_C_0,
 	};
-	struct rte_flow_item_tag reg_c0_mask = {
-		.index = 0xff,
+	struct mlx5_rte_flow_item_tag reg_c0_mask = {
+		.id = (enum modify_reg)0xff,
 		.data = flow_hw_esw_mgr_regc_marker_mask(dev),
 	};
 	struct mlx5_rte_flow_item_sq queue_mask = {
@@ -10131,14 +10133,12 @@ flow_hw_create_ctrl_regc_sq_pattern_template(struct rte_eth_dev *dev,
 	};
 	struct rte_flow_item items[] = {
 		{
-			.type = (enum rte_flow_item_type)
-				MLX5_RTE_FLOW_ITEM_TYPE_TAG,
+			.type = (enum rte_flow_item_type)MLX5_RTE_FLOW_ITEM_TYPE_TAG,
 			.spec = &reg_c0_spec,
 			.mask = &reg_c0_mask,
 		},
 		{
-			.type = (enum rte_flow_item_type)
-				MLX5_RTE_FLOW_ITEM_TYPE_SQ,
+			.type = (enum rte_flow_item_type)MLX5_RTE_FLOW_ITEM_TYPE_SQ,
 			.mask = &queue_mask,
 		},
 		{
-- 
2.34.1

