Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D72C61DE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 10:26:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 271F04042F;
	Mon, 31 Aug 2026 12:26:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 221B840659;
 Mon, 31 Aug 2026 12:26:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788171992; x=1819707992;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QrBi0e/jBNvZ6adrQxg7uGTuX5X3BdHgKijJ4hrg+5c=;
 b=nL2JjG5v1UnA8PpItlr44vkgUlowxZFeqfKFeuxIz1YIy6fBe6vpaxHP
 aB6WnXTENaEqIjj6v0p7ARXVHfIP4jxhxPO0BH1ldLk0bV69vlOo/koLI
 vMaVU0FSelqnS4eDzuQZOUdngR8KQRQQDhH9IpQbbciO7gsRK2qDcM1Ft
 x5LD19ukfOk2eavSV9gdoeJnx4oF7JbqBdEF4fnDI3qcw+n6v/F9Ztqw9
 ftQcLpdox3rfg3Fd6llK8PB0xdQbGDyaa3BJ59I+r5nL6QJXPgbPj1jps
 n08pp9DxDHsqIL/RbMo86F8oBLpFRfYXw6NjByB/CNjSuGLnikVye2HA8 w==;
X-CSE-ConnectionGUID: x2DGfB7YTJSXrNslcxRQUw==
X-CSE-MsgGUID: 3Bdcgc4EQtGSP5s5U7v5Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88452417"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="88452417"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 03:26:32 -0700
X-CSE-ConnectionGUID: OvgBuq+nSF6U93o3fdrJRA==
X-CSE-MsgGUID: ZQfl+79NRgKoXH6lqBhbag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="267424146"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 31 Aug 2026 03:26:30 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Abhijit Sinha <abhijit.sinha@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>
Subject: [PATCH 2/7] net/iavf: fix VLAN tag placement logic
Date: Mon, 31 Aug 2026 11:26:15 +0100
Message-ID: <20260831102621.495759-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831102621.495759-1-bruce.richardson@intel.com>
References: <20260831102621.495759-1-bruce.richardson@intel.com>
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

Depending on what is reported by the PF to the VF the VLAN tag or VLAN +
QinQ tags can be in either the L2Tag1 or the L2Tag2 fields. This needs
to be taken into account when reading the vlan tags from the flex
descriptors, rather than assuming that the tag is always present in a
fixed location.

