Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2DAD2505D
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 09:25:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14D0E40A80;
	Mon, 12 Jan 2026 10:25:10 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010005.outbound.protection.outlook.com
 [52.101.193.5]) by mails.dpdk.org (Postfix) with ESMTP id 894C24013F;
 Mon, 12 Jan 2026 10:25:08 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgDidXkv/JLEIQSiHAiVoJGB5OdM70gPqmmJRKWig6bPUE20cLgp9C0S+TkrZxeH4NTRqd6OT7Z8dFpMOFqCTXy5SW2cDubwmvLfVpBU94vEqCZ1YPHzCA1WdumqegeoWgwbEh013eSrsCSisJi+APUCj2FcMQX1NvYkkgoJI9C/x1JUt6FnPRnuUc7VMm5y/KxupDa3AcSN7DaycGbrYt+8+N/qvRkcOjKHnhI1f1eZWpRhNBkDSnUKGyGVrilV7H60uJWs9RktykX7w/jHKBWMKQsWsj/aoQLM1cP3YcJf9SZm/X9XbsRuPkuXP8sKSxlsx1eIte/v/dx8IKvc3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xh29QuMWp3/JQg7J5j4nize3qIruMJ01BnL1LKr0F1Y=;
 b=eszPQ7uqx8aqINh4Uao+sYzhDMCsf1P6NOjtNM0KU92krFOTow5F1IauzpfwYJywV0qHnqDWUfOFFta7geKC0WI6Dx5DQ+VGEdejASYZxaIH9zpF6TJ6hKui2vEt7fxEWfm4/LBek5jgsYuDnjFqqDBXle4qIpJW3DIpDss0D4to+DYy5L3HFOEt+N2vXfczBQ0JEr5OqExRsqi9zjtGfJD3pkkUFeMRg5oz5vZbKm3ndv5gzjPB8LbEJMxoc2fdf4kCBO716dKSdoszdYcATNk/++1ps10GLgqBF5074PFv1OvWKjlRPmluRv8AcDS9na3c3R+jnwMV/RQNdQI5Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xh29QuMWp3/JQg7J5j4nize3qIruMJ01BnL1LKr0F1Y=;
 b=c9dn6xF/opXSmawW5a1GKus8iS1iMrRZNCXmFWPdTy6P6YfEdjibfKOlIMAZErVASjtB9/8Mz621OrD2OA/4Dxau4JkHoE3OlO6bz+DZavRQuGXzG9mF2N9Z/Fai0KK4huPO5p6l/teOEAXD+82zfsmbAyYGNjK6zwzuyCSk1Ccsoef2joZtN4FcabfdRYSnWY+K/nqCXjqTOR0PchNUSnm8XQfz9nOX6jK8K3JJTy+JWzCHxjVcRA2C9WRYyC+5fXn0iBditG9B/KBdAzemljxeh6lylFvb3Ic8zg9VOCT9wuLgP9JBlNvN8pvVtz8NnfAiMVO+dxY9vQhR8EuLBw==
Received: from DM6PR04CA0004.namprd04.prod.outlook.com (2603:10b6:5:334::9) by
 CY5PR12MB6479.namprd12.prod.outlook.com (2603:10b6:930:34::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Mon, 12 Jan 2026 09:25:03 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::75) by DM6PR04CA0004.outlook.office365.com
 (2603:10b6:5:334::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 09:24:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 09:25:03 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 01:24:50 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 12 Jan 2026 01:24:49 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 01:24:47 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH 1/4] drivers: fix flow devarg handling for future HW
