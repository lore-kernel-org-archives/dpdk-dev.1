Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9318AC021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 06:51:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9616B402DB;
	Wed, 26 Feb 2025 07:51:06 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
 by mails.dpdk.org (Postfix) with ESMTP id 6EEBC402D8
 for <dev@dpdk.org>; Wed, 26 Feb 2025 07:51:05 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGc8u8WgnbkUATyuMIxO6+W0Cy1pqXJXW7aQew7uBeAdDX/6COjbI+Erpx5rLLPVmE9Zq2xceAkz5diN+qAN3ZqfITBh7gDAcHaKw43TkSulyhxCkxQNrV/Ys8egbjn5Nn/W9zMSLylZAcW1oADiLX0dASC5Oe4Z7WZpZ8vTTyQSImB2qWEWlsdMPvxGVjCMXlChlbon/T1MwTbGtz7lW4tfhAxaceOv0x06VvZ5QRG/ptMxLrOUqj+Hs+H7xdU4SMPc8GFBYxYoQG1hRMvOIB9UizelhZeSJLnQH0steaEQynqLdQH/59kUlh49b8kWGDjjZI58pADvn9qshmGW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvTV/BApsZgF0NMQIpnIc4K59u/LHDlLg5eN/whzwy0=;
 b=TZx62H/aklyCMpNG6Ab3CK4302HOKu+WB72r/hCnG/w7KIjsZJMMuThzA9VBlpefpwC3fdiysZ5Yx7DxsL11EgHF8Nu/HPM6CiBiseAy9O4Zw0qrHS3CdYMlxy+SMadV0viWjiahGFyx/h7DFWMTWXQ6Pen45RZhfjVjT4CVSQksLDNV+8WRG1u71lGHnyk2h/TRElbHUKGQtxql9dlSS2m1eW8A0YZPq3PIwUjgP/nZkehlGjABeXIAZRMBbrbf5Nk0UJS2Qu41n7ll6Sxuv19OnxQVD9ogyr7mWmXlRg9+oK9ms76XNiMpt2kt+/sx0e0Q0M/79hhljX1UJBt2SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvTV/BApsZgF0NMQIpnIc4K59u/LHDlLg5eN/whzwy0=;
 b=eGToQjBdfdwsRY4G+olE93+t4z1GW5weJxhesLplWqVd31P7QNkYK1d6Fns+2GCve+CZsygb8Lueg/fH/KsnqqVt/s9vS2phYh+ZMw+RTU76Z8cS9ufV8SGdqdGdO7xGoCDS3uYFivt3I+DRvIxeBP1BFnDXjgy+pKWpH+VwEQfvXuaKdR8rTXl3WChczO3AghN9iN/2LHuJofDdnzl6nknP1OneUv1c4iTHtXkG8+lVA8YJJDm5R30vPDEUckrkIGq/RnaS0S5Z4e1z7tWyORVO99LT09CyYWago03+j4+6vmRklqHXA5noSqQviz78Whxi9g3yO+Ck27jT/KAmHQ==
