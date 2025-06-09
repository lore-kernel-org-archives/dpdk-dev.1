Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D37EC61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 15:38:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22C0B42707;
	Mon,  9 Jun 2025 17:38:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 3D4F542709
 for <dev@dpdk.org>; Mon,  9 Jun 2025 17:37:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749483479; x=1781019479;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=wtIG0noST226Jd94jK7Nmar74R5oIVzAHc/Ap0nS5uQ=;
 b=aT8IHxpU5Dq1QgQB9o0HiFEubZOJEYFymxOw6gQrgT8Yv62EWh9mtpEB
 mLRPfVQkSDj0y8U99yOkHiMa6GWx2Zb3+oqR5ZYqErH/5oOGSHTI9nJYO
 plWc5SWDv02recE5feI8GfFI6c4/b9RbweTL7cggJEEl5SIZ449y6dhxy
 grrMW35shk1Yb8kLgAhsu7CxD1wY50X27+/BTLRp8xERW8xrScXMLnpen
 qhX/KzWo7lTEmL9ICh+s5f6vLEda2j/IJr55+Gu4J/f2ed+0dGtMa1q8U
 a69AOndOg+QSYeziT9qzStwXh2I4F9yLTprGFnKS35hcDnnvKXV5imKxT A==;
X-CSE-ConnectionGUID: vrTgOtmNQ1Ow3zCqZrc0aw==
X-CSE-MsgGUID: AYZNsHFWT0qBjVYUdbGNlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="69012150"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="69012150"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 08:37:58 -0700
X-CSE-ConnectionGUID: +4bObQWlRl2Gwz+LDxxumA==
X-CSE-MsgGUID: hbZbwM8CRiu7UwQW/GRxDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="151419599"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa005.fm.intel.com with ESMTP; 09 Jun 2025 08:37:56 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 07/33] net/ice: rename 16-byte descriptor define
Date: Mon,  9 Jun 2025 16:37:05 +0100
Message-ID: <9bd75a32af442afc3961f16b4124aa7a43804e5a.1749483382.git.anatoly.burakov@intel.com>
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

In preparation for having a common definition for 16-byte and 32-byte Rx
descriptors, rename RTE_LIBRTE_ICE_16BYTE_RX_DESC to
RTE_NET_INTEL_USE_16BYTE_DESC.

Suggested-by: Bruce Richardson <bruce.richardson@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---

Notes:
    v3 -> v4:
    - Add this commit

 drivers/net/intel/ice/ice_dcf.c             |  2 +-
 drivers/net/intel/ice/ice_dcf_ethdev.c      |  2 +-
 drivers/net/intel/ice/ice_rxtx.c            | 30 ++++++++++-----------
 drivers/net/intel/ice/ice_rxtx.h            |  2 +-
 drivers/net/intel/ice/ice_rxtx_common_avx.h |  2 +-
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c   |  2 +-
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c |  2 +-
 drivers/net/intel/ice/ice_rxtx_vec_sse.c    |  2 +-
 8 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/net/intel/ice/ice_dcf.c b/drivers/net/intel/ice/ice_dcf.c
index fa95aaaba6..2f7c239491 100644
--- a/drivers/net/intel/ice/ice_dcf.c
+++ b/drivers/net/intel/ice/ice_dcf.c
@@ -1214,7 +1214,7 @@ ice_dcf_configure_queues(struct ice_dcf_hw *hw)
 		vc_qp->rxq.dma_ring_addr = rxq[i]->rx_ring_phys_addr;
 		vc_qp->rxq.databuffer_size = rxq[i]->rx_buf_len;
 
-#ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 		if (hw->vf_res->vf_cap_flags &
 		    VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC &&
 		    hw->supported_rxdid &
diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice/ice_dcf_ethdev.c
index efff76afa8..d3fd5d7122 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
@@ -308,7 +308,7 @@ alloc_rxq_mbufs(struct ice_rx_queue *rxq)
 		rxd = &rxq->rx_ring[i];
 		rxd->read.pkt_addr = dma_addr;
 		rxd->read.hdr_addr = 0;
-#ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 		rxd->read.rsvd1 = 0;
 		rxd->read.rsvd2 = 0;
 #endif
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 81962a1f9a..19569b6a38 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -86,7 +86,7 @@ ice_rxd_to_pkt_fields_by_comms_generic(__rte_unused struct ice_rx_queue *rxq,
 		mb->hash.rss = rte_le_to_cpu_32(desc->rss_hash);
 	}
 
