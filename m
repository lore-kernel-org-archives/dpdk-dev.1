Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AC2CEACC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 20:18:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38D7A410F1;
	Fri, 14 Nov 2025 21:18:03 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012053.outbound.protection.outlook.com [52.101.53.53])
 by mails.dpdk.org (Postfix) with ESMTP id 6D05940E34;
 Fri, 14 Nov 2025 21:18:02 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjoIRYnzTl8+ydyKqK3Qe/YJATs3Dc3k6yLu2vbPtWxl7ZFXedD+NR9yutdqTTa5I+r+3k56Wiaw+qgHJMhDQ5tYPzWUXZqmPtbz6UH7uBeVxyoPClAigsN3nf+hq1j3eWulemIQzo1yq8tZHXhfb8IwhYcykb4iTqevrJkxDNCrwjj5FfU+EuYGH4wbno6NMB+DFg0uWTtTso8DNRPgU/h+Z0RX5OMxSdZu4hVCv2PueL9pyjyPy5naJlvbmz1ktMY1TjOS1yBn+kbHGdnlSqAw6BHG0gH/N0fYBYQTG80GY2O/IArxKNUQ0m/qhDrVIrjcVkLD4DOI5G1YyQuFsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vov5T7XDZwwO86ohJgOGDaEnETgEBKWAt14IsYbiP94=;
 b=b+z71upilbXNp2jm90g50LT+EoRtys96hYS8/IaMVNreCVC7FVFzlK0uVN9bqNrmNYggpggI+X7E+tpG1lAEvAz1hUor1odPrTJX38VSKDiYMdRElZDkpJoL0c04SL1ZfOc0eW7nxYWc3O64J30hmCCL4BmcDOsUsVuYNAdKnAtv2KeOT8lFHP/BA9GB1cY2YA3dZRKpj/FnEzo4PVv3FD/d8tTVhO2Tu0zBzpqbtUNA/DBD5vWzVtS7N/IbE/sGFNoR55a5wJ3EK18lnlYMXGOXZqwtmYiRHD60dvLxXdh62xJw4th8Qa7o6Y0LRsfnUwUXAM4AM/3dJna14H4IbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vov5T7XDZwwO86ohJgOGDaEnETgEBKWAt14IsYbiP94=;
 b=tx4FELi2gjT1xMWit+3fyrRMQJfosulFerH8T3kfU+1yH/P9cPg21zkt4wXcRT7kMr71poLA1KXatloRle/vwOEy6gUWC0V9yfmHxhoWsjzMVR88IS86BcYBgEobPXsIBHsGiCjzgEbag7zUrF+GO71QuzrsjJ+PhQ+eRwymElVMZ6amRUN6cZ2X5breocRkoUgYPlDfK3s9EFdli82snGvEIMgAos3QlBu9DQkfp+pdA4URhr0np/fqGlRht949GX4wBK5gsn8UPfj993xnxM73PInylSqlbzHiUSEcDj5Gv+r0TSUIMobjm7eXmAUW9QIVLFbDE+6G0/WxIXuebQ==
