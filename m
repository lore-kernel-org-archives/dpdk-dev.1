Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4EACA5FAB
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 04:46:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 656CA40DD6;
	Wed, 30 Sep 2026 06:46:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 7D2A240A7A;
 Wed, 30 Sep 2026 06:46:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790743615; x=1822279615;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=eJYwx4xbHTMI0aKdm41TaQ6+Aw/Fd4ClcsOVxAxgG3E=;
 b=gP/IQ1P1p1T9ndQezJtnk+5JL5itiDNc+u6QLUsOOVv7Cre/NBrFDogm
 pYqVBbp4HFfck0tnX2rdxBU5NseK/2mjSqXkHXTX0/en8TA58bpDIF7tP
 FlIBGgzmK7K4Q+U9nDU07uLwfbfEcUHwjMXdhl9TTcSPc182YzHQXdwJo
 cWYoqst5SE4kjNWysPT1YsPWQdzNDU0ZBcWGrKZ8MZaSNAmbV1x218E4r
 MxbH7zf5V29XA3hz7Cv8T5pYQj9dZKKMVm+8CuRIdNPyFH7EP1Z/PAuKO
 fNFmwYIqxAHb1aY6NOakuZQgOxiNrQeMQ8soP1PaAhE0sbXtMebO0IW2v Q==;
X-CSE-ConnectionGUID: Y2vl4FhrQym3it4H5r/BWg==
X-CSE-MsgGUID: vxuTMP/USJSMMhVlD2JgIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90373170"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="90373170"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 21:46:53 -0700
X-CSE-ConnectionGUID: fVY1jhZFT+KBuiz33n8zOw==
X-CSE-MsgGUID: u4eKdgdgQey4rR+z/fu98Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="274770246"
Received: from npg-npf-wlpr-srv19.iind.intel.com ([10.190.212.201])
 by fmviesa010.fm.intel.com with ESMTP; 29 Sep 2026 21:46:51 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: stable@dpdk.org
Subject: [PATCH] net/idpf: fix Tx payload corruption in split queue
Date: Wed, 30 Sep 2026 10:16:30 +0530
Message-Id: <20260930044630.250936-1-shaiq.wani@intel.com>
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

Observed on ACC while running NVMe traffic tests: under sustained
high-throughput split-queue Tx, payload bytes on the wire did not
match what the application submitted, while headers and checksums
looked valid.

The RS-completion path was freeing mbufs by walking sw_ring[] slots
between first_id and the EOP sw_id. sw_ring[] slots get reclaimed
by RE and reused by subsequent submits well before RS lands, so the
walker was freeing mbufs still in flight for later packets, whose
buffers then got recycled and overwritten mid-DMA.

Fix by tracking completion ownership in a shadow ring indexed by a
software-defined compl_tag stamped on the EOP descriptor and echoed
back by HW on RS. sw_ring[].mbuf and .first_id are no longer touched
on the Tx completion path.

Fixes: 96cc9b6ea60c ("net/idpf: fix multi-segment mbuf leak in split Tx path")
Cc: stable@dpdk.org

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/common/tx.h             |  7 +++
 drivers/net/intel/idpf/idpf_common_rxtx.c | 72 +++++++++++++++--------
 2 files changed, 55 insertions(+), 24 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 2a63cd4330..dbf28b5500 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -262,6 +262,13 @@ struct ci_tx_queue {
 				uint16_t sw_nb_desc;
 				uint16_t sw_tail;
 				uint16_t rs_compl_count;
+				/* Split-Tx completion tracking: shadow ring indexed by a
+				 * rolling compl_tag decouples RS-completion mbuf lifetime
+				 * from sw_ring[] slot reuse. sized next_pow2(nb_tx_desc).
+				 */
+				struct rte_mbuf **tx_pending_pkts;
+				uint16_t tx_pending_mask;
+				uint16_t tx_next_compl_tag;
 		};
 	};
 };
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index 649b5d1f99..281c99a216 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -233,6 +233,23 @@ idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq)
 	txq->rs_compl_count = 0;
 	txq->tx_next_dd = txq->tx_rs_thresh - 1;
 	txq->tx_next_rs = txq->tx_rs_thresh - 1;
+
+	if (txq->tx_pending_pkts == NULL) {
+		uint32_t pending_sz = rte_align32pow2(txq->nb_tx_desc);
+
+		txq->tx_pending_pkts = rte_zmalloc_socket("idpf_tx_pending",
+			sizeof(struct rte_mbuf *) * pending_sz,
+			RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+		if (txq->tx_pending_pkts == NULL) {
+			DRV_LOG(ERR, "Failed to alloc idpf tx_pending shadow ring");
+			return;
+		}
+		txq->tx_pending_mask = (uint16_t)(pending_sz - 1);
+	} else {
+		for (i = 0; i <= txq->tx_pending_mask; i++)
+			txq->tx_pending_pkts[i] = NULL;
+	}
+	txq->tx_next_compl_tag = 0;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_tx_complq_reset)
@@ -387,6 +404,17 @@ idpf_qc_tx_queue_release(void *txq)
 		rte_free(q->complq);
 	}
 
