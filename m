Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B332C77B7C
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 18:35:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B26D40676;
	Mon, 23 Jun 2025 20:35:49 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by mails.dpdk.org (Postfix) with ESMTP id B8B3F40669
 for <dev@dpdk.org>; Mon, 23 Jun 2025 20:35:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iaq/1/Avv3XK38q4a/K2s4CS6PDw2APO/pzafIq/vi+uhRxSgBWD1TXxa0BCIMORlCFrkGsA8MUQHIZIsHm3AhqSwpjB9htCaagi9a/4mQ5jrX9aD6U5ZTkKSw6uKUqMGwpOhBtwZAz9C/c9Mf4Lo2lVCSDgwnJs6QyE+Tn06OH/sS1p+Prm0RFF//e0JoINyP2BE9pDEyVzyGiMJ1cq8k88b64gOS6P3t1y/6caelSVXVMX6AUdTmUzOe6Y28t/8nPEr8P9UhAvAtkuOIEYW6R2+H/Sxs6bCPJQ1L6d1Qij+dEG+p7qO4V8psBs0+wwUghjprEFGRsRf1L2phOVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUxfHHhOTtZHwWsO977HoKR/UDJrdrNmWeIY4dcAvRY=;
 b=PBa5+UmZLKT5Vye+9RYyf4B39rQle4P17J6aJsfrbJuMGfJP1uz9B3qTTnS0POYm/9KixclSDe5+gHoVJSRMOK4NPzR7v0ifSARVpelEM2JcjOtQvzOj6x2ftAXF4nCea+prpqXUWIxnTl67XBgKvqXbc0qMxBT038dpXFJxLeWq1g4P+d9Q+n9H1cExlwcfThFsXyFUfbU2YkghoIbJIRk/dNpD/b80NIZ3cw9IqCNefre0wrsxU2oToSqJ9dtUNpxw3wzc6ZKckc1HhCG5j5HspTD1A5ULEQqP+Ab7pI59QVrRp3lXewX5kDtW3b8lt1CVaDwyXUK8PXBPMhHt/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUxfHHhOTtZHwWsO977HoKR/UDJrdrNmWeIY4dcAvRY=;
 b=QTwBeOcN0Y4jrHWDb6zNiFA3E8SM1TD5sbPf+J5tHoVDCkDZ4B6nJgmGgJdAjq01KRcjOn+g4p5a4bHKGJwPGMQ0DkzB/u9h7CEyGXUA909HstnbMd6ozd0wkgmIHFukLasenM50pVvBzkNt5Mv35Mrh4hYEVqSSXe43mL1OPQS6gE+2Y+hE7FmBC2DZIuOPk2YsIEoM91LXAOqghXn9Zy9YnGJfI/OY4bwY2lTpcdmfPZ+4bRNtZHXEtGUdIySYv67Ec+SS1gG3+IgV54SmYk9WJik3m79oBZ5S7521lEzFK02K86hVMTZYhPPgCc3tQRfX3jix11OMk4VkbD3N6A==
Received: from CH0PR04CA0027.namprd04.prod.outlook.com (2603:10b6:610:76::32)
 by IA1PR12MB7661.namprd12.prod.outlook.com (2603:10b6:208:426::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Mon, 23 Jun
 2025 18:35:39 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::b4) by CH0PR04CA0027.outlook.office365.com
 (2603:10b6:610:76::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Mon,
 23 Jun 2025 18:35:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 18:35:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 23 Jun
 2025 11:35:24 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 23 Jun
 2025 11:35:22 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <matan@nvidia.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <dsosnowski@nvidia.com>,
 <suanmingm@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH v2 3/3] net/mlx5: use consecutive memory for all Tx queues
