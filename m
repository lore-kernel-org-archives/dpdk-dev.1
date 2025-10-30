Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636C4CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 09:13:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8200402F0;
	Thu, 30 Oct 2025 10:13:23 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
 by mails.dpdk.org (Postfix) with ESMTP id 8FA0B4027A
 for <dev@dpdk.org>; Thu, 30 Oct 2025 10:13:22 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FM7IF64+sAGnYCVHXx4NLB4s7yRTfaZ/ypNRXQN51LuDXwsOeaUjhdEPly1Xo4fIkVc2pXeafzWk9z5oAkpvpq9KcutubKpIQVAgih0MT/YD5JbwzoQKNDsLQlvP5uqM9xM/Q7gyz76N06hrwtYaxsamMvPQJWx8siisRb33s5WkuP1RhX+cy4Z+FInWrmrQgTOkkKPkjaPokbnqB+ztFUi27BFlorWYZJD6U7xDz7W5OR8GNZR1fEUD39Xiz1G5f2sXkxyq7zQ3oeTvVOpwaXphPMyz2hp2QrBXsG7vDl9yL8dGDj0Q4uHU5nCOWjCoTcwNMGiTJUSyvnemEEqD7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Re1DCEY/yXfeK3bnHqyiqHzXRkDdWpukp1kMCdKwIPw=;
 b=skGZaPAuCMeXBMUyM4ZcsxFBZtjgCBWt3gL+EqZHcXtBFHBhk06ufBdHT7ywR8OsZd7ROVAm0zkfR5lv7JBSdNTtcbsaxa7KUH74WLmdSavg3DMYRA1uZGnLlU0vIw9/Bf45vo5+Azs6gGw4H4Lv3Yir0xLkDOLlIv3Uz4KnzmGo/oCwk8z43/mWmw314BR1vgXb/wPNcQkCAjmfeujY93bor+PNjlZPy0UXEe99PDkhUeAqcU7O3FGEP2oWDM/Ytys6o7xxDrpOAh0L5SkrktnycediBpcAuhWRS2QhoreKR15vGUIdPh8nwyl6WDG7dZpGiVH3upvsp5G4TpXZLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Re1DCEY/yXfeK3bnHqyiqHzXRkDdWpukp1kMCdKwIPw=;
 b=GFkKyLLy5+lGbeAXkslqU3OPJL19q+PjnfR7xtq5tm4c3sITktkgNR05x919FQnVKDING+QdVXhKzwVKeb1JJcnnDdTJtXf37GITZO2gHxU0DrPj8iHPVEzTmjyUh5fIRySTHrmikP9x3ado/qFgjJtfySjZ9at4Hv/633I8xPA/n2c5xqBPSMX+9W3OzkhkY8VcBlz+7MshC0jd7GgdfGnVGXyFKKaiT7Q8HOQv2zGeEltB3qLG9suOUVdPKA5z6FBCcX0doV5PLPdXeznldFcJ/y2+VdBGsD3+X5BMebst/PJlV1SeR+XuD/2+eD08H3ys834u2/hIP1swvZ9CGA==
