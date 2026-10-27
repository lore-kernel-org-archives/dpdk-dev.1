Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDAE606A322
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uWybwWk6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E21C140647;
	Wed, 28 Oct 2026 10:01:02 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTPS id 7D1B9400D7
 for <dev@dpdk.org>; Tue, 27 Oct 2026 19:21:28 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2e940d5d2beso357735ad.0
 for <dev@dpdk.org>; Tue, 27 Oct 2026 11:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793125287; x=1793730087; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JVXx07g0lNymqZBxwJC/bZHxAbsQ5kF9opR5GmhvPIE=;
 b=uWybwWk6OKhQ2gyLvdwEyEeBiq+42WnmLgx2gmWNgNFGxXZiMmwxA5Sb5tv4RDcSfT
 kcKT5nQ8torU1lriI5joVSZYlRIqh3vDArfvQUg/KpsX9zSNRdslxJ8E5WOisMTeykxK
 PRFjQflzV/d9sAffKtT8u8RGyRQxs/i0JsF1WM/jcFolUiPn6rq6D3+9riIwPqt3GtYx
 tCyyl8nwDsFYoW/qmhsm6rYTw6+MiD3NurRLVgu2R1o95O+TjuQmC2sU6b7d0rcpV2Ps
 U0b2WeGVuVzrLRFS49e5JGVyCXp7bEzVAlxWQWYRmLT9AvS7MntL7c43dHFg3wHUJOVp
 YicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793125287; x=1793730087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JVXx07g0lNymqZBxwJC/bZHxAbsQ5kF9opR5GmhvPIE=;
 b=pxlJZyy6S8SfuRKjjbBNdje3ElHAf/6tRBiut9qy2+HD+b8uojD/kzAgVacVUWWhHW
 +LmzaotZPkY1VbEwNPHa1zNeh46ULRYwpLxrU2q6YmuH3DwiZLVoiSV4J5rrnDR2UQgp
 gXW4dzP2Pd8272bkRxJAdMkK0TBCiekWAm1n7iMOFyjfvAOfklXW49dVaiNhmN69hMF5
 dvYj97/ujxMz7cl+Of2OZtZ41VORbK3JFydNXKeH5eRFMWRznFWGz0/ESiXGlm95tu6Z
 uoyemNSfzTbHm5Z5Ml4GQTfXV0876XhalXSlnagJcldIv3bIPW1DsyHMAkC8PGa6bHA8
 ZZQQ==
X-Gm-Message-State: AFq9FYJqSrPrNEvjm8zfFOZHfEA4B1uAh78mwr4sHlRL9U/qy5lUvlkd
 lk0O9SpHBk+1sJqIfxmB8/+zigBkkWmbi3aG8bnrOzyi/kTBNpe72JiSttaRbxoO
X-Gm-Gg: AYBFou1lIwDPprQ20ZXXi7BMQ7n1DKrBYoqmUnCEgAdMscqbIoXrupC+bPHS/0wFrAR
 pIvBqLpFrxLl2lNwmLfmphRDp1qGdNvofxwYvnJufkuonPavMPd7KlsXdMV8k5XzilB5Four+BA
 lGhsrZMvuL4pi23yrRDkZ6617/B3hx0HSXlpsK82o71eAIEzNmuo1yDet3ua0F2EYkhl4Drmzyu
 1fnKUXbXjzkJSkRtDDjCWvjZHpNbjXggUx3H8oBcxUpjkHZ66Nt5K7a+huVW2KE7kvtKCLouq4l
 GSKWBUiOi5QU+5qx6g5c0+wWo7lVIpXr9t/UhSeKnnD6y7mNHjMSNZpyXWlJXBqRuN4ErCMdrAi
 HFbs128DBiTlfSemeymAgVL1UgL3OrwlSsqBlFeKSAOiS/pLnblNcWeKI69LyiiUDAFatDgLiLa
 NcZXOf7dPRg6IM6TJkM7PPMlU5TSthkgAxAuk6UjeF7pxDeeLOeq0PUvJe0A774L3BzSlviQ0bP
 RXMnIA7MnHi+UcXby5OdPbSwTgojY5oUET7mJOl+/snoY16mowToAgB/Q==
X-Received: by 2002:a17:903:124d:b0:2dd:ad73:c987 with SMTP id
 d9443c01a7336-2eb004b1df2mr1416015ad.31.1793125286874; 
 Tue, 27 Oct 2026 11:21:26 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6c84d6csm13054585ad.55.2026.10.27.11.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 11:21:26 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: weh@microsoft.com,
	longli@microsoft.com,
	stephen@networkplumber.org
