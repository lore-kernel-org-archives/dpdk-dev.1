Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8303C7EE30
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 17:08:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4EA7406B8;
	Sun, 29 Jun 2025 19:07:58 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by mails.dpdk.org (Postfix) with ESMTP id 48978406B7
 for <dev@dpdk.org>; Sun, 29 Jun 2025 19:07:56 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9vyxLSQ9DSXFluZfGTLaG+PW7ftPCB13bd2izrwR0TDkzjbn7mfp22LphH0qC+oO5MBmUwhBXuNwWpVFizNsQtQZT9V15zFkScnlmoygk/z6ZK0Xzzif0SP0YAOva1mDLEnrx/mMwETowEGBzxFqR4yw835w3VoPxcyxTk3N7DpBhD3PbsuwTTlPi9vVwY3uGuQ4WokpJ1kT5xkUpemUHT7WO5tV8UXSdV7K19ofcRbJc1bv+8v7UhrV1gI2LtPNoqobAkVfOs+dohCGVwy47tFBhYrA3opi6pv2dsYDA/Ha9sIkcOSdDu766t/op81ef+cXX+5g5gB65GZ2d1IgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQn4ugqjjcfZQTakxnj31+GQ+N3o1fZCaCRUJojBDm8=;
 b=PGbwKj7CdSy7UiwM+/7yS+81JTYrbabpJs+u9+rdpX7yiGV7ajBvOSqpfcpyNfo6gS+MNi68lgJ0fk8A9YRPzZyU2y6bDZS++NXCbI1bWGzJ4AcFd6A68p2f7yMGJ4T//oFL1D71y/zxJLDCTXONyLr6uYI2QhK4F3q1qjpVcQA/7WlyKggyi0C3h4tf+UQITAPURMJKJzAYxJr30SgdIJL6XrC/B0FbqjnNASutRIrIbQovPx1ziDTqq1Gj+7fvPTdJRE1J/TdS1w2MYE2658RwwMfvVE0ojHpV/v1tONUNUtt+Uvm6vmHl2FoyBRG/TSwwOeQCTZX2wyGx4lTHGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQn4ugqjjcfZQTakxnj31+GQ+N3o1fZCaCRUJojBDm8=;
 b=Ci84vluOvkzbDYj6YVLWNYL4Mf2yN5SrX+D4gKXdDBbwXi4seSHvZbjvb195hnfu4vBILipzIr2fe9mHDEGgBnSubbv1cI4WX9ry3mcFLEPgvYOHB0+Lh9Nqb/Utr0nL/44kVXLJaml1Ahc8YR77T+838rwVjIA/hBrmLMa/eJnbab4mFZeFq4Dhe0ooG1ydBnJnrvYdvEel7yB6qtKmeHyX6nB2zT8TVa53L79Os8U0tu8civ4OAMBoDsBhI2dKOZCrLzMTYjLSpV8aXLz3Ow59ouvrYhdbKvjVRfjT30zh8kNRUr4FPSwJan0e52kCzOgtvuHAMkUeWFNVObEoFg==
Received: from PH1PEPF000132FB.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::2c)
 by SA1PR12MB7365.namprd12.prod.outlook.com (2603:10b6:806:2ba::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.32; Sun, 29 Jun
 2025 17:07:52 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2a01:111:f403:f912::) by PH1PEPF000132FB.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.29 via Frontend Transport; Sun,
 29 Jun 2025 17:07:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sun, 29 Jun 2025 17:07:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 29 Jun
 2025 10:07:39 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 29 Jun
 2025 10:07:37 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <matan@nvidia.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <dsosnowski@nvidia.com>,
 <suanmingm@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH v4 5/5] net/mlx5: use consecutive memory for Tx queue creation
