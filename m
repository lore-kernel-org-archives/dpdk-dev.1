Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6078BC71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 11:12:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19D76410FA;
	Thu, 12 Jun 2025 13:12:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id A4F0940EE2
 for <dev@dpdk.org>; Thu, 12 Jun 2025 13:12:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749726729; x=1781262729;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=keaIKEHLB8ZrFiSpsOh2GGbdGE5rQBF24uMsFr5mjks=;
 b=EYo4v1WS631MLEKOC9mEdE+KChAYahqQKAZwN/C5iOapWsDo48jlToJn
 GGY57opF3kNmrnVU7vxoA3pQCoMK4K4z2UDgXUjmDc2cKdy01b408vf9z
 oFOqmlHCFv29CZ8cQTvaKJ1hc3lxXF1R9YlyLZgzWWkOo7l8pDqqSlZSS
 nWdvhIz/QnL/wNjm18N9LwQufJmPhDsA9DZnkdplgvHbEKT7JluV7j525
 OxqH99lURGopUJs8NnUrNCU2qeSCKwKpUfjw75Yzp1H2uYo6Ek2zb8xYJ
 jjQFJj71iEvKtWSqwU8qvfywf75GWcF4Xx/TDBY9dPqTCE4GENBesRjcJ Q==;
X-CSE-ConnectionGUID: K8zn3ZZdRLKLbwwGt75RCg==
X-CSE-MsgGUID: wF8cKd/USWK96mt752446Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62177543"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="62177543"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 04:12:09 -0700
X-CSE-ConnectionGUID: HPATMkYKRTyxtMNVK2FSGA==
X-CSE-MsgGUID: YZf6ex09R36/9SPN1Bj01w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="147371324"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jun 2025 04:12:07 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ian Stokes <ian.stokes@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v7 08/33] net/iavf: remove 16-byte descriptor define
Date: Thu, 12 Jun 2025 12:11:14 +0100
Message-ID: <c38641bd774ab89e1148e50802d3bb3b06f117a5.1749726639.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749726639.git.anatoly.burakov@intel.com>
 <cover.1749726639.git.anatoly.burakov@intel.com>
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

There are no physical functions that support having VF use 16-byte
descriptors, so remove all 16-byte descriptor related code from the driver.

Suggested-by: Bruce Richardson <bruce.richardson@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---

Notes:
    v4 -> v5:
    - Remove 16-byte descriptor related codepaths
    
    v3 -> v4:
    - Add this commit

 drivers/net/intel/iavf/iavf_rxtx.c            |  18 ---
 drivers/net/intel/iavf/iavf_rxtx.h            |  38 ------
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   |  11 --
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c |  10 --
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 124 ------------------
 drivers/net/intel/iavf/iavf_rxtx_vec_sse.c    |  25 ----
 drivers/net/intel/iavf/iavf_vchnl.c           |  14 --
 7 files changed, 240 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index d23d2df807..7b10c0314f 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -345,10 +345,8 @@ alloc_rxq_mbufs(struct iavf_rx_queue *rxq)
 		rxd = &rxq->rx_ring[i];
 		rxd->read.pkt_addr = dma_addr;
 		rxd->read.hdr_addr = 0;
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 		rxd->read.rsvd1 = 0;
 		rxd->read.rsvd2 = 0;
-#endif
 
 		rxq->sw_ring[i] = mbuf;
 	}
@@ -401,22 +399,18 @@ iavf_rxd_to_pkt_fields_by_comms_ovs(__rte_unused struct iavf_rx_queue *rxq,
 {
 	volatile struct iavf_32b_rx_flex_desc_comms_ovs *desc =
 			(volatile struct iavf_32b_rx_flex_desc_comms_ovs *)rxdp;
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 	uint16_t stat_err;
-#endif
 
 	if (desc->flow_id != 0xFFFFFFFF) {
 		mb->ol_flags |= RTE_MBUF_F_RX_FDIR | RTE_MBUF_F_RX_FDIR_ID;
 		mb->hash.fdir.hi = rte_le_to_cpu_32(desc->flow_id);
 	}
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 	stat_err = rte_le_to_cpu_16(desc->status_error0);
 	if (likely(stat_err & (1 << IAVF_RX_FLEX_DESC_STATUS0_RSS_VALID_S))) {
 		mb->ol_flags |= RTE_MBUF_F_RX_RSS_HASH;
 		mb->hash.rss = rte_le_to_cpu_32(desc->rss_hash);
 	}
-#endif
 }
 
 static inline void
@@ -434,7 +428,6 @@ iavf_rxd_to_pkt_fields_by_comms_aux_v1(struct iavf_rx_queue *rxq,
 		mb->hash.rss = rte_le_to_cpu_32(desc->rss_hash);
 	}
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 	if (desc->flow_id != 0xFFFFFFFF) {
 		mb->ol_flags |= RTE_MBUF_F_RX_FDIR | RTE_MBUF_F_RX_FDIR_ID;
 		mb->hash.fdir.hi = rte_le_to_cpu_32(desc->flow_id);
@@ -458,7 +451,6 @@ iavf_rxd_to_pkt_fields_by_comms_aux_v1(struct iavf_rx_queue *rxq,
 			*RTE_PMD_IFD_DYNF_PROTO_XTR_METADATA(mb) = metadata;
 		}
 	}
-#endif
 }
 
 static inline void
