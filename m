Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3381EFCEE91
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 12:00:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D95F14064F;
	Wed, 25 Feb 2026 13:00:21 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
 by mails.dpdk.org (Postfix) with ESMTP id 17F8E40616
 for <dev@dpdk.org>; Wed, 25 Feb 2026 13:00:19 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5/sKmx5HSycywrhS1w0ruOxhxASAo55Kf0a6qUjDY9+1nhRmPiIsMfPTjvj8uh0/vv2q2wpzt34GBWlLv8zQmqHPif3DIJGa/UJFKFn/FSFWkYGxtxl1Y/QfmlE1boWivT9qeUlQ9tsxULI9UmBPQxGP0JIMdQhUcnwBGx/XnyBO5CIkKcZZEYhdzN1YA1s8yXUNhSUPXb/fNp1VzyUTPiQZC6TSJAYW2LO2xaeYYz9OgQzGBxVjvYm8dojWdwCOKan+RApKTLabPQan3WoMpDdxZP+P0pZiz06tOs9EePHt6VzYSW+kotjoI/cuuctvws0iMG1eNn8NPi1LHwnRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnnv37mx8ZMpm5U3DXPYyMLVFGcJCb/lHBKCfVcpzh4=;
 b=wQcr48DU9lnyzwypBNuxWMQCipDZO7LKjurTjRjkKSODwLJTcJMn94RqqKdoIqwyNNMbo0XkKX5LUXkHUi1DENYoeNEtqwJPG3jhVMHwDcwLcToCjQE9CZqOpDCylgYrq55TRCZWpE93BDN8O1SICiuqecN9+14Y9PgfQjE++fHrWMBvd3ugegELslVzk+nqOTBysoRwQ8RFxEhxL6SjF+2amJRgLznSdHlt4wEjVsCfPxJEBh11g1WlwIeI4/221Get8f0xwfdq+aZkcqqVvYcNTyggs0xAo5lLDfbSS7GwKD0mYPpu04d5/HYDqiCkeLXAqEzRn6diEPc8YptYHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnnv37mx8ZMpm5U3DXPYyMLVFGcJCb/lHBKCfVcpzh4=;
 b=PxmPMw1dzbT6JBmt0swhWCr7AT4osXgGOtSDi2TVIxX3mA+SZT7MeNqOc8qfJU0CEFWZAzrzy8P6EBtC7qJK3uOI1GPpOLSoitVIqf8ys3c78XN+jSkcWwGdvNqmUf7TnSwRl5jkJXgGy0S3J36sn3fSsLtpfESJHXowPkjbsmraFnRUyQc5TniC89MvG2LAJUmm7mfkn9NujqcLd5Z2D5FMI8Bjwmu5CBVRlJ2JlzK1WAODvSTbfN6o/RRFlByOzS+phJ1bbgS725Vp6bQxWxUOVB8tgZz1YQKEXlsUaooPiSt6PKzhOUntFvJHS8EFHPt5KNJ0ahIgKmwbSW3ssg==
Received: from BL1PR13CA0328.namprd13.prod.outlook.com (2603:10b6:208:2c1::33)
 by SA1PR12MB6822.namprd12.prod.outlook.com (2603:10b6:806:25d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 12:00:12 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::a7) by BL1PR13CA0328.outlook.office365.com
 (2603:10b6:208:2c1::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.0 via Frontend Transport; Wed,
 25 Feb 2026 12:00:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 12:00:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 03:59:57 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 03:59:55 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH 4/9] net/mlx5: lazily allocate tag HWS action
