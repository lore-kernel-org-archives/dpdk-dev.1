Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FFFF8D766
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:52:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87E1540BA2;
	Thu, 16 Apr 2026 20:52:01 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id 98160406B7
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:51:57 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2d832f2f44cso6054906eec.0
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365517;
 x=1776970317; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U8qlHnaWL3xA7pIAnsegSiJnseUdbksPPijuwVzzW1s=;
 b=UWQ/4C0mfgnD4G5/xgf1ga3BY/ZoI4pkMZfBy204WK95sgjP/bmGXY5EommMU/iIQi
 Wk2TU/2l+6lHurNUCD59RHZtQH+vAFuiaSCcEkS4Yv2ySm9B3iwH79/aq2XOO2hSEOnS
 4C1Jl9W/UBUsOb4SGWwRMpJ/8E0ut4PS4r36MRCqY46gM/7PAFwUMwQDovtDk2+h1pAS
 v4xPo+Y2cHkf1zBGd8X5A6hhnh765UkAZ6BpgBxoh9g8vM72jj5JoQIghBF/65abdtpR
 81XHj4NQmbsxcUoQIvNdpRTmuaHcZ8uc0o3iYlVeCFNA+k6mo4j21tQJ4ZjBab2nViXX
 P9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365517; x=1776970317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U8qlHnaWL3xA7pIAnsegSiJnseUdbksPPijuwVzzW1s=;
 b=Qmpxa/530mXybyfiQdUcydZUK8rgNxSjt/k/1BBR63gETm3GpIitSAJo2cxG69soeM
 NqX/ob7shVdpQuTY5LwXL+tddWtqiUBrm6CXxwL2VVn3UucBCiuUE4874vIFQ/8vqR+k
 YcPQapwPwfFgUu1rQ31qbh8MOT9A8eTK0FoQcEbGmRV3g5gUci1GqUcyIrvhampIyUQ9
 tzHeQhT0nwD3EaTjnwsS3FQBRJRiPK3S+PPr4Z9QGOc0E3WpSiHf0mlizBpT7F4Wx/7/
 YthArnrRqq6fydlRMivYqRN3vugYm/hYPmVsdJ8B/656d9a/7yeyCthG0xFvbn/7lK3c
 tAyw==
X-Gm-Message-State: AOJu0YxTedfv8TRds7Z0S1dBmEQM6A9SIvlYCJo9P8mLABCVSonunKHA
 BA6obK1M40IGzGm2IFpT3HNTM8Ed4EngsSxYQScO0yDNoXtmdBzt8xSdrEgfrEq6Muh9VuXEnkD
 8jXjG
X-Gm-Gg: AeBDievoIWZsmWOoSEMf1vIxryzt1Aejoj5aAza7j4w1piRc+2odxBdOJ3JgxVazIhD
 aSkKC+S1d5/O4BN4YbB9YSCXcJLH/jKkB1lT7/fz2WKGC7hSQzdeeEfG2Rc7UGQyp1k6rguLqFI
 jMoacr2WFjRqB28pUeIVLwudLxyT9rIdU7ALyRSc8+hw7CL2Vn6f8+R4mtxiDPg0VOhBZMnskwv
 t9wBpvG4udxwZvUmOcsYXsUKJt4VbtBezqOocw3sBcDGraWg6Qldl8FeOBQJ3x2852RMSJ3E83S
 YVQepp2TJ+aBf9bbswMv4B8Lk/s5HpmH9OXOkbE5nrd4coFMWhg/PPv+rSCKbv2wmeu1DDMT1Ah
 k66gemsDXUHOoXrNsk0WdfPQh67V0s3Y/JtHaTzEO7BszU2IQf8uhcb4DS+MzYCEs975fUlcZf5
 0vrq0HXgEGwh2GSPj/oqbpLlgxlQWjy3WUH5EV3u89xoI=
X-Received: by 2002:a05:7300:861e:b0:2c7:5a7b:e8c0 with SMTP id
 5a478bee46e88-2e2e3b68c33mr246936eec.12.1776365516611; 
 Thu, 16 Apr 2026 11:51:56 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8f6615d5sm10602510eec.24.2026.04.16.11.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:51:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 David Marchand <david.marchand@redhat.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v24 09/24] net/pcap: fix error accounting and backpressure on
 transmit
Date: Thu, 16 Apr 2026 11:48:26 -0700
Message-ID: <20260416185144.1359260-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416185144.1359260-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260416185144.1359260-1-stephen@networkplumber.org>
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

Fix two problems in eth_pcap_tx():

Oversized multi-segment packets that exceed the bounce buffer are
dropped but were not counted as errors. Add err_pkts accounting
for these drops.

When pcap_sendpacket() fails due to kernel socket backpressure,
the remaining unsent packets were counted as TX errors. Since
backpressure is transient (EAGAIN/EBUSY/EINTR), break the loop
and return the number of packets attempted so the caller retains
ownership of the unsent mbufs per tx_burst semantics.

Fixes: fbbbf553f268 ("net/pcap: fix concurrent multiseg Tx")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 02d5cb591f..ca08b8e342 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -462,7 +462,17 @@ eth_tx_drop(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
@@ -484,26 +494,27 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 	for (i = 0; i < nb_pkts; i++) {
 		struct rte_mbuf *mbuf = bufs[i];
-		size_t len = rte_pktmbuf_pkt_len(mbuf);
-		int ret;
+		uint32_t len = rte_pktmbuf_pkt_len(mbuf);
+		const uint8_t *data;
 
 		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) &&
 				len > RTE_ETH_PCAP_SNAPSHOT_LEN)) {
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
+		data = rte_pktmbuf_read(mbuf, 0, len, temp_data);
+		RTE_ASSERT(data != NULL);
+
+		if (unlikely(pcap_sendpacket(pcap, data, len) != 0)) {
+			/* Assume failure is backpressure */
+			PMD_LOG(ERR, "pcap_sendpacket() failed: %s", pcap_geterr(pcap));
 			break;
+		}
 		num_tx++;
 		tx_bytes += len;
 		rte_pktmbuf_free(mbuf);
@@ -511,7 +522,6 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 	tx_queue->tx_stat.pkts += num_tx;
 	tx_queue->tx_stat.bytes += tx_bytes;
-	tx_queue->tx_stat.err_pkts += i - num_tx;
 
 	return i;
 }
-- 
2.53.0

