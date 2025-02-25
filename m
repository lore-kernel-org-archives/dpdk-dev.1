Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54DCC021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 16:03:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 982EA40299;
	Tue, 25 Feb 2025 17:03:53 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by mails.dpdk.org (Postfix) with ESMTP id ADBE54025E
 for <dev@dpdk.org>; Tue, 25 Feb 2025 17:03:51 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUiKt+pN4HKIXrv2LVYOGTtAC+nix8hMsy784meTPDojxBAghNwbGL+vTmWccdng7lhKFuhd4lMi4wkon+YCMgeJ15JMbrjde+62uC8xk1Xxex4CH56VYQ5f2LyDJq2LhUgCs9msCuth7hlaJnHHnCCx3qYl8PycjBEyfJNBTH0jorAY22x3doOdNvn9JjOS18N99Yf/dYWqTB2T3xUHvOd6X16hQXUrTY9obWPkCfm5UgeWf972xxMNgD51C6f7T71t8LZyRDlaTrAU685KnttQtPF/l1/pRcpA+2IFdS3Xgcy4rq5zzh1SFkGsII9nfT3yFvndazUvtsi/F9AIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDyhunz+ckZ9RTNux0rK3RKIN03j6jPQB3sDY3/R0wQ=;
 b=xXqQ9lhIpIZ2AzHYoAulRzQ9JWh04TNnR03B/Zd0/WEjeQLQcx6pKRSKfEhMgzkS86k+yYzK4f+ccYy6DW/5v+VljTriyl0l/jJB7mkzP3b7SdPmD7BXkDY6iDwPxOAxdqnch7k3jtoF13WcqbYxMIjtzecwQwmxjis9z2oh6Ayipi9HzuFxBTlaIGudEnueQB4Ve6sFVvL9bI+0LB16p9W9y+rTlbkhnTTrzmwQuIlFRy9Ql7kAuZa2j8zWcS75sEnGgAzRdctBkoccRByLKO20FRGL+abMhECQ5mK/ChIJfJAgY6gCAI4Y9Bzq1SAzgEVSiMEm4dWRY3lZzKNq6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDyhunz+ckZ9RTNux0rK3RKIN03j6jPQB3sDY3/R0wQ=;
 b=o5/a6mycsxgCr1SiHWIqTwIg9rRqoWOeUFIpu/O2PHRccsWjwqOvFW/vD99FLHWz5N6dbrTdsfVQKNg1zPJO9C6972Ni0SQBUy902yUqX55AmhmRdPMliZaAtkJLWzbA05yK4LHpcmbcACsqoV3Ad0oH2yr7jl1CAMyXg9CcrU22nVoJMYrPQXI4Pwk/Wk4JeUmC6cIET5HFJDvyowtzQY1nppBcmKF3jyhl1/JCoKEc2D5P22XIB7KMbtwg9n/tlKEGL2rukqIsEn5yj76yHagLEUCtBrnmW5+LUmPOwXKx4qYDZ3urQElsPfP2YsTzVXBCa7muAFl/Bno/oxtTrA==
