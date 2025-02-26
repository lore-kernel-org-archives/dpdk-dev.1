Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5883EC19776
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 07:18:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 252A9402D8;
	Wed, 26 Feb 2025 08:18:05 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by mails.dpdk.org (Postfix) with ESMTP id 30E4D4027C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 08:18:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsQT7Xby5q/v7ggBO5y1E1uhnKp/jUigvy2yBXUxc4tcW9X+xSjz1buwYLP2yAE+z4JP7dTdp5+5OyMgKZXFRuwqhE+2wj1tfq6/rJ4F53K4AF1C+VJMZNU04QEIxiRpdPA3pr2HeDJEMXm20Kz2JqrStzNdFqt5MNF1+H5BNWTduOgiCsO7Cc4QjPZmnyHEfZBw5qdADRjLr3pGaknD3p5CwiLALuoKrlu3G/oFHQlPQ1hU6tVoFSX5XxctgDQdMbGcCtiG+TVkJ/cZVNdHB7x/7h3gu776gG7ap2ZFizTUTmENzQ43PeeqZ60oQCVMh+iw3hzZ/5yv3/lvkZKJFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZHc52zcGJgreIRhh+nMi6bciu9p25l0no4I5N4X1ns=;
 b=ibU7pG2XCoGGlRHLbt7/q7YGrwGg1BpYhRHdDs8JMty7pmgdpT1RIYLiYA4IxKfvpUuzWymXm6xk41rnFjGnmD+E2nwAnxaXW41/QDCMJt0rDXzSnuE3ZZ58CUyBe9dFzov7tD27IsHV7GqoXF37zqvgACaIdHOmOFS3+9yfTmznN/qMrgZ2KRAXO4Z388tzzcezHcBRDQlpZVIrBaPsQr0NI15EM0zL6r0q23jXD4kyeKJVHb9fGpwhesqs2KNeKMCRek0QaxD4djhuTFvbVlHg8xjh8jIrD4ocSfHZyd8fAKsc6G+NM27CfF263+Krm8TzKJT3lTjrH+1DpecUuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZHc52zcGJgreIRhh+nMi6bciu9p25l0no4I5N4X1ns=;
 b=AGcl53kVREWJBN0px4+jKZshZaltndQqu2z+mOahsQIts7vX4l5Voia2rB2aIf+ujOgRD63cD58LrVeNK/uIeHrogW6IIZ9gKmn+Nbgi+8nYLwq1/0yccn4qsxrBO+ibVTtShoZPzWgFGdr5KhF0x/wlxaOgOshfxtvI1YMXwhPFlXWTOgGDynqKSyJm3CPMXiql6N3XPhGJjtLY3Bq9TF/FJj7IZGNPPqPWAiOXTY0XNN3q5pJRKPAwI0Og2uFekTPbi0+EBgSX0OT5KfGcT2+XfBBDEeWfIGpe5exQUqTOmUoxKTmGThICI/oDonNplNU5faiB148hIul6iNF6zQ==
