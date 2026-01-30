Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F18E6BF31
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 17:36:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD2C5406B8;
	Fri, 30 Jan 2026 18:35:27 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 9F2A240655
 for <dev@dpdk.org>; Fri, 30 Jan 2026 18:35:18 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-480142406b3so18204585e9.1
 for <dev@dpdk.org>; Fri, 30 Jan 2026 09:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769794518;
 x=1770399318; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0QisYXEnWlfMJY5zbInCw9rwciXwDHwbzq0/FjUtsd8=;
 b=EF7Eq/QQlrPmnL7O5HpMGOy1/u2t9uskmoRXOqHHPQRSYi/Tscn1pZFEBteqhL8FKM
 Mt4FTrSPtRepJg1TL5gjj6oxoMD43SApbKZM9J3efb9ESJRXNfgVZThJBravHE+BIqqV
 JbMFrr4Gp6Y5ztoL8mbAc67oeF+T8DuhFbDTn2H8Tl3kkC1yKqwvqgWVlcQfz3xeTH7j
 Z1bFsrwaUCrQHOuMgZdKafN10tgsA1s1S5jDfXz32831Def8b9g2owaSV6TsqLM+JTIN
 tKGHiuYs6mX2B7BPd1Fc1a7qcFn5stdDLJFzTqDSlPOtpnCA8UDLLAQTZV8rKYTEgqW7
 cgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769794518; x=1770399318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0QisYXEnWlfMJY5zbInCw9rwciXwDHwbzq0/FjUtsd8=;
 b=fEAS+q+GIDo+w6/IxUo8GqeLxITsTW2oRAwGsvNv+eRoveiCc7f1QeF0kO+9XlmPKG
 +nxL0iRZYeUammKuNgwDrB3U6XAhZPEWFCrzpfcN/pGF5qxJV9JzcMymtmr/vE8+Rcwz
 4J8/wPUbB4kYoWuARiLL9hSGriawgO394BSDb7Rzbbj5LsCJPWJL6YwZOPXKeIdnB4/J
 GfWt3YC68AvF2lI5DgSZBzvK26/buL+AaS6Lpf3TyjUnt+II9ECXrT5MV3B+R1AtTO8k
 NDLT9rM6F74ahbbnZt+kk9REMp9V4ib21JlN9GP5OUWSssdeJ+qgKujM/seds8Ey7hhT
 AMUQ==
X-Gm-Message-State: AOJu0YzC1RjUKvuQI5B7qt9OGvotBgc7UyQ/suS4qltr9mnbJwMXTlOw
 WN9x/zIbY6Z42MnHNcO2clm0b4I+T+8qz3JJ2I2el83FzWYkoEnMmb1493v6eOTRdC1NzlnZERq
 5GclZ
X-Gm-Gg: AZuq6aLKfkWHtWwsrJnPV9UVgI8sm84oGCuFVmTW/VQwi87a4WeM0ElqFrR4YSQyeYL
 pcM/ieDN2yHtB3iAirWjhIgps65jU68OKTcm3cK0Yt+GMKgUO906yyrt1uaOMtyZC7qgN8Nk1P5
 1xHD3jTURi18//dekPidz8x76VGVQHxLEwLGXNjf5PfkdsYIwGgRmLYcqeHXsxog5p7oQdmfvlL
 UWuBNH0t5OBJ/tL7xMmpN8TYgl5BvYBZfqKqZFy/TC8wD/LjfRvD3kwRLghgka+tTzeLyrIwJVz
 VZMkRI6j6HOYBUXWRSu6s69muSdml6sQnwwCi744pYSPISWBbzOos7dTnZwgbjJ67EnmV2CuVoW
 Uqkn/CKa4WWJkF1ityah+MUmTCmAauO7nxeMjLIxTUJp9in+xbKb+XIETewQGq8tZ5J0vBVz6E6
 3xPPS98VuIdN5i4lkFgKIHZxfncDKnvewMGFHYKtaJICeYf1Pp/A4hlSvY7o1n
X-Received: by 2002:a05:600c:3f0a:b0:477:a21c:2066 with SMTP id
 5b1f17b1804b1-482db447c57mr42557995e9.5.1769794518115; 
 Fri, 30 Jan 2026 09:35:18 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm201085325e9.12.2026.01.30.09.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 09:35:17 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v11 13/19] net/pcap: support nanosecond timestamp precision
Date: Fri, 30 Jan 2026 09:33:26 -0800
Message-ID: <20260130173447.14546-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130173447.14546-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130173447.14546-1-stephen@networkplumber.org>
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
 doc/guides/nics/pcap_ring.rst          |   3 +
 doc/guides/rel_notes/release_26_03.rst |   2 +
 drivers/net/pcap/pcap_ethdev.c         | 145 +++++++++++++++++++------
 3 files changed, 114 insertions(+), 36 deletions(-)

diff --git a/doc/guides/nics/pcap_ring.rst b/doc/guides/nics/pcap_ring.rst
index c005786ce3..5b9ca71b18 100644
--- a/doc/guides/nics/pcap_ring.rst
+++ b/doc/guides/nics/pcap_ring.rst
@@ -224,6 +224,9 @@ Features and Limitations
    ``RTE_ETH_TX_OFFLOAD_VLAN_INSERT`` is enabled and the mbuf has ``RTE_MBUF_F_TX_VLAN``
    set.
 
+*  The PMD will insert the pcap header packet timestamp with nanoseconds resolution and
+   UNIX origin, i.e. time since 1-JAN-1970 UTC, if ``RTE_ETH_RX_OFFLOAD_TIMESTAMP`` is enabled.
+
 
 Rings-based PMD
 ~~~~~~~~~~~~~~~
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 0264968567..50ba8bf109 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -59,6 +59,8 @@ New Features
 
   * Added support for VLAN insertion and stripping.
   * Added support for reporting link state and speed in ``iface`` mode.
