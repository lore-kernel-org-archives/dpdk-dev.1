Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87867FCEE91
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 12:00:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCAF840653;
	Wed, 25 Feb 2026 13:00:22 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012005.outbound.protection.outlook.com
 [40.107.200.5]) by mails.dpdk.org (Postfix) with ESMTP id 26C7740647
 for <dev@dpdk.org>; Wed, 25 Feb 2026 13:00:19 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ghe65opuHaaLVFS09mF5v8R5berQ7d/yo67Gjj69Bv780xzurj9iGBmGVmm2EldnkM2lo+zbCdwwllfGDFKee4RQdndZo07VuPE2GE35cd8IM5Qg82EIyngQjG2Qh6T8hBfemSwxQ8mwcy0V5dT7tYSGUm0ZRoWcRecPH+srsHT2XFLrT2gPJ+evXaXrC3BJ0nReG/qK4fc0bp+8jCMrzN4KRzKynX/vxyejwJVFerDaNVt3SHAFcdy0lY5RUFlPineVmqvZP5MKFIwJ3TAwqC9EPOtjrlJ0YJOQvJlgYmkNZHamwTNWiv8vj9edNVp1HoXjK5gWmHD+SQY5xXPxDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAWoEg3mJE/Oe1Se4ie8wX5iPNPtKtmISnBuUgVYBp4=;
 b=Lh38vdniSfqPRYadHfALtFcudgemDsJ224t7baDttQG/xSwnED4/0eYIwvpaBcDJ9yvqelcG+Sj1VvCDG8cX3njfYq4uW4V2zIvQsYKT6xn9iVDX+lfvyz5sJrHTBtf0B2+qIPH10pp3zKhiRAw8pjsfA5zNAakxJDrVlG9C9+5AR+V734GoVxo98lPOcDr0J7lNV3EJkW7RdtdWvaKb8NgzixiL4eWl/1GFiHVkF0jlOyOBKUu5a1Cc2LNctmTCSfSkeWdCsJShXTOQYGPG4VymAu/kwcQA3NCQO5yzAZMbHoy8aKpCSeBuIK17dTPK3qmzsmoOUCJQY0GZisAZ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAWoEg3mJE/Oe1Se4ie8wX5iPNPtKtmISnBuUgVYBp4=;
 b=Bd9m2dbAS2S1dShhcEjL6KV+CozgD3YccQuUwjbZMVLr396tj3waJU17u/jpq0Nec31+kJ76vOyQ5S59HMBNmo6gnGBosVRVolOU8/1ubxFEpEOMGTkrfAP6x82IGyOgbno856krONPMd9bWMHThcRyEUYR5APSALv5QmPbYjMV3hqio1BJ+lWGrIwCTWPPw/c1L9W+RNpdl2wEITMcNB8KZ/6b9RuovjehKIRUto9zCMMOtaKR+ZP5V48llmiWsxFpefiZpLXN9rbIdjdNHvkuDHp7mJsKHNFgdHq0qgepOAEXct7GOd5j/l7xs011nEfhEAstk1etePoc0GC6w+A==
