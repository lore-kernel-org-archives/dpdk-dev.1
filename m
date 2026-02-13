Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129F9EDF17D
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 17:04:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 529F440678;
	Fri, 13 Feb 2026 18:03:55 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id A179D4065A
 for <dev@dpdk.org>; Fri, 13 Feb 2026 18:03:53 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-483487335c2so10577255e9.2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 09:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771002233;
 x=1771607033; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PSnqud5rxY1WDls8mJYv0gyxSy0OtgymXz/APsb32i8=;
 b=Vm3rwaEEYu5Cq3BJZ/Tcj4tFTQLEQutYWdxCSG6eChh2Jr6v4GDlFR8B8CdmWvgsPW
 GI7nx4nKOUPM8K4hCndkR6ms3fp6NfI5xvX05KBux4+RvxIJzLsafBHWW2v39CirgCut
 usEupOurTmqDypI4gsWnCLvhy2oPtY72N1km7aKYGbmxjx7OW1ORlLejL3UO1Hq8hqX4
 BJfKZarAxX4ib7QSss7dKAsnUY0+dfZ+aS2QMJOZtOv6kcautt7U1BmcmSRD1gALiu6e
 xjasSWU0YHJYM46vBNO09NyEGHyytJr4PfH4KN2jUwVbV4hqCV98q1qM/YhYfwAlXGCM
 t2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771002233; x=1771607033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PSnqud5rxY1WDls8mJYv0gyxSy0OtgymXz/APsb32i8=;
 b=D0kQ8grFrByb47YO/tjQKKbv7qp7MigwOtKhzkCNFHaXzMjerOTKDGbTKYnK88cH2I
 bckroajmXVTJlrfZtaaGPetLcpsJCJMJwqMtpf1VJSrnvtkZE7GF7MO3OVNEeZ6yBN9+
 W5fuyLMzAwgbvoOuZrJyKIswn6wTyQWQboKCsJN6beeH621hlB8Twj83YWut6XZLiCEQ
 k2hCV3GSwVZc6LRycNGl88ZxATVT8lgJdBRo14NXD4BY/w8BPia3iIXzXG5V3khCrvcs
 7XRNQn6c5wBXdncL2IRTJmCUkAeJI3eNbqRrWJHvFNdfMenm1dCjuRjAmlASwAFKAHXe
 chZA==
X-Gm-Message-State: AOJu0YzXytK109zashy/kFSsIxzLKG9Cko/IH0tWhVyVwioR4GtWmubn
 X/UVtkfa20v+up2IDaQRoyLnyG8EVFkwi49Sw/8mNrk9MJ/vUgB8mQfPvXhHfqHK4zNYNb3wLrC
 nYVTy
X-Gm-Gg: AZuq6aJnGMFtmp2YojDkAsl2qXozOOU7M49ECHtAVo7NIqf+ecBSuAm46eOpAUl2Hb0
 pWYtQ8oFT5EEKdPcu+fzHDi5gQwCrUbYxxb52hDcI7nMSOo2CRzIZDyCoN4nqR2+TOFT6Dx/blq
 /NXCb9P3c7LeOEvxHgxsXq3NgemA+5NUXEUNgZc9m5iL6IdS/EdL/9kDYZkgz4ftzNPhmhEqTnE
 EiOaZneSQdD8P/8OeizMxr9iOeey/XZnQwPy1t2AVu4JywedlcIBpnuMdO3aS2KlyHT+rFFLh1k
 TMRJgN+JLNu3Gfi5GoydzK0nEX3KjPZj15wqWVfZkWBflMj3ThOJeFotUNYgzJ5gm/E9pYke3lo
 /DuIdhhaXhyHSpfIHXdlOGCXelTfzdv1+UxwveagNwAkzyfuxN0yiavkQxsre+oObJUjUb1lJ78
 PmtRzFvbIdjHECD0JW6WnrGXScHYM61puTCA5zUM26dQvIlRmjzAENLJa56/8dTQ==
X-Received: by 2002:a05:600c:3e88:b0:480:5951:fc1e with SMTP id
 5b1f17b1804b1-48373a02bf6mr37420055e9.11.1771002233105; 
 Fri, 13 Feb 2026 09:03:53 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483740be167sm40963035e9.15.2026.02.13.09.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 09:03:52 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v15 08/18] net/pcap: support VLAN strip and insert offloads
Date: Fri, 13 Feb 2026 09:01:31 -0800
Message-ID: <20260213170333.40089-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213170333.40089-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260213170333.40089-1-stephen@networkplumber.org>
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
index afdf1af06c..fa998f1620 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -87,6 +87,10 @@ New Features
   * Added support for AES-XTS cipher algorithm.
   * Added support for SHAKE-128 and SHAKE-256 authentication algorithms.
 
+* **Updated PCAP ethernet driver.**
+
+  * Added support for VLAN insertion and stripping.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index f6adc23463..421a72a0cb 100644
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
+	/* If indirect or shared then need another buffer to hold VLAN header? */
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

