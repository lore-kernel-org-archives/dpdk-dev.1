Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43010C7115E
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 07:02:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B17A4279F;
	Thu, 19 Jun 2025 09:02:09 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
 by mails.dpdk.org (Postfix) with ESMTP id 720354025E
 for <dev@dpdk.org>; Thu, 19 Jun 2025 09:02:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txpsbVUyfA0KxGuLazSyFrk4EgAqwvDK/0SrBGWqyAnowqe+rWyh5SoRgsgQ59a6ZJ17glbvmn53v+07klmDfXy2EpR478fIeykqXECdH4OskFxFcJCM/DwOZ/eFQqOL+Qtj+Ag07x2/OaIArC6QkoPocSi+JvggT/2EQ3oICBg2hl3tXxvEAuLal8cDNWEKHDrdlRVVMzyj48+IgqUoOxpGaeE/H7Pra2fFh7mFtgNrZmUyqQHYiHRe+1rHIEwr9fk/t/9zlDRyJxCd360WnN2B58Ya3/9to5ebHJ8w8EO/yRi3185ehtF6zkM56iKhZ6XE5Gs5krSmhHPK89Gs9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jf9DeNLkuGw670KHNYxNmLMR3jHqy4OhU+6BT5FUo3Q=;
 b=IWZKKscCsZZVEnOCTXpmHAM5cctOE1jxicxTMyXJ/uPjB+O0nfIrY23FSionJCP8thcjFa+XLGfscWINghK4IiiFPLTWSzasLacJcG88bww1anBctzTXAbvHJNnZoVv3BAxtHjwI+/f1KJm/phMou4okWPrnqJuyiTSbiOJdOzH2L/aXMSPZtuw2exLrOthC6Ap+F3RPN2/kJtNWGv2KBuoYljEVbGpAPnQnvpMp1ltCpB6xbnf7v3+9oU46gKqrb9RMYCJ3NrHw2i2fah0zDYjT7l/4s3aMtpT3opOoFnAlTigK4voUDoUATUTQvuVzqwjcP/bc477yTOea0tXnBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jf9DeNLkuGw670KHNYxNmLMR3jHqy4OhU+6BT5FUo3Q=;
 b=rNqwHZnVPegz7GLDkHiKQp8U7ZFClbxnpFWaoC6w7xtmx7Wu0SQpid2hbwieSHD9t28qaOA3w2NXYBQJ5iWWRUQWwVlsKfhp4tANdJ6u67HrZcQR/RRfyaFdO4JocvPZjQ05fmKgPtWK9yCuY0B67N/O/JFsCGeR8pMLMBnMTa0+NAFjL21Q195rFQrNDTw7BlG1/f9ldW8c7HCZk7P0txcA49/O+1eTsQJUwxn15bp9nUl4PxkuFTkp+XJOUKIhnnyjo0gjHGQUaWomApc4nEx2O9sPO9mWZjCFDcGHYsPD7k040NnJAZJ47ciksqExzAfl/7+ZbJ649Hw6LQvaew==
Received: from SA9P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::26)
 by CH2PR12MB9517.namprd12.prod.outlook.com (2603:10b6:610:27f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 07:01:56 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:26:cafe::fc) by SA9P223CA0021.outlook.office365.com
 (2603:10b6:806:26::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.30 via Frontend Transport; Thu,
 19 Jun 2025 07:01:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 07:01:56 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Jun
 2025 00:01:42 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 19 Jun
 2025 00:01:41 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 19 Jun 2025 00:01:38 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH] net/mlx5: mlx5 malloc NUMA fallback
