Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B14FCEE91
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 12:00:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AD7F40649;
	Wed, 25 Feb 2026 13:00:21 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010030.outbound.protection.outlook.com
 [52.101.193.30]) by mails.dpdk.org (Postfix) with ESMTP id 6E19A40395
 for <dev@dpdk.org>; Wed, 25 Feb 2026 13:00:18 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqmg0Hi/G5GonZynUTQ3CVDTnX8I5Ru5OBwRhHDckBXRYdpu85y8RAfC80DkoGHME8F1LcEnOn46oVxQaznrV5mZ3eMGWvjJeLOX6gDTtlqUY3vjo7vjfXf+bJOhl+/IRR6FDJrDoKzA4qU94K/+kJEuo8UdgS3C88cyw7OUuZvVRBNzMS4L2pOcLG1v24o1sDJoEWUzK3lE5VzRHAglQK27FMesgLNNCtAmdZWUg2Fkq5fHY+Bff1Eoi7iNyM5DF3P69zg0mfmAE4l9RRHXD00iO4iEV/3BJmgwNF3FWnSVizMrgR18u3uGeftf0VX8EY0XjU/7xWyN4135otQ7+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpfGGILeCVyW+Piun4q10oULt0irNKUI9nRHfCAOR84=;
 b=Q61YQKLTPXm+Cq6ML559MJBMkQtcfM3ivB3m8x3xEqOq+WRlanhLC/ftISzWY17Fniodu9XtMOzp43uMrlxCZNRWZB9ucdjYeCq+G64kBYtdkrCsnHFg4tTZwkVDTNjEtbnlRi/E2VyTSKLqp+6rItHcVBbafpTQBI39lex2N73grLRkTlor/8REvf/K74yCUF11RVV92R7H7MOREc8qcUM9JPjlTQYZ6VIxt21tT3KNZZqMvQC9KRqbRl+v3/LpvF0dEra9HjW4DuFS+LlrW5+lirMLSGKFIKmsVLKoVqwB9+UnFS7FmcZvECZ/q2JuKTOx/p7fRkpFbZ+B2a1fzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpfGGILeCVyW+Piun4q10oULt0irNKUI9nRHfCAOR84=;
 b=e1Eu3wCROBIm8OusxTdN3yImYTK7z+tvZ1SPnXyHj0vA16a6xg9PMJIPm9EIv2FD5O5FoMl8ud27ogwFwWv95mZRozgcjPdf8WvaWKZ6cbO8wLiU4tzbe7WZbAgdEcsqJzmVHlXTi8MoLJntnSP4Pk8PjEiezTXyTlYDrngEbd3vJ/6mJebNndl4VKI+cVQGob3vN9jSbN0dh0oT/KbZhbG71j3Ro2Mslbfor5CqMcnArsitrdE9vRw1WXeFWa/tJ4gVyiUQMd/nGahsWHott+qkdHKCZEZqoSmzlLIgIyyiZa86ofjUKu84A1uWFnu5aMr6GZ12S8neKfiN6VgbFA==
Received: from BN9PR03CA0222.namprd03.prod.outlook.com (2603:10b6:408:f8::17)
 by MW3PR12MB4459.namprd12.prod.outlook.com (2603:10b6:303:56::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 25 Feb
 2026 12:00:13 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:f8:cafe::5f) by BN9PR03CA0222.outlook.office365.com
 (2603:10b6:408:f8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 11:59:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 12:00:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 04:00:00 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 03:59:58 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH 5/9] net/mlx5: lazily allocate HWS pop VLAN action
