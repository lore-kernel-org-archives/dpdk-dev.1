Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C7AD2F32A
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:19:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C24E40E30;
	Tue, 13 Jan 2026 16:15:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id CC8E940E0A
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:15:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768317351; x=1799853351;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Eju+xjqfStmNpXgwezVuGyswqOTklvhQ+ViH345ygGs=;
 b=Fw+lvTr1Tg3nfir6kveDLY4/Se/BOfU20VbnyixdMb8uOcGbG39LH/qg
 QNl/nSZ06zG2+1ORwVINaA2+daSUSFHv3AY+ntKs5xVG9Iooc+gY4KQSs
 6kq1X4+vgIPL+z2xoHniHckLDvNA43Vy6PyKToro4s5kKnI3gWe2PnQoK
 Ywv4+XQi6g+Ga4OTD60X6AX5N5AVfw7kCTGkEI9IlZ0eknNpNMRuoguQ5
 4nAyAN1MnvlP7p3Dr5LRx078YRSw5QVmQEy4H2nXEEAzewRHl0qH61GQe
 p6oGjFDG3Jzkg3A2R8lQubnanN66eKELugh3cNEDBLhrRemjey7ulazOV w==;
X-CSE-ConnectionGUID: eC5sdikKSzm6yx2+57/qZQ==
X-CSE-MsgGUID: ta1LwbIfRRi9qx1pbafGIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80969227"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="80969227"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 07:15:51 -0800
X-CSE-ConnectionGUID: OEB+3Py9QTq9rfGH9tL43w==
X-CSE-MsgGUID: ri/MET3eSH+NEVpt7OM9nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="203556659"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 13 Jan 2026 07:15:49 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 29/36] net/intel: merge ring writes in simple Tx for ice
 and i40e
Date: Tue, 13 Jan 2026 15:14:53 +0000
Message-ID: <20260113151505.1871271-30-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113151505.1871271-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260113151505.1871271-1-bruce.richardson@intel.com>
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

