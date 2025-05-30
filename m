Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DCCC5B543
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 14:00:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C30540DDC;
	Fri, 30 May 2025 15:58:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 9A9DF40DFD
 for <dev@dpdk.org>; Fri, 30 May 2025 15:58:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748613502; x=1780149502;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gK8O5QFnCsh+deJt0UaV9H3VZLQJOlcX2LTDDXyDGTk=;
 b=lpP8OejbhciRdqM84KzLYGkGO8I3If/O4nEIJOwMOo9O29d0La3soWYD
 zI8qnNjvghDgxhruDumU19m/r8W5cDsW3K5wg1Urmn+vOm0X/tUe10J0Y
 xT5JZ8d3yWWK2qDp1018BSWTUJf6M4gJf+ji/nylmr6u/C5H2tFhaaT1s
 d7wVFmDzVbzI1LC2sw0fx6mGmE8mNALS9yta9tG1m07OYumGYf+h7G4r9
 uWtoSxxxGNboSgZ6F9nihMU48er3IgX4Km7nS/7OVmMFa0pGZUPrD6oN1
 /j06H59KOYIlMYT0pxS0pmwXubbauw6tmc8jQMlzdGNiUEiZRKoeJZdrp w==;
X-CSE-ConnectionGUID: jDVe2/ugRTCWt83nACgcfQ==
X-CSE-MsgGUID: jjEFKPnYSk2wXH4XPKq66g==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="50809453"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; d="scan'208";a="50809453"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2025 06:58:19 -0700
X-CSE-ConnectionGUID: b2z4oSgHSLSrB0KdPwNfOw==
X-CSE-MsgGUID: DPUlfb73SJe38z84k1LVPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; d="scan'208";a="174887543"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa002.jf.intel.com with ESMTP; 30 May 2025 06:58:18 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v4 22/25] net/ixgbe: use common Rx rearm code
Date: Fri, 30 May 2025 14:57:18 +0100
Message-ID: <94bf598f2c12704cc60e4201bc670c70c2795227.1748612804.git.anatoly.burakov@intel.com>
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

The ixgbe driver has implementations of vectorized mbuf rearm code that
is identical to the ones in the common code, so just use those.

Since ixgbe Rx descriptors are always 16-byte wide, force using 16-byte
definitions in the common headers with a define flag.

While we're at it, also make sure to use common definitions for things like
burst size, rearm threshold, and descriptors per loop, which is currently
defined separately in each driver.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v3 -> v4:
    - Use the common descriptor format instead of constant propagation
    - Use some definitional hackery to work around IXGBE descriptors always being 16-byte
    - Use the new unified definitions for burst size, rearm threshold, and descriptors per loop

 drivers/net/intel/ixgbe/ixgbe_rxtx.h          | 21 ++++-
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c | 67 +---------------
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c  | 76 +------------------
 3 files changed, 26 insertions(+), 138 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.h b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
index d1847a33dd..0640336156 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.h
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
@@ -5,9 +5,24 @@
 #ifndef _IXGBE_RXTX_H_
 #define _IXGBE_RXTX_H_
 
+/*
+ * For IXGBE, descriptor size is always 16 bytes, so in order to have all
+ * vectorized and common code building correctly and with proper offsets, force
+ * the common parts to consider IXGBE descriptors to be 16-bytes in size.
+ */
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
+#define IXGBE_FORCE_16BYTE_DESC
+#define RTE_NET_INTEL_USE_16BYTE_DESC
+#endif
+
 #include "../common/rx.h"
 #include "../common/tx.h"
 
