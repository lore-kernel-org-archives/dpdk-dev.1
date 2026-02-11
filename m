Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73D1ECD6D3
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 18:15:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D303940E41;
	Wed, 11 Feb 2026 19:13:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 8EFEF40E17
 for <dev@dpdk.org>; Wed, 11 Feb 2026 19:13:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770833633; x=1802369633;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fnWC72teK3MSmweM0mvu5Zl/A8ee1bwX5rsbhhXpD+o=;
 b=lachSTsZG8riOC4JrjN56SgosWB/EmLLHviMBg7mJE0mINf+P4V8hx2I
 YBvoC9k9Zkd0TNlOb3McJQ6/C5N5IyXKiDzaANs2TX/0HexRkqruT7Dlw
 /FYFC0pnCvyIed3DvAjzh08MH0VRGtjV5Z9fc4hLwp4VvIQuUeJ5c8erD
 encpBzpE4125iRrHn9sTFUdb4b9ONBMdOigD3kya5w6ADsEPKkNZYuVQq
 Z8cfjMt97tsgN4o5fikb5FdxDtQsG6a7zW1KZul7EPIIIAOJz78nx4Yud
 nlS0TsNN+PAN+ETSisBcaJFyp6V3rk3JA/QSppNMI9VysGcJPMs61cIS9 w==;
X-CSE-ConnectionGUID: dYCDHi2wTEqBDHaZecJGrg==
X-CSE-MsgGUID: ZpDGtQRFSYGsV/7616TLdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75834687"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="75834687"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 10:13:52 -0800
X-CSE-ConnectionGUID: GdFI/Z6yTcGBSTlTYquCvw==
X-CSE-MsgGUID: V1ehIU2mTKez+uXpxdkb2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="249986360"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 11 Feb 2026 10:13:51 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 19/35] net/intel: avoid writing the final pkt descriptor
 twice
Date: Wed, 11 Feb 2026 18:12:48 +0000
Message-ID: <20260211181309.2838042-20-bruce.richardson@intel.com>
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

In the scalar datapath, there is a loop to handle multi-segment, and
multi-descriptor packets on Tx. After that loop, the end-of-packet bit
was written to the descriptor separately, meaning that for each
single-descriptor packet there were two writes to the second quad-word -
basically 3 x 64-bit writes rather than just 2. Adjusting the code to
compute the EOP bit inside the loop saves that extra write per packet
and so improves performance.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/common/tx_scalar.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index 15dc3dfa59..f6ed11a5a8 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -364,6 +364,10 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 				txn = &sw_ring[txe->next_id];
 			}
 
+			/* fill the last descriptor with End of Packet (EOP) bit */
+			if (m_seg->next == NULL)
+				td_cmd |= CI_TX_DESC_CMD_EOP;
+
 			txd->buffer_addr = rte_cpu_to_le_64(buf_dma_addr);
 			txd->cmd_type_offset_bsz = rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DATA |
 				((uint64_t)td_cmd << CI_TXD_QW1_CMD_S) |
@@ -376,21 +380,17 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
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

