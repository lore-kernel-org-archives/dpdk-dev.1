Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545EFE66880
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Dec 2025 17:28:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00ABE40B91;
	Fri, 19 Dec 2025 18:26:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id C43AA40A80
 for <dev@dpdk.org>; Fri, 19 Dec 2025 18:26:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766165196; x=1797701196;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=O/a6e91iPIBiHDveSuFudFFGioIGcaohrWlwFZZHCbQ=;
 b=ggQjVqK1yHtGn/KQQBkwP1cMdQ3Flj0A5u8VB4SNd7GhYuFxgVfTrE2g
 BhnfhykLvconSRcLFQvXatzeqMjDFmwsHcC6/EFxdUSWs8JoYWScHGSvi
 nPQctJ+Rgma2RFb8sbrwGLfTBLJnkn3AVl3PtoITTF3glX5ybsJ9Ie4gR
 vawK5AS8UCVrDmAFF+dry1WQ8uKlWQV/D8byKQYZ3yyhk6CEMV5oghzbc
 29GEBW8SkZyL6Ju6E8bP1LfctTxEl1gSHQL0NE4dgxOjHy0jSrGrX4dU6
 vY0WSFGf6FZsd6h1WQD6xgMJuxQSmaz5uwMC8STsW2eb3SHK1vl7QUm4v g==;
X-CSE-ConnectionGUID: 5iISHC6gQPSLg8kzFhaWSg==
X-CSE-MsgGUID: abys9xldQvGh0tvKPLh30w==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="71759507"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; d="scan'208";a="71759507"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2025 09:26:36 -0800
X-CSE-ConnectionGUID: yeSOH31WQQK+JnuaGnNWLg==
X-CSE-MsgGUID: 4IzbiRloTQy2gdnJVym+gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; d="scan'208";a="198170501"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 19 Dec 2025 09:26:34 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 20/27] net/intel: write descriptors using non-volatile
 pointers
Date: Fri, 19 Dec 2025 17:25:37 +0000
Message-ID: <20251219172548.2660777-21-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251219172548.2660777-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
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
index 7b643fcf44..95e9acbe60 100644
--- a/drivers/net/intel/common/tx_scalar_fns.h
+++ b/drivers/net/intel/common/tx_scalar_fns.h
@@ -184,6 +184,15 @@ struct ci_timesstamp_queue_fns {
 	write_ts_tail_t write_ts_tail;
 };
 
+static inline void
+write_txd(volatile void *txd, uint64_t qw0, uint64_t qw1)
+{
+	uint64_t *txd_qw = RTE_CAST_PTR(void *, txd);
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

