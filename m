Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4C1D2F32A
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:19:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68D1940E2B;
	Tue, 13 Jan 2026 16:15:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 96E0D40E0F
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:15:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768317350; x=1799853350;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=82IPKBjV9LEJyccz2E6iG5RVK1QSeBcM7FiH6mc6RtY=;
 b=fwcS7Np3kZQAqNvJF8qkDzEHZey3c3H+pvRrdS/lsuDT241cyHBPMI/5
 /qoWKaRduTze0DnJ+sK/2XY+Abj3SaZ68pk6PIeCaefpYXX3nk+Y41NGv
 RpeVLFPWF3+2tp3F5E9vsQq+xVPwhTPSqCFFyv2R4P/XJrwqilAxji4f0
 UCL6qKQ2tN/Oc2i58QULM0Ki7oUjQLIncqv2GOxnx89tVELklwvGkZ9++
 knyed/nayod1OBlHeM/O98CMEm30Sj0AZi566IMsKR/ns2hMaGWaM/3So
 BVbXwyFyISKeEIcubSSRl83oi+IQ7e81cYAKZx3ZGWbAXWUquzFA7XVHx g==;
X-CSE-ConnectionGUID: nalypLTFSSqXkCehqwEU5g==
X-CSE-MsgGUID: 2AeVjZ1fQaeypw+sgTxShA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80969226"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="80969226"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 07:15:49 -0800
X-CSE-ConnectionGUID: DaFH5ysnSdq7nnBSuHfpyQ==
X-CSE-MsgGUID: Oqk6NSUjRd20XBW5ZTm58A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="203556656"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 13 Jan 2026 07:15:48 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Subject: [PATCH v2 28/36] net/intel: remove index for tracking end of packet
Date: Tue, 13 Jan 2026 15:14:52 +0000
Message-ID: <20260113151505.1871271-29-bruce.richardson@intel.com>
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

The last_id value in each tx_sw_queue entry was no longer used in the
datapath, remove it and its initialization. For the function releasing
packets back, rather than relying on "last_id" to identify end of
packet, instead check for the next pointer being NULL.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx.h             | 1 -
 drivers/net/intel/i40e/i40e_rxtx.c        | 8 +++-----
 drivers/net/intel/iavf/iavf_rxtx.c        | 9 ++++-----
 drivers/net/intel/ice/ice_dcf_ethdev.c    | 1 -
 drivers/net/intel/ice/ice_rxtx.c          | 9 ++++-----
 drivers/net/intel/idpf/idpf_common_rxtx.c | 2 --
 drivers/net/intel/ixgbe/ixgbe_rxtx.c      | 9 ++++-----
 7 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 3976766f06..2d3626cbda 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -104,7 +104,6 @@ struct ci_tx_queue;
 struct ci_tx_entry {
 	struct rte_mbuf *mbuf; /* mbuf associated with TX desc, if any. */
 	uint16_t next_id; /* Index of next descriptor in ring. */
-	uint16_t last_id; /* Index of last scattered descriptor. */
 };
 
 /**
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 812a9a7a83..985d84c0f6 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -2521,14 +2521,13 @@ i40e_tx_done_cleanup_full(struct ci_tx_queue *txq,
 			pkt_cnt < free_cnt &&
 			tx_id != tx_last; i++) {
 			if (swr_ring[tx_id].mbuf != NULL) {
-				rte_pktmbuf_free_seg(swr_ring[tx_id].mbuf);
-				swr_ring[tx_id].mbuf = NULL;
-
 				/*
 				 * last segment in the packet,
 				 * increment packet count
 				 */
-				pkt_cnt += (swr_ring[tx_id].last_id == tx_id);
+				pkt_cnt += (swr_ring[tx_id].mbuf->next == NULL) ? 1 : 0;
+				rte_pktmbuf_free_seg(swr_ring[tx_id].mbuf);
+				swr_ring[tx_id].mbuf = NULL;
 			}
 
 			tx_id = swr_ring[tx_id].next_id;
@@ -2621,7 +2620,6 @@ i40e_reset_tx_queue(struct ci_tx_queue *txq)
 		txd->cmd_type_offset_bsz =
 			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE);
 		txe[i].mbuf =  NULL;
-		txe[i].last_id = i;
 		txe[prev].next_id = i;
 		prev = i;
 	}
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 5227227b5a..5a4fea03ac 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -296,7 +296,6 @@ reset_tx_queue(struct ci_tx_queue *txq)
 		txq->ci_tx_ring[i].cmd_type_offset_bsz =
 			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE);
 		txe[i].mbuf =  NULL;
-		txe[i].last_id = i;
 		txe[prev].next_id = i;
 		prev = i;
 	}
