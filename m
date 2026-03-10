Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C09DFD4F05
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 16:15:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0A7A40ED9;
	Tue, 10 Mar 2026 17:14:17 +0100 (CET)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42]) by mails.dpdk.org (Postfix) with ESMTP id 561F040E48
 for <dev@dpdk.org>; Tue, 10 Mar 2026 17:14:14 +0100 (CET)
Received: by mail-ot1-f42.google.com with SMTP id
 46e09a7af769-7d74aa6bcdbso1266852a34.2
 for <dev@dpdk.org>; Tue, 10 Mar 2026 09:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773159253;
 x=1773764053; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PGfJsvIVG8iB5mvI9cl6jYfRWpRIr76cLTzx+u/CM9Q=;
 b=qxDml7IdzbGCggCtXAydoUs92OvEZyeSoxvfnrPpRVzg5Onc7qOttGS6T4rTqIAqb/
 PKfed6IOyDZ6zkkJy/uVvB2auGW3ijWVGyj8J6gfNussVRwQPBs6qJRjPGpT5xx+i2OT
 s1ZLkh9FHKJM8XDR60MStzXwa+2H0hcRd2nqwmBFhjH6VWd+XkTUO/K2MhGw48vCVS/5
 EDvx3HyIqxH3hZbntziZsaQoly643jZL9RKcfzh7bSvdTHE8CVSooAXQM2Xd8JUcTZo3
 PjbxYYptOYNVrs7qT9b08sEcOc5Nvw+jLsNIANrAo/WkH1RzCrMVgV8OlTdxSBxoviUc
 LUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159253; x=1773764053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PGfJsvIVG8iB5mvI9cl6jYfRWpRIr76cLTzx+u/CM9Q=;
 b=OPzm4JLJ5+vKWcIdhjET9ZMR5ekJ2SdOpvgrJTW2cVoTHj77sw2DnZplEkoTcLVr9M
 JNZseoQu9oqfHUgi5Cr2tLlEjCJhZjliiRGRtXf175f0/3umFxdjMqgkYtjJvKdq5j3r
 r58WAqYC4VSo2xQ0PeXOggMwLEEmO+O2dZu+iYP9T6FiPwaKahkRosJm90FizN+G0Jr1
 ELwwYf2cV4l9Yo5blF5qpEcAosLassFjZoVeV9caiOYuHWDnZ9Zh5rvgl8z7P/5yRxLP
 TqHmFrt0QRuj83XTZE8TAriTGQfE0tXpm7OmVQAhQmbRgjbNZ7nwIRgyZDHdUVuhwnXi
 tL+w==
X-Gm-Message-State: AOJu0YybR76I5Lq8LjRdHxymlK5fq18U4mdiHqBGLrWV3DQ/WQb1/rUO
 1v/j4bFbzq11QjN0EUoW+sMinwFaqiXeQ7Kn6coE4WJB/Z82nE+mRjnCCITFiwqVpK7/P7Etrsq
 QLyGE7tw=
X-Gm-Gg: ATEYQzzB6zLhpc1/B5R8j1uR09bwfdXQfgP73Uify6iMn1qL25kEdKZ6hVUOZ6uSDF/
 ZEVjRqjYwjTnlQv1f2A7lW5rIXJ/kpE5msWcyysO7EIPCE46m9b8SZErVEFT1/RWKs21a0LO1Ee
 QVv/G9MecAVGBdC0L30/xd4vNg9iq+kSTuqkb2Zr1cnDich4S+QHtggfZwNy3JObcl42Ul4of1c
 ZDUKrHL4LKpKSSeKvsW12+fox2fE6YJi3/rCqKVTrXGJb7qYCCtEXSUUU2idkS4aYy8mMg+mDg9
 8S1Od8gkOr6OgOGmY4qu14YezbcNbbo7VOLQI5ZXJN+mXH6tH37m2OZDTETy0eCFtpdWPr+sed0
 DqceSFZD7j/sjzc37Xzgx/AzIs+C59zX92fOC3ZNPhw7zU3bS8qmQpefaXuJNtIC4U7tfz5WEbH
 ibNBy6RCdT7TPxCptqGR1UM7NDgy75/PnW
X-Received: by 2002:a05:6830:2784:b0:7cf:e57f:df1b with SMTP id
 46e09a7af769-7d726fdbe89mr10156560a34.26.1773159253579; 
 Tue, 10 Mar 2026 09:14:13 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d738e3f421sm7304004a34.25.2026.03.10.09.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:14:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v20 12/25] net/pcap: support VLAN strip and insert offloads
Date: Tue, 10 Mar 2026 09:09:50 -0700
Message-ID: <20260310161356.194553-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310161356.194553-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
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
and af_packet drivers implement it. This also gets used for
capture of VLAN tagged packets when legacy pdump is used.

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
 doc/guides/nics/features/pcap.ini      |  1 +
 doc/guides/nics/pcap.rst               | 11 +++
 doc/guides/rel_notes/release_26_03.rst |  5 ++
 drivers/net/pcap/pcap_ethdev.c         | 96 ++++++++++++++++++++++++--
 4 files changed, 109 insertions(+), 4 deletions(-)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index c4f0360a06..ec7c91c650 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -9,6 +9,7 @@ Queue start/stop     = Y
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
index d121951f5c..6aef623bf8 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -118,6 +118,11 @@ New Features
   Added handling of the key combination Control+L
   to clear the screen before redisplaying the prompt.
 
