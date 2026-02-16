Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D02E83822
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 18:15:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C03264067A;
	Mon, 16 Feb 2026 19:14:26 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id F14EE4069F
 for <dev@dpdk.org>; Mon, 16 Feb 2026 19:14:23 +0100 (CET)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-43626796202so3197318f8f.3
 for <dev@dpdk.org>; Mon, 16 Feb 2026 10:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771265663;
 x=1771870463; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7+MtiTaSR9URI4r/Xa8V5rdkgf4avYXNU8nIHltFkY=;
 b=Yd/6CVAMRXF6w8FUJcHJWKQ/SW/9ears7NRp3XZKWz7398974So59hBfqafVt+do/s
 ijOCFCrgWJScaX+W/+XYrLkAftA+Q+JmyN5/kuT5rIz0AaqkWwSAse3U7eXvIfviecQE
 75z5GwfcXpUICxUbdzJmBtatX+xkpDFVuJT+aTFKUO+4ObuKFWAJt6mJjSujSZrYsFWs
 80mADnv+Kn2RS0aH8kuFLQfuxES8WbR7t3eD+wcmDwcqR4h7OcH8gDBSGvS1eXn5YGNP
 zFZYaXg4ugnVAMcXqpoAk9LGjnHqTyK6dLQjfeTCNhQo88yNJ5P4BQUmkvfeX0h9r262
 6Exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771265663; x=1771870463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W7+MtiTaSR9URI4r/Xa8V5rdkgf4avYXNU8nIHltFkY=;
 b=P0vYwvkhqr10XtlXdo2ZQ370xeXmVOV+KFiQOlpKZ5kfL5/lyQL6KYHgk0QisnlM+T
 cL7AzhyVJE5ZCPrYCo9ipk8jhYOIEY3iQFbkdxROjnD6Gh6pbCNf+NrpGzas9zeWtKMq
 7uYvVliKXUo9jINl0rEsvC/eK5FXfUGv2PUPgKeOiyKMgJrV6nt08077Sd1rjHEuiZki
 Fm4YNIrNekvUZb03jFljm6D9i173uwySOqlLC9v2MD8jVsmdLz4nsP0z/CHPm/Ff6nrP
 Tjzg2rnG6iBjBQmu1oOtYSt5C1bs0f8SiNn8LJr+nAu8DHE7MKFpDlfUS/ncWnl/3Ac6
 K+NQ==
X-Gm-Message-State: AOJu0YxjnC0BI66bg2SwhSneJtbTqDQdMPS+1vnKhwykAUMDWHaPPEi1
 I9G+HUeUpQky/nrrG6+3SQrSsDjJDb/kcwN5Qtqzfw79B1cJLGAdZasgHtXpQ1o+U5QyBL41ZBo
 yKgGKxpY=
X-Gm-Gg: AZuq6aKvDBRaaSvn2XvsEslOf3bZ1E3WhZVA4es06P0B4dJsoymNFI4+z/PwYJeqo+W
 vv23czh/oKRGbf3ELMi6k2ytqTKBSi5KeKDpRMYVCKhsEmbnUjgj97jJ98AP6mNZvKkAFGVDOeA
 l3W6xuAJ+cE03bHIM2FOp18mW6eLZVB/wmFtWqXNj8S0cUhGo18hc/JGD2uF8hl1H23QNtGdDzP
 3ewbeRMAOVW2iJtOrWF/WbrbtJFgjH8Kj2xLNvDrXGUJSbYALKO7n7JoEBu/hqyRSD69ZCnGFnV
 3d+fw8fnSkgkxu9Ljj6IZKE9Dy05XMNp2gIBo55yHxJkRcTB5+fohT1TAVKzSx6UreBHpmwjKJK
 G7kIO0XxyKuV7t7kfHwVadrNSvQkIKrMI86QVCrgduCUP7U1BuM646qWpmh4P5zQrNjlRlhvc1n
 xGDxV5hjQL9cedkpCtVl3L73UwOE9+/f/k9K2LHTpFa0ycp7YXpuVt6Xg76/Ow0g==
X-Received: by 2002:a05:6000:2382:b0:437:7168:af5f with SMTP id
 ffacd0b85a97d-43797941468mr18842603f8f.49.1771265663430; 
 Mon, 16 Feb 2026 10:14:23 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796acffcesm26064725f8f.37.2026.02.16.10.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 10:14:23 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v16 08/21] net/pcap: fix error accounting and backpressure on
 transmit
Date: Mon, 16 Feb 2026 10:12:03 -0800
Message-ID: <20260216181407.428877-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216181407.428877-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260216181407.428877-1-stephen@networkplumber.org>
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

Fix error accounting: backpressure from pcap_sendpacket() (kernel
socket buffer full) was incorrectly counted as errors. Malformed
multi-segment mbufs where pkt_len exceeds actual data were silently
accepted; they are now detected via rte_pktmbuf_read() failure
and counted as errors.

On Linux, pcap_sendpacket() calls send() on a blocking PF_PACKET
socket with default kernel buffer sizes and no TX ring (PACKET_TX_RING).
The send() call only blocks when the kernel socket send buffer is full,
providing limited backpressure. Backpressure is not an error.

Fixes: fbbbf553f268 ("net/pcap: fix concurrent multiseg Tx")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 71 +++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 26 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 4cf5319839..42c5a37177 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -407,22 +407,27 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	 * dumper */
 	for (i = 0; i < nb_pkts; i++) {
 		struct rte_mbuf *mbuf = bufs[i];
-		size_t len, caplen;
+		uint32_t len, caplen;
+		const uint8_t *data;
 
 		len = caplen = rte_pktmbuf_pkt_len(mbuf);
 
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
 
@@ -461,7 +466,17 @@ eth_tx_drop(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
@@ -483,34 +498,38 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
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
+			/* Unfortunately, libpcap collapses transient (-EBUSY) and hard errors. */
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

