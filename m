Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07255C77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 16:38:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7074C4060B;
	Fri, 27 Jun 2025 18:38:16 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by mails.dpdk.org (Postfix) with ESMTP id 4AC30400D5
 for <dev@dpdk.org>; Fri, 27 Jun 2025 18:38:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VsdOXSkzBowHEhhdwGJJ4IOIAu87e3Gtmb169IRK7X8oZP3781knMoR2fIOwMXlJdVXZMuHbn8Ywqxkl95+3tyxA7yrXzR0UYfJ4dT7Uau4zgEC5VoDrBXbKkemFKd561n/vHdvK2jxac3FQDhq0BPDahiw/hPYJApKDcvxXjDPBBdWOpq013ElY4JYf9bqqT/1IUHBvpZe2ldpxYsC8bDYjp6Yhgso0fZwcL6fkksTAZtvpfKbhTaVabr5/9XUBJRsGhfl1U1++Jxch653cvNCqspBkjgMbASBYpLiVeMycvSdDjH2tboFmkM7TfO/TQ0E1DT3QrlxavDCSdsXEjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LI2MutRGNFO2gInqnMe3M7gDX5PuFbhHgRK794zxtA=;
 b=vlm6PUnsjMzG70MoF64v6X9Yps8zaJOQRbWdVffLpCXmJGKaYUYdnlPjV5B2RDwgY9NY+hzD251mZWhsLuk394/Eh8bdtj2wWf/KY+kqliJTRhfcQMBHhWpV35qCf5G/LFWogdZx+f7QOX01+/FgcJ+axsYR/11xTCpIiYeG9H/vvk/T8zTPmpZHXvny+NkUCMRlUHRrf8XPaUlGOYkSm2qWMYOjvdppsjfbNalxrALFvHEJaNzbo+lb01l5rz/Rtym6lPjt9eHLYomYBBslJTN3sorp9dxey75nEwKEP67CqZEns17Ko9Jig0t+CMjFUiAf5fc/WqNs1+c6q5D6ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LI2MutRGNFO2gInqnMe3M7gDX5PuFbhHgRK794zxtA=;
 b=SWP5+QVaZxBK1+2aulmuTmWNHDSv5r+jjAl3fBb6nJDW63MV/3XYqhncnU5ZmhXIQNnFmm1gSq1BgaSOoEUOksnQkS6sPBwQZ8C0TNPZR7CP+w5Lkmm1MXuyoiPiyTYzK394wuJlThHFPVL1ajN2DALUUoE6Q/6vjhHDxA4kYQWM23rjuxopdTEnqLa4ay6HUpMRT5lJSRd/x5r8qoEmb7oYHStCYuZbIa8Peym9+EBPwSSKRy1J3hhjNDhP0KDjw1gutD3k5C22m6jpUzvwWE3PqMJJGXVTIrxmMzBoDfoq4jx3o31Dy2eTuHfCZiCuzVMdpLrlJJwzg/T6i+Tufw==
Received: from MN2PR16CA0044.namprd16.prod.outlook.com (2603:10b6:208:234::13)
 by DM4PR12MB7528.namprd12.prod.outlook.com (2603:10b6:8:110::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Fri, 27 Jun
 2025 16:38:11 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::b1) by MN2PR16CA0044.outlook.office365.com
 (2603:10b6:208:234::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Fri,
 27 Jun 2025 16:38:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 16:38:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 27 Jun
 2025 09:37:58 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 27 Jun
 2025 09:37:56 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <matan@nvidia.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <dsosnowski@nvidia.com>,
 <suanmingm@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH v3 2/5] net/mlx5: calculate the memory length for all Tx queues