+#ifdef IXGBE_FORCE_16BYTE_DESC
+#undef RTE_NET_INTEL_USE_16BYTE_DESC
+#undef IXGBE_FORCE_16BYTE_DESC
+#endif
+
 /*
  * Rings setup and release.
  *
@@ -34,10 +49,10 @@
 #define IXGBE_RX_MAX_BURST            CI_RX_MAX_BURST
 #define IXGBE_TX_MAX_FREE_BUF_SZ      64
 
-#define IXGBE_VPMD_DESCS_PER_LOOP     4
+#define IXGBE_VPMD_DESCS_PER_LOOP     CI_VPMD_DESCS_PER_LOOP
 
-#define IXGBE_VPMD_RXQ_REARM_THRESH   32
-#define IXGBE_VPMD_RX_BURST           IXGBE_VPMD_RXQ_REARM_THRESH
+#define IXGBE_VPMD_RXQ_REARM_THRESH   CI_VPMD_RX_REARM_THRESH
+#define IXGBE_VPMD_RX_BURST           CI_VPMD_RX_BURST
 
 #define RX_RING_SZ ((IXGBE_MAX_RING_DESC + IXGBE_RX_MAX_BURST) * \
 		    sizeof(union ixgbe_adv_rx_desc))
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
index 82c655e769..481ff61c60 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
@@ -11,72 +11,13 @@
 #include "ixgbe_rxtx.h"
 #include "ixgbe_rxtx_vec_common.h"
 
+#include "../common/rx_vec_arm.h"
+
 static inline void
 ixgbe_rxq_rearm(struct ci_rx_queue *rxq)
 {
-	int i;
-	uint16_t rx_id;
-	volatile union ixgbe_adv_rx_desc *rxdp;
-	struct ci_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
-	struct rte_mbuf *mb0, *mb1;
-	uint64x2_t dma_addr0, dma_addr1;
-	uint64x2_t zero = vdupq_n_u64(0);
-	uint64_t paddr;
-	uint8x8_t p;
-
-	rxdp = rxq->ixgbe_rx_ring + rxq->rxrearm_start;
-
-	/* Pull 'n' more MBUFs into the software ring */
-	if (unlikely(rte_mempool_get_bulk(rxq->mp,
-					  (void *)rxep,
-					  IXGBE_VPMD_RXQ_REARM_THRESH) < 0)) {
-		if (rxq->rxrearm_nb + IXGBE_VPMD_RXQ_REARM_THRESH >=
-		    rxq->nb_rx_desc) {
-			for (i = 0; i < IXGBE_VPMD_DESCS_PER_LOOP; i++) {
-				rxep[i].mbuf = &rxq->fake_mbuf;
-				vst1q_u64(RTE_CAST_PTR(uint64_t *, &rxdp[i].read),
-					  zero);
-			}
-		}
-		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			IXGBE_VPMD_RXQ_REARM_THRESH;
-		return;
-	}
-
-	p = vld1_u8((uint8_t *)&rxq->mbuf_initializer);
-
-	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < IXGBE_VPMD_RXQ_REARM_THRESH; i += 2, rxep += 2) {
-		mb0 = rxep[0].mbuf;
-		mb1 = rxep[1].mbuf;
-
-		/*
-		 * Flush mbuf with pkt template.
-		 * Data to be rearmed is 6 bytes long.
-		 */
-		vst1_u8((uint8_t *)&mb0->rearm_data, p);
-		paddr = mb0->buf_iova + RTE_PKTMBUF_HEADROOM;
-		dma_addr0 = vsetq_lane_u64(paddr, zero, 0);
-		/* flush desc with pa dma_addr */
-		vst1q_u64(RTE_CAST_PTR(uint64_t *, &rxdp++->read), dma_addr0);
-
-		vst1_u8((uint8_t *)&mb1->rearm_data, p);
-		paddr = mb1->buf_iova + RTE_PKTMBUF_HEADROOM;
-		dma_addr1 = vsetq_lane_u64(paddr, zero, 0);
-		vst1q_u64(RTE_CAST_PTR(uint64_t *, &rxdp++->read), dma_addr1);
-	}
-
-	rxq->rxrearm_start += IXGBE_VPMD_RXQ_REARM_THRESH;
-	if (rxq->rxrearm_start >= rxq->nb_rx_desc)
-		rxq->rxrearm_start = 0;
-
-	rxq->rxrearm_nb -= IXGBE_VPMD_RXQ_REARM_THRESH;
-
-	rx_id = (uint16_t)((rxq->rxrearm_start == 0) ?
-			     (rxq->nb_rx_desc - 1) : (rxq->rxrearm_start - 1));
-
-	/* Update the tail pointer on the NIC */
-	IXGBE_PCI_REG_WRITE(rxq->qrx_tail, rx_id);
+	RTE_BUILD_BUG_ON(sizeof(union ci_rx_desc) != sizeof(union ixgbe_adv_rx_desc));
+	ci_rxq_rearm(rxq);
 }
 
 static inline void
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
index f6aa3f9f9a..03d16e7b36 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
@@ -10,83 +10,15 @@
 #include "ixgbe_rxtx.h"
 #include "ixgbe_rxtx_vec_common.h"
 