Received: from SN6PR16CA0070.namprd16.prod.outlook.com (2603:10b6:805:ca::47)
 by SA1PR12MB7317.namprd12.prod.outlook.com (2603:10b6:806:2ba::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Thu, 30 Oct
 2025 09:13:16 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:805:ca:cafe::56) by SN6PR16CA0070.outlook.office365.com
 (2603:10b6:805:ca::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 09:13:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 09:13:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 02:13:00 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 02:12:56 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <thomas@monjalon.net>, <getelson@nvidia.com>, <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Michael Baum <michaelba@nvidia.com>
Subject: [PATCH v3] net/mlx5: fix external Rx and Tx queues access
Date: Thu, 30 Oct 2025 11:11:38 +0200
Message-ID: <20251030091138.223868-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250731060849.18117-1-getelson@nvidia.com>
References: <20250731060849.18117-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|SA1PR12MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: 67bd2fb9-814a-4776-88e5-08de17948f61
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AjdZh5jJ+OTUfn1HrCl/CA/8/mIUWZQHLWXfB0mUJwmxSEA0G5B2ya9jZhym?=
 =?us-ascii?Q?G+HAOB8tjATR5xfmNEWdNXc6HjTNvvlkRqSw4UkkV9BwYH2/S57++rZtDy2O?=
 =?us-ascii?Q?8qvA2jYurmTDATSKnos1AbeKnrJbStH6Dzv6UgctCbaAUG4Qh77qmhSIQPfo?=
 =?us-ascii?Q?SDvnubluysKvK03E6J48jMr0ayz84qGOBHKDYtt4FRAhu4TTeJ/Uvz69L1CS?=
 =?us-ascii?Q?HPi5kmNHyOCI/nV73MGPZhLpYZ2bzpSaAkdUEwx+67ccJ34y1aTWW0eRw+U4?=
 =?us-ascii?Q?JDEJuwcuwi/+KoHNphcHGKLSifUDYCNN+KheiWGTsqJJXiOuEvS2kAFaDIPJ?=
 =?us-ascii?Q?aUK0X8oHDippwQ/ujiVWKG8Wz/fafIEWEyvhnzchaRsIYxO9dy6W/BECOQFW?=
 =?us-ascii?Q?lZtnQCNQIDa7gIPezqvj+608xBz1c7xROZR9uiy3y+blByExV7aLCvyKLX2P?=
 =?us-ascii?Q?XofjCsf1wgpgUGHjwcMKiS3yfHiEHtPP2e0wmlML8+e1LwQZ/CSALTxsqHzp?=
 =?us-ascii?Q?uZyWRcZKwCZOxmiAkIEy0RLcmjGe6IEo0TNcum/skEekjtBb3gCkmGX9bJ4/?=
 =?us-ascii?Q?+CREEZuQwl0j46Rz9snVoFwa+aYPyw3CO4bKsBX5D30mHcPWEqDqqNhur/y7?=
 =?us-ascii?Q?zGdFe5eBuPL7YOEmP3dJp6c5yhLhO005Tpi6g3/yntFrtof/dfEPkxSgwZrq?=
 =?us-ascii?Q?H3+lFYA+NoC7Dbt+ErkljmN+0NukkxcRVRviLNstgMVQQYAzTwO/v/ygT4RF?=
 =?us-ascii?Q?61WstGgMztuPwktA6gaqrawOIVVhqpYF3/hqdcQLEytUM5j5jEA6Edhfkatd?=
 =?us-ascii?Q?ToYum9M68s+UkTJEY12qYvORMnd8g2HIukf+F5BWC8u+XnzoUxHmUnLkBNPe?=
 =?us-ascii?Q?hKHmxcKCD/lSe+MOa4ZsZ50512WB9KYxRYE/dikl5R1N6XjtYliS573GJnt0?=
 =?us-ascii?Q?soIhyHI6XJE1JEKGxKoqPURhbWw0q6BwjzvotTLCzUu0lcU7ay4lOiC/Qcrh?=
 =?us-ascii?Q?bRzR3Gr3rskG+c17H8OLSxAb/166M14ytJknX2x9orcyfuqLaWuXso2Yup0x?=
 =?us-ascii?Q?gNGa/bpNeHbs+/ifJmkmDj2HwlfXw1jDLB97xGhBu59s0HIFi+o5vqcp21k9?=
 =?us-ascii?Q?CAjc3r1gv6ogqtgpxlgPQJY6vRkUYow+aBakvanEisXXtY+LCsJWTggcyYKH?=
 =?us-ascii?Q?KYY2ON3o2dQKYh8XW3Di2qSlywKZH5aGkbegaGrjT7ZOnerZEQ5Ox+Tq9kIc?=
 =?us-ascii?Q?u64BUfDc1Lwpx33H/CH2pRfPcNDej6sTu04ew7K5cveE9jrIPvxrzsExN9WJ?=
 =?us-ascii?Q?Zska5rePOMvnHbRUdtmA71sVuyb7izcJRb2TGKwswc6Pp6x9Mxp8ktd6XfL2?=
 =?us-ascii?Q?3Y3pTI209W8BA6Fo2kH/gjaUbYcWE5a23a1ufVOSj45OXeo8InY/T+bcWlSn?=
 =?us-ascii?Q?KGkLn08GFDoboWEr31nXtvbHFpZLxU1MaTYn4Sk6SIBqwnVLItWFaKL19U3X?=
 =?us-ascii?Q?/5xspD80V1eGk32U2c5rFOU/GRwd3N0IXwAfUbpUgtuC/lbK0rbz8VNi7GjL?=
 =?us-ascii?Q?2BAsesdcNgQKn0MtCi0=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 09:13:16.0057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bd2fb9-814a-4776-88e5-08de17948f61
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7317
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
v2: fixed MinGW compiler warnings.
v3: fix return value.
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
index ff61706054..5b2e17a2a9 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -2039,6 +2039,8 @@ flow_hw_get_sqn(struct rte_eth_dev *dev, uint16_t tx_queue, uint32_t *sqn)
 	}
 	if (mlx5_is_external_txq(dev, tx_queue)) {
 		ext_txq = mlx5_ext_txq_get(dev, tx_queue);
+		if (ext_txq == NULL)
+			return -EINVAL;
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

