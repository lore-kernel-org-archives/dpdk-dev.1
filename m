Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FA0C19F32
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Mar 2025 09:23:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FBFF4029E;
	Fri,  7 Mar 2025 10:23:02 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by mails.dpdk.org (Postfix) with ESMTP id 756AC40275;
 Fri,  7 Mar 2025 10:23:01 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQRA/FfU39DP8urxYg3GwQQPOwB9/F+qEMxB3kdpdonn+50SJCnW6deD+44luavWWfjyRyQlUS/XpC+mxRstwTC6w3W2Z7GqIAmYhN9fjC26lQEwRb7OCFMyPv/5d2FF2V770RKOcy1WrEsCeR9EY19FQ9QcK4Pl6t/BIznhNE7ep6OBwH6erNlMITNjMd5cUW742fxouCkndpbmzJ2Z/U+k0Bnkn6J6KtRRLdEvmvG5bpe6M59hK4EtUEUrvUHvAoXCUIjT4h+IzLmL7JNtZhst6dlQY6xXHIoKW12DEYBTkEAN1XDLFk+TscytDYpyQRiOwSttfIMMbQJHLqdXGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Syr3lrOa2Q3Z4CmwWWaqILNk7UeU+J2ntejV8/LlU+w=;
 b=XnZeA9nw4sjMOLfBET13IJjxJdsusP6+cTQViXLkKyxgsWtZ9Tk4PgyKVmSDth4RDjKEGs91T33EgA0HCWJnMB1dDgUUSmJr5Rxy7/a3ccxMoz0Vpn8IIKIeg4IYn1qPy6pULlRaaJLTNeTU0R4AhOIxvP5O6PNbXy82p4eb2NTPA0tY91GDCbDeG0HR41Iwo5X22F1M4CFw3S2CcUyoJ4NTeZziBDvGNt1yhsTlOYmh/j27IZxc5uj4WsoIkrbzagr/ckIcVS2Aik6achWL2dnlQST6gsWE75/JY4seyuaGaV+kS61Cumdnny+Jne+hdXRj2FXgm9Y6MeRU/HwG4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Syr3lrOa2Q3Z4CmwWWaqILNk7UeU+J2ntejV8/LlU+w=;
 b=oalQwQzrc5/sDotvVgc3C5MYvhCn2mugAdxZ2JKyiGtAdhQjkKCNiKBfc99QJx5vJXDnmntMPXXkxtoEdlZ2aMAEFhQn2rcZwhVwkzDhVpoqkEzFREEJa1GfzrOVzr42cWHkpCr2OxAPrbwHmNpKpSvqXvzz+bQuEyvAwSvihuu/efbtwMVFRoM7m8begH+mS27qfsQVRsa1q9WVKXjnbVi7WSJduxS88aYBWF2Lzytv4rK/uQjrA/rHiz9XzKNbs/OrdxcQsdh2RaGbqKNQUsEAtOGBm+EUFGpWbvsBpTustoUodqd9ndvp5ZyJqzysZlfi6padcmn7exi6c9L6RQ==
Received: from MN2PR03CA0011.namprd03.prod.outlook.com (2603:10b6:208:23a::16)
 by PH8PR12MB7328.namprd12.prod.outlook.com (2603:10b6:510:214::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Fri, 7 Mar
 2025 09:22:58 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::8d) by MN2PR03CA0011.outlook.office365.com
 (2603:10b6:208:23a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 09:22:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 09:22:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Mar 2025
 01:22:45 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 7 Mar
 2025 01:22:42 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Erez Shitrit
 <erezsh@nvidia.com>, Alex Vesker <valex@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH v2] net/mlx5/hws: fix incorrect DV FT type convert
