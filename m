Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64817C7115B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 13:37:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFDCD42E7F;
	Thu, 19 Jun 2025 15:37:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 04C1242E86
 for <dev@dpdk.org>; Thu, 19 Jun 2025 15:37:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750340244; x=1781876244;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KeJMJ2WVEDDZkDWwNwdX1dmy0PX11dr5ucmbwpvQGus=;
 b=DAc9uvHjIxVuRdqlqs/ALORPzgI4N7LaxTllN+41RFdApzbTnZ8RthtW
 E6IyeNcEA2y74DHqJ2Cug8FnrIzjT/K/y/Busfbm5JG0xNbBGa81p18k/
 hzQRVaNWh5uYmH0QXDJdJ4b7YG5Y+9XhQZRDhbvyuAaW+0nJ6YhGQeP/9
 uxEJdnRRPX3Zu9eT1diZqEaoGPN/yW+rm0ttf0bCxYg8mXfPjXZ5ZDcIJ
 baNAqfv/86Dz+nR9Ftc3hEKIAeCYIPL8M9LN1riUNu2viX485rkpgQkvj
 94PIr0JMTA/NAkWZQnt6MhA43n/fVUHBYK0WVEjGacfqLIsLGISTvkn0b g==;
X-CSE-ConnectionGUID: mAKbm7V8QiiOl2dqRpFJWA==
X-CSE-MsgGUID: 1OTSBPKmSCCB3Meephkwdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52684343"
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; d="scan'208";a="52684343"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2025 06:37:23 -0700
X-CSE-ConnectionGUID: mio3RruZTpa3ykhOd/1bTg==
X-CSE-MsgGUID: bvtTaZEiRomajMcW5yhraQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; d="scan'208";a="187867145"
Received: from silpixa00401177.ir.intel.com (HELO vm177..) ([10.237.213.77])
 by orviesa001.jf.intel.com with ESMTP; 19 Jun 2025 06:37:22 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com,
	Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 3/3] net/iavf: support vlan insertion offload for the avx-512
 path
Date: Thu, 19 Jun 2025 13:36:58 +0000
Message-Id: <20250619133658.13494-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250619133658.13494-1-ciara.loftus@intel.com>
References: <20250619133658.13494-1-ciara.loftus@intel.com>
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

Re-enable support for VLAN insertion and implement support for QinQ
insertion on the iavf avx-512 transmit path.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx.h            |  6 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   | 24 +++----
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 62 ++++++++++++++-----
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 17 ++++-
 4 files changed, 76 insertions(+), 33 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 0b5d67e718..d04722a5ed 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -30,8 +30,6 @@
 #define IAVF_VPMD_TX_MAX_FREE_BUF 64
 
 #define IAVF_TX_NO_VECTOR_FLAGS (				 \
-		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |		 \
-		RTE_ETH_TX_OFFLOAD_QINQ_INSERT |		 \
 		RTE_ETH_TX_OFFLOAD_MULTI_SEGS |		 \
 		RTE_ETH_TX_OFFLOAD_TCP_TSO |		 \
 		RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |	 \
@@ -48,7 +46,9 @@
 
 #define IAVF_TX_VECTOR_OFFLOAD_CTX (			\
 		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |	\
