Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C68C5B543
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 13:58:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C688E4067A;
	Fri, 30 May 2025 15:57:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 0193040666
 for <dev@dpdk.org>; Fri, 30 May 2025 15:57:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748613470; x=1780149470;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fkPzRmb8sQOq4mCeiv+uXBvg+20tJr4zO4TBv8TO2Cs=;
 b=Gh2MyIGN9rOP+JB70rgm7t9+pUvg1PpQuDgs96ffRMMUTfl5tSvn+aZ8
 rQc3riekQI+cCx8uZgjw//SC1s0VicrP/BrRdKM4QTxeTP59jLA84CPkr
 20bkswPKoRLV6HR8Mse2KlIzdc7jVEM6Q43Hm5fuxoh7Mb5X6eSXO0Opl
 v5OG6ysyZkqoXLAyf4/J2yYhC4Y4aDCSBccd4zubswcVGJRHjwe5OTj4k
 iR6S4lQRvEyMV9XOXaU1QIIVKhiGbf20z7Yj/kRWPrsjFOoUobi8Baf7M
 qHg4uv5xCTZRcdEiYCsVDE2k8+7L+wwwbtTRammIhtHTuALlHsRHGcjRm g==;
X-CSE-ConnectionGUID: KCGMrA03Rc+x3XDN+mJiow==
X-CSE-MsgGUID: g4eb8VxhTxKO4lP94CIUuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="50809374"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; d="scan'208";a="50809374"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2025 06:57:49 -0700
X-CSE-ConnectionGUID: q1xy4tvISTKxj/6WFSCuHg==
X-CSE-MsgGUID: MXWq21wiTOaoS2A8RztBCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; d="scan'208";a="174887423"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa002.jf.intel.com with ESMTP; 30 May 2025 06:57:48 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ian Stokes <ian.stokes@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v4 08/25] net/iavf: rename 16-byte descriptor define
Date: Fri, 30 May 2025 14:57:04 +0100
Message-ID: <0165cc6e2a54ececf6c8b29aa6ac62ad7ff5fe26.1748612803.git.anatoly.burakov@intel.com>
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

In preparation for having a common definition for 16-byte and 32-byte Rx
descriptors, rename RTE_LIBRTE_IAVF_16BYTE_RX_DESC to
RTE_NET_INTEL_USE_16BYTE_DESC.

Suggested-by: Bruce Richardson <bruce.richardson@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v3 -> v4:
    - Add this commit

 drivers/net/intel/iavf/iavf_rxtx.c            | 14 +++++++-------
 drivers/net/intel/iavf/iavf_rxtx.h            |  4 ++--
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   | 10 +++++-----
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 10 +++++-----
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  2 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_sse.c    | 18 +++++++++---------
 drivers/net/intel/iavf/iavf_vchnl.c           |  2 +-
 7 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index d23d2df807..fd6c7d3a3e 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -345,7 +345,7 @@ alloc_rxq_mbufs(struct iavf_rx_queue *rxq)
 		rxd = &rxq->rx_ring[i];
 		rxd->read.pkt_addr = dma_addr;
 		rxd->read.hdr_addr = 0;
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 		rxd->read.rsvd1 = 0;
 		rxd->read.rsvd2 = 0;
 #endif
