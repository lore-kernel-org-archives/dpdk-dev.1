Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F77C7EE39
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 17:24:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C552F402E7;
	Sun, 29 Jun 2025 19:23:49 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by mails.dpdk.org (Postfix) with ESMTP id 20B4D40691
 for <dev@dpdk.org>; Sun, 29 Jun 2025 19:23:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z10oTETa8G98hUJmFMUqZBYgWNmVPwoSTXSYxXryCiLrtB0NLwwBjmjZarhXeaB9yTh2+yqbYRjyUg2Y5i0fuNfd5HJMg7VMemaxWHsDd2MSRZVytFSlxYDMLb0TpoD3cIPcNSEw7Vt4h6F47h8DXz3rSJUct6is30uYAubH+RPoGG0ykBOqjj8l9ljcyduC78Je8GjhIc5y0EI7BZ2qt0sNREuDq678Ic+dTU8Uc62K2AEuYDTIXqeniuSqv8Afp/ECE4YJkgMZ/hOGWaIH667XlCkwEGXJUn9fPfJWZTA2fh5/HeCvIUix0vGs/M687mkiSYD8AZ0yZbgV00V8nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQn4ugqjjcfZQTakxnj31+GQ+N3o1fZCaCRUJojBDm8=;
 b=gZCLn2Tmieue/kNon+pLMoVxPjWQm2qj2tJv+skA3PNoZuDeldAaxK8e0vtdxhj50U0Li16s10n2Qd2daqxw/xCySGuiiD9gzXkaxXwAgN45HOmqE30nPWZjvA3T+TAbDAp94sSq4EAXSlTqAbeuzR0xP+Xeuxv7GWx7vOxBR+QSx+eed5uteuyENZF0yBoCgTKC+VhMz4QdmG4rGXpCeXjZSZ4cTZyJChqPoEgDb6N7RuR+VeKPZ7aWVFIFrIadbofo9AkhXsot/8KhXtUkj+bk3J4eBZFlTyQbH6PsZeJs54lssvP30Y3Yrn3wNuq3+j5BxcoYPDNSBcevnfiDuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 216.228.117.160) smtp.rcpttodomain=dpdk.org
 smtp.mailfrom=nvidia.com; 
 dmarc=temperror action=none header.from=nvidia.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQn4ugqjjcfZQTakxnj31+GQ+N3o1fZCaCRUJojBDm8=;
 b=f7UAG3ro8h/SgtpKa2MLltzHpnS5YgZBZnqtfa8ciOw7odKDS6CtruA/Mw8+4Bi4JcSP3ZaBojfJh5/CXvMjfv6AYiT0189jO5e6eIEHIGbWGP15YKInzNiUKrj9OcBqvbTWnyOjjgBdDanCgGUTXGnPPMUonJPknf40512WcsHZpsZ+ozDVhFVbeCr0EWmN96jQdIWBwcyH8DPjGeZxjwjVCIz0EnVu9hvIyTK0sJ8nXg+VVp8EAcdfHf8bBNNrpv/z3Wo6om500SjrjHHRLnF/RN0daWMaPYqgqeeOam7hrPDDobE7+/gxjgyY3L7/mQg6wI+iLxDs+gvKvzGUFQ==
Received: from BL0PR05CA0008.namprd05.prod.outlook.com (2603:10b6:208:91::18)
 by CH3PR12MB9121.namprd12.prod.outlook.com (2603:10b6:610:1a1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Sun, 29 Jun
 2025 17:23:43 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::c2) by BL0PR05CA0008.outlook.office365.com
 (2603:10b6:208:91::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.17 via Frontend Transport; Sun,
 29 Jun 2025 17:23:43 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=nvidia.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nvidia.com: DNS Timeout)
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sun, 29 Jun 2025 17:23:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 29 Jun
 2025 10:23:32 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 29 Jun
 2025 10:23:30 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <matan@nvidia.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <dsosnowski@nvidia.com>,
 <suanmingm@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH v5 5/5] net/mlx5: use consecutive memory for Tx queue creation
