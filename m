Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90525FD0049
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Mar 2026 02:08:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD1CB40E28;
	Sun,  1 Mar 2026 03:07:47 +0100 (CET)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47]) by mails.dpdk.org (Postfix) with ESMTP id 38B8240E18
 for <dev@dpdk.org>; Sun,  1 Mar 2026 03:07:45 +0100 (CET)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-899ab9d13d0so26687496d6.0
 for <dev@dpdk.org>; Sat, 28 Feb 2026 18:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772330864;
 x=1772935664; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RvMwH4eSfcYwmD2/yPtRoszV6ooS6eQZpe74hWQhafU=;
 b=MWuW4vYZJ9v2JhfD0i87Aj+PEh5wi+XtCOSlsHEDHmcxqkUxmiKyGD7lXNKNkuN6l7
 r3iahRnLi1ipQFmslYRoLPeIHIph2CcBDf2fmQn4FqagsqxEMvN2WIaNC2GMwqXIZUDK
 G2THHRXLcnQr/qaCAgM4IaHzBft0DWy5Q5Kecd5vUyP0d2C/MgPddOOxyShXiu1Y/Sbo
 IswMxxK/x+2f17p64ONk+Mz1KRyb36qWywob+w66Sg1PD1K6xPblbsp/7Qoo499CzgJL
 GsKjL62cKa66eKtUMGFli3t7VgEbKmHBrBEgJs4HeillKGjUypza6To5gQJpQTpOYxD5
 /Maw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772330864; x=1772935664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RvMwH4eSfcYwmD2/yPtRoszV6ooS6eQZpe74hWQhafU=;
 b=gouw8xN+lTGfWsgQGFi3VrAdvQKM0hGDclRPfd6UZ9mDEzxSOVN3iK0pXjNz9UCO/E
 n5q0GOjhnnzheEljerbkXvga4/W6zLvY5d1qqxv89Q6hcXTa/GX1lLUyeEe8XSJ/otG8
 Iy/oY8mxALpZR+hA0hSTlBx+V6yUtQcWEAbbMbg2P39ZEYvE0szG1NelZgjLbpTIKEtL
 Cm7zQQ1Z20UWZZY45Eb8H8NIhIGN51EsOYoJC4G22Q6NjuCMpbCGIF/+1Zu898mfuOJS
 Aip9M+8tuf8+Rb8RIdfIi8pNLfuaI7VN+ztPv2WGdqXFYQFIzjC1xgDXIqzckCp6N9Os
 RvVA==
X-Gm-Message-State: AOJu0YwmUGuQD1rC4z5cgWXd0uLYSmwgvPVVNJaRZL9Ct9lPjjkxEdKL
 pla2EW5+wCXBEhupH+wbOvCUxfr7zYbEUgNlNo7WrgTrjrv1KXbtHz/QJ8hun2EeX0zuKPKcJJ+
 a773R
X-Gm-Gg: ATEYQzyz1lFxAFUMGV07dSoe3Fc/cvq8FfqNdYPTNnEGupJD0T1V8lS9BHJLZVf+lpP
 KRKeb4B0MjQfRTWYBUjX+GtR4WUMLqHCPb09yWHiKeC9omSockSebIzxifX7AkhRr6Ger4BMmXh
 voN7rH5wELOUouB+DR23wl2XlKG1VDWWR4LbILI4tRbsr5v5yXS2ejdOilZiHxpPX7vNlQdZE4f
 Lfr1XuOadw0aP27fQFu1hdmsfcC2r+Zei28xyrGSTeJsztRtGFqPf3st7BBzxyHeP3MRafV+23s
 u2trpWH11bogYy451bG/C0r8g0MY1VGSKS8RKETGYC05H92RMnLhH3/Iy4lvVHFu2dnMyXRZFeZ
 0PYPpLgBR+tuS844S3GOwBxrKEqHFSfUY7nCkXoqpg6Jsmnkt8Qr5eoUQLzZ7S7v/0XWvRzRVIo
 v6p/3NHa5s9UFrAMAHyoYOCvdeDRgdBeGMciCRoit6UO9e5wFbwC9Yr9wlpcCVng==
X-Received: by 2002:a05:620a:c42:b0:8a2:e1db:f442 with SMTP id
 af79cd13be357-8cbc8e98504mr991235485a.30.1772330864435; 
 Sat, 28 Feb 2026 18:07:44 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf736bffsm802292985a.50.2026.02.28.18.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 18:07:44 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 David Marchand <david.marchand@redhat.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v18 09/23] net/pcap: fix error accounting and backpressure on
 transmit
Date: Sat, 28 Feb 2026 18:05:42 -0800
Message-ID: <20260301020726.852401-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260301020726.852401-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260301020726.852401-1-stephen@networkplumber.org>
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

The error handling when pcap_sendpacket() was incorrect.
When underlying kernel socket buffer got full the send was counted as
an error. Malformed multi-segment mbufs where pkt_len exceeds actual
data were silently accepted.

Malformed mbufs are now detected via rte_pktmbuf_read() failure
and counted as errors.

