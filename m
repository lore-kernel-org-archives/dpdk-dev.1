Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97FCCA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 08:55:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9018240E30;
	Mon,  5 Oct 2026 10:54:02 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id BA0AD40687
 for <dev@dpdk.org>; Mon,  5 Oct 2026 10:53:46 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9D6062000AA;
 Mon,  5 Oct 2026 10:53:46 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 679B72000BB;
 Mon,  5 Oct 2026 10:53:46 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DCC85180022D;
 Mon,  5 Oct 2026 16:53:45 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v20 17/27] drivers: release DPAA bpid on driver destructor
Date: Mon,  5 Oct 2026 14:23:27 +0530
Message-Id: <20261005085337.1069213-18-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261005085337.1069213-1-hemant.agrawal@nxp.com>
References: <20261001112430.251845-1-hemant.agrawal@nxp.com>
 <20261005085337.1069213-1-hemant.agrawal@nxp.com>
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

A BPID allocated by dpaa_mbuf_create_pool() is only returned to the
kernel allocator from dpaa_mbuf_free_pool(). An application that exits
without calling rte_mempool_free() therefore leaks the BPID, and the ID
stays reserved until the board is rebooted.

Track the allocated BPIDs and the flags they were created with in a
static per-BPID table, and add a driver destructor that releases any
BPID still marked in use at process exit. The destructor cannot touch
the bman_pool object because it lives in EAL memory that may already be
gone, so bman_free_bpid() is added to release the ID from the flags
alone.

rte_dpaa_bpid_info is deliberately left alone. It is shared hugepage
memory referenced by every Rx queue through fq->bp_array, including in
secondary processes where the Rx path installs the primary's array, so
releasing it when the last local mempool goes away would leave those
references dangling. A destructor cannot release it either, because
rte_eal_cleanup() detaches EAL memory before the destructors run. Only
the per-BPID mp and bp pointers are cleared in dpaa_mbuf_free_pool();
the array itself is left to process teardown.

Allocate bp_info with rte_zmalloc() so no uninitialised field is left
behind, and use FSL_BM_BURST_MAX instead of the open-coded 8 for the
hardware bulk acquire size.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/dpaa/base/qbman/bman.c       |  8 +++
 drivers/bus/dpaa/dpaa_bus_base_symbols.c |  1 +
 drivers/bus/dpaa/include/fsl_bman.h      |  3 ++
 drivers/mempool/dpaa/dpaa_mempool.c      | 65 +++++++++++++++++++++---
 drivers/mempool/dpaa/dpaa_mempool.h      |  2 +-
 5 files changed, 72 insertions(+), 7 deletions(-)

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
index b6ed9b2ec8..4da43f293d 100644
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
index 639e0edc96..88e4df503f 100644
--- a/drivers/bus/dpaa/include/fsl_bman.h
+++ b/drivers/bus/dpaa/include/fsl_bman.h
@@ -292,6 +292,9 @@ struct bman_pool *bman_new_pool(const struct bman_pool_params *params);
 __rte_internal
 void bman_free_pool(struct bman_pool *pool);
 
+__rte_internal
+void bman_free_bpid(u8 bpid, u32 flags);
+
 /**
  * bman_get_params - Returns a pool object's parameters.
  * @pool: the pool object
diff --git a/drivers/mempool/dpaa/dpaa_mempool.c b/drivers/mempool/dpaa/dpaa_mempool.c
index 94aea5e77c..da746a6ca9 100644
--- a/drivers/mempool/dpaa/dpaa_mempool.c
+++ b/drivers/mempool/dpaa/dpaa_mempool.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
- *   Copyright 2017,2019,2023-2025 NXP
+ *   Copyright 2017,2019,2023-2026 NXP
  *
  */
 
@@ -25,10 +25,24 @@
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
+/* Referenced from the destructor to release the BPIDs allocated by this
+ * process. The destructor cannot touch the bman_pool object because it lives
+ * in EAL memory that rte_eal_cleanup() may already have detached, so the ID
+ * is released from the recorded flags alone. This table is process-local
+ * static storage and therefore still valid at that point.
+ */
+static struct dpaa_bpid_flag s_dpaa_bpid_allocated_flag[DPAA_MAX_BPOOLS];
+
 #define FMAN_ERRATA_BOUNDARY ((uint64_t)4096)
 #define FMAN_ERRATA_BOUNDARY_MASK (~(FMAN_ERRATA_BOUNDARY - 1))
 
