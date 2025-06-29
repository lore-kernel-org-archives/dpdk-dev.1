Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C9CC7EE30
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 17:23:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EADBD40613;
	Sun, 29 Jun 2025 19:23:44 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by mails.dpdk.org (Postfix) with ESMTP id C2EF640669
 for <dev@dpdk.org>; Sun, 29 Jun 2025 19:23:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmS7vFKhyJgoF5hr+u421UrV3S0qnTo1l1bRid5N0r0jIKy7GC8d+5EsL8tzqx7HWfu/tnm5h1kkGULOjVJNwVKQ6865tui0q0fDFCneiXl7dLoVJOwSLf8GMarIf3R1Y4kAueAE565c7k636W5rNjsRf6MSSLlvAYDxoMHVCPhh22VDYu7iSVRonhyN3FD5JU4WFCgHlncEm4hSc3r4d63AjSmrOZcoqUUXbxtrMhZMImFk2uAaoozsp++E/GDGXkoxcVpswGjcpJmrwTeSo3LzVURalAr/kCQQpwcka9C7n5R9X9MobQVjyAtMOEGkVVVnFx4Gcg61b/x6mvxvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rerW+ygu1mukS2LYhveEv/XbPIJRyG94jMK/DlYcEYo=;
 b=PD29xcWjEr8KeLU9sO/hTy5Df2tEIpihXgrCMHIkIgmFQQTEfr9VJXax8pjuN16jh8RgSjRSSRiNRLLwiQUNG61xbzGhvHQ+i/Xede3FJonLxtJYaGMYl9zeP5yvvbB4+bDY5Plz6sS1E0kRQOOYZZgwUyAWU+2N1LwvpES4bo9JrLRZFErWjZHs7BtpKHNhJnykzua/K+UzSPwmD13zoVpolLPZ2TH7S74QM6G3cw6CKf6rOniMyTqju1R8SR9YTyiyyQJufR0IgjoIhU0sqDIWek6CvjcJ1nz3AQeZ3t6wga5GXksf39560lkfihEsRshMlSDaPuEJZEKfaRFH0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rerW+ygu1mukS2LYhveEv/XbPIJRyG94jMK/DlYcEYo=;
 b=KcVeT7YITtvob4WYTWALcKFNz4smgBMsc8gnyR6q5WIuxaWieQ98SeKlSsuxkTgS9s2WzLa/RdmWGtJ5Vf5t3TcxVY/JREgzuL3nLksLrcBM6ObCFPZ2v6WwiWrTsgP55RBXLXu8ra3gnsEb3/1St+D5PybUNTj57HOBsvjXdfaDDKwpspZezLPJA3a6058sVBBxQC4WZ4+2Oge78s6GTQo+KWR1T+qSHxbnP5WMq7kL4B7b2kO8V6tjBYULhQkmSVxAAL//bd25gkX0Xsu9zy3ttW/d3UeWC/TouP3GYo0eQwiaCH3iCcZBgs0tezgNH84MVra755e4FYWo5l8SOA==
Received: from BN9PR03CA0540.namprd03.prod.outlook.com (2603:10b6:408:131::35)
 by PH7PR12MB7967.namprd12.prod.outlook.com (2603:10b6:510:273::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Sun, 29 Jun
 2025 17:23:40 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::d0) by BN9PR03CA0540.outlook.office365.com
 (2603:10b6:408:131::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.27 via Frontend Transport; Sun,
 29 Jun 2025 17:23:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sun, 29 Jun 2025 17:23:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 29 Jun
 2025 10:23:30 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 29 Jun
 2025 10:23:27 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <matan@nvidia.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <dsosnowski@nvidia.com>,
 <suanmingm@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH v5 4/5] net/mlx5: pass the information in Tx queue start