Date: Mon, 23 Jun 2025 21:34:56 +0300
Message-ID: <20250623183456.130666-4-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623183456.130666-1-bingz@nvidia.com>
References: <20250623173524.128125-1:x-bingz@nvidia.com>
 <20250623183456.130666-1-bingz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|IA1PR12MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: dd01174a-d3a0-4365-57e7-08ddb284c0c2
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VCU3MLojW61+9q/9UM+R21H+Ae+ZpoMGBa2R9eEF7yOm4ElKyhfBf6Fv/EdT?=
 =?us-ascii?Q?N/HvsbbzffN4s8dVVFRISFM/Ig2GIKHkyD3lVemluunDLNbbT/KUQartlIXF?=
 =?us-ascii?Q?iP1L3nV+3r6PWO3a7/oOTOyf2bH+MRVtm+ktbVdvXWSRF/ZKO1jSTuaV/CPh?=
 =?us-ascii?Q?SWzXtp4GoXqhrU1KMYSuAuAZS9N4JlRfrZEnY3jKDcDC44SJY+0UFmfWdNmO?=
 =?us-ascii?Q?GWyF3riJM33lTES/CERoXef4GZjkFJ9CpVJw5p2W8ZhUjrZAowBYcQCKJ8GB?=
 =?us-ascii?Q?sX896ZBFzqGzJsQt0HqXzsgsNkoIJqJXmmMYq41dUBiZYc1V1PfhWEKYmjGJ?=
 =?us-ascii?Q?3fRaXlhE/eQkSGVn1bWxzOyv9GjSStlN/oUoOusf/s7vAKmrhFa0WesSyaBz?=
 =?us-ascii?Q?54erL4TQSF8xKeNbEOfhn8f3xUx24ScgSBnepcvPTHwd8aXSwtoHUi7b5Zo6?=
 =?us-ascii?Q?mdDUTLerWT8qNUXheoxn9x7BsmIF+vi8jTmQH+zfZm8xE7z3qR0FMuXUiD4E?=
 =?us-ascii?Q?LrLqeYHB3YViv9I0KfsgQ83CR1y3b+a7/5YXZN2IF0zBNy+r9CUhd15LQbiu?=
 =?us-ascii?Q?P2NywTu6CzkWHfhsb4zcIuwXrlW4ycQdtAwljXW9vFKOt0hCILGGwshcWoJH?=
 =?us-ascii?Q?PrsBhW8+yIY8qLXdSS/zwd0mlmf8eCZ3oqqvkUsxEbJ67+rBSRKL9MXPwYn6?=
 =?us-ascii?Q?1NGRd3V68+OwCk0871rIoWPXQaMXMcJJXzyArMkgnIuHihZlEOh/EO1eOr+u?=
 =?us-ascii?Q?lyWO+b4Gf+i6pLFHTLuJ4yv+R8M/jLaCG98ozCPox7kTNoOEoaAgj9KM81mK?=
 =?us-ascii?Q?aNhIPZ3+ykoo1ARQXoLBgmsLNKqF6OmakwE1Pcen1sNz5JaS3MfaECTXNMGb?=
 =?us-ascii?Q?nAj72md+aoQZdeOBYmEF8XBdQiD8LEpGbmVz2wqFXYR2L9Rom42tHgyHnLdZ?=
 =?us-ascii?Q?UruELXmBEF7Uzjl2jLffpuuRlPjVPmy3fNotMcssIu0d1a7X2KdXet0UyNHB?=
 =?us-ascii?Q?2EFFM9rK+hAtFubYkspnRqXUBUf4GvXo+mN1KYqwd672RWIbLAhC7L7IuFTD?=
 =?us-ascii?Q?R6iBkFe6sPWtcIhMQ9MoK5jk4ICcmHqUVCi8nwyG7XhRH/eEaBwiknc4zJ4R?=
 =?us-ascii?Q?SKk7DRaFnr/PvJucZz+VYThk4bApnQhPrHKnitcTFISocHqleU+0M8hk2GZt?=
 =?us-ascii?Q?+hOxER2MTahvnzOSa+L8MEZCeKZCA/4ZREVQTMHB3QR/9kENar+7baMRNzGY?=
 =?us-ascii?Q?rdHJgACbusKj3QC38fsUUggPZTwYHxWLbaEAN2rhYoTCETX6lGmVXyLbyUxb?=
 =?us-ascii?Q?Xv7mNtp0uA1IqTjwZsLTVFdsEBio8PdO9+Robe6gfy5khaENo25jPbxZFgzy?=
 =?us-ascii?Q?WazalsDcjDbpj5d+T9WtSrEXv0AC3lREzMjuyvfvY+ZgfV7CV/HfrW26iJsR?=
 =?us-ascii?Q?zl0nIXYltJU42aBGjJMpvpHpq4yFi60vJMmsWQSXzmFV2nu/s3SRju/v+CQP?=
 =?us-ascii?Q?fCPUvO32N68pW2jmIJ7m0l29GJ3nAtFeYF8G?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 18:35:39.4190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd01174a-d3a0-4365-57e7-08ddb284c0c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7661
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

