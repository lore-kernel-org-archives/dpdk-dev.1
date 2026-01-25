Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69251E63CA4
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Jan 2026 19:24:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3861140652;
	Sun, 25 Jan 2026 20:23:36 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 52972402D8
 for <dev@dpdk.org>; Sun, 25 Jan 2026 20:23:28 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-43246af170aso2163070f8f.0
 for <dev@dpdk.org>; Sun, 25 Jan 2026 11:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769369008;
 x=1769973808; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g/TYV+R1AnI9rllXi2MKxqpY9f9Qr9fBBtsfbkTRwWI=;
 b=0b15hYXqWO+rcGxyIHlzh7RQEFD0ya60gAQrNhNhQKeoKOeZC27i0laGdDZgzV07nk
 P/0uXdbjRi8gYw3+onMPLYA7iahrLT2HfQxSPAJIoBo89m7U3X4y8LOUKy+UkB2cgpLb
 L9UvV0ZMZBN0seKRvPpLLRXnqUZ98cam2V2D9IJQ1VtddgvLi/Iu4kpjq0pbb6NI4DIu
 NmItSiNGGJJ2mTTjSYZ2uvlcbuzPBoivI0XHCL0T2O+as3+34mjooFHeWO7ULns2uDeE
 2uGnygK32pSwe/RCzX6j5qEI5qxr7iIAoNM+fHgiAq/p6jWuFF19Y/8Hhfc2ZV5Yd2Rv
 9Czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769369008; x=1769973808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g/TYV+R1AnI9rllXi2MKxqpY9f9Qr9fBBtsfbkTRwWI=;
 b=ADfukGAzhlrywOkYw4yWeVnWFxeariK7mJo6vXd4vpGYGX7udCMXmTYxcZApjRmpnK
 CmsX45o2CoN8FRGNB2pmvufAzI3Mc7GESOeTPwaDoXonGKCE1uoY4sOidPUYFQkIsnMo
 p9Oww0dSDPeVapX4xnv3a7hgh78p5M11SZbrDm1DIDzpIvfzTM2VO6wWBHMS5LBAXQ5D
 5+6FXU3Exu3vKaGKXErwQPTnumAGVSLcAKjNSk5SXrvfmnm8LQCbUs1AJOpoQMA11V4o
 7f5H1xI5q6bHbnTKmEogMjo4jOy5hlOOu+Rv9joCovPLVNJ/S0bsnT+nM/93p4Urh+E6
 k6VA==
X-Gm-Message-State: AOJu0Yx9Gq0DnsYc27yK2bbb1/34DtR3dTiKkA8GpwNCqO9Tas6yJGmw
 LwMuykrhbb8ig3qMGjQuuE0gC1gdYJ7riqWdHTL9RaI1SV4VDkS4X/CrX6RDIZv5156EJxBCPjm
 p4byH
X-Gm-Gg: AZuq6aKVl4l66kFL5gycWoGZkj0DH4Q8WfMpapcaFDkHgaPv0hBldKEX1wSI804xw0p
 tJ3wOJU2NoomHJB9wFfuy4ZgeE2fPEN4bg4MBWO9CqYB/rYIoBxWhFinHQzWeKHyz0l3Iltmpq4
 iUESpXA0v4WU/Mdkh+gcsQxIhISHTIPz20KTCjaJIAMlneuCAA1k9VmtcfQ1Ez07bNZGVwTKtKX
 1CTyt4OoszZdNXyO5E/KWkGpDhhNshuq+klcsSOpuWLnMpPDGCcj1C+Sc/Gg8GaYgLzR0IqhsSn
 g8gxMlvX6dHFDzRtqdtjqCJKzT3fnOepWyRwlDQ8FLGXu9tCEctK5h2G+EmUuKdpseubfguWiDF
 /UHpfCsAg0ocgSqgtnpuqGAm6ilW1JsaPcEEvg2+Zz/oTB90cajcxSGEZfI2gGdLUptxfY/3FPv
 DoEstQoIb7JvCLKJUAw69CbrAcODn5O/mRfyGUrGsDiYgT9qQ1xg==