Date: Thu, 19 Jun 2025 10:01:32 +0300
Message-ID: <20250619070132.35181-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|CH2PR12MB9517:EE_
X-MS-Office365-Filtering-Correlation-Id: 69335477-2c85-4923-bc7d-08ddaeff2dcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GPWrcpqbQ6HTV/t2HjXxRXRkTc+3fo7gcL6kMGhVQwrodwu+Ij5WAxxriVD8?=
 =?us-ascii?Q?8gYYT9AhvxW/oAFSRHkSftscVVIc0MHtWMvin7nKWn/4TrJiaXDEnKJRw+9n?=
 =?us-ascii?Q?tkMk8mXmSMkqWOdXyIE0kcpTerbf/6HcueII1AofhHa3iv46R9NjbwJBn3Eh?=
 =?us-ascii?Q?MsCean6ahMOQkQxi6Qt4VhVu4TK7CZFBhL1XNVr7YBGifib3bEgdE2LUvTNg?=
 =?us-ascii?Q?Ru4TfeRW0e/m4ORrV9K/djjiS+8ZDUetzOy5pPTAzf1mrvjEh/IgThV5n/9w?=
 =?us-ascii?Q?rUzBR6AJqVQIfg2f73D6LR+Q4amNws+59jYlgfjWeap1NOGzJePb+2/lWzjz?=
 =?us-ascii?Q?czEcjD56rTATyNLdowf5+GDG746PfBUK9q310h9Q57h+9KIaylZd0iqpFNLH?=
 =?us-ascii?Q?iAtyZ9Rn5SonOih6b2tMCnA80OT2TIlrwUtB+Q+gFXy3xV5IHyPgRwzTZcfD?=
 =?us-ascii?Q?k97AHUiDXSs1+JcTHSM1ukmTtgXwnKoE5p+wGfZZtlq5xtdTVV9YYX0qQwWX?=
 =?us-ascii?Q?Vosi6KXS+16Whq3AEUdZUS7pCdu0uzCRQ7vMRRwOFRSQ+8UsaAzk1VWC7ky/?=
 =?us-ascii?Q?w5NtjWw53svoEYOpiCvdxRy+4kl6ouxL0eJUMuz4SxtA+Z9H5Ve2V71WxCsl?=
 =?us-ascii?Q?Wltq6Y6UQyZjJXHt/fy9JNsHt08REYsayivPszgiakNHkA5TNAcsWvh5t20i?=
 =?us-ascii?Q?teubD+PrywFK1ZfH1F5NNwAqCodZg+S9X7tuBO8HJpbz2ek18/cPfysbFdQ4?=
 =?us-ascii?Q?jz46ZHs0aPciN1CuiF3xPahUo/dhserz+w709IUcEpO+5t3zWG75lpJZpklz?=
 =?us-ascii?Q?6pCJQkdX8lx7NCFpjnyiXBUAOs3nsr2ueSWDocAEdIBHuhNb6gVk42ikYRlz?=
 =?us-ascii?Q?gOYJ4WjY36nHCNduqxzu9/WnR7PisW4yUHnKVpSG2LaG05Uxfa9GUhcnkEV2?=
 =?us-ascii?Q?2tXABRZB2jgqdVi4YkgDXGSBdbzU1ei2O6JbS8HD9MxXs5JwGiUf9QpJguNz?=
 =?us-ascii?Q?50e08CcKFodlcv9efe81TICoofnJ28kcDU547QU4rj5YtL+9YwgGSGpkixKo?=
 =?us-ascii?Q?vqlIiEFDzqxGzEi+h5fqWModcqFYoe9c31O2vp3B/ZP8lxnruu56ls4j/BNP?=
 =?us-ascii?Q?jGLYqhHPQXdsyuA90NzzccKPyYLABKYvI17cXNxsgS1huBwcFOtifYs4tHrr?=
 =?us-ascii?Q?JJEBWRc+krR25Kaq1kEZpQf9RcoJdE5rN1o7S7iOg1IF3EPGKyvpyy7l5M6P?=
 =?us-ascii?Q?Lxg4SXejYSHSqXuC4WT3WNs4kZSgJ26QO6ofHDTKiceJiS3XHZ04RrBeJebm?=
 =?us-ascii?Q?VUzi7Q77qCaXGpovk7zuU2zwuM4GLF46oX8SQ1xY1WiDkzt3iBFCVF7JVmKd?=
 =?us-ascii?Q?d8wQWDEuRZQhLD7jWT3D3DjVgJrHkPQ15z1hHP/awgUaL1LxlQDuRH60uK6n?=
 =?us-ascii?Q?hnLqm3p+zDWsAD8x2qXPH1PdZFLCv7QErCV2x1xaH2JlFQGSO7H5tj4AjhOp?=
 =?us-ascii?Q?nmU6riKnMPxIi5zEiJmSlr3KqXgBEkZD+NVR?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 07:01:56.3295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69335477-2c85-4923-bc7d-08ddaeff2dcb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9517
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

