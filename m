Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FCCCA0EFF
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 06:29:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BA324065E;
	Wed, 27 Aug 2025 08:29:37 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by mails.dpdk.org (Postfix) with ESMTP id E0FCD40664
 for <dev@dpdk.org>; Wed, 27 Aug 2025 08:29:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xml58oELzNfFetFe7VFoJVve/4k/XnojKgde/tpHUUqxp4gdgFYgWTvGPGOl51d8d+h6OoHmiyeiXzXcx1F9lL1PSem+PWxfbbFdZCY2ljO8oJOXyo+mmnE43BcKyqm8pW7OwdB8qUQO9l4v5VXiafVZacDESM90yY9NoBfZWp0AdWMDcNvugu8XVKzd1f5On+M5S7LKWpDZnz1vLtIe0W8XxftSFEyXicR0JI49Tk7TVfFiEi2ZDyy5P3Iicxjy+/7Ql9UCEm6R/ReAbEc/Ys3Jge7fCXbq9D50MgvBszAuI9PfwlatjO0LVzs1qdSyJH5iuGDRqJ/WJiEE7XFVAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gE9WKqZigUGvSPmmQkno+8OOUwt4qCfc1qJhWwPS6HA=;
 b=JinJiKYUAPCNoDQUGzgbeKnO7cmg4COGXR89hoWJU42b/DV5E4pdniHU0pTWuWSXIiaz5n2GS6DMXMh/i60CQy7NRiAJHu6FzC83N1FsgyFrz/qSgONLSRF0i87lI6RUYLwFpCmE9b+nKiDV+2MMAX2Eq5O06dJEAkRz0K1yGj9Ghri7/sNp0RBKh3oAkIOU1peDLpVdQXYzmhU/pd5WnT2n1Fsqe++cPy27fMzp/vV5lZ0XN60onaev3d6DRc1cQG6kZrbxAE6yDuXhItcrtSl+ptzLVeZsn20Rogfq+5vj+zmQ3R2xfPr0S60ZNM1Eus1aJNGaVnqPC3bv60R+Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gE9WKqZigUGvSPmmQkno+8OOUwt4qCfc1qJhWwPS6HA=;
 b=AMXD2siUhH8AIIS8yY1ehM6o+OzgW69DOuWHKMoaR2cofF2insiduRwqFciqvHhBFYZqoTgC1WgaToFFyK7epEsau+Q0zsU4eAK0AgWi79Absw81Zj1rjlwVM4x8F7kWj/3CyOlzTURXrz0iKDD94pEpI8j6Ilp6qhPXUJXK736EYltbRFpZkf3WeymRSBn4ZGAd6647ff4K+u1KUPxhH/k8aJQhaYEvKqMcrgKO3C/LCPljeQYOlSatvb0qi7WcofIgdoLO2EerfjRJT5PVDK0c1RqyomwNOfxkvGHubqrrk0e/l9ziWRcAkAjHxTTZO0K9h0Ajlm6pOjhyhv9jbg==
Received: from DM6PR11CA0004.namprd11.prod.outlook.com (2603:10b6:5:190::17)
 by SA5PPF5D41D38AD.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8cb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Wed, 27 Aug
 2025 06:29:31 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:5:190:cafe::f1) by DM6PR11CA0004.outlook.office365.com
 (2603:10b6:5:190::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.13 via Frontend Transport; Wed,
 27 Aug 2025 06:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 06:29:30 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 26 Aug
 2025 23:29:17 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 26 Aug 2025 23:29:17 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 26 Aug 2025 23:29:15 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH 3/4] net/mlx5: rework Rx queue mark flag functions
