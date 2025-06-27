Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB0CC7EE2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 16:38:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EFEF40B94;
	Fri, 27 Jun 2025 18:38:40 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by mails.dpdk.org (Postfix) with ESMTP id CBDF0400EF
 for <dev@dpdk.org>; Fri, 27 Jun 2025 18:38:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7QraS7HahXkOQfu4ocz/XZTUjkbk6UtyKxQt8ShurVk5M9tXtl0Wmn588p9s/6ukanv4SLUGd3jmex7KqnQCYjm6ia5LMEMSE1JgCCSJdQ0UQJgyuDFF32HyY9Wwj9kpBI5R+ovrY3mGdI8jFaq98C1E6m0K5SdTng9obxyYGoet1LrGir00FWAc6zemU6wzp2MTk2zdEsvnM6jXTFCqeFbsHJfjgAZyjwsS+CVQ+Dv6BOtgcQqCoCAQeoBKrcCODpWC2SlUOcku3FaKx0VoxgodiE2V20jS3/+ioZwWm8MoH8Wo8M3n+5g7j13W8lRpX9ZdPr+0hGqoAgoItbHxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aas2n6UdDUxQ7IgMNx4OxSTa7t4CjUirkS9if6Y7np8=;
 b=FpNwJrZixsiUsEZXr2dIm6KdlilCRug/OlFufUr6WjDg1Kq820erDD8aHaaHLiYeUfm86HMtxQj+QTYrcXbGSh0bhTuZTJtHwWRFHMRbA7Xyn0PhKOTZMnkRWToErXD2kTeryckgTDnQLojaeS8UjLFDmkKJPjgxX8HDt8RHRGSbOuti6GYSyXGfkP6d3Lt87FdY7EgqiFrf00USf+QNnJ4cJ6fdwh9k3i5fEfVbOYaB8gvPLz9Mu5skah/PSLSo660ZgtQAbW5+7Ll4QQnSQiSeJvzaMAk/MS21bEHQmEDFNVsyypkCSPGC8nFg3m7UDwXa//J68M0YC/04YXrJtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aas2n6UdDUxQ7IgMNx4OxSTa7t4CjUirkS9if6Y7np8=;
 b=Nr/xFbDqXqGef1TNH4WjoGd/D32z1aMx1L5GPIiDMGMIf8V7Gn0INh+wDBIkyU6ebF4MAh3pm4sDE1puKgD6TvMwDJBaMxYtJ4TwIL6nGBEHjfMIhe0hp08p7/NaIW5fD3PX7pW9gkUmI6yx833vgAmXIcj0nrX0aUa6lE2PXpZXLadWw9IIEUPh6bBeac6OTIFXOhQklyVIHbN74KGUxXwdtUULnWkjLwydgOjIhoWafSnnv40wh7RR024AU7kq4mbYil4yfbm/+quTkaG36w6xDw+KfognkOZ910cpxZrkWARwHkNLucR1mhWu0yF4laP2a+LhbymKXVgoyzbVnA==
Received: from MW2PR16CA0042.namprd16.prod.outlook.com (2603:10b6:907:1::19)
 by DS5PPF5E0E7945E.namprd12.prod.outlook.com (2603:10b6:f:fc00::650) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 27 Jun
 2025 16:38:26 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::1e) by MW2PR16CA0042.outlook.office365.com
 (2603:10b6:907:1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Fri,
 27 Jun 2025 16:38:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 16:38:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 27 Jun
 2025 09:38:04 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 27 Jun
 2025 09:38:01 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <matan@nvidia.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <dsosnowski@nvidia.com>,
 <suanmingm@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH v3 4/5] net/mlx5: pass the information in Tx queue start
