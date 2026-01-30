Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EB6E6BF31
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 17:35:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 048584067C;
	Fri, 30 Jan 2026 18:35:23 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 2104E40658
 for <dev@dpdk.org>; Fri, 30 Jan 2026 18:35:10 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4806f9e61f9so12640085e9.1
 for <dev@dpdk.org>; Fri, 30 Jan 2026 09:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769794510;
 x=1770399310; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4AKeZ5n9aHSLOPZJ7HNvITCDpuWc36TR960rnhrMnXA=;
 b=nymaMGqXXgv4OjzSA8Ivx3gMdZNeYrSQ6FRHhWRcaKyhItHbuQBcA6j4QI6ghYAdBH
 FfWorZ6PchbfHDOah4YfH8Q37NvpwTvWP1K+o2PVjOH+O0O+HW1I+qJubDdy8bUL1U9a
 LqoLTguaAAbqLBzDXdQs961z/JBEppp3ZtkVtWTH8Ae6vtwNEyn8N4DNpyHYP6CzXi2o
 AQnmde6GA4Q2yUV+B3XM2K5zS+TsIlDtzAmJLQGmGHeFzaPkK+gDlOOQBRWcPaHmDARK
 6/Lqok+pDYRu1zWgUdinHG4Ms4/sMa1Dcxgls77Z3JHsji12e5nmzazP6jQ/gCuBSGX5
 7LOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769794510; x=1770399310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4AKeZ5n9aHSLOPZJ7HNvITCDpuWc36TR960rnhrMnXA=;
 b=DdjI8bRshSHadGNHa6OE2UX+2MziS2fpQnhTQBaXFkiBjkbKQ9wSbUuXYq9ePLv161
 T4vfCeXa0CM0HsHoJ7jpLoOGOhhEWuAZVDytPhLPtKul/Y2MPObpTeTqnTnwH6QVZWoI
 WbsGIkqi9yGsIP4vd0ruxoXhVAElW7MqYkJqJPgUL6gGP/KqvUIS/0VIyLOBZ1xS+k68
 fnhjFUg29QFZ3dflTxtXuvnqIJP3XCRptoYKNG7ZQUJTwjT0killxzZMRieRRbr68e4G
 0+wM/S/ASr70Di8KMcp6ebpezCEBZJguYiR+bN8yXFV4E8BLNO6YFOFHexBsqME+1rrR
 Prsg==
X-Gm-Message-State: AOJu0YwQgblqk+s/Kjn1p90IpTZTHGTRGDTOW0ZZ62ERFdAeFclYnSyZ
 6Ct5GV2QHRe2NUQmRWu4nLR8ZhcMHtm+QDDmK4RN3K23vPMluElhitEKBOUorM/L0Z+UAflInUp
 cDV0X
X-Gm-Gg: AZuq6aL7noicB0xhTCZuO3YAy3bh4bb2a2vsJRv5/eVFR4zZBtdKi+gdNGwV7y6X05i
 1GjB9t2QftZRGR5QBc+p2oe2dNR4i9RWpBKP8hZpRgv9KidOL+fn7zMRsO/q65Cx2B6ODNCos2a
 Kd6oJoOmhMOzcjsJJaKqsCtYep9wVUDDSxhfEpWJH0csExztVOkxHpg3JsKoACpndiPXaakWA5c
 matTN9XfAMmj7tA5NwtluJBzr+3TrKLmt9QUwWK6NpoLFx83W5ujQXFyQF5xeqt6HFEK8hmD67r
 DVd4zeZ9633aZDVSN7bciU2hB+vlEh3Vbf8LRlM+MTRkKIUlg+PWal1RSk4QnEnSBZYWW3t5lSU
 m3vJt67IJ0bWiYGf/YUcrVif0l98zVsl0SG4FPdsqh2GCg7Hmp8TA6BFbtIW8MPTY5b5EjaGTql
 Pk9KsannbvF0VwzqFmGYcEwiHsK6KuF5L89PDSH7ByBrUBXSHbC5EEglGtf2ks
X-Received: by 2002:a05:600c:1d23:b0:45d:d97c:236c with SMTP id
 5b1f17b1804b1-482db47d46dmr48223805e9.21.1769794509689; 
 Fri, 30 Jan 2026 09:35:09 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm201085325e9.12.2026.01.30.09.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 09:35:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v11 08/19] net/pcap: cleanup transmit buffer handling
