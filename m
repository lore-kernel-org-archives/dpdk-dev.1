Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3832ACEDDA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 14:57:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C14540265;
	Tue, 18 Nov 2025 15:57:49 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010050.outbound.protection.outlook.com
 [52.101.193.50])
 by mails.dpdk.org (Postfix) with ESMTP id CA2D140150;
 Tue, 18 Nov 2025 15:57:47 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDfD+V6f/rC6fVFlpD62/t4p9pnDT075PEZimK4+9EVSMv43vVJ+cTFU63+CxUE1cnKbmCwaG8bHtdkj3ZWMsP5MhsKIUsttSdGpYrNsv6NPeUvcSVU/VAYWuK99Tg3IFNL1hZiY8KFEALoj2QFx9TclpwijU7e51UioPKrAT+QO/Nn+7D25Yi9ocgy+154IlYWxg8p0wfTfyH83lQgDczw/l+1gB0YMAIrLSho1i03TL/04e16oU2d8UQalO3XvpIwAyR318KMwHff4kT72Pk0YSsxo5uAiE1PU8expu1ob1Y1vGlGVK+H2Zk1GG/dx10mFGzUSkjNGEnGK7PsMcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3x9qXllDd4ahijnP26tl4B9DKBKQWdKcR1UKGcnC7OE=;
 b=VypMHKJGD1SCdmzUWO6ecx1n0WkzzMWeMXFMGWxwoYi5CP20/VQNPLDcV0TYksHSTsBN96EzPCCblZhuKoEnkb63a3J9RVvwTCQsPpIeE3oMEAMouiZKl3G8j4wRADj9tt1V5UpB/w5Zcn1BuNhQbUZGN1ESmp6vclLgoxRIQDVtbwrxXHfLUZlmDYOsOxZx3i3vtqFegkyPheVpDNOonu8+9AK5msquR5GCONoBPqPdEqHdvtcdUbKJqTNbXuGkUYz/WsEcTcF63e3ZR/QMtdnV6ZvBrZcC2ZmK3Vf3uhGJC/pBio/whjbnynCPKLG1IbFNA65vj8oMC6X6h38bUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3x9qXllDd4ahijnP26tl4B9DKBKQWdKcR1UKGcnC7OE=;
 b=lK5Pv7g7sAnxVM1l1STtxGpCKS2oevMg2ICt5IZ5g1zKI9u27mblSlUwKJaFW28c9qybaVkidnLaj63l52suUPYr5G6m+GpIc3dODKnpHJFEVGiqgrK9pu33Vh/tp/pg0RxFzOSE86v4EmPKHxsXpumZ5gFAt0ktMer6I6lXQfVYPSG65WKv0PDUK9TRKUnrG0RR9JJEL5nFtVEX9FTEE2hgNHLbluHebQHXLq7xht/a8bQWv9a8XIw9asaq7AgqXl6blvjq7SO5TPfGyFZbRnI7carbjoU3YZODzgpMPQ86ccIHmtlcrCibJaxbzgccp+9G4GUid6e1hg1FZCWPbA==
