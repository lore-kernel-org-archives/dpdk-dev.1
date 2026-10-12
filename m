Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9F3CA9ED0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 20:38:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4136C402DB;
	Mon, 12 Oct 2026 22:38:40 +0200 (CEST)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id BBE2E40041
 for <dev@dpdk.org>; Mon, 12 Oct 2026 09:36:39 +0200 (CEST)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-15354aa70e8so518978c88.1
 for <dev@dpdk.org>; Mon, 12 Oct 2026 00:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791790599; x=1792395399; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zvOzXRK5jA5WOYpJbRBHxfYa5Ne4EpnrzGSRLUtSv4g=;
 b=RE9IbSzjoToe/0tDwvAaJ92VdiGkziijSNKr/QZmncEhxq4UV9dTswMQK8HzcDu8Gl
 r5GwdXzQMzADI7PPdceIQu6XGWPO60RUOnfKoKEpOMaOmSjzDYOwBr8gS3QF7GQEB/1u
 v85vy1jL9Y65BG9Nm4zIHWhOp90AHbB1r+IlGbV1wYUcZNasCf1K74Py+f63EmfH6Rhz
 12G5L907FFk2Cq8Zh2x86bJgbivz06TT08OERdqRsK0gDkdNdCXZRdBAcnieiZhYKdqH
 g+/NOxVH0K4YJMb8bW0ak3Bpm7Zv2jVP4l2+6yrVd77TEPRW+sU5lAXBymTNCgZZZqmp
 u1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791790599; x=1792395399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zvOzXRK5jA5WOYpJbRBHxfYa5Ne4EpnrzGSRLUtSv4g=;
 b=vFYY1BqEQBXEUyA1GsFt2gRMS4ge8k85ZYC604DPhiV5gZnKwdLseGhBT9fhMPRlRe
 IHHjaE4d/UzMsoIrVdKGDY4x2eyeBGGHwSfCslyo5Vjp2laYEsC9fR2Ym6G4DjVguH1U
 6yj7gRFGbciBxgo6+6VTcteCBvJqqnun6J3gZhPTQU7RpMU+YdRRUNGGz8MlXnCTGiJc
 kHdhbZYsCRxa+w0R3NJW9eHb4DWMpQqdHv0s/h4+foai9Hr+nlWYJrv+1xiVnSXxsXAu
 om4nWjc3vpibc5GNrrQe//lQ8sElncKJM+zjuLmjFaY+xRzFt28tAJBqiKAL7AKTXAR+
 QxYA==
X-Gm-Message-State: AFq9FYK2fBJMPbJIRqyMjrQ0RYsPToAy+iawQV35x5WCrNGvCg0jB0Fv
 jJm1sOAPtVkwqXYeOdZJn2Evqsj7h35WvkUUDlYTeKGQuIAyGxStPNX1jCThYw==
X-Gm-Gg: AYBFou0sKrVC2A6yPpNiGpCBFPViGug+87yJSGt9Sxtoq+OOnjYFhOv8kOTm/Yyu3Cx
 WTqNurny35JXtLQw9JbIA/q6TDxbb/YZaptZEpvs2VAmKHIWqSBRdtQxbz/KTpydgPQifrR96yk
 84Sy2AvrMOYr/Mn2dFY4lGV707L8I2ToHr3GMKuL6b7uiJ8nwVLRyB/pQQTOEkr1FLzCiJ5Yez7
 wJnmB+mmcI/v/HkBMnHtrNpCSGbC3ekSs7TR+1smPWekHnK9jacnhsmZ6KpeG/imKZufs6MZSly
 obge9GMbCGo6WMla4TRIZk3rwPzq9dhlhcWVWfXxfTvYlAyTMn2CuDLf4jj02c3IpZco0aQJbQi
 /lfXtyl8qjFbnt9yEBqr827rKqWXRsZFopvyNwfeaRu/EYUOsnUNWYY38xAZtF4e279xIk2FN9V
 jn2+Cd+krhu8UUpsooRRMRx/gKPTOggb+RTe6sVzX52PozU7zQqvW5jMNA0Yp4F2WFjonQIoO+
