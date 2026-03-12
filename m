Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E57105A583
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 11:05:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6484402C9;
	Thu, 12 Mar 2026 12:05:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 2C1E5402AC;
 Thu, 12 Mar 2026 12:05:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773313555; x=1804849555;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=R74QBs9mso9ceBZUdtxw5YCBYBmSOMsFSFmpJVlT074=;
 b=QMMEQoddxutZ0A5cUnfOfZOiwGZVdXHrC1NHys4+6V1mEeBl4JwCGNNY
 joFu84XsIqM7rbMGn3I9opfoOdJNO5DBxq8/1N/xkCUU9Bp2YnTdAnoK8
 Q3LCk/zhbDG/Hno7olr27Zv1OFFm/bblO2RT6qKhm1NBOcfzwYUqe6OzO
 KM/+BJQWtoyqNEl0G+1tT4xDPNKCRkV2i8J/Ed11dpcALdwkkH7gFT675
 UZ8WXX/oPEIW78Z3VpjLlHrv4X+54KaEMMhXAoTBSQ/w6Ki0kHSmSuDdN
 D9FxaJQjvGhY0QuNC2Dp+TFQJryubcIpnMyX0zByu5d5JeORWH/lIpdHE w==;
X-CSE-ConnectionGUID: MfVAyXIKQPq81+A26pbSaQ==
X-CSE-MsgGUID: SvQB791oQD2Y0ZNqch+lZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="73418595"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="73418595"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 04:05:53 -0700
X-CSE-ConnectionGUID: NquoP8QfTJKFJuhnv13b+g==
X-CSE-MsgGUID: ffesiFsmTHqXSZ4Lg95qFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="251280227"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by orviesa002.jf.intel.com with ESMTP; 12 Mar 2026 04:05:51 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: stable@dpdk.org
Subject: [PATCH v1] net/intel: fix mbuf leak in idpf split queue Tx path
Date: Thu, 12 Mar 2026 16:31:33 +0530
Message-Id: <20260312110133.629246-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
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

RS completion only frees the EOP entry's mbuf, leaking preceding
segments of multi-segment packets. Add a first_id field to the Tx
entry struct, record the first sw_id at the EOP entry during submit,
and walk forward from first to EOP to free all segments on completion.

Fixes: 8c6098afa075 ("common/idpf: add Rx/Tx data path")
Cc: stable@dpdk.org

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/common/tx.h             |  1 +
 drivers/net/intel/idpf/idpf_common_rxtx.c | 26 ++++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 283bd58d5d..53e61c0b62 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -121,6 +121,7 @@ struct ci_tx_queue;
 struct ci_tx_entry {
 	struct rte_mbuf *mbuf; /* mbuf associated with TX desc, if any. */
 	uint16_t next_id; /* Index of next descriptor in ring. */
+	uint16_t first_id; /* Split-queue: first sw_id of packet at EOP entry. */
 };
 
 /**
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index f73716e57c..bc0677f2ee 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -825,11 +825,23 @@ idpf_split_tx_free(struct ci_tx_queue *cq)
 		txq->last_desc_cleaned = q_head;
 		break;
 	case IDPF_TXD_COMPLT_RS:
-		/* q_head indicates sw_id when ctype is 2 */
+		/* Walk from first segment to EOP, freeing each segment. */
 		txe = &txq->sw_ring[q_head];
 		if (txe->mbuf != NULL) {
-			rte_pktmbuf_free_seg(txe->mbuf);
-			txe->mbuf = NULL;
+			uint16_t first = txe->first_id;
+			uint16_t idx = first;
+			uint16_t end = (q_head + 1 == txq->sw_nb_desc) ?
+					0 : q_head + 1;
+
+			do {
+				txe = &txq->sw_ring[idx];
+				if (txe->mbuf != NULL) {
+					rte_pktmbuf_free_seg(txe->mbuf);
+					txe->mbuf = NULL;
+				}
+				idx = (idx + 1 == txq->sw_nb_desc) ?
+					0 : idx + 1;
+			} while (idx != end);
 		}
 		break;
 	default:
@@ -979,9 +991,14 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 				tx_id = 0;
 		}
 
+		uint16_t first_sw_id = sw_id;
+
 		do {
 			txd = &txr[tx_id];
 			txn = &sw_ring[txe->next_id];
+
+			if (txe->mbuf != NULL)
+				rte_pktmbuf_free_seg(txe->mbuf);
 			txe->mbuf = tx_pkt;
 
 			/* Setup TX descriptor */
@@ -1002,6 +1019,9 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		/* fill the last descriptor with End of Packet (EOP) bit */
 		txd->qw1.cmd_dtype |= IDPF_TXD_FLEX_FLOW_CMD_EOP;
 
+		/* Record first sw_id at EOP so completion can walk forward. */
+		sw_ring[txd->qw1.compl_tag].first_id = first_sw_id;
+
 		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
 		txq->rs_compl_count += nb_used;
 
-- 
2.34.1