Date: Wed, 25 Feb 2026 12:59:12 +0100
Message-ID: <20260225115918.233843-5-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|SA1PR12MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: 345eb7d1-ed02-40f5-a7e2-08de74656e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: Btf24n1aBN16sGjzufcc1aSVe6Pki50w/PSuS3o3T0RSvDCbd9xo0z5uo9nv+0AgYyONqJHFz3NJhIHGNw4at/sT+f/4Cw996ChwF+NDuVAxf1LMQXda9Uwd+kHb+3K1lkChgJgjpUFaAX04a58jDm8X3sNHU882wRby5VCSOWlIe6bltOaH/QgETdwXRX8g9IVkciaP4PAi5Wpv9VTT9YmUsTI+hXStvbGjwje9iQC9et+5kxCDaS5ZvuGYPzxVZxMj91KpZI8lB5XpGKfaJA6WWq71qe9fH+lGzfrmPzCW2Xs8BXnRFCTorCHJP6nKsPc4oOVxVSlxHnSznxMCwvFX/PFooVB4pN2K24yAIozOJlg4KJHUcVlZxcMUNxNoCCR1Vz+Fbjj1Bx/gJHT+fchIzRLkcQDkrMQnv0b0+RSOcn3yBq+7sDFJjk1Z7nkcxYOcA4W2v9EjitBXuOauDH9EaivV1eyIpL2VJLDtTG3L557GOtSqFisQqLVn9UbZETLcRlkwOFZn1usF8w7R7lGaELRAMSWEMl1hYyAylFTCaSqEJzzYTrPTR5DCe/wvDrRDOs1s+BgLogRlxA57JygIHHhef6Z+hsyF0lVHSLZoOb6xLPliXdhGrfMKw6qOUIsDoskT+GJhOd4EwaWmaGwnVfbpLtFHjro2FsdH0V8p8afkGpTMV1VFoyS9YUbtD1srmkQIJKNWSgXKaBYghxczG67N6ZYf9ngExqU34u1ED68N/LqeKo/9kpCsX5VZqyVtz3b77C3rNxf+/4FK1Fw2nCMM4mMx1b2ih6rgB5TAaf5rx0aoVANtf3YXIJ+BEQrwxRRM1wdQ+H6CmQsTqg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l3pcmD7tXAPonnrpv17d51fnr/beOp7fjTbWWhZleROpx9fmf8VFj7Saku6ecZ/ufwQmc5E/tmXwLXqqMeUzcy33Vv7DCnBVPxDkBwgPIX8g33I8hMNr/ETCqGWLmUPp8JnDq8htBKcs/ySbY4I/cG45A2EWDmUOrxWqSnzoEoEiq78YHJyHhygEJpF4tPfiNH9hko19ODfAMWckk8xMvjTC6YbzH4jF3Am9KC3A+unsykKoQDnQDIbHiGNtMzSaiZVEMjI5un7rnjjdCXnuNebkzA9rSA1bWVgrY+tLPWi1kd86cEaBpR9zD8V92E5Z9zR2PQeufs7bvb42aMRPNdRR+PSyy2C2Y8VhlgMMwPHMNfKUUIgLq+5F++4zvO1u2NhXmQLwRffZIHHdfkSeQNJQUNUGMrL+VpGXvWxZ/rwGIITBET7Z327WeBSUmTWQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:00:12.0057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 345eb7d1-ed02-40f5-a7e2-08de74656e28
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6822
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

HWS tag action is used to implement FLAG and MARK rte_flow actions.
It was allocated either on port start or on rte_flow_configure().
This could cause unnecessary FW resource usage
if user did not use any FLAG/MARK actions.

This patch extends global actions internal API,
introduced in previous commit, to allow lazy allocation
of HWS tag action. It will be allocated on first use of
FLAG/MARK action and will be allocated per domain to minimize
FW resource usage.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Ori Kam <orika@nvidia.com>
---
 drivers/net/mlx5/mlx5.h                    |  2 -
 drivers/net/mlx5/mlx5_flow_hw.c            | 47 +++++------
 drivers/net/mlx5/mlx5_hws_global_actions.c | 92 ++++++++++++++++++----
 drivers/net/mlx5/mlx5_hws_global_actions.h |  5 ++
 4 files changed, 100 insertions(+), 46 deletions(-)

diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 54683cce7a..43553b1f35 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -2115,8 +2115,6 @@ struct mlx5_priv {
 	struct mlx5dr_action **hw_vport;
 	/* HWS global actions. */
 	struct mlx5_hws_global_actions hw_global_actions;
-	/* HW steering global tag action. */
-	struct mlx5dr_action *hw_tag[2];
 	/* HW steering global default miss action. */
 	struct mlx5dr_action *hw_def_miss;
 	/* HW steering global send to kernel action. */
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 80e156f26a..54c30264b2 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -2692,16 +2692,33 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 			acts->rule_acts[dr_pos].action = priv->hw_def_miss;
 			break;
 		case RTE_FLOW_ACTION_TYPE_FLAG:
+			dr_action = mlx5_hws_global_action_tag_get(priv, type, is_root);
+			if (dr_action == NULL) {
+				DRV_LOG(ERR, "port %u failed to allocate flag action",
+					priv->dev_data->port_id);
+				rte_flow_error_set(&sub_error, ENOMEM,
+						   RTE_FLOW_ERROR_TYPE_STATE, NULL,
+						   "failed to allocate flag action");
+				goto err;
+			}
 			acts->mark = true;
 			acts->rule_acts[dr_pos].tag.value =
 				mlx5_flow_mark_set(MLX5_FLOW_MARK_DEFAULT);
-			acts->rule_acts[dr_pos].action =
-				priv->hw_tag[!!attr->group];
+			acts->rule_acts[dr_pos].action = dr_action;
 			rte_atomic_fetch_add_explicit(&priv->hws_mark_refcnt, 1,
 					rte_memory_order_relaxed);
 			mlx5_flow_hw_rxq_flag_set(dev, true);
 			break;
 		case RTE_FLOW_ACTION_TYPE_MARK:
+			dr_action = mlx5_hws_global_action_tag_get(priv, type, is_root);
+			if (dr_action == NULL) {
+				DRV_LOG(ERR, "port %u failed to allocate mark action",
+					priv->dev_data->port_id);
+				rte_flow_error_set(&sub_error, ENOMEM,
+						   RTE_FLOW_ERROR_TYPE_STATE, NULL,
+						   "failed to allocate mark action");
+				goto err;
+			}
 			acts->mark = true;
 			if (masks->conf &&
 			    ((const struct rte_flow_action_mark *)
@@ -2714,8 +2731,7 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 								   actions->type,
 								   src_pos, dr_pos))
 				goto err;
-			acts->rule_acts[dr_pos].action =
-				priv->hw_tag[!!attr->group];
+			acts->rule_acts[dr_pos].action = dr_action;
 			rte_atomic_fetch_add_explicit(&priv->hws_mark_refcnt, 1,
 					rte_memory_order_relaxed);
 			mlx5_flow_hw_rxq_flag_set(dev, true);
@@ -11973,10 +11989,6 @@ __mlx5_flow_hw_resource_release(struct rte_eth_dev *dev, bool ctx_close)
 		claim_zero(flow_hw_actions_template_destroy(dev, at, NULL));
 		at = temp_at;
 	}
