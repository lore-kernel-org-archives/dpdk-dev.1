Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FB4D232C6
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 01:18:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE7DF40A6B;
	Fri,  9 Jan 2026 02:18:09 +0100 (CET)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44]) by mails.dpdk.org (Postfix) with ESMTP id E9136406FF
 for <dev@dpdk.org>; Fri,  9 Jan 2026 02:18:08 +0100 (CET)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b72b495aa81so734521766b.2
 for <dev@dpdk.org>; Thu, 08 Jan 2026 17:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767921488;
 x=1768526288; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ygOgmgfLltwFJfgwUHbCTpJe56a0p2QGo/uPqwQZYNo=;
 b=t69IUXPcq8lBg4cOFkPdzHan52tpmU0QdVSaJ2F99Fq44dZcubvfD+vNS0qKaPnSfM
 fFnQ1HkvJWbu4KpnywRZvyHAmxZPDDaHbXQ0CcOqiSgAyhSEbACnZeEx7NYr8Gr10taO
 T8TmgVGxa3G4bP7vPNOe2prR9RScKiZKf7bx9LItgYzkRLTQVD0lFIcNnefipRzDWSn+
 Y2rEvw7KV0VfkOg1QC4jitM8EcONoaotVeVNsnDADIzlY8FYI7tDK+O9UI2hOPlTKzBZ
 kZTQmVFGtqhyl9pDBk/zd/oBwTbAbPIn1G/JDGDKDIeMcCaFrp3BThs/eWdWwCegD7CU
 2b3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767921488; x=1768526288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ygOgmgfLltwFJfgwUHbCTpJe56a0p2QGo/uPqwQZYNo=;
 b=df9CgHMq63DTH5J8FFCdcFvkoqJsyHnlR3RhVal8jRgE8HGuNWnuxded2EE9TJ7ouk
 zDBJHborj7AwK+hbhoC6OewBYkPhVswEWDvTAtvflgN0FJ0bgMD2PsliITEpLxH/HnkM
 ukLSrf0p3UNu0cWLDiJlMZvom2oykOKyBlvSpFvcwcjiifHPx7fAGdT6qv6SiwSgoCdo
 qcb0UZ3DfEJZNTArRuTYHHPKRcMuSPu2zREnCMDve3D5tSSddAvoV6v2CRMVDNdxuL2F
 Un2+xRWenwPlZrlzwVpnlfYyS4PdswNgKCChtxgG2yVFcZmcImNlSKtwJGDPs07i4qFd
 P30Q==
X-Gm-Message-State: AOJu0Yx06ADa5RSrFGZE48wA27ysrgJuN4qsmFHIGy3yxZnlO/FXLZST
 IdAY1bvygmsrX7xvZAklJQUQwzofDgBuBMpEtGfB5URsvek2h0fJ57cXtNIx65MvTQE77NV2h6b
 Omo3G
X-Gm-Gg: AY/fxX5YTNM+qWe8KyD3caVs30Op6MReoqnVM8ovNciqA7XskpM3mvnZ9sPRGEoVMFZ
 TUbyus1J/5Ar88AfrS9fhI3D850aBEw+CbPBTRMFkTJ0qNjBtju3BlImm+V3El0nrgUeWYjtaYF
 /QeqFITeqg36RiSYf2DQPfN08OOS0JvspfspHt7AHuPEApqm4mcR/tvPZ+qc+ockRpTI00EmqUq
 P7l6lzg5dg5qLtbVPLd7Y2erPJsuTwbOJ2gJ5BPHx6P0RTbj3S6D0a3qsjsGErhGOB93AEAIa0V
 2716kwR0N/TLRAu3tEia37XpSUQgaYFjtZX6TVb31Aor/E0m1bkmEvPdOdTD0Y1n3SSpbeS4gjP
 LFbPqiT1y/eTskFQOhr5+DYnzS4hU+29wurnN1u8PN6NnZUi7AkXKoNs8GgibxEN78VtdUMY6ZV
 /dwzDfCMLXHp0lIkhvmMlgfIml5aMB263WF6lQnyPyKrXvmR+SHg==
X-Google-Smtp-Source: AGHT+IHl9KmcEjZOcK7jfaBox1LsJWYQ4nEbJ4BnB7b3q0XcM4Q0t3HfuAOsBJEvTIaUUUZscho9wg==
X-Received: by 2002:a17:906:478f:b0:b3d:200a:bd6e with SMTP id
 a640c23a62f3a-b84453ee74bmr755692166b.47.1767921487933; 
 Thu, 08 Jan 2026 17:18:07 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a27cac3sm954886566b.20.2026.01.08.17.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 17:18:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 5/9] net/pcap: support nanosecond timestamp precision
Date: Thu,  8 Jan 2026 17:16:22 -0800
Message-ID: <20260109011755.362857-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109011755.362857-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260109011755.362857-1-stephen@networkplumber.org>
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
 drivers/net/pcap/pcap_ethdev.c | 142 +++++++++++++++++++++++++--------
 1 file changed, 109 insertions(+), 33 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index a27a132002..25e78f1e3a 100644
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
 
@@ -514,22 +529,57 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
  * pcap_open_live wrapper function
  */
 static inline int
-open_iface_live(const char *iface, pcap_t **pcap) {
-	*pcap = pcap_open_live(iface, RTE_ETH_PCAP_SNAPLEN,
-			RTE_ETH_PCAP_PROMISC, RTE_ETH_PCAP_TIMEOUT, errbuf);
+open_iface_live(const char *iface, pcap_t **pcap)
+{
+	pcap_t *pc = pcap_create(iface, errbuf);
+	if (pc == NULL) {
+		PMD_LOG(ERR, "Couldn't create %s: %s", iface, errbuf);
+		goto error;
+	}
 
-	if (*pcap == NULL) {
-		PMD_LOG(ERR, "Couldn't open %s: %s", iface, errbuf);
-		return -1;
+	int status = pcap_set_tstamp_precision(pc, PCAP_TSTAMP_PRECISION_NANO);
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
+	if (pc)
+		pcap_close(pc);
+	return -1;
 }
 
 static int
@@ -576,7 +626,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
-	*pcap = pcap_open_offline(pcap_filename, errbuf);
+	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
+							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
 		PMD_LOG(ERR, "Couldn't open %s: %s", pcap_filename,
 			errbuf);
@@ -613,6 +664,15 @@ eth_dev_start(struct rte_eth_dev *dev)
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
@@ -728,8 +788,13 @@ eth_dev_stop(struct rte_eth_dev *dev)
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
 
@@ -749,6 +814,7 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_mtu = RTE_ETH_PCAP_SNAPLEN;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
+	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_TIMESTAMP;
 
 	return 0;
 }
@@ -896,6 +962,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	pcap_q->port_id = dev->data->port_id;
 	pcap_q->queue_id = rx_queue_id;
 	dev->data->rx_queues[rx_queue_id] = pcap_q;
+	pcap_q->timestamp_offloading = internals->timestamp_offloading;
 
 	if (internals->infinite_rx) {
 		struct pmd_process_private *pp;
@@ -1017,6 +1084,16 @@ eth_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
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
 
 static const struct eth_dev_ops ops = {
 	.dev_start = eth_dev_start,
@@ -1034,6 +1111,7 @@ static const struct eth_dev_ops ops = {
 	.mtu_set = eth_mtu_set,
 	.stats_get = eth_stats_get,
 	.stats_reset = eth_stats_reset,
+	.read_clock = eth_rx_clock,
 };
 
 static int
@@ -1434,15 +1512,13 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
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

