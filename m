Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FD4C36002
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 08:18:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA79F40677;
	Mon, 24 Mar 2025 09:18:53 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by mails.dpdk.org (Postfix) with ESMTP id 2E87940677
 for <dev@dpdk.org>; Mon, 24 Mar 2025 09:18:52 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CwAY5gsiPRbmCcW7CBkjobWp3ehbqFXnLEoCmOY/wOIRb/YyxKhV0cE0LIzxmHwJyTS5apXwwid1kog+dqUzzCHFIVGoN6r8Oc+4Os+awscF/oEDPBR7IMTE1vkdf7Kj9wKTP3zrGlSJbW8dczaaFMqjVIwHNsmwO+yHmz5nwVKbPjIihL1IiofUD4E6wuicx+iCSBx2VYx18Zd+n95V7hPSntQIkK+PvQlvdvhR0kHZzWmbI4Jdb0AORFHWIh07Fig/baTScmMbJMe+c8y8Gv8DO8CPHQL2/+gkH1CxvigKDL9U0gsA6ruVYYEVZrujTovtFjYhAqXGZ/wPsU/fhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckohmd+K2KXbGS5/r7uAsifPmVjKh9k5U5B3ZQe8aXc=;
 b=bTDtucLGuz7nADSqh6ch0tl3jGNxMWC0IWxsXZcqOu9fXe87FZVdoVGDFV4RgQWmWuQ+jyk7k8LNCP9pYh0sKO3d2/1tByozZkI1I6EVJYhWfWOdpVKGdumLEnhXYRqJ3Q9QN5XQ3/hNEZLtzwKuN/8q5DgsI7QOVLhvO2ruhLyf8TqTMBYOuQdhWiF+GSWRk/2uAquVuQwUb+6/bteTwKz2L/9TBkOIZPWoNCPTHJ+hfWtkn2x0xIP07/7dh6kpW4XJrywYdvTUcVcIctE6FdPCrPtNk+7ZF+1m7iJIG7GT+5o0kbIqjtyje4gMSqb5rEOgBcH3wuT/B47a3ZFo7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckohmd+K2KXbGS5/r7uAsifPmVjKh9k5U5B3ZQe8aXc=;
 b=CZKsv0wFo8fdPxj9mLM2qbEjdGge64y4lYhhR00d8Abm4GQhDNfVigfgcD2DU/IeLhHLnaA/dlxm0lgTxzSol1df98RiFPrZiIIUoKb1BgRZXylOk0BDRduUp+cjdLf/OTA37Ck7PtULR+iGe7Bp2W+hCgcp2ShkSWKK++BBzhVJTN05yxlx2LPaQl6urNaORfqSwnZJuxwgAAXxqsmoscpGTIKtxuebNYH6sYaPw/4ba8QghrF/AHRlGLt7PDqMswhO52/y6Y7oIbreT9dmPlxKFuovfHvJBkE6gNIQGUHN03a6H8kAYBuxubDhRT5YHtGpcVlyfebgR82wX5rNcw==
Received: from SA0PR13CA0030.namprd13.prod.outlook.com (2603:10b6:806:130::35)
 by IA0PR12MB7723.namprd12.prod.outlook.com (2603:10b6:208:431::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:18:48 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::b9) by SA0PR13CA0030.outlook.office365.com
 (2603:10b6:806:130::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 08:18:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 08:18:47 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Mar
 2025 01:18:33 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Mar
 2025 01:18:33 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 24 Mar 2025 01:18:31 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, Shani Peretz <shperetz@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH 1/2] net/mlx5: add ipool debug capabilities