Date: Fri, 30 Jan 2026 09:33:21 -0800
Message-ID: <20260130173447.14546-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130173447.14546-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130173447.14546-1-stephen@networkplumber.org>
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

The transmit loops should handle the possible failure
of rte_pktmbuf_read(). If a pcap_sendpacket fails, then
the packet with error should be freed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 50 ++++++++++++++--------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 1a186142d3..394fd0b6b2 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -389,7 +389,6 @@ static uint16_t
 eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
 	unsigned int i;
-	struct rte_mbuf *mbuf;
 	struct pmd_process_private *pp;
 	struct pcap_tx_queue *dumper_q = queue;
 	uint16_t num_tx = 0;
@@ -397,7 +396,6 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	struct pcap_pkthdr header;
 	pcap_dumper_t *dumper;
 	unsigned char *temp_data;
-	size_t len, caplen;
 
 	pp = rte_eth_devices[dumper_q->port_id].process_private;
 	dumper = pp->tx_dumper[dumper_q->queue_id];
@@ -409,21 +407,22 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	/* writes the nb_pkts packets to the previously opened pcap file
 	 * dumper */
 	for (i = 0; i < nb_pkts; i++) {
-		mbuf = bufs[i];
+		struct rte_mbuf *mbuf = bufs[i];
+		uint32_t len, caplen;
+		const uint8_t *data;
+
 		len = caplen = rte_pktmbuf_pkt_len(mbuf);
 
 		calculate_timestamp(&header.ts);
 		header.len = len;
 		header.caplen = caplen;
-		/* rte_pktmbuf_read() returns a pointer to the data directly
-		 * in the mbuf (when the mbuf is contiguous) or, otherwise,
-		 * a pointer to temp_data after copying into it.
-		 */
-		pcap_dump((u_char *)dumper, &header,
-			  rte_pktmbuf_read(mbuf, 0, caplen, temp_data));
 
-		num_tx++;
-		tx_bytes += caplen;
+		data = rte_pktmbuf_read(mbuf, 0, caplen, temp_data);
+		if (likely(data != NULL)) {
+			pcap_dump((u_char *)dumper, &header, data);
+			num_tx++;
+			tx_bytes += caplen;
+		}
 	}
 	rte_pktmbuf_free_bulk(bufs, nb_pkts);
 
@@ -458,7 +457,7 @@ eth_tx_drop(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	tx_queue->tx_stat.pkts += nb_pkts;
 	tx_queue->tx_stat.bytes += tx_bytes;
 
-	return i;
+	return nb_pkts;
 }
 
 /*
@@ -468,15 +467,12 @@ static uint16_t
 eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
 	unsigned int i;
-	int ret;
-	struct rte_mbuf *mbuf;
 	struct pmd_process_private *pp;
 	struct pcap_tx_queue *tx_queue = queue;
 	uint16_t num_tx = 0;
 	uint32_t tx_bytes = 0;
 	pcap_t *pcap;
 	unsigned char *temp_data;
-	size_t len;
 
 	pp = rte_eth_devices[tx_queue->port_id].process_private;
 	pcap = pp->tx_pcap[tx_queue->queue_id];
@@ -486,19 +482,15 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		return 0;
 
 	for (i = 0; i < nb_pkts; i++) {
-		mbuf = bufs[i];
-		len = rte_pktmbuf_pkt_len(mbuf);
-
-		/* rte_pktmbuf_read() returns a pointer to the data directly
-		 * in the mbuf (when the mbuf is contiguous) or, otherwise,
-		 * a pointer to temp_data after copying into it.
-		 */
-		ret = pcap_sendpacket(pcap,
-			rte_pktmbuf_read(mbuf, 0, len, temp_data), len);
-		if (unlikely(ret != 0))
-			break;
-		num_tx++;
-		tx_bytes += len;
+		struct rte_mbuf *mbuf = bufs[i];
+		uint32_t len = rte_pktmbuf_pkt_len(mbuf);
+		const uint8_t *data;
+
+		data = rte_pktmbuf_read(mbuf, 0, len, temp_data);
+		if (likely(data != NULL && pcap_sendpacket(pcap, data, len) == 0)) {
+			num_tx++;
+			tx_bytes += len;
+		}
 	}
 
 	rte_pktmbuf_free_bulk(bufs, nb_pkts);
@@ -507,7 +499,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	tx_queue->tx_stat.bytes += tx_bytes;
 	tx_queue->tx_stat.err_pkts += i - num_tx;
 
-	return i;
+	return nb_pkts;
 }
 
 /*
-- 
2.51.0

