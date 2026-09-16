Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D197CC88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 10:36:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64787427D7;
	Wed, 16 Sep 2026 12:36:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id C8CEC427D7
 for <dev@dpdk.org>; Wed, 16 Sep 2026 12:36:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789554993; x=1821090993;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xTF3e7S/O9eLi/9O387PRIIjEPCd14hpbpm2/kZUIQU=;
 b=Fcm10SUHEPb7XFnoAe+NH5RxrapF0Ev78EDrXWpzDMSX+r9faY8p98Sy
 8G6lLgj9H7Mj6auWnvlheWxdUaqn+V9hTbn9otLAfIRsj6LVrZXxCQbzi
 9qywXZilbARDNh82irr9SCxx0bWq19B5ItZF4wITGXA6svCzeccr0ws6Q
 svS7F2ErFfUbROsXnuKPv+2GIH1qWfqMlRW0gw7Jqw7aujx2BA41huiiQ
 519uQSmg1/3pKpjz3PJqUpqokaelWh32+lfZvD9BoYVg2gd+IQp6OWvvW
 JYC4LLNpI9oJ4eiudm/299su6HUPJS23Wyaj/MiypdTtASAAHO+Wj0tbJ A==;
X-CSE-ConnectionGUID: 1iddspPqRrqOL+HifQrONQ==
X-CSE-MsgGUID: n5hc6ZTnTxys4YpdRyaA4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89867624"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89867624"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 03:36:32 -0700
X-CSE-ConnectionGUID: WsoLkRz4RgOGN+acltKuLA==
X-CSE-MsgGUID: o3A6bscvRSOFmsX/H/hc7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1528141"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa012.fm.intel.com with ESMTP; 16 Sep 2026 03:36:30 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 03/15] net/iavf: use separate params for VLAN and QinQ
 position
Date: Wed, 16 Sep 2026 11:36:10 +0100
Message-ID: <20260916103622.319874-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916103622.319874-1-bruce.richardson@intel.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260916103622.319874-1-bruce.richardson@intel.com>
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

