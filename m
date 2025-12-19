Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BB6E66880
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Dec 2025 17:28:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9548E40BA2;
	Fri, 19 Dec 2025 18:26:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 914FC40A79
 for <dev@dpdk.org>; Fri, 19 Dec 2025 18:26:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766165199; x=1797701199;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iRw/YXotiO5TUGJePT67kuUrghf0gEiylNOCuV5tDPg=;
 b=aIo6S5KOo383pDULL8Rt0X3w4SjYXhYlLyCyPBvEc5Trl0eZbxnh9Ei+
 zlQ6Rq9Z8DqImV1idoSS1B145iN/MjHj91L6uOXwo89+ixfII/ZImnfhh
 VeTyYIejRahfJf7DQ2HAkosN3UWIHjpa7UJfL8lUq8HwDWAW0vgZE28zS
 J70SVE7NGl714dVFjpiuH3+Q9TTe98Xk7S4b8p8myhZlfpA2jpNl3uPx5
 xtHqltHyBgKI7ytIezIx8aDjpiabVyXODySP7vLJEFkCRR+qjD+cQhR+M
 DixD0QI/ujsePMOhOaUDpm10julfWrOsC9rxLDmEHr+ojWX5mX0i+MCqE g==;
X-CSE-ConnectionGUID: gpVtOpPyQC+j1/euyfry2w==
X-CSE-MsgGUID: SQw3qf6YS42qF9lQeLjqLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="71759515"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; d="scan'208";a="71759515"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2025 09:26:38 -0800
X-CSE-ConnectionGUID: l7om2716Re2dHr5DD2TchQ==
X-CSE-MsgGUID: sp9XXqokTCel97TxQjo2lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; d="scan'208";a="198170517"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 19 Dec 2025 09:26:37 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 23/27] net/intel: add special handling for single desc
 packets
Date: Fri, 19 Dec 2025 17:25:40 +0000
Message-ID: <20251219172548.2660777-24-bruce.richardson@intel.com>
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

Within the scalar packets, add a shortcut path for packets that don't
use TSO and have only a single data descriptor.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar_fns.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/intel/common/tx_scalar_fns.h b/drivers/net/intel/common/tx_scalar_fns.h
index 27791cf138..55502b46ed 100644
--- a/drivers/net/intel/common/tx_scalar_fns.h
+++ b/drivers/net/intel/common/tx_scalar_fns.h
@@ -304,6 +304,28 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 			ci_txd_enable_checksum(ol_flags, &td_cmd,
 						&td_offset, tx_offload);
 
+		/* special case for single descriptor packet, without TSO offload */
+		if (nb_used == 1 && (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) == 0) {
+			txd = &ci_tx_ring[tx_id];
+			tx_id = txe->next_id;
+
+			if (txe->mbuf)
+				rte_pktmbuf_free_seg(txe->mbuf);
+			*txe = (struct ci_tx_entry){ .mbuf = tx_pkt, .last_id = tx_last, .next_id = tx_id };
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
@@ -395,6 +417,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 			txe = txn;
 			m_seg = m_seg->next;
 		} while (m_seg);
+end_pkt:
 		txq->nb_tx_used = (uint16_t)(txq->nb_tx_used + nb_used);
 		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
 
-- 
2.51.0

