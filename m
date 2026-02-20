Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F6FC54EFC
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:49:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32B3D406B4;
	Fri, 20 Feb 2026 06:48:52 +0100 (CET)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id 8283840678
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:48:48 +0100 (CET)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-896fa834290so19587236d6.1
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771566528;
 x=1772171328; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FX3nZFBP3EJDtIuZL8I+GEgURZS6cCmm2/u5sMmB3kE=;
 b=jONxfdViyu3zu3LCVB76Lum8ZYBvkqCdZlZLVPn1zCGxpm2K4bNjHwPNODPubx+VLv
 xbv2WfY6N4qKfamAjRvs8+xa53T2/kVlVvQ3BBhLJq1T+MCSYkiyqqAI7gyVnWx3tI9c
 OTS/cKpLCfJy/maFZNMbA25ErvioorvnkP9smDl510m8EmvYuTOnD0F/1kfe5LxtDscF
 rjsjIWDFQpwxGxqVhIA8oIePdx9nM+dyxL6Mnew+qHi72Rt5q4wHutU280wRgxqrAVk8
 fYAA8M1soS/stc0gi/76dUQw2jA5jQJH5Vj5soA38Qyzh1//yiYjYZslAWbjkgA1i5WL
 hkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771566528; x=1772171328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FX3nZFBP3EJDtIuZL8I+GEgURZS6cCmm2/u5sMmB3kE=;
 b=uPM+9TbNgDuddYCpCOkHqnxfSy7Aij2SjfXzsxzvRVS9E/avQ3noUN4nEWIFY5K0Dv
 nRBiaUqn/5UVvjmBdNlUmVH0t/xgtltIC9frCB/oQsB39W5LDByspxQKHiuhhCC5gSD1
 2PEO/xMJ9AnHS7VPfFNHy3T+Wn3K2Y0s0DPz9ksDrpMzk29azfn6ApWuPwyak8vRtDzn
 lK+9la72n/eAhlYdZ0Y+lW05bsVmEyS83S41+TOizDqIohTcB3yPaIi0xQOlH8gPLCJn
 +962tvEbloKECMdkF6cb8KMj2qaAFm3eybA4moQfspZZj6N/xw/uZeE24a6/9haAAaKb
 tZvQ==
X-Gm-Message-State: AOJu0Yz2hbGfW49qvxuqVJQ9O1OwIsNOsEZVqVbk/SzFdSyz5uzdlEe/
 P8CnxCB5cmHCXk3QtcV0ZRCQybDbdf06pGHrBG5L+ZobcGbi3HvtL20j3R7xy+hL5QkgwQbE70M
 lM6Lt
X-Gm-Gg: AZuq6aL+1zzu0LNe4GtwYdmSpRSIMyLUgOJCpIDxWOgykUHTKZppRnAxgKUCBEN22Mu
 uYdkfF1Cev3YYPCnSO5DPrbLjPUb1r6YxKCt2pKST2WN/XUamIAfrvQhm/GyqsyI+CBZNRPQE/d
 5NcD3UgidFkTOM4Tbd57lP3HLsBPUEupyXd57g8fC6JaDDofJsWg8cqjnEbLkzY8wFQXmmhe6ul
 Xjr08oci4ss6TExGeFHkzu8cSLs+BxeeXwxj3Okg7YH22CZ90wfTZrc7wpSXV0dQiknIsTqIMrJ
 el0PEZTzWkd8GIvOG9y8ft9QgmuOBaTLEqEXciu4AerLQuWdjBhR3BuNL+lDuiT3hExmZfV2Bdu
 dPX8u40cB0Z7J5ppImemMZNkqEK3uzIZ9Q5EHy+KUiI5BQ23srt/xopACoVELqGvzwx+yX+Bd2v
 RGiFSxK50ZHJm2G3sLAPh703c9NUlRzM44yFAAOn6oF/KQns7XXb8fGdXjDvJD9g==
X-Received: by 2002:ad4:5ded:0:b0:895:4aee:ac8d with SMTP id
 6a1803df08f44-89965b45016mr57951956d6.21.1771566527804; 
 Thu, 19 Feb 2026 21:48:47 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cdad6c1sm229078096d6.39.2026.02.19.21.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:48:47 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v17 09/23] net/pcap: fix error accounting and backpressure on
 transmit
Date: Thu, 19 Feb 2026 21:45:44 -0800
Message-ID: <20260220054834.1632201-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220054834.1632201-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260220054834.1632201-1-stephen@networkplumber.org>
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
index 4cf5319839..1ab5b1755c 100644
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
 
@@ -434,9 +439,8 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	pcap_dump_flush(dumper);
 	dumper_q->tx_stat.pkts += num_tx;
 	dumper_q->tx_stat.bytes += tx_bytes;
-	dumper_q->tx_stat.err_pkts += nb_pkts - num_tx;
 
-	return nb_pkts;
+	return i;
 }
 
 /*
@@ -461,7 +465,17 @@ eth_tx_drop(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
@@ -483,34 +497,41 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
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

