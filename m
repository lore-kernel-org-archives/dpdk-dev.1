Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8762CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 07:42:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D172402AE;
	Thu, 30 Oct 2025 08:42:09 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013038.outbound.protection.outlook.com
 [40.93.196.38]) by mails.dpdk.org (Postfix) with ESMTP id C9A5C4027A
 for <dev@dpdk.org>; Thu, 30 Oct 2025 08:42:07 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVohBwme9TX4akIrQXajMn0CkksTzbT9zDhiuYCWnI8QZ3AzSaf/lDgsnNe9Y5Qku68jUjKmWsLe7Noe8blmqdUmOFJq8sw+Dgdy40c6/wDnnU7XoKo1VUqOWv3IkkDMYSaxyrtwAyQe4W6sXx6tw6YZmTjCQ+vFKBTg8Pkofp5sXmv5Fhi9jtKkAsB3wfyMoHnbKw4IaBPoqvbN8lCz4u2QSvgiEfkjgXHd4vupo0+svi7VPdY7CdAKAK+DEDGmfL0bTGGvzTT67gxg0uUcdgTP355+VbHtCS08UFjb0ee/fZLlDz7YFPR5eL7x+9XMJzNn7dU4kznGDtmtbXkHag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnFpI1SgntzOHPZKxii9Y2LAYyQBLeA/wO0PdNENKqE=;
 b=bRoEjfFhiQgTXjdbvyf1ucV7wRx5vkmiXidXfdSJr7INErfvYwXNygROZMFGxos2txVA2433v+uYA1BhuiVhnKXGUY6FD5uu57hqLnJpTvl7KcOtz+UXKCyc0fy3UoS4D4/epAwuZpdx64nZBcALI3JujdEgzYG0nGLN3Ttc7FpNaM040L1diUNRTHI+6iqmlVX5xxc4vStJSSstsiEq2lJceBy8SgNR8WDD1JmLZXCIASs9SjcdyjUT7XZOARG9fOi2fshaSzPGHBIRFk+Gywm97xgUxpH4HRl58vR+oFbU6HtO1QIywaTlMfBzO8yev3SSDinaA49i2+Ew951zOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnFpI1SgntzOHPZKxii9Y2LAYyQBLeA/wO0PdNENKqE=;
 b=YJKMX3N2w+5dLsnL5ykUWgjIzbYMLPH5XQ9UeX4IqqXqAl7WRegNvDg7y5OKraYLJHpSirq2toimgN96zsoO7GneG5WGJSsYeOehbvRpWUfGnBWBYDiE+o4kqa4Z4sd6t9D2L7GijO1cdnQgvOgnWsB55ACvMbfW1KSqRKXfGADB2Ewt5X9Epxt79dQ1yooeeKv8A83sui7l0KL/ezl5EXjEpZHXryxXnawfpMkzj+K6zWQjWdpstMA2pDyaL+vGzgO9ov7Ov06lqc69OY/UZbY/lWtjXZssR7NzYy2CcBgbxLwFyCkoxa1Sd72PtIlcC4+5F5xXF7yg/cNYs0PCFg==