Date: Fri, 27 Jun 2025 19:37:28 +0300
Message-ID: <20250627163729.50460-5-bingz@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|DS5PPF5E0E7945E:EE_
X-MS-Office365-Filtering-Correlation-Id: a18b71f9-f534-4d0a-0116-08ddb59909b5
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vIY6/lOCHw+XgrmJ8weXJHROEorSB4s4HDoYaRm5yGTOG6RRa87EdX92IBLD?=
 =?us-ascii?Q?4sExs7NcP1kVTU712kW74e8IoOREc9s9nPJ1F35ZwO0lqgvCoXUHsvwDw4t0?=
 =?us-ascii?Q?Iw0vETL3fXxKebPHWZSrGM+pIX089bAhRuI4nlj0jYzlIjoE3/sum+tXBLhB?=
 =?us-ascii?Q?1UK+HVqt+fNJXf8GRP1Ra5q7D4XU614felQfjJeRNtgy4EMmX6TSb6PQxjAB?=
 =?us-ascii?Q?9zNcA4K6mLadB4LT4c9A78cNYRYsBmyoSCr4sDOchX5rw/31WVSSy+p7Drye?=
 =?us-ascii?Q?AlaMxpSBy+cpL9d5CGVD+/UGEYhYZ0oPnkN0SxnOjO6679QxYCx6d9psqI6K?=
 =?us-ascii?Q?XiBckpeTs95EdBvdSdlpj4ZBBaju03GxNPtN2Jpj8xc+iXhyjSeyh2yvaGkR?=
 =?us-ascii?Q?w4DZiV+JS4sdAJZs4pZbjvxShX2D4PvXujDZmeImeDtCl66nzvm4f48K1K/e?=
 =?us-ascii?Q?S41cyO4mQePfJ1WEet+Bp2VyWTkZMXLzynTYzqVvB4Ph1QXPoI5RevCOBulF?=
 =?us-ascii?Q?AniUd7CvELNqm/S8Lvwz6dexxEjtCJQ7KPfhX+41/XPG27LE7t7kU5HAJ+Kc?=
 =?us-ascii?Q?ldTa9b53CUWV6Z4zLg+r/a1i/Z0PAqPfiNL91uiAUxuFO5Dr4BouLNhA939o?=
 =?us-ascii?Q?nThbKmWK/Z0zZZIg0zG4XZVOQHMZnHxp0QERMEpwq4kN4yjXvo2EcvlDaUbP?=
 =?us-ascii?Q?SwiDE/g3ZaIaq+dWHHxB9lo8cW0h70d8OrwxsCK7G8AyKwT2UDHl2715TOUF?=
 =?us-ascii?Q?nb4VCUAKjxW2LDt621BZG8OecKFca0JasnvEVfmy0YSQt8QHNS7wNHoZ6vEm?=
 =?us-ascii?Q?vUmHUnwce8H3XxoEFVnWsAPa1rNJODVRu9ovJENYgAlAyYAo2W9HCXTUlnKU?=
 =?us-ascii?Q?bzE6D+JoKWMzr1pV2XiSS1rkexaaDFQOjVrk+FgvB0kCe29wAv4QrlUITLtw?=
 =?us-ascii?Q?gA/mi+84SpGhsCltoJ0gQYtwpH63/wU7Gb2gUyLQ5DTtM+8TjNRLPD5ado8B?=
 =?us-ascii?Q?qC5lWnunBQu6xS7Q9r9IBbrgwrZGwELRJom8huTlvHDSrLmK5vj3FmVldJ+1?=
 =?us-ascii?Q?fm5H2kWdYK8JwbdGhI6JO3USiq/YT8j1V7MoXTus4FlrE03hgpJf9NYHoxdP?=
 =?us-ascii?Q?Vev4Us/D2mUdqijQRi4Dgy9vaexeLZ1LhSF/yi5ghEGhIQRv5YEJgA7n2Dqy?=
 =?us-ascii?Q?oLkasgW4jKMxKu2Wf0l5CV4tcpGv+vVIxIK4asMy1N86a9Nnoti1LQawaNU+?=
 =?us-ascii?Q?edyH6o8wDPfoj16QuCr18AjH1FC54FxNoKoEX13W7VPHfLnVTeX8sClD5rbu?=
 =?us-ascii?Q?HGf8jjAAjznW0ZN2zl6bFjWz6yOcvkAsTQ4f7oPIuOKa69P3eRUKZnQDEGkr?=
 =?us-ascii?Q?y3U8zurzVoFmegItpy8DzAt1/z0BYaa6x9LrdrvfvQIVbKwfcaZAZlqeM67a?=
 =?us-ascii?Q?Ol4604sFWXtNoA8F08h7Ez8GeLDfLAfAaAHZZP9l4HG1ALZ83ukrQV1CJAQU?=
 =?us-ascii?Q?3uFUpURgOer+RWB5Jea/3SCAwdpIQXEgkpj4?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 16:38:25.2661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a18b71f9-f534-4d0a-0116-08ddb59909b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5E0E7945E
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