The ice and i40e drivers have identical code for writing ring entries in
the simple Tx path, so merge in the descriptor writing code.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx.h                 |  6 ++
 drivers/net/intel/common/tx_scalar_fns.h      | 60 ++++++++++++++
 drivers/net/intel/i40e/i40e_rxtx.c            | 79 +------------------
 drivers/net/intel/i40e/i40e_rxtx.h            |  3 -
 .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |  4 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   |  4 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c |  4 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |  4 +-
 drivers/net/intel/ice/ice_rxtx.c              | 69 +---------------
 drivers/net/intel/ice/ice_rxtx.h              |  2 -
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c     |  4 +-
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c   |  4 +-
 12 files changed, 86 insertions(+), 157 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 2d3626cbda..502b3f2032 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -63,6 +63,12 @@ enum ci_tx_l2tag1_field {
 /* Common maximum data per TX descriptor */
 #define CI_MAX_DATA_PER_TXD     (CI_TXD_QW1_TX_BUF_SZ_M >> CI_TXD_QW1_TX_BUF_SZ_S)
 
+/* Common TX maximum burst size for chunked transmission in simple paths */
+#define CI_TX_MAX_BURST 32
+
+/* Common TX descriptor command flags for simple transmit */
+#define CI_TX_DESC_CMD_DEFAULT (CI_TX_DESC_CMD_ICRC | CI_TX_DESC_CMD_EOP)
+
 /* Checksum offload mask to identify packets requesting offload */
 #define CI_TX_CKSUM_OFFLOAD_MASK (RTE_MBUF_F_TX_IP_CKSUM |		 \
 				   RTE_MBUF_F_TX_L4_MASK |		 \
diff --git a/drivers/net/intel/common/tx_scalar_fns.h b/drivers/net/intel/common/tx_scalar_fns.h
index 3a65797c5f..0d64a63e16 100644
--- a/drivers/net/intel/common/tx_scalar_fns.h
+++ b/drivers/net/intel/common/tx_scalar_fns.h
@@ -12,6 +12,66 @@
 /* depends on common Tx definitions. */
 #include "tx.h"
 
+/* Populate 4 descriptors with data from 4 mbufs */
+static inline void
+ci_tx_fill_hw_ring_tx4(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkts)
+{
+	uint64_t dma_addr;
+	uint32_t i;
+
+	for (i = 0; i < 4; i++, txdp++, pkts++) {
+		dma_addr = rte_mbuf_data_iova(*pkts);
+		txdp->buffer_addr = rte_cpu_to_le_64(dma_addr);
+		txdp->cmd_type_offset_bsz =
+			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DATA |
+				((uint64_t)CI_TX_DESC_CMD_DEFAULT << CI_TXD_QW1_CMD_S) |
+				((uint64_t)(*pkts)->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
+	}
+}
+
+/* Populate 1 descriptor with data from 1 mbuf */
+static inline void
+ci_tx_fill_hw_ring_tx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkts)
+{
+	uint64_t dma_addr;
+
+	dma_addr = rte_mbuf_data_iova(*pkts);
+	txdp->buffer_addr = rte_cpu_to_le_64(dma_addr);
+	txdp->cmd_type_offset_bsz =
+		rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DATA |
+			((uint64_t)CI_TX_DESC_CMD_DEFAULT << CI_TXD_QW1_CMD_S) |
+			((uint64_t)(*pkts)->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
+}
+
+/* Fill hardware descriptor ring with mbuf data */
+static inline void
+ci_tx_fill_hw_ring(struct ci_tx_queue *txq, struct rte_mbuf **pkts,
+		   uint16_t nb_pkts)
+{
+	volatile struct ci_tx_desc *txdp = &txq->ci_tx_ring[txq->tx_tail];
+	struct ci_tx_entry *txep = &txq->sw_ring[txq->tx_tail];
+	const int N_PER_LOOP = 4;
+	const int N_PER_LOOP_MASK = N_PER_LOOP - 1;
+	int mainpart, leftover;
+	int i, j;
+
+	mainpart = nb_pkts & ((uint32_t)~N_PER_LOOP_MASK);
+	leftover = nb_pkts & ((uint32_t)N_PER_LOOP_MASK);
+	for (i = 0; i < mainpart; i += N_PER_LOOP) {
+		for (j = 0; j < N_PER_LOOP; ++j)
+			(txep + i + j)->mbuf = *(pkts + i + j);
+		ci_tx_fill_hw_ring_tx4(txdp + i, pkts + i);
+	}
+
+	if (unlikely(leftover > 0)) {
+		for (i = 0; i < leftover; ++i) {
+			(txep + mainpart + i)->mbuf = *(pkts + mainpart + i);
+			ci_tx_fill_hw_ring_tx1(txdp + mainpart + i,
+					       pkts + mainpart + i);
+		}
+	}
+}
+
 /*
  * Common transmit descriptor cleanup function for Intel drivers.
  * Used by ice, i40e, iavf, and idpf drivers.
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 985d84c0f6..cb91eeeab2 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -311,19 +311,6 @@ i40e_parse_tunneling_params(uint64_t ol_flags,
 		*cd_tunneling |= I40E_TXD_CTX_QW0_L4T_CS_MASK;
 }
 
-/* Construct the tx flags */
-static inline uint64_t
-i40e_build_ctob(uint32_t td_cmd,
-		uint32_t td_offset,
-		unsigned int size,
-		uint32_t td_tag)
-{
-	return rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DATA |
-			((uint64_t)td_cmd  << CI_TXD_QW1_CMD_S) |
-			((uint64_t)td_offset << CI_TXD_QW1_OFFSET_S) |
-			((uint64_t)size  << CI_TXD_QW1_TX_BUF_SZ_S) |
-			((uint64_t)td_tag  << CI_TXD_QW1_L2TAG1_S));
-}
 
 static inline int
 #ifdef RTE_LIBRTE_I40E_RX_ALLOW_BULK_ALLOC
@@ -1079,64 +1066,6 @@ i40e_tx_free_bufs(struct ci_tx_queue *txq)
 	return txq->tx_rs_thresh;
 }
 
