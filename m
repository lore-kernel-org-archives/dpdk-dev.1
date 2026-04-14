Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BEEF9D0DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 16:11:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DD6A40A79;
	Tue, 14 Apr 2026 18:10:33 +0200 (CEST)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com
 [209.85.160.47]) by mails.dpdk.org (Postfix) with ESMTP id 36BCF40A4B
 for <dev@dpdk.org>; Tue, 14 Apr 2026 18:10:30 +0200 (CEST)
Received: by mail-oa1-f47.google.com with SMTP id
 586e51a60fabf-4043b909ed4so3183933fac.3
 for <dev@dpdk.org>; Tue, 14 Apr 2026 09:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776183029;
 x=1776787829; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+JqtXBGDEW5u5/6kEBZuHBY4ES2nQlNLTox0GG0TEwI=;
 b=x0UuTbt4mFb7nSImqPyQA6EBaAsnUXd1yUH3Fl7B9FrOSjTmQVYwuHmJ3gQHHOJHfU
 xzKn0AJKb6M0TH/1Bqn0QQSfBvDv4DJyoZG0U1blK2gCqQQaict7ofxTJCyjv/6AJCl/
 ZT7/e1ihBsVjDApDDAlGr/5S8BS08i426jDuPVpSf8YKOua5Sd1OGMlovGey/41DioRh
 IDuMphZLfyXo0Oaeh7gzzvRbQAoA9Kr8oALA+Q55UMCkkJsGw0FK/wxi/GmLEDsCJDVi
 jfZYMj7GcgCTE5uCUbHxycm3hx58x0WvTVAH5OGAwYq3SCtFE0324ZfRE/C4dqZbHs5Y
 pTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776183029; x=1776787829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+JqtXBGDEW5u5/6kEBZuHBY4ES2nQlNLTox0GG0TEwI=;
 b=CfkbN/1ipoUyfy6/3xhcCu5qTQ8pVdAlOz3SIbFhVyhUVVC7ppT5AdUCMHPrGqbUTj
 ujASMk4tSvjthqxpz5MEiRbmaTLTrdDu5yF8vMj+0naeLlDP7DXd+3K7jDI1w0nhoDrO
 Xh8FznZGy6UVJ/gNs02nxaBupLLcewdmZhl9pqjWNnM1qn3F61U4qFfrXSBf5ARTynxr
 +wr42VcEsLulHTvUMj40CjkqhTKtPHiTUuDP+vey5pElg2n3s4TSQLQKP2Htpr91ueFw
 t+HSEZrglRmbb6WtI/TtWHVQvRgguhxMY/rREmQoWA0QHn2ljJ/3O7JEAQitI4+isjZc
 xEwQ==
X-Gm-Message-State: AOJu0Yxt2hVf4EIMlSZZrOBzjyTSnZ/YAY9mFp282LcuidCJbZ+F9We9
 jUmwjes6Bjix+W8A+KOAxpa/bPIj89tyolBM5coWvTBWf9wXUDKeQ+1UFg/1OJ3n5FZpA3w3zO8
 sskxE
X-Gm-Gg: AeBDietmhQ8770SZ0aDmXYeW336HiBi/qmtC7dYEEOHA3ONc/+IY4SK4m/VByWySWCN
 dFcT6vWVhwXaPkZMpqlREfeYdA9FEtjWvruUhKhfxQBphIv7FqFF7Wx1UlNmAoFgR/NoOrTeTTi
 oA2qFC9YaC9IFbd7PBqhozDL16Qx+e2o4zdRMm6XL0N4Py42+fV68oDl1Kw79derH2971gXGqY6
 e6PnoqH8wHQccfFPKsye1P4vEsYJoHkYmZly7KdInQiUpcJv4XnUn4gceXtUU36lh6TbtUbi186
 kwFE4qwr/j1vow1UO/TsIj2p20qT3sw6si+XuIm6R8WkAqgfxc5Auy+PENVE+4Lc3L6t7aMkDp8
 ctBThmWreXBJ/phLvYkP7xlYbA6ldNOX/cXno+AzooaK+nrvCI7kijZrhXahWMQYpG4P8U7ebgx
 9O/q//hYYHC/t9dxaWcpubMkrdea44H9egSL/Y4PHBkcY=
X-Received: by 2002:a05:6870:5d91:b0:41b:ff2c:de23 with SMTP id
 586e51a60fabf-423e0e2c330mr12142786fac.10.1776183029237; 
 Tue, 14 Apr 2026 09:10:29 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd396960sm11809554fac.2.2026.04.14.09.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 09:10:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v22 13/24] net/pcap: support VLAN strip and insert offloads
Date: Tue, 14 Apr 2026 09:08:04 -0700
Message-ID: <20260414161011.756101-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414161011.756101-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260414161011.756101-1-stephen@networkplumber.org>
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
 doc/guides/rel_notes/release_26_07.rst |   4 +
 drivers/net/pcap/pcap_ethdev.c         | 120 ++++++++++++++++++++++++-
 4 files changed, 131 insertions(+), 4 deletions(-)

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
index 060b26ff61..44f7164f9a 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
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