The actual Devx object of SQs and CQs are only created in the
function mlx5_txq_start() in the device stage.

By changing the 1-level iteration to 2-level iterations, the Tx
queue with a big number of queue depth will be set up firstly.
This will help to split the memory from big trunks to small trunks.

In the testing, such assignment will help to improve the performance
a little bit. All the doorbells will be grouped and padded at the end
of the umem area.

The umem object and offsets information are passed to the Devx
creation function for the further usage.

Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/common/mlx5/mlx5_devx_cmds.h | 10 ++++
 drivers/net/mlx5/mlx5_devx.c         | 32 ++++++++++-
 drivers/net/mlx5/mlx5_trigger.c      | 81 ++++++++++++++--------------
 3 files changed, 82 insertions(+), 41 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_devx_cmds.h b/drivers/common/mlx5/mlx5_devx_cmds.h
index 6c726a0d46..f5fda02c1e 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.h
+++ b/drivers/common/mlx5/mlx5_devx_cmds.h
@@ -483,6 +483,11 @@ struct mlx5_devx_create_sq_attr {
 	uint32_t packet_pacing_rate_limit_index:16;
 	uint32_t tis_lst_sz:16;
 	uint32_t tis_num:24;
+	uint32_t q_off;
+	void *umem;
+	void *umem_obj;
+	uint32_t q_len;
+	uint32_t db_off;
 	struct mlx5_devx_wq_attr wq_attr;
 };
 
@@ -514,6 +519,11 @@ struct mlx5_devx_cq_attr {
 	uint64_t db_umem_offset;
 	uint32_t eqn;
 	uint64_t db_addr;
+	void *umem;
+	void *umem_obj;
+	uint32_t q_off;
+	uint32_t q_len;
+	uint32_t db_off;
 };
 
 /* Virtq attributes structure, used by VIRTQ operations. */
diff --git a/drivers/net/mlx5/mlx5_devx.c b/drivers/net/mlx5/mlx5_devx.c
index 3d49e096ef..985ffdfd18 100644
--- a/drivers/net/mlx5/mlx5_devx.c
+++ b/drivers/net/mlx5/mlx5_devx.c
@@ -1493,10 +1493,25 @@ mlx5_txq_create_devx_sq_resources(struct rte_eth_dev *dev, uint16_t idx,
 			mlx5_ts_format_conv(cdev->config.hca_attr.sq_ts_format),
 		.tis_num = mlx5_get_txq_tis_num(dev, idx),
 	};
+	uint32_t db_start = priv->consec_tx_mem.sq_total_size + priv->consec_tx_mem.cq_total_size;
+	uint32_t act_sq_len, alignment;
+	int ret;
 
 	/* Create Send Queue object with DevX. */