Received: from BL1PR13CA0320.namprd13.prod.outlook.com (2603:10b6:208:2c1::25)
 by IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 12:00:10 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::ee) by BL1PR13CA0320.outlook.office365.com
 (2603:10b6:208:2c1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Wed,
 25 Feb 2026 11:59:41 +0000
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
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 12:00:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 03:59:55 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 03:59:53 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH 3/9] net/mlx5: lazily allocate drop HWS action
Date: Wed, 25 Feb 2026 12:59:11 +0100
Message-ID: <20260225115918.233843-4-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|IA0PR12MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: c0889e9c-83ea-4099-9ad1-08de74656c0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: EAjQXpWqiv/fzRxf7g0P8gRj5bEUiMmwlu8GVDz8niAlTqJJMx5UUgq3rnbQNLKlUiSOWDCR0w5k1VJgpKbwCDm3MKnO2aLzM8E1Ixpw0ScSBzSjCge1UMRSjj7WiOUIFVCAdfJDGLZcLZJgd8OtPRzYYOYu3I0uYcwRmhdvRssSe22F0guUIS0fYFPifJ7S8jkdU88v7rwS8ABn+h+u4Iw0gmJ2xk6pG+iQy1dk9+7mqok3knAFWWR8FZGnh5AgbJdRmSwzd8gc1inx9sdifCkl0iyo9a2jbIivErkzHU09QOqGCQl47aaeDek06Sb/k+Ms1kv9Z+VrO+VoqAaXZeDRqO3OOPoM1eo5wqSLgRuXIuNQr5KupEXLrjIqt8mJAQjpt0vBITo02J6HT6yDSnFPJW+FJSicdawQ6emBm6CHpjwU7Y2RSF9OPgKghSvOKkZjPWPSArxWYTmZUGeTe68DelTElkz916sJqMcY/WYgMoQLDvQ6EyEB2I8n9hVEaur2hrpGAn08hcxnRbKC0tzKrkBahrvjB/zxRnBzBA4WvjDrwDWCSZWNwuPlTCBdlKhASZIpQ/LDh8CsPF+hhGgKIp94n+n0PmWfv9dGRxqqtZtah90yYWP+CYq0UmMc9TiqJud17aEl3VAXI15WmpvtKvlvnp2+BXyOJywI4dVQ7eEbQGaOMtN9xpDXhK3thTGSvTPPXy4PAsC0gEHK+ulEHExfEXuqZm6W2htJxLzDPjIsTDnlhaVCZ94hASUwXrcBj79nwGWulajKDRm5TpU+aa6AawVBOnC3mFN7R8q7TUXeDuHvTggZaBVc4NTqy50I0WkgEvuhIjVTljlgAQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HjNBveoraNTY/b8ye1EmJovv4wvSyCbfH5FtrFRv/7UwP/H3iII1+Y5lTWwAjvT1/67rgTxuV9PYYya7cZBhVXNFrU31V3fhxlk/w5Wwv6GR9F3Gp2oAqgoSdN1aFpLvfemA6zRyefqBQdu9NwCmHY1j34Muh4EhtWX1b9QKorc6tCgkwDR6k0hhXGqwfXvwrTW6Q/ILU1KnIxzt6m93UJtYAOyK683XoPqeVAyFcnGXuxPmtJHhZGzxFtHlshVGQrUrx5V3Rgriz5TYI4vbBIM00GBpg0Sc5JAZpx3am5u9G34X5FapgMYewlBMQGa5xxCrsYQh9UWU1LuOdqUKiiR96qZjQPPdPsro9L6wPGrXf7KuGGij+TVeiaAYs78tWYdEotKcbLXX0AlsjrDrBC0sd+q9I2klcq1amn1/E2BhRCJH4FVjZH2PpxIhzQvm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:00:08.4489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0889e9c-83ea-4099-9ad1-08de74656c0a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374
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

As of now, HWS drop action used for DROP flow action,
is allocated either on port start or on rte_flow_configure().
This can cause unnecessary FW resource usage
if user does not use any DROP actions.

This patch adds dedicated internal API - mlx5_hws_global_actions -
in mlx5 PMD for lazily allocating HWS drop action, to delay FW resource
allocation until needed.
Instead of allocating HWS drop action supporting all possible domains
(NIC Rx, NIC Tx, FDB if relevant) as it was previously,
separate action will be allocated for each domain as needed
to further minimize FW resource usage.

Follow up commits will extend this API with additional actions
which are pre-allocated on port start or on rte_flow_configure().

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Ori Kam <orika@nvidia.com>
---
 drivers/net/mlx5/meson.build               |  1 +
 drivers/net/mlx5/mlx5.h                    |  5 +-
 drivers/net/mlx5/mlx5_flow_hw.c            | 27 ++++-----
 drivers/net/mlx5/mlx5_hws_global_actions.c | 68 ++++++++++++++++++++++
 drivers/net/mlx5/mlx5_hws_global_actions.h | 39 +++++++++++++
 5 files changed, 123 insertions(+), 17 deletions(-)
 create mode 100644 drivers/net/mlx5/mlx5_hws_global_actions.c
 create mode 100644 drivers/net/mlx5/mlx5_hws_global_actions.h

diff --git a/drivers/net/mlx5/meson.build b/drivers/net/mlx5/meson.build
index 28275bed21..82a7dfe782 100644
--- a/drivers/net/mlx5/meson.build
+++ b/drivers/net/mlx5/meson.build
@@ -53,6 +53,7 @@ if is_linux
             'mlx5_flow_quota.c',
             'mlx5_flow_verbs.c',
             'mlx5_hws_cnt.c',
+            'mlx5_hws_global_actions.c',
             'mlx5_nta_split.c',
             'mlx5_nta_sample.c',
     )
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index e9d855e345..54683cce7a 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -39,6 +39,7 @@
 #define HAVE_MLX5_HWS_SUPPORT 1
 #endif
 #include "hws/mlx5dr.h"
