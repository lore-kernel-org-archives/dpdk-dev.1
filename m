Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73E6C87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu, 31 Jul 2025 06:09:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3B4E4026A;
	Thu, 31 Jul 2025 08:09:37 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by mails.dpdk.org (Postfix) with ESMTP id F13854025A
 for <dev@dpdk.org>; Thu, 31 Jul 2025 08:09:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKnbvtJkFTcVOpUzIXg+55pGveAqLTRYK/RWGNHFDJ/rUOe+ocCQmJugVVMWMtf3gwPfqksjvd7u94SJgOAOOr4jjtv7PgCyPzBn34EjNMJZJ2VCGcjcstgYf1GwIoSWAsLYj1f/LM6sRK8mSAvdQ7IOPC9Q6BgHUiRoGAGHh5iY2NpKe8EttvqqtyAloIMfmJJg6T8X0SJWlOpwzWB1ES/K5yBN5i097J7f62oqM0671hljO2rBA8hRD56og5fWrLnB3ZS9HNDfV+l37axaQbZz4/hfQJLtGJOMM500JcflvnKm+n8kj2+f3o/lJChShQerNBhePcLzlepNuFJyTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Msk65xcRo34+H2oPIkWQrgz0gYevRhre1IMK6Ipj1mI=;
 b=ZKa0Pq10PtI0HqsU3fYpCXUscQRhcDtKar+QlRLACt6TZ28kDRDew8sBJeHC5jJsbiYCsNcIQn+jq9mrTmy/Puq16uPwWVA/7YzRWQcSMXIvfVBCRZ3xWJ1O7oeHYZ2OOUAfie4EicPHyn4TG5ecVCfWTHUbpnC5h1IANjL3KB3dqFUJcT+N5BeKPt9PbyejGNSUEczf9eWr5/nPuMdMqHIR3LO7RoDoqBC85Nc1zjkdY7F00tbv5DlH03kPHicHZD725+0aolB0Bx16CdKEY8LA5/EnW2Y19Y757ClLuvro4xZn/23V34e7NODiejV6n5oRfvLDSL09ewBms2aLag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Msk65xcRo34+H2oPIkWQrgz0gYevRhre1IMK6Ipj1mI=;
 b=HzGus4uSy2iAoh/5j0Z/qkcXnsT6dS2r+eOp4AREA1cxg48+wtD2rmrtMg5owCKiXZJJ+HEHBsNjrWxNPx2EAci3M2dk3+1MyvuHYSmsh3Z4jp3QlH9B+87P11/jnIN6T+0jQvwTV4+vVwMgsYhd5SLzpYpNLuCfVMDdTRp1Bi1GaiBttHgHstk5DTY4/5Vil3i5fkZJqzO5l28nNiYnJQ/mctu3Tt8tMvBNr00mAGhJsjhAYx4hZbV2ckjAumL+XzyY5gzv+JguCuBWDGpQovy/LTi59cDFjBTA8Q7LSWiZbvE+Pd2Hft/SAnEPJb/qyIt8uVMHexxcBK83gOVaOw==
