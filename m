Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405CAC88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 10:37:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F5CF42ED3;
	Wed, 16 Sep 2026 12:36:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id DBBC342EAB
 for <dev@dpdk.org>; Wed, 16 Sep 2026 12:36:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789555000; x=1821091000;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ViqnV76EJ2uF16MPpnd6SQBm+IOxNHn6XIYSnKUMOJM=;
 b=AZbUTFJkr7RdMMsY4qznKMyEQecTLyhii+R9qyysCEtAWQ8rbJCUdYMU
 jJ1X1nxnw/snQCWSYGwSGM14K4OwEW5/1TfnWIngyJkBJy9iVzSL8MNUI
 xGTtJtBASdVAuTHIYzhd7BR9VyB/JGJBRFrzYCZyZZfQjx6Wx6Kas85Ty
 5dWHdQTN75ViCgAgeK39wIClwxbL/qNrg32wqhD5b+xWTTiA0zzFy/k6+
 BB6Q1+yxZb2MauKgjDtpO9OnEeyleG8M8xcijlrrTUVWODO8H94DoAYou
 wVWCot10xbCtXS2zzNn3GwQjjIyW3DGpbaVa4q9D+Scoa8Hu/VF8aqbPu Q==;
X-CSE-ConnectionGUID: tXCwK6COTTKc4U+65fZQtQ==
X-CSE-MsgGUID: nHjAuct7QA+ZG/OxDgRmRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89867632"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89867632"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 03:36:39 -0700
X-CSE-ConnectionGUID: L+QMrpEyQHSEsG4auv8a2A==
X-CSE-MsgGUID: D17huCnDQCyd8y5iNPp90A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1528239"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa012.fm.intel.com with ESMTP; 16 Sep 2026 03:36:37 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 09/15] net/ice: use common descriptor creation functions
Date: Wed, 16 Sep 2026 11:36:16 +0100
Message-ID: <20260916103622.319874-10-bruce.richardson@intel.com>
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

Update ice driver to use the descriptor creation functions from common
rather than having it maintain its own copies of them.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c   | 73 ++-------------------
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c | 64 ++----------------
 drivers/net/intel/ice/ice_rxtx_vec_common.h | 59 -----------------
 3 files changed, 12 insertions(+), 184 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
index b72f69a47b..68401560ce 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
@@ -5,6 +5,7 @@
 #include "ice_rxtx_vec_common.h"
 
 #include "../common/rx_vec_x86.h"
+#include "../common/tx_vec_x86.h"
 
 #include <rte_vect.h>
 
@@ -773,70 +774,6 @@ ice_recv_scattered_pkts_vec_avx2_offload(void *rx_queue,
 						       true);
 }
 
-static __rte_always_inline void
-ice_vtx1(volatile struct ci_tx_desc *txdp,
-	 struct rte_mbuf *pkt, uint64_t flags, bool offload)
-{
-	uint64_t high_qw = (CI_TX_DESC_DTYPE_DATA |
-		 ((uint64_t)flags << CI_TXD_QW1_CMD_S) |
-		 ((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
-	if (offload)
-		ice_txd_enable_offload(pkt, &high_qw);
-
-	__m128i descriptor = _mm_set_epi64x(high_qw, rte_pktmbuf_iova(pkt));
-	_mm_store_si128(RTE_CAST_PTR(__m128i *, txdp), descriptor);
-}
-
-static __rte_always_inline void
-ice_vtx(volatile struct ci_tx_desc *txdp,
-	struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags, bool offload)
-{
-	const uint64_t hi_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags << CI_TXD_QW1_CMD_S));
-
-	/* if unaligned on 32-bit boundary, do one to align */
-	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
-		ice_vtx1(txdp, *pkt, flags, offload);
-		nb_pkts--; txdp++; pkt++;
-	}
-
-	/* do four at a time while possible, in bursts */
-	for (; nb_pkts > 3; txdp += 4, pkt += 4, nb_pkts -= 4) {
-		uint64_t hi_qw3 = hi_qw_tmpl |
-			((uint64_t)pkt[3]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
-		if (offload)
-			ice_txd_enable_offload(pkt[3], &hi_qw3);
-		uint64_t hi_qw2 = hi_qw_tmpl |
-			((uint64_t)pkt[2]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
-		if (offload)
-			ice_txd_enable_offload(pkt[2], &hi_qw2);
-		uint64_t hi_qw1 = hi_qw_tmpl |
-			((uint64_t)pkt[1]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
-		if (offload)
-			ice_txd_enable_offload(pkt[1], &hi_qw1);
-		uint64_t hi_qw0 = hi_qw_tmpl |
-			((uint64_t)pkt[0]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
-		if (offload)
-			ice_txd_enable_offload(pkt[0], &hi_qw0);
-
-		__m256i desc2_3 =
-			_mm256_set_epi64x
-				(hi_qw3, rte_pktmbuf_iova(pkt[3]),
-				 hi_qw2, rte_pktmbuf_iova(pkt[2]));
-		__m256i desc0_1 =
-			_mm256_set_epi64x
-				(hi_qw1, rte_pktmbuf_iova(pkt[1]),
-				 hi_qw0, rte_pktmbuf_iova(pkt[0]));
-		_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp + 2), desc2_3);
-		_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp), desc0_1);
-	}
-
-	/* do any last ones */
-	while (nb_pkts) {
-		ice_vtx1(txdp, *pkt, flags, offload);
-		txdp++; pkt++; nb_pkts--;
-	}
-}
-
 static __rte_always_inline uint16_t
 ice_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 			      uint16_t nb_pkts, bool offload)
