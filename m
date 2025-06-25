Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D7FC7EE2A
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 15:01:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D030140B8D;
	Wed, 25 Jun 2025 17:01:07 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by mails.dpdk.org (Postfix) with ESMTP id 490CF4069D
 for <dev@dpdk.org>; Wed, 25 Jun 2025 17:01:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSRjAlVKrQkmxVac+d36s4fJ2hM2d7rKcPmlNTzjhcMyLb+J6JCe5PkxHQEt7ceDNxmuUO53v3mpEOhzUQ3C1vIZVXiVASUcq2j8S8B1o4DmVL3uKdusAP/jIU3kXvR8ZDMbn5eMH5y3wotmWKJX8rTgTNLw8/EqDXtaLqToEfSsSimTZHFZVMY61TQLPWe7VhyO3y4o4hNfYkvDq92ND6nc/kcos82aeFbCl8oh3TaxLt3ZN+KoFyg69NhV4evU7et0MSYB+guRRu9CTNxo7UmdqMRxdrlCvFS/wJfCDcKOQuOS9AXMIW1mGqSPOtE7T7Gk1UP/DlWEi7xS7b8U8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGsVjCqqmOnwnkcO4yMKmx8LWhC9wSn5+6m7eOfc7+k=;
 b=pgNSsDpFx/vDWZlTpWOzEnvoOuKqjmJAlb/4fBrX/otOo7esiC2KTEhGeSJrCYKsNvvRe/ll8rFNwIlMy7esjUx1MfTw+HKQHjYLz+4V1vaMk2QE27MlKGrNNu3LiC+xRvEcnjAKZ7lnwCaHPiYU77KAI36vaFcUfOaW0FHeGKV3nPt+J3qNpbwznNSye49ysPWJ6Z8DPkK8bBTbwGQ5rbMwyQabRyWzrE7dP69iT6BJRV3spGbtMJ01JyVYHUlXo3xZA6jjyQIfjkjW20uXPgl5w9SYwtWn6E5xXIv3C2TLL1FIDhUOPtRLdSZv7ATZHBKvjT4/hnBkrETH9MXhyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGsVjCqqmOnwnkcO4yMKmx8LWhC9wSn5+6m7eOfc7+k=;
 b=n6vYXvl32KViOur4epPbWfUAdo21ZTUVA8TnSg+DW0l6+5fuanz2XWJ7Vef5LvzXbivQqlsL2g/3nMACgoLwR2j+uCU13EuE6RqgCjQBKCmb9K2W+rrgOFZM3zPKqK+CNAGndJeDTiFG22QfBZCunVRtdqNqM9qamx2/L3BXTlWDmTslIE2+/8ezKnRybkENgGPJj0bWsYF6/mEcTiIIZmvzUedbczlPiGZqcPoVAoxf0eE0IxeYzIFA7cllcsyXgflN5Vqz9jRHqZ6JmbiH0QClV8OIqf75rKK360610AFUjOnw+4IxwMxHXYYRkVrFkQyMk6G/zhnX+LOgoFFhpQ==
Received: from BLAPR03CA0036.namprd03.prod.outlook.com (2603:10b6:208:32d::11)
 by PH0PR12MB7789.namprd12.prod.outlook.com (2603:10b6:510:283::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 15:00:55 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:208:32d:cafe::3) by BLAPR03CA0036.outlook.office365.com
 (2603:10b6:208:32d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Wed,
 25 Jun 2025 15:00:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 15:00:54 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 25 Jun
 2025 08:00:29 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 25 Jun
 2025 08:00:29 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 25 Jun 2025 08:00:26 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH v2] net/mlx5: support NUMA node fallback
