Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6123EEF4EC8
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Apr 2026 08:51:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E86F94065A;
	Mon,  6 Apr 2026 10:51:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id D411C40265
 for <dev@dpdk.org>; Mon,  6 Apr 2026 10:51:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775465464; x=1807001464;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=2WWDMWnhXazGO7Jsbi4L+rB/YApWD9gyZ80vB+3r0So=;
 b=Wsc2mELW7rCZm5l/Aw6dkWk1t5P3Tc0q3MLYpLyWVOimBSy/Ci4MdCPp
 Bfm9qhslvXVs5HKzEMq/l1g+GHJYYcHx8LjMaDw6x12QDpRikaF2V+43N
 SsUHWz4Y8sfDAsgSc+vswpPVwkKZK0sJwK1N6WKx4puNnvlZAHMQTuJyS
 c3VQ4VW6d+IqmiDVtb5BbUsBKMf/shbSdYuHBwcI+4Zh2LJd1qJmdJ48u
 V0UpZ+4xq8WRVdR2hWPXvDtdDN5CEaVZdGOXG06StfeW4bzAiHrWR+39A
 j7E/WGxHw3drapR+fhdgdo/ewexmaeMkCvZA08DyD6LSp8IB7rBQky0HS w==;
X-CSE-ConnectionGUID: jDi8hcNzRserDhbAprvk0g==
X-CSE-MsgGUID: qF3nlp9lRb+FdFLyFmUVXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11750"; a="76133629"
X-IronPort-AV: E=Sophos;i="6.23,163,1770624000"; d="scan'208";a="76133629"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2026 01:51:03 -0700
X-CSE-ConnectionGUID: qIrW/J1lQ2Wo8SxLXHQNgA==
X-CSE-MsgGUID: W5jqLJfGRHGTP73WGPnFcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,163,1770624000"; d="scan'208";a="227732491"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa009.jf.intel.com with ESMTP; 06 Apr 2026 01:51:00 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org, rajesh3.kumar@intel.com
Subject: [PATCH v3 1/2] net/iavf: remove PHC polling from Rx datapath
Date: Mon,  6 Apr 2026 17:22:07 -0400
Message-ID: <20260406212208.1562899-2-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260406212208.1562899-1-soumyadeep.hore@intel.com>
References: <20260402154655.1540930-2-soumyadeep.hore@intel.com>
 <20260406212208.1562899-1-soumyadeep.hore@intel.com>
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

Remove periodic PHC read/update checks from scalar and vector flex
RX paths, keeping timestamp conversion based on queue PHC state.

