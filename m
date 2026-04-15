Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C363CF43828
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 14:49:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99E3C40A6C;
	Wed, 15 Apr 2026 16:48:22 +0200 (CEST)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by mails.dpdk.org (Postfix) with ESMTP id C127F4069F
 for <dev@dpdk.org>; Wed, 15 Apr 2026 16:48:20 +0200 (CEST)
Received: by mail-oi1-f174.google.com with SMTP id
 5614622812f47-47018d34159so4995407b6e.2
 for <dev@dpdk.org>; Wed, 15 Apr 2026 07:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776264500;
 x=1776869300; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U8qlHnaWL3xA7pIAnsegSiJnseUdbksPPijuwVzzW1s=;
 b=KCwM8VssYoWNvTor7aG+TvEwKGCc/SdLnomot0GTzABi7rK5J/N8t3GIdE5OjmHc/+
 4RbAKQxkRT8ejS4Xc5YEwKgdGzYIGevLRfvWBQSMqFi9jqFF1ZWPToH9CkkUBl5DA3DV
 9cKPvhpTy7a+gVMYleeO7j4oTDtr3/8PRssVWrp9njWhvAK3vPuWB3JJKfJWkTKXnhdK
 eAl1g2s6IcaCqbCLpArOcKvJJKcf9Kut+Qs3t9OAome8f9LlMjw40qbGVUQPrG27rbHn
 tkp2liMBLS9QMdjJb9NELdQmnA9uRPryFgWmK9KgjrU4LSY9jgRmVPh9ziLwzTaMvvNc
 O0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776264500; x=1776869300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U8qlHnaWL3xA7pIAnsegSiJnseUdbksPPijuwVzzW1s=;
 b=ax227kCACeDv0buqOJyyNBFI3C4/YcAhOtFHFYzvzh265aLx6oBCV/itnVy3cd3cJK
 C+Q0Z6P3u1e5K07I+s94khgxyNzgYdet06559NU3A3l4jZmWKOOzlZ+V9ou0Otcqaem+
 Z7M7HmXSThI3qdqJvkj/Kmfn4tiYl39i3SIiJ4PklJ0IWc/S+y1NIP9KbBJf+aLVJUQ+
 HgWF3PBWSkpbjPWUwmPsLPkRwcF10mqWw4f8wk1yz+aXyaCSZL0WXSH2aPN0nlQE1SQo
 744QoPuwyroIPy84JCvf22Z8ETCAoF0FYGmfHNj8DNmogHSj4rp30Ms6kftOv6fwwyu1
 OqVA==
X-Gm-Message-State: AOJu0YzhBOmAOKXDvQj/vdCZG93GEZE90+4ktGOAMj00TCWh4i54WIBS
 qABA1OFLRq5Tfg1RwGPo3UNth56ehR3gcqcqBPzKxrShhNiR/txFBLCvIDfSKeEFOUABFzz4RCI
 imjzP
X-Gm-Gg: AeBDieuhkr3B0744LMrgcSYshD8IX/3IJNJRspx3AsD8tLDdsNcprcu0q8XUSeTnkcO
 agNnWL9gaExnWLKna13HNWIaEWnusjY5msuZLpLsEEIwzZchrtrTqtXQdBDIhx8LC4PRMLRzrpA
 K+9uAaggA+yLZAP6FuY9eUT79wG/mGOlfV4UTY4/QoDVjKhBRRRkz7MnTURO/HJEvMJldkYbM5P
 knjK65iS5WzlGr1comtn5tY/rFb2l+LlR9zprpSzSEW/FlSlX8jIwwpgHT4/Ye02TFF0KDUKpSK
 FHF96lNmOxktycax2uNYPa+8njHS9X5d9Tfy4/z8GMFEzfh4QLR+ivIzoFf8Td7wh/lF+UCZfky
 r1t7DCVnRZjvjK+UhqzARNFimlJYDiotGzdMbfXeRj7IQCE/ioU4t3ZYw1U216ZO7b5ICvzHvdj
 o1v/VWCAeFoFizkiJK5WMW6qg6AFqkbpxAtceMhbYI6QU=
X-Received: by 2002:a05:6808:191b:b0:467:db7f:ab8b with SMTP id
 5614622812f47-4789d1503admr11578307b6e.19.1776264500036; 
 Wed, 15 Apr 2026 07:48:20 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4797a53b1fesm945798b6e.16.2026.04.15.07.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 07:48:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v23 09/24] net/pcap: fix error accounting and backpressure on
 transmit
Date: Wed, 15 Apr 2026 07:45:58 -0700
Message-ID: <20260415144717.226161-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415144717.226161-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260415144717.226161-1-stephen@networkplumber.org>
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

