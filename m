Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB09FE6BF04
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 11:44:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA00040DDB;
	Fri, 30 Jan 2026 12:42:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id E103940B9C
 for <dev@dpdk.org>; Fri, 30 Jan 2026 12:42:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769773368; x=1801309368;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BEC87MBmfFGMynP52/LleVnlY5pl4YpRPmZZp9PBhnw=;
 b=XiFORnZCmzyll6MdPw07VuupEUGaZE+pbC3vF/ooxop9Am1nRB0mu7RB
 3X4RaBtzz6VlvxPSfCPAOCoySG1I4i0M3pCFHCIl3FuFmljY1aos0ntbw
 y6/z1o+TYqB8L+5pd8lmnz7T8RIotVluaE7/BxTQz/jnLglqQPQbIg+kd
 lO0+ud6a1ClNvzjBO80pRnkxH+ZSB8XAfpnFctwKc1lSq6nNEJr7NFCp2
 jUUg6Acb+MK2MJ+gBE3k9fu9IeKcdyO8Mj1wB0l2INxer7vIPTlECQh2z
 o5/wakymQgmMtklsfm0FmQCTKoGfOHoTpJnMWI21IlhpYwyTHtttPuGNi Q==;
X-CSE-ConnectionGUID: XKkwVyhnT/KS/TQOKJLUbA==
X-CSE-MsgGUID: 8IxV96x5QtqFNAUuHB7xMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82392323"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="82392323"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2026 03:42:47 -0800
X-CSE-ConnectionGUID: y0QU+XvUS6y7BlYF2l42ow==
X-CSE-MsgGUID: XLeP10HWRMeTZceX/UvUDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="209190544"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa010.fm.intel.com with ESMTP; 30 Jan 2026 03:42:46 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 24/36] net/intel: add special handling for single desc
 packets
Date: Fri, 30 Jan 2026 11:41:51 +0000
Message-ID: <20260130114207.1126032-25-bruce.richardson@intel.com>
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

Within the scalar packets, add a shortcut path for packets that don't
use TSO and have only a single data descriptor.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar_fns.h | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/intel/common/tx_scalar_fns.h b/drivers/net/intel/common/tx_scalar_fns.h
index 488130c813..8c4086296e 100644
--- a/drivers/net/intel/common/tx_scalar_fns.h
+++ b/drivers/net/intel/common/tx_scalar_fns.h
@@ -303,6 +303,31 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
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
@@ -394,6 +419,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 			txe = txn;
 			m_seg = m_seg->next;
 		} while (m_seg);
+end_pkt:
 		txq->nb_tx_used = (uint16_t)(txq->nb_tx_used + nb_used);
 		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
 
-- 
2.51.0