X-Received: by 2002:a05:6000:4211:b0:3ea:6680:8fb9 with SMTP id
 ffacd0b85a97d-435c9a8eb72mr4138197f8f.3.1769369007727; 
 Sun, 25 Jan 2026 11:23:27 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b4d8sm22854362f8f.38.2026.01.25.11.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 11:23:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 10/13] net/pcap: support nanosecond timestamp precision
Date: Sun, 25 Jan 2026 11:20:08 -0800
Message-ID: <20260125192248.497563-12-stephen@networkplumber.org>
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
index 4e31d85e50..a1536033f7 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -59,6 +59,8 @@ New Features
 
   * Added support for setting MTU in single interface mode.
   * Added support for VLAN insertion and stripping.
+  * Receive timestamp offload is only done if offload flag set.
+  * Receive timestamps support nanosecond precision.
   * Changed transmit burst to always return the number of packets requested.
     Failed sends are counted as transmit errors.
 
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 85225fca2d..1c53a47bc6 100644
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
@@ -339,10 +340,20 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
@@ -362,14 +373,13 @@ eth_null_rx(void *queue __rte_unused,
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
 
@@ -420,6 +430,9 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	if (unlikely(dumper == NULL || nb_pkts == 0))
 		return 0;
 
+	/* all packets in burst have same timestamp */
+	calculate_timestamp(&header.ts);
+
 	/* writes the nb_pkts packets to the previously opened pcap file dumper */
 	for (i = 0; i < nb_pkts; i++) {
 		struct rte_mbuf *mbuf = bufs[i];
@@ -433,7 +446,6 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 				continue;
 		}
 
-		calculate_timestamp(&header.ts);
 		header.len = len;
 		header.caplen = len;
 
@@ -536,22 +548,60 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
@@ -598,7 +648,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
-	*pcap = pcap_open_offline(pcap_filename, errbuf);
+	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
+							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
 		PMD_LOG(ERR, "Couldn't open %s: %s", pcap_filename,
 			errbuf);
@@ -635,6 +686,15 @@ eth_dev_start(struct rte_eth_dev *dev)
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
@@ -757,6 +817,7 @@ eth_dev_configure(struct rte_eth_dev *dev)
 	const struct rte_eth_rxmode *rxmode = &dev_conf->rxmode;
 
 	internals->vlan_strip = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP);
+	internals->timestamp_offloading = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP);
 	return 0;
 }
 
@@ -776,7 +837,8 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_mtu = RTE_ETH_PCAP_SNAPLEN;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
-	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
+	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
+		RTE_ETH_RX_OFFLOAD_TIMESTAMP;
 
 	return 0;
 }
@@ -925,6 +987,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	pcap_q->queue_id = rx_queue_id;
 	pcap_q->vlan_strip = internals->vlan_strip;
 	dev->data->rx_queues[rx_queue_id] = pcap_q;
+	pcap_q->timestamp_offloading = internals->timestamp_offloading;
 
 	if (internals->infinite_rx) {
 		struct pmd_process_private *pp;
@@ -1046,6 +1109,17 @@ eth_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 	return 0;
 }
 
+/* Timestamp values in receive packets from libpcap are in nanoseconds */
+static int
+ns_read_clock(struct rte_eth_dev *dev __rte_unused, uint64_t *timestamp)
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
@@ -1062,6 +1136,7 @@ static const struct eth_dev_ops ops = {
 	.mtu_set = eth_mtu_set,
 	.stats_get = eth_stats_get,
 	.stats_reset = eth_stats_reset,
+	.read_clock = ns_read_clock,
 };
 
 static int
@@ -1461,15 +1536,11 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
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

