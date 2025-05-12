Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0524CC3ABBC
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 10:59:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4293540654;
	Mon, 12 May 2025 12:59:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id CA44640667
 for <dev@dpdk.org>; Mon, 12 May 2025 12:59:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747047542; x=1778583542;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=aU1+frsZfk16Zn3M5mYyl+PTmke+a451M175mgYErMU=;
 b=ftHiis/hMzjC4lbMEBH5aTdzYMsSMnd0DJ+5/56aJqJs9vL21W5afela
 jIiSS8dLKvJJ8QuIWz0y/bzdg7N3OMK0MyqA1L4N1YYPRb/vzIw+GVoQq
 x8W6zuEZE7mcjQDxT02uUdLIpmk7RjiW/9+Ze/95wxfGZ/AWaPXMwVtdM
 Zpd3yf0IEH2ezzpMX1WCnTolcXZA9+zkuRvrL+djsVnSoJ+eoejaUk9mH
 qpp2m8XRTJ9KtwPye1OBukJ9/antblnPIcvIiy/+nto+Rz3jdjGDVN9b9
 VoFPUp4JN1qQq4JlSmESyAzfoC+GVLs6cRuuefgJdkA0qxG6FLGKz21EG Q==;
X-CSE-ConnectionGUID: ZvaaajyzTGWMcomevMoa4Q==
X-CSE-MsgGUID: 1PKydoz6SmKdTag5nNdUDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="51488954"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="51488954"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 03:59:02 -0700
X-CSE-ConnectionGUID: pi6V2hKsTtiVeW+jtWoaaw==
X-CSE-MsgGUID: pi55KJHfQDuFPO9o1Ma/Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="142097970"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa003.jf.intel.com with ESMTP; 12 May 2025 03:59:00 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Ian Stokes <ian.stokes@intel.com>
Subject: [PATCH v2 08/13] net/i40e: use common Rx rearm code
Date: Mon, 12 May 2025 11:58:33 +0100
Message-ID: <d445840b6b63793d8e7f74520944caad7cc23277.1747047506.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <afcd4013458bdb8b970e7ed57d6a1ede0ee654b8.1747047505.git.anatoly.burakov@intel.com>
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

The i40e driver has an implementation of vectorized mbuf rearm code that
is identical to the one in the common code, so just use that.

In addition, the i40e has an implementation of Rx queue rearm for Neon
instruction set, so create a common header for Neon implementations too,
and use that in i40e Neon code.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v2:
    - Fix compile issues on Arm64

 drivers/net/intel/common/rx_vec_neon.h        | 131 +++++++++++
 drivers/net/intel/i40e/i40e_rxtx.h            |   2 +-
 drivers/net/intel/i40e/i40e_rxtx_common_avx.h | 215 ------------------
 drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   |   5 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c |   5 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |  59 +----
 drivers/net/intel/i40e/i40e_rxtx_vec_sse.c    |  70 +-----
 7 files changed, 144 insertions(+), 343 deletions(-)
 create mode 100644 drivers/net/intel/common/rx_vec_neon.h
 delete mode 100644 drivers/net/intel/i40e/i40e_rxtx_common_avx.h

