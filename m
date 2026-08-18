Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44804C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 11:18:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DC3A40B9E;
	Tue, 18 Aug 2026 13:17:58 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 76A8740A76
 for <dev@dpdk.org>; Tue, 18 Aug 2026 13:17:52 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5A8BC200122;
 Tue, 18 Aug 2026 13:17:52 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2485C200254;
 Tue, 18 Aug 2026 13:17:52 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8B2EC180022C;
 Tue, 18 Aug 2026 19:17:50 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v12 13/26] drivers: release DPAA bpid on driver destructor
Date: Tue, 18 Aug 2026 16:47:17 +0530
Message-Id: <20260818111730.801760-14-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260818111730.801760-1-hemant.agrawal@nxp.com>
References: <20260813144205.2505031-1-hemant.agrawal@nxp.com>
 <20260818111730.801760-1-hemant.agrawal@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Jun Yang <jun.yang@nxp.com>

Track allocated BPIDs in a static per-BPID flag table and register a
driver destructor that releases any BPIDs still marked as in use at
process exit. This prevents BPID leaks when an application exits without
calling rte_mempool_free(). Also tune the per-lcore mempool cache flush
threshold to match the hardware bulk release size (DPAA_MBUF_MAX_ACQ_REL)
so that buffers are returned to HW in optimal burst sizes.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/dpaa/base/qbman/bman.c       |  8 +++
 drivers/bus/dpaa/dpaa_bus_base_symbols.c |  1 +
 drivers/bus/dpaa/include/fsl_bman.h      |  3 ++
 drivers/mempool/dpaa/dpaa_mempool.c      | 62 +++++++++++++++++++++---
 drivers/mempool/dpaa/dpaa_mempool.h      |  3 +-
 5 files changed, 69 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/bman.c b/drivers/bus/dpaa/base/qbman/bman.c
index ee4232d0a0..0ae1160973 100644
--- a/drivers/bus/dpaa/base/qbman/bman.c
+++ b/drivers/bus/dpaa/base/qbman/bman.c
@@ -251,6 +251,14 @@ void bman_free_pool(struct bman_pool *pool)
 	kfree(pool);
 }
 
