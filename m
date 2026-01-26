Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516DFD1950F
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 18:09:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F25BA40678;
	Mon, 26 Jan 2026 19:08:36 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 39603402F0
 for <dev@dpdk.org>; Mon, 26 Jan 2026 19:08:28 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-430f3ef2d37so4233505f8f.3
 for <dev@dpdk.org>; Mon, 26 Jan 2026 10:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769450908;
 x=1770055708; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=seEygGRxWs7QydzYwqS/Vq3mnSAuo3mBWpHgj3hNLsM=;
 b=GiNrMDRzsk/kAo4jdXhnCJ7vDNfOu7RhTbUNn54BQrDcw4Z4Q3CJL2EgF7TzdbyA/m
 yPlrk3YWM7JWdOLGNVbkyCeU4fvmRDLkRbPs0Higc2gW8PUP6zGPnrqta3VKqhP7AbpB
 URrZUVjB/NDF2Czx+TInzNCviKNAAQcKR0tUOYY5HhNw+AT/2m25r5/Av/OxmncYwJ2t
 aA50d7vmt5KrIkbZDlr7Vu3ZBnzQ1INyO2t9n4E462iPdlukp80ofH1Iqbt4qhDdb8a3
 IgNcL/UMV4WRx+H5Q6Wrop814sVBK1rotsz0454+mwEIuY1OEB3gXrkZ8X8+gunAzYLf
 Un6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769450908; x=1770055708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=seEygGRxWs7QydzYwqS/Vq3mnSAuo3mBWpHgj3hNLsM=;
 b=jEcwIYd28T/z/RFpIgtmu+qpKIhAchxlD5+KaBaRW6MXYN8Q0KOD+FAxCtHxevZkj9
 phoZBLgoPmzMey5as5xiL25QURvI97F3F7e6YLqAmNZf108+soOZHgdK+8PYMVeLZqQG
 tdgnVELwn1TzV432faSiwJzLOEftqpN4fNmzXEwT9cVkUaJYSYoai2PhOvXzzuvrcPPg
 PBTKLsV+svJ1RGsP6J0RTBiLDFJAxbhjonGw+Wt0eZDvTrwZBimkuvb9EhjWdaDo5d5t
 QEMhIWutN7qNCIdGYFZTRYx2heQQyypB1Rix+I4kUJhbaj29QV6Xl8M2o6yryAQGaanu
 KG8A==
X-Gm-Message-State: AOJu0YwoSVrXedIuG8+aYhj4VkWnr6RiB1+RFnxzGmrB7v2AXCATvPth
 Q1n375HBY9pf9MeI3ndcVqbfGmTKLSWBmHYuohysERXLyp5n3Ip1UlfE2w5RMDxrImIteddTRSA
 2bG/n
X-Gm-Gg: AZuq6aJ6Gs3e4Rye6Gp0i4vsTcpZmlYJ6RHUBiQsnwXH/gGPrCpkiElgiEWbmU56mtG
 NxM8TgkkJ+edq41UjqaC7s3ln1I3emmaxKbargzyjFkDZ361ukAugq53tLwWL58F4xLjMYGa/7x
 H6uVlUfYTyvoTYsteBFgiaUQfWLiFINaaEJlszEx5nvRUljzJuQ0EkOozn2/rQPe784sGYfkYm0
 SOSSr8NJI673v84LmwaHw5p1nOBfz8Ic3yV/CDHLbPpcPcB96nllz3/PdnHFM3MsAJ+zc1ekK//
 nR7OBJxeVexrNSW9nspf7VAHA6wnzfcstFB8BQh1oELNYTlR0YA20yzMGy98eiDJgmx71hNYhrq
 2B8CQiDrOywnPTmwXj6CpxzAMAzVrh1dVzn2Qj+3rTocd1fyoDeA19YemOTbmecGzQUX5+3NM17
 z0cZD+yKGEoOXrpMp2FDvTl6Jmkatmw+M8wu9WbTbOtKrHSMWGhw==