Received: from SJ0PR03CA0033.namprd03.prod.outlook.com (2603:10b6:a03:33e::8)
 by SA5PPFE3F7EF2AE.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Thu, 31 Jul
 2025 06:09:33 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::47) by SJ0PR03CA0033.outlook.office365.com
 (2603:10b6:a03:33e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Thu,
 31 Jul 2025 06:09:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.10 via Frontend Transport; Thu, 31 Jul 2025 06:09:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 30 Jul
 2025 23:09:11 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 30 Jul
 2025 23:09:04 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Michael Baum <michaelba@nvidia.com>
Subject: [PATCH] net/mlx5: fix external Rx and Tx queues access
Date: Thu, 31 Jul 2025 09:08:49 +0300
Message-ID: <20250731060849.18117-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|SA5PPFE3F7EF2AE:EE_
X-MS-Office365-Filtering-Correlation-Id: d26e9618-5a18-4db4-b331-08ddcff8d13a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R6xvhBBdz0WDIhvSpR/z2IkJUC5FX/xrU9IZc3qpp2GaFl7ZPSRjdt9AhrFV?=
 =?us-ascii?Q?/40ri7nszHn5ENxwvoj5diPbJX2FOGPK/ys2Xqqe9cchoa8ci1JSSFMrlVSL?=
 =?us-ascii?Q?DwJXWYXyyXRBwD77iKZ6c4E/y7ll5DSRuM5DfKHw770rLpFmJZKLS6a6PmcW?=
 =?us-ascii?Q?DMzgC6BvbzKVaDcPbYX/i++LK3nMIBgHUmee7ajh9iosQRL4sut2D9QWsM7H?=
 =?us-ascii?Q?Xw81ZLjH2dZMIH6UDqDR4gKupaJP8tFP4KUkjGtkwfJgArk53tevqSbsBTjl?=
 =?us-ascii?Q?BMOQbzqYVqDTJLmt44N5D1Nf0hhazs95qj/psXHO5M7+FFn2GRMjMC3mq3kf?=
 =?us-ascii?Q?N0au5Xa9MwwtM+89BoUdoXrQAK1KCGLwWTULEQ33b/jEkt3MI1LwQ8vGEimg?=
 =?us-ascii?Q?DdF9N+KpFwq/AwsxJkRSKKWwIAIhpEt/HbwEq5ilKNJXMZwNvo2ofobVWc2G?=
 =?us-ascii?Q?GanQ8XF52pybvEfGxalq7I0pEMq+iyibphbg5YeoUjW+UBytW2Gy/gVtVfF+?=
 =?us-ascii?Q?9jw9Y10N/eh1bisZNUvPsVh6CDeBq05dx9kH1gGOCQaxiuieaR+pLp2d4UF5?=
 =?us-ascii?Q?PPPhHAzDUpy1YUdofNnNueVaNYC+h5Q4dpyCu9wAR30uYSAjuFIdHZtRwIba?=
 =?us-ascii?Q?RcnmqkdVCi220ZBP0FrzXscNw2TPO5tbTO4xTxccPdUcxYj28NdqH8P3z838?=
 =?us-ascii?Q?j08h+1wyQ8drfDeoPmzHfi/XTRvEApL+n0yB2CcB1k/vL+dBn6b8a6nxWle3?=
 =?us-ascii?Q?Pl9BFsZsNCskfc1cZ297fXOZAH5OiCJWGZwlKNvYE9SUEiKlI93TAAtYkvED?=
 =?us-ascii?Q?XMbUxDbfvoaaHqptxfeNZh7AO4a1wo/QKdH/WoZCjhBj7cxVDQsGGT48cEyN?=
 =?us-ascii?Q?qhBU3zWwqPXvv8ZyFXXA2tWI7XvXZkYQYwYFe6x5/uIn3c92sxbTnEdzrtB9?=
 =?us-ascii?Q?aZQVRR51m5bcn5ibySoyUhFvY0xBBg7MsS4IWlcEi1dywsKjXZ7YX4GDf4oB?=
 =?us-ascii?Q?jD3MGx58p4nLS2dkg2/ApJ47jYZrPVrOlNhIqaPD31xOovopEX7i2nKFhKMf?=
 =?us-ascii?Q?d75MCYCaLp6nYcwUbeURkO//9SYfPkihCtwIZhUYEGsIJLFZiw4XrJNFLg+o?=
 =?us-ascii?Q?Hy5eoi+fkaL6ksD9K1HiWkM+tAd8Fbpw2kevomg+ZXAYax6gzpT2uHGRn6Gu?=
 =?us-ascii?Q?tveyRzowmpsp1lj6gE7LhbBIo/miLFx+NTDFOcSF46W6fz27jD87QQW45B1b?=
 =?us-ascii?Q?va7yOYH/LlsCnumPXr6JuhXZwwwEN50EUHpZ7QAwR+2vVXUieliNVLWpbXrL?=
 =?us-ascii?Q?0at2BYNVHuAcPzT43VhtQgMdmoeW0Ij/dSSiBCsO7HmVngurjodi/eCkX+ud?=
 =?us-ascii?Q?1kut76QlHqG2Bguieg0gQfazN5ttOz1Wm3OxN0cFy/u/lovLMKWtkwuh6GeX?=
 =?us-ascii?Q?s//mGnpjKunLB++zwg3WgpKHsMwQWKI9D/tUTdyVlUNv8bKVB9H0SEaKRa+w?=
 =?us-ascii?Q?tMNjlgwo34xocGdrkwxHzzah1ZCg18h94AiO?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 06:09:32.4232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d26e9618-5a18-4db4-b331-08ddcff8d13a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE3F7EF2AE
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

mlx5_ext_rxq_get() and mlx5_ext_txq_get() functions did not return
NULL value if query index was not referencing external queue.

As a result, calling functions did not expect the NULL on return.

External Rx queue:

- In mlx5_ext_rxq_get() remove assert and return NULL if a queue index
  does not point to a valid external queue.

- In mlx5_ext_rxq_verify() validate that probed queue index references
  a valid extern queue.

External Tx queue:

-  In mlx5_ext_txq_get() remove assert and return NULL if a queue index
   does not point to a valid external queue.

- In mlx5_ext_txq_verify() validate that probed queue index references
  a valid extern queue.

Fixes: 311b17e669ab ("net/mlx5: support queue/RSS actions for external Rx queue")

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_rxq.c | 10 +++++-----
 drivers/net/mlx5/mlx5_txq.c | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_rxq.c b/drivers/net/mlx5/mlx5_rxq.c
index 77c5848c37..c615a5c64b 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -2250,8 +2250,8 @@ mlx5_ext_rxq_get(struct rte_eth_dev *dev, uint16_t idx)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 
-	MLX5_ASSERT(mlx5_is_external_rxq(dev, idx));
-	return &priv->ext_rxqs[idx - RTE_PMD_MLX5_EXTERNAL_RX_QUEUE_ID_MIN];
+	return mlx5_is_external_rxq(dev, idx) ?
+		&priv->ext_rxqs[idx -  RTE_PMD_MLX5_EXTERNAL_RX_QUEUE_ID_MIN] : NULL;
 }
 
 /**
@@ -2413,7 +2413,6 @@ int
 mlx5_ext_rxq_verify(struct rte_eth_dev *dev)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
-	struct mlx5_external_q *rxq;
 	uint32_t i;
 	int ret = 0;
 
@@ -2421,8 +2420,9 @@ mlx5_ext_rxq_verify(struct rte_eth_dev *dev)
 		return 0;
 
 	for (i = RTE_PMD_MLX5_EXTERNAL_RX_QUEUE_ID_MIN; i <= UINT16_MAX ; ++i) {
-		rxq = mlx5_ext_rxq_get(dev, i);
-		if (rxq->refcnt < 2)
+		struct mlx5_external_q *rxq = mlx5_ext_rxq_get(dev, i);
+
+		if (rxq == NULL || rxq->refcnt < 2)
 			continue;
 		DRV_LOG(DEBUG, "Port %u external RxQ %u still referenced.",
 			dev->data->port_id, i);
diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index b090d8274d..2aa2475a8a 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -1281,8 +1281,8 @@ mlx5_ext_txq_get(struct rte_eth_dev *dev, uint16_t idx)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 
-	MLX5_ASSERT(mlx5_is_external_txq(dev, idx));
-	return &priv->ext_txqs[idx - MLX5_EXTERNAL_TX_QUEUE_ID_MIN];
+	return mlx5_is_external_txq(dev, idx) ?
+		&priv->ext_txqs[idx - MLX5_EXTERNAL_TX_QUEUE_ID_MIN] : NULL;
 }
 
 /**
@@ -1298,7 +1298,6 @@ int
 mlx5_ext_txq_verify(struct rte_eth_dev *dev)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
-	struct mlx5_external_q *txq;
 	uint32_t i;
 	int ret = 0;
 
@@ -1306,8 +1305,9 @@ mlx5_ext_txq_verify(struct rte_eth_dev *dev)
 		return 0;
 
 	for (i = MLX5_EXTERNAL_TX_QUEUE_ID_MIN; i <= UINT16_MAX ; ++i) {
-		txq = mlx5_ext_txq_get(dev, i);
-		if (txq->refcnt < 2)
+		struct mlx5_external_q *txq = mlx5_ext_txq_get(dev, i);
+
+		if (txq == NULL || txq->refcnt < 2)
 			continue;
 		DRV_LOG(DEBUG, "Port %u external TxQ %u still referenced.",
 			dev->data->port_id, i);
-- 
2.48.1