Subject: [PATCH v3 2/2] net/mana: add hardware TSO support
Date: Tue, 27 Oct 2026 18:21:15 +0000
Message-ID: <20261027182115.3666158-3-tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027182115.3666158-1-tathagat.dpdk@gmail.com>
References: <20261012073626.642397-1-tathagat.dpdk@gmail.com>
 <20261027182115.3666158-1-tathagat.dpdk@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 10:01:00 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Advertise RTE_ETH_TX_OFFLOAD_TCP_TSO for IPv4 and IPv6 TCP packets.

For a packet with RTE_MBUF_F_TX_TCP_SEG and a non-zero tso_segsz, put
the L2/L3/L4 headers alone in the first SGE and the payload in the
following ones, pass tso_segsz as the client data unit, and request IP
and TCP checksum offload with the pseudo-header checksum seeded. A first
segment that also carries payload needs one extra SGE, so advertise
nb_seg_max as one less than the maximum supported SGE count.

A packet that cannot be sent as TSO (invalid segment size, header size
overflow, fragmented headers, or SGL build failure) is dropped. A packet
with TCP_SEG but no payload or zero tso_segsz is sent unsegmented, with
the TCP checksum offloaded as TCP_SEG implies.

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
---
v3:
- Mask RTE_MBUF_F_TX_TCP_SEG in the non-TSO fallback branch so
  rte_ipv4_phdr_cksum / rte_ipv6_phdr_cksum calculate the full L4 length.
- Reject invalid TSO packets (tso_segsz > MANA_TSO_MAX_SEGSZ or
  gso_hs > UINT8_MAX) to prevent hardware bitfield truncations.
- Set dev_info nb_seg_max to max_sge - 1 to reflect the extra SGE for TSO.
- Bound TSO SGL construction loop by expected_sge and verify SGE count.
- Streamline commit log.

v2:
- Drop unsendable packets instead of break.
- Honour TCP checksum offload when TCP_SEG packet is unsegmented.
- Move GDMA_WR_OOB_IN_SGL and GDMA_WR_PAD_BY_SGE0 adjacent to
  struct gdma_work_request.
- Add release notes entry and update mana.ini feature matrix.

 doc/guides/nics/features/mana.ini      |   1 +
 doc/guides/rel_notes/release_26_11.rst |   4 +
 drivers/net/mana/gdma.c                |   5 +
 drivers/net/mana/mana.c                |   9 +-
 drivers/net/mana/mana.h                |   9 +-
 drivers/net/mana/tx.c                  | 194 ++++++++++++++++++++-----
 6 files changed, 184 insertions(+), 38 deletions(-)

diff --git a/doc/guides/nics/features/mana.ini b/doc/guides/nics/features/mana.ini
index c7c8215aab..6a4fb0a89e 100644
--- a/doc/guides/nics/features/mana.ini
+++ b/doc/guides/nics/features/mana.ini
@@ -10,6 +10,7 @@ Rx interrupt         = Y
 RSS hash             = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
+TSO                  = Y
 MTU update           = Y
 Multiprocess aware   = Y
 Linux                = Y
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index be758a0c02..7e5f463f88 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -164,6 +164,10 @@ New Features
   Added ``fdir_buffer_size`` devarg to select the Flow Director table size
   (``64k``, ``128k`` or ``256k``) at probe time. The default remains ``64k``.
 
