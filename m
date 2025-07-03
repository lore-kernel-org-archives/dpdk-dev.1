Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B0FC83030
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 05:26:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F004402E8;
	Thu,  3 Jul 2025 07:26:05 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 737C34028C
 for <dev@dpdk.org>; Thu,  3 Jul 2025 07:26:01 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 52830201591;
 Thu,  3 Jul 2025 07:26:01 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 23705202A05;
 Thu,  3 Jul 2025 07:26:01 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3EAB91800241;
 Thu,  3 Jul 2025 13:26:00 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [v7 3/8] bus/dpaa: optimize bman acquire/release
Date: Thu,  3 Jul 2025 10:55:53 +0530
Message-Id: <20250703052558.3700573-4-vanshika.shukla@nxp.com>
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

1) Reduce byte swap between big endian and little endian.
2) Reduce ci(cache invalid) access by 128bit R/W instructions.
These methods improve ~10% buffer acquire/release performance.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/dpaa/base/qbman/bman.c  | 147 ++++++++++++++++++++++++----
 drivers/bus/dpaa/include/fsl_bman.h |  20 +++-
 2 files changed, 148 insertions(+), 19 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/bman.c b/drivers/bus/dpaa/base/qbman/bman.c
index 8a6290734f..037030ea19 100644
--- a/drivers/bus/dpaa/base/qbman/bman.c
+++ b/drivers/bus/dpaa/base/qbman/bman.c
@@ -1,18 +1,36 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
- * Copyright 2017 NXP
+ * Copyright 2017, 2024 NXP
  *
  */
+#include <rte_memcpy.h>
+#include <rte_branch_prediction.h>
+#include <eal_export.h>
+#include <stdint.h>
+#include <limits.h>
 
 #include "bman.h"
-#include <rte_branch_prediction.h>
 
 /* Compilation constants */
 #define RCR_THRESH	2	/* reread h/w CI when running out of space */
 #define IRQNAME		"BMan portal %d"
 #define MAX_IRQNAME	16	/* big enough for "BMan portal %d" */
 
+
+#define MAX_U16 UINT16_MAX
+#define MAX_U32 UINT32_MAX
+#ifndef BIT_SIZE
+#define BIT_SIZE(t) (sizeof(t) * 8)
+#endif
+#define MAX_U48 \
+	((((uint64_t)MAX_U16) << BIT_SIZE(uint32_t)) | MAX_U32)
+#define HI16_OF_U48(x) \
+	(((x) >> BIT_SIZE(rte_be32_t)) & MAX_U16)
+#define LO32_OF_U48(x) ((x) & MAX_U32)
+#define U48_BY_HI16_LO32(hi, lo) \
+	(((hi) << BIT_SIZE(uint32_t)) | (lo))
+
 struct bman_portal {
 	struct bm_portal p;
 	/* 2-element array. pools[0] is mask, pools[1] is snapshot. */
@@ -246,7 +264,52 @@ static void update_rcr_ci(struct bman_portal *p, int avail)
 		bm_rcr_cce_update(&p->p);
 }
 
