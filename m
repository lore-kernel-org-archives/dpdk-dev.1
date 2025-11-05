Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96968CCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 16:55:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D514B40B99;
	Wed,  5 Nov 2025 17:54:46 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
 by mails.dpdk.org (Postfix) with ESMTP id C843C40A87
 for <dev@dpdk.org>; Wed,  5 Nov 2025 17:54:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Es5HSiFqyTYOrUn0H6dfPghkKb3I0MaB0/OD7ukMatmwFIPwnByeVnjxSE3gN9FQoWtqW5GqXl1ZvnW+bA2vVjZxoeL7nh0KiA5f+HMMrWbQKumj7L5NdaUnIqCxZuoXzQ/UABFjiIGsUnSptlyO/b1IfZZA7dhy9ybzo/aGZGOA65wbQm7MCjfogfVls9B2wxrp5FF85WpdroBAGuVetRdM6fNfRrqQ66mPLzfVQvsdwET6Sdll6jYF+zb4KlQXtg5y2ZjowSUvjoltisRPA05U/lyeb1oNTzvm+nv3szBL+m/qCGj96R4GRVz2GVwpA7RqcU3zBtYQPwpUDXVbjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=al7IZq8nyV3taUS9BOz/YlUZGAXGUQCzwP+FzjsZUZA=;
 b=qY8CKN6aGpY5foemN4gfKkD9DxaYljTj1rzl+hCdrDSsX3oPHr58GSno37BYdXNRJ+1CXEVJpTgOSW9YU4fFj4GNe1h0WlFRxFrcJCODer3cemsru8YBCZrIlHHM4PFjQV1LAOf2RgrsqH2boBJskncYhEl4jq4mgwbHy6O9hJIgcoH74PTX/r4yx8Bf6/RONNIkEJZmqCdQ8nYN7xKrnJ6W3SWKQZIQZP7vgGEoZ1hSROkmCiBzRFBQaoIU2lTY0fSFXh7VJBKwB+O0qphwLbm5bL28fsuhUl0CRs/BCFqMtVwPAmbt+c0Xav1a9H2PUDY3IAif3igjNTYahr30gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=al7IZq8nyV3taUS9BOz/YlUZGAXGUQCzwP+FzjsZUZA=;
 b=U8Z+9eb2GgloVGTJBQ2IJ0Xtm0WYU64zwQhWU8E6S3itDdcAQYXzTx9rvOmUfQsED1uKEa5c1ztXbNvmezg2DRNFTiZA0ElW+f4prM8Z+/aY+WFtVqSRQYkYmbY/EvAdVwJWn37w6gm9nFiIFXNh7Q0sP2eeZHziOMgzTQeOoghZJO5W5Ij64m9Pkdy+WuSvCDoQ5TM04M985j4CxoCyIJr/lQFM8iDGCXrfylQxOUdkanx8gcHdimL3tMeSm3e4/F3jGqSYFNhxTgmTpF7Et1Q6WjQcOXMVDwj3Y0pYFyD2PxiJlRzk52TXVv3oAApOrbEzjwux8dfEVcPPeO01Rw==
Received: from BN8PR04CA0052.namprd04.prod.outlook.com (2603:10b6:408:d4::26)
 by DS5PPFFF21E27DC.namprd12.prod.outlook.com (2603:10b6:f:fc00::66b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Wed, 5 Nov
 2025 16:54:42 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::74) by BN8PR04CA0052.outlook.office365.com
 (2603:10b6:408:d4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 16:54:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 16:54:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 08:54:17 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 08:54:15 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH v2 3/5] net/mlx5/hws: support counter from DevX bulk on root