Date: Mon, 12 Jan 2026 11:24:35 +0200
Message-ID: <20260112092439.14843-2-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20260112092439.14843-1-mkashani@nvidia.com>
References: <20260112092439.14843-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|CY5PR12MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e17f461-a337-4c7f-800e-08de51bc77b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hWbFf9K/2REaCfk40d+HtTfbeYZWem0l9DUFicHD31XvwUk3Iy5PwCj9nWPE?=
 =?us-ascii?Q?rTRsqEwuKm7Pks8XViJzRteHy51Mq/AkB9IBFu4QNkx4gUFJvRgh2nggwAM4?=
 =?us-ascii?Q?gJjlwbxZaYihNZhuRDgo2CcFDw4Tz2R62oMoZooF6TqYSi/u8i5BsegMmFrb?=
 =?us-ascii?Q?AvRUNR1d5EqU5ehlXt1sesbwcce1WDlku/fpilhTB9lS7y67evCM+XtIs0XA?=
 =?us-ascii?Q?BZkP6XHXyEaTDl3SHMbjkR20ylypoIuEDeO5EwIVakBJcnKxYbH3I9ASc0fp?=
 =?us-ascii?Q?TxWiIkvSGHtFeGeStvzOzduHIEymoOMunY+5wmmi4z3bEE66yQom1+3CJXw3?=
 =?us-ascii?Q?sm8R/hRz28lLNbdxmRizpqavPqpxtXhEk8+5yFpm9NqhPZdCuL57vG6WU7k6?=
 =?us-ascii?Q?E55ygxu+pSj+Bu5FeAE1KDCyMAHDAWqrALJ8YgZx8eU3o7v8S+Bn1WNV6+r8?=
 =?us-ascii?Q?hCSGFnP3T2T+FAxuF5ql1lbNI5PC0MaKJg1wkxd+bprSaE5IPO3Ti4uoDg26?=
 =?us-ascii?Q?G2gpbMKJNrYGC5EPk/xTombQgQGC5bh2EF/4LBGZ8pnaYhL6Zbt/dda6nAff?=
 =?us-ascii?Q?Z6IDxr7waUO7tHBRS2o4XkumYqAaT6v7K3J6Hh3/h3TZaL6mkKaaAovmKRAW?=
 =?us-ascii?Q?3WctxxE2Ci/m7Rg4USDAA6Nu2iP6NnUL7TtylRvm4CJVZMgmFJ0zCjWnnFp/?=
 =?us-ascii?Q?SXBwEDglT6A8vAd7+lpyA1XzlKZifnaK6k1Kk2YVJjO9n7oIhkEkuQdbJB8z?=
 =?us-ascii?Q?njtVb8ybaahfL0ouGqmMFZ4qBLbyNBxyVDtNXO4jR+YUyX/eJVIjvKHhRMyj?=
 =?us-ascii?Q?4BLuFselt3PS3U+NQZODVBPyTKYiSAe+2LD9YUVADaMHflfbsjrGvzwlYmj3?=
 =?us-ascii?Q?p95cx7AWfril2qfNJYqW0zlUeBtXZu1u6qsVJ4L6L4A5ulSVPuoXKFO85wSB?=
 =?us-ascii?Q?i99eGIF02K+XIVKAGjrtjZ5kNKkiU5NvqNQPYUrrmEiRDpUE4k48xXmLpxby?=
 =?us-ascii?Q?gc80FbSUCmKn/5eBi6Uq1HPGftIrkuXUj0FSCb25un3ZDIL+UWh5FxAu13pf?=
 =?us-ascii?Q?ChWwiCrc5v7I+icQY+vsU1TgXB/sRiBN5T0kDCERDAVTcAm6Fo8ehU1S6vNY?=
 =?us-ascii?Q?XVSINB+D+fUxi21g7/pGG45KUCRP4qNYx0/EFxlxEXiYCtpiwavq8pk3iKVU?=
 =?us-ascii?Q?x5tfjbftv4TiWME60kez4TnWT55EnfvP+ToREE7SftGpqqHkIisAxOnmjBF0?=
 =?us-ascii?Q?tK6tMaAV+iLrNAWDjDS9qQlESMKlPYogxqasdGhjbi9rUXEm366L6KeRYOIa?=
 =?us-ascii?Q?xXI/N/spbGbyBq2xwic74rhQgEf2JSmm/cEVxzS/L8x7bPkcIa0q4opKkRqL?=
 =?us-ascii?Q?zPoEK9GSbBxw2FtoIpxbooHXh9cg1BEDx5PH/2kZNk+PetOOQdQekQ+MTCMA?=
 =?us-ascii?Q?vkN+M0dLxLlZBq+xDIkhcUWv390y5WDVquF8ueT1S1UiO6/7RYNoE6gmi5Cv?=
 =?us-ascii?Q?uH1fUVNg7yGG1Lz7Y6qULAzOurAGhNOUQtZtPF6T6nkSzGDJqxP/UhcFZ5az?=
 =?us-ascii?Q?wlxd/7812WQmSJOmltY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:25:03.6135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e17f461-a337-4c7f-800e-08de51bc77b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6479
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

