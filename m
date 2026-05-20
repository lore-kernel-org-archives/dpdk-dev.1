Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA279CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 06:10:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AAFA4065F;
	Wed, 20 May 2026 08:10:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 1C9BF40276;
 Wed, 20 May 2026 08:10:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779257445; x=1810793445;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bg5WvbFOJbQLjsX3hMw41xtW5N43yk4EINvrJk8DpLc=;
 b=C8Z4dwKJx1OZkTLIKzmbjJuoIRu61xsdagZwkk0Y4XhNR4+71apNi+C0
 R3iJ+hIpGLjAshj8E0a/pqi/HdGlA0NleHwqvAoPpH3ZS9BNs9Pv9T1Pm
 s2Psod50HuD3guJkgdrALhugZA1laCoIXyUiXkxicL6FyWLOjDpFJMAZW
 dsUsBnnxUERJp10kx7M4Yw44TOMKd5zZSB6UWES36WgRa1BM6LzBA39cN
 TsRr8yOcdJSlH4Yb9aLOStoTU23TPbngs+MZR47VwgvP3chbPUcqdf56G
 gX2KQxjjSPzAJ8s4e75CC3WPyGQADk6apMTby+MOULtJRPbrjNg9WbAOQ A==;
X-CSE-ConnectionGUID: +CTkSEFnSaWkh9g1eAoHtg==
X-CSE-MsgGUID: ez4nbOtWQBeQRXfTD5meBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80203413"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="80203413"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 23:10:35 -0700
X-CSE-ConnectionGUID: XYxhv2YKS/Cd/PUsRx5kjQ==
X-CSE-MsgGUID: lABqph2pRr2dHgrjVk9xQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="240093559"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa009.jf.intel.com with ESMTP; 19 May 2026 23:10:32 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v5 2/2] net/iavf: remove PHC polling from Rx datapath
Date: Wed, 20 May 2026 14:43:50 -0400
Message-ID: <20260520184350.81934-3-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260520184350.81934-1-soumyadeep.hore@intel.com>
References: <20260509101447.42093-3-soumyadeep.hore@intel.com>
 <20260520184350.81934-1-soumyadeep.hore@intel.com>
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

With control-path PHC sync already in place, this avoids hot-path PHC
polling overhead while preserving RX timestamp correctness.

Bugzilla ID: 1898
Fixes: 61b6874b9224 ("net/iavf: support Rx timestamp offload on AVX512")
Fixes: 6ad2944f4e82 ("net/iavf: support Rx timestamp offload on AVX2")
Fixes: 33db16136e55 ("net/iavf: improve performance of Rx timestamp offload")
Cc: stable@dpdk.org

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx.c            | 34 -------------------
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   | 16 ++-------
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 16 ++-------
 3 files changed, 4 insertions(+), 62 deletions(-)

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
index db0462f0f5..9349646d55 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -514,18 +514,10 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct ci_rx_queue *rxq,
 	if (!(rxdp->wb.status_error0 &
 			rte_cpu_to_le_32(1 << IAVF_RX_FLEX_DESC_STATUS0_DD_S)))
 		return 0;
-	bool is_tsinit = false;
 	uint8_t inflection_point = 0;
 	__m256i hw_low_last = _mm256_set_epi32(0, 0, 0, 0, 0, 0, 0, rxq->phc_time);
 	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
-		uint64_t sw_cur_time = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
-
-		if (unlikely(sw_cur_time - rxq->hw_time_update > 4)) {
-			hw_low_last = _mm256_setzero_si256();
-			is_tsinit = 1;
-		} else {
-			hw_low_last = _mm256_set_epi32(0, 0, 0, 0, 0, 0, 0, rxq->phc_time);
-		}
+		hw_low_last = _mm256_set_epi32(0, 0, 0, 0, 0, 0, 0, rxq->phc_time);
 	}
 
 	/* constants used in processing loop */
@@ -1152,10 +1144,8 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct ci_rx_queue *rxq,
 					*RTE_MBUF_DYNFIELD(rx_pkts[i + 7],
 						iavf_timestamp_dynfield_offset, uint32_t *) = _mm256_extract_epi32(ts_low1, 7);
 
-					if (unlikely(is_tsinit)) {
+					{
 						uint32_t in_timestamp;
-						if (iavf_get_phc_time(rxq))
-							PMD_DRV_LOG(ERR, "get physical time failed");
 						in_timestamp = *RTE_MBUF_DYNFIELD(rx_pkts[i + 0],
 								iavf_timestamp_dynfield_offset, uint32_t *);
 						rxq->phc_time = iavf_tstamp_convert_32b_64b(rxq->phc_time, in_timestamp);
@@ -1388,8 +1378,6 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct ci_rx_queue *rxq,
 				PMD_DRV_LOG(ERR, "invalid inflection point for rx timestamp");
 				break;
 			}
-
-			rxq->hw_time_update = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
 		}
 		if (burst != IAVF_VPMD_DESCS_PER_LOOP_WIDE)
 			break;
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index 4e8bf94fa0..1bb3e9746b 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -615,18 +615,10 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct ci_rx_queue *rxq,
 
 #ifdef IAVF_RX_TS_OFFLOAD
 	uint8_t inflection_point = 0;
-	bool is_tsinit = false;
 	__m256i hw_low_last = _mm256_set_epi32(0, 0, 0, 0, 0, 0, 0, (uint32_t)rxq->phc_time);
 
 	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
-		uint64_t sw_cur_time = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
-
-		if (unlikely(sw_cur_time - rxq->hw_time_update > 4)) {
-			hw_low_last = _mm256_setzero_si256();
-			is_tsinit = 1;
-		} else {
-			hw_low_last = _mm256_set_epi32(0, 0, 0, 0, 0, 0, 0, (uint32_t)rxq->phc_time);
-		}
+		hw_low_last = _mm256_set_epi32(0, 0, 0, 0, 0, 0, 0, (uint32_t)rxq->phc_time);
 	}
 #endif
 
@@ -1343,11 +1335,9 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct ci_rx_queue *rxq,
 					*RTE_MBUF_DYNFIELD(rx_pkts[i + 7],
 						iavf_timestamp_dynfield_offset, uint32_t *) = _mm256_extract_epi32(ts_low1, 7);
 
-					if (unlikely(is_tsinit)) {
+					{
 						uint32_t in_timestamp;
 
-						if (iavf_get_phc_time(rxq))
-							PMD_DRV_LOG(ERR, "get physical time failed");
 						in_timestamp = *RTE_MBUF_DYNFIELD(rx_pkts[i + 0],
 										iavf_timestamp_dynfield_offset, uint32_t *);
 						rxq->phc_time = iavf_tstamp_convert_32b_64b(rxq->phc_time, in_timestamp);
@@ -1584,8 +1574,6 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct ci_rx_queue *rxq,
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

