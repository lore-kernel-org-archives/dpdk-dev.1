Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E8BC83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 04:00:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 020FF4021E;
	Wed,  9 Jul 2025 06:00:53 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by mails.dpdk.org (Postfix) with ESMTP id 8F2504013F
 for <dev@dpdk.org>; Wed,  9 Jul 2025 06:00:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpCtcZRZwrHmBzQS2n5dgS372K+6GQWpIN2TJQXZqc27TR74yjQYbzWVH9OzwxWL2LvYwBvIPZo0Iw/apjQLHiSJiP8i793eV3kCj5IPgaX29VHWOnrG5iQq6RVOmrs7xSLF1sUPFR0+oc/Ruhr2Itnqg+1wAnlAkEhwYtjLcrhoXoMBF0xVVt5foOo3tSTrDORLCTRUoB7dAQEwZSiUkaMpIxsKRuingF3oM/ga98Gk27zs2sHDoEulm6U112QYJFbdh4mPtYpek5cxqAG/K5lpVklOeNSUruYfD5Khl8qfZLQmNX0hNiHtsz5XpdfTXHStfs8nrTz5Uj4G+4aARw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2FtiJx8EXHPR/zr/cTUaJ9p5JsxIByblYEJH1klfuU=;
 b=IqTfG0rT4pK/exw2MmVIxjY/+Co5q6FSnt1RF64xnrurnRMAJi83G39sHqyk4IY90hj58wEFa+1nXPS06rqWYO9DD2h+m3UN+vsEtPxU94JK0XGGbOYUd/JrG4J6g9eXPYEUsR3g3w7SLdS0TR+KO2FPNyEDv1qeHFSB0EODwPBrto8mDup2YZHQOytI0K7hSXYb+QZPBpHy62HGh01ImgAx6MYNOYUcdYtx9iZAl6B97nDg1ODpLPMmIboBRe/lQ+gWuuRK7bCu9YOFMQ4FBNNiYNw7JZ74plflmhj7hPCBJB8Y9+iNL6IR/8VTUff25GF7lfbP97KsgSmmemSiJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2FtiJx8EXHPR/zr/cTUaJ9p5JsxIByblYEJH1klfuU=;
 b=fEbkQm/kTbQtTXFKT/nPB5xjiOVofMI6IwzMyZtVuUTqOofTjCe/Zz4p5mIzwefXuCPKZtYJxLGYI1QPeRhpPv3VmJgSgTa6HiQEg9mJRnZkA3fkpyYVDokxVeWYm334VeDep8CURg8HWNnBrN2Vwq+uz5aUjf4wflIU2IEb+ge9PDWa809OMoNVmwF3UaiYumBW32JKe9V2tkTgOHFEBR6bmtVvLzhtmglWF/C54EpH/D0kEVhE87aFOSHReUDIeeOoYIIqaMTqnRC0U+sKu9gcPL0UZ3fwcxWTFiCQnHVCfTCZ2mmw3sTFnd23UV01for4RMmSZi205pWeSxqCug==