SWS (software steering) will be disabled on future hardware generations.
This fix should check for SWS capability bits and return relevant error.
Update the defaults for the dv_flow_en and allow_duplicate_pattern
devargs accordingly.

- Default dv_flow_en devarg value will be chosen based on whether
  NIC supports SW steering and/or HW steering.
- If DV flow is not supported and allow_duplicate_pattern is
  set by the user, forcibly disable it and emit a clear log message.

This change improves reliability by ensuring only valid
configurations are applied, and provides clear feedback to
the user when fallbacks are triggered.

Fixes: 1b55eeb7b76f ("common/mlx5: add ConnectX-9 SuperNIC")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
---
 doc/guides/nics/mlx5.rst             | 11 +++--
 drivers/common/mlx5/mlx5_devx_cmds.c | 18 +++++++
 drivers/common/mlx5/mlx5_devx_cmds.h |  6 +++
 drivers/common/mlx5/mlx5_prm.h       | 14 ++++--
 drivers/net/mlx5/mlx5.c              | 71 +++++++++++++++++++++++++++-
 5 files changed, 111 insertions(+), 9 deletions(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 904a0ac3584..0b123461a30 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -698,8 +698,11 @@ for an additional list of options shared with other mlx5 drivers.
   Value 2 enables the WQE based hardware steering.
   In this mode, only queue-based flow management is supported.
 
-  It is configured by default to 1 (DV flow steering) if supported.
-  Otherwise, the value is 0 which indicates legacy Verbs flow offloading.
+  By default, the PMD will set this value according to capability.
+  If DV flow steering is supported, it will be set to 1.
+  If DV flow steering is not supported and HW steering is supported,
+  then it will be set to 2.
+  Otherwise, it will be set to 0.
 
 - ``dv_esw_en`` parameter [int]
 
@@ -834,8 +837,10 @@ for an additional list of options shared with other mlx5 drivers.
   - 1. Allow insertion of rules with the same pattern items.
     In this case, all rules are inserted but only the first rule takes effect,
     the next rule takes effect only if the previous rules are deleted.
+    This option is not supported in :ref:`HWS mode <mlx5_hws>`.
+    If this option is set to 1 in HWS mode, it will be set to 0.
 
-  By default, the PMD will set this value to 1.
+  By default, the PMD will set this value according to capability.
 
 
 .. _mlx5_net_stats:
diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c b/drivers/common/mlx5/mlx5_devx_cmds.c
index d885a95c04e..d12ebf8487d 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.c
+++ b/drivers/common/mlx5/mlx5_devx_cmds.c
@@ -1304,6 +1304,18 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
 		rx_reg |= ((0xff & reg_c_8_15) << 8);
 		attr->set_reg_c &= (rx_reg & tx_reg);
 
+		attr->rx_sw_owner_v2 = MLX5_GET(flow_table_nic_cap, hcattr,
+						flow_table_properties_nic_receive.sw_owner_v2);
+		if (!attr->rx_sw_owner_v2)
+			attr->rx_sw_owner = MLX5_GET(flow_table_nic_cap, hcattr,
+						flow_table_properties_nic_receive.sw_owner);
+
+		attr->tx_sw_owner_v2 = MLX5_GET(flow_table_nic_cap, hcattr,
+						flow_table_properties_nic_transmit.sw_owner_v2);
+		if (!attr->tx_sw_owner_v2)
+			attr->tx_sw_owner = MLX5_GET(flow_table_nic_cap, hcattr,
+						flow_table_properties_nic_transmit.sw_owner);
+
 #undef GET_RX_REG_X_BITS
 #undef GET_TX_REG_X_BITS
 	}