X-Received: by 2002:a05:6000:3109:b0:432:c0e6:cfda with SMTP id
 ffacd0b85a97d-435ca051defmr7987953f8f.7.1769450907728; 
 Mon, 26 Jan 2026 10:08:27 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c02c91sm31845864f8f.9.2026.01.26.10.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 10:08:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 10/13] net/pcap: support nanosecond timestamp precision
Date: Mon, 26 Jan 2026 10:06:47 -0800
Message-ID: <20260126180807.100891-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126180807.100891-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260126180807.100891-1-stephen@networkplumber.org>
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

Enable nanosecond-precision timestamps for both live capture and pcap
file reading.

Replace pcap_open_live() with the pcap_create()/pcap_activate() API,
which allows setting PCAP_TSTAMP_PRECISION_NANO before
activation. Similarly, use pcap_open_offline_with_tstamp_precision()
for reading pcap files. The pcap_pkthdr timestamp field, despite being
declared as struct timeval, actually contains nanoseconds (not
microseconds) when nanosecond precision is requested.

Make receive timestamp offloading conditional: timestamps are now only
written to the mbuf dynamic field when RTE_ETH_RX_OFFLOAD_TIMESTAMP is
enabled. Previously, timestamps were unconditionally added to every
received packet.

Other related changes:
* Defer timestamp dynfield registration from probe to device start,
  and only when timestamp offloading is enabled
* Add read_clock dev_op returning current UTC time
  for timestamp correlation
* Move per-burst timestamp calculation outside the packet loop in
  tx_dumper
* Enable immediate mode and improve error reporting
  in live capture setup

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_03.rst |   2 +
 drivers/net/pcap/pcap_ethdev.c         | 129 +++++++++++++++++++------
 2 files changed, 102 insertions(+), 29 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 3d25626adb..de1302ef06 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -60,6 +60,8 @@ New Features
   * Changed transmit burst to always return the number of packets requested.
     Failed sends are counted as transmit errors.
   * Added support for VLAN insertion and stripping.
+  * Receive timestamp offload is only done if offload flag set.
+  * Receive timestamps support nanosecond precision.
 
 
 Removed Items
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 0200e129d8..35ab4e58d3 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -27,13 +27,12 @@
 #include <rte_mbuf_dyn.h>
 #include <bus_vdev_driver.h>
 #include <rte_os_shim.h>
+#include <rte_time.h>
 
 #include "pcap_osdep.h"
 
 #define RTE_ETH_PCAP_SNAPSHOT_LEN 65535
 #define RTE_ETH_PCAP_SNAPLEN (RTE_ETHER_MAX_JUMBO_FRAME_LEN - RTE_ETHER_CRC_LEN)
-#define RTE_ETH_PCAP_PROMISC 1
-#define RTE_ETH_PCAP_TIMEOUT -1
 
 #define ETH_PCAP_RX_PCAP_ARG  "rx_pcap"
 #define ETH_PCAP_TX_PCAP_ARG  "tx_pcap"