@@ -476,7 +468,6 @@ iavf_rxd_to_pkt_fields_by_comms_aux_v2(struct iavf_rx_queue *rxq,
 		mb->hash.rss = rte_le_to_cpu_32(desc->rss_hash);
 	}
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 	if (desc->flow_id != 0xFFFFFFFF) {
 		mb->ol_flags |= RTE_MBUF_F_RX_FDIR | RTE_MBUF_F_RX_FDIR_ID;
 		mb->hash.fdir.hi = rte_le_to_cpu_32(desc->flow_id);
@@ -496,7 +487,6 @@ iavf_rxd_to_pkt_fields_by_comms_aux_v2(struct iavf_rx_queue *rxq,
 			*RTE_PMD_IFD_DYNF_PROTO_XTR_METADATA(mb) = metadata;
 		}
 	}
-#endif
 }
 
 static const
@@ -1177,7 +1167,6 @@ iavf_flex_rxd_to_vlan_tci(struct rte_mbuf *mb,
 		mb->vlan_tci = 0;
 	}
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 	if (rte_le_to_cpu_16(rxdp->wb.status_error1) &
 	    (1 << IAVF_RX_FLEX_DESC_STATUS1_L2TAG2P_S)) {
 		mb->ol_flags |= RTE_MBUF_F_RX_QINQ_STRIPPED |
@@ -1192,7 +1181,6 @@ iavf_flex_rxd_to_vlan_tci(struct rte_mbuf *mb,
 	} else {
 		mb->vlan_tci_outer = 0;
 	}
-#endif
 }
 
 static inline void
@@ -1301,7 +1289,6 @@ static inline uint64_t
 iavf_rxd_build_fdir(volatile union iavf_rx_desc *rxdp, struct rte_mbuf *mb)
 {
 	uint64_t flags = 0;
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 	uint16_t flexbh;
 
 	flexbh = (rte_le_to_cpu_32(rxdp->wb.qword2.ext_status) >>
@@ -1313,11 +1300,6 @@ iavf_rxd_build_fdir(volatile union iavf_rx_desc *rxdp, struct rte_mbuf *mb)
 			rte_le_to_cpu_32(rxdp->wb.qword3.hi_dword.fd_id);
 		flags |= RTE_MBUF_F_RX_FDIR_ID;
 	}
-#else
-	mb->hash.fdir.hi =
-		rte_le_to_cpu_32(rxdp->wb.qword0.hi_dword.fd_id);
-	flags |= RTE_MBUF_F_RX_FDIR_ID;
-#endif
 	return flags;
 }
 
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 62b5a67c84..a0e1fd8667 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -126,30 +126,6 @@ extern int rte_pmd_iavf_tx_lldp_dynfield_offset;
  * Rx Flex Descriptors
  * These descriptors are used instead of the legacy version descriptors
  */
