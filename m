Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49017ECD6EE
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 22:22:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF786406B4;
	Wed, 11 Feb 2026 23:21:57 +0100 (CET)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id D8136406A2
 for <dev@dpdk.org>; Wed, 11 Feb 2026 23:21:55 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-436234ef0f0so4496369f8f.1
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770848515;
 x=1771453315; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LsYu02tkwKtuRjG1LUQmL60F8rvtSzS6kJWZFqyeE9U=;
 b=Q4eCbHgD97Pch0khqkgWWd0bmFkIT1pww53kzXcyRIlxK6oiI744FyOWjaxlCCvGDG
 3Z7FW5T/P96FLr3kjbBJADeJPhO6tdfEGhNBZqlkjcIeX5qR/CMdkJM8F4aQN2tdNyzR
 Xg3QPt0+JTs7/Eq+v/de77a+1q2F2PnErlgyyR8DZ+oMhGQkCF3e9UhlD6D9ZpImX6ZH
 lcTLjxQdZ2C2rKIt89r/6N7N1cbPyjB/4U11HAttbHoOj/kpJp86oNOJ3tOfbNcD6gvt
 aoBWNnllfrCAlbrgxAQ+YipJ8mD+A7WJnyA/FpVk6S3vUUt0xvnpeKYTssyGS0zSg2uf
 hWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770848515; x=1771453315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LsYu02tkwKtuRjG1LUQmL60F8rvtSzS6kJWZFqyeE9U=;
 b=kNHGKagf9/mmFR5d1xXCyLQw2G8KXghdwZQvWlS/pKp280LGXMudgA8KqS1v9P+8zB
 8E7Fqkna4Uu27FVrYi4UZGj2IkLjp3O72G8KCKeRC+F5cD+lxcq/cHkFU9pJAUwKvghS
 IS3fZpiv3xlSDDY8pyAe8Vt+F5gjwpAMn6iJu9/nuqUiEIPb9fk/Jr16d2BwnUBKr+ZQ
 Tam6Qpwk9Xbd1b+gssVXUkmxxcMQpOovLA/WFHx6N/r4rHyUustFUIJgHPytk9utezWh
 6iv9EL0eNt3qobJg5mfZdiRVOSlIf4sSKU3e/GnOW/3xVq3y4ACDG6Brv0QFfG49d6Ia
 oVYA==
X-Gm-Message-State: AOJu0YxLHvBdH2qQN7YFRQ7aV0N7ZloJLHEyF4dDIaVPUdgf5FXZLPTu
 1z5Ca7h7PpYD5y6KsNPSq9bO55KvO2G4XxM9MbHb/1hMSU8CJ4Q+RAR/T4U/foWJ8KVyBWGJQVb
 95IW5
X-Gm-Gg: AZuq6aIaH91u+kxC7LnV9zYUlcsIuetJqMJMmIRXXlaFFpMH94dEqqoa7C6CtKPOURz
 +v+uRGnHaLSubedvyrZ6bIE2N57nP8f9cCa8I1BhBlYzRdqAMPHAAimN6wFcoTks35YjdcdL4Um
 fSJ5lVsKbJcahtg5FHQeWYcrqcbP8dQx+ACMG46UBmIQok5MBglMTFdHrMbc5t9GP7NN/C3VvYz
 wTjB+1Y9cN+fxXZIZc2rknmLjN6J6xwUYvrN318TA5kSQlY4dh8sLlds7Fdqzy0HyO7PuwgWoTp
 1Wqdvhpili/b4Kjp8YunzdXUiVwOkG3IolOjfzAQjnGR/9Si49QFlxnKrn/vNjsAfrczCY0o2uY
 BXS1fP2AehKEiRcP6ZchcPZ8hLgPHYefcd92q02L8WMj/WZ9B5tZy0DGm0FUOOVW9S6PDqNGH2/
 eJ2HZTwtjiyJh3w5HVdYYDcHLpDK9S9i7QSBaQcNpXV2AomKr+tGUnTbIDx42d0Q==
X-Received: by 2002:a05:6000:2906:b0:435:9ce0:f93c with SMTP id
 ffacd0b85a97d-4378aca47e9mr1547680f8f.62.1770848515409; 
 Wed, 11 Feb 2026 14:21:55 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783e0196bsm7877965f8f.23.2026.02.11.14.21.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 14:21:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v14 08/18] net/pcap: support VLAN strip and insert offloads
Date: Wed, 11 Feb 2026 13:09:41 -0800
Message-ID: <20260211222130.338797-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211222130.338797-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260211222130.338797-1-stephen@networkplumber.org>
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

Add VLAN tag handling to the pcap PMD, consistent with how virtio
and af_packet drivers implement it.

RX strip: when RTE_ETH_RX_OFFLOAD_VLAN_STRIP is enabled, the driver
calls rte_vlan_strip() on received packets in both normal and
infinite_rx modes. For infinite_rx, offloads are deferred to
packet delivery rather than applied during ring fill, so the
stored template packets remain unmodified.