Received: from SA1P222CA0110.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::22)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Tue, 18 Nov
 2025 14:57:41 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::45) by SA1P222CA0110.outlook.office365.com
 (2603:10b6:806:3c5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 14:57:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 14:57:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 06:57:23 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 06:57:20 -0800
From: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, <matan@nvidia.com>, <suanmingm@nvidia.com>,
 <dsosnowski@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix flex item header length field adjusting
Date: Tue, 18 Nov 2025 16:57:06 +0200
Message-ID: <20251118145706.1272370-1-viacheslavo@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|DM4PR12MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e3a495-8f91-4c04-0981-08de26b2d200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3HH+lFraLFZM1PTjQJ0NiovR5l2A3gNyAZXvVyOxjJnHUpT0QGGD0U9Jf3mL?=
 =?us-ascii?Q?eXIncCFRXLhXHPlrSeyIPh4Ifj/HZiDrh2rz+OF0g0kYVA1eKqLPeUTxfoI2?=
 =?us-ascii?Q?UiEh1/yiOvDhv59stJGHObDp88Nilj2HoLpJiJg2T6kl7Am0JVxT7s5rrzRl?=
 =?us-ascii?Q?KeLjRv1hCxXDFE/5Yv6IwhzY5/VS8v2IfrLxyEP3166LU4uCZGkjFn6avtOU?=
 =?us-ascii?Q?1a62sO6yzOgKiK55+GavVbI+P262Zkwj47zUxBGCam2CJqUY31hxZtYCfvMj?=
 =?us-ascii?Q?yG1lExnek/cfvT4PGojVv9VyI6SYSVIzBU9XRMuOXmsobzZr+xvqPMHw05ht?=
 =?us-ascii?Q?ROQ1lUgmwor3zXSMMIcutcsXFA47Pee6L6b0UxfnqgSBc9ZzSeTJJY3vIHwK?=
 =?us-ascii?Q?6CFUzZDh+RK4xHnhfnR0zc7QPWN6aFMEv+1yfkv9wVCvdyueblNo7LmCA3Ru?=
 =?us-ascii?Q?RrNpjEURLIvPoq2EKK1DQ6DLNxzn/OFeUlNhKnx7Kl4KtXQsB+FVs/9yelBm?=
 =?us-ascii?Q?oUaJHQvlR4ETWqYUt4pZuM8XwsKta22GF1kCktFVKDDSqQUoP9wFBo7vxOqy?=
 =?us-ascii?Q?GF3+1IXthqwm4f0jQuw4Q/v3Rksel6EDSC7zRrMhq7Q40h+bT3ILilat7mh+?=
 =?us-ascii?Q?qINg5R6tghPy4dMxu6GSQ2T6ak+jGfjJmcUNntH1P+UeRiW5a5GxFQGhqYRM?=
 =?us-ascii?Q?yAhl66HT97aNqE39J0/1sXjULl9WH/AHZ4ElLxUZfUWucYtCiKCPIrQ6NZ/x?=
 =?us-ascii?Q?DnbT/F4l2g8u1nLDULl/pnn4q+NHoFdSy1+pSYH2TtBuY+N/rUMSmQQ3pdt2?=
 =?us-ascii?Q?EaMvB4uylhXFbjt1ZwdKgJ0swSmG+HWGNCPkXTZh0mnmc8YbKk/EdSe5Rjsm?=
 =?us-ascii?Q?+C+OSMqOXzly9CgpGj6JBceM/1cjpUsSnjjimCFqjUp/1zcnJnbn1svnI3Jy?=
 =?us-ascii?Q?T34au5sXSGGSWoRNnTERR/ZhIEbAG72T//1p6LEc74TMzyzOsz82JkHme3/U?=
 =?us-ascii?Q?RajuGL1cHdY9CVaSUFXI4LBmOLoQZLADvNWl/wlHANDBPvWbZ0C5iXs/hn0T?=
 =?us-ascii?Q?Oc8OaKKwUyS1W+CZIidLHvZbpOHD0aUmgAjYzR5uW5I/DTTUY/VDsKsilrEx?=
 =?us-ascii?Q?GYtujkj/5+3RWw+TRN/KqvvM3j5iSk8VhIvTdHgwMkPdTq/iHIn3o3BRz0Kp?=
 =?us-ascii?Q?ozqxa2xBt97mBjtLXWZ1SDm9cij/NGRS+e+Hiss29I2KaH41J46J8dmUuv0G?=
 =?us-ascii?Q?tN21dIeWGBcYIuoZR+rJZzGRQoZXf21yOieSX0zcWNzfMljv+zGj8LoeZxYc?=
 =?us-ascii?Q?6Iqin/kwktYKY0DHY8T77gEywvrUjtRXLR8qGBdpwipu8FTR9j0NWsEwiURF?=
 =?us-ascii?Q?Lb3ryoSuqt+znsyx9xSYnFekP4JEQ3VQ3gk9FaZ/db/ysNxgJpXWUzVFOeZF?=
 =?us-ascii?Q?2b4kNHe4sp+nCkubsgolYNOl2v43UpwpuJEVm3w6xE8vpCgr3cJzMYj9/G0v?=
 =?us-ascii?Q?CVhwAtStyP6jrYceHTuXUFHgKT5ubfbOiTGxhviiUR1A4qu0WLVqsutIJCW4?=
 =?us-ascii?Q?gB9NzgvPvt3wFlSI1v8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:57:40.0791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e3a495-8f91-4c04-0981-08de26b2d200
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573
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

There is the updated firmware providing the new capability
bit "header_length_field_offset_mode". If this bit is set
the length field offset in flex parser configuration should
not be adjusted by the supported field mask left margin,
and the bit "header_length_field_offset_mode" should be set
in configuration command on the flex parser creation
firmware call.

Fixes: b04b06f4cb3f ("net/mlx5: fix flex item header length field translation")
Cc: stable@dpdk.org

Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/common/mlx5/mlx5_devx_cmds.c |  4 ++++
 drivers/common/mlx5/mlx5_devx_cmds.h |  2 ++
 drivers/common/mlx5/mlx5_prm.h       |  8 ++++++--
 drivers/net/mlx5/mlx5.c              | 12 +++++++++---
 drivers/net/mlx5/mlx5_flow_flex.c    |  3 ++-
 5 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c b/drivers/common/mlx5/mlx5_devx_cmds.c
index 22f6b29089..d12ebf8487 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.c
+++ b/drivers/common/mlx5/mlx5_devx_cmds.c
@@ -784,6 +784,8 @@ mlx5_devx_cmd_create_flex_parser(void *ctx,
 		 MLX5_GENERAL_OBJ_TYPE_FLEX_PARSE_GRAPH);
 	MLX5_SET(parse_graph_flex, flex, header_length_mode,
 		 data->header_length_mode);
+	MLX5_SET(parse_graph_flex, flex, header_length_field_offset_mode,
+		 data->header_length_field_offset_mode);
 	MLX5_SET64(parse_graph_flex, flex, modify_field_select,
 		   data->modify_field_select);
 	MLX5_SET(parse_graph_flex, flex, header_length_base_value,
@@ -911,6 +913,8 @@ mlx5_devx_cmd_query_hca_parse_graph_node_cap
 						max_next_header_offset);
 	attr->header_length_mask_width = MLX5_GET(parse_graph_node_cap, hcattr,
 						  header_length_mask_width);
+	attr->header_length_field_mode_wa = !MLX5_GET(parse_graph_node_cap, hcattr,
+						      header_length_field_offset_mode);
 	/* Get the max supported samples from HCA CAP 2 */
 	hcattr = mlx5_devx_get_hca_cap(ctx, in, out, &rc,
 			MLX5_GET_HCA_CAP_OP_MOD_GENERAL_DEVICE_2 |
diff --git a/drivers/common/mlx5/mlx5_devx_cmds.h b/drivers/common/mlx5/mlx5_devx_cmds.h
index 4c7747cbec..da50fc686c 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.h
+++ b/drivers/common/mlx5/mlx5_devx_cmds.h
@@ -119,6 +119,7 @@ struct mlx5_hca_flex_attr {
 	uint8_t  sample_tunnel_inner2:1;
 	uint8_t  zero_size_supported:1;
 	uint8_t  sample_id_in_out:1;
+	uint8_t  header_length_field_mode_wa:1;
 	uint16_t max_base_header_length;
 	uint8_t  max_sample_base_offset;
 	uint16_t max_next_header_offset;
@@ -654,6 +655,7 @@ struct mlx5_devx_graph_node_attr {
 	uint32_t header_length_base_value:16;
 	uint32_t header_length_field_shift:4;
 	uint32_t header_length_field_offset:16;
+	uint32_t header_length_field_offset_mode:1;
 	uint32_t header_length_field_mask;
 	struct mlx5_devx_match_sample_attr sample[MLX5_GRAPH_NODE_SAMPLE_NUM];
 	uint32_t next_header_field_offset:16;
diff --git a/drivers/common/mlx5/mlx5_prm.h b/drivers/common/mlx5/mlx5_prm.h
index 9383e09893..ba33336e58 100644
--- a/drivers/common/mlx5/mlx5_prm.h
+++ b/drivers/common/mlx5/mlx5_prm.h
@@ -2119,7 +2119,9 @@ struct mlx5_ifc_parse_graph_node_cap_bits {
 	u8 max_num_arc_in[0x08];
 	u8 max_num_arc_out[0x08];
 	u8 max_num_sample[0x08];
-	u8 reserved_at_78[0x03];
+	u8 reserved_at_78[0x01];
+	u8 header_length_field_offset_mode[0x1];
+	u8 reserved_at_79[0x01];
 	u8 parse_graph_anchor[0x1];
 	u8 reserved_at_7c[0x01];
 	u8 sample_tunnel_inner2[0x1];
@@ -4991,7 +4993,9 @@ struct mlx5_ifc_parse_graph_flex_bits {
 	u8 next_header_field_offset[0x10];
 	u8 reserved_at_160[0x12];
 	u8 head_anchor_id[0x6];
-	u8 reserved_at_178[0x3];
+	u8 reserved_at_178[0x1];
+	u8 header_length_field_offset_mode[0x1];
+	u8 reserved_at_17a[0x1];
 	u8 next_header_field_size[0x5];
 	u8 header_length_field_mask[0x20];
 	u8 reserved_at_224[0x20];
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 1d07ca4293..45d1fccf65 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -1080,9 +1080,15 @@ mlx5_alloc_srh_flex_parser(struct rte_eth_dev *dev)
 	/* The unit is uint64_t. */
 	node.header_length_field_shift = 0x3;
 	/* Header length is the 2nd byte. */
-	node.header_length_field_offset = 0x8;
-	if (attr->header_length_mask_width < 8)
-		node.header_length_field_offset += 8 - attr->header_length_mask_width;
+	if (attr->header_length_field_mode_wa) {
+		/* Legacy firmware before ConnectX-8, we should provide offset WA. */
+		node.header_length_field_offset = 8;
+		if (attr->header_length_mask_width < 8)
+			node.header_length_field_offset += 8 - attr->header_length_mask_width;
+	} else {
+		/* The new firmware, we can specify the correct offset directly. */
+		node.header_length_field_offset = 12;
+	}
 	node.header_length_field_mask = 0xF;
 	/* One byte next header protocol. */
 	node.next_header_field_size = 0x8;
diff --git a/drivers/net/mlx5/mlx5_flow_flex.c b/drivers/net/mlx5/mlx5_flow_flex.c
index b1174fe0ed..d21e28f7fd 100644
--- a/drivers/net/mlx5/mlx5_flow_flex.c
+++ b/drivers/net/mlx5/mlx5_flow_flex.c
@@ -554,7 +554,7 @@ mlx5_flex_translate_length(struct mlx5_hca_flex_attr *attr,
 				 "mask and shift combination not supported (OFFSET)");
 		msb++;
 		offset += field->field_size - msb;
-		if (msb < attr->header_length_mask_width) {
+		if (attr->header_length_field_mode_wa && msb < attr->header_length_mask_width) {
 			if (attr->header_length_mask_width - msb > offset)
 				return rte_flow_error_set
 					(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM, NULL,
@@ -572,6 +572,7 @@ mlx5_flex_translate_length(struct mlx5_hca_flex_attr *attr,
 		node->header_length_field_mask = mask;
 		node->header_length_field_shift = shift;
 		node->header_length_field_offset = offset;
+		node->header_length_field_offset_mode = !attr->header_length_field_mode_wa;
 		break;
 	}
 	case FIELD_MODE_BITMASK:
-- 
2.34.1

