Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2880C5AD49
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Jun 2025 19:42:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD5A440648;
	Sun,  8 Jun 2025 21:42:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id D02EC40615
 for <dev@dpdk.org>; Sun,  8 Jun 2025 21:42:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749411729; x=1780947729;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=E39m0dozhNIIxfXVB77P5B6tFRUM1ghuTXWgw2h5Xvk=;
 b=PCoa8wEOgatXCvWiJGHDaKOcLlJ5baUnq3BiFhWu0ucd8JxRvcV66sFN
 iCp+b0BlkU1ENM5I1T4GrNr0TnqUsxsyKTS1Pp7sGagXPEm4LvJ/RXP08
 l+g+8GviVDiPfn1lFOy4BIWwrDh3K3XHR0fsQgsvzq9XHLsy3t67gBKYs
 LBNyNRM2ngTk1kN9VHyOXnM4ngrCexHgfPuD1e9DPXo2XIJ0BEiSPUJsX
 l9tDX+/7TnFsdcNXM/g3ImkNBhQq0yWBC2jrzfEgXqkKju6N6h+/BsLyU
 XjXb94vex9hUta79YCMqDeToXVH+IKAK1GAlquQz2dcY5O+MWn+SKQX9e g==;
X-CSE-ConnectionGUID: zgMVG3+3RuiSY+1ZNLg9eQ==
X-CSE-MsgGUID: Zwr5R2UYRwu5n4yvpZSzJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="61757552"
X-IronPort-AV: E=Sophos;i="6.16,221,1744095600"; d="scan'208";a="61757552"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2025 12:42:09 -0700
X-CSE-ConnectionGUID: m30I9xQ4RQmvbTaaeYMAOA==
X-CSE-MsgGUID: BsDmmnw5Qbe8XTSbhPWl6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,221,1744095600"; d="scan'208";a="146847525"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by fmviesa010.fm.intel.com with ESMTP; 08 Jun 2025 12:42:07 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com,
	manoj.kumar.subbarao@intel.com
Subject: [PATCH v3 5/6] net/intel: add AVX512 Support for TxPP
Date: Sun,  8 Jun 2025 11:32:22 +0000
Message-ID: <20250608113223.487043-6-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250608113223.487043-1-soumyadeep.hore@intel.com>
References: <20250606211947.473544-2-soumyadeep.hore@intel.com>
 <20250608113223.487043-1-soumyadeep.hore@intel.com>
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

Tx Time based queues are supported using AVX512 vector.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c | 206 +++++++++++++++++++-
 1 file changed, 205 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
index bd49be07c9..394cd15a71 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
@@ -912,6 +912,200 @@ ice_vtx(volatile struct ice_tx_desc *txdp, struct rte_mbuf **pkt,
 	}
 }
 
