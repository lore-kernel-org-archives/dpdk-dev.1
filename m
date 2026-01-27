Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7795DD2FECE
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 18:16:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8ECDD4111B;
	Tue, 27 Jan 2026 19:16:47 +0100 (CET)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id C6C46410D0
 for <dev@dpdk.org>; Tue, 27 Jan 2026 19:16:46 +0100 (CET)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-1249b9f5703so2438110c88.0
 for <dev@dpdk.org>; Tue, 27 Jan 2026 10:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769537806; x=1770142606; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bLB+UcQZc7zzfPPhRwig31E2JYTPrcyOisMszExzq00=;
 b=ZfgKtz1nDq9GdiAYu7GtZQ6Vj3dICqWHONUKkgJoX/dCtmHAlYpH5NKBY/NJCgYB6r
 RT4Npzw0k36EMDzc03So68HBUA3agqoIX1jeuVlSeB4PQgDOTR1e0sfvwIKjo6+nzURr
 hVE9ZnoWn6tCddj/edtQZgoAwzkb1GzM1wgIA8MzTOUP9qZAJqmvINH1KpXP15rXMSFI
 OW3/LPW3fi1kIGuRihQV8CGBkpRcO1A1spkCXKjVwmV1WxnetWn7D5uHZJ1d4AbpwhXc
 kxMnmWhVMUDbac0w1Qp5ZGe7yx9QD2aXtGQtzzJmFAcMR9v76YMQFRU8l9usp0w8rUy5
 rxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769537806; x=1770142606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bLB+UcQZc7zzfPPhRwig31E2JYTPrcyOisMszExzq00=;
 b=AlAkaPNIA2FFwpzHwIpclhvZNvQ7ar+N3a57Re701UjHRbWtPacTgUPa2BWWgsOaeF
 k44rK1vP3pNPzOJvQKKm/N74zduogneBf6AxMNNr3+KdRjJV7iL6aMLBZxYdxjhTNCz6
 /I6130QwkNU5PMCi15vsMoSNUTDNvYU4NpqTtiVVFhqV0RHrbezv04ZxzhpJdtGTcz5q
 a3SaSBYr2u9YD8CsHXVABkKEdOJ19Te8nDiSX2nkaYsNfNW+xW8wmJ92emnaZAWtKCQz
 9eEeJQZWiEhYL5OYMF8LD0K642RqAgB26J707XK0LVJc2etf4Umdo6hnORfCHNvYrmwG
 g4fg==
X-Gm-Message-State: AOJu0YyFmKYtM9vaCePCdUrvpqezWphC1D+9tpwWH8UyVcHb1ZRrCHVW
 tsHSAH22NkBjUBfZm3pCsPk3Kc9OKkxN+yN/F50NR5LJKkH3kfitCX4dPwm3Tw==
X-Gm-Gg: AZuq6aIXPfJ9Mvu1dytoPHTwWz3b0mpIwrb+DgVVcWeeIUyAoL7Rkr8CVNGLMj7tpx7
 DfahmN/kHt1j2E6c2gzd4kIG/zex6BdssHunBVs9F/PuFyQSddxASZhb7kAd5YN77C+ykIJjL6p
 0JB+FIeRmfVvXrH4AXOaM2UKYiB9nnie1rbDLf6lbkBmVVVg+mppiVQYKLorr65xNC1q9ohsA7C
 VTK5F5Bt14v+TJDj3NoZ5ak48BDY8IJ5loQgsZYG9zXC3blAgu4uUDQ+Ytt1dVooW1ganpuDvC7
 8tpKZi1/AbfVxn3Ghj/Xvn/IwIwpfHeyhDlAtnZYkGseYExbH4JaJJQLglDucIR1n+Zx7DOTIFh
 /XBvq22+JcZ8rWKbpGO0kvSU5D46pF6cN7re9zY3XCeBzTVTerdgWmB9No1YCPPAcshFqPssY7q
 AAVb+esE1NdP1PYhwup8qcMysd5/Acn1lsaowjC4vGujuYpLR8vA==
X-Received: by 2002:a05:7022:6884:b0:11b:9386:8264 with SMTP id
 a92af1059eb24-124a00e447cmr1510613c88.41.1769537805594; 
 Tue, 27 Jan 2026 10:16:45 -0800 (PST)
Received: from mr41p01nt-relayp03.apple.com ([17.199.85.102])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-124a7bf8f5dsm483172c88.7.2026.01.27.10.16.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Jan 2026 10:16:45 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v1 3/3] net/af_packet: software checksum and tx poll control
Date: Tue, 27 Jan 2026 10:13:55 -0800
Message-Id: <20260127181355.98437-4-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260127181355.98437-1-scott.k.mitch1@gmail.com>
References: <20260127181355.98437-1-scott.k.mitch1@gmail.com>
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

Implement af_packet_sw_cksum() helper to compute IPv4/UDP/TCP
checksums in software when hardware offload is not available.
This enables checksum offload on interfaces without HW support.