Date: Wed, 25 Feb 2026 12:59:13 +0100
Message-ID: <20260225115918.233843-6-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260225115918.233843-1-dsosnowski@nvidia.com>
References: <20260225115918.233843-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|MW3PR12MB4459:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9597cf-cbae-4077-e4b7-08de74656e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: DdIl/hgzdkOeXl5MyvI+GD605W98/rqFpjMtAR7ksmI841C/QxQnml+ue0DASXiJ7n9VE1Z00ByldcHllpJLOsYX9NRJL9IGiT8/ZbzbbLZO71V+Hw7NbCkn1LmvvMqcG2PimBNKQFi4//BGoAiljjslE6uA/2NzDinXLZ1yfkh6HR8ygadvkX0+ljYjf3M3ZiyS1oh9gXjtiI21gdnPjOrHFKqxP71uCyEIcQbVbaaNGDHadwAkjMXRrH09ky1noJ2bF49pqhm8aN+MCJrgBbCgL4ev7QfA0561isrOApo9F8D2UrD+4AMS8PxwA+D8qz2ulu0US/rEOqQscj6+ugOOm83gr74VEnUOiJKSw5me0kQma5d9pyAPoAJyDbPb6CcPg3s9YZbXmQgFzsAtPslf71GBE3ZTt7o9okYxnd6ij6iXaMAzQ7UsHLAM6gaAZ0ng0ivw4nEgBDjrpavMTGXSjym4VZO0DlEFCqperAwRLE1kseZAT+DmUmV1/DlD8hzLeCBr2CD/N55M7+KZYqlOL87scgFDhEN0SBnHZgtPTqVFHwxj9W3wp4/UJIhtRezehQJc6MlAIf3ui32T2bI2JDt1acWoe4Zb4LfX2FWtUln9be3nnw2ok4/WwecglAgMmv2giOHKjcdOMoMpFbY2afV97hged8WwFNN1EcwxAJQJ3pTRjway0dkMiFuYy4paiKsC+g1OfCpUzmfpMkim57DnFNJFKP6Os6drhpTB0N8dB9PyemXMtntLANv+KM+qDzc/OxQSYDmdfOSlGPYO85xSD/cvN6XtLtGVA6bxlvvYhLqYYgutModFCDUZXjTMRpKBiEh/946wTSLH7g==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MwkdF4UPNf8YIaAfWzGAJ4kzhgvv0yYeTBeuTgLXxXq8PECEFbNeMkGMf8VcudDhClV4tvi1zLve7wmyASFXIYciB2rMsPoFCY8CCEhNMJO4v2+qC6vXDgqgamtoRetPC7H6TfO3IDapQsyvcSSTSJag+HywGHBjJ/91KujdyZ7JvwQXji5dGdZo1cMte124nlw8xA+sziWFmu330ajykr4wqG1TGtWwjo3FJDLXossn27zT5RwTGO5CwJRKX0DYcc7eQI0uSeSmgEYfzrd1dJ4UQykfKdSJ7DRnCd3AtzZk8pp6olczOQ+KSNrugeO2lybfkOGWuzquwqLz6far1D5UZ0CxP9/W5xeVhCO/gexsrqHxnPbKb+t4flNra4l9oTricx70nHrP26c1qrEM/yCLowbDX3m6cyPtcZCTSD/pS63IHprw51dQ+AwBcsmi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:00:12.1928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9597cf-cbae-4077-e4b7-08de74656e47
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4459
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

HWS pop_vlan action is used to implement OF_POP_VLAN rte_flow action.
It was allocated either on port start or on rte_flow_configure().
This could cause unnecessary FW resource usage
if user did not use any OF_POP_VLAN action.