@@ -1456,6 +1468,12 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
 		reg_c_8_15 = MLX5_GET(flow_table_esw_cap, hcattr,
 				      ft_field_support_2_esw_fdb.metadata_reg_c_8_15);
 		attr->set_reg_c &= ((0xff & reg_c_8_15) << 8) | esw_reg;
+
+		attr->esw_sw_owner_v2 = MLX5_GET(flow_table_esw_cap, hcattr,
+						 flow_table_properties_nic_esw_fdb.sw_owner_v2);
+		if (!attr->esw_sw_owner_v2)
+			attr->esw_sw_owner = MLX5_GET(flow_table_esw_cap, hcattr,
+						 flow_table_properties_nic_esw_fdb.sw_owner);
 	}
 	return 0;
 error:
diff --git a/drivers/common/mlx5/mlx5_devx_cmds.h b/drivers/common/mlx5/mlx5_devx_cmds.h
index f6e8afbf395..da50fc686cd 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.h
+++ b/drivers/common/mlx5/mlx5_devx_cmds.h
@@ -337,6 +337,12 @@ struct mlx5_hca_attr {
 	uint8_t max_header_modify_pattern_length;
 	uint64_t system_image_guid;
 	uint32_t log_max_conn_track_offload:5;
+	uint8_t rx_sw_owner:1;
+	uint8_t rx_sw_owner_v2:1;
+	uint8_t tx_sw_owner:1;
+	uint8_t tx_sw_owner_v2:1;
+	uint8_t esw_sw_owner:1;
+	uint8_t esw_sw_owner_v2:1;
 };
 
 /* LAG Context. */
