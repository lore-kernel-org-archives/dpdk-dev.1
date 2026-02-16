Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0457AE83822
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 18:15:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DB7C40A7A;
	Mon, 16 Feb 2026 19:14:34 +0100 (CET)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 7D44340A4B
 for <dev@dpdk.org>; Mon, 16 Feb 2026 19:14:31 +0100 (CET)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4359a316d89so3053542f8f.0
 for <dev@dpdk.org>; Mon, 16 Feb 2026 10:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771265671;
 x=1771870471; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n2aYInTEKDwFNE+Nxaln0ewGYEsL/uJ+YBkv1Poo7b4=;
 b=MejRa+dgR/WFr0w2udkf7FSJwrPRmY4tH3VrC/Te6s8aA3xVMFZ0Tjyk8Po3GZ0S+1
 qZOAzS9Og7bBsRvb3saMH+/ElPtIfyAZ7VD7CP1PUhAy46Dj96QxBSaCFLr0ued9cHbt
 GTu5U47BUj+xKrD+Yt9W2BHAu3yY2+kFxP4wagaln8y9CVN3tc7J9cNwmowrU1r2qEpY
 0YUYHvVCLBQ+SmnXrQou4Kov3PEkXkTVBd5DRRDfwr3Lu/Y7NAx6Y3b4mjFnXvr28w3z
 BL8/Tu5QG1x8QKEY/gx/SGy1TsF2Q5gRrrPzbYB1na0CgiCo5Z/CXOgnXf+v3lAQS50l
 YHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771265671; x=1771870471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n2aYInTEKDwFNE+Nxaln0ewGYEsL/uJ+YBkv1Poo7b4=;
 b=pTizQ924A5HPxZ/6yBi9b2xjguNs7mJAUyeQq4XS3ZL8CnuRDV1r4iEiTB7aLp83OI
 Dy7HKQGqC+3yc/w7YmMlwGUUGsybMxoqFZoeU+2bwiVlS/bAYpW1i0YAdmaYWowo0BfT
 aQ1NlKa9e5kSVgc8LXSaG3yNoDei+JcQXQK+WrnZYqTHSM0wDQEn9Un+PQEd9gizkq4W
 MvO7OgKV/dxWiFKMvpuVXrTuGgqwUAgPexaSBR0iDMGek7omwub6846U6FmcerYVGZcI
 Nu9T46AjUXac6Z+tgYI5910gGF2t7HsMhX8EqJ/+PPgOY9NEkv+JEwUzjCOAndDhv3Ru
 N9DA==
X-Gm-Message-State: AOJu0YzWcUsmCvxV+ibUhxSU/9Z1n205Af+Sce3fPoM3cHUasielpWjV
 3CQznyjLSjDxABP0HVitg6q3eXOJpBZijbiMwSkG3G8A0x+u+YVXRCnz17bIxmM70n0hbc+u80k
 Jq0IHnzI=
X-Gm-Gg: AZuq6aJPzI+/l/LrAwoRUXsHneR+gPYKvqfyjz7APXKINnxgbNFOK2XRERcNxvLSSbZ
 0mdiOYSGXJPkHisl7lcAWo2V/PgppWDY8jbSnL/z69zMPy7MIASKEaZMCVeLQayttP8LmOPq7xn
 Ypsf+y97VPbBadmH5/WAdUrI1lDgSGhq5KZvLCOiqNZDuBSMPlPl8eyeWXE6kym4CulclnY7JQM
 OWuqdNilmXA2rmCnfuwlxPwOLbVb19SkBm8uthhCSZnqQ+HWt2Z/3Iw3vhpJorUl3Y/oLorHS6Y
 9Y0FMMub5iIGBC3ocov9TwftUCvzqHyv7dvLIrucnotI33utMAfkJVln2GJvnNt418B2VbD9B/W
 Dpev3QutoHltRb3F4SN+xNKWA6vxnmui/it3NjkZTp29j+gqNp1nhnylhKg7RjNlPlmMqeUkJVT
 XDaxqDiTGqZPMbgUBHrxFzqjdb9kP4i5G8mCDHCh9VnRErh3Lr1fUkw2DjvSybOw==
