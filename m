Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC83D2FED0
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 18:16:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71A7D40E50;
	Tue, 27 Jan 2026 19:16:46 +0100 (CET)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id 9172340E21
 for <dev@dpdk.org>; Tue, 27 Jan 2026 19:16:45 +0100 (CET)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-124a1b4dd40so299272c88.0
 for <dev@dpdk.org>; Tue, 27 Jan 2026 10:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769537804; x=1770142604; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQi7hNMlxl33iSVEaY0Q25MZm15E6nKR5x9kZ+NyHC0=;
 b=fWMJpG3n0Skb7wbJrZiHhGrD7xh3Ilsx6AsXXBUUgf7RzIpdlblrYoMK/dTG3zQnT/
 b2OFTRFt23K1bySgtJwGcusek0eSPoh/tclMqoenFrgwbaYhxXgLr18KhyjafQed0+MH
 8BfNddHg/hVorEQPptjVW2wrQUqUuGmrijZfSjS+aY/EjuuLQcY+RvQ+diMDVNeMkGz2
 qL3E1hhmIxDTTSpl2TsZS6S448v2yI3bmXm+yXRCQXFBmDDngU1Y0DQMRvDwhzyoC6kb
 7JzuitAb6jmSknV3M4oD0BEJqAhrx+7JgHSw7TTx7hCjuwZ0IlotcTbAkmM/JHTKc1eP
 2rIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769537804; x=1770142604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CQi7hNMlxl33iSVEaY0Q25MZm15E6nKR5x9kZ+NyHC0=;
 b=eYOe+ZFEY7qX3Fm/K/AXWwNhuhLrHZp6PMgAq/xKfslCYg1xYjRZGvS3c9FTP0hHgn
 9E+AjpCxRfLKSXlBodw6XzlM/IMixoyLQ+cNx27viPzQ/q7Bk4unnUznzuSrVe9HX277
 9ICflBFMX/JJp+rymuhsGUmHGB6fGB42BrddfJhOMRqK75db6oB2m/CaR79RmGI50a4b
 kTPCoznQqFf/RSg7jYH1GjTBBzhKeNqLwS9y+4TgxZU8eDPTf2bTNCbj/qrB31285/hv
 yPIs96Nwp4J5wmcY7HyHM0ljEhZmNv2H2sir5C6ctLXKuAASeo2IuWkJH9q61QOd7BNr
 oYqg==
X-Gm-Message-State: AOJu0Yx0/799S9qCN21NhusGQQE/zzQxLyHYuY2FHkao3VKBOLI9yGUU
 NqE1rYxKkp0927CGG3Dtw35gYBNPamWHs6PLi6ndt/dRBvkqaejEOTSmdUNTog==
X-Gm-Gg: AZuq6aK9Des6K0kvfUOj3gSdBrSstdpNysmui7ZoC4E2gGBK+GR1dA0G3TUuedjrHPx
 qieDNvT00VeNiJLWfqPVitPIzKjpoCwg0Z2o1pFe8Uy9lSjD8/2gQlq+JbJ6WEL14vJ4s8hRSdx
 5aT92q6Dwbv3CbzOzuAi1HkKJrEBfUkveZc4U2rfOA6ERts3X0Kv7ertAKsfQhAphFbVpXEPAot
 Q3fAFhSvsh8E7nzimTrFHkVzSK/B0MeiZVn325WmnAWlHw34vEkN7PQllPlvbNLd+aPTjE/zIz2
 Fe/FzoRzOePRY3RnyfdlU9+aKy0qY+6LjxHv3v/1MLuhEmyyGhf3ZLxUu1YrmziAdkkI+bbHiz2
 ALdCMk2fHSNWDxjPhAw9GYcSM8iNOvsb35HXKWKSD2xfpKzsOjIHvTWv5cfmGKakJTU/O+dzXE9
 MSGXoXcUak7AtlOl2JNxcqXaQyR5rgZ8d6tuxKqKXovGd5zzwnVg==
