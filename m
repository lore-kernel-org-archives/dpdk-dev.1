Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC8DE6BF30
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 17:36:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA61940697;
	Fri, 30 Jan 2026 18:35:25 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 3505340672
 for <dev@dpdk.org>; Fri, 30 Jan 2026 18:35:15 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-48069a48629so24429015e9.0
 for <dev@dpdk.org>; Fri, 30 Jan 2026 09:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769794515;
 x=1770399315; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f7wQB/hUSmH/67rxXuXeCj2oQXqVVfcd2EtfIjOgwrA=;
 b=vUR7kVsQKTb/9WxkwA8BlfeJ/CcLHANu0wNn7bcr7Xgpt0n2CQeRHLLLyxeuWUiqZH
 gK4uSvZDg/RwoiRdmC89Co5o7Wv2aFD1nsIOKy2VGvoh2UIB84+qBdgwAG5zcRt5IbXr
 mpJ0WSt9D9J4nJnBqY+vA3D97ABrG7/qAGiCU9OZV9baWS75Bs8wHIiOeQNKwKPS+P2g
 jJpD6Ipx/nZOMSbap5IOYt8NhNp/oxr7pAFfnxFeOsk0NagczuHnu/tjQmlpakwEP7kB
 MIQemvoB5lxBBWQhwbUj6pzuGMQbYD6zEdjvoX45LZlqWUPx5vmalsz5/xCOQCUMitId
 fKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769794515; x=1770399315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f7wQB/hUSmH/67rxXuXeCj2oQXqVVfcd2EtfIjOgwrA=;
 b=MTNtfFgrqWrJTmBGmow7dHnewpA2PF56KPyjDluGT6yn2aMOBP8abqi2y9OU/pw+rW
 eQ+joZbgn22A51GAJ3Yv7B/pY8RhXjPwJTNBIDs30AaUowaNr7Igq1XGQABwZzOZd9Nt
 B+4NQ28mX8RsKJv0UbkasmmkOQxMyy5enDkgGkrL9T4zMyl3+TKjbplq7KrjnIDE4PUu
 Wbl3Oya73AYdvlnuc7C+UDFsqjok3Q/0Q6KkxpdmRHLZPFHZH3pGNuxnJFhwXl4B0N6+
 TXsfBLGgCj1kaQ3nvrifDTEZgYxvLVzuxw6dWtp02fSyQ6/drT1F0S8kXo6QgYNTiU8C
 0lBA==
X-Gm-Message-State: AOJu0Yy8d5Vl+u/qR2r8WZMiBIj8bOYjJtqwmXc4Wq+b4lz4zO+UlybW
 YpzwRuLDenDvj0FZKnPdDHSUka1hMOneEnN1PwxNoFRW+wwMHM1MVv/wCXyjKH7+KkteTdUMIWZ
 TpE9f
X-Gm-Gg: AZuq6aKAgh9du4jhWHu3aZCmrcnJPvIDOZ8aZk4PD3AnnuWlZyvfkHFEHDZ1DTL0nIJ
 V7ACtCdRMZLU076OG/AS6WxzTMb3/Ta5v8qvttxDPJPCYeiyBWuyTKWP2LPw4AwF/7xNn5GeoJA
 E5oT9P2xpgtfIuLnqGAN8ckDv4Kg7dVDGBDg6PrDCPqLwU5tYvhjukuuvufar/W5aRb7zlZ+VTI
 6azfml5J4pclYSe8UU/e27P93n1jfBPGb+yDKOb1sCYx4OnaJutnEH9WIz5P+dLHGUMzFCyH2KU
 kHXuNUHNKMS1T0qj1dyZkyL2SJZJmvFl8cdqZzdZO5JyjvBOBEaVNW/MEspzOoDooTwuswDY09F
 TtOvXyF2ixmLotQF4JarwkiL67DaXJSU+x9sw6LKIVeIerXtLGRQFjRZf48R6GLJtR+UCLJoYFc
 8A0sb/2CZLUmYksgN6dzmcpOzlBTl+W2FOF/n+MlOFGg4x9CdntT7VYUmdrnDq
X-Received: by 2002:a05:600c:c16d:b0:477:63b5:7148 with SMTP id
 5b1f17b1804b1-482db44d22dmr50422605e9.6.1769794514648; 
 Fri, 30 Jan 2026 09:35:14 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm201085325e9.12.2026.01.30.09.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 09:35:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v11 11/19] net/pcap: support VLAN insert and strip
Date: Fri, 30 Jan 2026 09:33:24 -0800
Message-ID: <20260130173447.14546-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130173447.14546-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130173447.14546-1-stephen@networkplumber.org>
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