@@ -77,6 +76,7 @@ struct pcap_rx_queue {
 	uint16_t port_id;
 	uint16_t queue_id;
 	bool vlan_strip;
+	bool timestamp_offloading;
 	struct rte_mempool *mb_pool;
 	struct queue_stat rx_stat;
 	struct queue_missed_stat missed_stat;
@@ -105,6 +105,7 @@ struct pmd_internals {
 	bool phy_mac;
 	bool infinite_rx;
 	bool vlan_strip;
+	bool timestamp_offloading;
 };
 
 struct pmd_process_private {
@@ -332,10 +333,20 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		if (pcap_q->vlan_strip)
 			rte_vlan_strip(mbuf);
 
-		uint64_t us = (uint64_t)header->ts.tv_sec * US_PER_S + header->ts.tv_usec;
+		if (pcap_q->timestamp_offloading) {
+			/*
+			 * Although time stamp in struct pcap_pkthdr is defined as struct timeval,
+			 * it really is a timespec with nanosecond resolution.
+			 */
+			uint64_t ns = (uint64_t)header->ts.tv_sec * NSEC_PER_SEC
+				+  header->ts.tv_usec;
+
+			*RTE_MBUF_DYNFIELD(mbuf, timestamp_dynfield_offset,
+					   rte_mbuf_timestamp_t *) = ns;
+
+			mbuf->ol_flags |= timestamp_rx_dynflag;
+		}
 
-		*RTE_MBUF_DYNFIELD(mbuf, timestamp_dynfield_offset, rte_mbuf_timestamp_t *) = us;
-		mbuf->ol_flags |= timestamp_rx_dynflag;
 		mbuf->port = pcap_q->port_id;
 		bufs[num_rx] = mbuf;
 		num_rx++;
@@ -355,14 +366,13 @@ eth_null_rx(void *queue __rte_unused,
 	return 0;
 }
 
-#define NSEC_PER_SEC	1000000000L
-
 /*
  * This function stores nanoseconds in `tv_usec` field of `struct timeval`,
  * because `ts` goes directly to nanosecond-precision dump.
  */
 static inline void
-calculate_timestamp(struct timeval *ts) {
+calculate_timestamp(struct timeval *ts)
+{
 	uint64_t cycles;
 	struct timespec cur_time;
 
@@ -413,6 +423,9 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	if (unlikely(dumper == NULL || nb_pkts == 0))
 		return 0;
 
+	/* all packets in burst have same timestamp */
+	calculate_timestamp(&header.ts);
+
 	/* writes the nb_pkts packets to the previously opened pcap file dumper */
 	for (i = 0; i < nb_pkts; i++) {
 		struct rte_mbuf *mbuf = bufs[i];
@@ -426,7 +439,6 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 				continue;
 		}
 
-		calculate_timestamp(&header.ts);
 		header.len = len;
 		header.caplen = len;
 
@@ -529,22 +541,60 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
  * pcap_open_live wrapper function
  */
 static inline int
-open_iface_live(const char *iface, pcap_t **pcap) {
-	*pcap = pcap_open_live(iface, RTE_ETH_PCAP_SNAPLEN,
-			RTE_ETH_PCAP_PROMISC, RTE_ETH_PCAP_TIMEOUT, errbuf);
+open_iface_live(const char *iface, pcap_t **pcap)
+{
+	pcap_t *pc;
+	int status;
 
-	if (*pcap == NULL) {
-		PMD_LOG(ERR, "Couldn't open %s: %s", iface, errbuf);
-		return -1;
+	pc = pcap_create(iface, errbuf);
+	if (pc == NULL) {
+		PMD_LOG(ERR, "Couldn't create %s: %s", iface, errbuf);
+		goto error;
 	}
 
-	if (pcap_setnonblock(*pcap, 1, errbuf)) {
+	status = pcap_set_tstamp_precision(pc, PCAP_TSTAMP_PRECISION_NANO);
+	if (status != 0)
+		PMD_LOG(WARNING, "%s: Could not set to ns precision: %s",
+			iface, pcap_statustostr(status));
+
+	status = pcap_set_immediate_mode(pc, 1);
+	if (status != 0)
+		PMD_LOG(WARNING, "%s: Could not set to immediate mode: %s",
+			iface, pcap_statustostr(status));
+
+	status = pcap_set_promisc(pc, 1);
+	if (status != 0)
+		PMD_LOG(WARNING, "%s: Could not set to promiscuous: %s",
+			iface, pcap_statustostr(status));
+
+	status = pcap_set_snaplen(pc, RTE_ETH_PCAP_SNAPSHOT_LEN);
+	if (status != 0)
+		PMD_LOG(WARNING, "%s: Could not set snapshot length: %s",
+			iface, pcap_statustostr(status));
+
+	status = pcap_activate(pc);
+	if (status < 0) {
+		char *cp = pcap_geterr(pc);
+
+		if (status == PCAP_ERROR)
+			PMD_LOG(ERR, "%s: could not activate: %s", iface, cp);
+		else
+			PMD_LOG(ERR, "%s: %s (%s)", iface, pcap_statustostr(status), cp);
+		goto error;
+	}
+
+	if (pcap_setnonblock(pc, 1, errbuf)) {
 		PMD_LOG(ERR, "Couldn't set non-blocking on %s: %s", iface, errbuf);
-		pcap_close(*pcap);
-		return -1;
+		goto error;
 	}
 
+	*pcap = pc;
 	return 0;
+
+error:
+	if (pc != NULL)
+		pcap_close(pc);
+	return -1;
 }
 
 static int
@@ -591,7 +641,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
-	*pcap = pcap_open_offline(pcap_filename, errbuf);
+	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
+							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
 		PMD_LOG(ERR, "Couldn't open %s: %s", pcap_filename,
 			errbuf);
@@ -628,6 +679,15 @@ eth_dev_start(struct rte_eth_dev *dev)
 	struct pcap_tx_queue *tx;
 	struct pcap_rx_queue *rx;
 
+	if (internals->timestamp_offloading) {
+		int ret = rte_mbuf_dyn_rx_timestamp_register(&timestamp_dynfield_offset,
+							     &timestamp_rx_dynflag);
+		if (ret != 0) {
+			PMD_LOG(ERR, "Failed to register Rx timestamp field/flag");
+			return ret;
+		}
+	}
+
 	/* Special iface case. Single pcap is open and shared between tx/rx. */
 	if (internals->single_iface) {
 		tx = &internals->tx_queue[0];
@@ -750,6 +810,7 @@ eth_dev_configure(struct rte_eth_dev *dev)
 	const struct rte_eth_rxmode *rxmode = &dev_conf->rxmode;
 
 	internals->vlan_strip = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP);
+	internals->timestamp_offloading = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP);
 	return 0;
 }
 
@@ -767,7 +828,8 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->min_rx_bufsize = 0;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
-	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
+	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
+		RTE_ETH_RX_OFFLOAD_TIMESTAMP;
 
 	return 0;
 }
@@ -1001,6 +1063,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	pcap_q->queue_id = rx_queue_id;
 	pcap_q->vlan_strip = internals->vlan_strip;
 	dev->data->rx_queues[rx_queue_id] = pcap_q;
+	pcap_q->timestamp_offloading = internals->timestamp_offloading;
 
 	if (internals->infinite_rx) {
 		struct pmd_process_private *pp;
@@ -1111,12 +1174,24 @@ eth_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	return 0;
 }
 
+/* Timestamp values in receive packets from libpcap are in nanoseconds */
+static int
+eth_dev_read_clock(struct rte_eth_dev *dev __rte_unused, uint64_t *timestamp)
+{
+	struct timespec cur_time;
+
+	timespec_get(&cur_time, TIME_UTC);
+	*timestamp = rte_timespec_to_ns(&cur_time);
+	return 0;
+}
+
 static const struct eth_dev_ops ops = {
 	.dev_start = eth_dev_start,
 	.dev_stop = eth_dev_stop,
 	.dev_close = eth_dev_close,
 	.dev_configure = eth_dev_configure,
 	.dev_infos_get = eth_dev_info,
+	.read_clock = eth_dev_read_clock,
 	.rx_queue_setup = eth_rx_queue_setup,
 	.tx_queue_setup = eth_tx_queue_setup,
 	.rx_queue_start = eth_rx_queue_start,
@@ -1530,15 +1605,11 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 	name = rte_vdev_device_name(dev);
 	PMD_LOG(INFO, "Initializing pmd_pcap for %s", name);
 
-	timespec_get(&start_time, TIME_UTC);
-	start_cycles = rte_get_timer_cycles();
-	hz = rte_get_timer_hz();
-
-	ret = rte_mbuf_dyn_rx_timestamp_register(&timestamp_dynfield_offset,
-			&timestamp_rx_dynflag);
-	if (ret != 0) {
-		PMD_LOG(ERR, "Failed to register Rx timestamp field/flag");
-		return -1;
+	/* Record info for timestamps on first probe */
+	if (hz == 0) {
+		timespec_get(&start_time, TIME_UTC);
+		start_cycles = rte_get_timer_cycles();
+		hz = rte_get_timer_hz();
 	}
 
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
-- 
2.51.0