-	return mlx5_devx_sq_create(cdev->ctx, &txq_obj->sq_obj,
-				   log_desc_n, &sq_attr, priv->sh->numa_node);
+	if (priv->sh->config.txq_mem_algn) {
+		alignment = RTE_BIT32(priv->sh->config.txq_mem_algn);
+		sq_attr.umem = priv->consec_tx_mem.umem;
+		sq_attr.umem_obj = priv->consec_tx_mem.umem_obj;
+		act_sq_len = RTE_ALIGN(txq_data->sq_mem_len, alignment);
+		sq_attr.q_off = priv->consec_tx_mem.sq_cur_off;
+		sq_attr.db_off = db_start + (2 * idx) * MLX5_DBR_SIZE;
+		sq_attr.q_len = txq_data->sq_mem_len;
+	}
+	ret = mlx5_devx_sq_create(cdev->ctx, &txq_obj->sq_obj,
+				  log_desc_n, &sq_attr, priv->sh->numa_node);
+	if (!ret)
+		priv->consec_tx_mem.sq_cur_off += act_sq_len;
+	return ret;
 }
 #endif
 
@@ -1536,6 +1551,8 @@ mlx5_txq_devx_obj_new(struct rte_eth_dev *dev, uint16_t idx)
 	uint32_t cqe_n, log_desc_n;
 	uint32_t wqe_n, wqe_size;
 	int ret = 0;
+	uint32_t db_start = priv->consec_tx_mem.sq_total_size + priv->consec_tx_mem.cq_total_size;
+	uint32_t act_cq_len, alignment;
 
 	MLX5_ASSERT(txq_data);
 	MLX5_ASSERT(txq_obj);
@@ -1557,6 +1574,15 @@ mlx5_txq_devx_obj_new(struct rte_eth_dev *dev, uint16_t idx)
 		rte_errno = EINVAL;
 		return 0;
 	}
+	if (priv->sh->config.txq_mem_algn) {
+		alignment = RTE_BIT32(priv->sh->config.txq_mem_algn);
+		cq_attr.umem = priv->consec_tx_mem.umem;
+		cq_attr.umem_obj = priv->consec_tx_mem.umem_obj;
+		act_cq_len = RTE_ALIGN(txq_data->cq_mem_len, alignment);
+		cq_attr.q_off = priv->consec_tx_mem.cq_cur_off;
+		cq_attr.db_off = db_start + (2 * idx + 1) * MLX5_DBR_SIZE;
+		cq_attr.q_len = txq_data->cq_mem_len;
+	}
 	/* Create completion queue object with DevX. */
 	ret = mlx5_devx_cq_create(sh->cdev->ctx, &txq_obj->cq_obj, log_desc_n,
 				  &cq_attr, priv->sh->numa_node);
@@ -1641,6 +1667,8 @@ mlx5_txq_devx_obj_new(struct rte_eth_dev *dev, uint16_t idx)
 #endif
 	txq_ctrl->uar_mmap_offset =
 			mlx5_os_get_devx_uar_mmap_offset(sh->tx_uar.obj);
+	if (priv->sh->config.txq_mem_algn)
+		priv->consec_tx_mem.cq_cur_off += act_cq_len;
 	ppriv->uar_table[txq_data->idx] = sh->tx_uar.bf_db;
 	dev->data->tx_queue_state[idx] = RTE_ETH_QUEUE_STATE_STARTED;
 	return 0;
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 0fdf66d696..80ffe88120 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -51,52 +51,55 @@ static int
 mlx5_txq_start(struct rte_eth_dev *dev)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
-	unsigned int i;
+	uint32_t log_max_wqe = log2above(mlx5_dev_get_max_wq_size(priv->sh));
+	uint32_t flags = MLX5_MEM_RTE | MLX5_MEM_ZERO;
+	unsigned int i, cnt;
 	int ret;
 
