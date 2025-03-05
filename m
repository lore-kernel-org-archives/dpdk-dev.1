Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE956C19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 13:24:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE814402A4;
	Wed,  5 Mar 2025 14:24:31 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
 by mails.dpdk.org (Postfix) with ESMTP id E4D7A40275;
 Wed,  5 Mar 2025 14:24:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewjqmcPRtN2B3qeIXEHmSSoUIbWjx6AnTUC0u5Zcj1Jo1Rss2oD9Vsc/6jhII5n06LuyoQ2Ek+tzaykU66BdZtjKMaTgwLL892SDCKF8jWMmRpZsEqlfzqVRgxh18vwW5DWv0gJcXlL0BckQf1z+hIJVSjwQ8nWNahuwk9fpKZ0zmiwhrM5rnFrL3sQ0FHCuepN90Zj77i+2TuY+93x9d+FRZcwDETw5A1XjdduQJ232kGvVWxgeZ6GYSESuEWtbBXLz64Ib1pzbRYB3yFCnMdcnP9VCGEj95uxmcfKQOqfiWTjR4KgE2StpwoV9KUP8hX+dXhJ+7lJihi5wjPW6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbJu7YfLbRnFmvuM9dynO9DDGHlqVMMpCAquSxD6K4s=;
 b=sf8Ilhk7VekCNRpAE4DSGvKBaHhB//5noCgb4nGjMuv5r6hLB9D1B9ej6/Mh7qs6mKFD59JKH2c+LJKZsRMDtGWTfEI0uw+I11aMQYgIrRduDlbNUsynvzB+eGIe0R7IWRVxaYprXYBQFWFJkbKZN4sve85a5ccTuHOW3WOuRSqd4kpAvw31Q3ft1XUWuSxvuOge9Cpw/geJQzikSWRQyhZrtx+tcubGKPsUFsvhJsK+IvADTw9pF1mhUifL/+OEnIPJ5CO1ge6TsvcIJ1Kc0sWdIAJ5Ws9TKzofPxwFpXhjF8wNXt60/FovUP7Lu2evHXHgtj6SnwpOYaryZsG0xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbJu7YfLbRnFmvuM9dynO9DDGHlqVMMpCAquSxD6K4s=;
 b=VMyuEcq1SgJy/SXwRRF4smDj0RHM92+jbEAvEeriuaD0aqINxtmbO8+caerEJKWRJYmh5iUjs765A23YTZSD/fCBybU3Exh1fihtwilnBTYfzj9MYKAFR9TdqoQ7apMgziKsZ+a0X+hfaHvDnpui3lChwU2pyZoCDu+LB/br/Y5AJCaUS5dUgjToHbYCcPyyCKrdrGXl4nMdFSix6zCH2FO9z6VRYOgXT4ZTRQ9d5sr2fXpxnYAFT54BT9f5BGgtZPbvu4RrVHNU2lcFhgQrMYuEDULN7S+4VopxnfLjUgvsj23nH0p2uNN3pQqhbPAfADXgp+3i0+fLMz8qpxpm+g==
