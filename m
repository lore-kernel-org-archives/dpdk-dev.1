Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3F9D73EAA
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 01:15:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EC9F40A6D;
	Fri, 30 Jan 2026 02:14:20 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 8101D4067D
 for <dev@dpdk.org>; Fri, 30 Jan 2026 02:14:08 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso16251665e9.2
 for <dev@dpdk.org>; Thu, 29 Jan 2026 17:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769735648;
 x=1770340448; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f7wQB/hUSmH/67rxXuXeCj2oQXqVVfcd2EtfIjOgwrA=;
 b=xmMVes2K0MzSbUTin/JBpPQtpK6vdzpdAWTJE0z1rVpM1+vusVtyhA4rpUkMJItJAU
 rsTRtgWC5l/Vj2RFmuwB6fpB9l8a5SWOM/AxKV5tN31mt5O6yFyTjA0xUrdg+MGld9pa
 N19qpAAAMseKhgh+/3w/J+bM+8BtUl4CXyzigLICwH8twVNvIfAMId6hH5sLp3/K2UcL
 Gc5vPOHADgstcoRUfh+DI06s2Y47J5ntnwQEPDJkbtmbYfhoLTZUW0lXScgv3TuRaBSw
 qLYhb/GXQ6GeaxDPaNq1uPyoh/8DtWTtcGBAuqs71aWbGDOY4qLx1VVlVWXii15GXyMN
 wDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769735648; x=1770340448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f7wQB/hUSmH/67rxXuXeCj2oQXqVVfcd2EtfIjOgwrA=;
 b=aFgDLnSb8EQzYIgAh6QYZG7gyDCGEoKIC0bpDsqEJG91789Pa5mf/W/tRcrUwGk5uF
 7wSKbL5X+3Nv/Ks5liWdFoAsLKCkLH4Et6Vbr1gC8kwQ3KXRSxP4JxcAZODLUjCVX9/f
 5yqdUwZvp0ikWcYUB86yJedBu2RH10jFu2aZT32ZIx/kUsfqPnAv5dJvsiT+kNkLnrBS
 649Kr6cqipu7+OqPqA5K1w4QyrMT85L3SlI5yAiln0/TG6Gai7PZ1khRJ2W159GGKgSi
 VQKevOBdbJ0gWR9qhf3JQaJ6GICZ7hWsCjsjjQBEzKemmY+4DcnAjgPvOAu3hUgIKGOG
 iyuA==
X-Gm-Message-State: AOJu0YzHWM3ABFMEw1xHeFtOM2ezVUbzx3jGm9m7mP3WHMN4qHh9j81g
 Tmk5zCdileQDlarhFXq5mH7Z3lTY48dDRoAUOz/7gxkGPznVika2zDC0pDMbraDoG4n/J0YRHeZ
 QXIA4
X-Gm-Gg: AZuq6aKkm0Stl5WwgAO0aNrVrrG3WPDrEItq4YzrMUk+kGX4qXV0+APn1ivZ47XjkdD
 EzDHXRBABsRAy3nZ+4cWARtfE0LZA49SsGHXYQWrtUFykG+otZqxOsdhdS+H1ojQS2S5ldTyO6a
 UVptkqY/359y9sDsZZ5DXRvCTPzlUKC5hpGe7CURb0wos8RNOs870thOHaQ8lgCw7V6xOZWKXTz
 OfxwHzq6KL/b869peL99yJdURhL9A+m4hot9SYgiVPf9JtekOi990BXVRdMpCZACM4YXLmA8RzD
 7Xv6rb7XA1RzUgLKv729Wx2uYDbtA5Qs+idKcIrpTrKSo9eirOU9ezGaZveViujOkzLueiF0bZ9
 QOKgu+CX3UWq4QdV/Qu2HSBwCFRXIm318O5ZL/cpMfQgbCiD7zUtFT0pNOUig9J+i7DJl+mQ+fo
 vVdDSEm7wlQpvQ0RnU0H6f8Mhz4pyvTvRq0CDX2JZ56Zc0QJmw9AiUYjJtoDe1
X-Received: by 2002:a05:600c:81c8:b0:479:2f95:5179 with SMTP id
 5b1f17b1804b1-482db467e7cmr10134225e9.15.1769735648100; 
 Thu, 29 Jan 2026 17:14:08 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e1d0f9sm2934825e9.18.2026.01.29.17.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 17:14:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v10 11/19] net/pcap: support VLAN insert and strip
Date: Thu, 29 Jan 2026 17:12:27 -0800
Message-ID: <20260130011344.204233-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130011344.204233-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130011344.204233-1-stephen@networkplumber.org>
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

