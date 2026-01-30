Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B19E6BF01
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 11:45:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77EEF40E27;
	Fri, 30 Jan 2026 12:43:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 033C140E19
 for <dev@dpdk.org>; Fri, 30 Jan 2026 12:42:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769773379; x=1801309379;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lc9saLjjHNer3rXGNjwDv6ymIB5+Jv+h5xyIjx7Hqm4=;
 b=lWOPf8vhqCvgg2kPdpDcYSvIn0VgtWajs9Kw2322lYg4XotNb5AqkQfM
 aeaaG4vneJ25A80HFm/z8BcyrRY6/w3zOUzIWUd+7Cq2xKGZVLdCXU7fr
 iof1sZGY6lYXju5r+fdf8GemrtxyYyFek3WxXRwRs8RHfp5Q+OYVDlpsW
 smWQC70wipuERPIY3KHCOh0gUS9wG3abVnA4IgNb93E0fiJ2CXNjAbJyl
 qWqlVa5YaolFOH47BnR4jRlYE2auX20FVxZBjhqM1WOSwedh6fzU1INbn
 OGOk6FrfeTrSvJuT2la6tnCRRCYc5BNX9RF+57sO9R6WwVRDVMdBvIAbN Q==;
X-CSE-ConnectionGUID: y56f8yRZSD6IxjVVDUSTJA==
X-CSE-MsgGUID: XdN6HsRNS7+z53Hth81Liw==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82392342"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="82392342"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2026 03:42:58 -0800
X-CSE-ConnectionGUID: cJfNit3qTgKJjUrk/BQhtQ==
X-CSE-MsgGUID: CXYFO3QXTy27WRzZA/00eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="209190585"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa010.fm.intel.com with ESMTP; 30 Jan 2026 03:42:57 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 32/36] net/intel: use non-volatile stores in simple Tx
 function
Date: Fri, 30 Jan 2026 11:41:59 +0000
Message-ID: <20260130114207.1126032-33-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130114207.1126032-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
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
index 5c4f09c197..579206f7ab 100644
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
@@ -365,15 +351,6 @@ struct ci_timesstamp_queue_fns {
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

