Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD0EC61DE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 10:37:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4BD04069F;
	Mon, 31 Aug 2026 12:36:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 64E7840682
 for <dev@dpdk.org>; Mon, 31 Aug 2026 12:36:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788172612; x=1819708612;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mBRYUKOxwV/bFogRpzEWKH8akgUA0AVXEedGgsy7dwg=;
 b=NO9o6ad4sz/nhI3dxzSW29pbZvvk949NkKHltAoqYbnKdBi6mD1imBtG
 ppcWY6LL70wbKpMEwnk8YWGTV8UCKZuuv0g5tgdCbyDJIc0v0kmwlUs0J
 kF208QyfOj2p7D1gvIZMWeVQ5hQfZ2BhfolHJHFQ5Tb8LtXy3PnTZtEGh
 A02LJFeFVZibep8yRZEJYuJwgX/bM48ZTR3OHtqj4OajwEcC0kPvs0lMT
 V6tGYQBHFAKFoLF5G1F5bjamd2u2oZ3L1veqB/lHD5n8thPprplM725Qo
 zWMzq1dzrxoxvEgf7INxhjRp/DrQ1TVdMSxnWoVAuKWo4zOiggmHqKIch Q==;
X-CSE-ConnectionGUID: L4kZ0ef2RPetDo/5QN/Epg==
X-CSE-MsgGUID: tzIDpPmGT06ViaQYpAAYQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88625951"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="88625951"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 03:36:52 -0700
X-CSE-ConnectionGUID: E6rKKU0RQS+gCI/6g8KJCw==
X-CSE-MsgGUID: /Lb3uCThQWu9PvO39WEPsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="268807454"
Received: from unknown (HELO pae-14.iind.intel.com) ([10.190.203.153])
 by orviesa007.jf.intel.com with ESMTP; 31 Aug 2026 03:36:50 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v2 4/4] net/ice: add AVX-512 context descriptor Tx path
Date: Mon, 31 Aug 2026 10:35:30 +0000
Message-Id: <513a99557c260187f86954b7ce289352bfae04a8.1788171502.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1788171502.git.anurag.mandal@intel.com>
References: <cover.1788171502.git.anurag.mandal@intel.com>
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

Added an AVX-512 context descriptor path for tunneled
outer IPv4 and UDP checksum offloads.

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 doc/guides/rel_notes/release_26_11.rst      |   5 +-
 drivers/net/intel/ice/ice_ethdev.h          |   1 +
 drivers/net/intel/ice/ice_rxtx.c            |  10 ++
 drivers/net/intel/ice/ice_rxtx.h            |   3 +
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c | 141 ++++++++++++++++++++
 5 files changed, 158 insertions(+), 2 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 8ce1875843..1239f1ab0d 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -57,8 +57,9 @@ New Features
 
 * **Updated Intel ice driver.**
 
-  Added an AVX2 Tx path using context descriptors, allowing tunneled outer IPv4
-  and UDP checksum offloads without falling back to scalar Tx.
+  * Added AVX2 and AVX-512 context-descriptor Tx paths,
+    enabling outer IPv4 and UDP checksum offloads for
+    tunneled packets without falling back to scalar Tx.
 
 * **Updated Intel iavf driver.**
 
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 0e74f8d776..00facd48bd 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -216,6 +216,7 @@ enum ice_tx_func_type {
 	ICE_TX_AVX2_CTX_OFFLOAD,
 	ICE_TX_AVX512,
 	ICE_TX_AVX512_OFFLOAD,
+	ICE_TX_AVX512_CTX_OFFLOAD,
 	ICE_TX_NEON,
 };
 
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 7e83541f5d..ea43006d79 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3580,6 +3580,16 @@ static const struct ci_tx_path_info ice_tx_path_infos[] = {
 		},
 		.pkt_prep = ice_prep_pkts
 	},
