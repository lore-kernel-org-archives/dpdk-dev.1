Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A635D46BEE
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 18:42:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 323D5406B7;
	Wed, 28 Jan 2026 19:41:57 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 2F93E40687
 for <dev@dpdk.org>; Wed, 28 Jan 2026 19:41:48 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-432d2c7a8b9so213922f8f.2
 for <dev@dpdk.org>; Wed, 28 Jan 2026 10:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769625708;
 x=1770230508; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5uozYhwyaNAO//u3X9vy+vRUbOBnYpkTjf8nIGdlKmE=;
 b=tltNj5yclWpu/JqNyft1FbXtGOcHW7BK+FsLkuQ3Xit5rxN2shRN8fZ48YaKA6Nj9a
 y6Iwj3PNgDStQ/MMxU3Redb1P9U0SzTpT3sQ1F9yxOJhsBQfrHKVEquboN4YzLiAlY3N
 GrIEipFH7vIY597aDZ+DTzFMZ0al6drXSZOZjyZIFbiuxbkrwJPbUBYwuwLfq1rNAECL
 T3g+cT2TWag0Tz67Btre9uXxD6Z2kBvHewEIRB69R/kH7+TJCslmXDWRkB9buqx3s1zb
 uNlGgJ+RsQcacc6L92O66v2woPXKvhyDcu6EB3laeaDfx7dpnX1T6Ku0xNwRVNOJdYi3
 GAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769625708; x=1770230508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5uozYhwyaNAO//u3X9vy+vRUbOBnYpkTjf8nIGdlKmE=;
 b=Rn9Ia8eiiiw5eT87yakhUsXmoSHSY2U/w566GRlKyoB8kKUavzAk4CywBt8BrEKH7p
 4TfBU30uu01HiFD6QQyH06joxWWczqcnP9AHZHGjbEyibETe6cxWATu7J8Uvki8/MDtf
 l48yfhUT6izaPp6jLxKdthXzV6ttZ4gf5FaacaklkAUsr/kQ+/uwEuKfd7VbMr6S3jX+
 blgyCK4NmZhjqRvYRVWMqNJEL5Xe9hWsL5GDWMyiVSEf9qQonEXXaK9Lr+Le/YGuC66M
 7d6DFQOwGLLKDVOyozhIF3nzNR1ekC2aP3Gd8X/CSeuERn00O56DgLM2OPqmeNZnm4l0
 qcOw==
X-Gm-Message-State: AOJu0Yz51Zj8YQr8dB+Ay6bz1m0Z0Vk05ifoG/313atCDLa30H5D8PwO
 n8YDITFURHsq5qNldpyiG8+NQffGQzp5Jvgc8kTaVqgn3wnKoTkx+2/OMRvS9h5Kn/tCG4053p0
 GXd2s
X-Gm-Gg: AZuq6aLTxbIA4cTrqXiR5Cm3kv9vykuy7o/v7uJXDc1vDk2RKEbStbwN6KjgoNwpcC8
 +6gk6JlTfg/VfijxHz17En4TJseb0FPTQtCSVQzBa9p9YKpA9CdmQdifX8OeB4DOg1eOAqo/4FX
 6ERtOugZj6pR9raEzMYXcw2Pgh3F4DBDHyJOKAI+EtPFmQwAC8gECrcSbD/ypegtDI+JZCBndAY
 WVMUa/m2gneYTLXBsShz3iA5gOAzXoJUiMTSU1EDm8fdSf0oe56TFDwgVsxLCPfi76fidM33Fvd
 AV4bSor96e197p7tCRqeguv0gMb+7eCTozaah93kP/TJTSFe8WLZOeJy6QOWkm0kLhrbXJZTvxO
 lY1d3C/P4dJKgqY2u1paQxB+oeRPs3zgcHqIGK8ezcqwT09c3NoUFl7wslWrf8OoV42jUYMBMSv
 0hyvv0lQed/L0U6i9050qUTCToPnuIXIHM1XGVN9dgiCRrBLVE6A==
