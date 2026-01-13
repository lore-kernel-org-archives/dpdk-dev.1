Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7858D2F35C
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 19:26:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A61AE40670;
	Tue, 13 Jan 2026 20:25:51 +0100 (CET)
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68]) by mails.dpdk.org (Postfix) with ESMTP id 7C7164066F
 for <dev@dpdk.org>; Tue, 13 Jan 2026 20:25:50 +0100 (CET)
Received: by mail-ej1-f68.google.com with SMTP id
 a640c23a62f3a-b8710c9cddbso411478566b.2
 for <dev@dpdk.org>; Tue, 13 Jan 2026 11:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768332350;
 x=1768937150; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CfCYRda1ALCCA3suPcqWj5y3/lTCZXQA1C9KPwsKSGQ=;
 b=kpuV3ZT2iqyuYqAMxGIVVB292Gk8oXrH3A/PHqVCcdLC7PNona/tPGQzn7cG5R+H2a
 GXnzUK+ePovuvidAtJqdwXdyGPczmsfwhP5nWlHpgXMr78GXQ5kr5M9Nj4Zga4WroEfA
 evBh0OnbJ5KLXiP7yiLu/hkDJg6cUti/DFBSl5HifVcBfSajyedIP5lLsfiemkg6/AWa
 i8pL2WRuvxpYHBKhW200nL1vKJdtnfF+DOKDCioEx+I2zwRh9soIly7EDhY7PHHoP8rm
 GXnal4jBhNz86SZq7wP4G2mqyfWsdda6kA+ebT6ykBHGJgkyMB+8kXLe4GiqXxwYkDGL
 sy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768332350; x=1768937150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CfCYRda1ALCCA3suPcqWj5y3/lTCZXQA1C9KPwsKSGQ=;
 b=kVd5/Ffcq2YmxVXnvq4g1NJbpaNWrmp3aix7FcFuTlDe/1r9cCHWa1ADGZEQua190h
 sEJIoH1AXdNWOZ2t0nj6QR6I2DVSoU8hHAdO4KlvEF/OIxI+Mh21vsPQHrOaGDKEjxcG
 OeKj3ZObT0SawuA1MdiDndW8BWEoeI7iePhhbNob0+quSp2as00w2zlqdZr6qfOJPWIb
 0ZiFi9URZcSTZazliBt8sRYE91t/tY9Dyk1bvenHZAYX7d4J6vL40uquGSsMgLZ+P0V9
 xJSYsueb+cmzcS3PRdSM1XD96hsdoqiH68BjUqalNNPmU6FCZYf6c4JaHMJGnPRBzuUx
 s8uQ==
X-Gm-Message-State: AOJu0YwdQvYB+J+iWwt39vhwbImRU9yfzkjjqUDChOcQN7Kc08CbzKJY
 dMjTeD4UEouiZpd7lv9EE7H1kKI4wqrZ7uEtR0WQlK/w3sOgNZVwDXZTk4/UjMA7w4ujLM8zrv7
 n5Nyz
X-Gm-Gg: AY/fxX5oaUernv9a4984IPUANYErvDDvQg3aI8Wux3e/4UHYl5RECvs5HV0oS2iJB/a
 gwuL4PW3gW/ONVnOb/XnCQMg7duYoQ29qnq7/XfdD9lc8pR+/rE5dL/UHxwilDij0Yun9jbdaWs
 Awme72RBMt0KplLxlfuDJjP4ky62ZrcVKwgUTIPsc4CrWdwn7MnxoWVvglMMoG7UgmKtJ0ZAPAW
 oyaEAlGv0GIB+TrtrqWwEAADiTrL7KN3q8uG1IEVF3QITToUwiJxN7HRg3/L0GOODlcu+vcpCrb
 XH8LcTDM0ge33OnXmylB0VZxaNUeGEloMHvO0A+DIKqVEerSS2m9kbxRpEN740G6xp0PfaGukRO
 rdRbPInwAozSayngG6t2TkakwygNcDkgKIMT4TPbr5HUqpF4A8AK7Q16k2j2mmqPlc5QXHhY9pK
 ydpUC16Wkj5XQaMbzY0x1/Ur3EdB71EUxhEI5Z3hN9rtsE8AL35zyHSBIATrHx
X-Received: by 2002:a17:907:3f16:b0:b87:1064:4eb5 with SMTP id
 a640c23a62f3a-b8761139d86mr18787566b.30.1768332349920; 
 Tue, 13 Jan 2026 11:25:49 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b22c3absm20945603a12.0.2026.01.13.11.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 11:25:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 6/9] net/pcap: support nanosecond timestamp precision
