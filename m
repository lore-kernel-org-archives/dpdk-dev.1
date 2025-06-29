Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5744CC7EE30
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 17:08:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1A5240669;
	Sun, 29 Jun 2025 19:08:00 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
 by mails.dpdk.org (Postfix) with ESMTP id 3B072406BC
 for <dev@dpdk.org>; Sun, 29 Jun 2025 19:07:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWY48nXu2EBm6MoYWpQOqqVZKw6gepCsetgUGW4sgZHKqhXLQ/XfOOQptaSpEWaiudC6NBp555D3CRPHtXD9IJ+IamwRh9sBJBcpsjtwMbyNL34UqcIhK/b3TO7nNS94SlQ/8s9fYfXQssET4yeDyzkeF09ok9SZWmQKy7OjC9OzcO12Jlv7t0QVemLOzuYf8rRztZcOeQbUsdNKO7vuX+noF2fjfSGPjyn+m2p08CWoMhIaJwrftkbaf7OuLlHNUJNr1CpAFvJfdB5qk/Ctv+yPRdcBfO20QGFz1bjJXsAGF2EG/0hQCXUCYW1pX5+GQ/KZfJ5wOMSMSydnz8BSSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rerW+ygu1mukS2LYhveEv/XbPIJRyG94jMK/DlYcEYo=;
 b=kWsoppjwsfsYLxgdcGIZFgb86aFf2INyKFBC5iH0DmmuTfedRRCDguFiDd6oGkrvz6Wtqroo+lyAQ5zMnZxbd11y+3qEOtnOz5Ff2+7mGyF5G4ej319JaQaGHAeuqPPR7zlcwCFWlzURI4hg8LbFfzgCQn5B715iEWY3yClE03LFVNnQ4yILzfVn50NpPlDDnQYzoPML+NSc9ktrYcURRucdiHO1Heh8YFN7vZjpW743l3P+t8bjj6svi5SP0YEHyqJ4SsyRndKUEgbYqHoWT/PLWq8VY/FWBVc4Np3CaYhIJ9kh+4lLXh0CUoXlCj1rS8YplAn4mmakH3KhQ3CAjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rerW+ygu1mukS2LYhveEv/XbPIJRyG94jMK/DlYcEYo=;
 b=E1mxRv1CmwIeKanY4QEmFMXs0u+zgTd8GXst0mO79F1VvtRBWqsH7+guePyAqnMTpfL5ldoNk55M6sIZ4OLSwwhhIge01CabAJlYo+acuf9x3B3maWTwrVTIic9uj+AEXmryp63YKZQKp0IS0Vo5Q1EPvuuEDDAjFngfKSsn+ovLX3gjfI443n9xaJR8DYWFZHqDFTf+uabALsy1W+/1FdSYXpNu57/a1NlCS6rZcOAB7qU0I+/JEnpR1YjTrp515+AEwxtGLSqnJIR7+KkkDL9uBFr4q6kZePXKjxE0OqnKF5WWrmu6YbClGS4YhGEAx3KgQ6HhrxS8cBHIWTUQEQ==
Received: from BYAPR07CA0061.namprd07.prod.outlook.com (2603:10b6:a03:60::38)
 by CH1PR12MB9599.namprd12.prod.outlook.com (2603:10b6:610:2ae::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Sun, 29 Jun
 2025 17:07:54 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::4f) by BYAPR07CA0061.outlook.office365.com
 (2603:10b6:a03:60::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.27 via Frontend Transport; Sun,
 29 Jun 2025 17:07:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sun, 29 Jun 2025 17:07:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 29 Jun
 2025 10:07:37 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 29 Jun
 2025 10:07:34 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <matan@nvidia.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <dsosnowski@nvidia.com>,
 <suanmingm@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH v4 4/5] net/mlx5: pass the information in Tx queue start
Date: Sun, 29 Jun 2025 20:07:08 +0300
Message-ID: <20250629170709.69960-5-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250629170709.69960-1-bingz@nvidia.com>
References: <20250627163729.50460-1-bingz@nvidia.com>
 <20250629170709.69960-1-bingz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|CH1PR12MB9599:EE_