X-Received: by 2002:a05:701b:21d3:10b0:143:296a:3ee with SMTP id
 a92af1059eb24-16a5ef28797mr12190168c88.25.1791790598610; 
 Mon, 12 Oct 2026 00:36:38 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1becb11sm25558463c88.4.2026.10.12.00.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 00:36:38 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: Long Li <longli@microsoft.com>,
	Wei Hu <weh@microsoft.com>
Subject: [PATCH 2/2] net/mana: add hardware TSO support
Date: Mon, 12 Oct 2026 07:36:26 +0000
Message-ID: <20261012073626.642397-3-tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012073626.642397-1-tathagat.dpdk@gmail.com>
References: <20261012073626.642397-1-tathagat.dpdk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 22:38:37 +0200
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

Implement hardware TCP Segmentation Offload (TSO) in Microsoft Azure
MANA PMD:
- Define GDMA_WR_OOB_IN_SGL and GDMA_WR_PAD_BY_SGE0 in mana.h.
- Advertise RTE_ETH_TX_OFFLOAD_TCP_TSO in MANA_DEV_TX_OFFLOAD_SUPPORT.
- Handle GDMA_WR_OOB_IN_SGL and GDMA_WR_PAD_BY_SGE0 in
  write_dma_client_oob() in gdma.c to configure client_oob_in_sgl and
  last_v_bytes.
- In mana_tx_burst() in tx.c:
  * Parse RTE_MBUF_F_TX_TCP_SEG and validate total SGEs against
    priv->max_send_sge and MAX_SGL_ENTRIES_FOR_TRANSMIT.
  * Zero out IPv4 total_length and hdr_checksum (or IPv6 payload_len)
    and compute pseudo-header checksum in the TCP header.
  * Enable tx_compute_TCP_checksum and set tx_transport_header_offset.
  * Format SGL so SGE0 contains packet headers (L2 + L3 + L4) and
    subsequent SGEs carry segment payloads, allocating MRs through
    mana_alloc_pmd_mr().
  * Set GDMA_WR_OOB_IN_SGL | GDMA_WR_PAD_BY_SGE0 work request flags and
    assign client_data_unit to m_pkt->tso_segsz.
- Update mana.ini to advertise TSO feature support.

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
---
 doc/guides/nics/features/mana.ini |   1 +
 drivers/net/mana/gdma.c           |   5 +
 drivers/net/mana/mana.h           |   6 +-
 drivers/net/mana/tx.c             | 177 +++++++++++++++++++++++++-----
 4 files changed, 162 insertions(+), 27 deletions(-)

diff --git a/doc/guides/nics/features/mana.ini b/doc/guides/nics/features/mana.ini
index db555ffe27..edf9469486 100644
--- a/doc/guides/nics/features/mana.ini
+++ b/doc/guides/nics/features/mana.ini
@@ -11,6 +11,7 @@ Rx interrupt         = Y
 RSS hash             = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
+TSO                  = Y
 Basic stats          = Y
 MTU update           = Y
 Multiprocess aware   = Y
