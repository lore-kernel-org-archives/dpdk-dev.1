Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31866C7EE30
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 17:24:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4386E40670;
	Sun, 29 Jun 2025 19:23:46 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by mails.dpdk.org (Postfix) with ESMTP id 0CD9A4066C
 for <dev@dpdk.org>; Sun, 29 Jun 2025 19:23:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCMge530ek6USFm4gmgaljsLkP+INrGEiAaVmQ/SVV06LwRDDI36oz6Uts/aAAb/m2Sm9pD0CciwqLr4IpsjNoU8ptW4VtltNxiqaR7rB8KT4pLh5assxE4k42Q5zGZUaxFUD2B4tkGAlTwFfXIQAB9I0XfFu3REb0WkpTDBS7TPoSpYdvLV9ARwnhoDcjenyyCJiY8vWLjhAsUdS3WksExyIYcaQ9zxlWv9boBjydMYNNgekgXyydz4ZoPUTeGGGJc2BkiOwkHO3VrKAqm4BQBZVZ08FjVRtfjtSEPjQ2+PbicwZJl5r1y5H0Q90y5rXi0rFvZXh1bsGbg0HNAEvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pj9m6NpCiqTARpluQSxqcm5W4FKdGrGOtwuE3VhnOWI=;
 b=V8viBSSHj8yl8Y+mgeSyr9irGOH/gzaiK2ZujgY5xnNgcthMuZlnTB8APzG2nOwjWyMugcjcig/SlFxcF21Ud0nn4Jke3YlVlz64mINoHQb1SbxeLTyaWOX6LxsklpoNhlafklYzR7H9eB465OmF+vfBTiairSQelGeGyMg5vtcHSUDQ6WTw+x+PnU3QRZFEDHiX/TfMmFBh7TnfhaE8A40tGLYnAaimVczJlvE376t0+0D4MGdKf3WyKawXRz0Bt7wBB4SOXvwBtOUYGWruoaRQEuBbRynLy1D8dzXrL8FA5F0q6kDKds8pKtHK4aOSRAs2eQ1V9pL6r+1nyluC3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj9m6NpCiqTARpluQSxqcm5W4FKdGrGOtwuE3VhnOWI=;
 b=nKpKGH5zi39/ySvQQQ0ilG6sRwf/eDD5m/ClN6aNK2Kj/qX44nDAkv9MB4u4FxnYzKm04dtDWVRryNaJkFy+AE0TL0c9RsRcSG+60U8wcxI5mj27BPNQ/KzV+5p0JjsWWvH+ljZek44od/gKhVzWgYfmIiC1mYR2q/ixoD/1beIBvdatva6d5WiRUq3K9LUK/R9gKMUgD3whZB/AI1tOb3ZcyiYKhvjX/Zul0p2FJnmDOCdqfrbs5gWxjZK4bDkqfVI/+dGHUpGnyvj5Yq0fAVOWrqI52Bq+BLaVyL/m0ODpOwH4uesS8VYGZmOcypea0lU5a7uyM6tXwiGisKrd2g==
Received: from BL0PR02CA0118.namprd02.prod.outlook.com (2603:10b6:208:35::23)
 by SA1PR12MB9490.namprd12.prod.outlook.com (2603:10b6:806:45b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Sun, 29 Jun
 2025 17:23:39 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::3c) by BL0PR02CA0118.outlook.office365.com
 (2603:10b6:208:35::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.29 via Frontend Transport; Sun,
 29 Jun 2025 17:23:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sun, 29 Jun 2025 17:23:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 29 Jun
 2025 10:23:27 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 29 Jun
 2025 10:23:25 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <matan@nvidia.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <dsosnowski@nvidia.com>,
 <suanmingm@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH v5 3/5] net/mlx5: allocate and release unique resources for Tx
 queues
Date: Sun, 29 Jun 2025 20:23:01 +0300
Message-ID: <20250629172303.72049-4-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250629172303.72049-1-bingz@nvidia.com>
References: <20250629170709.69960-1x-bingz@nvidia.com>
 <20250629172303.72049-1-bingz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|SA1PR12MB9490:EE_