X-Received: by 2002:a05:7022:238c:b0:11b:7970:ea3f with SMTP id
 a92af1059eb24-124a00b1239mr1716689c88.25.1769537804244; 
 Tue, 27 Jan 2026 10:16:44 -0800 (PST)
Received: from mr41p01nt-relayp03.apple.com ([17.199.85.102])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-124a7bf8f5dsm483172c88.7.2026.01.27.10.16.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Jan 2026 10:16:43 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v1 2/3] net/af_packet: RX/TX rte_memcpy, bulk free, prefetch
Date: Tue, 27 Jan 2026 10:13:54 -0800
Message-Id: <20260127181355.98437-3-scott.k.mitch1@gmail.com>
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

- Add rte_prefetch0() to prefetch next frame/mbuf while processing
  current packet, reducing cache miss latency
- Replace memcpy() with rte_memcpy() for optimized copy operations
- Use rte_pktmbuf_free_bulk() in TX path instead of individual
  rte_pktmbuf_free() calls for better batch efficiency
- Add unlikely() hints for error paths (oversized packets, VLAN
  insertion failures, sendto errors) to optimize branch prediction
- Remove unnecessary early nb_pkts == 0 when loop handles this
  and app may never call with 0 frames.

Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 70 ++++++++++++-----------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index 2ee52a402b..2d152a2e2f 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -9,6 +9,7 @@
 #include <rte_common.h>
 #include <rte_string_fns.h>
 #include <rte_mbuf.h>
+#include <rte_memcpy.h>
 #include <rte_atomic.h>
 #include <rte_bitops.h>
 #include <ethdev_driver.h>
@@ -138,9 +139,6 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	uint32_t num_rx_bytes = 0;
 	unsigned int framecount, framenum;
 
