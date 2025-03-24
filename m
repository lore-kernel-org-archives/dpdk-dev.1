Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FB5C36008
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 08:19:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C1B74069F;
	Mon, 24 Mar 2025 09:18:58 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by mails.dpdk.org (Postfix) with ESMTP id 020EE4069D
 for <dev@dpdk.org>; Mon, 24 Mar 2025 09:18:55 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afVilWTdVzDQcfVbZ04Spj8O1BjFy9WccAuDjPaJvdFrxIYRDhWq3o4pGBAq87zFi4K2p7x8UlvqipADEsk0mXufPBq3olq6Dd253VcrJfcj64SIV/heACn/YiCWx1NJVi5h1vneJxncmi2EOWWnTo/8COcFN+2TAU3FIsgYqDmLAyj171BrHsViAkk6lHtMSmh4NzzLyhdLEm0Dl/HJSIcsBpjQaBN9mt9+vOdATsmteMiCRJi32/b8DEyMcO4acLtKycN9KCvE3nvSc8C6dsD7Fmu2quVGJccnX3u7GQMQuYNgweXyYmT6IX55ZmqWXieo9UOAyWyiQjw9N7pOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7vzGE6500r4sQjKx9ZWQxgFpbByBCsb7rA6qDWYpUc=;
 b=PdiDPwytUK5G/3QYMJZbZI2R3u7t1qwIS/fiH1Qu+kbrgygNDQ7cZbpLIoTr6h+D3qlEQY4H3KkWIdnh6XVjXFBoc6kwheMxVStJ5qaLb9cW4J0L6DGWr+3Ikqg5MPQW7CVGKo2HprH3OwuxxiAu49rOPByl7hMAeYbkrYrMqsWrxKVcTarPnV92nynwVVOUbkMLiGqsCT1CnkAtw+Y8sBQA2ZqnK5kNH/Ou9UqHXFAXCM4blsaFmsfG6oGS6uQs5rU17t/j4bILhUow+Mobbiofh/EHR3wIbD+vAsaFTCRhuGwD5c7EXy0GKmjwdmoc6dG+XqIZeaCvPK5rjjfOfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7vzGE6500r4sQjKx9ZWQxgFpbByBCsb7rA6qDWYpUc=;
 b=d2oAzyhtnmcdPYJfN8JRVPr6Kpc/wd7xz2ZkupsXLRWREQcrh7sA4O7C1LIovel6HUwJRcFsyladC/XUEw3AnnlSHU4I8wCoYp12NvOmeQVFc5QiEKa/EsxcHdoX9PvuZmxOX8qf1+KrPcl0tHd06yFK2XqZc/GYqKTqzsjbzAEJu7/RnRg/8a4CXi6PIb5R9sxQu38lEcUujaciTac5kpYwo5V+fAcI/gMVEekflQAcC8CcvoY4j1EeIFP2tkk/9Il2hWUK3nIxKZGSRotU5sRAgZ8F31HksVlk4jRlmmj7KAgBbQKrxHdHNXQPFfAVUG3fjlJb1+ZFcgRx64etyw==
Received: from SA1PR04CA0006.namprd04.prod.outlook.com (2603:10b6:806:2ce::6)
 by CY8PR12MB8337.namprd12.prod.outlook.com (2603:10b6:930:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:18:52 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:2ce:cafe::f8) by SA1PR04CA0006.outlook.office365.com
 (2603:10b6:806:2ce::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 08:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 08:18:51 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Mar
 2025 01:18:37 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Mar
 2025 01:18:37 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 24 Mar 2025 01:18:35 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, Shani Peretz <shperetz@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH 2/2] net/mlx5: added a bitmap that tracks ipool allocs and
 frees
