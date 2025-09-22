Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49476CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 06:19:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A2B140657;
	Mon, 22 Sep 2025 08:19:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 9960D40653
 for <dev@dpdk.org>; Mon, 22 Sep 2025 08:19:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758521958; x=1790057958;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=u1P7d/swk3nSUxhi96u+5AKXdIlzn1agv15E1E5ijMg=;
 b=Fpt54/CI6gw52g2/8sass7dcA7cpLdyW3ZAQTI+Q3CDiDsIs/UHXAGhf
 VOJb2Qk0s5Gyz/wdzKB9G4t7YtbfJ92y7BxkUUdYcO++7dlfbLpzd4eOV
 HR4+YDTODGPNQ50H/DcB6ml2fhglKDTutI0sWMM6rFRJoJRR1FJjf/Zjd
 066fxpegkKPr0jo4dXolEmF4t7eUyobF5e1C5iJK3mXUh0Ee2HeNcG48T
 e/fR+eOn4h4N0nXEpnEEz1soI38Z5CsNG6NBGKLCYL+/U6uRmJOnc9PIZ
 GElcxjsE/SrV64kQRxfmMbBt8F9tAWdgriHaDmA2dCFZQ+Gls+igjehWQ Q==;
X-CSE-ConnectionGUID: 8rC4pIpYRNSLxQX94mCVuA==
X-CSE-MsgGUID: /Jw3DoOmT9izoiIkKD6zTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11560"; a="60939095"
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; d="scan'208";a="60939095"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2025 23:19:17 -0700
X-CSE-ConnectionGUID: N90PMf+vQ5KS+VeKdjc2oQ==
X-CSE-MsgGUID: oKdO3d3NQE2agDIFaMcfJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; d="scan'208";a="207136434"
Received: from gk6031-gr4-41638.igk.intel.com (HELO
 GK6031-GR4-41638-c04.igk.intel.com) ([10.91.173.62])
 by orviesa002.jf.intel.com with ESMTP; 21 Sep 2025 23:19:15 -0700
From: "Shetty, Praveen" <praveen.shetty@intel.com>
To: bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: dev@dpdk.org, Praveen Shetty <praveen.shetty@intel.com>,
	Shukla@dpdk.org, Dhananjay <dhananjay.shukla@intel.com>,
	atulpatel261194 <Atul.Patel@intel.com>
Subject: [PATCH 2/4] net/idpf: add splitq jumbo packet handling
Date: Mon, 22 Sep 2025 11:48:17 +0200
Message-Id: <20250922094819.1350709-3-praveen.shetty@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250922094819.1350709-1-praveen.shetty@intel.com>
References: <20250922094819.1350709-1-praveen.shetty@intel.com>
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

From: Praveen Shetty <praveen.shetty@intel.com>

This patch will add the jumbo packets handling in the
idpf_dp_splitq_recv_pkts function.

Signed-off-by: Praveen Shetty <praveen.shetty@intel.com>
Signed-off-by: Shukla, Dhananjay <dhananjay.shukla@intel.com>
Signed-off-by: atulpatel261194 <Atul.Patel@intel.com>
---
 drivers/net/intel/idpf/idpf_common_rxtx.c | 50 ++++++++++++++++++-----
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index eb25b091d8..412aff8f5f 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -623,10 +623,12 @@ idpf_dp_splitq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 	volatile struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc_ring;
 	volatile struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc;
 	uint16_t pktlen_gen_bufq_id;
-	struct idpf_rx_queue *rxq;
+	struct idpf_rx_queue *rxq = rx_queue;
 	const uint32_t *ptype_tbl;
 	uint8_t status_err0_qw1;
 	struct idpf_adapter *ad;
+	struct rte_mbuf *first_seg = rxq->pkt_first_seg;
+	struct rte_mbuf *last_seg = rxq->pkt_last_seg;
 	struct rte_mbuf *rxm;
 	uint16_t rx_id_bufq1;
 	uint16_t rx_id_bufq2;
@@ -659,6 +661,7 @@ idpf_dp_splitq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 
 		pktlen_gen_bufq_id =
 			rte_le_to_cpu_16(rx_desc->pktlen_gen_bufq_id);
+		status_err0_qw1 = rte_le_to_cpu_16(rx_desc->status_err0_qw1);
 		gen_id = (pktlen_gen_bufq_id &
 			  VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) >>
 			VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S;
@@ -697,16 +700,39 @@ idpf_dp_splitq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 		rxm->pkt_len = pkt_len;
 		rxm->data_len = pkt_len;
 		rxm->data_off = RTE_PKTMBUF_HEADROOM;
+
+		/*
+		 * If this is the first buffer of the received packet, set the
+		 * pointer to the first mbuf of the packet and initialize its
+		 * context. Otherwise, update the total length and the number
+		 * of segments of the current scattered packet, and update the
+		 * pointer to the last mbuf of the current packet.
+		 */
+		if (!first_seg) {
+			first_seg = rxm;
+			first_seg->nb_segs = 1;
+			first_seg->pkt_len = pkt_len;
+		} else {
+			first_seg->pkt_len =
+					(uint16_t)(first_seg->pkt_len +
+							pkt_len);
+			first_seg->nb_segs++;
+			last_seg->next = rxm;
+		}
+
+		if (!(status_err0_qw1 & (1 << VIRTCHNL2_RX_FLEX_DESC_ADV_STATUS0_EOF_S))) {
+			last_seg = rxm;
+			continue;
+		}
+
 		rxm->next = NULL;
-		rxm->nb_segs = 1;
-		rxm->port = rxq->port_id;
-		rxm->ol_flags = 0;
-		rxm->packet_type =
+		first_seg->port = rxq->port_id;
+		first_seg->ol_flags = 0;
+		first_seg->packet_type =
 			ptype_tbl[(rte_le_to_cpu_16(rx_desc->ptype_err_fflags0) &
 				   VIRTCHNL2_RX_FLEX_DESC_ADV_PTYPE_M) >>
 				  VIRTCHNL2_RX_FLEX_DESC_ADV_PTYPE_S];
-
-		status_err0_qw1 = rx_desc->status_err0_qw1;
+		status_err0_qw1 = rte_le_to_cpu_16(rx_desc->status_err0_qw1);
 		pkt_flags = idpf_splitq_rx_csum_offload(status_err0_qw1);
 		pkt_flags |= idpf_splitq_rx_rss_offload(rxm, rx_desc);
 		if (idpf_timestamp_dynflag > 0 &&
@@ -719,16 +745,20 @@ idpf_dp_splitq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			*RTE_MBUF_DYNFIELD(rxm,
 					   idpf_timestamp_dynfield_offset,
 					   rte_mbuf_timestamp_t *) = ts_ns;
-			rxm->ol_flags |= idpf_timestamp_dynflag;
+			first_seg->ol_flags |= idpf_timestamp_dynflag;
 		}
 
-		rxm->ol_flags |= pkt_flags;
+		first_seg->ol_flags |= pkt_flags;
 
-		rx_pkts[nb_rx++] = rxm;
+		rx_pkts[nb_rx++] = first_seg;
+
+		first_seg = NULL;
 	}
 
 	if (nb_rx > 0) {
 		rxq->rx_tail = rx_id;
+		rxq->pkt_first_seg = first_seg;
+		rxq->pkt_last_seg = last_seg;
 		if (rx_id_bufq1 != rxq->bufq1->rx_next_avail)
 			rxq->bufq1->rx_next_avail = rx_id_bufq1;
 		if (rx_id_bufq2 != rxq->bufq2->rx_next_avail)
-- 
2.37.3

