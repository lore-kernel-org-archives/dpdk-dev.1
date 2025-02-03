Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6909AC02193
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 07:42:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D04D40ED1;
	Mon,  3 Feb 2025 08:42:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 338BF40E7C
 for <dev@dpdk.org>; Mon,  3 Feb 2025 08:42:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738568525; x=1770104525;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=nnTdGGsha1aba3XP+Ne52gLW0vZoadZTvxV7uBr5mwU=;
 b=NVcsMTX12f8i889fsHpxSduhmnX9ztzEvi8loHfhCASfbIBUnP40asvp
 +t54pzBANrMT/xIKKNSws9x42gOKRPQlslhrui1Yn46rpgB9GQAy4sE3B
 bJoLWOyN+wLMA0U631KwJb50wii66ofGv2T1W/Gu8Tn8Cpw0p+f0MullA
 L1he8+XbX9fklMJg2+Y8scNQOFFDekvplBzRIG25Tm3Ah1W8myhp7Dnou
 KNp0iOB5NINh1NavFGaVjP3mgS4BGdKAH5T1Drld0tBaGsYex7Rl5uOR9
 xPN5/HkoTFUdK9xZLR6vyXufpm6IeJRnrvnrISclTrOaRjg38DmhgAIS2 w==;
X-CSE-ConnectionGUID: ntfNy2E+QK2xyqagGKnjSw==
X-CSE-MsgGUID: 4WayRZnhTz6QfkwpRXwoQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="56479581"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; d="scan'208";a="56479581"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2025 23:42:04 -0800
X-CSE-ConnectionGUID: OgG7c1TuT0+ZFDNVdeSY1g==
X-CSE-MsgGUID: +tVp6ozsROmB04XEXmprvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="133466625"
Received: from npg-npf-wlpr-srv12.iind.intel.com ([10.190.212.205])
 by fmviesa002.fm.intel.com with ESMTP; 02 Feb 2025 23:42:03 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v5 1/2] common/idpf: enable AVX2 for single queue Rx
Date: Mon,  3 Feb 2025 13:25:07 +0530
Message-Id: <20250203075508.1304702-2-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203075508.1304702-1-shaiq.wani@intel.com>
References: <20250203052430.1243485-2-shaiq.wani@intel.com>
 <20250203075508.1304702-1-shaiq.wani@intel.com>
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

In case some CPUs don't support AVX512. Enable AVX2 for them to
get better per-core performance.

The single queue model processes all packets in order while
the split queue model separates packet data and metadata into
different queues for parallel processing and improved performance.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/common/idpf/idpf_common_device.h    |   1 +
 drivers/common/idpf/idpf_common_rxtx.h      |   4 +
 drivers/common/idpf/idpf_common_rxtx_avx2.c | 480 ++++++++++++++++++++
 drivers/common/idpf/meson.build             |   7 +
 drivers/common/idpf/version.map             |   1 +
 drivers/net/intel/idpf/idpf_rxtx.c          |  11 +
 6 files changed, 504 insertions(+)
 create mode 100644 drivers/common/idpf/idpf_common_rxtx_avx2.c

