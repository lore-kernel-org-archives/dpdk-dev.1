Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062C0FCC9AE
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 02:50:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1082640B9D;
	Tue, 10 Mar 2026 03:49:43 +0100 (CET)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49]) by mails.dpdk.org (Postfix) with ESMTP id 13C8440A6E
 for <dev@dpdk.org>; Tue, 10 Mar 2026 03:49:39 +0100 (CET)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-7d738fe814cso2658253a34.3
 for <dev@dpdk.org>; Mon, 09 Mar 2026 19:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773110978;
 x=1773715778; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8BWz+1HDX4Te0zgjn4oPVTzDBFfvbeL/ycSMs259YBM=;
 b=Zm1lLo6/5f3siTudzDSeyzelNMDWiISK8xbrptcURpsH0VsN7vxMbHNJ+s43tDwW3z
 fOa3JxkrRcKjbn/fsLTctWrszB7zNGYdBZGC1pBdvZ5SpStbzoOIKbansE6Y4dgacY+c
 y0NEEGk0k6hMWulSVV9+o4KNQOzjmP1YWUrw8wYcnGTy6DMzhIyskhkkiVPoVjEq28MN
 iv2MXe+il29/j7OFe+DyoURnb6sUg51ezcvhIdSHqgc0aGSaWQILxQVwvJunZzS2Ehv4
 jM6jr/XIORZAuIL4ZPTET1wl/CsZXD/gX17DSaYzYL5WY1ikyRV6P01rXpi/ARgjK95v
 ayEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773110978; x=1773715778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8BWz+1HDX4Te0zgjn4oPVTzDBFfvbeL/ycSMs259YBM=;
 b=m8ltX77OFPH/+tvr5Tgjpvxa5CV2d3C3uF35QZE0Ctli5yzZafbFjjMdI+wL14aXiD
 vnO5hO8Zw9bkGvZ/7gOWD5wMuRSj6dydbtCQHRsW2HSwVNV7X+WFxpZjXQuqY9iWtgu7
 i1a7M1WURxAXY8mfggWoaDFasNGpuC1Xx88dSBBEAlhzhWk8beWzE1FzDlvggr4lRZSu
 ge5iG624sxG3hB28ze4Q3aNVMwwuvRPaTYV14kQ6Qqcigq6RXXdOTRwyajoGDtr04lqV
 cvAfqDpc/b06OmsxxotP/sjFcFY6EhRFioWERtcSk/HlhJF8QKh9AaYXdzWs2TdGbXiQ
 py9A==
X-Gm-Message-State: AOJu0YwwvmekuhBCbRO0duzu2XtTdAcgxnCUFlIdx++4EXQ1Kezo+RuE
 LvS3Tm5H3/PPuDjOyWGJjZCGcxeTD0jR8RnzlSHDxz5oDX5eeDTy4DlZVV8H9qiZTTXvJfcKj53
 M6w7KBg4=
X-Gm-Gg: ATEYQzzs1LuaTV7nLPlIHeJH+cuYyQN8AvgIcampC4sB6fTBERUp1KjxZb7spaP8G7B
 2ND9teUHavyNeSXVl/C3ANGjvKwVrSbJi72lbiqSI3I2va06+D1Zk8TRyOhq0C93Rgwphz47o3z
 OlJp2PjZl+O+qXoaFPuNKvKMTRD3ep8/11vAmNxcVRf4DHEQ51fZWE46On7gzZvavghJancUZp9
 UeR4EzoZkeRuNp27YcSN17nszma4RZnCQPRgp6dWzSSsLjssaYiYXTcLPCNEBgGHrZiRWzCeI2r
 EBnigeKyKoLFTQZ0rPPpxrN5I9+z6tRBhWaSiiR0CqD25a9BB6zV7kIX2b4v9gpHPc8ISj6Txv/
 RBZxPhq8cRpnP97csE7yy3bIMIYIFvt6qoXVDIvkvIAFWYFhDDJ8bo/zNJoRpq7LeAlQW9+BprK
 6D1VWJQNte8vecPI5H3yRuJ++XrmWOLUxk
X-Received: by 2002:a05:6830:6683:b0:7d7:45b7:ed93 with SMTP id
 46e09a7af769-7d745b7eeb4mr4979776a34.15.1773110978348; 
 Mon, 09 Mar 2026 19:49:38 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728d1238csm7808572a34.15.2026.03.09.19.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 19:49:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 David Marchand <david.marchand@redhat.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v19 09/25] net/pcap: fix error accounting and backpressure on
 transmit
Date: Mon,  9 Mar 2026 19:47:44 -0700
Message-ID: <20260310024925.476543-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310024925.476543-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310024925.476543-1-stephen@networkplumber.org>
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

