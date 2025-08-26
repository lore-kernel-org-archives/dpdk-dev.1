Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D82CA0FE9
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 11:47:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5402840648;
	Tue, 26 Aug 2025 13:46:48 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by mails.dpdk.org (Postfix) with ESMTP id ECA9A402EF
 for <dev@dpdk.org>; Tue, 26 Aug 2025 13:46:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEVzT8og1cwdMtW6kzpx9iozVhjtJq6WEa63xHgfWKHcCEmGc1T0/6vDOKeYuFVka6GV6moj0GBcgVRur5PcXae5MTphFDMCYYg4On0jQ0QE0A8ry0zsQxuU0yi3CwPTHQXfH4iQ6A1TI8JHCK1yw0H+R4oPSXHIBldC+3RAuwx9p/Hg+h5cRFpcDH18K3oSQT1i5Zu2kqimdBl8HpkSsG3aE5KtYX2AHQEi/NalVX7yFI2sIzmJYS9+x1MYZ3JG3GJl8nm7jW3wTc4GTeBXrjOra2aziKEGwVMDvbCHsFXgjEdHW2unds7eES7xw/Y3zNgAhsSLoH5PY5BuW8giLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gE9WKqZigUGvSPmmQkno+8OOUwt4qCfc1qJhWwPS6HA=;
 b=MJwWB/PzM0Cr07j057xJbO/xF5nVr6QZTWPw4D4x7VNWxGfJXxf5FwLtnUgcH2LobYBjQVX7q2aQhFsm37veD5b6mpXQKOtJfg8HLnhK83SA+Gaubt6AhYSTWzPSlnT6FITZQRRDyP6JmEdioapIPy5gL1auffTh2XwL3ZYbOMwelCNLC31WVDYxh1N4XGJpJxfo7knoNZmogWNOFU3aAfw6j34KO2jGe9JBWmM4juoW7Te4HTesN1iYe24oo+OjdgEL16Ed1i1CFcMnbsl1hF5JJQUZ/TxJC1fBvt7OvZ1JBUEvl0fU0wxn5t34FTmUZMNZIlpaF4rgKhXlIiSNNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gE9WKqZigUGvSPmmQkno+8OOUwt4qCfc1qJhWwPS6HA=;
 b=Ga2LkkR4lfX+c7RZori176H/2Qjm78ttqskDNrOuMYzVjBvCeCQRfkxzhSTNf3ih5AMHYljq6HWU9TiNLch0KnRQIUCinr59Xor4FMQ56obaH56qobENQ9HbF4vZSxzC0VfOVNytczy7zlOkSJRFXoMlsejJVdrJQtSz4IsTKIoycIKKZRlxJl8q+nQqMcQ6/jCxGqcsUvafMzvCnKS6wriKwp1t7BxE8jIkJY5mgfNBhKEz086x+UOLC8aBdvn7R5pdNPvbwL5SSOZzKuXAEm5/KcZLujG4K6rTPcV9POyVkozub71285gqimtCaZCCK7+knafuqlGPWLsUDAbY4A==
Received: from BY5PR20CA0015.namprd20.prod.outlook.com (2603:10b6:a03:1f4::28)
 by LV2PR12MB5965.namprd12.prod.outlook.com (2603:10b6:408:172::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Tue, 26 Aug
 2025 11:46:43 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::d3) by BY5PR20CA0015.outlook.office365.com
 (2603:10b6:a03:1f4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 11:46:42 +0000
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
 15.20.9094.0 via Frontend Transport; Tue, 26 Aug 2025 11:46:42 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 26 Aug
 2025 04:46:34 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 26 Aug 2025 04:46:33 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 26 Aug 2025 04:46:31 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH 3/4] net/mlx5: rework Rx queue mark flag functions
