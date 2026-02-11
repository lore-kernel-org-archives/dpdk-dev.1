Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45109ECD6D0
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 18:16:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB62C410DD;
	Wed, 11 Feb 2026 19:14:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 67FA340E24
 for <dev@dpdk.org>; Wed, 11 Feb 2026 19:14:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770833646; x=1802369646;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hid8A48hx5TZWQqn0Fj9b3vADLV69+RSx8eyzpZ42/w=;
 b=bfmjzGOXNyboxUy7LthntNMqDX88W1WVFoZMXS2oBWle7BybaBwiO3+S
 KmKqC17VwoVx19HoYe0VX1V5I3qPOq6QMQnKOFm0XnT4Pbc8tt+HYY1hp
 26vZARMmyA8xwDNgIdoofLLSk0vdOWOui1CkMQ51KceP6SfHRMcnve38/
 aVah/xZvH6wX2ugl6ymrBT0BH79nxGGJKlSRczpq7vHE7hnwklyVGbotI
 sCfZDQOgeu37Ypyvou1tGvKg/Etzsf5PhSePkK313PTCMLOHPlPzhNiQR
 TIZ4fCTAGTWwI6x5dwncuswb6UAckYGOmjVeqb7X7OwjJvLqdWuy26Fqk w==;
X-CSE-ConnectionGUID: UDTqL1rOQNyMOHrcotmIkQ==
X-CSE-MsgGUID: vSYnHx5ETWi3Qwe7iTq9Jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75834702"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="75834702"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 10:14:06 -0800
X-CSE-ConnectionGUID: 0byjGLUhQtWwuV8QlKcVNA==
X-CSE-MsgGUID: 7zxLa7YaS76TNQAZxjhpPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="249986399"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 11 Feb 2026 10:14:05 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v5 30/35] net/intel: use non-volatile stores in simple Tx
 function
Date: Wed, 11 Feb 2026 18:12:59 +0000
Message-ID: <20260211181309.2838042-31-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211181309.2838042-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260211181309.2838042-1-bruce.richardson@intel.com>
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
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/common/tx_scalar.h | 65 +++++++++-------------------
 1 file changed, 21 insertions(+), 44 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index ca25a2fc9d..2c624e97e7 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -12,35 +12,17 @@
 /* depends on common Tx definitions. */
 #include "tx.h"
 
-/* Populate 4 descriptors with data from 4 mbufs */
 static inline void
-ci_tx_fill_hw_ring_tx4(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkts)
-{
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
-
-/* Populate 1 descriptor with data from 1 mbuf */
-static inline void
-ci_tx_fill_hw_ring_tx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkts)
+write_txd(volatile void *txd, uint64_t qw0, uint64_t qw1)
 {
-	uint64_t dma_addr;
-
-	dma_addr = rte_mbuf_data_iova(*pkts);
-	txdp->buffer_addr = rte_cpu_to_le_64(dma_addr);
-	txdp->cmd_type_offset_bsz =
-		rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DATA |
-			((uint64_t)CI_TX_DESC_CMD_DEFAULT << CI_TXD_QW1_CMD_S) |
-			((uint64_t)(*pkts)->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
+	/* we use an aligned structure and cast away the volatile to allow the compiler
+	 * to opportunistically optimize the two 64-bit writes as a single 128-bit write.
+	 */
+	__rte_aligned(16) struct txdesc {
+		uint64_t qw0, qw1;
+	} *txdesc = RTE_CAST_PTR(struct txdesc *, txd);
+	txdesc->qw0 = rte_cpu_to_le_64(qw0);
+	txdesc->qw1 = rte_cpu_to_le_64(qw1);
 }
 
 /* Fill hardware descriptor ring with mbuf data */
@@ -60,14 +42,22 @@ ci_tx_fill_hw_ring(struct ci_tx_queue *txq, struct rte_mbuf **pkts,
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
@@ -356,19 +346,6 @@ struct ci_timestamp_queue_fns {
 	write_ts_tail_t write_ts_tail;
 };
 
-static inline void
-write_txd(volatile void *txd, uint64_t qw0, uint64_t qw1)
-{
-	/* we use an aligned structure and cast away the volatile to allow the compiler
-	 * to opportunistically optimize the two 64-bit writes as a single 128-bit write.
-	 */
-	__rte_aligned(16) struct txdesc {
-		uint64_t qw0, qw1;
-	} *txdesc = RTE_CAST_PTR(struct txdesc *, txd);
-	txdesc->qw0 = rte_cpu_to_le_64(qw0);
-	txdesc->qw1 = rte_cpu_to_le_64(qw1);
-}
-
 static inline uint16_t
 ci_xmit_pkts(struct ci_tx_queue *txq,
 	     struct rte_mbuf **tx_pkts,
-- 
2.51.0