High cache miss rate may impact the software performance
significantly. Usually, the cache misses are caused by the
conflict and then some eviction may happen.

Now in the mlx5 PMD, the Tx queues are created separately, that
means the memory footprints may differ due to the different
configurations. In some case, the cache miss rate will be higher
than other cases and cause a performance drop in the software. And
it will be very hard to make the traffic generating rate stable
enough.

In practice, accessing linear and consecutive memory addresses will
reduce the conflicts significantly. This will make the Tx performance
more stable.

Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/common/mlx5/mlx5_common.h      |  2 +
 drivers/common/mlx5/mlx5_common_devx.c | 77 +++++++++++++++++---------
 drivers/common/mlx5/mlx5_common_devx.h |  2 +-
 drivers/common/mlx5/mlx5_devx_cmds.h   |  5 ++
 drivers/net/mlx5/hws/mlx5dr_internal.h |  1 -
 drivers/net/mlx5/mlx5.h                |  8 ++-
 drivers/net/mlx5/mlx5_devx.c           | 34 ++++++++++--
 drivers/net/mlx5/mlx5_flow_aso.c       |  2 +-
 drivers/net/mlx5/mlx5_trigger.c        | 56 +++++++++++++++++++
 drivers/net/mlx5/mlx5_tx.h             |  2 +
 drivers/net/mlx5/mlx5_txpp.c           |  2 +-
 drivers/net/mlx5/mlx5_txq.c            | 18 +++++-
 12 files changed, 171 insertions(+), 38 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_common.h b/drivers/common/mlx5/mlx5_common.h
index bea1382911..b952300cb4 100644
--- a/drivers/common/mlx5/mlx5_common.h
+++ b/drivers/common/mlx5/mlx5_common.h
@@ -46,6 +46,8 @@
 	!!(((bf)[((b) / (sizeof((bf)[0]) * CHAR_BIT))] & \
 		((size_t)1 << ((b) % (sizeof((bf)[0]) * CHAR_BIT)))))
 
+#define MLX5_ROUNDUP(x, y) ((((x) + ((y) - 1)) / (y)) * (y))
+
 /*
  * Helper macros to work around __VA_ARGS__ limitations in a C99 compliant
  * manner.
diff --git a/drivers/common/mlx5/mlx5_common_devx.c b/drivers/common/mlx5/mlx5_common_devx.c
index cd1292b92b..cfd495c304 100644
--- a/drivers/common/mlx5/mlx5_common_devx.c
+++ b/drivers/common/mlx5/mlx5_common_devx.c
@@ -167,10 +167,12 @@ mlx5_devx_cq_create(void *ctx, struct mlx5_devx_cq *cq_obj, uint16_t log_desc_n,
  */
 RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_sq_destroy)
 void