-	for (i = 0; i < MLX5_HW_ACTION_FLAG_MAX; i++) {
-		if (priv->hw_tag[i])
-			mlx5dr_action_destroy(priv->hw_tag[i]);
-	}
 	if (priv->hw_def_miss)
 		mlx5dr_action_destroy(priv->hw_def_miss);
 	flow_hw_destroy_nat64_actions(priv);
@@ -12351,25 +12363,6 @@ __flow_hw_configure(struct rte_eth_dev *dev,
 	if (port_attr->nb_meters || (host_priv && host_priv->hws_mpool))
 		if (mlx5_flow_meter_init(dev, port_attr->nb_meters, 0, 0, nb_q_updated))
 			goto err;
-	/* Add global actions. */
-	for (i = 0; i < MLX5_HW_ACTION_FLAG_MAX; i++) {
-		uint32_t tag_flags = mlx5_hw_act_flag[i][0];
-		bool tag_fdb_rx = !!priv->sh->cdev->config.hca_attr.fdb_rx_set_flow_tag_stc;
-
-		if (is_proxy) {
-			if (unified_fdb) {
-				if (i == MLX5_HW_ACTION_FLAG_NONE_ROOT && tag_fdb_rx)
-					tag_flags |= mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_RX];
-			} else {
-				if (i == MLX5_HW_ACTION_FLAG_NONE_ROOT && tag_fdb_rx)
-					tag_flags |= mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB];
-			}
-		}
-		priv->hw_tag[i] = mlx5dr_action_create_tag
-			(priv->dr_ctx, tag_flags);
-		if (!priv->hw_tag[i])
-			goto err;
-	}
 	if (priv->sh->config.dv_esw_en) {
 		ret = flow_hw_setup_tx_repr_tagging(dev, error);
 		if (ret)
diff --git a/drivers/net/mlx5/mlx5_hws_global_actions.c b/drivers/net/mlx5/mlx5_hws_global_actions.c
index 6af5497123..1ca444ce98 100644
--- a/drivers/net/mlx5/mlx5_hws_global_actions.c
+++ b/drivers/net/mlx5/mlx5_hws_global_actions.c
@@ -12,33 +12,63 @@ mlx5_hws_global_actions_init(struct mlx5_priv *priv)
 	rte_spinlock_init(&priv->hw_global_actions.lock);
 }
 
-void
-mlx5_hws_global_actions_cleanup(struct mlx5_priv *priv)
+static void
+global_actions_array_cleanup(struct mlx5_priv *priv,
+			     struct mlx5_hws_global_actions_array *array,
+			     const char *name)
 {
-	rte_spinlock_lock(&priv->hw_global_actions.lock);
-
 	for (int i = 0; i < MLX5_HWS_GLOBAL_ACTION_MAX; ++i) {
 		for (int j = 0; j < MLX5DR_TABLE_TYPE_MAX; ++j) {
 			int ret;
 
-			if (priv->hw_global_actions.drop.arr[i][j] == NULL)
+			if (array->arr[i][j] == NULL)
 				continue;
 
-			ret = mlx5dr_action_destroy(priv->hw_global_actions.drop.arr[i][j]);
+			ret = mlx5dr_action_destroy(array->arr[i][j]);
 			if (ret != 0)
-				DRV_LOG(ERR, "port %u failed to free HWS action",
-					priv->dev_data->port_id);
-			priv->hw_global_actions.drop.arr[i][j] = NULL;
+				DRV_LOG(ERR, "port %u failed to free %s HWS action",
+					priv->dev_data->port_id,
+					name);
+			array->arr[i][j] = NULL;
 		}
 	}
+}
+
+void
+mlx5_hws_global_actions_cleanup(struct mlx5_priv *priv)
+{
+	rte_spinlock_lock(&priv->hw_global_actions.lock);
+
+	global_actions_array_cleanup(priv, &priv->hw_global_actions.drop, "drop");
+	global_actions_array_cleanup(priv, &priv->hw_global_actions.tag, "tag");
 
 	rte_spinlock_unlock(&priv->hw_global_actions.lock);
 }
 