Date: Fri, 27 Jun 2025 19:37:26 +0300
Message-ID: <20250627163729.50460-3-bingz@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|DM4PR12MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: 040f7c76-df7a-4fcd-b949-08ddb5990159
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Brm0VExxVarqZCi3RESyOo2lSRpZhngeR9ETj2KLxSa6vD/9xR6U6weJOAfG?=
 =?us-ascii?Q?rCYGjbv4aXYft/1XvpGO6X7BVXSc7HdM+yiYLNAFtUccvwTV5G32AMmEvOwU?=
 =?us-ascii?Q?iarj9RzB4LAVFZE+qUly451UGCde+lljv6xZUai3UO8NHSfZdlSwz4COrp90?=
 =?us-ascii?Q?D0d5Lwa+ofLYhSwbjwbAbqdP/1Tem8z5jYIY+O6bHsCHCqEDegzznGlVAHLO?=
 =?us-ascii?Q?nP0NL3pm9xgNMnVZuvMw9b5hfZ5UTdVBAM82MBsdk25bvS4oBvF1gs1TFmHs?=
 =?us-ascii?Q?nQmgb/oXZxZXC/UQMbDPxcG373qdYKQdLsoae/oDtfCn5F/245Fw//Y0fDeA?=
 =?us-ascii?Q?GUXWc8Vt1y0FBig+2kSRtr3585gm22iDr5zYLrgBLXXLwrfSTXTAlrQnzd+0?=
 =?us-ascii?Q?DExedV787YI+REj4Nk2yHt9IOaN/+38TodkZ71O3FgQkDJJOTaE+RJdLjHtf?=
 =?us-ascii?Q?Xl7ALPgCExRHjwEuwWRLhTA8KHsJ6CqvThrT3gZ5/a/tdyGrLuZx8TJOY0Xr?=
 =?us-ascii?Q?Y5LWxvAhrBaFhaPpaIVSMM81fsc+U2cpxzS2JKkVt8UAZspZ4rLaPNZz9Lbr?=
 =?us-ascii?Q?ksK97+ku/X2pHjsysZzYRC5QAldkCxNaMIQGGnKrP/L9P7VVAeChl42eGSos?=
 =?us-ascii?Q?A36J50yRtKeU59h/7TaeEHpHyFVnj3sTdqc+3bHa6J09CDl1T6jbWybNP9pF?=
 =?us-ascii?Q?BHTuP3oQAgZ4wuDU8SOtnVgiJQK5ZGyw/3skuXWc/2E1gamXOA5rAODphiGP?=
 =?us-ascii?Q?/p8cytCrSoaYfUSgAVsNsXzm9wnXS5Tj/7Y3+1Hg0uPPW/OuKdQ81PLpmpLh?=
 =?us-ascii?Q?aMf0Oim109LKha4ws8CvXBxsEd21v8EPtEXkUznJxJnH0xKIGC/B/TrtqxCl?=
 =?us-ascii?Q?hMcHYCo/L24ShmNVS+flX1bkD6enyVuqHEZ4hbbsU15MREUJqbRCW91kGX2b?=
 =?us-ascii?Q?EoPqLOuI5YC6Pk9WsRTSbld4R6W2Lih7kFiP8Okn8dxb7gAdA4Odg4JuGqDd?=
 =?us-ascii?Q?wVc2qZvT+a0TJQF1k6cg3oF/AvJ3MANUpX00egzcYx/W9vByP9vbYkSjmzZP?=
 =?us-ascii?Q?79POl0ElQUECBe8VZ3mtkwL2j1K4j2dhMep3Yh/bZDQiAkrU/SiThUpE+zCx?=
 =?us-ascii?Q?yok9/KTqoySnh24rYfgHYrpeVVu2OIRIttEh01Z5oG56Y42c+VrNdzSFiw3+?=
 =?us-ascii?Q?fpRZ73BQkH6y7re62tngovILmNZSIGPJH9P7NXmfaa8KIlDu9OfyaLDgKund?=
 =?us-ascii?Q?msXKLiV+2ObzNeBIDAxZTDIvdsv9EWWegvpBLtUf5hx3a/oQj3BsFRryeSJR?=
 =?us-ascii?Q?UfuPn8Ev6iuSfoBfBxPVXCOH9+cSjBNrAblPF/r7WEaOdLIdpbKnH69XLI/t?=
 =?us-ascii?Q?1oHKZqtxX+S7JhIFbNZg1y3uahwMU7ihOYIsDzdLo7Hqqas67Ta3N/I7S5tJ?=
 =?us-ascii?Q?B2U3BrO8HFE3tmasxSoM7Avl2hZKQUC7T+X3Fl61kpWpslKhUNjwM0kuiZ3E?=
 =?us-ascii?Q?xyWI65brQ7RaZ/NG3uJg3czTQNqRit8N4Bgv?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 16:38:11.2393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 040f7c76-df7a-4fcd-b949-08ddb5990159
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7528
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
 drivers/net/mlx5/mlx5_txq.c | 69 +++++++++++++++++++++++++++++++++++--
 3 files changed, 73 insertions(+), 2 deletions(-)

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
index 8ee8108497..6ae7d75cd0 100644
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
+	uint32_t num_of_wqbbs = RTE_BIT32(log_wqe_cnt);
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
@@ -1057,6 +1109,8 @@ mlx5_txq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_txq_ctrl *tmpl;
 	uint16_t max_wqe;
+	uint32_t wqebb_cnt, log_desc_n;
+	uint32_t alignment;
 
 	if (socket != (unsigned int)SOCKET_ID_ANY) {
 		tmpl = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO, sizeof(*tmpl) +
@@ -1099,15 +1153,26 @@ mlx5_txq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
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
+		alignment = RTE_BIT32(priv->sh->config.txq_mem_algn);
+		priv->consec_tx_mem.sq_total_size += RTE_ALIGN(tmpl->txq.sq_mem_len, alignment);
+		priv->consec_tx_mem.cq_total_size += RTE_ALIGN(tmpl->txq.cq_mem_len, alignment);
+	}
 	rte_atomic_fetch_add_explicit(&tmpl->refcnt, 1, rte_memory_order_relaxed);
 	tmpl->is_hairpin = false;
 	LIST_INSERT_HEAD(&priv->txqsctrl, tmpl, next);
-- 
2.34.1

