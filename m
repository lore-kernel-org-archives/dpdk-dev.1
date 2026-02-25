Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F073FCEE8A
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 12:01:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2630440672;
	Wed, 25 Feb 2026 13:00:31 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013028.outbound.protection.outlook.com
 [40.93.201.28]) by mails.dpdk.org (Postfix) with ESMTP id DE6A24066D
 for <dev@dpdk.org>; Wed, 25 Feb 2026 13:00:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfJdHUapeqSXsIReLUf9fgUGPMAiq33jou7yTIdlyPPWkXaRs5CVT+4zTcyeYuS7QVzAsDWzN+keZ+KWEbwaM8HUG7DuuJIZuDCj6bB5iBF/q2nNrsTMbPwhF466iNHolsqmDVCZRf3aPXM4GfV2i1qCq2oG25gKg3sHTQKKQi8QNHZNrN+GOWE83CbbGcH0PXyjBja6LABESjyRCj6rycZ2gqh0cteweZ6MZSFDcsZMU6CQ/V3HBFQIi+yv9hHertIKcUtDvnM5WR5I8AYga+aFQX0VyLVRLPAVMzfVSXlX9Vi3/c9mnQQ/+ghb4gw4+e8ecNC3bSQDzFEnqDnzVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkZyjeSGvpMSPgwz0YoVKkZuS1eAp0YA86YL0yxqEAw=;
 b=TrD+p2ZPTI81WdFHN/fzX1BJG/cP9bO0DLL4wSj1YsI6VL/3n0+S7neIMupnRQY0GPAs8EH3WVWGFUGcTxCtqIMYhUVfJA3klQ/84ZPGMG0f5tTKOXdBVRKtGQS0CG74ryb/bd+aaA710z6h6XO20A29ngcnjC/bH2yOwy0Y3+78EMjxY6kvbTYOGMetvuhdq+pxFwA9VNMwNoRoPKIeah++em4ESNHnwkam8y+oc4350B38bZ6EYZOlecRu/agwUnE4quAal4i3kuG/PulHxxAAcRhxIcHfacALdrTzgndVH2CYCkwbSzwXOxmj3bnbjfIcCFsh8Y+u+B66nny8Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkZyjeSGvpMSPgwz0YoVKkZuS1eAp0YA86YL0yxqEAw=;
 b=Xrqk6kdR+n1CC8fmzuagqStAR3Yaq9nmp9BVCqlibgtJPMntPWE76HRXpK6yoDTvvn1iQMQqdGHWJbhsdK/kAagVQXaalORKQb66BfX6Hk2ZpDHEHU9KP2fpGLda+mLNPHJ20ZPhJUmLfs98TDXUJoHOtTj8eCelUTL4x3bDbHzV7p8993YHh0Chg7jTUy2oPVk3oAo5nDB9xzcMxNWpdWjeQl13gTd0zwOC/nOy1KiX7sbM384+N24N3xyB1lVEn4qKF4pbrctj9decu5n9cyJlX2/IP4V8UaVlZ7/r2/2jeL6uf8uWD0fBVcPxA0Yq1NUegEgG6/tNH5xqpf64cQ==
Received: from BN9PR03CA0691.namprd03.prod.outlook.com (2603:10b6:408:ef::6)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.25; Wed, 25 Feb
 2026 12:00:23 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:ef:cafe::c3) by BN9PR03CA0691.outlook.office365.com
 (2603:10b6:408:ef::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 12:00:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 12:00:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 04:00:07 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 04:00:04 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH 8/9] net/mlx5: lazily allocate HWS NAT64 action