+#include "mlx5_hws_global_actions.h"
 #endif
 
 #define MLX5_SH(dev) (((struct mlx5_priv *)(dev)->data->dev_private)->sh)
@@ -2112,8 +2113,8 @@ struct mlx5_priv {
 	struct mlx5dr_action *hw_push_vlan[MLX5DR_TABLE_TYPE_MAX];
 	struct mlx5dr_action *hw_pop_vlan[MLX5DR_TABLE_TYPE_MAX];
 	struct mlx5dr_action **hw_vport;
-	/* HW steering global drop action. */
-	struct mlx5dr_action *hw_drop[2];
+	/* HWS global actions. */
+	struct mlx5_hws_global_actions hw_global_actions;
 	/* HW steering global tag action. */
 	struct mlx5dr_action *hw_tag[2];
 	/* HW steering global default miss action. */
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index b29909f99d..80e156f26a 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -2634,6 +2634,7 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 	int ret, err;
 	bool is_root = mlx5_group_id_is_root(cfg->attr.flow_attr.group);
 	bool unified_fdb = is_unified_fdb(priv);
+	struct mlx5dr_action *dr_action = NULL;
 
 	flow_hw_modify_field_init(&mhdr, at);
 	type = get_mlx5dr_table_type(attr, cfg->attr.specialize, unified_fdb);
@@ -2672,8 +2673,16 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 		case RTE_FLOW_ACTION_TYPE_VOID:
 			break;
 		case RTE_FLOW_ACTION_TYPE_DROP:
-			acts->rule_acts[dr_pos].action =
-				priv->hw_drop[!!attr->group];
+			dr_action = mlx5_hws_global_action_drop_get(priv, type, is_root);
+			if (dr_action == NULL) {
+				DRV_LOG(ERR, "port %u failed to allocate drop action",
+					priv->dev_data->port_id);
+				rte_flow_error_set(&sub_error, ENOMEM,
+						   RTE_FLOW_ERROR_TYPE_STATE, NULL,
+						   "failed to allocate drop action");
+				goto err;
+			}
+			acts->rule_acts[dr_pos].action = dr_action;
 			break;
 		case RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR:
 			if (is_root) {
@@ -11965,8 +11974,6 @@ __mlx5_flow_hw_resource_release(struct rte_eth_dev *dev, bool ctx_close)
 		at = temp_at;
 	}
 	for (i = 0; i < MLX5_HW_ACTION_FLAG_MAX; i++) {
-		if (priv->hw_drop[i])
-			mlx5dr_action_destroy(priv->hw_drop[i]);
 		if (priv->hw_tag[i])
 			mlx5dr_action_destroy(priv->hw_tag[i]);
 	}
@@ -11995,6 +12002,7 @@ __mlx5_flow_hw_resource_release(struct rte_eth_dev *dev, bool ctx_close)
 		priv->ct_mng = NULL;
 	}
 	mlx5_flow_quota_destroy(dev);
+	mlx5_hws_global_actions_cleanup(priv);
 	if (priv->hw_q) {
 		for (i = 0; i < priv->nb_queue; i++) {
 			struct mlx5_hw_q *hwq = &priv->hw_q[i];
@@ -12345,29 +12353,18 @@ __flow_hw_configure(struct rte_eth_dev *dev,
 			goto err;
 	/* Add global actions. */
 	for (i = 0; i < MLX5_HW_ACTION_FLAG_MAX; i++) {
-		uint32_t act_flags = 0;
 		uint32_t tag_flags = mlx5_hw_act_flag[i][0];
 		bool tag_fdb_rx = !!priv->sh->cdev->config.hca_attr.fdb_rx_set_flow_tag_stc;
 
-		act_flags = mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_NIC_RX] |
-			    mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_NIC_TX];
 		if (is_proxy) {
 			if (unified_fdb) {
-				act_flags |=
-					(mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_RX] |
-					 mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_TX] |
-					 mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_UNIFIED]);
 				if (i == MLX5_HW_ACTION_FLAG_NONE_ROOT && tag_fdb_rx)
 					tag_flags |= mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_RX];
 			} else {
-				act_flags |= mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB];
 				if (i == MLX5_HW_ACTION_FLAG_NONE_ROOT && tag_fdb_rx)
 					tag_flags |= mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB];
 			}
 		}
-		priv->hw_drop[i] = mlx5dr_action_create_dest_drop(priv->dr_ctx, act_flags);
-		if (!priv->hw_drop[i])
-			goto err;
 		priv->hw_tag[i] = mlx5dr_action_create_tag
 			(priv->dr_ctx, tag_flags);
 		if (!priv->hw_tag[i])
