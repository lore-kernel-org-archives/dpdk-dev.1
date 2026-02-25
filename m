Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48233FCEE91
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 12:01:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F09B40609;
	Wed, 25 Feb 2026 13:00:32 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011058.outbound.protection.outlook.com
 [40.93.194.58]) by mails.dpdk.org (Postfix) with ESMTP id 03D9140609
 for <dev@dpdk.org>; Wed, 25 Feb 2026 13:00:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxOB8OOJjzEsaNAE23biHy2M/gVZ4vx+WrG7wPwV2qh55Otb4z5jpJMrFL7Bo/603O39dk3d5SCk/6EMnZIoZf8qCgFNZDOFGGtqXkmHZ4cugubiX9dqEWJyWZieLFohwV1B34wjTXlgyzstpCrRm/22nLeOPywYgsYCuWNTAhB0K4mYHuDBwgynA/Ed5l0/7YKbU51Y+SjRYfVIxEgxN9ijrR/QhCpHYAubBReFJGKSM+elX8I2D44pnyLdge8udDTaiXKOxcCOlGhFn2Sg2Qs8aYy1D0GevcrOk9QfdL+IqibyNQXMf4oOpQGfsKsHTALXqfWNOQq/h3GB051AKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtERM/Sb4FjoAHzcZ4KysWDxKPxxCSZ0nJPRZ1QsSu0=;
 b=K5tYoyodNg5sDaIEf+PHzBfTW7Mkzt1PEt+Qse/W4DZw7b2dpIn2LBl/+lCaCFmO5tnYXLiJ5HbLy7dyKTDrVyJB/d26Dar9oovzkmvfm59qRGb0E08p3tQGbT9sfcfaNOn3Jpwjn4Cy41xuMqXvGILZBs+yOchCsul2RljpfY6fX2BcNMajE+Uv4E2DU4O3i7Al3Hlf4CzKcP1S16lm+LsXj3G0VLiYoz+SyWz495WB5WmzoQtFqXbUl4mEJwd6RYoll3XlCKD9hPtcyItAbEXwQQbRP+dTSm6oUuJ2SBqMIa2Aonly97IxyEuvGzS8ocyGjBBTuvCNeEd2vDV/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtERM/Sb4FjoAHzcZ4KysWDxKPxxCSZ0nJPRZ1QsSu0=;
 b=B3PYw1Md6+cpR5hUv0kwBjpwwre/8Bk5fXcuLNvZf8DiLaOx6IvB0tcpDbC3kWG3BLUcUZ8BD2q7naxcV8+z5QFfBPUmK7ODwPyyZUtf5yTcsdy7/2zTTJdpIyu+Ht/tj0Mwn+18tW6SBiJn1pk4/DUX5VMLNEZSM9yk9ge8YpveD/tqRXnIfK5SNcZNbhkXPNI7XLv/LgqTBDqaTAAUD16gYqyGmpFO7zue47HTSWB5oghJ4NFFT1AJ+Cv66/wS5G70AXEvW5goNqlsGAo2uOwHw/fClOVNViWw35Hp96Xe+2W712FrTvFZIb5S2znfUWWmnp+5bZLZhrvxHZgJFw==