Date: Mon, 24 Mar 2025 10:18:24 +0200
Message-ID: <20250324081825.231395-3-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324081825.231395-1-shperetz@nvidia.com>
References: <20250324081825.231395-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|CY8PR12MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: 698b2e77-fcca-4762-aed8-08dd6aac82f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rIvOrgkzzyTEjw3LSzXyqzFdiCj3uFrGvERUAqihlxqWaUvsMmkxWANq82rq?=
 =?us-ascii?Q?/lmzil76AYc2i4IROWV4695CNHED8zb1r8q4IIfGeWE1hk0smlTYkj2zNBna?=
 =?us-ascii?Q?a8PaIIU+ijWS1gcFBmJ60dScEu0xwDyAR1tNBuXQH0qn1zZ+dB7t0Xe8JDsU?=
 =?us-ascii?Q?ZNt1JHuTuQ6gvYcwwoBhziN31e0EL4Loek4ID86CfGH0Qb6IIAhgFtod4ff4?=
 =?us-ascii?Q?04A+nJc/rHjDvdVq+ZU3ob4lZE5Wku6iqrJH6nAVtIGiYc9AQshndT/ikoJR?=
 =?us-ascii?Q?QXwUu5SI29g0MIHehnLReDOqaHSBErFGZOwgfBpjOVDyKtTsdyvCKfMMyfVF?=
 =?us-ascii?Q?nq9x0LuKgHTH9Bfk2r4GavPG8+7wA5cNqqpiMg2eUtKxdKUi5pNqW+QpDI4m?=
 =?us-ascii?Q?bqVsutHCmiOVU2hR/O5wmtcE20rZiTWM2EDlcdsamIbodTmRPEE4jxDowkq3?=
 =?us-ascii?Q?gpJ8XaGEEfI8Xh3RjtbkIQnee6ayAezm7GHftIvBoVqyif/KyFQF4xNCmdS7?=
 =?us-ascii?Q?2A9Y3F7r6MiNN+3Ovq3ghcFtdWJgivnG3nUkS7bduGRccUcRlPJFPWiPKiq+?=
 =?us-ascii?Q?YhJKGsxxGo6WopvDRp0MuDIPPBwgtsguV0hDC43o/cpyflYy/o44WMcT/RZZ?=
 =?us-ascii?Q?D0+jpGAPTSSGi+ijba6sghL84H35J6UzKhoZjU4LF76OpzGk6QnpUvWkWoRS?=
 =?us-ascii?Q?K1fv3CxHQkzEITz9qeGO1T6XBWRGiCQMHQS66afgCx3mU744ZNX9YPRAv28h?=
 =?us-ascii?Q?7KwY8rPgO6Xa2cwRC0cj3Az0f2RkocI/PaKmdHCOmgeDFlvk/HC46PaCBa95?=
 =?us-ascii?Q?9j8UHmvN61R8xbRrK5ZNbKefD8kMxMkjYx3zEDCKUx4jaGGfDQLoXFXX/G/u?=
 =?us-ascii?Q?CBffdj2fnDuUlC7hh8WSe34me8KcvaMlWwej7FSlQ3nlkvlrkoL9qG3OUE81?=
 =?us-ascii?Q?DG767jC3f2YWQPUj077rW8OIBN91aEf+Ps/NMuVZ5ueEqqlkxMe7JlhG/DH6?=
 =?us-ascii?Q?t/r3IEIWujfTvWGd+dDiPwv9zrh3ujoDvN7aOgGfTMZoZFFWBYOGNxxd8a/E?=
 =?us-ascii?Q?i39y1PoeQwP5MRu/HbSKL6Lj8teA75oEslWnYdYOYdXOyHp3N3ilEjb/W5PE?=
 =?us-ascii?Q?TMCyKHwcBxNtV2G75W9VLVWdDcPgeEI0XPf/47d2C7UV+yyAYMo0/z4N7hQW?=
 =?us-ascii?Q?oToCxnzITTL83xXPx0jTSU+hJFGknEiiddbAAk9D8cm11nYGbdyU25oQnBc4?=
 =?us-ascii?Q?vyRks9luw4CERkNFzk3CnZY+tgTG5EjIIXolC+FZBMqmM3ERkvSwT3SxIKjC?=
 =?us-ascii?Q?do32cYuSvVJF/88sCDZDrJSrlzNN834GioCjpW0a3ASHI2F5S1AYsrH5229+?=
 =?us-ascii?Q?hnJwV2jWi2upLRBsYCtrFq5GXzC9lXSPzMmcpQfyYdz49gvuqA/ABH0PTFw4?=
 =?us-ascii?Q?P+h69LX+gLk7d7x7Mx7uF6NxKJnOVq3SQvMzurGaKLSUz2sm17oi+YUyzyDL?=
 =?us-ascii?Q?SWsAuI/9NbAycBU=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 08:18:51.9196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 698b2e77-fcca-4762-aed8-08dd6aac82f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8337
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