Date: Tue, 26 Aug 2025 14:45:54 +0300
Message-ID: <20250826114556.10068-4-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20250826114556.10068-1-mkashani@nvidia.com>
References: <20250826114556.10068-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|LV2PR12MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c84972a-8e3e-45f7-62e8-08dde4963a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/rzKY9fgkVbRY1+RFB36E9l4Dsykt/ee2cGZCJMzd4TseUzIsN9dsxw1kf4F?=
 =?us-ascii?Q?k33bHUTBbBvWKwp71Vc+R+8lYWkH1x6CkLtclMgN5o5AHwgoDqkqQEO5SyIb?=
 =?us-ascii?Q?URhDEjYu3zIL/PHqxGd2Sc9bT/1DH5JEGdiSEgauR6IxBrdDrfsEBGRZpa3o?=
 =?us-ascii?Q?VxCsBnCoT1N7rEj+bQ/2LTk0+IjjOsuFK4pTKHxvfLucGa2tcfd0KcT+T5De?=
 =?us-ascii?Q?LMfH7q1OWGbI4H6b4c2wsBSsC6IcpkLdJZTLWaRTry2oyoXXJcmvwrWHt0qb?=
 =?us-ascii?Q?CGD03cNobIHWnCnNdL0yHlkntDtBIWCjISlYxsqdFQpueK8DivwFR1wAxkKy?=
 =?us-ascii?Q?Pngh7c/XxOLdWLB1ut41yWjE7/CAfSL2VQdQoSdvt8blKFXrpKpSTte0+5cg?=
 =?us-ascii?Q?ZS9fgxBB5HByqi5JmB/Iet7FZ2ma6AGnJTYs99Q59TO9e6B7cruqAAYHMwJA?=
 =?us-ascii?Q?JyT2oD7tCigqY4pISQcJSuQqlb2KyedbwNY3THKedZljfTnZHnW0WLNbfRX7?=
 =?us-ascii?Q?TWISAILrJmEmKbzgjgLFP94oWiVE/o+A/DEtd2zgau3U1ComFmAz1VI3Tw0a?=
 =?us-ascii?Q?NBwY0MLoO3bCCd0juKSnKQyO54oTUtZeLStvcN4M+OGFH+JW0OvBXNO+R671?=
 =?us-ascii?Q?RYq0N/EJJHSjwOvy26+utaftd7/KaO4mr2fUFfw4TMh5UVoBh76ucLP/fS0S?=
 =?us-ascii?Q?FNxy/gMsiRwATAliyVaSMmrZb2ObjDeZwGzrWpTxFTTPd1YCognenYD2tVEK?=
 =?us-ascii?Q?P9hhmlbTunvD7jKh9rxj9dsfSSy6qy+O+1q3uFAoFXTrlfI9dUGhHMvujiPl?=
 =?us-ascii?Q?YxeP8JAWE5cyCsRBg4iO3NP/kydzut/ltgXV5XyLvEIG2BWWU/nhzx2BOW+z?=
 =?us-ascii?Q?++gng0N3IqmE9m1GkL/LcCP2bIDI494hXxlsXyukwfbMbxsvV3A88XLt0cWZ?=
 =?us-ascii?Q?hcHGpYAMPHFSjrnMQ0un0Df1NL6t6CCXN46iQC6NPpRPWG0OUYhCaP8emz0d?=
 =?us-ascii?Q?ft8fws+nTAQ7GCFv+2fpgzzRNG0Ds6wE+rb7iTZfF+p1N+0gfHiVnQttXd/Z?=
 =?us-ascii?Q?D3QfD3GWDFUov2R1u/zDNsPnq6fVyxt+2iyjm/aoTjonRpUrQbxLf0Q4aZuj?=
 =?us-ascii?Q?RngxeVCuCkRBt0Ozc7WUAcwhlZonKIMC4MgWDhefbveZNSnq3T3Tv52vkXED?=
 =?us-ascii?Q?nXUTYqE5IFadjpeXTKWBMaGeTjVwBuevvAcY/IFgE9N06zKd60OV7M0Tdopt?=
 =?us-ascii?Q?KcqhSq6CFFeP4RoPjKV84TngZlr4EnSwa3/pzRLhk3AEk98ohHlUp5fRmB0K?=
 =?us-ascii?Q?FZEq2N7OskYJ6gcG1PXgFGmeCaQww/6/odV20AmdtRGeuTXTCkyKBFrrin94?=
 =?us-ascii?Q?Fmc3+AXQl7MzDbcCg3GfJie8EEDrwHylkUOazIwfsMvW0eaGPvbDmb0jmqmQ?=
 =?us-ascii?Q?XRvNMvOkdsZDT6ahUEOoOgYeKeaenK9giMHNXqfbUJ5ARZG3IWevRKR5umi1?=
 =?us-ascii?Q?SQFJ8p/K7YNy8WgeGC7bYV9/tUTDP3idrzG6?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 11:46:42.5901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c84972a-8e3e-45f7-62e8-08dde4963a0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5965
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

