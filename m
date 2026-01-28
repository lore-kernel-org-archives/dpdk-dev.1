Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BD3D46BF4
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 19:12:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7CA3406B7;
	Wed, 28 Jan 2026 20:12:27 +0100 (CET)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id 2EA3240673
 for <dev@dpdk.org>; Wed, 28 Jan 2026 20:12:25 +0100 (CET)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2b7070acfdcso282367eec.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 11:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769627544; x=1770232344; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ajmt3QNZoMVbWir9GX/pimIOr2pIiHyePGWXaqd1zcM=;
 b=SY4gGk05Ex2asXwY8c42n89PrfvFHUl2AR+YnsQtWKWEAAxNZIB/bU9XXyBeqYxPdZ
 NuAW5pWWwFldSf2WnfH/MCSNdFL+ntpkD8mgHi6y6xOxi57PiLjDWioSTEgaMn8Y399+
 pnZLrcDfirr1jgvqYwDyyNJsbI5dkQGQvERX4qj0Xm3lgACp5w27VQczcBsAVtYfuvhf
 L8W6WAk0LhlD5kV2FLl133/KV+CrHjMCaIbngS+9n6xl7lGz5UGehB4B85dq57qImb9K
 Xiu4+6ajGl1gSPwyJnJsVqbbjMpPmsxsCFUPQi1eXsoCREhm0qLdef7j0QSkKudk/b6Y
 4OYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769627544; x=1770232344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ajmt3QNZoMVbWir9GX/pimIOr2pIiHyePGWXaqd1zcM=;
 b=soTy7tC/PDShhrA4dXMrliuhy/xee3tp0OkqDNvhgeJPcIQDljxgxeRjEmP7YPEkMF
 5OX3rqcn34zqCDP1tReoUjjr931kNrnCvPhE72D4MCF9BQ9Rqx+adLqxa1JqmxBi++82
 LVD7RNi1D65OVmGEWbiXWvjoQzrswCbi1I5BKYEKfGGWqIPrGqX2zR0tSVawSQCon1rS
 7GX6Q2Hvpwqyc7Z8/oIhlgII0nS5gOT9VgGRQqpWxgCmezGiXc2pywU0NVFV91kRjIYx
 EdzNWlhI5U4FY4ivetURGVg1YhCBxcgQl2cDSBQqLewMxGFBiGGvKZQHTbfIJgrn0zdq
 5q4A==
X-Gm-Message-State: AOJu0Yz9Nnk6Dkcz/00waGJjEx63Hd/+Gxb6WngkU/xYosxXpfxJ86Uk
 aqqfAPd16cmna7DjhYhzMcI3zFeXTGo6E7a5tCcNnBII4dr9E/VTuugpAf06Yg==
X-Gm-Gg: AZuq6aJCEIeZkxXJWq1m0GSNbDXIxUzNUZaw588NBkrVo53/2vQycL5rXM8l39UApWi
 5jxtdKSDxHdi29mGA85ZRB13afHPXsEhl69yH3bkEaVYXkjZR+W7P8gsQiQbteTlb77ty5bxEMK
 pxHctVI651a8qM1E6TtT9eSkXobVZSefYz6pqsQA6NKqLqe+0/49jIj+LE2x0BAfN9WYIts7BJB
 TSGDbK0w7uUC6PYxBS/NOAwXuJapo2O1xjYGbMVGj0WMWQjGzmTuzV60cND1R1FaFLQWIy2IS1g
 Hudy8edVw76Js3o5+9p/v5rhkkNSCnD/Xn2yxRP2zu9iiB0wkPAGyhTd4vQMLYMeqN5C68H3Yv4
 7s2va+XHr36Ta4zbVCgnh537valy9ntuMRfma5D9QVwjNfTf4Ln3I/2GQEo52Gx5bBtJHV+cYhT
 s2VN1ahTEeV3T763nJYt6B/Lg3QBaopUvxxA4BiH81q9RVLe9A/A==
X-Received: by 2002:a05:7301:6786:b0:2b7:2dbb:eb4a with SMTP id
 5a478bee46e88-2b78da34d0amr3999741eec.31.1769627543834; 
 Wed, 28 Jan 2026 11:12:23 -0800 (PST)
Received: from mr41p01nt-relayp04.apple.com ([17.199.85.102])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b7a1adc5ecsm4261286eec.24.2026.01.28.11.12.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jan 2026 11:12:23 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v3 2/4] net/af_packet: RX/TX unlikely, bulk free, prefetch
Date: Wed, 28 Jan 2026 11:10:30 -0800
Message-Id: <20260128191032.78916-3-scott.k.mitch1@gmail.com>
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

