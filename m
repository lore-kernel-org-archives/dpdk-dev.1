Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D24CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 08:38:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E315840670;
	Thu,  6 Nov 2025 09:38:45 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
 by mails.dpdk.org (Postfix) with ESMTP id E61F54013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 09:38:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6o2B2uuCKq9525bc6yTeRQzhEQ1NMWDJJ+CSXH+t9BOHtZsJPxn3brcZI1mlpuBLb+uO5CIl1xnKUkWjYaHbfasr01A+KxbzIMBCVolnY6asSgXgUo5bh/uyDQEMo9IEcf+3VVmaQWdf/Vp+fEqtuMYarkCNTuzRyv8y1H0jmmO1kRWNFT0qvFafSyDFcJlN3R9OVNUktUNh3qQcpM95g4sEojla897A34qjiODVPcP7PoqT7vsNLeBOOBvx86I9Pso3er2X7rlpL3JiYVH5r6xhDQIPa0dVsUteaJHcv4mM8Zu5JCV8mp6PsNNDo2cZxmj52jTMeUQ3/j7o3VTmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KywefTNxSX2OIJFwILV7K9IFLtseNBgMO8CVUtkCQeM=;
 b=fSWTv4cbBeK2Y2eQia21iVyKRp7Vjf5s8iuZCZIYs78nWO136ZRCks9+wMx5rA3UalKcSmSdIKp0AEw81D9Vu6Ssb5qKu/hq/6CozOUlBT6w3Vtm8vr4AdDa7IF7eYaBvb+vI/DBTZml5bWnM3DtlpP76rgA8OPTPSyTfGK3emS5yLC1GA3mINdqjl9zILW1rH4sUuGqprt/dDpzVpgkvCJOMIylzoSy86BiKSEpsDhGGQdEhUUmhiTyiPNrJT5KeNolkHvl8vngqnLhWK56Nd+Te9S48qHzWc5KmndWdmA091aRebGEmHSsuahcwoHS/ED5A9M/3vYToQCrumzSmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KywefTNxSX2OIJFwILV7K9IFLtseNBgMO8CVUtkCQeM=;
 b=tKLQh9FZhj0x3YC3mBip1tS0mqA5QeRX3cGs5nYIqggdqmE+mIOoYv8QpxI277reRRiVDR4uZdWpaCFfJYKdRPJlLquDVCdS/wPfbmjmIRwiYyCK0I+u6Tx4Y+ngVYP5dmo95kJTEQxslIm1N/r8/CZNLMNOu0lHJETSWXqpOZlrVaCB66ls0xAJdVcJJJ1m+aYHeWeiPJvq9QU0fUHOPJ+SWun6O6Z1LN+s1zGJRIumL6LTej7YSFvKJpxhpibEw2WRCjT9658LshdmFjLbE/WD5PPEXin9D+VZDcvsakJI4FrqsihyeHtk+FBXZNr+FdEehLPM5Obn+l3YdTyQTw==
Received: from DS7P220CA0067.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::27) by
 BY5PR12MB4114.namprd12.prod.outlook.com (2603:10b6:a03:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 08:38:40 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:8:224:cafe::33) by DS7P220CA0067.outlook.office365.com
 (2603:10b6:8:224::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Thu, 6
 Nov 2025 08:38:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 08:38:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 00:38:24 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 00:38:24 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 6 Nov 2025 00:38:21 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH 1/2] common/mlx5: read SWS capability bits