X-MS-Office365-Filtering-Correlation-Id: d7341dca-534c-497a-aa6c-08ddb72f7c8b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yiZb+5b1/Q/ie9k4LH+Aape9mCK0eXYIVRqIAWtxN0TEtyqXhAm6fSVud7sz?=
 =?us-ascii?Q?s4bPeFKEzdlJhPZdFWfjJnab1f+JmvMdzMqoOOUjUQQfPoHSnWjKv66AbVZ4?=
 =?us-ascii?Q?1TYjOd+2oWWyPTBwWQN/sx62i0FxuWzltSCBIzuV0IgIdai/uMK5VhViBRU1?=
 =?us-ascii?Q?hBQF1qg7jwHg/XdOAv0C/EbN1TcJf4WgcWsmJEckkrUHnFk3Ow1vd3awRmjq?=
 =?us-ascii?Q?GyUjHjFM03PEWRQoJ8FSsb2UiFDlYCEOBUQEytP4GKkoAMDtKzv+Xo1/rYfH?=
 =?us-ascii?Q?AwNbhGtTBxqdpp1quTD/f5s/3yeZWBo/SpSbXtXIx+W+eAZ+o2RBs2C7tKem?=
 =?us-ascii?Q?DtHpx2Qx/diTLd9wIU3MF6NS4oby+4JrQxCm3U156hR2SEFUUi//iA1MFTT4?=
 =?us-ascii?Q?L9p6twohyzHhBLEoeU3HCFwFmKGECarZSR+QE2d1nGUbf8nN6+LXKH/8oC7Z?=
 =?us-ascii?Q?EehEv6tS1KYuwn8WpsG/ti6UEjX2EnebqX4CyqdUvH37TZKELzkI934Xg7c0?=
 =?us-ascii?Q?268LitYeyz22P570NPp4TLzuOpNdD6rth3w5RMABPUAaBwRmXOowglvM7u7e?=
 =?us-ascii?Q?rgDc2gCLNtIV/tox4dwKHuUvivdIXX6HWAtKOtlFSxnitf6Y2Pgi5H9c+MA1?=
 =?us-ascii?Q?Yj3MwMxcpUvEYFRigni2H2uWXRprza2KprcuoIn3UmJ3ho0QrZbXh/IGAzRS?=
 =?us-ascii?Q?vhNy9i0tmkLVae7DdGRs9fn9U7sP+UvFBGEcp2cyNfJ36ZaFARGaseM7dteQ?=
 =?us-ascii?Q?NjrlxcAHTvrtKILhFIVahNEc94gQZgt41R0vZW3MWmr9pZYX5eX4++m/NugG?=
 =?us-ascii?Q?pmGlv3F2HfpsvxlQlbxWO8JoDNePmdylfEQkx1LUV4tSuZOwAH6nnEfJ3y0b?=
 =?us-ascii?Q?mJZK+XYzcWrrXgnfkH/qzDoGSvyMZZssnIeveVKaqKNULSL2F7A44XxdxTwS?=
 =?us-ascii?Q?UIolWisccteR4jMuk5zcYP1fKt812DU4D1j0bNGcJREQAIlWNksHbb48xG0L?=
 =?us-ascii?Q?GjZhZBn7WC8LjG/G6wc5raEaITxY+DUN0tuCINMJMfHfmfPqB1B/CDfAd2JZ?=
 =?us-ascii?Q?Zf/yS64905BDkLZr7vDPQQsXBDdHHMmKEU1aOEyM1eyJ9nS7VDL1EZZ++NYk?=
 =?us-ascii?Q?subu0Mvex5CH8L5NT3f+tix86n10RBnBnrzEW5N6zplO9dgvxTLOUdtNktjR?=
 =?us-ascii?Q?HmpCwtlFxiJij25pCGaBLP/7L9vff2Pm1ZYvF7D4kajOkLUK+zdNO9bpMZtp?=
 =?us-ascii?Q?hHeT7A9yx7lxwrXvIbfndJC2xD03vOkYvczQUkuDq4qzqqD++2zzEH3If/k+?=
 =?us-ascii?Q?KOYfvWyVrCwWHQYdp44POlfHZ+QLUUcSTyT3etxTBSYN85KYPj/OC+RoIdyI?=
 =?us-ascii?Q?TSWNtVU3HBbjxjXpfmJ3KAtiknGxmoqAvM9QpDFQFoCOOtAkZsMwN8Y2ErmZ?=
 =?us-ascii?Q?T0mm1JvyIVZt/CpScxEgUDgkCdRbJT3Kv5z7kZudqek1hL40xwmXZDEf8n7B?=
 =?us-ascii?Q?ENicDRWnKiudtqYyf/h4/CmOnYT/duFkzYsy?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 17:07:53.5971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7341dca-534c-497a-aa6c-08ddb72f7c8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9599
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
 drivers/net/mlx5/mlx5_devx.c         | 26 ++++++++-
 drivers/net/mlx5/mlx5_trigger.c      | 82 +++++++++++++++-------------
 3 files changed, 77 insertions(+), 41 deletions(-)

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
index 3d49e096ef..0ee16ba4f0 100644
--- a/drivers/net/mlx5/mlx5_devx.c
+++ b/drivers/net/mlx5/mlx5_devx.c
@@ -1493,10 +1493,22 @@ mlx5_txq_create_devx_sq_resources(struct rte_eth_dev *dev, uint16_t idx,
 			mlx5_ts_format_conv(cdev->config.hca_attr.sq_ts_format),
 		.tis_num = mlx5_get_txq_tis_num(dev, idx),
 	};
