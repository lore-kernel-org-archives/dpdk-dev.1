Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9495CA0EED
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 17:07:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABDE840B98;
	Fri, 22 Aug 2025 19:07:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 40D3D40297
 for <dev@dpdk.org>; Fri, 22 Aug 2025 19:07:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755882431; x=1787418431;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PMLa34z45zgczF6Gy/DtGMgiwSbzOTHBh2CBemk3sEU=;
 b=DqulJHfnWPP0HOF2l7cb+jh8lI3JH32VY0FpBCy2hpDRV9Z/2yzMwozc
 A2B5Ky+wAIgUQUQolOg3xSj2aEwAVlZcsPpfYVObaeMbz7bwtAy713Bd6
 FjmV47y/P50VgxDJWLryZ8dWEBZsaS6REQE0rqnVDG5ck9O3/BdZWgbh2
 NBm7wqdb551WEGD85Zcfve0djX1+o0NcnAsSK/8c/LMfLBj2edAfFLSIi
 5FosYKMxq2B+2aQggpJh7lnz7NilZuRQ+ZP6zFyI3K0nZWSjTK9Fib48o
 u5RvzODvnb8cmIyWjpBl3GmjcTumIbXvcOC9G2oULjPtzLlmMUQnKFe0N A==;
X-CSE-ConnectionGUID: uC77QE01RrG1g+JKpXJTcg==
X-CSE-MsgGUID: gTUgtLBDRSmWAybCIGzZAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="69294555"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="69294555"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2025 10:07:10 -0700
X-CSE-ConnectionGUID: MF3UqFJORuuTKs7bYmOGCw==
X-CSE-MsgGUID: EECm2A99TCuBtR4F+e6hUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="192416675"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.55.129.54])
 by fmviesa002.fm.intel.com with ESMTP; 22 Aug 2025 10:07:08 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: mb@smartsharesystems.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 1/2] net/intel: avoid allocating from mempool directly
Date: Fri, 22 Aug 2025 17:06:55 +0000
Message-ID: <20250822170656.454571-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250822170656.454571-1-bruce.richardson@intel.com>
References: <20250822170656.454571-1-bruce.richardson@intel.com>
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

Rather than calling the mempool function rte_mempool_get_bulk we update
the code to use the mbuf function rte_mbuf_raw_alloc_bulk, which
properly supports debug flags and checks - when enabled.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/rx_vec_arm.h            | 6 +++---
 drivers/net/intel/common/rx_vec_ppc.h            | 6 +++---
 drivers/net/intel/common/rx_vec_x86.h            | 6 +++---
 drivers/net/intel/fm10k/fm10k_ethdev.c           | 2 +-
 drivers/net/intel/fm10k/fm10k_rxtx.c             | 8 ++++----
 drivers/net/intel/fm10k/fm10k_rxtx_vec.c         | 2 +-
 drivers/net/intel/i40e/i40e_rxtx.c               | 2 +-
 drivers/net/intel/iavf/iavf_rxtx.c               | 2 +-
 drivers/net/intel/ice/ice_rxtx.c                 | 4 ++--
 drivers/net/intel/idpf/idpf_common_rxtx_avx2.c   | 2 +-
 drivers/net/intel/idpf/idpf_common_rxtx_avx512.c | 4 ++--
 drivers/net/intel/ixgbe/ixgbe_rxtx.c             | 2 +-
 12 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/net/intel/common/rx_vec_arm.h b/drivers/net/intel/common/rx_vec_arm.h