Received: from SA1P222CA0081.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::7)
 by IA0PR12MB7530.namprd12.prod.outlook.com (2603:10b6:208:440::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 20:17:59 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:35e:cafe::7c) by SA1P222CA0081.outlook.office365.com
 (2603:10b6:806:35e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 20:17:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 20:17:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 12:17:44 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 12:17:41 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Itamar Gozlan
 <igozlan@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix higher flow tag indexes support on root
Date: Fri, 14 Nov 2025 21:17:20 +0100
Message-ID: <20251114201720.1639238-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|IA0PR12MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: f28d7a92-ff07-4fd4-cdd3-08de23bae7be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wynq1iJz397QUsXIR5uIyOnkV8Gmx2/Px3F+pvyMYS2/OLWqmIoHaUUtPHsy?=
 =?us-ascii?Q?+5qFcf8UKNVelbOX2E/zAN14ChL07IQrlifdewP8aI+l5avMWncgyIooljet?=
 =?us-ascii?Q?Sd/55JfxO8aZTzeEFLVtlhmmkqg++8roMuNzmgTUW3KEzNRXU6XZouMeyH4l?=
 =?us-ascii?Q?dTZ3dPupJmMBdLxY/DHonnbgW6bHrbWQef+hsxkDRAZJtX20yjexhppsNvkB?=
 =?us-ascii?Q?/CRR5nS+DhWuNhard+23qFOwSRCMgrRhS4bcZKxxWgi60okmxYGJuhjb9Wmn?=
 =?us-ascii?Q?OiBUT+8bgvFxziHPt+kHTfWrGWGciPr/vDZ3pnU1zuBXtCitBSp+sW0gl9dM?=
 =?us-ascii?Q?q6jsuGQyWYt633am03yinTIZ4qRXBl7RHCcnB6Ulsqx6Pa/4wjFlgaVXWX8C?=
 =?us-ascii?Q?mArUBEPhepQ//TQ+aEQZpdGO1nKWu02LE7fQJ2mO54l7CSTS40aMiFdFmcwP?=
 =?us-ascii?Q?twEupjRKeJp5ETTPKt/TXrfYNoY9erfEoWQun50cjSkrO4MOqj7TCpzoDUEg?=
 =?us-ascii?Q?+7g9r0+tie1sWBCFJOTB4MWiZzSDKkJBoqMayr+e9sgrBaHfo1J1nHoH9Czx?=
 =?us-ascii?Q?vCJf8zC5bz28CHuht5zIUfO+SpJByZRK96Lqw4MBaKBPpIcs64dUDYIowgv+?=
 =?us-ascii?Q?UWAY8zRxQWu/LFdnZpAlAnCN6gFU7N269l7zNliJCzqSR8lLbfNoiQDL3sVe?=
 =?us-ascii?Q?CJOvOh7dASujg/vZm0QiYEvqGkkYW4E2OL0dRjEE5M0xOQ8GqrVa9S5d+O4F?=
 =?us-ascii?Q?usF3j30d4gJfy4x4p+4L8izL838FGMJrqBnIx+DAxxe67Sj9O1KHuMSvGjOq?=
 =?us-ascii?Q?vVlcYSMO3rTDfNiqAhmt1ALQgTwWjqp+uaBI9GPHvnPofAa6ThjMNVpTZUcn?=
 =?us-ascii?Q?x2Bp6tm3tFRzOZ/5i4NUXBhT0Yjwyi/uE3ee4ZRlZWsQEehIFV4rMfJui9hP?=
 =?us-ascii?Q?8y5WN+l/joyNWk87Zolv7FI/iqUAXO6J+zObkoNAZ5ChK34ugWRZFpEGOKXc?=
 =?us-ascii?Q?ThlvJiPBp0O1P6kxPNASY1ntCE2fwIhFQ/QteEERNADTpDs7yUsvv8/OhcwB?=
 =?us-ascii?Q?Zpk425QbXC0hEkmhJdMatitJnkwxEQQ/fMaztlZ9Dn8OFnOK/DcZwk3xNYuz?=
 =?us-ascii?Q?zldllpiWVEGJrNK+k4AU3x577kvlDYKG4qSvUWOw0b65Cw36xU5XXP7qRAFG?=
 =?us-ascii?Q?R0LJ8Q635eOaSDRXYglU+wBhbKOoKzWYHi6MvzxfEx6m3RiBqPFEFF6LuoKu?=
 =?us-ascii?Q?A24Vh8RjDaXe6Cvq1NUn4M11bORNnvkB3pLzTtm6hZ89vIKBrE0YS9fLAYCj?=
 =?us-ascii?Q?TPMebejH+VEE9t4lP62930VwhfHrZvA7SRbXOnzENXuJKTIyZfXp7pdXkN6c?=
 =?us-ascii?Q?vlxvV1mPCbeGndgDezJ3LODHCLvc5fcAzIN1FpJSelZhzAEV/1kQHbALd7WG?=
 =?us-ascii?Q?YR12RV7zQRSnxLLfivGmia/KyzF7S4pHYIHU1y6bnYN9eKWDQs8CyVGz3PAo?=
 =?us-ascii?Q?a/8yKXofeM2cgy1GnQq8UgfxZKJlX86Domq/daqqyBmadmalQmwZ/wqLt4F7?=
 =?us-ascii?Q?afMb9tUdBxkS3ReRQoA=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 20:17:59.0711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f28d7a92-ff07-4fd4-cdd3-08de23bae7be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7530
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

Offending patch introduced support for additional flow tag indexes
with HW Steering flow engine. New tag indexes will be mapped
to HW registers REG_C_8 to REG_C_11, depending on HW capabilities.

That patch only handled tables created on group > 0 (non-root table),
where mlx5 PMD directly configures the HW.
Tables and flow rules on group 0 (root table) are handled through
kernel driver, and new registers were not addressed for that case.

Because of that, usage of unsupported tag index in group 0
triggered an assertion in flow_dv_match_meta_reg().

This patch adds necessary definitions for REG_C_8 to REG_C_11 to make
these registers usable for flow tag indexes in root table.
Validation of flow tag to HW register translation is also amended
to report invalid cases to the user, instead of relying on assertions.

Fixes: 7e3a14423c1a ("net/mlx5/hws: support 4 additional C registers")
Cc: igozlan@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/common/mlx5/mlx5_prm.h  |  6 ++++-
 drivers/net/mlx5/mlx5_flow.h    |  3 ++-
 drivers/net/mlx5/mlx5_flow_dv.c | 40 ++++++++++++++++++++++++++++-----
 3 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_prm.h b/drivers/common/mlx5/mlx5_prm.h
index 5db8d67cfc..ad3cca5bd6 100644
--- a/drivers/common/mlx5/mlx5_prm.h
+++ b/drivers/common/mlx5/mlx5_prm.h
@@ -1205,7 +1205,11 @@ struct mlx5_ifc_fte_match_set_misc5_bits {
 	u8 tunnel_header_1[0x20];
 	u8 tunnel_header_2[0x20];
 	u8 tunnel_header_3[0x20];
-	u8 reserved[0x100];
+	u8 reserved[0x80];
+	u8 metadata_reg_c_8[0x20];
+	u8 metadata_reg_c_9[0x20];
+	u8 metadata_reg_c_10[0x20];
+	u8 metadata_reg_c_11[0x20];
 };
 
 /* Flow matcher. */
diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index e8b298dd1d..fa2af91d66 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -1833,7 +1833,8 @@ flow_hw_get_reg_id_by_domain(struct rte_eth_dev *dev,
 	case RTE_FLOW_ITEM_TYPE_TAG:
 		if (id == RTE_PMD_MLX5_LINEAR_HASH_TAG_INDEX)
 			return REG_C_3;
-		MLX5_ASSERT(id < MLX5_FLOW_HW_TAGS_MAX);
+		if (id >= MLX5_FLOW_HW_TAGS_MAX)
+			return REG_NON;
 		return reg->hw_avl_tags[id];
 	default:
 		return REG_NON;
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 95ca57e8c4..2a8bdd498e 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -10560,8 +10560,8 @@ static void
 flow_dv_match_meta_reg(void *key, enum modify_reg reg_type,
 		       uint32_t data, uint32_t mask)
 {
-	void *misc2_v =
-		MLX5_ADDR_OF(fte_match_param, key, misc_parameters_2);
+	void *misc2_v = MLX5_ADDR_OF(fte_match_param, key, misc_parameters_2);
+	void *misc5_v = MLX5_ADDR_OF(fte_match_param, key, misc_parameters_5);
 	uint32_t temp;
 
 	if (!key)
@@ -10607,6 +10607,18 @@ flow_dv_match_meta_reg(void *key, enum modify_reg reg_type,
 	case REG_C_7:
 		MLX5_SET(fte_match_set_misc2, misc2_v, metadata_reg_c_7, data);
 		break;
+	case REG_C_8:
+		MLX5_SET(fte_match_set_misc5, misc5_v, metadata_reg_c_8, data);
+		break;
+	case REG_C_9:
+		MLX5_SET(fte_match_set_misc5, misc5_v, metadata_reg_c_9, data);
+		break;
+	case REG_C_10:
+		MLX5_SET(fte_match_set_misc5, misc5_v, metadata_reg_c_10, data);
+		break;
+	case REG_C_11:
+		MLX5_SET(fte_match_set_misc5, misc5_v, metadata_reg_c_11, data);
+		break;
 	default:
 		MLX5_ASSERT(false);
 		break;
@@ -10825,8 +10837,11 @@ flow_dv_translate_mlx5_item_tag(struct rte_eth_dev *dev, void *key,
  *   Flow pattern to translate.
  * @param[in] key_type
  *   Set flow matcher mask or value.
+ *
+ * @return
+ *   0 on success. Negative errno value otherwise.
  */
-static void
+static int
 flow_dv_translate_item_tag(struct rte_eth_dev *dev, void *key,
 			   const struct rte_flow_item *item,
 			   uint32_t key_type)
@@ -10838,7 +10853,7 @@ flow_dv_translate_item_tag(struct rte_eth_dev *dev, void *key,
 	uint32_t index;
 
 	if (MLX5_ITEM_VALID(item, key_type))
-		return;
+		return 0;
 	MLX5_ITEM_UPDATE(item, key_type, tag_v, tag_m,
 		&rte_flow_item_tag_mask);
 	/* When set mask, the index should be from spec. */
@@ -10848,8 +10863,18 @@ flow_dv_translate_item_tag(struct rte_eth_dev *dev, void *key,
 		reg = mlx5_flow_get_reg_id(dev, MLX5_APP_TAG, index, NULL);
 	else
 		reg = flow_hw_get_reg_id(dev, RTE_FLOW_ITEM_TYPE_TAG, index);
-	MLX5_ASSERT(reg > 0);
+	if (reg < 0) {
+		DRV_LOG(ERR, "port %u tag index %u does not map to correct register",
+			dev->data->port_id, index);
+		return -EINVAL;
+	}
+	if (reg == REG_NON) {
+		DRV_LOG(ERR, "port %u tag index %u maps to unsupported register",
+			dev->data->port_id, index);
+		return -ENOTSUP;
+	}
 	flow_dv_match_meta_reg(key, (enum modify_reg)reg, tag_v->data, tag_m->data);
+	return 0;
 }
 
 /**
@@ -14408,7 +14433,10 @@ flow_dv_translate_items(struct rte_eth_dev *dev,
 		last_item = MLX5_FLOW_LAYER_ICMP6;
 		break;
 	case RTE_FLOW_ITEM_TYPE_TAG:
-		flow_dv_translate_item_tag(dev, key, items, key_type);
+		ret = flow_dv_translate_item_tag(dev, key, items, key_type);
+		if (ret < 0)
+			return rte_flow_error_set(error, -ret, RTE_FLOW_ERROR_TYPE_ITEM, NULL,
+						  "invalid flow tag item");
 		last_item = MLX5_FLOW_ITEM_TAG;
 		break;
 	case MLX5_RTE_FLOW_ITEM_TYPE_TAG:
-- 
2.39.5