Date: Wed, 5 Nov 2025 17:52:56 +0100
Message-ID: <20251105165258.1396352-4-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251105165258.1396352-1-dsosnowski@nvidia.com>
References: <20251104174612.1341962-1-dsosnowski@nvidia.com>
 <20251105165258.1396352-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|DS5PPFFF21E27DC:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a102dab-933f-41ce-c232-08de1c8c02f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HFironJtqIKa9GQKjtZdHbsIkOrSgGaTgGi5oxaKUlBJx02ENOvq850jz6zO?=
 =?us-ascii?Q?0X2vF3BBWZhRt/X43Ut7sHp3i23nAtWNyeRKt0+m4IKRBHT/2ktIKUp9Yvlo?=
 =?us-ascii?Q?9eTHT7GE+c/Idj0Ra049/qeyJyPmRBIduZWjnwGh3IpfGECR1gavuOhbTUaf?=
 =?us-ascii?Q?2e/Fw0No1oyZQ9eJ87bpUZ2PILvPE3EvgWtlZFtF1oHHU75nGMZV3DRxmq2y?=
 =?us-ascii?Q?ZQ4y2hv18NClKHKjB4TeRVspkH30oorwWxkpSBsofmJg9PIqKjMG8LLhOcqp?=
 =?us-ascii?Q?TG0lxptFsnPnHylDyd9mgLA0mI07t8fUtwFoTk2551lfV5AMtYaPV5wRkSHx?=
 =?us-ascii?Q?PVypYhvjATZvDk4j1+CLqJ5Yc6IH9R2EUZNjXjhmZZhxqLtpWd8IrVIRolRx?=
 =?us-ascii?Q?nGiOJZ5UzS5PmHxJiV1VAMtGuzQR8+lgyuP3c4GDY8QpZESKue/RZWWk/YsJ?=
 =?us-ascii?Q?DyIMbsPwfLBz/GZ9VqItmz75VXtqhLTWzkk0yR6fhzdwAOx/g8ovtxc2T7HF?=
 =?us-ascii?Q?LuQsv4xYS2w6xGhSkOv6mNMR+CY4r2Gx+KW0WUlW2BV23xJhs3bvZTc6DVeb?=
 =?us-ascii?Q?kXevKMYtJLZg7f4u7k6Z4Gk+5NutqlkmYNsLaholEYy5U5j6VvkVAynH22Mn?=
 =?us-ascii?Q?UBi9NdZ8MnkDJoC9E8prWLOm9bkFLnJm4ri+lcb3KATs1xe5ARpa1NT3dGE9?=
 =?us-ascii?Q?zmMq9f8KQ0IS5N6TMXTUyN+QBUE6JUpS5E+FNlNs/rKkfuM96bH0p1EqhJ7H?=
 =?us-ascii?Q?aCWEVtO7RkhHh8nP/f9zeEj9SKqxp9O9hLiIyEOTvWVAbD0md1wnQKqNYgos?=
 =?us-ascii?Q?E1ul0kLcIeuUJbtbq3me+ADJOn3qz7EbPPCozzL1Y+HZPKfs6LXo2WZkqwkR?=
 =?us-ascii?Q?b5XLO5ZAYrkNA767tnBJctJX4QSpvCIcM4jQ670T0t08JzUnsoPwjUWC6KBq?=
 =?us-ascii?Q?+Md+x4HpelJDeIFiqGqrcqz1Gzb9CBL/IuyvPXP12CCVs+fUcdwHqbpi40vP?=
 =?us-ascii?Q?uvp/DMjQY5wM1xgQcLkE7cNNJthLEJPTuJh62kfBxRJVcrrmIJwzsnTihdqF?=
 =?us-ascii?Q?WejSsbXW/1QxoSMMsOcML3j2MUQ8I2SkuufsszB5wHc9/mBkR0om/PaTdf6h?=
 =?us-ascii?Q?fmx5zV9FV+5vBUb0LuVF71xjGGB8eT8alxzpXIB9TjSVnE89f93Ip7UxJ6IW?=
 =?us-ascii?Q?rZ0COKrKcTIgwgi4oIPSghOXmwVDmO6MT2QNW9JS4rNB3mz9OFVRnhFprYlL?=
 =?us-ascii?Q?Ao8rYApJJOnzHik7uTwg5S3Wta58gAr7U1lpI/E2EttvNu+8W3kh82waf4Dt?=
 =?us-ascii?Q?QUkTD0iXqHK+QdsVD7YhHcIbEnsqhiLHA9PEQNOjQ1ClSU14xNXkVbKo4vti?=
 =?us-ascii?Q?8CbENJpWyMJj6vMmUCv1abv1aycSxnzgX5VfsJEvqPd+2SOLErV/m+EP7Cic?=
 =?us-ascii?Q?rN4joZkvctEaZI+wOPRxSUoq9v16AUEZanO6RcAT6C1yTSj3CX+ilqFPYu6V?=
 =?us-ascii?Q?eRW3aMqdqmMlKZWAeEATTcIWn9lBqho3wiN8cfxabZJRuO9yrgVcd6nJfTyq?=
 =?us-ascii?Q?xfnyt4Juh9E807ipUVE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 16:54:40.1957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a102dab-933f-41ce-c232-08de1c8c02f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFFF21E27DC
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

