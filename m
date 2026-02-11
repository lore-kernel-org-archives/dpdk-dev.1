Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E84ECD6D3
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 18:15:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E255840E4B;
	Wed, 11 Feb 2026 19:14:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 8EF4140E34
 for <dev@dpdk.org>; Wed, 11 Feb 2026 19:13:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770833636; x=1802369636;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G1eSC38yRm5cdld6iEDP4Z7q+ld7YljnObmsV/9pQr0=;
 b=ekHuqNM7pJg7qIjfCU5MUus8PHxS8fILebLhcli3C2U4qAndSIenA820
 Akn0JXS/AYsT5H3fEMUePudlLFq/e6jTsr3BPxXbGepQKFwMpZUQbQ8QF
 kmrFpcfCFt04Deq68aaAKzZSCdLuShl9cTuEhipXxW0rbSyri7iim2+C6
 MQPfvnUESVGhmtMnGhYzDOo6dAe4XdEu2DSNLtotoA6iz2TT2XpXJtQHU
 i1qIDaIDzkf74V1TRSELblA/8BFRDcAuiO7mkN0dtkMYq3RUh8wGIKTtI
 SyUVzE6+cg298Bcrs+VdQdG/MfzBvpx+J7XqJyZUZp5/iQSb9t76SYdyM g==;
X-CSE-ConnectionGUID: FLJJIHaJTq2C3RJ8p3aLmg==
X-CSE-MsgGUID: uDuY0v9yTVyzgo6bb9hDqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75834690"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="75834690"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 10:13:55 -0800
X-CSE-ConnectionGUID: cwJElzJ8RtufiK2q65wBdA==
X-CSE-MsgGUID: G3FrF1XyRVGFJC6A9Xqraw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="249986370"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 11 Feb 2026 10:13:54 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 22/35] net/intel: add special handling for single desc
 packets
Date: Wed, 11 Feb 2026 18:12:51 +0000
Message-ID: <20260211181309.2838042-23-bruce.richardson@intel.com>
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

Within the scalar packets, add a shortcut path for packets that don't
use TSO and have only a single data descriptor.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/common/tx_scalar.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index 56c2dd526f..0bc2956dcf 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -294,6 +294,31 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 			ci_txd_enable_checksum(ol_flags, &td_cmd,
 						&td_offset, tx_offload);
 
+		/* special case for single descriptor packet, without TSO offload */
+		if (nb_used == 1 &&
+				(ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) == 0) {
+			txd = &ci_tx_ring[tx_id];
+			tx_id = txe->next_id;
+
+			if (txe->mbuf)
+				rte_pktmbuf_free_seg(txe->mbuf);
+			*txe = (struct ci_tx_entry){
+				.mbuf = tx_pkt, .last_id = tx_last, .next_id = tx_id
+			};
+
+			/* Setup TX Descriptor */
+			td_cmd |= CI_TX_DESC_CMD_EOP;
+			const uint64_t cmd_type_offset_bsz = CI_TX_DESC_DTYPE_DATA |
+				((uint64_t)td_cmd << CI_TXD_QW1_CMD_S) |
+				((uint64_t)td_offset << CI_TXD_QW1_OFFSET_S) |
+				((uint64_t)tx_pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S) |
+				((uint64_t)td_tag << CI_TXD_QW1_L2TAG1_S);
+			write_txd(txd, rte_mbuf_data_iova(tx_pkt), cmd_type_offset_bsz);
+
+			txe = &sw_ring[tx_id];
+			goto end_pkt;
+		}
+
 		if (nb_ctx) {
 			/* Setup TX context descriptor if required */
 			uint64_t *ctx_txd = RTE_CAST_PTR(uint64_t *, &ci_tx_ring[tx_id]);
@@ -385,6 +410,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 			txe = txn;
 			m_seg = m_seg->next;
 		} while (m_seg);
+end_pkt:
 		txq->nb_tx_used = (uint16_t)(txq->nb_tx_used + nb_used);
 		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
 
-- 
2.51.0