X-Received: by 2002:a5d:5887:0:b0:435:db95:c2d3 with SMTP id
 ffacd0b85a97d-435dd0b134amr8490906f8f.36.1769625707769; 
 Wed, 28 Jan 2026 10:41:47 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee562sm9015430f8f.18.2026.01.28.10.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 10:41:47 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 08/15] net/pcap: support VLAN insert and strip
Date: Wed, 28 Jan 2026 10:40:37 -0800
Message-ID: <20260128184130.445567-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128184130.445567-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260128184130.445567-1-stephen@networkplumber.org>
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
 doc/guides/rel_notes/release_26_03.rst |  1 +
 drivers/net/pcap/pcap_ethdev.c         | 38 ++++++++++++++++++++++----
 3 files changed, 34 insertions(+), 6 deletions(-)

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
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 76d81ac524..3d25626adb 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -59,6 +59,7 @@ New Features
 
   * Changed transmit burst to always return the number of packets requested.
     Failed sends are counted as transmit errors.
+  * Added support for VLAN insertion and stripping.
 
 
 Removed Items
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 63a4f92c9c..47211807a7 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -75,6 +75,7 @@ struct queue_missed_stat {
 struct pcap_rx_queue {
 	uint16_t port_id;
 	uint16_t queue_id;
+	bool vlan_strip;
 	struct rte_mempool *mb_pool;
 	struct queue_stat rx_stat;
 	struct queue_missed_stat missed_stat;
@@ -102,6 +103,7 @@ struct pmd_internals {
 	bool single_iface;
 	bool phy_mac;
 	bool infinite_rx;
+	bool vlan_strip;
 };
 
 struct pmd_process_private {
@@ -332,6 +334,10 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		}
 
 		mbuf->pkt_len = len;
+
+		if (pcap_q->vlan_strip)
+			rte_vlan_strip(mbuf);
+
 		uint64_t us = (uint64_t)header->ts.tv_sec * US_PER_S + header->ts.tv_usec;
 
 		*RTE_MBUF_DYNFIELD(mbuf, timestamp_dynfield_offset, rte_mbuf_timestamp_t *) = us;
@@ -416,15 +422,21 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	/* writes the nb_pkts packets to the previously opened pcap file dumper */
 	for (i = 0; i < nb_pkts; i++) {
 		struct rte_mbuf *mbuf = bufs[i];
-		uint32_t len = rte_pktmbuf_pkt_len(mbuf);
-		void *temp = NULL;
-		const uint8_t *data;
+
+		if (mbuf->ol_flags & RTE_MBUF_F_TX_VLAN) {
+			/* if vlan insert fails treat it as error */
+			if (unlikely(rte_vlan_insert(&mbuf) != 0))
+				continue;
+		}
 
 		calculate_timestamp(&header.ts);
+
+		uint32_t len = rte_pktmbuf_pkt_len(mbuf);
 		header.len = len;
 		header.caplen = len;
 
-		data = pcap_pktmbuf_read(mbuf, 0, len, &temp);
+		void *temp = NULL;
+		const uint8_t *data = pcap_pktmbuf_read(mbuf, 0, len, &temp);
 		if (likely(data != NULL)) {
 			pcap_dump((u_char *)dumper, &header, data);
 
@@ -497,6 +509,12 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		void *temp = NULL;
 		const uint8_t *data;
 
+		if (mbuf->ol_flags & RTE_MBUF_F_TX_VLAN) {
+			/* if vlan insert fails treat it as error */
+			if (unlikely(rte_vlan_insert(&mbuf) != 0))
+				continue;
+		}
+
 		data = pcap_pktmbuf_read(mbuf, 0, len, &temp);
 		if (likely(data != NULL &&
 		    pcap_sendpacket(pcap, data, len) == 0)) {
@@ -731,8 +749,13 @@ eth_dev_stop(struct rte_eth_dev *dev)
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
 
@@ -748,7 +771,9 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
-	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
+		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
+	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
 
 	return 0;
 }
@@ -895,6 +920,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	pcap_q->mb_pool = mb_pool;
 	pcap_q->port_id = dev->data->port_id;
 	pcap_q->queue_id = rx_queue_id;
+	pcap_q->vlan_strip = internals->vlan_strip;
 	dev->data->rx_queues[rx_queue_id] = pcap_q;
 
 	if (internals->infinite_rx) {
-- 
2.51.0

