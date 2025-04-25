Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8C9C369C2
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 15:55:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAFDE40279;
	Fri, 25 Apr 2025 17:55:55 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by mails.dpdk.org (Postfix) with ESMTP id 333794025E
 for <dev@dpdk.org>; Fri, 25 Apr 2025 17:55:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpmVHf9ajdbpwnYcey/NECgcfB+WBXWkf2J/31LAjJDLenA0t2Svapp6nUW7ARdgt5BF7VEciu1Vbs6vBf2sEor+kKXIsu8/w/JfpAKmv+0UaOftCiALkNvdUgD9UgwDCBy/oLg3u3D7Pcym7nO9KY29FgRCYa028mpxGUiz9Ol/v78TYghzTSgZvBVs45XXnzjR/3D8sR5dsyxBKsU3nNdE9dWdLfaWUNacv/k2JnBi1kSXZIaxf9gkJ/QnieiZSPCtNKZDsdXGwa9J0pNkE7ot0lId7/x0FlzzEthnOi8n0pBt1E3heZEE+5hLMkiQPLcyqs23kGaCbR8PO0TxBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rg/wmA/DJeLj2/Ddwx/8BdLf8haycA96PVyCJ+XdZYs=;
 b=I4oKPevOECoZ6favDdd8w0QL6neLf7GDG0AjKvtrmEyOXayxco4/JJ8l7qwsWMJ7plm3Mka1NeLMzDbT7yYWI8t4VWjaA0JAjQ6jL1WhQJ3+/dmMDHP3xZd81WNSZQ8Szq18WIxzMdpxbpmIHjoPn3/Yy8IVcr3fMCWbp0hMLOeSrbRtF7lK3Wuq3ZR4KdjrrZYXDBk3VuKT/bpW1txG90HwWHojikj9ZbLD4Th1DO0urbRINHILdU3pBIUx1lkUEJUiixtZNfz0YfdOfzNKIMf5JmyXyoNirogrvfMqLbzQpB8izQDhyzHdd3HZfQAZ3AE+kroJ5J4WWRlsDK5xlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rg/wmA/DJeLj2/Ddwx/8BdLf8haycA96PVyCJ+XdZYs=;
 b=b5mF2UWExwLIH4GDOiBV6TPC7cd8uJ3dDfRz2zPOk5bT0/xG0v5apU8Ctdw1B0b/yVyXh43PGdu9aLH62sZCHAlRcU3sFx+oQU4OEByDcoYhzwP27BUriR3crTDEcZlwfYHRJNe+2vGEITV3nOs5vJbk8inz9VsOFwtCFUpMj4qWneWHmAEwBVgIcJ5xW7IGsA+SPCCnCqOduWlSOu92rbNorMBFfxistLbFgG5ueN6n9UqDUgF4wf/QttmUWaQQ1RKYAA9V1/1J3jvnG2gadrd9vByIvGrfaH4B0PGTXAQiHtox5ryvfGgT3iw8/5i0Mvdlh8N0gqcojjC7wchDIw==