Date: Sun, 29 Jun 2025 20:23:03 +0300
Message-ID: <20250629172303.72049-6-bingz@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|CH3PR12MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: 835b5063-9f8c-4fb3-4d41-08ddb731b1e2
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K3geZ54UL4zxu8rPnbno4T6wRZ1YYu1CMydekbQ4vsePaADbQvo7Aeb8ZquF?=
 =?us-ascii?Q?asIZZyXaVTG8CsLUX5SbJ0W8uwmrREXMw00kbvLYBzo7DbjawsFaRURpW9aI?=
 =?us-ascii?Q?+LZXfOxGbCTOHoPIRNT3ffrahWDcYy9EoprjC9hvzpIe90nosz/KxFM8+sK0?=
 =?us-ascii?Q?XDcUbHfQJtYhbNkX39P7PXqAMsPpYBTPntt03xxvoIRlQBPZP8P4fTlHHX5e?=
 =?us-ascii?Q?0OrtVW0ANG9h/WB5Amh/umuYq2GLN25ab+Fq6iP/RQ7F5TxpXnUDVwP7ikFM?=
 =?us-ascii?Q?cncViU6t87oDyRW9+i2TRuHnUnqKAAEc48ZiyxVbE60vBvpVHk88fnnmY3G2?=
 =?us-ascii?Q?L6h7tsVlwc08YffQ9OzChsDlo2q6WWfiug4JqbveVDeNV/1NjjYYR3+P7Qkr?=
 =?us-ascii?Q?/CGaIs4uXLl4x90euXm91uxNY/WDA3mxq7Wr4tPZDrPwRbTj3rNxRH3jgPff?=
 =?us-ascii?Q?WFBJZdWKyBAiGJhX6DVAgSp2oOIk79aSCKX4Qxhhv54P5DUvlKTHU0JjtyJ/?=
 =?us-ascii?Q?ML5Zn6WrLg/p0JLFmmYoxOJ+24maFDWIWGscVO7KEnvXJVS0bczyAfDZz4ji?=
 =?us-ascii?Q?dlF7cwvbAkdIMyQHPeDyzXdOYuixXhpTiY0lpfkW/lD1AWvHeGV2ud7i0Esq?=
 =?us-ascii?Q?7Et5M0OI37y+mu7YgXAWs7dLMThgYn4P9h58Mr/EGvFLkYZDwzBC5+mAXrtb?=
 =?us-ascii?Q?+Kcz0/NXIKWFWLDTC7OEZ+8KzRqc3jW27h8acTkRiGhjk4rlcfVomaQZwHhj?=
 =?us-ascii?Q?tW9kWW/cbOYbjeu5KOhIyR3i2VfwmXUsobkGHYKt3yoFKjw0//g+hr3AKt3c?=
 =?us-ascii?Q?jad74cbP5IpYRBF9zWFk1I0RuaX3nbdKJmEn/eUTHwxMwjxIQinVR91f5HLv?=
 =?us-ascii?Q?yvUGRD6xrlaZqge7Mv3GtRwCp3l8i4tnxnF5RcYO+90W5hFqkiiHB6ri4/c/?=
 =?us-ascii?Q?lpDOT8PSxNBCTP0Fcil3nFgs9rzFXVBzQmwvgAyLLu57PSt5Rm0OgF1Kcwj5?=
 =?us-ascii?Q?c/4JBGfUME9B1BW80E8IZ8B0NNQlsZcdFPcLHRCPsieM4EAuVNRgdJog5i98?=
 =?us-ascii?Q?U68uqcLmqd0qo2mPaZFy58yYu35kf5rwCH17gJ8n5/xsHQw5f7fno2mivOTh?=
 =?us-ascii?Q?qoe62NKNqn/N/u4qqT+HE6HEE5iG74SCgd5wXU0ZAlR7m7dHih4KlIdZe9xj?=
 =?us-ascii?Q?gfsKZJIok+PaGDKKUo4KhtOPVGUEWdrRHHzJkHEZUU3Ir7J8hw/3yUsZKo5e?=
 =?us-ascii?Q?e8hTEkhkKs/F5h+Nf0oS895rzKX29nVZ84SSUSJNrAVmqOvZ+CMVwS+SGGWO?=
 =?us-ascii?Q?Q3o+1WVHifmtFmeEbkwCvybXv4s1VbNmTmECr3//0ojtwI+kTUJBRI2IUcxM?=
 =?us-ascii?Q?XAB5q7GU7Vy1YRO1DyVigAu6W2gLyjgXCkMhn7cbdGLMhj5Pvfwx0QtRLQMS?=
 =?us-ascii?Q?93SLBmNzr3VeY9UD6FA+JBgxFTrNfnpPc+Ut3YtCOkyGni3CwIdNI9EUxi1V?=
 =?us-ascii?Q?1qG9gGMsC9oGbxCMcn9LvUKR14bzo9ADeyff?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 17:23:42.0358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 835b5063-9f8c-4fb3-4d41-08ddb731b1e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9121
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