Date: Sun, 29 Jun 2025 20:07:09 +0300
Message-ID: <20250629170709.69960-6-bingz@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|SA1PR12MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd4a8f7-04bc-416b-2a08-08ddb72f7ba7
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hgmwyXzdy6dleDTqnWAdEVVYLuTCIdj/CWb6OZ0oYANMCHnNDZhbuUvP4nGx?=
 =?us-ascii?Q?XpgUYsnoebXgbnlyD5yj559lp8j3+spNzlincUbiV4EHW2CWQeLk3hsywP8y?=
 =?us-ascii?Q?HHjPBiS7RYihNrc5zbWC9ZQKIb1f1IJGHkfUwKwSpbUG/cvImQOv5ZM4L3Fx?=
 =?us-ascii?Q?DsRbRy8bvyPFUKSpEs2Amqubz/6siDdYgwtfF7icpVkqvItPOdXFXxSaBc1Z?=
 =?us-ascii?Q?SHm5G7VGT/kVFJChog+CSoBn6QMtbg16qmP/VwD4giv/MN5MsRijDGv9B7Ek?=
 =?us-ascii?Q?VRKGbWUT17dmVsPgeRWkMZ8HdHpm5wGQy+Y7E3+4HEKQ56NhCYAXzhl/0gj5?=
 =?us-ascii?Q?THxpwAJ8krRVi2wqjMDVBB2fek1gJgLCEBt85YD3kPsfEosqmppDrVNKfXSr?=
 =?us-ascii?Q?XGbQcYZgUudwLsKlLJoPiWj+V94CTOwo1Nzff4oXecp3q7CewDjhxsFjeRRq?=
 =?us-ascii?Q?4JpdNztYDlm5mlcQeXHdMhiHKOwR7a2GGDyZTDnF7IqIQNwphiA8sl1HmzXj?=
 =?us-ascii?Q?AecmuWd0eOy/r/NEjVpKWbX4PtwLjP+l9WftSUmqU7nSogs5rjx1tX3T2qiP?=
 =?us-ascii?Q?hipu0xp0V2MxsDVtQ7UjsuLDMpq1+4HSqTyQqZhej8KjmUey0ECQ1AUcm1D5?=
 =?us-ascii?Q?zj8ir7cBmhAb2mNom3jkl+o1tuSHzeFqmPD0PYFPOHUNW9kqWbwTw2fpyjbG?=
 =?us-ascii?Q?j/QQy0n4ZA5XlNGgyuW2avfaCT4PIBHs3lDmjPBiOpB6D3oPwUFA2X2EuXQK?=
 =?us-ascii?Q?vnD+KZJDYHeDaGNqDY+meghFumHuzQWDytQ7gvHcPoQuQB7BbdrylqpNwxes?=
 =?us-ascii?Q?EUwj3brbpR/hVu1gGJHbnNiMgNBE8X4zPAvg5AR5U0sIURKLioQU6aT6D4E5?=
 =?us-ascii?Q?rx9OB7DUikit1RhO0iLR0+ZX0uSwPdbur+HskMq8ztiLCM5ikdujH/W0Ebqj?=
 =?us-ascii?Q?Pe72+CUNzfhd8qLNmbfYo92u41euWWueVOdchnAcT6dXYavbBTqZUWsxCrve?=
 =?us-ascii?Q?SYAmZm2sLj8kNXMgjHtPo3ktjC+JPsoi2dyAqERSAanO/d719Trdnjc0nqB6?=
 =?us-ascii?Q?65bRJjPneVl2Dx+uYQJTEimaENOn7RWK0n5Ntdpl7SCUsgi3wsY6RTURhWAs?=
 =?us-ascii?Q?hUMLL/fH2OlIoOfDRWB2hPMeQLTaZzf0SbzNOcLlXMfLohHuYAcU85oMKRSa?=
 =?us-ascii?Q?7L36Mz0gDQssSLJy0xM0PnE0XAjXaaHodxVwaLAHMXVl4S0ENN/T7A6eWYun?=
 =?us-ascii?Q?MJqJ1FYav301Ocp1AnDxai3XRIO50w2BpejxpjfoYD3owd3lS+19M1RmJ4Kk?=
 =?us-ascii?Q?FELkYDcVhGcL7u9z7EvxROCv5QES3+k8QLHNn1+gp+e5VX3inGK1gBX01wih?=
 =?us-ascii?Q?C1TnBk4SnkNIrKMzRuTNTSV9TfN+GB4Ts4Sh28eUBzMYla3nPA4M1K6MS/lP?=
 =?us-ascii?Q?JPEv/drF0Gq++HosmM78A8ce+geh0SDHMCLI122v8RyMLyTMvtGmJF/dH+b2?=
 =?us-ascii?Q?+Osp2EaICjG6X5+crUhFTKevu+cVdcbsqMME?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 17:07:52.1290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd4a8f7-04bc-416b-2a08-08ddb72f7ba7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7365
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

The queue starting addresses offsets of a umem and doorbell offsets
are already passed to the Devx object creation function.

When the queue length is not zero, it means that the memory was
pre-allocated and the new object creation with consecutive memory
should be enabled.

When destroying the SQ / CQ objects, if it is in consecutive mode,
the umem and MR should not be released and the global resources
should only be released when stopping the device.

Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/common/mlx5/mlx5_common_devx.c | 160 +++++++++++++++++--------
 drivers/common/mlx5/mlx5_common_devx.h |   2 +
 2 files changed, 110 insertions(+), 52 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_common_devx.c b/drivers/common/mlx5/mlx5_common_devx.c
