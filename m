Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE56FD46BE2
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 17:32:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5184540659;
	Wed, 28 Jan 2026 18:31:51 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id EEAD540664
 for <dev@dpdk.org>; Wed, 28 Jan 2026 18:31:49 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so7850305e9.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 09:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769621509;
 x=1770226309; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wuTEbuPWLS1RMMuBJ1vCPAortOkBgYikFJBnx/TXHBA=;
 b=PfMkVyw26KUTJV+IbIJvn5qItsBoPQDzqWKCeGhB1ZrFvlpSHA+bzKXoPC1UIS3v3V
 2D60Ok6rj8QwLiEcxbEnXdTkMhJ4CdnWQeL8jLD/VUOb29aCi1Vy9JZaaETTfqC0bPn4
 /HIFNmR4YbyW8lAEKOfuA+F3ZjQkQ/QObYkZ69AEdfDGNOlg94lOkcirijjlYGGwPiYR
 Lex+05yLMlh9ekglBlTu5Si7Wcg5mRoIYvaJecMwVOGgevwFCvps1P/IyIphRBAQi19V
 uRUTOWtOszVPQ+dgvV75imXZhTslMNPa/N+WXPcVvhcSbhTzy+QN+Qa6u/L3FcawqiWK
 4r/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769621509; x=1770226309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wuTEbuPWLS1RMMuBJ1vCPAortOkBgYikFJBnx/TXHBA=;
 b=Wl64scSpPa4Rk63NDzaXFxX2a7ZDHRJBw9tOXn0K4w+RfQZCq9chAyeeP/rFX4TFwd
 TNJ+C07PGvN8otvV/cvN4vryLtiN1rhJw+QkSgdsiG32xqwB207BDWz4iSisZ1A+ViMQ
 2yhBfIZIEubq+MB7ZN7TU57nc5/K6iZedYB4SABO13UMv2CtwZ0do90o3HN+tQAMPQRu
 EfhIK5Rxu2wa76IpbyeQMQwhFiRaZ7B2XoDxaxiadlyTYjM6lOs5iXNNO6QpPm/Xe6c+
 8pv46ZsSCSTmNcMlatHBPa0FXLUepQPhZNKej2GFB5Vf0aDLYVIk+mLEwFIYFmqwfNv9
 QNyw==
X-Gm-Message-State: AOJu0YyPRaFzso+t6LwwqLd/hBw2Qv01u/QAQVLMjixycHE2vCSHdeBb
 CzkpS3wfjwb5jPGerctnUeAf65GKf+tA+OrszDn8mRJUugUCxONHtmJN30yfQTme1POTXWZ6qsc
 mXxFT
X-Gm-Gg: AZuq6aLPmZHSJIf/Kb6roOd+hby14rqSm1vICBBeM4QGGE2cOPtadtX+U23Psv8EY3P
 h2RDnBnfpyhU+AxPIVzGEnGPJr0rGnAfDz/j+8+3YLFCt4YT9xXL5+xwq1caT3U3JCDvjkMoUn3
 xUkiJnPWqmGCzZcdwUHk85434RLntRNsuySnd5cZu322m7VdZH3ba7w0KWICKsAOuh+efVMop+4
 i7xDoPk6sDPnABBtrW7sarjXwQ1RuHaFYTowcLyxlEFH3htBqla8xd/TOPXpC9dB5yEtqVSxNob
 a8U2ZsKG9nuCK60ZuwKrIDIY2WV2on1Z7lNtHgVxwrmtIFlPDke+NDfvq7iIoAPliu+aJqKxDL5
 6Y2iymkO1x81+V42MLDaaCC9RVsFpxwn9BfcUjAKLD1thcsanXw3hlG8I+at8hEqSzDg33Z2uN+
 9mX4TS/DK2KoNi9qBf6tFuvOYqbK9/gnWTkGbBb86Pe+gkmT/lbF+evF+G8Uss
X-Received: by 2002:a05:600c:a10b:b0:47d:52ef:c572 with SMTP id
 5b1f17b1804b1-480828745e6mr2744635e9.1.1769621509476; 
 Wed, 28 Jan 2026 09:31:49 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066bfb59asm133732875e9.7.2026.01.28.09.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 09:31:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 "John W. Linville" <linville@tuxdriver.com>
