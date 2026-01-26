Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710D7D1950F
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 18:08:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B3D540649;
	Mon, 26 Jan 2026 19:08:32 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id DB6344042F
 for <dev@dpdk.org>; Mon, 26 Jan 2026 19:08:21 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47ee937ecf2so40884505e9.0
 for <dev@dpdk.org>; Mon, 26 Jan 2026 10:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769450901;
 x=1770055701; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A0XiRI6ZbAP5COo33JN75kxrdB0yAHundQu8OPyhTeM=;
 b=OEkIpJ5jvFGFlSGu1jhK+FYUl69FjgJlEoZM+3/yU4XTDTovD3waWCn6HXhRkJ26bK
 gfH8SH/qVw4pVQj87dio6Q4sW1ALTnrbhbAkP4+o8erL2nuUPx8WwaBAXdc8l/xSg1yL
 htumnQf9O8irqvpyvtM0RnUnPMHCTY8rRJoPS+fP38uS6a9yluhZ1qDPpZYK35blV66x
 yiHH8R2e7wbWnxN6aFexFnoEq5dlyIYD1m5hLDx2RUSVQIaaKF3zoc7NJQDh1+BI7UIh
 L9Kfsh2p1nK6C8649VVj6qm4un4ffnCZA4GtoSGT1cD0HKyAn065Wsu3ZrtPdLJJ0JxY
 FggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769450901; x=1770055701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A0XiRI6ZbAP5COo33JN75kxrdB0yAHundQu8OPyhTeM=;
 b=Cwb5cE8M6sFLZkgQWsbBn2faKn52xNcip7qL0s+Jnsa8IQNf+LCu2258RNS/kCbzAd
 Acv3m/9c1t7qGP/RI7RG4SMXiNSA/GH136vI+3u3fxf0zYkGMxxe+iR6g/CUQk4Y6zJu
 rK3IVBMnmiUrhNfBCEe621rOIsnOfOuhzhCHuIM18BjjvePDKGI2w3LAYpMv2lHFfYkN
 2ccAva0nHa8klJvphGeYftTx0nAOGIbzu+dWV2P+FQInhmmQK+B5kZG5Cr29Zoi471b5
 w/oVR1r2msMD/bXT9MxXxh8jWuopiQlVq+vIIW6mzwvsL6rDqzG4686GLycLkCJoiq1m
 HsEw==
X-Gm-Message-State: AOJu0Yy7DGZWB4VJRJ+azpdkooy9u9Ui7UJoiDh6OiryQ6lHcqL1HVQ4
 hQ36wgIR8Vq1LbB5dx5Q7b4gD3EV8Ccn6QlKexuB7btfNcjvj1aRU2WzKB64sZNefj/SVUaULs+
 h+UpY
X-Gm-Gg: AZuq6aK8lofBDx3nb0nNsAmoC+hnEVbIbGhKSueO0FWNF0GKYRk9pDR77m1lWOtuPHq
 qVbu9DW5HGrmeUK15ynv6Ekd9t5Fkx3fxif4ZIIvDD3+yyVqg6ocK2qRGefoNFYvW0qM2aeN6D6
 sPL4l6WMme+Di/kiojDLNTSRSZGykpYerzE1aKx/5BMxn9nEFHzzLwbQz6dJSPQ7GbVHbQUEZ8y
 EBISJspnpMJl514O4gcgMNx8x3y66S6oPlV57kl7VCOJwJssrVXs24C5fSh5S1uhHZ48pnT7fRO
 SpfVnVDmXTcKrFpQNYm/uLIbtg2NzC1/TvJKwmqT2V3S8AZbp7YLTowe97olQHAdwqPJqYjXP36
 EM1E9kCYcmMQQuxAZvRYXVbIIoe/pT78o+Jy5Y6mbXwyOtSrBskRFMfuleLJ60PbVxWVXODkKmG
 UEilyiWq6kE7wpuf89SrxzgXXA8B0fhTvEktPll3dkMhj89OdcUg==