@@ -868,11 +805,12 @@ ice_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 	if (nb_commit >= n) {
 		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
 
-		ice_vtx(txdp, tx_pkts, n - 1, flags, offload);
+		ci_vtx_avx2(txdp, tx_pkts, n - 1, flags, offload,
+			CI_TAG_IN_DATA_DESC, CI_TAG_IN_DATA_DESC);
 		tx_pkts += (n - 1);
 		txdp += (n - 1);
 
-		ice_vtx1(txdp, *tx_pkts++, rs, offload);
+		ci_vtx1(txdp, *tx_pkts++, rs, offload, CI_TAG_IN_DATA_DESC, CI_TAG_IN_DATA_DESC);
 
 		nb_commit = (uint16_t)(nb_commit - n);
 
@@ -886,7 +824,8 @@ ice_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
 
-	ice_vtx(txdp, tx_pkts, nb_commit, flags, offload);
+	ci_vtx_avx2(txdp, tx_pkts, nb_commit, flags, offload,
+		CI_TAG_IN_DATA_DESC, CI_TAG_IN_DATA_DESC);
 
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
index 309ab9fca7..b4695c398e 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
@@ -5,6 +5,7 @@
 #include "ice_rxtx_vec_common.h"
 
 #include "../common/rx_vec_x86.h"
+#include "../common/tx_vec_x86.h"
 
 #include <rte_vect.h>
 
@@ -846,61 +847,6 @@ ice_recv_scattered_pkts_vec_avx512_offload(void *rx_queue,
 				rx_pkts + retval, nb_pkts);
 }
 