Date: Wed, 27 Aug 2025 09:28:55 +0300
Message-ID: <20250827062859.55086-4-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20250827062859.55086-1-mkashani@nvidia.com>
References: <20250827062859.55086-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|SA5PPF5D41D38AD:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b155505-7265-4ffc-47b8-08dde5331463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xLmANxsegOf2zSGng/Qu7GyVJhqdTvOLh8tRA9Gf8DJehoCIZ4F68/9I9/K1?=
 =?us-ascii?Q?XwnNbTBE1AwtyGAaKIJJFjvKLP6LBPTzzS6AMqw2UdgVVKZsfBJ4j2Lrm2ob?=
 =?us-ascii?Q?aAQ8YYl2C7v1ynaZg/kx8a31jVa/p9X13K8YZoVWo1nVp6zFLVS/FW0F7KxT?=
 =?us-ascii?Q?TzSDoMueCerZV1FB0cJNVJdqAEtTH6JVqlZnyepBqSsqHRp1qL3Zn1hpEtvW?=
 =?us-ascii?Q?qdxfLIQzAdFE/siJ59KBf0w10TyvJ4logll2kC2xPylnrM/ex2AJYrI4CRJa?=
 =?us-ascii?Q?bE0s0uOY+IqspH/+gSZMWTgdoXfkpG1h8jWVW5LGcO84WkxPM1dM3mHYOIcM?=
 =?us-ascii?Q?v5YycfrOM8RZ+SYolMTWD2yjcfu6vaXBxSgPkLXJB1AGnUMh9fivKnpFYTKD?=
 =?us-ascii?Q?zLoCzgR8xUqDWATM/Hvg6pDS9HgutZCPDexaCGLJBbHyFIK1R2D6Qp1SW27N?=
 =?us-ascii?Q?EibxWBgibo9mzD2i3wP5XtSghL8vI0wOdBG2S9gdFvBaWmGxW/pgxSL3HXry?=
 =?us-ascii?Q?0G2TE1hwQPzPd8L1U75XLHxhK6vl1C+7RnKcIJHDyvuzwaDWZf1p5iKvsg3U?=
 =?us-ascii?Q?p8u7ZpEnRPYmcctaKNQSClWxnQSrUAgSlgLS1Rdb7U0lXOanGQapi4Vlvpcb?=
 =?us-ascii?Q?j/RQRxeGzL9aL6baXeChXF0mV+ed0+x/Qwg/IkU933V2+TYhXc399EQz5qT2?=
 =?us-ascii?Q?+os5q2s8pidtwsFqDTBHBMzjbsfEh+aohlRx9rHuNqnD/2GUK93IVbwvLMSK?=
 =?us-ascii?Q?AV9u3i4rq61VUvWrLvz0ceZSUT13rk75c3tbX9anTD31uxKfvWrFNe3GDZaO?=
 =?us-ascii?Q?hQ0orCFtTqt6jZkhHvUPOCda9mXXIxxW1ZMmZnq5/XALyi6MKepcWSEqS2GM?=
 =?us-ascii?Q?yoKqWkGXtZVLTy6SAPUgB92d9QKXtI1zDRdPFbh+ue7Cegit63NLXUh6A/mM?=
 =?us-ascii?Q?mJQaEG2Dd83hrH83j46sDux483h3cewXRvTPuX5zX5ZH7RPzPOLf9sMZu7eT?=
 =?us-ascii?Q?b5ZmlNYSNnXUvIe41xTscwG7G9+WPWY9eeTDE+uDD0EhuvekPuOX9vsNsRO1?=
 =?us-ascii?Q?CkFVQa3ddY77PDcXg+9yUQGTmHHT5j2Z3+AY3Z/P8DxNsA49Y/O1/zQ6cOU0?=
 =?us-ascii?Q?/E54D2FSq2I+wBMXwkJooS2yI4qYIZz8m8BTRp2TPRIGVCxfRIqqTmWhnWAR?=
 =?us-ascii?Q?AYje3KqZ/qhL7hFJgkbBJ5wm1lmf3hoi5ysiI8M2UCMFJGYR5ALKBid2xPST?=
 =?us-ascii?Q?u2AvGhj+6Gq51fUf6AfAeLLAIv7BKYFYfE1JgurbeSEXzSn/RwsiH6m/0cem?=
 =?us-ascii?Q?7+4UGtGCw9mTso1u5dML5ksxrke2Az55JNwmuR3ouREFp9vKUiTRwFqQrsCY?=
 =?us-ascii?Q?u0PL5iCLMcX2A7u9w5tvI9Yrt+pMIIpj+EK/+w2nu0qduAEgAmC9ChzLb63i?=
 =?us-ascii?Q?ewu0Yw+rnO/aWnglo8ZRgRnCrVDD2wsoNH7ZguF/190VyFg4rPEmRdPF7LqQ?=
 =?us-ascii?Q?JmQ+KYQSQmfIKT1kMn2CK5wNL/0ssShX2G1d?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 06:29:30.3646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b155505-7265-4ffc-47b8-08dde5331463
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF5D41D38AD
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