-mlx5_devx_sq_destroy(struct mlx5_devx_sq *sq)
+mlx5_devx_sq_destroy(struct mlx5_devx_sq *sq, bool consec_mem)
 {
 	if (sq->sq)
 		claim_zero(mlx5_devx_cmd_destroy(sq->sq));
+	if (consec_mem)
+		return;
 	if (sq->umem_obj)
 		claim_zero(mlx5_os_umem_dereg(sq->umem_obj));
 	if (sq->umem_buf)
@@ -220,38 +222,54 @@ mlx5_devx_sq_create(void *ctx, struct mlx5_devx_sq *sq_obj, uint16_t log_wqbb_n,
 	uint32_t umem_size, umem_dbrec;
 	uint32_t num_of_wqbbs = RTE_BIT32(log_wqbb_n);
 	int ret;
+	uint32_t wq_umem_id;
+	uint32_t wq_umem_offset;
 
 	if (alignment == (size_t)-1) {
 		DRV_LOG(ERR, "Failed to get WQE buf alignment.");
 		rte_errno = ENOMEM;
 		return -rte_errno;
 	}
-	/* Allocate memory buffer for WQEs and doorbell record. */
 	umem_size = MLX5_WQE_SIZE * num_of_wqbbs;
 	umem_dbrec = RTE_ALIGN(umem_size, MLX5_DBR_SIZE);
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
+	if (!attr->acc_mem) {
+		umem_size += MLX5_DBR_SIZE;
+		/* Allocate memory buffer for WQEs and doorbell record. */
+		umem_buf = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO, umem_size,
+				       alignment, socket);
+		if (!umem_buf) {
+			DRV_LOG(ERR, "Failed to allocate memory for SQ.");
+			rte_errno = ENOMEM;
+			return -rte_errno;
+		}
+		/* Register allocated buffer in user space with DevX. */
+		umem_obj = mlx5_os_umem_reg(ctx, (void *)(uintptr_t)umem_buf, umem_size,
+					    IBV_ACCESS_LOCAL_WRITE);
+		if (!umem_obj) {
+			DRV_LOG(ERR, "Failed to register umem for SQ.");
+			rte_errno = errno;
+			goto error;
+		}
+		wq_umem_id = mlx5_os_get_umem_id(umem_obj);
+		wq_umem_offset = 0;
+	} else {
+		if (umem_size != attr->len) {
+			DRV_LOG(ERR, "Mismatch between saved length and calc length");
+			rte_errno = EINVAL;
+			return -rte_errno;
+		}
+		umem_buf = attr->mem;
+		wq_umem_offset = attr->offset;
+		umem_dbrec = RTE_ALIGN((uintptr_t)wq_umem_offset + umem_size, MLX5_DBR_SIZE);
+		wq_umem_id = mlx5_os_get_umem_id(attr->umem_obj);
 	}
 	/* Fill attributes for SQ object creation. */
 	attr->wq_attr.wq_type = MLX5_WQ_TYPE_CYCLIC;
 	attr->wq_attr.wq_umem_valid = 1;
-	attr->wq_attr.wq_umem_id = mlx5_os_get_umem_id(umem_obj);
-	attr->wq_attr.wq_umem_offset = 0;
+	attr->wq_attr.wq_umem_id = wq_umem_id;
+	attr->wq_attr.wq_umem_offset = wq_umem_offset;
 	attr->wq_attr.dbr_umem_valid = 1;
-	attr->wq_attr.dbr_umem_id = attr->wq_attr.wq_umem_id;
+	attr->wq_attr.dbr_umem_id = wq_umem_id;
 	attr->wq_attr.dbr_addr = umem_dbrec;
 	attr->wq_attr.log_wq_stride = rte_log2_u32(MLX5_WQE_SIZE);
 	attr->wq_attr.log_wq_sz = log_wqbb_n;
@@ -263,17 +281,24 @@ mlx5_devx_sq_create(void *ctx, struct mlx5_devx_sq *sq_obj, uint16_t log_wqbb_n,
 		rte_errno = ENOMEM;
 		goto error;
 	}
-	sq_obj->umem_buf = umem_buf;
+	if (attr->acc_mem) {
+		sq_obj->umem_buf = RTE_PTR_ADD(umem_buf, attr->offset);
+		sq_obj->db_rec = RTE_PTR_ADD(umem_buf, umem_dbrec);
+	} else {
+		sq_obj->umem_buf = umem_buf;
+		sq_obj->db_rec = RTE_PTR_ADD(sq_obj->umem_buf, umem_dbrec);
+	}
 	sq_obj->umem_obj = umem_obj;
 	sq_obj->sq = sq;
-	sq_obj->db_rec = RTE_PTR_ADD(sq_obj->umem_buf, umem_dbrec);
 	return 0;
 error:
 	ret = rte_errno;
-	if (umem_obj)
-		claim_zero(mlx5_os_umem_dereg(umem_obj));
-	if (umem_buf)
-		mlx5_free((void *)(uintptr_t)umem_buf);
+	if (!attr->acc_mem) {
+		if (umem_obj)
+			claim_zero(mlx5_os_umem_dereg(umem_obj));
+		if (umem_buf)
+			mlx5_free((void *)(uintptr_t)umem_buf);
+	}
 	rte_errno = ret;
 	return -rte_errno;
 }
