Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B2BC021B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 09:09:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB22A4281D;
	Tue, 25 Feb 2025 10:09:21 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by mails.dpdk.org (Postfix) with ESMTP id 2160F427D0
 for <dev@dpdk.org>; Tue, 25 Feb 2025 10:09:20 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNRWc4wGXZIRvg6rr6/+IluBSlLNwMow+Ocftxp1KK+TjGjOnpPSjPcbfraLJkVjTFTjhDG5YbVlffKDE/P1EDZx/Z+fJ8t+/ZgqwDd/aPg+piH9Ozil+ZEOu8OwrA1jpOYzfdnA7Ifq5mhJIBapUXQ8Wh/vcHAWGPuwLqZSPMDrXUJcPpOF4ETS9M1XN1601legneRQDUJh2D3Zv+kukn1h7IbI18AUSZQ9DH4ZkVin8LHmY1dC1Qm++itrvplPldcco5dClifJFcVFDmHQntUlN2RhwYOBqmGKcOoIVp6O29AzXSycyMhMRj52LRlmWVHjEhPSCzODXNIoYUhbNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1bO1E8ViYTY1X8detv0YFCGIcg8GjsQtuwx+4rCpPM=;
 b=Vhz7ykIk8DAzBzrEtjiAPsKD+xeEdDhQYUVF5MhtPKKB5+lWyVFtS2b8I0nE6S1ZrCJ4uCKw1tohn8ZnRgvG9WLjulINnYVHHPPdLsBgs86G2DXrpacRJol9yW6PljDMlWBmqRb0aUQqebf8nYyc8gFvs3/aNOJfRtiXfRft0/ndzsrQeJBM0ZndbnIvWKxq7Ah1Xx9j7/gFOpof/SGjYWUqjceePc7XYB9IC8wzjI6v6BFZq7ndWjNNwwECSbOMP54tlkQNjETA+Psqh8IOs5h+eBKDsVFzPPJVjz63obxrXfIXgAWjm38CsbTSLziTZ4NwUIbOWRK3IEcvM5wUjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1bO1E8ViYTY1X8detv0YFCGIcg8GjsQtuwx+4rCpPM=;
 b=aq3b4wpe6FVeJiEpifN4eovtPL/Yqz4zLM4XLrzFKYGMNRgi0e0lZlb4d7tkzR0bAymLdmB82yAeZPxV7qUWUvePIrLMe6fFysbi2peb0996hM3cB6I2sWcOfCReWrwKT1WVzFBI/gVmj/kmWg8Ys/1CWXjFisvdKl861woubigt5DdvSxg67GRbI7mDbKB7zcAhbsmu05sfy+JXKvanu9XoihsgILZ26561msELjnxSwH7Bbz5+RNdzoJsNJhN6zMogXq+QaFxdChxFj4H3wLK88TXoET104aG0/Nt8hu3exami98UgJWOsGMt65TwRzFle3vzNKkFXWtFsjfY/gg==
Received: from CY5PR15CA0018.namprd15.prod.outlook.com (2603:10b6:930:14::14)
 by SN7PR12MB7154.namprd12.prod.outlook.com (2603:10b6:806:2a5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 09:09:15 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:930:14:cafe::7c) by CY5PR15CA0018.outlook.office365.com
 (2603:10b6:930:14::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Tue,
 25 Feb 2025 09:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 09:09:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 01:09:03 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 01:09:01 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Shani Peretz
 <shperetz@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH] net/mlx5: fix queue counter error check