Date: Wed, 25 Jun 2025 18:00:22 +0300
Message-ID: <20250625150022.183054-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20250619070132.35181-1-mkashani@nvidia.com>
References: <20250619070132.35181-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|PH0PR12MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ef8f426-35e6-49c0-615f-08ddb3f9155d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/7sJIhIk90SN4ZlGo6OYlE3N5ZPqZ78Tx7e+J+dfnnX7fAHvMPSIkFnk+P2P?=
 =?us-ascii?Q?nFkASjAN8+wXIZGacSLfns6qrvc8XrLG6sbBG94jSJ3D8FB1JqdKNSzoS00t?=
 =?us-ascii?Q?euFAQZxz2cpfYKp3yk9anmNOC8CG7FBAhl461ewX0JYKtEaxoH1L5NPWaaMJ?=
 =?us-ascii?Q?6SGYjhlLJaikUhi9ns8Dgz6ApSzyJTkOJpJngMKTmP/TYLMe+6uoBlEFPhQU?=
 =?us-ascii?Q?FzKhuzlLuCUTNnDrf5BlO1RqoQGapcCQIMEd85d58lf4i7ECNJn5rIMAqhvI?=
 =?us-ascii?Q?JSNw9Yk0rmVDm8HVuCvwPrJEZeM9qBYEDDzaBn+g1lIZ5ZySiM48uFEuWRaa?=
 =?us-ascii?Q?aNbA6H1h3hKpMdmIUPWv4voqew+jtuAY8KuXxmlkLWqm/SAmOK9gwNk0oPos?=
 =?us-ascii?Q?0NnRgZQzQOEYhoMJ298LN5BO5SuEst0o/rKMZdI08Uy0QKsQfIK+aElUtYTm?=
 =?us-ascii?Q?SksJ+AuRBDj8Y5/C1FgSCoWEWUZBojHvIpD5y/P91A7P3WNSEItjZX5JEE2Y?=
 =?us-ascii?Q?zWVZasfhKn8q5DXSybtxF3pU+yQMvaEe02sXiIubHTyzCjVjT7SRkmYzM8PV?=
 =?us-ascii?Q?JXymzXjDAh1U82/K8Kezk8Sq9Faw64ZPIl4vhdOmwgKUQyZ5nkgeAQr0hqwB?=
 =?us-ascii?Q?OgzRz9wPrHlzxSOPmjHKvYBVWlknOAlDkfiQ/oBeSMmvwz3xm9suPyV4GDHo?=
 =?us-ascii?Q?3uvQGP9AFGYlRMKgYVtjVBVZ/gcAJuvzOngdoosOhxLgoIk4VNbGhD5mlxgC?=
 =?us-ascii?Q?j2LymKbCZeB+xXT0jxSFyZgxGh5e99bnQlhzgZWZPFlLzwUJtKm4fY1hdK+H?=
 =?us-ascii?Q?d8uxf1i8K2xsV5WplmrRoGgi2y+NEGUS7nqLEekKHpqKzETeBDkkpY5zkx66?=
 =?us-ascii?Q?vz8JY4cOGYWRUyJIYRx2ryPtbrxdNiashBsZvyYgOZJyIUji8YNAIlSkA6LS?=
 =?us-ascii?Q?oHLbzXnfsJxXNmecTJOkv+x5905BYoG6J64xUB72NkwE4N0ZyIpz6Rg6S6fX?=
 =?us-ascii?Q?UHoYb0gFdnac1d9qbTiu0bANXKIX8/5fsVa+VpmJehNoIB8K653znhWudNqc?=
 =?us-ascii?Q?JQpLaFVTBMgYDdnC6GxNPxRFv+UJBQhsOQeqzWvIRKgjTur7rKUmH+DzLHpR?=
 =?us-ascii?Q?qDmFjVsn9RcrtDYdL+r9RpH07GYZ4Cnqwb2T250zTrTI9l38sHCmIsekQyz8?=
 =?us-ascii?Q?L28g1tTdrh2TUspynEz/KbVQbyxJyMsMuQwCDEy/xdXlEFEwsAaJch95WEtT?=
 =?us-ascii?Q?qHQwJR1Pca1dvK/nyuLbvf+LAImY/ArmuHPCwWwPTp6Ul64+MIKhIISojrqc?=
 =?us-ascii?Q?nLBYtacEuW8AS/1XIepVPU1eG01Mmpqv0R+9SKy3f/4t5uM2AUNgbd7J8/B9?=
 =?us-ascii?Q?w93VbDMUTqVlNCsSrt6fnS97KTbx+xC9ray+ByvJSQIlpJJ1S+NyN35G18mD?=
 =?us-ascii?Q?/dDBBZEs2emZ5fuyDh/yfrDrZkqR1X+yvqgVmJ/M9e2/nSEPmdxfLL7Vjedz?=
 =?us-ascii?Q?NkZssV3BL3qN/i8ziQh1ApZWyiSGPIpvmbIf?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 15:00:54.1355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef8f426-35e6-49c0-615f-08ddb3f9155d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7789
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

Cross NUMA support means that when there is no
memory on the local NUMA, use other available
NUMA memory for port initialization and start.

If mlx5 malloc with specified socket failed,
malloc function would return an error.
To support cross NUMA,
NUMA tolerant wrapper will be used on supported toolchains,
and it will log the exact place where fallback allocation happened.
NUMA tolerant flags in mlx5_malloc were added to support cases
where the toolchain does not support statement expressions.

Add a NUMA tolerant wrapper to mlx5 malloc calls in
ipool and devx/memory region initializations
to support cross NUMA in device probing and port start stage.

For Tx/Rx initializations, use socket-num given by the user
 and when SOCKET_ID_ANY is passed, default to device NUMA
node with fallback to SOCKET_ID_ANY.

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/common/mlx5/mlx5_common_devx.c |  8 ++---
 drivers/common/mlx5/mlx5_devx_cmds.c   |  4 +--
 drivers/common/mlx5/mlx5_malloc.c      | 21 +++++++++---
 drivers/common/mlx5/mlx5_malloc.h      | 20 +++++++++++
 drivers/net/mlx5/mlx5.c                |  4 +--
 drivers/net/mlx5/mlx5_devx.c           |  6 ++--
 drivers/net/mlx5/mlx5_flow_hw.c        | 14 ++++----
 drivers/net/mlx5/mlx5_rxq.c            | 30 +++++++++++++----
 drivers/net/mlx5/mlx5_trigger.c        | 16 ++++-----
 drivers/net/mlx5/mlx5_txq.c            | 31 +++++++++++++----
 drivers/net/mlx5/mlx5_utils.c          | 46 ++++++++++++++++++++------
 11 files changed, 147 insertions(+), 53 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_common_devx.c b/drivers/common/mlx5/mlx5_common_devx.c
