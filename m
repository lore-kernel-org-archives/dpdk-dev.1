Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F38FCEE8A
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 12:00:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C835440658;
	Wed, 25 Feb 2026 13:00:23 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
 by mails.dpdk.org (Postfix) with ESMTP id 405B340647
 for <dev@dpdk.org>; Wed, 25 Feb 2026 13:00:22 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZHS1bMr/yToitoRPvKCZDE/MbAEqMWR9wy4mF6RRE2tXrb9wUfe5v/Itvede+K4xXxNxidORZ93KRQuSaeHi2sNJ0uHpuR2B9nPh0kGV972i0gqjwrgv4Jrlbp+w3XmoxogCqiocGoVKvCnVdS5SPFse5DOn+G5jrbrpsOflPOV5KhWNJRiWFKNGwAanI6CE3rmm5J2Qz78eHQfz1i1zOv0TestPHihdOfHsIdY6WFDONIepGXRwWKB+JLoUldk2a9Vid07SYAuwQNPC++IN6fnLoI6O+Iqn6HlVQtPlXwBnUrp51zWmalWKHfimZsjubawRY/B+bmjV08m0x6T/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9t7wk5XD7MPKnWFb1TA+Ypt4p1ClrI1VyOlyWhh0sIE=;
 b=MU9o0X2dorhaLGGaHas1FE+d6ucfLoulh2A25Gayd2CbO72GX7GgVWOhHr3SD4RfhiTzG4pfixbZsdnDBkLj8BnUUhXNRTXXeYD0QXgWnaH65XwiBaQpS786bFiQiOIDHvONFNl6II+09Q2i0GRxqyjhN3mzpy0/5cMfkpr9U2RLnIwvWJiMJYpvFMBu8FFLWO5QMYUhEDVwaQTugnSMxJ4OS39ttcfBwK/1RYXuy+17hyKI1XPGUlGGKlOB4eqb78IowikBDpDNLlaByquPDdkG+pvVO0N+ye1iNJQ7zVM78XO/+DecKi268yaDrilxZf0C+0trO15NXBGwdIDfsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9t7wk5XD7MPKnWFb1TA+Ypt4p1ClrI1VyOlyWhh0sIE=;
 b=lBq2YwWt08GNLnG1GPVHHVJAwiKvvRwkZ22XLpIh1FvN5y6cebmJRCntjxtbB01bjrCpvqA/v0Mfu9ryPbFAEtjvkVdytf7Iq8oPoy/s6m3XOYJqbhYuaaCufj6aHpOkEKHQtGGA9CM7ThNO4ANv9MxhplSYe3GAw0/swz0m84OzGjShz69iOkAVbDohL8QnGTgiYw+8zoxbmR5spKoKm3PvJzHbwvRHThb8mnXHRRQa0mrAu22Ahucsi4qMMCHqzmsYWnlr7yPYN5DXjqMZr+6d7gBOFGR/hdiNUJ7B5EDoDNm/bk/xT5+tCLLzNkpGdILOvfkZc+ireFQsbqM97Q==
Received: from BLAPR05CA0006.namprd05.prod.outlook.com (2603:10b6:208:36e::9)
 by MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 12:00:14 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::7a) by BLAPR05CA0006.outlook.office365.com
 (2603:10b6:208:36e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 12:00:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 12:00:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 04:00:02 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 04:00:00 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH 6/9] net/mlx5: lazily allocate HWS push VLAN action
