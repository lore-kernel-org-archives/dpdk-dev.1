Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209C9CEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 04:16:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62165410D5;
	Mon, 17 Nov 2025 05:16:13 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
 by mails.dpdk.org (Postfix) with ESMTP id BC983402AA;
 Mon, 17 Nov 2025 05:16:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W93gnmkjwqz5gigMzSpHTBUnOFONCyRHeZTilTfebZQMM0c36ibU8mwbhXT18924PupsUpCydmGkvO8fiTgZLLf1QB/jPem39Q37D8BfW9KvLSa2plIICwgqMIFv8v5d84uEtaGPZbHpsE/DSFFBoDmxMHpGTJmt/+pDZdPH0AX9MD7b+WeHHf/jL+2aM8jQA7XS/cETbkn+wmy/fFd01liBLyPXewpL34Fr3KFhkj8uGnzhXaie71PaVo2ejLpu/wkB4xRH9GKTK3+vkD6GlbrPSKwV5z4nizW/eel2H0kvwf3wxWrc5Rnl9ftfW/om3s5OXLZtymUSHDjYfTRZDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exr99zLU5KU0Iy1EsdbwLzqFk4HWPeyz9KfsOIW+mDo=;
 b=A5cn1Gmc6uieDQr4nGmD85keK9IHnMAHckHwxDWtth4W53sIc5vRc0R5cWBSglF4LNPUKmJwdLE06MXvVvS9jlFFWE8t1ihIe0Bv1weMd/t3sqGItssDjmIm118thT7kb+zKmzXaMUOE8qnX1FhMnv0GMFIiI+Ksxkv4oHo0bUjWyxJTHRZSyYJmRNrLnX5wqnObRLU3wokGbDDBgUpQ/ySFilU8o1Ut0Q+hqUggBNYN/vaExEi9haiGz7/EtT906CilqZTzZ0SIzvtXKJ63vjxFNWMgp1Ys6LtyW9IxhOQu+HrJbO4WnSvBLOQwzYcFaTCJMMW4Yz8oEb3MhGa18g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exr99zLU5KU0Iy1EsdbwLzqFk4HWPeyz9KfsOIW+mDo=;
 b=LWroG+SpyngDK5cmcf5/08R0X7qv+hRSmUA9MWrvFVvs6sQi1yRzMX9tS9P4n/2siQfw1JF9+X7LLMkQg8eiUXRsoIbqJfn9FBgWHTqhCBVVuqc5D0Noa3XilHUP4yf8YhLYALFcujzCGvYqak29kCzVYJ1bucY7lX3I0uRCakJylVCxeys+cEnLNl1qVfb0PpmH08E4FlJNfZEQbk93Ac4Qd7jAEgN3mls11i1Dt+KgX37BW4cirLFVx2VLQJ6nLugxo92xFWlKFLLH8bQYPOtcNFxyVsZpHxqLv3Ybe1QwFWFwm3RE9V4W16FwujNSJXSuBMyalYQJK/AMlkdZeA==