+* **Updated Microsoft MANA PMD.**
+
+  * Added hardware TCP Segmentation Offload (TSO) support for IPv4 and IPv6.
+
 * **Updated NVIDIA mlx5 ethernet driver.**
 
   * Increased the maximum number of secondary unicast MAC addresses from 128 to up to 4096
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
diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
index 5ddbbdc3d0..d6a8b2dd04 100644
--- a/drivers/net/mana/mana.c
+++ b/drivers/net/mana/mana.c
@@ -349,6 +349,7 @@ mana_dev_info_get(struct rte_eth_dev *dev,
 		  struct rte_eth_dev_info *dev_info)
 {
 	struct mana_priv *priv = dev->data->dev_private;
+	uint16_t max_sge;
 
 	dev_info->min_mtu = RTE_ETHER_MIN_MTU;
 	dev_info->max_mtu = MANA_MAX_MTU;
@@ -406,13 +407,13 @@ mana_dev_info_get(struct rte_eth_dev *dev,
 	dev_info->rx_desc_lim.nb_mtu_seg_max =
 		RTE_MIN(priv->max_recv_sge, UINT16_MAX);
 
+	max_sge = RTE_MIN(priv->max_send_sge, MAX_SGL_ENTRIES_FOR_TRANSMIT);
+
 	dev_info->tx_desc_lim.nb_min = MIN_BUFFERS_PER_QUEUE;
 	dev_info->tx_desc_lim.nb_max = RTE_MIN(priv->max_tx_desc, UINT16_MAX);
 	dev_info->tx_desc_lim.nb_align = MIN_BUFFERS_PER_QUEUE;
-	dev_info->tx_desc_lim.nb_seg_max =
-		RTE_MIN(priv->max_send_sge, MAX_SGL_ENTRIES_FOR_TRANSMIT);
-	dev_info->tx_desc_lim.nb_mtu_seg_max =
-		RTE_MIN(priv->max_send_sge, MAX_SGL_ENTRIES_FOR_TRANSMIT);
+	dev_info->tx_desc_lim.nb_seg_max = max_sge > 1 ? max_sge - 1 : 1;
+	dev_info->tx_desc_lim.nb_mtu_seg_max = max_sge;
 
 	/* Speed */
 	dev_info->speed_capa = RTE_ETH_LINK_SPEED_100G;
diff --git a/drivers/net/mana/mana.h b/drivers/net/mana/mana.h
index 79879b7626..a259a12f66 100644
--- a/drivers/net/mana/mana.h
+++ b/drivers/net/mana/mana.h
@@ -33,7 +33,8 @@ struct mana_shared_data {
 		RTE_ETH_TX_OFFLOAD_MULTI_SEGS | \
 		RTE_ETH_TX_OFFLOAD_IPV4_CKSUM | \
 		RTE_ETH_TX_OFFLOAD_TCP_CKSUM | \
-		RTE_ETH_TX_OFFLOAD_UDP_CKSUM)
+		RTE_ETH_TX_OFFLOAD_UDP_CKSUM | \
+		RTE_ETH_TX_OFFLOAD_TCP_TSO)
 
 #define INDIRECTION_TABLE_NUM_ELEMENTS 64
 #define TOEPLITZ_HASH_KEY_SIZE_IN_BYTES 40
@@ -208,6 +209,12 @@ struct one_sgl {
 	struct gdma_sgl_element gdma_sgl[MAX_SGL_ENTRIES_FOR_TRANSMIT];
 };
 
+#define GDMA_WR_OOB_IN_SGL  (1 << 0)
+#define GDMA_WR_PAD_BY_SGE0 (1 << 1)
+
+/* client_data_unit is 14 bits in gdma_wqe_dma_oob */
+#define MANA_TSO_MAX_SEGSZ  ((1u << 14) - 1)
+
 struct gdma_work_request {
 	struct gdma_header gdma_header;
 	struct gdma_sgl_element *sgl;
diff --git a/drivers/net/mana/tx.c b/drivers/net/mana/tx.c
index 16e63e89c9..19a3aaec59 100644
--- a/drivers/net/mana/tx.c
+++ b/drivers/net/mana/tx.c
@@ -274,15 +274,43 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
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
-		if (unlikely(m_pkt->nb_segs > priv->max_send_sge ||
-			     m_pkt->nb_segs > MAX_SGL_ENTRIES_FOR_TRANSMIT)) {
+		if (m_pkt->ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
+			gso_hs = m_pkt->l2_len + m_pkt->l3_len + m_pkt->l4_len;
+			/* Header must be in first segment; last_v_bytes is 8 bits */
+			if (unlikely(m_pkt->data_len < gso_hs ||
+				     gso_hs > UINT8_MAX)) {
+				DP_LOG(ERR, "invalid TSO packet header length %u",
+				       gso_hs);
+				goto drop;
+			}
+			if (unlikely(m_pkt->tso_segsz > MANA_TSO_MAX_SEGSZ)) {
+				DP_LOG(ERR, "TSO segment size %u exceeds max %u",
+				       m_pkt->tso_segsz, MANA_TSO_MAX_SEGSZ);
+				goto drop;
+			}
+			if (likely(gso_hs != 0 && m_pkt->pkt_len > gso_hs &&
+				   m_pkt->tso_segsz != 0))
+				is_tso = true;
+		}
+
+		/* Drop the packet if it exceeds max segments. A TSO packet
+		 * with payload in the first segment needs an extra SGE for
+		 * the header.
+		 */
+		expected_sge = m_pkt->nb_segs +
+			(is_tso && m_pkt->data_len > gso_hs ? 1 : 0);
+		if (unlikely(expected_sge > priv->max_send_sge ||
+			     expected_sge > MAX_SGL_ENTRIES_FOR_TRANSMIT)) {
 			DP_LOG(ERR, "send packet segments %d exceeding max",
-			       m_pkt->nb_segs);
+			       expected_sge);
 			goto drop;
 		}
 
@@ -307,9 +335,47 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		tx_oob.short_oob.tx_compute_IP_header_checksum =
 			m_pkt->ol_flags & RTE_MBUF_F_TX_IP_CKSUM ? 1 : 0;
 
-		if ((m_pkt->ol_flags & RTE_MBUF_F_TX_L4_MASK) ==
-				RTE_MBUF_F_TX_TCP_CKSUM) {
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
+				goto drop;
+			}
+
+			tx_oob.short_oob.tx_compute_IP_header_checksum =
+				(m_pkt->ol_flags & RTE_MBUF_F_TX_IPV4) ? 1 : 0;
+			tx_oob.short_oob.tx_compute_TCP_checksum = 1;
+			tx_oob.short_oob.tx_compute_UDP_checksum = 0;
+			tx_oob.short_oob.tx_transport_header_offset =
+				m_pkt->l2_len + m_pkt->l3_len;
+		} else if ((m_pkt->ol_flags & RTE_MBUF_F_TX_L4_MASK) ==
+				RTE_MBUF_F_TX_TCP_CKSUM ||
+			   (m_pkt->ol_flags & RTE_MBUF_F_TX_TCP_SEG)) {
 			struct rte_tcp_hdr *tcp_hdr;
+			uint64_t ol = m_pkt->ol_flags & ~RTE_MBUF_F_TX_TCP_SEG;
 
 			/* HW needs partial TCP checksum */
 
@@ -323,8 +389,7 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 				ip_hdr = rte_pktmbuf_mtod_offset(m_pkt,
 						struct rte_ipv4_hdr *,
 						m_pkt->l2_len);
-				tcp_hdr->cksum = rte_ipv4_phdr_cksum(ip_hdr,
-							m_pkt->ol_flags);
+				tcp_hdr->cksum = rte_ipv4_phdr_cksum(ip_hdr, ol);
 
 			} else if (m_pkt->ol_flags & RTE_MBUF_F_TX_IPV6) {
 				struct rte_ipv6_hdr *ip_hdr;
@@ -332,8 +397,7 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 				ip_hdr = rte_pktmbuf_mtod_offset(m_pkt,
 						struct rte_ipv6_hdr *,
 						m_pkt->l2_len);
-				tcp_hdr->cksum = rte_ipv6_phdr_cksum(ip_hdr,
-							m_pkt->ol_flags);
+				tcp_hdr->cksum = rte_ipv6_phdr_cksum(ip_hdr, ol);
 			} else {
 				DP_LOG(ERR, "Invalid input for TCP CKSUM");
 			}
@@ -407,34 +471,92 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
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
-				break;
+				goto drop;
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
+			while (m_seg && num_sge < expected_sge) {
+				mr = mana_alloc_pmd_mr(&txq->mr_btree, priv,
+						       m_seg);
+				if (unlikely(!mr)) {
+					DP_LOG(ERR,
+					       "failed to get MR for TSO seg, pkt_idx %u",
+					       pkt_idx);
+					goto drop;
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
+			if (unlikely(m_seg != NULL || num_sge != expected_sge)) {
+				DP_LOG(ERR, "failed to build TSO SGL, num_sge %u",
+				       num_sge);
+				goto drop;
+			}
+		} else {
+			for (seg_idx = 0; seg_idx < m_pkt->nb_segs; seg_idx++) {
+				struct mana_mr_cache *mr =
+					mana_alloc_pmd_mr(&txq->mr_btree, priv,
+							  m_seg);
+
+				if (!mr) {
+					DP_LOG(ERR, "failed to get MR, pkt_idx %u",
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
-			goto drop;
+			/* Skip this packet if we can't populate all segments */
+			if (seg_idx != m_pkt->nb_segs)
+				goto drop;
+
+			num_sge = m_pkt->nb_segs;
+		}
 
 		/* If we can at least queue post two WQEs and there are at
 		 * least two packets to send, use TX CQE suppression for the
@@ -452,7 +574,7 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		work_req.gdma_header.struct_size = sizeof(work_req);
 
 		work_req.sgl = sgl.gdma_sgl;
-		work_req.num_sgl_elements = m_pkt->nb_segs;
+		work_req.num_sgl_elements = num_sge;
 		if (tx_oob.short_oob.packet_format == SHORT_PACKET_FORMAT)
 			work_req.inline_oob_size_in_bytes =
 				sizeof(struct transmit_short_oob_v2);
@@ -460,8 +582,14 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
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