TX insert: when RTE_MBUF_F_TX_VLAN is set on an mbuf, the driver
inserts the VLAN tag via rte_vlan_insert() before writing to pcap
or sending to the interface. Indirect or shared mbufs get a new
header mbuf to avoid modifying the original.

Runtime reconfiguration is supported through vlan_offload_set,
which propagates the strip setting to all active RX queues.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/pcap.ini      |   1 +
 doc/guides/nics/pcap.rst               |  11 +++
 doc/guides/rel_notes/release_26_03.rst |   4 +
 drivers/net/pcap/pcap_ethdev.c         | 118 ++++++++++++++++++++++++-
 4 files changed, 130 insertions(+), 4 deletions(-)

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
diff --git a/doc/guides/nics/pcap.rst b/doc/guides/nics/pcap.rst
index fbfe854bb1..bed5006a42 100644
--- a/doc/guides/nics/pcap.rst
+++ b/doc/guides/nics/pcap.rst
@@ -247,3 +247,14 @@ will be discarded by the Rx flushing operation.
    The network interface provided to the PMD should be up.
    The PMD will return an error if the interface is down,
    and the PMD itself won't change the status of the external network interface.
+
+Features and Limitations
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+*  The PMD will re-insert the VLAN tag transparently to the packet if the kernel
+   strips it, as long as the ``RTE_ETH_RX_OFFLOAD_VLAN_STRIP`` is not enabled by the
+   application.
+
+*  The PMD will transparently insert a VLAN tag to transmitted packets if
+   ``RTE_ETH_TX_OFFLOAD_VLAN_INSERT`` is enabled and the mbuf has ``RTE_MBUF_F_TX_VLAN``
+   set.
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 5c2a4bb32e..eb80c8a785 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -82,6 +82,10 @@ New Features
   * NEA5, NIA5, NCA5: AES 256 confidentiality, integrity and AEAD modes.
   * NEA6, NIA6, NCA6: ZUC 256 confidentiality, integrity and AEAD modes.
 
+* **Updated PCAP ethernet driver.**
+
+  * Added support for VLAN insertion and stripping.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index f6adc23463..51f0fdbfd7 100644
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
@@ -271,7 +273,11 @@ eth_pcap_rx_infinite(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		bufs[i]->data_len = pcap_buf->data_len;
 		bufs[i]->pkt_len = pcap_buf->pkt_len;
 		bufs[i]->port = pcap_q->port_id;
-		rx_bytes += pcap_buf->data_len;
+
+		if (pcap_q->vlan_strip)
+			rte_vlan_strip(bufs[i]);
+
+		rx_bytes += bufs[i]->data_len;
 
 		/* Enqueue packet back on ring to allow infinite rx. */
 		rte_ring_enqueue(pcap_q->pkts, pcap_buf);
@@ -337,6 +343,10 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		}
 
 		mbuf->pkt_len = len;
+
+		if (pcap_q->vlan_strip)
+			rte_vlan_strip(mbuf);
+
 		uint64_t us = (uint64_t)header->ts.tv_sec * US_PER_S + header->ts.tv_usec;
 
 		*RTE_MBUF_DYNFIELD(mbuf, timestamp_dynfield_offset, rte_mbuf_timestamp_t *) = us;
@@ -383,6 +393,57 @@ calculate_timestamp(struct timeval *ts) {
 	}
 }
 
+
+/*
+ * If Vlan offload flag is present, insert the vlan.
+ */
+static inline int
+eth_pcap_tx_vlan(struct pcap_tx_queue *tx_queue, struct rte_mbuf **mbuf)
+{
+	struct rte_mbuf *mb = *mbuf;
+
+	if ((mb->ol_flags & RTE_MBUF_F_TX_VLAN) == 0)
+		return 0;
+
+	if (unlikely(mb->data_len < RTE_ETHER_HDR_LEN)) {
+		PMD_TX_LOG(ERR, "mbuf missing ether header");
+		goto error;
+	}
+
+	/* Need at another buffer to hold VLAN header? */
+	if (!RTE_MBUF_DIRECT(mb) || rte_mbuf_refcnt_read(mb) > 1) {
+		struct rte_mbuf *mh = rte_pktmbuf_alloc(mb->pool);
+		if (unlikely(mh == NULL)) {
+			PMD_TX_LOG(ERR, "mbuf pool exhausted on transmit vlan");
+			goto error;
+		}
+
+		/* Move original ethernet header into new mbuf */
+		memcpy(rte_pktmbuf_mtod(mh, void *),
+		       rte_pktmbuf_mtod(mb, void *), RTE_ETHER_HDR_LEN);
+
+		rte_pktmbuf_adj(mb, RTE_ETHER_HDR_LEN);
+		mh->nb_segs = mb->nb_segs + 1;
+		mh->data_len = RTE_ETHER_HDR_LEN;
+		mh->pkt_len = mb->pkt_len + RTE_ETHER_HDR_LEN;
+		mh->ol_flags = mb->ol_flags;
+		mh->next = mb;
+
+		*mbuf = mh;
+	}
+
+	int ret = rte_vlan_insert(mbuf);
+	if (unlikely(ret != 0)) {
+		PMD_TX_LOG(ERR, "Vlan insert failed: %s", strerror(-ret));
+		goto error;
+	}
+	return 0;
+error:
+	rte_pktmbuf_free(*mbuf);
+	tx_queue->tx_stat.err_pkts++;
+	return -1;
+}
+
 /*
  * Callback to handle writing packets to a pcap file.
  */