X-Received: by 2002:a05:6000:40cd:b0:437:6806:994f with SMTP id
 ffacd0b85a97d-437978c75ecmr19724785f8f.12.1771265670931; 
 Mon, 16 Feb 2026 10:14:30 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796acffcesm26064725f8f.37.2026.02.16.10.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 10:14:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v16 13/21] net/pcap: support nanosecond timestamp precision
Date: Mon, 16 Feb 2026 10:12:08 -0800
Message-ID: <20260216181407.428877-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216181407.428877-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260216181407.428877-1-stephen@networkplumber.org>
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
* Add read_clock dev_op returning current UTC time for timestamp
  correlation.
* Move per-burst timestamp calculation outside the packet loop in
  tx_dumper.
* Enable immediate mode and improve error reporting
  in live capture setup.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/pcap.rst               |   3 +
 doc/guides/rel_notes/release_26_03.rst |   2 +
 drivers/net/pcap/pcap_ethdev.c         | 157 +++++++++++++++++++------
 3 files changed, 127 insertions(+), 35 deletions(-)

diff --git a/doc/guides/nics/pcap.rst b/doc/guides/nics/pcap.rst
index bed5006a42..2709c6d017 100644
--- a/doc/guides/nics/pcap.rst
+++ b/doc/guides/nics/pcap.rst
@@ -258,3 +258,6 @@ Features and Limitations
 *  The PMD will transparently insert a VLAN tag to transmitted packets if
    ``RTE_ETH_TX_OFFLOAD_VLAN_INSERT`` is enabled and the mbuf has ``RTE_MBUF_F_TX_VLAN``
    set.
+
+*  The PMD will insert the pcap header packet timestamp with nanoseconds resolution and
+   UNIX origin, i.e. time since 1-JAN-1970 UTC, if ``RTE_ETH_RX_OFFLOAD_TIMESTAMP`` is enabled.
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 6a09eb1048..2cdc304539 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -96,6 +96,8 @@ New Features
 
   * Added support for VLAN insertion and stripping.
   * Added support for reporting link state and speed in ``iface`` mode.