index 2e48d4b6c0..f7e7b8c396 100644
--- a/drivers/net/intel/common/rx_vec_arm.h
+++ b/drivers/net/intel/common/rx_vec_arm.h
@@ -16,19 +16,19 @@
 static inline int
 _ci_rxq_rearm_get_bufs(struct ci_rx_queue *rxq)
 {
-	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
+	struct rte_mbuf **rxp = &rxq->sw_ring[rxq->rxrearm_start].mbuf;
 	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
 	volatile union ci_rx_desc *rxdp;
 	int i;
 
 	rxdp = &rxq->rx_ring[rxq->rxrearm_start];
 
-	if (rte_mempool_get_bulk(rxq->mp, (void **)rxp, rearm_thresh) < 0) {
+	if (rte_mbuf_raw_alloc_bulk(rxq->mp, rxp, rearm_thresh) < 0) {
 		if (rxq->rxrearm_nb + rearm_thresh >= rxq->nb_rx_desc) {
 			uint64x2_t zero = vdupq_n_u64(0);
 
 			for (i = 0; i < CI_VPMD_DESCS_PER_LOOP; i++) {
-				rxp[i].mbuf = &rxq->fake_mbuf;
+				rxp[i] = &rxq->fake_mbuf;
 				vst1q_u64(RTE_CAST_PTR(uint64_t *, &rxdp[i]), zero);
 			}
 		}
diff --git a/drivers/net/intel/common/rx_vec_ppc.h b/drivers/net/intel/common/rx_vec_ppc.h
index 97affc34c2..7d02eb067b 100644
--- a/drivers/net/intel/common/rx_vec_ppc.h
+++ b/drivers/net/intel/common/rx_vec_ppc.h
@@ -16,19 +16,19 @@
 static inline int
 _ci_rxq_rearm_get_bufs(struct ci_rx_queue *rxq)
 {
-	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
+	struct rte_mbuf **rxp = &rxq->sw_ring[rxq->rxrearm_start].mbuf;
 	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
 	volatile union ci_rx_desc *rxdp;
 	int i;
 
 	rxdp = &rxq->rx_ring[rxq->rxrearm_start];
 
-	if (rte_mempool_get_bulk(rxq->mp, (void **)rxp, rearm_thresh) < 0) {
+	if (rte_mbuf_raw_alloc_bulk(rxq->mp, rxp, rearm_thresh) < 0) {
 		if (rxq->rxrearm_nb + rearm_thresh >= rxq->nb_rx_desc) {
 			__vector unsigned long dma_addr0 = (__vector unsigned long){};
 
 			for (i = 0; i < CI_VPMD_DESCS_PER_LOOP; i++) {
-				rxp[i].mbuf = &rxq->fake_mbuf;
+				rxp[i] = &rxq->fake_mbuf;
 				vec_st(dma_addr0, 0,
 					RTE_CAST_PTR(__vector unsigned long *, &rxdp[i]));
 			}
diff --git a/drivers/net/intel/common/rx_vec_x86.h b/drivers/net/intel/common/rx_vec_x86.h
index 3d7343b1ff..5160767385 100644
--- a/drivers/net/intel/common/rx_vec_x86.h
+++ b/drivers/net/intel/common/rx_vec_x86.h
@@ -21,19 +21,19 @@ enum ci_rx_vec_level {
 static inline int
 _ci_rxq_rearm_get_bufs(struct ci_rx_queue *rxq)
 {
-	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
+	struct rte_mbuf **rxp = &rxq->sw_ring[rxq->rxrearm_start].mbuf;
 	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
 	volatile union ci_rx_desc *rxdp;
 	int i;
 
 	rxdp = &rxq->rx_ring[rxq->rxrearm_start];
 
-	if (rte_mempool_get_bulk(rxq->mp, (void **)rxp, rearm_thresh) < 0) {
+	if (rte_mbuf_raw_alloc_bulk(rxq->mp, rxp, rearm_thresh) < 0) {
 		if (rxq->rxrearm_nb + rearm_thresh >= rxq->nb_rx_desc) {
 			const __m128i zero = _mm_setzero_si128();
 
 			for (i = 0; i < CI_VPMD_DESCS_PER_LOOP; i++) {
-				rxp[i].mbuf = &rxq->fake_mbuf;
+				rxp[i] = &rxq->fake_mbuf;
 				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i]), zero);
 			}
 		}
diff --git a/drivers/net/intel/fm10k/fm10k_ethdev.c b/drivers/net/intel/fm10k/fm10k_ethdev.c
index 75ce2e19cf..216165a9bd 100644
--- a/drivers/net/intel/fm10k/fm10k_ethdev.c
+++ b/drivers/net/intel/fm10k/fm10k_ethdev.c
@@ -205,7 +205,7 @@ rx_queue_reset(struct fm10k_rx_queue *q)
 	int i, diag;
 	PMD_INIT_FUNC_TRACE();
 
-	diag = rte_mempool_get_bulk(q->mp, (void **)q->sw_ring, q->nb_desc);
+	diag = rte_mbuf_raw_alloc_bulk(q->mp, (void *)q->sw_ring, q->nb_desc);
 	if (diag != 0)
 		return -ENOMEM;
 
diff --git a/drivers/net/intel/fm10k/fm10k_rxtx.c b/drivers/net/intel/fm10k/fm10k_rxtx.c
index 690142b357..0557ee88df 100644
--- a/drivers/net/intel/fm10k/fm10k_rxtx.c
+++ b/drivers/net/intel/fm10k/fm10k_rxtx.c
@@ -164,8 +164,8 @@ fm10k_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 	q->next_dd = next_dd;
 
 	if ((q->next_dd > q->next_trigger) || (alloc == 1)) {
-		ret = rte_mempool_get_bulk(q->mp,
-					(void **)&q->sw_ring[q->next_alloc],
+		ret = rte_mbuf_raw_alloc_bulk(q->mp,
+					(void *)&q->sw_ring[q->next_alloc],
 					q->alloc_thresh);
 
 		if (unlikely(ret != 0)) {
@@ -322,8 +322,8 @@ fm10k_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 	q->next_dd = next_dd;
 
 	if ((q->next_dd > q->next_trigger) || (alloc == 1)) {
-		ret = rte_mempool_get_bulk(q->mp,
-					(void **)&q->sw_ring[q->next_alloc],
+		ret = rte_mbuf_raw_alloc_bulk(q->mp,
+					(void *)&q->sw_ring[q->next_alloc],
 					q->alloc_thresh);
 
 		if (unlikely(ret != 0)) {
diff --git a/drivers/net/intel/fm10k/fm10k_rxtx_vec.c b/drivers/net/intel/fm10k/fm10k_rxtx_vec.c
index 715c891c30..1269a34e76 100644
--- a/drivers/net/intel/fm10k/fm10k_rxtx_vec.c
+++ b/drivers/net/intel/fm10k/fm10k_rxtx_vec.c
@@ -259,7 +259,7 @@ fm10k_rxq_rearm(struct fm10k_rx_queue *rxq)
 	rxdp = rxq->hw_ring + rxq->rxrearm_start;
 
 	/* Pull 'n' more MBUFs into the software ring */
-	if (rte_mempool_get_bulk(rxq->mp,
+	if (rte_mbuf_raw_alloc_bulk(rxq->mp,
 				 (void *)mb_alloc,
 				 RTE_FM10K_RXQ_REARM_THRESH) < 0) {
 		dma_addr0 = _mm_setzero_si128();
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index aba3c11ee5..a3ca8254ff 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -590,7 +590,7 @@ i40e_rx_alloc_bufs(struct ci_rx_queue *rxq)
 	alloc_idx = (uint16_t)(rxq->rx_free_trigger -
 				(rxq->rx_free_thresh - 1));
 	rxep = &(rxq->sw_ring[alloc_idx]);
-	diag = rte_mempool_get_bulk(rxq->mp, (void *)rxep,
+	diag = rte_mbuf_raw_alloc_bulk(rxq->mp, (void *)rxep,
 					rxq->rx_free_thresh);
 	if (unlikely(diag != 0)) {
 		PMD_DRV_LOG(ERR, "Failed to get mbufs in bulk");
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 7033a74610..c0e3827066 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -2227,7 +2227,7 @@ iavf_rx_alloc_bufs(struct ci_rx_queue *rxq)
 	alloc_idx = (uint16_t)(rxq->rx_free_trigger -
 				(rxq->rx_free_thresh - 1));
 	rxep = &rxq->sw_ring[alloc_idx];
-	diag = rte_mempool_get_bulk(rxq->mp, (void *)rxep,
+	diag = rte_mbuf_raw_alloc_bulk(rxq->mp, (void *)rxep,
 				    rxq->rx_free_thresh);
 	if (unlikely(diag != 0)) {
 		PMD_RX_LOG(ERR, "Failed to get mbufs in bulk");
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index da508592aa..0294794bed 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -2039,7 +2039,7 @@ ice_rx_alloc_bufs(struct ci_rx_queue *rxq)
 	alloc_idx = (uint16_t)(rxq->rx_free_trigger -
 			       (rxq->rx_free_thresh - 1));
 	rxep = &rxq->sw_ring[alloc_idx];
-	diag = rte_mempool_get_bulk(rxq->mp, (void *)rxep,
+	diag = rte_mbuf_raw_alloc_bulk(rxq->mp, (void *)rxep,
 				    rxq->rx_free_thresh);
 	if (unlikely(diag != 0)) {
 		PMD_RX_LOG(ERR, "Failed to get mbufs in bulk");
@@ -2047,7 +2047,7 @@ ice_rx_alloc_bufs(struct ci_rx_queue *rxq)
 	}
 
 	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT) {
-		diag_pay = rte_mempool_get_bulk(rxq->rxseg[1].mp,
+		diag_pay = rte_mbuf_raw_alloc_bulk(rxq->rxseg[1].mp,
 				(void *)rxq->sw_split_buf, rxq->rx_free_thresh);
 		if (unlikely(diag_pay != 0)) {
 			rte_mempool_put_bulk(rxq->mp, (void *)rxep,
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
index 1babc5114b..21c8f79254 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -20,7 +20,7 @@ idpf_singleq_rx_rearm(struct idpf_rx_queue *rxq)
 	rxdp += rxq->rxrearm_start;
 
 	/* Pull 'n' more MBUFs into the software ring */
-	if (rte_mempool_get_bulk(rxq->mp,
+	if (rte_mbuf_raw_alloc_bulk(rxq->mp,
 				 (void *)rxep,
 				 IDPF_RXQ_REARM_THRESH) < 0) {
 		if (rxq->rxrearm_nb + IDPF_RXQ_REARM_THRESH >=
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index 06e73c8725..bc2cadd738 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -22,7 +22,7 @@ idpf_singleq_rearm_common(struct idpf_rx_queue *rxq)
 	rxdp += rxq->rxrearm_start;
 
 	/* Pull 'n' more MBUFs into the software ring */
-	if (rte_mempool_get_bulk(rxq->mp,
+	if (rte_mbuf_raw_alloc_bulk(rxq->mp,
 				 (void *)rxp,
 				 IDPF_RXQ_REARM_THRESH) < 0) {
 		if (rxq->rxrearm_nb + IDPF_RXQ_REARM_THRESH >=
@@ -551,7 +551,7 @@ idpf_splitq_rearm_common(struct idpf_rx_queue *rx_bufq)
 	rxdp += rx_bufq->rxrearm_start;
 
 	/* Pull 'n' more MBUFs into the software ring */
-	if (rte_mempool_get_bulk(rx_bufq->mp,
+	if (rte_mbuf_raw_alloc_bulk(rx_bufq->mp,
 				 (void *)rxp,
 				 IDPF_RXQ_REARM_THRESH) < 0) {
 		if (rx_bufq->rxrearm_nb + IDPF_RXQ_REARM_THRESH >=
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index bbe665a6ff..6143d16377 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -1659,7 +1659,7 @@ ixgbe_rx_alloc_bufs(struct ci_rx_queue *rxq, bool reset_mbuf)
 	/* allocate buffers in bulk directly into the S/W ring */
 	alloc_idx = rxq->rx_free_trigger - (rxq->rx_free_thresh - 1);
 	rxep = &rxq->sw_ring[alloc_idx];
-	diag = rte_mempool_get_bulk(rxq->mp, (void *)rxep,
+	diag = rte_mbuf_raw_alloc_bulk(rxq->mp, (void *)rxep,
 				    rxq->rx_free_thresh);
 	if (unlikely(diag != 0))
 		return -ENOMEM;
-- 
2.48.1