Date: Mon, 24 Mar 2025 10:18:23 +0200
Message-ID: <20250324081825.231395-2-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324081825.231395-1-shperetz@nvidia.com>
References: <20250324081825.231395-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|IA0PR12MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: 730b73c2-6dbe-4fae-7aae-08dd6aac8049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RerF8j8CikN+WoHcVOO7h8vdsyDLtw3OhUztKG9u9/L9mhycj1rWWVVuc0n9?=
 =?us-ascii?Q?WcP9imJQlCibUUeBRhaTeqCnyvCS7ftDj2q9S/b7zcZPPaHicJDtiF5+UhMk?=
 =?us-ascii?Q?KsQBk3p6R3A8rqNGf8KuyujZp5jDi7hKxI1O2NQN4jKiZTT5aw+Ec6gnaGAY?=
 =?us-ascii?Q?lIPMBWgGzi1SsF0mVFakyC6nawJr+mxYAcRe5ojHJBIwR8UBGdWZy9seCiZc?=
 =?us-ascii?Q?8r2fz9yVtvts3VGALNQVd4AQrJwbHhm41h1QefOfR2Es+hT+CU50InmVgx6d?=
 =?us-ascii?Q?qFzGvq7aoTUmGRY2D5r8kFgz04G28IsbWay9CFUwF+U9Qi1E0M7A+JZJCzwP?=
 =?us-ascii?Q?Fuig/3an7TiFFg2TiaYJPHFUWMFnnmmi8fR1OmDBKvezHQuXI+pr++byAQem?=
 =?us-ascii?Q?E6+PDJwgwHSvYRHjZRXVAI1YOEZ9hdGQUr0ZeAKx7E2qSrrAzcwIJ440rMY4?=
 =?us-ascii?Q?R9QrJVxDaODozbdFHk5QfnK1aMidDlyU1e3VmE/+eeDFJAdatxUSHHMULRmj?=
 =?us-ascii?Q?0DERnRVORVyM04WqNRNO7d5Wia8C/MZcytE3PkabPMBd87MwrN8qYBnEw83v?=
 =?us-ascii?Q?KpBoMgZEg71QPl6uuxDspso+1q91zh5VvZKjjgji5qIde5mkxU1jB4mMlbcH?=
 =?us-ascii?Q?G76lug3/n4/vTHt57Q+/6dhH6qKldK64ceHvRjTbKGJ6+U9ez4cTWPUjVqLC?=
 =?us-ascii?Q?ekzj8wk6ckHn2csLaUNh+YOFeuLzhGttXcs3NHiho2rSgYaNNQfZqEfc1p93?=
 =?us-ascii?Q?rb3RGwrHcEQZWNZp9VL/znUCspy8VDQ+peR/RfBztzFD0sTHklEAaISWMhzK?=
 =?us-ascii?Q?+SKYskXsYtuzdDmaKediyJEYmoUMuH9ZDYZXbBIUjOWX7IiIuE5WFvE+49yP?=
 =?us-ascii?Q?CoMB4cokL7S3l+SlQHgzDy7VVy0cZV3tzdyUMMl9b1t6dNQueAOSPZm+L0Ro?=
 =?us-ascii?Q?TnDkDFRFTvvT9iqXznw2xuJLw9ynTrteygIolQ7CyArxgCzYMJhAmaMRuV+j?=
 =?us-ascii?Q?ziHXpaWTkkLcD6V0PAAoSPh02PVPycKj/Np6s3975GwLQB0/QgXpjCMrc40C?=
 =?us-ascii?Q?qTELUA91U5s5V9UMAWB5dpeGmSHHAukj6gaHFM8nvj7zZXHAoB7Hw6Kj2Fi3?=
 =?us-ascii?Q?Kd+MjLpOJ1w7/msV95wIya17V6mcdgI9iKDBbJ3DEBgnxf/NjBh7M4LO8yKU?=
 =?us-ascii?Q?nCo6fGTYk+BlbbxCDG2/4YCGzs+h+J8QbZRL8LylT0FJrkRRjLXIfR0JdNnZ?=
 =?us-ascii?Q?GOX9LE8JD62NrL67n91HwHpalEFMYX39NUDdexWJpYDqfy4NNkxmSqqJW/Xj?=
 =?us-ascii?Q?axrr2ZxKYo8dO/I52jE+iJBdqIHqMV1J5tYNvyaRJTQo8PliAFZlIjkcspP9?=
 =?us-ascii?Q?iSLass8azU9dz/D6CbI1T61njBkixc7310fNpYbStIB/GroFfqWWDvYCtLX/?=
 =?us-ascii?Q?sl7EkMpJIPR96ObrePx5ZQ9MvbfHTaO5T1yUx22JDeVcwlsLLfiXpZJEGpm/?=
 =?us-ascii?Q?TuQcyJaS1Owlkug=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 08:18:47.4290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 730b73c2-6dbe-4fae-7aae-08dd6aac8049
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7723
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

Enhancing ipool debug capabilities by introducing new ipool log
component.
Also adding various logs in different verbosities for ipool operations.

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_utils.c | 50 ++++++++++++++++++++++++++++++++++-
 drivers/net/mlx5/mlx5_utils.h |  9 +++++++
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_utils.c b/drivers/net/mlx5/mlx5_utils.c
index d882af6047..b92ac44540 100644
--- a/drivers/net/mlx5/mlx5_utils.c
+++ b/drivers/net/mlx5/mlx5_utils.c
@@ -10,6 +10,11 @@
 
 /********************* Indexed pool **********************/
 
