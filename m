Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D93C5B543
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 14:00:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EEC740DD0;
	Fri, 30 May 2025 15:58:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 7B59C40B92
 for <dev@dpdk.org>; Fri, 30 May 2025 15:58:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748613499; x=1780149499;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=J8ubl8Ti4FJESqt+E5pPswE7FssOglwu/D524LEct4E=;
 b=MEvNRjJkDPIY8iswx5++NuvdCpSGTGXWhRPG40pWPQkv1DrUIKpPA8LT
 juXQxJFkD3JvGEI7LKop9fnJ+HaXQkeVyh30yzkoRMCvKS2iCcUa6yj4r
 2RfWcYskdDCsY5KX6UlQaJqDWhixJUhviGPqL5zJd5PQNl2oG/rxIpEgB
 7CMWH9bmJNhGjh01cI5bcJLxGL9Oq33nHnvKZ4QVRlbdiFGuXI1fCH8uw
 svxyiB0n0dBpQG2LmqhzqCCJlcqTXXw6To/irTp3wMUhTxS/qBj96jYse
 P0vi4ITarhoP0CJEXSz6RfzbIqa5le8o3lzKI+xrVOymR55v87ZStTenF Q==;
X-CSE-ConnectionGUID: NmN0hoRfSG2L6g9ha1Y6Ow==
X-CSE-MsgGUID: Z/xdR0miTVGc0dHCe7VRaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="50809437"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; d="scan'208";a="50809437"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2025 06:58:17 -0700
X-CSE-ConnectionGUID: htEYTes6RBWRDbIrnlp4Jw==
X-CSE-MsgGUID: 5hwL3sf6TamyKQbt5OCFSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; d="scan'208";a="174887532"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa002.jf.intel.com with ESMTP; 30 May 2025 06:58:15 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ian Stokes <ian.stokes@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v4 21/25] net/iavf: use common Rx rearm code
Date: Fri, 30 May 2025 14:57:17 +0100
Message-ID: <7b28ca830c7e182bad74dce56965d54deddc247e.1748612804.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The iavf driver has implementations of vectorized mbuf rearm code that
is identical to the ones in the common code, so just use those.

While we're at it, also make sure to use common definitions for things like
burst size, rearm threshold, and descriptors per loop, which is currently
defined separately in each driver.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v3 -> v4:
    - Use the common descriptor format instead of constant propagation
    - Use the new unified definitions for burst size, rearm threshold, and descriptors per loop

 drivers/net/intel/iavf/iavf_rxtx.h            |   8 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   |   3 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c |   3 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 199 ------------------
 drivers/net/intel/iavf/iavf_rxtx_vec_neon.c   |  58 +----
 drivers/net/intel/iavf/iavf_rxtx_vec_sse.c    |  72 +------
 6 files changed, 13 insertions(+), 330 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 98abebae90..df5164f534 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -23,11 +23,11 @@
 #define IAVF_RX_MAX_DATA_BUF_SIZE (16 * 1024 - 128)
 
 /* used for Vector PMD */
-#define IAVF_VPMD_RX_BURST             32
+#define IAVF_VPMD_RX_BURST             CI_VPMD_RX_BURST
 #define IAVF_VPMD_TX_BURST             32
-#define IAVF_VPMD_RXQ_REARM_THRESH     32
-#define IAVF_VPMD_DESCS_PER_LOOP       4
-#define IAVF_VPMD_DESCS_PER_LOOP_WIDE  8
+#define IAVF_VPMD_RXQ_REARM_THRESH     CI_VPMD_RX_REARM_THRESH
+#define IAVF_VPMD_DESCS_PER_LOOP       CI_VPMD_DESCS_PER_LOOP
+#define IAVF_VPMD_DESCS_PER_LOOP_WIDE  CI_VPMD_DESCS_PER_LOOP_WIDE
 #define IAVF_VPMD_TX_MAX_FREE_BUF      64
 
 #define IAVF_TX_NO_VECTOR_FLAGS (				 \
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index 319f0166ce..ca118ea02e 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2019 Intel Corporation
  */
 
+#include "../common/rx_vec_x86.h"
 #include "iavf_rxtx_vec_common.h"
 
 #include <rte_vect.h>
