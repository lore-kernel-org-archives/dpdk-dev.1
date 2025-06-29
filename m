Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7E5C7EE30
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 17:23:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C42B04065E;
	Sun, 29 Jun 2025 19:23:42 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by mails.dpdk.org (Postfix) with ESMTP id 94EE440654
 for <dev@dpdk.org>; Sun, 29 Jun 2025 19:23:41 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/hRKnK+RZAl2ugaBlUdGzqYoJSomtx+6LvY6Jn0UcVgY++3goXxqeE2c2hvPZC+ctxgy19VB82MRT11VkxIRtL7hmLCENC9JapV8OGF8hR22FVOBW8wQIB8C9F2fYcxsqfsJWbSZ2LbCFOrNbECFTbj0eox/MiQ2WkjObTmJzn3Z9nQQrukabonVqLRISbR3tn7VLnH5Fux3zRO1dCZWNhmuQAQC3rWjMRH3moi1TjikvH7smTMZW055DZhaQip1vqF3njC2EFGsSuj+/GTCQdoTZq4vnmS12TpboAQjO6/yQVkU8fhJy8yDUQVBSIoQ8m1KtkttPtl1+sy3Ki20g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWH4QM15U4WqYpkvdj8uuX/zpz25MC9yWOmFMcsEqA0=;
 b=Pw0XiJb5/K7kDpD122KpLuGaZ0eT4RENm7Tr3a8F2aGkJ7dTiOaFwphfRO8ajM7a2DJlgwA/QeiFu/vtxHbE+LEpDgBTeRJeuXHVcQ2+yf7FNh76SiecPLZu0ZKsgJHGZh9KKCAGMZNgSUOnAhSHeAOZ1KqBO+pPX7vBg2H6EVhv3wkosa+ftVIifW92c3pLv1XS+pkEpVqaA9dNDbCGP+UrQ7x08eQHl6RrcdjEqoGNIYf+6j1leDqVfTynSiKEfYsOoRVt9mB0YmlIn8pWByNlAyW6+q88RyTPo3iFhvLXmCqSiFEoCTlx6G6qRkbQzT4Chmf7NtxOXJZYtPIYCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWH4QM15U4WqYpkvdj8uuX/zpz25MC9yWOmFMcsEqA0=;
 b=VVIQ8ehFIdNtYczim4Z2IRbuMvv47QSlrf/T5zkQ6/wzvqNhIuKpV0QbIl9JwdPc5jQobkA7zflsNO3Et2d8oI3cD21DxfgrQpg8Jc4M0Ir3vcGtOaV3TVPBZZILZnScY6hnfwDijzYvmM27SppjjOhEuF0m+ep6RxgtySkpUOtyeJgDxB7u8CDRG1xTu1cofcuvjwhdcbgyiv93G7QeikMwUelrPcx2rX+7bXvVcDKHlinGb4/6ygMbqCJQlrJlhA+m/9BftKswLQGfcQaUjJeAd73RVWWxEEp4UhZghVBt5Ne6HUhpj1GCIrp5TFQE+Jauj67+uDFw+u0DyANjdg==
Received: from BL0PR02CA0143.namprd02.prod.outlook.com (2603:10b6:208:35::48)
 by SN7PR12MB7225.namprd12.prod.outlook.com (2603:10b6:806:2a8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Sun, 29 Jun
 2025 17:23:37 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::3b) by BL0PR02CA0143.outlook.office365.com
 (2603:10b6:208:35::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.25 via Frontend Transport; Sun,
 29 Jun 2025 17:23:37 +0000
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
 15.20.8901.15 via Frontend Transport; Sun, 29 Jun 2025 17:23:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 29 Jun
 2025 10:23:25 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 29 Jun
 2025 10:23:22 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <matan@nvidia.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <dsosnowski@nvidia.com>,
 <suanmingm@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH v5 2/5] net/mlx5: calculate the memory length for all Tx queues