Add txpollnotrdy devarg (default=true) to control whether poll()
is called when the TX ring is not ready. This allows users to
avoid blocking behavior if application threads are in asynchronous
poll mode where blocking the thread has negative side effects and
backpressure is applied via different means.

Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 82 +++++++++++++++++++++--
 1 file changed, 76 insertions(+), 6 deletions(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index 2d152a2e2f..2654e7feed 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -11,6 +11,7 @@
 #include <rte_mbuf.h>
 #include <rte_memcpy.h>
 #include <rte_atomic.h>
+#include <rte_ip.h>
 #include <rte_bitops.h>
 #include <ethdev_driver.h>
 #include <ethdev_vdev.h>
@@ -19,6 +20,7 @@
 #include <bus_vdev_driver.h>
 
 #include <errno.h>
+#include <stdbool.h>
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
 #include <arpa/inet.h>
@@ -40,9 +42,11 @@
 #define ETH_AF_PACKET_FRAMECOUNT_ARG	"framecnt"
 #define ETH_AF_PACKET_QDISC_BYPASS_ARG	"qdisc_bypass"
 #define ETH_AF_PACKET_FANOUT_MODE_ARG	"fanout_mode"
+#define ETH_AF_PACKET_TX_POLL_NOT_READY_ARG	"txpollnotrdy"
 
 #define DFLT_FRAME_SIZE		(1 << 11)
 #define DFLT_FRAME_COUNT	(1 << 9)
+#define DFLT_TX_POLL_NOT_RDY	true
 
 static const uint16_t ETH_AF_PACKET_FRAME_SIZE_MAX = RTE_IPV4_MAX_PKT_LEN;
 #define ETH_AF_PACKET_FRAME_OVERHEAD (TPACKET2_HDRLEN - sizeof(struct sockaddr_ll))
@@ -79,6 +83,9 @@ struct __rte_cache_aligned pkt_tx_queue {
 	unsigned int framecount;
 	unsigned int framenum;
 
+	bool txpollnotrdy;
+	bool sw_cksum;
+
 	RTE_ATOMIC(uint64_t) tx_pkts;
 	RTE_ATOMIC(uint64_t) err_pkts;
 	RTE_ATOMIC(uint64_t) tx_bytes;
@@ -97,6 +104,7 @@ struct pmd_internals {
 	struct pkt_tx_queue *tx_queue;
 	uint8_t vlan_strip;
 	uint8_t timestamp_offloading;
+	bool tx_sw_cksum;
 };
 
 static const char *valid_arguments[] = {
@@ -107,6 +115,7 @@ static const char *valid_arguments[] = {
 	ETH_AF_PACKET_FRAMECOUNT_ARG,
 	ETH_AF_PACKET_QDISC_BYPASS_ARG,
 	ETH_AF_PACKET_FANOUT_MODE_ARG,
+	ETH_AF_PACKET_TX_POLL_NOT_READY_ARG,
 	NULL
 };
 
@@ -127,6 +136,45 @@ RTE_LOG_REGISTER_DEFAULT(af_packet_logtype, NOTICE);
 	RTE_LOG_LINE(level, AFPACKET, "%s(): " fmt ":%s", __func__, \
 		## __VA_ARGS__, strerror(errno))
 
+/*
+ * Compute and set the IPv4 or IPv6 UDP/TCP checksum on a packet.
+ */
+static inline void
+af_packet_sw_cksum(struct rte_mbuf *mbuf)
+{
+	const uint64_t l4_offset = mbuf->l2_len + mbuf->l3_len;
+	const uint64_t mbuf_len = rte_pktmbuf_data_len(mbuf);
+	if (unlikely(mbuf_len < l4_offset))
+		return;
+
+	void *l3_hdr = rte_pktmbuf_mtod_offset(mbuf, void *, mbuf->l2_len);
+	const uint64_t ol_flags = mbuf->ol_flags;
+	if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
+		struct rte_ipv4_hdr *iph = l3_hdr;
+		iph->hdr_checksum = 0;
+		iph->hdr_checksum = rte_ipv4_cksum(iph);
+	}
+
+	uint64_t l4_ol_flags = mbuf->ol_flags & RTE_MBUF_F_TX_L4_MASK;
+	if (l4_ol_flags == RTE_MBUF_F_TX_UDP_CKSUM &&
+	    likely(mbuf_len >= l4_offset + sizeof(struct rte_udp_hdr))) {
+		struct rte_udp_hdr *udp_hdr =
+			rte_pktmbuf_mtod_offset(mbuf, struct rte_udp_hdr *, l4_offset);
+		udp_hdr->dgram_cksum = 0;
+		udp_hdr->dgram_cksum = (ol_flags & RTE_MBUF_F_TX_IPV4) ?
+			rte_ipv4_udptcp_cksum_mbuf(mbuf, l3_hdr, l4_offset) :
+			rte_ipv6_udptcp_cksum_mbuf(mbuf, l3_hdr, l4_offset);
+	} else if (l4_ol_flags == RTE_MBUF_F_TX_TCP_CKSUM &&
+		   likely(mbuf_len >= l4_offset + sizeof(struct rte_tcp_hdr))) {
+		struct rte_tcp_hdr *tcp_hdr =
+			rte_pktmbuf_mtod_offset(mbuf, struct rte_tcp_hdr *, l4_offset);
+		tcp_hdr->cksum = 0;
+		tcp_hdr->cksum = (ol_flags & RTE_MBUF_F_TX_IPV4) ?
+			rte_ipv4_udptcp_cksum_mbuf(mbuf, l3_hdr, l4_offset) :
+			rte_ipv6_udptcp_cksum_mbuf(mbuf, l3_hdr, l4_offset);
+	}
+}
+
 static uint16_t
 eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
@@ -246,10 +294,12 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	uint32_t num_tx_bytes = 0;
 	uint16_t i;
 
-	memset(&pfd, 0, sizeof(pfd));
-	pfd.fd = pkt_q->sockfd;
-	pfd.events = POLLOUT;
-	pfd.revents = 0;
+	if (pkt_q->txpollnotrdy) {
+		memset(&pfd, 0, sizeof(pfd));
+		pfd.fd = pkt_q->sockfd;
+		pfd.events = POLLOUT;
+		pfd.revents = 0;
+	}
 
 	framecount = pkt_q->framecount;
 	framenum = pkt_q->framenum;
@@ -290,7 +340,8 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		 */
 		if (unlikely(!tx_ring_status_available(rte_atomic_load_explicit(&ppd->tp_status,
 				rte_memory_order_acquire)) &&
-			(poll(&pfd, 1, -1) < 0 || (pfd.revents & POLLERR) != 0 ||
+			(!pkt_q->txpollnotrdy || poll(&pfd, 1, -1) < 0 ||
+			 (pfd.revents & POLLERR) != 0 ||
 			 !tx_ring_status_available(rte_atomic_load_explicit(&ppd->tp_status,
 					 rte_memory_order_acquire))))) {
 			/* Ring is full, stop here. Don't process bufs[i]. */
@@ -302,6 +353,9 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		ppd->tp_len = mbuf->pkt_len;
 		ppd->tp_snaplen = mbuf->pkt_len;
 
+		if (pkt_q->sw_cksum)
+			af_packet_sw_cksum(mbuf);
+
 		struct rte_mbuf *tmp_mbuf = mbuf;
 		do {
 			uint16_t data_len = rte_pktmbuf_data_len(tmp_mbuf);
@@ -387,10 +441,14 @@ eth_dev_configure(struct rte_eth_dev *dev __rte_unused)
 {
 	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
 	const struct rte_eth_rxmode *rxmode = &dev_conf->rxmode;
+	const struct rte_eth_txmode *txmode = &dev_conf->txmode;
 	struct pmd_internals *internals = dev->data->dev_private;
 
 	internals->vlan_strip = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP);
 	internals->timestamp_offloading = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP);
+	internals->tx_sw_cksum = !!(txmode->offloads & (RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
+			RTE_ETH_TX_OFFLOAD_UDP_CKSUM | RTE_ETH_TX_OFFLOAD_TCP_CKSUM));
+
 	return 0;
 }
 
@@ -408,7 +466,10 @@ eth_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
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
 
@@ -634,6 +695,7 @@ eth_tx_queue_setup(struct rte_eth_dev *dev,
 {
 
 	struct pmd_internals *internals = dev->data->dev_private;
+	internals->tx_queue[tx_queue_id].sw_cksum = internals->tx_sw_cksum;
 
 	dev->data->tx_queues[tx_queue_id] = &internals->tx_queue[tx_queue_id];
 	return 0;
@@ -829,6 +891,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
                        unsigned int framecnt,
 		       unsigned int qdisc_bypass,
 		       const char *fanout_mode,
+		       bool txpollnotrdy,
                        struct pmd_internals **internals,
                        struct rte_eth_dev **eth_dev,
                        struct rte_kvargs *kvlist)
@@ -1049,6 +1112,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 			tx_queue->rd[i].iov_len = req->tp_frame_size;
 		}
 		tx_queue->sockfd = qsockfd;
+		tx_queue->txpollnotrdy = txpollnotrdy;
 
 		rc = bind(qsockfd, (const struct sockaddr*)&sockaddr, sizeof(sockaddr));
 		if (rc == -1) {
@@ -1137,6 +1201,7 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 	unsigned int qpairs = 1;
 	unsigned int qdisc_bypass = 1;
 	const char *fanout_mode = NULL;
+	bool txpollnotrdy = DFLT_TX_POLL_NOT_RDY;
 
 	/* do some parameter checking */
 	if (*sockfd < 0)
@@ -1204,6 +1269,10 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 			fanout_mode = pair->value;
 			continue;
 		}
+		if (strstr(pair->key, ETH_AF_PACKET_TX_POLL_NOT_READY_ARG) != NULL) {
+			txpollnotrdy = atoi(pair->value) != 0;
+			continue;
+		}
 	}
 
 	if (framesize > blocksize) {
@@ -1278,6 +1347,7 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 				   framesize, framecount,
 				   qdisc_bypass,
 				   fanout_mode,
+				   txpollnotrdy,
 				   &internals, &eth_dev,
 				   kvlist) < 0)
 		return -1;
-- 
2.39.5 (Apple Git-154)