Date: Tue, 25 Feb 2025 10:08:45 +0100
Message-ID: <20250225090845.136968-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|SN7PR12MB7154:EE_
X-MS-Office365-Filtering-Correlation-Id: b55b889e-6577-4506-c389-08dd557c13db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KeEy2mAvvhnbRE6bOxjpp2tddBVJ3mctKdaG3w2gryiE27wmtb8RF/2P6r3L?=
 =?us-ascii?Q?dWDb4vNQ7B94MHW7Od5L4EBRT3P6cgmF0+EnDGVcvk8/TdvtXaeWJ3HyCC0+?=
 =?us-ascii?Q?j9r9wl3iB0zh3GXUZYzH7TpzwtGsNI1UVCTwYafV4dHzt/o5hRHmQAI8yKDO?=
 =?us-ascii?Q?DiN3MwABbtGIE5zWrqbAvXjvj/5Nh+x755nooPAAIuH/+VxhLVLLKpM/fnfY?=
 =?us-ascii?Q?zpqTHgAJe/iYk1V9/hxjPZmlKDH1voMO7noEAnG4LImwFP32ABbaDwp1q2kf?=
 =?us-ascii?Q?n8n2H+aS22ccYFWD8HUyMux/41b6KNP3s4cOiLhXa71dAAen7v/KkxMWF06m?=
 =?us-ascii?Q?0fSbIiB8rYakcX0flRoXFPoTZov9lJHRtdL2K1jeeo9fF2FhgPyBBiuMOWsN?=
 =?us-ascii?Q?zSTtFiOv3eiVKSgo1Ddy8AQyb4CwVGv87binkUHxsSqoPh0+14sKa8IhCgN0?=
 =?us-ascii?Q?hvat+p5/by54r11Pan+I2kIhajtuWbs/x/C75LNhkVZ9wzyeEvOAhhn+85ex?=
 =?us-ascii?Q?WC8O7uR3pVr2uC5wQTIy+dNDOvG6PQx0dHfbDbAPje8D3fnS3KkqCd1LG4lc?=
 =?us-ascii?Q?OS9Pxm0JAZ20arxrQG9DOogUFWmkwUl6d1EAC6zCrRBG0gmL/AUWn+I74g7I?=
 =?us-ascii?Q?DSvloeuxZwhgUtnVj+U6gnMzI2SS2cwG2TVU7CV/Q1zpu4RIVV5FNdFpF4kv?=
 =?us-ascii?Q?bKka8QriN97GgBlieKRg2xvcYfhi40cq9rRdn/yRKsb27EP4u1is6H3LQWpP?=
 =?us-ascii?Q?rJcwBoovdovqcDorXghGFFF7Xiv6PhhWf9MVakaxLqYAu4FXRuIrIWO8Ec/G?=
 =?us-ascii?Q?RH6GB7w2AiZfS7DXmwS3KeGLKVJuamcgnBVXGpfiglqZHST14Q96vbpmZ0ui?=
 =?us-ascii?Q?mhV2RsLgxfYc3LBGB9AY4sVO0ZIvR4gEl06urWq1XLginVd7ZdyMy4255lhv?=
 =?us-ascii?Q?0M8KZKwBANhTo1yhnqzqHsDmQygd+NhhLv7ohE3WDWigLtcRTrMhi5BHUb9+?=
 =?us-ascii?Q?NeESibRmAb2h/nry2DkByEpWmaFfmJw+naji+I7T5motwLuWda51Mu0WanWY?=
 =?us-ascii?Q?Af6v9PIDrX/Rwls2qNd/nZ5ovxiFX5ovzF5vOH9pIllGnk9m1gBq4sCIcG5V?=
 =?us-ascii?Q?bhw9WMVCa26DIRV8Gg9PdfxCgFcOpUn2xXarbRMr7QTGxSDnoIkm8upUv3IZ?=
 =?us-ascii?Q?qVKPePSIEHp+dB+JeoqTUcywDoISdySCD3F9lFhyW0r/bW7AmbWvr4tc9dVY?=
 =?us-ascii?Q?MgAPov0TKrTQVf5vGkjr/ZvYdRY61YCUd2BA1c7NUxyvXWClxhAmgMYbRCXP?=
 =?us-ascii?Q?QFeZ1Ie0cZen7eF2i6xXGAmnWdvw+XUhO+Y/rzOK0zndXiU/QPBUFriq7iF2?=
 =?us-ascii?Q?CVCJCKUXB1w0RQHRKgHrkB7LMxY8YoEftSb1d8TXESVbt2aXfZR5iKZ9U5kt?=
 =?us-ascii?Q?o/Uq7QyJbsNr7wfwTypnN4Z5S8U+svXiM26NIfQJJuqwAeqFLAEGZe36Ensj?=
 =?us-ascii?Q?stCgOUq4to4Oqks=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 09:09:15.2703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b55b889e-6577-4506-c389-08dd557c13db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7154
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

