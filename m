Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B175DC7EE2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 16:38:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4B0440A6C;
	Fri, 27 Jun 2025 18:38:20 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by mails.dpdk.org (Postfix) with ESMTP id 82B6F40698
 for <dev@dpdk.org>; Fri, 27 Jun 2025 18:38:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOwkhITKqq9pSTbTO75Lvz2URjViiJkrtHB1fE+pApOseAOSDRCm2RdHTyKgvInewhr4F/a83Vn1raO7qun+w5Hjl0gmEAn4tGR1PDrmmSL1UOnvD2yU8665j8eHcBqyg/Wr9A/E4aQ23dRzG8DMDRJcyHGEvWEOFE9Ve1rM98HMX/JXFKlJLjbSVcG/LmbClYd8kRoSWhYPktdMtYuwRC2RsXxqzUW37x9nLqcJik094u0r28/SW4ipqFAQpRwoKN9Ho1tJY1I6HM1q4Dk0c4YTx81N7pFgNHoCbs/Lx5xy9QuPBeYQcIZzAsU0L7OmqL6JTOeQ61LVWlSGRD9tTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liWKI7Ux4bHSyEQ3SY+dMCeSPWj6YMkCD3hTQIoxWqI=;
 b=C48rhz0Oqv75Ozr8lYlA9IWOVRTh28xwuGjZQz95YF93UTNBi/b+lGIPqTxUUZ4DImYEzuOAWz3UngOHsz+2d7yrmtNckpSzz+c5jsFefMb007/eZBFH4RfjgUyyrUPAIFr5ZR33N1WAQaKDoWGNR9FD7yqIgy5mjoxsLcT0CfjWpvv6Q7dU9CEvOiMiQihVxvpPMTOkWSFFvp77b5OwIY8eqWAmRkJBwvHUQr8fdzl/x9ok95q6b1GZvxxF/sEagiLt9zsm0vZjxkLl+5x8ahiwyfwMbE9Be6uWzWaJjtObnrnT9fRvgikQN0jG3f5VsAzHyyfI83i4l0cX4MwwIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liWKI7Ux4bHSyEQ3SY+dMCeSPWj6YMkCD3hTQIoxWqI=;
 b=VN8+PqpKF3YSstcNv9Fp/3M3fanRRYoiO4lF9RMuaVXAQtA3RrQnorUWO5NQopbGb4PArALbyKAu82LiAWK/UrKjkvP1iHHvMDxJjE82E5icUOqsdJHzDEzaega9fybyUpyINAdJ7HyHP4MARih1ZjBfQWJ6EIrSM1j/kVCo8QFxxNZ5MCou5pLY62oZl9SwL+GwTtGOqDlv+aof4ZepyREZB+XHrvAmpL8jqchIObJFwbs/aw+HNGVJKP2UOJSn+1hSD6xtEm4eVh0SxrbJDEL5u8mJ9ybrqPDGonrXVu0W6ux6XpWjpY+N23VvinSVJ05O3yoz+ZL7L1kfd6Vldg==
Received: from BLAP220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::25)
 by DS7PR12MB6357.namprd12.prod.outlook.com (2603:10b6:8:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 27 Jun
 2025 16:38:13 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::e0) by BLAP220CA0020.outlook.office365.com
 (2603:10b6:208:32c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Fri,
 27 Jun 2025 16:38:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 16:38:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 27 Jun
 2025 09:38:01 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 27 Jun
 2025 09:37:59 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <matan@nvidia.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <dsosnowski@nvidia.com>,
 <suanmingm@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH v3 3/5] net/mlx5: allocate and release unique resources for Tx
 queues
