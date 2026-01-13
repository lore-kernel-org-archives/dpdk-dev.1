Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76D6D2F327
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:19:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AE2C40E48;
	Tue, 13 Jan 2026 16:15:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 0BCB340E0F
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:15:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768317354; x=1799853354;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dfgBBF6GtBPDV45owv0mKWQPf1PAAsBRhRpJZ4E+mmI=;
 b=Mjz7KJctXRYFL1VzPc28Pm/e+miZ6clswLN+dtWSErfMmqcMm05e2saV
 HFWa004XI/AXb+Hk3gG2InJwWcGCaJzHO8ysBLV+O8MMhO8S6o7gdnN7a
 HlsrdrJLdWn6Su8V8w+d7Tt5oohO+vI7fQhnw97NZc4LmsCvgiSwZOFq6
 4Y9Wn0F0AFhZ55/y/3isf/34TY1V1jlEnms9TwU0fH2ePPb+NvmhL/caB
 ReaGUN1lVq9mPc6MMgK82rJPq2Ftd0tb4Ka1T5C2hQ7xNVdYpQsJUS4wM
 sBI9IHVZGz2EbIJCvM5t1N65hpTRLOrgyntKDzCrYmjniHM37XZj6ePxE Q==;
X-CSE-ConnectionGUID: vS0q9ZP2SvWWyoVeF8XK3A==
X-CSE-MsgGUID: yekPE6AuSiaCpCU4Mu2DXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80969234"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="80969234"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 07:15:54 -0800
X-CSE-ConnectionGUID: i1HiiZvZRuiXvyh1rHuvUw==
X-CSE-MsgGUID: kiUq+g0STEqRUvph9+tS5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="203556672"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 13 Jan 2026 07:15:53 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 32/36] net/intel: use non-volatile stores in simple Tx
 function
Date: Tue, 13 Jan 2026 15:14:56 +0000
Message-ID: <20260113151505.1871271-33-bruce.richardson@intel.com>
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

The simple Tx code path can be reworked to use non-volatile stores - as
is the case with the full-featured Tx path - by reusing the existing
write_txd function (which just needs to be moved up in the header file).
This gives a small performance boost.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar_fns.h | 55 +++++++-----------------
 1 file changed, 16 insertions(+), 39 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar_fns.h b/drivers/net/intel/common/tx_scalar_fns.h
index dcdec200ac..16f802e902 100644
--- a/drivers/net/intel/common/tx_scalar_fns.h
+++ b/drivers/net/intel/common/tx_scalar_fns.h
@@ -12,35 +12,13 @@
 /* depends on common Tx definitions. */
 #include "tx.h"
 
-/* Populate 4 descriptors with data from 4 mbufs */
 static inline void
-ci_tx_fill_hw_ring_tx4(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkts)
+write_txd(volatile void *txd, uint64_t qw0, uint64_t qw1)
 {
-	uint64_t dma_addr;
-	uint32_t i;
-
-	for (i = 0; i < 4; i++, txdp++, pkts++) {
-		dma_addr = rte_mbuf_data_iova(*pkts);
-		txdp->buffer_addr = rte_cpu_to_le_64(dma_addr);
-		txdp->cmd_type_offset_bsz =
-			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DATA |
-				((uint64_t)CI_TX_DESC_CMD_DEFAULT << CI_TXD_QW1_CMD_S) |
-				((uint64_t)(*pkts)->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
-	}
-}
+	uint64_t *txd_qw =  __rte_assume_aligned(RTE_CAST_PTR(void *, txd), 16);
 
-/* Populate 1 descriptor with data from 1 mbuf */
-static inline void
-ci_tx_fill_hw_ring_tx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkts)
-{
-	uint64_t dma_addr;
-
-	dma_addr = rte_mbuf_data_iova(*pkts);
-	txdp->buffer_addr = rte_cpu_to_le_64(dma_addr);
-	txdp->cmd_type_offset_bsz =
-		rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DATA |
-			((uint64_t)CI_TX_DESC_CMD_DEFAULT << CI_TXD_QW1_CMD_S) |
-			((uint64_t)(*pkts)->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
+	txd_qw[0] = rte_cpu_to_le_64(qw0);
+	txd_qw[1] = rte_cpu_to_le_64(qw1);
 }
 
 /* Fill hardware descriptor ring with mbuf data */
@@ -60,14 +38,22 @@ ci_tx_fill_hw_ring(struct ci_tx_queue *txq, struct rte_mbuf **pkts,
 	for (i = 0; i < mainpart; i += N_PER_LOOP) {
 		for (j = 0; j < N_PER_LOOP; ++j)
 			(txep + i + j)->mbuf = *(pkts + i + j);
-		ci_tx_fill_hw_ring_tx4(txdp + i, pkts + i);
+		for (j = 0; j < N_PER_LOOP; ++j)
+			write_txd(txdp + i + j, rte_mbuf_data_iova(*(pkts + i + j)),
+				CI_TX_DESC_DTYPE_DATA |
+				((uint64_t)CI_TX_DESC_CMD_DEFAULT << CI_TXD_QW1_CMD_S) |
+				((uint64_t)(*(pkts + i + j))->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
 	}
 
 	if (unlikely(leftover > 0)) {
 		for (i = 0; i < leftover; ++i) {
-			(txep + mainpart + i)->mbuf = *(pkts + mainpart + i);
-			ci_tx_fill_hw_ring_tx1(txdp + mainpart + i,
-					       pkts + mainpart + i);
+			uint16_t idx = mainpart + i;
+			(txep + idx)->mbuf = *(pkts + idx);
+			write_txd(txdp + idx, rte_mbuf_data_iova(*(pkts + idx)),
+				CI_TX_DESC_DTYPE_DATA |
+				((uint64_t)CI_TX_DESC_CMD_DEFAULT << CI_TXD_QW1_CMD_S) |
+				((uint64_t)(*(pkts + idx))->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
+
 		}
 	}
 }
@@ -367,15 +353,6 @@ struct ci_timesstamp_queue_fns {
 	write_ts_tail_t write_ts_tail;
 };
 
-static inline void
-write_txd(volatile void *txd, uint64_t qw0, uint64_t qw1)
-{
-	uint64_t *txd_qw = __rte_assume_aligned(RTE_CAST_PTR(void *, txd), 16);
-
-	txd_qw[0] = rte_cpu_to_le_64(qw0);
-	txd_qw[1] = rte_cpu_to_le_64(qw1);
-}
-
 static inline uint16_t
 ci_xmit_pkts(struct ci_tx_queue *txq,
 	     struct rte_mbuf **tx_pkts,
-- 
2.51.0