@@ -9,7 +10,7 @@
 static __rte_always_inline void
 iavf_rxq_rearm(struct ci_rx_queue *rxq)
 {
-	iavf_rxq_rearm_common(rxq, false);
+	ci_rxq_rearm(rxq, CI_RX_VEC_LEVEL_AVX2);
 }
 
 #define PKTLEN_SHIFT     10
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index d2aeccf5e6..01ec8ddd10 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2020 Intel Corporation
  */
 
+#include "../common/rx_vec_x86.h"
 #include "iavf_rxtx_vec_common.h"
 
 #include <rte_vect.h>
@@ -29,7 +30,7 @@
 static __rte_always_inline void
 iavf_rxq_rearm(struct ci_rx_queue *rxq)
 {
-	iavf_rxq_rearm_common(rxq, true);
+	ci_rxq_rearm(rxq, CI_RX_VEC_LEVEL_AVX512);
 }
 
 #define IAVF_RX_LEN_MASK 0x80808080
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
index e98551e1fb..335e7e9af5 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
@@ -237,203 +237,4 @@ iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
 	*txd_hi |= ((uint64_t)td_cmd) << IAVF_TXD_QW1_CMD_SHIFT;
 }
 
-#ifdef RTE_ARCH_X86
-static __rte_always_inline void
-iavf_rxq_rearm_common(struct ci_rx_queue *rxq, __rte_unused bool avx512)
-{
-	int i;
-	uint16_t rx_id;
-	volatile union ci_rx_desc *rxdp;
-	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
-
-	rxdp = rxq->rx_ring + rxq->rxrearm_start;
-
-	/* Pull 'n' more MBUFs into the software ring */
-	if (rte_mempool_get_bulk(rxq->mp,
-				 (void *)rxp,
-				 IAVF_VPMD_RXQ_REARM_THRESH) < 0) {
-		if (rxq->rxrearm_nb + IAVF_VPMD_RXQ_REARM_THRESH >=
-		    rxq->nb_rx_desc) {
-			__m128i dma_addr0;
-
-			dma_addr0 = _mm_setzero_si128();
-			for (i = 0; i < IAVF_VPMD_DESCS_PER_LOOP; i++) {
-				rxp[i].mbuf = &rxq->fake_mbuf;
-				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i].read),
-						dma_addr0);
-			}
-		}
-		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			IAVF_VPMD_RXQ_REARM_THRESH;
-		return;
-	}
-
-#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
-	struct rte_mbuf *mb0, *mb1;
-	__m128i dma_addr0, dma_addr1;
-	__m128i hdr_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
-			RTE_PKTMBUF_HEADROOM);
-	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < IAVF_VPMD_RXQ_REARM_THRESH; i += 2, rxp += 2) {
-		__m128i vaddr0, vaddr1;
-
-		mb0 = rxp[0].mbuf;
-		mb1 = rxp[1].mbuf;
-
-		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
-		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
-				offsetof(struct rte_mbuf, buf_addr) + 8);
-		vaddr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
-		vaddr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
-
-		/* convert pa to dma_addr hdr/data */
-		dma_addr0 = _mm_unpackhi_epi64(vaddr0, vaddr0);
-		dma_addr1 = _mm_unpackhi_epi64(vaddr1, vaddr1);
-
-		/* add headroom to pa values */
-		dma_addr0 = _mm_add_epi64(dma_addr0, hdr_room);
-		dma_addr1 = _mm_add_epi64(dma_addr1, hdr_room);
-
-		/* flush desc with pa dma_addr */
-		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp++->read), dma_addr0);
-		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp++->read), dma_addr1);
-	}
-#else
-#ifdef CC_AVX512_SUPPORT
-	if (avx512) {
-		struct rte_mbuf *mb0, *mb1, *mb2, *mb3;
-		struct rte_mbuf *mb4, *mb5, *mb6, *mb7;
-		__m512i dma_addr0_3, dma_addr4_7;
-		__m512i hdr_room = _mm512_set1_epi64(RTE_PKTMBUF_HEADROOM);
-		/* Initialize the mbufs in vector, process 8 mbufs in one loop */
-		for (i = 0; i < IAVF_VPMD_RXQ_REARM_THRESH;
-				i += 8, rxp += 8, rxdp += 8) {
-			__m128i vaddr0, vaddr1, vaddr2, vaddr3;
-			__m128i vaddr4, vaddr5, vaddr6, vaddr7;
-			__m256i vaddr0_1, vaddr2_3;
-			__m256i vaddr4_5, vaddr6_7;
-			__m512i vaddr0_3, vaddr4_7;
-
-			mb0 = rxp[0];
-			mb1 = rxp[1];
-			mb2 = rxp[2];
-			mb3 = rxp[3];
-			mb4 = rxp[4];
-			mb5 = rxp[5];
-			mb6 = rxp[6];
-			mb7 = rxp[7];
-
-			/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
-			RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
-					offsetof(struct rte_mbuf, buf_addr) + 8);
-			vaddr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
-			vaddr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
-			vaddr2 = _mm_loadu_si128((__m128i *)&mb2->buf_addr);
-			vaddr3 = _mm_loadu_si128((__m128i *)&mb3->buf_addr);
-			vaddr4 = _mm_loadu_si128((__m128i *)&mb4->buf_addr);
-			vaddr5 = _mm_loadu_si128((__m128i *)&mb5->buf_addr);
-			vaddr6 = _mm_loadu_si128((__m128i *)&mb6->buf_addr);
-			vaddr7 = _mm_loadu_si128((__m128i *)&mb7->buf_addr);
-
-			/**
-			 * merge 0 & 1, by casting 0 to 256-bit and inserting 1
-			 * into the high lanes. Similarly for 2 & 3, and so on.
-			 */
-			vaddr0_1 =
-				_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr0),
-							vaddr1, 1);
-			vaddr2_3 =
-				_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr2),
-							vaddr3, 1);
-			vaddr4_5 =
-				_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr4),
-							vaddr5, 1);
-			vaddr6_7 =
-				_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr6),
-							vaddr7, 1);
-			vaddr0_3 =
-				_mm512_inserti64x4(_mm512_castsi256_si512(vaddr0_1),
-							vaddr2_3, 1);
-			vaddr4_7 =
-				_mm512_inserti64x4(_mm512_castsi256_si512(vaddr4_5),
-							vaddr6_7, 1);
-
-			/* convert pa to dma_addr hdr/data */
-			dma_addr0_3 = _mm512_unpackhi_epi64(vaddr0_3, vaddr0_3);
-			dma_addr4_7 = _mm512_unpackhi_epi64(vaddr4_7, vaddr4_7);
-
-			/* add headroom to pa values */
-			dma_addr0_3 = _mm512_add_epi64(dma_addr0_3, hdr_room);
-			dma_addr4_7 = _mm512_add_epi64(dma_addr4_7, hdr_room);
-
-			/* flush desc with pa dma_addr */
-			_mm512_store_si512((__m512i *)&rxdp->read, dma_addr0_3);
-			_mm512_store_si512((__m512i *)&(rxdp + 4)->read, dma_addr4_7);
-		}
-	} else
-#endif
-	{
-		struct rte_mbuf *mb0, *mb1, *mb2, *mb3;
-		__m256i dma_addr0_1, dma_addr2_3;
-		__m256i hdr_room = _mm256_set1_epi64x(RTE_PKTMBUF_HEADROOM);
-		/* Initialize the mbufs in vector, process 4 mbufs in one loop */
-		for (i = 0; i < IAVF_VPMD_RXQ_REARM_THRESH;
-				i += 4, rxp += 4, rxdp += 4) {
-			__m128i vaddr0, vaddr1, vaddr2, vaddr3;
-			__m256i vaddr0_1, vaddr2_3;
-
-			mb0 = rxp[0];
-			mb1 = rxp[1];
-			mb2 = rxp[2];
-			mb3 = rxp[3];
-
-			/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
-			RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
-					offsetof(struct rte_mbuf, buf_addr) + 8);
-			vaddr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
-			vaddr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
-			vaddr2 = _mm_loadu_si128((__m128i *)&mb2->buf_addr);
-			vaddr3 = _mm_loadu_si128((__m128i *)&mb3->buf_addr);
-
-			/**
-			 * merge 0 & 1, by casting 0 to 256-bit and inserting 1
-			 * into the high lanes. Similarly for 2 & 3
-			 */
-			vaddr0_1 =
-				_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr0),
-							vaddr1, 1);
-			vaddr2_3 =
-				_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr2),
-							vaddr3, 1);
-
-			/* convert pa to dma_addr hdr/data */
-			dma_addr0_1 = _mm256_unpackhi_epi64(vaddr0_1, vaddr0_1);
-			dma_addr2_3 = _mm256_unpackhi_epi64(vaddr2_3, vaddr2_3);
-
-			/* add headroom to pa values */
-			dma_addr0_1 = _mm256_add_epi64(dma_addr0_1, hdr_room);
-			dma_addr2_3 = _mm256_add_epi64(dma_addr2_3, hdr_room);
-
-			/* flush desc with pa dma_addr */
-			_mm256_store_si256((__m256i *)&rxdp->read, dma_addr0_1);
-			_mm256_store_si256((__m256i *)&(rxdp + 2)->read, dma_addr2_3);
-		}
-	}
-
-#endif
-
-	rxq->rxrearm_start += IAVF_VPMD_RXQ_REARM_THRESH;
-	if (rxq->rxrearm_start >= rxq->nb_rx_desc)
-		rxq->rxrearm_start = 0;
-
-	rxq->rxrearm_nb -= IAVF_VPMD_RXQ_REARM_THRESH;
-
-	rx_id = (uint16_t)((rxq->rxrearm_start == 0) ?
-			     (rxq->nb_rx_desc - 1) : (rxq->rxrearm_start - 1));
-
-	/* Update the tail pointer on the NIC */
-	IAVF_PCI_REG_WC_WRITE(rxq->qrx_tail, rx_id);
-}
-#endif
-
 #endif
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c b/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c
index 562e574aab..4ed4e9b336 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c
@@ -14,64 +14,12 @@
 #include "iavf_rxtx.h"
 #include "iavf_rxtx_vec_common.h"
 