Date: Fri, 27 Jun 2025 19:37:27 +0300
Message-ID: <20250627163729.50460-4-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627163729.50460-1-bingz@nvidia.com>
References: <20250623183456.130666-1-bingz@nvidia.com>
 <20250627163729.50460-1-bingz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|DS7PR12MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f3c9ae-499f-461b-77c0-08ddb59902d3
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l2TIcxwC0MXUyM2re5rO1suFgUAHhHbyU5U9w3lSsaT4aVUypcsBy2GRHs0k?=
 =?us-ascii?Q?nZFyQ30bo7QEYDirWwqVz/ZvCxSYWltA35NgoAwQxpVH0zcIBDrm7nPvUO8n?=
 =?us-ascii?Q?fMa8lkaqaczX923LJz6quqCCLAS8LVSMeFqDZiqWmeFoYHleJWrNWERBL9mc?=
 =?us-ascii?Q?dUKqz2gm0gqzN9AJVGVMLoUhsu5mMwqEsfMdhmnEQpisDRI3CHDViJA4SD6h?=
 =?us-ascii?Q?Yw80mlFhmrJG/q7lT9UIBLcNm0X9STumEh0YIciEw3JSlfCGDuVXgGq7Pb5E?=
 =?us-ascii?Q?kMGJYLA3QMLXeLrq665fuWO3U6L7G4ytSK8s+Lf+yjD8QpoSH4AMsVMZasxA?=
 =?us-ascii?Q?StHrP7yX8ldmuyrZ+E3ToglkP618nRwua9Im15tN8ImfbCNolBSESuCq95Dw?=
 =?us-ascii?Q?PYdmY7pklkzzRjilrlEDWFplmCkJxufN81GfApi6NncBpgsenYA3QRxz2cxU?=
 =?us-ascii?Q?mrzXzkV/dv1p8LpT3X13spp9rwX/8cN8jcBoJd5x7oZenxnLTzAEyZ5tyDLA?=
 =?us-ascii?Q?bMDjffWSDAvshSlILzy/nugrHpbvPXqJXfuM0QYcxZ/cOd0n/PFnrJvWlNsB?=
 =?us-ascii?Q?BcdSMDCK4mb3vZAoOew1pQpdW5E6wsanJ0ZzAjKK+cIFdL6BUmJDTb3l2HYg?=
 =?us-ascii?Q?fuY4s/VV/pLGsdeb+o/ISY9+elCcnZIyCU4qfBPJNXhrjwwylSbyuOwIvBZ6?=
 =?us-ascii?Q?/u4zNY4qkkQPaBl+odxTnIfxhXbMpi2kZZLTSwni6ZSAe1NdJJzvB4DxIZin?=
 =?us-ascii?Q?F8/8vpHEHbO39vWAYuFwKDHPMGOudyTXp3kHtq2GJvyyDXH6Ud7KmyOXrRim?=
 =?us-ascii?Q?3OmL2/0swOfR3y5SqmBB/Qg8xy8XxMmTv5XRHQlIlmvAuPBZvgQxOz+6Ywvq?=
 =?us-ascii?Q?JIzrsLOpIKH6EiAVvXWMXOu4FpvPVI3yViZ9oYtrxEyu4AqFDJUYxtvnugtd?=
 =?us-ascii?Q?FuRBdKZSHmBprbI4YYkOAfbxQfAoeFEo81q5gWODRgsTylG7xKvA5WG6OQ3E?=
 =?us-ascii?Q?jfmY36n/ioJvCAsi+GMwgO4YEbV1eNRRUz8NP+DltujPDSlugr2UT4b43b9t?=
 =?us-ascii?Q?zydQJlgAuzwoBShyJy6qbehpDXD2LGFr/vjb1lfnd0AAa1naO8GSL/EPmKqE?=
 =?us-ascii?Q?+sl+VJU2zEu+2PSCjCqiXRbLIg2tZDAkU1N1hxb95qJr+mwcezmx7Ti9oS7L?=
 =?us-ascii?Q?+UfMPXbn4wjS6sA0tqireU7xweuabfH9T7A8GrSV1QZr4fgxJySDvqDCjvW8?=
 =?us-ascii?Q?mB0IKdR1oFgpf/3JTl0DMcB24LP+EsT+wtHRyN9mrefMuVckGNVOhWveh/GM?=
 =?us-ascii?Q?m0f19cx+Q1kFL69KDRB0maBV6IxG3OUWounqpNeDyLBFqz4j+8nwBme4qmRW?=
 =?us-ascii?Q?aef5kXEhisJpKvbba+RPItyeKvv98Ta6tQOC5oWdOoY50AsE4EM0oDowWHOv?=
 =?us-ascii?Q?htcbJrfhWN7rCuGohVtVQ8qHvgRoUeC+fEIjBy2ZEO0wz+OhrkXJg4jaJ1oh?=
 =?us-ascii?Q?iS8MHiBE+Tb9Tymoip/avPWXz8lzOeXRL3BX?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 16:38:13.7292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f3c9ae-499f-461b-77c0-08ddb59902d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6357
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
 drivers/net/mlx5/mlx5_trigger.c | 85 +++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

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
index 3aa7d01ee2..0fdf66d696 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1135,6 +1135,83 @@ mlx5_hw_representor_port_allowed_start(struct rte_eth_dev *dev)
 
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
+	alignment = RTE_BIT32(priv->sh->config.txq_mem_algn);
+	total_size = priv->consec_tx_mem.sq_total_size + priv->consec_tx_mem.cq_total_size;
+	/*
+	 * Hairpin queues can be skipped later
+	 * queue size alignment is bigger than doorbell alignment, no need to align or
+	 * round-up again. 1 queue have 2 DBs.
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
+ */
+static void mlx5_dev_free_consec_tx_mem(struct rte_eth_dev *dev)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+
+	if (priv->sh->config.txq_mem_algn == 0)
+		return;
+	if (priv->consec_tx_mem.umem_obj) {
+		mlx5_os_umem_dereg(priv->consec_tx_mem.umem_obj);
+		priv->consec_tx_mem.umem_obj = NULL;
+	}
+	if (priv->consec_tx_mem.umem) {
+		mlx5_free(priv->consec_tx_mem.umem);
+		priv->consec_tx_mem.umem = NULL;
+	}
+}
+
 /**
  * DPDK callback to start the device.
  *
@@ -1225,6 +1302,12 @@ mlx5_dev_start(struct rte_eth_dev *dev)
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
@@ -1358,6 +1441,7 @@ mlx5_dev_start(struct rte_eth_dev *dev)
 	mlx5_rxq_stop(dev);
 	if (priv->obj_ops.lb_dummy_queue_release)
 		priv->obj_ops.lb_dummy_queue_release(dev);
+	mlx5_dev_free_consec_tx_mem(dev);
 	mlx5_txpp_stop(dev); /* Stop last. */
 	rte_errno = ret; /* Restore rte_errno. */
 	return -rte_errno;
@@ -1470,6 +1554,7 @@ mlx5_dev_stop(struct rte_eth_dev *dev)
 	priv->sh->port[priv->dev_port - 1].nl_ih_port_id = RTE_MAX_ETHPORTS;
 	mlx5_txq_stop(dev);
 	mlx5_rxq_stop(dev);
+	mlx5_dev_free_consec_tx_mem(dev);
 	if (priv->obj_ops.lb_dummy_queue_release)
 		priv->obj_ops.lb_dummy_queue_release(dev);
 	mlx5_txpp_stop(dev);
-- 
2.34.1

