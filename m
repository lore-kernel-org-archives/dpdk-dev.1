Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1A7C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 15:41:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE1364281D;
	Mon,  9 Jun 2025 17:38:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9F5D442D7B
 for <dev@dpdk.org>; Mon,  9 Jun 2025 17:38:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749483513; x=1781019513;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=uZKZPKDe/3hpQUNMJZavEvPWgopdpPJK88Eeupw1Vto=;
 b=Vugho3EsqV1fKnSmeS5kOy8Vga5OQlmnXZYoB8WpXAT3fU2BHyNCMeMw
 7DZyw7VRVTyWLyQvuuoclthvEY/d8ezm5Gzmczk7c+x0t4uMIKgRks7jU
 Hg3k/qmWBbsAbw0h0e/gfT+PkqPIc+jt6GT7bjqD08IrYO+zVexlnreQr
 0JyOPbLQXBiabNw8qFhpIWS9uAGroG0f5LFxwhDKhpIcJTWjrllReK9Tu
 Pw8pQJBPkbO6YrridFrZnDv4LRlZ4ANE3Sb7Z+tUxWr9kdAYUPJvKE+tF
 xiyKT54kVj0UD9RNuBuj7vKRRF5wVe53OP8Xj0b51KxbeqFsopyuNRosj Q==;
X-CSE-ConnectionGUID: hEkGrIS5TiGP3kzknxXWEA==
X-CSE-MsgGUID: R2nLQUo9SRuGYMiHQtBM5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="69012238"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="69012238"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 08:38:32 -0700
X-CSE-ConnectionGUID: 6gIp4drwTRGox8tdc3CPHQ==
X-CSE-MsgGUID: kRiPd1MNSeWF2ga6iraEAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="151419767"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa005.fm.intel.com with ESMTP; 09 Jun 2025 08:38:30 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Ian Stokes <ian.stokes@intel.com>
Subject: [PATCH v6 28/33] net/i40e: use common Rx rearm code
Date: Mon,  9 Jun 2025 16:37:26 +0100
Message-ID: <0c8097ad41731d4f4c03c023291564a3d17535ae.1749483382.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749483381.git.anatoly.burakov@intel.com>
 <cover.1749483381.git.anatoly.burakov@intel.com>
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

In addition, the i40e has implementations of Rx queue rearm for Neon and
AltiVec instruction sets, so create common headers for each of the
instruction sets, and use that in respective i40e code.

While we're at it, also make sure to use common definitions for things like
burst size, rearm threshold, and descriptors per loop, which is currently
defined separately in each driver.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/rx_vec_arm.h         | 105 +++++++++
 drivers/net/intel/common/rx_vec_ppc.h         | 121 ++++++++++
 drivers/net/intel/i40e/i40e_rxtx.h            |   8 +-
 drivers/net/intel/i40e/i40e_rxtx_common_avx.h | 215 ------------------
 .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |  83 +------
 drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   |   5 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c |   5 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |  59 +----
 drivers/net/intel/i40e/i40e_rxtx_vec_sse.c    |  70 +-----
 9 files changed, 245 insertions(+), 426 deletions(-)
 create mode 100644 drivers/net/intel/common/rx_vec_arm.h
 create mode 100644 drivers/net/intel/common/rx_vec_ppc.h
 delete mode 100644 drivers/net/intel/i40e/i40e_rxtx_common_avx.h