The bitmap goal is to prevent double allocations and deallocations in
per core cache mode.
This validation occurs only in debug mode, ensuring it doesn't
impact performance.

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_utils.c | 103 +++++++++++++++++++++++++++++++++-
 drivers/net/mlx5/mlx5_utils.h |  12 ++++
 2 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_utils.c b/drivers/net/mlx5/mlx5_utils.c
index b92ac44540..f8cd7bc043 100644
--- a/drivers/net/mlx5/mlx5_utils.c
+++ b/drivers/net/mlx5/mlx5_utils.c
@@ -121,6 +121,9 @@ mlx5_ipool_create(struct mlx5_indexed_pool_config *cfg)
 		pool->free_list = TRUNK_INVALID;
 	rte_spinlock_init(&pool->lcore_lock);
 
+#ifdef POOL_DEBUG
+	rte_spinlock_init(&pool->cache_validator.lock);
+#endif
 	DRV_LOG_IPOOL(INFO, "lcore id %d: pool %s: per core cache mode %s",
 		      rte_lcore_id(), pool->cfg.type, pool->cfg.per_core_cache != 0 ? "on" : "off");
 	return pool;
@@ -229,6 +232,55 @@ mlx5_ipool_update_global_cache(struct mlx5_indexed_pool *pool, int cidx)
 	return lc;
 }
 
+#ifdef POOL_DEBUG
+static void
+mlx5_ipool_grow_bmp(struct mlx5_indexed_pool *pool, uint32_t new_size)
+{
+	struct rte_bitmap *old_bmp = NULL;
+	void *old_bmp_mem = NULL;
+	uint32_t old_size = 0;
+	uint32_t i, bmp_mem_size;
+
+	if (pool->cache_validator.bmp_mem && pool->cache_validator.bmp) {
+		old_bmp = pool->cache_validator.bmp;
+		old_size = pool->cache_validator.bmp_size;
+		old_bmp_mem = pool->cache_validator.bmp_mem;
+	}
+
+	if (unlikely(new_size <= old_size))
+		return;
+
+	pool->cache_validator.bmp_size = new_size;
+	bmp_mem_size = rte_bitmap_get_memory_footprint(new_size);
+
+	pool->cache_validator.bmp_mem = pool->cfg.malloc(MLX5_MEM_ZERO, bmp_mem_size,
+										RTE_CACHE_LINE_SIZE,
+										rte_socket_id());
+	if (unlikely(!pool->cache_validator.bmp_mem)) {
+		DRV_LOG_IPOOL(ERR, "Unable to allocate memory for a new bitmap");
+		return;
+	}
+
+	pool->cache_validator.bmp = rte_bitmap_init_with_all_set(pool->cache_validator.bmp_size,
+								pool->cache_validator.bmp_mem,
+								bmp_mem_size);
+	if (unlikely(!pool->cache_validator.bmp)) {
+		DRV_LOG(ERR, "Unable to allocate memory for a new bitmap");
+		pool->cfg.free(pool->cache_validator.bmp_mem);
+		return;
+	}
+
+	if (old_bmp && old_bmp_mem) {
+		for (i = 0; i < old_size; i++) {
+			if (rte_bitmap_get(old_bmp, i) == 0)
+				rte_bitmap_clear(pool->cache_validator.bmp, i);
+		}
+		rte_bitmap_free(old_bmp);
+		pool->cfg.free(old_bmp_mem);
+	}
+}
+#endif
+
 static uint32_t
 mlx5_ipool_allocate_from_global(struct mlx5_indexed_pool *pool, int cidx)
 {
@@ -413,6 +465,50 @@ mlx5_ipool_get_cache(struct mlx5_indexed_pool *pool, uint32_t idx)
 	return entry;
 }
 