On Linux, pcap_sendpacket() calls send() on a blocking PF_PACKET
socket with default kernel buffer sizes and no TX ring (PACKET_TX_RING).
The send() call only blocks when the kernel socket send buffer is full,
providing limited backpressure. Backpressure is not an error.

Fixes: fbbbf553f268 ("net/pcap: fix concurrent multiseg Tx")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 77 +++++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 28 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 72a297d423..14014a9e4b 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -407,7 +407,8 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	 * dumper */
 	for (i = 0; i < nb_pkts; i++) {
 		struct rte_mbuf *mbuf = bufs[i];
-		size_t len, caplen;
+		uint32_t len, caplen;
+		const uint8_t *data;
 
 		len = rte_pktmbuf_pkt_len(mbuf);
 		caplen = RTE_MIN(len, RTE_ETH_PCAP_SNAPSHOT_LEN);
@@ -415,15 +416,19 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		calculate_timestamp(&header.ts);
 		header.len = len;
 		header.caplen = caplen;
-		/* rte_pktmbuf_read() returns a pointer to the data directly
-		 * in the mbuf (when the mbuf is contiguous) or, otherwise,
-		 * a pointer to temp_data after copying into it.
-		 */
-		pcap_dump((u_char *)dumper, &header,
-			rte_pktmbuf_read(mbuf, 0, caplen, temp_data));
 
-		num_tx++;
-		tx_bytes += caplen;
+		data = rte_pktmbuf_read(mbuf, 0, caplen, temp_data);
+		if (unlikely(data == NULL)) {
+			/* This only happens if mbuf is bogus pkt_len > data_len */
+			PMD_LOG(ERR, "rte_pktmbuf_read failed");
+			dumper_q->tx_stat.err_pkts++;
+		} else {
+			pcap_dump((u_char *)dumper, &header, data);
+
+			num_tx++;
+			tx_bytes += caplen;
+		}
+
 		rte_pktmbuf_free(mbuf);
 	}
 
@@ -435,9 +440,8 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	pcap_dump_flush(dumper);
 	dumper_q->tx_stat.pkts += num_tx;
 	dumper_q->tx_stat.bytes += tx_bytes;
-	dumper_q->tx_stat.err_pkts += nb_pkts - num_tx;
 
-	return nb_pkts;
+	return i;
 }
 
 /*
@@ -462,7 +466,17 @@ eth_tx_drop(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 }
 
 /*
- * Callback to handle sending packets through a real NIC.
+ * Send a burst of packets to a pcap device.
+ *
+ * On Linux, pcap_sendpacket() calls send() on a blocking PF_PACKET
+ * socket with default kernel buffer sizes and no TX ring (PACKET_TX_RING).
+ * The send() call only blocks when the kernel socket send buffer is full,
+ * providing limited backpressure.
+ *
+ * On error, pcap_sendpacket() returns non-zero and the loop breaks,
+ * leaving remaining packets unsent.
+ *
+ * Bottom line: backpressure is not an error.
  */
 static uint16_t
 eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
@@ -484,34 +498,41 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 	for (i = 0; i < nb_pkts; i++) {
 		struct rte_mbuf *mbuf = bufs[i];
-		size_t len = rte_pktmbuf_pkt_len(mbuf);
-		int ret;
+		uint32_t len = rte_pktmbuf_pkt_len(mbuf);
+		const uint8_t *data;
 
-		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) &&
-				len > RTE_ETH_PCAP_SNAPSHOT_LEN)) {
+		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) && len > RTE_ETH_PCAP_SNAPSHOT_LEN)) {
 			PMD_LOG(ERR,
-				"Dropping multi segment PCAP packet. Size (%zd) > max size (%u).",
+				"Dropping multi segment PCAP packet. Size (%u) > max size (%u).",
 				len, RTE_ETH_PCAP_SNAPSHOT_LEN);
+			tx_queue->tx_stat.err_pkts++;
 			rte_pktmbuf_free(mbuf);
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
+		data = rte_pktmbuf_read(mbuf, 0, len, temp_data);
+		if (unlikely(data == NULL)) {
+			/* This only happens if mbuf is bogus pkt_len > data_len */
+			PMD_LOG(ERR, "rte_pktmbuf_read failed");
+			tx_queue->tx_stat.err_pkts++;
+		} else {
+			/*
+			 * No good way to separate back pressure from failure here
+			 * Assume it is EBUSY, ENOMEM, or EINTR, something that can be retried.
+			 */
+			if (pcap_sendpacket(pcap, data, len) != 0) {
+				PMD_LOG(ERR, "pcap_sendpacket() failed: %s", pcap_geterr(pcap));
+				break;
+			}
+			num_tx++;
+			tx_bytes += len;
+		}
+
 		rte_pktmbuf_free(mbuf);
 	}
 
 	tx_queue->tx_stat.pkts += num_tx;
 	tx_queue->tx_stat.bytes += tx_bytes;
-	tx_queue->tx_stat.err_pkts += i - num_tx;
 
 	return i;
 }
-- 
2.51.0

