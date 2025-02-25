Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2891AC021A4
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 00:46:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10F19427E6;
	Tue, 25 Feb 2025 01:46:26 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by mails.dpdk.org (Postfix) with ESMTP id EA38740EE2
 for <dev@dpdk.org>; Tue, 25 Feb 2025 01:46:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cii6kro/UQV5mwfXXc/rC2abXJKNnMVGqaR8uykiB0sZsonaojidYkZ3an7SAVQv5RL38YRJOACSrTHF9KARJeZ8CtRvE8PjXkN0NzVFhdR8RNkfeEoTSHFvr82s35gjxrP3Y3N4ClLDj04A3y8a/ySqPSNrDNzAC2d9M8XJQBHu1lTDrFdyPvqQ6jjBGuOmqbs5q4rVbs8MS3QTXfJBlVJ1IwsEHihARrIZE5sVo/mSL/DnoQufzBpGiKXtK9adSlIWUF+7cOnDf2QuzG13x10aonnVZY9KmiVuBTKZztlksZU+WW8KkjS77iIyo9reNFGeejDF6p3/I/UIXGsJsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pef/6tsk1+IiBeZnlclvaXSmIbVJn9/f/3aNLwus9Jw=;
 b=rNuxGGxsYQq/XI5piUeCkHYbU/fCWZCx21v16HzG2ZIr6zM3Icm3KDM/ENUi2KgKMstUXf3GJxOQHj+u53WFos5I4rAhh67YapM2ZjqncR2URd1OBr/pzitt+Kn9g8TB0sVz9TRcR2u5pdKD98W44myhOYt+5OCzFP/Ta7PC5ccTGkP2XCrzzVTA/FwGxQG1tzQM7nDl9DL1BeYBy5iRZHeCbSdtAGUOOjZ1dWXBpOkZf9CbsQvuFypcUci2MSu3+ybrE5dE5npbDDnfJhv5u+surR5b6Glz/g14e2QlhCL+6PcB1j4o5kZXtPy41vR/SK7fAq0Y04Z/xpOiZg9Tuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pef/6tsk1+IiBeZnlclvaXSmIbVJn9/f/3aNLwus9Jw=;
 b=iQdVLdCqpt0OVtR0xTyKe7FrYExxWVImgRx6C6BKG8wtdxvdUJXEz7/lCP0+pST2FQeQQZJ9amx19ox0hDS0TJpJlV8nbhZKMkTvetqKSiIPNkHu47ZM6PmQfrdcMC9mnLOo0CH0o4+ka+ousXrDZ8EnuMqevy7koba5yHVJUH4Qw2mSGD3+KxADyvCz6bkPrwd+MCYMPy5Yl1fL3EKI4UkmpxixHlh2gGlTkImVyaRO0FmFc0IrWhM3UPVU1AwbdwbdrL2q73MeDlHIA6cRvWspJ2ozDq7qiF3PjDA9vdxJrAwPWLwneCJy2KQMa0mjFlRvLZMLaYxTJYTD+3E1rw==
