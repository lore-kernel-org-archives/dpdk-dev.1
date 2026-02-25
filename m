Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC3CFCEE8A
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 12:01:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76E0D4066A;
	Wed, 25 Feb 2026 13:00:28 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
 by mails.dpdk.org (Postfix) with ESMTP id 5960140288
 for <dev@dpdk.org>; Wed, 25 Feb 2026 13:00:26 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNTgSpUVWetlFsJQ+4Kd8inN2zo9WAQYRR5fUT1tSz2ekMfnShjBH6YY5o+F8CnHiUIW3mH1PCzKacktKpg3uf7QGbFVHk8wseGFUlYGhjiMi/4tMJ0BgAnvbVI/fadZ3x3fLfbneptJ3uqTexSoKpmijf3FslmcIZubY0M/eK4/zDRA5gteXQpQpZYcrtAI+5MgNpEF8n0Gcar9GMhnqpzN/WCenyMl2TcneLMAFTPZAEoeTuNgIteQxnr0hdm/W8H/49tuG/F5fZ0ZDXvV5/hN8CdafFp1QOuNMwuSE1THNN/ividrh49YeN1lT6w8Xt8r7Z2G8FO2osvhW8X/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QV0nJdkPOGSiSA6oJB4RW5rb72STS3t90vjWVx2yZdU=;
 b=l/LsyB6g+WU5HeuwX9d2HPEom2CD1A2nYSvN1r3sO3UKbfu32HG2FMOQ3poj23bXTIznrnh6HVo1inCbr5k5u6g/IcXrCDHFVQk7HWURg4y0vpAo1E4Skfw+LCJRwvd8YaUAgL28+Pov83p9KrpJ0trcJuuWqfIIB0LEbcRMfjB4VJc0oQKSafDRDC2Gltdg9ea0uyxwCYIgJQrTdhGm6OW17EL3ZH2DyaVEZ4XCRVSPsZH/flL/eGCgQYJ72NmHd9RMWLlChGHfYnL2gpks6WPWYCuU51VWQhOG8eaznkho2i+7VG9aBUXwifHZHFTBHcVclnJcPRp8YlLoo9yNyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QV0nJdkPOGSiSA6oJB4RW5rb72STS3t90vjWVx2yZdU=;
 b=SmNRtP/qTaGvvw+H1xgIxcemLcNv/eGkzkGJgiCok3F1YVWAQTrTpylw+B1FcZOp8CBcfsaFf+BRh5hSOiFLundUXNinlrc0XjhE8F+XXmvL9oC8e+MT/s0xEJ3iQILFGNmqzVy84BsWTxwXANRqfNDQiz193kadmNN4yEE1hPmz/Q1VGRyq0psgvVlRGm4kkvgPsJ+WPuRLPmxl6EZvtdWiFMYdNFt/JuBx2eBbTnAuhHbEVs26HyBpbKsp2BXxNL6S9MON8nOe9DyKAvidNbYFDeuyzYguRXMAQYrlUFmcRjbIgnv3+Ounu0Prg1H91MGJWFiWCok5sGd8G5xd/Q==
Received: from BN9PR03CA0375.namprd03.prod.outlook.com (2603:10b6:408:f7::20)
 by CYYPR12MB8854.namprd12.prod.outlook.com (2603:10b6:930:b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Wed, 25 Feb
 2026 12:00:18 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:f7:cafe::b7) by BN9PR03CA0375.outlook.office365.com
 (2603:10b6:408:f7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 12:00:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 12:00:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 04:00:04 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 04:00:02 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH 7/9] net/mlx5: lazily allocate HWS send to kernel action
