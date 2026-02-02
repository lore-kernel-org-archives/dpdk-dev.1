Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B34E7FDF8
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 23:14:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 301E3406B8;
	Tue,  3 Feb 2026 00:13:13 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 4DFD440673
 for <dev@dpdk.org>; Tue,  3 Feb 2026 00:13:12 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4359228b7c6so3503542f8f.2
 for <dev@dpdk.org>; Mon, 02 Feb 2026 15:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770073992;
 x=1770678792; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8TPzVbmv403no/w4N4QMmmAWBEIVmoWxCogdOBJGAA=;
 b=AENHlmtJIAldCj6ZOo8hFbLp0/m1b5A70fIdYNYgdpBaswsW8I/TLlc15Kp1o1vOfA
 fGgndwMVCiE/iDqYLPcau8sfF5W2oIFG1Xn+gl3ZwWDLt/uai2wQHKhN/8kIAy+BiKoq
 4fFXCsNdHQKimlnpdZdXc5p83OkL/Q/JJawNRSm1hBtsxURQexx3OAaWuGSsn1jTWMq+
 q4dOuZrtKfTOVzjzgDxabvw0pj9FQUHC86bQaQLl6l2Is1DesJnGRqUKrMXt4I6zPctJ
 hRX4p0XVxN6ZGU65C0jp6dkTjGccXjGz95cOUhC83s5fT7o4/IRd0d9MNYIz8b/vL+GH
 pQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770073992; x=1770678792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z8TPzVbmv403no/w4N4QMmmAWBEIVmoWxCogdOBJGAA=;
 b=nk8kttj0C9jzTXagcW42gTqhhcC/oNmad+zpsri0mq2GNzz+uzJWHSW8DNH6/AJt/J
 NDOzbejL9R6UORtzP6eTcJEnBhcLOmjzc+zcRu8qaVJpsRRTJpFzbYmbmQgw4JpY+mVi
 yjnzzfJTTR0uXO5E7pFy23f+qQdtPd4EaVzQXuNCiuzND8hjX50w4afyDt+SuLmM9xuK
 T18zY9UtGhhltpqaX5Wn+ZwNXmuf00EbZ8KEXSQnJIoxbgaEpUa4RiJwU52Rj0CPxC+c
 p6Bxp3X18HMWOb/pyNhs+gskEpZNsQDjlegKwoxkI860V04R5CTiEIflV6rlr0oKkUCH
 Mw2w==
X-Gm-Message-State: AOJu0YzZ5H2Kk4EadJCdWngA4KOVp0Yev048z5eiupkSfFC/+AnC5wMA
 cQtuhf6mEccgySeeJ7AeTPB1754WF4NWNCgXx6x1xTJpKa6D65l18Iax+pxE823EvEqeI2QRB+A
 73MJR
X-Gm-Gg: AZuq6aJ0e3/izHg44QdcBDA6J1lXOxU2dQKiL+D0R12n5kl5fVqRQrrogljVUoDlSUh
 pVD8G3a/Ux2q2AotwQMs5QmE3HLKaJpV9cxxuy1d/E6Pv7kOf4+GRxLzTNdeEQiv+wxt/lf697N
 E6N9/2P8HHiZCqB2UNqVvizo+IcbNT+z6dUrxBUmR4Jwmsx1xJBMAQet79vdZNJJVGJ/FGHI4wo
 nwEJ5/debSel68RTKAgW7jpXp5CC4QIq9Ndgr1Y4Nq1dVSOhwKs5Zf2KpwO+9+W2INr1ihEVCXk
 QwmMutCs25woOnh/PQdpP7lwX12/bufmGUBkMwG7+Xm6b9PpchqbvWpBQa4yfstcR8bZ4RlxkvD
 evCPwg1CyL7c3OrJZWwe614m5Oc4ijie3XXCLjszBcFdr7+W6xK2m6NLBtrsxLeSAV8lKBdIpdS
 PZxGihVgiurv9HXPHp3dqXmjXLjNOx2Jf9RWdWXy8HXvkj2o6skYltq3DRS4QU
X-Received: by 2002:a05:6000:1ac8:b0:432:c37c:d83a with SMTP id
 ffacd0b85a97d-435f3a86321mr20234310f8f.15.1770073991869; 
 Mon, 02 Feb 2026 15:13:11 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e48a6sm45799474f8f.8.2026.02.02.15.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 15:13:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v12 11/19] net/pcap: support VLAN insert and strip
Date: Mon,  2 Feb 2026 15:09:14 -0800
Message-ID: <20260202231245.216433-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202231245.216433-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260202231245.216433-1-stephen@networkplumber.org>
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
 doc/guides/nics/pcap_ring.rst          | 11 ++++
 doc/guides/rel_notes/release_26_03.rst |  4 ++
 drivers/net/pcap/pcap_ethdev.c         | 71 ++++++++++++++++++++++++--
 4 files changed, 84 insertions(+), 3 deletions(-)

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
index a837bdb600..9d4bdfc985 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -59,6 +59,10 @@ New Features
 
   * Added support for V4000 Krackan2e.
 
+* **Updated PCAP ethernet driver.**
+
+  * Added support for VLAN insertion and stripping.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index dcfd636fa0..957da1e0ab 100644
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
@@ -412,9 +422,16 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
 
@@ -487,6 +504,12 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		uint32_t len = rte_pktmbuf_pkt_len(mbuf);
 		const uint8_t *data;
 
+		if (mbuf->ol_flags & RTE_MBUF_F_TX_VLAN) {
+			/* if vlan insert fails treat it as error */
+			if (unlikely(rte_vlan_insert(&mbuf) != 0))
+				continue;
+		}
+
 		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) && len > RTE_ETH_PCAP_SNAPSHOT_LEN)) {
 			static int warned;
 
@@ -733,8 +756,13 @@ eth_dev_stop(struct rte_eth_dev *dev)
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
 
@@ -750,7 +778,9 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
-	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
+		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
+	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
 
 	return 0;
 }
@@ -897,6 +927,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	pcap_q->mb_pool = mb_pool;
 	pcap_q->port_id = dev->data->port_id;
 	pcap_q->queue_id = rx_queue_id;
+	pcap_q->vlan_strip = internals->vlan_strip;
 	dev->data->rx_queues[rx_queue_id] = pcap_q;
 
 	if (internals->infinite_rx) {
@@ -906,6 +937,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 		uint64_t pcap_pkt_count = 0;
 		struct rte_mbuf *bufs[1];
 		pcap_t **pcap;
+		bool save_vlan_strip;
 
 		pp = rte_eth_devices[pcap_q->port_id].process_private;
 		pcap = &pp->rx_pcap[pcap_q->queue_id];
@@ -925,11 +957,20 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
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
@@ -939,6 +980,9 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 					(void * const *)bufs, 1, NULL);
 		}
 
+		/* Restore offloads for use during packet delivery */
+		pcap_q->vlan_strip = save_vlan_strip;
+
 		if (rte_ring_count(pcap_q->pkts) < pcap_pkt_count) {
 			infinite_rx_ring_free(pcap_q->pkts);
 			PMD_LOG(ERR,
@@ -1023,6 +1067,26 @@ eth_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
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
@@ -1039,6 +1103,7 @@ static const struct eth_dev_ops ops = {
 	.link_update = eth_link_update,
 	.stats_get = eth_stats_get,
 	.stats_reset = eth_stats_reset,
+	.vlan_offload_set = eth_vlan_offload_set,
 };
 
 static int
-- 
2.51.0