diff --git a/drivers/net/intel/common/rx_vec_neon.h b/drivers/net/intel/common/rx_vec_neon.h
new file mode 100644
index 0000000000..d79802b1c0
--- /dev/null
+++ b/drivers/net/intel/common/rx_vec_neon.h
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Intel Corporation
+ */
+
+#ifndef _COMMON_INTEL_RX_VEC_NEON_H_
+#define _COMMON_INTEL_RX_VEC_NEON_H_
+
+#include <stdint.h>
+
+#include <ethdev_driver.h>
+#include <rte_io.h>
+#include <rte_vect.h>
+
+#include "rx.h"
+
+static inline int
+_ci_rxq_rearm_get_bufs(struct ci_rx_queue *rxq, const size_t desc_len)
+{
+	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
+	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
+	volatile void *rxdp;
+	int i;
+
+	rxdp = RTE_PTR_ADD(rxq->rx_ring, rxq->rxrearm_start * desc_len);
+
+	if (rte_mempool_get_bulk(rxq->mp,
+				 (void **)rxp,
+				 rearm_thresh) < 0) {
+		if (rxq->rxrearm_nb + rearm_thresh >= rxq->nb_rx_desc) {
+			uint64x2_t zero = vdupq_n_u64(0);
+
+			for (i = 0; i < CI_VPMD_DESCS_PER_LOOP; i++) {
+				rxp[i].mbuf = &rxq->fake_mbuf;
+				const void *ptr = RTE_PTR_ADD(rxdp, i * desc_len);
+				vst1q_u64(RTE_CAST_PTR(uint64_t *, ptr), zero);
+			}
+		}
+		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed += rearm_thresh;
+		return -1;
+	}
+	return 0;
+}
+
+/*
+ * SSE code path can handle both 16-byte and 32-byte descriptors with one code
+ * path, as we only ever write 16 bytes at a time.
+ */
+static __rte_always_inline void
+_ci_rxq_rearm_neon(struct ci_rx_queue *rxq, const size_t desc_len)
+{
+	const uint64x2_t zero = vdupq_n_u64(0);
+	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
+	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
+	volatile void *rxdp;
+	int i;
+
+	const uint8x8_t mbuf_init = vld1_u8((uint8_t *)&rxq->mbuf_initializer);
+
+	rxdp = RTE_PTR_ADD(rxq->rx_ring, rxq->rxrearm_start * desc_len);
+
+	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
+	for (i = 0; i < rearm_thresh; i += 2, rxp += 2, rxdp = RTE_PTR_ADD(rxdp, 2 * desc_len)) {
+		volatile void *ptr0 = RTE_PTR_ADD(rxdp, 0);
+		volatile void *ptr1 = RTE_PTR_ADD(rxdp, desc_len);
+		uint64_t addr0, addr1;
+		uint64x2_t dma_addr0, dma_addr1;
+		struct rte_mbuf *mb0, *mb1;
+
+		mb0 = rxp[0].mbuf;
+		mb1 = rxp[1].mbuf;
+
+#if RTE_IOVA_IN_MBUF
+		/*
+		 * Flush mbuf with pkt template.
+		 * Data to be rearmed is 6 bytes long.
+		 */
+		vst1_u8((uint8_t *)&mb0->rearm_data, mbuf_init);
+		addr0 = mb0->buf_iova + RTE_PKTMBUF_HEADROOM;
+		dma_addr0 = vsetq_lane_u64(addr0, zero, 0);
+		/* flush desc with pa dma_addr */
+		vst1q_u64(RTE_CAST_PTR(uint64_t *, ptr0), dma_addr0);
+
+		vst1_u8((uint8_t *)&mb1->rearm_data, mbuf_init);
+		addr1 = mb1->buf_iova + RTE_PKTMBUF_HEADROOM;
+		dma_addr1 = vsetq_lane_u64(addr1, zero, 0);
+		vst1q_u64(RTE_CAST_PTR(uint64_t *, ptr1), dma_addr1);
+#else
+		/*
+		 * Flush mbuf with pkt template.
+		 * Data to be rearmed is 6 bytes long.
+		 */
+		vst1_u8((uint8_t *)&mb0->rearm_data, mbuf_init);
+		addr0 = (uintptr_t)RTE_PTR_ADD(mb0->buf_addr, RTE_PKTMBUF_HEADROOM);
+		dma_addr0 = vsetq_lane_u64(addr0, zero, 0);
+		/* flush desc with pa dma_addr */
+		vst1q_u64(RTE_CAST_PTR(uint64_t *, ptr0), dma_addr0);
+
+		vst1_u8((uint8_t *)&mb1->rearm_data, mbuf_init);
+		addr1 = (uintptr_t)RTE_PTR_ADD(mb1->buf_addr, RTE_PKTMBUF_HEADROOM);
+		dma_addr1 = vsetq_lane_u64(addr1, zero, 0);
+		vst1q_u64(RTE_CAST_PTR(uint64_t *, ptr1), dma_addr1);
+#endif
+	}
+}
+
+static __rte_always_inline void
+ci_rxq_rearm(struct ci_rx_queue *rxq, const size_t desc_len)
+{
+	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
+	uint16_t rx_id;
+
+	/* Pull 'n' more MBUFs into the software ring */
+	if (_ci_rxq_rearm_get_bufs(rxq, desc_len) < 0)
+		return;
+
+	_ci_rxq_rearm_neon(rxq, desc_len);
+
+	rxq->rxrearm_start += rearm_thresh;
+	if (rxq->rxrearm_start >= rxq->nb_rx_desc)
+		rxq->rxrearm_start = 0;
+
+	rxq->rxrearm_nb -= rearm_thresh;
+
+	rx_id = (uint16_t)((rxq->rxrearm_start == 0) ?
+			     (rxq->nb_rx_desc - 1) : (rxq->rxrearm_start - 1));
+
+	/* Update the tail pointer on the NIC */
+	rte_write32_wc(rte_cpu_to_le_32(rx_id), rxq->qrx_tail);
+}
+
+#endif /* _COMMON_INTEL_RX_VEC_NEON_H_ */
diff --git a/drivers/net/intel/i40e/i40e_rxtx.h b/drivers/net/intel/i40e/i40e_rxtx.h
index 4b5a84d8ef..8a41db2df3 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.h
+++ b/drivers/net/intel/i40e/i40e_rxtx.h
@@ -13,7 +13,7 @@
 
 #define RTE_I40E_VPMD_RX_BURST        32
 #define RTE_I40E_VPMD_TX_BURST        32
