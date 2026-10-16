Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFD2CCA462
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:21:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 676A940DCD;
	Fri, 16 Oct 2026 13:20:45 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id A951A40A76
 for <dev@dpdk.org>; Fri, 16 Oct 2026 13:20:08 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 81921200206;
 Fri, 16 Oct 2026 13:20:08 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4BA642001FF;
 Fri, 16 Oct 2026 13:20:08 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C3C26180006C;
 Fri, 16 Oct 2026 19:20:07 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v27 18/25] drivers: release DPAA bpid on driver destructor
Date: Fri, 16 Oct 2026 16:49:51 +0530
Message-Id: <20261016111958.163060-19-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261016111958.163060-1-hemant.agrawal@nxp.com>
References: <20261015141144.3140281-1-hemant.agrawal@nxp.com>
 <20261016111958.163060-1-hemant.agrawal@nxp.com>
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
kernel from dpaa_mbuf_free_pool(), so an application that exits without
rte_mempool_free() leaks it until the board is rebooted.

Track the allocated BPIDs and their flags in a static table and add a
driver destructor that releases any still in use at exit. The
destructor cannot touch the bman_pool object in EAL memory, so
bman_free_bpid() releases the ID from the flags alone.

rte_dpaa_bpid_info is left to process teardown: Rx queues reference it
via fq->bp_array, and EAL memory is detached before destructors run.

Also allocate bp_info with rte_zmalloc() and use FSL_BM_BURST_MAX for
the bulk acquire size.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/dpaa/base/qbman/bman.c       |  8 ++++
 drivers/bus/dpaa/dpaa_bus_base_symbols.c |  1 +
 drivers/bus/dpaa/include/fsl_bman.h      |  3 ++
 drivers/mempool/dpaa/dpaa_mempool.c      | 51 +++++++++++++++++++++---
 4 files changed, 57 insertions(+), 6 deletions(-)

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
index 3e243a4426..0927e5fe2c 100644
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
index 94aea5e77c..5c92e2e079 100644
--- a/drivers/mempool/dpaa/dpaa_mempool.c
+++ b/drivers/mempool/dpaa/dpaa_mempool.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
- *   Copyright 2017,2019,2023-2025 NXP
+ *   Copyright 2017,2019,2023-2026 NXP
  *
  */
 
@@ -25,10 +25,21 @@
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
+/* Process-local record of allocated BPIDs, still valid in the destructor
+ * when the bman_pool object in EAL memory may already be detached.
+ */
+static struct dpaa_bpid_flag s_dpaa_bpid_allocated_flag[DPAA_MAX_BPOOLS];
+
 #define FMAN_ERRATA_BOUNDARY ((uint64_t)4096)
 #define FMAN_ERRATA_BOUNDARY_MASK (~(FMAN_ERRATA_BOUNDARY - 1))
 
@@ -50,7 +61,7 @@ static int
 dpaa_mbuf_create_pool(struct rte_mempool *mp)
 {
 	struct bman_pool *bp;
-	struct bm_buffer bufs[8];
+	struct bm_buffer bufs[FSL_BM_BURST_MAX];
 	struct dpaa_bp_info *bp_info;
 	uint8_t bpid;
 	int num_bufs = 0, ret = 0;
@@ -83,8 +94,8 @@ dpaa_mbuf_create_pool(struct rte_mempool *mp)
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
@@ -115,7 +126,7 @@ dpaa_mbuf_create_pool(struct rte_mempool *mp)
 	rte_dpaa_bpid_info[bpid].ptov_off = 0;
 	rte_dpaa_bpid_info[bpid].flags = 0;
 
-	bp_info = rte_malloc(NULL,
+	bp_info = rte_zmalloc(NULL,
 			     sizeof(struct dpaa_bp_info),
 			     RTE_CACHE_LINE_SIZE);
 	if (!bp_info) {
@@ -127,6 +138,8 @@ dpaa_mbuf_create_pool(struct rte_mempool *mp)
 	rte_memcpy(bp_info, (void *)&rte_dpaa_bpid_info[bpid],
 		   sizeof(struct dpaa_bp_info));
 	mp->pool_data = (void *)bp_info;
+	s_dpaa_bpid_allocated_flag[bpid].flags = params.flags;
+	s_dpaa_bpid_allocated_flag[bpid].used = true;
 
 	DPAA_MEMPOOL_INFO("BMAN pool created for bpid =%d", bpid);
 	return 0;
@@ -143,10 +156,18 @@ dpaa_mbuf_free_pool(struct rte_mempool *mp)
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
+	/* rte_dpaa_bpid_info is left to process teardown: Rx queues still
+	 * reference it via fq->bp_array.
+	 */
 }
 
 static int
@@ -481,4 +502,22 @@ static const struct rte_mempool_ops dpaa_mpool_ops = {
 	.populate = dpaa_populate,
 };
 
+/* RTE_FINI_PRIO() pastes this onto RTE_PRIORITY_; EAL only defines the
+ * named priorities, so declare the numeric one used below.
+ */
+#define RTE_PRIORITY_104 104
+
+RTE_FINI_PRIO(dpaa_mpool_finish, 104)
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
+}
+
 RTE_MEMPOOL_REGISTER_OPS(dpaa_mpool_ops);
-- 
2.25.1