+#ifdef POOL_DEBUG
+static void
+mlx5_ipool_validate_malloc_cache(struct mlx5_indexed_pool *pool, uint32_t idx)
+{
+	rte_spinlock_lock(&pool->cache_validator.lock);
+	uint32_t entry_idx = idx - 1;
+	uint32_t allocated_size = pool->gc->n_trunk_valid *
+						mlx5_trunk_size_get(pool, pool->n_trunk_valid);
+
+	if (!pool->cache_validator.bmp)
+		mlx5_ipool_grow_bmp(pool, allocated_size);
+
+	if (pool->cache_validator.bmp_size < allocated_size)
+		mlx5_ipool_grow_bmp(pool, allocated_size);
+
+	if (rte_bitmap_get(pool->cache_validator.bmp, entry_idx) == 0) {
+		DRV_LOG_IPOOL(ERR, "lcore id %d: pool %s: detected double malloc idx: %d",
+			      rte_lcore_id(), pool->cfg.type, idx);
+		MLX5_ASSERT(0);
+	}
+	rte_bitmap_clear(pool->cache_validator.bmp, entry_idx);
+	rte_spinlock_unlock(&pool->cache_validator.lock);
+}
+
+static void
+mlx5_ipool_validate_free_cache(struct mlx5_indexed_pool *pool, uint32_t idx)
+{
+	rte_spinlock_lock(&pool->cache_validator.lock);
+	uint32_t entry_idx = idx - 1;
+
+	if (!pool->gc || !pool->cache_validator.bmp) {
+		rte_spinlock_unlock(&pool->cache_validator.lock);
+		return;
+	}
+
+	if (rte_bitmap_get(pool->cache_validator.bmp, entry_idx) != 0) {
+		DRV_LOG_IPOOL(ERR, "lcore id %d: pool %s: detected double free of index %d",
+			      rte_lcore_id(), pool->cfg.type, idx);
+		MLX5_ASSERT(0);
+	}
+	rte_bitmap_set(pool->cache_validator.bmp, entry_idx);
+	rte_spinlock_unlock(&pool->cache_validator.lock);
+}
+#endif
 
 static void *
 _mlx5_ipool_malloc_cache(struct mlx5_indexed_pool *pool, int cidx,
@@ -455,11 +551,11 @@ mlx5_ipool_malloc_cache(struct mlx5_indexed_pool *pool, uint32_t *idx)
 		rte_spinlock_unlock(&pool->lcore_lock);
 #ifdef POOL_DEBUG
 	++pool->n_entry;
+	mlx5_ipool_validate_malloc_cache(pool, *idx);
 	DRV_LOG_IPOOL(DEBUG, "lcore id %d: pool %s: allocated entry %d lcore %d, "
 		      "current cache size %d, total allocated entries %d.", rte_lcore_id(),
 		      pool->cfg.type, *idx, cidx, pool->cache[cidx]->len, pool->n_entry);
 #endif
-
 	return entry;
 }
 
@@ -471,6 +567,11 @@ _mlx5_ipool_free_cache(struct mlx5_indexed_pool *pool, int cidx, uint32_t idx)
 	uint32_t reclaim_num = 0;
 
 	MLX5_ASSERT(idx);
+
+#ifdef POOL_DEBUG
+	mlx5_ipool_validate_free_cache(pool, idx);
+#endif
+
 	/*
 	 * When index was allocated on core A but freed on core B. In this
 	 * case check if local cache on core B was allocated before.
diff --git a/drivers/net/mlx5/mlx5_utils.h b/drivers/net/mlx5/mlx5_utils.h
index 68dcda5c4d..c65839c5d9 100644
--- a/drivers/net/mlx5/mlx5_utils.h
+++ b/drivers/net/mlx5/mlx5_utils.h
@@ -259,6 +259,15 @@ struct mlx5_ipool_per_lcore {
 	uint32_t idx[]; /**< Cache objects. */
 };
 
+#ifdef POOL_DEBUG
+struct mlx5_ipool_cache_validation {
+	rte_spinlock_t lock;
+	uint32_t bmp_size;
+	struct rte_bitmap *bmp;
+	void *bmp_mem;
+};
+#endif
+
 struct mlx5_indexed_pool {
 	struct mlx5_indexed_pool_config cfg; /* Indexed pool configuration. */
 	rte_spinlock_t rsz_lock; /* Pool lock for multiple thread usage. */
@@ -279,6 +288,9 @@ struct mlx5_indexed_pool {
 			struct rte_bitmap *ibmp;
 			void *bmp_mem;
 			/* Allocate objects bitmap. Use during flush. */
+#ifdef POOL_DEBUG
+			struct mlx5_ipool_cache_validation cache_validator;
+#endif
 		};
 	};
 #ifdef POOL_DEBUG
-- 
2.34.1