Date: Wed, 25 Feb 2026 12:59:15 +0100
Message-ID: <20260225115918.233843-8-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|CYYPR12MB8854:EE_
X-MS-Office365-Filtering-Correlation-Id: 17782e99-0b2d-4d72-b2c2-08de7465717a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: aX84sZXi7S/TMexBc/oNTStlM0I9fieO+jRS9ovwkY0lmPI8AXvKS+Z+OHh4UmWmWdjuS82wqIiTCd+H4PYTGOAh7lPAEQkfCLOCdrfNc2vgHGX0nrZQGEiZbrmJLTzKz+LdhpT4n4zqOa7byJKav1te9Fq23L2Ets0rBrlOigRkNLf/pluxsd/5IWZLmH9gK3mr4EZUO8vDbaXYxgfLw4XHJbumSgB4zKcrTVeaB52K1oXxl4XJ1GypJTFrquTZXkjKANN8yuo7YBFnu8O72S+9EYjmDBazrrg6QB2AeDo+TViT3c6OQwxARFykTSgfuJF5WVLOtMb16GoqruyW+SBqAEiJfWfCYL+R8NEkyE8vGxMNRfgrDKzelqdMqzqsTERtHuwdQmhIniEzpvptIJ+rOnsfFHdMFOdFmN/if7kwjBIHai2XWsm600XlejPxmmRKj+3Xs2buFkdjezn68O9T8qz8fwph++hk+yKa0I7JQWOG05tKGb5s6rLMswLbtdP0ZwOCw0pVJWZEVcY/upnDU3ftz9MboPbtw2rqi3q8hwu/9yYQbA5a/ldbMU+SIVV9Ul4n0iFTGAcZomP3BGZd3shAKGnQfeFf0o1YfhBLUL6cidBR2Wi9Mu4Z4RTB29P0mHuJHo9XNqnNUotWE+CCx9JkLnxb8s3vDaoJhkUt9t+jjQKfY4YV4SrEXQNEkYhfnxgc44adZAW4XJ364FrFY8xqHiqNp1YIeNA1M0Wsq0xeanhy9mxpSiQuq7NbzJGZHtf5dMOtXpVPMWpZ+QtvF/AvVkzAgabVKMt4PsNn3VLeRbkNjbBSpJAKjdQLzbbJwUY4yIAadGpFtRrfBA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vNSkgv4M2hJjVm/tLSPNodDaC41olOqShLDJOdze2EPXZS4MLsx8LBhaVqI/p7ch/z5mn2FRJcXusnkeLA245T2fNa+v0rH4SEnJv7BRwrgg+TD8peBr7KJ+/hdR/pVMKR/VZtTXMyS6SkinVIAnFDW9D9aDRLulmQ0fSV/gV4ITtKmr9CHWCm1T2hqJd2DZzM+C7WuA0iIipqZdjnvq5oUSaEn/ZippMEoMn76iAyOqQFCKcY0ZBo7cXXqbCHlW0yMyQvJVTYB0bWbzIITTsDniIqPGNJzpKa2p2Xr281BDOFUZWeA4gBWHTgOcIqknFrkqBYUoaSteoeL92qdn9T7YAsCQFDH96P0f9jJT3m3n4/iPKyF4WDoo3+7UKvDyySm4RL1ruiql9vtrxZc/gRzSDuQdGrFq8hw4WbnzZo9NKUhfWIOOkP8JeY9mIqlT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:00:17.5618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17782e99-0b2d-4d72-b2c2-08de7465717a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8854
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

HWS send_to_kernel action is used to implement
SEND_TO_KERNEL rte_flow action.
It was allocated either on port start or on rte_flow_configure().
This could cause unnecessary FW resource usage
if user did not use any SEND_TO_KERNEL action.

This patch extends global actions internal API,
introduced in previous commits, to allow lazy allocation
of HWS send_to_kernel action. It will be allocated on first use
and will be allocated per domain to minimize FW resource usage.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Ori Kam <orika@nvidia.com>
---
 drivers/net/mlx5/mlx5.h                    |  2 -
 drivers/net/mlx5/mlx5_flow_hw.c            | 90 ++++------------------
 drivers/net/mlx5/mlx5_hws_global_actions.c | 59 +++++++++++---
 drivers/net/mlx5/mlx5_hws_global_actions.h |  5 ++
 4 files changed, 66 insertions(+), 90 deletions(-)

diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 94b4cb0d7b..739b414faf 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -2115,8 +2115,6 @@ struct mlx5_priv {
 	struct mlx5_hws_global_actions hw_global_actions;
 	/* HW steering global default miss action. */
 	struct mlx5dr_action *hw_def_miss;
-	/* HW steering global send to kernel action. */
-	struct mlx5dr_action *hw_send_to_kernel[MLX5DR_TABLE_TYPE_MAX];
 	/* HW steering create ongoing rte flow table list header. */
 	LIST_HEAD(flow_hw_tbl_ongo, rte_flow_template_table) flow_hw_tbl_ongo;
 	struct mlx5_indexed_pool *acts_ipool; /* Action data indexed pool. */
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 2ecae1b7e7..7fafe3fe6a 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -2913,14 +2913,24 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 			break;
 		case RTE_FLOW_ACTION_TYPE_SEND_TO_KERNEL:
 			if (is_root) {
-				__flow_hw_action_template_destroy(dev, acts);
 				rte_flow_error_set(&sub_error, ENOTSUP,
 					RTE_FLOW_ERROR_TYPE_ACTION,
 					NULL,
 					"Send to kernel action on root table is not supported in HW steering mode");
 				goto err;
 			}
-			acts->rule_acts[dr_pos].action = priv->hw_send_to_kernel[type];
+			dr_action = mlx5_hws_global_action_send_to_kernel_get(priv,
+					type,
+					MLX5_HW_LOWEST_PRIO_ROOT);
+			if (dr_action == NULL) {
+				DRV_LOG(ERR, "port %u failed to allocate send to kernel action",
+					priv->dev_data->port_id);
+				rte_flow_error_set(&sub_error, ENOMEM,
+						   RTE_FLOW_ERROR_TYPE_STATE, NULL,
+						   "failed to allocate send to kernel action");
+				goto err;
+			}
+			acts->rule_acts[dr_pos].action = dr_action;
 			break;
 		case RTE_FLOW_ACTION_TYPE_MODIFY_FIELD:
 			err = flow_hw_modify_field_compile(dev, attr, actions,
@@ -7366,36 +7376,14 @@ mlx5_flow_hw_actions_validate(struct rte_eth_dev *dev,
 			action_flags |= MLX5_FLOW_ACTION_JUMP;
 			break;
 #ifdef HAVE_MLX5DV_DR_ACTION_CREATE_DEST_ROOT_TABLE
-		case RTE_FLOW_ACTION_TYPE_SEND_TO_KERNEL: {
-			bool res;
-
+		case RTE_FLOW_ACTION_TYPE_SEND_TO_KERNEL:
 			if (priv->shared_host)
 				return rte_flow_error_set(error, ENOTSUP,
 							  RTE_FLOW_ERROR_TYPE_ACTION,
 							  action,
 							  "action not supported in guest port");
-			if (attr->ingress) {
-				res = priv->hw_send_to_kernel[MLX5DR_TABLE_TYPE_NIC_RX];
-			} else if (attr->egress) {
-				res = priv->hw_send_to_kernel[MLX5DR_TABLE_TYPE_NIC_TX];
-			} else {
-				if (!is_unified_fdb(priv))
-					res = priv->hw_send_to_kernel[MLX5DR_TABLE_TYPE_FDB];
-				else
-					res =
-					    priv->hw_send_to_kernel[MLX5DR_TABLE_TYPE_FDB_RX] &&
-					    priv->hw_send_to_kernel[MLX5DR_TABLE_TYPE_FDB_TX] &&
-					    priv->hw_send_to_kernel[MLX5DR_TABLE_TYPE_FDB_UNIFIED];
-			}
-			if (!res)
-				return rte_flow_error_set(error, ENOTSUP,
-							  RTE_FLOW_ERROR_TYPE_ACTION,
-							  action,
-							  "action is not available");
-
 			action_flags |= MLX5_FLOW_ACTION_SEND_TO_KERNEL;
 			break;
-		}
 #endif
 		case RTE_FLOW_ACTION_TYPE_QUEUE:
 			ret = mlx5_hw_validate_action_queue(dev, action, mask,
@@ -9891,55 +9879,6 @@ flow_hw_free_vport_actions(struct mlx5_priv *priv)
 	priv->hw_vport = NULL;
 }
 
-#ifdef HAVE_MLX5DV_DR_ACTION_CREATE_DEST_ROOT_TABLE
-static __rte_always_inline void
-_create_send_to_kernel_actions(struct mlx5_priv *priv, int type)
-{
-	int action_flag;
-
-	action_flag = mlx5_hw_act_flag[1][type];
-	priv->hw_send_to_kernel[type] =
-		mlx5dr_action_create_dest_root(priv->dr_ctx,
-				MLX5_HW_LOWEST_PRIO_ROOT,
-				action_flag);
-	if (!priv->hw_send_to_kernel[type])
-		DRV_LOG(WARNING, "Unable to create HWS send to kernel action");
-}
-#endif
-
-static void
-flow_hw_create_send_to_kernel_actions(__rte_unused struct mlx5_priv *priv,
-				      __rte_unused bool is_proxy)
-{
-#ifdef HAVE_MLX5DV_DR_ACTION_CREATE_DEST_ROOT_TABLE
-	int i, from, to;
-	bool unified_fdb = is_unified_fdb(priv);
-
-	for (i = MLX5DR_TABLE_TYPE_NIC_RX; i <= MLX5DR_TABLE_TYPE_NIC_TX; i++)
-		_create_send_to_kernel_actions(priv, i);
-
-	if (is_proxy) {
-		from = unified_fdb ? MLX5DR_TABLE_TYPE_FDB_RX : MLX5DR_TABLE_TYPE_FDB;
-		to = unified_fdb ? MLX5DR_TABLE_TYPE_FDB_UNIFIED : MLX5DR_TABLE_TYPE_FDB;
-		for (i = from; i <= to; i++)
-			_create_send_to_kernel_actions(priv, i);
-	}
-#endif
-}
-
-static void
-flow_hw_destroy_send_to_kernel_action(struct mlx5_priv *priv)
-{
-	int i;
-
-	for (i = MLX5DR_TABLE_TYPE_NIC_RX; i < MLX5DR_TABLE_TYPE_MAX; i++) {
-		if (priv->hw_send_to_kernel[i]) {
-			mlx5dr_action_destroy(priv->hw_send_to_kernel[i]);
-			priv->hw_send_to_kernel[i] = NULL;
-		}
-	}
-}
-
 static bool
 flow_hw_should_create_nat64_actions(struct mlx5_priv *priv)
 {
@@ -11941,7 +11880,6 @@ __mlx5_flow_hw_resource_release(struct rte_eth_dev *dev, bool ctx_close)
 	if (priv->hw_def_miss)
 		mlx5dr_action_destroy(priv->hw_def_miss);
 	flow_hw_destroy_nat64_actions(priv);
-	flow_hw_destroy_send_to_kernel_action(priv);
 	flow_hw_free_vport_actions(priv);
 	if (priv->acts_ipool) {
 		mlx5_ipool_destroy(priv->acts_ipool);
@@ -12360,8 +12298,6 @@ __flow_hw_configure(struct rte_eth_dev *dev,
 			goto err;
 		}
 	}
-	if (!priv->shared_host)
-		flow_hw_create_send_to_kernel_actions(priv, is_proxy);
 	if (port_attr->nb_conn_tracks || (host_priv && host_priv->hws_ctpool)) {
 		if (mlx5_flow_ct_init(dev, port_attr->nb_conn_tracks, nb_q_updated))
 			goto err;
diff --git a/drivers/net/mlx5/mlx5_hws_global_actions.c b/drivers/net/mlx5/mlx5_hws_global_actions.c
index 2bbfa5a24c..d8b21a67f1 100644
--- a/drivers/net/mlx5/mlx5_hws_global_actions.c
+++ b/drivers/net/mlx5/mlx5_hws_global_actions.c
@@ -43,48 +43,67 @@ mlx5_hws_global_actions_cleanup(struct mlx5_priv *priv)
 	global_actions_array_cleanup(priv, &priv->hw_global_actions.tag, "tag");
 	global_actions_array_cleanup(priv, &priv->hw_global_actions.pop_vlan, "pop_vlan");
 	global_actions_array_cleanup(priv, &priv->hw_global_actions.push_vlan, "push_vlan");
+	global_actions_array_cleanup(priv,
+				     &priv->hw_global_actions.send_to_kernel,
+				     "send_to_kernel");
 
 	rte_spinlock_unlock(&priv->hw_global_actions.lock);
 }
 
 typedef struct mlx5dr_action *(*global_action_create_t)(struct mlx5dr_context *ctx,
-							uint32_t action_flags);
+							uint32_t action_flags,
+							void *user_data);
 
 static struct mlx5dr_action *
 action_create_drop_cb(struct mlx5dr_context *ctx,
-		      uint32_t action_flags)
+		      uint32_t action_flags,
+		      void *user_data __rte_unused)
 {
 	return mlx5dr_action_create_dest_drop(ctx, action_flags);
 }
 
 static struct mlx5dr_action *
 action_create_tag_cb(struct mlx5dr_context *ctx,
-		     uint32_t action_flags)
+		     uint32_t action_flags,
+		     void *user_data __rte_unused)
 {
 	return mlx5dr_action_create_tag(ctx, action_flags);
 }
 
 static struct mlx5dr_action *
 action_create_pop_vlan_cb(struct mlx5dr_context *ctx,
-			  uint32_t action_flags)
+			  uint32_t action_flags,
+			  void *user_data __rte_unused)
 {
 	return mlx5dr_action_create_pop_vlan(ctx, action_flags);
 }
 
 static struct mlx5dr_action *
 action_create_push_vlan_cb(struct mlx5dr_context *ctx,
-			   uint32_t action_flags)
+			   uint32_t action_flags,
+			   void *user_data __rte_unused)
 {
 	return mlx5dr_action_create_push_vlan(ctx, action_flags);
 }
 