diff --git a/drivers/common/idpf/idpf_common_device.h b/drivers/common/idpf/idpf_common_device.h
index bfa927a5ff..734be1c88a 100644
--- a/drivers/common/idpf/idpf_common_device.h
+++ b/drivers/common/idpf/idpf_common_device.h
@@ -123,6 +123,7 @@ struct idpf_vport {
 
 	bool rx_vec_allowed;
 	bool tx_vec_allowed;
+	bool rx_use_avx2;
 	bool rx_use_avx512;
 	bool tx_use_avx512;
 
diff --git a/drivers/common/idpf/idpf_common_rxtx.h b/drivers/common/idpf/idpf_common_rxtx.h
index eeeeed12e2..f50cf5ef46 100644
--- a/drivers/common/idpf/idpf_common_rxtx.h
+++ b/drivers/common/idpf/idpf_common_rxtx.h
@@ -302,5 +302,9 @@ uint16_t idpf_dp_splitq_xmit_pkts_avx512(void *tx_queue, struct rte_mbuf **tx_pk
 __rte_internal
 uint16_t idpf_dp_singleq_recv_scatter_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			  uint16_t nb_pkts);
+__rte_internal
+uint16_t idpf_dp_singleq_recv_pkts_avx2(void *rx_queue,
+					struct rte_mbuf **rx_pkts,
+					uint16_t nb_pkts);
 
 #endif /* _IDPF_COMMON_RXTX_H_ */
diff --git a/drivers/common/idpf/idpf_common_rxtx_avx2.c b/drivers/common/idpf/idpf_common_rxtx_avx2.c
new file mode 100644
index 0000000000..277b2a9469
--- /dev/null
+++ b/drivers/common/idpf/idpf_common_rxtx_avx2.c
@@ -0,0 +1,480 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 Intel Corporation
+ */
+
+#include <rte_vect.h>
+
+#include "idpf_common_rxtx.h"
+#include "idpf_common_device.h"
+
+static __rte_always_inline void
+idpf_singleq_rx_rearm(struct idpf_rx_queue *rxq)
+{
+	int i;
+	uint16_t rx_id;
+	volatile union virtchnl2_rx_desc *rxdp = rxq->rx_ring;
+	struct rte_mbuf **rxep = &rxq->sw_ring[rxq->rxrearm_start];
+
+	rxdp += rxq->rxrearm_start;
+
+	/* Pull 'n' more MBUFs into the software ring */
+	if (rte_mempool_get_bulk(rxq->mp,
+				 (void *)rxep,
+				 IDPF_RXQ_REARM_THRESH) < 0) {
+		if (rxq->rxrearm_nb + IDPF_RXQ_REARM_THRESH >=
+		    rxq->nb_rx_desc) {
+			__m128i dma_addr0;
+
+			dma_addr0 = _mm_setzero_si128();
+			for (i = 0; i < IDPF_VPMD_DESCS_PER_LOOP; i++) {
+				rxep[i] = &rxq->fake_mbuf;
+				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i].read), dma_addr0);
+			}
+		}
+		rte_atomic_fetch_add_explicit(&rxq->rx_stats.mbuf_alloc_failed,
+				IDPF_RXQ_REARM_THRESH, rte_memory_order_relaxed);
+		return;
+	}
+
+	struct rte_mbuf *mb0, *mb1;
+	__m128i dma_addr0, dma_addr1;
+	__m128i hdr_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
+			RTE_PKTMBUF_HEADROOM);
+	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
+	for (i = 0; i < IDPF_RXQ_REARM_THRESH; i += 2, rxep += 2) {
+		__m128i vaddr0, vaddr1;
+
+		mb0 = rxep[0];
+		mb1 = rxep[1];
+
+		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
+		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
+				offsetof(struct rte_mbuf, buf_addr) + 8);
+		vaddr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
+		vaddr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
+
+		/* convert pa to dma_addr hdr/data */
+		dma_addr0 = _mm_unpackhi_epi64(vaddr0, vaddr0);
+		dma_addr1 = _mm_unpackhi_epi64(vaddr1, vaddr1);
+
+		/* add headroom to pa values */
+		dma_addr0 = _mm_add_epi64(dma_addr0, hdr_room);
+		dma_addr1 = _mm_add_epi64(dma_addr1, hdr_room);
+
+		/* flush desc with pa dma_addr */
+		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp++->read), dma_addr0);
+		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp++->read), dma_addr1);
+	}
+
+	rxq->rxrearm_start += IDPF_RXQ_REARM_THRESH;
+	if (rxq->rxrearm_start >= rxq->nb_rx_desc)
+		rxq->rxrearm_start = 0;
+
+	rxq->rxrearm_nb -= IDPF_RXQ_REARM_THRESH;
+
+	rx_id = (uint16_t)((rxq->rxrearm_start == 0) ?
+			     (rxq->nb_rx_desc - 1) : (rxq->rxrearm_start - 1));
+
+	/* Update the tail pointer on the NIC */
+	IDPF_PCI_REG_WRITE(rxq->qrx_tail, rx_id);
+}
+
+static inline uint16_t
+_idpf_singleq_recv_raw_pkts_vec_avx2(struct idpf_rx_queue *rxq, struct rte_mbuf **rx_pkts,
+				     uint16_t nb_pkts)
+{
+#define IDPF_DESCS_PER_LOOP_AVX 8
+
+	const uint32_t *ptype_tbl = rxq->adapter->ptype_tbl;
+	const __m256i mbuf_init = _mm256_set_epi64x(0, 0,
+			0, rxq->mbuf_initializer);
+	struct rte_mbuf **sw_ring = &rxq->sw_ring[rxq->rx_tail];
+	volatile union virtchnl2_rx_desc *rxdp = rxq->rx_ring;
+	const int avx_aligned = ((rxq->rx_tail & 1) == 0);
+
+	rxdp += rxq->rx_tail;
+
+	rte_prefetch0(rxdp);
+
+	/* nb_pkts has to be floor-aligned to IDPF_DESCS_PER_LOOP_AVX */
+	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, IDPF_DESCS_PER_LOOP_AVX);
+
+	/* See if we need to rearm the RX queue - gives the prefetch a bit
+	 * of time to act
+	 */
+	if (rxq->rxrearm_nb > IDPF_RXQ_REARM_THRESH)
+		idpf_singleq_rx_rearm(rxq);
+
+	/* Before we start moving massive data around, check to see if
+	 * there is actually a packet available
+	 */
+	if (!(rxdp->flex_nic_wb.status_error0 &
+			rte_cpu_to_le_32(1 << VIRTCHNL2_RX_FLEX_DESC_STATUS0_DD_S)))
+		return 0;
+
+	/* 8 packets DD mask, LSB in each 32-bit value */
+	const __m256i dd_check = _mm256_set1_epi32(1);
+
+	/* mask to shuffle from desc. to mbuf (2 descriptors)*/
+	const __m256i shuf_msk =
+		_mm256_set_epi8
+			(/* first descriptor */
+			 0xFF, 0xFF,
+			 0xFF, 0xFF,	/* rss hash parsed separately */
+			 11, 10,	/* octet 10~11, 16 bits vlan_macip */
+			 5, 4,		/* octet 4~5, 16 bits data_len */
+			 0xFF, 0xFF,	/* skip hi 16 bits pkt_len, zero out */
+			 5, 4,		/* octet 4~5, 16 bits pkt_len */
+			 0xFF, 0xFF,	/* pkt_type set as unknown */
+			 0xFF, 0xFF,	/*pkt_type set as unknown */
+			 /* second descriptor */
+			 0xFF, 0xFF,
+			 0xFF, 0xFF,	/* rss hash parsed separately */
+			 11, 10,	/* octet 10~11, 16 bits vlan_macip */
+			 5, 4,		/* octet 4~5, 16 bits data_len */
+			 0xFF, 0xFF,	/* skip hi 16 bits pkt_len, zero out */
+			 5, 4,		/* octet 4~5, 16 bits pkt_len */
+			 0xFF, 0xFF,	/* pkt_type set as unknown */
+			 0xFF, 0xFF	/*pkt_type set as unknown */
+			);
+	/**
+	 * compile-time check the above crc and shuffle layout is correct.
+	 * NOTE: the first field (lowest address) is given last in set_epi
+	 * calls above.
+	 */
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, pkt_len) !=
+			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 4);
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, data_len) !=
+			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 8);
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, vlan_tci) !=
+			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 10);
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, hash) !=
+			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 12);
+
+	/* Status/Error flag masks */
+	/**
+	 * mask everything except Checksum Reports, RSS indication
+	 * and VLAN indication.
+	 * bit6:4 for IP/L4 checksum errors.
+	 * bit12 is for RSS indication.
+	 * bit13 is for VLAN indication.
+	 */
+	const __m256i flags_mask =
+		 _mm256_set1_epi32((0xF << 4) | (1 << 12) | (1 << 13));
+	/**
+	 * data to be shuffled by the result of the flags mask shifted by 4
+	 * bits.  This gives use the l3_l4 flags.
+	 */
+	const __m256i l3_l4_flags_shuf =
+		_mm256_set_epi8((RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 |
+		 RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_BAD |
+		  RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+		 RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+		 RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+		 RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_BAD  |
+		 RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_BAD  |
+		 RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
+		 RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
+		 RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+		 RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+		 RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+		 RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+		 RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_BAD |
+		 RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_BAD |
+		 RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
+		 RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
+		 RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
+		/**
+		 * second 128-bits
+		 * shift right 20 bits to use the low two bits to indicate
+		 * outer checksum status
+		 * shift right 1 bit to make sure it not exceed 255
+		 */
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+		 RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+		 RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+		 RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+		 RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_BAD  |
+		 RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_BAD  |
+		 RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
+		 RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
+		 RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+		 RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+		 RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+		 RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+		 RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_BAD |
+		 RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_BAD |
+		 RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
+		 RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
+		 RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1);
+	const __m256i cksum_mask =
+		 _mm256_set1_epi32(RTE_MBUF_F_RX_IP_CKSUM_MASK |
+				   RTE_MBUF_F_RX_L4_CKSUM_MASK |
+				   RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+				   RTE_MBUF_F_RX_OUTER_L4_CKSUM_MASK);
+	/**
+	 * data to be shuffled by result of flag mask, shifted down 12.
+	 * If RSS(bit12)/VLAN(bit13) are set,
+	 * shuffle moves appropriate flags in place.
+	 */
+	const __m256i rss_vlan_flags_shuf = _mm256_set_epi8(0, 0, 0, 0,
+			0, 0, 0, 0,
+			0, 0, 0, 0,
+			RTE_MBUF_F_RX_RSS_HASH | RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED,
+			RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED,
+			RTE_MBUF_F_RX_RSS_HASH, 0,
+			/* end up 128-bits */
+			0, 0, 0, 0,
+			0, 0, 0, 0,
+			0, 0, 0, 0,
+			RTE_MBUF_F_RX_RSS_HASH | RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED,
+			RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED,
+			RTE_MBUF_F_RX_RSS_HASH, 0);
+
+	RTE_SET_USED(avx_aligned); /* for 32B descriptors we don't use this */
+
+	uint16_t i, received;
+
+	for (i = 0, received = 0; i < nb_pkts;
+	     i += IDPF_DESCS_PER_LOOP_AVX,
+	     rxdp += IDPF_DESCS_PER_LOOP_AVX) {
+		/* step 1, copy over 8 mbuf pointers to rx_pkts array */
+		_mm256_storeu_si256((void *)&rx_pkts[i],
+				    _mm256_loadu_si256((void *)&sw_ring[i]));
+#ifdef RTE_ARCH_X86_64
+		_mm256_storeu_si256
+			((void *)&rx_pkts[i + 4],
+			 _mm256_loadu_si256((void *)&sw_ring[i + 4]));
+#endif
+
+		__m256i raw_desc0_1, raw_desc2_3, raw_desc4_5, raw_desc6_7;
+
+		const __m128i raw_desc7 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, rxdp + 7));
+		rte_compiler_barrier();
+		const __m128i raw_desc6 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, rxdp + 6));
+		rte_compiler_barrier();
+		const __m128i raw_desc5 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, rxdp + 5));
+		rte_compiler_barrier();
+		const __m128i raw_desc4 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, rxdp + 4));
+		rte_compiler_barrier();
+		const __m128i raw_desc3 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, rxdp + 3));
+		rte_compiler_barrier();
+		const __m128i raw_desc2 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, rxdp + 2));
+		rte_compiler_barrier();
+		const __m128i raw_desc1 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, rxdp + 1));
+		rte_compiler_barrier();
+		const __m128i raw_desc0 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, rxdp + 0));
+
+		raw_desc6_7 = _mm256_inserti128_si256(_mm256_castsi128_si256(raw_desc6),
+		raw_desc7, 1);
+		raw_desc4_5 = _mm256_inserti128_si256(_mm256_castsi128_si256(raw_desc4),
+		raw_desc5, 1);
+		raw_desc2_3 = _mm256_inserti128_si256(_mm256_castsi128_si256(raw_desc2),
+		raw_desc3, 1);
+		raw_desc0_1 = _mm256_inserti128_si256(_mm256_castsi128_si256(raw_desc0),
+		raw_desc1, 1);
+
+		/**
+		 * convert descriptors 4-7 into mbufs, re-arrange fields.
+		 * Then write into the mbuf.
+		 */
+		__m256i mb6_7 = _mm256_shuffle_epi8(raw_desc6_7, shuf_msk);
+		__m256i mb4_5 = _mm256_shuffle_epi8(raw_desc4_5, shuf_msk);
+
+		/**
+		 * to get packet types, ptype is located in bit16-25
+		 * of each 128bits
+		 */
+		const __m256i ptype_mask = _mm256_set1_epi16(VIRTCHNL2_RX_FLEX_DESC_PTYPE_M);
+		const __m256i ptypes6_7 = _mm256_and_si256(raw_desc6_7, ptype_mask);
+		const __m256i ptypes4_5 = _mm256_and_si256(raw_desc4_5, ptype_mask);
+		const uint16_t ptype7 = _mm256_extract_epi16(ptypes6_7, 9);
+		const uint16_t ptype6 = _mm256_extract_epi16(ptypes6_7, 1);
+		const uint16_t ptype5 = _mm256_extract_epi16(ptypes4_5, 9);
+		const uint16_t ptype4 = _mm256_extract_epi16(ptypes4_5, 1);
+
+		mb6_7 = _mm256_insert_epi32(mb6_7, ptype_tbl[ptype7], 4);
+		mb6_7 = _mm256_insert_epi32(mb6_7, ptype_tbl[ptype6], 0);
+		mb4_5 = _mm256_insert_epi32(mb4_5, ptype_tbl[ptype5], 4);
+		mb4_5 = _mm256_insert_epi32(mb4_5, ptype_tbl[ptype4], 0);
+		/* merge the status bits into one register */
+		const __m256i status4_7 = _mm256_unpackhi_epi32(raw_desc6_7,
+			raw_desc4_5);
+
+		/**
+		 * convert descriptors 0-3 into mbufs, re-arrange fields.
+		 * Then write into the mbuf.
+		 */
+		__m256i mb2_3 = _mm256_shuffle_epi8(raw_desc2_3, shuf_msk);
+		__m256i mb0_1 = _mm256_shuffle_epi8(raw_desc0_1, shuf_msk);
+
+		/**
+		 * to get packet types, ptype is located in bit16-25
+		 * of each 128bits
+		 */
+		const __m256i ptypes2_3 = _mm256_and_si256(raw_desc2_3, ptype_mask);
+		const __m256i ptypes0_1 = _mm256_and_si256(raw_desc0_1, ptype_mask);
+		const uint16_t ptype3 = _mm256_extract_epi16(ptypes2_3, 9);
+		const uint16_t ptype2 = _mm256_extract_epi16(ptypes2_3, 1);
+		const uint16_t ptype1 = _mm256_extract_epi16(ptypes0_1, 9);
+		const uint16_t ptype0 = _mm256_extract_epi16(ptypes0_1, 1);
+
+		mb2_3 = _mm256_insert_epi32(mb2_3, ptype_tbl[ptype3], 4);
+		mb2_3 = _mm256_insert_epi32(mb2_3, ptype_tbl[ptype2], 0);
+		mb0_1 = _mm256_insert_epi32(mb0_1, ptype_tbl[ptype1], 4);
+		mb0_1 = _mm256_insert_epi32(mb0_1, ptype_tbl[ptype0], 0);
+		/* merge the status bits into one register */
+		const __m256i status0_3 = _mm256_unpackhi_epi32(raw_desc2_3,
+			raw_desc0_1);
+
+		/**
+		 * take the two sets of status bits and merge to one
+		 * After merge, the packets status flags are in the
+		 * order (hi->lo): [1, 3, 5, 7, 0, 2, 4, 6]
+		 */
+		__m256i status0_7 = _mm256_unpacklo_epi64(status4_7,
+			status0_3);
+
+		/* now do flag manipulation */
+
+		/* get only flag/error bits we want */
+		const __m256i flag_bits = _mm256_and_si256(status0_7, flags_mask);
+		/**
+		 * l3_l4_error flags, shuffle, then shift to correct adjustment
+		 * of flags in flags_shuf, and finally mask out extra bits
+		 */
+		__m256i l3_l4_flags = _mm256_shuffle_epi8(l3_l4_flags_shuf,
+			_mm256_srli_epi32(flag_bits, 4));
+		l3_l4_flags = _mm256_slli_epi32(l3_l4_flags, 1);
+
+		__m256i l4_outer_mask = _mm256_set1_epi32(0x6);
+		__m256i l4_outer_flags = _mm256_and_si256(l3_l4_flags, l4_outer_mask);
+		l4_outer_flags = _mm256_slli_epi32(l4_outer_flags, 20);
+
+		__m256i l3_l4_mask = _mm256_set1_epi32(~0x6);
+		l3_l4_flags = _mm256_and_si256(l3_l4_flags, l3_l4_mask);
+		l3_l4_flags = _mm256_or_si256(l3_l4_flags, l4_outer_flags);
+		l3_l4_flags = _mm256_and_si256(l3_l4_flags, cksum_mask);
+		/* set rss and vlan flags */
+		const __m256i rss_vlan_flag_bits = _mm256_srli_epi32(flag_bits, 12);
+		const __m256i rss_vlan_flags = _mm256_shuffle_epi8(rss_vlan_flags_shuf,
+			rss_vlan_flag_bits);
+
+		/* merge flags */
+		__m256i mbuf_flags = _mm256_or_si256(l3_l4_flags, rss_vlan_flags);
+
+		/**
+		 * At this point, we have the 8 sets of flags in the low 16-bits
+		 * of each 32-bit value in vlan0.
+		 * We want to extract these, and merge them with the mbuf init
+		 * data so we can do a single write to the mbuf to set the flags
+		 * and all the other initialization fields. Extracting the
+		 * appropriate flags means that we have to do a shift and blend
+		 * for each mbuf before we do the write. However, we can also
+		 * add in the previously computed rx_descriptor fields to
+		 * make a single 256-bit write per mbuf
+		 */
+		/* check the structure matches expectations */
+		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, ol_flags) != offsetof(struct rte_mbuf,
+			rearm_data) + 8);
+		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, rearm_data) != RTE_ALIGN
+			(offsetof(struct rte_mbuf, rearm_data), 16));
+		/* build up data and do writes */
+		__m256i rearm0, rearm1, rearm2, rearm3, rearm4, rearm5, rearm6, rearm7;
+		rearm6 = _mm256_blend_epi32(mbuf_init, _mm256_slli_si256(mbuf_flags, 8), 0x04);
+		rearm4 = _mm256_blend_epi32(mbuf_init, _mm256_slli_si256(mbuf_flags, 4), 0x04);
+		rearm2 = _mm256_blend_epi32(mbuf_init, mbuf_flags, 0x04);
+		rearm0 = _mm256_blend_epi32(mbuf_init, _mm256_srli_si256(mbuf_flags, 4), 0x04);
+		/* permute to add in the rx_descriptor e.g. rss fields */
+		rearm6 = _mm256_permute2f128_si256(rearm6, mb6_7, 0x20);
+		rearm4 = _mm256_permute2f128_si256(rearm4, mb4_5, 0x20);
+		rearm2 = _mm256_permute2f128_si256(rearm2, mb2_3, 0x20);
+		rearm0 = _mm256_permute2f128_si256(rearm0, mb0_1, 0x20);
+		/* write to mbuf */
+		_mm256_storeu_si256((__m256i *)&rx_pkts[i + 6]->rearm_data, rearm6);
+		_mm256_storeu_si256((__m256i *)&rx_pkts[i + 4]->rearm_data, rearm4);
+		_mm256_storeu_si256((__m256i *)&rx_pkts[i + 2]->rearm_data, rearm2);
+		_mm256_storeu_si256((__m256i *)&rx_pkts[i + 0]->rearm_data, rearm0);
+
+		/* repeat for the odd mbufs */
+		const __m256i odd_flags = _mm256_castsi128_si256(_mm256_extracti128_si256
+			(mbuf_flags, 1));
+		rearm7 = _mm256_blend_epi32(mbuf_init, _mm256_slli_si256(odd_flags, 8), 0x04);
+		rearm5 = _mm256_blend_epi32(mbuf_init, _mm256_slli_si256(odd_flags, 4), 0x04);
+		rearm3 = _mm256_blend_epi32(mbuf_init, odd_flags, 0x04);
+		rearm1 = _mm256_blend_epi32(mbuf_init, _mm256_srli_si256(odd_flags, 4), 0x04);
+		/* since odd mbufs are already in hi 128-bits use blend */
+		rearm7 = _mm256_blend_epi32(rearm7, mb6_7, 0xF0);
+		rearm5 = _mm256_blend_epi32(rearm5, mb4_5, 0xF0);
+		rearm3 = _mm256_blend_epi32(rearm3, mb2_3, 0xF0);
+		rearm1 = _mm256_blend_epi32(rearm1, mb0_1, 0xF0);
+		/* again write to mbufs */
+		_mm256_storeu_si256((__m256i *)&rx_pkts[i + 7]->rearm_data, rearm7);
+		_mm256_storeu_si256((__m256i *)&rx_pkts[i + 5]->rearm_data, rearm5);
+		_mm256_storeu_si256((__m256i *)&rx_pkts[i + 3]->rearm_data, rearm3);
+		_mm256_storeu_si256((__m256i *)&rx_pkts[i + 1]->rearm_data, rearm1);
+
+	    /* perform dd_check */
+		status0_7 = _mm256_and_si256(status0_7, dd_check);
+		status0_7 = _mm256_packs_epi32(status0_7, _mm256_setzero_si256());
+
+		uint64_t burst = rte_popcount64(_mm_cvtsi128_si64(_mm256_extracti128_si256
+			(status0_7, 1)));
+		burst += rte_popcount64(_mm_cvtsi128_si64(_mm256_castsi256_si128
+			(status0_7)));
+
+		received += burst;
+		if (burst != IDPF_DESCS_PER_LOOP_AVX)
+			break;
+	}
+
+	/* update tail pointers */
+	rxq->rx_tail += received;
+	rxq->rx_tail &= (rxq->nb_rx_desc - 1);
+	if ((rxq->rx_tail & 1) == 1 && received > 1) { /* keep avx2 aligned */
+		rxq->rx_tail--;
+		received--;
+	}
+	rxq->rxrearm_nb += received;
+	return received;
+}
+
+/**
+ * Notice:
+ * - nb_pkts < IDPF_DESCS_PER_LOOP, just return no packet
+ */
+uint16_t
+idpf_dp_singleq_recv_pkts_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
+{
+	return _idpf_singleq_recv_raw_pkts_vec_avx2(rx_queue, rx_pkts, nb_pkts);
+}
diff --git a/drivers/common/idpf/meson.build b/drivers/common/idpf/meson.build
index 46fd45c03b..0a30c7e601 100644
--- a/drivers/common/idpf/meson.build
+++ b/drivers/common/idpf/meson.build
@@ -16,6 +16,13 @@ sources = files(
 )
 
 if arch_subdir == 'x86'
