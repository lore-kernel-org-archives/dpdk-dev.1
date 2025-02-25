Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D966DC021A4
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 00:46:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA066427DA;
	Tue, 25 Feb 2025 01:46:24 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
 by mails.dpdk.org (Postfix) with ESMTP id 0A5DC40EE2
 for <dev@dpdk.org>; Tue, 25 Feb 2025 01:46:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQSXyACRZJcmXyF7nFIArkNj4P9t9BS0Eyw05m4aC3KZoBen7jEW5BS8txnmMhwSKELArUTGQ/NfDN6KWWIgsj2t2CkhtU8vgjUVja355S6SGcim2FBwi30sAUNprvh44iuJNHLhnffBwaBW7krprulphoJp4pcR7K72Jn/3uvJlodlHESjALno8F7bZ+l7DsM7E+dTBtF3EDOBgi1UpZONMPU3rLpYWCmC4rgFxPJxgNc3zc8xOAHp3qc1oVnEDBf7v5tZ2e0c8erHXyiHPBE013i6G1CwwIERPudJijBLH3GnC5UHKrqZKWt/FloLVZf1XNwIdo5JNuMGTVGgt5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTaz/5qa74WpBsJ+GmMcrwBOXyIiFRtiPRVL0WB/LJU=;
 b=JjP3SR4dLyAQRbp8oh5L4aG++iXfxnWHnAjB0ApqT1QwgiQ0qlI/M+m7Q8941GMwt0lAKYjSOrD1e0/UQBUhNKDNH+FKQh3FhN4svpj4HmUtZf07slYR6Nm+Vji0NQ2U3PN9wMgqTt/UzJ/k4q4TAZmJAqRS6NXKtFqDW58S51tRK83jzcBMlVm9mZd/u6O86vfJxacvBJs2ZPH3Uq6oRelN1OOOwFEs7H95Ob7wlWayzUZi7XzglSQGBwYQEeDL5hl8CttSHS5KD+6wTI8839MbkD6t7+pNFrob1niX8QTy36AVR+P93Mw/Z+9xm5QyC2MTrJtn60hmwdCjT0ASjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTaz/5qa74WpBsJ+GmMcrwBOXyIiFRtiPRVL0WB/LJU=;
 b=o2byc37zJt6pbmPOm42cj7GHeg9LFqsL/1NXphDg8aiKutRi9zmBdpi96+Yxn3RNIfb5jNIu0Mv4Qr+9bV6ePqfHJBNecy5Vzr5iE6X0UKaldrQnEFHOZvKrqfyGt+9QHzHPW7EuYR0yMO1HyOpjKkYlRukbgE4nJlrFmCyECSVSVHlFJ/ZpPljhYpnRfC5xX7TbImh2j6b4HArpaV75JWgfx3P3qwBj+oT+6arcacOaD4YpLrADCHTfGKRXpVNKNTNn8AAGZ+t1gvPZ94TnQpNrjMpWWQWfEAjYmSZUCEUck4u9K7/CV4ArEsAJdyWB2SuzRYq1359T610GcG326g==