@@ -50,7 +64,7 @@ static int
 dpaa_mbuf_create_pool(struct rte_mempool *mp)
 {
 	struct bman_pool *bp;
-	struct bm_buffer bufs[8];
+	struct bm_buffer bufs[FSL_BM_BURST_MAX];
 	struct dpaa_bp_info *bp_info;
 	uint8_t bpid;
 	int num_bufs = 0, ret = 0;
@@ -83,8 +97,8 @@ dpaa_mbuf_create_pool(struct rte_mempool *mp)
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
@@ -115,7 +129,7 @@ dpaa_mbuf_create_pool(struct rte_mempool *mp)
 	rte_dpaa_bpid_info[bpid].ptov_off = 0;
 	rte_dpaa_bpid_info[bpid].flags = 0;
 
-	bp_info = rte_malloc(NULL,
+	bp_info = rte_zmalloc(NULL,
 			     sizeof(struct dpaa_bp_info),
 			     RTE_CACHE_LINE_SIZE);
 	if (!bp_info) {
@@ -127,6 +141,8 @@ dpaa_mbuf_create_pool(struct rte_mempool *mp)
 	rte_memcpy(bp_info, (void *)&rte_dpaa_bpid_info[bpid],
 		   sizeof(struct dpaa_bp_info));
 	mp->pool_data = (void *)bp_info;
+	s_dpaa_bpid_allocated_flag[bpid].flags = params.flags;
+	s_dpaa_bpid_allocated_flag[bpid].used = true;
 
 	DPAA_MEMPOOL_INFO("BMAN pool created for bpid =%d", bpid);
 	return 0;
@@ -143,10 +159,25 @@ dpaa_mbuf_free_pool(struct rte_mempool *mp)
 		bman_free_pool(bp_info->bp);
 		DPAA_MEMPOOL_INFO("BMAN pool freed for bpid =%d",
 				  bp_info->bpid);
-		bp_info->bp = NULL;
+		if (rte_dpaa_bpid_info != NULL) {
+			rte_dpaa_bpid_info[bp_info->bpid].mp = NULL;
+			rte_dpaa_bpid_info[bp_info->bpid].bp = NULL;
+		}
+		s_dpaa_bpid_allocated_flag[bp_info->bpid].used = false;
 		rte_free(bp_info);
 		mp->pool_data = NULL;
 	}
+
+	/* rte_dpaa_bpid_info is not freed here, and not from the driver
+	 * destructor either. It is a single fixed-size array in EAL memory,
+	 * allocated once and referenced by every Rx queue via fq->bp_array;
+	 * in a secondary process the Rx path installs the primary's array
+	 * (see dpaa_rxtx.c). Releasing it when the last local mempool goes
+	 * away would leave those references dangling, and a destructor
+	 * cannot release it either because rte_eal_cleanup() detaches EAL
+	 * memory before the destructors run. It is therefore left to the
+	 * process teardown.
+	 */
 }
 
 static int
@@ -481,4 +512,26 @@ static const struct rte_mempool_ops dpaa_mpool_ops = {
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
+
+	/* rte_dpaa_bpid_info is deliberately not freed here. It is EAL memory,
+	 * and rte_eal_cleanup() has already called rte_eal_memory_detach() by
+	 * the time the destructors run, so rte_free() would operate on an
+	 * unmapped mapping. In a secondary it is not even a local allocation:
+	 * the Rx path installs the primary's array (see dpaa_rxtx.c), so
+	 * freeing it would release the primary's live BPID table.
+	 */
+}
+
 RTE_MEMPOOL_REGISTER_OPS(dpaa_mpool_ops);
diff --git a/drivers/mempool/dpaa/dpaa_mempool.h b/drivers/mempool/dpaa/dpaa_mempool.h
index 865b533b8f..ca34747711 100644
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
-- 
2.25.1