Received: from BN9PR03CA0720.namprd03.prod.outlook.com (2603:10b6:408:ef::35)
 by CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 12:00:25 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:ef:cafe::e1) by BN9PR03CA0720.outlook.office365.com
 (2603:10b6:408:ef::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 11:59:58 +0000
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
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 12:00:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 04:00:09 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 04:00:07 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH 9/9] net/mlx5: lazily allocate HWS default miss action
Date: Wed, 25 Feb 2026 12:59:17 +0100
Message-ID: <20260225115918.233843-10-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb57fd6-085d-4a79-9439-08de74657645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: ENtAfdYYMRkpbjr4J1CccS9Kx1b7UVUzfA49Y3D0J2cSMBxru2HwrHGejlvnmT+piS5RDdU/IiNPBR8w/gYKMgRWz0IRccE2doLZ9E9uc6H7ogIy8/YpxkjWPsNnqXeKtYd4zjMfoFGZX5KySSpYm1Ki787EIecza9+QnGdLjjPnRe4NwSG1jq5J/Ep2JFiZj4SZUomO1e8J2KtRKh7mnJ/3AI/iIP2GfvOCPNlvVdg+jlKRfFXg7MDwyKx63g2W/j51MdQJ5eDPYAxvQe6uEwT3E9yB6Pd/kob7JmPfSdapVr25NarM7yMmWeMr7jC5osOp8VIYySWFJ2z7YNYrV5hcZV9HJjjKm4fckGvfB1Kz25gjWxjLAJxK1pvVwfq2OzvPXV+YGN1GdMf2fbyRpTBB/d4hr3uRUwOpPi2fhxba+XgC4AqFv0keP+HE4rk7+rsw7kdwbUXXb4JcHSHSbnVR8XF/9WdZL9OZ3uqOCK+GTvpiX0yjhDYU874chKVHXQkuxfYAVOOIwd/RGXv40BZBbpLPcR3viSElpYQVej/2iUT3SutIQsIu+6FIu1V2ViagGK4GHS1uL3Sgi+2ZpuIQgaNO2nfBpREhiMGwhDr22qWLC27HzECiwZp8hwWVJud4Tmeby09kdOvvwa5lG2d4B/G3qtXp4om3lFoz1BA8aXmlk4Gzl9S+vMUv4n2Ev+n9ArLsELyC/6tBH/EDW6IOVRC5az8JsKqtiqP4VQivsMk1VVYZ2keNS+vhT7IdESoqtLhKHlhy+sAU5ZMdCxcqAIMIreXI8i8nhsRHua1yTcqBmwSXPdfogaPAjIT7N5gMKmrw3YU05oKlFstIIg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s4cdvxg2AlAFh7RIioa7oVJMOuGTGn23O+aaL5mOCihzB8JMY8SAWITiR4YeFM6o/GlBWZZrCKigSjdT4JEUnFHkgnsMR+KhlAxMvLl2p1D9L5d1fU+52//sFbpOhzv4ZUmSST1hVJyiaa45mb9YrMasstldSExbscD6PMCeODmS+zKMgAqQdCJtyKuFOit4GVwqJC3X4RezdSUNE+OUwHeCyc22+52d5ZPyDb6fLisW7oDUQnewFGqzucXrT2O29JWA4H+YIHg2hjnsWZ0dJhUs7hCMSDE3tHLvqy8HlCtQOmLui8goUl+kekkydBLJeXOAeaBFTcvtLR3O51BYM2YkNHKywkpRe4WCFVeWpfTl0IHjpUegGzowg2W4Wi472E+ner/ZOBtHDpsx92kHitOMcEw5jWgAwZRiCvfzJGMjtXcrf+jvwofG6J7dXKT2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:00:25.6026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb57fd6-085d-4a79-9439-08de74657645
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570
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

HWS default miss action is used to implement PORT_REPRESENTOR
rte_flow action and is used internally for LACP default rules.
It was allocated either on port start or on rte_flow_configure().
This could cause unnecessary FW resource usage
even if user did not use PORT_REPRESENTOR or application
was running on a setup without LACP.

This patch extends global actions internal API,
introduced in previous commits, to allow lazy allocation
of HWS default miss action. It will be allocated on first use
and will be allocated per domain to minimize FW resource usage.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Ori Kam <orika@nvidia.com>
---
 drivers/net/mlx5/mlx5.h                    |  2 -
 drivers/net/mlx5/mlx5_flow_hw.c            | 76 ++++++++++------------
 drivers/net/mlx5/mlx5_hws_global_actions.c | 23 +++++++
 drivers/net/mlx5/mlx5_hws_global_actions.h |  5 ++
 4 files changed, 61 insertions(+), 45 deletions(-)

diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 75e61d6b5b..c54266ec26 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -2113,8 +2113,6 @@ struct mlx5_priv {
 	struct mlx5dr_action **hw_vport;
 	/* HWS global actions. */
 	struct mlx5_hws_global_actions hw_global_actions;
-	/* HW steering global default miss action. */
-	struct mlx5dr_action *hw_def_miss;
 	/* HW steering create ongoing rte flow table list header. */
 	LIST_HEAD(flow_hw_tbl_ongo, rte_flow_template_table) flow_hw_tbl_ongo;
 	struct mlx5_indexed_pool *acts_ipool; /* Action data indexed pool. */
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index c74705be8f..041066a94f 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -2690,7 +2690,16 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 				DRV_LOG(ERR, "Port representor is not supported in root table.");
 				goto err;
 			}
-			acts->rule_acts[dr_pos].action = priv->hw_def_miss;
+			dr_action = mlx5_hws_global_action_def_miss_get(priv, type, is_root);
+			if (dr_action == NULL) {
+				DRV_LOG(ERR, "port %u failed to allocate port representor action",
+					priv->dev_data->port_id);
+				rte_flow_error_set(&sub_error, ENOMEM,
+						   RTE_FLOW_ERROR_TYPE_STATE, NULL,
+						   "failed to allocate port representor action");
+				goto err;
+			}
+			acts->rule_acts[dr_pos].action = dr_action;
 			break;
 		case RTE_FLOW_ACTION_TYPE_FLAG:
 			dr_action = mlx5_hws_global_action_tag_get(priv, type, is_root);
@@ -3017,7 +3026,16 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 				goto err;
 			break;
 		case MLX5_RTE_FLOW_ACTION_TYPE_DEFAULT_MISS:
-			acts->rule_acts[dr_pos].action = priv->hw_def_miss;
+			dr_action = mlx5_hws_global_action_def_miss_get(priv, type, is_root);
+			if (dr_action == NULL) {
+				DRV_LOG(ERR, "port %u failed to allocate default miss action",
+					priv->dev_data->port_id);
+				rte_flow_error_set(&sub_error, ENOMEM,
+						   RTE_FLOW_ERROR_TYPE_STATE, NULL,
+						   "failed to allocate default miss action");
+				goto err;
+			}
+			acts->rule_acts[dr_pos].action = dr_action;
 			break;
 		case RTE_FLOW_ACTION_TYPE_NAT64:
 			if (masks->conf &&
@@ -6913,8 +6931,7 @@ flow_hw_validate_action_push_vlan(struct rte_eth_dev *dev,
 }
 
 static int
-flow_hw_validate_action_default_miss(struct rte_eth_dev *dev,
-				     const struct rte_flow_actions_template_attr *attr,
+flow_hw_validate_action_default_miss(const struct rte_flow_actions_template_attr *attr,
 				     uint64_t action_flags,
 				     struct rte_flow_error *error)
 {
@@ -6923,16 +6940,10 @@ flow_hw_validate_action_default_miss(struct rte_eth_dev *dev,
 	 * flows. So this validation can be ignored. It can be kept right now since
 	 * the validation will be done only once.
 	 */
-	struct mlx5_priv *priv = dev->data->dev_private;
-
 	if (!attr->ingress || attr->egress || attr->transfer)
 		return rte_flow_error_set(error, EINVAL,
 					  RTE_FLOW_ERROR_TYPE_ACTION, NULL,
 					  "DEFAULT MISS is only supported in ingress.");
-	if (!priv->hw_def_miss)
-		return rte_flow_error_set(error, EINVAL,
-					  RTE_FLOW_ERROR_TYPE_ACTION, NULL,
-					  "DEFAULT MISS action does not exist.");
 	if (action_flags & MLX5_FLOW_FATE_ACTIONS)
 		return rte_flow_error_set(error, EINVAL,
 					  RTE_FLOW_ERROR_TYPE_ACTION, NULL,
@@ -7493,8 +7504,7 @@ mlx5_flow_hw_actions_validate(struct rte_eth_dev *dev,
 			actions_end = true;
 			break;
 		case MLX5_RTE_FLOW_ACTION_TYPE_DEFAULT_MISS:
-			ret = flow_hw_validate_action_default_miss(dev, attr,
-								   action_flags, error);
+			ret = flow_hw_validate_action_default_miss(attr, action_flags, error);
 			if (ret < 0)
 				return ret;
 			action_flags |= MLX5_FLOW_ACTION_DEFAULT_MISS;
@@ -11753,8 +11763,6 @@ __mlx5_flow_hw_resource_release(struct rte_eth_dev *dev, bool ctx_close)
 		claim_zero(flow_hw_actions_template_destroy(dev, at, NULL));
 		at = temp_at;
 	}
-	if (priv->hw_def_miss)
-		mlx5dr_action_destroy(priv->hw_def_miss);
 	flow_hw_free_vport_actions(priv);
 	if (priv->acts_ipool) {
 		mlx5_ipool_destroy(priv->acts_ipool);
@@ -11952,9 +11960,7 @@ __flow_hw_configure(struct rte_eth_dev *dev,
 	struct rte_flow_queue_attr **_queue_attr = NULL;
 	struct rte_flow_queue_attr ctrl_queue_attr = {0};
 	bool is_proxy = !!(priv->sh->config.dv_esw_en && priv->master);
-	bool unified_fdb = is_unified_fdb(priv);
 	int ret = 0;
-	uint32_t action_flags;
 	bool strict_queue = false;
 
 	error->type = RTE_FLOW_ERROR_TYPE_NONE;
@@ -12129,30 +12135,6 @@ __flow_hw_configure(struct rte_eth_dev *dev,
 		if (ret)
 			goto err;
 	}
-	/*
-	 * DEFAULT_MISS action have different behaviors in different domains.
-	 * In FDB, it will steering the packets to the E-switch manager.
-	 * In NIC Rx root, it will steering the packet to the kernel driver stack.
-	 * An action with all bits set in the flag can be created and the HWS
-	 * layer will translate it properly when being used in different rules.
-	 */
-	action_flags = MLX5DR_ACTION_FLAG_ROOT_RX | MLX5DR_ACTION_FLAG_HWS_RX |
-		       MLX5DR_ACTION_FLAG_ROOT_TX | MLX5DR_ACTION_FLAG_HWS_TX;
-	if (is_proxy) {
-		if (unified_fdb)
-			action_flags |=
-				(MLX5DR_ACTION_FLAG_ROOT_FDB |
-				 MLX5DR_ACTION_FLAG_HWS_FDB_RX |
-				 MLX5DR_ACTION_FLAG_HWS_FDB_TX |
-				 MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED);
-		else
-			action_flags |=
-				(MLX5DR_ACTION_FLAG_ROOT_FDB |
-				 MLX5DR_ACTION_FLAG_HWS_FDB);
-	}
-	priv->hw_def_miss = mlx5dr_action_create_default_miss(priv->dr_ctx, action_flags);
-	if (!priv->hw_def_miss)
-		goto err;
 	if (is_proxy) {
 		ret = flow_hw_create_vport_actions(priv);
 		if (ret) {
@@ -14599,7 +14581,9 @@ hw_mirror_format_clone(struct rte_eth_dev *dev,
 			const struct mlx5_flow_template_table_cfg *table_cfg,
 			const struct rte_flow_action *actions,
 			struct mlx5dr_action_dest_attr *dest_attr,
-			uint8_t *reformat_buf, struct rte_flow_error *error)
+			uint8_t *reformat_buf,
+			enum mlx5dr_table_type table_type,
+			struct rte_flow_error *error)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	int ret;
@@ -14629,7 +14613,13 @@ hw_mirror_format_clone(struct rte_eth_dev *dev,
 				return ret;
 			break;
 		case RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR:
-			dest_attr->dest = priv->hw_def_miss;
+			dest_attr->dest = mlx5_hws_global_action_def_miss_get(priv,
+									      table_type,
+									      false);
+			if (dest_attr->dest == NULL)
+				return rte_flow_error_set(error, ENOMEM,
+						RTE_FLOW_ERROR_TYPE_STATE, NULL,
+						"failed to allocate port representor action");
 			break;
 		case RTE_FLOW_ACTION_TYPE_RAW_DECAP:
 			decap_seen = true;
@@ -14711,7 +14701,7 @@ mlx5_hw_create_mirror(struct rte_eth_dev *dev,
 		}
 		ret = hw_mirror_format_clone(dev, &mirror->clone[i], table_cfg,
 					     clone_actions, &mirror_attr[i],
-					     reformat_buf[i], error);
+					     reformat_buf[i], table_type, error);
 
 		if (ret)
 			goto error;
diff --git a/drivers/net/mlx5/mlx5_hws_global_actions.c b/drivers/net/mlx5/mlx5_hws_global_actions.c
index 6520879ae4..58b9c44752 100644
--- a/drivers/net/mlx5/mlx5_hws_global_actions.c
+++ b/drivers/net/mlx5/mlx5_hws_global_actions.c
@@ -49,6 +49,7 @@ mlx5_hws_global_actions_cleanup(struct mlx5_priv *priv)
 				     "send_to_kernel");
 	global_actions_array_cleanup(priv, &priv->hw_global_actions.nat64_6to4, "nat64_6to4");
 	global_actions_array_cleanup(priv, &priv->hw_global_actions.nat64_4to6, "nat64_4to6");
+	global_actions_array_cleanup(priv, &priv->hw_global_actions.def_miss, "def_miss");
 
 	rte_spinlock_unlock(&priv->hw_global_actions.lock);
 }
@@ -111,6 +112,14 @@ action_create_nat64_cb(struct mlx5dr_context *ctx,
 					  action_flags | MLX5DR_ACTION_FLAG_SHARED);
 }
 
+static struct mlx5dr_action *
+action_create_def_miss_cb(struct mlx5dr_context *ctx,
+			  uint32_t action_flags,
+			  void *user_data __rte_unused)
+{
+	return mlx5dr_action_create_default_miss(ctx, action_flags);
+}
+
 static struct mlx5dr_action *
 global_action_get(struct mlx5_priv *priv,
 		  struct mlx5_hws_global_actions_array *array,
@@ -248,3 +257,17 @@ mlx5_hws_global_action_nat64_get(struct mlx5_priv *priv,
 	return global_action_get(priv, array, name, table_type,
 				 false, action_create_nat64_cb, &attr);
 }
+
+struct mlx5dr_action *
+mlx5_hws_global_action_def_miss_get(struct mlx5_priv *priv,
+				    enum mlx5dr_table_type table_type,
+				    bool is_root)
+{
+	return global_action_get(priv,
+				 &priv->hw_global_actions.def_miss,
+				 "def_miss",
+				 table_type,
+				 is_root,
+				 action_create_def_miss_cb,
+				 NULL);
+}
diff --git a/drivers/net/mlx5/mlx5_hws_global_actions.h b/drivers/net/mlx5/mlx5_hws_global_actions.h
index 788b5c124a..16dc8d7002 100644
--- a/drivers/net/mlx5/mlx5_hws_global_actions.h
+++ b/drivers/net/mlx5/mlx5_hws_global_actions.h
@@ -32,6 +32,7 @@ struct mlx5_hws_global_actions {
 	struct mlx5_hws_global_actions_array send_to_kernel;
 	struct mlx5_hws_global_actions_array nat64_6to4;
 	struct mlx5_hws_global_actions_array nat64_4to6;
+	struct mlx5_hws_global_actions_array def_miss;
 	rte_spinlock_t lock;
 };
 
@@ -63,4 +64,8 @@ struct mlx5dr_action *mlx5_hws_global_action_nat64_get(struct mlx5_priv *priv,
 						       enum mlx5dr_table_type table_type,
 						       enum rte_flow_nat64_type nat64_type);
 
+struct mlx5dr_action *mlx5_hws_global_action_def_miss_get(struct mlx5_priv *priv,
+							   enum mlx5dr_table_type table_type,
+							   bool is_root);
+
 #endif /* !RTE_PMD_MLX5_HWS_GLOBAL_ACTIONS_H_ */
-- 
2.47.3