-#define RTE_I40E_RXQ_REARM_THRESH      32
+#define RTE_I40E_RXQ_REARM_THRESH      CI_VPMD_RX_REARM_THRESH
 #define RTE_I40E_MAX_RX_BURST          RTE_I40E_RXQ_REARM_THRESH
 #define RTE_I40E_TX_MAX_FREE_BUF_SZ    64
 #define RTE_I40E_DESCS_PER_LOOP    4
diff --git a/drivers/net/intel/i40e/i40e_rxtx_common_avx.h b/drivers/net/intel/i40e/i40e_rxtx_common_avx.h
deleted file mode 100644
index fd9447014b..0000000000
--- a/drivers/net/intel/i40e/i40e_rxtx_common_avx.h
+++ /dev/null
@@ -1,215 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2015 Intel Corporation
- */
-
-#ifndef _I40E_RXTX_COMMON_AVX_H_
-#define _I40E_RXTX_COMMON_AVX_H_
-#include <stdint.h>
-#include <ethdev_driver.h>
-#include <rte_malloc.h>
-
-#include "i40e_ethdev.h"
-#include "i40e_rxtx.h"
-
-#ifdef __AVX2__
-static __rte_always_inline void
-i40e_rxq_rearm_common(struct ci_rx_queue *rxq, __rte_unused bool avx512)
-{
-	int i;
-	uint16_t rx_id;
-	volatile union i40e_rx_desc *rxdp;
-	struct ci_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
-
-	rxdp = I40E_RX_RING_PTR(rxq, rxq->rxrearm_start);
-
-	/* Pull 'n' more MBUFs into the software ring */
-	if (rte_mempool_get_bulk(rxq->mp,
-				 (void *)rxep,
-				 RTE_I40E_RXQ_REARM_THRESH) < 0) {
-		if (rxq->rxrearm_nb + RTE_I40E_RXQ_REARM_THRESH >=
-		    rxq->nb_rx_desc) {
-			__m128i dma_addr0;
-			dma_addr0 = _mm_setzero_si128();
-			for (i = 0; i < RTE_I40E_DESCS_PER_LOOP; i++) {
-				rxep[i].mbuf = &rxq->fake_mbuf;
-				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i].read),
-						dma_addr0);
-			}
-		}
-		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			RTE_I40E_RXQ_REARM_THRESH;
-		return;
-	}
-
-#ifndef RTE_LIBRTE_I40E_16BYTE_RX_DESC
-	struct rte_mbuf *mb0, *mb1;
-	__m128i dma_addr0, dma_addr1;
-	__m128i hdr_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
-			RTE_PKTMBUF_HEADROOM);
-	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < RTE_I40E_RXQ_REARM_THRESH; i += 2, rxep += 2) {
-		__m128i vaddr0, vaddr1;
-
-		mb0 = rxep[0].mbuf;
-		mb1 = rxep[1].mbuf;
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
-#ifdef __AVX512VL__
-	if (avx512) {
-		struct rte_mbuf *mb0, *mb1, *mb2, *mb3;
-		struct rte_mbuf *mb4, *mb5, *mb6, *mb7;
-		__m512i dma_addr0_3, dma_addr4_7;
-		__m512i hdr_room = _mm512_set1_epi64(RTE_PKTMBUF_HEADROOM);
-		/* Initialize the mbufs in vector, process 8 mbufs in one loop */
-		for (i = 0; i < RTE_I40E_RXQ_REARM_THRESH;
-				i += 8, rxep += 8, rxdp += 8) {
-			__m128i vaddr0, vaddr1, vaddr2, vaddr3;
-			__m128i vaddr4, vaddr5, vaddr6, vaddr7;
-			__m256i vaddr0_1, vaddr2_3;
-			__m256i vaddr4_5, vaddr6_7;
-			__m512i vaddr0_3, vaddr4_7;
-
-			mb0 = rxep[0].mbuf;
-			mb1 = rxep[1].mbuf;
-			mb2 = rxep[2].mbuf;
-			mb3 = rxep[3].mbuf;
-			mb4 = rxep[4].mbuf;
-			mb5 = rxep[5].mbuf;
-			mb6 = rxep[6].mbuf;
-			mb7 = rxep[7].mbuf;
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
-						   vaddr2_3, 1);
-			vaddr4_7 =
-				_mm512_inserti64x4(_mm512_castsi256_si512(vaddr4_5),
-						   vaddr6_7, 1);
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
-			_mm512_store_si512(RTE_CAST_PTR(__m512i *,
-					&rxdp->read), dma_addr0_3);
-			_mm512_store_si512(RTE_CAST_PTR(__m512i *,
-					&(rxdp + 4)->read), dma_addr4_7);
-		}
-	} else
-#endif /* __AVX512VL__*/
-	{
-		struct rte_mbuf *mb0, *mb1, *mb2, *mb3;
-		__m256i dma_addr0_1, dma_addr2_3;
-		__m256i hdr_room = _mm256_set1_epi64x(RTE_PKTMBUF_HEADROOM);
-		/* Initialize the mbufs in vector, process 4 mbufs in one loop */
-		for (i = 0; i < RTE_I40E_RXQ_REARM_THRESH;
-				i += 4, rxep += 4, rxdp += 4) {
-			__m128i vaddr0, vaddr1, vaddr2, vaddr3;
-			__m256i vaddr0_1, vaddr2_3;
-
-			mb0 = rxep[0].mbuf;
-			mb1 = rxep[1].mbuf;
-			mb2 = rxep[2].mbuf;
-			mb3 = rxep[3].mbuf;
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
-			vaddr0_1 = _mm256_inserti128_si256
-				(_mm256_castsi128_si256(vaddr0), vaddr1, 1);
-			vaddr2_3 = _mm256_inserti128_si256
-				(_mm256_castsi128_si256(vaddr2), vaddr3, 1);
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
-			_mm256_store_si256(RTE_CAST_PTR(__m256i *,
-					&rxdp->read), dma_addr0_1);
-			_mm256_store_si256(RTE_CAST_PTR(__m256i *,
-					&(rxdp + 2)->read), dma_addr2_3);
-		}
-	}
-
-#endif
-
-	rxq->rxrearm_start += RTE_I40E_RXQ_REARM_THRESH;
-	rx_id = rxq->rxrearm_start - 1;
-
-	if (unlikely(rxq->rxrearm_start >= rxq->nb_rx_desc)) {
-		rxq->rxrearm_start = 0;
-		rx_id = rxq->nb_rx_desc - 1;
-	}
-
-	rxq->rxrearm_nb -= RTE_I40E_RXQ_REARM_THRESH;
-
-	/* Update the tail pointer on the NIC */
-	I40E_PCI_REG_WC_WRITE(rxq->qrx_tail, rx_id);
-}
-#endif /* __AVX2__*/
-
-#endif /*_I40E_RXTX_COMMON_AVX_H_*/
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
index 0f3f7430aa..260b7d700a 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
@@ -11,14 +11,15 @@
 #include "i40e_ethdev.h"
 #include "i40e_rxtx.h"
 #include "i40e_rxtx_vec_common.h"