Fixes: 1e728b01120c ("net/iavf: rework Tx path")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx.c | 49 +++++++++++++++---------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index d65a518f8e..39bcbebf56 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -1151,33 +1151,32 @@ iavf_rxd_to_vlan_tci(struct rte_mbuf *mb, volatile union ci_rx_desc *rxdp)

 static inline void
 iavf_flex_rxd_to_vlan_tci(struct rte_mbuf *mb,
-			  volatile union ci_rx_flex_desc *rxdp)
+			  volatile union ci_rx_flex_desc *rxdp,
+			  uint8_t rx_flags)
 {
-	if (rte_le_to_cpu_64(rxdp->wb.status_error0) &
-		(1 << IAVF_RX_FLEX_DESC_STATUS0_L2TAG1P_S)) {
-		mb->ol_flags |= RTE_MBUF_F_RX_VLAN |
-				RTE_MBUF_F_RX_VLAN_STRIPPED;
-		mb->vlan_tci =
-			rte_le_to_cpu_16(rxdp->wb.l2tag1);
-	} else {
-		mb->vlan_tci = 0;
-	}
-
-	if (rte_le_to_cpu_16(rxdp->wb.status_error1) &
-	    (1 << IAVF_RX_FLEX_DESC_STATUS1_L2TAG2P_S)) {
-		if ((mb->ol_flags & RTE_MBUF_F_RX_VLAN_STRIPPED) == 0) {
-			mb->ol_flags |= RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED;
+	bool l2tag1_valid = rte_le_to_cpu_16(rxdp->wb.status_error0) &
+			(1 << IAVF_RX_FLEX_DESC_STATUS0_L2TAG1P_S);
+	bool l2tag2_valid = rte_le_to_cpu_16(rxdp->wb.status_error1) &
+			(1 << IAVF_RX_FLEX_DESC_STATUS1_L2TAG2P_S);
+	if (l2tag1_valid && l2tag2_valid) {
+		mb->ol_flags |= RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED |
+				RTE_MBUF_F_RX_QINQ | RTE_MBUF_F_RX_QINQ_STRIPPED;
+		/* with both tags, the rx_flags say which is outer vs inner */
+		if (rx_flags & IAVF_RX_FLAGS_VLAN_TAG_LOC_L2TAG2_2) {
+			mb->vlan_tci_outer = rte_le_to_cpu_16(rxdp->wb.l2tag2_2nd);
+			mb->vlan_tci = rte_le_to_cpu_16(rxdp->wb.l2tag1);
 		} else {
-			/* if two tags, move Tag1 to outer tag field */
-			mb->ol_flags |= RTE_MBUF_F_RX_QINQ_STRIPPED | RTE_MBUF_F_RX_QINQ;
-			mb->vlan_tci_outer = mb->vlan_tci;
+			mb->vlan_tci_outer = rte_le_to_cpu_16(rxdp->wb.l2tag1);
+			mb->vlan_tci = rte_le_to_cpu_16(rxdp->wb.l2tag2_2nd);
 		}
-		mb->vlan_tci = rte_le_to_cpu_16(rxdp->wb.l2tag2_2nd);
-		PMD_RX_LOG(DEBUG, "Descriptor l2tag2_1: %u, l2tag2_2: %u",
-			   rte_le_to_cpu_16(rxdp->wb.l2tag2_1st),
-			   rte_le_to_cpu_16(rxdp->wb.l2tag2_2nd));
+	} else if (l2tag1_valid || l2tag2_valid) {
+		mb->ol_flags |= RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED;
+		mb->vlan_tci_outer = 0;
+		mb->vlan_tci = rte_le_to_cpu_16(
+				l2tag1_valid ? rxdp->wb.l2tag1 : rxdp->wb.l2tag2_2nd);
 	} else {
 		mb->vlan_tci_outer = 0;
+		mb->vlan_tci = 0;
 	}
 }

@@ -1564,7 +1563,7 @@ iavf_recv_pkts_flex_rxd(void *rx_queue,
 		rxm->ol_flags = 0;
 		rxm->packet_type = ptype_tbl[IAVF_RX_FLEX_DESC_PTYPE_M &
 			rte_le_to_cpu_16(rxd.wb.ptype_flex_flags0)];
-		iavf_flex_rxd_to_vlan_tci(rxm, &rxd);
+		iavf_flex_rxd_to_vlan_tci(rxm, &rxd, rxq->rx_flags);
 		iavf_flex_rxd_to_ipsec_crypto_status(rxm, &rxd,
 				&rxq->stats->ipsec_crypto);
 		rxd_to_pkt_fields_ops[rxq->rxdid](rxq, rxm, &rxd);
@@ -1731,7 +1730,7 @@ iavf_recv_scattered_pkts_flex_rxd(void *rx_queue, struct rte_mbuf **rx_pkts,
 		first_seg->ol_flags = 0;
 		first_seg->packet_type = ptype_tbl[IAVF_RX_FLEX_DESC_PTYPE_M &
 			rte_le_to_cpu_16(rxd.wb.ptype_flex_flags0)];
-		iavf_flex_rxd_to_vlan_tci(first_seg, &rxd);
+		iavf_flex_rxd_to_vlan_tci(first_seg, &rxd, rxq->rx_flags);
 		iavf_flex_rxd_to_ipsec_crypto_status(first_seg, &rxd,
 				&rxq->stats->ipsec_crypto);
 		rxd_to_pkt_fields_ops[rxq->rxdid](rxq, first_seg, &rxd);
@@ -2013,7 +2012,7 @@ iavf_rx_scan_hw_ring_flex_rxd(struct ci_rx_queue *rxq,

 			mb->packet_type = ptype_tbl[IAVF_RX_FLEX_DESC_PTYPE_M &
 				rte_le_to_cpu_16(rxdp[j].wb.ptype_flex_flags0)];
-			iavf_flex_rxd_to_vlan_tci(mb, &rxdp[j]);
+			iavf_flex_rxd_to_vlan_tci(mb, &rxdp[j], rxq->rx_flags);
 			iavf_flex_rxd_to_ipsec_crypto_status(mb, &rxdp[j],
 				&rxq->stats->ipsec_crypto);
 			rxd_to_pkt_fields_ops[rxq->rxdid](rxq, mb, &rxdp[j]);
--
2.53.0

