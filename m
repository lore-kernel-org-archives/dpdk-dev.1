Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81053C83030
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 05:26:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CB75402F2;
	Thu,  3 Jul 2025 07:26:06 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 1AEED40298
 for <dev@dpdk.org>; Thu,  3 Jul 2025 07:26:02 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E0D721A258E;
 Thu,  3 Jul 2025 07:26:01 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8ECB51A2A47;
 Thu,  3 Jul 2025 07:26:01 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A4326180007B;
 Thu,  3 Jul 2025 13:26:00 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [v7 4/8] mempool/dpaa: fast acquire and release
Date: Thu,  3 Jul 2025 10:55:54 +0530
Message-Id: <20250703052558.3700573-5-vanshika.shukla@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250703052558.3700573-1-vanshika.shukla@nxp.com>
References: <20250702101026.3301762-1-vanshika.shukla@nxp.com>
 <20250703052558.3700573-1-vanshika.shukla@nxp.com>
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

Use new BMan APIs to improve performance and support burst release.
Improve release performance ~90% by burst release.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/mempool/dpaa/dpaa_mempool.c | 85 ++++++++++++-----------------
 drivers/mempool/dpaa/dpaa_mempool.h |  2 +-
 2 files changed, 36 insertions(+), 51 deletions(-)

diff --git a/drivers/mempool/dpaa/dpaa_mempool.c b/drivers/mempool/dpaa/dpaa_mempool.c
index 7dacaa9513..6c850f5cb2 100644
--- a/drivers/mempool/dpaa/dpaa_mempool.c
+++ b/drivers/mempool/dpaa/dpaa_mempool.c
@@ -157,61 +157,46 @@ dpaa_mbuf_free_pool(struct rte_mempool *mp)
 	}
 }
 
-static void
-dpaa_buf_free(struct dpaa_bp_info *bp_info, uint64_t addr)
-{
-	struct bm_buffer buf;
-	int ret;
-
-	DPAA_MEMPOOL_DPDEBUG("Free 0x%" PRIx64 " to bpid: %d",
-			   addr, bp_info->bpid);
-
-	bm_buffer_set64(&buf, addr);
-retry:
-	ret = bman_release(bp_info->bp, &buf, 1, 0);
-	if (ret) {
-		DPAA_MEMPOOL_DEBUG("BMAN busy. Retrying...");
-		cpu_spin(CPU_SPIN_BACKOFF_CYCLES);
-		goto retry;
-	}
-}
-
 static int
 dpaa_mbuf_free_bulk(struct rte_mempool *pool,
 		    void *const *obj_table,
-		    unsigned int n)
+		    unsigned int count)
 {
 	struct dpaa_bp_info *bp_info = DPAA_MEMPOOL_TO_POOL_INFO(pool);
 	int ret;
-	unsigned int i = 0;
+	uint32_t n = 0, i, left;
+	uint64_t phys[DPAA_MBUF_MAX_ACQ_REL];
 
 	DPAA_MEMPOOL_DPDEBUG("Request to free %d buffers in bpid = %d",
-			     n, bp_info->bpid);
+			     count, bp_info->bpid);
 
 	if (unlikely(!DPAA_PER_LCORE_PORTAL)) {
 		ret = rte_dpaa_portal_init((void *)0);
 		if (ret) {
 			DPAA_MEMPOOL_ERR("rte_dpaa_portal_init failed with ret: %d",
 					 ret);
-			return 0;
+			return ret;
 		}
 	}
 
