Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E57C3ABCD
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 12:56:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE91F406B8;
	Mon, 12 May 2025 14:55:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id BB41A40677
 for <dev@dpdk.org>; Mon, 12 May 2025 14:55:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747054504; x=1778590504;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hNNcvHoQJf0xcyrkCJbM2kBIFvd/QAE3qCIvUnhWJAE=;
 b=N95jogE5n78TUS0zL4xABprnB3NckQPYEumue/9s9cH82M+jYTGCZagT
 UQDOOIGVvByGpVkYsQdpHkpc51TdDChfewPXF54RH8ZurN/azNNia6Yx4
 GB2tcuH4JS6eEG26+5LFoD7K7njZbbblSzGoyUpqtESLx/a9A0EWn3xuv
 Y+G4HzTWobja1jH5SsozeQn1xDmvrl//OQYRe7p4nBvWbrzG1rqhsrY17
 Cp7vfxBG0Yd0oD6+0a9g5nHOXDTBA7/hmGRVAiwOl9wQKrh8bi+XbFCbJ
 oUZAa1rawMOZBGyc3N2El3SiOXRdGEkcqDZL+aaZE9TA1/fgrk5g0forp g==;
X-CSE-ConnectionGUID: kR05VQ3WT/mTuJ6Jz6ERew==
X-CSE-MsgGUID: PsZlW0TFSbmelBCEEoKBZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="48097013"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="48097013"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 05:55:04 -0700
X-CSE-ConnectionGUID: EU4+LP5SQf+B7ivvEhMqGA==
X-CSE-MsgGUID: ROitqz0SS5uHobWSGrUHRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="142251888"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa005.fm.intel.com with ESMTP; 12 May 2025 05:55:02 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v3 10/13] net/ixgbe: use common Rx rearm code
Date: Mon, 12 May 2025 13:54:36 +0100
Message-ID: <0fc78848f0d5c79af8a8d8d55156bc7b956b90d4.1747054471.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <afcd4013458bdb8b970e7ed57d6a1ede0ee654b8.1747054471.git.anatoly.burakov@intel.com>
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

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_rxtx.h          |  2 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c | 66 +---------------
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c  | 75 +------------------
 3 files changed, 7 insertions(+), 136 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.h b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
index 84e28eb254..f3dd32b9ff 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.h
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
@@ -37,7 +37,7 @@
 #define RTE_IXGBE_DESCS_PER_LOOP    4
 
 #if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
-#define RTE_IXGBE_RXQ_REARM_THRESH      32
+#define RTE_IXGBE_RXQ_REARM_THRESH      CI_VPMD_RX_REARM_THRESH
 #define RTE_IXGBE_MAX_RX_BURST          RTE_IXGBE_RXQ_REARM_THRESH
 #endif
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
index 630a2e6a1d..0842f213ef 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
@@ -11,72 +11,12 @@
 #include "ixgbe_rxtx.h"
 #include "ixgbe_rxtx_vec_common.h"
 
+#include "../common/rx_vec_neon.h"
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
-					  RTE_IXGBE_RXQ_REARM_THRESH) < 0)) {
-		if (rxq->rxrearm_nb + RTE_IXGBE_RXQ_REARM_THRESH >=
-		    rxq->nb_rx_desc) {
-			for (i = 0; i < RTE_IXGBE_DESCS_PER_LOOP; i++) {
-				rxep[i].mbuf = &rxq->fake_mbuf;
-				vst1q_u64(RTE_CAST_PTR(uint64_t *, &rxdp[i].read),
-					  zero);
-			}
-		}
-		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			RTE_IXGBE_RXQ_REARM_THRESH;
-		return;
-	}
-
-	p = vld1_u8((uint8_t *)&rxq->mbuf_initializer);
-
-	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < RTE_IXGBE_RXQ_REARM_THRESH; i += 2, rxep += 2) {
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
-	rxq->rxrearm_start += RTE_IXGBE_RXQ_REARM_THRESH;
-	if (rxq->rxrearm_start >= rxq->nb_rx_desc)
-		rxq->rxrearm_start = 0;
-
-	rxq->rxrearm_nb -= RTE_IXGBE_RXQ_REARM_THRESH;
-
-	rx_id = (uint16_t)((rxq->rxrearm_start == 0) ?
-			     (rxq->nb_rx_desc - 1) : (rxq->rxrearm_start - 1));
-
-	/* Update the tail pointer on the NIC */
-	IXGBE_PCI_REG_WRITE(rxq->qrx_tail, rx_id);
+	ci_rxq_rearm(rxq, sizeof(union ixgbe_adv_rx_desc));
 }
 
 static inline void
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
index ecfb0d6ba6..c6e90b8d41 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
@@ -10,83 +10,14 @@
 #include "ixgbe_rxtx.h"
 #include "ixgbe_rxtx_vec_common.h"
 
+#include "../common/rx_vec_sse.h"
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
-				 RTE_IXGBE_RXQ_REARM_THRESH) < 0) {
-		if (rxq->rxrearm_nb + RTE_IXGBE_RXQ_REARM_THRESH >=
-		    rxq->nb_rx_desc) {
-			dma_addr0 = _mm_setzero_si128();
-			for (i = 0; i < RTE_IXGBE_DESCS_PER_LOOP; i++) {
-				rxep[i].mbuf = &rxq->fake_mbuf;
-				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i].read),
-						dma_addr0);
-			}
-		}
-		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			RTE_IXGBE_RXQ_REARM_THRESH;
-		return;
-	}
-
-	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < RTE_IXGBE_RXQ_REARM_THRESH; i += 2, rxep += 2) {
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
-	rxq->rxrearm_start += RTE_IXGBE_RXQ_REARM_THRESH;
-	if (rxq->rxrearm_start >= rxq->nb_rx_desc)
-		rxq->rxrearm_start = 0;
-
-	rxq->rxrearm_nb -= RTE_IXGBE_RXQ_REARM_THRESH;
-
-	rx_id = (uint16_t) ((rxq->rxrearm_start == 0) ?
-			     (rxq->nb_rx_desc - 1) : (rxq->rxrearm_start - 1));
-
-	/* Update the tail pointer on the NIC */
-	IXGBE_PCI_REG_WC_WRITE(rxq->qrx_tail, rx_id);
+	ci_rxq_rearm(rxq, sizeof(union ixgbe_adv_rx_desc), CI_RX_VEC_LEVEL_SSE);
 }
 
 #ifdef RTE_LIB_SECURITY
-- 
2.47.1

