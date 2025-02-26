Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD23C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 14:02:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF52D4060B;
	Wed, 26 Feb 2025 15:02:03 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by mails.dpdk.org (Postfix) with ESMTP id B38D24026C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 15:02:02 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWl4PGCAmMRgMBgzuodFCuzQ3y3HnbDIB1oavQp0YJ3ZApJxvdZh2kwELwSyu6Jp+s10/8bscZFeYMJf1JrKo39oOatwADlvLqJPJ1gr4ePE+4vvkiUwbi1eFtMeS97Guo5aPvNUFurjGe9MOLhq8yMYbhxThHwm4xdPr98F9XMhK8htdFjgjmOVa9Gkv09ofDUP4zhXrYRDfYPN4UKbeXx7oIuMZiQIzcI1Kcyy8ICpvRz/FR/g1JYsr+9JzxgNBM0oEfZcQ33S2TJ6d8NmcM0QWgq5C0zj8eLf9n+BOhO9YDZk0zlpmhLQ0xe8iYtiIyUs2BdpujJmNJlGppcnWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8k/dlY6JMiPCUdReB0H9t9fEOr/tvOIXEWL8BDtUHfg=;
 b=nLCGPqTnAhd0JS2K93Gi9mnKZ/SP/rTJjIXtD/lE8PxVmjIMf4+LmA/NDC/YkW8Y+faG3P+jmbpfv0eb7WDmRldTBba+kRCpSuNr6VIKF63a3j8pIWJdXkREKioH5rFnZj/ubAwd4JyFNsvcX7iQ0NkbRboZlFYICsKoMSDvrcUelLv6a5gaJn6ppWnUHsr40IINA6YqQXr2ol76ggJJJpVJ9WxqyNVJaTo2bh+ISf2VXejWeBBlr4YfxBNq4rkR0Qk5zF3g9937hGV9YHmYmE5+SOmX08uKKBQJRYr2xR9xgDkFEMF38XFZBBKOIw3tNtjXeSktYZ0tSz3CRU6lfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8k/dlY6JMiPCUdReB0H9t9fEOr/tvOIXEWL8BDtUHfg=;
 b=uCsEojVeOymtJGUfhVmybLXQ7oZ5Y0bKopBc+AZuaRy+EkjKQTEKIcac6NTK9mpG/djXYYSdc5cOXZG2dXE7b6inAkBrcIy+PFGPPSsSCHKvpKndEG0JkolnH4/fR1cFDPgVl5yHbIGKFHV8D4zqWn+HlL1IiuN9eA0URfY9vJtgbXKT2YXB9Y7cNKhB4D4AffEie1M1rFABktELI389iprDV1jGYZboHwPmzM0q5cwBCD/MBQTV70DvAEmFlblYNHD9j7pcPc197Gc/eggmym6hsQbmHpdqy7WBri1oPWX8Y8Du7HGLU/gBSTBeJMrwvvORzB6M9WFLJR+0uQ9KZQ==
