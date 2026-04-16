Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B229F8D765
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:53:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB97B40DD1;
	Thu, 16 Apr 2026 20:52:05 +0200 (CEST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id B2BD740B8C
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:52:01 +0200 (CEST)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-12c565dd3a7so771845c88.1
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365521;
 x=1776970321; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qm2zRDOAn+hCf6WIw1pRWLJKrkH2rHmCaXzsjpSeu88=;
 b=JGP0hAbfvWt2SpvHI9Yuk40jtP+r7W+3bqwIFB93Hp/tu9SYGhvXwOOV8EoMbUTC2/
 nyciBOKqL42UUffR7muU1nN0ppzWMYfa2m2x8dZtG88TgxnBPT0t8RIRp9LANfD5Mr24
 e3h7eZs/NP9BspINg5UX0eAGlyZEhm5OR913/ha+mtR1C/Q5YuUtxatFs5dI0tohqrOw
 WSU4NzG+Y8FkEP4s3Nvgg4k0eQy2l4xF7iPf0slDms2peBobBiVJO0WIxVzdrfreutDH
 zK1LMiOTgQo3v16yfIImYcI+X1MC6hHTOKQ31hPfbUaMiUM3wQnrCOtxikFCqYFyxqz9
 GWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365521; x=1776970321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qm2zRDOAn+hCf6WIw1pRWLJKrkH2rHmCaXzsjpSeu88=;
 b=LQS9C1hCcPLDjW3+7464E5AQHOfg5RUZxvxJbHJZzi4r+HDtn+pz00YaVJLzNGabHR
 QgJGbCNY6J1UQtoKdiUYu0nd9uNsDUjv7WJVKBVnwZIB62SlqWVcEKLfyTuwRgrE2pH8
 suOkikQb4kos3vpkfHMPjSfOwwOhGATmzX+qsb9sgP/w5Pt3EKVBkNzbH5kQQ3zcL/8i
 q4UgWYsP+LZM8Tp+Lbtg1Yr87Zz2r8bYMa//PnYFn3E9mXRty/arT6xnPwY5HbFuBvZB
 XakJykxr3fhlyPMg25xycCt3991q+u44DPtiggV55F8AXeQ5yd/v2RGRgsF2pTjuZnhJ
 1wwA==
X-Gm-Message-State: AOJu0YyOW0snpZ14xdTROeajt4PKSRUGcyIVZBJlCoxkdevegFZOOtE3
 zaFTZJvNkmoL/2CbFTbDDjFKuC+qpv6cE56lx9OSXdydP7tDBQrTnGwmEnKsh6z+ni8HvAUdQrg
 aAJl0
X-Gm-Gg: AeBDiesnCTPgN7cAF6sRYvaPe5kjeZrANV6QW7uLvwphh38BdAp1BjDwRU+OfAWZ4mO
 tk2rv7C5pkv/RGme/JferhqQgbdQaT8CEx7HFDSZkQWLYDKOVK77eb9yhGDNXFykuvhE6myJutG
 uxfeAwZoL7tx/hsTb7wmttYRXGmrytN3D/nR/zB1ZJnfbOJEm7B1c1+yzVr5p0dzSJtGcBepEdI
 1WHMr2If3itco2wt5xdWBdWGkLIvlQH7hrpnt3/2OMTs9aK3PiMT9Z5SjBpYN1Ld2QuleB5xU9z
 5qSgUJ+EaCwVn00EOkSI2IlNODNq0uk74v1c85vGsZMZ8yM2ntXFC/dXqDVsHTwk5itda3nHN3o
 u2C21WYcxSBxWPxT6TCaP/gNcqEkQasKefi0539kIaf8n799hnXGuRw3bnq7DYX1PqyxOwJ+8lc
 RSALTl+pi2tZjy3PRJQzOIwWIj+vTP2pjj4t9UXzAZ9QDkqYngBwc11Q==
X-Received: by 2002:a05:7300:748b:b0:2d8:c521:c157 with SMTP id
 5a478bee46e88-2e2e5610050mr286409eec.18.1776365520655; 
 Thu, 16 Apr 2026 11:52:00 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8f6615d5sm10602510eec.24.2026.04.16.11.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:52:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v24 13/24] net/pcap: support VLAN strip and insert offloads