+static struct mlx5dr_action *
+action_create_send_to_kernel_cb(struct mlx5dr_context *ctx,
+				uint32_t action_flags,
+				void *user_data)
+{
+	uint16_t priority = (uint16_t)(uintptr_t)user_data;
+
+	return mlx5dr_action_create_dest_root(ctx, priority, action_flags);
+}
+
 static struct mlx5dr_action *
 global_action_get(struct mlx5_priv *priv,
 		  struct mlx5_hws_global_actions_array *array,
 		  const char *name,
 		  enum mlx5dr_table_type table_type,
 		  bool is_root,
-		  global_action_create_t create_cb)
+		  global_action_create_t create_cb,
+		  void *user_data)
 {
 	enum mlx5dr_action_flags action_flags;
 	struct mlx5dr_action *action = NULL;
@@ -100,7 +119,7 @@ global_action_get(struct mlx5_priv *priv,
 	if (action != NULL)
 		goto unlock_ret;
 
-	action = create_cb(priv->dr_ctx, action_flags);
+	action = create_cb(priv->dr_ctx, action_flags, user_data);
 	if (action == NULL) {
 		DRV_LOG(ERR, "port %u failed to create %s HWS action",
 			priv->dev_data->port_id,
@@ -125,7 +144,8 @@ mlx5_hws_global_action_drop_get(struct mlx5_priv *priv,
 				 "drop",
 				 table_type,
 				 is_root,
-				 action_create_drop_cb);
+				 action_create_drop_cb,
+				 NULL);
 }
 
 struct mlx5dr_action *
@@ -138,7 +158,8 @@ mlx5_hws_global_action_tag_get(struct mlx5_priv *priv,
 				 "tag",
 				 table_type,
 				 is_root,
-				 action_create_tag_cb);
+				 action_create_tag_cb,
+				 NULL);
 }
 
 struct mlx5dr_action *
