Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE515E7FDF8
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 23:13:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 761C6406B4;
	Tue,  3 Feb 2026 00:13:08 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 049C240685
 for <dev@dpdk.org>; Tue,  3 Feb 2026 00:13:07 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-48068ed1eccso45918425e9.2
 for <dev@dpdk.org>; Mon, 02 Feb 2026 15:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770073986;
 x=1770678786; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UPH459D810YYeGLP7kol19OmSpaOkf273irSpjYA9M0=;
 b=TXoZez1JtIsLc/7LjDkapP/284L8mlAi7Xdc5MCxwlaWWTir5+Z+MRBzdNEDSJm7p4
 SF2XI3OYZYzZGmleMqeAhOACJ1sNeO44KOeczubkIvzK6Tax8Ky3cuABbu5WsDszfo37
 kFLOFDYVRUwAD2ruOXOOWdngTFLsAvX84lDmqJh6CY2ntceq3czQQy3tcmaGutQe3wb1
 bLThz6z+/R7vs9H5J/OpPZzyEQcZQeE3+bkorgohGgkmx6bK/JT5oN6ojukTZrTq0w1j
 6nL1/FYVvjRPH+1gSMveXXgID0NmsFkPJ5apf3jHtVYdhQLc9PpXVpG7PXCLeADs076g
 BRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770073986; x=1770678786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UPH459D810YYeGLP7kol19OmSpaOkf273irSpjYA9M0=;
 b=n81VjDShpCpo1GjkAqHRAKjOp+n5eJdySWO1xHRVwt9FFh6cDVGXaZZ2jvhFlCsx31
 MzOD612VXwMwZt+Mymvg7sZxW7m3iL4EKd8Ybgu32C05Xl6TDD2QLgPRkwHPkiv7CkwO
 E1RcZoxc7wglE5k9+5+FPriRuHCrR+EK1TQBpc4S4ZLirCRtduqxItE0ptoMeWJQ8fUx
 ZGVMliaZR6Aey4KIVyVd9jN0ZVSKXrkccGF2zEYJXD2mfNWGL89q3sKehjM8yc09ke/K
 hJZNLLA9g4Y5qrye8gEZY1G4FZUA5PSdT1SKPF/7w3+HqmnuGrgLpVH5XTkRi3i9VVHq
 Z7Hw==
X-Gm-Message-State: AOJu0YxPMrNDx83f0xYptLtCHl/cWklxKwDcDpzMGgJdcbLA+VLnRCCO
 sO1aSJi3FtX8kU2YpSP5ca7A83WasqhioK0ZMjAVVjSW20SbQD7wRVwBhC7Qr9OeU+1o5N3DapL
 MnSZ9
X-Gm-Gg: AZuq6aIlxMsHPDl3fKHxwp6gzYrsSlfUEFgEk/4D/oZ5L0WIwzDFX41zUY+L4nrQI3J
 vtlfI2tEO1xnoboxWp9XO4oBmPhh29Kmig4WR4IRj1pOz+dY87l5DUjKAG30JV+QPMEGGDsV18o
 hra+hfPwAkn8wyxRZDJFpVxhgRc7EnZklPkari6GZoyB2h8d8rKCTOABPPaKgO+kSlFa86dLAti
 6SrgA9mJs1XvZM0x/AKrHHb3zH4wzFeqbj95JRaNMPvKxZ38aICZfobJWCjTiTlUgtID2DUaX4x
 Kub0TyNfag8T+GW9csWFMwzYOZqzx32CwnCWev4crHNPFz12jpvmsNJbcjpx4nuKywf2vd9VFFr
 vFqlMKqtk2s7e5l6SyOZI2eFyd2lYML6cScm/JWenaZzOOLjxv1j359Zmix5qlcDpUwNVtoGaf3
 MfKorD8+eV3pwVXVhbnfFXMCseMPq2vAP3oP6ARUVD+uFx3iCNlGof3RXanP1p
X-Received: by 2002:a05:600c:8716:b0:47e:d943:ec08 with SMTP id
 5b1f17b1804b1-482db4919a6mr164698615e9.28.1770073986584; 
 Mon, 02 Feb 2026 15:13:06 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e48a6sm45799474f8f.8.2026.02.02.15.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 15:13:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v12 08/19] net/pcap: cleanup transmit buffer handling
Date: Mon,  2 Feb 2026 15:09:11 -0800
Message-ID: <20260202231245.216433-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202231245.216433-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260202231245.216433-1-stephen@networkplumber.org>
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
 drivers/net/pcap/pcap_ethdev.c | 60 ++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index a89379ea9c..0aa3d67e4d 100644
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
@@ -486,19 +482,27 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		return 0;
 
 	for (i = 0; i < nb_pkts; i++) {
-		mbuf = bufs[i];
-		len = rte_pktmbuf_pkt_len(mbuf);
+		struct rte_mbuf *mbuf = bufs[i];
+		uint32_t len = rte_pktmbuf_pkt_len(mbuf);
+		const uint8_t *data;
 
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
+		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) && len > RTE_ETH_PCAP_SNAPSHOT_LEN)) {
+			static int warned;
+
+			if (!warned) {
+				PMD_LOG(ERR,
+					"Multi segment PCAP packet. Size (%u) > max size (%u).",
+					len, RTE_ETH_PCAP_SNAPSHOT_LEN);
+				warned = 1;
+			}
+			continue;
+		}
+
+		data = rte_pktmbuf_read(mbuf, 0, len, temp_data);
+		if (likely(data != NULL && pcap_sendpacket(pcap, data, len) == 0)) {
+			num_tx++;
+			tx_bytes += len;
+		}
 	}
 
 	rte_pktmbuf_free_bulk(bufs, nb_pkts);
@@ -507,7 +511,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	tx_queue->tx_stat.bytes += tx_bytes;
 	tx_queue->tx_stat.err_pkts += i - num_tx;
 
-	return i;
+	return nb_pkts;
 }
 
 /*
-- 
2.51.0

