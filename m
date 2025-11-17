Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E44BCE8D6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 08:45:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4812A402D9;
	Mon, 17 Nov 2025 09:45:27 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013015.outbound.protection.outlook.com
 [40.93.201.15]) by mails.dpdk.org (Postfix) with ESMTP id 0471D402A1
 for <dev@dpdk.org>; Mon, 17 Nov 2025 09:45:25 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2rlx8bJ6Ty8qRXX6+B6cLH5gJdNCEPPzrrlPecoMdHhrcqvpLku1cHjHEoZybA+DzF5Pg3tMFi2cm7JPgrJ/dEWLl813nsecIaRnhwBgxyEzYHA/Qvh28mYyGwhvJCTI+sVsHpzK0dRKM3LSCGlwwN3e3lTUluQR/igPSaZdNvDN0b+SK2Lx1vVUJP25TPQ3Q2Yh20k/00i5chOZ+WmQ9GhtiEBobUhNyMPTPocMD4lpcCApwhunC08PQnI9znnZRnLNM14t+wrSGCz93HrvxX78eVPiHwViVtjzoD2qG09msLDU3FEa+eAr3RoxPeNEhplhlfFn5nFmmnHg9WpsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjfpwP81sTnaA7UbSoe2OhZDqthsfy9rd+d1owkr9Sw=;
 b=TZK0MbOkV3Hel1hvERcq5z8sM8xD3mr+GJ21+o2CFkeWNZwyXHPYNTiKkHtuD44BVjZ7OgSMdRLxotqanQx97hC1Zf13tcLO4up4cI6isHvBNbZGvHNg8LcDFSmRGXxtoXGP/u8zIuxPXJcZGOpitLB7l621r0eyiPdnxKgRmp65xzadB9E4UGuv39uQ+K5T0MWpZdFRdSxDpzju2WKj5qX63jf982v1Pidk1pL7FjFdefe+Upjuh42eCUtX6BBY0a+76QYFMbJSgZfsAcfNzbmW5S4MGRUYLqXyHRFzSDYNiuA6mWHrE3PMKrKRTEEgSo7jCs+O5kdiWPa5Is2yYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjfpwP81sTnaA7UbSoe2OhZDqthsfy9rd+d1owkr9Sw=;
 b=rt77OSVfYxBjAmPONaOq4LFCk9FhQSOAw1jnnVdrZY923S+kvz6JdTXfMTdEQA2sW9+kSTMh8LEYiEDt29GzxzRz9bDuzk8B6H4+3jacgFmi/q09O83eWYOL0/O63tsCAmCERuw0tM8V021j/7QO8RhNX4CbL0OTSCHSp9//z8Grdlde/MaMyQD01F29wiDrkwr00XrLsTqhfcaylUfb59bg2VR13/JIPnlp/qb+UyDN+VI7zW1PsfelfxqJaElPTFVFqHJUL/LDqdS2PT6Gx4gmsmPgivfjjahFHwCpHeyq1jIRrD6A+w3aPhqDN7McRjNoUhJc5p9/1V5emd2ZfA==
