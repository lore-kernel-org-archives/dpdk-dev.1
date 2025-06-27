Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64815C7EE2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 16:38:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECA7040685;
	Fri, 27 Jun 2025 18:38:37 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by mails.dpdk.org (Postfix) with ESMTP id 0F9C7400EF
 for <dev@dpdk.org>; Fri, 27 Jun 2025 18:38:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lh4yA+e2qKnHO44lB9MjZ8zrHJJIb4Z/U18RqJm+e0Hoi/h3bcih1fpd1ONQh9seMAXs3VyOGsZSlrn2h01Yp3vIL5fesypesx8A1U2+csU5mHx8C4gXp495aYYs78ayOBdQteqxe5J+wU+TP+/Iygzejh5GDf3PGdVK3x1OXaPt1dHsd47i2SkeHCONM/V5k1IG7TdHXDwRB35z2OcR8IXEhPOVbcGsQQaC43jUzwo/Rn4K1IivjSn74Po4v9w71ExWDmIUYFex5S3Y+33EXGw9KondHOHJAqBy9Zy1vPGRT4erC7CzqmEzR5D1ZPkF66ux1IX6wc728aEcm+DO5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQn4ugqjjcfZQTakxnj31+GQ+N3o1fZCaCRUJojBDm8=;
 b=tInRsxYTPqQnwzRszk9vdRBYTmFBqZwoyOG+LkjTsTFGEFIwn5aEXscneRiHhHpBX82EyVCE+Tf/Vd5Pysm0jwwbutE6uyKKILs+qgFvvVJK2TiJentX+eOWlVfN34NdoxITIPTRu1AMFXWFCUSnbNOqztNJsijQkfHXdAJGP10IET7HacAJKlkgYS+Psho8LiDFmwEn27nm0h4UkQJetg2tE6d7A/p0S0S9IcmzbTg6Nx0vX/wrk52/tZ/+jL8bR40cSp5X1mr3F2N89DkBidvpAbJCTvYUmp71n2HNkG9lTm/0uQKiRJ407DxiQ1zWdjRgtrz7AOJODfVgyCYIfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQn4ugqjjcfZQTakxnj31+GQ+N3o1fZCaCRUJojBDm8=;
 b=OEwFulEnNar6M/hcEP1O7Zl6OP4zUXKv9wwsdA1uYALFY98Gb9AL2MnTk32KW/uXHceJg/rDkSEIwFNZt2av1wDA6CJ0aYyk7/Jl/jvLwK1x4SFbSmoTD8IRACGGaNyX9oGYRJLpk4NTch+zPMHG4i3hru3cpYW5NqoKbHQgSV7q9tXiBCKzmhlDWe1Qrs02I5dm/sPRSauH6QDoTia3/5rDAJL9sp8p5+2XbtgUuTDFN0jnnXr8vxLVITbGRCuUf71Pgdb/fuzax1KEk0Hp2JQarvZ7G9V5cT1BC5GhWr+pUN10gHJbFZwd2aQ5QvA3LHq3tTuvd0Ol3z36ruE/UA==
Received: from BYAPR02CA0020.namprd02.prod.outlook.com (2603:10b6:a02:ee::33)
 by IA0PR12MB8277.namprd12.prod.outlook.com (2603:10b6:208:3de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 27 Jun
 2025 16:38:28 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a02:ee:cafe::eb) by BYAPR02CA0020.outlook.office365.com
 (2603:10b6:a02:ee::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Fri,
 27 Jun 2025 16:38:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 16:38:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 27 Jun
 2025 09:38:06 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 27 Jun
 2025 09:38:04 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <matan@nvidia.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <dsosnowski@nvidia.com>,
 <suanmingm@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH v3 5/5] net/mlx5: use consecutive memory for Tx queue creation