Date: Wed, 25 Feb 2026 12:59:16 +0100
Message-ID: <20260225115918.233843-9-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 9020b9fa-aa30-475b-52e6-08de746574ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: B75IVDq6ca63Gr+2RYX9tg2PrvNXzbjl5myyiCE904MVQkRnxwsXpV0gIyPJoqNAMiw8d1I0KCHZ+6sKzimjRAToInZkq4yyTvYxYx4V3V3TbaFw6Nv8A7Grg7h3rRsEaTxMHI6ONM5Z+bDQGSgCnJnJoohwAb7Jr2SWwII65dh63r5I3dXjQfP818cXG/VtHdzHcHiE7nXcOghTGR5u5hhBZaHL2QQxGpgzMkUhimVzVPrLG7wSdLLqsBNfu43lO59nJr3vjA6rvcF4ZKBQNl0S/2UBVtW+CmCILJ9UrFP8k3BhtCruRhhDX3eejluDR2sb38kDqCs2eu/9SifnTSRK259JNsZ507vXGfKuhvOY6ctDbJiqSIb5sqBcAUz/Aa8sFIJDkZCMSE+oNz1AI/zjDPQ7E+H12tkiPjTkACSA9hIi+mjhs2dyHH/UzEJb75hxaxANAvWT7kEV9rzCvOnKL6jOsWPETOTjC8itjxO/Qc0+yaRUZ6sQeA09jlYi2rN42L70xMaQXuywIIyCImJvBTPlsure7Qz+k85IrkhTa9rehgeq2ONK++nT5YOWxXdU95w7MhSeBgraO7Z1TMKJl2d+qYzcaPF6mnrk+lE+loqJdqo5xSDAEWsWvN3hZI0i7Sbh9QSWjrW6Wlcqn8ODVC+v/KxfIIIy8+70+pzey0r8OTbE4YeF936B4O94aG1bGmRtaMv8PdBdD/vICbC+3RYQCL3sPqjJ8CD0tDBEiJO4VsLFyBsqijYyhEbrQ3pxzTJs9ci9cIIuOHE72B/9qWZ85FxtZ0DW0sCSSbruUazTc7zGrLd2/R6ccsBZGV59+lRV0xhkTKRHaYF9LA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YlTAzvrOJ01gbvjFKX/BkivHEuXpkIOXCXMCVpqZFO7eoe0eM1htF1V0x0NGuurg6WoimjshE8hXKIaagStmjyMka/utNXCuKDgfce1x7xZqwcXbeSJ3zXlcR1v6EWt6+MJ7znURMHAYYTcfFmplV/AIe8of60/97AMt2YafoVsr92gVPLIPSvc1fB58RH1MKEI3UT8UJRfMj4kzhVpDqbCCXPaoxwRvcJZufSxvh31LdMyCD4fZbpw9iG9NA5DV25kDEi3cN4C8miEisWcDZP4rV3UnNLY0yZS1hBKaSKlalZvnxJUr/MgVQ908C+kle+LlgcTru9WLvDKKSMyhKKzzv1ZIdjrrX03PBgWrNxrSEa8AaL5sUPP4JKd/dFCiwx2mkYmb/p/WOvlYcb9t3FN8S+qGTTgLz6xDQYMU+iiANN1MV4btYTmigm+rKYzD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:00:22.8959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9020b9fa-aa30-475b-52e6-08de746574ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182
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

HWS NAT64 action is used to implement NAT64 rte_flow action.
It was allocated either on port start or on rte_flow_configure().
This could cause unnecessary FW resource usage
if user did not use any NAT64 action.

This patch extends global actions internal API,
introduced in previous commits, to allow lazy allocation
of HWS NAT64 action. It will be allocated on first use
and will be allocated per domain to minimize FW resource usage.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Ori Kam <orika@nvidia.com>
---
 drivers/net/mlx5/mlx5.h                    |   6 -
 drivers/net/mlx5/mlx5_flow.h               |   1 +
 drivers/net/mlx5/mlx5_flow_hw.c            | 215 ++++-----------------
 drivers/net/mlx5/mlx5_hws_global_actions.c |  45 +++++
 drivers/net/mlx5/mlx5_hws_global_actions.h |   7 +
 5 files changed, 94 insertions(+), 180 deletions(-)

diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 739b414faf..75e61d6b5b 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -2127,12 +2127,6 @@ struct mlx5_priv {
 
 	struct rte_flow_actions_template *action_template_drop[MLX5DR_TABLE_TYPE_MAX];
 
-	/*
-	 * The NAT64 action can be shared among matchers per domain.
-	 * [0]: RTE_FLOW_NAT64_6TO4, [1]: RTE_FLOW_NAT64_4TO6
-	 * Todo: consider to add *_MAX macro.
-	 */
-	struct mlx5dr_action *action_nat64[MLX5DR_TABLE_TYPE_MAX][2];
 	struct mlx5_indexed_pool *ptype_rss_groups;
 	struct mlx5_nta_sample_ctx *nta_sample_ctx;
 #endif
diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index c8af3fe0be..4c56e638ab 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -1625,6 +1625,7 @@ struct mlx5_hw_actions {
 	uint32_t mark:1; /* Indicate the mark action. */
 	cnt_id_t cnt_id; /* Counter id. */
 	uint32_t mtr_id; /* Meter id. */
+	struct mlx5dr_action *nat64[2]; /* [RTE_FLOW_NAT64_6TO4], [RTE_FLOW_NAT64_4TO6] */
 	/* Translated DR action array from action template. */
 	struct mlx5dr_rule_action rule_acts[MLX5_HW_MAX_ACTS];
 };
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 7fafe3fe6a..c74705be8f 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -369,6 +369,7 @@ static int flow_hw_async_destroy_validate(struct rte_eth_dev *dev,
 					  const uint32_t queue,
 					  const struct rte_flow_hw *flow,
 					  struct rte_flow_error *error);
+static bool flow_hw_should_create_nat64_actions(struct mlx5_priv *priv);
 
 const struct mlx5_flow_driver_ops mlx5_flow_hw_drv_ops;
 
@@ -3023,12 +3024,38 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 			    ((const struct rte_flow_action_nat64 *)masks->conf)->type) {
 				const struct rte_flow_action_nat64 *nat64_c =
 					(const struct rte_flow_action_nat64 *)actions->conf;
-
-				acts->rule_acts[dr_pos].action =
-					priv->action_nat64[type][nat64_c->type];
-			} else if (__flow_hw_act_data_general_append(priv, acts,
-								     actions->type,
-								     src_pos, dr_pos))
+				dr_action = mlx5_hws_global_action_nat64_get(priv,
+									     type,
+									     nat64_c->type);
+				if (dr_action == NULL) {
+					DRV_LOG(ERR, "port %u failed to allocate NAT64 action",
+						priv->dev_data->port_id);
+					rte_flow_error_set(&sub_error, ENOMEM,
+							   RTE_FLOW_ERROR_TYPE_STATE, NULL,
+							   "failed to allocate NAT64 action");
+					goto err;
+				}
+				acts->rule_acts[dr_pos].action = dr_action;
+				break;
+			}
+			acts->nat64[RTE_FLOW_NAT64_6TO4] = mlx5_hws_global_action_nat64_get(priv,
+					type,
+					RTE_FLOW_NAT64_6TO4);
+			acts->nat64[RTE_FLOW_NAT64_4TO6] = mlx5_hws_global_action_nat64_get(priv,
+					type,
+					RTE_FLOW_NAT64_4TO6);
+			if (!acts->nat64[RTE_FLOW_NAT64_6TO4] ||
+			    !acts->nat64[RTE_FLOW_NAT64_4TO6]) {
+				DRV_LOG(ERR, "port %u failed to allocate both NAT64 actions",
+					priv->dev_data->port_id);
+				rte_flow_error_set(&sub_error, ENOMEM,
+						   RTE_FLOW_ERROR_TYPE_STATE, NULL,
+						   "failed to allocate both NAT64 actions");
+				goto err;
+			}
+			if (__flow_hw_act_data_general_append(priv, acts,
+							      actions->type,
+							      src_pos, dr_pos))
 				goto err;
 			break;
 		case RTE_FLOW_ACTION_TYPE_JUMP_TO_TABLE_INDEX:
@@ -3894,9 +3921,7 @@ flow_hw_actions_construct(struct rte_eth_dev *dev,
 			break;
 		case RTE_FLOW_ACTION_TYPE_NAT64:
 			nat64_c = action->conf;
-			MLX5_ASSERT(table->type < MLX5DR_TABLE_TYPE_MAX);
-			rule_acts[act_data->action_dst].action =
-				priv->action_nat64[table->type][nat64_c->type];
+			rule_acts[act_data->action_dst].action = hw_acts->nat64[nat64_c->type];
 			break;
 		case RTE_FLOW_ACTION_TYPE_JUMP_TO_TABLE_INDEX:
 			jump_table = ((const struct rte_flow_action_jump_to_table_index *)
@@ -6916,76 +6941,16 @@ flow_hw_validate_action_default_miss(struct rte_eth_dev *dev,
 }
 
 static int
-flow_hw_validate_action_nat64(struct rte_eth_dev *dev,
-			      const struct rte_flow_actions_template_attr *attr,
-			      const struct rte_flow_action *action,
-			      const struct rte_flow_action *mask,
-			      uint64_t action_flags,
-			      struct rte_flow_error *error)
+flow_hw_validate_action_nat64(struct rte_eth_dev *dev, struct rte_flow_error *error)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
-	const struct rte_flow_action_nat64 *nat64_c;
-	enum rte_flow_nat64_type cov_type;
 
-	RTE_SET_USED(action_flags);
-	if (mask->conf && ((const struct rte_flow_action_nat64 *)mask->conf)->type) {
-		nat64_c = (const struct rte_flow_action_nat64 *)action->conf;
-		cov_type = nat64_c->type;
-		if ((attr->ingress && !priv->action_nat64[MLX5DR_TABLE_TYPE_NIC_RX][cov_type]) ||
-		    (attr->egress && !priv->action_nat64[MLX5DR_TABLE_TYPE_NIC_TX][cov_type]))
-			goto err_out;
-		if (attr->transfer) {
-			if (!is_unified_fdb(priv)) {
-				if (!priv->action_nat64[MLX5DR_TABLE_TYPE_FDB][cov_type])
-					goto err_out;
-			} else {
-				if (!priv->action_nat64[MLX5DR_TABLE_TYPE_FDB_RX][cov_type] ||
-				    !priv->action_nat64[MLX5DR_TABLE_TYPE_FDB_TX][cov_type] ||
-				    !priv->action_nat64[MLX5DR_TABLE_TYPE_FDB_UNIFIED][cov_type])
-					goto err_out;
-			}
-		}
-	} else {
-		/*
-		 * Usually, the actions will be used on both directions. For non-masked actions,
-		 * both directions' actions will be checked.
-		 */
-		if (attr->ingress)
-			if (!priv->action_nat64[MLX5DR_TABLE_TYPE_NIC_RX][RTE_FLOW_NAT64_6TO4] ||
-			    !priv->action_nat64[MLX5DR_TABLE_TYPE_NIC_RX][RTE_FLOW_NAT64_4TO6])
-				goto err_out;
-		if (attr->egress)
-			if (!priv->action_nat64[MLX5DR_TABLE_TYPE_NIC_TX][RTE_FLOW_NAT64_6TO4] ||
-			    !priv->action_nat64[MLX5DR_TABLE_TYPE_NIC_TX][RTE_FLOW_NAT64_4TO6])
-				goto err_out;
-		if (attr->transfer) {
-			if (!is_unified_fdb(priv)) {
-				if (!priv->action_nat64[MLX5DR_TABLE_TYPE_FDB]
-						       [RTE_FLOW_NAT64_6TO4] ||
-				    !priv->action_nat64[MLX5DR_TABLE_TYPE_FDB]
-						       [RTE_FLOW_NAT64_4TO6])
-					goto err_out;
-			} else {
-				if (!priv->action_nat64[MLX5DR_TABLE_TYPE_FDB_RX]
-						       [RTE_FLOW_NAT64_6TO4] ||
-				    !priv->action_nat64[MLX5DR_TABLE_TYPE_FDB_RX]
-						       [RTE_FLOW_NAT64_4TO6] ||
-				    !priv->action_nat64[MLX5DR_TABLE_TYPE_FDB_TX]
-						       [RTE_FLOW_NAT64_6TO4] ||
-				    !priv->action_nat64[MLX5DR_TABLE_TYPE_FDB_TX]
-						       [RTE_FLOW_NAT64_4TO6] ||
-				    !priv->action_nat64[MLX5DR_TABLE_TYPE_FDB_UNIFIED]
-						       [RTE_FLOW_NAT64_6TO4] ||
-				    !priv->action_nat64[MLX5DR_TABLE_TYPE_FDB_UNIFIED]
-						       [RTE_FLOW_NAT64_4TO6])
-					goto err_out;
-			}
-		}
-	}
+	if (!flow_hw_should_create_nat64_actions(priv))
+		return rte_flow_error_set(error, EOPNOTSUPP,
+					  RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+					  "NAT64 action is not supported.");
+
 	return 0;
-err_out:
-	return rte_flow_error_set(error, EOPNOTSUPP, RTE_FLOW_ERROR_TYPE_ACTION,
-				  NULL, "NAT64 action is not supported.");
 }
 
 static int
@@ -7519,8 +7484,7 @@ mlx5_flow_hw_actions_validate(struct rte_eth_dev *dev,
 			action_flags |= MLX5_FLOW_ACTION_OF_PUSH_VLAN;
 			break;
 		case RTE_FLOW_ACTION_TYPE_NAT64:
-			ret = flow_hw_validate_action_nat64(dev, attr, action, mask,
-							    action_flags, error);
+			ret = flow_hw_validate_action_nat64(dev, error);
 			if (ret != 0)
 				return ret;
 			action_flags |= MLX5_FLOW_ACTION_NAT64;
@@ -9892,94 +9856,6 @@ flow_hw_should_create_nat64_actions(struct mlx5_priv *priv)
 	return true;
 }
 
-static void
-flow_hw_destroy_nat64_actions(struct mlx5_priv *priv)
-{
-	uint32_t i;
-
-	for (i = MLX5DR_TABLE_TYPE_NIC_RX; i < MLX5DR_TABLE_TYPE_MAX; i++) {
-		if (priv->action_nat64[i][RTE_FLOW_NAT64_6TO4]) {
-			(void)mlx5dr_action_destroy(priv->action_nat64[i][RTE_FLOW_NAT64_6TO4]);
-			priv->action_nat64[i][RTE_FLOW_NAT64_6TO4] = NULL;
-		}
-		if (priv->action_nat64[i][RTE_FLOW_NAT64_4TO6]) {
-			(void)mlx5dr_action_destroy(priv->action_nat64[i][RTE_FLOW_NAT64_4TO6]);
-			priv->action_nat64[i][RTE_FLOW_NAT64_4TO6] = NULL;
-		}
-	}
-}
-
-static int
-_create_nat64_actions(struct mlx5_priv *priv,
-		      struct mlx5dr_action_nat64_attr *attr,
-		      int type,
-		      struct rte_flow_error *error)
-{
-	const uint32_t flags[MLX5DR_TABLE_TYPE_MAX] = {
-		MLX5DR_ACTION_FLAG_HWS_RX | MLX5DR_ACTION_FLAG_SHARED,
-		MLX5DR_ACTION_FLAG_HWS_TX | MLX5DR_ACTION_FLAG_SHARED,
-		MLX5DR_ACTION_FLAG_HWS_FDB | MLX5DR_ACTION_FLAG_SHARED,
-		MLX5DR_ACTION_FLAG_HWS_FDB_RX | MLX5DR_ACTION_FLAG_SHARED,
-		MLX5DR_ACTION_FLAG_HWS_FDB_TX | MLX5DR_ACTION_FLAG_SHARED,
-		MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED | MLX5DR_ACTION_FLAG_SHARED,
-	};
-	struct mlx5dr_action *act;
-
-	attr->flags = (enum mlx5dr_action_nat64_flags)
-		(MLX5DR_ACTION_NAT64_V6_TO_V4 | MLX5DR_ACTION_NAT64_BACKUP_ADDR);
-	act = mlx5dr_action_create_nat64(priv->dr_ctx, attr, flags[type]);
-	if (!act)
-		return rte_flow_error_set(error, rte_errno,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
-				"Failed to create v6 to v4 action.");
-	priv->action_nat64[type][RTE_FLOW_NAT64_6TO4] = act;
-	attr->flags = (enum mlx5dr_action_nat64_flags)
-		(MLX5DR_ACTION_NAT64_V4_TO_V6 | MLX5DR_ACTION_NAT64_BACKUP_ADDR);
-	act = mlx5dr_action_create_nat64(priv->dr_ctx, attr, flags[type]);
-	if (!act)
-		return rte_flow_error_set(error, rte_errno,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
-				"Failed to create v4 to v6 action.");
-	priv->action_nat64[type][RTE_FLOW_NAT64_4TO6] = act;
-	return 0;
-}
-
-static int
-flow_hw_create_nat64_actions(struct mlx5_priv *priv, struct rte_flow_error *error)
-{
-	struct mlx5dr_action_nat64_attr attr;
-	uint8_t regs[MLX5_FLOW_NAT64_REGS_MAX];
-	uint32_t i, from, to;
-	int rc;
-	bool unified_fdb = is_unified_fdb(priv);
-
-	attr.registers = regs;
-	/* Try to use 3 registers by default. */
-	attr.num_of_registers = MLX5_FLOW_NAT64_REGS_MAX;
-	for (i = 0; i < MLX5_FLOW_NAT64_REGS_MAX; i++) {
-		MLX5_ASSERT(priv->sh->registers.nat64_regs[i] != REG_NON);
-		regs[i] = mlx5_convert_reg_to_field(priv->sh->registers.nat64_regs[i]);
-	}
-	for (i = MLX5DR_TABLE_TYPE_NIC_RX; i <= MLX5DR_TABLE_TYPE_NIC_TX; i++) {
-		rc = _create_nat64_actions(priv, &attr, i, error);
-		if (rc)
-			return rc;
-	}
-	if (priv->sh->config.dv_esw_en) {
-		from = unified_fdb ? MLX5DR_TABLE_TYPE_FDB_RX :
-					MLX5DR_TABLE_TYPE_FDB;
-		to = unified_fdb ? MLX5DR_TABLE_TYPE_FDB_UNIFIED :
-			MLX5DR_TABLE_TYPE_FDB;
-
-		for (i = from; i <= to; i++) {
-			rc = _create_nat64_actions(priv, &attr, i, error);
-			if (rc)
-				return rc;
-		}
-	}
-	return 0;
-}
-
 /**
  * Create an egress pattern template matching on source SQ.
  *
@@ -11879,7 +11755,6 @@ __mlx5_flow_hw_resource_release(struct rte_eth_dev *dev, bool ctx_close)
 	}
 	if (priv->hw_def_miss)
 		mlx5dr_action_destroy(priv->hw_def_miss);
-	flow_hw_destroy_nat64_actions(priv);
 	flow_hw_free_vport_actions(priv);
 	if (priv->acts_ipool) {
 		mlx5_ipool_destroy(priv->acts_ipool);
@@ -12336,14 +12211,6 @@ __flow_hw_configure(struct rte_eth_dev *dev,
 		if (ret < 0)
 			goto err;
 	}
-	if (flow_hw_should_create_nat64_actions(priv)) {
-		if (flow_hw_create_nat64_actions(priv, error))
-			goto err;
-	} else {
-		DRV_LOG(WARNING, "Cannot create NAT64 action on port %u, "
-			"please check the FW version. NAT64 will not be supported.",
-			dev->data->port_id);
-	}
 	if (_queue_attr)
 		mlx5_free(_queue_attr);
 	if (port_attr->flags & RTE_FLOW_PORT_FLAG_STRICT_QUEUE)
diff --git a/drivers/net/mlx5/mlx5_hws_global_actions.c b/drivers/net/mlx5/mlx5_hws_global_actions.c
index d8b21a67f1..6520879ae4 100644
--- a/drivers/net/mlx5/mlx5_hws_global_actions.c
+++ b/drivers/net/mlx5/mlx5_hws_global_actions.c
@@ -5,6 +5,7 @@
 #include "mlx5_hws_global_actions.h"
 
 #include "mlx5.h"
+#include "mlx5_flow.h"
 
 void
 mlx5_hws_global_actions_init(struct mlx5_priv *priv)
@@ -46,6 +47,8 @@ mlx5_hws_global_actions_cleanup(struct mlx5_priv *priv)
 	global_actions_array_cleanup(priv,
 				     &priv->hw_global_actions.send_to_kernel,
 				     "send_to_kernel");
+	global_actions_array_cleanup(priv, &priv->hw_global_actions.nat64_6to4, "nat64_6to4");
+	global_actions_array_cleanup(priv, &priv->hw_global_actions.nat64_4to6, "nat64_4to6");
 
 	rte_spinlock_unlock(&priv->hw_global_actions.lock);
 }
@@ -96,6 +99,18 @@ action_create_send_to_kernel_cb(struct mlx5dr_context *ctx,
 	return mlx5dr_action_create_dest_root(ctx, priority, action_flags);
 }
 
+static struct mlx5dr_action *
+action_create_nat64_cb(struct mlx5dr_context *ctx,
+		       uint32_t action_flags,
+		       void *user_data)
+{
+	struct mlx5dr_action_nat64_attr *attr = user_data;
+
+	/* NAT64 action must always be marked as shared. */
+	return mlx5dr_action_create_nat64(ctx, attr,
+					  action_flags | MLX5DR_ACTION_FLAG_SHARED);
+}
+
 static struct mlx5dr_action *
 global_action_get(struct mlx5_priv *priv,
 		  struct mlx5_hws_global_actions_array *array,
@@ -203,3 +218,33 @@ mlx5_hws_global_action_send_to_kernel_get(struct mlx5_priv *priv,
 				 action_create_send_to_kernel_cb,
 				 (void *)(uintptr_t)priority);
 }