+* **Updated PCAP ethernet driver.**
+
+  * Added support for VLAN insertion and stripping.
+
+
 Removed Items
 -------------
 
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index c3270a676c..c49ca7fa2b 100644
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
@@ -106,6 +107,7 @@ struct pmd_internals {
 	bool single_iface;
 	bool phy_mac;
 	bool infinite_rx;
+	bool vlan_strip;
 };
 
 struct pmd_process_private {
@@ -270,7 +272,11 @@ eth_pcap_rx_infinite(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
@@ -336,6 +342,10 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		}
 
 		mbuf->pkt_len = len;
+
+		if (pcap_q->vlan_strip)
+			rte_vlan_strip(mbuf);
+
 		uint64_t us = (uint64_t)header->ts.tv_sec * US_PER_S + header->ts.tv_usec;
 
 		*RTE_MBUF_DYNFIELD(mbuf, timestamp_dynfield_offset, rte_mbuf_timestamp_t *) = us;
@@ -382,6 +392,39 @@ calculate_timestamp(struct timeval *ts) {
 	}
 }
 
+static uint16_t
+eth_pcap_tx_prepare(void *queue __rte_unused, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
+{
+	uint16_t nb_tx;
+	int error;
+
+	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
+		struct rte_mbuf *m = tx_pkts[nb_tx];
+
+#ifdef RTE_LIBRTE_ETHDEV_DEBUG
+		error = rte_validate_tx_offload(m);
+		if (unlikely(error)) {
+			rte_errno = -error;
+			break;
+		}
+#endif
+		/* Do VLAN tag insertion */
+		if (unlikely(m->ol_flags & RTE_MBUF_F_TX_VLAN)) {
+			error = rte_vlan_insert(&m);
+
+			/* rte_vlan_insert() could change pointer (currently does not) */
+			tx_pkts[nb_tx] = m;
+
+			if (unlikely(error != 0)) {
+				PMD_TX_LOG(ERR, "rte_vlan_insert failed: %s", strerror(-error));
+				rte_errno = -error;
+				break;
+			}
+		}
+	}
+	return nb_tx;
+}
+
 /*
  * Callback to handle writing packets to a pcap file.
  */
@@ -415,6 +458,7 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		caplen = RTE_MIN(len, RTE_ETH_PCAP_SNAPSHOT_LEN);
 
 		calculate_timestamp(&header.ts);
+
 		header.len = len;
 		header.caplen = caplen;
 
@@ -496,9 +540,10 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 	for (i = 0; i < nb_pkts; i++) {
 		struct rte_mbuf *mbuf = bufs[i];
-		uint32_t len = rte_pktmbuf_pkt_len(mbuf);
+		uint32_t len;
 		const uint8_t *data;
 
+		len = rte_pktmbuf_pkt_len(mbuf);
 		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) && len > RTE_ETH_PCAP_SNAPSHOT_LEN)) {
 			PMD_TX_LOG(ERR,
 				"Dropping multi segment PCAP packet. Size (%u) > max size (%u).",
@@ -749,8 +794,13 @@ eth_dev_stop(struct rte_eth_dev *dev)
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
 
@@ -766,7 +816,9 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
-	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
+		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
+	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
 
 	return 0;
 }
@@ -913,6 +965,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	pcap_q->mb_pool = mb_pool;
 	pcap_q->port_id = dev->data->port_id;
 	pcap_q->queue_id = rx_queue_id;
+	pcap_q->vlan_strip = internals->vlan_strip;
 	dev->data->rx_queues[rx_queue_id] = pcap_q;
 
 	if (internals->infinite_rx) {
@@ -922,6 +975,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 		uint64_t pcap_pkt_count = 0;
 		struct rte_mbuf *bufs[1];
 		pcap_t **pcap;
+		bool save_vlan_strip;
 
 		pp = rte_eth_devices[pcap_q->port_id].process_private;
 		pcap = &pp->rx_pcap[pcap_q->queue_id];
@@ -941,11 +995,20 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
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
@@ -955,6 +1018,9 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 					(void * const *)bufs, 1, NULL);
 		}
 
+		/* Restore offloads for use during packet delivery */
+		pcap_q->vlan_strip = save_vlan_strip;
+
 		if (rte_ring_count(pcap_q->pkts) < pcap_pkt_count) {
 			infinite_rx_ring_free(pcap_q->pkts);
 			PMD_LOG(ERR,
@@ -1039,6 +1105,26 @@ eth_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
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
@@ -1055,6 +1141,7 @@ static const struct eth_dev_ops ops = {
 	.link_update = eth_link_update,
 	.stats_get = eth_stats_get,
 	.stats_reset = eth_stats_reset,
+	.vlan_offload_set = eth_vlan_offload_set,
 };
 
 static int
@@ -1395,6 +1482,7 @@ eth_from_pcaps(struct rte_vdev_device *vdev,
 		eth_dev->rx_pkt_burst = eth_null_rx;
 
 	/* Assign tx ops. */
+	eth_dev->tx_pkt_prepare = eth_pcap_tx_prepare;
 	if (devargs_all->is_tx_pcap)
 		eth_dev->tx_pkt_burst = eth_pcap_tx_dumper;
 	else if (devargs_all->is_tx_iface || single_iface)
-- 
2.51.0