Date: Fri, 7 Mar 2025 10:22:20 +0100
Message-ID: <20250307092220.38013-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250305132353.46724-1-dsosnowski@nvidia.com>
References: <20250305132353.46724-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|PH8PR12MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ca109b-0a29-44cd-cb95-08dd5d59a61a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B3s4Gw0caxreNl3IbpjBwHSYLSaAM/wf+Iu8hEJvHngitdiWhMgqvydnabGg?=
 =?us-ascii?Q?ZbPc/oR7lVhLAi7uiiYKN27Adv8FgIICFmNDaYmTIbaA4qDpJ005Z9XMRsex?=
 =?us-ascii?Q?ZNMLVPiQn8een8Q0T6qKg7eBFMQBUFG7LpC6Ykw3R5/PSaXxKFVOY0/dZI3Z?=
 =?us-ascii?Q?xOHmrA3tUstsoCK+W0I4lbqT6+pBB6e9w6WikE4AesjHtmwcZ+bmtleqvZAf?=
 =?us-ascii?Q?F7ockwVl/7LKxYtRemuPED8gWvMatS73bla3unAUy7MJOmR7SJpxiCgZfdIV?=
 =?us-ascii?Q?cHwPEF6lsWXTHS3fVNCeOmtSZHM63ebeiECrCCo3WUIS/0CI9B646hvrg8I+?=
 =?us-ascii?Q?Lh8QKjDZ5Q3qudawAbLEDD2wL1fQXcB2lhsIX64EV/XhSVlzgqiwuZt1dHWi?=
 =?us-ascii?Q?Yxj5Bze7CsBYByVxhCKl1KOrKZW0ZVbkF1a2uBc700xbHxwHHVgnD2jY4nNv?=
 =?us-ascii?Q?7XK+WTJzaQ92t7lk/iD69axHWFXmIefjb93Mpm127fpakl14AVGgjhJXv8Yr?=
 =?us-ascii?Q?r+JN66qTgV6eEQUu2+4pB+SR7Tdy4HdlL0dxuGps0jinMWYEOghBEglNsivB?=
 =?us-ascii?Q?3D6Wb2u6oKNslWC6+Ez6iGtjiz11f1BEKb3jRkZZgLA6mB1jv2x/d1LKOk8/?=
 =?us-ascii?Q?mWGEcTQ7P09kz5zhgAPJAsOstRvnmn10bzpYe+ZM2cYKN4J8u6c5Oh5L9fXV?=
 =?us-ascii?Q?vL4iVD81ioZBJnF9kka2jIBVtgLBItqHk9JubLiItPM6tx3DsBRyMKL/RfsM?=
 =?us-ascii?Q?KArhY5UHMkhxRjdWTU75vVTtXZFIlu7ngBkwA9Dg9ii3+zz1ylYV0r/PN09B?=
 =?us-ascii?Q?C10kn294/70UisFYbnpVjqPLvg5Nit18g3BP4WVKlyaWKuIjuCiObtJNdlno?=
 =?us-ascii?Q?N0smY8CTgRAwC9gnOo859DPL1pgbWDJUNgkfi6GnrFQocqY480lxyZtsD9dv?=
 =?us-ascii?Q?yAl3Vjp15cwfjBRcAXm1d+UJqWP+anCTQJVj+IJoi2YyXdIKpgoP6UgXzAsv?=
 =?us-ascii?Q?GUAYZYse6XDiqxux0EKo3yfy+Km0D5GB9h/DDHicCRhBprl5JGEK5Mk956h1?=
 =?us-ascii?Q?usPr+UwlMFu9iKqQCa6hdiNXYvq+dqto3P6fA/SL/4D1JGmk/21roMLjS0eX?=
 =?us-ascii?Q?8qw/Y/ZveFHfZ8Jy1RcFB5LDf2IvPYy+nIXPFOnSZByMpduPGgsUfLQVyyH1?=
 =?us-ascii?Q?oes/ZfjU64hgWZ/MSAMa7oi7XhNrvkPaKp+whZYbgRJmTgX5tYvRu8nSx2Cn?=
 =?us-ascii?Q?ZsWMUAOMte4Pn7bF+zFy7Zc9UJB176+0iIVQojqCRuEBBToj/VwiU+rOYfD8?=
 =?us-ascii?Q?HMfy9SzZPMrZjbc4c7hlm5vOLwxZVOO11GXItvdxGtU5OE/ZlkHaKRAF/dfx?=
 =?us-ascii?Q?tASSv6HzIGdQSWIncmxiv0y8eTNGqfuNVK2BRr2ROmydDgsI7kqtC4pjIadB?=
 =?us-ascii?Q?Xoou8LoRzfA/DOR92Rkspxqd0D5yrP31WICLxlcRaevyop8Wnm/Um9uqcT2c?=
 =?us-ascii?Q?Ri7d2v3FwMo+sPY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 09:22:57.4849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ca109b-0a29-44cd-cb95-08dd5d59a61a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7328
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

v2:
* Rebase on top of v25.03-rc2

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