@@ -401,7 +401,7 @@ iavf_rxd_to_pkt_fields_by_comms_ovs(__rte_unused struct iavf_rx_queue *rxq,
 {
 	volatile struct iavf_32b_rx_flex_desc_comms_ovs *desc =
 			(volatile struct iavf_32b_rx_flex_desc_comms_ovs *)rxdp;
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	uint16_t stat_err;
 #endif
 
@@ -410,7 +410,7 @@ iavf_rxd_to_pkt_fields_by_comms_ovs(__rte_unused struct iavf_rx_queue *rxq,
 		mb->hash.fdir.hi = rte_le_to_cpu_32(desc->flow_id);
 	}
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	stat_err = rte_le_to_cpu_16(desc->status_error0);
 	if (likely(stat_err & (1 << IAVF_RX_FLEX_DESC_STATUS0_RSS_VALID_S))) {
 		mb->ol_flags |= RTE_MBUF_F_RX_RSS_HASH;
@@ -434,7 +434,7 @@ iavf_rxd_to_pkt_fields_by_comms_aux_v1(struct iavf_rx_queue *rxq,
 		mb->hash.rss = rte_le_to_cpu_32(desc->rss_hash);
 	}
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	if (desc->flow_id != 0xFFFFFFFF) {
 		mb->ol_flags |= RTE_MBUF_F_RX_FDIR | RTE_MBUF_F_RX_FDIR_ID;
 		mb->hash.fdir.hi = rte_le_to_cpu_32(desc->flow_id);
@@ -476,7 +476,7 @@ iavf_rxd_to_pkt_fields_by_comms_aux_v2(struct iavf_rx_queue *rxq,
 		mb->hash.rss = rte_le_to_cpu_32(desc->rss_hash);
 	}
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	if (desc->flow_id != 0xFFFFFFFF) {
 		mb->ol_flags |= RTE_MBUF_F_RX_FDIR | RTE_MBUF_F_RX_FDIR_ID;
 		mb->hash.fdir.hi = rte_le_to_cpu_32(desc->flow_id);
@@ -1177,7 +1177,7 @@ iavf_flex_rxd_to_vlan_tci(struct rte_mbuf *mb,
 		mb->vlan_tci = 0;
 	}
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	if (rte_le_to_cpu_16(rxdp->wb.status_error1) &
 	    (1 << IAVF_RX_FLEX_DESC_STATUS1_L2TAG2P_S)) {
 		mb->ol_flags |= RTE_MBUF_F_RX_QINQ_STRIPPED |
@@ -1301,7 +1301,7 @@ static inline uint64_t
 iavf_rxd_build_fdir(volatile union iavf_rx_desc *rxdp, struct rte_mbuf *mb)
 {
 	uint64_t flags = 0;
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	uint16_t flexbh;
 
 	flexbh = (rte_le_to_cpu_32(rxdp->wb.qword2.ext_status) >>
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 62b5a67c84..6198643605 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -195,7 +195,7 @@ union iavf_32b_rx_flex_desc {
 };
 
 /* HW desc structure, both 16-byte and 32-byte types are supported */
-#ifdef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifdef RTE_NET_INTEL_USE_16BYTE_DESC
 #define iavf_rx_desc iavf_16byte_rx_desc
 #define iavf_rx_flex_desc iavf_16b_rx_flex_desc
 #else
@@ -740,7 +740,7 @@ void iavf_dump_rx_descriptor(struct iavf_rx_queue *rxq,
 			    const volatile void *desc,
 			    uint16_t rx_id)
 {
-#ifdef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifdef RTE_NET_INTEL_USE_16BYTE_DESC
 	const volatile union iavf_16byte_rx_desc *rx_desc = desc;
 
 	printf("Queue %d Rx_desc %d: QW0: 0x%016"PRIx64" QW1: 0x%016"PRIx64"\n",
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index 88e35dc3e9..d94a8b0ae1 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -496,7 +496,7 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct iavf_rx_queue *rxq,
 
 	struct iavf_adapter *adapter = rxq->vsi->adapter;
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	uint64_t offloads = adapter->dev_data->dev_conf.rxmode.offloads;
 #endif
 	const uint32_t *type_table = adapter->ptype_tbl;
@@ -524,7 +524,7 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct iavf_rx_queue *rxq,
 	if (!(rxdp->wb.status_error0 &
 			rte_cpu_to_le_32(1 << IAVF_RX_FLEX_DESC_STATUS0_DD_S)))
 		return 0;
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	bool is_tsinit = false;
 	uint8_t inflection_point = 0;
 	__m256i hw_low_last = _mm256_set_epi32(0, 0, 0, 0, 0, 0, 0, rxq->phc_time);
@@ -946,7 +946,7 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct iavf_rx_queue *rxq,
 		} /* if() on fdir_enabled */
 
 		if (offload) {
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 			/**
 			 * needs to load 2nd 16B of each desc,
 			 * will cause performance drop to get into this context.
@@ -1360,7 +1360,7 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct iavf_rx_queue *rxq,
 				(_mm_cvtsi128_si64
 					(_mm256_castsi256_si128(status0_7)));
 		received += burst;
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 		if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
 			inflection_point = (inflection_point <= burst) ? inflection_point : 0;
 			switch (inflection_point) {
@@ -1411,7 +1411,7 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct iavf_rx_queue *rxq,
 			break;
 	}
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	if (received > 0 && (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP))
 		rxq->phc_time = *RTE_MBUF_DYNFIELD(rx_pkts[received - 1], iavf_timestamp_dynfield_offset, rte_mbuf_timestamp_t *);
 #endif
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index f2af028bef..895b8717f7 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -585,7 +585,7 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct iavf_rx_queue *rxq,
 					bool offload)
 {
 	struct iavf_adapter *adapter = rxq->vsi->adapter;
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	uint64_t offloads = adapter->dev_data->dev_conf.rxmode.offloads;
 #endif
 #ifdef IAVF_RX_PTYPE_OFFLOAD
@@ -616,7 +616,7 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct iavf_rx_queue *rxq,
 	      rte_cpu_to_le_32(1 << IAVF_RX_FLEX_DESC_STATUS0_DD_S)))
 		return 0;
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 #ifdef IAVF_RX_TS_OFFLOAD
 	uint8_t inflection_point = 0;
 	bool is_tsinit = false;
@@ -1096,7 +1096,7 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct iavf_rx_queue *rxq,
 		__m256i mb0_1 = _mm512_extracti64x4_epi64(mb0_3, 0);
 		__m256i mb2_3 = _mm512_extracti64x4_epi64(mb0_3, 1);
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 		if (offload) {
 #if defined(IAVF_RX_RSS_OFFLOAD) || defined(IAVF_RX_TS_OFFLOAD)
 			/**
@@ -1548,7 +1548,7 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct iavf_rx_queue *rxq,
 				(_mm_cvtsi128_si64
 					(_mm256_castsi256_si128(status0_7)));
 		received += burst;
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 #ifdef IAVF_RX_TS_OFFLOAD
 		if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
 			inflection_point = (inflection_point <= burst) ? inflection_point : 0;
@@ -1601,7 +1601,7 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct iavf_rx_queue *rxq,
 			break;
 	}
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 #ifdef IAVF_RX_TS_OFFLOAD
 	if (received > 0 && (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP))
 		rxq->phc_time = *RTE_MBUF_DYNFIELD(rx_pkts[received - 1],
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
index 38e9a206d9..f577fd7f3e 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
@@ -269,7 +269,7 @@ iavf_rxq_rearm_common(struct iavf_rx_queue *rxq, __rte_unused bool avx512)
 		return;
 	}
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	struct rte_mbuf *mb0, *mb1;
 	__m128i dma_addr0, dma_addr1;
 	__m128i hdr_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_sse.c b/drivers/net/intel/iavf/iavf_rxtx_vec_sse.c
index 2e41079e88..8ccdec7f8a 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_sse.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_sse.c
@@ -204,7 +204,7 @@ flex_rxd_to_fdir_flags_vec(const __m128i fdir_id0_3)
 	return fdir_flags;
 }
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 static inline void
 flex_desc_to_olflags_v(struct iavf_rx_queue *rxq, __m128i descs[4], __m128i descs_bh[4],
 		       struct rte_mbuf **rx_pkts)
@@ -325,7 +325,7 @@ flex_desc_to_olflags_v(struct iavf_rx_queue *rxq, __m128i descs[4],
 	/* merge the flags */
 	flags = _mm_or_si128(flags, rss_vlan);
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	if (rxq->rx_flags & IAVF_RX_FLAGS_VLAN_TAG_LOC_L2TAG2_2) {
 		const __m128i l2tag2_mask =
 			_mm_set1_epi32(1 << IAVF_RX_FLEX_DESC_STATUS1_L2TAG2P_S);
@@ -388,7 +388,7 @@ flex_desc_to_olflags_v(struct iavf_rx_queue *rxq, __m128i descs[4],
 			_mm_extract_epi32(fdir_id0_3, 3);
 	} /* if() on fdir_enabled */
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP)
 		flags = _mm_or_si128(flags, _mm_set1_epi32(iavf_timestamp_dynflag));
 #endif
@@ -724,7 +724,7 @@ _recv_raw_pkts_vec_flex_rxd(struct iavf_rx_queue *rxq,
 	int pos;
 	uint64_t var;
 	struct iavf_adapter *adapter = rxq->vsi->adapter;
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	uint64_t offloads = adapter->dev_data->dev_conf.rxmode.offloads;
 #endif
 	const uint32_t *ptype_tbl = adapter->ptype_tbl;
@@ -796,7 +796,7 @@ _recv_raw_pkts_vec_flex_rxd(struct iavf_rx_queue *rxq,
 	      rte_cpu_to_le_32(1 << IAVF_RX_FLEX_DESC_STATUS0_DD_S)))
 		return 0;
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	uint8_t inflection_point = 0;
 	bool is_tsinit = false;
 	__m128i hw_low_last = _mm_set_epi32(0, 0, 0, (uint32_t)rxq->phc_time);
@@ -845,7 +845,7 @@ _recv_raw_pkts_vec_flex_rxd(struct iavf_rx_queue *rxq,
 	     pos += IAVF_VPMD_DESCS_PER_LOOP,
 	     rxdp += IAVF_VPMD_DESCS_PER_LOOP) {
 		__m128i descs[IAVF_VPMD_DESCS_PER_LOOP];
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 		__m128i descs_bh[IAVF_VPMD_DESCS_PER_LOOP] = {_mm_setzero_si128()};
 #endif
 		__m128i pkt_mb0, pkt_mb1, pkt_mb2, pkt_mb3;
@@ -914,7 +914,7 @@ _recv_raw_pkts_vec_flex_rxd(struct iavf_rx_queue *rxq,
 		pkt_mb1 = _mm_add_epi16(pkt_mb1, crc_adjust);
 		pkt_mb0 = _mm_add_epi16(pkt_mb0, crc_adjust);
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 		/**
 		 * needs to load 2nd 16B of each desc,
 		 * will cause performance drop to get into this context.
@@ -1121,7 +1121,7 @@ _recv_raw_pkts_vec_flex_rxd(struct iavf_rx_queue *rxq,
 		var = rte_popcount64(_mm_cvtsi128_si64(staterr));
 		nb_pkts_recd += var;
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 		if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
 			inflection_point = (inflection_point <= var) ? inflection_point : 0;
 			switch (inflection_point) {
@@ -1157,7 +1157,7 @@ _recv_raw_pkts_vec_flex_rxd(struct iavf_rx_queue *rxq,
 			break;
 	}
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 #ifdef IAVF_RX_TS_OFFLOAD
 	if (nb_pkts_recd > 0 && (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP))
 		rxq->phc_time = *RTE_MBUF_DYNFIELD(rx_pkts[nb_pkts_recd - 1],
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 6feca8435e..da1ef5900f 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -1260,7 +1260,7 @@ iavf_configure_queues(struct iavf_adapter *adapter,
 		vc_qp->rxq.dma_ring_addr = rxq[i]->rx_ring_phys_addr;
 		vc_qp->rxq.databuffer_size = rxq[i]->rx_buf_len;
 		vc_qp->rxq.crc_disable = rxq[i]->crc_len != 0 ? 1 : 0;
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 		if (vf->vf_res->vf_cap_flags &
 		    VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC) {
 			if (vf->supported_rxdid & RTE_BIT64(rxq[i]->rxdid)) {
-- 
2.47.1

