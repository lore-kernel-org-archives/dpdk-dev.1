Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FB3C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 14:02:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 770394066E;
	Wed, 26 Feb 2025 15:02:11 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
 by mails.dpdk.org (Postfix) with ESMTP id 0853240668
 for <dev@dpdk.org>; Wed, 26 Feb 2025 15:02:08 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqYVpAYrKe8BFE986Q1cYtKRIVIJoTvIrBKarfJZNjNwODqZAZgPt2zemeUrJV6D3u6H2yfIwElC9WQ5ubjh3PAtIPsH8k85QJVijzsz/TfxWMo5WpqgqvEYYtclVb/PhI5xrHaTVJzg7S8+E30dzrvO/6KgDJjeSZ5ZNA1jN1Lj6UnynN0m7+l59/nV4oH97ScQ0U5scrbcDgklP9FxfEXRzDfOrFBVrFroSo0bj3lX8JyfKhDL4/d7MvzdVkyrd9VdSZ6iZTKJuMF/zSSuJIHP+M2wJgJVtErcDvA/GbyaPTvBP8oxLg93aZJ/HKpbuEYe0/4n7HI1AtutZYO6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdxYoBJj41i374leX+kNvWgWxp4jW0PvmyDW+6fanfI=;
 b=xCPTr2XPACU2DttZ0bFGZK0dIsgCmqTUzW+B7IbqLynfA6KalS0z1OETJYuJTjU1DdEMw2SN8iSaLxrlgzEsxqVQTkrVM5JhptOzrtgNoSxPsbi5FP04Dftji9vV1+jBFQeW9gWUslJX4Hffq0Q/dGkIlLkwlnrhNdsgbFaxKyhBMf/kBKito+5j5zikcV/k1LTojJ3i4u3hFmqs9nWeVCzk9P7zBUKUQMJu30SQDLTtQOodDSUXXh8DWHMeEQx35/EubTVoAjcYnSe+AXUfG2rhwBk7Em1QRdmPRkACOAhlpRZRl/s3lNAZ1zJw2GmyoP3Z2mo0DmTcXX/i5K2zfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdxYoBJj41i374leX+kNvWgWxp4jW0PvmyDW+6fanfI=;
 b=YrX15Fc0zG955FHmR4bM97zBgvp6gc1TBzmcBKNzPSTVPflvB40lui3aQ6706gn5hdPWfgTp4WL3G4bDkpyHFuHXCkSr2VCGTH+jKgVvk26AXv4FQDWf1i35araw0U61+OsNDEB6lpdSRwu7f7B6fDGhrXoi6BaZ5T3ofw7tR5V3GMCbGMMSaCMtqvkdBUh5fZ4B2cC0jZshd98zppTPmhURH5/nAlMXmHfcHbR6VKh7MMQsWnIsl+EmbuwZji41HBbAyCeGEuD4a35Zwwd/SHPOGNmp0fYW+YLuJq/+2HAj82v+BHTDJyWwrQsKoHI/Rc6+mG1w6KjRa+RuvGpb/Q==
