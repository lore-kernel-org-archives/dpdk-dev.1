Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121ABEA719A
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Apr 2026 16:12:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 018D840696;
	Sun, 19 Apr 2026 18:11:20 +0200 (CEST)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com
 [209.85.161.53]) by mails.dpdk.org (Postfix) with ESMTP id F08B540654
 for <dev@dpdk.org>; Sun, 19 Apr 2026 18:11:16 +0200 (CEST)
Received: by mail-oo1-f53.google.com with SMTP id
 006d021491bc7-689e6737446so1195964eaf.1
 for <dev@dpdk.org>; Sun, 19 Apr 2026 09:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776615076;
 x=1777219876; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U8qlHnaWL3xA7pIAnsegSiJnseUdbksPPijuwVzzW1s=;
 b=JddTF/d8ChYYa7K3LDXseSCPFApIjG1jw+34OMmtPTlLI1a4MX98AhcrOBfUxskZvy
 1q/i+L3rxa15LHeIVgMV0ICmwlwxtybvirBja6Bv7RSDpgo+N2MJjM4XkDxS5b2FmJSS
 lYxeA7jw6sx0GnhdHIbZKkd9uh9RaGqBzh7TP4zMb85KgGYi0aUTNggzy5/8qFXkYASa
 r2dQ9y7snme0pcU9hcqpeUIXK/aUiPOFaTgAgzUyZM/T7gMuEAuQ14Uq7EKYOGB8IkFs
 3W+sWBYBGZisIueSSeaSkctPmU64xK+qWqZuAZKsFoPQiumQUSP15ZNmldEU/9G9bmTG
 CUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776615076; x=1777219876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U8qlHnaWL3xA7pIAnsegSiJnseUdbksPPijuwVzzW1s=;
 b=tAFdHwE7l/a0aPmxDWlUUw3CNzRNPmXCPu6A85/7gxcYAyXoqNqQ1TDK4ExN5/IPWS
 /wprM1UBrSWk+xEdnSb5FCmMOJ06f0CvRe8g5Wawg3iVpd3QGYC6tvVvw9QYu02rl5nn
 iwVcEh8k17d/2rtHaB2tBRhXD/EfG9UwoTxD7AM7tNd+apVEoZbN6Q08VrI1j4IMZTtd
 9iiel8p6ClpGygbt8BVArmNn8vxaMfQCnRlqlZ6zZeb8Dt3b75IOng4lyLb/4VH/MxBi
 jwJpFKgams0UHmIiVqjWbWrxGIba4jkwvoUlNn2FssSIqt9me9X/worDYlJprz7sB/K1
 VhYg==
X-Gm-Message-State: AOJu0YxkPpmic5HwyI78HMuQdcaU7vF8OWx49A6iomCkr7LgOtniII1O
 r+ez8PvSKXlYHN3GklNP9MZJVxMZzwWYFY+pd36ezXxYOmSs/KbApftOVS9erhH6n6yoHMCZkB9
 xoXPY
X-Gm-Gg: AeBDieuw3aIcYETO968Nbky98qN7MSt8aiOwLGZh3+oZCAlDIlUWjXvF0Ph9ZegqrMq
 NXhDyjV7EoEzW5nrYPsJmyRD3ZubeQdZz1qEQEDvRgtnRrcTQGrI7VjzlwcCbLOpiqd7/VD4P2a
 NHKvpzTNKj56V9qD/FmrzGc8hvY7qY/63tPZX7m5dT6aFw3N++eLdxx17llu0mWc4B8GgKo0CdD
 sLTtXZurphNQos6xNdBtwGG2TLSjmBWrM2flEP6FhY2Ai/ecbiGBht1oKWABpD+fF6pOlj+l/2b
 s/DxRz7J+7cznmYLTq4ujMumA3r8fS8A6VDDPhLrMOM6NO34AK7bGU90WgJ5gO1C97Go9R005L+
 +wbNZswdwHfgaxHAOjAL68ZdQ9S7AKTw0QeQIvnOBHrMJYLpPCD3ONfJqp3gvD4N6+t44iUrXDS
 r3NCZITzMmS63DiH+1LhN0ckUssaqy/vRrvxufQEOxsqc=
X-Received: by 2002:a05:6820:1888:b0:67f:ab5d:1748 with SMTP id
 006d021491bc7-69462f08433mr5669645eaf.48.1776615076252; 
 Sun, 19 Apr 2026 09:11:16 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b930bca47sm5970632fac.7.2026.04.19.09.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 09:11:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v25 09/24] net/pcap: fix error accounting and backpressure on
 transmit
Date: Sun, 19 Apr 2026 09:09:42 -0700
Message-ID: <20260419161059.205954-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419161059.205954-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260419161059.205954-1-stephen@networkplumber.org>
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