-struct mlx5dr_action *
-mlx5_hws_global_action_drop_get(struct mlx5_priv *priv,
-				enum mlx5dr_table_type table_type,
-				bool is_root)
+typedef struct mlx5dr_action *(*global_action_create_t)(struct mlx5dr_context *ctx,
+							uint32_t action_flags);
+
+static struct mlx5dr_action *
+action_create_drop_cb(struct mlx5dr_context *ctx,
+		      uint32_t action_flags)
+{
+	return mlx5dr_action_create_dest_drop(ctx, action_flags);
+}
+
+static struct mlx5dr_action *
+action_create_tag_cb(struct mlx5dr_context *ctx,
+		     uint32_t action_flags)
+{
+	return mlx5dr_action_create_tag(ctx, action_flags);
+}
+
+static struct mlx5dr_action *
+global_action_get(struct mlx5_priv *priv,
+		  struct mlx5_hws_global_actions_array *array,
+		  const char *name,
+		  enum mlx5dr_table_type table_type,
+		  bool is_root,
+		  global_action_create_t create_cb)
 {
 	enum mlx5dr_action_flags action_flags;
 	struct mlx5dr_action *action = NULL;
@@ -50,19 +80,47 @@ mlx5_hws_global_action_drop_get(struct mlx5_priv *priv,
 
 	rte_spinlock_lock(&priv->hw_global_actions.lock);
 
-	action = priv->hw_global_actions.drop.arr[!is_root][table_type];
+	action = array->arr[!is_root][table_type];
 	if (action != NULL)
 		goto unlock_ret;
 
-	action = mlx5dr_action_create_dest_drop(priv->dr_ctx, action_flags);
+	action = create_cb(priv->dr_ctx, action_flags);
 	if (action == NULL) {
-		DRV_LOG(ERR, "port %u failed to create drop HWS action", priv->dev_data->port_id);
+		DRV_LOG(ERR, "port %u failed to create %s HWS action",
+			priv->dev_data->port_id,
+			name);
 		goto unlock_ret;
 	}
 
-	priv->hw_global_actions.drop.arr[!is_root][table_type] = action;
+	array->arr[!is_root][table_type] = action;
 
 unlock_ret:
 	rte_spinlock_unlock(&priv->hw_global_actions.lock);
 	return action;
 }
+
+struct mlx5dr_action *
+mlx5_hws_global_action_drop_get(struct mlx5_priv *priv,
+				enum mlx5dr_table_type table_type,
+				bool is_root)
+{
+	return global_action_get(priv,
+				 &priv->hw_global_actions.drop,
+				 "drop",
+				 table_type,
+				 is_root,
+				 action_create_drop_cb);
+}
+
+struct mlx5dr_action *
+mlx5_hws_global_action_tag_get(struct mlx5_priv *priv,
+			       enum mlx5dr_table_type table_type,
+			       bool is_root)
+{
+	return global_action_get(priv,
+				 &priv->hw_global_actions.tag,
+				 "tag",
+				 table_type,
+				 is_root,
+				 action_create_tag_cb);
+}
diff --git a/drivers/net/mlx5/mlx5_hws_global_actions.h b/drivers/net/mlx5/mlx5_hws_global_actions.h
index 3921004102..bec9f3e0e8 100644
--- a/drivers/net/mlx5/mlx5_hws_global_actions.h
+++ b/drivers/net/mlx5/mlx5_hws_global_actions.h
@@ -25,6 +25,7 @@ struct mlx5_hws_global_actions_array {
 
 struct mlx5_hws_global_actions {
 	struct mlx5_hws_global_actions_array drop;
+	struct mlx5_hws_global_actions_array tag;
 	rte_spinlock_t lock;
 };
 
@@ -36,4 +37,8 @@ struct mlx5dr_action *mlx5_hws_global_action_drop_get(struct mlx5_priv *priv,
 						      enum mlx5dr_table_type table_type,
 						      bool is_root);
 
+struct mlx5dr_action *mlx5_hws_global_action_tag_get(struct mlx5_priv *priv,
+						     enum mlx5dr_table_type table_type,
+						     bool is_root);
+
 #endif /* !RTE_PMD_MLX5_HWS_GLOBAL_ACTIONS_H_ */
-- 
2.47.3