+#include "../common/rx_vec_arm.h"
+
 static inline void
 iavf_rxq_rearm(struct ci_rx_queue *rxq)
 {
-	int i;
-	uint16_t rx_id;
-	volatile union ci_rx_desc *rxdp;
-	struct ci_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
-	struct rte_mbuf *mb0, *mb1;
-	uint64x2_t dma_addr0, dma_addr1;
-	uint64x2_t zero = vdupq_n_u64(0);
-	uint64_t paddr;
-
-	rxdp = rxq->rx_ring + rxq->rxrearm_start;
-
-	/* Pull 'n' more MBUFs into the software ring */
-	if (unlikely(rte_mempool_get_bulk(rxq->mp,
-					  (void *)rxep,
-					  IAVF_VPMD_RXQ_REARM_THRESH) < 0)) {
-		if (rxq->rxrearm_nb + IAVF_VPMD_RXQ_REARM_THRESH >=
-		    rxq->nb_rx_desc) {
-			for (i = 0; i < IAVF_VPMD_DESCS_PER_LOOP; i++) {
-				rxep[i].mbuf = &rxq->fake_mbuf;
-				vst1q_u64(RTE_CAST_PTR(uint64_t *, &rxdp[i].read), zero);
-			}
-		}
-		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			IAVF_VPMD_RXQ_REARM_THRESH;
-		return;
-	}
-
-	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < IAVF_VPMD_RXQ_REARM_THRESH; i += 2, rxep += 2) {
-		mb0 = rxep[0].mbuf;
-		mb1 = rxep[1].mbuf;
-
-		paddr = mb0->buf_iova + RTE_PKTMBUF_HEADROOM;
-		dma_addr0 = vdupq_n_u64(paddr);
-
-		/* flush desc with pa dma_addr */
-		vst1q_u64(RTE_CAST_PTR(uint64_t *, &rxdp++->read), dma_addr0);
-
-		paddr = mb1->buf_iova + RTE_PKTMBUF_HEADROOM;
-		dma_addr1 = vdupq_n_u64(paddr);
-		vst1q_u64(RTE_CAST_PTR(uint64_t *, &rxdp++->read), dma_addr1);
-	}
-
-	rxq->rxrearm_start += IAVF_VPMD_RXQ_REARM_THRESH;
-	if (rxq->rxrearm_start >= rxq->nb_rx_desc)
-		rxq->rxrearm_start = 0;
-
-	rxq->rxrearm_nb -= IAVF_VPMD_RXQ_REARM_THRESH;
-
-	rx_id = (uint16_t)((rxq->rxrearm_start == 0) ?
-			     (rxq->nb_rx_desc - 1) : (rxq->rxrearm_start - 1));
-
-	rte_io_wmb();
-	/* Update the tail pointer on the NIC */
-	IAVF_PCI_REG_WRITE_RELAXED(rxq->qrx_tail, rx_id);
+	ci_rxq_rearm(rxq);
 }
 
 static inline void
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_sse.c b/drivers/net/intel/iavf/iavf_rxtx_vec_sse.c
index 8bbcf836b7..c6589ecd81 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_sse.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_sse.c
@@ -9,82 +9,14 @@
 #include "iavf.h"
 #include "iavf_rxtx.h"
 #include "iavf_rxtx_vec_common.h"