diff --git a/drivers/common/mlx5/mlx5_common_devx.h b/drivers/common/mlx5/mlx5_common_devx.h
index 743f06042c..060760ce1a 100644
--- a/drivers/common/mlx5/mlx5_common_devx.h
+++ b/drivers/common/mlx5/mlx5_common_devx.h
@@ -79,7 +79,7 @@ int mlx5_devx_cq_create(void *ctx, struct mlx5_devx_cq *cq_obj,
 			struct mlx5_devx_cq_attr *attr, int socket);
 
 __rte_internal
-void mlx5_devx_sq_destroy(struct mlx5_devx_sq *sq);
+void mlx5_devx_sq_destroy(struct mlx5_devx_sq *sq, bool consec_mem);
 
 __rte_internal
 int mlx5_devx_sq_create(void *ctx, struct mlx5_devx_sq *sq_obj,
diff --git a/drivers/common/mlx5/mlx5_devx_cmds.h b/drivers/common/mlx5/mlx5_devx_cmds.h
index 6c726a0d46..1438d539e4 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.h
+++ b/drivers/common/mlx5/mlx5_devx_cmds.h
@@ -483,6 +483,11 @@ struct mlx5_devx_create_sq_attr {
 	uint32_t packet_pacing_rate_limit_index:16;
 	uint32_t tis_lst_sz:16;
 	uint32_t tis_num:24;
+	bool acc_mem;
+	uint32_t offset;
+	void *mem;
+	void *umem_obj;
+	uint32_t len;
 	struct mlx5_devx_wq_attr wq_attr;
 };
 
diff --git a/drivers/net/mlx5/hws/mlx5dr_internal.h b/drivers/net/mlx5/hws/mlx5dr_internal.h
index 2abc516b5e..3f7fc37da8 100644
--- a/drivers/net/mlx5/hws/mlx5dr_internal.h
+++ b/drivers/net/mlx5/hws/mlx5dr_internal.h
@@ -61,7 +61,6 @@
 #define DR_LOG(level, ...) \
 	DRV_LOG(level, RTE_FMT("[%s]: " RTE_FMT_HEAD(__VA_ARGS__,), __func__, RTE_FMT_TAIL(__VA_ARGS__,)))
 #endif
-
 static inline void *simple_malloc(size_t size)
 {
 	return mlx5_malloc(MLX5_MEM_SYS,
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 4e0287cbc0..aa592bc96c 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -393,7 +393,7 @@ struct mlx5_sh_config {
 	/* Allow/Prevent the duplicate rules pattern. */
 	uint32_t fdb_def_rule:1; /* Create FDB default jump rule */
 	uint32_t repr_matching:1; /* Enable implicit vport matching in HWS FDB. */
-	uint32_t txq_consec_mem:1; /**/
+	uint32_t txq_consec_mem:1; /* Using consecutive memory. */
 };
 
 /* Structure for VF VLAN workaround. */
@@ -2131,6 +2131,12 @@ struct mlx5_priv {
 	struct mlx5_indexed_pool *ptype_rss_groups;
 #endif
 	struct rte_eth_dev *shared_host; /* Host device for HW steering. */
+	struct {
+		void *umem_obj;
+		void *mem;
+		uint32_t total_size;
+		uint32_t cur_off;
+	} acc_tx_wq_mem;
 	RTE_ATOMIC(uint16_t) shared_refcnt; /* HW steering host reference counter. */
 };
 
diff --git a/drivers/net/mlx5/mlx5_devx.c b/drivers/net/mlx5/mlx5_devx.c
index ab0de7eb0c..39ddf2e3b4 100644
--- a/drivers/net/mlx5/mlx5_devx.c
+++ b/drivers/net/mlx5/mlx5_devx.c
@@ -1444,11 +1444,13 @@ mlx5_txq_obj_hairpin_new(struct rte_eth_dev *dev, uint16_t idx)
  *
  * @param txq_obj
  *   Txq object to destroy.
+ * @param consec_mem
+ *   Txq is using consecutive memory space.
  */
 static void
-mlx5_txq_release_devx_resources(struct mlx5_txq_obj *txq_obj)
+mlx5_txq_release_devx_resources(struct mlx5_txq_obj *txq_obj, bool consec_mem)
 {
-	mlx5_devx_sq_destroy(&txq_obj->sq_obj);
+	mlx5_devx_sq_destroy(&txq_obj->sq_obj, consec_mem);
 	memset(&txq_obj->sq_obj, 0, sizeof(txq_obj->sq_obj));
 	mlx5_devx_cq_destroy(&txq_obj->cq_obj);
 	memset(&txq_obj->cq_obj, 0, sizeof(txq_obj->cq_obj));
@@ -1492,11 +1494,31 @@ mlx5_txq_create_devx_sq_resources(struct rte_eth_dev *dev, uint16_t idx,
 		.ts_format =
 			mlx5_ts_format_conv(cdev->config.hca_attr.sq_ts_format),
 		.tis_num = mlx5_get_txq_tis_num(dev, idx),
+		.acc_mem = false,
+		.offset = priv->acc_tx_wq_mem.cur_off,
+		.mem = (void *)priv->acc_tx_wq_mem.mem,
+		.umem_obj = priv->acc_tx_wq_mem.umem_obj,
+		.len = txq_data->sq_mem_len,
 	};
+	int ret;
+	uint32_t act_size = MLX5_ROUNDUP(RTE_ALIGN(txq_data->sq_mem_len, MLX5_DBR_SIZE) +
+					 MLX5_DBR_SIZE, MLX5_WQE_BUF_ALIGNMENT);
 
+	if (priv->sh->config.txq_consec_mem) {
+		sq_attr.acc_mem = true;
+		if ((priv->acc_tx_wq_mem.cur_off + act_size) > priv->acc_tx_wq_mem.total_size) {
+			DRV_LOG(ERR, "Failed to get enough memory room for Tx queue %u.", idx);
+			rte_errno = ENOMEM;
+			return -rte_errno;
+		}
+	}
 	/* Create Send Queue object with DevX. */
-	return mlx5_devx_sq_create(cdev->ctx, &txq_obj->sq_obj,
-				   log_desc_n, &sq_attr, priv->sh->numa_node);
+	ret = mlx5_devx_sq_create(cdev->ctx, &txq_obj->sq_obj,
+				  log_desc_n, &sq_attr, priv->sh->numa_node);
+	if (!ret)
+		priv->acc_tx_wq_mem.cur_off += act_size;
+	txq_ctrl->consec_mem = !!priv->sh->config.txq_consec_mem;
+	return ret;
 }
 #endif
 
@@ -1646,7 +1668,7 @@ mlx5_txq_devx_obj_new(struct rte_eth_dev *dev, uint16_t idx)
 	return 0;
 error:
 	ret = rte_errno; /* Save rte_errno before cleanup. */
-	mlx5_txq_release_devx_resources(txq_obj);
+	mlx5_txq_release_devx_resources(txq_obj, !!priv->sh->config.txq_consec_mem);
 	rte_errno = ret; /* Restore rte_errno. */
 	return -rte_errno;
 #endif
@@ -1679,7 +1701,7 @@ mlx5_txq_devx_obj_release(struct mlx5_txq_obj *txq_obj)
 		}
 #if defined(HAVE_MLX5DV_DEVX_UAR_OFFSET) || !defined(HAVE_INFINIBAND_VERBS_H)
 	} else {
-		mlx5_txq_release_devx_resources(txq_obj);
+		mlx5_txq_release_devx_resources(txq_obj, txq_obj->txq_ctrl->consec_mem);
 #endif
 	}
 }
