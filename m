Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9510FEB362F
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 15:00:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 972B6402B0;
	Tue,  3 Mar 2026 16:00:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 59BB240268;
 Tue,  3 Mar 2026 16:00:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772550044; x=1804086044;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gF2Im5Rn5nc91hZiYJmB4Yv0m9Lzv+XlyvlF7U626Y0=;
 b=Vz9hVHRk19DvXNcvHj2ODkd6gK8dqmaaJ5dqChvDwMgaslGmFdJH1a8A
 Pb0PqNrW6O7AJ9krcysnCkNy3lYDPEK5EjjeyF7dJtb7DSfLUQf/9nXqS
 1SvmWmFqDPamHhGgPhtCN1ILmewhiJSBc9ligDJn9rKfvTW+Xl2hZIKk4
 dLhSoO7jeAgdOAu5JoTpU+snjhvFLHbuu4keYXFxh4JubdH0pIW9hUsEf
 vo12bC2tLrEkQEusAQBqdSqATLrMvQJG/sYnuMQAXcr5RjSTCc782C4T+
 l/slLBDC2EWg9ezS5jPmS9y4RpLiUG3nLl/IauOYniA9fK0Ow4DBaXQK3 Q==;
X-CSE-ConnectionGUID: oo8qRtofRuuM3/66mCIUkA==
X-CSE-MsgGUID: 02XHyO0eTTmtIlYFEOlT1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="73640201"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; d="scan'208";a="73640201"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2026 07:00:39 -0800
X-CSE-ConnectionGUID: guWefQ5PQqmE70reLqOCKQ==
X-CSE-MsgGUID: 464mrS6RTCitywOFThWlog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; d="scan'208";a="217970446"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa009.jf.intel.com with ESMTP; 03 Mar 2026 07:00:37 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Xiaoyun Li <xiaoyun.li@intel.com>, Beilei Xing <beilei.xing@intel.com>,
 Junfeng Guo <junfengg@nvidia.com>
Subject: [PATCH] net/idpf: handle Tx of mbuf segments larger than 16k
Date: Tue,  3 Mar 2026 15:00:26 +0000
Message-ID: <20260303150026.1601461-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
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

Recent rework of the Tx single-queue path in idpf aligned that path with
that of other drivers, meaning it now supports segments of size greater
than 16k. Rework the split-queue path to similarly support those large
segments.

Fixes: 770f4dfe0f79 ("net/idpf: support basic Tx data path")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/idpf/idpf_common_rxtx.c | 98 ++++++++++++++---------
 1 file changed, 60 insertions(+), 38 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index b8f6418d4a..981b4b8eee 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -890,7 +890,7 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	volatile struct idpf_flex_tx_sched_desc *txd;
 	struct ci_tx_entry *sw_ring;
 	union ci_tx_offload tx_offload = {0};
-	struct ci_tx_entry *txe, *txn;
+	struct ci_tx_entry *txe;
 	uint16_t nb_used, tx_id, sw_id;
 	struct rte_mbuf *tx_pkt;
 	uint16_t nb_to_clean;
@@ -911,44 +911,44 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
 		tx_pkt = tx_pkts[nb_tx];
 
-		if (txq->nb_tx_free <= txq->tx_free_thresh) {
-			/* TODO: Need to refine
-			 * 1. free and clean: Better to decide a clean destination instead of
-			 * loop times. And don't free mbuf when RS got immediately, free when
-			 * transmit or according to the clean destination.
-			 * Now, just ignore the RE write back, free mbuf when get RS
-			 * 2. out-of-order rewrite back haven't be supported, SW head and HW head
-			 * need to be separated.
-			 **/
-			nb_to_clean = 2 * txq->tx_rs_thresh;
-			while (nb_to_clean--)
-				idpf_split_tx_free(txq->complq);
-		}
-
-		if (txq->nb_tx_free < tx_pkt->nb_segs)
-			break;
-
 		cmd_dtype = 0;
 		ol_flags = tx_pkt->ol_flags;
 		tx_offload.l2_len = tx_pkt->l2_len;
 		tx_offload.l3_len = tx_pkt->l3_len;
 		tx_offload.l4_len = tx_pkt->l4_len;
 		tx_offload.tso_segsz = tx_pkt->tso_segsz;
+
 		/* Calculate the number of context descriptors needed. */
 		uint64_t cd_qw0 = 0, cd_qw1 = 0;
 		nb_ctx = idpf_set_tso_ctx(ol_flags, tx_pkt, &tx_offload, txq,
 					  &cd_qw0, &cd_qw1);
 