Date: Fri, 27 Jun 2025 19:37:29 +0300
Message-ID: <20250627163729.50460-6-bingz@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|IA0PR12MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec0bd50-1dfc-459d-3892-08ddb5990b41
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F0Oq3MskLwrZuvr4ysoCAc0WJSiaSU280NtKzC0O9kY+y1vEFGg7Y9YvNOt8?=
 =?us-ascii?Q?4IMV5+pVuUDedRzpxycUj20HI97ei5/ABjMGSOEH2ThqIL0iuTqlAhOA5XdF?=
 =?us-ascii?Q?1fe4jTBnXNrD8GSN5IFhABI2VVrzWRNdB5l3JSXXhKX2GQIPU782ioDLYy3p?=
 =?us-ascii?Q?BRyQp9u6IUrxuJR4wvQG0EZYyPfe2v3SX4XqIHYb1FKyB/GNxKV6NcMCwCqQ?=
 =?us-ascii?Q?V12TFs+WSzG6WUh38HDC+HaoueeUo3KbP8uyyZduE9JhBsxN/X07/L5jEMzh?=
 =?us-ascii?Q?vPKlEWX9EQGaBouToTxBXeLk8GrF0hfZoSjnC2HqWBcsRkFZRtAtgQyKOstV?=
 =?us-ascii?Q?SnCs8ZRYJ4XsIAEF8UUt2Mu68XLvFV057S8DQaP/ejq/pA/kP8bso3yXojFe?=
 =?us-ascii?Q?8lRy0HmZ41YlM9XiOcBv5eg+N87mMuGgxlhhO3LK8IB3vfS2Tq+JVKu/hjKy?=
 =?us-ascii?Q?LEmyIerX47bwzzej62zGNDITfrnNRh2f0xG8SKLBLI99IHMsYrYclvt3jerf?=
 =?us-ascii?Q?AZWA5isnoXufZAsEVv7+zA5sf0fmYuK1KM+n1vmcPFyZsf5+Ze8Kz25uUbaH?=
 =?us-ascii?Q?tDJV27CS2nPxH0zoMkGSR5riytLPlLoXblfBdBs2Cb3exXiHzvjML1oIzCYb?=
 =?us-ascii?Q?zERru+Maqd25f8q6p9gzZ3NCCNue2wjh3lkd4Wlc1TerzZhRpU+yktaZTKhX?=
 =?us-ascii?Q?qPA1c6Zq26VDo15HfhjnO1/LD+TNGYf3i9TAlNyHUk8QoeFTMrwi/qkGcbVn?=
 =?us-ascii?Q?E8p3Wk5G89scw62UL63+KVAuHiQspcGlOogyqeNz4RI7Xnr1FsvXnn/B2HIw?=
 =?us-ascii?Q?zJHslgHGRqeOeFdY7D4P5PlIObM2qIEVQ1DoO3sn4tBpmHJckr0/RbT+PQke?=
 =?us-ascii?Q?irbMTyxVE2nghqufmsA9Mhl+04RpJL4NESRb09G35pmLqXyCZk6wEzeHlYIF?=
 =?us-ascii?Q?K+VOL6FRYN5nKKUW03lVN3X2/EYhuFBpX+Q82Zjo7/oTV5WOPmGSUVZkdsV1?=
 =?us-ascii?Q?caP947CvOjZTqpMc96SMMnKGZSAkjTEp0HCan9MTLKKbpxBYi6YTdCpOVAFX?=
 =?us-ascii?Q?XpvWIeh9tXHfU9VFnZf+OabY87YCJ9i/SrD5yv1Lm6r2Zkgu6ouPQSdWe8AW?=
 =?us-ascii?Q?jTMWXD3EBlZVTT7vsiwkJkR6xK3jhDOldSaBrwGrjGk8wUbZUDrMhZmwaD7c?=
 =?us-ascii?Q?NHrGFkDt5AQCq1ksCz35ABHjcsueMTc3ybK9Tjfqn8T87inTInEQsW6srSWh?=
 =?us-ascii?Q?wcrRUGCvfGeqACnB50JZLqMrt7NyJJW0Jjt7UnngWouBlDoqdfhLCG0TvHYw?=
 =?us-ascii?Q?eLZFdiOzjw1nBBkiO0Bg2q/58qAf5gWDUqPqwqfcAzZvpI/525kq431WCBgr?=
 =?us-ascii?Q?KIjuWshevst5/9DreUlEo2CrufifDByqRyyIqCBWy+GvQ5OAARldLixVETw8?=
 =?us-ascii?Q?AWkqa3W8ZBz/jIOycZ7MK8bOu8c1i3qj1DD1zt9u42+kSkH0DmdMfCCts0Aj?=
 =?us-ascii?Q?C5ZsNfQs9Kwxyn+9pfi6+gnh+KFbOlXC/ilo?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 16:38:27.8538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec0bd50-1dfc-459d-3892-08ddb5990b41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8277
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

