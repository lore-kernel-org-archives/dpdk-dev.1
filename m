Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F6BC28B23
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Mar 2025 16:07:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49E3D40E3A;
	Fri,  7 Mar 2025 17:07:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 144AE40E39
 for <dev@dpdk.org>; Fri,  7 Mar 2025 17:07:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741363642; x=1772899642;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VcOaRvcwksoavucs888GNerQWbhEGlwHMccg6UhoG0Y=;
 b=kdXb/b18NHtx+ci1KJ2vvwMT0bls8h2IH8bj2YXsr8sGx8GsLWuhLYvm
 DMtBodAhbxmIp1Jz7L2NEt0Dd27Ag+ydQkC7E02j+Sdq2rf9LE4s0maxt
 yeAMqE265IkglcEGxDZ98P+oC9sn9J7Aok2A2gn6FYD8dsLF8M+oDA9KY
 WkAGWkTmOdsqmXbMh4qqFucn1WvQw9BWdH99hOYlTzvl8cL6UQAxqdcTQ
 ZWyKtQvyd3yv5lmw1cwXrxAgIyTCrF6xJaY+05ZCxv3pnWeugZaiPZ6Hi
 JDx5zxz39JsE+qnfHKTVeTj0RK3kGlyqJpwG3nxVa5SJ6cr67cqi1axez w==;
X-CSE-ConnectionGUID: 7Sb33jOcQo661AbfiBMxnQ==
X-CSE-MsgGUID: JDeQCnqtT/66SivO9qaRng==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42616354"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; d="scan'208";a="42616354"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2025 08:07:21 -0800
X-CSE-ConnectionGUID: z0MDnSsjSYyV5XjZE23zPw==
X-CSE-MsgGUID: rZgQoqXQRwWDkwbSP1oRpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; d="scan'208";a="119350164"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.43])
 by orviesa006.jf.intel.com with ESMTP; 07 Mar 2025 08:07:19 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Ian Stokes <ian.stokes@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Subject: [PATCH] net/intel: remove unused reassembly functions
Date: Fri,  7 Mar 2025 16:07:10 +0000
Message-ID: <20250307160711.747754-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
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

When creating a common pkt reassembly function for common driver Rx
re-use, not all original copies of the function were removed. Fix this
omission.

Fixes: 82fbc4a4479c ("net/intel: create common packet reassembly")

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/i40e/i40e_rxtx_vec_common.h | 63 ------------------
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 64 ------------------
 drivers/net/intel/ice/ice_rxtx_vec_common.h   | 65 -------------------
 3 files changed, 192 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_common.h b/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
index e988689d7b..ba72df8e13 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
@@ -12,69 +12,6 @@
 #include "i40e_ethdev.h"
 #include "i40e_rxtx.h"
 
