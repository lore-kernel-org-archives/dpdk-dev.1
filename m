Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94271CA0FE9
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 11:47:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCEDD40612;
	Tue, 26 Aug 2025 13:46:55 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by mails.dpdk.org (Postfix) with ESMTP id 47F8E40156
 for <dev@dpdk.org>; Tue, 26 Aug 2025 13:46:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQqAio/7ZsL1adOiFrSZt/Np7Av94OZ5eQVj7GRbh3ic9kwc0Bi+QhIjUqMHA0IWWQU12LLZppanM28kqCXFQNHMWA/X6DkJSlUCA4JBmZRXj6ow9ppwMHuWVNzO8wymFH94KzAHUocSzcy1yYV3xka52Lipg7bEuhSb41yRi7qOCrD2Y06MSARNAXNa24YsMuCUnrzhqUwkE7ccxJTCfkHqTCvULonJy8egd0/uKHale4s+htRsASEs5AQ29WAppx0rIIOFLBE+g/N237Ecx4N8KaquZ0i5DCReyBDS61KVxuPVnQ6/koPhLJU5kytS/vcQ2VwX7GfKEwnLiRQ4lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0aU2mYp8waVf+VeWRiZGPcX/0UBpI1Xjriz++VSdiU=;
 b=KfhLj4m0zkbfX70krJoWqprS6nO67FkVXaQRjDoyDdXydWdC3Zdw8nMwUpZpNBm3lrK7IytCmpt8UA52vnnrfZ06wMjCITtPTTakscgUZxh+G20hLusAWKIHIu+zHC3EFVtbuMi+fYp5XXCOF1juh0Kc/dvIJuv2N+JW9G9skf0hiw+sLTy2sK1ZwPkVWx+LoBMK+0CxbXI3Cp6N29cjWQJLgzH1BCgUz8cPYBmYKAszibFwa/QYP+E5BOETFtv4fKrqe8yM/6Ibb6HqVjtxh+9edI4ZDjrJCJi4BzusVvxe+01aqSv5SNBJ8M45zlS4EkhadySL7OzjyZyde4e4aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0aU2mYp8waVf+VeWRiZGPcX/0UBpI1Xjriz++VSdiU=;
 b=ZnNKbJYu1h8gIy8TteziLeCnY+wI+LnbZUzzzeXBdx7pRwqgdD4hSuQ/x2NAOMt1Fcf3dfLBZB921L3OuFb1nkOJ0gPVhSYWjdii926FFWLmlT5uSPAu02/Bx9xnDW7opk1csRWxhJuwRXoQFdoyGRB4JTc835bKFpANYRGvfoX02ikKJF0BwDdfYX3gHQllAfLJZ1nwZfNRNYkmBZM/t7x3zTMJ9humDu6KnDzW2F+A57KxoyzQU6JyW1eC6yOocMahFLNYVbVz7IVRAx8Kg9WmZhf5kPZnTKu2uIHbrCn/2bLzqBuMSIkRCCHOWhV17ZXBaskBIYPOaVepV+EZOQ==
Received: from BY5PR20CA0024.namprd20.prod.outlook.com (2603:10b6:a03:1f4::37)
 by SJ0PR12MB6855.namprd12.prod.outlook.com (2603:10b6:a03:47e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 11:46:48 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::62) by BY5PR20CA0024.outlook.office365.com
 (2603:10b6:a03:1f4::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 11:46:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.0 via Frontend Transport; Tue, 26 Aug 2025 11:46:48 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 26 Aug
 2025 04:46:38 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 26 Aug 2025 04:46:38 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 26 Aug 2025 04:46:35 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH 4/4] net/mlx5: add steering toggle API