Received: from SN4PR0501CA0024.namprd05.prod.outlook.com
 (2603:10b6:803:40::37) by CH3PR12MB9251.namprd12.prod.outlook.com
 (2603:10b6:610:1bd::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.25; Wed, 26 Feb
 2025 14:01:58 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:803:40:cafe::6e) by SN4PR0501CA0024.outlook.office365.com
 (2603:10b6:803:40::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.16 via Frontend Transport; Wed,
 26 Feb 2025 14:01:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 14:01:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 06:01:39 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 06:01:36 -0800
From: Suanming Mou <suanmingm@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>
Subject: [PATCH v2 2/3] net/mlx5: add jump FDB Rx flag
Date: Wed, 26 Feb 2025 22:01:18 +0800
Message-ID: <20250226140119.2142352-3-suanmingm@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226140119.2142352-1-suanmingm@nvidia.com>
References: <20250225004527.2066812-1-suanmingm@nvidia.com>
 <20250226140119.2142352-1-suanmingm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|CH3PR12MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: ee777c9a-968f-4589-8356-08dd566e2252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?akQjfHwCMcojcm1CvTwmTW3/K7VbmqpfBNNHcxtZw34y/kYzOfiHG3IrIzAj?=
 =?us-ascii?Q?EgTADBmp6x5TjMMf8+hZnabebqdQcl7ue0LTnP8Gg6g2H4Qqw9J8IPmcn/zI?=
 =?us-ascii?Q?w5aWzo8L/hp2cn9/e75YHMutMEt1unoVqgGFnYJILH/5GcbbAvjrABePldYU?=
 =?us-ascii?Q?lUM9oi1oTwtXhaJhsWHN8rJfOkb9SFzr7YBdyuVHGMIpJE6MNu/sPhXkCiLT?=
 =?us-ascii?Q?qUZirrawNw7hKT+IfIShVG1sQntRvIQwa33myv5zefie/+Bh/J12evltEYtA?=
 =?us-ascii?Q?CIi+mIX64kSxk9Qx6td0z4yjAj0FIwiwdLJGXvAEqe9mTK2kPSbXp/gNDNXV?=
 =?us-ascii?Q?PsGlXzNeh2lWner+RtU6L+mQqMIDIgKNd5yySTzw/ZR7+pGMMmuDSxOoayAQ?=
 =?us-ascii?Q?yfrRexBDnLim6ZaUDPCN1Vp6drS2iGDw25T31vMRd29Nkp5djUm3x1BkP71n?=
 =?us-ascii?Q?8LQh+R13/WrCDF0Gz+ONnxnVM6MfRH0BivTHSqWeTLRJXvDG0QMTSFR14Vab?=
 =?us-ascii?Q?KqP6VBCd0Gf37mRQV5IavGfruG7mWmzFdVIXGU9uesw7X1sGYNXfiSzgCl4/?=
 =?us-ascii?Q?HuMSS64ouNhzNhXrGST3dXF7Zs7iTXaT9XZ32Xz6OoOsZsoAYCegwL1V07rl?=
 =?us-ascii?Q?WWpPr2BEuzKBcZhzsd7w4V2nkS/pBJtgpLvAjD7X8YKuY9MbH/XbDB9dvAvm?=
 =?us-ascii?Q?cw/nuOu/aw99bBqg6VjBm/YAxHVoKNls7S0L/JwNyBlWu+6oLbdCudQsddmA?=
 =?us-ascii?Q?ybo2bQQLTufwFkgITNTlyNivCtLWMSr2WVbItbx6ggPGoVkg1XsLBAiSkmHk?=
 =?us-ascii?Q?ynbC7jnRx4CbanqyEVjFpDdXmBFnfLpZ4tan196ZOqC2LUt6I4Qfa6A9cH6Y?=
 =?us-ascii?Q?OqbDTAJdkSSQAM5yxBO/r9YBLGL09OuXx1kLi8FYSEcPwiTNcgKhvuZtMbXd?=
 =?us-ascii?Q?LS2Bt9yaRJeTR3VO6+0j14QSBAS6v3utVGT/QAwAVeIVLpzdWg6R8i0KHEx2?=
 =?us-ascii?Q?sFsJyuKW6Yta/KtTkcxL0yhRUULupi+2I7vmVaVJ/Ty+vR0l6axEQTX6ce80?=
 =?us-ascii?Q?7gF5qTi4H32kS/4iAn9xbGHsS50q4FMgtOh4+jYpM1SQFMvqINcXYMOMeGYr?=
 =?us-ascii?Q?r8zTejfL1P4yntmwLY2DjCgUA1O/GnA0j+4DvTyPU2gbs/sC6oMsNKr+xGWb?=
 =?us-ascii?Q?nh/az85wLKkLBkuWF8nkNqPO25doWFQoLX0y/KXt/EC4/mnHPsNERIYU1W3z?=
 =?us-ascii?Q?4w4/xQIFucb117kxFSwg2viu9IOCbhT4lRfAnBUKhdcFT/jPk1W40mUIY2wn?=
 =?us-ascii?Q?9QbeFGdXKa61xtOC+nMQ0nEuIqWC7EqNgHq9urXS7RKvEMw9KUWejdcj5p18?=
 =?us-ascii?Q?8m9irXf5Qu8pU9xL5UhQEBSG2rVeLAvZQCc+GdzCg6Hb1Ut0O47d6K1FCZyO?=
 =?us-ascii?Q?ISb4btYBrJjBDhe8FJOGQw0zUYTito7Z53553EEZ+Qa5/SAPMoG4MqqA/Ssh?=
 =?us-ascii?Q?sgq7678J+mEAGBA=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 14:01:57.7296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee777c9a-968f-4589-8356-08dd566e2252
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251
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

v2: fix bool and update log info.

---
 drivers/common/mlx5/mlx5_devx_cmds.c | 8 ++++++++
 drivers/common/mlx5/mlx5_devx_cmds.h | 1 +
 drivers/net/mlx5/linux/mlx5_os.c     | 9 +++++++--
 drivers/net/mlx5/mlx5.h              | 1 +
 drivers/net/mlx5/mlx5_flow_hw.c      | 8 +++++++-
 5 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c b/drivers/common/mlx5/mlx5_devx_cmds.c
index f504b29f31..440820fd4f 100644
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
+			attr->jump_fdb_rx_en = 1;
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
index 9410211e3b..77f17f1a14 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1716,8 +1716,13 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 		 *   4. all representors in HWS
 		 */
 		priv->unified_fdb_en = !!priv->master;
-		DRV_LOG(DEBUG, "port %u: unified FDB %s enabled.",
-			eth_dev->data->port_id, priv->unified_fdb_en ? "is" : "isn't");
+		/* Jump FDB Rx works only with unified FDB enabled. */
+		if (priv->unified_fdb_en)
+			priv->jump_fdb_rx_en = sh->cdev->config.hca_attr.jump_fdb_rx_en;
+		DRV_LOG(DEBUG, "port %u: unified FDB %s enabled, jump_fdb_rx %s enabled.",
+			eth_dev->data->port_id,
+			priv->unified_fdb_en ? "is" : "isn't",
+			priv->jump_fdb_rx_en ? "is" : "isn't");
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
index 07d36bfb8f..cdb3dd6420 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -9350,6 +9350,7 @@ flow_hw_grp_create_cb(void *tool_ctx, void *cb_ctx)
 	struct mlx5_flow_group *grp_data;
 	struct mlx5dr_table *tbl = NULL;
 	struct mlx5dr_action *jump;
+	uint32_t hws_flags;
 	uint32_t idx = 0;
 	MKSTR(matcher_name, "%s_%s_%u_%u_matcher_list",
 	      attr->transfer ? "FDB" : "NIC", attr->egress ? "egress" : "ingress",
@@ -9370,10 +9371,15 @@ flow_hw_grp_create_cb(void *tool_ctx, void *cb_ctx)
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

