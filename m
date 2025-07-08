Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B074C8303C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 09:54:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC560402A0;
	Tue,  8 Jul 2025 11:54:26 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by mails.dpdk.org (Postfix) with ESMTP id 55CB24028C
 for <dev@dpdk.org>; Tue,  8 Jul 2025 11:54:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIV0esuozqPpYAQ/7t37b0IFwdclzcor/i89zaVwCgkHxS1y1BiaYxLRqvJ+5ghZ04dvbsCyhaHlHREEWl6MqmELoFVMjb2GMXmqstgajeGihc+q3spZ2sJbK/kwDghZu6aI2xcxkES9qJYsmUkhWrFYrZ/AocCqG+oDWkccJ+0RKHMVd0mrd5F/YLW3cAZxp5mS28lITejGiBpK/WQwI30qd4QCs0etm2znbNzO+0pSPadXa1KKvhWmFQWl7R27kB/F5wSuca0vs3Crd2UvSZolmvODKLpLL5Vt5aG0vZqaXo9CZYavg8wlH6RARYj9EJs3RXMyqA8RyQhtpGVk9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJNY7I1FhDu+zsIllicT7dbpdwnfsKfrMFxa2Zk+eVA=;
 b=lGiPu06aSpPic/yZwg4HbJN5lx0xaG7FBqyfQkhFm3R06aCr+W2Qz1YyxPR3YXiWO47dPJji1E+H+B88rZhQoAWnfdFdsDthlonImMI5AYgfpq2SSI+/3y8C4xVKcld5Pw2afxmWLkDx8BtVqxjf27yl4uY3qak0SBrsWKzpkQEtzDEGeEGx64o8x/9LOkWu/nRVWvvTDxCHkZ/JWWCSnqzVsjXswooS+A6pIwvbSPhusIDuci+j3Hxq6gYcyngWcP5Wieb2a65Te7pRsHovMMqHl7J1qgQ1lQmF/JsXISqW5Va15vBbPqG2NVMrXXZadNyVshJwavtZ81FRScDrsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJNY7I1FhDu+zsIllicT7dbpdwnfsKfrMFxa2Zk+eVA=;
 b=Eq/J4NsQwvaHQo44lMyy7Gy9PG7FpNHuogfebSvwhtKwCRzxR8CHCW88rMWO3aGSdd7JEe1dNRS+U73w9AAdOluKxNyu+3PbAafssNwc4z5SSKCN00SefUwjU1/urV6M+VgWe9UcHNUSro+QhiSzZACrfH/Qd7i5rKMgNWXuB9oB8M5Ldi5w0kZSdA8Q7UAPO1NX2ZB5ACICP/kxxecubZlLYmx7wME1yI5QRPgcVVryhtb0diK7t9LKiYhP6I8DZRkUAWw6xv1PCBQjJnVYaxmBIN6aexqQWzJmvXhEhTVvU0vqaIQTW4IewhRoSLMMCBB0Xb3MivN38KaaJsAfOw==