+    idpf_avx2_lib = static_library('idpf_avx2_lib',
+        'idpf_common_rxtx_avx2.c',
+        dependencies: [static_rte_ethdev, static_rte_hash],
+        include_directories: includes,
+        c_args: [cflags, '-mavx2'])
+    objs += idpf_avx2_lib.extract_objects('idpf_common_rxtx_avx2.c')
+
     if cc_has_avx512
         cflags += ['-DCC_AVX512_SUPPORT']
         avx512_args = cflags + cc_avx512_flags
diff --git a/drivers/common/idpf/version.map b/drivers/common/idpf/version.map
index 0729f6b912..22b689f5f5 100644
--- a/drivers/common/idpf/version.map
+++ b/drivers/common/idpf/version.map
@@ -6,6 +6,7 @@ INTERNAL {
 
 	idpf_dp_prep_pkts;
 	idpf_dp_singleq_recv_pkts;
+	idpf_dp_singleq_recv_pkts_avx2;
 	idpf_dp_singleq_recv_pkts_avx512;
 	idpf_dp_singleq_recv_scatter_pkts;
 	idpf_dp_singleq_xmit_pkts;
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 858bbefe3b..a8377d3fee 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -776,6 +776,10 @@ idpf_set_rx_function(struct rte_eth_dev *dev)
 	    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
 		vport->rx_vec_allowed = true;
 
+		if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1 &&
+		    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
+			vport->rx_use_avx2 = true;
+
 		if (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512)
 #ifdef CC_AVX512_SUPPORT
 			if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1 &&
@@ -827,6 +831,13 @@ idpf_set_rx_function(struct rte_eth_dev *dev)
 				return;
 			}
 #endif /* CC_AVX512_SUPPORT */
+			if (vport->rx_use_avx2) {
+				PMD_DRV_LOG(NOTICE,
+					    "Using Single AVX2 Vector Rx (port %d).",
+					    dev->data->port_id);
+				dev->rx_pkt_burst = idpf_dp_singleq_recv_pkts_avx2;
+				return;
+			}
 		}
 
 		if (dev->data->scattered_rx) {
-- 
2.34.1

