Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A25CA5FE6
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Jan 2026 22:01:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B2B242F4D;
	Sat, 17 Jan 2026 23:00:57 +0100 (CET)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id C371F42F4D
 for <dev@dpdk.org>; Sat, 17 Jan 2026 23:00:55 +0100 (CET)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-432d2c7a8b9so2740577f8f.2
 for <dev@dpdk.org>; Sat, 17 Jan 2026 14:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768687255;
 x=1769292055; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q97m/f7O2bKIB+Pa3rt2+7AlRtrwwn6e6+dN00Sk7gI=;
 b=qcO2aZARU0rVni+MYEIjAtBkwn+Q0C1JHcFAlaYY+N6vOh5nv53RXbKzuJNFq/Lkgy
 5nmHso0E/uhwcu0wfpNXylNGvVmmMTg+2Ldl5lhpo/GuDU2cv8iM9XRShpyJ0XNGIpCZ
 KgV5EvhaipooGvccJA0st7nlNFIVRiYvdbDC6xotDmOW7GcEJdj8Q8MXqAIgQlGNDOVG
 WtEaa3Q8VYVQrMMN/wO61Abe0lEM/jeTjJg+r3s9DOS52FVyC+jdSk3KmZjEKOx9GyZf
 fgr+G5MDkZvww45vRZ04m/FPSJaYQwX9JZkcLvLz/uhfl5xVPANgsUgL5uJ3Ki3xSdgU
 IFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768687255; x=1769292055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q97m/f7O2bKIB+Pa3rt2+7AlRtrwwn6e6+dN00Sk7gI=;
 b=wxrhRerWOquWBxaWw9MeJwC/A7bxJUpEYtDTjfG+KstAAu0C5Zfe+pft1yBQMFLPoh
 7aANNqCcJcqxq3Lt6QQvLMi99BJb/T2NSw0dO8LtNrnbuhngt/IsTZ2NrqFfwWJ6Mcg/
 LIRqS7h69Qx2kMIy4DpvDRbxRIUbGuzv860XdMm7BjyJO4i8XjjM726qmsKWCcEc3EcK
 E8QLpiuRS+YkyHpw4vOTRKgHU8A2fR7xOIPpB+2PO83anyCBRFjEzYunEMBK+5xP18gD
 0X6+xhXnYZ+qj0yg3cQweVYr5TzQMbnyH31/QkgPY5crQ/Cygulk1zRqhjpibfx4cxe8
 EZHg==
X-Gm-Message-State: AOJu0YzOgKoJ5LkFdcifI/YSqltI0HNWubXJq9MO4g3i10XQK9pz1qia
 Hu7jnkD9bQpnY+PkQVkWActiAU8hr8mJgHmdW4VI7UWZhn9OP1S/X6egU+9ZkKrd9VcvYMJ+g7o
 IoC8g
X-Gm-Gg: AY/fxX6A/i/j2aZkGNS6X3Ks5jttBRYzUmsEk4jnJLnwLCYcHRPQmOq+sk3bvZrYVyY
 FPsV5JJ15PT0BX6X4R/aYtAWtw11upxKIep8CioBL6L6oL3XW+mzPSauIzUslW9Lync3Wlh+gGY
 R5DiNfTNxBqM7IymcrfG8Znxhkx3EDagQSMOcPr49Tu/xbKih6WAyaaU4vC9rCL8DSJ1K1UAGIX
 7R6tJj835wyQdo9qrDxBQO2UoRNWlF6URAyF3euX84okPu3fDKm4Wz2haB0UrvQe/dBtRYHUxOn
 qypF/lhi9lk0KRvygDcgHE0Zlv0kn1lo3M2Gk+tCQi+Ix/iJ+m8P5gJmBNojSSzeUVHuU26ezg5
 zAUtFa8+4xtmYVfyKV1Vl0xiBHv3Ku4EygVqJxrw+ncYU0MbTSFfMdgewMPLoY0PNV5DPC/OK9D
 1DCid6qDfclgfYsu9spt1/4ekQKmJXq83hmzyfElqLLHXxe9+/cg==
X-Received: by 2002:a5d:5918:0:b0:431:907:f308 with SMTP id
 ffacd0b85a97d-4356a089a5fmr6689319f8f.61.1768687255321; 
 Sat, 17 Jan 2026 14:00:55 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992681esm13309352f8f.11.2026.01.17.14.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 14:00:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 07/11] net/pcap: support nanosecond timestamp precision