-#include "i40e_rxtx_common_avx.h"
+
+#include "../common/rx_vec_sse.h"
 
 #include <rte_vect.h>
 
 static __rte_always_inline void
 i40e_rxq_rearm(struct ci_rx_queue *rxq)
 {
-	i40e_rxq_rearm_common(rxq, false);
+	ci_rxq_rearm(rxq, sizeof(union i40e_rx_desc), CI_RX_VEC_LEVEL_AVX2);
 }
 
 #ifndef RTE_LIBRTE_I40E_16BYTE_RX_DESC
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
index f2292b45e8..be004e9f4f 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
@@ -11,7 +11,8 @@
 #include "i40e_ethdev.h"
 #include "i40e_rxtx.h"
 #include "i40e_rxtx_vec_common.h"
-#include "i40e_rxtx_common_avx.h"
+
+#include "../common/rx_vec_sse.h"
 
 #include <rte_vect.h>
 
@@ -20,7 +21,7 @@
 static __rte_always_inline void
 i40e_rxq_rearm(struct ci_rx_queue *rxq)
 {
-	i40e_rxq_rearm_common(rxq, true);
+	ci_rxq_rearm(rxq, sizeof(union i40e_rx_desc), CI_RX_VEC_LEVEL_AVX512);
 }
 
 #ifndef RTE_LIBRTE_I40E_16BYTE_RX_DESC
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
index 814aa666dc..6c21546471 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
@@ -16,65 +16,12 @@
 #include "i40e_rxtx.h"
 #include "i40e_rxtx_vec_common.h"
 
