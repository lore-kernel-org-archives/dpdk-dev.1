Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B47ED2F32A
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:18:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B8DF40DD3;
	Tue, 13 Jan 2026 16:15:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 59FC440BA5
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:15:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768317341; x=1799853341;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QyxHp3BhEPXe0PHix1W+limR65K+byv58RXXtKXJd+c=;
 b=KyYWMRBU4/X4FTnOsKVhs6Nz3L2v6toqesN7KBy3ruXUhyMhagbIlZFa
 2IedH+lEgdO8O/5WN+hA/JYF3j0G3TBkJaYD3BcNHXZdMTSlVmsQvVyHh
 mTunkMzZ3d4RJaPxeLUTNo23wxOgrjTdM1ybgJV4SVNW6euPaf9i+fMPY
 96W7xjuBx1JcF55elYXfANJNGlKFeanuJO+sJk/EAL7dZN/zV8Gx5RTSU
 08RH3mksjkKAQxNj/c+iT4mx0FyleWob/J0jhXLsV5mjQuDf/UTl2EFHv
 5oosReDbsp7Wi4/g6DiXzEVCQhCoFvId1K42IXPTCuoSpkQiYsFZ0O9/P w==;
X-CSE-ConnectionGUID: QSDlon82R0+SLZ2AOy64FQ==
X-CSE-MsgGUID: aafwEaTuSaq0XNlEPfRhdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80969207"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="80969207"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 07:15:40 -0800
X-CSE-ConnectionGUID: pvFQf9A/RAWR4yqSrpigXQ==
X-CSE-MsgGUID: mi7l39HzT2OzYPTd1sZG2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="203556631"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 13 Jan 2026 07:15:39 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 21/36] net/intel: write descriptors using non-volatile
 pointers
Date: Tue, 13 Jan 2026 15:14:45 +0000
Message-ID: <20260113151505.1871271-22-bruce.richardson@intel.com>
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

Use a non-volatile uint64_t pointer to store to the descriptor ring.
This will allow the compiler to optionally merge the stores as it sees
best.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar_fns.h | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar_fns.h b/drivers/net/intel/common/tx_scalar_fns.h
index bfe545826b..7cb4d3efb9 100644
--- a/drivers/net/intel/common/tx_scalar_fns.h
+++ b/drivers/net/intel/common/tx_scalar_fns.h
@@ -184,6 +184,15 @@ struct ci_timesstamp_queue_fns {
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
@@ -313,8 +322,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 				txe->mbuf = NULL;
 			}
 
-			ctx_txd[0] = cd_qw0;
-			ctx_txd[1] = cd_qw1;
+			write_txd(ctx_txd, cd_qw0, cd_qw1);
 
 			txe->last_id = tx_last;
 			tx_id = txe->next_id;
@@ -361,12 +369,12 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 
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
@@ -382,12 +390,12 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
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