diff --git a/drivers/net/intel/common/rx_vec_arm.h b/drivers/net/intel/common/rx_vec_arm.h
new file mode 100644
index 0000000000..2e48d4b6c0
--- /dev/null
+++ b/drivers/net/intel/common/rx_vec_arm.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Intel Corporation
+ */
+
+#ifndef _COMMON_INTEL_RX_VEC_ARM_H_
+#define _COMMON_INTEL_RX_VEC_ARM_H_
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
+_ci_rxq_rearm_get_bufs(struct ci_rx_queue *rxq)
+{
+	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
+	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
+	volatile union ci_rx_desc *rxdp;
+	int i;
+
+	rxdp = &rxq->rx_ring[rxq->rxrearm_start];
+
+	if (rte_mempool_get_bulk(rxq->mp, (void **)rxp, rearm_thresh) < 0) {
+		if (rxq->rxrearm_nb + rearm_thresh >= rxq->nb_rx_desc) {
+			uint64x2_t zero = vdupq_n_u64(0);
+
+			for (i = 0; i < CI_VPMD_DESCS_PER_LOOP; i++) {
+				rxp[i].mbuf = &rxq->fake_mbuf;
+				vst1q_u64(RTE_CAST_PTR(uint64_t *, &rxdp[i]), zero);
+			}
+		}
+		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed += rearm_thresh;
+		return -1;
+	}
+	return 0;
+}
+
+static __rte_always_inline void
+_ci_rxq_rearm_neon(struct ci_rx_queue *rxq)
+{
+	const uint64x2_t zero = vdupq_n_u64(0);
+	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
+	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
+	volatile union ci_rx_desc *rxdp;
+	int i;
+
+	const uint8x8_t mbuf_init = vld1_u8((uint8_t *)&rxq->mbuf_initializer);
+
+	rxdp = &rxq->rx_ring[rxq->rxrearm_start];
+
+	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
+	for (i = 0; i < rearm_thresh; i += 2, rxp += 2, rxdp += 2) {
+		struct rte_mbuf *mb0 = rxp[0].mbuf;
+		struct rte_mbuf *mb1 = rxp[1].mbuf;
+
+		/*
+		 * Flush mbuf with pkt template.
+		 * Data to be rearmed is 6 bytes long.
+		 */
+		vst1_u8((uint8_t *)&mb0->rearm_data, mbuf_init);
+		vst1_u8((uint8_t *)&mb1->rearm_data, mbuf_init);
+#if RTE_IOVA_IN_MBUF
+		const uint64_t addr0 = mb0->buf_iova + RTE_PKTMBUF_HEADROOM;
+		const uint64_t addr1 = mb1->buf_iova + RTE_PKTMBUF_HEADROOM;
+#else
+		const uint64_t addr0 = (uintptr_t)RTE_PTR_ADD(mb0->buf_addr, RTE_PKTMBUF_HEADROOM);
+		const uint64_t addr1 = (uintptr_t)RTE_PTR_ADD(mb1->buf_addr, RTE_PKTMBUF_HEADROOM);
+#endif
+		uint64x2_t dma_addr0 = vsetq_lane_u64(addr0, zero, 0);
+		uint64x2_t dma_addr1 = vsetq_lane_u64(addr1, zero, 0);
+		/* flush desc with pa dma_addr */
+		vst1q_u64(RTE_CAST_PTR(uint64_t *, &rxdp[0]), dma_addr0);
+		vst1q_u64(RTE_CAST_PTR(uint64_t *, &rxdp[1]), dma_addr1);
+	}
+}
+
+static __rte_always_inline void
+ci_rxq_rearm(struct ci_rx_queue *rxq)
+{
+	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
+	uint16_t rx_id;
+
+	/* Pull 'n' more MBUFs into the software ring */
+	if (_ci_rxq_rearm_get_bufs(rxq) < 0)
+		return;
+
+	_ci_rxq_rearm_neon(rxq);
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
+#endif /* _COMMON_INTEL_RX_VEC_ARM_H_ */
diff --git a/drivers/net/intel/common/rx_vec_ppc.h b/drivers/net/intel/common/rx_vec_ppc.h
new file mode 100644
index 0000000000..97affc34c2
--- /dev/null
+++ b/drivers/net/intel/common/rx_vec_ppc.h
@@ -0,0 +1,121 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Intel Corporation
+ */
+
+#ifndef _COMMON_INTEL_RX_VEC_PPC_H_
+#define _COMMON_INTEL_RX_VEC_PPC_H_
+
+#include <stdint.h>
+
+#include <ethdev_driver.h>
+#include <rte_io.h>
+#include <rte_altivec.h>
+
+#include "rx.h"
+
+static inline int
+_ci_rxq_rearm_get_bufs(struct ci_rx_queue *rxq)
+{
+	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
+	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
+	volatile union ci_rx_desc *rxdp;
+	int i;
+
+	rxdp = &rxq->rx_ring[rxq->rxrearm_start];
+
+	if (rte_mempool_get_bulk(rxq->mp, (void **)rxp, rearm_thresh) < 0) {
+		if (rxq->rxrearm_nb + rearm_thresh >= rxq->nb_rx_desc) {
+			__vector unsigned long dma_addr0 = (__vector unsigned long){};
+
+			for (i = 0; i < CI_VPMD_DESCS_PER_LOOP; i++) {
+				rxp[i].mbuf = &rxq->fake_mbuf;
+				vec_st(dma_addr0, 0,
+					RTE_CAST_PTR(__vector unsigned long *, &rxdp[i]));
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
+_ci_rxq_rearm_altivec(struct ci_rx_queue *rxq)
+{
+	struct ci_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
+	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
+	__vector unsigned long hdroom =
+			(__vector unsigned long){RTE_PKTMBUF_HEADROOM, RTE_PKTMBUF_HEADROOM};
+	int i;
+
+	volatile union ci_rx_desc *rxdp = rxq->rx_ring + rxq->rxrearm_start;
+
+	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
+	for (i = 0; i < rearm_thresh; i += 2, rxep += 2) {
+		__vector unsigned long vaddr0, vaddr1;
+		struct rte_mbuf *mb0 = rxep[0].mbuf;
+		struct rte_mbuf *mb1 = rxep[1].mbuf;
+
+		/* Flush mbuf with pkt template.
+		 * Data to be rearmed is 6 bytes long.
+		 * Though, RX will overwrite ol_flags that are coming next
+		 * anyway. So overwrite whole 8 bytes with one load:
+		 * 6 bytes of rearm_data plus first 2 bytes of ol_flags.
+		 */
+		*(uint64_t *)&mb0->rearm_data = rxq->mbuf_initializer;
+		*(uint64_t *)&mb1->rearm_data = rxq->mbuf_initializer;
+
+		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
+		vaddr0 = vec_ld(0, (__vector unsigned long *)&mb0->buf_addr);
+		vaddr1 = vec_ld(0, (__vector unsigned long *)&mb1->buf_addr);
+
+#if RTE_IOVA_IN_MBUF
+		/* convert pa to dma_addr hdr/data */
+		vaddr0 = vec_mergel(vaddr0, vaddr0);
+		vaddr1 = vec_mergel(vaddr1, vaddr1);
+#else
+		/* convert va to dma_addr hdr/data */
+		vaddr0 = vec_mergeh(vaddr0, vaddr0);
+		vaddr1 = vec_mergeh(vaddr1, vaddr1);
+#endif
+
+		/* add headroom to pa values */
+		vaddr0 = vec_add(vaddr0, hdroom);
+		vaddr1 = vec_add(vaddr1, hdroom);
+
+		/* flush desc with pa dma_addr */
+		vec_st(vaddr0, 0, RTE_CAST_PTR(__vector unsigned long *, rxdp++));
+		vec_st(vaddr1, 0, RTE_CAST_PTR(__vector unsigned long *, rxdp++));
+	}
+}
+
+static __rte_always_inline void
+ci_rxq_rearm(struct ci_rx_queue *rxq)
+{
+	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
+	uint16_t rx_id;
+
+	/* Pull 'n' more MBUFs into the software ring */
+	if (_ci_rxq_rearm_get_bufs(rxq) < 0)
+		return;
+
+	_ci_rxq_rearm_altivec(rxq);
+
+	rxq->rxrearm_start += rearm_thresh;
+	if (rxq->rxrearm_start >= rxq->nb_rx_desc)
+		rxq->rxrearm_start = 0;
+
+	rxq->rxrearm_nb -= rearm_thresh;
+
+	rx_id = (uint16_t)((rxq->rxrearm_start == 0) ?
+			(rxq->nb_rx_desc - 1) : (rxq->rxrearm_start - 1));
+
+	/* Update the tail pointer on the NIC */
+	rte_write32_wc(rte_cpu_to_le_32(rx_id), rxq->qrx_tail);
+}
+
+#endif /* _COMMON_INTEL_RX_VEC_ARM_H_ */
diff --git a/drivers/net/intel/i40e/i40e_rxtx.h b/drivers/net/intel/i40e/i40e_rxtx.h
index 05c41d473e..984532c507 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.h
+++ b/drivers/net/intel/i40e/i40e_rxtx.h
@@ -11,11 +11,11 @@
 #define I40E_RX_MAX_BURST CI_RX_MAX_BURST
 #define I40E_TX_MAX_BURST 32
 
-#define I40E_VPMD_RX_BURST            32
-#define I40E_VPMD_RXQ_REARM_THRESH    32
+#define I40E_VPMD_RX_BURST            CI_VPMD_RX_BURST
+#define I40E_VPMD_RXQ_REARM_THRESH    CI_VPMD_RX_REARM_THRESH
 #define I40E_TX_MAX_FREE_BUF_SZ       64
-#define I40E_VPMD_DESCS_PER_LOOP      4
-#define I40E_VPMD_DESCS_PER_LOOP_WIDE 8
+#define I40E_VPMD_DESCS_PER_LOOP      CI_VPMD_DESCS_PER_LOOP
+#define I40E_VPMD_DESCS_PER_LOOP_WIDE CI_VPMD_DESCS_PER_LOOP_WIDE
 
 #define I40E_RXBUF_SZ_1024 1024
 #define I40E_RXBUF_SZ_2048 2048
diff --git a/drivers/net/intel/i40e/i40e_rxtx_common_avx.h b/drivers/net/intel/i40e/i40e_rxtx_common_avx.h
deleted file mode 100644
index 97cf5226f6..0000000000
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
-	volatile union ci_rx_desc *rxdp;
-	struct ci_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
-
-	rxdp = rxq->rx_ring + rxq->rxrearm_start;
-
-	/* Pull 'n' more MBUFs into the software ring */
-	if (rte_mempool_get_bulk(rxq->mp,
-				 (void *)rxep,
-				 I40E_VPMD_RXQ_REARM_THRESH) < 0) {
-		if (rxq->rxrearm_nb + I40E_VPMD_RXQ_REARM_THRESH >=
-		    rxq->nb_rx_desc) {
-			__m128i dma_addr0;
-			dma_addr0 = _mm_setzero_si128();
-			for (i = 0; i < I40E_VPMD_DESCS_PER_LOOP; i++) {
-				rxep[i].mbuf = &rxq->fake_mbuf;
-				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i].read),
-						dma_addr0);
-			}
-		}
-		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			I40E_VPMD_RXQ_REARM_THRESH;
-		return;
-	}
-
-#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
-	struct rte_mbuf *mb0, *mb1;
-	__m128i dma_addr0, dma_addr1;
-	__m128i hdr_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
-			RTE_PKTMBUF_HEADROOM);
-	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < I40E_VPMD_RXQ_REARM_THRESH; i += 2, rxep += 2) {
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
-		for (i = 0; i < I40E_VPMD_RXQ_REARM_THRESH;
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
-		for (i = 0; i < I40E_VPMD_RXQ_REARM_THRESH;
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
-	rxq->rxrearm_start += I40E_VPMD_RXQ_REARM_THRESH;
-	rx_id = rxq->rxrearm_start - 1;
-
-	if (unlikely(rxq->rxrearm_start >= rxq->nb_rx_desc)) {
-		rxq->rxrearm_start = 0;
-		rx_id = rxq->nb_rx_desc - 1;
-	}
-
-	rxq->rxrearm_nb -= I40E_VPMD_RXQ_REARM_THRESH;
-
-	/* Update the tail pointer on the NIC */
-	I40E_PCI_REG_WC_WRITE(rxq->qrx_tail, rx_id);
-}
-#endif /* __AVX2__*/
-
-#endif /*_I40E_RXTX_COMMON_AVX_H_*/
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
index a914ef20f4..8a4a1a77bf 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
@@ -13,91 +13,14 @@
 #include "i40e_rxtx.h"
 #include "i40e_rxtx_vec_common.h"
 
+#include "../common/rx_vec_ppc.h"
+
 #include <rte_altivec.h>
 
 static inline void
 i40e_rxq_rearm(struct ci_rx_queue *rxq)
 {
-	int i;
-	uint16_t rx_id;
-	volatile union ci_rx_desc *rxdp;
-
-	struct ci_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
-	struct rte_mbuf *mb0, *mb1;
-
-	__vector unsigned long hdr_room = (__vector unsigned long){
-						RTE_PKTMBUF_HEADROOM,
-						RTE_PKTMBUF_HEADROOM};
-	__vector unsigned long dma_addr0, dma_addr1;
-
-	rxdp = rxq->rx_ring + rxq->rxrearm_start;
-
-	/* Pull 'n' more MBUFs into the software ring */
-	if (rte_mempool_get_bulk(rxq->mp,
-				 (void *)rxep,
-				 I40E_VPMD_RXQ_REARM_THRESH) < 0) {
-		if (rxq->rxrearm_nb + I40E_VPMD_RXQ_REARM_THRESH >=
-		    rxq->nb_rx_desc) {
-			dma_addr0 = (__vector unsigned long){};
-			for (i = 0; i < I40E_VPMD_DESCS_PER_LOOP; i++) {
-				rxep[i].mbuf = &rxq->fake_mbuf;
-				vec_st(dma_addr0, 0,
-					RTE_CAST_PTR(__vector unsigned long *, &rxdp[i].read));
-			}
-		}
-		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			I40E_VPMD_RXQ_REARM_THRESH;
-		return;
-	}
-
-	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < I40E_VPMD_RXQ_REARM_THRESH; i += 2, rxep += 2) {
-		__vector unsigned long vaddr0, vaddr1;
-		uintptr_t p0, p1;
-
-		mb0 = rxep[0].mbuf;
-		mb1 = rxep[1].mbuf;
-
-		 /* Flush mbuf with pkt template.
-		  * Data to be rearmed is 6 bytes long.
-		  * Though, RX will overwrite ol_flags that are coming next
-		  * anyway. So overwrite whole 8 bytes with one load:
-		  * 6 bytes of rearm_data plus first 2 bytes of ol_flags.
-		  */
-		p0 = (uintptr_t)&mb0->rearm_data;
-		*(uint64_t *)p0 = rxq->mbuf_initializer;
-		p1 = (uintptr_t)&mb1->rearm_data;
-		*(uint64_t *)p1 = rxq->mbuf_initializer;
-
-		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
-		vaddr0 = vec_ld(0, (__vector unsigned long *)&mb0->buf_addr);
-		vaddr1 = vec_ld(0, (__vector unsigned long *)&mb1->buf_addr);
-
-		/* convert pa to dma_addr hdr/data */
-		dma_addr0 = vec_mergel(vaddr0, vaddr0);
-		dma_addr1 = vec_mergel(vaddr1, vaddr1);
-
-		/* add headroom to pa values */
-		dma_addr0 = vec_add(dma_addr0, hdr_room);
-		dma_addr1 = vec_add(dma_addr1, hdr_room);
-
-		/* flush desc with pa dma_addr */
-		vec_st(dma_addr0, 0, RTE_CAST_PTR(__vector unsigned long *, &rxdp++->read));
-		vec_st(dma_addr1, 0, RTE_CAST_PTR(__vector unsigned long *, &rxdp++->read));
-	}
-
-	rxq->rxrearm_start += I40E_VPMD_RXQ_REARM_THRESH;
-	rx_id = rxq->rxrearm_start - 1;
-
-	if (unlikely(rxq->rxrearm_start >= rxq->nb_rx_desc)) {
-		rxq->rxrearm_start = 0;
-		rx_id = rxq->nb_rx_desc - 1;
-	}
-
-	rxq->rxrearm_nb -= I40E_VPMD_RXQ_REARM_THRESH;
-
-	/* Update the tail pointer on the NIC */
-	I40E_PCI_REG_WRITE(rxq->qrx_tail, rx_id);
+	ci_rxq_rearm(rxq);
 }
 
 static inline void
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
index fee2a6e670..aeb2756e7a 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
@@ -11,14 +11,15 @@
 #include "i40e_ethdev.h"
 #include "i40e_rxtx.h"
 #include "i40e_rxtx_vec_common.h"
-#include "i40e_rxtx_common_avx.h"
+
+#include "../common/rx_vec_x86.h"
 
 #include <rte_vect.h>
 
 static __rte_always_inline void
 i40e_rxq_rearm(struct ci_rx_queue *rxq)
 {
-	i40e_rxq_rearm_common(rxq, false);
+	ci_rxq_rearm(rxq, CI_RX_VEC_LEVEL_AVX2);
 }
 
 #ifndef RTE_NET_INTEL_USE_16BYTE_DESC
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
index e609b7c411..571987d27a 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
@@ -11,14 +11,15 @@
 #include "i40e_ethdev.h"
 #include "i40e_rxtx.h"
 #include "i40e_rxtx_vec_common.h"
-#include "i40e_rxtx_common_avx.h"
+
+#include "../common/rx_vec_x86.h"
 
 #include <rte_vect.h>
 
 static __rte_always_inline void
 i40e_rxq_rearm(struct ci_rx_queue *rxq)
 {
-	i40e_rxq_rearm_common(rxq, true);
+	ci_rxq_rearm(rxq, CI_RX_VEC_LEVEL_AVX512);
 }
 
 #ifndef RTE_NET_INTEL_USE_16BYTE_DESC
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
index 02ba03c290..64ffb2f6df 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
@@ -16,65 +16,12 @@
 #include "i40e_rxtx.h"
 #include "i40e_rxtx_vec_common.h"
 
+#include "../common/rx_vec_arm.h"
+
 static inline void
 i40e_rxq_rearm(struct ci_rx_queue *rxq)
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
-					  I40E_VPMD_RXQ_REARM_THRESH) < 0)) {
-		if (rxq->rxrearm_nb + I40E_VPMD_RXQ_REARM_THRESH >=
-		    rxq->nb_rx_desc) {
-			for (i = 0; i < I40E_VPMD_DESCS_PER_LOOP; i++) {
-				rxep[i].mbuf = &rxq->fake_mbuf;
-				vst1q_u64(RTE_CAST_PTR(uint64_t *, &rxdp[i].read), zero);
-			}
-		}
-		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			I40E_VPMD_RXQ_REARM_THRESH;
-		return;
-	}
-
-	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < I40E_VPMD_RXQ_REARM_THRESH; i += 2, rxep += 2) {
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
-	rxq->rxrearm_start += I40E_VPMD_RXQ_REARM_THRESH;
-	rx_id = rxq->rxrearm_start - 1;
-
-	if (unlikely(rxq->rxrearm_start >= rxq->nb_rx_desc)) {
-		rxq->rxrearm_start = 0;
-		rx_id = rxq->nb_rx_desc - 1;
-	}
-
-	rxq->rxrearm_nb -= I40E_VPMD_RXQ_REARM_THRESH;
-
-	rte_io_wmb();
-	/* Update the tail pointer on the NIC */
-	I40E_PCI_REG_WRITE_RELAXED(rxq->qrx_tail, rx_id);
+	ci_rxq_rearm(rxq);
 }
 
 #ifndef RTE_NET_INTEL_USE_16BYTE_DESC
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c b/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
index 6bafd96797..15cf07e548 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
@@ -12,78 +12,14 @@
 #include "i40e_rxtx.h"
 #include "i40e_rxtx_vec_common.h"
 