Received: from SA9PR10CA0002.namprd10.prod.outlook.com (2603:10b6:806:a7::7)
 by IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 07:42:03 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:a7:cafe::79) by SA9PR10CA0002.outlook.office365.com
 (2603:10b6:806:a7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Thu,
 30 Oct 2025 07:42:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 07:42:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 00:41:47 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 00:41:43 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <thomas@monjalon.net>, <getelson@nvidia.com>, <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Michael Baum <michaelba@nvidia.com>
Subject: [PATCH v2] net/mlx5: fix external Rx and Tx queues access
Date: Thu, 30 Oct 2025 09:39:22 +0200
Message-ID: <20251030073922.205190-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250731060849.18117-1-getelson@nvidia.com>
References: <20250731060849.18117-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: e1597bde-0ccf-4e02-98c6-08de1787d114
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m9dLmk3VSmiLQh6dJ8G5UuioL8onEAR6Rd6DszHeqdVHvXZlonjAgt44nobh?=
 =?us-ascii?Q?Q5rRQUZF/7+NVucBgNQavqZLhiN+zSONQEgv2rJTizk44C1pokIzHwRTcCyq?=
 =?us-ascii?Q?JeWSYTAbtHAfZ9zekiZ1fu0OLU2K+RDF8ye7PUMWzZpH8edhymeXrHaQKTh2?=
 =?us-ascii?Q?6eVBpdxMbO+XL/C3qcxUf2dL5KFycmQa+0hl+Bfawo/iWk3rRg9fnHM8+Baa?=
 =?us-ascii?Q?m25u8nx6NDwL8L1z9Vu6y1ZJUsOU8xW5VX/Zm81ygWWRgSyQLElY3ibJrS/t?=
 =?us-ascii?Q?q9pFvoHwyF92nCCRlr7YruTbqmlQHlujM+wdFBUVi8BWkezgy1l+i1NZ7QIB?=
 =?us-ascii?Q?/6SDMJ//BvvgF3BGXGpiERS3mXC652XPMPrYHKgGCDvtyz5YUaBGeaO+EW87?=
 =?us-ascii?Q?RZotGpqVy60Emyc4OOjdeP4ABr1zDTeNGMengTR68HKliY+uBhvfodUW4dV1?=
 =?us-ascii?Q?Me/6YekTJeuCcWRLXAZNVxrVU5E2TzxYpK8HbNm35pizi6YW5LvitbDZj6D3?=
 =?us-ascii?Q?a5igT+40B8EixlW1ASQwCXFIfLOxPdVQ+23HemXNw0+YdtspO0aE3OxsK9z1?=
 =?us-ascii?Q?tzy+2NYIT6sf8jcbRNR0H+QbJqoTNuQ0oLtUOE3D5G2Ao9L5INom9unldb2M?=
 =?us-ascii?Q?3z7+XfPLC0hi43P+5d85hypZy0jEhsA3FqBiaarqH/zyhIl/m+/SZhzfcR82?=
 =?us-ascii?Q?h1n9LScEdrnj9qKWjH8EG2KwYxy90Z4jesqWktmsRrDo+kNqMQwGr+LK259G?=
 =?us-ascii?Q?h5vy/D3ujVeWG1WiV3g1i77ivtVc+a4s4Ab3VpZ5NYKEHyy9avYDPvYJmVo7?=
 =?us-ascii?Q?YvY06n/haRjRcC/jx8vcD7ZEeer/s9HmIxNkiVnP+Ur2qRbRq4eCdOHwSdRm?=
 =?us-ascii?Q?jA2khdzFBkJAT2IWDSdHVF9EDH73J1yKyPgIPthhIBbGykwHHip30ZwYMCFh?=
 =?us-ascii?Q?9ugbiesYcXEeJXxtWvfQiyUXUmuz3a2KZs1T4IUGjRuQReFIErZzg79KVbP4?=
 =?us-ascii?Q?4tuDyKd813nvlV7XBVIyUtVolAiJdjOu2kI4ufJwSPClTfx8n2+U7Yc2yy5v?=
 =?us-ascii?Q?l0J+URQtqsKvAwdgf3vCanpgzDlKdqJ3ZqwW9zGPqD3aGRDz3c2yW0NQoafX?=
 =?us-ascii?Q?/g63gPdbra5PWwDxG2lmc+7wVpyae+DUAT2+bEb/CQlr0CYdpR6cdExdOVRe?=
 =?us-ascii?Q?fe3HhN5rdmaMQY4T1wFfMxgXGzDHWkRMWSVLGce4B918BquA8A96zVb2inGd?=
 =?us-ascii?Q?o+W3oBoloxF2s+i9z7l4p62DFzmwRCNC+6Xvp8JHuYiC84CG6fTGTowNzN74?=
 =?us-ascii?Q?H54ZC6pyRqvhU7ogtn8wUtciklchWHuIpqIGTwllYS+Gpyv6ZdpGMk9GuY/y?=
 =?us-ascii?Q?1WQ054FwRrtkjR/jl6wTJIFt+DoSrywMJY221OR1VcCFxaLWn40n4I8hAnO0?=
 =?us-ascii?Q?HAldUeLDtY6E6J9Lo3UiUx7F9yYGSxCoTMhrc8Iui3B5YmL+gyNIGM7XegH/?=
 =?us-ascii?Q?kFHE3CFoLqqIuaAo9sCEyOVEWTxHQor86A/5pQuN2jC/V66aywUC1kPo4OIY?=
 =?us-ascii?Q?F1XjU9+qzEe+y3hMHeo=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 07:42:02.7573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1597bde-0ccf-4e02-98c6-08de1787d114
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750
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
v2: fixed MinGW compiler warnings
---
 drivers/net/mlx5/mlx5_devx.c |  5 +++++
 drivers/net/mlx5/mlx5_flow.h |  2 ++
 drivers/net/mlx5/mlx5_rxq.c  | 17 ++++++++++-------
 drivers/net/mlx5/mlx5_txq.c  | 10 +++++-----
 4 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_devx.c b/drivers/net/mlx5/mlx5_devx.c
index 673c9f3902..523b53d713 100644
--- a/drivers/net/mlx5/mlx5_devx.c
+++ b/drivers/net/mlx5/mlx5_devx.c
@@ -761,6 +761,11 @@ mlx5_devx_ind_table_create_rqt_attr(struct rte_eth_dev *dev,
 			struct mlx5_external_q *ext_rxq =
 					mlx5_ext_rxq_get(dev, queues[i]);
 
+			if (ext_rxq == NULL) {
+				rte_errno = EINVAL;
+				mlx5_free(rqt_attr);
+				return NULL;
+			}
 			rqt_attr->rq_list[i] = ext_rxq->hw_id;
 		} else {
 			struct mlx5_rxq_priv *rxq =
diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index ff61706054..6ced0fd741 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -2039,6 +2039,8 @@ flow_hw_get_sqn(struct rte_eth_dev *dev, uint16_t tx_queue, uint32_t *sqn)
 	}
 	if (mlx5_is_external_txq(dev, tx_queue)) {
 		ext_txq = mlx5_ext_txq_get(dev, tx_queue);
+		if (ext_txq == NULL)
+			return EINVAL;
 		*sqn = ext_txq->hw_id;
 		return 0;
 	}
diff --git a/drivers/net/mlx5/mlx5_rxq.c b/drivers/net/mlx5/mlx5_rxq.c
index 1425886a22..677e8491d3 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -2212,7 +2212,8 @@ mlx5_ext_rxq_ref(struct rte_eth_dev *dev, uint16_t idx)
 {
 	struct mlx5_external_q *rxq = mlx5_ext_rxq_get(dev, idx);
 
-	rte_atomic_fetch_add_explicit(&rxq->refcnt, 1, rte_memory_order_relaxed);
+	if (rxq != NULL)
+		rte_atomic_fetch_add_explicit(&rxq->refcnt, 1, rte_memory_order_relaxed);
 	return rxq;
 }
 
@@ -2232,7 +2233,9 @@ mlx5_ext_rxq_deref(struct rte_eth_dev *dev, uint16_t idx)
 {
 	struct mlx5_external_q *rxq = mlx5_ext_rxq_get(dev, idx);
 
-	return rte_atomic_fetch_sub_explicit(&rxq->refcnt, 1, rte_memory_order_relaxed) - 1;
+	return rxq != NULL ?
+		rte_atomic_fetch_sub_explicit(&rxq->refcnt, 1, rte_memory_order_relaxed) - 1 :
+		UINT32_MAX;
 }
 
 /**
@@ -2251,8 +2254,8 @@ mlx5_ext_rxq_get(struct rte_eth_dev *dev, uint16_t idx)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 
-	MLX5_ASSERT(mlx5_is_external_rxq(dev, idx));
-	return &priv->ext_rxqs[idx - RTE_PMD_MLX5_EXTERNAL_RX_QUEUE_ID_MIN];
+	return mlx5_is_external_rxq(dev, idx) ?
+		&priv->ext_rxqs[idx -  RTE_PMD_MLX5_EXTERNAL_RX_QUEUE_ID_MIN] : NULL;
 }
 
 /**
@@ -2415,7 +2418,6 @@ int
 mlx5_ext_rxq_verify(struct rte_eth_dev *dev)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
-	struct mlx5_external_q *rxq;
 	uint32_t i;
 	int ret = 0;
 
@@ -2423,8 +2425,9 @@ mlx5_ext_rxq_verify(struct rte_eth_dev *dev)
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
2.51.0