-	for (i = 0; i != priv->txqs_n; ++i) {
-		struct mlx5_txq_ctrl *txq_ctrl = mlx5_txq_get(dev, i);
-		struct mlx5_txq_data *txq_data = &txq_ctrl->txq;
-		uint32_t flags = MLX5_MEM_RTE | MLX5_MEM_ZERO;
+	for (cnt = log_max_wqe; cnt > 0; cnt -= 1) {
+		for (i = 0; i != priv->txqs_n; ++i) {
+			struct mlx5_txq_ctrl *txq_ctrl = mlx5_txq_get(dev, i);
+			struct mlx5_txq_data *txq_data = &txq_ctrl->txq;
 
-		if (!txq_ctrl)
-			continue;
-		if (!txq_ctrl->is_hairpin)
-			txq_alloc_elts(txq_ctrl);
-		MLX5_ASSERT(!txq_ctrl->obj);
-		txq_ctrl->obj = mlx5_malloc_numa_tolerant(flags, sizeof(struct mlx5_txq_obj),
-							  0, txq_ctrl->socket);
-		if (!txq_ctrl->obj) {
-			DRV_LOG(ERR, "Port %u Tx queue %u cannot allocate "
-				"memory resources.", dev->data->port_id,
-				txq_data->idx);
-			rte_errno = ENOMEM;
-			goto error;
-		}
-		ret = priv->obj_ops.txq_obj_new(dev, i);
-		if (ret < 0) {
-			mlx5_free(txq_ctrl->obj);
-			txq_ctrl->obj = NULL;
-			goto error;
-		}
-		if (!txq_ctrl->is_hairpin) {
-			size_t size = txq_data->cqe_s * sizeof(*txq_data->fcqs);
-
-			txq_data->fcqs = mlx5_malloc_numa_tolerant(flags, size,
-								   RTE_CACHE_LINE_SIZE,
-								   txq_ctrl->socket);
-			if (!txq_data->fcqs) {
-				DRV_LOG(ERR, "Port %u Tx queue %u cannot "
-					"allocate memory (FCQ).",
-					dev->data->port_id, i);
+			if (!txq_ctrl || txq_data->elts_n != cnt)
+				continue;
+			if (!txq_ctrl->is_hairpin)
+				txq_alloc_elts(txq_ctrl);
+			MLX5_ASSERT(!txq_ctrl->obj);
+			txq_ctrl->obj = mlx5_malloc_numa_tolerant(flags, sizeof(struct mlx5_txq_obj),
+								  0, txq_ctrl->socket);
+			if (!txq_ctrl->obj) {
+				DRV_LOG(ERR, "Port %u Tx queue %u cannot allocate "
+					"memory resources.", dev->data->port_id,
+					txq_data->idx);
 				rte_errno = ENOMEM;
 				goto error;
 			}
-		}
-		DRV_LOG(DEBUG, "Port %u txq %u updated with %p.",
-			dev->data->port_id, i, (void *)&txq_ctrl->obj);
-		LIST_INSERT_HEAD(&priv->txqsobj, txq_ctrl->obj, next);
+			ret = priv->obj_ops.txq_obj_new(dev, i);
+			if (ret < 0) {
+				mlx5_free(txq_ctrl->obj);
+				txq_ctrl->obj = NULL;
+				goto error;
+			}
+			if (!txq_ctrl->is_hairpin) {
+				size_t size = txq_data->cqe_s * sizeof(*txq_data->fcqs);
+
+				txq_data->fcqs = mlx5_malloc_numa_tolerant(flags, size,
+									   RTE_CACHE_LINE_SIZE,
+									   txq_ctrl->socket);
+				if (!txq_data->fcqs) {
+					DRV_LOG(ERR, "Port %u Tx queue %u cannot "
+						"allocate memory (FCQ).",
+						dev->data->port_id, i);
+					rte_errno = ENOMEM;
+					goto error;
+				}
+			}
+			DRV_LOG(DEBUG, "Port %u txq %u updated with %p.",
+				dev->data->port_id, i, (void *)&txq_ctrl->obj);
+			LIST_INSERT_HEAD(&priv->txqsobj, txq_ctrl->obj, next);
 	}
+}
 	return 0;
 error:
 	ret = rte_errno; /* Save rte_errno before cleanup. */
-- 
2.34.1