This patch extends global actions internal API,
introduced in previous commits, to allow lazy allocation
of HWS pop_vlan action. It will be allocated on first use
and will be allocated per domain to minimize FW resource usage.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Ori Kam <orika@nvidia.com>
---
 drivers/net/mlx5/mlx5.h                    |  1 -
 drivers/net/mlx5/mlx5_flow_hw.c            | 20 ++++++++++----------
 drivers/net/mlx5/mlx5_hws_global_actions.c | 21 +++++++++++++++++++++
 drivers/net/mlx5/mlx5_hws_global_actions.h |  5 +++++
 4 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 43553b1f35..9e46a8cee8 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -2111,7 +2111,6 @@ struct mlx5_priv {
 	/* HW steering rte flow group list header */
 	LIST_HEAD(flow_hw_grp, mlx5_flow_group) flow_hw_grp;
 	struct mlx5dr_action *hw_push_vlan[MLX5DR_TABLE_TYPE_MAX];
-	struct mlx5dr_action *hw_pop_vlan[MLX5DR_TABLE_TYPE_MAX];
 	struct mlx5dr_action **hw_vport;
 	/* HWS global actions. */
 	struct mlx5_hws_global_actions hw_global_actions;
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 54c30264b2..21c61bce90 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -2753,8 +2753,16 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 			masks += of_vlan_offset;
 			break;
 		case RTE_FLOW_ACTION_TYPE_OF_POP_VLAN:
-			acts->rule_acts[dr_pos].action =
-				priv->hw_pop_vlan[type];
+			dr_action = mlx5_hws_global_action_pop_vlan_get(priv, type, is_root);
+			if (dr_action == NULL) {
+				DRV_LOG(ERR, "port %u failed to allocate pop VLAN action",
+					priv->dev_data->port_id);
+				rte_flow_error_set(&sub_error, ENOMEM,
+						   RTE_FLOW_ERROR_TYPE_STATE, NULL,
+						   "failed to allocate pop VLAN action");
+				goto err;
+			}
+			acts->rule_acts[dr_pos].action = dr_action;
 			break;
 		case RTE_FLOW_ACTION_TYPE_JUMP:
 			if (masks->conf &&
@@ -11377,10 +11385,6 @@ flow_hw_destroy_vlan(struct rte_eth_dev *dev)
 	enum mlx5dr_table_type i;
 
 	for (i = MLX5DR_TABLE_TYPE_NIC_RX; i < MLX5DR_TABLE_TYPE_MAX; i++) {
-		if (priv->hw_pop_vlan[i]) {
-			mlx5dr_action_destroy(priv->hw_pop_vlan[i]);
-			priv->hw_pop_vlan[i] = NULL;
-		}
 		if (priv->hw_push_vlan[i]) {
 			mlx5dr_action_destroy(priv->hw_push_vlan[i]);
 			priv->hw_push_vlan[i] = NULL;
@@ -11401,10 +11405,6 @@ _create_vlan(struct mlx5_priv *priv, enum mlx5dr_table_type type)
 	};
 
 	/* rte_errno is set in the mlx5dr_action* functions. */
-	priv->hw_pop_vlan[type] =
-		mlx5dr_action_create_pop_vlan(priv->dr_ctx, flags[type]);
-	if (!priv->hw_pop_vlan[type])
-		return -rte_errno;
 	priv->hw_push_vlan[type] =
 		mlx5dr_action_create_push_vlan(priv->dr_ctx, flags[type]);
 	if (!priv->hw_push_vlan[type])
diff --git a/drivers/net/mlx5/mlx5_hws_global_actions.c b/drivers/net/mlx5/mlx5_hws_global_actions.c
index 1ca444ce98..236e6f1d1a 100644
--- a/drivers/net/mlx5/mlx5_hws_global_actions.c
+++ b/drivers/net/mlx5/mlx5_hws_global_actions.c
@@ -41,6 +41,7 @@ mlx5_hws_global_actions_cleanup(struct mlx5_priv *priv)
 
 	global_actions_array_cleanup(priv, &priv->hw_global_actions.drop, "drop");
 	global_actions_array_cleanup(priv, &priv->hw_global_actions.tag, "tag");
+	global_actions_array_cleanup(priv, &priv->hw_global_actions.pop_vlan, "pop_vlan");
 
 	rte_spinlock_unlock(&priv->hw_global_actions.lock);
 }
@@ -62,6 +63,13 @@ action_create_tag_cb(struct mlx5dr_context *ctx,
 	return mlx5dr_action_create_tag(ctx, action_flags);
 }
 
+static struct mlx5dr_action *
+action_create_pop_vlan_cb(struct mlx5dr_context *ctx,
+			  uint32_t action_flags)
+{
+	return mlx5dr_action_create_pop_vlan(ctx, action_flags);
+}
+
 static struct mlx5dr_action *
 global_action_get(struct mlx5_priv *priv,
 		  struct mlx5_hws_global_actions_array *array,
@@ -124,3 +132,16 @@ mlx5_hws_global_action_tag_get(struct mlx5_priv *priv,
 				 is_root,
 				 action_create_tag_cb);
 }
+
+struct mlx5dr_action *
+mlx5_hws_global_action_pop_vlan_get(struct mlx5_priv *priv,
+				    enum mlx5dr_table_type table_type,
+				    bool is_root)
+{
+	return global_action_get(priv,
+				 &priv->hw_global_actions.pop_vlan,
+				 "pop_vlan",
+				 table_type,
+				 is_root,
+				 action_create_pop_vlan_cb);
+}
diff --git a/drivers/net/mlx5/mlx5_hws_global_actions.h b/drivers/net/mlx5/mlx5_hws_global_actions.h
index bec9f3e0e8..d04ebc42be 100644
--- a/drivers/net/mlx5/mlx5_hws_global_actions.h
+++ b/drivers/net/mlx5/mlx5_hws_global_actions.h
@@ -26,6 +26,7 @@ struct mlx5_hws_global_actions_array {
 struct mlx5_hws_global_actions {
 	struct mlx5_hws_global_actions_array drop;
 	struct mlx5_hws_global_actions_array tag;
+	struct mlx5_hws_global_actions_array pop_vlan;
 	rte_spinlock_t lock;
 };
 
@@ -41,4 +42,8 @@ struct mlx5dr_action *mlx5_hws_global_action_tag_get(struct mlx5_priv *priv,
 						     enum mlx5dr_table_type table_type,
 						     bool is_root);
 
+struct mlx5dr_action *mlx5_hws_global_action_pop_vlan_get(struct mlx5_priv *priv,
+							  enum mlx5dr_table_type table_type,
+							  bool is_root);
+
 #endif /* !RTE_PMD_MLX5_HWS_GLOBAL_ACTIONS_H_ */
-- 
2.47.3