Date: Tue, 26 Aug 2025 14:45:55 +0300
Message-ID: <20250826114556.10068-5-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20250826114556.10068-1-mkashani@nvidia.com>
References: <20250826114556.10068-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|SJ0PR12MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: fe7c10f2-ab72-4398-44c5-08dde4963da0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GgwjlsN62m4XLAIqF9LvRA8sxpK19cmJpNwjypaQXYhgj2A4CeTcju4/VX6A?=
 =?us-ascii?Q?iJfToiaa+/jOVcUylhx5Fz/zTNvLg/hpGum8B2P5/gHrL9vqLLAuEqgi+Q6T?=
 =?us-ascii?Q?jtFs6aNbkg47+CJ7jKnheXqRrSojvP8KXJgMWsAHLLFciX6TPYfrUG8ZdfxV?=
 =?us-ascii?Q?Q/zZAh41nSaN1PpPLSvF8d/WsNIV7t2q/3emgrh46azHuTJ2ZUGnNIFNkcfC?=
 =?us-ascii?Q?mvaUYCCHrJ9d/KfObQXuWSenMJkhDINxC0tB35GkPOBkdif6FI9ixtfmtmLh?=
 =?us-ascii?Q?+2BLJOaAYkOxlCIM4F5D1t1OS34GGbAvUK+uOIRr3u7t4tKEEi3buKpE26of?=
 =?us-ascii?Q?xEEkN5v+5k5DTMvrD3aQ7iRzYnf3TBzhSZP5pO7ynoHY9NRizkfpmlYTJP2k?=
 =?us-ascii?Q?B7WItc3MISdc9MKpIZv3YGjxJseybHd1OX/42nQB/l8okebVFaHwmSs//7Mn?=
 =?us-ascii?Q?15ugl34cy1Vl3kIe0hcgWXsO8FsAA7QYDy2YKkBfPcfQjEAa7kM9+IpVIcye?=
 =?us-ascii?Q?li8etkQkp5kTPpTl6gwJ1tLA7cWNXru2YOcG80AQZpKEzoYOfDnsbnGudDCz?=
 =?us-ascii?Q?nP/ZbiYmlQrMHpCPcDsp61yZP5jv+aQhyeCuA2WJD5Z3wrEfNzqqtKXxwhbM?=
 =?us-ascii?Q?32hffcLIwEmaHymzFCe8zumfN1cQGRLknXsyLl8Albw9vs5i7k5jTI9FLV3i?=
 =?us-ascii?Q?0EafPypORgOq/TO+6+xFv0/LtW6J/zGgDbYqEcjb8YhwwKZKd6duOWpYvnEQ?=
 =?us-ascii?Q?rXZ6+zwuMSyv8sMs1K99E5mxiXXhg/FUJPW9whBzTGuzEjQgP48WEBEEeh8O?=
 =?us-ascii?Q?v0JG4OprJw4FtA2nLRWSPyTRZ82Cn5imoHOWXR0vYjaOJ+IrGH2zjR/4yJ9x?=
 =?us-ascii?Q?Kk7ecrUVyjXAifDkyrsv6RI6yZEH23RMpFVHHFlkYfozPRNbcl0p0iVlMujd?=
 =?us-ascii?Q?O87JEMIVxepYx+GdyYrh/L0CofmWQmB+dXMDRvsOK0Ju1OeAEmHxLX1zFqKQ?=
 =?us-ascii?Q?LfjNdQSyxgOwR3ZyljJgspzJkQxmsQWIGhPNG+x/Ofmv1u2F6VGfcJSI7+gc?=
 =?us-ascii?Q?lxqXdIbVP7JlSElEAz7TW7bmMeZgVzhKCcym+qzN/i7JSlY4sENLa4pqRFdx?=
 =?us-ascii?Q?7hbluCWiT3x/LME/yookBnUJN5bUpHAk+Nj0+hEpkX8yceZ1YVcXWMH+3HbQ?=
 =?us-ascii?Q?X9CnwPGXs8dvXGHGgssaaMxcY/1WNrUWImz6C7dRr8FvPur6+v82cJpseM0A?=
 =?us-ascii?Q?7O0mH7K7XMkDUGlw3zhq/IN4rw6P8a0LvFNSpscLwPAOJlJuKBq23t55LU/l?=
 =?us-ascii?Q?8d1t0wWf4fSlXnNqnest80fHSWPvB5hgsNWbeON+WwqQtx4eKD/wfnqRMsy/?=
 =?us-ascii?Q?Iz1H4oaGUJvtJz3L4+SjYi1zTlL7uk5gGCMI7kRngkg1UfBr7aj/bopn98Y7?=
 =?us-ascii?Q?GyefGsqqh7hlmQf9giQGp6bKoMTNpxIZtI4isPfhNKw3lKG2oqjf5kjoITvT?=
 =?us-ascii?Q?TjDlEg6EwfDTuYj2P7Wj5Z/ZF0xBswtkVC5y?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 11:46:48.5970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7c10f2-ab72-4398-44c5-08dde4963da0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6855
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