+	[ICE_TX_AVX512_CTX_OFFLOAD] = {
+		.pkt_burst = ice_xmit_pkts_vec_avx512_ctx_offload,
+		.info = "Context Offload Vector AVX512",
+		.features = {
+			.tx_offloads = ICE_TX_VECTOR_CTX_OFFLOAD_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512,
+			.ctx_desc = true
+		},
+		.pkt_prep = ice_prep_pkts
+	},
 #endif
 #elif defined(RTE_ARCH_ARM64)
 	[ICE_TX_NEON] = {
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index 37e346fe39..8d6bb0af01 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -308,6 +308,9 @@ uint16_t ice_xmit_pkts_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 uint16_t ice_xmit_pkts_vec_avx512_offload(void *tx_queue,
 					  struct rte_mbuf **tx_pkts,
 					  uint16_t nb_pkts);
+uint16_t ice_xmit_pkts_vec_avx512_ctx_offload(void *tx_queue,
+					      struct rte_mbuf **tx_pkts,
+					      uint16_t nb_pkts);
 int ice_fdir_programming(struct ice_pf *pf, struct ice_fltr_desc *fdir_desc);
 int ice_tx_done_cleanup(void *txq, uint32_t free_cnt);
 int ice_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc);
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
index 309ab9fca7..c8c3e103c5 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
@@ -901,6 +901,147 @@ ice_vtx(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkt,
 	}
 }
 