+#include "../common/rx_vec_x86.h"
+
 #include <rte_vect.h>
 
 static inline void
 ixgbe_rxq_rearm(struct ci_rx_queue *rxq)
 {
-	int i;
-	uint16_t rx_id;
-	volatile union ixgbe_adv_rx_desc *rxdp;
-	struct ci_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
-	struct rte_mbuf *mb0, *mb1;
-	__m128i hdr_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
-			RTE_PKTMBUF_HEADROOM);
-	__m128i dma_addr0, dma_addr1;
-
-	const __m128i hba_msk = _mm_set_epi64x(0, UINT64_MAX);
-
-	rxdp = rxq->ixgbe_rx_ring + rxq->rxrearm_start;
-
-	/* Pull 'n' more MBUFs into the software ring */
-	if (rte_mempool_get_bulk(rxq->mp,
-				 (void *)rxep,
-				 IXGBE_VPMD_RXQ_REARM_THRESH) < 0) {
-		if (rxq->rxrearm_nb + IXGBE_VPMD_RXQ_REARM_THRESH >=
-		    rxq->nb_rx_desc) {
-			dma_addr0 = _mm_setzero_si128();
-			for (i = 0; i < IXGBE_VPMD_DESCS_PER_LOOP; i++) {
-				rxep[i].mbuf = &rxq->fake_mbuf;
-				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i].read),
-						dma_addr0);
-			}
-		}
-		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			IXGBE_VPMD_RXQ_REARM_THRESH;
-		return;
-	}
-
-	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < IXGBE_VPMD_RXQ_REARM_THRESH; i += 2, rxep += 2) {
-		__m128i vaddr0, vaddr1;
-
-		mb0 = rxep[0].mbuf;
-		mb1 = rxep[1].mbuf;
-
-		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
-		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
-				offsetof(struct rte_mbuf, buf_addr) + 8);
-		vaddr0 = _mm_loadu_si128((__m128i *)&(mb0->buf_addr));
-		vaddr1 = _mm_loadu_si128((__m128i *)&(mb1->buf_addr));
-
-		/* convert pa to dma_addr hdr/data */
-		dma_addr0 = _mm_unpackhi_epi64(vaddr0, vaddr0);
-		dma_addr1 = _mm_unpackhi_epi64(vaddr1, vaddr1);
-
-		/* add headroom to pa values */
-		dma_addr0 = _mm_add_epi64(dma_addr0, hdr_room);
-		dma_addr1 = _mm_add_epi64(dma_addr1, hdr_room);
-
-		/* set Header Buffer Address to zero */
-		dma_addr0 =  _mm_and_si128(dma_addr0, hba_msk);
-		dma_addr1 =  _mm_and_si128(dma_addr1, hba_msk);
-
-		/* flush desc with pa dma_addr */
-		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp++->read), dma_addr0);
-		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp++->read), dma_addr1);
-	}
-
-	rxq->rxrearm_start += IXGBE_VPMD_RXQ_REARM_THRESH;
-	if (rxq->rxrearm_start >= rxq->nb_rx_desc)
-		rxq->rxrearm_start = 0;
-
-	rxq->rxrearm_nb -= IXGBE_VPMD_RXQ_REARM_THRESH;
-
-	rx_id = (uint16_t) ((rxq->rxrearm_start == 0) ?
-			     (rxq->nb_rx_desc - 1) : (rxq->rxrearm_start - 1));
-
-	/* Update the tail pointer on the NIC */
-	IXGBE_PCI_REG_WC_WRITE(rxq->qrx_tail, rx_id);
+	RTE_BUILD_BUG_ON(sizeof(union ci_rx_desc) != sizeof(union ixgbe_adv_rx_desc));
+	ci_rxq_rearm(rxq, CI_RX_VEC_LEVEL_SSE);
 }
 
 #ifdef RTE_LIB_SECURITY
-- 
2.47.1