-union iavf_16b_rx_flex_desc {
-	struct {
-		__le64 pkt_addr; /* Packet buffer address */
-		__le64 hdr_addr; /* Header buffer address */
-				 /* bit 0 of hdr_addr is DD bit */
-	} read;
-	struct {
-		/* Qword 0 */
-		u8 rxdid; /* descriptor builder profile ID */
-		u8 mir_id_umb_cast; /* mirror=[5:0], umb=[7:6] */
-		__le16 ptype_flex_flags0; /* ptype=[9:0], ff0=[15:10] */
-		__le16 pkt_len; /* [15:14] are reserved */
-		__le16 hdr_len_sph_flex_flags1; /* header=[10:0] */
-						/* sph=[11:11] */
-						/* ff1/ext=[15:12] */
-
-		/* Qword 1 */
-		__le16 status_error0;
-		__le16 l2tag1;
-		__le16 flex_meta0;
-		__le16 flex_meta1;
-	} wb; /* writeback */
-};
-
 union iavf_32b_rx_flex_desc {
 	struct {
 		__le64 pkt_addr; /* Packet buffer address */
@@ -194,14 +170,8 @@ union iavf_32b_rx_flex_desc {
 	} wb; /* writeback */
 };
 
-/* HW desc structure, both 16-byte and 32-byte types are supported */
-#ifdef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
-#define iavf_rx_desc iavf_16byte_rx_desc
-#define iavf_rx_flex_desc iavf_16b_rx_flex_desc
-#else
 #define iavf_rx_desc iavf_32byte_rx_desc
 #define iavf_rx_flex_desc iavf_32b_rx_flex_desc
-#endif
 
 typedef void (*iavf_rxd_to_pkt_fields_t)(struct iavf_rx_queue *rxq,
 				struct rte_mbuf *mb,
@@ -740,20 +710,12 @@ void iavf_dump_rx_descriptor(struct iavf_rx_queue *rxq,
 			    const volatile void *desc,
 			    uint16_t rx_id)
 {
-#ifdef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
-	const volatile union iavf_16byte_rx_desc *rx_desc = desc;
-
-	printf("Queue %d Rx_desc %d: QW0: 0x%016"PRIx64" QW1: 0x%016"PRIx64"\n",
-	       rxq->queue_id, rx_id, rx_desc->read.pkt_addr,
-	       rx_desc->read.hdr_addr);
-#else
 	const volatile union iavf_32byte_rx_desc *rx_desc = desc;
 
 	printf("Queue %d Rx_desc %d: QW0: 0x%016"PRIx64" QW1: 0x%016"PRIx64
 	       " QW2: 0x%016"PRIx64" QW3: 0x%016"PRIx64"\n", rxq->queue_id,
 	       rx_id, rx_desc->read.pkt_addr, rx_desc->read.hdr_addr,
 	       rx_desc->read.rsvd1, rx_desc->read.rsvd2);
-#endif
 }
 
 /* All the descriptors are 16 bytes, so just use one of them
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index 88e35dc3e9..c7dc5bbe3e 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -495,10 +495,7 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct iavf_rx_queue *rxq,
 #define IAVF_DESCS_PER_LOOP_AVX 8
 
 	struct iavf_adapter *adapter = rxq->vsi->adapter;
-
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 	uint64_t offloads = adapter->dev_data->dev_conf.rxmode.offloads;
-#endif
 	const uint32_t *type_table = adapter->ptype_tbl;
 
 	const __m256i mbuf_init = _mm256_set_epi64x(0, 0,
@@ -524,7 +521,6 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct iavf_rx_queue *rxq,
 	if (!(rxdp->wb.status_error0 &
 			rte_cpu_to_le_32(1 << IAVF_RX_FLEX_DESC_STATUS0_DD_S)))
 		return 0;
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 	bool is_tsinit = false;
 	uint8_t inflection_point = 0;
 	__m256i hw_low_last = _mm256_set_epi32(0, 0, 0, 0, 0, 0, 0, rxq->phc_time);
@@ -538,7 +534,6 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct iavf_rx_queue *rxq,
 			hw_low_last = _mm256_set_epi32(0, 0, 0, 0, 0, 0, 0, rxq->phc_time);
 		}
 	}
-#endif
 
 	/* constants used in processing loop */
 	const __m256i crc_adjust =
@@ -946,7 +941,6 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct iavf_rx_queue *rxq,
 		} /* if() on fdir_enabled */
 
 		if (offload) {
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 			/**
 			 * needs to load 2nd 16B of each desc,
 			 * will cause performance drop to get into this context.
@@ -1229,7 +1223,6 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct iavf_rx_queue *rxq,
 					mbuf_flags = _mm256_or_si256(mbuf_flags, _mm256_set1_epi32(iavf_timestamp_dynflag));
 				} /* if() on Timestamp parsing */
 			}
-#endif
 		}
 
 		/**
@@ -1360,7 +1353,6 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct iavf_rx_queue *rxq,
 				(_mm_cvtsi128_si64
 					(_mm256_castsi256_si128(status0_7)));
 		received += burst;
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 		if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
 			inflection_point = (inflection_point <= burst) ? inflection_point : 0;
 			switch (inflection_point) {
@@ -1406,15 +1398,12 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct iavf_rx_queue *rxq,
 
 			rxq->hw_time_update = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
 		}
-#endif
 		if (burst != IAVF_DESCS_PER_LOOP_AVX)
 			break;
 	}
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 	if (received > 0 && (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP))
 		rxq->phc_time = *RTE_MBUF_DYNFIELD(rx_pkts[received - 1], iavf_timestamp_dynfield_offset, rte_mbuf_timestamp_t *);
-#endif
 
 	/* update tail pointers */
 	rxq->rx_tail += received;
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index f2af028bef..51a2dc12bf 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -585,9 +585,7 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct iavf_rx_queue *rxq,
 					bool offload)
 {
 	struct iavf_adapter *adapter = rxq->vsi->adapter;
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 	uint64_t offloads = adapter->dev_data->dev_conf.rxmode.offloads;
-#endif
 #ifdef IAVF_RX_PTYPE_OFFLOAD
 	const uint32_t *type_table = adapter->ptype_tbl;
 #endif
@@ -616,7 +614,6 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct iavf_rx_queue *rxq,
 	      rte_cpu_to_le_32(1 << IAVF_RX_FLEX_DESC_STATUS0_DD_S)))
 		return 0;
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 #ifdef IAVF_RX_TS_OFFLOAD
 	uint8_t inflection_point = 0;
 	bool is_tsinit = false;
