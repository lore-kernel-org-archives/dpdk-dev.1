Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DEDC9830C
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 13:52:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 800F942EF4;
	Wed, 23 Sep 2026 15:52:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
 by mails.dpdk.org (Postfix) with ESMTP id D79434027C
 for <dev@dpdk.org>; Wed, 23 Sep 2026 15:51:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790171517; x=1821707517;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Oi1YVJL/4QdGKu9k/+rw5ISxJGBTeB21ChNitiPNxWY=;
 b=Lpk4ZQ6lhb/SzoW+HcH3i/x8vUdCcdx9rk1u087xl3t7j5AYN4IjGdUG
 EhbcWGYO66H0d+55ksOxXZenjNbNrxRBItKMKGqV10W3zHaP06kOW4vB9
 GyaYL0BamlHgf4KESeod4UXAfaOY+kPKF8Z7cT3oIL/mWF924EhND3Kqn
 00OlDGyPp3ujqoauThwK4sh5Q+e/rX3FxjfT8/7DaNPrjPrcOVoPCYwbE
 QspNwtVKZ89snuvUJMyvIvG0LRa7lBGzsjIOcX/TsNbx0w23iskotObTp
 LzuJyJGLs6RAfW8WMtK1VwSG7GPdgzjWDpBjJ3cGanesmZPYCbwxo7IaO w==;
X-CSE-ConnectionGUID: srj1Da88SDuRN03Fync7Cg==
X-CSE-MsgGUID: K0WZdY+TQPmaIZCSL7Lzyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="1375384"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="1375384"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 06:51:56 -0700
X-CSE-ConnectionGUID: A6di6E4LTdKPhsJQXdKrkQ==
X-CSE-MsgGUID: LHfIpANDTnaJfQ23l08ekQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="270130098"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa009.fm.intel.com with ESMTP; 23 Sep 2026 06:51:55 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 2/2] net/i40e: use common AVX-512 Tx function
Date: Wed, 23 Sep 2026 14:51:46 +0100
Message-ID: <20260923135146.3527913-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923135146.3527913-1-bruce.richardson@intel.com>
References: <20260923135146.3527913-1-bruce.richardson@intel.com>
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

Replace the standard (non-offloading) AVX-512 Tx function with the one
from the intel/common folder. Both old and new code paths have identical
behaviour.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c | 113 +-----------------
 1 file changed, 3 insertions(+), 110 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
index 0c2e699a95..ea2e6dc024 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
@@ -13,6 +13,7 @@
 #include "i40e_rxtx_vec_common.h"
 
 #include "../common/rx_vec_x86.h"
+#include "../common/tx_vec_x86.h"
 
 #include <rte_vect.h>
 
@@ -749,114 +750,6 @@ i40e_recv_scattered_pkts_vec_avx512(void *rx_queue,
 				rx_pkts + retval, nb_pkts);
 }
 
-static inline void
-vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt, uint64_t flags)
-{
-	uint64_t high_qw = (CI_TX_DESC_DTYPE_DATA |
-		((uint64_t)flags << CI_TXD_QW1_CMD_S) |
-		((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
-
-	__m128i descriptor = _mm_set_epi64x(high_qw,
-				pkt->buf_iova + pkt->data_off);
-	_mm_store_si128(RTE_CAST_PTR(__m128i *, txdp), descriptor);
-}
-
-static inline void
-vtx(volatile struct ci_tx_desc *txdp,
-	struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags)
-{
-	const uint64_t hi_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags << CI_TXD_QW1_CMD_S));
-
-	for (; nb_pkts > 3; txdp += 4, pkt += 4, nb_pkts -= 4) {
-		uint64_t hi_qw3 = hi_qw_tmpl |
-			((uint64_t)pkt[3]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
-		uint64_t hi_qw2 = hi_qw_tmpl |
-			((uint64_t)pkt[2]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
-		uint64_t hi_qw1 = hi_qw_tmpl |
-			((uint64_t)pkt[1]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
-		uint64_t hi_qw0 = hi_qw_tmpl |
-			((uint64_t)pkt[0]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
-
-		__m512i desc0_3 =
-			_mm512_set_epi64
-			(hi_qw3, pkt[3]->buf_iova + pkt[3]->data_off,
-			hi_qw2, pkt[2]->buf_iova + pkt[2]->data_off,
-			hi_qw1, pkt[1]->buf_iova + pkt[1]->data_off,
-			hi_qw0, pkt[0]->buf_iova + pkt[0]->data_off);
-		_mm512_storeu_si512(RTE_CAST_PTR(void *, txdp), desc0_3);
-	}
-
-	/* do any last ones */
-	while (nb_pkts) {
-		vtx1(txdp, *pkt, flags);
-		txdp++; pkt++; nb_pkts--;
-	}
-}
-
-static inline uint16_t
-i40e_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
-				 uint16_t nb_pkts)
-{
-	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
-	volatile struct ci_tx_desc *txdp;
-	struct ci_tx_entry_vec *txep;
-	uint16_t n, nb_commit, tx_id;
-	uint64_t flags = CI_TX_DESC_CMD_DEFAULT;
-	uint64_t rs = CI_TX_DESC_CMD_RS | CI_TX_DESC_CMD_DEFAULT;
-
-	if (txq->nb_tx_free < txq->tx_free_thresh)
-		ci_tx_free_bufs_vec(txq, i40e_tx_desc_done, false);
-
-	nb_commit = nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
-	if (unlikely(nb_pkts == 0))
-		return 0;
-
-	tx_id = txq->tx_tail;
-	txdp = &txq->ci_tx_ring[tx_id];
-	txep = (void *)txq->sw_ring;
-	txep += tx_id;
-
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
-
-	n = (uint16_t)(txq->nb_tx_desc - tx_id);
-	if (nb_commit >= n) {
-		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
-
-		vtx(txdp, tx_pkts, n - 1, flags);
-		tx_pkts += (n - 1);
-		txdp += (n - 1);
-
-		vtx1(txdp, *tx_pkts++, rs);
-
-		nb_commit = (uint16_t)(nb_commit - n);
-
-		tx_id = 0;
-		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
-
-		/* avoid reach the end of ring */
-		txdp = txq->ci_tx_ring;
-		txep = (void *)txq->sw_ring;
-	}
-
-	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
-
-	vtx(txdp, tx_pkts, nb_commit, flags);
-
-	tx_id = (uint16_t)(tx_id + nb_commit);
-	if (tx_id > txq->tx_next_rs) {
-		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
-		txq->tx_next_rs =
-			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
-	}
-
-	txq->tx_tail = tx_id;
-
-	I40E_PCI_REG_WC_WRITE(txq->qtx_tail, txq->tx_tail);
-
-	return nb_pkts;
-}
-
 uint16_t
 i40e_xmit_pkts_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 			  uint16_t nb_pkts)
@@ -869,8 +762,8 @@ i40e_xmit_pkts_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 		/* cross rs_thresh boundary is not allowed */
 		num = (uint16_t)RTE_MIN(nb_pkts, txq->tx_rs_thresh);
-		ret = i40e_xmit_fixed_burst_vec_avx512
-				(tx_queue, &tx_pkts[nb_tx], num);
+		ret = ci_xmit_fixed_burst_vec_avx512(tx_queue, &tx_pkts[nb_tx], num,
+				false, CI_TAG_IN_DATA_DESC, CI_TAG_IN_DATA_DESC);
 		nb_tx += ret;
 		nb_pkts -= ret;
 		if (ret < num)
-- 
2.53.0