+#include "../common/rx_vec_neon.h"
+
 static inline void
 i40e_rxq_rearm(struct ci_rx_queue *rxq)
 {
-	int i;
-	uint16_t rx_id;
-	volatile union i40e_rx_desc *rxdp;
-	struct ci_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
-	struct rte_mbuf *mb0, *mb1;
-	uint64x2_t dma_addr0, dma_addr1;
-	uint64x2_t zero = vdupq_n_u64(0);
-	uint64_t paddr;
-
-	rxdp = I40E_RX_RING_PTR(rxq, rxq->rxrearm_start);
-
-	/* Pull 'n' more MBUFs into the software ring */
-	if (unlikely(rte_mempool_get_bulk(rxq->mp,
-					  (void *)rxep,
-					  RTE_I40E_RXQ_REARM_THRESH) < 0)) {
-		if (rxq->rxrearm_nb + RTE_I40E_RXQ_REARM_THRESH >=
-		    rxq->nb_rx_desc) {
-			for (i = 0; i < RTE_I40E_DESCS_PER_LOOP; i++) {
-				rxep[i].mbuf = &rxq->fake_mbuf;
-				vst1q_u64(RTE_CAST_PTR(uint64_t *, &rxdp[i].read), zero);
-			}
-		}
-		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			RTE_I40E_RXQ_REARM_THRESH;
-		return;
-	}
-
-	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < RTE_I40E_RXQ_REARM_THRESH; i += 2, rxep += 2) {
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
-	rxq->rxrearm_start += RTE_I40E_RXQ_REARM_THRESH;
-	rx_id = rxq->rxrearm_start - 1;
-
-	if (unlikely(rxq->rxrearm_start >= rxq->nb_rx_desc)) {
-		rxq->rxrearm_start = 0;
-		rx_id = rxq->nb_rx_desc - 1;
-	}
-
-	rxq->rxrearm_nb -= RTE_I40E_RXQ_REARM_THRESH;
-
-	rte_io_wmb();
-	/* Update the tail pointer on the NIC */
-	I40E_PCI_REG_WRITE_RELAXED(rxq->qrx_tail, rx_id);
+	ci_rxq_rearm(rxq, sizeof(union i40e_rx_desc));
 }
 
 #ifndef RTE_LIBRTE_I40E_16BYTE_RX_DESC
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c b/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
index 74cd59e245..432177d499 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
@@ -12,78 +12,14 @@
 #include "i40e_rxtx.h"
 #include "i40e_rxtx_vec_common.h"
 