+#include "../common/rx_vec_x86.h"
+
 #include <rte_vect.h>
 
 static inline void
 i40e_rxq_rearm(struct ci_rx_queue *rxq)
 {
-	int i;
-	uint16_t rx_id;
-	volatile union ci_rx_desc *rxdp;
-	struct ci_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
-	struct rte_mbuf *mb0, *mb1;
-	__m128i hdr_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
-			RTE_PKTMBUF_HEADROOM);
-	__m128i dma_addr0, dma_addr1;
-
-	rxdp = rxq->rx_ring + rxq->rxrearm_start;
-
-	/* Pull 'n' more MBUFs into the software ring */
-	if (rte_mempool_get_bulk(rxq->mp,
-				 (void *)rxep,
-				 I40E_VPMD_RXQ_REARM_THRESH) < 0) {
-		if (rxq->rxrearm_nb + I40E_VPMD_RXQ_REARM_THRESH >=
-		    rxq->nb_rx_desc) {
-			dma_addr0 = _mm_setzero_si128();
-			for (i = 0; i < I40E_VPMD_DESCS_PER_LOOP; i++) {
-				rxep[i].mbuf = &rxq->fake_mbuf;
-				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i].read),
-						dma_addr0);
-			}
-		}
-		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			I40E_VPMD_RXQ_REARM_THRESH;
-		return;
-	}
-
-	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < I40E_VPMD_RXQ_REARM_THRESH; i += 2, rxep += 2) {
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
-	rxq->rxrearm_start += I40E_VPMD_RXQ_REARM_THRESH;
-	rx_id = rxq->rxrearm_start - 1;
-
-	if (unlikely(rxq->rxrearm_start >= rxq->nb_rx_desc)) {
-		rxq->rxrearm_start = 0;
-		rx_id = rxq->nb_rx_desc - 1;
-	}
-
-	rxq->rxrearm_nb -= I40E_VPMD_RXQ_REARM_THRESH;
-
-	/* Update the tail pointer on the NIC */
-	I40E_PCI_REG_WC_WRITE(rxq->qrx_tail, rx_id);
+	ci_rxq_rearm(rxq, CI_RX_VEC_LEVEL_SSE);
 }
 
 #ifndef RTE_NET_INTEL_USE_16BYTE_DESC
-- 
2.47.1

