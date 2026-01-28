Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B81BD46BF4
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 19:12:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2241140A70;
	Wed, 28 Jan 2026 20:12:32 +0100 (CET)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 1AD1A40670
 for <dev@dpdk.org>; Wed, 28 Jan 2026 20:12:28 +0100 (CET)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2b73112ab62so244825eec.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 11:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769627547; x=1770232347; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O9GNu4V6gg7SWCIJvbegfY6SKDH8FFXtT3CPsoo1XSY=;
 b=T3e0g56ZtCADkAlLw/+RcfkyOsv6FxtngkwBDFY5bmzCwAIcnUufNoX1E7FDNCwo4e
 uQjlHTXpnZQxhFmUmok89694s2+XLzW9PQy7GJPArtmAu6lWURY8dCJqsSaRjHdBLDxl
 0PQZwot5tWFLiq+w+BmwsgEy0QNddwDjOyh8ClS2taf+qJ8PDMfq+M4sFWf/iKHVx3W0
 HE8Y53IhMXB0SqAtumzk0EOpCsCkzFzEU+1x0yF5un0vj7PkK3k+uijKTi86Y0IM5TUs
 sBIY4qmGemzHxC2WcAP1txQRsfDA2xiqvMM4Zsu8oXphjM3kdh6vnD1Hq4aSQlH+TbUD
 UUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769627547; x=1770232347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O9GNu4V6gg7SWCIJvbegfY6SKDH8FFXtT3CPsoo1XSY=;
 b=UgYQeMCRPHKIY2EWtjbWfJ+oM1ykq0wNSaKnyoMAQgywsS2CUyxzx99WMAIcj3rTXh
 zydQL52jlcVTdp1CKNgEeGNLSWeExHvk6PPLO4orSuYJCe8cfSYWO8DYpTRLG98X7DoO
 oPNfx23QD6RIO5eCar35wUYhwgqi+Uw95rqmf2EX4I2ZphLPYl0M9d4C2QJwKXoYR1Uc
 +auFyki4OCrBlMfMM1vvibbiu5ybJ8IM22efmXsGqawMaEgjn/PIVyVtY8ykZ9wGOfYD
 Irpz3HZOlQduAXDCIEfPC50e7jS6rzymc+7hw/y7SKRkY1wACUV17ftId0O1B2MTji00
 hPeA==
X-Gm-Message-State: AOJu0Yw/vHaElwmHqZdeVdBj837rXRDWHxSjia5IMh5imWTfmbJmvN0c
 bZG4DcSyseHLZ+QazpqHT/Y/R+TGUWuTn/16cvxLM8M7Orz9eo5NfHks+sodAQ==
X-Gm-Gg: AZuq6aLaOy1i29PETeLW4HgW2BrnfUVlQYEQiMv58V/mX8zVq3mOL78cRkZjMSuvlOa
 Vt90egW00AArt66mFf8dlItLeDUdVuwFTbTNYH2YWfR7odieslK28rKUm9NJ/0n2G8j/PSEOK0U
 XbiLHntTTjlddkd9eynkvyY2hhtazxR50rL3pjF84Kakvq///ZF9IwLULe0sptCKTUqanV0xTs0
 Cz6i/SCYs3S9G1ojToly/dY4SZ6R3ebzG2y3rP+5fubcIeLQIW1aDJm7SN4luIvQ1vTBCGcVavh
 7r/Iv3byMeJAdN1hmU9pyFbk303366nsziqAPxPkT5Mk6tXTNtZ2GTMXDnbssRjm3SWMjpgL98U
 hs49Y6+xFGRW9uyp0xroQm3aqIMKhVkQWPXJM8ufQxMjs/cY95/moXFeoQCSIY0aKbWi9vyqm1M
 8LYKvZP5VpsWDckV4wz6LOiuF/KXhtyLgPyAknyuwTt1rPTCauqQ==
X-Received: by 2002:a05:7300:e688:b0:2b7:19f2:6b70 with SMTP id
 5a478bee46e88-2b78d9f1bf6mr3332762eec.26.1769627546872; 
 Wed, 28 Jan 2026 11:12:26 -0800 (PST)
Received: from mr41p01nt-relayp04.apple.com ([17.199.85.102])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b7a1adc5ecsm4261286eec.24.2026.01.28.11.12.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jan 2026 11:12:26 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v3 4/4] net/af_packet: software checksum
Date: Wed, 28 Jan 2026 11:10:32 -0800
Message-Id: <20260128191032.78916-5-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260128191032.78916-1-scott.k.mitch1@gmail.com>
References: <20260128093607.62908-1-scott.k.mitch1@gmail.com>
 <20260128191032.78916-1-scott.k.mitch1@gmail.com>
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