X-MS-Office365-Filtering-Correlation-Id: f266c548-0750-4bb0-bc72-08ddb731aff0
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X8uyXM/XVFmUX94kavVY5FCdnXN/QV9a5Jy7LjWWzBUW5npUaoYAdsGRkfLm?=
 =?us-ascii?Q?95Vnv9MjzoqjHmVuButTMlPXpqUBIaE+IVn2x8wSL9UUzifBxb8Zr3jAw/3K?=
 =?us-ascii?Q?9/ypdvqDGLwoODZ7e5qyNSK4kVHDWOTG2fhoOrUT2uHjnXIwrvipS/xLTiBZ?=
 =?us-ascii?Q?+GTQBgBfH9BtTZEk4UaGj+DjI7RQAW/LUHI3yf6DSPFQwnCMmD5glU/QY/0b?=
 =?us-ascii?Q?a5tb1gBo3pb1ZUopjWzFbAtZ7CXr8bBluZOHhXQl8ZgOGNzWHz4cOH1UxGsD?=
 =?us-ascii?Q?dQj1GzlACtx4Xj7m9L6lq44SRiIlz4hO8fWa9EOnfFE54EhmMxDuSPwYH8je?=
 =?us-ascii?Q?ZU7iO6VkrpDCZ1suqwwY34uPNFCxRrkFZG4SqeZWv/RG+sO+sFOgh/7LFjai?=
 =?us-ascii?Q?3XC1mCNMe9bG+yNNA718aNKhYTt3iqdiW7UIB6zfJxvZ8JpAVIxnAW0ZppZl?=
 =?us-ascii?Q?G4yer8cTJUvyy4OOA0jsu+vHadOE7RIJziw4vBctHLVv8WvZV0j6afCEg8LR?=
 =?us-ascii?Q?W6bWBiKjG0uJg4enWxniqM0OLmDngZDLmFV2Ld8aLYn5WpDO6RE7ez+qUrgb?=
 =?us-ascii?Q?xB8AQj5MzQU51+g3ps+rlXYX5ihNC+XVvW4Uoymoi4SPegiGmfbd1okpfAul?=
 =?us-ascii?Q?uHruU8LRDgyaYM3lqIvj5Ipf0YpdVhZGkkxUtHTtFYbdQiA3NEvb8vp5PFq8?=
 =?us-ascii?Q?Th2+TUUzi5QY/E8cnPM2NE1FMLONV41GrzRIXVj2fT3I9Ugahzv4JlvAGwM2?=
 =?us-ascii?Q?uxFUHWMCqfJvjvPSYWplHmZgp+D/kwn2jw2KWv9RNgkM+/M8PbZA+9XL+hXj?=
 =?us-ascii?Q?KexpsGlzz4JN48a4GLJjwwTaG/DdEKobphq1c0Wl7UEZOS+dhsFbEGE5ZD9v?=
 =?us-ascii?Q?wp7tqx7HOF2cYx57+Zetmcmzj+92goJ5C5DZ9vM64IOeHInIdlGLGDJCKQPV?=
 =?us-ascii?Q?1g+MwcWKYR/Xt9EGQrf2JZuExGoZZy09lfaLHf42ecbsLDkNHwCy3zZr0LhR?=
 =?us-ascii?Q?7aoQe8t7AYk6SWzE50v71d/G8hXF76NJJJW1c+7fzxtprTnyhFFvIXaL64mS?=
 =?us-ascii?Q?Zy9RoYPQyGiUeiwP68nGs8X2AnWEMUMb2yZoM4kRe48gioDaJqbUvsJk7hkD?=
 =?us-ascii?Q?N4RXU5V8LJldlW1lVYPVaC+/nyG4yLv+ytr1SvVqyOIGE97U22W4bDx6bAml?=
 =?us-ascii?Q?nmBoXRxOata/WgeHyRqjIBJyPQC/eDjFX0TdtgCagdoGcUg9qhSXR4fIdcA3?=
 =?us-ascii?Q?ZZq8popJX5jRr9ni9uekrEaPXVSIa3bEm2oMzPBV7Hq3SfPgc9l3R0UVlYj6?=
 =?us-ascii?Q?hDMulBUGdgGyShSWAN3XrIpitGN4R4WowsRvM3hpj7oY9e/yb2NxerCpnjBL?=
 =?us-ascii?Q?tDFUSzDNe5ZtV9FyR+uT3Y5Hu8xeC60utk11xE8sKtzjWm2d7vpjpDgMN4qC?=
 =?us-ascii?Q?ohcEmXX+M0ZjVXa0jOHN46QOVXSgBt8ue7C7MA/WFt0mg0i2fg/m7mrh1IoX?=
 =?us-ascii?Q?17m12x8qlqvteIF70pYv3HkuSZsQI0koeSl/?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 17:23:38.7692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f266c548-0750-4bb0-bc72-08ddb731aff0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9490
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

If the unique umem and MR method is enabled, before starting Tx
queues in device start stage, the memory will be pre-allocated
and the MR will be registered for the Tx queues' usage later.

Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5.h         |  4 ++
 drivers/net/mlx5/mlx5_trigger.c | 91 +++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 285c9ba396..c08894cd03 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -2141,6 +2141,10 @@ struct mlx5_priv {
 	struct {
 		uint32_t sq_total_size;
 		uint32_t cq_total_size;
+		void *umem;
+		void *umem_obj;
+		uint32_t sq_cur_off;
+		uint32_t cq_cur_off;
 	} consec_tx_mem;
 	RTE_ATOMIC(uint16_t) shared_refcnt; /* HW steering host reference counter. */
 };
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 3aa7d01ee2..00ffb39ecb 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1135,6 +1135,89 @@ mlx5_hw_representor_port_allowed_start(struct rte_eth_dev *dev)
 
 #endif
 
