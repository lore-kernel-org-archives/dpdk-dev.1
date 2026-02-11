Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8563ECD6D3
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 18:16:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7F6340EDD;
	Wed, 11 Feb 2026 19:14:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 978DC40E5A
 for <dev@dpdk.org>; Wed, 11 Feb 2026 19:14:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770833642; x=1802369642;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NDeCvSRexQxsGlWTmkY5nvbI8U5SnLY0Umi0gNsSk7o=;
 b=nKEwv6M/lIEnTyG4wVzozXNop+Mwmvl2JZA6xnKD873imBQhTJ3YSDQJ
 3vDVTqaPtTe4Xrydxuqj6HtS/A2sGK8WZmuRaRepmVX7Wj7deLjxiej3e
 m4wF6qHurhREvXahCOOTu1cUrYvqejJzzoGmfj07jf43xiW45GW3Veq5B
 orHIW7e8NT9V6eSkCZ/EvJ3fIZo12ZrxGqCR2QuIakCR/CkySfzXt9VYm
 Z9cJHYGs2LTgXWlTQp6ADjoN9pd5EzhJpiFd1EFmeBEas9Hwfo18afKEz
 u1XSop2CKi/FlXNBWIactcqTAo/nam5N/qwIRXUGeFoEi7ZYyhjDpuCiK g==;
X-CSE-ConnectionGUID: 9ycg+XaSQuCO1EFkipjvcw==
X-CSE-MsgGUID: e0Y8EPsYQc63KsiJpzNAYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75834696"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="75834696"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 10:14:01 -0800
X-CSE-ConnectionGUID: 3iCrE8apSx6GWSrPOCc3Cw==
X-CSE-MsgGUID: Bncb6PUASHqiYLwFb0sjNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="249986384"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 11 Feb 2026 10:14:00 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Subject: [PATCH v5 26/35] net/intel: remove index for tracking end of packet
Date: Wed, 11 Feb 2026 18:12:55 +0000
Message-ID: <20260211181309.2838042-27-bruce.richardson@intel.com>
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

The last_id value in each tx_sw_queue entry was no longer used in the
datapath, remove it and its initialization. For the function releasing
packets back, rather than relying on "last_id" to identify end of
packet, instead check for the next pointer being NULL.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
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
index a4ef230523..ee7c83cf00 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -112,7 +112,6 @@ struct ci_tx_queue;
 struct ci_tx_entry {
 	struct rte_mbuf *mbuf; /* mbuf associated with TX desc, if any. */
 	uint16_t next_id; /* Index of next descriptor in ring. */
-	uint16_t last_id; /* Index of last scattered descriptor. */
 };
 
 /**
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 1303010819..ba94c59c0a 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -2536,14 +2536,13 @@ i40e_tx_done_cleanup_full(struct ci_tx_queue *txq,
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
@@ -2636,7 +2635,6 @@ i40e_reset_tx_queue(struct ci_tx_queue *txq)
 		txd->cmd_type_offset_bsz =
 			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE);
 		txe[i].mbuf =  NULL;
-		txe[i].last_id = i;
 		txe[prev].next_id = i;
 		prev = i;
 	}
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 05aca9b1dd..e621d4bf47 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -282,7 +282,6 @@ reset_tx_queue(struct ci_tx_queue *txq)
 		txq->ci_tx_ring[i].cmd_type_offset_bsz =
 			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE);
 		txe[i].mbuf =  NULL;
-		txe[i].last_id = i;
 		txe[prev].next_id = i;
 		prev = i;
 	}
@@ -3957,14 +3956,14 @@ iavf_tx_done_cleanup_full(struct ci_tx_queue *txq,
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
index 87ffcd3895..fe65df94da 100644
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
@@ -3201,14 +3200,14 @@ ice_tx_done_cleanup_full(struct ci_tx_queue *txq,
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
index c2dcf3cde3..f14a20d6ec 100644
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
index ea609d926a..dc9fda8e21 100644
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