+  * Receive timestamp offload is only done if offload flag set.
+  * Receive timestamps support nanosecond precision.
 
 
 Removed Items
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 917a8eee36..90bedb6286 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -28,13 +28,11 @@
 #include <rte_mbuf_dyn.h>
 #include <bus_vdev_driver.h>
 #include <rte_os_shim.h>
+#include <rte_time.h>
 
 #include "pcap_osdep.h"
 
 #define RTE_ETH_PCAP_SNAPSHOT_LEN 65535
-#define RTE_ETH_PCAP_SNAPLEN RTE_ETHER_MAX_JUMBO_FRAME_LEN
-#define RTE_ETH_PCAP_PROMISC 1
-#define RTE_ETH_PCAP_TIMEOUT -1
 
 #define ETH_PCAP_RX_PCAP_ARG  "rx_pcap"
 #define ETH_PCAP_TX_PCAP_ARG  "tx_pcap"
@@ -78,6 +76,7 @@ struct pcap_rx_queue {
 	uint16_t port_id;
 	uint16_t queue_id;
 	bool vlan_strip;
+	bool timestamp_offloading;
 	struct rte_mempool *mb_pool;
 	struct queue_stat rx_stat;
 	struct queue_missed_stat missed_stat;
@@ -109,6 +108,7 @@ struct pmd_internals {
 	bool phy_mac;
 	bool infinite_rx;
 	bool vlan_strip;
+	bool timestamp_offloading;
 };
 
 struct pmd_process_private {
@@ -336,10 +336,21 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		if (pcap_q->vlan_strip)
 			rte_vlan_strip(mbuf);
 
-		uint64_t us = (uint64_t)header->ts.tv_sec * US_PER_S + header->ts.tv_usec;
+		if (pcap_q->timestamp_offloading) {
+			/*
+			 * The use of tv_usec as nanoseconds is not a bug here.
+			 * Interface is always created with nanosecond precision, and
+			 * that is how pcap API bodged in nanoseconds support.
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
@@ -359,14 +370,19 @@ eth_null_rx(void *queue __rte_unused,
 	return 0;
 }
 
-#define NSEC_PER_SEC	1000000000L
-
 /*
- * This function stores nanoseconds in `tv_usec` field of `struct timeval`,
- * because `ts` goes directly to nanosecond-precision dump.
+ * Calculate current timestamp in nanoseconds by computing
+ * offset from starting time value.
+ *
+ * Note: it is not a bug that this code is putting nanosecond
+ * value into microsecond timeval field. The pcap API is old
+ * and nanoseconds were bodged on as an after thought.
+ * As long as the pcap stream is set to nanosecond precision
+ * it expects nanoseconds here.
  */
 static inline void
-calculate_timestamp(struct timeval *ts) {
+calculate_timestamp(struct timeval *ts)
+{
 	uint64_t cycles;
 	struct timespec cur_time;
 
@@ -404,8 +420,10 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	if (dumper == NULL || nb_pkts == 0)
 		return 0;
 
-	/* writes the nb_pkts packets to the previously opened pcap file
-	 * dumper */
+	/* all packets in burst have same timestamp */
+	calculate_timestamp(&header.ts);
+
+	/* writes the nb_pkts packets to the previously opened pcap file dumper */
 	for (i = 0; i < nb_pkts; i++) {
 		struct rte_mbuf *mbuf = bufs[i];
 		uint32_t len, caplen;
@@ -418,9 +436,6 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		}
 
 		len = caplen = rte_pktmbuf_pkt_len(mbuf);
-
-		calculate_timestamp(&header.ts);
-
 		header.len = len;
 		header.caplen = caplen;
 
@@ -519,22 +534,62 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
+	if (status != 0) {
+		PMD_LOG(ERR, "%s: Could not set to ns precision: %s",
+			iface, pcap_statustostr(status));
+		goto error;
+	}
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
@@ -581,7 +636,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
-	*pcap = pcap_open_offline(pcap_filename, errbuf);
+	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
+							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
 		PMD_LOG(ERR, "Couldn't open %s: %s", pcap_filename,
 			errbuf);
@@ -740,6 +796,7 @@ eth_dev_configure(struct rte_eth_dev *dev)
 	const struct rte_eth_rxmode *rxmode = &dev_conf->rxmode;
 
 	internals->vlan_strip = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP);
+	internals->timestamp_offloading = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP);
 	return 0;
 }
 
@@ -757,7 +814,8 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->min_rx_bufsize = 0;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
-	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
+	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
+		RTE_ETH_RX_OFFLOAD_TIMESTAMP;
 
 	return 0;
 }
@@ -979,6 +1037,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	pcap_q->queue_id = rx_queue_id;
 	pcap_q->vlan_strip = internals->vlan_strip;
 	dev->data->rx_queues[rx_queue_id] = pcap_q;
+	pcap_q->timestamp_offloading = internals->timestamp_offloading;
 
 	if (internals->infinite_rx) {
 		struct pmd_process_private *pp;
@@ -1104,12 +1163,24 @@ eth_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
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
 	.tx_queue_release = eth_tx_queue_release,
@@ -1524,15 +1595,17 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
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
+		ret = rte_mbuf_dyn_rx_timestamp_register(&timestamp_dynfield_offset,
+							 &timestamp_rx_dynflag);
+		if (ret != 0) {
+			PMD_LOG(ERR, "Failed to register Rx timestamp field/flag");
+			return ret;
+		}
+		timespec_get(&start_time, TIME_UTC);
+		start_cycles = rte_get_timer_cycles();
+		hz = rte_get_timer_hz();
 	}
 
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
-- 
2.51.0