This patch:

- Renames flow_rxq_mark_flag_set() to mlx5_flow_rxq_mark_flag_set()
  so that it has a proper prefix and makes it non-static.
- Renames flow_rxq_flags_clear() to mlx5_flow_rxq_flags_clear()
  so that is has a proper prefix and makes it non-static.

Both of these functions will be used in a follow up patch
to implement flow steering clean up when disabling steering.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow.c | 12 ++++++------
 drivers/net/mlx5/mlx5_flow.h |  4 +++-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index cc9ec73dfee..e6a057160cb 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -1630,8 +1630,8 @@ flow_drv_rxq_flags_set(struct rte_eth_dev *dev,
 	}
 }
 
-static void
-flow_rxq_mark_flag_set(struct rte_eth_dev *dev)
+void
+mlx5_flow_rxq_mark_flag_set(struct rte_eth_dev *dev)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_rxq_ctrl *rxq_ctrl;
@@ -1687,7 +1687,7 @@ flow_rxq_flags_set(struct rte_eth_dev *dev, struct rte_flow *flow)
 
 	MLX5_ASSERT(wks);
 	if (wks->mark)
-		flow_rxq_mark_flag_set(dev);
+		mlx5_flow_rxq_mark_flag_set(dev);
 	SILIST_FOREACH(priv->sh->ipool[MLX5_IPOOL_MLX5_FLOW], flow->dev_handles,
 		       handle_idx, dev_handle, next)
 		flow_drv_rxq_flags_set(dev, dev_handle);
@@ -1784,8 +1784,8 @@ flow_rxq_flags_trim(struct rte_eth_dev *dev, struct rte_flow *flow)
  * @param dev
  *   Pointer to Ethernet device.
  */
-static void
-flow_rxq_flags_clear(struct rte_eth_dev *dev)
+void
+mlx5_flow_rxq_flags_clear(struct rte_eth_dev *dev)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	unsigned int i;
@@ -8177,7 +8177,7 @@ mlx5_flow_stop_default(struct rte_eth_dev *dev)
 	}
 #endif
 	flow_mreg_del_default_copy_action(dev);
-	flow_rxq_flags_clear(dev);
+	mlx5_flow_rxq_flags_clear(dev);
 }
 
 /**
diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index e890e732c34..36be7660012 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -3592,6 +3592,8 @@ int mlx5_flow_item_field_width(struct rte_eth_dev *dev,
 			   enum rte_flow_field_id field, int inherit,
 			   const struct rte_flow_attr *attr,
 			   struct rte_flow_error *error);
+void mlx5_flow_rxq_mark_flag_set(struct rte_eth_dev *dev);
+void mlx5_flow_rxq_flags_clear(struct rte_eth_dev *dev);
 uintptr_t flow_legacy_list_create(struct rte_eth_dev *dev, enum mlx5_flow_type type,
 				const struct rte_flow_attr *attr,
 				const struct rte_flow_item items[],
@@ -3768,5 +3770,5 @@ mlx5_flow_hw_action_flags_get(const struct rte_flow_action actions[],
 
 #include "mlx5_nta_sample.h"
 
-#endif
+#endif /* HAVE_MLX5_HWS_SUPPORT */
 #endif /* RTE_PMD_MLX5_FLOW_H_ */
-- 
2.21.0