+
+struct mlx5dr_action *
+mlx5_hws_global_action_nat64_get(struct mlx5_priv *priv,
+				 enum mlx5dr_table_type table_type,
+				 enum rte_flow_nat64_type nat64_type)
+{
+	struct mlx5_hws_global_actions_array *array;
+	uint8_t regs[MLX5_FLOW_NAT64_REGS_MAX];
+	struct mlx5dr_action_nat64_attr attr;
+	const char *name;
+
+	for (uint32_t i = 0; i < MLX5_FLOW_NAT64_REGS_MAX; i++)
+		regs[i] = mlx5_convert_reg_to_field(priv->sh->registers.nat64_regs[i]);
+
+	attr.num_of_registers = MLX5_FLOW_NAT64_REGS_MAX;
+	attr.registers = regs;
+
+	if (nat64_type == RTE_FLOW_NAT64_6TO4) {
+		attr.flags = MLX5DR_ACTION_NAT64_V6_TO_V4 | MLX5DR_ACTION_NAT64_BACKUP_ADDR;
+		array = &priv->hw_global_actions.nat64_6to4;
+		name = "nat64_6to4";
+	} else {
+		attr.flags = MLX5DR_ACTION_NAT64_V4_TO_V6 | MLX5DR_ACTION_NAT64_BACKUP_ADDR;
+		array = &priv->hw_global_actions.nat64_4to6;
+		name = "nat64_4to6";
+	}
+
+	return global_action_get(priv, array, name, table_type,
+				 false, action_create_nat64_cb, &attr);
+}
diff --git a/drivers/net/mlx5/mlx5_hws_global_actions.h b/drivers/net/mlx5/mlx5_hws_global_actions.h
index 7fbca9fc96..788b5c124a 100644
--- a/drivers/net/mlx5/mlx5_hws_global_actions.h
+++ b/drivers/net/mlx5/mlx5_hws_global_actions.h
@@ -7,6 +7,7 @@
 
 #include <stdint.h>
 
+#include <rte_flow.h>
 #include <rte_spinlock.h>
 
 #include "hws/mlx5dr.h"
@@ -29,6 +30,8 @@ struct mlx5_hws_global_actions {
 	struct mlx5_hws_global_actions_array pop_vlan;
 	struct mlx5_hws_global_actions_array push_vlan;
 	struct mlx5_hws_global_actions_array send_to_kernel;
+	struct mlx5_hws_global_actions_array nat64_6to4;
+	struct mlx5_hws_global_actions_array nat64_4to6;
 	rte_spinlock_t lock;
 };
 
@@ -56,4 +59,8 @@ struct mlx5dr_action *mlx5_hws_global_action_send_to_kernel_get(struct mlx5_priv
 								 enum mlx5dr_table_type table_type,
 								 uint16_t priority);
 
+struct mlx5dr_action *mlx5_hws_global_action_nat64_get(struct mlx5_priv *priv,
+						       enum mlx5dr_table_type table_type,
+						       enum rte_flow_nat64_type nat64_type);
+
 #endif /* !RTE_PMD_MLX5_HWS_GLOBAL_ACTIONS_H_ */
-- 
2.47.3