@@ -151,7 +172,8 @@ mlx5_hws_global_action_pop_vlan_get(struct mlx5_priv *priv,
 				 "pop_vlan",
 				 table_type,
 				 is_root,
-				 action_create_pop_vlan_cb);
+				 action_create_pop_vlan_cb,
+				 NULL);
 }
 
 struct mlx5dr_action *
@@ -164,5 +186,20 @@ mlx5_hws_global_action_push_vlan_get(struct mlx5_priv *priv,
 				 "push_vlan",
 				 table_type,
 				 is_root,
-				 action_create_push_vlan_cb);
+				 action_create_push_vlan_cb,
+				 NULL);
+}
+
+struct mlx5dr_action *
+mlx5_hws_global_action_send_to_kernel_get(struct mlx5_priv *priv,
+					   enum mlx5dr_table_type table_type,
+					   uint16_t priority)
+{
+	return global_action_get(priv,
+				 &priv->hw_global_actions.send_to_kernel,
+				 "send_to_kernel",
+				 table_type,
+				 false, /* send-to-kernel is non-root only */
+				 action_create_send_to_kernel_cb,
+				 (void *)(uintptr_t)priority);
 }
diff --git a/drivers/net/mlx5/mlx5_hws_global_actions.h b/drivers/net/mlx5/mlx5_hws_global_actions.h
index 4281ba701c..7fbca9fc96 100644
--- a/drivers/net/mlx5/mlx5_hws_global_actions.h
+++ b/drivers/net/mlx5/mlx5_hws_global_actions.h
@@ -28,6 +28,7 @@ struct mlx5_hws_global_actions {
 	struct mlx5_hws_global_actions_array tag;
 	struct mlx5_hws_global_actions_array pop_vlan;
 	struct mlx5_hws_global_actions_array push_vlan;
+	struct mlx5_hws_global_actions_array send_to_kernel;
 	rte_spinlock_t lock;
 };
 
@@ -51,4 +52,8 @@ struct mlx5dr_action *mlx5_hws_global_action_push_vlan_get(struct mlx5_priv *pri
 							   enum mlx5dr_table_type table_type,
 							   bool is_root);
 
+struct mlx5dr_action *mlx5_hws_global_action_send_to_kernel_get(struct mlx5_priv *priv,
+								 enum mlx5dr_table_type table_type,
+								 uint16_t priority);
+
 #endif /* !RTE_PMD_MLX5_HWS_GLOBAL_ACTIONS_H_ */
-- 
2.47.3

