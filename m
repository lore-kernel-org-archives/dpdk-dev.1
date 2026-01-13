Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2E6D2F327
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:18:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F069240DCD;
	Tue, 13 Jan 2026 16:15:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 85B4340B92
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:15:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768317339; x=1799853339;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LU5/sISyNVnXVcrrUuTd9z2fz/+OIMTGIwSRZaBFGzU=;
 b=GEn8IsVflTNLUVd+CPxHCJoqGQtToHzGiPdW+Tsz+p5L7WBkTQWc1A1N
 qpcbVqMbyt8qlkLFr5CO+lIFireXbob7bEYE83/5OLaidgZRbP2lZDRaT
 1WQ/EVjoa59xJRz38I2OL5LmrozxGY5ZIcZgxO5cC2dZ97s0GB9lAV91/
 f+CqXcCS0lbLOHiXUvTD6X0h9IcNmpL8e4BwiIYqKwuBBKASzhjVackuQ
 rqbvB2MGF8iDAaVQTlctzN0KzCF4eM836/d4QoPGXmhlXWHI4xl+AbMBe
 ADUh4vYrZJyYzdCJhwnZHI4m6KIzq3frNJmSxvJesvQJcjIlpan8dNefr g==;
X-CSE-ConnectionGUID: PBnntXGXT/i/5ZuV/Uas0w==
X-CSE-MsgGUID: SYFPzcV2R1OBz3VbO1J3rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80969200"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="80969200"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 07:15:38 -0800
X-CSE-ConnectionGUID: zgHPrlLEQvuiwhltPt3R0w==
X-CSE-MsgGUID: mG5BbrxvSrKnhYpSY5ob3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="203556623"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 13 Jan 2026 07:15:37 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 19/36] net/intel: avoid writing the final pkt descriptor
 twice
Date: Tue, 13 Jan 2026 15:14:43 +0000
Message-ID: <20260113151505.1871271-20-bruce.richardson@intel.com>
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

In the scalar datapath, there is a loop to handle multi-segment, and
multi-descriptor packets on Tx. After that loop, the end-of-packet bit
was written to the descriptor separately, meaning that for each
single-descriptor packet there were two writes to the second quad-word -
basically 3 x 64-bit writes rather than just 2. Adjusting the code to
compute the EOP bit inside the loop saves that extra write per packet
and so improves performance.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar_fns.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar_fns.h b/drivers/net/intel/common/tx_scalar_fns.h
index 0dfe2060c0..bfe545826b 100644
--- a/drivers/net/intel/common/tx_scalar_fns.h
+++ b/drivers/net/intel/common/tx_scalar_fns.h
@@ -378,6 +378,10 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 				txn = &sw_ring[txe->next_id];
 			}
 
+			/* fill the last descriptor with End of Packet (EOP) bit */
+			if (m_seg->next == NULL)
+				td_cmd |= CI_TX_DESC_CMD_EOP;
+
 			txd->buffer_addr = rte_cpu_to_le_64(buf_dma_addr);
 			txd->cmd_type_offset_bsz = rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DATA |
 				((uint64_t)td_cmd << CI_TXD_QW1_CMD_S) |
@@ -390,21 +394,17 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 			txe = txn;
 			m_seg = m_seg->next;
 		} while (m_seg);
-
-		/* fill the last descriptor with End of Packet (EOP) bit */
-		td_cmd |= CI_TX_DESC_CMD_EOP;
 		txq->nb_tx_used = (uint16_t)(txq->nb_tx_used + nb_used);
 		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
 
 		/* set RS bit on the last descriptor of one packet */
 		if (txq->nb_tx_used >= txq->tx_rs_thresh) {
-			td_cmd |= CI_TX_DESC_CMD_RS;
+			txd->cmd_type_offset_bsz |=
+					rte_cpu_to_le_64(CI_TX_DESC_CMD_RS << CI_TXD_QW1_CMD_S);
 
 			/* Update txq RS bit counters */
 			txq->nb_tx_used = 0;
 		}
-		txd->cmd_type_offset_bsz |=
-				rte_cpu_to_le_64(((uint64_t)td_cmd) << CI_TXD_QW1_CMD_S);
 
 		if (ts_fns != NULL)
 			ts_id = ts_fns->write_ts_desc(txq, tx_pkt, tx_id, ts_id);
-- 
2.51.0

