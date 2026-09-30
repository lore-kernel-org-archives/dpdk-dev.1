Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8676BCA5FAB
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 06:26:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 707B142E61;
	Wed, 30 Sep 2026 08:25:27 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 434E8427CE
 for <dev@dpdk.org>; Wed, 30 Sep 2026 08:24:47 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2898D200203;
 Wed, 30 Sep 2026 08:24:47 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E72ED200204;
 Wed, 30 Sep 2026 08:24:46 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6A1C818000BE;
 Wed, 30 Sep 2026 14:24:46 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v18 19/24] bus/dpaa: optimize DPAA multi-entry buffer pool
 operations
Date: Wed, 30 Sep 2026 11:54:32 +0530
Message-Id: <20260930062437.3019096-20-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260930062437.3019096-1-hemant.agrawal@nxp.com>
References: <20260929104519.1770698-1-hemant.agrawal@nxp.com>
 <20260930062437.3019096-1-hemant.agrawal@nxp.com>
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

Replace the hardcoded buffer acquire count of 8 with the FSL_BM_BURST_MAX
constant when acquiring buffers from the buffer pool.

Add a big-endian hardware buffer descriptor overlay (struct bm_hw_buf_desc)
to the bm_buffer union so a release or acquire entry can be built and
parsed through one 8-byte access instead of separate 16-bit and 32-bit
address halves. The bm_buffer_set64_to_be() helper writes the whole
descriptor in a single store, which also clears the reserved byte and the
bpid field so no uninitialised stack content is published to the hardware
ring, and bm_buffer_get64_from_be() reads the address back.

The MAX_U48, HI16_OF_U48, LO32_OF_U48 and U48_BY_HI16_LO32 helper macros
move from bman.c to fsl_bman.h so the new accessors can use them, and the
standalone bman_hw_extract_addr() helper is dropped in favour of
bm_buffer_get64_from_be().

When publishing to the release ring, entry 0 is written on its own
precisely because copying it would trip the ring valid bit; entries
1..n-1 are the ones copied into the ring in a single memcpy:

	r->bufs[0].opaque = bm_bufs[0].opaque;
	if (num > 1)
		memcpy(&r->bufs[1], &bm_bufs[1],
			sizeof(struct bm_buffer) * (num - 1));

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/dpaa/base/qbman/bman.c  | 52 ++++++++---------------------
 drivers/bus/dpaa/include/fsl_bman.h | 51 +++++++++++++++++++++++-----
 2 files changed, 56 insertions(+), 47 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/bman.c b/drivers/bus/dpaa/base/qbman/bman.c
index 0ae1160973..80061b31e4 100644
--- a/drivers/bus/dpaa/base/qbman/bman.c
+++ b/drivers/bus/dpaa/base/qbman/bman.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
- * Copyright 2017, 2024 NXP
+ * Copyright 2017, 2024-2026 NXP
  *
  */
 #include <rte_memcpy.h>
@@ -17,20 +17,6 @@
 #define IRQNAME		"BMan portal %d"
 #define MAX_IRQNAME	16	/* big enough for "BMan portal %d" */
 