Date: Tue, 13 Jan 2026 11:23:38 -0800
Message-ID: <20260113192530.116470-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113192530.116470-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260113192530.116470-1-stephen@networkplumber.org>
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

Consistently support nanosecond timestamps across all the
variations of pcap PMD receive.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/pcap.ini |   1 +
 drivers/net/pcap/pcap_ethdev.c    | 146 +++++++++++++++++++++++-------
 2 files changed, 114 insertions(+), 33 deletions(-)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index c4772031be..ae38051dc6 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -11,6 +11,7 @@ Rx Timestamp         = Y
 Basic stats          = Y
 Stats per queue      = Y
 VLAN offload         = P
+Timestamp offload    = Y
 Multiprocess aware   = Y
 FreeBSD              = Y
 Linux                = Y
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index fde04bd1b2..fbd0f475d7 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -19,13 +19,13 @@
 #include <rte_mbuf_dyn.h>
 #include <bus_vdev_driver.h>
 #include <rte_os_shim.h>
+#include <rte_time.h>
+#include <rte_reciprocal.h>
 
 #include "pcap_osdep.h"
 
 #define RTE_ETH_PCAP_SNAPSHOT_LEN 65535
 #define RTE_ETH_PCAP_SNAPLEN (RTE_ETHER_MAX_JUMBO_FRAME_LEN - RTE_ETHER_CRC_LEN)
-#define RTE_ETH_PCAP_PROMISC 1
-#define RTE_ETH_PCAP_TIMEOUT -1
 
 #define ETH_PCAP_RX_PCAP_ARG  "rx_pcap"
 #define ETH_PCAP_TX_PCAP_ARG  "tx_pcap"
@@ -44,6 +44,7 @@ static char errbuf[PCAP_ERRBUF_SIZE];
 static struct timespec start_time;
 static uint64_t start_cycles;
 static uint64_t hz;
+static struct rte_reciprocal_u64 hz_inv;
 static uint8_t iface_idx;
 
 static uint64_t timestamp_rx_dynflag;