Received: from SA1P222CA0183.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::7)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 00:46:15 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::16) by SA1P222CA0183.outlook.office365.com
 (2603:10b6:806:3c4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.22 via Frontend Transport; Tue,
 25 Feb 2025 00:46:14 +0000
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
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 00:46:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Feb
 2025 16:46:04 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Feb
 2025 16:46:00 -0800
From: Suanming Mou <suanmingm@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>
Subject: [PATCH 3/3] net/mlx5: allow FDB RSS
Date: Tue, 25 Feb 2025 08:45:27 +0800
Message-ID: <20250225004527.2066812-4-suanmingm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|CH2PR12MB4040:EE_
X-MS-Office365-Filtering-Correlation-Id: dd12b6df-7473-48ba-954f-08dd5535cec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kXKlkCYSeXirMrLa+qc181jORri4t3ShuR5mAA1wLTLl3nMke7f19xc5pHvC?=
 =?us-ascii?Q?o5FBk/+LyR334XfpjcTyAEqFFSyIrpTks99K5+C+2CKXc5NgRhOmPKS/F4+i?=
 =?us-ascii?Q?gvsHWBL341DHgg7nJXrQ48yCvGFjW0COwzZmF0/T24OidLUhj5amDzFLYHqD?=
 =?us-ascii?Q?VMef7P9qv3ptOJKeZYxBT26XTRqwIuVF//5FXI/taNhCyEnGeyKsYONU9KBy?=
 =?us-ascii?Q?ZJwxphjlhsf/pVfKNkA5sJuMRQF5DVVjjZ4OtfWNmv3qD/QFvPBf9W4lDYs7?=
 =?us-ascii?Q?6basSdJFqIdn9OChpUvQYHYzWNgmQNMK4FgO5BVFUVvtnef1dMJl7UF9NPVD?=
 =?us-ascii?Q?/c85ngPzaIRksgcq1+mL+eCxFgZHeRVNkJAVRdtuq55UujPQjvhMFsz+IbNx?=
 =?us-ascii?Q?VWdWdid1ctOeLW1d6P+dPJGWpYkEw6Coc71ZvvnlkW3mXcLVjjw6Uwj6toUJ?=
 =?us-ascii?Q?9s2kIAedyGu9lF9C6PzveOiboRNyRB0PmUSK5ZEZJymuU1e8oGAAmlI2u+CL?=
 =?us-ascii?Q?0ANSS/t90J3Vp+mH+TGVcTuLUoHQ4dFPKeTJp2Y/Pv6wZVW0wxCRRayDZn3s?=
 =?us-ascii?Q?UBRqKSW8SP8DGhAqqr9sUWlzr5lzS3WQo5rnfa+/DjXLNK6MJyJDwSa0Dq6k?=
 =?us-ascii?Q?w/XinfsMk7Q6y0ieG1d4BRB9HkVpX6m13d5bkUOkYAV2/5DhOtWth/Afnmcb?=
 =?us-ascii?Q?L1G6I77v1ifXDQaVFuUgTIBQQFvc7ma9DmjJgERJhnyouqukhsfhQXEfsrsP?=
 =?us-ascii?Q?vEPL84y1qLanpbp0f6Bt+OxTPCY0rFJsrs0IrTIX24aEYhCHDbuxMBX2lXME?=
 =?us-ascii?Q?xaB7BYplcCq1mD8VB90BS/pCt8x545HGHPrnkxMShPFJ0LTn7HWYhwZKBa9E?=
 =?us-ascii?Q?v8EvEnnKt8fMalUeGGtPhkrvHWEuKPgyxtuVif8C0/vo0Ub7Lr9q6fGUSTEy?=
 =?us-ascii?Q?Gs2lQ2jsqk4GpDbQvAOTV4taROoTe/6CYN3PcXgL7v4VndVBlwaybTy4UXyv?=
 =?us-ascii?Q?UR+9xoVTtofR2MsADqEDI4LS+2K1+dTbah+dv57cnI5aN+RrWhEZbml7NPol?=
 =?us-ascii?Q?yjtYmX7YnDD9WpABpcUVyCax/1i6OM9JZ6LyyYXUST01NC2ONvnHEQMjdD8R?=
 =?us-ascii?Q?IcHSRxE9XVkc0R2R6cQvRVc3iUnr5jngCVXllQbRhGYomgFW/QPRpJQqCwSE?=
 =?us-ascii?Q?LK8sij3CQwRwBIrmnv9i3ChRS7bNgZiw3W3/fXLNBTj8U3zHMk21gFNHGAIM?=
 =?us-ascii?Q?pAJ+qPS2xawhtARMXiAespIRnqqxFRbxMnflVd4r2aqwIy68D3RAXrOJ+zW8?=
 =?us-ascii?Q?kWNKIhPp5KYLAlHzRJyVyprnUILSyrSJW3Lxa/kQ3MEcaKSQSsag6Lh584To?=
 =?us-ascii?Q?7kH6RlBcYyozDaPU+lBZ9QaV7EzSySbSJY2NlF3f3rXHIv08S+1ZgEVO79eq?=
 =?us-ascii?Q?JlLZLGocQZ1+icq4LTZdaNWdsbVcu15EPQ6Cm9Xab9r299MOQxFKdw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 00:46:14.5155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd12b6df-7473-48ba-954f-08dd5535cec3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040
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

RSS can be used in FDB Rx rules when JUMP_FDB_RX action to allow
jump from FDB Tx to FDB Rx table.

Different with NIC RSS, FDB RSS will not do the internal implicit
metadata copy.

This commit enables the FDB RSS if JUMP_FDB_RX is supported.

Signed-off-by: Suanming Mou <suanmingm@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow.c    |  4 ++--
 drivers/net/mlx5/mlx5_flow_dv.c | 32 +++++++++++++++++---------------
 drivers/net/mlx5/mlx5_flow_hw.c | 19 ++++++++++++++-----
 3 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 3fbe89a9d4..9c6a4f39fb 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -1977,9 +1977,9 @@ mlx5_flow_validate_action_mark(struct rte_eth_dev *dev,
 					  RTE_FLOW_ERROR_TYPE_ATTR_EGRESS, NULL,
 					  "mark action not supported for "
 					  "egress");
-	if (attr->transfer && mlx5_hws_active(dev))
+	if (attr->transfer && !mlx5_hws_active(dev))
 		return rte_flow_error_set(error, ENOTSUP,
-					  RTE_FLOW_ERROR_TYPE_ATTR_EGRESS, NULL,
+					  RTE_FLOW_ERROR_TYPE_ATTR_TRANSFER, NULL,
 					  "non-template mark action not supported for transfer");
 	return 0;
 }
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 633c41e358..61d3101ce8 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -8939,21 +8939,23 @@ flow_dv_validate(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
 						  RTE_FLOW_ERROR_TYPE_ACTION,
 						  NULL,
 						  "unsupported action MARK");