X-Received: by 2002:a05:600c:698d:b0:47e:e2b8:66e6 with SMTP id
 5b1f17b1804b1-4805ce4fba0mr85181545e9.14.1769450901334; 
 Mon, 26 Jan 2026 10:08:21 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c02c91sm31845864f8f.9.2026.01.26.10.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 10:08:20 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 06/13] net/pcap: improve multi-segment transmit handling
Date: Mon, 26 Jan 2026 10:06:43 -0800
Message-ID: <20260126180807.100891-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126180807.100891-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260126180807.100891-1-stephen@networkplumber.org>
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

Advertise RTE_ETH_TX_OFFLOAD_MULTI_SEGS capability in device info. The
driver already handles multi-segment mbufs but was not reporting this.

Replace the fixed-size stack buffer (up to 9K) with dynamic allocation
only when the mbuf is non-contiguous. This avoids large stack usage and
removes the silent truncation that occurred when packets exceeded the
buffer size.

Change transmit functions to always consume and free all packets,
returning nb_pkts regardless of send success. The DPDK transmit API
interprets a return value less than requested as "queue full, retry
later." However, pcap_sendpacket() failures (bad parameters or socket
errors) are not transient and retrying would fail again. The correct
behavior is to free failed packets and increment the error counter
rather than leaving mbufs for the application to retry.

Also use rte_pktmbuf_free_bulk() for more efficient buffer freeing.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_03.rst |   5 ++
 drivers/net/pcap/pcap_ethdev.c         | 106 ++++++++++++-------------
 2 files changed, 56 insertions(+), 55 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 15dabee7a1..76d81ac524 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -55,6 +55,11 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated PCAP ethernet driver.**
+
+  * Changed transmit burst to always return the number of packets requested.
+    Failed sends are counted as transmit errors.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 2e41ad35ed..537d66ed30 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -30,7 +30,7 @@
 #include "pcap_osdep.h"
 
 #define RTE_ETH_PCAP_SNAPSHOT_LEN 65535
-#define RTE_ETH_PCAP_SNAPLEN RTE_ETHER_MAX_JUMBO_FRAME_LEN
+#define RTE_ETH_PCAP_SNAPLEN (RTE_ETHER_MAX_JUMBO_FRAME_LEN - RTE_ETHER_CRC_LEN)
 #define RTE_ETH_PCAP_PROMISC 1
 #define RTE_ETH_PCAP_TIMEOUT -1
 
@@ -378,6 +378,21 @@ calculate_timestamp(struct timeval *ts) {
 	}
 }
 
+/* Like rte_pktmbuf_read() but allocate if needed */
+static inline const void *
+pcap_pktmbuf_read(const struct rte_mbuf *m,
+		  uint32_t off, uint32_t len, void **buf)
+{
+	if (likely(off + len <= rte_pktmbuf_data_len(m)))
+		return rte_pktmbuf_mtod_offset(m, char *, off);
+
+	*buf = malloc(len);
+	if (likely(*buf != NULL))
+		return rte_pktmbuf_read(m, off, len, *buf);
+	else
+		return NULL;
+}
+
 /*
  * Callback to handle writing packets to a pcap file.
  */
@@ -385,46 +400,40 @@ static uint16_t
 eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
 	unsigned int i;
-	struct rte_mbuf *mbuf;
 	struct pmd_process_private *pp;
 	struct pcap_tx_queue *dumper_q = queue;
+	pcap_dumper_t *dumper;
 	uint16_t num_tx = 0;
 	uint32_t tx_bytes = 0;
 	struct pcap_pkthdr header;
-	pcap_dumper_t *dumper;
-	unsigned char temp_data[RTE_ETH_PCAP_SNAPLEN];
-	size_t len, caplen;
 
 	pp = rte_eth_devices[dumper_q->port_id].process_private;
 	dumper = pp->tx_dumper[dumper_q->queue_id];
 
-	if (dumper == NULL || nb_pkts == 0)
+	if (unlikely(dumper == NULL || nb_pkts == 0))
 		return 0;
 
