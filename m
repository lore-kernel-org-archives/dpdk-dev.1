Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1240CAC5A8
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 14:11:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86D0640677;
	Mon, 22 Sep 2025 16:11:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 46A2F40677
 for <dev@dpdk.org>; Mon, 22 Sep 2025 16:11:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758550267; x=1790086267;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EsfHquTopJVSpcpvCnDdnrYUUZzEiRLz9JF7eX2zdL0=;
 b=JCsWhVcNKZ33wmCzfeYN5GKoDatxDOHwTROu8NjJ+zCwBC+hpW9IVjqU
 YSY6u31EWBH35L0gfZSIMdiPtYh7aL9kVlb1R1JVgfIaYdva7z5Pu8AMG
 JaZ0XBZUZBnVaQeq9LE+0a86noFuwzqC6NOzJey2wrRt9Xz9cXgZWyFrX
 vSSDL6e/SfrQDam5kVKLAMRvMAqpl9EZMoy9fQ7eIzAogagfLVDkCgmWi
 /XR44fvEtBic3+o5Fc0CH5gp07/YX8tLTiV5kQyUl1GvrUURFFy3oDwTG
 JsDKbhpLwrgknk+cUMkentaHjRKyOlunEvwDmMa69ajQQZU5rgrkboknP Q==;
X-CSE-ConnectionGUID: vWQuqrSSQ5WzAePn6RdmDQ==
X-CSE-MsgGUID: TGJ/EA8/RQ6cbgAWlnmOMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="60869745"
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; d="scan'208";a="60869745"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2025 07:11:07 -0700
X-CSE-ConnectionGUID: +Ibp3NRPTCq0eBcuHqqkYg==
X-CSE-MsgGUID: knFMyYxuS8Cm8uPsm3PgLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; d="scan'208";a="176560278"
Received: from gk6031-gr4-41638.igk.intel.com (HELO
 GK6031-GR4-41638-c04.igk.intel.com) ([10.91.173.62])
 by orviesa008.jf.intel.com with ESMTP; 22 Sep 2025 07:11:05 -0700
From: "Shetty, Praveen" <praveen.shetty@intel.com>
To: bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: dev@dpdk.org, Praveen Shetty <praveen.shetty@intel.com>,
 Dhananjay Shukla <dhananjay.shukla@intel.com>,
 atulpatel261194 <Atul.Patel@intel.com>
Subject: [PATCH v2 2/4] net/idpf: add splitq jumbo packet handling
Date: Mon, 22 Sep 2025 16:10:56 +0200
Message-Id: <20250922141058.1390212-3-praveen.shetty@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250922141058.1390212-1-praveen.shetty@intel.com>
References: <20250922094819.1350709-2-praveen.shetty@intel.com>
 <20250922141058.1390212-1-praveen.shetty@intel.com>
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
Signed-off-by: Dhananjay Shukla <dhananjay.shukla@intel.com>
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