+static __rte_always_inline void
+ice_vts1(volatile struct ice_ts_desc *ts, struct rte_mbuf *pkt,
+		uint16_t tx_tail, uint16_t nb_tx_desc, int ts_offset)
+{
+	ts->tx_desc_idx_tstamp = ice_get_ts_queue_desc(pkt,
+						tx_tail, nb_tx_desc, ts_offset);
+}
+
+static __rte_always_inline void
+ice_vts4(volatile struct ice_ts_desc *ts, struct rte_mbuf **pkt,
+	uint16_t nb_pkts, uint16_t tx_tail, uint16_t nb_tx_desc,
+	int ts_offset)
+{
+	uint16_t tx_id;
+
+	for (; nb_pkts > 3; ts += 4, pkt += 4, nb_pkts -= 4,
+			tx_tail += 4) {
+		tx_id = tx_tail + 4;
+		uint32_t ts_dsc3 = ice_get_ts_queue_desc(pkt[3],
+						tx_id, nb_tx_desc, ts_offset);
+		tx_id = tx_tail + 3;
+		uint32_t ts_dsc2 = ice_get_ts_queue_desc(pkt[2],
+						tx_id, nb_tx_desc, ts_offset);
+		tx_id = tx_tail + 2;
+		uint32_t ts_dsc1 = ice_get_ts_queue_desc(pkt[1],
+						tx_id, nb_tx_desc, ts_offset);
+		tx_id = tx_tail + 1;
+		uint32_t ts_dsc0 = ice_get_ts_queue_desc(pkt[0],
+						tx_id, nb_tx_desc, ts_offset);
+		__m128i desc0_3 = _mm_set_epi32(ts_dsc3, ts_dsc2,
+						ts_dsc1, ts_dsc0);
+		_mm_store_si128(RTE_CAST_PTR(void *, ts), desc0_3);
+	}
+
+	/* do any last ones */
+	while (nb_pkts) {
+		tx_tail++;
+		ice_vts1(ts, *pkt, tx_tail, nb_tx_desc, ts_offset);
+		ts++, pkt++, nb_pkts--;
+	}
+}
+
+static __rte_always_inline void
+ice_vts8(volatile struct ice_ts_desc *ts, struct rte_mbuf **pkt,
+	uint16_t nb_pkts, uint16_t tx_tail, uint16_t nb_tx_desc,
+	int ts_offset)
+{
+	uint16_t tx_id;
+
+	for (; nb_pkts > 7; ts += 8, pkt += 8, nb_pkts -= 8,
+			tx_tail += 8) {
+		tx_id = tx_tail + 8;
+		uint32_t ts_dsc7 = ice_get_ts_queue_desc(pkt[7],
+						tx_id, nb_tx_desc, ts_offset);
+		tx_id = tx_tail + 7;
+		uint32_t ts_dsc6 = ice_get_ts_queue_desc(pkt[6],
+						tx_id, nb_tx_desc, ts_offset);
+		tx_id = tx_tail + 6;
+		uint32_t ts_dsc5 = ice_get_ts_queue_desc(pkt[5],
+						tx_id, nb_tx_desc, ts_offset);
+		tx_id = tx_tail + 5;
+		uint32_t ts_dsc4 = ice_get_ts_queue_desc(pkt[4],
+						tx_id, nb_tx_desc, ts_offset);
+		tx_id = tx_tail + 4;
+		uint32_t ts_dsc3 = ice_get_ts_queue_desc(pkt[3],
+						tx_id, nb_tx_desc, ts_offset);
+		tx_id = tx_tail + 3;
+		uint32_t ts_dsc2 = ice_get_ts_queue_desc(pkt[2],
+						tx_id, nb_tx_desc, ts_offset);
+		tx_id = tx_tail + 2;
+		uint32_t ts_dsc1 = ice_get_ts_queue_desc(pkt[1],
+						tx_id, nb_tx_desc, ts_offset);
+		tx_id = tx_tail + 1;
+		uint32_t ts_dsc0 = ice_get_ts_queue_desc(pkt[0],
+						tx_id, nb_tx_desc, ts_offset);
+		__m256i desc0_7 = _mm256_set_epi32(ts_dsc7, ts_dsc6,
+						ts_dsc5, ts_dsc4, ts_dsc3, ts_dsc2,
+						ts_dsc1, ts_dsc0);
+		_mm256_storeu_si256(RTE_CAST_PTR(void *, ts), desc0_7);
+	}
+
+	/* do any last ones */
+	if (nb_pkts)
+		ice_vts4(ts, pkt, nb_pkts, tx_tail, nb_tx_desc,
+				ts_offset);
+}
+
+static __rte_always_inline void
+ice_vts(volatile struct ice_ts_desc *ts, struct rte_mbuf **pkt,
+	uint16_t nb_pkts, uint16_t tx_tail, uint16_t nb_tx_desc,
+	int ts_offset)
+{
+	uint16_t tx_id;
+
+	for (; nb_pkts > 15; ts += 16, pkt += 16, nb_pkts -= 16,
+			tx_tail += 16) {
+		tx_id = tx_tail + 16;
+		uint32_t ts_dsc15 = ice_get_ts_queue_desc(pkt[15],
+						tx_id, nb_tx_desc, ts_offset);
+		tx_id = tx_tail + 15;
+		uint32_t ts_dsc14 = ice_get_ts_queue_desc(pkt[14],
+						tx_id, nb_tx_desc, ts_offset);
+		tx_id = tx_tail + 14;
+		uint32_t ts_dsc13 = ice_get_ts_queue_desc(pkt[13],
+						tx_id, nb_tx_desc, ts_offset);
+		tx_id = tx_tail + 13;
+		uint32_t ts_dsc12 = ice_get_ts_queue_desc(pkt[12],
+						tx_id, nb_tx_desc, ts_offset);
+		tx_id = tx_tail + 12;
+		uint32_t ts_dsc11 = ice_get_ts_queue_desc(pkt[11],
+						tx_id, nb_tx_desc, ts_offset);
+		tx_id = tx_tail + 11;
+		uint32_t ts_dsc10 = ice_get_ts_queue_desc(pkt[10],
+						tx_id, nb_tx_desc, ts_offset);
+		tx_id = tx_tail + 10;
+		uint32_t ts_dsc9 = ice_get_ts_queue_desc(pkt[9],
+						tx_id, nb_tx_desc, ts_offset);
+		tx_id = tx_tail + 9;
+		uint32_t ts_dsc8 = ice_get_ts_queue_desc(pkt[8],
+						tx_id, nb_tx_desc, ts_offset);
+		tx_id = tx_tail + 8;
+		uint32_t ts_dsc7 = ice_get_ts_queue_desc(pkt[7],
+						tx_id, nb_tx_desc, ts_offset);
+		tx_id = tx_tail + 7;
+		uint32_t ts_dsc6 = ice_get_ts_queue_desc(pkt[6],
+						tx_id, nb_tx_desc, ts_offset);
+		tx_id = tx_tail + 6;
+		uint32_t ts_dsc5 = ice_get_ts_queue_desc(pkt[5],
+						tx_id, nb_tx_desc, ts_offset);
+		tx_id = tx_tail + 5;
+		uint32_t ts_dsc4 = ice_get_ts_queue_desc(pkt[4],
+						tx_id, nb_tx_desc, ts_offset);
+		tx_id = tx_tail + 4;
+		uint32_t ts_dsc3 = ice_get_ts_queue_desc(pkt[3],
+						tx_id, nb_tx_desc, ts_offset);
+		tx_id = tx_tail + 3;
+		uint32_t ts_dsc2 = ice_get_ts_queue_desc(pkt[2],
+						tx_id, nb_tx_desc, ts_offset);
+		tx_id = tx_tail + 2;
+		uint32_t ts_dsc1 = ice_get_ts_queue_desc(pkt[1],
+						tx_id, nb_tx_desc, ts_offset);
+		tx_id = tx_tail + 1;
+		uint32_t ts_dsc0 = ice_get_ts_queue_desc(pkt[0],
+						tx_id, nb_tx_desc, ts_offset);
+		__m512i desc0_15 = _mm512_set_epi32(ts_dsc15, ts_dsc14,
+						ts_dsc13, ts_dsc12, ts_dsc11, ts_dsc10,
+						ts_dsc9, ts_dsc8, ts_dsc7, ts_dsc6,
+						ts_dsc5, ts_dsc4, ts_dsc3, ts_dsc2,
+						ts_dsc1, ts_dsc0);
+		_mm512_storeu_si512(RTE_CAST_PTR(void *, ts), desc0_15);
+	}
+
+	/* do any last ones */
+	if (nb_pkts)
+		ice_vts8(ts, pkt, nb_pkts, tx_tail, nb_tx_desc,
+				ts_offset);
+}
+
+static __rte_always_inline uint16_t
+ice_xmit_fixed_ts_burst_vec_avx512(struct ci_tx_queue *txq,
+				struct rte_mbuf **tx_pkts, uint16_t nb_pkts,
+				uint16_t tx_tail)
+{
+	volatile struct ice_ts_desc *ts;
+	uint16_t n;
+	uint16_t ts_id;
+	uint16_t fetch;
+
+	ts_id = txq->tsq.ts_tail;
+	ts = &txq->tsq.ice_ts_ring[ts_id];
+
+	n = (uint16_t)(txq->tsq.nb_ts_desc - ts_id);
+	if (nb_pkts >= n) {
+		ice_vts(ts, tx_pkts, n, txq->tx_tail, txq->nb_tx_desc,
+				txq->tsq.ts_offset);
+		tx_pkts += n;
+		ts += n;
+		tx_tail += n;
+		nb_pkts = (uint16_t)(nb_pkts - n);
+		ts_id = 0;
+		ts = &txq->tsq.ice_ts_ring[ts_id];
+		fetch = txq->tsq.nb_ts_desc - txq->nb_tx_desc;
+		for (; ts_id < fetch; ts_id++, ts++)
+			ice_vts1(ts, *tx_pkts, tx_tail + 1,
+					txq->nb_tx_desc, txq->tsq.ts_offset);
+	}
+
+	ice_vts(ts, tx_pkts, nb_pkts, tx_tail, txq->nb_tx_desc,
+			txq->tsq.ts_offset);
+	ts_id = (uint16_t)(ts_id + nb_pkts);
+
+	return ts_id;
+}
+
 static __rte_always_inline uint16_t
 ice_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 				uint16_t nb_pkts, bool do_offload)
