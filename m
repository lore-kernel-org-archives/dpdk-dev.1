Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA83ECD6D3
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 18:15:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D80CA40E49;
	Wed, 11 Feb 2026 19:13:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 75EEB40E17
 for <dev@dpdk.org>; Wed, 11 Feb 2026 19:13:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770833634; x=1802369634;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OW3x3gnw0Kyv90UEbH6vidfAafYh8m/gfFhz8XNZeYA=;
 b=mXzokgdZS95xSAQdOmrLFq8l9LLQNYZOqqG/8/bJoJnGw9tyECw0JclZ
 xwU1uydlI9ms4JERQ6jL+dDcOHNJsyOv2DCdsFwNqHqBN+vdh0XJQLBLk
 YrHvFFjT+SANrsyYwSgs+asp3SAD3Ov/LdfPzCPyUKfm6+J77Ja5C5V70
 vAQRa5byTOyzpg/FEeKA7eCei4cjYzyBuVv80FaGAA2Fx11q+0CCGzNcU
 EUqTVsQNdG3dRi3H4hgwdPGvjGrZjQveW1ThIG0BOq+Ik6NWmHGsCf1Jm
 sbHWZkrZxgyEywnUjvGqqjAjZnm7ewNGxtfcTXbeiaFnS9ieB6ETKF9ki g==;
X-CSE-ConnectionGUID: jknPd63NRAu2L8cjowLOLA==
X-CSE-MsgGUID: TCn+bCWRS0yXqxDQdQcGBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75834688"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="75834688"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 10:13:53 -0800
X-CSE-ConnectionGUID: RN0vLdKORvi/afDTmB2NvQ==
X-CSE-MsgGUID: XQLutqwwS/y3jyO6ByWtKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="249986363"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 11 Feb 2026 10:13:52 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 20/35] net/intel: write descriptors using non-volatile
 pointers
Date: Wed, 11 Feb 2026 18:12:49 +0000
Message-ID: <20260211181309.2838042-21-bruce.richardson@intel.com>
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

Use a non-volatile uint64_t pointer to store to the descriptor ring.
This will allow the compiler to optionally merge the stores as it sees
best.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar.h | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index f6ed11a5a8..00771402f8 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -166,6 +166,19 @@ struct ci_timestamp_queue_fns {
 	write_ts_tail_t write_ts_tail;
 };
 
+static inline void
+write_txd(volatile void *txd, uint64_t qw0, uint64_t qw1)
+{
+	/* we use an aligned structure and cast away the volatile to allow the compiler
+	 * to opportunistically optimize the two 64-bit writes as a single 128-bit write.
+	 */
+	__rte_aligned(16) struct txdesc {
+		uint64_t qw0, qw1;
+	} *txdesc = RTE_CAST_PTR(struct txdesc *, txd);
+	txdesc->qw0 = rte_cpu_to_le_64(qw0);
+	txdesc->qw1 = rte_cpu_to_le_64(qw1);
+}
+
 static inline uint16_t
 ci_xmit_pkts(struct ci_tx_queue *txq,
 	     struct rte_mbuf **tx_pkts,
@@ -299,8 +312,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 				txe->mbuf = NULL;
 			}
 
-			ctx_txd[0] = cd_qw0;
-			ctx_txd[1] = cd_qw1;
+			write_txd(ctx_txd, cd_qw0, cd_qw1);
 
 			txe->last_id = tx_last;
 			tx_id = txe->next_id;
@@ -347,12 +359,12 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 
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
@@ -368,12 +380,12 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
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

