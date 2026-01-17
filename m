Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F318CA5FE0
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Jan 2026 22:00:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72F5142F37;
	Sat, 17 Jan 2026 23:00:45 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 5DAEA42F1B
 for <dev@dpdk.org>; Sat, 17 Jan 2026 23:00:44 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-432d2c7a8b9so2740517f8f.2
 for <dev@dpdk.org>; Sat, 17 Jan 2026 14:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768687244;
 x=1769292044; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2VBvQOAzZM120p4lcsqe+Ow8nYDJ4wNHVGIE+UgEwI=;
 b=FcmNjL3vWkf29ikOBtFgwZwrxOw6VV3iZ4nT5sVQZrGy/lD2foeaFWXEOJxq8s8BbG
 gCTdmK6BtOnxF0kYJIbqGQ7pCbEyrod2fqPwucW4akTi0osxI0tIC9+PwqbkEh/G1zWw
 XR1rOhOZdc2omOsat4PpRfjKsE49iV3fl8S1Cap5AeAEq+ieXzuT+BUj+F+VWvgYqnEf
 Pe9/2AtTnRbqFrJu3Ztssc+7UKkx7ai3W0XqkIGVmRPbrprPM/b8lEoAMPSzOepUHDKM
 iX66/R6XYm5LFwTsTBr6ddAAsMGeGOoxVh3uXsWjQnxtA1Wuig2mzvcC0y/RPr14Gc4l
 9exA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768687244; x=1769292044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G2VBvQOAzZM120p4lcsqe+Ow8nYDJ4wNHVGIE+UgEwI=;
 b=tWi4sC/3+NbTejITudY0af15LO3fJXvaKibuEqnJiBmTARiidY+JcDBYh2HlM8jpw+
 XtFH0bHFcOhEGwoV1u/9LE39Qc4DtbArOp7E17kialCKDV8WrIZoDxpxCGUBRxuNL7SR
 cnpGBb+KCfGZX0R1wOnsWQ5vbP16POi23LvWw6YcOl0DuG6JkqfI6RI/llLOpUH3DO41
 rm4LWa9YbJLgARRKc+iesjwL9ZWn7WGl5gdR8OToEa46IBquCZ0FOzudioX0dU0WR7L0
 H151/GuY6navUZyQXj/VqEozXTdWW5nEET9XkxCtw4blkyNCsdGPO1jK0le7GcrxuyMA
 Kt3Q==
X-Gm-Message-State: AOJu0YygRc35kimTWc2sCuB0FXXl/6wNN4Xu0pSaD8SFtsb0KSR1JY8v
 j6ok7MGguRPFLDCDapTTOs40OkzMaz7aTVzQmqnTQjpVRXHRBcMv3nsQ8kQt+Zk7Cvz/zPZwoKd
 //Dld
X-Gm-Gg: AY/fxX7PoXnH/EDl8yFhXNrBi2yohF8tZ3sF5vRSHmRc0ukvJ2SmYbTKYsSm3zaXdBA
 zXEnhQZTIiyxM3avu95/pSjOx/zNy9YQJ+nl3T15w/zbD4a55ac+jZISx03ITTPnP/la/+IsSeM
 BIbgVTJ428As+xL+ryLzkMGDz8e5Z6Zi2gzNqgTCNCpJynV0wcSSYStqqvij+7pGAJxu2BdF29d
 NPsZ6AmClyg3LwSPP7Q2VitqDxlxnJCgW3V8iExFQDNWxoG/5zKwd7bMZixQ6WRPREDNneaIjlw
 ZRnI/Z2X+xdGPw38xDQ17rkP7eEOFT+VfGy4XPs1pxxlg+ZXLptiq0C7A4uptLMJtq8gPENA1wP
 QxnBXQf1FTY3qaZqCsHxEHApgGsN096YeYOlBbwBP00fg/ArMHxlwRfo8e2EixuTzWVhXqH7dMJ
 en0A1el+MxN7U+KSAONVw8BeiPisxravcaZi8yiaF/vlB4WDCfnw==