Date: Thu, 6 Nov 2025 10:38:16 +0200
Message-ID: <20251106083817.166689-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|BY5PR12MB4114:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a051c7-e027-4f92-e4b8-08de1d0fe2c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?asc7KS1ZYZW8nizK2HMc4ATyNX46pKoEtl2OrecyaZaKaj9QDdQqJMKUs8Nr?=
 =?us-ascii?Q?eBFfWAZviVJ8V6YEVearuBQUP+YO1xuJowFi3svUDwck+rraPCICCyVloybL?=
 =?us-ascii?Q?D9OwkWIf9Qwv/LFEduK/SVOVzAe0bWozq/Y8UGgcSy9y3+PBiVbpGn/H3yuL?=
 =?us-ascii?Q?zf/xiBFJKfw5zBsQ2mmluYzm4+BTpchPJUIEqsnHXVHQpmCru0MngqHFwtEv?=
 =?us-ascii?Q?+xXyP8gEaEqw/LfWHIVGNJqAlgnmAC4qhZzXN2j/sfiWs6j4LUstniMu4Ymp?=
 =?us-ascii?Q?xS1A515x8kxv2B6GWbtqDtIBspg3qLf6eeggfYV9KbA3J1h/+JGQHq/wxOOO?=
 =?us-ascii?Q?eDgWNHXbHYhKd/m3QzPLv0RHzYgwfeQaZFQCvnGJFXk2meAuxBWh+HMZ/DXD?=
 =?us-ascii?Q?ICG5IuC3nEVYSc2mJ3SVjXBwStYsxJdtSMuhCYm+l8DmrlO0v8Pk/1R99ey4?=
 =?us-ascii?Q?UotW3VWlDmhf0Pm6iw3D8S5bSFxERIXa31ICDAhF1Cwhiivxk2HGvE/TLnML?=
 =?us-ascii?Q?WWiTf/ToZBpG19vu+PcD/gW61z/7zexdc1j1qzx2bopXECQRl4v9Jaq1so+c?=
 =?us-ascii?Q?yaT91+rypFl1fDkNBN846h0Z/+oxIo+1Esypyc7czSbjK7PVKPf0g9bdu/TB?=
 =?us-ascii?Q?5/rwI5Sqf6NdKNmaz79KgJjFBNIPCyj5w/OpjYLK94SQMejxSoZ/9BNpYOU5?=
 =?us-ascii?Q?ty1j5e1UmkguH8xVjVuGSfkUxkd/bT5p8frkDnRIoT+CnA5o8cmICaiqAxPq?=
 =?us-ascii?Q?gLcqZ0fchRPrZKdpEMWFpDuEiNHh0NAg89WmcwmwhSc+0Afk9PMzrRjjcH8z?=
 =?us-ascii?Q?8OTVABkSRCNg4VTKbchJEf8p4jFDdwC5q1vCigAgPQqJXn5U9Nw6v9lw6nx+?=
 =?us-ascii?Q?rr7WxKC3iYjqRJZYrXuMm77tBW8+owlbBZrd0iNLEdd0XnCPHtBS6uxlJ9Co?=
 =?us-ascii?Q?BzrGuvHbhXNkrDghretvDnigXsNAJm2fDMJYPKDVfH16m66lAiK9sVYQ8Xx2?=
 =?us-ascii?Q?HnE7n23jnMpext6aZ7ysCGp1OQm86D2qpa7E8WvnVW1ZihiwC9+5pjCD5nXS?=
 =?us-ascii?Q?4/dS1F+fchU7SrtGGeZrq+Uqz6VqgP0SrSyHvTn309O+wXJB1D/Lwnyh1O9z?=
 =?us-ascii?Q?I8VZEEJfDFvCWdOU/NC2Mny5SzzG+E4jE1VQLNwhlPk26jM4dIMJuaSTPYaj?=
 =?us-ascii?Q?bp0rNzJiGDYctLH0AquojpJZNZnbGd9GZHbV1eBAFsO6TtfBjcTrWGPupsu0?=
 =?us-ascii?Q?n4fcMNFXRtxhd2IJAEs8EYlU1XIg0pY9KV3Ioq+mIl5ADCjL6kakxvjrUyTW?=
 =?us-ascii?Q?P8Nz0jhfUGPaxPmM119p05JBN75p9K4QKTrdpgXxBI8faFF3DrCaWzxrSn5T?=
 =?us-ascii?Q?FI2UXgKyDfDyZBX+QQzymdaj/0fMRTd9AoZTQa3YKBsnjp8qk8aGf6okX/JH?=
 =?us-ascii?Q?JAo12s7OoiczkIKIto3LrYtdwnObdELIoA1W3b1oh4Oh9ptAb/Njm/7N2Fpf?=
 =?us-ascii?Q?ilmopX5TxQYkxdbE/Kc3nJDShHpHE1ugMdrhKNtdQ9iy6sU85OaOQsMPFh4b?=
 =?us-ascii?Q?Y18Q+uzblKoqGoVJ6Wg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 08:38:39.8357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a051c7-e027-4f92-e4b8-08de1d0fe2c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4114
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

SWS will be disabled in future HW generation.
Checking SWS capability bits and returning relevant error.
if user configuration is not supported,
will be added in the follow up commit.

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/common/mlx5/mlx5_devx_cmds.c | 18 ++++++++++++++++++
 drivers/common/mlx5/mlx5_devx_cmds.h |  6 ++++++
 drivers/common/mlx5/mlx5_prm.h       | 14 ++++++++++----
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c b/drivers/common/mlx5/mlx5_devx_cmds.c
index 385759230a2..22f6b29089e 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.c
+++ b/drivers/common/mlx5/mlx5_devx_cmds.c
@@ -1300,6 +1300,18 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
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
@@ -1452,6 +1464,12 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
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
index efae6826dcf..4c7747cbeca 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.h
+++ b/drivers/common/mlx5/mlx5_devx_cmds.h
@@ -336,6 +336,12 @@ struct mlx5_hca_attr {
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
index 5db8d67cfc1..6cde3f8f1a1 100644
--- a/drivers/common/mlx5/mlx5_prm.h
+++ b/drivers/common/mlx5/mlx5_prm.h
@@ -1593,9 +1593,13 @@ enum {
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
@@ -2342,7 +2346,9 @@ struct mlx5_ifc_flow_table_nic_cap_bits {
 };
 
 struct mlx5_ifc_flow_table_esw_cap_bits {
-	u8 reserved_at_0[0x800];
+	u8 reserved_at_0[0x200];
+	struct mlx5_ifc_flow_table_prop_layout_bits flow_table_properties_nic_esw_fdb;
+	u8 reserved_at_400[0x400];
 	struct mlx5_ifc_ft_fields_support_bits ft_header_modify_esw_fdb;
 	u8 reserved_at_C00[0x800];
 	struct mlx5_ifc_ft_fields_support_2_bits
-- 
2.21.0