Date: Sun, 29 Jun 2025 20:23:00 +0300
Message-ID: <20250629172303.72049-3-bingz@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|SN7PR12MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e6c5e96-5057-4e18-6dff-08ddb731aea7
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L6PORQgg0Dt1k/VQ6X2oAvVvhY6HBkx5ugha7BEaEk5PYQhrUzsNwNFidnRz?=
 =?us-ascii?Q?831hdY0xVSivu6PD4R134fF6JtrUxf7JwlMBvAPsV/az8TndLb7fc0X1lq5L?=
 =?us-ascii?Q?OkgNz1b0AzbgP9KQhj/EdAAJKKxnaOsKdlQD6vapuSp/aeq15oxCAHwih1HD?=
 =?us-ascii?Q?Uj761hvXK/okd0SI0aaTXPTqLEGKOymqtjQtv3AQMsyPkT1hFulfjOq4Evw5?=
 =?us-ascii?Q?wQG6ktdeDq3ljqzgSZ25Ca33h3N5Z60z8A4iQY0IjMpwW0gdcFwPISuW3wpg?=
 =?us-ascii?Q?6T3QuW5/o66f3mH80dzY5HlwPkgwUVt4zByAFJ2oZ8hiUNJD8MU/hWVkF+MP?=
 =?us-ascii?Q?Rq3OVKgTyBfoBXr/iOXoA7sbLXzZkYto8O9/jVbmQm9o1FB8yd2s8bE9qq8U?=
 =?us-ascii?Q?2D84eq/mqOs72qUJOekbuV8ZNeKmkK2Iev2c31kyfM167qtd5E78pKnjrlYa?=
 =?us-ascii?Q?mVcsz/7O1KqMo/KzDVfh3ke/dlibvkWX6tr3T8NlReXy8eOpjFWh+ekRhxk9?=
 =?us-ascii?Q?3mCOR3FfzyQNYkahAWvmXcoCn8zMUJChk+6iJtXnaaw4zyvGK8qIhyiJwqrE?=
 =?us-ascii?Q?ewcrf+KZItWTgV36PU66FhovgJidS7E6D9hl2PiMCDJYnir6DCzgELizxBeW?=
 =?us-ascii?Q?dutZKZcVlKddNjGVWNrGO90qJXwoWOpfzNBmC5CU1NY7Lz3z2XJ4FySRO2NN?=
 =?us-ascii?Q?s3W2+CTEn9bKr1XFpnKROKKZhR9ThWkVR6RriyNHTBHl4LUHLjQQwiUqsr+v?=
 =?us-ascii?Q?u2pY5CsdFIxuvB/EtseIwdsNO/ikc1Igy5G/kyzfgXNJjOgvn8zGE2XpFrVN?=
 =?us-ascii?Q?RsVdZDd5KjbTc8AyT9TEA+Yroco62Af6+FWqbTcwF+ic5uLe+MzRMfXmKr09?=
 =?us-ascii?Q?fH+qPEzzE9PCaFTCBFygnl+7yIKmXdISz5SVBjvqbU6GSYAlPjuRCXxxCI+q?=
 =?us-ascii?Q?LZ+8g1ju1+nS9P+klqFrUf0fN9ra8H1hr72OuRG0JwmJzEmGu6ajcSHk5yS1?=
 =?us-ascii?Q?tMB+3dWn1pyqgsjIOxdcSV+CDohbStJ/vK6fB3rWhq3xGroQkQJ/x8gpmHLg?=
 =?us-ascii?Q?Rvg5qdl9FqtEpf0egucaorxfgWIM5+1B+izeiPxW2y/gUlaG2ocbJOBC2XTM?=
 =?us-ascii?Q?NVCTWZoRcxWwXRTy2VI2Tl+Vati/u3e1ulntASMRVl2ELDDIKMnPr8dJmIQs?=
 =?us-ascii?Q?sMjxl6P3fASzi2IFLyNbniaJHe+NT7ebVE8N3lPtTkcjiePhhru3KUVIacKS?=
 =?us-ascii?Q?GmGgLsRznOGEbsEwRCe4aenBcNRRIsJtubit5appAqBfFLYJks/uSV8DyjWH?=
 =?us-ascii?Q?Hz94J7Xn4cECQ+Obsxn1/zlpBARmLF2j6sBHI1S+23h42Isn1B56fq3LKhhf?=
 =?us-ascii?Q?WlcEzybEf40Iy2vIuuGr0WyB+73XluVsxkSIhs+YoeaTTEp6+wyC5CA5C2rw?=
 =?us-ascii?Q?1tdE7YbyyCpqKYyzGj/mTCXbrsEdX9/grvmue4FS//G7NtV1AH2vPokmmdsz?=
 =?us-ascii?Q?F7M95d2D5EBTD1eX6r+z2sC/0JfVaCTrzB0U?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 17:23:36.6122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6c5e96-5057-4e18-6dff-08ddb731aea7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7225
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