@@ -3965,14 +3964,14 @@ iavf_tx_done_cleanup_full(struct ci_tx_queue *txq,
 	while (pkt_cnt < free_cnt) {
 		do {
 			if (swr_ring[tx_id].mbuf != NULL) {
-				rte_pktmbuf_free_seg(swr_ring[tx_id].mbuf);
-				swr_ring[tx_id].mbuf = NULL;
-
 				/*
 				 * last segment in the packet,
 				 * increment packet count
 				 */
-				pkt_cnt += (swr_ring[tx_id].last_id == tx_id);
+				pkt_cnt += (swr_ring[tx_id].mbuf->next == NULL) ? 1 : 0;
+				rte_pktmbuf_free_seg(swr_ring[tx_id].mbuf);
+				swr_ring[tx_id].mbuf = NULL;
+
 			}
 
 			tx_id = swr_ring[tx_id].next_id;
diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice/ice_dcf_ethdev.c
index 02a23629d6..abd7875e7b 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
@@ -408,7 +408,6 @@ reset_tx_queue(struct ci_tx_queue *txq)
 		txq->ci_tx_ring[i].cmd_type_offset_bsz =
 			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE);
 		txe[i].mbuf =  NULL;
-		txe[i].last_id = i;
 		txe[prev].next_id = i;
 		prev = i;
 	}
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 3c1e1d762e..7261c07265 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -1121,7 +1121,6 @@ ice_reset_tx_queue(struct ci_tx_queue *txq)
 		txd->cmd_type_offset_bsz =
 			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE);
 		txe[i].mbuf =  NULL;
-		txe[i].last_id = i;
 		txe[prev].next_id = i;
 		prev = i;
 	}
@@ -3186,14 +3185,14 @@ ice_tx_done_cleanup_full(struct ci_tx_queue *txq,
 			pkt_cnt < free_cnt &&
 			tx_id != tx_last; i++) {
 			if (swr_ring[tx_id].mbuf != NULL) {
-				rte_pktmbuf_free_seg(swr_ring[tx_id].mbuf);
-				swr_ring[tx_id].mbuf = NULL;
-
 				/*
 				 * last segment in the packet,
 				 * increment packet count
 				 */
-				pkt_cnt += (swr_ring[tx_id].last_id == tx_id);
+				pkt_cnt += swr_ring[tx_id].mbuf->next == NULL ? 1 : 0;
+				rte_pktmbuf_free_seg(swr_ring[tx_id].mbuf);
+				swr_ring[tx_id].mbuf = NULL;
+
 			}
 
 			tx_id = swr_ring[tx_id].next_id;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index b36e29c8d2..781310e564 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -218,7 +218,6 @@ idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq)
 	prev = (uint16_t)(txq->sw_nb_desc - 1);
 	for (i = 0; i < txq->sw_nb_desc; i++) {
 		txe[i].mbuf = NULL;
-		txe[i].last_id = i;
 		txe[prev].next_id = i;
 		prev = i;
 	}
@@ -277,7 +276,6 @@ idpf_qc_single_tx_queue_reset(struct ci_tx_queue *txq)
 		txq->ci_tx_ring[i].cmd_type_offset_bsz =
 			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE);
 		txe[i].mbuf =  NULL;
-		txe[i].last_id = i;
 		txe[prev].next_id = i;
 		prev = i;
 	}
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 6b8ff20f61..5f4bee4f2f 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -2407,14 +2407,14 @@ ixgbe_tx_done_cleanup_full(struct ci_tx_queue *txq, uint32_t free_cnt)
 			pkt_cnt < free_cnt &&
 			tx_id != tx_last; i++) {
 			if (swr_ring[tx_id].mbuf != NULL) {
-				rte_pktmbuf_free_seg(swr_ring[tx_id].mbuf);
-				swr_ring[tx_id].mbuf = NULL;
-
 				/*
 				 * last segment in the packet,
 				 * increment packet count
 				 */
-				pkt_cnt += (swr_ring[tx_id].last_id == tx_id);
+				pkt_cnt += swr_ring[tx_id].mbuf->next == NULL ? 1 : 0;
+				rte_pktmbuf_free_seg(swr_ring[tx_id].mbuf);
+				swr_ring[tx_id].mbuf = NULL;
+
 			}
 
 			tx_id = swr_ring[tx_id].next_id;
@@ -2535,7 +2535,6 @@ ixgbe_reset_tx_queue(struct ci_tx_queue *txq)
 
 		txd->wb.status = rte_cpu_to_le_32(IXGBE_TXD_STAT_DD);
 		txe[i].mbuf = NULL;
-		txe[i].last_id = i;
 		txe[prev].next_id = i;
 		prev = i;
 	}
-- 
2.51.0

