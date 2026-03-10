Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6639AFD4F05
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 16:15:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B97640E4B;
	Tue, 10 Mar 2026 17:14:14 +0100 (CET)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48]) by mails.dpdk.org (Postfix) with ESMTP id 5E0C940E36
 for <dev@dpdk.org>; Tue, 10 Mar 2026 17:14:11 +0100 (CET)
Received: by mail-ot1-f48.google.com with SMTP id
 46e09a7af769-7d73d6976adso2237292a34.2
 for <dev@dpdk.org>; Tue, 10 Mar 2026 09:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773159250;
 x=1773764050; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8BWz+1HDX4Te0zgjn4oPVTzDBFfvbeL/ycSMs259YBM=;
 b=rLmbn7ZKIVt7HSUHxzSkVGkxqokODvm31TmaSkl2aDYoFFuqEZWWcSpnhvsWIRDbsd
 I+trLdcoYzORrVw7uBl3SrpaShjtezEb/1EsW9Mt4m85pEOuJYSyvFzrgf7V67fknPuz
 GizxKRmLYgmqHZebDbzAOmkiAfQA+dNc6oZyWf16gArSL3jbiBwNQR4Jz4RubxO96mVZ
 sOlo2xyAY50XV9MfL/NkLXhISvbAjpyBegjsEUmpky9E9C6WFhKDpqWV4DkvaD83a4m2
 HDCBQ7M3PThfTdUWfxpBfAZiEIHB0l681MGmrCrzM7E4cqdKbJVFoYC9mf91PxzpVYLu
 wsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159250; x=1773764050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8BWz+1HDX4Te0zgjn4oPVTzDBFfvbeL/ycSMs259YBM=;
 b=TiN+4V2Rnl/gFoJoFAPC//utCnOdOJYm/O9DwLrMiTQf4h/jlgTThmZegBGT0YvA9o
 8evDO24wxwOu3OxCOlDIMInZOs93gPDk/3MzGF1Z9kg4TPtZXTAuZivNDO100wZHnx+u
 Cs1YE9rPDppn8K8qbDM3pGX0g5e0J+vATQkDHA/SuoPl/lKmOG/Q+P/DFKTnko0n4BK9
 UH2AXw4dZl39qJTmTdya6JRSNxLqz8JywtRZkiN6XOmhqRZuxGvz5alprMVYq+jN7NDg
 0F+abxp5KtfgTi6gOM4nxSqHrAm6f66JPHTpuTdXwNsBz3HvEaoFlX7qfCqKCbPdAPT3
 9LYA==
X-Gm-Message-State: AOJu0YzSS9IghtLNU5eAEZzSrfUOo1EyCv9RZHQM3mbe6mLePXciAeAU
 KNHyQoR3rRwUm+4d7fA1vSwr3NUrngZKf7XUtH09ZJbohdYoQjNxJiu2OJ9OR+T/ENxSn1XSVOq
 u+h8XVT8=
X-Gm-Gg: ATEYQzxRFF1VtVOKLisHJcybEMIUG3VJDfajQz7kHeqIgEQ7m+1V/p7FyLrryr8TVQN
 53KdeJ8Rq+W2UYJSyVuirEnzzK4nDRmJL+dhhT9k9+N/I4fCehIrQrJZyDtxtioAcwPpcXVWijU
 IUFu+k6bwzp0pmq1qHIWvjCzKMNMRVIUZ1rzBq9arc+2+aCT4ExjxAVqysjykfc48Ea/MnpaCaf
 jdDQ8VNmwrsKBAKKsbWsvPI/zBqeA6mrg0Euy6O1q1GPHWiVpzAyntyB4JejM4jyoATkqTQeFLV
 Bn3r9uvjW1gtpLzt4PmHoPMuxD3SPb/NK7jAcynExIYxbyfoAHDxvaPIOwC7hSyXBlFH8q4ji4I
 96LVtTHWf0TNV9nkOa4g8A40AErE6ywPkfhhi4vfT2hHLvGwdAJKhLJ3BBOKvNIbBndyNgrXMZA
 MpZ3nW+gtUEnWvL+xbIh5b1fMZKssRMm6a
X-Received: by 2002:a9d:630d:0:b0:7d7:4009:1ad with SMTP id
 46e09a7af769-7d740090acemr4431394a34.2.1773159250667; 
 Tue, 10 Mar 2026 09:14:10 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d738e3f421sm7304004a34.25.2026.03.10.09.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:14:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 David Marchand <david.marchand@redhat.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v20 09/25] net/pcap: fix error accounting and backpressure on
 transmit
Date: Tue, 10 Mar 2026 09:09:47 -0700
Message-ID: <20260310161356.194553-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310161356.194553-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
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

On Linux, pcap_sendpacket() calls send() on a blocking PF_PACKET
socket with default kernel buffer sizes and no TX ring (PACKET_TX_RING).
The send() call only blocks when the kernel socket send buffer is full,
providing limited backpressure. Backpressure is not an error.

Fixes: fbbbf553f268 ("net/pcap: fix concurrent multiseg Tx")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 58 +++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 72a297d423..47a050df11 100644
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
@@ -415,15 +416,16 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		calculate_timestamp(&header.ts);
 		header.len = len;
 		header.caplen = caplen;
-		/* rte_pktmbuf_read() returns a pointer to the data directly
-		 * in the mbuf (when the mbuf is contiguous) or, otherwise,
-		 * a pointer to temp_data after copying into it.
-		 */
-		pcap_dump((u_char *)dumper, &header,
-			rte_pktmbuf_read(mbuf, 0, caplen, temp_data));
+
+		data = rte_pktmbuf_read(mbuf, 0, caplen, temp_data);
+
+		/* This could only happen if mbuf is bogus pkt_len > data_len */
+		RTE_ASSERT(data != NULL);
+		pcap_dump((u_char *)dumper, &header, data);
 
 		num_tx++;
 		tx_bytes += caplen;
+
 		rte_pktmbuf_free(mbuf);
 	}
 
@@ -435,9 +437,8 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	pcap_dump_flush(dumper);
 	dumper_q->tx_stat.pkts += num_tx;
 	dumper_q->tx_stat.bytes += tx_bytes;
-	dumper_q->tx_stat.err_pkts += nb_pkts - num_tx;
 
-	return nb_pkts;
+	return i;
 }
 
 /*
@@ -462,7 +463,17 @@ eth_tx_drop(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
@@ -484,34 +495,37 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
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
+		data = rte_pktmbuf_read(mbuf, 0, len, temp_data);
+		RTE_ASSERT(data != NULL);
+
+		/*
+		 * No good way to separate back pressure from failure here
+		 * Assume it is EBUSY, ENOMEM, or EINTR, something that can be retried.
 		 */
-		ret = pcap_sendpacket(pcap,
-			rte_pktmbuf_read(mbuf, 0, len, temp_data), len);
-		if (unlikely(ret != 0))
+		if (pcap_sendpacket(pcap, data, len) != 0) {
+			PMD_LOG(ERR, "pcap_sendpacket() failed: %s", pcap_geterr(pcap));
 			break;
+		}
 		num_tx++;
 		tx_bytes += len;
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