+static __rte_always_inline void
+ice_ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
+	     uint64_t flags, bool offload)
+{
+	uint64_t high_data_qw = CI_TX_DESC_DTYPE_DATA |
+			(flags << CI_TXD_QW1_CMD_S) |
+			((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
+	const uint64_t low_ctx_qw = offload ? ice_txd_tunneling_ctx(pkt) : 0;
+
+	if (offload)
+		ice_txd_enable_offload(pkt, &high_data_qw);
+
+	const __m256i ctx_data_desc = _mm256_set_epi64x(high_data_qw,
+			rte_pktmbuf_iova(pkt), CI_TX_DESC_DTYPE_CTX, low_ctx_qw);
+
+	_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp), ctx_data_desc);
+}
+
+static __rte_always_inline void
+ice_ctx_vtx(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkt,
+	    uint16_t nb_pkts, uint64_t flags, bool offload)
+{
+	while (nb_pkts > 1) {
+		uint64_t high_data_qw1 = CI_TX_DESC_DTYPE_DATA |
+				(flags << CI_TXD_QW1_CMD_S) |
+				((uint64_t)pkt[1]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t high_data_qw0 = CI_TX_DESC_DTYPE_DATA |
+				(flags << CI_TXD_QW1_CMD_S) |
+				((uint64_t)pkt[0]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
+		const uint64_t low_ctx_qw1 = offload ? ice_txd_tunneling_ctx(pkt[1]) : 0;
+		const uint64_t low_ctx_qw0 = offload ? ice_txd_tunneling_ctx(pkt[0]) : 0;
+
+		if (offload) {
+			ice_txd_enable_offload(pkt[1], &high_data_qw1);
+			ice_txd_enable_offload(pkt[0], &high_data_qw0);
+		}
+
+		const __m512i ctx_data_desc = _mm512_set_epi64(high_data_qw1,
+				rte_pktmbuf_iova(pkt[1]), CI_TX_DESC_DTYPE_CTX, low_ctx_qw1,
+				high_data_qw0, rte_pktmbuf_iova(pkt[0]),
+				CI_TX_DESC_DTYPE_CTX, low_ctx_qw0);
+
+		_mm512_storeu_si512(RTE_CAST_PTR(void *, txdp), ctx_data_desc);
+		txdp += 4;
+		pkt += 2;
+		nb_pkts -= 2;
+	}
+
+	if (nb_pkts)
+		ice_ctx_vtx1(txdp, *pkt, flags, offload);
+}
+
+static __rte_always_inline uint16_t
+ice_xmit_fixed_burst_vec_avx512_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
+				   uint16_t nb_pkts, bool offload)
+{
+	struct ci_tx_queue *txq = tx_queue;
+	volatile struct ci_tx_desc *txdp;
+	struct ci_tx_entry_vec *txep;
+	uint16_t n, nb_commit, nb_mbuf, tx_id;
+	const uint64_t flags = CI_TX_DESC_CMD_DEFAULT;
+	const uint64_t rs = CI_TX_DESC_CMD_RS | flags;
+
+	if (txq->nb_tx_free < txq->tx_free_thresh)
+		ci_tx_free_bufs_vec(txq, ice_tx_desc_done, true);
+
+	nb_commit = (uint16_t)RTE_MIN(txq->nb_tx_free,
+			(uint32_t)nb_pkts * 2);
+	nb_commit &= (uint16_t)~1;
+	if (unlikely(nb_commit == 0))
+		return 0;
+
+	nb_pkts = nb_commit >> 1;
+	tx_id = txq->tx_tail;
+	txdp = &txq->ci_tx_ring[tx_id];
+	txep = &txq->sw_ring_vec[tx_id >> 1];
+
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_commit);
+	n = (uint16_t)(txq->nb_tx_desc - tx_id);
+
+	if (nb_commit >= n) {
+		nb_mbuf = n >> 1;
+		ci_tx_backlog_entry_vec(txep, tx_pkts, nb_mbuf);
+
+		ice_ctx_vtx(txdp, tx_pkts, nb_mbuf - 1, flags, offload);
+		tx_pkts += nb_mbuf - 1;
+		txdp += n - 2;
+		ice_ctx_vtx1(txdp, *tx_pkts++, rs, offload);
+
+		nb_commit = (uint16_t)(nb_commit - n);
+		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
+		tx_id = 0;
+		txdp = txq->ci_tx_ring;
+		txep = txq->sw_ring_vec;
+	}
+
+	nb_mbuf = nb_commit >> 1;
+	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_mbuf);
+	ice_ctx_vtx(txdp, tx_pkts, nb_mbuf, flags, offload);
+	tx_id = (uint16_t)(tx_id + nb_commit);
+
+	if (tx_id > txq->tx_next_rs) {
+		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
+			rte_cpu_to_le_64((uint64_t)CI_TX_DESC_CMD_RS << CI_TXD_QW1_CMD_S);
+		txq->tx_next_rs = (uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
+	}
+
+	txq->tx_tail = tx_id;
+	ICE_PCI_REG_WC_WRITE(txq->qtx_tail, txq->tx_tail);
+
+	return nb_pkts;
+}
+
+static __rte_always_inline uint16_t
+ice_xmit_pkts_vec_avx512_ctx_common(void *tx_queue, struct rte_mbuf **tx_pkts,
+				   uint16_t nb_pkts, bool offload)
+{
+	struct ci_tx_queue *txq = tx_queue;
+	uint16_t nb_tx = 0;
+
+	while (nb_pkts) {
+		const uint16_t num = RTE_MIN(nb_pkts, txq->tx_rs_thresh >> 1);
+		const uint16_t ret = ice_xmit_fixed_burst_vec_avx512_ctx(tx_queue,
+				&tx_pkts[nb_tx], num, offload);
+
+		nb_tx += ret;
+		nb_pkts -= ret;
+		if (ret < num)
+			break;
+	}
+
+	return nb_tx;
+}
+
+uint16_t
+ice_xmit_pkts_vec_avx512_ctx_offload(void *tx_queue,
+		struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
+{
+	return ice_xmit_pkts_vec_avx512_ctx_common(tx_queue, tx_pkts, nb_pkts, true);
+}
+
 static __rte_always_inline uint16_t
 ice_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 				uint16_t nb_pkts, bool do_offload)
-- 
2.34.1