@@ -632,7 +629,6 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct iavf_rx_queue *rxq,
 			hw_low_last = _mm256_set_epi32(0, 0, 0, 0, 0, 0, 0, (uint32_t)rxq->phc_time);
 		}
 	}
-#endif
 #endif
 
 	/* constants used in processing loop */
@@ -1096,7 +1092,6 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct iavf_rx_queue *rxq,
 		__m256i mb0_1 = _mm512_extracti64x4_epi64(mb0_3, 0);
 		__m256i mb2_3 = _mm512_extracti64x4_epi64(mb0_3, 1);
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 		if (offload) {
 #if defined(IAVF_RX_RSS_OFFLOAD) || defined(IAVF_RX_TS_OFFLOAD)
 			/**
@@ -1418,7 +1413,6 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct iavf_rx_queue *rxq,
 			} /* if() on RSS hash or RX timestamp parsing */
 #endif
 		}
-#endif
 
 		/**
 		 * At this point, we have the 8 sets of flags in the low 16-bits
@@ -1548,7 +1542,6 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct iavf_rx_queue *rxq,
 				(_mm_cvtsi128_si64
 					(_mm256_castsi256_si128(status0_7)));
 		received += burst;
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 #ifdef IAVF_RX_TS_OFFLOAD
 		if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
 			inflection_point = (inflection_point <= burst) ? inflection_point : 0;
@@ -1595,18 +1588,15 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct iavf_rx_queue *rxq,
 
 			rxq->hw_time_update = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
 		}
-#endif
 #endif
 		if (burst != IAVF_DESCS_PER_LOOP_AVX)
 			break;
 	}
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 #ifdef IAVF_RX_TS_OFFLOAD
 	if (received > 0 && (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP))
 		rxq->phc_time = *RTE_MBUF_DYNFIELD(rx_pkts[received - 1],
 			iavf_timestamp_dynfield_offset, rte_mbuf_timestamp_t *);
-#endif
 #endif
 
 	/* update tail pointers */
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
index 38e9a206d9..326b8b07ba 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
@@ -269,7 +269,6 @@ iavf_rxq_rearm_common(struct iavf_rx_queue *rxq, __rte_unused bool avx512)
 		return;
 	}
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 	struct rte_mbuf *mb0, *mb1;
 	__m128i dma_addr0, dma_addr1;
 	__m128i hdr_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
@@ -299,129 +298,6 @@ iavf_rxq_rearm_common(struct iavf_rx_queue *rxq, __rte_unused bool avx512)
 		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp++->read), dma_addr0);
 		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp++->read), dma_addr1);
 	}