Received: from MW4PR04CA0275.namprd04.prod.outlook.com (2603:10b6:303:89::10)
 by MW4PR12MB7358.namprd12.prod.outlook.com (2603:10b6:303:22b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 08:45:21 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:303:89:cafe::c5) by MW4PR04CA0275.outlook.office365.com
 (2603:10b6:303:89::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 08:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 08:45:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 00:45:07 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 00:45:02 -0800
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>
CC: <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>
Subject: [PATCH v3] net/mlx5: use private structure for internal tag item
Date: Mon, 17 Nov 2025 10:44:43 +0200
Message-ID: <20251117084443.10264-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117074159.9480-1-bingz@nvidia.com>
References: <20251117074159.9480-1-bingz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|MW4PR12MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: a02014f0-d2dc-46de-fd9f-08de25b5a4a7
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RQljGtdSuZt1079WDxzQJ0FVeomuirAK6+szp9D6Q22Gt25StPe/Lr0i/y2o?=
 =?us-ascii?Q?DPp6lRTamXBsJZ8mstLXuXep7Aw+Fb1FckoCup3kh0yCD/kZxnxFrHElqtI6?=
 =?us-ascii?Q?4rVaWhqzH2VmlqeotTFgzJkZTHAImpLTT6ipqmK0Uueb1OCA/oPNAeNywm/J?=
 =?us-ascii?Q?1Mng8wm8cEjFXU82rcu9f4qRWMnrVi9ivUCo0s71XIyeRVRom2UXF8EfDK4L?=
 =?us-ascii?Q?B3McwumHApCfst8ulhSCURSRW09ro2b+QESnJKTugTF+69uttQbNJKV+u2oG?=
 =?us-ascii?Q?psSWJHrSoC52kE/GmEiF107VQBPB+TiPzy58kSuG3DmlFsS5zg2x2QTRrb1H?=
 =?us-ascii?Q?s5arFniAKJ8C59Sqwlj2Ppox+SeoSjYjkKqDavkoHceg7Bcj8GHEMk3umY9q?=
 =?us-ascii?Q?qy3mFA0r+Xscrv/xmrvOXFvcP77tOQRcfroarcWFSump9UGYIHgEyNSO1c4G?=
 =?us-ascii?Q?AMd4miML2XlwggtkgQk5gdenKow1gpX5c2WDIhbd8wYD1sCMTucapYeVxbGE?=
 =?us-ascii?Q?nw+HgMHIykZQrD25xIDfRVlEy7VMjmozOrzTSGp8pJIonD4Wa4/dHY6SH8YQ?=
 =?us-ascii?Q?wvKVR+9Y3L9PS5JBtj/Z/a/vJYjpbjO+/OAbxa2WCd07jjgUQ6dm8yKk2j5E?=
 =?us-ascii?Q?rwjX+59bIbqvusqzxl0Cj7Uv7VZr9TXYYBRRCVw0snCLu9NpMamWdR8R50zS?=
 =?us-ascii?Q?zy0DyjxY6Mu9bW0S6tzIz9k5GdMtYD+kMyCgN/kItmXTArj/qwFjMcQI1W44?=
 =?us-ascii?Q?DF+i7UvZTqqKnTeXTKizmJgzU5WmFSEAaz/D2tYY3AytzeqQZXL/pNwsK6i4?=
 =?us-ascii?Q?021eaDMtON1XKY0pxM/kI01iwKeVdbf1R4G0AXy8LdAVGKks0vJV4meKyiQQ?=
 =?us-ascii?Q?2hO9gl5+pLBntYeTc93dAtw9XVmdFTn8DHcw35OwbBCtg/5UKwHurT6cIqOE?=
 =?us-ascii?Q?pYZPMQ18VEvEHGK8tVA9aUfTaRJeDqedY5c+7d8MUfRnViFVlXjW7LENoeNG?=
 =?us-ascii?Q?y0tVXBgtKIaxIZQH8HJtg06M+GSOcq0pAHvxuayBjse18BGAm81a6Xwt9XH0?=
 =?us-ascii?Q?RFKlUH7toorQMf0kahgPNQlCMFYTwNgVtAtUA2G5+Ai1s32umlb2Od6t3/75?=
 =?us-ascii?Q?WsqRv7Xr9iRjew0P+nvQSfKyp5HrIHR8e9rWjs+Sp49TrKoLmnKy+8GVhblQ?=
 =?us-ascii?Q?X8e/hpusjcnEqvAHGLJjMdIh2hDin+MMr/3Hb0IaF4C7YBT+inij3JRibsjg?=
 =?us-ascii?Q?rX+3q/kFdVrebHdGs5Wz1hGmuoakLv+IDVks6Vkk0NpJM8Vwg271cT6Jeuk5?=
 =?us-ascii?Q?kplUhI8J9hmbmzo5+Fg5rIiCbL6V96eTqr7nDgSGFloD3VI2yHCEifB9e+YP?=
 =?us-ascii?Q?4YmM2dnJhn2Q4+Ei2Ox0ELtQdR8YfR+pDYc6ju3njxeB3qsg+DK/jtiWHCzy?=
 =?us-ascii?Q?Jz3FbO0rep8/wnOlz8gP5oEcCXjIH+Py845Rgy96Gndu6BWfJOFeNopKSIsG?=
 =?us-ascii?Q?LFZQgHW9ltmtaM8Od+nJfrH/V3vXtm7zWnTwFRv+wj/XuMRdETjFprpi81xg?=
 =?us-ascii?Q?QD/47x7xdVjzf1tuxos=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 08:45:21.3537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a02014f0-d2dc-46de-fd9f-08de25b5a4a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7358
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
v3: some compiler may not consider the structure name as a pointer
address
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
index e0f79932a5..0d8146c149 100644
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
+		rte_memcpy(pp->mlx5_tag_spec, &mlx5_tag, sizeof(struct mlx5_rte_flow_item_tag));
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

