Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB15D35697
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 09:36:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A5114060A;
	Wed, 28 Jan 2026 10:36:22 +0100 (CET)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 7ABE2402D3
 for <dev@dpdk.org>; Wed, 28 Jan 2026 10:36:18 +0100 (CET)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2b785801c93so5866415eec.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 01:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769592977; x=1770197777; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ajmt3QNZoMVbWir9GX/pimIOr2pIiHyePGWXaqd1zcM=;
 b=XUQ1Un70VrFc8gqR5VPtKMZKK3jCmo5CxCgm8RSgjR/PLIpqx+25IimyTA0uJm6xB9
 hX+8rafI9tv322a1p5WF0KtOP6ZAmbpLdcnDD4FiMp6bTSmif4GxqIEHnyO7MCs0Fd1x
 +ecfuLuJGxvT0aGx+4s81VCfvlGo8M2tSIrhzkJHkxEkIAVYFK6siT0iBKa331p22zRk
 YpjpYop4E3B2h61bwzjyd6Vj4vhT3yMP4syOvlGFv5QmHXRrwbfHEqiD8o916Ck0h+od
 5PqfqpdXkHhnTuktScuT9Sd5uyYdc4iU6KKtbAZwf4KL5Iar2B8BXopsYw4BdC/k5R5k
 qDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769592977; x=1770197777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ajmt3QNZoMVbWir9GX/pimIOr2pIiHyePGWXaqd1zcM=;
 b=p/JlzgeatpZ9PCdvljStXQWaXbxULhrF0mF4tfKrfGo4st5oL4PlFlufm2yki4fnv5
 VDXMvpv5aQTqkW1TODSJ9mV0fvSyBHHAMWphTuTqXyyZWpNtkL9Moel59iHum3NuzK5I
 PkCI/C6cN1IB3NP58GSAeyjC0EVluKqPkxfK21yG417iF6lD+M3MinzsRcB1BUtcKjxv
 OB9Yi006l1OsDqwOp+zRdGYGw0bayd25A8HrbpktJQzTDu7j5O0L6Rx9vzgjgi2F0OUM
 ndChP9gHnWP8U+5i5Bd3B0LtZ5iRFeIWQaIpoE3Y9ZZKl5DEB4wyJrJbwv/wXKKOHLJf
 O0bA==
X-Gm-Message-State: AOJu0YxgqH+IZHfv9yWVPXpJ3hrb+c3L5BXZ6652DCGNU4Fq6p3IaXb8
 mzVcr0tx11qXCcodEzfkpNKargwHfJlGp/9u94fYBZTstlQa4ZzPMSOWsky5mQ==
X-Gm-Gg: AZuq6aJr0CAXGT2svTOqX5ggqYlLJXE3OKeB/VDcFmcScx5oUPspDkuQnF2r8PaG6cN
 DjhPj49zmGW7uRXj/lK6R24FXe4YTrAT+iaKfxwIi+qY5GCfowjuMMjIufLLuii7SkG8TmPU92o
 wNVCVP1bU13LTMVy898rPYOGrNz9ykHbZOQcONO5i1MPWX1CvSi/W9uO/bR2bO8wtQxyz6M0Jmq
 yhv+tvYqnmYwuoC2B4/oSR027anOq+QFIswtpcO3ll368Pms4EoiYPXzsfSqbbOkQBQupYgKUFu
 zCbdLPYlvnWFjm6Sit0rLNi8pgzpnTd6fTBVCT4b8aHPYSrxuOERulAI4d+60xXN7daE7s2FWnB
 wmNESnYpR7juPJJSDAWS8yrfNAd8n8Hw1EfTt3St1B5e2B0EUaq1pDEGtYXT508uJynWusMRdGS
 4J+o6mtWZKhjkgU7wFDYbk9g==
X-Received: by 2002:a05:7300:f10a:b0:2b7:23ba:af2e with SMTP id
 5a478bee46e88-2b78da4dc5bmr3015977eec.43.1769592977342; 
 Wed, 28 Jan 2026 01:36:17 -0800 (PST)
Received: from mac.com ([136.24.82.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b7a14bb02csm1834864eec.0.2026.01.28.01.36.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jan 2026 01:36:17 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v2 2/4] net/af_packet: RX/TX unlikely, bulk free, prefetch
Date: Wed, 28 Jan 2026 01:36:05 -0800
Message-Id: <20260128093607.62908-3-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260128093607.62908-1-scott.k.mitch1@gmail.com>
References: <20260127181355.98437-1-scott.k.mitch1@gmail.com>
 <20260128093607.62908-1-scott.k.mitch1@gmail.com>
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
- Use rte_pktmbuf_free_bulk() in TX path instead of individual
  rte_pktmbuf_free() calls for better batch efficiency
- Add unlikely() hints for error paths (oversized packets, VLAN
  insertion failures, sendto errors) to optimize branch prediction
- Remove unnecessary early nb_pkts == 0 when loop handles this
  and app may never call with 0 frames.

Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 65 ++++++++++++-----------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index 6c276bb7fc..e357ae168b 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -161,9 +161,6 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	uint32_t tp_status;
 	unsigned int framecount, framenum;
 
-	if (unlikely(nb_pkts == 0))
-		return 0;
-
 	/*
 	 * Reads the given number of packets from the AF_PACKET socket one by
 	 * one and copies the packet data into a newly allocated mbuf.
@@ -177,6 +174,14 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
@@ -210,8 +215,7 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 		/* release incoming frame and advance ring buffer */
 		tpacket_write_status(&ppd->tp_status, TP_STATUS_KERNEL);
-		if (++framenum >= framecount)
-			framenum = 0;
+		framenum = next_framenum;
 		mbuf->port = pkt_q->in_port;
 
 		/* account for the receive frame */
@@ -261,9 +265,6 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	uint32_t num_tx_bytes = 0;
 	uint16_t i;
 
-	if (unlikely(nb_pkts == 0))
-		return 0;
-
 	memset(&pfd, 0, sizeof(pfd));
 	pfd.fd = pkt_q->sockfd;
 	pfd.events = POLLOUT;
@@ -271,22 +272,25 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
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
@@ -312,6 +316,9 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 		pbuf = (uint8_t *)ppd + ETH_AF_PACKET_FRAME_OVERHEAD;
 
+		ppd->tp_len = mbuf->pkt_len;
+		ppd->tp_snaplen = mbuf->pkt_len;
+
 		struct rte_mbuf *tmp_mbuf = mbuf;
 		do {
 			uint16_t data_len = rte_pktmbuf_data_len(tmp_mbuf);
@@ -320,23 +327,19 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			tmp_mbuf = tmp_mbuf->next;
 		} while (tmp_mbuf);
 
-		ppd->tp_len = mbuf->pkt_len;
-		ppd->tp_snaplen = mbuf->pkt_len;
-
 		/* release incoming frame and advance ring buffer */
 		tpacket_write_status(&ppd->tp_status, TP_STATUS_SEND_REQUEST);
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