@@ -920,6 +1114,7 @@ ice_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 	volatile struct ice_tx_desc *txdp;
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
+	uint16_t ts_id = -1;
 	uint64_t flags = ICE_TD_CMD;
 	uint64_t rs = ICE_TX_DESC_CMD_RS | ICE_TD_CMD;
 
@@ -940,6 +1135,10 @@ ice_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
 
+	if (txq->tsq.ts_flag > 0)
+		ts_id = ice_xmit_fixed_ts_burst_vec_avx512(txq,
+								tx_pkts, nb_commit, tx_id);
+
 	n = (uint16_t)(txq->nb_tx_desc - tx_id);
 	if (nb_commit >= n) {
 		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
@@ -975,7 +1174,12 @@ ice_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	txq->tx_tail = tx_id;
 
-	ICE_PCI_REG_WC_WRITE(txq->qtx_tail, txq->tx_tail);
+	if (txq->tsq.ts_flag > 0) {
+		ICE_PCI_REG_WC_WRITE(txq->qtx_tail, ts_id);
+		txq->tsq.ts_tail = ts_id;
+	} else {
+		ICE_PCI_REG_WC_WRITE(txq->qtx_tail, txq->tx_tail);
+	}
 
 	return nb_pkts;
 }
-- 
2.43.0