Date: Thu, 16 Apr 2026 11:48:30 -0700
Message-ID: <20260416185144.1359260-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416185144.1359260-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260416185144.1359260-1-stephen@networkplumber.org>
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

Add VLAN tag handling to the pcap PMD, similar to virtio
and af_packet drivers. This also helps if with
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
 doc/guides/nics/features/pcap.ini      |   1 +
 doc/guides/nics/pcap.rst               |  10 +++
 doc/guides/rel_notes/release_26_07.rst |   5 ++
 drivers/net/pcap/pcap_ethdev.c         | 120 ++++++++++++++++++++++++-
 4 files changed, 132 insertions(+), 4 deletions(-)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index 99ba3b8e1f..9f234aa7b9 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -9,6 +9,7 @@ Queue start/stop     = Y
 Timestamp offload    = P
 Basic stats          = Y
 Stats per queue      = Y
+VLAN offload         = Y
 Multiprocess aware   = Y
 FreeBSD              = Y
 Linux                = Y
diff --git a/doc/guides/nics/pcap.rst b/doc/guides/nics/pcap.rst
index fbfe854bb1..2c5fc0b500 100644
--- a/doc/guides/nics/pcap.rst
+++ b/doc/guides/nics/pcap.rst
@@ -247,3 +247,13 @@ will be discarded by the Rx flushing operation.
    The network interface provided to the PMD should be up.
    The PMD will return an error if the interface is down,
    and the PMD itself won't change the status of the external network interface.
+
+Features and Limitations
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+*  When ``RTE_ETH_RX_OFFLOAD_VLAN_STRIP`` is enabled, the driver removes the
+   outermost VLAN tag from received packets via ``rte_vlan_strip()``.
+   The strip setting can be changed at runtime through ``vlan_offload_set``.
+
+*  The PMD will transparently insert a VLAN tag to transmitted packets if
+   the mbuf has ``RTE_MBUF_F_TX_VLAN`` set.
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index f012d47a4b..f6af296684 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -63,6 +63,11 @@ New Features
     ``rte_eal_init`` and the application is responsible for probing each device,
   * ``--auto-probing`` enables the initial bus probing, which is the current default behavior.
 
+* **Updated PCAP ethernet driver.**
+
+  * Added support for VLAN insertion and stripping.
+
+
 
 Removed Items
 -------------
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 955eaf17e2..0bd95d6f01 100644
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
@@ -382,6 +392,45 @@ calculate_timestamp(struct timeval *ts) {
 	}
 }
 
+/*
+ * Insert VLAN tag into packet.
+ *
+ * rte_vlan_insert() modifies the mbuf in place, prepending
+ * RTE_VLAN_HLEN bytes. If mbuf cannot safely be modified in place
+ * a private copy is made first.
+ *
+ * The caller's mbuf pointer is updated on success; on failure the
+ * original mbuf is freed and -1 is returned.
+ */
+static int
+pcap_tx_vlan_insert(struct rte_mbuf **m)
+{
+	struct rte_mbuf *mbuf = *m;
+
+	if (rte_mbuf_refcnt_read(mbuf) > 1 ||
+	    rte_pktmbuf_headroom(mbuf) < RTE_VLAN_HLEN) {
+		struct rte_mbuf *copy;
+
+		copy = rte_pktmbuf_copy(mbuf, mbuf->pool, 0, UINT32_MAX);
+		if (unlikely(copy == NULL)) {
+			rte_pktmbuf_free(mbuf);
+			return -1;
+		}
+		copy->ol_flags |= RTE_MBUF_F_TX_VLAN;
+		copy->vlan_tci = mbuf->vlan_tci;
+		rte_pktmbuf_free(mbuf);
+		*m = copy;
+		mbuf = copy;
+	}
+
+	if (unlikely(rte_vlan_insert(&mbuf) != 0)) {
+		rte_pktmbuf_free(mbuf);
+		return -1;
+	}
+	*m = mbuf;
+	return 0;
+}
+
 /*
  * Callback to handle writing packets to a pcap file.
  */
