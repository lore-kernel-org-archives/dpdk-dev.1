Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E76DE8305D
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 07:08:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E670540657;
	Tue,  3 Feb 2026 08:07:51 +0100 (CET)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id 8C13240611
 for <dev@dpdk.org>; Tue,  3 Feb 2026 08:07:48 +0100 (CET)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-126ea4b77adso1053716c88.1
 for <dev@dpdk.org>; Mon, 02 Feb 2026 23:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770102467; x=1770707267; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzZXfdEFxFt8JpGJIezVLIXv9ZEGCLwOtqM14IO3HRk=;
 b=f2AUe+OVTQtsAWo+zvbPvPMmLyX3E+w7nZjOylL9+I481o/WRBCyHp6XJQUv1CCV6h
 ryGxiFRzhlXuMz8+aCns+NSJIQurTYpT5QxzU3QWfnyLRqz4FSv91kre0ha3EJjxMack
 2X2OpuorgO0e+NDIRUgkqnn1SLXCG6cMncpjZH6XjkOGxj312U+za7BPFzHEcUT3Fa1p
 Rl1oLPtgfaM7o13iLyBO2CzKSJ/ydadzhWnyYhP9+pWIPRj6HnYQTKX+salQqFndNitT
 KJsCNJMDl1WYNuXAWUVXc8Xkxq9RAH7iAqqcajm6Fwi1Brh7Tt3y0jK0OgDLxKrR6ueP
 XwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770102467; x=1770707267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yzZXfdEFxFt8JpGJIezVLIXv9ZEGCLwOtqM14IO3HRk=;
 b=RNpHw16D1V4fgrfGdEUzzp+1qA71/FsjlTMmR4Y4Oxbv6RUlkYtSAOI0zX0cZXEftJ
 mFOs0G3u4ta5c1LjYULJ2Eu5unOja5pVxMOD/ymWLH3ZG3UDj69kA+la+hqkpwV3aBc8
 HoRu5f/z5eIXffcWCa5eyg07utw1VNKRlnJA0sMIkCeaXg8SHNPq9JNiXRelC3fwn9Pm
 XQ3cz0YaxFyy+07SsNF7F5/3brL3ke4jWphakjtB6mpAWYbOOBww8t56bYag5tRx/rNr
 xjTrvlqyo+SE2J4moduSoVjbg5uk43/zaS0M2RY79ailOjKYvjaKM4CvtJM1Ryblj5SA
 hM5A==
X-Gm-Message-State: AOJu0YzsgO6MtcujVc8YAkQhc+LNZDG5yJw2e1WkpRDw3ScfPECfNecN
 joXnFG5hVjQbhe4wlkkFBnPGpRLRQ8PfYxvFgnrc//4hJQRYQdZz5DED+P3tmQ==
X-Gm-Gg: AZuq6aJMxOpULh1O9WPSL6tj5H3dkxZNaXyTL49jYkgu3k1sLYXHCBbitmp8rfvCS+Y
 LONu8hFOluEa9M2Ou0pJheAONxr3BaWc+63vnKTN9bXR2/uTtZwIvVj+6fOOJCja3PkOZ/+H7nl
 tET3K0rmGl9YIvGKP2nC791InOFsWLeAAZV/M3igsL6yimNoubsodUgnFnHCJYcwmYYB/rEDvIj
 neVRGp+NqpkuGnrdIkL9kRBQ8eSJdE0bGorQST/KctxFLYENuQVK8NWSothCTeZiEO/JccmdlvQ
 ZthONjVNKWmh9RKHY6VFLBF8a9yNb5c1RZfV7hHb1fExFUwkwUZANYfr1eK0aZXH1qWR3MtYdGF
 RfzgeQbvKUuO3yMOP00vX12HV564+uaTzlGevQRIOaV1AJYS6ZMP870hHtuEF7dQHzn7/5yUTh7
 Um/jF+bcl4wW8U1VNsCP9tXA==
X-Received: by 2002:a05:7300:4306:b0:2b7:b7e7:9025 with SMTP id
 5a478bee46e88-2b7c88f4382mr7309186eec.31.1770102467272; 
 Mon, 02 Feb 2026 23:07:47 -0800 (PST)