Like is the case with the scalar path, use separate offload parameters
for the vector path to distinguish between the position of the single
VLAN tag and the QinQ outer tag. With iavf these are currently always
the same, but other drivers - with whom we may want to share code - have
different positions for these.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   | 64 +++++++++++--------
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 62 ++++++++++--------
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 11 ++--
 3 files changed, 77 insertions(+), 60 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index 9b62ef53d3..2aaa713702 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -1619,13 +1619,14 @@ iavf_recv_scattered_pkts_vec_avx2_flex_rxd_offload(void *rx_queue,
 
 static __rte_always_inline void
 iavf_vtx1(volatile struct ci_tx_desc *txdp,
-	  struct rte_mbuf *pkt, uint64_t flags, bool offload, uint8_t vlan_flag)
+	  struct rte_mbuf *pkt, uint64_t flags, bool offload,
+	  enum ci_l2tag_pos single_vlan_pos, enum ci_l2tag_pos qinq_outer_pos)
 {
 	uint64_t high_qw = (CI_TX_DESC_DTYPE_DATA |
 		 ((uint64_t)flags << CI_TXD_QW1_CMD_S) |
 		 ((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
 	if (offload)
-		iavf_txd_enable_offload(pkt, &high_qw, vlan_flag);
+		iavf_txd_enable_offload(pkt, &high_qw, single_vlan_pos, qinq_outer_pos);
 
 	__m128i descriptor = _mm_set_epi64x(high_qw,
 				pkt->buf_iova + pkt->data_off);
@@ -1634,13 +1635,14 @@ iavf_vtx1(volatile struct ci_tx_desc *txdp,
 
 static __rte_always_inline void
 iavf_vtx(volatile struct ci_tx_desc *txdp,
-	 struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags, bool offload, uint8_t vlan_flag)
+	 struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags, bool offload,
+	 enum ci_l2tag_pos single_vlan_pos, enum ci_l2tag_pos qinq_outer_pos)
 {
 	const uint64_t hi_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags << CI_TXD_QW1_CMD_S));
 
 	/* if unaligned on 32-bit boundary, do one to align */
 	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
-		iavf_vtx1(txdp, *pkt, flags, offload, vlan_flag);
+		iavf_vtx1(txdp, *pkt, flags, offload, single_vlan_pos, qinq_outer_pos);
 		nb_pkts--; txdp++; pkt++;
 	}
 
@@ -1649,19 +1651,19 @@ iavf_vtx(volatile struct ci_tx_desc *txdp,
 		uint64_t hi_qw3 = hi_qw_tmpl |
 			((uint64_t)pkt[3]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 		if (offload)
-			iavf_txd_enable_offload(pkt[3], &hi_qw3, vlan_flag);
+			iavf_txd_enable_offload(pkt[3], &hi_qw3, single_vlan_pos, qinq_outer_pos);
 		uint64_t hi_qw2 = hi_qw_tmpl |
 			((uint64_t)pkt[2]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 		if (offload)
-			iavf_txd_enable_offload(pkt[2], &hi_qw2, vlan_flag);
+			iavf_txd_enable_offload(pkt[2], &hi_qw2, single_vlan_pos, qinq_outer_pos);
 		uint64_t hi_qw1 = hi_qw_tmpl |
 			((uint64_t)pkt[1]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 		if (offload)
-			iavf_txd_enable_offload(pkt[1], &hi_qw1, vlan_flag);
+			iavf_txd_enable_offload(pkt[1], &hi_qw1, single_vlan_pos, qinq_outer_pos);
 		uint64_t hi_qw0 = hi_qw_tmpl |
 			((uint64_t)pkt[0]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 		if (offload)
-			iavf_txd_enable_offload(pkt[0], &hi_qw0, vlan_flag);
+			iavf_txd_enable_offload(pkt[0], &hi_qw0, single_vlan_pos, qinq_outer_pos);
 
 		__m256i desc2_3 =
 			_mm256_set_epi64x
@@ -1681,7 +1683,7 @@ iavf_vtx(volatile struct ci_tx_desc *txdp,
 
 	/* do any last ones */
 	while (nb_pkts) {
-		iavf_vtx1(txdp, *pkt, flags, offload, vlan_flag);
+		iavf_vtx1(txdp, *pkt, flags, offload, single_vlan_pos, qinq_outer_pos);
 		txdp++; pkt++; nb_pkts--;
 	}
 }
@@ -1697,6 +1699,9 @@ iavf_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 	/* bit2 is reserved and must be set to 1 according to Spec */
 	uint64_t flags = CI_TX_DESC_CMD_EOP | CI_TX_DESC_CMD_ICRC;
 	uint64_t rs = CI_TX_DESC_CMD_RS | flags;
+	/* vlan_flag gives both the single-VLAN and the QinQ outer tag position */
+	enum ci_l2tag_pos vlan_pos = (txq->vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) ?
+			CI_TAG_IN_DATA_DESC : CI_TAG_IN_CTX_DESC;
 
 	if (txq->nb_tx_free < txq->tx_free_thresh)
 		ci_tx_free_bufs_vec(txq, iavf_tx_desc_done, false);
@@ -1716,11 +1721,11 @@ iavf_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 	if (nb_commit >= n) {
 		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
 
-		iavf_vtx(txdp, tx_pkts, n - 1, flags, offload, txq->vlan_flag);
+		iavf_vtx(txdp, tx_pkts, n - 1, flags, offload, vlan_pos, vlan_pos);
 		tx_pkts += (n - 1);
 		txdp += (n - 1);
 
-		iavf_vtx1(txdp, *tx_pkts++, rs, offload, txq->vlan_flag);
+		iavf_vtx1(txdp, *tx_pkts++, rs, offload, vlan_pos, vlan_pos);
 
 		nb_commit = (uint16_t)(nb_commit - n);
 
@@ -1734,7 +1739,7 @@ iavf_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
 
-	iavf_vtx(txdp, tx_pkts, nb_commit, flags, offload, txq->vlan_flag);
+	iavf_vtx(txdp, tx_pkts, nb_commit, flags, offload, vlan_pos, vlan_pos);
 
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
@@ -1903,7 +1908,8 @@ iavf_fill_ctx_desc_tunneling_field(volatile uint64_t *qw0,
 
 static __rte_always_inline void
 ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
-		uint64_t flags, bool offload, uint8_t vlan_flag, bool ptype_lldp_enabled)
+		uint64_t flags, bool offload, enum ci_l2tag_pos single_vlan_pos,
+		enum ci_l2tag_pos qinq_outer_pos, bool ptype_lldp_enabled)
 {
 	uint64_t high_ctx_qw = IAVF_TX_DESC_DTYPE_CONTEXT;
 	uint64_t low_ctx_qw = 0;
@@ -1911,13 +1917,13 @@ ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 	if (offload) {
 		iavf_fill_ctx_desc_tunneling_avx2(&low_ctx_qw, pkt);
 		if (pkt->ol_flags & RTE_MBUF_F_TX_QINQ) {
-			uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
+			uint64_t qinq_tag = qinq_outer_pos == CI_TAG_IN_CTX_DESC ?
 				(uint64_t)pkt->vlan_tci_outer :
 				(uint64_t)pkt->vlan_tci;
 			high_ctx_qw |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
 			low_ctx_qw |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 		} else if ((pkt->ol_flags & RTE_MBUF_F_TX_VLAN) &&
-				vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
+				single_vlan_pos == CI_TAG_IN_CTX_DESC) {
 			high_ctx_qw |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
 			low_ctx_qw |= (uint64_t)pkt->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 		}
@@ -1928,7 +1934,7 @@ ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 				((uint64_t)flags  << IAVF_TXD_QW1_CMD_SHIFT) |
 				((uint64_t)pkt->data_len << IAVF_TXD_QW1_TX_BUF_SZ_SHIFT));
 	if (offload)
-		iavf_txd_enable_offload(pkt, &high_data_qw, vlan_flag);
+		iavf_txd_enable_offload(pkt, &high_data_qw, single_vlan_pos, qinq_outer_pos);
 
 	__m256i ctx_data_desc = _mm256_set_epi64x(high_data_qw, pkt->buf_iova + pkt->data_off,
 							high_ctx_qw, low_ctx_qw);
@@ -1940,7 +1946,8 @@ ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 static __rte_always_inline void
 ctx_vtx(volatile struct ci_tx_desc *txdp,
 		struct rte_mbuf **pkt, uint16_t nb_pkts, uint64_t flags,
-		bool offload, uint8_t vlan_flag, bool ptype_lldp_enabled)
+		bool offload, enum ci_l2tag_pos single_vlan_pos, enum ci_l2tag_pos qinq_outer_pos,
+		bool ptype_lldp_enabled)
 {
 	uint64_t hi_data_qw_tmpl = (IAVF_TX_DESC_DTYPE_DATA |
 					((uint64_t)flags  << IAVF_TXD_QW1_CMD_SHIFT));
@@ -1964,14 +1971,14 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 			/* tunnel fill assigns low_ctx_qw1; must run before QinQ/VLAN OR below */
 			iavf_fill_ctx_desc_tunneling_field(&low_ctx_qw1, pkt[1]);
 			if (pkt[1]->ol_flags & RTE_MBUF_F_TX_QINQ) {
-				uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
+				uint64_t qinq_tag = qinq_outer_pos == CI_TAG_IN_CTX_DESC ?
 					(uint64_t)pkt[1]->vlan_tci_outer :
 					(uint64_t)pkt[1]->vlan_tci;
 				hi_ctx_qw1 |= IAVF_TX_CTX_DESC_IL2TAG2 <<
 						IAVF_TXD_CTX_QW1_CMD_SHIFT;
 				low_ctx_qw1 |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 			} else if (pkt[1]->ol_flags & RTE_MBUF_F_TX_VLAN &&
-					vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
+					single_vlan_pos == CI_TAG_IN_CTX_DESC) {
 				hi_ctx_qw1 |=
 					IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
 				low_ctx_qw1 |=
@@ -1985,14 +1992,14 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 			/* tunnel fill assigns low_ctx_qw0; must run before QinQ/VLAN OR below */
 			iavf_fill_ctx_desc_tunneling_field(&low_ctx_qw0, pkt[0]);
 			if (pkt[0]->ol_flags & RTE_MBUF_F_TX_QINQ) {
-				uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
+				uint64_t qinq_tag = qinq_outer_pos == CI_TAG_IN_CTX_DESC ?
 					(uint64_t)pkt[0]->vlan_tci_outer :
 					(uint64_t)pkt[0]->vlan_tci;
 				hi_ctx_qw0 |= IAVF_TX_CTX_DESC_IL2TAG2 <<
 						IAVF_TXD_CTX_QW1_CMD_SHIFT;
 				low_ctx_qw0 |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 			} else if (pkt[0]->ol_flags & RTE_MBUF_F_TX_VLAN &&
-					vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
+					single_vlan_pos == CI_TAG_IN_CTX_DESC) {
 				hi_ctx_qw0 |=
 					IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
 				low_ctx_qw0 |=
@@ -2003,8 +2010,8 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << IAVF_TXD_CTX_QW1_CMD_SHIFT;
 
 		if (offload) {
-			iavf_txd_enable_offload(pkt[1], &hi_data_qw1, vlan_flag);
-			iavf_txd_enable_offload(pkt[0], &hi_data_qw0, vlan_flag);
+			iavf_txd_enable_offload(pkt[1], &hi_data_qw1, single_vlan_pos, qinq_outer_pos);
+			iavf_txd_enable_offload(pkt[0], &hi_data_qw0, single_vlan_pos, qinq_outer_pos);
 		}
 
 		__m256i desc2_3 =
@@ -2020,7 +2027,7 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 	}
 
 	if (nb_pkts)
-		ctx_vtx1(txdp, *pkt, flags, offload, vlan_flag, ptype_lldp_enabled);
+		ctx_vtx1(txdp, *pkt, flags, offload, single_vlan_pos, qinq_outer_pos, ptype_lldp_enabled);
 }
 
 static __rte_always_inline uint16_t
@@ -2035,6 +2042,9 @@ iavf_xmit_fixed_burst_vec_avx2_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 	uint64_t flags = IAVF_TX_DESC_CMD_EOP | IAVF_TX_DESC_CMD_ICRC;
 	uint64_t rs = IAVF_TX_DESC_CMD_RS | flags;
 	bool lldp_enabled = txq->lldp_enabled;
+	/* vlan_flag gives both the single-VLAN and the QinQ outer tag position */
+	enum ci_l2tag_pos vlan_pos = (txq->vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) ?
+			CI_TAG_IN_DATA_DESC : CI_TAG_IN_CTX_DESC;
 
 	if (txq->nb_tx_free < txq->tx_free_thresh)
 		ci_tx_free_bufs_vec(txq, iavf_tx_desc_done, true);
@@ -2057,10 +2067,10 @@ iavf_xmit_fixed_burst_vec_avx2_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 		nb_mbuf = n >> 1;
 		ci_tx_backlog_entry_vec(txep, tx_pkts, nb_mbuf);
 
-		ctx_vtx(txdp, tx_pkts, nb_mbuf - 1, flags, offload, txq->vlan_flag, lldp_enabled);
+		ctx_vtx(txdp, tx_pkts, nb_mbuf - 1, flags, offload, vlan_pos, vlan_pos, lldp_enabled);
 		tx_pkts += (nb_mbuf - 1);
 		txdp += (n - 2);
-		ctx_vtx1(txdp, *tx_pkts++, rs, offload, txq->vlan_flag, lldp_enabled);
+		ctx_vtx1(txdp, *tx_pkts++, rs, offload, vlan_pos, vlan_pos, lldp_enabled);
 
 		nb_commit = (uint16_t)(nb_commit - n);
 
@@ -2074,7 +2084,7 @@ iavf_xmit_fixed_burst_vec_avx2_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 	nb_mbuf = nb_commit >> 1;
 	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_mbuf);
 
-	ctx_vtx(txdp, tx_pkts, nb_mbuf, flags, offload, txq->vlan_flag, lldp_enabled);
+	ctx_vtx(txdp, tx_pkts, nb_mbuf, flags, offload, vlan_pos, vlan_pos, lldp_enabled);
 	tx_id = (uint16_t)(tx_id + nb_commit);
 
 	if (tx_id > txq->tx_next_rs) {
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index 4609c2245a..8e44406511 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -1830,13 +1830,13 @@ tx_backlog_entry_avx512(struct ci_tx_entry_vec *txep,
 static __rte_always_inline void
 iavf_vtx1(volatile struct ci_tx_desc *txdp,
 	  struct rte_mbuf *pkt, uint64_t flags,
-	  bool offload, uint8_t vlan_flag)
+	  bool offload, enum ci_l2tag_pos single_vlan_pos, enum ci_l2tag_pos qinq_outer_pos)
 {
 	uint64_t high_qw = (CI_TX_DESC_DTYPE_DATA |
 		 ((uint64_t)flags << CI_TXD_QW1_CMD_S) |
 		 ((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
 	if (offload)
-		iavf_txd_enable_offload(pkt, &high_qw, vlan_flag);
+		iavf_txd_enable_offload(pkt, &high_qw, single_vlan_pos, qinq_outer_pos);
 
 	__m128i descriptor = _mm_set_epi64x(high_qw,
 					    pkt->buf_iova + pkt->data_off);
@@ -1848,13 +1848,13 @@ iavf_vtx1(volatile struct ci_tx_desc *txdp,
 static __rte_always_inline void
 iavf_vtx(volatile struct ci_tx_desc *txdp,
 		struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags,
-		bool offload, uint8_t vlan_flag)
+		bool offload, enum ci_l2tag_pos single_vlan_pos, enum ci_l2tag_pos qinq_outer_pos)
 {
 	const uint64_t hi_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags << CI_TXD_QW1_CMD_S));
 
 	/* if unaligned on 32-bit boundary, do one to align */
 	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
-		iavf_vtx1(txdp, *pkt, flags, offload, vlan_flag);
+		iavf_vtx1(txdp, *pkt, flags, offload, single_vlan_pos, qinq_outer_pos);
 		nb_pkts--; txdp++; pkt++;
 	}
 
@@ -1869,10 +1869,10 @@ iavf_vtx(volatile struct ci_tx_desc *txdp,
 		uint64_t hi_qw0 = hi_qw_tmpl |
 			((uint64_t)pkt[0]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 		if (offload) {
-			iavf_txd_enable_offload(pkt[3], &hi_qw3, vlan_flag);
-			iavf_txd_enable_offload(pkt[2], &hi_qw2, vlan_flag);
-			iavf_txd_enable_offload(pkt[1], &hi_qw1, vlan_flag);
-			iavf_txd_enable_offload(pkt[0], &hi_qw0, vlan_flag);
+			iavf_txd_enable_offload(pkt[3], &hi_qw3, single_vlan_pos, qinq_outer_pos);
+			iavf_txd_enable_offload(pkt[2], &hi_qw2, single_vlan_pos, qinq_outer_pos);
+			iavf_txd_enable_offload(pkt[1], &hi_qw1, single_vlan_pos, qinq_outer_pos);
+			iavf_txd_enable_offload(pkt[0], &hi_qw0, single_vlan_pos, qinq_outer_pos);
 		}
 
 		__m512i desc0_3 =
@@ -1890,7 +1890,7 @@ iavf_vtx(volatile struct ci_tx_desc *txdp,
 
 	/* do any last ones */
 	while (nb_pkts) {
-		iavf_vtx1(txdp, *pkt, flags, offload, vlan_flag);
+		iavf_vtx1(txdp, *pkt, flags, offload, single_vlan_pos, qinq_outer_pos);
 		txdp++; pkt++; nb_pkts--;
 	}
 }
@@ -2047,7 +2047,8 @@ iavf_fill_ctx_desc_tunnelling_field(volatile uint64_t *qw0,
 
 static __rte_always_inline void
 ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
-		uint64_t flags, bool offload, uint8_t vlan_flag, bool lldp_enabled)
+		uint64_t flags, bool offload, enum ci_l2tag_pos single_vlan_pos,
+		enum ci_l2tag_pos qinq_outer_pos, bool lldp_enabled)
 {
 	uint64_t high_ctx_qw = IAVF_TX_DESC_DTYPE_CONTEXT;
 	uint64_t low_ctx_qw = 0;
@@ -2055,13 +2056,13 @@ ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 	if (offload) {
 		iavf_fill_ctx_desc_tunneling_avx512(&low_ctx_qw, pkt);
 		if (pkt->ol_flags & RTE_MBUF_F_TX_QINQ) {
-			uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
+			uint64_t qinq_tag = qinq_outer_pos == CI_TAG_IN_CTX_DESC ?
 				(uint64_t)pkt->vlan_tci_outer :
 				(uint64_t)pkt->vlan_tci;
 			high_ctx_qw |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
 			low_ctx_qw |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 		} else if ((pkt->ol_flags & RTE_MBUF_F_TX_VLAN) &&
-				vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
+				single_vlan_pos == CI_TAG_IN_CTX_DESC) {
 			high_ctx_qw |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
 			low_ctx_qw |= (uint64_t)pkt->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 		}
@@ -2073,7 +2074,7 @@ ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 				((uint64_t)flags << CI_TXD_QW1_CMD_S) |
 				((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
 	if (offload)
-		iavf_txd_enable_offload(pkt, &high_data_qw, vlan_flag);
+		iavf_txd_enable_offload(pkt, &high_data_qw, single_vlan_pos, qinq_outer_pos);
 
 	__m256i ctx_data_desc = _mm256_set_epi64x(high_data_qw, pkt->buf_iova + pkt->data_off,
 							high_ctx_qw, low_ctx_qw);
@@ -2085,7 +2086,8 @@ ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 static __rte_always_inline void
 ctx_vtx(volatile struct ci_tx_desc *txdp,
 		struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags,
-		bool offload, uint8_t vlan_flag, bool lldp_enabled)
+		bool offload, enum ci_l2tag_pos single_vlan_pos, enum ci_l2tag_pos qinq_outer_pos,
+		bool lldp_enabled)
 {
 	uint64_t hi_data_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags << CI_TXD_QW1_CMD_S));
 
@@ -2106,13 +2108,13 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 			/* tunnel fill assigns low_ctx_qw1; must run before QinQ/VLAN OR below */
 			iavf_fill_ctx_desc_tunnelling_field(&low_ctx_qw1, pkt[1]);
 			if (pkt[1]->ol_flags & RTE_MBUF_F_TX_QINQ) {
-				uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
+				uint64_t qinq_tag = qinq_outer_pos == CI_TAG_IN_CTX_DESC ?
 					(uint64_t)pkt[1]->vlan_tci_outer :
 					(uint64_t)pkt[1]->vlan_tci;
 				hi_ctx_qw1 |= CI_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S;
 				low_ctx_qw1 |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 			} else if (pkt[1]->ol_flags & RTE_MBUF_F_TX_VLAN &&
-					vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
+					single_vlan_pos == CI_TAG_IN_CTX_DESC) {
 				hi_ctx_qw1 |= IAVF_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S;
 				low_ctx_qw1 |=
 					(uint64_t)pkt[1]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
@@ -2126,13 +2128,13 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 			/* tunnel fill assigns low_ctx_qw0; must run before QinQ/VLAN OR below */
 			iavf_fill_ctx_desc_tunnelling_field(&low_ctx_qw0, pkt[0]);
 			if (pkt[0]->ol_flags & RTE_MBUF_F_TX_QINQ) {
-				uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
+				uint64_t qinq_tag = qinq_outer_pos == CI_TAG_IN_CTX_DESC ?
 					(uint64_t)pkt[0]->vlan_tci_outer :
 					(uint64_t)pkt[0]->vlan_tci;
 				hi_ctx_qw0 |= IAVF_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S;
 				low_ctx_qw0 |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 			} else if (pkt[0]->ol_flags & RTE_MBUF_F_TX_VLAN &&
-					vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
+					single_vlan_pos == CI_TAG_IN_CTX_DESC) {
 				hi_ctx_qw0 |= IAVF_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S;
 				low_ctx_qw0 |=
 					(uint64_t)pkt[0]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
@@ -2142,8 +2144,8 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << CI_TXD_QW1_CMD_S;
 
 		if (offload) {
-			iavf_txd_enable_offload(pkt[1], &hi_data_qw1, vlan_flag);
-			iavf_txd_enable_offload(pkt[0], &hi_data_qw0, vlan_flag);
+			iavf_txd_enable_offload(pkt[1], &hi_data_qw1, single_vlan_pos, qinq_outer_pos);
+			iavf_txd_enable_offload(pkt[0], &hi_data_qw0, single_vlan_pos, qinq_outer_pos);
 		}
 
 		__m512i desc0_3 =
@@ -2156,7 +2158,7 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 	}
 
 	if (nb_pkts)
-		ctx_vtx1(txdp, *pkt, flags, offload, vlan_flag, lldp_enabled);
+		ctx_vtx1(txdp, *pkt, flags, offload, single_vlan_pos, qinq_outer_pos, lldp_enabled);
 }
 
 static __rte_always_inline uint16_t
@@ -2170,6 +2172,9 @@ iavf_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 	/* bit2 is reserved and must be set to 1 according to Spec */
 	uint64_t flags = CI_TX_DESC_CMD_EOP | CI_TX_DESC_CMD_ICRC;
 	uint64_t rs = CI_TX_DESC_CMD_RS | flags;
+	/* vlan_flag gives both the single-VLAN and the QinQ outer tag position */
+	enum ci_l2tag_pos vlan_pos = (txq->vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) ?
+			CI_TAG_IN_DATA_DESC : CI_TAG_IN_CTX_DESC;
 
 	if (txq->nb_tx_free < txq->tx_free_thresh)
 		ci_tx_free_bufs_vec(txq, iavf_tx_desc_done, false);
@@ -2190,11 +2195,11 @@ iavf_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 	if (nb_commit >= n) {
 		tx_backlog_entry_avx512(txep, tx_pkts, n);
 
-		iavf_vtx(txdp, tx_pkts, n - 1, flags, offload, txq->vlan_flag);
+		iavf_vtx(txdp, tx_pkts, n - 1, flags, offload, vlan_pos, vlan_pos);
 		tx_pkts += (n - 1);
 		txdp += (n - 1);
 
-		iavf_vtx1(txdp, *tx_pkts++, rs, offload, txq->vlan_flag);
+		iavf_vtx1(txdp, *tx_pkts++, rs, offload, vlan_pos, vlan_pos);
 
 		nb_commit = (uint16_t)(nb_commit - n);
 
@@ -2209,7 +2214,7 @@ iavf_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	tx_backlog_entry_avx512(txep, tx_pkts, nb_commit);
 
-	iavf_vtx(txdp, tx_pkts, nb_commit, flags, offload, txq->vlan_flag);
+	iavf_vtx(txdp, tx_pkts, nb_commit, flags, offload, vlan_pos, vlan_pos);
 
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
@@ -2238,6 +2243,9 @@ iavf_xmit_fixed_burst_vec_avx512_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 	uint64_t flags = CI_TX_DESC_CMD_EOP | CI_TX_DESC_CMD_ICRC;
 	uint64_t rs = CI_TX_DESC_CMD_RS | flags;
 	bool lldp_enabled = txq->lldp_enabled;
+	/* vlan_flag gives both the single-VLAN and the QinQ outer tag position */
+	enum ci_l2tag_pos vlan_pos = (txq->vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) ?
+			CI_TAG_IN_DATA_DESC : CI_TAG_IN_CTX_DESC;
 
 	if (txq->nb_tx_free < txq->tx_free_thresh)
 		ci_tx_free_bufs_vec(txq, iavf_tx_desc_done, true);
@@ -2260,10 +2268,10 @@ iavf_xmit_fixed_burst_vec_avx512_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 		nb_mbuf = n >> 1;
 		tx_backlog_entry_avx512(txep, tx_pkts, nb_mbuf);
 
-		ctx_vtx(txdp, tx_pkts, nb_mbuf - 1, flags, offload, txq->vlan_flag, lldp_enabled);
+		ctx_vtx(txdp, tx_pkts, nb_mbuf - 1, flags, offload, vlan_pos, vlan_pos, lldp_enabled);
 		tx_pkts += (nb_mbuf - 1);
 		txdp += (n - 2);
-		ctx_vtx1(txdp, *tx_pkts++, rs, offload, txq->vlan_flag, lldp_enabled);
+		ctx_vtx1(txdp, *tx_pkts++, rs, offload, vlan_pos, vlan_pos, lldp_enabled);
 
 		nb_commit = (uint16_t)(nb_commit - n);
 
@@ -2277,7 +2285,7 @@ iavf_xmit_fixed_burst_vec_avx512_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 	nb_mbuf = nb_commit >> 1;
 	tx_backlog_entry_avx512(txep, tx_pkts, nb_mbuf);
 
-	ctx_vtx(txdp, tx_pkts, nb_mbuf, flags, offload, txq->vlan_flag, lldp_enabled);
+	ctx_vtx(txdp, tx_pkts, nb_mbuf, flags, offload, vlan_pos, vlan_pos, lldp_enabled);
 	tx_id = (uint16_t)(tx_id + nb_commit);
 
 	if (tx_id > txq->tx_next_rs) {
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
index 1e9ce924ee..e99964eaef 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
@@ -121,14 +121,13 @@ iavf_tx_vec_dev_check_default(struct rte_eth_dev *dev)
 
 static __rte_always_inline void
 iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
-			uint64_t *txd_hi, uint8_t vlan_flag)
+			uint64_t *txd_hi, enum ci_l2tag_pos single_vlan_pos,
+			enum ci_l2tag_pos qinq_outer_pos)
 {
 	uint64_t ol_flags = tx_pkt->ol_flags;
 	uint32_t td_cmd = 0;
 	uint32_t td_offset = 0;
 
-	RTE_SET_USED(vlan_flag);
-
 	/* Set MACLEN */
 	if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
 		td_offset |= (tx_pkt->outer_l2_len >> 1)
@@ -179,12 +178,12 @@ iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
 
 	if (ol_flags & RTE_MBUF_F_TX_QINQ) {
 		td_cmd |= IAVF_TX_DESC_CMD_IL2TAG1;
-		/* vlan_flag specifies outer tag location for QinQ. */
-		if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1)
+		/* L2Tag1 always carries a tag for QinQ */
+		if (qinq_outer_pos == CI_TAG_IN_DATA_DESC)
 			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci_outer << CI_TXD_QW1_L2TAG1_S);
 		else
 			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci << CI_TXD_QW1_L2TAG1_S);
-	} else if (ol_flags & RTE_MBUF_F_TX_VLAN && vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) {
+	} else if (ol_flags & RTE_MBUF_F_TX_VLAN && single_vlan_pos == CI_TAG_IN_DATA_DESC) {
 		td_cmd |= CI_TX_DESC_CMD_IL2TAG1;
 		*txd_hi |= ((uint64_t)tx_pkt->vlan_tci << CI_TXD_QW1_L2TAG1_S);
 	}
-- 
2.53.0