-#define BMAN_BUF_MASK 0x0000fffffffffffful
+RTE_EXPORT_INTERNAL_SYMBOL(bman_release_fast)
+int
+bman_release_fast(struct bman_pool *pool, const uint64_t *bufs,
+	uint8_t num)
+{
+	struct bman_portal *p;
+	struct bm_rcr_entry *r;
+	uint8_t i, avail;
+	uint64_t bpid = pool->params.bpid;
+	struct bm_hw_buf_desc bm_bufs[FSL_BM_BURST_MAX];
+
+#ifdef RTE_LIBRTE_DPAA_HWDEBUG
+	if (!num || (num > FSL_BM_BURST_MAX))
+		return -EINVAL;
+	if (pool->params.flags & BMAN_POOL_FLAG_NO_RELEASE)
+		return -EINVAL;
+#endif
+
+	p = get_affine_portal();
+	avail = bm_rcr_get_avail(&p->p);
+	if (avail < 2)
+		update_rcr_ci(p, avail);
+	r = bm_rcr_start(&p->p);
+	if (unlikely(!r))
+		return -EBUSY;
+
+	/*
+	 * we can copy all but the first entry, as this can trigger badness
+	 * with the valid-bit
+	 */
+	bm_bufs[0].bpid = bpid;
+	bm_bufs[0].hi_addr = cpu_to_be16(HI16_OF_U48(bufs[0]));
+	bm_bufs[0].lo_addr = cpu_to_be32(LO32_OF_U48(bufs[0]));
+	for (i = 1; i < num; i++) {
+		bm_bufs[i].hi_addr = cpu_to_be16(HI16_OF_U48(bufs[i]));
+		bm_bufs[i].lo_addr = cpu_to_be32(LO32_OF_U48(bufs[i]));
+	}
+
+	memcpy(r->bufs, bm_bufs, sizeof(struct bm_buffer) * num);
+
+	bm_rcr_pvb_commit(&p->p, BM_RCR_VERB_CMD_BPID_SINGLE |
+		(num & BM_RCR_VERB_BUFCOUNT_MASK));
+
+	return 0;
+}
+
 int bman_release(struct bman_pool *pool, const struct bm_buffer *bufs, u8 num,
 		 u32 flags __maybe_unused)
 {
@@ -256,7 +319,7 @@ int bman_release(struct bman_pool *pool, const struct bm_buffer *bufs, u8 num,
 	u8 avail;
 
 #ifdef RTE_LIBRTE_DPAA_HWDEBUG
-	if (!num || (num > 8))
+	if (!num || (num > FSL_BM_BURST_MAX))
 		return -EINVAL;
 	if (pool->params.flags & BMAN_POOL_FLAG_NO_RELEASE)
 		return -EINVAL;
@@ -276,11 +339,11 @@ int bman_release(struct bman_pool *pool, const struct bm_buffer *bufs, u8 num,
 	 */
 	r->bufs[0].opaque =
 		cpu_to_be64(((u64)pool->params.bpid << 48) |
-			    (bufs[0].opaque & BMAN_BUF_MASK));
+			    (bufs[0].opaque & MAX_U48));
 	if (i) {
 		for (i = 1; i < num; i++)
 			r->bufs[i].opaque =
-				cpu_to_be64(bufs[i].opaque & BMAN_BUF_MASK);
+				cpu_to_be64(bufs[i].opaque & MAX_U48);
 	}
 
 	bm_rcr_pvb_commit(&p->p, BM_RCR_VERB_CMD_BPID_SINGLE |
@@ -289,16 +352,70 @@ int bman_release(struct bman_pool *pool, const struct bm_buffer *bufs, u8 num,
 	return 0;
 }
 
+static inline uint64_t
+bman_extract_addr(struct bm_buffer *buf)
+{
+	buf->opaque = be64_to_cpu(buf->opaque);
+
+	return buf->addr;
+}
+
+static inline uint64_t
+bman_hw_extract_addr(struct bm_hw_buf_desc *buf)
+{
+	uint64_t hi, lo;
+
+	hi = be16_to_cpu(buf->hi_addr);
+	lo = be32_to_cpu(buf->lo_addr);
+	return U48_BY_HI16_LO32(hi, lo);
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(bman_acquire_fast)
+int
+bman_acquire_fast(struct bman_pool *pool, uint64_t *bufs, uint8_t num)
+{
+	struct bman_portal *p = get_affine_portal();
+	struct bm_mc_command *mcc;
+	struct bm_mc_result *mcr;
+	uint8_t i, rst;
+	struct bm_hw_buf_desc bm_bufs[FSL_BM_BURST_MAX];
+
+#ifdef RTE_LIBRTE_DPAA_HWDEBUG
+	if (!num || (num > FSL_BM_BURST_MAX))
+		return -EINVAL;
+	if (pool->params.flags & BMAN_POOL_FLAG_ONLY_RELEASE)
+		return -EINVAL;
+#endif
+
+	mcc = bm_mc_start(&p->p);
+	mcc->acquire.bpid = pool->params.bpid;
+	bm_mc_commit(&p->p, BM_MCC_VERB_CMD_ACQUIRE |
+			(num & BM_MCC_VERB_ACQUIRE_BUFCOUNT));
+	while (!(mcr = bm_mc_result(&p->p)))
+		;
+	rst = mcr->verb & BM_MCR_VERB_ACQUIRE_BUFCOUNT;
+	if (unlikely(!rst))
+		return 0;
+
+	rte_memcpy(bm_bufs, mcr->acquire.bufs,
+		sizeof(struct bm_buffer) * rst);
+
+	for (i = 0; i < rst; i++)
+		bufs[i] = bman_hw_extract_addr(&bm_bufs[i]);
+
+	return rst;
+}
+
 int bman_acquire(struct bman_pool *pool, struct bm_buffer *bufs, u8 num,
 		 u32 flags __maybe_unused)
 {
 	struct bman_portal *p = get_affine_portal();
 	struct bm_mc_command *mcc;
 	struct bm_mc_result *mcr;
-	int ret, i;
+	uint8_t rst, i;
 
 #ifdef RTE_LIBRTE_DPAA_HWDEBUG
-	if (!num || (num > 8))
+	if (!num || (num > FSL_BM_BURST_MAX))
 		return -EINVAL;
 	if (pool->params.flags & BMAN_POOL_FLAG_ONLY_RELEASE)
 		return -EINVAL;
@@ -310,15 +427,11 @@ int bman_acquire(struct bman_pool *pool, struct bm_buffer *bufs, u8 num,
 			(num & BM_MCC_VERB_ACQUIRE_BUFCOUNT));
 	while (!(mcr = bm_mc_result(&p->p)))
 		cpu_relax();
-	ret = mcr->verb & BM_MCR_VERB_ACQUIRE_BUFCOUNT;
-	if (bufs) {
-		for (i = 0; i < num; i++)
-			bufs[i].opaque =
-				be64_to_cpu(mcr->acquire.bufs[i].opaque);
-	}
-	if (ret != num)
-		ret = -ENOMEM;
-	return ret;
+	rst = mcr->verb & BM_MCR_VERB_ACQUIRE_BUFCOUNT;
+	for (i = 0; i < rst; i++)
+		bufs[i].opaque = be64_to_cpu(mcr->acquire.bufs[i].opaque);
+
+	return rst;
 }
 
 int bman_query_pools(struct bm_pool_state *state)
diff --git a/drivers/bus/dpaa/include/fsl_bman.h b/drivers/bus/dpaa/include/fsl_bman.h
index c0760149e1..0107ced8c5 100644
--- a/drivers/bus/dpaa/include/fsl_bman.h
+++ b/drivers/bus/dpaa/include/fsl_bman.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
  *
  * Copyright 2008-2012 Freescale Semiconductor, Inc.
+ * Copyright 2024 NXP
  *
  */
 
@@ -68,6 +69,14 @@ struct __rte_aligned(8) bm_buffer {
 		u64 opaque;
 	};
 };
+
+struct __rte_packed_begin bm_hw_buf_desc {
+	uint8_t rsv;
+	uint8_t bpid;
+	rte_be16_t hi_addr; /* High 16-bits of 48-bit address */
+	rte_be32_t lo_addr; /* Low 32-bits of 48-bit address */
+} __rte_packed_end;
+
 static inline u64 bm_buffer_get64(const struct bm_buffer *buf)
 {
 	return buf->addr;
@@ -85,6 +94,8 @@ static inline dma_addr_t bm_buf_addr(const struct bm_buffer *buf)
 		__buf931->lo = lower_32_bits(v); \
 	} while (0)
 
+#define FSL_BM_BURST_MAX 8
+
 /* See 1.5.3.5.4: "Release Command" */
 struct __rte_packed_begin bm_rcr_entry {
 	union {
@@ -93,7 +104,7 @@ struct __rte_packed_begin bm_rcr_entry {
 			u8 bpid; /* used with BM_RCR_VERB_CMD_BPID_SINGLE */
 			u8 __reserved1[62];
 		};
-		struct bm_buffer bufs[8];
+		struct bm_buffer bufs[FSL_BM_BURST_MAX];
 	};
 } __rte_packed_end;
 #define BM_RCR_VERB_VBIT		0x80
@@ -148,7 +159,7 @@ struct __rte_packed_begin bm_mc_result {
 				u8 bpid;
 				u8 __reserved2[62];
 			};
-			struct bm_buffer bufs[8];
+			struct bm_buffer bufs[FSL_BM_BURST_MAX];
 		} acquire;
 		struct bm_pool_state query;
 	};
@@ -297,6 +308,9 @@ const struct bman_pool_params *bman_get_params(const struct bman_pool *pool);
 __rte_internal
 int bman_release(struct bman_pool *pool, const struct bm_buffer *bufs, u8 num,
 		 u32 flags);
+__rte_internal
+int bman_release_fast(struct bman_pool *pool, const uint64_t *bufs,
+	uint8_t num);
 
 /**
  * bman_acquire - Acquire buffer(s) from a buffer pool
@@ -311,6 +325,8 @@ int bman_release(struct bman_pool *pool, const struct bm_buffer *bufs, u8 num,
 __rte_internal
 int bman_acquire(struct bman_pool *pool, struct bm_buffer *bufs, u8 num,
 		 u32 flags);
+__rte_internal
+int bman_acquire_fast(struct bman_pool *pool, uint64_t *bufs, uint8_t num);
 
 /**
  * bman_query_pools - Query all buffer pool states
-- 
2.25.1