Received: from CH2PR14CA0027.namprd14.prod.outlook.com (2603:10b6:610:60::37)
 by IA1PR12MB6355.namprd12.prod.outlook.com (2603:10b6:208:3e1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 00:46:12 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::5a) by CH2PR14CA0027.outlook.office365.com
 (2603:10b6:610:60::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Tue,
 25 Feb 2025 00:46:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 00:46:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Feb
 2025 16:45:59 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Feb
 2025 16:45:55 -0800
From: Suanming Mou <suanmingm@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>
Subject: [PATCH 2/3] net/mlx5: add jump FDB Rx flag
Date: Tue, 25 Feb 2025 08:45:26 +0800
Message-ID: <20250225004527.2066812-3-suanmingm@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225004527.2066812-1-suanmingm@nvidia.com>
References: <20250225004527.2066812-1-suanmingm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|IA1PR12MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: a3005718-a2c6-431b-959a-08dd5535cd99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iVEjMvGPQmyXnwKoJO9SYdPykKEc+Cy9XJVthUtJ287rXzaV7fiS9/Zw/u4m?=
 =?us-ascii?Q?1yKPN/zh+PP7LtYRQA0e/71LPhJTJf3XFpBTsb/79p4BxHsjXmc8i5h93Y+L?=
 =?us-ascii?Q?AWaMsdTbcqtYcHX4HRlZ62oQwQ6ffyDsb++Ep16F4/EC9xyJjJNMwr3sfout?=
 =?us-ascii?Q?GYcPMSiHtLf1MmJ1or3Ad/4NglVUJwXM2duQtxy9jya9M7IuhC3yXQiEgXyU?=
 =?us-ascii?Q?Dwj42JFu00PXHJRUArgJjLpphse6T/tDEA9aOkzpK9Sl8nwzHuScUG0TKhtK?=
 =?us-ascii?Q?HSUb3oswZ7TSatg/sOZFK5HVO5/MQvGDXRlAu6D456IznsS/Pl9yAmb7VJTR?=
 =?us-ascii?Q?dDl9MOKsvO20ToibqbsNn/se5OISrDAKBlT6IYPDMPD68vZp4A+prwJfijP5?=
 =?us-ascii?Q?hJOEfu5P9zarc/D/kiTuoDIoI/LTv3u+CmMWygMdmqPQuXJETrrKDlnxOLZk?=
 =?us-ascii?Q?yAfRIsQZmatgWnggUZUsXBpGLF+QKDtroueqzmgd9l+Mozm0T7OVIXH35j7i?=
 =?us-ascii?Q?4b2KuzR76Qgees1jhMpCTmZgoHLIzS5XwhnT7+ncYeNhrt9hWPqL+YZG6swc?=
 =?us-ascii?Q?QmoWxOPJN9yndluuTKF5lGU6O/pK3aNcdQyL0OFZ6H0OGpPLFtzJO2hEji5g?=
 =?us-ascii?Q?OoGTHbgbunV579dZtFlWdUXsWwB2Xa3zbTs+5jVnDbTLivCdOOA1CSuMnq6M?=
 =?us-ascii?Q?/xUKe71HAwMuhYwtTPiiwgM9K6lcxd3mA5uuXq0kC9ZvHAD1jO2qXJ8Cp/yU?=
 =?us-ascii?Q?C3dKgXmV1wShXOjA2ITZrrzA5yw7tYOy4BZUz394MZ/NfMbRjHn5F+eMKZfb?=
 =?us-ascii?Q?SOezTK8FCskfE0z6+KHgQB+tKYjdy3w50XSF9j0N25SWxkrOEKguBu4gi2m0?=
 =?us-ascii?Q?31O/64ucWMxd23svBKyXzHhWJzm6+lqVh0xrNZa3ZAyORh+2wdu9sCVOPWeI?=
 =?us-ascii?Q?K1KfHLAzncDxhMZS1I3fjq5r5aJ56kfxTJV6Y9uL15i9VhDmnncrtOosPGOa?=
 =?us-ascii?Q?xdvR3BoRzqHOpbP7wg+X1ti0R4QpLciiZaclbErlERKwbJIZ0bPTuNUZeq7i?=
 =?us-ascii?Q?0sviT3U8drUCRULEploCl3jDh1/jLddotv14Zf0BOWTB0Vgd5qr9pALwBBa2?=
 =?us-ascii?Q?DvThJQ3uG/pkKC9bG+u5wDo+Leq8BkGtHlOFYo0Mgv5XvrPXxNCdxzZHFYNg?=
 =?us-ascii?Q?6gVDF+u76Rdn7dioe3/GO8W/QQkhk2Hc1TuJh/pNLTbJFWg4nGlZR4u6BM3P?=
 =?us-ascii?Q?NNbjBMX93/5gkPL0PbpFNBesyXWxDDUhDdEL4uHH6aVCUOeF/AU2UiDJ9Kd0?=
 =?us-ascii?Q?/5w9zBZ+4fws3UAnV7AxnTbkKEj0gytkgCsyPD3Xnw6g8ObOfHhePOIBWOTX?=
 =?us-ascii?Q?dHMrymAj0YWAPUpzSixO3D4hFjDUz31YAv6SNevByvSr4/A6kDk+/iQ7HVM8?=
 =?us-ascii?Q?wUHT+bi6n5tUCMK3FQmcbQxpHrsZE2DmpIEsTVTp2Jknh0kqHRq4oBVpfUpy?=
 =?us-ascii?Q?pZdvvy+FFFHqa9I=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 00:46:12.6094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3005718-a2c6-431b-959a-08dd5535cd99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6355
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

When jump FDB Rx is supported, flow will be able to jump
from FDB Tx to FDB Rx, in that case the dest action in FDB
Rx table should support FDB Tx as well.

Signed-off-by: Suanming Mou <suanmingm@nvidia.com>
---
 drivers/common/mlx5/mlx5_devx_cmds.c | 8 ++++++++
 drivers/common/mlx5/mlx5_devx_cmds.h | 1 +
 drivers/net/mlx5/linux/mlx5_os.c     | 1 +
 drivers/net/mlx5/mlx5.h              | 1 +
 drivers/net/mlx5/mlx5_flow_hw.c      | 8 +++++++-
 5 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c b/drivers/common/mlx5/mlx5_devx_cmds.c
index f504b29f31..eb8553e8ad 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.c
+++ b/drivers/common/mlx5/mlx5_devx_cmds.c
@@ -924,6 +924,7 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
 	uint32_t out[MLX5_ST_SZ_DW(query_hca_cap_out)] = {0};
 	bool hca_cap_2_sup;
 	uint64_t general_obj_types_supported = 0;
+	uint64_t stc_action_type_127_64;
 	void *hcattr;
 	int rc, i;
 
@@ -1352,6 +1353,13 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
 		attr->fdb_unified_en = MLX5_GET(wqe_based_flow_table_cap,
 						hcattr,
 						fdb_unified_en);
+		stc_action_type_127_64 = MLX5_GET64(wqe_based_flow_table_cap,
+						    hcattr,
+						    stc_action_type_127_64);
+		if (stc_action_type_127_64 &
+		   (1 << (MLX5_IFC_STC_ACTION_TYPE_JUMP_FLOW_TABLE_FDB_RX_BIT_INDEX -
+			  MLX5_IFC_STC_ACTION_TYPE_BIT_64_INDEX)))
+			attr->jump_fdb_rx_en = true;
 	}
 	/* Query HCA attribute for ROCE. */
 	if (attr->roce) {
diff --git a/drivers/common/mlx5/mlx5_devx_cmds.h b/drivers/common/mlx5/mlx5_devx_cmds.h
index 8de4210fb2..6c726a0d46 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.h
+++ b/drivers/common/mlx5/mlx5_devx_cmds.h
@@ -326,6 +326,7 @@ struct mlx5_hca_attr {
 	uint32_t lag_rx_port_affinity:1;
 	uint32_t wqe_based_flow_table_sup:1;
 	uint32_t fdb_unified_en:1;
+	uint32_t jump_fdb_rx_en:1;
 	uint8_t max_header_modify_pattern_length;
 	uint64_t system_image_guid;
 	uint32_t log_max_conn_track_offload:5;
diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 9410211e3b..4e64026137 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1718,6 +1718,7 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 		priv->unified_fdb_en = !!priv->master;
 		DRV_LOG(DEBUG, "port %u: unified FDB %s enabled.",
 			eth_dev->data->port_id, priv->unified_fdb_en ? "is" : "isn't");
+		priv->jump_fdb_rx_en = sh->cdev->config.hca_attr.jump_fdb_rx_en;
 		if (priv->sh->config.dv_esw_en) {
 			uint32_t usable_bits;
 			uint32_t required_bits;
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index f73f6e63ff..545ba48b3c 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -1987,6 +1987,7 @@ struct mlx5_priv {
 	uint32_t num_lag_ports:4; /* Number of ports can be bonded. */
 	uint32_t tunnel_enabled:1; /* If tunnel offloading is enabled on rxqs. */
 	uint32_t unified_fdb_en:1; /* Unified FDB flag per port. */
+	uint32_t jump_fdb_rx_en:1; /* Jump from FDB Tx to FDB Rx flag per port. */
 	uint16_t domain_id; /* Switch domain identifier. */
 	uint16_t vport_id; /* Associated VF vport index (if any). */
 	uint32_t vport_meta_tag; /* Used for vport index match ove VF LAG. */
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index f0888dbf0e..83f55ed3e8 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -9322,6 +9322,7 @@ flow_hw_grp_create_cb(void *tool_ctx, void *cb_ctx)
 	struct mlx5_flow_group *grp_data;
 	struct mlx5dr_table *tbl = NULL;
 	struct mlx5dr_action *jump;
+	uint32_t hws_flags;
 	uint32_t idx = 0;
 	MKSTR(matcher_name, "%s_%s_%u_%u_matcher_list",
 	      attr->transfer ? "FDB" : "NIC", attr->egress ? "egress" : "ingress",
@@ -9342,10 +9343,15 @@ flow_hw_grp_create_cb(void *tool_ctx, void *cb_ctx)
 		goto error;
 	grp_data->tbl = tbl;
 	if (attr->group) {
+		hws_flags = mlx5_hw_act_dest_table_flag[dr_tbl_attr.type];
+		/* For case of jump from FDB Tx to FDB Rx as it is supported now. */
+		if (priv->jump_fdb_rx_en &&
+		    dr_tbl_attr.type == MLX5DR_TABLE_TYPE_FDB_RX)
+			hws_flags |= MLX5DR_ACTION_FLAG_HWS_FDB_TX;
 		/* Jump action be used by non-root table. */
 		jump = mlx5dr_action_create_dest_table
 			(priv->dr_ctx, tbl,
-			 mlx5_hw_act_dest_table_flag[dr_tbl_attr.type]);
+			 hws_flags);
 		if (!jump)
 			goto error;
 		grp_data->jump.hws_action = jump;
-- 
2.34.1