Received: from DM6PR06CA0098.namprd06.prod.outlook.com (2603:10b6:5:336::31)
 by SA3PR12MB7903.namprd12.prod.outlook.com (2603:10b6:806:307::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Wed, 26 Feb
 2025 14:02:03 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:336:cafe::da) by DM6PR06CA0098.outlook.office365.com
 (2603:10b6:5:336::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Wed,
 26 Feb 2025 14:02:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 14:02:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 06:01:41 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 06:01:39 -0800
From: Suanming Mou <suanmingm@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>
Subject: [PATCH v2 3/3] net/mlx5: allow FDB RSS
Date: Wed, 26 Feb 2025 22:01:19 +0800
Message-ID: <20250226140119.2142352-4-suanmingm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|SA3PR12MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd7b05b-b2da-4902-6784-08dd566e2547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BpqrMdcMywmXsFU9tXtJSlnDiM3XTdI7BjrklrGjtvaKU5JQOlLSBZ2svbHx?=
 =?us-ascii?Q?QwxoyyBifjVDF95mZ3TfMY0kWSNBWmD/2tjckfS5322tq1K6GBaz8bxCxnOI?=
 =?us-ascii?Q?gbKQ9gW899E3t7JsXnZ3Q4mC8s30aYuyQXxnHBDC2vi8XdvOnhb+u5erhDpc?=
 =?us-ascii?Q?C52EuWotZ6P31SgcKRg5gPLw2l0hhp34TafUcLiSYyGqWysUMUqtR2Ace8b5?=
 =?us-ascii?Q?keXIMgPKPxxyRfjwUMKX3gurt3qnbyXdnNatD4HNf7McHFt3lutcgog65WjW?=
 =?us-ascii?Q?TAb9eRheX5RnaXJWorcOBnIh7oOuQwcrWlKD5N/BzFHCjkAe9zA/vdtHpoSB?=
 =?us-ascii?Q?6dLUPgyP0AzkCJcAiOGfjVjMT/P2UR5fuPx2jp2cLBA44zpU7ELfW0CdgPY3?=
 =?us-ascii?Q?jSHtKeSxhZbsOsoPgthbvcPKgPWNcLDBVSikneH/rEqZHxL4/Bntt/Hzjkmw?=
 =?us-ascii?Q?siZWjCSpZiTMaM/jXthQB+H7NCQENqb0fJrPbwQ46MSrKseS94sbEE9+ad8u?=
 =?us-ascii?Q?yi2v6c1B9SlWIUw+QT6CDNWaKsPQHnhMC50vq9PJ1hC5AbReaGSJW3QuQZRa?=
 =?us-ascii?Q?OCoDaCacikl8Lb7H39wMlpz3XBf1LF2Sf/fMv2RayVjsX2NG8udyEd7ggpiu?=
 =?us-ascii?Q?70/gs6NJDMa2YxAREtC4OU38ZrV3g8Yf6ZwOGgWIPTiYf4Zn8zIiqsomd93M?=
 =?us-ascii?Q?6cyd3+BeAvp1KkFq/L/5+1Vc8oI7JfVnCS4mAAM4QSWv/AQvEw/4eKcuU4uM?=
 =?us-ascii?Q?eWMrt+47vNgsZJn8mygBLQvlY1SgmOmAA5HRiP8NNHLvSLoRAC/MlGMvZiC2?=
 =?us-ascii?Q?HhNMvqSyYf/kKHlsjsC5IfII1VLutZ1yRj4DFf56VFCxoLenLJrTJCjL5mfI?=
 =?us-ascii?Q?1dkpB1jkbv8ze6Kud+fNCKJlrgOHG9DDuj6LBdo570ajayrqHU0908n7GbxI?=
 =?us-ascii?Q?Uv5qWN+ceLfDfVrDdD48NNdPedNEZG6XTMRq7JV5e3GIgAOYbEcg8uD8jmIt?=
 =?us-ascii?Q?24fSaOZR1ojkcROSBcHM87XpgPkP7U2ZI3brPdy64T5m0tCUjmwg/iM7W5WI?=
 =?us-ascii?Q?MXzE7ncVtGaryNUryzzjZzJGtr/Bk1hLLqET7RHykZjS+ECWfuaPgBTDJi/s?=
 =?us-ascii?Q?HmoG/fbLdAZyw9P4Ma44Gq39KL31M6/ST/jTNcbtYuuXPQv5FPkeUjOy5Wva?=
 =?us-ascii?Q?AzLc4eMhfy+9eqI5mawmrL1MQto78TUOC4Cliu7QoUAvHf/YcgsJmd5Ri+v4?=
 =?us-ascii?Q?17H2ZNmla7Tx/uZbFlUb0c9Ezgx1GzWzC6T65eEkO8x9GDNvMq9NmXTDt3cC?=
 =?us-ascii?Q?jrW6wZ3qpbt8OXb5XotUnKAxOC0JCJzK077Yx/RjU4UlPcxWVgWFCpSgm8zk?=
 =?us-ascii?Q?iJumbB3M1xRlklRQ87eP/9r52RL7DBvXwxwfGcHttIQ18h3QMYfY71Z2Qmpr?=
 =?us-ascii?Q?PPIdWSj90jJJjMXN97VJrboe9q7MlA9Ai4GnSwY+a7nJhxzgoiW5zz/TPtFE?=
 =?us-ascii?Q?+GuWszlPFoqSr1s=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 14:02:02.7056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd7b05b-b2da-4902-6784-08dd566e2547
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7903
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

v2: update limitation.

---
 doc/guides/nics/mlx5.rst        |  4 ++++
 drivers/net/mlx5/mlx5_flow.c    |  4 ++--
 drivers/net/mlx5/mlx5_flow_dv.c | 32 +++++++++++++++++---------------
 drivers/net/mlx5/mlx5_flow_hw.c | 20 +++++++++++++++-----
 4 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index d40878e336..0371a397b6 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -968,6 +968,10 @@ Limitations
   The flow engine of a process cannot move from active to standby mode
   if preceding active application rules are still present and vice versa.
 
+- Since only when unified FDB is enabled, there will be FDB Rx/Tx, jump FDB Rx
+  is valid only when unfied is enabled. And in unified FDB mode, the tag and RSS
+  actions are only allowed in FDB Rx domain.
+
 
 Statistics
 ----------
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 69d7621d0b..f8b3e504b3 100644
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
index cdb3dd6420..25a59076f5 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -7036,6 +7036,7 @@ mlx5_hw_validate_action_queue(struct rte_eth_dev *dev,
 			      uint64_t action_flags,
 			      struct rte_flow_error *error)
 {
+	struct mlx5_priv *priv = dev->data->dev_private;
 	const struct rte_flow_action_queue *queue_mask = template_mask->conf;
 	const struct rte_flow_attr attr = {
 		.ingress = template_attr->ingress,
@@ -7044,7 +7045,7 @@ mlx5_hw_validate_action_queue(struct rte_eth_dev *dev,
 	};
 	bool masked = queue_mask != NULL && queue_mask->index;
 
-	if (template_attr->egress || template_attr->transfer)
+	if (template_attr->egress || (template_attr->transfer && !priv->jump_fdb_rx_en))
 		return rte_flow_error_set(error, EINVAL,
 					  RTE_FLOW_ERROR_TYPE_ATTR, NULL,
 					  "QUEUE action supported for ingress only");
@@ -7063,9 +7064,10 @@ mlx5_hw_validate_action_rss(struct rte_eth_dev *dev,
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
@@ -8114,6 +8116,7 @@ __flow_hw_actions_template_create(struct rte_eth_dev *dev,
 	}
 	if (priv->sh->config.dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS &&
 	    priv->sh->config.dv_esw_en &&
+	    !attr->transfer &&
 	    (action_flags & (MLX5_FLOW_ACTION_QUEUE | MLX5_FLOW_ACTION_RSS))) {
 		/* Insert META copy */
 		mf_actions[expand_mf_num] = rx_meta_copy_action;
@@ -12140,23 +12143,30 @@ __flow_hw_configure(struct rte_eth_dev *dev,
 	/* Add global actions. */
 	for (i = 0; i < MLX5_HW_ACTION_FLAG_MAX; i++) {
 		uint32_t act_flags = 0;
+		uint32_t tag_flags = mlx5_hw_act_flag[i][0];
 
 		act_flags = mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_NIC_RX] |
 			    mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_NIC_TX];
 		if (is_proxy) {
-			if (unified_fdb)
+			/* Tag action is valid only in FDB_Rx domain. */
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