Date: Sun, 29 Jun 2025 20:23:02 +0300
Message-ID: <20250629172303.72049-5-bingz@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|PH7PR12MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: cfaf3053-10b7-4920-df7d-08ddb731b062
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d+qau1Yvl8ojVVYPD4FWNeVdOCZfPxbBwpD9siKkiSn17ep3R9Y09QD+3WRu?=
 =?us-ascii?Q?zHkRt+74lH+nuSFsv0sTQJv/nei80nDX51HposhVA/H0wS3gOrKhivaJsFF8?=
 =?us-ascii?Q?Q19noJgRinFtucCf/PN6HeLToJZbtOF2hXkUnd8dD8dp70wnHRFr5Ti8NOdh?=
 =?us-ascii?Q?2CA+7/+RCqPeFxto00hNLVRTYY8mKB88dyZS7qsbGRzsytoov3jBsb+dCPkY?=
 =?us-ascii?Q?vuOnYU64zB3zlHU3qNuJ/71Y/YsKEcuJvnvQLDqokIAF0DvaTpiuxIjfbs59?=
 =?us-ascii?Q?v3seTzzBDvWJOqzUomOj0/w52vvrqegnAPLLJHVAyPcLsEmyqHd4HJh+XrXS?=
 =?us-ascii?Q?Fdu61XyR2HZTKSEwWQ8ayzdZVW+rVd/E9QXtI0ugtYMLyizt1/k5nCFfTEyH?=
 =?us-ascii?Q?7mGZ3rfa+PExV5QE6ZIkgRfVYzI3GD6mO2ej94NLhUiiAAZephn+I6S+SRfQ?=
 =?us-ascii?Q?wpmg3KtnasFoegTC7qBE39E/4u7BAmGQwGaEK3qdK0YqGXxVjiu4L9iNLihJ?=
 =?us-ascii?Q?H4xUeieTUBx98dJhsiEy46vhdC9qqrJpX9vV8JHuEipd383+O8cLwYRHs2dQ?=
 =?us-ascii?Q?z2JLLyBE3wovxV/Ec+Sos44EfS7r1jJCsq69pFN7Y5ZGOO9ePWBQlJjxuSyX?=
 =?us-ascii?Q?xthU1g4EKF21OajfWkLu6FeA/gOdN2M0l8bKkXD09pWU3651IYX8LR/5YQPk?=
 =?us-ascii?Q?lXAeqdMbVVJJwLFLD5C/8pPDCUR7tlnq4TDtV3CVQTykAKAxIfb5frnPEjZ1?=
 =?us-ascii?Q?u7TxdYhpVMOAz7JYp5F1VNElvtgzwYLZ6bP/AoLE95q4Awh9vWkA7VFdw6PO?=
 =?us-ascii?Q?GgZdW9onthFJ/1qwEiotmYcGgeSj3AnwMepYBnMLwfwl6dIDNjAT1Z1anOL8?=
 =?us-ascii?Q?l4UPihERtq8k5ETlWbIEFrHIn3vMtVfndUZKx1YjJE0fwaAHLQnYeIJjZGR+?=
 =?us-ascii?Q?0fJzHTVEJ6ZMWr+dK/4AE/0UHXJmqe3usw5FdyN7srmh0Y2n3dffQI/LcCdi?=
 =?us-ascii?Q?TJZss2zks/4YkOm1fbyc+nc+WqKga5YD10kSlPocL34Vj5Bwc+Zm5GNH4blf?=
 =?us-ascii?Q?O4WL5UkszkR05D94MJUdC5cCIqp1mrXUNKRbusS70vXXrm2cH7EdCAv0bCJt?=
 =?us-ascii?Q?u2lSbXu2J9+lnRUqn/qu1nv26kOafD9dU9Y4Ec80Bjhs8Gm9WR5ykQrLPMQK?=
 =?us-ascii?Q?Lf/9rU5wLD7BtIogMLBnwqLZSTIbK2/fPkiWmcELltFEWsItFHidXc4HbBFM?=
 =?us-ascii?Q?jWIFssSzq7BZ957QhDpNCgcxX6KOjSCttw5C81yV9eqxKC0NQzaMw4YRwBbj?=
 =?us-ascii?Q?st1EiW+tB3+5xDbuOOOzZq9MJbQiCRBG66LEE0CdeS+NG8+D0QrS1MGYkZOj?=
 =?us-ascii?Q?Vtcs/u36C7sfZ4/2bFamrrGwfCiAsoi+HZpjLDI908Xm8NNvUIF9jDrg/3Ta?=
 =?us-ascii?Q?FI+v5M1OYbB2Y6OTPYze1PwulWoEBDQSjDDM+RgT+oTtiCewU+IvO95TP0hN?=
 =?us-ascii?Q?liuMzbvsTaiC9Y2BtTZmGRx3NsviHy3B+DEz?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 17:23:39.5226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfaf3053-10b7-4920-df7d-08ddb731b062
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7967
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