When the alignment is non-zero, it means that the single umem and MR
allocation for all Tx queues will be used.

In this commit, the total length of SQs and associated CQs will be
calculated and saved.

Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5.h     |  4 +++
 drivers/net/mlx5/mlx5_tx.h  |  2 ++
 drivers/net/mlx5/mlx5_txq.c | 67 +++++++++++++++++++++++++++++++++++--
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 6b8d29a2bf..285c9ba396 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -2138,6 +2138,10 @@ struct mlx5_priv {
 	struct mlx5_nta_sample_ctx *nta_sample_ctx;
 #endif
 	struct rte_eth_dev *shared_host; /* Host device for HW steering. */
+	struct {
+		uint32_t sq_total_size;
+		uint32_t cq_total_size;
+	} consec_tx_mem;
 	RTE_ATOMIC(uint16_t) shared_refcnt; /* HW steering host reference counter. */
 };
 
diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h
index 55568c41b1..94f2028513 100644
--- a/drivers/net/mlx5/mlx5_tx.h
+++ b/drivers/net/mlx5/mlx5_tx.h
@@ -149,6 +149,7 @@ struct __rte_cache_aligned mlx5_txq_data {
 	uint16_t inlen_mode; /* Minimal data length to inline. */
 	uint8_t tx_aggr_affinity; /* TxQ affinity configuration. */
 	uint32_t qp_num_8s; /* QP number shifted by 8. */
+	uint32_t sq_mem_len; /* Length of TxQ for WQEs */
 	uint64_t offloads; /* Offloads for Tx Queue. */
 	struct mlx5_mr_ctrl mr_ctrl; /* MR control descriptor. */
 	struct mlx5_wqe *wqes; /* Work queue. */
@@ -167,6 +168,7 @@ struct __rte_cache_aligned mlx5_txq_data {
 	uint64_t ts_mask; /* Timestamp flag dynamic mask. */
 	uint64_t ts_last; /* Last scheduled timestamp. */
 	int32_t ts_offset; /* Timestamp field dynamic offset. */
+	uint32_t cq_mem_len; /* Length of TxQ for CQEs */
 	struct mlx5_dev_ctx_shared *sh; /* Shared context. */
 	struct mlx5_txq_stats stats; /* TX queue counters. */
 	struct mlx5_txq_stats stats_reset; /* stats on last reset. */
diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index 8ee8108497..1948a700f1 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -17,6 +17,7 @@
 #include <bus_pci_driver.h>
 #include <rte_common.h>
 #include <rte_eal_paging.h>
+#include <rte_bitops.h>
 
 #include <mlx5_common.h>
 #include <mlx5_common_mr.h>
@@ -1032,6 +1033,57 @@ txq_adjust_params(struct mlx5_txq_ctrl *txq_ctrl)
 		    !txq_ctrl->txq.inlen_empw);
 }
 