+int mlx5_logtype_ipool;
+
+/* Initialize driver log type. */
+RTE_LOG_REGISTER_SUFFIX(mlx5_logtype_ipool, ipool, NOTICE)
+
 static inline void
 mlx5_ipool_lock(struct mlx5_indexed_pool *pool)
 {
@@ -115,6 +120,9 @@ mlx5_ipool_create(struct mlx5_indexed_pool_config *cfg)
 	if (!cfg->per_core_cache)
 		pool->free_list = TRUNK_INVALID;
 	rte_spinlock_init(&pool->lcore_lock);
+
+	DRV_LOG_IPOOL(INFO, "lcore id %d: pool %s: per core cache mode %s",
+		      rte_lcore_id(), pool->cfg.type, pool->cfg.per_core_cache != 0 ? "on" : "off");
 	return pool;
 }
 
@@ -214,6 +222,9 @@ mlx5_ipool_update_global_cache(struct mlx5_indexed_pool *pool, int cidx)
 		mlx5_ipool_unlock(pool);
 		if (olc)
 			pool->cfg.free(olc);
+		DRV_LOG_IPOOL(DEBUG, "lcore id %d: pool %s: updated lcache %d "
+			      "ref %d, new %p, old %p", rte_lcore_id(), pool->cfg.type,
+			      cidx, lc->ref_cnt, (void *)lc, (void *)olc);
 	}
 	return lc;
 }
@@ -442,6 +453,13 @@ mlx5_ipool_malloc_cache(struct mlx5_indexed_pool *pool, uint32_t *idx)
 	entry = _mlx5_ipool_malloc_cache(pool, cidx, idx);
 	if (unlikely(cidx == RTE_MAX_LCORE))
 		rte_spinlock_unlock(&pool->lcore_lock);
+#ifdef POOL_DEBUG
+	++pool->n_entry;
+	DRV_LOG_IPOOL(DEBUG, "lcore id %d: pool %s: allocated entry %d lcore %d, "
+		      "current cache size %d, total allocated entries %d.", rte_lcore_id(),
+		      pool->cfg.type, *idx, cidx, pool->cache[cidx]->len, pool->n_entry);
+#endif
+
 	return entry;
 }
 
@@ -471,6 +489,9 @@ _mlx5_ipool_free_cache(struct mlx5_indexed_pool *pool, int cidx, uint32_t idx)
 	if (pool->cache[cidx]->len < pool->cfg.per_core_cache) {
 		pool->cache[cidx]->idx[pool->cache[cidx]->len] = idx;
 		pool->cache[cidx]->len++;
+		DRV_LOG_IPOOL(DEBUG, "lcore id %d: pool %s: freed entry %d "
+			      "back to lcache %d, lcache size %d.", rte_lcore_id(),
+			      pool->cfg.type, idx, cidx, pool->cache[cidx]->len);
 		return;
 	}
 	ilc = pool->cache[cidx];
@@ -493,6 +514,10 @@ _mlx5_ipool_free_cache(struct mlx5_indexed_pool *pool, int cidx, uint32_t idx)
 		pool->cfg.free(olc);
 	pool->cache[cidx]->idx[pool->cache[cidx]->len] = idx;
 	pool->cache[cidx]->len++;
+
+	DRV_LOG_IPOOL(DEBUG, "lcore id %d: pool %s: cache reclaim, lcache %d, "
+		      "reclaimed: %d, gcache size %d.", rte_lcore_id(), pool->cfg.type,
+		      cidx, reclaim_num, pool->cache[cidx]->len);
 }
 
 static void
@@ -508,6 +533,10 @@ mlx5_ipool_free_cache(struct mlx5_indexed_pool *pool, uint32_t idx)
 	_mlx5_ipool_free_cache(pool, cidx, idx);
 	if (unlikely(cidx == RTE_MAX_LCORE))
 		rte_spinlock_unlock(&pool->lcore_lock);
+
+#ifdef POOL_DEBUG
+	pool->n_entry--;
+#endif
 }
 
 void *
@@ -527,6 +556,8 @@ mlx5_ipool_malloc(struct mlx5_indexed_pool *pool, uint32_t *idx)
 			mlx5_ipool_unlock(pool);
 			return NULL;
 		}
+		DRV_LOG_IPOOL(INFO, "lcore id %d: pool %s: add trunk: new size = %d",
+			      rte_lcore_id(), pool->cfg.type, pool->n_trunk_valid);
 	}
 	MLX5_ASSERT(pool->free_list != TRUNK_INVALID);
 	trunk = pool->trunks[pool->free_list];
@@ -550,7 +581,7 @@ mlx5_ipool_malloc(struct mlx5_indexed_pool *pool, uint32_t *idx)
 	iidx += 1; /* non-zero index. */
 	trunk->free--;
 #ifdef POOL_DEBUG