Received: from BN9PR03CA0272.namprd03.prod.outlook.com (2603:10b6:408:f5::7)
 by CH1PPF351A22FF6.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Wed, 9 Jul
 2025 04:00:43 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::85) by BN9PR03CA0272.outlook.office365.com
 (2603:10b6:408:f5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.26 via Frontend Transport; Wed,
 9 Jul 2025 04:00:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20 via Frontend Transport; Wed, 9 Jul 2025 04:00:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Jul 2025
 21:00:19 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 8 Jul
 2025 21:00:15 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>
CC: <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>
Subject: [PATCH] net/mlx5: fix the queue length checking
Date: Wed, 9 Jul 2025 07:00:00 +0300
Message-ID: <20250709040000.112338-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|CH1PPF351A22FF6:EE_
X-MS-Office365-Filtering-Correlation-Id: 73c0f37f-7012-4576-c063-08ddbe9d2ccc
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5eG3G+rmLXMzkoODuIvmQSfNgsTQuNyimX/4gAseAEwjNle5Kh28IHG6SjNP?=
 =?us-ascii?Q?npfdyVWXDy73/MElKH55fVewbpOhlFZLXrdzKJkew+yq9tfOE2Udv/nQe8Z8?=
 =?us-ascii?Q?s3wBYWS/MApBHDDMSbt73zCMu/MPe/6EdwQxXf6v70iTBIfh2s8N/c/Q/i3m?=
 =?us-ascii?Q?CutBEt6vGodKZS3Y+Jw6T7r7RKzPForpN/KZkohC/2PWloDdQDVebuhXAgye?=
 =?us-ascii?Q?8w6x5c6j7FYP3tvUv74FZTzdDQWBLzt4mcKtejo1g272XY8G9/gJG/em7fcF?=
 =?us-ascii?Q?QE9ktb5p3mnpdhA8e8OVzxtjgjmh9oVq+yiJE7VfZtt5z/qxNYOyvkuSnfAV?=
 =?us-ascii?Q?ofXXmG7YMnd4CUopZiBSlZWohxdLqa0mUSxtuB2DWvlsiKKfECuRpfpr2wqF?=
 =?us-ascii?Q?v12L1c4kcHPo8RvgAzVVydJ6uavMu+rgPnp7aLD01HEjf/vLZJZlmFaBaSbq?=
 =?us-ascii?Q?VZPA42nDoy/6mM3bttR063om3kygBvp97+yz8qaiutjDarXr4+bpAOLCM3qw?=
 =?us-ascii?Q?SnPEuoPlm1PhSQT31NnCIuqSCEYP5Wz+4OJNZ1i78ItSUsyziJwqCkxKWaFr?=
 =?us-ascii?Q?U6+y9l/FveQ7Tae5nWvTYrqzMe/iJoYqFr3O542o+iGEA/4pqerl0B7s5bZ6?=
 =?us-ascii?Q?qSoVoGiA+l/12suNfId72Pp3U+U3L3phmCvPaKTGN2idwfemntGvY4qT/TZK?=
 =?us-ascii?Q?LOwTMCUMJJI4ZTBAi5vLh2kdjBqOhnFnRBFtJ686ejDpQx0xsyR7GEC1i8H5?=
 =?us-ascii?Q?QLtNe16NW9KwhQuH+fVxjo3uVaVQZ/uf5CnT3j/WZL8lrjw9z/L1vF39/u2f?=
 =?us-ascii?Q?NZF3vg6IM8zckoDYzFLItHsaq4yg8rqIWrdRYebtXKvJwI85Cx5Y2K3K4FqE?=
 =?us-ascii?Q?7OZpIW9Le2GSndgojYJm55Pef5fiSTRqwaAzptFo/x3uoMy5XCBtQooMvL4t?=
 =?us-ascii?Q?Cdu1xgy3TWPJlEqpMPw1CTuLv0Q9cxY9uQLxu5fEwCpkbM5lUS5Nwcs+tN9O?=
 =?us-ascii?Q?3XWC6Yu4nIVOaQ/SuS+su8QCcllsqjZIP6rJhdE48riRCrzEeHu9QzSHxvR3?=
 =?us-ascii?Q?TxatTclIwhWXJcyqNG2FpL/6lH+Wf5QCmxzUjoPS7255fqz0Ebv9WZ979q3r?=
 =?us-ascii?Q?T2eiLXcYkgIgi6/29PicO8fxCZy8PZOH3mYydbgFln+KfD6eDw8xNPIfZw1Y?=
 =?us-ascii?Q?9BbKwaOeKU0uXGojQYQeMZCeFgmqE3Ry8sCQOc/kRMVx7H6aWxZCyTnVd329?=
 =?us-ascii?Q?rkjpN9XjrAMZOW8bqcPdT0QEa8KtOhNNXkcJZ6hMfeYL56/tCudmCMC2gzk7?=
 =?us-ascii?Q?q1/YcdT7mappYQs/26rpptu7fqw4/1/x0ZXTr30GtSr3MGfnpjI0Fheoj5OZ?=
 =?us-ascii?Q?mj9rDi6N2MvlSUwcg6/4ue84O1sE56UruykWuFw5QEIprxxyZ6DaMyDMY5s9?=
 =?us-ascii?Q?S4sO990uL3zY1FVwey7Jv1lMH5YxpZ0iVItkYxNTy85HqJkczZFA+Le9VDCM?=
 =?us-ascii?Q?zez7Et63xMrOGuJIDTukHJ5m63Wxw4ACH58u?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 04:00:42.5436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c0f37f-7012-4576-c063-08ddbe9d2ccc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF351A22FF6
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

In the new consecutive memory mode of Tx queues allocation, the
needed WQ length is calculated via txq_calc_wqebb_cnt(). This
function is used both in Verbs and Devx modes, but in the Devx queue
creation, the actual length is re-calculated / adjusted for the Devx
API. The queue parameters 'max_inline_data' and 'inlen_send' are used
separately for the length calculation for different modes and the
counts calculated are different as a result.

So passing the mode as a bool input to adjust the calculation in
different modes will solve the mismatch. In the meanwhile, since the
memory and MR are allocated successfully before creating a SQ / CQ.
So the error is not critical and a warning message is enough, the
saved length can be used to create the queue.

Fixes: d94177339289 ("net/mlx5: use consecutive memory for Tx queue creation")

Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/common/mlx5/mlx5_common_devx.c | 23 +++++++++++-------
 drivers/net/mlx5/mlx5_txq.c            | 33 +++++++++++++++++++-------
 2 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_common_devx.c b/drivers/common/mlx5/mlx5_common_devx.c
index e237558ec2..18a53769c9 100644
--- a/drivers/common/mlx5/mlx5_common_devx.c
+++ b/drivers/common/mlx5/mlx5_common_devx.c
@@ -96,6 +96,7 @@ mlx5_devx_cq_create(void *ctx, struct mlx5_devx_cq *cq_obj, uint16_t log_desc_n,
 	uint32_t num_of_cqes = RTE_BIT32(log_desc_n);
 	int ret;
 	uint32_t umem_offset, umem_id;
+	uint16_t act_log_size = log_desc_n;
 
 	if (page_size == (size_t)-1 || alignment == (size_t)-1) {
 		DRV_LOG(ERR, "Failed to get page_size.");
@@ -133,15 +134,18 @@ mlx5_devx_cq_create(void *ctx, struct mlx5_devx_cq *cq_obj, uint16_t log_desc_n,
 		umem_id = mlx5_os_get_umem_id(umem_obj);
 	} else {
 		if (umem_size != attr->q_len) {
-			DRV_LOG(ERR, "Mismatch between saved length and calc length of CQ %u-%u",
+			DRV_LOG(ERR, "Mismatch between saved length and calc length"
+				" of CQ %u-%u, using saved length.",
 				umem_size, attr->q_len);
-			rte_errno = EINVAL;
-			return -rte_errno;
+			/* saved length is a power of 2. */
+			act_log_size =
+				(uint16_t)rte_log2_u32(attr->q_len / sizeof(struct mlx5_cqe));
 		}
 		umem_buf = attr->umem;
 		umem_offset = attr->q_off;
 		umem_dbrec = attr->db_off;
 		umem_id = mlx5_os_get_umem_id(attr->umem_obj);
+
 	}
 	/* Fill attributes for CQ object creation. */
 	attr->q_umem_valid = 1;
@@ -151,7 +155,7 @@ mlx5_devx_cq_create(void *ctx, struct mlx5_devx_cq *cq_obj, uint16_t log_desc_n,
 	attr->db_umem_id = umem_id;
 	attr->db_umem_offset = umem_dbrec;
 	attr->eqn = eqn;
-	attr->log_cq_size = log_desc_n;
+	attr->log_cq_size = act_log_size;
 	attr->log_page_size = rte_log2_u32(page_size);
 	/* Create completion queue object with DevX. */
 	cq = mlx5_devx_cmd_create_cq(ctx, attr);
@@ -251,6 +255,7 @@ mlx5_devx_sq_create(void *ctx, struct mlx5_devx_sq *sq_obj, uint16_t log_wqbb_n,
 	uint32_t num_of_wqbbs = RTE_BIT32(log_wqbb_n);
 	int ret;
 	uint32_t umem_offset, umem_id;
+	uint16_t act_log_size = log_wqbb_n;
 
 	if (alignment == (size_t)-1) {
 		DRV_LOG(ERR, "Failed to get WQE buf alignment.");
@@ -281,15 +286,17 @@ mlx5_devx_sq_create(void *ctx, struct mlx5_devx_sq *sq_obj, uint16_t log_wqbb_n,
 		umem_id = mlx5_os_get_umem_id(umem_obj);
 	} else {
 		if (umem_size != attr->q_len) {
-			DRV_LOG(ERR, "Mismatch between saved length and calc length of WQ %u-%u",
+			DRV_LOG(WARNING, "Mismatch between saved length and calc length"
+				" of WQ %u-%u, using saved length.",
 				umem_size, attr->q_len);
-			rte_errno = EINVAL;
-			return -rte_errno;
+			/* saved length is a power of 2. */
+			act_log_size = (uint16_t)rte_log2_u32(attr->q_len / MLX5_WQE_SIZE);
 		}
 		umem_buf = attr->umem;
 		umem_offset = attr->q_off;
 		umem_dbrec = attr->db_off;
 		umem_id = mlx5_os_get_umem_id(attr->umem_obj);
+
 	}
 	/* Fill attributes for SQ object creation. */
 	attr->wq_attr.wq_type = MLX5_WQ_TYPE_CYCLIC;
@@ -300,7 +307,7 @@ mlx5_devx_sq_create(void *ctx, struct mlx5_devx_sq *sq_obj, uint16_t log_wqbb_n,
 	attr->wq_attr.dbr_umem_id = umem_id;
 	attr->wq_attr.dbr_addr = umem_dbrec;
 	attr->wq_attr.log_wq_stride = rte_log2_u32(MLX5_WQE_SIZE);
-	attr->wq_attr.log_wq_sz = log_wqbb_n;
+	attr->wq_attr.log_wq_sz = act_log_size;
 	attr->wq_attr.log_wq_pg_sz = MLX5_LOG_PAGE_SIZE;
 	/* Create send queue object with DevX. */
 	sq = mlx5_devx_cmd_create_sq(ctx, attr);
diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index 0981091acd..b090d8274d 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -695,22 +695,39 @@ mlx5_txq_obj_verify(struct rte_eth_dev *dev)
  *
  * @param txq_ctrl
  *   Pointer to Tx queue control structure.
+ * @param devx
+ *   If the calculation is used for Devx queue.
  *
  * @return
  *   The number of WQEBB.
  */
 static int
-txq_calc_wqebb_cnt(struct mlx5_txq_ctrl *txq_ctrl)
+txq_calc_wqebb_cnt(struct mlx5_txq_ctrl *txq_ctrl, bool devx)
 {
 	unsigned int wqe_size;
 	const unsigned int desc = 1 << txq_ctrl->txq.elts_n;
 
-	wqe_size = MLX5_WQE_CSEG_SIZE +
-		   MLX5_WQE_ESEG_SIZE +
-		   MLX5_WSEG_SIZE -
-		   MLX5_ESEG_MIN_INLINE_SIZE +
-		   txq_ctrl->max_inline_data;
-	wqe_size = RTE_MAX(wqe_size, MLX5_WQE_SIZE);
+	if (devx) {
+		wqe_size = txq_ctrl->txq.tso_en ?
+			   RTE_ALIGN(txq_ctrl->max_tso_header, MLX5_WSEG_SIZE) : 0;
+		wqe_size += MLX5_WQE_CSEG_SIZE +
+			    MLX5_WQE_ESEG_SIZE +
+			    MLX5_WQE_DSEG_SIZE;
+		if (txq_ctrl->txq.inlen_send)
+			wqe_size = RTE_MAX(wqe_size, sizeof(struct mlx5_wqe_cseg) +
+						     sizeof(struct mlx5_wqe_eseg) +
+						     RTE_ALIGN(txq_ctrl->txq.inlen_send +
+							       sizeof(uint32_t),
+							       MLX5_WSEG_SIZE));
+		wqe_size = RTE_ALIGN(wqe_size, MLX5_WQE_SIZE);
+	} else {
+		wqe_size = MLX5_WQE_CSEG_SIZE +
+			   MLX5_WQE_ESEG_SIZE +
+			   MLX5_WSEG_SIZE -
+			   MLX5_ESEG_MIN_INLINE_SIZE +
+			   txq_ctrl->max_inline_data;
+		wqe_size = RTE_MAX(wqe_size, MLX5_WQE_SIZE);
+	}
 	return rte_align32pow2(wqe_size * desc) / MLX5_WQE_SIZE;
 }
 
@@ -1154,7 +1171,7 @@ mlx5_txq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 	tmpl->txq.idx = idx;
 	txq_set_params(tmpl);
 	txq_adjust_params(tmpl);
-	wqebb_cnt = txq_calc_wqebb_cnt(tmpl);
+	wqebb_cnt = txq_calc_wqebb_cnt(tmpl, !!mlx5_devx_obj_ops_en(priv->sh));
 	max_wqe = mlx5_dev_get_max_wq_size(priv->sh);
 	if (wqebb_cnt > max_wqe) {
 		DRV_LOG(ERR,
-- 
2.34.1