index cd1292b92ba..aace5283e7d 100644
--- a/drivers/common/mlx5/mlx5_common_devx.c
+++ b/drivers/common/mlx5/mlx5_common_devx.c
@@ -110,8 +110,8 @@ mlx5_devx_cq_create(void *ctx, struct mlx5_devx_cq *cq_obj, uint16_t log_desc_n,
 	umem_size = sizeof(struct mlx5_cqe) * num_of_cqes;
 	umem_dbrec = RTE_ALIGN(umem_size, MLX5_DBR_SIZE);
 	umem_size += MLX5_DBR_SIZE;
-	umem_buf = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO, umem_size,
-			       alignment, socket);
+	umem_buf = mlx5_malloc_numa_tolerant(MLX5_MEM_RTE | MLX5_MEM_ZERO, umem_size,
+					     alignment, socket);
 	if (!umem_buf) {
 		DRV_LOG(ERR, "Failed to allocate memory for CQ.");
 		rte_errno = ENOMEM;
@@ -484,8 +484,8 @@ mlx5_devx_wq_init(void *ctx, uint32_t wqe_size, uint16_t log_wqbb_n, int socket,
 	umem_size = wqe_size * (1 << log_wqbb_n);
 	umem_dbrec = RTE_ALIGN(umem_size, MLX5_DBR_SIZE);
 	umem_size += MLX5_DBR_SIZE;
-	umem_buf = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO, umem_size,
-			       alignment, socket);
+	umem_buf = mlx5_malloc_numa_tolerant(MLX5_MEM_RTE | MLX5_MEM_ZERO, umem_size,
+					     alignment, socket);
 	if (!umem_buf) {
 		DRV_LOG(ERR, "Failed to allocate memory for RQ.");
 		rte_errno = ENOMEM;
diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c b/drivers/common/mlx5/mlx5_devx_cmds.c
index 1a3f4580d87..cf601254ab2 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.c
+++ b/drivers/common/mlx5/mlx5_devx_cmds.c
@@ -1537,7 +1537,7 @@ mlx5_devx_cmd_create_rq(void *ctx,
 	struct mlx5_devx_wq_attr *wq_attr;
 	struct mlx5_devx_obj *rq = NULL;
 
-	rq = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*rq), 0, socket);
+	rq = mlx5_malloc_numa_tolerant(MLX5_MEM_ZERO, sizeof(*rq), 0, socket);
 	if (!rq) {
 		DRV_LOG(ERR, "Failed to allocate RQ data");
 		rte_errno = ENOMEM;
@@ -1680,7 +1680,7 @@ mlx5_devx_cmd_create_rmp(void *ctx,
 	struct mlx5_devx_wq_attr *wq_attr;
 	struct mlx5_devx_obj *rmp = NULL;
 
-	rmp = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*rmp), 0, socket);
+	rmp = mlx5_malloc_numa_tolerant(MLX5_MEM_ZERO, sizeof(*rmp), 0, socket);
 	if (!rmp) {
 		DRV_LOG(ERR, "Failed to allocate RMP data");
 		rte_errno = ENOMEM;
diff --git a/drivers/common/mlx5/mlx5_malloc.c b/drivers/common/mlx5/mlx5_malloc.c
index d56b4fb5a89..28fb19b2852 100644
--- a/drivers/common/mlx5/mlx5_malloc.c
+++ b/drivers/common/mlx5/mlx5_malloc.c
@@ -162,6 +162,13 @@ mlx5_alloc_align(size_t size, unsigned int align, unsigned int zero)
 	return buf;
 }
 
+static void *
+mlx5_malloc_socket_internal(size_t size, unsigned int align, int socket, bool zero)
+{
+	return zero ? rte_zmalloc_socket(NULL, size, align, socket) :
+		      rte_malloc_socket(NULL, size, align, socket);
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(mlx5_malloc)
 void *
 mlx5_malloc(uint32_t flags, size_t size, unsigned int align, int socket)
@@ -180,10 +187,16 @@ mlx5_malloc(uint32_t flags, size_t size, unsigned int align, int socket)
 	else
 		rte_mem = mlx5_sys_mem.enable ? false : true;
 	if (rte_mem) {
-		if (flags & MLX5_MEM_ZERO)
-			addr = rte_zmalloc_socket(NULL, size, align, socket);
-		else
-			addr = rte_malloc_socket(NULL, size, align, socket);
+		addr = mlx5_malloc_socket_internal(size, align, socket, !!(flags & MLX5_MEM_ZERO));
+		if (addr == NULL && socket != SOCKET_ID_ANY && (flags & MLX5_NUMA_TOLERANT)) {
+			size_t alloc_size = size;
+			addr = mlx5_malloc_socket_internal(size, align, SOCKET_ID_ANY,
+				!!(flags & MLX5_MEM_ZERO));
+			if (addr) {
+				DRV_LOG(WARNING, "Allocated %p (size %zu socket %d) through NUMA tolerant fallback",
+					(addr), (alloc_size), (socket));
+			}
+		}
 		mlx5_mem_update_msl(addr);
 #ifdef RTE_LIBRTE_MLX5_DEBUG
 		if (addr)
diff --git a/drivers/common/mlx5/mlx5_malloc.h b/drivers/common/mlx5/mlx5_malloc.h
index 9086a4f3f22..1be3885c9cf 100644
--- a/drivers/common/mlx5/mlx5_malloc.h
+++ b/drivers/common/mlx5/mlx5_malloc.h
@@ -28,6 +28,8 @@ enum mlx5_mem_flags {
 	/* Memory should be allocated from rte hugepage. */
 	MLX5_MEM_ZERO = 1 << 2,
 	/* Memory should be cleared to zero. */
+	MLX5_NUMA_TOLERANT = 1 << 3,
+	/* Fallback to any NUMA if the memory allocation fails. */
 };
 
 /**
@@ -101,6 +103,24 @@ void *mlx5_realloc(void *addr, uint32_t flags, size_t size, unsigned int align,
 __rte_internal
 void mlx5_free(void *addr);
 
+#if defined(RTE_TOOLCHAIN_GCC) || defined(RTE_TOOLCHAIN_CLANG)
+#define mlx5_malloc_numa_tolerant(flags, size, align, socket) (__extension__ ({			\
+		void *mem = mlx5_malloc((uint32_t)(flags), (size_t)(size), (align), (socket));	\
+		if ((mem == NULL) && ((int)(socket) != SOCKET_ID_ANY)) {			\
+			mem = mlx5_malloc((uint32_t)(flags), (size_t)(size),			\
+					  (align), SOCKET_ID_ANY);				\
+			if (mem) {								\
+				DRV_LOG(WARNING,						\
+				"Allocated %p (size %zu socket %d) through NUMA tolerant fallback",\
+					(mem), ((size_t)(size)), (socket));			\
+			}									\
+		}										\
+		mem;										\
+	}))
+#else
+#define mlx5_malloc_numa_tolerant(flags, size, align, socket)
+	(mlx5_malloc((flags) | MLX5_NUMA_TOLERANT, (size), (align), (socket)));
+#endif
 #ifdef __cplusplus
 }
 #endif
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index b4bd43aae25..29700524458 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -2271,8 +2271,8 @@ mlx5_proc_priv_init(struct rte_eth_dev *dev)
 	 */
 	ppriv_size = sizeof(struct mlx5_proc_priv) +
 		     priv->txqs_n * sizeof(struct mlx5_uar_data);
-	ppriv = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO, ppriv_size,
-			    RTE_CACHE_LINE_SIZE, dev->device->numa_node);
+	ppriv = mlx5_malloc_numa_tolerant(MLX5_MEM_RTE | MLX5_MEM_ZERO, ppriv_size,
+					  RTE_CACHE_LINE_SIZE, dev->device->numa_node);
 	if (!ppriv) {
 		rte_errno = ENOMEM;
 		return -rte_errno;
diff --git a/drivers/net/mlx5/mlx5_devx.c b/drivers/net/mlx5/mlx5_devx.c
index ab0de7eb0ca..3d49e096ef3 100644
--- a/drivers/net/mlx5/mlx5_devx.c
+++ b/drivers/net/mlx5/mlx5_devx.c
@@ -1097,14 +1097,14 @@ mlx5_rxq_devx_obj_drop_create(struct rte_eth_dev *dev)
 	 * They are required to hold pointers for cleanup
 	 * and are only accessible via drop queue DevX objects.
 	 */
-	rxq = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*rxq), 0, socket_id);
+	rxq = mlx5_malloc_numa_tolerant(MLX5_MEM_ZERO, sizeof(*rxq), 0, socket_id);
 	if (rxq == NULL) {
 		DRV_LOG(ERR, "Port %u could not allocate drop queue private",
 			dev->data->port_id);
 		rte_errno = ENOMEM;
 		goto error;
 	}
-	rxq_ctrl = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*rxq_ctrl),
+	rxq_ctrl = mlx5_malloc_numa_tolerant(MLX5_MEM_ZERO, sizeof(*rxq_ctrl),
 			       0, socket_id);
 	if (rxq_ctrl == NULL) {
 		DRV_LOG(ERR, "Port %u could not allocate drop queue control",
@@ -1112,7 +1112,7 @@ mlx5_rxq_devx_obj_drop_create(struct rte_eth_dev *dev)
 		rte_errno = ENOMEM;
 		goto error;
 	}
-	rxq_obj = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*rxq_obj), 0, socket_id);
+	rxq_obj = mlx5_malloc_numa_tolerant(MLX5_MEM_ZERO, sizeof(*rxq_obj), 0, socket_id);
 	if (rxq_obj == NULL) {
 		DRV_LOG(ERR, "Port %u could not allocate drop queue object",
 			dev->data->port_id);
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index af2e7a84a54..f7f85effbac 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -5070,7 +5070,7 @@ flow_hw_table_create(struct rte_eth_dev *dev,
 	tbl_mem_size = sizeof(*tbl);
 	tbl_mem_size += nb_action_templates * priv->nb_queue * sizeof(tbl->rule_acts[0]);
 	/* Allocate the table memory. */
-	tbl = mlx5_malloc(MLX5_MEM_ZERO, tbl_mem_size, RTE_CACHE_LINE_SIZE, rte_socket_id());
+	tbl = mlx5_malloc(MLX5_MEM_ZERO, tbl_mem_size, RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
 	if (!tbl)
 		goto error;
 	tbl->cfg = *table_cfg;
@@ -5080,7 +5080,7 @@ flow_hw_table_create(struct rte_eth_dev *dev,
 		goto error;
 	/* Allocate table of auxiliary flow rule structs. */
 	tbl->flow_aux = mlx5_malloc(MLX5_MEM_ZERO, sizeof(struct rte_flow_hw_aux) * nb_flows,
-				    RTE_CACHE_LINE_SIZE, rte_dev_numa_node(dev->device));
+				    RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
 	if (!tbl->flow_aux)
 		goto error;
 	/* Register the flow group. */
@@ -8033,7 +8033,7 @@ __flow_hw_actions_template_create(struct rte_eth_dev *dev,
 		return NULL;
 	len += RTE_ALIGN(orig_act_len, 16);
 	at = mlx5_malloc(MLX5_MEM_ZERO, len + sizeof(*at),
-			 RTE_CACHE_LINE_SIZE, rte_socket_id());
+			 RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
 	if (!at) {
 		rte_flow_error_set(error, ENOMEM,
 				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
@@ -8201,7 +8201,7 @@ flow_hw_prepend_item(const struct rte_flow_item *items,
 
 	/* Allocate new array of items. */
 	size = sizeof(*copied_items) * (nb_items + 1);
-	copied_items = mlx5_malloc(MLX5_MEM_ZERO, size, 0, rte_socket_id());
+	copied_items = mlx5_malloc(MLX5_MEM_ZERO, size, 0, SOCKET_ID_ANY);
 	if (!copied_items) {
 		rte_flow_error_set(error, ENOMEM,
 				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
@@ -9018,7 +9018,7 @@ flow_hw_pattern_template_create(struct rte_eth_dev *dev,
 		tmpl_items = items;
 	}
 setup_pattern_template:
-	it = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*it), 0, rte_socket_id());
+	it = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*it), 0, SOCKET_ID_ANY);
 	if (!it) {
 		rte_flow_error_set(error, ENOMEM,
 				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
@@ -9038,7 +9038,7 @@ flow_hw_pattern_template_create(struct rte_eth_dev *dev,
 		goto error;
 	}
 	it_items_size = RTE_ALIGN(it_items_size, 16);
-	it->items = mlx5_malloc(MLX5_MEM_ZERO, it_items_size, 0, rte_dev_numa_node(dev->device));
+	it->items = mlx5_malloc(MLX5_MEM_ZERO, it_items_size, 0, SOCKET_ID_ANY);
 	if (it->items == NULL) {
 		rte_flow_error_set(error, ENOMEM,
 				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
@@ -11443,7 +11443,7 @@ flow_hw_create_ctrl_rx_tables(struct rte_eth_dev *dev)
 
 	MLX5_ASSERT(!priv->hw_ctrl_rx);
 	priv->hw_ctrl_rx = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*priv->hw_ctrl_rx),
-				       RTE_CACHE_LINE_SIZE, rte_socket_id());
+				       RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
 	if (!priv->hw_ctrl_rx) {
 		DRV_LOG(ERR, "Failed to allocate memory for Rx control flow tables");
 		rte_errno = ENOMEM;
diff --git a/drivers/net/mlx5/mlx5_rxq.c b/drivers/net/mlx5/mlx5_rxq.c
index f5df451a32f..2e9bcbea4db 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -1756,6 +1756,7 @@ mlx5_rxq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 	     const struct rte_eth_rxseg_split *rx_seg, uint16_t n_seg,
 	     bool is_extmem)
 {
+	int ret;
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_rxq_ctrl *tmpl;
 	unsigned int mb_len = rte_pktmbuf_data_room_size(rx_seg[0].mp);
@@ -1793,7 +1794,12 @@ mlx5_rxq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 		desc >>= mprq_log_actual_stride_num;
 		alloc_size += desc * sizeof(struct mlx5_mprq_buf *);
 	}
-	tmpl = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO, alloc_size, 0, socket);
+	if (socket != (unsigned int)SOCKET_ID_ANY) {
+		tmpl = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO, alloc_size, 0, socket);
+	} else {
+		tmpl = mlx5_malloc_numa_tolerant(MLX5_MEM_RTE | MLX5_MEM_ZERO, alloc_size, 0,
+						 dev->device->numa_node);
+	}
 	if (!tmpl) {
 		rte_errno = ENOMEM;
 		return NULL;
@@ -1882,12 +1888,24 @@ mlx5_rxq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 		goto error;
 	}
 	tmpl->is_hairpin = false;
-	if (mlx5_mr_ctrl_init(&tmpl->rxq.mr_ctrl,
-			      &priv->sh->cdev->mr_scache.dev_gen, socket)) {
-		/* rte_errno is already set. */
-		goto error;
+	if (socket != (unsigned int)SOCKET_ID_ANY) {
+		if (mlx5_mr_ctrl_init(&tmpl->rxq.mr_ctrl,
+					&priv->sh->cdev->mr_scache.dev_gen, socket))
+			/* rte_errno is already set. */
+			goto error;
+	} else {
+		ret = mlx5_mr_ctrl_init(&tmpl->rxq.mr_ctrl,
+					&priv->sh->cdev->mr_scache.dev_gen, dev->device->numa_node);
+		if (ret == -ENOMEM) {
+			ret = mlx5_mr_ctrl_init(&tmpl->rxq.mr_ctrl,
+						&priv->sh->cdev->mr_scache.dev_gen, SOCKET_ID_ANY);
+		}
+		if (ret)
+			/* rte_errno is already set. */
+			goto error;
 	}
-	tmpl->socket = socket;
+	tmpl->socket = (socket == (unsigned int)SOCKET_ID_ANY ?
+			(unsigned int)dev->device->numa_node : socket);
 	if (dev->data->dev_conf.intr_conf.rxq)
 		tmpl->irq = 1;
 	if (mprq_en) {
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 644927c19c9..3aa7d01ee2e 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -64,8 +64,8 @@ mlx5_txq_start(struct rte_eth_dev *dev)
 		if (!txq_ctrl->is_hairpin)
 			txq_alloc_elts(txq_ctrl);
 		MLX5_ASSERT(!txq_ctrl->obj);
-		txq_ctrl->obj = mlx5_malloc(flags, sizeof(struct mlx5_txq_obj),
-					    0, txq_ctrl->socket);
+		txq_ctrl->obj = mlx5_malloc_numa_tolerant(flags, sizeof(struct mlx5_txq_obj),
+							  0, txq_ctrl->socket);
 		if (!txq_ctrl->obj) {
 			DRV_LOG(ERR, "Port %u Tx queue %u cannot allocate "
 				"memory resources.", dev->data->port_id,
@@ -82,9 +82,9 @@ mlx5_txq_start(struct rte_eth_dev *dev)
 		if (!txq_ctrl->is_hairpin) {
 			size_t size = txq_data->cqe_s * sizeof(*txq_data->fcqs);
 
-			txq_data->fcqs = mlx5_malloc(flags, size,
-						     RTE_CACHE_LINE_SIZE,
-						     txq_ctrl->socket);
+			txq_data->fcqs = mlx5_malloc_numa_tolerant(flags, size,
+								   RTE_CACHE_LINE_SIZE,
+								   txq_ctrl->socket);
 			if (!txq_data->fcqs) {
 				DRV_LOG(ERR, "Port %u Tx queue %u cannot "
 					"allocate memory (FCQ).",
@@ -182,9 +182,9 @@ mlx5_rxq_ctrl_prepare(struct rte_eth_dev *dev, struct mlx5_rxq_ctrl *rxq_ctrl,
 			return ret;
 	}
 	MLX5_ASSERT(!rxq_ctrl->obj);
-	rxq_ctrl->obj = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO,
-				    sizeof(*rxq_ctrl->obj), 0,
-				    rxq_ctrl->socket);
+	rxq_ctrl->obj = mlx5_malloc_numa_tolerant(MLX5_MEM_RTE | MLX5_MEM_ZERO,
+						  sizeof(*rxq_ctrl->obj), 0,
+						  rxq_ctrl->socket);
 	if (!rxq_ctrl->obj) {
 		DRV_LOG(ERR, "Port %u Rx queue %u can't allocate resources.",
 			dev->data->port_id, idx);
diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index 5fee5bc4e87..5db12f5c645 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -1052,26 +1052,45 @@ struct mlx5_txq_ctrl *
 mlx5_txq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 	     unsigned int socket, const struct rte_eth_txconf *conf)
 {
+	int ret;
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_txq_ctrl *tmpl;
 	uint16_t max_wqe;
 
-	tmpl = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO, sizeof(*tmpl) +
+	if (socket != (unsigned int)SOCKET_ID_ANY) {
+		tmpl = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO, sizeof(*tmpl) +
 			   desc * sizeof(struct rte_mbuf *), 0, socket);
+	} else {
+		tmpl = mlx5_malloc_numa_tolerant(MLX5_MEM_RTE | MLX5_MEM_ZERO, sizeof(*tmpl) +
+					 desc * sizeof(struct rte_mbuf *), 0,
+					 dev->device->numa_node);
+	}
 	if (!tmpl) {
 		rte_errno = ENOMEM;
 		return NULL;
 	}
-	if (mlx5_mr_ctrl_init(&tmpl->txq.mr_ctrl,
-			      &priv->sh->cdev->mr_scache.dev_gen, socket)) {
-		/* rte_errno is already set. */
-		goto error;
+	if (socket != (unsigned int)SOCKET_ID_ANY) {
+		if (mlx5_mr_ctrl_init(&tmpl->txq.mr_ctrl,
+					&priv->sh->cdev->mr_scache.dev_gen, socket))
+			/* rte_errno is already set. */
+			goto error;
+	} else {
+		ret = mlx5_mr_ctrl_init(&tmpl->txq.mr_ctrl,
+					&priv->sh->cdev->mr_scache.dev_gen, dev->device->numa_node);
+		if (ret == -ENOMEM) {
+			ret = mlx5_mr_ctrl_init(&tmpl->txq.mr_ctrl,
+						&priv->sh->cdev->mr_scache.dev_gen, SOCKET_ID_ANY);
+		}
+		if (ret)
+			/* rte_errno is already set. */
+			goto error;
 	}
 	MLX5_ASSERT(desc > MLX5_TX_COMP_THRESH);
 	tmpl->txq.offloads = conf->offloads |
 			     dev->data->dev_conf.txmode.offloads;
 	tmpl->priv = priv;
-	tmpl->socket = socket;
+	tmpl->socket = (socket == (unsigned int)SOCKET_ID_ANY ?
+			(unsigned int)dev->device->numa_node : socket);
 	tmpl->txq.elts_n = log2above(desc);
 	tmpl->txq.elts_s = desc;
 	tmpl->txq.elts_m = desc - 1;
diff --git a/drivers/net/mlx5/mlx5_utils.c b/drivers/net/mlx5/mlx5_utils.c
index 1503cacf387..3352195fa18 100644
--- a/drivers/net/mlx5/mlx5_utils.c
+++ b/drivers/net/mlx5/mlx5_utils.c
@@ -10,6 +10,29 @@
 
 /********************* Indexed pool **********************/
 
+#if defined(RTE_TOOLCHAIN_GCC) || defined(RTE_TOOLCHAIN_CLANG)
+#define pool_malloc(pool, flags, size, align, socket) (__extension__ ({				\
+	struct mlx5_indexed_pool *p = (struct mlx5_indexed_pool *)(pool);			\
+	uint32_t f = (uint32_t)(flags);								\
+	size_t s = (size_t)(size);								\
+	uint32_t a = (uint32_t)(align);								\
+	int so = (int)(socket);									\
+	void *mem = p->cfg.malloc(f, s, a, so);							\
+	if (mem == NULL && so != SOCKET_ID_ANY) {					\
+		mem = p->cfg.malloc(f, s, a, SOCKET_ID_ANY);					\
+		if (mem) {									\
+			DRV_LOG(WARNING,							\
+			"Allocated %p (size %zu socket %d) through NUMA tolerant fallback",	\
+			mem, s, so);								\
+		}										\
+	}											\
+	mem;											\
+}))
+#else
+#define pool_malloc(pool, flags, size, align, socket)
+	(pool)->cfg.malloc((uint32_t)(flags) | NUMA_TOLERANT, (size), (align), (socket));
+#endif
+
 int mlx5_logtype_ipool;
 
 /* Initialize driver log type. */
@@ -149,7 +172,7 @@ mlx5_ipool_grow(struct mlx5_indexed_pool *pool)
 		int n_grow = pool->n_trunk_valid ? pool->n_trunk :
 			     RTE_CACHE_LINE_SIZE / sizeof(void *);
 
-		p = pool->cfg.malloc(0, (pool->n_trunk_valid + n_grow) *
+		p = pool_malloc(pool, MLX5_MEM_ZERO, (pool->n_trunk_valid + n_grow) *
 				     sizeof(struct mlx5_indexed_trunk *),
 				     RTE_CACHE_LINE_SIZE, rte_socket_id());
 		if (!p)
@@ -179,7 +202,7 @@ mlx5_ipool_grow(struct mlx5_indexed_pool *pool)
 	/* rte_bitmap requires memory cacheline aligned. */
 	trunk_size += RTE_CACHE_LINE_ROUNDUP(data_size * pool->cfg.size);
 	trunk_size += bmp_size;
-	trunk = pool->cfg.malloc(0, trunk_size,
+	trunk = pool_malloc(pool, MLX5_MEM_ZERO, trunk_size,
 				 RTE_CACHE_LINE_SIZE, rte_socket_id());
 	if (!trunk)
 		return -ENOMEM;
@@ -253,9 +276,10 @@ mlx5_ipool_grow_bmp(struct mlx5_indexed_pool *pool, uint32_t new_size)
 	pool->cache_validator.bmp_size = new_size;
 	bmp_mem_size = rte_bitmap_get_memory_footprint(new_size);
 
-	pool->cache_validator.bmp_mem = pool->cfg.malloc(MLX5_MEM_ZERO, bmp_mem_size,
-										RTE_CACHE_LINE_SIZE,
-										rte_socket_id());
+	pool->cache_validator.bmp_mem = pool_malloc(pool, MLX5_MEM_ZERO,
+							 bmp_mem_size,
+							 RTE_CACHE_LINE_SIZE,
+							 rte_socket_id());
 	if (unlikely(!pool->cache_validator.bmp_mem)) {
 		DRV_LOG_IPOOL(ERR, "Unable to allocate memory for a new bitmap");
 		return;
@@ -343,7 +367,7 @@ mlx5_ipool_allocate_from_global(struct mlx5_indexed_pool *pool, int cidx)
 			     RTE_CACHE_LINE_SIZE / sizeof(void *);
 		cur_max_idx = mlx5_trunk_idx_offset_get(pool, trunk_n + n_grow);
 		/* Resize the trunk array. */
-		p = pool->cfg.malloc(0, ((trunk_idx + n_grow) *
+		p = pool_malloc(pool, MLX5_MEM_ZERO, ((trunk_idx + n_grow) *
 			sizeof(struct mlx5_indexed_trunk *)) +
 			(cur_max_idx * sizeof(uint32_t)) + sizeof(*p),
 			RTE_CACHE_LINE_SIZE, rte_socket_id());
@@ -365,7 +389,7 @@ mlx5_ipool_allocate_from_global(struct mlx5_indexed_pool *pool, int cidx)
 	trunk_size = sizeof(*trunk);
 	data_size = mlx5_trunk_size_get(pool, trunk_idx);
 	trunk_size += RTE_CACHE_LINE_ROUNDUP(data_size * pool->cfg.size);
-	trunk = pool->cfg.malloc(0, trunk_size,
+	trunk = pool_malloc(pool, MLX5_MEM_ZERO, trunk_size,
 				 RTE_CACHE_LINE_SIZE, rte_socket_id());
 	if (unlikely(!trunk)) {
 		pool->cfg.free(p);
@@ -429,7 +453,7 @@ _mlx5_ipool_get_cache(struct mlx5_indexed_pool *pool, int cidx, uint32_t idx)
 
 	MLX5_ASSERT(idx);
 	if (unlikely(!pool->cache[cidx])) {
-		pool->cache[cidx] = pool->cfg.malloc(MLX5_MEM_ZERO,
+		pool->cache[cidx] = pool_malloc(pool, MLX5_MEM_ZERO,
 			sizeof(struct mlx5_ipool_per_lcore) +
 			(pool->cfg.per_core_cache * sizeof(uint32_t)),
 			RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
@@ -515,7 +539,7 @@ _mlx5_ipool_malloc_cache(struct mlx5_indexed_pool *pool, int cidx,
 			 uint32_t *idx)
 {
 	if (unlikely(!pool->cache[cidx])) {
-		pool->cache[cidx] = pool->cfg.malloc(MLX5_MEM_ZERO,
+		pool->cache[cidx] = pool_malloc(pool, MLX5_MEM_ZERO,
 			sizeof(struct mlx5_ipool_per_lcore) +
 			(pool->cfg.per_core_cache * sizeof(uint32_t)),
 			RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
@@ -577,7 +601,7 @@ _mlx5_ipool_free_cache(struct mlx5_indexed_pool *pool, int cidx, uint32_t idx)
 	 * case check if local cache on core B was allocated before.
 	 */
 	if (unlikely(!pool->cache[cidx])) {
-		pool->cache[cidx] = pool->cfg.malloc(MLX5_MEM_ZERO,
+		pool->cache[cidx] = pool_malloc(pool, MLX5_MEM_ZERO,
 			sizeof(struct mlx5_ipool_per_lcore) +
 			(pool->cfg.per_core_cache * sizeof(uint32_t)),
 			RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
@@ -881,7 +905,7 @@ mlx5_ipool_flush_cache(struct mlx5_indexed_pool *pool)
 	/* Reset bmp. */
 	bmp_num = mlx5_trunk_idx_offset_get(pool, gc->n_trunk_valid);
 	mem_size = rte_bitmap_get_memory_footprint(bmp_num);
-	pool->bmp_mem = pool->cfg.malloc(MLX5_MEM_ZERO, mem_size,
+	pool->bmp_mem = pool_malloc(pool, MLX5_MEM_ZERO, mem_size,
 					 RTE_CACHE_LINE_SIZE, rte_socket_id());
 	if (!pool->bmp_mem) {
 		DRV_LOG(ERR, "Ipool bitmap mem allocate failed.\n");
-- 
2.21.0