index aace5283e7..e237558ec2 100644
--- a/drivers/common/mlx5/mlx5_common_devx.c
+++ b/drivers/common/mlx5/mlx5_common_devx.c
@@ -30,6 +30,8 @@ mlx5_devx_cq_destroy(struct mlx5_devx_cq *cq)
 {
 	if (cq->cq)
 		claim_zero(mlx5_devx_cmd_destroy(cq->cq));
+	if (cq->consec)
+		return;
 	if (cq->umem_obj)
 		claim_zero(mlx5_os_umem_dereg(cq->umem_obj));
 	if (cq->umem_buf)
@@ -93,6 +95,7 @@ mlx5_devx_cq_create(void *ctx, struct mlx5_devx_cq *cq_obj, uint16_t log_desc_n,
 	uint32_t eqn;
 	uint32_t num_of_cqes = RTE_BIT32(log_desc_n);
 	int ret;
+	uint32_t umem_offset, umem_id;
 
 	if (page_size == (size_t)-1 || alignment == (size_t)-1) {
 		DRV_LOG(ERR, "Failed to get page_size.");
@@ -108,29 +111,44 @@ mlx5_devx_cq_create(void *ctx, struct mlx5_devx_cq *cq_obj, uint16_t log_desc_n,
 	}
 	/* Allocate memory buffer for CQEs and doorbell record. */
 	umem_size = sizeof(struct mlx5_cqe) * num_of_cqes;
-	umem_dbrec = RTE_ALIGN(umem_size, MLX5_DBR_SIZE);
-	umem_size += MLX5_DBR_SIZE;
-	umem_buf = mlx5_malloc_numa_tolerant(MLX5_MEM_RTE | MLX5_MEM_ZERO, umem_size,
-					     alignment, socket);
-	if (!umem_buf) {
-		DRV_LOG(ERR, "Failed to allocate memory for CQ.");
-		rte_errno = ENOMEM;
-		return -rte_errno;
-	}
-	/* Register allocated buffer in user space with DevX. */
-	umem_obj = mlx5_os_umem_reg(ctx, (void *)(uintptr_t)umem_buf, umem_size,
-				    IBV_ACCESS_LOCAL_WRITE);
-	if (!umem_obj) {
-		DRV_LOG(ERR, "Failed to register umem for CQ.");
-		rte_errno = errno;
-		goto error;
+	if (!attr->q_len) {
+		umem_dbrec = RTE_ALIGN(umem_size, MLX5_DBR_SIZE);
+		umem_size += MLX5_DBR_SIZE;
+		umem_buf = mlx5_malloc_numa_tolerant(MLX5_MEM_RTE | MLX5_MEM_ZERO, umem_size,
+						     alignment, socket);
+		if (!umem_buf) {
+			DRV_LOG(ERR, "Failed to allocate memory for CQ.");
+			rte_errno = ENOMEM;
+			return -rte_errno;
+		}
+		/* Register allocated buffer in user space with DevX. */
+		umem_obj = mlx5_os_umem_reg(ctx, (void *)(uintptr_t)umem_buf, umem_size,
+					    IBV_ACCESS_LOCAL_WRITE);
+		if (!umem_obj) {
+			DRV_LOG(ERR, "Failed to register umem for CQ.");
+			rte_errno = errno;
+			goto error;
+		}
+		umem_offset = 0;
+		umem_id = mlx5_os_get_umem_id(umem_obj);
+	} else {
+		if (umem_size != attr->q_len) {
+			DRV_LOG(ERR, "Mismatch between saved length and calc length of CQ %u-%u",
+				umem_size, attr->q_len);
+			rte_errno = EINVAL;
+			return -rte_errno;
+		}
+		umem_buf = attr->umem;
+		umem_offset = attr->q_off;
+		umem_dbrec = attr->db_off;
+		umem_id = mlx5_os_get_umem_id(attr->umem_obj);
 	}
 	/* Fill attributes for CQ object creation. */
 	attr->q_umem_valid = 1;
-	attr->q_umem_id = mlx5_os_get_umem_id(umem_obj);
-	attr->q_umem_offset = 0;
+	attr->q_umem_id = umem_id;
+	attr->q_umem_offset = umem_offset;
 	attr->db_umem_valid = 1;
-	attr->db_umem_id = attr->q_umem_id;
+	attr->db_umem_id = umem_id;
 	attr->db_umem_offset = umem_dbrec;
 	attr->eqn = eqn;
 	attr->log_cq_size = log_desc_n;
@@ -142,19 +160,29 @@ mlx5_devx_cq_create(void *ctx, struct mlx5_devx_cq *cq_obj, uint16_t log_desc_n,
 		rte_errno  = ENOMEM;
 		goto error;
 	}
-	cq_obj->umem_buf = umem_buf;
-	cq_obj->umem_obj = umem_obj;
+	if (!attr->q_len) {
+		cq_obj->umem_buf = umem_buf;
+		cq_obj->umem_obj = umem_obj;
+		cq_obj->db_rec = RTE_PTR_ADD(cq_obj->umem_buf, umem_dbrec);
+		cq_obj->consec = false;
+	} else {
+		cq_obj->umem_buf = RTE_PTR_ADD(umem_buf, umem_offset);
+		cq_obj->umem_obj = attr->umem_obj;
+		cq_obj->db_rec = RTE_PTR_ADD(umem_buf, umem_dbrec);
+		cq_obj->consec = true;
+	}
 	cq_obj->cq = cq;
-	cq_obj->db_rec = RTE_PTR_ADD(cq_obj->umem_buf, umem_dbrec);
 	/* Mark all CQEs initially as invalid. */
 	mlx5_cq_init(cq_obj, num_of_cqes);
 	return 0;
 error:
 	ret = rte_errno;
-	if (umem_obj)
-		claim_zero(mlx5_os_umem_dereg(umem_obj));
-	if (umem_buf)
-		mlx5_free((void *)(uintptr_t)umem_buf);
+	if (!attr->q_len) {
+		if (umem_obj)
+			claim_zero(mlx5_os_umem_dereg(umem_obj));
+		if (umem_buf)
+			mlx5_free((void *)(uintptr_t)umem_buf);
+	}
 	rte_errno = ret;
 	return -rte_errno;
 }
@@ -171,6 +199,8 @@ mlx5_devx_sq_destroy(struct mlx5_devx_sq *sq)
 {
 	if (sq->sq)
 		claim_zero(mlx5_devx_cmd_destroy(sq->sq));
+	if (sq->consec)
+		return;
 	if (sq->umem_obj)
 		claim_zero(mlx5_os_umem_dereg(sq->umem_obj));
 	if (sq->umem_buf)
@@ -220,6 +250,7 @@ mlx5_devx_sq_create(void *ctx, struct mlx5_devx_sq *sq_obj, uint16_t log_wqbb_n,
 	uint32_t umem_size, umem_dbrec;
 	uint32_t num_of_wqbbs = RTE_BIT32(log_wqbb_n);
 	int ret;
+	uint32_t umem_offset, umem_id;
 
 	if (alignment == (size_t)-1) {
 		DRV_LOG(ERR, "Failed to get WQE buf alignment.");
@@ -228,30 +259,45 @@ mlx5_devx_sq_create(void *ctx, struct mlx5_devx_sq *sq_obj, uint16_t log_wqbb_n,
 	}
 	/* Allocate memory buffer for WQEs and doorbell record. */
 	umem_size = MLX5_WQE_SIZE * num_of_wqbbs;
-	umem_dbrec = RTE_ALIGN(umem_size, MLX5_DBR_SIZE);
-	umem_size += MLX5_DBR_SIZE;
-	umem_buf = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO, umem_size,
-			       alignment, socket);
-	if (!umem_buf) {
-		DRV_LOG(ERR, "Failed to allocate memory for SQ.");
-		rte_errno = ENOMEM;
-		return -rte_errno;
-	}
-	/* Register allocated buffer in user space with DevX. */
-	umem_obj = mlx5_os_umem_reg(ctx, (void *)(uintptr_t)umem_buf, umem_size,
-				    IBV_ACCESS_LOCAL_WRITE);
-	if (!umem_obj) {
-		DRV_LOG(ERR, "Failed to register umem for SQ.");
-		rte_errno = errno;
-		goto error;
+	if (!attr->q_len) {
+		umem_dbrec = RTE_ALIGN(umem_size, MLX5_DBR_SIZE);
+		umem_size += MLX5_DBR_SIZE;
+		umem_buf = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO, umem_size,
+				       alignment, socket);
+		if (!umem_buf) {
+			DRV_LOG(ERR, "Failed to allocate memory for SQ.");
+				rte_errno = ENOMEM;
+				return -rte_errno;
+		}
+		/* Register allocated buffer in user space with DevX. */
+		umem_obj = mlx5_os_umem_reg(ctx, (void *)(uintptr_t)umem_buf, umem_size,
+					    IBV_ACCESS_LOCAL_WRITE);
+		if (!umem_obj) {
+			DRV_LOG(ERR, "Failed to register umem for SQ.");
+			rte_errno = errno;
+			goto error;
+		}
+		umem_offset = 0;
+		umem_id = mlx5_os_get_umem_id(umem_obj);
+	} else {
+		if (umem_size != attr->q_len) {
+			DRV_LOG(ERR, "Mismatch between saved length and calc length of WQ %u-%u",
+				umem_size, attr->q_len);
+			rte_errno = EINVAL;
+			return -rte_errno;
+		}
+		umem_buf = attr->umem;
+		umem_offset = attr->q_off;
+		umem_dbrec = attr->db_off;
+		umem_id = mlx5_os_get_umem_id(attr->umem_obj);
 	}
 	/* Fill attributes for SQ object creation. */
 	attr->wq_attr.wq_type = MLX5_WQ_TYPE_CYCLIC;
 	attr->wq_attr.wq_umem_valid = 1;
-	attr->wq_attr.wq_umem_id = mlx5_os_get_umem_id(umem_obj);
-	attr->wq_attr.wq_umem_offset = 0;
+	attr->wq_attr.wq_umem_id = umem_id;
+	attr->wq_attr.wq_umem_offset = umem_offset;
 	attr->wq_attr.dbr_umem_valid = 1;
-	attr->wq_attr.dbr_umem_id = attr->wq_attr.wq_umem_id;
+	attr->wq_attr.dbr_umem_id = umem_id;
 	attr->wq_attr.dbr_addr = umem_dbrec;
 	attr->wq_attr.log_wq_stride = rte_log2_u32(MLX5_WQE_SIZE);
 	attr->wq_attr.log_wq_sz = log_wqbb_n;
@@ -263,17 +309,27 @@ mlx5_devx_sq_create(void *ctx, struct mlx5_devx_sq *sq_obj, uint16_t log_wqbb_n,
 		rte_errno = ENOMEM;
 		goto error;
 	}
-	sq_obj->umem_buf = umem_buf;
-	sq_obj->umem_obj = umem_obj;
+	if (!attr->q_len) {
+		sq_obj->umem_buf = umem_buf;
+		sq_obj->umem_obj = umem_obj;
+		sq_obj->db_rec = RTE_PTR_ADD(sq_obj->umem_buf, umem_dbrec);
+		sq_obj->consec = false;
+	} else {
+		sq_obj->umem_buf = RTE_PTR_ADD(umem_buf, attr->q_off);
+		sq_obj->umem_obj = attr->umem_obj;
+		sq_obj->db_rec = RTE_PTR_ADD(umem_buf, attr->db_off);
+		sq_obj->consec = true;
+	}
 	sq_obj->sq = sq;
-	sq_obj->db_rec = RTE_PTR_ADD(sq_obj->umem_buf, umem_dbrec);
 	return 0;
 error:
 	ret = rte_errno;
-	if (umem_obj)
-		claim_zero(mlx5_os_umem_dereg(umem_obj));
-	if (umem_buf)
-		mlx5_free((void *)(uintptr_t)umem_buf);
+	if (!attr->q_len) {
+		if (umem_obj)
+			claim_zero(mlx5_os_umem_dereg(umem_obj));
+		if (umem_buf)
+			mlx5_free((void *)(uintptr_t)umem_buf);
+	}
 	rte_errno = ret;
 	return -rte_errno;
 }
diff --git a/drivers/common/mlx5/mlx5_common_devx.h b/drivers/common/mlx5/mlx5_common_devx.h
index 743f06042c..4cb9111dbb 100644
--- a/drivers/common/mlx5/mlx5_common_devx.h
+++ b/drivers/common/mlx5/mlx5_common_devx.h
@@ -21,6 +21,7 @@ struct mlx5_devx_cq {
 		volatile struct mlx5_cqe *cqes; /* The CQ ring buffer. */
 	};
 	volatile uint32_t *db_rec; /* The CQ doorbell record. */
+	bool consec; /* Using consecutive memory. */
 };
 
 /* DevX Send Queue structure. */
@@ -33,6 +34,7 @@ struct mlx5_devx_sq {
 		volatile struct mlx5_aso_wqe *aso_wqes;
 	};
 	volatile uint32_t *db_rec; /* The SQ doorbell record. */
+	bool consec; /* Using consecutive memory. */
 };
 
 /* DevX Queue Pair structure. */
-- 
2.34.1