-/* Populate 4 descriptors with data from 4 mbufs */
-static inline void
-tx4(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkts)
-{
-	uint64_t dma_addr;
-	uint32_t i;
-
-	for (i = 0; i < 4; i++, txdp++, pkts++) {
-		dma_addr = rte_mbuf_data_iova(*pkts);
-		txdp->buffer_addr = rte_cpu_to_le_64(dma_addr);
-		txdp->cmd_type_offset_bsz =
-			i40e_build_ctob((uint32_t)I40E_TD_CMD, 0,
-					(*pkts)->data_len, 0);
-	}
-}
-
-/* Populate 1 descriptor with data from 1 mbuf */
-static inline void
-tx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkts)
-{
-	uint64_t dma_addr;
-
-	dma_addr = rte_mbuf_data_iova(*pkts);
-	txdp->buffer_addr = rte_cpu_to_le_64(dma_addr);
-	txdp->cmd_type_offset_bsz =
-		i40e_build_ctob((uint32_t)I40E_TD_CMD, 0,
-				(*pkts)->data_len, 0);
-}
-
-/* Fill hardware descriptor ring with mbuf data */
-static inline void
-i40e_tx_fill_hw_ring(struct ci_tx_queue *txq,
-		     struct rte_mbuf **pkts,
-		     uint16_t nb_pkts)
-{
-	volatile struct ci_tx_desc *txdp = &txq->ci_tx_ring[txq->tx_tail];
-	struct ci_tx_entry *txep = &txq->sw_ring[txq->tx_tail];
-	const int N_PER_LOOP = 4;
-	const int N_PER_LOOP_MASK = N_PER_LOOP - 1;
-	int mainpart, leftover;
-	int i, j;
-
-	mainpart = (nb_pkts & ((uint32_t) ~N_PER_LOOP_MASK));
-	leftover = (nb_pkts & ((uint32_t)  N_PER_LOOP_MASK));
-	for (i = 0; i < mainpart; i += N_PER_LOOP) {
-		for (j = 0; j < N_PER_LOOP; ++j) {
-			(txep + i + j)->mbuf = *(pkts + i + j);
-		}
-		tx4(txdp + i, pkts + i);
-	}
-	if (unlikely(leftover > 0)) {
-		for (i = 0; i < leftover; ++i) {
-			(txep + mainpart + i)->mbuf = *(pkts + mainpart + i);
-			tx1(txdp + mainpart + i, pkts + mainpart + i);
-		}
-	}
-}
-
 static inline uint16_t
 tx_xmit_pkts(struct ci_tx_queue *txq,
 	     struct rte_mbuf **tx_pkts,
@@ -1161,7 +1090,7 @@ tx_xmit_pkts(struct ci_tx_queue *txq,
 	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
 	if ((txq->tx_tail + nb_pkts) > txq->nb_tx_desc) {
 		n = (uint16_t)(txq->nb_tx_desc - txq->tx_tail);
-		i40e_tx_fill_hw_ring(txq, tx_pkts, n);
+		ci_tx_fill_hw_ring(txq, tx_pkts, n);
 		txr[txq->tx_next_rs].cmd_type_offset_bsz |=
 			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
 		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
@@ -1169,7 +1098,7 @@ tx_xmit_pkts(struct ci_tx_queue *txq,
 	}
 
 	/* Fill hardware descriptor ring with mbuf data */
-	i40e_tx_fill_hw_ring(txq, tx_pkts + n, (uint16_t)(nb_pkts - n));
+	ci_tx_fill_hw_ring(txq, tx_pkts + n, (uint16_t)(nb_pkts - n));
 	txq->tx_tail = (uint16_t)(txq->tx_tail + (nb_pkts - n));
 
 	/* Determine if RS bit needs to be set */
@@ -1198,13 +1127,13 @@ i40e_xmit_pkts_simple(void *tx_queue,
 {
 	uint16_t nb_tx = 0;
 
-	if (likely(nb_pkts <= I40E_TX_MAX_BURST))
+	if (likely(nb_pkts <= CI_TX_MAX_BURST))
 		return tx_xmit_pkts((struct ci_tx_queue *)tx_queue,
 						tx_pkts, nb_pkts);
 
 	while (nb_pkts) {
 		uint16_t ret, num = (uint16_t)RTE_MIN(nb_pkts,
-						I40E_TX_MAX_BURST);
+						CI_TX_MAX_BURST);
 
 		ret = tx_xmit_pkts((struct ci_tx_queue *)tx_queue,
 						&tx_pkts[nb_tx], num);
diff --git a/drivers/net/intel/i40e/i40e_rxtx.h b/drivers/net/intel/i40e/i40e_rxtx.h
index 307ffa3049..0977342064 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.h
+++ b/drivers/net/intel/i40e/i40e_rxtx.h
@@ -47,9 +47,6 @@
 #define I40E_RX_DESC_EXT_STATUS_FLEXBL_MASK   0x03
 #define I40E_RX_DESC_EXT_STATUS_FLEXBL_FLEX   0x01
 
-#define I40E_TD_CMD (CI_TX_DESC_CMD_ICRC |\
-		     CI_TX_DESC_CMD_EOP)
-
 enum i40e_header_split_mode {
 	i40e_header_split_none = 0,
 	i40e_header_split_enabled = 1,
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
index 4c36748d94..68667bdc9b 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
@@ -476,8 +476,8 @@ i40e_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 	volatile struct ci_tx_desc *txdp;
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
-	uint64_t flags = I40E_TD_CMD;
-	uint64_t rs = CI_TX_DESC_CMD_RS | I40E_TD_CMD;
+	uint64_t flags = CI_TX_DESC_CMD_DEFAULT;
+	uint64_t rs = CI_TX_DESC_CMD_RS | CI_TX_DESC_CMD_DEFAULT;
 	int i;
 
 	if (txq->nb_tx_free < txq->tx_free_thresh)
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
index 502a1842c6..e1672c4371 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
@@ -741,8 +741,8 @@ i40e_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 	volatile struct ci_tx_desc *txdp;
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
-	uint64_t flags = I40E_TD_CMD;
-	uint64_t rs = CI_TX_DESC_CMD_RS | I40E_TD_CMD;
+	uint64_t flags = CI_TX_DESC_CMD_DEFAULT;
+	uint64_t rs = CI_TX_DESC_CMD_RS | CI_TX_DESC_CMD_DEFAULT;
 
 	if (txq->nb_tx_free < txq->tx_free_thresh)
 		ci_tx_free_bufs_vec(txq, i40e_tx_desc_done, false);
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
index d48ff9f51e..bceb95ad2d 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
@@ -801,8 +801,8 @@ i40e_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 	volatile struct ci_tx_desc *txdp;
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
-	uint64_t flags = I40E_TD_CMD;
-	uint64_t rs = CI_TX_DESC_CMD_RS | I40E_TD_CMD;
+	uint64_t flags = CI_TX_DESC_CMD_DEFAULT;
+	uint64_t rs = CI_TX_DESC_CMD_RS | CI_TX_DESC_CMD_DEFAULT;
 
 	if (txq->nb_tx_free < txq->tx_free_thresh)
 		ci_tx_free_bufs_vec(txq, i40e_tx_desc_done, false);
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
index be4c64942e..debc9bda28 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
@@ -626,8 +626,8 @@ i40e_xmit_fixed_burst_vec(void *__rte_restrict tx_queue,
 	volatile struct ci_tx_desc *txdp;
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
-	uint64_t flags = I40E_TD_CMD;
-	uint64_t rs = CI_TX_DESC_CMD_RS | I40E_TD_CMD;
+	uint64_t flags = CI_TX_DESC_CMD_DEFAULT;
+	uint64_t rs = CI_TX_DESC_CMD_RS | CI_TX_DESC_CMD_DEFAULT;
 	int i;
 
 	if (txq->nb_tx_free < txq->tx_free_thresh)
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 7261c07265..5e4391f120 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3271,67 +3271,6 @@ ice_tx_done_cleanup(void *txq, uint32_t free_cnt)
 		return ice_tx_done_cleanup_full(q, free_cnt);
 }
 
-/* Populate 4 descriptors with data from 4 mbufs */
-static inline void
-tx4(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkts)
-{
-	uint64_t dma_addr;
-	uint32_t i;
-
-	for (i = 0; i < 4; i++, txdp++, pkts++) {
-		dma_addr = rte_mbuf_data_iova(*pkts);
-		txdp->buffer_addr = rte_cpu_to_le_64(dma_addr);
-		txdp->cmd_type_offset_bsz =
-			ice_build_ctob((uint32_t)ICE_TD_CMD, 0,
-				       (*pkts)->data_len, 0);
-	}
-}
-
-/* Populate 1 descriptor with data from 1 mbuf */
-static inline void
-tx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkts)
-{
-	uint64_t dma_addr;
-
-	dma_addr = rte_mbuf_data_iova(*pkts);
-	txdp->buffer_addr = rte_cpu_to_le_64(dma_addr);
-	txdp->cmd_type_offset_bsz =
-		ice_build_ctob((uint32_t)ICE_TD_CMD, 0,
-			       (*pkts)->data_len, 0);
-}
-
-static inline void
-ice_tx_fill_hw_ring(struct ci_tx_queue *txq, struct rte_mbuf **pkts,
-		    uint16_t nb_pkts)
-{
-	volatile struct ci_tx_desc *txdp = &txq->ci_tx_ring[txq->tx_tail];
-	struct ci_tx_entry *txep = &txq->sw_ring[txq->tx_tail];
-	const int N_PER_LOOP = 4;
-	const int N_PER_LOOP_MASK = N_PER_LOOP - 1;
-	int mainpart, leftover;
-	int i, j;
-
-	/**
-	 * Process most of the packets in chunks of N pkts.  Any
-	 * leftover packets will get processed one at a time.
-	 */
-	mainpart = nb_pkts & ((uint32_t)~N_PER_LOOP_MASK);
-	leftover = nb_pkts & ((uint32_t)N_PER_LOOP_MASK);
-	for (i = 0; i < mainpart; i += N_PER_LOOP) {
-		/* Copy N mbuf pointers to the S/W ring */
-		for (j = 0; j < N_PER_LOOP; ++j)
-			(txep + i + j)->mbuf = *(pkts + i + j);
-		tx4(txdp + i, pkts + i);
-	}
-
-	if (unlikely(leftover > 0)) {
-		for (i = 0; i < leftover; ++i) {
-			(txep + mainpart + i)->mbuf = *(pkts + mainpart + i);
-			tx1(txdp + mainpart + i, pkts + mainpart + i);
-		}
-	}
-}
-
 static inline uint16_t
 tx_xmit_pkts(struct ci_tx_queue *txq,
 	     struct rte_mbuf **tx_pkts,
@@ -3356,7 +3295,7 @@ tx_xmit_pkts(struct ci_tx_queue *txq,
 	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
 	if ((txq->tx_tail + nb_pkts) > txq->nb_tx_desc) {
 		n = (uint16_t)(txq->nb_tx_desc - txq->tx_tail);
-		ice_tx_fill_hw_ring(txq, tx_pkts, n);
+		ci_tx_fill_hw_ring(txq, tx_pkts, n);
 		txr[txq->tx_next_rs].cmd_type_offset_bsz |=
 			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
 		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
@@ -3364,7 +3303,7 @@ tx_xmit_pkts(struct ci_tx_queue *txq,
 	}
 
 	/* Fill hardware descriptor ring with mbuf data */
-	ice_tx_fill_hw_ring(txq, tx_pkts + n, (uint16_t)(nb_pkts - n));
+	ci_tx_fill_hw_ring(txq, tx_pkts + n, (uint16_t)(nb_pkts - n));
 	txq->tx_tail = (uint16_t)(txq->tx_tail + (nb_pkts - n));
 
 	/* Determine if RS bit needs to be set */
@@ -3393,13 +3332,13 @@ ice_xmit_pkts_simple(void *tx_queue,
 {
 	uint16_t nb_tx = 0;
 
-	if (likely(nb_pkts <= ICE_TX_MAX_BURST))
+	if (likely(nb_pkts <= CI_TX_MAX_BURST))
 		return tx_xmit_pkts((struct ci_tx_queue *)tx_queue,
 				    tx_pkts, nb_pkts);
 
 	while (nb_pkts) {
 		uint16_t ret, num = (uint16_t)RTE_MIN(nb_pkts,
-						      ICE_TX_MAX_BURST);
+						      CI_TX_MAX_BURST);
 
 		ret = tx_xmit_pkts((struct ci_tx_queue *)tx_queue,
 				   &tx_pkts[nb_tx], num);
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index cd5fa93d1c..ddcd012e8b 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -46,8 +46,6 @@
 
 #define ICE_SUPPORT_CHAIN_NUM 5
 
-#define ICE_TD_CMD                      CI_TX_DESC_CMD_EOP
-
 #define ICE_VPMD_RX_BURST            CI_VPMD_RX_BURST
 #define ICE_VPMD_TX_BURST            32
 #define ICE_VPMD_RXQ_REARM_THRESH    CI_VPMD_RX_REARM_THRESH
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
index 2922671158..d03f2e5b36 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
@@ -845,8 +845,8 @@ ice_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 	volatile struct ci_tx_desc *txdp;
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
-	uint64_t flags = ICE_TD_CMD;
-	uint64_t rs = CI_TX_DESC_CMD_RS | ICE_TD_CMD;
+	uint64_t flags = CI_TX_DESC_CMD_DEFAULT;
+	uint64_t rs = CI_TX_DESC_CMD_RS | CI_TX_DESC_CMD_DEFAULT;
 
 	/* cross rx_thresh boundary is not allowed */
 	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
index e64b6e227b..004c01054a 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
@@ -909,8 +909,8 @@ ice_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 	volatile struct ci_tx_desc *txdp;
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
-	uint64_t flags = ICE_TD_CMD;
-	uint64_t rs = CI_TX_DESC_CMD_RS | ICE_TD_CMD;
+	uint64_t flags = CI_TX_DESC_CMD_DEFAULT;
+	uint64_t rs = CI_TX_DESC_CMD_RS | CI_TX_DESC_CMD_DEFAULT;
 
 	/* cross rx_thresh boundary is not allowed */
 	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
-- 
2.51.0

