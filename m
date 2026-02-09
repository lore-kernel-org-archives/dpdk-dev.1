Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B44E7E0BC
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 16:47:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C4EA40DF6;
	Mon,  9 Feb 2026 17:46:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 1772E40BA6
 for <dev@dpdk.org>; Mon,  9 Feb 2026 17:46:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770655564; x=1802191564;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=n7fjfgl20ZLKlPUS3juI7G3AXJ7KA8JLp6ICzD394Pg=;
 b=iYqfrNuU9QXPcTkiiKIOqmb25UUhCiiBCZlYUCcut/8pKOz5RQWBBLa4
 5Ek/bRyddwJoL+B5g1yWFz5CgPP83W6gLx4k07PrVcvp88KVac3t6qy2w
 g7M0vEBJoIo87bzjbIjxgQMQxL0S5zfH8Y3WVIjc528REO/JmiEHtAD3q
 vBK3/h50ZX1xBwFKk1CqRzLH0qllMynDRf7UIZGs1KMrYd4BYg3jqJZUX
 wyWLLlUCOwIhHNsUR2Kz+WSM7XRR9jHpFvLjvNGwyvTYo7t0pdmCa3RK9
 nB6vKLkNrI0aHEVRbMua0huhTvqqHsHLF7hrJTr6+TL5YIvvGSYWnnRo+ A==;
X-CSE-ConnectionGUID: G0wFlOYcSwGVeCE6LMvOWw==
X-CSE-MsgGUID: evwgmvHBQvCy7iKf5v8G0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71663463"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71663463"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 08:46:04 -0800
X-CSE-ConnectionGUID: QQyhNQJaShy3DM8l3br3mA==
X-CSE-MsgGUID: kDsGSNbHRfqlaNzJnAGTwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="210789154"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 09 Feb 2026 08:46:03 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 18/35] net/intel: avoid writing the final pkt descriptor
 twice
Date: Mon,  9 Feb 2026 16:45:16 +0000
Message-ID: <20260209164538.1428499-19-bruce.richardson@intel.com>
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

In the scalar datapath, there is a loop to handle multi-segment, and
multi-descriptor packets on Tx. After that loop, the end-of-packet bit
was written to the descriptor separately, meaning that for each
single-descriptor packet there were two writes to the second quad-word -
basically 3 x 64-bit writes rather than just 2. Adjusting the code to
compute the EOP bit inside the loop saves that extra write per packet
and so improves performance.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index 8b503dd4de..e9e9a826fa 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -372,6 +372,10 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 				txn = &sw_ring[txe->next_id];
 			}
 
+			/* fill the last descriptor with End of Packet (EOP) bit */
+			if (m_seg->next == NULL)
+				td_cmd |= CI_TX_DESC_CMD_EOP;
+
 			txd->buffer_addr = rte_cpu_to_le_64(buf_dma_addr);
 			txd->cmd_type_offset_bsz = rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DATA |
 				((uint64_t)td_cmd << CI_TXD_QW1_CMD_S) |
@@ -384,21 +388,17 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
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

