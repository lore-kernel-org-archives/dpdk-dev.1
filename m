Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2341606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zf1XK13S
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7ED340678;
	Tue, 27 Oct 2026 10:34:39 +0100 (CET)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by mails.dpdk.org (Postfix) with ESMTPS id A31BF4025A
 for <dev@dpdk.org>; Mon, 26 Oct 2026 22:21:37 +0100 (CET)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-3645f0f3fcdso6460220eec.0
 for <dev@dpdk.org>; Mon, 26 Oct 2026 14:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793049696; x=1793654496; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SSgvz9inm00pi5RjTCWPq+WjAJ8ObaCVd8tuRsNQXtE=;
 b=Zf1XK13SmLo//ZGAD9b+jqmjhaPAba2XOhh/3X6vKXT5cd15gad0Irwi8mqpGdeyid
 mNTIYvyx0BpNBUH7NX1cnG/jZzzr+GC/McBT3OaJhgLSVHQUWf0o1YBFcPlIkyekuZDb
 TvnhH0yzHi2s5ywhLyMH4sJKA5pL7AiULZEhViEz1PEBK0dPi9pBk3dnduK69At9pDAx
 rd2k6M50tfSJCK06+LUSmx7AhUVhGJuLwYGvDh5XleTwNxvNpUn59jOw91u8sJT+tH2M
 b1V3QfnRfG3Vrgfnein0rBw1DVNS9vuffhOZNebXeQzUGy2xm2SbNXepa7e83WJc+m2S
 /zNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793049696; x=1793654496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SSgvz9inm00pi5RjTCWPq+WjAJ8ObaCVd8tuRsNQXtE=;
 b=KuB6/tb8S7/cdMW1L3XCRRQFUP9Msrj1/pmCybEWekUiWJSEMz3CmryD+UAuPIEJ7N
 U0/cVW5AuCRMiPi4iLBhaCHQY8/4KvjepzYyVf6lxfCYwW4ifuIVBatNKCmhELpFt7iv
 pmXus+nk1huOD8bn0e71zeEKyLZGHiXbowkF3XRL6lLfamPvUChKEiwMcL/DUss0dmMz
 +MQSoTTNsEwcRa3uw807UtUecFNGKJ10YnydAYuu0QfcZjbqKIFKAXkH2/wVHJuJdVnr
 wj+teqj4500HlN5fcDhcZeAP3kwQNFT8FYT3iEzOANM/e6uussbfvwrjHdJI7ckbZ0xt
 u22A==
X-Gm-Message-State: AFq9FYL/IyFrRKCUxB0AOIXppOOflbzECFv96I4dPGVvPd0ncEhGleRI
 3VcAiUx6yIyo17IFzONH9hw78bXmoZYpoRelKaRDJtVUZ3o0HWIef87UWGT+w1zm
X-Gm-Gg: AYBFou0SwK3+YdD68c9Ak0acfRXJJTFQ/0ct5pnGmDd7V5HS1cZ8q6zfkavlN/m2oUy
 O4Rp+M+6+A2S6kiYrZU5FbgoZpCDn9NSVt/f9imZamWisYngp2M4xpWwiyMTH1S99yqNraqP6Xa
 uB4ThWCINrN5O9ZXk/tmjBQUGvnchUpTbI0S0j7C1u972VzM+y1ssr/2fpnrnAQrL4vBirYIawP
 6ldrLAqu07ZxCu3rW4nvm96XJrwQwV0ieB3YQwpkEsCd+6lzm/pMEznudP3ImjDwrDv0flRmuEb
 lh40L3TltMTPqrkCSNmjF4AgW9xO5ff6cKNz3I2bLmM6w3HEPIRWyjiN8WfA445j1XMagToVtFs
 QZY36zy5KbES/UMwAxjtt2q/Ie5+vJIUffN74SKsurM7hPBRR58Q5UtPfWAobQ0z0IH12d+kdiL
 ygeBm+LTjHPniWfuUGGJqSLrpekweB+oRDVrHoandtHh+tysrXnWYQPJg6Tlg9YeJNA8MzMMnb4
 6NhPt3znHHbmzXJ8bbGjMQszlgPGKlaOaUDxy10UuRD2mErKSrepJB3ACbchb4TCwREq0ZHVpOD
 osVOrk0fz36aD8rgAm3YunRnGn2/giQ=
X-Received: by 2002:a05:7301:e0c9:b0:353:5d0a:dba4 with SMTP id
 5a478bee46e88-369e86462afmr12137698eec.36.1793049695688; 
 Mon, 26 Oct 2026 14:21:35 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a11b45b8csm617393eec.17.2026.10.26.14.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 14:21:35 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: weh@microsoft.com,
	longli@microsoft.com,
	stephen@networkplumber.org