This patch adds support for using flow counters with offsets
within a DevX bulk, in flow rules on root table, in HWS layer.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr.h        | 14 ++++++++++++++
 drivers/net/mlx5/hws/mlx5dr_action.c | 20 +++++++++++---------
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr.h b/drivers/net/mlx5/hws/mlx5dr.h
index 58526fc08e..c13316305f 100644
--- a/drivers/net/mlx5/hws/mlx5dr.h
+++ b/drivers/net/mlx5/hws/mlx5dr.h
@@ -738,6 +738,20 @@ mlx5dr_action_create_counter(struct mlx5dr_context *ctx,
 			     struct mlx5dr_devx_obj *obj,
 			     uint32_t flags);
 
+/* Check if counter action on root table is supported.
+ *
+ * @return true if counter action on root table is supported.
+ */
+static inline bool
+mlx5dr_action_counter_root_is_supported(void)
+{
+#ifdef HAVE_MLX5DV_FLOW_ACTION_COUNTERS_DEVX_WITH_OFFSET
+	return true;
+#else
+	return false;
+#endif
+}
+
 /* Create direct rule reformat action.
  *
  * @param[in] ctx
diff --git a/drivers/net/mlx5/hws/mlx5dr_action.c b/drivers/net/mlx5/hws/mlx5dr_action.c
index d765d57a8f..b35bf07c3c 100644
--- a/drivers/net/mlx5/hws/mlx5dr_action.c
+++ b/drivers/net/mlx5/hws/mlx5dr_action.c
@@ -832,16 +832,11 @@ int mlx5dr_action_root_build_attr(struct mlx5dr_rule_action rule_actions[],
 			attr[i].type = MLX5DV_FLOW_ACTION_IBV_FLOW_ACTION;
 			attr[i].action = action->flow_action;
 			break;
-#ifdef HAVE_IBV_FLOW_DEVX_COUNTERS
+#ifdef HAVE_MLX5DV_FLOW_ACTION_COUNTERS_DEVX_WITH_OFFSET
 		case MLX5DR_ACTION_TYP_CTR:
-			attr[i].type = MLX5DV_FLOW_ACTION_COUNTERS_DEVX;
-			attr[i].obj = action->devx_obj;
-
-			if (rule_actions[i].counter.offset) {
-				DR_LOG(ERR, "Counter offset not supported over root");
-				rte_errno = ENOTSUP;
-				return rte_errno;
-			}
+			attr[i].type = MLX5DV_FLOW_ACTION_COUNTERS_DEVX_WITH_OFFSET;
+			attr[i].bulk_obj.obj = action->devx_obj;
+			attr[i].bulk_obj.offset = rule_actions[i].counter.offset;
 			break;
 #endif
 		default:
@@ -1712,6 +1707,13 @@ mlx5dr_action_create_counter(struct mlx5dr_context *ctx,
 		return NULL;
 	}
 
+	if (mlx5dr_action_is_root_flags(flags) &&
+	    !mlx5dr_action_counter_root_is_supported()) {
+		DR_LOG(ERR, "Counter action is not supported on root");
+		rte_errno = ENOTSUP;
+		return NULL;
+	}
+
 	action = mlx5dr_action_create_generic(ctx, flags, MLX5DR_ACTION_TYP_CTR);
 	if (!action)
 		return NULL;
-- 
2.39.5