Received: from MN2PR10CA0028.namprd10.prod.outlook.com (2603:10b6:208:120::41)
 by DS0PR12MB7654.namprd12.prod.outlook.com (2603:10b6:8:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 16:03:49 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::e3) by MN2PR10CA0028.outlook.office365.com
 (2603:10b6:208:120::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Tue,
 25 Feb 2025 16:03:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 16:03:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 08:03:20 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 08:03:18 -0800
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>
CC: <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <hamdani@nvidia.com>
Subject: [PATCH] net/mlx5: add eCPRI support
Date: Tue, 25 Feb 2025 18:03:04 +0200
Message-ID: <20250225160304.9865-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|DS0PR12MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c274957-21f8-4942-b832-08dd55b5fd40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3arjMhOsqFayoRYTsryUjoX4PzaUPlfs1E2BAPPbhMt4+z9R0PqpEj4TatLc?=
 =?us-ascii?Q?34fJ/tk7iFg8J37bOs4fTAthX/6EbqsimJGZeYrYin7hla2fmq0yKNzYOmUn?=
 =?us-ascii?Q?2PbsJZ7Ox7shRP1ybVnTJh5NLBZ1nhLCPUGQsfdTSmvXjX5YPtP6rghJbE7h?=
 =?us-ascii?Q?EQQD2KqeEStYGxxrPWTeOOXPVyS5dkbpYc5WhxKRFhV+6BUzvuCQdbvFapIk?=
 =?us-ascii?Q?9A98mU4alGCLR5R9IGsirRTfxmONb8ZZkefHETTbH+U6zZ6eoPR0fTmXGSXx?=
 =?us-ascii?Q?mP9vzlnNnIC9xVduHf2JlBQgyGv33GMZFpdqL8qphaAYcERwHgnHdKI+ic1I?=
 =?us-ascii?Q?dlr7JhxaYsfPqZB4it/C4cvA7vepr4tVwGeHVrLVX7NfKk2BmOGYAT94SCVP?=
 =?us-ascii?Q?eA2NK62esS78JF2Eal3xOzYAbO+jQ8PAPgrUpt1hhxksrl8ImEKxE8baAFcm?=
 =?us-ascii?Q?5bTBWKDvyzDUTRE9k0GX0dIxvpiAVvj6FXmjOYwKNsjCoaksRqJv95mD8F9X?=
 =?us-ascii?Q?jevWSxjDhsRPQjmBfzdOFdUb9PDICH6t3Yy02o9jOTcA/tubjE5C8o6dTmCA?=
 =?us-ascii?Q?StWPhhHwa5/fUwEi3wOJibPZyhEdhUiZoprDo3YHJqkYnY+nF1yjpaQKmTyN?=
 =?us-ascii?Q?YOsVq88/+0z2MdqwaAiPM/eyb2tlBNXfa3OZbxdEr53QhLl7cGpuQ5CuvEH9?=
 =?us-ascii?Q?/nGZ7pS7KO2ay2qGh+LSp8EaJnWKTYrFClyi6lsm2gnGBum4CvT9x8o1tE04?=
 =?us-ascii?Q?lwEWJ/2FQIPMjTln8E0qu5QCMfMflcGNr89c5aSlNGBAJV8YxT48t/9cglWJ?=
 =?us-ascii?Q?15vikTT6GM3j079BQJibcDjb1KDROUBp2cuOGRDyUQwDzHrh3943PIY2gRTB?=
 =?us-ascii?Q?FcXgVdkn0iEWcDlNRNBbH1MElb+XsOv3NLiLPgy5Fvsia3F8qoKu36bgqwpx?=
 =?us-ascii?Q?FuuVwt9VS92r1iVNlOK5ZKCpDg/CkTokAvElTgFSgJBY6e6Ng0sW1/jWLDoR?=
 =?us-ascii?Q?rmDuyfOmfof8JOmIBXKbIZ2hPG0Sn5m9ATLnguGR2EphCEKU2aVYDRUhatjc?=
 =?us-ascii?Q?ZCchCNxqm8Wk1K90hGqz9jMx2xn6wXSHdq0J0zNzoktN4RlQRKjWmlAvmWFo?=
 =?us-ascii?Q?+9Co1hv5894763p+u1HIELf5SW6jgp0I9ZSAaE41phgCt7P4eYzG4Ga+t3Iz?=
 =?us-ascii?Q?L4g3yDrkrLr3QJnDpnQNXZLDybVpnTJ2ADJ8b41OMzdF6DbHL1gVuro3rGaz?=
 =?us-ascii?Q?jTSO/5CIkaT7mMf+sCsCQzTdXj/RvWXRwyvHkO8y+Hv/x1l2N0ibVCWqpi/I?=
 =?us-ascii?Q?lrkRWG/P+cwBXRquPRsDULzGE1xTuCI4u9vcCS8CokNp2YBnq6JiJzq817ZU?=
 =?us-ascii?Q?85Ie1O2rat96CxJ51ojxzr7HfMT4DxqkE70UDHScC29tnwMYIodtmLpAPVUV?=
 =?us-ascii?Q?NkujZuawgGvpGZw5l8xGTALMs3mEpKpkQHNQRHg9VayukzTJSgG7WSjv9dgs?=
 =?us-ascii?Q?Ii1oBBildQKoDsM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 16:03:48.0609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c274957-21f8-4942-b832-08dd55b5fd40
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7654
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
---
 drivers/net/mlx5/hws/mlx5dr_definer.c | 86 +++++++++++++++++++++++++++
 drivers/net/mlx5/mlx5_flow.h          |  3 +
 drivers/net/mlx5/mlx5_flow_hw.c       | 61 +++++++++++++++++++
 3 files changed, 150 insertions(+)

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
index e72b87d70f..fd9c7c8491 100644
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
@@ -16422,6 +16460,29 @@ mlx5_flow_hw_ctrl_flow_dmac_vlan_destroy(struct rte_eth_dev *dev,
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
+	} else {
+		rte_errno = ENODEV;
+		return NULL;
+	}
+}
+
+
 static __rte_always_inline uint32_t
 mlx5_reformat_domain_to_tbl_type(const struct rte_flow_indir_action_conf *domain)
 {
-- 
2.34.1