Received: from BY3PR10CA0001.namprd10.prod.outlook.com (2603:10b6:a03:255::6)
 by DS0PR12MB7747.namprd12.prod.outlook.com (2603:10b6:8:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 13:24:27 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::c6) by BY3PR10CA0001.outlook.office365.com
 (2603:10b6:a03:255::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 13:24:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 13:24:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Mar 2025
 05:24:11 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 5 Mar
 2025 05:24:09 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Erez Shitrit
 <erezsh@nvidia.com>, Alex Vesker <valex@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5/hws: fix incorrect DV FT type convert
Date: Wed, 5 Mar 2025 14:23:52 +0100
Message-ID: <20250305132353.46724-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|DS0PR12MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: accd8b64-696f-45ec-61a4-08dd5be90d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NMpBHzM5bfdLQit7+Bhj5ZCHzUSKEBi9WV49nUn/DdwTH0fWirHDrpfllfcr?=
 =?us-ascii?Q?OVfQnVmWbD993z6JaAYv+JAquMEMzW1m3hXNSoZPz0923rpsiXQTequoVH7P?=
 =?us-ascii?Q?ouyb3LK7wSkrTyka7UBjy0JOOvfvECTGYDVffxbl/jMWhi+dokpunkC7SXly?=
 =?us-ascii?Q?p6gTyDsbE3+L4XE76d3Vz3+P+6VzmZJwJDnqsqsp/3C67zuVQxCbeoiSA4I3?=
 =?us-ascii?Q?u4xsaRI1/s4MXVoW0UM188Pc2eUhpPQmhwnTr8TahqpN9ZMDkvEL3DwqpJSm?=
 =?us-ascii?Q?yEYYs6PszkgkQOXnNNwIo2jYunHHxFKQBcxL6ZQFPT12YjcoxiuSdiAPaXvB?=
 =?us-ascii?Q?9DWaV4WXIlB+x59NCMVzirVIILFYR5iKLEECYpKSSmWJ3riLwFOi5fwe7Y/k?=
 =?us-ascii?Q?ZY9YIgIjgih3NNbPKS59eioXRAKOvC32G14PQ7mmaBgoEfg59gc18lebJuk4?=
 =?us-ascii?Q?Hazjb5XyVDaLveF69aHBkPhkEcMOEQ5zGyQarzenubtSD/dT8LnnsN7SITWO?=
 =?us-ascii?Q?yDkmdopXdt0CVO3Mye//lFzI9cKawPVdZ0gLbDNNm3VH6oFzOPARGBaM7kZ4?=
 =?us-ascii?Q?RYS6u+o5H9epYO2ABnnd3yGUj/kW/zrO3441VGTMhpkpINKg5tAiNdCzdJA9?=
 =?us-ascii?Q?/RpEvGIKe21vkCFOTZHsyoLQjQrdfDRMNzSZGOrlnN8cGDySdgMvVH/H3v1/?=
 =?us-ascii?Q?WSpPZMFpRKj7ZX/T2fCc/dqinIT4ayFoDB0TcXvdWlB6aRnyCQNV8liotzJP?=
 =?us-ascii?Q?U99aFJv6c2YCAWKYcJNNm1Fa0EemobzQVLvDTV3MRjvvCHQXj7cj+7EuwBf5?=
 =?us-ascii?Q?oY3QwapHozqtOCquCiyMXHIAoht/fUYtiRBmB1cDb4aeJg8vhO5sQR5VFcbT?=
 =?us-ascii?Q?hUO1dAlQNOtdpJWuYOTQeD+Mi8HPI3W5NLhDShL8myWnnuAYN2k6rtQ3lN6g?=
 =?us-ascii?Q?ZSCbgKebUwzMGX3ZUcVws9nnQNxykQ2Zu/9R9FRiwTrxIRJ4QXSwviZfxQ6z?=
 =?us-ascii?Q?hdE5SN5dl0wP2JYbHo4dk7Pic5XE2LFT1pSaKUCotquZzMJEc0qg1okAdhIr?=
 =?us-ascii?Q?j1mhfJ+6ThQcN0QubfAkwUPV3FVluwA+lJLeVo35SAc5PYZ3PoZSlfbhYRbD?=
 =?us-ascii?Q?c1lS7/CR4sujYO2xPs0xlIt2wDdQq3eZOQQuTIqAq6VVPGL2oSuIsuGQcr3L?=
 =?us-ascii?Q?3U/R+PLkwE8WgBAtsMH86SpRqLr2ZBh3y5UvTpu7pc7gZyoTb6J0TNqLcoET?=
 =?us-ascii?Q?zyLIlT9dp1KxRGdJTO4gCYXPOmpS7s3r94XoPG5d40T1oXpsqi9p6skSn++D?=
 =?us-ascii?Q?eyn7KrmpwyeXLTVW6vTu2b4nyFHewacHpZFjn+zj1I6XB0FEclzW7AnVoHaR?=
 =?us-ascii?Q?6mTEPTTDex4S5Ps2Nqow2LG9XaFMM6m5Turl3DULiAQmzCGio577CwoWjmy6?=
 =?us-ascii?Q?+2TAhV3vCZbv/cM3omXyj1tOON+WTgzW6qNWrstLMr8H9cHSQ4de4WiRhyb3?=
 =?us-ascii?Q?aTmND0hjNcg64vM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:24:26.6835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: accd8b64-696f-45ec-61a4-08dd5be90d7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7747
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

From: Alex Vesker <valex@nvidia.com>

When creating a root modify/reformat action it is created
for a single specific table type, current code ignored this and
used the first ft_type found in if, else.
Also added missing translation for non-root FDB action root dest.

Fixes: f8c8a6d8440d ("net/mlx5/hws: add action object")
Cc: stable@dpdk.org

Signed-off-by: Alex Vesker <valex@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_action.c | 68 ++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 10 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_action.c b/drivers/net/mlx5/hws/mlx5dr_action.c
index c3e67f8a0b..5e2b845985 100644
--- a/drivers/net/mlx5/hws/mlx5dr_action.c
+++ b/drivers/net/mlx5/hws/mlx5dr_action.c
@@ -1879,19 +1879,67 @@ mlx5dr_action_conv_reformat_to_verbs(uint32_t action_type,
 }
 
 static int
-mlx5dr_action_conv_flags_to_ft_type(uint32_t flags, enum mlx5dv_flow_table_type *ft_type)
+mlx5dr_action_conv_root_flags_to_dv_ft(uint32_t flags,
+				       enum mlx5dv_flow_table_type *ft_type)
 {
-	if (flags & (MLX5DR_ACTION_FLAG_ROOT_RX | MLX5DR_ACTION_FLAG_HWS_RX)) {
+	uint8_t is_rx, is_tx, is_fdb;
+
+	is_rx = !!(flags & MLX5DR_ACTION_FLAG_ROOT_RX);
+	is_tx = !!(flags & MLX5DR_ACTION_FLAG_ROOT_TX);
+	is_fdb = !!(flags & MLX5DR_ACTION_FLAG_ROOT_FDB);
+
+	if (is_rx + is_tx + is_fdb != 1) {
+		DR_LOG(ERR, "Root action flags must be converted to a single ft type");
+		rte_errno = ENOTSUP;
+		return -rte_errno;
+	}
+
+	if (is_rx) {
+		*ft_type = MLX5DV_FLOW_TABLE_TYPE_NIC_RX;
+	} else if (is_tx) {
+		*ft_type = MLX5DV_FLOW_TABLE_TYPE_NIC_TX;
+#ifdef HAVE_MLX5DV_FLOW_MATCHER_FT_TYPE
+	} else if (is_fdb) {
+		*ft_type = MLX5DV_FLOW_TABLE_TYPE_FDB;
+#endif
+	} else {
+		rte_errno = ENOTSUP;
+		return -rte_errno;
+	}
+
+	return 0;
+}
+
+static int
+mlx5dr_action_conv_hws_flags_to_dv_ft(uint32_t flags,
+				     enum mlx5dv_flow_table_type *ft_type)
+{
+	uint8_t is_rx, is_tx, is_fdb;
+
+	is_rx = !!(flags & MLX5DR_ACTION_FLAG_HWS_RX);
+	is_tx = !!(flags & MLX5DR_ACTION_FLAG_HWS_TX);
+	is_fdb = !!(flags & (MLX5DR_ACTION_FLAG_HWS_FDB |
+			     MLX5DR_ACTION_FLAG_HWS_FDB_RX |
+			     MLX5DR_ACTION_FLAG_HWS_FDB_TX |
+			     MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED));
+
+	if (is_rx + is_tx + is_fdb != 1) {
+		DR_LOG(ERR, "Action flags must be converted to a single ft type");
+		rte_errno = ENOTSUP;
+		return -rte_errno;
+	}
+
+	if (is_rx) {
 		*ft_type = MLX5DV_FLOW_TABLE_TYPE_NIC_RX;
-	} else if (flags & (MLX5DR_ACTION_FLAG_ROOT_TX | MLX5DR_ACTION_FLAG_HWS_TX)) {
+	} else if (is_tx) {
 		*ft_type = MLX5DV_FLOW_TABLE_TYPE_NIC_TX;
 #ifdef HAVE_MLX5DV_FLOW_MATCHER_FT_TYPE
-	} else if (flags & (MLX5DR_ACTION_FLAG_ROOT_FDB | MLX5DR_ACTION_FLAG_HWS_FDB)) {
+	} else if (is_fdb) {
 		*ft_type = MLX5DV_FLOW_TABLE_TYPE_FDB;
 #endif
 	} else {
 		rte_errno = ENOTSUP;
-		return 1;
+		return -rte_errno;
 	}
 
 	return 0;
@@ -1908,9 +1956,9 @@ mlx5dr_action_create_reformat_root(struct mlx5dr_action *action,
 	int ret;
 
 	/* Convert action to FT type and verbs reformat type */
-	ret = mlx5dr_action_conv_flags_to_ft_type(action->flags, &ft_type);
+	ret = mlx5dr_action_conv_root_flags_to_dv_ft(action->flags, &ft_type);
 	if (ret)
-		return rte_errno;
+		return ret;
 
 	ret = mlx5dr_action_conv_reformat_to_verbs(action->type, &verb_reformat_type);
 	if (ret)
@@ -2249,9 +2297,9 @@ mlx5dr_action_create_modify_header_root(struct mlx5dr_action *action,
 	struct ibv_context *local_ibv_ctx;
 	int ret;
 
-	ret = mlx5dr_action_conv_flags_to_ft_type(action->flags, &ft_type);
+	ret = mlx5dr_action_conv_root_flags_to_dv_ft(action->flags, &ft_type);
 	if (ret)
-		return rte_errno;
+		return ret;
 
 	local_ibv_ctx = mlx5dr_context_get_local_ibv(action->ctx);
 
@@ -2655,7 +2703,7 @@ mlx5dr_action_create_dest_root(struct mlx5dr_context *ctx,
 		return NULL;
 	}
 
-	if (mlx5dr_action_conv_flags_to_ft_type(flags, &attr.ft_type))
+	if (mlx5dr_action_conv_hws_flags_to_dv_ft(flags, &attr.ft_type))
 		return NULL;
 
 	attr.priority = priority;
-- 
2.39.5

