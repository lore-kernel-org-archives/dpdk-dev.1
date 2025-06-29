Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE22C7EE39
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 17:08:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7491440697;
	Sun, 29 Jun 2025 19:07:53 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by mails.dpdk.org (Postfix) with ESMTP id 14AC840288
 for <dev@dpdk.org>; Sun, 29 Jun 2025 19:07:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D92ZlMeqQEcLnN5ukLsEN/PjaNNzzvU1KZooX0tAydZXvtwsb7VMQo1+VMDFsMJJmuZd80DIQv+2f5fEWGX3Tbo0LVrV54cVXvO0XFWJTw3GcQ9rjJaBlfcD3j4ytqV1V/RWmc8dHQqS3PxlYpZc80f+4mMUYtbvI5MGQ77ikadz9j70W6e9Fl1E44UWD19qsuYIPRwL4dEJgfDhtSsFtm/RxmxY//2DzNnLZ5HDZhyPFyyuPOEswrcNx/J/u/Pbtjlyy45R75zZmI4GxuNnkSNvxCd8nRikJiU1RNr16763FX7gGr41czlTPprVnnRJ2aobdzLRgZ3n0QDZ5pHalw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWH4QM15U4WqYpkvdj8uuX/zpz25MC9yWOmFMcsEqA0=;
 b=ykgx3FN+SKGp88icgiLZwwQi0eruvuHd7mY9+c4lcx7BM5rxpsPivX2cfOeF02c/GaHZFxIWXYwAxgvghiAMHqRF0HH3/L055KSgEEu7sXyssCP83peBfOs7Gv47mo6K7IMmtBI6N5LaCAPKfjiyHjNYcwpeVSTHlpE/33vyv20sgsv5XA4sASCPikJi+6ASrVv5h6S34ywAS2lAzJJoNKWMchNGRRnOJOCYjOL38iTiNGwM0ZJQH78jeFrz84DRgHwTHi2JcnXd6/VepFev2MMnN1k5uIOd2i9qeLG7lQT0rktj0knV22aEw/PEoA5CzV42aMS5n+mIAB7rROKLHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWH4QM15U4WqYpkvdj8uuX/zpz25MC9yWOmFMcsEqA0=;
 b=mFWgcnfSdNB/CY/QerZPffPiqe4x2ySJu9ONtGm/tPmRxIRsEoeUGN44OoDiChkcuu5OuqLeY/GXl2dE8AeTCN+jAx7C/kNJYJIMekUJfFMAclKDm5EzuZ6ZX/A8ID6tKOgEfswqLVF8dHI6ZmfFn98GXyp/JWzkFMsQliYN9dXx3uRJveEHKGPsEqjw0HH+Swdg9wRWtMMi5oVU2VF+9vdfs0TFGwBxgbz1czroQWzytbaRW69/ealRjTef7XfJXBhxiWvrP7jUiFS/Jne/VjwdacU4uGFQ/wFIg5MdBsr0+Bp6ySdgcWsPJd5pKHdChywCziSJALkRrkRL9ZTSog==
Received: from PH7PR17CA0012.namprd17.prod.outlook.com (2603:10b6:510:324::12)
 by SA1PR12MB8597.namprd12.prod.outlook.com (2603:10b6:806:251::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Sun, 29 Jun
 2025 17:07:44 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::db) by PH7PR17CA0012.outlook.office365.com
 (2603:10b6:510:324::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.27 via Frontend Transport; Sun,
 29 Jun 2025 17:07:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sun, 29 Jun 2025 17:07:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 29 Jun
 2025 10:07:31 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 29 Jun
 2025 10:07:29 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <matan@nvidia.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <dsosnowski@nvidia.com>,
 <suanmingm@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH v4 2/5] net/mlx5: calculate the memory length for all Tx queues