-	if (unlikely(nb_pkts == 0))
-		return 0;
-
 	/*
 	 * Reads the given number of packets from the AF_PACKET socket one by
 	 * one and copies the packet data into a newly allocated mbuf.
@@ -155,6 +153,14 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		if ((tp_status & TP_STATUS_USER) == 0)
 			break;
 
+		unsigned int next_framenum = framenum + 1;
+		if (next_framenum >= framecount)
+			next_framenum = 0;
+
+		/* prefetch the next frame for the next loop iteration */
+		if (likely(i + 1 < nb_pkts))
+			rte_prefetch0(pkt_q->rd[next_framenum].iov_base);
+
 		/* allocate the next mbuf */
 		mbuf = rte_pktmbuf_alloc(pkt_q->mb_pool);
 		if (unlikely(mbuf == NULL)) {
@@ -166,7 +172,7 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		/* packet will fit in the mbuf, go ahead and receive it */
 		rte_pktmbuf_pkt_len(mbuf) = rte_pktmbuf_data_len(mbuf) = ppd->tp_snaplen;
 		pbuf = (uint8_t *) ppd + ppd->tp_mac;
-		memcpy(rte_pktmbuf_mtod(mbuf, void *), pbuf, rte_pktmbuf_data_len(mbuf));
+		rte_memcpy(rte_pktmbuf_mtod(mbuf, void *), pbuf, rte_pktmbuf_data_len(mbuf));
 
 		/* check for vlan info */
 		if (tp_status & TP_STATUS_VLAN_VALID) {
@@ -190,8 +196,7 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		/* release incoming frame and advance ring buffer */
 		rte_atomic_store_explicit(&ppd->tp_status, TP_STATUS_KERNEL,
 					rte_memory_order_release);
-		if (++framenum >= framecount)
-			framenum = 0;
+		framenum = next_framenum;
 		mbuf->port = pkt_q->in_port;
 
 		/* account for the receive frame */
@@ -241,9 +246,6 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	uint32_t num_tx_bytes = 0;
 	uint16_t i;
 
-	if (unlikely(nb_pkts == 0))
-		return 0;
-
 	memset(&pfd, 0, sizeof(pfd));
 	pfd.fd = pkt_q->sockfd;
 	pfd.events = POLLOUT;
@@ -251,22 +253,25 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 	framecount = pkt_q->framecount;
 	framenum = pkt_q->framenum;
-	ppd = (struct tpacket2_hdr *) pkt_q->rd[framenum].iov_base;
 	for (i = 0; i < nb_pkts; i++) {
-		mbuf = *bufs++;
-
-		/* drop oversized packets */
-		if (mbuf->pkt_len > pkt_q->frame_data_size) {
-			rte_pktmbuf_free(mbuf);
-			continue;
+		unsigned int next_framenum = framenum + 1;
+		if (next_framenum >= framecount)
+			next_framenum = 0;
+
+		/* prefetch the next source mbuf and destination TPACKET */
+		if (likely(i + 1 < nb_pkts)) {
+			rte_prefetch0(bufs[i + 1]);
+			rte_prefetch0(pkt_q->rd[next_framenum].iov_base);
 		}
 
-		/* insert vlan info if necessary */
-		if (mbuf->ol_flags & RTE_MBUF_F_TX_VLAN) {
-			if (rte_vlan_insert(&mbuf)) {
-				rte_pktmbuf_free(mbuf);
-				continue;
-			}
+		mbuf = bufs[i];
+		ppd = (struct tpacket2_hdr *)pkt_q->rd[framenum].iov_base;
+
+		/* Drop oversized packets. Insert VLAN if necessary */
+		if (unlikely(mbuf->pkt_len > pkt_q->frame_data_size ||
+			    ((mbuf->ol_flags & RTE_MBUF_F_TX_VLAN) != 0 &&
+			     rte_vlan_insert(&mbuf) != 0))) {
+			continue;
 		}
 
 		/*
@@ -294,32 +299,31 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 		pbuf = (uint8_t *)ppd + ETH_AF_PACKET_FRAME_OVERHEAD;
 
+		ppd->tp_len = mbuf->pkt_len;
+		ppd->tp_snaplen = mbuf->pkt_len;
+
 		struct rte_mbuf *tmp_mbuf = mbuf;
 		do {
 			uint16_t data_len = rte_pktmbuf_data_len(tmp_mbuf);
-			memcpy(pbuf, rte_pktmbuf_mtod(tmp_mbuf, void*), data_len);
+			rte_memcpy(pbuf, rte_pktmbuf_mtod(tmp_mbuf, void*), data_len);
 			pbuf += data_len;
 			tmp_mbuf = tmp_mbuf->next;
 		} while (tmp_mbuf);
 
-		ppd->tp_len = mbuf->pkt_len;
-		ppd->tp_snaplen = mbuf->pkt_len;
-
 		/* release incoming frame and advance ring buffer */
 		rte_atomic_store_explicit(&ppd->tp_status, TP_STATUS_SEND_REQUEST,
 					rte_memory_order_release);
-		if (++framenum >= framecount)
-			framenum = 0;
-		ppd = (struct tpacket2_hdr *) pkt_q->rd[framenum].iov_base;
-
+		framenum = next_framenum;
 		num_tx++;
 		num_tx_bytes += mbuf->pkt_len;
-		rte_pktmbuf_free(mbuf);
 	}
 
+	rte_pktmbuf_free_bulk(&bufs[0], i);
+
 	/* kick-off transmits */
-	if (sendto(pkt_q->sockfd, NULL, 0, MSG_DONTWAIT, NULL, 0) == -1 &&
-			errno != ENOBUFS && errno != EAGAIN) {
+	if (unlikely(num_tx > 0 &&
+		     sendto(pkt_q->sockfd, NULL, 0, MSG_DONTWAIT, NULL, 0) == -1 &&
+		     errno != ENOBUFS && errno != EAGAIN)) {
 		/*
 		 * In case of a ENOBUFS/EAGAIN error all of the enqueued
 		 * packets will be considered successful even though only some
-- 
2.39.5 (Apple Git-154)