Subject: [PATCH v2 2/2] net/mana: add hardware TSO support
Date: Mon, 26 Oct 2026 21:21:25 +0000
Message-ID: <20261026212125.3193356-3-tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026212125.3193356-1-tathagat.dpdk@gmail.com>
References: <20261012073626.642397-1-tathagat.dpdk@gmail.com>
 <20261026212125.3193356-1-tathagat.dpdk@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 10:34:36 +0100
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

Hardware TSO offloads TCP segmentation to the adapter, reducing host
CPU overhead and allowing transmit bursts of up to 64KB TCP packets at
wire speed.

For a packet with RTE_MBUF_F_TX_TCP_SEG and a non-zero tso_segsz, put
the L2/L3/L4 headers alone in the first SGE and the payload in the
following ones, pass tso_segsz as the client data unit, and request IP
and TCP checksum offload with the pseudo-header checksum seeded. A first
segment that also carries payload needs one extra SGE, which is
documented in mana.rst.

A packet that cannot be sent as TSO (headers split across segments, no
IP version flag, SGL build failure) is dropped. A packet with TCP_SEG
but no tso_segsz or no payload is sent unsegmented, with the TCP
checksum offloaded as TCP_SEG implies.

Tested on Azure Standard_D8ds_v6 (kernel 6.8.0-1067-azure, MANA PCI
7870:00:00.0; driver reports no firmware version) with DPDK testpmd:
- Single segment IPv4 TCP (4000-byte packet, MSS 1460): verified
  segmentation into 1514, 1514, and 1080 byte frames on receiver.
- Multi-segment with header alone in first segment (54, 1400, 1400, 1146):
  verified identical segmentation.
- Multi-segment with payload in first segment (200, 1400, 1400, 1000):
  verified extra SGE allocation and segmentation without drops.
- Non-TSO fallback (MSS 0): verified transmission as single unsegmented
  frames.
- Verified consecutive TCP sequence numbers, incrementing IP IDs, and
  valid IP and TCP checksums via tcpdump on peer VM.

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
---
 doc/guides/nics/features/mana.ini      |   1 +
 doc/guides/nics/mana.rst               |   8 ++
 doc/guides/rel_notes/release_26_11.rst |   4 +
 drivers/net/mana/gdma.c                |   5 +
 drivers/net/mana/mana.h                |   6 +-
 drivers/net/mana/tx.c                  | 179 +++++++++++++++++++++----
 6 files changed, 173 insertions(+), 30 deletions(-)

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
diff --git a/doc/guides/nics/mana.rst b/doc/guides/nics/mana.rst
index 25580c1082..6752ab8bc9 100644
--- a/doc/guides/nics/mana.rst
+++ b/doc/guides/nics/mana.rst
@@ -109,3 +109,11 @@ To distinguish a PCI hot-remove from a service reset,
 the driver registers for PCI device removal events.
 This requires the application to call ``rte_dev_event_monitor_start()``
 for removal events to be delivered (e.g. testpmd ``--hot-plug-handling`` option).
+
+Limitations
+-----------
+
+* For TSO packets where the first segment contains packet payload beyond the
+  headers, an additional scatter-gather entry is required for the header.
+  In this case, the effective maximum number of segments supported is
+  ``nb_seg_max - 1``.
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
diff --git a/drivers/net/mana/mana.h b/drivers/net/mana/mana.h
index 79879b7626..5ac316f4e3 100644
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
@@ -208,6 +209,9 @@ struct one_sgl {
 	struct gdma_sgl_element gdma_sgl[MAX_SGL_ENTRIES_FOR_TRANSMIT];
 };
 
+#define GDMA_WR_OOB_IN_SGL  (1 << 0)
+#define GDMA_WR_PAD_BY_SGE0 (1 << 1)
+
 struct gdma_work_request {
 	struct gdma_header gdma_header;
 	struct gdma_sgl_element *sgl;
diff --git a/drivers/net/mana/tx.c b/drivers/net/mana/tx.c
index 16e63e89c9..1421f6f7c6 100644
--- a/drivers/net/mana/tx.c
+++ b/drivers/net/mana/tx.c
@@ -274,15 +274,35 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
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
+			if (unlikely(m_pkt->data_len < gso_hs)) {
+				DP_LOG(ERR, "TSO header cannot be fragmented");
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
 
@@ -307,8 +327,45 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
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
 
 			/* HW needs partial TCP checksum */
@@ -407,34 +464,92 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
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
@@ -452,7 +567,7 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		work_req.gdma_header.struct_size = sizeof(work_req);
 
 		work_req.sgl = sgl.gdma_sgl;
-		work_req.num_sgl_elements = m_pkt->nb_segs;
+		work_req.num_sgl_elements = num_sge;
 		if (tx_oob.short_oob.packet_format == SHORT_PACKET_FORMAT)
 			work_req.inline_oob_size_in_bytes =
 				sizeof(struct transmit_short_oob_v2);
@@ -460,8 +575,14 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
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