diff --git a/drivers/net/mlx5/mlx5_flow_aso.c b/drivers/net/mlx5/mlx5_flow_aso.c
index feca8c3e89..da60acea42 100644
--- a/drivers/net/mlx5/mlx5_flow_aso.c
+++ b/drivers/net/mlx5/mlx5_flow_aso.c
@@ -77,7 +77,7 @@ mlx5_aso_reg_mr(struct mlx5_common_device *cdev, size_t length,
 void
 mlx5_aso_destroy_sq(struct mlx5_aso_sq *sq)
 {
-	mlx5_devx_sq_destroy(&sq->sq_obj);
+	mlx5_devx_sq_destroy(&sq->sq_obj, false);
 	mlx5_devx_cq_destroy(&sq->cq.cq_obj);
 	memset(sq, 0, sizeof(*sq));
 }
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 644927c19c..9714a7cf9e 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -10,6 +10,7 @@
 #include <rte_interrupts.h>
 #include <rte_alarm.h>
 #include <rte_cycles.h>
+#include <rte_eal_paging.h>
 
 #include <mlx5_malloc.h>
 
@@ -1135,6 +1136,53 @@ mlx5_hw_representor_port_allowed_start(struct rte_eth_dev *dev)
 
 #endif
 
+static int mlx5_dev_allocate_tx_sq_acc_mem(struct rte_eth_dev *dev)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+	size_t alignment = MLX5_WQE_BUF_ALIGNMENT;
+	struct mlx5dv_devx_umem *umem_obj = NULL;
+	void *umem_buf = NULL;
+
+	if (!priv->sh->config.txq_consec_mem)
+		return 0;
+	umem_buf = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO, priv->acc_tx_wq_mem.total_size,
+			       alignment, priv->sh->numa_node);
+	if (!umem_buf) {
+		DRV_LOG(ERR, "Failed to allocate consecutive memory for SQs.");
+		rte_errno = ENOMEM;
+		return -rte_errno;
+	}
+	umem_obj = mlx5_os_umem_reg(priv->sh->cdev->ctx, (void *)(uintptr_t)umem_buf,
+				    priv->acc_tx_wq_mem.total_size, IBV_ACCESS_LOCAL_WRITE);
+	if (!umem_obj) {
+		DRV_LOG(ERR, "Failed to register unique umem for all SQs.");
+		rte_errno = errno;
+		if (umem_buf)
+			mlx5_free(umem_buf);
+		return -rte_errno;
+	}
+	priv->acc_tx_wq_mem.mem = umem_buf;
+	priv->acc_tx_wq_mem.cur_off = 0;
+	priv->acc_tx_wq_mem.umem_obj = umem_obj;
+	return 0;
+}
+
+static void mlx5_dev_free_tx_sq_acc_mem(struct rte_eth_dev *dev)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+
+	if (!priv->sh->config.txq_consec_mem)
+		return;
+	if (priv->acc_tx_wq_mem.umem_obj) {
+		mlx5_os_umem_dereg(priv->acc_tx_wq_mem.umem_obj);
+		priv->acc_tx_wq_mem.umem_obj = NULL;
+	}
+	if (priv->acc_tx_wq_mem.mem) {
+		mlx5_free(priv->acc_tx_wq_mem.mem);
+		priv->acc_tx_wq_mem.mem = NULL;
+	}
+}
+
 /**
  * DPDK callback to start the device.
  *
@@ -1225,6 +1273,12 @@ mlx5_dev_start(struct rte_eth_dev *dev)
 		if (ret)
 			goto error;
 	}
+	ret = mlx5_dev_allocate_tx_sq_acc_mem(dev);
+	if (ret) {
+		DRV_LOG(ERR, "port %u Tx queues memory allocation failed: %s",
+			dev->data->port_id, strerror(rte_errno));
+		goto error;
+	}
 	ret = mlx5_txq_start(dev);
 	if (ret) {
 		DRV_LOG(ERR, "port %u Tx queue allocation failed: %s",
@@ -1358,6 +1412,7 @@ mlx5_dev_start(struct rte_eth_dev *dev)
 	mlx5_rxq_stop(dev);
 	if (priv->obj_ops.lb_dummy_queue_release)
 		priv->obj_ops.lb_dummy_queue_release(dev);
+	mlx5_dev_free_tx_sq_acc_mem(dev);
 	mlx5_txpp_stop(dev); /* Stop last. */
 	rte_errno = ret; /* Restore rte_errno. */
 	return -rte_errno;