-#ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	if (desc->flow_id != 0xFFFFFFFF) {
 		mb->ol_flags |= RTE_MBUF_F_RX_FDIR | RTE_MBUF_F_RX_FDIR_ID;
 		mb->hash.fdir.hi = rte_le_to_cpu_32(desc->flow_id);
@@ -101,7 +101,7 @@ ice_rxd_to_pkt_fields_by_comms_ovs(__rte_unused struct ice_rx_queue *rxq,
 {
 	volatile struct ice_32b_rx_flex_desc_comms_ovs *desc =
 			(volatile struct ice_32b_rx_flex_desc_comms_ovs *)rxdp;
-#ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	uint16_t stat_err;
 #endif
 
@@ -110,7 +110,7 @@ ice_rxd_to_pkt_fields_by_comms_ovs(__rte_unused struct ice_rx_queue *rxq,
 		mb->hash.fdir.hi = rte_le_to_cpu_32(desc->flow_id);
 	}
 
-#ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	stat_err = rte_le_to_cpu_16(desc->status_error0);
 	if (likely(stat_err & (1 << ICE_RX_FLEX_DESC_STATUS0_RSS_VALID_S))) {
 		mb->ol_flags |= RTE_MBUF_F_RX_RSS_HASH;
@@ -134,7 +134,7 @@ ice_rxd_to_pkt_fields_by_comms_aux_v1(struct ice_rx_queue *rxq,
 		mb->hash.rss = rte_le_to_cpu_32(desc->rss_hash);
 	}
 
-#ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	if (desc->flow_id != 0xFFFFFFFF) {
 		mb->ol_flags |= RTE_MBUF_F_RX_FDIR | RTE_MBUF_F_RX_FDIR_ID;
 		mb->hash.fdir.hi = rte_le_to_cpu_32(desc->flow_id);
@@ -178,7 +178,7 @@ ice_rxd_to_pkt_fields_by_comms_aux_v2(struct ice_rx_queue *rxq,
 		mb->hash.rss = rte_le_to_cpu_32(desc->rss_hash);
 	}
 
-#ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	if (desc->flow_id != 0xFFFFFFFF) {
 		mb->ol_flags |= RTE_MBUF_F_RX_FDIR | RTE_MBUF_F_RX_FDIR_ID;
 		mb->hash.fdir.hi = rte_le_to_cpu_32(desc->flow_id);
@@ -374,7 +374,7 @@ ice_program_hw_rx_queue(struct ice_rx_queue *rxq)
 	rx_ctx.qlen = rxq->nb_rx_desc;
 	rx_ctx.dbuf = rxq->rx_buf_len >> ICE_RLAN_CTX_DBUF_S;
 	rx_ctx.hbuf = rxq->rx_hdr_len >> ICE_RLAN_CTX_HBUF_S;
-#ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	rx_ctx.dsize = 1; /* 32B descriptors */
 #endif
 	rx_ctx.rxmax = rxq->max_pkt_len;
@@ -501,7 +501,7 @@ ice_alloc_rx_queue_mbufs(struct ice_rx_queue *rxq)
 			rxd->read.pkt_addr = rte_cpu_to_le_64(rte_mbuf_data_iova_default(mbuf_pay));
 		}
 
-#ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 		rxd->read.rsvd1 = 0;
 		rxd->read.rsvd2 = 0;
 #endif
@@ -1668,7 +1668,7 @@ ice_rxd_to_vlan_tci(struct rte_mbuf *mb, volatile union ice_rx_flex_desc *rxdp)
 		mb->vlan_tci = 0;
 	}
 
-#ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	if (rte_le_to_cpu_16(rxdp->wb.status_error1) &
 	    (1 << ICE_RX_FLEX_DESC_STATUS1_L2TAG2P_S)) {
 		mb->ol_flags |= RTE_MBUF_F_RX_QINQ_STRIPPED | RTE_MBUF_F_RX_QINQ |
@@ -1705,7 +1705,7 @@ ice_rx_scan_hw_ring(struct ice_rx_queue *rxq)
 	int32_t i, j, nb_rx = 0;
 	uint64_t pkt_flags = 0;
 	uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
-#ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	bool is_tsinit = false;
 	uint64_t ts_ns;
 	struct ice_vsi *vsi = rxq->vsi;
@@ -1721,7 +1721,7 @@ ice_rx_scan_hw_ring(struct ice_rx_queue *rxq)
 	if (!(stat_err0 & (1 << ICE_RX_FLEX_DESC_STATUS0_DD_S)))
 		return 0;
 
-#ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
 		uint64_t sw_cur_time = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
 
@@ -1783,7 +1783,7 @@ ice_rx_scan_hw_ring(struct ice_rx_queue *rxq)
 				rte_le_to_cpu_16(rxdp[j].wb.ptype_flex_flags0)];
 			ice_rxd_to_vlan_tci(mb, &rxdp[j]);
 			rxd_to_pkt_fields_ops[rxq->rxdid](rxq, mb, &rxdp[j]);