Date: Sun, 29 Jun 2025 20:07:06 +0300
Message-ID: <20250629170709.69960-3-bingz@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|SA1PR12MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: b94f6068-32e8-4989-6f54-08ddb72f7696
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b6iC5VA/e8YrETxz7tPHl//o2GXNRFeYjyahx+YpX5JFq5U4P9iRYi1XVV3C?=
 =?us-ascii?Q?PvtqVyyYrTYNgS4sbErKaiGCIH0NxcZGOkd5hHpEN/8nHlVBcuWGIoN6os0m?=
 =?us-ascii?Q?FBmUHjRdmOUknmPJuO/i+VdUY22Qbt6Is0DeFsqiuv0XwtwW+a2RaBG9u1y6?=
 =?us-ascii?Q?h5esAxL44LxxLLTNEOhSalZyR6RyfdOqYyWipjEDMfKCigwWUfoxg98vwPU9?=
 =?us-ascii?Q?HAfjrePxjSY33QqTLNTMv32g/AK0Rqx27/7PwlHtUDOTj6byBBwHNmLjIRz4?=
 =?us-ascii?Q?EXkvxRq3FB9am5eXkcF+/afaRYNvPPZ+opGRPCIbdPoQ0J1qR44LLPfdfaAq?=
 =?us-ascii?Q?DRp5gLKX4WwptOPOiiojul9NjPssnz5+zo41yUZ3Oj0Tq4xZkqNg19eV4LZx?=
 =?us-ascii?Q?+C6OqbzIN5yTngZLJ0QtnE9xi3tuDrvWm6wrM2vrOfyBNV+Z2Zc5TqDahAkG?=
 =?us-ascii?Q?0ZL/oz3YgMqAYxYmPconMsf+66yox8IfQsjI52cylthXlP6lccb4hxZ3d8Aj?=
 =?us-ascii?Q?WEJSOlhGaxM4sUe/blmtTYXUiTEkmaUvVxsJqkguSL6yfukg/4z7Fy6vw4pg?=
 =?us-ascii?Q?DmKR7mDW9ftuRFYPxTkmjHnEBBAqaf8Rz6mR8dWNAdBlvTcnTd0hx8HmO3QC?=
 =?us-ascii?Q?Rvj50mZJREgwkAIm3NrjCCa9Ov9XCqDNsxGSRlNiNGk0+pyBGSgqvWeypqzH?=
 =?us-ascii?Q?D0wXoNH6M8qrJQ2VMvTEbEcNUIFuo3xGaMc32G2uDVeK580nTyAIKx67Zu7j?=
 =?us-ascii?Q?73ofqEmqQOdTEyvY0qvNQH393eldYT0NqXW3kC7QlZ1ZRNli8kHkY3T4Fyce?=
 =?us-ascii?Q?JVNibvhcuLPOipl1c4rcqIoLzMmPrFVkoI93baneHqd+wADP2HtL8vFiUd6u?=
 =?us-ascii?Q?r+IVw+1XwA+9ErGPRIXcjY2qOYEDF4+WvZnzjnvMKasaj7UxPbVB62ieZ8i7?=
 =?us-ascii?Q?hUNYTDvuGbIVyMGHhYwA1f8IByI4rqUIXIL8yB9ONdcHTMfEAiidWAGzUXnE?=
 =?us-ascii?Q?h17fZFE7haA4Qon8sJA9qFPqnW2iu74QkxtWoDcKf/OgH3HTDUETbUpUP8xb?=
 =?us-ascii?Q?5axC2xwXcFyVau4qfm0FP6255Mk9pPo1tYXkkTsDhq4SB/qNMIF4J7un6rnN?=
 =?us-ascii?Q?EVwSnPxul0ln9rDk1Jm0rGJPEnvPuWORDD4xjNbJO/9ybiCvWkRX8NeyHY1P?=
 =?us-ascii?Q?DdkFCi0rm0evdOy7DHQNcZIOtKLiRpczW4yvde3aZH0lnQq02i/v/mWYzZcT?=
 =?us-ascii?Q?INbVhjEIxTyYFSCkG/DlKrf02d78KYQI7eX0TmfW/wMxvHTOS2CahKb8kLtC?=
 =?us-ascii?Q?/mpqPau3ahFXGFU802tyyo0f/IRB/bc2f8S+omp5dMfOTKWPFwyrqFvqTemY?=
 =?us-ascii?Q?3208wsdUa3qyrc+xIO0i53qZdsqKUbFQEpNKZwHzpH7g+NRalEr6Nt1h35r5?=
 =?us-ascii?Q?TdfYCWPihA8JdyxIhIat8RkHofJpvwG+NIPCQpC9XjnKV29F+jncxV0bkmrs?=
 =?us-ascii?Q?6/F6kOCCmAEqgq1HBCyaT5AGVqxuzWebR3nE?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 17:07:43.6179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b94f6068-32e8-4989-6f54-08ddb72f7696
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8597
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