Whenever queue counter allocation fails, the FW syndrome error
should be checked to determine if maximum number of queue counters
was reached.

Fixes: f0c0731b6d40 ("net/mlx5: add counters for hairpin drop")
Cc: shperetz@nvidia.com

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 91fd9346a9..cbedb2606e 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -3471,6 +3471,7 @@ mlx5_enable_port_level_hairpin_counter(struct rte_eth_dev *dev, uint64_t id __rt
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_rxq_priv *rxq;
+	int syndrome = 0;
 	unsigned int i;

 	int ret = mlx5_hairpin_queue_counter_supported(priv);
@@ -3487,15 +3488,15 @@ mlx5_enable_port_level_hairpin_counter(struct rte_eth_dev *dev, uint64_t id __rt
 	}

 	/* Alloc global hairpin queue counter. */
-	priv->q_counter_hairpin = mlx5_devx_cmd_queue_counter_alloc(priv->sh->cdev->ctx, NULL);
+	priv->q_counter_hairpin = mlx5_devx_cmd_queue_counter_alloc(priv->sh->cdev->ctx, &syndrome);
 	if (!priv->q_counter_hairpin) {
-		if (ret == MLX5_Q_COUNTERS_LIMIT_REACHED) {
-			DRV_LOG(WARNING, "Maximum number of queue counters reached. "
-					"Unable to create counter object for Port %d using DevX.",
-					priv->dev_data->port_id);
+		if (syndrome == MLX5_Q_COUNTERS_LIMIT_REACHED) {
+			DRV_LOG(ERR, "Maximum number of queue counters reached. "
+				"Unable to create counter object for Port %d using DevX.",
+				priv->dev_data->port_id);
 			return -ENOSPC;
 		}
-		DRV_LOG(WARNING, "Port %d global hairpin queue counter object cannot be created "
+		DRV_LOG(ERR, "Port %d global hairpin queue counter object cannot be created "
 			"by DevX.", priv->dev_data->port_id);
 		return -ENOMEM;
 	}
@@ -3536,6 +3537,7 @@ mlx5_enable_per_queue_hairpin_counter(struct rte_eth_dev *dev, uint64_t id)
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_rxq_priv *rxq;
 	struct mlx5_rxq_data *rxq_data;
+	int syndrome = 0;

 	int ret = mlx5_hairpin_queue_counter_supported(priv);
 	if (ret) {
@@ -3558,16 +3560,16 @@ mlx5_enable_per_queue_hairpin_counter(struct rte_eth_dev *dev, uint64_t id)
 		return 0;

 	/* Alloc hairpin queue counter. */
-	rxq->q_counter = mlx5_devx_cmd_queue_counter_alloc(priv->sh->cdev->ctx, NULL);
+	rxq->q_counter = mlx5_devx_cmd_queue_counter_alloc(priv->sh->cdev->ctx, &syndrome);
 	if (rxq->q_counter == NULL) {
-		if (ret == MLX5_Q_COUNTERS_LIMIT_REACHED) {
-			DRV_LOG(WARNING, "Maximum number of queue counters reached. "
-					"Unable to create counter object for Port %d, Queue %d "
-					"using DevX. The counter from this queue will not increment.",
-					priv->dev_data->port_id, rxq->idx);
+		if (syndrome == MLX5_Q_COUNTERS_LIMIT_REACHED) {
+			DRV_LOG(ERR, "Maximum number of queue counters reached. "
+				"Unable to create counter object for Port %d, Queue %d "
+				"using DevX. The counter from this queue will not increment.",
+				priv->dev_data->port_id, rxq->idx);
 			return -ENOSPC;
 		}
-		DRV_LOG(WARNING, "Port %d queue %d counter object cannot be created "
+		DRV_LOG(ERR, "Port %d queue %d counter object cannot be created "
 			"by DevX. Counter from this queue will not increment.",
 			priv->dev_data->port_id, rxq->idx);
 		return -ENOMEM;
--
2.39.5