+/*
+ * Calculate WQ memory length for a Tx queue.
+ *
+ * @param log_wqe_cnt
+ *   Logarithm value of WQE numbers.
+ *
+ * @return
+ *   memory length of this WQ.
+ */
+static uint32_t mlx5_txq_wq_mem_length(uint32_t log_wqe_cnt)
+{
+	uint32_t num_of_wqbbs = 1U << log_wqe_cnt;
+	uint32_t umem_size;
+
+	umem_size = MLX5_WQE_SIZE * num_of_wqbbs;
+	return umem_size;
+}
+
+/*
+ * Calculate CQ memory length for a Tx queue.
+ *
+ * @param dev
+ *   Pointer to Ethernet device.
+ * @param txq_ctrl
+ *   Pointer to the TxQ control structure of the CQ.
+ *
+ * @return
+ *   memory length of this CQ.
+ */
+static uint32_t
+mlx5_txq_cq_mem_length(struct rte_eth_dev *dev, struct mlx5_txq_ctrl *txq_ctrl)
+{
+	uint32_t cqe_n, log_desc_n;
+
+	if (__rte_trace_point_fp_is_enabled() &&
+	    txq_ctrl->txq.offloads & RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP)
+		cqe_n = UINT16_MAX / 2 - 1;
+	else
+		cqe_n = (1UL << txq_ctrl->txq.elts_n) / MLX5_TX_COMP_THRESH +
+			1 + MLX5_TX_COMP_THRESH_INLINE_DIV;
+	log_desc_n = log2above(cqe_n);
+	cqe_n = 1UL << log_desc_n;
+	if (cqe_n > UINT16_MAX) {
+		DRV_LOG(ERR, "Port %u Tx queue %u requests to many CQEs %u.",
+			dev->data->port_id, txq_ctrl->txq.idx, cqe_n);
+		rte_errno = EINVAL;
+		return 0;
+	}
+	return sizeof(struct mlx5_cqe) * cqe_n;
+}
+
 /**
  * Create a DPDK Tx queue.
  *
@@ -1057,6 +1109,7 @@ mlx5_txq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_txq_ctrl *tmpl;
 	uint16_t max_wqe;
+	uint32_t wqebb_cnt, log_desc_n;
 
 	if (socket != (unsigned int)SOCKET_ID_ANY) {
 		tmpl = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO, sizeof(*tmpl) +
@@ -1099,15 +1152,25 @@ mlx5_txq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 	tmpl->txq.idx = idx;
 	txq_set_params(tmpl);
 	txq_adjust_params(tmpl);
+	wqebb_cnt = txq_calc_wqebb_cnt(tmpl);
 	max_wqe = mlx5_dev_get_max_wq_size(priv->sh);
-	if (txq_calc_wqebb_cnt(tmpl) > max_wqe) {
+	if (wqebb_cnt > max_wqe) {
 		DRV_LOG(ERR,
 			"port %u Tx WQEBB count (%d) exceeds the limit (%d),"
 			" try smaller queue size",
-			dev->data->port_id, txq_calc_wqebb_cnt(tmpl), max_wqe);
+			dev->data->port_id, wqebb_cnt, max_wqe);
 		rte_errno = ENOMEM;
 		goto error;
 	}
+	if (priv->sh->config.txq_mem_algn != 0) {
+		log_desc_n = log2above(wqebb_cnt);
+		tmpl->txq.sq_mem_len = mlx5_txq_wq_mem_length(log_desc_n);
+		tmpl->txq.cq_mem_len = mlx5_txq_cq_mem_length(dev, tmpl);
+		DRV_LOG(DEBUG, "Port %u TxQ %u WQ length %u, CQ length %u before align.",
+			dev->data->port_id, idx, tmpl->txq.sq_mem_len, tmpl->txq.cq_mem_len);
+		priv->consec_tx_mem.sq_total_size += tmpl->txq.sq_mem_len;
+		priv->consec_tx_mem.cq_total_size += tmpl->txq.cq_mem_len;
+	}
 	rte_atomic_fetch_add_explicit(&tmpl->refcnt, 1, rte_memory_order_relaxed);
 	tmpl->is_hairpin = false;
 	LIST_INSERT_HEAD(&priv->txqsctrl, tmpl, next);
-- 
2.34.1