+	if (q->tx_pending_pkts != NULL) {
+		uint32_t i;
+
+		for (i = 0; i <= q->tx_pending_mask; i++) {
+			if (q->tx_pending_pkts[i] != NULL)
+				rte_pktmbuf_free(q->tx_pending_pkts[i]);
+		}
+		rte_free(q->tx_pending_pkts);
+		q->tx_pending_pkts = NULL;
+	}
+
 	ci_txq_release_all_mbufs(q, false);
 	rte_free(q->rs_last_id);
 	rte_free(q->sw_ring);
@@ -787,7 +815,6 @@ idpf_split_tx_free(struct idpf_complq *cq)
 	volatile struct idpf_splitq_tx_compl_desc *compl_ring = cq->compl_ring;
 	volatile struct idpf_splitq_tx_compl_desc *txd;
 	uint16_t next = cq->tx_tail;
-	struct ci_tx_entry *txe;
 	struct ci_tx_queue *txq;
 	uint16_t gen, qid, q_head;
 	uint16_t nb_desc_clean;
@@ -824,26 +851,20 @@ idpf_split_tx_free(struct idpf_complq *cq)
 		txq->nb_tx_free += nb_desc_clean;
 		txq->last_desc_cleaned = q_head;
 		break;
-	case IDPF_TXD_COMPLT_RS:
-		/* Walk from first segment to EOP, freeing each segment. */
-		txe = &txq->sw_ring[q_head];
-		if (txe->mbuf != NULL) {
-			uint16_t first = txe->first_id;
-			uint16_t idx = first;
-			uint16_t end = (q_head + 1 == txq->sw_nb_desc) ?
-					0 : q_head + 1;
-
-			do {
-				txe = &txq->sw_ring[idx];
-				if (txe->mbuf != NULL) {
-					rte_pktmbuf_free_seg(txe->mbuf);
-					txe->mbuf = NULL;
-				}
-				idx = (idx + 1 == txq->sw_nb_desc) ?
-					0 : idx + 1;
-			} while (idx != end);
+	case IDPF_TXD_COMPLT_RS: {
+		/* Shadow ring indexed by the software-defined compl_tag is
+		 * the sole source of truth for RS-time mbuf ownership; free
+		 * the whole multi-seg chain via mbuf->next in one call.
+		 */
+		uint16_t tag = q_head & txq->tx_pending_mask;
+		struct rte_mbuf *pkt = txq->tx_pending_pkts[tag];
+
+		if (pkt != NULL) {
+			rte_pktmbuf_free(pkt);
+			txq->tx_pending_pkts[tag] = NULL;
 		}
 		break;
+	}
 	default:
 		TX_LOG(ERR, "unknown completion type.");
 		return;
@@ -991,7 +1012,7 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 				tx_id = 0;
 		}
 
-		uint16_t first_sw_id = sw_id;
+		uint16_t tag = txq->tx_next_compl_tag++ & txq->tx_pending_mask;
 
 		do {
 			uint16_t slen = tx_pkt->data_len;
@@ -1010,7 +1031,7 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 				txd->qw1.cmd_dtype = cmd_dtype |
 					IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
 				txd->qw1.rxr_bufsize = CI_MAX_DATA_PER_TXD;
-				txd->qw1.compl_tag = sw_id;
+				txd->qw1.compl_tag = 0;
 
 				buf_dma_addr += CI_MAX_DATA_PER_TXD;
 				slen -= CI_MAX_DATA_PER_TXD;
@@ -1031,7 +1052,7 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			txd->qw1.cmd_dtype = cmd_dtype |
 				IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
 			txd->qw1.rxr_bufsize = slen;
-			txd->qw1.compl_tag = sw_id;
+			txd->qw1.compl_tag = 0;
 			tx_id++;
 			if (tx_id == txq->nb_tx_desc)
 				tx_id = 0;
@@ -1043,8 +1064,11 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		/* fill the last descriptor with End of Packet (EOP) bit */
 		txd->qw1.cmd_dtype |= IDPF_TXD_FLEX_FLOW_CMD_EOP;
 
-		/* Record first sw_id at EOP so completion can walk forward. */
-		sw_ring[txd->qw1.compl_tag].first_id = first_sw_id;
+		/* Stamp EOP with the rolling compl_tag; RS uses it to look up
+		 * the packet-head mbuf in the shadow ring.
+		 */
+		txd->qw1.compl_tag = tag;
+		txq->tx_pending_pkts[tag] = tx_pkts[nb_tx];
 
 		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
 		txq->rs_compl_count += nb_used;
-- 
2.34.1