-	while (i < n) {
-		uint64_t phy = rte_mempool_virt2iova(obj_table[i]);
-
-		if (unlikely(!bp_info->ptov_off)) {
-			/* buffers are from single mem segment */
-			if (bp_info->flags & DPAA_MPOOL_SINGLE_SEGMENT) {
-				bp_info->ptov_off = (size_t)obj_table[i] - phy;
-				rte_dpaa_bpid_info[bp_info->bpid].ptov_off
-						= bp_info->ptov_off;
-			}
+	while (n < count) {
+		/* Acquire is all-or-nothing, so we drain in 7s,
+		 * then the remainder.
+		 */
+		if ((count - n) > DPAA_MBUF_MAX_ACQ_REL)
+			left = DPAA_MBUF_MAX_ACQ_REL;
+		else
+			left = count - n;
+
+		for (i = 0; i < left; i++) {
+			phys[i] = rte_mempool_virt2iova(obj_table[n]);
+			phys[i] += bp_info->meta_data_size;
+			n++;
 		}
-
-		dpaa_buf_free(bp_info,
-			      (uint64_t)phy + bp_info->meta_data_size);
-		i = i + 1;
+release_again:
+		ret = bman_release_fast(bp_info->bp, phys, left);
+		if (unlikely(ret))
+			goto release_again;
 	}
 
 	DPAA_MEMPOOL_DPDEBUG("freed %d buffers in bpid =%d",
@@ -226,9 +211,9 @@ dpaa_mbuf_alloc_bulk(struct rte_mempool *pool,
 		     unsigned int count)
 {
 	struct rte_mbuf **m = (struct rte_mbuf **)obj_table;
-	struct bm_buffer bufs[DPAA_MBUF_MAX_ACQ_REL];
+	uint64_t bufs[DPAA_MBUF_MAX_ACQ_REL];
 	struct dpaa_bp_info *bp_info;
-	void *bufaddr;
+	uint8_t *bufaddr;
 	int i, ret;
 	unsigned int n = 0;
 
@@ -240,7 +225,7 @@ dpaa_mbuf_alloc_bulk(struct rte_mempool *pool,
 	if (unlikely(count >= (RTE_MEMPOOL_CACHE_MAX_SIZE * 2))) {
 		DPAA_MEMPOOL_ERR("Unable to allocate requested (%u) buffers",
 				 count);
-		return -1;
+		return -EINVAL;
 	}
 
 	if (unlikely(!DPAA_PER_LCORE_PORTAL)) {
@@ -248,7 +233,7 @@ dpaa_mbuf_alloc_bulk(struct rte_mempool *pool,
 		if (ret) {
 			DPAA_MEMPOOL_ERR("rte_dpaa_portal_init failed with ret: %d",
 					 ret);
-			return -1;
+			return ret;
 		}
 	}
 
@@ -257,10 +242,11 @@ dpaa_mbuf_alloc_bulk(struct rte_mempool *pool,
 		 * then the remainder.
 		 */
 		if ((count - n) > DPAA_MBUF_MAX_ACQ_REL) {
-			ret = bman_acquire(bp_info->bp, bufs,
-					   DPAA_MBUF_MAX_ACQ_REL, 0);
+			ret = bman_acquire_fast(bp_info->bp, bufs,
+				DPAA_MBUF_MAX_ACQ_REL);
 		} else {
-			ret = bman_acquire(bp_info->bp, bufs, count - n, 0);
+			ret = bman_acquire_fast(bp_info->bp, bufs,
+				count - n);
 		}
 		/* In case of less than requested number of buffers available
 		 * in pool, qbman_swp_acquire returns 0
@@ -275,16 +261,15 @@ dpaa_mbuf_alloc_bulk(struct rte_mempool *pool,
 			return -ENOBUFS;
 		}
 		/* assigning mbuf from the acquired objects */
-		for (i = 0; (i < ret) && bufs[i].addr; i++) {
+		for (i = 0; (i < ret) && bufs[i]; i++) {
 			/* TODO-errata - observed that bufs may be null
 			 * i.e. first buffer is valid, remaining 6 buffers
 			 * may be null.
 			 */
-			bufaddr = DPAA_MEMPOOL_PTOV(bp_info, bufs[i].addr);
-			m[n] = (struct rte_mbuf *)((char *)bufaddr
-						- bp_info->meta_data_size);
-			DPAA_MEMPOOL_DPDEBUG("Paddr (%p), FD (%p) from BMAN",
-					     (void *)bufaddr, (void *)m[n]);
+			bufaddr = DPAA_MEMPOOL_PTOV(bp_info, bufs[i]);
+			m[n] = (void *)(bufaddr - bp_info->meta_data_size);
+			DPAA_MEMPOOL_DPDEBUG("Vaddr(%p), mbuf(%p) from BMAN",
+				bufaddr, m[n]);
 			n++;
 		}
 	}
diff --git a/drivers/mempool/dpaa/dpaa_mempool.h b/drivers/mempool/dpaa/dpaa_mempool.h
index 0877068fdd..5ca53c7ff9 100644
--- a/drivers/mempool/dpaa/dpaa_mempool.h
+++ b/drivers/mempool/dpaa/dpaa_mempool.h
@@ -26,7 +26,7 @@
 #define DPAA_MAX_BPOOLS	256
 
 /* Maximum release/acquire from BMAN */
-#define DPAA_MBUF_MAX_ACQ_REL  8
+#define DPAA_MBUF_MAX_ACQ_REL  FSL_BM_BURST_MAX
 
 /* Buffers are allocated from single mem segment i.e. phys contiguous */
 #define DPAA_MPOOL_SINGLE_SEGMENT  0x01
-- 
2.25.1