X-Received: by 2002:a05:6000:250c:b0:430:f58d:40d7 with SMTP id
 ffacd0b85a97d-4356a033054mr9562705f8f.13.1768687243830; 
 Sat, 17 Jan 2026 14:00:43 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992681esm13309352f8f.11.2026.01.17.14.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 14:00:42 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 03/11] net/pcap: cleanup transmit of multi segment
Date: Sat, 17 Jan 2026 13:57:02 -0800
Message-ID: <20260117220030.273471-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260117220030.273471-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260117220030.273471-1-stephen@networkplumber.org>
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

The driver was not reporting multi segment in offload
flags but it can handle it.

The logic for handling transmit would allocate a worst case
size buffer on the stack which could be up to 9K.
If packet was transmitted larger than that it would get
truncated and log would get flooded.

Instead, allocate a buffer on stack only if necessary
and gracefully handle errors by incrementing transmit error
counter.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 110 +++++++++++++++++----------------
 1 file changed, 58 insertions(+), 52 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index f323c0b0df..22c9cb5928 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -22,7 +22,7 @@
 #include "pcap_osdep.h"
 
 #define RTE_ETH_PCAP_SNAPSHOT_LEN 65535
-#define RTE_ETH_PCAP_SNAPLEN RTE_ETHER_MAX_JUMBO_FRAME_LEN
+#define RTE_ETH_PCAP_SNAPLEN (RTE_ETHER_MAX_JUMBO_FRAME_LEN - RTE_ETHER_CRC_LEN)
 #define RTE_ETH_PCAP_PROMISC 1
 #define RTE_ETH_PCAP_TIMEOUT -1
 
@@ -370,6 +370,22 @@ calculate_timestamp(struct timeval *ts) {
 	}
 }
 
+/* Like rte_pktmbuf_read() but allocate if needed */
+static inline const void *
+pcap_pktmbuf_read(const struct rte_mbuf *m,
+		  uint32_t off, uint32_t len, void **buf)
+{
+	if (likely(off + len <= rte_pktmbuf_data_len(m))) {
+		return rte_pktmbuf_mtod_offset(m, char *, off);
+	} else {
+		*buf = malloc(len);
+		if (likely(*buf != NULL))
+			return rte_pktmbuf_read(m, off, len, *buf);
+		else
+			return NULL;
+	}
+}
+
 /*
  * Callback to handle writing packets to a pcap file.
  */
@@ -377,46 +393,43 @@ static uint16_t
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
+
+		data = pcap_pktmbuf_read(mbuf, 0, len, &temp);
+		if (unlikely(data == NULL)) {
+			++dumper_q->tx_stat.err_pkts;
+			continue;
+		}
+
+		pcap_dump((u_char *)dumper, &header, data);
 
 		num_tx++;
-		tx_bytes += caplen;
-		rte_pktmbuf_free(mbuf);
+		tx_bytes += len;
+		free(temp);
 	}
+	rte_pktmbuf_free_bulk(bufs, nb_pkts);
 
 	/*
 	 * Since there's no place to hook a callback when the forwarding
@@ -444,15 +457,15 @@ eth_tx_drop(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
@@ -462,15 +475,11 @@ static uint16_t
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
@@ -479,35 +488,31 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
+		struct rte_mbuf *mbuf = bufs[i];
+		uint32_t len = rte_pktmbuf_pkt_len(mbuf);
+		void *temp = NULL;
+		const uint8_t *data;
+
+		data = pcap_pktmbuf_read(mbuf, 0, len, &temp);
+		if (unlikely(data == NULL)) {
+			++tx_queue->tx_stat.err_pkts;
 			continue;
 		}
 
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
+		if (likely(pcap_sendpacket(pcap, data, len) == 0)) {
+			num_tx++;
+			tx_bytes += len;
+		} else {
+			++tx_queue->tx_stat.err_pkts;
+		}
+
 	}
 
 	tx_queue->tx_stat.pkts += num_tx;
 	tx_queue->tx_stat.bytes += tx_bytes;
-	tx_queue->tx_stat.err_pkts += i - num_tx;
+	tx_queue->tx_stat.err_pkts += nb_pkts - num_tx;
 
-	return i;
+	return nb_pkts;
 }
 
 /*
@@ -745,6 +750,7 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
 	return 0;
 }
-- 
2.51.0