Received: from MN2PR22CA0023.namprd22.prod.outlook.com (2603:10b6:208:238::28)
 by PH7PR12MB5831.namprd12.prod.outlook.com (2603:10b6:510:1d6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 09:54:15 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:208:238:cafe::76) by MN2PR22CA0023.outlook.office365.com
 (2603:10b6:208:238::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 09:54:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.1 via Frontend Transport; Tue, 8 Jul 2025 09:54:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Jul 2025
 02:53:59 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 8 Jul
 2025 02:53:57 -0700
From: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, <matan@nvidia.com>, <suanmingm@nvidia.com>,
 <dsosnowski@nvidia.com>
Subject: [PATCH] net/mlx5: fix out of order completions in ordinary Rx burst
Date: Tue, 8 Jul 2025 12:53:41 +0300
Message-ID: <20250708095341.441890-1-viacheslavo@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|PH7PR12MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c5e7a6-3c2e-47f6-cbd5-08ddbe056611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yNzQAsI4nDQm60Sx0a9BnrpiLx377OqpQRbskK184uiYuKW9z/rlzsXhOyLw?=
 =?us-ascii?Q?ecfO0UKjl2sVgpYkz6MbwKwdIUiMOX8mZ8dOpG9/PDlrVaZ1oz0N+dPfdvrF?=
 =?us-ascii?Q?Ubbjwxn9D4RsS0gBzTgxd6NZXEkvl4QBuzF7bSbF1KKV/caMyjySPSgS/JZm?=
 =?us-ascii?Q?zk1395v4TqoKLUPhTQN+jzPwYyzmXDA7FdA3B36I1g+ocir+bcC9Ba1Kcr0k?=
 =?us-ascii?Q?wR9no+Knbw40aJ5bhQM8NuHTgk54vs7NW6e7IzjwlHMnf7R4/G6VGcIhBMGq?=
 =?us-ascii?Q?lR4YF1EAjrgaN464ncCCJVJWlWIWDy+buKiIwKiHooYNqGXQ2MwGZL5a8XDV?=
 =?us-ascii?Q?XyLmCBy6qdBukRkux4sj+rQCG8C2kSJ6WKfX6lt414MP85+Da/mVbG9RVtk/?=
 =?us-ascii?Q?6spLGrAzKW3rT8dgGzod/HYH6555zP5ktYQVg1ZLdy17sWGnvpWgrKEO/2Xg?=
 =?us-ascii?Q?866tdXl2AY1LBYi4ehzQtozA/A5qzp6H9KEcA0whA1SBrYq2dQl7GqTQJDOF?=
 =?us-ascii?Q?iDx07WbRgLZnLiWaus2dHVqTKURh2XwMg0FmXi1K8jc+Dtv27OM4im1kiWeH?=
 =?us-ascii?Q?+1L57nbXSvz3d8mRtj0ZYZK5s+sgDWAJjXvZCcL4/lQYlZ0UyGuKY95Spdv1?=
 =?us-ascii?Q?2H2M7yxmrGGkOvOJ0kZ4PLEtt8G+AlS3GfoGebBGgC+2492+DHFTXYuCSHFd?=
 =?us-ascii?Q?y/KIMDHrS7qq7Ycw/rrJtVUdqK5YI3RhJFA53JpLkhYvTpJxSMdHftO7F/h4?=
 =?us-ascii?Q?CFgl2ZrhrwaxdVB2iyqtjjDuV491FGuACbd/cgfQ+XzuH5clSDAZ0gCaYQj/?=
 =?us-ascii?Q?EtQpKaFBB7L1wAc0C0LR8JKynGP7WR8w+NJ9xW6qSXbKS/WGRz6WAd5ioBbG?=
 =?us-ascii?Q?YCsJCvvSLIGrUObzDnHo6g1xMFoXaUi7XKidBjV8NC3M4TjO9Y8V7t8nNJY7?=
 =?us-ascii?Q?CIep6eCSbB3QUCqayNf8jcBUtaIBA+VTZEmDGtNqi0P3044UKjbgbTGuYdLi?=
 =?us-ascii?Q?d2eqLHkWlUn7gDQuVdaWNS3O5DQ7tHYkWmhSD87ZA830B/Eilhl5CvMeYd4Q?=
 =?us-ascii?Q?nn4qv9TpIKM52JDg1RwKa74xpHKG8NL6XdaOi/SXYUjnPOpZMy58SffRe6HG?=
 =?us-ascii?Q?y93w22/P0id8GyHe/Oha+3FqtxQrvA37swuBt/mujkqp4sTzDTLRY7O+ZH+b?=
 =?us-ascii?Q?W7EQoV1jMgceZMRtAiiDbCejlSLvZuDEcfxh+drkwLzx0HeBtt5X85/AvQVE?=
 =?us-ascii?Q?z/98Q7CQnTEEeeu2cgwR2Ns8Ly8FLG6vAjxBGhRudYifYparU7NDJUg/xbZx?=
 =?us-ascii?Q?G7n9dfn1udx7TPm8kesXC+EgzbUTTj1UE0uIsyUy9uWZn6/bp0MBkgNZdf4g?=
 =?us-ascii?Q?fHRYNxnFpOG8oPb5FFl1TCzxRvBn8T9aaB78fPIfIkAjAJeouNLbVTL6bKUW?=
 =?us-ascii?Q?x5gGIHKwp+4n6rBDIdfCqRaGq5mqImkEFmpxsGnVHZ7K7c8OjuhLl/qwQxJ8?=
 =?us-ascii?Q?yCSv3TUe1LIxmO7pfSAoAXXwb+hLTv8Sg6Jh?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 09:54:15.1064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c5e7a6-3c2e-47f6-cbd5-08ddbe056611
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5831
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

The existing Rx burst routines suppose the completions in CQ
arrive in order and address the WQEs in receiving queue in order.
That is not true for the shared RQs, CQEs can arrive in out of
order and to address appropriate WQE we should fetch its index
from the CQE wqe_counter field.

Also, we can advance the RQ CI if and only if all the WQEs are
handled in the covered range. This requires slide window to track
handled WQEs. We support the out-of-order window size up to the
full queue size.

Fixes: 09c2555303be ("net/mlx5: support shared Rx queue")

Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_verbs.c |   8 +-
 drivers/net/mlx5/mlx5_devx.c        |   7 +-
 drivers/net/mlx5/mlx5_ethdev.c      |   8 +-
 drivers/net/mlx5/mlx5_rx.c          | 284 +++++++++++++++++++++++++++-
 drivers/net/mlx5/mlx5_rx.h          |  28 ++-
 drivers/net/mlx5/mlx5_rxq.c         |  11 +-
 6 files changed, 334 insertions(+), 12 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_verbs.c b/drivers/net/mlx5/linux/mlx5_verbs.c
index 454bd7c77e..9011319a3e 100644
--- a/drivers/net/mlx5/linux/mlx5_verbs.c
+++ b/drivers/net/mlx5/linux/mlx5_verbs.c
@@ -397,7 +397,13 @@ mlx5_rxq_ibv_obj_new(struct mlx5_rxq_priv *rxq)
 	rxq_data->wqes = rwq.buf;
 	rxq_data->rq_db = rwq.dbrec;
 	rxq_data->cq_arm_sn = 0;
-	mlx5_rxq_initialize(rxq_data);
+	ret = mlx5_rxq_initialize(rxq_data);
+	if (ret) {
+		DRV_LOG(ERR, "Port %u Rx queue %u RQ initialization failure.",
+			priv->dev_data->port_id, rxq->idx);
+		rte_errno = ENOMEM;
+		goto error;
+	}
 	rxq_data->cq_ci = 0;
 	priv->dev_data->rx_queue_state[idx] = RTE_ETH_QUEUE_STATE_STARTED;
 	rxq_ctrl->wqn = ((struct ibv_wq *)(tmpl->wq))->wq_num;
diff --git a/drivers/net/mlx5/mlx5_devx.c b/drivers/net/mlx5/mlx5_devx.c
index 0ee16ba4f0..10bd93c29a 100644
--- a/drivers/net/mlx5/mlx5_devx.c
+++ b/drivers/net/mlx5/mlx5_devx.c
@@ -683,7 +683,12 @@ mlx5_rxq_devx_obj_new(struct mlx5_rxq_priv *rxq)
 				(uint32_t *)(uintptr_t)tmpl->devx_rmp.wq.db_rec;
 	}
 	if (!rxq_ctrl->started) {
-		mlx5_rxq_initialize(rxq_data);
+		if (mlx5_rxq_initialize(rxq_data)) {
+			DRV_LOG(ERR, "Port %u Rx queue %u RQ initialization failure.",
+			priv->dev_data->port_id, rxq->idx);
+			rte_errno = ENOMEM;
+			goto error;
+		}
 		rxq_ctrl->wqn = rxq->devx_rq.rq->id;
 	}
 	priv->dev_data->rx_queue_state[rxq->idx] = RTE_ETH_QUEUE_STATE_STARTED;
diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.c
index b7df39ace9..68d1c1bfa7 100644
--- a/drivers/net/mlx5/mlx5_ethdev.c
+++ b/drivers/net/mlx5/mlx5_ethdev.c
@@ -648,6 +648,7 @@ mlx5_dev_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements)
 	};
 
 	if (dev->rx_pkt_burst == mlx5_rx_burst ||
+	    dev->rx_pkt_burst == mlx5_rx_burst_out_of_order ||
 	    dev->rx_pkt_burst == mlx5_rx_burst_mprq ||
 	    dev->rx_pkt_burst == mlx5_rx_burst_vec ||
 	    dev->rx_pkt_burst == mlx5_rx_burst_mprq_vec) {
@@ -718,7 +719,12 @@ mlx5_select_rx_function(struct rte_eth_dev *dev)
 	eth_rx_burst_t rx_pkt_burst = mlx5_rx_burst;
 
 	MLX5_ASSERT(dev != NULL);
-	if (mlx5_check_vec_rx_support(dev) > 0) {
+	if (mlx5_shared_rq_enabled(dev)) {
+		rx_pkt_burst = mlx5_rx_burst_out_of_order;
+		DRV_LOG(DEBUG, "port %u forced to use SPRQ"
+			" Rx function with Out-of-Order completions",
+			dev->data->port_id);
+	} else if (mlx5_check_vec_rx_support(dev) > 0) {
 		if (mlx5_mprq_enabled(dev)) {
 			rx_pkt_burst = mlx5_rx_burst_mprq_vec;
 			DRV_LOG(DEBUG, "port %u selected vectorized"
diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
index 5f4a93fe8c..5e8c312d00 100644
--- a/drivers/net/mlx5/mlx5_rx.c
+++ b/drivers/net/mlx5/mlx5_rx.c
@@ -42,7 +42,7 @@ static __rte_always_inline int
 mlx5_rx_poll_len(struct mlx5_rxq_data *rxq, volatile struct mlx5_cqe *cqe,
 		 uint16_t cqe_n, uint16_t cqe_mask,
 		 volatile struct mlx5_mini_cqe8 **mcqe,
-		 uint16_t *skip_cnt, bool mprq);
+		 uint16_t *skip_cnt, bool mprq, uint32_t *widx);
 
 static __rte_always_inline uint32_t
 rxq_cq_to_ol_flags(volatile struct mlx5_cqe *cqe);
@@ -221,6 +221,8 @@ mlx5_rx_burst_mode_get(struct rte_eth_dev *dev,
 	}
 	if (pkt_burst == mlx5_rx_burst) {
 		snprintf(mode->info, sizeof(mode->info), "%s", "Scalar");
+	} else if (pkt_burst == mlx5_rx_burst_out_of_order) {
+		snprintf(mode->info, sizeof(mode->info), "%s", "Scalar Out-of-Order");
 	} else if (pkt_burst == mlx5_rx_burst_mprq) {
 		snprintf(mode->info, sizeof(mode->info), "%s", "Multi-Packet RQ");
 	} else if (pkt_burst == mlx5_rx_burst_vec) {
@@ -359,13 +361,84 @@ rxq_cq_to_pkt_type(struct mlx5_rxq_data *rxq, volatile struct mlx5_cqe *cqe,
 	return mlx5_ptype_table[idx] | rxq->tunnel * !!(idx & (1 << 6));
 }
 
+static inline void mlx5_rq_win_reset(struct mlx5_rxq_data *rxq)
+{
+	static_assert(MLX5_WINOOO_BITS == (sizeof(*rxq->rq_win_data) * CHAR_BIT),
+		      "Invalid out-of-order window bitwidth");
+	rxq->rq_win_idx = 0;
+	rxq->rq_win_cnt = 0;
+	if (rxq->rq_win_data != NULL && rxq->rq_win_idx_mask != 0)
+		memset(rxq->rq_win_data, 0, (rxq->rq_win_idx_mask + 1) * sizeof(*rxq->rq_win_data));
+}
+
+static inline int mlx5_rq_win_init(struct mlx5_rxq_data *rxq)
+{
+	struct mlx5_rxq_ctrl *ctrl = container_of(rxq, struct mlx5_rxq_ctrl, rxq);
+	uint32_t win_size, win_mask;
+
+	/* Set queue size as window size */
+	win_size = 1u << rxq->elts_n;
+	win_size = RTE_MAX(win_size, MLX5_WINOOO_BITS);
+	win_size = win_size / MLX5_WINOOO_BITS;
+	win_mask = win_size - 1;
+	if (win_mask != rxq->rq_win_idx_mask || rxq->rq_win_data == NULL) {
+		mlx5_free(rxq->rq_win_data);
+		rxq->rq_win_idx_mask = 0;
+		rxq->rq_win_data = mlx5_malloc(MLX5_MEM_RTE,
+					       win_size * sizeof(*rxq->rq_win_data),
+					       RTE_CACHE_LINE_SIZE, ctrl->socket);
+		if (rxq->rq_win_data == NULL)
+			return -ENOMEM;
+		rxq->rq_win_idx_mask = (uint16_t)win_mask;
+	}
+	mlx5_rq_win_reset(rxq);
+	return 0;
+}
+
+static inline bool mlx5_rq_win_test(struct mlx5_rxq_data *rxq)
+{
+	return !!rxq->rq_win_cnt;
+}
+
+static inline void mlx5_rq_win_update(struct mlx5_rxq_data *rxq, uint32_t delta)
+{
+	uint32_t idx;
+
+	idx = (delta / MLX5_WINOOO_BITS) + rxq->rq_win_idx;
+	idx &= rxq->rq_win_idx_mask;
+	rxq->rq_win_cnt = 1;
+	rxq->rq_win_data[idx] |= 1u << (delta % MLX5_WINOOO_BITS);
+}
+
+static inline uint32_t mlx5_rq_win_advance(struct mlx5_rxq_data *rxq, uint32_t delta)
+{
+	uint32_t idx;
+
+	idx = (delta / MLX5_WINOOO_BITS) + rxq->rq_win_idx;
+	idx &= rxq->rq_win_idx_mask;
+	rxq->rq_win_data[idx] |= 1u << (delta % MLX5_WINOOO_BITS);
+	++rxq->rq_win_cnt;
+	if (delta >= MLX5_WINOOO_BITS)
+		return 0;
+	delta = 0;
+	while (~rxq->rq_win_data[idx] == 0) {
+		rxq->rq_win_data[idx] = 0;
+		MLX5_ASSERT(rxq->rq_win_cnt >= MLX5_WINOOO_BITS);
+		rxq->rq_win_cnt -= MLX5_WINOOO_BITS;
+		idx = (idx + 1) & rxq->rq_win_idx_mask;
+		rxq->rq_win_idx = idx;
+		delta += MLX5_WINOOO_BITS;
+	}
+	return delta;
+}
+
 /**
  * Initialize Rx WQ and indexes.
  *
  * @param[in] rxq
  *   Pointer to RX queue structure.
  */
-void
+int
 mlx5_rxq_initialize(struct mlx5_rxq_data *rxq)
 {
 	const unsigned int wqe_n = 1 << rxq->elts_n;
@@ -414,8 +487,12 @@ mlx5_rxq_initialize(struct mlx5_rxq_data *rxq)
 		(wqe_n >> rxq->sges_n) * RTE_BIT32(rxq->log_strd_num) : 0;
 	/* Update doorbell counter. */
 	rxq->rq_ci = wqe_n >> rxq->sges_n;
+	rxq->rq_ci_ooo = rxq->rq_ci;
+	if (mlx5_rq_win_init(rxq))
+		return -ENOMEM;
 	rte_io_wmb();
 	*rxq->rq_db = rte_cpu_to_be_32(rxq->rq_ci);
+	return 0;
 }
 
 #define MLX5_ERROR_CQE_MASK 0x40000000
@@ -524,6 +601,9 @@ mlx5_rx_err_handle(struct mlx5_rxq_data *rxq, uint8_t vec,
 						    16 * wqe_n);
 			rxq_ctrl->dump_file_n++;
 		}
+		/* Try to find the actual cq_ci in hardware for shared queue. */
+		if (rxq->shared)
+			rxq_sync_cq(rxq);
 		rxq->err_state = MLX5_RXQ_ERR_STATE_NEED_READY;
 		/* Fall-through */
 	case MLX5_RXQ_ERR_STATE_NEED_READY:
@@ -583,7 +663,8 @@ mlx5_rx_err_handle(struct mlx5_rxq_data *rxq, uint8_t vec,
 					(*rxq->elts)[elts_n + i] =
 								&rxq->fake_mbuf;
 			}
-			mlx5_rxq_initialize(rxq);
+			if (mlx5_rxq_initialize(rxq))
+				return MLX5_RECOVERY_ERROR_RET;
 			rxq->err_state = MLX5_RXQ_ERR_STATE_NO_ERROR;
 			return MLX5_RECOVERY_COMPLETED_RET;
 		}
@@ -613,6 +694,10 @@ mlx5_rx_err_handle(struct mlx5_rxq_data *rxq, uint8_t vec,
  *   Number of packets skipped due to recoverable errors.
  * @param mprq
  *   Indication if it is called from MPRQ.
+ * @param[out] widx
+ *   Store WQE index from CQE to support out of order completions. NULL
+ *   can be specified if index is not needed
+ *
  * @return
  *   0 in case of empty CQE,
  *   MLX5_REGULAR_ERROR_CQE_RET in case of error CQE,
@@ -624,7 +709,7 @@ static inline int
 mlx5_rx_poll_len(struct mlx5_rxq_data *rxq, volatile struct mlx5_cqe *cqe,
 		 uint16_t cqe_n, uint16_t cqe_mask,
 		 volatile struct mlx5_mini_cqe8 **mcqe,
-		 uint16_t *skip_cnt, bool mprq)
+		 uint16_t *skip_cnt, bool mprq, uint32_t *widx)
 {
 	struct rxq_zip *zip = &rxq->zip;
 	int len = 0, ret = 0;
@@ -640,6 +725,8 @@ mlx5_rx_poll_len(struct mlx5_rxq_data *rxq, volatile struct mlx5_cqe *cqe,
 							cqe_mask].pkt_info);
 			len = rte_be_to_cpu_32((*mc)[zip->ai & 7].byte_cnt &
 						rxq->byte_mask);
+			if (widx != NULL)
+				*widx = zip->wqe_idx + zip->ai;
 			*mcqe = &(*mc)[zip->ai & 7];
 			if (rxq->cqe_comp_layout) {
 				zip->ai++;
@@ -693,6 +780,9 @@ mlx5_rx_poll_len(struct mlx5_rxq_data *rxq, volatile struct mlx5_cqe *cqe,
 			if (unlikely(ret != MLX5_CQE_STATUS_SW_OWN)) {
 				if (unlikely(ret == MLX5_CQE_STATUS_ERR ||
 					     rxq->err_state)) {
+					/* We should try to track out-pf-order WQE */
+					if (widx != NULL)
+						*widx = rte_be_to_cpu_16(cqe->wqe_counter);
 					ret = mlx5_rx_err_handle(rxq, 0, 1, skip_cnt);
 					if (ret == MLX5_CQE_STATUS_HW_OWN)
 						return MLX5_ERROR_CQE_MASK;
@@ -737,6 +827,10 @@ mlx5_rx_poll_len(struct mlx5_rxq_data *rxq, volatile struct mlx5_cqe *cqe,
 				*/
 				zip->ca = cq_ci;
 				zip->na = zip->ca + 7;
+				if (widx != NULL) {
+					zip->wqe_idx = rte_be_to_cpu_16(cqe->wqe_counter);
+					*widx = zip->wqe_idx;
+				}
 				/* Compute the next non compressed CQE. */
 				zip->cq_ci = rxq->cq_ci + zip->cqe_cnt;
 				/* Get packet size to return. */
@@ -761,6 +855,8 @@ mlx5_rx_poll_len(struct mlx5_rxq_data *rxq, volatile struct mlx5_cqe *cqe,
 			} else {
 				++rxq->cq_ci;
 				len = rte_be_to_cpu_32(cqe->byte_cnt);
+				if (widx != NULL)
+					*widx = rte_be_to_cpu_16(cqe->wqe_counter);
 				if (rxq->cqe_comp_layout) {
 					volatile struct mlx5_cqe *next;
 
@@ -976,7 +1072,8 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 		}
 		if (!pkt) {
 			cqe = &(*rxq->cqes)[rxq->cq_ci & cqe_mask];
-			len = mlx5_rx_poll_len(rxq, cqe, cqe_n, cqe_mask, &mcqe, &skip_cnt, false);
+			len = mlx5_rx_poll_len(rxq, cqe, cqe_n, cqe_mask,
+					       &mcqe, &skip_cnt, false, NULL);
 			if (unlikely(len & MLX5_ERROR_CQE_MASK)) {
 				/* We drop packets with non-critical errors */
 				rte_mbuf_raw_free(rep);
@@ -1062,6 +1159,181 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 	return i;
 }
 
+/**
+ * DPDK callback for RX with Out-of-Order completions support.
+ *
+ * @param dpdk_rxq
+ *   Generic pointer to RX queue structure.
+ * @param[out] pkts
+ *   Array to store received packets.
+ * @param pkts_n
+ *   Maximum number of packets in array.
+ *
+ * @return
+ *   Number of packets successfully received (<= pkts_n).
+ */
+uint16_t
+mlx5_rx_burst_out_of_order(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
+{
+	struct mlx5_rxq_data *rxq = dpdk_rxq;
+	const uint32_t wqe_n = 1 << rxq->elts_n;
+	const uint32_t wqe_mask = wqe_n - 1;
+	const uint32_t cqe_n = 1 << rxq->cqe_n;
+	const uint32_t cqe_mask = cqe_n - 1;
+	const unsigned int sges_n = rxq->sges_n;
+	const uint32_t pkt_mask = wqe_mask >> sges_n;
+	struct rte_mbuf *pkt = NULL;
+	struct rte_mbuf *seg = NULL;
+	volatile struct mlx5_cqe *cqe =
+		&(*rxq->cqes)[rxq->cq_ci & cqe_mask];
+	unsigned int i = 0;
+	int len = 0; /* keep its value across iterations. */
+	const uint32_t rq_ci = rxq->rq_ci;
+	uint32_t idx = 0;
+
+	do {
+		volatile struct mlx5_wqe_data_seg *wqe;
+		struct rte_mbuf *rep = NULL;
+		volatile struct mlx5_mini_cqe8 *mcqe = NULL;
+		uint32_t delta;
+		uint16_t skip_cnt;
+
+		if (!pkt) {
+			cqe = &(*rxq->cqes)[rxq->cq_ci & cqe_mask];
+			rte_prefetch0(cqe);
+			/* Allocate from the first packet mbuf pool */
+			rep = (*rxq->elts)[0];
+			/* We must allocate before CQE consuming to allow retry */
+			rep = rte_mbuf_raw_alloc(rep->pool);
+			if (unlikely(rep == NULL)) {
+				++rxq->stats.rx_nombuf;
+				break;
+			}
+			len = mlx5_rx_poll_len(rxq, cqe, cqe_n, cqe_mask,
+					       &mcqe, &skip_cnt, false, &idx);
+			if (unlikely(len == MLX5_CRITICAL_ERROR_CQE_RET)) {
+				rte_mbuf_raw_free(rep);
+				mlx5_rq_win_reset(rxq);
+				break;
+			}
+			if (len == 0) {
+				rte_mbuf_raw_free(rep);
+				break;
+			}
+			idx &= pkt_mask;
+			delta = (idx - rxq->rq_ci) & pkt_mask;
+			MLX5_ASSERT(delta < ((rxq->rq_win_idx_mask + 1) * MLX5_WINOOO_BITS));
+			if (likely(!mlx5_rq_win_test(rxq))) {
+				/* No out of order completions in sliding window */
+				if (likely(delta == 0))
+					rxq->rq_ci++;
+				else
+					mlx5_rq_win_update(rxq, delta);
+			} else {
+				/* We have out of order completions */
+				rxq->rq_ci += mlx5_rq_win_advance(rxq, delta);
+			}
+			if (rxq->zip.ai == 0)
+				rxq->rq_ci_ooo = rxq->rq_ci;
+			idx <<= sges_n;
+			/* We drop packets with non-critical errors */
+			if (unlikely(len & MLX5_ERROR_CQE_MASK)) {
+				rte_mbuf_raw_free(rep);
+				continue;
+			}
+		}
+		wqe = &((volatile struct mlx5_wqe_data_seg *)rxq->wqes)[idx];
+		if (unlikely(pkt))
+			NEXT(seg) = (*rxq->elts)[idx];
+		seg = (*rxq->elts)[idx];
+		rte_prefetch0(seg);
+		rte_prefetch0(wqe);
+		/* Allocate the buf from the same pool. */
+		if (unlikely(rep == NULL)) {
+			rep = rte_mbuf_raw_alloc(seg->pool);
+			if (unlikely(rep == NULL)) {
+				++rxq->stats.rx_nombuf;
+				if (!pkt) {
+					/*
+					 * no buffers before we even started,
+					 * bail out silently.
+					 */
+					break;
+				}
+				while (pkt != seg) {
+					MLX5_ASSERT(pkt != (*rxq->elts)[idx]);
+					rep = NEXT(pkt);
+					NEXT(pkt) = NULL;
+					NB_SEGS(pkt) = 1;
+					rte_mbuf_raw_free(pkt);
+					pkt = rep;
+				}
+				break;
+			}
+		}
+		if (!pkt) {
+			pkt = seg;
+			MLX5_ASSERT(len >= (rxq->crc_present << 2));
+			pkt->ol_flags &= RTE_MBUF_F_EXTERNAL;
+			if (rxq->cqe_comp_layout && mcqe)
+				cqe = &rxq->title_cqe;
+			rxq_cq_to_mbuf(rxq, pkt, cqe, mcqe);
+			if (rxq->crc_present)
+				len -= RTE_ETHER_CRC_LEN;
+			PKT_LEN(pkt) = len;
+			if (cqe->lro_num_seg > 1) {
+				mlx5_lro_update_hdr
+					(rte_pktmbuf_mtod(pkt, uint8_t *), cqe,
+					 mcqe, rxq, len);
+				pkt->ol_flags |= RTE_MBUF_F_RX_LRO;
+				pkt->tso_segsz = len / cqe->lro_num_seg;
+			}
+		}
+		DATA_LEN(rep) = DATA_LEN(seg);
+		PKT_LEN(rep) = PKT_LEN(seg);
+		SET_DATA_OFF(rep, DATA_OFF(seg));
+		PORT(rep) = PORT(seg);
+		(*rxq->elts)[idx] = rep;
+		/*
+		 * Fill NIC descriptor with the new buffer. The lkey and size
+		 * of the buffers are already known, only the buffer address
+		 * changes.
+		 */
+		wqe->addr = rte_cpu_to_be_64(rte_pktmbuf_mtod(rep, uintptr_t));
+		/* If there's only one MR, no need to replace LKey in WQE. */
+		if (unlikely(mlx5_mr_btree_len(&rxq->mr_ctrl.cache_bh) > 1))
+			wqe->lkey = mlx5_rx_mb2mr(rxq, rep);
+		if (len > DATA_LEN(seg)) {
+			len -= DATA_LEN(seg);
+			++NB_SEGS(pkt);
+			++idx;
+			idx &= wqe_mask;
+			continue;
+		}
+		DATA_LEN(seg) = len;
+#ifdef MLX5_PMD_SOFT_COUNTERS
+		/* Increment bytes counter. */
+		rxq->stats.ibytes += PKT_LEN(pkt);
+#endif
+		/* Return packet. */
+		*(pkts++) = pkt;
+		pkt = NULL;
+		++i;
+	} while (i < pkts_n);
+	if (unlikely(i == 0 && rq_ci == rxq->rq_ci_ooo))
+		return 0;
+	/* Update the consumer index. */
+	rte_io_wmb();
+	*rxq->cq_db = rte_cpu_to_be_32(rxq->cq_ci);
+	rte_io_wmb();
+	*rxq->rq_db = rte_cpu_to_be_32(rxq->rq_ci_ooo);
+#ifdef MLX5_PMD_SOFT_COUNTERS
+	/* Increment packets counter. */
+	rxq->stats.ipackets += i;
+#endif
+	return i;
+}
+
 /**
  * Update LRO packet TCP header.
  * The HW LRO feature doesn't update the TCP header after coalescing the
@@ -1220,7 +1492,7 @@ mlx5_rx_burst_mprq(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 			buf = (*rxq->mprq_bufs)[rq_ci & wq_mask];
 		}
 		cqe = &(*rxq->cqes)[rxq->cq_ci & cq_mask];
-		ret = mlx5_rx_poll_len(rxq, cqe, cqe_n, cq_mask, &mcqe, &skip_cnt, true);
+		ret = mlx5_rx_poll_len(rxq, cqe, cqe_n, cq_mask, &mcqe, &skip_cnt, true, NULL);
 		if (unlikely(ret & MLX5_ERROR_CQE_MASK)) {
 			if (ret == MLX5_CRITICAL_ERROR_CQE_RET) {
 				rq_ci = rxq->rq_ci;
diff --git a/drivers/net/mlx5/mlx5_rx.h b/drivers/net/mlx5/mlx5_rx.h
index 6380895502..4f3d73e3c4 100644
--- a/drivers/net/mlx5/mlx5_rx.h
+++ b/drivers/net/mlx5/mlx5_rx.h
@@ -22,6 +22,7 @@
 
 /* Support tunnel matching. */
 #define MLX5_FLOW_TUNNEL 10
+#define MLX5_WINOOO_BITS  (sizeof(uint32_t) * CHAR_BIT)
 
 #define RXQ_PORT(rxq_ctrl) LIST_FIRST(&(rxq_ctrl)->owners)->priv
 #define RXQ_DEV(rxq_ctrl) ETH_DEV(RXQ_PORT(rxq_ctrl))
@@ -64,6 +65,7 @@ struct rxq_zip {
 	uint32_t ca; /* Current array index. */
 	uint32_t na; /* Next array index. */
 	uint32_t cq_ci; /* The next CQE. */
+	uint16_t wqe_idx; /* WQE index */
 };
 
 /* Get pointer to the first stride. */
@@ -124,6 +126,7 @@ struct __rte_cache_aligned mlx5_rxq_data {
 	volatile uint32_t *cq_db;
 	uint32_t elts_ci;
 	uint32_t rq_ci;
+	uint32_t rq_ci_ooo;
 	uint16_t consumed_strd; /* Number of consumed strides in WQE. */
 	uint32_t rq_pi;
 	uint32_t cq_ci:24;
@@ -164,6 +167,10 @@ struct __rte_cache_aligned mlx5_rxq_data {
 	uint32_t rxseg_n; /* Number of split segment descriptions. */
 	struct mlx5_eth_rxseg rxseg[MLX5_MAX_RXQ_NSEG];
 	/* Buffer split segment descriptions - sizes, offsets, pools. */
+	uint16_t rq_win_cnt; /* Number of packets in the sliding window data. */
+	uint16_t rq_win_idx_mask; /* Sliding window index wrapping mask. */
+	uint16_t rq_win_idx; /* Index of the first element in sliding window. */
+	uint32_t *rq_win_data; /* Out-of-Order completions sliding window. */
 };
 
 /* RX queue control descriptor. */
@@ -305,7 +312,8 @@ int mlx5_hrxq_modify(struct rte_eth_dev *dev, uint32_t hxrq_idx,
 /* mlx5_rx.c */
 
 uint16_t mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n);
-void mlx5_rxq_initialize(struct mlx5_rxq_data *rxq);
+uint16_t mlx5_rx_burst_out_of_order(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n);
+int mlx5_rxq_initialize(struct mlx5_rxq_data *rxq);
 __rte_noinline int mlx5_rx_err_handle(struct mlx5_rxq_data *rxq, uint8_t vec,
 				      uint16_t err_n, uint16_t *skip_cnt);
 void mlx5_mprq_buf_free(struct mlx5_mprq_buf *buf);
@@ -331,6 +339,7 @@ uint16_t mlx5_rx_burst_vec(void *dpdk_rxq, struct rte_mbuf **pkts,
 			   uint16_t pkts_n);
 uint16_t mlx5_rx_burst_mprq_vec(void *dpdk_rxq, struct rte_mbuf **pkts,
 				uint16_t pkts_n);
+void rxq_sync_cq(struct mlx5_rxq_data *rxq);
 
 static int mlx5_rxq_mprq_enabled(struct mlx5_rxq_data *rxq);
 
@@ -661,6 +670,23 @@ mlx5_mprq_enabled(struct rte_eth_dev *dev)
 	return n == n_ibv;
 }
 
+/**
+ * Check whether Shared RQ is enabled for the device.
+ *
+ * @param dev
+ *   Pointer to Ethernet device.
+ *
+ * @return
+ *   0 if disabled, otherwise enabled.
+ */
+static __rte_always_inline int
+mlx5_shared_rq_enabled(struct rte_eth_dev *dev)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+
+	return !LIST_EMPTY(&priv->sh->shared_rxqs);
+}
+
 /**
  * Check whether given RxQ is external.
  *
diff --git a/drivers/net/mlx5/mlx5_rxq.c b/drivers/net/mlx5/mlx5_rxq.c
index 2e9bcbea4d..77c5848c37 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -421,7 +421,7 @@ mlx5_rxq_releasable(struct rte_eth_dev *dev, uint16_t idx)
 }
 
 /* Fetches and drops all SW-owned and error CQEs to synchronize CQ. */
-static void
+void
 rxq_sync_cq(struct mlx5_rxq_data *rxq)
 {
 	const uint16_t cqe_n = 1 << rxq->cqe_n;
@@ -593,7 +593,13 @@ mlx5_rx_queue_start_primary(struct rte_eth_dev *dev, uint16_t idx)
 		return ret;
 	}
 	/* Reinitialize RQ - set WQEs. */
-	mlx5_rxq_initialize(rxq_data);
+	ret = mlx5_rxq_initialize(rxq_data);
+	if (ret) {
+		DRV_LOG(ERR, "Port %u Rx queue %u RQ initialization failure.",
+			priv->dev_data->port_id, rxq->idx);
+		rte_errno = ENOMEM;
+		return ret;
+	}
 	rxq_data->err_state = MLX5_RXQ_ERR_STATE_NO_ERROR;
 	/* Set actual queue state. */
 	dev->data->rx_queue_state[idx] = RTE_ETH_QUEUE_STATE_STARTED;
@@ -2360,6 +2366,7 @@ mlx5_rxq_release(struct rte_eth_dev *dev, uint16_t idx)
 			if (rxq_ctrl->rxq.shared)
 				LIST_REMOVE(rxq_ctrl, share_entry);
 			LIST_REMOVE(rxq_ctrl, next);
+			mlx5_free(rxq_ctrl->rxq.rq_win_data);
 			mlx5_free(rxq_ctrl);
 		}
 		dev->data->rx_queues[idx] = NULL;
-- 
2.34.1