-
-#define MAX_U16 UINT16_MAX
-#define MAX_U32 UINT32_MAX
-#ifndef BIT_SIZE
-#define BIT_SIZE(t) (sizeof(t) * 8)
-#endif
-#define MAX_U48 \
-	((((uint64_t)MAX_U16) << BIT_SIZE(uint32_t)) | MAX_U32)
-#define HI16_OF_U48(x) \
-	(((x) >> BIT_SIZE(rte_be32_t)) & MAX_U16)
-#define LO32_OF_U48(x) ((x) & MAX_U32)
-#define U48_BY_HI16_LO32(hi, lo) \
-	(((hi) << BIT_SIZE(uint32_t)) | (lo))
-
 struct bman_portal {
 	struct bm_portal p;
 	/* 2-element array. pools[0] is mask, pools[1] is snapshot. */
@@ -281,7 +267,7 @@ bman_release_fast(struct bman_pool *pool, const uint64_t *bufs,
 	struct bm_rcr_entry *r;
 	uint8_t i, avail;
 	uint64_t bpid = pool->params.bpid;
-	struct bm_hw_buf_desc bm_bufs[FSL_BM_BURST_MAX];
+	struct bm_buffer bm_bufs[FSL_BM_BURST_MAX];
 
 #ifdef RTE_LIBRTE_DPAA_HWDEBUG
 	if (!num || (num > FSL_BM_BURST_MAX))
@@ -298,19 +284,18 @@ bman_release_fast(struct bman_pool *pool, const uint64_t *bufs,
 	if (unlikely(!r))
 		return -EBUSY;
 
+	for (i = 0; i < num; i++)
+		bm_buffer_set64_to_be(&bm_bufs[i], bufs[i]);
+
+	bm_bufs[0].be_desc.bpid = bpid;
 	/*
 	 * we can copy all but the first entry, as this can trigger badness
 	 * with the valid-bit
 	 */
-	bm_bufs[0].bpid = bpid;
-	bm_bufs[0].hi_addr = cpu_to_be16(HI16_OF_U48(bufs[0]));
-	bm_bufs[0].lo_addr = cpu_to_be32(LO32_OF_U48(bufs[0]));
-	for (i = 1; i < num; i++) {
-		bm_bufs[i].hi_addr = cpu_to_be16(HI16_OF_U48(bufs[i]));
-		bm_bufs[i].lo_addr = cpu_to_be32(LO32_OF_U48(bufs[i]));
-	}
-
-	memcpy(r->bufs, bm_bufs, sizeof(struct bm_buffer) * num);
+	r->bufs[0].opaque = bm_bufs[0].opaque;
+	if (num > 1)
+		memcpy(&r->bufs[1], &bm_bufs[1],
+			sizeof(struct bm_buffer) * (num - 1));
 
 	bm_rcr_pvb_commit(&p->p, BM_RCR_VERB_CMD_BPID_SINGLE |
 		(num & BM_RCR_VERB_BUFCOUNT_MASK));
@@ -368,16 +353,6 @@ __rte_unused bman_extract_addr(struct bm_buffer *buf)
 	return buf->addr;
 }
 
-static inline uint64_t
-bman_hw_extract_addr(struct bm_hw_buf_desc *buf)
-{
-	uint64_t hi, lo;
-
-	hi = be16_to_cpu(buf->hi_addr);
-	lo = be32_to_cpu(buf->lo_addr);
-	return U48_BY_HI16_LO32(hi, lo);
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(bman_acquire_fast)
 int
 bman_acquire_fast(struct bman_pool *pool, uint64_t *bufs, uint8_t num)
@@ -386,7 +361,7 @@ bman_acquire_fast(struct bman_pool *pool, uint64_t *bufs, uint8_t num)
 	struct bm_mc_command *mcc;
 	struct bm_mc_result *mcr;
 	uint8_t i, rst;
-	struct bm_hw_buf_desc bm_bufs[FSL_BM_BURST_MAX];
+	struct bm_buffer bm_bufs[FSL_BM_BURST_MAX];
 
 #ifdef RTE_LIBRTE_DPAA_HWDEBUG
 	if (!num || (num > FSL_BM_BURST_MAX))
@@ -405,11 +380,10 @@ bman_acquire_fast(struct bman_pool *pool, uint64_t *bufs, uint8_t num)
 	if (unlikely(rst < 1 || rst > FSL_BM_BURST_MAX))
 		return -EINVAL;
 
-	rte_memcpy(bm_bufs, mcr->acquire.bufs,
-		sizeof(struct bm_buffer) * rst);
+	rte_memcpy(bm_bufs, mcr->acquire.bufs, sizeof(struct bm_buffer) * rst);
 
 	for (i = 0; i < rst; i++)
-		bufs[i] = bman_hw_extract_addr(&bm_bufs[i]);
+		bufs[i] = bm_buffer_get64_from_be(&bm_bufs[i]);
 
 	return rst;
 }
diff --git a/drivers/bus/dpaa/include/fsl_bman.h b/drivers/bus/dpaa/include/fsl_bman.h
index 88e4df503f..8c3cf82722 100644
--- a/drivers/bus/dpaa/include/fsl_bman.h
+++ b/drivers/bus/dpaa/include/fsl_bman.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2012 Freescale Semiconductor, Inc.
- * Copyright 2024 NXP
+ * Copyright 2024-2026 NXP
  *
  */
 
@@ -47,6 +47,13 @@ struct bm_mc_result;	/* MC result */
  * pool id specific to this buffer is needed (BM_RCR_VERB_CMD_BPID_MULTI,
  * BM_MCC_VERB_ACQUIRE), the 'bpid' field is used.
  */
+struct __rte_packed_begin bm_hw_buf_desc {
+	uint8_t rsv;
+	uint8_t bpid;
+	rte_be16_t hi; /* High 16-bits of 48-bit address */
+	rte_be32_t lo; /* Low 32-bits of 48-bit address */
+} __rte_packed_end;
+
 struct __rte_aligned(8) bm_buffer {
 	union {
 		struct {
@@ -71,17 +78,11 @@ struct __rte_aligned(8) bm_buffer {
 			u64 __notaddress:16;
 #endif
 		};
+		struct bm_hw_buf_desc be_desc;
 		u64 opaque;
 	};
 };
 
-struct __rte_packed_begin bm_hw_buf_desc {
-	uint8_t rsv;
-	uint8_t bpid;
-	rte_be16_t hi_addr; /* High 16-bits of 48-bit address */
-	rte_be32_t lo_addr; /* Low 32-bits of 48-bit address */
-} __rte_packed_end;
-
 static inline u64 bm_buffer_get64(const struct bm_buffer *buf)
 {
 	return buf->addr;
@@ -92,6 +93,17 @@ static inline dma_addr_t bm_buf_addr(const struct bm_buffer *buf)
 	return (dma_addr_t)buf->addr;
 }
 
+#ifndef BIT_SIZE
+#define BIT_SIZE(t) (sizeof(t) * 8)
+#endif
+#define MAX_U48 \
+	((((uint64_t)UINT16_MAX) << BIT_SIZE(uint32_t)) | UINT32_MAX)
+#define HI16_OF_U48(x) \
+	(((x) >> BIT_SIZE(uint32_t)) & UINT16_MAX)
+#define LO32_OF_U48(x) ((x) & UINT32_MAX)
+#define U48_BY_HI16_LO32(hi, lo) \
+	(((uint64_t)(hi) << BIT_SIZE(uint32_t)) | (lo))
+
 #define bm_buffer_set64(buf, v) \
 	do { \
 		struct bm_buffer *__buf931 = (buf); \
@@ -99,6 +111,29 @@ static inline dma_addr_t bm_buf_addr(const struct bm_buffer *buf)
 		__buf931->lo = lower_32_bits(v); \
 	} while (0)
 
+/*
+ * Write the whole 8-byte descriptor in one store. Besides the 48-bit
+ * address this clears the reserved byte and the bpid field, so no
+ * uninitialized stack content can be published to the hardware ring.
+ * Callers that need a bpid must set it after this macro.
+ */
+#define bm_buffer_set64_to_be(buf, v) \
+	do { \
+		struct bm_buffer *__buf931 = (buf); \
+		\
+		__buf931->opaque = cpu_to_be64((uint64_t)(v) & MAX_U48); \
+	} while (0)
+
+#define bm_buffer_get64_from_be(buf) \
+	({ \
+		uint64_t hi, lo; \
+		struct bm_buffer *__buf931 = (buf); \
+		\
+		hi = be16_to_cpu(__buf931->be_desc.hi); \
+		lo = be32_to_cpu(__buf931->be_desc.lo); \
+		U48_BY_HI16_LO32(hi, lo); \
+	})
+
 #define FSL_BM_BURST_MAX 8
 
 /* See 1.5.3.5.4: "Release Command" */
-- 
2.25.1

