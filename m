Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAC7D2F32A
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:18:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F30840E13;
	Tue, 13 Jan 2026 16:15:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 3E29B40DD0
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:15:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768317344; x=1799853344;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=byIQ0SKQ95zddIbuv61jsbMkvUvWKC8KELTU7ukihj0=;
 b=LquahDjd6Tf5u+rjfyUzgqOuP7HyJxrzzqBBYz0foZn+nDyod3xvVusD
 242OvDCyKAXZmycWheyBhoYHLk/0DOf316fZCsh8r3CeGe+Nfw8ACBTVf
 xxIJnKOIbuJLhnDcRdByGFbnkNeZwktOk6d1fxi94Kfj0rwh5FDnROMVr
 Fcu61uOI6oE9rXKcNbyXchmQia/Ng64TY4wWmzF3CkyuRmUyWdKt3UGAM
 N0bjaH0+Yw8udrRC1DDdSx4DkS0VfrNwsudO8oipIFSRCbDkJYMalI2Ot
 hDqT1g8EmQ6ou+xR6mgW7Bl6mDK4CiprdRnBPvNcUTJporxFlAW695CKG A==;
X-CSE-ConnectionGUID: sVaWA1aORWiiU455NTVADQ==
X-CSE-MsgGUID: n4hrC6xhRtKkWkOTnn+4RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80969210"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="80969210"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 07:15:43 -0800
X-CSE-ConnectionGUID: 6PBhN6r2QCCRs7NDNYsu2w==
X-CSE-MsgGUID: lFOHBVxKTzmBKj5lsJrSGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="203556643"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 13 Jan 2026 07:15:42 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 24/36] net/intel: add special handling for single desc
 packets
Date: Tue, 13 Jan 2026 15:14:48 +0000
Message-ID: <20260113151505.1871271-25-bruce.richardson@intel.com>
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

Within the scalar packets, add a shortcut path for packets that don't
use TSO and have only a single data descriptor.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar_fns.h | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/intel/common/tx_scalar_fns.h b/drivers/net/intel/common/tx_scalar_fns.h
index 58196dc02a..3772cb4c3c 100644
--- a/drivers/net/intel/common/tx_scalar_fns.h
+++ b/drivers/net/intel/common/tx_scalar_fns.h
@@ -304,6 +304,31 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
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
@@ -395,6 +420,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 			txe = txn;
 			m_seg = m_seg->next;
 		} while (m_seg);
+end_pkt:
 		txq->nb_tx_used = (uint16_t)(txq->nb_tx_used + nb_used);
 		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
 
-- 
2.51.0