Date: Wed, 25 Feb 2026 12:59:14 +0100
Message-ID: <20260225115918.233843-7-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|MW4PR12MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d5e1b4-be3e-4bbc-97bd-08de74656f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: nZi2nYGrVQp1QfBMTN8NSzD4Zs9TnXbASrq1l1fTKmeXjrK6jjvyJI/JHxaVF+VtfpnFy4DkxyBCMeDz2p9jj0aeWDJ00nWotDvLbDio9WFYkD/MlnCHIhEYfHAIX1MryvhvWG13fDljMw4dUYFXkfPkPNuO62wirE9IHMesN1/G7jda7S0blSlfHejIvLtAgGnkoiLjYRPlpYiveQOnzonl5yFUYJRai1BLxx/7OuTFM4Z31N7/JjcWYtwYMUx5+ZGzjwwMkQ6+Lx/c3SMSQC5oTwHC8A7282F2mkRWd5N6ktbd5NTQG2i4mAxdvS+zergbIFrrQSRoR1PgaTiKcEkQbMOjogENydfbcnWshpN8kLka+EVyf1Z3zgdYMkrqIIGew+xePezHv2YH+tX5kQcpORrKvkODbsMH/RNxwTDvYTXmOoECjX2dY6iPw82ectoli12aXMt7GmfnKxhXM37hsd32LELeEPK1G9w6lL1caxCKb6M/jbghoF1voLjt0cPFJ74wqwQOFxzGBg9mkBRUsxj5WEA/ruBt7ymzOL1sNRDxqMGXh6otpmjsbQCST27+d9lxZ7yvXx/9nv9dkGplgtj1bUwB6fRZskWpwA+aIArdM6R0erraL2OlO3oHYwpFfpxBjZw2GrZOzj45q8faeLi+pn6epSqkdqZfXNVpzHkTl+QQQP7EX3+NuWzNoEGZZ7mMirqyjL+B5izldBahq6TdH2TJIs5VDlM8Wk6gp/AI2BO0Bb2NETqD+j2kVN3Kjkp6+U+/QLwFnc0ozQK5gQ2S65qjHEcKcFiHtpdIqQDMJZuxKy/flmkR2OLy6TeFlGQa/fSlRHdeZd9Gkg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gHflWQZ29w5anLnV6v6hor+NGYPpPtKfFpyCm1wSen5sk775l2y1uOVTHp7Q4FFCp0LdagYC59pQhNS0eak+Z/LzArhA0/zsmNgIXnJevj8D4uW7yDIPLmZV0upE1wBR5SqeX0TRNdZmUd6j4Mgk9bGrnC453yb1tBCw3z4hIEV2Q9yCfNWg1OZ3c18PdbOBJCSe5eUfaMWdoADatp+3ImBGHzYtSM2GiDzUMVG30fhpxmin4iD4pey90gQRgzMsECanXvqx8/GF51h8X8GFSQZ4EVxUZIc1DlydqXQ2+zAE6TH3ixfEuEC9gmCwqACOKzfebUizS9o+J9VeIdTN2G/KFZ13EMkokJFugPqqDM+EZMlJk0fOxk2X8A5A/8Ko3b1dKT3L11pJIf8+518n+EV3mGOQI9DMIfskGYKKTysSK0xqZCSyRsgJqxb39HEc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:00:14.2529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d5e1b4-be3e-4bbc-97bd-08de74656f80
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5667
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

HWS push_vlan action is used to implement OF_PUSH_VLAN rte_flow action.
It was allocated either on port start or on rte_flow_configure().
This could cause unnecessary FW resource usage
if user did not use any OF_PUSH_VLAN action.

This patch extends global actions internal API,
introduced in previous commits, to allow lazy allocation
of HWS push_vlan action. It will be allocated on first use
and will be allocated per domain to minimize FW resource usage.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Ori Kam <orika@nvidia.com>
---
 drivers/net/mlx5/mlx5.h                    |  1 -
 drivers/net/mlx5/mlx5_flow_hw.c            | 78 +++-------------------
 drivers/net/mlx5/mlx5_hws_global_actions.c | 21 ++++++
 drivers/net/mlx5/mlx5_hws_global_actions.h |  5 ++
 4 files changed, 36 insertions(+), 69 deletions(-)

diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 9e46a8cee8..94b4cb0d7b 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -2110,7 +2110,6 @@ struct mlx5_priv {
 	LIST_HEAD(flow_hw_tbl, rte_flow_template_table) flow_hw_tbl;
 	/* HW steering rte flow group list header */
 	LIST_HEAD(flow_hw_grp, mlx5_flow_group) flow_hw_grp;
-	struct mlx5dr_action *hw_push_vlan[MLX5DR_TABLE_TYPE_MAX];
 	struct mlx5dr_action **hw_vport;
 	/* HWS global actions. */
 	struct mlx5_hws_global_actions hw_global_actions;
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 21c61bce90..2ecae1b7e7 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -2737,8 +2737,16 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 			mlx5_flow_hw_rxq_flag_set(dev, true);
 			break;
 		case RTE_FLOW_ACTION_TYPE_OF_PUSH_VLAN:
-			acts->rule_acts[dr_pos].action =
-				priv->hw_push_vlan[type];
+			dr_action = mlx5_hws_global_action_push_vlan_get(priv, type, is_root);
+			if (dr_action == NULL) {
+				DRV_LOG(ERR, "port %u failed to allocate push VLAN action",
+					priv->dev_data->port_id);
+				rte_flow_error_set(&sub_error, ENOMEM,
+						   RTE_FLOW_ERROR_TYPE_STATE, NULL,
+						   "failed to allocate push VLAN action");
+				goto err;
+			}
+			acts->rule_acts[dr_pos].action = dr_action;
 			if (is_template_masked_push_vlan(masks->conf))
 				acts->rule_acts[dr_pos].push_vlan.vlan_hdr =
 					vlan_hdr_to_be32(actions);
@@ -11378,65 +11386,6 @@ mlx5_flow_ct_init(struct rte_eth_dev *dev,
 	return ret;
 }
 
-static void
-flow_hw_destroy_vlan(struct rte_eth_dev *dev)
-{
-	struct mlx5_priv *priv = dev->data->dev_private;
-	enum mlx5dr_table_type i;
-
-	for (i = MLX5DR_TABLE_TYPE_NIC_RX; i < MLX5DR_TABLE_TYPE_MAX; i++) {
-		if (priv->hw_push_vlan[i]) {
-			mlx5dr_action_destroy(priv->hw_push_vlan[i]);
-			priv->hw_push_vlan[i] = NULL;
-		}
-	}
-}
-
-static int
-_create_vlan(struct mlx5_priv *priv, enum mlx5dr_table_type type)
-{
-	const enum mlx5dr_action_flags flags[MLX5DR_TABLE_TYPE_MAX] = {
-		MLX5DR_ACTION_FLAG_HWS_RX,
-		MLX5DR_ACTION_FLAG_HWS_TX,
-		MLX5DR_ACTION_FLAG_HWS_FDB,
-		MLX5DR_ACTION_FLAG_HWS_FDB_RX,
-		MLX5DR_ACTION_FLAG_HWS_FDB_TX,
-		MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED,
-	};
-
-	/* rte_errno is set in the mlx5dr_action* functions. */
-	priv->hw_push_vlan[type] =
-		mlx5dr_action_create_push_vlan(priv->dr_ctx, flags[type]);
-	if (!priv->hw_push_vlan[type])
-		return -rte_errno;
-	return 0;
-}
-
-static int
-flow_hw_create_vlan(struct rte_eth_dev *dev)
-{
-	struct mlx5_priv *priv = dev->data->dev_private;
-	enum mlx5dr_table_type i, from, to;
-	int rc;
-	bool unified_fdb = is_unified_fdb(priv);
-
-	for (i = MLX5DR_TABLE_TYPE_NIC_RX; i <= MLX5DR_TABLE_TYPE_NIC_TX; i++) {
-		rc = _create_vlan(priv, i);
-		if (rc)
-			return rc;
-	}
-	from = unified_fdb ? MLX5DR_TABLE_TYPE_FDB_RX : MLX5DR_TABLE_TYPE_FDB;
-	to = unified_fdb ? MLX5DR_TABLE_TYPE_FDB_UNIFIED : MLX5DR_TABLE_TYPE_FDB;
-	if (priv->sh->config.dv_esw_en && priv->master) {
-		for (i = from; i <= to; i++) {
-			rc = _create_vlan(priv, i);
-			if (rc)
-				return rc;
-		}
-	}
-	return 0;
-}
-
 void
 mlx5_flow_hw_cleanup_ctrl_rx_tables(struct rte_eth_dev *dev)
 {
@@ -11992,7 +11941,6 @@ __mlx5_flow_hw_resource_release(struct rte_eth_dev *dev, bool ctx_close)
 	if (priv->hw_def_miss)
 		mlx5dr_action_destroy(priv->hw_def_miss);
 	flow_hw_destroy_nat64_actions(priv);
-	flow_hw_destroy_vlan(dev);
 	flow_hw_destroy_send_to_kernel_action(priv);
 	flow_hw_free_vport_actions(priv);
 	if (priv->acts_ipool) {
@@ -12452,12 +12400,6 @@ __flow_hw_configure(struct rte_eth_dev *dev,
 		if (ret < 0)
 			goto err;
 	}
-	ret = flow_hw_create_vlan(dev);
-	if (ret) {
-		rte_flow_error_set(error, -ret, RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				   NULL, "Failed to VLAN actions.");
-		goto err;
-	}
 	if (flow_hw_should_create_nat64_actions(priv)) {
 		if (flow_hw_create_nat64_actions(priv, error))
 			goto err;
diff --git a/drivers/net/mlx5/mlx5_hws_global_actions.c b/drivers/net/mlx5/mlx5_hws_global_actions.c
index 236e6f1d1a..2bbfa5a24c 100644
--- a/drivers/net/mlx5/mlx5_hws_global_actions.c
+++ b/drivers/net/mlx5/mlx5_hws_global_actions.c
@@ -42,6 +42,7 @@ mlx5_hws_global_actions_cleanup(struct mlx5_priv *priv)
 	global_actions_array_cleanup(priv, &priv->hw_global_actions.drop, "drop");
 	global_actions_array_cleanup(priv, &priv->hw_global_actions.tag, "tag");
 	global_actions_array_cleanup(priv, &priv->hw_global_actions.pop_vlan, "pop_vlan");
+	global_actions_array_cleanup(priv, &priv->hw_global_actions.push_vlan, "push_vlan");
 
 	rte_spinlock_unlock(&priv->hw_global_actions.lock);
 }
@@ -70,6 +71,13 @@ action_create_pop_vlan_cb(struct mlx5dr_context *ctx,
 	return mlx5dr_action_create_pop_vlan(ctx, action_flags);
 }
 
+static struct mlx5dr_action *
+action_create_push_vlan_cb(struct mlx5dr_context *ctx,
+			   uint32_t action_flags)
+{
+	return mlx5dr_action_create_push_vlan(ctx, action_flags);
+}
+
 static struct mlx5dr_action *
 global_action_get(struct mlx5_priv *priv,
 		  struct mlx5_hws_global_actions_array *array,
@@ -145,3 +153,16 @@ mlx5_hws_global_action_pop_vlan_get(struct mlx5_priv *priv,
 				 is_root,
 				 action_create_pop_vlan_cb);
 }
+
+struct mlx5dr_action *
+mlx5_hws_global_action_push_vlan_get(struct mlx5_priv *priv,
+				     enum mlx5dr_table_type table_type,
+				     bool is_root)
+{
+	return global_action_get(priv,
+				 &priv->hw_global_actions.push_vlan,
+				 "push_vlan",
+				 table_type,
+				 is_root,
+				 action_create_push_vlan_cb);
+}
diff --git a/drivers/net/mlx5/mlx5_hws_global_actions.h b/drivers/net/mlx5/mlx5_hws_global_actions.h
index d04ebc42be..4281ba701c 100644
--- a/drivers/net/mlx5/mlx5_hws_global_actions.h
+++ b/drivers/net/mlx5/mlx5_hws_global_actions.h
@@ -27,6 +27,7 @@ struct mlx5_hws_global_actions {
 	struct mlx5_hws_global_actions_array drop;
 	struct mlx5_hws_global_actions_array tag;
 	struct mlx5_hws_global_actions_array pop_vlan;
+	struct mlx5_hws_global_actions_array push_vlan;
 	rte_spinlock_t lock;
 };
 
@@ -46,4 +47,8 @@ struct mlx5dr_action *mlx5_hws_global_action_pop_vlan_get(struct mlx5_priv *priv
 							  enum mlx5dr_table_type table_type,
 							  bool is_root);
 
+struct mlx5dr_action *mlx5_hws_global_action_push_vlan_get(struct mlx5_priv *priv,
+							   enum mlx5dr_table_type table_type,
+							   bool is_root);
+
 #endif /* !RTE_PMD_MLX5_HWS_GLOBAL_ACTIONS_H_ */
-- 
2.47.3