-static __rte_always_inline void
-ice_vtx1(volatile struct ci_tx_desc *txdp,
-	 struct rte_mbuf *pkt, uint64_t flags, bool do_offload)
-{
-	uint64_t high_qw = (CI_TX_DESC_DTYPE_DATA |
-		 ((uint64_t)flags << CI_TXD_QW1_CMD_S) |
-		 ((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
-
-	if (do_offload)
-		ice_txd_enable_offload(pkt, &high_qw);
-
-	__m128i descriptor = _mm_set_epi64x(high_qw, rte_pktmbuf_iova(pkt));
-	_mm_store_si128(RTE_CAST_PTR(__m128i *, txdp), descriptor);
-}
-
-static __rte_always_inline void
-ice_vtx(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkt,
-	uint16_t nb_pkts,  uint64_t flags, bool do_offload)
-{
-	const uint64_t hi_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags << CI_TXD_QW1_CMD_S));
-
-	for (; nb_pkts > 3; txdp += 4, pkt += 4, nb_pkts -= 4) {
-		uint64_t hi_qw3 = hi_qw_tmpl |
-			((uint64_t)pkt[3]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
-		if (do_offload)
-			ice_txd_enable_offload(pkt[3], &hi_qw3);
-		uint64_t hi_qw2 = hi_qw_tmpl |
-			((uint64_t)pkt[2]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
-		if (do_offload)
-			ice_txd_enable_offload(pkt[2], &hi_qw2);
-		uint64_t hi_qw1 = hi_qw_tmpl |
-			((uint64_t)pkt[1]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
-		if (do_offload)
-			ice_txd_enable_offload(pkt[1], &hi_qw1);
-		uint64_t hi_qw0 = hi_qw_tmpl |
-			((uint64_t)pkt[0]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
-		if (do_offload)
-			ice_txd_enable_offload(pkt[0], &hi_qw0);
-
-		__m512i desc0_3 =
-			_mm512_set_epi64
-				(hi_qw3, rte_pktmbuf_iova(pkt[3]),
-				 hi_qw2, rte_pktmbuf_iova(pkt[2]),
-				 hi_qw1, rte_pktmbuf_iova(pkt[1]),
-				 hi_qw0, rte_pktmbuf_iova(pkt[0]));
-		_mm512_storeu_si512(RTE_CAST_PTR(void *, txdp), desc0_3);
-	}
-
-	/* do any last ones */
-	while (nb_pkts) {
-		ice_vtx1(txdp, *pkt, flags, do_offload);
-		txdp++; pkt++; nb_pkts--;
-	}
-}
-
 static __rte_always_inline uint16_t
 ice_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 				uint16_t nb_pkts, bool do_offload)
@@ -933,11 +879,12 @@ ice_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 	if (nb_commit >= n) {
 		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
 
-		ice_vtx(txdp, tx_pkts, n - 1, flags, do_offload);
+		ci_vtx_avx512(txdp, tx_pkts, n - 1, flags, do_offload,
+			CI_TAG_IN_DATA_DESC, CI_TAG_IN_DATA_DESC);
 		tx_pkts += (n - 1);
 		txdp += (n - 1);
 
-		ice_vtx1(txdp, *tx_pkts++, rs, do_offload);
+		ci_vtx1(txdp, *tx_pkts++, rs, do_offload, CI_TAG_IN_DATA_DESC, CI_TAG_IN_DATA_DESC);
 
 		nb_commit = (uint16_t)(nb_commit - n);
 
@@ -951,7 +898,8 @@ ice_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
 
-	ice_vtx(txdp, tx_pkts, nb_commit, flags, do_offload);
+	ci_vtx_avx512(txdp, tx_pkts, nb_commit, flags, do_offload,
+		CI_TAG_IN_DATA_DESC, CI_TAG_IN_DATA_DESC);
 
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_common.h b/drivers/net/intel/ice/ice_rxtx_vec_common.h
index 1d83a087cc..53d1eb42a3 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
+++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
@@ -113,63 +113,4 @@ ice_tx_vec_dev_check_default(struct rte_eth_dev *dev)
 	return ret;
 }
 
-static inline void
-ice_txd_enable_offload(struct rte_mbuf *tx_pkt,
-		       uint64_t *txd_hi)
-{
-	uint64_t ol_flags = tx_pkt->ol_flags;
-	uint32_t td_cmd = 0;
-	uint32_t td_offset = 0;
-
-	/* Tx Checksum Offload */
-	/* SET MACLEN */
-	td_offset |= (tx_pkt->l2_len >> 1) <<
-		CI_TX_DESC_LEN_MACLEN_S;
-
-	/* Enable L3 checksum offload */
-	if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
-		td_cmd |= CI_TX_DESC_CMD_IIPT_IPV4_CSUM;
-		td_offset |= (tx_pkt->l3_len >> 2) <<
-			CI_TX_DESC_LEN_IPLEN_S;
-	} else if (ol_flags & RTE_MBUF_F_TX_IPV4) {
-		td_cmd |= CI_TX_DESC_CMD_IIPT_IPV4;
-		td_offset |= (tx_pkt->l3_len >> 2) <<
-			CI_TX_DESC_LEN_IPLEN_S;
-	} else if (ol_flags & RTE_MBUF_F_TX_IPV6) {
-		td_cmd |= CI_TX_DESC_CMD_IIPT_IPV6;
-		td_offset |= (tx_pkt->l3_len >> 2) <<
-			CI_TX_DESC_LEN_IPLEN_S;
-	}
-
-	/* Enable L4 checksum offloads */
-	switch (ol_flags & RTE_MBUF_F_TX_L4_MASK) {
-	case RTE_MBUF_F_TX_TCP_CKSUM:
-		td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_TCP;
-		td_offset |= (sizeof(struct rte_tcp_hdr) >> 2) <<
-			CI_TX_DESC_LEN_L4_LEN_S;
-		break;
-	case RTE_MBUF_F_TX_SCTP_CKSUM:
-		td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_SCTP;
-		td_offset |= (sizeof(struct rte_sctp_hdr) >> 2) <<
-			CI_TX_DESC_LEN_L4_LEN_S;
-		break;
-	case RTE_MBUF_F_TX_UDP_CKSUM:
-		td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_UDP;
-		td_offset |= (sizeof(struct rte_udp_hdr) >> 2) <<
-			CI_TX_DESC_LEN_L4_LEN_S;
-		break;
-	default:
-		break;
-	}
-
-	*txd_hi |= ((uint64_t)td_offset) << CI_TXD_QW1_OFFSET_S;
-
-	/* Tx VLAN/QINQ insertion Offload */
-	if (ol_flags & RTE_MBUF_F_TX_VLAN) {
-		td_cmd |= CI_TX_DESC_CMD_IL2TAG1;
-		*txd_hi |= ((uint64_t)tx_pkt->vlan_tci << CI_TXD_QW1_L2TAG1_S);
-	}
-
-	*txd_hi |= ((uint64_t)td_cmd) << CI_TXD_QW1_CMD_S;
-}
 #endif
-- 
2.53.0

