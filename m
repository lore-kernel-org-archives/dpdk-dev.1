Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC81BE63CBF
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Jan 2026 19:24:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D412A40648;
	Sun, 25 Jan 2026 20:23:34 +0100 (CET)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id A0561402D8
 for <dev@dpdk.org>; Sun, 25 Jan 2026 20:23:26 +0100 (CET)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-435903c4040so2326598f8f.3
 for <dev@dpdk.org>; Sun, 25 Jan 2026 11:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769369006;
 x=1769973806; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=venSRc2KCnWCoWAaZ90jRBJ5BpUIonkXF6k9X44cxiE=;
 b=GNI7y76MnZUDL8d4MVpcIbdk2/zHsghZVf37e9+UQpWtqZWKItQQNBO+0RnyAYC0qE
 tVeTtL6GRYMlGsuM3hHhaKvLmJNYnxPQTtE+fQH3LMZv+1vnpY1LJdnLOk+fQROXCD09
 Wc2JlRL/EuXKAgcJi7EWLk2q4M8blbrk8dj3NdR22cP7ZV0o/fUh6TZ0YRjlwaTDz2yg
 uwZddgbKhbKD+tvxva/osxn1XGHSl5Be/Ax0P/vV0YwYwk2r1C3TE6fycvG6iq/oyWAl
 L8lFLcCEuMLgHTbmWlP1hWxPRoyss/ezgb4dSRV2dWFuaN6Hm6EJ2wQnDHoAoR9Gbep0
 0iPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769369006; x=1769973806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=venSRc2KCnWCoWAaZ90jRBJ5BpUIonkXF6k9X44cxiE=;
 b=AdKLzrKYt8+uFwsoytrJevEeeyR1Z6fzNh0ZQ1hMjtgl1eJ1HzNeBZbw8hRgoZldLw
 E/VA6H9oI4qdFTtzaWgwuE256EQRUAl8D/O0Y8RwZY7VUAapf2uQxF9YUlbVSPywiNYo
 TtuD8Gyi2WpiQmksjwUelseioKqb4G3NVshFOAPyi0iyWiB9VkSWqhAUkccpP+D0Nxwz
 oad3bH6GwBx67fe/0hDmcIO5C3eANA7Bf0immW7yEYKIxE0B4B8bcyIPgZ2G5rKxT/j6
 SsmNSaYudCJQee36JdcWgD481obd141pQAwJ/GjpOub0iR+ltPnyRHqOFxv0q9ah7v/J
 y5Ng==
X-Gm-Message-State: AOJu0YwBWGWTjCqLK/KuI1V4em40XdjlLIizc1ZVwUKJLo8NHDFtuUH/
 SrE8sCNm7orpYJrhfBYDoeTDpxGanNpzUvKJMUl35R4p2BDssyBCr9Wfl11IQnO8ABBWn3/Bz1L
 18ul9
X-Gm-Gg: AZuq6aKh2BBfpR2uFWTvRNcTuUALRaOhs97STYr6V6ZeG1C2lliiNweVjP2MmYeQi4b
 O9y4h0ei8McEIHpKbAgk/Nnvsw3Y/SsOOe4f3K9ximHdjAWt2dSQzt9U2qMW+zH6Ioa8RBR3nNU
 EEBcXp8XrqwHKMLT70ZEZhr+C+HZ4bxMb+lYfaWK2nTB1sJyNF/tGnuS3jIUOPntDQNdnBC+w37
 kNBfWQ5hKcMFTziZo/Ntz+fXffvi4Ks1h09S6VKHUB6NwHGPlS5wttiIviOmludhm7j3CQX1O1g
 XrpHj7MLqMMyOQtT4WM7udguGk/h4x+Itc+N0EsQKP7jiKjgYr8+pk4eJykpRVPO68TlfmL85Fy
 Nj3WaaYLYQapnqEz8P8W+GsYuR29UyN1JS+IJAyghOZoaMbhM+9WAE4vLpX1JFfjmKhdw4pVi3O
 b2bLu/VZ12ZWxTVKB6zp0BJWhDsRsDBd/7QVQ7q2Rc5sQULUiR/w==
X-Received: by 2002:a05:6000:230c:b0:435:a8e7:62de with SMTP id
 ffacd0b85a97d-435ca39bb1cmr3967954f8f.58.1769369006131; 
 Sun, 25 Jan 2026 11:23:26 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b4d8sm22854362f8f.38.2026.01.25.11.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 11:23:25 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 09/13] net/pcap: support VLAN insert and strip
Date: Sun, 25 Jan 2026 11:20:07 -0800
Message-ID: <20260125192248.497563-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125192248.497563-2-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260125192248.497563-2-stephen@networkplumber.org>
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
 drivers/net/pcap/pcap_ethdev.c         | 30 ++++++++++++++++++++++++--
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index d2f5ee6039..7043213c5f 100644
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
index 41f96ad1af..4e31d85e50 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -58,6 +58,7 @@ New Features
 * **Updated PCAP ethernet driver.**
 
   * Added support for setting MTU in single interface mode.
+  * Added support for VLAN insertion and stripping.
   * Changed transmit burst to always return the number of packets requested.
     Failed sends are counted as transmit errors.
 
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 9ebb9c8633..85225fca2d 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -76,6 +76,7 @@ struct queue_missed_stat {
 struct pcap_rx_queue {
 	uint16_t port_id;
 	uint16_t queue_id;
+	bool vlan_strip;
 	struct rte_mempool *mb_pool;
 	struct queue_stat rx_stat;
 	struct queue_missed_stat missed_stat;
@@ -103,6 +104,7 @@ struct pmd_internals {
 	bool single_iface;
 	bool phy_mac;
 	bool infinite_rx;
+	bool vlan_strip;
 };
 
 struct pmd_process_private {
@@ -333,6 +335,10 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		}
 
 		mbuf->pkt_len = len;
+
+		if (pcap_q->vlan_strip)
+			rte_vlan_strip(mbuf);
+
 		uint64_t us = (uint64_t)header->ts.tv_sec * US_PER_S + header->ts.tv_usec;
 
 		*RTE_MBUF_DYNFIELD(mbuf, timestamp_dynfield_offset, rte_mbuf_timestamp_t *) = us;
@@ -421,6 +427,12 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		void *temp = NULL;
 		const uint8_t *data;
 
+		if (mbuf->ol_flags & RTE_MBUF_F_TX_VLAN) {
+			/* if vlan insert fails treat it as error */
+			if (unlikely(rte_vlan_insert(&mbuf) != 0))
+				continue;
+		}
+
 		calculate_timestamp(&header.ts);
 		header.len = len;
 		header.caplen = len;
@@ -498,6 +510,12 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
@@ -732,8 +750,13 @@ eth_dev_stop(struct rte_eth_dev *dev)
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
 
@@ -751,7 +774,9 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->min_rx_bufsize = 0;
 	dev_info->min_mtu = RTE_ETHER_MIN_LEN - RTE_ETHER_HDR_LEN - RTE_ETHER_CRC_LEN;
 	dev_info->max_mtu = RTE_ETH_PCAP_SNAPLEN;
-	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
+		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
+	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
 
 	return 0;
 }
@@ -898,6 +923,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	pcap_q->mb_pool = mb_pool;
 	pcap_q->port_id = dev->data->port_id;
 	pcap_q->queue_id = rx_queue_id;
+	pcap_q->vlan_strip = internals->vlan_strip;
 	dev->data->rx_queues[rx_queue_id] = pcap_q;
 
 	if (internals->infinite_rx) {
-- 
2.51.0