diff --git a/drivers/net/mana/gdma.c b/drivers/net/mana/gdma.c
index a92aef59d2..65896b6a69 100644
--- a/drivers/net/mana/gdma.c
+++ b/drivers/net/mana/gdma.c
@@ -38,6 +38,11 @@ write_dma_client_oob(uint8_t *work_queue_buffer_pointer,
 	header->inline_client_oob_size_in_dwords =
 		client_oob_size / sizeof(uint32_t);
 	header->client_data_unit = work_request->client_data_unit;
+	if (work_request->flags & GDMA_WR_OOB_IN_SGL) {
+		header->client_oob_in_sgl = 1;
+		if (work_request->flags & GDMA_WR_PAD_BY_SGE0)
+			header->last_v_bytes = work_request->sgl[0].size;
+	}
 
 	DP_LOG(DEBUG, "queue buf %p sgl %u oob_h %u du %u oob_buf %p oob_b %u",
 	       work_queue_buffer_pointer, header->num_sgl_entries,
diff --git a/drivers/net/mana/mana.h b/drivers/net/mana/mana.h
index 79879b7626..17aa4a09ac 100644
--- a/drivers/net/mana/mana.h
+++ b/drivers/net/mana/mana.h
@@ -28,12 +28,16 @@ struct mana_shared_data {
 		RTE_ETH_RX_OFFLOAD_CHECKSUM | \
 		RTE_ETH_RX_OFFLOAD_RSS_HASH)
 
+#define GDMA_WR_OOB_IN_SGL  (1 << 0)
+#define GDMA_WR_PAD_BY_SGE0 (1 << 1)
+
 #define MANA_DEV_TX_OFFLOAD_SUPPORT ( \
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT | \
 		RTE_ETH_TX_OFFLOAD_MULTI_SEGS | \
 		RTE_ETH_TX_OFFLOAD_IPV4_CKSUM | \
 		RTE_ETH_TX_OFFLOAD_TCP_CKSUM | \
-		RTE_ETH_TX_OFFLOAD_UDP_CKSUM)
+		RTE_ETH_TX_OFFLOAD_UDP_CKSUM | \
+		RTE_ETH_TX_OFFLOAD_TCP_TSO)
 
 #define INDIRECTION_TABLE_NUM_ELEMENTS 64
 #define TOEPLITZ_HASH_KEY_SIZE_IN_BYTES 40
diff --git a/drivers/net/mana/tx.c b/drivers/net/mana/tx.c
index d35030cbe5..9401928bad 100644
--- a/drivers/net/mana/tx.c
+++ b/drivers/net/mana/tx.c
@@ -273,14 +273,31 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		struct transmit_oob_v2 tx_oob;
 		struct one_sgl sgl;
 		uint16_t seg_idx;
+		uint16_t num_sge;
+		uint16_t expected_sge;
+		bool is_tso = false;
+		uint32_t gso_hs = 0;
 
 		if (txq->desc_ring_len >= txq->num_desc)
 			break;
 
-		/* Drop the packet if it exceeds max segments */
-		if (m_pkt->nb_segs > priv->max_send_sge) {
+		if (m_pkt->ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
+			gso_hs = m_pkt->l2_len + m_pkt->l3_len + m_pkt->l4_len;
+			if (unlikely(m_pkt->data_len < gso_hs)) {
+				DP_LOG(ERR, "TSO header cannot be fragmented");
+				break;
+			}
+			if (likely(gso_hs != 0 && m_pkt->pkt_len > gso_hs &&
+				   m_pkt->tso_segsz != 0))
+				is_tso = true;
+		}
+
+		expected_sge = m_pkt->nb_segs +
+			(is_tso && m_pkt->data_len > gso_hs ? 1 : 0);
+		if (expected_sge > priv->max_send_sge ||
+		    expected_sge > MAX_SGL_ENTRIES_FOR_TRANSMIT) {
 			DP_LOG(ERR, "send packet segments %d exceeding max",
-			       m_pkt->nb_segs);
+			       expected_sge);
 			break;
 		}
 
@@ -305,7 +322,43 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		tx_oob.short_oob.tx_compute_IP_header_checksum =
 			m_pkt->ol_flags & RTE_MBUF_F_TX_IP_CKSUM ? 1 : 0;
 