-	pool->n_entry++;
+	++pool->n_entry;
 #endif
 	if (!trunk->free) {
 		/* Full trunk will be removed from free list in imalloc. */
@@ -567,6 +598,11 @@ mlx5_ipool_malloc(struct mlx5_indexed_pool *pool, uint32_t *idx)
 	}
 	*idx = iidx;
 	mlx5_ipool_unlock(pool);
+#ifdef POOL_DEBUG
+	DRV_LOG_IPOOL(DEBUG, "lcore id %d: pool %s: allocated entry %d trunk_id %d, "
+		      "number of trunks %d, total allocated entries %d", rte_lcore_id(),
+		      pool->cfg.type, *idx, pool->free_list, pool->n_trunk_valid, pool->n_entry);
+#endif
 	return p;
 }
 
@@ -644,6 +680,8 @@ mlx5_ipool_free(struct mlx5_indexed_pool *pool, uint32_t idx)
 #ifdef POOL_DEBUG
 	pool->n_entry--;
 #endif
+	DRV_LOG_IPOOL(DEBUG, "lcore id %d: pool %s: freed entry %d trunk_id %d",
+		      rte_lcore_id(), pool->cfg.type, entry_idx + 1, trunk_idx);
 out:
 	mlx5_ipool_unlock(pool);
 }
@@ -688,6 +726,8 @@ mlx5_ipool_destroy(struct mlx5_indexed_pool *pool)
 
 	MLX5_ASSERT(pool);
 	mlx5_ipool_lock(pool);
+	DRV_LOG_IPOOL(INFO, "lcore id %d: pool %s: destroy", rte_lcore_id(), pool->cfg.type);
+
 	if (pool->cfg.per_core_cache) {
 		for (i = 0; i <= RTE_MAX_LCORE; i++) {
 			/*
@@ -757,6 +797,8 @@ mlx5_ipool_flush_cache(struct mlx5_indexed_pool *pool)
 	/* Clear global cache. */
 	for (i = 0; i < gc->len; i++)
 		rte_bitmap_clear(ibmp, gc->idx[i] - 1);
+	DRV_LOG_IPOOL(INFO, "lcore id %d: pool %s: flush gcache, gcache size = %d",
+		      rte_lcore_id(), pool->cfg.type, gc->len);
 	/* Clear core cache. */
 	for (i = 0; i < RTE_MAX_LCORE + 1; i++) {
 		struct mlx5_ipool_per_lcore *ilc = pool->cache[i];
@@ -765,6 +807,8 @@ mlx5_ipool_flush_cache(struct mlx5_indexed_pool *pool)
 			continue;
 		for (j = 0; j < ilc->len; j++)
 			rte_bitmap_clear(ibmp, ilc->idx[j] - 1);
+		DRV_LOG_IPOOL(INFO, "lcore id %d: pool %s: flush lcache %d",
+			      rte_lcore_id(), pool->cfg.type, i);
 	}
 }
 
@@ -831,6 +875,10 @@ mlx5_ipool_resize(struct mlx5_indexed_pool *pool, uint32_t num_entries,
 	mlx5_ipool_lock(pool);
 	pool->cfg.max_idx = num_entries;
 	mlx5_ipool_unlock(pool);
+
+	DRV_LOG_IPOOL(INFO,
+		      "lcore id %d: pool %s:, resize pool, new entries limit %d",
+		      rte_lcore_id(), pool->cfg.type, pool->cfg.max_idx);
 	return 0;
 }
 
diff --git a/drivers/net/mlx5/mlx5_utils.h b/drivers/net/mlx5/mlx5_utils.h
index db2e33dfa9..68dcda5c4d 100644
--- a/drivers/net/mlx5/mlx5_utils.h
+++ b/drivers/net/mlx5/mlx5_utils.h
@@ -190,6 +190,15 @@ typedef int32_t (*mlx5_l3t_alloc_callback_fn)(void *ctx,
 #define POOL_DEBUG 1
 #endif
 
+extern int mlx5_logtype_ipool;
+#define MLX5_NET_LOG_PREFIX_IPOOL "mlx5_ipool"
+
+/* Generic printf()-like logging macro with automatic line feed. */
+#define DRV_LOG_IPOOL(level, ...) \
+	PMD_DRV_LOG_(level, mlx5_logtype_ipool, MLX5_NET_LOG_PREFIX_IPOOL, \
+		__VA_ARGS__ PMD_DRV_LOG_STRIP PMD_DRV_LOG_OPAREN, \
+		PMD_DRV_LOG_CPAREN)
+
 struct mlx5_indexed_pool_config {
 	uint32_t size; /* Pool entry size. */
 	uint32_t trunk_size:22;
-- 
2.34.1