Date: Sat, 17 Jan 2026 13:57:06 -0800
Message-ID: <20260117220030.273471-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260117220030.273471-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260117220030.273471-1-stephen@networkplumber.org>
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
 drivers/net/pcap/pcap_ethdev.c    | 136 +++++++++++++++++++++++-------
 2 files changed, 107 insertions(+), 30 deletions(-)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index 7a1420a2eb..24161cb33f 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -11,6 +11,7 @@ Rx Timestamp         = Y
 Basic stats          = Y
 Stats per queue      = Y
 VLAN offload         = Y
+Timestamp offload    = Y
 Multiprocess aware   = Y
 FreeBSD              = Y
 Linux                = Y
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 19d4ed94e1..7e2a69f137 100644
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
@@ -69,6 +70,7 @@ struct pcap_rx_queue {
 	uint16_t port_id;
 	uint16_t queue_id;
 	bool vlan_strip;
+	bool timestamp_offloading;
 	struct rte_mempool *mb_pool;
 	struct queue_stat rx_stat;
 	struct queue_missed_stat missed_stat;
@@ -97,6 +99,7 @@ struct pmd_internals {
 	bool phy_mac;
 	bool infinite_rx;
 	bool vlan_strip;
+	bool timestamp_offloading;
 };
 
 struct pmd_process_private {
@@ -331,10 +334,19 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		if (pcap_q->vlan_strip)
 			rte_vlan_strip(mbuf);
 
-		uint64_t us = (uint64_t)header->ts.tv_sec * US_PER_S + header->ts.tv_usec;
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
 
-		*RTE_MBUF_DYNFIELD(mbuf, timestamp_dynfield_offset, rte_mbuf_timestamp_t *) = us;
-		mbuf->ol_flags |= timestamp_rx_dynflag;
 		mbuf->port = pcap_q->port_id;
 		bufs[num_rx] = mbuf;
 		num_rx++;
@@ -354,20 +366,21 @@ eth_null_rx(void *queue __rte_unused,
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
@@ -413,6 +426,9 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	if (unlikely(dumper == NULL || nb_pkts == 0))
 		return 0;
 
+	/* all packets in burst have same timestamp */
+	calculate_timestamp(&header.ts);
+
 	/* writes the nb_pkts packets to the previously opened pcap file dumper */
 	for (i = 0; i < nb_pkts; i++) {
 		struct rte_mbuf *mbuf = bufs[i];
@@ -427,7 +443,6 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			}
 		}
 
-		calculate_timestamp(&header.ts);
 		header.len = len;
 		header.caplen = len;
 
@@ -539,22 +554,60 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
@@ -601,7 +654,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
-	*pcap = pcap_open_offline(pcap_filename, errbuf);
+	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
+							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
 		PMD_LOG(ERR, "Couldn't open %s: %s", pcap_filename,
 			errbuf);
@@ -638,6 +692,15 @@ eth_dev_start(struct rte_eth_dev *dev)
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
@@ -760,6 +823,7 @@ eth_dev_configure(struct rte_eth_dev *dev)
 	const struct rte_eth_rxmode *rxmode = &dev_conf->rxmode;
 
 	internals->vlan_strip = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP);
+	internals->timestamp_offloading = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP);
 	return 0;
 }
 
@@ -779,7 +843,8 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_mtu = RTE_ETH_PCAP_SNAPLEN;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
-	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
+	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
+		RTE_ETH_RX_OFFLOAD_TIMESTAMP;
 
 	return 0;
 }
@@ -928,6 +993,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	pcap_q->queue_id = rx_queue_id;
 	pcap_q->vlan_strip = internals->vlan_strip;
 	dev->data->rx_queues[rx_queue_id] = pcap_q;
+	pcap_q->timestamp_offloading = internals->timestamp_offloading;
 
 	if (internals->infinite_rx) {
 		struct pmd_process_private *pp;
@@ -1049,6 +1115,17 @@ eth_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
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
@@ -1065,6 +1142,7 @@ static const struct eth_dev_ops ops = {
 	.mtu_set = eth_mtu_set,
 	.stats_get = eth_stats_get,
 	.stats_reset = eth_stats_reset,
+	.read_clock = eth_rx_clock,
 };
 
 static int
@@ -1465,15 +1543,13 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
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