-#else
-#ifdef CC_AVX512_SUPPORT
-	if (avx512) {
-		struct rte_mbuf *mb0, *mb1, *mb2, *mb3;
-		struct rte_mbuf *mb4, *mb5, *mb6, *mb7;
-		__m512i dma_addr0_3, dma_addr4_7;
-		__m512i hdr_room = _mm512_set1_epi64(RTE_PKTMBUF_HEADROOM);
-		/* Initialize the mbufs in vector, process 8 mbufs in one loop */
-		for (i = 0; i < IAVF_RXQ_REARM_THRESH;
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
-		for (i = 0; i < IAVF_RXQ_REARM_THRESH;
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
 
 	rxq->rxrearm_start += IAVF_RXQ_REARM_THRESH;
 	if (rxq->rxrearm_start >= rxq->nb_rx_desc)
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_sse.c b/drivers/net/intel/iavf/iavf_rxtx_vec_sse.c
index 2e41079e88..9c1f8276d0 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_sse.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_sse.c
@@ -204,15 +204,9 @@ flex_rxd_to_fdir_flags_vec(const __m128i fdir_id0_3)
 	return fdir_flags;
 }
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 static inline void
 flex_desc_to_olflags_v(struct iavf_rx_queue *rxq, __m128i descs[4], __m128i descs_bh[4],
 		       struct rte_mbuf **rx_pkts)
-#else
-static inline void
-flex_desc_to_olflags_v(struct iavf_rx_queue *rxq, __m128i descs[4],
-		       struct rte_mbuf **rx_pkts)
-#endif
 {
 	const __m128i mbuf_init = _mm_set_epi64x(0, rxq->mbuf_initializer);
 	__m128i rearm0, rearm1, rearm2, rearm3;
@@ -325,7 +319,6 @@ flex_desc_to_olflags_v(struct iavf_rx_queue *rxq, __m128i descs[4],
 	/* merge the flags */
 	flags = _mm_or_si128(flags, rss_vlan);
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 	if (rxq->rx_flags & IAVF_RX_FLAGS_VLAN_TAG_LOC_L2TAG2_2) {
 		const __m128i l2tag2_mask =
 			_mm_set1_epi32(1 << IAVF_RX_FLEX_DESC_STATUS1_L2TAG2P_S);
@@ -356,7 +349,6 @@ flex_desc_to_olflags_v(struct iavf_rx_queue *rxq, __m128i descs[4],
 		/* merge with vlan_flags */
 		flags = _mm_or_si128(flags, vlan_flags);
 	}
-#endif
 
 	if (rxq->fdir_enabled) {
 		const __m128i fdir_id0_1 =
@@ -388,10 +380,8 @@ flex_desc_to_olflags_v(struct iavf_rx_queue *rxq, __m128i descs[4],
 			_mm_extract_epi32(fdir_id0_3, 3);
 	} /* if() on fdir_enabled */
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP)
 		flags = _mm_or_si128(flags, _mm_set1_epi32(iavf_timestamp_dynflag));
-#endif
 
 	/**
 	 * At this point, we have the 4 sets of flags in the low 16-bits
@@ -724,9 +714,7 @@ _recv_raw_pkts_vec_flex_rxd(struct iavf_rx_queue *rxq,
 	int pos;
 	uint64_t var;
 	struct iavf_adapter *adapter = rxq->vsi->adapter;
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 	uint64_t offloads = adapter->dev_data->dev_conf.rxmode.offloads;
-#endif
 	const uint32_t *ptype_tbl = adapter->ptype_tbl;
 	__m128i crc_adjust = _mm_set_epi16
 				(0, 0, 0,       /* ignore non-length fields */
@@ -796,7 +784,6 @@ _recv_raw_pkts_vec_flex_rxd(struct iavf_rx_queue *rxq,
 	      rte_cpu_to_le_32(1 << IAVF_RX_FLEX_DESC_STATUS0_DD_S)))
 		return 0;
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 	uint8_t inflection_point = 0;
 	bool is_tsinit = false;
 	__m128i hw_low_last = _mm_set_epi32(0, 0, 0, (uint32_t)rxq->phc_time);
@@ -812,8 +799,6 @@ _recv_raw_pkts_vec_flex_rxd(struct iavf_rx_queue *rxq,
 		}
 	}
 
-#endif
-
 	/**
 	 * Compile-time verify the shuffle mask
 	 * NOTE: some field positions already verified above, but duplicated
@@ -845,9 +830,7 @@ _recv_raw_pkts_vec_flex_rxd(struct iavf_rx_queue *rxq,
 	     pos += IAVF_VPMD_DESCS_PER_LOOP,
 	     rxdp += IAVF_VPMD_DESCS_PER_LOOP) {
 		__m128i descs[IAVF_VPMD_DESCS_PER_LOOP];
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 		__m128i descs_bh[IAVF_VPMD_DESCS_PER_LOOP] = {_mm_setzero_si128()};
-#endif
 		__m128i pkt_mb0, pkt_mb1, pkt_mb2, pkt_mb3;
 		__m128i staterr, sterr_tmp1, sterr_tmp2;
 		/* 2 64 bit or 4 32 bit mbuf pointers in one XMM reg. */
@@ -914,7 +897,6 @@ _recv_raw_pkts_vec_flex_rxd(struct iavf_rx_queue *rxq,
 		pkt_mb1 = _mm_add_epi16(pkt_mb1, crc_adjust);
 		pkt_mb0 = _mm_add_epi16(pkt_mb0, crc_adjust);
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 		/**
 		 * needs to load 2nd 16B of each desc,
 		 * will cause performance drop to get into this context.
@@ -1076,9 +1058,6 @@ _recv_raw_pkts_vec_flex_rxd(struct iavf_rx_queue *rxq,
 		} /* if() on Timestamp parsing */
 
 		flex_desc_to_olflags_v(rxq, descs, descs_bh, &rx_pkts[pos]);
-#else
-		flex_desc_to_olflags_v(rxq, descs, &rx_pkts[pos]);
-#endif
 
 		/* C.2 get 4 pkts staterr value  */
 		staterr = _mm_unpacklo_epi32(sterr_tmp1, sterr_tmp2);
@@ -1121,7 +1100,6 @@ _recv_raw_pkts_vec_flex_rxd(struct iavf_rx_queue *rxq,
 		var = rte_popcount64(_mm_cvtsi128_si64(staterr));
 		nb_pkts_recd += var;
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 		if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
 			inflection_point = (inflection_point <= var) ? inflection_point : 0;
 			switch (inflection_point) {
@@ -1151,18 +1129,15 @@ _recv_raw_pkts_vec_flex_rxd(struct iavf_rx_queue *rxq,
 
 			rxq->hw_time_update = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
 		}
-#endif
 
 		if (likely(var != IAVF_VPMD_DESCS_PER_LOOP))
 			break;
 	}
 
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 #ifdef IAVF_RX_TS_OFFLOAD
 	if (nb_pkts_recd > 0 && (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP))
 		rxq->phc_time = *RTE_MBUF_DYNFIELD(rx_pkts[nb_pkts_recd - 1],
 						iavf_timestamp_dynfield_offset, uint32_t *);
-#endif
 #endif
 
 	/* Update our internal tail pointer */
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 6feca8435e..2302d2bcf1 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -1260,7 +1260,6 @@ iavf_configure_queues(struct iavf_adapter *adapter,
 		vc_qp->rxq.dma_ring_addr = rxq[i]->rx_ring_phys_addr;
 		vc_qp->rxq.databuffer_size = rxq[i]->rx_buf_len;
 		vc_qp->rxq.crc_disable = rxq[i]->crc_len != 0 ? 1 : 0;
-#ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 		if (vf->vf_res->vf_cap_flags &
 		    VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC) {
 			if (vf->supported_rxdid & RTE_BIT64(rxq[i]->rxdid)) {
@@ -1279,19 +1278,6 @@ iavf_configure_queues(struct iavf_adapter *adapter,
 			    rxq[i]->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP)
 				vc_qp->rxq.flags |= VIRTCHNL_PTP_RX_TSTAMP;
 		}
-#else
-		if (vf->vf_res->vf_cap_flags &
-			VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC &&
-			vf->supported_rxdid & BIT(IAVF_RXDID_LEGACY_0)) {
-			vc_qp->rxq.rxdid = IAVF_RXDID_LEGACY_0;
-			PMD_DRV_LOG(NOTICE, "request RXDID[%d] in Queue[%d]",
-				    vc_qp->rxq.rxdid, i);
-		} else {
-			PMD_DRV_LOG(ERR, "RXDID[%d] is not supported",
-				    IAVF_RXDID_LEGACY_0);
-			return -1;
-		}
-#endif
 	}
 
 	memset(&args, 0, sizeof(args));
-- 
2.47.1