-		/* Calculate the number of TX descriptors needed for
-		 * each packet. For TSO packets, use ci_calc_pkt_desc as
-		 * the mbuf data size might exceed max data size that hw allows
-		 * per tx desc.
+		/* Calculate the number of TX descriptors needed for each packet.
+		 * For TSO packets, use ci_calc_pkt_desc as the mbuf data size
+		 * might exceed the max data size that hw allows per tx desc.
 		 */
-		if (ol_flags & RTE_MBUF_F_TX_TCP_SEG)
+		if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
 			nb_used = ci_calc_pkt_desc(tx_pkt) + nb_ctx;
 		else
 			nb_used = tx_pkt->nb_segs + nb_ctx;
 
+		if (txq->nb_tx_free <= txq->tx_free_thresh) {
+			/* TODO: Need to refine
+			 * 1. free and clean: Better to decide a clean destination instead of
+			 * loop times. And don't free mbuf when RS got immediately, free when
+			 * transmit or according to the clean destination.
+			 * Now, just ignore the RE write back, free mbuf when get RS
+			 * 2. out-of-order rewrite back haven't be supported, SW head and HW head
+			 * need to be separated.
+			 **/
+			nb_to_clean = 2 * txq->tx_rs_thresh;
+			while (nb_to_clean--)
+				idpf_split_tx_free(txq->complq);
+		}
+
+		if (txq->nb_tx_free < nb_used)
+			break;
+
 		if (ol_flags & CI_TX_CKSUM_OFFLOAD_MASK)
 			cmd_dtype = IDPF_TXD_FLEX_FLOW_CMD_CS_EN;
 
@@ -959,30 +959,52 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			ctx_desc[0] = cd_qw0;
 			ctx_desc[1] = cd_qw1;
 
-			tx_id++;
-			if (tx_id == txq->nb_tx_desc)
+			if (++tx_id == txq->nb_tx_desc)
 				tx_id = 0;
 		}
 
+		cmd_dtype |= IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
+		struct rte_mbuf *m_seg = tx_pkt;
 		do {
-			txd = &txr[tx_id];
-			txn = &sw_ring[txe->next_id];
-			txe->mbuf = tx_pkt;
+			uint64_t buf_dma_addr = rte_mbuf_data_iova(m_seg);
+			uint16_t slen = m_seg->data_len;
+
+			txe->mbuf = m_seg;
+
+			/* For TSO, split large segments that exceed the
+			 * per-descriptor data limit, matching the behaviour of
+			 * ci_xmit_pkts() on the singleq path.
+			 */
+			while ((ol_flags & (RTE_MBUF_F_TX_TCP_SEG |
+					    RTE_MBUF_F_TX_UDP_SEG)) &&
+					unlikely(slen > CI_MAX_DATA_PER_TXD)) {
+				txd = &txr[tx_id];
+				txd->buf_addr = rte_cpu_to_le_64(buf_dma_addr);
+				txd->qw1.cmd_dtype = cmd_dtype;
+				txd->qw1.rxr_bufsize = CI_MAX_DATA_PER_TXD;
+				txd->qw1.compl_tag = sw_id;
+				buf_dma_addr += CI_MAX_DATA_PER_TXD;
+				slen -= CI_MAX_DATA_PER_TXD;
+				if (++tx_id == txq->nb_tx_desc)
+					tx_id = 0;
+				sw_id = txe->next_id;
+				txe = &sw_ring[sw_id];
+				/* sub-descriptor slots do not own the mbuf */
+				txe->mbuf = NULL;
+			}
 
-			/* Setup TX descriptor */
-			txd->buf_addr =
-				rte_cpu_to_le_64(rte_mbuf_data_iova(tx_pkt));
-			cmd_dtype |= IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
+			/* Write the final (or only) descriptor for this segment */
+			txd = &txr[tx_id];
+			txd->buf_addr = rte_cpu_to_le_64(buf_dma_addr);
 			txd->qw1.cmd_dtype = cmd_dtype;
-			txd->qw1.rxr_bufsize = tx_pkt->data_len;
+			txd->qw1.rxr_bufsize = slen;
 			txd->qw1.compl_tag = sw_id;
-			tx_id++;
-			if (tx_id == txq->nb_tx_desc)
+			if (++tx_id == txq->nb_tx_desc)
 				tx_id = 0;
 			sw_id = txe->next_id;
-			txe = txn;
-			tx_pkt = tx_pkt->next;
-		} while (tx_pkt);
+			txe = &sw_ring[sw_id];
+			m_seg = m_seg->next;
+		} while (m_seg);
 
 		/* fill the last descriptor with End of Packet (EOP) bit */
 		txd->qw1.cmd_dtype |= IDPF_TXD_FLEX_FLOW_CMD_EOP;
-- 
2.51.0

