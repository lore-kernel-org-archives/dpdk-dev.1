Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB47CE6BF04
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 11:44:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8DA440BA2;
	Fri, 30 Jan 2026 12:42:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id E47D040A75
 for <dev@dpdk.org>; Fri, 30 Jan 2026 12:42:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769773363; x=1801309363;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LQSFDoQhMdxpR6DiwRj1HL1/elSseSyMxBKciBg+5DQ=;
 b=QvYXxRVL2dUHQYD5sn4+DjRNtHJ0CqFUgCx9H5DYuU/hlQ3eMPrRCaAU
 pQdIg93bRnfn9eMG8MEnBmch6CNeHscJeB9GHMQeb4j/RgvlNtWr3GWo5
 Vp61twMQQQa+f8MkUbwvpNW6du8k7Rp15ravk+I6VbmOVu2mZVH0zBDRA
 X7nZBIYAefpna4+p7Eu4LzU2A+FEFY0Rj+JtWK4FNDvAkK9SEp9gWU6Bp
 aMM1d7A2qRrAYRjpuNMqn8k5oUEhyRCBZ45NrJQuVxxVfOOwvQ1ERN3wS
 Uij2MTE5wvwqJsran8saTjlWG+8Psk/RcfcIQO6UJMjGhVbtzKlISTiW5 w==;
X-CSE-ConnectionGUID: hCkLe3fRRUqJJNtZbEcOzQ==
X-CSE-MsgGUID: bF8RCsBrRBGlPtf1FVvEZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82392315"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="82392315"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2026 03:42:42 -0800
X-CSE-ConnectionGUID: VwQMbGVHSUiDjP609JrguQ==
X-CSE-MsgGUID: jx8sKnt+QN+URVO/6dyLSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="209190524"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa010.fm.intel.com with ESMTP; 30 Jan 2026 03:42:42 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 19/36] net/intel: avoid writing the final pkt descriptor
 twice
Date: Fri, 30 Jan 2026 11:41:46 +0000
Message-ID: <20260130114207.1126032-20-bruce.richardson@intel.com>
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
index 5e301699be..bd8053f58c 100644
--- a/drivers/net/intel/common/tx_scalar_fns.h
+++ b/drivers/net/intel/common/tx_scalar_fns.h
@@ -377,6 +377,10 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 				txn = &sw_ring[txe->next_id];
 			}
 
+			/* fill the last descriptor with End of Packet (EOP) bit */
+			if (m_seg->next == NULL)
+				td_cmd |= CI_TX_DESC_CMD_EOP;
+
 			txd->buffer_addr = rte_cpu_to_le_64(buf_dma_addr);
 			txd->cmd_type_offset_bsz = rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DATA |
 				((uint64_t)td_cmd << CI_TXD_QW1_CMD_S) |
@@ -389,21 +393,17 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
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