This avoids hot-path PHC polling overhead and preserves the latency
fix for RX timestamp-enabled traffic.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx.c            | 34 -------------------
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   | 24 ++-----------
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 26 ++------------
 3 files changed, 6 insertions(+), 78 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 4ff6c18dc4..fabccc89bf 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -1507,16 +1507,6 @@ iavf_recv_pkts_flex_rxd(void *rx_queue,
 	rx_ring = rxq->rx_flex_ring;
 	ptype_tbl = rxq->iavf_vsi->adapter->ptype_tbl;
 
-	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
-		uint64_t sw_cur_time = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
-
-		if (sw_cur_time - rxq->hw_time_update > 4) {
-			if (iavf_get_phc_time(rxq))
-				PMD_DRV_LOG(ERR, "get physical time failed");
-			rxq->hw_time_update = sw_cur_time;
-		}
-	}
-
 	while (nb_rx < nb_pkts) {
 		rxdp = &rx_ring[rx_id];
 		rx_stat_err0 = rte_le_to_cpu_16(rxdp->wb.status_error0);
@@ -1585,7 +1575,6 @@ iavf_recv_pkts_flex_rxd(void *rx_queue,
 				rte_le_to_cpu_32(rxd.wb.flex_ts.ts_high));
 
 			rxq->phc_time = ts_ns;
-			rxq->hw_time_update = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
 
 			*RTE_MBUF_DYNFIELD(rxm,
 				iavf_timestamp_dynfield_offset,
@@ -1627,16 +1616,6 @@ iavf_recv_scattered_pkts_flex_rxd(void *rx_queue, struct rte_mbuf **rx_pkts,
 	volatile union ci_rx_flex_desc *rxdp;
 	const uint32_t *ptype_tbl = rxq->iavf_vsi->adapter->ptype_tbl;
 
-	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
-		uint64_t sw_cur_time = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
-
-		if (sw_cur_time - rxq->hw_time_update > 4) {
-			if (iavf_get_phc_time(rxq))
-				PMD_DRV_LOG(ERR, "get physical time failed");
-			rxq->hw_time_update = sw_cur_time;
-		}
-	}
-
 	while (nb_rx < nb_pkts) {
 		rxdp = &rx_ring[rx_id];
 		rx_stat_err0 = rte_le_to_cpu_16(rxdp->wb.status_error0);
@@ -1755,7 +1734,6 @@ iavf_recv_scattered_pkts_flex_rxd(void *rx_queue, struct rte_mbuf **rx_pkts,
 				rte_le_to_cpu_32(rxd.wb.flex_ts.ts_high));
 
 			rxq->phc_time = ts_ns;
-			rxq->hw_time_update = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
 
 			*RTE_MBUF_DYNFIELD(first_seg,
 				iavf_timestamp_dynfield_offset,
@@ -1969,16 +1947,6 @@ iavf_rx_scan_hw_ring_flex_rxd(struct ci_rx_queue *rxq,
 	if (!(stat_err0 & (1 << IAVF_RX_FLEX_DESC_STATUS0_DD_S)))
 		return 0;
 
-	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
-		uint64_t sw_cur_time = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
-
-		if (sw_cur_time - rxq->hw_time_update > 4) {
-			if (iavf_get_phc_time(rxq))
-				PMD_DRV_LOG(ERR, "get physical time failed");
-			rxq->hw_time_update = sw_cur_time;
-		}
-	}
-
 	/* Scan LOOK_AHEAD descriptors at a time to determine which
 	 * descriptors reference packets that are ready to be received.
 	 */
@@ -2041,8 +2009,6 @@ iavf_rx_scan_hw_ring_flex_rxd(struct ci_rx_queue *rxq,
 					rte_le_to_cpu_32(rxdp[j].wb.flex_ts.ts_high));
 
 				rxq->phc_time = ts_ns;
-				rxq->hw_time_update = rte_get_timer_cycles() /
-					(rte_get_timer_hz() / 1000);
 
 				*RTE_MBUF_DYNFIELD(mb,
 					iavf_timestamp_dynfield_offset,
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index db0462f0f5..c91123ead4 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -514,19 +514,8 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct ci_rx_queue *rxq,
 	if (!(rxdp->wb.status_error0 &
 			rte_cpu_to_le_32(1 << IAVF_RX_FLEX_DESC_STATUS0_DD_S)))
 		return 0;
-	bool is_tsinit = false;
 	uint8_t inflection_point = 0;
 	__m256i hw_low_last = _mm256_set_epi32(0, 0, 0, 0, 0, 0, 0, rxq->phc_time);
-	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
-		uint64_t sw_cur_time = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
-
-		if (unlikely(sw_cur_time - rxq->hw_time_update > 4)) {
-			hw_low_last = _mm256_setzero_si256();
-			is_tsinit = 1;
-		} else {
-			hw_low_last = _mm256_set_epi32(0, 0, 0, 0, 0, 0, 0, rxq->phc_time);
-		}
-	}
 
 	/* constants used in processing loop */
 	const __m256i crc_adjust =
@@ -1152,14 +1141,9 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct ci_rx_queue *rxq,
 					*RTE_MBUF_DYNFIELD(rx_pkts[i + 7],
 						iavf_timestamp_dynfield_offset, uint32_t *) = _mm256_extract_epi32(ts_low1, 7);
 
-					if (unlikely(is_tsinit)) {
-						uint32_t in_timestamp;
-						if (iavf_get_phc_time(rxq))
-							PMD_DRV_LOG(ERR, "get physical time failed");
-						in_timestamp = *RTE_MBUF_DYNFIELD(rx_pkts[i + 0],
-								iavf_timestamp_dynfield_offset, uint32_t *);
-						rxq->phc_time = iavf_tstamp_convert_32b_64b(rxq->phc_time, in_timestamp);
-					}
+					rxq->phc_time = iavf_tstamp_convert_32b_64b(rxq->phc_time,
+						*RTE_MBUF_DYNFIELD(rx_pkts[i + 0],
+						iavf_timestamp_dynfield_offset, uint32_t *));
 
 					*RTE_MBUF_DYNFIELD(rx_pkts[i + 0],
 						iavf_timestamp_dynfield_offset + 4, uint32_t *) = (uint32_t)(rxq->phc_time >> 32);
@@ -1388,8 +1372,6 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct ci_rx_queue *rxq,
 				PMD_DRV_LOG(ERR, "invalid inflection point for rx timestamp");
 				break;
 			}
-
-			rxq->hw_time_update = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
 		}
 		if (burst != IAVF_VPMD_DESCS_PER_LOOP_WIDE)
 			break;
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index 4e8bf94fa0..a7c0a02eba 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -615,19 +615,7 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct ci_rx_queue *rxq,
 
 #ifdef IAVF_RX_TS_OFFLOAD
 	uint8_t inflection_point = 0;
-	bool is_tsinit = false;
 	__m256i hw_low_last = _mm256_set_epi32(0, 0, 0, 0, 0, 0, 0, (uint32_t)rxq->phc_time);
-
-	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
-		uint64_t sw_cur_time = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
-
-		if (unlikely(sw_cur_time - rxq->hw_time_update > 4)) {
-			hw_low_last = _mm256_setzero_si256();
-			is_tsinit = 1;
-		} else {
-			hw_low_last = _mm256_set_epi32(0, 0, 0, 0, 0, 0, 0, (uint32_t)rxq->phc_time);
-		}
-	}
 #endif
 
 	/* constants used in processing loop */
@@ -1343,15 +1331,9 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct ci_rx_queue *rxq,
 					*RTE_MBUF_DYNFIELD(rx_pkts[i + 7],
 						iavf_timestamp_dynfield_offset, uint32_t *) = _mm256_extract_epi32(ts_low1, 7);
 
-					if (unlikely(is_tsinit)) {
-						uint32_t in_timestamp;
-
-						if (iavf_get_phc_time(rxq))
-							PMD_DRV_LOG(ERR, "get physical time failed");
-						in_timestamp = *RTE_MBUF_DYNFIELD(rx_pkts[i + 0],
-										iavf_timestamp_dynfield_offset, uint32_t *);
-						rxq->phc_time = iavf_tstamp_convert_32b_64b(rxq->phc_time, in_timestamp);
-					}
+					rxq->phc_time = iavf_tstamp_convert_32b_64b(rxq->phc_time,
+						*RTE_MBUF_DYNFIELD(rx_pkts[i + 0],
+						iavf_timestamp_dynfield_offset, uint32_t *));
 
 					*RTE_MBUF_DYNFIELD(rx_pkts[i + 0],
 						iavf_timestamp_dynfield_offset + 4, uint32_t *) = (uint32_t)(rxq->phc_time >> 32);
@@ -1584,8 +1566,6 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct ci_rx_queue *rxq,
 				PMD_DRV_LOG(ERR, "invalid inflection point for rx timestamp");
 				break;
 			}
-
-			rxq->hw_time_update = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
 		}
 #endif
 		if (burst != IAVF_VPMD_DESCS_PER_LOOP_WIDE)
-- 
2.47.1