-		if ((m_pkt->ol_flags & RTE_MBUF_F_TX_L4_MASK) ==
+		if (is_tso) {
+			struct rte_tcp_hdr *tcp_hdr =
+				rte_pktmbuf_mtod_offset(m_pkt,
+					struct rte_tcp_hdr *,
+					m_pkt->l2_len + m_pkt->l3_len);
+
+			if (m_pkt->ol_flags & RTE_MBUF_F_TX_IPV4) {
+				struct rte_ipv4_hdr *ip_hdr =
+					rte_pktmbuf_mtod_offset(m_pkt,
+						struct rte_ipv4_hdr *,
+						m_pkt->l2_len);
+
+				ip_hdr->total_length = 0;
+				ip_hdr->hdr_checksum = 0;
+				tcp_hdr->cksum = rte_ipv4_phdr_cksum(ip_hdr,
+							m_pkt->ol_flags);
+			} else if (m_pkt->ol_flags & RTE_MBUF_F_TX_IPV6) {
+				struct rte_ipv6_hdr *ip_hdr =
+					rte_pktmbuf_mtod_offset(m_pkt,
+						struct rte_ipv6_hdr *,
+						m_pkt->l2_len);
+
+				ip_hdr->payload_len = 0;
+				tcp_hdr->cksum = rte_ipv6_phdr_cksum(ip_hdr,
+							m_pkt->ol_flags);
+			} else {
+				DP_LOG(ERR, "Invalid IP version for TSO");
+				break;
+			}
+
+			tx_oob.short_oob.tx_compute_IP_header_checksum =
+				(m_pkt->ol_flags & RTE_MBUF_F_TX_IPV4) ? 1 : 0;
+			tx_oob.short_oob.tx_compute_TCP_checksum = 1;
+			tx_oob.short_oob.tx_compute_UDP_checksum = 0;
+			tx_oob.short_oob.tx_transport_header_offset =
+				m_pkt->l2_len + m_pkt->l3_len;
+		} else if ((m_pkt->ol_flags & RTE_MBUF_F_TX_L4_MASK) ==
 				RTE_MBUF_F_TX_TCP_CKSUM) {
 			struct rte_tcp_hdr *tcp_hdr;
 
@@ -405,34 +458,100 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		       m_pkt->pkt_len);
 
 		/* Create SGL for packet data buffers */
-		for (seg_idx = 0; seg_idx < m_pkt->nb_segs; seg_idx++) {
+		if (is_tso) {
 			struct mana_mr_cache *mr =
-				mana_alloc_pmd_mr(&txq->mr_btree, priv, m_seg);
+				mana_alloc_pmd_mr(&txq->mr_btree, priv, m_pkt);
 
-			if (!mr) {
-				DP_LOG(ERR, "failed to get MR, pkt_idx %u",
+			if (unlikely(!mr)) {
+				DP_LOG(ERR, "failed to get MR for TSO hdr, pkt_idx %u",
 				       pkt_idx);
 				break;
 			}
 
-			sgl.gdma_sgl[seg_idx].address =
-				rte_cpu_to_le_64(rte_pktmbuf_mtod(m_seg,
-								  uint64_t));
-			sgl.gdma_sgl[seg_idx].size = m_seg->data_len;
-			sgl.gdma_sgl[seg_idx].memory_key = mr->lkey;
+			/* SGE0: packet header only (L2 + L3 + L4) */
+			sgl.gdma_sgl[0].address =
+				rte_cpu_to_le_64(rte_pktmbuf_mtod(m_pkt, uint64_t));
+			sgl.gdma_sgl[0].size = gso_hs;
+			sgl.gdma_sgl[0].memory_key = mr->lkey;
+			num_sge = 1;
+
+			/* If first mbuf has payload data beyond the header */
+			if (m_pkt->data_len > gso_hs) {
+				sgl.gdma_sgl[1].address =
+					rte_cpu_to_le_64(rte_pktmbuf_mtod(m_pkt,
+									  uint64_t) +
+							 gso_hs);
+				sgl.gdma_sgl[1].size = m_pkt->data_len - gso_hs;
+				sgl.gdma_sgl[1].memory_key = mr->lkey;
+				num_sge = 2;
+			}
 
-			DP_LOG(DEBUG,
-			       "seg idx %u addr 0x%" PRIx64 " size %x key %x",
-			       seg_idx, sgl.gdma_sgl[seg_idx].address,
-			       sgl.gdma_sgl[seg_idx].size,
-			       sgl.gdma_sgl[seg_idx].memory_key);
+			/* Subsequent mbuf segments */
+			m_seg = m_pkt->next;
+			while (m_seg) {
+				if (unlikely(num_sge >=
+					     MAX_SGL_ENTRIES_FOR_TRANSMIT)) {
+					DP_LOG(ERR,
+					       "TSO SGL entries exceed max %d",
+					       MAX_SGL_ENTRIES_FOR_TRANSMIT);
+					break;
+				}
+				mr = mana_alloc_pmd_mr(&txq->mr_btree, priv,
+						       m_seg);
+				if (unlikely(!mr)) {
+					DP_LOG(ERR,
+					       "failed to get MR for TSO seg, pkt_idx %u",
+					       pkt_idx);
+					break;
+				}
+				sgl.gdma_sgl[num_sge].address =
+					rte_cpu_to_le_64(rte_pktmbuf_mtod(m_seg,
+									  uint64_t));
+				sgl.gdma_sgl[num_sge].size = m_seg->data_len;
+				sgl.gdma_sgl[num_sge].memory_key = mr->lkey;
+				num_sge++;
+				m_seg = m_seg->next;
+			}
 
-			m_seg = m_seg->next;
-		}
+			if (unlikely(m_seg != NULL || num_sge < 2)) {
+				DP_LOG(ERR, "failed to build TSO SGL, num_sge %u",
+				       num_sge);
+				break;
+			}
+		} else {
+			for (seg_idx = 0; seg_idx < m_pkt->nb_segs; seg_idx++) {
+				struct mana_mr_cache *mr =
+					mana_alloc_pmd_mr(&txq->mr_btree, priv,
+							  m_seg);
+
+				if (!mr) {
+					DP_LOG(ERR,
+					       "failed to get MR, pkt_idx %u",
+					       pkt_idx);
+					break;
+				}
+
+				sgl.gdma_sgl[seg_idx].address =
+					rte_cpu_to_le_64(rte_pktmbuf_mtod(m_seg,
+									  uint64_t));
+				sgl.gdma_sgl[seg_idx].size = m_seg->data_len;
+				sgl.gdma_sgl[seg_idx].memory_key = mr->lkey;
+
+				DP_LOG(DEBUG,
+				       "seg idx %u addr 0x%" PRIx64 " size %x key %x",
+				       seg_idx, sgl.gdma_sgl[seg_idx].address,
+				       sgl.gdma_sgl[seg_idx].size,
+				       sgl.gdma_sgl[seg_idx].memory_key);
+
+				m_seg = m_seg->next;
+			}
 
-		/* Skip this packet if we can't populate all segments */
-		if (seg_idx != m_pkt->nb_segs)
-			break;
+			/* Skip this packet if we can't populate all segments */
+			if (seg_idx != m_pkt->nb_segs)
+				break;
+
+			num_sge = m_pkt->nb_segs;
+		}
 
 		/* If we can at least queue post two WQEs and there are at
 		 * least two packets to send, use TX CQE suppression for the
@@ -450,7 +569,7 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		work_req.gdma_header.struct_size = sizeof(work_req);
 
 		work_req.sgl = sgl.gdma_sgl;
-		work_req.num_sgl_elements = m_pkt->nb_segs;
+		work_req.num_sgl_elements = num_sge;
 		if (tx_oob.short_oob.packet_format == SHORT_PACKET_FORMAT)
 			work_req.inline_oob_size_in_bytes =
 				sizeof(struct transmit_short_oob_v2);
@@ -458,8 +577,14 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			work_req.inline_oob_size_in_bytes =
 				sizeof(struct transmit_oob_v2);
 		work_req.inline_oob_data = &tx_oob;
-		work_req.flags = 0;
-		work_req.client_data_unit = NOT_USING_CLIENT_DATA_UNIT;
+		if (is_tso) {
+			work_req.flags = GDMA_WR_OOB_IN_SGL |
+					 GDMA_WR_PAD_BY_SGE0;
+			work_req.client_data_unit = m_pkt->tso_segsz;
+		} else {
+			work_req.flags = 0;
+			work_req.client_data_unit = NOT_USING_CLIENT_DATA_UNIT;
+		}
 
 		ret = gdma_post_work_request(&txq->gdma_sq, &work_req,
 					     &wqe_size_in_bu);
-- 
2.43.0

