Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6AED2FEC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 17:22:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 975C541140;
	Tue, 27 Jan 2026 18:21:58 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id AD35940EE3
 for <dev@dpdk.org>; Tue, 27 Jan 2026 18:21:51 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-47ee937ecf2so472045e9.0
 for <dev@dpdk.org>; Tue, 27 Jan 2026 09:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769534511;
 x=1770139311; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5uozYhwyaNAO//u3X9vy+vRUbOBnYpkTjf8nIGdlKmE=;
 b=w83uwbhIiw7wsjRXgP86gmzv6cYVItRhWxC8b+nnOgA2Vn4yHCJrhSYsUzvFTS6tKG
 X3hdmKVZoPC6IHBnI3547T8hc8JlpC7VLguN6x/w1cVGP3UpMlk5YLwF/iSEWpeb1iiH
 K52Yws3cBUfTDirzLmAyUobpHzrcuI46j/XW3WG2XrIjYC/7hoKyzQUvPhXB9cEuoAjf
 UCchR/WH6yhIhGWSGW65YICrnkrMcVEnZrO1jVn3amv3BfKrHmARIvI/zLN8p+rk9O6I
 qq8iGGLI0rMH78xyk6B+uf4krp4d6Xr0M4ng5tFs/rJLb2bwjuPXiFESDe5bpxszOTGW
 u5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769534511; x=1770139311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5uozYhwyaNAO//u3X9vy+vRUbOBnYpkTjf8nIGdlKmE=;
 b=rpmZDgTaYDoejs+QCUUsswHZgn49eIk2TGXpRWkMxMgu+xop1GF5OCuHGcPyfPGwwV
 L8wHleRhsvKfQtu4psEg9/P4naL5xJivNTdOjbT0uPxwHRiPmwGwkaxXCd6WaUrAZ+AC
 azeqhFrG+iFpobuK4uGqf/PP28RakKGhF9+/FsmFETOthXrTHA2oRDeryxwO1cEdgoe7
 fkePdrqO2+n/T1XSQi/ly71LwI0EkjE76RT/A3m8mEVLO3A7FkxwGcyYRrGYleVQmYWc
 j7ugvsdk/WbQi4dr2Hn8lpz/3aZqEcgnxI7SFqAPg6DxryO5Fem/EcqmmrCRxHgbjQnX
 VV9Q==
X-Gm-Message-State: AOJu0YxLZWhc1+BD0CtFiDUJqHjtRbbgB2CzmCAQww3U8Ah9OFzVSnR/
 61Yj3UxwVRMFXRBZo8i6la1Wl8RSGUyM3UQ1psLrkgdSm4898OB/8yLgUvc4Gm2e03Bp+QwG1Is
 16diF
X-Gm-Gg: AZuq6aKL3YA8uYruPDyh400S4YUCZHkM7SKSkkVadyrGRvVBO124/tCB3/m1UTRFt8Q
 LtrY60lxXsp/M0lvcW+MPEBqc8c8IfiMQjvNBsmzXpMgKmvuXxoKCxHdqrqi29hLLAOEZcLOUMD
 ohl4z6XgBvr7F04orDoFC23aDZqYKsXs3yzIBr0ima3NzncX1HIBIvJ5/EOUUk0nC6kdPKbgS48
 F+imgnXA9p/FfwqjlB+HPQGD9XylwDzCPnrSsBxUQCdl/MqMGYc8lfwVEdF3ZftJHaQtV1s4pIG
 ucAMVDirLF5sTMu15ndhhi6d6Cp+bdgs/rsT0+ScAly0TQ3fGr+MJn3opRYaEQKOBfQPi1/nGYZ
 wsJmuW4jaunZtBUnJ7hkb1oOWgDjNOMgBSCO/IdXbOM/OiI+oSlILR96mvskErTjeTDCnm9N7Bc
 HRXANxdq1YzD80T/+SPNBtit+f/+dnmX17fLp8v50h9BGLMCPbNA==
X-Received: by 2002:a05:600c:8011:b0:480:4a90:1afd with SMTP id
 5b1f17b1804b1-48069d44770mr24942745e9.0.1769534511221; 
 Tue, 27 Jan 2026 09:21:51 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm4769395e9.12.2026.01.27.09.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 09:21:50 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 08/14] net/pcap: support VLAN insert and strip
Date: Tue, 27 Jan 2026 09:18:49 -0800
Message-ID: <20260127172128.124473-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127172128.124473-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260127172128.124473-1-stephen@networkplumber.org>
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