-		if (action_flags & MLX5_FLOW_ACTION_QUEUE)
-			return rte_flow_error_set(error, ENOTSUP,
-						  RTE_FLOW_ERROR_TYPE_ACTION,
-						  NULL,
-						  "unsupported action QUEUE");
-		if (action_flags & MLX5_FLOW_ACTION_RSS)
-			return rte_flow_error_set(error, ENOTSUP,
-						  RTE_FLOW_ERROR_TYPE_ACTION,
-						  NULL,
-						  "unsupported action RSS");
-		if (!(action_flags & MLX5_FLOW_FATE_ESWITCH_ACTIONS))
-			return rte_flow_error_set(error, EINVAL,
-						  RTE_FLOW_ERROR_TYPE_ACTION,
-						  actions,
-						  "no fate action is found");
+		if (!priv->jump_fdb_rx_en) {
+			if (action_flags & MLX5_FLOW_ACTION_QUEUE)
+				return rte_flow_error_set(error, ENOTSUP,
+							  RTE_FLOW_ERROR_TYPE_ACTION,
+							  NULL,
+							  "unsupported action QUEUE");
+			if (action_flags & MLX5_FLOW_ACTION_RSS)
+				return rte_flow_error_set(error, ENOTSUP,
+							  RTE_FLOW_ERROR_TYPE_ACTION,
+							  NULL,
+							  "unsupported action RSS");
+			if (!(action_flags & MLX5_FLOW_FATE_ESWITCH_ACTIONS))
+				return rte_flow_error_set(error, EINVAL,
+							  RTE_FLOW_ERROR_TYPE_ACTION,
+							  actions,
+							  "no fate action is found");
+		}
 	} else {
 		if (!(action_flags & MLX5_FLOW_FATE_ACTIONS) && attr->ingress)
 			return rte_flow_error_set(error, EINVAL,
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 83f55ed3e8..a063e5ac9c 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -7026,6 +7026,7 @@ mlx5_hw_validate_action_queue(struct rte_eth_dev *dev,
 			      uint64_t action_flags,
 			      struct rte_flow_error *error)
 {
+	struct mlx5_priv *priv = dev->data->dev_private;
 	const struct rte_flow_action_queue *queue_mask = template_mask->conf;
 	const struct rte_flow_attr attr = {
 		.ingress = template_attr->ingress,
@@ -7034,7 +7035,7 @@ mlx5_hw_validate_action_queue(struct rte_eth_dev *dev,
 	};
 	bool masked = queue_mask != NULL && queue_mask->index;
 
-	if (template_attr->egress || template_attr->transfer)
+	if (template_attr->egress || (template_attr->transfer && !priv->jump_fdb_rx_en))
 		return rte_flow_error_set(error, EINVAL,
 					  RTE_FLOW_ERROR_TYPE_ATTR, NULL,
 					  "QUEUE action supported for ingress only");
@@ -7053,9 +7054,10 @@ mlx5_hw_validate_action_rss(struct rte_eth_dev *dev,
 			      __rte_unused uint64_t action_flags,
 			      struct rte_flow_error *error)
 {
+	struct mlx5_priv *priv = dev->data->dev_private;
 	const struct rte_flow_action_rss *mask = template_mask->conf;
 
-	if (template_attr->egress || template_attr->transfer)
+	if (template_attr->egress || (template_attr->transfer && !priv->jump_fdb_rx_en))
 		return rte_flow_error_set(error, EINVAL,
 					  RTE_FLOW_ERROR_TYPE_ATTR, NULL,
 					  "RSS action supported for ingress only");
@@ -8104,6 +8106,7 @@ __flow_hw_actions_template_create(struct rte_eth_dev *dev,
 	}
 	if (priv->sh->config.dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS &&
 	    priv->sh->config.dv_esw_en &&
+	    !attr->transfer &&
 	    (action_flags & (MLX5_FLOW_ACTION_QUEUE | MLX5_FLOW_ACTION_RSS))) {
 		/* Insert META copy */
 		mf_actions[expand_mf_num] = rx_meta_copy_action;
@@ -12112,23 +12115,29 @@ __flow_hw_configure(struct rte_eth_dev *dev,
 	/* Add global actions. */
 	for (i = 0; i < MLX5_HW_ACTION_FLAG_MAX; i++) {
 		uint32_t act_flags = 0;
+		uint32_t tag_flags = mlx5_hw_act_flag[i][0];
 
 		act_flags = mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_NIC_RX] |
 			    mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_NIC_TX];
 		if (is_proxy) {
-			if (unified_fdb)
+			if (unified_fdb) {
 				act_flags |=
 					(mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_RX] |
 					 mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_TX] |
 					 mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_UNIFIED]);
-			else
+				if (i == MLX5_HW_ACTION_FLAG_NONE_ROOT)
+					tag_flags |= mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_RX];
+			} else {
 				act_flags |= mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB];
+				if (i == MLX5_HW_ACTION_FLAG_NONE_ROOT)
+					tag_flags |= mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB];
+			}
 		}
 		priv->hw_drop[i] = mlx5dr_action_create_dest_drop(priv->dr_ctx, act_flags);
 		if (!priv->hw_drop[i])
 			goto err;
 		priv->hw_tag[i] = mlx5dr_action_create_tag
-			(priv->dr_ctx, mlx5_hw_act_flag[i][0]);
+			(priv->dr_ctx, tag_flags);
 		if (!priv->hw_tag[i])
 			goto err;
 	}
-- 
2.34.1