-#ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 			if (rxq->ts_flag > 0 &&
 			    (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP)) {
 				rxq->time_high =
@@ -2023,7 +2023,7 @@ ice_recv_scattered_pkts(void *rx_queue,
 	uint64_t dma_addr;
 	uint64_t pkt_flags;
 	uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
-#ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	bool is_tsinit = false;
 	uint64_t ts_ns;
 	struct ice_vsi *vsi = rxq->vsi;
@@ -2151,7 +2151,7 @@ ice_recv_scattered_pkts(void *rx_queue,
 		ice_rxd_to_vlan_tci(first_seg, &rxd);
 		rxd_to_pkt_fields_ops[rxq->rxdid](rxq, first_seg, &rxd);
 		pkt_flags = ice_rxd_error_to_pkt_flags(rx_stat_err0);
-#ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 		if (rxq->ts_flag > 0 &&
 		    (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP)) {
 			rxq->time_high =
@@ -2540,7 +2540,7 @@ ice_recv_pkts(void *rx_queue,
 	uint64_t dma_addr;
 	uint64_t pkt_flags;
 	uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
-#ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	bool is_tsinit = false;
 	uint64_t ts_ns;
 	struct ice_vsi *vsi = rxq->vsi;
@@ -2649,7 +2649,7 @@ ice_recv_pkts(void *rx_queue,
 		ice_rxd_to_vlan_tci(rxm, &rxd);
 		rxd_to_pkt_fields_ops[rxq->rxdid](rxq, rxm, &rxd);
 		pkt_flags = ice_rxd_error_to_pkt_flags(rx_stat_err0);
-#ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 		if (rxq->ts_flag > 0 &&
 		    (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP)) {
 			rxq->time_high =
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index 3c5c014b41..d2d521c4f5 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -23,7 +23,7 @@
 #define ICE_CHK_Q_ENA_COUNT        100
 #define ICE_CHK_Q_ENA_INTERVAL_US  100
 
-#ifdef RTE_LIBRTE_ICE_16BYTE_RX_DESC
+#ifdef RTE_NET_INTEL_USE_16BYTE_DESC
 #define ice_rx_flex_desc ice_16b_rx_flex_desc
 #else
 #define ice_rx_flex_desc ice_32b_rx_flex_desc
diff --git a/drivers/net/intel/ice/ice_rxtx_common_avx.h b/drivers/net/intel/ice/ice_rxtx_common_avx.h
index c62e60c70e..a68cf8512d 100644
--- a/drivers/net/intel/ice/ice_rxtx_common_avx.h
+++ b/drivers/net/intel/ice/ice_rxtx_common_avx.h
@@ -38,7 +38,7 @@ ice_rxq_rearm_common(struct ice_rx_queue *rxq, __rte_unused bool avx512)
 		return;
 	}
 
-#ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	struct rte_mbuf *mb0, *mb1;
 	__m128i dma_addr0, dma_addr1;
 	__m128i hdr_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
index 0c54b325c6..6fe5ffa6f4 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
@@ -440,7 +440,7 @@ _ice_recv_raw_pkts_vec_avx2(struct ice_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		} /* if() on fdir_enabled */
 
 		if (offload) {
-#ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 			/**
 			 * needs to load 2nd 16B of each desc for RSS hash parsing,
 			 * will cause performance drop to get into this context.
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
index bd49be07c9..490d1ae059 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
@@ -462,7 +462,7 @@ _ice_recv_raw_pkts_vec_avx512(struct ice_rx_queue *rxq,
 		} /* if() on fdir_enabled */
 
 		if (do_offload) {
-#ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 			/**
 			 * needs to load 2nd 16B of each desc for RSS hash parsing,
 			 * will cause performance drop to get into this context.
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_sse.c b/drivers/net/intel/ice/ice_rxtx_vec_sse.c
index 97f05ba45e..719b37645e 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_sse.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_sse.c
@@ -477,7 +477,7 @@ _ice_recv_raw_pkts_vec(struct ice_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		pkt_mb1 = _mm_add_epi16(pkt_mb1, crc_adjust);
 		pkt_mb0 = _mm_add_epi16(pkt_mb0, crc_adjust);
 
-#ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 		/**
 		 * needs to load 2nd 16B of each desc for RSS hash parsing,
 		 * will cause performance drop to get into this context.
-- 
2.47.1