@@ -411,10 +460,20 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		uint32_t len, caplen;
 		const uint8_t *data;
 
+		/* Do VLAN tag insertion */
+		if (unlikely(mbuf->ol_flags & RTE_MBUF_F_TX_VLAN)) {
+			if (pcap_tx_vlan_insert(&mbuf) != 0) {
+				dumper_q->tx_stat.err_pkts++;
+				continue;
+			}
+			bufs[i] = mbuf;
+		}
+
 		len = rte_pktmbuf_pkt_len(mbuf);
 		caplen = RTE_MIN(len, RTE_ETH_PCAP_SNAPSHOT_LEN);
 
 		calculate_timestamp(&header.ts);
+
 		header.len = len;
 		header.caplen = caplen;
 
@@ -496,9 +555,20 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 	for (i = 0; i < nb_pkts; i++) {
 		struct rte_mbuf *mbuf = bufs[i];
-		uint32_t len = rte_pktmbuf_pkt_len(mbuf);
+		uint32_t len;
 		const uint8_t *data;
 
+		/* Do VLAN tag insertion */
+		if (unlikely(mbuf->ol_flags & RTE_MBUF_F_TX_VLAN)) {
+			if (pcap_tx_vlan_insert(&mbuf) != 0) {
+				tx_queue->tx_stat.err_pkts++;
+				continue;
+			}
+			bufs[i] = mbuf;
+		}
+
+		len = rte_pktmbuf_pkt_len(mbuf);
+
 		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) &&
 				len > RTE_ETH_PCAP_SNAPSHOT_LEN)) {
 			PMD_TX_LOG(ERR,
@@ -746,8 +816,13 @@ eth_dev_stop(struct rte_eth_dev *dev)
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
 
@@ -763,7 +838,9 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
-	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
+		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
+	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
 
 	return 0;
 }
@@ -910,6 +987,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	pcap_q->mb_pool = mb_pool;
 	pcap_q->port_id = dev->data->port_id;
 	pcap_q->queue_id = rx_queue_id;
+	pcap_q->vlan_strip = internals->vlan_strip;
 	dev->data->rx_queues[rx_queue_id] = pcap_q;
 
 	if (internals->infinite_rx) {
@@ -919,6 +997,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 		uint64_t pcap_pkt_count = 0;
 		struct rte_mbuf *bufs[1];
 		pcap_t **pcap;
+		bool save_vlan_strip;
 
 		pp = rte_eth_devices[pcap_q->port_id].process_private;
 		pcap = &pp->rx_pcap[pcap_q->queue_id];
@@ -938,11 +1017,20 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
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
@@ -952,6 +1040,9 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 					(void * const *)bufs, 1, NULL);
 		}
 
+		/* Restore offloads for use during packet delivery */
+		pcap_q->vlan_strip = save_vlan_strip;
+
 		if (rte_ring_count(pcap_q->pkts) < pcap_pkt_count) {
 			infinite_rx_ring_free(pcap_q->pkts);
 			PMD_LOG(ERR,
@@ -1036,6 +1127,26 @@ eth_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
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
@@ -1052,6 +1163,7 @@ static const struct eth_dev_ops ops = {
 	.link_update = eth_link_update,
 	.stats_get = eth_stats_get,
 	.stats_reset = eth_stats_reset,
+	.vlan_offload_set = eth_vlan_offload_set,
 };
 
 static int
-- 
2.53.0