-		RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM)
+		RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |	\
+		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |	\
+		RTE_ETH_TX_OFFLOAD_QINQ_INSERT)
 
 #define IAVF_RX_VECTOR_OFFLOAD (				 \
 		RTE_ETH_RX_OFFLOAD_CHECKSUM |		 \
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index 88e35dc3e9..d08a3ac269 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -1649,14 +1649,14 @@ iavf_recv_scattered_pkts_vec_avx2_flex_rxd_offload(void *rx_queue,
 
 static __rte_always_inline void
 iavf_vtx1(volatile struct iavf_tx_desc *txdp,
-	  struct rte_mbuf *pkt, uint64_t flags, bool offload)
+	  struct rte_mbuf *pkt, uint64_t flags, bool offload, uint8_t vlan_flag)
 {
 	uint64_t high_qw =
 		(IAVF_TX_DESC_DTYPE_DATA |
 		 ((uint64_t)flags  << IAVF_TXD_QW1_CMD_SHIFT) |
 		 ((uint64_t)pkt->data_len << IAVF_TXD_QW1_TX_BUF_SZ_SHIFT));
 	if (offload)
-		iavf_txd_enable_offload(pkt, &high_qw);
+		iavf_txd_enable_offload(pkt, &high_qw, vlan_flag);
 
 	__m128i descriptor = _mm_set_epi64x(high_qw,
 				pkt->buf_iova + pkt->data_off);
@@ -1665,14 +1665,14 @@ iavf_vtx1(volatile struct iavf_tx_desc *txdp,
 
 static __rte_always_inline void
 iavf_vtx(volatile struct iavf_tx_desc *txdp,
-	 struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags, bool offload)
+	 struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags, bool offload, uint8_t vlan_flag)
 {
 	const uint64_t hi_qw_tmpl = (IAVF_TX_DESC_DTYPE_DATA |
 			((uint64_t)flags  << IAVF_TXD_QW1_CMD_SHIFT));
 
 	/* if unaligned on 32-bit boundary, do one to align */
 	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
-		iavf_vtx1(txdp, *pkt, flags, offload);
+		iavf_vtx1(txdp, *pkt, flags, offload, vlan_flag);
 		nb_pkts--, txdp++, pkt++;
 	}
 
@@ -1683,25 +1683,25 @@ iavf_vtx(volatile struct iavf_tx_desc *txdp,
 			((uint64_t)pkt[3]->data_len <<
 			 IAVF_TXD_QW1_TX_BUF_SZ_SHIFT);
 		if (offload)
-			iavf_txd_enable_offload(pkt[3], &hi_qw3);
+			iavf_txd_enable_offload(pkt[3], &hi_qw3, vlan_flag);
 		uint64_t hi_qw2 =
 			hi_qw_tmpl |
 			((uint64_t)pkt[2]->data_len <<
 			 IAVF_TXD_QW1_TX_BUF_SZ_SHIFT);
 		if (offload)
-			iavf_txd_enable_offload(pkt[2], &hi_qw2);
+			iavf_txd_enable_offload(pkt[2], &hi_qw2, vlan_flag);
 		uint64_t hi_qw1 =
 			hi_qw_tmpl |
 			((uint64_t)pkt[1]->data_len <<
 			 IAVF_TXD_QW1_TX_BUF_SZ_SHIFT);
 		if (offload)
-			iavf_txd_enable_offload(pkt[1], &hi_qw1);
+			iavf_txd_enable_offload(pkt[1], &hi_qw1, vlan_flag);
 		uint64_t hi_qw0 =
 			hi_qw_tmpl |
 			((uint64_t)pkt[0]->data_len <<
 			 IAVF_TXD_QW1_TX_BUF_SZ_SHIFT);
 		if (offload)
-			iavf_txd_enable_offload(pkt[0], &hi_qw0);
+			iavf_txd_enable_offload(pkt[0], &hi_qw0, vlan_flag);
 
 		__m256i desc2_3 =
 			_mm256_set_epi64x
@@ -1721,7 +1721,7 @@ iavf_vtx(volatile struct iavf_tx_desc *txdp,
 
 	/* do any last ones */
 	while (nb_pkts) {
-		iavf_vtx1(txdp, *pkt, flags, offload);
+		iavf_vtx1(txdp, *pkt, flags, offload, vlan_flag);
 		txdp++, pkt++, nb_pkts--;
 	}
 }
@@ -1756,11 +1756,11 @@ iavf_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 	if (nb_commit >= n) {
 		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
 
-		iavf_vtx(txdp, tx_pkts, n - 1, flags, offload);
+		iavf_vtx(txdp, tx_pkts, n - 1, flags, offload, txq->vlan_flag);
 		tx_pkts += (n - 1);
 		txdp += (n - 1);
 
-		iavf_vtx1(txdp, *tx_pkts++, rs, offload);
+		iavf_vtx1(txdp, *tx_pkts++, rs, offload, txq->vlan_flag);
 
 		nb_commit = (uint16_t)(nb_commit - n);
 
@@ -1774,7 +1774,7 @@ iavf_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
 
-	iavf_vtx(txdp, tx_pkts, nb_commit, flags, offload);
+	iavf_vtx(txdp, tx_pkts, nb_commit, flags, offload, txq->vlan_flag);
 
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index f2af028bef..ad21ada440 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -1853,14 +1853,14 @@ tx_backlog_entry_avx512(struct ci_tx_entry_vec *txep,
 static __rte_always_inline void
 iavf_vtx1(volatile struct iavf_tx_desc *txdp,
 	  struct rte_mbuf *pkt, uint64_t flags,
-	  bool offload)
+	  bool offload, uint8_t vlan_flag)
 {
 	uint64_t high_qw =
 		(IAVF_TX_DESC_DTYPE_DATA |
 		 ((uint64_t)flags  << IAVF_TXD_QW1_CMD_SHIFT) |
 		 ((uint64_t)pkt->data_len << IAVF_TXD_QW1_TX_BUF_SZ_SHIFT));
 	if (offload)
-		iavf_txd_enable_offload(pkt, &high_qw);
+		iavf_txd_enable_offload(pkt, &high_qw, vlan_flag);
 
 	__m128i descriptor = _mm_set_epi64x(high_qw,
 					    pkt->buf_iova + pkt->data_off);
@@ -1872,14 +1872,14 @@ iavf_vtx1(volatile struct iavf_tx_desc *txdp,
 static __rte_always_inline void
 iavf_vtx(volatile struct iavf_tx_desc *txdp,
 		struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags,
-		bool offload)
+		bool offload, uint8_t vlan_flag)
 {
 	const uint64_t hi_qw_tmpl = (IAVF_TX_DESC_DTYPE_DATA |
 			((uint64_t)flags  << IAVF_TXD_QW1_CMD_SHIFT));
 
 	/* if unaligned on 32-bit boundary, do one to align */
 	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
-		iavf_vtx1(txdp, *pkt, flags, offload);
+		iavf_vtx1(txdp, *pkt, flags, offload, vlan_flag);
 		nb_pkts--, txdp++, pkt++;
 	}
 
@@ -1902,10 +1902,10 @@ iavf_vtx(volatile struct iavf_tx_desc *txdp,
 			((uint64_t)pkt[0]->data_len <<
 			 IAVF_TXD_QW1_TX_BUF_SZ_SHIFT);
 		if (offload) {
-			iavf_txd_enable_offload(pkt[3], &hi_qw3);
-			iavf_txd_enable_offload(pkt[2], &hi_qw2);
-			iavf_txd_enable_offload(pkt[1], &hi_qw1);
-			iavf_txd_enable_offload(pkt[0], &hi_qw0);
+			iavf_txd_enable_offload(pkt[3], &hi_qw3, vlan_flag);
+			iavf_txd_enable_offload(pkt[2], &hi_qw2, vlan_flag);
+			iavf_txd_enable_offload(pkt[1], &hi_qw1, vlan_flag);
+			iavf_txd_enable_offload(pkt[0], &hi_qw0, vlan_flag);
 		}
 
 		__m512i desc0_3 =
@@ -1923,7 +1923,7 @@ iavf_vtx(volatile struct iavf_tx_desc *txdp,
 
 	/* do any last ones */
 	while (nb_pkts) {
-		iavf_vtx1(txdp, *pkt, flags, offload);
+		iavf_vtx1(txdp, *pkt, flags, offload, vlan_flag);
 		txdp++, pkt++, nb_pkts--;
 	}
 }
@@ -2101,7 +2101,7 @@ ctx_vtx1(volatile struct iavf_tx_desc *txdp, struct rte_mbuf *pkt,
 				((uint64_t)flags  << IAVF_TXD_QW1_CMD_SHIFT) |
 				((uint64_t)pkt->data_len << IAVF_TXD_QW1_TX_BUF_SZ_SHIFT));
 	if (offload)
-		iavf_txd_enable_offload(pkt, &high_data_qw);
+		iavf_txd_enable_offload(pkt, &high_data_qw, vlan_flag);
 
 	__m256i ctx_data_desc = _mm256_set_epi64x(high_data_qw, pkt->buf_iova + pkt->data_off,
 							high_ctx_qw, low_ctx_qw);
@@ -2149,6 +2149,22 @@ ctx_vtx(volatile struct iavf_tx_desc *txdp,
 					(uint64_t)pkt[1]->vlan_tci << IAVF_TXD_QW1_L2TAG1_SHIFT;
 			}
 		}
+		if (pkt[1]->ol_flags & RTE_MBUF_F_TX_QINQ) {
+			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
+			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
+				/* Inner tag at L2TAG2, outer tag at L2TAG1. */
+				low_ctx_qw1 |= (uint64_t)pkt[1]->vlan_tci <<
+							IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
+				hi_data_qw1 |= (uint64_t)pkt[1]->vlan_tci_outer <<
+							IAVF_TXD_QW1_L2TAG1_SHIFT;
+			} else {
+				/* Outer tag at L2TAG2, inner tag at L2TAG1. */
+				low_ctx_qw1 |= (uint64_t)pkt[1]->vlan_tci_outer <<
+							IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
+				hi_data_qw1 |= (uint64_t)pkt[1]->vlan_tci <<
+							IAVF_TXD_QW1_L2TAG1_SHIFT;
+			}
+		}
 		if (IAVF_CHECK_TX_LLDP(pkt[1]))
 			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
 				<< IAVF_TXD_CTX_QW1_CMD_SHIFT;
@@ -2164,13 +2180,29 @@ ctx_vtx(volatile struct iavf_tx_desc *txdp,
 					(uint64_t)pkt[0]->vlan_tci << IAVF_TXD_QW1_L2TAG1_SHIFT;
 			}
 		}
+		if (pkt[0]->ol_flags & RTE_MBUF_F_TX_QINQ) {
+			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
+			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
+				/* Inner tag at L2TAG2, outer tag at L2TAG1. */
+				low_ctx_qw0 |= (uint64_t)pkt[0]->vlan_tci <<
+							IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
+				hi_data_qw0 |= (uint64_t)pkt[0]->vlan_tci_outer <<
+							IAVF_TXD_QW1_L2TAG1_SHIFT;
+			} else {
+				/* Outer tag at L2TAG2, inner tag at L2TAG1. */
+				low_ctx_qw0 |= (uint64_t)pkt[0]->vlan_tci_outer <<
+							IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
+				hi_data_qw0 |= (uint64_t)pkt[0]->vlan_tci <<
+							IAVF_TXD_QW1_L2TAG1_SHIFT;
+			}
+		}
 		if (IAVF_CHECK_TX_LLDP(pkt[0]))
 			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
 				<< IAVF_TXD_CTX_QW1_CMD_SHIFT;
 
 		if (offload) {
-			iavf_txd_enable_offload(pkt[1], &hi_data_qw1);
-			iavf_txd_enable_offload(pkt[0], &hi_data_qw0);
+			iavf_txd_enable_offload(pkt[1], &hi_data_qw1, vlan_flag);
+			iavf_txd_enable_offload(pkt[0], &hi_data_qw0, vlan_flag);
 			iavf_fill_ctx_desc_tunnelling_field(&low_ctx_qw1, pkt[1]);
 			iavf_fill_ctx_desc_tunnelling_field(&low_ctx_qw0, pkt[0]);
 		}
@@ -2219,11 +2251,11 @@ iavf_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 	if (nb_commit >= n) {
 		tx_backlog_entry_avx512(txep, tx_pkts, n);
 
-		iavf_vtx(txdp, tx_pkts, n - 1, flags, offload);
+		iavf_vtx(txdp, tx_pkts, n - 1, flags, offload, txq->vlan_flag);
 		tx_pkts += (n - 1);
 		txdp += (n - 1);
 
-		iavf_vtx1(txdp, *tx_pkts++, rs, offload);
+		iavf_vtx1(txdp, *tx_pkts++, rs, offload, txq->vlan_flag);
 
 		nb_commit = (uint16_t)(nb_commit - n);
 
@@ -2238,7 +2270,7 @@ iavf_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	tx_backlog_entry_avx512(txep, tx_pkts, nb_commit);
 
-	iavf_vtx(txdp, tx_pkts, nb_commit, flags, offload);
+	iavf_vtx(txdp, tx_pkts, nb_commit, flags, offload, txq->vlan_flag);
 
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
index 38e9a206d9..68b694b39e 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
@@ -99,7 +99,8 @@ iavf_tx_vec_queue_default(struct ci_tx_queue *txq)
 	 */
 	if (txq->offloads & (IAVF_TX_VECTOR_OFFLOAD | IAVF_TX_VECTOR_OFFLOAD_CTX)) {
 		if (txq->offloads & IAVF_TX_VECTOR_OFFLOAD_CTX) {
-			if (txq->vlan_flag == IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
+			if (txq->vlan_flag == IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ||
+					txq->offloads & RTE_ETH_TX_OFFLOAD_QINQ_INSERT) {
 				txq->use_ctx = 1;
 				return IAVF_VECTOR_CTX_OFFLOAD_PATH;
 			} else {
@@ -167,7 +168,7 @@ iavf_tx_vec_dev_check_default(struct rte_eth_dev *dev)
 
 static __rte_always_inline void
 iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
-			uint64_t *txd_hi)
+			uint64_t *txd_hi, uint8_t vlan_flag)
 {
 #if defined(IAVF_TX_CSUM_OFFLOAD) || defined(IAVF_TX_VLAN_QINQ_OFFLOAD)
 	uint64_t ol_flags = tx_pkt->ol_flags;
@@ -228,11 +229,21 @@ iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
 #endif
 
 #ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
-	if (ol_flags & (RTE_MBUF_F_TX_VLAN | RTE_MBUF_F_TX_QINQ)) {
+	if (ol_flags & RTE_MBUF_F_TX_VLAN && vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) {
 		td_cmd |= IAVF_TX_DESC_CMD_IL2TAG1;
 		*txd_hi |= ((uint64_t)tx_pkt->vlan_tci <<
 			    IAVF_TXD_QW1_L2TAG1_SHIFT);
 	}
+
+	if (ol_flags & RTE_MBUF_F_TX_QINQ) {
+		td_cmd |= IAVF_TX_DESC_CMD_IL2TAG1;
+		if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1)
+			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci <<
+					IAVF_TXD_QW1_L2TAG1_SHIFT);
+		else
+			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci_outer <<
+					IAVF_TXD_QW1_L2TAG1_SHIFT);
+	}
 #endif
 
 	*txd_hi |= ((uint64_t)td_cmd) << IAVF_TXD_QW1_CMD_SHIFT;
-- 
2.34.1

