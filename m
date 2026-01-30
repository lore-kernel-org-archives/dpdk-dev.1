Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EB4D73EAF
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 01:14:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FEDD40678;
	Fri, 30 Jan 2026 02:14:08 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 7FA7840656
 for <dev@dpdk.org>; Fri, 30 Jan 2026 02:14:03 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-480142406b3so11609305e9.1
 for <dev@dpdk.org>; Thu, 29 Jan 2026 17:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769735643;
 x=1770340443; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4AKeZ5n9aHSLOPZJ7HNvITCDpuWc36TR960rnhrMnXA=;
 b=L1Qn7+HUAU24lw0r0wtG41RufHdb/VO/3XNE7zMf98Es2Xt23+tk4y+vxwGpHl9YbS
 Aq8eIOX2jksIb9dau/Mu20dfVDGaCJ/jMC8arqVhNFzmG4w/jU9pY1lT7xnrKlVku9ku
 NDLrpUKAjNThThsTImWZfEa0flXhPpkP1ht0KuM/v18b6W8dTI/2JkPAhqE0SDnPAuzK
 3CZgKTIbQILBgrMTNbQHEulaYr7NW7leJKvOwzqYl/obs55ewnFuO6MBNohyqGtoqnKa
 Jhmcqj8bb04wVXSnreVGRnm+Krh32duZEkNvLpAzLfByOXxB6XxS3TEJrBi7jKAGjVSt
 DB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769735643; x=1770340443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4AKeZ5n9aHSLOPZJ7HNvITCDpuWc36TR960rnhrMnXA=;
 b=AlCv+peuxX2IZSgMkh4Z1eJ+gOgIw9wKkAqhBFWS9+Amaopx+2fe2du1UK0haXPQdF
 fTn8zMaXUqM13EmtTBDlkFqT2rQq1R8OHO/tDFIPEeDiO/Yb0Am8NBXdlCfFoe3rRoZ1
 oko0eqD2isZveH0dcm/b63y5V6V3cvaKBNMRo6tMbmX5Mqk19JFlvztebH/gnwPP/QNW
 YkUwXKkE+HobYTaer1tBuKdxb+DrACu/WsJO5FTeOSOuVtKlIc7y43eB/GLHqHZJzLLX
 MQv4H2RhRh54LFrDudwWXnkWKWoT9c1e1EFmES/ZQzoS3xvyiOIGIeb39cLg/t+Mrh9X
 Hc0w==
X-Gm-Message-State: AOJu0YzJoYTglHp7/JHcrwpenzJDCtFtRDxfCFdu2d3zJL3GoHX7CuUJ
 4DOrNGxY9O4V2K97Rf1DQbPUf7TxCMMACf1RifGdFFjIqRh4+bpn1df402iUHCJvCVm1j1CbkCL
 Nwq9z
X-Gm-Gg: AZuq6aKegQkHah61uC/A3uaXTmYRyziF86y8GNygdkIYYrA4gV0a7/u4uMA2J0tmtrH
 5U+wTDjAebo/GKeUA4j86PvBz+v0CnsHSaMEs9ne5glCpPUZRij0QpZVxfUi0QevvQTMPd8pB5A
 blA8lqah29aMhl4EvVfmSZWLsXnzuOw3b6oIEjCG8b4qGe6lRRgfnbf2OkSaazhk8x4Nc7VTcmq
 5GtZTJGo2Onr/JHqwGLHrh18P5ahfmWGGrkyc26Xo7TWe5+3bGcVmvMB+/GEAkthaNbcpTCE9wV
 5vkm9DgCBAgSRYSSt40A0CNsJAu6u2TAxg/BB6tCqS1Db3uRgMh8ySZDNQbKibicxSHVFhmxwDR
 m3as4TUsGjl/M5ykwnZ9y+PNuqHuK25j6TU+fbKljVU5NFclJK5eCXEUt8DojSVNnXPpcCPpPEA
 MSSWYxtzqfVnAClU5iYdqCzTGXTcTwIQDO74kMr7Boq5+vHaJ8zA==
X-Received: by 2002:a05:600c:3148:b0:47a:935f:618e with SMTP id
 5b1f17b1804b1-482db45ce3amr10806875e9.15.1769735643149; 
 Thu, 29 Jan 2026 17:14:03 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e1d0f9sm2934825e9.18.2026.01.29.17.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 17:14:02 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 08/19] net/pcap: cleanup transmit buffer handling
Date: Thu, 29 Jan 2026 17:12:24 -0800
Message-ID: <20260130011344.204233-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130011344.204233-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130011344.204233-1-stephen@networkplumber.org>
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

