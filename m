Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB21E94625
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 00:02:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FA2840A4B;
	Tue, 10 Feb 2026 01:02:23 +0100 (CET)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id 81FC640A4B
 for <dev@dpdk.org>; Tue, 10 Feb 2026 01:02:22 +0100 (CET)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4362197d174so172594f8f.3
 for <dev@dpdk.org>; Mon, 09 Feb 2026 16:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770681742;
 x=1771286542; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k4wDbXGzzw/WfaPvT1wL6uZXToJNS/HoeZDoZJiao3I=;
 b=Z7j9dUFkOWWWs70gdKC/CkWWsju5yWuBldkKV1+rQx+f3Xbcp1FjS8QOCKo2uwcS/w
 RGIZtOMByXRPe+1/0Hn1m+SqCfkstY7ObfOZtT8sirxJJb2J9OJyzpglqEVmVj8AySCo
 62zuPfAJ4i3BTItqYT5ClMjUlHFqRtmMx0a907m7xLTGy8q0g5cuHshZTDdZYcChfrRf
 cfWaM9Alvw4Qye4N1tWJtgP4H/yN1SLwDMV41fmcYeqD8M7eYIKJjtSZTLEQQ2CZdDpD
 AjOKXYPGDm5TFYYdSyse4/OvpzEYvNrqRAbMhbA2K++OU2LtY8H2eYepLEU0HboV5iPi
 MJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770681742; x=1771286542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k4wDbXGzzw/WfaPvT1wL6uZXToJNS/HoeZDoZJiao3I=;
 b=djBb/Zfg3KWC9QtiDuKQi3ufcZqHdqhw4Trn6wKCEeQmykF2HBYYQZ0N4wkoyTY4zT
 8xEVn4Pht9qFDbKBHN6ZNB8bgRO+TAtQkxugRhkF0OPiLxAm/DcxvO1Sd0h9qdn95uDI
 HHU9JdcnRyVxE8o0DKhS1nK4HilLogz+VLmiTWiAhp73O7BlibqKmLZBsnaqx6Wis8ao
 vpYEq5C9TnK+3oXW8qZoHJQLynNG1qNYmdE0DAyb+7M0H9a4G0PLjzO5JX8vNjAbu5Rt
 hmTbCwfU9VRKHppMk2hEH/B28zkZ9Aa0uuP08apALqGWbxj3kniDFPOrRvuAgMD7uleI
 fBNQ==
X-Gm-Message-State: AOJu0Yxdg62+ATznVAau1URWsVoZ4zpnaxOj3vjaZRiur2iNBeXPegr6
 iCNje9D+tkFB9IaktPJaJlvRVWY9KjQMd2ktx2ebdQ1HsBbgkO0AAPp6PNgm9CwYbe8pdgeIOAq
 rtZVT
X-Gm-Gg: AZuq6aJEMNaj9vbwRybj9s1M3f4USDy/rIOymhCJpFuhI2bxs4ICveukNyOX1AjnMp2
 bRYWVKMslLvx0f+JztZ0nzJBP+b5eRnudDn43GmANWUN6FT3H9I+iXB/uHUzhTlyjg1kxTyvj18
 QBhr3SrTXjICGHh9a7QBM2N8VyaH1h9E+qYTvVZaHIIOoKAIGFGaVZg10ZDL+aWkIYZKH7/ygFk
 zwjI+JOPRKBXj09IF04GnjqQ6bkwuZUyDKT3WiV+Dhuf6RJaSxA4r/8IIq8DVM/+xjKpghCNBIK
 HO8N/jGloRC/7w7o5sJfGtPyGMCAgAIpAneWOhnsum3/s7FgqdAy7Z+6pVRwiCevV2YTpx2600c
 dHdSmbcxdUDuvkeEWcdOpNWpSpmBnLcZF2zIl2n3AQN15xm4399Uct84EwXHSy4bYenkrAtTMwn
 a1Ch381vIZlPulW9NXdflJoQsrjWoiJO+2EYrysiQk2J/WWBQPwg==