diff --git a/drivers/net/mlx5/mlx5_hws_global_actions.c b/drivers/net/mlx5/mlx5_hws_global_actions.c
new file mode 100644
index 0000000000..6af5497123
--- /dev/null
+++ b/drivers/net/mlx5/mlx5_hws_global_actions.c
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 NVIDIA Corporation & Affiliates
+ */
+
+#include "mlx5_hws_global_actions.h"
+
+#include "mlx5.h"
+
+void
+mlx5_hws_global_actions_init(struct mlx5_priv *priv)
+{
+	rte_spinlock_init(&priv->hw_global_actions.lock);
+}
+
+void
+mlx5_hws_global_actions_cleanup(struct mlx5_priv *priv)
+{
+	rte_spinlock_lock(&priv->hw_global_actions.lock);
+
+	for (int i = 0; i < MLX5_HWS_GLOBAL_ACTION_MAX; ++i) {
+		for (int j = 0; j < MLX5DR_TABLE_TYPE_MAX; ++j) {
+			int ret;
+
+			if (priv->hw_global_actions.drop.arr[i][j] == NULL)
+				continue;
+
+			ret = mlx5dr_action_destroy(priv->hw_global_actions.drop.arr[i][j]);
+			if (ret != 0)
+				DRV_LOG(ERR, "port %u failed to free HWS action",
+					priv->dev_data->port_id);
+			priv->hw_global_actions.drop.arr[i][j] = NULL;
+		}
+	}
+
+	rte_spinlock_unlock(&priv->hw_global_actions.lock);
+}
+
+struct mlx5dr_action *
+mlx5_hws_global_action_drop_get(struct mlx5_priv *priv,
+				enum mlx5dr_table_type table_type,
+				bool is_root)
+{
+	enum mlx5dr_action_flags action_flags;
+	struct mlx5dr_action *action = NULL;
+	int ret;
+
+	ret = mlx5dr_table_type_to_action_flags(table_type, is_root, &action_flags);
+	if (ret < 0)
+		return NULL;
+
+	rte_spinlock_lock(&priv->hw_global_actions.lock);
+
+	action = priv->hw_global_actions.drop.arr[!is_root][table_type];
+	if (action != NULL)
+		goto unlock_ret;
+
+	action = mlx5dr_action_create_dest_drop(priv->dr_ctx, action_flags);
+	if (action == NULL) {
+		DRV_LOG(ERR, "port %u failed to create drop HWS action", priv->dev_data->port_id);
+		goto unlock_ret;
+	}
+
+	priv->hw_global_actions.drop.arr[!is_root][table_type] = action;
+
+unlock_ret:
+	rte_spinlock_unlock(&priv->hw_global_actions.lock);
+	return action;
+}
diff --git a/drivers/net/mlx5/mlx5_hws_global_actions.h b/drivers/net/mlx5/mlx5_hws_global_actions.h
new file mode 100644
index 0000000000..3921004102
--- /dev/null
+++ b/drivers/net/mlx5/mlx5_hws_global_actions.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 NVIDIA Corporation & Affiliates
+ */
+
+#ifndef RTE_PMD_MLX5_HWS_GLOBAL_ACTIONS_H_
+#define RTE_PMD_MLX5_HWS_GLOBAL_ACTIONS_H_
+
+#include <stdint.h>
+
+#include <rte_spinlock.h>
+
+#include "hws/mlx5dr.h"
+
+struct mlx5_priv;
+
+enum mlx5_hws_global_action_index {
+	MLX5_HWS_GLOBAL_ACTION_ROOT,
+	MLX5_HWS_GLOBAL_ACTION_NON_ROOT,
+	MLX5_HWS_GLOBAL_ACTION_MAX,
+};
+
+struct mlx5_hws_global_actions_array {
+	struct mlx5dr_action *arr[MLX5_HWS_GLOBAL_ACTION_MAX][MLX5DR_TABLE_TYPE_MAX];
+};
+
+struct mlx5_hws_global_actions {
+	struct mlx5_hws_global_actions_array drop;
+	rte_spinlock_t lock;
+};
+
+void mlx5_hws_global_actions_init(struct mlx5_priv *priv);
+
+void mlx5_hws_global_actions_cleanup(struct mlx5_priv *priv);
+
+struct mlx5dr_action *mlx5_hws_global_action_drop_get(struct mlx5_priv *priv,
+						      enum mlx5dr_table_type table_type,
+						      bool is_root);
+
+#endif /* !RTE_PMD_MLX5_HWS_GLOBAL_ACTIONS_H_ */
-- 
2.47.3

