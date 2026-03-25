Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26EB103A9A0
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 02:41:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 212CC40E11;
	Wed, 25 Mar 2026 03:40:41 +0100 (CET)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id B0C1C40E3A
 for <dev@dpdk.org>; Wed, 25 Mar 2026 03:40:37 +0100 (CET)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2c0c955a481so7162324eec.1
 for <dev@dpdk.org>; Tue, 24 Mar 2026 19:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774406437;
 x=1775011237; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TEOLIDfsnO/plLhYg3ge70r0XwlPUyCfaNCOKHDD/OY=;
 b=FPkY8hxS6lPvrBwHT+XBpaL1gxaA0S7ffZGhjkxZIZ5jWIiLEqM63QX5Bs7YvRsCHT
 xlLWCdUA9sTBwPxEcp7aENUyZmp71RxJrMzz1aBZfkaA3w/g3RPH6PFuwxGN9SpjwCfs
 bEDIMQ7Y1YVVk7LOWszh2UApNzGGBPS4uRZCM5MqxPLy7jd3UPzD0YpmFRk8kUBXq1jc
 tt17w6h4chCsresF7k65wBkY+Pfjnv+Up2DRoL8FPRJyaFcYGDIQ8bwmV9EHrU+8nBzY
 /DLYaCaGXcrGY8l0/G7bgfckC9vlCOa+aAlt0iK4d+J4mfdxG4axWIvc2r3CSv4Wyid4
 nPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774406437; x=1775011237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TEOLIDfsnO/plLhYg3ge70r0XwlPUyCfaNCOKHDD/OY=;
 b=jMz0P0UJFqFKJgG0/j0XbCXoEBvH+ZbJvlk4zJ94jh3WwfQ/sxoSAXA2UFuTlnxcjR
 D7Tfwl7JhP9uH5gHIlqLLUsFOFvoJc5Hkm0s1GGSjI+aH7ZDKI8k3HSt51/rv2fZxzDE
 42J2Cqvi8iU9b2EAgEuwC0wqFzf8w9ZvTBfjNp6kbh7SwkYx0hq8DnWi8zCfK4bXrgzj
 +xj0n9Wn2j82SBzWKV1FYtJnHy1iB/QKHlkPfZYAgbs8p3oaT+YoFzxV3pn5IgmNvO0I
 /5smDxQrkNuPeV0R4afvBb2yneMPF71PYwDqb1fmS8lbNWRX2QatmQi1yQW4WJmxyCDE
 6Fwg==
X-Gm-Message-State: AOJu0YzNgyF6SEbPHlTjIUrU/3NT1j7wwwIk/lJsJagbdMPREUzQqMaj
 9WiRy7b9EvPlRculQqUOSon5hGcFeYuTf4Lhq5OrXcUeGT2oRAuRL1sMr5/Hv2hopIMdkZLJWEX
 096MW
X-Gm-Gg: ATEYQzxHl0bZ09hPXWNCrBvLKmMfh8E0wc1rrRWeJGneufuPsHi8DmKPhTeFRXepSuv
 E1CqvwtDFWwzqeovl0lAOTndlYCAT7yDEzfGqYTFVk/BP0lvxNcS4vJqpYo+LqGzdw2gBew6roG
 Xh5oZ8tHv+355qAkI6Lf2jdCpSgEv1xnc5iMAQ8JFgmO+jpNjpUkvdRULehbc1btPdPHwlN2hT6
 nrBTlaDydNlJaek41PRi0BOWVcKYIeV5GS6KJw+fp2J7YqkyaJ6X8HpP1EmQW0+fhmlvhQZjeEA
 bPnumI02xunqUkIqFb4oTTCLeeTUoVuUDtbCok0tKzoWYT3/G+RXg1rzSRpDkcy56Evs9wwnmm1
 48+JqkKcP0Y6WgjUjv2ats2+LY7XwZ75O/jKNGNOWTaSeuBMiOOiGs8I04eMGIjtmRB6LChNbxo
 DtulPv3R/MGnVzR5NocHT2XtgQJe07JNAR
X-Received: by 2002:a05:7301:19af:b0:2be:2953:fd74 with SMTP id
 5a478bee46e88-2c15d2ba3f1mr1017051eec.14.1774406436557; 
 Tue, 24 Mar 2026 19:40:36 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b29b447sm17209452eec.16.2026.03.24.19.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:40:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v21 13/25] net/pcap: support VLAN strip and insert offloads
Date: Tue, 24 Mar 2026 19:37:44 -0700
Message-ID: <20260325024018.1275209-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325024018.1275209-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260325024018.1275209-1-stephen@networkplumber.org>
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
 doc/guides/rel_notes/release_26_03.rst |  4 ++
 drivers/net/pcap/pcap_ethdev.c         | 93 +++++++++++++++++++++++++-
 4 files changed, 106 insertions(+), 3 deletions(-)

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
index 3d2ed19eb8..7a74f732d3 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -136,6 +136,10 @@ New Features
   Added handling of the key combination Control+L
   to clear the screen before redisplaying the prompt.
 
+* **Updated PCAP ethernet driver.**
+
+  * Added support for VLAN insertion and stripping.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 955eaf17e2..c16bff9198 100644
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
 
@@ -746,8 +790,13 @@ eth_dev_stop(struct rte_eth_dev *dev)
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
 
@@ -763,7 +812,9 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
-	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
+		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
+	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
 
 	return 0;
 }
@@ -910,6 +961,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	pcap_q->mb_pool = mb_pool;
 	pcap_q->port_id = dev->data->port_id;
 	pcap_q->queue_id = rx_queue_id;
+	pcap_q->vlan_strip = internals->vlan_strip;
 	dev->data->rx_queues[rx_queue_id] = pcap_q;
 
 	if (internals->infinite_rx) {
@@ -919,6 +971,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 		uint64_t pcap_pkt_count = 0;
 		struct rte_mbuf *bufs[1];
 		pcap_t **pcap;
+		bool save_vlan_strip;
 
 		pp = rte_eth_devices[pcap_q->port_id].process_private;
 		pcap = &pp->rx_pcap[pcap_q->queue_id];
@@ -938,11 +991,20 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
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
@@ -952,6 +1014,9 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 					(void * const *)bufs, 1, NULL);
 		}
 
+		/* Restore offloads for use during packet delivery */
+		pcap_q->vlan_strip = save_vlan_strip;
+
 		if (rte_ring_count(pcap_q->pkts) < pcap_pkt_count) {
 			infinite_rx_ring_free(pcap_q->pkts);
 			PMD_LOG(ERR,
@@ -1036,6 +1101,26 @@ eth_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
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
@@ -1052,6 +1137,7 @@ static const struct eth_dev_ops ops = {
 	.link_update = eth_link_update,
 	.stats_get = eth_stats_get,
 	.stats_reset = eth_stats_reset,
+	.vlan_offload_set = eth_vlan_offload_set,
 };
 
 static int
@@ -1391,6 +1477,7 @@ eth_from_pcaps(struct rte_vdev_device *vdev,
 		eth_dev->rx_pkt_burst = eth_null_rx;
 
 	/* Assign tx ops. */
+	eth_dev->tx_pkt_prepare = eth_pcap_tx_prepare;
 	if (devargs_all->is_tx_pcap)
 		eth_dev->tx_pkt_burst = eth_pcap_tx_dumper;
 	else if (devargs_all->is_tx_iface || single_iface)
-- 
2.53.0

