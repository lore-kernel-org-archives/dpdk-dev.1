Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4406E7E0BC
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 16:48:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87E6C40E18;
	Mon,  9 Feb 2026 17:46:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id B551C40DD7
 for <dev@dpdk.org>; Mon,  9 Feb 2026 17:46:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770655566; x=1802191566;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zqPruIzpKWhcz5F1MP8yXreJ2NBo0SbS5H2+IOy9e7M=;
 b=cfoPCd2AHqaMa3PAPfCwbbWQmOFnTvzCcaMeV2eieriC3bzwokCWOQg0
 McaaeA54WNF9o8vQFagvBu2wqwk4lOgu0+/KYijZQIvLganeRjVXducbN
 LsJxUBBQmOlY7vaIBdKwfOeZyznFZBZ+yqFQyASiK3N/yd53xI6JKxDTB
 VjhXugihifghNWbTxlYXq5rtCzCiL+Xrkek0wTUd1DG/uvp2QBe0gDmX9
 KzhpupaBumAjytdFjavGDW2hLqqllqFZBmRRSmy0+No0lGCw/3/2OWHw2
 M6GtQfL3L1ttAUkF4M9bfcGnFUVGzXvIZb8yTf/K/EFnNxQBavsd53O35 A==;
X-CSE-ConnectionGUID: 4ZdAFSV4QLyh3fOAhCahvw==
X-CSE-MsgGUID: 6F6ZE266R6ukqj8WQxnTVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71663469"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71663469"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 08:46:05 -0800
X-CSE-ConnectionGUID: 9X5Gsw15QEiuzoi2eoWtPQ==
X-CSE-MsgGUID: eB4NRS5XS6aeMwMkIsjJHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="210789164"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 09 Feb 2026 08:46:05 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 20/35] net/intel: write descriptors using non-volatile
 pointers
Date: Mon,  9 Feb 2026 16:45:18 +0000
Message-ID: <20260209164538.1428499-21-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209164538.1428499-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
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

Use a non-volatile uint64_t pointer to store to the descriptor ring.
This will allow the compiler to optionally merge the stores as it sees
best.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar.h | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index e9e9a826fa..71f96349c3 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -174,6 +174,15 @@ struct ci_timestamp_queue_fns {
 	write_ts_tail_t write_ts_tail;
 };
 
+static inline void
+write_txd(volatile void *txd, uint64_t qw0, uint64_t qw1)
+{
+	uint64_t *txd_qw = __rte_assume_aligned(RTE_CAST_PTR(void *, txd), 16);
+
+	txd_qw[0] = rte_cpu_to_le_64(qw0);
+	txd_qw[1] = rte_cpu_to_le_64(qw1);
+}
+
 static inline uint16_t
 ci_xmit_pkts(struct ci_tx_queue *txq,
 	     struct rte_mbuf **tx_pkts,
@@ -307,8 +316,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 				txe->mbuf = NULL;
 			}
 
-			ctx_txd[0] = cd_qw0;
-			ctx_txd[1] = cd_qw1;
+			write_txd(ctx_txd, cd_qw0, cd_qw1);
 
 			txe->last_id = tx_last;
 			tx_id = txe->next_id;
@@ -355,12 +363,12 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 
 			while ((ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) &&
 					unlikely(slen > CI_MAX_DATA_PER_TXD)) {
-				txd->buffer_addr = rte_cpu_to_le_64(buf_dma_addr);
-				txd->cmd_type_offset_bsz = rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DATA |
+				const uint64_t cmd_type_offset_bsz = CI_TX_DESC_DTYPE_DATA |
 					((uint64_t)td_cmd << CI_TXD_QW1_CMD_S) |
 					((uint64_t)td_offset << CI_TXD_QW1_OFFSET_S) |
 					((uint64_t)CI_MAX_DATA_PER_TXD << CI_TXD_QW1_TX_BUF_SZ_S) |
-					((uint64_t)td_tag << CI_TXD_QW1_L2TAG1_S));
+					((uint64_t)td_tag << CI_TXD_QW1_L2TAG1_S);
+				write_txd(txd, buf_dma_addr, cmd_type_offset_bsz);
 
 				buf_dma_addr += CI_MAX_DATA_PER_TXD;
 				slen -= CI_MAX_DATA_PER_TXD;
@@ -376,12 +384,12 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 			if (m_seg->next == NULL)
 				td_cmd |= CI_TX_DESC_CMD_EOP;
 
-			txd->buffer_addr = rte_cpu_to_le_64(buf_dma_addr);
-			txd->cmd_type_offset_bsz = rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DATA |
+			const uint64_t cmd_type_offset_bsz = CI_TX_DESC_DTYPE_DATA |
 				((uint64_t)td_cmd << CI_TXD_QW1_CMD_S) |
 				((uint64_t)td_offset << CI_TXD_QW1_OFFSET_S) |
 				((uint64_t)slen << CI_TXD_QW1_TX_BUF_SZ_S) |
-				((uint64_t)td_tag << CI_TXD_QW1_L2TAG1_S));
+				((uint64_t)td_tag << CI_TXD_QW1_L2TAG1_S);
+			write_txd(txd, buf_dma_addr, cmd_type_offset_bsz);
 
 			txe->last_id = tx_last;
 			tx_id = txe->next_id;
-- 
2.51.0

