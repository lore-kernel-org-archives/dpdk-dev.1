Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02766C83030
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 05:26:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03E1B40615;
	Thu,  3 Jul 2025 07:26:07 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 4BCC940299
 for <dev@dpdk.org>; Thu,  3 Jul 2025 07:26:02 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2D0DA2026C1;
 Thu,  3 Jul 2025 07:26:02 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EDEEC202A20;
 Thu,  3 Jul 2025 07:26:01 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 15D651800086;
 Thu,  3 Jul 2025 13:26:01 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [v7 5/8] mempool/dpaa: adjust pool element for LS1043A errata
Date: Thu,  3 Jul 2025 10:55:55 +0530
Message-Id: <20250703052558.3700573-6-vanshika.shukla@nxp.com>
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

Adjust every element of pool by populate callback.
1) Make sure start DMA address is aligned with 16B.
2) For buffer across 4KB boundary, make sure start DMA address is
   aligned with 256B.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/mempool/dpaa/dpaa_mempool.c | 144 +++++++++++++++++++++++++++-
 drivers/mempool/dpaa/dpaa_mempool.h |  11 ++-
 2 files changed, 149 insertions(+), 6 deletions(-)

diff --git a/drivers/mempool/dpaa/dpaa_mempool.c b/drivers/mempool/dpaa/dpaa_mempool.c
index 6c850f5cb2..2f9395b3f4 100644
--- a/drivers/mempool/dpaa/dpaa_mempool.c
+++ b/drivers/mempool/dpaa/dpaa_mempool.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
- *   Copyright 2017,2019,2023 NXP
+ *   Copyright 2017,2019,2023-2025 NXP
  *
  */
 
@@ -29,6 +29,9 @@
 #include <dpaa_mempool.h>
 #include <dpaax_iova_table.h>
 