From: Dariusz Sosnowski <dsosnowski@nvidia.com>

This patch adds:

- rte_pmd_mlx5_driver_disable_steering()
- rte_pmd_mlx5_driver_enable_steering()

private mlx5 PMD APIs, which allow applications to enable/disable
flow rule handling in mlx5 PMD (both internally and externally managed).
It allows applications (along with driver event callback API)
to use external libraries to configure flow rules which would forward
traffic to Rx and Tx queues managed by DPDK.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow.c    | 187 +++++++++++++++++++++++++++++++-
 drivers/net/mlx5/mlx5_flow.h    |   3 +
 drivers/net/mlx5/mlx5_trigger.c |  30 +++++
 drivers/net/mlx5/rte_pmd_mlx5.h |  56 ++++++++++
 4 files changed, 272 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index e6a057160cb..1de398982a9 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -8165,9 +8165,12 @@ mlx5_flow_list_flush(struct rte_eth_dev *dev, enum mlx5_flow_type type,
 void
 mlx5_flow_stop_default(struct rte_eth_dev *dev)
 {
-#ifdef HAVE_MLX5_HWS_SUPPORT
 	struct mlx5_priv *priv = dev->data->dev_private;
 
+	if (mlx5_flow_is_steering_disabled())
+		return;
+
+#ifdef HAVE_MLX5_HWS_SUPPORT
 	if (priv->sh->config.dv_flow_en == 2) {
 		mlx5_flow_nta_del_default_copy_action(dev);
 		if (!rte_atomic_load_explicit(&priv->hws_mark_refcnt,
@@ -8175,6 +8178,8 @@ mlx5_flow_stop_default(struct rte_eth_dev *dev)
 			flow_hw_rxq_flag_set(dev, false);
 		return;
 	}
+#else
+	RTE_SET_USED(priv);
 #endif
 	flow_mreg_del_default_copy_action(dev);
 	mlx5_flow_rxq_flags_clear(dev);
@@ -8220,10 +8225,12 @@ int
 mlx5_flow_start_default(struct rte_eth_dev *dev)
 {
 	struct rte_flow_error error;
-#ifdef HAVE_MLX5_HWS_SUPPORT
-	struct mlx5_priv *priv = dev->data->dev_private;
 
-	if (priv->sh->config.dv_flow_en == 2) {
+	if (mlx5_flow_is_steering_disabled())
+		return 0;
+
+#ifdef HAVE_MLX5_HWS_SUPPORT
+	if (MLX5_SH(dev)->config.dv_flow_en == 2) {
 		/*
 		 * Ignore this failure, if the proxy port is not started, other
 		 * default jump actions are not created and this rule will not
@@ -8879,6 +8886,13 @@ int
 mlx5_flow_ops_get(struct rte_eth_dev *dev __rte_unused,
 		  const struct rte_flow_ops **ops)
 {
+	if (mlx5_flow_is_steering_disabled()) {
+		DRV_LOG(WARNING, "port %u flow API is not supported since steering was disabled",
+			dev->data->port_id);
+		*ops = NULL;
+		return 0;
+	}
+
 	*ops = &mlx5_flow_ops;
 	return 0;
 }
@@ -12347,3 +12361,168 @@ mlx5_ctrl_flow_uc_dmac_vlan_exists(struct rte_eth_dev *dev,
 	}
 	return exists;
 }
+
+static bool mlx5_steering_disabled;
+
+bool
+mlx5_flow_is_steering_disabled(void)
+{
+	return mlx5_steering_disabled;
+}
+
+static void
+flow_disable_steering_flush(struct rte_eth_dev *dev)
+{
+	/*
+	 * This repeats the steps done in mlx5_dev_stop(), with a small difference:
+	 * - mlx5_flow_hw_cleanup_ctrl_rx_templates() and mlx5_action_handle_detach()
+	 * They are rearranged to make it work with different dev->data->dev_started.
+	 * Please see a TODO note in mlx5_dev_stop().
+	 */
+
+	mlx5_flow_stop_default(dev);
+	mlx5_traffic_disable(dev);
+	mlx5_flow_list_flush(dev, MLX5_FLOW_TYPE_GEN, true);
+	mlx5_flow_meter_rxq_flush(dev);
+#ifdef HAVE_MLX5_HWS_SUPPORT
+	mlx5_flow_hw_cleanup_ctrl_rx_templates(dev);
+#endif
+	mlx5_action_handle_detach(dev);
+}
+
+static void
+flow_disable_steering_cleanup(struct rte_eth_dev *dev)
+{
+	/*
+	 * See mlx5_dev_close(). Only steps not done on mlx5_dev_stop() are executed here.
+	 * Necessary steps are copied as is because steering resource cleanup in mlx5_dev_close()
+	 * is interleaved with other steps.
+	 * TODO: Rework steering resource cleanup in mlx5_dev_close() to allow code reuse.
+	 */
+
+	struct mlx5_priv *priv = dev->data->dev_private;
+
+	mlx5_action_handle_flush(dev);
+	mlx5_flow_meter_flush(dev, NULL);
+	mlx5_flex_parser_ecpri_release(dev);
+	mlx5_flex_item_port_cleanup(dev);
+	mlx5_indirect_list_handles_release(dev);
+#ifdef HAVE_MLX5_HWS_SUPPORT
+	flow_hw_destroy_vport_action(dev);
+	flow_hw_resource_release(dev);
+	flow_hw_clear_port_info(dev);
+	if (priv->tlv_options != NULL) {
+		/* Free the GENEVE TLV parser resource. */
+		claim_zero(mlx5_geneve_tlv_options_destroy(priv->tlv_options, priv->sh->phdev));
+		priv->tlv_options = NULL;
+	}
+	if (priv->ptype_rss_groups) {
+		mlx5_ipool_destroy(priv->ptype_rss_groups);
+		priv->ptype_rss_groups = NULL;
+	}
+	if (priv->dr_ctx) {
+		claim_zero(mlx5dr_context_close(priv->dr_ctx));
+		priv->dr_ctx = NULL;
+	}
+#else
+	RTE_SET_USED(priv);
+#endif
+}
+
+typedef void (*run_on_related_cb_t)(struct rte_eth_dev *dev);
+
+static void
+flow_disable_steering_run_on_related(struct rte_eth_dev *dev,
+				     run_on_related_cb_t cb)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+	uint16_t other_port_id;
+	uint16_t proxy_port_id;
+	uint16_t port_id;
+	int ret __rte_unused;
+
+	if (priv->sh->config.dv_esw_en) {
+		ret = mlx5_flow_pick_transfer_proxy(dev, &proxy_port_id, NULL);
+		if (ret != 0) {
+			/*
+			 * This case should not happen because E-Switch is enabled.
+			 * However, in any case, release resources on the given port
+			 * and log the misconfigured port.
+			 */
+			DRV_LOG(ERR, "port %u unable to find transfer proxy port ret=%d",
+				priv->dev_data->port_id, ret);
+			cb(dev);
+			return;
+		}
+
+		/* Run callback on representors. */
+		MLX5_ETH_FOREACH_DEV(other_port_id, dev->device) {
+			struct rte_eth_dev *other_dev = &rte_eth_devices[other_port_id];
+
+			if (other_port_id != proxy_port_id)
+				cb(other_dev);
+		}
+
+		/* Run callback on proxy port. */
+		cb(&rte_eth_devices[proxy_port_id]);
+	} else if (rte_atomic_load_explicit(&priv->shared_refcnt, rte_memory_order_relaxed) > 0) {
+		/* Run callback on guest ports. */
+		MLX5_ETH_FOREACH_DEV(port_id, NULL) {
+			struct rte_eth_dev *other_dev = &rte_eth_devices[port_id];
+			struct mlx5_priv *other_priv = other_dev->data->dev_private;
+
+			if (other_priv->shared_host == dev)
+				cb(other_dev);
+		}
+
+		/* Run callback on host port. */
+		cb(dev);
+	} else {
+		cb(dev);
+	}
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_disable_steering, 25.11)
+void
+rte_pmd_mlx5_disable_steering(void)
+{
+	uint16_t port_id;
+
+	if (mlx5_steering_disabled)
+		return;
+
+	MLX5_ETH_FOREACH_DEV(port_id, NULL) {
+		struct rte_eth_dev *dev = &rte_eth_devices[port_id];
+
+		if (mlx5_hws_active(dev)) {
+			flow_disable_steering_run_on_related(dev, flow_disable_steering_flush);
+			flow_disable_steering_run_on_related(dev, flow_disable_steering_cleanup);
+		} else {
+			flow_disable_steering_flush(dev);
+			flow_disable_steering_cleanup(dev);
+		}
+
+		mlx5_flow_rxq_mark_flag_set(dev);
+	}
+
+	mlx5_steering_disabled = true;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_enable_steering, 25.11)
+int
+rte_pmd_mlx5_enable_steering(void)
+{
+	uint16_t port_id;
+
+	if (!mlx5_steering_disabled)
+		return 0;
+
+	/* If any mlx5 port is probed, disallow enabling steering. */
+	port_id = mlx5_eth_find_next(0, NULL);
+	if (port_id != RTE_MAX_ETHPORTS)
+		return -EBUSY;
+
+	mlx5_steering_disabled = false;
+
+	return 0;
+}
diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index 36be7660012..8201b7aa4e3 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -3670,6 +3670,9 @@ flow_hw_get_ipv6_route_ext_mod_id_from_ctx(void *dr_ctx, uint8_t idx)
 }
 void
 mlx5_indirect_list_handles_release(struct rte_eth_dev *dev);
+
+bool mlx5_flow_is_steering_disabled(void);
+
 #ifdef HAVE_MLX5_HWS_SUPPORT
 
 #define MLX5_REPR_STC_MEMORY_LOG 11
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 6c6f228afd1..b104ca9f520 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1253,6 +1253,14 @@ mlx5_dev_start(struct rte_eth_dev *dev)
 	if (priv->sh->config.dv_flow_en == 2) {
 		struct rte_flow_error error = { 0, };
 
+		/*
+		 * If steering is disabled, then:
+		 * - There are no limitations regarding port start ordering,
+		 *   since no flow rules need to be created as part of port start.
+		 * - Non template API initialization will be skipped.
+		 */
+		if (mlx5_flow_is_steering_disabled())
+			goto continue_dev_start;
 		/*If previous configuration does not exist. */
 		if (!(priv->dr_ctx)) {
 			ret = flow_hw_init(dev, &error);
@@ -1420,6 +1428,8 @@ mlx5_dev_start(struct rte_eth_dev *dev)
 			dev->data->port_id, rte_strerror(rte_errno));
 		goto error;
 	}
+	if (mlx5_flow_is_steering_disabled())
+		mlx5_flow_rxq_mark_flag_set(dev);
 	rte_wmb();
 	dev->tx_pkt_burst = mlx5_select_tx_function(dev);
 	dev->rx_pkt_burst = mlx5_select_rx_function(dev);
@@ -1530,6 +1540,13 @@ mlx5_dev_stop(struct rte_eth_dev *dev)
 
 #ifdef HAVE_MLX5_HWS_SUPPORT
 	if (priv->sh->config.dv_flow_en == 2) {
+		/*
+		 * If steering is disabled,
+		 * then there are no limitations regarding port stop ordering,
+		 * since no flow rules need to be destroyed as part of port stop.
+		 */
+		if (mlx5_flow_is_steering_disabled())
+			goto continue_dev_stop;
 		/* If there is no E-Switch, then there are no start/stop order limitations. */
 		if (!priv->sh->config.dv_esw_en)
 			goto continue_dev_stop;
@@ -1552,6 +1569,8 @@ mlx5_dev_stop(struct rte_eth_dev *dev)
 	mlx5_mp_os_req_stop_rxtx(dev);
 	rte_delay_us_sleep(1000 * priv->rxqs_n);
 	DRV_LOG(DEBUG, "port %u stopping device", dev->data->port_id);
+	if (mlx5_flow_is_steering_disabled())
+		mlx5_flow_rxq_flags_clear(dev);
 	mlx5_flow_stop_default(dev);
 	/* Control flows for default traffic can be removed firstly. */
 	mlx5_traffic_disable(dev);
@@ -1692,6 +1711,9 @@ mlx5_traffic_enable(struct rte_eth_dev *dev)
 	unsigned int j;
 	int ret;
 
+	if (mlx5_flow_is_steering_disabled())
+		return 0;
+
 #ifdef HAVE_MLX5_HWS_SUPPORT
 	if (priv->sh->config.dv_flow_en == 2)
 		return mlx5_traffic_enable_hws(dev);
@@ -1878,6 +1900,9 @@ mlx5_traffic_disable_legacy(struct rte_eth_dev *dev)
 void
 mlx5_traffic_disable(struct rte_eth_dev *dev)
 {
+	if (mlx5_flow_is_steering_disabled())
+		return;
+
 #ifdef HAVE_MLX5_HWS_SUPPORT
 	struct mlx5_priv *priv = dev->data->dev_private;
 
@@ -1900,6 +1925,9 @@ mlx5_traffic_disable(struct rte_eth_dev *dev)
 int
 mlx5_traffic_restart(struct rte_eth_dev *dev)
 {
+	if (mlx5_flow_is_steering_disabled())
+		return 0;
+
 	if (dev->data->dev_started) {
 		mlx5_traffic_disable(dev);
 #ifdef HAVE_MLX5_HWS_SUPPORT
@@ -1915,6 +1943,8 @@ mac_flows_update_needed(struct rte_eth_dev *dev)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 
+	if (mlx5_flow_is_steering_disabled())
+		return false;
 	if (!dev->data->dev_started)
 		return false;
 	if (dev->data->promiscuous)
diff --git a/drivers/net/mlx5/rte_pmd_mlx5.h b/drivers/net/mlx5/rte_pmd_mlx5.h
index da8d4b1c83c..4e253a602ae 100644
--- a/drivers/net/mlx5/rte_pmd_mlx5.h
+++ b/drivers/net/mlx5/rte_pmd_mlx5.h
@@ -551,6 +551,62 @@ __rte_experimental
 int
 rte_pmd_mlx5_driver_event_cb_unregister(rte_pmd_mlx5_driver_event_callback_t cb);
 
+/**
+ * Disable flow steering for all mlx5 ports.
+ *
+ * In mlx5 PMD, HW flow rules are generally used in 2 ways:
+ *
+ * - "internal" - to connect HW objects created by mlx5 PMD (e.g. Rx queues)
+ *   to datapath, so traffic can be received in user space by DPDK application,
+ *   bypassing the kernel driver. Such rules are created implicitly by mlx5 PMD.
+ * - "external" - flow rules created by application explicitly through flow API.
+ *
+ * In mlx5 PMD language, configuring flow rules is known as configuring flow steering.
+ *
+ * If an application wants to use any other library compatible with NVIDIA hardware
+ * to configure flow steering or delegate flow steering to another process,
+ * the application can call this function to disable flow steering globally for all mlx5 ports.
+ *
+ * Information required to configure flow steering in such a way that externally created
+ * flow rules would forward/match traffic to DPDK-managed Rx/Tx queues can be extracted
+ * through #rte_pmd_mlx5_driver_event_cb_register API.
+ *
+ * This function can be called:
+ *
+ * - before or after #rte_eal_init.
+ * - before or after any mlx5 port is probed.
+ *
+ * If this function is called when mlx5 ports (at least one) exist,
+ * then steering will be disabled for all existing mlx5 port.
+ * This will invalidate *ALL* handles to objects return from flow API for these ports
+ * (for example handles to flow rules, indirect actions, template tables).
+ *
+ * This function is lock-free and it is assumed that it won't be called concurrently
+ * with other functions from ethdev API used to configure any of the mlx5 ports.
+ * It is the responsibility of the application to enforce this.
+ */
+__rte_experimental
+void
+rte_pmd_mlx5_disable_steering(void);
+
+/**
+ * Enable flow steering for mlx5 ports.
+ *
+ * This function reverses the effects of #rte_pmd_mlx5_driver_disable_steering.
+ *
+ * It can be called if and only if there are no mlx5 ports known by DPDK,
+ * so in case if #rte_pmd_mlx5_driver_disable_steering was previously called
+ * the application has to remove mlx5 devices, call this function and
+ * re-probe the mlx5 devices.
+ *
+ * @return
+ *   - 0 - Flow steering was successfully enabled or it flow steering was never disabled.
+ *   - (-EBUSY) - There are mlx5 ports probed and re-enabling steering cannot be done safely.
+ */
+__rte_experimental
+int
+rte_pmd_mlx5_enable_steering(void);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.21.0