Driver can easily insert VLAN tag strip and insertion similar
to how it is handled in virtio and af_packet.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/pcap.ini      |  1 +
 doc/guides/nics/pcap_ring.rst          | 11 +++++++++
 doc/guides/rel_notes/release_26_03.rst |  4 ++++
 drivers/net/pcap/pcap_ethdev.c         | 31 ++++++++++++++++++++++++--
 4 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index b0dac3cca7..814bc2119f 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -10,6 +10,7 @@ Scattered Rx         = Y
 Timestamp offload    = Y
 Basic stats          = Y
 Stats per queue      = Y
+VLAN offload         = Y
 Multiprocess aware   = Y
 FreeBSD              = Y
 Linux                = Y
diff --git a/doc/guides/nics/pcap_ring.rst b/doc/guides/nics/pcap_ring.rst
index 6955e91130..c005786ce3 100644
--- a/doc/guides/nics/pcap_ring.rst
+++ b/doc/guides/nics/pcap_ring.rst
@@ -213,6 +213,17 @@ Otherwise, the first 512 packets from the input pcap file will be discarded by t
    an error if interface is down, and the PMD itself won't change the status
    of the external network interface.
 
+Features and Limitations
+^^^^^^^^^^^^^^^^^^^^^^^^
+
+*  The PMD will re-insert the VLAN tag transparently to the packet if the kernel
+   strips it, as long as the ``RTE_ETH_RX_OFFLOAD_VLAN_STRIP`` is not enabled by the
+   application.
+
+*  The PMD will transparently insert a VLAN tag to transmitted packets if
+   ``RTE_ETH_TX_OFFLOAD_VLAN_INSERT`` is enabled and the mbuf has ``RTE_MBUF_F_TX_VLAN``
+   set.
+
 
 Rings-based PMD
 ~~~~~~~~~~~~~~~
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 15dabee7a1..7993ce2ee0 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -55,6 +55,10 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated PCAP ethernet driver.**
+
+  * Added support for VLAN insertion and stripping.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 201eb97745..b19e837b97 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -77,6 +77,7 @@ struct queue_missed_stat {
 struct pcap_rx_queue {
 	uint16_t port_id;
 	uint16_t queue_id;
+	bool vlan_strip;
 	struct rte_mempool *mb_pool;
 	struct queue_stat rx_stat;
 	struct queue_missed_stat missed_stat;
@@ -107,6 +108,7 @@ struct pmd_internals {
 	bool single_iface;
 	bool phy_mac;
 	bool infinite_rx;
+	bool vlan_strip;
 };
 
 struct pmd_process_private {
@@ -337,6 +339,10 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		}
 
 		mbuf->pkt_len = len;
+
+		if (pcap_q->vlan_strip)
+			rte_vlan_strip(mbuf);
+
 		uint64_t us = (uint64_t)header->ts.tv_sec * US_PER_S + header->ts.tv_usec;
 
 		*RTE_MBUF_DYNFIELD(mbuf, timestamp_dynfield_offset, rte_mbuf_timestamp_t *) = us;
@@ -412,9 +418,16 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		uint32_t len, caplen;
 		const uint8_t *data;
 
+		if (mbuf->ol_flags & RTE_MBUF_F_TX_VLAN) {
+			/* if vlan insert fails treat it as error */
+			if (unlikely(rte_vlan_insert(&mbuf) != 0))
+				continue;
+		}
+
 		len = caplen = rte_pktmbuf_pkt_len(mbuf);
 
 		calculate_timestamp(&header.ts);
+
 		header.len = len;
 		header.caplen = caplen;
 
@@ -487,6 +500,12 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		uint32_t len = rte_pktmbuf_pkt_len(mbuf);
 		const uint8_t *data;
 
+		if (mbuf->ol_flags & RTE_MBUF_F_TX_VLAN) {
+			/* if vlan insert fails treat it as error */
+			if (unlikely(rte_vlan_insert(&mbuf) != 0))
+				continue;
+		}
+
 		data = rte_pktmbuf_read(mbuf, 0, len, temp_data);
 		if (likely(data != NULL && pcap_sendpacket(pcap, data, len) == 0)) {
 			num_tx++;
@@ -721,8 +740,13 @@ eth_dev_stop(struct rte_eth_dev *dev)
 }
 
 static int
-eth_dev_configure(struct rte_eth_dev *dev __rte_unused)
+eth_dev_configure(struct rte_eth_dev *dev)
 {
+	struct pmd_internals *internals = dev->data->dev_private;
+	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
+	const struct rte_eth_rxmode *rxmode = &dev_conf->rxmode;
+
+	internals->vlan_strip = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP);
 	return 0;
 }
 
@@ -738,7 +762,9 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
-	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
+		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
+	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
 
 	return 0;
 }
@@ -885,6 +911,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	pcap_q->mb_pool = mb_pool;
 	pcap_q->port_id = dev->data->port_id;
 	pcap_q->queue_id = rx_queue_id;
+	pcap_q->vlan_strip = internals->vlan_strip;
 	dev->data->rx_queues[rx_queue_id] = pcap_q;
 
 	if (internals->infinite_rx) {
-- 
2.51.0