diff --git a/drivers/common/mlx5/mlx5_prm.h b/drivers/common/mlx5/mlx5_prm.h
index 411c35f456e..ba33336e588 100644
--- a/drivers/common/mlx5/mlx5_prm.h
+++ b/drivers/common/mlx5/mlx5_prm.h
@@ -1597,9 +1597,13 @@ enum {
 #define MLX5_HCA_FLEX_GTPU_DW_0_ENABLED (1UL << 18)
 #define MLX5_HCA_FLEX_GTPU_TEID_ENABLED (1UL << 19)
 
-/* The device steering logic format. */
-#define MLX5_STEERING_LOGIC_FORMAT_CONNECTX_5 0x0
-#define MLX5_STEERING_LOGIC_FORMAT_CONNECTX_6DX 0x1
+/* The device steering logic format version. */
+enum {
+	MLX5_STEERING_LOGIC_FORMAT_CONNECTX_5 = 0,
+	MLX5_STEERING_LOGIC_FORMAT_CONNECTX_6DX = 1,
+	MLX5_STEERING_LOGIC_FORMAT_CONNECTX_7 = 2,
+	MLX5_STEERING_LOGIC_FORMAT_CONNECTX_8 = 3,
+};
 
 struct mlx5_ifc_cmd_hca_cap_bits {
 	u8 access_other_hca_roce[0x1];
@@ -2348,7 +2352,9 @@ struct mlx5_ifc_flow_table_nic_cap_bits {
 };
 
 struct mlx5_ifc_flow_table_esw_cap_bits {
-	u8 reserved_at_0[0x800];
+	u8 reserved_at_0[0x200];
+	struct mlx5_ifc_flow_table_prop_layout_bits flow_table_properties_nic_esw_fdb;
+	u8 reserved_at_400[0x400];
 	struct mlx5_ifc_ft_fields_support_bits ft_header_modify_esw_fdb;
 	u8 reserved_at_C00[0x800];
 	struct mlx5_ifc_ft_fields_support_2_bits
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index bde4d01e488..c78054eb3c5 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -1441,6 +1441,45 @@ mlx5_dev_args_check_handler(const char *key, const char *val, void *opaque)
 	return 0;
 }
 
+static bool
+mlx5_hws_is_supported(struct mlx5_dev_ctx_shared *sh)
+{
+	return (sh->cdev->config.devx &&
+	       sh->cdev->config.hca_attr.wqe_based_flow_table_sup);
+}
+
+static bool
+mlx5_sws_is_any_supported(struct mlx5_dev_ctx_shared *sh)
+{
+	struct mlx5_common_device *cdev = sh->cdev;
+	struct mlx5_hca_attr *hca_attr = &cdev->config.hca_attr;
+
+	if (hca_attr->rx_sw_owner_v2 || hca_attr->rx_sw_owner)
+		return true;
+
+	if (hca_attr->tx_sw_owner_v2 || hca_attr->tx_sw_owner)
+		return true;
+
+	if (hca_attr->eswitch_manager && (hca_attr->esw_sw_owner_v2 || hca_attr->esw_sw_owner))
+		return true;
+
+	return false;
+}
+
+static bool
+mlx5_kvargs_is_used(struct mlx5_kvargs_ctrl *mkvlist, const char *key)
+{
+	const struct rte_kvargs_pair *pair;
+	uint32_t i;
+
+	for (i = 0; i < mkvlist->kvlist->count; ++i) {
+		pair = &mkvlist->kvlist->pairs[i];
+		if (strcmp(pair->key, key) == 0 && mkvlist->is_used[i])
+			return true;
+	}
+	return false;
+}
+
 /**
  * Parse user device parameters and adjust them according to device
  * capabilities.
@@ -1481,6 +1520,8 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 	int ret = 0;
 	size_t alignment = rte_mem_page_size();
 	uint32_t max_queue_umem_size = MLX5_WQE_SIZE * mlx5_dev_get_max_wq_size(sh);
+	bool hws_is_supported = mlx5_hws_is_supported(sh);
+	bool sws_is_supported = mlx5_sws_is_any_supported(sh);
 
 	if (alignment == (size_t)-1) {
 		alignment = (1 << MLX5_LOG_PAGE_SIZE);
@@ -1491,9 +1532,15 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 	memset(config, 0, sizeof(*config));
 	config->vf_nl_en = 1;
 	config->dv_esw_en = 1;
-	config->dv_flow_en = 1;
+	if (!sws_is_supported && hws_is_supported)
+		config->dv_flow_en = 2;
+	else
+		config->dv_flow_en = 1;
 	config->decap_en = 1;
-	config->allow_duplicate_pattern = 1;
+	if (config->dv_flow_en == 2)
+		config->allow_duplicate_pattern = 0;
+	else
+		config->allow_duplicate_pattern = 1;
 	config->fdb_def_rule = 1;
 	config->cnt_svc.cycle_time = MLX5_CNT_SVC_CYCLE_TIME_DEFAULT;
 	config->cnt_svc.service_core = rte_get_main_lcore();
@@ -1513,6 +1560,26 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 		DRV_LOG(WARNING, "DV flow is not supported.");
 		config->dv_flow_en = 0;
 	}
+	/* Inform user if DV flow is not supported. */
+	if (config->dv_flow_en == 1 && !sws_is_supported && hws_is_supported) {
+		DRV_LOG(WARNING, "DV flow is not supported. Changing to HWS mode.");
+		config->dv_flow_en = 2;
+	}
+	/* Handle allow_duplicate_pattern based on final dv_flow_en mode.
+	 * HWS mode (dv_flow_en=2) doesn't support duplicate patterns.
+	 * Warn only if user explicitly requested an incompatible setting.
+	 */
+	bool allow_dup_pattern_set = mkvlist != NULL &&
+		mlx5_kvargs_is_used(mkvlist, MLX5_ALLOW_DUPLICATE_PATTERN);
+	if (config->dv_flow_en == 2) {
+		if (config->allow_duplicate_pattern == 1 && allow_dup_pattern_set)
+			DRV_LOG(WARNING, "Duplicate pattern is not supported with HWS. Disabling it.");
+		config->allow_duplicate_pattern = 0;
+	} else if (!allow_dup_pattern_set) {
+		/* Non-HWS mode: set default to 1 only if not explicitly set by user */
+		config->allow_duplicate_pattern = 1;
+	}
+
 	if (config->dv_esw_en && !sh->dev_cap.dv_esw_en) {
 		DRV_LOG(DEBUG, "E-Switch DV flow is not supported.");
 		config->dv_esw_en = 0;
-- 
2.21.0