-static inline uint16_t
-reassemble_packets(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_bufs,
-		   uint16_t nb_bufs, uint8_t *split_flags)
-{
-	struct rte_mbuf *pkts[RTE_I40E_VPMD_RX_BURST]; /*finished pkts*/
-	struct rte_mbuf *start = rxq->pkt_first_seg;
-	struct rte_mbuf *end =  rxq->pkt_last_seg;
-	unsigned pkt_idx, buf_idx;
-
-	for (buf_idx = 0, pkt_idx = 0; buf_idx < nb_bufs; buf_idx++) {
-		if (end != NULL) {
-			/* processing a split packet */
-			end->next = rx_bufs[buf_idx];
-			rx_bufs[buf_idx]->data_len += rxq->crc_len;
-
-			start->nb_segs++;
-			start->pkt_len += rx_bufs[buf_idx]->data_len;
-			end = end->next;
-
-			if (!split_flags[buf_idx]) {
-				/* it's the last packet of the set */
-				start->hash = end->hash;
-				start->vlan_tci = end->vlan_tci;
-				start->ol_flags = end->ol_flags;
-				/* we need to strip crc for the whole packet */
-				start->pkt_len -= rxq->crc_len;
-				if (end->data_len > rxq->crc_len)
-					end->data_len -= rxq->crc_len;
-				else {
-					/* free up last mbuf */
-					struct rte_mbuf *secondlast = start;
-
-					start->nb_segs--;
-					while (secondlast->next != end)
-						secondlast = secondlast->next;
-					secondlast->data_len -= (rxq->crc_len -
-							end->data_len);
-					secondlast->next = NULL;
-					rte_pktmbuf_free_seg(end);
-				}
-				pkts[pkt_idx++] = start;
-				start = end = NULL;
-			}
-		} else {
-			/* not processing a split packet */
-			if (!split_flags[buf_idx]) {
-				/* not a split packet, save and skip */
-				pkts[pkt_idx++] = rx_bufs[buf_idx];
-				continue;
-			}
-			end = start = rx_bufs[buf_idx];
-			rx_bufs[buf_idx]->data_len += rxq->crc_len;
-			rx_bufs[buf_idx]->pkt_len += rxq->crc_len;
-		}
-	}
-
-	/* save the partial packet for next time */
-	rxq->pkt_first_seg = start;
-	rxq->pkt_last_seg = end;
-	memcpy(rx_bufs, pkts, pkt_idx * (sizeof(*pkts)));
-	return pkt_idx;
-}
-
 static inline int
 i40e_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
 {
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
index 33b2bb0633..38e9a206d9 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
@@ -12,70 +12,6 @@
 #include "iavf.h"
 #include "iavf_rxtx.h"
 
-static __rte_always_inline uint16_t
-reassemble_packets(struct iavf_rx_queue *rxq, struct rte_mbuf **rx_bufs,
-		   uint16_t nb_bufs, uint8_t *split_flags)
-{
-	struct rte_mbuf *pkts[IAVF_VPMD_RX_MAX_BURST];
-	struct rte_mbuf *start = rxq->pkt_first_seg;
-	struct rte_mbuf *end =  rxq->pkt_last_seg;
-	unsigned int pkt_idx, buf_idx;
-
-	for (buf_idx = 0, pkt_idx = 0; buf_idx < nb_bufs; buf_idx++) {
-		if (end) {
-			/* processing a split packet */
-			end->next = rx_bufs[buf_idx];
-			rx_bufs[buf_idx]->data_len += rxq->crc_len;
-
-			start->nb_segs++;
-			start->pkt_len += rx_bufs[buf_idx]->data_len;
-			end = end->next;
-
-			if (!split_flags[buf_idx]) {
-				/* it's the last packet of the set */
-				start->hash = end->hash;
-				start->vlan_tci = end->vlan_tci;
-				start->ol_flags = end->ol_flags;
-				/* we need to strip crc for the whole packet */
-				start->pkt_len -= rxq->crc_len;
-				if (end->data_len > rxq->crc_len) {
-					end->data_len -= rxq->crc_len;
-				} else {
-					/* free up last mbuf */
-					struct rte_mbuf *secondlast = start;
-
-					start->nb_segs--;
-					while (secondlast->next != end)
-						secondlast = secondlast->next;
-					secondlast->data_len -= (rxq->crc_len -
-							end->data_len);
-					secondlast->next = NULL;
-					rte_pktmbuf_free_seg(end);
-				}
-				pkts[pkt_idx++] = start;
-				start = NULL;
-				end = NULL;
-			}
-		} else {
-			/* not processing a split packet */
-			if (!split_flags[buf_idx]) {
-				/* not a split packet, save and skip */
-				pkts[pkt_idx++] = rx_bufs[buf_idx];
-				continue;
-			}
-			end = start = rx_bufs[buf_idx];
-			rx_bufs[buf_idx]->data_len += rxq->crc_len;
-			rx_bufs[buf_idx]->pkt_len += rxq->crc_len;
-		}
-	}
-
-	/* save the partial packet for next time */
-	rxq->pkt_first_seg = start;
-	rxq->pkt_last_seg = end;
-	memcpy(rx_bufs, pkts, pkt_idx * (sizeof(*pkts)));
-	return pkt_idx;
-}
-
 static inline int
 iavf_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
 {
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_common.h b/drivers/net/intel/ice/ice_rxtx_vec_common.h
index 7d9a54e38f..7933c26366 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
+++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
@@ -8,71 +8,6 @@
 #include "../common/rx.h"
 #include "ice_rxtx.h"
 
-static inline uint16_t
-ice_rx_reassemble_packets(struct ice_rx_queue *rxq, struct rte_mbuf **rx_bufs,
-			  uint16_t nb_bufs, uint8_t *split_flags)
-{
-	struct rte_mbuf *pkts[ICE_VPMD_RX_BURST] = {0}; /*finished pkts*/
-	struct rte_mbuf *start = rxq->pkt_first_seg;
-	struct rte_mbuf *end =  rxq->pkt_last_seg;
-	unsigned int pkt_idx, buf_idx;
-
-	for (buf_idx = 0, pkt_idx = 0; buf_idx < nb_bufs; buf_idx++) {
-		if (end) {
-			/* processing a split packet */
-			end->next = rx_bufs[buf_idx];
-			rx_bufs[buf_idx]->data_len += rxq->crc_len;
-
-			start->nb_segs++;
-			start->pkt_len += rx_bufs[buf_idx]->data_len;
-			end = end->next;
-
-			if (!split_flags[buf_idx]) {
-				/* it's the last packet of the set */
-				start->hash = end->hash;
-				start->vlan_tci = end->vlan_tci;
-				start->ol_flags = end->ol_flags;
-				/* we need to strip crc for the whole packet */
-				start->pkt_len -= rxq->crc_len;
-				if (end->data_len > rxq->crc_len) {
-					end->data_len -= rxq->crc_len;
-				} else {
-					/* free up last mbuf */
-					struct rte_mbuf *secondlast = start;
-
-					start->nb_segs--;
-					while (secondlast->next != end)
-						secondlast = secondlast->next;
-					secondlast->data_len -= (rxq->crc_len -
-							end->data_len);
-					secondlast->next = NULL;
-					rte_pktmbuf_free_seg(end);
-				}
-				pkts[pkt_idx++] = start;
-				start = NULL;
-				end = NULL;
-			}
-		} else {
-			/* not processing a split packet */
-			if (!split_flags[buf_idx]) {
-				/* not a split packet, save and skip */
-				pkts[pkt_idx++] = rx_bufs[buf_idx];
-				continue;
-			}
-			start = rx_bufs[buf_idx];
-			end = start;
-			rx_bufs[buf_idx]->data_len += rxq->crc_len;
-			rx_bufs[buf_idx]->pkt_len += rxq->crc_len;
-		}
-	}
-
-	/* save the partial packet for next time */
-	rxq->pkt_first_seg = start;
-	rxq->pkt_last_seg = end;
-	memcpy(rx_bufs, pkts, pkt_idx * (sizeof(*pkts)));
-	return pkt_idx;
-}
-
 static inline int
 ice_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
 {
-- 
2.43.0

