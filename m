Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755CBE6BF04
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 11:44:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFFE340A76;
	Fri, 30 Jan 2026 12:42:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id C69AA40A84
 for <dev@dpdk.org>; Fri, 30 Jan 2026 12:42:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769773365; x=1801309365;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CFmgn7s1+OWCndpK462ZwD5/EYXvqFVL5dH9s4LaFXM=;
 b=D0TbF+mx1TTLBdExtwBJMnEAFrk77Ex/mGwmFBHz3zMjcfwskZrMl2lB
 vrFkpZnjvk93uz4DDVdu1+Imiihhd86x2U+qxBgkB0zWHfQmC/sLfyJJf
 zAjKfkEy6OeMhjHsy8DzGG+1L9SFQeAJz5vN4iceoalRnDpC9RamjgPTA
 ccKrkf9ixYvkHY0LNCx4D+Tj4cHXDKblDkJhPN2GNZiIZ7Jibr0rw4tYE
 O2UGww1QlTZRyXdGd+uJVNfdsmWNehqcrkElUMWcsqiO3429hn7lXZhCG
 Kw8nMb4IfJBVqmWAzn8KFmvclrom8rYrjtCKINCJx+xLjmcIOnHMqM5td g==;
X-CSE-ConnectionGUID: 0hKNeWBvRJii0z5lvyZD6w==
X-CSE-MsgGUID: 9+VTbgDLTveNmNUqN8nlKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82392317"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="82392317"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2026 03:42:44 -0800
X-CSE-ConnectionGUID: Vg4c3ajxSYSeUBtSxA3lxw==
X-CSE-MsgGUID: QtGIGtZjRoWV8NwByOZ11w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="209190531"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa010.fm.intel.com with ESMTP; 30 Jan 2026 03:42:44 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 21/36] net/intel: write descriptors using non-volatile
 pointers
Date: Fri, 30 Jan 2026 11:41:48 +0000
Message-ID: <20260130114207.1126032-22-bruce.richardson@intel.com>
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

Use a non-volatile uint64_t pointer to store to the descriptor ring.
This will allow the compiler to optionally merge the stores as it sees
best.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar_fns.h | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar_fns.h b/drivers/net/intel/common/tx_scalar_fns.h
index bd8053f58c..ee93ce5811 100644
--- a/drivers/net/intel/common/tx_scalar_fns.h
+++ b/drivers/net/intel/common/tx_scalar_fns.h
@@ -179,6 +179,15 @@ struct ci_timesstamp_queue_fns {
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
@@ -312,8 +321,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 				txe->mbuf = NULL;
 			}
 
-			ctx_txd[0] = cd_qw0;
-			ctx_txd[1] = cd_qw1;
+			write_txd(ctx_txd, cd_qw0, cd_qw1);
 
 			txe->last_id = tx_last;
 			tx_id = txe->next_id;
@@ -360,12 +368,12 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 
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
@@ -381,12 +389,12 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
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