Received: from BN9PR03CA0447.namprd03.prod.outlook.com (2603:10b6:408:113::32)
 by DS0PR12MB7777.namprd12.prod.outlook.com (2603:10b6:8:153::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 15:55:49 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:113:cafe::be) by BN9PR03CA0447.outlook.office365.com
 (2603:10b6:408:113::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.38 via Frontend Transport; Fri,
 25 Apr 2025 15:55:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.1 via Frontend Transport; Fri, 25 Apr 2025 15:55:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Apr
 2025 08:55:35 -0700
Received: from pegasus01.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 25 Apr 2025 08:55:33 -0700
From: Alexander Kozyrev <akozyrev@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, <viacheslavo@nvidia.com>, <dsosnowski@nvidia.com>,
 <bingz@nvidia.com>, <suanmingm@nvidia.com>
Subject: [PATCH] net/mlx5: optimize counters ID greneration logic
Date: Fri, 25 Apr 2025 18:55:12 +0300
Message-ID: <20250425155515.2635090-1-akozyrev@nvidia.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|DS0PR12MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: a055dd06-2bfc-4012-94a0-08dd8411a5ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3qqWFRowGTR0Ls/XxzY7ALz/JWS6f9/NcYhQT4C5oyE3J7TuARgZ/HI7JWI1?=
 =?us-ascii?Q?+Y/DYB1kr1VkdK1SrJMZAbzWtqNoL9bJALXbasmQyZBwti32fNMdhh8dKjX8?=
 =?us-ascii?Q?3146HdXcz+oPRMvQ1xzNtZGGH3Q+prNYySwsb/zulBC5QsBQgX4jhBzr5a1P?=
 =?us-ascii?Q?gF6V1bqBovce628c0PBa6JyyknYN/YjEDEt5ry094gkzkcWoFWX/IErLoyWX?=
 =?us-ascii?Q?knmqEAkDT56+TZXOJG1wRJuxQAWrqh0qWF5ZwHORi2KeLTglqZ5spI6utI0+?=
 =?us-ascii?Q?kC2XbRchNejOwrE0zX+u7E8QRPtEcWVCqGFYdOA+Q3Beg+pMRniPIK+b54zH?=
 =?us-ascii?Q?TC3yk1Z3AGRk0kvwkSH1DdMR4xuBah4I330Cv9A1MvJ9cwcdGM72Jy/bZFIp?=
 =?us-ascii?Q?EwMJjHHD3fsxqpLKph44TGGIFGpHmSc1V/epGpR7Ow13WKYoeM9wcNS/n8CW?=
 =?us-ascii?Q?o3D8AoZ1XHCOGDbJbUQTe6LuyrpeMm1iUGiNj1jllT7u37OqZ4m4bAL/arNW?=
 =?us-ascii?Q?xl/1An7HdN/4ilZci7YrML48YuX3hvrlbCOUkPCypuCF41XmyQF0O12OWK0o?=
 =?us-ascii?Q?UFLCMBwK+zthq4PcZvRFNI8wd6zOiHVTka1xdFgDH7hC0DNYjEaq9w6YpUTe?=
 =?us-ascii?Q?7EMJaTAOOEmr81duQtK+JEIRxBBes4v6IMIYXwrfaTZCWUjyFpo6SppgcPAn?=
 =?us-ascii?Q?ffEvrU9+/+IZdSS3oitQ9D0jDqJod5q2RsOplhk9UhvzjwaADoPFpoX0BEYc?=
 =?us-ascii?Q?BKRqdGZWZ5BtiWmd2k+6LoCU15y07h8/3znJ/z4SMzsbGOQ4oHKcM95rYk7l?=
 =?us-ascii?Q?vmPgRzGxaM8Y3UCoCAM3BBj3F2oKxPNyUvGkLDAJY+wBq11ph2wIDilrpdIV?=
 =?us-ascii?Q?J32fhuKf5oqT0iH44ZbVl7IFe1iJR1BdTT3A6IOrsd5eTu+QXB5LdYSmojXV?=
 =?us-ascii?Q?Ifg/v6VAoIJD5MhLMQhUxtTP3kug5PJQRl+B1guDnueq6KwS/VnJpLCuiEhl?=
 =?us-ascii?Q?xDRmuWdh5Iy9cMtSAQ/tKBHUu9Ex+jEOIATxUqW99lYZ+81nRmLAGPiMV1BM?=
 =?us-ascii?Q?zxDFibywS6HKxl/PULbajetz7Zl3aUKPV0+uYs7Pu4AqJwGwnwAbod5NaFQG?=
 =?us-ascii?Q?vA5TK8fjJ8+t3Y+DPecIdNU0k5tOOCeqNzITiDULzIUgV5iOKT7qnJpxLDn2?=
 =?us-ascii?Q?bqRSztUnba++O3Bs1NDBY9FLwL5To8ymViSO0MzX5jaOJZMLsLf+BYR2nowv?=
 =?us-ascii?Q?oOQVG19X4jyPFgVMy+AQ2a1g0w0AqiUqS5wOU5eGAru8X5uBVX/fpCG5I+Fb?=
 =?us-ascii?Q?/YiOC0STD58RzdKj7qewwnGhnmzSo3ohssGLy3aFayb2AAjVlWPTCcgCWGcd?=
 =?us-ascii?Q?4LAJ4xHCKZVmmweXjXvopT5rsQ4uPQLFWs8iUc0E7F1v08bd7uWsdxNRH4Li?=
 =?us-ascii?Q?S7zqhfBfgUFCKxv7sgO9BuD74Q/dj5E/vSx9QRiAN8mz8SjnR7Uf1pN58yVq?=
 =?us-ascii?Q?goEwcFBis5ndcXSXvrGeRSQLx60lmSLG9VNF?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 15:55:48.7567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a055dd06-2bfc-4012-94a0-08dd8411a5ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7777
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

Enqueue generated counter IDs on a ring in bulk.
Generate them and store in an array before putting them
on a ring all at once. That bring better cache access
and speeds up the mlx5_hws_cnt_pool_create() function.

Signed-off-by: Alexander Kozyrev <akozyrev@nvidia.com>
---
 drivers/net/mlx5/mlx5_hws_cnt.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_hws_cnt.c b/drivers/net/mlx5/mlx5_hws_cnt.c
index 7b5e7310af..2d2faa2c65 100644
--- a/drivers/net/mlx5/mlx5_hws_cnt.c
+++ b/drivers/net/mlx5/mlx5_hws_cnt.c
@@ -22,12 +22,17 @@
 #define HWS_CNT_CACHE_THRESHOLD_DEFAULT 254
 #define HWS_CNT_ALLOC_FACTOR_DEFAULT 20
 
-static void
+static int
 __hws_cnt_id_load(struct mlx5_hws_cnt_pool *cpool)
 {
 	uint32_t cnt_num = mlx5_hws_cnt_pool_get_size(cpool);
 	uint32_t iidx;
+	cnt_id_t *cnt_arr = NULL;
 
+	cnt_arr = mlx5_malloc(MLX5_MEM_ANY | MLX5_MEM_ZERO,
+			      cnt_num * sizeof(cnt_id_t), 0, SOCKET_ID_ANY);
+	if (cnt_arr == NULL)
+		return -ENOMEM;
 	/*
 	 * Counter ID order is important for tracking the max number of in used
 	 * counter for querying, which means counter internal index order must
@@ -38,10 +43,12 @@ __hws_cnt_id_load(struct mlx5_hws_cnt_pool *cpool)
 	 */
 	for (iidx = 0; iidx < cnt_num; iidx++) {
 		cnt_id_t cnt_id  = mlx5_hws_cnt_id_gen(cpool, iidx);
-
-		rte_ring_enqueue_elem(cpool->free_list, &cnt_id,
-				sizeof(cnt_id));
+		cnt_arr[iidx] = cnt_id;
 	}
+	rte_ring_enqueue_bulk_elem(cpool->free_list, cnt_arr,
+				   sizeof(cnt_id_t), cnt_num, NULL);
+	mlx5_free(cnt_arr);
+	return 0;
 }
 
 static void
@@ -745,7 +752,9 @@ mlx5_hws_cnt_pool_create(struct rte_eth_dev *dev,
 	cpool->raw_mng = mlx5_hws_cnt_raw_data_alloc(priv->sh, sz, error);
 	if (cpool->raw_mng == NULL)
 		goto error;
-	__hws_cnt_id_load(cpool);
+	ret = __hws_cnt_id_load(cpool);
+	if (ret != 0)
+		goto error;
 	/*
 	 * Bump query gen right after pool create so the
 	 * pre-loaded counters can be used directly
-- 
2.43.5