Received: from SJ0PR05CA0141.namprd05.prod.outlook.com (2603:10b6:a03:33d::26)
 by SN7PR12MB7371.namprd12.prod.outlook.com (2603:10b6:806:29a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 07:17:58 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::9) by SJ0PR05CA0141.outlook.office365.com
 (2603:10b6:a03:33d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.15 via Frontend Transport; Wed,
 26 Feb 2025 07:17:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 07:17:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 23:17:41 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 23:17:39 -0800
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>
CC: <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <hamdani@nvidia.com>
Subject: [PATCH v3] net/mlx5: add eCPRI support
Date: Wed, 26 Feb 2025 09:17:24 +0200
Message-ID: <20250226071724.12769-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226065023.12560-1-bingz@nvidia.com>
References: <20250226065023.12560-1-bingz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|SN7PR12MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: d3a764c7-c42d-4216-8315-08dd5635b22e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RSj18XvfoIt5wLORu0+3h6MNAaw5Zhui+3juZtJKpGrH6OX3bypb1m/ZMVD2?=
 =?us-ascii?Q?aLgswsIlaagUBiPfwPd8OSz8SrLIIY9tb4FB13LaWWarRvOh9DDyyM0l/h/O?=
 =?us-ascii?Q?Vl40dUG77pTVdgl1vUs0ggQC9yhA/1Uu0rTMZAqcrp7hH0tCqkrFXoF3sfAv?=
 =?us-ascii?Q?4Cqb/+v3nAwDR8OIr3D9NZWyma23a2jalOeOS4JC7kpfylm6IXp7zyzaviAU?=
 =?us-ascii?Q?vJOFz6gJgJBsZOovOp/bvV5GoSh6RBTyogiWaxFxCcba/TOECIOKcCaGkbXU?=
 =?us-ascii?Q?HzGnOtQVPKYM5enQBauFv7VgAs0/DcEhZCowA3LYbjr4/15Vdy7WFq4N7i1l?=
 =?us-ascii?Q?kDbsXiBxw/3QbsBZLLWslMdnmfO+YW32L9sBcP+ZYC5eHtExq+VXwIo4nqFW?=
 =?us-ascii?Q?d5LdW/riNawxdjgRDCaExr/bmLMbKI06JP7ydCsqrxZ5kN5K/JNKyzrPF5zM?=
 =?us-ascii?Q?Vju0WjUnuND1c/hmv4I6K5bkdIUUEhOO1/EfqgflImK3GkP7pdAp9HSsNkTe?=
 =?us-ascii?Q?3H7xh9NrSiHFywBuUEQ94CbsGjttKEWs3zuVWbChc71BdgiZWqkgYPalNwRb?=
 =?us-ascii?Q?zHLw/dzdex0MlSUxJJWCGfRx3Qt6KzXyUCKL1SQfDkzBsqtEM7vtbs3O6b+e?=
 =?us-ascii?Q?c25Ab9uH47bqdTCWP/4zQT8An+rChNuaquHCERZECBfhxGrncfQCpe4vBYL8?=
 =?us-ascii?Q?rDp4kedW4M3K1uMhj+AQrKmvHfVJBaVS2SGbyvNOux118JgzzHBnQoLvpq5i?=
 =?us-ascii?Q?GLP6NfLEJmmRwrmh7T2sg4h09Js3GRgbzksQ0+rafR3PLfaqGyLZoclrm965?=
 =?us-ascii?Q?dIROiTOQX0NyuiHhuX2GVbi+snQ+bl1bDUrOqmSVcc+n8Coh0NcREVOCePBv?=
 =?us-ascii?Q?hhvls9eo7ND2CY1esWBAoNPCfNNbIppuxDaaMFRHa8rzM8fIdiPjrQkA3BEa?=
 =?us-ascii?Q?9QH/1Q30PNJbjG1Qu4l6Vku8iJkL/QpgnuvjSXu83yqvv73ieSAChGXMADPG?=
 =?us-ascii?Q?Ij8uhincm1RBcsidmkbD9mpV8EfD4p3NzHFcOnYvxybBTPJKmVD3Lz15uXaz?=
 =?us-ascii?Q?NCfczgjPfolECGzR3aUT4Z9MQ6/XWEUEUi+AfOEl6IiNdmHjwVEkqAUKyBOQ?=
 =?us-ascii?Q?uaeWC69PWeM4+SbAx4fX4Od7ReP2Z0FN8aYPvcfRoPgXl4bKDUWGomuzILdT?=
 =?us-ascii?Q?G4DRAPpQZUFRsk4LlJpOrI5B/1zmx3/lUM+lV2z9uK35UUy4pI1LaOEk5M2N?=
 =?us-ascii?Q?esSs1uNZIwuvmIJCAtu/6caDRnEyj+ee6MIHSaEDSi4v/TsojcENsE3Gmvl8?=
 =?us-ascii?Q?mzXHtrIyrQdw9XmAesdjng1lVtJUKUarksNun8IElIwJgsComfv84HKxYiSL?=
 =?us-ascii?Q?ptEE0WYZvwg0I/XX6xazjwNU+IMB05Wew0/rIdLcjbGNCgyQfgC801jqGvfh?=
 =?us-ascii?Q?BBx6YoqU/9eBEh1Q2YFKfgx6ZiOayUlE2yzI5oPzTe8W8PhsetEKEBvWhyft?=
 =?us-ascii?Q?PXD1/Ip5b/NZ/y8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 07:17:57.8032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a764c7-c42d-4216-8315-08dd5635b22e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7371
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

Support eCPRI item matching over L2 (ETHER / VLAN) in HWS, both for
template API and backward compatibility API.

Signed-off-by: Bing Zhao <bingz@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
v2: fix the checkpatch warning of unneeded else
v3: fix single line if condition code style warning
---
 drivers/net/mlx5/hws/mlx5dr_definer.c | 86 +++++++++++++++++++++++++++
 drivers/net/mlx5/mlx5_flow.h          |  3 +
 drivers/net/mlx5/mlx5_flow_hw.c       | 59 ++++++++++++++++++
 3 files changed, 148 insertions(+)

diff --git a/drivers/net/mlx5/hws/mlx5dr_definer.c b/drivers/net/mlx5/hws/mlx5dr_definer.c
index 837e0c47bd..25087022c1 100644
--- a/drivers/net/mlx5/hws/mlx5dr_definer.c
+++ b/drivers/net/mlx5/hws/mlx5dr_definer.c
@@ -583,6 +583,35 @@ mlx5dr_definer_ipv6_routing_ext_set(struct mlx5dr_definer_fc *fc,
 	DR_SET(tag, val, fc->byte_off, 0, fc->bit_mask);
 }
 
+static void
+mlx5dr_definer_ecpri_common_set(struct mlx5dr_definer_fc *fc,
+				const void *item,
+				uint8_t *tag)
+{
+	const struct rte_flow_item_ecpri *ec = item;
+	uint32_t val;
+
+	val = ec->hdr.common.u32;
+
+	DR_SET_BE32(tag, val, fc->byte_off, 0, fc->bit_mask);
+}
+
+static void
+mlx5dr_definer_ecpri_body_set(struct mlx5dr_definer_fc *fc,
+			      const void *item,
+			      uint8_t *tag)
+{
+	const struct rte_flow_item_ecpri *ec = item;
+	uint32_t val, idx;
+
+
+	idx = fc->fname - MLX5DR_DEFINER_FNAME_FLEX_PARSER_0;
+	/* The 1st DW is used for common field, indeed, there are only 2 DWs. */
+	val = ec->hdr.dummy[idx - 1];
+
+	DR_SET_BE32(tag, val, fc->byte_off, 0, fc->bit_mask);
+}
+
 static void
 mlx5dr_definer_flex_parser_set(struct mlx5dr_definer_fc *fc,
 			       const void *item,
@@ -2555,6 +2584,59 @@ mlx5dr_definer_conv_item_random(struct mlx5dr_definer_conv_data *cd,
 	return 0;
 }
 
+static uint32_t
+mlx5dr_definer_get_ecpri_parser_byte_off_from_ctx(void *dr_ctx, uint32_t *byte_off)
+{
+	uint32_t base_off = MLX5_BYTE_OFF(definer_hl, flex_parser.flex_parser_0);
+	struct mlx5_ecpri_parser_profile *ecp;
+	uint32_t i;
+
+	ecp = flow_hw_get_ecpri_parser_profile(dr_ctx);
+	if (!ecp)
+		return UINT32_MAX;
+	for (i = 0; i < ecp->num; i++)
+		byte_off[i] = base_off - ecp->ids[i] * sizeof(uint32_t);
+	return i;
+}
+
+static int
+mlx5dr_definer_conv_item_ecpri(struct mlx5dr_definer_conv_data *cd,
+			       struct rte_flow_item *item,
+			       int item_idx)
+{
+	const struct rte_flow_item_ecpri *m;
+	uint32_t i, mask, byte_off[8] = {0};
+	struct mlx5dr_definer_fc *fc;
+	uint32_t num_dws;
+
+	num_dws = mlx5dr_definer_get_ecpri_parser_byte_off_from_ctx(cd->ctx, byte_off);
+	if (num_dws == UINT32_MAX) {
+		DR_LOG(ERR, "failed to get eCPRI samples %d", -rte_errno);
+		return rte_errno;
+	}
+
+	m = item->mask;
+	if (!m)
+		return 0;
+
+	for (i = 0; i < num_dws; i++) {
+		mask = i == 0 ? m->hdr.common.u32 : m->hdr.dummy[i - 1];
+		if (!mask)
+			continue;
+		mask = htobe32(mask);
+		fc = mlx5dr_definer_get_flex_parser_fc(cd, byte_off[i]);
+		if (!fc)
+			return rte_errno;
+
+		fc->item_idx = item_idx;
+		fc->tag_set = i == 0 ? &mlx5dr_definer_ecpri_common_set :
+				       &mlx5dr_definer_ecpri_body_set;
+		fc->tag_mask_set = &mlx5dr_definer_ones_set;
+		fc->bit_mask = mask;
+	}
+	return 0;
+}
+
 static int
 mlx5dr_definer_conv_item_geneve(struct mlx5dr_definer_conv_data *cd,
 				struct rte_flow_item *item,
@@ -3314,6 +3396,10 @@ mlx5dr_definer_conv_items_to_hl(struct mlx5dr_context *ctx,
 								  MLX5_FLOW_ITEM_OUTER_FLEX;
 			}
 			break;
+		case RTE_FLOW_ITEM_TYPE_ECPRI:
+			ret = mlx5dr_definer_conv_item_ecpri(&cd, items, i);
+			item_flags |= MLX5_FLOW_LAYER_ECPRI;
+			break;
 		case RTE_FLOW_ITEM_TYPE_MPLS:
 			ret = mlx5dr_definer_conv_item_mpls(&cd, items, i);
 			item_flags |= MLX5_FLOW_LAYER_MPLS;
diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index 445c9cdb4b..e5245edd46 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -1812,6 +1812,7 @@ flow_hw_get_reg_id_from_ctx(void *dr_ctx, enum rte_flow_item_type type,
 
 #endif
 
+
 /*
  * Define list of valid combinations of RX Hash fields
  * (see enum ibv_rx_hash_fields).
@@ -3704,5 +3705,7 @@ mlx5_flow_nta_update_copy_table(struct rte_eth_dev *dev,
 				uint64_t action_flags,
 				struct rte_flow_error *error);
 
+struct mlx5_ecpri_parser_profile *flow_hw_get_ecpri_parser_profile(void *dr_ctx);
+
 #endif
 #endif /* RTE_PMD_MLX5_FLOW_H_ */
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index e72b87d70f..48b1b5f95e 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -5096,6 +5096,16 @@ flow_hw_table_create(struct rte_eth_dev *dev,
 					   NULL, "pattern template domain does not match table");
 			return NULL;
 		}
+		if (item_templates[i]->item_flags & MLX5_FLOW_LAYER_ECPRI &&
+		    !mlx5_flex_parser_ecpri_exist(dev))
+			if (mlx5_flex_parser_ecpri_alloc(dev)) {
+				rte_flow_error_set(error, EIO,
+						   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+						   NULL,
+						   "failed to create Flex parser "
+						   "profile for ECPRI");
+				goto error;
+			}
 	}
 	for (i = 0; i < nb_action_templates; i++) {
 		const struct rte_flow_actions_template *at = action_templates[i];
@@ -8389,6 +8399,16 @@ const struct rte_flow_item_ipv6 hws_nic_ipv6_mask = {
 	.has_frag_ext = 1,
 };
 
+const struct rte_flow_item_ecpri hws_nic_ecpri_mask = {
+	.hdr = {
+		.common = {
+			.u32 = RTE_BE32(0xffffffff),
+		},
+		.dummy[0] = 0xffffffff,
+	},
+};
+
+
 static int
 flow_hw_validate_item_ptype(const struct rte_flow_item *item,
 			    struct rte_flow_error *error)
@@ -8831,6 +8851,14 @@ flow_hw_pattern_validate(struct rte_eth_dev *dev,
 			 * template and item spec in flow rule.
 			 */
 			break;
+		case RTE_FLOW_ITEM_TYPE_ECPRI:
+			ret = mlx5_flow_validate_item_ecpri(dev, item, *item_flags, last_item,
+							    RTE_ETHER_TYPE_ECPRI,
+							    &hws_nic_ecpri_mask, error);
+			if (ret < 0)
+				return ret;
+			*item_flags |= MLX5_FLOW_LAYER_ECPRI;
+			break;
 		case RTE_FLOW_ITEM_TYPE_IB_BTH:
 		case RTE_FLOW_ITEM_TYPE_VOID:
 		case RTE_FLOW_ITEM_TYPE_END:
@@ -13859,6 +13887,15 @@ flow_hw_create_flow(struct rte_eth_dev *dev, enum mlx5_flow_type type,
 	if (ret)
 		goto error;
 
+	if (item_flags & MLX5_FLOW_LAYER_ECPRI && !mlx5_flex_parser_ecpri_exist(dev))
+		if (mlx5_flex_parser_ecpri_alloc(dev)) {
+			rte_flow_error_set(error, EIO,
+					   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+					   NULL,
+					   "failed to create Flex parser "
+					   "profile for ECPRI");
+			goto error;
+		}
 	ret = flow_hw_register_matcher(dev, attr, items, external, *flow, &matcher, error);
 	if (ret)
 		goto error;
@@ -16341,6 +16378,7 @@ mlx5_flow_hw_ctrl_flow_dmac(struct rte_eth_dev *dev,
 					     addr, 0);
 }
 
+
 int
 mlx5_flow_hw_ctrl_flow_dmac_destroy(struct rte_eth_dev *dev,
 				    const struct rte_ether_addr *addr)
@@ -16422,6 +16460,27 @@ mlx5_flow_hw_ctrl_flow_dmac_vlan_destroy(struct rte_eth_dev *dev,
 	return 0;
 }
 
+struct mlx5_ecpri_parser_profile *
+flow_hw_get_ecpri_parser_profile(void *dr_ctx)
+{
+	uint16_t port_id;
+	bool found = false;
+	struct mlx5_priv *priv;
+
+	MLX5_ETH_FOREACH_DEV(port_id, NULL) {
+		priv = rte_eth_devices[port_id].data->dev_private;
+		if (priv->dr_ctx == dr_ctx) {
+			found = true;
+			break;
+		}
+	}
+	if (found)
+		return &priv->sh->ecpri_parser;
+	rte_errno = ENODEV;
+	return NULL;
+}
+
+
 static __rte_always_inline uint32_t
 mlx5_reformat_domain_to_tbl_type(const struct rte_flow_indir_action_conf *domain)
 {
-- 
2.34.1