X-Received: by 2002:a05:6000:24c9:b0:435:a2f8:1534 with SMTP id
 ffacd0b85a97d-4362937e19fmr19116678f8f.49.1770681741998; 
 Mon, 09 Feb 2026 16:02:21 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bd211sm31529133f8f.13.2026.02.09.16.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 16:02:20 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v13 08/16] net/pcap: support VLAN insert and strip
Date: Mon,  9 Feb 2026 16:00:39 -0800
Message-ID: <20260210000201.295839-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260210000201.295839-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260210000201.295839-1-stephen@networkplumber.org>
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
 doc/guides/nics/features/pcap.ini      |   1 +
 doc/guides/nics/pcap_ring.rst          |  11 +++
 doc/guides/rel_notes/release_26_03.rst |   4 +
 drivers/net/pcap/pcap_ethdev.c         | 117 ++++++++++++++++++++++++-
 4 files changed, 129 insertions(+), 4 deletions(-)

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
index 031eaa657e..c97ab7c3ca 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -63,6 +63,10 @@ New Features
 
   * Added support for pre and post VF reset callbacks.
 
+* **Updated PCAP ethernet driver.**
+
+  * Added support for VLAN insertion and stripping.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index b77fa85dd4..7fb6d98d75 100644
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
@@ -383,6 +393,56 @@ calculate_timestamp(struct timeval *ts) {
 	}
 }
 
+
+/*
+ * If Vlan offload flag is present, insert the vlan.
+ * Returns the mbuf to send, or NULL on error.
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
+		/* Extract original ethernet header into new mbuf */
+		memcpy(rte_pktmbuf_mtod(mh, void *), rte_pktmbuf_mtod(mb, void *), RTE_ETHER_HDR_LEN);
+		mh->nb_segs = mb->nb_segs + 1;
+		mh->data_len = RTE_ETHER_HDR_LEN;
+		mh->pkt_len = mb->pkt_len;
+		mh->ol_flags = mb->ol_flags;
+
+		mb->data_len -= RTE_ETHER_HDR_LEN;
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
+	tx_queue->tx_stat.err_pkts++;
+	return -1;
+}
+
 /*
  * Callback to handle writing packets to a pcap file.
  */
@@ -408,13 +468,17 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
 
@@ -493,6 +557,9 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		return 0;
 
 	for (i = 0; i < nb_pkts; i++) {
+		if (eth_pcap_tx_vlan(tx_queue, &bufs[i]) < 0)
+			continue;
+
 		struct rte_mbuf *mbuf = bufs[i];
 		uint32_t len = rte_pktmbuf_pkt_len(mbuf);
 
@@ -740,8 +807,13 @@ eth_dev_stop(struct rte_eth_dev *dev)
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
 
@@ -757,7 +829,9 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
-	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
+		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
+	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
 
 	return 0;
 }
@@ -904,6 +978,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	pcap_q->mb_pool = mb_pool;
 	pcap_q->port_id = dev->data->port_id;
 	pcap_q->queue_id = rx_queue_id;
+	pcap_q->vlan_strip = internals->vlan_strip;
 	dev->data->rx_queues[rx_queue_id] = pcap_q;
 
 	if (internals->infinite_rx) {
@@ -913,6 +988,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 		uint64_t pcap_pkt_count = 0;
 		struct rte_mbuf *bufs[1];
 		pcap_t **pcap;
+		bool save_vlan_strip;
 
 		pp = rte_eth_devices[pcap_q->port_id].process_private;
 		pcap = &pp->rx_pcap[pcap_q->queue_id];
@@ -932,11 +1008,20 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
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
@@ -946,6 +1031,9 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 					(void * const *)bufs, 1, NULL);
 		}
 
+		/* Restore offloads for use during packet delivery */
+		pcap_q->vlan_strip = save_vlan_strip;
+
 		if (rte_ring_count(pcap_q->pkts) < pcap_pkt_count) {
 			infinite_rx_ring_free(pcap_q->pkts);
 			PMD_LOG(ERR,
@@ -1030,6 +1118,26 @@ eth_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
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
@@ -1046,6 +1154,7 @@ static const struct eth_dev_ops ops = {
 	.link_update = eth_link_update,
 	.stats_get = eth_stats_get,
 	.stats_reset = eth_stats_reset,
+	.vlan_offload_set = eth_vlan_offload_set,
 };
 
 static int
-- 
2.51.0