+/*
+ * Allocate TxQs unique umem and register its MR.
+ *
+ * @param dev
+ *   Pointer to Ethernet device structure.
+ *
+ * @return
+ *   0 on success, a negative errno value otherwise and rte_errno is set.
+ */
+static int mlx5_dev_allocate_consec_tx_mem(struct rte_eth_dev *dev)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+	size_t alignment;
+	uint32_t total_size;
+	struct mlx5dv_devx_umem *umem_obj = NULL;
+	void *umem_buf = NULL;
+
+	/* Legacy per queue allocation, do nothing here. */
+	if (priv->sh->config.txq_mem_algn == 0)
+		return 0;
+	alignment = (size_t)1 << priv->sh->config.txq_mem_algn);
+	total_size = priv->consec_tx_mem.sq_total_size + priv->consec_tx_mem.cq_total_size;
+	/*
+	 * Hairpin queues can be skipped later
+	 * queue size alignment is bigger than doorbell alignment, no need to align or
+	 * round-up again. One queue have two DBs (for CQ + WQ).
+	 */
+	total_size += MLX5_DBR_SIZE * priv->txqs_n * 2;
+	umem_buf = mlx5_malloc_numa_tolerant(MLX5_MEM_RTE | MLX5_MEM_ZERO, total_size,
+					     alignment, priv->sh->numa_node);
+	if (!umem_buf) {
+		DRV_LOG(ERR, "Failed to allocate consecutive memory for TxQs.");
+		rte_errno = ENOMEM;
+		return -rte_errno;
+	}
+	umem_obj = mlx5_os_umem_reg(priv->sh->cdev->ctx, (void *)(uintptr_t)umem_buf,
+				    total_size, IBV_ACCESS_LOCAL_WRITE);
+	if (!umem_obj) {
+		DRV_LOG(ERR, "Failed to register unique umem for all SQs.");
+		rte_errno = errno;
+		if (umem_buf)
+			mlx5_free(umem_buf);
+		return -rte_errno;
+	}
+	priv->consec_tx_mem.umem = umem_buf;
+	priv->consec_tx_mem.sq_cur_off = 0;
+	priv->consec_tx_mem.cq_cur_off = priv->consec_tx_mem.sq_total_size;
+	priv->consec_tx_mem.umem_obj = umem_obj;
+	DRV_LOG(DEBUG, "Allocated umem %p with size %u for %u queues with sq_len %u,"
+		" cq_len %u and registered object %p on port %u",
+		umem_buf, total_size, priv->txqs_n, priv->consec_tx_mem.sq_total_size,
+		priv->consec_tx_mem.cq_total_size, (void *)umem_obj, dev->data->port_id);
+	return 0;
+}
+
+/*
+ * Release TxQs unique umem and register its MR.
+ *
+ * @param dev
+ *   Pointer to Ethernet device structure.
+ * @param on_stop
+ *   If this is on device stop stage.
+ */
+static void mlx5_dev_free_consec_tx_mem(struct rte_eth_dev *dev, bool on_stop)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+
+	if (priv->consec_tx_mem.umem_obj) {
+		mlx5_os_umem_dereg(priv->consec_tx_mem.umem_obj);
+		priv->consec_tx_mem.umem_obj = NULL;
+	}
+	if (priv->consec_tx_mem.umem) {
+		mlx5_free(priv->consec_tx_mem.umem);
+		priv->consec_tx_mem.umem = NULL;
+	}
+	/* Queues information will not be reset. */
+	if (on_stop) {
+		/* Reset to 0s for re-setting up queues. */
+		priv->consec_tx_mem.sq_cur_off = 0;
+		priv->consec_tx_mem.cq_cur_off = 0;
+	}
+}
+
 /**
  * DPDK callback to start the device.
  *
@@ -1225,6 +1308,12 @@ mlx5_dev_start(struct rte_eth_dev *dev)
 		if (ret)
 			goto error;
 	}
+	ret = mlx5_dev_allocate_consec_tx_mem(dev);
+	if (ret) {
+		DRV_LOG(ERR, "port %u Tx queues memory allocation failed: %s",
+			dev->data->port_id, strerror(rte_errno));
+		goto error;
+	}
 	ret = mlx5_txq_start(dev);
 	if (ret) {
 		DRV_LOG(ERR, "port %u Tx queue allocation failed: %s",
@@ -1358,6 +1447,7 @@ mlx5_dev_start(struct rte_eth_dev *dev)
 	mlx5_rxq_stop(dev);
 	if (priv->obj_ops.lb_dummy_queue_release)
 		priv->obj_ops.lb_dummy_queue_release(dev);
+	mlx5_dev_free_consec_tx_mem(dev, false);
 	mlx5_txpp_stop(dev); /* Stop last. */
 	rte_errno = ret; /* Restore rte_errno. */
 	return -rte_errno;
@@ -1470,6 +1560,7 @@ mlx5_dev_stop(struct rte_eth_dev *dev)
 	priv->sh->port[priv->dev_port - 1].nl_ih_port_id = RTE_MAX_ETHPORTS;
 	mlx5_txq_stop(dev);
 	mlx5_rxq_stop(dev);
+	mlx5_dev_free_consec_tx_mem(dev, true);
 	if (priv->obj_ops.lb_dummy_queue_release)
 		priv->obj_ops.lb_dummy_queue_release(dev);
 	mlx5_txpp_stop(dev);
-- 
2.34.1