+	uint32_t db_start = priv->consec_tx_mem.sq_total_size + priv->consec_tx_mem.cq_total_size;
+	int ret;
 
 	/* Create Send Queue object with DevX. */
-	return mlx5_devx_sq_create(cdev->ctx, &txq_obj->sq_obj,
-				   log_desc_n, &sq_attr, priv->sh->numa_node);
+	if (priv->sh->config.txq_mem_algn) {
+		sq_attr.umem = priv->consec_tx_mem.umem;
+		sq_attr.umem_obj = priv->consec_tx_mem.umem_obj;
+		sq_attr.q_off = priv->consec_tx_mem.sq_cur_off;
+		sq_attr.db_off = db_start + (2 * idx) * MLX5_DBR_SIZE;
+		sq_attr.q_len = txq_data->sq_mem_len;
+	}
+	ret = mlx5_devx_sq_create(cdev->ctx, &txq_obj->sq_obj,
+				  log_desc_n, &sq_attr, priv->sh->numa_node);
+	if (!ret && priv->sh->config.txq_mem_algn)
+		priv->consec_tx_mem.sq_cur_off += txq_data->sq_mem_len;
+	return ret;
 }
 #endif
 
@@ -1536,6 +1548,7 @@ mlx5_txq_devx_obj_new(struct rte_eth_dev *dev, uint16_t idx)
 	uint32_t cqe_n, log_desc_n;
 	uint32_t wqe_n, wqe_size;
 	int ret = 0;
+	uint32_t db_start = priv->consec_tx_mem.sq_total_size + priv->consec_tx_mem.cq_total_size;
 
 	MLX5_ASSERT(txq_data);
 	MLX5_ASSERT(txq_obj);
@@ -1557,6 +1570,13 @@ mlx5_txq_devx_obj_new(struct rte_eth_dev *dev, uint16_t idx)
 		rte_errno = EINVAL;
 		return 0;
 	}
+	if (priv->sh->config.txq_mem_algn) {
+		cq_attr.umem = priv->consec_tx_mem.umem;
+		cq_attr.umem_obj = priv->consec_tx_mem.umem_obj;
+		cq_attr.q_off = priv->consec_tx_mem.cq_cur_off;
+		cq_attr.db_off = db_start + (2 * idx + 1) * MLX5_DBR_SIZE;
+		cq_attr.q_len = txq_data->cq_mem_len;
+	}
 	/* Create completion queue object with DevX. */
 	ret = mlx5_devx_cq_create(sh->cdev->ctx, &txq_obj->cq_obj, log_desc_n,
 				  &cq_attr, priv->sh->numa_node);
@@ -1641,6 +1661,8 @@ mlx5_txq_devx_obj_new(struct rte_eth_dev *dev, uint16_t idx)
 #endif
 	txq_ctrl->uar_mmap_offset =
 			mlx5_os_get_devx_uar_mmap_offset(sh->tx_uar.obj);
+	if (priv->sh->config.txq_mem_algn)
+		priv->consec_tx_mem.cq_cur_off += txq_data->cq_mem_len;
 	ppriv->uar_table[txq_data->idx] = sh->tx_uar.bf_db;
 	dev->data->tx_queue_state[idx] = RTE_ETH_QUEUE_STATE_STARTED;
 	return 0;
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 00ffb39ecb..855d7518b9 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -51,52 +51,56 @@ static int
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
+			txq_ctrl->obj = mlx5_malloc_numa_tolerant(flags,
+								  sizeof(struct mlx5_txq_obj),
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