@@ -1470,6 +1525,7 @@ mlx5_dev_stop(struct rte_eth_dev *dev)
 	priv->sh->port[priv->dev_port - 1].nl_ih_port_id = RTE_MAX_ETHPORTS;
 	mlx5_txq_stop(dev);
 	mlx5_rxq_stop(dev);
+	mlx5_dev_free_tx_sq_acc_mem(dev);
 	if (priv->obj_ops.lb_dummy_queue_release)
 		priv->obj_ops.lb_dummy_queue_release(dev);
 	mlx5_txpp_stop(dev);
diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h
index 55568c41b1..a230b6b1b4 100644
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
@@ -182,6 +183,7 @@ struct mlx5_txq_ctrl {
 	RTE_ATOMIC(uint32_t) refcnt; /* Reference counter. */
 	unsigned int socket; /* CPU socket ID for allocations. */
 	bool is_hairpin; /* Whether TxQ type is Hairpin. */
+	bool consec_mem; /* using consecutive memory. */
 	unsigned int max_inline_data; /* Max inline data. */
 	unsigned int max_tso_header; /* Max TSO header size. */
 	struct mlx5_txq_obj *obj; /* Verbs/DevX queue object. */
diff --git a/drivers/net/mlx5/mlx5_txpp.c b/drivers/net/mlx5/mlx5_txpp.c
index 0e99b58bde..a750c147f8 100644
--- a/drivers/net/mlx5/mlx5_txpp.c
+++ b/drivers/net/mlx5/mlx5_txpp.c
@@ -131,7 +131,7 @@ mlx5_txpp_alloc_pp_index(struct mlx5_dev_ctx_shared *sh)
 static void
 mlx5_txpp_destroy_send_queue(struct mlx5_txpp_wq *wq)
 {
-	mlx5_devx_sq_destroy(&wq->sq_obj);
+	mlx5_devx_sq_destroy(&wq->sq_obj, false);
 	mlx5_devx_cq_destroy(&wq->cq_obj);
 	memset(wq, 0, sizeof(*wq));
 }
diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index 2fdb472ab3..cf1fc26e75 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -1037,6 +1037,16 @@ txq_adjust_params(struct mlx5_txq_ctrl *txq_ctrl)
 		    !txq_ctrl->txq.inlen_empw);
 }
 