-	/* writes the nb_pkts packets to the previously opened pcap file
-	 * dumper */
+	/* writes the nb_pkts packets to the previously opened pcap file dumper */
 	for (i = 0; i < nb_pkts; i++) {
-		mbuf = bufs[i];
-		len = caplen = rte_pktmbuf_pkt_len(mbuf);
-		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) &&
-				len > sizeof(temp_data))) {
-			caplen = sizeof(temp_data);
-		}
+		struct rte_mbuf *mbuf = bufs[i];
+		uint32_t len = rte_pktmbuf_pkt_len(mbuf);
+		void *temp = NULL;
+		const uint8_t *data;
 
 		calculate_timestamp(&header.ts);
 		header.len = len;
-		header.caplen = caplen;
-		/* rte_pktmbuf_read() returns a pointer to the data directly
-		 * in the mbuf (when the mbuf is contiguous) or, otherwise,
-		 * a pointer to temp_data after copying into it.
-		 */
-		pcap_dump((u_char *)dumper, &header,
-			rte_pktmbuf_read(mbuf, 0, caplen, temp_data));
+		header.caplen = len;
 
-		num_tx++;
-		tx_bytes += caplen;
-		rte_pktmbuf_free(mbuf);
+		data = pcap_pktmbuf_read(mbuf, 0, len, &temp);
+		if (likely(data != NULL)) {
+			pcap_dump((u_char *)dumper, &header, data);
+
+			num_tx++;
+			tx_bytes += len;
+		}
+		free(temp);
 	}
+	rte_pktmbuf_free_bulk(bufs, nb_pkts);
 
 	/*
 	 * Since there's no place to hook a callback when the forwarding
@@ -452,15 +461,15 @@ eth_tx_drop(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	if (unlikely(nb_pkts == 0))
 		return 0;
 
-	for (i = 0; i < nb_pkts; i++) {
+	for (i = 0; i < nb_pkts; i++)
 		tx_bytes += bufs[i]->pkt_len;
-		rte_pktmbuf_free(bufs[i]);
-	}
+
+	rte_pktmbuf_free_bulk(bufs, nb_pkts);
 
 	tx_queue->tx_stat.pkts += nb_pkts;
 	tx_queue->tx_stat.bytes += tx_bytes;
 
-	return i;
+	return nb_pkts;
 }
 
 /*
@@ -470,15 +479,11 @@ static uint16_t
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
-	unsigned char temp_data[RTE_ETH_PCAP_SNAPLEN];
-	size_t len;
 
 	pp = rte_eth_devices[tx_queue->port_id].process_private;
 	pcap = pp->tx_pcap[tx_queue->queue_id];
@@ -487,35 +492,25 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		return 0;
 
 	for (i = 0; i < nb_pkts; i++) {
-		mbuf = bufs[i];
-		len = rte_pktmbuf_pkt_len(mbuf);
-		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) &&
-				len > sizeof(temp_data))) {
-			PMD_LOG(ERR,
-				"Dropping multi segment PCAP packet. Size (%zd) > max size (%zd).",
-				len, sizeof(temp_data));
-			rte_pktmbuf_free(mbuf);
-			continue;
+		struct rte_mbuf *mbuf = bufs[i];
+		uint32_t len = rte_pktmbuf_pkt_len(mbuf);
+		void *temp = NULL;
+		const uint8_t *data;
+
+		data = pcap_pktmbuf_read(mbuf, 0, len, &temp);
+		if (likely(data != NULL &&
+		    pcap_sendpacket(pcap, data, len) == 0)) {
+			num_tx++;
+			tx_bytes += len;
 		}
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
-		rte_pktmbuf_free(mbuf);
 	}
+	rte_pktmbuf_free_bulk(bufs, nb_pkts);
 
 	tx_queue->tx_stat.pkts += num_tx;
 	tx_queue->tx_stat.bytes += tx_bytes;
-	tx_queue->tx_stat.err_pkts += i - num_tx;
+	tx_queue->tx_stat.err_pkts += nb_pkts - num_tx;
 
-	return i;
+	return nb_pkts;
 }
 
 /*
@@ -753,6 +748,7 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
 	return 0;
 }
-- 
2.51.0