Received: from CYXPR02CA0079.namprd02.prod.outlook.com (2603:10b6:930:ce::27)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 04:16:07 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:ce:cafe::67) by CYXPR02CA0079.outlook.office365.com
 (2603:10b6:930:ce::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Mon,
 17 Nov 2025 04:16:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 04:16:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 20:15:54 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 20:15:52 -0800
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>
CC: <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>, <stable@dpdk.org>
Subject: [PATCH 2/2] net/mlx5: use private structure for internal tag item
Date: Mon, 17 Nov 2025 06:15:37 +0200
Message-ID: <20251117041537.8161-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|SN7PR12MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: eed96ac7-339d-4af6-4d9b-08de259007f7
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0mmnimmnto7Ujj/5/3hoBDT8QP1L6H/7SwLuJ/WO6JkNDIi9k71YRvwbHqBI?=
 =?us-ascii?Q?bmbXOdCHn16z2epdQagUkD8+xc3x7N49ztVkgLN65GS6LS3e98bdZ0hMJ1IJ?=
 =?us-ascii?Q?qH2ntA9jJNgxM5WGJnVEXz3vVAhrBtEJWaT6XVTRbJ8fHdkavgB1jrBjL+H1?=
 =?us-ascii?Q?3tQ2ejdB9lq7oSrHNZT0+mv/PaY7lJdJ7kAhuuABb11/E/d8q/eS3r1TXdCc?=
 =?us-ascii?Q?9Aeny75cFhGX+jYPZnubmyhiYWCRxC9oEFvc/LR0kz+PSfyLEiNBe7Qjfq3B?=
 =?us-ascii?Q?5LnlYC7yZSq1DOkkNmYdOGt83XQ7MtqoqX45ymaZg0oO1LzHAbehUFVmtygn?=
 =?us-ascii?Q?dj45RTntom1MpZ8wnm1RD4lFYnuSfpppL4iKtEtlR6I3YHdkP5nmIwIi/A+o?=
 =?us-ascii?Q?lnakMgZX8/xuUtUpRYAXuMBkstN6qagdFHRtspyvfBhhy/kFkxsJ1pAXIsGl?=
 =?us-ascii?Q?1tp9NMPqwwl4iZf63gktfSSpLpha+hQP/Ooe5Tk0dLfghmKqZrc1GJEWNZQV?=
 =?us-ascii?Q?5e2f0SGrcEPb+mdLYS5Akpx35XYHrzU32Z2p6F7+DtmdWGfnPBv420HgDCMx?=
 =?us-ascii?Q?KYLwrvlQnZY4wBHvfHnSNugJDOmkL30JdDsdKhx42MqdGsjHzdlDKrB7C4p7?=
 =?us-ascii?Q?1K2LmlfslzKmXdy04IL/lFubhO103AEb10caPLHYDLbiwzNV2qcnN/8AjtQO?=
 =?us-ascii?Q?zPZ1l47s2RWwkqXj1Wrhut8ULKdC0ZiskonSieo4oykQT4ll4pcmY5ECSPDj?=
 =?us-ascii?Q?fc1XwaY/4Z6EbX5J73KDH+CMFBOpjXh8SQx8yQqzNijx7ioCeN7eE2oqM+6q?=
 =?us-ascii?Q?UF3f8spwOBc+FDwzlHDE39s4V67Ll5zIeYPUNC3X7D2R6J+Xh8tns20q1Fh2?=
 =?us-ascii?Q?zJNymYNoz6jhHMDTdNRX3whOSaUPzRqcz6cnbV1uWWoxFpg/Ai7WNjJsUS3s?=
 =?us-ascii?Q?ofPrhNlLgATkZFwSnmSgTPJJoIySR0vuXEdYaHjDHhIB2YaDQJLLjVjI95h+?=
 =?us-ascii?Q?3syj66Ae9Nwu3OPWGIA3AGy3B3aMPSpc4HYsXVHIg70mFxThEu8EqNUGXHaZ?=
 =?us-ascii?Q?KtRJT+MgMXba8eF9FA4Nc2wS9u9jopqAmDjExK0lWDAp93u1r3RBpxI5JEI3?=
 =?us-ascii?Q?MHUXpuUKvHfCZuRZ4gbIJmklpC6gvhOuewtSfbZt5TX8BWLWsBENZx5uV9Ei?=
 =?us-ascii?Q?X7SCN35nHP38nNuNH0xhhigEbm4QJ5pzRSiEGySof3p+2frRBhquC4eMFlYo?=
 =?us-ascii?Q?mPGCaZnhVvveneCWQYA4unKcjTqH93kEsLCjvmylY8rDWdCtW+Awf5wZ6K7t?=
 =?us-ascii?Q?S11Di8WI3lXpAygTnZlaMsd+nfW5QkqIS/Jx5SS1FiPrbe3vNkplxRd7H4UM?=
 =?us-ascii?Q?Q248KK4Xut9wuZHEVVi31QeEa0nxMwFp/iLwrVc0QZcfzVTY+HwYepEc90pq?=
 =?us-ascii?Q?vEP6hp8dvA2zrWcsK5EEPqIQSzUaaIA/bU8f6twC4FxguCMyol8rrHYbDc/8?=
 =?us-ascii?Q?FLjP/oMc9Dgj85+o3FZMuRgpOBES58fTaUKljqVrY2lXdIrKby3ydYOv2dF7?=
 =?us-ascii?Q?QC3Nv/EMj9i1LpTpl7o=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 04:16:07.1307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eed96ac7-339d-4af6-4d9b-08de259007f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129
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
Cc: stable@dpdk.org

Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5.h         |  4 ++--
 drivers/net/mlx5/mlx5_flow_hw.c | 41 ++++++++++++++++-----------------
 2 files changed, 22 insertions(+), 23 deletions(-)

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
index e0f79932a5..f5ad48c6d2 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -3855,7 +3855,7 @@ flow_hw_get_rule_items(struct rte_eth_dev *dev,
 			return NULL;
 		}
 		/* Set up represented port item in pattern params. */
-		pp->port_spec = (struct rte_flow_item_ethdev){
+		pp->port_spec = (struct rte_flow_item_ethdev) {
 			.port_id = dev->data->port_id,
 		};
 		pp->items[0] = (struct rte_flow_item){
@@ -3870,12 +3870,13 @@ flow_hw_get_rule_items(struct rte_eth_dev *dev,
 			return NULL;
 		}
 		/* Set up tag item in pattern params. */
-		pp->tag_spec = (struct rte_flow_item_tag){
+		pp->mlx5_tag_spec = (struct mlx5_rte_flow_item_tag) {
+			.id = REG_C_0, /* vport_meta_tag is using C_0 */
 			.data = flow_hw_tx_tag_regc_value(dev),
 		};
-		pp->items[0] = (struct rte_flow_item){
+		pp->items[0] = (struct rte_flow_item) {
 			.type = (enum rte_flow_item_type)MLX5_RTE_FLOW_ITEM_TYPE_TAG,
-			.spec = &pp->tag_spec,
+			.spec = &pp->mlx5_tag_spec,
 		};
 		rte_memcpy(&pp->items[1], items, sizeof(*items) * pt->orig_item_nb);
 		return pp->items;
@@ -8559,21 +8560,21 @@ __flow_hw_pattern_validate(struct rte_eth_dev *dev,
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
@@ -9028,13 +9029,13 @@ flow_hw_pattern_template_create(struct rte_eth_dev *dev,
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
@@ -10119,11 +10120,11 @@ flow_hw_create_ctrl_regc_sq_pattern_template(struct rte_eth_dev *dev,
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
@@ -10131,14 +10132,12 @@ flow_hw_create_ctrl_regc_sq_pattern_template(struct rte_eth_dev *dev,
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