Subject: [RFC 4/4] net/af_packet: add VPP-style prefetching to receive path
Date: Wed, 28 Jan 2026 09:30:20 -0800
Message-ID: <20260128173138.151837-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128173138.151837-1-stephen@networkplumber.org>
References: <20260128173138.151837-1-stephen@networkplumber.org>
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

Implement the single/dual/quad loop design pattern from FD.IO VPP to
improve cache efficiency in the af_packet PMD receive path.

The original implementation processes packets one at a time in a simple
loop, which can result in cache misses when accessing frame headers and
packet data. The new implementation:

- Processes packets in batches of 4 (quad), 2 (dual), and 1 (single)
- Prefetches next batch of frame headers while processing current batch
- Prefetches packet data before memcpy to hide memory latency
- Reduces loop overhead through partial unrolling

Two helper functions are introduced:
- af_packet_get_frame(): Returns frame pointer at index with wraparound
- af_packet_rx_one(): Common per-packet processing (mbuf alloc, memcpy,
  VLAN handling, timestamp offload)

The quad loop checks availability of all 4 frames before processing,
falling through to dual/single loops when fewer frames are ready. Early
exit paths (out_advance1/2/3) ensure correct frame index tracking when
mbuf allocation fails mid-batch.

Prefetch strategy:
- Frame headers: prefetch N+4..N+7 while processing N..N+3
- Packet data: prefetch at tp_mac offset before memcpy