+#define FMAN_ERRATA_BOUNDARY ((uint64_t)4096)
+#define FMAN_ERRATA_BOUNDARY_MASK (~(FMAN_ERRATA_BOUNDARY - 1))
+
 /* List of all the memseg information locally maintained in dpaa driver. This
  * is to optimize the PA_to_VA searches until a better mechanism (algo) is
  * available.
@@ -51,6 +54,7 @@ dpaa_mbuf_create_pool(struct rte_mempool *mp)
 	struct dpaa_bp_info *bp_info;
 	uint8_t bpid;
 	int num_bufs = 0, ret = 0;
+	uint16_t elem_max_size;
 	struct bman_pool_params params = {
 		.flags = BMAN_POOL_FLAG_DYNAMIC_BPID
 	};
@@ -101,9 +105,11 @@ dpaa_mbuf_create_pool(struct rte_mempool *mp)
 		}
 	}
 
+	elem_max_size = rte_pktmbuf_data_room_size(mp);
+
 	rte_dpaa_bpid_info[bpid].mp = mp;
 	rte_dpaa_bpid_info[bpid].bpid = bpid;
-	rte_dpaa_bpid_info[bpid].size = mp->elt_size;
+	rte_dpaa_bpid_info[bpid].size = elem_max_size;
 	rte_dpaa_bpid_info[bpid].bp = bp;
 	rte_dpaa_bpid_info[bpid].meta_data_size =
 		sizeof(struct rte_mbuf) + rte_pktmbuf_priv_size(mp);
@@ -296,6 +302,130 @@ dpaa_mbuf_get_count(const struct rte_mempool *mp)
 	return bman_query_free_buffers(bp_info->bp);
 }
 
+static int
+dpaa_check_obj_bounds(char *obj, size_t pg_sz, size_t elt_sz)
+{
+	if (!pg_sz || elt_sz > pg_sz)
+		return true;
+
+	if (RTE_PTR_ALIGN(obj, pg_sz) !=
+		RTE_PTR_ALIGN(obj + elt_sz - 1, pg_sz))
+		return false;
+	return true;
+}
+
+static void
+dpaa_adjust_obj_bounds(char *va, size_t *offset,
+	size_t pg_sz, size_t total, uint32_t flags)
+{
+	size_t off = *offset;
+
+	if (dpaa_check_obj_bounds(va + off, pg_sz, total) == false) {
+		off += RTE_PTR_ALIGN_CEIL(va + off, pg_sz) - (va + off);
+		if (flags & RTE_MEMPOOL_POPULATE_F_ALIGN_OBJ)
+			off += total - ((((size_t)va + off - 1) % total) + 1);
+	}
+
+	*offset = off;
+}
+
+static int
+dpaa_mbuf_ls1043a_errata_obj_adjust(uint8_t **pobj,
+	uint32_t header_size, size_t *poff, size_t data_room)
+{
+	uint8_t *obj = *pobj;
+	size_t off = *poff, buf_addr, end;
+
+	if (RTE_PKTMBUF_HEADROOM % FMAN_ERRATA_BUF_START_ALIGN) {
+		DPAA_MEMPOOL_ERR("RTE_PKTMBUF_HEADROOM(%d) NOT aligned to %d",
+			RTE_PKTMBUF_HEADROOM,
+			FMAN_ERRATA_BUF_START_ALIGN);
+		return -1;
+	}
+	if (header_size % FMAN_ERRATA_BUF_START_ALIGN) {
+		DPAA_MEMPOOL_ERR("Header size(%d) NOT aligned to %d",
+			header_size,
+			FMAN_ERRATA_BUF_START_ALIGN);
+		return -1;
+	}
+
+	/** All FMAN DMA start addresses (for example, BMAN buffer
+	 * address, FD[address] + FD[offset]) are 16B aligned.
+	 */
+	buf_addr = (size_t)obj + header_size;
+	while (!rte_is_aligned((void *)buf_addr,
+		FMAN_ERRATA_BUF_START_ALIGN)) {
+		off++;
+		obj++;
+		buf_addr = (size_t)obj + header_size;
+	}
+
+	/** Frame buffers must not span a 4KB address boundary,
+	 * unless the frame start address is 256 byte aligned.
+	 */
+	end = buf_addr + data_room;
+	if (((buf_addr + RTE_PKTMBUF_HEADROOM) &
+		FMAN_ERRATA_BOUNDARY_MASK) ==
+		(end & FMAN_ERRATA_BOUNDARY_MASK))
+		goto quit;
+
+	while (!rte_is_aligned((void *)(buf_addr + RTE_PKTMBUF_HEADROOM),
+		FMAN_ERRATA_4K_SPAN_ADDR_ALIGN)) {
+		off++;
+		obj++;
+		buf_addr = (size_t)obj + header_size;
+	}
+quit:
+	*pobj = obj;
+	*poff = off;
+
+	return 0;
+}
+
+static int
+dpaa_mbuf_op_pop_helper(struct rte_mempool *mp, uint32_t flags,
+	uint32_t max_objs, void *vaddr, rte_iova_t iova,
+	size_t len, struct dpaa_bp_info *bp_info,
+	rte_mempool_populate_obj_cb_t *obj_cb, void *obj_cb_arg)
+{
+	char *va = vaddr;
+	size_t total_elt_sz, pg_sz, off;
+	uint32_t i;
+	void *obj;
+	int ret;
+	uint16_t data_room = rte_pktmbuf_data_room_size(mp);
+
+	ret = rte_mempool_get_page_size(mp, &pg_sz);
+	if (ret < 0)
+		return ret;
+
+	total_elt_sz = mp->header_size + mp->elt_size + mp->trailer_size;
+
+	if (flags & RTE_MEMPOOL_POPULATE_F_ALIGN_OBJ)
+		off = total_elt_sz - (((uintptr_t)(va - 1) % total_elt_sz) + 1);
+	else
+		off = 0;
+	for (i = 0; i < max_objs; i++) {
+		/* avoid objects to cross page boundaries */
+		dpaa_adjust_obj_bounds(va, &off, pg_sz, total_elt_sz, flags);
+		if (off + total_elt_sz > len)
+			break;
+
+		off += mp->header_size;
+		obj = va + off;
+		if (dpaa_soc_ver() == SVR_LS1043A_FAMILY) {
+			dpaa_mbuf_ls1043a_errata_obj_adjust((uint8_t **)&obj,
+				bp_info->meta_data_size, &off, data_room);
+		}
+		obj_cb(mp, obj_cb_arg, obj,
+			(iova == RTE_BAD_IOVA) ? RTE_BAD_IOVA : (iova + off));
+		rte_mempool_ops_enqueue_bulk(mp, &obj, 1);
+		off += mp->elt_size + mp->trailer_size;
+	}
+
+	return i;
+}
+
 static int
 dpaa_populate(struct rte_mempool *mp, unsigned int max_objs,
 	      void *vaddr, rte_iova_t paddr, size_t len,
@@ -303,9 +433,14 @@ dpaa_populate(struct rte_mempool *mp, unsigned int max_objs,
 {
 	struct dpaa_bp_info *bp_info;
 	unsigned int total_elt_sz;
+	struct dpaa_memseg *ms;
 
 	if (!mp || !mp->pool_data) {
 		DPAA_MEMPOOL_ERR("Invalid mempool provided");
+		if (dpaa_soc_ver() == SVR_LS1043A_FAMILY) {
+			/** populate must be successful for LS1043A*/
+			return -EINVAL;
+		}
 		return 0;
 	}
 
@@ -321,7 +456,6 @@ dpaa_populate(struct rte_mempool *mp, unsigned int max_objs,
 	/* Detect pool area has sufficient space for elements in this memzone */
 	if (len >= total_elt_sz * mp->size)
 		bp_info->flags |= DPAA_MPOOL_SINGLE_SEGMENT;
-	struct dpaa_memseg *ms;
 
 	/* For each memory chunk pinned to the Mempool, a linked list of the
 	 * contained memsegs is created for searching when PA to VA
@@ -347,8 +481,8 @@ dpaa_populate(struct rte_mempool *mp, unsigned int max_objs,
 	 */
 	TAILQ_INSERT_HEAD(&rte_dpaa_memsegs, ms, next);
 
-	return rte_mempool_op_populate_helper(mp, 0, max_objs, vaddr, paddr,
-					       len, obj_cb, obj_cb_arg);
+	return dpaa_mbuf_op_pop_helper(mp, 0, max_objs, vaddr, paddr,
+			len, bp_info, obj_cb, obj_cb_arg);
 }
 
 static const struct rte_mempool_ops dpaa_mpool_ops = {
diff --git a/drivers/mempool/dpaa/dpaa_mempool.h b/drivers/mempool/dpaa/dpaa_mempool.h
index 5ca53c7ff9..865b533b8f 100644
--- a/drivers/mempool/dpaa/dpaa_mempool.h
+++ b/drivers/mempool/dpaa/dpaa_mempool.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
- *   Copyright 2017,2019 NXP
+ *   Copyright 2017,2019,2024 -2025 NXP
  *
  */
 #ifndef __DPAA_MEMPOOL_H__
@@ -31,6 +31,15 @@
 /* Buffers are allocated from single mem segment i.e. phys contiguous */
 #define DPAA_MPOOL_SINGLE_SEGMENT  0x01
 
+#define FMAN_ERRATA_4K_SPAN_ADDR_ALIGN 256
+#define FMAN_ERRATA_4K_SPAN_ADDR_MASK \
+	(FMAN_ERRATA_4K_SPAN_ADDR_ALIGN - 1)
+
+#define FMAN_ERRATA_BUF_START_ALIGN 16
+#define FMAN_ERRATA_BUF_START_MASK (FMAN_ERRATA_BUF_START_ALIGN - 1)
+#define FMAN_ERRATA_SG_LEN_ALIGN 16
+#define FMAN_ERRATA_SG_LEN_MASK (FMAN_ERRATA_SG_LEN_ALIGN - 1)
+
 struct dpaa_bp_info {
 	struct rte_mempool *mp;
 	struct bman_pool *bp;
-- 
2.25.1