If mlx5 malloc with specified socket failed,
malloc function would return an error.

Cross NUMA support means that when there is no
memory on the local NUMA, use other available
NUMA memory for port init and start.

To support cross NUMA,
added a flag to enable NUMA fallback to any NUMA.
Fallback will be enabled only if this flag is set.

Add a NUMA tolerant wraper to mlx5 malloc calls in
ipool and devx/memory region initializations
to support cross NUMA in device probing and port start stage.

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
---
 drivers/common/mlx5/mlx5_common_devx.c |  8 ++---
 drivers/common/mlx5/mlx5_common_mr.c   |  6 ++--
 drivers/common/mlx5/mlx5_devx_cmds.c   |  4 +--
 drivers/common/mlx5/mlx5_malloc.c      | 20 +++++++++--
 drivers/common/mlx5/mlx5_malloc.h      | 20 +++++++++++
 drivers/net/mlx5/mlx5.c                |  4 +--
 drivers/net/mlx5/mlx5_devx.c           |  6 ++--
 drivers/net/mlx5/mlx5_flow_hw.c        | 21 +++++++-----
 drivers/net/mlx5/mlx5_rxq.c            |  2 +-
 drivers/net/mlx5/mlx5_trigger.c        | 16 ++++-----
 drivers/net/mlx5/mlx5_txq.c            |  4 +--
 drivers/net/mlx5/mlx5_utils.c          | 46 ++++++++++++++++++++------
 12 files changed, 111 insertions(+), 46 deletions(-)

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
diff --git a/drivers/common/mlx5/mlx5_common_mr.c b/drivers/common/mlx5/mlx5_common_mr.c
index c41ffff2d5a..62cbc9bc001 100644
--- a/drivers/common/mlx5/mlx5_common_mr.c
+++ b/drivers/common/mlx5/mlx5_common_mr.c
@@ -225,9 +225,9 @@ mlx5_mr_btree_init(struct mlx5_mr_btree *bt, int n, int socket)
 	}
 	MLX5_ASSERT(!bt->table && !bt->size);
 	memset(bt, 0, sizeof(*bt));