This pattern is well-established in high-performance packet processing
and should improve throughput by better utilizing CPU cache hierarchy,
particularly beneficial when processing bursts of packets.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 208 +++++++++++++++++-----
 1 file changed, 164 insertions(+), 44 deletions(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index 5847e14d80..946c21d878 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -14,6 +14,7 @@
 #include <rte_malloc.h>
 #include <rte_kvargs.h>
 #include <bus_vdev_driver.h>
+#include <rte_prefetch.h>
 
 #include <errno.h>
 #include <linux/if_ether.h>
@@ -120,75 +121,194 @@ RTE_LOG_REGISTER_DEFAULT(af_packet_logtype, NOTICE);
 	RTE_LOG_LINE(level, AFPACKET, "%s(): " fmt ":%s", __func__, \
 		## __VA_ARGS__, strerror(errno))
 
-static uint16_t
-eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
+/*
+ * Helper to get the frame pointer at a given index with wraparound
+ */
+static inline struct tpacket2_hdr *
+af_packet_get_frame(struct pkt_rx_queue *pkt_q, unsigned int idx)
+{
+	if (idx >= pkt_q->framecount)
+		idx -= pkt_q->framecount;
+	return (struct tpacket2_hdr *)pkt_q->rd[idx].iov_base;
+}
+
+/*
+ * Process a single received packet - common code for all loop variants
+ */
+static inline int
+af_packet_rx_one(struct pkt_rx_queue *pkt_q,
+		 struct tpacket2_hdr *ppd,
+		 struct rte_mbuf **mbuf_out,
+		 unsigned long *rx_bytes)
 {
-	unsigned i;
-	struct tpacket2_hdr *ppd;
 	struct rte_mbuf *mbuf;
 	uint8_t *pbuf;
+
+	mbuf = rte_pktmbuf_alloc(pkt_q->mb_pool);
+	if (unlikely(mbuf == NULL)) {
+		pkt_q->rx_nombuf++;
+		return -1;
+	}
+
+	rte_pktmbuf_pkt_len(mbuf) = rte_pktmbuf_data_len(mbuf) = ppd->tp_snaplen;
+	pbuf = (uint8_t *)ppd + ppd->tp_mac;
+	memcpy(rte_pktmbuf_mtod(mbuf, void *), pbuf, rte_pktmbuf_data_len(mbuf));
+
+	if (ppd->tp_status & TP_STATUS_VLAN_VALID) {
+		mbuf->vlan_tci = ppd->tp_vlan_tci;
+		mbuf->ol_flags |= (RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED);
+		if (!pkt_q->vlan_strip && rte_vlan_insert(&mbuf))
+			PMD_LOG(ERR, "Failed to reinsert VLAN tag");
+	}
+
+	if (pkt_q->timestamp_offloading) {
+		*RTE_MBUF_DYNFIELD(mbuf, timestamp_dynfield_offset,
+			rte_mbuf_timestamp_t *) =
+				(uint64_t)ppd->tp_sec * 1000000000 + ppd->tp_nsec;
+		mbuf->ol_flags |= timestamp_dynflag;
+	}
+
+	mbuf->port = pkt_q->in_port;
+	*mbuf_out = mbuf;
+	*rx_bytes += mbuf->pkt_len;
+	ppd->tp_status = TP_STATUS_KERNEL;
+
+	return 0;
+}
+
+/*
+ * Receive packets using VPP-style single/dual/quad loop pattern with prefetching.
+ */
+static uint16_t
+eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
+{
 	struct pkt_rx_queue *pkt_q = queue;
+	struct tpacket2_hdr *ppd0, *ppd1, *ppd2, *ppd3;
 	uint16_t num_rx = 0;
 	unsigned long num_rx_bytes = 0;
 	unsigned int framecount, framenum;
+	uint16_t n_left;
 
 	if (unlikely(nb_pkts == 0))
 		return 0;
 
-	/*
-	 * Reads the given number of packets from the AF_PACKET socket one by
-	 * one and copies the packet data into a newly allocated mbuf.
-	 */
 	framecount = pkt_q->framecount;
 	framenum = pkt_q->framenum;
-	for (i = 0; i < nb_pkts; i++) {
-		/* point at the next incoming frame */
-		ppd = (struct tpacket2_hdr *) pkt_q->rd[framenum].iov_base;
-		if ((ppd->tp_status & TP_STATUS_USER) == 0)
+	n_left = nb_pkts;
+
+	/* Quad loop: Process 4 packets at a time with prefetching */
+	while (n_left >= 4) {
+		ppd0 = af_packet_get_frame(pkt_q, framenum);
+		ppd1 = af_packet_get_frame(pkt_q, framenum + 1);
+		ppd2 = af_packet_get_frame(pkt_q, framenum + 2);
+		ppd3 = af_packet_get_frame(pkt_q, framenum + 3);
+
+		if ((ppd0->tp_status & TP_STATUS_USER) == 0)
 			break;
+		if ((ppd1->tp_status & TP_STATUS_USER) == 0)
+			goto dual_loop;
+		if ((ppd2->tp_status & TP_STATUS_USER) == 0)
+			goto dual_loop;
+		if ((ppd3->tp_status & TP_STATUS_USER) == 0)
+			goto dual_loop;
+
+		/* Prefetch next 4 frame headers */
+		rte_prefetch0(af_packet_get_frame(pkt_q, framenum + 4));
+		rte_prefetch0(af_packet_get_frame(pkt_q, framenum + 5));
+		rte_prefetch0(af_packet_get_frame(pkt_q, framenum + 6));
+		rte_prefetch0(af_packet_get_frame(pkt_q, framenum + 7));
+
+		/* Prefetch packet data */
+		rte_prefetch0((uint8_t *)ppd0 + ppd0->tp_mac);
+		rte_prefetch0((uint8_t *)ppd1 + ppd1->tp_mac);
+		rte_prefetch0((uint8_t *)ppd2 + ppd2->tp_mac);
+		rte_prefetch0((uint8_t *)ppd3 + ppd3->tp_mac);
+
+		if (unlikely(af_packet_rx_one(pkt_q, ppd0, &bufs[num_rx], &num_rx_bytes) < 0))
+			goto out;
+		num_rx++;
+		if (unlikely(af_packet_rx_one(pkt_q, ppd1, &bufs[num_rx], &num_rx_bytes) < 0))
+			goto out_advance1;
+		num_rx++;
+		if (unlikely(af_packet_rx_one(pkt_q, ppd2, &bufs[num_rx], &num_rx_bytes) < 0))
+			goto out_advance2;
+		num_rx++;
+		if (unlikely(af_packet_rx_one(pkt_q, ppd3, &bufs[num_rx], &num_rx_bytes) < 0))
+			goto out_advance3;
+		num_rx++;
 
-		/* allocate the next mbuf */
-		mbuf = rte_pktmbuf_alloc(pkt_q->mb_pool);
-		if (unlikely(mbuf == NULL)) {
-			pkt_q->rx_nombuf++;
+		framenum += 4;
+		if (framenum >= framecount)
+			framenum -= framecount;
+		n_left -= 4;
+	}
+
+dual_loop:
+	/* Dual loop: Process 2 packets at a time */
+	while (n_left >= 2) {
+		ppd0 = af_packet_get_frame(pkt_q, framenum);
+		ppd1 = af_packet_get_frame(pkt_q, framenum + 1);
+
+		if ((ppd0->tp_status & TP_STATUS_USER) == 0)
 			break;
-		}
+		if ((ppd1->tp_status & TP_STATUS_USER) == 0)
+			goto single_loop;
 
-		/* packet will fit in the mbuf, go ahead and receive it */
-		rte_pktmbuf_pkt_len(mbuf) = rte_pktmbuf_data_len(mbuf) = ppd->tp_snaplen;
-		pbuf = (uint8_t *) ppd + ppd->tp_mac;
-		memcpy(rte_pktmbuf_mtod(mbuf, void *), pbuf, rte_pktmbuf_data_len(mbuf));
+		rte_prefetch0(af_packet_get_frame(pkt_q, framenum + 2));
+		rte_prefetch0(af_packet_get_frame(pkt_q, framenum + 3));
+		rte_prefetch0((uint8_t *)ppd0 + ppd0->tp_mac);
+		rte_prefetch0((uint8_t *)ppd1 + ppd1->tp_mac);
 
-		/* check for vlan info */
-		if (ppd->tp_status & TP_STATUS_VLAN_VALID) {
-			mbuf->vlan_tci = ppd->tp_vlan_tci;
-			mbuf->ol_flags |= (RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED);
+		if (unlikely(af_packet_rx_one(pkt_q, ppd0, &bufs[num_rx], &num_rx_bytes) < 0))
+			goto out;
+		num_rx++;
+		if (unlikely(af_packet_rx_one(pkt_q, ppd1, &bufs[num_rx], &num_rx_bytes) < 0))
+			goto out_advance1;
+		num_rx++;
 
-			if (!pkt_q->vlan_strip && rte_vlan_insert(&mbuf))
-				PMD_LOG(ERR, "Failed to reinsert VLAN tag");
-		}
+		framenum += 2;
+		if (framenum >= framecount)
+			framenum -= framecount;
+		n_left -= 2;
+	}
 
-		/* add kernel provided timestamp when offloading is enabled */
-		if (pkt_q->timestamp_offloading) {
-			/* since TPACKET_V2 timestamps are provided in nanoseconds resolution */
-			*RTE_MBUF_DYNFIELD(mbuf, timestamp_dynfield_offset,
-				rte_mbuf_timestamp_t *) =
-					(uint64_t)ppd->tp_sec * 1000000000 + ppd->tp_nsec;
+single_loop:
+	/* Single loop: Process remaining packets */
+	while (n_left >= 1) {
+		ppd0 = af_packet_get_frame(pkt_q, framenum);
 
-			mbuf->ol_flags |= timestamp_dynflag;
-		}
+		if ((ppd0->tp_status & TP_STATUS_USER) == 0)
+			break;
 
-		/* release incoming frame and advance ring buffer */
-		ppd->tp_status = TP_STATUS_KERNEL;
-		if (++framenum >= framecount)
-			framenum = 0;
-		mbuf->port = pkt_q->in_port;
+		rte_prefetch0(af_packet_get_frame(pkt_q, framenum + 1));
+		rte_prefetch0((uint8_t *)ppd0 + ppd0->tp_mac);
 
-		/* account for the receive frame */
-		bufs[i] = mbuf;
+		if (unlikely(af_packet_rx_one(pkt_q, ppd0, &bufs[num_rx], &num_rx_bytes) < 0))
+			goto out;
 		num_rx++;
-		num_rx_bytes += mbuf->pkt_len;
+
+		if (++framenum >= framecount)
+			framenum = 0;
+		n_left--;
 	}
+
+	goto out;
+
+out_advance3:
+	framenum += 3;
+	if (framenum >= framecount)
+		framenum -= framecount;
+	goto out;
+out_advance2:
+	framenum += 2;
+	if (framenum >= framecount)
+		framenum -= framecount;
+	goto out;
+out_advance1:
+	framenum += 1;
+	if (framenum >= framecount)
+		framenum -= framecount;
+out:
 	pkt_q->framenum = framenum;
 	pkt_q->rx_pkts += num_rx;
 	pkt_q->rx_bytes += num_rx_bytes;
-- 
2.51.0