+#include "../common/rx_vec_sse.h"
+
 #include <rte_vect.h>
 
 static inline void
 i40e_rxq_rearm(struct ci_rx_queue *rxq)
 {
-	int i;
-	uint16_t rx_id;
-	volatile union i40e_rx_desc *rxdp;
-	struct ci_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
-	struct rte_mbuf *mb0, *mb1;
-	__m128i hdr_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
-			RTE_PKTMBUF_HEADROOM);
-	__m128i dma_addr0, dma_addr1;
-
-	rxdp = I40E_RX_RING_PTR(rxq, rxq->rxrearm_start);
-
-	/* Pull 'n' more MBUFs into the software ring */
-	if (rte_mempool_get_bulk(rxq->mp,
-				 (void *)rxep,
-				 RTE_I40E_RXQ_REARM_THRESH) < 0) {
-		if (rxq->rxrearm_nb + RTE_I40E_RXQ_REARM_THRESH >=
-		    rxq->nb_rx_desc) {
-			dma_addr0 = _mm_setzero_si128();
-			for (i = 0; i < RTE_I40E_DESCS_PER_LOOP; i++) {
-				rxep[i].mbuf = &rxq->fake_mbuf;
-				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i].read),
-						dma_addr0);
-			}
-		}
-		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			RTE_I40E_RXQ_REARM_THRESH;
-		return;
-	}
-
-	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < RTE_I40E_RXQ_REARM_THRESH; i += 2, rxep += 2) {
-		__m128i vaddr0, vaddr1;
-
-		mb0 = rxep[0].mbuf;
-		mb1 = rxep[1].mbuf;
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
-	rxq->rxrearm_start += RTE_I40E_RXQ_REARM_THRESH;
-	rx_id = rxq->rxrearm_start - 1;
-
-	if (unlikely(rxq->rxrearm_start >= rxq->nb_rx_desc)) {
-		rxq->rxrearm_start = 0;
-		rx_id = rxq->nb_rx_desc - 1;
-	}
-
-	rxq->rxrearm_nb -= RTE_I40E_RXQ_REARM_THRESH;
-
-	/* Update the tail pointer on the NIC */
-	I40E_PCI_REG_WC_WRITE(rxq->qrx_tail, rx_id);
+	ci_rxq_rearm(rxq, sizeof(union i40e_rx_desc), CI_RX_VEC_LEVEL_SSE);
 }
 
 #ifndef RTE_LIBRTE_I40E_16BYTE_RX_DESC
-- 
2.47.1