+void bman_free_bpid(u8 bpid, u32 flags)
+{
+	if (flags & BMAN_POOL_FLAG_THRESH)
+		bm_pool_set(bpid, zero_thresholds);
+	if (flags & BMAN_POOL_FLAG_DYNAMIC_BPID)
+		bman_release_bpid(bpid);
+}
+
 const struct bman_pool_params *bman_get_params(const struct bman_pool *pool)
 {
 	return &pool->params;
diff --git a/drivers/bus/dpaa/dpaa_bus_base_symbols.c b/drivers/bus/dpaa/dpaa_bus_base_symbols.c
index b806b44d29..7a9b08e68c 100644
--- a/drivers/bus/dpaa/dpaa_bus_base_symbols.c
+++ b/drivers/bus/dpaa/dpaa_bus_base_symbols.c
@@ -44,6 +44,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(fman_if_receive_rx_errors)
 RTE_EXPORT_INTERNAL_SYMBOL(netcfg_acquire)
 RTE_EXPORT_INTERNAL_SYMBOL(netcfg_release)
 RTE_EXPORT_INTERNAL_SYMBOL(bman_new_pool)
+RTE_EXPORT_INTERNAL_SYMBOL(bman_free_bpid)
 RTE_EXPORT_INTERNAL_SYMBOL(bman_free_pool)
 RTE_EXPORT_INTERNAL_SYMBOL(bman_get_params)
 RTE_EXPORT_INTERNAL_SYMBOL(bman_release)
diff --git a/drivers/bus/dpaa/include/fsl_bman.h b/drivers/bus/dpaa/include/fsl_bman.h
index 2d24b89889..9c949d1baa 100644
--- a/drivers/bus/dpaa/include/fsl_bman.h
+++ b/drivers/bus/dpaa/include/fsl_bman.h
@@ -287,6 +287,9 @@ struct bman_pool *bman_new_pool(const struct bman_pool_params *params);
 __rte_internal
 void bman_free_pool(struct bman_pool *pool);
 
+__rte_internal
+void bman_free_bpid(u8 bpid, u32 flags);
+
 /**
  * bman_get_params - Returns a pool object's parameters.
  * @pool: the pool object
diff --git a/drivers/mempool/dpaa/dpaa_mempool.c b/drivers/mempool/dpaa/dpaa_mempool.c
index 2f8555a026..3d44739028 100644
--- a/drivers/mempool/dpaa/dpaa_mempool.c
+++ b/drivers/mempool/dpaa/dpaa_mempool.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
- *   Copyright 2017,2019,2023-2025 NXP
+ *   Copyright 2017,2019,2023-2026 NXP
  *
  */
 
@@ -25,10 +25,22 @@
 #include <rte_eal.h>
 #include <rte_malloc.h>
 #include <rte_ring.h>
+#include <rte_common.h>
 
 #include <dpaa_mempool.h>
 #include <dpaax_iova_table.h>
 
+struct dpaa_bpid_flag {
+	uint32_t flags;
+	bool used;
+};
+
+/** Be referenced in destructor to release bpid allocated.
+ * Destructor can't access bman_pool from eal mem,
+ * we release ID with flag directly.
+ */
+static struct dpaa_bpid_flag s_dpaa_bpid_allocated_flag[DPAA_MAX_BPOOLS];
+
 #define FMAN_ERRATA_BOUNDARY ((uint64_t)4096)
 #define FMAN_ERRATA_BOUNDARY_MASK (~(FMAN_ERRATA_BOUNDARY - 1))
 
@@ -50,7 +62,7 @@ static int
 dpaa_mbuf_create_pool(struct rte_mempool *mp)
 {
 	struct bman_pool *bp;
-	struct bm_buffer bufs[8];
+	struct bm_buffer bufs[FSL_BM_BURST_MAX];
 	struct dpaa_bp_info *bp_info;
 	uint8_t bpid;
 	int num_bufs = 0, ret = 0;
@@ -83,8 +95,8 @@ dpaa_mbuf_create_pool(struct rte_mempool *mp)
 		 * then in 1s for the remainder.
 		 */
 		if (ret != 1)
-			ret = bman_acquire(bp, bufs, 8, 0);
-		if (ret < 8)
+			ret = bman_acquire(bp, bufs, FSL_BM_BURST_MAX, 0);
+		if (ret < FSL_BM_BURST_MAX)
 			ret = bman_acquire(bp, bufs, 1, 0);
 		if (ret > 0)
 			num_bufs += ret;
@@ -115,7 +127,7 @@ dpaa_mbuf_create_pool(struct rte_mempool *mp)
 	rte_dpaa_bpid_info[bpid].ptov_off = 0;
 	rte_dpaa_bpid_info[bpid].flags = 0;
 
-	bp_info = rte_malloc(NULL,
+	bp_info = rte_zmalloc(NULL,
 			     sizeof(struct dpaa_bp_info),
 			     RTE_CACHE_LINE_SIZE);
 	if (!bp_info) {
@@ -127,6 +139,8 @@ dpaa_mbuf_create_pool(struct rte_mempool *mp)
 	rte_memcpy(bp_info, (void *)&rte_dpaa_bpid_info[bpid],
 		   sizeof(struct dpaa_bp_info));
 	mp->pool_data = (void *)bp_info;
+	s_dpaa_bpid_allocated_flag[bpid].flags = params.flags;
+	s_dpaa_bpid_allocated_flag[bpid].used = true;
 
 	DPAA_MEMPOOL_INFO("BMAN pool created for bpid =%d", bpid);
 	return 0;
@@ -136,6 +150,7 @@ static void
 dpaa_mbuf_free_pool(struct rte_mempool *mp)
 {
 	struct dpaa_bp_info *bp_info = DPAA_MEMPOOL_TO_POOL_INFO(mp);
+	uint16_t i;
 
 	MEMPOOL_INIT_FUNC_TRACE();
 
@@ -143,10 +158,25 @@ dpaa_mbuf_free_pool(struct rte_mempool *mp)
 		bman_free_pool(bp_info->bp);
 		DPAA_MEMPOOL_INFO("BMAN pool freed for bpid =%d",
 				  bp_info->bpid);
-		rte_free(mp->pool_data);
-		bp_info->bp = NULL;
+		rte_dpaa_bpid_info[bp_info->bpid].mp = NULL;
+		rte_dpaa_bpid_info[bp_info->bpid].bp = NULL;
+		s_dpaa_bpid_allocated_flag[bp_info->bpid].used = false;
+		rte_free(bp_info);
 		mp->pool_data = NULL;
 	}
+
+	if (!rte_dpaa_bpid_info)
+		return;
+
+	for (i = 0; i < DPAA_MAX_BPOOLS; i++) {
+		if (rte_dpaa_bpid_info[i].mp)
+			break;
+	}
+
+	if (i == DPAA_MAX_BPOOLS) {
+		rte_free(rte_dpaa_bpid_info);
+		rte_dpaa_bpid_info = NULL;
+	}
 }
 
 static int
@@ -481,4 +511,22 @@ static const struct rte_mempool_ops dpaa_mpool_ops = {
 	.populate = dpaa_populate,
 };
 
+#define RTE_PRIORITY_104 104
+
+RTE_FINI_PRIO(dpaa_mpool_finish, RTE_PRIORITY_104)
+{
+	uint16_t bpid;
+
+	for (bpid = 0; bpid < DPAA_MAX_BPOOLS; bpid++) {
+		if (s_dpaa_bpid_allocated_flag[bpid].used) {
+			bman_free_bpid(bpid, s_dpaa_bpid_allocated_flag[bpid].flags);
+			s_dpaa_bpid_allocated_flag[bpid].used = false;
+		}
+	}
+	if (rte_dpaa_bpid_info) {
+		rte_free(rte_dpaa_bpid_info);
+		rte_dpaa_bpid_info = NULL;
+	}
+}
+
 RTE_MEMPOOL_REGISTER_OPS(dpaa_mpool_ops);
diff --git a/drivers/mempool/dpaa/dpaa_mempool.h b/drivers/mempool/dpaa/dpaa_mempool.h
index 865b533b8f..d7ee49b557 100644
--- a/drivers/mempool/dpaa/dpaa_mempool.h
+++ b/drivers/mempool/dpaa/dpaa_mempool.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
- *   Copyright 2017,2019,2024 -2025 NXP
+ *   Copyright 2017,2019,2024 -2026 NXP
  *
  */
 #ifndef __DPAA_MEMPOOL_H__
@@ -24,6 +24,7 @@
 
 /* total number of bpools on SoC */
 #define DPAA_MAX_BPOOLS	256
+#define DPAA_INVALID_BPID DPAA_MAX_BPOOLS
 
 /* Maximum release/acquire from BMAN */
 #define DPAA_MBUF_MAX_ACQ_REL  FSL_BM_BURST_MAX
-- 
2.25.1