Received: from BN0PR03CA0031.namprd03.prod.outlook.com (2603:10b6:408:e7::6)
 by CH3PR12MB8512.namprd12.prod.outlook.com (2603:10b6:610:158::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 06:50:58 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:e7:cafe::9b) by BN0PR03CA0031.outlook.office365.com
 (2603:10b6:408:e7::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 06:50:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.0 via Frontend Transport; Wed, 26 Feb 2025 06:50:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 22:50:40 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 22:50:37 -0800
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>
CC: <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <hamdani@nvidia.com>
Subject: [PATCH v2] net/mlx5: add eCPRI support
Date: Wed, 26 Feb 2025 08:50:23 +0200
Message-ID: <20250226065023.12560-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225160304.9865-1-bingz@nvidia.com>
References: <20250225160304.9865-1-bingz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|CH3PR12MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a5a40a-70b9-4c3b-bd68-08dd5631ec7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NX6kSRuYtZ94J84ppoplCW3xNOx9eieJPTnCM74lJ+ilZyj4osIp9KBWx+ll?=
 =?us-ascii?Q?B6hyHNSsBaNMbqeyULv7s3BlFXCkjkq4TYhc3wg+SVX0Y/ksHjldE6g3bf7n?=
 =?us-ascii?Q?ezFVP3RZc8kalgdsyrJo9/gK9X46XpJH29K9MUF5Rb4dm5W20yKISob5QfbQ?=
 =?us-ascii?Q?kjBVDYvy20wajpFTpQN9TBXihPlHnJkZ4YlfwtZL5alHcwGYx3+dvzou9zMu?=
 =?us-ascii?Q?+v7E2wawxAzWmhfKMzy2/DfDHCmKrhBDOFEYdqneUcB6tPNEgF5OAN8BOOiz?=
 =?us-ascii?Q?fY5rhbxGkM3SP300Joa6YIx2QmTbs3YKpzqyT2GCCYYFesvy8f6eSlzqQMnN?=
 =?us-ascii?Q?gXuNj7k8m9V69SiHPgW/pBaLxTFLKLeak4VcEBtjAl010tyalGK3RgUavGZQ?=
 =?us-ascii?Q?uxMqoGVf9wN+tHuqS6kPnVevGf3M8qDT0DhAAghu9vmQxoIp6fX0lAI2WCws?=
 =?us-ascii?Q?DbQlP6GJhCFEicLQNnn7CTMoUD8/BneywoueWF8BYk3YC9J7nvfM7eveXsVY?=
 =?us-ascii?Q?ZCkxnUqtXFmZaHnfCrRRHAc/IqijYL1L/w4tEqBEMO8oBzFUZ46FjMDhOY9e?=
 =?us-ascii?Q?sHWDBFyLtfFyckFAQYKIOtQI+mufjIhiHZgRTAB+A9NSL5w7LWnqvFLpi8z+?=
 =?us-ascii?Q?VBMKRyaLB2fT3h5VM7vnjHUylGnLpPaTfF746HFpoqK7auFlPgc608bkjt4C?=
 =?us-ascii?Q?z6K8P66M+2E3LYPglELZaB5TC+GLDqDeFQadeaHv5vEGiA/IrgzeyGqv5YBc?=
 =?us-ascii?Q?4xSTkNNTeQKo3519mo/dF3lCXiI1rVXvJk4TuJjHZOxB/jq/lqUb99v+pkgh?=
 =?us-ascii?Q?CvZpNPk8I6Vljb2fdfLVRNOy1ULx1mgxmPeiNHGQ31msdd+CEjgTEidSKsjH?=
 =?us-ascii?Q?YIzu3kRihgha9XchNZoCiP67eaEKB5gU1SadrFDlvgJEZysUGZ5r82zOo2rs?=
 =?us-ascii?Q?IUZI9xMtKh4mWClOpZ6l8k+hYoxK/V9/rBVWJnsvM+Wb7w+1zIBR+Qs3Sl3L?=
 =?us-ascii?Q?XsnJSNNSRlIglBFmea08LdfVRnpOLWe+It3VYEqX7zOCKqjSAUqXSLI7cglR?=
 =?us-ascii?Q?SduXCC/IniCCC6cKf/GqCXvl017dDpPaGdgPr1V6gCqTKP7GKNM4FKx+W352?=
 =?us-ascii?Q?RCZ53bjMtqIkt1f+KIk5NU0Dc+V2IhhfdtdYOrtry/bbdqZaV+Og9aGQMp5/?=
 =?us-ascii?Q?knEhVWqNC20gGUcsafe7tVz+nRjhaJ002ARdA5khbHv7MQJIhHD7FiFbgkZn?=
 =?us-ascii?Q?u8fwUdIkqGSSIHu9F0HW+HgdvW9B8wGWA7gVXxyFOFHDyvoQoVE1yQS/HOIv?=
 =?us-ascii?Q?Zp4wQYYtPwZ0ZnaWG3Q89xz/1iMPp6apeS8mFbYp8kCCrziQ0FsKo++rlc5t?=
 =?us-ascii?Q?7PlMguEKOf2XEck+Wmm0Sns0jUdPOcQtJ1Psbmk6wkbDJAU5IHePXNzDb90O?=
 =?us-ascii?Q?ESIPR4ICY5c+dN35W84oaRO+YLEWYpgysDapR3BPwH+atvsIu+wyZqZ3UHDr?=
 =?us-ascii?Q?+iXiwcJ9chVVgBA=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 06:50:57.5627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a5a40a-70b9-4c3b-bd68-08dd5631ec7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8512
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
---
 drivers/net/mlx5/hws/mlx5dr_definer.c | 86 +++++++++++++++++++++++++++
 drivers/net/mlx5/mlx5_flow.h          |  3 +
 drivers/net/mlx5/mlx5_flow_hw.c       | 60 +++++++++++++++++++
 3 files changed, 149 insertions(+)

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
index e72b87d70f..708a817f0d 100644
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
@@ -16422,6 +16460,28 @@ mlx5_flow_hw_ctrl_flow_dmac_vlan_destroy(struct rte_eth_dev *dev,
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
+	if (found) {
+		return &priv->sh->ecpri_parser;
+	}
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