+static uint32_t
+mlx5_txq_wq_mem_length(uint32_t log_wqe_cnt)
+{
+	uint32_t num_of_wqbbs = RTE_BIT32(log_wqe_cnt);
+	uint32_t umem_size;
+
+	umem_size = MLX5_WQE_SIZE * num_of_wqbbs;
+	return umem_size;
+}
+
 /**
  * Create a DPDK Tx queue.
  *
@@ -1061,6 +1071,7 @@ mlx5_txq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_txq_ctrl *tmpl;
 	uint16_t max_wqe;
+	uint32_t wqebb_cnt, log_desc_n;
 
 	tmpl = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO, sizeof(*tmpl) +
 			   desc * sizeof(struct rte_mbuf *), 0, socket);
@@ -1086,7 +1097,8 @@ mlx5_txq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 	txq_set_params(tmpl);
 	txq_adjust_params(tmpl);
 	max_wqe = mlx5_dev_get_max_wq_size(priv->sh);
-	if (txq_calc_wqebb_cnt(tmpl) > max_wqe) {
+	wqebb_cnt = txq_calc_wqebb_cnt(tmpl);
+	if (wqebb_cnt > max_wqe) {
 		DRV_LOG(ERR,
 			"port %u Tx WQEBB count (%d) exceeds the limit (%d),"
 			" try smaller queue size",
@@ -1094,6 +1106,10 @@ mlx5_txq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 		rte_errno = ENOMEM;
 		goto error;
 	}
+	log_desc_n = log2above(wqebb_cnt);
+	tmpl->txq.sq_mem_len = mlx5_txq_wq_mem_length(log_desc_n);
+	priv->acc_tx_wq_mem.total_size += MLX5_ROUNDUP(RTE_ALIGN(tmpl->txq.sq_mem_len,
+		MLX5_DBR_SIZE) + MLX5_DBR_SIZE, MLX5_WQE_BUF_ALIGNMENT);
 	rte_atomic_fetch_add_explicit(&tmpl->refcnt, 1, rte_memory_order_relaxed);
 	tmpl->is_hairpin = false;
 	LIST_INSERT_HEAD(&priv->txqsctrl, tmpl, next);
-- 
2.34.1