Received: from mac.com ([136.24.82.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b7a16cfaa8sm21073318eec.4.2026.02.02.23.07.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 23:07:46 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v5 4/4] net/af_packet: add software checksum offload support
Date: Mon,  2 Feb 2026 23:07:40 -0800
Message-Id: <20260203070740.62305-5-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260203070740.62305-1-scott.k.mitch1@gmail.com>
References: <20260202081456.4322-1-scott.k.mitch1@gmail.com>
 <20260203070740.62305-1-scott.k.mitch1@gmail.com>
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
Depends-on: patch-160679 ("eal: add __rte_may_alias and __rte_aligned to unaligned typedefs")

 doc/guides/nics/features/afpacket.ini     |  2 +
 doc/guides/rel_notes/release_26_03.rst    |  2 +
 drivers/net/af_packet/rte_eth_af_packet.c | 42 ++++++++++----
 drivers/net/tap/rte_eth_tap.c             | 70 ++---------------------
 lib/net/rte_net.c                         | 68 ++++++++++++++++++++++
 lib/net/rte_net.h                         | 22 +++++++
 6 files changed, 130 insertions(+), 76 deletions(-)

diff --git a/doc/guides/nics/features/afpacket.ini b/doc/guides/nics/features/afpacket.ini
index 391f79b173..4bb81c84ff 100644
--- a/doc/guides/nics/features/afpacket.ini
+++ b/doc/guides/nics/features/afpacket.ini
@@ -7,5 +7,7 @@
 Link status          = Y
 Promiscuous mode     = Y
 MTU update           = Y
+L3 checksum offload  = Y
+L4 checksum offload  = Y
 Basic stats          = Y
 Stats per queue      = Y
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 3b6be19645..2946acce99 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -60,6 +60,8 @@ New Features
   * Fixed kernel memory barrier protocol for memory availability
   * Fixed shared memory frame overhead offset calculation
   * Added ``txpollnotrdy`` devarg to avoid ``poll()`` blocking calls
+  * Added checksum offload support for ``IPV4_CKSUM``, ``UDP_CKSUM``,
+    and ``TCP_CKSUM``
 
 Removed Items
 -------------
diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index 9df1b1fd4c..662341ffc7 100644
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
@@ -101,6 +103,7 @@ struct pmd_internals {
 	struct pkt_tx_queue *tx_queue;
 	uint8_t vlan_strip;
 	uint8_t timestamp_offloading;
+	bool tx_sw_cksum;
 };
 
 static const char *valid_arguments[] = {
@@ -220,7 +223,7 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		/* account for the receive frame */
 		bufs[i] = mbuf;
 		num_rx++;
-		num_rx_bytes += mbuf->pkt_len;
+		num_rx_bytes += rte_pktmbuf_pkt_len(mbuf);
 	}
 	pkt_q->framenum = framenum;
 	pkt_q->rx_pkts += num_rx;
@@ -256,6 +259,7 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
 	struct tpacket2_hdr *ppd;
 	struct rte_mbuf *mbuf;
+	struct rte_mbuf *seg;
 	uint8_t *pbuf;
 	unsigned int framecount, framenum;
 	struct pollfd pfd;
@@ -277,7 +281,7 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		mbuf = bufs[i];
 
 		/* Drop oversized packets. Insert VLAN if necessary */
-		if (unlikely(mbuf->pkt_len > pkt_q->frame_data_size ||
+		if (unlikely(rte_pktmbuf_pkt_len(mbuf) > pkt_q->frame_data_size ||
 			    ((mbuf->ol_flags & RTE_MBUF_F_TX_VLAN) != 0 &&
 			     rte_vlan_insert(&mbuf) != 0))) {
 			continue;
@@ -308,23 +312,32 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 		pbuf = (uint8_t *)ppd + ETH_AF_PACKET_FRAME_OVERHEAD;
 
-		ppd->tp_len = mbuf->pkt_len;
-		ppd->tp_snaplen = mbuf->pkt_len;
+		if (pkt_q->sw_cksum) {
+			seg = rte_net_ip_udptcp_cksum_mbuf(mbuf);
+			if (!seg)
+				continue;
 
-		struct rte_mbuf *tmp_mbuf = mbuf;
+			mbuf = seg;
+			bufs[i] = seg;
+		}
+
+		ppd->tp_len = rte_pktmbuf_pkt_len(mbuf);
+		ppd->tp_snaplen = rte_pktmbuf_pkt_len(mbuf);
+
+		seg = mbuf;
 		do {
-			uint16_t data_len = rte_pktmbuf_data_len(tmp_mbuf);
-			memcpy(pbuf, rte_pktmbuf_mtod(tmp_mbuf, void*), data_len);
+			uint16_t data_len = rte_pktmbuf_data_len(seg);
+			memcpy(pbuf, rte_pktmbuf_mtod(seg, void*), data_len);
 			pbuf += data_len;
-			tmp_mbuf = tmp_mbuf->next;
-		} while (tmp_mbuf);
+			seg = seg->next;
+		} while (seg);
 
 		/* release incoming frame and advance ring buffer */
 		tpacket_write_status(&ppd->tp_status, TP_STATUS_SEND_REQUEST);
 		if (++framenum >= framecount)
 			framenum = 0;
 		num_tx++;
-		num_tx_bytes += mbuf->pkt_len;
+		num_tx_bytes += rte_pktmbuf_pkt_len(mbuf);
 	}
 
 	rte_pktmbuf_free_bulk(&bufs[0], i);
@@ -396,10 +409,13 @@ eth_dev_configure(struct rte_eth_dev *dev __rte_unused)
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
 
@@ -417,7 +433,10 @@ eth_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
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
 
@@ -618,6 +637,7 @@ eth_tx_queue_setup(struct rte_eth_dev *dev,
 {
 
 	struct pmd_internals *internals = dev->data->dev_private;
+	internals->tx_queue[tx_queue_id].sw_cksum = internals->tx_sw_cksum;
 
 	dev->data->tx_queues[tx_queue_id] = &internals->tx_queue[tx_queue_id];
 	return 0;
diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 730f1859bd..c7ed6dfb8b 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -525,7 +525,6 @@ tap_write_mbufs(struct tx_queue *txq, uint16_t num_mbufs,
 		struct iovec iovecs[mbuf->nb_segs + 2];
 		struct tun_pi pi = { .flags = 0, .proto = 0x00 };
 		struct rte_mbuf *seg = mbuf;
-		uint64_t l4_ol_flags;
 		int proto;
 		int n;
 		int j;
@@ -556,74 +555,15 @@ tap_write_mbufs(struct tx_queue *txq, uint16_t num_mbufs,
 		iovecs[k].iov_len = sizeof(pi);
 		k++;
 
-		l4_ol_flags = mbuf->ol_flags & RTE_MBUF_F_TX_L4_MASK;
-		if (txq->csum && (mbuf->ol_flags & RTE_MBUF_F_TX_IP_CKSUM ||
-				l4_ol_flags == RTE_MBUF_F_TX_UDP_CKSUM ||
-				l4_ol_flags == RTE_MBUF_F_TX_TCP_CKSUM)) {
-			unsigned int hdrlens = mbuf->l2_len + mbuf->l3_len;
-			uint16_t *l4_cksum;
-			void *l3_hdr;
-
-			if (l4_ol_flags == RTE_MBUF_F_TX_UDP_CKSUM)
-				hdrlens += sizeof(struct rte_udp_hdr);
-			else if (l4_ol_flags == RTE_MBUF_F_TX_TCP_CKSUM)
-				hdrlens += sizeof(struct rte_tcp_hdr);
-			else if (l4_ol_flags != RTE_MBUF_F_TX_L4_NO_CKSUM)
+		if (txq->csum) {
+			seg = rte_net_ip_udptcp_cksum_mbuf(mbuf);
+			if (!seg)
 				return -1;
 
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
-			if (seg == NULL)
-				return -1;
-			rte_pktmbuf_adj(mbuf, hdrlens);
-			rte_pktmbuf_chain(seg, mbuf);
-			pmbufs[i] = mbuf = seg;
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
+			mbuf = seg;
+			pmbufs[i] = seg;
 		}
 
-skip_l4_cksum:
 		for (j = 0; j < mbuf->nb_segs; j++) {
 			iovecs[k].iov_len = rte_pktmbuf_data_len(seg);
 			iovecs[k].iov_base = rte_pktmbuf_mtod(seg, void *);
diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index 458b4814a9..1a0397bcd7 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -615,3 +615,71 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
 
 	return pkt_type;
 }
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_net_ip_udptcp_cksum_mbuf, 26.03)
+struct rte_mbuf *
+rte_net_ip_udptcp_cksum_mbuf(struct rte_mbuf *mbuf)
+{
+	const uint64_t l4_ol_flags = mbuf->ol_flags & RTE_MBUF_F_TX_L4_MASK;
+	const uint32_t l4_offset = mbuf->l2_len + mbuf->l3_len;
+	uint32_t hdrlens = l4_offset;
+	unaligned_uint16_t *l4_cksum = NULL;
+	void *l3_hdr;
+
+	/* Quick check - nothing to do if no checksum offloads requested */
+	if (!(mbuf->ol_flags & (RTE_MBUF_F_TX_IP_CKSUM | RTE_MBUF_F_TX_L4_MASK)))
+		return mbuf;
+
+	/* Determine total header length needed */
+	if (l4_ol_flags == RTE_MBUF_F_TX_UDP_CKSUM)
+		hdrlens += sizeof(struct rte_udp_hdr);
+	else if (l4_ol_flags == RTE_MBUF_F_TX_TCP_CKSUM)
+		hdrlens += sizeof(struct rte_tcp_hdr);
+	else if (l4_ol_flags != RTE_MBUF_F_TX_L4_NO_CKSUM)
+		return NULL; /* Unsupported L4 checksum type */
+
+	/* Validate we at least have L2+L3 headers */
+	if (unlikely(rte_pktmbuf_data_len(mbuf) < l4_offset))
+		return NULL;
+
+	if (!RTE_MBUF_DIRECT(mbuf) || rte_mbuf_refcnt_read(mbuf) > 1) {
+		/* Indirect or shared - must copy, cannot modify in-place */
+		struct rte_mbuf *seg = rte_pktmbuf_copy(mbuf, mbuf->pool, 0, hdrlens);
+		if (!seg)
+			return NULL;
+
+		rte_pktmbuf_adj(mbuf, hdrlens);
+		rte_pktmbuf_chain(seg, mbuf);
+		mbuf = seg;
+	} else if (rte_pktmbuf_data_len(mbuf) < hdrlens &&
+		(rte_pktmbuf_linearize(mbuf) < 0 || rte_pktmbuf_data_len(mbuf) < hdrlens)) {
+		/* failed: direct, non-shared, but segmented headers linearize in-place */
+		return NULL;
+	}
+	/* else: Direct, non-shared, contiguous - can modify in-place, nothing to do */
+
+	l3_hdr = rte_pktmbuf_mtod_offset(mbuf, void *, mbuf->l2_len);
+
+	/* IPv4 header checksum */
+	if (mbuf->ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
+		struct rte_ipv4_hdr *iph = (struct rte_ipv4_hdr *)l3_hdr;
+		iph->hdr_checksum = 0;
+		iph->hdr_checksum = rte_ipv4_cksum(iph);
+	}
+
+	/* L4 checksum */
+	if (l4_ol_flags == RTE_MBUF_F_TX_UDP_CKSUM)
+		l4_cksum = &rte_pktmbuf_mtod_offset(mbuf, struct rte_udp_hdr *,
+				l4_offset)->dgram_cksum;
+	else if (l4_ol_flags == RTE_MBUF_F_TX_TCP_CKSUM)
+		l4_cksum = &rte_pktmbuf_mtod_offset(mbuf, struct rte_tcp_hdr *, l4_offset)->cksum;
+
+	if (l4_cksum) {
+		*l4_cksum = 0;
+		*l4_cksum = (mbuf->ol_flags & RTE_MBUF_F_TX_IPV4) ?
+				rte_ipv4_udptcp_cksum_mbuf(mbuf, l3_hdr, l4_offset) :
+				rte_ipv6_udptcp_cksum_mbuf(mbuf, l3_hdr, l4_offset);
+	}
+
+	return mbuf;
+}
diff --git a/lib/net/rte_net.h b/lib/net/rte_net.h
index 65d724b84b..b258a86928 100644
--- a/lib/net/rte_net.h
+++ b/lib/net/rte_net.h
@@ -246,6 +246,28 @@ rte_net_intel_cksum_prepare(struct rte_mbuf *m)
 	return rte_net_intel_cksum_flags_prepare(m, m->ol_flags);
 }
 
+/**
+ * Compute IP and L4 checksums in software for mbufs with
+ * RTE_MBUF_F_TX_IP_CKSUM, RTE_MBUF_F_TX_UDP_CKSUM, or
+ * RTE_MBUF_F_TX_TCP_CKSUM offload flags set.
+ *
+ * On success, this function takes ownership of the input mbuf. The mbuf may be
+ * modified in-place (for direct, non-shared mbufs) or a new mbuf chain may be
+ * created (for indirect/shared mbufs) with the original becoming part of the chain.
+ *
+ * @param mbuf
+ *   The packet mbuf to checksum.
+ * @return
+ *   - On success: pointer to mbuf with checksums computed (may be same as input
+ *     or a new mbuf chain). Caller must free only this returned pointer; the input
+ *     mbuf pointer should not be freed separately as it may be part of the returned
+ *     chain or may be the same as the returned pointer.
+ *   - On error: NULL. Original mbuf remains valid and owned by caller.
+ */
+__rte_experimental
+struct rte_mbuf *
+rte_net_ip_udptcp_cksum_mbuf(struct rte_mbuf *mbuf);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.39.5 (Apple Git-154)