+  * Receive timestamp offload is only done if offload flag set.
+  * Receive timestamps support nanosecond precision.
 
 
 Removed Items
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index f3069968c3..79a8c63b72 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -27,13 +27,11 @@
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
@@ -77,6 +75,7 @@ struct pcap_rx_queue {
 	uint16_t port_id;
 	uint16_t queue_id;
 	bool vlan_strip;
+	bool timestamp_offloading;
 	struct rte_mempool *mb_pool;
 	struct queue_stat rx_stat;
 	struct queue_missed_stat missed_stat;
@@ -108,6 +107,7 @@ struct pmd_internals {
 	bool phy_mac;
 	bool infinite_rx;
 	bool vlan_strip;
+	bool timestamp_offloading;
 };
 
 struct pmd_process_private {
@@ -269,6 +269,15 @@ eth_pcap_rx_infinite(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		if (pcap_q->vlan_strip)
 			rte_vlan_strip(bufs[i]);
 
+		if (pcap_q->timestamp_offloading) {
+			struct timespec ts;
+
+			timespec_get(&ts, TIME_UTC);
+			*RTE_MBUF_DYNFIELD(bufs[i], timestamp_dynfield_offset,
+					   rte_mbuf_timestamp_t *) = rte_timespec_to_ns(&ts);
+			bufs[i]->ol_flags |= timestamp_rx_dynflag;
+		}
+
 		rx_bytes += bufs[i]->data_len;
 
 		/* Enqueue packet back on ring to allow infinite rx. */
@@ -339,10 +348,21 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
@@ -362,14 +382,19 @@ eth_null_rx(void *queue __rte_unused,
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
 
@@ -458,8 +483,10 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	if (dumper == NULL || nb_pkts == 0)
 		return 0;
 
-	/* writes the nb_pkts packets to the previously opened pcap file
-	 * dumper */
+	/* all packets in burst have same timestamp */
+	calculate_timestamp(&header.ts);
+
+	/* writes the nb_pkts packets to the previously opened pcap file dumper */
 	for (i = 0; i < nb_pkts; i++) {
 		uint32_t len, caplen;
 		const uint8_t *data;
@@ -469,9 +496,6 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 		struct rte_mbuf *mbuf = bufs[i];
 		len = caplen = rte_pktmbuf_pkt_len(mbuf);
-
-		calculate_timestamp(&header.ts);
-
 		header.len = len;
 		header.caplen = caplen;
 
@@ -600,22 +624,62 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
@@ -662,7 +726,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
-	*pcap = pcap_open_offline(pcap_filename, errbuf);
+	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
+							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
 		PMD_LOG(ERR, "Couldn't open %s: %s", pcap_filename,
 			errbuf);
@@ -821,6 +886,7 @@ eth_dev_configure(struct rte_eth_dev *dev)
 	const struct rte_eth_rxmode *rxmode = &dev_conf->rxmode;
 
 	internals->vlan_strip = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP);
+	internals->timestamp_offloading = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP);
 	return 0;
 }
 
@@ -838,7 +904,8 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->min_rx_bufsize = 0;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
-	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
+	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
+		RTE_ETH_RX_OFFLOAD_TIMESTAMP;
 
 	return 0;
 }
@@ -1060,6 +1127,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	pcap_q->queue_id = rx_queue_id;
 	pcap_q->vlan_strip = internals->vlan_strip;
 	dev->data->rx_queues[rx_queue_id] = pcap_q;
+	pcap_q->timestamp_offloading = internals->timestamp_offloading;
 
 	if (internals->infinite_rx) {
 		struct pmd_process_private *pp;
@@ -1198,6 +1266,17 @@ eth_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
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
 static int
 eth_vlan_offload_set(struct rte_eth_dev *dev, int mask)
 {
@@ -1224,6 +1303,7 @@ static const struct eth_dev_ops ops = {
 	.dev_close = eth_dev_close,
 	.dev_configure = eth_dev_configure,
 	.dev_infos_get = eth_dev_info,
+	.read_clock = eth_dev_read_clock,
 	.rx_queue_setup = eth_rx_queue_setup,
 	.tx_queue_setup = eth_tx_queue_setup,
 	.tx_queue_release = eth_tx_queue_release,
@@ -1639,15 +1719,22 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 	name = rte_vdev_device_name(dev);
 	PMD_LOG(INFO, "Initializing pmd_pcap for %s", name);
 
-	timespec_get(&start_time, TIME_UTC);
-	start_cycles = rte_get_timer_cycles();
-	hz = rte_get_timer_hz();
+	/* Record info for timestamps on first probe */
+	if (hz == 0) {
+		hz = rte_get_timer_hz();
+		if (hz == 0) {
+			PMD_LOG(ERR, "Reported hz is zero!");
+			return -1;
+		}
 
-	ret = rte_mbuf_dyn_rx_timestamp_register(&timestamp_dynfield_offset,
-			&timestamp_rx_dynflag);
-	if (ret != 0) {
-		PMD_LOG(ERR, "Failed to register Rx timestamp field/flag");
-		return -1;
+		ret = rte_mbuf_dyn_rx_timestamp_register(&timestamp_dynfield_offset,
+							 &timestamp_rx_dynflag);
+		if (ret != 0) {
+			PMD_LOG(ERR, "Failed to register Rx timestamp field/flag");
+			return ret;
+		}
+		timespec_get(&start_time, TIME_UTC);
+		start_cycles = rte_get_timer_cycles();
 	}
 
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
-- 
2.51.0