-	bt->table = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO,
-				sizeof(struct mr_cache_entry) * n,
-				0, socket);
+	bt->table = mlx5_malloc_numa_tolerant(MLX5_MEM_RTE | MLX5_MEM_ZERO,
+					      sizeof(struct mr_cache_entry) * n,
+					      0, socket);
 	if (bt->table == NULL) {
 		rte_errno = ENOMEM;
 		DRV_LOG(DEBUG,
diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c b/drivers/common/mlx5/mlx5_devx_cmds.c
index 39a4298b58c..15ca63fba9f 100644
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
index d56b4fb5a89..159182ee3cd 100644
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
@@ -181,9 +188,18 @@ mlx5_malloc(uint32_t flags, size_t size, unsigned int align, int socket)
 		rte_mem = mlx5_sys_mem.enable ? false : true;
 	if (rte_mem) {
 		if (flags & MLX5_MEM_ZERO)
-			addr = rte_zmalloc_socket(NULL, size, align, socket);
+			addr = mlx5_malloc_socket_internal(size, align, socket, true);
 		else
-			addr = rte_malloc_socket(NULL, size, align, socket);
+			addr = mlx5_malloc_socket_internal(size, align, socket, false);
+		if (addr == NULL && socket != SOCKET_ID_ANY && (flags & MLX5_NUMA_TOLERANT)) {
+			size_t alloc_size = size;
+			addr = mlx5_malloc_socket_internal(size, align, SOCKET_ID_ANY,
+				!!(flags & MLX5_MEM_ZERO));
+			if (addr) {
+				(DRV_LOG(WARNING, "Allocated %p (size %zu socket %d) through NUMA tolerant fallback",
+					(addr), (alloc_size), (socket)));
+			}
+		}
 		mlx5_mem_update_msl(addr);
 #ifdef RTE_LIBRTE_MLX5_DEBUG
 		if (addr)
diff --git a/drivers/common/mlx5/mlx5_malloc.h b/drivers/common/mlx5/mlx5_malloc.h
index 9086a4f3f22..545a1124c24 100644
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
+		if (mem == NULL) {								\
+			mem = mlx5_malloc((uint32_t)(flags), (size_t)(size),			\
+					  (align), SOCKET_ID_ANY);				\
+			if (mem != NULL) {							\
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
index 9711746edba..41e4142c1f8 100644
--- a/drivers/net/mlx5/mlx5_devx.c
+++ b/drivers/net/mlx5/mlx5_devx.c
@@ -1095,14 +1095,14 @@ mlx5_rxq_devx_obj_drop_create(struct rte_eth_dev *dev)
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
@@ -1110,7 +1110,7 @@ mlx5_rxq_devx_obj_drop_create(struct rte_eth_dev *dev)
 		rte_errno = ENOMEM;
 		goto error;
 	}
-	rxq_obj = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*rxq_obj), 0, socket_id);
+	rxq_obj = mlx5_malloc_numa_tolerant(MLX5_MEM_ZERO, sizeof(*rxq_obj), 0, socket_id);
 	if (rxq_obj == NULL) {
 		DRV_LOG(ERR, "Port %u could not allocate drop queue object",
 			dev->data->port_id);
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index e26093522fb..c6e732df77f 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -5069,7 +5069,8 @@ flow_hw_table_create(struct rte_eth_dev *dev,
 	tbl_mem_size = sizeof(*tbl);
 	tbl_mem_size += nb_action_templates * priv->nb_queue * sizeof(tbl->rule_acts[0]);
 	/* Allocate the table memory. */
-	tbl = mlx5_malloc(MLX5_MEM_ZERO, tbl_mem_size, RTE_CACHE_LINE_SIZE, rte_socket_id());
+	tbl = mlx5_malloc_numa_tolerant(MLX5_MEM_ZERO, tbl_mem_size,
+					RTE_CACHE_LINE_SIZE, rte_socket_id());
 	if (!tbl)
 		goto error;
 	tbl->cfg = *table_cfg;
@@ -5078,8 +5079,10 @@ flow_hw_table_create(struct rte_eth_dev *dev,
 	if (!tbl->flow)
 		goto error;
 	/* Allocate table of auxiliary flow rule structs. */
-	tbl->flow_aux = mlx5_malloc(MLX5_MEM_ZERO, sizeof(struct rte_flow_hw_aux) * nb_flows,
-				    RTE_CACHE_LINE_SIZE, rte_dev_numa_node(dev->device));
+	tbl->flow_aux = mlx5_malloc_numa_tolerant(MLX5_MEM_ZERO,
+						  sizeof(struct rte_flow_hw_aux) * nb_flows,
+						  RTE_CACHE_LINE_SIZE,
+						  rte_dev_numa_node(dev->device));
 	if (!tbl->flow_aux)
 		goto error;
 	/* Register the flow group. */
@@ -8031,7 +8034,7 @@ __flow_hw_actions_template_create(struct rte_eth_dev *dev,
 	if (orig_act_len <= 0)
 		return NULL;
 	len += RTE_ALIGN(orig_act_len, 16);
-	at = mlx5_malloc(MLX5_MEM_ZERO, len + sizeof(*at),
+	at = mlx5_malloc_numa_tolerant(MLX5_MEM_ZERO, len + sizeof(*at),
 			 RTE_CACHE_LINE_SIZE, rte_socket_id());
 	if (!at) {
 		rte_flow_error_set(error, ENOMEM,
@@ -8200,7 +8203,7 @@ flow_hw_prepend_item(const struct rte_flow_item *items,
 
 	/* Allocate new array of items. */
 	size = sizeof(*copied_items) * (nb_items + 1);
-	copied_items = mlx5_malloc(MLX5_MEM_ZERO, size, 0, rte_socket_id());
+	copied_items = mlx5_malloc_numa_tolerant(MLX5_MEM_ZERO, size, 0, rte_socket_id());
 	if (!copied_items) {
 		rte_flow_error_set(error, ENOMEM,
 				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
@@ -9017,7 +9020,7 @@ flow_hw_pattern_template_create(struct rte_eth_dev *dev,
 		tmpl_items = items;
 	}
 setup_pattern_template:
-	it = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*it), 0, rte_socket_id());
+	it = mlx5_malloc_numa_tolerant(MLX5_MEM_ZERO, sizeof(*it), 0, rte_socket_id());
 	if (!it) {
 		rte_flow_error_set(error, ENOMEM,
 				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
@@ -9037,7 +9040,8 @@ flow_hw_pattern_template_create(struct rte_eth_dev *dev,
 		goto error;
 	}
 	it_items_size = RTE_ALIGN(it_items_size, 16);
-	it->items = mlx5_malloc(MLX5_MEM_ZERO, it_items_size, 0, rte_dev_numa_node(dev->device));
+	it->items = mlx5_malloc_numa_tolerant(MLX5_MEM_ZERO, it_items_size, 0,
+				rte_dev_numa_node(dev->device));
 	if (it->items == NULL) {
 		rte_flow_error_set(error, ENOMEM,
 				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
@@ -11441,7 +11445,8 @@ flow_hw_create_ctrl_rx_tables(struct rte_eth_dev *dev)
 	int ret;
 
 	MLX5_ASSERT(!priv->hw_ctrl_rx);
-	priv->hw_ctrl_rx = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*priv->hw_ctrl_rx),
+	priv->hw_ctrl_rx = mlx5_malloc_numa_tolerant(MLX5_MEM_ZERO,
+				       sizeof(*priv->hw_ctrl_rx),
 				       RTE_CACHE_LINE_SIZE, rte_socket_id());
 	if (!priv->hw_ctrl_rx) {
 		DRV_LOG(ERR, "Failed to allocate memory for Rx control flow tables");
diff --git a/drivers/net/mlx5/mlx5_rxq.c b/drivers/net/mlx5/mlx5_rxq.c
index b676e5394b0..628af59fcc7 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -1793,7 +1793,7 @@ mlx5_rxq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 		desc >>= mprq_log_actual_stride_num;
 		alloc_size += desc * sizeof(struct mlx5_mprq_buf *);
 	}
-	tmpl = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO, alloc_size, 0, socket);
+	tmpl = mlx5_malloc_numa_tolerant(MLX5_MEM_RTE | MLX5_MEM_ZERO, alloc_size, 0, socket);
 	if (!tmpl) {
 		rte_errno = ENOMEM;
 		return NULL;
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 485984f9b06..f33cd86e609 100644
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
index 5fee5bc4e87..fd9c477aa9f 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -1056,8 +1056,8 @@ mlx5_txq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 	struct mlx5_txq_ctrl *tmpl;
 	uint16_t max_wqe;
 
-	tmpl = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO, sizeof(*tmpl) +
-			   desc * sizeof(struct rte_mbuf *), 0, socket);
+	tmpl = mlx5_malloc_numa_tolerant(MLX5_MEM_RTE | MLX5_MEM_ZERO, sizeof(*tmpl) +
+					 desc * sizeof(struct rte_mbuf *), 0, socket);
 	if (!tmpl) {
 		rte_errno = ENOMEM;
 		return NULL;
diff --git a/drivers/net/mlx5/mlx5_utils.c b/drivers/net/mlx5/mlx5_utils.c
index f8cd7bc0439..5752efa108f 100644
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
+	if (mem == NULL) {									\
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