@@ -408,13 +469,17 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	/* writes the nb_pkts packets to the previously opened pcap file
 	 * dumper */
 	for (i = 0; i < nb_pkts; i++) {
-		struct rte_mbuf *mbuf = bufs[i];
 		uint32_t len, caplen;
 		const uint8_t *data;
 
+		if (eth_pcap_tx_vlan(dumper_q, &bufs[i]) < 0)
+			continue;
+
+		struct rte_mbuf *mbuf = bufs[i];
 		len = caplen = rte_pktmbuf_pkt_len(mbuf);
 
 		calculate_timestamp(&header.ts);
+
 		header.len = len;
 		header.caplen = caplen;
 
@@ -499,6 +564,9 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		return 0;
 
 	for (i = 0; i < nb_pkts; i++) {
+		if (eth_pcap_tx_vlan(tx_queue, &bufs[i]) < 0)
+			continue;
+
 		struct rte_mbuf *mbuf = bufs[i];
 		uint32_t len = rte_pktmbuf_pkt_len(mbuf);
 		const uint8_t *data;
@@ -754,8 +822,13 @@ eth_dev_stop(struct rte_eth_dev *dev)
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
 
@@ -771,7 +844,9 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
-	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
+		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
+	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
 
 	return 0;
 }
@@ -918,6 +993,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	pcap_q->mb_pool = mb_pool;
 	pcap_q->port_id = dev->data->port_id;
 	pcap_q->queue_id = rx_queue_id;
+	pcap_q->vlan_strip = internals->vlan_strip;
 	dev->data->rx_queues[rx_queue_id] = pcap_q;
 
 	if (internals->infinite_rx) {
@@ -927,6 +1003,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 		uint64_t pcap_pkt_count = 0;
 		struct rte_mbuf *bufs[1];
 		pcap_t **pcap;
+		bool save_vlan_strip;
 
 		pp = rte_eth_devices[pcap_q->port_id].process_private;
 		pcap = &pp->rx_pcap[pcap_q->queue_id];
@@ -946,11 +1023,20 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 		if (!pcap_q->pkts)
 			return -ENOENT;
 
+		/*
+		 * Temporarily disable offloads while filling the ring
+		 * with raw packets. VLAN strip and timestamp will be
+		 * applied later in eth_pcap_rx_infinite() on each copy.
+		 */
+		save_vlan_strip = pcap_q->vlan_strip;
+		pcap_q->vlan_strip = false;
+
 		/* Fill ring with packets from PCAP file one by one. */
 		while (eth_pcap_rx(pcap_q, bufs, 1)) {
 			/* Check for multiseg mbufs. */
 			if (bufs[0]->nb_segs != 1) {
 				infinite_rx_ring_free(pcap_q->pkts);
+				pcap_q->vlan_strip = save_vlan_strip;
 				PMD_LOG(ERR,
 					"Multiseg mbufs are not supported in infinite_rx mode.");
 				return -EINVAL;
@@ -960,6 +1046,9 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 					(void * const *)bufs, 1, NULL);
 		}
 
+		/* Restore offloads for use during packet delivery */
+		pcap_q->vlan_strip = save_vlan_strip;
+
 		if (rte_ring_count(pcap_q->pkts) < pcap_pkt_count) {
 			infinite_rx_ring_free(pcap_q->pkts);
 			PMD_LOG(ERR,
@@ -1044,6 +1133,26 @@ eth_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	return 0;
 }
 
+static int
+eth_vlan_offload_set(struct rte_eth_dev *dev, int mask)
+{
+	struct pmd_internals *internals = dev->data->dev_private;
+	unsigned int i;
+
+	if (mask & RTE_ETH_VLAN_STRIP_MASK) {
+		bool vlan_strip = !!(dev->data->dev_conf.rxmode.offloads &
+				     RTE_ETH_RX_OFFLOAD_VLAN_STRIP);
+
+		internals->vlan_strip = vlan_strip;
+
+		/* Update all RX queues */
+		for (i = 0; i < dev->data->nb_rx_queues; i++)
+			internals->rx_queue[i].vlan_strip = vlan_strip;
+	}
+
+	return 0;
+}
+
 static const struct eth_dev_ops ops = {
 	.dev_start = eth_dev_start,
 	.dev_stop = eth_dev_stop,
@@ -1060,6 +1169,7 @@ static const struct eth_dev_ops ops = {
 	.link_update = eth_link_update,
 	.stats_get = eth_stats_get,
 	.stats_reset = eth_stats_reset,
+	.vlan_offload_set = eth_vlan_offload_set,
 };
 
 static int
-- 
2.51.0