From: Scott Mitchell <scott.k.mitch1@gmail.com>

Add software checksum offload support and configurable TX poll
behavior to improve flexibility and performance.

Add rte_net_ip_udptcp_cksum_mbuf in rte_net.h which is shared
between rte_eth_tap and rte_eth_af_packet that supports
IPv4/UDP/TCP checksums in software due to hardware offload
and context propagation not being supported.

Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 15 +++-
 drivers/net/tap/rte_eth_tap.c             | 61 +--------------
 lib/net/rte_net.h                         | 90 +++++++++++++++++++++++
 3 files changed, 106 insertions(+), 60 deletions(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index be8e3260aa..19bafc99a6 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -10,6 +10,8 @@
 #include <rte_string_fns.h>
 #include <rte_mbuf.h>
 #include <rte_atomic.h>
+#include <rte_ip.h>
+#include <rte_net.h>
 #include <rte_bitops.h>
 #include <ethdev_driver.h>
 #include <ethdev_vdev.h>
@@ -102,6 +104,7 @@ struct pmd_internals {
 	struct pkt_tx_queue *tx_queue;
 	uint8_t vlan_strip;
 	uint8_t timestamp_offloading;
+	bool tx_sw_cksum;
 };
 
 static const char *valid_arguments[] = {
@@ -329,6 +332,9 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		ppd->tp_len = mbuf->pkt_len;
 		ppd->tp_snaplen = mbuf->pkt_len;
 
+		if (pkt_q->sw_cksum && !rte_net_ip_udptcp_cksum_mbuf(mbuf, false))
+			continue;
+
 		struct rte_mbuf *tmp_mbuf = mbuf;
 		do {
 			uint16_t data_len = rte_pktmbuf_data_len(tmp_mbuf);
@@ -413,10 +419,13 @@ eth_dev_configure(struct rte_eth_dev *dev __rte_unused)
 {
 	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
 	const struct rte_eth_rxmode *rxmode = &dev_conf->rxmode;
+	const struct rte_eth_txmode *txmode = &dev_conf->txmode;
 	struct pmd_internals *internals = dev->data->dev_private;
 
 	internals->vlan_strip = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP);
 	internals->timestamp_offloading = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP);
+	internals->tx_sw_cksum = !!(txmode->offloads & (RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
+			RTE_ETH_TX_OFFLOAD_UDP_CKSUM | RTE_ETH_TX_OFFLOAD_TCP_CKSUM));
 	return 0;
 }
 
@@ -434,7 +443,10 @@ eth_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->max_tx_queues = (uint16_t)internals->nb_queues;
 	dev_info->min_rx_bufsize = ETH_AF_PACKET_ETH_OVERHEAD;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
-		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
+		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |
+		RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
+		RTE_ETH_TX_OFFLOAD_UDP_CKSUM |
+		RTE_ETH_TX_OFFLOAD_TCP_CKSUM;
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
 		RTE_ETH_RX_OFFLOAD_TIMESTAMP;
 
@@ -635,6 +647,7 @@ eth_tx_queue_setup(struct rte_eth_dev *dev,
 {
 
 	struct pmd_internals *internals = dev->data->dev_private;
+	internals->tx_queue[tx_queue_id].sw_cksum = internals->tx_sw_cksum;
 
 	dev->data->tx_queues[tx_queue_id] = &internals->tx_queue[tx_queue_id];
 	return 0;
diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 730f1859bd..55f496babe 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -560,70 +560,13 @@ tap_write_mbufs(struct tx_queue *txq, uint16_t num_mbufs,
 		if (txq->csum && (mbuf->ol_flags & RTE_MBUF_F_TX_IP_CKSUM ||
 				l4_ol_flags == RTE_MBUF_F_TX_UDP_CKSUM ||
 				l4_ol_flags == RTE_MBUF_F_TX_TCP_CKSUM)) {
-			unsigned int hdrlens = mbuf->l2_len + mbuf->l3_len;
-			uint16_t *l4_cksum;
-			void *l3_hdr;
-
-			if (l4_ol_flags == RTE_MBUF_F_TX_UDP_CKSUM)
-				hdrlens += sizeof(struct rte_udp_hdr);
-			else if (l4_ol_flags == RTE_MBUF_F_TX_TCP_CKSUM)
-				hdrlens += sizeof(struct rte_tcp_hdr);
-			else if (l4_ol_flags != RTE_MBUF_F_TX_L4_NO_CKSUM)
-				return -1;
-
-			/* Support only packets with at least layer 4
-			 * header included in the first segment
-			 */
-			if (rte_pktmbuf_data_len(mbuf) < hdrlens)
-				return -1;
-
-			/* To change checksums (considering that a mbuf can be
-			 * indirect, for example), copy l2, l3 and l4 headers
-			 * in a new segment and chain it to existing data
-			 */
-			seg = rte_pktmbuf_copy(mbuf, mbuf->pool, 0, hdrlens);
+			/* Compute checksums in software, copying headers if needed */
+			seg = rte_net_ip_udptcp_cksum_mbuf(mbuf, true);
 			if (seg == NULL)
 				return -1;
-			rte_pktmbuf_adj(mbuf, hdrlens);
-			rte_pktmbuf_chain(seg, mbuf);
 			pmbufs[i] = mbuf = seg;
-
-			l3_hdr = rte_pktmbuf_mtod_offset(mbuf, void *, mbuf->l2_len);
-			if (mbuf->ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
-				struct rte_ipv4_hdr *iph = l3_hdr;
-
-				iph->hdr_checksum = 0;
-				iph->hdr_checksum = rte_ipv4_cksum(iph);
-			}
-
-			if (l4_ol_flags == RTE_MBUF_F_TX_L4_NO_CKSUM)
-				goto skip_l4_cksum;
-
-			if (l4_ol_flags == RTE_MBUF_F_TX_UDP_CKSUM) {
-				struct rte_udp_hdr *udp_hdr;
-
-				udp_hdr = rte_pktmbuf_mtod_offset(mbuf, struct rte_udp_hdr *,
-					mbuf->l2_len + mbuf->l3_len);
-				l4_cksum = &udp_hdr->dgram_cksum;
-			} else {
-				struct rte_tcp_hdr *tcp_hdr;
-
-				tcp_hdr = rte_pktmbuf_mtod_offset(mbuf, struct rte_tcp_hdr *,
-					mbuf->l2_len + mbuf->l3_len);
-				l4_cksum = &tcp_hdr->cksum;
-			}
-
-			*l4_cksum = 0;
-			if (mbuf->ol_flags & RTE_MBUF_F_TX_IPV4) {
-				*l4_cksum = rte_ipv4_udptcp_cksum_mbuf(mbuf, l3_hdr,
-					mbuf->l2_len + mbuf->l3_len);
-			} else {
-				*l4_cksum = rte_ipv6_udptcp_cksum_mbuf(mbuf, l3_hdr,
-					mbuf->l2_len + mbuf->l3_len);
-			}
 		}
 
-skip_l4_cksum:
 		for (j = 0; j < mbuf->nb_segs; j++) {
 			iovecs[k].iov_len = rte_pktmbuf_data_len(seg);
 			iovecs[k].iov_base = rte_pktmbuf_mtod(seg, void *);
diff --git a/lib/net/rte_net.h b/lib/net/rte_net.h
index 65d724b84b..c640ccbba2 100644
--- a/lib/net/rte_net.h
+++ b/lib/net/rte_net.h
@@ -246,6 +246,96 @@ rte_net_intel_cksum_prepare(struct rte_mbuf *m)
 	return rte_net_intel_cksum_flags_prepare(m, m->ol_flags);
 }
 
+/**
+ * Compute IPv4 header and UDP/TCP checksums in software.
+ *
+ * Computes checksums based on mbuf offload flags:
+ * - RTE_MBUF_F_TX_IP_CKSUM: Compute IPv4 header checksum
+ * - RTE_MBUF_F_TX_UDP_CKSUM: Compute UDP checksum (IPv4 or IPv6)
+ * - RTE_MBUF_F_TX_TCP_CKSUM: Compute TCP checksum (IPv4 or IPv6)
+ *
+ * @param mbuf
+ *   The packet mbuf. Must have l2_len and l3_len set correctly.
+ * @param copy
+ *   If true, copy L2/L3/L4 headers to a new segment before computing
+ *   checksums. This is safe for indirect mbufs but has overhead.
+ *   If false, compute checksums in place. This is only safe if the
+ *   mbuf will be copied afterward (e.g., to a device ring buffer).
+ * @return
+ *   - On success: Returns mbuf (new segment if copy=true, original if copy=false)
+ *   - On error: Returns NULL (allocation failed or malformed packet)
+ */
+static inline struct rte_mbuf *
+rte_net_ip_udptcp_cksum_mbuf(struct rte_mbuf *mbuf, bool copy)
+{
+	const uint64_t l4_ol_flags = mbuf->ol_flags & RTE_MBUF_F_TX_L4_MASK;
+	const uint64_t l4_offset = mbuf->l2_len + mbuf->l3_len;
+	uint32_t hdrlens = l4_offset;
+
+	/* Determine total header length needed */
+	if (l4_ol_flags == RTE_MBUF_F_TX_UDP_CKSUM)
+		hdrlens += sizeof(struct rte_udp_hdr);
+	else if (l4_ol_flags == RTE_MBUF_F_TX_TCP_CKSUM)
+		hdrlens += sizeof(struct rte_tcp_hdr);
+	else if (l4_ol_flags != RTE_MBUF_F_TX_L4_NO_CKSUM)
+		return NULL; /* Unsupported L4 checksum type */
+	else if (!(mbuf->ol_flags & RTE_MBUF_F_TX_IP_CKSUM))
+		return mbuf; /* Nothing to do */
+
+	/* Validate we at least have L2+L3 headers before doing any work */
+	if (unlikely(rte_pktmbuf_data_len(mbuf) < l4_offset))
+		return NULL;
+
+	if (copy) {
+		/*
+		 * Copy headers to new segment to handle indirect mbufs.
+		 * This ensures we can safely modify checksums without
+		 * corrupting shared/read-only data.
+		 */
+		struct rte_mbuf *seg = rte_pktmbuf_copy(mbuf, mbuf->pool, 0, hdrlens);
+		if (!seg)
+			return NULL;
+
+		rte_pktmbuf_adj(mbuf, hdrlens);
+		rte_pktmbuf_chain(seg, mbuf);
+		mbuf = seg;
+	} else if (unlikely(!RTE_MBUF_DIRECT(mbuf) || rte_mbuf_refcnt_read(mbuf) > 1))
+		return NULL;
+
+	void *l3_hdr = rte_pktmbuf_mtod_offset(mbuf, void *, mbuf->l2_len);
+
+	/* IPv4 header checksum */
+	if (mbuf->ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
+		struct rte_ipv4_hdr *iph = (struct rte_ipv4_hdr *)l3_hdr;
+		iph->hdr_checksum = 0;
+		iph->hdr_checksum = rte_ipv4_cksum(iph);
+	}
+
+	/* L4 checksum (UDP or TCP) - skip if headers not in first segment */
+	if (l4_ol_flags == RTE_MBUF_F_TX_UDP_CKSUM && rte_pktmbuf_data_len(mbuf) >= hdrlens) {
+		struct rte_udp_hdr *udp_hdr = rte_pktmbuf_mtod_offset(mbuf, struct rte_udp_hdr *,
+				l4_offset);
+		udp_hdr->dgram_cksum = 0;
+		udp_hdr->dgram_cksum = (mbuf->ol_flags & RTE_MBUF_F_TX_IPV4) ?
+			rte_ipv4_udptcp_cksum_mbuf(mbuf, (const struct rte_ipv4_hdr *)l3_hdr,
+					l4_offset) :
+			rte_ipv6_udptcp_cksum_mbuf(mbuf, (const struct rte_ipv6_hdr *)l3_hdr,
+					l4_offset);
+	} else if (l4_ol_flags == RTE_MBUF_F_TX_TCP_CKSUM &&
+			rte_pktmbuf_data_len(mbuf) >= hdrlens) {
+		struct rte_tcp_hdr *tcp_hdr = rte_pktmbuf_mtod_offset(mbuf, struct rte_tcp_hdr *,
+				l4_offset);
+		tcp_hdr->cksum = 0;
+		tcp_hdr->cksum = (mbuf->ol_flags & RTE_MBUF_F_TX_IPV4) ?
+			rte_ipv4_udptcp_cksum_mbuf(mbuf,  (const struct rte_ipv4_hdr *)l3_hdr,
+					l4_offset) :
+			rte_ipv6_udptcp_cksum_mbuf(mbuf, (const struct rte_ipv6_hdr *)l3_hdr,
+					l4_offset);
+	}
+
+	return mbuf;
+}
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.39.5 (Apple Git-154)

