Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E2EE7E0BC
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 16:48:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3212940E32;
	Mon,  9 Feb 2026 17:46:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 34C4240DDE
 for <dev@dpdk.org>; Mon,  9 Feb 2026 17:46:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770655568; x=1802191568;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hrOMDlzO+hPgFxXb0HIzKPIuXkcWqy0keP40MP9oLpw=;
 b=HX1/YeoigUD4yEOcabUIDeeYVl2FKK7xxsRgPLWrRIsVzK3Y4uq8pVZF
 G+McdjILY6B7Gk/XFo5ISVAtJSsB/Eysk/MAFSYSSOOWXPDLbHplclFk/
 EQsVW8msecE/xbLwvmZdoGd14w9MAkhGaKZFQp7NM8RHvOx7vBJWdV/VC
 pnncD5SKevtJ3dMRiUqJovrBVq7fQQybvf7OZ2suFvlbfvkLs9sRS2zZU
 4UfsJyOH1PGQQmHsu7g7rHDR1aVMiMfbKmleVafX2SCaShn7xEaNbcSKp
 uIMPiu/UdmYtXBTWDYzgn9mDN4tRXpsMzS99Ax6RoyzbG/Sbpl8ZeaLpR Q==;
X-CSE-ConnectionGUID: AtC8063bRJeSErRbiN1Gcw==
X-CSE-MsgGUID: DctW9MQwSlaaOUeim3vwsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71663476"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71663476"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 08:46:08 -0800
X-CSE-ConnectionGUID: jb7RxUCzQ6WmUq0xdWkVXg==
X-CSE-MsgGUID: 1kteBbO6SwiRE4kj9/vJRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="210789176"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 09 Feb 2026 08:46:07 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 23/35] net/intel: add special handling for single desc
 packets
Date: Mon,  9 Feb 2026 16:45:21 +0000
Message-ID: <20260209164538.1428499-24-bruce.richardson@intel.com>
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

Within the scalar packets, add a shortcut path for packets that don't
use TSO and have only a single data descriptor.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index cee8f11c7f..342e271c5f 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -298,6 +298,31 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
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
@@ -389,6 +414,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 			txe = txn;
 			m_seg = m_seg->next;
 		} while (m_seg);
+end_pkt:
 		txq->nb_tx_used = (uint16_t)(txq->nb_tx_used + nb_used);
 		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
 
-- 
2.51.0