@@ -68,6 +69,7 @@ struct queue_missed_stat {
 struct pcap_rx_queue {
 	uint16_t port_id;
 	uint16_t queue_id;
+	bool timestamp_offloading;
 	struct rte_mempool *mb_pool;
 	struct queue_stat rx_stat;
 	struct queue_missed_stat missed_stat;
@@ -95,6 +97,7 @@ struct pmd_internals {
 	bool single_iface;
 	bool phy_mac;
 	bool infinite_rx;
+	bool timestamp_offloading;
 };
 
 struct pmd_process_private {
@@ -325,10 +328,20 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		}
 
 		mbuf->pkt_len = len;
-		uint64_t us = (uint64_t)header->ts.tv_sec * US_PER_S + header->ts.tv_usec;
 
-		*RTE_MBUF_DYNFIELD(mbuf, timestamp_dynfield_offset, rte_mbuf_timestamp_t *) = us;
-		mbuf->ol_flags |= timestamp_rx_dynflag;
+		if (pcap_q->timestamp_offloading) {
+			/*
+			 * Although time stamp in struct pcap_pkthdr is defined as struct timeval,
+			 * it really is a timespec with nanosecond resolution.
+			 */
+			const struct timespec *ts = (struct timespec *)&header->ts;
+
+			*RTE_MBUF_DYNFIELD(mbuf, timestamp_dynfield_offset,
+					   rte_mbuf_timestamp_t *) = rte_timespec_to_ns(ts);
+
+			mbuf->ol_flags |= timestamp_rx_dynflag;
+		}
+
 		mbuf->port = pcap_q->port_id;
 		bufs[num_rx] = mbuf;
 		num_rx++;
@@ -348,20 +361,21 @@ eth_null_rx(void *queue __rte_unused,
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
 
 	cycles = rte_get_timer_cycles() - start_cycles;
-	cur_time.tv_sec = cycles / hz;
-	cur_time.tv_nsec = (cycles % hz) * NSEC_PER_SEC / hz;
+	cur_time.tv_sec = rte_reciprocal_divide_u64(cycles, &hz_inv);
+	/* compute remainder */
+	cycles -= cur_time.tv_sec * hz;
+	cur_time.tv_nsec = rte_reciprocal_divide_u64(cycles * NS_PER_S, &hz_inv);
 
 	ts->tv_sec = start_time.tv_sec + cur_time.tv_sec;
 	ts->tv_usec = start_time.tv_nsec + cur_time.tv_nsec;
@@ -380,6 +394,7 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	unsigned int i;
 	struct pmd_process_private *pp;
 	struct pcap_tx_queue *dumper_q = queue;
+	struct pcap_pkthdr header;
 	uint16_t num_tx = 0;
 	uint32_t tx_bytes = 0;
 	pcap_dumper_t *dumper;
@@ -392,13 +407,14 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	if (unlikely(dumper == NULL || nb_pkts == 0))
 		return 0;
 
-	/* writes the nb_pkts packets to the previously opened pcap file
-	 * dumper */
+	/* all packets in burst have same timestamp */
+	calculate_timestamp(&header.ts);
+
+	/* writes the nb_pkts packets to the previously opened pcap file dumper */
 	for (i = 0; i < nb_pkts; i++) {
 		struct rte_mbuf *mbuf = bufs[i];
 		size_t len = rte_pktmbuf_pkt_len(mbuf);
 		uint8_t temp_data[RTE_ETH_PCAP_SNAPLEN];
-		struct pcap_pkthdr header;
 
 		if (unlikely(len > mtu))
 			continue;
@@ -406,7 +422,6 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		if ((mbuf->ol_flags & RTE_MBUF_F_TX_VLAN) && rte_vlan_insert(&mbuf))
 			continue;
 
-		calculate_timestamp(&header.ts);
 		header.len = len;
 		header.caplen = len;
 
@@ -514,22 +529,60 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
+	}
+
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
+		PMD_LOG(WARNING, "%s: Could not set to promiscious: %s",
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
 	}
 
-	if (pcap_setnonblock(*pcap, 1, errbuf)) {
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
@@ -576,7 +629,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
-	*pcap = pcap_open_offline(pcap_filename, errbuf);
+	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
+							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
 		PMD_LOG(ERR, "Couldn't open %s: %s", pcap_filename,
 			errbuf);
@@ -613,6 +667,15 @@ eth_dev_start(struct rte_eth_dev *dev)
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
@@ -728,8 +791,13 @@ eth_dev_stop(struct rte_eth_dev *dev)
 }
 
 static int
-eth_dev_configure(struct rte_eth_dev *dev __rte_unused)
+eth_dev_configure(struct rte_eth_dev *dev)
 {
+	struct pmd_internals *internals = dev->data->dev_private;
+	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
+	const struct rte_eth_rxmode *rxmode = &dev_conf->rxmode;
+
+	internals->timestamp_offloading = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP);
 	return 0;
 }
 
@@ -749,6 +817,7 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_mtu = RTE_ETH_PCAP_SNAPLEN;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
+	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_TIMESTAMP;
 
 	return 0;
 }
@@ -896,6 +965,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	pcap_q->port_id = dev->data->port_id;
 	pcap_q->queue_id = rx_queue_id;
 	dev->data->rx_queues[rx_queue_id] = pcap_q;
+	pcap_q->timestamp_offloading = internals->timestamp_offloading;
 
 	if (internals->infinite_rx) {
 		struct pmd_process_private *pp;
@@ -1017,6 +1087,17 @@ eth_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 	return 0;
 }
 
+/* Timestamp values in receive packets from libpcap are in UTC */
+static int
+eth_rx_clock(struct rte_eth_dev *dev __rte_unused, uint64_t *timestamp)
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
@@ -1033,6 +1114,7 @@ static const struct eth_dev_ops ops = {
 	.mtu_set = eth_mtu_set,
 	.stats_get = eth_stats_get,
 	.stats_reset = eth_stats_reset,
+	.read_clock = eth_rx_clock,
 };
 
 static int
@@ -1433,15 +1515,13 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 	name = rte_vdev_device_name(dev);
 	PMD_LOG(INFO, "Initializing pmd_pcap for %s", name);
 
-	timespec_get(&start_time, TIME_UTC);
-	start_cycles = rte_get_timer_cycles();
-	hz = rte_get_timer_hz();
+	/* Record info for timestamps on first probe */
+	if (hz == 0) {
+		timespec_get(&start_time, TIME_UTC);
+		start_cycles = rte_get_timer_cycles();
 
-	ret = rte_mbuf_dyn_rx_timestamp_register(&timestamp_dynfield_offset,
-			&timestamp_rx_dynflag);
-	if (ret != 0) {
-		PMD_LOG(ERR, "Failed to register Rx timestamp field/flag");
-		return -1;
+		hz = rte_get_timer_hz();
+		hz_inv = rte_reciprocal_value_u64(hz);
 	}
 
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
-- 
2.51.0