+#include "../common/rx_vec_x86.h"
 
 #include <rte_vect.h>
 
 static inline void
 iavf_rxq_rearm(struct ci_rx_queue *rxq)
 {
-	int i;
-	uint16_t rx_id;
-
-	volatile union ci_rx_desc *rxdp;
-	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
-	struct rte_mbuf *mb0, *mb1;
-	__m128i hdr_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
-			RTE_PKTMBUF_HEADROOM);
-	__m128i dma_addr0, dma_addr1;
-
-	rxdp = rxq->rx_ring + rxq->rxrearm_start;
-
-	/* Pull 'n' more MBUFs into the software ring */
-	if (rte_mempool_get_bulk(rxq->mp, (void *)rxp,
-				 rxq->rx_free_thresh) < 0) {
-		if (rxq->rxrearm_nb + rxq->rx_free_thresh >= rxq->nb_rx_desc) {
-			dma_addr0 = _mm_setzero_si128();
-			for (i = 0; i < IAVF_VPMD_DESCS_PER_LOOP; i++) {
-				rxp[i].mbuf = &rxq->fake_mbuf;
-				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i].read),
-						dma_addr0);
-			}
-		}
-		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			rxq->rx_free_thresh;
-		return;
-	}
-
-	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < rxq->rx_free_thresh; i += 2, rxp += 2) {
-		__m128i vaddr0, vaddr1;
-
-		mb0 = rxp[0].mbuf;
-		mb1 = rxp[1].mbuf;
-
-		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
-		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
-				offsetof(struct rte_mbuf, buf_addr) + 8);
-		vaddr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
-		vaddr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
-
-		/* convert pa to dma_addr hdr/data */
-		dma_addr0 = _mm_unpackhi_epi64(vaddr0, vaddr0);
-		dma_addr1 = _mm_unpackhi_epi64(vaddr1, vaddr1);
-
-		/* add headroom to pa values */
-		dma_addr0 = _mm_add_epi64(dma_addr0, hdr_room);
-		dma_addr1 = _mm_add_epi64(dma_addr1, hdr_room);
-
-		/* flush desc with pa dma_addr */
-		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp++->read), dma_addr0);
-		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp++->read), dma_addr1);
-	}
-
-	rxq->rxrearm_start += rxq->rx_free_thresh;
-	if (rxq->rxrearm_start >= rxq->nb_rx_desc)
-		rxq->rxrearm_start = 0;
-
-	rxq->rxrearm_nb -= rxq->rx_free_thresh;
-
-	rx_id = (uint16_t)((rxq->rxrearm_start == 0) ?
-			   (rxq->nb_rx_desc - 1) : (rxq->rxrearm_start - 1));
-
-	PMD_RX_LOG(DEBUG, "port_id=%u queue_id=%u rx_tail=%u "
-		   "rearm_start=%u rearm_nb=%u",
-		   rxq->port_id, rxq->queue_id,
-		   rx_id, rxq->rxrearm_start, rxq->rxrearm_nb);
-
-	/* Update the tail pointer on the NIC */
-	IAVF_PCI_REG_WC_WRITE(rxq->qrx_tail, rx_id);
+	ci_rxq_rearm(rxq, CI_RX_VEC_LEVEL_SSE);
 }
 
 static inline void
-- 
2.47.1

